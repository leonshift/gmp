module EbTabSh (
    input clk,
    input rst_n,
    input we,
    input [4:0] waddr,
    input [33:0] wdata,
    input [5:0] raddr,
    input [5:0] emx,
    output logic [3:0] sh
);
    logic [33:0] m [0:31];
    logic [4:0] ra;
    logic [33:0] rw;
    logic [5:0] eb;
    logic [5:0] d;
    logic [3:0] shq;

    assign ra = raddr[5:1];
    assign rw = m[ra];
    assign eb = (raddr[0] ? rw[33:28] : rw[16:11]);
    assign d = (emx - eb);
    assign sh = shq;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            shq <= 0;
        end else begin
            shq <= ((d > 15) ? 4'd15 : d[3:0]);
        end
    end
    always_ff @(posedge clk) begin
        if (we) begin
            m[waddr] <= wdata;
        end
    end
endmodule
