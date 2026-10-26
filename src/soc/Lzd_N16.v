module Lzd_N16 (
    input [15:0] src,
    output logic [3:0] msb
);
    logic b_0;
    logic b_1;
    logic b_2;
    logic b_3;
    logic [7:0] sl_0;
    logic [3:0] sl_1;
    logic [1:0] sl_2;

    assign b_0 = (src[15:8] != 0);
    assign sl_0 = (b_0 ? src[15:8] : src[7:0]);
    assign b_1 = (sl_0[7:4] != 0);
    assign sl_1 = (b_1 ? sl_0[7:4] : sl_0[3:0]);
    assign b_2 = (sl_1[3:2] != 0);
    assign sl_2 = (b_2 ? sl_1[3:2] : sl_1[1:0]);
    assign b_3 = (sl_2[1] != 0);
    assign msb = {b_0, b_1, b_2, b_3};
endmodule
