module RedLevelFix_N2 (
    input [43:0] s_in,
    input [31:0] m_in,
    input ismin,
    output logic [21:0] s_out,
    output logic [15:0] m_out
);
    logic [21:0] sa_0;
    logic [21:0] sb_0;
    logic [21:0] sc_0;
    logic [15:0] ma_0;
    logic [15:0] mb_0;
    logic lt_0;
    logic [15:0] mc_0;

    assign sa_0 = s_in[21:0];
    assign sb_0 = s_in[43:22];
    assign sc_0 = (sa_0 + sb_0);
    assign ma_0 = m_in[15:0];
    assign mb_0 = m_in[31:16];
    assign lt_0 = ((ma_0[15] ^ mb_0[15]) ? ma_0[15] : (ma_0 < mb_0));
    assign mc_0 = (ismin ? (lt_0 ? ma_0 : mb_0) : (lt_0 ? mb_0 : ma_0));
    assign s_out = {sc_0};
    assign m_out = {mc_0};
endmodule
