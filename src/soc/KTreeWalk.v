module KTreeWalk (
    input clk,
    input rst_n,
    input [127:0] im_data,
    input im_gnt,
    output logic im_req,
    output logic [11:0] im_addr,
    input start_v,
    input [18:0] st_bit0,
    input [19:0] tree_bit,
    input [11:0] word_line0,
    input out_rdy,
    input [31:0] cq_val,
    input adv_busy,
    output logic out_v,
    output logic [13:0] out_word,
    output logic [127:0] out_inst,
    output logic [2:0] out_nw,
    output logic done,
    output logic busy,
    output logic [5:0] cq_idx,
    output logic adv_v,
    output logic [19:0] adv_bit,
    output logic [15:0] adv_iter
);
    logic [4:0] st;
    logic [3:0] sp;
    logic [15:0] fired;
    logic [13:0] iword;
    logic [6:0] n_left;
    logic [127:0] out_q;
    logic ov;
    logic pre_g;
    logic hdr_cvar;
    logic [15:0] hdr_count;
    logic [24:0] hdr_lim;
    logic hdr_own;
    logic [19:0] hdr_sbit;
    logic [13:0] hdr_sword;
    logic [19:0] hdr_abit;
    logic [11:0] tq_nleft;
    logic tq_isloop;
    logic [15:0] tq_count;
    logic [15:0] tq_iter;
    logic [24:0] tq_lim;
    logic tq_limv;
    logic tq_own;
    logic [19:0] tq_bbit;
    logic [13:0] tq_bword;
    logic [19:0] tq_abit;
    logic [19:0] tq_sbit;
    logic [13:0] tq_sword;
    logic lh_q;
    logic it_last_q;
    logic [24:0] nl_lim;
    logic nl_limv;
    logic nn_q;
    logic spnz_q;
    logic [11:0] stk_nleft [0:7];
    logic stk_isloop [0:7];
    logic [15:0] stk_count [0:7];
    logic [15:0] stk_iter [0:7];
    logic [24:0] stk_lim [0:7];
    logic stk_limv [0:7];
    logic stk_own [0:7];
    logic [19:0] stk_bbit [0:7];
    logic [13:0] stk_bword [0:7];
    logic [19:0] stk_abit [0:7];
    logic [19:0] stk_sbit [0:7];
    logic [13:0] stk_sword [0:7];
    logic [3:0] top;
    logic [3:0] sp_m2;
    logic [3:0] sp_m3;
    logic [24:0] q_lim;
    logic q_limv;
    logic [11:0] p_nleft;
    logic p_isloop;
    logic [15:0] p_count;
    logic [15:0] p_iter;
    logic [24:0] p_lim;
    logic p_limv;
    logic p_own;
    logic [19:0] p_bbit;
    logic [13:0] p_bword;
    logic [19:0] p_abit;
    logic [19:0] p_sbit;
    logic [13:0] p_sword;
    logic lim_hit;
    logic lh_cur;
    logic lh_pop;
    logic node_go;
    logic [5:0] rt_get_w;
    logic rdy;
    logic rt_req_v;
    logic rt_get_v;
    logic seek_go;
    logic [18:0] seek_rel;
    logic [18:0] seek_abs;
    logic [11:0] seek_line;
    logic [6:0] seek_bit;
    logic [31:0] hv;
    logic if_req_n;
    logic if_req;
    logic rt_gnt;
    logic v1;
    logic [6:0] v7;
    logic [11:0] v12;
    logic [13:0] v14;
    logic [17:0] v18;
    logic [23:0] v24;
    logic at_start;
    logic adv_ack;
    logic adv_done;
    logic [15:0] iter_n;
    logic [11:0] ifl_q;
    logic [11:0] ifl1_q;
    logic [11:0] if_cur;
    logic [127:0] in_sh;
    logic [2:0] nx_nw;
    logic [13:0] nx_word;
    logic nx_line;
    logic new_own;
    logic [24:0] new_lim;
    logic lh_push;
    logic [15:0] cnt_sel;
    logic u_rt_ready;
    logic u_rt_im_req;
    logic [31:0] u_rt_hd;
    logic [11:0] u_rt_im_addr;
    logic [18:0] u_rt_pos;

    initial begin
        for (int _i = 0; _i < 8; _i++) stk_nleft[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_isloop[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_count[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_iter[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_lim[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_limv[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_own[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_bbit[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_bword[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_abit[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_sbit[_i] = 0;
        for (int _i = 0; _i < 8; _i++) stk_sword[_i] = 0;
    end

    assign top = (sp - 1);
    assign sp_m2 = (sp - 2);
    assign sp_m3 = (sp - 3);
    assign q_lim = stk_lim[sp_m3[2:0]];
    assign q_limv = stk_limv[sp_m3[2:0]];
    assign p_nleft = stk_nleft[sp_m2[2:0]];
    assign p_isloop = stk_isloop[sp_m2[2:0]];
    assign p_count = stk_count[sp_m2[2:0]];
    assign p_iter = stk_iter[sp_m2[2:0]];
    assign p_lim = stk_lim[sp_m2[2:0]];
    assign p_limv = stk_limv[sp_m2[2:0]];
    assign p_own = stk_own[sp_m2[2:0]];
    assign p_bbit = stk_bbit[sp_m2[2:0]];
    assign p_bword = stk_bword[sp_m2[2:0]];
    assign p_abit = stk_abit[sp_m2[2:0]];
    assign p_sbit = stk_sbit[sp_m2[2:0]];
    assign p_sword = stk_sword[sp_m2[2:0]];
    assign lim_hit = lh_q;
    assign lh_cur = (tq_limv & ({9'd0, fired} >= tq_lim));
    assign lh_pop = (nl_limv & ({9'd0, fired} >= nl_lim));
    assign node_go = ((((st == 2) & spnz_q) & (~lim_hit)) & nn_q);
    assign rt_get_w = ((st == 0) ? 0 :
                      ((st == 1) ? 12 :
                      ((st == 2) ? 1 :
                      ((st == 3) ? 18 :
                      ((st == 4) ? 24 :
                      ((st == 5) ? 24 :
                      ((st == 6) ? 14 :
                      ((st == 7) ? 7 :
                      ((st == 8) ? 13 :
                      ((st == 9) ? 12 :
                      ((st == 10) ? 0 :
                      ((st == 11) ? 12 :
                      ((st == 12) ? 0 :
                      ((st == 13) ? 0 :
                      ((st == 14) ? 0 :
                      ((st == 15) ? 0 :
                      ((st == 16) ? 0 :
                      ((st == 17) ? 0 :
                      0))))))))))))))))));
    assign rt_req_v = (rdy & (rt_get_w != 0));
    assign rt_get_v = (rt_req_v & ((st == 2) ? node_go : 1'd1));
    assign seek_abs = (st_bit0 + seek_rel);
    assign seek_line = seek_abs[18:7];
    assign seek_bit = seek_abs[6:0];
    assign if_req_n = (((st == 2) & rdy) & (~hv[31]));
    assign if_req = (if_req_n | ((st == 13) & (~pre_g)));
    assign rdy = u_rt_ready;
    assign rt_gnt = ((im_gnt & u_rt_im_req) & (~if_req));
    assign hv = u_rt_hd;
    assign v1 = hv[31];
    assign v7 = hv[31:25];
    assign v12 = hv[31:20];
    assign v14 = hv[31:18];
    assign v18 = hv[31:14];
    assign v24 = hv[31:8];
    assign at_start = ((st == 0) | (st == 16));
    assign adv_done = (((st == 17) & (~adv_busy)) & adv_ack);
    assign iter_n = (tq_iter + 1);
    assign seek_go = (((at_start & start_v) | (adv_done & (~it_last_q))) | ((((st == 12) & spnz_q) & tq_own) & lim_hit));
    assign seek_rel = (at_start ? tree_bit[18:0] : (adv_done ? tq_bbit[18:0] : tq_sbit[18:0]));
    assign if_cur = (word_line0 + iword[13:2]);
    assign in_sh = (im_data >> {iword[1:0], 5'd0});
    assign nx_nw = ((out_q[4:0] == 0) ? 3'd4 :
                   ((out_q[4:0] == 1) ? 3'd3 :
                   ((out_q[4:0] == 2) ? 3'd2 :
                   ((out_q[4:0] == 3) ? 3'd3 :
                   ((out_q[4:0] == 4) ? 3'd3 :
                   ((out_q[4:0] == 5) ? 3'd3 :
                   ((out_q[4:0] == 6) ? 3'd3 :
                   ((out_q[4:0] == 7) ? 3'd3 :
                   ((out_q[4:0] == 8) ? 3'd2 :
                   ((out_q[4:0] == 9) ? 3'd2 :
                   ((out_q[4:0] == 10) ? 3'd2 :
                   ((out_q[4:0] == 11) ? 3'd2 :
                   ((out_q[4:0] == 12) ? 3'd1 :
                   ((out_q[4:0] == 13) ? 3'd3 :
                   ((out_q[4:0] == 14) ? 3'd4 :
                   ((out_q[4:0] == 15) ? 3'd1 :
                   ((out_q[4:0] == 16) ? 3'd3 :
                   ((out_q[4:0] == 17) ? 3'd2 :
                   ((out_q[4:0] == 18) ? 3'd1 :
                   ((out_q[4:0] == 19) ? 3'd1 :
                   ((out_q[4:0] == 20) ? 3'd4 :
                   ((out_q[4:0] == 21) ? 3'd1 :
                   ((out_q[4:0] == 22) ? 3'd1 :
                   ((out_q[4:0] == 23) ? 3'd3 :
                   3'd3))))))))))))))))))))))));
    assign nx_word = (((({1'd0, iword[1:0]} + nx_nw) < 4)
                       & (((nx_nw == 0) ? out_q[4:0] :
                          ((nx_nw == 1) ? out_q[36:32] :
                          ((nx_nw == 2) ? out_q[68:64] :
                          ((nx_nw == 3) ? out_q[100:96] :
                          out_q[4:0])))) == 31)) ? {(iword[13:2] + 12'd1), 2'd0} :
                     (iword + {11'd0, nx_nw}));
    assign nx_line = (nx_word[2] ^ iword[2]);
    assign im_req = (if_req | u_rt_im_req);
    assign im_addr = (if_req ? ifl_q : u_rt_im_addr);
    assign out_v = ov;
    assign out_word = iword;
    assign out_inst = out_q;
    assign out_nw = nx_nw;
    assign done = (st == 16);
    assign busy = (st != 0);
    assign cq_idx = hdr_count[5:0];
    assign adv_v = (st == 10);
    assign adv_bit = tq_abit;
    assign adv_iter = tq_iter;
    assign new_own = (hdr_own & ((~tq_limv) | (hdr_lim < tq_lim)));
    assign new_lim = (new_own ? hdr_lim : tq_lim);
    assign lh_push = ((hdr_own | tq_limv) & (new_own ? ({9'd0, fired} >= hdr_lim) : ({9'd0, fired} >= tq_lim)));
    assign cnt_sel = (hdr_cvar ? cq_val[15:0] : hdr_count);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            pre_g <= 0;
            lh_q <= 0;
            it_last_q <= 0;
            ifl_q <= 0;
            ifl1_q <= 1;
            fired <= 0;
            sp <= 0;
            spnz_q <= 0;
            iword <= 0;
            st <= 0;
            tq_nleft <= 0;
            nn_q <= 0;
            tq_isloop <= 0;
            tq_limv <= 0;
            tq_own <= 0;
            tq_iter <= 0;
            hdr_own <= 0;
            hdr_cvar <= 0;
            hdr_count <= 0;
            hdr_lim <= 0;
            hdr_sbit <= 0;
            hdr_sword <= 0;
            hdr_abit <= 0;
            n_left <= 0;
            tq_count <= 0;
            tq_lim <= 0;
            nl_lim <= 0;
            nl_limv <= 0;
            tq_bbit <= 0;
            tq_bword <= 0;
            tq_abit <= 0;
            tq_sbit <= 0;
            tq_sword <= 0;
            adv_ack <= 0;
            ov <= 0;
        end else begin
            pre_g <= (if_req_n & im_gnt);
            lh_q <= lh_cur;
            it_last_q <= (iter_n >= tq_count);
            ifl_q <= if_cur;
            ifl1_q <= (if_cur + 1);
            case (st)
                0: begin
                    if (start_v) begin
                        fired <= 0;
                        sp <= 0;
                        spnz_q <= 0;
                        iword <= 0;
                        st <= 1;
                    end
                end
                1: begin
                    if (rdy) begin
                        tq_nleft <= v12;
                        nn_q <= (v12 != 0);
                        tq_isloop <= 0;
                        tq_limv <= 0;
                        lh_q <= 0;
                        tq_own <= 0;
                        tq_iter <= 0;
                        sp <= 1;
                        spnz_q <= 1;
                        st <= 2;
                    end
                end
                2: begin
                    if ((~spnz_q)) begin
                        st <= 16;
                    end else begin
                        if (lim_hit) begin
                            st <= 12;
                        end else begin
                            if ((~nn_q)) begin
                                if (tq_isloop) begin
                                    st <= 10;
                                end else begin
                                    sp <= (sp - 1);
                                    spnz_q <= (sp != 1);
                                end
                            end else begin
                                if (rdy) begin
                                    tq_nleft <= (tq_nleft - 1);
                                    nn_q <= (tq_nleft != 1);
                                    if ((v1 == 0)) begin
                                        fired <= (fired + 1);
                                        st <= 13;
                                    end else begin
                                        hdr_own <= 0;
                                        st <= 3;
                                    end
                                end
                            end
                        end
                    end
                end
                3: begin
                    if (rdy) begin
                        hdr_cvar <= v18[17];
                        hdr_count <= v18[16:1];
                        st <= (v18[0] ? 5'd4 : 5'd7);
                    end
                end
                4: begin
                    if (rdy) begin
                        hdr_lim <= ({9'd0, fired} + {1'd0, v24});
                        hdr_own <= 1;
                        st <= 5;
                    end
                end
                5: begin
                    if (rdy) begin
                        hdr_sbit <= v24[19:0];
                        st <= 6;
                    end
                end
                6: begin
                    if (rdy) begin
                        hdr_sword <= v14;
                        st <= 7;
                    end
                end
                7: begin
                    if (rdy) begin
                        hdr_abit <= (u_rt_pos - st_bit0);
                        n_left <= v7;
                        st <= ((v7 == 0) ? 5'd9 : 5'd8);
                    end
                end
                8: begin
                    if (rdy) begin
                        n_left <= (n_left - 1);
                        st <= ((n_left == 1) ? 5'd9 : 5'd8);
                    end
                end
                9: begin
                    if (rdy) begin
                        stk_nleft[top[2:0]] <= tq_nleft;
                        stk_isloop[top[2:0]] <= tq_isloop;
                        stk_count[top[2:0]] <= tq_count;
                        stk_iter[top[2:0]] <= tq_iter;
                        stk_lim[top[2:0]] <= tq_lim;
                        stk_limv[top[2:0]] <= tq_limv;
                        stk_own[top[2:0]] <= tq_own;
                        stk_bbit[top[2:0]] <= tq_bbit;
                        stk_bword[top[2:0]] <= tq_bword;
                        stk_abit[top[2:0]] <= tq_abit;
                        stk_sbit[top[2:0]] <= tq_sbit;
                        stk_sword[top[2:0]] <= tq_sword;
                        tq_nleft <= v12;
                        nn_q <= (v12 != 0);
                        tq_isloop <= 1;
                        tq_count <= cnt_sel;
                        tq_iter <= 0;
                        tq_lim <= new_lim;
                        tq_limv <= (hdr_own | tq_limv);
                        lh_q <= lh_push;
                        nl_lim <= tq_lim;
                        nl_limv <= tq_limv;
                        tq_own <= new_own;
                        tq_bbit <= (u_rt_pos - st_bit0);
                        tq_bword <= iword;
                        tq_abit <= hdr_abit;
                        tq_sbit <= hdr_sbit;
                        tq_sword <= hdr_sword;
                        sp <= (sp + 1);
                        spnz_q <= (sp != 15);
                        st <= 2;
                    end
                end
                10: begin
                    adv_ack <= 0;
                    st <= 17;
                end
                17: begin
                    if (adv_busy) begin
                        adv_ack <= 1;
                    end else begin
                        if (adv_ack) begin
                            tq_iter <= iter_n;
                            if (it_last_q) begin
                                sp <= (sp - 1);
                                spnz_q <= (sp != 1);
                                if ((sp != 1)) begin
                                    lh_q <= lh_pop;
                                    nl_lim <= q_lim;
                                    nl_limv <= q_limv;
                                    tq_nleft <= p_nleft;
                                    nn_q <= (p_nleft != 0);
                                    tq_isloop <= p_isloop;
                                    tq_count <= p_count;
                                    tq_iter <= p_iter;
                                    tq_lim <= p_lim;
                                    tq_limv <= p_limv;
                                    tq_own <= p_own;
                                    tq_bbit <= p_bbit;
                                    tq_bword <= p_bword;
                                    tq_abit <= p_abit;
                                    tq_sbit <= p_sbit;
                                    tq_sword <= p_sword;
                                end
                                st <= 2;
                            end else begin
                                iword <= tq_bword;
                                st <= 11;
                            end
                        end
                    end
                end
                11: begin
                    if (rdy) begin
                        tq_nleft <= v12;
                        nn_q <= (v12 != 0);
                        st <= 2;
                    end
                end
                12: begin
                    if ((~spnz_q)) begin
                        st <= 16;
                    end else begin
                        sp <= (sp - 1);
                        spnz_q <= (sp != 1);
                        if ((sp != 1)) begin
                            lh_q <= lh_pop;
                            nl_lim <= q_lim;
                            nl_limv <= q_limv;
                            tq_nleft <= p_nleft;
                            nn_q <= (p_nleft != 0);
                            tq_isloop <= p_isloop;
                            tq_count <= p_count;
                            tq_iter <= p_iter;
                            tq_lim <= p_lim;
                            tq_limv <= p_limv;
                            tq_own <= p_own;
                            tq_bbit <= p_bbit;
                            tq_bword <= p_bword;
                            tq_abit <= p_abit;
                            tq_sbit <= p_sbit;
                            tq_sword <= p_sword;
                        end
                        if ((tq_own & lim_hit)) begin
                            iword <= tq_sword;
                            st <= 2;
                        end else begin
                            st <= 12;
                        end
                    end
                end
                13: begin
                    if (pre_g) begin
                        ov <= 1;
                        st <= 14;
                    end else begin
                        if (im_gnt) begin
                            st <= 18;
                        end
                    end
                end
                18: begin
                    ov <= 1;
                    st <= 14;
                end
                14, 15: begin
                    if (out_rdy) begin
                        iword <= nx_word;
                        if (nx_line) begin
                            ifl_q <= ifl1_q;
                        end
                        ov <= 0;
                        st <= 2;
                    end
                end
                default: begin
                    if (start_v) begin
                        fired <= 0;
                        sp <= 0;
                        spnz_q <= 0;
                        iword <= 0;
                        st <= 1;
                    end
                end
            endcase
        end
    end
    always_ff @(posedge clk) begin
        case (st)
            0: begin
            end
            1: begin
            end
            2: begin
            end
            3: begin
            end
            4: begin
            end
            5: begin
            end
            6: begin
            end
            7: begin
            end
            8: begin
            end
            9: begin
            end
            10: begin
            end
            17: begin
            end
            11: begin
            end
            12: begin
            end
            13: begin
                if (pre_g) begin
                    out_q <= in_sh;
                end
            end
            18: begin
                out_q <= in_sh;
            end
        endcase
    end

    KBitStream u_rt (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(im_data),
        .im_gnt(rt_gnt),
        .seek_v(seek_go),
        .seek_line(seek_line),
        .seek_bit(seek_bit),
        .get_v(rt_get_v),
        .get_w(rt_get_w),
        .req_v(rt_req_v),
        .req_pre(1'd1),
        .ready(u_rt_ready),
        .im_req(u_rt_im_req),
        .hd(u_rt_hd),
        .im_addr(u_rt_im_addr),
        .pos(u_rt_pos)
    );
endmodule
