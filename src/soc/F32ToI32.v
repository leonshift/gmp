module F32ToI32 (
    input [31:0] a,
    output logic [31:0] res,
    output logic [31:0] u,
    output logic ng
);
    logic s;
    logic [7:0] e8;
    logic [23:0] m24;
    logic lt1;
    logic [7:0] sh;
    logic big;
    logic [31:0] mtop;
    logic [4:0] rs;
    logic [31:0] mag;
    logic [31:0] neg;
    logic [31:0] sat;
    logic [31:0] v;

    assign s = a[31];
    assign e8 = a[30:23];
    assign m24 = {1'd1, a[22:0]};
    assign lt1 = (e8 < 8'd127);
    assign sh = (e8 - 8'd127);
    assign big = ((~lt1) & (sh >= 8'd31));
    assign mtop = {m24, 8'd0};
    assign rs = (~sh[4:0]);
    assign mag = (mtop >> rs);
    assign neg = (32'd0 - mag);
    assign sat = (s ? 32'd2147483648 : 32'd2147483647);
    assign v = (s ? neg : mag);
    assign res = (lt1 ? 32'd0 : (big ? sat : v));
    assign u = (lt1 ? 32'd0 : (big ? sat : mag));
    assign ng = ((s & (~lt1)) & (~big));
endmodule
