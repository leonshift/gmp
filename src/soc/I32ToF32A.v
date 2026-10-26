module I32ToF32A (
    input [31:0] a,
    output logic [38:0] pk
);
    logic z;
    logic s;
    logic [31:0] av;
    logic [4:0] msb;
    logic [4:0] u_lz_msb;

    assign z = (a == 0);
    assign s = a[31];
    assign av = (s ? (32'd0 - a) : a);
    assign msb = u_lz_msb;
    assign pk = {s, z, msb, av};

    Lzd u_lz (
        .src(av),
        .msb(u_lz_msb)
    );
endmodule
