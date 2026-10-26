module Lzd_N8 (
    input [7:0] src,
    output logic [2:0] msb
);
    logic b_0;
    logic b_1;
    logic b_2;
    logic [3:0] sl_0;
    logic [1:0] sl_1;

    assign b_0 = (src[7:4] != 0);
    assign sl_0 = (b_0 ? src[7:4] : src[3:0]);
    assign b_1 = (sl_0[3:2] != 0);
    assign sl_1 = (b_1 ? sl_0[3:2] : sl_0[1:0]);
    assign b_2 = (sl_1[1] != 0);
    assign msb = {b_0, b_1, b_2};
endmodule
