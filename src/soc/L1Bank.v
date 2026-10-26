module L1Bank (
    input clk,
    input rst_n,
    output logic [1:0] dbg_grant,
    output logic [1:0] dbg_stall,
    input p_0_s_valid,
    output logic p_0_s_ready,
    input [19:0] p_0_s_addr,
    input [19:0] p_0_s_bytes,
    input p_0_s_dir,
    input [15:0] p_0_s_tag,
    input [2:0] p_0_s_q,
    input [3:0] p_0_s_mid,
    input p_0_s_last,
    input [7:0] p_0_s_cid,
    input p_0_s_cnt,
    input p_0_dsp_ok,
    output logic p_0_dsp,
    output logic [7:0] p_0_dsp_cid,
    output logic p_0_sdone,
    output logic p_0_sdone_dir,
    output logic p_0_sdone_w,
    output logic p_0_sdone_last,
    output logic [15:0] p_0_sdone_tag,
    output logic [3:0] p_0_sdone_mid,
    input p_1_s_valid,
    output logic p_1_s_ready,
    input [19:0] p_1_s_addr,
    input [19:0] p_1_s_bytes,
    input p_1_s_dir,
    input [15:0] p_1_s_tag,
    input [2:0] p_1_s_q,
    input [3:0] p_1_s_mid,
    input p_1_s_last,
    input [7:0] p_1_s_cid,
    input p_1_s_cnt,
    input p_1_dsp_ok,
    output logic p_1_dsp,
    output logic [7:0] p_1_dsp_cid,
    output logic p_1_sdone,
    output logic p_1_sdone_dir,
    output logic p_1_sdone_w,
    output logic p_1_sdone_last,
    output logic [15:0] p_1_sdone_tag,
    output logic [3:0] p_1_sdone_mid,
    input p_2_s_valid,
    output logic p_2_s_ready,
    input [19:0] p_2_s_addr,
    input [19:0] p_2_s_bytes,
    input p_2_s_dir,
    input [15:0] p_2_s_tag,
    input [2:0] p_2_s_q,
    input [3:0] p_2_s_mid,
    input p_2_s_last,
    input [7:0] p_2_s_cid,
    input p_2_s_cnt,
    input p_2_dsp_ok,
    output logic p_2_dsp,
    output logic [7:0] p_2_dsp_cid,
    output logic p_2_sdone,
    output logic p_2_sdone_dir,
    output logic p_2_sdone_w,
    output logic p_2_sdone_last,
    output logic [15:0] p_2_sdone_tag,
    output logic [3:0] p_2_sdone_mid,
    input w_0_valid,
    input [3:0] w_0_id,
    input [1023:0] w_0_data,
    input [127:0] w_0_strb,
    output logic [7:0] w_0_ready,
    input w_1_valid,
    input [3:0] w_1_id,
    input [511:0] w_1_data,
    input [63:0] w_1_strb,
    output logic [7:0] w_1_ready,
    input w_2_valid,
    input [3:0] w_2_id,
    input [511:0] w_2_data,
    input [63:0] w_2_strb,
    output logic [7:0] w_2_ready,
    output logic r_0_valid,
    input r_0_ready,
    output logic [1023:0] r_0_data,
    output logic [3:0] r_0_id,
    output logic [15:0] r_0_tag,
    output logic r_0_last,
    output logic r_1_valid,
    input r_1_ready,
    output logic [511:0] r_1_data,
    output logic [3:0] r_1_id,
    output logic [15:0] r_1_tag,
    output logic r_1_last,
    output logic r_2_valid,
    input r_2_ready,
    output logic [1023:0] r_2_data,
    output logic [3:0] r_2_id,
    output logic [15:0] r_2_tag,
    output logic r_2_last
);
    logic [13:0] st_word [0:5];
    logic [14:0] st_beats [0:5];
    logic st_dir [0:5];
    logic [15:0] st_tag [0:5];
    logic [2:0] st_q [0:5];
    logic [3:0] st_mid [0:5];
    logic st_last [0:5];
    logic [7:0] st_cid [0:5];
    logic st_cnt [0:5];
    logic st_one [0:5];
    logic st_wp_0;
    logic st_wp_1;
    logic st_wp_2;
    logic st_rp_0;
    logic st_rp_1;
    logic st_rp_2;
    logic [1:0] st_n_0;
    logic [1:0] st_n_1;
    logic [1:0] st_n_2;
    logic [13:0] cur_word [0:2];
    logic [14:0] cur_left [0:2];
    logic cur_one_0;
    logic cur_one_1;
    logic cur_one_2;
    logic cur_v_0;
    logic cur_v_1;
    logic cur_v_2;
    logic [1:0] rr_0;
    logic [1:0] rr_1;
    logic [1:0] rr_2;
    logic [1:0] rr_3;
    logic [1:0] dsp_rr;
    logic g1_v_0;
    logic g1_v_1;
    logic g1_v_2;
    logic g1_dir [0:2];
    logic [1:0] g1_bank [0:2];
    logic [15:0] g1_tag [0:2];
    logic [3:0] g1_mid [0:2];
    logic g1_lastb [0:2];
    logic g1_lasts [0:2];
    logic g1_dsp_0;
    logic g1_dsp_1;
    logic g1_dsp_2;
    logic [7:0] g1_cid [0:2];
    logic g1_half [0:2];
    logic g2_v_0;
    logic g2_v_1;
    logic g2_v_2;
    logic g3_v_0;
    logic g3_v_1;
    logic g3_v_2;
    logic g4_v_0;
    logic g4_v_1;
    logic g4_v_2;
    logic g5_v_0;
    logic g5_v_1;
    logic g5_v_2;
    logic g2_dir [0:2];
    logic [1:0] g2_bank [0:2];
    logic g2_half [0:2];
    logic [15:0] g2_tag [0:2];
    logic [3:0] g2_mid [0:2];
    logic g2_lastb [0:2];
    logic g2_lasts [0:2];
    logic g3_dir [0:2];
    logic [1:0] g3_bank [0:2];
    logic g3_half [0:2];
    logic [15:0] g3_tag [0:2];
    logic [3:0] g3_mid [0:2];
    logic g3_lastb [0:2];
    logic g3_lasts [0:2];
    logic g4_dir [0:2];
    logic [1:0] g4_bank [0:2];
    logic g4_half [0:2];
    logic [15:0] g4_tag [0:2];
    logic [3:0] g4_mid [0:2];
    logic g4_lastb [0:2];
    logic g4_lasts [0:2];
    logic g5_dir [0:2];
    logic [1:0] g5_bank [0:2];
    logic g5_half [0:2];
    logic [15:0] g5_tag [0:2];
    logic [3:0] g5_mid [0:2];
    logic g5_lastb [0:2];
    logic g5_lasts [0:2];
    logic g6_dir [0:2];
    logic [1:0] g6_bank [0:2];
    logic g6_half [0:2];
    logic [15:0] g6_tag [0:2];
    logic [3:0] g6_mid [0:2];
    logic g6_lastb [0:2];
    logic g6_lasts [0:2];
    logic g6_vr_0_0;
    logic g6_vr_0_1;
    logic g6_vr_0_2;
    logic g6_vr_0_3;
    logic g6_vr_0_4;
    logic g6_vr_0_5;
    logic g6_vr_0_6;
    logic g6_vr_0_7;
    logic g6_vr_0_8;
    logic g6_vr_0_9;
    logic g6_vr_0_10;
    logic g6_vr_0_11;
    logic g6_vr_0_12;
    logic g6_vr_0_13;
    logic g6_vr_0_14;
    logic g6_vr_0_15;
    logic g6_vr_1_0;
    logic g6_vr_1_1;
    logic g6_vr_1_2;
    logic g6_vr_1_3;
    logic g6_vr_1_4;
    logic g6_vr_1_5;
    logic g6_vr_1_6;
    logic g6_vr_1_7;
    logic g6_vr_1_8;
    logic g6_vr_1_9;
    logic g6_vr_1_10;
    logic g6_vr_1_11;
    logic g6_vr_1_12;
    logic g6_vr_1_13;
    logic g6_vr_1_14;
    logic g6_vr_1_15;
    logic g6_vr_2_0;
    logic g6_vr_2_1;
    logic g6_vr_2_2;
    logic g6_vr_2_3;
    logic g6_vr_2_4;
    logic g6_vr_2_5;
    logic g6_vr_2_6;
    logic g6_vr_2_7;
    logic g6_vr_2_8;
    logic g6_vr_2_9;
    logic g6_vr_2_10;
    logic g6_vr_2_11;
    logic g6_vr_2_12;
    logic g6_vr_2_13;
    logic g6_vr_2_14;
    logic g6_vr_2_15;
    logic [4:0] rq_occ_0;
    logic [4:0] rq_occ_1;
    logic [4:0] rq_occ_2;
    logic rd_v1_0;
    logic rd_v1_1;
    logic rd_v1_2;
    logic rd_v1_3;
    logic rd_v2_0;
    logic rd_v2_1;
    logic rd_v2_2;
    logic rd_v2_3;
    logic rd_v3_0;
    logic rd_v3_1;
    logic rd_v3_2;
    logic rd_v3_3;
    logic rd_v4_0;
    logic rd_v4_1;
    logic rd_v4_2;
    logic rd_v4_3;
    logic [8:0] rd_a1_0;
    logic [8:0] rd_a1_1;
    logic [8:0] rd_a1_2;
    logic [8:0] rd_a1_3;
    logic [8:0] rd_a2_0;
    logic [8:0] rd_a2_1;
    logic [8:0] rd_a2_2;
    logic [8:0] rd_a2_3;
    logic [8:0] rd_a3_0;
    logic [8:0] rd_a3_1;
    logic [8:0] rd_a3_2;
    logic [8:0] rd_a3_3;
    logic [8:0] rd_a4_0;
    logic [8:0] rd_a4_1;
    logic [8:0] rd_a4_2;
    logic [8:0] rd_a4_3;
    logic [1023:0] wd_q_0;
    logic [511:0] wd_q_1;
    logic [511:0] wd_q_2;
    logic [127:0] ws_q_0;
    logic [63:0] ws_q_1;
    logic [63:0] ws_q_2;
    logic [1023:0] wd_q2_0;
    logic [511:0] wd_q2_1;
    logic [511:0] wd_q2_2;
    logic [127:0] ws_q2_0;
    logic [63:0] ws_q2_1;
    logic [63:0] ws_q2_2;
    logic [1:0] dq_grant;
    logic [1:0] dq_stall;
    logic hd_one_l_0;
    logic hd_one_l_1;
    logic hd_one_l_2;
    logic hd_half_l_0;
    logic hd_half_l_1;
    logic hd_half_l_2;
    logic [7:0] ld_lw_l_0;
    logic [7:0] ld_lw_l_1;
    logic [7:0] ld_lw_l_2;
    logic [6:0] ld_ln_l_0;
    logic [6:0] ld_ln_l_1;
    logic [6:0] ld_ln_l_2;
    logic [13:0] ld_cw_l_0;
    logic [13:0] ld_cw_l_1;
    logic [13:0] ld_cw_l_2;
    logic [13:0] ld_cn_l_0;
    logic [13:0] ld_cn_l_1;
    logic [13:0] ld_cn_l_2;
    logic [14:0] ld_nbw_l_0;
    logic [14:0] ld_nbw_l_1;
    logic [14:0] ld_nbw_l_2;
    logic [14:0] ld_nbn_l_0;
    logic [14:0] ld_nbn_l_1;
    logic [14:0] ld_nbn_l_2;
    logic ld_onew_l_0;
    logic ld_onew_l_1;
    logic ld_onew_l_2;
    logic ld_onen_l_0;
    logic ld_onen_l_1;
    logic ld_onen_l_2;
    logic [14:0] ld_h1w_l_0;
    logic [14:0] ld_h1w_l_1;
    logic [14:0] ld_h1w_l_2;
    logic [14:0] ld_h2w_l_0;
    logic [14:0] ld_h2w_l_1;
    logic [14:0] ld_h2w_l_2;
    logic [14:0] ld_h1n_l_0;
    logic [14:0] ld_h1n_l_1;
    logic [14:0] ld_h1n_l_2;
    logic [14:0] ld_h2n_l_0;
    logic [14:0] ld_h2n_l_1;
    logic [14:0] ld_h2n_l_2;
    logic [13:0] ld_cell_l_0;
    logic [13:0] ld_cell_l_1;
    logic [13:0] ld_cell_l_2;
    logic [14:0] ld_nb_l_0;
    logic [14:0] ld_nb_l_1;
    logic [14:0] ld_nb_l_2;
    logic ld_one_l_0;
    logic ld_one_l_1;
    logic ld_one_l_2;
    logic [13:0] hd_step_l_0;
    logic [13:0] hd_step_l_1;
    logic [13:0] hd_step_l_2;
    logic [2:0] hd_idx_l_0;
    logic [2:0] hd_idx_l_1;
    logic [2:0] hd_idx_l_2;
    logic hd_v_l_0;
    logic hd_v_l_1;
    logic hd_v_l_2;
    logic hd_dir_l_0;
    logic hd_dir_l_1;
    logic hd_dir_l_2;
    logic [2:0] hd_q_l_0;
    logic [2:0] hd_q_l_1;
    logic [2:0] hd_q_l_2;
    logic [13:0] hd_word_l_0;
    logic [13:0] hd_word_l_1;
    logic [13:0] hd_word_l_2;
    logic [14:0] hd_left_l_0;
    logic [14:0] hd_left_l_1;
    logic [14:0] hd_left_l_2;
    logic [1:0] hd_bank_l_0;
    logic [1:0] hd_bank_l_1;
    logic [1:0] hd_bank_l_2;
    logic [8:0] hd_baddr_l_0;
    logic [8:0] hd_baddr_l_1;
    logic [8:0] hd_baddr_l_2;
    logic hd_cntf_l_0;
    logic hd_cntf_l_1;
    logic hd_cntf_l_2;
    logic [1023:0] rq_data_0;
    logic [511:0] rq_data_1;
    logic [1023:0] rq_data_2;
    logic rq_leave_0;
    logic rq_leave_1;
    logic rq_leave_2;
    logic fifo_room_l_0;
    logic fifo_room_l_1;
    logic fifo_room_l_2;
    logic w_here_l_0;
    logic w_here_l_1;
    logic w_here_l_2;
    logic pre_ok_l_0;
    logic pre_ok_l_1;
    logic pre_ok_l_2;
    logic ok_nw_l_0;
    logic ok_nw_l_1;
    logic ok_nw_l_2;
    logic ok_w_l_0;
    logic ok_w_l_1;
    logic ok_w_l_2;
    logic [2:0] wh_vec;
    logic cntbeat_l_0;
    logic cntbeat_l_1;
    logic cntbeat_l_2;
    logic cb_ok_l_0;
    logic cb_ok_l_1;
    logic cb_ok_l_2;
    logic dsp_ahead_0;
    logic dsp_ahead_1;
    logic dsp_ahead_2;
    logic dsp_ahead_3;
    logic dsp_ahead_4;
    logic dsp_ahead_5;
    logic [1:0] rr_p_l_0;
    logic [1:0] rr_p_l_1;
    logic [1:0] rr_p_l_2;
    logic bq_ahead_0;
    logic bq_ahead_1;
    logic bq_ahead_2;
    logic bq_ahead_3;
    logic bq_ahead_4;
    logic bq_ahead_5;
    logic grant_c_0;
    logic grant_c_1;
    logic grant_c_2;
    logic grant_c_3;
    logic grant_c_4;
    logic grant_c_5;
    logic grant_c_6;
    logic grant_c_7;
    logic grant_c_8;
    logic grant_c_9;
    logic grant_c_10;
    logic grant_c_11;
    logic grant_c_12;
    logic grant_c_13;
    logic grant_c_14;
    logic grant_c_15;
    logic grant_c_16;
    logic grant_c_17;
    logic grant_c_18;
    logic grant_c_19;
    logic grant_c_20;
    logic grant_c_21;
    logic grant_c_22;
    logic grant_c_23;
    logic dwin_c_0;
    logic dwin_c_1;
    logic dwin_c_2;
    logic dwin_c_3;
    logic dwin_c_4;
    logic dwin_c_5;
    logic dwin_c_6;
    logic dwin_c_7;
    logic dwin_c_8;
    logic dwin_c_9;
    logic dwin_c_10;
    logic dwin_c_11;
    logic dwin_c_12;
    logic dwin_c_13;
    logic dwin_c_14;
    logic dwin_c_15;
    logic dwin_c_16;
    logic dwin_c_17;
    logic dwin_c_18;
    logic dwin_c_19;
    logic dwin_c_20;
    logic dwin_c_21;
    logic dwin_c_22;
    logic dwin_c_23;
    logic dhit_c_0;
    logic dhit_c_1;
    logic dhit_c_2;
    logic dhit_c_3;
    logic dhit_c_4;
    logic dhit_c_5;
    logic dhit_c_6;
    logic dhit_c_7;
    logic dsp_hit;
    logic grant_l_0;
    logic grant_l_1;
    logic grant_l_2;
    logic dsp_win_l_0;
    logic dsp_win_l_1;
    logic dsp_win_l_2;
    logic b_wen_0;
    logic b_wen_1;
    logic b_wen_2;
    logic b_wen_3;
    logic b_ren_0;
    logic b_ren_1;
    logic b_ren_2;
    logic b_ren_3;
    logic [8:0] b_waddr_0;
    logic [8:0] b_waddr_1;
    logic [8:0] b_waddr_2;
    logic [8:0] b_waddr_3;
    logic [8:0] b_raddr_0;
    logic [8:0] b_raddr_1;
    logic [8:0] b_raddr_2;
    logic [8:0] b_raddr_3;
    logic [2:0] b_wsel_0;
    logic [2:0] b_wsel_1;
    logic [2:0] b_wsel_2;
    logic [2:0] b_wsel_3;
    logic b_whalf_0;
    logic b_whalf_1;
    logic b_whalf_2;
    logic b_whalf_3;
    logic [1023:0] g6_word_0;
    logic [1023:0] g6_rd_0;
    logic [511:0] g6_rd_1;
    logic [1023:0] g6_rd_2;
    logic [1:0] grant_n;
    logic [1:0] stall_n;
    logic push_l_0;
    logic push_l_1;
    logic push_l_2;
    logic [1:0] rr_next_l_0;
    logic [1:0] rr_next_l_1;
    logic [1:0] rr_next_l_2;
    logic push__p0;
    logic [2:0] widx__p0;
    logic g__p0;
    logic lastb__p0;
    logic push__p1;
    logic [2:0] widx__p1;
    logic g__p1;
    logic lastb__p1;
    logic push__p2;
    logic [2:0] widx__p2;
    logic g__p2;
    logic lastb__p2;
    logic wpipe_0_o_wen;
    logic [8:0] wpipe_0_o_waddr;
    logic [1023:0] wpipe_0_o_wdata;
    logic [127:0] wpipe_0_o_wstrb;
    logic wpipe_1_o_wen;
    logic [8:0] wpipe_1_o_waddr;
    logic [1023:0] wpipe_1_o_wdata;
    logic [127:0] wpipe_1_o_wstrb;
    logic wpipe_2_o_wen;
    logic [8:0] wpipe_2_o_waddr;
    logic [1023:0] wpipe_2_o_wdata;
    logic [127:0] wpipe_2_o_wstrb;
    logic wpipe_3_o_wen;
    logic [8:0] wpipe_3_o_waddr;
    logic [1023:0] wpipe_3_o_wdata;
    logic [127:0] wpipe_3_o_wstrb;
    logic rq_0_leave;
    logic rq_1_leave;
    logic rq_2_leave;
    logic [1023:0] banks_0_rdata;
    logic [1023:0] banks_1_rdata;
    logic [1023:0] banks_2_rdata;
    logic [1023:0] banks_3_rdata;
    logic rq_0_rv;
    logic [1023:0] rq_0_hdata;
    logic [3:0] rq_0_hmid;
    logic [15:0] rq_0_htag;
    logic rq_0_hlastb;
    logic rq_0_hlasts;
    logic rq_0_hdir;
    logic rq_0_hv;
    logic rq_1_rv;
    logic [511:0] rq_1_hdata;
    logic [3:0] rq_1_hmid;
    logic [15:0] rq_1_htag;
    logic rq_1_hlastb;
    logic rq_1_hlasts;
    logic rq_1_hdir;
    logic rq_1_hv;
    logic rq_2_rv;
    logic [1023:0] rq_2_hdata;
    logic [3:0] rq_2_hmid;
    logic [15:0] rq_2_htag;
    logic rq_2_hlastb;
    logic rq_2_hlasts;
    logic rq_2_hdir;
    logic rq_2_hv;
    logic ld_nbw_l_0_c0;
    logic ld_nbw_l_0_c1;
    logic ld_nbn_l_0_c0;
    logic ld_nbn_l_0_c1;
    logic ld_nbw_l_1_c0;
    logic ld_nbw_l_1_c1;
    logic ld_nbn_l_1_c0;
    logic ld_nbn_l_1_c1;
    logic ld_nbw_l_2_c0;
    logic ld_nbw_l_2_c1;
    logic ld_nbn_l_2_c0;
    logic ld_nbn_l_2_c1;
    logic grant_c_0_c0;
    logic grant_c_0_c1;
    logic grant_c_0_c2;
    logic grant_c_0_c3;
    logic grant_c_0_c4;
    logic grant_c_0_c5;
    logic dhit_c_0_c0;
    logic grant_c_3_c0;
    logic grant_c_3_c1;
    logic grant_c_3_c2;
    logic grant_c_3_c3;
    logic dhit_c_1_c0;
    logic grant_c_6_c0;
    logic grant_c_6_c1;
    logic grant_c_6_c2;
    logic dhit_c_2_c0;
    logic grant_c_9_c0;
    logic dhit_c_3_c0;
    logic grant_c_12_c0;
    logic grant_c_12_c1;
    logic grant_c_15_c0;
    logic grant_c_18_c0;
    logic b_wen_0_c0;
    logic b_wen_0_c1;
    logic b_wen_0_c2;
    logic b_wen_1_c0;
    logic b_wen_1_c1;
    logic b_wen_1_c2;
    logic b_wen_2_c0;
    logic b_wen_2_c1;
    logic b_wen_2_c2;
    logic b_wen_3_c0;
    logic b_wen_3_c1;
    logic b_wen_3_c2;

    assign hd_idx_l_0 = {2'd0, st_rp_0};
    assign hd_idx_l_1 = {2'd1, st_rp_1};
    assign hd_idx_l_2 = {2'd2, st_rp_2};
    assign hd_v_l_0 = (st_n_0 != 0);
    assign hd_v_l_1 = (st_n_1 != 0);
    assign hd_v_l_2 = (st_n_2 != 0);
    assign hd_dir_l_0 = st_dir[hd_idx_l_0];
    assign hd_dir_l_1 = st_dir[hd_idx_l_1];
    assign hd_dir_l_2 = st_dir[hd_idx_l_2];
    assign hd_q_l_0 = st_q[hd_idx_l_0];
    assign hd_q_l_1 = st_q[hd_idx_l_1];
    assign hd_q_l_2 = st_q[hd_idx_l_2];
    assign hd_cntf_l_0 = st_cnt[hd_idx_l_0];
    assign hd_cntf_l_1 = st_cnt[hd_idx_l_1];
    assign hd_cntf_l_2 = st_cnt[hd_idx_l_2];
    assign hd_word_l_0 = (cur_v_0 ? cur_word[0] : st_word[hd_idx_l_0]);
    assign hd_word_l_1 = (cur_v_1 ? cur_word[1] : st_word[hd_idx_l_1]);
    assign hd_word_l_2 = (cur_v_2 ? cur_word[2] : st_word[hd_idx_l_2]);
    assign hd_left_l_0 = (cur_v_0 ? cur_left[0] : st_beats[hd_idx_l_0]);
    assign hd_left_l_1 = (cur_v_1 ? cur_left[1] : st_beats[hd_idx_l_1]);
    assign hd_left_l_2 = (cur_v_2 ? cur_left[2] : st_beats[hd_idx_l_2]);
    assign hd_one_l_0 = (cur_v_0 ? cur_one_0 : st_one[hd_idx_l_0]);
    assign hd_one_l_1 = (cur_v_1 ? cur_one_1 : st_one[hd_idx_l_1]);
    assign hd_one_l_2 = (cur_v_2 ? cur_one_2 : st_one[hd_idx_l_2]);
    assign hd_bank_l_0 = hd_word_l_0[2:1];
    assign hd_bank_l_1 = hd_word_l_1[2:1];
    assign hd_bank_l_2 = hd_word_l_2[2:1];
    assign hd_baddr_l_0 = hd_word_l_0[11:3];
    assign hd_baddr_l_1 = hd_word_l_1[11:3];
    assign hd_baddr_l_2 = hd_word_l_2[11:3];
    assign hd_half_l_0 = hd_word_l_0[0];
    assign hd_half_l_1 = hd_word_l_1[0];
    assign hd_half_l_2 = hd_word_l_2[0];
    assign ld_lw_l_0 = ({1'd0, p_0_s_addr[6:0]} + {1'd0, p_0_s_bytes[6:0]});
    assign ld_ln_l_0 = ({1'd0, p_0_s_addr[5:0]} + {1'd0, p_0_s_bytes[5:0]});
    assign ld_cw_l_0 = {p_0_s_addr[19:7], 1'd0};
    assign ld_cn_l_0 = p_0_s_addr[19:6];
    assign ld_lw_l_1 = ({1'd0, p_1_s_addr[6:0]} + {1'd0, p_1_s_bytes[6:0]});
    assign ld_ln_l_1 = ({1'd0, p_1_s_addr[5:0]} + {1'd0, p_1_s_bytes[5:0]});
    assign ld_cw_l_1 = {p_1_s_addr[19:7], 1'd0};
    assign ld_cn_l_1 = p_1_s_addr[19:6];
    assign ld_lw_l_2 = ({1'd0, p_2_s_addr[6:0]} + {1'd0, p_2_s_bytes[6:0]});
    assign ld_ln_l_2 = ({1'd0, p_2_s_addr[5:0]} + {1'd0, p_2_s_bytes[5:0]});
    assign ld_cw_l_2 = {p_2_s_addr[19:7], 1'd0};
    assign ld_cn_l_2 = p_2_s_addr[19:6];
    assign ld_h1w_l_0 = ({2'd0, p_0_s_bytes[19:7]} + 1);
    assign ld_h2w_l_0 = ({2'd0, p_0_s_bytes[19:7]} + 2);
    assign ld_nbw_l_0_c0 = ((p_0_s_addr[6:0] == 0) & (p_0_s_bytes[6:0] == 0));
    assign ld_nbw_l_0_c1 = (ld_lw_l_0[7] & (ld_lw_l_0[6:0] != 0));
    assign ld_nbw_l_0 = (ld_nbw_l_0_c0 ? ({2'd0, p_0_s_bytes[19:7]} | {14'd0, (p_0_s_bytes[19:7] == 0)}) :
                        (ld_nbw_l_0_c1 ? ld_h2w_l_0 :
                        ld_h1w_l_0));
    assign ld_onew_l_0 = (((p_0_s_bytes[19:7] == 0) & (~ld_nbw_l_0_c1)) | ((p_0_s_bytes[19:7] == 1) & ld_nbw_l_0_c0));
    assign ld_h1n_l_0 = ({1'd0, p_0_s_bytes[19:6]} + 1);
    assign ld_h2n_l_0 = ({1'd0, p_0_s_bytes[19:6]} + 2);
    assign ld_nbn_l_0_c0 = ((p_0_s_addr[5:0] == 0) & (p_0_s_bytes[5:0] == 0));
    assign ld_nbn_l_0_c1 = (ld_ln_l_0[6] & (ld_ln_l_0[5:0] != 0));
    assign ld_nbn_l_0 = (ld_nbn_l_0_c0 ? ({1'd0, p_0_s_bytes[19:6]} | {14'd0, (p_0_s_bytes[19:6] == 0)}) :
                        (ld_nbn_l_0_c1 ? ld_h2n_l_0 :
                        ld_h1n_l_0));
    assign ld_onen_l_0 = (((p_0_s_bytes[19:6] == 0) & (~ld_nbn_l_0_c1)) | ((p_0_s_bytes[19:6] == 1) & ld_nbn_l_0_c0));
    assign ld_h1w_l_1 = ({2'd0, p_1_s_bytes[19:7]} + 1);
    assign ld_h2w_l_1 = ({2'd0, p_1_s_bytes[19:7]} + 2);
    assign ld_nbw_l_1_c0 = ((p_1_s_addr[6:0] == 0) & (p_1_s_bytes[6:0] == 0));
    assign ld_nbw_l_1_c1 = (ld_lw_l_1[7] & (ld_lw_l_1[6:0] != 0));
    assign ld_nbw_l_1 = (ld_nbw_l_1_c0 ? ({2'd0, p_1_s_bytes[19:7]} | {14'd0, (p_1_s_bytes[19:7] == 0)}) :
                        (ld_nbw_l_1_c1 ? ld_h2w_l_1 :
                        ld_h1w_l_1));
    assign ld_onew_l_1 = (((p_1_s_bytes[19:7] == 0) & (~ld_nbw_l_1_c1)) | ((p_1_s_bytes[19:7] == 1) & ld_nbw_l_1_c0));
    assign ld_h1n_l_1 = ({1'd0, p_1_s_bytes[19:6]} + 1);
    assign ld_h2n_l_1 = ({1'd0, p_1_s_bytes[19:6]} + 2);
    assign ld_nbn_l_1_c0 = ((p_1_s_addr[5:0] == 0) & (p_1_s_bytes[5:0] == 0));
    assign ld_nbn_l_1_c1 = (ld_ln_l_1[6] & (ld_ln_l_1[5:0] != 0));
    assign ld_nbn_l_1 = (ld_nbn_l_1_c0 ? ({1'd0, p_1_s_bytes[19:6]} | {14'd0, (p_1_s_bytes[19:6] == 0)}) :
                        (ld_nbn_l_1_c1 ? ld_h2n_l_1 :
                        ld_h1n_l_1));
    assign ld_onen_l_1 = (((p_1_s_bytes[19:6] == 0) & (~ld_nbn_l_1_c1)) | ((p_1_s_bytes[19:6] == 1) & ld_nbn_l_1_c0));
    assign ld_h1w_l_2 = ({2'd0, p_2_s_bytes[19:7]} + 1);
    assign ld_h2w_l_2 = ({2'd0, p_2_s_bytes[19:7]} + 2);
    assign ld_nbw_l_2_c0 = ((p_2_s_addr[6:0] == 0) & (p_2_s_bytes[6:0] == 0));
    assign ld_nbw_l_2_c1 = (ld_lw_l_2[7] & (ld_lw_l_2[6:0] != 0));
    assign ld_nbw_l_2 = (ld_nbw_l_2_c0 ? ({2'd0, p_2_s_bytes[19:7]} | {14'd0, (p_2_s_bytes[19:7] == 0)}) :
                        (ld_nbw_l_2_c1 ? ld_h2w_l_2 :
                        ld_h1w_l_2));
    assign ld_onew_l_2 = (((p_2_s_bytes[19:7] == 0) & (~ld_nbw_l_2_c1)) | ((p_2_s_bytes[19:7] == 1) & ld_nbw_l_2_c0));
    assign ld_h1n_l_2 = ({1'd0, p_2_s_bytes[19:6]} + 1);
    assign ld_h2n_l_2 = ({1'd0, p_2_s_bytes[19:6]} + 2);
    assign ld_nbn_l_2_c0 = ((p_2_s_addr[5:0] == 0) & (p_2_s_bytes[5:0] == 0));
    assign ld_nbn_l_2_c1 = (ld_ln_l_2[6] & (ld_ln_l_2[5:0] != 0));
    assign ld_nbn_l_2 = (ld_nbn_l_2_c0 ? ({1'd0, p_2_s_bytes[19:6]} | {14'd0, (p_2_s_bytes[19:6] == 0)}) :
                        (ld_nbn_l_2_c1 ? ld_h2n_l_2 :
                        ld_h1n_l_2));
    assign ld_onen_l_2 = (((p_2_s_bytes[19:6] == 0) & (~ld_nbn_l_2_c1)) | ((p_2_s_bytes[19:6] == 1) & ld_nbn_l_2_c0));
    assign ld_cell_l_0 = ld_cw_l_0;
    assign ld_nb_l_0 = ld_nbw_l_0;
    assign ld_one_l_0 = ld_onew_l_0;
    assign hd_step_l_0 = 14'd2;
    assign ld_cell_l_1 = ld_cn_l_1;
    assign ld_nb_l_1 = ld_nbn_l_1;
    assign ld_one_l_1 = ld_onen_l_1;
    assign hd_step_l_1 = 14'd1;
    assign ld_cell_l_2 = (p_2_s_dir ? ld_cn_l_2 : ld_cw_l_2);
    assign ld_nb_l_2 = (p_2_s_dir ? ld_nbn_l_2 : ld_nbw_l_2);
    assign ld_one_l_2 = (p_2_s_dir ? ld_onen_l_2 : ld_onew_l_2);
    assign hd_step_l_2 = (hd_dir_l_2 ? 14'd1 : 14'd2);
    assign rq_leave_0 = rq_0_leave;
    assign rq_leave_1 = rq_1_leave;
    assign rq_leave_2 = rq_2_leave;
    assign fifo_room_l_0 = (rq_occ_0 < 15);
    assign fifo_room_l_1 = (rq_occ_1 < 15);
    assign fifo_room_l_2 = (rq_occ_2 < 15);
    assign pre_ok_l_0 = (hd_v_l_0 & fifo_room_l_0);
    assign pre_ok_l_1 = (hd_v_l_1 & fifo_room_l_1);
    assign pre_ok_l_2 = (hd_v_l_2 & fifo_room_l_2);
    assign w_here_l_0 = (w_0_valid & (w_0_id[2:0] == hd_q_l_0));
    assign w_here_l_1 = (w_1_valid & (w_1_id[2:0] == hd_q_l_1));
    assign w_here_l_2 = (w_2_valid & (w_2_id[2:0] == hd_q_l_2));
    assign ok_nw_l_0 = (pre_ok_l_0 & (~hd_dir_l_0));
    assign ok_nw_l_1 = (pre_ok_l_1 & (~hd_dir_l_1));
    assign ok_nw_l_2 = (pre_ok_l_2 & (~hd_dir_l_2));
    assign ok_w_l_0 = (pre_ok_l_0 & hd_dir_l_0);
    assign ok_w_l_1 = (pre_ok_l_1 & hd_dir_l_1);
    assign ok_w_l_2 = (pre_ok_l_2 & hd_dir_l_2);
    assign wh_vec = {w_here_l_2, w_here_l_1, w_here_l_0};
    assign cntbeat_l_0 = ((hd_v_l_0 & hd_cntf_l_0) & hd_one_l_0);
    assign cntbeat_l_1 = ((hd_v_l_1 & hd_cntf_l_1) & hd_one_l_1);
    assign cntbeat_l_2 = ((hd_v_l_2 & hd_cntf_l_2) & hd_one_l_2);
    assign cb_ok_l_0 = (cntbeat_l_0 & p_0_dsp_ok);
    assign cb_ok_l_1 = (cntbeat_l_1 & p_1_dsp_ok);
    assign cb_ok_l_2 = (cntbeat_l_2 & p_2_dsp_ok);
    assign dsp_ahead_0 = ((dsp_rr == 0) ? 1'd0 : ((dsp_rr == 1) ? 1'd1 : ((dsp_rr == 2) ? 1'd0 : 1'd0)));
    assign dsp_ahead_1 = ((dsp_rr == 0) ? 1'd0 : ((dsp_rr == 1) ? 1'd1 : ((dsp_rr == 2) ? 1'd1 : 1'd1)));
    assign dsp_ahead_2 = ((dsp_rr == 0) ? 1'd1 : ((dsp_rr == 1) ? 1'd0 : ((dsp_rr == 2) ? 1'd1 : 1'd1)));
    assign dsp_ahead_3 = ((dsp_rr == 0) ? 1'd0 : ((dsp_rr == 1) ? 1'd0 : ((dsp_rr == 2) ? 1'd1 : 1'd1)));
    assign dsp_ahead_4 = ((dsp_rr == 0) ? 1'd1 : ((dsp_rr == 1) ? 1'd0 : ((dsp_rr == 2) ? 1'd0 : 1'd0)));
    assign dsp_ahead_5 = ((dsp_rr == 0) ? 1'd1 : ((dsp_rr == 1) ? 1'd1 : ((dsp_rr == 2) ? 1'd0 : 1'd0)));
    assign rr_p_l_0 = ((hd_bank_l_0 == 0) ? rr_0 : ((hd_bank_l_0 == 1) ? rr_1 : ((hd_bank_l_0 == 2) ? rr_2 : rr_3)));
    assign rr_p_l_1 = ((hd_bank_l_1 == 0) ? rr_0 : ((hd_bank_l_1 == 1) ? rr_1 : ((hd_bank_l_1 == 2) ? rr_2 : rr_3)));
    assign rr_p_l_2 = ((hd_bank_l_2 == 0) ? rr_0 : ((hd_bank_l_2 == 1) ? rr_1 : ((hd_bank_l_2 == 2) ? rr_2 : rr_3)));
    assign bq_ahead_0 = ((hd_bank_l_1 == hd_bank_l_0)
                         & ((rr_p_l_0 == 0) ? 1'd0 : ((rr_p_l_0 == 1) ? 1'd1 : ((rr_p_l_0 == 2) ? 1'd0 : 1'd0))));
    assign bq_ahead_1 = ((hd_bank_l_2 == hd_bank_l_0)
                         & ((rr_p_l_0 == 0) ? 1'd0 : ((rr_p_l_0 == 1) ? 1'd1 : ((rr_p_l_0 == 2) ? 1'd1 : 1'd1))));
    assign bq_ahead_2 = ((hd_bank_l_0 == hd_bank_l_1)
                         & ((rr_p_l_1 == 0) ? 1'd1 : ((rr_p_l_1 == 1) ? 1'd0 : ((rr_p_l_1 == 2) ? 1'd1 : 1'd1))));
    assign bq_ahead_3 = ((hd_bank_l_2 == hd_bank_l_1)
                         & ((rr_p_l_1 == 0) ? 1'd0 : ((rr_p_l_1 == 1) ? 1'd0 : ((rr_p_l_1 == 2) ? 1'd1 : 1'd1))));
    assign bq_ahead_4 = ((hd_bank_l_0 == hd_bank_l_2)
                         & ((rr_p_l_2 == 0) ? 1'd1 : ((rr_p_l_2 == 1) ? 1'd0 : ((rr_p_l_2 == 2) ? 1'd0 : 1'd0))));
    assign bq_ahead_5 = ((hd_bank_l_1 == hd_bank_l_2)
                         & ((rr_p_l_2 == 0) ? 1'd1 : ((rr_p_l_2 == 1) ? 1'd1 : ((rr_p_l_2 == 2) ? 1'd0 : 1'd0))));
    assign grant_c_0_c0 = (1'd0 | ((ok_nw_l_1 & cb_ok_l_1) & dsp_ahead_0));
    assign grant_c_0_c1 = (grant_c_0_c0 | ((ok_nw_l_2 & cb_ok_l_2) & dsp_ahead_1));
    assign grant_c_0_c2 = (1'd0 | ((ok_nw_l_0 & cb_ok_l_0) & dsp_ahead_2));
    assign grant_c_0_c3 = (grant_c_0_c2 | ((ok_nw_l_2 & cb_ok_l_2) & dsp_ahead_3));
    assign grant_c_0_c4 = (1'd0 | ((ok_nw_l_0 & cb_ok_l_0) & dsp_ahead_4));
    assign grant_c_0_c5 = (grant_c_0_c4 | ((ok_nw_l_1 & cb_ok_l_1) & dsp_ahead_5));
    assign grant_c_0 = ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_0_c1))))
                        & (~((1'd0
                             | ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_0_c3))))
                                & bq_ahead_0))
                             | ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_0_c5))))
                                & bq_ahead_1))));
    assign grant_c_1 = ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_0_c3))))
                        & (~((1'd0
                             | ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_0_c1))))
                                & bq_ahead_2))
                             | ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_0_c5))))
                                & bq_ahead_3))));
    assign grant_c_2 = ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_0_c5))))
                        & (~((1'd0
                             | ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_0_c1))))
                                & bq_ahead_4))
                             | ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_0_c3))))
                                & bq_ahead_5))));
    assign dwin_c_0 = ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_0_c1));
    assign dwin_c_1 = ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_0_c3));
    assign dwin_c_2 = ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_0_c5));
    assign dhit_c_0_c0 = ((ok_nw_l_0 & cb_ok_l_0) | (ok_nw_l_1 & cb_ok_l_1));
    assign dhit_c_0 = (dhit_c_0_c0 | (ok_nw_l_2 & cb_ok_l_2));
    assign grant_c_3_c0 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & dsp_ahead_2);
    assign grant_c_3_c1 = ((1'd0 | grant_c_3_c0) | ((ok_nw_l_2 & cb_ok_l_2) & dsp_ahead_3));
    assign grant_c_3_c2 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & dsp_ahead_4);
    assign grant_c_3_c3 = ((1'd0 | grant_c_3_c2) | ((ok_nw_l_1 & cb_ok_l_1) & dsp_ahead_5));
    assign grant_c_3 = (((ok_nw_l_0 | ok_w_l_0)
                        & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_0_c1))))
                        & (~((1'd0
                             | ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_3_c1))))
                                & bq_ahead_0))
                             | ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_3_c3))))
                                & bq_ahead_1))));
    assign grant_c_4 = ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_3_c1))))
                        & (~((1'd0
                             | (((ok_nw_l_0 | ok_w_l_0)
                                & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_0_c1))))
                                & bq_ahead_2))
                             | ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_3_c3))))
                                & bq_ahead_3))));
    assign grant_c_5 = ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_3_c3))))
                        & (~((1'd0
                             | (((ok_nw_l_0 | ok_w_l_0)
                                & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_0_c1))))
                                & bq_ahead_4))
                             | ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_3_c1))))
                                & bq_ahead_5))));
    assign dwin_c_3 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_0_c1));
    assign dwin_c_4 = ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_3_c1));
    assign dwin_c_5 = ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_3_c3));
    assign dhit_c_1_c0 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) | (ok_nw_l_1 & cb_ok_l_1));
    assign dhit_c_1 = (dhit_c_1_c0 | (ok_nw_l_2 & cb_ok_l_2));
    assign grant_c_6_c0 = (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & dsp_ahead_0);
    assign grant_c_6_c1 = ((1'd0 | grant_c_6_c0) | ((ok_nw_l_2 & cb_ok_l_2) & dsp_ahead_1));
    assign grant_c_6_c2 = (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & dsp_ahead_5);
    assign grant_c_6 = ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_6_c1))))
                        & (~((1'd0
                             | (((ok_nw_l_1 | ok_w_l_1)
                                & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_0_c3))))
                                & bq_ahead_0))
                             | ((ok_nw_l_2
                                & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)))))
                                & bq_ahead_1))));
    assign grant_c_7 = (((ok_nw_l_1 | ok_w_l_1)
                        & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_0_c3))))
                        & (~((1'd0
                             | ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_6_c1))))
                                & bq_ahead_2))
                             | ((ok_nw_l_2
                                & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)))))
                                & bq_ahead_3))));
    assign grant_c_8 = ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)))))
                        & (~((1'd0
                             | ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_6_c1))))
                                & bq_ahead_4))
                             | (((ok_nw_l_1 | ok_w_l_1)
                                & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_0_c3))))
                                & bq_ahead_5))));
    assign dwin_c_6 = ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_6_c1));
    assign dwin_c_7 = (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_0_c3));
    assign dwin_c_8 = ((ok_nw_l_2 & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)));
    assign dhit_c_2_c0 = ((ok_nw_l_0 & cb_ok_l_0) | ((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1));
    assign dhit_c_2 = (dhit_c_2_c0 | (ok_nw_l_2 & cb_ok_l_2));
    assign grant_c_9_c0 = ((1'd0 | grant_c_3_c2) | grant_c_6_c2);
    assign grant_c_9 = (((ok_nw_l_0 | ok_w_l_0)
                        & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_6_c1))))
                        & (~((1'd0
                             | (((ok_nw_l_1 | ok_w_l_1)
                                & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_3_c1))))
                                & bq_ahead_0))
                             | ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_9_c0))))
                                & bq_ahead_1))));
    assign grant_c_10 = (((ok_nw_l_1 | ok_w_l_1)
                         & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_3_c1))))
                         & (~((1'd0
                              | (((ok_nw_l_0 | ok_w_l_0)
                                 & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_6_c1))))
                                 & bq_ahead_2))
                              | ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_9_c0))))
                                 & bq_ahead_3))));
    assign grant_c_11 = ((ok_nw_l_2 & ((~cntbeat_l_2) | ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_9_c0))))
                         & (~((1'd0
                              | (((ok_nw_l_0 | ok_w_l_0)
                                 & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_6_c1))))
                                 & bq_ahead_4))
                              | (((ok_nw_l_1 | ok_w_l_1)
                                 & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_3_c1))))
                                 & bq_ahead_5))));
    assign dwin_c_9 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_6_c1));
    assign dwin_c_10 = (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_3_c1));
    assign dwin_c_11 = ((ok_nw_l_2 & cb_ok_l_2) & (~grant_c_9_c0));
    assign dhit_c_3_c0 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) | ((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1));
    assign dhit_c_3 = (dhit_c_3_c0 | (ok_nw_l_2 & cb_ok_l_2));
    assign grant_c_12_c0 = (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & dsp_ahead_1);
    assign grant_c_12_c1 = (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & dsp_ahead_3);
    assign grant_c_12 = ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)))))
                         & (~((1'd0
                              | ((ok_nw_l_1
                                 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)))))
                                 & bq_ahead_0))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_0_c5))))
                                 & bq_ahead_1))));
    assign grant_c_13 = ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)))))
                         & (~((1'd0
                              | ((ok_nw_l_0
                                 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)))))
                                 & bq_ahead_2))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_0_c5))))
                                 & bq_ahead_3))));
    assign grant_c_14 = (((ok_nw_l_2 | ok_w_l_2)
                         & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_0_c5))))
                         & (~((1'd0
                              | ((ok_nw_l_0
                                 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)))))
                                 & bq_ahead_4))
                              | ((ok_nw_l_1
                                 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)))))
                                 & bq_ahead_5))));
    assign dwin_c_12 = ((ok_nw_l_0 & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)));
    assign dwin_c_13 = ((ok_nw_l_1 & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)));
    assign dwin_c_14 = (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_0_c5));
    assign dhit_c_4 = (dhit_c_0_c0 | ((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2));
    assign grant_c_15_c0 = ((1'd0 | grant_c_3_c0) | grant_c_12_c1);
    assign grant_c_15 = (((ok_nw_l_0 | ok_w_l_0)
                         & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)))))
                         & (~((1'd0
                              | ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_15_c0))))
                                 & bq_ahead_0))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_3_c3))))
                                 & bq_ahead_1))));
    assign grant_c_16 = ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_15_c0))))
                         & (~((1'd0
                              | (((ok_nw_l_0 | ok_w_l_0)
                                 & ((~cntbeat_l_0)
                                    | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)))))
                                 & bq_ahead_2))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_3_c3))))
                                 & bq_ahead_3))));
    assign grant_c_17 = (((ok_nw_l_2 | ok_w_l_2)
                         & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_3_c3))))
                         & (~((1'd0
                              | (((ok_nw_l_0 | ok_w_l_0)
                                 & ((~cntbeat_l_0)
                                    | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)))))
                                 & bq_ahead_4))
                              | ((ok_nw_l_1 & ((~cntbeat_l_1) | ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_15_c0))))
                                 & bq_ahead_5))));
    assign dwin_c_15 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~(grant_c_0_c0 | grant_c_12_c0)));
    assign dwin_c_16 = ((ok_nw_l_1 & cb_ok_l_1) & (~grant_c_15_c0));
    assign dwin_c_17 = (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_3_c3));
    assign dhit_c_5 = (dhit_c_1_c0 | ((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2));
    assign grant_c_18_c0 = ((1'd0 | grant_c_6_c0) | grant_c_12_c0);
    assign grant_c_18 = ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_18_c0))))
                         & (~((1'd0
                              | (((ok_nw_l_1 | ok_w_l_1)
                                 & ((~cntbeat_l_1)
                                    | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)))))
                                 & bq_ahead_0))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2)
                                    | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)))))
                                 & bq_ahead_1))));
    assign grant_c_19 = (((ok_nw_l_1 | ok_w_l_1)
                         & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)))))
                         & (~((1'd0
                              | ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_18_c0))))
                                 & bq_ahead_2))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2)
                                    | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)))))
                                 & bq_ahead_3))));
    assign grant_c_20 = (((ok_nw_l_2 | ok_w_l_2)
                         & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)))))
                         & (~((1'd0
                              | ((ok_nw_l_0 & ((~cntbeat_l_0) | ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_18_c0))))
                                 & bq_ahead_4))
                              | (((ok_nw_l_1 | ok_w_l_1)
                                 & ((~cntbeat_l_1)
                                    | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)))))
                                 & bq_ahead_5))));
    assign dwin_c_18 = ((ok_nw_l_0 & cb_ok_l_0) & (~grant_c_18_c0));
    assign dwin_c_19 = (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~(grant_c_0_c2 | grant_c_12_c1)));
    assign dwin_c_20 = (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~(grant_c_0_c4 | grant_c_6_c2)));
    assign dhit_c_6 = (dhit_c_2_c0 | ((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2));
    assign grant_c_21 = (((ok_nw_l_0 | ok_w_l_0)
                         & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_18_c0))))
                         & (~((1'd0
                              | (((ok_nw_l_1 | ok_w_l_1)
                                 & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_15_c0))))
                                 & bq_ahead_0))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_9_c0))))
                                 & bq_ahead_1))));
    assign grant_c_22 = (((ok_nw_l_1 | ok_w_l_1)
                         & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_15_c0))))
                         & (~((1'd0
                              | (((ok_nw_l_0 | ok_w_l_0)
                                 & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_18_c0))))
                                 & bq_ahead_2))
                              | (((ok_nw_l_2 | ok_w_l_2)
                                 & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_9_c0))))
                                 & bq_ahead_3))));
    assign grant_c_23 = (((ok_nw_l_2 | ok_w_l_2)
                         & ((~cntbeat_l_2) | (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_9_c0))))
                         & (~((1'd0
                              | (((ok_nw_l_0 | ok_w_l_0)
                                 & ((~cntbeat_l_0) | (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_18_c0))))
                                 & bq_ahead_4))
                              | (((ok_nw_l_1 | ok_w_l_1)
                                 & ((~cntbeat_l_1) | (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_15_c0))))
                                 & bq_ahead_5))));
    assign dwin_c_21 = (((ok_nw_l_0 | ok_w_l_0) & cb_ok_l_0) & (~grant_c_18_c0));
    assign dwin_c_22 = (((ok_nw_l_1 | ok_w_l_1) & cb_ok_l_1) & (~grant_c_15_c0));
    assign dwin_c_23 = (((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2) & (~grant_c_9_c0));
    assign dhit_c_7 = (dhit_c_3_c0 | ((ok_nw_l_2 | ok_w_l_2) & cb_ok_l_2));
    assign grant_l_0 = ((wh_vec == 0) ? grant_c_0 :
                       ((wh_vec == 1) ? grant_c_3 :
                       ((wh_vec == 2) ? grant_c_6 :
                       ((wh_vec == 3) ? grant_c_9 :
                       ((wh_vec == 4) ? grant_c_12 :
                       ((wh_vec == 5) ? grant_c_15 :
                       ((wh_vec == 6) ? grant_c_18 :
                       grant_c_21)))))));
    assign grant_l_1 = ((wh_vec == 0) ? grant_c_1 :
                       ((wh_vec == 1) ? grant_c_4 :
                       ((wh_vec == 2) ? grant_c_7 :
                       ((wh_vec == 3) ? grant_c_10 :
                       ((wh_vec == 4) ? grant_c_13 :
                       ((wh_vec == 5) ? grant_c_16 :
                       ((wh_vec == 6) ? grant_c_19 :
                       grant_c_22)))))));
    assign grant_l_2 = ((wh_vec == 0) ? grant_c_2 :
                       ((wh_vec == 1) ? grant_c_5 :
                       ((wh_vec == 2) ? grant_c_8 :
                       ((wh_vec == 3) ? grant_c_11 :
                       ((wh_vec == 4) ? grant_c_14 :
                       ((wh_vec == 5) ? grant_c_17 :
                       ((wh_vec == 6) ? grant_c_20 :
                       grant_c_23)))))));
    assign dsp_win_l_0 = ((wh_vec == 0) ? dwin_c_0 :
                         ((wh_vec == 1) ? dwin_c_3 :
                         ((wh_vec == 2) ? dwin_c_6 :
                         ((wh_vec == 3) ? dwin_c_9 :
                         ((wh_vec == 4) ? dwin_c_12 :
                         ((wh_vec == 5) ? dwin_c_15 :
                         ((wh_vec == 6) ? dwin_c_18 :
                         dwin_c_21)))))));
    assign dsp_win_l_1 = ((wh_vec == 0) ? dwin_c_1 :
                         ((wh_vec == 1) ? dwin_c_4 :
                         ((wh_vec == 2) ? dwin_c_7 :
                         ((wh_vec == 3) ? dwin_c_10 :
                         ((wh_vec == 4) ? dwin_c_13 :
                         ((wh_vec == 5) ? dwin_c_16 :
                         ((wh_vec == 6) ? dwin_c_19 :
                         dwin_c_22)))))));
    assign dsp_win_l_2 = ((wh_vec == 0) ? dwin_c_2 :
                         ((wh_vec == 1) ? dwin_c_5 :
                         ((wh_vec == 2) ? dwin_c_8 :
                         ((wh_vec == 3) ? dwin_c_11 :
                         ((wh_vec == 4) ? dwin_c_14 :
                         ((wh_vec == 5) ? dwin_c_17 :
                         ((wh_vec == 6) ? dwin_c_20 :
                         dwin_c_23)))))));
    assign dsp_hit = ((wh_vec == 0) ? dhit_c_0 :
                     ((wh_vec == 1) ? dhit_c_1 :
                     ((wh_vec == 2) ? dhit_c_2 :
                     ((wh_vec == 3) ? dhit_c_3 :
                     ((wh_vec == 4) ? dhit_c_4 :
                     ((wh_vec == 5) ? dhit_c_5 :
                     ((wh_vec == 6) ? dhit_c_6 :
                     dhit_c_7)))))));
    assign b_wen_0_c0 = ((grant_l_0 & hd_dir_l_0) & (hd_bank_l_0 == 0));
    assign b_wen_0_c1 = ((grant_l_1 & hd_dir_l_1) & (hd_bank_l_1 == 0));
    assign b_wen_0_c2 = ((grant_l_2 & hd_dir_l_2) & (hd_bank_l_2 == 0));
    assign b_wen_0 = (((1'd0 | b_wen_0_c0) | b_wen_0_c1) | b_wen_0_c2);
    assign b_ren_0 = (((1'd0 | ((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 0)))
                      | ((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 0)))
                      | ((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 0)));
    assign b_waddr_0 = (((9'd0 | ({9{b_wen_0_c0}} & hd_baddr_l_0)) | ({9{b_wen_0_c1}} & hd_baddr_l_1))
                        | ({9{b_wen_0_c2}} & hd_baddr_l_2));
    assign b_raddr_0 = (((9'd0 | ({9{((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 0))}} & hd_baddr_l_0))
                        | ({9{((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 0))}} & hd_baddr_l_1))
                        | ({9{((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 0))}} & hd_baddr_l_2));
    assign b_wsel_0 = {b_wen_0_c2, b_wen_0_c1, b_wen_0_c0};
    assign b_whalf_0 = (((1'd0 | (b_wen_0_c0 & hd_half_l_0)) | (b_wen_0_c1 & hd_half_l_1)) | (b_wen_0_c2 & hd_half_l_2));
    assign b_wen_1_c0 = ((grant_l_0 & hd_dir_l_0) & (hd_bank_l_0 == 1));
    assign b_wen_1_c1 = ((grant_l_1 & hd_dir_l_1) & (hd_bank_l_1 == 1));
    assign b_wen_1_c2 = ((grant_l_2 & hd_dir_l_2) & (hd_bank_l_2 == 1));
    assign b_wen_1 = (((1'd0 | b_wen_1_c0) | b_wen_1_c1) | b_wen_1_c2);
    assign b_ren_1 = (((1'd0 | ((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 1)))
                      | ((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 1)))
                      | ((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 1)));
    assign b_waddr_1 = (((9'd0 | ({9{b_wen_1_c0}} & hd_baddr_l_0)) | ({9{b_wen_1_c1}} & hd_baddr_l_1))
                        | ({9{b_wen_1_c2}} & hd_baddr_l_2));
    assign b_raddr_1 = (((9'd0 | ({9{((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 1))}} & hd_baddr_l_0))
                        | ({9{((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 1))}} & hd_baddr_l_1))
                        | ({9{((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 1))}} & hd_baddr_l_2));
    assign b_wsel_1 = {b_wen_1_c2, b_wen_1_c1, b_wen_1_c0};
    assign b_whalf_1 = (((1'd0 | (b_wen_1_c0 & hd_half_l_0)) | (b_wen_1_c1 & hd_half_l_1)) | (b_wen_1_c2 & hd_half_l_2));
    assign b_wen_2_c0 = ((grant_l_0 & hd_dir_l_0) & (hd_bank_l_0 == 2));
    assign b_wen_2_c1 = ((grant_l_1 & hd_dir_l_1) & (hd_bank_l_1 == 2));
    assign b_wen_2_c2 = ((grant_l_2 & hd_dir_l_2) & (hd_bank_l_2 == 2));
    assign b_wen_2 = (((1'd0 | b_wen_2_c0) | b_wen_2_c1) | b_wen_2_c2);
    assign b_ren_2 = (((1'd0 | ((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 2)))
                      | ((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 2)))
                      | ((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 2)));
    assign b_waddr_2 = (((9'd0 | ({9{b_wen_2_c0}} & hd_baddr_l_0)) | ({9{b_wen_2_c1}} & hd_baddr_l_1))
                        | ({9{b_wen_2_c2}} & hd_baddr_l_2));
    assign b_raddr_2 = (((9'd0 | ({9{((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 2))}} & hd_baddr_l_0))
                        | ({9{((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 2))}} & hd_baddr_l_1))
                        | ({9{((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 2))}} & hd_baddr_l_2));
    assign b_wsel_2 = {b_wen_2_c2, b_wen_2_c1, b_wen_2_c0};
    assign b_whalf_2 = (((1'd0 | (b_wen_2_c0 & hd_half_l_0)) | (b_wen_2_c1 & hd_half_l_1)) | (b_wen_2_c2 & hd_half_l_2));
    assign b_wen_3_c0 = ((grant_l_0 & hd_dir_l_0) & (hd_bank_l_0 == 3));
    assign b_wen_3_c1 = ((grant_l_1 & hd_dir_l_1) & (hd_bank_l_1 == 3));
    assign b_wen_3_c2 = ((grant_l_2 & hd_dir_l_2) & (hd_bank_l_2 == 3));
    assign b_wen_3 = (((1'd0 | b_wen_3_c0) | b_wen_3_c1) | b_wen_3_c2);
    assign b_ren_3 = (((1'd0 | ((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 3)))
                      | ((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 3)))
                      | ((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 3)));
    assign b_waddr_3 = (((9'd0 | ({9{b_wen_3_c0}} & hd_baddr_l_0)) | ({9{b_wen_3_c1}} & hd_baddr_l_1))
                        | ({9{b_wen_3_c2}} & hd_baddr_l_2));
    assign b_raddr_3 = (((9'd0 | ({9{((grant_l_0 & (~hd_dir_l_0)) & (hd_bank_l_0 == 3))}} & hd_baddr_l_0))
                        | ({9{((grant_l_1 & (~hd_dir_l_1)) & (hd_bank_l_1 == 3))}} & hd_baddr_l_1))
                        | ({9{((grant_l_2 & (~hd_dir_l_2)) & (hd_bank_l_2 == 3))}} & hd_baddr_l_2));
    assign b_wsel_3 = {b_wen_3_c2, b_wen_3_c1, b_wen_3_c0};
    assign b_whalf_3 = (((1'd0 | (b_wen_3_c0 & hd_half_l_0)) | (b_wen_3_c1 & hd_half_l_1)) | (b_wen_3_c2 & hd_half_l_2));
    assign g6_word_0 = ((g6_bank[1] == 0) ? banks_0_rdata :
                       ((g6_bank[1] == 1) ? banks_1_rdata :
                       ((g6_bank[1] == 2) ? banks_2_rdata :
                       banks_3_rdata)));
    assign g6_rd_0 = ((g6_bank[0] == 0) ? banks_0_rdata :
                     ((g6_bank[0] == 1) ? banks_1_rdata :
                     ((g6_bank[0] == 2) ? banks_2_rdata :
                     banks_3_rdata)));
    assign g6_rd_1 = (g6_half[1] ? g6_word_0[1023:512] : g6_word_0[511:0]);
    assign g6_rd_2 = ((g6_bank[2] == 0) ? banks_0_rdata :
                     ((g6_bank[2] == 1) ? banks_1_rdata :
                     ((g6_bank[2] == 2) ? banks_2_rdata :
                     banks_3_rdata)));
    assign rq_data_0 = g6_rd_0;
    assign r_0_valid = rq_0_rv;
    assign r_0_data = rq_0_hdata;
    assign r_0_id = rq_0_hmid;
    assign r_0_tag = rq_0_htag;
    assign r_0_last = (rq_0_hlastb & rq_0_hlasts);
    assign p_0_sdone = (rq_leave_0 & rq_0_hlastb);
    assign p_0_sdone_dir = rq_0_hdir;
    assign p_0_sdone_w = ((rq_0_hv & rq_0_hdir) & rq_0_hlastb);
    assign p_0_sdone_last = rq_0_hlasts;
    assign p_0_sdone_tag = rq_0_htag;
    assign p_0_sdone_mid = rq_0_hmid;
    assign p_0_s_ready = (st_n_0 != 2);
    assign w_0_ready = ((grant_l_0 & hd_dir_l_0) ? ({7'd0, 1'd1} << hd_q_l_0) : 8'd0);
    assign p_0_dsp = g1_dsp_0;
    assign p_0_dsp_cid = g1_cid[0];
    assign rq_data_1 = g6_rd_1;
    assign r_1_valid = rq_1_rv;
    assign r_1_data = rq_1_hdata;
    assign r_1_id = rq_1_hmid;
    assign r_1_tag = rq_1_htag;
    assign r_1_last = (rq_1_hlastb & rq_1_hlasts);
    assign p_1_sdone = (rq_leave_1 & rq_1_hlastb);
    assign p_1_sdone_dir = rq_1_hdir;
    assign p_1_sdone_w = ((rq_1_hv & rq_1_hdir) & rq_1_hlastb);
    assign p_1_sdone_last = rq_1_hlasts;
    assign p_1_sdone_tag = rq_1_htag;
    assign p_1_sdone_mid = rq_1_hmid;
    assign p_1_s_ready = (st_n_1 != 2);
    assign w_1_ready = ((grant_l_1 & hd_dir_l_1) ? ({7'd0, 1'd1} << hd_q_l_1) : 8'd0);
    assign p_1_dsp = g1_dsp_1;
    assign p_1_dsp_cid = g1_cid[1];
    assign rq_data_2 = g6_rd_2;
    assign r_2_valid = rq_2_rv;
    assign r_2_data = rq_2_hdata;
    assign r_2_id = rq_2_hmid;
    assign r_2_tag = rq_2_htag;
    assign r_2_last = (rq_2_hlastb & rq_2_hlasts);
    assign p_2_sdone = (rq_leave_2 & rq_2_hlastb);
    assign p_2_sdone_dir = rq_2_hdir;
    assign p_2_sdone_w = ((rq_2_hv & rq_2_hdir) & rq_2_hlastb);
    assign p_2_sdone_last = rq_2_hlasts;
    assign p_2_sdone_tag = rq_2_htag;
    assign p_2_sdone_mid = rq_2_hmid;
    assign p_2_s_ready = (st_n_2 != 2);
    assign w_2_ready = ((grant_l_2 & hd_dir_l_2) ? ({7'd0, 1'd1} << hd_q_l_2) : 8'd0);
    assign p_2_dsp = g1_dsp_2;
    assign p_2_dsp_cid = g1_cid[2];
    assign dbg_grant = dq_grant;
    assign dbg_stall = dq_stall;
    assign grant_n = (({1'd0, grant_l_0} + {1'd0, grant_l_1}) + {1'd0, grant_l_2});
    assign stall_n = (({1'd0, (hd_v_l_0 & (~grant_l_0))} + {1'd0, (hd_v_l_1 & (~grant_l_1))})
                      + {1'd0, (hd_v_l_2 & (~grant_l_2))});
    assign push_l_0 = (p_0_s_valid & (st_n_0 != 2));
    assign push_l_1 = (p_1_s_valid & (st_n_1 != 2));
    assign push_l_2 = (p_2_s_valid & (st_n_2 != 2));
    assign rr_next_l_0 = 2'd1;
    assign rr_next_l_1 = 2'd2;
    assign rr_next_l_2 = 2'd0;
    assign push__p0 = push_l_0;
    assign widx__p0 = {2'd0, st_wp_0};
    assign g__p0 = grant_l_0;
    assign lastb__p0 = hd_one_l_0;
    assign push__p1 = push_l_1;
    assign widx__p1 = {2'd1, st_wp_1};
    assign g__p1 = grant_l_1;
    assign lastb__p1 = hd_one_l_1;
    assign push__p2 = push_l_2;
    assign widx__p2 = {2'd2, st_wp_2};
    assign g__p2 = grant_l_2;
    assign lastb__p2 = hd_one_l_2;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            dq_grant <= 0;
            dq_stall <= 0;
            dsp_rr <= 0;
            st_wp_0 <= 0;
            cur_v_0 <= 0;
            rr_0 <= 0;
            rr_1 <= 0;
            rr_2 <= 0;
            rr_3 <= 0;
            st_rp_0 <= 0;
            st_n_0 <= 0;
            g1_v_0 <= 0;
            g1_dsp_0 <= 0;
            g2_v_0 <= 0;
            g3_v_0 <= 0;
            g4_v_0 <= 0;
            g5_v_0 <= 0;
            g6_vr_0_0 <= 0;
            g6_vr_0_1 <= 0;
            g6_vr_0_2 <= 0;
            g6_vr_0_3 <= 0;
            g6_vr_0_4 <= 0;
            g6_vr_0_5 <= 0;
            g6_vr_0_6 <= 0;
            g6_vr_0_7 <= 0;
            g6_vr_0_8 <= 0;
            g6_vr_0_9 <= 0;
            g6_vr_0_10 <= 0;
            g6_vr_0_11 <= 0;
            g6_vr_0_12 <= 0;
            g6_vr_0_13 <= 0;
            g6_vr_0_14 <= 0;
            g6_vr_0_15 <= 0;
            rq_occ_0 <= 0;
            st_wp_1 <= 0;
            cur_v_1 <= 0;
            st_rp_1 <= 0;
            st_n_1 <= 0;
            g1_v_1 <= 0;
            g1_dsp_1 <= 0;
            g2_v_1 <= 0;
            g3_v_1 <= 0;
            g4_v_1 <= 0;
            g5_v_1 <= 0;
            g6_vr_1_0 <= 0;
            g6_vr_1_1 <= 0;
            g6_vr_1_2 <= 0;
            g6_vr_1_3 <= 0;
            g6_vr_1_4 <= 0;
            g6_vr_1_5 <= 0;
            g6_vr_1_6 <= 0;
            g6_vr_1_7 <= 0;
            g6_vr_1_8 <= 0;
            g6_vr_1_9 <= 0;
            g6_vr_1_10 <= 0;
            g6_vr_1_11 <= 0;
            g6_vr_1_12 <= 0;
            g6_vr_1_13 <= 0;
            g6_vr_1_14 <= 0;
            g6_vr_1_15 <= 0;
            rq_occ_1 <= 0;
            st_wp_2 <= 0;
            cur_v_2 <= 0;
            st_rp_2 <= 0;
            st_n_2 <= 0;
            g1_v_2 <= 0;
            g1_dsp_2 <= 0;
            g2_v_2 <= 0;
            g3_v_2 <= 0;
            g4_v_2 <= 0;
            g5_v_2 <= 0;
            g6_vr_2_0 <= 0;
            g6_vr_2_1 <= 0;
            g6_vr_2_2 <= 0;
            g6_vr_2_3 <= 0;
            g6_vr_2_4 <= 0;
            g6_vr_2_5 <= 0;
            g6_vr_2_6 <= 0;
            g6_vr_2_7 <= 0;
            g6_vr_2_8 <= 0;
            g6_vr_2_9 <= 0;
            g6_vr_2_10 <= 0;
            g6_vr_2_11 <= 0;
            g6_vr_2_12 <= 0;
            g6_vr_2_13 <= 0;
            g6_vr_2_14 <= 0;
            g6_vr_2_15 <= 0;
            rq_occ_2 <= 0;
            rd_v1_0 <= 0;
            rd_v2_0 <= 0;
            rd_v3_0 <= 0;
            rd_v4_0 <= 0;
            rd_v1_1 <= 0;
            rd_v2_1 <= 0;
            rd_v3_1 <= 0;
            rd_v4_1 <= 0;
            rd_v1_2 <= 0;
            rd_v2_2 <= 0;
            rd_v3_2 <= 0;
            rd_v4_2 <= 0;
            rd_v1_3 <= 0;
            rd_v2_3 <= 0;
            rd_v3_3 <= 0;
            rd_v4_3 <= 0;
        end else begin
            dq_grant <= grant_n;
            dq_stall <= stall_n;
            if (dsp_hit) begin
                dsp_rr <= (dsp_win_l_0 ? 2'd1 : (dsp_win_l_1 ? 2'd2 : 2'd0));
            end
            if (push__p0) begin
                st_wp_0 <= (st_wp_0 + 1);
            end
            if (g__p0) begin
                cur_v_0 <= (~lastb__p0);
                if ((hd_bank_l_0 == 0)) begin
                    rr_0 <= rr_next_l_0;
                end
                if ((hd_bank_l_0 == 1)) begin
                    rr_1 <= rr_next_l_0;
                end
                if ((hd_bank_l_0 == 2)) begin
                    rr_2 <= rr_next_l_0;
                end
                if ((hd_bank_l_0 == 3)) begin
                    rr_3 <= rr_next_l_0;
                end
                if (lastb__p0) begin
                    st_rp_0 <= (st_rp_0 + 1);
                end
            end
            if ((push__p0 & (~(g__p0 & lastb__p0)))) begin
                st_n_0 <= (st_n_0 + 1);
            end else begin
                if (((g__p0 & lastb__p0) & (~push__p0))) begin
                    st_n_0 <= (st_n_0 - 1);
                end
            end
            g1_v_0 <= g__p0;
            g1_dsp_0 <= (g__p0 & cntbeat_l_0);
            g2_v_0 <= g1_v_0;
            g3_v_0 <= g2_v_0;
            g4_v_0 <= g3_v_0;
            g5_v_0 <= g4_v_0;
            g6_vr_0_0 <= g5_v_0;
            g6_vr_0_1 <= g5_v_0;
            g6_vr_0_2 <= g5_v_0;
            g6_vr_0_3 <= g5_v_0;
            g6_vr_0_4 <= g5_v_0;
            g6_vr_0_5 <= g5_v_0;
            g6_vr_0_6 <= g5_v_0;
            g6_vr_0_7 <= g5_v_0;
            g6_vr_0_8 <= g5_v_0;
            g6_vr_0_9 <= g5_v_0;
            g6_vr_0_10 <= g5_v_0;
            g6_vr_0_11 <= g5_v_0;
            g6_vr_0_12 <= g5_v_0;
            g6_vr_0_13 <= g5_v_0;
            g6_vr_0_14 <= g5_v_0;
            g6_vr_0_15 <= g5_v_0;
            if ((g1_v_0 & (~rq_leave_0))) begin
                rq_occ_0 <= (rq_occ_0 + 1);
            end else begin
                if ((rq_leave_0 & (~g1_v_0))) begin
                    rq_occ_0 <= (rq_occ_0 - 1);
                end
            end
            if (push__p1) begin
                st_wp_1 <= (st_wp_1 + 1);
            end
            if (g__p1) begin
                cur_v_1 <= (~lastb__p1);
                if ((hd_bank_l_1 == 0)) begin
                    rr_0 <= rr_next_l_1;
                end
                if ((hd_bank_l_1 == 1)) begin
                    rr_1 <= rr_next_l_1;
                end
                if ((hd_bank_l_1 == 2)) begin
                    rr_2 <= rr_next_l_1;
                end
                if ((hd_bank_l_1 == 3)) begin
                    rr_3 <= rr_next_l_1;
                end
                if (lastb__p1) begin
                    st_rp_1 <= (st_rp_1 + 1);
                end
            end
            if ((push__p1 & (~(g__p1 & lastb__p1)))) begin
                st_n_1 <= (st_n_1 + 1);
            end else begin
                if (((g__p1 & lastb__p1) & (~push__p1))) begin
                    st_n_1 <= (st_n_1 - 1);
                end
            end
            g1_v_1 <= g__p1;
            g1_dsp_1 <= (g__p1 & cntbeat_l_1);
            g2_v_1 <= g1_v_1;
            g3_v_1 <= g2_v_1;
            g4_v_1 <= g3_v_1;
            g5_v_1 <= g4_v_1;
            g6_vr_1_0 <= g5_v_1;
            g6_vr_1_1 <= g5_v_1;
            g6_vr_1_2 <= g5_v_1;
            g6_vr_1_3 <= g5_v_1;
            g6_vr_1_4 <= g5_v_1;
            g6_vr_1_5 <= g5_v_1;
            g6_vr_1_6 <= g5_v_1;
            g6_vr_1_7 <= g5_v_1;
            g6_vr_1_8 <= g5_v_1;
            g6_vr_1_9 <= g5_v_1;
            g6_vr_1_10 <= g5_v_1;
            g6_vr_1_11 <= g5_v_1;
            g6_vr_1_12 <= g5_v_1;
            g6_vr_1_13 <= g5_v_1;
            g6_vr_1_14 <= g5_v_1;
            g6_vr_1_15 <= g5_v_1;
            if ((g1_v_1 & (~rq_leave_1))) begin
                rq_occ_1 <= (rq_occ_1 + 1);
            end else begin
                if ((rq_leave_1 & (~g1_v_1))) begin
                    rq_occ_1 <= (rq_occ_1 - 1);
                end
            end
            if (push__p2) begin
                st_wp_2 <= (st_wp_2 + 1);
            end
            if (g__p2) begin
                cur_v_2 <= (~lastb__p2);
                if ((hd_bank_l_2 == 0)) begin
                    rr_0 <= rr_next_l_2;
                end
                if ((hd_bank_l_2 == 1)) begin
                    rr_1 <= rr_next_l_2;
                end
                if ((hd_bank_l_2 == 2)) begin
                    rr_2 <= rr_next_l_2;
                end
                if ((hd_bank_l_2 == 3)) begin
                    rr_3 <= rr_next_l_2;
                end
                if (lastb__p2) begin
                    st_rp_2 <= (st_rp_2 + 1);
                end
            end
            if ((push__p2 & (~(g__p2 & lastb__p2)))) begin
                st_n_2 <= (st_n_2 + 1);
            end else begin
                if (((g__p2 & lastb__p2) & (~push__p2))) begin
                    st_n_2 <= (st_n_2 - 1);
                end
            end
            g1_v_2 <= g__p2;
            g1_dsp_2 <= (g__p2 & cntbeat_l_2);
            g2_v_2 <= g1_v_2;
            g3_v_2 <= g2_v_2;
            g4_v_2 <= g3_v_2;
            g5_v_2 <= g4_v_2;
            g6_vr_2_0 <= g5_v_2;
            g6_vr_2_1 <= g5_v_2;
            g6_vr_2_2 <= g5_v_2;
            g6_vr_2_3 <= g5_v_2;
            g6_vr_2_4 <= g5_v_2;
            g6_vr_2_5 <= g5_v_2;
            g6_vr_2_6 <= g5_v_2;
            g6_vr_2_7 <= g5_v_2;
            g6_vr_2_8 <= g5_v_2;
            g6_vr_2_9 <= g5_v_2;
            g6_vr_2_10 <= g5_v_2;
            g6_vr_2_11 <= g5_v_2;
            g6_vr_2_12 <= g5_v_2;
            g6_vr_2_13 <= g5_v_2;
            g6_vr_2_14 <= g5_v_2;
            g6_vr_2_15 <= g5_v_2;
            if ((g1_v_2 & (~rq_leave_2))) begin
                rq_occ_2 <= (rq_occ_2 + 1);
            end else begin
                if ((rq_leave_2 & (~g1_v_2))) begin
                    rq_occ_2 <= (rq_occ_2 - 1);
                end
            end
            rd_v1_0 <= b_ren_0;
            rd_v2_0 <= rd_v1_0;
            rd_v3_0 <= rd_v2_0;
            rd_v4_0 <= rd_v3_0;
            rd_v1_1 <= b_ren_1;
            rd_v2_1 <= rd_v1_1;
            rd_v3_1 <= rd_v2_1;
            rd_v4_1 <= rd_v3_1;
            rd_v1_2 <= b_ren_2;
            rd_v2_2 <= rd_v1_2;
            rd_v3_2 <= rd_v2_2;
            rd_v4_2 <= rd_v3_2;
            rd_v1_3 <= b_ren_3;
            rd_v2_3 <= rd_v1_3;
            rd_v3_3 <= rd_v2_3;
            rd_v4_3 <= rd_v3_3;
        end
    end
    always_ff @(posedge clk) begin
        wd_q_0 <= w_0_data;
        ws_q_0 <= w_0_strb;
        wd_q2_0 <= wd_q_0;
        ws_q2_0 <= ws_q_0;
        if (push__p0) begin
            st_word[widx__p0] <= ld_cell_l_0;
            st_beats[widx__p0] <= ld_nb_l_0;
            st_one[widx__p0] <= ld_one_l_0;
            st_dir[widx__p0] <= p_0_s_dir;
            st_tag[widx__p0] <= p_0_s_tag;
            st_q[widx__p0] <= p_0_s_q;
            st_mid[widx__p0] <= p_0_s_mid;
            st_last[widx__p0] <= p_0_s_last;
            st_cid[widx__p0] <= p_0_s_cid;
            st_cnt[widx__p0] <= p_0_s_cnt;
        end
        if (g__p0) begin
            cur_word[0] <= (hd_word_l_0 + hd_step_l_0);
            cur_left[0] <= (hd_left_l_0 - 1);
            cur_one_0 <= (hd_left_l_0 == 2);
        end
        g1_dir[0] <= hd_dir_l_0;
        g1_bank[0] <= hd_bank_l_0;
        g1_half[0] <= hd_half_l_0;
        g1_tag[0] <= st_tag[hd_idx_l_0];
        g1_mid[0] <= st_mid[hd_idx_l_0];
        g1_lastb[0] <= lastb__p0;
        g1_lasts[0] <= st_last[hd_idx_l_0];
        g1_cid[0] <= st_cid[hd_idx_l_0];
        g2_dir[0] <= g1_dir[0];
        g2_bank[0] <= g1_bank[0];
        g2_half[0] <= g1_half[0];
        g2_tag[0] <= g1_tag[0];
        g2_mid[0] <= g1_mid[0];
        g2_lastb[0] <= g1_lastb[0];
        g2_lasts[0] <= g1_lasts[0];
        g3_dir[0] <= g2_dir[0];
        g3_bank[0] <= g2_bank[0];
        g3_half[0] <= g2_half[0];
        g3_tag[0] <= g2_tag[0];
        g3_mid[0] <= g2_mid[0];
        g3_lastb[0] <= g2_lastb[0];
        g3_lasts[0] <= g2_lasts[0];
        g4_dir[0] <= g3_dir[0];
        g4_bank[0] <= g3_bank[0];
        g4_half[0] <= g3_half[0];
        g4_tag[0] <= g3_tag[0];
        g4_mid[0] <= g3_mid[0];
        g4_lastb[0] <= g3_lastb[0];
        g4_lasts[0] <= g3_lasts[0];
        g5_dir[0] <= g4_dir[0];
        g5_bank[0] <= g4_bank[0];
        g5_half[0] <= g4_half[0];
        g5_tag[0] <= g4_tag[0];
        g5_mid[0] <= g4_mid[0];
        g5_lastb[0] <= g4_lastb[0];
        g5_lasts[0] <= g4_lasts[0];
        g6_dir[0] <= g5_dir[0];
        g6_bank[0] <= g5_bank[0];
        g6_half[0] <= g5_half[0];
        g6_tag[0] <= g5_tag[0];
        g6_mid[0] <= g5_mid[0];
        g6_lastb[0] <= g5_lastb[0];
        g6_lasts[0] <= g5_lasts[0];
        wd_q_1 <= w_1_data;
        ws_q_1 <= w_1_strb;
        wd_q2_1 <= wd_q_1;
        ws_q2_1 <= ws_q_1;
        if (push__p1) begin
            st_word[widx__p1] <= ld_cell_l_1;
            st_beats[widx__p1] <= ld_nb_l_1;
            st_one[widx__p1] <= ld_one_l_1;
            st_dir[widx__p1] <= p_1_s_dir;
            st_tag[widx__p1] <= p_1_s_tag;
            st_q[widx__p1] <= p_1_s_q;
            st_mid[widx__p1] <= p_1_s_mid;
            st_last[widx__p1] <= p_1_s_last;
            st_cid[widx__p1] <= p_1_s_cid;
            st_cnt[widx__p1] <= p_1_s_cnt;
        end
        if (g__p1) begin
            cur_word[1] <= (hd_word_l_1 + hd_step_l_1);
            cur_left[1] <= (hd_left_l_1 - 1);
            cur_one_1 <= (hd_left_l_1 == 2);
        end
        g1_dir[1] <= hd_dir_l_1;
        g1_bank[1] <= hd_bank_l_1;
        g1_half[1] <= hd_half_l_1;
        g1_tag[1] <= st_tag[hd_idx_l_1];
        g1_mid[1] <= st_mid[hd_idx_l_1];
        g1_lastb[1] <= lastb__p1;
        g1_lasts[1] <= st_last[hd_idx_l_1];
        g1_cid[1] <= st_cid[hd_idx_l_1];
        g2_dir[1] <= g1_dir[1];
        g2_bank[1] <= g1_bank[1];
        g2_half[1] <= g1_half[1];
        g2_tag[1] <= g1_tag[1];
        g2_mid[1] <= g1_mid[1];
        g2_lastb[1] <= g1_lastb[1];
        g2_lasts[1] <= g1_lasts[1];
        g3_dir[1] <= g2_dir[1];
        g3_bank[1] <= g2_bank[1];
        g3_half[1] <= g2_half[1];
        g3_tag[1] <= g2_tag[1];
        g3_mid[1] <= g2_mid[1];
        g3_lastb[1] <= g2_lastb[1];
        g3_lasts[1] <= g2_lasts[1];
        g4_dir[1] <= g3_dir[1];
        g4_bank[1] <= g3_bank[1];
        g4_half[1] <= g3_half[1];
        g4_tag[1] <= g3_tag[1];
        g4_mid[1] <= g3_mid[1];
        g4_lastb[1] <= g3_lastb[1];
        g4_lasts[1] <= g3_lasts[1];
        g5_dir[1] <= g4_dir[1];
        g5_bank[1] <= g4_bank[1];
        g5_half[1] <= g4_half[1];
        g5_tag[1] <= g4_tag[1];
        g5_mid[1] <= g4_mid[1];
        g5_lastb[1] <= g4_lastb[1];
        g5_lasts[1] <= g4_lasts[1];
        g6_dir[1] <= g5_dir[1];
        g6_bank[1] <= g5_bank[1];
        g6_half[1] <= g5_half[1];
        g6_tag[1] <= g5_tag[1];
        g6_mid[1] <= g5_mid[1];
        g6_lastb[1] <= g5_lastb[1];
        g6_lasts[1] <= g5_lasts[1];
        wd_q_2 <= w_2_data;
        ws_q_2 <= w_2_strb;
        wd_q2_2 <= wd_q_2;
        ws_q2_2 <= ws_q_2;
        if (push__p2) begin
            st_word[widx__p2] <= ld_cell_l_2;
            st_beats[widx__p2] <= ld_nb_l_2;
            st_one[widx__p2] <= ld_one_l_2;
            st_dir[widx__p2] <= p_2_s_dir;
            st_tag[widx__p2] <= p_2_s_tag;
            st_q[widx__p2] <= p_2_s_q;
            st_mid[widx__p2] <= p_2_s_mid;
            st_last[widx__p2] <= p_2_s_last;
            st_cid[widx__p2] <= p_2_s_cid;
            st_cnt[widx__p2] <= p_2_s_cnt;
        end
        if (g__p2) begin
            cur_word[2] <= (hd_word_l_2 + hd_step_l_2);
            cur_left[2] <= (hd_left_l_2 - 1);
            cur_one_2 <= (hd_left_l_2 == 2);
        end
        g1_dir[2] <= hd_dir_l_2;
        g1_bank[2] <= hd_bank_l_2;
        g1_half[2] <= hd_half_l_2;
        g1_tag[2] <= st_tag[hd_idx_l_2];
        g1_mid[2] <= st_mid[hd_idx_l_2];
        g1_lastb[2] <= lastb__p2;
        g1_lasts[2] <= st_last[hd_idx_l_2];
        g1_cid[2] <= st_cid[hd_idx_l_2];
        g2_dir[2] <= g1_dir[2];
        g2_bank[2] <= g1_bank[2];
        g2_half[2] <= g1_half[2];
        g2_tag[2] <= g1_tag[2];
        g2_mid[2] <= g1_mid[2];
        g2_lastb[2] <= g1_lastb[2];
        g2_lasts[2] <= g1_lasts[2];
        g3_dir[2] <= g2_dir[2];
        g3_bank[2] <= g2_bank[2];
        g3_half[2] <= g2_half[2];
        g3_tag[2] <= g2_tag[2];
        g3_mid[2] <= g2_mid[2];
        g3_lastb[2] <= g2_lastb[2];
        g3_lasts[2] <= g2_lasts[2];
        g4_dir[2] <= g3_dir[2];
        g4_bank[2] <= g3_bank[2];
        g4_half[2] <= g3_half[2];
        g4_tag[2] <= g3_tag[2];
        g4_mid[2] <= g3_mid[2];
        g4_lastb[2] <= g3_lastb[2];
        g4_lasts[2] <= g3_lasts[2];
        g5_dir[2] <= g4_dir[2];
        g5_bank[2] <= g4_bank[2];
        g5_half[2] <= g4_half[2];
        g5_tag[2] <= g4_tag[2];
        g5_mid[2] <= g4_mid[2];
        g5_lastb[2] <= g4_lastb[2];
        g5_lasts[2] <= g4_lasts[2];
        g6_dir[2] <= g5_dir[2];
        g6_bank[2] <= g5_bank[2];
        g6_half[2] <= g5_half[2];
        g6_tag[2] <= g5_tag[2];
        g6_mid[2] <= g5_mid[2];
        g6_lastb[2] <= g5_lastb[2];
        g6_lasts[2] <= g5_lasts[2];
        rd_a1_0 <= b_raddr_0;
        rd_a2_0 <= rd_a1_0;
        rd_a3_0 <= rd_a2_0;
        rd_a4_0 <= rd_a3_0;
        rd_a1_1 <= b_raddr_1;
        rd_a2_1 <= rd_a1_1;
        rd_a3_1 <= rd_a2_1;
        rd_a4_1 <= rd_a3_1;
        rd_a1_2 <= b_raddr_2;
        rd_a2_2 <= rd_a1_2;
        rd_a3_2 <= rd_a2_2;
        rd_a4_2 <= rd_a3_2;
        rd_a1_3 <= b_raddr_3;
        rd_a2_3 <= rd_a1_3;
        rd_a3_3 <= rd_a2_3;
        rd_a4_3 <= rd_a3_3;
    end

    L1RespQ #(.DW(1024)) rq_0 (
        .clk(clk),
        .rst_n(rst_n),
        .p_dir(g6_dir[0]),
        .p_tag(g6_tag[0]),
        .p_mid(g6_mid[0]),
        .p_lastb(g6_lastb[0]),
        .p_lasts(g6_lasts[0]),
        .p_data(rq_data_0),
        .rready(r_0_ready),
        .push_0(g6_vr_0_0),
        .push_1(g6_vr_0_1),
        .push_2(g6_vr_0_2),
        .push_3(g6_vr_0_3),
        .push_4(g6_vr_0_4),
        .push_5(g6_vr_0_5),
        .push_6(g6_vr_0_6),
        .push_7(g6_vr_0_7),
        .push_8(g6_vr_0_8),
        .push_9(g6_vr_0_9),
        .push_10(g6_vr_0_10),
        .push_11(g6_vr_0_11),
        .push_12(g6_vr_0_12),
        .push_13(g6_vr_0_13),
        .push_14(g6_vr_0_14),
        .push_15(g6_vr_0_15),
        .leave(rq_0_leave),
        .rv(rq_0_rv),
        .hdata(rq_0_hdata),
        .hmid(rq_0_hmid),
        .htag(rq_0_htag),
        .hlastb(rq_0_hlastb),
        .hlasts(rq_0_hlasts),
        .hdir(rq_0_hdir),
        .hv(rq_0_hv)
    );
    L1RespQ #(.DW(512)) rq_1 (
        .clk(clk),
        .rst_n(rst_n),
        .p_dir(g6_dir[1]),
        .p_tag(g6_tag[1]),
        .p_mid(g6_mid[1]),
        .p_lastb(g6_lastb[1]),
        .p_lasts(g6_lasts[1]),
        .p_data(rq_data_1),
        .rready(r_1_ready),
        .push_0(g6_vr_1_0),
        .push_1(g6_vr_1_1),
        .push_2(g6_vr_1_2),
        .push_3(g6_vr_1_3),
        .push_4(g6_vr_1_4),
        .push_5(g6_vr_1_5),
        .push_6(g6_vr_1_6),
        .push_7(g6_vr_1_7),
        .push_8(g6_vr_1_8),
        .push_9(g6_vr_1_9),
        .push_10(g6_vr_1_10),
        .push_11(g6_vr_1_11),
        .push_12(g6_vr_1_12),
        .push_13(g6_vr_1_13),
        .push_14(g6_vr_1_14),
        .push_15(g6_vr_1_15),
        .leave(rq_1_leave),
        .rv(rq_1_rv),
        .hdata(rq_1_hdata),
        .hmid(rq_1_hmid),
        .htag(rq_1_htag),
        .hlastb(rq_1_hlastb),
        .hlasts(rq_1_hlasts),
        .hdir(rq_1_hdir),
        .hv(rq_1_hv)
    );
    L1RespQ #(.DW(1024)) rq_2 (
        .clk(clk),
        .rst_n(rst_n),
        .p_dir(g6_dir[2]),
        .p_tag(g6_tag[2]),
        .p_mid(g6_mid[2]),
        .p_lastb(g6_lastb[2]),
        .p_lasts(g6_lasts[2]),
        .p_data(rq_data_2),
        .rready(r_2_ready),
        .push_0(g6_vr_2_0),
        .push_1(g6_vr_2_1),
        .push_2(g6_vr_2_2),
        .push_3(g6_vr_2_3),
        .push_4(g6_vr_2_4),
        .push_5(g6_vr_2_5),
        .push_6(g6_vr_2_6),
        .push_7(g6_vr_2_7),
        .push_8(g6_vr_2_8),
        .push_9(g6_vr_2_9),
        .push_10(g6_vr_2_10),
        .push_11(g6_vr_2_11),
        .push_12(g6_vr_2_12),
        .push_13(g6_vr_2_13),
        .push_14(g6_vr_2_14),
        .push_15(g6_vr_2_15),
        .leave(rq_2_leave),
        .rv(rq_2_rv),
        .hdata(rq_2_hdata),
        .hmid(rq_2_hmid),
        .htag(rq_2_htag),
        .hlastb(rq_2_hlastb),
        .hlasts(rq_2_hlasts),
        .hdir(rq_2_hdir),
        .hv(rq_2_hv)
    );
    L1BankWPipe wpipe_0 (
        .clk(clk),
        .rst_n(rst_n),
        .wen(b_wen_0),
        .waddr(b_waddr_0),
        .wsel(b_wsel_0),
        .whalf(b_whalf_0),
        .p0_wdata(wd_q2_0),
        .p0_wstrb(ws_q2_0),
        .p1_wdata(wd_q2_1),
        .p1_wstrb(ws_q2_1),
        .p2_wdata(wd_q2_2),
        .p2_wstrb(ws_q2_2),
        .o_wen(wpipe_0_o_wen),
        .o_waddr(wpipe_0_o_waddr),
        .o_wdata(wpipe_0_o_wdata),
        .o_wstrb(wpipe_0_o_wstrb)
    );
    L1BankWPipe wpipe_1 (
        .clk(clk),
        .rst_n(rst_n),
        .wen(b_wen_1),
        .waddr(b_waddr_1),
        .wsel(b_wsel_1),
        .whalf(b_whalf_1),
        .p0_wdata(wd_q2_0),
        .p0_wstrb(ws_q2_0),
        .p1_wdata(wd_q2_1),
        .p1_wstrb(ws_q2_1),
        .p2_wdata(wd_q2_2),
        .p2_wstrb(ws_q2_2),
        .o_wen(wpipe_1_o_wen),
        .o_waddr(wpipe_1_o_waddr),
        .o_wdata(wpipe_1_o_wdata),
        .o_wstrb(wpipe_1_o_wstrb)
    );
    L1BankWPipe wpipe_2 (
        .clk(clk),
        .rst_n(rst_n),
        .wen(b_wen_2),
        .waddr(b_waddr_2),
        .wsel(b_wsel_2),
        .whalf(b_whalf_2),
        .p0_wdata(wd_q2_0),
        .p0_wstrb(ws_q2_0),
        .p1_wdata(wd_q2_1),
        .p1_wstrb(ws_q2_1),
        .p2_wdata(wd_q2_2),
        .p2_wstrb(ws_q2_2),
        .o_wen(wpipe_2_o_wen),
        .o_waddr(wpipe_2_o_waddr),
        .o_wdata(wpipe_2_o_wdata),
        .o_wstrb(wpipe_2_o_wstrb)
    );
    L1BankWPipe wpipe_3 (
        .clk(clk),
        .rst_n(rst_n),
        .wen(b_wen_3),
        .waddr(b_waddr_3),
        .wsel(b_wsel_3),
        .whalf(b_whalf_3),
        .p0_wdata(wd_q2_0),
        .p0_wstrb(ws_q2_0),
        .p1_wdata(wd_q2_1),
        .p1_wstrb(ws_q2_1),
        .p2_wdata(wd_q2_2),
        .p2_wstrb(ws_q2_2),
        .o_wen(wpipe_3_o_wen),
        .o_waddr(wpipe_3_o_waddr),
        .o_wdata(wpipe_3_o_wdata),
        .o_wstrb(wpipe_3_o_wstrb)
    );
    L1BankSram banks_0 (
        .clk(clk),
        .wen(wpipe_0_o_wen),
        .waddr(wpipe_0_o_waddr),
        .wdata(wpipe_0_o_wdata),
        .wstrb(wpipe_0_o_wstrb),
        .ren(rd_v4_0),
        .raddr(rd_a4_0),
        .rdata(banks_0_rdata)
    );
    L1BankSram banks_1 (
        .clk(clk),
        .wen(wpipe_1_o_wen),
        .waddr(wpipe_1_o_waddr),
        .wdata(wpipe_1_o_wdata),
        .wstrb(wpipe_1_o_wstrb),
        .ren(rd_v4_1),
        .raddr(rd_a4_1),
        .rdata(banks_1_rdata)
    );
    L1BankSram banks_2 (
        .clk(clk),
        .wen(wpipe_2_o_wen),
        .waddr(wpipe_2_o_waddr),
        .wdata(wpipe_2_o_wdata),
        .wstrb(wpipe_2_o_wstrb),
        .ren(rd_v4_2),
        .raddr(rd_a4_2),
        .rdata(banks_2_rdata)
    );
    L1BankSram banks_3 (
        .clk(clk),
        .wen(wpipe_3_o_wen),
        .waddr(wpipe_3_o_waddr),
        .wdata(wpipe_3_o_wdata),
        .wstrb(wpipe_3_o_wstrb),
        .ren(rd_v4_3),
        .raddr(rd_a4_3),
        .rdata(banks_3_rdata)
    );
endmodule
