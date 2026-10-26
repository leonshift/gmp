module NocAgg (
    input clk,
    input rst_n,
    input ent_b_ok0,
    input ent_b_ok1,
    input ent_b_ok2,
    input ent_b_ok3,
    input ent_b_ok4,
    input ent_rq0_push,
    input [7:0] ent_rq0_tk,
    input [47:0] ent_rq0_addr,
    input [4:0] ent_rq0_slot,
    output logic ent_rq0_ok,
    input ent_rq1_push,
    input [7:0] ent_rq1_tk,
    input [47:0] ent_rq1_addr,
    input [4:0] ent_rq1_slot,
    output logic ent_rq1_ok,
    input ent_rq2_push,
    input [7:0] ent_rq2_tk,
    input [47:0] ent_rq2_addr,
    input [4:0] ent_rq2_slot,
    output logic ent_rq2_ok,
    input ent_rq3_push,
    input [7:0] ent_rq3_tk,
    input [47:0] ent_rq3_addr,
    input [4:0] ent_rq3_slot,
    output logic ent_rq3_ok,
    input ent_wq_push,
    input [2:0] ent_wq_m,
    input [3:0] ent_wq_wid,
    input [47:0] ent_wq_addr,
    input [8:0] ent_wq_eoff,
    input ent_wq_last,
    input [15:0] ent_wq_tag,
    input ent_wq_loc,
    output logic ent_wq_ok,
    input ent_ra_en,
    input [5:0] ent_ra_addr,
    output logic [1023:0] ent_ra_data,
    input ent_rb_en,
    input [5:0] ent_rb_addr,
    output logic [1023:0] ent_rb_data,
    input ent_ed0_v,
    input [4:0] ent_ed0_slot,
    input ent_ed1_v,
    input [4:0] ent_ed1_slot,
    output logic ent_asm_ok0_c0,
    output logic [4:0] ent_asm_s0_c0,
    output logic ent_asm_ok1_c0,
    output logic [4:0] ent_asm_s1_c0,
    output logic ent_asm_ok0_c1,
    output logic [4:0] ent_asm_s0_c1,
    output logic ent_asm_ok1_c1,
    output logic [4:0] ent_asm_s1_c1,
    input ent_asm_rv0,
    input ent_asm_rv1,
    input ent_asm_pa_c0,
    input ent_asm_pa_c1,
    input ent_asm_pb_c0,
    input ent_asm_pb_c1,
    output logic ent_wk0_v,
    output logic [7:0] ent_wk0_tk,
    output logic [4:0] ent_wk0_asl,
    output logic ent_wk1_v,
    output logic [7:0] ent_wk1_tk,
    output logic [4:0] ent_wk1_asl,
    output logic ent_bev_v,
    output logic [2:0] ent_bev_m,
    output logic [3:0] ent_bev_wid,
    output logic [15:0] ent_bev_tag,
    output logic ent_bev_loc,
    output logic [31:0] st_req,
    output logic [31:0] st_fill,
    output logic [31:0] st_wt,
    input w_0_valid,
    input [3:0] w_0_id,
    input [1023:0] w_0_data,
    input [127:0] w_0_strb,
    output logic [7:0] w_0_ready,
    input w_1_valid,
    input [3:0] w_1_id,
    input [1023:0] w_1_data,
    input [127:0] w_1_strb,
    output logic [7:0] w_1_ready,
    input w_2_valid,
    input [3:0] w_2_id,
    input [1023:0] w_2_data,
    input [127:0] w_2_strb,
    output logic [7:0] w_2_ready,
    input w_3_valid,
    input [3:0] w_3_id,
    input [1023:0] w_3_data,
    input [127:0] w_3_strb,
    output logic [7:0] w_3_ready,
    input w_4_valid,
    input [3:0] w_4_id,
    input [1023:0] w_4_data,
    input [127:0] w_4_strb,
    output logic [7:0] w_4_ready,
    input stat_clr_all,
    output logic [5:0] dbg_infl_occ,
    output logic [5:0] dbg_rd_out,
    output logic [5:0] dbg_asm_occ,
    output logic [3:0] dbg_lane_busy,
    output logic dbg_idle,
    output logic m_0_ar_valid,
    input m_0_ar_ready,
    output logic [7:0] m_0_ar_id,
    output logic [47:0] m_0_ar_addr,
    output logic [7:0] m_0_ar_len,
    output logic m_0_aw_valid,
    input m_0_aw_ready,
    output logic [7:0] m_0_aw_id,
    output logic [47:0] m_0_aw_addr,
    output logic [7:0] m_0_aw_len,
    output logic m_0_w_valid,
    input m_0_w_ready,
    output logic [511:0] m_0_w_data,
    output logic [63:0] m_0_w_strb,
    output logic m_0_w_last,
    input m_0_b_valid,
    output logic m_0_b_ready,
    input [7:0] m_0_b_id,
    input m_0_r_valid,
    output logic m_0_r_ready,
    input [7:0] m_0_r_id,
    input [511:0] m_0_r_data,
    input m_0_r_last,
    output logic m_1_ar_valid,
    input m_1_ar_ready,
    output logic [7:0] m_1_ar_id,
    output logic [47:0] m_1_ar_addr,
    output logic [7:0] m_1_ar_len,
    output logic m_1_aw_valid,
    input m_1_aw_ready,
    output logic [7:0] m_1_aw_id,
    output logic [47:0] m_1_aw_addr,
    output logic [7:0] m_1_aw_len,
    output logic m_1_w_valid,
    input m_1_w_ready,
    output logic [511:0] m_1_w_data,
    output logic [63:0] m_1_w_strb,
    output logic m_1_w_last,
    input m_1_b_valid,
    output logic m_1_b_ready,
    input [7:0] m_1_b_id,
    input m_1_r_valid,
    output logic m_1_r_ready,
    input [7:0] m_1_r_id,
    input [511:0] m_1_r_data,
    input m_1_r_last
);
    logic mr_v_0;
    logic mr_v_1;
    logic [511:0] mr_data_0;
    logic [511:0] mr_data_1;
    logic [7:0] mr_id_0;
    logic [7:0] mr_id_1;
    logic mr_last_0;
    logic mr_last_1;
    logic ar_rr_0;
    logic ar_rr_1;
    logic [7:0] tk_slot_0 [0:15];
    logic [7:0] tk_slot_1 [0:15];
    logic [1:0] bcnt_0_0;
    logic [1:0] bcnt_0_1;
    logic [1:0] bcnt_0_2;
    logic [1:0] bcnt_0_3;
    logic [1:0] bcnt_0_4;
    logic [1:0] bcnt_0_5;
    logic [1:0] bcnt_0_6;
    logic [1:0] bcnt_0_7;
    logic [1:0] bcnt_0_8;
    logic [1:0] bcnt_0_9;
    logic [1:0] bcnt_0_10;
    logic [1:0] bcnt_0_11;
    logic [1:0] bcnt_0_12;
    logic [1:0] bcnt_0_13;
    logic [1:0] bcnt_0_14;
    logic [1:0] bcnt_0_15;
    logic [1:0] bcnt_1_0;
    logic [1:0] bcnt_1_1;
    logic [1:0] bcnt_1_2;
    logic [1:0] bcnt_1_3;
    logic [1:0] bcnt_1_4;
    logic [1:0] bcnt_1_5;
    logic [1:0] bcnt_1_6;
    logic [1:0] bcnt_1_7;
    logic [1:0] bcnt_1_8;
    logic [1:0] bcnt_1_9;
    logic [1:0] bcnt_1_10;
    logic [1:0] bcnt_1_11;
    logic [1:0] bcnt_1_12;
    logic [1:0] bcnt_1_13;
    logic [1:0] bcnt_1_14;
    logic [1:0] bcnt_1_15;
    logic [2:0] wqm [0:15];
    logic [3:0] wqwid [0:15];
    logic [47:0] wqaddr [0:15];
    logic [8:0] wqeoff [0:15];
    logic wqlast [0:15];
    logic [15:0] wqtag [0:15];
    logic wqloc [0:15];
    logic [3:0] wwp;
    logic [3:0] wrp;
    logic [4:0] wcnt;
    logic wq_okq;
    logic [2:0] wom [0:3];
    logic [3:0] wowid [0:3];
    logic [2:0] wonb [0:3];
    logic wolast [0:3];
    logic [15:0] wotag [0:3];
    logic woloc [0:3];
    logic [5:0] wosidx [0:3];
    logic woch [0:3];
    logic [1:0] owp;
    logic [1:0] orp;
    logic [2:0] ocnt;
    logic [1:0] orp1;
    logic [2:0] ho_m;
    logic [4:0] ho_moh;
    logic [3:0] ho_wid;
    logic [2:0] ho_nbm1;
    logic ho_last;
    logic [15:0] ho_tag;
    logic ho_loc;
    logic [5:0] ho_sidx;
    logic ho_ch;
    logic [2:0] wbk;
    logic ar_v_0;
    logic ar_v_1;
    logic [7:0] ar_id_0;
    logic [7:0] ar_id_1;
    logic [47:0] ar_addr_0;
    logic [47:0] ar_addr_1;
    logic aw_v;
    logic [7:0] aw_id;
    logic [47:0] aw_addr;
    logic [7:0] aw_len;
    logic [5:0] wt_id;
    logic wq_v;
    logic [511:0] wq_sd;
    logic [63:0] wq_ss;
    logic [511:0] wq_hd;
    logic [63:0] wq_hs;
    logic wq_more;
    logic wq_ch;
    logic aw_ch;
    logic wq_vc_0;
    logic wq_vc_1;
    logic aw_vc_0;
    logic aw_vc_1;
    logic wt_v;
    logic [2:0] wt_m;
    logic wt_last;
    logic wt_held;
    logic [1023:0] wt_dat;
    logic [127:0] wt_stb;
    logic wd_v;
    logic [1023:0] wd_data;
    logic [127:0] wd_strb;
    logic wd_last;
    logic wd_nrw;
    logic wt_ch;
    logic wd_ch;
    logic wq_last_q;
    logic wkv_q_0;
    logic wkv_q_1;
    logic [7:0] wktk_q_0;
    logic [7:0] wktk_q_1;
    logic [4:0] wkasl_q_0;
    logic [4:0] wkasl_q_1;
    logic [511:0] asw_d_a_0;
    logic [511:0] asw_d_a_1;
    logic [511:0] asw_d_a_2;
    logic [511:0] asw_d_a_3;
    logic [511:0] asw_d_b_0;
    logic [511:0] asw_d_b_1;
    logic [511:0] asw_d_b_2;
    logic [511:0] asw_d_b_3;
    logic asw_we_a_0;
    logic asw_we_a_1;
    logic asw_we_a_2;
    logic asw_we_a_3;
    logic asw_we_b_0;
    logic asw_we_b_1;
    logic asw_we_b_2;
    logic asw_we_b_3;
    logic [4:0] asw_ad_a_0;
    logic [4:0] asw_ad_a_1;
    logic [4:0] asw_ad_a_2;
    logic [4:0] asw_ad_a_3;
    logic [4:0] asw_ad_b_0;
    logic [4:0] asw_ad_b_1;
    logic [4:0] asw_ad_b_2;
    logic [4:0] asw_ad_b_3;
    logic ra_ch_q;
    logic rb_ch_q;
    logic [3:0] fl_0_0;
    logic [3:0] fl_0_1;
    logic [3:0] fl_0_2;
    logic [3:0] fl_0_3;
    logic [3:0] fl_0_4;
    logic [3:0] fl_0_5;
    logic [3:0] fl_0_6;
    logic [3:0] fl_0_7;
    logic [3:0] fl_0_8;
    logic [3:0] fl_0_9;
    logic [3:0] fl_0_10;
    logic [3:0] fl_0_11;
    logic [3:0] fl_0_12;
    logic [3:0] fl_0_13;
    logic [3:0] fl_0_14;
    logic [3:0] fl_0_15;
    logic [3:0] fl_1_0;
    logic [3:0] fl_1_1;
    logic [3:0] fl_1_2;
    logic [3:0] fl_1_3;
    logic [3:0] fl_1_4;
    logic [3:0] fl_1_5;
    logic [3:0] fl_1_6;
    logic [3:0] fl_1_7;
    logic [3:0] fl_1_8;
    logic [3:0] fl_1_9;
    logic [3:0] fl_1_10;
    logic [3:0] fl_1_11;
    logic [3:0] fl_1_12;
    logic [3:0] fl_1_13;
    logic [3:0] fl_1_14;
    logic [3:0] fl_1_15;
    logic [3:0] fl_rp_0;
    logic [3:0] fl_rp_1;
    logic [3:0] fl_rp1_0;
    logic [3:0] fl_rp1_1;
    logic [3:0] fl_wp_0;
    logic [3:0] fl_wp_1;
    logic [3:0] fl_wp1_0;
    logic [3:0] fl_wp1_1;
    logic [4:0] fl_cnt_0;
    logic [4:0] fl_cnt_1;
    logic fl_ok0q_0;
    logic fl_ok0q_1;
    logic fl_ok1q_0;
    logic fl_ok1q_1;
    logic bev_q;
    logic [2:0] bevm_q;
    logic [3:0] bevwid_q;
    logic [15:0] bevtag_q;
    logic bevloc_q;
    logic bev_p;
    logic [2:0] bevm_p;
    logic [3:0] bevwid_p;
    logic [15:0] bevtag_p;
    logic bevloc_p;
    logic [31:0] c_req;
    logic [31:0] c_fill;
    logic [31:0] c_wt;
    logic [2:0] st_nreq_q;
    logic [1:0] st_nfill_q;
    logic st_nwt_q;
    logic [2:0] st_clr_q;
    logic [5:0] infl_occ;
    logic [5:0] rd_out;
    logic [4:0] rid_slot_0;
    logic [4:0] rid_slot_1;
    logic [3:0] rid_idx_0;
    logic [3:0] rid_idx_1;
    logic [1:0] bcnt_rd_0;
    logic [1:0] bcnt_rd_1;
    logic land_0;
    logic land_1;
    logic [7:0] tk_rd_0;
    logic [7:0] tk_rd_1;
    logic [3:0] fl_hd0_0;
    logic [3:0] fl_hd0_1;
    logic [3:0] fl_hd1_0;
    logic [3:0] fl_hd1_1;
    logic fl_pa_0;
    logic fl_pa_1;
    logic fl_pb_0;
    logic fl_pb_1;
    logic fl_push0_0;
    logic fl_push0_1;
    logic fl_push1_0;
    logic fl_push1_1;
    logic [1:0] fl_npush_0;
    logic [1:0] fl_npush_1;
    logic [4:0] fl_cp_0;
    logic [4:0] fl_cp_1;
    logic [4:0] fl_cp1_0;
    logic [4:0] fl_cp1_1;
    logic [4:0] fl_cp2_0;
    logic [4:0] fl_cp2_1;
    logic [4:0] fl_cnt_n_0;
    logic [4:0] fl_cnt_n_1;
    logic fl_ok0_n_0;
    logic fl_ok0_n_1;
    logic fl_ok1_n_0;
    logic fl_ok1_n_1;
    logic [3:0] fl_rp_n_0;
    logic [3:0] fl_rp_n_1;
    logic [3:0] fl_rp1_n_0;
    logic [3:0] fl_rp1_n_1;
    logic fl_z_0_0;
    logic fl_z_0_1;
    logic fl_z_0_2;
    logic fl_z_1_0;
    logic fl_z_1_1;
    logic fl_z_1_2;
    logic fl_t_0_0;
    logic fl_t_0_1;
    logic fl_t_0_2;
    logic fl_t_1_0;
    logic fl_t_1_1;
    logic fl_t_1_2;
    logic [3:0] fl_ra_0_0;
    logic [3:0] fl_ra_0_1;
    logic [3:0] fl_ra_1_0;
    logic [3:0] fl_ra_1_1;
    logic [3:0] fl_rb_0_0;
    logic [3:0] fl_rb_0_1;
    logic [3:0] fl_rb_1_0;
    logic [3:0] fl_rb_1_1;
    logic [1:0] n_ret;
    logic lane_pop_0;
    logic lane_pop_1;
    logic lane_pop_2;
    logic lane_pop_3;
    logic [4:0] asm_waddr_0;
    logic [4:0] asm_waddr_1;
    logic asm_frag_0;
    logic asm_frag_1;
    logic asm_we_0;
    logic asm_we_1;
    logic asm_we_2;
    logic asm_we_3;
    logic [4:0] ra_baddr;
    logic [4:0] rb_baddr;
    logic ra_ch;
    logic rb_ch;
    logic [1023:0] ra_word_0;
    logic [1023:0] ra_word_1;
    logic [1023:0] rb_word_0;
    logic [1023:0] rb_word_1;
    logic ar_can_0;
    logic ar_can_1;
    logic [1:0] argr_0_vec;
    logic [3:0] argr_0_dv;
    logic [1:0] argr_0_rot;
    logic argr_0_k;
    logic [1:0] argr_0_sum;
    logic [1:0] argr_0_mod;
    logic argr_0_idx;
    logic argr_0_any;
    logic [1:0] argr_1_vec;
    logic [3:0] argr_1_dv;
    logic [1:0] argr_1_rot;
    logic argr_1_k;
    logic [1:0] argr_1_sum;
    logic [1:0] argr_1_mod;
    logic argr_1_idx;
    logic argr_1_any;
    logic ar_go_0;
    logic ar_go_1;
    logic ar_idx_0;
    logic ar_idx_1;
    logic [39:0] ar_line_0;
    logic [39:0] ar_line_1;
    logic [4:0] ar_slot_0;
    logic [4:0] ar_slot_1;
    logic [7:0] ar_tk_0;
    logic [7:0] ar_tk_1;
    logic [3:0] ar_sidx_0;
    logic [3:0] ar_sidx_1;
    logic [1:0] ar_go_n;
    logic [1:0] land_n;
    logic wh_v;
    logic [2:0] wh_m;
    logic [3:0] wh_wid;
    logic [47:0] wh_addr;
    logic [8:0] wh_eoff;
    logic wh_last;
    logic [15:0] wh_tag;
    logic wh_loc;
    logic wh_nrw;
    logic [2:0] wh_nbeat_w;
    logic [2:0] wh_nbeat_n;
    logic [2:0] wh_nbeat;
    logic [2:0] wh_nbeat_m1;
    logic [3:0] wh_len;
    logic [47:0] wh_aw_addr;
    logic wh_ch;
    logic wo_full;
    logic aw_rdy;
    logic aw_can;
    logic aw_go;
    logic loc_go;
    logic wo_push;
    logic wc_m1;
    logic wc_0;
    logic wc_p1;
    logic wq_ok_n;
    logic [4:0] wcnt_inc;
    logic [4:0] wcnt_dec;
    logic wo_v;
    logic [2:0] wo_m;
    logic [3:0] wo_wid;
    logic wo_last;
    logic [15:0] wo_tag;
    logic wo_loc;
    logic [5:0] wo_sidx;
    logic wo_ch;
    logic w_lastb;
    logic wo_pop;
    logic [2:0] wn_nb;
    logic ho_ld_q;
    logic ho_ld_p;
    logic wq_tail;
    logic mw_rdy;
    logic wslot_free;
    logic wd_free;
    logic wq_ce;
    logic wq_adv;
    logic wh_ce;
    logic wd_ce;
    logic [1023:0] wt_bus_d;
    logic [127:0] wt_bus_s;
    logic wt_nrw;
    logic [1023:0] wt_data;
    logic [127:0] wt_strb;
    logic b_ok_sel;
    logic bev_infl;
    logic w_pre;
    logic w_room;
    logic w_can;
    logic wv_sel;
    logic [3:0] wid_sel;
    logic w_hit_0;
    logic w_hit_1;
    logic w_hit_2;
    logic w_hit_3;
    logic w_hit_4;
    logic w_take;
    logic [2:0] wo_wid3;
    logic [7:0] w_rpre_0;
    logic [7:0] w_rpre_1;
    logic [7:0] w_rpre_2;
    logic [7:0] w_rpre_3;
    logic [7:0] w_rpre_4;
    logic [5:0] clr_idx_s;
    logic [3:0] clr_idx;
    logic stat_clr;
    logic [2:0] n_req;
    logic u_lane_0_rq_ok;
    logic u_lane_1_rq_ok;
    logic u_lane_2_rq_ok;
    logic u_lane_3_rq_ok;
    logic [511:0] u_asm_a_1_rdata;
    logic [511:0] u_asm_a_0_rdata;
    logic [511:0] u_asm_b_1_rdata;
    logic [511:0] u_asm_b_0_rdata;
    logic [511:0] u_asm_a_3_rdata;
    logic [511:0] u_asm_a_2_rdata;
    logic [511:0] u_asm_b_3_rdata;
    logic [511:0] u_asm_b_2_rdata;
    logic u_lane_2_hv;
    logic u_lane_0_hv;
    logic [39:0] u_lane_0_h_line;
    logic [39:0] u_lane_2_h_line;
    logic [4:0] u_lane_0_h_slot;
    logic [4:0] u_lane_2_h_slot;
    logic [7:0] u_lane_0_h_tk;
    logic [7:0] u_lane_2_h_tk;
    logic u_lane_3_hv;
    logic u_lane_1_hv;
    logic [39:0] u_lane_1_h_line;
    logic [39:0] u_lane_3_h_line;
    logic [4:0] u_lane_1_h_slot;
    logic [4:0] u_lane_3_h_slot;
    logic [7:0] u_lane_1_h_tk;
    logic [7:0] u_lane_3_h_tk;
    logic u_lane_3_busy;
    logic u_lane_2_busy;
    logic u_lane_1_busy;
    logic u_lane_0_busy;

    assign m_0_b_ready = 1'd1;
    assign m_0_r_ready = 1'd1;
    assign m_1_b_ready = 1'd1;
    assign m_1_r_ready = 1'd1;
    assign rid_slot_0 = mr_id_0[4:0];
    assign rid_idx_0 = mr_id_0[3:0];
    assign bcnt_rd_0 = ((rid_idx_0 == 0) ? bcnt_0_0 :
                       ((rid_idx_0 == 1) ? bcnt_0_1 :
                       ((rid_idx_0 == 2) ? bcnt_0_2 :
                       ((rid_idx_0 == 3) ? bcnt_0_3 :
                       ((rid_idx_0 == 4) ? bcnt_0_4 :
                       ((rid_idx_0 == 5) ? bcnt_0_5 :
                       ((rid_idx_0 == 6) ? bcnt_0_6 :
                       ((rid_idx_0 == 7) ? bcnt_0_7 :
                       ((rid_idx_0 == 8) ? bcnt_0_8 :
                       ((rid_idx_0 == 9) ? bcnt_0_9 :
                       ((rid_idx_0 == 10) ? bcnt_0_10 :
                       ((rid_idx_0 == 11) ? bcnt_0_11 :
                       ((rid_idx_0 == 12) ? bcnt_0_12 :
                       ((rid_idx_0 == 13) ? bcnt_0_13 :
                       ((rid_idx_0 == 14) ? bcnt_0_14 :
                       bcnt_0_15)))))))))))))));
    assign land_0 = (mr_v_0 & mr_last_0);
    assign tk_rd_0 = tk_slot_0[rid_idx_0];
    assign rid_slot_1 = mr_id_1[4:0];
    assign rid_idx_1 = mr_id_1[3:0];
    assign bcnt_rd_1 = ((rid_idx_1 == 0) ? bcnt_1_0 :
                       ((rid_idx_1 == 1) ? bcnt_1_1 :
                       ((rid_idx_1 == 2) ? bcnt_1_2 :
                       ((rid_idx_1 == 3) ? bcnt_1_3 :
                       ((rid_idx_1 == 4) ? bcnt_1_4 :
                       ((rid_idx_1 == 5) ? bcnt_1_5 :
                       ((rid_idx_1 == 6) ? bcnt_1_6 :
                       ((rid_idx_1 == 7) ? bcnt_1_7 :
                       ((rid_idx_1 == 8) ? bcnt_1_8 :
                       ((rid_idx_1 == 9) ? bcnt_1_9 :
                       ((rid_idx_1 == 10) ? bcnt_1_10 :
                       ((rid_idx_1 == 11) ? bcnt_1_11 :
                       ((rid_idx_1 == 12) ? bcnt_1_12 :
                       ((rid_idx_1 == 13) ? bcnt_1_13 :
                       ((rid_idx_1 == 14) ? bcnt_1_14 :
                       bcnt_1_15)))))))))))))));
    assign land_1 = (mr_v_1 & mr_last_1);
    assign tk_rd_1 = tk_slot_1[rid_idx_1];
    assign fl_hd0_0 = ((fl_rp_0 == 0) ? fl_0_0 :
                      ((fl_rp_0 == 1) ? fl_0_1 :
                      ((fl_rp_0 == 2) ? fl_0_2 :
                      ((fl_rp_0 == 3) ? fl_0_3 :
                      ((fl_rp_0 == 4) ? fl_0_4 :
                      ((fl_rp_0 == 5) ? fl_0_5 :
                      ((fl_rp_0 == 6) ? fl_0_6 :
                      ((fl_rp_0 == 7) ? fl_0_7 :
                      ((fl_rp_0 == 8) ? fl_0_8 :
                      ((fl_rp_0 == 9) ? fl_0_9 :
                      ((fl_rp_0 == 10) ? fl_0_10 :
                      ((fl_rp_0 == 11) ? fl_0_11 :
                      ((fl_rp_0 == 12) ? fl_0_12 :
                      ((fl_rp_0 == 13) ? fl_0_13 :
                      ((fl_rp_0 == 14) ? fl_0_14 :
                      fl_0_15)))))))))))))));
    assign fl_hd1_0 = ((fl_rp1_0 == 0) ? fl_0_0 :
                      ((fl_rp1_0 == 1) ? fl_0_1 :
                      ((fl_rp1_0 == 2) ? fl_0_2 :
                      ((fl_rp1_0 == 3) ? fl_0_3 :
                      ((fl_rp1_0 == 4) ? fl_0_4 :
                      ((fl_rp1_0 == 5) ? fl_0_5 :
                      ((fl_rp1_0 == 6) ? fl_0_6 :
                      ((fl_rp1_0 == 7) ? fl_0_7 :
                      ((fl_rp1_0 == 8) ? fl_0_8 :
                      ((fl_rp1_0 == 9) ? fl_0_9 :
                      ((fl_rp1_0 == 10) ? fl_0_10 :
                      ((fl_rp1_0 == 11) ? fl_0_11 :
                      ((fl_rp1_0 == 12) ? fl_0_12 :
                      ((fl_rp1_0 == 13) ? fl_0_13 :
                      ((fl_rp1_0 == 14) ? fl_0_14 :
                      fl_0_15)))))))))))))));
    assign ent_asm_ok0_c0 = fl_ok0q_0;
    assign ent_asm_s0_c0 = {1'd0, fl_hd0_0};
    assign ent_asm_ok1_c0 = fl_ok1q_0;
    assign ent_asm_s1_c0 = {1'd0, fl_hd1_0};
    assign fl_pa_0 = ent_asm_pa_c0;
    assign fl_pb_0 = ent_asm_pb_c0;
    assign fl_push0_0 = (ent_ed0_v & (ent_ed0_slot[4] == 0));
    assign fl_push1_0 = (ent_ed1_v & (ent_ed1_slot[4] == 0));
    assign fl_npush_0 = ({1'd0, fl_push0_0} + {1'd0, fl_push1_0});
    assign fl_cp_0 = (fl_cnt_0 + {3'd0, fl_npush_0});
    assign fl_cp1_0 = (fl_cp_0 - 1);
    assign fl_cp2_0 = (fl_cp_0 - 2);
    assign fl_z_0_0 = (fl_cp_0 != 0);
    assign fl_z_0_1 = (fl_cp1_0 != 0);
    assign fl_z_0_2 = (fl_cp2_0 != 0);
    assign fl_t_0_0 = (fl_cp_0[4:1] != 0);
    assign fl_t_0_1 = (fl_cp1_0[4:1] != 0);
    assign fl_t_0_2 = (fl_cp2_0[4:1] != 0);
    assign fl_ra_0_0 = (fl_rp_0 + 1);
    assign fl_ra_0_1 = (fl_rp_0 + 2);
    assign fl_rb_0_0 = (fl_rp1_0 + 1);
    assign fl_rb_0_1 = (fl_rp1_0 + 2);
    assign fl_cnt_n_0 = ((fl_pa_0 & fl_pb_0) ? fl_cp2_0 : ((fl_pa_0 | fl_pb_0) ? fl_cp1_0 : fl_cp_0));
    assign fl_ok0_n_0 = ((fl_pa_0 & fl_pb_0) ? fl_z_0_2 : ((fl_pa_0 | fl_pb_0) ? fl_z_0_1 : fl_z_0_0));
    assign fl_ok1_n_0 = ((fl_pa_0 & fl_pb_0) ? fl_t_0_2 : ((fl_pa_0 | fl_pb_0) ? fl_t_0_1 : fl_t_0_0));
    assign fl_rp_n_0 = ((fl_pa_0 & fl_pb_0) ? fl_ra_0_1 : ((fl_pa_0 | fl_pb_0) ? fl_ra_0_0 : fl_rp_0));
    assign fl_rp1_n_0 = ((fl_pa_0 & fl_pb_0) ? fl_rb_0_1 : ((fl_pa_0 | fl_pb_0) ? fl_rb_0_0 : fl_rp1_0));
    assign fl_hd0_1 = ((fl_rp_1 == 0) ? fl_1_0 :
                      ((fl_rp_1 == 1) ? fl_1_1 :
                      ((fl_rp_1 == 2) ? fl_1_2 :
                      ((fl_rp_1 == 3) ? fl_1_3 :
                      ((fl_rp_1 == 4) ? fl_1_4 :
                      ((fl_rp_1 == 5) ? fl_1_5 :
                      ((fl_rp_1 == 6) ? fl_1_6 :
                      ((fl_rp_1 == 7) ? fl_1_7 :
                      ((fl_rp_1 == 8) ? fl_1_8 :
                      ((fl_rp_1 == 9) ? fl_1_9 :
                      ((fl_rp_1 == 10) ? fl_1_10 :
                      ((fl_rp_1 == 11) ? fl_1_11 :
                      ((fl_rp_1 == 12) ? fl_1_12 :
                      ((fl_rp_1 == 13) ? fl_1_13 :
                      ((fl_rp_1 == 14) ? fl_1_14 :
                      fl_1_15)))))))))))))));
    assign fl_hd1_1 = ((fl_rp1_1 == 0) ? fl_1_0 :
                      ((fl_rp1_1 == 1) ? fl_1_1 :
                      ((fl_rp1_1 == 2) ? fl_1_2 :
                      ((fl_rp1_1 == 3) ? fl_1_3 :
                      ((fl_rp1_1 == 4) ? fl_1_4 :
                      ((fl_rp1_1 == 5) ? fl_1_5 :
                      ((fl_rp1_1 == 6) ? fl_1_6 :
                      ((fl_rp1_1 == 7) ? fl_1_7 :
                      ((fl_rp1_1 == 8) ? fl_1_8 :
                      ((fl_rp1_1 == 9) ? fl_1_9 :
                      ((fl_rp1_1 == 10) ? fl_1_10 :
                      ((fl_rp1_1 == 11) ? fl_1_11 :
                      ((fl_rp1_1 == 12) ? fl_1_12 :
                      ((fl_rp1_1 == 13) ? fl_1_13 :
                      ((fl_rp1_1 == 14) ? fl_1_14 :
                      fl_1_15)))))))))))))));
    assign ent_asm_ok0_c1 = fl_ok0q_1;
    assign ent_asm_s0_c1 = {1'd1, fl_hd0_1};
    assign ent_asm_ok1_c1 = fl_ok1q_1;
    assign ent_asm_s1_c1 = {1'd1, fl_hd1_1};
    assign fl_pa_1 = ent_asm_pa_c1;
    assign fl_pb_1 = ent_asm_pb_c1;
    assign fl_push0_1 = (ent_ed0_v & (ent_ed0_slot[4] == 1));
    assign fl_push1_1 = (ent_ed1_v & (ent_ed1_slot[4] == 1));
    assign fl_npush_1 = ({1'd0, fl_push0_1} + {1'd0, fl_push1_1});
    assign fl_cp_1 = (fl_cnt_1 + {3'd0, fl_npush_1});
    assign fl_cp1_1 = (fl_cp_1 - 1);
    assign fl_cp2_1 = (fl_cp_1 - 2);
    assign fl_z_1_0 = (fl_cp_1 != 0);
    assign fl_z_1_1 = (fl_cp1_1 != 0);
    assign fl_z_1_2 = (fl_cp2_1 != 0);
    assign fl_t_1_0 = (fl_cp_1[4:1] != 0);
    assign fl_t_1_1 = (fl_cp1_1[4:1] != 0);
    assign fl_t_1_2 = (fl_cp2_1[4:1] != 0);
    assign fl_ra_1_0 = (fl_rp_1 + 1);
    assign fl_ra_1_1 = (fl_rp_1 + 2);
    assign fl_rb_1_0 = (fl_rp1_1 + 1);
    assign fl_rb_1_1 = (fl_rp1_1 + 2);
    assign fl_cnt_n_1 = ((fl_pa_1 & fl_pb_1) ? fl_cp2_1 : ((fl_pa_1 | fl_pb_1) ? fl_cp1_1 : fl_cp_1));
    assign fl_ok0_n_1 = ((fl_pa_1 & fl_pb_1) ? fl_z_1_2 : ((fl_pa_1 | fl_pb_1) ? fl_z_1_1 : fl_z_1_0));
    assign fl_ok1_n_1 = ((fl_pa_1 & fl_pb_1) ? fl_t_1_2 : ((fl_pa_1 | fl_pb_1) ? fl_t_1_1 : fl_t_1_0));
    assign fl_rp_n_1 = ((fl_pa_1 & fl_pb_1) ? fl_ra_1_1 : ((fl_pa_1 | fl_pb_1) ? fl_ra_1_0 : fl_rp_1));
    assign fl_rp1_n_1 = ((fl_pa_1 & fl_pb_1) ? fl_rb_1_1 : ((fl_pa_1 | fl_pb_1) ? fl_rb_1_0 : fl_rp1_1));
    assign n_ret = ({1'd0, ent_ed0_v} + {1'd0, ent_ed1_v});
    assign ent_rq0_ok = u_lane_0_rq_ok;
    assign ent_rq1_ok = u_lane_1_rq_ok;
    assign ent_rq2_ok = u_lane_2_rq_ok;
    assign ent_rq3_ok = u_lane_3_rq_ok;
    assign asm_waddr_0 = {rid_idx_0, bcnt_rd_0[1]};
    assign asm_frag_0 = bcnt_rd_0[0];
    assign asm_we_0 = (mr_v_0 & (asm_frag_0 == 0));
    assign asm_we_1 = (mr_v_0 & (asm_frag_0 == 1));
    assign asm_waddr_1 = {rid_idx_1, bcnt_rd_1[1]};
    assign asm_frag_1 = bcnt_rd_1[0];
    assign asm_we_2 = (mr_v_1 & (asm_frag_1 == 0));
    assign asm_we_3 = (mr_v_1 & (asm_frag_1 == 1));
    assign ra_baddr = ent_ra_addr[4:0];
    assign rb_baddr = ent_rb_addr[4:0];
    assign ra_ch = ent_ra_addr[5];
    assign rb_ch = ent_rb_addr[5];
    assign ra_word_0 = {u_asm_a_1_rdata, u_asm_a_0_rdata};
    assign rb_word_0 = {u_asm_b_1_rdata, u_asm_b_0_rdata};
    assign ra_word_1 = {u_asm_a_3_rdata, u_asm_a_2_rdata};
    assign rb_word_1 = {u_asm_b_3_rdata, u_asm_b_2_rdata};
    assign ent_ra_data = ((ra_ch_q == 0) ? ra_word_0 : ra_word_1);
    assign ent_rb_data = ((rb_ch_q == 0) ? rb_word_0 : rb_word_1);
    assign ar_can_0 = ((~ar_v_0) | m_0_ar_ready);
    assign argr_0_vec = {u_lane_2_hv, u_lane_0_hv};
    assign argr_0_dv = ({2{argr_0_vec}} >> ar_rr_0);
    assign argr_0_rot = argr_0_dv[1:0];
    assign argr_0_k = (argr_0_rot[0] ? 1'd0 : (argr_0_rot[1] ? 1'd1 : 1'd0));
    assign argr_0_sum = ({1'd0, ar_rr_0} + {1'd0, argr_0_k});
    assign argr_0_mod = ((argr_0_sum >= 2) ? (argr_0_sum - 2) : argr_0_sum);
    assign argr_0_idx = argr_0_mod[0];
    assign argr_0_any = (argr_0_rot[0] | argr_0_rot[1]);
    assign ar_go_0 = (argr_0_any & ar_can_0);
    assign ar_idx_0 = argr_0_idx;
    assign ar_line_0 = ((ar_idx_0 == 0) ? u_lane_0_h_line : u_lane_2_h_line);
    assign ar_slot_0 = ((ar_idx_0 == 0) ? u_lane_0_h_slot : u_lane_2_h_slot);
    assign ar_tk_0 = ((ar_idx_0 == 0) ? u_lane_0_h_tk : u_lane_2_h_tk);
    assign ar_sidx_0 = ar_slot_0[3:0];
    assign m_0_ar_valid = ar_v_0;
    assign m_0_ar_id = ar_id_0;
    assign m_0_ar_addr = ar_addr_0;
    assign m_0_ar_len = 8'd3;
    assign ar_can_1 = ((~ar_v_1) | m_1_ar_ready);
    assign argr_1_vec = {u_lane_3_hv, u_lane_1_hv};
    assign argr_1_dv = ({2{argr_1_vec}} >> ar_rr_1);
    assign argr_1_rot = argr_1_dv[1:0];
    assign argr_1_k = (argr_1_rot[0] ? 1'd0 : (argr_1_rot[1] ? 1'd1 : 1'd0));
    assign argr_1_sum = ({1'd0, ar_rr_1} + {1'd0, argr_1_k});
    assign argr_1_mod = ((argr_1_sum >= 2) ? (argr_1_sum - 2) : argr_1_sum);
    assign argr_1_idx = argr_1_mod[0];
    assign argr_1_any = (argr_1_rot[0] | argr_1_rot[1]);
    assign ar_go_1 = (argr_1_any & ar_can_1);
    assign ar_idx_1 = argr_1_idx;
    assign ar_line_1 = ((ar_idx_1 == 0) ? u_lane_1_h_line : u_lane_3_h_line);
    assign ar_slot_1 = ((ar_idx_1 == 0) ? u_lane_1_h_slot : u_lane_3_h_slot);
    assign ar_tk_1 = ((ar_idx_1 == 0) ? u_lane_1_h_tk : u_lane_3_h_tk);
    assign ar_sidx_1 = ar_slot_1[3:0];
    assign m_1_ar_valid = ar_v_1;
    assign m_1_ar_id = ar_id_1;
    assign m_1_ar_addr = ar_addr_1;
    assign m_1_ar_len = 8'd3;
    assign lane_pop_0 = (ar_go_0 & (ar_idx_0 == 0));
    assign lane_pop_1 = (ar_go_1 & (ar_idx_1 == 0));
    assign lane_pop_2 = (ar_go_0 & (ar_idx_0 == 1));
    assign lane_pop_3 = (ar_go_1 & (ar_idx_1 == 1));
    assign ar_go_n = ({1'd0, ar_go_0} + {1'd0, ar_go_1});
    assign land_n = ({1'd0, land_0} + {1'd0, land_1});
    assign ent_wq_ok = wq_okq;
    assign wh_v = (wcnt != 0);
    assign wh_m = wqm[wrp];
    assign wh_wid = wqwid[wrp];
    assign wh_addr = wqaddr[wrp];
    assign wh_eoff = wqeoff[wrp];
    assign wh_last = wqlast[wrp];
    assign wh_tag = wqtag[wrp];
    assign wh_loc = wqloc[wrp];
    assign wh_nrw = ((1'd0 | (wh_m == 1)) | (wh_m == 2));
    assign wh_nbeat_w = (({1'd0, wh_eoff[8:7]} + {2'd0, (wh_eoff[6:0] != 0)}) - {2'd0, wh_addr[7]});
    assign wh_nbeat_n = ((wh_eoff[8:6] + {2'd0, (wh_eoff[5:0] != 0)}) - {1'd0, wh_addr[7:6]});
    assign wh_nbeat = (wh_nrw ? wh_nbeat_n : wh_nbeat_w);
    assign wh_nbeat_m1 = (wh_nbeat - 1);
    assign wh_len = (wh_nrw ? {1'd0, wh_nbeat_m1} : {wh_nbeat_m1[1:0], 1'd1});
    assign wh_aw_addr = (wh_nrw ? {wh_addr[47:6], 6'd0} : {wh_addr[47:7], 7'd0});
    assign wh_ch = wh_addr[8];
    assign wo_full = (ocnt == 4);
    assign aw_rdy = ((aw_ch == 0) ? m_0_aw_ready : m_1_aw_ready);
    assign aw_can = ((~aw_v) | aw_rdy);
    assign aw_go = (((wh_v & (~wh_loc)) & aw_can) & (~wo_full));
    assign loc_go = ((wh_v & wh_loc) & (~wo_full));
    assign wo_push = (aw_go | loc_go);
    assign wc_m1 = (wcnt != 15);
    assign wc_0 = (wcnt != 16);
    assign wc_p1 = (wcnt != 17);
    assign wq_ok_n = ((ent_wq_push & (~wo_push)) ? wc_m1 : ((wo_push & (~ent_wq_push)) ? wc_p1 : wc_0));
    assign wcnt_inc = (wcnt + 1);
    assign wcnt_dec = (wcnt - 1);
    assign m_0_aw_valid = aw_vc_0;
    assign m_0_aw_id = aw_id;
    assign m_0_aw_addr = aw_addr;
    assign m_0_aw_len = aw_len;
    assign m_1_aw_valid = aw_vc_1;
    assign m_1_aw_id = aw_id;
    assign m_1_aw_addr = aw_addr;
    assign m_1_aw_len = aw_len;
    assign wo_v = (ocnt != 0);
    assign wo_m = ho_m;
    assign wo_wid = ho_wid;
    assign wo_last = ho_last;
    assign wo_tag = ho_tag;
    assign wo_loc = ho_loc;
    assign wo_sidx = ho_sidx;
    assign wo_ch = ho_ch;
    assign w_lastb = (wbk == ho_nbm1);
    assign wo_pop = (w_take & w_lastb);
    assign wn_nb = wonb[orp1];
    assign ho_ld_q = (wo_pop & (ocnt >= 2));
    assign ho_ld_p = (wo_push & ((ocnt == 0) | (wo_pop & (ocnt == 1))));
    assign wq_tail = (~wq_more);
    assign mw_rdy = ((wq_ch == 0) ? m_0_w_ready : m_1_w_ready);
    assign wslot_free = ((~wq_v) | (mw_rdy & wq_tail));
    assign wd_free = ((~wd_v) | wslot_free);
    assign wq_ce = ((~wq_v) | mw_rdy);
    assign wq_adv = (wq_v & wq_more);
    assign wh_ce = (~(wq_v & wq_more));
    assign wd_ce = wd_free;
    assign wt_bus_d = ((wt_m == 0) ? w_0_data :
                      ((wt_m == 1) ? w_1_data :
                      ((wt_m == 2) ? w_2_data :
                      ((wt_m == 3) ? w_3_data :
                      w_4_data))));
    assign wt_bus_s = ((wt_m == 0) ? w_0_strb :
                      ((wt_m == 1) ? w_1_strb :
                      ((wt_m == 2) ? w_2_strb :
                      ((wt_m == 3) ? w_3_strb :
                      w_4_strb))));
    assign wt_nrw = ((1'd0 | (wt_m == 1)) | (wt_m == 2));
    assign wt_data = (wt_held ? wt_dat : wt_bus_d);
    assign wt_strb = (wt_held ? wt_stb : wt_bus_s);
    assign b_ok_sel = ((ho_moh & {ent_b_ok4, ent_b_ok3, ent_b_ok2, ent_b_ok1, ent_b_ok0}) != 0);
    assign bev_infl = ((bev_p & (bevm_p == wo_m)) | (bev_q & (bevm_q == wo_m)));
    assign w_pre = (wo_v & (~((w_lastb & wo_last) & ((~b_ok_sel) | bev_infl))));
    assign w_room = (((wo_loc | (~wt_v)) | (~wd_v)) | (~wq_v));
    assign w_can = (w_pre & (w_room | (wq_tail & mw_rdy)));
    assign wv_sel = ((wo_m == 0) ? w_0_valid :
                    ((wo_m == 1) ? w_1_valid :
                    ((wo_m == 2) ? w_2_valid :
                    ((wo_m == 3) ? w_3_valid :
                    w_4_valid))));
    assign wid_sel = ((wo_m == 0) ? w_0_id :
                     ((wo_m == 1) ? w_1_id :
                     ((wo_m == 2) ? w_2_id :
                     ((wo_m == 3) ? w_3_id :
                     w_4_id))));
    assign w_hit_0 = (w_0_valid & (w_0_id == wo_wid));
    assign w_hit_1 = (w_1_valid & (w_1_id == wo_wid));
    assign w_hit_2 = (w_2_valid & (w_2_id == wo_wid));
    assign w_hit_3 = (w_3_valid & (w_3_id == wo_wid));
    assign w_hit_4 = (w_4_valid & (w_4_id == wo_wid));
    assign w_take = (w_can & ((ho_moh & {w_hit_4, w_hit_3, w_hit_2, w_hit_1, w_hit_0}) != 0));
    assign wo_wid3 = wo_wid[2:0];
    assign w_rpre_0 = ((w_pre & ho_moh[0]) ? (8'd1 << wo_wid3) : 8'd0);
    assign w_0_ready = ((w_room | (wq_tail & mw_rdy)) ? w_rpre_0 : 8'd0);
    assign w_rpre_1 = ((w_pre & ho_moh[1]) ? (8'd1 << wo_wid3) : 8'd0);
    assign w_1_ready = ((w_room | (wq_tail & mw_rdy)) ? w_rpre_1 : 8'd0);
    assign w_rpre_2 = ((w_pre & ho_moh[2]) ? (8'd1 << wo_wid3) : 8'd0);
    assign w_2_ready = ((w_room | (wq_tail & mw_rdy)) ? w_rpre_2 : 8'd0);
    assign w_rpre_3 = ((w_pre & ho_moh[3]) ? (8'd1 << wo_wid3) : 8'd0);
    assign w_3_ready = ((w_room | (wq_tail & mw_rdy)) ? w_rpre_3 : 8'd0);
    assign w_rpre_4 = ((w_pre & ho_moh[4]) ? (8'd1 << wo_wid3) : 8'd0);
    assign w_4_ready = ((w_room | (wq_tail & mw_rdy)) ? w_rpre_4 : 8'd0);
    assign m_0_w_valid = wq_vc_0;
    assign m_0_w_data = wq_sd;
    assign m_0_w_strb = wq_ss;
    assign m_0_w_last = (wq_last_q & wq_tail);
    assign m_1_w_valid = wq_vc_1;
    assign m_1_w_data = wq_sd;
    assign m_1_w_strb = wq_ss;
    assign m_1_w_last = (wq_last_q & wq_tail);
    assign clr_idx_s = (wo_sidx - 8);
    assign clr_idx = clr_idx_s[3:0];
    assign stat_clr = ((((w_take & wo_loc) & (wbk == 0)) & (wo_sidx >= 8)) & (wo_sidx < 24));
    assign n_req = ({2'd0, ent_asm_rv0} + {2'd0, ent_asm_rv1});
    assign ent_wk0_v = wkv_q_0;
    assign ent_wk0_tk = wktk_q_0;
    assign ent_wk0_asl = wkasl_q_0;
    assign ent_wk1_v = wkv_q_1;
    assign ent_wk1_tk = wktk_q_1;
    assign ent_wk1_asl = wkasl_q_1;
    assign ent_bev_v = bev_q;
    assign ent_bev_m = bevm_q;
    assign ent_bev_wid = bevwid_q;
    assign ent_bev_tag = bevtag_q;
    assign ent_bev_loc = bevloc_q;
    assign st_req = c_req;
    assign st_fill = c_fill;
    assign st_wt = c_wt;
    assign dbg_infl_occ = infl_occ;
    assign dbg_rd_out = rd_out;
    assign dbg_asm_occ = ((6'd32 - {1'd0, fl_cnt_0}) - {1'd0, fl_cnt_1});
    assign dbg_lane_busy = {u_lane_3_busy, u_lane_2_busy, u_lane_1_busy, u_lane_0_busy};
    assign dbg_idle = ((((((((((((((((~aw_v) & (~wq_v)) & (~wt_v)) & (~wd_v)) & (~bev_p)) & (wcnt == 0)) & (ocnt == 0))
                       & (rd_out == 0)) & (fl_cnt_0 == 16)) & (fl_cnt_1 == 16)) & (~ar_v_0)) & (~ar_v_1))
                       & (~u_lane_0_busy)) & (~u_lane_1_busy)) & (~u_lane_2_busy)) & (~u_lane_3_busy));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ar_rr_0 <= 0;
            wkv_q_0 <= 0;
            wktk_q_0 <= 0;
            wkasl_q_0 <= 0;
            ar_rr_1 <= 0;
            wkv_q_1 <= 0;
            wktk_q_1 <= 0;
            wkasl_q_1 <= 0;
            ra_ch_q <= 0;
            rb_ch_q <= 0;
            fl_0_0 <= 0;
            fl_0_1 <= 1;
            fl_0_2 <= 2;
            fl_0_3 <= 3;
            fl_0_4 <= 4;
            fl_0_5 <= 5;
            fl_0_6 <= 6;
            fl_0_7 <= 7;
            fl_0_8 <= 8;
            fl_0_9 <= 9;
            fl_0_10 <= 10;
            fl_0_11 <= 11;
            fl_0_12 <= 12;
            fl_0_13 <= 13;
            fl_0_14 <= 14;
            fl_0_15 <= 15;
            fl_rp_0 <= 0;
            fl_rp1_0 <= 1;
            fl_wp_0 <= 0;
            fl_wp1_0 <= 1;
            fl_cnt_0 <= 16;
            fl_ok0q_0 <= 1;
            fl_ok1q_0 <= 1;
            fl_1_0 <= 0;
            fl_1_1 <= 1;
            fl_1_2 <= 2;
            fl_1_3 <= 3;
            fl_1_4 <= 4;
            fl_1_5 <= 5;
            fl_1_6 <= 6;
            fl_1_7 <= 7;
            fl_1_8 <= 8;
            fl_1_9 <= 9;
            fl_1_10 <= 10;
            fl_1_11 <= 11;
            fl_1_12 <= 12;
            fl_1_13 <= 13;
            fl_1_14 <= 14;
            fl_1_15 <= 15;
            fl_rp_1 <= 0;
            fl_rp1_1 <= 1;
            fl_wp_1 <= 0;
            fl_wp1_1 <= 1;
            fl_cnt_1 <= 16;
            fl_ok0q_1 <= 1;
            fl_ok1q_1 <= 1;
            ar_v_0 <= 0;
            ar_id_0 <= 0;
            ar_addr_0 <= 0;
            ar_v_1 <= 0;
            ar_id_1 <= 0;
            ar_addr_1 <= 0;
            wwp <= 0;
            wrp <= 0;
            owp <= 0;
            ho_m <= 0;
            ho_moh <= 0;
            ho_wid <= 0;
            ho_nbm1 <= 0;
            ho_last <= 0;
            ho_tag <= 0;
            ho_loc <= 0;
            ho_sidx <= 0;
            ho_ch <= 0;
            wcnt <= 0;
            wq_okq <= 1;
            aw_v <= 0;
            aw_id <= 0;
            aw_addr <= 0;
            aw_len <= 0;
            aw_ch <= 0;
            wt_id <= 0;
            aw_vc_0 <= 0;
            aw_vc_1 <= 0;
            wq_v <= 0;
            wq_more <= 0;
            wq_last_q <= 0;
            wq_ch <= 0;
            wq_vc_0 <= 0;
            wq_vc_1 <= 0;
            wd_v <= 0;
            wd_last <= 0;
            wd_nrw <= 0;
            wd_ch <= 0;
            wt_held <= 0;
            wt_v <= 0;
            wt_m <= 0;
            wt_last <= 0;
            wt_ch <= 0;
            bev_p <= 0;
            wbk <= 0;
            orp <= 0;
            orp1 <= 1;
            bevm_p <= 0;
            bevwid_p <= 0;
            bevtag_p <= 0;
            bevloc_p <= 0;
            ocnt <= 0;
            bev_q <= 0;
            bevm_q <= 0;
            bevwid_q <= 0;
            bevtag_q <= 0;
            bevloc_q <= 0;
            mr_v_0 <= 0;
            mr_id_0 <= 0;
            mr_last_0 <= 0;
            bcnt_0_0 <= 0;
            bcnt_0_1 <= 0;
            bcnt_0_2 <= 0;
            bcnt_0_3 <= 0;
            bcnt_0_4 <= 0;
            bcnt_0_5 <= 0;
            bcnt_0_6 <= 0;
            bcnt_0_7 <= 0;
            bcnt_0_8 <= 0;
            bcnt_0_9 <= 0;
            bcnt_0_10 <= 0;
            bcnt_0_11 <= 0;
            bcnt_0_12 <= 0;
            bcnt_0_13 <= 0;
            bcnt_0_14 <= 0;
            bcnt_0_15 <= 0;
            asw_we_a_0 <= 0;
            asw_we_b_0 <= 0;
            asw_we_a_1 <= 0;
            asw_we_b_1 <= 0;
            mr_v_1 <= 0;
            mr_id_1 <= 0;
            mr_last_1 <= 0;
            bcnt_1_0 <= 0;
            bcnt_1_1 <= 0;
            bcnt_1_2 <= 0;
            bcnt_1_3 <= 0;
            bcnt_1_4 <= 0;
            bcnt_1_5 <= 0;
            bcnt_1_6 <= 0;
            bcnt_1_7 <= 0;
            bcnt_1_8 <= 0;
            bcnt_1_9 <= 0;
            bcnt_1_10 <= 0;
            bcnt_1_11 <= 0;
            bcnt_1_12 <= 0;
            bcnt_1_13 <= 0;
            bcnt_1_14 <= 0;
            bcnt_1_15 <= 0;
            asw_we_a_2 <= 0;
            asw_we_b_2 <= 0;
            asw_we_a_3 <= 0;
            asw_we_b_3 <= 0;
            rd_out <= 0;
            infl_occ <= 0;
            st_nreq_q <= 0;
            st_nfill_q <= 0;
            st_nwt_q <= 0;
            st_clr_q <= 0;
            c_req <= 0;
            c_fill <= 0;
            c_wt <= 0;
        end else begin
            if (ar_go_0) begin
                ar_rr_0 <= (ar_idx_0 + 1);
            end
            wkv_q_0 <= land_0;
            wktk_q_0 <= tk_rd_0;
            wkasl_q_0 <= rid_slot_0;
            if (ar_go_1) begin
                ar_rr_1 <= (ar_idx_1 + 1);
            end
            wkv_q_1 <= land_1;
            wktk_q_1 <= tk_rd_1;
            wkasl_q_1 <= rid_slot_1;
            if (ent_ra_en) begin
                ra_ch_q <= ra_ch;
            end
            if (ent_rb_en) begin
                rb_ch_q <= rb_ch;
            end
            if ((fl_push0_0 & (fl_wp_0 == 0))) begin
                fl_0_0 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 0))) begin
                fl_0_0 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 1))) begin
                fl_0_1 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 1))) begin
                fl_0_1 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 2))) begin
                fl_0_2 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 2))) begin
                fl_0_2 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 3))) begin
                fl_0_3 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 3))) begin
                fl_0_3 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 4))) begin
                fl_0_4 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 4))) begin
                fl_0_4 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 5))) begin
                fl_0_5 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 5))) begin
                fl_0_5 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 6))) begin
                fl_0_6 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 6))) begin
                fl_0_6 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 7))) begin
                fl_0_7 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 7))) begin
                fl_0_7 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 8))) begin
                fl_0_8 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 8))) begin
                fl_0_8 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 9))) begin
                fl_0_9 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 9))) begin
                fl_0_9 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 10))) begin
                fl_0_10 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 10))) begin
                fl_0_10 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 11))) begin
                fl_0_11 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 11))) begin
                fl_0_11 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 12))) begin
                fl_0_12 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 12))) begin
                fl_0_12 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 13))) begin
                fl_0_13 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 13))) begin
                fl_0_13 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 14))) begin
                fl_0_14 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 14))) begin
                fl_0_14 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_0 & (fl_wp_0 == 15))) begin
                fl_0_15 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_0 & ((fl_push0_0 ? fl_wp1_0 : fl_wp_0) == 15))) begin
                fl_0_15 <= ent_ed1_slot[3:0];
            end
            fl_rp_0 <= fl_rp_n_0;
            fl_rp1_0 <= fl_rp1_n_0;
            fl_wp_0 <= (fl_wp_0 + {2'd0, fl_npush_0});
            fl_wp1_0 <= (fl_wp1_0 + {2'd0, fl_npush_0});
            fl_cnt_0 <= fl_cnt_n_0;
            fl_ok0q_0 <= fl_ok0_n_0;
            fl_ok1q_0 <= fl_ok1_n_0;
            if ((fl_push0_1 & (fl_wp_1 == 0))) begin
                fl_1_0 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 0))) begin
                fl_1_0 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 1))) begin
                fl_1_1 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 1))) begin
                fl_1_1 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 2))) begin
                fl_1_2 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 2))) begin
                fl_1_2 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 3))) begin
                fl_1_3 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 3))) begin
                fl_1_3 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 4))) begin
                fl_1_4 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 4))) begin
                fl_1_4 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 5))) begin
                fl_1_5 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 5))) begin
                fl_1_5 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 6))) begin
                fl_1_6 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 6))) begin
                fl_1_6 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 7))) begin
                fl_1_7 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 7))) begin
                fl_1_7 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 8))) begin
                fl_1_8 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 8))) begin
                fl_1_8 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 9))) begin
                fl_1_9 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 9))) begin
                fl_1_9 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 10))) begin
                fl_1_10 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 10))) begin
                fl_1_10 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 11))) begin
                fl_1_11 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 11))) begin
                fl_1_11 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 12))) begin
                fl_1_12 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 12))) begin
                fl_1_12 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 13))) begin
                fl_1_13 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 13))) begin
                fl_1_13 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 14))) begin
                fl_1_14 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 14))) begin
                fl_1_14 <= ent_ed1_slot[3:0];
            end
            if ((fl_push0_1 & (fl_wp_1 == 15))) begin
                fl_1_15 <= ent_ed0_slot[3:0];
            end
            if ((fl_push1_1 & ((fl_push0_1 ? fl_wp1_1 : fl_wp_1) == 15))) begin
                fl_1_15 <= ent_ed1_slot[3:0];
            end
            fl_rp_1 <= fl_rp_n_1;
            fl_rp1_1 <= fl_rp1_n_1;
            fl_wp_1 <= (fl_wp_1 + {2'd0, fl_npush_1});
            fl_wp1_1 <= (fl_wp1_1 + {2'd0, fl_npush_1});
            fl_cnt_1 <= fl_cnt_n_1;
            fl_ok0q_1 <= fl_ok0_n_1;
            fl_ok1q_1 <= fl_ok1_n_1;
            if (ar_go_0) begin
                ar_v_0 <= 1;
                ar_id_0 <= {3'd0, ar_slot_0};
                ar_addr_0 <= {ar_line_0, 8'd0};
            end else begin
                if (m_0_ar_ready) begin
                    ar_v_0 <= 0;
                end
            end
            if (ar_go_1) begin
                ar_v_1 <= 1;
                ar_id_1 <= {3'd0, ar_slot_1};
                ar_addr_1 <= {ar_line_1, 8'd0};
            end else begin
                if (m_1_ar_ready) begin
                    ar_v_1 <= 0;
                end
            end
            if (ent_wq_push) begin
                wwp <= (wwp + 1);
            end
            if (wo_push) begin
                wrp <= (wrp + 1);
                owp <= (owp + 1);
            end
            if (ho_ld_p) begin
                ho_m <= wh_m;
                ho_moh <= (5'd1 << wh_m);
                ho_wid <= wh_wid;
                ho_nbm1 <= (wh_nbeat - 1);
                ho_last <= wh_last;
                ho_tag <= wh_tag;
                ho_loc <= wh_loc;
                ho_sidx <= wh_addr[7:2];
                ho_ch <= wh_ch;
            end else begin
                if (ho_ld_q) begin
                    ho_m <= wom[orp1];
                    ho_moh <= (5'd1 << wom[orp1]);
                    ho_wid <= wowid[orp1];
                    ho_nbm1 <= (wn_nb - 1);
                    ho_last <= wolast[orp1];
                    ho_tag <= wotag[orp1];
                    ho_loc <= woloc[orp1];
                    ho_sidx <= wosidx[orp1];
                    ho_ch <= woch[orp1];
                end
            end
            if ((ent_wq_push & (~wo_push))) begin
                wcnt <= wcnt_inc;
            end else begin
                if ((wo_push & (~ent_wq_push))) begin
                    wcnt <= wcnt_dec;
                end
            end
            wq_okq <= wq_ok_n;
            if (aw_go) begin
                aw_v <= 1;
                aw_id <= {2'd1, wt_id};
                aw_addr <= wh_aw_addr;
                aw_len <= {4'd0, wh_len};
                aw_ch <= wh_ch;
                wt_id <= (wt_id + 1);
                aw_vc_0 <= (wh_ch == 0);
                aw_vc_1 <= (wh_ch == 1);
            end else begin
                if (aw_rdy) begin
                    aw_v <= 0;
                    aw_vc_0 <= 0;
                    aw_vc_1 <= 0;
                end
            end
            if ((wd_v & wslot_free)) begin
                wq_v <= 1;
                wq_more <= (~wd_nrw);
                wq_last_q <= wd_last;
                wq_ch <= wd_ch;
                wq_vc_0 <= (wd_ch == 0);
                wq_vc_1 <= (wd_ch == 1);
            end else begin
                if ((wq_v & mw_rdy)) begin
                    if (wq_tail) begin
                        wq_v <= 0;
                        wq_vc_0 <= 0;
                        wq_vc_1 <= 0;
                    end else begin
                        wq_more <= 0;
                    end
                end
            end
            if ((wt_v & wd_free)) begin
                wd_v <= 1;
                wd_last <= wt_last;
                wd_nrw <= wt_nrw;
                wd_ch <= wt_ch;
            end else begin
                if ((wd_v & wslot_free)) begin
                    wd_v <= 0;
                end
            end
            if (((wt_v & (~wd_free)) & (~wt_held))) begin
                wt_held <= 1;
            end
            if ((w_take & (~wo_loc))) begin
                wt_v <= 1;
                wt_m <= wo_m;
                wt_last <= w_lastb;
                wt_ch <= wo_ch;
                wt_held <= 0;
            end else begin
                if ((wt_v & wd_free)) begin
                    wt_v <= 0;
                    wt_held <= 0;
                end
            end
            bev_p <= 0;
            if (w_take) begin
                if (w_lastb) begin
                    wbk <= 0;
                    orp <= (orp + 1);
                    orp1 <= (orp1 + 1);
                    if (wo_last) begin
                        bev_p <= 1;
                        bevm_p <= wo_m;
                        bevwid_p <= wo_wid;
                        bevtag_p <= wo_tag;
                        bevloc_p <= wo_loc;
                    end
                end else begin
                    wbk <= (wbk + 1);
                end
            end
            ocnt <= ((ocnt + {2'd0, wo_push}) - {2'd0, (w_take & w_lastb)});
            bev_q <= bev_p;
            bevm_q <= bevm_p;
            bevwid_q <= bevwid_p;
            bevtag_q <= bevtag_p;
            bevloc_q <= bevloc_p;
            mr_v_0 <= m_0_r_valid;
            mr_id_0 <= m_0_r_id;
            mr_last_0 <= m_0_r_last;
            if ((mr_v_0 & (rid_idx_0 == 0))) begin
                bcnt_0_0 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 1))) begin
                bcnt_0_1 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 2))) begin
                bcnt_0_2 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 3))) begin
                bcnt_0_3 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 4))) begin
                bcnt_0_4 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 5))) begin
                bcnt_0_5 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 6))) begin
                bcnt_0_6 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 7))) begin
                bcnt_0_7 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 8))) begin
                bcnt_0_8 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 9))) begin
                bcnt_0_9 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 10))) begin
                bcnt_0_10 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 11))) begin
                bcnt_0_11 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 12))) begin
                bcnt_0_12 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 13))) begin
                bcnt_0_13 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 14))) begin
                bcnt_0_14 <= (bcnt_rd_0 + 1);
            end
            if ((mr_v_0 & (rid_idx_0 == 15))) begin
                bcnt_0_15 <= (bcnt_rd_0 + 1);
            end
            asw_we_a_0 <= asm_we_0;
            asw_we_b_0 <= asm_we_0;
            asw_we_a_1 <= asm_we_1;
            asw_we_b_1 <= asm_we_1;
            mr_v_1 <= m_1_r_valid;
            mr_id_1 <= m_1_r_id;
            mr_last_1 <= m_1_r_last;
            if ((mr_v_1 & (rid_idx_1 == 0))) begin
                bcnt_1_0 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 1))) begin
                bcnt_1_1 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 2))) begin
                bcnt_1_2 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 3))) begin
                bcnt_1_3 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 4))) begin
                bcnt_1_4 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 5))) begin
                bcnt_1_5 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 6))) begin
                bcnt_1_6 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 7))) begin
                bcnt_1_7 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 8))) begin
                bcnt_1_8 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 9))) begin
                bcnt_1_9 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 10))) begin
                bcnt_1_10 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 11))) begin
                bcnt_1_11 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 12))) begin
                bcnt_1_12 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 13))) begin
                bcnt_1_13 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 14))) begin
                bcnt_1_14 <= (bcnt_rd_1 + 1);
            end
            if ((mr_v_1 & (rid_idx_1 == 15))) begin
                bcnt_1_15 <= (bcnt_rd_1 + 1);
            end
            asw_we_a_2 <= asm_we_2;
            asw_we_b_2 <= asm_we_2;
            asw_we_a_3 <= asm_we_3;
            asw_we_b_3 <= asm_we_3;
            rd_out <= ((rd_out + {4'd0, ar_go_n}) - {4'd0, land_n});
            infl_occ <= ((infl_occ + {4'd0, ar_go_n}) - {4'd0, n_ret});
            st_nreq_q <= n_req;
            st_nfill_q <= ar_go_n;
            st_nwt_q <= aw_go;
            st_clr_q <= {(stat_clr_all | (stat_clr & (clr_idx == 3))), (stat_clr_all | (stat_clr & (clr_idx == 2))),
                         (stat_clr_all | (stat_clr & (clr_idx == 0)))};
            c_req <= (st_clr_q[0] ? 32'd0 : (c_req + {29'd0, st_nreq_q}));
            c_fill <= (st_clr_q[1] ? 32'd0 : (c_fill + {30'd0, st_nfill_q}));
            c_wt <= (st_clr_q[2] ? 32'd0 : (c_wt + {31'd0, st_nwt_q}));
        end
    end
    always_ff @(posedge clk) begin
        if (ar_go_0) begin
            tk_slot_0[ar_sidx_0] <= ar_tk_0;
        end
        if (ar_go_1) begin
            tk_slot_1[ar_sidx_1] <= ar_tk_1;
        end
        if (ent_wq_push) begin
            wqm[wwp] <= ent_wq_m;
            wqwid[wwp] <= ent_wq_wid;
            wqaddr[wwp] <= ent_wq_addr;
            wqeoff[wwp] <= ent_wq_eoff;
            wqlast[wwp] <= ent_wq_last;
            wqtag[wwp] <= ent_wq_tag;
            wqloc[wwp] <= ent_wq_loc;
        end
        if (wo_push) begin
            wom[owp] <= wh_m;
            wowid[owp] <= wh_wid;
            wonb[owp] <= wh_nbeat;
            wolast[owp] <= wh_last;
            wotag[owp] <= wh_tag;
            woloc[owp] <= wh_loc;
            wosidx[owp] <= wh_addr[7:2];
            woch[owp] <= wh_ch;
        end
        if (wq_ce) begin
            if (wq_adv) begin
                wq_sd <= wq_hd;
                wq_ss <= wq_hs;
            end else begin
                wq_sd <= wd_data[511:0];
                wq_ss <= wd_strb[63:0];
            end
        end
        if (wh_ce) begin
            wq_hd <= wd_data[1023:512];
            wq_hs <= wd_strb[127:64];
        end
        if (wd_ce) begin
            wd_data <= wt_data;
            wd_strb <= wt_strb;
        end
        if ((~wt_held)) begin
            wt_dat <= wt_bus_d;
            wt_stb <= wt_bus_s;
        end
        mr_data_0 <= m_0_r_data;
        asw_d_a_0 <= mr_data_0;
        asw_d_b_0 <= mr_data_0;
        asw_ad_a_0 <= asm_waddr_0;
        asw_ad_b_0 <= asm_waddr_0;
        asw_d_a_1 <= mr_data_0;
        asw_d_b_1 <= mr_data_0;
        asw_ad_a_1 <= asm_waddr_0;
        asw_ad_b_1 <= asm_waddr_0;
        mr_data_1 <= m_1_r_data;
        asw_d_a_2 <= mr_data_1;
        asw_d_b_2 <= mr_data_1;
        asw_ad_a_2 <= asm_waddr_1;
        asw_ad_b_2 <= asm_waddr_1;
        asw_d_a_3 <= mr_data_1;
        asw_d_b_3 <= mr_data_1;
        asw_ad_a_3 <= asm_waddr_1;
        asw_ad_b_3 <= asm_waddr_1;
    end

    NocLane u_lane_0 (
        .clk(clk),
        .rst_n(rst_n),
        .rq_push(ent_rq0_push),
        .rq_tk(ent_rq0_tk),
        .rq_addr(ent_rq0_addr),
        .rq_slot(ent_rq0_slot),
        .pop(lane_pop_0),
        .rq_ok(u_lane_0_rq_ok),
        .hv(u_lane_0_hv),
        .h_line(u_lane_0_h_line),
        .h_slot(u_lane_0_h_slot),
        .h_tk(u_lane_0_h_tk),
        .busy(u_lane_0_busy)
    );
    NocLane u_lane_1 (
        .clk(clk),
        .rst_n(rst_n),
        .rq_push(ent_rq1_push),
        .rq_tk(ent_rq1_tk),
        .rq_addr(ent_rq1_addr),
        .rq_slot(ent_rq1_slot),
        .pop(lane_pop_1),
        .rq_ok(u_lane_1_rq_ok),
        .hv(u_lane_1_hv),
        .h_line(u_lane_1_h_line),
        .h_slot(u_lane_1_h_slot),
        .h_tk(u_lane_1_h_tk),
        .busy(u_lane_1_busy)
    );
    NocLane u_lane_2 (
        .clk(clk),
        .rst_n(rst_n),
        .rq_push(ent_rq2_push),
        .rq_tk(ent_rq2_tk),
        .rq_addr(ent_rq2_addr),
        .rq_slot(ent_rq2_slot),
        .pop(lane_pop_2),
        .rq_ok(u_lane_2_rq_ok),
        .hv(u_lane_2_hv),
        .h_line(u_lane_2_h_line),
        .h_slot(u_lane_2_h_slot),
        .h_tk(u_lane_2_h_tk),
        .busy(u_lane_2_busy)
    );
    NocLane u_lane_3 (
        .clk(clk),
        .rst_n(rst_n),
        .rq_push(ent_rq3_push),
        .rq_tk(ent_rq3_tk),
        .rq_addr(ent_rq3_addr),
        .rq_slot(ent_rq3_slot),
        .pop(lane_pop_3),
        .rq_ok(u_lane_3_rq_ok),
        .hv(u_lane_3_hv),
        .h_line(u_lane_3_h_line),
        .h_slot(u_lane_3_h_slot),
        .h_tk(u_lane_3_h_tk),
        .busy(u_lane_3_busy)
    );
    NocAsmRam u_asm_a_0 (
        .clk(clk),
        .we(asw_we_a_0),
        .waddr(asw_ad_a_0),
        .wdata(asw_d_a_0),
        .ren(ent_ra_en),
        .raddr(ra_baddr),
        .rdata(u_asm_a_0_rdata)
    );
    NocAsmRam u_asm_a_1 (
        .clk(clk),
        .we(asw_we_a_1),
        .waddr(asw_ad_a_1),
        .wdata(asw_d_a_1),
        .ren(ent_ra_en),
        .raddr(ra_baddr),
        .rdata(u_asm_a_1_rdata)
    );
    NocAsmRam u_asm_a_2 (
        .clk(clk),
        .we(asw_we_a_2),
        .waddr(asw_ad_a_2),
        .wdata(asw_d_a_2),
        .ren(ent_ra_en),
        .raddr(ra_baddr),
        .rdata(u_asm_a_2_rdata)
    );
    NocAsmRam u_asm_a_3 (
        .clk(clk),
        .we(asw_we_a_3),
        .waddr(asw_ad_a_3),
        .wdata(asw_d_a_3),
        .ren(ent_ra_en),
        .raddr(ra_baddr),
        .rdata(u_asm_a_3_rdata)
    );
    NocAsmRam u_asm_b_0 (
        .clk(clk),
        .we(asw_we_b_0),
        .waddr(asw_ad_b_0),
        .wdata(asw_d_b_0),
        .ren(ent_rb_en),
        .raddr(rb_baddr),
        .rdata(u_asm_b_0_rdata)
    );
    NocAsmRam u_asm_b_1 (
        .clk(clk),
        .we(asw_we_b_1),
        .waddr(asw_ad_b_1),
        .wdata(asw_d_b_1),
        .ren(ent_rb_en),
        .raddr(rb_baddr),
        .rdata(u_asm_b_1_rdata)
    );
    NocAsmRam u_asm_b_2 (
        .clk(clk),
        .we(asw_we_b_2),
        .waddr(asw_ad_b_2),
        .wdata(asw_d_b_2),
        .ren(ent_rb_en),
        .raddr(rb_baddr),
        .rdata(u_asm_b_2_rdata)
    );
    NocAsmRam u_asm_b_3 (
        .clk(clk),
        .we(asw_we_b_3),
        .waddr(asw_ad_b_3),
        .wdata(asw_d_b_3),
        .ren(ent_rb_en),
        .raddr(rb_baddr),
        .rdata(u_asm_b_3_rdata)
    );
endmodule
