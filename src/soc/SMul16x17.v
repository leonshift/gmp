module SMul16x17 (
    input [15:0] a,
    input [16:0] b,
    input [47:0] c,
    output logic [47:0] p
);
    // RawBlock(assign) — forward-direction artifact, preserved verbatim:
    assign p = $signed(a) * $signed({1'b0, b}) + $signed(c);
endmodule
