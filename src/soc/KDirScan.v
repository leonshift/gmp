module KDirScan (
    input clk,
    input rst_n,
    input [127:0] im_data,
    input im_gnt,
    output logic im_req,
    output logic [11:0] im_addr,
    input find_v,
    input [15:0] find_id,
    input inval,
    output logic busy,
    output logic hit,
    output logic miss,
    output logic [15:0] scan_cnt,
    output logic fresh,
    output logic [15:0] d_st_off,
    output logic [15:0] d_word_off,
    output logic [11:0] d_n_inst,
    output logic [31:0] d_st_bits,
    output logic [31:0] d_leaves
);
    logic [1:0] st;
    logic [15:0] idx;
    logic [15:0] n_kernel;
    logic [11:0] line_q;
    logic need;
    logic wait_d;
    logic [15:0] id_q;
    logic [15:0] cur_id;
    logic cur_ok;
    logic hit_q;
    logic miss_q;
    logic [15:0] scan_q;
    logic fresh_q;
    logic [15:0] f_st_off;
    logic [15:0] f_word_off;
    logic [11:0] f_n_inst;
    logic [31:0] f_st_bits;
    logic [31:0] f_leaves;
    logic last;
    logic d_zero;
    logic d_match;
    logic rd1;
    logic rd2;
    logic need_sh;
    logic need_n;

    assign im_req = need;
    assign im_addr = line_q;
    assign busy = (st != 0);
    assign hit = hit_q;
    assign miss = miss_q;
    assign scan_cnt = scan_q;
    assign fresh = fresh_q;
    assign last = ((idx + 1) >= n_kernel);
    assign d_zero = (im_data[15:0] == 0);
    assign d_match = (im_data[47:32] == id_q);
    assign rd1 = ((st == 1) & wait_d);
    assign rd2 = ((st == 2) & wait_d);
    assign need_sh = (((need & (~im_gnt)) | (((st == 0) & find_v) & (~(cur_ok & (find_id == cur_id)))))
                      | (rd2 & (~last)));
    assign need_n = ((need_sh | (rd1 & (~d_zero))) | (rd2 & d_match));
    assign d_st_off = f_st_off;
    assign d_word_off = f_word_off;
    assign d_n_inst = f_n_inst;
    assign d_st_bits = f_st_bits;
    assign d_leaves = f_leaves;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            hit_q <= 0;
            miss_q <= 0;
            wait_d <= 0;
            need <= 0;
            scan_q <= 0;
            fresh_q <= 0;
            id_q <= 0;
            cur_ok <= 0;
            idx <= 0;
            line_q <= 0;
            st <= 0;
            n_kernel <= 0;
            f_n_inst <= 0;
            f_st_off <= 0;
            f_word_off <= 0;
            f_st_bits <= 0;
            f_leaves <= 0;
            cur_id <= 0;
        end else begin
            hit_q <= 0;
            miss_q <= 0;
            wait_d <= (need & im_gnt);
            need <= need_n;
            case (st)
                0: begin
                    if (find_v) begin
                        if ((cur_ok & (find_id == cur_id))) begin
                            scan_q <= 0;
                            fresh_q <= 0;
                            hit_q <= 1;
                        end else begin
                            id_q <= find_id;
                            cur_ok <= 0;
                            idx <= 0;
                            line_q <= 0;
                            st <= 1;
                        end
                    end
                end
                1: begin
                    if (wait_d) begin
                        n_kernel <= im_data[15:0];
                        f_n_inst <= im_data[59:48];
                        f_st_off <= im_data[79:64];
                        f_word_off <= im_data[95:80];
                        f_st_bits <= im_data[127:96];
                        idx <= 1;
                        line_q <= 1;
                        if (d_zero) begin
                            miss_q <= 1;
                            st <= 0;
                        end else begin
                            st <= (d_match ? 2'd3 : 2'd2);
                        end
                    end
                end
                2: begin
                    if (wait_d) begin
                        f_n_inst <= im_data[59:48];
                        f_st_off <= im_data[79:64];
                        f_word_off <= im_data[95:80];
                        f_st_bits <= im_data[127:96];
                        idx <= (idx + 1);
                        line_q <= (idx[11:0] + 1);
                        if (d_match) begin
                            st <= 3;
                        end else begin
                            if (last) begin
                                miss_q <= 1;
                                st <= 0;
                            end
                        end
                    end
                end
                default: begin
                    if (wait_d) begin
                        f_leaves <= im_data[31:0];
                        cur_id <= id_q;
                        cur_ok <= 1;
                        scan_q <= idx;
                        fresh_q <= 1;
                        hit_q <= 1;
                        st <= 0;
                    end
                end
            endcase
            if (inval) begin
                cur_ok <= 0;
            end
        end
    end
endmodule
