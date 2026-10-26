module L1Pipe (
    input clk,
    input rst_n,
    input ctrl_s_cm_valid,
    output logic ctrl_s_cm_ready,
    input [31:0] ctrl_s_cm_addr,
    input [31:0] ctrl_s_cm_wdata,
    input ctrl_s_cm_write,
    input [23:0] ctrl_s_cm_tag,
    output logic ctrl_s_cr_valid,
    input ctrl_s_cr_ready,
    output logic [31:0] ctrl_s_cr_data,
    output logic [23:0] ctrl_s_cr_tag,
    output logic [15:0] dbg_pend_write,
    output logic [31:0] dbg_mismatch_o,
    output logic [15:0] dbg_torn_o,
    output logic [1:0] dbg_gate_block,
    output logic [1:0] dbg_admit,
    output logic [7:0] dbg_cfg_pend,
    output logic [7:0] dbg_live_slots,
    output logic [31:0] dbg_instq,
    output logic [31:0] dbg_gateq,
    output logic [31:0] dbg_gateq2,
    input h_0_valid,
    input [2:0] h_0_q,
    input [7:0] h_0_cid,
    input h_0_dir,
    input [19:0] h_0_off,
    input [19:0] h_0_bytes,
    input [15:0] h_0_rows,
    input [19:0] h_0_stride,
    input [15:0] h_0_tag,
    input h_0_first,
    input h_0_last,
    output logic h_0_pop,
    input h_1_valid,
    input [2:0] h_1_q,
    input [7:0] h_1_cid,
    input h_1_dir,
    input [19:0] h_1_off,
    input [19:0] h_1_bytes,
    input [15:0] h_1_rows,
    input [19:0] h_1_stride,
    input [15:0] h_1_tag,
    input h_1_first,
    input h_1_last,
    output logic h_1_pop,
    input h_2_valid,
    input [2:0] h_2_q,
    input [7:0] h_2_cid,
    input h_2_dir,
    input [19:0] h_2_off,
    input [19:0] h_2_bytes,
    input [15:0] h_2_rows,
    input [19:0] h_2_stride,
    input [15:0] h_2_tag,
    input h_2_first,
    input h_2_last,
    output logic h_2_pop,
    output logic p_0_s_valid,
    input p_0_s_ready,
    output logic [19:0] p_0_s_addr,
    output logic [19:0] p_0_s_bytes,
    output logic p_0_s_dir,
    output logic [15:0] p_0_s_tag,
    output logic [2:0] p_0_s_q,
    output logic [3:0] p_0_s_mid,
    output logic p_0_s_last,
    output logic [7:0] p_0_s_cid,
    output logic p_0_s_cnt,
    output logic p_0_dsp_ok,
    input p_0_dsp,
    input [7:0] p_0_dsp_cid,
    input p_0_sdone,
    input p_0_sdone_dir,
    input p_0_sdone_w,
    input p_0_sdone_last,
    input [15:0] p_0_sdone_tag,
    input [3:0] p_0_sdone_mid,
    output logic p_1_s_valid,
    input p_1_s_ready,
    output logic [19:0] p_1_s_addr,
    output logic [19:0] p_1_s_bytes,
    output logic p_1_s_dir,
    output logic [15:0] p_1_s_tag,
    output logic [2:0] p_1_s_q,
    output logic [3:0] p_1_s_mid,
    output logic p_1_s_last,
    output logic [7:0] p_1_s_cid,
    output logic p_1_s_cnt,
    output logic p_1_dsp_ok,
    input p_1_dsp,
    input [7:0] p_1_dsp_cid,
    input p_1_sdone,
    input p_1_sdone_dir,
    input p_1_sdone_w,
    input p_1_sdone_last,
    input [15:0] p_1_sdone_tag,
    input [3:0] p_1_sdone_mid,
    output logic p_2_s_valid,
    input p_2_s_ready,
    output logic [19:0] p_2_s_addr,
    output logic [19:0] p_2_s_bytes,
    output logic p_2_s_dir,
    output logic [15:0] p_2_s_tag,
    output logic [2:0] p_2_s_q,
    output logic [3:0] p_2_s_mid,
    output logic p_2_s_last,
    output logic [7:0] p_2_s_cid,
    output logic p_2_s_cnt,
    output logic p_2_dsp_ok,
    input p_2_dsp,
    input [7:0] p_2_dsp_cid,
    input p_2_sdone,
    input p_2_sdone_dir,
    input p_2_sdone_w,
    input p_2_sdone_last,
    input [15:0] p_2_sdone_tag,
    input [3:0] p_2_sdone_mid,
    output logic a_0_valid,
    output logic [3:0] a_0_id,
    output logic [15:0] a_0_tag,
    output logic a_1_valid,
    output logic [3:0] a_1_id,
    output logic [15:0] a_1_tag,
    output logic a_2_valid,
    output logic [3:0] a_2_id,
    output logic [15:0] a_2_tag,
    output logic b_0_valid,
    input b_0_ready,
    output logic [3:0] b_0_id,
    output logic [15:0] b_0_tag,
    output logic b_1_valid,
    input b_1_ready,
    output logic [3:0] b_1_id,
    output logic [15:0] b_1_tag,
    output logic b_2_valid,
    input b_2_ready,
    output logic [3:0] b_2_id,
    output logic [15:0] b_2_tag
);
    logic s_valid_c_0;
    logic s_valid_c_1;
    logic s_valid_c_2;
    logic s_valid_c_3;
    logic s_valid_c_4;
    logic s_valid_c_5;
    logic s_valid_c_6;
    logic s_valid_c_7;
    logic s_valid_c_8;
    logic s_valid_c_9;
    logic s_valid_c_10;
    logic s_valid_c_11;
    logic s_valid_c_12;
    logic s_valid_c_13;
    logic s_valid_c_14;
    logic s_valid_c_15;
    logic s_valid_c_16;
    logic s_valid_c_17;
    logic s_valid_c_18;
    logic s_valid_c_19;
    logic s_valid_c_20;
    logic s_valid_c_21;
    logic s_valid_c_22;
    logic s_valid_c_23;
    logic s_valid_c_24;
    logic s_valid_c_25;
    logic s_valid_c_26;
    logic s_valid_c_27;
    logic s_valid_c_28;
    logic s_valid_c_29;
    logic s_valid_c_30;
    logic s_valid_c_31;
    logic s_valid_c_32;
    logic s_valid_c_33;
    logic s_valid_c_34;
    logic s_valid_c_35;
    logic s_valid_c_36;
    logic s_valid_c_37;
    logic s_valid_c_38;
    logic s_valid_c_39;
    logic s_valid_c_40;
    logic s_valid_c_41;
    logic s_valid_c_42;
    logic s_valid_c_43;
    logic s_valid_c_44;
    logic s_valid_c_45;
    logic s_valid_c_46;
    logic s_valid_c_47;
    logic s_valid_c_48;
    logic s_valid_c_49;
    logic s_valid_c_50;
    logic s_valid_c_51;
    logic s_valid_c_52;
    logic s_valid_c_53;
    logic s_valid_c_54;
    logic s_valid_c_55;
    logic s_valid_c_56;
    logic s_valid_c_57;
    logic s_valid_c_58;
    logic s_valid_c_59;
    logic s_valid_c_60;
    logic s_valid_c_61;
    logic s_valid_c_62;
    logic s_valid_c_63;
    logic s_valid_c_64;
    logic s_valid_c_65;
    logic s_valid_c_66;
    logic s_valid_c_67;
    logic s_valid_c_68;
    logic s_valid_c_69;
    logic s_valid_c_70;
    logic s_valid_c_71;
    logic s_valid_c_72;
    logic s_valid_c_73;
    logic s_valid_c_74;
    logic s_valid_c_75;
    logic s_valid_c_76;
    logic s_valid_c_77;
    logic s_valid_c_78;
    logic s_valid_c_79;
    logic s_valid_c_80;
    logic s_valid_c_81;
    logic s_valid_c_82;
    logic s_valid_c_83;
    logic s_valid_c_84;
    logic s_valid_c_85;
    logic s_valid_c_86;
    logic s_valid_c_87;
    logic s_valid_c_88;
    logic s_valid_c_89;
    logic s_valid_c_90;
    logic s_valid_c_91;
    logic s_valid_c_92;
    logic s_valid_c_93;
    logic s_valid_c_94;
    logic s_valid_c_95;
    logic s_valid_c_96;
    logic s_valid_c_97;
    logic s_valid_c_98;
    logic s_valid_c_99;
    logic s_valid_c_100;
    logic s_valid_c_101;
    logic s_valid_c_102;
    logic s_valid_c_103;
    logic s_valid_c_104;
    logic s_valid_c_105;
    logic s_valid_c_106;
    logic s_valid_c_107;
    logic s_valid_c_108;
    logic s_valid_c_109;
    logic s_valid_c_110;
    logic s_valid_c_111;
    logic s_valid_c_112;
    logic s_valid_c_113;
    logic s_valid_c_114;
    logic s_valid_c_115;
    logic s_valid_c_116;
    logic s_valid_c_117;
    logic s_valid_c_118;
    logic s_valid_c_119;
    logic s_valid_c_120;
    logic s_valid_c_121;
    logic s_valid_c_122;
    logic s_valid_c_123;
    logic s_valid_c_124;
    logic s_valid_c_125;
    logic s_valid_c_126;
    logic s_valid_c_127;
    logic s_valid_c_128;
    logic s_valid_c_129;
    logic s_valid_c_130;
    logic s_valid_c_131;
    logic s_valid_c_132;
    logic s_valid_c_133;
    logic s_valid_c_134;
    logic s_valid_c_135;
    logic s_valid_c_136;
    logic s_valid_c_137;
    logic s_valid_c_138;
    logic s_valid_c_139;
    logic s_valid_c_140;
    logic s_valid_c_141;
    logic s_valid_c_142;
    logic s_valid_c_143;
    logic s_valid_c_144;
    logic s_valid_c_145;
    logic s_valid_c_146;
    logic s_valid_c_147;
    logic s_valid_c_148;
    logic s_valid_c_149;
    logic s_valid_c_150;
    logic s_valid_c_151;
    logic s_valid_c_152;
    logic s_valid_c_153;
    logic s_valid_c_154;
    logic s_valid_c_155;
    logic s_valid_c_156;
    logic s_valid_c_157;
    logic s_valid_c_158;
    logic s_valid_c_159;
    logic s_valid_c_160;
    logic s_valid_c_161;
    logic s_valid_c_162;
    logic s_valid_c_163;
    logic s_valid_c_164;
    logic s_valid_c_165;
    logic s_valid_c_166;
    logic s_valid_c_167;
    logic s_valid_c_168;
    logic s_valid_c_169;
    logic s_valid_c_170;
    logic s_valid_c_171;
    logic s_valid_c_172;
    logic s_valid_c_173;
    logic s_valid_c_174;
    logic s_valid_c_175;
    logic s_valid_c_176;
    logic s_valid_c_177;
    logic s_valid_c_178;
    logic s_valid_c_179;
    logic s_valid_c_180;
    logic s_valid_c_181;
    logic s_valid_c_182;
    logic s_valid_c_183;
    logic s_valid_c_184;
    logic s_valid_c_185;
    logic s_valid_c_186;
    logic s_valid_c_187;
    logic s_valid_c_188;
    logic s_valid_c_189;
    logic s_valid_c_190;
    logic s_valid_c_191;
    logic [191:0] s_valid;
    logic [19:0] s_base [0:191];
    logic [19:0] s_size [0:191];
    logic s_dir [0:255];
    logic [16:0] s_decl [0:191];
    logic [16:0] s_acc [0:191];
    logic [16:0] s_dm1 [0:191];
    logic s_qfull [0:255];
    logic acc_pv;
    logic [7:0] acc_pidx;
    logic [16:0] acc_pdata;
    logic dp_v;
    logic [7:0] dp_idx;
    logic [16:0] dp_data;
    logic s_dlast [0:255];
    logic dp_fb;
    logic [16:0] dp_dm1;
    logic qf_pdata;
    logic [16:0] s_disp [0:191];
    logic s_raww [0:255];
    logic [7:0] s_rawpeer [0:191];
    logic s_depv [0:255];
    logic [7:0] s_depread [0:191];
    logic p_valid_c_0;
    logic p_valid_c_1;
    logic p_valid_c_2;
    logic p_valid_c_3;
    logic p_valid_c_4;
    logic p_valid_c_5;
    logic p_valid_c_6;
    logic p_valid_c_7;
    logic p_valid_c_8;
    logic p_valid_c_9;
    logic p_valid_c_10;
    logic p_valid_c_11;
    logic p_valid_c_12;
    logic p_valid_c_13;
    logic p_valid_c_14;
    logic p_valid_c_15;
    logic p_valid_c_16;
    logic p_valid_c_17;
    logic p_valid_c_18;
    logic p_valid_c_19;
    logic p_valid_c_20;
    logic p_valid_c_21;
    logic p_valid_c_22;
    logic p_valid_c_23;
    logic p_valid_c_24;
    logic p_valid_c_25;
    logic p_valid_c_26;
    logic p_valid_c_27;
    logic p_valid_c_28;
    logic p_valid_c_29;
    logic p_valid_c_30;
    logic p_valid_c_31;
    logic p_valid_c_32;
    logic p_valid_c_33;
    logic p_valid_c_34;
    logic p_valid_c_35;
    logic p_valid_c_36;
    logic p_valid_c_37;
    logic p_valid_c_38;
    logic p_valid_c_39;
    logic p_valid_c_40;
    logic p_valid_c_41;
    logic p_valid_c_42;
    logic p_valid_c_43;
    logic p_valid_c_44;
    logic p_valid_c_45;
    logic p_valid_c_46;
    logic p_valid_c_47;
    logic p_valid_c_48;
    logic p_valid_c_49;
    logic p_valid_c_50;
    logic p_valid_c_51;
    logic p_valid_c_52;
    logic p_valid_c_53;
    logic p_valid_c_54;
    logic p_valid_c_55;
    logic p_valid_c_56;
    logic p_valid_c_57;
    logic p_valid_c_58;
    logic p_valid_c_59;
    logic p_valid_c_60;
    logic p_valid_c_61;
    logic p_valid_c_62;
    logic p_valid_c_63;
    logic p_valid_c_64;
    logic p_valid_c_65;
    logic p_valid_c_66;
    logic p_valid_c_67;
    logic p_valid_c_68;
    logic p_valid_c_69;
    logic p_valid_c_70;
    logic p_valid_c_71;
    logic p_valid_c_72;
    logic p_valid_c_73;
    logic p_valid_c_74;
    logic p_valid_c_75;
    logic p_valid_c_76;
    logic p_valid_c_77;
    logic p_valid_c_78;
    logic p_valid_c_79;
    logic p_valid_c_80;
    logic p_valid_c_81;
    logic p_valid_c_82;
    logic p_valid_c_83;
    logic p_valid_c_84;
    logic p_valid_c_85;
    logic p_valid_c_86;
    logic p_valid_c_87;
    logic p_valid_c_88;
    logic p_valid_c_89;
    logic p_valid_c_90;
    logic p_valid_c_91;
    logic p_valid_c_92;
    logic p_valid_c_93;
    logic p_valid_c_94;
    logic p_valid_c_95;
    logic [95:0] p_valid;
    logic [7:0] p_cid [0:95];
    logic [7:0] c_cid [0:191];
    logic c_dir [0:191];
    logic [16:0] c_decl [0:191];
    logic [19:0] c_base [0:191];
    logic [19:0] c_size [0:191];
    logic [1:0] c_wp_0;
    logic [1:0] c_wp_1;
    logic [1:0] c_wp_2;
    logic [1:0] c_wp_3;
    logic [1:0] c_wp_4;
    logic [1:0] c_wp_5;
    logic [1:0] c_wp_6;
    logic [1:0] c_wp_7;
    logic [1:0] c_wp_8;
    logic [1:0] c_wp_9;
    logic [1:0] c_wp_10;
    logic [1:0] c_wp_11;
    logic [1:0] c_wp_12;
    logic [1:0] c_wp_13;
    logic [1:0] c_wp_14;
    logic [1:0] c_wp_15;
    logic [1:0] c_wp_16;
    logic [1:0] c_wp_17;
    logic [1:0] c_wp_18;
    logic [1:0] c_wp_19;
    logic [1:0] c_wp_20;
    logic [1:0] c_wp_21;
    logic [1:0] c_wp_22;
    logic [1:0] c_wp_23;
    logic [1:0] c_wp_24;
    logic [1:0] c_wp_25;
    logic [1:0] c_wp_26;
    logic [1:0] c_wp_27;
    logic [1:0] c_wp_28;
    logic [1:0] c_wp_29;
    logic [1:0] c_wp_30;
    logic [1:0] c_wp_31;
    logic [1:0] c_wp_32;
    logic [1:0] c_wp_33;
    logic [1:0] c_wp_34;
    logic [1:0] c_wp_35;
    logic [1:0] c_wp_36;
    logic [1:0] c_wp_37;
    logic [1:0] c_wp_38;
    logic [1:0] c_wp_39;
    logic [1:0] c_wp_40;
    logic [1:0] c_wp_41;
    logic [1:0] c_wp_42;
    logic [1:0] c_wp_43;
    logic [1:0] c_wp_44;
    logic [1:0] c_wp_45;
    logic [1:0] c_wp_46;
    logic [1:0] c_wp_47;
    logic [1:0] c_rp_0;
    logic [1:0] c_rp_1;
    logic [1:0] c_rp_2;
    logic [1:0] c_rp_3;
    logic [1:0] c_rp_4;
    logic [1:0] c_rp_5;
    logic [1:0] c_rp_6;
    logic [1:0] c_rp_7;
    logic [1:0] c_rp_8;
    logic [1:0] c_rp_9;
    logic [1:0] c_rp_10;
    logic [1:0] c_rp_11;
    logic [1:0] c_rp_12;
    logic [1:0] c_rp_13;
    logic [1:0] c_rp_14;
    logic [1:0] c_rp_15;
    logic [1:0] c_rp_16;
    logic [1:0] c_rp_17;
    logic [1:0] c_rp_18;
    logic [1:0] c_rp_19;
    logic [1:0] c_rp_20;
    logic [1:0] c_rp_21;
    logic [1:0] c_rp_22;
    logic [1:0] c_rp_23;
    logic [1:0] c_rp_24;
    logic [1:0] c_rp_25;
    logic [1:0] c_rp_26;
    logic [1:0] c_rp_27;
    logic [1:0] c_rp_28;
    logic [1:0] c_rp_29;
    logic [1:0] c_rp_30;
    logic [1:0] c_rp_31;
    logic [1:0] c_rp_32;
    logic [1:0] c_rp_33;
    logic [1:0] c_rp_34;
    logic [1:0] c_rp_35;
    logic [1:0] c_rp_36;
    logic [1:0] c_rp_37;
    logic [1:0] c_rp_38;
    logic [1:0] c_rp_39;
    logic [1:0] c_rp_40;
    logic [1:0] c_rp_41;
    logic [1:0] c_rp_42;
    logic [1:0] c_rp_43;
    logic [1:0] c_rp_44;
    logic [1:0] c_rp_45;
    logic [1:0] c_rp_46;
    logic [1:0] c_rp_47;
    logic [2:0] c_cnt_0;
    logic [2:0] c_cnt_1;
    logic [2:0] c_cnt_2;
    logic [2:0] c_cnt_3;
    logic [2:0] c_cnt_4;
    logic [2:0] c_cnt_5;
    logic [2:0] c_cnt_6;
    logic [2:0] c_cnt_7;
    logic [2:0] c_cnt_8;
    logic [2:0] c_cnt_9;
    logic [2:0] c_cnt_10;
    logic [2:0] c_cnt_11;
    logic [2:0] c_cnt_12;
    logic [2:0] c_cnt_13;
    logic [2:0] c_cnt_14;
    logic [2:0] c_cnt_15;
    logic [2:0] c_cnt_16;
    logic [2:0] c_cnt_17;
    logic [2:0] c_cnt_18;
    logic [2:0] c_cnt_19;
    logic [2:0] c_cnt_20;
    logic [2:0] c_cnt_21;
    logic [2:0] c_cnt_22;
    logic [2:0] c_cnt_23;
    logic [2:0] c_cnt_24;
    logic [2:0] c_cnt_25;
    logic [2:0] c_cnt_26;
    logic [2:0] c_cnt_27;
    logic [2:0] c_cnt_28;
    logic [2:0] c_cnt_29;
    logic [2:0] c_cnt_30;
    logic [2:0] c_cnt_31;
    logic [2:0] c_cnt_32;
    logic [2:0] c_cnt_33;
    logic [2:0] c_cnt_34;
    logic [2:0] c_cnt_35;
    logic [2:0] c_cnt_36;
    logic [2:0] c_cnt_37;
    logic [2:0] c_cnt_38;
    logic [2:0] c_cnt_39;
    logic [2:0] c_cnt_40;
    logic [2:0] c_cnt_41;
    logic [2:0] c_cnt_42;
    logic [2:0] c_cnt_43;
    logic [2:0] c_cnt_44;
    logic [2:0] c_cnt_45;
    logic [2:0] c_cnt_46;
    logic [2:0] c_cnt_47;
    logic c_ne_0;
    logic c_ne_1;
    logic c_ne_2;
    logic c_ne_3;
    logic c_ne_4;
    logic c_ne_5;
    logic c_ne_6;
    logic c_ne_7;
    logic c_ne_8;
    logic c_ne_9;
    logic c_ne_10;
    logic c_ne_11;
    logic c_ne_12;
    logic c_ne_13;
    logic c_ne_14;
    logic c_ne_15;
    logic c_ne_16;
    logic c_ne_17;
    logic c_ne_18;
    logic c_ne_19;
    logic c_ne_20;
    logic c_ne_21;
    logic c_ne_22;
    logic c_ne_23;
    logic c_ne_24;
    logic c_ne_25;
    logic c_ne_26;
    logic c_ne_27;
    logic c_ne_28;
    logic c_ne_29;
    logic c_ne_30;
    logic c_ne_31;
    logic c_ne_32;
    logic c_ne_33;
    logic c_ne_34;
    logic c_ne_35;
    logic c_ne_36;
    logic c_ne_37;
    logic c_ne_38;
    logic c_ne_39;
    logic c_ne_40;
    logic c_ne_41;
    logic c_ne_42;
    logic c_ne_43;
    logic c_ne_44;
    logic c_ne_45;
    logic c_ne_46;
    logic c_ne_47;
    logic c_fl_0;
    logic c_fl_1;
    logic c_fl_2;
    logic c_fl_3;
    logic c_fl_4;
    logic c_fl_5;
    logic c_fl_6;
    logic c_fl_7;
    logic c_fl_8;
    logic c_fl_9;
    logic c_fl_10;
    logic c_fl_11;
    logic c_fl_12;
    logic c_fl_13;
    logic c_fl_14;
    logic c_fl_15;
    logic c_fl_16;
    logic c_fl_17;
    logic c_fl_18;
    logic c_fl_19;
    logic c_fl_20;
    logic c_fl_21;
    logic c_fl_22;
    logic c_fl_23;
    logic c_fl_24;
    logic c_fl_25;
    logic c_fl_26;
    logic c_fl_27;
    logic c_fl_28;
    logic c_fl_29;
    logic c_fl_30;
    logic c_fl_31;
    logic c_fl_32;
    logic c_fl_33;
    logic c_fl_34;
    logic c_fl_35;
    logic c_fl_36;
    logic c_fl_37;
    logic c_fl_38;
    logic c_fl_39;
    logic c_fl_40;
    logic c_fl_41;
    logic c_fl_42;
    logic c_fl_43;
    logic c_fl_44;
    logic c_fl_45;
    logic c_fl_46;
    logic c_fl_47;
    logic [95:0] c_wp_v;
    logic [95:0] c_rp_v;
    logic [191:0] c_cnt_v;
    logic [47:0] c_ne_v;
    logic [47:0] c_fl_v;
    logic [7:0] cfg_pend;
    logic a1_v;
    logic [5:0] a1_pp;
    logic [5:0] a1_mpp;
    logic [47:0] a1_mask;
    logic ca_v;
    logic [5:0] ca_pp;
    logic [7:0] ca_cid;
    logic ca_dir;
    logic [16:0] ca_decl;
    logic [19:0] ca_base;
    logic [19:0] ca_size;
    logic ic_v;
    logic [7:0] ic_cid;
    logic ic_dir;
    logic [16:0] ic_decl;
    logic [19:0] ic_base;
    logic [19:0] ic_size;
    logic [16:0] ic_dm1;
    logic [6:0] ic_pd;
    logic [7:0] ic_opp;
    logic ic_raww;
    logic pop_q;
    logic [5:0] pop_pp;
    logic [7:0] st_pi_0;
    logic [7:0] st_pi_1;
    logic [2:0] st_have_0;
    logic [2:0] st_have_1;
    logic [19:0] st_base [0:1];
    logic [19:0] st_size [0:1];
    logic st_dir [0:1];
    logic [16:0] st_cnt [0:1];
    logic [7:0] ci_mpi [0:3];
    logic [1:0] ci_mri [0:3];
    logic [2:0] ci_mfl [0:3];
    logic [31:0] ci_wdata [0:3];
    logic ci_write [0:3];
    logic [23:0] ci_tag [0:3];
    logic [1:0] ci_wp;
    logic [1:0] ci_rp;
    logic [2:0] ci_cnt;
    logic [7:0] ch_pi;
    logic [1:0] ch_ri;
    logic [2:0] ch_fl;
    logic [31:0] ch_wdata;
    logic ch_write;
    logic [23:0] ch_tag;
    logic cr_v;
    logic [31:0] cr_d;
    logic [23:0] cr_t;
    logic [7:0] f_cid_0 [0:15];
    logic [7:0] f_cid_1 [0:15];
    logic [7:0] f_cid_2 [0:15];
    logic [2:0] f_q_0 [0:15];
    logic [2:0] f_q_1 [0:15];
    logic [2:0] f_q_2 [0:15];
    logic [15:0] f_tag_0 [0:15];
    logic [15:0] f_tag_1 [0:15];
    logic [15:0] f_tag_2 [0:15];
    logic f_dir_0 [0:15];
    logic f_dir_1 [0:15];
    logic f_dir_2 [0:15];
    logic [19:0] f_addr_0 [0:15];
    logic [19:0] f_addr_1 [0:15];
    logic [19:0] f_addr_2 [0:15];
    logic [19:0] f_bytes_0 [0:15];
    logic [19:0] f_bytes_1 [0:15];
    logic [19:0] f_bytes_2 [0:15];
    logic [15:0] f_rm1_0 [0:15];
    logic [15:0] f_rm1_1 [0:15];
    logic [15:0] f_rm1_2 [0:15];
    logic f_one_0 [0:15];
    logic f_one_1 [0:15];
    logic f_one_2 [0:15];
    logic [19:0] f_stride_0 [0:15];
    logic [19:0] f_stride_1 [0:15];
    logic [19:0] f_stride_2 [0:15];
    logic f_last_0 [0:15];
    logic f_last_1 [0:15];
    logic f_last_2 [0:15];
    logic [3:0] f_wp_0;
    logic [3:0] f_wp_1;
    logic [3:0] f_wp_2;
    logic [3:0] f_ip_0;
    logic [3:0] f_ip_1;
    logic [3:0] f_ip_2;
    logic [3:0] f_cp_0;
    logic [3:0] f_cp_1;
    logic [3:0] f_cp_2;
    logic [4:0] f_n_p_0;
    logic [4:0] f_n_p_1;
    logic [4:0] f_n_p_2;
    logic [4:0] f_in_0;
    logic [4:0] f_in_1;
    logic [4:0] f_in_2;
    logic [7:0] ih_cid_0;
    logic [7:0] ih_cid_1;
    logic [7:0] ih_cid_2;
    logic [2:0] ih_q_0;
    logic [2:0] ih_q_1;
    logic [2:0] ih_q_2;
    logic [15:0] ih_tag_0;
    logic [15:0] ih_tag_1;
    logic [15:0] ih_tag_2;
    logic ih_dir_0;
    logic ih_dir_1;
    logic ih_dir_2;
    logic [19:0] ih_bytes_0;
    logic [19:0] ih_bytes_1;
    logic [19:0] ih_bytes_2;
    logic [19:0] ih_stride_0;
    logic [19:0] ih_stride_1;
    logic [19:0] ih_stride_2;
    logic ih_last_0;
    logic ih_last_1;
    logic ih_last_2;
    logic [15:0] ih_rem_0;
    logic [15:0] ih_rem_1;
    logic [15:0] ih_rem_2;
    logic ih_lr_0;
    logic ih_lr_1;
    logic ih_lr_2;
    logic [15:0] fc_rem_0;
    logic [15:0] fc_rem_1;
    logic [15:0] fc_rem_2;
    logic fc_last_0;
    logic fc_last_1;
    logic fc_last_2;
    logic fc_dir_0;
    logic fc_dir_1;
    logic fc_dir_2;
    logic fp_v_0;
    logic fp_v_1;
    logic fp_v_2;
    logic [3:0] fp_wp_0;
    logic [3:0] fp_wp_1;
    logic [3:0] fp_wp_2;
    logic [7:0] fp_cid_0;
    logic [7:0] fp_cid_1;
    logic [7:0] fp_cid_2;
    logic [2:0] fp_q_0;
    logic [2:0] fp_q_1;
    logic [2:0] fp_q_2;
    logic [15:0] fp_tag_0;
    logic [15:0] fp_tag_1;
    logic [15:0] fp_tag_2;
    logic fp_dir_0;
    logic fp_dir_1;
    logic fp_dir_2;
    logic [19:0] fp_addr_0;
    logic [19:0] fp_addr_1;
    logic [19:0] fp_addr_2;
    logic [19:0] fp_bytes_0;
    logic [19:0] fp_bytes_1;
    logic [19:0] fp_bytes_2;
    logic [15:0] fp_rm1_0;
    logic [15:0] fp_rm1_1;
    logic [15:0] fp_rm1_2;
    logic fp_one_0;
    logic fp_one_1;
    logic fp_one_2;
    logic [19:0] fp_stride_0;
    logic [19:0] fp_stride_1;
    logic [19:0] fp_stride_2;
    logic fp_last_0;
    logic fp_last_1;
    logic fp_last_2;
    logic [14:0] f_n;
    logic f_room_0;
    logic f_room_1;
    logic f_room_2;
    logic [19:0] inj_addr [0:2];
    logic [1:0] adm_rr;
    logic rn_v_0;
    logic rn_v_1;
    logic rn_v_2;
    logic [7:0] rn_cid [0:2];
    logic rn_dir_0;
    logic rn_dir_1;
    logic rn_dir_2;
    logic rn_own_0;
    logic rn_own_1;
    logic rn_own_2;
    logic a_v_0;
    logic a_v_1;
    logic a_v_2;
    logic [3:0] a_id_0;
    logic [3:0] a_id_1;
    logic [3:0] a_id_2;
    logic [15:0] a_tag_0;
    logic [15:0] a_tag_1;
    logic [15:0] a_tag_2;
    logic [3:0] b_id_0 [0:15];
    logic [3:0] b_id_1 [0:15];
    logic [3:0] b_id_2 [0:15];
    logic [15:0] b_tag_0 [0:15];
    logic [15:0] b_tag_1 [0:15];
    logic [15:0] b_tag_2 [0:15];
    logic [3:0] b_wp_0;
    logic [3:0] b_wp_1;
    logic [3:0] b_wp_2;
    logic [3:0] b_rp_0;
    logic [3:0] b_rp_1;
    logic [3:0] b_rp_2;
    logic [4:0] b_n_0;
    logic [4:0] b_n_1;
    logic [4:0] b_n_2;
    logic [15:0] pend_write;
    logic [31:0] dbg_mismatch;
    logic [7:0] live_slots;
    logic [15:0] dbg_torn;
    logic hm_q_0;
    logic hm_q_1;
    logic hm_q_2;
    logic [1:0] pw_dec_q;
    logic [31:0] dq_instq;
    logic [31:0] dq_gateq;
    logic [31:0] dq_gateq2;
    logic [1:0] dq_gate_block;
    logic [1:0] dq_admit;
    logic dsp_ev_l_0;
    logic dsp_ev_l_1;
    logic dsp_ev_l_2;
    logic dsp_any;
    logic [7:0] disp_cid;
    logic dp_last;
    logic dbyp_l_0;
    logic dbyp_l_1;
    logic dbyp_l_2;
    logic [16:0] dinc_l_0;
    logic [16:0] dinc_l_1;
    logic [16:0] dinc_l_2;
    logic dfull_l_0;
    logic dfull_l_1;
    logic dfull_l_2;
    logic ddir_l_0;
    logic ddir_l_1;
    logic ddir_l_2;
    logic [16:0] ddm1_l_0;
    logic [16:0] ddm1_l_1;
    logic [16:0] ddm1_l_2;
    logic ret_pend_l_0;
    logic ret_pend_l_1;
    logic ret_pend_l_2;
    logic [7:0] ret_pcid_l_0;
    logic [7:0] ret_pcid_l_1;
    logic [7:0] ret_pcid_l_2;
    logic ret_any;
    logic [1:0] ret_sel;
    logic [7:0] ret_cid;
    logic ret_dir;
    logic ret_raww;
    logic ret_depv;
    logic [7:0] ret_depread;
    logic [7:0] ret_rawpeer;
    logic ret_w_clear;
    logic ret_r_clear;
    logic [6:0] pd_same;
    logic [6:0] pd_opp;
    logic pv_same;
    logic pv_opp;
    logic [7:0] pc_d0;
    logic [7:0] pc_d1;
    logic [7:0] pc_same;
    logic [7:0] pc_opp;
    logic icb_same;
    logic icb_opp;
    logic dir_busy;
    logic opp_hit;
    logic [7:0] opp_cid;
    logic war_busy;
    logic slot_busy;
    logic ca_zero;
    logic ic_fire;
    logic ic_free;
    logic dec;
    logic ic_load;
    logic new_raww;
    logic ret_fire;
    logic [47:0] ne_vec;
    logic a1_hi_any;
    logic [5:0] a1_hi_idx;
    logic [5:0] a1_all_idx;
    logic a1_any;
    logic [5:0] pp1;
    logic a2_ne;
    logic [1:0] a2_rp;
    logic [7:0] a2_idx;
    logic a2_stale;
    logic a2_ok;
    logic h_v_l_0;
    logic h_v_l_1;
    logic h_v_l_2;
    logic [7:0] h_cid_l_0;
    logic [7:0] h_cid_l_1;
    logic [7:0] h_cid_l_2;
    logic h_dir_l_0;
    logic h_dir_l_1;
    logic h_dir_l_2;
    logic h_first_l_0;
    logic h_first_l_1;
    logic h_first_l_2;
    logic [19:0] h_off_l_0;
    logic [19:0] h_off_l_1;
    logic [19:0] h_off_l_2;
    logic [2:0] h_q_l_0;
    logic [2:0] h_q_l_1;
    logic [2:0] h_q_l_2;
    logic [15:0] h_tag_l_0;
    logic [15:0] h_tag_l_1;
    logic [15:0] h_tag_l_2;
    logic [19:0] h_bytes_l_0;
    logic [19:0] h_bytes_l_1;
    logic [19:0] h_bytes_l_2;
    logic [15:0] h_rows_l_0;
    logic [15:0] h_rows_l_1;
    logic [15:0] h_rows_l_2;
    logic [19:0] h_stride_l_0;
    logic [19:0] h_stride_l_1;
    logic [19:0] h_stride_l_2;
    logic h_last_l_0;
    logic h_last_l_1;
    logic h_last_l_2;
    logic [16:0] hacc_l_0;
    logic [16:0] hacc_l_1;
    logic [16:0] hacc_l_2;
    logic active_l_0;
    logic active_l_1;
    logic active_l_2;
    logic quota_ok_l_0;
    logic quota_ok_l_1;
    logic quota_ok_l_2;
    logic raw_ok_l_0;
    logic raw_ok_l_1;
    logic raw_ok_l_2;
    logic infl_ok_l_0;
    logic infl_ok_l_1;
    logic infl_ok_l_2;
    logic pre_l_0;
    logic pre_l_1;
    logic pre_l_2;
    logic [2:0] pre_vec;
    logic adm_win_l_0;
    logic adm_win_l_1;
    logic adm_win_l_2;
    logic [1:0] adm_sel;
    logic adm_any;
    logic go_l_0;
    logic go_l_1;
    logic go_l_2;
    logic [19:0] habs_l_0;
    logic [19:0] habs_l_1;
    logic [19:0] habs_l_2;
    logic hmism_l_0;
    logic hmism_l_1;
    logic hmism_l_2;
    logic [15:0] hrm1_l_0;
    logic [15:0] hrm1_l_1;
    logic [15:0] hrm1_l_2;
    logic hone_l_0;
    logic hone_l_1;
    logic hone_l_2;
    logic mism_q;
    logic [7:0] g_cid;
    logic g_first;
    logic [16:0] hinc_l_0;
    logic [16:0] hinc_l_1;
    logic [16:0] hinc_l_2;
    logic hqf_l_0;
    logic hqf_l_1;
    logic hqf_l_2;
    logic pw_inc;
    logic [15:0] pw_base;
    logic [15:0] pw_base1;
    logic [31:0] instq_nx;
    logic [31:0] gateq_nx;
    logic [31:0] gateq2_nx;
    logic [1:0] gate_block_nx;
    logic acc_we;
    logic [7:0] acc_idx;
    logic [16:0] acc_data;
    logic qf_data;
    logic inj_v_l_0;
    logic inj_v_l_1;
    logic inj_v_l_2;
    logic inj_go_l_0;
    logic inj_go_l_1;
    logic inj_go_l_2;
    logic iadv_l_0;
    logic iadv_l_1;
    logic iadv_l_2;
    logic iin_l_0;
    logic iin_l_1;
    logic iin_l_2;
    logic [3:0] f_ip1_l_0;
    logic [3:0] f_ip1_l_1;
    logic [3:0] f_ip1_l_2;
    logic ibyp_l_0;
    logic ibyp_l_1;
    logic ibyp_l_2;
    logic [7:0] inx_cid_l_0;
    logic [7:0] inx_cid_l_1;
    logic [7:0] inx_cid_l_2;
    logic [2:0] inx_q_l_0;
    logic [2:0] inx_q_l_1;
    logic [2:0] inx_q_l_2;
    logic [15:0] inx_tag_l_0;
    logic [15:0] inx_tag_l_1;
    logic [15:0] inx_tag_l_2;
    logic inx_dir_l_0;
    logic inx_dir_l_1;
    logic inx_dir_l_2;
    logic [19:0] inx_addr_l_0;
    logic [19:0] inx_addr_l_1;
    logic [19:0] inx_addr_l_2;
    logic [19:0] inx_bytes_l_0;
    logic [19:0] inx_bytes_l_1;
    logic [19:0] inx_bytes_l_2;
    logic [15:0] inx_rm1_l_0;
    logic [15:0] inx_rm1_l_1;
    logic [15:0] inx_rm1_l_2;
    logic inx_one_l_0;
    logic inx_one_l_1;
    logic inx_one_l_2;
    logic [19:0] inx_stride_l_0;
    logic [19:0] inx_stride_l_1;
    logic [19:0] inx_stride_l_2;
    logic inx_last_l_0;
    logic inx_last_l_1;
    logic inx_last_l_2;
    logic [16:0] disp_new;
    logic disp_full;
    logic [16:0] disp_dm1;
    logic dsp_we;
    logic [7:0] dsp_idx;
    logic [16:0] dsp_data;
    logic sv_we;
    logic [7:0] sv_idx;
    logic sv_data;
    logic rw_we;
    logic [7:0] rw_idx;
    logic rw_data;
    logic dv_we;
    logic [7:0] dv_idx;
    logic dv_data;
    logic [6:0] ret_pd;
    logic ret_pd_own;
    logic rv_we;
    logic [6:0] rn_pd_l_0;
    logic [6:0] rn_pd_l_1;
    logic [6:0] rn_pd_l_2;
    logic dpv0_l_0;
    logic dpv0_l_1;
    logic dpv0_l_2;
    logic dpv1_l_0;
    logic dpv1_l_1;
    logic dpv1_l_2;
    logic own_reg_l_0;
    logic own_reg_l_1;
    logic own_reg_l_2;
    logic own_hold_l_0;
    logic own_hold_l_1;
    logic own_hold_l_2;
    logic [6:0] rv_idx;
    logic rv_data;
    logic sdone_l_0;
    logic sdone_l_1;
    logic sdone_l_2;
    logic comp_l_0;
    logic comp_l_1;
    logic comp_l_2;
    logic comp_dir_l_0;
    logic comp_dir_l_1;
    logic comp_dir_l_2;
    logic cbyp_l_0;
    logic cbyp_l_1;
    logic cbyp_l_2;
    logic [4:0] f_n_nx_l_0;
    logic [4:0] f_n_nx_l_1;
    logic [4:0] f_n_nx_l_2;
    logic cin_l_0;
    logic cin_l_1;
    logic cin_l_2;
    logic [15:0] cnx_rm1_l_0;
    logic [15:0] cnx_rm1_l_1;
    logic [15:0] cnx_rm1_l_2;
    logic cnx_one_l_0;
    logic cnx_one_l_1;
    logic cnx_one_l_2;
    logic cnx_dir_l_0;
    logic cnx_dir_l_1;
    logic cnx_dir_l_2;
    logic [3:0] f_cp1_l_0;
    logic [3:0] f_cp1_l_1;
    logic [3:0] f_cp1_l_2;
    logic wcomp_l_0;
    logic wcomp_l_1;
    logic wcomp_l_2;
    logic [2:0] comp_q_l_0;
    logic [2:0] comp_q_l_1;
    logic [2:0] comp_q_l_2;
    logic [15:0] comp_tag_l_0;
    logic [15:0] comp_tag_l_1;
    logic [15:0] comp_tag_l_2;
    logic [1:0] pw_dec;
    logic b_pop_l_0;
    logic b_pop_l_1;
    logic b_pop_l_2;
    logic [31:0] cm_off;
    logic cm_inseg;
    logic [7:0] cm_pi;
    logic [1:0] cm_ri;
    logic [2:0] cm_fl;
    logic ci_full;
    logic ci_push;
    logic ci_hv;
    logic [2:0] ci_hfl;
    logic [31:0] ci_hwdata;
    logic ci_hwrite;
    logic [23:0] ci_htag;
    logic ci_inseg;
    logic [7:0] ci_pi;
    logic [1:0] ci_ri;
    logic ci_unit;
    logic ci_pipeok;
    logic [5:0] ci_phys;
    logic [5:0] ch_phys;
    logic ci_cfull;
    logic ci_is_pw;
    logic ci_is_status_w;
    logic ci_mid;
    logic ci_is_parw;
    logic [7:0] st_hpi;
    logic [2:0] st_hhave;
    logic [2:0] st_keep;
    logic [2:0] st_next;
    logic stg_ok;
    logic torn_par;
    logic torn_trig;
    logic cpush;
    logic cr_free;
    logic ci_is_read;
    logic ci_pop;
    logic rd_valid;
    logic [31:0] rd_slot;
    logic [31:0] rd_unit;
    logic [31:0] rd_pipe;
    logic [31:0] rd_val;
    logic [1:0] ci_rp1;
    logic ci_few;
    logic [7:0] chn_pi;
    logic [1:0] chn_ri;
    logic [2:0] chn_fl;
    logic [31:0] chn_wdata;
    logic chn_write;
    logic [23:0] chn_tag;
    logic ch_ld;
    logic [1:0] ci_wp_c;
    logic [7:0] cw_idx;
    logic ci_byp;
    logic [5:0] pp1_f;
    logic c_up_0;
    logic c_up_1;
    logic c_up_2;
    logic c_up_3;
    logic c_up_4;
    logic c_up_5;
    logic c_up_6;
    logic c_up_7;
    logic c_up_8;
    logic c_up_9;
    logic c_up_10;
    logic c_up_11;
    logic c_up_12;
    logic c_up_13;
    logic c_up_14;
    logic c_up_15;
    logic c_up_16;
    logic c_up_17;
    logic c_up_18;
    logic c_up_19;
    logic c_up_20;
    logic c_up_21;
    logic c_up_22;
    logic c_up_23;
    logic c_up_24;
    logic c_up_25;
    logic c_up_26;
    logic c_up_27;
    logic c_up_28;
    logic c_up_29;
    logic c_up_30;
    logic c_up_31;
    logic c_up_32;
    logic c_up_33;
    logic c_up_34;
    logic c_up_35;
    logic c_up_36;
    logic c_up_37;
    logic c_up_38;
    logic c_up_39;
    logic c_up_40;
    logic c_up_41;
    logic c_up_42;
    logic c_up_43;
    logic c_up_44;
    logic c_up_45;
    logic c_up_46;
    logic c_up_47;
    logic c_dn_0;
    logic c_dn_1;
    logic c_dn_2;
    logic c_dn_3;
    logic c_dn_4;
    logic c_dn_5;
    logic c_dn_6;
    logic c_dn_7;
    logic c_dn_8;
    logic c_dn_9;
    logic c_dn_10;
    logic c_dn_11;
    logic c_dn_12;
    logic c_dn_13;
    logic c_dn_14;
    logic c_dn_15;
    logic c_dn_16;
    logic c_dn_17;
    logic c_dn_18;
    logic c_dn_19;
    logic c_dn_20;
    logic c_dn_21;
    logic c_dn_22;
    logic c_dn_23;
    logic c_dn_24;
    logic c_dn_25;
    logic c_dn_26;
    logic c_dn_27;
    logic c_dn_28;
    logic c_dn_29;
    logic c_dn_30;
    logic c_dn_31;
    logic c_dn_32;
    logic c_dn_33;
    logic c_dn_34;
    logic c_dn_35;
    logic c_dn_36;
    logic c_dn_37;
    logic c_dn_38;
    logic c_dn_39;
    logic c_dn_40;
    logic c_dn_41;
    logic c_dn_42;
    logic c_dn_43;
    logic c_dn_44;
    logic c_dn_45;
    logic c_dn_46;
    logic c_dn_47;
    logic [2:0] c_cnt_nx_0;
    logic [2:0] c_cnt_nx_1;
    logic [2:0] c_cnt_nx_2;
    logic [2:0] c_cnt_nx_3;
    logic [2:0] c_cnt_nx_4;
    logic [2:0] c_cnt_nx_5;
    logic [2:0] c_cnt_nx_6;
    logic [2:0] c_cnt_nx_7;
    logic [2:0] c_cnt_nx_8;
    logic [2:0] c_cnt_nx_9;
    logic [2:0] c_cnt_nx_10;
    logic [2:0] c_cnt_nx_11;
    logic [2:0] c_cnt_nx_12;
    logic [2:0] c_cnt_nx_13;
    logic [2:0] c_cnt_nx_14;
    logic [2:0] c_cnt_nx_15;
    logic [2:0] c_cnt_nx_16;
    logic [2:0] c_cnt_nx_17;
    logic [2:0] c_cnt_nx_18;
    logic [2:0] c_cnt_nx_19;
    logic [2:0] c_cnt_nx_20;
    logic [2:0] c_cnt_nx_21;
    logic [2:0] c_cnt_nx_22;
    logic [2:0] c_cnt_nx_23;
    logic [2:0] c_cnt_nx_24;
    logic [2:0] c_cnt_nx_25;
    logic [2:0] c_cnt_nx_26;
    logic [2:0] c_cnt_nx_27;
    logic [2:0] c_cnt_nx_28;
    logic [2:0] c_cnt_nx_29;
    logic [2:0] c_cnt_nx_30;
    logic [2:0] c_cnt_nx_31;
    logic [2:0] c_cnt_nx_32;
    logic [2:0] c_cnt_nx_33;
    logic [2:0] c_cnt_nx_34;
    logic [2:0] c_cnt_nx_35;
    logic [2:0] c_cnt_nx_36;
    logic [2:0] c_cnt_nx_37;
    logic [2:0] c_cnt_nx_38;
    logic [2:0] c_cnt_nx_39;
    logic [2:0] c_cnt_nx_40;
    logic [2:0] c_cnt_nx_41;
    logic [2:0] c_cnt_nx_42;
    logic [2:0] c_cnt_nx_43;
    logic [2:0] c_cnt_nx_44;
    logic [2:0] c_cnt_nx_45;
    logic [2:0] c_cnt_nx_46;
    logic [2:0] c_cnt_nx_47;
    logic [3:0] fi__p0;
    logic [3:0] fi__p1;
    logic [3:0] fi__p2;
    logic bpush__p0;
    logic bpush__p1;
    logic bpush__p2;
    logic [7:0] ic;
    logic a1_hi_any_c0;
    logic a1_hi_any_c1;
    logic a1_hi_any_c2;
    logic a1_hi_any_c3;
    logic a1_hi_any_c4;
    logic a1_hi_any_c5;
    logic a1_hi_any_c6;
    logic a1_hi_any_c7;
    logic a1_hi_any_c8;
    logic a1_hi_any_c9;
    logic a1_hi_any_c10;
    logic a1_hi_any_c11;
    logic a1_hi_any_c12;
    logic a1_hi_any_c13;
    logic a1_hi_any_c14;
    logic a1_all_idx_c0;
    logic a1_all_idx_c1;
    logic a1_all_idx_c2;
    logic a1_all_idx_c3;

    initial begin
        for (int _i = 0; _i < 192; _i++) s_base[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_size[_i] = 0;
        for (int _i = 0; _i < 256; _i++) s_dir[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_decl[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_acc[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_dm1[_i] = 0;
        for (int _i = 0; _i < 256; _i++) s_qfull[_i] = 0;
        for (int _i = 0; _i < 256; _i++) s_dlast[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_disp[_i] = 0;
        for (int _i = 0; _i < 256; _i++) s_raww[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_rawpeer[_i] = 0;
        for (int _i = 0; _i < 256; _i++) s_depv[_i] = 0;
        for (int _i = 0; _i < 192; _i++) s_depread[_i] = 0;
        for (int _i = 0; _i < 96; _i++) p_cid[_i] = 0;
        for (int _i = 0; _i < 192; _i++) c_cid[_i] = 0;
        for (int _i = 0; _i < 192; _i++) c_dir[_i] = 0;
        for (int _i = 0; _i < 192; _i++) c_decl[_i] = 0;
        for (int _i = 0; _i < 192; _i++) c_base[_i] = 0;
        for (int _i = 0; _i < 192; _i++) c_size[_i] = 0;
        for (int _i = 0; _i < 2; _i++) st_base[_i] = 0;
        for (int _i = 0; _i < 2; _i++) st_size[_i] = 0;
        for (int _i = 0; _i < 2; _i++) st_dir[_i] = 0;
        for (int _i = 0; _i < 2; _i++) st_cnt[_i] = 0;
        for (int _i = 0; _i < 4; _i++) ci_mpi[_i] = 0;
        for (int _i = 0; _i < 4; _i++) ci_mri[_i] = 0;
        for (int _i = 0; _i < 4; _i++) ci_mfl[_i] = 0;
        for (int _i = 0; _i < 4; _i++) ci_wdata[_i] = 0;
        for (int _i = 0; _i < 4; _i++) ci_write[_i] = 0;
        for (int _i = 0; _i < 4; _i++) ci_tag[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_cid_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_cid_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_cid_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_q_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_q_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_q_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_tag_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_tag_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_tag_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_dir_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_dir_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_dir_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_addr_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_addr_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_addr_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_bytes_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_bytes_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_bytes_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_rm1_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_rm1_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_rm1_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_one_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_one_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_one_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_stride_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_stride_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_stride_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_last_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_last_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) f_last_2[_i] = 0;
        for (int _i = 0; _i < 3; _i++) inj_addr[_i] = 0;
        for (int _i = 0; _i < 3; _i++) rn_cid[_i] = 0;
        for (int _i = 0; _i < 16; _i++) b_id_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) b_id_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) b_id_2[_i] = 0;
        for (int _i = 0; _i < 16; _i++) b_tag_0[_i] = 0;
        for (int _i = 0; _i < 16; _i++) b_tag_1[_i] = 0;
        for (int _i = 0; _i < 16; _i++) b_tag_2[_i] = 0;
    end

    assign s_valid = {s_valid_c_191, s_valid_c_190, s_valid_c_189, s_valid_c_188, s_valid_c_187, s_valid_c_186,
                      s_valid_c_185, s_valid_c_184, s_valid_c_183, s_valid_c_182, s_valid_c_181, s_valid_c_180,
                      s_valid_c_179, s_valid_c_178, s_valid_c_177, s_valid_c_176, s_valid_c_175, s_valid_c_174,
                      s_valid_c_173, s_valid_c_172, s_valid_c_171, s_valid_c_170, s_valid_c_169, s_valid_c_168,
                      s_valid_c_167, s_valid_c_166, s_valid_c_165, s_valid_c_164, s_valid_c_163, s_valid_c_162,
                      s_valid_c_161, s_valid_c_160, s_valid_c_159, s_valid_c_158, s_valid_c_157, s_valid_c_156,
                      s_valid_c_155, s_valid_c_154, s_valid_c_153, s_valid_c_152, s_valid_c_151, s_valid_c_150,
                      s_valid_c_149, s_valid_c_148, s_valid_c_147, s_valid_c_146, s_valid_c_145, s_valid_c_144,
                      s_valid_c_143, s_valid_c_142, s_valid_c_141, s_valid_c_140, s_valid_c_139, s_valid_c_138,
                      s_valid_c_137, s_valid_c_136, s_valid_c_135, s_valid_c_134, s_valid_c_133, s_valid_c_132,
                      s_valid_c_131, s_valid_c_130, s_valid_c_129, s_valid_c_128, s_valid_c_127, s_valid_c_126,
                      s_valid_c_125, s_valid_c_124, s_valid_c_123, s_valid_c_122, s_valid_c_121, s_valid_c_120,
                      s_valid_c_119, s_valid_c_118, s_valid_c_117, s_valid_c_116, s_valid_c_115, s_valid_c_114,
                      s_valid_c_113, s_valid_c_112, s_valid_c_111, s_valid_c_110, s_valid_c_109, s_valid_c_108,
                      s_valid_c_107, s_valid_c_106, s_valid_c_105, s_valid_c_104, s_valid_c_103, s_valid_c_102,
                      s_valid_c_101, s_valid_c_100, s_valid_c_99, s_valid_c_98, s_valid_c_97, s_valid_c_96,
                      s_valid_c_95, s_valid_c_94, s_valid_c_93, s_valid_c_92, s_valid_c_91, s_valid_c_90, s_valid_c_89,
                      s_valid_c_88, s_valid_c_87, s_valid_c_86, s_valid_c_85, s_valid_c_84, s_valid_c_83, s_valid_c_82,
                      s_valid_c_81, s_valid_c_80, s_valid_c_79, s_valid_c_78, s_valid_c_77, s_valid_c_76, s_valid_c_75,
                      s_valid_c_74, s_valid_c_73, s_valid_c_72, s_valid_c_71, s_valid_c_70, s_valid_c_69, s_valid_c_68,
                      s_valid_c_67, s_valid_c_66, s_valid_c_65, s_valid_c_64, s_valid_c_63, s_valid_c_62, s_valid_c_61,
                      s_valid_c_60, s_valid_c_59, s_valid_c_58, s_valid_c_57, s_valid_c_56, s_valid_c_55, s_valid_c_54,
                      s_valid_c_53, s_valid_c_52, s_valid_c_51, s_valid_c_50, s_valid_c_49, s_valid_c_48, s_valid_c_47,
                      s_valid_c_46, s_valid_c_45, s_valid_c_44, s_valid_c_43, s_valid_c_42, s_valid_c_41, s_valid_c_40,
                      s_valid_c_39, s_valid_c_38, s_valid_c_37, s_valid_c_36, s_valid_c_35, s_valid_c_34, s_valid_c_33,
                      s_valid_c_32, s_valid_c_31, s_valid_c_30, s_valid_c_29, s_valid_c_28, s_valid_c_27, s_valid_c_26,
                      s_valid_c_25, s_valid_c_24, s_valid_c_23, s_valid_c_22, s_valid_c_21, s_valid_c_20, s_valid_c_19,
                      s_valid_c_18, s_valid_c_17, s_valid_c_16, s_valid_c_15, s_valid_c_14, s_valid_c_13, s_valid_c_12,
                      s_valid_c_11, s_valid_c_10, s_valid_c_9, s_valid_c_8, s_valid_c_7, s_valid_c_6, s_valid_c_5,
                      s_valid_c_4, s_valid_c_3, s_valid_c_2, s_valid_c_1, s_valid_c_0};
    assign p_valid = {p_valid_c_95, p_valid_c_94, p_valid_c_93, p_valid_c_92, p_valid_c_91, p_valid_c_90, p_valid_c_89,
                      p_valid_c_88, p_valid_c_87, p_valid_c_86, p_valid_c_85, p_valid_c_84, p_valid_c_83, p_valid_c_82,
                      p_valid_c_81, p_valid_c_80, p_valid_c_79, p_valid_c_78, p_valid_c_77, p_valid_c_76, p_valid_c_75,
                      p_valid_c_74, p_valid_c_73, p_valid_c_72, p_valid_c_71, p_valid_c_70, p_valid_c_69, p_valid_c_68,
                      p_valid_c_67, p_valid_c_66, p_valid_c_65, p_valid_c_64, p_valid_c_63, p_valid_c_62, p_valid_c_61,
                      p_valid_c_60, p_valid_c_59, p_valid_c_58, p_valid_c_57, p_valid_c_56, p_valid_c_55, p_valid_c_54,
                      p_valid_c_53, p_valid_c_52, p_valid_c_51, p_valid_c_50, p_valid_c_49, p_valid_c_48, p_valid_c_47,
                      p_valid_c_46, p_valid_c_45, p_valid_c_44, p_valid_c_43, p_valid_c_42, p_valid_c_41, p_valid_c_40,
                      p_valid_c_39, p_valid_c_38, p_valid_c_37, p_valid_c_36, p_valid_c_35, p_valid_c_34, p_valid_c_33,
                      p_valid_c_32, p_valid_c_31, p_valid_c_30, p_valid_c_29, p_valid_c_28, p_valid_c_27, p_valid_c_26,
                      p_valid_c_25, p_valid_c_24, p_valid_c_23, p_valid_c_22, p_valid_c_21, p_valid_c_20, p_valid_c_19,
                      p_valid_c_18, p_valid_c_17, p_valid_c_16, p_valid_c_15, p_valid_c_14, p_valid_c_13, p_valid_c_12,
                      p_valid_c_11, p_valid_c_10, p_valid_c_9, p_valid_c_8, p_valid_c_7, p_valid_c_6, p_valid_c_5,
                      p_valid_c_4, p_valid_c_3, p_valid_c_2, p_valid_c_1, p_valid_c_0};
    assign c_wp_v = {c_wp_47, c_wp_46, c_wp_45, c_wp_44, c_wp_43, c_wp_42, c_wp_41, c_wp_40, c_wp_39, c_wp_38, c_wp_37,
                     c_wp_36, c_wp_35, c_wp_34, c_wp_33, c_wp_32, c_wp_31, c_wp_30, c_wp_29, c_wp_28, c_wp_27, c_wp_26,
                     c_wp_25, c_wp_24, c_wp_23, c_wp_22, c_wp_21, c_wp_20, c_wp_19, c_wp_18, c_wp_17, c_wp_16, c_wp_15,
                     c_wp_14, c_wp_13, c_wp_12, c_wp_11, c_wp_10, c_wp_9, c_wp_8, c_wp_7, c_wp_6, c_wp_5, c_wp_4,
                     c_wp_3, c_wp_2, c_wp_1, c_wp_0};
    assign c_rp_v = {c_rp_47, c_rp_46, c_rp_45, c_rp_44, c_rp_43, c_rp_42, c_rp_41, c_rp_40, c_rp_39, c_rp_38, c_rp_37,
                     c_rp_36, c_rp_35, c_rp_34, c_rp_33, c_rp_32, c_rp_31, c_rp_30, c_rp_29, c_rp_28, c_rp_27, c_rp_26,
                     c_rp_25, c_rp_24, c_rp_23, c_rp_22, c_rp_21, c_rp_20, c_rp_19, c_rp_18, c_rp_17, c_rp_16, c_rp_15,
                     c_rp_14, c_rp_13, c_rp_12, c_rp_11, c_rp_10, c_rp_9, c_rp_8, c_rp_7, c_rp_6, c_rp_5, c_rp_4,
                     c_rp_3, c_rp_2, c_rp_1, c_rp_0};
    assign c_cnt_v = {{1'd0, c_cnt_47}, {1'd0, c_cnt_46}, {1'd0, c_cnt_45}, {1'd0, c_cnt_44}, {1'd0, c_cnt_43},
                      {1'd0, c_cnt_42}, {1'd0, c_cnt_41}, {1'd0, c_cnt_40}, {1'd0, c_cnt_39}, {1'd0, c_cnt_38},
                      {1'd0, c_cnt_37}, {1'd0, c_cnt_36}, {1'd0, c_cnt_35}, {1'd0, c_cnt_34}, {1'd0, c_cnt_33},
                      {1'd0, c_cnt_32}, {1'd0, c_cnt_31}, {1'd0, c_cnt_30}, {1'd0, c_cnt_29}, {1'd0, c_cnt_28},
                      {1'd0, c_cnt_27}, {1'd0, c_cnt_26}, {1'd0, c_cnt_25}, {1'd0, c_cnt_24}, {1'd0, c_cnt_23},
                      {1'd0, c_cnt_22}, {1'd0, c_cnt_21}, {1'd0, c_cnt_20}, {1'd0, c_cnt_19}, {1'd0, c_cnt_18},
                      {1'd0, c_cnt_17}, {1'd0, c_cnt_16}, {1'd0, c_cnt_15}, {1'd0, c_cnt_14}, {1'd0, c_cnt_13},
                      {1'd0, c_cnt_12}, {1'd0, c_cnt_11}, {1'd0, c_cnt_10}, {1'd0, c_cnt_9}, {1'd0, c_cnt_8},
                      {1'd0, c_cnt_7}, {1'd0, c_cnt_6}, {1'd0, c_cnt_5}, {1'd0, c_cnt_4}, {1'd0, c_cnt_3},
                      {1'd0, c_cnt_2}, {1'd0, c_cnt_1}, {1'd0, c_cnt_0}};
    assign c_ne_v = {c_ne_47, c_ne_46, c_ne_45, c_ne_44, c_ne_43, c_ne_42, c_ne_41, c_ne_40, c_ne_39, c_ne_38, c_ne_37,
                     c_ne_36, c_ne_35, c_ne_34, c_ne_33, c_ne_32, c_ne_31, c_ne_30, c_ne_29, c_ne_28, c_ne_27, c_ne_26,
                     c_ne_25, c_ne_24, c_ne_23, c_ne_22, c_ne_21, c_ne_20, c_ne_19, c_ne_18, c_ne_17, c_ne_16, c_ne_15,
                     c_ne_14, c_ne_13, c_ne_12, c_ne_11, c_ne_10, c_ne_9, c_ne_8, c_ne_7, c_ne_6, c_ne_5, c_ne_4,
                     c_ne_3, c_ne_2, c_ne_1, c_ne_0};
    assign c_fl_v = {c_fl_47, c_fl_46, c_fl_45, c_fl_44, c_fl_43, c_fl_42, c_fl_41, c_fl_40, c_fl_39, c_fl_38, c_fl_37,
                     c_fl_36, c_fl_35, c_fl_34, c_fl_33, c_fl_32, c_fl_31, c_fl_30, c_fl_29, c_fl_28, c_fl_27, c_fl_26,
                     c_fl_25, c_fl_24, c_fl_23, c_fl_22, c_fl_21, c_fl_20, c_fl_19, c_fl_18, c_fl_17, c_fl_16, c_fl_15,
                     c_fl_14, c_fl_13, c_fl_12, c_fl_11, c_fl_10, c_fl_9, c_fl_8, c_fl_7, c_fl_6, c_fl_5, c_fl_4,
                     c_fl_3, c_fl_2, c_fl_1, c_fl_0};
    assign a1_mask = {(a1_mpp < 47), (a1_mpp < 46), (a1_mpp < 45), (a1_mpp < 44), (a1_mpp < 43), (a1_mpp < 42),
                      (a1_mpp < 41), (a1_mpp < 40), (a1_mpp < 39), (a1_mpp < 38), (a1_mpp < 37), (a1_mpp < 36),
                      (a1_mpp < 35), (a1_mpp < 34), (a1_mpp < 33), (a1_mpp < 32), (a1_mpp < 31), (a1_mpp < 30),
                      (a1_mpp < 29), (a1_mpp < 28), (a1_mpp < 27), (a1_mpp < 26), (a1_mpp < 25), (a1_mpp < 24),
                      (a1_mpp < 23), (a1_mpp < 22), (a1_mpp < 21), (a1_mpp < 20), (a1_mpp < 19), (a1_mpp < 18),
                      (a1_mpp < 17), (a1_mpp < 16), (a1_mpp < 15), (a1_mpp < 14), (a1_mpp < 13), (a1_mpp < 12),
                      (a1_mpp < 11), (a1_mpp < 10), (a1_mpp < 9), (a1_mpp < 8), (a1_mpp < 7), (a1_mpp < 6),
                      (a1_mpp < 5), (a1_mpp < 4), (a1_mpp < 3), (a1_mpp < 2), (a1_mpp < 1), (a1_mpp < 0)};
    assign f_n = {f_n_p_2, f_n_p_1, f_n_p_0};
    assign dsp_ev_l_0 = p_0_dsp;
    assign dsp_ev_l_1 = p_1_dsp;
    assign dsp_ev_l_2 = p_2_dsp;
    assign dsp_any = ((dsp_ev_l_0 | dsp_ev_l_1) | dsp_ev_l_2);
    assign disp_cid = (dsp_ev_l_0 ? p_0_dsp_cid : (dsp_ev_l_1 ? p_1_dsp_cid : p_2_dsp_cid));
    assign dp_last = (dp_fb | (dp_data == dp_dm1));
    assign dbyp_l_0 = (dp_v & (dp_idx == p_0_dsp_cid));
    assign dbyp_l_1 = (dp_v & (dp_idx == p_1_dsp_cid));
    assign dbyp_l_2 = (dp_v & (dp_idx == p_2_dsp_cid));
    assign dinc_l_0 = ((dbyp_l_0 ? dp_data : s_disp[p_0_dsp_cid]) + 1);
    assign dinc_l_1 = ((dbyp_l_1 ? dp_data : s_disp[p_1_dsp_cid]) + 1);
    assign dinc_l_2 = ((dbyp_l_2 ? dp_data : s_disp[p_2_dsp_cid]) + 1);
    assign dfull_l_0 = (dbyp_l_0 ? dp_last : s_dlast[p_0_dsp_cid]);
    assign dfull_l_1 = (dbyp_l_1 ? dp_last : s_dlast[p_1_dsp_cid]);
    assign dfull_l_2 = (dbyp_l_2 ? dp_last : s_dlast[p_2_dsp_cid]);
    assign ddir_l_0 = s_dir[p_0_dsp_cid];
    assign ddir_l_1 = s_dir[p_1_dsp_cid];
    assign ddir_l_2 = s_dir[p_2_dsp_cid];
    assign ddm1_l_0 = s_dm1[p_0_dsp_cid];
    assign ddm1_l_1 = s_dm1[p_1_dsp_cid];
    assign ddm1_l_2 = s_dm1[p_2_dsp_cid];
    assign ret_pend_l_0 = rn_v_0;
    assign ret_pend_l_1 = rn_v_1;
    assign ret_pend_l_2 = rn_v_2;
    assign ret_pcid_l_0 = rn_cid[0];
    assign ret_pcid_l_1 = rn_cid[1];
    assign ret_pcid_l_2 = rn_cid[2];
    assign ret_any = ((ret_pend_l_0 | ret_pend_l_1) | ret_pend_l_2);
    assign ret_sel = (ret_pend_l_0 ? 2'd0 : (ret_pend_l_1 ? 2'd1 : 2'd2));
    assign ret_cid = (ret_pend_l_0 ? ret_pcid_l_0 : (ret_pend_l_1 ? ret_pcid_l_1 : ret_pcid_l_2));
    assign ret_dir = (ret_pend_l_0 ? rn_dir_0 : (ret_pend_l_1 ? rn_dir_1 : rn_dir_2));
    assign ret_raww = s_raww[ret_cid];
    assign ret_depv = s_depv[ret_cid];
    assign ret_depread = s_depread[ret_cid];
    assign ret_rawpeer = s_rawpeer[ret_cid];
    assign ret_w_clear = ((ret_dir & ret_depv) & (s_rawpeer[ret_depread] == ret_cid));
    assign ret_r_clear = (((~ret_dir) & ret_raww) & (s_depread[ret_rawpeer] == ret_cid));
    assign pd_same = {ca_pp, ca_dir};
    assign pd_opp = {ca_pp, (~ca_dir)};
    assign pv_same = (p_valid >> pd_same);
    assign pv_opp = (p_valid >> pd_opp);
    assign pc_d0 = p_cid[{ca_pp, 1'd0}];
    assign pc_d1 = p_cid[{ca_pp, 1'd1}];
    assign pc_same = (ca_dir ? pc_d1 : pc_d0);
    assign pc_opp = (ca_dir ? pc_d0 : pc_d1);
    assign icb_same = (ic_v & (ic_pd == pd_same));
    assign icb_opp = (ic_v & (ic_pd == pd_opp));
    assign dir_busy = (icb_same
                       | (pv_same
                          & (~(((1'd0 | (ret_pend_l_0 & (ret_pcid_l_0 == pc_same)))
                               | (ret_pend_l_1 & (ret_pcid_l_1 == pc_same)))
                               | (ret_pend_l_2 & (ret_pcid_l_2 == pc_same))))));
    assign opp_hit = (icb_opp
                      | (pv_opp
                         & (~(((1'd0 | (ret_pend_l_0 & (ret_pcid_l_0 == pc_opp)))
                              | (ret_pend_l_1 & (ret_pcid_l_1 == pc_opp))) | (ret_pend_l_2 & (ret_pcid_l_2 == pc_opp))))));
    assign opp_cid = (icb_opp ? ic_cid : (opp_hit ? pc_opp : 8'd0));
    assign war_busy = (ca_dir & opp_hit);
    assign slot_busy = ((s_valid >> ca_cid) | (ic_v & (ic_cid == ca_cid)));
    assign ca_zero = (ca_decl == 0);
    assign ic_fire = (ic_v & (~dsp_any));
    assign ic_free = ((~ic_v) | (~dsp_any));
    assign dec = ((((ca_v & (~slot_busy)) & (~dir_busy)) & (~war_busy)) & ic_free);
    assign ic_load = (dec & (~ca_zero));
    assign new_raww = ((~ca_dir) & opp_hit);
    assign ret_fire = (ret_any & (~ic_v));
    assign ne_vec = c_ne_v;
    assign a1_hi_any_c0 = ((c_ne_0 & a1_mask[0]) | ((c_ne_1 & a1_mask[1]) | (c_ne_2 & a1_mask[2])));
    assign a1_hi_any_c1 = ((c_ne_3 & a1_mask[3]) | ((c_ne_4 & a1_mask[4]) | (c_ne_5 & a1_mask[5])));
    assign a1_hi_any_c2 = ((c_ne_6 & a1_mask[6]) | ((c_ne_7 & a1_mask[7]) | (c_ne_8 & a1_mask[8])));
    assign a1_hi_any_c3 = ((a1_hi_any_c0 | a1_hi_any_c1)
                           | (a1_hi_any_c2
                              | ((c_ne_9 & a1_mask[9]) | ((c_ne_10 & a1_mask[10]) | (c_ne_11 & a1_mask[11])))));
    assign a1_hi_any_c4 = ((c_ne_12 & a1_mask[12]) | ((c_ne_13 & a1_mask[13]) | (c_ne_14 & a1_mask[14])));
    assign a1_hi_any_c5 = ((c_ne_15 & a1_mask[15]) | ((c_ne_16 & a1_mask[16]) | (c_ne_17 & a1_mask[17])));
    assign a1_hi_any_c6 = ((c_ne_18 & a1_mask[18]) | ((c_ne_19 & a1_mask[19]) | (c_ne_20 & a1_mask[20])));
    assign a1_hi_any_c7 = ((a1_hi_any_c4 | a1_hi_any_c5)
                           | (a1_hi_any_c6
                              | ((c_ne_21 & a1_mask[21]) | ((c_ne_22 & a1_mask[22]) | (c_ne_23 & a1_mask[23])))));
    assign a1_hi_any_c8 = ((c_ne_24 & a1_mask[24]) | ((c_ne_25 & a1_mask[25]) | (c_ne_26 & a1_mask[26])));
    assign a1_hi_any_c9 = ((c_ne_27 & a1_mask[27]) | ((c_ne_28 & a1_mask[28]) | (c_ne_29 & a1_mask[29])));
    assign a1_hi_any_c10 = ((c_ne_30 & a1_mask[30]) | ((c_ne_31 & a1_mask[31]) | (c_ne_32 & a1_mask[32])));
    assign a1_hi_any_c11 = ((a1_hi_any_c8 | a1_hi_any_c9)
                            | (a1_hi_any_c10
                               | ((c_ne_33 & a1_mask[33]) | ((c_ne_34 & a1_mask[34]) | (c_ne_35 & a1_mask[35])))));
    assign a1_hi_any_c12 = ((c_ne_36 & a1_mask[36]) | ((c_ne_37 & a1_mask[37]) | (c_ne_38 & a1_mask[38])));
    assign a1_hi_any_c13 = ((c_ne_39 & a1_mask[39]) | ((c_ne_40 & a1_mask[40]) | (c_ne_41 & a1_mask[41])));
    assign a1_hi_any_c14 = ((c_ne_42 & a1_mask[42]) | ((c_ne_43 & a1_mask[43]) | (c_ne_44 & a1_mask[44])));
    assign a1_hi_any = ((a1_hi_any_c3 | a1_hi_any_c7)
                        | (a1_hi_any_c11
                           | ((a1_hi_any_c12 | a1_hi_any_c13)
                              | (a1_hi_any_c14
                                 | ((c_ne_45 & a1_mask[45]) | ((c_ne_46 & a1_mask[46]) | (c_ne_47 & a1_mask[47])))))));
    assign a1_hi_idx = ((a1_hi_any_c3 | a1_hi_any_c7)
                        ? (a1_hi_any_c3
                           ? ((a1_hi_any_c0 | a1_hi_any_c1)
                              ? (a1_hi_any_c0 ? ((c_ne_0 & a1_mask[0]) ? 6'd0 : ((c_ne_1 & a1_mask[1]) ? 6'd1 : 6'd2)) :
                                ((c_ne_3 & a1_mask[3]) ? 6'd3 :
                                ((c_ne_4 & a1_mask[4]) ? 6'd4 :
                                6'd5))) :
                             (a1_hi_any_c2 ? ((c_ne_6 & a1_mask[6]) ? 6'd6 : ((c_ne_7 & a1_mask[7]) ? 6'd7 : 6'd8)) :
                             ((c_ne_9 & a1_mask[9]) ? 6'd9 :
                             ((c_ne_10 & a1_mask[10]) ? 6'd10 :
                             6'd11)))) :
                          ((a1_hi_any_c4 | a1_hi_any_c5)
                           ? (a1_hi_any_c4
                              ? ((c_ne_12 & a1_mask[12]) ? 6'd12 : ((c_ne_13 & a1_mask[13]) ? 6'd13 : 6'd14)) :
                             ((c_ne_15 & a1_mask[15]) ? 6'd15 :
                             ((c_ne_16 & a1_mask[16]) ? 6'd16 :
                             6'd17))) :
                          (a1_hi_any_c6 ? ((c_ne_18 & a1_mask[18]) ? 6'd18 : ((c_ne_19 & a1_mask[19]) ? 6'd19 : 6'd20))
                           :
                          ((c_ne_21 & a1_mask[21]) ? 6'd21 :
                          ((c_ne_22 & a1_mask[22]) ? 6'd22 :
                          6'd23))))) :
                       (a1_hi_any_c11
                        ? ((a1_hi_any_c8 | a1_hi_any_c9)
                           ? (a1_hi_any_c8
                              ? ((c_ne_24 & a1_mask[24]) ? 6'd24 : ((c_ne_25 & a1_mask[25]) ? 6'd25 : 6'd26)) :
                             ((c_ne_27 & a1_mask[27]) ? 6'd27 :
                             ((c_ne_28 & a1_mask[28]) ? 6'd28 :
                             6'd29))) :
                          (a1_hi_any_c10 ? ((c_ne_30 & a1_mask[30]) ? 6'd30 : ((c_ne_31 & a1_mask[31]) ? 6'd31 : 6'd32))
                           :
                          ((c_ne_33 & a1_mask[33]) ? 6'd33 :
                          ((c_ne_34 & a1_mask[34]) ? 6'd34 :
                          6'd35)))) :
                       ((a1_hi_any_c12 | a1_hi_any_c13)
                        ? (a1_hi_any_c12 ? ((c_ne_36 & a1_mask[36]) ? 6'd36 : ((c_ne_37 & a1_mask[37]) ? 6'd37 : 6'd38))
                           :
                          ((c_ne_39 & a1_mask[39]) ? 6'd39 :
                          ((c_ne_40 & a1_mask[40]) ? 6'd40 :
                          6'd41))) :
                       (a1_hi_any_c14 ? ((c_ne_42 & a1_mask[42]) ? 6'd42 : ((c_ne_43 & a1_mask[43]) ? 6'd43 : 6'd44)) :
                       ((c_ne_45 & a1_mask[45]) ? 6'd45 :
                       ((c_ne_46 & a1_mask[46]) ? 6'd46 :
                       6'd47))))));
    assign a1_all_idx_c0 = ((c_ne_0 | (c_ne_1 | c_ne_2)) | (c_ne_3 | (c_ne_4 | c_ne_5)));
    assign a1_all_idx_c1 = ((c_ne_6 | (c_ne_7 | c_ne_8)) | (c_ne_9 | (c_ne_10 | c_ne_11)));
    assign a1_all_idx_c2 = ((c_ne_12 | (c_ne_13 | c_ne_14)) | (c_ne_15 | (c_ne_16 | c_ne_17)));
    assign a1_all_idx_c3 = ((c_ne_24 | (c_ne_25 | c_ne_26)) | (c_ne_27 | (c_ne_28 | c_ne_29)));
    assign a1_all_idx = (((a1_all_idx_c0 | a1_all_idx_c1)
                          | (a1_all_idx_c2 | ((c_ne_18 | (c_ne_19 | c_ne_20)) | (c_ne_21 | (c_ne_22 | c_ne_23)))))
                         ? ((a1_all_idx_c0 | a1_all_idx_c1)
                            ? (a1_all_idx_c0
                               ? ((c_ne_0 | (c_ne_1 | c_ne_2)) ? (c_ne_0 ? 6'd0 : (c_ne_1 ? 6'd1 : 6'd2)) :
                                 (c_ne_3 ? 6'd3 :
                                 (c_ne_4 ? 6'd4 :
                                 6'd5))) :
                              ((c_ne_6 | (c_ne_7 | c_ne_8)) ? (c_ne_6 ? 6'd6 : (c_ne_7 ? 6'd7 : 6'd8)) :
                              (c_ne_9 ? 6'd9 :
                              (c_ne_10 ? 6'd10 :
                              6'd11)))) :
                           (a1_all_idx_c2
                            ? ((c_ne_12 | (c_ne_13 | c_ne_14)) ? (c_ne_12 ? 6'd12 : (c_ne_13 ? 6'd13 : 6'd14)) :
                              (c_ne_15 ? 6'd15 :
                              (c_ne_16 ? 6'd16 :
                              6'd17))) :
                           ((c_ne_18 | (c_ne_19 | c_ne_20)) ? (c_ne_18 ? 6'd18 : (c_ne_19 ? 6'd19 : 6'd20)) :
                           (c_ne_21 ? 6'd21 :
                           (c_ne_22 ? 6'd22 :
                           6'd23))))) :
                        ((a1_all_idx_c3 | ((c_ne_30 | (c_ne_31 | c_ne_32)) | (c_ne_33 | (c_ne_34 | c_ne_35))))
                         ? (a1_all_idx_c3
                            ? ((c_ne_24 | (c_ne_25 | c_ne_26)) ? (c_ne_24 ? 6'd24 : (c_ne_25 ? 6'd25 : 6'd26)) :
                              (c_ne_27 ? 6'd27 :
                              (c_ne_28 ? 6'd28 :
                              6'd29))) :
                           ((c_ne_30 | (c_ne_31 | c_ne_32)) ? (c_ne_30 ? 6'd30 : (c_ne_31 ? 6'd31 : 6'd32)) :
                           (c_ne_33 ? 6'd33 :
                           (c_ne_34 ? 6'd34 :
                           6'd35)))) :
                        (((c_ne_36 | (c_ne_37 | c_ne_38)) | (c_ne_39 | (c_ne_40 | c_ne_41)))
                         ? ((c_ne_36 | (c_ne_37 | c_ne_38)) ? (c_ne_36 ? 6'd36 : (c_ne_37 ? 6'd37 : 6'd38)) :
                           (c_ne_39 ? 6'd39 :
                           (c_ne_40 ? 6'd40 :
                           6'd41))) :
                        ((c_ne_42 | (c_ne_43 | c_ne_44)) ? (c_ne_42 ? 6'd42 : (c_ne_43 ? 6'd43 : 6'd44)) :
                        (c_ne_45 ? 6'd45 :
                        (c_ne_46 ? 6'd46 :
                        6'd47))))));
    assign a1_any = (ne_vec != 0);
    assign pp1 = (a1_hi_any ? a1_hi_idx : a1_all_idx);
    assign a2_ne = (c_ne_v >> a1_pp);
    assign a2_rp = (c_rp_v >> {a1_pp, 1'd0});
    assign a2_idx = {a1_pp, a2_rp};
    assign a2_stale = ((pop_q & (pop_pp == a1_pp)) | (dec & (ca_pp == a1_pp)));
    assign a2_ok = ((a1_v & a2_ne) & (~a2_stale));
    assign h_v_l_0 = h_0_valid;
    assign h_v_l_1 = h_1_valid;
    assign h_v_l_2 = h_2_valid;
    assign h_cid_l_0 = h_0_cid;
    assign h_cid_l_1 = h_1_cid;
    assign h_cid_l_2 = h_2_cid;
    assign h_dir_l_0 = h_0_dir;
    assign h_dir_l_1 = h_1_dir;
    assign h_dir_l_2 = h_2_dir;
    assign h_first_l_0 = h_0_first;
    assign h_first_l_1 = h_1_first;
    assign h_first_l_2 = h_2_first;
    assign h_off_l_0 = h_0_off;
    assign h_off_l_1 = h_1_off;
    assign h_off_l_2 = h_2_off;
    assign h_q_l_0 = h_0_q;
    assign h_q_l_1 = h_1_q;
    assign h_q_l_2 = h_2_q;
    assign h_tag_l_0 = h_0_tag;
    assign h_tag_l_1 = h_1_tag;
    assign h_tag_l_2 = h_2_tag;
    assign h_bytes_l_0 = h_0_bytes;
    assign h_bytes_l_1 = h_1_bytes;
    assign h_bytes_l_2 = h_2_bytes;
    assign h_rows_l_0 = h_0_rows;
    assign h_rows_l_1 = h_1_rows;
    assign h_rows_l_2 = h_2_rows;
    assign h_stride_l_0 = h_0_stride;
    assign h_stride_l_1 = h_1_stride;
    assign h_stride_l_2 = h_2_stride;
    assign h_last_l_0 = h_0_last;
    assign h_last_l_1 = h_1_last;
    assign h_last_l_2 = h_2_last;
    assign hacc_l_0 = ((acc_pv & (acc_pidx == h_cid_l_0)) ? acc_pdata : s_acc[h_cid_l_0]);
    assign hacc_l_1 = ((acc_pv & (acc_pidx == h_cid_l_1)) ? acc_pdata : s_acc[h_cid_l_1]);
    assign hacc_l_2 = ((acc_pv & (acc_pidx == h_cid_l_2)) ? acc_pdata : s_acc[h_cid_l_2]);
    assign active_l_0 = (s_valid >> h_cid_l_0);
    assign active_l_1 = (s_valid >> h_cid_l_1);
    assign active_l_2 = (s_valid >> h_cid_l_2);
    assign quota_ok_l_0 = (~(h_first_l_0 & ((acc_pv & (acc_pidx == h_cid_l_0)) ? qf_pdata : s_qfull[h_cid_l_0])));
    assign quota_ok_l_1 = (~(h_first_l_1 & ((acc_pv & (acc_pidx == h_cid_l_1)) ? qf_pdata : s_qfull[h_cid_l_1])));
    assign quota_ok_l_2 = (~(h_first_l_2 & ((acc_pv & (acc_pidx == h_cid_l_2)) ? qf_pdata : s_qfull[h_cid_l_2])));
    assign raw_ok_l_0 = (h_dir_l_0 | (~s_raww[h_cid_l_0]));
    assign raw_ok_l_1 = (h_dir_l_1 | (~s_raww[h_cid_l_1]));
    assign raw_ok_l_2 = (h_dir_l_2 | (~s_raww[h_cid_l_2]));
    assign infl_ok_l_0 = f_room_0;
    assign infl_ok_l_1 = f_room_1;
    assign infl_ok_l_2 = f_room_2;
    assign pre_l_0 = ((((h_v_l_0 & active_l_0) & quota_ok_l_0) & raw_ok_l_0) & infl_ok_l_0);
    assign pre_l_1 = ((((h_v_l_1 & active_l_1) & quota_ok_l_1) & raw_ok_l_1) & infl_ok_l_1);
    assign pre_l_2 = ((((h_v_l_2 & active_l_2) & quota_ok_l_2) & raw_ok_l_2) & infl_ok_l_2);
    assign pre_vec = {pre_l_2, pre_l_1, pre_l_0};
    assign adm_win_l_0 = (pre_l_0
                          & (~((1'd0
                               | (pre_l_1
                                  & ((adm_rr == 0) ? 1'd0 : ((adm_rr == 1) ? 1'd1 : ((adm_rr == 2) ? 1'd0 : 1'd0)))))
                               | (pre_l_2
                                  & ((adm_rr == 0) ? 1'd0 : ((adm_rr == 1) ? 1'd1 : ((adm_rr == 2) ? 1'd1 : 1'd1)))))));
    assign adm_win_l_1 = (pre_l_1
                          & (~((1'd0
                               | (pre_l_0
                                  & ((adm_rr == 0) ? 1'd1 : ((adm_rr == 1) ? 1'd0 : ((adm_rr == 2) ? 1'd1 : 1'd1)))))
                               | (pre_l_2
                                  & ((adm_rr == 0) ? 1'd0 : ((adm_rr == 1) ? 1'd0 : ((adm_rr == 2) ? 1'd1 : 1'd1)))))));
    assign adm_win_l_2 = (pre_l_2
                          & (~((1'd0
                               | (pre_l_0
                                  & ((adm_rr == 0) ? 1'd1 : ((adm_rr == 1) ? 1'd0 : ((adm_rr == 2) ? 1'd0 : 1'd0)))))
                               | (pre_l_1
                                  & ((adm_rr == 0) ? 1'd1 : ((adm_rr == 1) ? 1'd1 : ((adm_rr == 2) ? 1'd0 : 1'd0)))))));
    assign adm_sel = (adm_win_l_0 ? 2'd0 : (adm_win_l_1 ? 2'd1 : 2'd2));
    assign adm_any = ((pre_vec != 0) & (~ic_fire));
    assign go_l_0 = (adm_win_l_0 & (~ic_fire));
    assign go_l_1 = (adm_win_l_1 & (~ic_fire));
    assign go_l_2 = (adm_win_l_2 & (~ic_fire));
    assign h_0_pop = go_l_0;
    assign h_1_pop = go_l_1;
    assign h_2_pop = go_l_2;
    assign habs_l_0 = (s_base[h_cid_l_0] + h_off_l_0[19:0]);
    assign habs_l_1 = (s_base[h_cid_l_1] + h_off_l_1[19:0]);
    assign habs_l_2 = (s_base[h_cid_l_2] + h_off_l_2[19:0]);
    assign hmism_l_0 = ((~(h_off_l_0 < s_size[h_cid_l_0]))
                        | (({1'd0, s_base[h_cid_l_0]} + {1'd0, h_off_l_0}) >= 21'd262144));
    assign hmism_l_1 = ((~(h_off_l_1 < s_size[h_cid_l_1]))
                        | (({1'd0, s_base[h_cid_l_1]} + {1'd0, h_off_l_1}) >= 21'd262144));
    assign hmism_l_2 = ((~(h_off_l_2 < s_size[h_cid_l_2]))
                        | (({1'd0, s_base[h_cid_l_2]} + {1'd0, h_off_l_2}) >= 21'd262144));
    assign hrm1_l_0 = (h_rows_l_0 - 1);
    assign hrm1_l_1 = (h_rows_l_1 - 1);
    assign hrm1_l_2 = (h_rows_l_2 - 1);
    assign hone_l_0 = (h_rows_l_0 <= 1);
    assign hone_l_1 = (h_rows_l_1 <= 1);
    assign hone_l_2 = (h_rows_l_2 <= 1);
    assign mism_q = (((a_v_0 & hm_q_0) | (a_v_1 & hm_q_1)) | (a_v_2 & hm_q_2));
    assign g_cid = ((adm_sel == 0) ? h_cid_l_0 :
                   ((adm_sel == 1) ? h_cid_l_1 :
                   ((adm_sel == 2) ? h_cid_l_2 :
                   h_cid_l_2)));
    assign g_first = ((adm_sel == 0) ? h_first_l_0 :
                     ((adm_sel == 1) ? h_first_l_1 :
                     ((adm_sel == 2) ? h_first_l_2 :
                     h_first_l_2)));
    assign hinc_l_0 = (hacc_l_0 + 1);
    assign hinc_l_1 = (hacc_l_1 + 1);
    assign hinc_l_2 = (hacc_l_2 + 1);
    assign hqf_l_0 = (hacc_l_0 >= s_dm1[h_cid_l_0]);
    assign hqf_l_1 = (hacc_l_1 >= s_dm1[h_cid_l_1]);
    assign hqf_l_2 = (hacc_l_2 >= s_dm1[h_cid_l_2]);
    assign pw_inc = (((go_l_0 & h_dir_l_0) | (go_l_1 & h_dir_l_1)) | (go_l_2 & h_dir_l_2));
    assign pw_base = (pend_write - {14'd0, pw_dec_q});
    assign pw_base1 = (pw_base + 1);
    assign dbg_admit = dq_admit;
    assign dbg_instq = dq_instq;
    assign dbg_gateq = dq_gateq;
    assign dbg_gateq2 = dq_gateq2;
    assign dbg_gate_block = dq_gate_block;
    assign instq_nx = {ca_v, dir_busy, war_busy, slot_busy, 4'd0, ca_cid, opp_cid, 8'd0};
    assign gateq_nx = {6'd0, h_v_l_0, active_l_0, quota_ok_l_0, raw_ok_l_0, infl_ok_l_0, h_cid_l_0, h_v_l_1, active_l_1,
                       quota_ok_l_1, raw_ok_l_1, infl_ok_l_1, h_cid_l_1};
    assign gateq2_nx = {19'd0, h_v_l_2, active_l_2, quota_ok_l_2, raw_ok_l_2, infl_ok_l_2, h_cid_l_2};
    assign gate_block_nx = (({1'd0, (h_v_l_0 & (~go_l_0))} + {1'd0, (h_v_l_1 & (~go_l_1))})
                            + {1'd0, (h_v_l_2 & (~go_l_2))});
    assign acc_we = (((ic_fire | (go_l_0 & h_first_l_0)) | (go_l_1 & h_first_l_1)) | (go_l_2 & h_first_l_2));
    assign acc_idx = (ic_fire ? ic_cid :
                     (((8'd0 | (go_l_0 ? h_cid_l_0 : 8'd0)) | (go_l_1 ? h_cid_l_1 : 8'd0))
                      | (go_l_2 ? h_cid_l_2 : 8'd0)));
    assign acc_data = (((17'd0 | (go_l_0 ? hinc_l_0 : 17'd0)) | (go_l_1 ? hinc_l_1 : 17'd0))
                       | (go_l_2 ? hinc_l_2 : 17'd0));
    assign qf_data = (((1'd0 | (go_l_0 & hqf_l_0)) | (go_l_1 & hqf_l_1)) | (go_l_2 & hqf_l_2));
    assign inj_v_l_0 = (f_in_0 != 0);
    assign inj_v_l_1 = (f_in_1 != 0);
    assign inj_v_l_2 = (f_in_2 != 0);
    assign inj_go_l_0 = (inj_v_l_0 & p_0_s_ready);
    assign inj_go_l_1 = (inj_v_l_1 & p_1_s_ready);
    assign inj_go_l_2 = (inj_v_l_2 & p_2_s_ready);
    assign iadv_l_0 = (inj_go_l_0 & ih_lr_0);
    assign iadv_l_1 = (inj_go_l_1 & ih_lr_1);
    assign iadv_l_2 = (inj_go_l_2 & ih_lr_2);
    assign f_ip1_l_0 = (f_ip_0 + 1);
    assign f_ip1_l_1 = (f_ip_1 + 1);
    assign f_ip1_l_2 = (f_ip_2 + 1);
    assign iin_l_0 = (iadv_l_0 ? (f_in_0 == 1) : (f_in_0 == 0));
    assign iin_l_1 = (iadv_l_1 ? (f_in_1 == 1) : (f_in_1 == 0));
    assign iin_l_2 = (iadv_l_2 ? (f_in_2 == 1) : (f_in_2 == 0));
    assign ibyp_l_0 = (fp_v_0 & (fp_wp_0 == f_ip1_l_0));
    assign ibyp_l_1 = (fp_v_1 & (fp_wp_1 == f_ip1_l_1));
    assign ibyp_l_2 = (fp_v_2 & (fp_wp_2 == f_ip1_l_2));
    assign inx_cid_l_0 = (ibyp_l_0 ? fp_cid_0 : f_cid_0[f_ip1_l_0]);
    assign inx_cid_l_1 = (ibyp_l_1 ? fp_cid_1 : f_cid_1[f_ip1_l_1]);
    assign inx_cid_l_2 = (ibyp_l_2 ? fp_cid_2 : f_cid_2[f_ip1_l_2]);
    assign inx_q_l_0 = (ibyp_l_0 ? fp_q_0 : f_q_0[f_ip1_l_0]);
    assign inx_q_l_1 = (ibyp_l_1 ? fp_q_1 : f_q_1[f_ip1_l_1]);
    assign inx_q_l_2 = (ibyp_l_2 ? fp_q_2 : f_q_2[f_ip1_l_2]);
    assign inx_tag_l_0 = (ibyp_l_0 ? fp_tag_0 : f_tag_0[f_ip1_l_0]);
    assign inx_tag_l_1 = (ibyp_l_1 ? fp_tag_1 : f_tag_1[f_ip1_l_1]);
    assign inx_tag_l_2 = (ibyp_l_2 ? fp_tag_2 : f_tag_2[f_ip1_l_2]);
    assign inx_dir_l_0 = (ibyp_l_0 ? fp_dir_0 : f_dir_0[f_ip1_l_0]);
    assign inx_dir_l_1 = (ibyp_l_1 ? fp_dir_1 : f_dir_1[f_ip1_l_1]);
    assign inx_dir_l_2 = (ibyp_l_2 ? fp_dir_2 : f_dir_2[f_ip1_l_2]);
    assign inx_addr_l_0 = (ibyp_l_0 ? fp_addr_0 : f_addr_0[f_ip1_l_0]);
    assign inx_addr_l_1 = (ibyp_l_1 ? fp_addr_1 : f_addr_1[f_ip1_l_1]);
    assign inx_addr_l_2 = (ibyp_l_2 ? fp_addr_2 : f_addr_2[f_ip1_l_2]);
    assign inx_bytes_l_0 = (ibyp_l_0 ? fp_bytes_0 : f_bytes_0[f_ip1_l_0]);
    assign inx_bytes_l_1 = (ibyp_l_1 ? fp_bytes_1 : f_bytes_1[f_ip1_l_1]);
    assign inx_bytes_l_2 = (ibyp_l_2 ? fp_bytes_2 : f_bytes_2[f_ip1_l_2]);
    assign inx_rm1_l_0 = (ibyp_l_0 ? fp_rm1_0 : f_rm1_0[f_ip1_l_0]);
    assign inx_rm1_l_1 = (ibyp_l_1 ? fp_rm1_1 : f_rm1_1[f_ip1_l_1]);
    assign inx_rm1_l_2 = (ibyp_l_2 ? fp_rm1_2 : f_rm1_2[f_ip1_l_2]);
    assign inx_one_l_0 = (ibyp_l_0 ? fp_one_0 : f_one_0[f_ip1_l_0]);
    assign inx_one_l_1 = (ibyp_l_1 ? fp_one_1 : f_one_1[f_ip1_l_1]);
    assign inx_one_l_2 = (ibyp_l_2 ? fp_one_2 : f_one_2[f_ip1_l_2]);
    assign inx_stride_l_0 = (ibyp_l_0 ? fp_stride_0 : f_stride_0[f_ip1_l_0]);
    assign inx_stride_l_1 = (ibyp_l_1 ? fp_stride_1 : f_stride_1[f_ip1_l_1]);
    assign inx_stride_l_2 = (ibyp_l_2 ? fp_stride_2 : f_stride_2[f_ip1_l_2]);
    assign inx_last_l_0 = (ibyp_l_0 ? fp_last_0 : f_last_0[f_ip1_l_0]);
    assign inx_last_l_1 = (ibyp_l_1 ? fp_last_1 : f_last_1[f_ip1_l_1]);
    assign inx_last_l_2 = (ibyp_l_2 ? fp_last_2 : f_last_2[f_ip1_l_2]);
    assign disp_new = (dsp_ev_l_0 ? dinc_l_0 : (dsp_ev_l_1 ? dinc_l_1 : dinc_l_2));
    assign disp_full = (dsp_ev_l_0 ? dfull_l_0 : (dsp_ev_l_1 ? dfull_l_1 : dfull_l_2));
    assign disp_dm1 = (dsp_ev_l_0 ? ddm1_l_0 : (dsp_ev_l_1 ? ddm1_l_1 : ddm1_l_2));
    assign dsp_we = (ic_fire | dsp_any);
    assign dsp_idx = (dsp_any ? disp_cid : ic_cid);
    assign dsp_data = (dsp_any ? disp_new : 17'd0);
    assign p_0_dsp_ok = ((~rn_v_0) & (~dsp_ev_l_0));
    assign p_1_dsp_ok = ((~rn_v_1) & (~dsp_ev_l_1));
    assign p_2_dsp_ok = ((~rn_v_2) & (~dsp_ev_l_2));
    assign p_0_s_valid = inj_go_l_0;
    assign p_0_s_addr = inj_addr[0];
    assign p_0_s_bytes = ih_bytes_0;
    assign p_0_s_dir = ih_dir_0;
    assign p_0_s_tag = ih_tag_0;
    assign p_0_s_q = ih_q_0;
    assign p_0_s_mid = {1'd0, ih_q_0};
    assign p_0_s_last = ih_lr_0;
    assign p_0_s_cid = ih_cid_0;
    assign p_0_s_cnt = (ih_lr_0 & ih_last_0);
    assign p_1_s_valid = inj_go_l_1;
    assign p_1_s_addr = inj_addr[1];
    assign p_1_s_bytes = ih_bytes_1;
    assign p_1_s_dir = ih_dir_1;
    assign p_1_s_tag = ih_tag_1;
    assign p_1_s_q = ih_q_1;
    assign p_1_s_mid = {1'd0, ih_q_1};
    assign p_1_s_last = ih_lr_1;
    assign p_1_s_cid = ih_cid_1;
    assign p_1_s_cnt = (ih_lr_1 & ih_last_1);
    assign p_2_s_valid = inj_go_l_2;
    assign p_2_s_addr = inj_addr[2];
    assign p_2_s_bytes = ih_bytes_2;
    assign p_2_s_dir = ih_dir_2;
    assign p_2_s_tag = ih_tag_2;
    assign p_2_s_q = ih_q_2;
    assign p_2_s_mid = {1'd0, ih_q_2};
    assign p_2_s_last = ih_lr_2;
    assign p_2_s_cid = ih_cid_2;
    assign p_2_s_cnt = (ih_lr_2 & ih_last_2);
    assign sv_we = (ic_fire | ret_fire);
    assign sv_idx = (ic_v ? ic_cid : ret_cid);
    assign sv_data = ic_v;
    assign rw_we = (ic_fire | (ret_fire & (ret_w_clear | ret_r_clear)));
    assign rw_idx = (ic_v ? ic_cid : (ret_dir ? ret_depread : ret_cid));
    assign rw_data = (ic_v & ic_raww);
    assign dv_we = ((ic_fire & ic_raww) | (ret_fire & (ret_dir | ret_r_clear)));
    assign dv_idx = (ic_v ? ic_opp : (ret_dir ? ret_cid : ret_rawpeer));
    assign dv_data = ic_v;
    assign ret_pd = {ret_cid[7:2], ret_dir};
    assign ret_pd_own = (ret_pend_l_0 ? rn_own_0 : (ret_pend_l_1 ? rn_own_1 : rn_own_2));
    assign rv_we = (ic_fire | (ret_fire & ret_pd_own));
    assign rn_pd_l_0 = {ret_pcid_l_0[7:2], rn_dir_0};
    assign rn_pd_l_1 = {ret_pcid_l_1[7:2], rn_dir_1};
    assign rn_pd_l_2 = {ret_pcid_l_2[7:2], rn_dir_2};
    assign dpv0_l_0 = (p_valid >> {p_0_dsp_cid[7:2], 1'd0});
    assign dpv0_l_1 = (p_valid >> {p_1_dsp_cid[7:2], 1'd0});
    assign dpv0_l_2 = (p_valid >> {p_2_dsp_cid[7:2], 1'd0});
    assign dpv1_l_0 = (p_valid >> {p_0_dsp_cid[7:2], 1'd1});
    assign dpv1_l_1 = (p_valid >> {p_1_dsp_cid[7:2], 1'd1});
    assign dpv1_l_2 = (p_valid >> {p_2_dsp_cid[7:2], 1'd1});
    assign own_reg_l_0 = (ddir_l_0 ? (dpv1_l_0 & (p_cid[{p_0_dsp_cid[7:2], 1'd1}] == p_0_dsp_cid)) :
                         (dpv0_l_0 & (p_cid[{p_0_dsp_cid[7:2], 1'd0}] == p_0_dsp_cid)));
    assign own_reg_l_1 = (ddir_l_1 ? (dpv1_l_1 & (p_cid[{p_1_dsp_cid[7:2], 1'd1}] == p_1_dsp_cid)) :
                         (dpv0_l_1 & (p_cid[{p_1_dsp_cid[7:2], 1'd0}] == p_1_dsp_cid)));
    assign own_reg_l_2 = (ddir_l_2 ? (dpv1_l_2 & (p_cid[{p_2_dsp_cid[7:2], 1'd1}] == p_2_dsp_cid)) :
                         (dpv0_l_2 & (p_cid[{p_2_dsp_cid[7:2], 1'd0}] == p_2_dsp_cid)));
    assign own_hold_l_0 = ((ic_fire & (ic_pd == rn_pd_l_0)) ? (ic_cid == ret_pcid_l_0) : rn_own_0);
    assign own_hold_l_1 = ((ic_fire & (ic_pd == rn_pd_l_1)) ? (ic_cid == ret_pcid_l_1) : rn_own_1);
    assign own_hold_l_2 = ((ic_fire & (ic_pd == rn_pd_l_2)) ? (ic_cid == ret_pcid_l_2) : rn_own_2);
    assign rv_idx = (ic_v ? ic_pd : ret_pd);
    assign rv_data = ic_v;
    assign sdone_l_0 = p_0_sdone;
    assign sdone_l_1 = p_1_sdone;
    assign sdone_l_2 = p_2_sdone;
    assign comp_l_0 = (sdone_l_0 & fc_last_0);
    assign comp_l_1 = (sdone_l_1 & fc_last_1);
    assign comp_l_2 = (sdone_l_2 & fc_last_2);
    assign comp_dir_l_0 = fc_dir_0;
    assign comp_dir_l_1 = fc_dir_1;
    assign comp_dir_l_2 = fc_dir_2;
    assign f_cp1_l_0 = (f_cp_0 + 1);
    assign f_cp1_l_1 = (f_cp_1 + 1);
    assign f_cp1_l_2 = (f_cp_2 + 1);
    assign cin_l_0 = (comp_l_0 ? (f_n_p_0 == 1) : (f_n_p_0 == 0));
    assign cin_l_1 = (comp_l_1 ? (f_n_p_1 == 1) : (f_n_p_1 == 0));
    assign cin_l_2 = (comp_l_2 ? (f_n_p_2 == 1) : (f_n_p_2 == 0));
    assign cbyp_l_0 = (fp_v_0 & (fp_wp_0 == f_cp1_l_0));
    assign cbyp_l_1 = (fp_v_1 & (fp_wp_1 == f_cp1_l_1));
    assign cbyp_l_2 = (fp_v_2 & (fp_wp_2 == f_cp1_l_2));
    assign cnx_rm1_l_0 = (cbyp_l_0 ? fp_rm1_0 : f_rm1_0[f_cp1_l_0]);
    assign cnx_rm1_l_1 = (cbyp_l_1 ? fp_rm1_1 : f_rm1_1[f_cp1_l_1]);
    assign cnx_rm1_l_2 = (cbyp_l_2 ? fp_rm1_2 : f_rm1_2[f_cp1_l_2]);
    assign cnx_one_l_0 = (cbyp_l_0 ? fp_one_0 : f_one_0[f_cp1_l_0]);
    assign cnx_one_l_1 = (cbyp_l_1 ? fp_one_1 : f_one_1[f_cp1_l_1]);
    assign cnx_one_l_2 = (cbyp_l_2 ? fp_one_2 : f_one_2[f_cp1_l_2]);
    assign cnx_dir_l_0 = (cbyp_l_0 ? fp_dir_0 : f_dir_0[f_cp1_l_0]);
    assign cnx_dir_l_1 = (cbyp_l_1 ? fp_dir_1 : f_dir_1[f_cp1_l_1]);
    assign cnx_dir_l_2 = (cbyp_l_2 ? fp_dir_2 : f_dir_2[f_cp1_l_2]);
    assign f_n_nx_l_0 = (go_l_0 ? (comp_l_0 ? f_n_p_0 : (f_n_p_0 + 1)) : (comp_l_0 ? (f_n_p_0 - 1) : f_n_p_0));
    assign f_n_nx_l_1 = (go_l_1 ? (comp_l_1 ? f_n_p_1 : (f_n_p_1 + 1)) : (comp_l_1 ? (f_n_p_1 - 1) : f_n_p_1));
    assign f_n_nx_l_2 = (go_l_2 ? (comp_l_2 ? f_n_p_2 : (f_n_p_2 + 1)) : (comp_l_2 ? (f_n_p_2 - 1) : f_n_p_2));
    assign wcomp_l_0 = ((p_0_sdone_w & comp_dir_l_0) & fc_last_0);
    assign wcomp_l_1 = ((p_1_sdone_w & comp_dir_l_1) & fc_last_1);
    assign wcomp_l_2 = ((p_2_sdone_w & comp_dir_l_2) & fc_last_2);
    assign comp_q_l_0 = f_q_0[f_cp_0];
    assign comp_q_l_1 = f_q_1[f_cp_1];
    assign comp_q_l_2 = f_q_2[f_cp_2];
    assign comp_tag_l_0 = f_tag_0[f_cp_0];
    assign comp_tag_l_1 = f_tag_1[f_cp_1];
    assign comp_tag_l_2 = f_tag_2[f_cp_2];
    assign pw_dec = (({1'd0, wcomp_l_0} + {1'd0, wcomp_l_1}) + {1'd0, wcomp_l_2});
    assign b_0_valid = (b_n_0 != 0);
    assign b_0_id = b_id_0[b_rp_0];
    assign b_0_tag = b_tag_0[b_rp_0];
    assign a_0_valid = a_v_0;
    assign a_0_id = a_id_0;
    assign a_0_tag = a_tag_0;
    assign b_1_valid = (b_n_1 != 0);
    assign b_1_id = b_id_1[b_rp_1];
    assign b_1_tag = b_tag_1[b_rp_1];
    assign a_1_valid = a_v_1;
    assign a_1_id = a_id_1;
    assign a_1_tag = a_tag_1;
    assign b_2_valid = (b_n_2 != 0);
    assign b_2_id = b_id_2[b_rp_2];
    assign b_2_tag = b_tag_2[b_rp_2];
    assign a_2_valid = a_v_2;
    assign a_2_id = a_id_2;
    assign a_2_tag = a_tag_2;
    assign b_pop_l_0 = ((b_n_0 != 0) & b_0_ready);
    assign b_pop_l_1 = ((b_n_1 != 0) & b_1_ready);
    assign b_pop_l_2 = ((b_n_2 != 0) & b_2_ready);
    assign cm_off = (ctrl_s_cm_addr - 528);
    assign cm_inseg = ((ctrl_s_cm_addr >= 528) & (ctrl_s_cm_addr < 1552));
    assign cm_pi = cm_off[9:2];
    assign cm_ri = cm_off[1:0];
    assign cm_fl = {cm_inseg, (cm_pi == 255), (cm_pi < 192)};
    assign ci_full = (ci_cnt == 4);
    assign ctrl_s_cm_ready = (~ci_full);
    assign ci_push = (ctrl_s_cm_valid & (~ci_full));
    assign ci_hv = (ci_cnt != 0);
    assign ci_hfl = ch_fl;
    assign ci_hwdata = ch_wdata;
    assign ci_hwrite = ch_write;
    assign ci_htag = ch_tag;
    assign ci_inseg = ci_hfl[2];
    assign ci_pi = ci_mpi[ci_rp];
    assign ci_ri = ch_ri;
    assign ci_unit = ci_hfl[1];
    assign ci_pipeok = ci_hfl[0];
    assign ci_phys = ci_pi[7:2];
    assign ch_phys = ch_pi[7:2];
    assign ci_cfull = (c_fl_v >> ch_phys);
    assign ci_is_pw = ((((ci_hv & ci_hwrite) & ci_inseg) & (~ci_unit)) & ci_pipeok);
    assign ci_is_status_w = (ci_is_pw & (ci_ri == 0));
    assign ci_mid = ci_htag[20];
    assign ci_is_parw = (ci_is_pw & (ci_ri != 0));
    assign st_hpi = ((ci_mid == 0) ? st_pi_0 : st_pi_1);
    assign st_hhave = ((ci_mid == 0) ? st_have_0 : st_have_1);
    assign st_keep = ((ch_pi == st_hpi) ? st_hhave : 3'd0);
    assign st_next = (st_keep | (3'd1 << (ci_ri - 1)));
    assign stg_ok = ((ch_pi == st_hpi) & (st_hhave == 7));
    assign torn_par = ((ci_is_parw & (st_hhave != 0)) & (ch_pi != st_hpi));
    assign torn_trig = (ci_is_status_w & (~stg_ok));
    assign cpush = ((ci_is_status_w & (~ci_cfull)) & stg_ok);
    assign cr_free = ((~cr_v) | ctrl_s_cr_ready);
    assign ci_is_read = (ci_hv & (~ci_hwrite));
    assign ci_pop = (ci_hv & (ci_hwrite ? (ci_is_status_w ? ((~ci_cfull) | (~stg_ok)) : 1'd1) : cr_free));
    assign rd_valid = (s_valid >> ch_pi);
    assign rd_slot = {rd_valid, s_dir[ch_pi], 13'd0, ((dp_v & (dp_idx == ch_pi)) ? dp_data : s_disp[ch_pi])};
    assign rd_unit = ((ci_ri == 0) ? {16'd0, pend_write} :
                     ((ci_ri == 1) ? 32'd0 :
                     ((ci_ri == 2) ? 32'd0 :
                     dbg_mismatch)));
    assign rd_pipe = ((ci_ri == 0) ? rd_slot : 32'd0);
    assign rd_val = (ci_inseg ? (ci_unit ? rd_unit : (ci_pipeok ? rd_pipe : 32'd0)) : 32'd0);
    assign ci_rp1 = (ci_rp + 1);
    assign ci_few = (ci_cnt <= 1);
    assign chn_pi = (ci_few ? cm_pi : ci_mpi[ci_rp1]);
    assign chn_ri = (ci_few ? cm_ri : ci_mri[ci_rp1]);
    assign chn_fl = (ci_few ? cm_fl : ci_mfl[ci_rp1]);
    assign chn_wdata = (ci_few ? ctrl_s_cm_wdata : ci_wdata[ci_rp1]);
    assign chn_write = (ci_few ? ctrl_s_cm_write : ci_write[ci_rp1]);
    assign chn_tag = (ci_few ? ctrl_s_cm_tag : ci_tag[ci_rp1]);
    assign ch_ld = (ci_pop | (ci_push & (ci_cnt == 0)));
    assign ctrl_s_cr_valid = cr_v;
    assign ctrl_s_cr_data = cr_d;
    assign ctrl_s_cr_tag = cr_t;
    assign ci_wp_c = (c_wp_v >> {ch_phys, 1'd0});
    assign cw_idx = {ch_phys, ci_wp_c};
    assign ci_byp = ((~a1_any) & ci_is_status_w);
    assign pp1_f = (a1_any ? pp1 : ci_phys);
    assign c_up_0 = (cpush & (ch_phys == 0));
    assign c_up_1 = (cpush & (ch_phys == 1));
    assign c_up_2 = (cpush & (ch_phys == 2));
    assign c_up_3 = (cpush & (ch_phys == 3));
    assign c_up_4 = (cpush & (ch_phys == 4));
    assign c_up_5 = (cpush & (ch_phys == 5));
    assign c_up_6 = (cpush & (ch_phys == 6));
    assign c_up_7 = (cpush & (ch_phys == 7));
    assign c_up_8 = (cpush & (ch_phys == 8));
    assign c_up_9 = (cpush & (ch_phys == 9));
    assign c_up_10 = (cpush & (ch_phys == 10));
    assign c_up_11 = (cpush & (ch_phys == 11));
    assign c_up_12 = (cpush & (ch_phys == 12));
    assign c_up_13 = (cpush & (ch_phys == 13));
    assign c_up_14 = (cpush & (ch_phys == 14));
    assign c_up_15 = (cpush & (ch_phys == 15));
    assign c_up_16 = (cpush & (ch_phys == 16));
    assign c_up_17 = (cpush & (ch_phys == 17));
    assign c_up_18 = (cpush & (ch_phys == 18));
    assign c_up_19 = (cpush & (ch_phys == 19));
    assign c_up_20 = (cpush & (ch_phys == 20));
    assign c_up_21 = (cpush & (ch_phys == 21));
    assign c_up_22 = (cpush & (ch_phys == 22));
    assign c_up_23 = (cpush & (ch_phys == 23));
    assign c_up_24 = (cpush & (ch_phys == 24));
    assign c_up_25 = (cpush & (ch_phys == 25));
    assign c_up_26 = (cpush & (ch_phys == 26));
    assign c_up_27 = (cpush & (ch_phys == 27));
    assign c_up_28 = (cpush & (ch_phys == 28));
    assign c_up_29 = (cpush & (ch_phys == 29));
    assign c_up_30 = (cpush & (ch_phys == 30));
    assign c_up_31 = (cpush & (ch_phys == 31));
    assign c_up_32 = (cpush & (ch_phys == 32));
    assign c_up_33 = (cpush & (ch_phys == 33));
    assign c_up_34 = (cpush & (ch_phys == 34));
    assign c_up_35 = (cpush & (ch_phys == 35));
    assign c_up_36 = (cpush & (ch_phys == 36));
    assign c_up_37 = (cpush & (ch_phys == 37));
    assign c_up_38 = (cpush & (ch_phys == 38));
    assign c_up_39 = (cpush & (ch_phys == 39));
    assign c_up_40 = (cpush & (ch_phys == 40));
    assign c_up_41 = (cpush & (ch_phys == 41));
    assign c_up_42 = (cpush & (ch_phys == 42));
    assign c_up_43 = (cpush & (ch_phys == 43));
    assign c_up_44 = (cpush & (ch_phys == 44));
    assign c_up_45 = (cpush & (ch_phys == 45));
    assign c_up_46 = (cpush & (ch_phys == 46));
    assign c_up_47 = (cpush & (ch_phys == 47));
    assign c_dn_0 = (pop_q & (pop_pp == 0));
    assign c_dn_1 = (pop_q & (pop_pp == 1));
    assign c_dn_2 = (pop_q & (pop_pp == 2));
    assign c_dn_3 = (pop_q & (pop_pp == 3));
    assign c_dn_4 = (pop_q & (pop_pp == 4));
    assign c_dn_5 = (pop_q & (pop_pp == 5));
    assign c_dn_6 = (pop_q & (pop_pp == 6));
    assign c_dn_7 = (pop_q & (pop_pp == 7));
    assign c_dn_8 = (pop_q & (pop_pp == 8));
    assign c_dn_9 = (pop_q & (pop_pp == 9));
    assign c_dn_10 = (pop_q & (pop_pp == 10));
    assign c_dn_11 = (pop_q & (pop_pp == 11));
    assign c_dn_12 = (pop_q & (pop_pp == 12));
    assign c_dn_13 = (pop_q & (pop_pp == 13));
    assign c_dn_14 = (pop_q & (pop_pp == 14));
    assign c_dn_15 = (pop_q & (pop_pp == 15));
    assign c_dn_16 = (pop_q & (pop_pp == 16));
    assign c_dn_17 = (pop_q & (pop_pp == 17));
    assign c_dn_18 = (pop_q & (pop_pp == 18));
    assign c_dn_19 = (pop_q & (pop_pp == 19));
    assign c_dn_20 = (pop_q & (pop_pp == 20));
    assign c_dn_21 = (pop_q & (pop_pp == 21));
    assign c_dn_22 = (pop_q & (pop_pp == 22));
    assign c_dn_23 = (pop_q & (pop_pp == 23));
    assign c_dn_24 = (pop_q & (pop_pp == 24));
    assign c_dn_25 = (pop_q & (pop_pp == 25));
    assign c_dn_26 = (pop_q & (pop_pp == 26));
    assign c_dn_27 = (pop_q & (pop_pp == 27));
    assign c_dn_28 = (pop_q & (pop_pp == 28));
    assign c_dn_29 = (pop_q & (pop_pp == 29));
    assign c_dn_30 = (pop_q & (pop_pp == 30));
    assign c_dn_31 = (pop_q & (pop_pp == 31));
    assign c_dn_32 = (pop_q & (pop_pp == 32));
    assign c_dn_33 = (pop_q & (pop_pp == 33));
    assign c_dn_34 = (pop_q & (pop_pp == 34));
    assign c_dn_35 = (pop_q & (pop_pp == 35));
    assign c_dn_36 = (pop_q & (pop_pp == 36));
    assign c_dn_37 = (pop_q & (pop_pp == 37));
    assign c_dn_38 = (pop_q & (pop_pp == 38));
    assign c_dn_39 = (pop_q & (pop_pp == 39));
    assign c_dn_40 = (pop_q & (pop_pp == 40));
    assign c_dn_41 = (pop_q & (pop_pp == 41));
    assign c_dn_42 = (pop_q & (pop_pp == 42));
    assign c_dn_43 = (pop_q & (pop_pp == 43));
    assign c_dn_44 = (pop_q & (pop_pp == 44));
    assign c_dn_45 = (pop_q & (pop_pp == 45));
    assign c_dn_46 = (pop_q & (pop_pp == 46));
    assign c_dn_47 = (pop_q & (pop_pp == 47));
    assign c_cnt_nx_0 = ((c_up_0 & (~c_dn_0)) ? (c_cnt_0 + 1) : ((c_dn_0 & (~c_up_0)) ? (c_cnt_0 - 1) : c_cnt_0));
    assign c_cnt_nx_1 = ((c_up_1 & (~c_dn_1)) ? (c_cnt_1 + 1) : ((c_dn_1 & (~c_up_1)) ? (c_cnt_1 - 1) : c_cnt_1));
    assign c_cnt_nx_2 = ((c_up_2 & (~c_dn_2)) ? (c_cnt_2 + 1) : ((c_dn_2 & (~c_up_2)) ? (c_cnt_2 - 1) : c_cnt_2));
    assign c_cnt_nx_3 = ((c_up_3 & (~c_dn_3)) ? (c_cnt_3 + 1) : ((c_dn_3 & (~c_up_3)) ? (c_cnt_3 - 1) : c_cnt_3));
    assign c_cnt_nx_4 = ((c_up_4 & (~c_dn_4)) ? (c_cnt_4 + 1) : ((c_dn_4 & (~c_up_4)) ? (c_cnt_4 - 1) : c_cnt_4));
    assign c_cnt_nx_5 = ((c_up_5 & (~c_dn_5)) ? (c_cnt_5 + 1) : ((c_dn_5 & (~c_up_5)) ? (c_cnt_5 - 1) : c_cnt_5));
    assign c_cnt_nx_6 = ((c_up_6 & (~c_dn_6)) ? (c_cnt_6 + 1) : ((c_dn_6 & (~c_up_6)) ? (c_cnt_6 - 1) : c_cnt_6));
    assign c_cnt_nx_7 = ((c_up_7 & (~c_dn_7)) ? (c_cnt_7 + 1) : ((c_dn_7 & (~c_up_7)) ? (c_cnt_7 - 1) : c_cnt_7));
    assign c_cnt_nx_8 = ((c_up_8 & (~c_dn_8)) ? (c_cnt_8 + 1) : ((c_dn_8 & (~c_up_8)) ? (c_cnt_8 - 1) : c_cnt_8));
    assign c_cnt_nx_9 = ((c_up_9 & (~c_dn_9)) ? (c_cnt_9 + 1) : ((c_dn_9 & (~c_up_9)) ? (c_cnt_9 - 1) : c_cnt_9));
    assign c_cnt_nx_10 = ((c_up_10 & (~c_dn_10)) ? (c_cnt_10 + 1) :
                         ((c_dn_10 & (~c_up_10)) ? (c_cnt_10 - 1) :
                         c_cnt_10));
    assign c_cnt_nx_11 = ((c_up_11 & (~c_dn_11)) ? (c_cnt_11 + 1) :
                         ((c_dn_11 & (~c_up_11)) ? (c_cnt_11 - 1) :
                         c_cnt_11));
    assign c_cnt_nx_12 = ((c_up_12 & (~c_dn_12)) ? (c_cnt_12 + 1) :
                         ((c_dn_12 & (~c_up_12)) ? (c_cnt_12 - 1) :
                         c_cnt_12));
    assign c_cnt_nx_13 = ((c_up_13 & (~c_dn_13)) ? (c_cnt_13 + 1) :
                         ((c_dn_13 & (~c_up_13)) ? (c_cnt_13 - 1) :
                         c_cnt_13));
    assign c_cnt_nx_14 = ((c_up_14 & (~c_dn_14)) ? (c_cnt_14 + 1) :
                         ((c_dn_14 & (~c_up_14)) ? (c_cnt_14 - 1) :
                         c_cnt_14));
    assign c_cnt_nx_15 = ((c_up_15 & (~c_dn_15)) ? (c_cnt_15 + 1) :
                         ((c_dn_15 & (~c_up_15)) ? (c_cnt_15 - 1) :
                         c_cnt_15));
    assign c_cnt_nx_16 = ((c_up_16 & (~c_dn_16)) ? (c_cnt_16 + 1) :
                         ((c_dn_16 & (~c_up_16)) ? (c_cnt_16 - 1) :
                         c_cnt_16));
    assign c_cnt_nx_17 = ((c_up_17 & (~c_dn_17)) ? (c_cnt_17 + 1) :
                         ((c_dn_17 & (~c_up_17)) ? (c_cnt_17 - 1) :
                         c_cnt_17));
    assign c_cnt_nx_18 = ((c_up_18 & (~c_dn_18)) ? (c_cnt_18 + 1) :
                         ((c_dn_18 & (~c_up_18)) ? (c_cnt_18 - 1) :
                         c_cnt_18));
    assign c_cnt_nx_19 = ((c_up_19 & (~c_dn_19)) ? (c_cnt_19 + 1) :
                         ((c_dn_19 & (~c_up_19)) ? (c_cnt_19 - 1) :
                         c_cnt_19));
    assign c_cnt_nx_20 = ((c_up_20 & (~c_dn_20)) ? (c_cnt_20 + 1) :
                         ((c_dn_20 & (~c_up_20)) ? (c_cnt_20 - 1) :
                         c_cnt_20));
    assign c_cnt_nx_21 = ((c_up_21 & (~c_dn_21)) ? (c_cnt_21 + 1) :
                         ((c_dn_21 & (~c_up_21)) ? (c_cnt_21 - 1) :
                         c_cnt_21));
    assign c_cnt_nx_22 = ((c_up_22 & (~c_dn_22)) ? (c_cnt_22 + 1) :
                         ((c_dn_22 & (~c_up_22)) ? (c_cnt_22 - 1) :
                         c_cnt_22));
    assign c_cnt_nx_23 = ((c_up_23 & (~c_dn_23)) ? (c_cnt_23 + 1) :
                         ((c_dn_23 & (~c_up_23)) ? (c_cnt_23 - 1) :
                         c_cnt_23));
    assign c_cnt_nx_24 = ((c_up_24 & (~c_dn_24)) ? (c_cnt_24 + 1) :
                         ((c_dn_24 & (~c_up_24)) ? (c_cnt_24 - 1) :
                         c_cnt_24));
    assign c_cnt_nx_25 = ((c_up_25 & (~c_dn_25)) ? (c_cnt_25 + 1) :
                         ((c_dn_25 & (~c_up_25)) ? (c_cnt_25 - 1) :
                         c_cnt_25));
    assign c_cnt_nx_26 = ((c_up_26 & (~c_dn_26)) ? (c_cnt_26 + 1) :
                         ((c_dn_26 & (~c_up_26)) ? (c_cnt_26 - 1) :
                         c_cnt_26));
    assign c_cnt_nx_27 = ((c_up_27 & (~c_dn_27)) ? (c_cnt_27 + 1) :
                         ((c_dn_27 & (~c_up_27)) ? (c_cnt_27 - 1) :
                         c_cnt_27));
    assign c_cnt_nx_28 = ((c_up_28 & (~c_dn_28)) ? (c_cnt_28 + 1) :
                         ((c_dn_28 & (~c_up_28)) ? (c_cnt_28 - 1) :
                         c_cnt_28));
    assign c_cnt_nx_29 = ((c_up_29 & (~c_dn_29)) ? (c_cnt_29 + 1) :
                         ((c_dn_29 & (~c_up_29)) ? (c_cnt_29 - 1) :
                         c_cnt_29));
    assign c_cnt_nx_30 = ((c_up_30 & (~c_dn_30)) ? (c_cnt_30 + 1) :
                         ((c_dn_30 & (~c_up_30)) ? (c_cnt_30 - 1) :
                         c_cnt_30));
    assign c_cnt_nx_31 = ((c_up_31 & (~c_dn_31)) ? (c_cnt_31 + 1) :
                         ((c_dn_31 & (~c_up_31)) ? (c_cnt_31 - 1) :
                         c_cnt_31));
    assign c_cnt_nx_32 = ((c_up_32 & (~c_dn_32)) ? (c_cnt_32 + 1) :
                         ((c_dn_32 & (~c_up_32)) ? (c_cnt_32 - 1) :
                         c_cnt_32));
    assign c_cnt_nx_33 = ((c_up_33 & (~c_dn_33)) ? (c_cnt_33 + 1) :
                         ((c_dn_33 & (~c_up_33)) ? (c_cnt_33 - 1) :
                         c_cnt_33));
    assign c_cnt_nx_34 = ((c_up_34 & (~c_dn_34)) ? (c_cnt_34 + 1) :
                         ((c_dn_34 & (~c_up_34)) ? (c_cnt_34 - 1) :
                         c_cnt_34));
    assign c_cnt_nx_35 = ((c_up_35 & (~c_dn_35)) ? (c_cnt_35 + 1) :
                         ((c_dn_35 & (~c_up_35)) ? (c_cnt_35 - 1) :
                         c_cnt_35));
    assign c_cnt_nx_36 = ((c_up_36 & (~c_dn_36)) ? (c_cnt_36 + 1) :
                         ((c_dn_36 & (~c_up_36)) ? (c_cnt_36 - 1) :
                         c_cnt_36));
    assign c_cnt_nx_37 = ((c_up_37 & (~c_dn_37)) ? (c_cnt_37 + 1) :
                         ((c_dn_37 & (~c_up_37)) ? (c_cnt_37 - 1) :
                         c_cnt_37));
    assign c_cnt_nx_38 = ((c_up_38 & (~c_dn_38)) ? (c_cnt_38 + 1) :
                         ((c_dn_38 & (~c_up_38)) ? (c_cnt_38 - 1) :
                         c_cnt_38));
    assign c_cnt_nx_39 = ((c_up_39 & (~c_dn_39)) ? (c_cnt_39 + 1) :
                         ((c_dn_39 & (~c_up_39)) ? (c_cnt_39 - 1) :
                         c_cnt_39));
    assign c_cnt_nx_40 = ((c_up_40 & (~c_dn_40)) ? (c_cnt_40 + 1) :
                         ((c_dn_40 & (~c_up_40)) ? (c_cnt_40 - 1) :
                         c_cnt_40));
    assign c_cnt_nx_41 = ((c_up_41 & (~c_dn_41)) ? (c_cnt_41 + 1) :
                         ((c_dn_41 & (~c_up_41)) ? (c_cnt_41 - 1) :
                         c_cnt_41));
    assign c_cnt_nx_42 = ((c_up_42 & (~c_dn_42)) ? (c_cnt_42 + 1) :
                         ((c_dn_42 & (~c_up_42)) ? (c_cnt_42 - 1) :
                         c_cnt_42));
    assign c_cnt_nx_43 = ((c_up_43 & (~c_dn_43)) ? (c_cnt_43 + 1) :
                         ((c_dn_43 & (~c_up_43)) ? (c_cnt_43 - 1) :
                         c_cnt_43));
    assign c_cnt_nx_44 = ((c_up_44 & (~c_dn_44)) ? (c_cnt_44 + 1) :
                         ((c_dn_44 & (~c_up_44)) ? (c_cnt_44 - 1) :
                         c_cnt_44));
    assign c_cnt_nx_45 = ((c_up_45 & (~c_dn_45)) ? (c_cnt_45 + 1) :
                         ((c_dn_45 & (~c_up_45)) ? (c_cnt_45 - 1) :
                         c_cnt_45));
    assign c_cnt_nx_46 = ((c_up_46 & (~c_dn_46)) ? (c_cnt_46 + 1) :
                         ((c_dn_46 & (~c_up_46)) ? (c_cnt_46 - 1) :
                         c_cnt_46));
    assign c_cnt_nx_47 = ((c_up_47 & (~c_dn_47)) ? (c_cnt_47 + 1) :
                         ((c_dn_47 & (~c_up_47)) ? (c_cnt_47 - 1) :
                         c_cnt_47));
    assign dbg_pend_write = pend_write;
    assign dbg_mismatch_o = dbg_mismatch;
    assign dbg_torn_o = dbg_torn;
    assign dbg_cfg_pend = cfg_pend;
    assign dbg_live_slots = live_slots;
    assign fi__p0 = fp_wp_0;
    assign fi__p1 = fp_wp_1;
    assign fi__p2 = fp_wp_2;
    assign bpush__p0 = wcomp_l_0;
    assign bpush__p1 = wcomp_l_1;
    assign bpush__p2 = wcomp_l_2;
    assign ic = ic_cid;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            s_valid_c_0 <= 0;
            s_valid_c_1 <= 0;
            s_valid_c_2 <= 0;
            s_valid_c_3 <= 0;
            s_valid_c_4 <= 0;
            s_valid_c_5 <= 0;
            s_valid_c_6 <= 0;
            s_valid_c_7 <= 0;
            s_valid_c_8 <= 0;
            s_valid_c_9 <= 0;
            s_valid_c_10 <= 0;
            s_valid_c_11 <= 0;
            s_valid_c_12 <= 0;
            s_valid_c_13 <= 0;
            s_valid_c_14 <= 0;
            s_valid_c_15 <= 0;
            s_valid_c_16 <= 0;
            s_valid_c_17 <= 0;
            s_valid_c_18 <= 0;
            s_valid_c_19 <= 0;
            s_valid_c_20 <= 0;
            s_valid_c_21 <= 0;
            s_valid_c_22 <= 0;
            s_valid_c_23 <= 0;
            s_valid_c_24 <= 0;
            s_valid_c_25 <= 0;
            s_valid_c_26 <= 0;
            s_valid_c_27 <= 0;
            s_valid_c_28 <= 0;
            s_valid_c_29 <= 0;
            s_valid_c_30 <= 0;
            s_valid_c_31 <= 0;
            s_valid_c_32 <= 0;
            s_valid_c_33 <= 0;
            s_valid_c_34 <= 0;
            s_valid_c_35 <= 0;
            s_valid_c_36 <= 0;
            s_valid_c_37 <= 0;
            s_valid_c_38 <= 0;
            s_valid_c_39 <= 0;
            s_valid_c_40 <= 0;
            s_valid_c_41 <= 0;
            s_valid_c_42 <= 0;
            s_valid_c_43 <= 0;
            s_valid_c_44 <= 0;
            s_valid_c_45 <= 0;
            s_valid_c_46 <= 0;
            s_valid_c_47 <= 0;
            s_valid_c_48 <= 0;
            s_valid_c_49 <= 0;
            s_valid_c_50 <= 0;
            s_valid_c_51 <= 0;
            s_valid_c_52 <= 0;
            s_valid_c_53 <= 0;
            s_valid_c_54 <= 0;
            s_valid_c_55 <= 0;
            s_valid_c_56 <= 0;
            s_valid_c_57 <= 0;
            s_valid_c_58 <= 0;
            s_valid_c_59 <= 0;
            s_valid_c_60 <= 0;
            s_valid_c_61 <= 0;
            s_valid_c_62 <= 0;
            s_valid_c_63 <= 0;
            s_valid_c_64 <= 0;
            s_valid_c_65 <= 0;
            s_valid_c_66 <= 0;
            s_valid_c_67 <= 0;
            s_valid_c_68 <= 0;
            s_valid_c_69 <= 0;
            s_valid_c_70 <= 0;
            s_valid_c_71 <= 0;
            s_valid_c_72 <= 0;
            s_valid_c_73 <= 0;
            s_valid_c_74 <= 0;
            s_valid_c_75 <= 0;
            s_valid_c_76 <= 0;
            s_valid_c_77 <= 0;
            s_valid_c_78 <= 0;
            s_valid_c_79 <= 0;
            s_valid_c_80 <= 0;
            s_valid_c_81 <= 0;
            s_valid_c_82 <= 0;
            s_valid_c_83 <= 0;
            s_valid_c_84 <= 0;
            s_valid_c_85 <= 0;
            s_valid_c_86 <= 0;
            s_valid_c_87 <= 0;
            s_valid_c_88 <= 0;
            s_valid_c_89 <= 0;
            s_valid_c_90 <= 0;
            s_valid_c_91 <= 0;
            s_valid_c_92 <= 0;
            s_valid_c_93 <= 0;
            s_valid_c_94 <= 0;
            s_valid_c_95 <= 0;
            s_valid_c_96 <= 0;
            s_valid_c_97 <= 0;
            s_valid_c_98 <= 0;
            s_valid_c_99 <= 0;
            s_valid_c_100 <= 0;
            s_valid_c_101 <= 0;
            s_valid_c_102 <= 0;
            s_valid_c_103 <= 0;
            s_valid_c_104 <= 0;
            s_valid_c_105 <= 0;
            s_valid_c_106 <= 0;
            s_valid_c_107 <= 0;
            s_valid_c_108 <= 0;
            s_valid_c_109 <= 0;
            s_valid_c_110 <= 0;
            s_valid_c_111 <= 0;
            s_valid_c_112 <= 0;
            s_valid_c_113 <= 0;
            s_valid_c_114 <= 0;
            s_valid_c_115 <= 0;
            s_valid_c_116 <= 0;
            s_valid_c_117 <= 0;
            s_valid_c_118 <= 0;
            s_valid_c_119 <= 0;
            s_valid_c_120 <= 0;
            s_valid_c_121 <= 0;
            s_valid_c_122 <= 0;
            s_valid_c_123 <= 0;
            s_valid_c_124 <= 0;
            s_valid_c_125 <= 0;
            s_valid_c_126 <= 0;
            s_valid_c_127 <= 0;
            s_valid_c_128 <= 0;
            s_valid_c_129 <= 0;
            s_valid_c_130 <= 0;
            s_valid_c_131 <= 0;
            s_valid_c_132 <= 0;
            s_valid_c_133 <= 0;
            s_valid_c_134 <= 0;
            s_valid_c_135 <= 0;
            s_valid_c_136 <= 0;
            s_valid_c_137 <= 0;
            s_valid_c_138 <= 0;
            s_valid_c_139 <= 0;
            s_valid_c_140 <= 0;
            s_valid_c_141 <= 0;
            s_valid_c_142 <= 0;
            s_valid_c_143 <= 0;
            s_valid_c_144 <= 0;
            s_valid_c_145 <= 0;
            s_valid_c_146 <= 0;
            s_valid_c_147 <= 0;
            s_valid_c_148 <= 0;
            s_valid_c_149 <= 0;
            s_valid_c_150 <= 0;
            s_valid_c_151 <= 0;
            s_valid_c_152 <= 0;
            s_valid_c_153 <= 0;
            s_valid_c_154 <= 0;
            s_valid_c_155 <= 0;
            s_valid_c_156 <= 0;
            s_valid_c_157 <= 0;
            s_valid_c_158 <= 0;
            s_valid_c_159 <= 0;
            s_valid_c_160 <= 0;
            s_valid_c_161 <= 0;
            s_valid_c_162 <= 0;
            s_valid_c_163 <= 0;
            s_valid_c_164 <= 0;
            s_valid_c_165 <= 0;
            s_valid_c_166 <= 0;
            s_valid_c_167 <= 0;
            s_valid_c_168 <= 0;
            s_valid_c_169 <= 0;
            s_valid_c_170 <= 0;
            s_valid_c_171 <= 0;
            s_valid_c_172 <= 0;
            s_valid_c_173 <= 0;
            s_valid_c_174 <= 0;
            s_valid_c_175 <= 0;
            s_valid_c_176 <= 0;
            s_valid_c_177 <= 0;
            s_valid_c_178 <= 0;
            s_valid_c_179 <= 0;
            s_valid_c_180 <= 0;
            s_valid_c_181 <= 0;
            s_valid_c_182 <= 0;
            s_valid_c_183 <= 0;
            s_valid_c_184 <= 0;
            s_valid_c_185 <= 0;
            s_valid_c_186 <= 0;
            s_valid_c_187 <= 0;
            s_valid_c_188 <= 0;
            s_valid_c_189 <= 0;
            s_valid_c_190 <= 0;
            s_valid_c_191 <= 0;
            p_valid_c_0 <= 0;
            p_valid_c_1 <= 0;
            p_valid_c_2 <= 0;
            p_valid_c_3 <= 0;
            p_valid_c_4 <= 0;
            p_valid_c_5 <= 0;
            p_valid_c_6 <= 0;
            p_valid_c_7 <= 0;
            p_valid_c_8 <= 0;
            p_valid_c_9 <= 0;
            p_valid_c_10 <= 0;
            p_valid_c_11 <= 0;
            p_valid_c_12 <= 0;
            p_valid_c_13 <= 0;
            p_valid_c_14 <= 0;
            p_valid_c_15 <= 0;
            p_valid_c_16 <= 0;
            p_valid_c_17 <= 0;
            p_valid_c_18 <= 0;
            p_valid_c_19 <= 0;
            p_valid_c_20 <= 0;
            p_valid_c_21 <= 0;
            p_valid_c_22 <= 0;
            p_valid_c_23 <= 0;
            p_valid_c_24 <= 0;
            p_valid_c_25 <= 0;
            p_valid_c_26 <= 0;
            p_valid_c_27 <= 0;
            p_valid_c_28 <= 0;
            p_valid_c_29 <= 0;
            p_valid_c_30 <= 0;
            p_valid_c_31 <= 0;
            p_valid_c_32 <= 0;
            p_valid_c_33 <= 0;
            p_valid_c_34 <= 0;
            p_valid_c_35 <= 0;
            p_valid_c_36 <= 0;
            p_valid_c_37 <= 0;
            p_valid_c_38 <= 0;
            p_valid_c_39 <= 0;
            p_valid_c_40 <= 0;
            p_valid_c_41 <= 0;
            p_valid_c_42 <= 0;
            p_valid_c_43 <= 0;
            p_valid_c_44 <= 0;
            p_valid_c_45 <= 0;
            p_valid_c_46 <= 0;
            p_valid_c_47 <= 0;
            p_valid_c_48 <= 0;
            p_valid_c_49 <= 0;
            p_valid_c_50 <= 0;
            p_valid_c_51 <= 0;
            p_valid_c_52 <= 0;
            p_valid_c_53 <= 0;
            p_valid_c_54 <= 0;
            p_valid_c_55 <= 0;
            p_valid_c_56 <= 0;
            p_valid_c_57 <= 0;
            p_valid_c_58 <= 0;
            p_valid_c_59 <= 0;
            p_valid_c_60 <= 0;
            p_valid_c_61 <= 0;
            p_valid_c_62 <= 0;
            p_valid_c_63 <= 0;
            p_valid_c_64 <= 0;
            p_valid_c_65 <= 0;
            p_valid_c_66 <= 0;
            p_valid_c_67 <= 0;
            p_valid_c_68 <= 0;
            p_valid_c_69 <= 0;
            p_valid_c_70 <= 0;
            p_valid_c_71 <= 0;
            p_valid_c_72 <= 0;
            p_valid_c_73 <= 0;
            p_valid_c_74 <= 0;
            p_valid_c_75 <= 0;
            p_valid_c_76 <= 0;
            p_valid_c_77 <= 0;
            p_valid_c_78 <= 0;
            p_valid_c_79 <= 0;
            p_valid_c_80 <= 0;
            p_valid_c_81 <= 0;
            p_valid_c_82 <= 0;
            p_valid_c_83 <= 0;
            p_valid_c_84 <= 0;
            p_valid_c_85 <= 0;
            p_valid_c_86 <= 0;
            p_valid_c_87 <= 0;
            p_valid_c_88 <= 0;
            p_valid_c_89 <= 0;
            p_valid_c_90 <= 0;
            p_valid_c_91 <= 0;
            p_valid_c_92 <= 0;
            p_valid_c_93 <= 0;
            p_valid_c_94 <= 0;
            p_valid_c_95 <= 0;
            acc_pv <= 0;
            acc_pidx <= 0;
            acc_pdata <= 0;
            qf_pdata <= 0;
            dp_v <= 0;
            rn_v_0 <= 0;
            rn_v_1 <= 0;
            rn_v_2 <= 0;
            a_v_0 <= 0;
            fp_v_0 <= 0;
            f_wp_0 <= 0;
            a_id_0 <= 0;
            a_tag_0 <= 0;
            a_v_1 <= 0;
            fp_v_1 <= 0;
            f_wp_1 <= 0;
            a_id_1 <= 0;
            a_tag_1 <= 0;
            a_v_2 <= 0;
            fp_v_2 <= 0;
            f_wp_2 <= 0;
            a_id_2 <= 0;
            a_tag_2 <= 0;
            adm_rr <= 0;
            hm_q_0 <= 0;
            hm_q_1 <= 0;
            hm_q_2 <= 0;
            dbg_mismatch <= 0;
            pw_dec_q <= 0;
            pend_write <= 0;
            dq_instq <= 0;
            dq_gateq <= 0;
            dq_gateq2 <= 0;
            dq_gate_block <= 0;
            dq_admit <= 0;
            f_ip_0 <= 0;
            ih_lr_0 <= 0;
            rn_dir_0 <= 0;
            rn_own_0 <= 0;
            f_in_0 <= 0;
            f_ip_1 <= 0;
            ih_lr_1 <= 0;
            rn_dir_1 <= 0;
            rn_own_1 <= 0;
            f_in_1 <= 0;
            f_ip_2 <= 0;
            ih_lr_2 <= 0;
            rn_dir_2 <= 0;
            rn_own_2 <= 0;
            f_in_2 <= 0;
            f_cp_0 <= 0;
            fc_last_0 <= 0;
            fc_dir_0 <= 0;
            b_wp_0 <= 0;
            b_rp_0 <= 0;
            b_n_0 <= 0;
            f_n_p_0 <= 0;
            f_room_0 <= 1;
            f_cp_1 <= 0;
            fc_last_1 <= 0;
            fc_dir_1 <= 0;
            b_wp_1 <= 0;
            b_rp_1 <= 0;
            b_n_1 <= 0;
            f_n_p_1 <= 0;
            f_room_1 <= 1;
            f_cp_2 <= 0;
            fc_last_2 <= 0;
            fc_dir_2 <= 0;
            b_wp_2 <= 0;
            b_rp_2 <= 0;
            b_n_2 <= 0;
            f_n_p_2 <= 0;
            f_room_2 <= 1;
            ci_wp <= 0;
            ci_rp <= 0;
            ci_cnt <= 0;
            st_pi_0 <= 0;
            st_have_0 <= 0;
            st_pi_1 <= 0;
            st_have_1 <= 0;
            dbg_torn <= 0;
            cr_v <= 0;
            cr_d <= 0;
            cr_t <= 0;
            a1_v <= 0;
            a1_pp <= 0;
            a1_mpp <= 63;
            ca_v <= 0;
            ca_pp <= 0;
            ca_cid <= 0;
            ca_dir <= 0;
            ca_decl <= 0;
            ca_base <= 0;
            ca_size <= 0;
            pop_q <= 0;
            pop_pp <= 0;
            ic_v <= 0;
            ic_cid <= 0;
            ic_dir <= 0;
            ic_decl <= 0;
            ic_dm1 <= 0;
            ic_base <= 0;
            ic_size <= 0;
            ic_pd <= 0;
            ic_opp <= 0;
            ic_raww <= 0;
            c_wp_0 <= 0;
            c_rp_0 <= 0;
            c_cnt_0 <= 0;
            c_ne_0 <= 0;
            c_fl_0 <= 0;
            c_wp_1 <= 0;
            c_rp_1 <= 0;
            c_cnt_1 <= 0;
            c_ne_1 <= 0;
            c_fl_1 <= 0;
            c_wp_2 <= 0;
            c_rp_2 <= 0;
            c_cnt_2 <= 0;
            c_ne_2 <= 0;
            c_fl_2 <= 0;
            c_wp_3 <= 0;
            c_rp_3 <= 0;
            c_cnt_3 <= 0;
            c_ne_3 <= 0;
            c_fl_3 <= 0;
            c_wp_4 <= 0;
            c_rp_4 <= 0;
            c_cnt_4 <= 0;
            c_ne_4 <= 0;
            c_fl_4 <= 0;
            c_wp_5 <= 0;
            c_rp_5 <= 0;
            c_cnt_5 <= 0;
            c_ne_5 <= 0;
            c_fl_5 <= 0;
            c_wp_6 <= 0;
            c_rp_6 <= 0;
            c_cnt_6 <= 0;
            c_ne_6 <= 0;
            c_fl_6 <= 0;
            c_wp_7 <= 0;
            c_rp_7 <= 0;
            c_cnt_7 <= 0;
            c_ne_7 <= 0;
            c_fl_7 <= 0;
            c_wp_8 <= 0;
            c_rp_8 <= 0;
            c_cnt_8 <= 0;
            c_ne_8 <= 0;
            c_fl_8 <= 0;
            c_wp_9 <= 0;
            c_rp_9 <= 0;
            c_cnt_9 <= 0;
            c_ne_9 <= 0;
            c_fl_9 <= 0;
            c_wp_10 <= 0;
            c_rp_10 <= 0;
            c_cnt_10 <= 0;
            c_ne_10 <= 0;
            c_fl_10 <= 0;
            c_wp_11 <= 0;
            c_rp_11 <= 0;
            c_cnt_11 <= 0;
            c_ne_11 <= 0;
            c_fl_11 <= 0;
            c_wp_12 <= 0;
            c_rp_12 <= 0;
            c_cnt_12 <= 0;
            c_ne_12 <= 0;
            c_fl_12 <= 0;
            c_wp_13 <= 0;
            c_rp_13 <= 0;
            c_cnt_13 <= 0;
            c_ne_13 <= 0;
            c_fl_13 <= 0;
            c_wp_14 <= 0;
            c_rp_14 <= 0;
            c_cnt_14 <= 0;
            c_ne_14 <= 0;
            c_fl_14 <= 0;
            c_wp_15 <= 0;
            c_rp_15 <= 0;
            c_cnt_15 <= 0;
            c_ne_15 <= 0;
            c_fl_15 <= 0;
            c_wp_16 <= 0;
            c_rp_16 <= 0;
            c_cnt_16 <= 0;
            c_ne_16 <= 0;
            c_fl_16 <= 0;
            c_wp_17 <= 0;
            c_rp_17 <= 0;
            c_cnt_17 <= 0;
            c_ne_17 <= 0;
            c_fl_17 <= 0;
            c_wp_18 <= 0;
            c_rp_18 <= 0;
            c_cnt_18 <= 0;
            c_ne_18 <= 0;
            c_fl_18 <= 0;
            c_wp_19 <= 0;
            c_rp_19 <= 0;
            c_cnt_19 <= 0;
            c_ne_19 <= 0;
            c_fl_19 <= 0;
            c_wp_20 <= 0;
            c_rp_20 <= 0;
            c_cnt_20 <= 0;
            c_ne_20 <= 0;
            c_fl_20 <= 0;
            c_wp_21 <= 0;
            c_rp_21 <= 0;
            c_cnt_21 <= 0;
            c_ne_21 <= 0;
            c_fl_21 <= 0;
            c_wp_22 <= 0;
            c_rp_22 <= 0;
            c_cnt_22 <= 0;
            c_ne_22 <= 0;
            c_fl_22 <= 0;
            c_wp_23 <= 0;
            c_rp_23 <= 0;
            c_cnt_23 <= 0;
            c_ne_23 <= 0;
            c_fl_23 <= 0;
            c_wp_24 <= 0;
            c_rp_24 <= 0;
            c_cnt_24 <= 0;
            c_ne_24 <= 0;
            c_fl_24 <= 0;
            c_wp_25 <= 0;
            c_rp_25 <= 0;
            c_cnt_25 <= 0;
            c_ne_25 <= 0;
            c_fl_25 <= 0;
            c_wp_26 <= 0;
            c_rp_26 <= 0;
            c_cnt_26 <= 0;
            c_ne_26 <= 0;
            c_fl_26 <= 0;
            c_wp_27 <= 0;
            c_rp_27 <= 0;
            c_cnt_27 <= 0;
            c_ne_27 <= 0;
            c_fl_27 <= 0;
            c_wp_28 <= 0;
            c_rp_28 <= 0;
            c_cnt_28 <= 0;
            c_ne_28 <= 0;
            c_fl_28 <= 0;
            c_wp_29 <= 0;
            c_rp_29 <= 0;
            c_cnt_29 <= 0;
            c_ne_29 <= 0;
            c_fl_29 <= 0;
            c_wp_30 <= 0;
            c_rp_30 <= 0;
            c_cnt_30 <= 0;
            c_ne_30 <= 0;
            c_fl_30 <= 0;
            c_wp_31 <= 0;
            c_rp_31 <= 0;
            c_cnt_31 <= 0;
            c_ne_31 <= 0;
            c_fl_31 <= 0;
            c_wp_32 <= 0;
            c_rp_32 <= 0;
            c_cnt_32 <= 0;
            c_ne_32 <= 0;
            c_fl_32 <= 0;
            c_wp_33 <= 0;
            c_rp_33 <= 0;
            c_cnt_33 <= 0;
            c_ne_33 <= 0;
            c_fl_33 <= 0;
            c_wp_34 <= 0;
            c_rp_34 <= 0;
            c_cnt_34 <= 0;
            c_ne_34 <= 0;
            c_fl_34 <= 0;
            c_wp_35 <= 0;
            c_rp_35 <= 0;
            c_cnt_35 <= 0;
            c_ne_35 <= 0;
            c_fl_35 <= 0;
            c_wp_36 <= 0;
            c_rp_36 <= 0;
            c_cnt_36 <= 0;
            c_ne_36 <= 0;
            c_fl_36 <= 0;
            c_wp_37 <= 0;
            c_rp_37 <= 0;
            c_cnt_37 <= 0;
            c_ne_37 <= 0;
            c_fl_37 <= 0;
            c_wp_38 <= 0;
            c_rp_38 <= 0;
            c_cnt_38 <= 0;
            c_ne_38 <= 0;
            c_fl_38 <= 0;
            c_wp_39 <= 0;
            c_rp_39 <= 0;
            c_cnt_39 <= 0;
            c_ne_39 <= 0;
            c_fl_39 <= 0;
            c_wp_40 <= 0;
            c_rp_40 <= 0;
            c_cnt_40 <= 0;
            c_ne_40 <= 0;
            c_fl_40 <= 0;
            c_wp_41 <= 0;
            c_rp_41 <= 0;
            c_cnt_41 <= 0;
            c_ne_41 <= 0;
            c_fl_41 <= 0;
            c_wp_42 <= 0;
            c_rp_42 <= 0;
            c_cnt_42 <= 0;
            c_ne_42 <= 0;
            c_fl_42 <= 0;
            c_wp_43 <= 0;
            c_rp_43 <= 0;
            c_cnt_43 <= 0;
            c_ne_43 <= 0;
            c_fl_43 <= 0;
            c_wp_44 <= 0;
            c_rp_44 <= 0;
            c_cnt_44 <= 0;
            c_ne_44 <= 0;
            c_fl_44 <= 0;
            c_wp_45 <= 0;
            c_rp_45 <= 0;
            c_cnt_45 <= 0;
            c_ne_45 <= 0;
            c_fl_45 <= 0;
            c_wp_46 <= 0;
            c_rp_46 <= 0;
            c_cnt_46 <= 0;
            c_ne_46 <= 0;
            c_fl_46 <= 0;
            c_wp_47 <= 0;
            c_rp_47 <= 0;
            c_cnt_47 <= 0;
            c_ne_47 <= 0;
            c_fl_47 <= 0;
            cfg_pend <= 0;
            live_slots <= 0;
        end else begin
            if (sv_we) begin
                if ((sv_idx == 0)) begin
                    s_valid_c_0 <= sv_data;
                end
                if ((sv_idx == 1)) begin
                    s_valid_c_1 <= sv_data;
                end
                if ((sv_idx == 2)) begin
                    s_valid_c_2 <= sv_data;
                end
                if ((sv_idx == 3)) begin
                    s_valid_c_3 <= sv_data;
                end
                if ((sv_idx == 4)) begin
                    s_valid_c_4 <= sv_data;
                end
                if ((sv_idx == 5)) begin
                    s_valid_c_5 <= sv_data;
                end
                if ((sv_idx == 6)) begin
                    s_valid_c_6 <= sv_data;
                end
                if ((sv_idx == 7)) begin
                    s_valid_c_7 <= sv_data;
                end
                if ((sv_idx == 8)) begin
                    s_valid_c_8 <= sv_data;
                end
                if ((sv_idx == 9)) begin
                    s_valid_c_9 <= sv_data;
                end
                if ((sv_idx == 10)) begin
                    s_valid_c_10 <= sv_data;
                end
                if ((sv_idx == 11)) begin
                    s_valid_c_11 <= sv_data;
                end
                if ((sv_idx == 12)) begin
                    s_valid_c_12 <= sv_data;
                end
                if ((sv_idx == 13)) begin
                    s_valid_c_13 <= sv_data;
                end
                if ((sv_idx == 14)) begin
                    s_valid_c_14 <= sv_data;
                end
                if ((sv_idx == 15)) begin
                    s_valid_c_15 <= sv_data;
                end
                if ((sv_idx == 16)) begin
                    s_valid_c_16 <= sv_data;
                end
                if ((sv_idx == 17)) begin
                    s_valid_c_17 <= sv_data;
                end
                if ((sv_idx == 18)) begin
                    s_valid_c_18 <= sv_data;
                end
                if ((sv_idx == 19)) begin
                    s_valid_c_19 <= sv_data;
                end
                if ((sv_idx == 20)) begin
                    s_valid_c_20 <= sv_data;
                end
                if ((sv_idx == 21)) begin
                    s_valid_c_21 <= sv_data;
                end
                if ((sv_idx == 22)) begin
                    s_valid_c_22 <= sv_data;
                end
                if ((sv_idx == 23)) begin
                    s_valid_c_23 <= sv_data;
                end
                if ((sv_idx == 24)) begin
                    s_valid_c_24 <= sv_data;
                end
                if ((sv_idx == 25)) begin
                    s_valid_c_25 <= sv_data;
                end
                if ((sv_idx == 26)) begin
                    s_valid_c_26 <= sv_data;
                end
                if ((sv_idx == 27)) begin
                    s_valid_c_27 <= sv_data;
                end
                if ((sv_idx == 28)) begin
                    s_valid_c_28 <= sv_data;
                end
                if ((sv_idx == 29)) begin
                    s_valid_c_29 <= sv_data;
                end
                if ((sv_idx == 30)) begin
                    s_valid_c_30 <= sv_data;
                end
                if ((sv_idx == 31)) begin
                    s_valid_c_31 <= sv_data;
                end
                if ((sv_idx == 32)) begin
                    s_valid_c_32 <= sv_data;
                end
                if ((sv_idx == 33)) begin
                    s_valid_c_33 <= sv_data;
                end
                if ((sv_idx == 34)) begin
                    s_valid_c_34 <= sv_data;
                end
                if ((sv_idx == 35)) begin
                    s_valid_c_35 <= sv_data;
                end
                if ((sv_idx == 36)) begin
                    s_valid_c_36 <= sv_data;
                end
                if ((sv_idx == 37)) begin
                    s_valid_c_37 <= sv_data;
                end
                if ((sv_idx == 38)) begin
                    s_valid_c_38 <= sv_data;
                end
                if ((sv_idx == 39)) begin
                    s_valid_c_39 <= sv_data;
                end
                if ((sv_idx == 40)) begin
                    s_valid_c_40 <= sv_data;
                end
                if ((sv_idx == 41)) begin
                    s_valid_c_41 <= sv_data;
                end
                if ((sv_idx == 42)) begin
                    s_valid_c_42 <= sv_data;
                end
                if ((sv_idx == 43)) begin
                    s_valid_c_43 <= sv_data;
                end
                if ((sv_idx == 44)) begin
                    s_valid_c_44 <= sv_data;
                end
                if ((sv_idx == 45)) begin
                    s_valid_c_45 <= sv_data;
                end
                if ((sv_idx == 46)) begin
                    s_valid_c_46 <= sv_data;
                end
                if ((sv_idx == 47)) begin
                    s_valid_c_47 <= sv_data;
                end
                if ((sv_idx == 48)) begin
                    s_valid_c_48 <= sv_data;
                end
                if ((sv_idx == 49)) begin
                    s_valid_c_49 <= sv_data;
                end
                if ((sv_idx == 50)) begin
                    s_valid_c_50 <= sv_data;
                end
                if ((sv_idx == 51)) begin
                    s_valid_c_51 <= sv_data;
                end
                if ((sv_idx == 52)) begin
                    s_valid_c_52 <= sv_data;
                end
                if ((sv_idx == 53)) begin
                    s_valid_c_53 <= sv_data;
                end
                if ((sv_idx == 54)) begin
                    s_valid_c_54 <= sv_data;
                end
                if ((sv_idx == 55)) begin
                    s_valid_c_55 <= sv_data;
                end
                if ((sv_idx == 56)) begin
                    s_valid_c_56 <= sv_data;
                end
                if ((sv_idx == 57)) begin
                    s_valid_c_57 <= sv_data;
                end
                if ((sv_idx == 58)) begin
                    s_valid_c_58 <= sv_data;
                end
                if ((sv_idx == 59)) begin
                    s_valid_c_59 <= sv_data;
                end
                if ((sv_idx == 60)) begin
                    s_valid_c_60 <= sv_data;
                end
                if ((sv_idx == 61)) begin
                    s_valid_c_61 <= sv_data;
                end
                if ((sv_idx == 62)) begin
                    s_valid_c_62 <= sv_data;
                end
                if ((sv_idx == 63)) begin
                    s_valid_c_63 <= sv_data;
                end
                if ((sv_idx == 64)) begin
                    s_valid_c_64 <= sv_data;
                end
                if ((sv_idx == 65)) begin
                    s_valid_c_65 <= sv_data;
                end
                if ((sv_idx == 66)) begin
                    s_valid_c_66 <= sv_data;
                end
                if ((sv_idx == 67)) begin
                    s_valid_c_67 <= sv_data;
                end
                if ((sv_idx == 68)) begin
                    s_valid_c_68 <= sv_data;
                end
                if ((sv_idx == 69)) begin
                    s_valid_c_69 <= sv_data;
                end
                if ((sv_idx == 70)) begin
                    s_valid_c_70 <= sv_data;
                end
                if ((sv_idx == 71)) begin
                    s_valid_c_71 <= sv_data;
                end
                if ((sv_idx == 72)) begin
                    s_valid_c_72 <= sv_data;
                end
                if ((sv_idx == 73)) begin
                    s_valid_c_73 <= sv_data;
                end
                if ((sv_idx == 74)) begin
                    s_valid_c_74 <= sv_data;
                end
                if ((sv_idx == 75)) begin
                    s_valid_c_75 <= sv_data;
                end
                if ((sv_idx == 76)) begin
                    s_valid_c_76 <= sv_data;
                end
                if ((sv_idx == 77)) begin
                    s_valid_c_77 <= sv_data;
                end
                if ((sv_idx == 78)) begin
                    s_valid_c_78 <= sv_data;
                end
                if ((sv_idx == 79)) begin
                    s_valid_c_79 <= sv_data;
                end
                if ((sv_idx == 80)) begin
                    s_valid_c_80 <= sv_data;
                end
                if ((sv_idx == 81)) begin
                    s_valid_c_81 <= sv_data;
                end
                if ((sv_idx == 82)) begin
                    s_valid_c_82 <= sv_data;
                end
                if ((sv_idx == 83)) begin
                    s_valid_c_83 <= sv_data;
                end
                if ((sv_idx == 84)) begin
                    s_valid_c_84 <= sv_data;
                end
                if ((sv_idx == 85)) begin
                    s_valid_c_85 <= sv_data;
                end
                if ((sv_idx == 86)) begin
                    s_valid_c_86 <= sv_data;
                end
                if ((sv_idx == 87)) begin
                    s_valid_c_87 <= sv_data;
                end
                if ((sv_idx == 88)) begin
                    s_valid_c_88 <= sv_data;
                end
                if ((sv_idx == 89)) begin
                    s_valid_c_89 <= sv_data;
                end
                if ((sv_idx == 90)) begin
                    s_valid_c_90 <= sv_data;
                end
                if ((sv_idx == 91)) begin
                    s_valid_c_91 <= sv_data;
                end
                if ((sv_idx == 92)) begin
                    s_valid_c_92 <= sv_data;
                end
                if ((sv_idx == 93)) begin
                    s_valid_c_93 <= sv_data;
                end
                if ((sv_idx == 94)) begin
                    s_valid_c_94 <= sv_data;
                end
                if ((sv_idx == 95)) begin
                    s_valid_c_95 <= sv_data;
                end
                if ((sv_idx == 96)) begin
                    s_valid_c_96 <= sv_data;
                end
                if ((sv_idx == 97)) begin
                    s_valid_c_97 <= sv_data;
                end
                if ((sv_idx == 98)) begin
                    s_valid_c_98 <= sv_data;
                end
                if ((sv_idx == 99)) begin
                    s_valid_c_99 <= sv_data;
                end
                if ((sv_idx == 100)) begin
                    s_valid_c_100 <= sv_data;
                end
                if ((sv_idx == 101)) begin
                    s_valid_c_101 <= sv_data;
                end
                if ((sv_idx == 102)) begin
                    s_valid_c_102 <= sv_data;
                end
                if ((sv_idx == 103)) begin
                    s_valid_c_103 <= sv_data;
                end
                if ((sv_idx == 104)) begin
                    s_valid_c_104 <= sv_data;
                end
                if ((sv_idx == 105)) begin
                    s_valid_c_105 <= sv_data;
                end
                if ((sv_idx == 106)) begin
                    s_valid_c_106 <= sv_data;
                end
                if ((sv_idx == 107)) begin
                    s_valid_c_107 <= sv_data;
                end
                if ((sv_idx == 108)) begin
                    s_valid_c_108 <= sv_data;
                end
                if ((sv_idx == 109)) begin
                    s_valid_c_109 <= sv_data;
                end
                if ((sv_idx == 110)) begin
                    s_valid_c_110 <= sv_data;
                end
                if ((sv_idx == 111)) begin
                    s_valid_c_111 <= sv_data;
                end
                if ((sv_idx == 112)) begin
                    s_valid_c_112 <= sv_data;
                end
                if ((sv_idx == 113)) begin
                    s_valid_c_113 <= sv_data;
                end
                if ((sv_idx == 114)) begin
                    s_valid_c_114 <= sv_data;
                end
                if ((sv_idx == 115)) begin
                    s_valid_c_115 <= sv_data;
                end
                if ((sv_idx == 116)) begin
                    s_valid_c_116 <= sv_data;
                end
                if ((sv_idx == 117)) begin
                    s_valid_c_117 <= sv_data;
                end
                if ((sv_idx == 118)) begin
                    s_valid_c_118 <= sv_data;
                end
                if ((sv_idx == 119)) begin
                    s_valid_c_119 <= sv_data;
                end
                if ((sv_idx == 120)) begin
                    s_valid_c_120 <= sv_data;
                end
                if ((sv_idx == 121)) begin
                    s_valid_c_121 <= sv_data;
                end
                if ((sv_idx == 122)) begin
                    s_valid_c_122 <= sv_data;
                end
                if ((sv_idx == 123)) begin
                    s_valid_c_123 <= sv_data;
                end
                if ((sv_idx == 124)) begin
                    s_valid_c_124 <= sv_data;
                end
                if ((sv_idx == 125)) begin
                    s_valid_c_125 <= sv_data;
                end
                if ((sv_idx == 126)) begin
                    s_valid_c_126 <= sv_data;
                end
                if ((sv_idx == 127)) begin
                    s_valid_c_127 <= sv_data;
                end
                if ((sv_idx == 128)) begin
                    s_valid_c_128 <= sv_data;
                end
                if ((sv_idx == 129)) begin
                    s_valid_c_129 <= sv_data;
                end
                if ((sv_idx == 130)) begin
                    s_valid_c_130 <= sv_data;
                end
                if ((sv_idx == 131)) begin
                    s_valid_c_131 <= sv_data;
                end
                if ((sv_idx == 132)) begin
                    s_valid_c_132 <= sv_data;
                end
                if ((sv_idx == 133)) begin
                    s_valid_c_133 <= sv_data;
                end
                if ((sv_idx == 134)) begin
                    s_valid_c_134 <= sv_data;
                end
                if ((sv_idx == 135)) begin
                    s_valid_c_135 <= sv_data;
                end
                if ((sv_idx == 136)) begin
                    s_valid_c_136 <= sv_data;
                end
                if ((sv_idx == 137)) begin
                    s_valid_c_137 <= sv_data;
                end
                if ((sv_idx == 138)) begin
                    s_valid_c_138 <= sv_data;
                end
                if ((sv_idx == 139)) begin
                    s_valid_c_139 <= sv_data;
                end
                if ((sv_idx == 140)) begin
                    s_valid_c_140 <= sv_data;
                end
                if ((sv_idx == 141)) begin
                    s_valid_c_141 <= sv_data;
                end
                if ((sv_idx == 142)) begin
                    s_valid_c_142 <= sv_data;
                end
                if ((sv_idx == 143)) begin
                    s_valid_c_143 <= sv_data;
                end
                if ((sv_idx == 144)) begin
                    s_valid_c_144 <= sv_data;
                end
                if ((sv_idx == 145)) begin
                    s_valid_c_145 <= sv_data;
                end
                if ((sv_idx == 146)) begin
                    s_valid_c_146 <= sv_data;
                end
                if ((sv_idx == 147)) begin
                    s_valid_c_147 <= sv_data;
                end
                if ((sv_idx == 148)) begin
                    s_valid_c_148 <= sv_data;
                end
                if ((sv_idx == 149)) begin
                    s_valid_c_149 <= sv_data;
                end
                if ((sv_idx == 150)) begin
                    s_valid_c_150 <= sv_data;
                end
                if ((sv_idx == 151)) begin
                    s_valid_c_151 <= sv_data;
                end
                if ((sv_idx == 152)) begin
                    s_valid_c_152 <= sv_data;
                end
                if ((sv_idx == 153)) begin
                    s_valid_c_153 <= sv_data;
                end
                if ((sv_idx == 154)) begin
                    s_valid_c_154 <= sv_data;
                end
                if ((sv_idx == 155)) begin
                    s_valid_c_155 <= sv_data;
                end
                if ((sv_idx == 156)) begin
                    s_valid_c_156 <= sv_data;
                end
                if ((sv_idx == 157)) begin
                    s_valid_c_157 <= sv_data;
                end
                if ((sv_idx == 158)) begin
                    s_valid_c_158 <= sv_data;
                end
                if ((sv_idx == 159)) begin
                    s_valid_c_159 <= sv_data;
                end
                if ((sv_idx == 160)) begin
                    s_valid_c_160 <= sv_data;
                end
                if ((sv_idx == 161)) begin
                    s_valid_c_161 <= sv_data;
                end
                if ((sv_idx == 162)) begin
                    s_valid_c_162 <= sv_data;
                end
                if ((sv_idx == 163)) begin
                    s_valid_c_163 <= sv_data;
                end
                if ((sv_idx == 164)) begin
                    s_valid_c_164 <= sv_data;
                end
                if ((sv_idx == 165)) begin
                    s_valid_c_165 <= sv_data;
                end
                if ((sv_idx == 166)) begin
                    s_valid_c_166 <= sv_data;
                end
                if ((sv_idx == 167)) begin
                    s_valid_c_167 <= sv_data;
                end
                if ((sv_idx == 168)) begin
                    s_valid_c_168 <= sv_data;
                end
                if ((sv_idx == 169)) begin
                    s_valid_c_169 <= sv_data;
                end
                if ((sv_idx == 170)) begin
                    s_valid_c_170 <= sv_data;
                end
                if ((sv_idx == 171)) begin
                    s_valid_c_171 <= sv_data;
                end
                if ((sv_idx == 172)) begin
                    s_valid_c_172 <= sv_data;
                end
                if ((sv_idx == 173)) begin
                    s_valid_c_173 <= sv_data;
                end
                if ((sv_idx == 174)) begin
                    s_valid_c_174 <= sv_data;
                end
                if ((sv_idx == 175)) begin
                    s_valid_c_175 <= sv_data;
                end
                if ((sv_idx == 176)) begin
                    s_valid_c_176 <= sv_data;
                end
                if ((sv_idx == 177)) begin
                    s_valid_c_177 <= sv_data;
                end
                if ((sv_idx == 178)) begin
                    s_valid_c_178 <= sv_data;
                end
                if ((sv_idx == 179)) begin
                    s_valid_c_179 <= sv_data;
                end
                if ((sv_idx == 180)) begin
                    s_valid_c_180 <= sv_data;
                end
                if ((sv_idx == 181)) begin
                    s_valid_c_181 <= sv_data;
                end
                if ((sv_idx == 182)) begin
                    s_valid_c_182 <= sv_data;
                end
                if ((sv_idx == 183)) begin
                    s_valid_c_183 <= sv_data;
                end
                if ((sv_idx == 184)) begin
                    s_valid_c_184 <= sv_data;
                end
                if ((sv_idx == 185)) begin
                    s_valid_c_185 <= sv_data;
                end
                if ((sv_idx == 186)) begin
                    s_valid_c_186 <= sv_data;
                end
                if ((sv_idx == 187)) begin
                    s_valid_c_187 <= sv_data;
                end
                if ((sv_idx == 188)) begin
                    s_valid_c_188 <= sv_data;
                end
                if ((sv_idx == 189)) begin
                    s_valid_c_189 <= sv_data;
                end
                if ((sv_idx == 190)) begin
                    s_valid_c_190 <= sv_data;
                end
                if ((sv_idx == 191)) begin
                    s_valid_c_191 <= sv_data;
                end
            end
            if (rw_we) begin
                s_raww[rw_idx] <= rw_data;
            end
            if (dv_we) begin
                s_depv[dv_idx] <= dv_data;
            end
            if (rv_we) begin
                if ((rv_idx == 0)) begin
                    p_valid_c_0 <= rv_data;
                end
                if ((rv_idx == 1)) begin
                    p_valid_c_1 <= rv_data;
                end
                if ((rv_idx == 2)) begin
                    p_valid_c_2 <= rv_data;
                end
                if ((rv_idx == 3)) begin
                    p_valid_c_3 <= rv_data;
                end
                if ((rv_idx == 4)) begin
                    p_valid_c_4 <= rv_data;
                end
                if ((rv_idx == 5)) begin
                    p_valid_c_5 <= rv_data;
                end
                if ((rv_idx == 6)) begin
                    p_valid_c_6 <= rv_data;
                end
                if ((rv_idx == 7)) begin
                    p_valid_c_7 <= rv_data;
                end
                if ((rv_idx == 8)) begin
                    p_valid_c_8 <= rv_data;
                end
                if ((rv_idx == 9)) begin
                    p_valid_c_9 <= rv_data;
                end
                if ((rv_idx == 10)) begin
                    p_valid_c_10 <= rv_data;
                end
                if ((rv_idx == 11)) begin
                    p_valid_c_11 <= rv_data;
                end
                if ((rv_idx == 12)) begin
                    p_valid_c_12 <= rv_data;
                end
                if ((rv_idx == 13)) begin
                    p_valid_c_13 <= rv_data;
                end
                if ((rv_idx == 14)) begin
                    p_valid_c_14 <= rv_data;
                end
                if ((rv_idx == 15)) begin
                    p_valid_c_15 <= rv_data;
                end
                if ((rv_idx == 16)) begin
                    p_valid_c_16 <= rv_data;
                end
                if ((rv_idx == 17)) begin
                    p_valid_c_17 <= rv_data;
                end
                if ((rv_idx == 18)) begin
                    p_valid_c_18 <= rv_data;
                end
                if ((rv_idx == 19)) begin
                    p_valid_c_19 <= rv_data;
                end
                if ((rv_idx == 20)) begin
                    p_valid_c_20 <= rv_data;
                end
                if ((rv_idx == 21)) begin
                    p_valid_c_21 <= rv_data;
                end
                if ((rv_idx == 22)) begin
                    p_valid_c_22 <= rv_data;
                end
                if ((rv_idx == 23)) begin
                    p_valid_c_23 <= rv_data;
                end
                if ((rv_idx == 24)) begin
                    p_valid_c_24 <= rv_data;
                end
                if ((rv_idx == 25)) begin
                    p_valid_c_25 <= rv_data;
                end
                if ((rv_idx == 26)) begin
                    p_valid_c_26 <= rv_data;
                end
                if ((rv_idx == 27)) begin
                    p_valid_c_27 <= rv_data;
                end
                if ((rv_idx == 28)) begin
                    p_valid_c_28 <= rv_data;
                end
                if ((rv_idx == 29)) begin
                    p_valid_c_29 <= rv_data;
                end
                if ((rv_idx == 30)) begin
                    p_valid_c_30 <= rv_data;
                end
                if ((rv_idx == 31)) begin
                    p_valid_c_31 <= rv_data;
                end
                if ((rv_idx == 32)) begin
                    p_valid_c_32 <= rv_data;
                end
                if ((rv_idx == 33)) begin
                    p_valid_c_33 <= rv_data;
                end
                if ((rv_idx == 34)) begin
                    p_valid_c_34 <= rv_data;
                end
                if ((rv_idx == 35)) begin
                    p_valid_c_35 <= rv_data;
                end
                if ((rv_idx == 36)) begin
                    p_valid_c_36 <= rv_data;
                end
                if ((rv_idx == 37)) begin
                    p_valid_c_37 <= rv_data;
                end
                if ((rv_idx == 38)) begin
                    p_valid_c_38 <= rv_data;
                end
                if ((rv_idx == 39)) begin
                    p_valid_c_39 <= rv_data;
                end
                if ((rv_idx == 40)) begin
                    p_valid_c_40 <= rv_data;
                end
                if ((rv_idx == 41)) begin
                    p_valid_c_41 <= rv_data;
                end
                if ((rv_idx == 42)) begin
                    p_valid_c_42 <= rv_data;
                end
                if ((rv_idx == 43)) begin
                    p_valid_c_43 <= rv_data;
                end
                if ((rv_idx == 44)) begin
                    p_valid_c_44 <= rv_data;
                end
                if ((rv_idx == 45)) begin
                    p_valid_c_45 <= rv_data;
                end
                if ((rv_idx == 46)) begin
                    p_valid_c_46 <= rv_data;
                end
                if ((rv_idx == 47)) begin
                    p_valid_c_47 <= rv_data;
                end
                if ((rv_idx == 48)) begin
                    p_valid_c_48 <= rv_data;
                end
                if ((rv_idx == 49)) begin
                    p_valid_c_49 <= rv_data;
                end
                if ((rv_idx == 50)) begin
                    p_valid_c_50 <= rv_data;
                end
                if ((rv_idx == 51)) begin
                    p_valid_c_51 <= rv_data;
                end
                if ((rv_idx == 52)) begin
                    p_valid_c_52 <= rv_data;
                end
                if ((rv_idx == 53)) begin
                    p_valid_c_53 <= rv_data;
                end
                if ((rv_idx == 54)) begin
                    p_valid_c_54 <= rv_data;
                end
                if ((rv_idx == 55)) begin
                    p_valid_c_55 <= rv_data;
                end
                if ((rv_idx == 56)) begin
                    p_valid_c_56 <= rv_data;
                end
                if ((rv_idx == 57)) begin
                    p_valid_c_57 <= rv_data;
                end
                if ((rv_idx == 58)) begin
                    p_valid_c_58 <= rv_data;
                end
                if ((rv_idx == 59)) begin
                    p_valid_c_59 <= rv_data;
                end
                if ((rv_idx == 60)) begin
                    p_valid_c_60 <= rv_data;
                end
                if ((rv_idx == 61)) begin
                    p_valid_c_61 <= rv_data;
                end
                if ((rv_idx == 62)) begin
                    p_valid_c_62 <= rv_data;
                end
                if ((rv_idx == 63)) begin
                    p_valid_c_63 <= rv_data;
                end
                if ((rv_idx == 64)) begin
                    p_valid_c_64 <= rv_data;
                end
                if ((rv_idx == 65)) begin
                    p_valid_c_65 <= rv_data;
                end
                if ((rv_idx == 66)) begin
                    p_valid_c_66 <= rv_data;
                end
                if ((rv_idx == 67)) begin
                    p_valid_c_67 <= rv_data;
                end
                if ((rv_idx == 68)) begin
                    p_valid_c_68 <= rv_data;
                end
                if ((rv_idx == 69)) begin
                    p_valid_c_69 <= rv_data;
                end
                if ((rv_idx == 70)) begin
                    p_valid_c_70 <= rv_data;
                end
                if ((rv_idx == 71)) begin
                    p_valid_c_71 <= rv_data;
                end
                if ((rv_idx == 72)) begin
                    p_valid_c_72 <= rv_data;
                end
                if ((rv_idx == 73)) begin
                    p_valid_c_73 <= rv_data;
                end
                if ((rv_idx == 74)) begin
                    p_valid_c_74 <= rv_data;
                end
                if ((rv_idx == 75)) begin
                    p_valid_c_75 <= rv_data;
                end
                if ((rv_idx == 76)) begin
                    p_valid_c_76 <= rv_data;
                end
                if ((rv_idx == 77)) begin
                    p_valid_c_77 <= rv_data;
                end
                if ((rv_idx == 78)) begin
                    p_valid_c_78 <= rv_data;
                end
                if ((rv_idx == 79)) begin
                    p_valid_c_79 <= rv_data;
                end
                if ((rv_idx == 80)) begin
                    p_valid_c_80 <= rv_data;
                end
                if ((rv_idx == 81)) begin
                    p_valid_c_81 <= rv_data;
                end
                if ((rv_idx == 82)) begin
                    p_valid_c_82 <= rv_data;
                end
                if ((rv_idx == 83)) begin
                    p_valid_c_83 <= rv_data;
                end
                if ((rv_idx == 84)) begin
                    p_valid_c_84 <= rv_data;
                end
                if ((rv_idx == 85)) begin
                    p_valid_c_85 <= rv_data;
                end
                if ((rv_idx == 86)) begin
                    p_valid_c_86 <= rv_data;
                end
                if ((rv_idx == 87)) begin
                    p_valid_c_87 <= rv_data;
                end
                if ((rv_idx == 88)) begin
                    p_valid_c_88 <= rv_data;
                end
                if ((rv_idx == 89)) begin
                    p_valid_c_89 <= rv_data;
                end
                if ((rv_idx == 90)) begin
                    p_valid_c_90 <= rv_data;
                end
                if ((rv_idx == 91)) begin
                    p_valid_c_91 <= rv_data;
                end
                if ((rv_idx == 92)) begin
                    p_valid_c_92 <= rv_data;
                end
                if ((rv_idx == 93)) begin
                    p_valid_c_93 <= rv_data;
                end
                if ((rv_idx == 94)) begin
                    p_valid_c_94 <= rv_data;
                end
                if ((rv_idx == 95)) begin
                    p_valid_c_95 <= rv_data;
                end
            end
            acc_pv <= acc_we;
            acc_pidx <= acc_idx;
            acc_pdata <= acc_data;
            qf_pdata <= qf_data;
            if (acc_pv) begin
                s_acc[acc_pidx] <= acc_pdata;
                s_qfull[acc_pidx] <= qf_pdata;
            end
            dp_v <= dsp_we;
            if (dp_v) begin
                s_disp[dp_idx] <= dp_data;
                s_dlast[dp_idx] <= dp_last;
            end
            if ((ret_fire & (ret_sel == 0))) begin
                rn_v_0 <= 0;
            end
            if ((ret_fire & (ret_sel == 1))) begin
                rn_v_1 <= 0;
            end
            if ((ret_fire & (ret_sel == 2))) begin
                rn_v_2 <= 0;
            end
            a_v_0 <= 0;
            fp_v_0 <= go_l_0;
            if (fp_v_0) begin
                f_cid_0[fi__p0] <= fp_cid_0;
                f_q_0[fi__p0] <= fp_q_0;
                f_tag_0[fi__p0] <= fp_tag_0;
                f_dir_0[fi__p0] <= fp_dir_0;
                f_addr_0[fi__p0] <= fp_addr_0;
                f_bytes_0[fi__p0] <= fp_bytes_0;
                f_rm1_0[fi__p0] <= fp_rm1_0;
                f_one_0[fi__p0] <= fp_one_0;
                f_stride_0[fi__p0] <= fp_stride_0;
                f_last_0[fi__p0] <= fp_last_0;
            end
            if (go_l_0) begin
                f_wp_0 <= (f_wp_0 + 1);
                a_v_0 <= 1;
                a_id_0 <= {1'd0, h_q_l_0};
                a_tag_0 <= h_tag_l_0;
            end
            a_v_1 <= 0;
            fp_v_1 <= go_l_1;
            if (fp_v_1) begin
                f_cid_1[fi__p1] <= fp_cid_1;
                f_q_1[fi__p1] <= fp_q_1;
                f_tag_1[fi__p1] <= fp_tag_1;
                f_dir_1[fi__p1] <= fp_dir_1;
                f_addr_1[fi__p1] <= fp_addr_1;
                f_bytes_1[fi__p1] <= fp_bytes_1;
                f_rm1_1[fi__p1] <= fp_rm1_1;
                f_one_1[fi__p1] <= fp_one_1;
                f_stride_1[fi__p1] <= fp_stride_1;
                f_last_1[fi__p1] <= fp_last_1;
            end
            if (go_l_1) begin
                f_wp_1 <= (f_wp_1 + 1);
                a_v_1 <= 1;
                a_id_1 <= {1'd0, h_q_l_1};
                a_tag_1 <= h_tag_l_1;
            end
            a_v_2 <= 0;
            fp_v_2 <= go_l_2;
            if (fp_v_2) begin
                f_cid_2[fi__p2] <= fp_cid_2;
                f_q_2[fi__p2] <= fp_q_2;
                f_tag_2[fi__p2] <= fp_tag_2;
                f_dir_2[fi__p2] <= fp_dir_2;
                f_addr_2[fi__p2] <= fp_addr_2;
                f_bytes_2[fi__p2] <= fp_bytes_2;
                f_rm1_2[fi__p2] <= fp_rm1_2;
                f_one_2[fi__p2] <= fp_one_2;
                f_stride_2[fi__p2] <= fp_stride_2;
                f_last_2[fi__p2] <= fp_last_2;
            end
            if (go_l_2) begin
                f_wp_2 <= (f_wp_2 + 1);
                a_v_2 <= 1;
                a_id_2 <= {1'd0, h_q_l_2};
                a_tag_2 <= h_tag_l_2;
            end
            if (adm_any) begin
                adm_rr <= ((adm_sel == 2) ? 2'd0 : (adm_sel + 1));
            end
            hm_q_0 <= hmism_l_0;
            hm_q_1 <= hmism_l_1;
            hm_q_2 <= hmism_l_2;
            dbg_mismatch <= (dbg_mismatch + {31'd0, mism_q});
            pw_dec_q <= pw_dec;
            pend_write <= (pw_inc ? pw_base1 : pw_base);
            dq_instq <= instq_nx;
            dq_gateq <= gateq_nx;
            dq_gateq2 <= gateq2_nx;
            dq_gate_block <= gate_block_nx;
            dq_admit <= {1'd0, adm_any};
            if (iadv_l_0) begin
                f_ip_0 <= f_ip1_l_0;
            end
            if (iin_l_0) begin
                inj_addr[0] <= habs_l_0;
                ih_lr_0 <= hone_l_0;
            end else begin
                if (iadv_l_0) begin
                    inj_addr[0] <= inx_addr_l_0;
                    ih_lr_0 <= inx_one_l_0;
                end else begin
                    if (inj_go_l_0) begin
                        inj_addr[0] <= (inj_addr[0] + ih_stride_0);
                        ih_lr_0 <= (ih_rem_0 == 1);
                    end
                end
            end
            if ((dsp_ev_l_0 & dfull_l_0)) begin
                rn_v_0 <= 1;
                rn_cid[0] <= p_0_dsp_cid;
                rn_dir_0 <= ddir_l_0;
                rn_own_0 <= own_reg_l_0;
            end else begin
                rn_own_0 <= own_hold_l_0;
            end
            f_in_0 <= (go_l_0 ? (iadv_l_0 ? f_in_0 : (f_in_0 + 1)) : (iadv_l_0 ? (f_in_0 - 1) : f_in_0));
            if (iadv_l_1) begin
                f_ip_1 <= f_ip1_l_1;
            end
            if (iin_l_1) begin
                inj_addr[1] <= habs_l_1;
                ih_lr_1 <= hone_l_1;
            end else begin
                if (iadv_l_1) begin
                    inj_addr[1] <= inx_addr_l_1;
                    ih_lr_1 <= inx_one_l_1;
                end else begin
                    if (inj_go_l_1) begin
                        inj_addr[1] <= (inj_addr[1] + ih_stride_1);
                        ih_lr_1 <= (ih_rem_1 == 1);
                    end
                end
            end
            if ((dsp_ev_l_1 & dfull_l_1)) begin
                rn_v_1 <= 1;
                rn_cid[1] <= p_1_dsp_cid;
                rn_dir_1 <= ddir_l_1;
                rn_own_1 <= own_reg_l_1;
            end else begin
                rn_own_1 <= own_hold_l_1;
            end
            f_in_1 <= (go_l_1 ? (iadv_l_1 ? f_in_1 : (f_in_1 + 1)) : (iadv_l_1 ? (f_in_1 - 1) : f_in_1));
            if (iadv_l_2) begin
                f_ip_2 <= f_ip1_l_2;
            end
            if (iin_l_2) begin
                inj_addr[2] <= habs_l_2;
                ih_lr_2 <= hone_l_2;
            end else begin
                if (iadv_l_2) begin
                    inj_addr[2] <= inx_addr_l_2;
                    ih_lr_2 <= inx_one_l_2;
                end else begin
                    if (inj_go_l_2) begin
                        inj_addr[2] <= (inj_addr[2] + ih_stride_2);
                        ih_lr_2 <= (ih_rem_2 == 1);
                    end
                end
            end
            if ((dsp_ev_l_2 & dfull_l_2)) begin
                rn_v_2 <= 1;
                rn_cid[2] <= p_2_dsp_cid;
                rn_dir_2 <= ddir_l_2;
                rn_own_2 <= own_reg_l_2;
            end else begin
                rn_own_2 <= own_hold_l_2;
            end
            f_in_2 <= (go_l_2 ? (iadv_l_2 ? f_in_2 : (f_in_2 + 1)) : (iadv_l_2 ? (f_in_2 - 1) : f_in_2));
            if (comp_l_0) begin
                f_cp_0 <= f_cp1_l_0;
            end
            if (cin_l_0) begin
                fc_last_0 <= hone_l_0;
                fc_dir_0 <= h_dir_l_0;
            end else begin
                if (comp_l_0) begin
                    fc_last_0 <= cnx_one_l_0;
                    fc_dir_0 <= cnx_dir_l_0;
                end else begin
                    if (sdone_l_0) begin
                        fc_last_0 <= (fc_rem_0 == 1);
                    end
                end
            end
            if (bpush__p0) begin
                b_id_0[b_wp_0] <= {1'd0, comp_q_l_0};
                b_tag_0[b_wp_0] <= comp_tag_l_0;
                b_wp_0 <= (b_wp_0 + 1);
            end
            if (b_pop_l_0) begin
                b_rp_0 <= (b_rp_0 + 1);
            end
            if ((bpush__p0 & (~b_pop_l_0))) begin
                b_n_0 <= (b_n_0 + 1);
            end else begin
                if ((b_pop_l_0 & (~bpush__p0))) begin
                    b_n_0 <= (b_n_0 - 1);
                end
            end
            f_n_p_0 <= f_n_nx_l_0;
            f_room_0 <= (f_n_nx_l_0 != 16);
            if (comp_l_1) begin
                f_cp_1 <= f_cp1_l_1;
            end
            if (cin_l_1) begin
                fc_last_1 <= hone_l_1;
                fc_dir_1 <= h_dir_l_1;
            end else begin
                if (comp_l_1) begin
                    fc_last_1 <= cnx_one_l_1;
                    fc_dir_1 <= cnx_dir_l_1;
                end else begin
                    if (sdone_l_1) begin
                        fc_last_1 <= (fc_rem_1 == 1);
                    end
                end
            end
            if (bpush__p1) begin
                b_id_1[b_wp_1] <= {1'd0, comp_q_l_1};
                b_tag_1[b_wp_1] <= comp_tag_l_1;
                b_wp_1 <= (b_wp_1 + 1);
            end
            if (b_pop_l_1) begin
                b_rp_1 <= (b_rp_1 + 1);
            end
            if ((bpush__p1 & (~b_pop_l_1))) begin
                b_n_1 <= (b_n_1 + 1);
            end else begin
                if ((b_pop_l_1 & (~bpush__p1))) begin
                    b_n_1 <= (b_n_1 - 1);
                end
            end
            f_n_p_1 <= f_n_nx_l_1;
            f_room_1 <= (f_n_nx_l_1 != 16);
            if (comp_l_2) begin
                f_cp_2 <= f_cp1_l_2;
            end
            if (cin_l_2) begin
                fc_last_2 <= hone_l_2;
                fc_dir_2 <= h_dir_l_2;
            end else begin
                if (comp_l_2) begin
                    fc_last_2 <= cnx_one_l_2;
                    fc_dir_2 <= cnx_dir_l_2;
                end else begin
                    if (sdone_l_2) begin
                        fc_last_2 <= (fc_rem_2 == 1);
                    end
                end
            end
            if (bpush__p2) begin
                b_id_2[b_wp_2] <= {1'd0, comp_q_l_2};
                b_tag_2[b_wp_2] <= comp_tag_l_2;
                b_wp_2 <= (b_wp_2 + 1);
            end
            if (b_pop_l_2) begin
                b_rp_2 <= (b_rp_2 + 1);
            end
            if ((bpush__p2 & (~b_pop_l_2))) begin
                b_n_2 <= (b_n_2 + 1);
            end else begin
                if ((b_pop_l_2 & (~bpush__p2))) begin
                    b_n_2 <= (b_n_2 - 1);
                end
            end
            f_n_p_2 <= f_n_nx_l_2;
            f_room_2 <= (f_n_nx_l_2 != 16);
            if (ci_push) begin
                ci_mpi[ci_wp] <= cm_pi;
                ci_mri[ci_wp] <= cm_ri;
                ci_mfl[ci_wp] <= cm_fl;
                ci_wdata[ci_wp] <= ctrl_s_cm_wdata;
                ci_write[ci_wp] <= ctrl_s_cm_write;
                ci_tag[ci_wp] <= ctrl_s_cm_tag;
                ci_wp <= (ci_wp + 1);
            end
            if (ci_pop) begin
                ci_rp <= (ci_rp + 1);
            end
            if ((ci_push & (~ci_pop))) begin
                ci_cnt <= (ci_cnt + 1);
            end else begin
                if ((ci_pop & (~ci_push))) begin
                    ci_cnt <= (ci_cnt - 1);
                end
            end
            if ((ci_is_pw & (ci_ri == 1))) begin
                st_base[ci_mid] <= ci_hwdata[19:0];
            end
            if ((ci_is_pw & (ci_ri == 2))) begin
                st_size[ci_mid] <= ci_hwdata[19:0];
            end
            if ((ci_is_pw & (ci_ri == 3))) begin
                st_dir[ci_mid] <= ci_hwdata[31];
                st_cnt[ci_mid] <= ci_hwdata[16:0];
            end
            if ((ci_is_parw & (ci_mid == 0))) begin
                st_pi_0 <= ch_pi;
                st_have_0 <= st_next;
            end
            if ((ci_is_parw & (ci_mid == 1))) begin
                st_pi_1 <= ch_pi;
                st_have_1 <= st_next;
            end
            if (cpush) begin
                c_cid[cw_idx] <= ch_pi;
                c_dir[cw_idx] <= st_dir[ci_mid];
                c_decl[cw_idx] <= st_cnt[ci_mid];
                c_base[cw_idx] <= st_base[ci_mid];
                c_size[cw_idx] <= st_size[ci_mid];
                if ((ci_mid == 0)) begin
                    st_have_0 <= 0;
                end
                if ((ci_mid == 1)) begin
                    st_have_1 <= 0;
                end
            end
            dbg_torn <= ((dbg_torn + {15'd0, torn_par}) + {15'd0, torn_trig});
            if ((cr_v & ctrl_s_cr_ready)) begin
                cr_v <= 0;
            end
            if ((ci_is_read & cr_free)) begin
                cr_v <= 1;
                cr_d <= rd_val;
                cr_t <= ci_htag;
            end
            a1_v <= (a1_any | ci_byp);
            a1_pp <= pp1_f;
            if ((a1_any | ci_byp)) begin
                a1_mpp <= pp1_f;
            end
            ca_v <= a2_ok;
            ca_pp <= a1_pp;
            ca_cid <= c_cid[a2_idx];
            ca_dir <= c_dir[a2_idx];
            ca_decl <= c_decl[a2_idx];
            ca_base <= c_base[a2_idx];
            ca_size <= c_size[a2_idx];
            pop_q <= dec;
            pop_pp <= ca_pp;
            if (ic_fire) begin
                ic_v <= 0;
            end
            if (ic_load) begin
                ic_v <= 1;
            end
            if (ic_free) begin
                ic_cid <= ca_cid;
                ic_dir <= ca_dir;
                ic_decl <= ca_decl;
                ic_dm1 <= (ca_decl - 1);
                ic_base <= ca_base;
                ic_size <= ca_size;
                ic_pd <= pd_same;
                ic_opp <= opp_cid;
                ic_raww <= new_raww;
            end
            if (c_up_0) begin
                c_wp_0 <= (c_wp_0 + 1);
            end
            if (c_dn_0) begin
                c_rp_0 <= (c_rp_0 + 1);
            end
            c_cnt_0 <= c_cnt_nx_0;
            c_ne_0 <= (c_cnt_nx_0 != 0);
            c_fl_0 <= (c_cnt_nx_0 == 4);
            if (c_up_1) begin
                c_wp_1 <= (c_wp_1 + 1);
            end
            if (c_dn_1) begin
                c_rp_1 <= (c_rp_1 + 1);
            end
            c_cnt_1 <= c_cnt_nx_1;
            c_ne_1 <= (c_cnt_nx_1 != 0);
            c_fl_1 <= (c_cnt_nx_1 == 4);
            if (c_up_2) begin
                c_wp_2 <= (c_wp_2 + 1);
            end
            if (c_dn_2) begin
                c_rp_2 <= (c_rp_2 + 1);
            end
            c_cnt_2 <= c_cnt_nx_2;
            c_ne_2 <= (c_cnt_nx_2 != 0);
            c_fl_2 <= (c_cnt_nx_2 == 4);
            if (c_up_3) begin
                c_wp_3 <= (c_wp_3 + 1);
            end
            if (c_dn_3) begin
                c_rp_3 <= (c_rp_3 + 1);
            end
            c_cnt_3 <= c_cnt_nx_3;
            c_ne_3 <= (c_cnt_nx_3 != 0);
            c_fl_3 <= (c_cnt_nx_3 == 4);
            if (c_up_4) begin
                c_wp_4 <= (c_wp_4 + 1);
            end
            if (c_dn_4) begin
                c_rp_4 <= (c_rp_4 + 1);
            end
            c_cnt_4 <= c_cnt_nx_4;
            c_ne_4 <= (c_cnt_nx_4 != 0);
            c_fl_4 <= (c_cnt_nx_4 == 4);
            if (c_up_5) begin
                c_wp_5 <= (c_wp_5 + 1);
            end
            if (c_dn_5) begin
                c_rp_5 <= (c_rp_5 + 1);
            end
            c_cnt_5 <= c_cnt_nx_5;
            c_ne_5 <= (c_cnt_nx_5 != 0);
            c_fl_5 <= (c_cnt_nx_5 == 4);
            if (c_up_6) begin
                c_wp_6 <= (c_wp_6 + 1);
            end
            if (c_dn_6) begin
                c_rp_6 <= (c_rp_6 + 1);
            end
            c_cnt_6 <= c_cnt_nx_6;
            c_ne_6 <= (c_cnt_nx_6 != 0);
            c_fl_6 <= (c_cnt_nx_6 == 4);
            if (c_up_7) begin
                c_wp_7 <= (c_wp_7 + 1);
            end
            if (c_dn_7) begin
                c_rp_7 <= (c_rp_7 + 1);
            end
            c_cnt_7 <= c_cnt_nx_7;
            c_ne_7 <= (c_cnt_nx_7 != 0);
            c_fl_7 <= (c_cnt_nx_7 == 4);
            if (c_up_8) begin
                c_wp_8 <= (c_wp_8 + 1);
            end
            if (c_dn_8) begin
                c_rp_8 <= (c_rp_8 + 1);
            end
            c_cnt_8 <= c_cnt_nx_8;
            c_ne_8 <= (c_cnt_nx_8 != 0);
            c_fl_8 <= (c_cnt_nx_8 == 4);
            if (c_up_9) begin
                c_wp_9 <= (c_wp_9 + 1);
            end
            if (c_dn_9) begin
                c_rp_9 <= (c_rp_9 + 1);
            end
            c_cnt_9 <= c_cnt_nx_9;
            c_ne_9 <= (c_cnt_nx_9 != 0);
            c_fl_9 <= (c_cnt_nx_9 == 4);
            if (c_up_10) begin
                c_wp_10 <= (c_wp_10 + 1);
            end
            if (c_dn_10) begin
                c_rp_10 <= (c_rp_10 + 1);
            end
            c_cnt_10 <= c_cnt_nx_10;
            c_ne_10 <= (c_cnt_nx_10 != 0);
            c_fl_10 <= (c_cnt_nx_10 == 4);
            if (c_up_11) begin
                c_wp_11 <= (c_wp_11 + 1);
            end
            if (c_dn_11) begin
                c_rp_11 <= (c_rp_11 + 1);
            end
            c_cnt_11 <= c_cnt_nx_11;
            c_ne_11 <= (c_cnt_nx_11 != 0);
            c_fl_11 <= (c_cnt_nx_11 == 4);
            if (c_up_12) begin
                c_wp_12 <= (c_wp_12 + 1);
            end
            if (c_dn_12) begin
                c_rp_12 <= (c_rp_12 + 1);
            end
            c_cnt_12 <= c_cnt_nx_12;
            c_ne_12 <= (c_cnt_nx_12 != 0);
            c_fl_12 <= (c_cnt_nx_12 == 4);
            if (c_up_13) begin
                c_wp_13 <= (c_wp_13 + 1);
            end
            if (c_dn_13) begin
                c_rp_13 <= (c_rp_13 + 1);
            end
            c_cnt_13 <= c_cnt_nx_13;
            c_ne_13 <= (c_cnt_nx_13 != 0);
            c_fl_13 <= (c_cnt_nx_13 == 4);
            if (c_up_14) begin
                c_wp_14 <= (c_wp_14 + 1);
            end
            if (c_dn_14) begin
                c_rp_14 <= (c_rp_14 + 1);
            end
            c_cnt_14 <= c_cnt_nx_14;
            c_ne_14 <= (c_cnt_nx_14 != 0);
            c_fl_14 <= (c_cnt_nx_14 == 4);
            if (c_up_15) begin
                c_wp_15 <= (c_wp_15 + 1);
            end
            if (c_dn_15) begin
                c_rp_15 <= (c_rp_15 + 1);
            end
            c_cnt_15 <= c_cnt_nx_15;
            c_ne_15 <= (c_cnt_nx_15 != 0);
            c_fl_15 <= (c_cnt_nx_15 == 4);
            if (c_up_16) begin
                c_wp_16 <= (c_wp_16 + 1);
            end
            if (c_dn_16) begin
                c_rp_16 <= (c_rp_16 + 1);
            end
            c_cnt_16 <= c_cnt_nx_16;
            c_ne_16 <= (c_cnt_nx_16 != 0);
            c_fl_16 <= (c_cnt_nx_16 == 4);
            if (c_up_17) begin
                c_wp_17 <= (c_wp_17 + 1);
            end
            if (c_dn_17) begin
                c_rp_17 <= (c_rp_17 + 1);
            end
            c_cnt_17 <= c_cnt_nx_17;
            c_ne_17 <= (c_cnt_nx_17 != 0);
            c_fl_17 <= (c_cnt_nx_17 == 4);
            if (c_up_18) begin
                c_wp_18 <= (c_wp_18 + 1);
            end
            if (c_dn_18) begin
                c_rp_18 <= (c_rp_18 + 1);
            end
            c_cnt_18 <= c_cnt_nx_18;
            c_ne_18 <= (c_cnt_nx_18 != 0);
            c_fl_18 <= (c_cnt_nx_18 == 4);
            if (c_up_19) begin
                c_wp_19 <= (c_wp_19 + 1);
            end
            if (c_dn_19) begin
                c_rp_19 <= (c_rp_19 + 1);
            end
            c_cnt_19 <= c_cnt_nx_19;
            c_ne_19 <= (c_cnt_nx_19 != 0);
            c_fl_19 <= (c_cnt_nx_19 == 4);
            if (c_up_20) begin
                c_wp_20 <= (c_wp_20 + 1);
            end
            if (c_dn_20) begin
                c_rp_20 <= (c_rp_20 + 1);
            end
            c_cnt_20 <= c_cnt_nx_20;
            c_ne_20 <= (c_cnt_nx_20 != 0);
            c_fl_20 <= (c_cnt_nx_20 == 4);
            if (c_up_21) begin
                c_wp_21 <= (c_wp_21 + 1);
            end
            if (c_dn_21) begin
                c_rp_21 <= (c_rp_21 + 1);
            end
            c_cnt_21 <= c_cnt_nx_21;
            c_ne_21 <= (c_cnt_nx_21 != 0);
            c_fl_21 <= (c_cnt_nx_21 == 4);
            if (c_up_22) begin
                c_wp_22 <= (c_wp_22 + 1);
            end
            if (c_dn_22) begin
                c_rp_22 <= (c_rp_22 + 1);
            end
            c_cnt_22 <= c_cnt_nx_22;
            c_ne_22 <= (c_cnt_nx_22 != 0);
            c_fl_22 <= (c_cnt_nx_22 == 4);
            if (c_up_23) begin
                c_wp_23 <= (c_wp_23 + 1);
            end
            if (c_dn_23) begin
                c_rp_23 <= (c_rp_23 + 1);
            end
            c_cnt_23 <= c_cnt_nx_23;
            c_ne_23 <= (c_cnt_nx_23 != 0);
            c_fl_23 <= (c_cnt_nx_23 == 4);
            if (c_up_24) begin
                c_wp_24 <= (c_wp_24 + 1);
            end
            if (c_dn_24) begin
                c_rp_24 <= (c_rp_24 + 1);
            end
            c_cnt_24 <= c_cnt_nx_24;
            c_ne_24 <= (c_cnt_nx_24 != 0);
            c_fl_24 <= (c_cnt_nx_24 == 4);
            if (c_up_25) begin
                c_wp_25 <= (c_wp_25 + 1);
            end
            if (c_dn_25) begin
                c_rp_25 <= (c_rp_25 + 1);
            end
            c_cnt_25 <= c_cnt_nx_25;
            c_ne_25 <= (c_cnt_nx_25 != 0);
            c_fl_25 <= (c_cnt_nx_25 == 4);
            if (c_up_26) begin
                c_wp_26 <= (c_wp_26 + 1);
            end
            if (c_dn_26) begin
                c_rp_26 <= (c_rp_26 + 1);
            end
            c_cnt_26 <= c_cnt_nx_26;
            c_ne_26 <= (c_cnt_nx_26 != 0);
            c_fl_26 <= (c_cnt_nx_26 == 4);
            if (c_up_27) begin
                c_wp_27 <= (c_wp_27 + 1);
            end
            if (c_dn_27) begin
                c_rp_27 <= (c_rp_27 + 1);
            end
            c_cnt_27 <= c_cnt_nx_27;
            c_ne_27 <= (c_cnt_nx_27 != 0);
            c_fl_27 <= (c_cnt_nx_27 == 4);
            if (c_up_28) begin
                c_wp_28 <= (c_wp_28 + 1);
            end
            if (c_dn_28) begin
                c_rp_28 <= (c_rp_28 + 1);
            end
            c_cnt_28 <= c_cnt_nx_28;
            c_ne_28 <= (c_cnt_nx_28 != 0);
            c_fl_28 <= (c_cnt_nx_28 == 4);
            if (c_up_29) begin
                c_wp_29 <= (c_wp_29 + 1);
            end
            if (c_dn_29) begin
                c_rp_29 <= (c_rp_29 + 1);
            end
            c_cnt_29 <= c_cnt_nx_29;
            c_ne_29 <= (c_cnt_nx_29 != 0);
            c_fl_29 <= (c_cnt_nx_29 == 4);
            if (c_up_30) begin
                c_wp_30 <= (c_wp_30 + 1);
            end
            if (c_dn_30) begin
                c_rp_30 <= (c_rp_30 + 1);
            end
            c_cnt_30 <= c_cnt_nx_30;
            c_ne_30 <= (c_cnt_nx_30 != 0);
            c_fl_30 <= (c_cnt_nx_30 == 4);
            if (c_up_31) begin
                c_wp_31 <= (c_wp_31 + 1);
            end
            if (c_dn_31) begin
                c_rp_31 <= (c_rp_31 + 1);
            end
            c_cnt_31 <= c_cnt_nx_31;
            c_ne_31 <= (c_cnt_nx_31 != 0);
            c_fl_31 <= (c_cnt_nx_31 == 4);
            if (c_up_32) begin
                c_wp_32 <= (c_wp_32 + 1);
            end
            if (c_dn_32) begin
                c_rp_32 <= (c_rp_32 + 1);
            end
            c_cnt_32 <= c_cnt_nx_32;
            c_ne_32 <= (c_cnt_nx_32 != 0);
            c_fl_32 <= (c_cnt_nx_32 == 4);
            if (c_up_33) begin
                c_wp_33 <= (c_wp_33 + 1);
            end
            if (c_dn_33) begin
                c_rp_33 <= (c_rp_33 + 1);
            end
            c_cnt_33 <= c_cnt_nx_33;
            c_ne_33 <= (c_cnt_nx_33 != 0);
            c_fl_33 <= (c_cnt_nx_33 == 4);
            if (c_up_34) begin
                c_wp_34 <= (c_wp_34 + 1);
            end
            if (c_dn_34) begin
                c_rp_34 <= (c_rp_34 + 1);
            end
            c_cnt_34 <= c_cnt_nx_34;
            c_ne_34 <= (c_cnt_nx_34 != 0);
            c_fl_34 <= (c_cnt_nx_34 == 4);
            if (c_up_35) begin
                c_wp_35 <= (c_wp_35 + 1);
            end
            if (c_dn_35) begin
                c_rp_35 <= (c_rp_35 + 1);
            end
            c_cnt_35 <= c_cnt_nx_35;
            c_ne_35 <= (c_cnt_nx_35 != 0);
            c_fl_35 <= (c_cnt_nx_35 == 4);
            if (c_up_36) begin
                c_wp_36 <= (c_wp_36 + 1);
            end
            if (c_dn_36) begin
                c_rp_36 <= (c_rp_36 + 1);
            end
            c_cnt_36 <= c_cnt_nx_36;
            c_ne_36 <= (c_cnt_nx_36 != 0);
            c_fl_36 <= (c_cnt_nx_36 == 4);
            if (c_up_37) begin
                c_wp_37 <= (c_wp_37 + 1);
            end
            if (c_dn_37) begin
                c_rp_37 <= (c_rp_37 + 1);
            end
            c_cnt_37 <= c_cnt_nx_37;
            c_ne_37 <= (c_cnt_nx_37 != 0);
            c_fl_37 <= (c_cnt_nx_37 == 4);
            if (c_up_38) begin
                c_wp_38 <= (c_wp_38 + 1);
            end
            if (c_dn_38) begin
                c_rp_38 <= (c_rp_38 + 1);
            end
            c_cnt_38 <= c_cnt_nx_38;
            c_ne_38 <= (c_cnt_nx_38 != 0);
            c_fl_38 <= (c_cnt_nx_38 == 4);
            if (c_up_39) begin
                c_wp_39 <= (c_wp_39 + 1);
            end
            if (c_dn_39) begin
                c_rp_39 <= (c_rp_39 + 1);
            end
            c_cnt_39 <= c_cnt_nx_39;
            c_ne_39 <= (c_cnt_nx_39 != 0);
            c_fl_39 <= (c_cnt_nx_39 == 4);
            if (c_up_40) begin
                c_wp_40 <= (c_wp_40 + 1);
            end
            if (c_dn_40) begin
                c_rp_40 <= (c_rp_40 + 1);
            end
            c_cnt_40 <= c_cnt_nx_40;
            c_ne_40 <= (c_cnt_nx_40 != 0);
            c_fl_40 <= (c_cnt_nx_40 == 4);
            if (c_up_41) begin
                c_wp_41 <= (c_wp_41 + 1);
            end
            if (c_dn_41) begin
                c_rp_41 <= (c_rp_41 + 1);
            end
            c_cnt_41 <= c_cnt_nx_41;
            c_ne_41 <= (c_cnt_nx_41 != 0);
            c_fl_41 <= (c_cnt_nx_41 == 4);
            if (c_up_42) begin
                c_wp_42 <= (c_wp_42 + 1);
            end
            if (c_dn_42) begin
                c_rp_42 <= (c_rp_42 + 1);
            end
            c_cnt_42 <= c_cnt_nx_42;
            c_ne_42 <= (c_cnt_nx_42 != 0);
            c_fl_42 <= (c_cnt_nx_42 == 4);
            if (c_up_43) begin
                c_wp_43 <= (c_wp_43 + 1);
            end
            if (c_dn_43) begin
                c_rp_43 <= (c_rp_43 + 1);
            end
            c_cnt_43 <= c_cnt_nx_43;
            c_ne_43 <= (c_cnt_nx_43 != 0);
            c_fl_43 <= (c_cnt_nx_43 == 4);
            if (c_up_44) begin
                c_wp_44 <= (c_wp_44 + 1);
            end
            if (c_dn_44) begin
                c_rp_44 <= (c_rp_44 + 1);
            end
            c_cnt_44 <= c_cnt_nx_44;
            c_ne_44 <= (c_cnt_nx_44 != 0);
            c_fl_44 <= (c_cnt_nx_44 == 4);
            if (c_up_45) begin
                c_wp_45 <= (c_wp_45 + 1);
            end
            if (c_dn_45) begin
                c_rp_45 <= (c_rp_45 + 1);
            end
            c_cnt_45 <= c_cnt_nx_45;
            c_ne_45 <= (c_cnt_nx_45 != 0);
            c_fl_45 <= (c_cnt_nx_45 == 4);
            if (c_up_46) begin
                c_wp_46 <= (c_wp_46 + 1);
            end
            if (c_dn_46) begin
                c_rp_46 <= (c_rp_46 + 1);
            end
            c_cnt_46 <= c_cnt_nx_46;
            c_ne_46 <= (c_cnt_nx_46 != 0);
            c_fl_46 <= (c_cnt_nx_46 == 4);
            if (c_up_47) begin
                c_wp_47 <= (c_wp_47 + 1);
            end
            if (c_dn_47) begin
                c_rp_47 <= (c_rp_47 + 1);
            end
            c_cnt_47 <= c_cnt_nx_47;
            c_ne_47 <= (c_cnt_nx_47 != 0);
            c_fl_47 <= (c_cnt_nx_47 == 4);
            if ((cpush & (~pop_q))) begin
                cfg_pend <= (cfg_pend + 1);
            end else begin
                if ((pop_q & (~cpush))) begin
                    cfg_pend <= (cfg_pend - 1);
                end
            end
            if (ic_fire) begin
                s_base[ic] <= ic_base;
                s_size[ic] <= ic_size;
                s_dir[ic] <= ic_dir;
                s_decl[ic] <= ic_decl;
                s_dm1[ic] <= ic_dm1;
                s_rawpeer[ic] <= ic_opp;
                if (ic_raww) begin
                    s_depread[ic_opp] <= ic;
                end
                p_cid[ic_pd] <= ic;
            end
            live_slots <= ((live_slots + {7'd0, ic_fire}) - {7'd0, ret_fire});
        end
    end
    always_ff @(posedge clk) begin
        dp_idx <= dsp_idx;
        dp_data <= dsp_data;
        dp_fb <= (dsp_any & disp_full);
        dp_dm1 <= (dsp_any ? disp_dm1 : ic_dm1);
        fp_wp_0 <= f_wp_0;
        fp_cid_0 <= h_cid_l_0;
        fp_q_0 <= h_q_l_0;
        fp_tag_0 <= h_tag_l_0;
        fp_dir_0 <= h_dir_l_0;
        fp_addr_0 <= habs_l_0;
        fp_bytes_0 <= h_bytes_l_0;
        fp_rm1_0 <= hrm1_l_0;
        fp_one_0 <= hone_l_0;
        fp_stride_0 <= h_stride_l_0;
        fp_last_0 <= h_last_l_0;
        fp_wp_1 <= f_wp_1;
        fp_cid_1 <= h_cid_l_1;
        fp_q_1 <= h_q_l_1;
        fp_tag_1 <= h_tag_l_1;
        fp_dir_1 <= h_dir_l_1;
        fp_addr_1 <= habs_l_1;
        fp_bytes_1 <= h_bytes_l_1;
        fp_rm1_1 <= hrm1_l_1;
        fp_one_1 <= hone_l_1;
        fp_stride_1 <= h_stride_l_1;
        fp_last_1 <= h_last_l_1;
        fp_wp_2 <= f_wp_2;
        fp_cid_2 <= h_cid_l_2;
        fp_q_2 <= h_q_l_2;
        fp_tag_2 <= h_tag_l_2;
        fp_dir_2 <= h_dir_l_2;
        fp_addr_2 <= habs_l_2;
        fp_bytes_2 <= h_bytes_l_2;
        fp_rm1_2 <= hrm1_l_2;
        fp_one_2 <= hone_l_2;
        fp_stride_2 <= h_stride_l_2;
        fp_last_2 <= h_last_l_2;
        if (iin_l_0) begin
            ih_cid_0 <= h_cid_l_0;
            ih_q_0 <= h_q_l_0;
            ih_tag_0 <= h_tag_l_0;
            ih_dir_0 <= h_dir_l_0;
            ih_bytes_0 <= h_bytes_l_0;
            ih_rem_0 <= hrm1_l_0;
            ih_stride_0 <= h_stride_l_0;
            ih_last_0 <= h_last_l_0;
        end else begin
            if (iadv_l_0) begin
                ih_cid_0 <= inx_cid_l_0;
                ih_q_0 <= inx_q_l_0;
                ih_tag_0 <= inx_tag_l_0;
                ih_dir_0 <= inx_dir_l_0;
                ih_bytes_0 <= inx_bytes_l_0;
                ih_rem_0 <= inx_rm1_l_0;
                ih_stride_0 <= inx_stride_l_0;
                ih_last_0 <= inx_last_l_0;
            end else begin
                if (inj_go_l_0) begin
                    ih_rem_0 <= (ih_rem_0 - 1);
                end
            end
        end
        if (iin_l_1) begin
            ih_cid_1 <= h_cid_l_1;
            ih_q_1 <= h_q_l_1;
            ih_tag_1 <= h_tag_l_1;
            ih_dir_1 <= h_dir_l_1;
            ih_bytes_1 <= h_bytes_l_1;
            ih_rem_1 <= hrm1_l_1;
            ih_stride_1 <= h_stride_l_1;
            ih_last_1 <= h_last_l_1;
        end else begin
            if (iadv_l_1) begin
                ih_cid_1 <= inx_cid_l_1;
                ih_q_1 <= inx_q_l_1;
                ih_tag_1 <= inx_tag_l_1;
                ih_dir_1 <= inx_dir_l_1;
                ih_bytes_1 <= inx_bytes_l_1;
                ih_rem_1 <= inx_rm1_l_1;
                ih_stride_1 <= inx_stride_l_1;
                ih_last_1 <= inx_last_l_1;
            end else begin
                if (inj_go_l_1) begin
                    ih_rem_1 <= (ih_rem_1 - 1);
                end
            end
        end
        if (iin_l_2) begin
            ih_cid_2 <= h_cid_l_2;
            ih_q_2 <= h_q_l_2;
            ih_tag_2 <= h_tag_l_2;
            ih_dir_2 <= h_dir_l_2;
            ih_bytes_2 <= h_bytes_l_2;
            ih_rem_2 <= hrm1_l_2;
            ih_stride_2 <= h_stride_l_2;
            ih_last_2 <= h_last_l_2;
        end else begin
            if (iadv_l_2) begin
                ih_cid_2 <= inx_cid_l_2;
                ih_q_2 <= inx_q_l_2;
                ih_tag_2 <= inx_tag_l_2;
                ih_dir_2 <= inx_dir_l_2;
                ih_bytes_2 <= inx_bytes_l_2;
                ih_rem_2 <= inx_rm1_l_2;
                ih_stride_2 <= inx_stride_l_2;
                ih_last_2 <= inx_last_l_2;
            end else begin
                if (inj_go_l_2) begin
                    ih_rem_2 <= (ih_rem_2 - 1);
                end
            end
        end
        if (cin_l_0) begin
            fc_rem_0 <= hrm1_l_0;
        end else begin
            if (comp_l_0) begin
                fc_rem_0 <= cnx_rm1_l_0;
            end else begin
                if (sdone_l_0) begin
                    fc_rem_0 <= (fc_rem_0 - 1);
                end
            end
        end
        if (cin_l_1) begin
            fc_rem_1 <= hrm1_l_1;
        end else begin
            if (comp_l_1) begin
                fc_rem_1 <= cnx_rm1_l_1;
            end else begin
                if (sdone_l_1) begin
                    fc_rem_1 <= (fc_rem_1 - 1);
                end
            end
        end
        if (cin_l_2) begin
            fc_rem_2 <= hrm1_l_2;
        end else begin
            if (comp_l_2) begin
                fc_rem_2 <= cnx_rm1_l_2;
            end else begin
                if (sdone_l_2) begin
                    fc_rem_2 <= (fc_rem_2 - 1);
                end
            end
        end
        if (ch_ld) begin
            ch_pi <= chn_pi;
            ch_ri <= chn_ri;
            ch_fl <= chn_fl;
            ch_wdata <= chn_wdata;
            ch_write <= chn_write;
            ch_tag <= chn_tag;
        end
    end
endmodule
