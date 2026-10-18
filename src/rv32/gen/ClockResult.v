module ClockResult (
    input clk,
    input rst_n,
    input [31:0] gray_in,
    output logic [31:0] measured
);
    logic [31:0] sync1;
    logic [31:0] sync2;

    assign measured = (((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) ^ ((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) >> 2)) ^ (((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) ^ ((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) >> 2)) >> 1));
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync1 <= 0;
            sync2 <= 0;
        end else begin
            sync1 <= gray_in;
            sync2 <= sync1;
        end
    end
endmodule
