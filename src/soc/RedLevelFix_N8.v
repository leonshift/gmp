module RedLevelFix_N8 (
    input [175:0] s_in,
    input [127:0] m_in,
    input ismin,
    output logic [87:0] s_out,
    output logic [63:0] m_out
);
    logic [21:0] sa_0;
    logic [21:0] sa_1;
    logic [21:0] sa_2;
    logic [21:0] sa_3;
    logic [21:0] sb_0;
    logic [21:0] sb_1;
    logic [21:0] sb_2;
    logic [21:0] sb_3;
    logic [21:0] sc_0;
    logic [21:0] sc_1;
    logic [21:0] sc_2;
    logic [21:0] sc_3;
    logic [15:0] ma_0;
    logic [15:0] ma_1;
    logic [15:0] ma_2;
    logic [15:0] ma_3;
    logic [15:0] mb_0;
    logic [15:0] mb_1;
    logic [15:0] mb_2;
    logic [15:0] mb_3;
    logic lt_0;
    logic lt_1;
    logic lt_2;
    logic lt_3;
    logic [15:0] mc_0;
    logic [15:0] mc_1;
    logic [15:0] mc_2;
    logic [15:0] mc_3;

    assign sa_0 = s_in[21:0];
    assign sb_0 = s_in[43:22];
    assign sc_0 = (sa_0 + sb_0);
    assign ma_0 = m_in[15:0];
    assign mb_0 = m_in[31:16];
    assign lt_0 = ((ma_0[15] ^ mb_0[15]) ? ma_0[15] : (ma_0 < mb_0));
    assign mc_0 = (ismin ? (lt_0 ? ma_0 : mb_0) : (lt_0 ? mb_0 : ma_0));
    assign sa_1 = s_in[65:44];
    assign sb_1 = s_in[87:66];
    assign sc_1 = (sa_1 + sb_1);
    assign ma_1 = m_in[47:32];
    assign mb_1 = m_in[63:48];
    assign lt_1 = ((ma_1[15] ^ mb_1[15]) ? ma_1[15] : (ma_1 < mb_1));
    assign mc_1 = (ismin ? (lt_1 ? ma_1 : mb_1) : (lt_1 ? mb_1 : ma_1));
    assign sa_2 = s_in[109:88];
    assign sb_2 = s_in[131:110];
    assign sc_2 = (sa_2 + sb_2);
    assign ma_2 = m_in[79:64];
    assign mb_2 = m_in[95:80];
    assign lt_2 = ((ma_2[15] ^ mb_2[15]) ? ma_2[15] : (ma_2 < mb_2));
    assign mc_2 = (ismin ? (lt_2 ? ma_2 : mb_2) : (lt_2 ? mb_2 : ma_2));
    assign sa_3 = s_in[153:132];
    assign sb_3 = s_in[175:154];
    assign sc_3 = (sa_3 + sb_3);
    assign ma_3 = m_in[111:96];
    assign mb_3 = m_in[127:112];
    assign lt_3 = ((ma_3[15] ^ mb_3[15]) ? ma_3[15] : (ma_3 < mb_3));
    assign mc_3 = (ismin ? (lt_3 ? ma_3 : mb_3) : (lt_3 ? mb_3 : ma_3));
    assign s_out = {sc_3, sc_2, sc_1, sc_0};
    assign m_out = {mc_3, mc_2, mc_1, mc_0};
endmodule
