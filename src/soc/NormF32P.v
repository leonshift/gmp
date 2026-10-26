module NormF32P (
    input [7:0] ex,
    output logic [7:0] ka,
    output logic [7:0] kb,
    output logic [7:0] km,
    output logic m128,
    output logic m127,
    output logic [5:0] ta
);
    logic [8:0] ta9;

    assign ka = (ex + 8'd127);
    assign kb = (ex + 8'd128);
    assign km = (ex + 8'd126);
    assign m128 = (ex == 128);
    assign m127 = (ex == 129);
    assign ta9 = (9'd128 - {ex[7], ex});
    assign ta = ((ta9 > 9'd48) ? 6'd48 : ta9[5:0]);
endmodule
