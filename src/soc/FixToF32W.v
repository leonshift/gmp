module FixToF32W (
    input [21:0] val,
    input [21:0] mgi,
    input [7:0] e,
    output logic [31:0] res
);
    logic sg;
    logic z;
    logic [4:0] msb;
    logic [4:0] sh;
    logic [21:0] nrm;
    logic [22:0] fr;
    logic [9:0] ew;
    logic lo;
    logic hi;
    logic [7:0] e8;
    logic [22:0] mo;
    logic [31:0] bd;
    logic [4:0] u_lz_msb;

    assign sg = val[21];
    assign z = (mgi == 22'd0);
    assign msb = u_lz_msb;
    assign sh = (5'd21 - msb);
    assign nrm = (mgi << sh);
    assign fr = {nrm[20:0], 2'd0};
    assign ew = (({2'd0, e} + {5'd0, msb}) - 10'd15);
    assign lo = (ew[9] | (ew == 10'd0));
    assign hi = ((~ew[9]) & (ew >= 10'd255));
    assign e8 = (hi ? 8'd254 : ew[7:0]);
    assign mo = (hi ? 23'd8388607 : fr);
    assign bd = {sg, e8, mo};
    assign res = ((z | lo) ? 32'd0 : bd);

    Lzd_N22 u_lz (
        .src(mgi),
        .msb(u_lz_msb)
    );
endmodule
