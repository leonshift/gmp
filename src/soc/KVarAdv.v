module KVarAdv (
    input clk,
    input rst_n,
    input [127:0] im_data,
    input im_gnt,
    output logic im_req,
    output logic [11:0] im_addr,
    input load_v,
    input [18:0] st_bit0,
    input adv_v,
    input [19:0] adv_bit,
    input [15:0] adv_iter,
    input [5:0] rd_idx,
    input vwe,
    input [5:0] vidx,
    input [31:0] vdat,
    output logic [19:0] tree_bit,
    output logic [19:0] segs_bit,
    output logic [6:0] n_var_o,
    output logic [11:0] n_inst_o,
    output logic [4:0] idx_bits,
    output logic [31:0] rd_val,
    input [6:0] tq_tid,
    output logic [19:0] tq_bit,
    output logic [5:0] tq_len,
    output logic tq_tri,
    input [5:0] kq_idx,
    output logic [1:0] kq_kind,
    output logic tq_res,
    output logic [31:0] tq_sum,
    output logic [4:0] tq_pre0,
    input [4:0] pq_idx,
    output logic [31:0] pq_val,
    input [5:0] vr_idx,
    output logic [31:0] vr_val,
    input [5:0] rda_idx,
    output logic [31:0] rda_val,
    input [5:0] rdb_idx,
    output logic [31:0] rdb_val,
    output logic busy,
    output logic im_rq_f,
    output logic im_rq_x
);
    logic [31:0] vars_r [0:47];
    logic [31:0] vars_q [0:47];
    logic [31:0] vars_a [0:47];
    logic [31:0] vars_b [0:47];
    logic [31:0] vars_p [0:47];
    logic [1:0] vkind [0:47];
    logic [19:0] tab_bit [0:31];
    logic [5:0] tab_len [0:31];
    logic tab_tri [0:31];
    logic [31:0] tab_sum [0:31];
    logic tab_res [0:31];
    logic [4:0] tab_pre0 [0:31];
    logic [31:0] tab_pre [0:31];
    logic [4:0] st;
    logic [6:0] n_var;
    logic [6:0] n_tab;
    logic [11:0] n_inst;
    logic [4:0] idx_bits_q;
    logic [6:0] idx;
    logic [19:0] tree_bit_q;
    logic [6:0] a_left;
    logic [5:0] a_vid;
    logic [6:0] a_tid;
    logic a_sign;
    logic [31:0] a_item;
    logic [5:0] a_idx;
    logic [19:0] a_pos;
    logic [6:0] mod_r;
    logic [15:0] mod_sh;
    logic [4:0] mod_i;
    logic [15:0] todo;
    logic [6:0] sk_left;
    logic [19:0] segs_bit_q;
    logic [5:0] pre_used;
    logic [5:0] pre_room;
    logic [5:0] ld_ti;
    logic [31:0] ld_acc;
    logic ld_sign;
    logic [5:0] rb_get_w;
    logic rdy;
    logic rb_get_v;
    logic seek_go;
    logic [18:0] seek_abs;
    logic [11:0] seek_line;
    logic [6:0] seek_bit;
    logic [31:0] hv;
    logic v1;
    logic [1:0] v2;
    logic [6:0] v7;
    logic [11:0] v12;
    logic [12:0] v13;
    logic [17:0] v18;
    logic [30:0] v31;
    logic [19:0] t_bit;
    logic [5:0] t_len;
    logic t_tri;
    logic t_pow2;
    logic [5:0] lg_len;
    logic [19:0] item_off;
    logic [5:0] cur_len;
    logic [5:0] hd_len;
    logic hd_tri;
    logic hd_fit;
    logic [5:0] ld_pv;
    logic [2:0] ld_sv;
    logic [19:0] ld_ov;
    logic [31:0] ld_acc_tri;
    logic [31:0] ld_acc_sc;
    logic [4:0] cur_pre0;
    logic [4:0] ld_pre_wa;
    logic ld_last;
    logic [31:0] ap_q;
    logic [31:0] ap_old;
    logic [5:0] ap_p;
    logic [2:0] ap_s;
    logic [19:0] ap_o;
    logic [31:0] ap_val;
    logic va_we;
    logic [5:0] va_wa;
    logic [31:0] va_wd;
    logic wq_v_0;
    logic wq_v_1;
    logic wq_v_2;
    logic wq_v_3;
    logic wq_v_4;
    logic [5:0] wq_a_0;
    logic [5:0] wq_a_1;
    logic [5:0] wq_a_2;
    logic [5:0] wq_a_3;
    logic [5:0] wq_a_4;
    logic [31:0] wq_d_0;
    logic [31:0] wq_d_1;
    logic [31:0] wq_d_2;
    logic [31:0] wq_d_3;
    logic [31:0] wq_d_4;
    logic [18:0] hd_span;
    logic [18:0] sk_q;
    logic [18:0] tb_q;
    logic [6:0] sh;
    logic [6:0] nr;
    logic u_rb_ready;
    logic u_rb_im_req;
    logic u_rb_rq_f;
    logic u_rb_rq_x;
    logic [11:0] u_rb_im_addr;
    logic [31:0] u_rb_hd;
    logic [18:0] u_rb_pos;

    initial begin
        for (int _i = 0; _i < 48; _i++) vkind[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_bit[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_len[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_tri[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_sum[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_res[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_pre0[_i] = 0;
        for (int _i = 0; _i < 32; _i++) tab_pre[_i] = 0;
    end

    assign tree_bit = tree_bit_q;
    assign segs_bit = segs_bit_q;
    assign n_var_o = n_var;
    assign n_inst_o = n_inst;
    assign idx_bits = idx_bits_q;
    assign rd_val = vars_r[rd_idx];
    assign tq_bit = tab_bit[tq_tid];
    assign tq_len = tab_len[tq_tid];
    assign tq_tri = tab_tri[tq_tid];
    assign kq_kind = vkind[kq_idx];
    assign tq_res = tab_res[tq_tid];
    assign tq_sum = tab_sum[tq_tid];
    assign tq_pre0 = tab_pre0[tq_tid];
    assign pq_val = tab_pre[pq_idx];
    assign vr_val = vars_q[vr_idx];
    assign rda_val = vars_a[rda_idx];
    assign rdb_val = vars_b[rdb_idx];
    assign busy = (st != 0);
    assign rb_get_w = ((st == 0) ? 0 :
                      ((st == 1) ? 16 :
                      ((st == 2) ? 31 :
                      ((st == 3) ? 2 :
                      ((st == 4) ? 7 :
                      ((st == 5) ? 0 :
                      ((st == 6) ? 0 :
                      ((st == 7) ? 7 :
                      ((st == 8) ? 13 :
                      ((st == 9) ? 0 :
                      ((st == 10) ? 0 :
                      ((st == 11) ? 0 :
                      ((st == 12) ? 32 :
                      ((st == 13) ? 1 :
                      ((st == 14) ? 32 :
                      ((st == 15) ? 0 :
                      ((st == 16) ? 0 :
                      ((st == 17) ? 12 :
                      ((st == 18) ? 1 :
                      ((st == 19) ? 18 :
                      ((st == 20) ? 24 :
                      ((st == 21) ? 24 :
                      ((st == 22) ? 14 :
                      ((st == 23) ? 7 :
                      ((st == 24) ? 13 :
                      ((st == 25) ? 12 :
                      ((st == 26) ? 32 :
                      ((st == 27) ? 1 :
                      32))))))))))))))))))))))))))));
    assign rb_get_v = (rdy & (rb_get_w != 0));
    assign seek_line = seek_abs[18:7];
    assign seek_bit = seek_abs[6:0];
    assign rdy = u_rb_ready;
    assign im_req = u_rb_im_req;
    assign im_rq_f = u_rb_rq_f;
    assign im_rq_x = u_rb_rq_x;
    assign im_addr = u_rb_im_addr;
    assign hv = u_rb_hd;
    assign v1 = hv[31];
    assign v2 = hv[31:30];
    assign v7 = hv[31:25];
    assign v12 = hv[31:20];
    assign v13 = hv[31:19];
    assign v18 = hv[31:14];
    assign v31 = hv[31:1];
    assign t_bit = tab_bit[a_tid];
    assign t_len = tab_len[a_tid];
    assign t_tri = tab_tri[a_tid];
    assign t_pow2 = ((t_len & (t_len - 1)) == 0);
    assign lg_len = (t_len[0] ? 6'd0 :
                    (t_len[1] ? 6'd1 :
                    (t_len[2] ? 6'd2 :
                    (t_len[3] ? 6'd3 :
                    (t_len[4] ? 6'd4 :
                    6'd5)))));
    assign item_off = ({a_idx, 5'd0} + (t_tri ? 20'd0 : {14'd0, a_idx}));
    assign cur_len = tab_len[idx];
    assign hd_len = v7[6:1];
    assign hd_tri = v7[0];
    assign hd_fit = (pre_room >= hd_len);
    assign ld_pv = (hv[31] ? (6'd0 - hv[30:25]) : hv[30:25]);
    assign ld_sv = (hv[24] ? (3'd0 - hv[23:21]) : hv[23:21]);
    assign ld_ov = (hv[20] ? (20'd0 - hv[19:0]) : hv[19:0]);
    assign ld_acc_tri = {3'd0, (ld_acc[28:23] + ld_pv), (ld_acc[22:20] + ld_sv), (ld_acc[19:0] + ld_ov)};
    assign ld_acc_sc = (ld_sign ? (ld_acc - hv) : (ld_acc + hv));
    assign cur_pre0 = tab_pre0[idx];
    assign ld_pre_wa = (cur_pre0 + ld_ti[4:0]);
    assign ld_last = ((ld_ti + 1) >= cur_len);
    assign ap_old = ap_q;
    assign ap_p = (a_item[31] ? (ap_old[28:23] - a_item[30:25]) : (ap_old[28:23] + a_item[30:25]));
    assign ap_s = (a_item[24] ? (ap_old[22:20] - a_item[23:21]) : (ap_old[22:20] + a_item[23:21]));
    assign ap_o = (a_item[20] ? (ap_old[19:0] - a_item[19:0]) : (ap_old[19:0] + a_item[19:0]));
    assign ap_val = (t_tri ? {3'd0, ap_p, ap_s, ap_o} : (a_sign ? (ap_old - a_item) : (ap_old + a_item)));
    assign va_we = (vwe | (st == 15));
    assign va_wa = ((st == 15) ? a_vid : vidx);
    assign va_wd = ((st == 15) ? ap_val : vdat);
    assign seek_go = (((((st == 0) & (load_v | adv_v)) | (st == 5)) | (st == 11)) | ((st == 16) & (a_left != 0)));
    assign hd_span = ({hd_len, 5'd0} + (hd_tri ? 19'd0 : {13'd0, hd_len}));
    assign seek_abs = ((st == 5) ? sk_q :
                      (((st == 0) | (st == 16))
                       ? (st_bit0 + ((st == 0) ? (load_v ? 19'd0 : adv_bit[18:0]) : a_pos[18:0])) :
                      (tb_q + item_off[18:0])));
    assign sh = {mod_r[5:0], mod_sh[15]};
    assign nr = ((sh >= {1'd0, t_len}) ? (sh - {1'd0, t_len}) : sh);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ap_q <= 0;
            tb_q <= 0;
            wq_v_0 <= 0;
            wq_a_0 <= 0;
            wq_d_0 <= 0;
            wq_v_1 <= 0;
            wq_a_1 <= 0;
            wq_d_1 <= 0;
            wq_v_2 <= 0;
            wq_a_2 <= 0;
            wq_d_2 <= 0;
            wq_v_3 <= 0;
            wq_a_3 <= 0;
            wq_d_3 <= 0;
            wq_v_4 <= 0;
            wq_a_4 <= 0;
            wq_d_4 <= 0;
            st <= 0;
            n_var <= 0;
            n_tab <= 0;
            n_inst <= 0;
            idx_bits_q <= 0;
            idx <= 0;
            pre_used <= 0;
            pre_room <= 32;
            ld_acc <= 0;
            ld_ti <= 0;
            sk_q <= 0;
            tree_bit_q <= 0;
            a_left <= 0;
            a_pos <= 0;
            a_vid <= 0;
            a_tid <= 0;
            a_idx <= 0;
            mod_r <= 0;
            mod_sh <= 0;
            mod_i <= 0;
            a_item <= 0;
            a_sign <= 0;
            ld_sign <= 0;
            todo <= 0;
            segs_bit_q <= 0;
            sk_left <= 0;
        end else begin
            ap_q <= vars_p[a_vid];
            tb_q <= (st_bit0 + t_bit[18:0]);
            wq_v_0 <= va_we;
            wq_a_0 <= va_wa;
            wq_d_0 <= va_wd;
            wq_v_1 <= va_we;
            wq_a_1 <= va_wa;
            wq_d_1 <= va_wd;
            wq_v_2 <= va_we;
            wq_a_2 <= va_wa;
            wq_d_2 <= va_wd;
            wq_v_3 <= va_we;
            wq_a_3 <= va_wa;
            wq_d_3 <= va_wd;
            wq_v_4 <= va_we;
            wq_a_4 <= va_wa;
            wq_d_4 <= va_wd;
            case (st)
                0: begin
                    if (load_v) begin
                        st <= 1;
                    end else begin
                        if (adv_v) begin
                            st <= 7;
                        end
                    end
                end
                1: begin
                    if (rdy) begin
                        st <= 2;
                    end
                end
                2: begin
                    if (rdy) begin
                        n_var <= v31[30:24];
                        n_tab <= v31[23:17];
                        n_inst <= v31[16:5];
                        idx_bits_q <= v31[4:0];
                        idx <= 0;
                        pre_used <= 0;
                        pre_room <= 32;
                        if ((v31[30:24] == 0)) begin
                            st <= ((v31[23:17] == 0) ? 5'd6 : 5'd4);
                        end else begin
                            st <= 3;
                        end
                    end
                end
                3: begin
                    if (rdy) begin
                        vkind[idx[5:0]] <= v2[1:0];
                        idx <= (idx + 1);
                        if (((idx + 1) >= n_var)) begin
                            idx <= 0;
                            st <= ((n_tab == 0) ? 5'd6 : 5'd4);
                        end
                    end
                end
                4: begin
                    if (rdy) begin
                        tab_len[idx] <= v7[6:1];
                        tab_tri[idx] <= v7[0];
                        tab_bit[idx] <= ((u_rb_pos - st_bit0) + 7);
                        tab_res[idx] <= hd_fit;
                        tab_pre0[idx] <= pre_used[4:0];
                        ld_acc <= 0;
                        ld_ti <= 0;
                        sk_q <= ((u_rb_pos + 7) + hd_span);
                        if (hd_fit) begin
                            pre_used <= (pre_used + hd_len);
                            pre_room <= (pre_room - hd_len);
                            if ((hd_len == 0)) begin
                                tab_sum[idx] <= 0;
                                idx <= (idx + 1);
                                st <= (((idx + 1) >= n_tab) ? 5'd6 : 5'd4);
                            end else begin
                                st <= (hd_tri ? 5'd26 : 5'd27);
                            end
                        end else begin
                            st <= 5;
                        end
                    end
                end
                5: begin
                    idx <= (idx + 1);
                    st <= (((idx + 1) >= n_tab) ? 5'd6 : 5'd4);
                end
                6: begin
                    tree_bit_q <= (u_rb_pos - st_bit0);
                    st <= 17;
                end
                7: begin
                    if (rdy) begin
                        a_left <= v7[6:0];
                        a_pos <= ((u_rb_pos - st_bit0) + 7);
                        st <= ((v7[6:0] == 0) ? 5'd0 : 5'd8);
                    end
                end
                8: begin
                    if (rdy) begin
                        a_vid <= v13[12:7];
                        a_tid <= v13[6:0];
                        a_left <= (a_left - 1);
                        a_pos <= (a_pos + 13);
                        st <= 9;
                    end
                end
                9: begin
                    if ((t_len == 0)) begin
                        st <= 16;
                    end else begin
                        if (t_pow2) begin
                            a_idx <= (adv_iter[5:0] & (t_len - 1));
                            st <= 11;
                        end else begin
                            mod_r <= 0;
                            mod_sh <= adv_iter;
                            mod_i <= 16;
                            st <= 10;
                        end
                    end
                end
                10: begin
                    mod_r <= nr;
                    mod_sh <= {mod_sh[14:0], 1'd0};
                    mod_i <= (mod_i - 1);
                    if ((mod_i == 1)) begin
                        a_idx <= nr[5:0];
                        st <= 11;
                    end
                end
                11: begin
                    st <= (t_tri ? 5'd12 : 5'd13);
                end
                12: begin
                    if (rdy) begin
                        a_item <= hv;
                        st <= 15;
                    end
                end
                13: begin
                    if (rdy) begin
                        a_sign <= v1;
                        st <= 14;
                    end
                end
                14: begin
                    if (rdy) begin
                        a_item <= hv;
                        st <= 15;
                    end
                end
                15: begin
                    st <= 16;
                end
                16: begin
                    st <= ((a_left == 0) ? 5'd0 : 5'd8);
                end
                26: begin
                    if (rdy) begin
                        tab_pre[ld_pre_wa] <= ld_acc;
                        ld_acc <= ld_acc_tri;
                        ld_ti <= (ld_ti + 1);
                        if (ld_last) begin
                            tab_sum[idx] <= ld_acc_tri;
                            idx <= (idx + 1);
                            st <= (((idx + 1) >= n_tab) ? 5'd6 : 5'd4);
                        end
                    end
                end
                27: begin
                    if (rdy) begin
                        ld_sign <= v1;
                        st <= 28;
                    end
                end
                28: begin
                    if (rdy) begin
                        tab_pre[ld_pre_wa] <= ld_acc;
                        ld_acc <= ld_acc_sc;
                        ld_ti <= (ld_ti + 1);
                        if (ld_last) begin
                            tab_sum[idx] <= ld_acc_sc;
                            idx <= (idx + 1);
                            st <= (((idx + 1) >= n_tab) ? 5'd6 : 5'd4);
                        end else begin
                            st <= 27;
                        end
                    end
                end
                17: begin
                    if (rdy) begin
                        todo <= v12[11:0];
                        if ((v12[11:0] == 0)) begin
                            segs_bit_q <= ((u_rb_pos - st_bit0) + 12);
                            st <= 0;
                        end else begin
                            st <= 18;
                        end
                    end
                end
                18: begin
                    if (rdy) begin
                        todo <= (todo - 1);
                        if ((v1 == 0)) begin
                            if ((todo == 1)) begin
                                segs_bit_q <= ((u_rb_pos - st_bit0) + 1);
                                st <= 0;
                            end
                        end else begin
                            st <= 19;
                        end
                    end
                end
                19: begin
                    if (rdy) begin
                        st <= (v18[0] ? 5'd20 : 5'd23);
                    end
                end
                20: begin
                    if (rdy) begin
                        st <= 21;
                    end
                end
                21: begin
                    if (rdy) begin
                        st <= 22;
                    end
                end
                22: begin
                    if (rdy) begin
                        st <= 23;
                    end
                end
                23: begin
                    if (rdy) begin
                        sk_left <= v7[6:0];
                        st <= ((v7[6:0] == 0) ? 5'd25 : 5'd24);
                    end
                end
                24: begin
                    if (rdy) begin
                        sk_left <= (sk_left - 1);
                        st <= ((sk_left == 1) ? 5'd25 : 5'd24);
                    end
                end
                default: begin
                    if (rdy) begin
                        todo <= (todo + v12[11:0]);
                        if (((todo + v12[11:0]) == 0)) begin
                            segs_bit_q <= ((u_rb_pos - st_bit0) + 12);
                            st <= 0;
                        end else begin
                            st <= 18;
                        end
                    end
                end
            endcase
        end
    end
    always_ff @(posedge clk) begin
        if (wq_v_0) begin
            vars_r[wq_a_0] <= wq_d_0;
        end
        if (wq_v_1) begin
            vars_q[wq_a_1] <= wq_d_1;
        end
        if (wq_v_2) begin
            vars_a[wq_a_2] <= wq_d_2;
        end
        if (wq_v_3) begin
            vars_b[wq_a_3] <= wq_d_3;
        end
        if (wq_v_4) begin
            vars_p[wq_a_4] <= wq_d_4;
        end
    end
    // RawBlock(initial) — forward-direction artifact, preserved verbatim:
    initial begin
        for (int _i = 0; _i < 48; _i++) begin
            vars_r[_i] = 0; vars_q[_i] = 0; vars_a[_i] = 0; vars_b[_i] = 0; vars_p[_i] = 0;
        end
    end

    KBitStream u_rb (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(im_gnt),
        .seek_v(seek_go),
        .seek_line(seek_line),
        .seek_bit(seek_bit),
        .get_v(rb_get_v),
        .get_w(rb_get_w),
        .req_v(rb_get_v),
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
