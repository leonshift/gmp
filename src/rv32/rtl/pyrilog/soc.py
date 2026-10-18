"""RV32I_Zmmul CoreMark 系统；主机接口单笔未完成，请求接受后响应保持到消费。"""

from pyrilog.ir import Module, Input, Output, Logic, Param
from pyrilog.hdl import bits, concat, mux, zext, one_hot_mux, repeat
from pyrilog.hdl.cycle import State
from .core import Rv32Core
from .memory import IlmDlmRam


class Rv32Soc(Module):
    PREDICT = Param(int, default=2)
    TRACE = Param(int, default=1)
    PERF = Param(int, default=0)
    rst_n = Input(1)
    clock_measurement = Input(32)
    h_valid = Input(1)
    h_write = Input(1)
    h_addr = Input(32)
    h_data = Input(32)
    h_strb = Input(4)
    h_rready = Input(1)
    go = State(1, init=0)
    seeds = [State(32, init=0), State(32, init=0), State(32, init=0x66), State(32, init=0)]
    ticks = State(32, init=0)
    prescaler = State(8, init=0)
    cycles = State(64, init=0)
    timer_cycles = State(64, depth=32)
    timer_ticks = State(32, depth=32)
    timer_count = State(6, init=0)
    timer_overflow = State(1, init=0)
    # FF FIFO，128 字节；满时通过数据口背压，不丢字符。
    uart = State(8, depth=128)
    uart_wp = State(7, init=0)
    uart_rp = State(7, init=0)
    uart_count = State(8, init=0)
    rsp_v = State(1, init=0)
    rsp_d = State(32, init=0)
    rsp_mem = State(1, init=0)
    rsp_error = State(1, init=0)
    cpu_mem_q = State(1, init=0)
    cpu_mmio_q = State(32, init=0)
    cpu_error_q = State(1, init=0)
    fetch_error_q = State(1, init=0)
    fetch_retry_q = State(1, init=0)
    uart_pending = State(1, init=0)
    uart_pending_data = State(8, reset=False)
    timer_pending = State(1, init=0)
    timer_cycles_q = State(64, reset=False)
    timer_ticks_q = State(32, reset=False)
    invalid_pending = State(1, init=0)
    invalid = State(32, init=0)
    h_ready = Output(1, ~rsp_v)
    h_rvalid = Output(1, rsp_v)
    h_rdata = Output(32, mux(rsp_mem, u_ilm_dlm.b_q, rsp_d))
    h_error = Output(1, rsp_error)
    host_fire = Logic(1, h_valid & h_ready)
    host_ram = Logic(1, h_addr < 0x20000)
    host_mem = Logic(1, host_fire & host_ram & ~go & (h_addr[1:0] == 0))
    host_regs = Logic(1, (h_addr[31:12] == 0x20000) & (h_addr[1:0] == 0))
    host_off = Logic(12, h_addr[11:0])
    host_cfg = Logic(1, (host_off >= 0x30) & (host_off <= 0x3C))
    host_control = Logic(1, host_fire & host_regs & h_write & (host_off == 4) & (h_strb == 15))
    start_run = Logic(1, host_control & h_data[0] & ~go)
    stop_run = Logic(1, host_control & ~h_data[0])
    uart_pop = Logic(1, host_fire & host_regs & ~h_write & (host_off == 0x14) & (uart_count != 0))
    cpu_load_data = Logic(32, mux(cpu_mem_q, u_ilm_dlm.b_q, cpu_mmio_q))

    u_core = Rv32Core(
        PREDICT=PREDICT,
        TRACE=TRACE,
        PERF=PERF,
        rst_n=rst_n & go,
        i_ready=bits(1, 1),
        i_data=u_ilm_dlm.a_q,
        i_prediction=u_ilm_dlm.a_prediction,
        program_word=h_addr[16:2],
        program_data=h_data,
        i_error=fetch_error_q,
        i_retry=fetch_retry_q,
        d_ready=(bits(1, 1)),
        d_byte_pause=~uart_capacity,
        d_data=cpu_load_data,
        d_error=cpu_error_q,
        d_zero_hint=u_ilm_dlm.b_zero_hint_q,
    )
    cpu_ram = Logic(1, u_core.d_addr < 0x20000)
    cpu_mmio_region = Logic(1, u_core.d_addr[31:6] == bits(0x3FFFFFF, 26))
    cpu_read_word = Logic(1, ~u_core.d_write & (u_core.d_f3 == 2))
    cpu_write_byte = Logic(1, u_core.d_write & (u_core.d_f3 == 0))
    config_offset = Logic(1, (u_core.d_addr[5:4] == bits(1, 2)) & (u_core.d_addr[1:0] == 0))
    timer_offset = Logic(1, u_core.d_addr[5:0] == bits(0x38, 6))
    uart_offset = Logic(1, u_core.d_addr[5:0] == bits(0x3C, 6))
    cpu_timer = Logic(1, cpu_mmio_region & cpu_read_word & timer_offset)
    cpu_uart = Logic(1, cpu_mmio_region & cpu_write_byte & uart_offset)
    cpu_access_valid = Logic(
        1,
        cpu_ram
        | (
            cpu_mmio_region
            & ((cpu_read_word & (config_offset | timer_offset)) | (cpu_write_byte & uart_offset))
        ),
    )
    # 四级核心的请求背压不依赖地址加法结果；FIFO 满时保守暂停字节 store。
    uart_capacity = Logic(1, (uart_count < 127) | ((uart_count == 127) & ~uart_pending))
    cpu_ready = Logic(1, (~u_core.d_write | (u_core.d_f3 != 0) | uart_capacity))
    cpu_fire = Logic(1, go & u_core.d_valid & cpu_ready)
    uart_accept = Logic(1, cpu_fire & cpu_uart)
    uart_push = Logic(1, (uart_pending & go))
    timer_commit = Logic(1, (timer_pending & go))
    invalid_access = Logic(1, cpu_fire & ~cpu_access_valid)
    # 保守检测覆盖所有同字读写，低位相同的其他地址也通过重取排除。
    fetch_collision = Logic(
        1,
        u_core.d_store_valid
        & cpu_ready
        & u_core.d_store_local
        & (u_core.i_addr[7:2] == u_core.d_store_word[5:0]),
    )
    fetch_fire = Logic(1, go & u_core.i_valid & (bits(1, 1)))
    # 存储端口的所有权由 go 决定；停机时只有主机请求能够使能端口。
    memory_b_base = Logic(
        15,
        one_hot_mux(
            [~go, go & u_core.d_address_forward & ~cpu_mem_q, go & ~u_core.d_address_forward],
            [h_addr[16:2], cpu_mmio_q[16:2], u_core.d_store_word],
        ),
    )
    memory_b_ram_grant = Logic(1, go & u_core.d_address_forward & cpu_mem_q)
    memory_b_address = Logic(
        15, memory_b_base | (u_ilm_dlm.b_q[16:2] & repeat(memory_b_ram_grant, 15))
    )
    u_ilm_dlm = IlmDlmRam(
        a_en=fetch_fire,
        a_addr=u_core.i_addr[16:2],
        a_mask=bits(0, 4),
        a_data=bits(0, 32),
        b_en=host_mem | go,
        b_addr=memory_b_address,
        b_mask=mux(
            ~go,
            mux(h_write, h_strb, bits(0, 4)),
            mux(
                u_core.d_store_valid & cpu_ready & u_core.d_store_local, u_core.d_wstrb, bits(0, 4)
            ),
        ),
        b_data=mux(go, u_core.d_wdata, h_data),
        b_prediction=mux(~go & (h_strb == 15), u_core.program_prediction, bits(0, 18)),
        b_zero_hint=mux(
            go, u_core.d_zero_encode, mux(h_strb == 15, u_core.program_zero_encode, bits(0, 2))
        ),
        b_prediction_write=mux(
            go, u_core.d_store_valid & cpu_ready & u_core.d_store_local, h_write & (h_strb != 0)
        ),
    )
    config_index = Logic(2, u_core.d_addr[3:2])
    host_index = Logic(2, host_off[3:2])
    history_index = Logic(5, concat(~host_off[8], host_off[7:4]))
    history_cycles = Logic(64, timer_cycles[history_index])
    history_ticks = Logic(32, timer_ticks[history_index])
    history_word = Logic(
        32,
        mux(
            host_off[3:2], [history_cycles[31:0], history_cycles[63:32], history_ticks, bits(0, 32)]
        ),
    )
    # 主机控制寄存器常量地址在 host/run.py 同步定义。
    status = Logic(
        32, concat(bits(0, 29), u_core.halt_o & (u_core.cause_o != 3), u_core.halt_o, go)
    )
    counter_word = Logic(
        32,
        mux(
            host_off[5:2],
            [
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
                cycles[31:0],
                cycles[63:32],
                u_core.retired_o[31:0],
                u_core.retired_o[63:32],
                invalid,
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
                bits(0, 32),
            ],
        ),
    )
    read_value = Logic(
        32,
        mux(
            host_off == 0,
            bits(0x52563332, 32),
            mux(
                host_off == 4,
                zext(go, 32),
                mux(
                    host_off == 8,
                    status,
                    mux(
                        host_off == 0xC,
                        zext(u_core.cause_o, 32),
                        mux(
                            host_off == 0x10,
                            u_core.trap_pc_o,
                            mux(
                                host_off == 0x14,
                                concat(bits(0, 23), uart_count != 0, uart[uart_rp]),
                                mux(
                                    host_off == 0x18,
                                    zext(uart_count, 32),
                                    mux(
                                        host_cfg,
                                        mux(host_index, seeds),
                                        mux(
                                            host_off == 0x40,
                                            zext(timer_count, 32),
                                            mux(
                                                host_off == 0x44,
                                                zext(timer_overflow, 32),
                                                mux(
                                                    host_off == 0x48,
                                                    u_core.trap_value_o,
                                                    mux(
                                                        host_off == 0x4C,
                                                        clock_measurement,
                                                        mux(
                                                            (host_off >= 0x100)
                                                            & (host_off < 0x300),
                                                            history_word,
                                                            mux(
                                                                host_off == 0x50,
                                                                u_core.load_stalls_o[31:0],
                                                                mux(
                                                                    host_off == 0x54,
                                                                    u_core.muldiv_stalls_o[31:0],
                                                                    mux(
                                                                        host_off == 0x58,
                                                                        u_core.redirects_o[31:0],
                                                                        counter_word,
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        ),
    )
    halt_o = Output(1, u_core.halt_o)
    cause_o = Output(4, u_core.cause_o)
    trace_valid = Output(1, u_core.trace_valid)
    trace_pc = Output(32, u_core.trace_pc)
    trace_inst = Output(32, u_core.trace_inst)
    trace_rd = Output(5, u_core.trace_rd)
    trace_data = Output(32, u_core.trace_data)
    trace_store = Output(1, u_core.trace_store)
    trace_addr = Output(32, u_core.trace_addr)
    trace_wdata = Output(32, u_core.trace_wdata)
    trace_mask = Output(4, u_core.trace_mask)
    trace_trap = Output(1, u_core.trace_trap)

    def cycle(self, reset=rst_n):
        # 时间在请求接受边沿取样，下一拍写入历史缓冲。
        self.timer_cycles_q = self.cycles
        self.timer_ticks_q = self.ticks
        self.uart_pending = self.uart_accept
        self.uart_pending_data = self.u_core.d_byte
        self.timer_pending = self.cpu_fire & self.cpu_timer
        self.invalid_pending = self.invalid_access
        if self.start_run | self.stop_run:
            self.uart_pending = 0
            self.timer_pending = 0
            self.invalid_pending = 0
        if self.rsp_v & self.h_rready:
            self.rsp_v = 0
        if self.host_fire:
            self.rsp_v = 1
            self.rsp_mem = self.host_mem & ~self.h_write
            self.rsp_error = ~(self.host_mem | self.host_regs)
            self.rsp_d = self.read_value
            if self.host_regs & self.h_write:
                self.rsp_error = ~((self.host_off == 4) | (self.host_cfg & ~self.go)) | (
                    self.h_strb != 15
                )
                if self.host_cfg & ~self.go & (self.h_strb == 15):
                    for index in range(4):
                        if self.host_index == index:
                            self.seeds[index] = self.h_data
        if self.start_run:
            self.go = 1
            self.cycles = 0
            self.ticks = 0
            self.prescaler = 0
            self.timer_count = 0
            self.timer_overflow = 0
            self.uart_wp = 0
            self.uart_rp = 0
            self.uart_count = 0
            self.invalid = 0
        elif self.go & ~self.u_core.halt_o:
            self.cycles = self.cycles + 1
            if self.prescaler == 199:
                self.prescaler = 0
                self.ticks = self.ticks + 1
            else:
                self.prescaler = self.prescaler + 1
        if self.stop_run:
            self.go = 0
        if self.fetch_fire:
            self.fetch_error_q = (self.u_core.i_addr >= 0x20000) | (self.u_core.i_addr[1:0] != 0)
            self.fetch_retry_q = self.fetch_collision
        self.cpu_error_q = 0
        if self.cpu_fire:
            self.cpu_mem_q = self.cpu_ram
            self.cpu_error_q = ~self.cpu_access_valid
            self.cpu_mmio_q = mux(
                self.u_core.d_addr[5], self.ticks, mux(self.config_index, self.seeds)
            )
        if self.invalid_pending & ~self.start_run:
            self.invalid = self.invalid + 1
        if self.timer_commit:
            if self.timer_count < 32:
                self.timer_cycles[self.timer_count[4:0]] = self.timer_cycles_q
                self.timer_ticks[self.timer_count[4:0]] = self.timer_ticks_q
                self.timer_count = self.timer_count + 1
            else:
                self.timer_overflow = 1
        if self.uart_push:
            self.uart[self.uart_wp] = self.uart_pending_data
            self.uart_wp = self.uart_wp + 1
        if self.uart_pop:
            self.uart_rp = self.uart_rp + 1
        if self.uart_push & ~self.uart_pop:
            self.uart_count = self.uart_count + 1
        elif self.uart_pop & ~self.uart_push:
            self.uart_count = self.uart_count - 1
