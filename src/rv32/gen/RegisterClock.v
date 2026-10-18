module RegisterClock (
    input clk,
    input enable,
    output logic clock
);
    logic held;

    assign clock = (clk & held);
    always_ff @(negedge clk) begin
        held <= enable;
    end
endmodule
