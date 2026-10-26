module KStartVar (
    input clk,
    input rst_n,
    input [127:0] im_data,
    input im_gnt,
    output logic im_req,
    output logic [11:0] im_addr,
    input start_v,
    input [23:0] start_g,
    input [18:0] st_bit0,
    input [19:0] segs_bit,
    input [6:0] n_var,
    input [4:0] idx_bits,
    input [15:0] kid,
    input inval,
    input [19:0] tq_bit,
    input [5:0] tq_len,
    input tq_tri,
    input [1:0] kq_kind,
    input [31:0] vr_val,
    input tq_res,
    input [31:0] tq_sum,
    input [4:0] tq_pre0,
    input [31:0] pq_val,
    output logic [5:0] kq_idx,
    output logic [5:0] vr_idx,
    output logic busy,
    output logic im_rq_f,
    output logic im_rq_x,
    output logic [6:0] tq_tid,
    output logic [4:0] pq_idx,
    output logic vw_v,
    output logic [5:0] vw_idx,
    output logic [31:0] vw_val,
    output logic bw_v,
    output logic [5:0] bw_idx,
    output logic [31:0] bw_val,
    output logic wr_v,
    output logic [5:0] wr_idx,
    output logic [31:0] wr_val
);
    logic [4:0] st;
    logic [11:0] seg_t;
    logic [23:0] ridx;
    logic [15:0] idx;
    logic [4:0] cnt_w;
    logic [11:0] seg_left;
    logic skip;
    logic [6:0] bi;
    logic sc_sign;
    logic [3:0] lv_left;
    logic [6:0] a_left;
    logic [6:0] a_n;
    logic [19:0] a_pos;
    logic [19:0] lv_end;
    logic [5:0] a_vid;
    logic [6:0] a_tid;
    logic [5:0] ti;
    logic [5:0] acc_p;
    logic [2:0] acc_s;
    logic [19:0] acc_o;
    logic [31:0] acc_sc;
    logic [5:0] pre_p;
    logic [2:0] pre_s;
    logic [19:0] pre_o;
    logic [31:0] pre_sc;
    logic [12:0] adv_q [0:7];
    logic [3:0] a_idx;
    logic [63:0] mm [0:255];
    logic [15:0] tagk [0:7];
    logic tagv_0;
    logic tagv_1;
    logic tagv_2;
    logic tagv_3;
    logic tagv_4;
    logic tagv_5;
    logic tagv_6;
    logic tagv_7;
    logic [5:0] known [0:7];
    logic [4:0] known_l [0:7];
    logic [11:0] nseg_q [0:7];
    logic [2:0] rr;
    logic [2:0] mslot;
    logic [11:0] seg_idx;
    logic [18:0] seg_off;
    logic [23:0] ngrp_q;
    logic had_lv;
    logic [23:0] q_times;
    logic [5:0] r_times;
    logic [4:0] pq_idx_q;
    logic res_q;
    logic [5:0] tql_q;
    logic tqt_q;
    logic [31:0] sm_q;
    logic cs_v;
    logic [15:0] cs_kid;
    logic [11:0] cs_seg;
    logic [3:0] cs_nlv;
    logic [31:0] cs_base [0:15];
    logic [6:0] cs_nadv [0:7];
    logic [4:0] cs_w [0:7];
    logic [12:0] cs_adv [0:63];
    logic cs_ok;
    logic cs_mode;
    logic [2:0] lv_i;
    logic an_le;
    logic [5:0] kn_q;
    logic [4:0] kl_q;
    logic cs_hit_q;
    logic inv_q;
    logic wh_q;
    logic [2:0] wi_q;
    logic ck_q;
    logic can_rec_q;
    logic [31:0] vr_q;
    logic mm_wv;
    logic [7:0] mm_wa;
    logic [63:0] mm_wd;
    logic [5:0] get_w;
    logic rdy;
    logic use_q;
    logic get_v;
    logic seek_go;
    logic [18:0] seek_abs;
    logic [11:0] seek_line;
    logic [6:0] seek_bit;
    logic [31:0] hv;
    logic v1;
    logic [3:0] v4;
    logic [6:0] v7;
    logic [11:0] v12;
    logic [12:0] v13;
    logic [15:0] v16;
    logic [23:0] v24;
    logic [28:0] v29;
    logic [23:0] idx_mask;
    logic [23:0] g_shr;
    logic [11:0] g_seg;
    logic [23:0] g_ridx;
    logic h0;
    logic h1;
    logic h2;
    logic h3;
    logic h4;
    logic h5;
    logic h6;
    logic h7;
    logic way_hit;
    logic [2:0] way_idx;
    logic [5:0] known_k;
    logic memo_hit;
    logic [63:0] mm_t;
    logic [63:0] mm_last;
    logic start_now;
    logic wh_n;
    logic [2:0] wi_n;
    logic [5:0] kn_new;
    logic [4:0] kl_new;
    logic [18:0] seg_end;
    logic can_rec;
    logic cs_hit;
    logic cs_hit_new;
    logic ck_n;
    logic [5:0] seg_idx_n;
    logic [23:0] lv_mask;
    logic [23:0] idx_and;
    logic [15:0] idx_new;
    logic [23:0] ridx_new;
    logic [4:0] cnt_w_new;
    logic [18:0] tqa_q;
    logic [12:0] cs_item;
    logic [12:0] item_q;
    logic [12:0] item_r;
    logic [12:0] item_c;
    logic one_item;
    logic [23:0] q_new;
    logic [5:0] r_new;
    logic [5:0] sum_p;
    logic [2:0] sum_s;
    logic [19:0] sum_o;
    logic [31:0] sum_sc;
    logic [5:0] prf_p;
    logic [2:0] prf_s;
    logic [19:0] prf_o;
    logic [31:0] prf_sc;
    logic [5:0] dp;
    logic [2:0] ds;
    logic [19:0] d_off;
    logic [7:0] hi8;
    logic [31:0] dsc;
    logic [5:0] dp_q;
    logic [2:0] ds_q;
    logic [19:0] d_off_q;
    logic [31:0] dsc_q;
    logic [7:0] hi8_q;
    logic [31:0] vw_l1;
    logic [31:0] vw_sc;
    logic [31:0] bw_bits;
    logic [31:0] cs_base_rd;
    logic [31:0] bs2_val;
    logic [31:0] vw_x;
    logic [1:0] wr_sel;
    logic back_to_lv;
    logic seek_memo;
    logic seek_next;
    logic seek_apos;
    logic [2:0] nl__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32;
    logic [5:0] pv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32;
    logic [2:0] sv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32;
    logic [19:0] ov__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32;
    logic [2:0] nl2__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32;
    logic u_rb_ready;
    logic u_rb_im_req;
    logic u_rb_rq_f;
    logic u_rb_rq_x;
    logic [11:0] u_rb_im_addr;
    logic [31:0] u_rb_hd;
    logic [18:0] u_rb_pos;
    logic [23:0] g_shr_c0;
    logic [23:0] ridx_new_c0;
    logic [3:0] cnt_w_new_c0;
    logic [1:0] cnt_w_new_c1;

    initial begin
        for (int _i = 0; _i < 8; _i++) adv_q[_i] = 0;
        for (int _i = 0; _i < 256; _i++) mm[_i] = 0;
        for (int _i = 0; _i < 8; _i++) known[_i] = 0;
        for (int _i = 0; _i < 8; _i++) known_l[_i] = 0;
        for (int _i = 0; _i < 8; _i++) nseg_q[_i] = 0;
        for (int _i = 0; _i < 16; _i++) cs_base[_i] = 0;
        for (int _i = 0; _i < 8; _i++) cs_nadv[_i] = 0;
        for (int _i = 0; _i < 8; _i++) cs_w[_i] = 0;
        for (int _i = 0; _i < 64; _i++) cs_adv[_i] = 0;
    end

    assign kq_idx = bi[5:0];
    assign vr_idx = a_vid;
    assign busy = (st != 0);
    assign get_w = ((st == 0) ? 0 :
                   ((st == 1) ? 12 :
                   ((st == 2) ? 24 :
                   ((st == 3) ? 0 :
                   ((st == 4) ? 29 :
                   ((st == 5) ? 1 :
                   ((st == 6) ? 32 :
                   ((st == 7) ? 4 :
                   ((st == 8) ? 16 :
                   ((st == 9) ? 7 :
                   ((st == 10) ? 13 :
                   ((st == 11) ? 0 :
                   ((st == 12) ? 0 :
                   ((st == 13) ? 13 :
                   ((st == 14) ? 0 :
                   ((st == 15) ? 32 :
                   ((st == 16) ? 0 :
                   ((st == 17) ? 0 :
                   ((st == 18) ? 0 :
                   ((st == 19) ? 1 :
                   ((st == 20) ? 32 :
                   ((st == 21) ? 0 :
                   ((st == 22) ? 0 :
                   0)))))))))))))))))))))));
    assign get_v = ((rdy & (get_w != 0)) & (~((st == 13) & use_q)));
    assign seek_line = seek_abs[18:7];
    assign seek_bit = seek_abs[6:0];
    assign rdy = u_rb_ready;
    assign im_req = u_rb_im_req;
    assign im_rq_f = u_rb_rq_f;
    assign im_rq_x = u_rb_rq_x;
    assign im_addr = u_rb_im_addr;
    assign hv = u_rb_hd;
    assign v1 = hv[31];
    assign v4 = hv[31:28];
    assign v7 = hv[31:25];
    assign v12 = hv[31:20];
    assign v13 = hv[31:19];
    assign v16 = hv[31:16];
    assign v24 = hv[31:8];
    assign v29 = hv[31:3];
    assign idx_mask = ((idx_bits == 0) ? 24'd0 :
                      ((idx_bits == 1) ? 24'd1 :
                      ((idx_bits == 2) ? 24'd3 :
                      ((idx_bits == 3) ? 24'd7 :
                      ((idx_bits == 4) ? 24'd15 :
                      ((idx_bits == 5) ? 24'd31 :
                      ((idx_bits == 6) ? 24'd63 :
                      ((idx_bits == 7) ? 24'd127 :
                      ((idx_bits == 8) ? 24'd255 :
                      ((idx_bits == 9) ? 24'd511 :
                      ((idx_bits == 10) ? 24'd1023 :
                      ((idx_bits == 11) ? 24'd2047 :
                      ((idx_bits == 12) ? 24'd4095 :
                      ((idx_bits == 13) ? 24'd8191 :
                      ((idx_bits == 14) ? 24'd16383 :
                      ((idx_bits == 15) ? 24'd32767 :
                      ((idx_bits == 16) ? 24'd65535 :
                      ((idx_bits == 17) ? 24'd131071 :
                      ((idx_bits == 18) ? 24'd262143 :
                      ((idx_bits == 19) ? 24'd524287 :
                      ((idx_bits == 20) ? 24'd1048575 :
                      ((idx_bits == 21) ? 24'd2097151 :
                      ((idx_bits == 22) ? 24'd4194303 :
                      ((idx_bits == 23) ? 24'd8388607 :
                      ((idx_bits == 24) ? 24'd16777215 :
                      ((idx_bits == 25) ? 24'd16777215 :
                      ((idx_bits == 26) ? 24'd16777215 :
                      ((idx_bits == 27) ? 24'd16777215 :
                      ((idx_bits == 28) ? 24'd16777215 :
                      ((idx_bits == 29) ? 24'd16777215 :
                      ((idx_bits == 30) ? 24'd16777215 :
                      24'd16777215)))))))))))))))))))))))))))))));
    assign g_shr_c0 = ((idx_bits[1:0] == 0) ? start_g :
                      ((idx_bits[1:0] == 1) ? (start_g >> 1) :
                      ((idx_bits[1:0] == 2) ? (start_g >> 2) :
                      (start_g >> 3))));
    assign g_shr = ((idx_bits[4:2] == 0) ? g_shr_c0 :
                   ((idx_bits[4:2] == 1) ? (g_shr_c0 >> 4) :
                   ((idx_bits[4:2] == 2) ? (g_shr_c0 >> 8) :
                   ((idx_bits[4:2] == 3) ? (g_shr_c0 >> 12) :
                   ((idx_bits[4:2] == 4) ? (g_shr_c0 >> 16) :
                   ((idx_bits[4:2] == 5) ? (g_shr_c0 >> 20) :
                   ((idx_bits[4:2] == 6) ? 24'd0 :
                   24'd0)))))));
    assign g_seg = g_shr[11:0];
    assign g_ridx = (start_g & idx_mask);
    assign h0 = (tagv_0 & (tagk[0] == kid));
    assign h1 = (tagv_1 & (tagk[1] == kid));
    assign h2 = (tagv_2 & (tagk[2] == kid));
    assign h3 = (tagv_3 & (tagk[3] == kid));
    assign h4 = (tagv_4 & (tagk[4] == kid));
    assign h5 = (tagv_5 & (tagk[5] == kid));
    assign h6 = (tagv_6 & (tagk[6] == kid));
    assign h7 = (tagv_7 & (tagk[7] == kid));
    assign way_hit = (((((((h0 | h1) | h2) | h3) | h4) | h5) | h6) | h7);
    assign way_idx = (h0 ? 3'd0 :
                     (h1 ? 3'd1 :
                     (h2 ? 3'd2 :
                     (h3 ? 3'd3 :
                     (h4 ? 3'd4 :
                     (h5 ? 3'd5 :
                     (h6 ? 3'd6 :
                     3'd7)))))));
    assign known_k = kn_q;
    assign memo_hit = (seg_t < {6'd0, known_k});
    assign mm_t = mm[{mslot, seg_t[4:0]}];
    assign mm_last = mm[{mslot, kl_q}];
    assign start_now = ((st == 0) & start_v);
    assign wh_n = ((~inval) & (way_hit | start_now));
    assign wi_n = (way_hit ? way_idx : rr);
    assign kn_new = (wh_q ? known[wi_q] : 6'd0);
    assign kl_new = (wh_q ? known_l[wi_q] : 5'd31);
    assign seg_end = (had_lv ? lv_end[18:0] : u_rb_pos);
    assign can_rec = ((seg_idx < 32) & (seg_idx == {6'd0, known_k}));
    assign cs_hit = (cs_hit_q & (~inv_q));
    assign cs_hit_new = (ck_q & (cs_seg == g_seg));
    assign ck_n = ((~inval) & (((st == 18) & (~skip)) ? cs_ok : (cs_v & (cs_kid == kid))));
    assign seg_idx_n = (seg_idx[5:0] + 1);
    assign lv_mask = ((cnt_w == 0) ? 24'd0 :
                     ((cnt_w == 1) ? 24'd1 :
                     ((cnt_w == 2) ? 24'd3 :
                     ((cnt_w == 3) ? 24'd7 :
                     ((cnt_w == 4) ? 24'd15 :
                     ((cnt_w == 5) ? 24'd31 :
                     ((cnt_w == 6) ? 24'd63 :
                     ((cnt_w == 7) ? 24'd127 :
                     ((cnt_w == 8) ? 24'd255 :
                     ((cnt_w == 9) ? 24'd511 :
                     ((cnt_w == 10) ? 24'd1023 :
                     ((cnt_w == 11) ? 24'd2047 :
                     ((cnt_w == 12) ? 24'd4095 :
                     ((cnt_w == 13) ? 24'd8191 :
                     ((cnt_w == 14) ? 24'd16383 :
                     ((cnt_w == 15) ? 24'd32767 :
                     ((cnt_w == 16) ? 24'd65535 :
                     ((cnt_w == 17) ? 24'd131071 :
                     ((cnt_w == 18) ? 24'd262143 :
                     ((cnt_w == 19) ? 24'd524287 :
                     ((cnt_w == 20) ? 24'd1048575 :
                     ((cnt_w == 21) ? 24'd2097151 :
                     ((cnt_w == 22) ? 24'd4194303 :
                     ((cnt_w == 23) ? 24'd8388607 :
                     ((cnt_w == 24) ? 24'd16777215 :
                     ((cnt_w == 25) ? 24'd16777215 :
                     ((cnt_w == 26) ? 24'd16777215 :
                     ((cnt_w == 27) ? 24'd16777215 :
                     ((cnt_w == 28) ? 24'd16777215 :
                     ((cnt_w == 29) ? 24'd16777215 :
                     ((cnt_w == 30) ? 24'd16777215 :
                     24'd16777215)))))))))))))))))))))))))))))));
    assign idx_and = (ridx & lv_mask);
    assign idx_new = idx_and[15:0];
    assign ridx_new_c0 = ((cnt_w[1:0] == 0) ? ridx :
                         ((cnt_w[1:0] == 1) ? (ridx >> 1) :
                         ((cnt_w[1:0] == 2) ? (ridx >> 2) :
                         (ridx >> 3))));
    assign ridx_new = ((cnt_w[4:2] == 0) ? ridx_new_c0 :
                      ((cnt_w[4:2] == 1) ? (ridx_new_c0 >> 4) :
                      ((cnt_w[4:2] == 2) ? (ridx_new_c0 >> 8) :
                      ((cnt_w[4:2] == 3) ? (ridx_new_c0 >> 12) :
                      ((cnt_w[4:2] == 4) ? (ridx_new_c0 >> 16) :
                      ((cnt_w[4:2] == 5) ? (ridx_new_c0 >> 20) :
                      ((cnt_w[4:2] == 6) ? 24'd0 :
                      24'd0)))))));
    assign cnt_w_new_c0 = {(v16[15:12] != 0), (v16[11:8] != 0), (v16[7:4] != 0), (v16[3:0] != 0)};
    assign cnt_w_new_c1 = ((cnt_w_new_c0 == 0) ? 2'd0 :
                          ((cnt_w_new_c0 == 1) ? 2'd0 :
                          ((cnt_w_new_c0 == 2) ? 2'd1 :
                          ((cnt_w_new_c0 == 3) ? 2'd1 :
                          ((cnt_w_new_c0 == 4) ? 2'd2 :
                          ((cnt_w_new_c0 == 5) ? 2'd2 :
                          ((cnt_w_new_c0 == 6) ? 2'd2 :
                          ((cnt_w_new_c0 == 7) ? 2'd2 :
                          ((cnt_w_new_c0 == 8) ? 2'd3 :
                          ((cnt_w_new_c0 == 9) ? 2'd3 :
                          ((cnt_w_new_c0 == 10) ? 2'd3 :
                          ((cnt_w_new_c0 == 11) ? 2'd3 :
                          ((cnt_w_new_c0 == 12) ? 2'd3 :
                          ((cnt_w_new_c0 == 13) ? 2'd3 :
                          ((cnt_w_new_c0 == 14) ? 2'd3 :
                          2'd3)))))))))))))));
    assign cnt_w_new = ((cnt_w_new_c0 == 0) ? 5'd16 :
                       ({1'd0, cnt_w_new_c1,
                         ((cnt_w_new_c1 == 0)
                          ? ((v16[3:0] == 0) ? 2'd0 :
                            ((v16[3:0] == 1) ? 2'd0 :
                            ((v16[3:0] == 2) ? 2'd1 :
                            ((v16[3:0] == 3) ? 2'd1 :
                            ((v16[3:0] == 4) ? 2'd2 :
                            ((v16[3:0] == 5) ? 2'd2 :
                            ((v16[3:0] == 6) ? 2'd2 :
                            ((v16[3:0] == 7) ? 2'd2 :
                            ((v16[3:0] == 8) ? 2'd3 :
                            ((v16[3:0] == 9) ? 2'd3 :
                            ((v16[3:0] == 10) ? 2'd3 :
                            ((v16[3:0] == 11) ? 2'd3 :
                            ((v16[3:0] == 12) ? 2'd3 :
                            ((v16[3:0] == 13) ? 2'd3 :
                            ((v16[3:0] == 14) ? 2'd3 :
                            2'd3))))))))))))))) :
                         ((cnt_w_new_c1 == 1)
                          ? ((v16[7:4] == 0) ? 2'd0 :
                            ((v16[7:4] == 1) ? 2'd0 :
                            ((v16[7:4] == 2) ? 2'd1 :
                            ((v16[7:4] == 3) ? 2'd1 :
                            ((v16[7:4] == 4) ? 2'd2 :
                            ((v16[7:4] == 5) ? 2'd2 :
                            ((v16[7:4] == 6) ? 2'd2 :
                            ((v16[7:4] == 7) ? 2'd2 :
                            ((v16[7:4] == 8) ? 2'd3 :
                            ((v16[7:4] == 9) ? 2'd3 :
                            ((v16[7:4] == 10) ? 2'd3 :
                            ((v16[7:4] == 11) ? 2'd3 :
                            ((v16[7:4] == 12) ? 2'd3 :
                            ((v16[7:4] == 13) ? 2'd3 :
                            ((v16[7:4] == 14) ? 2'd3 :
                            2'd3))))))))))))))) :
                         ((cnt_w_new_c1 == 2)
                          ? ((v16[11:8] == 0) ? 2'd0 :
                            ((v16[11:8] == 1) ? 2'd0 :
                            ((v16[11:8] == 2) ? 2'd1 :
                            ((v16[11:8] == 3) ? 2'd1 :
                            ((v16[11:8] == 4) ? 2'd2 :
                            ((v16[11:8] == 5) ? 2'd2 :
                            ((v16[11:8] == 6) ? 2'd2 :
                            ((v16[11:8] == 7) ? 2'd2 :
                            ((v16[11:8] == 8) ? 2'd3 :
                            ((v16[11:8] == 9) ? 2'd3 :
                            ((v16[11:8] == 10) ? 2'd3 :
                            ((v16[11:8] == 11) ? 2'd3 :
                            ((v16[11:8] == 12) ? 2'd3 :
                            ((v16[11:8] == 13) ? 2'd3 :
                            ((v16[11:8] == 14) ? 2'd3 :
                            2'd3))))))))))))))) :
                         ((v16[15:12] == 0) ? 2'd0 :
                         ((v16[15:12] == 1) ? 2'd0 :
                         ((v16[15:12] == 2) ? 2'd1 :
                         ((v16[15:12] == 3) ? 2'd1 :
                         ((v16[15:12] == 4) ? 2'd2 :
                         ((v16[15:12] == 5) ? 2'd2 :
                         ((v16[15:12] == 6) ? 2'd2 :
                         ((v16[15:12] == 7) ? 2'd2 :
                         ((v16[15:12] == 8) ? 2'd3 :
                         ((v16[15:12] == 9) ? 2'd3 :
                         ((v16[15:12] == 10) ? 2'd3 :
                         ((v16[15:12] == 11) ? 2'd3 :
                         ((v16[15:12] == 12) ? 2'd3 :
                         ((v16[15:12] == 13) ? 2'd3 :
                         ((v16[15:12] == 14) ? 2'd3 :
                         2'd3))))))))))))))))))}
                        + {4'd0,
                           ((((((v16[3:0] == 0) ? 1'd0 :
                               ((v16[3:0] == 1) ? 1'd0 :
                               ((v16[3:0] == 2) ? 1'd0 :
                               ((v16[3:0] == 3) ? 1'd1 :
                               ((v16[3:0] == 4) ? 1'd0 :
                               ((v16[3:0] == 5) ? 1'd1 :
                               ((v16[3:0] == 6) ? 1'd1 :
                               ((v16[3:0] == 7) ? 1'd1 :
                               ((v16[3:0] == 8) ? 1'd0 :
                               ((v16[3:0] == 9) ? 1'd1 :
                               ((v16[3:0] == 10) ? 1'd1 :
                               ((v16[3:0] == 11) ? 1'd1 :
                               ((v16[3:0] == 12) ? 1'd1 :
                               ((v16[3:0] == 13) ? 1'd1 :
                               ((v16[3:0] == 14) ? 1'd1 :
                               1'd1)))))))))))))))
                            | ((v16[7:4] == 0) ? 1'd0 :
                              ((v16[7:4] == 1) ? 1'd0 :
                              ((v16[7:4] == 2) ? 1'd0 :
                              ((v16[7:4] == 3) ? 1'd1 :
                              ((v16[7:4] == 4) ? 1'd0 :
                              ((v16[7:4] == 5) ? 1'd1 :
                              ((v16[7:4] == 6) ? 1'd1 :
                              ((v16[7:4] == 7) ? 1'd1 :
                              ((v16[7:4] == 8) ? 1'd0 :
                              ((v16[7:4] == 9) ? 1'd1 :
                              ((v16[7:4] == 10) ? 1'd1 :
                              ((v16[7:4] == 11) ? 1'd1 :
                              ((v16[7:4] == 12) ? 1'd1 :
                              ((v16[7:4] == 13) ? 1'd1 :
                              ((v16[7:4] == 14) ? 1'd1 :
                              1'd1))))))))))))))))
                            | ((v16[11:8] == 0) ? 1'd0 :
                              ((v16[11:8] == 1) ? 1'd0 :
                              ((v16[11:8] == 2) ? 1'd0 :
                              ((v16[11:8] == 3) ? 1'd1 :
                              ((v16[11:8] == 4) ? 1'd0 :
                              ((v16[11:8] == 5) ? 1'd1 :
                              ((v16[11:8] == 6) ? 1'd1 :
                              ((v16[11:8] == 7) ? 1'd1 :
                              ((v16[11:8] == 8) ? 1'd0 :
                              ((v16[11:8] == 9) ? 1'd1 :
                              ((v16[11:8] == 10) ? 1'd1 :
                              ((v16[11:8] == 11) ? 1'd1 :
                              ((v16[11:8] == 12) ? 1'd1 :
                              ((v16[11:8] == 13) ? 1'd1 :
                              ((v16[11:8] == 14) ? 1'd1 :
                              1'd1))))))))))))))))
                            | ((v16[15:12] == 0) ? 1'd0 :
                              ((v16[15:12] == 1) ? 1'd0 :
                              ((v16[15:12] == 2) ? 1'd0 :
                              ((v16[15:12] == 3) ? 1'd1 :
                              ((v16[15:12] == 4) ? 1'd0 :
                              ((v16[15:12] == 5) ? 1'd1 :
                              ((v16[15:12] == 6) ? 1'd1 :
                              ((v16[15:12] == 7) ? 1'd1 :
                              ((v16[15:12] == 8) ? 1'd0 :
                              ((v16[15:12] == 9) ? 1'd1 :
                              ((v16[15:12] == 10) ? 1'd1 :
                              ((v16[15:12] == 11) ? 1'd1 :
                              ((v16[15:12] == 12) ? 1'd1 :
                              ((v16[15:12] == 13) ? 1'd1 :
                              ((v16[15:12] == 14) ? 1'd1 :
                              1'd1))))))))))))))))
                            | ((cnt_w_new_c0 == 0) ? 1'd0 :
                              ((cnt_w_new_c0 == 1) ? 1'd0 :
                              ((cnt_w_new_c0 == 2) ? 1'd0 :
                              ((cnt_w_new_c0 == 3) ? 1'd1 :
                              ((cnt_w_new_c0 == 4) ? 1'd0 :
                              ((cnt_w_new_c0 == 5) ? 1'd1 :
                              ((cnt_w_new_c0 == 6) ? 1'd1 :
                              ((cnt_w_new_c0 == 7) ? 1'd1 :
                              ((cnt_w_new_c0 == 8) ? 1'd0 :
                              ((cnt_w_new_c0 == 9) ? 1'd1 :
                              ((cnt_w_new_c0 == 10) ? 1'd1 :
                              ((cnt_w_new_c0 == 11) ? 1'd1 :
                              ((cnt_w_new_c0 == 12) ? 1'd1 :
                              ((cnt_w_new_c0 == 13) ? 1'd1 :
                              ((cnt_w_new_c0 == 14) ? 1'd1 :
                              1'd1))))))))))))))))}));
    assign use_q = (cs_mode | an_le);
    assign cs_item = cs_adv[{lv_i, a_idx[2:0]}];
    assign item_r = (cs_mode ? cs_item : adv_q[a_idx[2:0]]);
    assign item_c = (use_q ? item_q : v13);
    assign tq_tid = ((st == 13) ? item_c[6:0] : a_tid);
    assign pq_idx = pq_idx_q;
    assign one_item = (tq_len == 1);
    assign q_new = (one_item ? {8'd0, idx} : 24'd0);
    assign r_new = (one_item ? 6'd0 : idx[5:0]);
    assign sum_p = sm_q[28:23];
    assign sum_s = sm_q[22:20];
    assign sum_o = sm_q[19:0];
    assign sum_sc = sm_q;
    assign prf_p = (res_q ? pq_val[28:23] : pre_p);
    assign prf_s = (res_q ? pq_val[22:20] : pre_s);
    assign prf_o = (res_q ? pq_val[19:0] : pre_o);
    assign prf_sc = (res_q ? pq_val : pre_sc);
    assign dp = ((q_times[5:0] * sum_p) + prf_p);
    assign ds = ((q_times[2:0] * sum_s) + prf_s);
    assign d_off = ((q_times[15:0] * sum_o) + prf_o);
    assign hi8 = (q_times[7:0] * sum_sc[31:24]);
    assign dsc = ((q_times[15:0] * sum_sc[23:0]) + prf_sc);
    assign vw_v = (st == 16);
    assign vw_idx = ((st == 16) ? a_vid : bi[5:0]);
    assign vw_l1 = {3'd0, (vr_q[28:23] + dp_q), (vr_q[22:20] + ds_q), (vr_q[19:0] + d_off_q)};
    assign vw_sc = ((vr_q + dsc_q) + {hi8_q, 24'd0});
    assign vw_val = ((st == 16) ? (tqt_q ? vw_l1 : vw_sc) : 32'd0);
    assign bw_bits = ((st == 4) ? {3'd0, v29} : (sc_sign ? (32'd0 - hv) : hv));
    assign cs_base_rd = cs_base[bi[3:0]];
    assign bw_v = (((((st == 4) | (st == 6)) & rdy) & (~skip)) | (st == 23));
    assign bw_idx = bi[5:0];
    assign bw_val = ((st == 23) ? cs_base_rd : bw_bits);
    assign bs2_val = (sc_sign ? (32'd0 - hv) : hv);
    assign vw_x = (tqt_q ? vw_l1 : vw_sc);
    assign wr_sel = ((st == 0) ? 0 :
                    ((st == 1) ? 0 :
                    ((st == 2) ? 0 :
                    ((st == 3) ? 0 :
                    ((st == 4) ? 0 :
                    ((st == 5) ? 0 :
                    ((st == 6) ? 1 :
                    ((st == 7) ? 0 :
                    ((st == 8) ? 0 :
                    ((st == 9) ? 0 :
                    ((st == 10) ? 0 :
                    ((st == 11) ? 0 :
                    ((st == 12) ? 0 :
                    ((st == 13) ? 0 :
                    ((st == 14) ? 0 :
                    ((st == 15) ? 0 :
                    ((st == 16) ? 3 :
                    ((st == 17) ? 0 :
                    ((st == 18) ? 0 :
                    ((st == 19) ? 0 :
                    ((st == 20) ? 0 :
                    ((st == 21) ? 0 :
                    ((st == 22) ? 0 :
                    2)))))))))))))))))))))));
    assign wr_v = (bw_v | vw_v);
    assign wr_idx = vw_idx;
    assign wr_val = ((wr_sel == 0) ? {3'd0, v29} : ((wr_sel == 1) ? bs2_val : ((wr_sel == 2) ? cs_base_rd : vw_x)));
    assign back_to_lv = ((((st == 17) & (a_left == 0)) & (lv_left != 0)) & (~cs_mode));
    assign seek_memo = (((st == 21) & (~cs_hit)) & memo_hit);
    assign seek_next = ((((st == 21) & (~cs_hit)) & (~memo_hit)) & (known_k != 0));
    assign seek_apos = (((st == 12) | ((st == 17) & (a_left != 0))) & (~use_q));
    assign seek_go = (((((((st == 0) & start_v) | seek_memo) | seek_next) | seek_apos) | ((st == 14) & (ti == 0)))
                      | back_to_lv);
    assign seek_abs = (seek_memo ? mm_t[18:0] :
                      (seek_next ? mm_last[61:43] :
                      (back_to_lv ? lv_end[18:0] :
                      ((st == 14) ? tqa_q :
                      (st_bit0 + ((st == 0) ? segs_bit[18:0] : a_pos[18:0]))))));
    assign nl__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32 =
            (lv_i + 1);
    assign pv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32 =
            (hv[31] ? (6'd0 - hv[30:25]) : hv[30:25]);
    assign sv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32 =
            (hv[24] ? (3'd0 - hv[23:21]) : hv[23:21]);
    assign ov__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32 =
            (hv[20] ? (20'd0 - hv[19:0]) : hv[19:0]);
    assign nl2__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32 =
            (lv_i + 1);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            tqa_q <= 0;
            tql_q <= 0;
            tqt_q <= 0;
            vr_q <= 0;
            item_q <= 0;
            can_rec_q <= 0;
            inv_q <= 0;
            wh_q <= 0;
            wi_q <= 0;
            ck_q <= 0;
            mm_wv <= 0;
            cs_mode <= 0;
            cs_hit_q <= 0;
            kn_q <= 0;
            kl_q <= 0;
            seg_t <= 0;
            ridx <= 0;
            seg_idx <= 0;
            mslot <= 0;
            tagv_0 <= 0;
            tagv_1 <= 0;
            tagv_2 <= 0;
            tagv_3 <= 0;
            tagv_4 <= 0;
            tagv_5 <= 0;
            tagv_6 <= 0;
            tagv_7 <= 0;
            rr <= 0;
            st <= 0;
            cs_ok <= 0;
            skip <= 0;
            bi <= 0;
            lv_i <= 0;
            lv_left <= 0;
            cnt_w <= 0;
            a_n <= 0;
            an_le <= 1;
            seg_left <= 0;
            seg_off <= 0;
            ngrp_q <= 0;
            had_lv <= 0;
            sc_sign <= 0;
            cs_nlv <= 0;
            a_left <= 0;
            a_idx <= 0;
            a_pos <= 0;
            lv_end <= 0;
            idx <= 0;
            a_vid <= 0;
            a_tid <= 0;
            ti <= 0;
            acc_p <= 0;
            acc_s <= 0;
            acc_o <= 0;
            acc_sc <= 0;
            sm_q <= 0;
            pre_p <= 0;
            pre_s <= 0;
            pre_o <= 0;
            pre_sc <= 0;
            q_times <= 0;
            r_times <= 0;
            res_q <= 0;
            pq_idx_q <= 0;
            dp_q <= 0;
            ds_q <= 0;
            d_off_q <= 0;
            dsc_q <= 0;
            hi8_q <= 0;
            cs_v <= 0;
            cs_kid <= 0;
            cs_seg <= 0;
        end else begin
            tqa_q <= (st_bit0 + tq_bit[18:0]);
            tql_q <= tq_len;
            tqt_q <= tq_tri;
            vr_q <= vr_val;
            item_q <= item_r;
            can_rec_q <= can_rec;
            inv_q <= inval;
            wh_q <= wh_n;
            wi_q <= wi_n;
            ck_q <= ck_n;
            mm_wv <= 0;
            if (mm_wv) begin
                mm[mm_wa] <= mm_wd;
            end
            case (st)
                0: begin
                    if (start_v) begin
                        cs_mode <= 0;
                        cs_hit_q <= cs_hit_new;
                        kn_q <= kn_new;
                        kl_q <= kl_new;
                        seg_t <= g_seg;
                        ridx <= g_ridx;
                        seg_idx <= 0;
                        if (wh_q) begin
                            mslot <= wi_q;
                        end else begin
                            mslot <= rr;
                            if ((rr == 0)) begin
                                tagv_0 <= 1;
                            end
                            if ((rr == 1)) begin
                                tagv_1 <= 1;
                            end
                            if ((rr == 2)) begin
                                tagv_2 <= 1;
                            end
                            if ((rr == 3)) begin
                                tagv_3 <= 1;
                            end
                            if ((rr == 4)) begin
                                tagv_4 <= 1;
                            end
                            if ((rr == 5)) begin
                                tagv_5 <= 1;
                            end
                            if ((rr == 6)) begin
                                tagv_6 <= 1;
                            end
                            if ((rr == 7)) begin
                                tagv_7 <= 1;
                            end
                            known[rr] <= 0;
                            known_l[rr] <= 31;
                            rr <= (rr + 1);
                        end
                        st <= 21;
                    end
                end
                21: begin
                    if (cs_hit) begin
                        cs_mode <= 1;
                        cs_ok <= 1;
                        skip <= 0;
                        bi <= 0;
                        lv_i <= 0;
                        lv_left <= cs_nlv;
                        cnt_w <= cs_w[0];
                        a_n <= cs_nadv[0];
                        an_le <= (cs_nadv[0] <= 8);
                        if ((n_var == 0)) begin
                            st <= ((cs_nlv == 0) ? 5'd0 : 5'd11);
                        end else begin
                            st <= 23;
                        end
                    end else begin
                        if (memo_hit) begin
                            seg_idx <= seg_t;
                            seg_left <= (nseg_q[mslot] - seg_t);
                            st <= 2;
                        end else begin
                            if ((known_k == 0)) begin
                                st <= 1;
                            end else begin
                                seg_idx <= {6'd0, known_k};
                                seg_left <= (nseg_q[mslot] - {6'd0, known_k});
                                st <= 2;
                            end
                        end
                    end
                end
                1: begin
                    if (rdy) begin
                        seg_left <= v12[11:0];
                        nseg_q[mslot] <= v12[11:0];
                        seg_idx <= 0;
                        st <= 2;
                    end
                end
                2: begin
                    if (rdy) begin
                        seg_left <= (seg_left - 1);
                        bi <= 0;
                        seg_off <= u_rb_pos;
                        ngrp_q <= v24[23:0];
                        had_lv <= 0;
                        skip <= (seg_idx != seg_t);
                        cs_ok <= (n_var <= 16);
                        st <= ((n_var == 0) ? 5'd7 : 5'd3);
                    end
                end
                3: begin
                    st <= ((kq_kind == 0) ? 5'd4 : 5'd5);
                end
                4: begin
                    if (rdy) begin
                        if ((bi < 16)) begin
                            cs_base[bi[3:0]] <= bw_bits;
                        end
                        bi <= (bi + 1);
                        st <= (((bi + 1) >= n_var) ? 5'd7 : 5'd3);
                    end
                end
                5: begin
                    if (rdy) begin
                        sc_sign <= v1;
                        st <= 6;
                    end
                end
                6: begin
                    if (rdy) begin
                        if ((bi < 16)) begin
                            cs_base[bi[3:0]] <= bw_bits;
                        end
                        bi <= (bi + 1);
                        st <= (((bi + 1) >= n_var) ? 5'd7 : 5'd3);
                    end
                end
                7: begin
                    if (rdy) begin
                        lv_left <= v4[3:0];
                        had_lv <= (v4[3:0] != 0);
                        lv_i <= 0;
                        cs_nlv <= v4[3:0];
                        if ((v4[3:0] > 8)) begin
                            cs_ok <= 0;
                        end
                        st <= ((v4[3:0] == 0) ? 5'd18 : 5'd8);
                    end
                end
                8: begin
                    if (rdy) begin
                        cnt_w <= cnt_w_new;
                        cs_w[lv_i] <= cnt_w_new;
                        st <= 9;
                    end
                end
                9: begin
                    if (rdy) begin
                        a_left <= v7[6:0];
                        a_n <= v7[6:0];
                        an_le <= (v7[6:0] <= 8);
                        a_idx <= 0;
                        a_pos <= ((u_rb_pos - st_bit0) + 7);
                        cs_nadv[lv_i] <= v7[6:0];
                        if ((v7[6:0] > 8)) begin
                            cs_ok <= 0;
                        end
                        st <= ((v7[6:0] == 0) ? 5'd11 : 5'd10);
                    end
                end
                10: begin
                    if (rdy) begin
                        if ((a_idx < 8)) begin
                            adv_q[a_idx[2:0]] <= v13[12:0];
                            cs_adv[{lv_i, a_idx[2:0]}] <= v13[12:0];
                        end
                        a_idx <= (a_idx + 1);
                        a_left <= (a_left - 1);
                        st <= ((a_left == 1) ? 5'd11 : 5'd10);
                    end
                end
                11: begin
                    lv_end <= {1'd0, u_rb_pos};
                    lv_left <= (lv_left - 1);
                    if ((skip == 0)) begin
                        idx <= idx_new;
                        ridx <= ridx_new;
                    end
                    if (((skip | (idx_new == 0)) | (a_n == 0))) begin
                        lv_i <= (lv_i + 1);
                        if (cs_mode) begin
                            cnt_w <= cs_w[nl__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32[2:0]];
                            a_n <= cs_nadv[nl__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32[2:0]];
                            an_le <= (cs_nadv[nl__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32[2:0]]
                                      <= 8);
                            st <= ((lv_left == 1) ? 5'd0 : 5'd11);
                        end else begin
                            st <= ((lv_left == 1) ? 5'd18 : 5'd8);
                        end
                    end else begin
                        a_left <= a_n;
                        a_idx <= 0;
                        st <= 12;
                    end
                end
                12: begin
                    st <= 13;
                end
                13: begin
                    if ((use_q | rdy)) begin
                        a_vid <= item_c[12:7];
                        a_tid <= item_c[6:0];
                        a_left <= (a_left - 1);
                        a_idx <= (a_idx + 1);
                        a_pos <= (a_pos + 13);
                        ti <= 0;
                        acc_p <= 0;
                        acc_s <= 0;
                        acc_o <= 0;
                        acc_sc <= 0;
                        sm_q <= tq_sum;
                        pre_p <= 0;
                        pre_s <= 0;
                        pre_o <= 0;
                        pre_sc <= 0;
                        q_times <= q_new;
                        r_times <= r_new;
                        res_q <= tq_res;
                        pq_idx_q <= (tq_pre0 + r_new[4:0]);
                        st <= (tq_res ? 5'd22 : 5'd14);
                    end
                end
                14: begin
                    st <= (tqt_q ? 5'd15 : 5'd19);
                end
                15: begin
                    if (rdy) begin
                        acc_p <= (acc_p
                                  + pv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32);
                        acc_s <= (acc_s
                                  + sv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32);
                        acc_o <= (acc_o
                                  + ov__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32);
                        sm_q <= {3'd0,
                                 (acc_p
                                  + pv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32),
                                 (acc_s
                                  + sv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32),
                                 (acc_o
                                  + ov__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32)};
                        if ((ti < r_times)) begin
                            pre_p <= (pre_p
                                      + pv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32);
                            pre_s <= (pre_s
                                      + sv__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32);
                            pre_o <= (pre_o
                                      + ov__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32);
                        end
                        ti <= (ti + 1);
                        st <= (((ti + 1) >= tql_q) ? 5'd22 : 5'd15);
                    end
                end
                19: begin
                    if (rdy) begin
                        sc_sign <= v1;
                        st <= 20;
                    end
                end
                20: begin
                    if (rdy) begin
                        acc_sc <= (sc_sign ? (acc_sc - hv) : (acc_sc + hv));
                        sm_q <= (sc_sign ? (acc_sc - hv) : (acc_sc + hv));
                        if ((ti < r_times)) begin
                            pre_sc <= (sc_sign ? (pre_sc - hv) : (pre_sc + hv));
                        end
                        ti <= (ti + 1);
                        st <= (((ti + 1) >= tql_q) ? 5'd22 : 5'd19);
                    end
                end
                22: begin
                    dp_q <= dp;
                    ds_q <= ds;
                    d_off_q <= d_off;
                    dsc_q <= dsc;
                    hi8_q <= hi8;
                    st <= 16;
                end
                16: begin
                    st <= 17;
                end
                17: begin
                    if ((a_left == 0)) begin
                        if ((lv_left != 0)) begin
                            lv_i <= (lv_i + 1);
                        end
                        if (cs_mode) begin
                            cnt_w <= cs_w[nl2__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32[2:0]];
                            a_n <= cs_nadv[nl2__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32[2:0]];
                            an_le <= (cs_nadv[nl2__S_NSEG1_S_NG2_S_BD3_S_BL14_S_BS15_S_BS26_S_NLV7_S_CNT8_S_ADVN9_S_ADVSK10_S_IDX11_S_APOS12_S_AITEM13_S_TSEEK14_S_TSCAN15_S_TAPPLY16_S_ANEXT17_S_LNEXT18_S_SSIGN19_S_SMAG20_S_MRD21_S_TMUL22_S_CB23_MEMO_SEG32[2:0]]
                                      <= 8);
                            st <= ((lv_left == 0) ? 5'd0 : 5'd11);
                        end else begin
                            st <= ((lv_left == 0) ? 5'd18 : 5'd8);
                        end
                    end else begin
                        st <= 13;
                    end
                end
                23: begin
                    bi <= (bi + 1);
                    if (((bi + 1) >= n_var)) begin
                        st <= ((lv_left == 0) ? 5'd0 : 5'd11);
                    end
                end
                default: begin
                    if (can_rec_q) begin
                        mm_wv <= 1;
                        known[mslot] <= seg_idx_n;
                        known_l[mslot] <= seg_idx[4:0];
                        kn_q <= seg_idx_n;
                        kl_q <= seg_idx[4:0];
                    end
                    if ((skip == 0)) begin
                        cs_v <= cs_ok;
                        cs_kid <= kid;
                        cs_seg <= seg_idx;
                    end
                    seg_idx <= (seg_idx + 1);
                    if (skip) begin
                        st <= ((seg_left == 0) ? 5'd0 : 5'd2);
                    end else begin
                        st <= 0;
                    end
                end
            endcase
            if (inval) begin
                tagv_0 <= 0;
                tagv_1 <= 0;
                tagv_2 <= 0;
                tagv_3 <= 0;
                tagv_4 <= 0;
                tagv_5 <= 0;
                tagv_6 <= 0;
                tagv_7 <= 0;
                cs_v <= 0;
            end
        end
    end
    always_ff @(posedge clk) begin
        mm_wa <= {mslot, seg_idx[4:0]};
        mm_wd <= {2'd0, seg_end, ngrp_q, seg_off};
        case (st)
            0: begin
                if (start_v) begin
                    if ((!wh_q)) begin
                        tagk[rr] <= kid;
                    end
                end
            end
        endcase
    end

    KBitStream u_rb (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(im_gnt),
        .seek_v(seek_go),
        .seek_line(seek_line),
        .seek_bit(seek_bit),
        .get_v(get_v),
        .get_w(get_w),
        .req_v(get_v),
        .req_pre(1'd0),
        .ready(u_rb_ready),
        .im_req(u_rb_im_req),
        .rq_f(u_rb_rq_f),
        .rq_x(u_rb_rq_x),
        .im_addr(u_rb_im_addr),
        .hd(u_rb_hd),
        .pos(u_rb_pos)
    );
endmodule
