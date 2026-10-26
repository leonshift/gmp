module SMul37x11 (
    input clk,
    input [36:0] s,
    input [10:0] ms,
    input ce,
    output logic [47:0] t
);
    // RawBlock(always) — forward-direction artifact, preserved verbatim:
    logic signed [36:0] sr;
        logic [10:0] mr;
        logic signed [47:0] m;
        always_ff @(posedge clk) begin
          sr <= s;
          if (ce) mr <= ms;
          m <= sr * $signed({1'b0, mr});
          t <= m;
        end
endmodule
