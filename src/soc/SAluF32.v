module SAluF32 (
    input clk,
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    input rst_n,
    output logic [31:0] res
);
    logic is_sub;
    logic [31:0] nb;
    logic [31:0] addb;
    logic az;
    logic bz;
    logic lt;
    logic eq;
    logic gt;
    logic [31:0] q_a;
    logic [31:0] q_b;
    logic q_lt;
    logic q_eq;
    logic q_gt;
    logic [3:0] q_op;
    logic [31:0] t1;
    logic [31:0] t0;
    logic [31:0] u_add_res;
    logic [31:0] u_mul_res;

    assign is_sub = (op == 1);
    assign nb = {(~b[31]), b[30:0]};
    assign addb = (is_sub ? nb : b);
    assign az = (a[30:23] == 0);
    assign bz = (b[30:23] == 0);
    assign lt = (((a[30:23] == 0) & (b[30:23] == 0)) ? 1'd0 :
                ((a[30:23] == 0) ? ((~b[31]) & (~(b[30:23] == 0))) :
                ((b[30:23] == 0) ? a[31] :
                ((a[31] ^ b[31]) ? a[31] :
                (a[31] ? (a[30:0] > b[30:0]) :
                (a[30:0] < b[30:0]))))));
    assign eq = ((az & bz) ? 1'd1 : (a == b));
    assign gt = ((~lt) & (~eq));
    assign t1 = 32'd1065353216;
    assign t0 = 32'd0;
    assign res = ((q_op == 0) ? u_add_res :
                 ((q_op == 1) ? u_add_res :
                 ((q_op == 2) ? u_mul_res :
                 ((q_op == 3) ? t0 :
                 ((q_op == 4) ? (q_lt ? q_b : q_a) :
                 ((q_op == 5) ? (q_lt ? q_a : q_b) :
                 ((q_op == 6) ? (q_gt ? t1 : t0) :
                 ((q_op == 7) ? (q_lt ? t0 : t1) :
                 ((q_op == 8) ? (q_lt ? t1 : t0) :
                 ((q_op == 9) ? (q_gt ? t0 : t1) :
                 ((q_op == 10) ? (q_eq ? t1 : t0) :
                 (q_eq ? t0 :
                 t1))))))))))));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q_a <= 0;
            q_b <= 0;
            q_lt <= 0;
            q_eq <= 0;
            q_gt <= 0;
            q_op <= 0;
        end else begin
            q_a <= a;
            q_b <= b;
            q_lt <= lt;
            q_eq <= eq;
            q_gt <= gt;
            q_op <= op;
        end
    end

    FpAddP u_add (
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(addb),
        .res(u_add_res)
    );
    FpMulP u_mul (
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(b),
        .res(u_mul_res)
    );
endmodule
