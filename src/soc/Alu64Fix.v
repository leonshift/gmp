module Alu64Fix (
    input clk,
    input rst_n,
    input [1023:0] a,
    input [1023:0] b,
    input [31:0] op_g,
    input [127:0] vtq_g,
    input [7:0] isw_g,
    input ph,
    input en,
    input [135:0] oh_a,
    input [135:0] oh_b,
    output logic [543:0] res
);
    logic [15:0] ax_0;
    logic [15:0] ax_1;
    logic [15:0] ax_2;
    logic [15:0] ax_3;
    logic [15:0] ax_4;
    logic [15:0] ax_5;
    logic [15:0] ax_6;
    logic [15:0] ax_7;
    logic [15:0] ax_8;
    logic [15:0] ax_9;
    logic [15:0] ax_10;
    logic [15:0] ax_11;
    logic [15:0] ax_12;
    logic [15:0] ax_13;
    logic [15:0] ax_14;
    logic [15:0] ax_15;
    logic [15:0] ax_16;
    logic [15:0] ax_17;
    logic [15:0] ax_18;
    logic [15:0] ax_19;
    logic [15:0] ax_20;
    logic [15:0] ax_21;
    logic [15:0] ax_22;
    logic [15:0] ax_23;
    logic [15:0] ax_24;
    logic [15:0] ax_25;
    logic [15:0] ax_26;
    logic [15:0] ax_27;
    logic [15:0] ax_28;
    logic [15:0] ax_29;
    logic [15:0] ax_30;
    logic [15:0] ax_31;
    logic [15:0] bx_0;
    logic [15:0] bx_1;
    logic [15:0] bx_2;
    logic [15:0] bx_3;
    logic [15:0] bx_4;
    logic [15:0] bx_5;
    logic [15:0] bx_6;
    logic [15:0] bx_7;
    logic [15:0] bx_8;
    logic [15:0] bx_9;
    logic [15:0] bx_10;
    logic [15:0] bx_11;
    logic [15:0] bx_12;
    logic [15:0] bx_13;
    logic [15:0] bx_14;
    logic [15:0] bx_15;
    logic [15:0] bx_16;
    logic [15:0] bx_17;
    logic [15:0] bx_18;
    logic [15:0] bx_19;
    logic [15:0] bx_20;
    logic [15:0] bx_21;
    logic [15:0] bx_22;
    logic [15:0] bx_23;
    logic [15:0] bx_24;
    logic [15:0] bx_25;
    logic [15:0] bx_26;
    logic [15:0] bx_27;
    logic [15:0] bx_28;
    logic [15:0] bx_29;
    logic [15:0] bx_30;
    logic [15:0] bx_31;
    logic [16:0] u_31_res;
    logic [16:0] u_30_res;
    logic [16:0] u_29_res;
    logic [16:0] u_28_res;
    logic [16:0] u_27_res;
    logic [16:0] u_26_res;
    logic [16:0] u_25_res;
    logic [16:0] u_24_res;
    logic [16:0] u_23_res;
    logic [16:0] u_22_res;
    logic [16:0] u_21_res;
    logic [16:0] u_20_res;
    logic [16:0] u_19_res;
    logic [16:0] u_18_res;
    logic [16:0] u_17_res;
    logic [16:0] u_16_res;
    logic [16:0] u_15_res;
    logic [16:0] u_14_res;
    logic [16:0] u_13_res;
    logic [16:0] u_12_res;
    logic [16:0] u_11_res;
    logic [16:0] u_10_res;
    logic [16:0] u_9_res;
    logic [16:0] u_8_res;
    logic [16:0] u_7_res;
    logic [16:0] u_6_res;
    logic [16:0] u_5_res;
    logic [16:0] u_4_res;
    logic [16:0] u_3_res;
    logic [16:0] u_2_res;
    logic [16:0] u_1_res;
    logic [16:0] u_0_res;

    assign ax_0 = (ph ? a[31:16] : a[15:0]);
    assign bx_0 = (ph ? b[31:16] : b[15:0]);
    assign ax_1 = (ph ? a[63:48] : a[47:32]);
    assign bx_1 = (ph ? b[63:48] : b[47:32]);
    assign ax_2 = (ph ? a[95:80] : a[79:64]);
    assign bx_2 = (ph ? b[95:80] : b[79:64]);
    assign ax_3 = (ph ? a[127:112] : a[111:96]);
    assign bx_3 = (ph ? b[127:112] : b[111:96]);
    assign ax_4 = (ph ? a[159:144] : a[143:128]);
    assign bx_4 = (ph ? b[159:144] : b[143:128]);
    assign ax_5 = (ph ? a[191:176] : a[175:160]);
    assign bx_5 = (ph ? b[191:176] : b[175:160]);
    assign ax_6 = (ph ? a[223:208] : a[207:192]);
    assign bx_6 = (ph ? b[223:208] : b[207:192]);
    assign ax_7 = (ph ? a[255:240] : a[239:224]);
    assign bx_7 = (ph ? b[255:240] : b[239:224]);
    assign ax_8 = (ph ? a[287:272] : a[271:256]);
    assign bx_8 = (ph ? b[287:272] : b[271:256]);
    assign ax_9 = (ph ? a[319:304] : a[303:288]);
    assign bx_9 = (ph ? b[319:304] : b[303:288]);
    assign ax_10 = (ph ? a[351:336] : a[335:320]);
    assign bx_10 = (ph ? b[351:336] : b[335:320]);
    assign ax_11 = (ph ? a[383:368] : a[367:352]);
    assign bx_11 = (ph ? b[383:368] : b[367:352]);
    assign ax_12 = (ph ? a[415:400] : a[399:384]);
    assign bx_12 = (ph ? b[415:400] : b[399:384]);
    assign ax_13 = (ph ? a[447:432] : a[431:416]);
    assign bx_13 = (ph ? b[447:432] : b[431:416]);
    assign ax_14 = (ph ? a[479:464] : a[463:448]);
    assign bx_14 = (ph ? b[479:464] : b[463:448]);
    assign ax_15 = (ph ? a[511:496] : a[495:480]);
    assign bx_15 = (ph ? b[511:496] : b[495:480]);
    assign ax_16 = (ph ? a[543:528] : a[527:512]);
    assign bx_16 = (ph ? b[543:528] : b[527:512]);
    assign ax_17 = (ph ? a[575:560] : a[559:544]);
    assign bx_17 = (ph ? b[575:560] : b[559:544]);
    assign ax_18 = (ph ? a[607:592] : a[591:576]);
    assign bx_18 = (ph ? b[607:592] : b[591:576]);
    assign ax_19 = (ph ? a[639:624] : a[623:608]);
    assign bx_19 = (ph ? b[639:624] : b[623:608]);
    assign ax_20 = (ph ? a[671:656] : a[655:640]);
    assign bx_20 = (ph ? b[671:656] : b[655:640]);
    assign ax_21 = (ph ? a[703:688] : a[687:672]);
    assign bx_21 = (ph ? b[703:688] : b[687:672]);
    assign ax_22 = (ph ? a[735:720] : a[719:704]);
    assign bx_22 = (ph ? b[735:720] : b[719:704]);
    assign ax_23 = (ph ? a[767:752] : a[751:736]);
    assign bx_23 = (ph ? b[767:752] : b[751:736]);
    assign ax_24 = (ph ? a[799:784] : a[783:768]);
    assign bx_24 = (ph ? b[799:784] : b[783:768]);
    assign ax_25 = (ph ? a[831:816] : a[815:800]);
    assign bx_25 = (ph ? b[831:816] : b[815:800]);
    assign ax_26 = (ph ? a[863:848] : a[847:832]);
    assign bx_26 = (ph ? b[863:848] : b[847:832]);
    assign ax_27 = (ph ? a[895:880] : a[879:864]);
    assign bx_27 = (ph ? b[895:880] : b[879:864]);
    assign ax_28 = (ph ? a[927:912] : a[911:896]);
    assign bx_28 = (ph ? b[927:912] : b[911:896]);
    assign ax_29 = (ph ? a[959:944] : a[943:928]);
    assign bx_29 = (ph ? b[959:944] : b[943:928]);
    assign ax_30 = (ph ? a[991:976] : a[975:960]);
    assign bx_30 = (ph ? b[991:976] : b[975:960]);
    assign ax_31 = (ph ? a[1023:1008] : a[1007:992]);
    assign bx_31 = (ph ? b[1023:1008] : b[1007:992]);
    assign res = {u_31_res, u_30_res, u_29_res, u_28_res, u_27_res, u_26_res, u_25_res, u_24_res, u_23_res, u_22_res,
                  u_21_res, u_20_res, u_19_res, u_18_res, u_17_res, u_16_res, u_15_res, u_14_res, u_13_res, u_12_res,
                  u_11_res, u_10_res, u_9_res, u_8_res, u_7_res, u_6_res, u_5_res, u_4_res, u_3_res, u_2_res, u_1_res,
                  u_0_res};

    AluLaneFix u_0 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_0),
        .b(bx_0),
        .oha(oh_a[16:0]),
        .ohb(oh_b[16:0]),
        .op(op_g[3:0]),
        .vtq(vtq_g[15:0]),
        .is_where(isw_g[0]),
        .en(en),
        .res(u_0_res)
    );
    AluLaneFix u_1 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_1),
        .b(bx_1),
        .oha(oh_a[16:0]),
        .ohb(oh_b[16:0]),
        .op(op_g[3:0]),
        .vtq(vtq_g[15:0]),
        .is_where(isw_g[0]),
        .en(en),
        .res(u_1_res)
    );
    AluLaneFix u_2 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_2),
        .b(bx_2),
        .oha(oh_a[16:0]),
        .ohb(oh_b[16:0]),
        .op(op_g[3:0]),
        .vtq(vtq_g[15:0]),
        .is_where(isw_g[0]),
        .en(en),
        .res(u_2_res)
    );
    AluLaneFix u_3 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_3),
        .b(bx_3),
        .oha(oh_a[16:0]),
        .ohb(oh_b[16:0]),
        .op(op_g[3:0]),
        .vtq(vtq_g[15:0]),
        .is_where(isw_g[0]),
        .en(en),
        .res(u_3_res)
    );
    AluLaneFix u_4 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_4),
        .b(bx_4),
        .oha(oh_a[33:17]),
        .ohb(oh_b[33:17]),
        .op(op_g[7:4]),
        .vtq(vtq_g[31:16]),
        .is_where(isw_g[1]),
        .en(en),
        .res(u_4_res)
    );
    AluLaneFix u_5 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_5),
        .b(bx_5),
        .oha(oh_a[33:17]),
        .ohb(oh_b[33:17]),
        .op(op_g[7:4]),
        .vtq(vtq_g[31:16]),
        .is_where(isw_g[1]),
        .en(en),
        .res(u_5_res)
    );
    AluLaneFix u_6 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_6),
        .b(bx_6),
        .oha(oh_a[33:17]),
        .ohb(oh_b[33:17]),
        .op(op_g[7:4]),
        .vtq(vtq_g[31:16]),
        .is_where(isw_g[1]),
        .en(en),
        .res(u_6_res)
    );
    AluLaneFix u_7 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_7),
        .b(bx_7),
        .oha(oh_a[33:17]),
        .ohb(oh_b[33:17]),
        .op(op_g[7:4]),
        .vtq(vtq_g[31:16]),
        .is_where(isw_g[1]),
        .en(en),
        .res(u_7_res)
    );
    AluLaneFix u_8 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_8),
        .b(bx_8),
        .oha(oh_a[50:34]),
        .ohb(oh_b[50:34]),
        .op(op_g[11:8]),
        .vtq(vtq_g[47:32]),
        .is_where(isw_g[2]),
        .en(en),
        .res(u_8_res)
    );
    AluLaneFix u_9 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_9),
        .b(bx_9),
        .oha(oh_a[50:34]),
        .ohb(oh_b[50:34]),
        .op(op_g[11:8]),
        .vtq(vtq_g[47:32]),
        .is_where(isw_g[2]),
        .en(en),
        .res(u_9_res)
    );
    AluLaneFix u_10 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_10),
        .b(bx_10),
        .oha(oh_a[50:34]),
        .ohb(oh_b[50:34]),
        .op(op_g[11:8]),
        .vtq(vtq_g[47:32]),
        .is_where(isw_g[2]),
        .en(en),
        .res(u_10_res)
    );
    AluLaneFix u_11 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_11),
        .b(bx_11),
        .oha(oh_a[50:34]),
        .ohb(oh_b[50:34]),
        .op(op_g[11:8]),
        .vtq(vtq_g[47:32]),
        .is_where(isw_g[2]),
        .en(en),
        .res(u_11_res)
    );
    AluLaneFix u_12 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_12),
        .b(bx_12),
        .oha(oh_a[67:51]),
        .ohb(oh_b[67:51]),
        .op(op_g[15:12]),
        .vtq(vtq_g[63:48]),
        .is_where(isw_g[3]),
        .en(en),
        .res(u_12_res)
    );
    AluLaneFix u_13 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_13),
        .b(bx_13),
        .oha(oh_a[67:51]),
        .ohb(oh_b[67:51]),
        .op(op_g[15:12]),
        .vtq(vtq_g[63:48]),
        .is_where(isw_g[3]),
        .en(en),
        .res(u_13_res)
    );
    AluLaneFix u_14 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_14),
        .b(bx_14),
        .oha(oh_a[67:51]),
        .ohb(oh_b[67:51]),
        .op(op_g[15:12]),
        .vtq(vtq_g[63:48]),
        .is_where(isw_g[3]),
        .en(en),
        .res(u_14_res)
    );
    AluLaneFix u_15 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_15),
        .b(bx_15),
        .oha(oh_a[67:51]),
        .ohb(oh_b[67:51]),
        .op(op_g[15:12]),
        .vtq(vtq_g[63:48]),
        .is_where(isw_g[3]),
        .en(en),
        .res(u_15_res)
    );
    AluLaneFix u_16 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_16),
        .b(bx_16),
        .oha(oh_a[84:68]),
        .ohb(oh_b[84:68]),
        .op(op_g[19:16]),
        .vtq(vtq_g[79:64]),
        .is_where(isw_g[4]),
        .en(en),
        .res(u_16_res)
    );
    AluLaneFix u_17 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_17),
        .b(bx_17),
        .oha(oh_a[84:68]),
        .ohb(oh_b[84:68]),
        .op(op_g[19:16]),
        .vtq(vtq_g[79:64]),
        .is_where(isw_g[4]),
        .en(en),
        .res(u_17_res)
    );
    AluLaneFix u_18 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_18),
        .b(bx_18),
        .oha(oh_a[84:68]),
        .ohb(oh_b[84:68]),
        .op(op_g[19:16]),
        .vtq(vtq_g[79:64]),
        .is_where(isw_g[4]),
        .en(en),
        .res(u_18_res)
    );
    AluLaneFix u_19 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_19),
        .b(bx_19),
        .oha(oh_a[84:68]),
        .ohb(oh_b[84:68]),
        .op(op_g[19:16]),
        .vtq(vtq_g[79:64]),
        .is_where(isw_g[4]),
        .en(en),
        .res(u_19_res)
    );
    AluLaneFix u_20 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_20),
        .b(bx_20),
        .oha(oh_a[101:85]),
        .ohb(oh_b[101:85]),
        .op(op_g[23:20]),
        .vtq(vtq_g[95:80]),
        .is_where(isw_g[5]),
        .en(en),
        .res(u_20_res)
    );
    AluLaneFix u_21 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_21),
        .b(bx_21),
        .oha(oh_a[101:85]),
        .ohb(oh_b[101:85]),
        .op(op_g[23:20]),
        .vtq(vtq_g[95:80]),
        .is_where(isw_g[5]),
        .en(en),
        .res(u_21_res)
    );
    AluLaneFix u_22 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_22),
        .b(bx_22),
        .oha(oh_a[101:85]),
        .ohb(oh_b[101:85]),
        .op(op_g[23:20]),
        .vtq(vtq_g[95:80]),
        .is_where(isw_g[5]),
        .en(en),
        .res(u_22_res)
    );
    AluLaneFix u_23 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_23),
        .b(bx_23),
        .oha(oh_a[101:85]),
        .ohb(oh_b[101:85]),
        .op(op_g[23:20]),
        .vtq(vtq_g[95:80]),
        .is_where(isw_g[5]),
        .en(en),
        .res(u_23_res)
    );
    AluLaneFix u_24 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_24),
        .b(bx_24),
        .oha(oh_a[118:102]),
        .ohb(oh_b[118:102]),
        .op(op_g[27:24]),
        .vtq(vtq_g[111:96]),
        .is_where(isw_g[6]),
        .en(en),
        .res(u_24_res)
    );
    AluLaneFix u_25 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_25),
        .b(bx_25),
        .oha(oh_a[118:102]),
        .ohb(oh_b[118:102]),
        .op(op_g[27:24]),
        .vtq(vtq_g[111:96]),
        .is_where(isw_g[6]),
        .en(en),
        .res(u_25_res)
    );
    AluLaneFix u_26 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_26),
        .b(bx_26),
        .oha(oh_a[118:102]),
        .ohb(oh_b[118:102]),
        .op(op_g[27:24]),
        .vtq(vtq_g[111:96]),
        .is_where(isw_g[6]),
        .en(en),
        .res(u_26_res)
    );
    AluLaneFix u_27 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_27),
        .b(bx_27),
        .oha(oh_a[118:102]),
        .ohb(oh_b[118:102]),
        .op(op_g[27:24]),
        .vtq(vtq_g[111:96]),
        .is_where(isw_g[6]),
        .en(en),
        .res(u_27_res)
    );
    AluLaneFix u_28 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_28),
        .b(bx_28),
        .oha(oh_a[135:119]),
        .ohb(oh_b[135:119]),
        .op(op_g[31:28]),
        .vtq(vtq_g[127:112]),
        .is_where(isw_g[7]),
        .en(en),
        .res(u_28_res)
    );
    AluLaneFix u_29 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_29),
        .b(bx_29),
        .oha(oh_a[135:119]),
        .ohb(oh_b[135:119]),
        .op(op_g[31:28]),
        .vtq(vtq_g[127:112]),
        .is_where(isw_g[7]),
        .en(en),
        .res(u_29_res)
    );
    AluLaneFix u_30 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_30),
        .b(bx_30),
        .oha(oh_a[135:119]),
        .ohb(oh_b[135:119]),
        .op(op_g[31:28]),
        .vtq(vtq_g[127:112]),
        .is_where(isw_g[7]),
        .en(en),
        .res(u_30_res)
    );
    AluLaneFix u_31 (
        .clk(clk),
        .rst_n(rst_n),
        .a(ax_31),
        .b(bx_31),
        .oha(oh_a[135:119]),
        .ohb(oh_b[135:119]),
        .op(op_g[31:28]),
        .vtq(vtq_g[127:112]),
        .is_where(isw_g[7]),
        .en(en),
        .res(u_31_res)
    );
endmodule
