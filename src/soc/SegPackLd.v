module SegPackLd (
    input clk,
    input rst_n,
    input en,
    input start,
    input [63:0] s,
    input [1535:0] m,
    input [511:0] ed,
    output logic [7:0] e,
    output logic [1023:0] f,
    output logic [1023:0] fq,
    output logic ov
);
    logic [7:0] ie_0;
    logic [7:0] ie_1;
    logic [7:0] ie_2;
    logic [7:0] ie_3;
    logic [7:0] ie_4;
    logic [7:0] ie_5;
    logic [7:0] ie_6;
    logic [7:0] ie_7;
    logic [7:0] ie_8;
    logic [7:0] ie_9;
    logic [7:0] ie_10;
    logic [7:0] ie_11;
    logic [7:0] ie_12;
    logic [7:0] ie_13;
    logic [7:0] ie_14;
    logic [7:0] ie_15;
    logic [7:0] ie_16;
    logic [7:0] ie_17;
    logic [7:0] ie_18;
    logic [7:0] ie_19;
    logic [7:0] ie_20;
    logic [7:0] ie_21;
    logic [7:0] ie_22;
    logic [7:0] ie_23;
    logic [7:0] ie_24;
    logic [7:0] ie_25;
    logic [7:0] ie_26;
    logic [7:0] ie_27;
    logic [7:0] ie_28;
    logic [7:0] ie_29;
    logic [7:0] ie_30;
    logic [7:0] ie_31;
    logic [7:0] ie_32;
    logic [7:0] ie_33;
    logic [7:0] ie_34;
    logic [7:0] ie_35;
    logic [7:0] ie_36;
    logic [7:0] ie_37;
    logic [7:0] ie_38;
    logic [7:0] ie_39;
    logic [7:0] ie_40;
    logic [7:0] ie_41;
    logic [7:0] ie_42;
    logic [7:0] ie_43;
    logic [7:0] ie_44;
    logic [7:0] ie_45;
    logic [7:0] ie_46;
    logic [7:0] ie_47;
    logic [7:0] ie_48;
    logic [7:0] ie_49;
    logic [7:0] ie_50;
    logic [7:0] ie_51;
    logic [7:0] ie_52;
    logic [7:0] ie_53;
    logic [7:0] ie_54;
    logic [7:0] ie_55;
    logic [7:0] ie_56;
    logic [7:0] ie_57;
    logic [7:0] ie_58;
    logic [7:0] ie_59;
    logic [7:0] ie_60;
    logic [7:0] ie_61;
    logic [7:0] ie_62;
    logic [7:0] ie_63;
    logic [23:0] im_0;
    logic [23:0] im_1;
    logic [23:0] im_2;
    logic [23:0] im_3;
    logic [23:0] im_4;
    logic [23:0] im_5;
    logic [23:0] im_6;
    logic [23:0] im_7;
    logic [23:0] im_8;
    logic [23:0] im_9;
    logic [23:0] im_10;
    logic [23:0] im_11;
    logic [23:0] im_12;
    logic [23:0] im_13;
    logic [23:0] im_14;
    logic [23:0] im_15;
    logic [23:0] im_16;
    logic [23:0] im_17;
    logic [23:0] im_18;
    logic [23:0] im_19;
    logic [23:0] im_20;
    logic [23:0] im_21;
    logic [23:0] im_22;
    logic [23:0] im_23;
    logic [23:0] im_24;
    logic [23:0] im_25;
    logic [23:0] im_26;
    logic [23:0] im_27;
    logic [23:0] im_28;
    logic [23:0] im_29;
    logic [23:0] im_30;
    logic [23:0] im_31;
    logic [23:0] im_32;
    logic [23:0] im_33;
    logic [23:0] im_34;
    logic [23:0] im_35;
    logic [23:0] im_36;
    logic [23:0] im_37;
    logic [23:0] im_38;
    logic [23:0] im_39;
    logic [23:0] im_40;
    logic [23:0] im_41;
    logic [23:0] im_42;
    logic [23:0] im_43;
    logic [23:0] im_44;
    logic [23:0] im_45;
    logic [23:0] im_46;
    logic [23:0] im_47;
    logic [23:0] im_48;
    logic [23:0] im_49;
    logic [23:0] im_50;
    logic [23:0] im_51;
    logic [23:0] im_52;
    logic [23:0] im_53;
    logic [23:0] im_54;
    logic [23:0] im_55;
    logic [23:0] im_56;
    logic [23:0] im_57;
    logic [23:0] im_58;
    logic [23:0] im_59;
    logic [23:0] im_60;
    logic [23:0] im_61;
    logic [23:0] im_62;
    logic [23:0] im_63;
    logic c_nz;
    logic [9:0] c_eraw;
    logic c_e_hi;
    logic c_e_lo;
    logic [7:0] c_ecl;
    logic c_zseg;
    logic [7:0] c_e;
    logic pge_0_0;
    logic pge_0_1;
    logic pge_0_2;
    logic pge_0_3;
    logic pge_0_4;
    logic pge_0_5;
    logic pge_0_6;
    logic pge_0_7;
    logic pge_0_8;
    logic pge_0_9;
    logic pge_0_10;
    logic pge_0_11;
    logic pge_0_12;
    logic pge_0_13;
    logic pge_0_14;
    logic pge_0_15;
    logic pge_0_16;
    logic pge_0_17;
    logic pge_0_18;
    logic pge_0_19;
    logic pge_0_20;
    logic pge_0_21;
    logic pge_0_22;
    logic pge_0_23;
    logic pge_0_24;
    logic pge_0_25;
    logic pge_0_26;
    logic pge_0_27;
    logic pge_1_0;
    logic pge_1_1;
    logic pge_1_2;
    logic pge_1_3;
    logic pge_1_4;
    logic pge_1_5;
    logic pge_1_6;
    logic pge_1_7;
    logic pge_1_8;
    logic pge_1_9;
    logic pge_1_10;
    logic pge_1_11;
    logic pge_1_12;
    logic pge_1_13;
    logic pge_1_14;
    logic pge_1_15;
    logic pge_1_16;
    logic pge_1_17;
    logic pge_1_18;
    logic pge_1_19;
    logic pge_1_20;
    logic pge_1_21;
    logic pge_1_22;
    logic pge_1_23;
    logic pge_1_24;
    logic pge_1_25;
    logic pge_1_26;
    logic pge_1_27;
    logic pge_2_0;
    logic pge_2_1;
    logic pge_2_2;
    logic pge_2_3;
    logic pge_2_4;
    logic pge_2_5;
    logic pge_2_6;
    logic pge_2_7;
    logic pge_2_8;
    logic pge_2_9;
    logic pge_2_10;
    logic pge_2_11;
    logic pge_2_12;
    logic pge_2_13;
    logic pge_2_14;
    logic pge_2_15;
    logic pge_2_16;
    logic pge_2_17;
    logic pge_2_18;
    logic pge_2_19;
    logic pge_2_20;
    logic pge_2_21;
    logic pge_2_22;
    logic pge_2_23;
    logic pge_2_24;
    logic pge_2_25;
    logic pge_2_26;
    logic pge_2_27;
    logic pge_3_0;
    logic pge_3_1;
    logic pge_3_2;
    logic pge_3_3;
    logic pge_3_4;
    logic pge_3_5;
    logic pge_3_6;
    logic pge_3_7;
    logic pge_3_8;
    logic pge_3_9;
    logic pge_3_10;
    logic pge_3_11;
    logic pge_3_12;
    logic pge_3_13;
    logic pge_3_14;
    logic pge_3_15;
    logic pge_3_16;
    logic pge_3_17;
    logic pge_3_18;
    logic pge_3_19;
    logic pge_3_20;
    logic pge_3_21;
    logic pge_3_22;
    logic pge_3_23;
    logic pge_3_24;
    logic pge_3_25;
    logic pge_3_26;
    logic pge_3_27;
    logic pge_4_0;
    logic pge_4_1;
    logic pge_4_2;
    logic pge_4_3;
    logic pge_4_4;
    logic pge_4_5;
    logic pge_4_6;
    logic pge_4_7;
    logic pge_4_8;
    logic pge_4_9;
    logic pge_4_10;
    logic pge_4_11;
    logic pge_4_12;
    logic pge_4_13;
    logic pge_4_14;
    logic pge_4_15;
    logic pge_4_16;
    logic pge_4_17;
    logic pge_4_18;
    logic pge_4_19;
    logic pge_4_20;
    logic pge_4_21;
    logic pge_4_22;
    logic pge_4_23;
    logic pge_4_24;
    logic pge_4_25;
    logic pge_4_26;
    logic pge_4_27;
    logic pge_5_0;
    logic pge_5_1;
    logic pge_5_2;
    logic pge_5_3;
    logic pge_5_4;
    logic pge_5_5;
    logic pge_5_6;
    logic pge_5_7;
    logic pge_5_8;
    logic pge_5_9;
    logic pge_5_10;
    logic pge_5_11;
    logic pge_5_12;
    logic pge_5_13;
    logic pge_5_14;
    logic pge_5_15;
    logic pge_5_16;
    logic pge_5_17;
    logic pge_5_18;
    logic pge_5_19;
    logic pge_5_20;
    logic pge_5_21;
    logic pge_5_22;
    logic pge_5_23;
    logic pge_5_24;
    logic pge_5_25;
    logic pge_5_26;
    logic pge_5_27;
    logic pge_6_0;
    logic pge_6_1;
    logic pge_6_2;
    logic pge_6_3;
    logic pge_6_4;
    logic pge_6_5;
    logic pge_6_6;
    logic pge_6_7;
    logic pge_6_8;
    logic pge_6_9;
    logic pge_6_10;
    logic pge_6_11;
    logic pge_6_12;
    logic pge_6_13;
    logic pge_6_14;
    logic pge_6_15;
    logic pge_6_16;
    logic pge_6_17;
    logic pge_6_18;
    logic pge_6_19;
    logic pge_6_20;
    logic pge_6_21;
    logic pge_6_22;
    logic pge_6_23;
    logic pge_6_24;
    logic pge_6_25;
    logic pge_6_26;
    logic pge_6_27;
    logic pge_7_0;
    logic pge_7_1;
    logic pge_7_2;
    logic pge_7_3;
    logic pge_7_4;
    logic pge_7_5;
    logic pge_7_6;
    logic pge_7_7;
    logic pge_7_8;
    logic pge_7_9;
    logic pge_7_10;
    logic pge_7_11;
    logic pge_7_12;
    logic pge_7_13;
    logic pge_7_14;
    logic pge_7_15;
    logic pge_7_16;
    logic pge_7_17;
    logic pge_7_18;
    logic pge_7_19;
    logic pge_7_20;
    logic pge_7_21;
    logic pge_7_22;
    logic pge_7_23;
    logic pge_7_24;
    logic pge_7_25;
    logic pge_7_26;
    logic pge_7_27;
    logic [7:0] px2_0;
    logic [7:0] px2_1;
    logic [7:0] px2_2;
    logic [7:0] px2_3;
    logic [7:0] px2_4;
    logic [7:0] px2_5;
    logic [7:0] px2_6;
    logic [7:0] px2_7;
    logic [63:0] pm_pack_c;
    logic [63:0] pm_q;
    logic v0;
    logic [7:0] pmq_0;
    logic [7:0] pmq_1;
    logic [7:0] pmq_2;
    logic [7:0] pmq_3;
    logic [7:0] pmq_4;
    logic [7:0] pmq_5;
    logic [7:0] pmq_6;
    logic [7:0] pmq_7;
    logic qge_0;
    logic qge_1;
    logic qge_2;
    logic qge_3;
    logic qge_4;
    logic qge_5;
    logic qge_6;
    logic qge_7;
    logic qge_8;
    logic qge_9;
    logic qge_10;
    logic qge_11;
    logic qge_12;
    logic qge_13;
    logic qge_14;
    logic qge_15;
    logic qge_16;
    logic qge_17;
    logic qge_18;
    logic qge_19;
    logic qge_20;
    logic qge_21;
    logic qge_22;
    logic qge_23;
    logic qge_24;
    logic qge_25;
    logic qge_26;
    logic qge_27;
    logic [7:0] emax_c;
    logic [7:0] q_emax_g_0;
    logic [7:0] q_emax_g_1;
    logic [7:0] q_emax_g_2;
    logic [7:0] q_emax_g_3;
    logic [7:0] q_emax_g_4;
    logic [7:0] q_emax_g_5;
    logic [7:0] q_emax_g_6;
    logic [7:0] q_emax_g_7;
    logic [7:0] q_e;
    logic zs_g_0;
    logic zs_g_1;
    logic zs_g_2;
    logic zs_g_3;
    logic zs_g_4;
    logic zs_g_5;
    logic zs_g_6;
    logic zs_g_7;
    logic v1;
    logic v2;
    logic v3;
    logic [511:0] f_lo;
    logic [511:0] f_hi_q;
    logic presel;
    logic [23:0] pmk_0;
    logic [23:0] pmk_1;
    logic [23:0] pmk_2;
    logic [23:0] pmk_3;
    logic [23:0] pmk_4;
    logic [23:0] pmk_5;
    logic [23:0] pmk_6;
    logic [23:0] pmk_7;
    logic [23:0] pmk_8;
    logic [23:0] pmk_9;
    logic [23:0] pmk_10;
    logic [23:0] pmk_11;
    logic [23:0] pmk_12;
    logic [23:0] pmk_13;
    logic [23:0] pmk_14;
    logic [23:0] pmk_15;
    logic [23:0] pmk_16;
    logic [23:0] pmk_17;
    logic [23:0] pmk_18;
    logic [23:0] pmk_19;
    logic [23:0] pmk_20;
    logic [23:0] pmk_21;
    logic [23:0] pmk_22;
    logic [23:0] pmk_23;
    logic [23:0] pmk_24;
    logic [23:0] pmk_25;
    logic [23:0] pmk_26;
    logic [23:0] pmk_27;
    logic [23:0] pmk_28;
    logic [23:0] pmk_29;
    logic [23:0] pmk_30;
    logic [23:0] pmk_31;
    logic [7:0] pek_0;
    logic [7:0] pek_1;
    logic [7:0] pek_2;
    logic [7:0] pek_3;
    logic [7:0] pek_4;
    logic [7:0] pek_5;
    logic [7:0] pek_6;
    logic [7:0] pek_7;
    logic [7:0] pek_8;
    logic [7:0] pek_9;
    logic [7:0] pek_10;
    logic [7:0] pek_11;
    logic [7:0] pek_12;
    logic [7:0] pek_13;
    logic [7:0] pek_14;
    logic [7:0] pek_15;
    logic [7:0] pek_16;
    logic [7:0] pek_17;
    logic [7:0] pek_18;
    logic [7:0] pek_19;
    logic [7:0] pek_20;
    logic [7:0] pek_21;
    logic [7:0] pek_22;
    logic [7:0] pek_23;
    logic [7:0] pek_24;
    logic [7:0] pek_25;
    logic [7:0] pek_26;
    logic [7:0] pek_27;
    logic [7:0] pek_28;
    logic [7:0] pek_29;
    logic [7:0] pek_30;
    logic [7:0] pek_31;
    logic psk_0;
    logic psk_1;
    logic psk_2;
    logic psk_3;
    logic psk_4;
    logic psk_5;
    logic psk_6;
    logic psk_7;
    logic psk_8;
    logic psk_9;
    logic psk_10;
    logic psk_11;
    logic psk_12;
    logic psk_13;
    logic psk_14;
    logic psk_15;
    logic psk_16;
    logic psk_17;
    logic psk_18;
    logic psk_19;
    logic psk_20;
    logic psk_21;
    logic psk_22;
    logic psk_23;
    logic psk_24;
    logic psk_25;
    logic psk_26;
    logic psk_27;
    logic psk_28;
    logic psk_29;
    logic psk_30;
    logic psk_31;
    logic [8:0] pre_0_d;
    logic pre_0_dz;
    logic [4:0] pre_0_dc;
    logic [17:0] pre_0_oh;
    logic [8:0] pre_1_d;
    logic pre_1_dz;
    logic [4:0] pre_1_dc;
    logic [17:0] pre_1_oh;
    logic [8:0] pre_2_d;
    logic pre_2_dz;
    logic [4:0] pre_2_dc;
    logic [17:0] pre_2_oh;
    logic [8:0] pre_3_d;
    logic pre_3_dz;
    logic [4:0] pre_3_dc;
    logic [17:0] pre_3_oh;
    logic [8:0] pre_4_d;
    logic pre_4_dz;
    logic [4:0] pre_4_dc;
    logic [17:0] pre_4_oh;
    logic [8:0] pre_5_d;
    logic pre_5_dz;
    logic [4:0] pre_5_dc;
    logic [17:0] pre_5_oh;
    logic [8:0] pre_6_d;
    logic pre_6_dz;
    logic [4:0] pre_6_dc;
    logic [17:0] pre_6_oh;
    logic [8:0] pre_7_d;
    logic pre_7_dz;
    logic [4:0] pre_7_dc;
    logic [17:0] pre_7_oh;
    logic [8:0] pre_8_d;
    logic pre_8_dz;
    logic [4:0] pre_8_dc;
    logic [17:0] pre_8_oh;
    logic [8:0] pre_9_d;
    logic pre_9_dz;
    logic [4:0] pre_9_dc;
    logic [17:0] pre_9_oh;
    logic [8:0] pre_10_d;
    logic pre_10_dz;
    logic [4:0] pre_10_dc;
    logic [17:0] pre_10_oh;
    logic [8:0] pre_11_d;
    logic pre_11_dz;
    logic [4:0] pre_11_dc;
    logic [17:0] pre_11_oh;
    logic [8:0] pre_12_d;
    logic pre_12_dz;
    logic [4:0] pre_12_dc;
    logic [17:0] pre_12_oh;
    logic [8:0] pre_13_d;
    logic pre_13_dz;
    logic [4:0] pre_13_dc;
    logic [17:0] pre_13_oh;
    logic [8:0] pre_14_d;
    logic pre_14_dz;
    logic [4:0] pre_14_dc;
    logic [17:0] pre_14_oh;
    logic [8:0] pre_15_d;
    logic pre_15_dz;
    logic [4:0] pre_15_dc;
    logic [17:0] pre_15_oh;
    logic [8:0] pre_16_d;
    logic pre_16_dz;
    logic [4:0] pre_16_dc;
    logic [17:0] pre_16_oh;
    logic [8:0] pre_17_d;
    logic pre_17_dz;
    logic [4:0] pre_17_dc;
    logic [17:0] pre_17_oh;
    logic [8:0] pre_18_d;
    logic pre_18_dz;
    logic [4:0] pre_18_dc;
    logic [17:0] pre_18_oh;
    logic [8:0] pre_19_d;
    logic pre_19_dz;
    logic [4:0] pre_19_dc;
    logic [17:0] pre_19_oh;
    logic [8:0] pre_20_d;
    logic pre_20_dz;
    logic [4:0] pre_20_dc;
    logic [17:0] pre_20_oh;
    logic [8:0] pre_21_d;
    logic pre_21_dz;
    logic [4:0] pre_21_dc;
    logic [17:0] pre_21_oh;
    logic [8:0] pre_22_d;
    logic pre_22_dz;
    logic [4:0] pre_22_dc;
    logic [17:0] pre_22_oh;
    logic [8:0] pre_23_d;
    logic pre_23_dz;
    logic [4:0] pre_23_dc;
    logic [17:0] pre_23_oh;
    logic [8:0] pre_24_d;
    logic pre_24_dz;
    logic [4:0] pre_24_dc;
    logic [17:0] pre_24_oh;
    logic [8:0] pre_25_d;
    logic pre_25_dz;
    logic [4:0] pre_25_dc;
    logic [17:0] pre_25_oh;
    logic [8:0] pre_26_d;
    logic pre_26_dz;
    logic [4:0] pre_26_dc;
    logic [17:0] pre_26_oh;
    logic [8:0] pre_27_d;
    logic pre_27_dz;
    logic [4:0] pre_27_dc;
    logic [17:0] pre_27_oh;
    logic [8:0] pre_28_d;
    logic pre_28_dz;
    logic [4:0] pre_28_dc;
    logic [17:0] pre_28_oh;
    logic [8:0] pre_29_d;
    logic pre_29_dz;
    logic [4:0] pre_29_dc;
    logic [17:0] pre_29_oh;
    logic [8:0] pre_30_d;
    logic pre_30_dz;
    logic [4:0] pre_30_dc;
    logic [17:0] pre_30_oh;
    logic [8:0] pre_31_d;
    logic pre_31_dz;
    logic [4:0] pre_31_dc;
    logic [17:0] pre_31_oh;
    logic [767:0] pst_m;
    logic [575:0] pst_o;
    logic [31:0] pst_s;
    logic [767:0] pmk_pack;
    logic [575:0] ohs_pack;
    logic [31:0] psk_pack;
    logic [47:0] pp_l_0;
    logic [47:0] pp_l_1;
    logic [47:0] pp_l_2;
    logic [47:0] pp_l_3;
    logic [47:0] pp_l_4;
    logic [47:0] pp_l_5;
    logic [47:0] pp_l_6;
    logic [47:0] pp_l_7;
    logic [47:0] pp_l_8;
    logic [47:0] pp_l_9;
    logic [47:0] pp_l_10;
    logic [47:0] pp_l_11;
    logic [47:0] pp_l_12;
    logic [47:0] pp_l_13;
    logic [47:0] pp_l_14;
    logic [47:0] pp_l_15;
    logic [47:0] pp_l_16;
    logic [47:0] pp_l_17;
    logic [47:0] pp_l_18;
    logic [47:0] pp_l_19;
    logic [47:0] pp_l_20;
    logic [47:0] pp_l_21;
    logic [47:0] pp_l_22;
    logic [47:0] pp_l_23;
    logic [47:0] pp_l_24;
    logic [47:0] pp_l_25;
    logic [47:0] pp_l_26;
    logic [47:0] pp_l_27;
    logic [47:0] pp_l_28;
    logic [47:0] pp_l_29;
    logic [47:0] pp_l_30;
    logic [47:0] pp_l_31;
    logic [15:0] po_l_0;
    logic [15:0] po_l_1;
    logic [15:0] po_l_2;
    logic [15:0] po_l_3;
    logic [15:0] po_l_4;
    logic [15:0] po_l_5;
    logic [15:0] po_l_6;
    logic [15:0] po_l_7;
    logic [15:0] po_l_8;
    logic [15:0] po_l_9;
    logic [15:0] po_l_10;
    logic [15:0] po_l_11;
    logic [15:0] po_l_12;
    logic [15:0] po_l_13;
    logic [15:0] po_l_14;
    logic [15:0] po_l_15;
    logic [15:0] po_l_16;
    logic [15:0] po_l_17;
    logic [15:0] po_l_18;
    logic [15:0] po_l_19;
    logic [15:0] po_l_20;
    logic [15:0] po_l_21;
    logic [15:0] po_l_22;
    logic [15:0] po_l_23;
    logic [15:0] po_l_24;
    logic [15:0] po_l_25;
    logic [15:0] po_l_26;
    logic [15:0] po_l_27;
    logic [15:0] po_l_28;
    logic [15:0] po_l_29;
    logic [15:0] po_l_30;
    logic [15:0] po_l_31;
    logic [511:0] post_out;
    logic [47:0] u_pp_0_p;
    logic [47:0] u_pp_1_p;
    logic [47:0] u_pp_2_p;
    logic [47:0] u_pp_3_p;
    logic [47:0] u_pp_4_p;
    logic [47:0] u_pp_5_p;
    logic [47:0] u_pp_6_p;
    logic [47:0] u_pp_7_p;
    logic [47:0] u_pp_8_p;
    logic [47:0] u_pp_9_p;
    logic [47:0] u_pp_10_p;
    logic [47:0] u_pp_11_p;
    logic [47:0] u_pp_12_p;
    logic [47:0] u_pp_13_p;
    logic [47:0] u_pp_14_p;
    logic [47:0] u_pp_15_p;
    logic [47:0] u_pp_16_p;
    logic [47:0] u_pp_17_p;
    logic [47:0] u_pp_18_p;
    logic [47:0] u_pp_19_p;
    logic [47:0] u_pp_20_p;
    logic [47:0] u_pp_21_p;
    logic [47:0] u_pp_22_p;
    logic [47:0] u_pp_23_p;
    logic [47:0] u_pp_24_p;
    logic [47:0] u_pp_25_p;
    logic [47:0] u_pp_26_p;
    logic [47:0] u_pp_27_p;
    logic [47:0] u_pp_28_p;
    logic [47:0] u_pp_29_p;
    logic [47:0] u_pp_30_p;
    logic [47:0] u_pp_31_p;

    assign ie_0 = ed[7:0];
    assign ie_1 = ed[15:8];
    assign ie_2 = ed[23:16];
    assign ie_3 = ed[31:24];
    assign ie_4 = ed[39:32];
    assign ie_5 = ed[47:40];
    assign ie_6 = ed[55:48];
    assign ie_7 = ed[63:56];
    assign ie_8 = ed[71:64];
    assign ie_9 = ed[79:72];
    assign ie_10 = ed[87:80];
    assign ie_11 = ed[95:88];
    assign ie_12 = ed[103:96];
    assign ie_13 = ed[111:104];
    assign ie_14 = ed[119:112];
    assign ie_15 = ed[127:120];
    assign ie_16 = ed[135:128];
    assign ie_17 = ed[143:136];
    assign ie_18 = ed[151:144];
    assign ie_19 = ed[159:152];
    assign ie_20 = ed[167:160];
    assign ie_21 = ed[175:168];
    assign ie_22 = ed[183:176];
    assign ie_23 = ed[191:184];
    assign ie_24 = ed[199:192];
    assign ie_25 = ed[207:200];
    assign ie_26 = ed[215:208];
    assign ie_27 = ed[223:216];
    assign ie_28 = ed[231:224];
    assign ie_29 = ed[239:232];
    assign ie_30 = ed[247:240];
    assign ie_31 = ed[255:248];
    assign ie_32 = ed[263:256];
    assign ie_33 = ed[271:264];
    assign ie_34 = ed[279:272];
    assign ie_35 = ed[287:280];
    assign ie_36 = ed[295:288];
    assign ie_37 = ed[303:296];
    assign ie_38 = ed[311:304];
    assign ie_39 = ed[319:312];
    assign ie_40 = ed[327:320];
    assign ie_41 = ed[335:328];
    assign ie_42 = ed[343:336];
    assign ie_43 = ed[351:344];
    assign ie_44 = ed[359:352];
    assign ie_45 = ed[367:360];
    assign ie_46 = ed[375:368];
    assign ie_47 = ed[383:376];
    assign ie_48 = ed[391:384];
    assign ie_49 = ed[399:392];
    assign ie_50 = ed[407:400];
    assign ie_51 = ed[415:408];
    assign ie_52 = ed[423:416];
    assign ie_53 = ed[431:424];
    assign ie_54 = ed[439:432];
    assign ie_55 = ed[447:440];
    assign ie_56 = ed[455:448];
    assign ie_57 = ed[463:456];
    assign ie_58 = ed[471:464];
    assign ie_59 = ed[479:472];
    assign ie_60 = ed[487:480];
    assign ie_61 = ed[495:488];
    assign ie_62 = ed[503:496];
    assign ie_63 = ed[511:504];
    assign im_0 = m[23:0];
    assign im_1 = m[47:24];
    assign im_2 = m[71:48];
    assign im_3 = m[95:72];
    assign im_4 = m[119:96];
    assign im_5 = m[143:120];
    assign im_6 = m[167:144];
    assign im_7 = m[191:168];
    assign im_8 = m[215:192];
    assign im_9 = m[239:216];
    assign im_10 = m[263:240];
    assign im_11 = m[287:264];
    assign im_12 = m[311:288];
    assign im_13 = m[335:312];
    assign im_14 = m[359:336];
    assign im_15 = m[383:360];
    assign im_16 = m[407:384];
    assign im_17 = m[431:408];
    assign im_18 = m[455:432];
    assign im_19 = m[479:456];
    assign im_20 = m[503:480];
    assign im_21 = m[527:504];
    assign im_22 = m[551:528];
    assign im_23 = m[575:552];
    assign im_24 = m[599:576];
    assign im_25 = m[623:600];
    assign im_26 = m[647:624];
    assign im_27 = m[671:648];
    assign im_28 = m[695:672];
    assign im_29 = m[719:696];
    assign im_30 = m[743:720];
    assign im_31 = m[767:744];
    assign im_32 = m[791:768];
    assign im_33 = m[815:792];
    assign im_34 = m[839:816];
    assign im_35 = m[863:840];
    assign im_36 = m[887:864];
    assign im_37 = m[911:888];
    assign im_38 = m[935:912];
    assign im_39 = m[959:936];
    assign im_40 = m[983:960];
    assign im_41 = m[1007:984];
    assign im_42 = m[1031:1008];
    assign im_43 = m[1055:1032];
    assign im_44 = m[1079:1056];
    assign im_45 = m[1103:1080];
    assign im_46 = m[1127:1104];
    assign im_47 = m[1151:1128];
    assign im_48 = m[1175:1152];
    assign im_49 = m[1199:1176];
    assign im_50 = m[1223:1200];
    assign im_51 = m[1247:1224];
    assign im_52 = m[1271:1248];
    assign im_53 = m[1295:1272];
    assign im_54 = m[1319:1296];
    assign im_55 = m[1343:1320];
    assign im_56 = m[1367:1344];
    assign im_57 = m[1391:1368];
    assign im_58 = m[1415:1392];
    assign im_59 = m[1439:1416];
    assign im_60 = m[1463:1440];
    assign im_61 = m[1487:1464];
    assign im_62 = m[1511:1488];
    assign im_63 = m[1535:1512];
    assign pge_0_0 = (ie_0 >= ie_1);
    assign pge_0_1 = (ie_0 >= ie_2);
    assign pge_0_2 = (ie_0 >= ie_3);
    assign pge_0_3 = (ie_0 >= ie_4);
    assign pge_0_4 = (ie_0 >= ie_5);
    assign pge_0_5 = (ie_0 >= ie_6);
    assign pge_0_6 = (ie_0 >= ie_7);
    assign pge_0_7 = (ie_1 >= ie_2);
    assign pge_0_8 = (ie_1 >= ie_3);
    assign pge_0_9 = (ie_1 >= ie_4);
    assign pge_0_10 = (ie_1 >= ie_5);
    assign pge_0_11 = (ie_1 >= ie_6);
    assign pge_0_12 = (ie_1 >= ie_7);
    assign pge_0_13 = (ie_2 >= ie_3);
    assign pge_0_14 = (ie_2 >= ie_4);
    assign pge_0_15 = (ie_2 >= ie_5);
    assign pge_0_16 = (ie_2 >= ie_6);
    assign pge_0_17 = (ie_2 >= ie_7);
    assign pge_0_18 = (ie_3 >= ie_4);
    assign pge_0_19 = (ie_3 >= ie_5);
    assign pge_0_20 = (ie_3 >= ie_6);
    assign pge_0_21 = (ie_3 >= ie_7);
    assign pge_0_22 = (ie_4 >= ie_5);
    assign pge_0_23 = (ie_4 >= ie_6);
    assign pge_0_24 = (ie_4 >= ie_7);
    assign pge_0_25 = (ie_5 >= ie_6);
    assign pge_0_26 = (ie_5 >= ie_7);
    assign pge_0_27 = (ie_6 >= ie_7);
    assign pge_1_0 = (ie_8 >= ie_9);
    assign pge_1_1 = (ie_8 >= ie_10);
    assign pge_1_2 = (ie_8 >= ie_11);
    assign pge_1_3 = (ie_8 >= ie_12);
    assign pge_1_4 = (ie_8 >= ie_13);
    assign pge_1_5 = (ie_8 >= ie_14);
    assign pge_1_6 = (ie_8 >= ie_15);
    assign pge_1_7 = (ie_9 >= ie_10);
    assign pge_1_8 = (ie_9 >= ie_11);
    assign pge_1_9 = (ie_9 >= ie_12);
    assign pge_1_10 = (ie_9 >= ie_13);
    assign pge_1_11 = (ie_9 >= ie_14);
    assign pge_1_12 = (ie_9 >= ie_15);
    assign pge_1_13 = (ie_10 >= ie_11);
    assign pge_1_14 = (ie_10 >= ie_12);
    assign pge_1_15 = (ie_10 >= ie_13);
    assign pge_1_16 = (ie_10 >= ie_14);
    assign pge_1_17 = (ie_10 >= ie_15);
    assign pge_1_18 = (ie_11 >= ie_12);
    assign pge_1_19 = (ie_11 >= ie_13);
    assign pge_1_20 = (ie_11 >= ie_14);
    assign pge_1_21 = (ie_11 >= ie_15);
    assign pge_1_22 = (ie_12 >= ie_13);
    assign pge_1_23 = (ie_12 >= ie_14);
    assign pge_1_24 = (ie_12 >= ie_15);
    assign pge_1_25 = (ie_13 >= ie_14);
    assign pge_1_26 = (ie_13 >= ie_15);
    assign pge_1_27 = (ie_14 >= ie_15);
    assign pge_2_0 = (ie_16 >= ie_17);
    assign pge_2_1 = (ie_16 >= ie_18);
    assign pge_2_2 = (ie_16 >= ie_19);
    assign pge_2_3 = (ie_16 >= ie_20);
    assign pge_2_4 = (ie_16 >= ie_21);
    assign pge_2_5 = (ie_16 >= ie_22);
    assign pge_2_6 = (ie_16 >= ie_23);
    assign pge_2_7 = (ie_17 >= ie_18);
    assign pge_2_8 = (ie_17 >= ie_19);
    assign pge_2_9 = (ie_17 >= ie_20);
    assign pge_2_10 = (ie_17 >= ie_21);
    assign pge_2_11 = (ie_17 >= ie_22);
    assign pge_2_12 = (ie_17 >= ie_23);
    assign pge_2_13 = (ie_18 >= ie_19);
    assign pge_2_14 = (ie_18 >= ie_20);
    assign pge_2_15 = (ie_18 >= ie_21);
    assign pge_2_16 = (ie_18 >= ie_22);
    assign pge_2_17 = (ie_18 >= ie_23);
    assign pge_2_18 = (ie_19 >= ie_20);
    assign pge_2_19 = (ie_19 >= ie_21);
    assign pge_2_20 = (ie_19 >= ie_22);
    assign pge_2_21 = (ie_19 >= ie_23);
    assign pge_2_22 = (ie_20 >= ie_21);
    assign pge_2_23 = (ie_20 >= ie_22);
    assign pge_2_24 = (ie_20 >= ie_23);
    assign pge_2_25 = (ie_21 >= ie_22);
    assign pge_2_26 = (ie_21 >= ie_23);
    assign pge_2_27 = (ie_22 >= ie_23);
    assign pge_3_0 = (ie_24 >= ie_25);
    assign pge_3_1 = (ie_24 >= ie_26);
    assign pge_3_2 = (ie_24 >= ie_27);
    assign pge_3_3 = (ie_24 >= ie_28);
    assign pge_3_4 = (ie_24 >= ie_29);
    assign pge_3_5 = (ie_24 >= ie_30);
    assign pge_3_6 = (ie_24 >= ie_31);
    assign pge_3_7 = (ie_25 >= ie_26);
    assign pge_3_8 = (ie_25 >= ie_27);
    assign pge_3_9 = (ie_25 >= ie_28);
    assign pge_3_10 = (ie_25 >= ie_29);
    assign pge_3_11 = (ie_25 >= ie_30);
    assign pge_3_12 = (ie_25 >= ie_31);
    assign pge_3_13 = (ie_26 >= ie_27);
    assign pge_3_14 = (ie_26 >= ie_28);
    assign pge_3_15 = (ie_26 >= ie_29);
    assign pge_3_16 = (ie_26 >= ie_30);
    assign pge_3_17 = (ie_26 >= ie_31);
    assign pge_3_18 = (ie_27 >= ie_28);
    assign pge_3_19 = (ie_27 >= ie_29);
    assign pge_3_20 = (ie_27 >= ie_30);
    assign pge_3_21 = (ie_27 >= ie_31);
    assign pge_3_22 = (ie_28 >= ie_29);
    assign pge_3_23 = (ie_28 >= ie_30);
    assign pge_3_24 = (ie_28 >= ie_31);
    assign pge_3_25 = (ie_29 >= ie_30);
    assign pge_3_26 = (ie_29 >= ie_31);
    assign pge_3_27 = (ie_30 >= ie_31);
    assign pge_4_0 = (ie_32 >= ie_33);
    assign pge_4_1 = (ie_32 >= ie_34);
    assign pge_4_2 = (ie_32 >= ie_35);
    assign pge_4_3 = (ie_32 >= ie_36);
    assign pge_4_4 = (ie_32 >= ie_37);
    assign pge_4_5 = (ie_32 >= ie_38);
    assign pge_4_6 = (ie_32 >= ie_39);
    assign pge_4_7 = (ie_33 >= ie_34);
    assign pge_4_8 = (ie_33 >= ie_35);
    assign pge_4_9 = (ie_33 >= ie_36);
    assign pge_4_10 = (ie_33 >= ie_37);
    assign pge_4_11 = (ie_33 >= ie_38);
    assign pge_4_12 = (ie_33 >= ie_39);
    assign pge_4_13 = (ie_34 >= ie_35);
    assign pge_4_14 = (ie_34 >= ie_36);
    assign pge_4_15 = (ie_34 >= ie_37);
    assign pge_4_16 = (ie_34 >= ie_38);
    assign pge_4_17 = (ie_34 >= ie_39);
    assign pge_4_18 = (ie_35 >= ie_36);
    assign pge_4_19 = (ie_35 >= ie_37);
    assign pge_4_20 = (ie_35 >= ie_38);
    assign pge_4_21 = (ie_35 >= ie_39);
    assign pge_4_22 = (ie_36 >= ie_37);
    assign pge_4_23 = (ie_36 >= ie_38);
    assign pge_4_24 = (ie_36 >= ie_39);
    assign pge_4_25 = (ie_37 >= ie_38);
    assign pge_4_26 = (ie_37 >= ie_39);
    assign pge_4_27 = (ie_38 >= ie_39);
    assign pge_5_0 = (ie_40 >= ie_41);
    assign pge_5_1 = (ie_40 >= ie_42);
    assign pge_5_2 = (ie_40 >= ie_43);
    assign pge_5_3 = (ie_40 >= ie_44);
    assign pge_5_4 = (ie_40 >= ie_45);
    assign pge_5_5 = (ie_40 >= ie_46);
    assign pge_5_6 = (ie_40 >= ie_47);
    assign pge_5_7 = (ie_41 >= ie_42);
    assign pge_5_8 = (ie_41 >= ie_43);
    assign pge_5_9 = (ie_41 >= ie_44);
    assign pge_5_10 = (ie_41 >= ie_45);
    assign pge_5_11 = (ie_41 >= ie_46);
    assign pge_5_12 = (ie_41 >= ie_47);
    assign pge_5_13 = (ie_42 >= ie_43);
    assign pge_5_14 = (ie_42 >= ie_44);
    assign pge_5_15 = (ie_42 >= ie_45);
    assign pge_5_16 = (ie_42 >= ie_46);
    assign pge_5_17 = (ie_42 >= ie_47);
    assign pge_5_18 = (ie_43 >= ie_44);
    assign pge_5_19 = (ie_43 >= ie_45);
    assign pge_5_20 = (ie_43 >= ie_46);
    assign pge_5_21 = (ie_43 >= ie_47);
    assign pge_5_22 = (ie_44 >= ie_45);
    assign pge_5_23 = (ie_44 >= ie_46);
    assign pge_5_24 = (ie_44 >= ie_47);
    assign pge_5_25 = (ie_45 >= ie_46);
    assign pge_5_26 = (ie_45 >= ie_47);
    assign pge_5_27 = (ie_46 >= ie_47);
    assign pge_6_0 = (ie_48 >= ie_49);
    assign pge_6_1 = (ie_48 >= ie_50);
    assign pge_6_2 = (ie_48 >= ie_51);
    assign pge_6_3 = (ie_48 >= ie_52);
    assign pge_6_4 = (ie_48 >= ie_53);
    assign pge_6_5 = (ie_48 >= ie_54);
    assign pge_6_6 = (ie_48 >= ie_55);
    assign pge_6_7 = (ie_49 >= ie_50);
    assign pge_6_8 = (ie_49 >= ie_51);
    assign pge_6_9 = (ie_49 >= ie_52);
    assign pge_6_10 = (ie_49 >= ie_53);
    assign pge_6_11 = (ie_49 >= ie_54);
    assign pge_6_12 = (ie_49 >= ie_55);
    assign pge_6_13 = (ie_50 >= ie_51);
    assign pge_6_14 = (ie_50 >= ie_52);
    assign pge_6_15 = (ie_50 >= ie_53);
    assign pge_6_16 = (ie_50 >= ie_54);
    assign pge_6_17 = (ie_50 >= ie_55);
    assign pge_6_18 = (ie_51 >= ie_52);
    assign pge_6_19 = (ie_51 >= ie_53);
    assign pge_6_20 = (ie_51 >= ie_54);
    assign pge_6_21 = (ie_51 >= ie_55);
    assign pge_6_22 = (ie_52 >= ie_53);
    assign pge_6_23 = (ie_52 >= ie_54);
    assign pge_6_24 = (ie_52 >= ie_55);
    assign pge_6_25 = (ie_53 >= ie_54);
    assign pge_6_26 = (ie_53 >= ie_55);
    assign pge_6_27 = (ie_54 >= ie_55);
    assign pge_7_0 = (ie_56 >= ie_57);
    assign pge_7_1 = (ie_56 >= ie_58);
    assign pge_7_2 = (ie_56 >= ie_59);
    assign pge_7_3 = (ie_56 >= ie_60);
    assign pge_7_4 = (ie_56 >= ie_61);
    assign pge_7_5 = (ie_56 >= ie_62);
    assign pge_7_6 = (ie_56 >= ie_63);
    assign pge_7_7 = (ie_57 >= ie_58);
    assign pge_7_8 = (ie_57 >= ie_59);
    assign pge_7_9 = (ie_57 >= ie_60);
    assign pge_7_10 = (ie_57 >= ie_61);
    assign pge_7_11 = (ie_57 >= ie_62);
    assign pge_7_12 = (ie_57 >= ie_63);
    assign pge_7_13 = (ie_58 >= ie_59);
    assign pge_7_14 = (ie_58 >= ie_60);
    assign pge_7_15 = (ie_58 >= ie_61);
    assign pge_7_16 = (ie_58 >= ie_62);
    assign pge_7_17 = (ie_58 >= ie_63);
    assign pge_7_18 = (ie_59 >= ie_60);
    assign pge_7_19 = (ie_59 >= ie_61);
    assign pge_7_20 = (ie_59 >= ie_62);
    assign pge_7_21 = (ie_59 >= ie_63);
    assign pge_7_22 = (ie_60 >= ie_61);
    assign pge_7_23 = (ie_60 >= ie_62);
    assign pge_7_24 = (ie_60 >= ie_63);
    assign pge_7_25 = (ie_61 >= ie_62);
    assign pge_7_26 = (ie_61 >= ie_63);
    assign pge_7_27 = (ie_62 >= ie_63);
    assign px2_0 = ((((((((8'd0
                    | ((((((((1'd1 & pge_0_0) & pge_0_1) & pge_0_2) & pge_0_3) & pge_0_4) & pge_0_5) & pge_0_6) ? ie_0 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_0)) & pge_0_7) & pge_0_8) & pge_0_9) & pge_0_10) & pge_0_11) & pge_0_12)
                       ? ie_1 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_1)) & (~pge_0_7)) & pge_0_13) & pge_0_14) & pge_0_15) & pge_0_16)
                        & pge_0_17) ? ie_2 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_2)) & (~pge_0_8)) & (~pge_0_13)) & pge_0_18) & pge_0_19) & pge_0_20)
                        & pge_0_21) ? ie_3 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_3)) & (~pge_0_9)) & (~pge_0_14)) & (~pge_0_18)) & pge_0_22) & pge_0_23)
                        & pge_0_24) ? ie_4 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_4)) & (~pge_0_10)) & (~pge_0_15)) & (~pge_0_19)) & (~pge_0_22)) & pge_0_25)
                        & pge_0_26) ? ie_5 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_5)) & (~pge_0_11)) & (~pge_0_16)) & (~pge_0_20)) & (~pge_0_23))
                        & (~pge_0_25)) & pge_0_27) ? ie_6 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_0_6)) & (~pge_0_12)) & (~pge_0_17)) & (~pge_0_21)) & (~pge_0_24))
                        & (~pge_0_26)) & (~pge_0_27)) ? ie_7 :
                      8'd0));
    assign px2_1 = ((((((((8'd0
                    | ((((((((1'd1 & pge_1_0) & pge_1_1) & pge_1_2) & pge_1_3) & pge_1_4) & pge_1_5) & pge_1_6) ? ie_8 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_0)) & pge_1_7) & pge_1_8) & pge_1_9) & pge_1_10) & pge_1_11) & pge_1_12)
                       ? ie_9 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_1)) & (~pge_1_7)) & pge_1_13) & pge_1_14) & pge_1_15) & pge_1_16)
                        & pge_1_17) ? ie_10 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_2)) & (~pge_1_8)) & (~pge_1_13)) & pge_1_18) & pge_1_19) & pge_1_20)
                        & pge_1_21) ? ie_11 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_3)) & (~pge_1_9)) & (~pge_1_14)) & (~pge_1_18)) & pge_1_22) & pge_1_23)
                        & pge_1_24) ? ie_12 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_4)) & (~pge_1_10)) & (~pge_1_15)) & (~pge_1_19)) & (~pge_1_22)) & pge_1_25)
                        & pge_1_26) ? ie_13 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_5)) & (~pge_1_11)) & (~pge_1_16)) & (~pge_1_20)) & (~pge_1_23))
                        & (~pge_1_25)) & pge_1_27) ? ie_14 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_1_6)) & (~pge_1_12)) & (~pge_1_17)) & (~pge_1_21)) & (~pge_1_24))
                        & (~pge_1_26)) & (~pge_1_27)) ? ie_15 :
                      8'd0));
    assign px2_2 = ((((((((8'd0
                    | ((((((((1'd1 & pge_2_0) & pge_2_1) & pge_2_2) & pge_2_3) & pge_2_4) & pge_2_5) & pge_2_6) ? ie_16
                       :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_0)) & pge_2_7) & pge_2_8) & pge_2_9) & pge_2_10) & pge_2_11) & pge_2_12)
                       ? ie_17 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_1)) & (~pge_2_7)) & pge_2_13) & pge_2_14) & pge_2_15) & pge_2_16)
                        & pge_2_17) ? ie_18 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_2)) & (~pge_2_8)) & (~pge_2_13)) & pge_2_18) & pge_2_19) & pge_2_20)
                        & pge_2_21) ? ie_19 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_3)) & (~pge_2_9)) & (~pge_2_14)) & (~pge_2_18)) & pge_2_22) & pge_2_23)
                        & pge_2_24) ? ie_20 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_4)) & (~pge_2_10)) & (~pge_2_15)) & (~pge_2_19)) & (~pge_2_22)) & pge_2_25)
                        & pge_2_26) ? ie_21 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_5)) & (~pge_2_11)) & (~pge_2_16)) & (~pge_2_20)) & (~pge_2_23))
                        & (~pge_2_25)) & pge_2_27) ? ie_22 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_2_6)) & (~pge_2_12)) & (~pge_2_17)) & (~pge_2_21)) & (~pge_2_24))
                        & (~pge_2_26)) & (~pge_2_27)) ? ie_23 :
                      8'd0));
    assign px2_3 = ((((((((8'd0
                    | ((((((((1'd1 & pge_3_0) & pge_3_1) & pge_3_2) & pge_3_3) & pge_3_4) & pge_3_5) & pge_3_6) ? ie_24
                       :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_0)) & pge_3_7) & pge_3_8) & pge_3_9) & pge_3_10) & pge_3_11) & pge_3_12)
                       ? ie_25 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_1)) & (~pge_3_7)) & pge_3_13) & pge_3_14) & pge_3_15) & pge_3_16)
                        & pge_3_17) ? ie_26 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_2)) & (~pge_3_8)) & (~pge_3_13)) & pge_3_18) & pge_3_19) & pge_3_20)
                        & pge_3_21) ? ie_27 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_3)) & (~pge_3_9)) & (~pge_3_14)) & (~pge_3_18)) & pge_3_22) & pge_3_23)
                        & pge_3_24) ? ie_28 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_4)) & (~pge_3_10)) & (~pge_3_15)) & (~pge_3_19)) & (~pge_3_22)) & pge_3_25)
                        & pge_3_26) ? ie_29 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_5)) & (~pge_3_11)) & (~pge_3_16)) & (~pge_3_20)) & (~pge_3_23))
                        & (~pge_3_25)) & pge_3_27) ? ie_30 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_3_6)) & (~pge_3_12)) & (~pge_3_17)) & (~pge_3_21)) & (~pge_3_24))
                        & (~pge_3_26)) & (~pge_3_27)) ? ie_31 :
                      8'd0));
    assign px2_4 = ((((((((8'd0
                    | ((((((((1'd1 & pge_4_0) & pge_4_1) & pge_4_2) & pge_4_3) & pge_4_4) & pge_4_5) & pge_4_6) ? ie_32
                       :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_0)) & pge_4_7) & pge_4_8) & pge_4_9) & pge_4_10) & pge_4_11) & pge_4_12)
                       ? ie_33 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_1)) & (~pge_4_7)) & pge_4_13) & pge_4_14) & pge_4_15) & pge_4_16)
                        & pge_4_17) ? ie_34 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_2)) & (~pge_4_8)) & (~pge_4_13)) & pge_4_18) & pge_4_19) & pge_4_20)
                        & pge_4_21) ? ie_35 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_3)) & (~pge_4_9)) & (~pge_4_14)) & (~pge_4_18)) & pge_4_22) & pge_4_23)
                        & pge_4_24) ? ie_36 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_4)) & (~pge_4_10)) & (~pge_4_15)) & (~pge_4_19)) & (~pge_4_22)) & pge_4_25)
                        & pge_4_26) ? ie_37 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_5)) & (~pge_4_11)) & (~pge_4_16)) & (~pge_4_20)) & (~pge_4_23))
                        & (~pge_4_25)) & pge_4_27) ? ie_38 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_4_6)) & (~pge_4_12)) & (~pge_4_17)) & (~pge_4_21)) & (~pge_4_24))
                        & (~pge_4_26)) & (~pge_4_27)) ? ie_39 :
                      8'd0));
    assign px2_5 = ((((((((8'd0
                    | ((((((((1'd1 & pge_5_0) & pge_5_1) & pge_5_2) & pge_5_3) & pge_5_4) & pge_5_5) & pge_5_6) ? ie_40
                       :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_0)) & pge_5_7) & pge_5_8) & pge_5_9) & pge_5_10) & pge_5_11) & pge_5_12)
                       ? ie_41 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_1)) & (~pge_5_7)) & pge_5_13) & pge_5_14) & pge_5_15) & pge_5_16)
                        & pge_5_17) ? ie_42 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_2)) & (~pge_5_8)) & (~pge_5_13)) & pge_5_18) & pge_5_19) & pge_5_20)
                        & pge_5_21) ? ie_43 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_3)) & (~pge_5_9)) & (~pge_5_14)) & (~pge_5_18)) & pge_5_22) & pge_5_23)
                        & pge_5_24) ? ie_44 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_4)) & (~pge_5_10)) & (~pge_5_15)) & (~pge_5_19)) & (~pge_5_22)) & pge_5_25)
                        & pge_5_26) ? ie_45 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_5)) & (~pge_5_11)) & (~pge_5_16)) & (~pge_5_20)) & (~pge_5_23))
                        & (~pge_5_25)) & pge_5_27) ? ie_46 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_5_6)) & (~pge_5_12)) & (~pge_5_17)) & (~pge_5_21)) & (~pge_5_24))
                        & (~pge_5_26)) & (~pge_5_27)) ? ie_47 :
                      8'd0));
    assign px2_6 = ((((((((8'd0
                    | ((((((((1'd1 & pge_6_0) & pge_6_1) & pge_6_2) & pge_6_3) & pge_6_4) & pge_6_5) & pge_6_6) ? ie_48
                       :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_0)) & pge_6_7) & pge_6_8) & pge_6_9) & pge_6_10) & pge_6_11) & pge_6_12)
                       ? ie_49 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_1)) & (~pge_6_7)) & pge_6_13) & pge_6_14) & pge_6_15) & pge_6_16)
                        & pge_6_17) ? ie_50 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_2)) & (~pge_6_8)) & (~pge_6_13)) & pge_6_18) & pge_6_19) & pge_6_20)
                        & pge_6_21) ? ie_51 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_3)) & (~pge_6_9)) & (~pge_6_14)) & (~pge_6_18)) & pge_6_22) & pge_6_23)
                        & pge_6_24) ? ie_52 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_4)) & (~pge_6_10)) & (~pge_6_15)) & (~pge_6_19)) & (~pge_6_22)) & pge_6_25)
                        & pge_6_26) ? ie_53 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_5)) & (~pge_6_11)) & (~pge_6_16)) & (~pge_6_20)) & (~pge_6_23))
                        & (~pge_6_25)) & pge_6_27) ? ie_54 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_6_6)) & (~pge_6_12)) & (~pge_6_17)) & (~pge_6_21)) & (~pge_6_24))
                        & (~pge_6_26)) & (~pge_6_27)) ? ie_55 :
                      8'd0));
    assign px2_7 = ((((((((8'd0
                    | ((((((((1'd1 & pge_7_0) & pge_7_1) & pge_7_2) & pge_7_3) & pge_7_4) & pge_7_5) & pge_7_6) ? ie_56
                       :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_0)) & pge_7_7) & pge_7_8) & pge_7_9) & pge_7_10) & pge_7_11) & pge_7_12)
                       ? ie_57 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_1)) & (~pge_7_7)) & pge_7_13) & pge_7_14) & pge_7_15) & pge_7_16)
                        & pge_7_17) ? ie_58 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_2)) & (~pge_7_8)) & (~pge_7_13)) & pge_7_18) & pge_7_19) & pge_7_20)
                        & pge_7_21) ? ie_59 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_3)) & (~pge_7_9)) & (~pge_7_14)) & (~pge_7_18)) & pge_7_22) & pge_7_23)
                        & pge_7_24) ? ie_60 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_4)) & (~pge_7_10)) & (~pge_7_15)) & (~pge_7_19)) & (~pge_7_22)) & pge_7_25)
                        & pge_7_26) ? ie_61 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_5)) & (~pge_7_11)) & (~pge_7_16)) & (~pge_7_20)) & (~pge_7_23))
                        & (~pge_7_25)) & pge_7_27) ? ie_62 :
                      8'd0))
                    | ((((((((1'd1 & (~pge_7_6)) & (~pge_7_12)) & (~pge_7_17)) & (~pge_7_21)) & (~pge_7_24))
                        & (~pge_7_26)) & (~pge_7_27)) ? ie_63 :
                      8'd0));
    assign pm_pack_c = {px2_7, px2_6, px2_5, px2_4, px2_3, px2_2, px2_1, px2_0};
    assign pmq_0 = pm_q[7:0];
    assign pmq_1 = pm_q[15:8];
    assign pmq_2 = pm_q[23:16];
    assign pmq_3 = pm_q[31:24];
    assign pmq_4 = pm_q[39:32];
    assign pmq_5 = pm_q[47:40];
    assign pmq_6 = pm_q[55:48];
    assign pmq_7 = pm_q[63:56];
    assign qge_0 = (pmq_0 >= pmq_1);
    assign qge_1 = (pmq_0 >= pmq_2);
    assign qge_2 = (pmq_0 >= pmq_3);
    assign qge_3 = (pmq_0 >= pmq_4);
    assign qge_4 = (pmq_0 >= pmq_5);
    assign qge_5 = (pmq_0 >= pmq_6);
    assign qge_6 = (pmq_0 >= pmq_7);
    assign qge_7 = (pmq_1 >= pmq_2);
    assign qge_8 = (pmq_1 >= pmq_3);
    assign qge_9 = (pmq_1 >= pmq_4);
    assign qge_10 = (pmq_1 >= pmq_5);
    assign qge_11 = (pmq_1 >= pmq_6);
    assign qge_12 = (pmq_1 >= pmq_7);
    assign qge_13 = (pmq_2 >= pmq_3);
    assign qge_14 = (pmq_2 >= pmq_4);
    assign qge_15 = (pmq_2 >= pmq_5);
    assign qge_16 = (pmq_2 >= pmq_6);
    assign qge_17 = (pmq_2 >= pmq_7);
    assign qge_18 = (pmq_3 >= pmq_4);
    assign qge_19 = (pmq_3 >= pmq_5);
    assign qge_20 = (pmq_3 >= pmq_6);
    assign qge_21 = (pmq_3 >= pmq_7);
    assign qge_22 = (pmq_4 >= pmq_5);
    assign qge_23 = (pmq_4 >= pmq_6);
    assign qge_24 = (pmq_4 >= pmq_7);
    assign qge_25 = (pmq_5 >= pmq_6);
    assign qge_26 = (pmq_5 >= pmq_7);
    assign qge_27 = (pmq_6 >= pmq_7);
    assign emax_c = ((((((((8'd0
                     | ((((((((1'd1 & qge_0) & qge_1) & qge_2) & qge_3) & qge_4) & qge_5) & qge_6) ? pmq_0 : 8'd0))
                     | ((((((((1'd1 & (~qge_0)) & qge_7) & qge_8) & qge_9) & qge_10) & qge_11) & qge_12) ? pmq_1 : 8'd0))
                     | ((((((((1'd1 & (~qge_1)) & (~qge_7)) & qge_13) & qge_14) & qge_15) & qge_16) & qge_17) ? pmq_2 :
                       8'd0))
                     | ((((((((1'd1 & (~qge_2)) & (~qge_8)) & (~qge_13)) & qge_18) & qge_19) & qge_20) & qge_21) ? pmq_3
                        :
                       8'd0))
                     | ((((((((1'd1 & (~qge_3)) & (~qge_9)) & (~qge_14)) & (~qge_18)) & qge_22) & qge_23) & qge_24)
                        ? pmq_4 :
                       8'd0))
                     | ((((((((1'd1 & (~qge_4)) & (~qge_10)) & (~qge_15)) & (~qge_19)) & (~qge_22)) & qge_25) & qge_26)
                        ? pmq_5 :
                       8'd0))
                     | ((((((((1'd1 & (~qge_5)) & (~qge_11)) & (~qge_16)) & (~qge_20)) & (~qge_23)) & (~qge_25))
                         & qge_27) ? pmq_6 :
                       8'd0))
                     | ((((((((1'd1 & (~qge_6)) & (~qge_12)) & (~qge_17)) & (~qge_21)) & (~qge_24)) & (~qge_26))
                         & (~qge_27)) ? pmq_7 :
                       8'd0));
    assign c_nz = (q_emax_g_0 != 8'd0);
    assign c_eraw = ({2'd0, q_emax_g_0} + 10'd1);
    assign c_e_hi = ((~c_eraw[9]) & (c_eraw[8] != 1'd0));
    assign c_e_lo = (c_eraw[9] | (c_eraw == 10'd0));
    assign c_ecl = (c_e_hi ? 8'd255 : c_eraw[7:0]);
    assign c_zseg = (c_e_lo | (~c_nz));
    assign c_e = (c_zseg ? 8'd0 : c_ecl);
    assign zs_g_0 = (q_emax_g_0 <= 8'd0);
    assign zs_g_1 = (q_emax_g_1 <= 8'd0);
    assign zs_g_2 = (q_emax_g_2 <= 8'd0);
    assign zs_g_3 = (q_emax_g_3 <= 8'd0);
    assign zs_g_4 = (q_emax_g_4 <= 8'd0);
    assign zs_g_5 = (q_emax_g_5 <= 8'd0);
    assign zs_g_6 = (q_emax_g_6 <= 8'd0);
    assign zs_g_7 = (q_emax_g_7 <= 8'd0);
    assign presel = v2;
    assign pmk_0 = (presel ? im_32 : im_0);
    assign pek_0 = (presel ? ie_32 : ie_0);
    assign psk_0 = (presel ? s[32] : s[0]);
    assign pre_0_d = ({1'd0, q_emax_g_0} - {1'd0, pek_0});
    assign pre_0_dz = (zs_g_0 | (pre_0_d[8:5] != 4'd0));
    assign pre_0_dc = (pre_0_dz ? 5'd31 : pre_0_d[4:0]);
    assign pre_0_oh = {(psk_0 & (pre_0_dc <= 5'd16)),
                       (psk_0 ? ((pre_0_dc >= 5'd0) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd0)),
                       (psk_0 ? ((pre_0_dc >= 5'd1) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd1)),
                       (psk_0 ? ((pre_0_dc >= 5'd2) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd2)),
                       (psk_0 ? ((pre_0_dc >= 5'd3) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd3)),
                       (psk_0 ? ((pre_0_dc >= 5'd4) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd4)),
                       (psk_0 ? ((pre_0_dc >= 5'd5) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd5)),
                       (psk_0 ? ((pre_0_dc >= 5'd6) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd6)),
                       (psk_0 ? ((pre_0_dc >= 5'd7) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd7)),
                       (psk_0 ? ((pre_0_dc >= 5'd8) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd8)),
                       (psk_0 ? ((pre_0_dc >= 5'd9) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd9)),
                       (psk_0 ? ((pre_0_dc >= 5'd10) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd10)),
                       (psk_0 ? ((pre_0_dc >= 5'd11) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd11)),
                       (psk_0 ? ((pre_0_dc >= 5'd12) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd12)),
                       (psk_0 ? ((pre_0_dc >= 5'd13) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd13)),
                       (psk_0 ? ((pre_0_dc >= 5'd14) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd14)),
                       (psk_0 ? ((pre_0_dc >= 5'd15) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd15)),
                       (psk_0 ? ((pre_0_dc >= 5'd16) & (pre_0_dc <= 5'd16)) : (pre_0_dc == 5'd16))};
    assign pmk_1 = (presel ? im_33 : im_1);
    assign pek_1 = (presel ? ie_33 : ie_1);
    assign psk_1 = (presel ? s[33] : s[1]);
    assign pre_1_d = ({1'd0, q_emax_g_0} - {1'd0, pek_1});
    assign pre_1_dz = (zs_g_0 | (pre_1_d[8:5] != 4'd0));
    assign pre_1_dc = (pre_1_dz ? 5'd31 : pre_1_d[4:0]);
    assign pre_1_oh = {(psk_1 & (pre_1_dc <= 5'd16)),
                       (psk_1 ? ((pre_1_dc >= 5'd0) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd0)),
                       (psk_1 ? ((pre_1_dc >= 5'd1) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd1)),
                       (psk_1 ? ((pre_1_dc >= 5'd2) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd2)),
                       (psk_1 ? ((pre_1_dc >= 5'd3) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd3)),
                       (psk_1 ? ((pre_1_dc >= 5'd4) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd4)),
                       (psk_1 ? ((pre_1_dc >= 5'd5) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd5)),
                       (psk_1 ? ((pre_1_dc >= 5'd6) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd6)),
                       (psk_1 ? ((pre_1_dc >= 5'd7) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd7)),
                       (psk_1 ? ((pre_1_dc >= 5'd8) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd8)),
                       (psk_1 ? ((pre_1_dc >= 5'd9) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd9)),
                       (psk_1 ? ((pre_1_dc >= 5'd10) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd10)),
                       (psk_1 ? ((pre_1_dc >= 5'd11) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd11)),
                       (psk_1 ? ((pre_1_dc >= 5'd12) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd12)),
                       (psk_1 ? ((pre_1_dc >= 5'd13) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd13)),
                       (psk_1 ? ((pre_1_dc >= 5'd14) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd14)),
                       (psk_1 ? ((pre_1_dc >= 5'd15) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd15)),
                       (psk_1 ? ((pre_1_dc >= 5'd16) & (pre_1_dc <= 5'd16)) : (pre_1_dc == 5'd16))};
    assign pmk_2 = (presel ? im_34 : im_2);
    assign pek_2 = (presel ? ie_34 : ie_2);
    assign psk_2 = (presel ? s[34] : s[2]);
    assign pre_2_d = ({1'd0, q_emax_g_0} - {1'd0, pek_2});
    assign pre_2_dz = (zs_g_0 | (pre_2_d[8:5] != 4'd0));
    assign pre_2_dc = (pre_2_dz ? 5'd31 : pre_2_d[4:0]);
    assign pre_2_oh = {(psk_2 & (pre_2_dc <= 5'd16)),
                       (psk_2 ? ((pre_2_dc >= 5'd0) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd0)),
                       (psk_2 ? ((pre_2_dc >= 5'd1) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd1)),
                       (psk_2 ? ((pre_2_dc >= 5'd2) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd2)),
                       (psk_2 ? ((pre_2_dc >= 5'd3) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd3)),
                       (psk_2 ? ((pre_2_dc >= 5'd4) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd4)),
                       (psk_2 ? ((pre_2_dc >= 5'd5) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd5)),
                       (psk_2 ? ((pre_2_dc >= 5'd6) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd6)),
                       (psk_2 ? ((pre_2_dc >= 5'd7) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd7)),
                       (psk_2 ? ((pre_2_dc >= 5'd8) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd8)),
                       (psk_2 ? ((pre_2_dc >= 5'd9) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd9)),
                       (psk_2 ? ((pre_2_dc >= 5'd10) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd10)),
                       (psk_2 ? ((pre_2_dc >= 5'd11) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd11)),
                       (psk_2 ? ((pre_2_dc >= 5'd12) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd12)),
                       (psk_2 ? ((pre_2_dc >= 5'd13) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd13)),
                       (psk_2 ? ((pre_2_dc >= 5'd14) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd14)),
                       (psk_2 ? ((pre_2_dc >= 5'd15) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd15)),
                       (psk_2 ? ((pre_2_dc >= 5'd16) & (pre_2_dc <= 5'd16)) : (pre_2_dc == 5'd16))};
    assign pmk_3 = (presel ? im_35 : im_3);
    assign pek_3 = (presel ? ie_35 : ie_3);
    assign psk_3 = (presel ? s[35] : s[3]);
    assign pre_3_d = ({1'd0, q_emax_g_0} - {1'd0, pek_3});
    assign pre_3_dz = (zs_g_0 | (pre_3_d[8:5] != 4'd0));
    assign pre_3_dc = (pre_3_dz ? 5'd31 : pre_3_d[4:0]);
    assign pre_3_oh = {(psk_3 & (pre_3_dc <= 5'd16)),
                       (psk_3 ? ((pre_3_dc >= 5'd0) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd0)),
                       (psk_3 ? ((pre_3_dc >= 5'd1) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd1)),
                       (psk_3 ? ((pre_3_dc >= 5'd2) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd2)),
                       (psk_3 ? ((pre_3_dc >= 5'd3) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd3)),
                       (psk_3 ? ((pre_3_dc >= 5'd4) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd4)),
                       (psk_3 ? ((pre_3_dc >= 5'd5) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd5)),
                       (psk_3 ? ((pre_3_dc >= 5'd6) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd6)),
                       (psk_3 ? ((pre_3_dc >= 5'd7) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd7)),
                       (psk_3 ? ((pre_3_dc >= 5'd8) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd8)),
                       (psk_3 ? ((pre_3_dc >= 5'd9) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd9)),
                       (psk_3 ? ((pre_3_dc >= 5'd10) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd10)),
                       (psk_3 ? ((pre_3_dc >= 5'd11) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd11)),
                       (psk_3 ? ((pre_3_dc >= 5'd12) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd12)),
                       (psk_3 ? ((pre_3_dc >= 5'd13) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd13)),
                       (psk_3 ? ((pre_3_dc >= 5'd14) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd14)),
                       (psk_3 ? ((pre_3_dc >= 5'd15) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd15)),
                       (psk_3 ? ((pre_3_dc >= 5'd16) & (pre_3_dc <= 5'd16)) : (pre_3_dc == 5'd16))};
    assign pmk_4 = (presel ? im_36 : im_4);
    assign pek_4 = (presel ? ie_36 : ie_4);
    assign psk_4 = (presel ? s[36] : s[4]);
    assign pre_4_d = ({1'd0, q_emax_g_1} - {1'd0, pek_4});
    assign pre_4_dz = (zs_g_1 | (pre_4_d[8:5] != 4'd0));
    assign pre_4_dc = (pre_4_dz ? 5'd31 : pre_4_d[4:0]);
    assign pre_4_oh = {(psk_4 & (pre_4_dc <= 5'd16)),
                       (psk_4 ? ((pre_4_dc >= 5'd0) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd0)),
                       (psk_4 ? ((pre_4_dc >= 5'd1) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd1)),
                       (psk_4 ? ((pre_4_dc >= 5'd2) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd2)),
                       (psk_4 ? ((pre_4_dc >= 5'd3) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd3)),
                       (psk_4 ? ((pre_4_dc >= 5'd4) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd4)),
                       (psk_4 ? ((pre_4_dc >= 5'd5) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd5)),
                       (psk_4 ? ((pre_4_dc >= 5'd6) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd6)),
                       (psk_4 ? ((pre_4_dc >= 5'd7) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd7)),
                       (psk_4 ? ((pre_4_dc >= 5'd8) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd8)),
                       (psk_4 ? ((pre_4_dc >= 5'd9) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd9)),
                       (psk_4 ? ((pre_4_dc >= 5'd10) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd10)),
                       (psk_4 ? ((pre_4_dc >= 5'd11) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd11)),
                       (psk_4 ? ((pre_4_dc >= 5'd12) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd12)),
                       (psk_4 ? ((pre_4_dc >= 5'd13) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd13)),
                       (psk_4 ? ((pre_4_dc >= 5'd14) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd14)),
                       (psk_4 ? ((pre_4_dc >= 5'd15) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd15)),
                       (psk_4 ? ((pre_4_dc >= 5'd16) & (pre_4_dc <= 5'd16)) : (pre_4_dc == 5'd16))};
    assign pmk_5 = (presel ? im_37 : im_5);
    assign pek_5 = (presel ? ie_37 : ie_5);
    assign psk_5 = (presel ? s[37] : s[5]);
    assign pre_5_d = ({1'd0, q_emax_g_1} - {1'd0, pek_5});
    assign pre_5_dz = (zs_g_1 | (pre_5_d[8:5] != 4'd0));
    assign pre_5_dc = (pre_5_dz ? 5'd31 : pre_5_d[4:0]);
    assign pre_5_oh = {(psk_5 & (pre_5_dc <= 5'd16)),
                       (psk_5 ? ((pre_5_dc >= 5'd0) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd0)),
                       (psk_5 ? ((pre_5_dc >= 5'd1) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd1)),
                       (psk_5 ? ((pre_5_dc >= 5'd2) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd2)),
                       (psk_5 ? ((pre_5_dc >= 5'd3) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd3)),
                       (psk_5 ? ((pre_5_dc >= 5'd4) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd4)),
                       (psk_5 ? ((pre_5_dc >= 5'd5) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd5)),
                       (psk_5 ? ((pre_5_dc >= 5'd6) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd6)),
                       (psk_5 ? ((pre_5_dc >= 5'd7) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd7)),
                       (psk_5 ? ((pre_5_dc >= 5'd8) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd8)),
                       (psk_5 ? ((pre_5_dc >= 5'd9) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd9)),
                       (psk_5 ? ((pre_5_dc >= 5'd10) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd10)),
                       (psk_5 ? ((pre_5_dc >= 5'd11) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd11)),
                       (psk_5 ? ((pre_5_dc >= 5'd12) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd12)),
                       (psk_5 ? ((pre_5_dc >= 5'd13) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd13)),
                       (psk_5 ? ((pre_5_dc >= 5'd14) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd14)),
                       (psk_5 ? ((pre_5_dc >= 5'd15) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd15)),
                       (psk_5 ? ((pre_5_dc >= 5'd16) & (pre_5_dc <= 5'd16)) : (pre_5_dc == 5'd16))};
    assign pmk_6 = (presel ? im_38 : im_6);
    assign pek_6 = (presel ? ie_38 : ie_6);
    assign psk_6 = (presel ? s[38] : s[6]);
    assign pre_6_d = ({1'd0, q_emax_g_1} - {1'd0, pek_6});
    assign pre_6_dz = (zs_g_1 | (pre_6_d[8:5] != 4'd0));
    assign pre_6_dc = (pre_6_dz ? 5'd31 : pre_6_d[4:0]);
    assign pre_6_oh = {(psk_6 & (pre_6_dc <= 5'd16)),
                       (psk_6 ? ((pre_6_dc >= 5'd0) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd0)),
                       (psk_6 ? ((pre_6_dc >= 5'd1) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd1)),
                       (psk_6 ? ((pre_6_dc >= 5'd2) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd2)),
                       (psk_6 ? ((pre_6_dc >= 5'd3) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd3)),
                       (psk_6 ? ((pre_6_dc >= 5'd4) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd4)),
                       (psk_6 ? ((pre_6_dc >= 5'd5) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd5)),
                       (psk_6 ? ((pre_6_dc >= 5'd6) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd6)),
                       (psk_6 ? ((pre_6_dc >= 5'd7) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd7)),
                       (psk_6 ? ((pre_6_dc >= 5'd8) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd8)),
                       (psk_6 ? ((pre_6_dc >= 5'd9) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd9)),
                       (psk_6 ? ((pre_6_dc >= 5'd10) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd10)),
                       (psk_6 ? ((pre_6_dc >= 5'd11) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd11)),
                       (psk_6 ? ((pre_6_dc >= 5'd12) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd12)),
                       (psk_6 ? ((pre_6_dc >= 5'd13) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd13)),
                       (psk_6 ? ((pre_6_dc >= 5'd14) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd14)),
                       (psk_6 ? ((pre_6_dc >= 5'd15) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd15)),
                       (psk_6 ? ((pre_6_dc >= 5'd16) & (pre_6_dc <= 5'd16)) : (pre_6_dc == 5'd16))};
    assign pmk_7 = (presel ? im_39 : im_7);
    assign pek_7 = (presel ? ie_39 : ie_7);
    assign psk_7 = (presel ? s[39] : s[7]);
    assign pre_7_d = ({1'd0, q_emax_g_1} - {1'd0, pek_7});
    assign pre_7_dz = (zs_g_1 | (pre_7_d[8:5] != 4'd0));
    assign pre_7_dc = (pre_7_dz ? 5'd31 : pre_7_d[4:0]);
    assign pre_7_oh = {(psk_7 & (pre_7_dc <= 5'd16)),
                       (psk_7 ? ((pre_7_dc >= 5'd0) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd0)),
                       (psk_7 ? ((pre_7_dc >= 5'd1) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd1)),
                       (psk_7 ? ((pre_7_dc >= 5'd2) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd2)),
                       (psk_7 ? ((pre_7_dc >= 5'd3) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd3)),
                       (psk_7 ? ((pre_7_dc >= 5'd4) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd4)),
                       (psk_7 ? ((pre_7_dc >= 5'd5) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd5)),
                       (psk_7 ? ((pre_7_dc >= 5'd6) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd6)),
                       (psk_7 ? ((pre_7_dc >= 5'd7) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd7)),
                       (psk_7 ? ((pre_7_dc >= 5'd8) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd8)),
                       (psk_7 ? ((pre_7_dc >= 5'd9) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd9)),
                       (psk_7 ? ((pre_7_dc >= 5'd10) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd10)),
                       (psk_7 ? ((pre_7_dc >= 5'd11) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd11)),
                       (psk_7 ? ((pre_7_dc >= 5'd12) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd12)),
                       (psk_7 ? ((pre_7_dc >= 5'd13) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd13)),
                       (psk_7 ? ((pre_7_dc >= 5'd14) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd14)),
                       (psk_7 ? ((pre_7_dc >= 5'd15) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd15)),
                       (psk_7 ? ((pre_7_dc >= 5'd16) & (pre_7_dc <= 5'd16)) : (pre_7_dc == 5'd16))};
    assign pmk_8 = (presel ? im_40 : im_8);
    assign pek_8 = (presel ? ie_40 : ie_8);
    assign psk_8 = (presel ? s[40] : s[8]);
    assign pre_8_d = ({1'd0, q_emax_g_2} - {1'd0, pek_8});
    assign pre_8_dz = (zs_g_2 | (pre_8_d[8:5] != 4'd0));
    assign pre_8_dc = (pre_8_dz ? 5'd31 : pre_8_d[4:0]);
    assign pre_8_oh = {(psk_8 & (pre_8_dc <= 5'd16)),
                       (psk_8 ? ((pre_8_dc >= 5'd0) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd0)),
                       (psk_8 ? ((pre_8_dc >= 5'd1) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd1)),
                       (psk_8 ? ((pre_8_dc >= 5'd2) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd2)),
                       (psk_8 ? ((pre_8_dc >= 5'd3) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd3)),
                       (psk_8 ? ((pre_8_dc >= 5'd4) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd4)),
                       (psk_8 ? ((pre_8_dc >= 5'd5) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd5)),
                       (psk_8 ? ((pre_8_dc >= 5'd6) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd6)),
                       (psk_8 ? ((pre_8_dc >= 5'd7) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd7)),
                       (psk_8 ? ((pre_8_dc >= 5'd8) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd8)),
                       (psk_8 ? ((pre_8_dc >= 5'd9) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd9)),
                       (psk_8 ? ((pre_8_dc >= 5'd10) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd10)),
                       (psk_8 ? ((pre_8_dc >= 5'd11) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd11)),
                       (psk_8 ? ((pre_8_dc >= 5'd12) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd12)),
                       (psk_8 ? ((pre_8_dc >= 5'd13) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd13)),
                       (psk_8 ? ((pre_8_dc >= 5'd14) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd14)),
                       (psk_8 ? ((pre_8_dc >= 5'd15) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd15)),
                       (psk_8 ? ((pre_8_dc >= 5'd16) & (pre_8_dc <= 5'd16)) : (pre_8_dc == 5'd16))};
    assign pmk_9 = (presel ? im_41 : im_9);
    assign pek_9 = (presel ? ie_41 : ie_9);
    assign psk_9 = (presel ? s[41] : s[9]);
    assign pre_9_d = ({1'd0, q_emax_g_2} - {1'd0, pek_9});
    assign pre_9_dz = (zs_g_2 | (pre_9_d[8:5] != 4'd0));
    assign pre_9_dc = (pre_9_dz ? 5'd31 : pre_9_d[4:0]);
    assign pre_9_oh = {(psk_9 & (pre_9_dc <= 5'd16)),
                       (psk_9 ? ((pre_9_dc >= 5'd0) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd0)),
                       (psk_9 ? ((pre_9_dc >= 5'd1) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd1)),
                       (psk_9 ? ((pre_9_dc >= 5'd2) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd2)),
                       (psk_9 ? ((pre_9_dc >= 5'd3) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd3)),
                       (psk_9 ? ((pre_9_dc >= 5'd4) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd4)),
                       (psk_9 ? ((pre_9_dc >= 5'd5) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd5)),
                       (psk_9 ? ((pre_9_dc >= 5'd6) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd6)),
                       (psk_9 ? ((pre_9_dc >= 5'd7) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd7)),
                       (psk_9 ? ((pre_9_dc >= 5'd8) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd8)),
                       (psk_9 ? ((pre_9_dc >= 5'd9) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd9)),
                       (psk_9 ? ((pre_9_dc >= 5'd10) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd10)),
                       (psk_9 ? ((pre_9_dc >= 5'd11) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd11)),
                       (psk_9 ? ((pre_9_dc >= 5'd12) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd12)),
                       (psk_9 ? ((pre_9_dc >= 5'd13) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd13)),
                       (psk_9 ? ((pre_9_dc >= 5'd14) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd14)),
                       (psk_9 ? ((pre_9_dc >= 5'd15) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd15)),
                       (psk_9 ? ((pre_9_dc >= 5'd16) & (pre_9_dc <= 5'd16)) : (pre_9_dc == 5'd16))};
    assign pmk_10 = (presel ? im_42 : im_10);
    assign pek_10 = (presel ? ie_42 : ie_10);
    assign psk_10 = (presel ? s[42] : s[10]);
    assign pre_10_d = ({1'd0, q_emax_g_2} - {1'd0, pek_10});
    assign pre_10_dz = (zs_g_2 | (pre_10_d[8:5] != 4'd0));
    assign pre_10_dc = (pre_10_dz ? 5'd31 : pre_10_d[4:0]);
    assign pre_10_oh = {(psk_10 & (pre_10_dc <= 5'd16)),
                        (psk_10 ? ((pre_10_dc >= 5'd0) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd0)),
                        (psk_10 ? ((pre_10_dc >= 5'd1) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd1)),
                        (psk_10 ? ((pre_10_dc >= 5'd2) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd2)),
                        (psk_10 ? ((pre_10_dc >= 5'd3) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd3)),
                        (psk_10 ? ((pre_10_dc >= 5'd4) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd4)),
                        (psk_10 ? ((pre_10_dc >= 5'd5) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd5)),
                        (psk_10 ? ((pre_10_dc >= 5'd6) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd6)),
                        (psk_10 ? ((pre_10_dc >= 5'd7) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd7)),
                        (psk_10 ? ((pre_10_dc >= 5'd8) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd8)),
                        (psk_10 ? ((pre_10_dc >= 5'd9) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd9)),
                        (psk_10 ? ((pre_10_dc >= 5'd10) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd10)),
                        (psk_10 ? ((pre_10_dc >= 5'd11) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd11)),
                        (psk_10 ? ((pre_10_dc >= 5'd12) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd12)),
                        (psk_10 ? ((pre_10_dc >= 5'd13) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd13)),
                        (psk_10 ? ((pre_10_dc >= 5'd14) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd14)),
                        (psk_10 ? ((pre_10_dc >= 5'd15) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd15)),
                        (psk_10 ? ((pre_10_dc >= 5'd16) & (pre_10_dc <= 5'd16)) : (pre_10_dc == 5'd16))};
    assign pmk_11 = (presel ? im_43 : im_11);
    assign pek_11 = (presel ? ie_43 : ie_11);
    assign psk_11 = (presel ? s[43] : s[11]);
    assign pre_11_d = ({1'd0, q_emax_g_2} - {1'd0, pek_11});
    assign pre_11_dz = (zs_g_2 | (pre_11_d[8:5] != 4'd0));
    assign pre_11_dc = (pre_11_dz ? 5'd31 : pre_11_d[4:0]);
    assign pre_11_oh = {(psk_11 & (pre_11_dc <= 5'd16)),
                        (psk_11 ? ((pre_11_dc >= 5'd0) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd0)),
                        (psk_11 ? ((pre_11_dc >= 5'd1) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd1)),
                        (psk_11 ? ((pre_11_dc >= 5'd2) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd2)),
                        (psk_11 ? ((pre_11_dc >= 5'd3) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd3)),
                        (psk_11 ? ((pre_11_dc >= 5'd4) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd4)),
                        (psk_11 ? ((pre_11_dc >= 5'd5) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd5)),
                        (psk_11 ? ((pre_11_dc >= 5'd6) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd6)),
                        (psk_11 ? ((pre_11_dc >= 5'd7) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd7)),
                        (psk_11 ? ((pre_11_dc >= 5'd8) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd8)),
                        (psk_11 ? ((pre_11_dc >= 5'd9) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd9)),
                        (psk_11 ? ((pre_11_dc >= 5'd10) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd10)),
                        (psk_11 ? ((pre_11_dc >= 5'd11) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd11)),
                        (psk_11 ? ((pre_11_dc >= 5'd12) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd12)),
                        (psk_11 ? ((pre_11_dc >= 5'd13) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd13)),
                        (psk_11 ? ((pre_11_dc >= 5'd14) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd14)),
                        (psk_11 ? ((pre_11_dc >= 5'd15) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd15)),
                        (psk_11 ? ((pre_11_dc >= 5'd16) & (pre_11_dc <= 5'd16)) : (pre_11_dc == 5'd16))};
    assign pmk_12 = (presel ? im_44 : im_12);
    assign pek_12 = (presel ? ie_44 : ie_12);
    assign psk_12 = (presel ? s[44] : s[12]);
    assign pre_12_d = ({1'd0, q_emax_g_3} - {1'd0, pek_12});
    assign pre_12_dz = (zs_g_3 | (pre_12_d[8:5] != 4'd0));
    assign pre_12_dc = (pre_12_dz ? 5'd31 : pre_12_d[4:0]);
    assign pre_12_oh = {(psk_12 & (pre_12_dc <= 5'd16)),
                        (psk_12 ? ((pre_12_dc >= 5'd0) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd0)),
                        (psk_12 ? ((pre_12_dc >= 5'd1) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd1)),
                        (psk_12 ? ((pre_12_dc >= 5'd2) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd2)),
                        (psk_12 ? ((pre_12_dc >= 5'd3) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd3)),
                        (psk_12 ? ((pre_12_dc >= 5'd4) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd4)),
                        (psk_12 ? ((pre_12_dc >= 5'd5) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd5)),
                        (psk_12 ? ((pre_12_dc >= 5'd6) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd6)),
                        (psk_12 ? ((pre_12_dc >= 5'd7) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd7)),
                        (psk_12 ? ((pre_12_dc >= 5'd8) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd8)),
                        (psk_12 ? ((pre_12_dc >= 5'd9) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd9)),
                        (psk_12 ? ((pre_12_dc >= 5'd10) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd10)),
                        (psk_12 ? ((pre_12_dc >= 5'd11) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd11)),
                        (psk_12 ? ((pre_12_dc >= 5'd12) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd12)),
                        (psk_12 ? ((pre_12_dc >= 5'd13) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd13)),
                        (psk_12 ? ((pre_12_dc >= 5'd14) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd14)),
                        (psk_12 ? ((pre_12_dc >= 5'd15) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd15)),
                        (psk_12 ? ((pre_12_dc >= 5'd16) & (pre_12_dc <= 5'd16)) : (pre_12_dc == 5'd16))};
    assign pmk_13 = (presel ? im_45 : im_13);
    assign pek_13 = (presel ? ie_45 : ie_13);
    assign psk_13 = (presel ? s[45] : s[13]);
    assign pre_13_d = ({1'd0, q_emax_g_3} - {1'd0, pek_13});
    assign pre_13_dz = (zs_g_3 | (pre_13_d[8:5] != 4'd0));
    assign pre_13_dc = (pre_13_dz ? 5'd31 : pre_13_d[4:0]);
    assign pre_13_oh = {(psk_13 & (pre_13_dc <= 5'd16)),
                        (psk_13 ? ((pre_13_dc >= 5'd0) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd0)),
                        (psk_13 ? ((pre_13_dc >= 5'd1) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd1)),
                        (psk_13 ? ((pre_13_dc >= 5'd2) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd2)),
                        (psk_13 ? ((pre_13_dc >= 5'd3) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd3)),
                        (psk_13 ? ((pre_13_dc >= 5'd4) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd4)),
                        (psk_13 ? ((pre_13_dc >= 5'd5) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd5)),
                        (psk_13 ? ((pre_13_dc >= 5'd6) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd6)),
                        (psk_13 ? ((pre_13_dc >= 5'd7) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd7)),
                        (psk_13 ? ((pre_13_dc >= 5'd8) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd8)),
                        (psk_13 ? ((pre_13_dc >= 5'd9) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd9)),
                        (psk_13 ? ((pre_13_dc >= 5'd10) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd10)),
                        (psk_13 ? ((pre_13_dc >= 5'd11) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd11)),
                        (psk_13 ? ((pre_13_dc >= 5'd12) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd12)),
                        (psk_13 ? ((pre_13_dc >= 5'd13) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd13)),
                        (psk_13 ? ((pre_13_dc >= 5'd14) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd14)),
                        (psk_13 ? ((pre_13_dc >= 5'd15) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd15)),
                        (psk_13 ? ((pre_13_dc >= 5'd16) & (pre_13_dc <= 5'd16)) : (pre_13_dc == 5'd16))};
    assign pmk_14 = (presel ? im_46 : im_14);
    assign pek_14 = (presel ? ie_46 : ie_14);
    assign psk_14 = (presel ? s[46] : s[14]);
    assign pre_14_d = ({1'd0, q_emax_g_3} - {1'd0, pek_14});
    assign pre_14_dz = (zs_g_3 | (pre_14_d[8:5] != 4'd0));
    assign pre_14_dc = (pre_14_dz ? 5'd31 : pre_14_d[4:0]);
    assign pre_14_oh = {(psk_14 & (pre_14_dc <= 5'd16)),
                        (psk_14 ? ((pre_14_dc >= 5'd0) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd0)),
                        (psk_14 ? ((pre_14_dc >= 5'd1) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd1)),
                        (psk_14 ? ((pre_14_dc >= 5'd2) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd2)),
                        (psk_14 ? ((pre_14_dc >= 5'd3) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd3)),
                        (psk_14 ? ((pre_14_dc >= 5'd4) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd4)),
                        (psk_14 ? ((pre_14_dc >= 5'd5) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd5)),
                        (psk_14 ? ((pre_14_dc >= 5'd6) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd6)),
                        (psk_14 ? ((pre_14_dc >= 5'd7) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd7)),
                        (psk_14 ? ((pre_14_dc >= 5'd8) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd8)),
                        (psk_14 ? ((pre_14_dc >= 5'd9) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd9)),
                        (psk_14 ? ((pre_14_dc >= 5'd10) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd10)),
                        (psk_14 ? ((pre_14_dc >= 5'd11) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd11)),
                        (psk_14 ? ((pre_14_dc >= 5'd12) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd12)),
                        (psk_14 ? ((pre_14_dc >= 5'd13) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd13)),
                        (psk_14 ? ((pre_14_dc >= 5'd14) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd14)),
                        (psk_14 ? ((pre_14_dc >= 5'd15) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd15)),
                        (psk_14 ? ((pre_14_dc >= 5'd16) & (pre_14_dc <= 5'd16)) : (pre_14_dc == 5'd16))};
    assign pmk_15 = (presel ? im_47 : im_15);
    assign pek_15 = (presel ? ie_47 : ie_15);
    assign psk_15 = (presel ? s[47] : s[15]);
    assign pre_15_d = ({1'd0, q_emax_g_3} - {1'd0, pek_15});
    assign pre_15_dz = (zs_g_3 | (pre_15_d[8:5] != 4'd0));
    assign pre_15_dc = (pre_15_dz ? 5'd31 : pre_15_d[4:0]);
    assign pre_15_oh = {(psk_15 & (pre_15_dc <= 5'd16)),
                        (psk_15 ? ((pre_15_dc >= 5'd0) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd0)),
                        (psk_15 ? ((pre_15_dc >= 5'd1) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd1)),
                        (psk_15 ? ((pre_15_dc >= 5'd2) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd2)),
                        (psk_15 ? ((pre_15_dc >= 5'd3) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd3)),
                        (psk_15 ? ((pre_15_dc >= 5'd4) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd4)),
                        (psk_15 ? ((pre_15_dc >= 5'd5) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd5)),
                        (psk_15 ? ((pre_15_dc >= 5'd6) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd6)),
                        (psk_15 ? ((pre_15_dc >= 5'd7) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd7)),
                        (psk_15 ? ((pre_15_dc >= 5'd8) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd8)),
                        (psk_15 ? ((pre_15_dc >= 5'd9) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd9)),
                        (psk_15 ? ((pre_15_dc >= 5'd10) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd10)),
                        (psk_15 ? ((pre_15_dc >= 5'd11) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd11)),
                        (psk_15 ? ((pre_15_dc >= 5'd12) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd12)),
                        (psk_15 ? ((pre_15_dc >= 5'd13) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd13)),
                        (psk_15 ? ((pre_15_dc >= 5'd14) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd14)),
                        (psk_15 ? ((pre_15_dc >= 5'd15) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd15)),
                        (psk_15 ? ((pre_15_dc >= 5'd16) & (pre_15_dc <= 5'd16)) : (pre_15_dc == 5'd16))};
    assign pmk_16 = (presel ? im_48 : im_16);
    assign pek_16 = (presel ? ie_48 : ie_16);
    assign psk_16 = (presel ? s[48] : s[16]);
    assign pre_16_d = ({1'd0, q_emax_g_4} - {1'd0, pek_16});
    assign pre_16_dz = (zs_g_4 | (pre_16_d[8:5] != 4'd0));
    assign pre_16_dc = (pre_16_dz ? 5'd31 : pre_16_d[4:0]);
    assign pre_16_oh = {(psk_16 & (pre_16_dc <= 5'd16)),
                        (psk_16 ? ((pre_16_dc >= 5'd0) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd0)),
                        (psk_16 ? ((pre_16_dc >= 5'd1) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd1)),
                        (psk_16 ? ((pre_16_dc >= 5'd2) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd2)),
                        (psk_16 ? ((pre_16_dc >= 5'd3) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd3)),
                        (psk_16 ? ((pre_16_dc >= 5'd4) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd4)),
                        (psk_16 ? ((pre_16_dc >= 5'd5) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd5)),
                        (psk_16 ? ((pre_16_dc >= 5'd6) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd6)),
                        (psk_16 ? ((pre_16_dc >= 5'd7) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd7)),
                        (psk_16 ? ((pre_16_dc >= 5'd8) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd8)),
                        (psk_16 ? ((pre_16_dc >= 5'd9) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd9)),
                        (psk_16 ? ((pre_16_dc >= 5'd10) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd10)),
                        (psk_16 ? ((pre_16_dc >= 5'd11) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd11)),
                        (psk_16 ? ((pre_16_dc >= 5'd12) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd12)),
                        (psk_16 ? ((pre_16_dc >= 5'd13) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd13)),
                        (psk_16 ? ((pre_16_dc >= 5'd14) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd14)),
                        (psk_16 ? ((pre_16_dc >= 5'd15) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd15)),
                        (psk_16 ? ((pre_16_dc >= 5'd16) & (pre_16_dc <= 5'd16)) : (pre_16_dc == 5'd16))};
    assign pmk_17 = (presel ? im_49 : im_17);
    assign pek_17 = (presel ? ie_49 : ie_17);
    assign psk_17 = (presel ? s[49] : s[17]);
    assign pre_17_d = ({1'd0, q_emax_g_4} - {1'd0, pek_17});
    assign pre_17_dz = (zs_g_4 | (pre_17_d[8:5] != 4'd0));
    assign pre_17_dc = (pre_17_dz ? 5'd31 : pre_17_d[4:0]);
    assign pre_17_oh = {(psk_17 & (pre_17_dc <= 5'd16)),
                        (psk_17 ? ((pre_17_dc >= 5'd0) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd0)),
                        (psk_17 ? ((pre_17_dc >= 5'd1) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd1)),
                        (psk_17 ? ((pre_17_dc >= 5'd2) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd2)),
                        (psk_17 ? ((pre_17_dc >= 5'd3) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd3)),
                        (psk_17 ? ((pre_17_dc >= 5'd4) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd4)),
                        (psk_17 ? ((pre_17_dc >= 5'd5) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd5)),
                        (psk_17 ? ((pre_17_dc >= 5'd6) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd6)),
                        (psk_17 ? ((pre_17_dc >= 5'd7) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd7)),
                        (psk_17 ? ((pre_17_dc >= 5'd8) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd8)),
                        (psk_17 ? ((pre_17_dc >= 5'd9) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd9)),
                        (psk_17 ? ((pre_17_dc >= 5'd10) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd10)),
                        (psk_17 ? ((pre_17_dc >= 5'd11) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd11)),
                        (psk_17 ? ((pre_17_dc >= 5'd12) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd12)),
                        (psk_17 ? ((pre_17_dc >= 5'd13) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd13)),
                        (psk_17 ? ((pre_17_dc >= 5'd14) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd14)),
                        (psk_17 ? ((pre_17_dc >= 5'd15) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd15)),
                        (psk_17 ? ((pre_17_dc >= 5'd16) & (pre_17_dc <= 5'd16)) : (pre_17_dc == 5'd16))};
    assign pmk_18 = (presel ? im_50 : im_18);
    assign pek_18 = (presel ? ie_50 : ie_18);
    assign psk_18 = (presel ? s[50] : s[18]);
    assign pre_18_d = ({1'd0, q_emax_g_4} - {1'd0, pek_18});
    assign pre_18_dz = (zs_g_4 | (pre_18_d[8:5] != 4'd0));
    assign pre_18_dc = (pre_18_dz ? 5'd31 : pre_18_d[4:0]);
    assign pre_18_oh = {(psk_18 & (pre_18_dc <= 5'd16)),
                        (psk_18 ? ((pre_18_dc >= 5'd0) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd0)),
                        (psk_18 ? ((pre_18_dc >= 5'd1) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd1)),
                        (psk_18 ? ((pre_18_dc >= 5'd2) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd2)),
                        (psk_18 ? ((pre_18_dc >= 5'd3) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd3)),
                        (psk_18 ? ((pre_18_dc >= 5'd4) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd4)),
                        (psk_18 ? ((pre_18_dc >= 5'd5) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd5)),
                        (psk_18 ? ((pre_18_dc >= 5'd6) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd6)),
                        (psk_18 ? ((pre_18_dc >= 5'd7) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd7)),
                        (psk_18 ? ((pre_18_dc >= 5'd8) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd8)),
                        (psk_18 ? ((pre_18_dc >= 5'd9) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd9)),
                        (psk_18 ? ((pre_18_dc >= 5'd10) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd10)),
                        (psk_18 ? ((pre_18_dc >= 5'd11) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd11)),
                        (psk_18 ? ((pre_18_dc >= 5'd12) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd12)),
                        (psk_18 ? ((pre_18_dc >= 5'd13) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd13)),
                        (psk_18 ? ((pre_18_dc >= 5'd14) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd14)),
                        (psk_18 ? ((pre_18_dc >= 5'd15) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd15)),
                        (psk_18 ? ((pre_18_dc >= 5'd16) & (pre_18_dc <= 5'd16)) : (pre_18_dc == 5'd16))};
    assign pmk_19 = (presel ? im_51 : im_19);
    assign pek_19 = (presel ? ie_51 : ie_19);
    assign psk_19 = (presel ? s[51] : s[19]);
    assign pre_19_d = ({1'd0, q_emax_g_4} - {1'd0, pek_19});
    assign pre_19_dz = (zs_g_4 | (pre_19_d[8:5] != 4'd0));
    assign pre_19_dc = (pre_19_dz ? 5'd31 : pre_19_d[4:0]);
    assign pre_19_oh = {(psk_19 & (pre_19_dc <= 5'd16)),
                        (psk_19 ? ((pre_19_dc >= 5'd0) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd0)),
                        (psk_19 ? ((pre_19_dc >= 5'd1) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd1)),
                        (psk_19 ? ((pre_19_dc >= 5'd2) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd2)),
                        (psk_19 ? ((pre_19_dc >= 5'd3) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd3)),
                        (psk_19 ? ((pre_19_dc >= 5'd4) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd4)),
                        (psk_19 ? ((pre_19_dc >= 5'd5) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd5)),
                        (psk_19 ? ((pre_19_dc >= 5'd6) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd6)),
                        (psk_19 ? ((pre_19_dc >= 5'd7) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd7)),
                        (psk_19 ? ((pre_19_dc >= 5'd8) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd8)),
                        (psk_19 ? ((pre_19_dc >= 5'd9) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd9)),
                        (psk_19 ? ((pre_19_dc >= 5'd10) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd10)),
                        (psk_19 ? ((pre_19_dc >= 5'd11) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd11)),
                        (psk_19 ? ((pre_19_dc >= 5'd12) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd12)),
                        (psk_19 ? ((pre_19_dc >= 5'd13) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd13)),
                        (psk_19 ? ((pre_19_dc >= 5'd14) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd14)),
                        (psk_19 ? ((pre_19_dc >= 5'd15) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd15)),
                        (psk_19 ? ((pre_19_dc >= 5'd16) & (pre_19_dc <= 5'd16)) : (pre_19_dc == 5'd16))};
    assign pmk_20 = (presel ? im_52 : im_20);
    assign pek_20 = (presel ? ie_52 : ie_20);
    assign psk_20 = (presel ? s[52] : s[20]);
    assign pre_20_d = ({1'd0, q_emax_g_5} - {1'd0, pek_20});
    assign pre_20_dz = (zs_g_5 | (pre_20_d[8:5] != 4'd0));
    assign pre_20_dc = (pre_20_dz ? 5'd31 : pre_20_d[4:0]);
    assign pre_20_oh = {(psk_20 & (pre_20_dc <= 5'd16)),
                        (psk_20 ? ((pre_20_dc >= 5'd0) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd0)),
                        (psk_20 ? ((pre_20_dc >= 5'd1) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd1)),
                        (psk_20 ? ((pre_20_dc >= 5'd2) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd2)),
                        (psk_20 ? ((pre_20_dc >= 5'd3) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd3)),
                        (psk_20 ? ((pre_20_dc >= 5'd4) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd4)),
                        (psk_20 ? ((pre_20_dc >= 5'd5) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd5)),
                        (psk_20 ? ((pre_20_dc >= 5'd6) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd6)),
                        (psk_20 ? ((pre_20_dc >= 5'd7) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd7)),
                        (psk_20 ? ((pre_20_dc >= 5'd8) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd8)),
                        (psk_20 ? ((pre_20_dc >= 5'd9) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd9)),
                        (psk_20 ? ((pre_20_dc >= 5'd10) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd10)),
                        (psk_20 ? ((pre_20_dc >= 5'd11) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd11)),
                        (psk_20 ? ((pre_20_dc >= 5'd12) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd12)),
                        (psk_20 ? ((pre_20_dc >= 5'd13) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd13)),
                        (psk_20 ? ((pre_20_dc >= 5'd14) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd14)),
                        (psk_20 ? ((pre_20_dc >= 5'd15) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd15)),
                        (psk_20 ? ((pre_20_dc >= 5'd16) & (pre_20_dc <= 5'd16)) : (pre_20_dc == 5'd16))};
    assign pmk_21 = (presel ? im_53 : im_21);
    assign pek_21 = (presel ? ie_53 : ie_21);
    assign psk_21 = (presel ? s[53] : s[21]);
    assign pre_21_d = ({1'd0, q_emax_g_5} - {1'd0, pek_21});
    assign pre_21_dz = (zs_g_5 | (pre_21_d[8:5] != 4'd0));
    assign pre_21_dc = (pre_21_dz ? 5'd31 : pre_21_d[4:0]);
    assign pre_21_oh = {(psk_21 & (pre_21_dc <= 5'd16)),
                        (psk_21 ? ((pre_21_dc >= 5'd0) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd0)),
                        (psk_21 ? ((pre_21_dc >= 5'd1) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd1)),
                        (psk_21 ? ((pre_21_dc >= 5'd2) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd2)),
                        (psk_21 ? ((pre_21_dc >= 5'd3) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd3)),
                        (psk_21 ? ((pre_21_dc >= 5'd4) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd4)),
                        (psk_21 ? ((pre_21_dc >= 5'd5) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd5)),
                        (psk_21 ? ((pre_21_dc >= 5'd6) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd6)),
                        (psk_21 ? ((pre_21_dc >= 5'd7) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd7)),
                        (psk_21 ? ((pre_21_dc >= 5'd8) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd8)),
                        (psk_21 ? ((pre_21_dc >= 5'd9) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd9)),
                        (psk_21 ? ((pre_21_dc >= 5'd10) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd10)),
                        (psk_21 ? ((pre_21_dc >= 5'd11) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd11)),
                        (psk_21 ? ((pre_21_dc >= 5'd12) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd12)),
                        (psk_21 ? ((pre_21_dc >= 5'd13) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd13)),
                        (psk_21 ? ((pre_21_dc >= 5'd14) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd14)),
                        (psk_21 ? ((pre_21_dc >= 5'd15) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd15)),
                        (psk_21 ? ((pre_21_dc >= 5'd16) & (pre_21_dc <= 5'd16)) : (pre_21_dc == 5'd16))};
    assign pmk_22 = (presel ? im_54 : im_22);
    assign pek_22 = (presel ? ie_54 : ie_22);
    assign psk_22 = (presel ? s[54] : s[22]);
    assign pre_22_d = ({1'd0, q_emax_g_5} - {1'd0, pek_22});
    assign pre_22_dz = (zs_g_5 | (pre_22_d[8:5] != 4'd0));
    assign pre_22_dc = (pre_22_dz ? 5'd31 : pre_22_d[4:0]);
    assign pre_22_oh = {(psk_22 & (pre_22_dc <= 5'd16)),
                        (psk_22 ? ((pre_22_dc >= 5'd0) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd0)),
                        (psk_22 ? ((pre_22_dc >= 5'd1) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd1)),
                        (psk_22 ? ((pre_22_dc >= 5'd2) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd2)),
                        (psk_22 ? ((pre_22_dc >= 5'd3) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd3)),
                        (psk_22 ? ((pre_22_dc >= 5'd4) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd4)),
                        (psk_22 ? ((pre_22_dc >= 5'd5) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd5)),
                        (psk_22 ? ((pre_22_dc >= 5'd6) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd6)),
                        (psk_22 ? ((pre_22_dc >= 5'd7) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd7)),
                        (psk_22 ? ((pre_22_dc >= 5'd8) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd8)),
                        (psk_22 ? ((pre_22_dc >= 5'd9) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd9)),
                        (psk_22 ? ((pre_22_dc >= 5'd10) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd10)),
                        (psk_22 ? ((pre_22_dc >= 5'd11) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd11)),
                        (psk_22 ? ((pre_22_dc >= 5'd12) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd12)),
                        (psk_22 ? ((pre_22_dc >= 5'd13) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd13)),
                        (psk_22 ? ((pre_22_dc >= 5'd14) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd14)),
                        (psk_22 ? ((pre_22_dc >= 5'd15) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd15)),
                        (psk_22 ? ((pre_22_dc >= 5'd16) & (pre_22_dc <= 5'd16)) : (pre_22_dc == 5'd16))};
    assign pmk_23 = (presel ? im_55 : im_23);
    assign pek_23 = (presel ? ie_55 : ie_23);
    assign psk_23 = (presel ? s[55] : s[23]);
    assign pre_23_d = ({1'd0, q_emax_g_5} - {1'd0, pek_23});
    assign pre_23_dz = (zs_g_5 | (pre_23_d[8:5] != 4'd0));
    assign pre_23_dc = (pre_23_dz ? 5'd31 : pre_23_d[4:0]);
    assign pre_23_oh = {(psk_23 & (pre_23_dc <= 5'd16)),
                        (psk_23 ? ((pre_23_dc >= 5'd0) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd0)),
                        (psk_23 ? ((pre_23_dc >= 5'd1) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd1)),
                        (psk_23 ? ((pre_23_dc >= 5'd2) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd2)),
                        (psk_23 ? ((pre_23_dc >= 5'd3) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd3)),
                        (psk_23 ? ((pre_23_dc >= 5'd4) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd4)),
                        (psk_23 ? ((pre_23_dc >= 5'd5) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd5)),
                        (psk_23 ? ((pre_23_dc >= 5'd6) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd6)),
                        (psk_23 ? ((pre_23_dc >= 5'd7) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd7)),
                        (psk_23 ? ((pre_23_dc >= 5'd8) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd8)),
                        (psk_23 ? ((pre_23_dc >= 5'd9) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd9)),
                        (psk_23 ? ((pre_23_dc >= 5'd10) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd10)),
                        (psk_23 ? ((pre_23_dc >= 5'd11) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd11)),
                        (psk_23 ? ((pre_23_dc >= 5'd12) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd12)),
                        (psk_23 ? ((pre_23_dc >= 5'd13) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd13)),
                        (psk_23 ? ((pre_23_dc >= 5'd14) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd14)),
                        (psk_23 ? ((pre_23_dc >= 5'd15) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd15)),
                        (psk_23 ? ((pre_23_dc >= 5'd16) & (pre_23_dc <= 5'd16)) : (pre_23_dc == 5'd16))};
    assign pmk_24 = (presel ? im_56 : im_24);
    assign pek_24 = (presel ? ie_56 : ie_24);
    assign psk_24 = (presel ? s[56] : s[24]);
    assign pre_24_d = ({1'd0, q_emax_g_6} - {1'd0, pek_24});
    assign pre_24_dz = (zs_g_6 | (pre_24_d[8:5] != 4'd0));
    assign pre_24_dc = (pre_24_dz ? 5'd31 : pre_24_d[4:0]);
    assign pre_24_oh = {(psk_24 & (pre_24_dc <= 5'd16)),
                        (psk_24 ? ((pre_24_dc >= 5'd0) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd0)),
                        (psk_24 ? ((pre_24_dc >= 5'd1) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd1)),
                        (psk_24 ? ((pre_24_dc >= 5'd2) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd2)),
                        (psk_24 ? ((pre_24_dc >= 5'd3) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd3)),
                        (psk_24 ? ((pre_24_dc >= 5'd4) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd4)),
                        (psk_24 ? ((pre_24_dc >= 5'd5) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd5)),
                        (psk_24 ? ((pre_24_dc >= 5'd6) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd6)),
                        (psk_24 ? ((pre_24_dc >= 5'd7) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd7)),
                        (psk_24 ? ((pre_24_dc >= 5'd8) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd8)),
                        (psk_24 ? ((pre_24_dc >= 5'd9) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd9)),
                        (psk_24 ? ((pre_24_dc >= 5'd10) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd10)),
                        (psk_24 ? ((pre_24_dc >= 5'd11) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd11)),
                        (psk_24 ? ((pre_24_dc >= 5'd12) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd12)),
                        (psk_24 ? ((pre_24_dc >= 5'd13) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd13)),
                        (psk_24 ? ((pre_24_dc >= 5'd14) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd14)),
                        (psk_24 ? ((pre_24_dc >= 5'd15) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd15)),
                        (psk_24 ? ((pre_24_dc >= 5'd16) & (pre_24_dc <= 5'd16)) : (pre_24_dc == 5'd16))};
    assign pmk_25 = (presel ? im_57 : im_25);
    assign pek_25 = (presel ? ie_57 : ie_25);
    assign psk_25 = (presel ? s[57] : s[25]);
    assign pre_25_d = ({1'd0, q_emax_g_6} - {1'd0, pek_25});
    assign pre_25_dz = (zs_g_6 | (pre_25_d[8:5] != 4'd0));
    assign pre_25_dc = (pre_25_dz ? 5'd31 : pre_25_d[4:0]);
    assign pre_25_oh = {(psk_25 & (pre_25_dc <= 5'd16)),
                        (psk_25 ? ((pre_25_dc >= 5'd0) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd0)),
                        (psk_25 ? ((pre_25_dc >= 5'd1) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd1)),
                        (psk_25 ? ((pre_25_dc >= 5'd2) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd2)),
                        (psk_25 ? ((pre_25_dc >= 5'd3) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd3)),
                        (psk_25 ? ((pre_25_dc >= 5'd4) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd4)),
                        (psk_25 ? ((pre_25_dc >= 5'd5) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd5)),
                        (psk_25 ? ((pre_25_dc >= 5'd6) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd6)),
                        (psk_25 ? ((pre_25_dc >= 5'd7) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd7)),
                        (psk_25 ? ((pre_25_dc >= 5'd8) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd8)),
                        (psk_25 ? ((pre_25_dc >= 5'd9) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd9)),
                        (psk_25 ? ((pre_25_dc >= 5'd10) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd10)),
                        (psk_25 ? ((pre_25_dc >= 5'd11) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd11)),
                        (psk_25 ? ((pre_25_dc >= 5'd12) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd12)),
                        (psk_25 ? ((pre_25_dc >= 5'd13) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd13)),
                        (psk_25 ? ((pre_25_dc >= 5'd14) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd14)),
                        (psk_25 ? ((pre_25_dc >= 5'd15) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd15)),
                        (psk_25 ? ((pre_25_dc >= 5'd16) & (pre_25_dc <= 5'd16)) : (pre_25_dc == 5'd16))};
    assign pmk_26 = (presel ? im_58 : im_26);
    assign pek_26 = (presel ? ie_58 : ie_26);
    assign psk_26 = (presel ? s[58] : s[26]);
    assign pre_26_d = ({1'd0, q_emax_g_6} - {1'd0, pek_26});
    assign pre_26_dz = (zs_g_6 | (pre_26_d[8:5] != 4'd0));
    assign pre_26_dc = (pre_26_dz ? 5'd31 : pre_26_d[4:0]);
    assign pre_26_oh = {(psk_26 & (pre_26_dc <= 5'd16)),
                        (psk_26 ? ((pre_26_dc >= 5'd0) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd0)),
                        (psk_26 ? ((pre_26_dc >= 5'd1) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd1)),
                        (psk_26 ? ((pre_26_dc >= 5'd2) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd2)),
                        (psk_26 ? ((pre_26_dc >= 5'd3) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd3)),
                        (psk_26 ? ((pre_26_dc >= 5'd4) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd4)),
                        (psk_26 ? ((pre_26_dc >= 5'd5) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd5)),
                        (psk_26 ? ((pre_26_dc >= 5'd6) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd6)),
                        (psk_26 ? ((pre_26_dc >= 5'd7) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd7)),
                        (psk_26 ? ((pre_26_dc >= 5'd8) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd8)),
                        (psk_26 ? ((pre_26_dc >= 5'd9) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd9)),
                        (psk_26 ? ((pre_26_dc >= 5'd10) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd10)),
                        (psk_26 ? ((pre_26_dc >= 5'd11) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd11)),
                        (psk_26 ? ((pre_26_dc >= 5'd12) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd12)),
                        (psk_26 ? ((pre_26_dc >= 5'd13) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd13)),
                        (psk_26 ? ((pre_26_dc >= 5'd14) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd14)),
                        (psk_26 ? ((pre_26_dc >= 5'd15) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd15)),
                        (psk_26 ? ((pre_26_dc >= 5'd16) & (pre_26_dc <= 5'd16)) : (pre_26_dc == 5'd16))};
    assign pmk_27 = (presel ? im_59 : im_27);
    assign pek_27 = (presel ? ie_59 : ie_27);
    assign psk_27 = (presel ? s[59] : s[27]);
    assign pre_27_d = ({1'd0, q_emax_g_6} - {1'd0, pek_27});
    assign pre_27_dz = (zs_g_6 | (pre_27_d[8:5] != 4'd0));
    assign pre_27_dc = (pre_27_dz ? 5'd31 : pre_27_d[4:0]);
    assign pre_27_oh = {(psk_27 & (pre_27_dc <= 5'd16)),
                        (psk_27 ? ((pre_27_dc >= 5'd0) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd0)),
                        (psk_27 ? ((pre_27_dc >= 5'd1) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd1)),
                        (psk_27 ? ((pre_27_dc >= 5'd2) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd2)),
                        (psk_27 ? ((pre_27_dc >= 5'd3) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd3)),
                        (psk_27 ? ((pre_27_dc >= 5'd4) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd4)),
                        (psk_27 ? ((pre_27_dc >= 5'd5) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd5)),
                        (psk_27 ? ((pre_27_dc >= 5'd6) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd6)),
                        (psk_27 ? ((pre_27_dc >= 5'd7) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd7)),
                        (psk_27 ? ((pre_27_dc >= 5'd8) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd8)),
                        (psk_27 ? ((pre_27_dc >= 5'd9) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd9)),
                        (psk_27 ? ((pre_27_dc >= 5'd10) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd10)),
                        (psk_27 ? ((pre_27_dc >= 5'd11) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd11)),
                        (psk_27 ? ((pre_27_dc >= 5'd12) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd12)),
                        (psk_27 ? ((pre_27_dc >= 5'd13) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd13)),
                        (psk_27 ? ((pre_27_dc >= 5'd14) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd14)),
                        (psk_27 ? ((pre_27_dc >= 5'd15) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd15)),
                        (psk_27 ? ((pre_27_dc >= 5'd16) & (pre_27_dc <= 5'd16)) : (pre_27_dc == 5'd16))};
    assign pmk_28 = (presel ? im_60 : im_28);
    assign pek_28 = (presel ? ie_60 : ie_28);
    assign psk_28 = (presel ? s[60] : s[28]);
    assign pre_28_d = ({1'd0, q_emax_g_7} - {1'd0, pek_28});
    assign pre_28_dz = (zs_g_7 | (pre_28_d[8:5] != 4'd0));
    assign pre_28_dc = (pre_28_dz ? 5'd31 : pre_28_d[4:0]);
    assign pre_28_oh = {(psk_28 & (pre_28_dc <= 5'd16)),
                        (psk_28 ? ((pre_28_dc >= 5'd0) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd0)),
                        (psk_28 ? ((pre_28_dc >= 5'd1) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd1)),
                        (psk_28 ? ((pre_28_dc >= 5'd2) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd2)),
                        (psk_28 ? ((pre_28_dc >= 5'd3) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd3)),
                        (psk_28 ? ((pre_28_dc >= 5'd4) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd4)),
                        (psk_28 ? ((pre_28_dc >= 5'd5) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd5)),
                        (psk_28 ? ((pre_28_dc >= 5'd6) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd6)),
                        (psk_28 ? ((pre_28_dc >= 5'd7) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd7)),
                        (psk_28 ? ((pre_28_dc >= 5'd8) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd8)),
                        (psk_28 ? ((pre_28_dc >= 5'd9) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd9)),
                        (psk_28 ? ((pre_28_dc >= 5'd10) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd10)),
                        (psk_28 ? ((pre_28_dc >= 5'd11) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd11)),
                        (psk_28 ? ((pre_28_dc >= 5'd12) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd12)),
                        (psk_28 ? ((pre_28_dc >= 5'd13) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd13)),
                        (psk_28 ? ((pre_28_dc >= 5'd14) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd14)),
                        (psk_28 ? ((pre_28_dc >= 5'd15) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd15)),
                        (psk_28 ? ((pre_28_dc >= 5'd16) & (pre_28_dc <= 5'd16)) : (pre_28_dc == 5'd16))};
    assign pmk_29 = (presel ? im_61 : im_29);
    assign pek_29 = (presel ? ie_61 : ie_29);
    assign psk_29 = (presel ? s[61] : s[29]);
    assign pre_29_d = ({1'd0, q_emax_g_7} - {1'd0, pek_29});
    assign pre_29_dz = (zs_g_7 | (pre_29_d[8:5] != 4'd0));
    assign pre_29_dc = (pre_29_dz ? 5'd31 : pre_29_d[4:0]);
    assign pre_29_oh = {(psk_29 & (pre_29_dc <= 5'd16)),
                        (psk_29 ? ((pre_29_dc >= 5'd0) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd0)),
                        (psk_29 ? ((pre_29_dc >= 5'd1) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd1)),
                        (psk_29 ? ((pre_29_dc >= 5'd2) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd2)),
                        (psk_29 ? ((pre_29_dc >= 5'd3) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd3)),
                        (psk_29 ? ((pre_29_dc >= 5'd4) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd4)),
                        (psk_29 ? ((pre_29_dc >= 5'd5) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd5)),
                        (psk_29 ? ((pre_29_dc >= 5'd6) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd6)),
                        (psk_29 ? ((pre_29_dc >= 5'd7) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd7)),
                        (psk_29 ? ((pre_29_dc >= 5'd8) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd8)),
                        (psk_29 ? ((pre_29_dc >= 5'd9) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd9)),
                        (psk_29 ? ((pre_29_dc >= 5'd10) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd10)),
                        (psk_29 ? ((pre_29_dc >= 5'd11) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd11)),
                        (psk_29 ? ((pre_29_dc >= 5'd12) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd12)),
                        (psk_29 ? ((pre_29_dc >= 5'd13) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd13)),
                        (psk_29 ? ((pre_29_dc >= 5'd14) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd14)),
                        (psk_29 ? ((pre_29_dc >= 5'd15) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd15)),
                        (psk_29 ? ((pre_29_dc >= 5'd16) & (pre_29_dc <= 5'd16)) : (pre_29_dc == 5'd16))};
    assign pmk_30 = (presel ? im_62 : im_30);
    assign pek_30 = (presel ? ie_62 : ie_30);
    assign psk_30 = (presel ? s[62] : s[30]);
    assign pre_30_d = ({1'd0, q_emax_g_7} - {1'd0, pek_30});
    assign pre_30_dz = (zs_g_7 | (pre_30_d[8:5] != 4'd0));
    assign pre_30_dc = (pre_30_dz ? 5'd31 : pre_30_d[4:0]);
    assign pre_30_oh = {(psk_30 & (pre_30_dc <= 5'd16)),
                        (psk_30 ? ((pre_30_dc >= 5'd0) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd0)),
                        (psk_30 ? ((pre_30_dc >= 5'd1) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd1)),
                        (psk_30 ? ((pre_30_dc >= 5'd2) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd2)),
                        (psk_30 ? ((pre_30_dc >= 5'd3) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd3)),
                        (psk_30 ? ((pre_30_dc >= 5'd4) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd4)),
                        (psk_30 ? ((pre_30_dc >= 5'd5) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd5)),
                        (psk_30 ? ((pre_30_dc >= 5'd6) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd6)),
                        (psk_30 ? ((pre_30_dc >= 5'd7) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd7)),
                        (psk_30 ? ((pre_30_dc >= 5'd8) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd8)),
                        (psk_30 ? ((pre_30_dc >= 5'd9) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd9)),
                        (psk_30 ? ((pre_30_dc >= 5'd10) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd10)),
                        (psk_30 ? ((pre_30_dc >= 5'd11) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd11)),
                        (psk_30 ? ((pre_30_dc >= 5'd12) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd12)),
                        (psk_30 ? ((pre_30_dc >= 5'd13) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd13)),
                        (psk_30 ? ((pre_30_dc >= 5'd14) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd14)),
                        (psk_30 ? ((pre_30_dc >= 5'd15) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd15)),
                        (psk_30 ? ((pre_30_dc >= 5'd16) & (pre_30_dc <= 5'd16)) : (pre_30_dc == 5'd16))};
    assign pmk_31 = (presel ? im_63 : im_31);
    assign pek_31 = (presel ? ie_63 : ie_31);
    assign psk_31 = (presel ? s[63] : s[31]);
    assign pre_31_d = ({1'd0, q_emax_g_7} - {1'd0, pek_31});
    assign pre_31_dz = (zs_g_7 | (pre_31_d[8:5] != 4'd0));
    assign pre_31_dc = (pre_31_dz ? 5'd31 : pre_31_d[4:0]);
    assign pre_31_oh = {(psk_31 & (pre_31_dc <= 5'd16)),
                        (psk_31 ? ((pre_31_dc >= 5'd0) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd0)),
                        (psk_31 ? ((pre_31_dc >= 5'd1) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd1)),
                        (psk_31 ? ((pre_31_dc >= 5'd2) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd2)),
                        (psk_31 ? ((pre_31_dc >= 5'd3) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd3)),
                        (psk_31 ? ((pre_31_dc >= 5'd4) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd4)),
                        (psk_31 ? ((pre_31_dc >= 5'd5) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd5)),
                        (psk_31 ? ((pre_31_dc >= 5'd6) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd6)),
                        (psk_31 ? ((pre_31_dc >= 5'd7) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd7)),
                        (psk_31 ? ((pre_31_dc >= 5'd8) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd8)),
                        (psk_31 ? ((pre_31_dc >= 5'd9) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd9)),
                        (psk_31 ? ((pre_31_dc >= 5'd10) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd10)),
                        (psk_31 ? ((pre_31_dc >= 5'd11) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd11)),
                        (psk_31 ? ((pre_31_dc >= 5'd12) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd12)),
                        (psk_31 ? ((pre_31_dc >= 5'd13) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd13)),
                        (psk_31 ? ((pre_31_dc >= 5'd14) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd14)),
                        (psk_31 ? ((pre_31_dc >= 5'd15) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd15)),
                        (psk_31 ? ((pre_31_dc >= 5'd16) & (pre_31_dc <= 5'd16)) : (pre_31_dc == 5'd16))};
    assign pmk_pack = {pmk_31, pmk_30, pmk_29, pmk_28, pmk_27, pmk_26, pmk_25, pmk_24, pmk_23, pmk_22, pmk_21, pmk_20,
                       pmk_19, pmk_18, pmk_17, pmk_16, pmk_15, pmk_14, pmk_13, pmk_12, pmk_11, pmk_10, pmk_9, pmk_8,
                       pmk_7, pmk_6, pmk_5, pmk_4, pmk_3, pmk_2, pmk_1, pmk_0};
    assign ohs_pack = {pre_31_oh, pre_30_oh, pre_29_oh, pre_28_oh, pre_27_oh, pre_26_oh, pre_25_oh, pre_24_oh,
                       pre_23_oh, pre_22_oh, pre_21_oh, pre_20_oh, pre_19_oh, pre_18_oh, pre_17_oh, pre_16_oh,
                       pre_15_oh, pre_14_oh, pre_13_oh, pre_12_oh, pre_11_oh, pre_10_oh, pre_9_oh, pre_8_oh, pre_7_oh,
                       pre_6_oh, pre_5_oh, pre_4_oh, pre_3_oh, pre_2_oh, pre_1_oh, pre_0_oh};
    assign psk_pack = {psk_31, psk_30, psk_29, psk_28, psk_27, psk_26, psk_25, psk_24, psk_23, psk_22, psk_21, psk_20,
                       psk_19, psk_18, psk_17, psk_16, psk_15, psk_14, psk_13, psk_12, psk_11, psk_10, psk_9, psk_8,
                       psk_7, psk_6, psk_5, psk_4, psk_3, psk_2, psk_1, psk_0};
    assign pp_l_0 = u_pp_0_p;
    assign po_l_0 = pp_l_0[40:25];
    assign pp_l_1 = u_pp_1_p;
    assign po_l_1 = pp_l_1[40:25];
    assign pp_l_2 = u_pp_2_p;
    assign po_l_2 = pp_l_2[40:25];
    assign pp_l_3 = u_pp_3_p;
    assign po_l_3 = pp_l_3[40:25];
    assign pp_l_4 = u_pp_4_p;
    assign po_l_4 = pp_l_4[40:25];
    assign pp_l_5 = u_pp_5_p;
    assign po_l_5 = pp_l_5[40:25];
    assign pp_l_6 = u_pp_6_p;
    assign po_l_6 = pp_l_6[40:25];
    assign pp_l_7 = u_pp_7_p;
    assign po_l_7 = pp_l_7[40:25];
    assign pp_l_8 = u_pp_8_p;
    assign po_l_8 = pp_l_8[40:25];
    assign pp_l_9 = u_pp_9_p;
    assign po_l_9 = pp_l_9[40:25];
    assign pp_l_10 = u_pp_10_p;
    assign po_l_10 = pp_l_10[40:25];
    assign pp_l_11 = u_pp_11_p;
    assign po_l_11 = pp_l_11[40:25];
    assign pp_l_12 = u_pp_12_p;
    assign po_l_12 = pp_l_12[40:25];
    assign pp_l_13 = u_pp_13_p;
    assign po_l_13 = pp_l_13[40:25];
    assign pp_l_14 = u_pp_14_p;
    assign po_l_14 = pp_l_14[40:25];
    assign pp_l_15 = u_pp_15_p;
    assign po_l_15 = pp_l_15[40:25];
    assign pp_l_16 = u_pp_16_p;
    assign po_l_16 = pp_l_16[40:25];
    assign pp_l_17 = u_pp_17_p;
    assign po_l_17 = pp_l_17[40:25];
    assign pp_l_18 = u_pp_18_p;
    assign po_l_18 = pp_l_18[40:25];
    assign pp_l_19 = u_pp_19_p;
    assign po_l_19 = pp_l_19[40:25];
    assign pp_l_20 = u_pp_20_p;
    assign po_l_20 = pp_l_20[40:25];
    assign pp_l_21 = u_pp_21_p;
    assign po_l_21 = pp_l_21[40:25];
    assign pp_l_22 = u_pp_22_p;
    assign po_l_22 = pp_l_22[40:25];
    assign pp_l_23 = u_pp_23_p;
    assign po_l_23 = pp_l_23[40:25];
    assign pp_l_24 = u_pp_24_p;
    assign po_l_24 = pp_l_24[40:25];
    assign pp_l_25 = u_pp_25_p;
    assign po_l_25 = pp_l_25[40:25];
    assign pp_l_26 = u_pp_26_p;
    assign po_l_26 = pp_l_26[40:25];
    assign pp_l_27 = u_pp_27_p;
    assign po_l_27 = pp_l_27[40:25];
    assign pp_l_28 = u_pp_28_p;
    assign po_l_28 = pp_l_28[40:25];
    assign pp_l_29 = u_pp_29_p;
    assign po_l_29 = pp_l_29[40:25];
    assign pp_l_30 = u_pp_30_p;
    assign po_l_30 = pp_l_30[40:25];
    assign pp_l_31 = u_pp_31_p;
    assign po_l_31 = pp_l_31[40:25];
    assign post_out = {po_l_31, po_l_30, po_l_29, po_l_28, po_l_27, po_l_26, po_l_25, po_l_24, po_l_23, po_l_22,
                       po_l_21, po_l_20, po_l_19, po_l_18, po_l_17, po_l_16, po_l_15, po_l_14, po_l_13, po_l_12,
                       po_l_11, po_l_10, po_l_9, po_l_8, po_l_7, po_l_6, po_l_5, po_l_4, po_l_3, po_l_2, po_l_1, po_l_0};
    assign e = q_e;
    assign f = {post_out, f_lo};
    assign fq = {f_hi_q, f_lo};
    assign ov = v3;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            pm_q <= 0;
            v0 <= 0;
            q_emax_g_0 <= 0;
            q_emax_g_1 <= 0;
            q_emax_g_2 <= 0;
            q_emax_g_3 <= 0;
            q_emax_g_4 <= 0;
            q_emax_g_5 <= 0;
            q_emax_g_6 <= 0;
            q_emax_g_7 <= 0;
            v1 <= 0;
            q_e <= 0;
            pst_m <= 0;
            pst_o <= 0;
            pst_s <= 0;
            v2 <= 0;
            f_lo <= 0;
            f_hi_q <= 0;
            v3 <= 0;
        end else begin
            if (en) begin
                if (start) begin
                    pm_q <= pm_pack_c;
                end
                v0 <= start;
                if (v0) begin
                    q_emax_g_0 <= emax_c;
                    q_emax_g_1 <= emax_c;
                    q_emax_g_2 <= emax_c;
                    q_emax_g_3 <= emax_c;
                    q_emax_g_4 <= emax_c;
                    q_emax_g_5 <= emax_c;
                    q_emax_g_6 <= emax_c;
                    q_emax_g_7 <= emax_c;
                end
                v1 <= v0;
                if (v1) begin
                    q_e <= c_e;
                    pst_m <= pmk_pack;
                    pst_o <= ohs_pack;
                    pst_s <= psk_pack;
                end
                v2 <= v1;
                if (v2) begin
                    f_lo <= post_out;
                    pst_m <= pmk_pack;
                    pst_o <= ohs_pack;
                    pst_s <= psk_pack;
                end
                if (v3) begin
                    f_hi_q <= post_out;
                end
                v3 <= v2;
            end
        end
    end

    UMulS24x18 u_pp_0 (
        .a(pst_m[23:0]),
        .b(pst_o[17:0]),
        .c({25{pst_s[0]}}),
        .p(u_pp_0_p)
    );
    UMulS24x18 u_pp_1 (
        .a(pst_m[47:24]),
        .b(pst_o[35:18]),
        .c({25{pst_s[1]}}),
        .p(u_pp_1_p)
    );
    UMulS24x18 u_pp_2 (
        .a(pst_m[71:48]),
        .b(pst_o[53:36]),
        .c({25{pst_s[2]}}),
        .p(u_pp_2_p)
    );
    UMulS24x18 u_pp_3 (
        .a(pst_m[95:72]),
        .b(pst_o[71:54]),
        .c({25{pst_s[3]}}),
        .p(u_pp_3_p)
    );
    UMulS24x18 u_pp_4 (
        .a(pst_m[119:96]),
        .b(pst_o[89:72]),
        .c({25{pst_s[4]}}),
        .p(u_pp_4_p)
    );
    UMulS24x18 u_pp_5 (
        .a(pst_m[143:120]),
        .b(pst_o[107:90]),
        .c({25{pst_s[5]}}),
        .p(u_pp_5_p)
    );
    UMulS24x18 u_pp_6 (
        .a(pst_m[167:144]),
        .b(pst_o[125:108]),
        .c({25{pst_s[6]}}),
        .p(u_pp_6_p)
    );
    UMulS24x18 u_pp_7 (
        .a(pst_m[191:168]),
        .b(pst_o[143:126]),
        .c({25{pst_s[7]}}),
        .p(u_pp_7_p)
    );
    UMulS24x18 u_pp_8 (
        .a(pst_m[215:192]),
        .b(pst_o[161:144]),
        .c({25{pst_s[8]}}),
        .p(u_pp_8_p)
    );
    UMulS24x18 u_pp_9 (
        .a(pst_m[239:216]),
        .b(pst_o[179:162]),
        .c({25{pst_s[9]}}),
        .p(u_pp_9_p)
    );
    UMulS24x18 u_pp_10 (
        .a(pst_m[263:240]),
        .b(pst_o[197:180]),
        .c({25{pst_s[10]}}),
        .p(u_pp_10_p)
    );
    UMulS24x18 u_pp_11 (
        .a(pst_m[287:264]),
        .b(pst_o[215:198]),
        .c({25{pst_s[11]}}),
        .p(u_pp_11_p)
    );
    UMulS24x18 u_pp_12 (
        .a(pst_m[311:288]),
        .b(pst_o[233:216]),
        .c({25{pst_s[12]}}),
        .p(u_pp_12_p)
    );
    UMulS24x18 u_pp_13 (
        .a(pst_m[335:312]),
        .b(pst_o[251:234]),
        .c({25{pst_s[13]}}),
        .p(u_pp_13_p)
    );
    UMulS24x18 u_pp_14 (
        .a(pst_m[359:336]),
        .b(pst_o[269:252]),
        .c({25{pst_s[14]}}),
        .p(u_pp_14_p)
    );
    UMulS24x18 u_pp_15 (
        .a(pst_m[383:360]),
        .b(pst_o[287:270]),
        .c({25{pst_s[15]}}),
        .p(u_pp_15_p)
    );
    UMulS24x18 u_pp_16 (
        .a(pst_m[407:384]),
        .b(pst_o[305:288]),
        .c({25{pst_s[16]}}),
        .p(u_pp_16_p)
    );
    UMulS24x18 u_pp_17 (
        .a(pst_m[431:408]),
        .b(pst_o[323:306]),
        .c({25{pst_s[17]}}),
        .p(u_pp_17_p)
    );
    UMulS24x18 u_pp_18 (
        .a(pst_m[455:432]),
        .b(pst_o[341:324]),
        .c({25{pst_s[18]}}),
        .p(u_pp_18_p)
    );
    UMulS24x18 u_pp_19 (
        .a(pst_m[479:456]),
        .b(pst_o[359:342]),
        .c({25{pst_s[19]}}),
        .p(u_pp_19_p)
    );
    UMulS24x18 u_pp_20 (
        .a(pst_m[503:480]),
        .b(pst_o[377:360]),
        .c({25{pst_s[20]}}),
        .p(u_pp_20_p)
    );
    UMulS24x18 u_pp_21 (
        .a(pst_m[527:504]),
        .b(pst_o[395:378]),
        .c({25{pst_s[21]}}),
        .p(u_pp_21_p)
    );
    UMulS24x18 u_pp_22 (
        .a(pst_m[551:528]),
        .b(pst_o[413:396]),
        .c({25{pst_s[22]}}),
        .p(u_pp_22_p)
    );
    UMulS24x18 u_pp_23 (
        .a(pst_m[575:552]),
        .b(pst_o[431:414]),
        .c({25{pst_s[23]}}),
        .p(u_pp_23_p)
    );
    UMulS24x18 u_pp_24 (
        .a(pst_m[599:576]),
        .b(pst_o[449:432]),
        .c({25{pst_s[24]}}),
        .p(u_pp_24_p)
    );
    UMulS24x18 u_pp_25 (
        .a(pst_m[623:600]),
        .b(pst_o[467:450]),
        .c({25{pst_s[25]}}),
        .p(u_pp_25_p)
    );
    UMulS24x18 u_pp_26 (
        .a(pst_m[647:624]),
        .b(pst_o[485:468]),
        .c({25{pst_s[26]}}),
        .p(u_pp_26_p)
    );
    UMulS24x18 u_pp_27 (
        .a(pst_m[671:648]),
        .b(pst_o[503:486]),
        .c({25{pst_s[27]}}),
        .p(u_pp_27_p)
    );
    UMulS24x18 u_pp_28 (
        .a(pst_m[695:672]),
        .b(pst_o[521:504]),
        .c({25{pst_s[28]}}),
        .p(u_pp_28_p)
    );
    UMulS24x18 u_pp_29 (
        .a(pst_m[719:696]),
        .b(pst_o[539:522]),
        .c({25{pst_s[29]}}),
        .p(u_pp_29_p)
    );
    UMulS24x18 u_pp_30 (
        .a(pst_m[743:720]),
        .b(pst_o[557:540]),
        .c({25{pst_s[30]}}),
        .p(u_pp_30_p)
    );
    UMulS24x18 u_pp_31 (
        .a(pst_m[767:744]),
        .b(pst_o[575:558]),
        .c({25{pst_s[31]}}),
        .p(u_pp_31_p)
    );
endmodule
