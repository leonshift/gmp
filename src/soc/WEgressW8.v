module WEgressW8 (
    input clk,
    input rst_n,
    input i_valid,
    input [3:0] i_id,
    input [1023:0] i_data,
    input [127:0] i_strb,
    output logic [7:0] i_ready,
    output logic o_valid,
    output logic [3:0] o_id,
    output logic [1023:0] o_data,
    output logic [127:0] o_strb,
    input [7:0] o_ready,
    output logic [7:0] i_room
);
    logic [3:0] n_0;
    logic [3:0] n_1;
    logic [3:0] n_2;
    logic [3:0] n_3;
    logic [3:0] n_4;
    logic [3:0] n_5;
    logic [3:0] n_6;
    logic [3:0] n_7;
    logic [2:0] rp_0;
    logic [2:0] rp_1;
    logic [2:0] rp_2;
    logic [2:0] rp_3;
    logic [2:0] rp_4;
    logic [2:0] rp_5;
    logic [2:0] rp_6;
    logic [2:0] rp_7;
    logic [2:0] wp_0;
    logic [2:0] wp_1;
    logic [2:0] wp_2;
    logic [2:0] wp_3;
    logic [2:0] wp_4;
    logic [2:0] wp_5;
    logic [2:0] wp_6;
    logic [2:0] wp_7;
    logic [1023:0] s_dat [0:63];
    logic [127:0] s_stb [0:63];
    logic v_q;
    logic [2:0] sel_q;
    logic [2:0] iw;
    logic [3:0] i_n;
    logic [2:0] i_wp;
    logic acc;
    logic [5:0] ridx;
    logic [1023:0] od;
    logic [127:0] os;
    logic [7:0] owr;
    logic pop;
    logic [7:0] sv_p;
    logic [7:0] sv_n;
    logic [2:0] pr_n;
    logic [7:0] rot_p;
    logic [7:0] rot_n;
    logic [2:0] k_p;
    logic [2:0] k_n;
    logic [2:0] sel_p;
    logic [2:0] sel_n;
    logic [5:0] widx;
    logic inc__i0;
    logic dec__i0;
    logic inc__i1;
    logic dec__i1;
    logic inc__i2;
    logic dec__i2;
    logic inc__i3;
    logic dec__i3;
    logic inc__i4;
    logic dec__i4;
    logic inc__i5;
    logic dec__i5;
    logic inc__i6;
    logic dec__i6;
    logic inc__i7;
    logic dec__i7;

    assign iw = i_id[2:0];
    assign i_n = ((iw == 0) ? n_0 :
                 ((iw == 1) ? n_1 :
                 ((iw == 2) ? n_2 :
                 ((iw == 3) ? n_3 :
                 ((iw == 4) ? n_4 :
                 ((iw == 5) ? n_5 :
                 ((iw == 6) ? n_6 :
                 n_7)))))));
    assign i_wp = ((iw == 0) ? wp_0 :
                  ((iw == 1) ? wp_1 :
                  ((iw == 2) ? wp_2 :
                  ((iw == 3) ? wp_3 :
                  ((iw == 4) ? wp_4 :
                  ((iw == 5) ? wp_5 :
                  ((iw == 6) ? wp_6 :
                  wp_7)))))));
    assign acc = (i_valid & (i_n != 8));
    assign i_ready = (acc ? (8'd1 << iw) : 8'd0);
    assign i_room = {(n_7 <= 4), (n_6 <= 4), (n_5 <= 4), (n_4 <= 4), (n_3 <= 4), (n_2 <= 4), (n_1 <= 4), (n_0 <= 4)};
    assign ridx = {sel_q,
                   ((sel_q == 0) ? rp_0 :
                   ((sel_q == 1) ? rp_1 :
                   ((sel_q == 2) ? rp_2 :
                   ((sel_q == 3) ? rp_3 :
                   ((sel_q == 4) ? rp_4 :
                   ((sel_q == 5) ? rp_5 :
                   ((sel_q == 6) ? rp_6 :
                   rp_7)))))))};
    assign o_valid = v_q;
    assign o_id = {1'd0, sel_q};
    assign o_data = od;
    assign o_strb = os;
    assign owr = (o_ready >> sel_q);
    assign pop = (v_q & owr[0]);
    assign sv_p = {((sel_q == 7) ? ((n_7 >= 2) | (acc & (iw == 7))) : ((n_7 != 0) | (acc & (iw == 7)))),
                   ((sel_q == 6) ? ((n_6 >= 2) | (acc & (iw == 6))) : ((n_6 != 0) | (acc & (iw == 6)))),
                   ((sel_q == 5) ? ((n_5 >= 2) | (acc & (iw == 5))) : ((n_5 != 0) | (acc & (iw == 5)))),
                   ((sel_q == 4) ? ((n_4 >= 2) | (acc & (iw == 4))) : ((n_4 != 0) | (acc & (iw == 4)))),
                   ((sel_q == 3) ? ((n_3 >= 2) | (acc & (iw == 3))) : ((n_3 != 0) | (acc & (iw == 3)))),
                   ((sel_q == 2) ? ((n_2 >= 2) | (acc & (iw == 2))) : ((n_2 != 0) | (acc & (iw == 2)))),
                   ((sel_q == 1) ? ((n_1 >= 2) | (acc & (iw == 1))) : ((n_1 != 0) | (acc & (iw == 1)))),
                   ((sel_q == 0) ? ((n_0 >= 2) | (acc & (iw == 0))) : ((n_0 != 0) | (acc & (iw == 0))))};
    assign sv_n = {((n_7 != 0) | (acc & (iw == 7))), ((n_6 != 0) | (acc & (iw == 6))), ((n_5 != 0) | (acc & (iw == 5))),
                   ((n_4 != 0) | (acc & (iw == 4))), ((n_3 != 0) | (acc & (iw == 3))), ((n_2 != 0) | (acc & (iw == 2))),
                   ((n_1 != 0) | (acc & (iw == 1))), ((n_0 != 0) | (acc & (iw == 0)))};
    assign pr_n = (sel_q + 1);
    assign rot_p = ((sv_p >> sel_q) | (sv_p << (4'd8 - {1'd0, sel_q})));
    assign rot_n = ((sv_n >> pr_n) | (sv_n << (4'd8 - {1'd0, pr_n})));
    assign k_p = (rot_p[0] ? 3'd0 :
                 (rot_p[1] ? 3'd1 :
                 (rot_p[2] ? 3'd2 :
                 (rot_p[3] ? 3'd3 :
                 (rot_p[4] ? 3'd4 :
                 (rot_p[5] ? 3'd5 :
                 (rot_p[6] ? 3'd6 :
                 3'd7)))))));
    assign k_n = (rot_n[0] ? 3'd0 :
                 (rot_n[1] ? 3'd1 :
                 (rot_n[2] ? 3'd2 :
                 (rot_n[3] ? 3'd3 :
                 (rot_n[4] ? 3'd4 :
                 (rot_n[5] ? 3'd5 :
                 (rot_n[6] ? 3'd6 :
                 3'd7)))))));
    assign sel_p = (sel_q + k_p);
    assign sel_n = (pr_n + k_n);
    assign widx = {iw, i_wp};
    assign inc__i0 = (acc & (iw == 0));
    assign dec__i0 = (pop & (sel_q == 0));
    assign inc__i1 = (acc & (iw == 1));
    assign dec__i1 = (pop & (sel_q == 1));
    assign inc__i2 = (acc & (iw == 2));
    assign dec__i2 = (pop & (sel_q == 2));
    assign inc__i3 = (acc & (iw == 3));
    assign dec__i3 = (pop & (sel_q == 3));
    assign inc__i4 = (acc & (iw == 4));
    assign dec__i4 = (pop & (sel_q == 4));
    assign inc__i5 = (acc & (iw == 5));
    assign dec__i5 = (pop & (sel_q == 5));
    assign inc__i6 = (acc & (iw == 6));
    assign dec__i6 = (pop & (sel_q == 6));
    assign inc__i7 = (acc & (iw == 7));
    assign dec__i7 = (pop & (sel_q == 7));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wp_0 <= 0;
            rp_0 <= 0;
            n_0 <= 0;
            wp_1 <= 0;
            rp_1 <= 0;
            n_1 <= 0;
            wp_2 <= 0;
            rp_2 <= 0;
            n_2 <= 0;
            wp_3 <= 0;
            rp_3 <= 0;
            n_3 <= 0;
            wp_4 <= 0;
            rp_4 <= 0;
            n_4 <= 0;
            wp_5 <= 0;
            rp_5 <= 0;
            n_5 <= 0;
            wp_6 <= 0;
            rp_6 <= 0;
            n_6 <= 0;
            wp_7 <= 0;
            rp_7 <= 0;
            n_7 <= 0;
            sel_q <= 7;
            v_q <= 0;
        end else begin
            if (inc__i0) begin
                wp_0 <= (wp_0 + 1);
            end
            if (dec__i0) begin
                rp_0 <= (rp_0 + 1);
            end
            if ((inc__i0 & (~dec__i0))) begin
                n_0 <= (n_0 + 1);
            end else begin
                if ((dec__i0 & (~inc__i0))) begin
                    n_0 <= (n_0 - 1);
                end
            end
            if (inc__i1) begin
                wp_1 <= (wp_1 + 1);
            end
            if (dec__i1) begin
                rp_1 <= (rp_1 + 1);
            end
            if ((inc__i1 & (~dec__i1))) begin
                n_1 <= (n_1 + 1);
            end else begin
                if ((dec__i1 & (~inc__i1))) begin
                    n_1 <= (n_1 - 1);
                end
            end
            if (inc__i2) begin
                wp_2 <= (wp_2 + 1);
            end
            if (dec__i2) begin
                rp_2 <= (rp_2 + 1);
            end
            if ((inc__i2 & (~dec__i2))) begin
                n_2 <= (n_2 + 1);
            end else begin
                if ((dec__i2 & (~inc__i2))) begin
                    n_2 <= (n_2 - 1);
                end
            end
            if (inc__i3) begin
                wp_3 <= (wp_3 + 1);
            end
            if (dec__i3) begin
                rp_3 <= (rp_3 + 1);
            end
            if ((inc__i3 & (~dec__i3))) begin
                n_3 <= (n_3 + 1);
            end else begin
                if ((dec__i3 & (~inc__i3))) begin
                    n_3 <= (n_3 - 1);
                end
            end
            if (inc__i4) begin
                wp_4 <= (wp_4 + 1);
            end
            if (dec__i4) begin
                rp_4 <= (rp_4 + 1);
            end
            if ((inc__i4 & (~dec__i4))) begin
                n_4 <= (n_4 + 1);
            end else begin
                if ((dec__i4 & (~inc__i4))) begin
                    n_4 <= (n_4 - 1);
                end
            end
            if (inc__i5) begin
                wp_5 <= (wp_5 + 1);
            end
            if (dec__i5) begin
                rp_5 <= (rp_5 + 1);
            end
            if ((inc__i5 & (~dec__i5))) begin
                n_5 <= (n_5 + 1);
            end else begin
                if ((dec__i5 & (~inc__i5))) begin
                    n_5 <= (n_5 - 1);
                end
            end
            if (inc__i6) begin
                wp_6 <= (wp_6 + 1);
            end
            if (dec__i6) begin
                rp_6 <= (rp_6 + 1);
            end
            if ((inc__i6 & (~dec__i6))) begin
                n_6 <= (n_6 + 1);
            end else begin
                if ((dec__i6 & (~inc__i6))) begin
                    n_6 <= (n_6 - 1);
                end
            end
            if (inc__i7) begin
                wp_7 <= (wp_7 + 1);
            end
            if (dec__i7) begin
                rp_7 <= (rp_7 + 1);
            end
            if ((inc__i7 & (~dec__i7))) begin
                n_7 <= (n_7 + 1);
            end else begin
                if ((dec__i7 & (~inc__i7))) begin
                    n_7 <= (n_7 - 1);
                end
            end
            sel_q <= (pop ? sel_p : sel_n);
            v_q <= (pop ? (sv_p != 0) : (sv_n != 0));
        end
    end
    always_ff @(posedge clk) begin
        od <= s_dat[ridx];
        os <= s_stb[ridx];
        if (acc) begin
            s_dat[widx] <= i_data;
            s_stb[widx] <= i_strb;
        end
    end
endmodule
