module FuncBankFix (
    input clk,
    input rst_n,
    input [255:0] x,
    input [31:0] es_g,
    input [11:0] func_g,
    input [63:0] kc_g,
    input en,
    input adv,
    output logic [303:0] m,
    output logic [143:0] ed,
    output logic [15:0] sgn,
    output logic valid
);
    logic [18:0] u_15_m;
    logic [18:0] u_14_m;
    logic [18:0] u_13_m;
    logic [18:0] u_12_m;
    logic [18:0] u_11_m;
    logic [18:0] u_10_m;
    logic [18:0] u_9_m;
    logic [18:0] u_8_m;
    logic [18:0] u_7_m;
    logic [18:0] u_6_m;
    logic [18:0] u_5_m;
    logic [18:0] u_4_m;
    logic [18:0] u_3_m;
    logic [18:0] u_2_m;
    logic [18:0] u_1_m;
    logic [18:0] u_0_m;
    logic [8:0] u_15_ed;
    logic [8:0] u_14_ed;
    logic [8:0] u_13_ed;
    logic [8:0] u_12_ed;
    logic [8:0] u_11_ed;
    logic [8:0] u_10_ed;
    logic [8:0] u_9_ed;
    logic [8:0] u_8_ed;
    logic [8:0] u_7_ed;
    logic [8:0] u_6_ed;
    logic [8:0] u_5_ed;
    logic [8:0] u_4_ed;
    logic [8:0] u_3_ed;
    logic [8:0] u_2_ed;
    logic [8:0] u_1_ed;
    logic [8:0] u_0_ed;
    logic u_15_sgn;
    logic u_14_sgn;
    logic u_13_sgn;
    logic u_12_sgn;
    logic u_11_sgn;
    logic u_10_sgn;
    logic u_9_sgn;
    logic u_8_sgn;
    logic u_7_sgn;
    logic u_6_sgn;
    logic u_5_sgn;
    logic u_4_sgn;
    logic u_3_sgn;
    logic u_2_sgn;
    logic u_1_sgn;
    logic u_0_sgn;
    logic u_0_valid;

    assign m = {u_15_m, u_14_m, u_13_m, u_12_m, u_11_m, u_10_m, u_9_m, u_8_m, u_7_m, u_6_m, u_5_m, u_4_m, u_3_m, u_2_m,
                u_1_m, u_0_m};
    assign ed = {u_15_ed, u_14_ed, u_13_ed, u_12_ed, u_11_ed, u_10_ed, u_9_ed, u_8_ed, u_7_ed, u_6_ed, u_5_ed, u_4_ed,
                 u_3_ed, u_2_ed, u_1_ed, u_0_ed};
    assign sgn = {u_15_sgn, u_14_sgn, u_13_sgn, u_12_sgn, u_11_sgn, u_10_sgn, u_9_sgn, u_8_sgn, u_7_sgn, u_6_sgn,
                  u_5_sgn, u_4_sgn, u_3_sgn, u_2_sgn, u_1_sgn, u_0_sgn};
    assign valid = u_0_valid;

    FuncLutFix u_0 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[15:0]),
        .es(es_g[7:0]),
        .func(func_g[2:0]),
        .kc(kc_g[15:0]),
        .en(en),
        .adv(adv),
        .m(u_0_m),
        .ed(u_0_ed),
        .sgn(u_0_sgn),
        .valid(u_0_valid)
    );
    FuncLutFix u_1 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[31:16]),
        .es(es_g[7:0]),
        .func(func_g[2:0]),
        .kc(kc_g[15:0]),
        .en(en),
        .adv(adv),
        .m(u_1_m),
        .ed(u_1_ed),
        .sgn(u_1_sgn)
    );
    FuncLutFix u_2 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[47:32]),
        .es(es_g[7:0]),
        .func(func_g[2:0]),
        .kc(kc_g[15:0]),
        .en(en),
        .adv(adv),
        .m(u_2_m),
        .ed(u_2_ed),
        .sgn(u_2_sgn)
    );
    FuncLutFix u_3 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[63:48]),
        .es(es_g[7:0]),
        .func(func_g[2:0]),
        .kc(kc_g[15:0]),
        .en(en),
        .adv(adv),
        .m(u_3_m),
        .ed(u_3_ed),
        .sgn(u_3_sgn)
    );
    FuncLutFix u_4 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[79:64]),
        .es(es_g[15:8]),
        .func(func_g[5:3]),
        .kc(kc_g[31:16]),
        .en(en),
        .adv(adv),
        .m(u_4_m),
        .ed(u_4_ed),
        .sgn(u_4_sgn)
    );
    FuncLutFix u_5 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[95:80]),
        .es(es_g[15:8]),
        .func(func_g[5:3]),
        .kc(kc_g[31:16]),
        .en(en),
        .adv(adv),
        .m(u_5_m),
        .ed(u_5_ed),
        .sgn(u_5_sgn)
    );
    FuncLutFix u_6 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[111:96]),
        .es(es_g[15:8]),
        .func(func_g[5:3]),
        .kc(kc_g[31:16]),
        .en(en),
        .adv(adv),
        .m(u_6_m),
        .ed(u_6_ed),
        .sgn(u_6_sgn)
    );
    FuncLutFix u_7 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[127:112]),
        .es(es_g[15:8]),
        .func(func_g[5:3]),
        .kc(kc_g[31:16]),
        .en(en),
        .adv(adv),
        .m(u_7_m),
        .ed(u_7_ed),
        .sgn(u_7_sgn)
    );
    FuncLutFix u_8 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[143:128]),
        .es(es_g[23:16]),
        .func(func_g[8:6]),
        .kc(kc_g[47:32]),
        .en(en),
        .adv(adv),
        .m(u_8_m),
        .ed(u_8_ed),
        .sgn(u_8_sgn)
    );
    FuncLutFix u_9 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[159:144]),
        .es(es_g[23:16]),
        .func(func_g[8:6]),
        .kc(kc_g[47:32]),
        .en(en),
        .adv(adv),
        .m(u_9_m),
        .ed(u_9_ed),
        .sgn(u_9_sgn)
    );
    FuncLutFix u_10 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[175:160]),
        .es(es_g[23:16]),
        .func(func_g[8:6]),
        .kc(kc_g[47:32]),
        .en(en),
        .adv(adv),
        .m(u_10_m),
        .ed(u_10_ed),
        .sgn(u_10_sgn)
    );
    FuncLutFix u_11 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[191:176]),
        .es(es_g[23:16]),
        .func(func_g[8:6]),
        .kc(kc_g[47:32]),
        .en(en),
        .adv(adv),
        .m(u_11_m),
        .ed(u_11_ed),
        .sgn(u_11_sgn)
    );
    FuncLutFix u_12 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[207:192]),
        .es(es_g[31:24]),
        .func(func_g[11:9]),
        .kc(kc_g[63:48]),
        .en(en),
        .adv(adv),
        .m(u_12_m),
        .ed(u_12_ed),
        .sgn(u_12_sgn)
    );
    FuncLutFix u_13 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[223:208]),
        .es(es_g[31:24]),
        .func(func_g[11:9]),
        .kc(kc_g[63:48]),
        .en(en),
        .adv(adv),
        .m(u_13_m),
        .ed(u_13_ed),
        .sgn(u_13_sgn)
    );
    FuncLutFix u_14 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[239:224]),
        .es(es_g[31:24]),
        .func(func_g[11:9]),
        .kc(kc_g[63:48]),
        .en(en),
        .adv(adv),
        .m(u_14_m),
        .ed(u_14_ed),
        .sgn(u_14_sgn)
    );
    FuncLutFix u_15 (
        .clk(clk),
        .rst_n(rst_n),
        .x(x[255:240]),
        .es(es_g[31:24]),
        .func(func_g[11:9]),
        .kc(kc_g[63:48]),
        .en(en),
        .adv(adv),
        .m(u_15_m),
        .ed(u_15_ed),
        .sgn(u_15_sgn)
    );
endmodule
