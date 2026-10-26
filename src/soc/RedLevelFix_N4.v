module RedLevelFix_N4 (
    input [87:0] s_in,
    input [63:0] m_in,
    input ismin,
    output logic [43:0] s_out,
    output logic [31:0] m_out
);
    logic [21:0] sa_0;
    logic [21:0] sa_1;
    logic [21:0] sb_0;
    logic [21:0] sb_1;
    logic [21:0] sc_0;
    logic [21:0] sc_1;
    logic [15:0] ma_0;
    logic [15:0] ma_1;
    logic [15:0] mb_0;
    logic [15:0] mb_1;
    logic lt_0;
    logic lt_1;
    logic [15:0] mc_0;
    logic [15:0] mc_1;

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
    assign s_out = {sc_1, sc_0};
    assign m_out = {mc_1, mc_0};
endmodule
