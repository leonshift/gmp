// L1BankSram —— 一个 bank 的存储宏：NB 字节 × DEPTH 字，1R1W，同步读，按字节写使能。
//
// 手写 Verilog（规范例外：存储宏封装）。原因只有一条：pyrilog 的 `self.mem[a] = x` 只能整字写，
// 表达不出「按 wstrb 逐字节写」这个 BRAM 模板；用 NB 个字节阵列拼会把每个 bank 摊成 NB 块
// BRAM18（按 l1_params.py 现值 4 bank × 128 字节，整片 512 块），而下面这个模板 Vivado 按
// x72 + 字节使能推成整块 BRAM36（512 深、每块装 64 个数据位，每 bank 16 块；按位宽推算，待综合核对）。
// ASIC 上这一块就是带 byte-mask 的 SRAM 宏，接口一致。
//
// 时序：写在 wen 那一拍落地；读在 ren 那一拍给地址、第 2 拍 rdata 有效：BRAM 同步读之后
//   再过一级输出寄存（`rdata_r` → `rdata`，Vivado 推成 BRAM 自带的 DO_REG），出数的时钟到输出只有
//   寄存器那一段，不含 BRAM 读出的 1.8 ns。
//   读写同拍同址：读到旧值（1R1W 两口分离，SDP 模板的 READ_FIRST 语义）。上层用不到这一条：
//   crossbar 每拍只把一个 beat（读或写）授权给一个 bank，读写两条路（写经 `L1BankWPipe`、读地址经
//   `L1Bank` 的 `rd_*`）到这里都是授权后第 4 拍，所以读口与写口不会在同一拍动作（tb T21 全程计数）。
// pyrilog 侧的桩类 `L1BankSram`（rtl/pyrilog/l1_bank.py）只声明端口；DEPTH / AW / NB 的默认值
// 必须与 l1_params.py 的 BANK_WORDS / BANK_AW / BEAT_BYTES 一致，gen.py 会核对。
`timescale 1ns/1ps
module L1BankSram #(
    parameter DEPTH = 512,
    parameter AW    = 9,
    parameter NB    = 128
) (
    input  wire            clk,
    input  wire            wen,
    input  wire [AW-1:0]   waddr,
    input  wire [NB*8-1:0] wdata,
    input  wire [NB-1:0]   wstrb,
    input  wire            ren,
    input  wire [AW-1:0]   raddr,
    output reg  [NB*8-1:0] rdata
);
    (* ram_style = "block" *) reg [NB*8-1:0] mem [0:DEPTH-1];
    reg [NB*8-1:0] rdata_r;

    integer i;
    always @(posedge clk) begin
        if (wen) begin
            for (i = 0; i < NB; i = i + 1)
                if (wstrb[i]) mem[waddr][i*8 +: 8] <= wdata[i*8 +: 8];
        end
        if (ren) rdata_r <= mem[raddr];
        rdata <= rdata_r;
    end
endmodule
