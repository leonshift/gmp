module I32ToF32B (
    input [38:0] pk,
    output logic [31:0] res
);
    logic [31:0] av;
    logic [4:0] msb;
    logic z;
    logic s;
    logic [7:0] e8;
    logic [4:0] lsh;
    logic [31:0] an;

    assign av = pk[31:0];
    assign msb = pk[36:32];
    assign z = pk[37];
    assign s = pk[38];
    assign e8 = (8'd127 + {3'd0, msb});
    assign lsh = (5'd31 - msb);
    assign an = (av << lsh);
    assign res = (z ? 32'd0 : {s, e8, an[30:8]});
endmodule
