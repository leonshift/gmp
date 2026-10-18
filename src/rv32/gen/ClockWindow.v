module ClockWindow (
    input clk,
    input rst_n,
    input [31:0] gray_in,
    output logic [31:0] gray_out
);
    logic [31:0] sync1;
    logic [31:0] sync2;
    logic [15:0] window;
    logic [31:0] previous;
    logic [31:0] measured;
    logic [31:0] current;
    logic [31:0] gray_q;

    assign current = (((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) ^ ((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) >> 2)) ^ (((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) ^ ((((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) ^ (((sync2 ^ (sync2 >> 16)) ^ ((sync2 ^ (sync2 >> 16)) >> 8)) >> 4)) >> 2)) >> 1));
    assign gray_out = gray_q;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync1 <= 0;
            sync2 <= 0;
            gray_q <= 0;
            window <= 0;
            measured <= 0;
            previous <= 0;
        end else begin
            sync1 <= gray_in;
            sync2 <= sync1;
            gray_q <= (measured ^ (measured >> 1));
            if ((window == 49999)) begin
                window <= 0;
                measured <= (current - previous);
                previous <= current;
            end else begin
                window <= (window + 1);
            end
        end
    end
endmodule
