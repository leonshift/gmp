module FloatLane (
    input clk,
    input rst_n,
    input [36:0] s,
    input [10:0] ms,
    input ms_ce,
    input [7:0] ex,
    input zi,
    input [31:0] old,
    output logic [31:0] res,
    output logic [31:0] res_q
);
    logic [7:0] ex1;
    logic [36:0] sq;
    logic [3:0] mm_q;
    logic mz_q;
    logic [3:0] mm1;
    logic mz1;
    logic [5:0] h0_l;
    logic h0_sz;
    logic [5:0] np_lsh;
    logic [7:0] np_ea;
    logic [7:0] np_eb;
    logic np_za;
    logic np_zb;
    logic np_oa;
    logic np_ob;
    logic zi2;
    logic zi3;
    logic zi4;
    logic [47:0] na_mg;
    logic [3:0] na_lsh;
    logic na_sg;
    logic na_za;
    logic na_zb;
    logic na_oa;
    logic na_ob;
    logic [7:0] na_ea;
    logic [7:0] na_eb;
    logic [31:0] v2;
    logic [31:0] rq;
    logic [7:0] u_np_km;
    logic [7:0] u_np_ka;
    logic u_np_m128;
    logic u_np_m127;
    logic [5:0] u_np_ta;
    logic [47:0] u_mul_t;
    logic [31:0] u_add_res;
    logic [3:0] u_mm_mm;
    logic u_mm_z;
    logic [5:0] u_h0_l;
    logic u_h0_sz;
    logic [5:0] u_h1_lsh;
    logic [7:0] u_h1_ea;
    logic [7:0] u_h1_eb;
    logic u_h1_za;
    logic u_h1_zb;
    logic u_h1_oa;
    logic u_h1_ob;
    logic [47:0] u_na_mg;
    logic u_na_sgo;
    logic [31:0] u_nb_res;

    assign res = u_add_res;
    assign res_q = rq;
    always_ff @(posedge clk) begin
        ex1 <= ex;
        sq <= s;
        if (ms_ce) begin
            mm_q <= u_mm_mm;
            mz_q <= u_mm_z;
        end
        mm1 <= mm_q;
        mz1 <= mz_q;
        h0_l <= u_h0_l;
        h0_sz <= u_h0_sz;
        np_lsh <= u_h1_lsh;
        np_ea <= u_h1_ea;
        np_eb <= u_h1_eb;
        np_za <= u_h1_za;
        np_zb <= u_h1_zb;
        np_oa <= u_h1_oa;
        np_ob <= u_h1_ob;
        zi2 <= zi;
        zi3 <= zi2;
        zi4 <= zi3;
        na_mg <= u_na_mg;
        na_lsh <= np_lsh[3:0];
        na_sg <= u_na_sgo;
        na_za <= np_za;
        na_zb <= np_zb;
        na_oa <= np_oa;
        na_ob <= np_ob;
        na_ea <= np_ea;
        na_eb <= np_eb;
        v2 <= u_nb_res;
        rq <= u_add_res;
    end

    SMul37x11 u_mul (
        .clk(clk),
        .s(s),
        .ms(ms),
        .ce(ms_ce),
        .t(u_mul_t)
    );
    NormF32P u_np (
        .ex(ex1),
        .km(u_np_km),
        .ka(u_np_ka),
        .m128(u_np_m128),
        .m127(u_np_m127),
        .ta(u_np_ta)
    );
    MsMsb u_mm (
        .ms(ms),
        .mm(u_mm_mm),
        .z(u_mm_z)
    );
    NormF32H0 u_h0 (
        .s(sq),
        .l(u_h0_l),
        .sz(u_h0_sz)
    );
    NormF32H1 u_h1 (
        .l(h0_l),
        .sz(h0_sz),
        .mm(mm1),
        .mz(mz1),
        .km(u_np_km),
        .ka(u_np_ka),
        .m128(u_np_m128),
        .m127(u_np_m127),
        .ta(u_np_ta),
        .lsh(u_h1_lsh),
        .ea(u_h1_ea),
        .eb(u_h1_eb),
        .za(u_h1_za),
        .zb(u_h1_zb),
        .oa(u_h1_oa),
        .ob(u_h1_ob)
    );
    NormF32S u_na (
        .t(u_mul_t),
        .lsh_hi(np_lsh[5:4]),
        .mg(u_na_mg),
        .sgo(u_na_sgo)
    );
    NormF32B u_nb (
        .mg(na_mg),
        .lsh(na_lsh),
        .sg(na_sg),
        .za(na_za),
        .zb(na_zb),
        .oa(na_oa),
        .ob(na_ob),
        .ea(na_ea),
        .eb(na_eb),
        .res(u_nb_res)
    );
    FpAddX u_add (
        .clk(clk),
        .rst_n(rst_n),
        .a(old),
        .az_in(zi4),
        .b(v2),
        .res(u_add_res)
    );
endmodule
