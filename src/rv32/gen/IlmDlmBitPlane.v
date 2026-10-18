module IlmDlmBitPlane (
    input clk,
    input a_en,
    input [14:0] a_addr,
    input a_write,
    input a_data,
    output logic a_q,
    input b_en,
    input [14:0] b_addr,
    input b_write,
    input b_data,
    output logic b_q
);
    logic mem [0:32767];

    initial begin
        for (int _i = 0; _i < 32768; _i++) mem[_i] = 0;
    end

    always_ff @(posedge clk) begin
        if (a_en) begin
            a_q <= mem[a_addr];
            if (a_write) begin
                mem[a_addr] <= a_data;
            end
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
