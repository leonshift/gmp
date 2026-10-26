module NocPortSink512_512 (
    input p_ar_valid,
    output logic p_ar_ready,
    input [3:0] p_ar_id,
    input [15:0] p_ar_tag,
    input [47:0] p_ar_addr,
    input [19:0] p_ar_bytes,
    input [15:0] p_ar_rows,
    input [19:0] p_ar_stride,
    input p_ar_first,
    input p_ar_last,
    input p_aw_valid,
    output logic p_aw_ready,
    input [3:0] p_aw_id,
    input [15:0] p_aw_tag,
    input [47:0] p_aw_addr,
    input [19:0] p_aw_bytes,
    input [15:0] p_aw_rows,
    input [19:0] p_aw_stride,
    input p_aw_first,
    input p_aw_last,
    input p_w_valid,
    input [3:0] p_w_id,
    input [511:0] p_w_data,
    input [63:0] p_w_strb,
    output logic [7:0] p_w_ready,
    output logic p_r_valid,
    input p_r_ready,
    output logic [511:0] p_r_data,
    output logic [3:0] p_r_id,
    output logic [15:0] p_r_tag,
    output logic p_r_last,
    output logic p_b_valid,
    input p_b_ready,
    output logic [3:0] p_b_id,
    output logic [15:0] p_b_tag,
    output logic p_a_valid,
    output logic [3:0] p_a_id,
    output logic [15:0] p_a_tag
);
    assign p_ar_ready = 1'd0;
    assign p_aw_ready = 1'd0;
    assign p_w_ready = 8'd0;
    assign p_r_valid = 1'd0;
    assign p_r_data = 512'd0;
    assign p_r_id = 4'd0;
    assign p_r_tag = 16'd0;
    assign p_r_last = 1'd0;
    assign p_b_valid = 1'd0;
    assign p_b_id = 4'd0;
    assign p_b_tag = 16'd0;
    assign p_a_valid = 1'd0;
    assign p_a_id = 4'd0;
    assign p_a_tag = 16'd0;
endmodule
