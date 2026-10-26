module L1BankWPipe (
    input clk,
    input rst_n,
    input wen,
    input [8:0] waddr,
    input [2:0] wsel,
    input whalf,
    input [1023:0] p0_wdata,
    input [127:0] p0_wstrb,
    input [511:0] p1_wdata,
    input [63:0] p1_wstrb,
    input [511:0] p2_wdata,
    input [63:0] p2_wstrb,
    output logic o_wen,
    output logic [8:0] o_waddr,
    output logic [1023:0] o_wdata,
    output logic [127:0] o_wstrb
);
    logic wen_q1;
    logic [8:0] waddr_q1;
    logic [2:0] wsel_q1;
    logic whalf_q1;
    logic wen_qm;
    logic [8:0] waddr_qm;
    logic sd_qm;
    logic sv_qm;
    logic svl_qm;
    logic svh_qm;
    logic sml_qm;
    logic smh_qm;
    logic wen_q2;
    logic [8:0] waddr_q2;
    logic k_d_0;
    logic k_d_1;
    logic k_d_2;
    logic k_d_3;
    logic k_d_4;
    logic k_d_5;
    logic k_d_6;
    logic k_d_7;
    logic k_d_8;
    logic k_d_9;
    logic k_d_10;
    logic k_d_11;
    logic k_d_12;
    logic k_d_13;
    logic k_d_14;
    logic k_d_15;
    logic k_v_0;
    logic k_v_1;
    logic k_v_2;
    logic k_v_3;
    logic k_v_4;
    logic k_v_5;
    logic k_v_6;
    logic k_v_7;
    logic k_v_8;
    logic k_v_9;
    logic k_v_10;
    logic k_v_11;
    logic k_v_12;
    logic k_v_13;
    logic k_v_14;
    logic k_v_15;
    logic k_vs_0;
    logic k_vs_1;
    logic k_vs_2;
    logic k_vs_3;
    logic k_vs_4;
    logic k_vs_5;
    logic k_vs_6;
    logic k_vs_7;
    logic k_vs_8;
    logic k_vs_9;
    logic k_vs_10;
    logic k_vs_11;
    logic k_vs_12;
    logic k_vs_13;
    logic k_vs_14;
    logic k_vs_15;
    logic k_ms_0;
    logic k_ms_1;
    logic k_ms_2;
    logic k_ms_3;
    logic k_ms_4;
    logic k_ms_5;
    logic k_ms_6;
    logic k_ms_7;
    logic k_ms_8;
    logic k_ms_9;
    logic k_ms_10;
    logic k_ms_11;
    logic k_ms_12;
    logic k_ms_13;
    logic k_ms_14;
    logic k_ms_15;
    logic wen_q;
    logic [8:0] waddr_q;
    logic [1023:0] wdata_q;
    logic [127:0] wstrb_q;
    logic [1023:0] wdata_m;
    logic [127:0] wstrb_m;

    assign wdata_m = {(k_d_15 ? p0_wdata[1023:960] : (k_v_15 ? p1_wdata[511:448] : p2_wdata[511:448])),
                      (k_d_14 ? p0_wdata[959:896] : (k_v_14 ? p1_wdata[447:384] : p2_wdata[447:384])),
                      (k_d_13 ? p0_wdata[895:832] : (k_v_13 ? p1_wdata[383:320] : p2_wdata[383:320])),
                      (k_d_12 ? p0_wdata[831:768] : (k_v_12 ? p1_wdata[319:256] : p2_wdata[319:256])),
                      (k_d_11 ? p0_wdata[767:704] : (k_v_11 ? p1_wdata[255:192] : p2_wdata[255:192])),
                      (k_d_10 ? p0_wdata[703:640] : (k_v_10 ? p1_wdata[191:128] : p2_wdata[191:128])),
                      (k_d_9 ? p0_wdata[639:576] : (k_v_9 ? p1_wdata[127:64] : p2_wdata[127:64])),
                      (k_d_8 ? p0_wdata[575:512] : (k_v_8 ? p1_wdata[63:0] : p2_wdata[63:0])),
                      (k_d_7 ? p0_wdata[511:448] : (k_v_7 ? p1_wdata[511:448] : p2_wdata[511:448])),
                      (k_d_6 ? p0_wdata[447:384] : (k_v_6 ? p1_wdata[447:384] : p2_wdata[447:384])),
                      (k_d_5 ? p0_wdata[383:320] : (k_v_5 ? p1_wdata[383:320] : p2_wdata[383:320])),
                      (k_d_4 ? p0_wdata[319:256] : (k_v_4 ? p1_wdata[319:256] : p2_wdata[319:256])),
                      (k_d_3 ? p0_wdata[255:192] : (k_v_3 ? p1_wdata[255:192] : p2_wdata[255:192])),
                      (k_d_2 ? p0_wdata[191:128] : (k_v_2 ? p1_wdata[191:128] : p2_wdata[191:128])),
                      (k_d_1 ? p0_wdata[127:64] : (k_v_1 ? p1_wdata[127:64] : p2_wdata[127:64])),
                      (k_d_0 ? p0_wdata[63:0] : (k_v_0 ? p1_wdata[63:0] : p2_wdata[63:0]))};
    assign wstrb_m = {((({8{k_d_15}} & p0_wstrb[127:120]) | ({8{k_vs_15}} & p1_wstrb[63:56]))
                       | ({8{k_ms_15}} & p2_wstrb[63:56])),
                      ((({8{k_d_14}} & p0_wstrb[119:112]) | ({8{k_vs_14}} & p1_wstrb[55:48]))
                       | ({8{k_ms_14}} & p2_wstrb[55:48])),
                      ((({8{k_d_13}} & p0_wstrb[111:104]) | ({8{k_vs_13}} & p1_wstrb[47:40]))
                       | ({8{k_ms_13}} & p2_wstrb[47:40])),
                      ((({8{k_d_12}} & p0_wstrb[103:96]) | ({8{k_vs_12}} & p1_wstrb[39:32]))
                       | ({8{k_ms_12}} & p2_wstrb[39:32])),
                      ((({8{k_d_11}} & p0_wstrb[95:88]) | ({8{k_vs_11}} & p1_wstrb[31:24]))
                       | ({8{k_ms_11}} & p2_wstrb[31:24])),
                      ((({8{k_d_10}} & p0_wstrb[87:80]) | ({8{k_vs_10}} & p1_wstrb[23:16]))
                       | ({8{k_ms_10}} & p2_wstrb[23:16])),
                      ((({8{k_d_9}} & p0_wstrb[79:72]) | ({8{k_vs_9}} & p1_wstrb[15:8]))
                       | ({8{k_ms_9}} & p2_wstrb[15:8])),
                      ((({8{k_d_8}} & p0_wstrb[71:64]) | ({8{k_vs_8}} & p1_wstrb[7:0])) | ({8{k_ms_8}} & p2_wstrb[7:0])),
                      ((({8{k_d_7}} & p0_wstrb[63:56]) | ({8{k_vs_7}} & p1_wstrb[63:56]))
                       | ({8{k_ms_7}} & p2_wstrb[63:56])),
                      ((({8{k_d_6}} & p0_wstrb[55:48]) | ({8{k_vs_6}} & p1_wstrb[55:48]))
                       | ({8{k_ms_6}} & p2_wstrb[55:48])),
                      ((({8{k_d_5}} & p0_wstrb[47:40]) | ({8{k_vs_5}} & p1_wstrb[47:40]))
                       | ({8{k_ms_5}} & p2_wstrb[47:40])),
                      ((({8{k_d_4}} & p0_wstrb[39:32]) | ({8{k_vs_4}} & p1_wstrb[39:32]))
                       | ({8{k_ms_4}} & p2_wstrb[39:32])),
                      ((({8{k_d_3}} & p0_wstrb[31:24]) | ({8{k_vs_3}} & p1_wstrb[31:24]))
                       | ({8{k_ms_3}} & p2_wstrb[31:24])),
                      ((({8{k_d_2}} & p0_wstrb[23:16]) | ({8{k_vs_2}} & p1_wstrb[23:16]))
                       | ({8{k_ms_2}} & p2_wstrb[23:16])),
                      ((({8{k_d_1}} & p0_wstrb[15:8]) | ({8{k_vs_1}} & p1_wstrb[15:8]))
                       | ({8{k_ms_1}} & p2_wstrb[15:8])),
                      ((({8{k_d_0}} & p0_wstrb[7:0]) | ({8{k_vs_0}} & p1_wstrb[7:0])) | ({8{k_ms_0}} & p2_wstrb[7:0]))};
    assign o_wen = wen_q;
    assign o_waddr = waddr_q;
    assign o_wdata = wdata_q;
    assign o_wstrb = wstrb_q;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wen_q1 <= 0;
            wen_qm <= 0;
            wen_q2 <= 0;
            wen_q <= 0;
        end else begin
            wen_q1 <= wen;
            wen_qm <= wen_q1;
            wen_q2 <= wen_qm;
            wen_q <= wen_q2;
        end
    end
    always_ff @(posedge clk) begin
        waddr_q1 <= waddr;
        wsel_q1 <= wsel;
        whalf_q1 <= whalf;
        waddr_qm <= waddr_q1;
        sd_qm <= wsel_q1[0];
        sv_qm <= wsel_q1[1];
        svl_qm <= (wsel_q1[1] & (~whalf_q1));
        svh_qm <= (wsel_q1[1] & whalf_q1);
        sml_qm <= (wsel_q1[2] & (~whalf_q1));
        smh_qm <= (wsel_q1[2] & whalf_q1);
        waddr_q2 <= waddr_qm;
        k_d_0 <= sd_qm;
        k_v_0 <= sv_qm;
        k_vs_0 <= svl_qm;
        k_ms_0 <= sml_qm;
        k_d_1 <= sd_qm;
        k_v_1 <= sv_qm;
        k_vs_1 <= svl_qm;
        k_ms_1 <= sml_qm;
        k_d_2 <= sd_qm;
        k_v_2 <= sv_qm;
        k_vs_2 <= svl_qm;
        k_ms_2 <= sml_qm;
        k_d_3 <= sd_qm;
        k_v_3 <= sv_qm;
        k_vs_3 <= svl_qm;
        k_ms_3 <= sml_qm;
        k_d_4 <= sd_qm;
        k_v_4 <= sv_qm;
        k_vs_4 <= svl_qm;
        k_ms_4 <= sml_qm;
        k_d_5 <= sd_qm;
        k_v_5 <= sv_qm;
        k_vs_5 <= svl_qm;
        k_ms_5 <= sml_qm;
        k_d_6 <= sd_qm;
        k_v_6 <= sv_qm;
        k_vs_6 <= svl_qm;
        k_ms_6 <= sml_qm;
        k_d_7 <= sd_qm;
        k_v_7 <= sv_qm;
        k_vs_7 <= svl_qm;
        k_ms_7 <= sml_qm;
        k_d_8 <= sd_qm;
        k_v_8 <= sv_qm;
        k_vs_8 <= svh_qm;
        k_ms_8 <= smh_qm;
        k_d_9 <= sd_qm;
        k_v_9 <= sv_qm;
        k_vs_9 <= svh_qm;
        k_ms_9 <= smh_qm;
        k_d_10 <= sd_qm;
        k_v_10 <= sv_qm;
        k_vs_10 <= svh_qm;
        k_ms_10 <= smh_qm;
        k_d_11 <= sd_qm;
        k_v_11 <= sv_qm;
        k_vs_11 <= svh_qm;
        k_ms_11 <= smh_qm;
        k_d_12 <= sd_qm;
        k_v_12 <= sv_qm;
        k_vs_12 <= svh_qm;
        k_ms_12 <= smh_qm;
        k_d_13 <= sd_qm;
        k_v_13 <= sv_qm;
        k_vs_13 <= svh_qm;
        k_ms_13 <= smh_qm;
        k_d_14 <= sd_qm;
        k_v_14 <= sv_qm;
        k_vs_14 <= svh_qm;
        k_ms_14 <= smh_qm;
        k_d_15 <= sd_qm;
        k_v_15 <= sv_qm;
        k_vs_15 <= svh_qm;
        k_ms_15 <= smh_qm;
        waddr_q <= waddr_q2;
        wdata_q <= wdata_m;
        wstrb_q <= wstrb_m;
    end
endmodule
