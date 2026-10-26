module CpuNocBridge (
    input clk,
    input rst_n,
    input dm_valid,
    input [31:0] dm_addr,
    input [15:0] dm_nbytes,
    input dm_write,
    output logic p_ar_valid,
    input p_ar_ready,
    output logic [3:0] p_ar_id,
    output logic [15:0] p_ar_tag,
    output logic [47:0] p_ar_addr,
    output logic [19:0] p_ar_bytes,
    output logic [15:0] p_ar_rows,
    output logic [19:0] p_ar_stride,
    output logic p_ar_first,
    output logic p_ar_last,
    output logic p_aw_valid,
    input p_aw_ready,
    output logic [3:0] p_aw_id,
    output logic [15:0] p_aw_tag,
    output logic [47:0] p_aw_addr,
    output logic [19:0] p_aw_bytes,
    output logic [15:0] p_aw_rows,
    output logic [19:0] p_aw_stride,
    output logic p_aw_first,
    output logic p_aw_last,
    output logic p_w_valid,
    output logic [3:0] p_w_id,
    output logic [1023:0] p_w_data,
    output logic [127:0] p_w_strb,
    input [7:0] p_w_ready,
    input p_r_valid,
    output logic p_r_ready,
    input [1023:0] p_r_data,
    input [3:0] p_r_id,
    input [15:0] p_r_tag,
    input p_r_last,
    input p_b_valid,
    output logic p_b_ready,
    input [3:0] p_b_id,
    input [15:0] p_b_tag,
    input p_a_valid,
    input [3:0] p_a_id,
    input [15:0] p_a_tag,
    output logic dm_ready,
    output logic da_valid,
    output logic dr_valid,
    output logic [31:0] dr_data
);
    logic busy;
    logic ar_v;
    logic [31:0] ar_addr;
    logic [15:0] ar_nbytes;
    logic [15:0] ar_tag;
    logic dr_v_q;
    logic [31:0] dr_d_q;
    logic [4:0] cur;
    logic [13:0] rem;
    logic [1023:0] beat;
    logic beat_v;
    logic [15:0] tagc;
    logic accept;
    logic [31:0] dr_word;

    assign accept = ((dm_valid & (~dm_write)) & (~busy));
    assign dm_ready = (~busy);
    assign p_ar_valid = ar_v;
    assign p_ar_id = 4'd0;
    assign p_ar_tag = ar_tag;
    assign p_ar_addr = {16'd0, ar_addr};
    assign p_ar_bytes = {4'd0, ar_nbytes};
    assign p_ar_rows = 16'd1;
    assign p_ar_stride = 20'd0;
    assign p_ar_first = 1'd1;
    assign p_ar_last = 1'd1;
    assign p_aw_valid = 1'd0;
    assign p_aw_id = 4'd0;
    assign p_aw_tag = 16'd0;
    assign p_aw_addr = 48'd0;
    assign p_aw_bytes = 20'd0;
    assign p_aw_rows = 16'd0;
    assign p_aw_stride = 20'd0;
    assign p_aw_first = 1'd0;
    assign p_aw_last = 1'd0;
    assign p_w_valid = 1'd0;
    assign p_w_id = 4'd0;
    assign p_w_data = 1024'd0;
    assign p_w_strb = 128'd0;
    assign p_b_ready = 1'd1;
    assign p_r_ready = (~beat_v);
    assign da_valid = p_a_valid;
    assign dr_word = ((cur == 0) ? beat[31:0] :
                     ((cur == 1) ? beat[63:32] :
                     ((cur == 2) ? beat[95:64] :
                     ((cur == 3) ? beat[127:96] :
                     ((cur == 4) ? beat[159:128] :
                     ((cur == 5) ? beat[191:160] :
                     ((cur == 6) ? beat[223:192] :
                     ((cur == 7) ? beat[255:224] :
                     ((cur == 8) ? beat[287:256] :
                     ((cur == 9) ? beat[319:288] :
                     ((cur == 10) ? beat[351:320] :
                     ((cur == 11) ? beat[383:352] :
                     ((cur == 12) ? beat[415:384] :
                     ((cur == 13) ? beat[447:416] :
                     ((cur == 14) ? beat[479:448] :
                     ((cur == 15) ? beat[511:480] :
                     ((cur == 16) ? beat[543:512] :
                     ((cur == 17) ? beat[575:544] :
                     ((cur == 18) ? beat[607:576] :
                     ((cur == 19) ? beat[639:608] :
                     ((cur == 20) ? beat[671:640] :
                     ((cur == 21) ? beat[703:672] :
                     ((cur == 22) ? beat[735:704] :
                     ((cur == 23) ? beat[767:736] :
                     ((cur == 24) ? beat[799:768] :
                     ((cur == 25) ? beat[831:800] :
                     ((cur == 26) ? beat[863:832] :
                     ((cur == 27) ? beat[895:864] :
                     ((cur == 28) ? beat[927:896] :
                     ((cur == 29) ? beat[959:928] :
                     ((cur == 30) ? beat[991:960] :
                     beat[1023:992])))))))))))))))))))))))))))))));
    assign dr_valid = dr_v_q;
    assign dr_data = dr_d_q;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            tagc <= 0;
            dr_v_q <= 0;
            busy <= 0;
            cur <= 0;
            rem <= 0;
            ar_v <= 0;
            beat_v <= 0;
        end else begin
            tagc <= (tagc + 1);
            dr_v_q <= (beat_v & (rem != 0));
            if (accept) begin
                busy <= 1;
                cur <= dm_addr[6:2];
                rem <= dm_nbytes[15:2];
                ar_v <= 1;
            end else begin
                if ((ar_v & p_ar_ready)) begin
                    ar_v <= 0;
                end
            end
            if ((p_r_valid & (~beat_v))) begin
                beat_v <= 1;
            end
            if ((beat_v & (rem != 0))) begin
                cur <= (cur + 1);
                rem <= (rem - 1);
                if (((cur == 31) | (rem == 1))) begin
                    beat_v <= 0;
                end
                if ((rem == 1)) begin
                    busy <= 0;
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        dr_d_q <= dr_word;
        if (accept) begin
            ar_addr <= dm_addr;
            ar_nbytes <= dm_nbytes;
            ar_tag <= tagc;
        end
        if ((p_r_valid & (~beat_v))) begin
            beat <= p_r_data;
        end
    end
endmodule
