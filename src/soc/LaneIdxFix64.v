module LaneIdxFix64 (
    input clk,
    input rst_n,
    input [31:0] base,
    input [31:0] base_pre,
    input [31:0] base_pre2,
    input v,
    input ph,
    input en,
    output logic [7:0] e,
    output logic [1023:0] f,
    output logic [1023:0] fq,
    output logic ov
);
    logic [31:0] last;
    logic [31:0] ab0_n;
    logic [31:0] ab0_out;
    logic [31:0] ab1_n;
    logic [31:0] ab1_out;
    logic [31:0] q_ab0;
    logic [31:0] q_ab1;
    logic [31:0] hi;
    logic nz_pc;
    logic [5:0] msb_c;
    logic [5:0] q_msb;
    logic q_nz;
    logic nz_c;
    logic [5:0] msb;
    logic [9:0] eraw;
    logic e_hi;
    logic [7:0] ecl;
    logic [7:0] e_c;
    logic [6:0] sv;
    logic s_pos_c;
    logic [3:0] lsh;
    logic [14:0] lsh_oh_c;
    logic [15:0] p_base_g_0;
    logic [15:0] p_base_g_1;
    logic [15:0] p_base_g_2;
    logic [15:0] p_base_g_3;
    logic [15:0] p_base_g_4;
    logic [15:0] p_base_g_5;
    logic [15:0] p_base_g_6;
    logic [15:0] p_base_g_7;
    logic [14:0] p_oh_g_0;
    logic [14:0] p_oh_g_1;
    logic [14:0] p_oh_g_2;
    logic [14:0] p_oh_g_3;
    logic [14:0] p_oh_g_4;
    logic [14:0] p_oh_g_5;
    logic [14:0] p_oh_g_6;
    logic [14:0] p_oh_g_7;
    logic [7:0] p_e;
    logic vH0;
    logic vH1;
    logic [511:0] pq;
    logic [511:0] f_lo;
    logic [15:0] base16;
    logic [15:0] oh2_g_0;
    logic [15:0] oh2_g_1;
    logic [15:0] oh2_g_2;
    logic [15:0] oh2_g_3;
    logic [15:0] oh2_g_4;
    logic [15:0] oh2_g_5;
    logic [15:0] oh2_g_6;
    logic [15:0] oh2_g_7;
    logic [15:0] ln_0_c;
    logic [30:0] ln_0_pl;
    logic [15:0] ln_1_c;
    logic [30:0] ln_1_pl;
    logic [15:0] ln_2_c;
    logic [30:0] ln_2_pl;
    logic [15:0] ln_3_c;
    logic [30:0] ln_3_pl;
    logic [15:0] ln_4_c;
    logic [30:0] ln_4_pl;
    logic [15:0] ln_5_c;
    logic [30:0] ln_5_pl;
    logic [15:0] ln_6_c;
    logic [30:0] ln_6_pl;
    logic [15:0] ln_7_c;
    logic [30:0] ln_7_pl;
    logic [15:0] ln_8_c;
    logic [30:0] ln_8_pl;
    logic [15:0] ln_9_c;
    logic [30:0] ln_9_pl;
    logic [15:0] ln_10_c;
    logic [30:0] ln_10_pl;
    logic [15:0] ln_11_c;
    logic [30:0] ln_11_pl;
    logic [15:0] ln_12_c;
    logic [30:0] ln_12_pl;
    logic [15:0] ln_13_c;
    logic [30:0] ln_13_pl;
    logic [15:0] ln_14_c;
    logic [30:0] ln_14_pl;
    logic [15:0] ln_15_c;
    logic [30:0] ln_15_pl;
    logic [15:0] ln_16_c;
    logic [30:0] ln_16_pl;
    logic [15:0] ln_17_c;
    logic [30:0] ln_17_pl;
    logic [15:0] ln_18_c;
    logic [30:0] ln_18_pl;
    logic [15:0] ln_19_c;
    logic [30:0] ln_19_pl;
    logic [15:0] ln_20_c;
    logic [30:0] ln_20_pl;
    logic [15:0] ln_21_c;
    logic [30:0] ln_21_pl;
    logic [15:0] ln_22_c;
    logic [30:0] ln_22_pl;
    logic [15:0] ln_23_c;
    logic [30:0] ln_23_pl;
    logic [15:0] ln_24_c;
    logic [30:0] ln_24_pl;
    logic [15:0] ln_25_c;
    logic [30:0] ln_25_pl;
    logic [15:0] ln_26_c;
    logic [30:0] ln_26_pl;
    logic [15:0] ln_27_c;
    logic [30:0] ln_27_pl;
    logic [15:0] ln_28_c;
    logic [30:0] ln_28_pl;
    logic [15:0] ln_29_c;
    logic [30:0] ln_29_pl;
    logic [15:0] ln_30_c;
    logic [30:0] ln_30_pl;
    logic [15:0] ln_31_c;
    logic [30:0] ln_31_pl;
    logic [511:0] half_out;
    logic [511:0] f_lo_c;
    logic [4:0] u_lz_msb;

    assign last = (base_pre2 + 32'd63);
    assign ab0_n = (base_pre2 ^ {32{base_pre2[31]}});
    assign ab0_out = (ab0_n + {31'd0, base_pre2[31]});
    assign ab1_n = (last ^ {32{last[31]}});
    assign ab1_out = (ab1_n + {31'd0, last[31]});
    assign hi = ((q_ab0 < q_ab1) ? q_ab1 : q_ab0);
    assign nz_pc = (hi != 32'd0);
    assign msb_c = u_lz_msb;
    assign nz_c = q_nz;
    assign msb = q_msb;
    assign eraw = ({4'd0, msb} + 10'd128);
    assign e_hi = (eraw[9:8] != 2'd0);
    assign ecl = (e_hi ? 8'd255 : eraw[7:0]);
    assign e_c = (nz_c ? ecl : 8'd0);
    assign sv = (7'd14 - {1'd0, msb});
    assign s_pos_c = ((~sv[6]) & (sv != 7'd0));
    assign lsh = (s_pos_c ? sv[3:0] : 4'd0);
    assign lsh_oh_c = (15'd1 << lsh);
    assign e = p_e;
    assign base16 = base[15:0];
    assign oh2_g_0 = {p_oh_g_0, 1'd0};
    assign oh2_g_1 = {p_oh_g_1, 1'd0};
    assign oh2_g_2 = {p_oh_g_2, 1'd0};
    assign oh2_g_3 = {p_oh_g_3, 1'd0};
    assign oh2_g_4 = {p_oh_g_4, 1'd0};
    assign oh2_g_5 = {p_oh_g_5, 1'd0};
    assign oh2_g_6 = {p_oh_g_6, 1'd0};
    assign oh2_g_7 = {p_oh_g_7, 1'd0};
    assign ln_0_c = 16'd0;
    assign ln_0_pl = ((p_base_g_0 * p_oh_g_0) + ln_0_c);
    assign ln_1_c = (16'd0 | (oh2_g_0 << 0));
    assign ln_1_pl = ((p_base_g_0 * p_oh_g_0) + ln_1_c);
    assign ln_2_c = (16'd0 | (oh2_g_0 << 1));
    assign ln_2_pl = ((p_base_g_0 * p_oh_g_0) + ln_2_c);
    assign ln_3_c = ((16'd0 | (oh2_g_0 << 0)) | (oh2_g_0 << 1));
    assign ln_3_pl = ((p_base_g_0 * p_oh_g_0) + ln_3_c);
    assign ln_4_c = (16'd0 | (oh2_g_1 << 2));
    assign ln_4_pl = ((p_base_g_1 * p_oh_g_1) + ln_4_c);
    assign ln_5_c = ((16'd0 | (oh2_g_1 << 0)) | (oh2_g_1 << 2));
    assign ln_5_pl = ((p_base_g_1 * p_oh_g_1) + ln_5_c);
    assign ln_6_c = ((16'd0 | (oh2_g_1 << 1)) | (oh2_g_1 << 2));
    assign ln_6_pl = ((p_base_g_1 * p_oh_g_1) + ln_6_c);
    assign ln_7_c = (((16'd0 | (oh2_g_1 << 0)) | (oh2_g_1 << 1)) | (oh2_g_1 << 2));
    assign ln_7_pl = ((p_base_g_1 * p_oh_g_1) + ln_7_c);
    assign ln_8_c = (16'd0 | (oh2_g_2 << 3));
    assign ln_8_pl = ((p_base_g_2 * p_oh_g_2) + ln_8_c);
    assign ln_9_c = ((16'd0 | (oh2_g_2 << 0)) | (oh2_g_2 << 3));
    assign ln_9_pl = ((p_base_g_2 * p_oh_g_2) + ln_9_c);
    assign ln_10_c = ((16'd0 | (oh2_g_2 << 1)) | (oh2_g_2 << 3));
    assign ln_10_pl = ((p_base_g_2 * p_oh_g_2) + ln_10_c);
    assign ln_11_c = (((16'd0 | (oh2_g_2 << 0)) | (oh2_g_2 << 1)) | (oh2_g_2 << 3));
    assign ln_11_pl = ((p_base_g_2 * p_oh_g_2) + ln_11_c);
    assign ln_12_c = ((16'd0 | (oh2_g_3 << 2)) | (oh2_g_3 << 3));
    assign ln_12_pl = ((p_base_g_3 * p_oh_g_3) + ln_12_c);
    assign ln_13_c = (((16'd0 | (oh2_g_3 << 0)) | (oh2_g_3 << 2)) | (oh2_g_3 << 3));
    assign ln_13_pl = ((p_base_g_3 * p_oh_g_3) + ln_13_c);
    assign ln_14_c = (((16'd0 | (oh2_g_3 << 1)) | (oh2_g_3 << 2)) | (oh2_g_3 << 3));
    assign ln_14_pl = ((p_base_g_3 * p_oh_g_3) + ln_14_c);
    assign ln_15_c = ((((16'd0 | (oh2_g_3 << 0)) | (oh2_g_3 << 1)) | (oh2_g_3 << 2)) | (oh2_g_3 << 3));
    assign ln_15_pl = ((p_base_g_3 * p_oh_g_3) + ln_15_c);
    assign ln_16_c = (16'd0 | (oh2_g_4 << 4));
    assign ln_16_pl = ((p_base_g_4 * p_oh_g_4) + ln_16_c);
    assign ln_17_c = ((16'd0 | (oh2_g_4 << 0)) | (oh2_g_4 << 4));
    assign ln_17_pl = ((p_base_g_4 * p_oh_g_4) + ln_17_c);
    assign ln_18_c = ((16'd0 | (oh2_g_4 << 1)) | (oh2_g_4 << 4));
    assign ln_18_pl = ((p_base_g_4 * p_oh_g_4) + ln_18_c);
    assign ln_19_c = (((16'd0 | (oh2_g_4 << 0)) | (oh2_g_4 << 1)) | (oh2_g_4 << 4));
    assign ln_19_pl = ((p_base_g_4 * p_oh_g_4) + ln_19_c);
    assign ln_20_c = ((16'd0 | (oh2_g_5 << 2)) | (oh2_g_5 << 4));
    assign ln_20_pl = ((p_base_g_5 * p_oh_g_5) + ln_20_c);
    assign ln_21_c = (((16'd0 | (oh2_g_5 << 0)) | (oh2_g_5 << 2)) | (oh2_g_5 << 4));
    assign ln_21_pl = ((p_base_g_5 * p_oh_g_5) + ln_21_c);
    assign ln_22_c = (((16'd0 | (oh2_g_5 << 1)) | (oh2_g_5 << 2)) | (oh2_g_5 << 4));
    assign ln_22_pl = ((p_base_g_5 * p_oh_g_5) + ln_22_c);
    assign ln_23_c = ((((16'd0 | (oh2_g_5 << 0)) | (oh2_g_5 << 1)) | (oh2_g_5 << 2)) | (oh2_g_5 << 4));
    assign ln_23_pl = ((p_base_g_5 * p_oh_g_5) + ln_23_c);
    assign ln_24_c = ((16'd0 | (oh2_g_6 << 3)) | (oh2_g_6 << 4));
    assign ln_24_pl = ((p_base_g_6 * p_oh_g_6) + ln_24_c);
    assign ln_25_c = (((16'd0 | (oh2_g_6 << 0)) | (oh2_g_6 << 3)) | (oh2_g_6 << 4));
    assign ln_25_pl = ((p_base_g_6 * p_oh_g_6) + ln_25_c);
    assign ln_26_c = (((16'd0 | (oh2_g_6 << 1)) | (oh2_g_6 << 3)) | (oh2_g_6 << 4));
    assign ln_26_pl = ((p_base_g_6 * p_oh_g_6) + ln_26_c);
    assign ln_27_c = ((((16'd0 | (oh2_g_6 << 0)) | (oh2_g_6 << 1)) | (oh2_g_6 << 3)) | (oh2_g_6 << 4));
    assign ln_27_pl = ((p_base_g_6 * p_oh_g_6) + ln_27_c);
    assign ln_28_c = (((16'd0 | (oh2_g_7 << 2)) | (oh2_g_7 << 3)) | (oh2_g_7 << 4));
    assign ln_28_pl = ((p_base_g_7 * p_oh_g_7) + ln_28_c);
    assign ln_29_c = ((((16'd0 | (oh2_g_7 << 0)) | (oh2_g_7 << 2)) | (oh2_g_7 << 3)) | (oh2_g_7 << 4));
    assign ln_29_pl = ((p_base_g_7 * p_oh_g_7) + ln_29_c);
    assign ln_30_c = ((((16'd0 | (oh2_g_7 << 1)) | (oh2_g_7 << 2)) | (oh2_g_7 << 3)) | (oh2_g_7 << 4));
    assign ln_30_pl = ((p_base_g_7 * p_oh_g_7) + ln_30_c);
    assign ln_31_c = (((((16'd0 | (oh2_g_7 << 0)) | (oh2_g_7 << 1)) | (oh2_g_7 << 2)) | (oh2_g_7 << 3))
                      | (oh2_g_7 << 4));
    assign ln_31_pl = ((p_base_g_7 * p_oh_g_7) + ln_31_c);
    assign half_out = {ln_31_pl[15:0], ln_30_pl[15:0], ln_29_pl[15:0], ln_28_pl[15:0], ln_27_pl[15:0], ln_26_pl[15:0],
                       ln_25_pl[15:0], ln_24_pl[15:0], ln_23_pl[15:0], ln_22_pl[15:0], ln_21_pl[15:0], ln_20_pl[15:0],
                       ln_19_pl[15:0], ln_18_pl[15:0], ln_17_pl[15:0], ln_16_pl[15:0], ln_15_pl[15:0], ln_14_pl[15:0],
                       ln_13_pl[15:0], ln_12_pl[15:0], ln_11_pl[15:0], ln_10_pl[15:0], ln_9_pl[15:0], ln_8_pl[15:0],
                       ln_7_pl[15:0], ln_6_pl[15:0], ln_5_pl[15:0], ln_4_pl[15:0], ln_3_pl[15:0], ln_2_pl[15:0],
                       ln_1_pl[15:0], ln_0_pl[15:0]};
    assign f_lo_c = (vH1 ? pq : f_lo);
    assign f = {half_out[511:496], f_lo_c[511:496], half_out[495:480], f_lo_c[495:480], half_out[479:464],
                f_lo_c[479:464], half_out[463:448], f_lo_c[463:448], half_out[447:432], f_lo_c[447:432],
                half_out[431:416], f_lo_c[431:416], half_out[415:400], f_lo_c[415:400], half_out[399:384],
                f_lo_c[399:384], half_out[383:368], f_lo_c[383:368], half_out[367:352], f_lo_c[367:352],
                half_out[351:336], f_lo_c[351:336], half_out[335:320], f_lo_c[335:320], half_out[319:304],
                f_lo_c[319:304], half_out[303:288], f_lo_c[303:288], half_out[287:272], f_lo_c[287:272],
                half_out[271:256], f_lo_c[271:256], half_out[255:240], f_lo_c[255:240], half_out[239:224],
                f_lo_c[239:224], half_out[223:208], f_lo_c[223:208], half_out[207:192], f_lo_c[207:192],
                half_out[191:176], f_lo_c[191:176], half_out[175:160], f_lo_c[175:160], half_out[159:144],
                f_lo_c[159:144], half_out[143:128], f_lo_c[143:128], half_out[127:112], f_lo_c[127:112],
                half_out[111:96], f_lo_c[111:96], half_out[95:80], f_lo_c[95:80], half_out[79:64], f_lo_c[79:64],
                half_out[63:48], f_lo_c[63:48], half_out[47:32], f_lo_c[47:32], half_out[31:16], f_lo_c[31:16],
                half_out[15:0], f_lo_c[15:0]};
    assign fq = {pq[511:496], f_lo[511:496], pq[495:480], f_lo[495:480], pq[479:464], f_lo[479:464], pq[463:448],
                 f_lo[463:448], pq[447:432], f_lo[447:432], pq[431:416], f_lo[431:416], pq[415:400], f_lo[415:400],
                 pq[399:384], f_lo[399:384], pq[383:368], f_lo[383:368], pq[367:352], f_lo[367:352], pq[351:336],
                 f_lo[351:336], pq[335:320], f_lo[335:320], pq[319:304], f_lo[319:304], pq[303:288], f_lo[303:288],
                 pq[287:272], f_lo[287:272], pq[271:256], f_lo[271:256], pq[255:240], f_lo[255:240], pq[239:224],
                 f_lo[239:224], pq[223:208], f_lo[223:208], pq[207:192], f_lo[207:192], pq[191:176], f_lo[191:176],
                 pq[175:160], f_lo[175:160], pq[159:144], f_lo[159:144], pq[143:128], f_lo[143:128], pq[127:112],
                 f_lo[127:112], pq[111:96], f_lo[111:96], pq[95:80], f_lo[95:80], pq[79:64], f_lo[79:64], pq[63:48],
                 f_lo[63:48], pq[47:32], f_lo[47:32], pq[31:16], f_lo[31:16], pq[15:0], f_lo[15:0]};
    assign ov = vH1;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q_ab0 <= 0;
            q_ab1 <= 0;
            q_msb <= 0;
            q_nz <= 0;
            p_base_g_0 <= 0;
            p_base_g_1 <= 0;
            p_base_g_2 <= 0;
            p_base_g_3 <= 0;
            p_base_g_4 <= 0;
            p_base_g_5 <= 0;
            p_base_g_6 <= 0;
            p_base_g_7 <= 0;
            p_oh_g_0 <= 0;
            p_oh_g_1 <= 0;
            p_oh_g_2 <= 0;
            p_oh_g_3 <= 0;
            p_oh_g_4 <= 0;
            p_oh_g_5 <= 0;
            p_oh_g_6 <= 0;
            p_oh_g_7 <= 0;
            p_e <= 0;
            vH0 <= 0;
            f_lo <= 0;
            vH1 <= 0;
        end else begin
            if (en) begin
                q_ab0 <= ab0_out;
                q_ab1 <= ab1_out;
                q_msb <= msb_c;
                q_nz <= nz_pc;
                if (vH0) begin
                    p_base_g_0 <= (p_base_g_0 + 1);
                    p_base_g_1 <= (p_base_g_1 + 1);
                    p_base_g_2 <= (p_base_g_2 + 1);
                    p_base_g_3 <= (p_base_g_3 + 1);
                    p_base_g_4 <= (p_base_g_4 + 1);
                    p_base_g_5 <= (p_base_g_5 + 1);
                    p_base_g_6 <= (p_base_g_6 + 1);
                    p_base_g_7 <= (p_base_g_7 + 1);
                end
                if ((v & (~ph))) begin
                    p_base_g_0 <= (base16 ^ 16'd32768);
                    p_oh_g_0 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_1 <= (base16 ^ 16'd32768);
                    p_oh_g_1 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_2 <= (base16 ^ 16'd32768);
                    p_oh_g_2 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_3 <= (base16 ^ 16'd32768);
                    p_oh_g_3 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_4 <= (base16 ^ 16'd32768);
                    p_oh_g_4 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_5 <= (base16 ^ 16'd32768);
                    p_oh_g_5 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_6 <= (base16 ^ 16'd32768);
                    p_oh_g_6 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_base_g_7 <= (base16 ^ 16'd32768);
                    p_oh_g_7 <= (nz_c ? lsh_oh_c : 15'd0);
                    p_e <= e_c;
                end
                vH0 <= (v & (~ph));
                if (vH1) begin
                    f_lo <= pq;
                end
                vH1 <= vH0;
            end
        end
    end
    always_ff @(posedge clk) begin
        if (en) begin
            pq <= half_out;
        end
    end

    Lzd u_lz (
        .src(hi),
        .msb(u_lz_msb)
    );
endmodule
