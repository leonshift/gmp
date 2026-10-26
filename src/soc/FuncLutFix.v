module FuncLutFix (
    input clk,
    input rst_n,
    input adv,
    input [15:0] x,
    input [7:0] es,
    input [2:0] func,
    input [15:0] kc,
    input en,
    output logic [18:0] m,
    output logic [8:0] ed,
    output logic sgn,
    output logic valid
);
    logic e1_v;
    logic e2_v;
    logic r_exp;
    logic r_rsq;
    logic r_sig;
    logic r_sin;
    logic [36:0] r_raw;
    logic [3:0] gid_c;
    logic [23:0] c6_c;
    logic [9:0] ed_c;
    logic f1_v;
    logic [15:0] f1_t;
    logic [3:0] f1_g;
    logic [23:0] f1_c6;
    logic [9:0] f1_ed;
    logic f1_sgn;
    logic [1:0] f1_spec;
    logic f1_sig;
    logic f1_pos;
    logic h_v_0;
    logic h_v_1;
    logic h_v_2;
    logic h_v_3;
    logic h_v_4;
    logic h_v_5;
    logic [15:0] h_t_0;
    logic [15:0] h_t_1;
    logic [15:0] h_t_2;
    logic [15:0] h_t_3;
    logic [15:0] h_t_4;
    logic [15:0] h_t_5;
    logic [3:0] h_g_0;
    logic [3:0] h_g_1;
    logic [3:0] h_g_2;
    logic [3:0] h_g_3;
    logic [3:0] h_g_4;
    logic [3:0] h_g_5;
    logic [23:0] h_acc_0;
    logic [23:0] h_acc_1;
    logic [23:0] h_acc_2;
    logic [23:0] h_acc_3;
    logic [23:0] h_acc_4;
    logic [23:0] h_acc_5;
    logic [9:0] h_ed_0;
    logic [9:0] h_ed_1;
    logic [9:0] h_ed_2;
    logic [9:0] h_ed_3;
    logic [9:0] h_ed_4;
    logic [9:0] h_ed_5;
    logic h_sgn_0;
    logic h_sgn_1;
    logic h_sgn_2;
    logic h_sgn_3;
    logic h_sgn_4;
    logic h_sgn_5;
    logic [1:0] h_spec_0;
    logic [1:0] h_spec_1;
    logic [1:0] h_spec_2;
    logic [1:0] h_spec_3;
    logic [1:0] h_spec_4;
    logic [1:0] h_spec_5;
    logic h_sig_0;
    logic h_sig_1;
    logic h_sig_2;
    logic h_sig_3;
    logic h_sig_4;
    logic h_sig_5;
    logic h_pos_0;
    logic h_pos_1;
    logic h_pos_2;
    logic h_pos_3;
    logic h_pos_4;
    logic h_pos_5;
    logic [15:0] hi_t_0;
    logic [15:0] hi_t_1;
    logic [15:0] hi_t_2;
    logic [15:0] hi_t_3;
    logic [15:0] hi_t_4;
    logic [15:0] hi_t_5;
    logic [3:0] hi_g_0;
    logic [3:0] hi_g_1;
    logic [3:0] hi_g_2;
    logic [3:0] hi_g_3;
    logic [3:0] hi_g_4;
    logic [3:0] hi_g_5;
    logic [23:0] hi_acc_0;
    logic [23:0] hi_acc_1;
    logic [23:0] hi_acc_2;
    logic [23:0] hi_acc_3;
    logic [23:0] hi_acc_4;
    logic [23:0] hi_acc_5;
    logic [39:0] hp_0;
    logic [39:0] hp_1;
    logic [39:0] hp_2;
    logic [39:0] hp_3;
    logic [39:0] hp_4;
    logic [39:0] hp_5;
    logic [23:0] hs_0;
    logic [23:0] hs_1;
    logic [23:0] hs_2;
    logic [23:0] hs_3;
    logic [23:0] hs_4;
    logic [23:0] hs_5;
    logic [39:0] hc_0;
    logic [39:0] hc_1;
    logic [39:0] hc_2;
    logic [39:0] hc_3;
    logic [39:0] hc_4;
    logic [39:0] hc_5;
    logic [16:0] h_tn;
    logic [39:0] hci;
    logic [39:0] hpi;
    logic [18:0] h_inv;
    logic y_neg;
    logic [19:0] y_q;
    logic y_inv;
    logic [18:0] f3_val;
    logic n_z;
    logic [31:0] f3_pad;
    logic [4:0] n_sh;
    logic g_v;
    logic [18:0] g_f3;
    logic [4:0] g_sh;
    logic g_nz;
    logic [9:0] g_ed;
    logic [1:0] g_spec;
    logic g_sgn;
    logic [9:0] n_edr;
    logic n_zn;
    logic [18:0] n_m;
    logic [8:0] n_ed;
    logic [18:0] n_mm;
    logic sp_z;
    logic sp_o;
    logic sp_m;
    logic [18:0] o_m;
    logic [8:0] o_ed;
    logic f4_v;
    logic [18:0] f4_m;
    logic [8:0] f4_ed;
    logic f4_s;
    logic [2:0] u_red_seg;
    logic [20:0] u_red_ta;
    logic [15:0] u_red_tv_o;
    logic u_red_tc;
    logic [1:0] u_red_rq;
    logic [2:0] u_red_soff;
    logic [9:0] u_red_edelta;
    logic [39:0] u_hp_0_p;
    logic [39:0] u_hp_1_p;
    logic [39:0] u_hp_2_p;
    logic [39:0] u_hp_3_p;
    logic [39:0] u_hp_4_p;
    logic [39:0] u_hp_5_p;
    logic [39:0] u_hpi_p;
    logic [4:0] u_nz_msb;
    logic u_red_sgn;
    logic [1:0] u_red_spec;
    logic [2:0] u_red_fnq;
    logic [15:0] u_red_xq;

    assign r_exp = (u_red_seg == 3'd0);
    assign r_rsq = (u_red_seg == 3'd1);
    assign r_sig = (u_red_seg == 3'd2);
    assign r_sin = (u_red_seg == 3'd4);
    assign r_raw = ((u_red_ta * u_red_tv_o) + (u_red_tc ? 37'd25736 : 37'd0));
    assign gid_c = (r_exp ? 4'd0 :
                   (r_rsq ? (4'd1 + {2'd0, u_red_rq}) :
                   (r_sig ? (4'd7 + {1'd0, u_red_soff}) :
                   (r_sin ? 4'd6 :
                   4'd5))));
    assign c6_c = ((gid_c == 0) ? 24'd917 :
                  ((gid_c == 1) ? 24'd3687 :
                  ((gid_c == 2) ? 24'd401 :
                  ((gid_c == 3) ? 24'd2607 :
                  ((gid_c == 4) ? 24'd284 :
                  ((gid_c == 5) ? 24'd16772144 :
                  ((gid_c == 6) ? 24'd16774445 :
                  ((gid_c == 7) ? 24'd0 :
                  ((gid_c == 8) ? 24'd0 :
                  ((gid_c == 9) ? 24'd35 :
                  ((gid_c == 10) ? 24'd69 :
                  ((gid_c == 11) ? 24'd16761506 :
                  ((gid_c == 12) ? 24'd52439 :
                  24'd15246)))))))))))));
    assign ed_c = (u_red_edelta + 10'd147);
    assign hi_t_0 = f1_t;
    assign hi_g_0 = f1_g;
    assign hi_acc_0 = f1_c6;
    assign hc_0 = {((hi_g_0 == 0) ? 24'd5197 :
                   ((hi_g_0 == 1) ? 24'd16756110 :
                   ((hi_g_0 == 2) ? 24'd16774480 :
                   ((hi_g_0 == 3) ? 24'd16762292 :
                   ((hi_g_0 == 4) ? 24'd16775281 :
                   ((hi_g_0 == 5) ? 24'd16775850 :
                   ((hi_g_0 == 6) ? 24'd38669 :
                   ((hi_g_0 == 7) ? 24'd16777207 :
                   ((hi_g_0 == 8) ? 24'd16777208 :
                   ((hi_g_0 == 9) ? 24'd16777071 :
                   ((hi_g_0 == 10) ? 24'd3836 :
                   ((hi_g_0 == 11) ? 24'd56276 :
                   ((hi_g_0 == 12) ? 24'd16528090 :
                   24'd16718226))))))))))))), 16'd0};
    assign hp_0 = u_hp_0_p;
    assign hs_0 = hp_0[39:16];
    assign hi_t_1 = h_t_0;
    assign hi_g_1 = h_g_0;
    assign hi_acc_1 = h_acc_0;
    assign hc_1 = {((hi_g_1 == 0) ? 24'd40618 :
                   ((hi_g_1 == 1) ? 24'd65168 :
                   ((hi_g_1 == 2) ? 24'd11111 :
                   ((hi_g_1 == 3) ? 24'd46081 :
                   ((hi_g_1 == 4) ? 24'd7856 :
                   ((hi_g_1 == 5) ? 24'd175800 :
                   ((hi_g_1 == 6) ? 24'd16774718 :
                   ((hi_g_1 == 7) ? 24'd0 :
                   ((hi_g_1 == 8) ? 24'd16777175 :
                   ((hi_g_1 == 9) ? 24'd16776069 :
                   ((hi_g_1 == 10) ? 24'd16754288 :
                   ((hi_g_1 == 11) ? 24'd16747892 :
                   ((hi_g_1 == 12) ? 24'd532444 :
                   24'd93919))))))))))))), 16'd0};
    assign hp_1 = u_hp_1_p;
    assign hs_1 = hp_1[39:16];
    assign hi_t_2 = h_t_1;
    assign hi_g_2 = h_g_1;
    assign hi_acc_2 = h_acc_1;
    assign hc_2 = {((hi_g_2 == 0) ? 24'd232703 :
                   ((hi_g_2 == 1) ? 24'd16615469 :
                   ((hi_g_2 == 2) ? 24'd16737728 :
                   ((hi_g_2 == 3) ? 24'd16662844 :
                   ((hi_g_2 == 4) ? 24'd16749294 :
                   ((hi_g_2 == 5) ? 24'd16776833 :
                   ((hi_g_2 == 6) ? 24'd16079032 :
                   ((hi_g_2 == 7) ? 24'd1365 :
                   ((hi_g_2 == 8) ? 24'd1282 :
                   ((hi_g_2 == 9) ? 24'd8421 :
                   ((hi_g_2 == 10) ? 24'd25152 :
                   ((hi_g_2 == 11) ? 24'd16549841 :
                   ((hi_g_2 == 12) ? 24'd16096565 :
                   24'd16697377))))))))))))), 16'd0};
    assign hp_2 = u_hp_2_p;
    assign hs_2 = hp_2[39:16];
    assign hi_t_3 = h_t_2;
    assign hi_g_3 = h_g_2;
    assign hi_acc_3 = h_acc_2;
    assign hc_3 = {((hi_g_3 == 0) ? 24'd1007600 :
                   ((hi_g_3 == 1) ? 24'd392883 :
                   ((hi_g_3 == 2) ? 24'd142669 :
                   ((hi_g_3 == 3) ? 24'd277811 :
                   ((hi_g_3 == 4) ? 24'd100882 :
                   ((hi_g_3 == 5) ? 24'd14680130 :
                   ((hi_g_3 == 6) ? 24'd16777072 :
                   ((hi_g_3 == 7) ? 24'd0 :
                   ((hi_g_3 == 8) ? 24'd4012 :
                   ((hi_g_3 == 9) ? 24'd30176 :
                   ((hi_g_3 == 10) ? 24'd190467 :
                   ((hi_g_3 == 11) ? 24'd672452 :
                   ((hi_g_3 == 12) ? 24'd566918 :
                   24'd39174))))))))))))), 16'd0};
    assign hp_3 = u_hp_3_p;
    assign hs_3 = hp_3[39:16];
    assign hi_t_4 = h_t_3;
    assign hi_g_4 = h_g_3;
    assign hi_acc_4 = h_acc_3;
    assign hc_4 = {((hi_g_4 == 0) ? 24'd2907269 :
                   ((hi_g_4 == 1) ? 24'd15728660 :
                   ((hi_g_4 == 2) ? 24'd16206445 :
                   ((hi_g_4 == 3) ? 24'd16035775 :
                   ((hi_g_4 == 4) ? 24'd16373620 :
                   ((hi_g_4 == 5) ? 24'd16777212 :
                   ((hi_g_4 == 6) ? 24'd4194313 :
                   ((hi_g_4 == 7) ? 24'd16515072 :
                   ((hi_g_4 == 8) ? 24'd16519126 :
                   ((hi_g_4 == 9) ? 24'd16284378 :
                   ((hi_g_4 == 10) ? 24'd15952570 :
                   ((hi_g_4 == 11) ? 24'd15896361 :
                   ((hi_g_4 == 12) ? 24'd16481164 :
                   24'd16766305))))))))))))), 16'd0};
    assign hp_4 = u_hp_4_p;
    assign hs_4 = hp_4[39:16];
    assign hi_t_5 = h_t_4;
    assign hi_g_5 = h_g_4;
    assign hi_acc_5 = h_acc_4;
    assign hc_5 = {((hi_g_5 == 0) ? 24'd4194312 :
                   ((hi_g_5 == 1) ? 24'd4194312 :
                   ((hi_g_5 == 2) ? 24'd3424643 :
                   ((hi_g_5 == 3) ? 24'd2965829 :
                   ((hi_g_5 == 4) ? 24'd2421591 :
                   ((hi_g_5 == 5) ? 24'd4194312 :
                   ((hi_g_5 == 6) ? 24'd8 :
                   ((hi_g_5 == 7) ? 24'd2097160 :
                   ((hi_g_5 == 8) ? 24'd1836373 :
                   ((hi_g_5 == 9) ? 24'd1583528 :
                   ((hi_g_5 == 10) ? 24'd1128030 :
                   ((hi_g_5 == 11) ? 24'd499982 :
                   ((hi_g_5 == 12) ? 24'd75445 :
                   24'd1411))))))))))))), 16'd0};
    assign hp_5 = u_hp_5_p;
    assign hs_5 = hp_5[39:16];
    assign hci = ((hi_g_5 == 0) ? 40'd524287 :
                 ((hi_g_5 == 1) ? 40'd524287 :
                 ((hi_g_5 == 2) ? 40'd50441551871 :
                 ((hi_g_5 == 3) ? 40'd80510386175 :
                 ((hi_g_5 == 4) ? 40'd116177567743 :
                 ((hi_g_5 == 5) ? 40'd524287 :
                 ((hi_g_5 == 6) ? 40'd274878431231 :
                 ((hi_g_5 == 7) ? 40'd137439477759 :
                 ((hi_g_5 == 8) ? 40'd154530414591 :
                 ((hi_g_5 == 9) ? 40'd171100864511 :
                 ((hi_g_5 == 10) ? 40'd200952381439 :
                 ((hi_g_5 == 11) ? 40'd242112135167 :
                 ((hi_g_5 == 12) ? 40'd269934591999 :
                 40'd274786484223)))))))))))));
    assign hpi = u_hpi_p;
    assign y_neg = h_acc_5[23];
    assign y_q = h_acc_5[23:4];
    assign y_inv = (h_sig_5 & h_pos_5);
    assign f3_val = (y_neg ? (y_inv ? 19'd262144 : 19'd0) : (y_inv ? h_inv : y_q[18:0]));
    assign n_z = (f3_val == 19'd0);
    assign f3_pad = {f3_val, 13'd0};
    assign n_sh = (~u_nz_msb);
    assign n_edr = (g_ed - {5'd0, g_sh});
    assign n_zn = (n_edr[9] | (~g_nz));
    assign n_m = (g_f3 << g_sh);
    assign n_ed = (n_zn ? 9'd0 : n_edr[8:0]);
    assign n_mm = (n_zn ? 19'd0 : n_m);
    assign sp_z = (g_spec == 2'd1);
    assign sp_o = (g_spec == 2'd2);
    assign sp_m = (g_spec == 2'd3);
    assign o_m = (sp_z ? 19'd0 : (sp_o ? 19'd262144 : (sp_m ? 19'd524287 : n_mm)));
    assign o_ed = (sp_z ? 9'd0 : (sp_o ? 9'd147 : (sp_m ? 9'd274 : n_ed)));
    assign m = f4_m;
    assign ed = f4_ed;
    assign sgn = f4_s;
    assign valid = f4_v;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            e1_v <= 0;
            e2_v <= 0;
            f1_v <= 0;
            h_v_0 <= 0;
            h_v_1 <= 0;
            h_v_2 <= 0;
            h_v_3 <= 0;
            h_v_4 <= 0;
            h_v_5 <= 0;
            g_v <= 0;
            f4_v <= 0;
        end else begin
            if (adv) begin
                e1_v <= en;
                e2_v <= e1_v;
                f1_v <= e2_v;
                h_v_0 <= f1_v;
                h_v_1 <= h_v_0;
                h_v_2 <= h_v_1;
                h_v_3 <= h_v_2;
                h_v_4 <= h_v_3;
                h_v_5 <= h_v_4;
                g_v <= h_v_5;
                f4_v <= g_v;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (adv) begin
            f1_t <= r_raw[29:14];
            f1_g <= gid_c;
            f1_c6 <= c6_c;
            f1_ed <= ed_c;
            f1_sgn <= u_red_sgn;
            f1_spec <= u_red_spec;
            f1_sig <= (u_red_fnq == 3'd2);
            f1_pos <= (~u_red_xq[15]);
            h_acc_0 <= hs_0;
            h_t_0 <= hi_t_0;
            h_g_0 <= hi_g_0;
            h_ed_0 <= f1_ed;
            h_sgn_0 <= f1_sgn;
            h_spec_0 <= f1_spec;
            h_sig_0 <= f1_sig;
            h_pos_0 <= f1_pos;
            h_acc_1 <= hs_1;
            h_t_1 <= hi_t_1;
            h_g_1 <= hi_g_1;
            h_ed_1 <= h_ed_0;
            h_sgn_1 <= h_sgn_0;
            h_spec_1 <= h_spec_0;
            h_sig_1 <= h_sig_0;
            h_pos_1 <= h_pos_0;
            h_acc_2 <= hs_2;
            h_t_2 <= hi_t_2;
            h_g_2 <= hi_g_2;
            h_ed_2 <= h_ed_1;
            h_sgn_2 <= h_sgn_1;
            h_spec_2 <= h_spec_1;
            h_sig_2 <= h_sig_1;
            h_pos_2 <= h_pos_1;
            h_acc_3 <= hs_3;
            h_t_3 <= hi_t_3;
            h_g_3 <= hi_g_3;
            h_ed_3 <= h_ed_2;
            h_sgn_3 <= h_sgn_2;
            h_spec_3 <= h_spec_2;
            h_sig_3 <= h_sig_2;
            h_pos_3 <= h_pos_2;
            h_acc_4 <= hs_4;
            h_t_4 <= hi_t_4;
            h_g_4 <= hi_g_4;
            h_ed_4 <= h_ed_3;
            h_sgn_4 <= h_sgn_3;
            h_spec_4 <= h_spec_3;
            h_sig_4 <= h_sig_3;
            h_pos_4 <= h_pos_3;
            h_acc_5 <= hs_5;
            h_t_5 <= hi_t_5;
            h_g_5 <= hi_g_5;
            h_ed_5 <= h_ed_4;
            h_sgn_5 <= h_sgn_4;
            h_spec_5 <= h_spec_4;
            h_sig_5 <= h_sig_4;
            h_pos_5 <= h_pos_4;
            h_tn <= (17'd0 - {1'd0, hi_t_4});
            h_inv <= hpi[38:20];
            g_f3 <= f3_val;
            g_sh <= n_sh;
            g_nz <= (~n_z);
            g_ed <= h_ed_5;
            g_spec <= h_spec_5;
            g_sgn <= h_sgn_5;
            f4_m <= o_m;
            f4_ed <= o_ed;
            f4_s <= g_sgn;
        end
    end

    FuncReduceFix u_red (
        .clk(clk),
        .rst_n(rst_n),
        .adv(adv),
        .x(x),
        .es(es),
        .func(func),
        .kc(kc),
        .seg(u_red_seg),
        .ta(u_red_ta),
        .tv_o(u_red_tv_o),
        .tc(u_red_tc),
        .rq(u_red_rq),
        .soff(u_red_soff),
        .edelta(u_red_edelta),
        .sgn(u_red_sgn),
        .spec(u_red_spec),
        .fnq(u_red_fnq),
        .xq(u_red_xq)
    );
    SMul24x16 u_hp_0 (
        .a(hi_acc_0),
        .b(hi_t_0),
        .c(hc_0),
        .p(u_hp_0_p)
    );
    SMul24x16 u_hp_1 (
        .a(hi_acc_1),
        .b(hi_t_1),
        .c(hc_1),
        .p(u_hp_1_p)
    );
    SMul24x16 u_hp_2 (
        .a(hi_acc_2),
        .b(hi_t_2),
        .c(hc_2),
        .p(u_hp_2_p)
    );
    SMul24x16 u_hp_3 (
        .a(hi_acc_3),
        .b(hi_t_3),
        .c(hc_3),
        .p(u_hp_3_p)
    );
    SMul24x16 u_hp_4 (
        .a(hi_acc_4),
        .b(hi_t_4),
        .c(hc_4),
        .p(u_hp_4_p)
    );
    SMul24x16 u_hp_5 (
        .a(hi_acc_5),
        .b(hi_t_5),
        .c(hc_5),
        .p(u_hp_5_p)
    );
    SMul24x18 u_hpi (
        .a(hi_acc_5),
        .b({h_tn[16], h_tn}),
        .c(hci),
        .p(u_hpi_p)
    );
    Lzd u_nz (
        .src(f3_pad),
        .msb(u_nz_msb)
    );
endmodule
