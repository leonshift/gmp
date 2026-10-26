module UMulS24x18 (
    input [23:0] a,
    input [17:0] b,
    input [24:0] c,
    output logic [47:0] p
);
    // RawBlock(assign) — forward-direction artifact, preserved verbatim:
    assign p = $signed({1'b0, a}) * $signed(b) + $signed({1'b0, c});
endmodule
