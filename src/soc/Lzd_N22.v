module Lzd_N22 (
    input [21:0] src,
    output logic [4:0] msb
);
    logic [31:0] pad;
    logic b_0;
    logic b_1;
    logic b_2;
    logic b_3;
    logic b_4;
    logic [15:0] sl_0;
    logic [7:0] sl_1;
    logic [3:0] sl_2;
    logic [1:0] sl_3;

    assign pad = {10'd0, src};
    assign b_0 = (pad[31:16] != 0);
    assign sl_0 = (b_0 ? pad[31:16] : pad[15:0]);
    assign b_1 = (sl_0[15:8] != 0);
    assign sl_1 = (b_1 ? sl_0[15:8] : sl_0[7:0]);
    assign b_2 = (sl_1[7:4] != 0);
    assign sl_2 = (b_2 ? sl_1[7:4] : sl_1[3:0]);
    assign b_3 = (sl_2[3:2] != 0);
    assign sl_3 = (b_3 ? sl_2[3:2] : sl_2[1:0]);
    assign b_4 = (sl_3[1] != 0);
    assign msb = {b_0, b_1, b_2, b_3, b_4};
endmodule
