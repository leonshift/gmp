module ClockCounter (
    input clk,
    input rst_n,
    output logic [31:0] gray
);
    logic [31:0] count;
    logic [31:0] next_count;
    logic [31:0] gray_q;

    assign next_count = (count + 1);
    assign gray = gray_q;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
            gray_q <= 0;
        end else begin
            count <= next_count;
            gray_q <= (next_count ^ (next_count >> 1));
        end
    end
endmodule
