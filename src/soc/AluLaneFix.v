module AluLaneFix (
    input clk,
    input rst_n,
    input [15:0] a,
    input [15:0] b,
    input [16:0] oha,
    input [16:0] ohb,
    input [3:0] op,
    input [15:0] vtq,
    input is_where,
    input en,
    output logic [16:0] res
);
    logic [15:0] a_q;
    logic [15:0] b_q;
    logic [47:0] pa;
    logic [15:0] aa;
    logic [47:0] pb;
    logic [15:0] bb;
    logic [47:0] pcor;
    logic [47:0] pm;
    logic [16:0] prod;
    logic mnz;
    logic [16:0] q_prod;
    logic [15:0] q_aa;
    logic [15:0] q_bb;
    logic q_mnz;
    logic [3:0] q_op;
    logic q_isw;
    logic [16:0] q_sum;
    logic [16:0] q_dif;
    logic q_lt;
    logic q_eq;
    logic [16:0] t1;
    logic [16:0] t0;
    logic q_gt;
    logic zb;
    logic cmpb;
    logic [16:0] cmpv;
    logic [16:0] mmv;
    logic [16:0] arith;
    logic [16:0] aluv;
    logic [47:0] u_pa_p;
    logic [47:0] u_pb_p;
    logic [47:0] u_pm_p;

    assign pa = u_pa_p;
    assign aa = pa[31:16];
    assign pb = u_pb_p;
    assign bb = pb[31:16];
    assign pcor = ((a_q[15] ^ b_q[15]) ? 48'd32767 : 48'd0);
    assign pm = u_pm_p;
    assign prod = pm[31:15];
    assign mnz = (a_q != 16'd0);
    assign q_sum = ({q_aa[15], q_aa} + {q_bb[15], q_bb});
    assign q_dif = ({q_aa[15], q_aa} - {q_bb[15], q_bb});
    assign q_lt = ((q_aa[15] ^ q_bb[15]) ? q_aa[15] : (q_aa < q_bb));
    assign q_eq = (q_aa == q_bb);
    assign t1 = 17'd32768;
    assign t0 = 17'd0;
    assign q_gt = ((~q_lt) & (~q_eq));
    assign zb = 1'd0;
    assign cmpb = ((q_op == 0) ? zb :
                  ((q_op == 1) ? zb :
                  ((q_op == 2) ? zb :
                  ((q_op == 3) ? zb :
                  ((q_op == 4) ? zb :
                  ((q_op == 5) ? zb :
                  ((q_op == 6) ? q_gt :
                  ((q_op == 7) ? (~q_lt) :
                  ((q_op == 8) ? q_lt :
                  ((q_op == 9) ? (~q_gt) :
                  ((q_op == 10) ? q_eq :
                  (~q_eq))))))))))));
    assign cmpv = (cmpb ? t1 : t0);
    assign mmv = ((q_lt ^ q_op[0]) ? {q_bb[15], q_bb} : {q_aa[15], q_aa});
    assign arith = ((q_op[2:0] == 0) ? q_sum :
                   ((q_op[2:0] == 1) ? q_dif :
                   ((q_op[2:0] == 2) ? q_prod :
                   ((q_op[2:0] == 3) ? t0 :
                   ((q_op[2:0] == 4) ? mmv :
                   ((q_op[2:0] == 5) ? mmv :
                   ((q_op[2:0] == 6) ? cmpv :
                   cmpv)))))));
    assign aluv = (q_op[3] ? cmpv : arith);
    assign res = (q_isw ? (q_mnz ? {vtq[15], vtq} : {q_bb[15], q_bb}) : aluv);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            a_q <= 0;
            b_q <= 0;
            q_prod <= 0;
            q_aa <= 0;
            q_bb <= 0;
            q_mnz <= 0;
            q_op <= 0;
            q_isw <= 0;
        end else begin
            if (en) begin
                a_q <= a;
                b_q <= b;
                q_prod <= prod;
                q_aa <= aa;
                q_bb <= bb;
                q_mnz <= mnz;
                q_op <= op;
                q_isw <= is_where;
            end
        end
    end

    SMul16x17 u_pa (
        .a(a_q),
        .b(oha),
        .c(48'd32768),
        .p(u_pa_p)
    );
    SMul16x17 u_pb (
        .a(b_q),
        .b(ohb),
        .c(48'd32768),
        .p(u_pb_p)
    );
    SMul16x16 u_pm (
        .a(a_q),
        .b(b_q),
        .c(pcor),
        .p(u_pm_p)
    );
endmodule
