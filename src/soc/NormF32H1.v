module NormF32H1 (
    input [5:0] l,
    input sz,
    input [3:0] mm,
    input mz,
    input [7:0] km,
    input [7:0] ka,
    input m128,
    input m127,
    input [5:0] ta,
    output logic [5:0] lsh,
    output logic [7:0] ea,
    output logic [7:0] eb,
    output logic za,
    output logic zb,
    output logic oa,
    output logic ob
);
    logic [5:0] hc;
    logic z;

    assign hc = (l + {2'd0, mm});
    assign z = (sz | mz);
    assign lsh = (6'd47 - hc);
    assign ea = ({2'd0, hc} + km);
    assign eb = ({2'd0, hc} + ka);
    assign za = ((z | (m128 & (hc <= 2))) | (m127 & (hc == 1)));
    assign zb = ((z | (m128 & (hc <= 1))) | (m127 & (hc == 0)));
    assign oa = (hc > ta);
    assign ob = (hc >= ta);
endmodule
