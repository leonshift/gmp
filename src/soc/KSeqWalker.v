module KSeqWalker (
    input clk,
    input rst_n,
    input [127:0] im_data,
    output logic im_req,
    output logic [11:0] im_addr,
    input lc_v,
    input [15:0] lc_id,
    input [23:0] lc_first,
    input [15:0] lc_len,
    input out_rdy,
    input inval,
    input [5:0] rd_idx,
    input [5:0] rda_idx,
    input [5:0] rdb_idx,
    output logic out_v,
    output logic [127:0] out_inst,
    output logic [2:0] out_nw,
    output logic [13:0] out_word,
    output logic [31:0] rd_val,
    output logic [31:0] rda_val,
    output logic [31:0] rdb_val,
    output logic [6:0] n_var_o,
    output logic [11:0] n_inst_o,
    output logic [31:0] leaves_o,
    output logic lc_ready,
    output logic busy,
    output logic done,
    output logic err
);
    logic [2:0] st;
    logic [23:0] cur_g;
    logic [15:0] cur_kid;
    logic [15:0] g_left;
    logic va_ack;
    logic sv_ack;
    logic rt_ack;
    logic err_q;
    logic dir_gnt;
    logic va_gnt;
    logic sv_gnt;
    logic rt_gnt;
    logic dir_find;
    logic [18:0] st_bit0;
    logic [11:0] word_line0;
    logic fresh;
    logic va_load;
    logic sv_busy;
    logic [5:0] rt_cq_idx;
    logic [5:0] sv_vr_idx;
    logic [5:0] vr_sel;
    logic [6:0] sv_tq_tid;
    logic [5:0] sv_kq_idx;
    logic [4:0] sv_pq_idx;
    logic sv_vwe;
    logic [5:0] sv_vidx;
    logic [31:0] sv_vdat;
    logic rt_adv_v;
    logic [19:0] rt_adv_bit;
    logic [15:0] rt_adv_iter;
    logic sv_start;
    logic rt_start;
    logic dir_want;
    logic va_want;
    logic sv_want;
    logic rt_want;
    logic hi_f;
    logic hi_want;
    logic [11:0] hi_addr;
    logic [19:0] u_va_segs_bit;
    logic [6:0] u_va_n_var_o;
    logic [4:0] u_va_idx_bits;
    logic [19:0] u_va_tq_bit;
    logic [5:0] u_va_tq_len;
    logic u_va_tq_tri;
    logic [1:0] u_va_kq_kind;
    logic [31:0] u_va_vr_val;
    logic u_va_tq_res;
    logic [31:0] u_va_tq_sum;
    logic [4:0] u_va_tq_pre0;
    logic [31:0] u_va_pq_val;
    logic [19:0] u_va_tree_bit;
    logic u_va_busy;
    logic [15:0] u_dir_d_st_off;
    logic [15:0] u_dir_d_word_off;
    logic u_dir_fresh;
    logic u_dir_hit;
    logic u_sv_busy;
    logic [5:0] u_sv_vr_idx;
    logic [6:0] u_sv_tq_tid;
    logic [5:0] u_sv_kq_idx;
    logic [4:0] u_sv_pq_idx;
    logic u_sv_wr_v;
    logic [5:0] u_sv_wr_idx;
    logic [31:0] u_sv_wr_val;
    logic [5:0] u_rt_cq_idx;
    logic u_rt_adv_v;
    logic [19:0] u_rt_adv_bit;
    logic [15:0] u_rt_adv_iter;
    logic u_dir_im_req;
    logic u_dir_busy;
    logic u_va_im_rq_f;
    logic u_va_im_rq_x;
    logic u_sv_im_rq_f;
    logic u_sv_im_rq_x;
    logic u_rt_im_req;
    logic u_rt_busy;
    logic [11:0] u_dir_im_addr;
    logic [11:0] u_va_im_addr;
    logic [11:0] u_sv_im_addr;
    logic [11:0] u_rt_im_addr;
    logic u_rt_out_v;
    logic [127:0] u_rt_out_inst;
    logic [2:0] u_rt_out_nw;
    logic [13:0] u_rt_out_word;
    logic [31:0] u_va_rd_val;
    logic [31:0] u_va_rda_val;
    logic [31:0] u_va_rdb_val;
    logic [11:0] u_dir_d_n_inst;
    logic [31:0] u_dir_d_leaves;
    logic u_dir_miss;
    logic u_rt_done;

    assign dir_find = ((st == 0) & lc_v);
    assign st_bit0 = {u_dir_d_st_off, 3'd0};
    assign word_line0 = u_dir_d_word_off[15:4];
    assign fresh = u_dir_fresh;
    assign va_load = (((st == 1) & u_dir_hit) & fresh);
    assign vr_sel = (sv_busy ? sv_vr_idx : rt_cq_idx);
    assign sv_start = (st == 3);
    assign sv_busy = u_sv_busy;
    assign sv_vr_idx = u_sv_vr_idx;
    assign sv_tq_tid = u_sv_tq_tid;
    assign sv_kq_idx = u_sv_kq_idx;
    assign sv_pq_idx = u_sv_pq_idx;
    assign sv_vwe = u_sv_wr_v;
    assign sv_vidx = u_sv_wr_idx;
    assign sv_vdat = u_sv_wr_val;
    assign rt_start = (((st == 4) & (~u_sv_busy)) & sv_ack);
    assign rt_cq_idx = u_rt_cq_idx;
    assign rt_adv_v = u_rt_adv_v;
    assign rt_adv_bit = u_rt_adv_bit;
    assign rt_adv_iter = u_rt_adv_iter;
    assign dir_want = (u_dir_im_req & u_dir_busy);
    assign va_want = ((u_va_im_rq_f & u_va_busy) | u_va_im_rq_x);
    assign sv_want = ((u_sv_im_rq_f & u_sv_busy) | u_sv_im_rq_x);
    assign rt_want = (u_rt_im_req & u_rt_busy);
    assign hi_f = ((dir_want | (u_va_im_rq_f & u_va_busy)) | (u_sv_im_rq_f & u_sv_busy));
    assign hi_want = ((hi_f | u_va_im_rq_x) | u_sv_im_rq_x);
    assign dir_gnt = dir_want;
    assign va_gnt = va_want;
    assign sv_gnt = sv_want;
    assign rt_gnt = (rt_want & (~hi_want));
    assign hi_addr = (u_dir_busy ? u_dir_im_addr : (u_va_busy ? u_va_im_addr : u_sv_im_addr));
    assign im_req = (hi_want | rt_want);
    assign im_addr = (hi_want ? hi_addr : u_rt_im_addr);
    assign out_v = u_rt_out_v;
    assign out_inst = u_rt_out_inst;
    assign out_nw = u_rt_out_nw;
    assign out_word = u_rt_out_word;
    assign rd_val = u_va_rd_val;
    assign rda_val = u_va_rda_val;
    assign rdb_val = u_va_rdb_val;
    assign n_var_o = u_va_n_var_o;
    assign n_inst_o = u_dir_d_n_inst;
    assign leaves_o = u_dir_d_leaves;
    assign lc_ready = (st == 0);
    assign busy = (st != 0);
    assign done = (st == 6);
    assign err = err_q;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            err_q <= 0;
            cur_g <= 0;
            cur_kid <= 0;
            g_left <= 0;
            va_ack <= 0;
            st <= 0;
            sv_ack <= 0;
            rt_ack <= 0;
        end else begin
            case (st)
                0: begin
                    err_q <= 0;
                    if (lc_v) begin
                        cur_g <= lc_first;
                        cur_kid <= lc_id;
                        g_left <= lc_len;
                        va_ack <= 0;
                        st <= 1;
                    end
                end
                1: begin
                    if (u_dir_hit) begin
                        st <= (fresh ? 3'd2 : 3'd3);
                    end else begin
                        if (u_dir_miss) begin
                            err_q <= 1;
                            st <= 6;
                        end
                    end
                end
                2: begin
                    if (u_va_busy) begin
                        va_ack <= 1;
                    end else begin
                        if (va_ack) begin
                            st <= 3;
                        end
                    end
                end
                3: begin
                    sv_ack <= 0;
                    st <= 4;
                end
                4: begin
                    if (u_sv_busy) begin
                        sv_ack <= 1;
                    end else begin
                        if (sv_ack) begin
                            rt_ack <= 0;
                            st <= 5;
                        end
                    end
                end
                5: begin
                    if ((~u_rt_done)) begin
                        rt_ack <= 1;
                    end else begin
                        if (rt_ack) begin
                            cur_g <= (cur_g + 1);
                            g_left <= (g_left - 1);
                            st <= ((g_left == 1) ? 3'd6 : 3'd3);
                        end
                    end
                end
                default: begin
                    st <= 0;
                end
            endcase
        end
    end

    KDirScan u_dir (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(dir_gnt),
        .find_v(dir_find),
        .find_id(lc_id),
        .inval(inval),
        .d_st_off(u_dir_d_st_off),
        .d_word_off(u_dir_d_word_off),
        .fresh(u_dir_fresh),
        .hit(u_dir_hit),
        .im_req(u_dir_im_req),
        .busy(u_dir_busy),
        .im_addr(u_dir_im_addr),
        .d_n_inst(u_dir_d_n_inst),
        .d_leaves(u_dir_d_leaves),
        .miss(u_dir_miss)
    );
    KVarAdv u_va (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(va_gnt),
        .load_v(va_load),
        .st_bit0(st_bit0),
        .adv_v(rt_adv_v),
        .adv_bit(rt_adv_bit),
        .adv_iter(rt_adv_iter),
        .rd_idx(rd_idx),
        .rda_idx(rda_idx),
        .rdb_idx(rdb_idx),
        .vwe(sv_vwe),
        .vidx(sv_vidx),
        .vdat(sv_vdat),
        .tq_tid(sv_tq_tid),
        .kq_idx(sv_kq_idx),
        .vr_idx(vr_sel),
        .pq_idx(sv_pq_idx),
        .segs_bit(u_va_segs_bit),
        .n_var_o(u_va_n_var_o),
        .idx_bits(u_va_idx_bits),
        .tq_bit(u_va_tq_bit),
        .tq_len(u_va_tq_len),
        .tq_tri(u_va_tq_tri),
        .kq_kind(u_va_kq_kind),
        .vr_val(u_va_vr_val),
        .tq_res(u_va_tq_res),
        .tq_sum(u_va_tq_sum),
        .tq_pre0(u_va_tq_pre0),
        .pq_val(u_va_pq_val),
        .tree_bit(u_va_tree_bit),
        .busy(u_va_busy),
        .im_rq_f(u_va_im_rq_f),
        .im_rq_x(u_va_im_rq_x),
        .im_addr(u_va_im_addr),
        .rd_val(u_va_rd_val),
        .rda_val(u_va_rda_val),
        .rdb_val(u_va_rdb_val)
    );
    KStartVar u_sv (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(sv_gnt),
        .start_v(sv_start),
        .start_g(cur_g),
        .st_bit0(st_bit0),
        .segs_bit(u_va_segs_bit),
        .n_var(u_va_n_var_o),
        .idx_bits(u_va_idx_bits),
        .kid(cur_kid),
        .inval(inval),
        .tq_bit(u_va_tq_bit),
        .tq_len(u_va_tq_len),
        .tq_tri(u_va_tq_tri),
        .kq_kind(u_va_kq_kind),
        .vr_val(u_va_vr_val),
        .tq_res(u_va_tq_res),
        .tq_sum(u_va_tq_sum),
        .tq_pre0(u_va_tq_pre0),
        .pq_val(u_va_pq_val),
        .busy(u_sv_busy),
        .vr_idx(u_sv_vr_idx),
        .tq_tid(u_sv_tq_tid),
        .kq_idx(u_sv_kq_idx),
        .pq_idx(u_sv_pq_idx),
        .wr_v(u_sv_wr_v),
        .wr_idx(u_sv_wr_idx),
        .wr_val(u_sv_wr_val),
        .im_rq_f(u_sv_im_rq_f),
        .im_rq_x(u_sv_im_rq_x),
        .im_addr(u_sv_im_addr)
    );
    KTreeWalk u_rt (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(rt_gnt),
        .start_v(rt_start),
        .st_bit0(st_bit0),
        .tree_bit(u_va_tree_bit),
        .word_line0(word_line0),
        .out_rdy(out_rdy),
        .cq_val(u_va_vr_val),
        .adv_busy(u_va_busy),
        .cq_idx(u_rt_cq_idx),
        .adv_v(u_rt_adv_v),
        .adv_bit(u_rt_adv_bit),
        .adv_iter(u_rt_adv_iter),
        .im_req(u_rt_im_req),
        .busy(u_rt_busy),
        .im_addr(u_rt_im_addr),
        .out_v(u_rt_out_v),
        .out_inst(u_rt_out_inst),
        .out_nw(u_rt_out_nw),
        .out_word(u_rt_out_word),
        .done(u_rt_done)
    );
endmodule
