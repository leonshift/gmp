module CpuIlm (
    input clk,
    input re,
    input host_re,
    input [13:0] raddr,
    input we,
    input [13:0] waddr,
    input [31:0] wdata,
    input [17:0] wprediction,
    output logic [31:0] rdata,
    output logic [17:0] prediction,
    output logic [31:0] host_rdata
);
    logic [31:0] mem [0:12287];
    logic [17:0] prediction_mem [0:12287];
    logic [31:0] rq;
    logic [17:0] prediction_q;
    logic [31:0] host_q;

    initial begin
        for (int _i = 0; _i < 12288; _i++) mem[_i] = 0;
        for (int _i = 0; _i < 12288; _i++) prediction_mem[_i] = 0;
    end

    assign rdata = rq;
    assign prediction = prediction_q;
    assign host_rdata = host_q;
    always_ff @(posedge clk) begin
        if (host_re) begin
            host_q <= mem[waddr];
        end
        if (re) begin
            rq <= mem[raddr];
            prediction_q <= prediction_mem[raddr];
        end
        if (we) begin
            mem[waddr] <= wdata;
            prediction_mem[waddr] <= wprediction;
        end
    end
endmodule
