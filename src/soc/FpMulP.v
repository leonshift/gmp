module FpMulP (
    input clk,
    input rst_n,
    input [31:0] a,
    input [31:0] b,
    output logic [31:0] res
);
    logic az;
    logic bz;
    logic sgn;
    logic [7:0] ea;
    logic [7:0] eb;
    logic [18:0] ma;
    logic [18:0] mb;
    logic [16:0] mb_lo;
    logic [20:0] mhi;
    logic [37:0] p;
    logic [9:0] es;
    logic [37:0] q_p;
    logic q_az;
    logic q_bz;
    logic q_sgn;
    logic [9:0] q_es;
    logic pn;
    logic [18:0] pm;
    logic [9:0] e10;
    logic undf;
    logic ovf;
    logic [22:0] mout;

    assign az = (a[30:23] == 0);
    assign bz = (b[30:23] == 0);
    assign sgn = (a[31] ^ b[31]);
    assign ea = a[30:23];
    assign eb = b[30:23];
    assign ma = {1'd1, a[22:5]};
    assign mb = {1'd1, b[22:5]};
    assign mb_lo = mb[16:0];
    assign mhi = ((mb[17] ? {2'd0, ma} : 21'd0) + (mb[18] ? {1'd0, ma, 1'd0} : 21'd0));
    assign p = ((ma * mb_lo) + {mhi, 17'd0});
    assign es = (({2'd0, ea} + {2'd0, eb}) - 10'd127);
    assign pn = q_p[37];
    assign pm = (pn ? q_p[37:19] : q_p[36:18]);
    assign e10 = (q_es + {9'd0, pn});
    assign undf = (e10[9] | (e10 == 0));
    assign ovf = ((~e10[9]) & (e10 >= 255));
    assign mout = {pm[17:0], 5'd0};
    assign res = ((q_az | q_bz) ? {q_sgn, 31'd0} :
                 (undf ? {q_sgn, 31'd0} :
                 (ovf ? {q_sgn, 31'd2139095040} :
                 {q_sgn, e10[7:0], mout})));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q_p <= 0;
            q_az <= 0;
            q_bz <= 0;
            q_sgn <= 0;
            q_es <= 0;
        end else begin
            q_p <= p;
            q_az <= az;
            q_bz <= bz;
            q_sgn <= sgn;
            q_es <= es;
        end
    end
endmodule
