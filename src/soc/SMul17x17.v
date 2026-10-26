module SMul17x17 (
    input [16:0] a,
    input [16:0] b,
    input [17:0] c,
    output logic [34:0] p
);
    // RawBlock(assign) — forward-direction artifact, preserved verbatim:
    assign p = $signed(a) * $signed({1'b0, b}) + $signed({1'b0, c});
endmodule
