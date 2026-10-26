module AluSegExp (
    input [7:0] ea,
    input [7:0] eb,
    input [3:0] op,
    input [7:0] evt,
    input [15:0] vt,
    input is_where,
    output logic [4:0] shb,
    output logic [4:0] sha,
    output logic [16:0] oha,
    output logic [16:0] ohb,
    output logic [15:0] vt_al,
    output logic [9:0] eo
);
    logic is_mul;
    logic is_cmp;
    logic [7:0] la;
    logic [8:0] dab;
    logic [8:0] dba;
    logic gt;
    logic [7:0] em;
    logic [7:0] da;
    logic [7:0] db;
    logic da_s;
    logic db_s;
    logic [4:0] sh_l;
    logic [16:0] vtc_half;
    logic [16:0] vtc_k;
    logic [16:0] vtc_m;
    logic [16:0] vt_sh_t;
    logic [16:0] vt_sh_l;
    logic [16:0] vt_sh_g;
    logic [16:0] vt_sh_w;
    logic [15:0] vt_sh_out;
    logic [9:0] e_mul;
    logic [9:0] e_nm;

    assign is_mul = ((op == 4'd2) & (~is_where));
    assign is_cmp = ((op >= 4'd6) & (~is_where));
    assign la = (is_where ? evt : ea);
    assign dab = ({1'd0, la} - {1'd0, eb});
    assign dba = ({1'd0, eb} - {1'd0, la});
    assign gt = dba[8];
    assign em = (gt ? la : eb);
    assign da = (gt ? 8'd0 : dba[7:0]);
    assign db = (gt ? dab[7:0] : 8'd0);
    assign da_s = (da > 8'd16);
    assign db_s = (db > 8'd16);
    assign sh_l = (da_s ? 5'd16 : da[4:0]);
    assign shb = (db_s ? 5'd16 : db[4:0]);
    assign sha = (is_where ? 5'd0 : sh_l);
    assign oha = ((is_where | gt) ? 17'd65536 : ((dba[7:4] != 4'd0) ? 17'd0 : (17'd65536 >> dba[3:0])));
    assign ohb = (gt ? ((dab[7:4] != 4'd0) ? 17'd0 : (17'd65536 >> dab[3:0])) : 17'd65536);
    assign vtc_half = ((17'd1 << sh_l) >> 1);
    assign vtc_k = (17'd131071 >> sh_l);
    assign vtc_m = (~vtc_k);
    assign vt_sh_t = ({vt[15], vt} + vtc_half);
    assign vt_sh_l = (vt_sh_t >> sh_l);
    assign vt_sh_g = (vt_sh_l | vtc_m);
    assign vt_sh_w = (vt_sh_t[16] ? vt_sh_g : vt_sh_l);
    assign vt_sh_out = vt_sh_w[15:0];
    assign vt_al = (da_s ? 16'd0 : vt_sh_out);
    assign e_mul = (({2'd0, ea} + {2'd0, eb}) - 10'd127);
    assign e_nm = (is_cmp ? 10'd127 : {2'd0, em});
    assign eo = (is_mul ? e_mul : e_nm);
endmodule
