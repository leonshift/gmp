module ABank (
    input clk,
    input we,
    input [1:0] wi,
    input [5:0] waddr,
    input [63:0] wdata,
    input [7:0] raddr,
    output logic [63:0] rd
);
    logic [15:0] m_0 [0:255];
    logic [15:0] m_1 [0:255];
    logic [15:0] m_2 [0:255];
    logic [15:0] m_3 [0:255];
    logic [15:0] q_0;
    logic [15:0] q_1;
    logic [15:0] q_2;
    logic [15:0] q_3;
    logic [15:0] r_0;
    logic [15:0] r_1;
    logic [15:0] r_2;
    logic [15:0] r_3;

    assign rd = {r_3, r_2, r_1, r_0};
    always_ff @(posedge clk) begin
        if ((we & (wi == 0))) begin
            m_0[{waddr, 2'd0}] <= wdata[15:0];
            m_0[{waddr, 2'd1}] <= wdata[31:16];
            m_0[{waddr, 2'd2}] <= wdata[47:32];
            m_0[{waddr, 2'd3}] <= wdata[63:48];
        end
        if ((we & (wi == 1))) begin
            m_1[{waddr, 2'd0}] <= wdata[15:0];
            m_1[{waddr, 2'd1}] <= wdata[31:16];
            m_1[{waddr, 2'd2}] <= wdata[47:32];
            m_1[{waddr, 2'd3}] <= wdata[63:48];
        end
        if ((we & (wi == 2))) begin
            m_2[{waddr, 2'd0}] <= wdata[15:0];
            m_2[{waddr, 2'd1}] <= wdata[31:16];
            m_2[{waddr, 2'd2}] <= wdata[47:32];
            m_2[{waddr, 2'd3}] <= wdata[63:48];
        end
        if ((we & (wi == 3))) begin
            m_3[{waddr, 2'd0}] <= wdata[15:0];
            m_3[{waddr, 2'd1}] <= wdata[31:16];
            m_3[{waddr, 2'd2}] <= wdata[47:32];
            m_3[{waddr, 2'd3}] <= wdata[63:48];
        end
        q_0 <= m_0[raddr];
        r_0 <= q_0;
        q_1 <= m_1[raddr];
        r_1 <= q_1;
        q_2 <= m_2[raddr];
        r_2 <= q_2;
        q_3 <= m_3[raddr];
        r_3 <= q_3;
    end
endmodule
