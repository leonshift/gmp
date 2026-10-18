module ClockedPayload (
    input clk,
    input enable,
    input [31:0] value,
    output logic [31:0] q
);
    logic u_gate_clock;
    logic [31:0] u_word_q;

    assign q = u_word_q;

    RegisterClock u_gate (
        .clk(clk),
        .enable(enable),
        .clock(u_gate_clock)
    );
    PayloadWord u_word (
        .clk(u_gate_clock),
        .value(value),
        .q(u_word_q)
    );
endmodule
