module SegNorm64 (
    input clk,
    input rst_n,
    input [543:0] r,
    input rv,
    input rph,
    input [9:0] eo,
    input en,
    output logic [7:0] e,
    output logic [1023:0] f,
    output logic [1023:0] fq,
    output logic ov
);
    logic [16:0] rl_0;
    logic [16:0] rl_1;
    logic [16:0] rl_2;
    logic [16:0] rl_3;
    logic [16:0] rl_4;
    logic [16:0] rl_5;
    logic [16:0] rl_6;
    logic [16:0] rl_7;
    logic [16:0] rl_8;
    logic [16:0] rl_9;
    logic [16:0] rl_10;
    logic [16:0] rl_11;
    logic [16:0] rl_12;
    logic [16:0] rl_13;
    logic [16:0] rl_14;
    logic [16:0] rl_15;
    logic [16:0] rl_16;
    logic [16:0] rl_17;
    logic [16:0] rl_18;
    logic [16:0] rl_19;
    logic [16:0] rl_20;
    logic [16:0] rl_21;
    logic [16:0] rl_22;
    logic [16:0] rl_23;
    logic [16:0] rl_24;
    logic [16:0] rl_25;
    logic [16:0] rl_26;
    logic [16:0] rl_27;
    logic [16:0] rl_28;
    logic [16:0] rl_29;
    logic [16:0] rl_30;
    logic [16:0] rl_31;
    logic [16:0] mg_0_n;
    logic [16:0] mg_0_out;
    logic [16:0] mg_1_n;
    logic [16:0] mg_1_out;
    logic [16:0] mg_2_n;
    logic [16:0] mg_2_out;
    logic [16:0] mg_3_n;
    logic [16:0] mg_3_out;
    logic [16:0] mg_4_n;
    logic [16:0] mg_4_out;
    logic [16:0] mg_5_n;
    logic [16:0] mg_5_out;
    logic [16:0] mg_6_n;
    logic [16:0] mg_6_out;
    logic [16:0] mg_7_n;
    logic [16:0] mg_7_out;
    logic [16:0] mg_8_n;
    logic [16:0] mg_8_out;
    logic [16:0] mg_9_n;
    logic [16:0] mg_9_out;
    logic [16:0] mg_10_n;
    logic [16:0] mg_10_out;
    logic [16:0] mg_11_n;
    logic [16:0] mg_11_out;
    logic [16:0] mg_12_n;
    logic [16:0] mg_12_out;
    logic [16:0] mg_13_n;
    logic [16:0] mg_13_out;
    logic [16:0] mg_14_n;
    logic [16:0] mg_14_out;
    logic [16:0] mg_15_n;
    logic [16:0] mg_15_out;
    logic [16:0] mg_16_n;
    logic [16:0] mg_16_out;
    logic [16:0] mg_17_n;
    logic [16:0] mg_17_out;
    logic [16:0] mg_18_n;
    logic [16:0] mg_18_out;
    logic [16:0] mg_19_n;
    logic [16:0] mg_19_out;
    logic [16:0] mg_20_n;
    logic [16:0] mg_20_out;
    logic [16:0] mg_21_n;
    logic [16:0] mg_21_out;
    logic [16:0] mg_22_n;
    logic [16:0] mg_22_out;
    logic [16:0] mg_23_n;
    logic [16:0] mg_23_out;
    logic [16:0] mg_24_n;
    logic [16:0] mg_24_out;
    logic [16:0] mg_25_n;
    logic [16:0] mg_25_out;
    logic [16:0] mg_26_n;
    logic [16:0] mg_26_out;
    logic [16:0] mg_27_n;
    logic [16:0] mg_27_out;
    logic [16:0] mg_28_n;
    logic [16:0] mg_28_out;
    logic [16:0] mg_29_n;
    logic [16:0] mg_29_out;
    logic [16:0] mg_30_n;
    logic [16:0] mg_30_out;
    logic [16:0] mg_31_n;
    logic [16:0] mg_31_out;
    logic [16:0] c0_0;
    logic [16:0] c0_1;
    logic [16:0] c0_2;
    logic [16:0] c0_3;
    logic [16:0] c0_4;
    logic [16:0] c0_5;
    logic [101:0] cpack;
    logic [16:0] mlo_c;
    logic [16:0] mhi_c;
    logic [101:0] cA;
    logic [101:0] cB;
    logic [543:0] rA;
    logic [543:0] rB;
    logic [9:0] q_eo;
    logic [16:0] q_mlo;
    logic [16:0] q_mhi;
    logic vC;
    logic [16:0] da_0;
    logic [16:0] da_1;
    logic [16:0] da_2;
    logic [16:0] da_3;
    logic [16:0] da_4;
    logic [16:0] da_5;
    logic [16:0] db_0;
    logic [16:0] db_1;
    logic [16:0] db_2;
    logic [16:0] db_3;
    logic [16:0] db_4;
    logic [16:0] db_5;
    logic [16:0] hi;
    logic hp_0;
    logic hp_1;
    logic hp_2;
    logic hp_3;
    logic hp_4;
    logic hp_5;
    logic hp_6;
    logic hp_7;
    logic hp_8;
    logic hp_9;
    logic hp_10;
    logic hp_11;
    logic hp_12;
    logic hp_13;
    logic hp_14;
    logic hp_15;
    logic hp_16;
    logic zseg;
    logic e_hi;
    logic [16:0] oh_c;
    logic sat_c;
    logic [16:0] p_oh_g_0;
    logic [16:0] p_oh_g_1;
    logic [16:0] p_oh_g_2;
    logic [16:0] p_oh_g_3;
    logic [16:0] p_oh_g_4;
    logic [16:0] p_oh_g_5;
    logic [16:0] p_oh_g_6;
    logic [16:0] p_oh_g_7;
    logic p_sat_g_0;
    logic p_sat_g_1;
    logic p_sat_g_2;
    logic p_sat_g_3;
    logic p_sat_g_4;
    logic p_sat_g_5;
    logic p_sat_g_6;
    logic p_sat_g_7;
    logic p_zs;
    logic p_eh;
    logic [7:0] p_eb;
    logic [7:0] p_e;
    logic [543:0] spc;
    logic [543:0] sph;
    logic vS0;
    logic vS1;
    logic [511:0] pq;
    logic [511:0] f_lo;
    logic [4:0] oh_k;
    logic [7:0] e_c;
    logic [16:0] nl_0_qr;
    logic nl_0_xz;
    logic [17:0] nl_0_cs;
    logic [34:0] nl_0_pm;
    logic [16:0] nl_1_qr;
    logic nl_1_xz;
    logic [17:0] nl_1_cs;
    logic [34:0] nl_1_pm;
    logic [16:0] nl_2_qr;
    logic nl_2_xz;
    logic [17:0] nl_2_cs;
    logic [34:0] nl_2_pm;
    logic [16:0] nl_3_qr;
    logic nl_3_xz;
    logic [17:0] nl_3_cs;
    logic [34:0] nl_3_pm;
    logic [16:0] nl_4_qr;
    logic nl_4_xz;
    logic [17:0] nl_4_cs;
    logic [34:0] nl_4_pm;
    logic [16:0] nl_5_qr;
    logic nl_5_xz;
    logic [17:0] nl_5_cs;
    logic [34:0] nl_5_pm;
    logic [16:0] nl_6_qr;
    logic nl_6_xz;
    logic [17:0] nl_6_cs;
    logic [34:0] nl_6_pm;
    logic [16:0] nl_7_qr;
    logic nl_7_xz;
    logic [17:0] nl_7_cs;
    logic [34:0] nl_7_pm;
    logic [16:0] nl_8_qr;
    logic nl_8_xz;
    logic [17:0] nl_8_cs;
    logic [34:0] nl_8_pm;
    logic [16:0] nl_9_qr;
    logic nl_9_xz;
    logic [17:0] nl_9_cs;
    logic [34:0] nl_9_pm;
    logic [16:0] nl_10_qr;
    logic nl_10_xz;
    logic [17:0] nl_10_cs;
    logic [34:0] nl_10_pm;
    logic [16:0] nl_11_qr;
    logic nl_11_xz;
    logic [17:0] nl_11_cs;
    logic [34:0] nl_11_pm;
    logic [16:0] nl_12_qr;
    logic nl_12_xz;
    logic [17:0] nl_12_cs;
    logic [34:0] nl_12_pm;
    logic [16:0] nl_13_qr;
    logic nl_13_xz;
    logic [17:0] nl_13_cs;
    logic [34:0] nl_13_pm;
    logic [16:0] nl_14_qr;
    logic nl_14_xz;
    logic [17:0] nl_14_cs;
    logic [34:0] nl_14_pm;
    logic [16:0] nl_15_qr;
    logic nl_15_xz;
    logic [17:0] nl_15_cs;
    logic [34:0] nl_15_pm;
    logic [16:0] nl_16_qr;
    logic nl_16_xz;
    logic [17:0] nl_16_cs;
    logic [34:0] nl_16_pm;
    logic [16:0] nl_17_qr;
    logic nl_17_xz;
    logic [17:0] nl_17_cs;
    logic [34:0] nl_17_pm;
    logic [16:0] nl_18_qr;
    logic nl_18_xz;
    logic [17:0] nl_18_cs;
    logic [34:0] nl_18_pm;
    logic [16:0] nl_19_qr;
    logic nl_19_xz;
    logic [17:0] nl_19_cs;
    logic [34:0] nl_19_pm;
    logic [16:0] nl_20_qr;
    logic nl_20_xz;
    logic [17:0] nl_20_cs;
    logic [34:0] nl_20_pm;
    logic [16:0] nl_21_qr;
    logic nl_21_xz;
    logic [17:0] nl_21_cs;
    logic [34:0] nl_21_pm;
    logic [16:0] nl_22_qr;
    logic nl_22_xz;
    logic [17:0] nl_22_cs;
    logic [34:0] nl_22_pm;
    logic [16:0] nl_23_qr;
    logic nl_23_xz;
    logic [17:0] nl_23_cs;
    logic [34:0] nl_23_pm;
    logic [16:0] nl_24_qr;
    logic nl_24_xz;
    logic [17:0] nl_24_cs;
    logic [34:0] nl_24_pm;
    logic [16:0] nl_25_qr;
    logic nl_25_xz;
    logic [17:0] nl_25_cs;
    logic [34:0] nl_25_pm;
    logic [16:0] nl_26_qr;
    logic nl_26_xz;
    logic [17:0] nl_26_cs;
    logic [34:0] nl_26_pm;
    logic [16:0] nl_27_qr;
    logic nl_27_xz;
    logic [17:0] nl_27_cs;
    logic [34:0] nl_27_pm;
    logic [16:0] nl_28_qr;
    logic nl_28_xz;
    logic [17:0] nl_28_cs;
    logic [34:0] nl_28_pm;
    logic [16:0] nl_29_qr;
    logic nl_29_xz;
    logic [17:0] nl_29_cs;
    logic [34:0] nl_29_pm;
    logic [16:0] nl_30_qr;
    logic nl_30_xz;
    logic [17:0] nl_30_cs;
    logic [34:0] nl_30_pm;
    logic [16:0] nl_31_qr;
    logic nl_31_xz;
    logic [17:0] nl_31_cs;
    logic [34:0] nl_31_pm;
    logic [511:0] sh_out;
    logic [511:0] f_lo_c;
    logic [34:0] u_pm_0_p;
    logic [34:0] u_pm_1_p;
    logic [34:0] u_pm_2_p;
    logic [34:0] u_pm_3_p;
    logic [34:0] u_pm_4_p;
    logic [34:0] u_pm_5_p;
    logic [34:0] u_pm_6_p;
    logic [34:0] u_pm_7_p;
    logic [34:0] u_pm_8_p;
    logic [34:0] u_pm_9_p;
    logic [34:0] u_pm_10_p;
    logic [34:0] u_pm_11_p;
    logic [34:0] u_pm_12_p;
    logic [34:0] u_pm_13_p;
    logic [34:0] u_pm_14_p;
    logic [34:0] u_pm_15_p;
    logic [34:0] u_pm_16_p;
    logic [34:0] u_pm_17_p;
    logic [34:0] u_pm_18_p;
    logic [34:0] u_pm_19_p;
    logic [34:0] u_pm_20_p;
    logic [34:0] u_pm_21_p;
    logic [34:0] u_pm_22_p;
    logic [34:0] u_pm_23_p;
    logic [34:0] u_pm_24_p;
    logic [34:0] u_pm_25_p;
    logic [34:0] u_pm_26_p;
    logic [34:0] u_pm_27_p;
    logic [34:0] u_pm_28_p;
    logic [34:0] u_pm_29_p;
    logic [34:0] u_pm_30_p;
    logic [34:0] u_pm_31_p;

    assign rl_0 = r[16:0];
    assign mg_0_n = (rl_0 ^ {17{rl_0[16]}});
    assign mg_0_out = (mg_0_n + {16'd0, rl_0[16]});
    assign rl_1 = r[33:17];
    assign mg_1_n = (rl_1 ^ {17{rl_1[16]}});
    assign mg_1_out = (mg_1_n + {16'd0, rl_1[16]});
    assign rl_2 = r[50:34];
    assign mg_2_n = (rl_2 ^ {17{rl_2[16]}});
    assign mg_2_out = (mg_2_n + {16'd0, rl_2[16]});
    assign rl_3 = r[67:51];
    assign mg_3_n = (rl_3 ^ {17{rl_3[16]}});
    assign mg_3_out = (mg_3_n + {16'd0, rl_3[16]});
    assign rl_4 = r[84:68];
    assign mg_4_n = (rl_4 ^ {17{rl_4[16]}});
    assign mg_4_out = (mg_4_n + {16'd0, rl_4[16]});
    assign rl_5 = r[101:85];
    assign mg_5_n = (rl_5 ^ {17{rl_5[16]}});
    assign mg_5_out = (mg_5_n + {16'd0, rl_5[16]});
    assign rl_6 = r[118:102];
    assign mg_6_n = (rl_6 ^ {17{rl_6[16]}});
    assign mg_6_out = (mg_6_n + {16'd0, rl_6[16]});
    assign rl_7 = r[135:119];
    assign mg_7_n = (rl_7 ^ {17{rl_7[16]}});
    assign mg_7_out = (mg_7_n + {16'd0, rl_7[16]});
    assign rl_8 = r[152:136];
    assign mg_8_n = (rl_8 ^ {17{rl_8[16]}});
    assign mg_8_out = (mg_8_n + {16'd0, rl_8[16]});
    assign rl_9 = r[169:153];
    assign mg_9_n = (rl_9 ^ {17{rl_9[16]}});
    assign mg_9_out = (mg_9_n + {16'd0, rl_9[16]});
    assign rl_10 = r[186:170];
    assign mg_10_n = (rl_10 ^ {17{rl_10[16]}});
    assign mg_10_out = (mg_10_n + {16'd0, rl_10[16]});
    assign rl_11 = r[203:187];
    assign mg_11_n = (rl_11 ^ {17{rl_11[16]}});
    assign mg_11_out = (mg_11_n + {16'd0, rl_11[16]});
    assign rl_12 = r[220:204];
    assign mg_12_n = (rl_12 ^ {17{rl_12[16]}});
    assign mg_12_out = (mg_12_n + {16'd0, rl_12[16]});
    assign rl_13 = r[237:221];
    assign mg_13_n = (rl_13 ^ {17{rl_13[16]}});
    assign mg_13_out = (mg_13_n + {16'd0, rl_13[16]});
    assign rl_14 = r[254:238];
    assign mg_14_n = (rl_14 ^ {17{rl_14[16]}});
    assign mg_14_out = (mg_14_n + {16'd0, rl_14[16]});
    assign rl_15 = r[271:255];
    assign mg_15_n = (rl_15 ^ {17{rl_15[16]}});
    assign mg_15_out = (mg_15_n + {16'd0, rl_15[16]});
    assign rl_16 = r[288:272];
    assign mg_16_n = (rl_16 ^ {17{rl_16[16]}});
    assign mg_16_out = (mg_16_n + {16'd0, rl_16[16]});
    assign rl_17 = r[305:289];
    assign mg_17_n = (rl_17 ^ {17{rl_17[16]}});
    assign mg_17_out = (mg_17_n + {16'd0, rl_17[16]});
    assign rl_18 = r[322:306];
    assign mg_18_n = (rl_18 ^ {17{rl_18[16]}});
    assign mg_18_out = (mg_18_n + {16'd0, rl_18[16]});
    assign rl_19 = r[339:323];
    assign mg_19_n = (rl_19 ^ {17{rl_19[16]}});
    assign mg_19_out = (mg_19_n + {16'd0, rl_19[16]});
    assign rl_20 = r[356:340];
    assign mg_20_n = (rl_20 ^ {17{rl_20[16]}});
    assign mg_20_out = (mg_20_n + {16'd0, rl_20[16]});
    assign rl_21 = r[373:357];
    assign mg_21_n = (rl_21 ^ {17{rl_21[16]}});
    assign mg_21_out = (mg_21_n + {16'd0, rl_21[16]});
    assign rl_22 = r[390:374];
    assign mg_22_n = (rl_22 ^ {17{rl_22[16]}});
    assign mg_22_out = (mg_22_n + {16'd0, rl_22[16]});
    assign rl_23 = r[407:391];
    assign mg_23_n = (rl_23 ^ {17{rl_23[16]}});
    assign mg_23_out = (mg_23_n + {16'd0, rl_23[16]});
    assign rl_24 = r[424:408];
    assign mg_24_n = (rl_24 ^ {17{rl_24[16]}});
    assign mg_24_out = (mg_24_n + {16'd0, rl_24[16]});
    assign rl_25 = r[441:425];
    assign mg_25_n = (rl_25 ^ {17{rl_25[16]}});
    assign mg_25_out = (mg_25_n + {16'd0, rl_25[16]});
    assign rl_26 = r[458:442];
    assign mg_26_n = (rl_26 ^ {17{rl_26[16]}});
    assign mg_26_out = (mg_26_n + {16'd0, rl_26[16]});
    assign rl_27 = r[475:459];
    assign mg_27_n = (rl_27 ^ {17{rl_27[16]}});
    assign mg_27_out = (mg_27_n + {16'd0, rl_27[16]});
    assign rl_28 = r[492:476];
    assign mg_28_n = (rl_28 ^ {17{rl_28[16]}});
    assign mg_28_out = (mg_28_n + {16'd0, rl_28[16]});
    assign rl_29 = r[509:493];
    assign mg_29_n = (rl_29 ^ {17{rl_29[16]}});
    assign mg_29_out = (mg_29_n + {16'd0, rl_29[16]});
    assign rl_30 = r[526:510];
    assign mg_30_n = (rl_30 ^ {17{rl_30[16]}});
    assign mg_30_out = (mg_30_n + {16'd0, rl_30[16]});
    assign rl_31 = r[543:527];
    assign mg_31_n = (rl_31 ^ {17{rl_31[16]}});
    assign mg_31_out = (mg_31_n + {16'd0, rl_31[16]});
    assign c0_0 = (((((mg_0_out | mg_1_out) | mg_2_out) | mg_3_out) | mg_4_out) | mg_5_out);
    assign c0_1 = (((((mg_6_out | mg_7_out) | mg_8_out) | mg_9_out) | mg_10_out) | mg_11_out);
    assign c0_2 = (((((mg_12_out | mg_13_out) | mg_14_out) | mg_15_out) | mg_16_out) | mg_17_out);
    assign c0_3 = (((((mg_18_out | mg_19_out) | mg_20_out) | mg_21_out) | mg_22_out) | mg_23_out);
    assign c0_4 = (((((mg_24_out | mg_25_out) | mg_26_out) | mg_27_out) | mg_28_out) | mg_29_out);
    assign c0_5 = (mg_30_out | mg_31_out);
    assign cpack = {c0_5, c0_4, c0_3, c0_2, c0_1, c0_0};
    assign mlo_c = {((eo ^ 10'd512) > 10'd510), ((eo ^ 10'd512) > 10'd511), ((eo ^ 10'd512) > 10'd512),
                    ((eo ^ 10'd512) > 10'd513), ((eo ^ 10'd512) > 10'd514), ((eo ^ 10'd512) > 10'd515),
                    ((eo ^ 10'd512) > 10'd516), ((eo ^ 10'd512) > 10'd517), ((eo ^ 10'd512) > 10'd518),
                    ((eo ^ 10'd512) > 10'd519), ((eo ^ 10'd512) > 10'd520), ((eo ^ 10'd512) > 10'd521),
                    ((eo ^ 10'd512) > 10'd522), ((eo ^ 10'd512) > 10'd523), ((eo ^ 10'd512) > 10'd524),
                    ((eo ^ 10'd512) > 10'd525), ((eo ^ 10'd512) > 10'd526)};
    assign mhi_c = {((eo ^ 10'd512) >= 10'd766), ((eo ^ 10'd512) >= 10'd767), ((eo ^ 10'd512) >= 10'd768),
                    ((eo ^ 10'd512) >= 10'd769), ((eo ^ 10'd512) >= 10'd770), ((eo ^ 10'd512) >= 10'd771),
                    ((eo ^ 10'd512) >= 10'd772), ((eo ^ 10'd512) >= 10'd773), ((eo ^ 10'd512) >= 10'd774),
                    ((eo ^ 10'd512) >= 10'd775), ((eo ^ 10'd512) >= 10'd776), ((eo ^ 10'd512) >= 10'd777),
                    ((eo ^ 10'd512) >= 10'd778), ((eo ^ 10'd512) >= 10'd779), ((eo ^ 10'd512) >= 10'd780),
                    ((eo ^ 10'd512) >= 10'd781), ((eo ^ 10'd512) >= 10'd782)};
    assign da_0 = cA[16:0];
    assign da_1 = cA[33:17];
    assign da_2 = cA[50:34];
    assign da_3 = cA[67:51];
    assign da_4 = cA[84:68];
    assign da_5 = cA[101:85];
    assign db_0 = cB[16:0];
    assign db_1 = cB[33:17];
    assign db_2 = cB[50:34];
    assign db_3 = cB[67:51];
    assign db_4 = cB[84:68];
    assign db_5 = cB[101:85];
    assign hi = (((((((((((da_0 | da_1) | da_2) | da_3) | da_4) | da_5) | db_0) | db_1) | db_2) | db_3) | db_4) | db_5);
    assign hp_0 = (hi[16:0] != 17'd0);
    assign hp_1 = (hi[16:1] != 16'd0);
    assign hp_2 = (hi[16:2] != 15'd0);
    assign hp_3 = (hi[16:3] != 14'd0);
    assign hp_4 = (hi[16:4] != 13'd0);
    assign hp_5 = (hi[16:5] != 12'd0);
    assign hp_6 = (hi[16:6] != 11'd0);
    assign hp_7 = (hi[16:7] != 10'd0);
    assign hp_8 = (hi[16:8] != 9'd0);
    assign hp_9 = (hi[16:9] != 8'd0);
    assign hp_10 = (hi[16:10] != 7'd0);
    assign hp_11 = (hi[16:11] != 6'd0);
    assign hp_12 = (hi[16:12] != 5'd0);
    assign hp_13 = (hi[16:13] != 4'd0);
    assign hp_14 = (hi[16:14] != 3'd0);
    assign hp_15 = (hi[16:15] != 2'd0);
    assign hp_16 = (hi[16] != 1'd0);
    assign zseg = ((hi & q_mlo) == 17'd0);
    assign e_hi = ((hi & q_mhi) != 17'd0);
    assign oh_c = ((zseg | e_hi) ? 17'd0 :
                  {(~hp_1), (hi[1] & (~hp_2)), (hi[2] & (~hp_3)), (hi[3] & (~hp_4)), (hi[4] & (~hp_5)),
                   (hi[5] & (~hp_6)), (hi[6] & (~hp_7)), (hi[7] & (~hp_8)), (hi[8] & (~hp_9)), (hi[9] & (~hp_10)),
                   (hi[10] & (~hp_11)), (hi[11] & (~hp_12)), (hi[12] & (~hp_13)), (hi[13] & (~hp_14)),
                   (hi[14] & (~hp_15)), (hi[15] & (~hp_16)), hi[16]});
    assign sat_c = (e_hi & (~zseg));
    assign oh_k = {(1'd0 | p_oh_g_0[16]),
                   ((((((((1'd0 | p_oh_g_0[8]) | p_oh_g_0[9]) | p_oh_g_0[10]) | p_oh_g_0[11]) | p_oh_g_0[12])
                    | p_oh_g_0[13]) | p_oh_g_0[14]) | p_oh_g_0[15]),
                   ((((((((1'd0 | p_oh_g_0[4]) | p_oh_g_0[5]) | p_oh_g_0[6]) | p_oh_g_0[7]) | p_oh_g_0[12])
                    | p_oh_g_0[13]) | p_oh_g_0[14]) | p_oh_g_0[15]),
                   ((((((((1'd0 | p_oh_g_0[2]) | p_oh_g_0[3]) | p_oh_g_0[6]) | p_oh_g_0[7]) | p_oh_g_0[10])
                    | p_oh_g_0[11]) | p_oh_g_0[14]) | p_oh_g_0[15]),
                   ((((((((1'd0 | p_oh_g_0[1]) | p_oh_g_0[3]) | p_oh_g_0[5]) | p_oh_g_0[7]) | p_oh_g_0[9])
                    | p_oh_g_0[11]) | p_oh_g_0[13]) | p_oh_g_0[15])};
    assign e_c = (p_zs ? 8'd0 : (p_eh ? 8'd255 : (p_eb - {3'd0, oh_k})));
    assign e = p_e;
    assign nl_0_qr = spc[16:0];
    assign nl_0_xz = (nl_0_qr == 17'd0);
    assign nl_0_cs = ((p_sat_g_0 & (~nl_0_xz)) ? {nl_0_qr[16], {15{(~nl_0_qr[16])}}, 2'd0} : 18'd0);
    assign nl_0_pm = u_pm_0_p;
    assign nl_1_qr = spc[33:17];
    assign nl_1_xz = (nl_1_qr == 17'd0);
    assign nl_1_cs = ((p_sat_g_0 & (~nl_1_xz)) ? {nl_1_qr[16], {15{(~nl_1_qr[16])}}, 2'd0} : 18'd0);
    assign nl_1_pm = u_pm_1_p;
    assign nl_2_qr = spc[50:34];
    assign nl_2_xz = (nl_2_qr == 17'd0);
    assign nl_2_cs = ((p_sat_g_0 & (~nl_2_xz)) ? {nl_2_qr[16], {15{(~nl_2_qr[16])}}, 2'd0} : 18'd0);
    assign nl_2_pm = u_pm_2_p;
    assign nl_3_qr = spc[67:51];
    assign nl_3_xz = (nl_3_qr == 17'd0);
    assign nl_3_cs = ((p_sat_g_0 & (~nl_3_xz)) ? {nl_3_qr[16], {15{(~nl_3_qr[16])}}, 2'd0} : 18'd0);
    assign nl_3_pm = u_pm_3_p;
    assign nl_4_qr = spc[84:68];
    assign nl_4_xz = (nl_4_qr == 17'd0);
    assign nl_4_cs = ((p_sat_g_1 & (~nl_4_xz)) ? {nl_4_qr[16], {15{(~nl_4_qr[16])}}, 2'd0} : 18'd0);
    assign nl_4_pm = u_pm_4_p;
    assign nl_5_qr = spc[101:85];
    assign nl_5_xz = (nl_5_qr == 17'd0);
    assign nl_5_cs = ((p_sat_g_1 & (~nl_5_xz)) ? {nl_5_qr[16], {15{(~nl_5_qr[16])}}, 2'd0} : 18'd0);
    assign nl_5_pm = u_pm_5_p;
    assign nl_6_qr = spc[118:102];
    assign nl_6_xz = (nl_6_qr == 17'd0);
    assign nl_6_cs = ((p_sat_g_1 & (~nl_6_xz)) ? {nl_6_qr[16], {15{(~nl_6_qr[16])}}, 2'd0} : 18'd0);
    assign nl_6_pm = u_pm_6_p;
    assign nl_7_qr = spc[135:119];
    assign nl_7_xz = (nl_7_qr == 17'd0);
    assign nl_7_cs = ((p_sat_g_1 & (~nl_7_xz)) ? {nl_7_qr[16], {15{(~nl_7_qr[16])}}, 2'd0} : 18'd0);
    assign nl_7_pm = u_pm_7_p;
    assign nl_8_qr = spc[152:136];
    assign nl_8_xz = (nl_8_qr == 17'd0);
    assign nl_8_cs = ((p_sat_g_2 & (~nl_8_xz)) ? {nl_8_qr[16], {15{(~nl_8_qr[16])}}, 2'd0} : 18'd0);
    assign nl_8_pm = u_pm_8_p;
    assign nl_9_qr = spc[169:153];
    assign nl_9_xz = (nl_9_qr == 17'd0);
    assign nl_9_cs = ((p_sat_g_2 & (~nl_9_xz)) ? {nl_9_qr[16], {15{(~nl_9_qr[16])}}, 2'd0} : 18'd0);
    assign nl_9_pm = u_pm_9_p;
    assign nl_10_qr = spc[186:170];
    assign nl_10_xz = (nl_10_qr == 17'd0);
    assign nl_10_cs = ((p_sat_g_2 & (~nl_10_xz)) ? {nl_10_qr[16], {15{(~nl_10_qr[16])}}, 2'd0} : 18'd0);
    assign nl_10_pm = u_pm_10_p;
    assign nl_11_qr = spc[203:187];
    assign nl_11_xz = (nl_11_qr == 17'd0);
    assign nl_11_cs = ((p_sat_g_2 & (~nl_11_xz)) ? {nl_11_qr[16], {15{(~nl_11_qr[16])}}, 2'd0} : 18'd0);
    assign nl_11_pm = u_pm_11_p;
    assign nl_12_qr = spc[220:204];
    assign nl_12_xz = (nl_12_qr == 17'd0);
    assign nl_12_cs = ((p_sat_g_3 & (~nl_12_xz)) ? {nl_12_qr[16], {15{(~nl_12_qr[16])}}, 2'd0} : 18'd0);
    assign nl_12_pm = u_pm_12_p;
    assign nl_13_qr = spc[237:221];
    assign nl_13_xz = (nl_13_qr == 17'd0);
    assign nl_13_cs = ((p_sat_g_3 & (~nl_13_xz)) ? {nl_13_qr[16], {15{(~nl_13_qr[16])}}, 2'd0} : 18'd0);
    assign nl_13_pm = u_pm_13_p;
    assign nl_14_qr = spc[254:238];
    assign nl_14_xz = (nl_14_qr == 17'd0);
    assign nl_14_cs = ((p_sat_g_3 & (~nl_14_xz)) ? {nl_14_qr[16], {15{(~nl_14_qr[16])}}, 2'd0} : 18'd0);
    assign nl_14_pm = u_pm_14_p;
    assign nl_15_qr = spc[271:255];
    assign nl_15_xz = (nl_15_qr == 17'd0);
    assign nl_15_cs = ((p_sat_g_3 & (~nl_15_xz)) ? {nl_15_qr[16], {15{(~nl_15_qr[16])}}, 2'd0} : 18'd0);
    assign nl_15_pm = u_pm_15_p;
    assign nl_16_qr = spc[288:272];
    assign nl_16_xz = (nl_16_qr == 17'd0);
    assign nl_16_cs = ((p_sat_g_4 & (~nl_16_xz)) ? {nl_16_qr[16], {15{(~nl_16_qr[16])}}, 2'd0} : 18'd0);
    assign nl_16_pm = u_pm_16_p;
    assign nl_17_qr = spc[305:289];
    assign nl_17_xz = (nl_17_qr == 17'd0);
    assign nl_17_cs = ((p_sat_g_4 & (~nl_17_xz)) ? {nl_17_qr[16], {15{(~nl_17_qr[16])}}, 2'd0} : 18'd0);
    assign nl_17_pm = u_pm_17_p;
    assign nl_18_qr = spc[322:306];
    assign nl_18_xz = (nl_18_qr == 17'd0);
    assign nl_18_cs = ((p_sat_g_4 & (~nl_18_xz)) ? {nl_18_qr[16], {15{(~nl_18_qr[16])}}, 2'd0} : 18'd0);
    assign nl_18_pm = u_pm_18_p;
    assign nl_19_qr = spc[339:323];
    assign nl_19_xz = (nl_19_qr == 17'd0);
    assign nl_19_cs = ((p_sat_g_4 & (~nl_19_xz)) ? {nl_19_qr[16], {15{(~nl_19_qr[16])}}, 2'd0} : 18'd0);
    assign nl_19_pm = u_pm_19_p;
    assign nl_20_qr = spc[356:340];
    assign nl_20_xz = (nl_20_qr == 17'd0);
    assign nl_20_cs = ((p_sat_g_5 & (~nl_20_xz)) ? {nl_20_qr[16], {15{(~nl_20_qr[16])}}, 2'd0} : 18'd0);
    assign nl_20_pm = u_pm_20_p;
    assign nl_21_qr = spc[373:357];
    assign nl_21_xz = (nl_21_qr == 17'd0);
    assign nl_21_cs = ((p_sat_g_5 & (~nl_21_xz)) ? {nl_21_qr[16], {15{(~nl_21_qr[16])}}, 2'd0} : 18'd0);
    assign nl_21_pm = u_pm_21_p;
    assign nl_22_qr = spc[390:374];
    assign nl_22_xz = (nl_22_qr == 17'd0);
    assign nl_22_cs = ((p_sat_g_5 & (~nl_22_xz)) ? {nl_22_qr[16], {15{(~nl_22_qr[16])}}, 2'd0} : 18'd0);
    assign nl_22_pm = u_pm_22_p;
    assign nl_23_qr = spc[407:391];
    assign nl_23_xz = (nl_23_qr == 17'd0);
    assign nl_23_cs = ((p_sat_g_5 & (~nl_23_xz)) ? {nl_23_qr[16], {15{(~nl_23_qr[16])}}, 2'd0} : 18'd0);
    assign nl_23_pm = u_pm_23_p;
    assign nl_24_qr = spc[424:408];
    assign nl_24_xz = (nl_24_qr == 17'd0);
    assign nl_24_cs = ((p_sat_g_6 & (~nl_24_xz)) ? {nl_24_qr[16], {15{(~nl_24_qr[16])}}, 2'd0} : 18'd0);
    assign nl_24_pm = u_pm_24_p;
    assign nl_25_qr = spc[441:425];
    assign nl_25_xz = (nl_25_qr == 17'd0);
    assign nl_25_cs = ((p_sat_g_6 & (~nl_25_xz)) ? {nl_25_qr[16], {15{(~nl_25_qr[16])}}, 2'd0} : 18'd0);
    assign nl_25_pm = u_pm_25_p;
    assign nl_26_qr = spc[458:442];
    assign nl_26_xz = (nl_26_qr == 17'd0);
    assign nl_26_cs = ((p_sat_g_6 & (~nl_26_xz)) ? {nl_26_qr[16], {15{(~nl_26_qr[16])}}, 2'd0} : 18'd0);
    assign nl_26_pm = u_pm_26_p;
    assign nl_27_qr = spc[475:459];
    assign nl_27_xz = (nl_27_qr == 17'd0);
    assign nl_27_cs = ((p_sat_g_6 & (~nl_27_xz)) ? {nl_27_qr[16], {15{(~nl_27_qr[16])}}, 2'd0} : 18'd0);
    assign nl_27_pm = u_pm_27_p;
    assign nl_28_qr = spc[492:476];
    assign nl_28_xz = (nl_28_qr == 17'd0);
    assign nl_28_cs = ((p_sat_g_7 & (~nl_28_xz)) ? {nl_28_qr[16], {15{(~nl_28_qr[16])}}, 2'd0} : 18'd0);
    assign nl_28_pm = u_pm_28_p;
    assign nl_29_qr = spc[509:493];
    assign nl_29_xz = (nl_29_qr == 17'd0);
    assign nl_29_cs = ((p_sat_g_7 & (~nl_29_xz)) ? {nl_29_qr[16], {15{(~nl_29_qr[16])}}, 2'd0} : 18'd0);
    assign nl_29_pm = u_pm_29_p;
    assign nl_30_qr = spc[526:510];
    assign nl_30_xz = (nl_30_qr == 17'd0);
    assign nl_30_cs = ((p_sat_g_7 & (~nl_30_xz)) ? {nl_30_qr[16], {15{(~nl_30_qr[16])}}, 2'd0} : 18'd0);
    assign nl_30_pm = u_pm_30_p;
    assign nl_31_qr = spc[543:527];
    assign nl_31_xz = (nl_31_qr == 17'd0);
    assign nl_31_cs = ((p_sat_g_7 & (~nl_31_xz)) ? {nl_31_qr[16], {15{(~nl_31_qr[16])}}, 2'd0} : 18'd0);
    assign nl_31_pm = u_pm_31_p;
    assign sh_out = {nl_31_pm[17:2], nl_30_pm[17:2], nl_29_pm[17:2], nl_28_pm[17:2], nl_27_pm[17:2], nl_26_pm[17:2],
                     nl_25_pm[17:2], nl_24_pm[17:2], nl_23_pm[17:2], nl_22_pm[17:2], nl_21_pm[17:2], nl_20_pm[17:2],
                     nl_19_pm[17:2], nl_18_pm[17:2], nl_17_pm[17:2], nl_16_pm[17:2], nl_15_pm[17:2], nl_14_pm[17:2],
                     nl_13_pm[17:2], nl_12_pm[17:2], nl_11_pm[17:2], nl_10_pm[17:2], nl_9_pm[17:2], nl_8_pm[17:2],
                     nl_7_pm[17:2], nl_6_pm[17:2], nl_5_pm[17:2], nl_4_pm[17:2], nl_3_pm[17:2], nl_2_pm[17:2],
                     nl_1_pm[17:2], nl_0_pm[17:2]};
    assign f_lo_c = (vS1 ? pq : f_lo);
    assign f = {sh_out[511:496], f_lo_c[511:496], sh_out[495:480], f_lo_c[495:480], sh_out[479:464], f_lo_c[479:464],
                sh_out[463:448], f_lo_c[463:448], sh_out[447:432], f_lo_c[447:432], sh_out[431:416], f_lo_c[431:416],
                sh_out[415:400], f_lo_c[415:400], sh_out[399:384], f_lo_c[399:384], sh_out[383:368], f_lo_c[383:368],
                sh_out[367:352], f_lo_c[367:352], sh_out[351:336], f_lo_c[351:336], sh_out[335:320], f_lo_c[335:320],
                sh_out[319:304], f_lo_c[319:304], sh_out[303:288], f_lo_c[303:288], sh_out[287:272], f_lo_c[287:272],
                sh_out[271:256], f_lo_c[271:256], sh_out[255:240], f_lo_c[255:240], sh_out[239:224], f_lo_c[239:224],
                sh_out[223:208], f_lo_c[223:208], sh_out[207:192], f_lo_c[207:192], sh_out[191:176], f_lo_c[191:176],
                sh_out[175:160], f_lo_c[175:160], sh_out[159:144], f_lo_c[159:144], sh_out[143:128], f_lo_c[143:128],
                sh_out[127:112], f_lo_c[127:112], sh_out[111:96], f_lo_c[111:96], sh_out[95:80], f_lo_c[95:80],
                sh_out[79:64], f_lo_c[79:64], sh_out[63:48], f_lo_c[63:48], sh_out[47:32], f_lo_c[47:32], sh_out[31:16],
                f_lo_c[31:16], sh_out[15:0], f_lo_c[15:0]};
    assign fq = {pq[511:496], f_lo[511:496], pq[495:480], f_lo[495:480], pq[479:464], f_lo[479:464], pq[463:448],
                 f_lo[463:448], pq[447:432], f_lo[447:432], pq[431:416], f_lo[431:416], pq[415:400], f_lo[415:400],
                 pq[399:384], f_lo[399:384], pq[383:368], f_lo[383:368], pq[367:352], f_lo[367:352], pq[351:336],
                 f_lo[351:336], pq[335:320], f_lo[335:320], pq[319:304], f_lo[319:304], pq[303:288], f_lo[303:288],
                 pq[287:272], f_lo[287:272], pq[271:256], f_lo[271:256], pq[255:240], f_lo[255:240], pq[239:224],
                 f_lo[239:224], pq[223:208], f_lo[223:208], pq[207:192], f_lo[207:192], pq[191:176], f_lo[191:176],
                 pq[175:160], f_lo[175:160], pq[159:144], f_lo[159:144], pq[143:128], f_lo[143:128], pq[127:112],
                 f_lo[127:112], pq[111:96], f_lo[111:96], pq[95:80], f_lo[95:80], pq[79:64], f_lo[79:64], pq[63:48],
                 f_lo[63:48], pq[47:32], f_lo[47:32], pq[31:16], f_lo[31:16], pq[15:0], f_lo[15:0]};
    assign ov = vS1;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            cA <= 0;
            rA <= 0;
            q_eo <= 0;
            q_mlo <= 0;
            q_mhi <= 0;
            cB <= 0;
            rB <= 0;
            vC <= 0;
            p_oh_g_0 <= 0;
            p_sat_g_0 <= 0;
            p_oh_g_1 <= 0;
            p_sat_g_1 <= 0;
            p_oh_g_2 <= 0;
            p_sat_g_2 <= 0;
            p_oh_g_3 <= 0;
            p_sat_g_3 <= 0;
            p_oh_g_4 <= 0;
            p_sat_g_4 <= 0;
            p_oh_g_5 <= 0;
            p_sat_g_5 <= 0;
            p_oh_g_6 <= 0;
            p_sat_g_6 <= 0;
            p_oh_g_7 <= 0;
            p_sat_g_7 <= 0;
            p_zs <= 0;
            p_eh <= 0;
            p_eb <= 0;
            spc <= 0;
            sph <= 0;
            vS0 <= 0;
            p_e <= 0;
            f_lo <= 0;
            vS1 <= 0;
        end else begin
            if (en) begin
                if ((rv & (~rph))) begin
                    cA <= cpack;
                    rA <= r;
                    q_eo <= eo;
                    q_mlo <= mlo_c;
                    q_mhi <= mhi_c;
                end
                if ((rv & rph)) begin
                    cB <= cpack;
                    rB <= r;
                end
                vC <= (rv & rph);
                if (vC) begin
                    p_oh_g_0 <= oh_c;
                    p_sat_g_0 <= sat_c;
                    p_oh_g_1 <= oh_c;
                    p_sat_g_1 <= sat_c;
                    p_oh_g_2 <= oh_c;
                    p_sat_g_2 <= sat_c;
                    p_oh_g_3 <= oh_c;
                    p_sat_g_3 <= sat_c;
                    p_oh_g_4 <= oh_c;
                    p_sat_g_4 <= sat_c;
                    p_oh_g_5 <= oh_c;
                    p_sat_g_5 <= sat_c;
                    p_oh_g_6 <= oh_c;
                    p_sat_g_6 <= sat_c;
                    p_oh_g_7 <= oh_c;
                    p_sat_g_7 <= sat_c;
                    p_zs <= zseg;
                    p_eh <= e_hi;
                    p_eb <= (q_eo[7:0] + 8'd2);
                    spc <= rA;
                    sph <= rB;
                end
                vS0 <= vC;
                if (vS0) begin
                    p_e <= e_c;
                    spc <= sph;
                end
                if (vS1) begin
                    f_lo <= pq;
                end
                vS1 <= vS0;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (en) begin
            pq <= sh_out;
        end
    end

    SMul17x17 u_pm_0 (
        .a(nl_0_qr),
        .b(p_oh_g_0),
        .c(nl_0_cs),
        .p(u_pm_0_p)
    );
    SMul17x17 u_pm_1 (
        .a(nl_1_qr),
        .b(p_oh_g_0),
        .c(nl_1_cs),
        .p(u_pm_1_p)
    );
    SMul17x17 u_pm_2 (
        .a(nl_2_qr),
        .b(p_oh_g_0),
        .c(nl_2_cs),
        .p(u_pm_2_p)
    );
    SMul17x17 u_pm_3 (
        .a(nl_3_qr),
        .b(p_oh_g_0),
        .c(nl_3_cs),
        .p(u_pm_3_p)
    );
    SMul17x17 u_pm_4 (
        .a(nl_4_qr),
        .b(p_oh_g_1),
        .c(nl_4_cs),
        .p(u_pm_4_p)
    );
    SMul17x17 u_pm_5 (
        .a(nl_5_qr),
        .b(p_oh_g_1),
        .c(nl_5_cs),
        .p(u_pm_5_p)
    );
    SMul17x17 u_pm_6 (
        .a(nl_6_qr),
        .b(p_oh_g_1),
        .c(nl_6_cs),
        .p(u_pm_6_p)
    );
    SMul17x17 u_pm_7 (
        .a(nl_7_qr),
        .b(p_oh_g_1),
        .c(nl_7_cs),
        .p(u_pm_7_p)
    );
    SMul17x17 u_pm_8 (
        .a(nl_8_qr),
        .b(p_oh_g_2),
        .c(nl_8_cs),
        .p(u_pm_8_p)
    );
    SMul17x17 u_pm_9 (
        .a(nl_9_qr),
        .b(p_oh_g_2),
        .c(nl_9_cs),
        .p(u_pm_9_p)
    );
    SMul17x17 u_pm_10 (
        .a(nl_10_qr),
        .b(p_oh_g_2),
        .c(nl_10_cs),
        .p(u_pm_10_p)
    );
    SMul17x17 u_pm_11 (
        .a(nl_11_qr),
        .b(p_oh_g_2),
        .c(nl_11_cs),
        .p(u_pm_11_p)
    );
    SMul17x17 u_pm_12 (
        .a(nl_12_qr),
        .b(p_oh_g_3),
        .c(nl_12_cs),
        .p(u_pm_12_p)
    );
    SMul17x17 u_pm_13 (
        .a(nl_13_qr),
        .b(p_oh_g_3),
        .c(nl_13_cs),
        .p(u_pm_13_p)
    );
    SMul17x17 u_pm_14 (
        .a(nl_14_qr),
        .b(p_oh_g_3),
        .c(nl_14_cs),
        .p(u_pm_14_p)
    );
    SMul17x17 u_pm_15 (
        .a(nl_15_qr),
        .b(p_oh_g_3),
        .c(nl_15_cs),
        .p(u_pm_15_p)
    );
    SMul17x17 u_pm_16 (
        .a(nl_16_qr),
        .b(p_oh_g_4),
        .c(nl_16_cs),
        .p(u_pm_16_p)
    );
    SMul17x17 u_pm_17 (
        .a(nl_17_qr),
        .b(p_oh_g_4),
        .c(nl_17_cs),
        .p(u_pm_17_p)
    );
    SMul17x17 u_pm_18 (
        .a(nl_18_qr),
        .b(p_oh_g_4),
        .c(nl_18_cs),
        .p(u_pm_18_p)
    );
    SMul17x17 u_pm_19 (
        .a(nl_19_qr),
        .b(p_oh_g_4),
        .c(nl_19_cs),
        .p(u_pm_19_p)
    );
    SMul17x17 u_pm_20 (
        .a(nl_20_qr),
        .b(p_oh_g_5),
        .c(nl_20_cs),
        .p(u_pm_20_p)
    );
    SMul17x17 u_pm_21 (
        .a(nl_21_qr),
        .b(p_oh_g_5),
        .c(nl_21_cs),
        .p(u_pm_21_p)
    );
    SMul17x17 u_pm_22 (
        .a(nl_22_qr),
        .b(p_oh_g_5),
        .c(nl_22_cs),
        .p(u_pm_22_p)
    );
    SMul17x17 u_pm_23 (
        .a(nl_23_qr),
        .b(p_oh_g_5),
        .c(nl_23_cs),
        .p(u_pm_23_p)
    );
    SMul17x17 u_pm_24 (
        .a(nl_24_qr),
        .b(p_oh_g_6),
        .c(nl_24_cs),
        .p(u_pm_24_p)
    );
    SMul17x17 u_pm_25 (
        .a(nl_25_qr),
        .b(p_oh_g_6),
        .c(nl_25_cs),
        .p(u_pm_25_p)
    );
    SMul17x17 u_pm_26 (
        .a(nl_26_qr),
        .b(p_oh_g_6),
        .c(nl_26_cs),
        .p(u_pm_26_p)
    );
    SMul17x17 u_pm_27 (
        .a(nl_27_qr),
        .b(p_oh_g_6),
        .c(nl_27_cs),
        .p(u_pm_27_p)
    );
    SMul17x17 u_pm_28 (
        .a(nl_28_qr),
        .b(p_oh_g_7),
        .c(nl_28_cs),
        .p(u_pm_28_p)
    );
    SMul17x17 u_pm_29 (
        .a(nl_29_qr),
        .b(p_oh_g_7),
        .c(nl_29_cs),
        .p(u_pm_29_p)
    );
    SMul17x17 u_pm_30 (
        .a(nl_30_qr),
        .b(p_oh_g_7),
        .c(nl_30_cs),
        .p(u_pm_30_p)
    );
    SMul17x17 u_pm_31 (
        .a(nl_31_qr),
        .b(p_oh_g_7),
        .c(nl_31_cs),
        .p(u_pm_31_p)
    );
endmodule
