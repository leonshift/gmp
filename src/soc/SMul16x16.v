module SMul16x16 (
    input [15:0] a,
    input [15:0] b,
    input [47:0] c,
    output logic [47:0] p
);
    // RawBlock(assign) — forward-direction artifact, preserved verbatim:
    assign p = $signed(a) * $signed(b) + $signed(c);
endmodule
