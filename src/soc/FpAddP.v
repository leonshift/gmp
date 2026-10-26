module FpAddP (
    input clk,
    input rst_n,
    input [31:0] a,
    input [31:0] b,
    output logic [31:0] res
);
    logic az;
    logic bz;
    logic bgt;
    logic swp;
    logic [31:0] x;
    logic [31:0] y;
    logic xs;
    logic [7:0] xe;
    logic ys;
    logic [7:0] ye;
    logic xz;
    logic yz;
    logic [17:0] xm;
    logic [21:0] xm3;
    logic [7:0] ea;
    logic [7:0] eb;
    logic [7:0] dab;
    logic [7:0] dba;
    logic big_b;
    logic big_a;
    logic [21:0] yv_b;
    logic [21:0] yv_a;
    logic [21:0] ysr_b;
    logic [21:0] ysr_a;
    logic [21:0] ysh_b;
    logic [21:0] ysh_a;
    logic [21:0] ym3;
    logic sub;
    logic [22:0] ssum;
    logic [21:0] sdif;
    logic [22:0] p_ssum;
    logic [21:0] p_sdif;
    logic [7:0] p_xe;
    logic p_xs;
    logic p_xz;
    logic p_yz;
    logic p_sub;
    logic [31:0] p_x;
    logic [22:0] v_ssum;
    logic [21:0] v_sdif;
    logic [7:0] v_xe;
    logic v_xs;
    logic v_xz;
    logic v_yz;
    logic v_sub;
    logic [31:0] v_x;
    logic cy;
    logic [18:0] sm;
    logic [7:0] xe1;
    logic [7:0] se8;
    logic x255;
    logic x254;
    logic ovf_a;
    logic dnz;
    logic [23:0] dpad;
    logic ng_0;
    logic ng_1;
    logic ng_2;
    logic ng_3;
    logic ng_4;
    logic ng_5;
    logic [2:0] nk;
    logic [21:0] dcs_0;
    logic [21:0] dcs_1;
    logic [21:0] dcs_2;
    logic [21:0] dcs_3;
    logic [21:0] dcs_4;
    logic [21:0] dcs_5;
    logic [21:0] dcs_6;
    logic [21:0] dcs_7;
    logic [21:0] dco;
    logic [1:0] nf;
    logic [21:0] dnrm;
    logic [18:0] dm;
    logic [5:0] ehs_0;
    logic [5:0] ehs_1;
    logic [5:0] ehs_2;
    logic [5:0] ehs_3;
    logic [5:0] ehs_4;
    logic [5:0] ehs_5;
    logic [5:0] ehs_6;
    logic [5:0] ehs_7;
    logic [5:0] eh0;
    logic [5:0] eh1;
    logic bw;
    logic [1:0] el2;
    logic [7:0] de8;
    logic [21:0] um;
    logic und_s;
    logic ovf_s;
    logic [18:0] rm;
    logic [7:0] re8;
    logic undf;
    logic ovf;
    logic [22:0] mout;

    assign az = (a[30:23] == 0);
    assign bz = (b[30:23] == 0);
    assign bgt = (b[30:0] > a[30:0]);
    assign swp = ((~bz) & (az | bgt));
    assign x = (swp ? b : a);
    assign y = (swp ? a : b);
    assign xs = x[31];
    assign xe = x[30:23];
    assign ys = y[31];
    assign ye = y[30:23];
    assign xz = (swp ? bz : az);
    assign yz = (swp ? az : bz);
    assign xm = x[22:5];
    assign xm3 = {1'd1, xm, 3'd0};
    assign ea = a[30:23];
    assign eb = b[30:23];
    assign dab = (ea - eb);
    assign dba = (eb - ea);
    assign big_b = (dab > 21);
    assign big_a = (dba > 21);
    assign yv_b = {1'd1, b[22:5], 3'd0};
    assign yv_a = {1'd1, a[22:5], 3'd0};
    assign ysr_b = (yv_b >> dab[4:0]);
    assign ysr_a = (yv_a >> dba[4:0]);
    assign ysh_b = (big_b ? 22'd1 : ysr_b);
    assign ysh_a = (big_a ? 22'd1 : ysr_a);
    assign ym3 = (swp ? ysh_a : ysh_b);
    assign sub = (xs ^ ys);
    assign ssum = ({1'd0, xm3} + {1'd0, ym3});
    assign sdif = (xm3 - ym3);
    assign v_ssum = p_ssum;
    assign v_sdif = p_sdif;
    assign v_xe = p_xe;
    assign v_xs = p_xs;
    assign v_xz = p_xz;
    assign v_yz = p_yz;
    assign v_sub = p_sub;
    assign v_x = p_x;
    assign cy = v_ssum[22];
    assign sm = (cy ? v_ssum[22:4] : v_ssum[21:3]);
    assign xe1 = (v_xe + 8'd1);
    assign se8 = (cy ? xe1 : v_xe);
    assign x255 = (v_xe == 8'd255);
    assign x254 = (v_xe == 8'd254);
    assign ovf_a = (x255 | (x254 & cy));
    assign dnz = (v_sdif != 0);
    assign dpad = {v_sdif, 2'd0};
    assign ng_0 = (dpad[23:20] == 4'd0);
    assign ng_1 = (dpad[19:16] == 4'd0);
    assign ng_2 = (dpad[15:12] == 4'd0);
    assign ng_3 = (dpad[11:8] == 4'd0);
    assign ng_4 = (dpad[7:4] == 4'd0);
    assign ng_5 = (dpad[3:0] == 4'd0);
    assign nk = (ng_0 ? (ng_1 ? (ng_2 ? (ng_3 ? (ng_4 ? 3'd5 : 3'd4) : 3'd3) : 3'd2) : 3'd1) : 3'd0);
    assign dcs_0 = (v_sdif << 0);
    assign dcs_1 = (v_sdif << 4);
    assign dcs_2 = (v_sdif << 8);
    assign dcs_3 = (v_sdif << 12);
    assign dcs_4 = (v_sdif << 16);
    assign dcs_5 = (v_sdif << 20);
    assign dcs_6 = (v_sdif << 20);
    assign dcs_7 = (v_sdif << 20);
    assign dco = ((nk == 0) ? dcs_0 :
                 ((nk == 1) ? dcs_1 :
                 ((nk == 2) ? dcs_2 :
                 ((nk == 3) ? dcs_3 :
                 ((nk == 4) ? dcs_4 :
                 ((nk == 5) ? dcs_5 :
                 ((nk == 6) ? dcs_6 :
                 dcs_7)))))));
    assign nf = (dco[21] ? 2'd0 : (dco[20] ? 2'd1 : (dco[19] ? 2'd2 : 2'd3)));
    assign dnrm = (dco << nf);
    assign dm = dnrm[21:3];
    assign ehs_0 = (v_xe[7:2] - 6'd0);
    assign ehs_1 = (v_xe[7:2] - 6'd1);
    assign ehs_2 = (v_xe[7:2] - 6'd2);
    assign ehs_3 = (v_xe[7:2] - 6'd3);
    assign ehs_4 = (v_xe[7:2] - 6'd4);
    assign ehs_5 = (v_xe[7:2] - 6'd5);
    assign ehs_6 = (v_xe[7:2] - 6'd6);
    assign ehs_7 = (v_xe[7:2] - 6'd6);
    assign eh0 = ((nk == 0) ? ehs_0 :
                 ((nk == 1) ? ehs_1 :
                 ((nk == 2) ? ehs_2 :
                 ((nk == 3) ? ehs_3 :
                 ((nk == 4) ? ehs_4 :
                 ((nk == 5) ? ehs_5 :
                 ((nk == 6) ? ehs_6 :
                 ehs_7)))))));
    assign eh1 = ((nk == 0) ? ehs_1 :
                 ((nk == 1) ? ehs_2 :
                 ((nk == 2) ? ehs_3 :
                 ((nk == 3) ? ehs_4 :
                 ((nk == 4) ? ehs_5 :
                 ((nk == 5) ? ehs_6 :
                 ((nk == 6) ? ehs_7 :
                 ehs_7)))))));
    assign bw = (nf > v_xe[1:0]);
    assign el2 = (v_xe[1:0] - nf);
    assign de8 = {(bw ? eh1 : eh0), el2};
    assign um = {(v_xe > 8'd0), (v_xe > 8'd1), (v_xe > 8'd2), (v_xe > 8'd3), (v_xe > 8'd4), (v_xe > 8'd5),
                 (v_xe > 8'd6), (v_xe > 8'd7), (v_xe > 8'd8), (v_xe > 8'd9), (v_xe > 8'd10), (v_xe > 8'd11),
                 (v_xe > 8'd12), (v_xe > 8'd13), (v_xe > 8'd14), (v_xe > 8'd15), (v_xe > 8'd16), (v_xe > 8'd17),
                 (v_xe > 8'd18), (v_xe > 8'd19), (v_xe > 8'd20), (v_xe > 8'd21)};
    assign und_s = ((v_sdif & um) == 0);
    assign ovf_s = (x255 & v_sdif[21]);
    assign rm = (v_sub ? dm : sm);
    assign re8 = (v_sub ? de8 : se8);
    assign undf = (v_sub & und_s);
    assign ovf = (v_sub ? ovf_s : ovf_a);
    assign mout = {rm[17:0], 5'd0};
    assign res = (v_xz ? 32'd0 :
                 (v_yz ? v_x :
                 ((v_sub & (~dnz)) ? 32'd0 :
                 (undf ? {v_xs, 31'd0} :
                 (ovf ? {v_xs, 31'd2139095040} :
                 {v_xs, re8, mout})))));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            p_ssum <= 0;
            p_sdif <= 0;
            p_xe <= 0;
            p_xs <= 0;
            p_xz <= 0;
            p_yz <= 0;
            p_sub <= 0;
            p_x <= 0;
        end else begin
            p_ssum <= ssum;
            p_sdif <= sdif;
            p_xe <= xe;
            p_xs <= xs;
            p_xz <= xz;
            p_yz <= yz;
            p_sub <= sub;
            p_x <= x;
        end
    end
endmodule
