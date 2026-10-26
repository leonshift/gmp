module DmaUnitW (
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
    output logic l1_ar_valid,
    input l1_ar_ready,
    output logic [3:0] l1_ar_id,
    output logic [15:0] l1_ar_tag,
    output logic [7:0] l1_ar_cfg,
    output logic [19:0] l1_ar_off,
    output logic [19:0] l1_ar_bytes,
    output logic [15:0] l1_ar_rows,
    output logic [19:0] l1_ar_stride,
    output logic l1_ar_first,
    output logic l1_ar_last,
    output logic l1_aw_valid,
    input l1_aw_ready,
    output logic [3:0] l1_aw_id,
    output logic [15:0] l1_aw_tag,
    output logic [7:0] l1_aw_cfg,
    output logic [19:0] l1_aw_off,
    output logic [19:0] l1_aw_bytes,
    output logic [15:0] l1_aw_rows,
    output logic [19:0] l1_aw_stride,
    output logic l1_aw_first,
    output logic l1_aw_last,
    output logic l1_w_valid,
    output logic [3:0] l1_w_id,
    output logic [1023:0] l1_w_data,
    output logic [127:0] l1_w_strb,
    input [7:0] l1_w_ready,
    input l1_r_valid,
    output logic l1_r_ready,
    input [1023:0] l1_r_data,
    input [3:0] l1_r_id,
    input [15:0] l1_r_tag,
    input l1_r_last,
    input l1_b_valid,
    output logic l1_b_ready,
    input [3:0] l1_b_id,
    input [15:0] l1_b_tag,
    input l1_a_valid,
    input [3:0] l1_a_id,
    input [15:0] l1_a_tag,
    input [7:0] l1_wroom,
    output logic noc_ar_valid,
    input noc_ar_ready,
    output logic [3:0] noc_ar_id,
    output logic [15:0] noc_ar_tag,
    output logic [47:0] noc_ar_addr,
    output logic [19:0] noc_ar_bytes,
    output logic [15:0] noc_ar_rows,
    output logic [19:0] noc_ar_stride,
    output logic noc_ar_first,
    output logic noc_ar_last,
    output logic noc_aw_valid,
    input noc_aw_ready,
    output logic [3:0] noc_aw_id,
    output logic [15:0] noc_aw_tag,
    output logic [47:0] noc_aw_addr,
    output logic [19:0] noc_aw_bytes,
    output logic [15:0] noc_aw_rows,
    output logic [19:0] noc_aw_stride,
    output logic noc_aw_first,
    output logic noc_aw_last,
    output logic noc_w_valid,
    output logic [3:0] noc_w_id,
    output logic [1023:0] noc_w_data,
    output logic [127:0] noc_w_strb,
    input [7:0] noc_w_ready,
    input noc_r_valid,
    output logic noc_r_ready,
    input [1023:0] noc_r_data,
    input [3:0] noc_r_id,
    input [15:0] noc_r_tag,
    input noc_r_last,
    input noc_b_valid,
    output logic noc_b_ready,
    input [3:0] noc_b_id,
    input [15:0] noc_b_tag,
    input noc_a_valid,
    input [3:0] noc_a_id,
    input [15:0] noc_a_tag,
    input [7:0] noc_wroom,
    output logic dbg_busy,
    output logic [3:0] dbg_ch_idle,
    output logic [11:0] dbg_ch_state,
    output logic [5:0] dbg_win_n,
    output logic [3:0] dbg_sid_used,
    output logic [2:0] dbg_noc_credit,
    output logic [2:0] dbg_seq_state,
    output logic [31:0] dbg_count_0,
    output logic [31:0] dbg_count_1,
    output logic [31:0] dbg_count_2,
    output logic [31:0] dbg_count_3,
    output logic [8:0] dbg_fifo_occ_0,
    output logic [8:0] dbg_fifo_occ_1,
    output logic [8:0] dbg_fifo_occ_2,
    output logic [8:0] dbg_fifo_occ_3
);
    logic [31:0] cm_addr;
    logic cm_seg;
    logic [6:0] cm_off;
    logic cm_isram;
    logic cm_kid;
    logic cm_kparam;
    logic cr_v;
    logic [31:0] cr_data_q;
    logic [23:0] cr_tag_q;
    logic [31:0] kparam;
    logic rd_ok;
    logic seq_lready;
    logic cm_fire;
    logic [2:0] cr_noc;
    logic [2:0] cr_l1_0;
    logic [2:0] cr_l1_1;
    logic [2:0] cr_l1_2;
    logic [2:0] cr_l1_3;
    logic cr_l1_nz_0;
    logic cr_l1_nz_1;
    logic cr_l1_nz_2;
    logic cr_l1_nz_3;
    logic cr_noc_nz;
    logic cr_noc_ge2;
    logic l1ar_v;
    logic [1:0] l1ar_idx;
    logic [31:0] l1ar_addr;
    logic [7:0] l1ar_cid;
    logic [19:0] l1ar_bytes;
    logic l1ar_first;
    logic l1ar_last;
    logic [15:0] l1ar_tag;
    logic l1aw_v;
    logic [1:0] l1aw_idx;
    logic [31:0] l1aw_addr;
    logic [7:0] l1aw_cid;
    logic [19:0] l1aw_bytes;
    logic l1aw_first;
    logic l1aw_last;
    logic [15:0] l1aw_tag;
    logic nar_v;
    logic [1:0] nar_idx;
    logic [31:0] nar_addr;
    logic [7:0] nar_cid;
    logic [19:0] nar_bytes;
    logic nar_first;
    logic nar_last;
    logic [15:0] nar_tag;
    logic naw_v;
    logic [1:0] naw_idx;
    logic [31:0] naw_addr;
    logic [7:0] naw_cid;
    logic [19:0] naw_bytes;
    logic naw_first;
    logic naw_last;
    logic [15:0] naw_tag;
    logic l1ar_d_v;
    logic [1:0] l1ar_d_idx;
    logic [31:0] l1ar_d_addr;
    logic [7:0] l1ar_d_cid;
    logic [19:0] l1ar_d_bytes;
    logic l1ar_d_first;
    logic l1ar_d_last;
    logic [15:0] l1ar_d_tag;
    logic l1aw_d_v;
    logic [1:0] l1aw_d_idx;
    logic [31:0] l1aw_d_addr;
    logic [7:0] l1aw_d_cid;
    logic [19:0] l1aw_d_bytes;
    logic l1aw_d_first;
    logic l1aw_d_last;
    logic [15:0] l1aw_d_tag;
    logic nar_d_v;
    logic [1:0] nar_d_idx;
    logic [31:0] nar_d_addr;
    logic [7:0] nar_d_cid;
    logic [19:0] nar_d_bytes;
    logic nar_d_first;
    logic nar_d_last;
    logic [15:0] nar_d_tag;
    logic naw_d_v;
    logic [1:0] naw_d_idx;
    logic [31:0] naw_d_addr;
    logic [7:0] naw_d_cid;
    logic [19:0] naw_d_bytes;
    logic naw_d_first;
    logic naw_d_last;
    logic [15:0] naw_d_tag;
    logic [1:0] l1w_idx;
    logic [3:0] l1w_oh;
    logic l1w_v;
    logic [3:0] l1w_c;
    logic [1:0] l1w_ptr;
    logic [7:0] l1w_room_q;
    logic l1w_g_v;
    logic [1:0] l1w_g_idx;
    logic l1w_oq_v;
    logic [1:0] l1w_oq_wid;
    logic [1023:0] l1w_oq_dat;
    logic [127:0] l1w_oq_stb;
    logic [1023:0] l1w_dat_c;
    logic [127:0] l1w_stb_c;
    logic [1:0] nocw_idx;
    logic [3:0] nocw_oh;
    logic nocw_v;
    logic [3:0] nocw_c;
    logic [1:0] nocw_ptr;
    logic [7:0] nocw_room_q;
    logic nocw_g_v;
    logic [1:0] nocw_g_idx;
    logic nocw_oq_v;
    logic [1:0] nocw_oq_wid;
    logic [1023:0] nocw_oq_dat;
    logic [127:0] nocw_oq_stb;
    logic [1023:0] nocw_dat_c;
    logic [127:0] nocw_stb_c;
    logic [1:0] l1w_gs_0;
    logic [1:0] l1w_gs_1;
    logic [1:0] l1w_gs_2;
    logic [1:0] l1w_gs_3;
    logic [1:0] l1w_gs_4;
    logic [1:0] l1w_gs_5;
    logic [1:0] l1w_gs_6;
    logic [1:0] l1w_gs_7;
    logic [1:0] l1w_gs_8;
    logic [1:0] l1w_gs_9;
    logic [1:0] l1w_gs_10;
    logic [1:0] l1w_gs_11;
    logic [1:0] l1w_gs_12;
    logic [1:0] l1w_gs_13;
    logic [1:0] l1w_gs_14;
    logic [1:0] l1w_gs_15;
    logic [1:0] l1w_gs_16;
    logic [1:0] l1w_gs_17;
    logic [1:0] l1w_gs_18;
    logic [1:0] l1w_gs_19;
    logic [1:0] l1w_gs_20;
    logic [1:0] l1w_gs_21;
    logic [1:0] l1w_gs_22;
    logic [1:0] l1w_gs_23;
    logic [1:0] l1w_gs_24;
    logic [1:0] l1w_gs_25;
    logic [1:0] l1w_gs_26;
    logic [1:0] l1w_gs_27;
    logic [1:0] l1w_gs_28;
    logic [1:0] l1w_gs_29;
    logic [1:0] l1w_gs_30;
    logic [1:0] l1w_gs_31;
    logic [1:0] l1w_gs_32;
    logic [1:0] l1w_gs_33;
    logic [1:0] l1w_gs_34;
    logic [1:0] l1w_gs_35;
    logic [1:0] nocw_gs_0;
    logic [1:0] nocw_gs_1;
    logic [1:0] nocw_gs_2;
    logic [1:0] nocw_gs_3;
    logic [1:0] nocw_gs_4;
    logic [1:0] nocw_gs_5;
    logic [1:0] nocw_gs_6;
    logic [1:0] nocw_gs_7;
    logic [1:0] nocw_gs_8;
    logic [1:0] nocw_gs_9;
    logic [1:0] nocw_gs_10;
    logic [1:0] nocw_gs_11;
    logic [1:0] nocw_gs_12;
    logic [1:0] nocw_gs_13;
    logic [1:0] nocw_gs_14;
    logic [1:0] nocw_gs_15;
    logic [1:0] nocw_gs_16;
    logic [1:0] nocw_gs_17;
    logic [1:0] nocw_gs_18;
    logic [1:0] nocw_gs_19;
    logic [1:0] nocw_gs_20;
    logic [1:0] nocw_gs_21;
    logic [1:0] nocw_gs_22;
    logic [1:0] nocw_gs_23;
    logic [1:0] nocw_gs_24;
    logic [1:0] nocw_gs_25;
    logic [1:0] nocw_gs_26;
    logic [1:0] nocw_gs_27;
    logic [1:0] nocw_gs_28;
    logic [1:0] nocw_gs_29;
    logic [1:0] nocw_gs_30;
    logic [1:0] nocw_gs_31;
    logic [1:0] nocw_gs_32;
    logic [1:0] nocw_gs_33;
    logic [1:0] nocw_gs_34;
    logic [1:0] nocw_gs_35;
    logic rd_tk_0;
    logic rd_tk_1;
    logic rd_tk_2;
    logic rd_tk_3;
    logic wr_tk_0;
    logic wr_tk_1;
    logic wr_tk_2;
    logic wr_tk_3;
    logic w_tk_0;
    logic w_tk_1;
    logic w_tk_2;
    logic w_tk_3;
    logic w_tkl_0_0;
    logic w_tkl_0_1;
    logic w_tkl_0_2;
    logic w_tkl_0_3;
    logic w_tkl_1_0;
    logic w_tkl_1_1;
    logic w_tkl_1_2;
    logic w_tkl_1_3;
    logic w_tkl_2_0;
    logic w_tkl_2_1;
    logic w_tkl_2_2;
    logic w_tkl_2_3;
    logic w_tkl_3_0;
    logic w_tkl_3_1;
    logic w_tkl_3_2;
    logic w_tkl_3_3;
    logic l1rd_g_0;
    logic l1rd_g_1;
    logic l1rd_g_2;
    logic l1rd_g_3;
    logic l1wr_g_0;
    logic l1wr_g_1;
    logic l1wr_g_2;
    logic l1wr_g_3;
    logic nrd_g_0;
    logic nrd_g_1;
    logic nrd_g_2;
    logic nrd_g_3;
    logic nwr_g_0;
    logic nwr_g_1;
    logic nwr_g_2;
    logic nwr_g_3;
    logic r_l1_0;
    logic r_l1_1;
    logic r_l1_2;
    logic r_l1_3;
    logic r_v_0;
    logic r_v_1;
    logic r_v_2;
    logic r_v_3;
    logic r_last_0;
    logic r_last_1;
    logic r_last_2;
    logic r_last_3;
    logic [1:0] a_n_0;
    logic [1:0] a_n_1;
    logic [1:0] a_n_2;
    logic [1:0] a_n_3;
    logic [1:0] b_n_0;
    logic [1:0] b_n_1;
    logic [1:0] b_n_2;
    logic [1:0] b_n_3;
    logic rd_av_0;
    logic rd_av_1;
    logic rd_av_2;
    logic rd_av_3;
    logic wr_av_0;
    logic wr_av_1;
    logic wr_av_2;
    logic wr_av_3;
    logic l1rd_cand_0;
    logic l1rd_cand_1;
    logic l1rd_cand_2;
    logic l1rd_cand_3;
    logic l1wr_cand_0;
    logic l1wr_cand_1;
    logic l1wr_cand_2;
    logic l1wr_cand_3;
    logic nrd_cand_0;
    logic nrd_cand_1;
    logic nrd_cand_2;
    logic nrd_cand_3;
    logic nwr_cand_0;
    logic nwr_cand_1;
    logic nwr_cand_2;
    logic nwr_cand_3;
    logic [1:0] l1rd_idx;
    logic [3:0] l1rd_oh;
    logic l1rd_v;
    logic [3:0] l1rd_c;
    logic [1:0] l1rd_rr;
    logic l1rd_fire;
    logic [1:0] l1wr_idx;
    logic [3:0] l1wr_oh;
    logic l1wr_v;
    logic [3:0] l1wr_c;
    logic [1:0] l1wr_rr;
    logic l1wr_fire;
    logic [1:0] nrd_idx;
    logic [3:0] nrd_oh;
    logic nrd_v;
    logic [3:0] nrd_c;
    logic [1:0] nrd_rr;
    logic nrd_fire;
    logic [1:0] nwr_idx;
    logic [3:0] nwr_oh;
    logic nwr_v;
    logic [3:0] nwr_c;
    logic [1:0] nwr_rr;
    logic nwr_fire;
    logic nwr_cred_ok;
    logic [2:0] cr_noc_n;
    logic [2:0] cr_l1_n_0;
    logic [2:0] cr_l1_n_1;
    logic [2:0] cr_l1_n_2;
    logic [2:0] cr_l1_n_3;
    logic rq_drop;
    logic w_av_0;
    logic w_av_1;
    logic w_av_2;
    logic w_av_3;
    logic w_tk_n_0;
    logic w_tk_n_1;
    logic w_tk_n_2;
    logic w_tk_n_3;
    logic any_active;
    logic busy;
    logic u_seq_sc_smem;
    logic [7:0] u_seq_sc_scid;
    logic [31:0] u_seq_sc_saddr;
    logic u_seq_sc_dmem;
    logic [7:0] u_seq_sc_dcid;
    logic [31:0] u_seq_sc_daddr;
    logic [15:0] u_seq_sc_rows;
    logic [19:0] u_seq_sc_bytes;
    logic [19:0] u_seq_sc_sstride;
    logic [19:0] u_seq_sc_dstride;
    logic u_seq_sc_valid;
    logic u_seq_sc_ready;
    logic u_fan_ch_0_cmd_valid;
    logic u_fan_ch_0_idle;
    logic u_fan_ch_0_rel;
    logic u_fan_cmd_smem;
    logic [7:0] u_fan_cmd_scid;
    logic [31:0] u_fan_cmd_saddr;
    logic u_fan_cmd_dmem;
    logic [7:0] u_fan_cmd_dcid;
    logic [31:0] u_fan_cmd_daddr;
    logic [15:0] u_fan_cmd_rows;
    logic [19:0] u_fan_cmd_bytes;
    logic [19:0] u_fan_cmd_sstride;
    logic [19:0] u_fan_cmd_dstride;
    logic u_fan_ch_1_cmd_valid;
    logic u_fan_ch_1_idle;
    logic u_fan_ch_1_rel;
    logic u_fan_ch_2_cmd_valid;
    logic u_fan_ch_2_idle;
    logic u_fan_ch_2_rel;
    logic u_fan_ch_3_cmd_valid;
    logic u_fan_ch_3_idle;
    logic u_fan_ch_3_rel;
    logic u_seq_launch_ready;
    logic [31:0] u_ch_0_dbg_count;
    logic [8:0] u_ch_0_dbg_fifo_occ;
    logic [31:0] u_ch_1_dbg_count;
    logic [8:0] u_ch_1_dbg_fifo_occ;
    logic [31:0] u_ch_2_dbg_count;
    logic [8:0] u_ch_2_dbg_fifo_occ;
    logic [31:0] u_ch_3_dbg_count;
    logic [8:0] u_ch_3_dbg_fifo_occ;
    logic u_ch_0_rdq_n2;
    logic u_ch_0_rdq_n1;
    logic u_ch_0_wrq_n2;
    logic u_ch_0_wrq_n1;
    logic u_ch_0_wrq_push;
    logic u_ch_0_rdq_l1;
    logic u_ch_0_wrq_l1;
    logic u_ch_1_rdq_n2;
    logic u_ch_1_rdq_n1;
    logic u_ch_1_wrq_n2;
    logic u_ch_1_wrq_n1;
    logic u_ch_1_wrq_push;
    logic u_ch_1_rdq_l1;
    logic u_ch_1_wrq_l1;
    logic u_ch_2_rdq_n2;
    logic u_ch_2_rdq_n1;
    logic u_ch_2_wrq_n2;
    logic u_ch_2_wrq_n1;
    logic u_ch_2_wrq_push;
    logic u_ch_2_rdq_l1;
    logic u_ch_2_wrq_l1;
    logic u_ch_3_rdq_n2;
    logic u_ch_3_rdq_n1;
    logic u_ch_3_wrq_n2;
    logic u_ch_3_wrq_n1;
    logic u_ch_3_wrq_push;
    logic u_ch_3_rdq_l1;
    logic u_ch_3_wrq_l1;
    logic [31:0] u_ch_0_rdq_x_addr;
    logic [31:0] u_ch_0_rdq_h_addr;
    logic [31:0] u_ch_1_rdq_x_addr;
    logic [31:0] u_ch_1_rdq_h_addr;
    logic [31:0] u_ch_2_rdq_x_addr;
    logic [31:0] u_ch_2_rdq_h_addr;
    logic [31:0] u_ch_3_rdq_x_addr;
    logic [31:0] u_ch_3_rdq_h_addr;
    logic [7:0] u_ch_0_rdq_cid;
    logic [7:0] u_ch_1_rdq_cid;
    logic [7:0] u_ch_2_rdq_cid;
    logic [7:0] u_ch_3_rdq_cid;
    logic [19:0] u_ch_0_rdq_x_bytes;
    logic [19:0] u_ch_0_rdq_h_bytes;
    logic [19:0] u_ch_1_rdq_x_bytes;
    logic [19:0] u_ch_1_rdq_h_bytes;
    logic [19:0] u_ch_2_rdq_x_bytes;
    logic [19:0] u_ch_2_rdq_h_bytes;
    logic [19:0] u_ch_3_rdq_x_bytes;
    logic [19:0] u_ch_3_rdq_h_bytes;
    logic u_ch_0_rdq_x_first;
    logic u_ch_0_rdq_h_first;
    logic u_ch_1_rdq_x_first;
    logic u_ch_1_rdq_h_first;
    logic u_ch_2_rdq_x_first;
    logic u_ch_2_rdq_h_first;
    logic u_ch_3_rdq_x_first;
    logic u_ch_3_rdq_h_first;
    logic u_ch_0_rdq_x_last;
    logic u_ch_0_rdq_h_last;
    logic u_ch_1_rdq_x_last;
    logic u_ch_1_rdq_h_last;
    logic u_ch_2_rdq_x_last;
    logic u_ch_2_rdq_h_last;
    logic u_ch_3_rdq_x_last;
    logic u_ch_3_rdq_h_last;
    logic [31:0] u_ch_0_wrq_i_addr;
    logic [31:0] u_ch_0_wrq_x_addr;
    logic [31:0] u_ch_0_wrq_h_addr;
    logic [31:0] u_ch_1_wrq_i_addr;
    logic [31:0] u_ch_1_wrq_x_addr;
    logic [31:0] u_ch_1_wrq_h_addr;
    logic [31:0] u_ch_2_wrq_i_addr;
    logic [31:0] u_ch_2_wrq_x_addr;
    logic [31:0] u_ch_2_wrq_h_addr;
    logic [31:0] u_ch_3_wrq_i_addr;
    logic [31:0] u_ch_3_wrq_x_addr;
    logic [31:0] u_ch_3_wrq_h_addr;
    logic [7:0] u_ch_0_wrq_cid;
    logic [7:0] u_ch_1_wrq_cid;
    logic [7:0] u_ch_2_wrq_cid;
    logic [7:0] u_ch_3_wrq_cid;
    logic [19:0] u_ch_0_wrq_i_bytes;
    logic [19:0] u_ch_0_wrq_x_bytes;
    logic [19:0] u_ch_0_wrq_h_bytes;
    logic [19:0] u_ch_1_wrq_i_bytes;
    logic [19:0] u_ch_1_wrq_x_bytes;
    logic [19:0] u_ch_1_wrq_h_bytes;
    logic [19:0] u_ch_2_wrq_i_bytes;
    logic [19:0] u_ch_2_wrq_x_bytes;
    logic [19:0] u_ch_2_wrq_h_bytes;
    logic [19:0] u_ch_3_wrq_i_bytes;
    logic [19:0] u_ch_3_wrq_x_bytes;
    logic [19:0] u_ch_3_wrq_h_bytes;
    logic u_ch_0_wrq_i_first;
    logic u_ch_0_wrq_x_first;
    logic u_ch_0_wrq_h_first;
    logic u_ch_1_wrq_i_first;
    logic u_ch_1_wrq_x_first;
    logic u_ch_1_wrq_h_first;
    logic u_ch_2_wrq_i_first;
    logic u_ch_2_wrq_x_first;
    logic u_ch_2_wrq_h_first;
    logic u_ch_3_wrq_i_first;
    logic u_ch_3_wrq_x_first;
    logic u_ch_3_wrq_h_first;
    logic u_ch_0_wrq_i_last;
    logic u_ch_0_wrq_x_last;
    logic u_ch_0_wrq_h_last;
    logic u_ch_1_wrq_i_last;
    logic u_ch_1_wrq_x_last;
    logic u_ch_1_wrq_h_last;
    logic u_ch_2_wrq_i_last;
    logic u_ch_2_wrq_x_last;
    logic u_ch_2_wrq_h_last;
    logic u_ch_3_wrq_i_last;
    logic u_ch_3_wrq_x_last;
    logic u_ch_3_wrq_h_last;
    logic u_ch_0_w_v2;
    logic u_ch_0_w_v1;
    logic u_ch_1_w_v2;
    logic u_ch_1_w_v1;
    logic u_ch_2_w_v2;
    logic u_ch_2_w_v1;
    logic u_ch_3_w_v2;
    logic u_ch_3_w_v1;
    logic u_ch_3_w_l1;
    logic u_ch_2_w_l1;
    logic u_ch_1_w_l1;
    logic u_ch_0_w_l1;
    logic [1023:0] u_ch_0_w_cur;
    logic [1023:0] u_ch_1_w_cur;
    logic [1023:0] u_ch_2_w_cur;
    logic [1023:0] u_ch_3_w_cur;
    logic [127:0] u_ch_0_w_stb;
    logic [127:0] u_ch_1_w_stb;
    logic [127:0] u_ch_2_w_stb;
    logic [127:0] u_ch_3_w_stb;
    logic u_seq_busy;
    logic u_fan_busy;
    logic [2:0] u_ch_3_dbg_state;
    logic [2:0] u_ch_2_dbg_state;
    logic [2:0] u_ch_1_dbg_state;
    logic [2:0] u_ch_0_dbg_state;
    logic [5:0] u_fan_dbg_win_n;
    logic [3:0] u_fan_dbg_sid_used;
    logic [2:0] u_fan_dbg_state;
    logic [31:0] l1ar_d_addr_c0;
    logic [31:0] l1ar_d_addr_c1;
    logic [31:0] l1ar_d_addr_c2;
    logic [19:0] l1ar_d_bytes_c0;
    logic [19:0] l1ar_d_bytes_c1;
    logic [19:0] l1ar_d_bytes_c2;
    logic l1ar_d_first_c0;
    logic l1ar_d_first_c1;
    logic l1ar_d_first_c2;
    logic l1ar_d_last_c0;
    logic l1ar_d_last_c1;
    logic l1ar_d_last_c2;
    logic [31:0] l1aw_d_addr_c0;
    logic [31:0] l1aw_d_addr_c1;
    logic [31:0] l1aw_d_addr_c2;
    logic [19:0] l1aw_d_bytes_c0;
    logic [19:0] l1aw_d_bytes_c1;
    logic [19:0] l1aw_d_bytes_c2;
    logic l1aw_d_first_c0;
    logic l1aw_d_first_c1;
    logic l1aw_d_first_c2;
    logic l1aw_d_last_c0;
    logic l1aw_d_last_c1;
    logic l1aw_d_last_c2;

    assign cm_addr = ctrl_s_cm_addr;
    assign cm_seg = ((cm_addr >= 336) & (cm_addr < 400));
    assign cm_off = (cm_addr[6:0] - 7'd80);
    assign cm_isram = ((cm_addr[31:16] == 512) & (cm_addr[15:14] == 0));
    assign cm_kid = (cm_seg & (cm_off == 2));
    assign cm_kparam = (cm_seg & (cm_off == 1));
    assign rd_ok = ((~cr_v) | ctrl_s_cr_ready);
    assign ctrl_s_cm_ready = (ctrl_s_cm_write ? (cm_kid ? seq_lready : 1'd1) : rd_ok);
    assign cm_fire = (ctrl_s_cm_valid & ctrl_s_cm_ready);
    assign ctrl_s_cr_valid = cr_v;
    assign ctrl_s_cr_data = cr_data_q;
    assign ctrl_s_cr_tag = cr_tag_q;
    assign seq_lready = u_seq_launch_ready;
    assign r_l1_0 = (l1_r_valid & (l1_r_id[1:0] == 0));
    assign r_v_0 = (r_l1_0 | (noc_r_valid & (noc_r_id[1:0] == 0)));
    assign r_last_0 = (r_l1_0 ? l1_r_last : noc_r_last);
    assign a_n_0 = ({1'd0, (l1_a_valid & (l1_a_id[1:0] == 0))} + {1'd0, (noc_a_valid & (noc_a_id[1:0] == 0))});
    assign b_n_0 = ({1'd0, (l1_b_valid & (l1_b_id[1:0] == 0))} + {1'd0, (noc_b_valid & (noc_b_id[1:0] == 0))});
    assign dbg_count_0 = u_ch_0_dbg_count;
    assign dbg_fifo_occ_0 = u_ch_0_dbg_fifo_occ;
    assign r_l1_1 = (l1_r_valid & (l1_r_id[1:0] == 1));
    assign r_v_1 = (r_l1_1 | (noc_r_valid & (noc_r_id[1:0] == 1)));
    assign r_last_1 = (r_l1_1 ? l1_r_last : noc_r_last);
    assign a_n_1 = ({1'd0, (l1_a_valid & (l1_a_id[1:0] == 1))} + {1'd0, (noc_a_valid & (noc_a_id[1:0] == 1))});
    assign b_n_1 = ({1'd0, (l1_b_valid & (l1_b_id[1:0] == 1))} + {1'd0, (noc_b_valid & (noc_b_id[1:0] == 1))});
    assign dbg_count_1 = u_ch_1_dbg_count;
    assign dbg_fifo_occ_1 = u_ch_1_dbg_fifo_occ;
    assign r_l1_2 = (l1_r_valid & (l1_r_id[1:0] == 2));
    assign r_v_2 = (r_l1_2 | (noc_r_valid & (noc_r_id[1:0] == 2)));
    assign r_last_2 = (r_l1_2 ? l1_r_last : noc_r_last);
    assign a_n_2 = ({1'd0, (l1_a_valid & (l1_a_id[1:0] == 2))} + {1'd0, (noc_a_valid & (noc_a_id[1:0] == 2))});
    assign b_n_2 = ({1'd0, (l1_b_valid & (l1_b_id[1:0] == 2))} + {1'd0, (noc_b_valid & (noc_b_id[1:0] == 2))});
    assign dbg_count_2 = u_ch_2_dbg_count;
    assign dbg_fifo_occ_2 = u_ch_2_dbg_fifo_occ;
    assign r_l1_3 = (l1_r_valid & (l1_r_id[1:0] == 3));
    assign r_v_3 = (r_l1_3 | (noc_r_valid & (noc_r_id[1:0] == 3)));
    assign r_last_3 = (r_l1_3 ? l1_r_last : noc_r_last);
    assign a_n_3 = ({1'd0, (l1_a_valid & (l1_a_id[1:0] == 3))} + {1'd0, (noc_a_valid & (noc_a_id[1:0] == 3))});
    assign b_n_3 = ({1'd0, (l1_b_valid & (l1_b_id[1:0] == 3))} + {1'd0, (noc_b_valid & (noc_b_id[1:0] == 3))});
    assign dbg_count_3 = u_ch_3_dbg_count;
    assign dbg_fifo_occ_3 = u_ch_3_dbg_fifo_occ;
    assign l1_r_ready = 1'd1;
    assign noc_r_ready = 1'd1;
    assign l1_b_ready = 1'd1;
    assign noc_b_ready = 1'd1;
    assign rd_av_0 = (rd_tk_0 ? u_ch_0_rdq_n2 : u_ch_0_rdq_n1);
    assign wr_av_0 = (wr_tk_0 ? (u_ch_0_wrq_n2 | (u_ch_0_wrq_n1 & u_ch_0_wrq_push)) : (u_ch_0_wrq_n1 | u_ch_0_wrq_push));
    assign l1rd_cand_0 = ((rd_av_0 & u_ch_0_rdq_l1) & cr_l1_nz_0);
    assign l1wr_cand_0 = ((wr_av_0 & u_ch_0_wrq_l1) & cr_l1_nz_0);
    assign nrd_cand_0 = ((rd_av_0 & (~u_ch_0_rdq_l1)) & cr_noc_nz);
    assign rd_av_1 = (rd_tk_1 ? u_ch_1_rdq_n2 : u_ch_1_rdq_n1);
    assign wr_av_1 = (wr_tk_1 ? (u_ch_1_wrq_n2 | (u_ch_1_wrq_n1 & u_ch_1_wrq_push)) : (u_ch_1_wrq_n1 | u_ch_1_wrq_push));
    assign l1rd_cand_1 = ((rd_av_1 & u_ch_1_rdq_l1) & cr_l1_nz_1);
    assign l1wr_cand_1 = ((wr_av_1 & u_ch_1_wrq_l1) & cr_l1_nz_1);
    assign nrd_cand_1 = ((rd_av_1 & (~u_ch_1_rdq_l1)) & cr_noc_nz);
    assign rd_av_2 = (rd_tk_2 ? u_ch_2_rdq_n2 : u_ch_2_rdq_n1);
    assign wr_av_2 = (wr_tk_2 ? (u_ch_2_wrq_n2 | (u_ch_2_wrq_n1 & u_ch_2_wrq_push)) : (u_ch_2_wrq_n1 | u_ch_2_wrq_push));
    assign l1rd_cand_2 = ((rd_av_2 & u_ch_2_rdq_l1) & cr_l1_nz_2);
    assign l1wr_cand_2 = ((wr_av_2 & u_ch_2_wrq_l1) & cr_l1_nz_2);
    assign nrd_cand_2 = ((rd_av_2 & (~u_ch_2_rdq_l1)) & cr_noc_nz);
    assign rd_av_3 = (rd_tk_3 ? u_ch_3_rdq_n2 : u_ch_3_rdq_n1);
    assign wr_av_3 = (wr_tk_3 ? (u_ch_3_wrq_n2 | (u_ch_3_wrq_n1 & u_ch_3_wrq_push)) : (u_ch_3_wrq_n1 | u_ch_3_wrq_push));
    assign l1rd_cand_3 = ((rd_av_3 & u_ch_3_rdq_l1) & cr_l1_nz_3);
    assign l1wr_cand_3 = ((wr_av_3 & u_ch_3_wrq_l1) & cr_l1_nz_3);
    assign nrd_cand_3 = ((rd_av_3 & (~u_ch_3_rdq_l1)) & cr_noc_nz);
    assign l1rd_c = {l1rd_cand_3, l1rd_cand_2, l1rd_cand_1, l1rd_cand_0};
    assign l1rd_idx = (({l1rd_rr, l1rd_c} == 0) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 1) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 2) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 3) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 4) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 5) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 6) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 7) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 8) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 9) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 10) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 11) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 12) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 13) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 14) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 15) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 16) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 17) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 18) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 19) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 20) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 21) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 22) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 23) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 24) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 25) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 26) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 27) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 28) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 29) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 30) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 31) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 32) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 33) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 34) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 35) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 36) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 37) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 38) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 39) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 40) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 41) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 42) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 43) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 44) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 45) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 46) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 47) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 48) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 49) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 50) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 51) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 52) ? 2'd2 :
                      (({l1rd_rr, l1rd_c} == 53) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 54) ? 2'd1 :
                      (({l1rd_rr, l1rd_c} == 55) ? 2'd0 :
                      (({l1rd_rr, l1rd_c} == 56) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 57) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 58) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 59) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 60) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 61) ? 2'd3 :
                      (({l1rd_rr, l1rd_c} == 62) ? 2'd3 :
                      2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign l1rd_oh = (({l1rd_rr, l1rd_c} == 0) ? 4'd0 :
                     (({l1rd_rr, l1rd_c} == 1) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 2) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 3) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 4) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 5) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 6) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 7) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 8) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 9) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 10) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 11) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 12) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 13) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 14) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 15) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 16) ? 4'd0 :
                     (({l1rd_rr, l1rd_c} == 17) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 18) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 19) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 20) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 21) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 22) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 23) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 24) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 25) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 26) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 27) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 28) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 29) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 30) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 31) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 32) ? 4'd0 :
                     (({l1rd_rr, l1rd_c} == 33) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 34) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 35) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 36) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 37) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 38) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 39) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 40) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 41) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 42) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 43) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 44) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 45) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 46) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 47) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 48) ? 4'd0 :
                     (({l1rd_rr, l1rd_c} == 49) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 50) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 51) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 52) ? 4'd4 :
                     (({l1rd_rr, l1rd_c} == 53) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 54) ? 4'd2 :
                     (({l1rd_rr, l1rd_c} == 55) ? 4'd1 :
                     (({l1rd_rr, l1rd_c} == 56) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 57) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 58) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 59) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 60) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 61) ? 4'd8 :
                     (({l1rd_rr, l1rd_c} == 62) ? 4'd8 :
                     4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign l1rd_v = (l1rd_c != 0);
    assign l1rd_fire = (l1rd_v & 1'd1);
    assign l1rd_g_0 = (l1rd_oh[0] & 1'd1);
    assign l1rd_g_1 = (l1rd_oh[1] & 1'd1);
    assign l1rd_g_2 = (l1rd_oh[2] & 1'd1);
    assign l1rd_g_3 = (l1rd_oh[3] & 1'd1);
    assign l1wr_c = {l1wr_cand_3, l1wr_cand_2, l1wr_cand_1, l1wr_cand_0};
    assign l1wr_idx = (({l1wr_rr, l1wr_c} == 0) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 1) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 2) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 3) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 4) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 5) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 6) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 7) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 8) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 9) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 10) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 11) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 12) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 13) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 14) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 15) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 16) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 17) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 18) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 19) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 20) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 21) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 22) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 23) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 24) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 25) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 26) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 27) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 28) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 29) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 30) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 31) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 32) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 33) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 34) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 35) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 36) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 37) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 38) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 39) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 40) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 41) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 42) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 43) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 44) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 45) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 46) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 47) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 48) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 49) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 50) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 51) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 52) ? 2'd2 :
                      (({l1wr_rr, l1wr_c} == 53) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 54) ? 2'd1 :
                      (({l1wr_rr, l1wr_c} == 55) ? 2'd0 :
                      (({l1wr_rr, l1wr_c} == 56) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 57) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 58) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 59) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 60) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 61) ? 2'd3 :
                      (({l1wr_rr, l1wr_c} == 62) ? 2'd3 :
                      2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign l1wr_oh = (({l1wr_rr, l1wr_c} == 0) ? 4'd0 :
                     (({l1wr_rr, l1wr_c} == 1) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 2) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 3) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 4) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 5) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 6) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 7) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 8) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 9) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 10) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 11) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 12) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 13) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 14) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 15) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 16) ? 4'd0 :
                     (({l1wr_rr, l1wr_c} == 17) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 18) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 19) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 20) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 21) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 22) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 23) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 24) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 25) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 26) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 27) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 28) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 29) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 30) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 31) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 32) ? 4'd0 :
                     (({l1wr_rr, l1wr_c} == 33) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 34) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 35) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 36) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 37) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 38) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 39) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 40) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 41) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 42) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 43) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 44) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 45) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 46) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 47) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 48) ? 4'd0 :
                     (({l1wr_rr, l1wr_c} == 49) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 50) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 51) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 52) ? 4'd4 :
                     (({l1wr_rr, l1wr_c} == 53) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 54) ? 4'd2 :
                     (({l1wr_rr, l1wr_c} == 55) ? 4'd1 :
                     (({l1wr_rr, l1wr_c} == 56) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 57) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 58) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 59) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 60) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 61) ? 4'd8 :
                     (({l1wr_rr, l1wr_c} == 62) ? 4'd8 :
                     4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign l1wr_v = (l1wr_c != 0);
    assign l1wr_fire = (l1wr_v & (~l1rd_v));
    assign l1wr_g_0 = (l1wr_oh[0] & (~l1rd_v));
    assign l1wr_g_1 = (l1wr_oh[1] & (~l1rd_v));
    assign l1wr_g_2 = (l1wr_oh[2] & (~l1rd_v));
    assign l1wr_g_3 = (l1wr_oh[3] & (~l1rd_v));
    assign nrd_c = {nrd_cand_3, nrd_cand_2, nrd_cand_1, nrd_cand_0};
    assign nrd_idx = (({nrd_rr, nrd_c} == 0) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 1) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 2) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 3) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 4) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 5) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 6) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 7) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 8) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 9) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 10) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 11) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 12) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 13) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 14) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 15) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 16) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 17) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 18) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 19) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 20) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 21) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 22) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 23) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 24) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 25) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 26) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 27) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 28) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 29) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 30) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 31) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 32) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 33) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 34) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 35) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 36) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 37) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 38) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 39) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 40) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 41) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 42) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 43) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 44) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 45) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 46) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 47) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 48) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 49) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 50) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 51) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 52) ? 2'd2 :
                     (({nrd_rr, nrd_c} == 53) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 54) ? 2'd1 :
                     (({nrd_rr, nrd_c} == 55) ? 2'd0 :
                     (({nrd_rr, nrd_c} == 56) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 57) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 58) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 59) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 60) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 61) ? 2'd3 :
                     (({nrd_rr, nrd_c} == 62) ? 2'd3 :
                     2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign nrd_oh = (({nrd_rr, nrd_c} == 0) ? 4'd0 :
                    (({nrd_rr, nrd_c} == 1) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 2) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 3) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 4) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 5) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 6) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 7) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 8) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 9) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 10) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 11) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 12) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 13) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 14) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 15) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 16) ? 4'd0 :
                    (({nrd_rr, nrd_c} == 17) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 18) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 19) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 20) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 21) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 22) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 23) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 24) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 25) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 26) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 27) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 28) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 29) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 30) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 31) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 32) ? 4'd0 :
                    (({nrd_rr, nrd_c} == 33) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 34) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 35) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 36) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 37) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 38) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 39) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 40) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 41) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 42) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 43) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 44) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 45) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 46) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 47) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 48) ? 4'd0 :
                    (({nrd_rr, nrd_c} == 49) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 50) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 51) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 52) ? 4'd4 :
                    (({nrd_rr, nrd_c} == 53) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 54) ? 4'd2 :
                    (({nrd_rr, nrd_c} == 55) ? 4'd1 :
                    (({nrd_rr, nrd_c} == 56) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 57) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 58) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 59) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 60) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 61) ? 4'd8 :
                    (({nrd_rr, nrd_c} == 62) ? 4'd8 :
                    4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign nrd_v = (nrd_c != 0);
    assign nrd_fire = (nrd_v & 1'd1);
    assign nrd_g_0 = (nrd_oh[0] & 1'd1);
    assign nrd_g_1 = (nrd_oh[1] & 1'd1);
    assign nrd_g_2 = (nrd_oh[2] & 1'd1);
    assign nrd_g_3 = (nrd_oh[3] & 1'd1);
    assign nwr_cred_ok = (cr_noc_ge2 | (~nrd_v));
    assign nwr_cand_0 = ((wr_av_0 & (~u_ch_0_wrq_l1)) & cr_noc_nz);
    assign nwr_cand_1 = ((wr_av_1 & (~u_ch_1_wrq_l1)) & cr_noc_nz);
    assign nwr_cand_2 = ((wr_av_2 & (~u_ch_2_wrq_l1)) & cr_noc_nz);
    assign nwr_cand_3 = ((wr_av_3 & (~u_ch_3_wrq_l1)) & cr_noc_nz);
    assign nwr_c = {nwr_cand_3, nwr_cand_2, nwr_cand_1, nwr_cand_0};
    assign nwr_idx = (({nwr_rr, nwr_c} == 0) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 1) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 2) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 3) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 4) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 5) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 6) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 7) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 8) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 9) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 10) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 11) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 12) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 13) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 14) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 15) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 16) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 17) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 18) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 19) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 20) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 21) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 22) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 23) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 24) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 25) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 26) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 27) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 28) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 29) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 30) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 31) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 32) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 33) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 34) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 35) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 36) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 37) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 38) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 39) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 40) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 41) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 42) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 43) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 44) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 45) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 46) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 47) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 48) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 49) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 50) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 51) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 52) ? 2'd2 :
                     (({nwr_rr, nwr_c} == 53) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 54) ? 2'd1 :
                     (({nwr_rr, nwr_c} == 55) ? 2'd0 :
                     (({nwr_rr, nwr_c} == 56) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 57) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 58) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 59) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 60) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 61) ? 2'd3 :
                     (({nwr_rr, nwr_c} == 62) ? 2'd3 :
                     2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign nwr_oh = (({nwr_rr, nwr_c} == 0) ? 4'd0 :
                    (({nwr_rr, nwr_c} == 1) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 2) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 3) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 4) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 5) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 6) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 7) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 8) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 9) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 10) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 11) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 12) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 13) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 14) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 15) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 16) ? 4'd0 :
                    (({nwr_rr, nwr_c} == 17) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 18) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 19) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 20) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 21) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 22) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 23) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 24) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 25) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 26) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 27) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 28) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 29) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 30) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 31) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 32) ? 4'd0 :
                    (({nwr_rr, nwr_c} == 33) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 34) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 35) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 36) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 37) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 38) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 39) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 40) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 41) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 42) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 43) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 44) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 45) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 46) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 47) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 48) ? 4'd0 :
                    (({nwr_rr, nwr_c} == 49) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 50) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 51) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 52) ? 4'd4 :
                    (({nwr_rr, nwr_c} == 53) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 54) ? 4'd2 :
                    (({nwr_rr, nwr_c} == 55) ? 4'd1 :
                    (({nwr_rr, nwr_c} == 56) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 57) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 58) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 59) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 60) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 61) ? 4'd8 :
                    (({nwr_rr, nwr_c} == 62) ? 4'd8 :
                    4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign nwr_v = (nwr_c != 0);
    assign nwr_fire = (nwr_v & nwr_cred_ok);
    assign nwr_g_0 = (nwr_oh[0] & nwr_cred_ok);
    assign nwr_g_1 = (nwr_oh[1] & nwr_cred_ok);
    assign nwr_g_2 = (nwr_oh[2] & nwr_cred_ok);
    assign nwr_g_3 = (nwr_oh[3] & nwr_cred_ok);
    assign cr_noc_n = (((cr_noc + {2'd0, noc_a_valid}) - {2'd0, nrd_fire}) - {2'd0, nwr_fire});
    assign cr_l1_n_0 = (((cr_l1_0 + {2'd0, (l1_a_valid & (l1_a_id[1:0] == 0))}) - {2'd0, l1rd_g_0}) - {2'd0, l1wr_g_0});
    assign cr_l1_n_1 = (((cr_l1_1 + {2'd0, (l1_a_valid & (l1_a_id[1:0] == 1))}) - {2'd0, l1rd_g_1}) - {2'd0, l1wr_g_1});
    assign cr_l1_n_2 = (((cr_l1_2 + {2'd0, (l1_a_valid & (l1_a_id[1:0] == 2))}) - {2'd0, l1rd_g_2}) - {2'd0, l1wr_g_2});
    assign cr_l1_n_3 = (((cr_l1_3 + {2'd0, (l1_a_valid & (l1_a_id[1:0] == 3))}) - {2'd0, l1rd_g_3}) - {2'd0, l1wr_g_3});
    assign l1ar_d_v = l1rd_fire;
    assign l1ar_d_idx = l1rd_idx;
    assign l1ar_d_addr_c0 = (rd_tk_0 ? u_ch_0_rdq_x_addr : u_ch_0_rdq_h_addr);
    assign l1ar_d_addr_c1 = (rd_tk_1 ? u_ch_1_rdq_x_addr : u_ch_1_rdq_h_addr);
    assign l1ar_d_addr_c2 = (rd_tk_2 ? u_ch_2_rdq_x_addr : u_ch_2_rdq_h_addr);
    assign l1ar_d_addr = ((l1rd_idx == 0) ? l1ar_d_addr_c0 :
                         ((l1rd_idx == 1) ? l1ar_d_addr_c1 :
                         ((l1rd_idx == 2) ? l1ar_d_addr_c2 :
                         (rd_tk_3 ? u_ch_3_rdq_x_addr :
                         u_ch_3_rdq_h_addr))));
    assign l1ar_d_cid = ((l1rd_idx == 0) ? u_ch_0_rdq_cid :
                        ((l1rd_idx == 1) ? u_ch_1_rdq_cid :
                        ((l1rd_idx == 2) ? u_ch_2_rdq_cid :
                        u_ch_3_rdq_cid)));
    assign l1ar_d_bytes_c0 = (rd_tk_0 ? u_ch_0_rdq_x_bytes : u_ch_0_rdq_h_bytes);
    assign l1ar_d_bytes_c1 = (rd_tk_1 ? u_ch_1_rdq_x_bytes : u_ch_1_rdq_h_bytes);
    assign l1ar_d_bytes_c2 = (rd_tk_2 ? u_ch_2_rdq_x_bytes : u_ch_2_rdq_h_bytes);
    assign l1ar_d_bytes = ((l1rd_idx == 0) ? l1ar_d_bytes_c0 :
                          ((l1rd_idx == 1) ? l1ar_d_bytes_c1 :
                          ((l1rd_idx == 2) ? l1ar_d_bytes_c2 :
                          (rd_tk_3 ? u_ch_3_rdq_x_bytes :
                          u_ch_3_rdq_h_bytes))));
    assign l1ar_d_first_c0 = (rd_tk_0 ? u_ch_0_rdq_x_first : u_ch_0_rdq_h_first);
    assign l1ar_d_first_c1 = (rd_tk_1 ? u_ch_1_rdq_x_first : u_ch_1_rdq_h_first);
    assign l1ar_d_first_c2 = (rd_tk_2 ? u_ch_2_rdq_x_first : u_ch_2_rdq_h_first);
    assign l1ar_d_first = ((l1rd_idx == 0) ? l1ar_d_first_c0 :
                          ((l1rd_idx == 1) ? l1ar_d_first_c1 :
                          ((l1rd_idx == 2) ? l1ar_d_first_c2 :
                          (rd_tk_3 ? u_ch_3_rdq_x_first :
                          u_ch_3_rdq_h_first))));
    assign l1ar_d_last_c0 = (rd_tk_0 ? u_ch_0_rdq_x_last : u_ch_0_rdq_h_last);
    assign l1ar_d_last_c1 = (rd_tk_1 ? u_ch_1_rdq_x_last : u_ch_1_rdq_h_last);
    assign l1ar_d_last_c2 = (rd_tk_2 ? u_ch_2_rdq_x_last : u_ch_2_rdq_h_last);
    assign l1ar_d_last = ((l1rd_idx == 0) ? l1ar_d_last_c0 :
                         ((l1rd_idx == 1) ? l1ar_d_last_c1 :
                         ((l1rd_idx == 2) ? l1ar_d_last_c2 :
                         (rd_tk_3 ? u_ch_3_rdq_x_last :
                         u_ch_3_rdq_h_last))));
    assign l1ar_d_tag = ((l1rd_idx == 0) ? u_ch_0_dbg_count[15:0] :
                        ((l1rd_idx == 1) ? u_ch_1_dbg_count[15:0] :
                        ((l1rd_idx == 2) ? u_ch_2_dbg_count[15:0] :
                        u_ch_3_dbg_count[15:0])));
    assign l1aw_d_v = l1wr_fire;
    assign l1aw_d_idx = l1wr_idx;
    assign l1aw_d_addr_c0 = ((wr_tk_0 ? (~u_ch_0_wrq_n2) : (~u_ch_0_wrq_n1)) ? u_ch_0_wrq_i_addr :
                            (wr_tk_0 ? u_ch_0_wrq_x_addr :
                            u_ch_0_wrq_h_addr));
    assign l1aw_d_addr_c1 = ((wr_tk_1 ? (~u_ch_1_wrq_n2) : (~u_ch_1_wrq_n1)) ? u_ch_1_wrq_i_addr :
                            (wr_tk_1 ? u_ch_1_wrq_x_addr :
                            u_ch_1_wrq_h_addr));
    assign l1aw_d_addr_c2 = ((wr_tk_2 ? (~u_ch_2_wrq_n2) : (~u_ch_2_wrq_n1)) ? u_ch_2_wrq_i_addr :
                            (wr_tk_2 ? u_ch_2_wrq_x_addr :
                            u_ch_2_wrq_h_addr));
    assign l1aw_d_addr = ((l1wr_idx == 0) ? l1aw_d_addr_c0 :
                         ((l1wr_idx == 1) ? l1aw_d_addr_c1 :
                         ((l1wr_idx == 2) ? l1aw_d_addr_c2 :
                         ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_addr :
                         (wr_tk_3 ? u_ch_3_wrq_x_addr :
                         u_ch_3_wrq_h_addr)))));
    assign l1aw_d_cid = ((l1wr_idx == 0) ? u_ch_0_wrq_cid :
                        ((l1wr_idx == 1) ? u_ch_1_wrq_cid :
                        ((l1wr_idx == 2) ? u_ch_2_wrq_cid :
                        u_ch_3_wrq_cid)));
    assign l1aw_d_bytes_c0 = ((wr_tk_0 ? (~u_ch_0_wrq_n2) : (~u_ch_0_wrq_n1)) ? u_ch_0_wrq_i_bytes :
                             (wr_tk_0 ? u_ch_0_wrq_x_bytes :
                             u_ch_0_wrq_h_bytes));
    assign l1aw_d_bytes_c1 = ((wr_tk_1 ? (~u_ch_1_wrq_n2) : (~u_ch_1_wrq_n1)) ? u_ch_1_wrq_i_bytes :
                             (wr_tk_1 ? u_ch_1_wrq_x_bytes :
                             u_ch_1_wrq_h_bytes));
    assign l1aw_d_bytes_c2 = ((wr_tk_2 ? (~u_ch_2_wrq_n2) : (~u_ch_2_wrq_n1)) ? u_ch_2_wrq_i_bytes :
                             (wr_tk_2 ? u_ch_2_wrq_x_bytes :
                             u_ch_2_wrq_h_bytes));
    assign l1aw_d_bytes = ((l1wr_idx == 0) ? l1aw_d_bytes_c0 :
                          ((l1wr_idx == 1) ? l1aw_d_bytes_c1 :
                          ((l1wr_idx == 2) ? l1aw_d_bytes_c2 :
                          ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_bytes :
                          (wr_tk_3 ? u_ch_3_wrq_x_bytes :
                          u_ch_3_wrq_h_bytes)))));
    assign l1aw_d_first_c0 = ((wr_tk_0 ? (~u_ch_0_wrq_n2) : (~u_ch_0_wrq_n1)) ? u_ch_0_wrq_i_first :
                             (wr_tk_0 ? u_ch_0_wrq_x_first :
                             u_ch_0_wrq_h_first));
    assign l1aw_d_first_c1 = ((wr_tk_1 ? (~u_ch_1_wrq_n2) : (~u_ch_1_wrq_n1)) ? u_ch_1_wrq_i_first :
                             (wr_tk_1 ? u_ch_1_wrq_x_first :
                             u_ch_1_wrq_h_first));
    assign l1aw_d_first_c2 = ((wr_tk_2 ? (~u_ch_2_wrq_n2) : (~u_ch_2_wrq_n1)) ? u_ch_2_wrq_i_first :
                             (wr_tk_2 ? u_ch_2_wrq_x_first :
                             u_ch_2_wrq_h_first));
    assign l1aw_d_first = ((l1wr_idx == 0) ? l1aw_d_first_c0 :
                          ((l1wr_idx == 1) ? l1aw_d_first_c1 :
                          ((l1wr_idx == 2) ? l1aw_d_first_c2 :
                          ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_first :
                          (wr_tk_3 ? u_ch_3_wrq_x_first :
                          u_ch_3_wrq_h_first)))));
    assign l1aw_d_last_c0 = ((wr_tk_0 ? (~u_ch_0_wrq_n2) : (~u_ch_0_wrq_n1)) ? u_ch_0_wrq_i_last :
                            (wr_tk_0 ? u_ch_0_wrq_x_last :
                            u_ch_0_wrq_h_last));
    assign l1aw_d_last_c1 = ((wr_tk_1 ? (~u_ch_1_wrq_n2) : (~u_ch_1_wrq_n1)) ? u_ch_1_wrq_i_last :
                            (wr_tk_1 ? u_ch_1_wrq_x_last :
                            u_ch_1_wrq_h_last));
    assign l1aw_d_last_c2 = ((wr_tk_2 ? (~u_ch_2_wrq_n2) : (~u_ch_2_wrq_n1)) ? u_ch_2_wrq_i_last :
                            (wr_tk_2 ? u_ch_2_wrq_x_last :
                            u_ch_2_wrq_h_last));
    assign l1aw_d_last = ((l1wr_idx == 0) ? l1aw_d_last_c0 :
                         ((l1wr_idx == 1) ? l1aw_d_last_c1 :
                         ((l1wr_idx == 2) ? l1aw_d_last_c2 :
                         ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_last :
                         (wr_tk_3 ? u_ch_3_wrq_x_last :
                         u_ch_3_wrq_h_last)))));
    assign l1aw_d_tag = ((l1wr_idx == 0) ? u_ch_0_dbg_count[15:0] :
                        ((l1wr_idx == 1) ? u_ch_1_dbg_count[15:0] :
                        ((l1wr_idx == 2) ? u_ch_2_dbg_count[15:0] :
                        u_ch_3_dbg_count[15:0])));
    assign nar_d_v = nrd_fire;
    assign nar_d_idx = nrd_idx;
    assign nar_d_addr = ((nrd_idx == 0) ? l1ar_d_addr_c0 :
                        ((nrd_idx == 1) ? l1ar_d_addr_c1 :
                        ((nrd_idx == 2) ? l1ar_d_addr_c2 :
                        (rd_tk_3 ? u_ch_3_rdq_x_addr :
                        u_ch_3_rdq_h_addr))));
    assign nar_d_cid = ((nrd_idx == 0) ? u_ch_0_rdq_cid :
                       ((nrd_idx == 1) ? u_ch_1_rdq_cid :
                       ((nrd_idx == 2) ? u_ch_2_rdq_cid :
                       u_ch_3_rdq_cid)));
    assign nar_d_bytes = ((nrd_idx == 0) ? l1ar_d_bytes_c0 :
                         ((nrd_idx == 1) ? l1ar_d_bytes_c1 :
                         ((nrd_idx == 2) ? l1ar_d_bytes_c2 :
                         (rd_tk_3 ? u_ch_3_rdq_x_bytes :
                         u_ch_3_rdq_h_bytes))));
    assign nar_d_first = ((nrd_idx == 0) ? l1ar_d_first_c0 :
                         ((nrd_idx == 1) ? l1ar_d_first_c1 :
                         ((nrd_idx == 2) ? l1ar_d_first_c2 :
                         (rd_tk_3 ? u_ch_3_rdq_x_first :
                         u_ch_3_rdq_h_first))));
    assign nar_d_last = ((nrd_idx == 0) ? l1ar_d_last_c0 :
                        ((nrd_idx == 1) ? l1ar_d_last_c1 :
                        ((nrd_idx == 2) ? l1ar_d_last_c2 :
                        (rd_tk_3 ? u_ch_3_rdq_x_last :
                        u_ch_3_rdq_h_last))));
    assign nar_d_tag = ((nrd_idx == 0) ? u_ch_0_dbg_count[15:0] :
                       ((nrd_idx == 1) ? u_ch_1_dbg_count[15:0] :
                       ((nrd_idx == 2) ? u_ch_2_dbg_count[15:0] :
                       u_ch_3_dbg_count[15:0])));
    assign naw_d_v = nwr_fire;
    assign naw_d_idx = nwr_idx;
    assign naw_d_addr = ((nwr_idx == 0) ? l1aw_d_addr_c0 :
                        ((nwr_idx == 1) ? l1aw_d_addr_c1 :
                        ((nwr_idx == 2) ? l1aw_d_addr_c2 :
                        ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_addr :
                        (wr_tk_3 ? u_ch_3_wrq_x_addr :
                        u_ch_3_wrq_h_addr)))));
    assign naw_d_cid = ((nwr_idx == 0) ? u_ch_0_wrq_cid :
                       ((nwr_idx == 1) ? u_ch_1_wrq_cid :
                       ((nwr_idx == 2) ? u_ch_2_wrq_cid :
                       u_ch_3_wrq_cid)));
    assign naw_d_bytes = ((nwr_idx == 0) ? l1aw_d_bytes_c0 :
                         ((nwr_idx == 1) ? l1aw_d_bytes_c1 :
                         ((nwr_idx == 2) ? l1aw_d_bytes_c2 :
                         ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_bytes :
                         (wr_tk_3 ? u_ch_3_wrq_x_bytes :
                         u_ch_3_wrq_h_bytes)))));
    assign naw_d_first = ((nwr_idx == 0) ? l1aw_d_first_c0 :
                         ((nwr_idx == 1) ? l1aw_d_first_c1 :
                         ((nwr_idx == 2) ? l1aw_d_first_c2 :
                         ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_first :
                         (wr_tk_3 ? u_ch_3_wrq_x_first :
                         u_ch_3_wrq_h_first)))));
    assign naw_d_last = ((nwr_idx == 0) ? l1aw_d_last_c0 :
                        ((nwr_idx == 1) ? l1aw_d_last_c1 :
                        ((nwr_idx == 2) ? l1aw_d_last_c2 :
                        ((wr_tk_3 ? (~u_ch_3_wrq_n2) : (~u_ch_3_wrq_n1)) ? u_ch_3_wrq_i_last :
                        (wr_tk_3 ? u_ch_3_wrq_x_last :
                        u_ch_3_wrq_h_last)))));
    assign naw_d_tag = ((nwr_idx == 0) ? u_ch_0_dbg_count[15:0] :
                       ((nwr_idx == 1) ? u_ch_1_dbg_count[15:0] :
                       ((nwr_idx == 2) ? u_ch_2_dbg_count[15:0] :
                       u_ch_3_dbg_count[15:0])));
    assign l1_ar_valid = l1ar_v;
    assign l1_ar_id = {2'd0, l1ar_idx};
    assign l1_ar_tag = l1ar_tag;
    assign l1_ar_cfg = l1ar_cid;
    assign l1_ar_off = l1ar_addr[19:0];
    assign l1_ar_bytes = l1ar_bytes;
    assign l1_ar_rows = 16'd1;
    assign l1_ar_stride = 20'd0;
    assign l1_ar_first = l1ar_first;
    assign l1_ar_last = l1ar_last;
    assign l1_aw_valid = l1aw_v;
    assign l1_aw_id = {2'd0, l1aw_idx};
    assign l1_aw_tag = l1aw_tag;
    assign l1_aw_cfg = l1aw_cid;
    assign l1_aw_off = l1aw_addr[19:0];
    assign l1_aw_bytes = l1aw_bytes;
    assign l1_aw_rows = 16'd1;
    assign l1_aw_stride = 20'd0;
    assign l1_aw_first = l1aw_first;
    assign l1_aw_last = l1aw_last;
    assign noc_ar_valid = nar_v;
    assign noc_ar_id = {2'd0, nar_idx};
    assign noc_ar_tag = nar_tag;
    assign noc_ar_addr = {16'd0, nar_addr};
    assign noc_ar_bytes = nar_bytes;
    assign noc_ar_rows = 16'd1;
    assign noc_ar_stride = 20'd0;
    assign noc_ar_first = nar_first;
    assign noc_ar_last = nar_last;
    assign noc_aw_valid = naw_v;
    assign noc_aw_id = {2'd0, naw_idx};
    assign noc_aw_tag = naw_tag;
    assign noc_aw_addr = {16'd0, naw_addr};
    assign noc_aw_bytes = naw_bytes;
    assign noc_aw_rows = 16'd1;
    assign noc_aw_stride = 20'd0;
    assign noc_aw_first = naw_first;
    assign noc_aw_last = naw_last;
    assign w_av_0 = (w_tk_0 ? u_ch_0_w_v2 : u_ch_0_w_v1);
    assign w_av_1 = (w_tk_1 ? u_ch_1_w_v2 : u_ch_1_w_v1);
    assign w_av_2 = (w_tk_2 ? u_ch_2_w_v2 : u_ch_2_w_v1);
    assign w_av_3 = (w_tk_3 ? u_ch_3_w_v2 : u_ch_3_w_v1);
    assign l1w_c = {((w_av_3 & u_ch_3_w_l1) & l1w_room_q[3]), ((w_av_2 & u_ch_2_w_l1) & l1w_room_q[2]),
                    ((w_av_1 & u_ch_1_w_l1) & l1w_room_q[1]), ((w_av_0 & u_ch_0_w_l1) & l1w_room_q[0])};
    assign l1w_idx = (({l1w_ptr, l1w_c} == 0) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 1) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 2) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 3) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 4) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 5) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 6) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 7) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 8) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 9) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 10) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 11) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 12) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 13) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 14) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 15) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 16) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 17) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 18) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 19) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 20) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 21) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 22) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 23) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 24) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 25) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 26) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 27) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 28) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 29) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 30) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 31) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 32) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 33) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 34) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 35) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 36) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 37) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 38) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 39) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 40) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 41) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 42) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 43) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 44) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 45) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 46) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 47) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 48) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 49) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 50) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 51) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 52) ? 2'd2 :
                     (({l1w_ptr, l1w_c} == 53) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 54) ? 2'd1 :
                     (({l1w_ptr, l1w_c} == 55) ? 2'd0 :
                     (({l1w_ptr, l1w_c} == 56) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 57) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 58) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 59) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 60) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 61) ? 2'd3 :
                     (({l1w_ptr, l1w_c} == 62) ? 2'd3 :
                     2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign l1w_oh = (({l1w_ptr, l1w_c} == 0) ? 4'd0 :
                    (({l1w_ptr, l1w_c} == 1) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 2) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 3) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 4) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 5) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 6) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 7) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 8) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 9) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 10) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 11) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 12) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 13) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 14) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 15) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 16) ? 4'd0 :
                    (({l1w_ptr, l1w_c} == 17) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 18) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 19) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 20) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 21) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 22) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 23) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 24) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 25) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 26) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 27) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 28) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 29) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 30) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 31) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 32) ? 4'd0 :
                    (({l1w_ptr, l1w_c} == 33) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 34) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 35) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 36) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 37) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 38) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 39) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 40) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 41) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 42) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 43) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 44) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 45) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 46) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 47) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 48) ? 4'd0 :
                    (({l1w_ptr, l1w_c} == 49) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 50) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 51) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 52) ? 4'd4 :
                    (({l1w_ptr, l1w_c} == 53) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 54) ? 4'd2 :
                    (({l1w_ptr, l1w_c} == 55) ? 4'd1 :
                    (({l1w_ptr, l1w_c} == 56) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 57) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 58) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 59) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 60) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 61) ? 4'd8 :
                    (({l1w_ptr, l1w_c} == 62) ? 4'd8 :
                    4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign l1w_v = (l1w_c != 0);
    assign l1w_dat_c = {((l1w_gs_31 == 0) ? u_ch_0_w_cur[1023:992] :
                        ((l1w_gs_31 == 1) ? u_ch_1_w_cur[1023:992] :
                        ((l1w_gs_31 == 2) ? u_ch_2_w_cur[1023:992] :
                        u_ch_3_w_cur[1023:992]))),
                        ((l1w_gs_30 == 0) ? u_ch_0_w_cur[991:960] :
                        ((l1w_gs_30 == 1) ? u_ch_1_w_cur[991:960] :
                        ((l1w_gs_30 == 2) ? u_ch_2_w_cur[991:960] :
                        u_ch_3_w_cur[991:960]))),
                        ((l1w_gs_29 == 0) ? u_ch_0_w_cur[959:928] :
                        ((l1w_gs_29 == 1) ? u_ch_1_w_cur[959:928] :
                        ((l1w_gs_29 == 2) ? u_ch_2_w_cur[959:928] :
                        u_ch_3_w_cur[959:928]))),
                        ((l1w_gs_28 == 0) ? u_ch_0_w_cur[927:896] :
                        ((l1w_gs_28 == 1) ? u_ch_1_w_cur[927:896] :
                        ((l1w_gs_28 == 2) ? u_ch_2_w_cur[927:896] :
                        u_ch_3_w_cur[927:896]))),
                        ((l1w_gs_27 == 0) ? u_ch_0_w_cur[895:864] :
                        ((l1w_gs_27 == 1) ? u_ch_1_w_cur[895:864] :
                        ((l1w_gs_27 == 2) ? u_ch_2_w_cur[895:864] :
                        u_ch_3_w_cur[895:864]))),
                        ((l1w_gs_26 == 0) ? u_ch_0_w_cur[863:832] :
                        ((l1w_gs_26 == 1) ? u_ch_1_w_cur[863:832] :
                        ((l1w_gs_26 == 2) ? u_ch_2_w_cur[863:832] :
                        u_ch_3_w_cur[863:832]))),
                        ((l1w_gs_25 == 0) ? u_ch_0_w_cur[831:800] :
                        ((l1w_gs_25 == 1) ? u_ch_1_w_cur[831:800] :
                        ((l1w_gs_25 == 2) ? u_ch_2_w_cur[831:800] :
                        u_ch_3_w_cur[831:800]))),
                        ((l1w_gs_24 == 0) ? u_ch_0_w_cur[799:768] :
                        ((l1w_gs_24 == 1) ? u_ch_1_w_cur[799:768] :
                        ((l1w_gs_24 == 2) ? u_ch_2_w_cur[799:768] :
                        u_ch_3_w_cur[799:768]))),
                        ((l1w_gs_23 == 0) ? u_ch_0_w_cur[767:736] :
                        ((l1w_gs_23 == 1) ? u_ch_1_w_cur[767:736] :
                        ((l1w_gs_23 == 2) ? u_ch_2_w_cur[767:736] :
                        u_ch_3_w_cur[767:736]))),
                        ((l1w_gs_22 == 0) ? u_ch_0_w_cur[735:704] :
                        ((l1w_gs_22 == 1) ? u_ch_1_w_cur[735:704] :
                        ((l1w_gs_22 == 2) ? u_ch_2_w_cur[735:704] :
                        u_ch_3_w_cur[735:704]))),
                        ((l1w_gs_21 == 0) ? u_ch_0_w_cur[703:672] :
                        ((l1w_gs_21 == 1) ? u_ch_1_w_cur[703:672] :
                        ((l1w_gs_21 == 2) ? u_ch_2_w_cur[703:672] :
                        u_ch_3_w_cur[703:672]))),
                        ((l1w_gs_20 == 0) ? u_ch_0_w_cur[671:640] :
                        ((l1w_gs_20 == 1) ? u_ch_1_w_cur[671:640] :
                        ((l1w_gs_20 == 2) ? u_ch_2_w_cur[671:640] :
                        u_ch_3_w_cur[671:640]))),
                        ((l1w_gs_19 == 0) ? u_ch_0_w_cur[639:608] :
                        ((l1w_gs_19 == 1) ? u_ch_1_w_cur[639:608] :
                        ((l1w_gs_19 == 2) ? u_ch_2_w_cur[639:608] :
                        u_ch_3_w_cur[639:608]))),
                        ((l1w_gs_18 == 0) ? u_ch_0_w_cur[607:576] :
                        ((l1w_gs_18 == 1) ? u_ch_1_w_cur[607:576] :
                        ((l1w_gs_18 == 2) ? u_ch_2_w_cur[607:576] :
                        u_ch_3_w_cur[607:576]))),
                        ((l1w_gs_17 == 0) ? u_ch_0_w_cur[575:544] :
                        ((l1w_gs_17 == 1) ? u_ch_1_w_cur[575:544] :
                        ((l1w_gs_17 == 2) ? u_ch_2_w_cur[575:544] :
                        u_ch_3_w_cur[575:544]))),
                        ((l1w_gs_16 == 0) ? u_ch_0_w_cur[543:512] :
                        ((l1w_gs_16 == 1) ? u_ch_1_w_cur[543:512] :
                        ((l1w_gs_16 == 2) ? u_ch_2_w_cur[543:512] :
                        u_ch_3_w_cur[543:512]))),
                        ((l1w_gs_15 == 0) ? u_ch_0_w_cur[511:480] :
                        ((l1w_gs_15 == 1) ? u_ch_1_w_cur[511:480] :
                        ((l1w_gs_15 == 2) ? u_ch_2_w_cur[511:480] :
                        u_ch_3_w_cur[511:480]))),
                        ((l1w_gs_14 == 0) ? u_ch_0_w_cur[479:448] :
                        ((l1w_gs_14 == 1) ? u_ch_1_w_cur[479:448] :
                        ((l1w_gs_14 == 2) ? u_ch_2_w_cur[479:448] :
                        u_ch_3_w_cur[479:448]))),
                        ((l1w_gs_13 == 0) ? u_ch_0_w_cur[447:416] :
                        ((l1w_gs_13 == 1) ? u_ch_1_w_cur[447:416] :
                        ((l1w_gs_13 == 2) ? u_ch_2_w_cur[447:416] :
                        u_ch_3_w_cur[447:416]))),
                        ((l1w_gs_12 == 0) ? u_ch_0_w_cur[415:384] :
                        ((l1w_gs_12 == 1) ? u_ch_1_w_cur[415:384] :
                        ((l1w_gs_12 == 2) ? u_ch_2_w_cur[415:384] :
                        u_ch_3_w_cur[415:384]))),
                        ((l1w_gs_11 == 0) ? u_ch_0_w_cur[383:352] :
                        ((l1w_gs_11 == 1) ? u_ch_1_w_cur[383:352] :
                        ((l1w_gs_11 == 2) ? u_ch_2_w_cur[383:352] :
                        u_ch_3_w_cur[383:352]))),
                        ((l1w_gs_10 == 0) ? u_ch_0_w_cur[351:320] :
                        ((l1w_gs_10 == 1) ? u_ch_1_w_cur[351:320] :
                        ((l1w_gs_10 == 2) ? u_ch_2_w_cur[351:320] :
                        u_ch_3_w_cur[351:320]))),
                        ((l1w_gs_9 == 0) ? u_ch_0_w_cur[319:288] :
                        ((l1w_gs_9 == 1) ? u_ch_1_w_cur[319:288] :
                        ((l1w_gs_9 == 2) ? u_ch_2_w_cur[319:288] :
                        u_ch_3_w_cur[319:288]))),
                        ((l1w_gs_8 == 0) ? u_ch_0_w_cur[287:256] :
                        ((l1w_gs_8 == 1) ? u_ch_1_w_cur[287:256] :
                        ((l1w_gs_8 == 2) ? u_ch_2_w_cur[287:256] :
                        u_ch_3_w_cur[287:256]))),
                        ((l1w_gs_7 == 0) ? u_ch_0_w_cur[255:224] :
                        ((l1w_gs_7 == 1) ? u_ch_1_w_cur[255:224] :
                        ((l1w_gs_7 == 2) ? u_ch_2_w_cur[255:224] :
                        u_ch_3_w_cur[255:224]))),
                        ((l1w_gs_6 == 0) ? u_ch_0_w_cur[223:192] :
                        ((l1w_gs_6 == 1) ? u_ch_1_w_cur[223:192] :
                        ((l1w_gs_6 == 2) ? u_ch_2_w_cur[223:192] :
                        u_ch_3_w_cur[223:192]))),
                        ((l1w_gs_5 == 0) ? u_ch_0_w_cur[191:160] :
                        ((l1w_gs_5 == 1) ? u_ch_1_w_cur[191:160] :
                        ((l1w_gs_5 == 2) ? u_ch_2_w_cur[191:160] :
                        u_ch_3_w_cur[191:160]))),
                        ((l1w_gs_4 == 0) ? u_ch_0_w_cur[159:128] :
                        ((l1w_gs_4 == 1) ? u_ch_1_w_cur[159:128] :
                        ((l1w_gs_4 == 2) ? u_ch_2_w_cur[159:128] :
                        u_ch_3_w_cur[159:128]))),
                        ((l1w_gs_3 == 0) ? u_ch_0_w_cur[127:96] :
                        ((l1w_gs_3 == 1) ? u_ch_1_w_cur[127:96] :
                        ((l1w_gs_3 == 2) ? u_ch_2_w_cur[127:96] :
                        u_ch_3_w_cur[127:96]))),
                        ((l1w_gs_2 == 0) ? u_ch_0_w_cur[95:64] :
                        ((l1w_gs_2 == 1) ? u_ch_1_w_cur[95:64] :
                        ((l1w_gs_2 == 2) ? u_ch_2_w_cur[95:64] :
                        u_ch_3_w_cur[95:64]))),
                        ((l1w_gs_1 == 0) ? u_ch_0_w_cur[63:32] :
                        ((l1w_gs_1 == 1) ? u_ch_1_w_cur[63:32] :
                        ((l1w_gs_1 == 2) ? u_ch_2_w_cur[63:32] :
                        u_ch_3_w_cur[63:32]))),
                        ((l1w_gs_0 == 0) ? u_ch_0_w_cur[31:0] :
                        ((l1w_gs_0 == 1) ? u_ch_1_w_cur[31:0] :
                        ((l1w_gs_0 == 2) ? u_ch_2_w_cur[31:0] :
                        u_ch_3_w_cur[31:0])))};
    assign l1w_stb_c = {((l1w_gs_35 == 0) ? u_ch_0_w_stb[127:96] :
                        ((l1w_gs_35 == 1) ? u_ch_1_w_stb[127:96] :
                        ((l1w_gs_35 == 2) ? u_ch_2_w_stb[127:96] :
                        u_ch_3_w_stb[127:96]))),
                        ((l1w_gs_34 == 0) ? u_ch_0_w_stb[95:64] :
                        ((l1w_gs_34 == 1) ? u_ch_1_w_stb[95:64] :
                        ((l1w_gs_34 == 2) ? u_ch_2_w_stb[95:64] :
                        u_ch_3_w_stb[95:64]))),
                        ((l1w_gs_33 == 0) ? u_ch_0_w_stb[63:32] :
                        ((l1w_gs_33 == 1) ? u_ch_1_w_stb[63:32] :
                        ((l1w_gs_33 == 2) ? u_ch_2_w_stb[63:32] :
                        u_ch_3_w_stb[63:32]))),
                        ((l1w_gs_32 == 0) ? u_ch_0_w_stb[31:0] :
                        ((l1w_gs_32 == 1) ? u_ch_1_w_stb[31:0] :
                        ((l1w_gs_32 == 2) ? u_ch_2_w_stb[31:0] :
                        u_ch_3_w_stb[31:0])))};
    assign nocw_c = {((w_av_3 & (~u_ch_3_w_l1)) & nocw_room_q[3]), ((w_av_2 & (~u_ch_2_w_l1)) & nocw_room_q[2]),
                     ((w_av_1 & (~u_ch_1_w_l1)) & nocw_room_q[1]), ((w_av_0 & (~u_ch_0_w_l1)) & nocw_room_q[0])};
    assign nocw_idx = (({nocw_ptr, nocw_c} == 0) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 1) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 2) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 3) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 4) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 5) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 6) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 7) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 8) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 9) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 10) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 11) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 12) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 13) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 14) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 15) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 16) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 17) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 18) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 19) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 20) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 21) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 22) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 23) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 24) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 25) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 26) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 27) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 28) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 29) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 30) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 31) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 32) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 33) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 34) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 35) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 36) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 37) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 38) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 39) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 40) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 41) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 42) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 43) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 44) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 45) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 46) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 47) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 48) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 49) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 50) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 51) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 52) ? 2'd2 :
                      (({nocw_ptr, nocw_c} == 53) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 54) ? 2'd1 :
                      (({nocw_ptr, nocw_c} == 55) ? 2'd0 :
                      (({nocw_ptr, nocw_c} == 56) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 57) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 58) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 59) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 60) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 61) ? 2'd3 :
                      (({nocw_ptr, nocw_c} == 62) ? 2'd3 :
                      2'd3)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign nocw_oh = (({nocw_ptr, nocw_c} == 0) ? 4'd0 :
                     (({nocw_ptr, nocw_c} == 1) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 2) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 3) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 4) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 5) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 6) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 7) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 8) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 9) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 10) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 11) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 12) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 13) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 14) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 15) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 16) ? 4'd0 :
                     (({nocw_ptr, nocw_c} == 17) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 18) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 19) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 20) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 21) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 22) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 23) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 24) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 25) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 26) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 27) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 28) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 29) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 30) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 31) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 32) ? 4'd0 :
                     (({nocw_ptr, nocw_c} == 33) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 34) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 35) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 36) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 37) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 38) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 39) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 40) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 41) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 42) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 43) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 44) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 45) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 46) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 47) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 48) ? 4'd0 :
                     (({nocw_ptr, nocw_c} == 49) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 50) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 51) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 52) ? 4'd4 :
                     (({nocw_ptr, nocw_c} == 53) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 54) ? 4'd2 :
                     (({nocw_ptr, nocw_c} == 55) ? 4'd1 :
                     (({nocw_ptr, nocw_c} == 56) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 57) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 58) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 59) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 60) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 61) ? 4'd8 :
                     (({nocw_ptr, nocw_c} == 62) ? 4'd8 :
                     4'd8)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign nocw_v = (nocw_c != 0);
    assign nocw_dat_c = {((nocw_gs_31 == 0) ? u_ch_0_w_cur[1023:992] :
                         ((nocw_gs_31 == 1) ? u_ch_1_w_cur[1023:992] :
                         ((nocw_gs_31 == 2) ? u_ch_2_w_cur[1023:992] :
                         u_ch_3_w_cur[1023:992]))),
                         ((nocw_gs_30 == 0) ? u_ch_0_w_cur[991:960] :
                         ((nocw_gs_30 == 1) ? u_ch_1_w_cur[991:960] :
                         ((nocw_gs_30 == 2) ? u_ch_2_w_cur[991:960] :
                         u_ch_3_w_cur[991:960]))),
                         ((nocw_gs_29 == 0) ? u_ch_0_w_cur[959:928] :
                         ((nocw_gs_29 == 1) ? u_ch_1_w_cur[959:928] :
                         ((nocw_gs_29 == 2) ? u_ch_2_w_cur[959:928] :
                         u_ch_3_w_cur[959:928]))),
                         ((nocw_gs_28 == 0) ? u_ch_0_w_cur[927:896] :
                         ((nocw_gs_28 == 1) ? u_ch_1_w_cur[927:896] :
                         ((nocw_gs_28 == 2) ? u_ch_2_w_cur[927:896] :
                         u_ch_3_w_cur[927:896]))),
                         ((nocw_gs_27 == 0) ? u_ch_0_w_cur[895:864] :
                         ((nocw_gs_27 == 1) ? u_ch_1_w_cur[895:864] :
                         ((nocw_gs_27 == 2) ? u_ch_2_w_cur[895:864] :
                         u_ch_3_w_cur[895:864]))),
                         ((nocw_gs_26 == 0) ? u_ch_0_w_cur[863:832] :
                         ((nocw_gs_26 == 1) ? u_ch_1_w_cur[863:832] :
                         ((nocw_gs_26 == 2) ? u_ch_2_w_cur[863:832] :
                         u_ch_3_w_cur[863:832]))),
                         ((nocw_gs_25 == 0) ? u_ch_0_w_cur[831:800] :
                         ((nocw_gs_25 == 1) ? u_ch_1_w_cur[831:800] :
                         ((nocw_gs_25 == 2) ? u_ch_2_w_cur[831:800] :
                         u_ch_3_w_cur[831:800]))),
                         ((nocw_gs_24 == 0) ? u_ch_0_w_cur[799:768] :
                         ((nocw_gs_24 == 1) ? u_ch_1_w_cur[799:768] :
                         ((nocw_gs_24 == 2) ? u_ch_2_w_cur[799:768] :
                         u_ch_3_w_cur[799:768]))),
                         ((nocw_gs_23 == 0) ? u_ch_0_w_cur[767:736] :
                         ((nocw_gs_23 == 1) ? u_ch_1_w_cur[767:736] :
                         ((nocw_gs_23 == 2) ? u_ch_2_w_cur[767:736] :
                         u_ch_3_w_cur[767:736]))),
                         ((nocw_gs_22 == 0) ? u_ch_0_w_cur[735:704] :
                         ((nocw_gs_22 == 1) ? u_ch_1_w_cur[735:704] :
                         ((nocw_gs_22 == 2) ? u_ch_2_w_cur[735:704] :
                         u_ch_3_w_cur[735:704]))),
                         ((nocw_gs_21 == 0) ? u_ch_0_w_cur[703:672] :
                         ((nocw_gs_21 == 1) ? u_ch_1_w_cur[703:672] :
                         ((nocw_gs_21 == 2) ? u_ch_2_w_cur[703:672] :
                         u_ch_3_w_cur[703:672]))),
                         ((nocw_gs_20 == 0) ? u_ch_0_w_cur[671:640] :
                         ((nocw_gs_20 == 1) ? u_ch_1_w_cur[671:640] :
                         ((nocw_gs_20 == 2) ? u_ch_2_w_cur[671:640] :
                         u_ch_3_w_cur[671:640]))),
                         ((nocw_gs_19 == 0) ? u_ch_0_w_cur[639:608] :
                         ((nocw_gs_19 == 1) ? u_ch_1_w_cur[639:608] :
                         ((nocw_gs_19 == 2) ? u_ch_2_w_cur[639:608] :
                         u_ch_3_w_cur[639:608]))),
                         ((nocw_gs_18 == 0) ? u_ch_0_w_cur[607:576] :
                         ((nocw_gs_18 == 1) ? u_ch_1_w_cur[607:576] :
                         ((nocw_gs_18 == 2) ? u_ch_2_w_cur[607:576] :
                         u_ch_3_w_cur[607:576]))),
                         ((nocw_gs_17 == 0) ? u_ch_0_w_cur[575:544] :
                         ((nocw_gs_17 == 1) ? u_ch_1_w_cur[575:544] :
                         ((nocw_gs_17 == 2) ? u_ch_2_w_cur[575:544] :
                         u_ch_3_w_cur[575:544]))),
                         ((nocw_gs_16 == 0) ? u_ch_0_w_cur[543:512] :
                         ((nocw_gs_16 == 1) ? u_ch_1_w_cur[543:512] :
                         ((nocw_gs_16 == 2) ? u_ch_2_w_cur[543:512] :
                         u_ch_3_w_cur[543:512]))),
                         ((nocw_gs_15 == 0) ? u_ch_0_w_cur[511:480] :
                         ((nocw_gs_15 == 1) ? u_ch_1_w_cur[511:480] :
                         ((nocw_gs_15 == 2) ? u_ch_2_w_cur[511:480] :
                         u_ch_3_w_cur[511:480]))),
                         ((nocw_gs_14 == 0) ? u_ch_0_w_cur[479:448] :
                         ((nocw_gs_14 == 1) ? u_ch_1_w_cur[479:448] :
                         ((nocw_gs_14 == 2) ? u_ch_2_w_cur[479:448] :
                         u_ch_3_w_cur[479:448]))),
                         ((nocw_gs_13 == 0) ? u_ch_0_w_cur[447:416] :
                         ((nocw_gs_13 == 1) ? u_ch_1_w_cur[447:416] :
                         ((nocw_gs_13 == 2) ? u_ch_2_w_cur[447:416] :
                         u_ch_3_w_cur[447:416]))),
                         ((nocw_gs_12 == 0) ? u_ch_0_w_cur[415:384] :
                         ((nocw_gs_12 == 1) ? u_ch_1_w_cur[415:384] :
                         ((nocw_gs_12 == 2) ? u_ch_2_w_cur[415:384] :
                         u_ch_3_w_cur[415:384]))),
                         ((nocw_gs_11 == 0) ? u_ch_0_w_cur[383:352] :
                         ((nocw_gs_11 == 1) ? u_ch_1_w_cur[383:352] :
                         ((nocw_gs_11 == 2) ? u_ch_2_w_cur[383:352] :
                         u_ch_3_w_cur[383:352]))),
                         ((nocw_gs_10 == 0) ? u_ch_0_w_cur[351:320] :
                         ((nocw_gs_10 == 1) ? u_ch_1_w_cur[351:320] :
                         ((nocw_gs_10 == 2) ? u_ch_2_w_cur[351:320] :
                         u_ch_3_w_cur[351:320]))),
                         ((nocw_gs_9 == 0) ? u_ch_0_w_cur[319:288] :
                         ((nocw_gs_9 == 1) ? u_ch_1_w_cur[319:288] :
                         ((nocw_gs_9 == 2) ? u_ch_2_w_cur[319:288] :
                         u_ch_3_w_cur[319:288]))),
                         ((nocw_gs_8 == 0) ? u_ch_0_w_cur[287:256] :
                         ((nocw_gs_8 == 1) ? u_ch_1_w_cur[287:256] :
                         ((nocw_gs_8 == 2) ? u_ch_2_w_cur[287:256] :
                         u_ch_3_w_cur[287:256]))),
                         ((nocw_gs_7 == 0) ? u_ch_0_w_cur[255:224] :
                         ((nocw_gs_7 == 1) ? u_ch_1_w_cur[255:224] :
                         ((nocw_gs_7 == 2) ? u_ch_2_w_cur[255:224] :
                         u_ch_3_w_cur[255:224]))),
                         ((nocw_gs_6 == 0) ? u_ch_0_w_cur[223:192] :
                         ((nocw_gs_6 == 1) ? u_ch_1_w_cur[223:192] :
                         ((nocw_gs_6 == 2) ? u_ch_2_w_cur[223:192] :
                         u_ch_3_w_cur[223:192]))),
                         ((nocw_gs_5 == 0) ? u_ch_0_w_cur[191:160] :
                         ((nocw_gs_5 == 1) ? u_ch_1_w_cur[191:160] :
                         ((nocw_gs_5 == 2) ? u_ch_2_w_cur[191:160] :
                         u_ch_3_w_cur[191:160]))),
                         ((nocw_gs_4 == 0) ? u_ch_0_w_cur[159:128] :
                         ((nocw_gs_4 == 1) ? u_ch_1_w_cur[159:128] :
                         ((nocw_gs_4 == 2) ? u_ch_2_w_cur[159:128] :
                         u_ch_3_w_cur[159:128]))),
                         ((nocw_gs_3 == 0) ? u_ch_0_w_cur[127:96] :
                         ((nocw_gs_3 == 1) ? u_ch_1_w_cur[127:96] :
                         ((nocw_gs_3 == 2) ? u_ch_2_w_cur[127:96] :
                         u_ch_3_w_cur[127:96]))),
                         ((nocw_gs_2 == 0) ? u_ch_0_w_cur[95:64] :
                         ((nocw_gs_2 == 1) ? u_ch_1_w_cur[95:64] :
                         ((nocw_gs_2 == 2) ? u_ch_2_w_cur[95:64] :
                         u_ch_3_w_cur[95:64]))),
                         ((nocw_gs_1 == 0) ? u_ch_0_w_cur[63:32] :
                         ((nocw_gs_1 == 1) ? u_ch_1_w_cur[63:32] :
                         ((nocw_gs_1 == 2) ? u_ch_2_w_cur[63:32] :
                         u_ch_3_w_cur[63:32]))),
                         ((nocw_gs_0 == 0) ? u_ch_0_w_cur[31:0] :
                         ((nocw_gs_0 == 1) ? u_ch_1_w_cur[31:0] :
                         ((nocw_gs_0 == 2) ? u_ch_2_w_cur[31:0] :
                         u_ch_3_w_cur[31:0])))};
    assign nocw_stb_c = {((nocw_gs_35 == 0) ? u_ch_0_w_stb[127:96] :
                         ((nocw_gs_35 == 1) ? u_ch_1_w_stb[127:96] :
                         ((nocw_gs_35 == 2) ? u_ch_2_w_stb[127:96] :
                         u_ch_3_w_stb[127:96]))),
                         ((nocw_gs_34 == 0) ? u_ch_0_w_stb[95:64] :
                         ((nocw_gs_34 == 1) ? u_ch_1_w_stb[95:64] :
                         ((nocw_gs_34 == 2) ? u_ch_2_w_stb[95:64] :
                         u_ch_3_w_stb[95:64]))),
                         ((nocw_gs_33 == 0) ? u_ch_0_w_stb[63:32] :
                         ((nocw_gs_33 == 1) ? u_ch_1_w_stb[63:32] :
                         ((nocw_gs_33 == 2) ? u_ch_2_w_stb[63:32] :
                         u_ch_3_w_stb[63:32]))),
                         ((nocw_gs_32 == 0) ? u_ch_0_w_stb[31:0] :
                         ((nocw_gs_32 == 1) ? u_ch_1_w_stb[31:0] :
                         ((nocw_gs_32 == 2) ? u_ch_2_w_stb[31:0] :
                         u_ch_3_w_stb[31:0])))};
    assign w_tk_n_0 = (l1w_oh[0] | nocw_oh[0]);
    assign w_tk_n_1 = (l1w_oh[1] | nocw_oh[1]);
    assign w_tk_n_2 = (l1w_oh[2] | nocw_oh[2]);
    assign w_tk_n_3 = (l1w_oh[3] | nocw_oh[3]);
    assign l1_w_valid = l1w_oq_v;
    assign l1_w_id = {2'd0, l1w_oq_wid};
    assign l1_w_data = l1w_oq_dat;
    assign l1_w_strb = l1w_oq_stb;
    assign noc_w_valid = nocw_oq_v;
    assign noc_w_id = {2'd0, nocw_oq_wid};
    assign noc_w_data = nocw_oq_dat;
    assign noc_w_strb = nocw_oq_stb;
    assign any_active = ({(~u_fan_ch_0_idle), (~u_fan_ch_1_idle), (~u_fan_ch_2_idle), (~u_fan_ch_3_idle)} != 0);
    assign busy = ((u_seq_busy | u_fan_busy) | any_active);
    assign dbg_busy = busy;
    assign dbg_ch_idle = {u_fan_ch_3_idle, u_fan_ch_2_idle, u_fan_ch_1_idle, u_fan_ch_0_idle};
    assign dbg_ch_state = {u_ch_3_dbg_state, u_ch_2_dbg_state, u_ch_1_dbg_state, u_ch_0_dbg_state};
    assign dbg_win_n = u_fan_dbg_win_n;
    assign dbg_sid_used = u_fan_dbg_sid_used;
    assign dbg_noc_credit = cr_noc;
    assign dbg_seq_state = u_fan_dbg_state;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            l1ar_v <= 0;
            l1ar_idx <= 0;
            l1ar_addr <= 0;
            l1ar_cid <= 0;
            l1ar_bytes <= 0;
            l1ar_first <= 0;
            l1ar_last <= 0;
            l1ar_tag <= 0;
            l1aw_v <= 0;
            l1aw_idx <= 0;
            l1aw_addr <= 0;
            l1aw_cid <= 0;
            l1aw_bytes <= 0;
            l1aw_first <= 0;
            l1aw_last <= 0;
            l1aw_tag <= 0;
            nar_v <= 0;
            nar_idx <= 0;
            nar_addr <= 0;
            nar_cid <= 0;
            nar_bytes <= 0;
            nar_first <= 0;
            nar_last <= 0;
            nar_tag <= 0;
            naw_v <= 0;
            naw_idx <= 0;
            naw_addr <= 0;
            naw_cid <= 0;
            naw_bytes <= 0;
            naw_first <= 0;
            naw_last <= 0;
            naw_tag <= 0;
            rq_drop <= 0;
            l1w_room_q <= 0;
            nocw_room_q <= 0;
            l1w_g_v <= 0;
            l1w_g_idx <= 0;
            l1w_gs_0 <= 0;
            l1w_gs_1 <= 0;
            l1w_gs_2 <= 0;
            l1w_gs_3 <= 0;
            l1w_gs_4 <= 0;
            l1w_gs_5 <= 0;
            l1w_gs_6 <= 0;
            l1w_gs_7 <= 0;
            l1w_gs_8 <= 0;
            l1w_gs_9 <= 0;
            l1w_gs_10 <= 0;
            l1w_gs_11 <= 0;
            l1w_gs_12 <= 0;
            l1w_gs_13 <= 0;
            l1w_gs_14 <= 0;
            l1w_gs_15 <= 0;
            l1w_gs_16 <= 0;
            l1w_gs_17 <= 0;
            l1w_gs_18 <= 0;
            l1w_gs_19 <= 0;
            l1w_gs_20 <= 0;
            l1w_gs_21 <= 0;
            l1w_gs_22 <= 0;
            l1w_gs_23 <= 0;
            l1w_gs_24 <= 0;
            l1w_gs_25 <= 0;
            l1w_gs_26 <= 0;
            l1w_gs_27 <= 0;
            l1w_gs_28 <= 0;
            l1w_gs_29 <= 0;
            l1w_gs_30 <= 0;
            l1w_gs_31 <= 0;
            l1w_gs_32 <= 0;
            l1w_gs_33 <= 0;
            l1w_gs_34 <= 0;
            l1w_gs_35 <= 0;
            nocw_g_v <= 0;
            nocw_g_idx <= 0;
            nocw_gs_0 <= 0;
            nocw_gs_1 <= 0;
            nocw_gs_2 <= 0;
            nocw_gs_3 <= 0;
            nocw_gs_4 <= 0;
            nocw_gs_5 <= 0;
            nocw_gs_6 <= 0;
            nocw_gs_7 <= 0;
            nocw_gs_8 <= 0;
            nocw_gs_9 <= 0;
            nocw_gs_10 <= 0;
            nocw_gs_11 <= 0;
            nocw_gs_12 <= 0;
            nocw_gs_13 <= 0;
            nocw_gs_14 <= 0;
            nocw_gs_15 <= 0;
            nocw_gs_16 <= 0;
            nocw_gs_17 <= 0;
            nocw_gs_18 <= 0;
            nocw_gs_19 <= 0;
            nocw_gs_20 <= 0;
            nocw_gs_21 <= 0;
            nocw_gs_22 <= 0;
            nocw_gs_23 <= 0;
            nocw_gs_24 <= 0;
            nocw_gs_25 <= 0;
            nocw_gs_26 <= 0;
            nocw_gs_27 <= 0;
            nocw_gs_28 <= 0;
            nocw_gs_29 <= 0;
            nocw_gs_30 <= 0;
            nocw_gs_31 <= 0;
            nocw_gs_32 <= 0;
            nocw_gs_33 <= 0;
            nocw_gs_34 <= 0;
            nocw_gs_35 <= 0;
            rd_tk_0 <= 0;
            wr_tk_0 <= 0;
            w_tk_0 <= 0;
            w_tkl_0_0 <= 0;
            w_tkl_0_1 <= 0;
            w_tkl_0_2 <= 0;
            w_tkl_0_3 <= 0;
            rd_tk_1 <= 0;
            wr_tk_1 <= 0;
            w_tk_1 <= 0;
            w_tkl_1_0 <= 0;
            w_tkl_1_1 <= 0;
            w_tkl_1_2 <= 0;
            w_tkl_1_3 <= 0;
            rd_tk_2 <= 0;
            wr_tk_2 <= 0;
            w_tk_2 <= 0;
            w_tkl_2_0 <= 0;
            w_tkl_2_1 <= 0;
            w_tkl_2_2 <= 0;
            w_tkl_2_3 <= 0;
            rd_tk_3 <= 0;
            wr_tk_3 <= 0;
            w_tk_3 <= 0;
            w_tkl_3_0 <= 0;
            w_tkl_3_1 <= 0;
            w_tkl_3_2 <= 0;
            w_tkl_3_3 <= 0;
            l1w_oq_v <= 0;
            l1w_oq_wid <= 0;
            l1w_oq_dat <= 0;
            l1w_oq_stb <= 0;
            nocw_oq_v <= 0;
            nocw_oq_wid <= 0;
            nocw_oq_dat <= 0;
            nocw_oq_stb <= 0;
            kparam <= 0;
            cr_v <= 0;
            cr_tag_q <= 0;
            cr_data_q <= 0;
            cr_noc <= 4;
            cr_noc_nz <= 1;
            cr_noc_ge2 <= 1;
            cr_l1_0 <= 4;
            cr_l1_nz_0 <= 1;
            cr_l1_1 <= 4;
            cr_l1_nz_1 <= 1;
            cr_l1_2 <= 4;
            cr_l1_nz_2 <= 1;
            cr_l1_3 <= 4;
            cr_l1_nz_3 <= 1;
            l1rd_rr <= 0;
            l1wr_rr <= 0;
            nrd_rr <= 0;
            nwr_rr <= 0;
            l1w_ptr <= 0;
            nocw_ptr <= 0;
        end else begin
            l1ar_v <= l1ar_d_v;
            l1ar_idx <= l1ar_d_idx;
            l1ar_addr <= l1ar_d_addr;
            l1ar_cid <= l1ar_d_cid;
            l1ar_bytes <= l1ar_d_bytes;
            l1ar_first <= l1ar_d_first;
            l1ar_last <= l1ar_d_last;
            l1ar_tag <= l1ar_d_tag;
            l1aw_v <= l1aw_d_v;
            l1aw_idx <= l1aw_d_idx;
            l1aw_addr <= l1aw_d_addr;
            l1aw_cid <= l1aw_d_cid;
            l1aw_bytes <= l1aw_d_bytes;
            l1aw_first <= l1aw_d_first;
            l1aw_last <= l1aw_d_last;
            l1aw_tag <= l1aw_d_tag;
            nar_v <= nar_d_v;
            nar_idx <= nar_d_idx;
            nar_addr <= nar_d_addr;
            nar_cid <= nar_d_cid;
            nar_bytes <= nar_d_bytes;
            nar_first <= nar_d_first;
            nar_last <= nar_d_last;
            nar_tag <= nar_d_tag;
            naw_v <= naw_d_v;
            naw_idx <= naw_d_idx;
            naw_addr <= naw_d_addr;
            naw_cid <= naw_d_cid;
            naw_bytes <= naw_d_bytes;
            naw_first <= naw_d_first;
            naw_last <= naw_d_last;
            naw_tag <= naw_d_tag;
            if (((((l1_ar_valid & (~l1_ar_ready)) | (l1_aw_valid & (~l1_aw_ready))) | (noc_ar_valid & (~noc_ar_ready)))
                 | (noc_aw_valid & (~noc_aw_ready)))) begin
                rq_drop <= 1;
            end
            l1w_room_q <= l1_wroom;
            nocw_room_q <= noc_wroom;
            l1w_g_v <= l1w_v;
            l1w_g_idx <= l1w_idx;
            l1w_gs_0 <= l1w_idx;
            l1w_gs_1 <= l1w_idx;
            l1w_gs_2 <= l1w_idx;
            l1w_gs_3 <= l1w_idx;
            l1w_gs_4 <= l1w_idx;
            l1w_gs_5 <= l1w_idx;
            l1w_gs_6 <= l1w_idx;
            l1w_gs_7 <= l1w_idx;
            l1w_gs_8 <= l1w_idx;
            l1w_gs_9 <= l1w_idx;
            l1w_gs_10 <= l1w_idx;
            l1w_gs_11 <= l1w_idx;
            l1w_gs_12 <= l1w_idx;
            l1w_gs_13 <= l1w_idx;
            l1w_gs_14 <= l1w_idx;
            l1w_gs_15 <= l1w_idx;
            l1w_gs_16 <= l1w_idx;
            l1w_gs_17 <= l1w_idx;
            l1w_gs_18 <= l1w_idx;
            l1w_gs_19 <= l1w_idx;
            l1w_gs_20 <= l1w_idx;
            l1w_gs_21 <= l1w_idx;
            l1w_gs_22 <= l1w_idx;
            l1w_gs_23 <= l1w_idx;
            l1w_gs_24 <= l1w_idx;
            l1w_gs_25 <= l1w_idx;
            l1w_gs_26 <= l1w_idx;
            l1w_gs_27 <= l1w_idx;
            l1w_gs_28 <= l1w_idx;
            l1w_gs_29 <= l1w_idx;
            l1w_gs_30 <= l1w_idx;
            l1w_gs_31 <= l1w_idx;
            l1w_gs_32 <= l1w_idx;
            l1w_gs_33 <= l1w_idx;
            l1w_gs_34 <= l1w_idx;
            l1w_gs_35 <= l1w_idx;
            nocw_g_v <= nocw_v;
            nocw_g_idx <= nocw_idx;
            nocw_gs_0 <= nocw_idx;
            nocw_gs_1 <= nocw_idx;
            nocw_gs_2 <= nocw_idx;
            nocw_gs_3 <= nocw_idx;
            nocw_gs_4 <= nocw_idx;
            nocw_gs_5 <= nocw_idx;
            nocw_gs_6 <= nocw_idx;
            nocw_gs_7 <= nocw_idx;
            nocw_gs_8 <= nocw_idx;
            nocw_gs_9 <= nocw_idx;
            nocw_gs_10 <= nocw_idx;
            nocw_gs_11 <= nocw_idx;
            nocw_gs_12 <= nocw_idx;
            nocw_gs_13 <= nocw_idx;
            nocw_gs_14 <= nocw_idx;
            nocw_gs_15 <= nocw_idx;
            nocw_gs_16 <= nocw_idx;
            nocw_gs_17 <= nocw_idx;
            nocw_gs_18 <= nocw_idx;
            nocw_gs_19 <= nocw_idx;
            nocw_gs_20 <= nocw_idx;
            nocw_gs_21 <= nocw_idx;
            nocw_gs_22 <= nocw_idx;
            nocw_gs_23 <= nocw_idx;
            nocw_gs_24 <= nocw_idx;
            nocw_gs_25 <= nocw_idx;
            nocw_gs_26 <= nocw_idx;
            nocw_gs_27 <= nocw_idx;
            nocw_gs_28 <= nocw_idx;
            nocw_gs_29 <= nocw_idx;
            nocw_gs_30 <= nocw_idx;
            nocw_gs_31 <= nocw_idx;
            nocw_gs_32 <= nocw_idx;
            nocw_gs_33 <= nocw_idx;
            nocw_gs_34 <= nocw_idx;
            nocw_gs_35 <= nocw_idx;
            rd_tk_0 <= (l1rd_g_0 | nrd_g_0);
            wr_tk_0 <= (l1wr_g_0 | nwr_g_0);
            w_tk_0 <= w_tk_n_0;
            w_tkl_0_0 <= w_tk_n_0;
            w_tkl_0_1 <= w_tk_n_0;
            w_tkl_0_2 <= w_tk_n_0;
            w_tkl_0_3 <= w_tk_n_0;
            rd_tk_1 <= (l1rd_g_1 | nrd_g_1);
            wr_tk_1 <= (l1wr_g_1 | nwr_g_1);
            w_tk_1 <= w_tk_n_1;
            w_tkl_1_0 <= w_tk_n_1;
            w_tkl_1_1 <= w_tk_n_1;
            w_tkl_1_2 <= w_tk_n_1;
            w_tkl_1_3 <= w_tk_n_1;
            rd_tk_2 <= (l1rd_g_2 | nrd_g_2);
            wr_tk_2 <= (l1wr_g_2 | nwr_g_2);
            w_tk_2 <= w_tk_n_2;
            w_tkl_2_0 <= w_tk_n_2;
            w_tkl_2_1 <= w_tk_n_2;
            w_tkl_2_2 <= w_tk_n_2;
            w_tkl_2_3 <= w_tk_n_2;
            rd_tk_3 <= (l1rd_g_3 | nrd_g_3);
            wr_tk_3 <= (l1wr_g_3 | nwr_g_3);
            w_tk_3 <= w_tk_n_3;
            w_tkl_3_0 <= w_tk_n_3;
            w_tkl_3_1 <= w_tk_n_3;
            w_tkl_3_2 <= w_tk_n_3;
            w_tkl_3_3 <= w_tk_n_3;
            l1w_oq_v <= l1w_g_v;
            l1w_oq_wid <= l1w_g_idx;
            l1w_oq_dat <= l1w_dat_c;
            l1w_oq_stb <= l1w_stb_c;
            nocw_oq_v <= nocw_g_v;
            nocw_oq_wid <= nocw_g_idx;
            nocw_oq_dat <= nocw_dat_c;
            nocw_oq_stb <= nocw_stb_c;
            if (((cm_fire & ctrl_s_cm_write) & cm_kparam)) begin
                kparam <= ctrl_s_cm_wdata;
            end
            if ((cr_v & ctrl_s_cr_ready)) begin
                cr_v <= 0;
            end
            if ((cm_fire & (~ctrl_s_cm_write))) begin
                cr_v <= 1;
                cr_tag_q <= ctrl_s_cm_tag;
                cr_data_q <= ((cm_seg & (cm_off == 33)) ? {31'd0, busy} : 32'd0);
            end
            cr_noc <= cr_noc_n;
            cr_noc_nz <= (cr_noc_n != 0);
            cr_noc_ge2 <= (cr_noc_n >= 2);
            cr_l1_0 <= cr_l1_n_0;
            cr_l1_nz_0 <= (cr_l1_n_0 != 0);
            cr_l1_1 <= cr_l1_n_1;
            cr_l1_nz_1 <= (cr_l1_n_1 != 0);
            cr_l1_2 <= cr_l1_n_2;
            cr_l1_nz_2 <= (cr_l1_n_2 != 0);
            cr_l1_3 <= cr_l1_n_3;
            cr_l1_nz_3 <= (cr_l1_n_3 != 0);
            if (l1rd_fire) begin
                l1rd_rr <= (l1rd_idx + 1);
            end
            if (l1wr_fire) begin
                l1wr_rr <= (l1wr_idx + 1);
            end
            if (nrd_fire) begin
                nrd_rr <= (nrd_idx + 1);
            end
            if (nwr_fire) begin
                nwr_rr <= (nwr_idx + 1);
            end
            if (l1w_v) begin
                l1w_ptr <= (l1w_idx + 1);
            end
            if (nocw_v) begin
                nocw_ptr <= (nocw_idx + 1);
            end
        end
    end

    DmaSeqW u_seq (
        .clk(clk),
        .rst_n(rst_n),
        .isram_we(((ctrl_s_cm_valid & ctrl_s_cm_write) & cm_isram)),
        .isram_waddr(cm_addr[13:2]),
        .isram_wdata(ctrl_s_cm_wdata),
        .launch_valid(((cm_fire & ctrl_s_cm_write) & cm_kid)),
        .launch_kid(ctrl_s_cm_wdata[15:0]),
        .launch_off({kparam[7:0], ctrl_s_cm_wdata[31:16]}),
        .launch_len(kparam[23:8]),
        .sc_smem(u_seq_sc_smem),
        .sc_scid(u_seq_sc_scid),
        .sc_saddr(u_seq_sc_saddr),
        .sc_dmem(u_seq_sc_dmem),
        .sc_dcid(u_seq_sc_dcid),
        .sc_daddr(u_seq_sc_daddr),
        .sc_rows(u_seq_sc_rows),
        .sc_bytes(u_seq_sc_bytes),
        .sc_sstride(u_seq_sc_sstride),
        .sc_dstride(u_seq_sc_dstride),
        .sc_valid(u_seq_sc_valid),
        .sc_ready(u_seq_sc_ready),
        .launch_ready(u_seq_launch_ready),
        .busy(u_seq_busy)
    );
    DmaFanout u_fan (
        .clk(clk),
        .rst_n(rst_n),
        .sc_smem(u_seq_sc_smem),
        .sc_scid(u_seq_sc_scid),
        .sc_saddr(u_seq_sc_saddr),
        .sc_dmem(u_seq_sc_dmem),
        .sc_dcid(u_seq_sc_dcid),
        .sc_daddr(u_seq_sc_daddr),
        .sc_rows(u_seq_sc_rows),
        .sc_bytes(u_seq_sc_bytes),
        .sc_sstride(u_seq_sc_sstride),
        .sc_dstride(u_seq_sc_dstride),
        .sc_valid(u_seq_sc_valid),
        .sc_ready(u_seq_sc_ready),
        .ch_0_cmd_valid(u_fan_ch_0_cmd_valid),
        .ch_0_idle(u_fan_ch_0_idle),
        .ch_0_rel(u_fan_ch_0_rel),
        .cmd_smem(u_fan_cmd_smem),
        .cmd_scid(u_fan_cmd_scid),
        .cmd_saddr(u_fan_cmd_saddr),
        .cmd_dmem(u_fan_cmd_dmem),
        .cmd_dcid(u_fan_cmd_dcid),
        .cmd_daddr(u_fan_cmd_daddr),
        .cmd_rows(u_fan_cmd_rows),
        .cmd_bytes(u_fan_cmd_bytes),
        .cmd_sstride(u_fan_cmd_sstride),
        .cmd_dstride(u_fan_cmd_dstride),
        .ch_1_cmd_valid(u_fan_ch_1_cmd_valid),
        .ch_1_idle(u_fan_ch_1_idle),
        .ch_1_rel(u_fan_ch_1_rel),
        .ch_2_cmd_valid(u_fan_ch_2_cmd_valid),
        .ch_2_idle(u_fan_ch_2_idle),
        .ch_2_rel(u_fan_ch_2_rel),
        .ch_3_cmd_valid(u_fan_ch_3_cmd_valid),
        .ch_3_idle(u_fan_ch_3_idle),
        .ch_3_rel(u_fan_ch_3_rel),
        .busy(u_fan_busy),
        .dbg_win_n(u_fan_dbg_win_n),
        .dbg_sid_used(u_fan_dbg_sid_used),
        .dbg_state(u_fan_dbg_state)
    );
    DmaChan u_ch_0 (
        .clk(clk),
        .rst_n(rst_n),
        .rd_take(rd_tk_0),
        .wr_take(wr_tk_0),
        .w_take(w_tk_0),
        .r_v(r_v_0),
        .r_last(r_last_0),
        .d_l1(l1_r_data),
        .d_noc(noc_r_data),
        .a_n(a_n_0),
        .b_n(b_n_0),
        .fan_cmd_valid(u_fan_ch_0_cmd_valid),
        .fan_idle(u_fan_ch_0_idle),
        .fan_rel(u_fan_ch_0_rel),
        .cmd_smem(u_fan_cmd_smem),
        .cmd_scid(u_fan_cmd_scid),
        .cmd_saddr(u_fan_cmd_saddr),
        .cmd_dmem(u_fan_cmd_dmem),
        .cmd_dcid(u_fan_cmd_dcid),
        .cmd_daddr(u_fan_cmd_daddr),
        .cmd_rows(u_fan_cmd_rows),
        .cmd_bytes(u_fan_cmd_bytes),
        .cmd_sstride(u_fan_cmd_sstride),
        .cmd_dstride(u_fan_cmd_dstride),
        .w_take_l_0(w_tkl_0_0),
        .w_take_l_1(w_tkl_0_1),
        .w_take_l_2(w_tkl_0_2),
        .w_take_l_3(w_tkl_0_3),
        .dbg_count(u_ch_0_dbg_count),
        .dbg_fifo_occ(u_ch_0_dbg_fifo_occ),
        .rdq_n2(u_ch_0_rdq_n2),
        .rdq_n1(u_ch_0_rdq_n1),
        .wrq_n2(u_ch_0_wrq_n2),
        .wrq_n1(u_ch_0_wrq_n1),
        .wrq_push(u_ch_0_wrq_push),
        .rdq_l1(u_ch_0_rdq_l1),
        .wrq_l1(u_ch_0_wrq_l1),
        .rdq_x_addr(u_ch_0_rdq_x_addr),
        .rdq_h_addr(u_ch_0_rdq_h_addr),
        .rdq_cid(u_ch_0_rdq_cid),
        .rdq_x_bytes(u_ch_0_rdq_x_bytes),
        .rdq_h_bytes(u_ch_0_rdq_h_bytes),
        .rdq_x_first(u_ch_0_rdq_x_first),
        .rdq_h_first(u_ch_0_rdq_h_first),
        .rdq_x_last(u_ch_0_rdq_x_last),
        .rdq_h_last(u_ch_0_rdq_h_last),
        .wrq_i_addr(u_ch_0_wrq_i_addr),
        .wrq_x_addr(u_ch_0_wrq_x_addr),
        .wrq_h_addr(u_ch_0_wrq_h_addr),
        .wrq_cid(u_ch_0_wrq_cid),
        .wrq_i_bytes(u_ch_0_wrq_i_bytes),
        .wrq_x_bytes(u_ch_0_wrq_x_bytes),
        .wrq_h_bytes(u_ch_0_wrq_h_bytes),
        .wrq_i_first(u_ch_0_wrq_i_first),
        .wrq_x_first(u_ch_0_wrq_x_first),
        .wrq_h_first(u_ch_0_wrq_h_first),
        .wrq_i_last(u_ch_0_wrq_i_last),
        .wrq_x_last(u_ch_0_wrq_x_last),
        .wrq_h_last(u_ch_0_wrq_h_last),
        .w_v2(u_ch_0_w_v2),
        .w_v1(u_ch_0_w_v1),
        .w_l1(u_ch_0_w_l1),
        .w_cur(u_ch_0_w_cur),
        .w_stb(u_ch_0_w_stb),
        .dbg_state(u_ch_0_dbg_state)
    );
    DmaChan u_ch_1 (
        .clk(clk),
        .rst_n(rst_n),
        .rd_take(rd_tk_1),
        .wr_take(wr_tk_1),
        .w_take(w_tk_1),
        .r_v(r_v_1),
        .r_last(r_last_1),
        .d_l1(l1_r_data),
        .d_noc(noc_r_data),
        .a_n(a_n_1),
        .b_n(b_n_1),
        .fan_cmd_valid(u_fan_ch_1_cmd_valid),
        .fan_idle(u_fan_ch_1_idle),
        .fan_rel(u_fan_ch_1_rel),
        .cmd_smem(u_fan_cmd_smem),
        .cmd_scid(u_fan_cmd_scid),
        .cmd_saddr(u_fan_cmd_saddr),
        .cmd_dmem(u_fan_cmd_dmem),
        .cmd_dcid(u_fan_cmd_dcid),
        .cmd_daddr(u_fan_cmd_daddr),
        .cmd_rows(u_fan_cmd_rows),
        .cmd_bytes(u_fan_cmd_bytes),
        .cmd_sstride(u_fan_cmd_sstride),
        .cmd_dstride(u_fan_cmd_dstride),
        .w_take_l_0(w_tkl_1_0),
        .w_take_l_1(w_tkl_1_1),
        .w_take_l_2(w_tkl_1_2),
        .w_take_l_3(w_tkl_1_3),
        .dbg_count(u_ch_1_dbg_count),
        .dbg_fifo_occ(u_ch_1_dbg_fifo_occ),
        .rdq_n2(u_ch_1_rdq_n2),
        .rdq_n1(u_ch_1_rdq_n1),
        .wrq_n2(u_ch_1_wrq_n2),
        .wrq_n1(u_ch_1_wrq_n1),
        .wrq_push(u_ch_1_wrq_push),
        .rdq_l1(u_ch_1_rdq_l1),
        .wrq_l1(u_ch_1_wrq_l1),
        .rdq_x_addr(u_ch_1_rdq_x_addr),
        .rdq_h_addr(u_ch_1_rdq_h_addr),
        .rdq_cid(u_ch_1_rdq_cid),
        .rdq_x_bytes(u_ch_1_rdq_x_bytes),
        .rdq_h_bytes(u_ch_1_rdq_h_bytes),
        .rdq_x_first(u_ch_1_rdq_x_first),
        .rdq_h_first(u_ch_1_rdq_h_first),
        .rdq_x_last(u_ch_1_rdq_x_last),
        .rdq_h_last(u_ch_1_rdq_h_last),
        .wrq_i_addr(u_ch_1_wrq_i_addr),
        .wrq_x_addr(u_ch_1_wrq_x_addr),
        .wrq_h_addr(u_ch_1_wrq_h_addr),
        .wrq_cid(u_ch_1_wrq_cid),
        .wrq_i_bytes(u_ch_1_wrq_i_bytes),
        .wrq_x_bytes(u_ch_1_wrq_x_bytes),
        .wrq_h_bytes(u_ch_1_wrq_h_bytes),
        .wrq_i_first(u_ch_1_wrq_i_first),
        .wrq_x_first(u_ch_1_wrq_x_first),
        .wrq_h_first(u_ch_1_wrq_h_first),
        .wrq_i_last(u_ch_1_wrq_i_last),
        .wrq_x_last(u_ch_1_wrq_x_last),
        .wrq_h_last(u_ch_1_wrq_h_last),
        .w_v2(u_ch_1_w_v2),
        .w_v1(u_ch_1_w_v1),
        .w_l1(u_ch_1_w_l1),
        .w_cur(u_ch_1_w_cur),
        .w_stb(u_ch_1_w_stb),
        .dbg_state(u_ch_1_dbg_state)
    );
    DmaChan u_ch_2 (
        .clk(clk),
        .rst_n(rst_n),
        .rd_take(rd_tk_2),
        .wr_take(wr_tk_2),
        .w_take(w_tk_2),
        .r_v(r_v_2),
        .r_last(r_last_2),
        .d_l1(l1_r_data),
        .d_noc(noc_r_data),
        .a_n(a_n_2),
        .b_n(b_n_2),
        .fan_cmd_valid(u_fan_ch_2_cmd_valid),
        .fan_idle(u_fan_ch_2_idle),
        .fan_rel(u_fan_ch_2_rel),
        .cmd_smem(u_fan_cmd_smem),
        .cmd_scid(u_fan_cmd_scid),
        .cmd_saddr(u_fan_cmd_saddr),
        .cmd_dmem(u_fan_cmd_dmem),
        .cmd_dcid(u_fan_cmd_dcid),
        .cmd_daddr(u_fan_cmd_daddr),
        .cmd_rows(u_fan_cmd_rows),
        .cmd_bytes(u_fan_cmd_bytes),
        .cmd_sstride(u_fan_cmd_sstride),
        .cmd_dstride(u_fan_cmd_dstride),
        .w_take_l_0(w_tkl_2_0),
        .w_take_l_1(w_tkl_2_1),
        .w_take_l_2(w_tkl_2_2),
        .w_take_l_3(w_tkl_2_3),
        .dbg_count(u_ch_2_dbg_count),
        .dbg_fifo_occ(u_ch_2_dbg_fifo_occ),
        .rdq_n2(u_ch_2_rdq_n2),
        .rdq_n1(u_ch_2_rdq_n1),
        .wrq_n2(u_ch_2_wrq_n2),
        .wrq_n1(u_ch_2_wrq_n1),
        .wrq_push(u_ch_2_wrq_push),
        .rdq_l1(u_ch_2_rdq_l1),
        .wrq_l1(u_ch_2_wrq_l1),
        .rdq_x_addr(u_ch_2_rdq_x_addr),
        .rdq_h_addr(u_ch_2_rdq_h_addr),
        .rdq_cid(u_ch_2_rdq_cid),
        .rdq_x_bytes(u_ch_2_rdq_x_bytes),
        .rdq_h_bytes(u_ch_2_rdq_h_bytes),
        .rdq_x_first(u_ch_2_rdq_x_first),
        .rdq_h_first(u_ch_2_rdq_h_first),
        .rdq_x_last(u_ch_2_rdq_x_last),
        .rdq_h_last(u_ch_2_rdq_h_last),
        .wrq_i_addr(u_ch_2_wrq_i_addr),
        .wrq_x_addr(u_ch_2_wrq_x_addr),
        .wrq_h_addr(u_ch_2_wrq_h_addr),
        .wrq_cid(u_ch_2_wrq_cid),
        .wrq_i_bytes(u_ch_2_wrq_i_bytes),
        .wrq_x_bytes(u_ch_2_wrq_x_bytes),
        .wrq_h_bytes(u_ch_2_wrq_h_bytes),
        .wrq_i_first(u_ch_2_wrq_i_first),
        .wrq_x_first(u_ch_2_wrq_x_first),
        .wrq_h_first(u_ch_2_wrq_h_first),
        .wrq_i_last(u_ch_2_wrq_i_last),
        .wrq_x_last(u_ch_2_wrq_x_last),
        .wrq_h_last(u_ch_2_wrq_h_last),
        .w_v2(u_ch_2_w_v2),
        .w_v1(u_ch_2_w_v1),
        .w_l1(u_ch_2_w_l1),
        .w_cur(u_ch_2_w_cur),
        .w_stb(u_ch_2_w_stb),
        .dbg_state(u_ch_2_dbg_state)
    );
    DmaChan u_ch_3 (
        .clk(clk),
        .rst_n(rst_n),
        .rd_take(rd_tk_3),
        .wr_take(wr_tk_3),
        .w_take(w_tk_3),
        .r_v(r_v_3),
        .r_last(r_last_3),
        .d_l1(l1_r_data),
        .d_noc(noc_r_data),
        .a_n(a_n_3),
        .b_n(b_n_3),
        .fan_cmd_valid(u_fan_ch_3_cmd_valid),
        .fan_idle(u_fan_ch_3_idle),
        .fan_rel(u_fan_ch_3_rel),
        .cmd_smem(u_fan_cmd_smem),
        .cmd_scid(u_fan_cmd_scid),
        .cmd_saddr(u_fan_cmd_saddr),
        .cmd_dmem(u_fan_cmd_dmem),
        .cmd_dcid(u_fan_cmd_dcid),
        .cmd_daddr(u_fan_cmd_daddr),
        .cmd_rows(u_fan_cmd_rows),
        .cmd_bytes(u_fan_cmd_bytes),
        .cmd_sstride(u_fan_cmd_sstride),
        .cmd_dstride(u_fan_cmd_dstride),
        .w_take_l_0(w_tkl_3_0),
        .w_take_l_1(w_tkl_3_1),
        .w_take_l_2(w_tkl_3_2),
        .w_take_l_3(w_tkl_3_3),
        .dbg_count(u_ch_3_dbg_count),
        .dbg_fifo_occ(u_ch_3_dbg_fifo_occ),
        .rdq_n2(u_ch_3_rdq_n2),
        .rdq_n1(u_ch_3_rdq_n1),
        .wrq_n2(u_ch_3_wrq_n2),
        .wrq_n1(u_ch_3_wrq_n1),
        .wrq_push(u_ch_3_wrq_push),
        .rdq_l1(u_ch_3_rdq_l1),
        .wrq_l1(u_ch_3_wrq_l1),
        .rdq_x_addr(u_ch_3_rdq_x_addr),
        .rdq_h_addr(u_ch_3_rdq_h_addr),
        .rdq_cid(u_ch_3_rdq_cid),
        .rdq_x_bytes(u_ch_3_rdq_x_bytes),
        .rdq_h_bytes(u_ch_3_rdq_h_bytes),
        .rdq_x_first(u_ch_3_rdq_x_first),
        .rdq_h_first(u_ch_3_rdq_h_first),
        .rdq_x_last(u_ch_3_rdq_x_last),
        .rdq_h_last(u_ch_3_rdq_h_last),
        .wrq_i_addr(u_ch_3_wrq_i_addr),
        .wrq_x_addr(u_ch_3_wrq_x_addr),
        .wrq_h_addr(u_ch_3_wrq_h_addr),
        .wrq_cid(u_ch_3_wrq_cid),
        .wrq_i_bytes(u_ch_3_wrq_i_bytes),
        .wrq_x_bytes(u_ch_3_wrq_x_bytes),
        .wrq_h_bytes(u_ch_3_wrq_h_bytes),
        .wrq_i_first(u_ch_3_wrq_i_first),
        .wrq_x_first(u_ch_3_wrq_x_first),
        .wrq_h_first(u_ch_3_wrq_h_first),
        .wrq_i_last(u_ch_3_wrq_i_last),
        .wrq_x_last(u_ch_3_wrq_x_last),
        .wrq_h_last(u_ch_3_wrq_h_last),
        .w_v2(u_ch_3_w_v2),
        .w_v1(u_ch_3_w_v1),
        .w_l1(u_ch_3_w_l1),
        .w_cur(u_ch_3_w_cur),
        .w_stb(u_ch_3_w_stb),
        .dbg_state(u_ch_3_dbg_state)
    );
endmodule
