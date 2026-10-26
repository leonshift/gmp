module CpuCdma (
    input clk,
    input rst_n,
    input ext_wq,
    input ext_w2,
    input ext_w3,
    input [2:0] ext_kind,
    input [31:0] ext_addr,
    input [31:0] ext_wdata,
    input [11:0] csr_addr,
    input dlm_rgrant,
    input [31:0] dlm_rdata,
    input dlm_wgrant,
    input cm_ready,
    input cr_valid,
    input [31:0] cr_data,
    input [23:0] cr_tag,
    input dm_ready,
    input da_valid,
    input dr_valid,
    input [31:0] dr_data,
    input hq_valid,
    input [2:0] hq_kind,
    input [31:0] hq_data,
    output logic cm_valid,
    output logic [31:0] cm_addr,
    output logic [31:0] cm_wdata,
    output logic cm_write,
    output logic [23:0] cm_tag,
    output logic dlm_rreq,
    output logic [11:0] dlm_raddr,
    output logic dlm_wreq,
    output logic [11:0] dlm_waddr,
    output logic [31:0] dlm_wdata,
    output logic ilm_we,
    output logic [13:0] ilm_waddr,
    output logic [31:0] ilm_wdata,
    output logic dm_valid,
    output logic [31:0] dm_addr,
    output logic [15:0] dm_nbytes,
    output logic dm_write,
    output logic ext_rd_ok,
    output logic ext_dat_ok,
    output logic ext_q_full,
    output logic [31:0] ext_rdata,
    output logic [31:0] csr_rdata,
    output logic busy_o,
    output logic hq_ready
);
    logic [2:0] q_kind [0:7];
    logic [31:0] q_addr [0:7];
    logic [31:0] q_data [0:7];
    logic [2:0] q_rp;
    logic [2:0] q_wp;
    logic [3:0] q_cnt;
    logic [31:0] o_addr [0:3];
    logic [31:0] o_data [0:3];
    logic o_isrd [0:3];
    logic [1:0] o_rp;
    logic [2:0] o_cnt;
    logic [31:0] r_src;
    logic [31:0] r_dst;
    logic [31:0] r_len;
    logic [31:0] r_mode;
    logic [31:0] it_cur;
    logic [31:0] it_left;
    logic it_nz;
    logic [1:0] it_idx;
    logic it_pend;
    logic [1:0] it_pidx;
    logic [31:0] it_w0;
    logic [31:0] it_w1;
    logic [31:0] it_w2;
    logic [31:0] blk_src;
    logic [31:0] blk_dst;
    logic [31:0] blk_left;
    logic blk_nz;
    logic [31:0] s_dst [0:7];
    logic [8:0] s_len [0:7];
    logic [2:0] s_alloc;
    logic [2:0] s_fill;
    logic [2:0] s_land;
    logic [3:0] cnt_out;
    logic [3:0] cnt_rdy;
    logic [8:0] recv_b;
    logic [8:0] land_b;
    logic [31:0] la_q;
    logic la_ctrl;
    logic la_dlm;
    logic la_ilm;
    logic [2:0] s_cls_0;
    logic [2:0] s_cls_1;
    logic [2:0] s_cls_2;
    logic [2:0] s_cls_3;
    logic [2:0] s_cls_4;
    logic [2:0] s_cls_5;
    logic [2:0] s_cls_6;
    logic [2:0] s_cls_7;
    logic [31:0] cbuf [0:511];
    logic [31:0] land_word_q;
    logic land_word_valid;
    logic [2:0] credit;
    logic dat_pend;
    logic rd_pend;
    logic [31:0] o_head_addr;
    logic [31:0] o_head_data;
    logic o_head_isrd;
    logic land_act;
    logic [31:0] land_addr_w;
    logic [2:0] s_land_n1;
    logic land_is_ctrl;
    logic land_is_dlm;
    logic land_is_ilm;
    logic [2:0] bd_cls;
    logic [2:0] n4_cls;
    logic [2:0] nx_cls;
    logic [8:0] land_idx;
    logic [31:0] land_word;
    logic [8:0] blk_chunk;
    logic core_dm_w;
    logic cdma_dm_w;
    logic q_full_w;
    logic cr_rd;
    logic busy_w;
    logic core_pushish;
    logic land_pushish;
    logic q_full;
    logic core_wr_push;
    logic core_rd_push;
    logic core_push;
    logic land_ctrl_push;
    logic land_local_ok;
    logic land_step;
    logic h_push;
    logic q_push;
    logic [2:0] q_kind_in;
    logic [31:0] q_addr_in;
    logic [31:0] q_data_in;
    logic q_pop;
    logic o_pop;
    logic it_issue;
    logic dm_fire_core;
    logic dm_fire_cdma;
    logic dm_issue;
    logic fill_beat;
    logic [8:0] fill_len;
    logic fill_done;
    logic [8:0] land_len;
    logic land_done;
    logic [8:0] f_idx;
    logic prefetch;
    logic [8:0] prefetch_idx;
    logic [2:0] k;
    logic [31:0] a;
    logic [31:0] d;
    logic nx_new;
    logic [2:0] nx_c;

    initial begin
        for (int _i = 0; _i < 8; _i++) q_kind[_i] = 0;
        for (int _i = 0; _i < 8; _i++) q_addr[_i] = 0;
        for (int _i = 0; _i < 8; _i++) q_data[_i] = 0;
        for (int _i = 0; _i < 4; _i++) o_addr[_i] = 0;
        for (int _i = 0; _i < 4; _i++) o_data[_i] = 0;
        for (int _i = 0; _i < 4; _i++) o_isrd[_i] = 0;
        for (int _i = 0; _i < 8; _i++) s_dst[_i] = 0;
        for (int _i = 0; _i < 8; _i++) s_len[_i] = 0;
        for (int _i = 0; _i < 512; _i++) cbuf[_i] = 0;
    end

    assign o_head_addr = o_addr[o_rp];
    assign o_head_data = o_data[o_rp];
    assign o_head_isrd = o_isrd[o_rp];
    assign cm_valid = (o_cnt != 0);
    assign cm_addr = o_head_addr;
    assign cm_wdata = o_head_data;
    assign cm_write = (~o_head_isrd);
    assign cm_tag = {23'd0, o_head_isrd};
    assign dlm_rreq = ((it_nz & (o_cnt == 0)) & (~(it_pend & (it_pidx == 3))));
    assign dlm_raddr = it_cur[13:2];
    assign land_act = ((cnt_rdy != 0) & land_word_valid);
    assign land_addr_w = la_q;
    assign s_land_n1 = (s_land + 1);
    assign land_is_ctrl = la_ctrl;
    assign land_is_dlm = la_dlm;
    assign land_is_ilm = la_ilm;
    assign bd_cls = {((blk_dst < 2048) | ((blk_dst >= 32'd33554432) & (blk_dst < 32'd50331648))),
                     ((blk_dst >= 32'd4194304) & (blk_dst < 32'd4210688)),
                     ((blk_dst >= 32'd8388608) & (blk_dst < 32'd8437760))};
    assign n4_cls = {(((la_q < 2044) | (la_q >= 32'd4294967292)) | ((la_q >= 32'd33554428) & (la_q < 32'd50331644))),
                     ((la_q >= 32'd4194300) & (la_q < 32'd4210684)), ((la_q >= 32'd8388604) & (la_q < 32'd8437756))};
    assign nx_cls = ((s_land_n1 == 0) ? s_cls_0 :
                    ((s_land_n1 == 1) ? s_cls_1 :
                    ((s_land_n1 == 2) ? s_cls_2 :
                    ((s_land_n1 == 3) ? s_cls_3 :
                    ((s_land_n1 == 4) ? s_cls_4 :
                    ((s_land_n1 == 5) ? s_cls_5 :
                    ((s_land_n1 == 6) ? s_cls_6 :
                    s_cls_7)))))));
    assign land_idx = {s_land, land_b[7:2]};
    assign land_word = land_word_q;
    assign dlm_wreq = (land_act & land_is_dlm);
    assign dlm_waddr = land_addr_w[13:2];
    assign dlm_wdata = land_word;
    assign ilm_we = (land_act & land_is_ilm);
    assign ilm_waddr = land_addr_w[15:2];
    assign ilm_wdata = land_word;
    assign blk_chunk = ((blk_left >= 256) ? 9'd256 : blk_left[8:0]);
    assign core_dm_w = (((ext_w3 & (~dat_pend)) & (cnt_out == 0)) & (credit != 0));
    assign cdma_dm_w = ((((blk_nz & (({1'd0, cnt_out} + {1'd0, cnt_rdy}) < 8)) & (~dat_pend)) & (credit != 0))
                        & (~core_dm_w));
    assign dm_valid = (core_dm_w | cdma_dm_w);
    assign dm_addr = (core_dm_w ? ext_addr : blk_src);
    assign dm_nbytes = (core_dm_w ? 4 : {7'd0, blk_chunk});
    assign dm_write = 1'd0;
    assign q_full_w = (q_cnt == 8);
    assign cr_rd = (cr_valid & cr_tag[0]);
    assign ext_rd_ok = (rd_pend & cr_rd);
    assign ext_dat_ok = (dat_pend & dr_valid);
    assign ext_q_full = q_full_w;
    assign ext_rdata = ((ext_kind == 2) ? cr_data : dr_data);
    assign busy_w = ((((((((q_cnt != 0) | (o_cnt != 0)) | it_nz) | (it_idx != 0)) | it_pend) | blk_nz) | (cnt_out != 0))
                     | (cnt_rdy != 0));
    assign csr_rdata = ((csr_addr == 3013) ? {31'd0, busy_w} : 0);
    assign busy_o = busy_w;
    assign core_pushish = ((~q_full_w) & (ext_wq | (ext_w2 & (~rd_pend))));
    assign land_pushish = (((land_act & land_is_ctrl) & (~q_full_w)) & (~core_pushish));
    assign hq_ready = (((~q_full_w) & (~core_pushish)) & (~land_pushish));
    assign q_full = (q_cnt == 8);
    assign core_wr_push = (ext_wq & (~q_full));
    assign core_rd_push = ((ext_w2 & (~rd_pend)) & (~q_full));
    assign core_push = (core_wr_push | core_rd_push);
    assign land_ctrl_push = (((land_act & land_is_ctrl) & (~q_full)) & (~core_push));
    assign land_local_ok = ((land_act & (~land_is_ctrl)) & (dlm_wgrant | (~land_is_dlm)));
    assign land_step = (land_ctrl_push | land_local_ok);
    assign h_push = (hq_valid & hq_ready);
    assign q_push = ((core_push | land_ctrl_push) | h_push);
    assign q_kind_in = (core_rd_push ? 6 :
                       ((core_wr_push & (ext_kind == 4)) ? ext_addr[2:0] :
                       ((core_wr_push | land_ctrl_push) ? 5 :
                       hq_kind)));
    assign q_addr_in = (core_push ? ext_addr : (land_ctrl_push ? land_addr_w : 0));
    assign q_data_in = (core_push ? ext_wdata : (land_ctrl_push ? land_word : hq_data));
    assign q_pop = (((o_cnt == 0) & (~it_nz)) & (q_cnt != 0));
    assign o_pop = ((o_cnt != 0) & cm_ready);
    assign it_issue = (dlm_rreq & dlm_rgrant);
    assign dm_fire_core = (core_dm_w & dm_ready);
    assign dm_fire_cdma = (cdma_dm_w & dm_ready);
    assign dm_issue = (dm_fire_core | dm_fire_cdma);
    assign fill_beat = ((dr_valid & (~dat_pend)) & (cnt_out != 0));
    assign fill_len = s_len[s_fill];
    assign fill_done = (fill_beat & (({1'd0, recv_b} + 4) >= {1'd0, fill_len}));
    assign land_len = s_len[s_land];
    assign land_done = (land_step & (({1'd0, land_b} + 4) >= {1'd0, land_len}));
    assign f_idx = {s_fill, recv_b[7:2]};
    assign prefetch = (((cnt_rdy != 0) & (~land_word_valid)) | (land_step & ((~land_done) | (cnt_rdy > 1))));
    assign prefetch_idx = (land_word_valid ? (land_done ? {s_land_n1, 6'd0} : (land_idx + 1)) : land_idx);
    assign k = q_kind[q_rp];
    assign a = q_addr[q_rp];
    assign d = q_data[q_rp];
    assign nx_new = (dm_fire_cdma & (s_alloc == s_land_n1));
    assign nx_c = (nx_new ? bd_cls : nx_cls);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            land_word_valid <= 0;
            q_wp <= 0;
            q_cnt <= 0;
            q_rp <= 0;
            r_src <= 0;
            r_dst <= 0;
            r_len <= 0;
            r_mode <= 0;
            blk_src <= 0;
            blk_dst <= 0;
            blk_left <= 0;
            blk_nz <= 0;
            it_cur <= 0;
            it_left <= 0;
            it_nz <= 0;
            o_cnt <= 0;
            o_rp <= 0;
            it_pend <= 0;
            it_pidx <= 0;
            it_idx <= 0;
            it_w0 <= 0;
            it_w1 <= 0;
            it_w2 <= 0;
            dat_pend <= 0;
            s_cls_0 <= 0;
            s_cls_1 <= 0;
            s_cls_2 <= 0;
            s_cls_3 <= 0;
            s_cls_4 <= 0;
            s_cls_5 <= 0;
            s_cls_6 <= 0;
            s_cls_7 <= 0;
            s_alloc <= 0;
            credit <= 4;
            recv_b <= 0;
            s_fill <= 0;
            land_b <= 0;
            s_land <= 0;
            la_q <= 0;
            la_ctrl <= 1;
            la_dlm <= 0;
            la_ilm <= 0;
            cnt_out <= 0;
            cnt_rdy <= 0;
            rd_pend <= 0;
        end else begin
            if (prefetch) begin
                land_word_valid <= 1;
            end else begin
                if (land_step) begin
                    land_word_valid <= 0;
                end
            end
            if (q_push) begin
                q_kind[q_wp] <= q_kind_in;
                q_addr[q_wp] <= q_addr_in;
                q_data[q_wp] <= q_data_in;
                q_wp <= (q_wp + 1);
            end
            if ((q_push & (~q_pop))) begin
                q_cnt <= (q_cnt + 1);
            end else begin
                if ((q_pop & (~q_push))) begin
                    q_cnt <= (q_cnt - 1);
                end
            end
            if (q_pop) begin
                q_rp <= (q_rp + 1);
                if ((k == 0)) begin
                    r_src <= d;
                end else begin
                    if ((k == 1)) begin
                        r_dst <= d;
                    end else begin
                        if ((k == 2)) begin
                            r_len <= d;
                        end else begin
                            if ((k == 3)) begin
                                r_mode <= d;
                            end else begin
                                if ((k == 4)) begin
                                    if ((r_mode == 1)) begin
                                        blk_src <= r_src;
                                        blk_dst <= r_dst;
                                        blk_left <= r_len;
                                        blk_nz <= (r_len != 0);
                                    end else begin
                                        it_cur <= r_src;
                                        it_left <= r_len;
                                        it_nz <= (r_len != 0);
                                    end
                                end else begin
                                    o_addr[o_rp] <= a;
                                    o_data[o_rp] <= d;
                                    o_isrd[o_rp] <= (k == 6);
                                    o_cnt <= 1;
                                end
                            end
                        end
                    end
                end
            end
            if (o_pop) begin
                o_cnt <= (o_cnt - 1);
                o_rp <= (o_rp + 1);
            end
            it_pend <= it_issue;
            if (it_issue) begin
                it_pidx <= it_idx;
                it_idx <= (it_idx + 1);
                it_cur <= (it_cur + 4);
            end
            if (it_pend) begin
                if ((it_pidx == 0)) begin
                    it_w0 <= dlm_rdata;
                end else begin
                    if ((it_pidx == 1)) begin
                        it_w1 <= dlm_rdata;
                    end else begin
                        if ((it_pidx == 2)) begin
                            it_w2 <= dlm_rdata;
                        end else begin
                            o_rp <= 0;
                            o_addr[0] <= (it_w0 + 1);
                            o_data[0] <= it_w1;
                            o_isrd[0] <= 0;
                            o_addr[1] <= (it_w0 + 2);
                            o_data[1] <= it_w2;
                            o_isrd[1] <= 0;
                            o_addr[2] <= (it_w0 + 3);
                            o_data[2] <= dlm_rdata;
                            o_isrd[2] <= 0;
                            o_addr[3] <= it_w0;
                            o_data[3] <= 1;
                            o_isrd[3] <= 0;
                            o_cnt <= 4;
                            it_left <= (it_left - 1);
                            it_nz <= (it_left != 1);
                        end
                    end
                end
            end
            if (dm_fire_core) begin
                dat_pend <= 1;
            end
            if (dm_fire_cdma) begin
                if ((s_alloc == 0)) begin
                    s_cls_0 <= bd_cls;
                end
                if ((s_alloc == 1)) begin
                    s_cls_1 <= bd_cls;
                end
                if ((s_alloc == 2)) begin
                    s_cls_2 <= bd_cls;
                end
                if ((s_alloc == 3)) begin
                    s_cls_3 <= bd_cls;
                end
                if ((s_alloc == 4)) begin
                    s_cls_4 <= bd_cls;
                end
                if ((s_alloc == 5)) begin
                    s_cls_5 <= bd_cls;
                end
                if ((s_alloc == 6)) begin
                    s_cls_6 <= bd_cls;
                end
                if ((s_alloc == 7)) begin
                    s_cls_7 <= bd_cls;
                end
                s_dst[s_alloc] <= blk_dst;
                s_len[s_alloc] <= blk_chunk;
                s_alloc <= (s_alloc + 1);
                blk_src <= (blk_src + {23'd0, blk_chunk});
                blk_dst <= (blk_dst + {23'd0, blk_chunk});
                blk_left <= (blk_left - {23'd0, blk_chunk});
                blk_nz <= (blk_left > 256);
            end
            if ((dm_issue & (~da_valid))) begin
                credit <= (credit - 1);
            end else begin
                if ((da_valid & (~dm_issue))) begin
                    credit <= (credit + 1);
                end
            end
            if (dr_valid) begin
                if (dat_pend) begin
                    dat_pend <= 0;
                end else begin
                    if ((cnt_out != 0)) begin
                        cbuf[f_idx] <= dr_data;
                        if (fill_done) begin
                            recv_b <= 0;
                            s_fill <= (s_fill + 1);
                        end else begin
                            recv_b <= (recv_b + 4);
                        end
                    end
                end
            end
            if (land_step) begin
                if (land_done) begin
                    land_b <= 0;
                    s_land <= (s_land + 1);
                    la_q <= (nx_new ? blk_dst : s_dst[s_land_n1]);
                    la_ctrl <= nx_c[2];
                    la_dlm <= nx_c[1];
                    la_ilm <= nx_c[0];
                end else begin
                    land_b <= (land_b + 4);
                    la_q <= (la_q + 4);
                    la_ctrl <= n4_cls[2];
                    la_dlm <= n4_cls[1];
                    la_ilm <= n4_cls[0];
                end
            end else begin
                if ((dm_fire_cdma & (s_alloc == s_land))) begin
                    la_q <= blk_dst;
                    la_ctrl <= bd_cls[2];
                    la_dlm <= bd_cls[1];
                    la_ilm <= bd_cls[0];
                end
            end
            if ((dm_fire_cdma & (~fill_done))) begin
                cnt_out <= (cnt_out + 1);
            end else begin
                if ((fill_done & (~dm_fire_cdma))) begin
                    cnt_out <= (cnt_out - 1);
                end
            end
            if ((fill_done & (~land_done))) begin
                cnt_rdy <= (cnt_rdy + 1);
            end else begin
                if ((land_done & (~fill_done))) begin
                    cnt_rdy <= (cnt_rdy - 1);
                end
            end
            if (core_rd_push) begin
                rd_pend <= 1;
            end
            if ((rd_pend & cr_rd)) begin
                rd_pend <= 0;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (prefetch) begin
            land_word_q <= cbuf[prefetch_idx];
        end
    end
endmodule
