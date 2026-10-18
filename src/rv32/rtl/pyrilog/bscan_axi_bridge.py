"""BSCANE2 ⇆ AXI4-Lite 桥 —— 用公开原语替换闭源的 JTAG-to-AXI Master IP。

（规范例外：本模块横跨 drck / update / clk 三个时钟域，`def cycle` 是单时钟
约定，表达不了 —— 保留装饰器层 `@always(<clk>)` 写法。）

7 系列的 `BSCANE2` 原语（UG470/UG953，公开文档）把 JTAG 的一条用户链
（USER1，IR 操作码 6'b000010）引进 fabric：SEL/CAPTURE/SHIFT/UPDATE 状态、
DRCK（Capture-DR/Shift-DR 期间的门控 TCK）、TDI 进 / TDO 出。本模块在
USER1 链上定义一个 66 位的帧协议，把 DR 扫描翻译成 AXI4-Lite 读写 ——
两端（FPGA 侧 + 主机 Python 侧 pyjtag/bscan.py）都是自己的代码，
没有协议黑盒。

## 单笔帧（DR 长 66 位，LSB 先入先出）

移入（主机 → FPGA），Update-DR 时生效：

    bit[1:0]   CMD    00=NOP（只轮询，不发事务） 01=READ 10=WRITE 11=BURST
    bit[33:2]  ADDR   32 位字节地址
    bit[65:34] WDATA  32 位写数据（READ/NOP 时忽略）

移出（FPGA → 主机），Capture-DR 时装载：

    bit[0]     DONE   上一笔事务已完成（req/ack 切换位相等）
    bit[1]     ERR    上一笔事务的 resp[1]（SLVERR/DECERR 粘一次）
    bit[33:2]  RDATA  上一笔 READ 的数据
    bit[65:34] 0

主机流程：先移入一帧 {READ/WRITE, addr, wdata}（Update 锁存并触发事务），
再移入 NOP 帧轮询，直到移出的 DONE=1，同帧的 RDATA/ERR 即结果。板上实测
DONE 要到命令帧的**下下帧**才可靠 —— 它是 req/ack 切换位经两级同步器进 DRCK
域的，而 DRCK 只在 Capture/Shift 期间有脉冲，一帧给不够同步沿。

## burst（CMD=11）：读写共用一个头，bit[50] 定方向

单笔帧一次只搬 32 位数据却要移 66 位，读方向还要垫一帧取结果（32/142），
协议效率分别只有 45% 和 23%。burst 把地址和长度只发一次，之后是纯数据流，
两个方向都做到 32/32：

    帧 1（66 位，与单笔同格式）：
        bit[1:0]   = 11
        bit[33:2]  = 起始地址
        bit[49:34] = 字数 N
        bit[50]    = 方向：0=写，1=读
    帧 2（数据帧）：
        写：SYNC(32 位) + N×32 位数据，LSB 先入，不采 TDO
        读：N×32 位数据移出，LSB 先出

### 写方向的同步字

数据帧开头那 32 位同步字（`SYNC`）不是冗余：**BSCANE2 的门控信号在高 TCK
档位下相对 TCK 偏移一拍**，板上实测 12 MHz 档整条数据流会提前一位（首字丢一
位、其余整体错位一位，中间段错法完全一致，说明是固定偏移而非随机丢位）。
桥在数据帧开头逐位滑动比对，直到移位寄存器等于 SYNC 才开始按 32 位分组，
因此对任何位对齐误差免疫，主机侧不必知道当前档位偏移几位。

同步字只在帧首找一次，找到即关闭，数据里再出现同样的值不会误触发。若始终
匹配不上（偏移大到离谱），整帧一个字都不写 —— 宁可整段不落地，也不写错。

### 读方向的预取

JTAG 没有反压，读数据必须在移出之前就备好。aclk 域自主预取：burst 头触发
第一笔 AXI 读，DRCK 域每取走一个字就翻一次 `rcons`，aclk 域据此发起下一笔。
32 个 DRCK（6 MHz 采样档约 27 µs）对一笔 AXI-Lite 读（约 0.2 µs）绰绰有余。

读 burst 的头会翻 `req_tgl`，最后一笔预取回来时翻 `ack_tgl` 还上 —— 否则
DONE 会永久停在 0，之后所有单笔操作都误判成没完成。

### 写方向的溢出

同样因为没有反压，写 burst 的正确性依赖「AXI 侧比 JTAG 侧快」：32 个 DRCK 在
12 MHz 下是 2.67 µs，而 AXI-Lite 一笔约 0.2 µs，快十倍以上。真被拖住时
`bov`（burst overflow）置位，下一帧的 ERR 位会带出来。

## 跨时钟域

三个时钟域，全部标准手法：

* **DRCK 域**（移位寄存器 sr / wsr / rsr）：CAPTURE 装载 / SHIFT 移位。
* **UPDATE 域**（请求锁存）：UPDATE 上升沿锁 cmd/addr/wdata，CMD≠0 时翻转
  req_tgl。UPDATE 与 DRCK 同源于 TCK、时序上互斥，不存在亚稳。
* **aclk 域**（AXI master FSM）：req_tgl / wtgl / rcons 各自两级同步取边沿；
  addr/wdata/b_len 是「先稳数据、后翻切换位」的握手跨域（主机在 ack 前不会
  再发帧，数据保稳）。事务收到 B/R 响应即翻转 ack_tgl 回礼。DONE =
  req_tgl==ack_tgl，在 DRCK 域经两级同步后于 CAPTURE 采样。

⚠ DRCK 与 UPDATE 都是 BSCANE2 门控出来的时钟，Vivado 不会自动为它们建时钟
约束（只报 no_clock）。约束写在 jtag_axi_sram.xdc 里，改动本模块后别忘了
那边的周期值要跟得上最高 TCK 档位。

顶层接线见 board/<板>/top.v（k480t 是 board/k480t/top.v；BSCANE2 原语实例化在那边，本模块只看拉出来的信号）。
"""

