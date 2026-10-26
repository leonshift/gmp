// NocDramSram —— 板内 DRAM 模型的存储本体：512 bit × DEPTH 字，1R1W，同步读带使能，按字节写使能。
//
// 手写 Verilog（规范例外：存储宏封装，与 g1/l1pipe 的 L1BankSram 同一个模板、同一个理由）：pyrilog 的
// `self.mem[a] = x` 只能整字写，表达不出「按 wstrb 逐字节写」这个 BRAM 模板。DEPTH 4096 = 256 KiB，
// Vivado 推成 x72 + 字节使能的 BRAM36。pyrilog 侧的桩类 `NocDramSram`（rtl/pyrilog/noc_dram.py）只声明端口；
// DEPTH / AW 的默认值必须与 noc_dram.py 的 DRAM_BEATS / DRAM_AW 一致，gen.py 会核对。
// 读写同拍同址读到旧值（SDP 模板 READ_FIRST 语义）；模型里 host 后门与 W 落地不会同拍写。
`timescale 1ns/1ps
module NocDramSram #(
    parameter DEPTH = 4096,
    parameter AW    = 12
) (
    input  wire           clk,
    input  wire           wen,
    input  wire [AW-1:0]  waddr,
    input  wire [511:0]   wdata,
    input  wire [63:0]    wstrb,
    input  wire           ren,
    input  wire [AW-1:0]  raddr,
    output reg  [511:0]   rdata
);
    (* ram_style = "block" *) reg [511:0] mem [0:DEPTH-1];

    integer i;
    always @(posedge clk) begin
        if (wen) begin
            for (i = 0; i < 64; i = i + 1)
                if (wstrb[i]) mem[waddr][i*8 +: 8] <= wdata[i*8 +: 8];
        end
        if (ren) rdata <= mem[raddr];
    end
endmodule
