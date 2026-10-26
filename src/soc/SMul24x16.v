module SMul24x16 (
    input [23:0] a,
    input [15:0] b,
    input [39:0] c,
    output logic [39:0] p
);
    // RawBlock(assign) — forward-direction artifact, preserved verbatim:
    assign p = $signed(a) * $signed({1'b0, b}) + $signed(c);
endmodule
