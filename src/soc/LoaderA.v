module LoaderA (
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
    output logic aw_en,
    output logic [5:0] aw_m,
    output logic [3:0] aw_en_r,
    output logic [23:0] aw_m_r,
    output logic [7:0] aw_set_r,
    output logic [1023:0] aw_data,
    output logic aw_e_en,
    output logic [9:0] aw_e
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
    logic [4:0] cv_bufr_0;
    logic [4:0] cv_bufr_1;
    logic [4:0] cv_bufr_2;
    logic [4:0] cv_bufr_3;
    logic [4:0] cv_bufr_4;
    logic [4:0] cv_bufr_5;
    logic [4:0] cv_bufr_6;
    logic [4:0] cv_bufr_7;
    logic wr_we_0;
    logic wr_we_1;
    logic wr_we_2;
    logic wr_we_3;
    logic wr_we_4;
    logic wr_we_5;
    logic wr_we_6;
    logic wr_we_7;
    logic [4:0] wr_aq_0;
    logic [4:0] wr_aq_1;
    logic [4:0] wr_aq_2;
    logic [4:0] wr_aq_3;
    logic [4:0] wr_aq_4;
    logic [4:0] wr_aq_5;
    logic [4:0] wr_aq_6;
    logic [4:0] wr_aq_7;
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
    logic aw_en_q;
    logic [5:0] aw_m_q;
    logic [1023:0] aw_data_q;
    logic aw_e_en_q;
    logic [9:0] aw_e_q;
    logic [1:0] aw_set_q;
    logic aw_en_g_0;
    logic aw_en_g_1;
    logic aw_en_g_2;
    logic aw_en_g_3;
    logic [5:0] aw_m_g_0;
    logic [5:0] aw_m_g_1;
    logic [5:0] aw_m_g_2;
    logic [5:0] aw_m_g_3;
    logic [1:0] aw_set_g_0;
    logic [1:0] aw_set_g_1;
    logic [1:0] aw_set_g_2;
    logic [1:0] aw_set_g_3;
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
    logic [6:0] fx_off7;
    logic [10:0] fx_span;
    logic [4:0] fx_nbeat;
    logic [2:0] fx_nbuf;
    logic [7:0] fx_rl_n;
    logic fx_go;
    logic ar_fire_c;
    logic cv_t;
    logic [1:0] cv_set;
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
    logic [31:0] cv_ok0;
    logic [31:0] cv_ok1;
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
    logic [5:0] occ_n;
    logic [7:0] st_take;
    logic st_bend;
    logic [1087:0] rs_grp;
    logic [1087:0] cva_pk;
    logic [1023:0] cvt_row;
    logic [9:0] em_row;
    logic [7:0] st_left_n;
    logic ar_fire;
    logic rx_fire;
    logic rx_pop;
    logic [543:0] u_cva1_mz;
    logic [543:0] u_cva0_mz;
    logic [511:0] u_cvb1_f;
    logic [511:0] u_cvb0_f;
    logic [4:0] u_em0_e;
    logic [4:0] u_em1_e;
    logic [30:0] u_et0_th;
    logic [30:0] u_et1_th;
    logic [159:0] u_et0_em;
    logic [159:0] u_et1_em;
    logic [31:0] u_et0_ez;
    logic [31:0] u_et1_ez;

    assign fx_bufbusy = (occ == 32);
    assign fx_inc = {16'd0, strd_q};
    assign fx_addr_n = (fx_addr + fx_inc);
    assign fx_off7 = fx_addr[6:0];
    assign fx_span = (({4'd0, fx_off7} + {2'd0, rowb_q}) + 11'd127);
    assign fx_nbeat = {2'd0, fx_span[9:7]};
    assign fx_nbuf = 3'd1;
    assign fx_rl_n = (fx_rleft - 8'd1);
    assign fx_go = ((act & fx_more) & (~fx_bufbusy));
    assign ar_bytes = {11'd0, rowb_q};
    assign ar_req = (fx_go & (fx_ost < 12));
    assign ar_addr = fx_addr;
    assign ar_cfg = cfg_q;
    assign ar_first = fx_firstq;
    assign ar_last = fx_lastq;
    assign ar_fire_c = (ar_req & ar_gnt);
    assign cv_t = cv_tq;
    assign cv_set = (cv_t ? cv_1_set : cv_0_set);
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
    assign cv_ok0 = {(6'd31 < cv_nv0), (6'd30 < cv_nv0), (6'd29 < cv_nv0), (6'd28 < cv_nv0), (6'd27 < cv_nv0),
                     (6'd26 < cv_nv0), (6'd25 < cv_nv0), (6'd24 < cv_nv0), (6'd23 < cv_nv0), (6'd22 < cv_nv0),
                     (6'd21 < cv_nv0), (6'd20 < cv_nv0), (6'd19 < cv_nv0), (6'd18 < cv_nv0), (6'd17 < cv_nv0),
                     (6'd16 < cv_nv0), (6'd15 < cv_nv0), (6'd14 < cv_nv0), (6'd13 < cv_nv0), (6'd12 < cv_nv0),
                     (6'd11 < cv_nv0), (6'd10 < cv_nv0), (6'd9 < cv_nv0), (6'd8 < cv_nv0), (6'd7 < cv_nv0),
                     (6'd6 < cv_nv0), (6'd5 < cv_nv0), (6'd4 < cv_nv0), (6'd3 < cv_nv0), (6'd2 < cv_nv0),
                     (6'd1 < cv_nv0), (6'd0 < cv_nv0)};
    assign cv_ok1 = {(6'd31 < cv_nv1), (6'd30 < cv_nv1), (6'd29 < cv_nv1), (6'd28 < cv_nv1), (6'd27 < cv_nv1),
                     (6'd26 < cv_nv1), (6'd25 < cv_nv1), (6'd24 < cv_nv1), (6'd23 < cv_nv1), (6'd22 < cv_nv1),
                     (6'd21 < cv_nv1), (6'd20 < cv_nv1), (6'd19 < cv_nv1), (6'd18 < cv_nv1), (6'd17 < cv_nv1),
                     (6'd16 < cv_nv1), (6'd15 < cv_nv1), (6'd14 < cv_nv1), (6'd13 < cv_nv1), (6'd12 < cv_nv1),
                     (6'd11 < cv_nv1), (6'd10 < cv_nv1), (6'd9 < cv_nv1), (6'd8 < cv_nv1), (6'd7 < cv_nv1),
                     (6'd6 < cv_nv1), (6'd5 < cv_nv1), (6'd4 < cv_nv1), (6'd3 < cv_nv1), (6'd2 < cv_nv1),
                     (6'd1 < cv_nv1), (6'd0 < cv_nv1)};
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
    assign cv_go = cv_bufv;
    assign occ_n = ((occ + {5'd0, ar_fire_c}) - {5'd0, cv_go});
    assign st_take = {7'd0, cv_go};
    assign st_bend = (cv_go & st_l1);
    assign rs_grp = {64'd0, c0_d};
    assign cva_pk = {u_cva1_mz, u_cva0_mz};
    assign cvt_row = {u_cvb1_f, u_cvb0_f};
    assign em_row = {em_w1, em_w0};
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
    assign set_q = aw_set_q;
    assign aw_en = aw_en_q;
    assign aw_m = aw_m_q;
    assign aw_en_r = {aw_en_g_3, aw_en_g_2, aw_en_g_1, aw_en_g_0};
    assign aw_m_r = {aw_m_g_3, aw_m_g_2, aw_m_g_1, aw_m_g_0};
    assign aw_set_r = {aw_set_g_3, aw_set_g_2, aw_set_g_1, aw_set_g_0};
    assign aw_data = aw_data_q;
    assign aw_e_en = aw_e_en_q;
    assign aw_e = aw_e_q;
    assign ar_fire = ar_fire_c;
    assign rx_fire = ((fx_ost != 0) & r_valid);
    assign rx_pop = (rx_fire & rx_last);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            done_pr <= 0;
            aw_en_q <= 0;
            aw_e_en_q <= 0;
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
            cv_1_tact <= 0;
            cv_1_nrows <= 0;
            cv_1_nv0 <= 0;
            cv_1_nv1 <= 0;
            cv_1_set <= 0;
            cv_1_tag <= 0;
            cv_1_slot <= 0;
            cv_1_rd <= 0;
            arq_wp <= 0;
            fx_addr <= 0;
            fx_rleft <= 0;
            fx_firstq <= 1;
            fx_row <= 0;
            fx_buf <= 0;
            fx_more <= 0;
            fx_lastq <= 0;
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
            wr_setv <= 0;
            wr_s <= 0;
            arq_rp <= 0;
            rx_cnt <= 0;
            rx_bc <= 0;
            rx_bo <= 0;
            fx_ost <= 0;
            aw_m_q <= 0;
            aw_set_q <= 0;
            done_slot_q <= 0;
            w_v <= 0;
            em_w0 <= 0;
            em_w1 <= 0;
            w_row <= 0;
            w_two <= 0;
            w_t <= 0;
            w_set <= 0;
            w_nv0 <= 0;
            w_nv1 <= 0;
            w1_v <= 0;
            em1_0 <= 0;
            em1_1 <= 0;
            w1_row <= 0;
            w1_two <= 0;
            w1_t <= 0;
            w1_set <= 0;
            w1_nv0 <= 0;
            w1_nv1 <= 0;
            e_v <= 0;
            e_row <= 0;
            e_two <= 0;
            e_t <= 0;
            e_set <= 0;
            e_nv0 <= 0;
            e_nv1 <= 0;
            s_v <= 0;
            s_row <= 0;
            s_two <= 0;
            s_t <= 0;
            s_set <= 0;
            s_nv0 <= 0;
            s_nv1 <= 0;
            cv_buf <= 0;
            cv_bufr_0 <= 0;
            cv_bufr_1 <= 0;
            cv_bufr_2 <= 0;
            cv_bufr_3 <= 0;
            cv_bufr_4 <= 0;
            cv_bufr_5 <= 0;
            cv_bufr_6 <= 0;
            cv_bufr_7 <= 0;
            st_row <= 0;
            cv_tq <= 0;
        end else begin
            done_pr <= 0;
            aw_en_q <= 0;
            aw_e_en_q <= 0;
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
                end
            end
            if (ar_fire) begin
                arq_wp <= (arq_wp + 1);
                fx_addr <= fx_addr_n;
                fx_rleft <= fx_rl_n;
                fx_firstq <= 0;
                fx_row <= (fx_row + 1);
                fx_buf <= ((fx_buf == 31) ? 5'd0 : (fx_buf + 1));
                fx_more <= (fx_rl_n != 0);
                fx_lastq <= (fx_rl_n == 1);
                if (ar_last) begin
                    act <= 0;
                end
            end
            if (start) begin
                fx_row <= 0;
                fx_addr <= p_base;
                fx_rleft <= p_nrows;
                fx_firstq <= 1;
                fx_more <= (p_nrows != 0);
                fx_lastq <= (p_nrows == 1);
            end
            occ <= occ_n;
            st_left <= st_left_n;
            st_l1 <= (st_left_n == 1);
            st_l2 <= (st_left_n == 2);
            vcnt <= ((vcnt + {5'd0, wr_setv}) - {5'd0, cv_go});
            wr_we_0 <= rx_fire;
            wr_we_1 <= rx_fire;
            wr_we_2 <= rx_fire;
            wr_we_3 <= rx_fire;
            wr_we_4 <= rx_fire;
            wr_we_5 <= rx_fire;
            wr_we_6 <= rx_fire;
            wr_we_7 <= rx_fire;
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
            if (w_v) begin
                aw_en_q <= 1;
                aw_e_en_q <= 1;
                aw_m_q <= w_row[5:0];
                aw_set_q <= w_set;
            end
            if (w_v) begin
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
            w_v <= w1_v;
            em_w0 <= em1_0;
            em_w1 <= em1_1;
            w_row <= w1_row;
            w_two <= w1_two;
            w_t <= w1_t;
            w_set <= w1_set;
            w_nv0 <= w1_nv0;
            w_nv1 <= w1_nv1;
            w1_v <= e_v;
            em1_0 <= u_em0_e;
            em1_1 <= u_em1_e;
            w1_row <= e_row;
            w1_two <= e_two;
            w1_t <= e_t;
            w1_set <= e_set;
            w1_nv0 <= e_nv0;
            w1_nv1 <= e_nv1;
            e_v <= s_v;
            e_row <= s_row;
            e_two <= s_two;
            e_t <= s_t;
            e_set <= s_set;
            e_nv0 <= s_nv0;
            e_nv1 <= s_nv1;
            if (cv_go) begin
                s_v <= 1;
                s_row <= cv_row;
                s_two <= 0;
                s_t <= cv_t;
                s_set <= cv_set;
                s_nv0 <= cv_nv0;
                s_nv1 <= cv_nv1;
                cv_buf <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_0 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_1 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_2 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_3 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_4 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_5 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_6 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                cv_bufr_7 <= ((cv_buf == 31) ? 5'd0 : (cv_buf + 1));
                if (st_blast) begin
                    st_row <= 0;
                    cv_tq <= (~cv_tq);
                end else begin
                    st_row <= (st_row + 1);
                end
            end else begin
                s_v <= 0;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (ar_fire) begin
            arq_buf[arq_wp] <= fx_buf;
            arq_nb[arq_wp] <= fx_nbeat;
            arq_st[arq_wp] <= 0;
        end
        wr_aq_0 <= rx_wi;
        wr_aq_1 <= rx_wi;
        wr_aq_2 <= rx_wi;
        wr_aq_3 <= rx_wi;
        wr_aq_4 <= rx_wi;
        wr_aq_5 <= rx_wi;
        wr_aq_6 <= rx_wi;
        wr_aq_7 <= rx_wi;
        wr_d <= r_data;
        if (wr_we_0) begin
            bcol0_0[wr_aq_0] <= wr_d[127:0];
        end
        if (wr_we_1) begin
            bcol0_1[wr_aq_1] <= wr_d[255:128];
        end
        if (wr_we_2) begin
            bcol0_2[wr_aq_2] <= wr_d[383:256];
        end
        if (wr_we_3) begin
            bcol0_3[wr_aq_3] <= wr_d[511:384];
        end
        if (wr_we_4) begin
            bcol0_4[wr_aq_4] <= wr_d[639:512];
        end
        if (wr_we_5) begin
            bcol0_5[wr_aq_5] <= wr_d[767:640];
        end
        if (wr_we_6) begin
            bcol0_6[wr_aq_6] <= wr_d[895:768];
        end
        if (wr_we_7) begin
            bcol0_7[wr_aq_7] <= wr_d[1023:896];
        end
        aw_en_g_0 <= w_v;
        if (w_v) begin
            aw_m_g_0 <= w_row[5:0];
            aw_set_g_0 <= w_set;
        end
        aw_en_g_1 <= w_v;
        if (w_v) begin
            aw_m_g_1 <= w_row[5:0];
            aw_set_g_1 <= w_set;
        end
        aw_en_g_2 <= w_v;
        if (w_v) begin
            aw_m_g_2 <= w_row[5:0];
            aw_set_g_2 <= w_set;
        end
        aw_en_g_3 <= w_v;
        if (w_v) begin
            aw_m_g_3 <= w_row[5:0];
            aw_set_g_3 <= w_set;
        end
        aw_data_q <= cvt_row;
        if (w_v) begin
            aw_e_q <= em_row;
        end
        w_grp <= cva_pk;
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
        s_grp <= rs_grp;
        if (cv_go) begin
            s_ok0 <= cv_ok0;
            s_ok1 <= cv_ok1;
        end
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
endmodule
