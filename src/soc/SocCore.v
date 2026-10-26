module SocCore (
    input clk,
    input rst_n,
    input calib,
    input [31:0] board_st,
    input [31:0] s_awaddr,
    input s_awvalid,
    input [31:0] s_wdata,
    input [3:0] s_wstrb,
    input s_wvalid,
    input s_bready,
    input [31:0] s_araddr,
    input s_arvalid,
    input s_rready,
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
    output logic rst_ext,
    output logic stat_clr_all,
    output logic s_awready,
    output logic s_wready,
    output logic [1:0] s_bresp,
    output logic s_bvalid,
    output logic s_arready,
    output logic [31:0] s_rdata,
    output logic [1:0] s_rresp,
    output logic s_rvalid
);
    logic u_unit_rst_ext;
    logic u_unit_hs_ready;
    logic u_unit_hr_valid;
    logic [31:0] u_unit_hr_data;
    logic u_front_hs_valid;
    logic [3:0] u_front_hs_op;
    logic [31:0] u_front_hs_addr;
    logic [31:0] u_front_hs_wdata;
    logic [11:0] u_front_hs_tag;
    logic u_front_hr_ready;
    logic u_front_stat_clr_all;
    logic u_front_hc_cm_valid;
    logic u_front_hc_cm_ready;
    logic [31:0] u_front_hc_cm_addr;
    logic [31:0] u_front_hc_cm_wdata;
    logic u_front_hc_cm_write;
    logic [23:0] u_front_hc_cm_tag;
    logic u_front_hc_cr_valid;
    logic u_front_hc_cr_ready;
    logic [31:0] u_front_hc_cr_data;
    logic [23:0] u_front_hc_cr_tag;
    logic u_front_hp_wen;
    logic [5:0] u_front_hp_addr;
    logic [31:0] u_front_hp_wdata;
    logic [5:0] u_front_hp_raddr;
    logic [31:0] u_front_hp_rdata;
    logic u_front_b_we;
    logic u_front_b_re;
    logic [11:0] u_front_b_addr;
    logic [31:0] u_front_b_wdata;
    logic [31:0] u_front_b_rdata;
    logic [31:0] u_front_stat_trace0;
    logic [31:0] u_front_stat_trace1;
    logic [31:0] u_front_stat_trace2;
    logic [31:0] u_front_stat_trace3;
    logic u_front_stat_uart_valid;
    logic [7:0] u_front_stat_uart_data;
    logic [3:0] u_front_stat_cpu_state;
    logic u_front_stat_dma_busy;
    logic [7:0] u_front_stat_dma_ch_idle;
    logic [2:0] u_front_stat_dma_seq_state;
    logic [4:0] u_front_stat_dma_noc_credit;
    logic u_front_stat_v1d_busy;
    logic u_front_stat_v1d_idle;
    logic [15:0] u_front_stat_v1d_donec;
    logic [4:0] u_front_stat_v1d_occ;
    logic u_front_stat_m2d_busy;
    logic u_front_stat_m2d_idle;
    logic [15:0] u_front_stat_m2d_donec;
    logic [4:0] u_front_stat_m2d_occ;
    logic [3:0] u_front_stat_ctrl_route_target;
    logic [7:0] u_front_stat_ctrl_inflight;
    logic [3:0] u_front_stat_ctrl_slave_ready;
    logic [15:0] u_front_stat_ctrl_cfg_ack_age;
    logic [15:0] u_front_stat_l1_pend_write;
    logic [31:0] u_front_stat_l1_mismatch;
    logic [15:0] u_front_stat_l1_torn;
    logic [1:0] u_front_stat_l1_gate_block;
    logic [1:0] u_front_stat_l1_admit;
    logic [7:0] u_front_stat_l1_cfg_pend;
    logic [7:0] u_front_stat_l1_live_slots;
    logic [31:0] u_front_stat_l1_instq;
    logic [31:0] u_front_stat_l1_gateq;
    logic [31:0] u_front_stat_l1_gateq2;
    logic [1:0] u_front_stat_l1_grant;
    logic [1:0] u_front_stat_l1_stall;
    logic [7:0] u_front_stat_l1_occ0;
    logic [7:0] u_front_stat_l1_occ1;
    logic [7:0] u_front_stat_l1_occ2;
    logic [15:0] u_front_stat_noc_pend_write;
    logic u_front_stat_noc_admit;
    logic [3:0] u_front_stat_noc_port_stall;
    logic u_front_stat_noc_idle;
    logic [7:0] u_front_stat_noc_win_occ;
    logic [5:0] u_front_stat_noc_infl_occ;
    logic [5:0] u_front_stat_noc_rd_out;
    logic [5:0] u_front_stat_noc_asm_occ;
    logic [15:0] u_front_stat_noc_asm_blk;
    logic [3:0] u_front_stat_noc_lane_busy;
    logic [5:0] u_front_stat_noc_occ0;
    logic [5:0] u_front_stat_noc_occ1;
    logic [5:0] u_front_stat_noc_occ2;
    logic [5:0] u_front_stat_noc_occ3;
    logic [5:0] u_front_stat_noc_occ4;
    logic u_front_s_awready;
    logic u_front_s_wready;
    logic [1:0] u_front_s_bresp;
    logic u_front_s_bvalid;
    logic u_front_s_arready;
    logic [31:0] u_front_s_rdata;
    logic [1:0] u_front_s_rresp;
    logic u_front_s_rvalid;

    assign rst_ext = u_unit_rst_ext;
    assign stat_clr_all = u_front_stat_clr_all;
    assign s_awready = u_front_s_awready;
    assign s_wready = u_front_s_wready;
    assign s_bresp = u_front_s_bresp;
    assign s_bvalid = u_front_s_bvalid;
    assign s_arready = u_front_s_arready;
    assign s_rdata = u_front_s_rdata;
    assign s_rresp = u_front_s_rresp;
    assign s_rvalid = u_front_s_rvalid;

    SocFront u_front (
        .clk(clk),
        .board_st(board_st),
        .s_awaddr(s_awaddr),
        .s_awvalid(s_awvalid),
        .s_wdata(s_wdata),
        .s_wstrb(s_wstrb),
        .s_wvalid(s_wvalid),
        .s_bready(s_bready),
        .s_araddr(s_araddr),
        .s_arvalid(s_arvalid),
        .s_rready(s_rready),
        .rst_n(u_unit_rst_ext),
        .hs_ready(u_unit_hs_ready),
        .hr_valid(u_unit_hr_valid),
        .hr_data(u_unit_hr_data),
        .hs_valid(u_front_hs_valid),
        .hs_op(u_front_hs_op),
        .hs_addr(u_front_hs_addr),
        .hs_wdata(u_front_hs_wdata),
        .hs_tag(u_front_hs_tag),
        .hr_ready(u_front_hr_ready),
        .stat_clr_all(u_front_stat_clr_all),
        .hc_cm_valid(u_front_hc_cm_valid),
        .hc_cm_ready(u_front_hc_cm_ready),
        .hc_cm_addr(u_front_hc_cm_addr),
        .hc_cm_wdata(u_front_hc_cm_wdata),
        .hc_cm_write(u_front_hc_cm_write),
        .hc_cm_tag(u_front_hc_cm_tag),
        .hc_cr_valid(u_front_hc_cr_valid),
        .hc_cr_ready(u_front_hc_cr_ready),
        .hc_cr_data(u_front_hc_cr_data),
        .hc_cr_tag(u_front_hc_cr_tag),
        .hp_wen(u_front_hp_wen),
        .hp_addr(u_front_hp_addr),
        .hp_wdata(u_front_hp_wdata),
        .hp_raddr(u_front_hp_raddr),
        .hp_rdata(u_front_hp_rdata),
        .b_we(u_front_b_we),
        .b_re(u_front_b_re),
        .b_addr(u_front_b_addr),
        .b_wdata(u_front_b_wdata),
        .b_rdata(u_front_b_rdata),
        .stat_trace0(u_front_stat_trace0),
        .stat_trace1(u_front_stat_trace1),
        .stat_trace2(u_front_stat_trace2),
        .stat_trace3(u_front_stat_trace3),
        .stat_uart_valid(u_front_stat_uart_valid),
        .stat_uart_data(u_front_stat_uart_data),
        .stat_cpu_state(u_front_stat_cpu_state),
        .stat_dma_busy(u_front_stat_dma_busy),
        .stat_dma_ch_idle(u_front_stat_dma_ch_idle),
        .stat_dma_seq_state(u_front_stat_dma_seq_state),
        .stat_dma_noc_credit(u_front_stat_dma_noc_credit),
        .stat_v1d_busy(u_front_stat_v1d_busy),
        .stat_v1d_idle(u_front_stat_v1d_idle),
        .stat_v1d_donec(u_front_stat_v1d_donec),
        .stat_v1d_occ(u_front_stat_v1d_occ),
        .stat_m2d_busy(u_front_stat_m2d_busy),
        .stat_m2d_idle(u_front_stat_m2d_idle),
        .stat_m2d_donec(u_front_stat_m2d_donec),
        .stat_m2d_occ(u_front_stat_m2d_occ),
        .stat_ctrl_route_target(u_front_stat_ctrl_route_target),
        .stat_ctrl_inflight(u_front_stat_ctrl_inflight),
        .stat_ctrl_slave_ready(u_front_stat_ctrl_slave_ready),
        .stat_ctrl_cfg_ack_age(u_front_stat_ctrl_cfg_ack_age),
        .stat_l1_pend_write(u_front_stat_l1_pend_write),
        .stat_l1_mismatch(u_front_stat_l1_mismatch),
        .stat_l1_torn(u_front_stat_l1_torn),
        .stat_l1_gate_block(u_front_stat_l1_gate_block),
        .stat_l1_admit(u_front_stat_l1_admit),
        .stat_l1_cfg_pend(u_front_stat_l1_cfg_pend),
        .stat_l1_live_slots(u_front_stat_l1_live_slots),
        .stat_l1_instq(u_front_stat_l1_instq),
        .stat_l1_gateq(u_front_stat_l1_gateq),
        .stat_l1_gateq2(u_front_stat_l1_gateq2),
        .stat_l1_grant(u_front_stat_l1_grant),
        .stat_l1_stall(u_front_stat_l1_stall),
        .stat_l1_occ0(u_front_stat_l1_occ0),
        .stat_l1_occ1(u_front_stat_l1_occ1),
        .stat_l1_occ2(u_front_stat_l1_occ2),
        .stat_noc_pend_write(u_front_stat_noc_pend_write),
        .stat_noc_admit(u_front_stat_noc_admit),
        .stat_noc_port_stall(u_front_stat_noc_port_stall),
        .stat_noc_idle(u_front_stat_noc_idle),
        .stat_noc_win_occ(u_front_stat_noc_win_occ),
        .stat_noc_infl_occ(u_front_stat_noc_infl_occ),
        .stat_noc_rd_out(u_front_stat_noc_rd_out),
        .stat_noc_asm_occ(u_front_stat_noc_asm_occ),
        .stat_noc_asm_blk(u_front_stat_noc_asm_blk),
        .stat_noc_lane_busy(u_front_stat_noc_lane_busy),
        .stat_noc_occ0(u_front_stat_noc_occ0),
        .stat_noc_occ1(u_front_stat_noc_occ1),
        .stat_noc_occ2(u_front_stat_noc_occ2),
        .stat_noc_occ3(u_front_stat_noc_occ3),
        .stat_noc_occ4(u_front_stat_noc_occ4),
        .s_awready(u_front_s_awready),
        .s_wready(u_front_s_wready),
        .s_bresp(u_front_s_bresp),
        .s_bvalid(u_front_s_bvalid),
        .s_arready(u_front_s_arready),
        .s_rdata(u_front_s_rdata),
        .s_rresp(u_front_s_rresp),
        .s_rvalid(u_front_s_rvalid)
    );
    SocUnit u_unit (
        .clk(clk),
        .rst_n(rst_n),
        .calib(calib),
        .hs_valid(u_front_hs_valid),
        .hs_op(u_front_hs_op),
        .hs_addr(u_front_hs_addr),
        .hs_wdata(u_front_hs_wdata),
        .hs_tag(u_front_hs_tag),
        .hr_ready(u_front_hr_ready),
        .stat_clr_all(u_front_stat_clr_all),
        .hc_cm_valid(u_front_hc_cm_valid),
        .hc_cm_ready(u_front_hc_cm_ready),
        .hc_cm_addr(u_front_hc_cm_addr),
        .hc_cm_wdata(u_front_hc_cm_wdata),
        .hc_cm_write(u_front_hc_cm_write),
        .hc_cm_tag(u_front_hc_cm_tag),
        .hc_cr_valid(u_front_hc_cr_valid),
        .hc_cr_ready(u_front_hc_cr_ready),
        .hc_cr_data(u_front_hc_cr_data),
        .hc_cr_tag(u_front_hc_cr_tag),
        .hp_wen(u_front_hp_wen),
        .hp_addr(u_front_hp_addr),
        .hp_wdata(u_front_hp_wdata),
        .hp_raddr(u_front_hp_raddr),
        .hp_rdata(u_front_hp_rdata),
        .b_we(u_front_b_we),
        .b_re(u_front_b_re),
        .b_addr(u_front_b_addr),
        .b_wdata(u_front_b_wdata),
        .b_rdata(u_front_b_rdata),
        .stat_trace0(u_front_stat_trace0),
        .stat_trace1(u_front_stat_trace1),
        .stat_trace2(u_front_stat_trace2),
        .stat_trace3(u_front_stat_trace3),
        .stat_uart_valid(u_front_stat_uart_valid),
        .stat_uart_data(u_front_stat_uart_data),
        .stat_cpu_state(u_front_stat_cpu_state),
        .stat_dma_busy(u_front_stat_dma_busy),
        .stat_dma_ch_idle(u_front_stat_dma_ch_idle),
        .stat_dma_seq_state(u_front_stat_dma_seq_state),
        .stat_dma_noc_credit(u_front_stat_dma_noc_credit),
        .stat_v1d_busy(u_front_stat_v1d_busy),
        .stat_v1d_idle(u_front_stat_v1d_idle),
        .stat_v1d_donec(u_front_stat_v1d_donec),
        .stat_v1d_occ(u_front_stat_v1d_occ),
        .stat_m2d_busy(u_front_stat_m2d_busy),
        .stat_m2d_idle(u_front_stat_m2d_idle),
        .stat_m2d_donec(u_front_stat_m2d_donec),
        .stat_m2d_occ(u_front_stat_m2d_occ),
        .stat_ctrl_route_target(u_front_stat_ctrl_route_target),
        .stat_ctrl_inflight(u_front_stat_ctrl_inflight),
        .stat_ctrl_slave_ready(u_front_stat_ctrl_slave_ready),
        .stat_ctrl_cfg_ack_age(u_front_stat_ctrl_cfg_ack_age),
        .stat_l1_pend_write(u_front_stat_l1_pend_write),
        .stat_l1_mismatch(u_front_stat_l1_mismatch),
        .stat_l1_torn(u_front_stat_l1_torn),
        .stat_l1_gate_block(u_front_stat_l1_gate_block),
        .stat_l1_admit(u_front_stat_l1_admit),
        .stat_l1_cfg_pend(u_front_stat_l1_cfg_pend),
        .stat_l1_live_slots(u_front_stat_l1_live_slots),
        .stat_l1_instq(u_front_stat_l1_instq),
        .stat_l1_gateq(u_front_stat_l1_gateq),
        .stat_l1_gateq2(u_front_stat_l1_gateq2),
        .stat_l1_grant(u_front_stat_l1_grant),
        .stat_l1_stall(u_front_stat_l1_stall),
        .stat_l1_occ0(u_front_stat_l1_occ0),
        .stat_l1_occ1(u_front_stat_l1_occ1),
        .stat_l1_occ2(u_front_stat_l1_occ2),
        .stat_noc_pend_write(u_front_stat_noc_pend_write),
        .stat_noc_admit(u_front_stat_noc_admit),
        .stat_noc_port_stall(u_front_stat_noc_port_stall),
        .stat_noc_idle(u_front_stat_noc_idle),
        .stat_noc_win_occ(u_front_stat_noc_win_occ),
        .stat_noc_infl_occ(u_front_stat_noc_infl_occ),
        .stat_noc_rd_out(u_front_stat_noc_rd_out),
        .stat_noc_asm_occ(u_front_stat_noc_asm_occ),
        .stat_noc_asm_blk(u_front_stat_noc_asm_blk),
        .stat_noc_lane_busy(u_front_stat_noc_lane_busy),
        .stat_noc_occ0(u_front_stat_noc_occ0),
        .stat_noc_occ1(u_front_stat_noc_occ1),
        .stat_noc_occ2(u_front_stat_noc_occ2),
        .stat_noc_occ3(u_front_stat_noc_occ3),
        .stat_noc_occ4(u_front_stat_noc_occ4),
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
        .rst_ext(u_unit_rst_ext),
        .hs_ready(u_unit_hs_ready),
        .hr_valid(u_unit_hr_valid),
        .hr_data(u_unit_hr_data)
    );
endmodule
