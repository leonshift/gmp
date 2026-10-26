module EbTab (
    input clk,
    input we,
    input [4:0] waddr,
    input [33:0] wdata,
    input [5:0] raddr,
    output logic [16:0] rd
);
    logic [16:0] q;
    logic [33:0] m [0:31];
    logic [4:0] ra;
    logic [33:0] rw;

    assign ra = raddr[5:1];
    assign rw = m[ra];
    assign rd = q;
    always_ff @(posedge clk) begin
        if (we) begin
            m[waddr] <= wdata;
        end
        q <= (raddr[0] ? rw[33:17] : rw[16:0]);
    end
endmodule
