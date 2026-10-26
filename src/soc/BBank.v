module BBank (
    input clk,
    input [15:0] we,
    input [4:0] waddr_0,
    input [4:0] waddr_1,
    input [4:0] waddr_2,
    input [4:0] waddr_3,
    input [1023:0] wdata,
    input [4:0] raddr_0,
    input [4:0] raddr_1,
    input [4:0] raddr_2,
    input [4:0] raddr_3,
    input rsel_0,
    input rsel_1,
    input rsel_2,
    input rsel_3,
    input rhi_0,
    input rhi_1,
    input rhi_2,
    input rhi_3,
    output logic [255:0] rd
);
    logic [15:0] m_0 [0:127];
    logic [15:0] m_1 [0:127];
    logic [15:0] m_2 [0:127];
    logic [15:0] m_3 [0:127];
    logic [15:0] m_4 [0:127];
    logic [15:0] m_5 [0:127];
    logic [15:0] m_6 [0:127];
    logic [15:0] m_7 [0:127];
    logic [15:0] m_8 [0:127];
    logic [15:0] m_9 [0:127];
    logic [15:0] m_10 [0:127];
    logic [15:0] m_11 [0:127];
    logic [15:0] m_12 [0:127];
    logic [15:0] m_13 [0:127];
    logic [15:0] m_14 [0:127];
    logic [15:0] m_15 [0:127];
    logic [15:0] q_0;
    logic [15:0] q_1;
    logic [15:0] q_2;
    logic [15:0] q_3;
    logic [15:0] q_4;
    logic [15:0] q_5;
    logic [15:0] q_6;
    logic [15:0] q_7;
    logic [15:0] q_8;
    logic [15:0] q_9;
    logic [15:0] q_10;
    logic [15:0] q_11;
    logic [15:0] q_12;
    logic [15:0] q_13;
    logic [15:0] q_14;
    logic [15:0] q_15;
    logic [15:0] r_0;
    logic [15:0] r_1;
    logic [15:0] r_2;
    logic [15:0] r_3;
    logic [15:0] r_4;
    logic [15:0] r_5;
    logic [15:0] r_6;
    logic [15:0] r_7;
    logic [15:0] r_8;
    logic [15:0] r_9;
    logic [15:0] r_10;
    logic [15:0] r_11;
    logic [15:0] r_12;
    logic [15:0] r_13;
    logic [15:0] r_14;
    logic [15:0] r_15;

    assign rd = {r_15, r_14, r_13, r_12, r_11, r_10, r_9, r_8, r_7, r_6, r_5, r_4, r_3, r_2, r_1, r_0};
    always_ff @(posedge clk) begin
        if (we[0]) begin
            m_0[{waddr_0, 2'd0}] <= wdata[15:0];
            m_0[{waddr_0, 2'd1}] <= wdata[31:16];
            m_0[{waddr_0, 2'd2}] <= wdata[47:32];
            m_0[{waddr_0, 2'd3}] <= wdata[63:48];
        end
        if (we[1]) begin
            m_1[{waddr_0, 2'd0}] <= wdata[79:64];
            m_1[{waddr_0, 2'd1}] <= wdata[95:80];
            m_1[{waddr_0, 2'd2}] <= wdata[111:96];
            m_1[{waddr_0, 2'd3}] <= wdata[127:112];
        end
        if (we[2]) begin
            m_2[{waddr_0, 2'd0}] <= wdata[143:128];
            m_2[{waddr_0, 2'd1}] <= wdata[159:144];
            m_2[{waddr_0, 2'd2}] <= wdata[175:160];
            m_2[{waddr_0, 2'd3}] <= wdata[191:176];
        end
        if (we[3]) begin
            m_3[{waddr_0, 2'd0}] <= wdata[207:192];
            m_3[{waddr_0, 2'd1}] <= wdata[223:208];
            m_3[{waddr_0, 2'd2}] <= wdata[239:224];
            m_3[{waddr_0, 2'd3}] <= wdata[255:240];
        end
        if (we[4]) begin
            m_4[{waddr_1, 2'd0}] <= wdata[271:256];
            m_4[{waddr_1, 2'd1}] <= wdata[287:272];
            m_4[{waddr_1, 2'd2}] <= wdata[303:288];
            m_4[{waddr_1, 2'd3}] <= wdata[319:304];
        end
        if (we[5]) begin
            m_5[{waddr_1, 2'd0}] <= wdata[335:320];
            m_5[{waddr_1, 2'd1}] <= wdata[351:336];
            m_5[{waddr_1, 2'd2}] <= wdata[367:352];
            m_5[{waddr_1, 2'd3}] <= wdata[383:368];
        end
        if (we[6]) begin
            m_6[{waddr_1, 2'd0}] <= wdata[399:384];
            m_6[{waddr_1, 2'd1}] <= wdata[415:400];
            m_6[{waddr_1, 2'd2}] <= wdata[431:416];
            m_6[{waddr_1, 2'd3}] <= wdata[447:432];
        end
        if (we[7]) begin
            m_7[{waddr_1, 2'd0}] <= wdata[463:448];
            m_7[{waddr_1, 2'd1}] <= wdata[479:464];
            m_7[{waddr_1, 2'd2}] <= wdata[495:480];
            m_7[{waddr_1, 2'd3}] <= wdata[511:496];
        end
        if (we[8]) begin
            m_8[{waddr_2, 2'd0}] <= wdata[527:512];
            m_8[{waddr_2, 2'd1}] <= wdata[543:528];
            m_8[{waddr_2, 2'd2}] <= wdata[559:544];
            m_8[{waddr_2, 2'd3}] <= wdata[575:560];
        end
        if (we[9]) begin
            m_9[{waddr_2, 2'd0}] <= wdata[591:576];
            m_9[{waddr_2, 2'd1}] <= wdata[607:592];
            m_9[{waddr_2, 2'd2}] <= wdata[623:608];
            m_9[{waddr_2, 2'd3}] <= wdata[639:624];
        end
        if (we[10]) begin
            m_10[{waddr_2, 2'd0}] <= wdata[655:640];
            m_10[{waddr_2, 2'd1}] <= wdata[671:656];
            m_10[{waddr_2, 2'd2}] <= wdata[687:672];
            m_10[{waddr_2, 2'd3}] <= wdata[703:688];
        end
        if (we[11]) begin
            m_11[{waddr_2, 2'd0}] <= wdata[719:704];
            m_11[{waddr_2, 2'd1}] <= wdata[735:720];
            m_11[{waddr_2, 2'd2}] <= wdata[751:736];
            m_11[{waddr_2, 2'd3}] <= wdata[767:752];
        end
        if (we[12]) begin
            m_12[{waddr_3, 2'd0}] <= wdata[783:768];
            m_12[{waddr_3, 2'd1}] <= wdata[799:784];
            m_12[{waddr_3, 2'd2}] <= wdata[815:800];
            m_12[{waddr_3, 2'd3}] <= wdata[831:816];
        end
        if (we[13]) begin
            m_13[{waddr_3, 2'd0}] <= wdata[847:832];
            m_13[{waddr_3, 2'd1}] <= wdata[863:848];
            m_13[{waddr_3, 2'd2}] <= wdata[879:864];
            m_13[{waddr_3, 2'd3}] <= wdata[895:880];
        end
        if (we[14]) begin
            m_14[{waddr_3, 2'd0}] <= wdata[911:896];
            m_14[{waddr_3, 2'd1}] <= wdata[927:912];
            m_14[{waddr_3, 2'd2}] <= wdata[943:928];
            m_14[{waddr_3, 2'd3}] <= wdata[959:944];
        end
        if (we[15]) begin
            m_15[{waddr_3, 2'd0}] <= wdata[975:960];
            m_15[{waddr_3, 2'd1}] <= wdata[991:976];
            m_15[{waddr_3, 2'd2}] <= wdata[1007:992];
            m_15[{waddr_3, 2'd3}] <= wdata[1023:1008];
        end
        q_0 <= m_0[{raddr_0, rhi_0, rsel_0}];
        r_0 <= q_0;
        q_1 <= m_1[{raddr_0, rhi_0, rsel_0}];
        r_1 <= q_1;
        q_2 <= m_2[{raddr_0, rhi_0, rsel_0}];
        r_2 <= q_2;
        q_3 <= m_3[{raddr_0, rhi_0, rsel_0}];
        r_3 <= q_3;
        q_4 <= m_4[{raddr_1, rhi_1, rsel_1}];
        r_4 <= q_4;
        q_5 <= m_5[{raddr_1, rhi_1, rsel_1}];
        r_5 <= q_5;
        q_6 <= m_6[{raddr_1, rhi_1, rsel_1}];
        r_6 <= q_6;
        q_7 <= m_7[{raddr_1, rhi_1, rsel_1}];
        r_7 <= q_7;
        q_8 <= m_8[{raddr_2, rhi_2, rsel_2}];
        r_8 <= q_8;
        q_9 <= m_9[{raddr_2, rhi_2, rsel_2}];
        r_9 <= q_9;
        q_10 <= m_10[{raddr_2, rhi_2, rsel_2}];
        r_10 <= q_10;
        q_11 <= m_11[{raddr_2, rhi_2, rsel_2}];
        r_11 <= q_11;
        q_12 <= m_12[{raddr_3, rhi_3, rsel_3}];
        r_12 <= q_12;
        q_13 <= m_13[{raddr_3, rhi_3, rsel_3}];
        r_13 <= q_13;
        q_14 <= m_14[{raddr_3, rhi_3, rsel_3}];
        r_14 <= q_14;
        q_15 <= m_15[{raddr_3, rhi_3, rsel_3}];
        r_15 <= q_15;
    end
endmodule
