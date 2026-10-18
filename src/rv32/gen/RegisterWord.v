module RegisterWord (
    input clk,
    input rst_n,
    input [31:0] value,
    output logic [31:0] q
);
    logic [31:0] data;

    assign q = data;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            data <= 32'd4294967295;
        end else begin
            data <= value;
        end
    end
endmodule
