module IlmDlmPredictionWord (
    input clk,
    input a_en,
    input [11:0] a_addr,
    output logic [8:0] a_q,
    input b_en,
    input [11:0] b_addr,
    input b_write,
    input [8:0] b_data,
    output logic [8:0] b_q
);
    logic [8:0] mem [0:4095];

    initial begin
        for (int _i = 0; _i < 4096; _i++) mem[_i] = 0;
    end

    always_ff @(posedge clk) begin
        if (a_en) begin
            a_q <= mem[a_addr];
        end
    end
    always_ff @(posedge clk) begin
        if (b_en) begin
            b_q <= mem[b_addr];
            if (b_write) begin
                mem[b_addr] <= b_data;
            end
        end
    end
endmodule
