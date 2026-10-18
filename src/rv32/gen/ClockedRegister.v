module ClockedRegister (
    input clk,
    input rst_n,
    input enable,
    input [31:0] value,
    output logic [31:0] q
);
    logic gated_clock;
    logic [31:0] u_word_q;

    assign gated_clock = (clk & enable);
    assign q = u_word_q;

    RegisterWord u_word (
        .clk(gated_clock),
        .rst_n(rst_n),
        .value(value),
        .q(u_word_q)
    );
endmodule
