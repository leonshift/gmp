module F32ToSeg (
    input [31:0] x,
    output logic [7:0] e,
    output logic [15:0] f
);
    logic sn;
    logic [7:0] e8;
    logic z;
    logic hi;
    logic [15:0] mg0;
    logic [15:0] mg;
    logic [15:0] ng;
    logic [15:0] fv;
    logic [8:0] ew;

    assign sn = x[31];
    assign e8 = x[30:23];
    assign z = (e8 == 8'd0);
    assign hi = (e8 == 8'd255);
    assign mg0 = {1'd0, 1'd1, x[22:9]};
    assign mg = (hi ? 16'd32767 : mg0);
    assign ng = (16'd0 - mg);
    assign fv = (sn ? ng : mg);
    assign ew = ({1'd0, e8} + 9'd1);
    assign e = (z ? 8'd0 : (hi ? 8'd255 : ew[7:0]));
    assign f = (z ? 16'd0 : fv);
endmodule
