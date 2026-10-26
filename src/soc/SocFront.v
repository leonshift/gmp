module SocFront (
    input clk,
    input rst_n,
    input [31:0] s_awaddr,
    input s_awvalid,
    input [31:0] s_wdata,
    input [3:0] s_wstrb,
    input s_wvalid,
    input s_bready,
    input [31:0] s_araddr,
    input s_arvalid,
    input s_rready,
    output logic hc_cm_valid,
    input hc_cm_ready,
    output logic [31:0] hc_cm_addr,
    output logic [31:0] hc_cm_wdata,
    output logic hc_cm_write,
    output logic [23:0] hc_cm_tag,
    input hc_cr_valid,
    output logic hc_cr_ready,
    input [31:0] hc_cr_data,
    input [23:0] hc_cr_tag,
    input hs_ready,
    input hr_valid,
    input [31:0] hr_data,
    output logic hp_wen,
    output logic [5:0] hp_addr,
    output logic [31:0] hp_wdata,
    output logic [5:0] hp_raddr,
    input [31:0] hp_rdata,
    output logic b_we,
    output logic b_re,
    output logic [11:0] b_addr,
    output logic [31:0] b_wdata,
    input [31:0] b_rdata,
    input [31:0] board_st,
    input [31:0] stat_trace0,
    input [31:0] stat_trace1,
    input [31:0] stat_trace2,
    input [31:0] stat_trace3,
    input stat_uart_valid,
    input [7:0] stat_uart_data,
    input [3:0] stat_cpu_state,
    input stat_dma_busy,
    input [7:0] stat_dma_ch_idle,
    input [2:0] stat_dma_seq_state,
    input [4:0] stat_dma_noc_credit,
    input stat_v1d_busy,
    input stat_v1d_idle,
    input [15:0] stat_v1d_donec,
    input [4:0] stat_v1d_occ,
    input stat_m2d_busy,
    input stat_m2d_idle,
    input [15:0] stat_m2d_donec,
    input [4:0] stat_m2d_occ,
    input [3:0] stat_ctrl_route_target,
    input [7:0] stat_ctrl_inflight,
    input [3:0] stat_ctrl_slave_ready,
    input [15:0] stat_ctrl_cfg_ack_age,
    input [15:0] stat_l1_pend_write,
    input [31:0] stat_l1_mismatch,
    input [15:0] stat_l1_torn,
    input [1:0] stat_l1_gate_block,
    input [1:0] stat_l1_admit,
    input [7:0] stat_l1_cfg_pend,
    input [7:0] stat_l1_live_slots,
    input [31:0] stat_l1_instq,
    input [31:0] stat_l1_gateq,
    input [31:0] stat_l1_gateq2,
    input [1:0] stat_l1_grant,
    input [1:0] stat_l1_stall,
    input [7:0] stat_l1_occ0,
    input [7:0] stat_l1_occ1,
    input [7:0] stat_l1_occ2,
    input [15:0] stat_noc_pend_write,
    input stat_noc_admit,
    input [3:0] stat_noc_port_stall,
    input stat_noc_idle,
    input [7:0] stat_noc_win_occ,
    input [5:0] stat_noc_infl_occ,
    input [5:0] stat_noc_rd_out,
    input [5:0] stat_noc_asm_occ,
    input [15:0] stat_noc_asm_blk,
    input [3:0] stat_noc_lane_busy,
    input [5:0] stat_noc_occ0,
    input [5:0] stat_noc_occ1,
    input [5:0] stat_noc_occ2,
    input [5:0] stat_noc_occ3,
    input [5:0] stat_noc_occ4,
    output logic s_awready,
    output logic s_wready,
    output logic s_bvalid,
    output logic [1:0] s_bresp,
    output logic s_arready,
    output logic s_rvalid,
    output logic [1:0] s_rresp,
    output logic [31:0] s_rdata,
    output logic hs_valid,
    output logic [3:0] hs_op,
    output logic [31:0] hs_addr,
    output logic [31:0] hs_wdata,
    output logic [11:0] hs_tag,
    output logic hr_ready,
    output logic stat_clr_all
);
    logic bvalid_q;
    logic [1:0] bresp_q;
    logic rvalid_q;
    logic [31:0] rdata_q;
    logic [7:0] rd_win;
    logic [21:0] rd_addr;
    logic fetch1;
    logic busy;
    logic busy_rd;
    logic busy_ctrl;
    logic cmv_q;
    logic [31:0] cm_a_q;
    logic [31:0] cm_d_q;
    logic cm_w_q;
    logic [19:0] cm_t_q;
    logic [19:0] tagc;
    logic hsv_q;
    logic hs_w_q;
    logic [31:0] hs_a_q;
    logic [31:0] hs_d_q;
    logic [7:0] uf [0:1023];
    logic [9:0] uf_wp;
    logic [9:0] uf_rp;
    logic [10:0] uf_cnt;
    logic [31:0] tick;
    logic stat_clr_q;
    logic fetch2;
    logic fetch3;
    logic [31:0] hp_rq;
    logic [31:0] b_rq;
    logic hpw_v;
    logic [5:0] hpw_a;
    logic [31:0] hpw_d;
    logic bq_we;
    logic bq_re;
    logic [11:0] bq_a;
    logic [31:0] bq_d;
    logic [31:0] st_tr0;
    logic [31:0] st_tr1;
    logic [31:0] st_tr2;
    logic [31:0] st_tr3;
    logic [3:0] st_cpu;
    logic [31:0] st_board;
    logic [15:0] st_l1_pend;
    logic [31:0] st_l1_mis;
    logic [1:0] st_l1_admit;
    logic [7:0] st_l1_cfg;
    logic [7:0] st_l1_live;
    logic [1:0] st_l1_grant;
    logic [1:0] st_l1_stall;
    logic [31:0] st_l1_occ;
    logic [31:0] st_l1_instq;
    logic [31:0] st_l1_gateq;
    logic [31:0] st_l1_gateq2;
    logic [15:0] st_noc_pend;
    logic st_noc_idle;
    logic [7:0] st_noc_win;
    logic [31:0] st_noc_occ;
    logic st_dma_busy;
    logic [7:0] st_dma_idle;
    logic [2:0] st_dma_seq;
    logic [4:0] st_dma_cr;
    logic st_v1d_busy;
    logic st_v1d_idle;
    logic [15:0] st_v1d_donec;
    logic [4:0] st_v1d_occ;
    logic st_m2d_busy;
    logic st_m2d_idle;
    logic [15:0] st_m2d_donec;
    logic [4:0] st_m2d_occ;
    logic [31:0] st_ctrl;
    logic [7:0] win_w;
    logic [7:0] win_r;
    logic wr_acc;
    logic fetching;
    logic ar_acc;
    logic w_is_ctrl;
    logic w_is_isram;
    logic w_is_cpu;
    logic w_is_nochp;
    logic w_is_stat;
    logic w_is_noccmd;
    logic w_is_nocbuf;
    logic r_is_nocbuf;
    logic r_is_ctrl;
    logic r_is_isram;
    logic r_is_cpu;
    logic rd_is_nocbuf;
    logic rd_is_noccmd;
    logic rd_is_stat;
    logic [5:0] rd_off;
    logic [31:0] ctrl_a_w;
    logic [31:0] ctrl_a_r;
    logic [31:0] l1_occ_all;
    logic [31:0] noc_occ_all;
    logic [31:0] ctrl_all;
    logic [31:0] uart_pop_w;
    logic u_push;
    logic u_pop;
    logic [5:0] off;

    assign win_w = s_awaddr[31:24];
    assign win_r = s_araddr[31:24];
    assign wr_acc = (((s_awvalid & s_wvalid) & (~bvalid_q)) & (~busy));
    assign fetching = ((fetch1 | fetch2) | fetch3);
    assign ar_acc = ((((s_arvalid & (~rvalid_q)) & (~fetching)) & (~busy)) & (~wr_acc));
    assign w_is_ctrl = (win_w == 0);
    assign w_is_isram = (win_w == 1);
    assign w_is_cpu = (win_w == 2);
    assign w_is_nochp = ((win_w == 3) | (win_w == 4));
    assign w_is_stat = (win_w == 32);
    assign w_is_noccmd = (win_w == 3);
    assign w_is_nocbuf = (win_w == 4);
    assign r_is_nocbuf = (win_r == 4);
    assign r_is_ctrl = (win_r == 0);
    assign r_is_isram = (win_r == 1);
    assign r_is_cpu = (win_r == 2);
    assign rd_is_nocbuf = (rd_win == 4);
    assign rd_is_noccmd = (rd_win == 3);
    assign rd_is_stat = (rd_win == 32);
    assign rd_off = rd_addr[5:0];
    assign ctrl_a_w = (w_is_isram ? {8'd2, s_awaddr[23:0]} : {10'd0, s_awaddr[23:2]});
    assign ctrl_a_r = (r_is_isram ? {8'd2, s_araddr[23:0]} : {10'd0, s_araddr[23:2]});
    assign l1_occ_all = {8'd0, stat_l1_occ2, stat_l1_occ1, stat_l1_occ0};
    assign noc_occ_all = {2'd0, stat_noc_occ4, stat_noc_occ3, stat_noc_occ2, stat_noc_occ1, stat_noc_occ0};
    assign ctrl_all = {stat_ctrl_route_target, stat_ctrl_inflight, stat_ctrl_slave_ready, stat_ctrl_cfg_ack_age};
    assign uart_pop_w = {23'd0, (uf_cnt != 0), uf[uf_rp]};
    assign s_awready = wr_acc;
    assign s_wready = wr_acc;
    assign s_bvalid = bvalid_q;
    assign s_bresp = bresp_q;
    assign s_arready = ((((~rvalid_q) & (~fetching)) & (~busy)) & (~wr_acc));
    assign s_rvalid = rvalid_q;
    assign s_rresp = 0;
    assign s_rdata = rdata_q;
    assign hc_cm_valid = cmv_q;
    assign hc_cm_addr = cm_a_q;
    assign hc_cm_wdata = cm_d_q;
    assign hc_cm_write = cm_w_q;
    assign hc_cm_tag = {4'd0, cm_t_q};
    assign hc_cr_ready = 1'd1;
    assign hs_valid = hsv_q;
    assign hs_op = {3'd0, hs_w_q};
    assign hs_addr = hs_a_q;
    assign hs_wdata = hs_d_q;
    assign hs_tag = 0;
    assign hr_ready = 1'd1;
    assign hp_wen = hpw_v;
    assign hp_addr = hpw_a;
    assign hp_wdata = hpw_d;
    assign hp_raddr = rd_off;
    assign b_we = bq_we;
    assign b_re = bq_re;
    assign b_addr = bq_a;
    assign b_wdata = bq_d;
    assign stat_clr_all = stat_clr_q;
    assign u_push = stat_uart_valid;
    assign u_pop = (((fetch1 & rd_is_stat) & (rd_off == 2)) & (uf_cnt != 0));
    assign off = rd_off;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            tick <= 0;
            stat_clr_q <= 0;
            hpw_v <= 0;
            bq_we <= 0;
            bq_re <= 0;
            uf_wp <= 0;
            bresp_q <= 0;
            cmv_q <= 0;
            cm_w_q <= 0;
            tagc <= 0;
            busy <= 0;
            busy_rd <= 0;
            busy_ctrl <= 0;
            hsv_q <= 0;
            hs_w_q <= 0;
            bvalid_q <= 0;
            rdata_q <= 0;
            rvalid_q <= 0;
            fetch2 <= 0;
            fetch3 <= 0;
            rd_win <= 0;
            rd_addr <= 0;
            fetch1 <= 0;
            uf_rp <= 0;
            uf_cnt <= 0;
        end else begin
            tick <= (tick + 1);
            stat_clr_q <= 0;
            hpw_v <= (wr_acc & w_is_noccmd);
            bq_we <= (wr_acc & w_is_nocbuf);
            bq_re <= (ar_acc & r_is_nocbuf);
            if (u_push) begin
                uf_wp <= (uf_wp + 1);
            end
            if (wr_acc) begin
                bresp_q <= 0;
                if ((w_is_ctrl | w_is_isram)) begin
                    cmv_q <= 1;
                    cm_w_q <= 1;
                    tagc <= (tagc + 1);
                    busy <= 1;
                    busy_rd <= 0;
                    busy_ctrl <= 1;
                end else begin
                    if (w_is_cpu) begin
                        hsv_q <= 1;
                        hs_w_q <= 1;
                        busy <= 1;
                        busy_rd <= 0;
                        busy_ctrl <= 0;
                    end else begin
                        if (w_is_nochp) begin
                            bvalid_q <= 1;
                        end else begin
                            if (w_is_stat) begin
                                if (((s_awaddr[7:2] == 41) & s_wdata[0])) begin
                                    stat_clr_q <= 1;
                                end
                                bvalid_q <= 1;
                            end else begin
                                bresp_q <= 2;
                                bvalid_q <= 1;
                            end
                        end
                    end
                end
            end else begin
                if ((bvalid_q & s_bready)) begin
                    bvalid_q <= 0;
                end
            end
            if ((cmv_q & hc_cm_ready)) begin
                cmv_q <= 0;
                if (cm_w_q) begin
                    busy <= 0;
                    bvalid_q <= 1;
                end
            end
            if ((((busy & busy_ctrl) & busy_rd) & hc_cr_valid)) begin
                busy <= 0;
                rdata_q <= hc_cr_data;
                rvalid_q <= 1;
            end
            if ((hsv_q & hs_ready)) begin
                hsv_q <= 0;
            end
            if (((busy & (~busy_ctrl)) & hr_valid)) begin
                busy <= 0;
                if (busy_rd) begin
                    rdata_q <= hr_data;
                    rvalid_q <= 1;
                end else begin
                    bvalid_q <= 1;
                end
            end
            fetch2 <= (fetch1 & (rd_is_noccmd | rd_is_nocbuf));
            fetch3 <= (fetch2 & rd_is_nocbuf);
            if (ar_acc) begin
                rd_win <= win_r;
                rd_addr <= s_araddr[23:2];
                if ((r_is_ctrl | r_is_isram)) begin
                    cmv_q <= 1;
                    cm_w_q <= 0;
                    tagc <= (tagc + 1);
                    busy <= 1;
                    busy_rd <= 1;
                    busy_ctrl <= 1;
                end else begin
                    if (r_is_cpu) begin
                        hsv_q <= 1;
                        hs_w_q <= 0;
                        busy <= 1;
                        busy_rd <= 1;
                        busy_ctrl <= 0;
                    end else begin
                        fetch1 <= 1;
                    end
                end
            end else begin
                if (fetch1) begin
                    fetch1 <= 0;
                    if (rd_is_stat) begin
                        if ((off == 0)) begin
                            rdata_q <= 1397703473;
                        end else begin
                            if ((off == 1)) begin
                                rdata_q <= tick;
                            end else begin
                                if ((off == 2)) begin
                                    rdata_q <= uart_pop_w;
                                    if ((uf_cnt != 0)) begin
                                        uf_rp <= (uf_rp + 1);
                                    end
                                end else begin
                                    if ((off == 3)) begin
                                        rdata_q <= {21'd0, uf_cnt};
                                    end else begin
                                        if ((off == 4)) begin
                                            rdata_q <= st_tr0;
                                        end else begin
                                            if ((off == 5)) begin
                                                rdata_q <= st_tr1;
                                            end else begin
                                                if ((off == 6)) begin
                                                    rdata_q <= st_tr2;
                                                end else begin
                                                    if ((off == 7)) begin
                                                        rdata_q <= st_tr3;
                                                    end else begin
                                                        if ((off == 8)) begin
                                                            rdata_q <= {28'd0, st_cpu};
                                                        end else begin
                                                            if ((off == 9)) begin
                                                                rdata_q <= st_board;
                                                            end else begin
                                                                if ((off == 16)) begin
                                                                    rdata_q <= {16'd0, st_l1_pend};
                                                                end else begin
                                                                    if ((off == 17)) begin
                                                                        rdata_q <= st_l1_mis;
                                                                    end else begin
                                                                        if ((off == 18)) begin
                                                                            rdata_q <= {30'd0, st_l1_admit};
                                                                        end else begin
                                                                            if ((off == 19)) begin
                                                                                rdata_q <= {24'd0, st_l1_cfg};
                                                                            end else begin
                                                                                if ((off == 20)) begin
                                                                                    rdata_q <= {24'd0, st_l1_live};
                                                                                end else begin
                                                                                    if ((off == 21)) begin
                                                                                        rdata_q <= {30'd0, st_l1_grant};
                                                                                    end else begin
                                                                                        if ((off == 22)) begin
                                                                                            rdata_q <=
                                                                                                    {30'd0, st_l1_stall};
                                                                                        end else begin
                                                                                            if ((off == 23)) begin
                                                                                                rdata_q <= st_l1_occ;
                                                                                            end else begin
                                                                                                if ((off == 24)) begin
                                                                                                    rdata_q <=
                                                                                                            {16'd0,
                                                                                                             st_noc_pend};
                                                                                                end else begin
                                                                                                    if ((off == 25)) begin
                                                                                                        rdata_q <=
                                                                                                                {31'd0,
                                                                                                                 st_noc_idle};
                                                                                                    end else begin
                                                                                                        if ((off == 26)) begin
                                                                                                            rdata_q <=
                                                                                                                    {24'd0,
                                                                                                                     st_noc_win};
                                                                                                        end else begin
                                                                                                            if ((off
                                                                                                                 == 27)) begin
                                                                                                                rdata_q <=
                                                                                                                        st_noc_occ;
                                                                                                            end else begin
                                                                                                                if ((off
                                                                                                                     == 28)) begin
                                                                                                                    rdata_q <=
                                                                                                                            {31'd0,
                                                                                                                             st_dma_busy};
                                                                                                                end else begin
                                                                                                                    if ((off
                                                                                                                         == 29)) begin
                                                                                                                        rdata_q <=
                                                                                                                                {24'd0,
                                                                                                                                 st_dma_idle};
                                                                                                                    end else begin
                                                                                                                        if ((off
                                                                                                                             == 30)) begin
                                                                                                                            rdata_q <=
                                                                                                                                    {29'd0,
                                                                                                                                     st_dma_seq};
                                                                                                                        end else begin
                                                                                                                            if ((off
                                                                                                                                 == 31)) begin
                                                                                                                                rdata_q <=
                                                                                                                                        {27'd0,
                                                                                                                                         st_dma_cr};
                                                                                                                            end else begin
                                                                                                                                if ((off
                                                                                                                                     == 32)) begin
                                                                                                                                    rdata_q <=
                                                                                                                                            {31'd0,
                                                                                                                                             st_v1d_busy};
                                                                                                                                end else begin
                                                                                                                                    if ((off
                                                                                                                                         == 33)) begin
                                                                                                                                        rdata_q <=
                                                                                                                                                {31'd0,
                                                                                                                                                 st_v1d_idle};
                                                                                                                                    end else begin
                                                                                                                                        if ((off
                                                                                                                                             == 34)) begin
                                                                                                                                            rdata_q <=
                                                                                                                                                    {16'd0,
                                                                                                                                                     st_v1d_donec};
                                                                                                                                        end else begin
                                                                                                                                            if ((off
                                                                                                                                                 == 35)) begin
                                                                                                                                                rdata_q <=
                                                                                                                                                        {27'd0,
                                                                                                                                                         st_v1d_occ};
                                                                                                                                            end else begin
                                                                                                                                                if ((off
                                                                                                                                                     == 36)) begin
                                                                                                                                                    rdata_q <=
                                                                                                                                                            {31'd0,
                                                                                                                                                             st_m2d_busy};
                                                                                                                                                end else begin
                                                                                                                                                    if ((off
                                                                                                                                                         == 37)) begin
                                                                                                                                                        rdata_q <=
                                                                                                                                                                {31'd0,
                                                                                                                                                                 st_m2d_idle};
                                                                                                                                                    end else begin
                                                                                                                                                        if ((off
                                                                                                                                                             == 38)) begin
                                                                                                                                                            rdata_q <=
                                                                                                                                                                    {16'd0,
                                                                                                                                                                     st_m2d_donec};
                                                                                                                                                        end else begin
                                                                                                                                                            if ((off
                                                                                                                                                                 == 39)) begin
                                                                                                                                                                rdata_q <=
                                                                                                                                                                        {27'd0,
                                                                                                                                                                         st_m2d_occ};
                                                                                                                                                            end else begin
                                                                                                                                                                if ((off
                                                                                                                                                                     == 40)) begin
                                                                                                                                                                    rdata_q <=
                                                                                                                                                                            st_ctrl;
                                                                                                                                                                end else begin
                                                                                                                                                                    if ((off
                                                                                                                                                                         == 42)) begin
                                                                                                                                                                        rdata_q <=
                                                                                                                                                                                st_l1_instq;
                                                                                                                                                                    end else begin
                                                                                                                                                                        if ((off
                                                                                                                                                                             == 43)) begin
                                                                                                                                                                            rdata_q <=
                                                                                                                                                                                    st_l1_gateq;
                                                                                                                                                                        end else begin
                                                                                                                                                                            if ((off
                                                                                                                                                                                 == 44)) begin
                                                                                                                                                                                rdata_q <=
                                                                                                                                                                                        st_l1_gateq2;
                                                                                                                                                                            end else begin
                                                                                                                                                                                rdata_q <=
                                                                                                                                                                                        0;
                                                                                                                                                                            end
                                                                                                                                                                        end
                                                                                                                                                                    end
                                                                                                                                                                end
                                                                                                                                                            end
                                                                                                                                                        end
                                                                                                                                                    end
                                                                                                                                                end
                                                                                                                                            end
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        rvalid_q <= 1;
                    end else begin
                        if ((~(rd_is_noccmd | rd_is_nocbuf))) begin
                            rvalid_q <= 1;
                        end
                    end
                end else begin
                    if ((fetch2 & rd_is_noccmd)) begin
                        rdata_q <= hp_rq;
                        rvalid_q <= 1;
                    end else begin
                        if (fetch3) begin
                            rdata_q <= b_rq;
                            rvalid_q <= 1;
                        end else begin
                            if ((rvalid_q & s_rready)) begin
                                rvalid_q <= 0;
                            end
                        end
                    end
                end
            end
            if ((u_push & (~u_pop))) begin
                uf_cnt <= (uf_cnt + 1);
            end else begin
                if ((u_pop & (~u_push))) begin
                    uf_cnt <= (uf_cnt - 1);
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        st_tr0 <= stat_trace0;
        st_tr1 <= stat_trace1;
        st_tr2 <= stat_trace2;
        st_tr3 <= stat_trace3;
        st_cpu <= stat_cpu_state;
        st_board <= board_st;
        st_l1_pend <= stat_l1_pend_write;
        st_l1_mis <= stat_l1_mismatch;
        st_l1_admit <= stat_l1_admit;
        st_l1_cfg <= stat_l1_cfg_pend;
        st_l1_live <= stat_l1_live_slots;
        st_l1_grant <= stat_l1_grant;
        st_l1_stall <= stat_l1_stall;
        st_l1_occ <= l1_occ_all;
        st_l1_instq <= stat_l1_instq;
        st_l1_gateq <= stat_l1_gateq;
        st_l1_gateq2 <= stat_l1_gateq2;
        st_noc_pend <= stat_noc_pend_write;
        st_noc_idle <= stat_noc_idle;
        st_noc_win <= stat_noc_win_occ;
        st_noc_occ <= noc_occ_all;
        st_dma_busy <= stat_dma_busy;
        st_dma_idle <= stat_dma_ch_idle;
        st_dma_seq <= stat_dma_seq_state;
        st_dma_cr <= stat_dma_noc_credit;
        st_v1d_busy <= stat_v1d_busy;
        st_v1d_idle <= stat_v1d_idle;
        st_v1d_donec <= stat_v1d_donec;
        st_v1d_occ <= stat_v1d_occ;
        st_m2d_busy <= stat_m2d_busy;
        st_m2d_idle <= stat_m2d_idle;
        st_m2d_donec <= stat_m2d_donec;
        st_m2d_occ <= stat_m2d_occ;
        st_ctrl <= ctrl_all;
        hpw_a <= s_awaddr[7:2];
        hpw_d <= s_wdata;
        bq_a <= (wr_acc ? s_awaddr[13:2] : s_araddr[13:2]);
        bq_d <= s_wdata;
        hp_rq <= hp_rdata;
        b_rq <= b_rdata;
        if (u_push) begin
            uf[uf_wp] <= stat_uart_data;
        end
        if (wr_acc) begin
            if ((w_is_ctrl | w_is_isram)) begin
                cm_a_q <= ctrl_a_w;
                cm_d_q <= s_wdata;
                cm_t_q <= tagc;
            end else begin
                if (w_is_cpu) begin
                    hs_a_q <= {8'd0, s_awaddr[23:0]};
                    hs_d_q <= s_wdata;
                end
            end
        end
        if (ar_acc) begin
            if ((r_is_ctrl | r_is_isram)) begin
                cm_a_q <= ctrl_a_r;
                cm_d_q <= 0;
                cm_t_q <= tagc;
            end else begin
                if (r_is_cpu) begin
                    hs_a_q <= {8'd0, s_araddr[23:0]};
                end
            end
        end
    end
endmodule
