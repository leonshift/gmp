module DmaChan (
    input clk,
    input rst_n,
    input fan_cmd_valid,
    output logic fan_idle,
    output logic fan_rel,
    input cmd_smem,
    input [7:0] cmd_scid,
    input [31:0] cmd_saddr,
    input cmd_dmem,
    input [7:0] cmd_dcid,
    input [31:0] cmd_daddr,
    input [15:0] cmd_rows,
    input [19:0] cmd_bytes,
    input [19:0] cmd_sstride,
    input [19:0] cmd_dstride,
    input rd_take,
    input wr_take,
    input w_take,
    input w_take_l_0,
    input w_take_l_1,
    input w_take_l_2,
    input w_take_l_3,
    input r_v,
    input r_last,
    input [1023:0] d_l1,
    input [1023:0] d_noc,
    input [1:0] a_n,
    input [1:0] b_n,
    output logic rdq_n1,
    output logic rdq_n2,
    output logic rdq_l1,
    output logic [7:0] rdq_cid,
    output logic [31:0] rdq_h_addr,
    output logic [19:0] rdq_h_bytes,
    output logic rdq_h_first,
    output logic rdq_h_last,
    output logic [31:0] rdq_x_addr,
    output logic [19:0] rdq_x_bytes,
    output logic rdq_x_first,
    output logic rdq_x_last,
    output logic wrq_n1,
    output logic wrq_n2,
    output logic wrq_l1,
    output logic [7:0] wrq_cid,
    output logic [31:0] wrq_h_addr,
    output logic [19:0] wrq_h_bytes,
    output logic wrq_h_first,
    output logic wrq_h_last,
    output logic [31:0] wrq_x_addr,
    output logic [19:0] wrq_x_bytes,
    output logic wrq_x_first,
    output logic wrq_x_last,
    output logic wrq_push,
    output logic [31:0] wrq_i_addr,
    output logic [19:0] wrq_i_bytes,
    output logic wrq_i_first,
    output logic wrq_i_last,
    output logic w_v1,
    output logic w_v2,
    output logic w_l1,
    output logic [1023:0] w_cur,
    output logic [127:0] w_stb,
    output logic [2:0] dbg_state,
    output logic [31:0] dbg_count,
    output logic [8:0] dbg_fifo_occ
);
    logic cv_q;
    logic cv_ri;
    logic cv_wi;
    logic cv_ww;
    logic cv_id;
    logic cv_g1;
    logic cv_g2;
    logic cv_c;
    logic q_smem;
    logic [7:0] q_scid;
    logic [31:0] q_saddr;
    logic q_dmem;
    logic [7:0] q_dcid;
    logic [31:0] q_daddr;
    logic [15:0] q_rows;
    logic [19:0] q_bytes;
    logic [19:0] q_sstride;
    logic [19:0] q_dstride;
    logic active;
    logic smem;
    logic [7:0] scid;
    logic dmem;
    logic [7:0] dcid;
    logic [15:0] rows;
    logic [19:0] nbytes;
    logic [19:0] sstride;
    logic [19:0] dstride;
    logic [19:0] nb_n;
    logic nb_le;
    logic nb_le2;
    logic [31:0] ri_addr;
    logic [31:0] ri_nrow;
    logic [19:0] ri_rem;
    logic [15:0] ri_row;
    logic ri_lrow;
    logic [19:0] ri_n;
    logic ri_lc;
    logic ri_le2q;
    logic [8:0] ri_beats;
    logic ri_first;
    logic ri_adv;
    logic ri_done;
    logic [31:0] rq_a0;
    logic [31:0] rq_a1;
    logic [19:0] rq_b0;
    logic [19:0] rq_b1;
    logic rq_f0;
    logic rq_f1;
    logic rq_z0;
    logic rq_z1;
    logic rq_wp;
    logic rq_rp;
    logic [1:0] rq_cnt;
    logic [31:0] wi_addr;
    logic [31:0] wi_nrow;
    logic [19:0] wi_rem;
    logic [15:0] wi_row;
    logic wi_lrow;
    logic [19:0] wi_n;
    logic wi_lc;
    logic wi_first;
    logic wi_done;
    logic wpa_q;
    logic [15:0] aw_pend;
    logic aw_pend_nz;
    logic [31:0] wq_a0;
    logic [31:0] wq_a1;
    logic [19:0] wq_b0;
    logic [19:0] wq_b1;
    logic wq_f0;
    logic wq_f1;
    logic wq_z0;
    logic wq_z1;
    logic wq_wp;
    logic wq_rp;
    logic [1:0] wq_cnt;
    logic [15:0] ww_row;
    logic [19:0] ww_remr;
    logic ww_lc;
    logic [12:0] ww_pnq;
    logic ww_lrow;
    logic [6:0] ww_slo;
    logic [6:0] ww_dlo7;
    logic wg_done;
    logic nx_v;
    logic [8:0] nx_ns;
    logic [8:0] nx_nd;
    logic [6:0] nx_dlo;
    logic [6:0] nx_hil;
    logic nx_last;
    logic nx_one;
    logic nx_two;
    logic ww_act;
    logic [8:0] ww_rem;
    logic ww_one;
    logic ww_first;
    logic [6:0] ww_dlo;
    logic [6:0] ww_hil;
    logic ww_last;
    logic [8:0] ww_ns;
    logic [8:0] ww_pops;
    logic ww_need_q;
    logic ww_done;
    logic [15:0] aw_rdy;
    logic aw_rdy_nz;
    logic rv_q;
    logic rv_w_0;
    logic rv_w_1;
    logic rv_w_2;
    logic rv_w_3;
    logic rlast_q;
    logic rsel1;
    logic rsel1x_0;
    logic rsel1x_1;
    logic rsel1x_2;
    logic rsel1x_3;
    logic rsel2_0;
    logic rsel2_1;
    logic rsel2_2;
    logic rsel2_3;
    logic rsel2_4;
    logic rsel2_5;
    logic rsel2_6;
    logic rsel2_7;
    logic rsel2_8;
    logic rsel2_9;
    logic rsel2_10;
    logic rsel2_11;
    logic rsel2_12;
    logic rsel2_13;
    logic rsel2_14;
    logic rsel2_15;
    logic [1023:0] rdat_q;
    logic [1023:0] rdat_d;
    logic [15:0] rd_iss;
    logic [15:0] rd_arr;
    logic rd_part;
    logic [15:0] wr_iss;
    logic [15:0] a_cnt;
    logic [15:0] adef;
    logic adef_hi0;
    logic [15:0] b_cnt;
    logic rel;
    logic reported;
    logic [31:0] count;
    logic q_empty;
    logic q_nb_le;
    logic q_nb_le2;
    logic [19:0] q_nb_n;
    logic [13:0] q_sbsum;
    logic q_lrow;
    logic [31:0] q_snrow;
    logic [31:0] q_dnrow;
    logic [19:0] ri_rem_m;
    logic ri_le2;
    logic ri_le3;
    logic [19:0] ri_n_nx;
    logic ri_lc_nx;
    logic [6:0] ri_lo_nx;
    logic [13:0] ri_bsum;
    logic ri_lrow_nx;
    logic [19:0] wi_rem_m;
    logic wi_le2;
    logic [19:0] wi_n_nx;
    logic wi_lc_nx;
    logic wi_lrow_nx;
    logic rd_push0;
    logic rd_push;
    logic ri_step;
    logic first_arr;
    logic wr_push;
    logic [15:0] aw_pend_nx;
    logic act_n;
    logic wid_n;
    logic ww_lastc;
    logic [13:0] wg_ssum;
    logic [13:0] wg_dsum;
    logic [13:0] wg_end;
    logic [19:0] ww_rem_m;
    logic ww_le2;
    logic [12:0] ww_pn_m;
    logic [15:0] ww_row_p1;
    logic ww_lrow_p1;
    logic aw_ok;
    logic st_idle;
    logic emit_a;
    logic emit_s;
    logic emit;
    logic rd_src;
    logic islast;
    logic e_last;
    logic ww_start;
    logic wg_calc;
    logic [13:0] side;
    logic [8:0] ww_pops_inc;
    logic ww_need_n;
    logic [15:0] aw_rdy_nx;
    logic all_issued;
    logic [15:0] adef_n;
    logic all_admitted;
    logic retire;
    logic u_fifo_room_max;
    logic [8:0] u_fifo_free;
    logic u_fifo_avail;
    logic u_fifo_space;
    logic u_fifo_wv1;
    logic u_fifo_wv2;
    logic [1023:0] u_fifo_hdata;
    logic [127:0] u_fifo_hstb;
    logic u_fifo_empty;
    logic [8:0] u_fifo_occ;

    assign rdat_d = {(rsel2_15 ? d_noc[1023:960] : d_l1[1023:960]), (rsel2_14 ? d_noc[959:896] : d_l1[959:896]),
                     (rsel2_13 ? d_noc[895:832] : d_l1[895:832]), (rsel2_12 ? d_noc[831:768] : d_l1[831:768]),
                     (rsel2_11 ? d_noc[767:704] : d_l1[767:704]), (rsel2_10 ? d_noc[703:640] : d_l1[703:640]),
                     (rsel2_9 ? d_noc[639:576] : d_l1[639:576]), (rsel2_8 ? d_noc[575:512] : d_l1[575:512]),
                     (rsel2_7 ? d_noc[511:448] : d_l1[511:448]), (rsel2_6 ? d_noc[447:384] : d_l1[447:384]),
                     (rsel2_5 ? d_noc[383:320] : d_l1[383:320]), (rsel2_4 ? d_noc[319:256] : d_l1[319:256]),
                     (rsel2_3 ? d_noc[255:192] : d_l1[255:192]), (rsel2_2 ? d_noc[191:128] : d_l1[191:128]),
                     (rsel2_1 ? d_noc[127:64] : d_l1[127:64]), (rsel2_0 ? d_noc[63:0] : d_l1[63:0])};
    assign q_empty = ((q_rows == 0) | (q_bytes == 0));
    assign q_nb_le = (q_bytes <= 4096);
    assign q_nb_le2 = (q_bytes <= 8192);
    assign q_nb_n = (q_nb_le ? q_bytes : 20'd4096);
    assign q_sbsum = (({7'd0, q_saddr[6:0]} + {1'd0, q_nb_n[12:0]}) + 127);
    assign q_lrow = (q_rows == 1);
    assign q_snrow = (q_saddr + {12'd0, q_sstride});
    assign q_dnrow = (q_daddr + {12'd0, q_dstride});
    assign ri_rem_m = (ri_rem - 4096);
    assign ri_le2 = ri_le2q;
    assign ri_le3 = (ri_rem <= 12288);
    assign ri_n_nx = (ri_lc ? nb_n : (ri_le2 ? ri_rem_m : 20'd4096));
    assign ri_lc_nx = (ri_lc ? nb_le : ri_le2);
    assign ri_lo_nx = (ri_lc ? ri_nrow[6:0] : ri_addr[6:0]);
    assign ri_bsum = (({7'd0, ri_lo_nx} + {1'd0, ri_n_nx[12:0]}) + 127);
    assign ri_lrow_nx = ((ri_row + 2) == rows);
    assign wi_rem_m = (wi_rem - 4096);
    assign wi_le2 = (wi_rem <= 8192);
    assign wi_n_nx = (wi_lc ? nb_n : (wi_le2 ? wi_rem_m : 20'd4096));
    assign wi_lc_nx = (wi_lc ? nb_le : wi_le2);
    assign wi_lrow_nx = ((wi_row + 2) == rows);
    assign rd_push0 = ((cv_q & (~q_empty)) & u_fifo_room_max);
    assign rd_push = ((((active & (~ri_done)) & (~ri_adv)) & (u_fifo_free >= ri_beats)) & ((rq_cnt != 2) | rd_take));
    assign ri_step = (rd_push | ri_adv);
    assign first_arr = (rv_q & (~rd_part));
    assign wr_push = ((wpa_q & (aw_pend_nz | first_arr)) & (wq_cnt != 2));
    assign aw_pend_nx = ((aw_pend + {15'd0, first_arr}) - {15'd0, wr_push});
    assign act_n = (cv_c | (active & (~retire)));
    assign wid_n = (cv_wi ? q_empty : (wi_done | ((wr_push & wi_lc) & wi_lrow)));
    assign rdq_n1 = (rq_cnt != 0);
    assign rdq_n2 = (rq_cnt == 2);
    assign rdq_l1 = (~smem);
    assign rdq_cid = scid;
    assign rdq_h_addr = (rq_rp ? rq_a1 : rq_a0);
    assign rdq_x_addr = (rq_rp ? rq_a0 : rq_a1);
    assign rdq_h_bytes = (rq_rp ? rq_b1 : rq_b0);
    assign rdq_x_bytes = (rq_rp ? rq_b0 : rq_b1);
    assign rdq_h_first = (rq_rp ? rq_f1 : rq_f0);
    assign rdq_x_first = (rq_rp ? rq_f0 : rq_f1);
    assign rdq_h_last = (rq_rp ? rq_z1 : rq_z0);
    assign rdq_x_last = (rq_rp ? rq_z0 : rq_z1);
    assign wrq_n1 = (wq_cnt != 0);
    assign wrq_n2 = (wq_cnt == 2);
    assign wrq_push = wr_push;
    assign wrq_i_addr = wi_addr;
    assign wrq_i_bytes = wi_n;
    assign wrq_i_first = wi_first;
    assign wrq_i_last = (wi_lrow & wi_lc);
    assign wrq_l1 = (~dmem);
    assign wrq_cid = dcid;
    assign wrq_h_addr = (wq_rp ? wq_a1 : wq_a0);
    assign wrq_x_addr = (wq_rp ? wq_a0 : wq_a1);
    assign wrq_h_bytes = (wq_rp ? wq_b1 : wq_b0);
    assign wrq_x_bytes = (wq_rp ? wq_b0 : wq_b1);
    assign wrq_h_first = (wq_rp ? wq_f1 : wq_f0);
    assign wrq_x_first = (wq_rp ? wq_f0 : wq_f1);
    assign wrq_h_last = (wq_rp ? wq_z1 : wq_z0);
    assign wrq_x_last = (wq_rp ? wq_z0 : wq_z1);
    assign ww_lastc = ww_lc;
    assign wg_ssum = (({7'd0, ww_slo} + {1'd0, ww_pnq}) + 127);
    assign wg_dsum = (({7'd0, ww_dlo7} + {1'd0, ww_pnq}) + 127);
    assign wg_end = (({7'd0, ww_dlo7} + {1'd0, ww_pnq}) - 1);
    assign ww_rem_m = (ww_remr - 4096);
    assign ww_le2 = (ww_remr <= 8192);
    assign ww_pn_m = (ww_le2 ? ww_rem_m[12:0] : 13'd4096);
    assign ww_row_p1 = (ww_row + 1);
    assign ww_lrow_p1 = (ww_row_p1 == (rows - 1));
    assign aw_ok = (aw_rdy_nz | wr_take);
    assign st_idle = (((~ww_act) & nx_v) & aw_ok);
    assign emit_a = ((ww_act & ((~ww_need_q) | u_fifo_avail)) & u_fifo_space);
    assign emit_s = ((st_idle & u_fifo_avail) & u_fifo_space);
    assign emit = (emit_a | emit_s);
    assign rd_src = ((emit_a & ww_need_q) | emit_s);
    assign islast = ww_one;
    assign e_last = (emit_a & islast);
    assign ww_start = ((nx_v & aw_ok) & ((~ww_act) | e_last));
    assign wg_calc = ((active & (~wg_done)) & ((~nx_v) | ww_start));
    assign side = (ww_act ? {(islast ? ww_hil : 7'd127), (ww_first ? ww_dlo : 7'd0)} :
                  {(nx_one ? nx_hil : 7'd127), nx_dlo});
    assign ww_pops_inc = (ww_pops + 1);
    assign ww_need_n = (ww_start ? (emit_s ? (nx_ns != 1) : 1'd1) :
                       ((emit_a & ww_need_q) ? (ww_ns != ww_pops_inc) :
                       ww_need_q));
    assign aw_rdy_nx = ((aw_rdy + {15'd0, wr_take}) - {15'd0, ww_start});
    assign w_v1 = u_fifo_wv1;
    assign w_v2 = u_fifo_wv2;
    assign w_l1 = (~dmem);
    assign w_cur = u_fifo_hdata;
    assign w_stb = u_fifo_hstb;
    assign fan_rel = rel;
    assign fan_idle = ((~active) & (~cv_q));
    assign all_issued = (((ri_done & wi_done) & (rq_cnt == 0)) & (wq_cnt == 0));
    assign adef_n = (((adef + {15'd0, rd_take}) + {15'd0, wr_take}) - {14'd0, a_n});
    assign all_admitted = ((all_issued & adef_hi0) & (adef[1:0] == a_n));
    assign retire = ((((((active & all_issued) & ww_done) & u_fifo_empty) & (rd_arr == rd_iss)) & (b_cnt == wr_iss))
                     & reported);
    assign dbg_state = ((~active) ? 3'd0 : ((~ri_done) ? 3'd1 : ((~wi_done) ? 3'd2 : ((~ww_done) ? 3'd3 : 3'd4))));
    assign dbg_count = count;
    assign dbg_fifo_occ = u_fifo_occ;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            cv_q <= 0;
            cv_ri <= 0;
            cv_wi <= 0;
            cv_ww <= 0;
            cv_id <= 0;
            cv_g1 <= 0;
            cv_g2 <= 0;
            cv_c <= 0;
            rv_q <= 0;
            rv_w_0 <= 0;
            rv_w_1 <= 0;
            rv_w_2 <= 0;
            rv_w_3 <= 0;
            rlast_q <= 0;
            rsel1 <= 0;
            rsel1x_0 <= 0;
            rsel1x_1 <= 0;
            rsel1x_2 <= 0;
            rsel1x_3 <= 0;
            rsel2_0 <= 0;
            rsel2_1 <= 0;
            rsel2_2 <= 0;
            rsel2_3 <= 0;
            rsel2_4 <= 0;
            rsel2_5 <= 0;
            rsel2_6 <= 0;
            rsel2_7 <= 0;
            rsel2_8 <= 0;
            rsel2_9 <= 0;
            rsel2_10 <= 0;
            rsel2_11 <= 0;
            rsel2_12 <= 0;
            rsel2_13 <= 0;
            rsel2_14 <= 0;
            rsel2_15 <= 0;
            a_cnt <= 0;
            adef <= 0;
            adef_hi0 <= 1;
            b_cnt <= 0;
            rd_part <= 0;
            rd_arr <= 0;
            rq_a1 <= 0;
            rq_b1 <= 0;
            rq_f1 <= 0;
            rq_z1 <= 0;
            rq_a0 <= 0;
            rq_b0 <= 0;
            rq_f0 <= 0;
            rq_z0 <= 0;
            rq_wp <= 0;
            ri_adv <= 0;
            ri_first <= 0;
            ri_n <= 0;
            ri_lc <= 0;
            ri_beats <= 0;
            ri_addr <= 0;
            ri_nrow <= 0;
            ri_rem <= 0;
            ri_le2q <= 1;
            ri_row <= 0;
            ri_lrow <= 0;
            ri_done <= 1;
            rq_rp <= 0;
            rd_iss <= 0;
            rq_cnt <= 0;
            aw_pend <= 0;
            aw_pend_nz <= 0;
            wpa_q <= 0;
            wq_a1 <= 0;
            wq_b1 <= 0;
            wq_f1 <= 0;
            wq_z1 <= 0;
            wq_a0 <= 0;
            wq_b0 <= 0;
            wq_f0 <= 0;
            wq_z0 <= 0;
            wq_wp <= 0;
            wi_first <= 0;
            wi_n <= 0;
            wi_lc <= 0;
            wi_addr <= 0;
            wi_nrow <= 0;
            wi_rem <= 0;
            wi_row <= 0;
            wi_lrow <= 0;
            wi_done <= 1;
            wq_rp <= 0;
            wr_iss <= 0;
            wq_cnt <= 0;
            nx_v <= 0;
            nx_ns <= 0;
            nx_nd <= 0;
            nx_dlo <= 0;
            nx_hil <= 0;
            nx_last <= 0;
            nx_one <= 0;
            nx_two <= 0;
            ww_remr <= 0;
            ww_lc <= 1;
            ww_pnq <= 0;
            ww_row <= 0;
            ww_lrow <= 0;
            ww_slo <= 0;
            ww_dlo7 <= 0;
            wg_done <= 1;
            aw_rdy <= 0;
            aw_rdy_nz <= 0;
            ww_first <= 0;
            ww_rem <= 0;
            ww_one <= 0;
            ww_pops <= 0;
            ww_act <= 0;
            ww_done <= 1;
            ww_ns <= 0;
            ww_dlo <= 0;
            ww_hil <= 0;
            ww_last <= 0;
            ww_need_q <= 0;
            rel <= 0;
            reported <= 1;
            active <= 0;
            count <= 0;
            smem <= 0;
            dmem <= 0;
            nb_le <= 0;
            nb_le2 <= 1;
            scid <= 0;
            dcid <= 0;
            rows <= 0;
            nbytes <= 0;
            sstride <= 0;
            dstride <= 0;
            nb_n <= 0;
        end else begin
            cv_q <= fan_cmd_valid;
            cv_ri <= fan_cmd_valid;
            cv_wi <= fan_cmd_valid;
            cv_ww <= fan_cmd_valid;
            cv_id <= fan_cmd_valid;
            cv_g1 <= fan_cmd_valid;
            cv_g2 <= fan_cmd_valid;
            cv_c <= fan_cmd_valid;
            rv_q <= r_v;
            rv_w_0 <= r_v;
            rv_w_1 <= r_v;
            rv_w_2 <= r_v;
            rv_w_3 <= r_v;
            rlast_q <= r_last;
            rsel1 <= (cv_c ? q_smem : smem);
            rsel1x_0 <= rsel1;
            rsel1x_1 <= rsel1;
            rsel1x_2 <= rsel1;
            rsel1x_3 <= rsel1;
            rsel2_0 <= rsel1x_0;
            rsel2_1 <= rsel1x_0;
            rsel2_2 <= rsel1x_0;
            rsel2_3 <= rsel1x_0;
            rsel2_4 <= rsel1x_1;
            rsel2_5 <= rsel1x_1;
            rsel2_6 <= rsel1x_1;
            rsel2_7 <= rsel1x_1;
            rsel2_8 <= rsel1x_2;
            rsel2_9 <= rsel1x_2;
            rsel2_10 <= rsel1x_2;
            rsel2_11 <= rsel1x_2;
            rsel2_12 <= rsel1x_3;
            rsel2_13 <= rsel1x_3;
            rsel2_14 <= rsel1x_3;
            rsel2_15 <= rsel1x_3;
            a_cnt <= (a_cnt + {14'd0, a_n});
            adef <= adef_n;
            adef_hi0 <= (adef_n[15:2] == 0);
            b_cnt <= (b_cnt + {14'd0, b_n});
            if (rv_q) begin
                rd_part <= (~rlast_q);
                if (rlast_q) begin
                    rd_arr <= (rd_arr + 1);
                end
            end
            if (rd_push) begin
                if (rq_wp) begin
                    rq_a1 <= ri_addr;
                    rq_b1 <= ri_n;
                    rq_f1 <= ri_first;
                    rq_z1 <= (ri_lrow & ri_lc);
                end else begin
                    rq_a0 <= ri_addr;
                    rq_b0 <= ri_n;
                    rq_f0 <= ri_first;
                    rq_z0 <= (ri_lrow & ri_lc);
                end
                rq_wp <= (~rq_wp);
            end
            if (rd_push0) begin
                if (rq_wp) begin
                    rq_a1 <= q_saddr;
                    rq_b1 <= q_nb_n;
                    rq_f1 <= 1;
                    rq_z1 <= (q_lrow & q_nb_le);
                end else begin
                    rq_a0 <= q_saddr;
                    rq_b0 <= q_nb_n;
                    rq_f0 <= 1;
                    rq_z0 <= (q_lrow & q_nb_le);
                end
                rq_wp <= (~rq_wp);
            end
            ri_adv <= 0;
            if (ri_step) begin
                ri_first <= 0;
                ri_n <= ri_n_nx;
                ri_lc <= ri_lc_nx;
                ri_beats <= {2'd0, ri_bsum[13:7]};
                if (ri_lc) begin
                    ri_addr <= ri_nrow;
                    ri_nrow <= (ri_nrow + {12'd0, sstride});
                    ri_rem <= nbytes;
                    ri_le2q <= nb_le2;
                    ri_row <= (ri_row + 1);
                    ri_lrow <= ri_lrow_nx;
                    if (ri_lrow) begin
                        ri_done <= 1;
                    end
                end else begin
                    ri_addr <= (ri_addr + 4096);
                    ri_rem <= ri_rem_m;
                    ri_le2q <= ri_le3;
                end
            end
            if (rd_take) begin
                rq_rp <= (~rq_rp);
                rd_iss <= (rd_iss + 1);
            end
            rq_cnt <= ((rq_cnt + {1'd0, (rd_push | rd_push0)}) - {1'd0, rd_take});
            aw_pend <= aw_pend_nx;
            aw_pend_nz <= (aw_pend_nx != 0);
            wpa_q <= (act_n & (~wid_n));
            if (wr_push) begin
                if (wq_wp) begin
                    wq_a1 <= wi_addr;
                    wq_b1 <= wi_n;
                    wq_f1 <= wi_first;
                    wq_z1 <= (wi_lrow & wi_lc);
                end else begin
                    wq_a0 <= wi_addr;
                    wq_b0 <= wi_n;
                    wq_f0 <= wi_first;
                    wq_z0 <= (wi_lrow & wi_lc);
                end
                wq_wp <= (~wq_wp);
                wi_first <= 0;
                wi_n <= wi_n_nx;
                wi_lc <= wi_lc_nx;
                if (wi_lc) begin
                    wi_addr <= wi_nrow;
                    wi_nrow <= (wi_nrow + {12'd0, dstride});
                    wi_rem <= nbytes;
                    wi_row <= (wi_row + 1);
                    wi_lrow <= wi_lrow_nx;
                    if (wi_lrow) begin
                        wi_done <= 1;
                    end
                end else begin
                    wi_addr <= (wi_addr + 4096);
                    wi_rem <= wi_rem_m;
                end
            end
            if (wr_take) begin
                wq_rp <= (~wq_rp);
                wr_iss <= (wr_iss + 1);
            end
            wq_cnt <= ((wq_cnt + {1'd0, wr_push}) - {1'd0, wr_take});
            if (wg_calc) begin
                nx_v <= 1;
                nx_ns <= {2'd0, wg_ssum[13:7]};
                nx_nd <= {2'd0, wg_dsum[13:7]};
                nx_dlo <= ww_dlo7;
                nx_hil <= wg_end[6:0];
                nx_last <= (ww_lrow & ww_lastc);
                nx_one <= (wg_dsum[13:7] == 1);
                nx_two <= (wg_dsum[13:7] == 2);
                if (ww_lastc) begin
                    ww_remr <= nbytes;
                    ww_lc <= nb_le;
                    ww_pnq <= nb_n[12:0];
                    ww_row <= ww_row_p1;
                    ww_lrow <= ww_lrow_p1;
                    ww_slo <= (ww_slo + sstride[6:0]);
                    ww_dlo7 <= (ww_dlo7 + dstride[6:0]);
                    if (ww_lrow) begin
                        wg_done <= 1;
                    end
                end else begin
                    ww_remr <= ww_rem_m;
                    ww_lc <= ww_le2;
                    ww_pnq <= ww_pn_m;
                end
            end
            aw_rdy <= aw_rdy_nx;
            aw_rdy_nz <= (aw_rdy_nx != 0);
            if (emit_a) begin
                ww_first <= 0;
                ww_rem <= (ww_rem - 1);
                ww_one <= (ww_rem == 2);
                if (ww_need_q) begin
                    ww_pops <= ww_pops_inc;
                end
                if (islast) begin
                    ww_act <= 0;
                    if (ww_last) begin
                        ww_done <= 1;
                    end
                end
            end
            if (ww_start) begin
                ww_act <= 1;
                ww_first <= 1;
                ww_rem <= nx_nd;
                ww_one <= nx_one;
                ww_pops <= 0;
                ww_ns <= nx_ns;
                ww_dlo <= nx_dlo;
                ww_hil <= nx_hil;
                ww_last <= nx_last;
                nx_v <= wg_calc;
                if (emit_s) begin
                    ww_first <= 0;
                    ww_rem <= (nx_nd - 1);
                    ww_one <= nx_two;
                    ww_pops <= 1;
                    if (nx_one) begin
                        ww_act <= 0;
                        if (nx_last) begin
                            ww_done <= 1;
                        end
                    end
                end
            end
            ww_need_q <= ww_need_n;
            rel <= 0;
            if (((active & (~reported)) & all_admitted)) begin
                reported <= 1;
                rel <= 1;
            end
            if (retire) begin
                active <= 0;
                count <= (count + 1);
            end
            if (cv_c) begin
                active <= 1;
                smem <= q_smem;
                dmem <= q_dmem;
                nb_le <= q_nb_le;
                nb_le2 <= q_nb_le2;
                reported <= 0;
            end
            if (cv_id) begin
                scid <= q_scid;
                dcid <= q_dcid;
            end
            if (cv_g1) begin
                rows <= q_rows;
                nbytes <= q_bytes;
            end
            if (cv_g2) begin
                sstride <= q_sstride;
                dstride <= q_dstride;
                nb_n <= q_nb_n;
            end
            if (cv_ri) begin
                ri_addr <= q_saddr;
                ri_nrow <= q_snrow;
                ri_rem <= q_bytes;
                ri_le2q <= q_nb_le2;
                ri_row <= 0;
                ri_lrow <= q_lrow;
                ri_n <= q_nb_n;
                ri_lc <= q_nb_le;
                ri_beats <= {2'd0, q_sbsum[13:7]};
                ri_first <= 1;
                ri_adv <= rd_push0;
                ri_done <= q_empty;
            end
            if (cv_wi) begin
                wi_addr <= q_daddr;
                wi_nrow <= q_dnrow;
                wi_rem <= q_bytes;
                wi_row <= 0;
                wi_lrow <= q_lrow;
                wi_n <= q_nb_n;
                wi_lc <= q_nb_le;
                wi_first <= 1;
                wi_done <= q_empty;
            end
            if (cv_ww) begin
                ww_row <= 0;
                ww_lrow <= q_lrow;
                ww_remr <= q_bytes;
                ww_lc <= q_nb_le;
                ww_pnq <= q_nb_n[12:0];
                ww_slo <= q_saddr[6:0];
                ww_dlo7 <= q_daddr[6:0];
                ww_act <= 0;
                ww_done <= q_empty;
                wg_done <= q_empty;
                nx_v <= 0;
            end
        end
    end
    always_ff @(posedge clk) begin
        q_smem <= cmd_smem;
        q_scid <= cmd_scid;
        q_saddr <= cmd_saddr;
        q_dmem <= cmd_dmem;
        q_dcid <= cmd_dcid;
        q_daddr <= cmd_daddr;
        q_rows <= cmd_rows;
        q_bytes <= cmd_bytes;
        q_sstride <= cmd_sstride;
        q_dstride <= cmd_dstride;
        rdat_q <= rdat_d;
    end

    DmaRdFifo u_fifo (
        .clk(clk),
        .rst_n(rst_n),
        .resv((rd_push | ri_adv)),
        .resv_n(ri_beats),
        .push(rv_q),
        .pdata(rdat_q),
        .emit(emit),
        .rd(rd_src),
        .take(w_take),
        .side(side),
        .push_l_0(rv_w_0),
        .push_l_1(rv_w_1),
        .push_l_2(rv_w_2),
        .push_l_3(rv_w_3),
        .take_l_0(w_take_l_0),
        .take_l_1(w_take_l_1),
        .take_l_2(w_take_l_2),
        .take_l_3(w_take_l_3),
        .room_max(u_fifo_room_max),
        .free(u_fifo_free),
        .avail(u_fifo_avail),
        .space(u_fifo_space),
        .wv1(u_fifo_wv1),
        .wv2(u_fifo_wv2),
        .hdata(u_fifo_hdata),
        .hstb(u_fifo_hstb),
        .empty(u_fifo_empty),
        .occ(u_fifo_occ)
    );
endmodule
