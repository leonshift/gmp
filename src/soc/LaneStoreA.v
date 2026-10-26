module LaneStoreA (
    input [15:0] f,
    output logic [22:0] pk
);
    logic sn;
    logic [15:0] mg_n;
    logic [15:0] mg_out;
    logic z;
    logic [4:0] msb;
    logic [4:0] sh;
    logic [3:0] u_lz_msb;

    assign sn = f[15];
    assign mg_n = (f ^ {16{f[15]}});
    assign mg_out = (mg_n + {15'd0, f[15]});
    assign z = (mg_out == 16'd0);
    assign msb = u_lz_msb;
    assign sh = (5'd15 - msb);
    assign pk = {sn, z, sh, mg_out};

    Lzd_N16 u_lz (
        .src(mg_out),
        .msb(u_lz_msb)
    );
endmodule