from pyrilog.ir import Module, Input, Output, Logic
from pyrilog.hdl import comb, always, bits, concat, mux


class BscanAxiBridge(Module):
    """USER1 链 66 位帧 → AXI4-Lite master；单笔未完成，toggle 握手跨域。"""

    # 写 burst 数据帧的同步字。选值只要「不容易在错位后仍自匹配」即可：
    # 0xA5A55A5A 的位模式无周期性自相关，滑动比对不会提前命中。
    SYNC = 0xA5A55A5A

    # ── BSCANE2 拉出来的 JTAG 用户链信号 ──
    drck    = Input(1)   # Capture-DR/Shift-DR 期间的门控 TCK
    sel     = Input(1)   # USER1 链被 IR 选中
    shift   = Input(1)   # Shift-DR 状态
    capture = Input(1)   # Capture-DR 状态
    update  = Input(1)   # Update-DR（当时钟用，上升沿锁存）
    tdi     = Input(1)
    tdo     = Output(1)

    # ── fabric 侧 ──
    clk   = Input(1)     # aclk（50 MHz），AXI 域
    rst_n = Input(1)

    # AXI4-Lite master 口（与 AxiLiteSram 的 slave 口一一对应）
    m_awaddr  = Output(32)
    m_awvalid = Output(1)
    m_awready = Input(1)
    m_wdata   = Output(32)
    m_wstrb   = Output(4)
    m_wvalid  = Output(1)
    m_wready  = Input(1)
    m_bresp   = Input(2)
    m_bvalid  = Input(1)
    m_bready  = Output(1)
    m_araddr  = Output(32)
    m_arvalid = Output(1)
    m_arready = Input(1)
    m_rdata   = Input(32)
    m_rresp   = Input(2)
    m_rvalid  = Input(1)
    m_rready  = Output(1)

    # ── DRCK 域 ──
    sr     = Logic(66)   # DR 移位寄存器（单笔帧 / burst 头）
    ack_s1 = Logic(1)    # ack_tgl → DRCK 域两级同步
    ack_s2 = Logic(1)
    bn     = Logic(16)   # burst 剩余字数，非 0 即处在数据帧中
    bbit   = Logic(5)    # 数据帧内的位计数 0..31
    wsr    = Logic(32)   # burst 写数据移位寄存器（兼作同步字滑动比对）
    wtgl   = Logic(1)    # 每满 32 位翻转一次，通知 aclk 域取走 wsr
    wadr   = Logic(32)   # 该字的目标地址，与 wsr 一同在 wtgl 翻转前稳定
    bsync  = Logic(1)    # 写数据帧：还在找同步字
    rsr    = Logic(32)   # burst 读数据移位寄存器
    rcons  = Logic(1)    # 每取走一个预取字翻转一次，催 aclk 域读下一个

    # ── UPDATE 域 ──
    b_addr    = Logic(32)  # burst 起始地址（Update 锁存后整段不变）
    b_len     = Logic(16)  # burst 字数；非 0 表示下一帧是数据帧
    b_rd      = Logic(1)   # burst 方向：1=读
    req_cmd   = Logic(2)
    req_addr  = Logic(32)
    req_wdata = Logic(32)
    req_tgl   = Logic(1)

    # ── aclk 域 ──
    req_s1 = Logic(1)
    req_s2 = Logic(1)
    req_s3 = Logic(1)
    ack_tgl   = Logic(1)
    awvalid_q = Logic(1)
    wvalid_q  = Logic(1)
    arvalid_q = Logic(1)
    rdata_q   = Logic(32)
    err_q     = Logic(1)
    wtgl_s1 = Logic(1)
    wtgl_s2 = Logic(1)
    wtgl_s3 = Logic(1)
    b_busy    = Logic(1)   # 本笔 burst 写还没收到 B 响应
    bov       = Logic(1)   # burst 溢出：上一笔还没做完又来一个字
    rcons_s1 = Logic(1)
    rcons_s2 = Logic(1)
    rcons_s3 = Logic(1)
    rb_addr   = Logic(32)  # 下一笔预取地址
    rb_left   = Logic(16)  # 还要预取几个字；非 0 即处在 burst 读中
    rpf_data  = Logic(32)  # 预取好的字，等 DRCK 域来取

    @comb
    def hookup(self):
        # 读 burst 的数据帧走 rsr，其余一律走 sr
        self.tdo       = mux(self.b_rd & (self.bn != 0), self.rsr[0], self.sr[0])
        self.m_awaddr  = mux(self.b_busy, self.wadr, self.req_addr)
        self.m_awvalid = self.awvalid_q
        self.m_wdata   = mux(self.b_busy, self.wsr, self.req_wdata)
        self.m_wstrb   = 15          # 恒整字写
        self.m_wvalid  = self.wvalid_q
        self.m_bready  = 1           # 响应即收
        self.m_araddr  = mux(self.rb_left != 0, self.rb_addr, self.req_addr)
        self.m_arvalid = self.arvalid_q
        self.m_rready  = 1

    @always(drck)
    def dr_shift(self):
        # ack 切换位同步进 DRCK 域（只在 DR 扫描期间打拍，够用：主机总是
        # 用下一帧轮询，本帧移位的 66 个沿早已把它同步过来）。
        self.ack_s1 = self.ack_tgl
        self.ack_s2 = self.ack_s1
        if self.sel & self.capture:
            done = ~(self.req_tgl ^ self.ack_s2)
            self.sr = concat(bits(0, 32), self.rdata_q, self.err_q, done)
            # 上一帧若锁存了 burst 参数，本帧就是数据帧：装入字数、位计数归零
            self.bn = self.b_len
            self.bbit = 0
            if self.b_rd:
                # 读：第一个字已由 aclk 域预取好，直接装载并催下一个
                self.rsr = self.rpf_data
                self.rcons = ~self.rcons
                self.bsync = 0
            else:
                # 写：数据帧开头要先滑动比对出同步字
                self.bsync = self.b_len != 0
        elif self.sel & self.shift:
            if self.bn != 0:
                if self.b_rd:
                    # 读 burst 数据帧：32 位一组移出，满组换下一个预取字
                    if self.bbit == 31:
                        self.rsr = self.rpf_data
                        self.rcons = ~self.rcons
                        self.bbit = 0
                        self.bn = self.bn - 1
                    else:
                        self.rsr = concat(bits(0, 1), self.rsr[31:1])
                        self.bbit = self.bbit + 1
                elif self.bsync:
                    # 逐位滑动，直到移位寄存器等于同步字才开始收数据
                    wnext = concat(self.tdi, self.wsr[31:1])
                    self.wsr = wnext
                    if wnext == self.SYNC:
                        self.bsync = 0
                        self.bbit = 0
                else:
                    # 写 burst 数据帧：攒满 32 位就把地址算好、翻切换位交给 aclk 域
                    self.wsr = concat(self.tdi, self.wsr[31:1])
                    if self.bbit == 31:
                        self.bbit = 0
                        self.wadr = self.b_addr + ((self.b_len - self.bn) << 2)
                        self.wtgl = ~self.wtgl
                        self.bn = self.bn - 1
                    else:
                        self.bbit = self.bbit + 1
            else:
                self.sr = concat(self.tdi, self.sr[65:1])

    @always(update)
    def dr_update(self):
        if self.sel:
            if self.b_len != 0:
                # 刚移完的是 burst 数据帧，清掉长度与方向，下一帧回到单笔模式
                self.b_len = 0
                self.b_rd = 0
            elif self.sr[1:0] == 3:
                # burst 头：锁存参数。读方向还要翻 req_tgl 让 aclk 域起预取。
                self.b_addr = self.sr[33:2]
                self.b_len  = self.sr[49:34]
                self.b_rd   = self.sr[50]
                if self.sr[50]:
                    self.req_cmd  = 3
                    self.req_addr = self.sr[33:2]
                    self.req_tgl  = ~self.req_tgl
            else:
                self.req_cmd   = self.sr[1:0]
                self.req_addr  = self.sr[33:2]
                self.req_wdata = self.sr[65:34]
                if self.sr[1:0] != 0:
                    self.req_tgl = ~self.req_tgl

    @always(clk)
    def axi_fsm(self):
        if not self.rst_n:
            self.req_s1    = 0
            self.req_s2    = 0
            self.req_s3    = 0
            self.ack_tgl   = 0
            self.awvalid_q = 0
            self.wvalid_q  = 0
            self.arvalid_q = 0
            self.err_q     = 0
            self.wtgl_s1   = 0
            self.wtgl_s2   = 0
            self.wtgl_s3   = 0
            self.b_busy    = 0
            self.bov       = 0
            self.rcons_s1  = 0
            self.rcons_s2  = 0
            self.rcons_s3  = 0
            self.rb_left   = 0
            return
        self.req_s1 = self.req_tgl
        self.req_s2 = self.req_s1
        self.req_s3 = self.req_s2
        self.wtgl_s1 = self.wtgl
        self.wtgl_s2 = self.wtgl_s1
        self.wtgl_s3 = self.wtgl_s2
        self.rcons_s1 = self.rcons
        self.rcons_s2 = self.rcons_s1
        self.rcons_s3 = self.rcons_s2
        # 写 burst 的每个字：切换位翻一次就发一笔写。JTAG 没有反压，上一笔还没
        # 收到 B 响应就来下一个字只能记 bov，由下一帧的 ERR 带出去。
        if self.wtgl_s2 ^ self.wtgl_s3:
            if self.b_busy:
                self.bov = 1
            else:
                self.awvalid_q = 1
                self.wvalid_q  = 1
                self.b_busy    = 1
        # 新请求边沿：按 CMD 拉起对应通道 valid（req_addr/req_wdata 已稳）。
        if self.req_s2 ^ self.req_s3:
            if self.req_cmd == 3:
                # 读 burst 起步：地址与剩余字数就位，发第一笔预取
                self.rb_addr   = self.req_addr
                self.rb_left   = self.b_len
                self.arvalid_q = 1
            elif self.req_cmd == 2:
                self.awvalid_q = 1
                self.wvalid_q  = 1
            elif self.req_cmd == 1:
                self.arvalid_q = 1
        # DRCK 域取走了一个预取字：补下一笔读
        if self.rcons_s2 ^ self.rcons_s3:
            if self.rb_left != 0:
                self.arvalid_q = 1
        if self.awvalid_q & self.m_awready:
            self.awvalid_q = 0
        if self.wvalid_q & self.m_wready:
            self.wvalid_q = 0
        if self.arvalid_q & self.m_arready:
            self.arvalid_q = 0
        # 响应到达 → 存结果、翻 ack 回礼（单笔未完成，两类响应不会同拍）。
        if self.m_bvalid:
            self.err_q   = self.m_bresp[1] | self.bov
            self.b_busy  = 0
            if not self.b_busy:
                self.ack_tgl = ~self.ack_tgl
        if self.m_rvalid:
            if self.rb_left != 0:
                # burst 预取：交给 DRCK 域，地址前进。最后一笔回来时把 burst
                # 头借走的 req_tgl 还上，否则 DONE 永久停在 0。
                self.rpf_data = self.m_rdata
                self.rb_addr  = self.rb_addr + 4
                self.rb_left  = self.rb_left - 1
                self.err_q    = self.m_rresp[1]
                if self.rb_left == 1:
                    self.ack_tgl = ~self.ack_tgl
            else:
                self.rdata_q = self.m_rdata
                self.err_q   = self.m_rresp[1]
                self.ack_tgl = ~self.ack_tgl
