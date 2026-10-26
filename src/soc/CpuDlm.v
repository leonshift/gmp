module CpuDlm (
    input clk,
    input [11:0] raddr,
    input we,
    input [11:0] waddr,
    input [3:0] wbe,
    input [31:0] wdata,
    input [3:0] wzero,
    input wlocal,
    output logic [31:0] rdata,
    output logic [3:0] zero_bytes,
    output logic pointer_local
);
    logic [8:0] m0 [0:4095];
    logic [8:0] m1 [0:4095];
    logic [8:0] m2 [0:4095];
    logic [8:0] m3 [0:4095];
    logic [8:0] q0;
    logic [8:0] q1;
    logic [8:0] q2;
    logic [8:0] q3;
    logic m2_is40_mem [0:4095];
    logic m2_is40_q;

    initial begin
        for (int _i = 0; _i < 4096; _i++) m0[_i] = 256;
        for (int _i = 0; _i < 4096; _i++) m1[_i] = 256;
        for (int _i = 0; _i < 4096; _i++) m2[_i] = 256;
        for (int _i = 0; _i < 4096; _i++) m3[_i] = 256;
        for (int _i = 0; _i < 4096; _i++) m2_is40_mem[_i] = 0;
    end

    assign rdata = {q3[7:0], q2[7:0], q1[7:0], q0[7:0]};
    assign zero_bytes = {q3[8], q2[8], q1[8], q0[8]};
    assign pointer_local = (m2_is40_q & q3[8]);
    always_ff @(posedge clk) begin
        q0 <= m0[raddr];
        q1 <= m1[raddr];
        q2 <= m2[raddr];
        q3 <= m3[raddr];
        m2_is40_q <= m2_is40_mem[raddr];
        if ((we & wbe[2])) begin
            m2_is40_mem[waddr] <= wlocal;
        end
        if (we) begin
            if (wbe[0]) begin
                m0[waddr] <= {wzero[0], wdata[7:0]};
            end
            if (wbe[1]) begin
                m1[waddr] <= {wzero[1], wdata[15:8]};
            end
            if (wbe[2]) begin
                m2[waddr] <= {wzero[2], wdata[23:16]};
            end
            if (wbe[3]) begin
                m3[waddr] <= {wzero[3], wdata[31:24]};
            end
        end
    end
endmodule
