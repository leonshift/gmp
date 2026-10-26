module MacCell (
    input clk,
    input [15:0] a,
    input [15:0] b,
    input [35:0] cin,
    output logic [35:0] p
);
    // RawBlock(always) — forward-direction artifact, preserved verbatim:
    logic signed [15:0] ar, br;
        always_ff @(posedge clk) begin
          ar <= a;
          br <= b;
          p  <= $signed(cin) + ar * br;
        end
endmodule
