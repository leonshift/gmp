module CpuPayload (
    input clk,
    input enable,
    input [31:0] value,
    output logic [31:0] q
);
    logic [31:0] data;

    assign q = data;
    always_ff @(posedge clk) begin
        if (enable) begin
            data <= value;
        end
    end
endmodule
