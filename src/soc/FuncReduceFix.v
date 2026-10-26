module FuncReduceFix (
    input clk,
    input rst_n,
    input adv,
    input [15:0] x,
    input [7:0] es,
    input [2:0] func,
    input [15:0] kc,
    output logic [2:0] seg,
    output logic [9:0] edelta,
    output logic sgn,
    output logic [1:0] spec,
    output logic [2:0] fnq,
    output logic [15:0] xq,
    output logic [15:0] tv_o,
    output logic tc,
    output logic [20:0] ta,
    output logic [2:0] soff,
    output logic [1:0] rq
);
    logic is_sig;
    logic xsn;
    logic [15:0] xmg_n;
    logic [15:0] xmg_out;
    logic [31:0] psgn;
    logic [4:0] msb;
    logic zin;
    logic [9:0] dbase;
    logic [9:0] draw;
    logic d_neg_c;
    logic d_big_c;
    logic [5:0] dsh_c;
    logic [32:0] ds_k_c;
    logic [31:0] a_psgn;
    logic a_xsn;
    logic [15:0] a_x;
    logic [15:0] a_mg;
    logic [4:0] a_msb;
    logic a_zin;
    logic [7:0] a_es;
    logic [2:0] a_fn;
    logic a_dneg;
    logic a_dbig;
    logic [5:0] a_dsh;
    logic [32:0] a_dsm;
    logic b_trig;
    logic b_sig;
    logic b_exp;
    logic b_rsq;
    logic b_tl;
    logic d_neg;
    logic d_sat;
    logic d_big;
    logic [5:0] dsh;
    logic [32:0] pm_v;
    logic [32:0] sg_v;
    logic [32:0] src;
    logic [32:0] ds_m;
    logic [32:0] ts_l;
    logic [32:0] ts_g;
    logic [32:0] tsh;
    logic [32:0] tv;
    logic [16:0] e_n;
    logic e_of;
    logic e_uf;
    logic [9:0] e_ed;
    logic s_sat;
    logic [6:0] s_q;
    logic s_hi;
    logic [2:0] s_off;
    logic [20:0] s_ta;
    logic [1:0] t_n;
    logic tf_sn;
    logic [1:0] quad;
    logic is_sin;
    logic [2:0] t_seg;
    logic q_neg;
    logic odd_leg;
    logic t_sgn;
    logic [9:0] r_ex;
    logic [4:0] r_sh;
    logic [15:0] r_nrm;
    logic [1:0] r_q;
    logic [9:0] r_h;
    logic [9:0] r_ed;
    logic r_bad;
    logic [2:0] seg_c;
    logic tc_c;
    logic [15:0] tvx;
    logic [15:0] tv_c;
    logic [20:0] ta_c;
    logic [9:0] edelta_c;
    logic sgn_c;
    logic [1:0] sp_exp;
    logic [1:0] sp_sig;
    logic [1:0] spec_c;
    logic [2:0] b_seg;
    logic [9:0] b_edelta;
    logic b_sgn;
    logic [1:0] b_spec;
    logic [2:0] b_fnq;
    logic [15:0] b_xq;
    logic [15:0] b_tv;
    logic b_tc;
    logic [20:0] b_ta;
    logic [2:0] b_soff;
    logic [1:0] b_rq;
    logic [3:0] u_rz_msb;

    assign is_sig = (func == 3'd2);
    assign xsn = x[15];
    assign xmg_n = (x ^ {16{x[15]}});
    assign xmg_out = (xmg_n + {15'd0, x[15]});
    assign psgn = ((x * kc) - (xsn ? {kc, 16'd0} : 32'd0));
    assign msb = u_rz_msb;
    assign zin = (xmg_out == 16'd0);
    assign dbase = (is_sig ? 10'd145 : 10'd141);
    assign draw = (dbase - {2'd0, es});
    assign d_neg_c = draw[9];
    assign d_big_c = ((~d_neg_c) & (draw >= 10'd49));
    assign dsh_c = ((d_neg_c | d_big_c) ? 6'd0 : draw[5:0]);
    assign ds_k_c = (33'd8589934591 >> dsh_c);
    assign b_trig = ((a_fn == 3'd3) | (a_fn == 3'd4));
    assign b_sig = (a_fn == 3'd2);
    assign b_exp = (a_fn == 3'd1);
    assign b_rsq = (a_fn == 3'd0);
    assign b_tl = (~((b_rsq | b_exp) | b_sig));
    assign d_neg = a_dneg;
    assign d_sat = (d_neg & (~a_zin));
    assign d_big = a_dbig;
    assign dsh = a_dsh;
    assign pm_v = {a_psgn[31], a_psgn};
    assign sg_v = ({17'd0, a_mg} << 15);
    assign src = (b_sig ? sg_v : pm_v);
    assign ds_m = a_dsm;
    assign ts_l = (src >> dsh);
    assign ts_g = (ts_l | ds_m);
    assign tsh = (src[32] ? ts_g : ts_l);
    assign tv = (d_big ? 33'd0 : tsh);
    assign e_n = tv[32:16];
    assign e_of = ((~e_n[16]) & (e_n >= 17'd128));
    assign e_uf = (e_n[16] & (e_n < 17'd130944));
    assign e_ed = e_n[9:0];
    assign s_sat = (tv[32:16] != 17'd0);
    assign s_q = ({1'd0, a_dsh} - {2'd0, a_msb});
    assign s_hi = ((((~a_zin) & (~a_dbig)) & (s_q[6:3] == 4'd0)) & (s_q[2:0] <= 3'd5));
    assign s_off = (s_hi ? (3'd6 - s_q[2:0]) : 3'd0);
    assign s_ta = (s_hi ? (21'd32768 << s_q[2:0]) : 21'd1048576);
    assign t_n = (tv[17:16] + {1'd0, tv[15]});
    assign tf_sn = tv[15];
    assign quad = t_n;
    assign is_sin = (a_fn == 3'd4);
    assign t_seg = (is_sin ? (quad[0] ? 3'd3 : 3'd4) : (quad[0] ? 3'd4 : 3'd3));
    assign q_neg = (is_sin ? quad[1] : (quad[1] ^ quad[0]));
    assign odd_leg = (quad[0] ^ is_sin);
    assign t_sgn = (q_neg ^ (odd_leg & tf_sn));
    assign r_ex = (({2'd0, a_es} + {5'd0, a_msb}) - 10'd142);
    assign r_sh = (5'd15 - a_msb);
    assign r_nrm = (a_mg << r_sh[3:0]);
    assign r_q = {(a_es[0] ^ a_msb[0]), r_nrm[14]};
    assign r_h = {r_ex[9], r_ex[9:1]};
    assign r_ed = (10'd0 - r_h);
    assign r_bad = (a_xsn | a_zin);
    assign seg_c = (b_rsq ? 3'd1 : (b_exp ? 3'd0 : (b_sig ? 3'd2 : t_seg)));
    assign tc_c = (b_tl & tf_sn);
    assign tvx = (tv[15:0] ^ {16{tc_c}});
    assign tv_c = (b_rsq ? r_nrm : tvx);
    assign ta_c = (b_exp ? 21'd16384 : (b_rsq ? 21'd65536 : (b_sig ? s_ta : 21'd25736)));
    assign edelta_c = (b_rsq ? r_ed : (b_exp ? e_ed : 10'd0));
    assign sgn_c = (b_trig ? t_sgn : 1'd0);
    assign sp_exp = ((e_of | (d_sat & (~a_xsn))) ? 2'd3 : ((e_uf | (d_sat & a_xsn)) ? 2'd1 : 2'd0));
    assign sp_sig = ((s_sat | d_sat) ? (a_xsn ? 2'd1 : 2'd2) : 2'd0);
    assign spec_c = (b_rsq ? (r_bad ? 2'd3 : 2'd0) : (b_exp ? sp_exp : (b_sig ? sp_sig : (d_sat ? 2'd1 : 2'd0))));
    assign seg = b_seg;
    assign edelta = b_edelta;
    assign sgn = b_sgn;
    assign spec = b_spec;
    assign fnq = b_fnq;
    assign xq = b_xq;
    assign tv_o = b_tv;
    assign tc = b_tc;
    assign ta = b_ta;
    assign soff = b_soff;
    assign rq = b_rq;
    always_ff @(posedge clk) begin
        if (adv) begin
            a_psgn <= psgn;
            a_xsn <= xsn;
            a_x <= x;
            a_mg <= xmg_out;
            a_msb <= msb;
            a_zin <= zin;
            a_es <= es;
            a_fn <= func;
            a_dneg <= d_neg_c;
            a_dbig <= d_big_c;
            a_dsh <= dsh_c;
            a_dsm <= (~ds_k_c);
            b_seg <= seg_c;
            b_edelta <= edelta_c;
            b_sgn <= sgn_c;
            b_spec <= spec_c;
            b_fnq <= a_fn;
            b_xq <= a_x;
            b_tv <= tv_c;
            b_tc <= tc_c;
            b_ta <= ta_c;
            b_soff <= s_off;
            b_rq <= r_q;
        end
    end

    Lzd_N16 u_rz (
        .src(xmg_out),
        .msb(u_rz_msb)
    );
endmodule
