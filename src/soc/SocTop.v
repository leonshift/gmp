module SocTop (
    input clk,
    input rst_n,
    input mclk0,
    input mrst_n0,
    input mclk1,
    input mrst_n1,
    input calib,
    input [7:0] ecc_err0,
    input [7:0] ecc_err1,
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
    output logic [30:0] m_0_ar_addr,
    output logic [7:0] m_0_ar_len,
    output logic m_0_aw_valid,
    input m_0_aw_ready,
    output logic [7:0] m_0_aw_id,
    output logic [30:0] m_0_aw_addr,
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
    output logic [30:0] m_1_ar_addr,
    output logic [7:0] m_1_ar_len,
    output logic m_1_aw_valid,
    input m_1_aw_ready,
    output logic [7:0] m_1_aw_id,
    output logic [30:0] m_1_aw_addr,
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
    output logic s_awready,
    output logic s_wready,
    output logic [1:0] s_bresp,
    output logic s_bvalid,
    output logic s_arready,
    output logic [31:0] s_rdata,
    output logic [1:0] s_rresp,
    output logic s_rvalid
);
    logic [31:0] board_st;
    logic u_core_rst_ext;
    logic u_core_m_0_ar_valid;
    logic u_core_m_0_ar_ready;
    logic [7:0] u_core_m_0_ar_id;
    logic [47:0] u_core_m_0_ar_addr;
    logic [7:0] u_core_m_0_ar_len;
    logic u_core_m_0_aw_valid;
    logic u_core_m_0_aw_ready;
    logic [7:0] u_core_m_0_aw_id;
    logic [47:0] u_core_m_0_aw_addr;
    logic [7:0] u_core_m_0_aw_len;
    logic u_core_m_0_w_valid;
    logic u_core_m_0_w_ready;
    logic [511:0] u_core_m_0_w_data;
    logic [63:0] u_core_m_0_w_strb;
    logic u_core_m_0_w_last;
    logic u_core_m_0_b_valid;
    logic u_core_m_0_b_ready;
    logic [7:0] u_core_m_0_b_id;
    logic u_core_m_0_r_valid;
    logic u_core_m_0_r_ready;
    logic [7:0] u_core_m_0_r_id;
    logic [511:0] u_core_m_0_r_data;
    logic u_core_m_0_r_last;
    logic u_core_m_1_ar_valid;
    logic u_core_m_1_ar_ready;
    logic [7:0] u_core_m_1_ar_id;
    logic [47:0] u_core_m_1_ar_addr;
    logic [7:0] u_core_m_1_ar_len;
    logic u_core_m_1_aw_valid;
    logic u_core_m_1_aw_ready;
    logic [7:0] u_core_m_1_aw_id;
    logic [47:0] u_core_m_1_aw_addr;
    logic [7:0] u_core_m_1_aw_len;
    logic u_core_m_1_w_valid;
    logic u_core_m_1_w_ready;
    logic [511:0] u_core_m_1_w_data;
    logic [63:0] u_core_m_1_w_strb;
    logic u_core_m_1_w_last;
    logic u_core_m_1_b_valid;
    logic u_core_m_1_b_ready;
    logic [7:0] u_core_m_1_b_id;
    logic u_core_m_1_r_valid;
    logic u_core_m_1_r_ready;
    logic [7:0] u_core_m_1_r_id;
    logic [511:0] u_core_m_1_r_data;
    logic u_core_m_1_r_last;
    logic u_ecc_t_0_tog;
    logic u_core_stat_clr_all;
    logic u_ecc_t_1_tog;
    logic [7:0] u_ecc_c_1_cnt;
    logic [7:0] u_ecc_c_0_cnt;
    logic u_core_s_awready;
    logic u_core_s_wready;
    logic [1:0] u_core_s_bresp;
    logic u_core_s_bvalid;
    logic u_core_s_arready;
    logic [31:0] u_core_s_rdata;
    logic [1:0] u_core_s_rresp;
    logic u_core_s_rvalid;

    assign board_st = {8'd0, u_ecc_c_1_cnt, u_ecc_c_0_cnt, 7'd0, calib};
    assign s_awready = u_core_s_awready;
    assign s_wready = u_core_s_wready;
    assign s_bresp = u_core_s_bresp;
    assign s_bvalid = u_core_s_bvalid;
    assign s_arready = u_core_s_arready;
    assign s_rdata = u_core_s_rdata;
    assign s_rresp = u_core_s_rresp;
    assign s_rvalid = u_core_s_rvalid;

    SocCore u_core (
        .clk(clk),
        .rst_n(rst_n),
        .calib(calib),
        .s_awaddr(s_awaddr),
        .s_awvalid(s_awvalid),
        .s_wdata(s_wdata),
        .s_wstrb(s_wstrb),
        .s_wvalid(s_wvalid),
        .s_bready(s_bready),
        .s_araddr(s_araddr),
        .s_arvalid(s_arvalid),
        .s_rready(s_rready),
        .board_st(board_st),
        .rst_ext(u_core_rst_ext),
        .m_0_ar_valid(u_core_m_0_ar_valid),
        .m_0_ar_ready(u_core_m_0_ar_ready),
        .m_0_ar_id(u_core_m_0_ar_id),
        .m_0_ar_addr(u_core_m_0_ar_addr),
        .m_0_ar_len(u_core_m_0_ar_len),
        .m_0_aw_valid(u_core_m_0_aw_valid),
        .m_0_aw_ready(u_core_m_0_aw_ready),
        .m_0_aw_id(u_core_m_0_aw_id),
        .m_0_aw_addr(u_core_m_0_aw_addr),
        .m_0_aw_len(u_core_m_0_aw_len),
        .m_0_w_valid(u_core_m_0_w_valid),
        .m_0_w_ready(u_core_m_0_w_ready),
        .m_0_w_data(u_core_m_0_w_data),
        .m_0_w_strb(u_core_m_0_w_strb),
        .m_0_w_last(u_core_m_0_w_last),
        .m_0_b_valid(u_core_m_0_b_valid),
        .m_0_b_ready(u_core_m_0_b_ready),
        .m_0_b_id(u_core_m_0_b_id),
        .m_0_r_valid(u_core_m_0_r_valid),
        .m_0_r_ready(u_core_m_0_r_ready),
        .m_0_r_id(u_core_m_0_r_id),
        .m_0_r_data(u_core_m_0_r_data),
        .m_0_r_last(u_core_m_0_r_last),
        .m_1_ar_valid(u_core_m_1_ar_valid),
        .m_1_ar_ready(u_core_m_1_ar_ready),
        .m_1_ar_id(u_core_m_1_ar_id),
        .m_1_ar_addr(u_core_m_1_ar_addr),
        .m_1_ar_len(u_core_m_1_ar_len),
        .m_1_aw_valid(u_core_m_1_aw_valid),
        .m_1_aw_ready(u_core_m_1_aw_ready),
        .m_1_aw_id(u_core_m_1_aw_id),
        .m_1_aw_addr(u_core_m_1_aw_addr),
        .m_1_aw_len(u_core_m_1_aw_len),
        .m_1_w_valid(u_core_m_1_w_valid),
        .m_1_w_ready(u_core_m_1_w_ready),
        .m_1_w_data(u_core_m_1_w_data),
        .m_1_w_strb(u_core_m_1_w_strb),
        .m_1_w_last(u_core_m_1_w_last),
        .m_1_b_valid(u_core_m_1_b_valid),
        .m_1_b_ready(u_core_m_1_b_ready),
        .m_1_b_id(u_core_m_1_b_id),
        .m_1_r_valid(u_core_m_1_r_valid),
        .m_1_r_ready(u_core_m_1_r_ready),
        .m_1_r_id(u_core_m_1_r_id),
        .m_1_r_data(u_core_m_1_r_data),
        .m_1_r_last(u_core_m_1_r_last),
        .stat_clr_all(u_core_stat_clr_all),
        .s_awready(u_core_s_awready),
        .s_wready(u_core_s_wready),
        .s_bresp(u_core_s_bresp),
        .s_bvalid(u_core_s_bvalid),
        .s_arready(u_core_s_arready),
        .s_rdata(u_core_s_rdata),
        .s_rresp(u_core_s_rresp),
        .s_rvalid(u_core_s_rvalid)
    );
    DdrDualCh u_dram (
        .clk(clk),
        .rst_n(u_core_rst_ext),
        .mclk0(mclk0),
        .mrst_n0(mrst_n0),
        .mclk1(mclk1),
        .mrst_n1(mrst_n1),
        .s_0_ar_valid(u_core_m_0_ar_valid),
        .s_0_ar_ready(u_core_m_0_ar_ready),
        .s_0_ar_id(u_core_m_0_ar_id),
        .s_0_ar_addr(u_core_m_0_ar_addr),
        .s_0_ar_len(u_core_m_0_ar_len),
        .s_0_aw_valid(u_core_m_0_aw_valid),
        .s_0_aw_ready(u_core_m_0_aw_ready),
        .s_0_aw_id(u_core_m_0_aw_id),
        .s_0_aw_addr(u_core_m_0_aw_addr),
        .s_0_aw_len(u_core_m_0_aw_len),
        .s_0_w_valid(u_core_m_0_w_valid),
        .s_0_w_ready(u_core_m_0_w_ready),
        .s_0_w_data(u_core_m_0_w_data),
        .s_0_w_strb(u_core_m_0_w_strb),
        .s_0_w_last(u_core_m_0_w_last),
        .s_0_b_valid(u_core_m_0_b_valid),
        .s_0_b_ready(u_core_m_0_b_ready),
        .s_0_b_id(u_core_m_0_b_id),
        .s_0_r_valid(u_core_m_0_r_valid),
        .s_0_r_ready(u_core_m_0_r_ready),
        .s_0_r_id(u_core_m_0_r_id),
        .s_0_r_data(u_core_m_0_r_data),
        .s_0_r_last(u_core_m_0_r_last),
        .s_1_ar_valid(u_core_m_1_ar_valid),
        .s_1_ar_ready(u_core_m_1_ar_ready),
        .s_1_ar_id(u_core_m_1_ar_id),
        .s_1_ar_addr(u_core_m_1_ar_addr),
        .s_1_ar_len(u_core_m_1_ar_len),
        .s_1_aw_valid(u_core_m_1_aw_valid),
        .s_1_aw_ready(u_core_m_1_aw_ready),
        .s_1_aw_id(u_core_m_1_aw_id),
        .s_1_aw_addr(u_core_m_1_aw_addr),
        .s_1_aw_len(u_core_m_1_aw_len),
        .s_1_w_valid(u_core_m_1_w_valid),
        .s_1_w_ready(u_core_m_1_w_ready),
        .s_1_w_data(u_core_m_1_w_data),
        .s_1_w_strb(u_core_m_1_w_strb),
        .s_1_w_last(u_core_m_1_w_last),
        .s_1_b_valid(u_core_m_1_b_valid),
        .s_1_b_ready(u_core_m_1_b_ready),
        .s_1_b_id(u_core_m_1_b_id),
        .s_1_r_valid(u_core_m_1_r_valid),
        .s_1_r_ready(u_core_m_1_r_ready),
        .s_1_r_id(u_core_m_1_r_id),
        .s_1_r_data(u_core_m_1_r_data),
        .s_1_r_last(u_core_m_1_r_last),
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
        .m_1_r_last(m_1_r_last)
    );
    EccToggle u_ecc_t_0 (
        .clk(mclk0),
        .rst_n(mrst_n0),
        .err(ecc_err0),
        .tog(u_ecc_t_0_tog)
    );
    EccToggle u_ecc_t_1 (
        .clk(mclk1),
        .rst_n(mrst_n1),
        .err(ecc_err1),
        .tog(u_ecc_t_1_tog)
    );
    EccCount u_ecc_c_0 (
        .clk(clk),
        .rst_n(u_core_rst_ext),
        .tog(u_ecc_t_0_tog),
        .clr(u_core_stat_clr_all),
        .cnt(u_ecc_c_0_cnt)
    );
    EccCount u_ecc_c_1 (
        .clk(clk),
        .rst_n(u_core_rst_ext),
        .tog(u_ecc_t_1_tog),
        .clr(u_core_stat_clr_all),
        .cnt(u_ecc_c_1_cnt)
    );
endmodule
