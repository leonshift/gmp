module CpuCsr (
    input clk,
    input rst_n,
    input [11:0] p_addr,
    input [4:0] p_gi_a,
    input [4:0] p_gi_b,
    input c_en,
    input c_wen,
    input [11:0] c_addr,
    input [31:0] c_wdata,
    input [31:0] c_wo,
    input h_wen,
    input [11:0] h_addr,
    input h_gp,
    input [4:0] h_gi,
    input [31:0] h_wdata,
    input core_halt,
    input core_quiet,
    input retire,
    output logic dbg_stop,
    output logic dbg_step,
    output logic dbg_stopped,
    output logic [31:0] c_rdata,
    output logic [31:0] h_rdata,
    output logic uart_tx_valid,
    output logic [7:0] uart_tx_data,
    output logic [31:0] trace0,
    output logic [31:0] trace1,
    output logic [31:0] trace2,
    output logic [31:0] trace3,
    output logic go
);
    logic go_q;
    logic [31:0] tr0_q;
    logic [31:0] tr1_q;
    logic [31:0] tr2_q;
    logic [31:0] tr3_q;
    logic [31:0] scratch_q;
    logic [31:0] cyc_q;
    logic [31:0] gp_0;
    logic [31:0] gp_1;
    logic [31:0] gp_2;
    logic [31:0] gp_3;
    logic [31:0] gp_4;
    logic [31:0] gp_5;
    logic [31:0] gp_6;
    logic [31:0] gp_7;
    logic [31:0] gp_8;
    logic [31:0] gp_9;
    logic [31:0] gp_10;
    logic [31:0] gp_11;
    logic [31:0] gp_12;
    logic [31:0] gp_13;
    logic [31:0] gp_14;
    logic [31:0] gp_15;
    logic [31:0] gp_16;
    logic [31:0] gp_17;
    logic [31:0] gp_18;
    logic [31:0] gp_19;
    logic [31:0] gp_20;
    logic [31:0] gp_21;
    logic [31:0] gp_22;
    logic [31:0] gp_23;
    logic [31:0] gp_24;
    logic [31:0] gp_25;
    logic [31:0] gp_26;
    logic [31:0] gp_27;
    logic [31:0] gp_28;
    logic [31:0] gp_29;
    logic [31:0] gp_30;
    logic [31:0] gp_31;
    logic cw_v;
    logic cw_gp;
    logic [4:0] cw_idx;
    logic [31:0] cw_data;
    logic [31:0] rq;
    logic rq_wide;
    logic rq_byp;
    logic rq_st;
    logic rq_us;
    logic rq_ds;
    logic dbg_stop_q;
    logic stepping;
    logic step_seen;
    logic step_done_q;
    logic stopped_w;
    logic [31:0] dbgstat_w;
    logic c_dctl;
    logic h_dctl;
    logic [31:0] dctl_d;
    logic [5:0] c_gidx;
    logic c_in_gp;
    logic [31:0] status_w;
    logic c_is_sc;
    logic p_in_gp;
    logic p_is_sc;
    logic p_is_cyc;
    logic c_rw_w;
    logic p_fwd;
    logic p_gp_cw;
    logic p_gp_h;
    logic [15:0] gp_lo_0;
    logic [15:0] gp_lo_1;
    logic [15:0] gp_lo_2;
    logic [15:0] gp_lo_3;
    logic [15:0] gp_lo_4;
    logic [15:0] gp_lo_5;
    logic [15:0] gp_lo_6;
    logic [15:0] gp_lo_7;
    logic [15:0] gp_lo_8;
    logic [15:0] gp_lo_9;
    logic [15:0] gp_lo_10;
    logic [15:0] gp_lo_11;
    logic [15:0] gp_lo_12;
    logic [15:0] gp_lo_13;
    logic [15:0] gp_lo_14;
    logic [15:0] gp_lo_15;
    logic [15:0] gp_lo_16;
    logic [15:0] gp_lo_17;
    logic [15:0] gp_lo_18;
    logic [15:0] gp_lo_19;
    logic [15:0] gp_lo_20;
    logic [15:0] gp_lo_21;
    logic [15:0] gp_lo_22;
    logic [15:0] gp_lo_23;
    logic [15:0] gp_lo_24;
    logic [15:0] gp_lo_25;
    logic [15:0] gp_lo_26;
    logic [15:0] gp_lo_27;
    logic [15:0] gp_lo_28;
    logic [15:0] gp_lo_29;
    logic [15:0] gp_lo_30;
    logic [15:0] gp_lo_31;
    logic [15:0] gp_hi_0;
    logic [15:0] gp_hi_1;
    logic [15:0] gp_hi_2;
    logic [15:0] gp_hi_3;
    logic [15:0] gp_hi_4;
    logic [15:0] gp_hi_5;
    logic [15:0] gp_hi_6;
    logic [15:0] gp_hi_7;
    logic [15:0] gp_hi_8;
    logic [15:0] gp_hi_9;
    logic [15:0] gp_hi_10;
    logic [15:0] gp_hi_11;
    logic [15:0] gp_hi_12;
    logic [15:0] gp_hi_13;
    logic [15:0] gp_hi_14;
    logic [15:0] gp_hi_15;
    logic [15:0] gp_hi_16;
    logic [15:0] gp_hi_17;
    logic [15:0] gp_hi_18;
    logic [15:0] gp_hi_19;
    logic [15:0] gp_hi_20;
    logic [15:0] gp_hi_21;
    logic [15:0] gp_hi_22;
    logic [15:0] gp_hi_23;
    logic [15:0] gp_hi_24;
    logic [15:0] gp_hi_25;
    logic [15:0] gp_hi_26;
    logic [15:0] gp_hi_27;
    logic [15:0] gp_hi_28;
    logic [15:0] gp_hi_29;
    logic [15:0] gp_hi_30;
    logic [15:0] gp_hi_31;
    logic [31:0] p_gp_cur;
    logic [31:0] p_gp_v;
    logic [31:0] p_sc_v;
    logic [31:0] p_val;
    logic c_wr;
    logic uw_c;
    logic uw_h;
    logic [7:0] c_wo8;
    logic c_gp_w;

    assign stopped_w = (dbg_stop_q & core_quiet);
    assign dbgstat_w = {30'd0, {step_done_q, stopped_w}};
    assign c_dctl = ((c_en & c_wen) & (c_addr == 2032));
    assign h_dctl = (h_wen & (h_addr == 2032));
    assign dctl_d = (c_dctl ? c_wo : h_wdata);
    assign dbg_stop = dbg_stop_q;
    assign dbg_step = (((c_dctl | h_dctl) & dctl_d[2]) & stopped_w);
    assign dbg_stopped = stopped_w;
    assign c_gidx = (c_addr[5:0] - 16);
    assign c_in_gp = ((c_addr >= 2000) & (c_addr <= 2031));
    assign status_w = {30'd0, {core_halt, (go_q & (~core_halt))}};
    assign c_is_sc = (c_addr == 2035);
    assign c_rdata = (rq_byp ? cw_data : (rq_wide ? rq : (rq_st ? status_w : (rq_us ? 1 : (rq_ds ? dbgstat_w : 0)))));
    assign p_in_gp = ((p_addr >= 2000) & (p_addr <= 2031));
    assign p_is_sc = (p_addr == 2035);
    assign p_is_cyc = (p_addr == 1998);
    assign c_rw_w = ((c_en & c_wen) & (c_in_gp | c_is_sc));
    assign p_fwd = (c_rw_w & (c_in_gp ? (p_in_gp & (p_gi_a == c_gidx[4:0])) : p_is_sc));
    assign p_gp_cw = ((cw_v & cw_gp) & (cw_idx == p_gi_a));
    assign p_gp_h = (((h_wen & h_gp) & (~(cw_v & cw_gp))) & (h_gi == p_gi_a));
    assign gp_lo_0 = gp_0[15:0];
    assign gp_lo_1 = gp_1[15:0];
    assign gp_lo_2 = gp_2[15:0];
    assign gp_lo_3 = gp_3[15:0];
    assign gp_lo_4 = gp_4[15:0];
    assign gp_lo_5 = gp_5[15:0];
    assign gp_lo_6 = gp_6[15:0];
    assign gp_lo_7 = gp_7[15:0];
    assign gp_lo_8 = gp_8[15:0];
    assign gp_lo_9 = gp_9[15:0];
    assign gp_lo_10 = gp_10[15:0];
    assign gp_lo_11 = gp_11[15:0];
    assign gp_lo_12 = gp_12[15:0];
    assign gp_lo_13 = gp_13[15:0];
    assign gp_lo_14 = gp_14[15:0];
    assign gp_lo_15 = gp_15[15:0];
    assign gp_lo_16 = gp_16[15:0];
    assign gp_lo_17 = gp_17[15:0];
    assign gp_lo_18 = gp_18[15:0];
    assign gp_lo_19 = gp_19[15:0];
    assign gp_lo_20 = gp_20[15:0];
    assign gp_lo_21 = gp_21[15:0];
    assign gp_lo_22 = gp_22[15:0];
    assign gp_lo_23 = gp_23[15:0];
    assign gp_lo_24 = gp_24[15:0];
    assign gp_lo_25 = gp_25[15:0];
    assign gp_lo_26 = gp_26[15:0];
    assign gp_lo_27 = gp_27[15:0];
    assign gp_lo_28 = gp_28[15:0];
    assign gp_lo_29 = gp_29[15:0];
    assign gp_lo_30 = gp_30[15:0];
    assign gp_lo_31 = gp_31[15:0];
    assign gp_hi_0 = gp_0[31:16];
    assign gp_hi_1 = gp_1[31:16];
    assign gp_hi_2 = gp_2[31:16];
    assign gp_hi_3 = gp_3[31:16];
    assign gp_hi_4 = gp_4[31:16];
    assign gp_hi_5 = gp_5[31:16];
    assign gp_hi_6 = gp_6[31:16];
    assign gp_hi_7 = gp_7[31:16];
    assign gp_hi_8 = gp_8[31:16];
    assign gp_hi_9 = gp_9[31:16];
    assign gp_hi_10 = gp_10[31:16];
    assign gp_hi_11 = gp_11[31:16];
    assign gp_hi_12 = gp_12[31:16];
    assign gp_hi_13 = gp_13[31:16];
    assign gp_hi_14 = gp_14[31:16];
    assign gp_hi_15 = gp_15[31:16];
    assign gp_hi_16 = gp_16[31:16];
    assign gp_hi_17 = gp_17[31:16];
    assign gp_hi_18 = gp_18[31:16];
    assign gp_hi_19 = gp_19[31:16];
    assign gp_hi_20 = gp_20[31:16];
    assign gp_hi_21 = gp_21[31:16];
    assign gp_hi_22 = gp_22[31:16];
    assign gp_hi_23 = gp_23[31:16];
    assign gp_hi_24 = gp_24[31:16];
    assign gp_hi_25 = gp_25[31:16];
    assign gp_hi_26 = gp_26[31:16];
    assign gp_hi_27 = gp_27[31:16];
    assign gp_hi_28 = gp_28[31:16];
    assign gp_hi_29 = gp_29[31:16];
    assign gp_hi_30 = gp_30[31:16];
    assign gp_hi_31 = gp_31[31:16];
    assign p_gp_cur = {((p_gi_b == 0) ? gp_hi_0 :
                       ((p_gi_b == 1) ? gp_hi_1 :
                       ((p_gi_b == 2) ? gp_hi_2 :
                       ((p_gi_b == 3) ? gp_hi_3 :
                       ((p_gi_b == 4) ? gp_hi_4 :
                       ((p_gi_b == 5) ? gp_hi_5 :
                       ((p_gi_b == 6) ? gp_hi_6 :
                       ((p_gi_b == 7) ? gp_hi_7 :
                       ((p_gi_b == 8) ? gp_hi_8 :
                       ((p_gi_b == 9) ? gp_hi_9 :
                       ((p_gi_b == 10) ? gp_hi_10 :
                       ((p_gi_b == 11) ? gp_hi_11 :
                       ((p_gi_b == 12) ? gp_hi_12 :
                       ((p_gi_b == 13) ? gp_hi_13 :
                       ((p_gi_b == 14) ? gp_hi_14 :
                       ((p_gi_b == 15) ? gp_hi_15 :
                       ((p_gi_b == 16) ? gp_hi_16 :
                       ((p_gi_b == 17) ? gp_hi_17 :
                       ((p_gi_b == 18) ? gp_hi_18 :
                       ((p_gi_b == 19) ? gp_hi_19 :
                       ((p_gi_b == 20) ? gp_hi_20 :
                       ((p_gi_b == 21) ? gp_hi_21 :
                       ((p_gi_b == 22) ? gp_hi_22 :
                       ((p_gi_b == 23) ? gp_hi_23 :
                       ((p_gi_b == 24) ? gp_hi_24 :
                       ((p_gi_b == 25) ? gp_hi_25 :
                       ((p_gi_b == 26) ? gp_hi_26 :
                       ((p_gi_b == 27) ? gp_hi_27 :
                       ((p_gi_b == 28) ? gp_hi_28 :
                       ((p_gi_b == 29) ? gp_hi_29 :
                       ((p_gi_b == 30) ? gp_hi_30 :
                       gp_hi_31))))))))))))))))))))))))))))))),
                       ((p_gi_a == 0) ? gp_lo_0 :
                       ((p_gi_a == 1) ? gp_lo_1 :
                       ((p_gi_a == 2) ? gp_lo_2 :
                       ((p_gi_a == 3) ? gp_lo_3 :
                       ((p_gi_a == 4) ? gp_lo_4 :
                       ((p_gi_a == 5) ? gp_lo_5 :
                       ((p_gi_a == 6) ? gp_lo_6 :
                       ((p_gi_a == 7) ? gp_lo_7 :
                       ((p_gi_a == 8) ? gp_lo_8 :
                       ((p_gi_a == 9) ? gp_lo_9 :
                       ((p_gi_a == 10) ? gp_lo_10 :
                       ((p_gi_a == 11) ? gp_lo_11 :
                       ((p_gi_a == 12) ? gp_lo_12 :
                       ((p_gi_a == 13) ? gp_lo_13 :
                       ((p_gi_a == 14) ? gp_lo_14 :
                       ((p_gi_a == 15) ? gp_lo_15 :
                       ((p_gi_a == 16) ? gp_lo_16 :
                       ((p_gi_a == 17) ? gp_lo_17 :
                       ((p_gi_a == 18) ? gp_lo_18 :
                       ((p_gi_a == 19) ? gp_lo_19 :
                       ((p_gi_a == 20) ? gp_lo_20 :
                       ((p_gi_a == 21) ? gp_lo_21 :
                       ((p_gi_a == 22) ? gp_lo_22 :
                       ((p_gi_a == 23) ? gp_lo_23 :
                       ((p_gi_a == 24) ? gp_lo_24 :
                       ((p_gi_a == 25) ? gp_lo_25 :
                       ((p_gi_a == 26) ? gp_lo_26 :
                       ((p_gi_a == 27) ? gp_lo_27 :
                       ((p_gi_a == 28) ? gp_lo_28 :
                       ((p_gi_a == 29) ? gp_lo_29 :
                       ((p_gi_a == 30) ? gp_lo_30 :
                       gp_lo_31)))))))))))))))))))))))))))))))};
    assign p_gp_v = (p_gp_cw ? cw_data : (p_gp_h ? h_wdata : p_gp_cur));
    assign p_sc_v = ((cw_v & (~cw_gp)) ? cw_data : ((h_wen & (h_addr == 2035)) ? h_wdata : scratch_q));
    assign p_val = (p_in_gp ? p_gp_v : (p_is_sc ? p_sc_v : (cyc_q + 1)));
    assign h_rdata = ((h_addr == 1990) ? status_w :
                     ((h_addr == 1997) ? 1 :
                     ((h_addr == 1998) ? cyc_q :
                     ((h_addr == 2035) ? scratch_q :
                     ((h_addr == 2033) ? dbgstat_w :
                     (h_gp
                      ? ((h_gi == 0) ? gp_0 :
                        ((h_gi == 1) ? gp_1 :
                        ((h_gi == 2) ? gp_2 :
                        ((h_gi == 3) ? gp_3 :
                        ((h_gi == 4) ? gp_4 :
                        ((h_gi == 5) ? gp_5 :
                        ((h_gi == 6) ? gp_6 :
                        ((h_gi == 7) ? gp_7 :
                        ((h_gi == 8) ? gp_8 :
                        ((h_gi == 9) ? gp_9 :
                        ((h_gi == 10) ? gp_10 :
                        ((h_gi == 11) ? gp_11 :
                        ((h_gi == 12) ? gp_12 :
                        ((h_gi == 13) ? gp_13 :
                        ((h_gi == 14) ? gp_14 :
                        ((h_gi == 15) ? gp_15 :
                        ((h_gi == 16) ? gp_16 :
                        ((h_gi == 17) ? gp_17 :
                        ((h_gi == 18) ? gp_18 :
                        ((h_gi == 19) ? gp_19 :
                        ((h_gi == 20) ? gp_20 :
                        ((h_gi == 21) ? gp_21 :
                        ((h_gi == 22) ? gp_22 :
                        ((h_gi == 23) ? gp_23 :
                        ((h_gi == 24) ? gp_24 :
                        ((h_gi == 25) ? gp_25 :
                        ((h_gi == 26) ? gp_26 :
                        ((h_gi == 27) ? gp_27 :
                        ((h_gi == 28) ? gp_28 :
                        ((h_gi == 29) ? gp_29 :
                        ((h_gi == 30) ? gp_30 :
                        gp_31))))))))))))))))))))))))))))))) :
                     0))))));
    assign c_wr = (c_en & c_wen);
    assign uw_c = (c_wr & (c_addr == 1996));
    assign uw_h = (h_wen & (h_addr == 1996));
    assign uart_tx_valid = (uw_c | uw_h);
    assign c_wo8 = c_wo[7:0];
    assign uart_tx_data = (uw_c ? c_wo8 : h_wdata[7:0]);
    assign trace0 = tr0_q;
    assign trace1 = tr1_q;
    assign trace2 = tr2_q;
    assign trace3 = tr3_q;
    assign go = go_q;
    assign c_gp_w = (cw_v & cw_gp);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            cyc_q <= 0;
            rq <= 0;
            rq_wide <= 0;
            rq_byp <= 0;
            rq_st <= 0;
            rq_us <= 0;
            rq_ds <= 0;
            cw_v <= 0;
            cw_gp <= 0;
            cw_idx <= 0;
            cw_data <= 0;
            go_q <= 0;
            dbg_stop_q <= 0;
            stepping <= 0;
            step_seen <= 0;
            step_done_q <= 0;
            tr0_q <= 0;
            tr1_q <= 0;
            tr2_q <= 0;
            tr3_q <= 0;
            scratch_q <= 0;
            gp_0 <= 0;
            gp_1 <= 0;
            gp_2 <= 0;
            gp_3 <= 0;
            gp_4 <= 0;
            gp_5 <= 0;
            gp_6 <= 0;
            gp_7 <= 0;
            gp_8 <= 0;
            gp_9 <= 0;
            gp_10 <= 0;
            gp_11 <= 0;
            gp_12 <= 0;
            gp_13 <= 0;
            gp_14 <= 0;
            gp_15 <= 0;
            gp_16 <= 0;
            gp_17 <= 0;
            gp_18 <= 0;
            gp_19 <= 0;
            gp_20 <= 0;
            gp_21 <= 0;
            gp_22 <= 0;
            gp_23 <= 0;
            gp_24 <= 0;
            gp_25 <= 0;
            gp_26 <= 0;
            gp_27 <= 0;
            gp_28 <= 0;
            gp_29 <= 0;
            gp_30 <= 0;
            gp_31 <= 0;
        end else begin
            cyc_q <= (cyc_q + 1);
            rq <= p_val;
            rq_wide <= ((p_in_gp | p_is_sc) | p_is_cyc);
            rq_byp <= p_fwd;
            rq_st <= (p_addr == 1990);
            rq_us <= (p_addr == 1997);
            rq_ds <= (p_addr == 2033);
            cw_v <= ((c_en & c_wen) & (c_in_gp | c_is_sc));
            cw_gp <= c_in_gp;
            cw_idx <= c_gidx[4:0];
            cw_data <= c_wdata;
            if (h_wen) begin
                if ((h_addr == 1984)) begin
                    go_q <= h_wdata[0];
                end else begin
                    if ((h_addr == 1989)) begin
                        if (h_wdata[0]) begin
                            go_q <= 0;
                            dbg_stop_q <= 0;
                            stepping <= 0;
                            step_seen <= 0;
                            step_done_q <= 0;
                        end
                    end else begin
                        if ((h_addr == 1992)) begin
                            tr0_q <= h_wdata;
                        end else begin
                            if ((h_addr == 1993)) begin
                                tr1_q <= h_wdata;
                            end else begin
                                if ((h_addr == 1994)) begin
                                    tr2_q <= h_wdata;
                                end else begin
                                    if ((h_addr == 1995)) begin
                                        tr3_q <= h_wdata;
                                    end else begin
                                        if ((h_addr == 2035)) begin
                                            scratch_q <= h_wdata;
                                        end else begin
                                            if ((h_gp & (~c_gp_w))) begin
                                                if ((h_gi == 0)) begin
                                                    gp_0 <= h_wdata;
                                                end
                                                if ((h_gi == 1)) begin
                                                    gp_1 <= h_wdata;
                                                end
                                                if ((h_gi == 2)) begin
                                                    gp_2 <= h_wdata;
                                                end
                                                if ((h_gi == 3)) begin
                                                    gp_3 <= h_wdata;
                                                end
                                                if ((h_gi == 4)) begin
                                                    gp_4 <= h_wdata;
                                                end
                                                if ((h_gi == 5)) begin
                                                    gp_5 <= h_wdata;
                                                end
                                                if ((h_gi == 6)) begin
                                                    gp_6 <= h_wdata;
                                                end
                                                if ((h_gi == 7)) begin
                                                    gp_7 <= h_wdata;
                                                end
                                                if ((h_gi == 8)) begin
                                                    gp_8 <= h_wdata;
                                                end
                                                if ((h_gi == 9)) begin
                                                    gp_9 <= h_wdata;
                                                end
                                                if ((h_gi == 10)) begin
                                                    gp_10 <= h_wdata;
                                                end
                                                if ((h_gi == 11)) begin
                                                    gp_11 <= h_wdata;
                                                end
                                                if ((h_gi == 12)) begin
                                                    gp_12 <= h_wdata;
                                                end
                                                if ((h_gi == 13)) begin
                                                    gp_13 <= h_wdata;
                                                end
                                                if ((h_gi == 14)) begin
                                                    gp_14 <= h_wdata;
                                                end
                                                if ((h_gi == 15)) begin
                                                    gp_15 <= h_wdata;
                                                end
                                                if ((h_gi == 16)) begin
                                                    gp_16 <= h_wdata;
                                                end
                                                if ((h_gi == 17)) begin
                                                    gp_17 <= h_wdata;
                                                end
                                                if ((h_gi == 18)) begin
                                                    gp_18 <= h_wdata;
                                                end
                                                if ((h_gi == 19)) begin
                                                    gp_19 <= h_wdata;
                                                end
                                                if ((h_gi == 20)) begin
                                                    gp_20 <= h_wdata;
                                                end
                                                if ((h_gi == 21)) begin
                                                    gp_21 <= h_wdata;
                                                end
                                                if ((h_gi == 22)) begin
                                                    gp_22 <= h_wdata;
                                                end
                                                if ((h_gi == 23)) begin
                                                    gp_23 <= h_wdata;
                                                end
                                                if ((h_gi == 24)) begin
                                                    gp_24 <= h_wdata;
                                                end
                                                if ((h_gi == 25)) begin
                                                    gp_25 <= h_wdata;
                                                end
                                                if ((h_gi == 26)) begin
                                                    gp_26 <= h_wdata;
                                                end
                                                if ((h_gi == 27)) begin
                                                    gp_27 <= h_wdata;
                                                end
                                                if ((h_gi == 28)) begin
                                                    gp_28 <= h_wdata;
                                                end
                                                if ((h_gi == 29)) begin
                                                    gp_29 <= h_wdata;
                                                end
                                                if ((h_gi == 30)) begin
                                                    gp_30 <= h_wdata;
                                                end
                                                if ((h_gi == 31)) begin
                                                    gp_31 <= h_wdata;
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
            if ((c_en & c_wen)) begin
                if ((c_addr == 1984)) begin
                    go_q <= c_wo[0];
                end else begin
                    if ((c_addr == 1989)) begin
                        if (c_wo[0]) begin
                            go_q <= 0;
                            dbg_stop_q <= 0;
                            stepping <= 0;
                            step_seen <= 0;
                            step_done_q <= 0;
                        end
                    end else begin
                        if ((c_addr == 1992)) begin
                            tr0_q <= c_wo;
                        end else begin
                            if ((c_addr == 1993)) begin
                                tr1_q <= c_wo;
                            end else begin
                                if ((c_addr == 1994)) begin
                                    tr2_q <= c_wo;
                                end else begin
                                    if ((c_addr == 1995)) begin
                                        tr3_q <= c_wo;
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if (cw_v) begin
                if (cw_gp) begin
                    if ((cw_idx == 0)) begin
                        gp_0 <= cw_data;
                    end
                    if ((cw_idx == 1)) begin
                        gp_1 <= cw_data;
                    end
                    if ((cw_idx == 2)) begin
                        gp_2 <= cw_data;
                    end
                    if ((cw_idx == 3)) begin
                        gp_3 <= cw_data;
                    end
                    if ((cw_idx == 4)) begin
                        gp_4 <= cw_data;
                    end
                    if ((cw_idx == 5)) begin
                        gp_5 <= cw_data;
                    end
                    if ((cw_idx == 6)) begin
                        gp_6 <= cw_data;
                    end
                    if ((cw_idx == 7)) begin
                        gp_7 <= cw_data;
                    end
                    if ((cw_idx == 8)) begin
                        gp_8 <= cw_data;
                    end
                    if ((cw_idx == 9)) begin
                        gp_9 <= cw_data;
                    end
                    if ((cw_idx == 10)) begin
                        gp_10 <= cw_data;
                    end
                    if ((cw_idx == 11)) begin
                        gp_11 <= cw_data;
                    end
                    if ((cw_idx == 12)) begin
                        gp_12 <= cw_data;
                    end
                    if ((cw_idx == 13)) begin
                        gp_13 <= cw_data;
                    end
                    if ((cw_idx == 14)) begin
                        gp_14 <= cw_data;
                    end
                    if ((cw_idx == 15)) begin
                        gp_15 <= cw_data;
                    end
                    if ((cw_idx == 16)) begin
                        gp_16 <= cw_data;
                    end
                    if ((cw_idx == 17)) begin
                        gp_17 <= cw_data;
                    end
                    if ((cw_idx == 18)) begin
                        gp_18 <= cw_data;
                    end
                    if ((cw_idx == 19)) begin
                        gp_19 <= cw_data;
                    end
                    if ((cw_idx == 20)) begin
                        gp_20 <= cw_data;
                    end
                    if ((cw_idx == 21)) begin
                        gp_21 <= cw_data;
                    end
                    if ((cw_idx == 22)) begin
                        gp_22 <= cw_data;
                    end
                    if ((cw_idx == 23)) begin
                        gp_23 <= cw_data;
                    end
                    if ((cw_idx == 24)) begin
                        gp_24 <= cw_data;
                    end
                    if ((cw_idx == 25)) begin
                        gp_25 <= cw_data;
                    end
                    if ((cw_idx == 26)) begin
                        gp_26 <= cw_data;
                    end
                    if ((cw_idx == 27)) begin
                        gp_27 <= cw_data;
                    end
                    if ((cw_idx == 28)) begin
                        gp_28 <= cw_data;
                    end
                    if ((cw_idx == 29)) begin
                        gp_29 <= cw_data;
                    end
                    if ((cw_idx == 30)) begin
                        gp_30 <= cw_data;
                    end
                    if ((cw_idx == 31)) begin
                        gp_31 <= cw_data;
                    end
                end else begin
                    scratch_q <= cw_data;
                end
            end
            if ((c_dctl | h_dctl)) begin
                if (dctl_d[0]) begin
                    dbg_stop_q <= 1;
                end
                if ((dctl_d[2] & stopped_w)) begin
                    stepping <= 1;
                    step_seen <= 0;
                    step_done_q <= 0;
                end
                if (dctl_d[1]) begin
                    dbg_stop_q <= 0;
                end
            end
            if ((stepping & retire)) begin
                step_seen <= 1;
            end
            if (((stepping & step_seen) & core_quiet)) begin
                step_done_q <= 1;
                stepping <= 0;
            end
        end
    end
endmodule
