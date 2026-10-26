module SocUnit (
    input clk,
    input rst_n,
    input hc_cm_valid,
    output logic hc_cm_ready,
    input [31:0] hc_cm_addr,
    input [31:0] hc_cm_wdata,
    input hc_cm_write,
    input [23:0] hc_cm_tag,
    output logic hc_cr_valid,
    input hc_cr_ready,
    output logic [31:0] hc_cr_data,
    output logic [23:0] hc_cr_tag,
    input hs_valid,
    input [3:0] hs_op,
    input [31:0] hs_addr,
    input [31:0] hs_wdata,
    input [11:0] hs_tag,
    input hr_ready,
    input hp_wen,
    input [5:0] hp_addr,
    input [31:0] hp_wdata,
    input [5:0] hp_raddr,
    output logic [31:0] hp_rdata,
    input b_we,
    input b_re,
    input [11:0] b_addr,
    input [31:0] b_wdata,
    output logic [31:0] b_rdata,
    input stat_clr_all,
    input calib,
    output logic m_0_ar_valid,
    input m_0_ar_ready,
    output logic [7:0] m_0_ar_id,
    output logic [47:0] m_0_ar_addr,
    output logic [7:0] m_0_ar_len,
    output logic m_0_aw_valid,
    input m_0_aw_ready,
    output logic [7:0] m_0_aw_id,
    output logic [47:0] m_0_aw_addr,
    output logic [7:0] m_0_aw_len,
    output logic m_0_w_valid,
    input m_0_w_ready,
    output logic [511:0] m_0_w_data,
    output logic [63:0] m_0_w_strb,
    output logic m_0_w_last,
    input m_0_b_valid,
    output logic m_0_b_ready,
    input [7:0] m_0_b_id,
    input m_0_r_valid,
    output logic m_0_r_ready,
    input [7:0] m_0_r_id,
    input [511:0] m_0_r_data,
    input m_0_r_last,
    output logic m_1_ar_valid,
    input m_1_ar_ready,
    output logic [7:0] m_1_ar_id,
    output logic [47:0] m_1_ar_addr,
    output logic [7:0] m_1_ar_len,
    output logic m_1_aw_valid,
    input m_1_aw_ready,
    output logic [7:0] m_1_aw_id,
    output logic [47:0] m_1_aw_addr,
    output logic [7:0] m_1_aw_len,
    output logic m_1_w_valid,
    input m_1_w_ready,
    output logic [511:0] m_1_w_data,
    output logic [63:0] m_1_w_strb,
    output logic m_1_w_last,
    input m_1_b_valid,
    output logic m_1_b_ready,
    input [7:0] m_1_b_id,
    input m_1_r_valid,
    output logic m_1_r_ready,
    input [7:0] m_1_r_id,
    input [511:0] m_1_r_data,
    input m_1_r_last,
    output logic [31:0] stat_trace0,
    output logic [31:0] stat_trace1,
    output logic [31:0] stat_trace2,
    output logic [31:0] stat_trace3,
    output logic stat_uart_valid,
    output logic [7:0] stat_uart_data,
    output logic [3:0] stat_cpu_state,
    output logic stat_dma_busy,
    output logic [7:0] stat_dma_ch_idle,
    output logic [2:0] stat_dma_seq_state,
    output logic [4:0] stat_dma_noc_credit,
    output logic stat_v1d_busy,
    output logic stat_v1d_idle,
    output logic [15:0] stat_v1d_donec,
    output logic [4:0] stat_v1d_occ,
    output logic stat_m2d_busy,
    output logic stat_m2d_idle,
    output logic [15:0] stat_m2d_donec,
    output logic [4:0] stat_m2d_occ,
    output logic [3:0] stat_ctrl_route_target,
    output logic [7:0] stat_ctrl_inflight,
    output logic [3:0] stat_ctrl_slave_ready,
    output logic [15:0] stat_ctrl_cfg_ack_age,
    output logic [15:0] stat_l1_pend_write,
    output logic [31:0] stat_l1_mismatch,
    output logic [15:0] stat_l1_torn,
    output logic [1:0] stat_l1_gate_block,
    output logic [1:0] stat_l1_admit,
    output logic [7:0] stat_l1_cfg_pend,
    output logic [7:0] stat_l1_live_slots,
    output logic [31:0] stat_l1_instq,
    output logic [31:0] stat_l1_gateq,
    output logic [31:0] stat_l1_gateq2,
    output logic [1:0] stat_l1_grant,
    output logic [1:0] stat_l1_stall,
    output logic [7:0] stat_l1_occ0,
    output logic [7:0] stat_l1_occ1,
    output logic [7:0] stat_l1_occ2,
    output logic [15:0] stat_noc_pend_write,
    output logic stat_noc_admit,
    output logic [3:0] stat_noc_port_stall,
    output logic stat_noc_idle,
    output logic [7:0] stat_noc_win_occ,
    output logic [5:0] stat_noc_infl_occ,
    output logic [5:0] stat_noc_rd_out,
    output logic [5:0] stat_noc_asm_occ,
    output logic [15:0] stat_noc_asm_blk,
    output logic [3:0] stat_noc_lane_busy,
    output logic [5:0] stat_noc_occ0,
    output logic [5:0] stat_noc_occ1,
    output logic [5:0] stat_noc_occ2,
    output logic [5:0] stat_noc_occ3,
    output logic [5:0] stat_noc_occ4,
    output logic rst_ext,
    output logic hs_ready,
    output logic hr_valid,
    output logic [31:0] hr_data
);
    logic u_brg_dm_ready;
    logic u_brg_da_valid;
    logic u_brg_dr_valid;
    logic [31:0] u_brg_dr_data;
    logic u_cpu_dm_valid;
    logic [31:0] u_cpu_dm_addr;
    logic [15:0] u_cpu_dm_nbytes;
    logic u_cpu_dm_write;
    logic [7:0] we_l1_dma_i_room;
    logic [7:0] we_nc_dma_i_room;
    logic u_dma_l1_ar_valid;
    logic u_dma_l1_ar_ready;
    logic [3:0] u_dma_l1_ar_id;
    logic [15:0] u_dma_l1_ar_tag;
    logic [7:0] u_dma_l1_ar_cfg;
    logic [19:0] u_dma_l1_ar_off;
    logic [19:0] u_dma_l1_ar_bytes;
    logic [15:0] u_dma_l1_ar_rows;
    logic [19:0] u_dma_l1_ar_stride;
    logic u_dma_l1_ar_first;
    logic u_dma_l1_ar_last;
    logic u_dma_l1_aw_valid;
    logic u_dma_l1_aw_ready;
    logic [3:0] u_dma_l1_aw_id;
    logic [15:0] u_dma_l1_aw_tag;
    logic [7:0] u_dma_l1_aw_cfg;
    logic [19:0] u_dma_l1_aw_off;
    logic [19:0] u_dma_l1_aw_bytes;
    logic [15:0] u_dma_l1_aw_rows;
    logic [19:0] u_dma_l1_aw_stride;
    logic u_dma_l1_aw_first;
    logic u_dma_l1_aw_last;
    logic we_l1_dma_o_valid;
    logic [3:0] we_l1_dma_o_id;
    logic [1023:0] we_l1_dma_o_data;
    logic [127:0] we_l1_dma_o_strb;
    logic [7:0] we_l1_dma_o_ready;
    logic re_l1_dma_i_valid;
    logic re_l1_dma_i_ready;
    logic [1023:0] re_l1_dma_i_data;
    logic [3:0] re_l1_dma_i_id;
    logic [15:0] re_l1_dma_i_tag;
    logic re_l1_dma_i_last;
    logic u_dma_l1_b_valid;
    logic u_dma_l1_b_ready;
    logic [3:0] u_dma_l1_b_id;
    logic [15:0] u_dma_l1_b_tag;
    logic u_dma_l1_a_valid;
    logic [3:0] u_dma_l1_a_id;
    logic [15:0] u_dma_l1_a_tag;
    logic u_v1d_l1_ar_valid;
    logic u_v1d_l1_ar_ready;
    logic [3:0] u_v1d_l1_ar_id;
    logic [15:0] u_v1d_l1_ar_tag;
    logic [7:0] u_v1d_l1_ar_cfg;
    logic [19:0] u_v1d_l1_ar_off;
    logic [19:0] u_v1d_l1_ar_bytes;
    logic [15:0] u_v1d_l1_ar_rows;
    logic [19:0] u_v1d_l1_ar_stride;
    logic u_v1d_l1_ar_first;
    logic u_v1d_l1_ar_last;
    logic u_v1d_l1_aw_valid;
    logic u_v1d_l1_aw_ready;
    logic [3:0] u_v1d_l1_aw_id;
    logic [15:0] u_v1d_l1_aw_tag;
    logic [7:0] u_v1d_l1_aw_cfg;
    logic [19:0] u_v1d_l1_aw_off;
    logic [19:0] u_v1d_l1_aw_bytes;
    logic [15:0] u_v1d_l1_aw_rows;
    logic [19:0] u_v1d_l1_aw_stride;
    logic u_v1d_l1_aw_first;
    logic u_v1d_l1_aw_last;
    logic we_l1_v1d_o_valid;
    logic [3:0] we_l1_v1d_o_id;
    logic [511:0] we_l1_v1d_o_data;
    logic [63:0] we_l1_v1d_o_strb;
    logic [7:0] we_l1_v1d_o_ready;
    logic re_l1_v1d_i_valid;
    logic re_l1_v1d_i_ready;
    logic [511:0] re_l1_v1d_i_data;
    logic [3:0] re_l1_v1d_i_id;
    logic [15:0] re_l1_v1d_i_tag;
    logic re_l1_v1d_i_last;
    logic u_v1d_l1_b_valid;
    logic u_v1d_l1_b_ready;
    logic [3:0] u_v1d_l1_b_id;
    logic [15:0] u_v1d_l1_b_tag;
    logic u_v1d_l1_a_valid;
    logic [3:0] u_v1d_l1_a_id;
    logic [15:0] u_v1d_l1_a_tag;
    logic u_m2d_l1_ar_valid;
    logic u_m2d_l1_ar_ready;
    logic [3:0] u_m2d_l1_ar_id;
    logic [15:0] u_m2d_l1_ar_tag;
    logic [7:0] u_m2d_l1_ar_cfg;
    logic [19:0] u_m2d_l1_ar_off;
    logic [19:0] u_m2d_l1_ar_bytes;
    logic [15:0] u_m2d_l1_ar_rows;
    logic [19:0] u_m2d_l1_ar_stride;
    logic u_m2d_l1_ar_first;
    logic u_m2d_l1_ar_last;
    logic u_m2d_l1_aw_valid;
    logic u_m2d_l1_aw_ready;
    logic [3:0] u_m2d_l1_aw_id;
    logic [15:0] u_m2d_l1_aw_tag;
    logic [7:0] u_m2d_l1_aw_cfg;
    logic [19:0] u_m2d_l1_aw_off;
    logic [19:0] u_m2d_l1_aw_bytes;
    logic [15:0] u_m2d_l1_aw_rows;
    logic [19:0] u_m2d_l1_aw_stride;
    logic u_m2d_l1_aw_first;
    logic u_m2d_l1_aw_last;
    logic we_l1_m2d_o_valid;
    logic [3:0] we_l1_m2d_o_id;
    logic [511:0] we_l1_m2d_o_data;
    logic [63:0] we_l1_m2d_o_strb;
    logic [7:0] we_l1_m2d_o_ready;
    logic re_l1_m2d_i_valid;
    logic re_l1_m2d_i_ready;
    logic [1023:0] re_l1_m2d_i_data;
    logic [3:0] re_l1_m2d_i_id;
    logic [15:0] re_l1_m2d_i_tag;
    logic re_l1_m2d_i_last;
    logic u_m2d_l1_b_valid;
    logic u_m2d_l1_b_ready;
    logic [3:0] u_m2d_l1_b_id;
    logic [15:0] u_m2d_l1_b_tag;
    logic u_m2d_l1_a_valid;
    logic [3:0] u_m2d_l1_a_id;
    logic [15:0] u_m2d_l1_a_tag;
    logic u_cpu_ctrl_cm_valid;
    logic u_cpu_ctrl_cm_ready;
    logic [31:0] u_cpu_ctrl_cm_addr;
    logic [31:0] u_cpu_ctrl_cm_wdata;
    logic u_cpu_ctrl_cm_write;
    logic [23:0] u_cpu_ctrl_cm_tag;
    logic u_cpu_ctrl_cr_valid;
    logic u_cpu_ctrl_cr_ready;
    logic [31:0] u_cpu_ctrl_cr_data;
    logic [23:0] u_cpu_ctrl_cr_tag;
    logic u_dma_ctrl_s_cm_valid;
    logic u_dma_ctrl_s_cm_ready;
    logic [31:0] u_dma_ctrl_s_cm_addr;
    logic [31:0] u_dma_ctrl_s_cm_wdata;
    logic u_dma_ctrl_s_cm_write;
    logic [23:0] u_dma_ctrl_s_cm_tag;
    logic u_dma_ctrl_s_cr_valid;
    logic u_dma_ctrl_s_cr_ready;
    logic [31:0] u_dma_ctrl_s_cr_data;
    logic [23:0] u_dma_ctrl_s_cr_tag;
    logic u_v1d_ctrl_s_cm_valid;
    logic u_v1d_ctrl_s_cm_ready;
    logic [31:0] u_v1d_ctrl_s_cm_addr;
    logic [31:0] u_v1d_ctrl_s_cm_wdata;
    logic u_v1d_ctrl_s_cm_write;
    logic [23:0] u_v1d_ctrl_s_cm_tag;
    logic u_v1d_ctrl_s_cr_valid;
    logic u_v1d_ctrl_s_cr_ready;
    logic [31:0] u_v1d_ctrl_s_cr_data;
    logic [23:0] u_v1d_ctrl_s_cr_tag;
    logic u_m2d_ctrl_s_cm_valid;
    logic u_m2d_ctrl_s_cm_ready;
    logic [31:0] u_m2d_ctrl_s_cm_addr;
    logic [31:0] u_m2d_ctrl_s_cm_wdata;
    logic u_m2d_ctrl_s_cm_write;
    logic [23:0] u_m2d_ctrl_s_cm_tag;
    logic u_m2d_ctrl_s_cr_valid;
    logic u_m2d_ctrl_s_cr_ready;
    logic [31:0] u_m2d_ctrl_s_cr_data;
    logic [23:0] u_m2d_ctrl_s_cr_tag;
    logic u_l1_ctrl_s_cm_valid;
    logic u_l1_ctrl_s_cm_ready;
    logic [31:0] u_l1_ctrl_s_cm_addr;
    logic [31:0] u_l1_ctrl_s_cm_wdata;
    logic u_l1_ctrl_s_cm_write;
    logic [23:0] u_l1_ctrl_s_cm_tag;
    logic u_l1_ctrl_s_cr_valid;
    logic u_l1_ctrl_s_cr_ready;
    logic [31:0] u_l1_ctrl_s_cr_data;
    logic [23:0] u_l1_ctrl_s_cr_tag;
    logic u_dma_l1_w_valid;
    logic [3:0] u_dma_l1_w_id;
    logic [1023:0] u_dma_l1_w_data;
    logic [127:0] u_dma_l1_w_strb;
    logic [7:0] u_dma_l1_w_ready;
    logic u_dma_noc_w_valid;
    logic [3:0] u_dma_noc_w_id;
    logic [1023:0] u_dma_noc_w_data;
    logic [127:0] u_dma_noc_w_strb;
    logic [7:0] u_dma_noc_w_ready;
    logic u_v1d_l1_w_valid;
    logic [3:0] u_v1d_l1_w_id;
    logic [511:0] u_v1d_l1_w_data;
    logic [63:0] u_v1d_l1_w_strb;
    logic [7:0] u_v1d_l1_w_ready;
    logic u_m2d_l1_w_valid;
    logic [3:0] u_m2d_l1_w_id;
    logic [511:0] u_m2d_l1_w_data;
    logic [63:0] u_m2d_l1_w_strb;
    logic [7:0] u_m2d_l1_w_ready;
    logic u_v1d_noc_w_valid;
    logic [3:0] u_v1d_noc_w_id;
    logic [511:0] u_v1d_noc_w_data;
    logic [63:0] u_v1d_noc_w_strb;
    logic [7:0] u_v1d_noc_w_ready;
    logic u_m2d_noc_w_valid;
    logic [3:0] u_m2d_noc_w_id;
    logic [511:0] u_m2d_noc_w_data;
    logic [63:0] u_m2d_noc_w_strb;
    logic [7:0] u_m2d_noc_w_ready;
    logic u_dma_l1_r_valid;
    logic u_dma_l1_r_ready;
    logic [1023:0] u_dma_l1_r_data;
    logic [3:0] u_dma_l1_r_id;
    logic [15:0] u_dma_l1_r_tag;
    logic u_dma_l1_r_last;
    logic u_v1d_l1_r_valid;
    logic u_v1d_l1_r_ready;
    logic [511:0] u_v1d_l1_r_data;
    logic [3:0] u_v1d_l1_r_id;
    logic [15:0] u_v1d_l1_r_tag;
    logic u_v1d_l1_r_last;
    logic u_m2d_l1_r_valid;
    logic u_m2d_l1_r_ready;
    logic [1023:0] u_m2d_l1_r_data;
    logic [3:0] u_m2d_l1_r_id;
    logic [15:0] u_m2d_l1_r_tag;
    logic u_m2d_l1_r_last;
    logic u_dma_noc_r_valid;
    logic u_dma_noc_r_ready;
    logic [1023:0] u_dma_noc_r_data;
    logic [3:0] u_dma_noc_r_id;
    logic [15:0] u_dma_noc_r_tag;
    logic u_dma_noc_r_last;
    logic u_v1d_noc_r_valid;
    logic u_v1d_noc_r_ready;
    logic [511:0] u_v1d_noc_r_data;
    logic [3:0] u_v1d_noc_r_id;
    logic [15:0] u_v1d_noc_r_tag;
    logic u_v1d_noc_r_last;
    logic u_m2d_noc_r_valid;
    logic u_m2d_noc_r_ready;
    logic [1023:0] u_m2d_noc_r_data;
    logic [3:0] u_m2d_noc_r_id;
    logic [15:0] u_m2d_noc_r_tag;
    logic u_m2d_noc_r_last;
    logic u_hp_p_3_w_valid;
    logic [3:0] u_hp_p_3_w_id;
    logic [1023:0] u_hp_p_3_w_data;
    logic [127:0] u_hp_p_3_w_strb;
    logic [7:0] u_hp_p_3_w_ready;
    logic u_brg_p_w_valid;
    logic [3:0] u_brg_p_w_id;
    logic [1023:0] u_brg_p_w_data;
    logic [127:0] u_brg_p_w_strb;
    logic [7:0] u_brg_p_w_ready;
    logic u_dma_noc_ar_valid;
    logic u_dma_noc_ar_ready;
    logic [3:0] u_dma_noc_ar_id;
    logic [15:0] u_dma_noc_ar_tag;
    logic [47:0] u_dma_noc_ar_addr;
    logic [19:0] u_dma_noc_ar_bytes;
    logic [15:0] u_dma_noc_ar_rows;
    logic [19:0] u_dma_noc_ar_stride;
    logic u_dma_noc_ar_first;
    logic u_dma_noc_ar_last;
    logic u_dma_noc_aw_valid;
    logic u_dma_noc_aw_ready;
    logic [3:0] u_dma_noc_aw_id;
    logic [15:0] u_dma_noc_aw_tag;
    logic [47:0] u_dma_noc_aw_addr;
    logic [19:0] u_dma_noc_aw_bytes;
    logic [15:0] u_dma_noc_aw_rows;
    logic [19:0] u_dma_noc_aw_stride;
    logic u_dma_noc_aw_first;
    logic u_dma_noc_aw_last;
    logic we_nc_dma_o_valid;
    logic [3:0] we_nc_dma_o_id;
    logic [1023:0] we_nc_dma_o_data;
    logic [127:0] we_nc_dma_o_strb;
    logic [7:0] we_nc_dma_o_ready;
    logic re_nc_dma_i_valid;
    logic re_nc_dma_i_ready;
    logic [1023:0] re_nc_dma_i_data;
    logic [3:0] re_nc_dma_i_id;
    logic [15:0] re_nc_dma_i_tag;
    logic re_nc_dma_i_last;
    logic u_dma_noc_b_valid;
    logic u_dma_noc_b_ready;
    logic [3:0] u_dma_noc_b_id;
    logic [15:0] u_dma_noc_b_tag;
    logic u_dma_noc_a_valid;
    logic [3:0] u_dma_noc_a_id;
    logic [15:0] u_dma_noc_a_tag;
    logic u_v1d_noc_ar_valid;
    logic u_v1d_noc_ar_ready;
    logic [3:0] u_v1d_noc_ar_id;
    logic [15:0] u_v1d_noc_ar_tag;
    logic [47:0] u_v1d_noc_ar_addr;
    logic [19:0] u_v1d_noc_ar_bytes;
    logic [15:0] u_v1d_noc_ar_rows;
    logic [19:0] u_v1d_noc_ar_stride;
    logic u_v1d_noc_ar_first;
    logic u_v1d_noc_ar_last;
    logic u_v1d_noc_aw_valid;
    logic u_v1d_noc_aw_ready;
    logic [3:0] u_v1d_noc_aw_id;
    logic [15:0] u_v1d_noc_aw_tag;
    logic [47:0] u_v1d_noc_aw_addr;
    logic [19:0] u_v1d_noc_aw_bytes;
    logic [15:0] u_v1d_noc_aw_rows;
    logic [19:0] u_v1d_noc_aw_stride;
    logic u_v1d_noc_aw_first;
    logic u_v1d_noc_aw_last;
    logic we_nc_v1d_o_valid;
    logic [3:0] we_nc_v1d_o_id;
    logic [511:0] we_nc_v1d_o_data;
    logic [63:0] we_nc_v1d_o_strb;
    logic [7:0] we_nc_v1d_o_ready;
    logic re_nc_v1d_i_valid;
    logic re_nc_v1d_i_ready;
    logic [511:0] re_nc_v1d_i_data;
    logic [3:0] re_nc_v1d_i_id;
    logic [15:0] re_nc_v1d_i_tag;
    logic re_nc_v1d_i_last;
    logic u_v1d_noc_b_valid;
    logic u_v1d_noc_b_ready;
    logic [3:0] u_v1d_noc_b_id;
    logic [15:0] u_v1d_noc_b_tag;
    logic u_v1d_noc_a_valid;
    logic [3:0] u_v1d_noc_a_id;
    logic [15:0] u_v1d_noc_a_tag;
    logic u_m2d_noc_ar_valid;
    logic u_m2d_noc_ar_ready;
    logic [3:0] u_m2d_noc_ar_id;
    logic [15:0] u_m2d_noc_ar_tag;
    logic [47:0] u_m2d_noc_ar_addr;
    logic [19:0] u_m2d_noc_ar_bytes;
    logic [15:0] u_m2d_noc_ar_rows;
    logic [19:0] u_m2d_noc_ar_stride;
    logic u_m2d_noc_ar_first;
    logic u_m2d_noc_ar_last;
    logic u_m2d_noc_aw_valid;
    logic u_m2d_noc_aw_ready;
    logic [3:0] u_m2d_noc_aw_id;
    logic [15:0] u_m2d_noc_aw_tag;
    logic [47:0] u_m2d_noc_aw_addr;
    logic [19:0] u_m2d_noc_aw_bytes;
    logic [15:0] u_m2d_noc_aw_rows;
    logic [19:0] u_m2d_noc_aw_stride;
    logic u_m2d_noc_aw_first;
    logic u_m2d_noc_aw_last;
    logic we_nc_m2d_o_valid;
    logic [3:0] we_nc_m2d_o_id;
    logic [511:0] we_nc_m2d_o_data;
    logic [63:0] we_nc_m2d_o_strb;
    logic [7:0] we_nc_m2d_o_ready;
    logic re_nc_m2d_i_valid;
    logic re_nc_m2d_i_ready;
    logic [1023:0] re_nc_m2d_i_data;
    logic [3:0] re_nc_m2d_i_id;
    logic [15:0] re_nc_m2d_i_tag;
    logic re_nc_m2d_i_last;
    logic u_m2d_noc_b_valid;
    logic u_m2d_noc_b_ready;
    logic [3:0] u_m2d_noc_b_id;
    logic [15:0] u_m2d_noc_b_tag;
    logic u_m2d_noc_a_valid;
    logic [3:0] u_m2d_noc_a_id;
    logic [15:0] u_m2d_noc_a_tag;
    logic u_hp_p_3_ar_valid;
    logic u_hp_p_3_ar_ready;
    logic [3:0] u_hp_p_3_ar_id;
    logic [15:0] u_hp_p_3_ar_tag;
    logic [47:0] u_hp_p_3_ar_addr;
    logic [19:0] u_hp_p_3_ar_bytes;
    logic [15:0] u_hp_p_3_ar_rows;
    logic [19:0] u_hp_p_3_ar_stride;
    logic u_hp_p_3_ar_first;
    logic u_hp_p_3_ar_last;
    logic u_hp_p_3_aw_valid;
    logic u_hp_p_3_aw_ready;
    logic [3:0] u_hp_p_3_aw_id;
    logic [15:0] u_hp_p_3_aw_tag;
    logic [47:0] u_hp_p_3_aw_addr;
    logic [19:0] u_hp_p_3_aw_bytes;
    logic [15:0] u_hp_p_3_aw_rows;
    logic [19:0] u_hp_p_3_aw_stride;
    logic u_hp_p_3_aw_first;
    logic u_hp_p_3_aw_last;
    logic lag_hp_o_valid;
    logic [3:0] lag_hp_o_id;
    logic [1023:0] lag_hp_o_data;
    logic [127:0] lag_hp_o_strb;
    logic [7:0] lag_hp_o_ready;
    logic u_hp_p_3_r_valid;
    logic u_hp_p_3_r_ready;
    logic [1023:0] u_hp_p_3_r_data;
    logic [3:0] u_hp_p_3_r_id;
    logic [15:0] u_hp_p_3_r_tag;
    logic u_hp_p_3_r_last;
    logic u_hp_p_3_b_valid;
    logic u_hp_p_3_b_ready;
    logic [3:0] u_hp_p_3_b_id;
    logic [15:0] u_hp_p_3_b_tag;
    logic u_hp_p_3_a_valid;
    logic [3:0] u_hp_p_3_a_id;
    logic [15:0] u_hp_p_3_a_tag;
    logic u_brg_p_ar_valid;
    logic u_brg_p_ar_ready;
    logic [3:0] u_brg_p_ar_id;
    logic [15:0] u_brg_p_ar_tag;
    logic [47:0] u_brg_p_ar_addr;
    logic [19:0] u_brg_p_ar_bytes;
    logic [15:0] u_brg_p_ar_rows;
    logic [19:0] u_brg_p_ar_stride;
    logic u_brg_p_ar_first;
    logic u_brg_p_ar_last;
    logic u_brg_p_aw_valid;
    logic u_brg_p_aw_ready;
    logic [3:0] u_brg_p_aw_id;
    logic [15:0] u_brg_p_aw_tag;
    logic [47:0] u_brg_p_aw_addr;
    logic [19:0] u_brg_p_aw_bytes;
    logic [15:0] u_brg_p_aw_rows;
    logic [19:0] u_brg_p_aw_stride;
    logic u_brg_p_aw_first;
    logic u_brg_p_aw_last;
    logic lag_cpu_o_valid;
    logic [3:0] lag_cpu_o_id;
    logic [1023:0] lag_cpu_o_data;
    logic [127:0] lag_cpu_o_strb;
    logic [7:0] lag_cpu_o_ready;
    logic u_brg_p_r_valid;
    logic u_brg_p_r_ready;
    logic [1023:0] u_brg_p_r_data;
    logic [3:0] u_brg_p_r_id;
    logic [15:0] u_brg_p_r_tag;
    logic u_brg_p_r_last;
    logic u_brg_p_b_valid;
    logic u_brg_p_b_ready;
    logic [3:0] u_brg_p_b_id;
    logic [15:0] u_brg_p_b_tag;
    logic u_brg_p_a_valid;
    logic [3:0] u_brg_p_a_id;
    logic [15:0] u_brg_p_a_tag;
    logic u_hp_p_0_ar_valid;
    logic u_hp_p_0_ar_ready;
    logic [3:0] u_hp_p_0_ar_id;
    logic [15:0] u_hp_p_0_ar_tag;
    logic [47:0] u_hp_p_0_ar_addr;
    logic [19:0] u_hp_p_0_ar_bytes;
    logic [15:0] u_hp_p_0_ar_rows;
    logic [19:0] u_hp_p_0_ar_stride;
    logic u_hp_p_0_ar_first;
    logic u_hp_p_0_ar_last;
    logic u_hp_p_0_aw_valid;
    logic u_hp_p_0_aw_ready;
    logic [3:0] u_hp_p_0_aw_id;
    logic [15:0] u_hp_p_0_aw_tag;
    logic [47:0] u_hp_p_0_aw_addr;
    logic [19:0] u_hp_p_0_aw_bytes;
    logic [15:0] u_hp_p_0_aw_rows;
    logic [19:0] u_hp_p_0_aw_stride;
    logic u_hp_p_0_aw_first;
    logic u_hp_p_0_aw_last;
    logic u_hp_p_0_w_valid;
    logic [3:0] u_hp_p_0_w_id;
    logic [1023:0] u_hp_p_0_w_data;
    logic [127:0] u_hp_p_0_w_strb;
    logic [7:0] u_hp_p_0_w_ready;
    logic u_hp_p_0_r_valid;
    logic u_hp_p_0_r_ready;
    logic [1023:0] u_hp_p_0_r_data;
    logic [3:0] u_hp_p_0_r_id;
    logic [15:0] u_hp_p_0_r_tag;
    logic u_hp_p_0_r_last;
    logic u_hp_p_0_b_valid;
    logic u_hp_p_0_b_ready;
    logic [3:0] u_hp_p_0_b_id;
    logic [15:0] u_hp_p_0_b_tag;
    logic u_hp_p_0_a_valid;
    logic [3:0] u_hp_p_0_a_id;
    logic [15:0] u_hp_p_0_a_tag;
    logic u_hp_p_1_ar_valid;
    logic u_hp_p_1_ar_ready;
    logic [3:0] u_hp_p_1_ar_id;
    logic [15:0] u_hp_p_1_ar_tag;
    logic [47:0] u_hp_p_1_ar_addr;
    logic [19:0] u_hp_p_1_ar_bytes;
    logic [15:0] u_hp_p_1_ar_rows;
    logic [19:0] u_hp_p_1_ar_stride;
    logic u_hp_p_1_ar_first;
    logic u_hp_p_1_ar_last;
    logic u_hp_p_1_aw_valid;
    logic u_hp_p_1_aw_ready;
    logic [3:0] u_hp_p_1_aw_id;
    logic [15:0] u_hp_p_1_aw_tag;
    logic [47:0] u_hp_p_1_aw_addr;
    logic [19:0] u_hp_p_1_aw_bytes;
    logic [15:0] u_hp_p_1_aw_rows;
    logic [19:0] u_hp_p_1_aw_stride;
    logic u_hp_p_1_aw_first;
    logic u_hp_p_1_aw_last;
    logic u_hp_p_1_w_valid;
    logic [3:0] u_hp_p_1_w_id;
    logic [511:0] u_hp_p_1_w_data;
    logic [63:0] u_hp_p_1_w_strb;
    logic [7:0] u_hp_p_1_w_ready;
    logic u_hp_p_1_r_valid;
    logic u_hp_p_1_r_ready;
    logic [511:0] u_hp_p_1_r_data;
    logic [3:0] u_hp_p_1_r_id;
    logic [15:0] u_hp_p_1_r_tag;
    logic u_hp_p_1_r_last;
    logic u_hp_p_1_b_valid;
    logic u_hp_p_1_b_ready;
    logic [3:0] u_hp_p_1_b_id;
    logic [15:0] u_hp_p_1_b_tag;
    logic u_hp_p_1_a_valid;
    logic [3:0] u_hp_p_1_a_id;
    logic [15:0] u_hp_p_1_a_tag;
    logic u_hp_p_2_ar_valid;
    logic u_hp_p_2_ar_ready;
    logic [3:0] u_hp_p_2_ar_id;
    logic [15:0] u_hp_p_2_ar_tag;
    logic [47:0] u_hp_p_2_ar_addr;
    logic [19:0] u_hp_p_2_ar_bytes;
    logic [15:0] u_hp_p_2_ar_rows;
    logic [19:0] u_hp_p_2_ar_stride;
    logic u_hp_p_2_ar_first;
    logic u_hp_p_2_ar_last;
    logic u_hp_p_2_aw_valid;
    logic u_hp_p_2_aw_ready;
    logic [3:0] u_hp_p_2_aw_id;
    logic [15:0] u_hp_p_2_aw_tag;
    logic [47:0] u_hp_p_2_aw_addr;
    logic [19:0] u_hp_p_2_aw_bytes;
    logic [15:0] u_hp_p_2_aw_rows;
    logic [19:0] u_hp_p_2_aw_stride;
    logic u_hp_p_2_aw_first;
    logic u_hp_p_2_aw_last;
    logic u_hp_p_2_w_valid;
    logic [3:0] u_hp_p_2_w_id;
    logic [511:0] u_hp_p_2_w_data;
    logic [63:0] u_hp_p_2_w_strb;
    logic [7:0] u_hp_p_2_w_ready;
    logic u_hp_p_2_r_valid;
    logic u_hp_p_2_r_ready;
    logic [1023:0] u_hp_p_2_r_data;
    logic [3:0] u_hp_p_2_r_id;
    logic [15:0] u_hp_p_2_r_tag;
    logic u_hp_p_2_r_last;
    logic u_hp_p_2_b_valid;
    logic u_hp_p_2_b_ready;
    logic [3:0] u_hp_p_2_b_id;
    logic [15:0] u_hp_p_2_b_tag;
    logic u_hp_p_2_a_valid;
    logic [3:0] u_hp_p_2_a_id;
    logic [15:0] u_hp_p_2_a_tag;
    logic u_hp_p_4_ar_valid;
    logic u_hp_p_4_ar_ready;
    logic [3:0] u_hp_p_4_ar_id;
    logic [15:0] u_hp_p_4_ar_tag;
    logic [47:0] u_hp_p_4_ar_addr;
    logic [19:0] u_hp_p_4_ar_bytes;
    logic [15:0] u_hp_p_4_ar_rows;
    logic [19:0] u_hp_p_4_ar_stride;
    logic u_hp_p_4_ar_first;
    logic u_hp_p_4_ar_last;
    logic u_hp_p_4_aw_valid;
    logic u_hp_p_4_aw_ready;
    logic [3:0] u_hp_p_4_aw_id;
    logic [15:0] u_hp_p_4_aw_tag;
    logic [47:0] u_hp_p_4_aw_addr;
    logic [19:0] u_hp_p_4_aw_bytes;
    logic [15:0] u_hp_p_4_aw_rows;
    logic [19:0] u_hp_p_4_aw_stride;
    logic u_hp_p_4_aw_first;
    logic u_hp_p_4_aw_last;
    logic u_hp_p_4_w_valid;
    logic [3:0] u_hp_p_4_w_id;
    logic [1023:0] u_hp_p_4_w_data;
    logic [127:0] u_hp_p_4_w_strb;
    logic [7:0] u_hp_p_4_w_ready;
    logic u_hp_p_4_r_valid;
    logic u_hp_p_4_r_ready;
    logic [1023:0] u_hp_p_4_r_data;
    logic [3:0] u_hp_p_4_r_id;
    logic [15:0] u_hp_p_4_r_tag;
    logic u_hp_p_4_r_last;
    logic u_hp_p_4_b_valid;
    logic u_hp_p_4_b_ready;
    logic [3:0] u_hp_p_4_b_id;
    logic [15:0] u_hp_p_4_b_tag;
    logic u_hp_p_4_a_valid;
    logic [3:0] u_hp_p_4_a_id;
    logic [15:0] u_hp_p_4_a_tag;
    logic u_cpu_hs_ready;
    logic u_cpu_hr_valid;
    logic [31:0] u_cpu_hr_data;
    logic [31:0] u_cpu_trace0;
    logic [31:0] u_cpu_trace1;
    logic [31:0] u_cpu_trace2;
    logic [31:0] u_cpu_trace3;
    logic u_cpu_uart_tx_valid;
    logic [7:0] u_cpu_uart_tx_data;
    logic [3:0] u_cpu_dbg_state;
    logic u_dma_dbg_busy;
    logic [3:0] u_dma_dbg_ch_idle;
    logic [2:0] u_dma_dbg_seq_state;
    logic [2:0] u_dma_dbg_noc_credit;
    logic u_v1d_dbg_busy;
    logic u_v1d_dbg_idle;
    logic [15:0] u_v1d_dbg_donec;
    logic [4:0] u_v1d_dbg_occ;
    logic u_m2d_dbg_busy;
    logic u_m2d_dbg_idle;
    logic [15:0] u_m2d_dbg_donec;
    logic [4:0] u_m2d_dbg_occ;
    logic [3:0] u_bus_dbg_route_target;
    logic [7:0] u_bus_dbg_inflight;
    logic [3:0] u_bus_dbg_slave_ready;
    logic [15:0] u_bus_dbg_cfg_ack_age;

    assign rst_ext = rst_n;
    assign hs_ready = u_cpu_hs_ready;
    assign hr_valid = u_cpu_hr_valid;
    assign hr_data = u_cpu_hr_data;
    assign stat_trace0 = u_cpu_trace0;
    assign stat_trace1 = u_cpu_trace1;
    assign stat_trace2 = u_cpu_trace2;
    assign stat_trace3 = u_cpu_trace3;
    assign stat_uart_valid = u_cpu_uart_tx_valid;
    assign stat_uart_data = u_cpu_uart_tx_data;
    assign stat_cpu_state = u_cpu_dbg_state;
    assign stat_dma_busy = u_dma_dbg_busy;
    assign stat_dma_ch_idle = {4'd0, u_dma_dbg_ch_idle};
    assign stat_dma_seq_state = u_dma_dbg_seq_state;
    assign stat_dma_noc_credit = u_dma_dbg_noc_credit;
    assign stat_v1d_busy = u_v1d_dbg_busy;
    assign stat_v1d_idle = u_v1d_dbg_idle;
    assign stat_v1d_donec = u_v1d_dbg_donec;
    assign stat_v1d_occ = u_v1d_dbg_occ;
    assign stat_m2d_busy = u_m2d_dbg_busy;
    assign stat_m2d_idle = u_m2d_dbg_idle;
    assign stat_m2d_donec = u_m2d_dbg_donec;
    assign stat_m2d_occ = u_m2d_dbg_occ;
    assign stat_ctrl_route_target = u_bus_dbg_route_target;
    assign stat_ctrl_inflight = u_bus_dbg_inflight;
    assign stat_ctrl_slave_ready = u_bus_dbg_slave_ready;
    assign stat_ctrl_cfg_ack_age = u_bus_dbg_cfg_ack_age;

    G1Cpu u_cpu (
        .clk(clk),
        .rst_n(rst_n),
        .hs_valid(hs_valid),
        .hs_op(hs_op),
        .hs_addr(hs_addr),
        .hs_wdata(hs_wdata),
        .hs_tag(hs_tag),
        .hr_ready(hr_ready),
        .dm_ready(u_brg_dm_ready),
        .da_valid(u_brg_da_valid),
        .dr_valid(u_brg_dr_valid),
        .dr_data(u_brg_dr_data),
        .dm_valid(u_cpu_dm_valid),
        .dm_addr(u_cpu_dm_addr),
        .dm_nbytes(u_cpu_dm_nbytes),
        .dm_write(u_cpu_dm_write),
        .ctrl_cm_valid(u_cpu_ctrl_cm_valid),
        .ctrl_cm_ready(u_cpu_ctrl_cm_ready),
        .ctrl_cm_addr(u_cpu_ctrl_cm_addr),
        .ctrl_cm_wdata(u_cpu_ctrl_cm_wdata),
        .ctrl_cm_write(u_cpu_ctrl_cm_write),
        .ctrl_cm_tag(u_cpu_ctrl_cm_tag),
        .ctrl_cr_valid(u_cpu_ctrl_cr_valid),
        .ctrl_cr_ready(u_cpu_ctrl_cr_ready),
        .ctrl_cr_data(u_cpu_ctrl_cr_data),
        .ctrl_cr_tag(u_cpu_ctrl_cr_tag),
        .hs_ready(u_cpu_hs_ready),
        .hr_valid(u_cpu_hr_valid),
        .hr_data(u_cpu_hr_data),
        .trace0(u_cpu_trace0),
        .trace1(u_cpu_trace1),
        .trace2(u_cpu_trace2),
        .trace3(u_cpu_trace3),
        .uart_tx_valid(u_cpu_uart_tx_valid),
        .uart_tx_data(u_cpu_uart_tx_data),
        .dbg_state(u_cpu_dbg_state)
    );
    CpuNocBridge u_brg (
        .clk(clk),
        .rst_n(rst_n),
        .dm_valid(u_cpu_dm_valid),
        .dm_addr(u_cpu_dm_addr),
        .dm_nbytes(u_cpu_dm_nbytes),
        .dm_write(u_cpu_dm_write),
        .dm_ready(u_brg_dm_ready),
        .da_valid(u_brg_da_valid),
        .dr_valid(u_brg_dr_valid),
        .dr_data(u_brg_dr_data),
        .p_w_valid(u_brg_p_w_valid),
        .p_w_id(u_brg_p_w_id),
        .p_w_data(u_brg_p_w_data),
        .p_w_strb(u_brg_p_w_strb),
        .p_w_ready(u_brg_p_w_ready),
        .p_ar_valid(u_brg_p_ar_valid),
        .p_ar_ready(u_brg_p_ar_ready),
        .p_ar_id(u_brg_p_ar_id),
        .p_ar_tag(u_brg_p_ar_tag),
        .p_ar_addr(u_brg_p_ar_addr),
        .p_ar_bytes(u_brg_p_ar_bytes),
        .p_ar_rows(u_brg_p_ar_rows),
        .p_ar_stride(u_brg_p_ar_stride),
        .p_ar_first(u_brg_p_ar_first),
        .p_ar_last(u_brg_p_ar_last),
        .p_aw_valid(u_brg_p_aw_valid),
        .p_aw_ready(u_brg_p_aw_ready),
        .p_aw_id(u_brg_p_aw_id),
        .p_aw_tag(u_brg_p_aw_tag),
        .p_aw_addr(u_brg_p_aw_addr),
        .p_aw_bytes(u_brg_p_aw_bytes),
        .p_aw_rows(u_brg_p_aw_rows),
        .p_aw_stride(u_brg_p_aw_stride),
        .p_aw_first(u_brg_p_aw_first),
        .p_aw_last(u_brg_p_aw_last),
        .p_r_valid(u_brg_p_r_valid),
        .p_r_ready(u_brg_p_r_ready),
        .p_r_data(u_brg_p_r_data),
        .p_r_id(u_brg_p_r_id),
        .p_r_tag(u_brg_p_r_tag),
        .p_r_last(u_brg_p_r_last),
        .p_b_valid(u_brg_p_b_valid),
        .p_b_ready(u_brg_p_b_ready),
        .p_b_id(u_brg_p_b_id),
        .p_b_tag(u_brg_p_b_tag),
        .p_a_valid(u_brg_p_a_valid),
        .p_a_id(u_brg_p_a_id),
        .p_a_tag(u_brg_p_a_tag)
    );
    NocHostPort u_hp (
        .clk(clk),
        .rst_n(rst_n),
        .calib(calib),
        .h_wen(hp_wen),
        .h_addr(hp_addr),
        .h_wdata(hp_wdata),
        .h_raddr(hp_raddr),
        .h_rdata(hp_rdata),
        .b_we(b_we),
        .b_re(b_re),
        .b_addr(b_addr),
        .b_wdata(b_wdata),
        .b_rdata(b_rdata),
        .p_3_w_valid(u_hp_p_3_w_valid),
        .p_3_w_id(u_hp_p_3_w_id),
        .p_3_w_data(u_hp_p_3_w_data),
        .p_3_w_strb(u_hp_p_3_w_strb),
        .p_3_w_ready(u_hp_p_3_w_ready),
        .p_3_ar_valid(u_hp_p_3_ar_valid),
        .p_3_ar_ready(u_hp_p_3_ar_ready),
        .p_3_ar_id(u_hp_p_3_ar_id),
        .p_3_ar_tag(u_hp_p_3_ar_tag),
        .p_3_ar_addr(u_hp_p_3_ar_addr),
        .p_3_ar_bytes(u_hp_p_3_ar_bytes),
        .p_3_ar_rows(u_hp_p_3_ar_rows),
        .p_3_ar_stride(u_hp_p_3_ar_stride),
        .p_3_ar_first(u_hp_p_3_ar_first),
        .p_3_ar_last(u_hp_p_3_ar_last),
        .p_3_aw_valid(u_hp_p_3_aw_valid),
        .p_3_aw_ready(u_hp_p_3_aw_ready),
        .p_3_aw_id(u_hp_p_3_aw_id),
        .p_3_aw_tag(u_hp_p_3_aw_tag),
        .p_3_aw_addr(u_hp_p_3_aw_addr),
        .p_3_aw_bytes(u_hp_p_3_aw_bytes),
        .p_3_aw_rows(u_hp_p_3_aw_rows),
        .p_3_aw_stride(u_hp_p_3_aw_stride),
        .p_3_aw_first(u_hp_p_3_aw_first),
        .p_3_aw_last(u_hp_p_3_aw_last),
        .p_3_r_valid(u_hp_p_3_r_valid),
        .p_3_r_ready(u_hp_p_3_r_ready),
        .p_3_r_data(u_hp_p_3_r_data),
        .p_3_r_id(u_hp_p_3_r_id),
        .p_3_r_tag(u_hp_p_3_r_tag),
        .p_3_r_last(u_hp_p_3_r_last),
        .p_3_b_valid(u_hp_p_3_b_valid),
        .p_3_b_ready(u_hp_p_3_b_ready),
        .p_3_b_id(u_hp_p_3_b_id),
        .p_3_b_tag(u_hp_p_3_b_tag),
        .p_3_a_valid(u_hp_p_3_a_valid),
        .p_3_a_id(u_hp_p_3_a_id),
        .p_3_a_tag(u_hp_p_3_a_tag),
        .p_0_ar_valid(u_hp_p_0_ar_valid),
        .p_0_ar_ready(u_hp_p_0_ar_ready),
        .p_0_ar_id(u_hp_p_0_ar_id),
        .p_0_ar_tag(u_hp_p_0_ar_tag),
        .p_0_ar_addr(u_hp_p_0_ar_addr),
        .p_0_ar_bytes(u_hp_p_0_ar_bytes),
        .p_0_ar_rows(u_hp_p_0_ar_rows),
        .p_0_ar_stride(u_hp_p_0_ar_stride),
        .p_0_ar_first(u_hp_p_0_ar_first),
        .p_0_ar_last(u_hp_p_0_ar_last),
        .p_0_aw_valid(u_hp_p_0_aw_valid),
        .p_0_aw_ready(u_hp_p_0_aw_ready),
        .p_0_aw_id(u_hp_p_0_aw_id),
        .p_0_aw_tag(u_hp_p_0_aw_tag),
        .p_0_aw_addr(u_hp_p_0_aw_addr),
        .p_0_aw_bytes(u_hp_p_0_aw_bytes),
        .p_0_aw_rows(u_hp_p_0_aw_rows),
        .p_0_aw_stride(u_hp_p_0_aw_stride),
        .p_0_aw_first(u_hp_p_0_aw_first),
        .p_0_aw_last(u_hp_p_0_aw_last),
        .p_0_w_valid(u_hp_p_0_w_valid),
        .p_0_w_id(u_hp_p_0_w_id),
        .p_0_w_data(u_hp_p_0_w_data),
        .p_0_w_strb(u_hp_p_0_w_strb),
        .p_0_w_ready(u_hp_p_0_w_ready),
        .p_0_r_valid(u_hp_p_0_r_valid),
        .p_0_r_ready(u_hp_p_0_r_ready),
        .p_0_r_data(u_hp_p_0_r_data),
        .p_0_r_id(u_hp_p_0_r_id),
        .p_0_r_tag(u_hp_p_0_r_tag),
        .p_0_r_last(u_hp_p_0_r_last),
        .p_0_b_valid(u_hp_p_0_b_valid),
        .p_0_b_ready(u_hp_p_0_b_ready),
        .p_0_b_id(u_hp_p_0_b_id),
        .p_0_b_tag(u_hp_p_0_b_tag),
        .p_0_a_valid(u_hp_p_0_a_valid),
        .p_0_a_id(u_hp_p_0_a_id),
        .p_0_a_tag(u_hp_p_0_a_tag),
        .p_1_ar_valid(u_hp_p_1_ar_valid),
        .p_1_ar_ready(u_hp_p_1_ar_ready),
        .p_1_ar_id(u_hp_p_1_ar_id),
        .p_1_ar_tag(u_hp_p_1_ar_tag),
        .p_1_ar_addr(u_hp_p_1_ar_addr),
        .p_1_ar_bytes(u_hp_p_1_ar_bytes),
        .p_1_ar_rows(u_hp_p_1_ar_rows),
        .p_1_ar_stride(u_hp_p_1_ar_stride),
        .p_1_ar_first(u_hp_p_1_ar_first),
        .p_1_ar_last(u_hp_p_1_ar_last),
        .p_1_aw_valid(u_hp_p_1_aw_valid),
        .p_1_aw_ready(u_hp_p_1_aw_ready),
        .p_1_aw_id(u_hp_p_1_aw_id),
        .p_1_aw_tag(u_hp_p_1_aw_tag),
        .p_1_aw_addr(u_hp_p_1_aw_addr),
        .p_1_aw_bytes(u_hp_p_1_aw_bytes),
        .p_1_aw_rows(u_hp_p_1_aw_rows),
        .p_1_aw_stride(u_hp_p_1_aw_stride),
        .p_1_aw_first(u_hp_p_1_aw_first),
        .p_1_aw_last(u_hp_p_1_aw_last),
        .p_1_w_valid(u_hp_p_1_w_valid),
        .p_1_w_id(u_hp_p_1_w_id),
        .p_1_w_data(u_hp_p_1_w_data),
        .p_1_w_strb(u_hp_p_1_w_strb),
        .p_1_w_ready(u_hp_p_1_w_ready),
        .p_1_r_valid(u_hp_p_1_r_valid),
        .p_1_r_ready(u_hp_p_1_r_ready),
        .p_1_r_data(u_hp_p_1_r_data),
        .p_1_r_id(u_hp_p_1_r_id),
        .p_1_r_tag(u_hp_p_1_r_tag),
        .p_1_r_last(u_hp_p_1_r_last),
        .p_1_b_valid(u_hp_p_1_b_valid),
        .p_1_b_ready(u_hp_p_1_b_ready),
        .p_1_b_id(u_hp_p_1_b_id),
        .p_1_b_tag(u_hp_p_1_b_tag),
        .p_1_a_valid(u_hp_p_1_a_valid),
        .p_1_a_id(u_hp_p_1_a_id),
        .p_1_a_tag(u_hp_p_1_a_tag),
        .p_2_ar_valid(u_hp_p_2_ar_valid),
        .p_2_ar_ready(u_hp_p_2_ar_ready),
        .p_2_ar_id(u_hp_p_2_ar_id),
        .p_2_ar_tag(u_hp_p_2_ar_tag),
        .p_2_ar_addr(u_hp_p_2_ar_addr),
        .p_2_ar_bytes(u_hp_p_2_ar_bytes),
        .p_2_ar_rows(u_hp_p_2_ar_rows),
        .p_2_ar_stride(u_hp_p_2_ar_stride),
        .p_2_ar_first(u_hp_p_2_ar_first),
        .p_2_ar_last(u_hp_p_2_ar_last),
        .p_2_aw_valid(u_hp_p_2_aw_valid),
        .p_2_aw_ready(u_hp_p_2_aw_ready),
        .p_2_aw_id(u_hp_p_2_aw_id),
        .p_2_aw_tag(u_hp_p_2_aw_tag),
        .p_2_aw_addr(u_hp_p_2_aw_addr),
        .p_2_aw_bytes(u_hp_p_2_aw_bytes),
        .p_2_aw_rows(u_hp_p_2_aw_rows),
        .p_2_aw_stride(u_hp_p_2_aw_stride),
        .p_2_aw_first(u_hp_p_2_aw_first),
        .p_2_aw_last(u_hp_p_2_aw_last),
        .p_2_w_valid(u_hp_p_2_w_valid),
        .p_2_w_id(u_hp_p_2_w_id),
        .p_2_w_data(u_hp_p_2_w_data),
        .p_2_w_strb(u_hp_p_2_w_strb),
        .p_2_w_ready(u_hp_p_2_w_ready),
        .p_2_r_valid(u_hp_p_2_r_valid),
        .p_2_r_ready(u_hp_p_2_r_ready),
        .p_2_r_data(u_hp_p_2_r_data),
        .p_2_r_id(u_hp_p_2_r_id),
        .p_2_r_tag(u_hp_p_2_r_tag),
        .p_2_r_last(u_hp_p_2_r_last),
        .p_2_b_valid(u_hp_p_2_b_valid),
        .p_2_b_ready(u_hp_p_2_b_ready),
        .p_2_b_id(u_hp_p_2_b_id),
        .p_2_b_tag(u_hp_p_2_b_tag),
        .p_2_a_valid(u_hp_p_2_a_valid),
        .p_2_a_id(u_hp_p_2_a_id),
        .p_2_a_tag(u_hp_p_2_a_tag),
        .p_4_ar_valid(u_hp_p_4_ar_valid),
        .p_4_ar_ready(u_hp_p_4_ar_ready),
        .p_4_ar_id(u_hp_p_4_ar_id),
        .p_4_ar_tag(u_hp_p_4_ar_tag),
        .p_4_ar_addr(u_hp_p_4_ar_addr),
        .p_4_ar_bytes(u_hp_p_4_ar_bytes),
        .p_4_ar_rows(u_hp_p_4_ar_rows),
        .p_4_ar_stride(u_hp_p_4_ar_stride),
        .p_4_ar_first(u_hp_p_4_ar_first),
        .p_4_ar_last(u_hp_p_4_ar_last),
        .p_4_aw_valid(u_hp_p_4_aw_valid),
        .p_4_aw_ready(u_hp_p_4_aw_ready),
        .p_4_aw_id(u_hp_p_4_aw_id),
        .p_4_aw_tag(u_hp_p_4_aw_tag),
        .p_4_aw_addr(u_hp_p_4_aw_addr),
        .p_4_aw_bytes(u_hp_p_4_aw_bytes),
        .p_4_aw_rows(u_hp_p_4_aw_rows),
        .p_4_aw_stride(u_hp_p_4_aw_stride),
        .p_4_aw_first(u_hp_p_4_aw_first),
        .p_4_aw_last(u_hp_p_4_aw_last),
        .p_4_w_valid(u_hp_p_4_w_valid),
        .p_4_w_id(u_hp_p_4_w_id),
        .p_4_w_data(u_hp_p_4_w_data),
        .p_4_w_strb(u_hp_p_4_w_strb),
        .p_4_w_ready(u_hp_p_4_w_ready),
        .p_4_r_valid(u_hp_p_4_r_valid),
        .p_4_r_ready(u_hp_p_4_r_ready),
        .p_4_r_data(u_hp_p_4_r_data),
        .p_4_r_id(u_hp_p_4_r_id),
        .p_4_r_tag(u_hp_p_4_r_tag),
        .p_4_r_last(u_hp_p_4_r_last),
        .p_4_b_valid(u_hp_p_4_b_valid),
        .p_4_b_ready(u_hp_p_4_b_ready),
        .p_4_b_id(u_hp_p_4_b_id),
        .p_4_b_tag(u_hp_p_4_b_tag),
        .p_4_a_valid(u_hp_p_4_a_valid),
        .p_4_a_id(u_hp_p_4_a_id),
        .p_4_a_tag(u_hp_p_4_a_tag)
    );
    Vec1DUnit u_v1d (
        .clk(clk),
        .rst_n(rst_n),
        .l1_ar_valid(u_v1d_l1_ar_valid),
        .l1_ar_ready(u_v1d_l1_ar_ready),
        .l1_ar_id(u_v1d_l1_ar_id),
        .l1_ar_tag(u_v1d_l1_ar_tag),
        .l1_ar_cfg(u_v1d_l1_ar_cfg),
        .l1_ar_off(u_v1d_l1_ar_off),
        .l1_ar_bytes(u_v1d_l1_ar_bytes),
        .l1_ar_rows(u_v1d_l1_ar_rows),
        .l1_ar_stride(u_v1d_l1_ar_stride),
        .l1_ar_first(u_v1d_l1_ar_first),
        .l1_ar_last(u_v1d_l1_ar_last),
        .l1_aw_valid(u_v1d_l1_aw_valid),
        .l1_aw_ready(u_v1d_l1_aw_ready),
        .l1_aw_id(u_v1d_l1_aw_id),
        .l1_aw_tag(u_v1d_l1_aw_tag),
        .l1_aw_cfg(u_v1d_l1_aw_cfg),
        .l1_aw_off(u_v1d_l1_aw_off),
        .l1_aw_bytes(u_v1d_l1_aw_bytes),
        .l1_aw_rows(u_v1d_l1_aw_rows),
        .l1_aw_stride(u_v1d_l1_aw_stride),
        .l1_aw_first(u_v1d_l1_aw_first),
        .l1_aw_last(u_v1d_l1_aw_last),
        .l1_b_valid(u_v1d_l1_b_valid),
        .l1_b_ready(u_v1d_l1_b_ready),
        .l1_b_id(u_v1d_l1_b_id),
        .l1_b_tag(u_v1d_l1_b_tag),
        .l1_a_valid(u_v1d_l1_a_valid),
        .l1_a_id(u_v1d_l1_a_id),
        .l1_a_tag(u_v1d_l1_a_tag),
        .ctrl_s_cm_valid(u_v1d_ctrl_s_cm_valid),
        .ctrl_s_cm_ready(u_v1d_ctrl_s_cm_ready),
        .ctrl_s_cm_addr(u_v1d_ctrl_s_cm_addr),
        .ctrl_s_cm_wdata(u_v1d_ctrl_s_cm_wdata),
        .ctrl_s_cm_write(u_v1d_ctrl_s_cm_write),
        .ctrl_s_cm_tag(u_v1d_ctrl_s_cm_tag),
        .ctrl_s_cr_valid(u_v1d_ctrl_s_cr_valid),
        .ctrl_s_cr_ready(u_v1d_ctrl_s_cr_ready),
        .ctrl_s_cr_data(u_v1d_ctrl_s_cr_data),
        .ctrl_s_cr_tag(u_v1d_ctrl_s_cr_tag),
        .l1_w_valid(u_v1d_l1_w_valid),
        .l1_w_id(u_v1d_l1_w_id),
        .l1_w_data(u_v1d_l1_w_data),
        .l1_w_strb(u_v1d_l1_w_strb),
        .l1_w_ready(u_v1d_l1_w_ready),
        .noc_w_valid(u_v1d_noc_w_valid),
        .noc_w_id(u_v1d_noc_w_id),
        .noc_w_data(u_v1d_noc_w_data),
        .noc_w_strb(u_v1d_noc_w_strb),
        .noc_w_ready(u_v1d_noc_w_ready),
        .l1_r_valid(u_v1d_l1_r_valid),
        .l1_r_ready(u_v1d_l1_r_ready),
        .l1_r_data(u_v1d_l1_r_data),
        .l1_r_id(u_v1d_l1_r_id),
        .l1_r_tag(u_v1d_l1_r_tag),
        .l1_r_last(u_v1d_l1_r_last),
        .noc_r_valid(u_v1d_noc_r_valid),
        .noc_r_ready(u_v1d_noc_r_ready),
        .noc_r_data(u_v1d_noc_r_data),
        .noc_r_id(u_v1d_noc_r_id),
        .noc_r_tag(u_v1d_noc_r_tag),
        .noc_r_last(u_v1d_noc_r_last),
        .noc_ar_valid(u_v1d_noc_ar_valid),
        .noc_ar_ready(u_v1d_noc_ar_ready),
        .noc_ar_id(u_v1d_noc_ar_id),
        .noc_ar_tag(u_v1d_noc_ar_tag),
        .noc_ar_addr(u_v1d_noc_ar_addr),
        .noc_ar_bytes(u_v1d_noc_ar_bytes),
        .noc_ar_rows(u_v1d_noc_ar_rows),
        .noc_ar_stride(u_v1d_noc_ar_stride),
        .noc_ar_first(u_v1d_noc_ar_first),
        .noc_ar_last(u_v1d_noc_ar_last),
        .noc_aw_valid(u_v1d_noc_aw_valid),
        .noc_aw_ready(u_v1d_noc_aw_ready),
        .noc_aw_id(u_v1d_noc_aw_id),
        .noc_aw_tag(u_v1d_noc_aw_tag),
        .noc_aw_addr(u_v1d_noc_aw_addr),
        .noc_aw_bytes(u_v1d_noc_aw_bytes),
        .noc_aw_rows(u_v1d_noc_aw_rows),
        .noc_aw_stride(u_v1d_noc_aw_stride),
        .noc_aw_first(u_v1d_noc_aw_first),
        .noc_aw_last(u_v1d_noc_aw_last),
        .noc_b_valid(u_v1d_noc_b_valid),
        .noc_b_ready(u_v1d_noc_b_ready),
        .noc_b_id(u_v1d_noc_b_id),
        .noc_b_tag(u_v1d_noc_b_tag),
        .noc_a_valid(u_v1d_noc_a_valid),
        .noc_a_id(u_v1d_noc_a_id),
        .noc_a_tag(u_v1d_noc_a_tag),
        .dbg_busy(u_v1d_dbg_busy),
        .dbg_idle(u_v1d_dbg_idle),
        .dbg_donec(u_v1d_dbg_donec),
        .dbg_occ(u_v1d_dbg_occ)
    );
    Mac2DUnit u_m2d (
        .clk(clk),
        .rst_n(rst_n),
        .l1_ar_valid(u_m2d_l1_ar_valid),
        .l1_ar_ready(u_m2d_l1_ar_ready),
        .l1_ar_id(u_m2d_l1_ar_id),
        .l1_ar_tag(u_m2d_l1_ar_tag),
        .l1_ar_cfg(u_m2d_l1_ar_cfg),
        .l1_ar_off(u_m2d_l1_ar_off),
        .l1_ar_bytes(u_m2d_l1_ar_bytes),
        .l1_ar_rows(u_m2d_l1_ar_rows),
        .l1_ar_stride(u_m2d_l1_ar_stride),
        .l1_ar_first(u_m2d_l1_ar_first),
        .l1_ar_last(u_m2d_l1_ar_last),
        .l1_aw_valid(u_m2d_l1_aw_valid),
        .l1_aw_ready(u_m2d_l1_aw_ready),
        .l1_aw_id(u_m2d_l1_aw_id),
        .l1_aw_tag(u_m2d_l1_aw_tag),
        .l1_aw_cfg(u_m2d_l1_aw_cfg),
        .l1_aw_off(u_m2d_l1_aw_off),
        .l1_aw_bytes(u_m2d_l1_aw_bytes),
        .l1_aw_rows(u_m2d_l1_aw_rows),
        .l1_aw_stride(u_m2d_l1_aw_stride),
        .l1_aw_first(u_m2d_l1_aw_first),
        .l1_aw_last(u_m2d_l1_aw_last),
        .l1_b_valid(u_m2d_l1_b_valid),
        .l1_b_ready(u_m2d_l1_b_ready),
        .l1_b_id(u_m2d_l1_b_id),
        .l1_b_tag(u_m2d_l1_b_tag),
        .l1_a_valid(u_m2d_l1_a_valid),
        .l1_a_id(u_m2d_l1_a_id),
        .l1_a_tag(u_m2d_l1_a_tag),
        .ctrl_s_cm_valid(u_m2d_ctrl_s_cm_valid),
        .ctrl_s_cm_ready(u_m2d_ctrl_s_cm_ready),
        .ctrl_s_cm_addr(u_m2d_ctrl_s_cm_addr),
        .ctrl_s_cm_wdata(u_m2d_ctrl_s_cm_wdata),
        .ctrl_s_cm_write(u_m2d_ctrl_s_cm_write),
        .ctrl_s_cm_tag(u_m2d_ctrl_s_cm_tag),
        .ctrl_s_cr_valid(u_m2d_ctrl_s_cr_valid),
        .ctrl_s_cr_ready(u_m2d_ctrl_s_cr_ready),
        .ctrl_s_cr_data(u_m2d_ctrl_s_cr_data),
        .ctrl_s_cr_tag(u_m2d_ctrl_s_cr_tag),
        .l1_w_valid(u_m2d_l1_w_valid),
        .l1_w_id(u_m2d_l1_w_id),
        .l1_w_data(u_m2d_l1_w_data),
        .l1_w_strb(u_m2d_l1_w_strb),
        .l1_w_ready(u_m2d_l1_w_ready),
        .noc_w_valid(u_m2d_noc_w_valid),
        .noc_w_id(u_m2d_noc_w_id),
        .noc_w_data(u_m2d_noc_w_data),
        .noc_w_strb(u_m2d_noc_w_strb),
        .noc_w_ready(u_m2d_noc_w_ready),
        .l1_r_valid(u_m2d_l1_r_valid),
        .l1_r_ready(u_m2d_l1_r_ready),
        .l1_r_data(u_m2d_l1_r_data),
        .l1_r_id(u_m2d_l1_r_id),
        .l1_r_tag(u_m2d_l1_r_tag),
        .l1_r_last(u_m2d_l1_r_last),
        .noc_r_valid(u_m2d_noc_r_valid),
        .noc_r_ready(u_m2d_noc_r_ready),
        .noc_r_data(u_m2d_noc_r_data),
        .noc_r_id(u_m2d_noc_r_id),
        .noc_r_tag(u_m2d_noc_r_tag),
        .noc_r_last(u_m2d_noc_r_last),
        .noc_ar_valid(u_m2d_noc_ar_valid),
        .noc_ar_ready(u_m2d_noc_ar_ready),
        .noc_ar_id(u_m2d_noc_ar_id),
        .noc_ar_tag(u_m2d_noc_ar_tag),
        .noc_ar_addr(u_m2d_noc_ar_addr),
        .noc_ar_bytes(u_m2d_noc_ar_bytes),
        .noc_ar_rows(u_m2d_noc_ar_rows),
        .noc_ar_stride(u_m2d_noc_ar_stride),
        .noc_ar_first(u_m2d_noc_ar_first),
        .noc_ar_last(u_m2d_noc_ar_last),
        .noc_aw_valid(u_m2d_noc_aw_valid),
        .noc_aw_ready(u_m2d_noc_aw_ready),
        .noc_aw_id(u_m2d_noc_aw_id),
        .noc_aw_tag(u_m2d_noc_aw_tag),
        .noc_aw_addr(u_m2d_noc_aw_addr),
        .noc_aw_bytes(u_m2d_noc_aw_bytes),
        .noc_aw_rows(u_m2d_noc_aw_rows),
        .noc_aw_stride(u_m2d_noc_aw_stride),
        .noc_aw_first(u_m2d_noc_aw_first),
        .noc_aw_last(u_m2d_noc_aw_last),
        .noc_b_valid(u_m2d_noc_b_valid),
        .noc_b_ready(u_m2d_noc_b_ready),
        .noc_b_id(u_m2d_noc_b_id),
        .noc_b_tag(u_m2d_noc_b_tag),
        .noc_a_valid(u_m2d_noc_a_valid),
        .noc_a_id(u_m2d_noc_a_id),
        .noc_a_tag(u_m2d_noc_a_tag),
        .dbg_busy(u_m2d_dbg_busy),
        .dbg_idle(u_m2d_dbg_idle),
        .dbg_donec(u_m2d_dbg_donec),
        .dbg_occ(u_m2d_dbg_occ)
    );
    DmaUnitW u_dma (
        .clk(clk),
        .rst_n(rst_n),
        .l1_wroom(we_l1_dma_i_room),
        .noc_wroom(we_nc_dma_i_room),
        .l1_ar_valid(u_dma_l1_ar_valid),
        .l1_ar_ready(u_dma_l1_ar_ready),
        .l1_ar_id(u_dma_l1_ar_id),
        .l1_ar_tag(u_dma_l1_ar_tag),
        .l1_ar_cfg(u_dma_l1_ar_cfg),
        .l1_ar_off(u_dma_l1_ar_off),
        .l1_ar_bytes(u_dma_l1_ar_bytes),
        .l1_ar_rows(u_dma_l1_ar_rows),
        .l1_ar_stride(u_dma_l1_ar_stride),
        .l1_ar_first(u_dma_l1_ar_first),
        .l1_ar_last(u_dma_l1_ar_last),
        .l1_aw_valid(u_dma_l1_aw_valid),
        .l1_aw_ready(u_dma_l1_aw_ready),
        .l1_aw_id(u_dma_l1_aw_id),
        .l1_aw_tag(u_dma_l1_aw_tag),
        .l1_aw_cfg(u_dma_l1_aw_cfg),
        .l1_aw_off(u_dma_l1_aw_off),
        .l1_aw_bytes(u_dma_l1_aw_bytes),
        .l1_aw_rows(u_dma_l1_aw_rows),
        .l1_aw_stride(u_dma_l1_aw_stride),
        .l1_aw_first(u_dma_l1_aw_first),
        .l1_aw_last(u_dma_l1_aw_last),
        .l1_b_valid(u_dma_l1_b_valid),
        .l1_b_ready(u_dma_l1_b_ready),
        .l1_b_id(u_dma_l1_b_id),
        .l1_b_tag(u_dma_l1_b_tag),
        .l1_a_valid(u_dma_l1_a_valid),
        .l1_a_id(u_dma_l1_a_id),
        .l1_a_tag(u_dma_l1_a_tag),
        .ctrl_s_cm_valid(u_dma_ctrl_s_cm_valid),
        .ctrl_s_cm_ready(u_dma_ctrl_s_cm_ready),
        .ctrl_s_cm_addr(u_dma_ctrl_s_cm_addr),
        .ctrl_s_cm_wdata(u_dma_ctrl_s_cm_wdata),
        .ctrl_s_cm_write(u_dma_ctrl_s_cm_write),
        .ctrl_s_cm_tag(u_dma_ctrl_s_cm_tag),
        .ctrl_s_cr_valid(u_dma_ctrl_s_cr_valid),
        .ctrl_s_cr_ready(u_dma_ctrl_s_cr_ready),
        .ctrl_s_cr_data(u_dma_ctrl_s_cr_data),
        .ctrl_s_cr_tag(u_dma_ctrl_s_cr_tag),
        .l1_w_valid(u_dma_l1_w_valid),
        .l1_w_id(u_dma_l1_w_id),
        .l1_w_data(u_dma_l1_w_data),
        .l1_w_strb(u_dma_l1_w_strb),
        .l1_w_ready(u_dma_l1_w_ready),
        .noc_w_valid(u_dma_noc_w_valid),
        .noc_w_id(u_dma_noc_w_id),
        .noc_w_data(u_dma_noc_w_data),
        .noc_w_strb(u_dma_noc_w_strb),
        .noc_w_ready(u_dma_noc_w_ready),
        .l1_r_valid(u_dma_l1_r_valid),
        .l1_r_ready(u_dma_l1_r_ready),
        .l1_r_data(u_dma_l1_r_data),
        .l1_r_id(u_dma_l1_r_id),
        .l1_r_tag(u_dma_l1_r_tag),
        .l1_r_last(u_dma_l1_r_last),
        .noc_r_valid(u_dma_noc_r_valid),
        .noc_r_ready(u_dma_noc_r_ready),
        .noc_r_data(u_dma_noc_r_data),
        .noc_r_id(u_dma_noc_r_id),
        .noc_r_tag(u_dma_noc_r_tag),
        .noc_r_last(u_dma_noc_r_last),
        .noc_ar_valid(u_dma_noc_ar_valid),
        .noc_ar_ready(u_dma_noc_ar_ready),
        .noc_ar_id(u_dma_noc_ar_id),
        .noc_ar_tag(u_dma_noc_ar_tag),
        .noc_ar_addr(u_dma_noc_ar_addr),
        .noc_ar_bytes(u_dma_noc_ar_bytes),
        .noc_ar_rows(u_dma_noc_ar_rows),
        .noc_ar_stride(u_dma_noc_ar_stride),
        .noc_ar_first(u_dma_noc_ar_first),
        .noc_ar_last(u_dma_noc_ar_last),
        .noc_aw_valid(u_dma_noc_aw_valid),
        .noc_aw_ready(u_dma_noc_aw_ready),
        .noc_aw_id(u_dma_noc_aw_id),
        .noc_aw_tag(u_dma_noc_aw_tag),
        .noc_aw_addr(u_dma_noc_aw_addr),
        .noc_aw_bytes(u_dma_noc_aw_bytes),
        .noc_aw_rows(u_dma_noc_aw_rows),
        .noc_aw_stride(u_dma_noc_aw_stride),
        .noc_aw_first(u_dma_noc_aw_first),
        .noc_aw_last(u_dma_noc_aw_last),
        .noc_b_valid(u_dma_noc_b_valid),
        .noc_b_ready(u_dma_noc_b_ready),
        .noc_b_id(u_dma_noc_b_id),
        .noc_b_tag(u_dma_noc_b_tag),
        .noc_a_valid(u_dma_noc_a_valid),
        .noc_a_id(u_dma_noc_a_id),
        .noc_a_tag(u_dma_noc_a_tag),
        .dbg_busy(u_dma_dbg_busy),
        .dbg_ch_idle(u_dma_dbg_ch_idle),
        .dbg_seq_state(u_dma_dbg_seq_state),
        .dbg_noc_credit(u_dma_dbg_noc_credit)
    );
    L1Unit u_l1 (
        .clk(clk),
        .rst_n(rst_n),
        .p_0_ar_valid(u_dma_l1_ar_valid),
        .p_0_ar_ready(u_dma_l1_ar_ready),
        .p_0_ar_id(u_dma_l1_ar_id),
        .p_0_ar_tag(u_dma_l1_ar_tag),
        .p_0_ar_cfg(u_dma_l1_ar_cfg),
        .p_0_ar_off(u_dma_l1_ar_off),
        .p_0_ar_bytes(u_dma_l1_ar_bytes),
        .p_0_ar_rows(u_dma_l1_ar_rows),
        .p_0_ar_stride(u_dma_l1_ar_stride),
        .p_0_ar_first(u_dma_l1_ar_first),
        .p_0_ar_last(u_dma_l1_ar_last),
        .p_0_aw_valid(u_dma_l1_aw_valid),
        .p_0_aw_ready(u_dma_l1_aw_ready),
        .p_0_aw_id(u_dma_l1_aw_id),
        .p_0_aw_tag(u_dma_l1_aw_tag),
        .p_0_aw_cfg(u_dma_l1_aw_cfg),
        .p_0_aw_off(u_dma_l1_aw_off),
        .p_0_aw_bytes(u_dma_l1_aw_bytes),
        .p_0_aw_rows(u_dma_l1_aw_rows),
        .p_0_aw_stride(u_dma_l1_aw_stride),
        .p_0_aw_first(u_dma_l1_aw_first),
        .p_0_aw_last(u_dma_l1_aw_last),
        .p_0_w_valid(we_l1_dma_o_valid),
        .p_0_w_id(we_l1_dma_o_id),
        .p_0_w_data(we_l1_dma_o_data),
        .p_0_w_strb(we_l1_dma_o_strb),
        .p_0_w_ready(we_l1_dma_o_ready),
        .p_0_r_valid(re_l1_dma_i_valid),
        .p_0_r_ready(re_l1_dma_i_ready),
        .p_0_r_data(re_l1_dma_i_data),
        .p_0_r_id(re_l1_dma_i_id),
        .p_0_r_tag(re_l1_dma_i_tag),
        .p_0_r_last(re_l1_dma_i_last),
        .p_0_b_valid(u_dma_l1_b_valid),
        .p_0_b_ready(u_dma_l1_b_ready),
        .p_0_b_id(u_dma_l1_b_id),
        .p_0_b_tag(u_dma_l1_b_tag),
        .p_0_a_valid(u_dma_l1_a_valid),
        .p_0_a_id(u_dma_l1_a_id),
        .p_0_a_tag(u_dma_l1_a_tag),
        .p_1_ar_valid(u_v1d_l1_ar_valid),
        .p_1_ar_ready(u_v1d_l1_ar_ready),
        .p_1_ar_id(u_v1d_l1_ar_id),
        .p_1_ar_tag(u_v1d_l1_ar_tag),
        .p_1_ar_cfg(u_v1d_l1_ar_cfg),
        .p_1_ar_off(u_v1d_l1_ar_off),
        .p_1_ar_bytes(u_v1d_l1_ar_bytes),
        .p_1_ar_rows(u_v1d_l1_ar_rows),
        .p_1_ar_stride(u_v1d_l1_ar_stride),
        .p_1_ar_first(u_v1d_l1_ar_first),
        .p_1_ar_last(u_v1d_l1_ar_last),
        .p_1_aw_valid(u_v1d_l1_aw_valid),
        .p_1_aw_ready(u_v1d_l1_aw_ready),
        .p_1_aw_id(u_v1d_l1_aw_id),
        .p_1_aw_tag(u_v1d_l1_aw_tag),
        .p_1_aw_cfg(u_v1d_l1_aw_cfg),
        .p_1_aw_off(u_v1d_l1_aw_off),
        .p_1_aw_bytes(u_v1d_l1_aw_bytes),
        .p_1_aw_rows(u_v1d_l1_aw_rows),
        .p_1_aw_stride(u_v1d_l1_aw_stride),
        .p_1_aw_first(u_v1d_l1_aw_first),
        .p_1_aw_last(u_v1d_l1_aw_last),
        .p_1_w_valid(we_l1_v1d_o_valid),
        .p_1_w_id(we_l1_v1d_o_id),
        .p_1_w_data(we_l1_v1d_o_data),
        .p_1_w_strb(we_l1_v1d_o_strb),
        .p_1_w_ready(we_l1_v1d_o_ready),
        .p_1_r_valid(re_l1_v1d_i_valid),
        .p_1_r_ready(re_l1_v1d_i_ready),
        .p_1_r_data(re_l1_v1d_i_data),
        .p_1_r_id(re_l1_v1d_i_id),
        .p_1_r_tag(re_l1_v1d_i_tag),
        .p_1_r_last(re_l1_v1d_i_last),
        .p_1_b_valid(u_v1d_l1_b_valid),
        .p_1_b_ready(u_v1d_l1_b_ready),
        .p_1_b_id(u_v1d_l1_b_id),
        .p_1_b_tag(u_v1d_l1_b_tag),
        .p_1_a_valid(u_v1d_l1_a_valid),
        .p_1_a_id(u_v1d_l1_a_id),
        .p_1_a_tag(u_v1d_l1_a_tag),
        .p_2_ar_valid(u_m2d_l1_ar_valid),
        .p_2_ar_ready(u_m2d_l1_ar_ready),
        .p_2_ar_id(u_m2d_l1_ar_id),
        .p_2_ar_tag(u_m2d_l1_ar_tag),
        .p_2_ar_cfg(u_m2d_l1_ar_cfg),
        .p_2_ar_off(u_m2d_l1_ar_off),
        .p_2_ar_bytes(u_m2d_l1_ar_bytes),
        .p_2_ar_rows(u_m2d_l1_ar_rows),
        .p_2_ar_stride(u_m2d_l1_ar_stride),
        .p_2_ar_first(u_m2d_l1_ar_first),
        .p_2_ar_last(u_m2d_l1_ar_last),
        .p_2_aw_valid(u_m2d_l1_aw_valid),
        .p_2_aw_ready(u_m2d_l1_aw_ready),
        .p_2_aw_id(u_m2d_l1_aw_id),
        .p_2_aw_tag(u_m2d_l1_aw_tag),
        .p_2_aw_cfg(u_m2d_l1_aw_cfg),
        .p_2_aw_off(u_m2d_l1_aw_off),
        .p_2_aw_bytes(u_m2d_l1_aw_bytes),
        .p_2_aw_rows(u_m2d_l1_aw_rows),
        .p_2_aw_stride(u_m2d_l1_aw_stride),
        .p_2_aw_first(u_m2d_l1_aw_first),
        .p_2_aw_last(u_m2d_l1_aw_last),
        .p_2_w_valid(we_l1_m2d_o_valid),
        .p_2_w_id(we_l1_m2d_o_id),
        .p_2_w_data(we_l1_m2d_o_data),
        .p_2_w_strb(we_l1_m2d_o_strb),
        .p_2_w_ready(we_l1_m2d_o_ready),
        .p_2_r_valid(re_l1_m2d_i_valid),
        .p_2_r_ready(re_l1_m2d_i_ready),
        .p_2_r_data(re_l1_m2d_i_data),
        .p_2_r_id(re_l1_m2d_i_id),
        .p_2_r_tag(re_l1_m2d_i_tag),
        .p_2_r_last(re_l1_m2d_i_last),
        .p_2_b_valid(u_m2d_l1_b_valid),
        .p_2_b_ready(u_m2d_l1_b_ready),
        .p_2_b_id(u_m2d_l1_b_id),
        .p_2_b_tag(u_m2d_l1_b_tag),
        .p_2_a_valid(u_m2d_l1_a_valid),
        .p_2_a_id(u_m2d_l1_a_id),
        .p_2_a_tag(u_m2d_l1_a_tag),
        .dbg_pend_write(stat_l1_pend_write),
        .dbg_mismatch(stat_l1_mismatch),
        .dbg_torn(stat_l1_torn),
        .dbg_gate_block(stat_l1_gate_block),
        .dbg_admit(stat_l1_admit),
        .dbg_cfg_pend(stat_l1_cfg_pend),
        .dbg_live_slots(stat_l1_live_slots),
        .dbg_instq(stat_l1_instq),
        .dbg_gateq(stat_l1_gateq),
        .dbg_gateq2(stat_l1_gateq2),
        .dbg_grant(stat_l1_grant),
        .dbg_stall(stat_l1_stall),
        .dbg_occ0(stat_l1_occ0),
        .dbg_occ1(stat_l1_occ1),
        .dbg_occ2(stat_l1_occ2),
        .ctrl_s_cm_valid(u_l1_ctrl_s_cm_valid),
        .ctrl_s_cm_ready(u_l1_ctrl_s_cm_ready),
        .ctrl_s_cm_addr(u_l1_ctrl_s_cm_addr),
        .ctrl_s_cm_wdata(u_l1_ctrl_s_cm_wdata),
        .ctrl_s_cm_write(u_l1_ctrl_s_cm_write),
        .ctrl_s_cm_tag(u_l1_ctrl_s_cm_tag),
        .ctrl_s_cr_valid(u_l1_ctrl_s_cr_valid),
        .ctrl_s_cr_ready(u_l1_ctrl_s_cr_ready),
        .ctrl_s_cr_data(u_l1_ctrl_s_cr_data),
        .ctrl_s_cr_tag(u_l1_ctrl_s_cr_tag)
    );
    CtrlBus u_bus (
        .clk(clk),
        .rst_n(rst_n),
        .m_0_cm_valid(u_cpu_ctrl_cm_valid),
        .m_0_cm_ready(u_cpu_ctrl_cm_ready),
        .m_0_cm_addr(u_cpu_ctrl_cm_addr),
        .m_0_cm_wdata(u_cpu_ctrl_cm_wdata),
        .m_0_cm_write(u_cpu_ctrl_cm_write),
        .m_0_cm_tag(u_cpu_ctrl_cm_tag),
        .m_0_cr_valid(u_cpu_ctrl_cr_valid),
        .m_0_cr_ready(u_cpu_ctrl_cr_ready),
        .m_0_cr_data(u_cpu_ctrl_cr_data),
        .m_0_cr_tag(u_cpu_ctrl_cr_tag),
        .m_1_cm_valid(hc_cm_valid),
        .m_1_cm_ready(hc_cm_ready),
        .m_1_cm_addr(hc_cm_addr),
        .m_1_cm_wdata(hc_cm_wdata),
        .m_1_cm_write(hc_cm_write),
        .m_1_cm_tag(hc_cm_tag),
        .m_1_cr_valid(hc_cr_valid),
        .m_1_cr_ready(hc_cr_ready),
        .m_1_cr_data(hc_cr_data),
        .m_1_cr_tag(hc_cr_tag),
        .s_0_cm_valid(u_dma_ctrl_s_cm_valid),
        .s_0_cm_ready(u_dma_ctrl_s_cm_ready),
        .s_0_cm_addr(u_dma_ctrl_s_cm_addr),
        .s_0_cm_wdata(u_dma_ctrl_s_cm_wdata),
        .s_0_cm_write(u_dma_ctrl_s_cm_write),
        .s_0_cm_tag(u_dma_ctrl_s_cm_tag),
        .s_0_cr_valid(u_dma_ctrl_s_cr_valid),
        .s_0_cr_ready(u_dma_ctrl_s_cr_ready),
        .s_0_cr_data(u_dma_ctrl_s_cr_data),
        .s_0_cr_tag(u_dma_ctrl_s_cr_tag),
        .s_1_cm_valid(u_v1d_ctrl_s_cm_valid),
        .s_1_cm_ready(u_v1d_ctrl_s_cm_ready),
        .s_1_cm_addr(u_v1d_ctrl_s_cm_addr),
        .s_1_cm_wdata(u_v1d_ctrl_s_cm_wdata),
        .s_1_cm_write(u_v1d_ctrl_s_cm_write),
        .s_1_cm_tag(u_v1d_ctrl_s_cm_tag),
        .s_1_cr_valid(u_v1d_ctrl_s_cr_valid),
        .s_1_cr_ready(u_v1d_ctrl_s_cr_ready),
        .s_1_cr_data(u_v1d_ctrl_s_cr_data),
        .s_1_cr_tag(u_v1d_ctrl_s_cr_tag),
        .s_2_cm_valid(u_m2d_ctrl_s_cm_valid),
        .s_2_cm_ready(u_m2d_ctrl_s_cm_ready),
        .s_2_cm_addr(u_m2d_ctrl_s_cm_addr),
        .s_2_cm_wdata(u_m2d_ctrl_s_cm_wdata),
        .s_2_cm_write(u_m2d_ctrl_s_cm_write),
        .s_2_cm_tag(u_m2d_ctrl_s_cm_tag),
        .s_2_cr_valid(u_m2d_ctrl_s_cr_valid),
        .s_2_cr_ready(u_m2d_ctrl_s_cr_ready),
        .s_2_cr_data(u_m2d_ctrl_s_cr_data),
        .s_2_cr_tag(u_m2d_ctrl_s_cr_tag),
        .s_3_cm_valid(u_l1_ctrl_s_cm_valid),
        .s_3_cm_ready(u_l1_ctrl_s_cm_ready),
        .s_3_cm_addr(u_l1_ctrl_s_cm_addr),
        .s_3_cm_wdata(u_l1_ctrl_s_cm_wdata),
        .s_3_cm_write(u_l1_ctrl_s_cm_write),
        .s_3_cm_tag(u_l1_ctrl_s_cm_tag),
        .s_3_cr_valid(u_l1_ctrl_s_cr_valid),
        .s_3_cr_ready(u_l1_ctrl_s_cr_ready),
        .s_3_cr_data(u_l1_ctrl_s_cr_data),
        .s_3_cr_tag(u_l1_ctrl_s_cr_tag),
        .dbg_route_target(u_bus_dbg_route_target),
        .dbg_inflight(u_bus_dbg_inflight),
        .dbg_slave_ready(u_bus_dbg_slave_ready),
        .dbg_cfg_ack_age(u_bus_dbg_cfg_ack_age)
    );
    WEgressW8 we_l1_dma (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(u_dma_l1_w_valid),
        .i_id(u_dma_l1_w_id),
        .i_data(u_dma_l1_w_data),
        .i_strb(u_dma_l1_w_strb),
        .i_ready(u_dma_l1_w_ready),
        .i_room(we_l1_dma_i_room),
        .o_valid(we_l1_dma_o_valid),
        .o_id(we_l1_dma_o_id),
        .o_data(we_l1_dma_o_data),
        .o_strb(we_l1_dma_o_strb),
        .o_ready(we_l1_dma_o_ready)
    );
    WEgressW8 we_nc_dma (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(u_dma_noc_w_valid),
        .i_id(u_dma_noc_w_id),
        .i_data(u_dma_noc_w_data),
        .i_strb(u_dma_noc_w_strb),
        .i_ready(u_dma_noc_w_ready),
        .i_room(we_nc_dma_i_room),
        .o_valid(we_nc_dma_o_valid),
        .o_id(we_nc_dma_o_id),
        .o_data(we_nc_dma_o_data),
        .o_strb(we_nc_dma_o_strb),
        .o_ready(we_nc_dma_o_ready)
    );
    WEgress512 we_l1_v1d (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(u_v1d_l1_w_valid),
        .i_id(u_v1d_l1_w_id),
        .i_data(u_v1d_l1_w_data),
        .i_strb(u_v1d_l1_w_strb),
        .i_ready(u_v1d_l1_w_ready),
        .o_valid(we_l1_v1d_o_valid),
        .o_id(we_l1_v1d_o_id),
        .o_data(we_l1_v1d_o_data),
        .o_strb(we_l1_v1d_o_strb),
        .o_ready(we_l1_v1d_o_ready)
    );
    WEgress512 we_l1_m2d (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(u_m2d_l1_w_valid),
        .i_id(u_m2d_l1_w_id),
        .i_data(u_m2d_l1_w_data),
        .i_strb(u_m2d_l1_w_strb),
        .i_ready(u_m2d_l1_w_ready),
        .o_valid(we_l1_m2d_o_valid),
        .o_id(we_l1_m2d_o_id),
        .o_data(we_l1_m2d_o_data),
        .o_strb(we_l1_m2d_o_strb),
        .o_ready(we_l1_m2d_o_ready)
    );
    WEgress512 we_nc_v1d (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(u_v1d_noc_w_valid),
        .i_id(u_v1d_noc_w_id),
        .i_data(u_v1d_noc_w_data),
        .i_strb(u_v1d_noc_w_strb),
        .i_ready(u_v1d_noc_w_ready),
        .o_valid(we_nc_v1d_o_valid),
        .o_id(we_nc_v1d_o_id),
        .o_data(we_nc_v1d_o_data),
        .o_strb(we_nc_v1d_o_strb),
        .o_ready(we_nc_v1d_o_ready)
    );
    WEgress512 we_nc_m2d (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(u_m2d_noc_w_valid),
        .i_id(u_m2d_noc_w_id),
        .i_data(u_m2d_noc_w_data),
        .i_strb(u_m2d_noc_w_strb),
        .i_ready(u_m2d_noc_w_ready),
        .o_valid(we_nc_m2d_o_valid),
        .o_id(we_nc_m2d_o_id),
        .o_data(we_nc_m2d_o_data),
        .o_strb(we_nc_m2d_o_strb),
        .o_ready(we_nc_m2d_o_ready)
    );
    REgress re_l1_dma (
        .clk(clk),
        .rst_n(rst_n),
        .o_valid(u_dma_l1_r_valid),
        .o_ready(u_dma_l1_r_ready),
        .o_data(u_dma_l1_r_data),
        .o_id(u_dma_l1_r_id),
        .o_tag(u_dma_l1_r_tag),
        .o_last(u_dma_l1_r_last),
        .i_valid(re_l1_dma_i_valid),
        .i_ready(re_l1_dma_i_ready),
        .i_data(re_l1_dma_i_data),
        .i_id(re_l1_dma_i_id),
        .i_tag(re_l1_dma_i_tag),
        .i_last(re_l1_dma_i_last)
    );
    REgress512 re_l1_v1d (
        .clk(clk),
        .rst_n(rst_n),
        .o_valid(u_v1d_l1_r_valid),
        .o_ready(u_v1d_l1_r_ready),
        .o_data(u_v1d_l1_r_data),
        .o_id(u_v1d_l1_r_id),
        .o_tag(u_v1d_l1_r_tag),
        .o_last(u_v1d_l1_r_last),
        .i_valid(re_l1_v1d_i_valid),
        .i_ready(re_l1_v1d_i_ready),
        .i_data(re_l1_v1d_i_data),
        .i_id(re_l1_v1d_i_id),
        .i_tag(re_l1_v1d_i_tag),
        .i_last(re_l1_v1d_i_last)
    );
    REgress re_l1_m2d (
        .clk(clk),
        .rst_n(rst_n),
        .o_valid(u_m2d_l1_r_valid),
        .o_ready(u_m2d_l1_r_ready),
        .o_data(u_m2d_l1_r_data),
        .o_id(u_m2d_l1_r_id),
        .o_tag(u_m2d_l1_r_tag),
        .o_last(u_m2d_l1_r_last),
        .i_valid(re_l1_m2d_i_valid),
        .i_ready(re_l1_m2d_i_ready),
        .i_data(re_l1_m2d_i_data),
        .i_id(re_l1_m2d_i_id),
        .i_tag(re_l1_m2d_i_tag),
        .i_last(re_l1_m2d_i_last)
    );
    REgress re_nc_dma (
        .clk(clk),
        .rst_n(rst_n),
        .o_valid(u_dma_noc_r_valid),
        .o_ready(u_dma_noc_r_ready),
        .o_data(u_dma_noc_r_data),
        .o_id(u_dma_noc_r_id),
        .o_tag(u_dma_noc_r_tag),
        .o_last(u_dma_noc_r_last),
        .i_valid(re_nc_dma_i_valid),
        .i_ready(re_nc_dma_i_ready),
        .i_data(re_nc_dma_i_data),
        .i_id(re_nc_dma_i_id),
        .i_tag(re_nc_dma_i_tag),
        .i_last(re_nc_dma_i_last)
    );
    REgress512 re_nc_v1d (
        .clk(clk),
        .rst_n(rst_n),
        .o_valid(u_v1d_noc_r_valid),
        .o_ready(u_v1d_noc_r_ready),
        .o_data(u_v1d_noc_r_data),
        .o_id(u_v1d_noc_r_id),
        .o_tag(u_v1d_noc_r_tag),
        .o_last(u_v1d_noc_r_last),
        .i_valid(re_nc_v1d_i_valid),
        .i_ready(re_nc_v1d_i_ready),
        .i_data(re_nc_v1d_i_data),
        .i_id(re_nc_v1d_i_id),
        .i_tag(re_nc_v1d_i_tag),
        .i_last(re_nc_v1d_i_last)
    );
    REgress re_nc_m2d (
        .clk(clk),
        .rst_n(rst_n),
        .o_valid(u_m2d_noc_r_valid),
        .o_ready(u_m2d_noc_r_ready),
        .o_data(u_m2d_noc_r_data),
        .o_id(u_m2d_noc_r_id),
        .o_tag(u_m2d_noc_r_tag),
        .o_last(u_m2d_noc_r_last),
        .i_valid(re_nc_m2d_i_valid),
        .i_ready(re_nc_m2d_i_ready),
        .i_data(re_nc_m2d_i_data),
        .i_id(re_nc_m2d_i_id),
        .i_tag(re_nc_m2d_i_tag),
        .i_last(re_nc_m2d_i_last)
    );
    WLag lag_hp (
        .clk(clk),
        .i_valid(u_hp_p_3_w_valid),
        .i_id(u_hp_p_3_w_id),
        .i_data(u_hp_p_3_w_data),
        .i_strb(u_hp_p_3_w_strb),
        .i_ready(u_hp_p_3_w_ready),
        .o_valid(lag_hp_o_valid),
        .o_id(lag_hp_o_id),
        .o_data(lag_hp_o_data),
        .o_strb(lag_hp_o_strb),
        .o_ready(lag_hp_o_ready)
    );
    WLag lag_cpu (
        .clk(clk),
        .i_valid(u_brg_p_w_valid),
        .i_id(u_brg_p_w_id),
        .i_data(u_brg_p_w_data),
        .i_strb(u_brg_p_w_strb),
        .i_ready(u_brg_p_w_ready),
        .o_valid(lag_cpu_o_valid),
        .o_id(lag_cpu_o_id),
        .o_data(lag_cpu_o_data),
        .o_strb(lag_cpu_o_strb),
        .o_ready(lag_cpu_o_ready)
    );
    NocUnit u_noc (
        .clk(clk),
        .rst_n(rst_n),
        .stat_clr_all(stat_clr_all),
        .p_0_ar_valid(u_dma_noc_ar_valid),
        .p_0_ar_ready(u_dma_noc_ar_ready),
        .p_0_ar_id(u_dma_noc_ar_id),
        .p_0_ar_tag(u_dma_noc_ar_tag),
        .p_0_ar_addr(u_dma_noc_ar_addr),
        .p_0_ar_bytes(u_dma_noc_ar_bytes),
        .p_0_ar_rows(u_dma_noc_ar_rows),
        .p_0_ar_stride(u_dma_noc_ar_stride),
        .p_0_ar_first(u_dma_noc_ar_first),
        .p_0_ar_last(u_dma_noc_ar_last),
        .p_0_aw_valid(u_dma_noc_aw_valid),
        .p_0_aw_ready(u_dma_noc_aw_ready),
        .p_0_aw_id(u_dma_noc_aw_id),
        .p_0_aw_tag(u_dma_noc_aw_tag),
        .p_0_aw_addr(u_dma_noc_aw_addr),
        .p_0_aw_bytes(u_dma_noc_aw_bytes),
        .p_0_aw_rows(u_dma_noc_aw_rows),
        .p_0_aw_stride(u_dma_noc_aw_stride),
        .p_0_aw_first(u_dma_noc_aw_first),
        .p_0_aw_last(u_dma_noc_aw_last),
        .p_0_w_valid(we_nc_dma_o_valid),
        .p_0_w_id(we_nc_dma_o_id),
        .p_0_w_data(we_nc_dma_o_data),
        .p_0_w_strb(we_nc_dma_o_strb),
        .p_0_w_ready(we_nc_dma_o_ready),
        .p_0_r_valid(re_nc_dma_i_valid),
        .p_0_r_ready(re_nc_dma_i_ready),
        .p_0_r_data(re_nc_dma_i_data),
        .p_0_r_id(re_nc_dma_i_id),
        .p_0_r_tag(re_nc_dma_i_tag),
        .p_0_r_last(re_nc_dma_i_last),
        .p_0_b_valid(u_dma_noc_b_valid),
        .p_0_b_ready(u_dma_noc_b_ready),
        .p_0_b_id(u_dma_noc_b_id),
        .p_0_b_tag(u_dma_noc_b_tag),
        .p_0_a_valid(u_dma_noc_a_valid),
        .p_0_a_id(u_dma_noc_a_id),
        .p_0_a_tag(u_dma_noc_a_tag),
        .p_1_ar_valid(u_v1d_noc_ar_valid),
        .p_1_ar_ready(u_v1d_noc_ar_ready),
        .p_1_ar_id(u_v1d_noc_ar_id),
        .p_1_ar_tag(u_v1d_noc_ar_tag),
        .p_1_ar_addr(u_v1d_noc_ar_addr),
        .p_1_ar_bytes(u_v1d_noc_ar_bytes),
        .p_1_ar_rows(u_v1d_noc_ar_rows),
        .p_1_ar_stride(u_v1d_noc_ar_stride),
        .p_1_ar_first(u_v1d_noc_ar_first),
        .p_1_ar_last(u_v1d_noc_ar_last),
        .p_1_aw_valid(u_v1d_noc_aw_valid),
        .p_1_aw_ready(u_v1d_noc_aw_ready),
        .p_1_aw_id(u_v1d_noc_aw_id),
        .p_1_aw_tag(u_v1d_noc_aw_tag),
        .p_1_aw_addr(u_v1d_noc_aw_addr),
        .p_1_aw_bytes(u_v1d_noc_aw_bytes),
        .p_1_aw_rows(u_v1d_noc_aw_rows),
        .p_1_aw_stride(u_v1d_noc_aw_stride),
        .p_1_aw_first(u_v1d_noc_aw_first),
        .p_1_aw_last(u_v1d_noc_aw_last),
        .p_1_w_valid(we_nc_v1d_o_valid),
        .p_1_w_id(we_nc_v1d_o_id),
        .p_1_w_data(we_nc_v1d_o_data),
        .p_1_w_strb(we_nc_v1d_o_strb),
        .p_1_w_ready(we_nc_v1d_o_ready),
        .p_1_r_valid(re_nc_v1d_i_valid),
        .p_1_r_ready(re_nc_v1d_i_ready),
        .p_1_r_data(re_nc_v1d_i_data),
        .p_1_r_id(re_nc_v1d_i_id),
        .p_1_r_tag(re_nc_v1d_i_tag),
        .p_1_r_last(re_nc_v1d_i_last),
        .p_1_b_valid(u_v1d_noc_b_valid),
        .p_1_b_ready(u_v1d_noc_b_ready),
        .p_1_b_id(u_v1d_noc_b_id),
        .p_1_b_tag(u_v1d_noc_b_tag),
        .p_1_a_valid(u_v1d_noc_a_valid),
        .p_1_a_id(u_v1d_noc_a_id),
        .p_1_a_tag(u_v1d_noc_a_tag),
        .p_2_ar_valid(u_m2d_noc_ar_valid),
        .p_2_ar_ready(u_m2d_noc_ar_ready),
        .p_2_ar_id(u_m2d_noc_ar_id),
        .p_2_ar_tag(u_m2d_noc_ar_tag),
        .p_2_ar_addr(u_m2d_noc_ar_addr),
        .p_2_ar_bytes(u_m2d_noc_ar_bytes),
        .p_2_ar_rows(u_m2d_noc_ar_rows),
        .p_2_ar_stride(u_m2d_noc_ar_stride),
        .p_2_ar_first(u_m2d_noc_ar_first),
        .p_2_ar_last(u_m2d_noc_ar_last),
        .p_2_aw_valid(u_m2d_noc_aw_valid),
        .p_2_aw_ready(u_m2d_noc_aw_ready),
        .p_2_aw_id(u_m2d_noc_aw_id),
        .p_2_aw_tag(u_m2d_noc_aw_tag),
        .p_2_aw_addr(u_m2d_noc_aw_addr),
        .p_2_aw_bytes(u_m2d_noc_aw_bytes),
        .p_2_aw_rows(u_m2d_noc_aw_rows),
        .p_2_aw_stride(u_m2d_noc_aw_stride),
        .p_2_aw_first(u_m2d_noc_aw_first),
        .p_2_aw_last(u_m2d_noc_aw_last),
        .p_2_w_valid(we_nc_m2d_o_valid),
        .p_2_w_id(we_nc_m2d_o_id),
        .p_2_w_data(we_nc_m2d_o_data),
        .p_2_w_strb(we_nc_m2d_o_strb),
        .p_2_w_ready(we_nc_m2d_o_ready),
        .p_2_r_valid(re_nc_m2d_i_valid),
        .p_2_r_ready(re_nc_m2d_i_ready),
        .p_2_r_data(re_nc_m2d_i_data),
        .p_2_r_id(re_nc_m2d_i_id),
        .p_2_r_tag(re_nc_m2d_i_tag),
        .p_2_r_last(re_nc_m2d_i_last),
        .p_2_b_valid(u_m2d_noc_b_valid),
        .p_2_b_ready(u_m2d_noc_b_ready),
        .p_2_b_id(u_m2d_noc_b_id),
        .p_2_b_tag(u_m2d_noc_b_tag),
        .p_2_a_valid(u_m2d_noc_a_valid),
        .p_2_a_id(u_m2d_noc_a_id),
        .p_2_a_tag(u_m2d_noc_a_tag),
        .p_3_ar_valid(u_hp_p_3_ar_valid),
        .p_3_ar_ready(u_hp_p_3_ar_ready),
        .p_3_ar_id(u_hp_p_3_ar_id),
        .p_3_ar_tag(u_hp_p_3_ar_tag),
        .p_3_ar_addr(u_hp_p_3_ar_addr),
        .p_3_ar_bytes(u_hp_p_3_ar_bytes),
        .p_3_ar_rows(u_hp_p_3_ar_rows),
        .p_3_ar_stride(u_hp_p_3_ar_stride),
        .p_3_ar_first(u_hp_p_3_ar_first),
        .p_3_ar_last(u_hp_p_3_ar_last),
        .p_3_aw_valid(u_hp_p_3_aw_valid),
        .p_3_aw_ready(u_hp_p_3_aw_ready),
        .p_3_aw_id(u_hp_p_3_aw_id),
        .p_3_aw_tag(u_hp_p_3_aw_tag),
        .p_3_aw_addr(u_hp_p_3_aw_addr),
        .p_3_aw_bytes(u_hp_p_3_aw_bytes),
        .p_3_aw_rows(u_hp_p_3_aw_rows),
        .p_3_aw_stride(u_hp_p_3_aw_stride),
        .p_3_aw_first(u_hp_p_3_aw_first),
        .p_3_aw_last(u_hp_p_3_aw_last),
        .p_3_w_valid(lag_hp_o_valid),
        .p_3_w_id(lag_hp_o_id),
        .p_3_w_data(lag_hp_o_data),
        .p_3_w_strb(lag_hp_o_strb),
        .p_3_w_ready(lag_hp_o_ready),
        .p_3_r_valid(u_hp_p_3_r_valid),
        .p_3_r_ready(u_hp_p_3_r_ready),
        .p_3_r_data(u_hp_p_3_r_data),
        .p_3_r_id(u_hp_p_3_r_id),
        .p_3_r_tag(u_hp_p_3_r_tag),
        .p_3_r_last(u_hp_p_3_r_last),
        .p_3_b_valid(u_hp_p_3_b_valid),
        .p_3_b_ready(u_hp_p_3_b_ready),
        .p_3_b_id(u_hp_p_3_b_id),
        .p_3_b_tag(u_hp_p_3_b_tag),
        .p_3_a_valid(u_hp_p_3_a_valid),
        .p_3_a_id(u_hp_p_3_a_id),
        .p_3_a_tag(u_hp_p_3_a_tag),
        .p_4_ar_valid(u_brg_p_ar_valid),
        .p_4_ar_ready(u_brg_p_ar_ready),
        .p_4_ar_id(u_brg_p_ar_id),
        .p_4_ar_tag(u_brg_p_ar_tag),
        .p_4_ar_addr(u_brg_p_ar_addr),
        .p_4_ar_bytes(u_brg_p_ar_bytes),
        .p_4_ar_rows(u_brg_p_ar_rows),
        .p_4_ar_stride(u_brg_p_ar_stride),
        .p_4_ar_first(u_brg_p_ar_first),
        .p_4_ar_last(u_brg_p_ar_last),
        .p_4_aw_valid(u_brg_p_aw_valid),
        .p_4_aw_ready(u_brg_p_aw_ready),
        .p_4_aw_id(u_brg_p_aw_id),
        .p_4_aw_tag(u_brg_p_aw_tag),
        .p_4_aw_addr(u_brg_p_aw_addr),
        .p_4_aw_bytes(u_brg_p_aw_bytes),
        .p_4_aw_rows(u_brg_p_aw_rows),
        .p_4_aw_stride(u_brg_p_aw_stride),
        .p_4_aw_first(u_brg_p_aw_first),
        .p_4_aw_last(u_brg_p_aw_last),
        .p_4_w_valid(lag_cpu_o_valid),
        .p_4_w_id(lag_cpu_o_id),
        .p_4_w_data(lag_cpu_o_data),
        .p_4_w_strb(lag_cpu_o_strb),
        .p_4_w_ready(lag_cpu_o_ready),
        .p_4_r_valid(u_brg_p_r_valid),
        .p_4_r_ready(u_brg_p_r_ready),
        .p_4_r_data(u_brg_p_r_data),
        .p_4_r_id(u_brg_p_r_id),
        .p_4_r_tag(u_brg_p_r_tag),
        .p_4_r_last(u_brg_p_r_last),
        .p_4_b_valid(u_brg_p_b_valid),
        .p_4_b_ready(u_brg_p_b_ready),
        .p_4_b_id(u_brg_p_b_id),
        .p_4_b_tag(u_brg_p_b_tag),
        .p_4_a_valid(u_brg_p_a_valid),
        .p_4_a_id(u_brg_p_a_id),
        .p_4_a_tag(u_brg_p_a_tag),
        .m_0_ar_valid(m_0_ar_valid),
        .m_0_ar_ready(m_0_ar_ready),
        .m_0_ar_id(m_0_ar_id),
        .m_0_ar_addr(m_0_ar_addr),
        .m_0_ar_len(m_0_ar_len),
        .m_0_aw_valid(m_0_aw_valid),
        .m_0_aw_ready(m_0_aw_ready),
        .m_0_aw_id(m_0_aw_id),
        .m_0_aw_addr(m_0_aw_addr),
        .m_0_aw_len(m_0_aw_len),
        .m_0_w_valid(m_0_w_valid),
        .m_0_w_ready(m_0_w_ready),
        .m_0_w_data(m_0_w_data),
        .m_0_w_strb(m_0_w_strb),
        .m_0_w_last(m_0_w_last),
        .m_0_b_valid(m_0_b_valid),
        .m_0_b_ready(m_0_b_ready),
        .m_0_b_id(m_0_b_id),
        .m_0_r_valid(m_0_r_valid),
        .m_0_r_ready(m_0_r_ready),
        .m_0_r_id(m_0_r_id),
        .m_0_r_data(m_0_r_data),
        .m_0_r_last(m_0_r_last),
        .m_1_ar_valid(m_1_ar_valid),
        .m_1_ar_ready(m_1_ar_ready),
        .m_1_ar_id(m_1_ar_id),
        .m_1_ar_addr(m_1_ar_addr),
        .m_1_ar_len(m_1_ar_len),
        .m_1_aw_valid(m_1_aw_valid),
        .m_1_aw_ready(m_1_aw_ready),
        .m_1_aw_id(m_1_aw_id),
        .m_1_aw_addr(m_1_aw_addr),
        .m_1_aw_len(m_1_aw_len),
        .m_1_w_valid(m_1_w_valid),
        .m_1_w_ready(m_1_w_ready),
        .m_1_w_data(m_1_w_data),
        .m_1_w_strb(m_1_w_strb),
        .m_1_w_last(m_1_w_last),
        .m_1_b_valid(m_1_b_valid),
        .m_1_b_ready(m_1_b_ready),
        .m_1_b_id(m_1_b_id),
        .m_1_r_valid(m_1_r_valid),
        .m_1_r_ready(m_1_r_ready),
        .m_1_r_id(m_1_r_id),
        .m_1_r_data(m_1_r_data),
        .m_1_r_last(m_1_r_last),
        .dbg_pend_write(stat_noc_pend_write),
        .dbg_admit(stat_noc_admit),
        .dbg_port_stall(stat_noc_port_stall),
        .dbg_idle(stat_noc_idle),
        .dbg_win_occ(stat_noc_win_occ),
        .dbg_infl_occ(stat_noc_infl_occ),
        .dbg_rd_out(stat_noc_rd_out),
        .dbg_asm_occ(stat_noc_asm_occ),
        .dbg_asm_blk(stat_noc_asm_blk),
        .dbg_lane_busy(stat_noc_lane_busy),
        .dbg_occ0(stat_noc_occ0),
        .dbg_occ1(stat_noc_occ1),
        .dbg_occ2(stat_noc_occ2),
        .dbg_occ3(stat_noc_occ3),
        .dbg_occ4(stat_noc_occ4)
    );
    NocPortSink u_sink_0 (
        .p_ar_valid(u_hp_p_0_ar_valid),
        .p_ar_ready(u_hp_p_0_ar_ready),
        .p_ar_id(u_hp_p_0_ar_id),
        .p_ar_tag(u_hp_p_0_ar_tag),
        .p_ar_addr(u_hp_p_0_ar_addr),
        .p_ar_bytes(u_hp_p_0_ar_bytes),
        .p_ar_rows(u_hp_p_0_ar_rows),
        .p_ar_stride(u_hp_p_0_ar_stride),
        .p_ar_first(u_hp_p_0_ar_first),
        .p_ar_last(u_hp_p_0_ar_last),
        .p_aw_valid(u_hp_p_0_aw_valid),
        .p_aw_ready(u_hp_p_0_aw_ready),
        .p_aw_id(u_hp_p_0_aw_id),
        .p_aw_tag(u_hp_p_0_aw_tag),
        .p_aw_addr(u_hp_p_0_aw_addr),
        .p_aw_bytes(u_hp_p_0_aw_bytes),
        .p_aw_rows(u_hp_p_0_aw_rows),
        .p_aw_stride(u_hp_p_0_aw_stride),
        .p_aw_first(u_hp_p_0_aw_first),
        .p_aw_last(u_hp_p_0_aw_last),
        .p_w_valid(u_hp_p_0_w_valid),
        .p_w_id(u_hp_p_0_w_id),
        .p_w_data(u_hp_p_0_w_data),
        .p_w_strb(u_hp_p_0_w_strb),
        .p_w_ready(u_hp_p_0_w_ready),
        .p_r_valid(u_hp_p_0_r_valid),
        .p_r_ready(u_hp_p_0_r_ready),
        .p_r_data(u_hp_p_0_r_data),
        .p_r_id(u_hp_p_0_r_id),
        .p_r_tag(u_hp_p_0_r_tag),
        .p_r_last(u_hp_p_0_r_last),
        .p_b_valid(u_hp_p_0_b_valid),
        .p_b_ready(u_hp_p_0_b_ready),
        .p_b_id(u_hp_p_0_b_id),
        .p_b_tag(u_hp_p_0_b_tag),
        .p_a_valid(u_hp_p_0_a_valid),
        .p_a_id(u_hp_p_0_a_id),
        .p_a_tag(u_hp_p_0_a_tag)
    );
    NocPortSink512_512 u_sink_1 (
        .p_ar_valid(u_hp_p_1_ar_valid),
        .p_ar_ready(u_hp_p_1_ar_ready),
        .p_ar_id(u_hp_p_1_ar_id),
        .p_ar_tag(u_hp_p_1_ar_tag),
        .p_ar_addr(u_hp_p_1_ar_addr),
        .p_ar_bytes(u_hp_p_1_ar_bytes),
        .p_ar_rows(u_hp_p_1_ar_rows),
        .p_ar_stride(u_hp_p_1_ar_stride),
        .p_ar_first(u_hp_p_1_ar_first),
        .p_ar_last(u_hp_p_1_ar_last),
        .p_aw_valid(u_hp_p_1_aw_valid),
        .p_aw_ready(u_hp_p_1_aw_ready),
        .p_aw_id(u_hp_p_1_aw_id),
        .p_aw_tag(u_hp_p_1_aw_tag),
        .p_aw_addr(u_hp_p_1_aw_addr),
        .p_aw_bytes(u_hp_p_1_aw_bytes),
        .p_aw_rows(u_hp_p_1_aw_rows),
        .p_aw_stride(u_hp_p_1_aw_stride),
        .p_aw_first(u_hp_p_1_aw_first),
        .p_aw_last(u_hp_p_1_aw_last),
        .p_w_valid(u_hp_p_1_w_valid),
        .p_w_id(u_hp_p_1_w_id),
        .p_w_data(u_hp_p_1_w_data),
        .p_w_strb(u_hp_p_1_w_strb),
        .p_w_ready(u_hp_p_1_w_ready),
        .p_r_valid(u_hp_p_1_r_valid),
        .p_r_ready(u_hp_p_1_r_ready),
        .p_r_data(u_hp_p_1_r_data),
        .p_r_id(u_hp_p_1_r_id),
        .p_r_tag(u_hp_p_1_r_tag),
        .p_r_last(u_hp_p_1_r_last),
        .p_b_valid(u_hp_p_1_b_valid),
        .p_b_ready(u_hp_p_1_b_ready),
        .p_b_id(u_hp_p_1_b_id),
        .p_b_tag(u_hp_p_1_b_tag),
        .p_a_valid(u_hp_p_1_a_valid),
        .p_a_id(u_hp_p_1_a_id),
        .p_a_tag(u_hp_p_1_a_tag)
    );
    NocPortSink512_1024 u_sink_2 (
        .p_ar_valid(u_hp_p_2_ar_valid),
        .p_ar_ready(u_hp_p_2_ar_ready),
        .p_ar_id(u_hp_p_2_ar_id),
        .p_ar_tag(u_hp_p_2_ar_tag),
        .p_ar_addr(u_hp_p_2_ar_addr),
        .p_ar_bytes(u_hp_p_2_ar_bytes),
        .p_ar_rows(u_hp_p_2_ar_rows),
        .p_ar_stride(u_hp_p_2_ar_stride),
        .p_ar_first(u_hp_p_2_ar_first),
        .p_ar_last(u_hp_p_2_ar_last),
        .p_aw_valid(u_hp_p_2_aw_valid),
        .p_aw_ready(u_hp_p_2_aw_ready),
        .p_aw_id(u_hp_p_2_aw_id),
        .p_aw_tag(u_hp_p_2_aw_tag),
        .p_aw_addr(u_hp_p_2_aw_addr),
        .p_aw_bytes(u_hp_p_2_aw_bytes),
        .p_aw_rows(u_hp_p_2_aw_rows),
        .p_aw_stride(u_hp_p_2_aw_stride),
        .p_aw_first(u_hp_p_2_aw_first),
        .p_aw_last(u_hp_p_2_aw_last),
        .p_w_valid(u_hp_p_2_w_valid),
        .p_w_id(u_hp_p_2_w_id),
        .p_w_data(u_hp_p_2_w_data),
        .p_w_strb(u_hp_p_2_w_strb),
        .p_w_ready(u_hp_p_2_w_ready),
        .p_r_valid(u_hp_p_2_r_valid),
        .p_r_ready(u_hp_p_2_r_ready),
        .p_r_data(u_hp_p_2_r_data),
        .p_r_id(u_hp_p_2_r_id),
        .p_r_tag(u_hp_p_2_r_tag),
        .p_r_last(u_hp_p_2_r_last),
        .p_b_valid(u_hp_p_2_b_valid),
        .p_b_ready(u_hp_p_2_b_ready),
        .p_b_id(u_hp_p_2_b_id),
        .p_b_tag(u_hp_p_2_b_tag),
        .p_a_valid(u_hp_p_2_a_valid),
        .p_a_id(u_hp_p_2_a_id),
        .p_a_tag(u_hp_p_2_a_tag)
    );
    NocPortSink u_sink_3 (
        .p_ar_valid(u_hp_p_4_ar_valid),
        .p_ar_ready(u_hp_p_4_ar_ready),
        .p_ar_id(u_hp_p_4_ar_id),
        .p_ar_tag(u_hp_p_4_ar_tag),
        .p_ar_addr(u_hp_p_4_ar_addr),
        .p_ar_bytes(u_hp_p_4_ar_bytes),
        .p_ar_rows(u_hp_p_4_ar_rows),
        .p_ar_stride(u_hp_p_4_ar_stride),
        .p_ar_first(u_hp_p_4_ar_first),
        .p_ar_last(u_hp_p_4_ar_last),
        .p_aw_valid(u_hp_p_4_aw_valid),
        .p_aw_ready(u_hp_p_4_aw_ready),
        .p_aw_id(u_hp_p_4_aw_id),
        .p_aw_tag(u_hp_p_4_aw_tag),
        .p_aw_addr(u_hp_p_4_aw_addr),
        .p_aw_bytes(u_hp_p_4_aw_bytes),
        .p_aw_rows(u_hp_p_4_aw_rows),
        .p_aw_stride(u_hp_p_4_aw_stride),
        .p_aw_first(u_hp_p_4_aw_first),
        .p_aw_last(u_hp_p_4_aw_last),
        .p_w_valid(u_hp_p_4_w_valid),
        .p_w_id(u_hp_p_4_w_id),
        .p_w_data(u_hp_p_4_w_data),
        .p_w_strb(u_hp_p_4_w_strb),
        .p_w_ready(u_hp_p_4_w_ready),
        .p_r_valid(u_hp_p_4_r_valid),
        .p_r_ready(u_hp_p_4_r_ready),
        .p_r_data(u_hp_p_4_r_data),
        .p_r_id(u_hp_p_4_r_id),
        .p_r_tag(u_hp_p_4_r_tag),
        .p_r_last(u_hp_p_4_r_last),
        .p_b_valid(u_hp_p_4_b_valid),
        .p_b_ready(u_hp_p_4_b_ready),
        .p_b_id(u_hp_p_4_b_id),
        .p_b_tag(u_hp_p_4_b_tag),
        .p_a_valid(u_hp_p_4_a_valid),
        .p_a_id(u_hp_p_4_a_id),
        .p_a_tag(u_hp_p_4_a_tag)
    );
endmodule
