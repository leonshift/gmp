module FuncSegToF32 (
    input [18:0] m,
    input [8:0] ed,
    input sgn,
    output logic [31:0] res
);
    logic z;
    logic [10:0] ew;
    logic lo;
    logic hi;
    logic [7:0] e8;
    logic [22:0] m23;
    logic [31:0] bd;

    assign z = ((ed == 9'd0) | (m == 19'd0));
    assign ew = ({2'd0, ed} - 11'd20);
    assign lo = (ew[10] | (ew == 11'd0));
    assign hi = ((~ew[10]) & (ew >= 11'd255));
    assign e8 = (hi ? 8'd254 : ew[7:0]);
    assign m23 = (hi ? 23'd8388607 : {m[17:0], 5'd0});
    assign bd = {sgn, e8, m23};
    assign res = ((z | lo) ? {sgn, 31'd0} : bd);
endmodule
