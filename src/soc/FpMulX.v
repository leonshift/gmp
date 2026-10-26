module FpMulX (
    input clk,
    input rst_n,
    input [31:0] a_in,
    input [31:0] b_in,
    output logic [31:0] res
);
    logic [23:0] am;
    logic [8:0] ax;
    logic [23:0] bm;
    logic [8:0] bx;
    logic az;
    logic bz;
    logic sgn;
    logic [47:0] p;
    logic [9:0] e0;
    logic [9:0] e1;
    logic [24:0] q_p;
    logic [7:0] q_e0;
    logic [7:0] q_e1;
    logic q_u0;
    logic q_u1;
    logic q_o0;
    logic q_o1;
    logic q_z;
    logic q_sgn;
    logic pn;
    logic [31:0] zr;
    logic [31:0] inf;
    logic [31:0] r1;
    logic [31:0] r0;

    assign az = (ax[7:0] == 0);
    assign bz = (bx[7:0] == 0);
    assign sgn = (ax[8] ^ bx[8]);
    assign p = (am * bm);
    assign e0 = (({2'd0, ax[7:0]} + {2'd0, bx[7:0]}) - 10'd127);
    assign e1 = (({2'd0, ax[7:0]} + {2'd0, bx[7:0]}) - 10'd126);
    assign pn = q_p[24];
    assign zr = {q_sgn, 31'd0};
    assign inf = {q_sgn, 31'd2139095040};
    assign r1 = (q_u1 ? zr : (q_o1 ? inf : {q_sgn, q_e1, q_p[23:1]}));
    assign r0 = (q_u0 ? zr : (q_o0 ? inf : {q_sgn, q_e0, q_p[22:0]}));
    assign res = (q_z ? zr : (pn ? r1 : r0));
    always_ff @(posedge clk) begin
        am <= {1'd1, a_in[22:0]};
        ax <= a_in[31:23];
        bm <= {1'd1, b_in[22:0]};
        bx <= b_in[31:23];
        q_p <= p[47:23];
        q_e0 <= e0[7:0];
        q_e1 <= e1[7:0];
        q_u0 <= (e0[9] | (e0 == 0));
        q_u1 <= (e1[9] | (e1 == 0));
        q_o0 <= ((~e0[9]) & (e0 >= 255));
        q_o1 <= ((~e1[9]) & (e1 >= 255));
        q_z <= (az | bz);
        q_sgn <= sgn;
    end
endmodule
