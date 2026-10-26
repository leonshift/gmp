module LoaderB (
    input clk,
    input rst_n,
    input start,
    input [47:0] p_base,
    input [31:0] p_strd,
    input [8:0] p_rowb,
    input [7:0] p_nrows,
    input [7:0] p_cfg,
    input [7:0] p_klim,
    input [1:0] p_set,
    input [2:0] p_tag,
    input [1:0] p_slot,
    input p_q8,
    input p_kmj,
    input p_strm,
    input ar_gnt,
    input r_valid,
    input [1023:0] r_data,
    output logic [19:0] ar_bytes,
    output logic ar_req,
    output logic [47:0] ar_addr,
    output logic [7:0] ar_cfg,
    output logic ar_first,
    output logic ar_last,
    output logic busy,
    output logic fx_free,
    output logic [7:0] rows_done0,
    output logic [2:0] tag_q0,
    output logic [7:0] rows_done1,
    output logic [2:0] tag_q1,
    output logic done_p,
    output logic [1:0] done_slot,
    output logic [1:0] slot_q,
    output logic [1:0] set_q,
    output logic bw_en,
    output logic [6:0] bw_r,
    output logic [1023:0] bw_data,
    output logic bw_e_en,
    output logic [33:0] bw_eb,
    output logic [1023:0] bw_data2,
    output logic [33:0] bw_eb2,
    output logic bw_dual,
    output logic kmj,
    output logic clr_q,
    output logic [1:0] clr_set
);
    logic act;
    logic [31:0] strd_q;
    logic [8:0] rowb_q;
    logic [7:0] nrows_q;
    logic [7:0] klim_q;
    logic [7:0] cfg_q;
    logic [1:0] slot_qr;
    logic fp;
    logic ftp;
    logic q8_q;
    logic clr_qr;
    logic [1:0] clr_set_q;
    logic strm_q;
    logic cv_0_tact;
    logic [7:0] cv_0_nrows;
    logic [5:0] cv_0_nv0;
    logic [5:0] cv_0_nv1;
    logic [1:0] cv_0_set;
    logic [2:0] cv_0_tag;
    logic [1:0] cv_0_slot;
    logic [7:0] cv_0_rd;
    logic cv_0_q8;
    logic cv_0_kmj;
    logic cv_0_strm;
    logic cv_1_tact;
    logic [7:0] cv_1_nrows;
    logic [5:0] cv_1_nv0;
    logic [5:0] cv_1_nv1;
    logic [1:0] cv_1_set;
    logic [2:0] cv_1_tag;
    logic [1:0] cv_1_slot;
    logic [7:0] cv_1_rd;
    logic cv_1_q8;
    logic cv_1_kmj;
    logic cv_1_strm;
    logic [7:0] fx_row;
    logic [4:0] fx_buf;
    logic [3:0] fx_ost;
    logic [4:0] arq_buf [0:15];
    logic [4:0] arq_nb [0:15];
    logic arq_st [0:15];
    logic [3:0] arq_wp;
    logic [3:0] arq_rp;
    logic [4:0] rx_cnt;
    logic [1:0] rx_bc;
    logic [2:0] rx_bo;
    logic [127:0] bcol0_0 [0:31];
    logic [127:0] bcol0_1 [0:31];
    logic [127:0] bcol0_2 [0:31];
    logic [127:0] bcol0_3 [0:31];
    logic [127:0] bcol0_4 [0:31];
    logic [127:0] bcol0_5 [0:31];
    logic [127:0] bcol0_6 [0:31];
    logic [127:0] bcol0_7 [0:31];
    logic [127:0] bcol1_0 [0:31];
    logic [127:0] bcol1_1 [0:31];
    logic [127:0] bcol1_2 [0:31];
    logic [127:0] bcol1_3 [0:31];
    logic [127:0] bcol1_4 [0:31];
    logic [127:0] bcol1_5 [0:31];
    logic [127:0] bcol1_6 [0:31];
    logic [127:0] bcol1_7 [0:31];
    logic [127:0] bcol2_0 [0:31];
    logic [127:0] bcol2_1 [0:31];
    logic [127:0] bcol2_2 [0:31];
    logic [127:0] bcol2_3 [0:31];
    logic [127:0] bcol2_4 [0:31];
    logic [127:0] bcol2_5 [0:31];
    logic [127:0] bcol2_6 [0:31];
    logic [127:0] bcol2_7 [0:31];
    logic [4:0] cv_bufr_0;
    logic [4:0] cv_bufr_1;
    logic [4:0] cv_bufr_2;
    logic [4:0] cv_bufr_3;
    logic [4:0] cv_bufr_4;
    logic [4:0] cv_bufr_5;
    logic [4:0] cv_bufr_6;
    logic [4:0] cv_bufr_7;
    logic [4:0] cv_bufr_8;
    logic [4:0] cv_bufr_9;
    logic [4:0] cv_bufr_10;
    logic [4:0] cv_bufr_11;
    logic [4:0] cv_bufr_12;
    logic [4:0] cv_bufr_13;
    logic [4:0] cv_bufr_14;
    logic [4:0] cv_bufr_15;
    logic [4:0] cv_bufr_16;
    logic [4:0] cv_bufr_17;
    logic [4:0] cv_bufr_18;
    logic [4:0] cv_bufr_19;
    logic [4:0] cv_bufr_20;
    logic [4:0] cv_bufr_21;
    logic [4:0] cv_bufr_22;
    logic [4:0] cv_bufr_23;
    logic wr_we_0;
    logic wr_we_1;
    logic wr_we_2;
    logic wr_we_3;
    logic wr_we_4;
    logic wr_we_5;
    logic wr_we_6;
    logic wr_we_7;
    logic wr_we_8;
    logic wr_we_9;
    logic wr_we_10;
    logic wr_we_11;
    logic wr_we_12;
    logic wr_we_13;
    logic wr_we_14;
    logic wr_we_15;
    logic wr_we_16;
    logic wr_we_17;
    logic wr_we_18;
    logic wr_we_19;
    logic wr_we_20;
    logic wr_we_21;
    logic wr_we_22;
    logic wr_we_23;
    logic [4:0] wr_aq_0;
    logic [4:0] wr_aq_1;
    logic [4:0] wr_aq_2;
    logic [4:0] wr_aq_3;
    logic [4:0] wr_aq_4;
    logic [4:0] wr_aq_5;
    logic [4:0] wr_aq_6;
    logic [4:0] wr_aq_7;
    logic [4:0] wr_aq_8;
    logic [4:0] wr_aq_9;
    logic [4:0] wr_aq_10;
    logic [4:0] wr_aq_11;
    logic [4:0] wr_aq_12;
    logic [4:0] wr_aq_13;
    logic [4:0] wr_aq_14;
    logic [4:0] wr_aq_15;
    logic [4:0] wr_aq_16;
    logic [4:0] wr_aq_17;
    logic [4:0] wr_aq_18;
    logic [4:0] wr_aq_19;
    logic [4:0] wr_aq_20;
    logic [4:0] wr_aq_21;
    logic [4:0] wr_aq_22;
    logic [4:0] wr_aq_23;
    logic [1023:0] wr_d;
    logic wr_setv;
    logic wr_s;
    logic [4:0] cv_buf;
    logic cv_tq;
    logic [7:0] st_row;
    logic [7:0] st_left;
    logic st_l1;
    logic st_l2;
    logic s_v;
    logic [7:0] s_row;
    logic s_two;
    logic s_t;
    logic [1:0] s_set;
    logic [5:0] s_nv0;
    logic [5:0] s_nv1;
    logic s_q8;
    logic s_kmj;
    logic s_strm;
    logic e_v;
    logic [7:0] e_row;
    logic e_two;
    logic e_t;
    logic [1:0] e_set;
    logic [5:0] e_nv0;
    logic [5:0] e_nv1;
    logic e_q8;
    logic e_kmj;
    logic e_strm;
    logic w1_v;
    logic [7:0] w1_row;
    logic w1_two;
    logic w1_t;
    logic [1:0] w1_set;
    logic [5:0] w1_nv0;
    logic [5:0] w1_nv1;
    logic w1_q8;
    logic w1_kmj;
    logic w1_strm;
    logic w_v;
    logic [7:0] w_row;
    logic w_two;
    logic w_t;
    logic [1:0] w_set;
    logic [5:0] w_nv0;
    logic [5:0] w_nv1;
    logic w_q8;
    logic w_kmj;
    logic w_strm;
    logic [1087:0] s_grp;
    logic [1087:0] e_grp;
    logic [1087:0] w1_grp;
    logic [1087:0] w_grp;
    logic [31:0] s_ok0;
    logic [31:0] s_ok1;
    logic [30:0] e_th0;
    logic [30:0] e_th1;
    logic [159:0] e_em0;
    logic [159:0] e_em1;
    logic [31:0] e_ez0;
    logic [31:0] e_ez1;
    logic [159:0] w1_em0;
    logic [159:0] w1_em1;
    logic [31:0] w1_ez0;
    logic [31:0] w1_ez1;
    logic [4:0] em1_0;
    logic [4:0] em1_1;
    logic [4:0] em_w0;
    logic [4:0] em_w1;
    logic done_pr;
    logic [1:0] done_slot_q;
    logic [1:0] cv_col;
    logic [1:0] cv_colr_0;
    logic [1:0] cv_colr_1;
    logic [1:0] cv_colr_2;
    logic [1:0] cv_colr_3;
    logic [1:0] cv_colr_4;
    logic [1:0] cv_colr_5;
    logic [1:0] cv_colr_6;
    logic [1:0] cv_colr_7;
    logic [511:0] sc_lat;
    logic [6:0] avail;
    logic s0_v;
    logic [1023:0] s0_d;
    logic s0_strm;
    logic s0_sca;
    logic s0_scb;
    logic s0_two;
    logic [7:0] s0_row;
    logic s0_t;
    logic [1:0] s0_set;
    logic [5:0] s0_nv0;
    logic [5:0] s0_nv1;
    logic s0_q8;
    logic s0_kmj;
    logic pa_v;
    logic [7:0] pa_row;
    logic [1:0] pa_set;
    logic pa_t;
    logic [1023:0] pa_q;
    logic [33:0] pa_eb;
    logic pa_ce_0;
    logic pa_ce_1;
    logic pa_ce_2;
    logic pa_ce_3;
    logic pa_ce_4;
    logic pa_ce_5;
    logic pa_ce_6;
    logic pa_ce_7;
    logic pa_sb_0;
    logic pa_sb_1;
    logic pa_sb_2;
    logic pa_sb_3;
    logic pa_sb_4;
    logic pa_sb_5;
    logic pa_sb_6;
    logic pa_sb_7;
    logic pa_ce_n;
    logic w1q8_c_0;
    logic w1q8_c_1;
    logic w1q8_c_2;
    logic w1q8_c_3;
    logic w1q8_c_4;
    logic w1q8_c_5;
    logic w1q8_c_6;
    logic w1q8_c_7;
    logic bw_en_q;
    logic [6:0] bw_r_q;
    logic [1023:0] bw_data_q;
    logic bw_e_en_q;
    logic [33:0] bw_eb_q;
    logic [1:0] bw_set_q;
    logic bw_kmj_q;
    logic [1023:0] bw_data2_q;
    logic [33:0] bw_eb2_q;
    logic bw_dual_q;
    logic bsel_p_0;
    logic bsel_p_1;
    logic bsel_p_2;
    logic bsel_p_3;
    logic bsel_p_4;
    logic bsel_p_5;
    logic bsel_p_6;
    logic bsel_p_7;
    logic bsel_p_8;
    logic bsel_p_9;
    logic bsel_p_10;
    logic bsel_p_11;
    logic bsel_p_12;
    logic bsel_p_13;
    logic bsel_p_14;
    logic bsel_p_15;
    logic bsel_a_0;
    logic bsel_a_1;
    logic bsel_a_2;
    logic bsel_a_3;
    logic bsel_a_4;
    logic bsel_a_5;
    logic bsel_a_6;
    logic bsel_a_7;
    logic bsel_a_8;
    logic bsel_a_9;
    logic bsel_a_10;
    logic bsel_a_11;
    logic bsel_a_12;
    logic bsel_a_13;
    logic bsel_a_14;
    logic bsel_a_15;
    logic [47:0] fx_addr;
    logic [5:0] occ;
    logic [5:0] vcnt;
    logic fx_bufbusy;
    logic [7:0] fx_rleft;
    logic fx_more;
    logic fx_lastq;
    logic fx_firstq;
    logic [47:0] fx_inc;
    logic [47:0] fx_addr_n;
    logic [5:0] fx_rtq;
    logic [4:0] fx_nbq;
    logic [2:0] fx_nfq;
    logic [11:0] fx_byq;
    logic [5:0] fx_rt;
    logic [4:0] fx_nbeat;
    logic [2:0] fx_nbuf;
    logic [7:0] fx_rl_n;
    logic [1:0] g0_sig_1;
    logic [7:0] g0_sig_2;
    logic [5:0] g0_sig_3;
    logic [4:0] g0_sig_4;
    logic [2:0] g0_sig_5;
    logic [10:0] g0_sig_6;
    logic [1:0] g1_sig_1;
    logic [7:0] g1_sig_2;
    logic [5:0] g1_sig_3;
    logic [4:0] g1_sig_4;
    logic [2:0] g1_sig_5;
    logic [10:0] g1_sig_6;
    logic [5:0] g0_rt;
    logic [4:0] g0_nbeat;
    logic [2:0] g0_nbuf;
    logic [11:0] g0_byts;
    logic g0_last;
    logic g0_more;
    logic [5:0] g1_rt;
    logic [4:0] g1_nbeat;
    logic [2:0] g1_nbuf;
    logic [11:0] g1_byts;
    logic g1_last;
    logic g1_more;
    logic fx_bufbusy6;
    logic fx_go;
    logic [5:0] fx_bs5;
    logic [4:0] fx_buf_n;
    logic ar_fire_c;
    logic cv_t;
    logic [1:0] cv_set;
    logic cv_q8;
    logic cv_kmj;
    logic cv_strm;
    logic [4:0] rx_buf;
    logic [4:0] rx_nb;
    logic rx_st;
    logic rx_last;
    logic [5:0] rx_s;
    logic [4:0] rx_wi;
    logic cv_bufv;
    logic [7:0] cv_row;
    logic st_blast;
    logic [7:0] st_onr;
    logic [5:0] p_nv0;
    logic [7:0] p_l1;
    logic [5:0] p_nv1;
    logic [5:0] cv_nv0;
    logic [5:0] cv_nv1;
    logic [31:0] s0_ok0;
    logic [31:0] s0_ok1;
    logic [5:0] nv_w0;
    logic [5:0] nv_w1;
    logic [127:0] c0_s_0;
    logic [127:0] c0_s_1;
    logic [127:0] c0_s_2;
    logic [127:0] c0_s_3;
    logic [127:0] c0_s_4;
    logic [127:0] c0_s_5;
    logic [127:0] c0_s_6;
    logic [127:0] c0_s_7;
    logic [1023:0] c0_d;
    logic cv_go;
    logic [5:0] cv_cb1;
    logic [4:0] cv_buf1;
    logic [127:0] c1_s_0;
    logic [127:0] c1_s_1;
    logic [127:0] c1_s_2;
    logic [127:0] c1_s_3;
    logic [127:0] c1_s_4;
    logic [127:0] c1_s_5;
    logic [127:0] c1_s_6;
    logic [127:0] c1_s_7;
    logic [127:0] c2_s_0;
    logic [127:0] c2_s_1;
    logic [127:0] c2_s_2;
    logic [127:0] c2_s_3;
    logic [127:0] c2_s_4;
    logic [127:0] c2_s_5;
    logic [127:0] c2_s_6;
    logic [127:0] c2_s_7;
    logic [1023:0] c1_d;
    logic [1023:0] c2_d;
    logic [127:0] cur_s_0;
    logic [127:0] cur_s_1;
    logic [127:0] cur_s_2;
    logic [127:0] cur_s_3;
    logic [127:0] cur_s_4;
    logic [127:0] cur_s_5;
    logic [127:0] cur_s_6;
    logic [127:0] cur_s_7;
    logic [1023:0] cur_beat;
    logic [1087:0] rs_grp;
    logic st_sca;
    logic st_scb;
    logic st_two;
    logic take_s;
    logic [511:0] sc_cur;
    logic [511:0] unit_a;
    logic [511:0] unit_b;
    logic [543:0] st_gra;
    logic [543:0] st_grb;
    logic [1087:0] st_grp;
    logic [511:0] sc_sh;
    logic [511:0] sc_next;
    logic [7:0] st_nrow;
    logic st_end;
    logic st_pend;
    logic st_c1w;
    logic [4:0] st_b1;
    logic [1:0] st_c1;
    logic st_tw;
    logic [4:0] st_b2;
    logic [1:0] st_c2;
    logic cv_rel;
    logic [5:0] occ_n;
    logic [7:0] st_take;
    logic st_bend;
    logic [1087:0] cva_pk;
    logic [1023:0] cvt_row;
    logic [9:0] em_row;
    logic [1023:0] q8a_row;
    logic [1023:0] q8b_row;
    logic [33:0] q8a_eb;
    logic [33:0] q8b_eb;
    logic [33:0] f16_eb;
    logic [33:0] row_eb;
    logic w_odd;
    logic st_pair;
    logic [7:0] st_pa_row;
    logic [33:0] st_pa_eb;
    logic [33:0] st_pb_eb;
    logic [7:0] st_left_n;
    logic ar_fire;
    logic rx_fire;
    logic rx_pop;
    logic [543:0] u_cva1_mz;
    logic [543:0] u_cva0_mz;
    logic [511:0] u_cvb1_f;
    logic [511:0] u_cvb0_f;
    logic [511:0] u_q8a1_q;
    logic [511:0] u_q8a0_q;
    logic [511:0] u_q8b1_q;
    logic [511:0] u_q8b0_q;
    logic [5:0] u_q8a1_eb;
    logic [10:0] u_q8a1_ms;
    logic [5:0] u_q8a0_eb;
    logic [10:0] u_q8a0_ms;
    logic [5:0] u_q8b1_eb;
    logic [10:0] u_q8b1_ms;
    logic [5:0] u_q8b0_eb;
    logic [10:0] u_q8b0_ms;
    logic [4:0] u_em0_e;
    logic [4:0] u_em1_e;
    logic [30:0] u_et0_th;
    logic [30:0] u_et1_th;
    logic [159:0] u_et0_em;
    logic [159:0] u_et1_em;
    logic [31:0] u_et0_ez;
    logic [31:0] u_et1_ez;

    assign pa_ce_n = ((w1_v & w1_strm) & (w1_two ? w1_row[0] : (~w1_row[0])));
    assign fx_bufbusy = (occ == 32);
    assign fx_inc = (strm_q ? ({16'd0, strd_q} << 5) : {16'd0, strd_q});
    assign fx_addr_n = (fx_addr + fx_inc);
    assign fx_rt = fx_rtq;
    assign fx_nbeat = fx_nbq;
    assign fx_nbuf = fx_nfq;
    assign fx_rl_n = (fx_rleft - (strm_q ? {2'd0, fx_rtq} : 8'd1));
    assign g0_rt = ((p_nrows > 32) ? 6'd32 : p_nrows[5:0]);
    assign g0_sig_1 = ((p_base[6:0] == 0) ? 2'd0 : ((p_base[6:0] > 64) ? 2'd2 : 2'd1));
    assign g0_sig_2 = {g0_sig_1, g0_rt};
    assign g0_sig_3 = ((g0_rt == 0) ? 6'd1 :
                      ((g0_rt == 1) ? 6'd2 :
                      ((g0_rt == 2) ? 6'd3 :
                      ((g0_rt == 3) ? 6'd4 :
                      ((g0_rt == 4) ? 6'd5 :
                      ((g0_rt == 5) ? 6'd6 :
                      ((g0_rt == 6) ? 6'd7 :
                      ((g0_rt == 7) ? 6'd8 :
                      ((g0_rt == 8) ? 6'd9 :
                      ((g0_rt == 9) ? 6'd10 :
                      ((g0_rt == 10) ? 6'd11 :
                      ((g0_rt == 11) ? 6'd12 :
                      ((g0_rt == 12) ? 6'd13 :
                      ((g0_rt == 13) ? 6'd14 :
                      ((g0_rt == 14) ? 6'd15 :
                      ((g0_rt == 15) ? 6'd16 :
                      ((g0_rt == 16) ? 6'd17 :
                      ((g0_rt == 17) ? 6'd19 :
                      ((g0_rt == 18) ? 6'd20 :
                      ((g0_rt == 19) ? 6'd21 :
                      ((g0_rt == 20) ? 6'd22 :
                      ((g0_rt == 21) ? 6'd23 :
                      ((g0_rt == 22) ? 6'd24 :
                      ((g0_rt == 23) ? 6'd25 :
                      ((g0_rt == 24) ? 6'd26 :
                      ((g0_rt == 25) ? 6'd27 :
                      ((g0_rt == 26) ? 6'd28 :
                      ((g0_rt == 27) ? 6'd29 :
                      ((g0_rt == 28) ? 6'd30 :
                      ((g0_rt == 29) ? 6'd31 :
                      ((g0_rt == 30) ? 6'd32 :
                      ((g0_rt == 31) ? 6'd33 :
                      ((g0_rt == 32) ? 6'd34 :
                      ((g0_rt == 33) ? 6'd35 :
                      ((g0_rt == 34) ? 6'd36 :
                      ((g0_rt == 35) ? 6'd37 :
                      ((g0_rt == 36) ? 6'd38 :
                      ((g0_rt == 37) ? 6'd39 :
                      ((g0_rt == 38) ? 6'd40 :
                      ((g0_rt == 39) ? 6'd41 :
                      ((g0_rt == 40) ? 6'd42 :
                      ((g0_rt == 41) ? 6'd43 :
                      ((g0_rt == 42) ? 6'd44 :
                      ((g0_rt == 43) ? 6'd45 :
                      ((g0_rt == 44) ? 6'd46 :
                      ((g0_rt == 45) ? 6'd47 :
                      ((g0_rt == 46) ? 6'd48 :
                      ((g0_rt == 47) ? 6'd49 :
                      ((g0_rt == 48) ? 6'd50 :
                      ((g0_rt == 49) ? 6'd51 :
                      ((g0_rt == 50) ? 6'd52 :
                      ((g0_rt == 51) ? 6'd53 :
                      ((g0_rt == 52) ? 6'd54 :
                      ((g0_rt == 53) ? 6'd55 :
                      ((g0_rt == 54) ? 6'd56 :
                      ((g0_rt == 55) ? 6'd57 :
                      ((g0_rt == 56) ? 6'd58 :
                      ((g0_rt == 57) ? 6'd59 :
                      ((g0_rt == 58) ? 6'd60 :
                      ((g0_rt == 59) ? 6'd61 :
                      ((g0_rt == 60) ? 6'd62 :
                      ((g0_rt == 61) ? 6'd63 :
                      ((g0_rt == 62) ? 6'd0 :
                      6'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign g0_sig_4 = ((g0_sig_2 == 0) ? 5'd1 :
                      ((g0_sig_2 == 1) ? 5'd1 :
                      ((g0_sig_2 == 2) ? 5'd2 :
                      ((g0_sig_2 == 3) ? 5'd2 :
                      ((g0_sig_2 == 4) ? 5'd3 :
                      ((g0_sig_2 == 5) ? 5'd3 :
                      ((g0_sig_2 == 6) ? 5'd4 :
                      ((g0_sig_2 == 7) ? 5'd4 :
                      ((g0_sig_2 == 8) ? 5'd5 :
                      ((g0_sig_2 == 9) ? 5'd5 :
                      ((g0_sig_2 == 10) ? 5'd6 :
                      ((g0_sig_2 == 11) ? 5'd6 :
                      ((g0_sig_2 == 12) ? 5'd7 :
                      ((g0_sig_2 == 13) ? 5'd7 :
                      ((g0_sig_2 == 14) ? 5'd8 :
                      ((g0_sig_2 == 15) ? 5'd8 :
                      ((g0_sig_2 == 16) ? 5'd9 :
                      ((g0_sig_2 == 17) ? 5'd10 :
                      ((g0_sig_2 == 18) ? 5'd10 :
                      ((g0_sig_2 == 19) ? 5'd11 :
                      ((g0_sig_2 == 20) ? 5'd11 :
                      ((g0_sig_2 == 21) ? 5'd12 :
                      ((g0_sig_2 == 22) ? 5'd12 :
                      ((g0_sig_2 == 23) ? 5'd13 :
                      ((g0_sig_2 == 24) ? 5'd13 :
                      ((g0_sig_2 == 25) ? 5'd14 :
                      ((g0_sig_2 == 26) ? 5'd14 :
                      ((g0_sig_2 == 27) ? 5'd15 :
                      ((g0_sig_2 == 28) ? 5'd15 :
                      ((g0_sig_2 == 29) ? 5'd16 :
                      ((g0_sig_2 == 30) ? 5'd16 :
                      ((g0_sig_2 == 31) ? 5'd17 :
                      ((g0_sig_2 == 32) ? 5'd17 :
                      ((g0_sig_2 == 33) ? 5'd18 :
                      ((g0_sig_2 == 34) ? 5'd18 :
                      ((g0_sig_2 == 35) ? 5'd19 :
                      ((g0_sig_2 == 36) ? 5'd19 :
                      ((g0_sig_2 == 37) ? 5'd20 :
                      ((g0_sig_2 == 38) ? 5'd20 :
                      ((g0_sig_2 == 39) ? 5'd21 :
                      ((g0_sig_2 == 40) ? 5'd21 :
                      ((g0_sig_2 == 41) ? 5'd22 :
                      ((g0_sig_2 == 42) ? 5'd22 :
                      ((g0_sig_2 == 43) ? 5'd23 :
                      ((g0_sig_2 == 44) ? 5'd23 :
                      ((g0_sig_2 == 45) ? 5'd24 :
                      ((g0_sig_2 == 46) ? 5'd24 :
                      ((g0_sig_2 == 47) ? 5'd25 :
                      ((g0_sig_2 == 48) ? 5'd25 :
                      ((g0_sig_2 == 49) ? 5'd26 :
                      ((g0_sig_2 == 50) ? 5'd26 :
                      ((g0_sig_2 == 51) ? 5'd27 :
                      ((g0_sig_2 == 52) ? 5'd27 :
                      ((g0_sig_2 == 53) ? 5'd28 :
                      ((g0_sig_2 == 54) ? 5'd28 :
                      ((g0_sig_2 == 55) ? 5'd29 :
                      ((g0_sig_2 == 56) ? 5'd29 :
                      ((g0_sig_2 == 57) ? 5'd30 :
                      ((g0_sig_2 == 58) ? 5'd30 :
                      ((g0_sig_2 == 59) ? 5'd31 :
                      ((g0_sig_2 == 60) ? 5'd31 :
                      ((g0_sig_2 == 61) ? 5'd0 :
                      ((g0_sig_2 == 62) ? 5'd0 :
                      ((g0_sig_2 == 63) ? 5'd1 :
                      ((g0_sig_2 == 64) ? 5'd1 :
                      ((g0_sig_2 == 65) ? 5'd2 :
                      ((g0_sig_2 == 66) ? 5'd2 :
                      ((g0_sig_2 == 67) ? 5'd3 :
                      ((g0_sig_2 == 68) ? 5'd3 :
                      ((g0_sig_2 == 69) ? 5'd4 :
                      ((g0_sig_2 == 70) ? 5'd4 :
                      ((g0_sig_2 == 71) ? 5'd5 :
                      ((g0_sig_2 == 72) ? 5'd5 :
                      ((g0_sig_2 == 73) ? 5'd6 :
                      ((g0_sig_2 == 74) ? 5'd6 :
                      ((g0_sig_2 == 75) ? 5'd7 :
                      ((g0_sig_2 == 76) ? 5'd7 :
                      ((g0_sig_2 == 77) ? 5'd8 :
                      ((g0_sig_2 == 78) ? 5'd8 :
                      ((g0_sig_2 == 79) ? 5'd9 :
                      ((g0_sig_2 == 80) ? 5'd9 :
                      ((g0_sig_2 == 81) ? 5'd10 :
                      ((g0_sig_2 == 82) ? 5'd11 :
                      ((g0_sig_2 == 83) ? 5'd11 :
                      ((g0_sig_2 == 84) ? 5'd12 :
                      ((g0_sig_2 == 85) ? 5'd12 :
                      ((g0_sig_2 == 86) ? 5'd13 :
                      ((g0_sig_2 == 87) ? 5'd13 :
                      ((g0_sig_2 == 88) ? 5'd14 :
                      ((g0_sig_2 == 89) ? 5'd14 :
                      ((g0_sig_2 == 90) ? 5'd15 :
                      ((g0_sig_2 == 91) ? 5'd15 :
                      ((g0_sig_2 == 92) ? 5'd16 :
                      ((g0_sig_2 == 93) ? 5'd16 :
                      ((g0_sig_2 == 94) ? 5'd17 :
                      ((g0_sig_2 == 95) ? 5'd17 :
                      ((g0_sig_2 == 96) ? 5'd18 :
                      ((g0_sig_2 == 97) ? 5'd18 :
                      ((g0_sig_2 == 98) ? 5'd19 :
                      ((g0_sig_2 == 99) ? 5'd19 :
                      ((g0_sig_2 == 100) ? 5'd20 :
                      ((g0_sig_2 == 101) ? 5'd20 :
                      ((g0_sig_2 == 102) ? 5'd21 :
                      ((g0_sig_2 == 103) ? 5'd21 :
                      ((g0_sig_2 == 104) ? 5'd22 :
                      ((g0_sig_2 == 105) ? 5'd22 :
                      ((g0_sig_2 == 106) ? 5'd23 :
                      ((g0_sig_2 == 107) ? 5'd23 :
                      ((g0_sig_2 == 108) ? 5'd24 :
                      ((g0_sig_2 == 109) ? 5'd24 :
                      ((g0_sig_2 == 110) ? 5'd25 :
                      ((g0_sig_2 == 111) ? 5'd25 :
                      ((g0_sig_2 == 112) ? 5'd26 :
                      ((g0_sig_2 == 113) ? 5'd26 :
                      ((g0_sig_2 == 114) ? 5'd27 :
                      ((g0_sig_2 == 115) ? 5'd27 :
                      ((g0_sig_2 == 116) ? 5'd28 :
                      ((g0_sig_2 == 117) ? 5'd28 :
                      ((g0_sig_2 == 118) ? 5'd29 :
                      ((g0_sig_2 == 119) ? 5'd29 :
                      ((g0_sig_2 == 120) ? 5'd30 :
                      ((g0_sig_2 == 121) ? 5'd30 :
                      ((g0_sig_2 == 122) ? 5'd31 :
                      ((g0_sig_2 == 123) ? 5'd31 :
                      ((g0_sig_2 == 124) ? 5'd0 :
                      ((g0_sig_2 == 125) ? 5'd0 :
                      ((g0_sig_2 == 126) ? 5'd1 :
                      ((g0_sig_2 == 127) ? 5'd1 :
                      ((g0_sig_2 == 128) ? 5'd2 :
                      ((g0_sig_2 == 129) ? 5'd2 :
                      ((g0_sig_2 == 130) ? 5'd3 :
                      ((g0_sig_2 == 131) ? 5'd3 :
                      ((g0_sig_2 == 132) ? 5'd4 :
                      ((g0_sig_2 == 133) ? 5'd4 :
                      ((g0_sig_2 == 134) ? 5'd5 :
                      ((g0_sig_2 == 135) ? 5'd5 :
                      ((g0_sig_2 == 136) ? 5'd6 :
                      ((g0_sig_2 == 137) ? 5'd6 :
                      ((g0_sig_2 == 138) ? 5'd7 :
                      ((g0_sig_2 == 139) ? 5'd7 :
                      ((g0_sig_2 == 140) ? 5'd8 :
                      ((g0_sig_2 == 141) ? 5'd8 :
                      ((g0_sig_2 == 142) ? 5'd9 :
                      ((g0_sig_2 == 143) ? 5'd9 :
                      ((g0_sig_2 == 144) ? 5'd10 :
                      ((g0_sig_2 == 145) ? 5'd11 :
                      ((g0_sig_2 == 146) ? 5'd11 :
                      ((g0_sig_2 == 147) ? 5'd12 :
                      ((g0_sig_2 == 148) ? 5'd12 :
                      ((g0_sig_2 == 149) ? 5'd13 :
                      ((g0_sig_2 == 150) ? 5'd13 :
                      ((g0_sig_2 == 151) ? 5'd14 :
                      ((g0_sig_2 == 152) ? 5'd14 :
                      ((g0_sig_2 == 153) ? 5'd15 :
                      ((g0_sig_2 == 154) ? 5'd15 :
                      ((g0_sig_2 == 155) ? 5'd16 :
                      ((g0_sig_2 == 156) ? 5'd16 :
                      ((g0_sig_2 == 157) ? 5'd17 :
                      ((g0_sig_2 == 158) ? 5'd17 :
                      ((g0_sig_2 == 159) ? 5'd18 :
                      ((g0_sig_2 == 160) ? 5'd18 :
                      ((g0_sig_2 == 161) ? 5'd19 :
                      ((g0_sig_2 == 162) ? 5'd19 :
                      ((g0_sig_2 == 163) ? 5'd20 :
                      ((g0_sig_2 == 164) ? 5'd20 :
                      ((g0_sig_2 == 165) ? 5'd21 :
                      ((g0_sig_2 == 166) ? 5'd21 :
                      ((g0_sig_2 == 167) ? 5'd22 :
                      ((g0_sig_2 == 168) ? 5'd22 :
                      ((g0_sig_2 == 169) ? 5'd23 :
                      ((g0_sig_2 == 170) ? 5'd23 :
                      ((g0_sig_2 == 171) ? 5'd24 :
                      ((g0_sig_2 == 172) ? 5'd24 :
                      ((g0_sig_2 == 173) ? 5'd25 :
                      ((g0_sig_2 == 174) ? 5'd25 :
                      ((g0_sig_2 == 175) ? 5'd26 :
                      ((g0_sig_2 == 176) ? 5'd26 :
                      ((g0_sig_2 == 177) ? 5'd27 :
                      ((g0_sig_2 == 178) ? 5'd27 :
                      ((g0_sig_2 == 179) ? 5'd28 :
                      ((g0_sig_2 == 180) ? 5'd28 :
                      ((g0_sig_2 == 181) ? 5'd29 :
                      ((g0_sig_2 == 182) ? 5'd29 :
                      ((g0_sig_2 == 183) ? 5'd30 :
                      ((g0_sig_2 == 184) ? 5'd30 :
                      ((g0_sig_2 == 185) ? 5'd31 :
                      ((g0_sig_2 == 186) ? 5'd31 :
                      ((g0_sig_2 == 187) ? 5'd0 :
                      ((g0_sig_2 == 188) ? 5'd0 :
                      ((g0_sig_2 == 189) ? 5'd1 :
                      ((g0_sig_2 == 190) ? 5'd1 :
                      ((g0_sig_2 == 191) ? 5'd2 :
                      ((g0_sig_2 == 192) ? 5'd2 :
                      ((g0_sig_2 == 193) ? 5'd2 :
                      ((g0_sig_2 == 194) ? 5'd3 :
                      ((g0_sig_2 == 195) ? 5'd3 :
                      ((g0_sig_2 == 196) ? 5'd4 :
                      ((g0_sig_2 == 197) ? 5'd4 :
                      ((g0_sig_2 == 198) ? 5'd5 :
                      ((g0_sig_2 == 199) ? 5'd5 :
                      ((g0_sig_2 == 200) ? 5'd6 :
                      ((g0_sig_2 == 201) ? 5'd6 :
                      ((g0_sig_2 == 202) ? 5'd7 :
                      ((g0_sig_2 == 203) ? 5'd7 :
                      ((g0_sig_2 == 204) ? 5'd8 :
                      ((g0_sig_2 == 205) ? 5'd8 :
                      ((g0_sig_2 == 206) ? 5'd9 :
                      ((g0_sig_2 == 207) ? 5'd9 :
                      ((g0_sig_2 == 208) ? 5'd10 :
                      ((g0_sig_2 == 209) ? 5'd11 :
                      ((g0_sig_2 == 210) ? 5'd11 :
                      ((g0_sig_2 == 211) ? 5'd12 :
                      ((g0_sig_2 == 212) ? 5'd12 :
                      ((g0_sig_2 == 213) ? 5'd13 :
                      ((g0_sig_2 == 214) ? 5'd13 :
                      ((g0_sig_2 == 215) ? 5'd14 :
                      ((g0_sig_2 == 216) ? 5'd14 :
                      ((g0_sig_2 == 217) ? 5'd15 :
                      ((g0_sig_2 == 218) ? 5'd15 :
                      ((g0_sig_2 == 219) ? 5'd16 :
                      ((g0_sig_2 == 220) ? 5'd16 :
                      ((g0_sig_2 == 221) ? 5'd17 :
                      ((g0_sig_2 == 222) ? 5'd17 :
                      ((g0_sig_2 == 223) ? 5'd18 :
                      ((g0_sig_2 == 224) ? 5'd18 :
                      ((g0_sig_2 == 225) ? 5'd19 :
                      ((g0_sig_2 == 226) ? 5'd19 :
                      ((g0_sig_2 == 227) ? 5'd20 :
                      ((g0_sig_2 == 228) ? 5'd20 :
                      ((g0_sig_2 == 229) ? 5'd21 :
                      ((g0_sig_2 == 230) ? 5'd21 :
                      ((g0_sig_2 == 231) ? 5'd22 :
                      ((g0_sig_2 == 232) ? 5'd22 :
                      ((g0_sig_2 == 233) ? 5'd23 :
                      ((g0_sig_2 == 234) ? 5'd23 :
                      ((g0_sig_2 == 235) ? 5'd24 :
                      ((g0_sig_2 == 236) ? 5'd24 :
                      ((g0_sig_2 == 237) ? 5'd25 :
                      ((g0_sig_2 == 238) ? 5'd25 :
                      ((g0_sig_2 == 239) ? 5'd26 :
                      ((g0_sig_2 == 240) ? 5'd26 :
                      ((g0_sig_2 == 241) ? 5'd27 :
                      ((g0_sig_2 == 242) ? 5'd27 :
                      ((g0_sig_2 == 243) ? 5'd28 :
                      ((g0_sig_2 == 244) ? 5'd28 :
                      ((g0_sig_2 == 245) ? 5'd29 :
                      ((g0_sig_2 == 246) ? 5'd29 :
                      ((g0_sig_2 == 247) ? 5'd30 :
                      ((g0_sig_2 == 248) ? 5'd30 :
                      ((g0_sig_2 == 249) ? 5'd31 :
                      ((g0_sig_2 == 250) ? 5'd31 :
                      ((g0_sig_2 == 251) ? 5'd0 :
                      ((g0_sig_2 == 252) ? 5'd0 :
                      ((g0_sig_2 == 253) ? 5'd1 :
                      ((g0_sig_2 == 254) ? 5'd1 :
                      5'd2)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign g0_sig_5 = ((g0_sig_2 == 0) ? 3'd1 :
                      ((g0_sig_2 == 1) ? 3'd1 :
                      ((g0_sig_2 == 2) ? 3'd1 :
                      ((g0_sig_2 == 3) ? 3'd1 :
                      ((g0_sig_2 == 4) ? 3'd1 :
                      ((g0_sig_2 == 5) ? 3'd1 :
                      ((g0_sig_2 == 6) ? 3'd2 :
                      ((g0_sig_2 == 7) ? 3'd2 :
                      ((g0_sig_2 == 8) ? 3'd2 :
                      ((g0_sig_2 == 9) ? 3'd2 :
                      ((g0_sig_2 == 10) ? 3'd2 :
                      ((g0_sig_2 == 11) ? 3'd2 :
                      ((g0_sig_2 == 12) ? 3'd3 :
                      ((g0_sig_2 == 13) ? 3'd3 :
                      ((g0_sig_2 == 14) ? 3'd3 :
                      ((g0_sig_2 == 15) ? 3'd3 :
                      ((g0_sig_2 == 16) ? 3'd3 :
                      ((g0_sig_2 == 17) ? 3'd4 :
                      ((g0_sig_2 == 18) ? 3'd4 :
                      ((g0_sig_2 == 19) ? 3'd4 :
                      ((g0_sig_2 == 20) ? 3'd4 :
                      ((g0_sig_2 == 21) ? 3'd4 :
                      ((g0_sig_2 == 22) ? 3'd4 :
                      ((g0_sig_2 == 23) ? 3'd5 :
                      ((g0_sig_2 == 24) ? 3'd5 :
                      ((g0_sig_2 == 25) ? 3'd5 :
                      ((g0_sig_2 == 26) ? 3'd5 :
                      ((g0_sig_2 == 27) ? 3'd5 :
                      ((g0_sig_2 == 28) ? 3'd5 :
                      ((g0_sig_2 == 29) ? 3'd6 :
                      ((g0_sig_2 == 30) ? 3'd6 :
                      ((g0_sig_2 == 31) ? 3'd6 :
                      ((g0_sig_2 == 32) ? 3'd6 :
                      ((g0_sig_2 == 33) ? 3'd6 :
                      ((g0_sig_2 == 34) ? 3'd6 :
                      ((g0_sig_2 == 35) ? 3'd6 :
                      ((g0_sig_2 == 36) ? 3'd6 :
                      ((g0_sig_2 == 37) ? 3'd6 :
                      ((g0_sig_2 == 38) ? 3'd6 :
                      ((g0_sig_2 == 39) ? 3'd6 :
                      ((g0_sig_2 == 40) ? 3'd6 :
                      ((g0_sig_2 == 41) ? 3'd6 :
                      ((g0_sig_2 == 42) ? 3'd6 :
                      ((g0_sig_2 == 43) ? 3'd6 :
                      ((g0_sig_2 == 44) ? 3'd6 :
                      ((g0_sig_2 == 45) ? 3'd6 :
                      ((g0_sig_2 == 46) ? 3'd6 :
                      ((g0_sig_2 == 47) ? 3'd6 :
                      ((g0_sig_2 == 48) ? 3'd6 :
                      ((g0_sig_2 == 49) ? 3'd6 :
                      ((g0_sig_2 == 50) ? 3'd6 :
                      ((g0_sig_2 == 51) ? 3'd6 :
                      ((g0_sig_2 == 52) ? 3'd6 :
                      ((g0_sig_2 == 53) ? 3'd6 :
                      ((g0_sig_2 == 54) ? 3'd6 :
                      ((g0_sig_2 == 55) ? 3'd6 :
                      ((g0_sig_2 == 56) ? 3'd6 :
                      ((g0_sig_2 == 57) ? 3'd6 :
                      ((g0_sig_2 == 58) ? 3'd6 :
                      ((g0_sig_2 == 59) ? 3'd6 :
                      ((g0_sig_2 == 60) ? 3'd6 :
                      ((g0_sig_2 == 61) ? 3'd6 :
                      ((g0_sig_2 == 62) ? 3'd6 :
                      ((g0_sig_2 == 63) ? 3'd6 :
                      ((g0_sig_2 == 64) ? 3'd1 :
                      ((g0_sig_2 == 65) ? 3'd1 :
                      ((g0_sig_2 == 66) ? 3'd1 :
                      ((g0_sig_2 == 67) ? 3'd1 :
                      ((g0_sig_2 == 68) ? 3'd1 :
                      ((g0_sig_2 == 69) ? 3'd2 :
                      ((g0_sig_2 == 70) ? 3'd2 :
                      ((g0_sig_2 == 71) ? 3'd2 :
                      ((g0_sig_2 == 72) ? 3'd2 :
                      ((g0_sig_2 == 73) ? 3'd2 :
                      ((g0_sig_2 == 74) ? 3'd2 :
                      ((g0_sig_2 == 75) ? 3'd3 :
                      ((g0_sig_2 == 76) ? 3'd3 :
                      ((g0_sig_2 == 77) ? 3'd3 :
                      ((g0_sig_2 == 78) ? 3'd3 :
                      ((g0_sig_2 == 79) ? 3'd3 :
                      ((g0_sig_2 == 80) ? 3'd3 :
                      ((g0_sig_2 == 81) ? 3'd4 :
                      ((g0_sig_2 == 82) ? 3'd4 :
                      ((g0_sig_2 == 83) ? 3'd4 :
                      ((g0_sig_2 == 84) ? 3'd4 :
                      ((g0_sig_2 == 85) ? 3'd4 :
                      ((g0_sig_2 == 86) ? 3'd5 :
                      ((g0_sig_2 == 87) ? 3'd5 :
                      ((g0_sig_2 == 88) ? 3'd5 :
                      ((g0_sig_2 == 89) ? 3'd5 :
                      ((g0_sig_2 == 90) ? 3'd5 :
                      ((g0_sig_2 == 91) ? 3'd5 :
                      ((g0_sig_2 == 92) ? 3'd6 :
                      ((g0_sig_2 == 93) ? 3'd6 :
                      ((g0_sig_2 == 94) ? 3'd6 :
                      ((g0_sig_2 == 95) ? 3'd6 :
                      ((g0_sig_2 == 96) ? 3'd6 :
                      ((g0_sig_2 == 97) ? 3'd6 :
                      ((g0_sig_2 == 98) ? 3'd6 :
                      ((g0_sig_2 == 99) ? 3'd6 :
                      ((g0_sig_2 == 100) ? 3'd6 :
                      ((g0_sig_2 == 101) ? 3'd6 :
                      ((g0_sig_2 == 102) ? 3'd6 :
                      ((g0_sig_2 == 103) ? 3'd6 :
                      ((g0_sig_2 == 104) ? 3'd6 :
                      ((g0_sig_2 == 105) ? 3'd6 :
                      ((g0_sig_2 == 106) ? 3'd6 :
                      ((g0_sig_2 == 107) ? 3'd6 :
                      ((g0_sig_2 == 108) ? 3'd6 :
                      ((g0_sig_2 == 109) ? 3'd6 :
                      ((g0_sig_2 == 110) ? 3'd6 :
                      ((g0_sig_2 == 111) ? 3'd6 :
                      ((g0_sig_2 == 112) ? 3'd6 :
                      ((g0_sig_2 == 113) ? 3'd6 :
                      ((g0_sig_2 == 114) ? 3'd6 :
                      ((g0_sig_2 == 115) ? 3'd6 :
                      ((g0_sig_2 == 116) ? 3'd6 :
                      ((g0_sig_2 == 117) ? 3'd6 :
                      ((g0_sig_2 == 118) ? 3'd6 :
                      ((g0_sig_2 == 119) ? 3'd6 :
                      ((g0_sig_2 == 120) ? 3'd6 :
                      ((g0_sig_2 == 121) ? 3'd6 :
                      ((g0_sig_2 == 122) ? 3'd6 :
                      ((g0_sig_2 == 123) ? 3'd6 :
                      ((g0_sig_2 == 124) ? 3'd6 :
                      ((g0_sig_2 == 125) ? 3'd6 :
                      ((g0_sig_2 == 126) ? 3'd6 :
                      ((g0_sig_2 == 127) ? 3'd6 :
                      ((g0_sig_2 == 128) ? 3'd1 :
                      ((g0_sig_2 == 129) ? 3'd1 :
                      ((g0_sig_2 == 130) ? 3'd1 :
                      ((g0_sig_2 == 131) ? 3'd1 :
                      ((g0_sig_2 == 132) ? 3'd2 :
                      ((g0_sig_2 == 133) ? 3'd2 :
                      ((g0_sig_2 == 134) ? 3'd2 :
                      ((g0_sig_2 == 135) ? 3'd2 :
                      ((g0_sig_2 == 136) ? 3'd2 :
                      ((g0_sig_2 == 137) ? 3'd2 :
                      ((g0_sig_2 == 138) ? 3'd3 :
                      ((g0_sig_2 == 139) ? 3'd3 :
                      ((g0_sig_2 == 140) ? 3'd3 :
                      ((g0_sig_2 == 141) ? 3'd3 :
                      ((g0_sig_2 == 142) ? 3'd3 :
                      ((g0_sig_2 == 143) ? 3'd3 :
                      ((g0_sig_2 == 144) ? 3'd4 :
                      ((g0_sig_2 == 145) ? 3'd4 :
                      ((g0_sig_2 == 146) ? 3'd4 :
                      ((g0_sig_2 == 147) ? 3'd4 :
                      ((g0_sig_2 == 148) ? 3'd4 :
                      ((g0_sig_2 == 149) ? 3'd5 :
                      ((g0_sig_2 == 150) ? 3'd5 :
                      ((g0_sig_2 == 151) ? 3'd5 :
                      ((g0_sig_2 == 152) ? 3'd5 :
                      ((g0_sig_2 == 153) ? 3'd5 :
                      ((g0_sig_2 == 154) ? 3'd5 :
                      ((g0_sig_2 == 155) ? 3'd6 :
                      ((g0_sig_2 == 156) ? 3'd6 :
                      ((g0_sig_2 == 157) ? 3'd6 :
                      ((g0_sig_2 == 158) ? 3'd6 :
                      ((g0_sig_2 == 159) ? 3'd6 :
                      ((g0_sig_2 == 160) ? 3'd6 :
                      ((g0_sig_2 == 161) ? 3'd6 :
                      ((g0_sig_2 == 162) ? 3'd6 :
                      ((g0_sig_2 == 163) ? 3'd6 :
                      ((g0_sig_2 == 164) ? 3'd6 :
                      ((g0_sig_2 == 165) ? 3'd6 :
                      ((g0_sig_2 == 166) ? 3'd6 :
                      ((g0_sig_2 == 167) ? 3'd6 :
                      ((g0_sig_2 == 168) ? 3'd6 :
                      ((g0_sig_2 == 169) ? 3'd6 :
                      ((g0_sig_2 == 170) ? 3'd6 :
                      ((g0_sig_2 == 171) ? 3'd6 :
                      ((g0_sig_2 == 172) ? 3'd6 :
                      ((g0_sig_2 == 173) ? 3'd6 :
                      ((g0_sig_2 == 174) ? 3'd6 :
                      ((g0_sig_2 == 175) ? 3'd6 :
                      ((g0_sig_2 == 176) ? 3'd6 :
                      ((g0_sig_2 == 177) ? 3'd6 :
                      ((g0_sig_2 == 178) ? 3'd6 :
                      ((g0_sig_2 == 179) ? 3'd6 :
                      ((g0_sig_2 == 180) ? 3'd6 :
                      ((g0_sig_2 == 181) ? 3'd6 :
                      ((g0_sig_2 == 182) ? 3'd6 :
                      ((g0_sig_2 == 183) ? 3'd6 :
                      ((g0_sig_2 == 184) ? 3'd6 :
                      ((g0_sig_2 == 185) ? 3'd6 :
                      ((g0_sig_2 == 186) ? 3'd6 :
                      ((g0_sig_2 == 187) ? 3'd6 :
                      ((g0_sig_2 == 188) ? 3'd6 :
                      ((g0_sig_2 == 189) ? 3'd6 :
                      ((g0_sig_2 == 190) ? 3'd6 :
                      ((g0_sig_2 == 191) ? 3'd6 :
                      ((g0_sig_2 == 192) ? 3'd1 :
                      ((g0_sig_2 == 193) ? 3'd1 :
                      ((g0_sig_2 == 194) ? 3'd1 :
                      ((g0_sig_2 == 195) ? 3'd1 :
                      ((g0_sig_2 == 196) ? 3'd2 :
                      ((g0_sig_2 == 197) ? 3'd2 :
                      ((g0_sig_2 == 198) ? 3'd2 :
                      ((g0_sig_2 == 199) ? 3'd2 :
                      ((g0_sig_2 == 200) ? 3'd2 :
                      ((g0_sig_2 == 201) ? 3'd2 :
                      ((g0_sig_2 == 202) ? 3'd3 :
                      ((g0_sig_2 == 203) ? 3'd3 :
                      ((g0_sig_2 == 204) ? 3'd3 :
                      ((g0_sig_2 == 205) ? 3'd3 :
                      ((g0_sig_2 == 206) ? 3'd3 :
                      ((g0_sig_2 == 207) ? 3'd3 :
                      ((g0_sig_2 == 208) ? 3'd4 :
                      ((g0_sig_2 == 209) ? 3'd4 :
                      ((g0_sig_2 == 210) ? 3'd4 :
                      ((g0_sig_2 == 211) ? 3'd4 :
                      ((g0_sig_2 == 212) ? 3'd4 :
                      ((g0_sig_2 == 213) ? 3'd5 :
                      ((g0_sig_2 == 214) ? 3'd5 :
                      ((g0_sig_2 == 215) ? 3'd5 :
                      ((g0_sig_2 == 216) ? 3'd5 :
                      ((g0_sig_2 == 217) ? 3'd5 :
                      ((g0_sig_2 == 218) ? 3'd5 :
                      ((g0_sig_2 == 219) ? 3'd6 :
                      ((g0_sig_2 == 220) ? 3'd6 :
                      ((g0_sig_2 == 221) ? 3'd6 :
                      ((g0_sig_2 == 222) ? 3'd6 :
                      ((g0_sig_2 == 223) ? 3'd6 :
                      ((g0_sig_2 == 224) ? 3'd6 :
                      ((g0_sig_2 == 225) ? 3'd6 :
                      ((g0_sig_2 == 226) ? 3'd6 :
                      ((g0_sig_2 == 227) ? 3'd6 :
                      ((g0_sig_2 == 228) ? 3'd6 :
                      ((g0_sig_2 == 229) ? 3'd6 :
                      ((g0_sig_2 == 230) ? 3'd6 :
                      ((g0_sig_2 == 231) ? 3'd6 :
                      ((g0_sig_2 == 232) ? 3'd6 :
                      ((g0_sig_2 == 233) ? 3'd6 :
                      ((g0_sig_2 == 234) ? 3'd6 :
                      ((g0_sig_2 == 235) ? 3'd6 :
                      ((g0_sig_2 == 236) ? 3'd6 :
                      ((g0_sig_2 == 237) ? 3'd6 :
                      ((g0_sig_2 == 238) ? 3'd6 :
                      ((g0_sig_2 == 239) ? 3'd6 :
                      ((g0_sig_2 == 240) ? 3'd6 :
                      ((g0_sig_2 == 241) ? 3'd6 :
                      ((g0_sig_2 == 242) ? 3'd6 :
                      ((g0_sig_2 == 243) ? 3'd6 :
                      ((g0_sig_2 == 244) ? 3'd6 :
                      ((g0_sig_2 == 245) ? 3'd6 :
                      ((g0_sig_2 == 246) ? 3'd6 :
                      ((g0_sig_2 == 247) ? 3'd6 :
                      ((g0_sig_2 == 248) ? 3'd6 :
                      ((g0_sig_2 == 249) ? 3'd6 :
                      ((g0_sig_2 == 250) ? 3'd6 :
                      ((g0_sig_2 == 251) ? 3'd6 :
                      ((g0_sig_2 == 252) ? 3'd6 :
                      ((g0_sig_2 == 253) ? 3'd6 :
                      ((g0_sig_2 == 254) ? 3'd6 :
                      3'd6)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign g0_sig_6 = (({4'd0, p_base[6:0]} + {2'd0, p_rowb}) + 11'd127);
    assign g0_nbeat = (p_strm ? g0_sig_4 : {2'd0, g0_sig_6[9:7]});
    assign g0_nbuf = (p_strm ? g0_sig_5 : 3'd1);
    assign g0_byts = (p_strm ? {g0_sig_3, 6'd0} : {3'd0, p_rowb});
    assign g0_last = (p_strm ? (p_nrows <= 32) : (p_nrows == 1));
    assign g0_more = (p_nrows != 0);
    assign g1_rt = ((fx_rl_n > 32) ? 6'd32 : fx_rl_n[5:0]);
    assign g1_sig_1 = ((fx_addr_n[6:0] == 0) ? 2'd0 : ((fx_addr_n[6:0] > 64) ? 2'd2 : 2'd1));
    assign g1_sig_2 = {g1_sig_1, g1_rt};
    assign g1_sig_3 = ((g1_rt == 0) ? 6'd1 :
                      ((g1_rt == 1) ? 6'd2 :
                      ((g1_rt == 2) ? 6'd3 :
                      ((g1_rt == 3) ? 6'd4 :
                      ((g1_rt == 4) ? 6'd5 :
                      ((g1_rt == 5) ? 6'd6 :
                      ((g1_rt == 6) ? 6'd7 :
                      ((g1_rt == 7) ? 6'd8 :
                      ((g1_rt == 8) ? 6'd9 :
                      ((g1_rt == 9) ? 6'd10 :
                      ((g1_rt == 10) ? 6'd11 :
                      ((g1_rt == 11) ? 6'd12 :
                      ((g1_rt == 12) ? 6'd13 :
                      ((g1_rt == 13) ? 6'd14 :
                      ((g1_rt == 14) ? 6'd15 :
                      ((g1_rt == 15) ? 6'd16 :
                      ((g1_rt == 16) ? 6'd17 :
                      ((g1_rt == 17) ? 6'd19 :
                      ((g1_rt == 18) ? 6'd20 :
                      ((g1_rt == 19) ? 6'd21 :
                      ((g1_rt == 20) ? 6'd22 :
                      ((g1_rt == 21) ? 6'd23 :
                      ((g1_rt == 22) ? 6'd24 :
                      ((g1_rt == 23) ? 6'd25 :
                      ((g1_rt == 24) ? 6'd26 :
                      ((g1_rt == 25) ? 6'd27 :
                      ((g1_rt == 26) ? 6'd28 :
                      ((g1_rt == 27) ? 6'd29 :
                      ((g1_rt == 28) ? 6'd30 :
                      ((g1_rt == 29) ? 6'd31 :
                      ((g1_rt == 30) ? 6'd32 :
                      ((g1_rt == 31) ? 6'd33 :
                      ((g1_rt == 32) ? 6'd34 :
                      ((g1_rt == 33) ? 6'd35 :
                      ((g1_rt == 34) ? 6'd36 :
                      ((g1_rt == 35) ? 6'd37 :
                      ((g1_rt == 36) ? 6'd38 :
                      ((g1_rt == 37) ? 6'd39 :
                      ((g1_rt == 38) ? 6'd40 :
                      ((g1_rt == 39) ? 6'd41 :
                      ((g1_rt == 40) ? 6'd42 :
                      ((g1_rt == 41) ? 6'd43 :
                      ((g1_rt == 42) ? 6'd44 :
                      ((g1_rt == 43) ? 6'd45 :
                      ((g1_rt == 44) ? 6'd46 :
                      ((g1_rt == 45) ? 6'd47 :
                      ((g1_rt == 46) ? 6'd48 :
                      ((g1_rt == 47) ? 6'd49 :
                      ((g1_rt == 48) ? 6'd50 :
                      ((g1_rt == 49) ? 6'd51 :
                      ((g1_rt == 50) ? 6'd52 :
                      ((g1_rt == 51) ? 6'd53 :
                      ((g1_rt == 52) ? 6'd54 :
                      ((g1_rt == 53) ? 6'd55 :
                      ((g1_rt == 54) ? 6'd56 :
                      ((g1_rt == 55) ? 6'd57 :
                      ((g1_rt == 56) ? 6'd58 :
                      ((g1_rt == 57) ? 6'd59 :
                      ((g1_rt == 58) ? 6'd60 :
                      ((g1_rt == 59) ? 6'd61 :
                      ((g1_rt == 60) ? 6'd62 :
                      ((g1_rt == 61) ? 6'd63 :
                      ((g1_rt == 62) ? 6'd0 :
                      6'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign g1_sig_4 = ((g1_sig_2 == 0) ? 5'd1 :
                      ((g1_sig_2 == 1) ? 5'd1 :
                      ((g1_sig_2 == 2) ? 5'd2 :
                      ((g1_sig_2 == 3) ? 5'd2 :
                      ((g1_sig_2 == 4) ? 5'd3 :
                      ((g1_sig_2 == 5) ? 5'd3 :
                      ((g1_sig_2 == 6) ? 5'd4 :
                      ((g1_sig_2 == 7) ? 5'd4 :
                      ((g1_sig_2 == 8) ? 5'd5 :
                      ((g1_sig_2 == 9) ? 5'd5 :
                      ((g1_sig_2 == 10) ? 5'd6 :
                      ((g1_sig_2 == 11) ? 5'd6 :
                      ((g1_sig_2 == 12) ? 5'd7 :
                      ((g1_sig_2 == 13) ? 5'd7 :
                      ((g1_sig_2 == 14) ? 5'd8 :
                      ((g1_sig_2 == 15) ? 5'd8 :
                      ((g1_sig_2 == 16) ? 5'd9 :
                      ((g1_sig_2 == 17) ? 5'd10 :
                      ((g1_sig_2 == 18) ? 5'd10 :
                      ((g1_sig_2 == 19) ? 5'd11 :
                      ((g1_sig_2 == 20) ? 5'd11 :
                      ((g1_sig_2 == 21) ? 5'd12 :
                      ((g1_sig_2 == 22) ? 5'd12 :
                      ((g1_sig_2 == 23) ? 5'd13 :
                      ((g1_sig_2 == 24) ? 5'd13 :
                      ((g1_sig_2 == 25) ? 5'd14 :
                      ((g1_sig_2 == 26) ? 5'd14 :
                      ((g1_sig_2 == 27) ? 5'd15 :
                      ((g1_sig_2 == 28) ? 5'd15 :
                      ((g1_sig_2 == 29) ? 5'd16 :
                      ((g1_sig_2 == 30) ? 5'd16 :
                      ((g1_sig_2 == 31) ? 5'd17 :
                      ((g1_sig_2 == 32) ? 5'd17 :
                      ((g1_sig_2 == 33) ? 5'd18 :
                      ((g1_sig_2 == 34) ? 5'd18 :
                      ((g1_sig_2 == 35) ? 5'd19 :
                      ((g1_sig_2 == 36) ? 5'd19 :
                      ((g1_sig_2 == 37) ? 5'd20 :
                      ((g1_sig_2 == 38) ? 5'd20 :
                      ((g1_sig_2 == 39) ? 5'd21 :
                      ((g1_sig_2 == 40) ? 5'd21 :
                      ((g1_sig_2 == 41) ? 5'd22 :
                      ((g1_sig_2 == 42) ? 5'd22 :
                      ((g1_sig_2 == 43) ? 5'd23 :
                      ((g1_sig_2 == 44) ? 5'd23 :
                      ((g1_sig_2 == 45) ? 5'd24 :
                      ((g1_sig_2 == 46) ? 5'd24 :
                      ((g1_sig_2 == 47) ? 5'd25 :
                      ((g1_sig_2 == 48) ? 5'd25 :
                      ((g1_sig_2 == 49) ? 5'd26 :
                      ((g1_sig_2 == 50) ? 5'd26 :
                      ((g1_sig_2 == 51) ? 5'd27 :
                      ((g1_sig_2 == 52) ? 5'd27 :
                      ((g1_sig_2 == 53) ? 5'd28 :
                      ((g1_sig_2 == 54) ? 5'd28 :
                      ((g1_sig_2 == 55) ? 5'd29 :
                      ((g1_sig_2 == 56) ? 5'd29 :
                      ((g1_sig_2 == 57) ? 5'd30 :
                      ((g1_sig_2 == 58) ? 5'd30 :
                      ((g1_sig_2 == 59) ? 5'd31 :
                      ((g1_sig_2 == 60) ? 5'd31 :
                      ((g1_sig_2 == 61) ? 5'd0 :
                      ((g1_sig_2 == 62) ? 5'd0 :
                      ((g1_sig_2 == 63) ? 5'd1 :
                      ((g1_sig_2 == 64) ? 5'd1 :
                      ((g1_sig_2 == 65) ? 5'd2 :
                      ((g1_sig_2 == 66) ? 5'd2 :
                      ((g1_sig_2 == 67) ? 5'd3 :
                      ((g1_sig_2 == 68) ? 5'd3 :
                      ((g1_sig_2 == 69) ? 5'd4 :
                      ((g1_sig_2 == 70) ? 5'd4 :
                      ((g1_sig_2 == 71) ? 5'd5 :
                      ((g1_sig_2 == 72) ? 5'd5 :
                      ((g1_sig_2 == 73) ? 5'd6 :
                      ((g1_sig_2 == 74) ? 5'd6 :
                      ((g1_sig_2 == 75) ? 5'd7 :
                      ((g1_sig_2 == 76) ? 5'd7 :
                      ((g1_sig_2 == 77) ? 5'd8 :
                      ((g1_sig_2 == 78) ? 5'd8 :
                      ((g1_sig_2 == 79) ? 5'd9 :
                      ((g1_sig_2 == 80) ? 5'd9 :
                      ((g1_sig_2 == 81) ? 5'd10 :
                      ((g1_sig_2 == 82) ? 5'd11 :
                      ((g1_sig_2 == 83) ? 5'd11 :
                      ((g1_sig_2 == 84) ? 5'd12 :
                      ((g1_sig_2 == 85) ? 5'd12 :
                      ((g1_sig_2 == 86) ? 5'd13 :
                      ((g1_sig_2 == 87) ? 5'd13 :
                      ((g1_sig_2 == 88) ? 5'd14 :
                      ((g1_sig_2 == 89) ? 5'd14 :
                      ((g1_sig_2 == 90) ? 5'd15 :
                      ((g1_sig_2 == 91) ? 5'd15 :
                      ((g1_sig_2 == 92) ? 5'd16 :
                      ((g1_sig_2 == 93) ? 5'd16 :
                      ((g1_sig_2 == 94) ? 5'd17 :
                      ((g1_sig_2 == 95) ? 5'd17 :
                      ((g1_sig_2 == 96) ? 5'd18 :
                      ((g1_sig_2 == 97) ? 5'd18 :
                      ((g1_sig_2 == 98) ? 5'd19 :
                      ((g1_sig_2 == 99) ? 5'd19 :
                      ((g1_sig_2 == 100) ? 5'd20 :
                      ((g1_sig_2 == 101) ? 5'd20 :
                      ((g1_sig_2 == 102) ? 5'd21 :
                      ((g1_sig_2 == 103) ? 5'd21 :
                      ((g1_sig_2 == 104) ? 5'd22 :
                      ((g1_sig_2 == 105) ? 5'd22 :
                      ((g1_sig_2 == 106) ? 5'd23 :
                      ((g1_sig_2 == 107) ? 5'd23 :
                      ((g1_sig_2 == 108) ? 5'd24 :
                      ((g1_sig_2 == 109) ? 5'd24 :
                      ((g1_sig_2 == 110) ? 5'd25 :
                      ((g1_sig_2 == 111) ? 5'd25 :
                      ((g1_sig_2 == 112) ? 5'd26 :
                      ((g1_sig_2 == 113) ? 5'd26 :
                      ((g1_sig_2 == 114) ? 5'd27 :
                      ((g1_sig_2 == 115) ? 5'd27 :
                      ((g1_sig_2 == 116) ? 5'd28 :
                      ((g1_sig_2 == 117) ? 5'd28 :
                      ((g1_sig_2 == 118) ? 5'd29 :
                      ((g1_sig_2 == 119) ? 5'd29 :
                      ((g1_sig_2 == 120) ? 5'd30 :
                      ((g1_sig_2 == 121) ? 5'd30 :
                      ((g1_sig_2 == 122) ? 5'd31 :
                      ((g1_sig_2 == 123) ? 5'd31 :
                      ((g1_sig_2 == 124) ? 5'd0 :
                      ((g1_sig_2 == 125) ? 5'd0 :
                      ((g1_sig_2 == 126) ? 5'd1 :
                      ((g1_sig_2 == 127) ? 5'd1 :
                      ((g1_sig_2 == 128) ? 5'd2 :
                      ((g1_sig_2 == 129) ? 5'd2 :
                      ((g1_sig_2 == 130) ? 5'd3 :
                      ((g1_sig_2 == 131) ? 5'd3 :
                      ((g1_sig_2 == 132) ? 5'd4 :
                      ((g1_sig_2 == 133) ? 5'd4 :
                      ((g1_sig_2 == 134) ? 5'd5 :
                      ((g1_sig_2 == 135) ? 5'd5 :
                      ((g1_sig_2 == 136) ? 5'd6 :
                      ((g1_sig_2 == 137) ? 5'd6 :
                      ((g1_sig_2 == 138) ? 5'd7 :
                      ((g1_sig_2 == 139) ? 5'd7 :
                      ((g1_sig_2 == 140) ? 5'd8 :
                      ((g1_sig_2 == 141) ? 5'd8 :
                      ((g1_sig_2 == 142) ? 5'd9 :
                      ((g1_sig_2 == 143) ? 5'd9 :
                      ((g1_sig_2 == 144) ? 5'd10 :
                      ((g1_sig_2 == 145) ? 5'd11 :
                      ((g1_sig_2 == 146) ? 5'd11 :
                      ((g1_sig_2 == 147) ? 5'd12 :
                      ((g1_sig_2 == 148) ? 5'd12 :
                      ((g1_sig_2 == 149) ? 5'd13 :
                      ((g1_sig_2 == 150) ? 5'd13 :
                      ((g1_sig_2 == 151) ? 5'd14 :
                      ((g1_sig_2 == 152) ? 5'd14 :
                      ((g1_sig_2 == 153) ? 5'd15 :
                      ((g1_sig_2 == 154) ? 5'd15 :
                      ((g1_sig_2 == 155) ? 5'd16 :
                      ((g1_sig_2 == 156) ? 5'd16 :
                      ((g1_sig_2 == 157) ? 5'd17 :
                      ((g1_sig_2 == 158) ? 5'd17 :
                      ((g1_sig_2 == 159) ? 5'd18 :
                      ((g1_sig_2 == 160) ? 5'd18 :
                      ((g1_sig_2 == 161) ? 5'd19 :
                      ((g1_sig_2 == 162) ? 5'd19 :
                      ((g1_sig_2 == 163) ? 5'd20 :
                      ((g1_sig_2 == 164) ? 5'd20 :
                      ((g1_sig_2 == 165) ? 5'd21 :
                      ((g1_sig_2 == 166) ? 5'd21 :
                      ((g1_sig_2 == 167) ? 5'd22 :
                      ((g1_sig_2 == 168) ? 5'd22 :
                      ((g1_sig_2 == 169) ? 5'd23 :
                      ((g1_sig_2 == 170) ? 5'd23 :
                      ((g1_sig_2 == 171) ? 5'd24 :
                      ((g1_sig_2 == 172) ? 5'd24 :
                      ((g1_sig_2 == 173) ? 5'd25 :
                      ((g1_sig_2 == 174) ? 5'd25 :
                      ((g1_sig_2 == 175) ? 5'd26 :
                      ((g1_sig_2 == 176) ? 5'd26 :
                      ((g1_sig_2 == 177) ? 5'd27 :
                      ((g1_sig_2 == 178) ? 5'd27 :
                      ((g1_sig_2 == 179) ? 5'd28 :
                      ((g1_sig_2 == 180) ? 5'd28 :
                      ((g1_sig_2 == 181) ? 5'd29 :
                      ((g1_sig_2 == 182) ? 5'd29 :
                      ((g1_sig_2 == 183) ? 5'd30 :
                      ((g1_sig_2 == 184) ? 5'd30 :
                      ((g1_sig_2 == 185) ? 5'd31 :
                      ((g1_sig_2 == 186) ? 5'd31 :
                      ((g1_sig_2 == 187) ? 5'd0 :
                      ((g1_sig_2 == 188) ? 5'd0 :
                      ((g1_sig_2 == 189) ? 5'd1 :
                      ((g1_sig_2 == 190) ? 5'd1 :
                      ((g1_sig_2 == 191) ? 5'd2 :
                      ((g1_sig_2 == 192) ? 5'd2 :
                      ((g1_sig_2 == 193) ? 5'd2 :
                      ((g1_sig_2 == 194) ? 5'd3 :
                      ((g1_sig_2 == 195) ? 5'd3 :
                      ((g1_sig_2 == 196) ? 5'd4 :
                      ((g1_sig_2 == 197) ? 5'd4 :
                      ((g1_sig_2 == 198) ? 5'd5 :
                      ((g1_sig_2 == 199) ? 5'd5 :
                      ((g1_sig_2 == 200) ? 5'd6 :
                      ((g1_sig_2 == 201) ? 5'd6 :
                      ((g1_sig_2 == 202) ? 5'd7 :
                      ((g1_sig_2 == 203) ? 5'd7 :
                      ((g1_sig_2 == 204) ? 5'd8 :
                      ((g1_sig_2 == 205) ? 5'd8 :
                      ((g1_sig_2 == 206) ? 5'd9 :
                      ((g1_sig_2 == 207) ? 5'd9 :
                      ((g1_sig_2 == 208) ? 5'd10 :
                      ((g1_sig_2 == 209) ? 5'd11 :
                      ((g1_sig_2 == 210) ? 5'd11 :
                      ((g1_sig_2 == 211) ? 5'd12 :
                      ((g1_sig_2 == 212) ? 5'd12 :
                      ((g1_sig_2 == 213) ? 5'd13 :
                      ((g1_sig_2 == 214) ? 5'd13 :
                      ((g1_sig_2 == 215) ? 5'd14 :
                      ((g1_sig_2 == 216) ? 5'd14 :
                      ((g1_sig_2 == 217) ? 5'd15 :
                      ((g1_sig_2 == 218) ? 5'd15 :
                      ((g1_sig_2 == 219) ? 5'd16 :
                      ((g1_sig_2 == 220) ? 5'd16 :
                      ((g1_sig_2 == 221) ? 5'd17 :
                      ((g1_sig_2 == 222) ? 5'd17 :
                      ((g1_sig_2 == 223) ? 5'd18 :
                      ((g1_sig_2 == 224) ? 5'd18 :
                      ((g1_sig_2 == 225) ? 5'd19 :
                      ((g1_sig_2 == 226) ? 5'd19 :
                      ((g1_sig_2 == 227) ? 5'd20 :
                      ((g1_sig_2 == 228) ? 5'd20 :
                      ((g1_sig_2 == 229) ? 5'd21 :
                      ((g1_sig_2 == 230) ? 5'd21 :
                      ((g1_sig_2 == 231) ? 5'd22 :
                      ((g1_sig_2 == 232) ? 5'd22 :
                      ((g1_sig_2 == 233) ? 5'd23 :
                      ((g1_sig_2 == 234) ? 5'd23 :
                      ((g1_sig_2 == 235) ? 5'd24 :
                      ((g1_sig_2 == 236) ? 5'd24 :
                      ((g1_sig_2 == 237) ? 5'd25 :
                      ((g1_sig_2 == 238) ? 5'd25 :
                      ((g1_sig_2 == 239) ? 5'd26 :
                      ((g1_sig_2 == 240) ? 5'd26 :
                      ((g1_sig_2 == 241) ? 5'd27 :
                      ((g1_sig_2 == 242) ? 5'd27 :
                      ((g1_sig_2 == 243) ? 5'd28 :
                      ((g1_sig_2 == 244) ? 5'd28 :
                      ((g1_sig_2 == 245) ? 5'd29 :
                      ((g1_sig_2 == 246) ? 5'd29 :
                      ((g1_sig_2 == 247) ? 5'd30 :
                      ((g1_sig_2 == 248) ? 5'd30 :
                      ((g1_sig_2 == 249) ? 5'd31 :
                      ((g1_sig_2 == 250) ? 5'd31 :
                      ((g1_sig_2 == 251) ? 5'd0 :
                      ((g1_sig_2 == 252) ? 5'd0 :
                      ((g1_sig_2 == 253) ? 5'd1 :
                      ((g1_sig_2 == 254) ? 5'd1 :
                      5'd2)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign g1_sig_5 = ((g1_sig_2 == 0) ? 3'd1 :
                      ((g1_sig_2 == 1) ? 3'd1 :
                      ((g1_sig_2 == 2) ? 3'd1 :
                      ((g1_sig_2 == 3) ? 3'd1 :
                      ((g1_sig_2 == 4) ? 3'd1 :
                      ((g1_sig_2 == 5) ? 3'd1 :
                      ((g1_sig_2 == 6) ? 3'd2 :
                      ((g1_sig_2 == 7) ? 3'd2 :
                      ((g1_sig_2 == 8) ? 3'd2 :
                      ((g1_sig_2 == 9) ? 3'd2 :
                      ((g1_sig_2 == 10) ? 3'd2 :
                      ((g1_sig_2 == 11) ? 3'd2 :
                      ((g1_sig_2 == 12) ? 3'd3 :
                      ((g1_sig_2 == 13) ? 3'd3 :
                      ((g1_sig_2 == 14) ? 3'd3 :
                      ((g1_sig_2 == 15) ? 3'd3 :
                      ((g1_sig_2 == 16) ? 3'd3 :
                      ((g1_sig_2 == 17) ? 3'd4 :
                      ((g1_sig_2 == 18) ? 3'd4 :
                      ((g1_sig_2 == 19) ? 3'd4 :
                      ((g1_sig_2 == 20) ? 3'd4 :
                      ((g1_sig_2 == 21) ? 3'd4 :
                      ((g1_sig_2 == 22) ? 3'd4 :
                      ((g1_sig_2 == 23) ? 3'd5 :
                      ((g1_sig_2 == 24) ? 3'd5 :
                      ((g1_sig_2 == 25) ? 3'd5 :
                      ((g1_sig_2 == 26) ? 3'd5 :
                      ((g1_sig_2 == 27) ? 3'd5 :
                      ((g1_sig_2 == 28) ? 3'd5 :
                      ((g1_sig_2 == 29) ? 3'd6 :
                      ((g1_sig_2 == 30) ? 3'd6 :
                      ((g1_sig_2 == 31) ? 3'd6 :
                      ((g1_sig_2 == 32) ? 3'd6 :
                      ((g1_sig_2 == 33) ? 3'd6 :
                      ((g1_sig_2 == 34) ? 3'd6 :
                      ((g1_sig_2 == 35) ? 3'd6 :
                      ((g1_sig_2 == 36) ? 3'd6 :
                      ((g1_sig_2 == 37) ? 3'd6 :
                      ((g1_sig_2 == 38) ? 3'd6 :
                      ((g1_sig_2 == 39) ? 3'd6 :
                      ((g1_sig_2 == 40) ? 3'd6 :
                      ((g1_sig_2 == 41) ? 3'd6 :
                      ((g1_sig_2 == 42) ? 3'd6 :
                      ((g1_sig_2 == 43) ? 3'd6 :
                      ((g1_sig_2 == 44) ? 3'd6 :
                      ((g1_sig_2 == 45) ? 3'd6 :
                      ((g1_sig_2 == 46) ? 3'd6 :
                      ((g1_sig_2 == 47) ? 3'd6 :
                      ((g1_sig_2 == 48) ? 3'd6 :
                      ((g1_sig_2 == 49) ? 3'd6 :
                      ((g1_sig_2 == 50) ? 3'd6 :
                      ((g1_sig_2 == 51) ? 3'd6 :
                      ((g1_sig_2 == 52) ? 3'd6 :
                      ((g1_sig_2 == 53) ? 3'd6 :
                      ((g1_sig_2 == 54) ? 3'd6 :
                      ((g1_sig_2 == 55) ? 3'd6 :
                      ((g1_sig_2 == 56) ? 3'd6 :
                      ((g1_sig_2 == 57) ? 3'd6 :
                      ((g1_sig_2 == 58) ? 3'd6 :
                      ((g1_sig_2 == 59) ? 3'd6 :
                      ((g1_sig_2 == 60) ? 3'd6 :
                      ((g1_sig_2 == 61) ? 3'd6 :
                      ((g1_sig_2 == 62) ? 3'd6 :
                      ((g1_sig_2 == 63) ? 3'd6 :
                      ((g1_sig_2 == 64) ? 3'd1 :
                      ((g1_sig_2 == 65) ? 3'd1 :
                      ((g1_sig_2 == 66) ? 3'd1 :
                      ((g1_sig_2 == 67) ? 3'd1 :
                      ((g1_sig_2 == 68) ? 3'd1 :
                      ((g1_sig_2 == 69) ? 3'd2 :
                      ((g1_sig_2 == 70) ? 3'd2 :
                      ((g1_sig_2 == 71) ? 3'd2 :
                      ((g1_sig_2 == 72) ? 3'd2 :
                      ((g1_sig_2 == 73) ? 3'd2 :
                      ((g1_sig_2 == 74) ? 3'd2 :
                      ((g1_sig_2 == 75) ? 3'd3 :
                      ((g1_sig_2 == 76) ? 3'd3 :
                      ((g1_sig_2 == 77) ? 3'd3 :
                      ((g1_sig_2 == 78) ? 3'd3 :
                      ((g1_sig_2 == 79) ? 3'd3 :
                      ((g1_sig_2 == 80) ? 3'd3 :
                      ((g1_sig_2 == 81) ? 3'd4 :
                      ((g1_sig_2 == 82) ? 3'd4 :
                      ((g1_sig_2 == 83) ? 3'd4 :
                      ((g1_sig_2 == 84) ? 3'd4 :
                      ((g1_sig_2 == 85) ? 3'd4 :
                      ((g1_sig_2 == 86) ? 3'd5 :
                      ((g1_sig_2 == 87) ? 3'd5 :
                      ((g1_sig_2 == 88) ? 3'd5 :
                      ((g1_sig_2 == 89) ? 3'd5 :
                      ((g1_sig_2 == 90) ? 3'd5 :
                      ((g1_sig_2 == 91) ? 3'd5 :
                      ((g1_sig_2 == 92) ? 3'd6 :
                      ((g1_sig_2 == 93) ? 3'd6 :
                      ((g1_sig_2 == 94) ? 3'd6 :
                      ((g1_sig_2 == 95) ? 3'd6 :
                      ((g1_sig_2 == 96) ? 3'd6 :
                      ((g1_sig_2 == 97) ? 3'd6 :
                      ((g1_sig_2 == 98) ? 3'd6 :
                      ((g1_sig_2 == 99) ? 3'd6 :
                      ((g1_sig_2 == 100) ? 3'd6 :
                      ((g1_sig_2 == 101) ? 3'd6 :
                      ((g1_sig_2 == 102) ? 3'd6 :
                      ((g1_sig_2 == 103) ? 3'd6 :
                      ((g1_sig_2 == 104) ? 3'd6 :
                      ((g1_sig_2 == 105) ? 3'd6 :
                      ((g1_sig_2 == 106) ? 3'd6 :
                      ((g1_sig_2 == 107) ? 3'd6 :
                      ((g1_sig_2 == 108) ? 3'd6 :
                      ((g1_sig_2 == 109) ? 3'd6 :
                      ((g1_sig_2 == 110) ? 3'd6 :
                      ((g1_sig_2 == 111) ? 3'd6 :
                      ((g1_sig_2 == 112) ? 3'd6 :
                      ((g1_sig_2 == 113) ? 3'd6 :
                      ((g1_sig_2 == 114) ? 3'd6 :
                      ((g1_sig_2 == 115) ? 3'd6 :
                      ((g1_sig_2 == 116) ? 3'd6 :
                      ((g1_sig_2 == 117) ? 3'd6 :
                      ((g1_sig_2 == 118) ? 3'd6 :
                      ((g1_sig_2 == 119) ? 3'd6 :
                      ((g1_sig_2 == 120) ? 3'd6 :
                      ((g1_sig_2 == 121) ? 3'd6 :
                      ((g1_sig_2 == 122) ? 3'd6 :
                      ((g1_sig_2 == 123) ? 3'd6 :
                      ((g1_sig_2 == 124) ? 3'd6 :
                      ((g1_sig_2 == 125) ? 3'd6 :
                      ((g1_sig_2 == 126) ? 3'd6 :
                      ((g1_sig_2 == 127) ? 3'd6 :
                      ((g1_sig_2 == 128) ? 3'd1 :
                      ((g1_sig_2 == 129) ? 3'd1 :
                      ((g1_sig_2 == 130) ? 3'd1 :
                      ((g1_sig_2 == 131) ? 3'd1 :
                      ((g1_sig_2 == 132) ? 3'd2 :
                      ((g1_sig_2 == 133) ? 3'd2 :
                      ((g1_sig_2 == 134) ? 3'd2 :
                      ((g1_sig_2 == 135) ? 3'd2 :
                      ((g1_sig_2 == 136) ? 3'd2 :
                      ((g1_sig_2 == 137) ? 3'd2 :
                      ((g1_sig_2 == 138) ? 3'd3 :
                      ((g1_sig_2 == 139) ? 3'd3 :
                      ((g1_sig_2 == 140) ? 3'd3 :
                      ((g1_sig_2 == 141) ? 3'd3 :
                      ((g1_sig_2 == 142) ? 3'd3 :
                      ((g1_sig_2 == 143) ? 3'd3 :
                      ((g1_sig_2 == 144) ? 3'd4 :
                      ((g1_sig_2 == 145) ? 3'd4 :
                      ((g1_sig_2 == 146) ? 3'd4 :
                      ((g1_sig_2 == 147) ? 3'd4 :
                      ((g1_sig_2 == 148) ? 3'd4 :
                      ((g1_sig_2 == 149) ? 3'd5 :
                      ((g1_sig_2 == 150) ? 3'd5 :
                      ((g1_sig_2 == 151) ? 3'd5 :
                      ((g1_sig_2 == 152) ? 3'd5 :
                      ((g1_sig_2 == 153) ? 3'd5 :
                      ((g1_sig_2 == 154) ? 3'd5 :
                      ((g1_sig_2 == 155) ? 3'd6 :
                      ((g1_sig_2 == 156) ? 3'd6 :
                      ((g1_sig_2 == 157) ? 3'd6 :
                      ((g1_sig_2 == 158) ? 3'd6 :
                      ((g1_sig_2 == 159) ? 3'd6 :
                      ((g1_sig_2 == 160) ? 3'd6 :
                      ((g1_sig_2 == 161) ? 3'd6 :
                      ((g1_sig_2 == 162) ? 3'd6 :
                      ((g1_sig_2 == 163) ? 3'd6 :
                      ((g1_sig_2 == 164) ? 3'd6 :
                      ((g1_sig_2 == 165) ? 3'd6 :
                      ((g1_sig_2 == 166) ? 3'd6 :
                      ((g1_sig_2 == 167) ? 3'd6 :
                      ((g1_sig_2 == 168) ? 3'd6 :
                      ((g1_sig_2 == 169) ? 3'd6 :
                      ((g1_sig_2 == 170) ? 3'd6 :
                      ((g1_sig_2 == 171) ? 3'd6 :
                      ((g1_sig_2 == 172) ? 3'd6 :
                      ((g1_sig_2 == 173) ? 3'd6 :
                      ((g1_sig_2 == 174) ? 3'd6 :
                      ((g1_sig_2 == 175) ? 3'd6 :
                      ((g1_sig_2 == 176) ? 3'd6 :
                      ((g1_sig_2 == 177) ? 3'd6 :
                      ((g1_sig_2 == 178) ? 3'd6 :
                      ((g1_sig_2 == 179) ? 3'd6 :
                      ((g1_sig_2 == 180) ? 3'd6 :
                      ((g1_sig_2 == 181) ? 3'd6 :
                      ((g1_sig_2 == 182) ? 3'd6 :
                      ((g1_sig_2 == 183) ? 3'd6 :
                      ((g1_sig_2 == 184) ? 3'd6 :
                      ((g1_sig_2 == 185) ? 3'd6 :
                      ((g1_sig_2 == 186) ? 3'd6 :
                      ((g1_sig_2 == 187) ? 3'd6 :
                      ((g1_sig_2 == 188) ? 3'd6 :
                      ((g1_sig_2 == 189) ? 3'd6 :
                      ((g1_sig_2 == 190) ? 3'd6 :
                      ((g1_sig_2 == 191) ? 3'd6 :
                      ((g1_sig_2 == 192) ? 3'd1 :
                      ((g1_sig_2 == 193) ? 3'd1 :
                      ((g1_sig_2 == 194) ? 3'd1 :
                      ((g1_sig_2 == 195) ? 3'd1 :
                      ((g1_sig_2 == 196) ? 3'd2 :
                      ((g1_sig_2 == 197) ? 3'd2 :
                      ((g1_sig_2 == 198) ? 3'd2 :
                      ((g1_sig_2 == 199) ? 3'd2 :
                      ((g1_sig_2 == 200) ? 3'd2 :
                      ((g1_sig_2 == 201) ? 3'd2 :
                      ((g1_sig_2 == 202) ? 3'd3 :
                      ((g1_sig_2 == 203) ? 3'd3 :
                      ((g1_sig_2 == 204) ? 3'd3 :
                      ((g1_sig_2 == 205) ? 3'd3 :
                      ((g1_sig_2 == 206) ? 3'd3 :
                      ((g1_sig_2 == 207) ? 3'd3 :
                      ((g1_sig_2 == 208) ? 3'd4 :
                      ((g1_sig_2 == 209) ? 3'd4 :
                      ((g1_sig_2 == 210) ? 3'd4 :
                      ((g1_sig_2 == 211) ? 3'd4 :
                      ((g1_sig_2 == 212) ? 3'd4 :
                      ((g1_sig_2 == 213) ? 3'd5 :
                      ((g1_sig_2 == 214) ? 3'd5 :
                      ((g1_sig_2 == 215) ? 3'd5 :
                      ((g1_sig_2 == 216) ? 3'd5 :
                      ((g1_sig_2 == 217) ? 3'd5 :
                      ((g1_sig_2 == 218) ? 3'd5 :
                      ((g1_sig_2 == 219) ? 3'd6 :
                      ((g1_sig_2 == 220) ? 3'd6 :
                      ((g1_sig_2 == 221) ? 3'd6 :
                      ((g1_sig_2 == 222) ? 3'd6 :
                      ((g1_sig_2 == 223) ? 3'd6 :
                      ((g1_sig_2 == 224) ? 3'd6 :
                      ((g1_sig_2 == 225) ? 3'd6 :
                      ((g1_sig_2 == 226) ? 3'd6 :
                      ((g1_sig_2 == 227) ? 3'd6 :
                      ((g1_sig_2 == 228) ? 3'd6 :
                      ((g1_sig_2 == 229) ? 3'd6 :
                      ((g1_sig_2 == 230) ? 3'd6 :
                      ((g1_sig_2 == 231) ? 3'd6 :
                      ((g1_sig_2 == 232) ? 3'd6 :
                      ((g1_sig_2 == 233) ? 3'd6 :
                      ((g1_sig_2 == 234) ? 3'd6 :
                      ((g1_sig_2 == 235) ? 3'd6 :
                      ((g1_sig_2 == 236) ? 3'd6 :
                      ((g1_sig_2 == 237) ? 3'd6 :
                      ((g1_sig_2 == 238) ? 3'd6 :
                      ((g1_sig_2 == 239) ? 3'd6 :
                      ((g1_sig_2 == 240) ? 3'd6 :
                      ((g1_sig_2 == 241) ? 3'd6 :
                      ((g1_sig_2 == 242) ? 3'd6 :
                      ((g1_sig_2 == 243) ? 3'd6 :
                      ((g1_sig_2 == 244) ? 3'd6 :
                      ((g1_sig_2 == 245) ? 3'd6 :
                      ((g1_sig_2 == 246) ? 3'd6 :
                      ((g1_sig_2 == 247) ? 3'd6 :
                      ((g1_sig_2 == 248) ? 3'd6 :
                      ((g1_sig_2 == 249) ? 3'd6 :
                      ((g1_sig_2 == 250) ? 3'd6 :
                      ((g1_sig_2 == 251) ? 3'd6 :
                      ((g1_sig_2 == 252) ? 3'd6 :
                      ((g1_sig_2 == 253) ? 3'd6 :
                      ((g1_sig_2 == 254) ? 3'd6 :
                      3'd6)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign g1_sig_6 = (({4'd0, fx_addr_n[6:0]} + {2'd0, rowb_q}) + 11'd127);
    assign g1_nbeat = (strm_q ? g1_sig_4 : {2'd0, g1_sig_6[9:7]});
    assign g1_nbuf = (strm_q ? g1_sig_5 : 3'd1);
    assign g1_byts = (strm_q ? {g1_sig_3, 6'd0} : {3'd0, rowb_q});
    assign g1_last = (strm_q ? (fx_rl_n <= 32) : (fx_rl_n == 1));
    assign g1_more = (fx_rl_n != 0);
    assign fx_bufbusy6 = (occ > 26);
    assign fx_go = ((act & fx_more) & (~(strm_q ? fx_bufbusy6 : fx_bufbusy)));
    assign ar_bytes = {8'd0, fx_byq};
    assign fx_bs5 = ({1'd0, fx_buf} + {3'd0, fx_nbuf});
    assign fx_buf_n = fx_bs5[4:0];
    assign ar_req = (fx_go & (fx_ost < 12));
    assign ar_addr = fx_addr;
    assign ar_cfg = cfg_q;
    assign ar_first = fx_firstq;
    assign ar_last = fx_lastq;
    assign ar_fire_c = (ar_req & ar_gnt);
    assign cv_t = cv_tq;
    assign cv_set = (cv_t ? cv_1_set : cv_0_set);
    assign cv_q8 = (cv_t ? cv_1_q8 : cv_0_q8);
    assign cv_kmj = (cv_t ? cv_1_kmj : cv_0_kmj);
    assign cv_strm = (cv_t ? cv_1_strm : cv_0_strm);
    assign rx_buf = arq_buf[arq_rp];
    assign rx_nb = arq_nb[arq_rp];
    assign rx_st = arq_st[arq_rp];
    assign rx_last = (rx_cnt == (rx_nb - 5'd1));
    assign rx_s = ({1'd0, rx_buf} + {3'd0, rx_bo});
    assign rx_wi = rx_s[4:0];
    assign cv_bufv = (vcnt != 0);
    assign cv_row = st_row;
    assign st_blast = st_l1;
    assign st_onr = (cv_t ? cv_0_nrows : cv_1_nrows);
    assign p_nv0 = ((p_klim > 32) ? 6'd32 : p_klim[5:0]);
    assign p_l1 = (p_klim - 8'd32);
    assign p_nv1 = ((p_l1[7] | (p_l1 == 0)) ? 6'd0 : ((p_l1 > 32) ? 6'd32 : p_l1[5:0]));
    assign cv_nv0 = (cv_t ? cv_1_nv0 : cv_0_nv0);
    assign cv_nv1 = (cv_t ? cv_1_nv1 : cv_0_nv1);
    assign s0_ok0 = {(6'd31 < s0_nv0), (6'd30 < s0_nv0), (6'd29 < s0_nv0), (6'd28 < s0_nv0), (6'd27 < s0_nv0),
                     (6'd26 < s0_nv0), (6'd25 < s0_nv0), (6'd24 < s0_nv0), (6'd23 < s0_nv0), (6'd22 < s0_nv0),
                     (6'd21 < s0_nv0), (6'd20 < s0_nv0), (6'd19 < s0_nv0), (6'd18 < s0_nv0), (6'd17 < s0_nv0),
                     (6'd16 < s0_nv0), (6'd15 < s0_nv0), (6'd14 < s0_nv0), (6'd13 < s0_nv0), (6'd12 < s0_nv0),
                     (6'd11 < s0_nv0), (6'd10 < s0_nv0), (6'd9 < s0_nv0), (6'd8 < s0_nv0), (6'd7 < s0_nv0),
                     (6'd6 < s0_nv0), (6'd5 < s0_nv0), (6'd4 < s0_nv0), (6'd3 < s0_nv0), (6'd2 < s0_nv0),
                     (6'd1 < s0_nv0), (6'd0 < s0_nv0)};
    assign s0_ok1 = {(6'd31 < s0_nv1), (6'd30 < s0_nv1), (6'd29 < s0_nv1), (6'd28 < s0_nv1), (6'd27 < s0_nv1),
                     (6'd26 < s0_nv1), (6'd25 < s0_nv1), (6'd24 < s0_nv1), (6'd23 < s0_nv1), (6'd22 < s0_nv1),
                     (6'd21 < s0_nv1), (6'd20 < s0_nv1), (6'd19 < s0_nv1), (6'd18 < s0_nv1), (6'd17 < s0_nv1),
                     (6'd16 < s0_nv1), (6'd15 < s0_nv1), (6'd14 < s0_nv1), (6'd13 < s0_nv1), (6'd12 < s0_nv1),
                     (6'd11 < s0_nv1), (6'd10 < s0_nv1), (6'd9 < s0_nv1), (6'd8 < s0_nv1), (6'd7 < s0_nv1),
                     (6'd6 < s0_nv1), (6'd5 < s0_nv1), (6'd4 < s0_nv1), (6'd3 < s0_nv1), (6'd2 < s0_nv1),
                     (6'd1 < s0_nv1), (6'd0 < s0_nv1)};
    assign nv_w0 = w_nv0;
    assign nv_w1 = w_nv1;
    assign c0_s_0 = bcol0_0[cv_bufr_0];
    assign c0_s_1 = bcol0_1[cv_bufr_1];
    assign c0_s_2 = bcol0_2[cv_bufr_2];
    assign c0_s_3 = bcol0_3[cv_bufr_3];
    assign c0_s_4 = bcol0_4[cv_bufr_4];
    assign c0_s_5 = bcol0_5[cv_bufr_5];
    assign c0_s_6 = bcol0_6[cv_bufr_6];
    assign c0_s_7 = bcol0_7[cv_bufr_7];
    assign c0_d = {c0_s_7, c0_s_6, c0_s_5, c0_s_4, c0_s_3, c0_s_2, c0_s_1, c0_s_0};
    assign cv_go = (cv_bufv & (~cv_strm));
    assign cv_cb1 = ({1'd0, cv_buf} + 6'd1);
    assign cv_buf1 = cv_cb1[4:0];
    assign c1_s_0 = bcol1_0[cv_bufr_8];
    assign c2_s_0 = bcol2_0[cv_bufr_16];
    assign c1_s_1 = bcol1_1[cv_bufr_9];
    assign c2_s_1 = bcol2_1[cv_bufr_17];
    assign c1_s_2 = bcol1_2[cv_bufr_10];
    assign c2_s_2 = bcol2_2[cv_bufr_18];
    assign c1_s_3 = bcol1_3[cv_bufr_11];
    assign c2_s_3 = bcol2_3[cv_bufr_19];
    assign c1_s_4 = bcol1_4[cv_bufr_12];
    assign c2_s_4 = bcol2_4[cv_bufr_20];
    assign c1_s_5 = bcol1_5[cv_bufr_13];
    assign c2_s_5 = bcol2_5[cv_bufr_21];
    assign c1_s_6 = bcol1_6[cv_bufr_14];
    assign c2_s_6 = bcol2_6[cv_bufr_22];
    assign c1_s_7 = bcol1_7[cv_bufr_15];
    assign c2_s_7 = bcol2_7[cv_bufr_23];
    assign c1_d = {c1_s_7, c1_s_6, c1_s_5, c1_s_4, c1_s_3, c1_s_2, c1_s_1, c1_s_0};
    assign c2_d = {c2_s_7, c2_s_6, c2_s_5, c2_s_4, c2_s_3, c2_s_2, c2_s_1, c2_s_0};
    assign cur_s_0 = ((cv_colr_0 == 0) ? c0_s_0 : ((cv_colr_0 == 1) ? c1_s_0 : ((cv_colr_0 == 2) ? c2_s_0 : c2_s_0)));
    assign cur_s_1 = ((cv_colr_1 == 0) ? c0_s_1 : ((cv_colr_1 == 1) ? c1_s_1 : ((cv_colr_1 == 2) ? c2_s_1 : c2_s_1)));
    assign cur_s_2 = ((cv_colr_2 == 0) ? c0_s_2 : ((cv_colr_2 == 1) ? c1_s_2 : ((cv_colr_2 == 2) ? c2_s_2 : c2_s_2)));
    assign cur_s_3 = ((cv_colr_3 == 0) ? c0_s_3 : ((cv_colr_3 == 1) ? c1_s_3 : ((cv_colr_3 == 2) ? c2_s_3 : c2_s_3)));
    assign cur_s_4 = ((cv_colr_4 == 0) ? c0_s_4 : ((cv_colr_4 == 1) ? c1_s_4 : ((cv_colr_4 == 2) ? c2_s_4 : c2_s_4)));
    assign cur_s_5 = ((cv_colr_5 == 0) ? c0_s_5 : ((cv_colr_5 == 1) ? c1_s_5 : ((cv_colr_5 == 2) ? c2_s_5 : c2_s_5)));
    assign cur_s_6 = ((cv_colr_6 == 0) ? c0_s_6 : ((cv_colr_6 == 1) ? c1_s_6 : ((cv_colr_6 == 2) ? c2_s_6 : c2_s_6)));
    assign cur_s_7 = ((cv_colr_7 == 0) ? c0_s_7 : ((cv_colr_7 == 1) ? c1_s_7 : ((cv_colr_7 == 2) ? c2_s_7 : c2_s_7)));
    assign cur_beat = {cur_s_7, cur_s_6, cur_s_5, cur_s_4, cur_s_3, cur_s_2, cur_s_1, cur_s_0};
    assign rs_grp = {64'd0, c0_d};
    assign st_sca = (st_row[4:0] == 0);
    assign st_scb = ((st_row[4:0] == 15) & (~st_blast));
    assign st_two = (((~st_sca) & (~st_scb)) & (~st_blast));
    assign take_s = (cv_strm & (avail >= 1));
    assign sc_cur = (s0_sca ? s0_d[511:0] : sc_lat);
    assign unit_a = (s0_sca ? s0_d[1023:512] : s0_d[511:0]);
    assign unit_b = s0_d[1023:512];
    assign st_gra = {unit_a[511:256], sc_cur[31:16], unit_a[255:0], sc_cur[15:0]};
    assign st_grb = {unit_b[511:256], sc_cur[63:48], unit_b[255:0], sc_cur[47:32]};
    assign st_grp = {st_grb, st_gra};
    assign sc_sh = (s0_two ? (sc_cur >> 64) : (sc_cur >> 32));
    assign sc_next = (s0_scb ? s0_d[1023:512] : sc_sh);
    assign st_nrow = (st_row + (st_two ? 8'd2 : 8'd1));
    assign st_end = (st_two ? st_l2 : st_l1);
    assign st_pend = ((st_nrow[4:0] == 0) | st_end);
    assign st_c1w = (cv_col == 2);
    assign st_b1 = (st_c1w ? cv_buf1 : cv_buf);
    assign st_c1 = (st_c1w ? 2'd0 : (cv_col + 1));
    assign st_tw = (st_pend & (st_c1 != 0));
    assign st_b2 = (st_tw ? (st_b1 + 1) : st_b1);
    assign st_c2 = (st_tw ? 2'd0 : st_c1);
    assign cv_rel = (take_s ? (st_c1w | st_tw) : cv_go);
    assign occ_n = ((occ + (ar_fire_c ? {3'd0, fx_nbuf} : 6'd0)) - {5'd0, cv_rel});
    assign st_take = (take_s ? (st_two ? 8'd2 : 8'd1) : {7'd0, cv_go});
    assign st_bend = (take_s ? st_end : (cv_go & st_l1));
    assign cva_pk = {u_cva1_mz, u_cva0_mz};
    assign cvt_row = {u_cvb1_f, u_cvb0_f};
    assign em_row = {em_w1, em_w0};
    assign q8a_row = {u_q8a1_q, u_q8a0_q};
    assign q8b_row = {u_q8b1_q, u_q8b0_q};
    assign q8a_eb = {u_q8a1_eb, u_q8a1_ms, u_q8a0_eb, u_q8a0_ms};
    assign q8b_eb = {u_q8b1_eb, u_q8b1_ms, u_q8b0_eb, u_q8b0_ms};
    assign f16_eb = {{1'd0, em_w1}, 11'd1024, {1'd0, em_w0}, 11'd1024};
    assign row_eb = (w_q8 ? q8a_eb : f16_eb);
    assign w_odd = w_row[0];
    assign st_pair = ((w_v & w_strm) & (w_two | w_odd));
    assign st_pa_row = (w_odd ? pa_row : w_row);
    assign st_pa_eb = (w_odd ? pa_eb : q8a_eb);
    assign st_pb_eb = (w_odd ? q8a_eb : q8b_eb);
    assign st_left_n = (st_bend ? ((start & (fp != cv_tq)) ? p_nrows : st_onr) :
                       ((start & (fp == cv_tq)) ? p_nrows :
                       (st_left - st_take)));
    assign busy = ((act | cv_0_tact) | cv_1_tact);
    assign fx_free = ((~act) & (~(fp ? cv_1_tact : cv_0_tact)));
    assign rows_done0 = cv_0_rd;
    assign tag_q0 = cv_0_tag;
    assign rows_done1 = cv_1_rd;
    assign tag_q1 = cv_1_tag;
    assign done_p = done_pr;
    assign done_slot = done_slot_q;
    assign slot_q = slot_qr;
    assign set_q = bw_set_q;
    assign bw_en = bw_en_q;
    assign bw_r = bw_r_q;
    assign bw_data = bw_data_q;
    assign bw_e_en = bw_e_en_q;
    assign bw_eb = bw_eb_q;
    assign bw_data2 = bw_data2_q;
    assign bw_eb2 = bw_eb2_q;
    assign bw_dual = bw_dual_q;
    assign kmj = bw_kmj_q;
    assign clr_q = clr_qr;
    assign clr_set = clr_set_q;
    assign ar_fire = ar_fire_c;
    assign rx_fire = ((fx_ost != 0) & r_valid);
    assign rx_pop = (rx_fire & rx_last);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            done_pr <= 0;
            bw_en_q <= 0;
            bw_e_en_q <= 0;
            bw_dual_q <= 0;
            clr_qr <= 0;
            act <= 0;
            strd_q <= 0;
            rowb_q <= 0;
            nrows_q <= 0;
            cfg_q <= 0;
            klim_q <= 0;
            slot_qr <= 0;
            ftp <= 0;
            fp <= 0;
            cv_0_tact <= 0;
            cv_0_nrows <= 0;
            cv_0_nv0 <= 0;
            cv_0_nv1 <= 0;
            cv_0_set <= 0;
            cv_0_tag <= 0;
            cv_0_slot <= 0;
            cv_0_rd <= 0;
            cv_0_q8 <= 0;
            cv_0_kmj <= 0;
            cv_0_strm <= 0;
            cv_1_tact <= 0;
            cv_1_nrows <= 0;
            cv_1_nv0 <= 0;
            cv_1_nv1 <= 0;
            cv_1_set <= 0;
            cv_1_tag <= 0;
            cv_1_slot <= 0;
            cv_1_rd <= 0;
            cv_1_q8 <= 0;
            cv_1_kmj <= 0;
            cv_1_strm <= 0;
            q8_q <= 0;
            strm_q <= 0;
            clr_set_q <= 0;
            arq_wp <= 0;
            fx_addr <= 0;
            fx_rleft <= 0;
            fx_firstq <= 1;
            fx_row <= 0;
            fx_buf <= 0;
            fx_more <= 0;
            fx_lastq <= 0;
            fx_rtq <= 0;
            fx_nbq <= 0;
            fx_nfq <= 1;
            fx_byq <= 0;
            occ <= 0;
            st_left <= 0;
            st_l1 <= 0;
            st_l2 <= 0;
            vcnt <= 0;
            wr_we_0 <= 0;
            wr_we_1 <= 0;
            wr_we_2 <= 0;
            wr_we_3 <= 0;
            wr_we_4 <= 0;
            wr_we_5 <= 0;
            wr_we_6 <= 0;
            wr_we_7 <= 0;
            wr_we_8 <= 0;
            wr_we_9 <= 0;
            wr_we_10 <= 0;
            wr_we_11 <= 0;
            wr_we_12 <= 0;
            wr_we_13 <= 0;
            wr_we_14 <= 0;
            wr_we_15 <= 0;
            wr_we_16 <= 0;
            wr_we_17 <= 0;
            wr_we_18 <= 0;
            wr_we_19 <= 0;
            wr_we_20 <= 0;
            wr_we_21 <= 0;
            wr_we_22 <= 0;
            wr_we_23 <= 0;
            wr_setv <= 0;
            wr_s <= 0;
            arq_rp <= 0;
            rx_cnt <= 0;
            rx_bc <= 0;
            rx_bo <= 0;
            fx_ost <= 0;
            bw_r_q <= 0;
            bw_set_q <= 0;
            bw_kmj_q <= 0;
            done_slot_q <= 0;
            pa_v <= 0;
            pa_row <= 0;
            pa_set <= 0;
            pa_t <= 0;
            w_v <= 0;
            em_w0 <= 0;
            em_w1 <= 0;
            w_row <= 0;
            w_two <= 0;
            w_t <= 0;
            w_set <= 0;
            w_nv0 <= 0;
            w_nv1 <= 0;
            w_q8 <= 0;
            w_kmj <= 0;
            w_strm <= 0;
            w1_v <= 0;
            em1_0 <= 0;
            em1_1 <= 0;
            w1_row <= 0;
            w1_two <= 0;
            w1_t <= 0;
            w1_set <= 0;
            w1_nv0 <= 0;
            w1_nv1 <= 0;
            w1_q8 <= 0;
            w1_kmj <= 0;
            w1_strm <= 0;
            e_v <= 0;
            e_row <= 0;
            e_two <= 0;
            e_t <= 0;
            e_set <= 0;
            e_nv0 <= 0;
            e_nv1 <= 0;
            e_q8 <= 0;
            e_kmj <= 0;
            e_strm <= 0;
            avail <= 0;
            s_v <= 0;
            s_row <= 0;
            s_two <= 0;
            s_t <= 0;
            s_set <= 0;
            s_nv0 <= 0;
            s_nv1 <= 0;
            s_q8 <= 0;
            s_kmj <= 0;
            s_strm <= 0;
            cv_buf <= 0;
            cv_bufr_0 <= 0;
            cv_bufr_1 <= 0;
            cv_bufr_2 <= 0;
            cv_bufr_3 <= 0;
            cv_bufr_4 <= 0;
            cv_bufr_5 <= 0;
            cv_bufr_6 <= 0;
            cv_bufr_7 <= 0;
            cv_bufr_8 <= 0;
            cv_bufr_9 <= 0;
            cv_bufr_10 <= 0;
            cv_bufr_11 <= 0;
            cv_bufr_12 <= 0;
            cv_bufr_13 <= 0;
            cv_bufr_14 <= 0;
            cv_bufr_15 <= 0;
            cv_bufr_16 <= 0;
            cv_bufr_17 <= 0;
            cv_bufr_18 <= 0;
            cv_bufr_19 <= 0;
            cv_bufr_20 <= 0;
            cv_bufr_21 <= 0;
            cv_bufr_22 <= 0;
            cv_bufr_23 <= 0;
            cv_col <= 0;
            cv_colr_0 <= 0;
            cv_colr_1 <= 0;
            cv_colr_2 <= 0;
            cv_colr_3 <= 0;
            cv_colr_4 <= 0;
            cv_colr_5 <= 0;
            cv_colr_6 <= 0;
            cv_colr_7 <= 0;
            s0_v <= 0;
            s0_strm <= 0;
            s0_sca <= 0;
            s0_scb <= 0;
            s0_two <= 0;
            s0_row <= 0;
            s0_t <= 0;
            s0_set <= 0;
            s0_nv0 <= 0;
            s0_nv1 <= 0;
            s0_q8 <= 0;
            s0_kmj <= 0;
            st_row <= 0;
            cv_tq <= 0;
        end else begin
            done_pr <= 0;
            bw_en_q <= 0;
            bw_e_en_q <= 0;
            bw_dual_q <= 0;
            clr_qr <= 0;
            if (start) begin
                act <= 1;
                strd_q <= p_strd;
                rowb_q <= p_rowb;
                nrows_q <= p_nrows;
                cfg_q <= p_cfg;
                klim_q <= p_klim;
                slot_qr <= p_slot;
                ftp <= fp;
                fp <= (~fp);
                if ((fp == 0)) begin
                    cv_0_tact <= 1;
                    cv_0_nrows <= p_nrows;
                    cv_0_nv0 <= p_nv0;
                    cv_0_nv1 <= p_nv1;
                    cv_0_set <= p_set;
                    cv_0_tag <= p_tag;
                    cv_0_slot <= p_slot;
                    cv_0_rd <= 0;
                    cv_0_q8 <= p_q8;
                    cv_0_kmj <= p_kmj;
                    cv_0_strm <= p_strm;
                end
                if ((fp == 1)) begin
                    cv_1_tact <= 1;
                    cv_1_nrows <= p_nrows;
                    cv_1_nv0 <= p_nv0;
                    cv_1_nv1 <= p_nv1;
                    cv_1_set <= p_set;
                    cv_1_tag <= p_tag;
                    cv_1_slot <= p_slot;
                    cv_1_rd <= 0;
                    cv_1_q8 <= p_q8;
                    cv_1_kmj <= p_kmj;
                    cv_1_strm <= p_strm;
                end
                q8_q <= p_q8;
                strm_q <= p_strm;
                clr_qr <= 1;
                clr_set_q <= p_set;
            end
            if (ar_fire) begin
                arq_wp <= (arq_wp + 1);
                fx_addr <= fx_addr_n;
                fx_rleft <= fx_rl_n;
                fx_firstq <= 0;
                fx_row <= (strm_q ? (fx_row + fx_rt) : (fx_row + 1));
                fx_buf <= fx_buf_n;
                fx_more <= g1_more;
                fx_lastq <= g1_last;
                fx_rtq <= g1_rt;
                fx_nbq <= g1_nbeat;
                fx_nfq <= g1_nbuf;
                fx_byq <= g1_byts;
                if (ar_last) begin
                    act <= 0;
                end
            end
            if (start) begin
                fx_row <= 0;
                fx_addr <= p_base;
                fx_rleft <= p_nrows;
                fx_firstq <= 1;
                fx_more <= g0_more;
                fx_lastq <= g0_last;
                fx_rtq <= g0_rt;
                fx_nbq <= g0_nbeat;
                fx_nfq <= g0_nbuf;
                fx_byq <= g0_byts;
            end
            occ <= occ_n;
            st_left <= st_left_n;
            st_l1 <= (st_left_n == 1);
            st_l2 <= (st_left_n == 2);
            vcnt <= ((vcnt + {5'd0, wr_setv}) - {5'd0, cv_go});
            wr_we_0 <= (rx_fire & (rx_bc == (0 / 8)));
            wr_we_1 <= (rx_fire & (rx_bc == (1 / 8)));
            wr_we_2 <= (rx_fire & (rx_bc == (2 / 8)));
            wr_we_3 <= (rx_fire & (rx_bc == (3 / 8)));
            wr_we_4 <= (rx_fire & (rx_bc == (4 / 8)));
            wr_we_5 <= (rx_fire & (rx_bc == (5 / 8)));
            wr_we_6 <= (rx_fire & (rx_bc == (6 / 8)));
            wr_we_7 <= (rx_fire & (rx_bc == (7 / 8)));
            wr_we_8 <= (rx_fire & (rx_bc == (8 / 8)));
            wr_we_9 <= (rx_fire & (rx_bc == (9 / 8)));
            wr_we_10 <= (rx_fire & (rx_bc == (10 / 8)));
            wr_we_11 <= (rx_fire & (rx_bc == (11 / 8)));
            wr_we_12 <= (rx_fire & (rx_bc == (12 / 8)));
            wr_we_13 <= (rx_fire & (rx_bc == (13 / 8)));
            wr_we_14 <= (rx_fire & (rx_bc == (14 / 8)));
            wr_we_15 <= (rx_fire & (rx_bc == (15 / 8)));
            wr_we_16 <= (rx_fire & rx_bc[1]);
            wr_we_17 <= (rx_fire & rx_bc[1]);
            wr_we_18 <= (rx_fire & rx_bc[1]);
            wr_we_19 <= (rx_fire & rx_bc[1]);
            wr_we_20 <= (rx_fire & rx_bc[1]);
            wr_we_21 <= (rx_fire & rx_bc[1]);
            wr_we_22 <= (rx_fire & rx_bc[1]);
            wr_we_23 <= (rx_fire & rx_bc[1]);
            wr_setv <= ((rx_fire & rx_last) & (~rx_st));
            wr_s <= (rx_fire & rx_st);
            if (rx_fire) begin
                if (rx_last) begin
                    arq_rp <= (arq_rp + 1);
                    rx_cnt <= 0;
                    rx_bc <= 0;
                    rx_bo <= 0;
                end else begin
                    rx_cnt <= (rx_cnt + 1);
                    if ((rx_bc == 2)) begin
                        rx_bc <= 0;
                        rx_bo <= (rx_bo + 1);
                    end else begin
                        rx_bc <= (rx_bc + 1);
                    end
                end
            end
            if ((ar_fire & (~rx_pop))) begin
                fx_ost <= (fx_ost + 1);
            end
            if ((rx_pop & (~ar_fire))) begin
                fx_ost <= (fx_ost - 1);
            end
            if ((w_v & (~w_strm))) begin
                bw_en_q <= 1;
                bw_e_en_q <= 1;
                bw_r_q <= w_row[6:0];
                bw_set_q <= w_set;
                bw_kmj_q <= w_kmj;
                if ((w_t == 0)) begin
                    cv_0_rd <= (cv_0_rd + 1);
                    if (((cv_0_rd + 8'd1) == cv_0_nrows)) begin
                        cv_0_tact <= 0;
                        done_pr <= 1;
                        done_slot_q <= cv_0_slot;
                    end
                end
                if ((w_t == 1)) begin
                    cv_1_rd <= (cv_1_rd + 1);
                    if (((cv_1_rd + 8'd1) == cv_1_nrows)) begin
                        cv_1_tact <= 0;
                        done_pr <= 1;
                        done_slot_q <= cv_1_slot;
                    end
                end
            end
            if (st_pair) begin
                bw_en_q <= 1;
                bw_e_en_q <= 1;
                bw_dual_q <= 1;
                bw_r_q <= st_pa_row[6:0];
                bw_set_q <= w_set;
                bw_kmj_q <= 0;
                if ((w_t == 0)) begin
                    cv_0_rd <= (cv_0_rd + 2);
                    if (((cv_0_rd + 8'd2) == cv_0_nrows)) begin
                        cv_0_tact <= 0;
                        done_pr <= 1;
                        done_slot_q <= cv_0_slot;
                    end
                end
                if ((w_t == 1)) begin
                    cv_1_rd <= (cv_1_rd + 2);
                    if (((cv_1_rd + 8'd2) == cv_1_nrows)) begin
                        cv_1_tact <= 0;
                        done_pr <= 1;
                        done_slot_q <= cv_1_slot;
                    end
                end
            end
            if ((w_v & w_strm)) begin
                if (w_two) begin
                    if (w_odd) begin
                        pa_v <= 1;
                        pa_row <= (w_row + 1);
                        pa_set <= w_set;
                        pa_t <= w_t;
                    end else begin
                        pa_v <= 0;
                    end
                end else begin
                    if ((~w_odd)) begin
                        pa_v <= 1;
                        pa_row <= w_row;
                        pa_set <= w_set;
                        pa_t <= w_t;
                    end else begin
                        pa_v <= 0;
                    end
                end
            end
            w_v <= w1_v;
            em_w0 <= em1_0;
            em_w1 <= em1_1;
            w_row <= w1_row;
            w_two <= w1_two;
            w_t <= w1_t;
            w_set <= w1_set;
            w_nv0 <= w1_nv0;
            w_nv1 <= w1_nv1;
            w_q8 <= w1_q8;
            w_kmj <= w1_kmj;
            w_strm <= w1_strm;
            w1_v <= e_v;
            em1_0 <= u_em0_e;
            em1_1 <= u_em1_e;
            w1_row <= e_row;
            w1_two <= e_two;
            w1_t <= e_t;
            w1_set <= e_set;
            w1_nv0 <= e_nv0;
            w1_nv1 <= e_nv1;
            w1_q8 <= e_q8;
            w1_kmj <= e_kmj;
            w1_strm <= e_strm;
            e_v <= s_v;
            e_row <= s_row;
            e_two <= s_two;
            e_t <= s_t;
            e_set <= s_set;
            e_nv0 <= s_nv0;
            e_nv1 <= s_nv1;
            e_q8 <= s_q8;
            e_kmj <= s_kmj;
            e_strm <= s_strm;
            avail <= ((avail + {6'd0, wr_s}) - {6'd0, take_s});
            s_v <= s0_v;
            s_row <= s0_row;
            s_two <= s0_two;
            s_t <= s0_t;
            s_set <= s0_set;
            s_nv0 <= s0_nv0;
            s_nv1 <= s0_nv1;
            s_q8 <= s0_q8;
            s_kmj <= s0_kmj;
            s_strm <= s0_strm;
            if (take_s) begin
                cv_buf <= st_b2;
                cv_bufr_0 <= st_b2;
                cv_bufr_1 <= st_b2;
                cv_bufr_2 <= st_b2;
                cv_bufr_3 <= st_b2;
                cv_bufr_4 <= st_b2;
                cv_bufr_5 <= st_b2;
                cv_bufr_6 <= st_b2;
                cv_bufr_7 <= st_b2;
                cv_bufr_8 <= st_b2;
                cv_bufr_9 <= st_b2;
                cv_bufr_10 <= st_b2;
                cv_bufr_11 <= st_b2;
                cv_bufr_12 <= st_b2;
                cv_bufr_13 <= st_b2;
                cv_bufr_14 <= st_b2;
                cv_bufr_15 <= st_b2;
                cv_bufr_16 <= st_b2;
                cv_bufr_17 <= st_b2;
                cv_bufr_18 <= st_b2;
                cv_bufr_19 <= st_b2;
                cv_bufr_20 <= st_b2;
                cv_bufr_21 <= st_b2;
                cv_bufr_22 <= st_b2;
                cv_bufr_23 <= st_b2;
                cv_col <= st_c2;
                cv_colr_0 <= st_c2;
                cv_colr_1 <= st_c2;
                cv_colr_2 <= st_c2;
                cv_colr_3 <= st_c2;
                cv_colr_4 <= st_c2;
                cv_colr_5 <= st_c2;
                cv_colr_6 <= st_c2;
                cv_colr_7 <= st_c2;
                s0_v <= 1;
                s0_strm <= 1;
                s0_sca <= st_sca;
                s0_scb <= st_scb;
                s0_two <= st_two;
                s0_row <= st_row;
                s0_t <= cv_t;
                s0_set <= cv_set;
                s0_nv0 <= cv_nv0;
                s0_nv1 <= cv_nv1;
                s0_q8 <= 1;
                s0_kmj <= 0;
                if (st_end) begin
                    st_row <= 0;
                    cv_tq <= (~cv_tq);
                end else begin
                    st_row <= st_nrow;
                end
            end else begin
                if (cv_go) begin
                    s0_v <= 1;
                    s0_strm <= 0;
                    s0_two <= 0;
                    s0_row <= cv_row;
                    s0_t <= cv_t;
                    s0_set <= cv_set;
                    s0_nv0 <= cv_nv0;
                    s0_nv1 <= cv_nv1;
                    s0_q8 <= cv_q8;
                    s0_kmj <= cv_kmj;
                    cv_buf <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_0 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_1 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_2 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_3 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_4 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_5 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_6 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_7 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_8 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_9 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_10 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_11 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_12 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_13 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_14 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_15 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_16 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_17 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_18 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_19 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_20 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_21 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_22 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    cv_bufr_23 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                    if (st_blast) begin
                        st_row <= 0;
                        cv_tq <= (~cv_tq);
                    end else begin
                        st_row <= (st_row + 1);
                    end
                end else begin
                    s0_v <= 0;
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        if (ar_fire) begin
            arq_buf[arq_wp] <= fx_buf;
            arq_nb[arq_wp] <= fx_nbeat;
            arq_st[arq_wp] <= strm_q;
        end
        wr_aq_0 <= rx_wi;
        wr_aq_1 <= rx_wi;
        wr_aq_2 <= rx_wi;
        wr_aq_3 <= rx_wi;
        wr_aq_4 <= rx_wi;
        wr_aq_5 <= rx_wi;
        wr_aq_6 <= rx_wi;
        wr_aq_7 <= rx_wi;
        wr_aq_8 <= rx_wi;
        wr_aq_9 <= rx_wi;
        wr_aq_10 <= rx_wi;
        wr_aq_11 <= rx_wi;
        wr_aq_12 <= rx_wi;
        wr_aq_13 <= rx_wi;
        wr_aq_14 <= rx_wi;
        wr_aq_15 <= rx_wi;
        wr_aq_16 <= rx_wi;
        wr_aq_17 <= rx_wi;
        wr_aq_18 <= rx_wi;
        wr_aq_19 <= rx_wi;
        wr_aq_20 <= rx_wi;
        wr_aq_21 <= rx_wi;
        wr_aq_22 <= rx_wi;
        wr_aq_23 <= rx_wi;
        wr_d <= r_data;
        if (wr_we_0) begin
            bcol0_0[wr_aq_0] <= wr_d[127:0];
        end
        if (wr_we_8) begin
            bcol1_0[wr_aq_8] <= wr_d[127:0];
        end
        if (wr_we_16) begin
            bcol2_0[wr_aq_16] <= wr_d[127:0];
        end
        if (wr_we_1) begin
            bcol0_1[wr_aq_1] <= wr_d[255:128];
        end
        if (wr_we_9) begin
            bcol1_1[wr_aq_9] <= wr_d[255:128];
        end
        if (wr_we_17) begin
            bcol2_1[wr_aq_17] <= wr_d[255:128];
        end
        if (wr_we_2) begin
            bcol0_2[wr_aq_2] <= wr_d[383:256];
        end
        if (wr_we_10) begin
            bcol1_2[wr_aq_10] <= wr_d[383:256];
        end
        if (wr_we_18) begin
            bcol2_2[wr_aq_18] <= wr_d[383:256];
        end
        if (wr_we_3) begin
            bcol0_3[wr_aq_3] <= wr_d[511:384];
        end
        if (wr_we_11) begin
            bcol1_3[wr_aq_11] <= wr_d[511:384];
        end
        if (wr_we_19) begin
            bcol2_3[wr_aq_19] <= wr_d[511:384];
        end
        if (wr_we_4) begin
            bcol0_4[wr_aq_4] <= wr_d[639:512];
        end
        if (wr_we_12) begin
            bcol1_4[wr_aq_12] <= wr_d[639:512];
        end
        if (wr_we_20) begin
            bcol2_4[wr_aq_20] <= wr_d[639:512];
        end
        if (wr_we_5) begin
            bcol0_5[wr_aq_5] <= wr_d[767:640];
        end
        if (wr_we_13) begin
            bcol1_5[wr_aq_13] <= wr_d[767:640];
        end
        if (wr_we_21) begin
            bcol2_5[wr_aq_21] <= wr_d[767:640];
        end
        if (wr_we_6) begin
            bcol0_6[wr_aq_6] <= wr_d[895:768];
        end
        if (wr_we_14) begin
            bcol1_6[wr_aq_14] <= wr_d[895:768];
        end
        if (wr_we_22) begin
            bcol2_6[wr_aq_22] <= wr_d[895:768];
        end
        if (wr_we_7) begin
            bcol0_7[wr_aq_7] <= wr_d[1023:896];
        end
        if (wr_we_15) begin
            bcol1_7[wr_aq_15] <= wr_d[1023:896];
        end
        if (wr_we_23) begin
            bcol2_7[wr_aq_23] <= wr_d[1023:896];
        end
        bsel_p_0 <= (w1_strm & w1_row[0]);
        bsel_a_0 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[63:0] <= (bsel_p_0 ? pa_q[63:0] : (bsel_a_0 ? q8a_row[63:0] : cvt_row[63:0]));
        bw_data2_q[63:0] <= (bsel_p_0 ? q8a_row[63:0] : q8b_row[63:0]);
        bsel_p_1 <= (w1_strm & w1_row[0]);
        bsel_a_1 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[127:64] <= (bsel_p_1 ? pa_q[127:64] : (bsel_a_1 ? q8a_row[127:64] : cvt_row[127:64]));
        bw_data2_q[127:64] <= (bsel_p_1 ? q8a_row[127:64] : q8b_row[127:64]);
        bsel_p_2 <= (w1_strm & w1_row[0]);
        bsel_a_2 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[191:128] <= (bsel_p_2 ? pa_q[191:128] : (bsel_a_2 ? q8a_row[191:128] : cvt_row[191:128]));
        bw_data2_q[191:128] <= (bsel_p_2 ? q8a_row[191:128] : q8b_row[191:128]);
        bsel_p_3 <= (w1_strm & w1_row[0]);
        bsel_a_3 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[255:192] <= (bsel_p_3 ? pa_q[255:192] : (bsel_a_3 ? q8a_row[255:192] : cvt_row[255:192]));
        bw_data2_q[255:192] <= (bsel_p_3 ? q8a_row[255:192] : q8b_row[255:192]);
        bsel_p_4 <= (w1_strm & w1_row[0]);
        bsel_a_4 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[319:256] <= (bsel_p_4 ? pa_q[319:256] : (bsel_a_4 ? q8a_row[319:256] : cvt_row[319:256]));
        bw_data2_q[319:256] <= (bsel_p_4 ? q8a_row[319:256] : q8b_row[319:256]);
        bsel_p_5 <= (w1_strm & w1_row[0]);
        bsel_a_5 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[383:320] <= (bsel_p_5 ? pa_q[383:320] : (bsel_a_5 ? q8a_row[383:320] : cvt_row[383:320]));
        bw_data2_q[383:320] <= (bsel_p_5 ? q8a_row[383:320] : q8b_row[383:320]);
        bsel_p_6 <= (w1_strm & w1_row[0]);
        bsel_a_6 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[447:384] <= (bsel_p_6 ? pa_q[447:384] : (bsel_a_6 ? q8a_row[447:384] : cvt_row[447:384]));
        bw_data2_q[447:384] <= (bsel_p_6 ? q8a_row[447:384] : q8b_row[447:384]);
        bsel_p_7 <= (w1_strm & w1_row[0]);
        bsel_a_7 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[511:448] <= (bsel_p_7 ? pa_q[511:448] : (bsel_a_7 ? q8a_row[511:448] : cvt_row[511:448]));
        bw_data2_q[511:448] <= (bsel_p_7 ? q8a_row[511:448] : q8b_row[511:448]);
        bsel_p_8 <= (w1_strm & w1_row[0]);
        bsel_a_8 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[575:512] <= (bsel_p_8 ? pa_q[575:512] : (bsel_a_8 ? q8a_row[575:512] : cvt_row[575:512]));
        bw_data2_q[575:512] <= (bsel_p_8 ? q8a_row[575:512] : q8b_row[575:512]);
        bsel_p_9 <= (w1_strm & w1_row[0]);
        bsel_a_9 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[639:576] <= (bsel_p_9 ? pa_q[639:576] : (bsel_a_9 ? q8a_row[639:576] : cvt_row[639:576]));
        bw_data2_q[639:576] <= (bsel_p_9 ? q8a_row[639:576] : q8b_row[639:576]);
        bsel_p_10 <= (w1_strm & w1_row[0]);
        bsel_a_10 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[703:640] <= (bsel_p_10 ? pa_q[703:640] : (bsel_a_10 ? q8a_row[703:640] : cvt_row[703:640]));
        bw_data2_q[703:640] <= (bsel_p_10 ? q8a_row[703:640] : q8b_row[703:640]);
        bsel_p_11 <= (w1_strm & w1_row[0]);
        bsel_a_11 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[767:704] <= (bsel_p_11 ? pa_q[767:704] : (bsel_a_11 ? q8a_row[767:704] : cvt_row[767:704]));
        bw_data2_q[767:704] <= (bsel_p_11 ? q8a_row[767:704] : q8b_row[767:704]);
        bsel_p_12 <= (w1_strm & w1_row[0]);
        bsel_a_12 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[831:768] <= (bsel_p_12 ? pa_q[831:768] : (bsel_a_12 ? q8a_row[831:768] : cvt_row[831:768]));
        bw_data2_q[831:768] <= (bsel_p_12 ? q8a_row[831:768] : q8b_row[831:768]);
        bsel_p_13 <= (w1_strm & w1_row[0]);
        bsel_a_13 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[895:832] <= (bsel_p_13 ? pa_q[895:832] : (bsel_a_13 ? q8a_row[895:832] : cvt_row[895:832]));
        bw_data2_q[895:832] <= (bsel_p_13 ? q8a_row[895:832] : q8b_row[895:832]);
        bsel_p_14 <= (w1_strm & w1_row[0]);
        bsel_a_14 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[959:896] <= (bsel_p_14 ? pa_q[959:896] : (bsel_a_14 ? q8a_row[959:896] : cvt_row[959:896]));
        bw_data2_q[959:896] <= (bsel_p_14 ? q8a_row[959:896] : q8b_row[959:896]);
        bsel_p_15 <= (w1_strm & w1_row[0]);
        bsel_a_15 <= (w1_strm ? (~w1_row[0]) : w1_q8);
        bw_data_q[1023:960] <= (bsel_p_15 ? pa_q[1023:960] : (bsel_a_15 ? q8a_row[1023:960] : cvt_row[1023:960]));
        bw_data2_q[1023:960] <= (bsel_p_15 ? q8a_row[1023:960] : q8b_row[1023:960]);
        if ((w_v & (~w_strm))) begin
            bw_eb_q <= row_eb;
        end
        if (st_pair) begin
            bw_eb_q <= st_pa_eb;
            bw_eb2_q <= st_pb_eb;
        end
        if ((w_v & w_strm)) begin
            if (w_two) begin
                if (w_odd) begin
                    pa_eb <= q8b_eb;
                end
            end else begin
                if ((~w_odd)) begin
                    pa_eb <= q8a_eb;
                end
            end
        end
        w_grp[135:0] <= (w1q8_c_0 ? w1_grp[135:0] : cva_pk[135:0]);
        w_grp[271:136] <= (w1q8_c_1 ? w1_grp[271:136] : cva_pk[271:136]);
        w_grp[407:272] <= (w1q8_c_2 ? w1_grp[407:272] : cva_pk[407:272]);
        w_grp[543:408] <= (w1q8_c_3 ? w1_grp[543:408] : cva_pk[543:408]);
        w_grp[679:544] <= (w1q8_c_4 ? w1_grp[679:544] : cva_pk[679:544]);
        w_grp[815:680] <= (w1q8_c_5 ? w1_grp[815:680] : cva_pk[815:680]);
        w_grp[951:816] <= (w1q8_c_6 ? w1_grp[951:816] : cva_pk[951:816]);
        w_grp[1087:952] <= (w1q8_c_7 ? w1_grp[1087:952] : cva_pk[1087:952]);
        w1q8_c_0 <= e_q8;
        pa_ce_0 <= pa_ce_n;
        pa_sb_0 <= w1_two;
        if (pa_ce_0) begin
            pa_q[127:0] <= (pa_sb_0 ? q8b_row[127:0] : q8a_row[127:0]);
        end
        w1q8_c_1 <= e_q8;
        pa_ce_1 <= pa_ce_n;
        pa_sb_1 <= w1_two;
        if (pa_ce_1) begin
            pa_q[255:128] <= (pa_sb_1 ? q8b_row[255:128] : q8a_row[255:128]);
        end
        w1q8_c_2 <= e_q8;
        pa_ce_2 <= pa_ce_n;
        pa_sb_2 <= w1_two;
        if (pa_ce_2) begin
            pa_q[383:256] <= (pa_sb_2 ? q8b_row[383:256] : q8a_row[383:256]);
        end
        w1q8_c_3 <= e_q8;
        pa_ce_3 <= pa_ce_n;
        pa_sb_3 <= w1_two;
        if (pa_ce_3) begin
            pa_q[511:384] <= (pa_sb_3 ? q8b_row[511:384] : q8a_row[511:384]);
        end
        w1q8_c_4 <= e_q8;
        pa_ce_4 <= pa_ce_n;
        pa_sb_4 <= w1_two;
        if (pa_ce_4) begin
            pa_q[639:512] <= (pa_sb_4 ? q8b_row[639:512] : q8a_row[639:512]);
        end
        w1q8_c_5 <= e_q8;
        pa_ce_5 <= pa_ce_n;
        pa_sb_5 <= w1_two;
        if (pa_ce_5) begin
            pa_q[767:640] <= (pa_sb_5 ? q8b_row[767:640] : q8a_row[767:640]);
        end
        w1q8_c_6 <= e_q8;
        pa_ce_6 <= pa_ce_n;
        pa_sb_6 <= w1_two;
        if (pa_ce_6) begin
            pa_q[895:768] <= (pa_sb_6 ? q8b_row[895:768] : q8a_row[895:768]);
        end
        w1q8_c_7 <= e_q8;
        pa_ce_7 <= pa_ce_n;
        pa_sb_7 <= w1_two;
        if (pa_ce_7) begin
            pa_q[1023:896] <= (pa_sb_7 ? q8b_row[1023:896] : q8a_row[1023:896]);
        end
        w1_grp <= e_grp;
        w1_em0 <= e_em0;
        w1_em1 <= e_em1;
        w1_ez0 <= e_ez0;
        w1_ez1 <= e_ez1;
        e_grp <= s_grp;
        e_th0 <= u_et0_th;
        e_th1 <= u_et1_th;
        e_em0 <= u_et0_em;
        e_em1 <= u_et1_em;
        e_ez0 <= u_et0_ez;
        e_ez1 <= u_et1_ez;
        s_grp <= (s0_strm ? st_grp : {64'd0, s0_d});
        s_ok0 <= s0_ok0;
        s_ok1 <= s0_ok1;
        if ((s0_v & s0_strm)) begin
            sc_lat <= sc_next;
        end
        s0_d <= cur_beat;
    end

    GrpEmaxT u_et0 (
        .x(s_grp[511:0]),
        .ok(s_ok0),
        .th(u_et0_th),
        .em(u_et0_em),
        .ez(u_et0_ez)
    );
    GrpEmaxT u_et1 (
        .x(s_grp[1023:512]),
        .ok(s_ok1),
        .th(u_et1_th),
        .em(u_et1_em),
        .ez(u_et1_ez)
    );
    GrpEmaxE u_em0 (
        .th(e_th0),
        .e(u_em0_e)
    );
    GrpEmaxE u_em1 (
        .th(e_th1),
        .e(u_em1_e)
    );
    GrpCvtA u_cva0 (
        .x(w1_grp[511:0]),
        .em(w1_em0),
        .ez(w1_ez0),
        .emax(em1_0),
        .mz(u_cva0_mz)
    );
    GrpCvtA u_cva1 (
        .x(w1_grp[1023:512]),
        .em(w1_em1),
        .ez(w1_ez1),
        .emax(em1_1),
        .mz(u_cva1_mz)
    );
    GrpCvtB u_cvb0 (
        .mz(w_grp[543:0]),
        .f(u_cvb0_f)
    );
    GrpCvtB u_cvb1 (
        .mz(w_grp[1087:544]),
        .f(u_cvb1_f)
    );
    Q8Parse u_q8a0 (
        .blk(w_grp[271:0]),
        .nv(nv_w0),
        .q(u_q8a0_q),
        .eb(u_q8a0_eb),
        .ms(u_q8a0_ms)
    );
    Q8Parse u_q8a1 (
        .blk(w_grp[543:272]),
        .nv(nv_w1),
        .q(u_q8a1_q),
        .eb(u_q8a1_eb),
        .ms(u_q8a1_ms)
    );
    Q8Parse u_q8b0 (
        .blk(w_grp[815:544]),
        .nv(nv_w0),
        .q(u_q8b0_q),
        .eb(u_q8b0_eb),
        .ms(u_q8b0_ms)
    );
    Q8Parse u_q8b1 (
        .blk(w_grp[1087:816]),
        .nv(nv_w1),
        .q(u_q8b1_q),
        .eb(u_q8b1_eb),
        .ms(u_q8b1_ms)
    );
endmodule
