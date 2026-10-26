module SMul24x18 (
    input [23:0] a,
    input [17:0] b,
    input [39:0] c,
    output logic [39:0] p
);
    // RawBlock(assign) — forward-direction artifact, preserved verbatim:
    assign p = $signed(a) * $signed(b) + $signed(c);
endmodule
