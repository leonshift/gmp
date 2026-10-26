module KBitStream (
    input clk,
    input rst_n,
    input [127:0] im_data,
    input im_gnt,
    output logic im_req,
    output logic [11:0] im_addr,
    input seek_v,
    input [11:0] seek_line,
    input [6:0] seek_bit,
    input get_v,
    input [5:0] get_w,
    input req_v,
    input req_pre,
    output logic ready,
    output logic [18:0] pos,
    output logic [31:0] hd,
    output logic [31:0] val,
    output logic rq_f,
    output logic rq_x
);
    logic [127:0] ln0;
    logic [127:0] ln1;
    logic p;
    logic [31:0] head;
    logic [6:0] bpos;
    logic [11:0] line_no;
    logic [11:0] ln1_q;
    logic [11:0] ln2_q;
    logic [2:0] fill;
    logic [4:0] sb_q;
    logic [2:0] sh_q;
    logic [5:0] tsb_q;
    logic [5:0] vshift;
    logic [7:0] bsum;
    logic gx;
    logic xrow;
    logic xreq;
    logic [255:0] ring;
    logic [287:0] ring2;
    logic [39:0] win_c;
    logic [39:0] win_f;
    logic [31:0] w32;
    logic [5:0] t_sh;
    logic [39:0] t_fine;
    logic [39:0] t_all;
    logic [31:0] h_fine;
    logic [31:0] h_hi;
    logic [31:0] lo_w;
    logic [31:0] h_get;
    logic [31:0] nx32;
    logic [63:0] nx_z;
    logic [63:0] nx_by;
    logic [63:0] nx_sh;
    logic [31:0] nx_hi;
    logic [63:0] lo_m;
    logic [31:0] fx;
    logic [2:0] fill_n;
    logic [6:0] bpos_n;
    logic p_n;
    logic [7:0] bp32;
    logic [7:0] s32;
    logic [7:0] sel_g;
    logic [7:0] sel_w;
    logic [7:0] sel_n;

    assign ready = (fill == 3);
    assign pos = {line_no, bpos};
    assign hd = head;
    assign vshift = (6'd32 - get_w);
    assign val = (head >> vshift);
    assign bsum = ({1'd0, bpos} + {2'd0, get_w});
    assign gx = (get_v & (fill == 3));
    assign xrow = (gx & bsum[7]);
    assign xreq = ((req_v & (fill == 3)) & (req_pre ? (bpos[6:5] == 3) : bsum[7]));
    assign ring = {{ln0[7:0], ln0[15:8], ln0[23:16], ln0[31:24], ln0[39:32], ln0[47:40], ln0[55:48], ln0[63:56],
                    ln0[71:64], ln0[79:72], ln0[87:80], ln0[95:88], ln0[103:96], ln0[111:104], ln0[119:112],
                    ln0[127:120]},
                   {ln1[7:0], ln1[15:8], ln1[23:16], ln1[31:24], ln1[39:32], ln1[47:40], ln1[55:48], ln1[63:56],
                    ln1[71:64], ln1[79:72], ln1[87:80], ln1[95:88], ln1[103:96], ln1[111:104], ln1[119:112],
                    ln1[127:120]}};
    assign ring2 = {ring, ring[255:224]};
    assign win_c = ((sb_q == 0) ? ring2[287:248] :
                   ((sb_q == 1) ? ring2[279:240] :
                   ((sb_q == 2) ? ring2[271:232] :
                   ((sb_q == 3) ? ring2[263:224] :
                   ((sb_q == 4) ? ring2[255:216] :
                   ((sb_q == 5) ? ring2[247:208] :
                   ((sb_q == 6) ? ring2[239:200] :
                   ((sb_q == 7) ? ring2[231:192] :
                   ((sb_q == 8) ? ring2[223:184] :
                   ((sb_q == 9) ? ring2[215:176] :
                   ((sb_q == 10) ? ring2[207:168] :
                   ((sb_q == 11) ? ring2[199:160] :
                   ((sb_q == 12) ? ring2[191:152] :
                   ((sb_q == 13) ? ring2[183:144] :
                   ((sb_q == 14) ? ring2[175:136] :
                   ((sb_q == 15) ? ring2[167:128] :
                   ((sb_q == 16) ? ring2[159:120] :
                   ((sb_q == 17) ? ring2[151:112] :
                   ((sb_q == 18) ? ring2[143:104] :
                   ((sb_q == 19) ? ring2[135:96] :
                   ((sb_q == 20) ? ring2[127:88] :
                   ((sb_q == 21) ? ring2[119:80] :
                   ((sb_q == 22) ? ring2[111:72] :
                   ((sb_q == 23) ? ring2[103:64] :
                   ((sb_q == 24) ? ring2[95:56] :
                   ((sb_q == 25) ? ring2[87:48] :
                   ((sb_q == 26) ? ring2[79:40] :
                   ((sb_q == 27) ? ring2[71:32] :
                   ((sb_q == 28) ? ring2[63:24] :
                   ((sb_q == 29) ? ring2[55:16] :
                   ((sb_q == 30) ? ring2[47:8] :
                   ring2[39:0])))))))))))))))))))))))))))))));
    assign win_f = (win_c >> (4'd8 - {1'd0, sh_q}));
    assign w32 = win_f[31:0];
    assign t_sh = (tsb_q - get_w);
    assign t_fine = ((t_sh[3:0] == 0) ? (win_c >> 0) :
                    ((t_sh[3:0] == 1) ? (win_c >> 1) :
                    ((t_sh[3:0] == 2) ? (win_c >> 2) :
                    ((t_sh[3:0] == 3) ? (win_c >> 3) :
                    ((t_sh[3:0] == 4) ? (win_c >> 4) :
                    ((t_sh[3:0] == 5) ? (win_c >> 5) :
                    ((t_sh[3:0] == 6) ? (win_c >> 6) :
                    ((t_sh[3:0] == 7) ? (win_c >> 7) :
                    ((t_sh[3:0] == 8) ? (win_c >> 8) :
                    ((t_sh[3:0] == 9) ? (win_c >> 9) :
                    ((t_sh[3:0] == 10) ? (win_c >> 10) :
                    ((t_sh[3:0] == 11) ? (win_c >> 11) :
                    ((t_sh[3:0] == 12) ? (win_c >> 12) :
                    ((t_sh[3:0] == 13) ? (win_c >> 13) :
                    ((t_sh[3:0] == 14) ? (win_c >> 14) :
                    (win_c >> 15))))))))))))))));
    assign t_all = ((t_sh[5:4] == 0) ? t_fine :
                   ((t_sh[5:4] == 1) ? (t_fine >> 16) :
                   ((t_sh[5:4] == 2) ? (t_fine >> 32) :
                   40'd0)));
    assign h_fine = ((get_w[3:0] == 0) ? (head << 0) :
                    ((get_w[3:0] == 1) ? (head << 1) :
                    ((get_w[3:0] == 2) ? (head << 2) :
                    ((get_w[3:0] == 3) ? (head << 3) :
                    ((get_w[3:0] == 4) ? (head << 4) :
                    ((get_w[3:0] == 5) ? (head << 5) :
                    ((get_w[3:0] == 6) ? (head << 6) :
                    ((get_w[3:0] == 7) ? (head << 7) :
                    ((get_w[3:0] == 8) ? (head << 8) :
                    ((get_w[3:0] == 9) ? (head << 9) :
                    ((get_w[3:0] == 10) ? (head << 10) :
                    ((get_w[3:0] == 11) ? (head << 11) :
                    ((get_w[3:0] == 12) ? (head << 12) :
                    ((get_w[3:0] == 13) ? (head << 13) :
                    ((get_w[3:0] == 14) ? (head << 14) :
                    (head << 15))))))))))))))));
    assign h_hi = ((get_w[5:4] == 0) ? h_fine :
                  ((get_w[5:4] == 1) ? (h_fine << 16) :
                  ((get_w[5:4] == 2) ? 32'd0 :
                  32'd0)));
    assign lo_w = ((get_w == 0) ? 32'd0 :
                  ((get_w == 1) ? 32'd1 :
                  ((get_w == 2) ? 32'd3 :
                  ((get_w == 3) ? 32'd7 :
                  ((get_w == 4) ? 32'd15 :
                  ((get_w == 5) ? 32'd31 :
                  ((get_w == 6) ? 32'd63 :
                  ((get_w == 7) ? 32'd127 :
                  ((get_w == 8) ? 32'd255 :
                  ((get_w == 9) ? 32'd511 :
                  ((get_w == 10) ? 32'd1023 :
                  ((get_w == 11) ? 32'd2047 :
                  ((get_w == 12) ? 32'd4095 :
                  ((get_w == 13) ? 32'd8191 :
                  ((get_w == 14) ? 32'd16383 :
                  ((get_w == 15) ? 32'd32767 :
                  ((get_w == 16) ? 32'd65535 :
                  ((get_w == 17) ? 32'd131071 :
                  ((get_w == 18) ? 32'd262143 :
                  ((get_w == 19) ? 32'd524287 :
                  ((get_w == 20) ? 32'd1048575 :
                  ((get_w == 21) ? 32'd2097151 :
                  ((get_w == 22) ? 32'd4194303 :
                  ((get_w == 23) ? 32'd8388607 :
                  ((get_w == 24) ? 32'd16777215 :
                  ((get_w == 25) ? 32'd33554431 :
                  ((get_w == 26) ? 32'd67108863 :
                  ((get_w == 27) ? 32'd134217727 :
                  ((get_w == 28) ? 32'd268435455 :
                  ((get_w == 29) ? 32'd536870911 :
                  ((get_w == 30) ? 32'd1073741823 :
                  ((get_w == 31) ? 32'd2147483647 :
                  ((get_w == 32) ? 32'd4294967295 :
                  ((get_w == 33) ? 32'd4294967295 :
                  ((get_w == 34) ? 32'd4294967295 :
                  ((get_w == 35) ? 32'd4294967295 :
                  ((get_w == 36) ? 32'd4294967295 :
                  ((get_w == 37) ? 32'd4294967295 :
                  ((get_w == 38) ? 32'd4294967295 :
                  ((get_w == 39) ? 32'd4294967295 :
                  ((get_w == 40) ? 32'd4294967295 :
                  ((get_w == 41) ? 32'd4294967295 :
                  ((get_w == 42) ? 32'd4294967295 :
                  ((get_w == 43) ? 32'd4294967295 :
                  ((get_w == 44) ? 32'd4294967295 :
                  ((get_w == 45) ? 32'd4294967295 :
                  ((get_w == 46) ? 32'd4294967295 :
                  ((get_w == 47) ? 32'd4294967295 :
                  ((get_w == 48) ? 32'd4294967295 :
                  ((get_w == 49) ? 32'd4294967295 :
                  ((get_w == 50) ? 32'd4294967295 :
                  ((get_w == 51) ? 32'd4294967295 :
                  ((get_w == 52) ? 32'd4294967295 :
                  ((get_w == 53) ? 32'd4294967295 :
                  ((get_w == 54) ? 32'd4294967295 :
                  ((get_w == 55) ? 32'd4294967295 :
                  ((get_w == 56) ? 32'd4294967295 :
                  ((get_w == 57) ? 32'd4294967295 :
                  ((get_w == 58) ? 32'd4294967295 :
                  ((get_w == 59) ? 32'd4294967295 :
                  ((get_w == 60) ? 32'd4294967295 :
                  ((get_w == 61) ? 32'd4294967295 :
                  ((get_w == 62) ? 32'd4294967295 :
                  32'd4294967295)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign h_get = (h_hi | (t_all[31:0] & lo_w));
    assign nx32 = {im_data[7:0], im_data[15:8], im_data[23:16], im_data[31:24]};
    assign nx_z = {32'd0, nx32};
    assign nx_by = ((bpos[4:3] == 0) ? nx_z :
                   ((bpos[4:3] == 1) ? (nx_z << 8) :
                   ((bpos[4:3] == 2) ? (nx_z << 16) :
                   (nx_z << 24))));
    assign nx_sh = (nx_by << bpos[2:0]);
    assign nx_hi = nx_sh[63:32];
    assign lo_m = ({32'd0, 32'd4294967295} << bpos[4:0]);
    assign fx = ((bpos[6:5] == 3) ? lo_m[63:32] : 32'd0);
    assign fill_n = (seek_v ? 3'd0 :
                    ((fill == 0) ? (im_gnt ? 3'd1 : 3'd0) :
                    ((fill == 1) ? 3'd4 :
                    ((fill == 2) ? 3'd3 :
                    ((fill == 4) ? (im_gnt ? 3'd2 : 3'd4) :
                    (xrow ? (im_gnt ? 3'd2 : 3'd4) :
                    fill))))));
    assign bpos_n = (seek_v ? seek_bit : (gx ? bsum[6:0] : bpos));
    assign p_n = (p ^ xrow);
    assign bp32 = ({1'd0, bpos} + 32);
    assign s32 = (bp32 + {2'd0, get_w});
    assign sel_g = (bsum[7] ? {(~p), bsum[6:0]} : {(s32[7] ^ p), s32[6:0]});
    assign sel_w = {(bp32[7] ^ p), bp32[6:0]};
    assign sel_n = (seek_v ? {p_n, seek_bit} : ((fill == 2) ? sel_w : ((fill == 3) ? (gx ? sel_g : sel_w) : {p, bpos})));
    assign im_req = (((fill == 0) | (fill == 4)) | xreq);
    assign rq_f = ((fill == 0) | (fill == 4));
    assign rq_x = xreq;
    assign im_addr = ((fill == 0) ? line_no : ((fill == 4) ? ln1_q : ln2_q));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ln1 <= 0;
            ln0 <= 0;
            head <= 0;
            fill <= 0;
            bpos <= 0;
            p <= 0;
            sb_q <= 0;
            sh_q <= 0;
            tsb_q <= 40;
            ln1_q <= 1;
            ln2_q <= 2;
            line_no <= 0;
        end else begin
            if ((fill == 1)) begin
                if (p) begin
                    ln1 <= im_data;
                end else begin
                    ln0 <= im_data;
                end
            end else begin
                if ((fill == 2)) begin
                    if (p) begin
                        ln0 <= im_data;
                    end else begin
                        ln1 <= im_data;
                    end
                    if (fx[0]) begin
                        head[0] <= nx_hi[0];
                    end
                    if (fx[1]) begin
                        head[1] <= nx_hi[1];
                    end
                    if (fx[2]) begin
                        head[2] <= nx_hi[2];
                    end
                    if (fx[3]) begin
                        head[3] <= nx_hi[3];
                    end
                    if (fx[4]) begin
                        head[4] <= nx_hi[4];
                    end
                    if (fx[5]) begin
                        head[5] <= nx_hi[5];
                    end
                    if (fx[6]) begin
                        head[6] <= nx_hi[6];
                    end
                    if (fx[7]) begin
                        head[7] <= nx_hi[7];
                    end
                    if (fx[8]) begin
                        head[8] <= nx_hi[8];
                    end
                    if (fx[9]) begin
                        head[9] <= nx_hi[9];
                    end
                    if (fx[10]) begin
                        head[10] <= nx_hi[10];
                    end
                    if (fx[11]) begin
                        head[11] <= nx_hi[11];
                    end
                    if (fx[12]) begin
                        head[12] <= nx_hi[12];
                    end
                    if (fx[13]) begin
                        head[13] <= nx_hi[13];
                    end
                    if (fx[14]) begin
                        head[14] <= nx_hi[14];
                    end
                    if (fx[15]) begin
                        head[15] <= nx_hi[15];
                    end
                    if (fx[16]) begin
                        head[16] <= nx_hi[16];
                    end
                    if (fx[17]) begin
                        head[17] <= nx_hi[17];
                    end
                    if (fx[18]) begin
                        head[18] <= nx_hi[18];
                    end
                    if (fx[19]) begin
                        head[19] <= nx_hi[19];
                    end
                    if (fx[20]) begin
                        head[20] <= nx_hi[20];
                    end
                    if (fx[21]) begin
                        head[21] <= nx_hi[21];
                    end
                    if (fx[22]) begin
                        head[22] <= nx_hi[22];
                    end
                    if (fx[23]) begin
                        head[23] <= nx_hi[23];
                    end
                    if (fx[24]) begin
                        head[24] <= nx_hi[24];
                    end
                    if (fx[25]) begin
                        head[25] <= nx_hi[25];
                    end
                    if (fx[26]) begin
                        head[26] <= nx_hi[26];
                    end
                    if (fx[27]) begin
                        head[27] <= nx_hi[27];
                    end
                    if (fx[28]) begin
                        head[28] <= nx_hi[28];
                    end
                    if (fx[29]) begin
                        head[29] <= nx_hi[29];
                    end
                    if (fx[30]) begin
                        head[30] <= nx_hi[30];
                    end
                    if (fx[31]) begin
                        head[31] <= nx_hi[31];
                    end
                end else begin
                    if ((fill == 4)) begin
                        head <= w32;
                    end else begin
                        if ((fill == 3)) begin
                            if (get_v) begin
                                head <= h_get;
                            end
                        end
                    end
                end
            end
            fill <= fill_n;
            bpos <= bpos_n;
            p <= p_n;
            sb_q <= sel_n[7:3];
            sh_q <= sel_n[2:0];
            tsb_q <= (6'd40 - {3'd0, sel_n[2:0]});
            ln1_q <= (line_no + 1);
            ln2_q <= (line_no + 2);
            if (seek_v) begin
                line_no <= seek_line;
            end else begin
                if (xrow) begin
                    line_no <= ln1_q;
                    ln1_q <= ln2_q;
                    ln2_q <= (ln2_q + 1);
                end
            end
        end
    end
endmodule
