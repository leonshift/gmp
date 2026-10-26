module L1Entrance1 #(
    parameter NQ = 1
) (
    input clk,
    input rst_n,
    input ar_valid,
    output logic ar_ready,
    input [3:0] ar_id,
    input [15:0] ar_tag,
    input [7:0] ar_cfg,
    input [19:0] ar_off,
    input [19:0] ar_bytes,
    input [15:0] ar_rows,
    input [19:0] ar_stride,
    input ar_first,
    input ar_last,
    input aw_valid,
    output logic aw_ready,
    input [3:0] aw_id,
    input [15:0] aw_tag,
    input [7:0] aw_cfg,
    input [19:0] aw_off,
    input [19:0] aw_bytes,
    input [15:0] aw_rows,
    input [19:0] aw_stride,
    input aw_first,
    input aw_last,
    output logic hd_valid,
    output logic [2:0] hd_q,
    output logic [7:0] hd_cid,
    output logic hd_dir,
    output logic [19:0] hd_off,
    output logic [19:0] hd_bytes,
    output logic [15:0] hd_rows,
    output logic [19:0] hd_stride,
    output logic [15:0] hd_tag,
    output logic hd_first,
    output logic hd_last,
    input hd_pop,
    output logic [7:0] dbg_occ
);
    logic [7:0] q_cid [0:3];
    logic q_dir [0:3];
    logic [19:0] q_off [0:3];
    logic [19:0] q_bytes [0:3];
    logic [15:0] q_rows [0:3];
    logic [19:0] q_stride [0:3];
    logic [15:0] q_tag [0:3];
    logic q_first [0:3];
    logic q_last [0:3];
    logic [1:0] wp_0;
    logic [1:0] rp_0;
    logic [2:0] cnt_0;
    logic ne_0;
    logic fl_0;
    logic [2:0] rr;
    logic [7:0] occ;
    logic ia_v;
    logic [3:0] ia_id;
    logic [7:0] ia_cid;
    logic [19:0] ia_off;
    logic [19:0] ia_bytes;
    logic [15:0] ia_rows;
    logic [19:0] ia_stride;
    logic [15:0] ia_tag;
    logic ia_first;
    logic ia_last;
    logic iw_v;
    logic [3:0] iw_id;
    logic [7:0] iw_cid;
    logic [19:0] iw_off;
    logic [19:0] iw_bytes;
    logic [15:0] iw_rows;
    logic [19:0] iw_stride;
    logic [15:0] iw_tag;
    logic iw_first;
    logic iw_last;
    logic hq_v;
    logic [2:0] hq_q;
    logic [1:0] hq_rp;
    logic [7:0] hq_cid;
    logic hq_dir;
    logic [19:0] hq_off;
    logic [19:0] hq_bytes;
    logic [15:0] hq_rows;
    logic [19:0] hq_stride;
    logic [15:0] hq_tag;
    logic hq_first;
    logic hq_last;
    logic lp_v;
    logic [2:0] lp_q;
    logic [1:0] lp_rp;
    logic [2:0] ia_q;
    logic [2:0] iw_q;
    logic ia_full;
    logic iw_full;
    logic push_a;
    logic push_w;
    logic push;
    logic in_full;
    logic in_dir;
    logic [2:0] in_q;
    logic [1:0] in_wp;
    logic [4:0] in_idx;
    logic [7:0] in_cid;
    logic [19:0] in_off;
    logic [19:0] in_bytes;
    logic [15:0] in_rows;
    logic [19:0] in_stride;
    logic [15:0] in_tag;
    logic in_first;
    logic in_last;
    logic ahd_0;
    logic [2:0] hsel0;
    logic [1:0] h_rp0;
    logic [4:0] h_idx;
    logic a_byq;
    logic w_byq;
    logic h_ba;
    logic h_bw;
    logic hsel_v;
    logic [2:0] hsel;
    logic [1:0] h_rp;
    logic [7:0] c_cid;
    logic c_dir;
    logic [19:0] c_off;
    logic [19:0] c_bytes;
    logic [15:0] c_rows;
    logic [19:0] c_stride;
    logic [15:0] c_tag;
    logic c_first;
    logic c_last;
    logic [2:0] rr_nx;
    logic hq_stale;
    logic hd_v;
    logic dopop;
    logic pu_l_0;
    logic pok_0;
    logic [2:0] cnt_p0_0;
    logic [2:0] cnt_p1_0;
    logic [2:0] cnt_nx_0;
    logic [7:0] occ_p0;
    logic [7:0] occ_p1;

    initial begin
        for (int _i = 0; _i < 4; _i++) q_cid[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_dir[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_off[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_bytes[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_rows[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_stride[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_tag[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_first[_i] = 0;
        for (int _i = 0; _i < 4; _i++) q_last[_i] = 0;
    end

    assign ia_q = ia_id[2:0];
    assign iw_q = iw_id[2:0];
    assign ia_full = fl_0;
    assign iw_full = fl_0;
    assign push_a = (ia_v & (~ia_full));
    assign push_w = ((iw_v & (~iw_full)) & (~push_a));
    assign push = (push_a | push_w);
    assign in_full = ((ia_v & ia_full) | (iw_v & iw_full));
    assign ar_ready = (~(ia_v & ia_full));
    assign aw_ready = (~(iw_v & (iw_full | push_a)));
    assign in_dir = (~push_a);
    assign in_q = (push_a ? ia_q : iw_q);
    assign in_wp = wp_0;
    assign in_idx = {in_q, in_wp};
    assign in_cid = (push_a ? ia_cid : iw_cid);
    assign in_off = (push_a ? ia_off : iw_off);
    assign in_bytes = (push_a ? ia_bytes : iw_bytes);
    assign in_rows = (push_a ? ia_rows : iw_rows);
    assign in_stride = (push_a ? ia_stride : iw_stride);
    assign in_tag = (push_a ? ia_tag : iw_tag);
    assign in_first = (push_a ? ia_first : iw_first);
    assign in_last = (push_a ? ia_last : iw_last);
    assign ahd_0 = 1'd0;
    assign hsel0 = 3'd0;
    assign h_rp0 = rp_0;
    assign h_idx = {hsel0, h_rp0};
    assign a_byq = (1'd0 | (((ia_q == 0) & (~ne_0)) & (~ahd_0)));
    assign w_byq = (1'd0 | (((iw_q == 0) & (~ne_0)) & (~ahd_0)));
    assign h_ba = (ia_v & a_byq);
    assign h_bw = ((iw_v & (~push_a)) & w_byq);
    assign hsel_v = ((({ne_0} != 0) | (push_a & (1'd0 | (ia_q == 0)))) | (push_w & (1'd0 | (iw_q == 0))));
    assign hsel = (h_ba ? ia_q : (h_bw ? iw_q : hsel0));
    assign h_rp = (h_ba ? rp_0 : (h_bw ? rp_0 : h_rp0));
    assign c_cid = (h_ba ? ia_cid : (h_bw ? iw_cid : q_cid[h_idx]));
    assign c_dir = (h_ba ? 1'd0 : (h_bw ? 1'd1 : q_dir[h_idx]));
    assign c_off = (h_ba ? ia_off : (h_bw ? iw_off : q_off[h_idx]));
    assign c_bytes = (h_ba ? ia_bytes : (h_bw ? iw_bytes : q_bytes[h_idx]));
    assign c_rows = (h_ba ? ia_rows : (h_bw ? iw_rows : q_rows[h_idx]));
    assign c_stride = (h_ba ? ia_stride : (h_bw ? iw_stride : q_stride[h_idx]));
    assign c_tag = (h_ba ? ia_tag : (h_bw ? iw_tag : q_tag[h_idx]));
    assign c_first = (h_ba ? ia_first : (h_bw ? iw_first : q_first[h_idx]));
    assign c_last = (h_ba ? ia_last : (h_bw ? iw_last : q_last[h_idx]));
    assign rr_nx = (h_ba ? ((ia_q == (NQ - 1)) ? 3'd0 : (ia_q + 1)) :
                   (h_bw ? ((iw_q == (NQ - 1)) ? 3'd0 : (iw_q + 1)) :
                   ((hsel0 == (NQ - 1)) ? 3'd0 :
                   (hsel0 + 1))));
    assign hq_stale = ((lp_v & (lp_q == hq_q)) & (lp_rp == hq_rp));
    assign hd_v = (hq_v & (~hq_stale));
    assign hd_valid = hd_v;
    assign hd_q = hq_q;
    assign hd_cid = hq_cid;
    assign hd_dir = hq_dir;
    assign hd_off = hq_off;
    assign hd_bytes = hq_bytes;
    assign hd_rows = hq_rows;
    assign hd_stride = hq_stride;
    assign hd_tag = hq_tag;
    assign hd_first = hq_first;
    assign hd_last = hq_last;
    assign dbg_occ = occ;
    assign dopop = (hd_pop & hd_v);
    assign pu_l_0 = (push & (in_q == 0));
    assign pok_0 = (hd_v & (hq_q == 0));
    assign cnt_p0_0 = (pu_l_0 ? (cnt_0 + 1) : cnt_0);
    assign cnt_p1_0 = (pok_0 ? (pu_l_0 ? cnt_0 : (cnt_0 - 1)) : cnt_p0_0);
    assign cnt_nx_0 = (hd_pop ? cnt_p1_0 : cnt_p0_0);
    assign occ_p0 = (push ? (occ + 1) : occ);
    assign occ_p1 = (hd_v ? (push ? occ : (occ - 1)) : occ_p0);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ia_v <= 0;
            iw_v <= 0;
            hq_v <= 0;
            hq_q <= 0;
            hq_rp <= 0;
            hq_cid <= 0;
            hq_dir <= 0;
            hq_off <= 0;
            hq_bytes <= 0;
            hq_rows <= 0;
            hq_stride <= 0;
            hq_tag <= 0;
            hq_first <= 0;
            hq_last <= 0;
            lp_v <= 0;
            lp_q <= 0;
            lp_rp <= 0;
            wp_0 <= 0;
            rp_0 <= 0;
            cnt_0 <= 0;
            ne_0 <= 0;
            fl_0 <= 0;
            occ <= 0;
            rr <= 0;
        end else begin
            if (ar_ready) begin
                ia_v <= ar_valid;
            end
            if (aw_ready) begin
                iw_v <= aw_valid;
            end
            hq_v <= hsel_v;
            hq_q <= hsel;
            hq_rp <= h_rp;
            hq_cid <= c_cid;
            hq_dir <= c_dir;
            hq_off <= c_off;
            hq_bytes <= c_bytes;
            hq_rows <= c_rows;
            hq_stride <= c_stride;
            hq_tag <= c_tag;
            hq_first <= c_first;
            hq_last <= c_last;
            lp_v <= dopop;
            lp_q <= hq_q;
            lp_rp <= hq_rp;
            if (push) begin
                q_cid[in_idx] <= in_cid;
                q_dir[in_idx] <= in_dir;
                q_off[in_idx] <= in_off;
                q_bytes[in_idx] <= in_bytes;
                q_rows[in_idx] <= in_rows;
                q_stride[in_idx] <= in_stride;
                q_tag[in_idx] <= in_tag;
                q_first[in_idx] <= in_first;
                q_last[in_idx] <= in_last;
            end
            if (pu_l_0) begin
                wp_0 <= (in_wp + 1);
            end
            if ((hd_pop & pok_0)) begin
                rp_0 <= (hq_rp + 1);
            end
            cnt_0 <= cnt_nx_0;
            ne_0 <= (hd_pop ? (cnt_p1_0 != 0) : (cnt_p0_0 != 0));
            fl_0 <= (hd_pop ? (cnt_p1_0 == 4) : (cnt_p0_0 == 4));
            occ <= (hd_pop ? occ_p1 : occ_p0);
            if (hsel_v) begin
                rr <= rr_nx;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (ar_ready) begin
            ia_id <= ar_id;
            ia_cid <= ar_cfg;
            ia_off <= ar_off;
            ia_bytes <= ar_bytes;
            ia_rows <= ar_rows;
            ia_stride <= ar_stride;
            ia_tag <= ar_tag;
            ia_first <= ar_first;
            ia_last <= ar_last;
        end
        if (aw_ready) begin
            iw_id <= aw_id;
            iw_cid <= aw_cfg;
            iw_off <= aw_off;
            iw_bytes <= aw_bytes;
            iw_rows <= aw_rows;
            iw_stride <= aw_stride;
            iw_tag <= aw_tag;
            iw_first <= aw_first;
            iw_last <= aw_last;
        end
    end
endmodule
