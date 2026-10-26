module NocAsmRam (
    input clk,
    input we,
    input [4:0] waddr,
    input [511:0] wdata,
    input ren,
    input [4:0] raddr,
    output logic [511:0] rdata
);
    logic [511:0] mem [0:31];
    logic [511:0] rq;

    initial begin
        for (int _i = 0; _i < 32; _i++) mem[_i] = 0;
    end

    assign rdata = rq;
    always_ff @(posedge clk) begin
        if (ren) begin
            rq <= mem[raddr];
        end
        if (we) begin
            mem[waddr] <= wdata;
        end
    end
endmodule
