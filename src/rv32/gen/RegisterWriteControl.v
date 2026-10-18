module RegisterWriteControl (
    input clk,
    input rst_n,
    input write,
    input [4:0] address,
    output logic write_q,
    output logic reset_q,
    output logic [4:0] address_q
);
    logic held_write;
    logic held_reset;
    logic [4:0] held_address;

    assign write_q = held_write;
    assign reset_q = held_reset;
    assign address_q = held_address;
    always_ff @(negedge clk) begin
        held_write <= write;
        held_reset <= (~rst_n);
        held_address <= address;
    end
endmodule
