module ReduceFix64 (
    input clk,
    input rst_n,
    input hold,
    input [1023:0] x,
    input [7:0] xe,
    input [19:0] mi,
    output logic [1023:0] bf,
    output logic [7:0] be,
    output logic [19:0] bm,
    output logic [31:0] res,
    output logic [19:0] mo,
    output logic obusy
);
    logic [511:0] x0;
    logic [7:0] x0e;
    logic ph0;
    logic [19:0] mt0;
    logic [511:0] xlo;
    logic [511:0] xhi;
    logic [511:0] xsel;
    logic [19:0] mt1c;
    logic [7:0] ea1c;
    logic [15:0] xl_0;
    logic [15:0] xl_1;
    logic [15:0] xl_2;
    logic [15:0] xl_3;
    logic [15:0] xl_4;
    logic [15:0] xl_5;
    logic [15:0] xl_6;
    logic [15:0] xl_7;
    logic [15:0] xl_8;
    logic [15:0] xl_9;
    logic [15:0] xl_10;
    logic [15:0] xl_11;
    logic [15:0] xl_12;
    logic [15:0] xl_13;
    logic [15:0] xl_14;
    logic [15:0] xl_15;
    logic [15:0] xl_16;
    logic [15:0] xl_17;
    logic [15:0] xl_18;
    logic [15:0] xl_19;
    logic [15:0] xl_20;
    logic [15:0] xl_21;
    logic [15:0] xl_22;
    logic [15:0] xl_23;
    logic [15:0] xl_24;
    logic [15:0] xl_25;
    logic [15:0] xl_26;
    logic [15:0] xl_27;
    logic [15:0] xl_28;
    logic [15:0] xl_29;
    logic [15:0] xl_30;
    logic [15:0] xl_31;
    logic [21:0] xs_0;
    logic [21:0] xs_1;
    logic [21:0] xs_2;
    logic [21:0] xs_3;
    logic [21:0] xs_4;
    logic [21:0] xs_5;
    logic [21:0] xs_6;
    logic [21:0] xs_7;
    logic [21:0] xs_8;
    logic [21:0] xs_9;
    logic [21:0] xs_10;
    logic [21:0] xs_11;
    logic [21:0] xs_12;
    logic [21:0] xs_13;
    logic [21:0] xs_14;
    logic [21:0] xs_15;
    logic [21:0] xs_16;
    logic [21:0] xs_17;
    logic [21:0] xs_18;
    logic [21:0] xs_19;
    logic [21:0] xs_20;
    logic [21:0] xs_21;
    logic [21:0] xs_22;
    logic [21:0] xs_23;
    logic [21:0] xs_24;
    logic [21:0] xs_25;
    logic [21:0] xs_26;
    logic [21:0] xs_27;
    logic [21:0] xs_28;
    logic [21:0] xs_29;
    logic [21:0] xs_30;
    logic [21:0] xs_31;
    logic [703:0] s0w;
    logic [703:0] st_0_s;
    logic [511:0] st_0_m;
    logic [19:0] st_0_mt;
    logic [7:0] st_0_ea;
    logic st_0_pv;
    logic [351:0] st_1_s;
    logic [255:0] st_1_m;
    logic [19:0] st_1_mt;
    logic [7:0] st_1_ea;
    logic st_1_pv;
    logic [175:0] st_2_s;
    logic [127:0] st_2_m;
    logic [19:0] st_2_mt;
    logic [7:0] st_2_ea;
    logic st_2_pv;
    logic [87:0] st_3_s;
    logic [63:0] st_3_m;
    logic [19:0] st_3_mt;
    logic [7:0] st_3_ea;
    logic st_3_pv;
    logic [43:0] st_4_s;
    logic [31:0] st_4_m;
    logic [19:0] st_4_mt;
    logic [7:0] st_4_ea;
    logic st_4_pv;
    logic [21:0] st_5_s;
    logic [15:0] st_5_m;
    logic [19:0] st_5_mt;
    logic [7:0] st_5_ea;
    logic st_5_pv;
    logic [21:0] s7;
    logic [15:0] m7;
    logic [19:0] mt7;
    logic [7:0] ea7;
    logic [21:0] half_s;
    logic [15:0] half_m;
    logic [19:0] mt8;
    logic [31:0] res8;
    logic [351:0] sn_0;
    logic [175:0] sn_1;
    logic [87:0] sn_2;
    logic [43:0] sn_3;
    logic [21:0] sn_4;
    logic [255:0] mn_0;
    logic [127:0] mn_1;
    logic [63:0] mn_2;
    logic [31:0] mn_3;
    logic [15:0] mn_4;
    logic [21:0] s6v;
    logic [15:0] m6v;
    logic [1:0] kd6;
    logic ismin6;
    logic [21:0] s7c;
    logic lt6;
    logic [15:0] m7c;
    logic [21:0] s7_ag_n;
    logic [21:0] s7_ag_out;
    logic [15:0] m7_ag_n;
    logic [15:0] m7_ag_out;
    logic [21:0] s7_mg;
    logic [15:0] m7_mg;
    logic bh;
    logic bhs;
    logic bhm;
    logic [21:0] bsv_s;
    logic [21:0] bmx_s;
    logic [21:0] bselw;
    logic [7:0] beaw;
    logic [19:0] bmtw;
    logic [21:0] bsel_ag_n;
    logic [21:0] bsel_ag_out;
    logic [21:0] ba_s;
    logic [21:0] ba_mg;
    logic [7:0] ba_e;
    logic [19:0] ba_mt;
    logic [21:0] bhi;
    logic bnz;
    logic [4:0] bmsb;
    logic [10:0] beraw;
    logic be_hi;
    logic be_lo;
    logic [7:0] becl;
    logic bzs;
    logic bs_pos;
    logic [4:0] blsh_n;
    logic [4:0] brsh_n;
    logic [3:0] blsh;
    logic [2:0] brsh;
    logic [14:0] bloh;
    logic [1:0] bosel;
    logic [7:0] becz;
    logic [28:0] bxe;
    logic [15:0] bro_0;
    logic [15:0] bro_1;
    logic [15:0] bro_2;
    logic [15:0] bro_3;
    logic [15:0] bro_4;
    logic [15:0] bro_5;
    logic [15:0] bro_6;
    logic [15:0] bro_7;
    logic [15:0] brr;
    logic [15:0] bst;
    logic bxz;
    logic [15:0] bsa;
    logic [15:0] bcs;
    logic [21:0] bb_x;
    logic [14:0] bb_oh;
    logic [15:0] bb_c;
    logic [7:0] bb_e;
    logic [19:0] bb_mt;
    logic [36:0] bpm;
    logic [15:0] bfo;
    logic [1:0] kd7;
    logic [31:0] outw;
    logic [351:0] u_lv_0_s_out;
    logic [255:0] u_lv_0_m_out;
    logic [175:0] u_lv_1_s_out;
    logic [127:0] u_lv_1_m_out;
    logic [87:0] u_lv_2_s_out;
    logic [63:0] u_lv_2_m_out;
    logic [43:0] u_lv_3_s_out;
    logic [31:0] u_lv_3_m_out;
    logic [21:0] u_lv_4_s_out;
    logic [15:0] u_lv_4_m_out;
    logic [4:0] u_bxlz_msb;
    logic [31:0] u_sumf_res;
    logic [31:0] u_mmf_res;

    assign xlo = x[511:0];
    assign xhi = x[1023:512];
    assign xsel = (ph0 ? x0 : xlo);
    assign mt1c = (ph0 ? mt0 : {mi[19:1], 1'd0});
    assign ea1c = (ph0 ? x0e : xe);
    assign xl_0 = xsel[15:0];
    assign xs_0 = {xl_0[15], xl_0[15], xl_0[15], xl_0[15], xl_0[15], xl_0[15], xl_0};
    assign xl_1 = xsel[31:16];
    assign xs_1 = {xl_1[15], xl_1[15], xl_1[15], xl_1[15], xl_1[15], xl_1[15], xl_1};
    assign xl_2 = xsel[47:32];
    assign xs_2 = {xl_2[15], xl_2[15], xl_2[15], xl_2[15], xl_2[15], xl_2[15], xl_2};
    assign xl_3 = xsel[63:48];
    assign xs_3 = {xl_3[15], xl_3[15], xl_3[15], xl_3[15], xl_3[15], xl_3[15], xl_3};
    assign xl_4 = xsel[79:64];
    assign xs_4 = {xl_4[15], xl_4[15], xl_4[15], xl_4[15], xl_4[15], xl_4[15], xl_4};
    assign xl_5 = xsel[95:80];
    assign xs_5 = {xl_5[15], xl_5[15], xl_5[15], xl_5[15], xl_5[15], xl_5[15], xl_5};
    assign xl_6 = xsel[111:96];
    assign xs_6 = {xl_6[15], xl_6[15], xl_6[15], xl_6[15], xl_6[15], xl_6[15], xl_6};
    assign xl_7 = xsel[127:112];
    assign xs_7 = {xl_7[15], xl_7[15], xl_7[15], xl_7[15], xl_7[15], xl_7[15], xl_7};
    assign xl_8 = xsel[143:128];
    assign xs_8 = {xl_8[15], xl_8[15], xl_8[15], xl_8[15], xl_8[15], xl_8[15], xl_8};
    assign xl_9 = xsel[159:144];
    assign xs_9 = {xl_9[15], xl_9[15], xl_9[15], xl_9[15], xl_9[15], xl_9[15], xl_9};
    assign xl_10 = xsel[175:160];
    assign xs_10 = {xl_10[15], xl_10[15], xl_10[15], xl_10[15], xl_10[15], xl_10[15], xl_10};
    assign xl_11 = xsel[191:176];
    assign xs_11 = {xl_11[15], xl_11[15], xl_11[15], xl_11[15], xl_11[15], xl_11[15], xl_11};
    assign xl_12 = xsel[207:192];
    assign xs_12 = {xl_12[15], xl_12[15], xl_12[15], xl_12[15], xl_12[15], xl_12[15], xl_12};
    assign xl_13 = xsel[223:208];
    assign xs_13 = {xl_13[15], xl_13[15], xl_13[15], xl_13[15], xl_13[15], xl_13[15], xl_13};
    assign xl_14 = xsel[239:224];
    assign xs_14 = {xl_14[15], xl_14[15], xl_14[15], xl_14[15], xl_14[15], xl_14[15], xl_14};
    assign xl_15 = xsel[255:240];
    assign xs_15 = {xl_15[15], xl_15[15], xl_15[15], xl_15[15], xl_15[15], xl_15[15], xl_15};
    assign xl_16 = xsel[271:256];
    assign xs_16 = {xl_16[15], xl_16[15], xl_16[15], xl_16[15], xl_16[15], xl_16[15], xl_16};
    assign xl_17 = xsel[287:272];
    assign xs_17 = {xl_17[15], xl_17[15], xl_17[15], xl_17[15], xl_17[15], xl_17[15], xl_17};
    assign xl_18 = xsel[303:288];
    assign xs_18 = {xl_18[15], xl_18[15], xl_18[15], xl_18[15], xl_18[15], xl_18[15], xl_18};
    assign xl_19 = xsel[319:304];
    assign xs_19 = {xl_19[15], xl_19[15], xl_19[15], xl_19[15], xl_19[15], xl_19[15], xl_19};
    assign xl_20 = xsel[335:320];
    assign xs_20 = {xl_20[15], xl_20[15], xl_20[15], xl_20[15], xl_20[15], xl_20[15], xl_20};
    assign xl_21 = xsel[351:336];
    assign xs_21 = {xl_21[15], xl_21[15], xl_21[15], xl_21[15], xl_21[15], xl_21[15], xl_21};
    assign xl_22 = xsel[367:352];
    assign xs_22 = {xl_22[15], xl_22[15], xl_22[15], xl_22[15], xl_22[15], xl_22[15], xl_22};
    assign xl_23 = xsel[383:368];
    assign xs_23 = {xl_23[15], xl_23[15], xl_23[15], xl_23[15], xl_23[15], xl_23[15], xl_23};
    assign xl_24 = xsel[399:384];
    assign xs_24 = {xl_24[15], xl_24[15], xl_24[15], xl_24[15], xl_24[15], xl_24[15], xl_24};
    assign xl_25 = xsel[415:400];
    assign xs_25 = {xl_25[15], xl_25[15], xl_25[15], xl_25[15], xl_25[15], xl_25[15], xl_25};
    assign xl_26 = xsel[431:416];
    assign xs_26 = {xl_26[15], xl_26[15], xl_26[15], xl_26[15], xl_26[15], xl_26[15], xl_26};
    assign xl_27 = xsel[447:432];
    assign xs_27 = {xl_27[15], xl_27[15], xl_27[15], xl_27[15], xl_27[15], xl_27[15], xl_27};
    assign xl_28 = xsel[463:448];
    assign xs_28 = {xl_28[15], xl_28[15], xl_28[15], xl_28[15], xl_28[15], xl_28[15], xl_28};
    assign xl_29 = xsel[479:464];
    assign xs_29 = {xl_29[15], xl_29[15], xl_29[15], xl_29[15], xl_29[15], xl_29[15], xl_29};
    assign xl_30 = xsel[495:480];
    assign xs_30 = {xl_30[15], xl_30[15], xl_30[15], xl_30[15], xl_30[15], xl_30[15], xl_30};
    assign xl_31 = xsel[511:496];
    assign xs_31 = {xl_31[15], xl_31[15], xl_31[15], xl_31[15], xl_31[15], xl_31[15], xl_31};
    assign s0w = {xs_31, xs_30, xs_29, xs_28, xs_27, xs_26, xs_25, xs_24, xs_23, xs_22, xs_21, xs_20, xs_19, xs_18,
                  xs_17, xs_16, xs_15, xs_14, xs_13, xs_12, xs_11, xs_10, xs_9, xs_8, xs_7, xs_6, xs_5, xs_4, xs_3,
                  xs_2, xs_1, xs_0};
    assign sn_0 = u_lv_0_s_out;
    assign mn_0 = u_lv_0_m_out;
    assign sn_1 = u_lv_1_s_out;
    assign mn_1 = u_lv_1_m_out;
    assign sn_2 = u_lv_2_s_out;
    assign mn_2 = u_lv_2_m_out;
    assign sn_3 = u_lv_3_s_out;
    assign mn_3 = u_lv_3_m_out;
    assign sn_4 = u_lv_4_s_out;
    assign mn_4 = u_lv_4_m_out;
    assign s6v = st_5_s;
    assign m6v = st_5_m;
    assign kd6 = st_5_mt[4:3];
    assign ismin6 = (kd6 == 2'd2);
    assign s7c = (half_s + s6v);
    assign lt6 = ((half_m[15] ^ m6v[15]) ? half_m[15] : (half_m < m6v));
    assign m7c = (ismin6 ? (lt6 ? half_m : m6v) : (lt6 ? m6v : half_m));
    assign s7_ag_n = (s7c ^ {22{s7c[21]}});
    assign s7_ag_out = (s7_ag_n + {21'd0, s7c[21]});
    assign m7_ag_n = (m7c ^ {16{m7c[15]}});
    assign m7_ag_out = (m7_ag_n + {15'd0, m7c[15]});
    assign bh = ((mt7[0] & mt7[5]) & (mt7[9:6] == 4'd6));
    assign bhs = (bh & (mt7[4:3] == 2'd0));
    assign bhm = (bh & (mt7[4:3] != 2'd0));
    assign bsv_s = s7;
    assign bmx_s = {m7[15], m7[15], m7[15], m7[15], m7[15], m7[15], m7};
    assign bselw = (bhs ? bsv_s : (bhm ? bmx_s : 22'd0));
    assign beaw = (bh ? ea7 : 8'd0);
    assign bmtw = (bh ? mt7 : 20'd0);
    assign bsel_ag_n = (bselw ^ {22{bselw[21]}});
    assign bsel_ag_out = (bsel_ag_n + {21'd0, bselw[21]});
    assign bhi = ba_mg;
    assign bnz = (bhi != 22'd0);
    assign bmsb = u_bxlz_msb;
    assign beraw = (({3'd0, ba_e} + {6'd0, bmsb}) - 11'd14);
    assign be_hi = ((~beraw[10]) & (beraw[9:8] != 2'd0));
    assign be_lo = (beraw[10] | (beraw == 11'd0));
    assign becl = (be_hi ? 8'd255 : beraw[7:0]);
    assign bzs = (be_lo | (~bnz));
    assign bs_pos = (bmsb < 5'd14);
    assign blsh_n = (5'd14 - bmsb);
    assign brsh_n = (bmsb - 5'd14);
    assign blsh = (bs_pos ? blsh_n[3:0] : 4'd0);
    assign brsh = (bs_pos ? 3'd0 : brsh_n[2:0]);
    assign bloh = (15'd1 << blsh);
    assign bosel = (bzs ? 2'd3 : (be_hi ? 2'd2 : (bs_pos ? 2'd0 : 2'd1)));
    assign becz = (bzs ? 8'd0 : becl);
    assign bxe = {ba_s[21], ba_s[21], ba_s[21], ba_s[21], ba_s[21], ba_s[21], ba_s[21], ba_s};
    assign bro_0 = bxe[15:0];
    assign bro_1 = bxe[16:1];
    assign bro_2 = bxe[17:2];
    assign bro_3 = bxe[18:3];
    assign bro_4 = bxe[19:4];
    assign bro_5 = bxe[20:5];
    assign bro_6 = bxe[21:6];
    assign bro_7 = bxe[22:7];
    assign brr = ((brsh == 0) ? bro_0 :
                 ((brsh == 1) ? bro_1 :
                 ((brsh == 2) ? bro_2 :
                 ((brsh == 3) ? bro_3 :
                 ((brsh == 4) ? bro_4 :
                 ((brsh == 5) ? bro_5 :
                 ((brsh == 6) ? bro_6 :
                 bro_7)))))));
    assign bst = {ba_s[21], {15{(~ba_s[21])}}};
    assign bxz = (ba_s == 22'd0);
    assign bsa = (bxz ? 16'd0 : bst);
    assign bcs = ((bosel == 0) ? 16'd0 : ((bosel == 1) ? brr : ((bosel == 2) ? bsa : 16'd0)));
    assign bpm = ((bb_x * bb_oh) + bb_c);
    assign bfo = bpm[15:0];
    assign bf = {64{bfo}};
    assign be = bb_e;
    assign bm = bb_mt;
    assign kd7 = mt7[4:3];
    assign outw = ((kd7 == 2'd0) ? u_sumf_res : u_mmf_res);
    assign res = res8;
    assign mo = mt8;
    assign obusy = (((((((mt8[0] | mt7[0]) | st_0_mt[0]) | st_1_mt[0]) | st_2_mt[0]) | st_3_mt[0]) | st_4_mt[0])
                    | st_5_mt[0]);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            x0 <= 0;
            x0e <= 0;
            mt0 <= 0;
            ph0 <= 0;
            st_0_s <= 0;
            st_0_m <= 0;
            st_0_mt <= 0;
            st_0_ea <= 0;
            st_0_pv <= 0;
            st_1_s <= 0;
            st_1_m <= 0;
            st_1_mt <= 0;
            st_1_ea <= 0;
            st_1_pv <= 0;
            st_2_s <= 0;
            st_2_m <= 0;
            st_2_mt <= 0;
            st_2_ea <= 0;
            st_2_pv <= 0;
            st_3_s <= 0;
            st_3_m <= 0;
            st_3_mt <= 0;
            st_3_ea <= 0;
            st_3_pv <= 0;
            st_4_s <= 0;
            st_4_m <= 0;
            st_4_mt <= 0;
            st_4_ea <= 0;
            st_4_pv <= 0;
            st_5_s <= 0;
            st_5_m <= 0;
            st_5_mt <= 0;
            st_5_ea <= 0;
            st_5_pv <= 0;
            half_s <= 0;
            half_m <= 0;
            s7 <= 0;
            m7 <= 0;
            mt7 <= 0;
            ea7 <= 0;
            s7_mg <= 0;
            m7_mg <= 0;
            res8 <= 0;
            mt8 <= 0;
            ba_s <= 0;
            ba_mg <= 0;
            ba_e <= 0;
            ba_mt <= 0;
            bb_x <= 0;
            bb_oh <= 0;
            bb_c <= 0;
            bb_e <= 0;
            bb_mt <= 0;
        end else begin
            if ((~hold)) begin
                x0 <= xhi;
                x0e <= xe;
                mt0 <= mi;
                ph0 <= mi[0];
                st_0_s <= s0w;
                st_0_m <= xsel;
                st_0_mt <= mt1c;
                st_0_ea <= ea1c;
                st_0_pv <= (~ph0);
                st_1_s <= sn_0;
                st_1_m <= mn_0;
                st_1_mt <= st_0_mt;
                st_1_ea <= st_0_ea;
                st_1_pv <= st_0_pv;
                st_2_s <= sn_1;
                st_2_m <= mn_1;
                st_2_mt <= st_1_mt;
                st_2_ea <= st_1_ea;
                st_2_pv <= st_1_pv;
                st_3_s <= sn_2;
                st_3_m <= mn_2;
                st_3_mt <= st_2_mt;
                st_3_ea <= st_2_ea;
                st_3_pv <= st_2_pv;
                st_4_s <= sn_3;
                st_4_m <= mn_3;
                st_4_mt <= st_3_mt;
                st_4_ea <= st_3_ea;
                st_4_pv <= st_3_pv;
                st_5_s <= sn_4;
                st_5_m <= mn_4;
                st_5_mt <= st_4_mt;
                st_5_ea <= st_4_ea;
                st_5_pv <= st_4_pv;
                if (st_5_pv) begin
                    half_s <= s6v;
                    half_m <= m6v;
                end
                s7 <= s7c;
                m7 <= m7c;
                mt7 <= st_5_mt;
                ea7 <= st_5_ea;
                s7_mg <= s7_ag_out;
                m7_mg <= m7_ag_out;
                res8 <= outw;
                mt8 <= mt7;
                ba_s <= bselw;
                ba_mg <= bsel_ag_out;
                ba_e <= beaw;
                ba_mt <= bmtw;
                bb_x <= (ba_s ^ 22'd2097152);
                bb_oh <= ((bosel == 2'd0) ? bloh : 15'd0);
                bb_c <= bcs;
                bb_e <= becz;
                bb_mt <= ba_mt;
            end
        end
    end

    RedLevelFix u_lv_0 (
        .s_in(st_0_s),
        .m_in(st_0_m),
        .ismin((st_0_mt[4:3] == 2'd2)),
        .s_out(u_lv_0_s_out),
        .m_out(u_lv_0_m_out)
    );
    RedLevelFix_N16 u_lv_1 (
        .s_in(st_1_s),
        .m_in(st_1_m),
        .ismin((st_1_mt[4:3] == 2'd2)),
        .s_out(u_lv_1_s_out),
        .m_out(u_lv_1_m_out)
    );
    RedLevelFix_N8 u_lv_2 (
        .s_in(st_2_s),
        .m_in(st_2_m),
        .ismin((st_2_mt[4:3] == 2'd2)),
        .s_out(u_lv_2_s_out),
        .m_out(u_lv_2_m_out)
    );
    RedLevelFix_N4 u_lv_3 (
        .s_in(st_3_s),
        .m_in(st_3_m),
        .ismin((st_3_mt[4:3] == 2'd2)),
        .s_out(u_lv_3_s_out),
        .m_out(u_lv_3_m_out)
    );
    RedLevelFix_N2 u_lv_4 (
        .s_in(st_4_s),
        .m_in(st_4_m),
        .ismin((st_4_mt[4:3] == 2'd2)),
        .s_out(u_lv_4_s_out),
        .m_out(u_lv_4_m_out)
    );
    Lzd_N22 u_bxlz (
        .src(bhi),
        .msb(u_bxlz_msb)
    );
    FixToF32W u_sumf (
        .val(s7),
        .mgi(s7_mg),
        .e(ea7),
        .res(u_sumf_res)
    );
    FixToF32W_W16 u_mmf (
        .val(m7),
        .mgi(m7_mg),
        .e(ea7),
        .res(u_mmf_res)
    );
endmodule
