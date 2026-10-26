module MsMsb (
    input [10:0] ms,
    output logic [3:0] mm,
    output logic z
);
    logic [15:0] lz_0;
    logic lz_1;
    logic [7:0] lz_2;
    logic lz_3;
    logic [3:0] lz_4;
    logic lz_5;
    logic [1:0] lz_6;
    logic lz_7;

    assign lz_0 = {5'd0, ms};
    assign lz_1 = (lz_0[15:8] != 0);
    assign lz_2 = (lz_1 ? lz_0[15:8] : lz_0[7:0]);
    assign lz_3 = (lz_2[7:4] != 0);
    assign lz_4 = (lz_3 ? lz_2[7:4] : lz_2[3:0]);
    assign lz_5 = (lz_4[3:2] != 0);
    assign lz_6 = (lz_5 ? lz_4[3:2] : lz_4[1:0]);
    assign lz_7 = (lz_6[1] != 0);
    assign mm = {lz_1, lz_3, lz_5, lz_7};
    assign z = (ms == 0);
endmodule
