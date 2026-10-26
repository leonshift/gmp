module NormF32S (
    input [47:0] t,
    input [1:0] lsh_hi,
    output logic [47:0] mg,
    output logic sgo
);
    logic sg;
    logic [47:0] nt;
    logic [47:0] mag;
    logic [47:0] m0;

    assign sg = t[47];
    assign nt = (48'd0 - t);
    assign mag = (sg ? nt : t);
    assign m0 = {1'd0, mag[46:0]};
    assign mg = ((lsh_hi == 0) ? m0 : ((lsh_hi == 1) ? (m0 << 16) : ((lsh_hi == 2) ? (m0 << 32) : 48'd0)));
    assign sgo = sg;
endmodule
