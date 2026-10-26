module ExpTab (
    input clk,
    input rst_n,
    input we,
    input [5:0] waddr,
    input [9:0] wdata,
    input [6:0] raddr,
    output logic [4:0] rd
);
    logic [9:0] q;
    logic hi_q;
    logic [9:0] m [0:63];
    logic [5:0] ra;

    assign ra = raddr[6:1];
    assign rd = (hi_q ? q[9:5] : q[4:0]);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 0;
            hi_q <= 0;
        end else begin
            q <= m[ra];
            hi_q <= raddr[0];
        end
    end
    always_ff @(posedge clk) begin
        if (we) begin
            m[waddr] <= wdata;
        end
    end
endmodule
