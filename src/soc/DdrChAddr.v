module DdrChAddr (
    input s_ar_valid,
    output logic s_ar_ready,
    input [7:0] s_ar_id,
    input [47:0] s_ar_addr,
    input [7:0] s_ar_len,
    input s_aw_valid,
    output logic s_aw_ready,
    input [7:0] s_aw_id,
    input [47:0] s_aw_addr,
    input [7:0] s_aw_len,
    input s_w_valid,
    output logic s_w_ready,
    input [511:0] s_w_data,
    input [63:0] s_w_strb,
    input s_w_last,
    output logic s_b_valid,
    input s_b_ready,
    output logic [7:0] s_b_id,
    output logic s_r_valid,
    input s_r_ready,
    output logic [7:0] s_r_id,
    output logic [511:0] s_r_data,
    output logic s_r_last,
    output logic m_ar_valid,
    input m_ar_ready,
    output logic [7:0] m_ar_id,
    output logic [30:0] m_ar_addr,
    output logic [7:0] m_ar_len,
    output logic m_aw_valid,
    input m_aw_ready,
    output logic [7:0] m_aw_id,
    output logic [30:0] m_aw_addr,
    output logic [7:0] m_aw_len,
    output logic m_w_valid,
    input m_w_ready,
    output logic [511:0] m_w_data,
    output logic [63:0] m_w_strb,
    output logic m_w_last,
    input m_b_valid,
    output logic m_b_ready,
    input [7:0] m_b_id,
    input m_r_valid,
    output logic m_r_ready,
    input [7:0] m_r_id,
    input [511:0] m_r_data,
    input m_r_last
);
    assign m_ar_valid = s_ar_valid;
    assign m_ar_id = s_ar_id;
    assign m_ar_addr = {s_ar_addr[31:9], s_ar_addr[7:0]};
    assign m_ar_len = s_ar_len;
    assign s_ar_ready = m_ar_ready;
    assign m_aw_valid = s_aw_valid;
    assign m_aw_id = s_aw_id;
    assign m_aw_addr = {s_aw_addr[31:9], s_aw_addr[7:0]};
    assign m_aw_len = s_aw_len;
    assign s_aw_ready = m_aw_ready;
    assign m_w_valid = s_w_valid;
    assign m_w_data = s_w_data;
    assign m_w_strb = s_w_strb;
    assign m_w_last = s_w_last;
    assign s_w_ready = m_w_ready;
    assign s_b_valid = m_b_valid;
    assign s_b_id = m_b_id;
    assign m_b_ready = s_b_ready;
    assign s_r_valid = m_r_valid;
    assign s_r_id = m_r_id;
    assign s_r_data = m_r_data;
    assign s_r_last = m_r_last;
    assign m_r_ready = s_r_ready;
endmodule
