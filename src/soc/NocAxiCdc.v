module NocAxiCdc (
    input clk,
    input rst_n,
    input mclk,
    input mrst_n,
    input s_ar_valid,
    output logic s_ar_ready,
    input [7:0] s_ar_id,
    input [30:0] s_ar_addr,
    input [7:0] s_ar_len,
    input s_aw_valid,
    output logic s_aw_ready,
    input [7:0] s_aw_id,
    input [30:0] s_aw_addr,
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
    logic [46:0] aw_pack;
    logic aw_wen;
    logic aw_ren;
    logic [576:0] w_pack;
    logic w_wen;
    logic w_ren;
    logic [46:0] ar_pack;
    logic ar_wen;
    logic ar_ren;
    logic b_wen;
    logic b_ren;
    logic [520:0] r_pack;
    logic r_wen;
    logic r_ren;
    logic u_aw_wfull;
    logic u_aw_rempty;
    logic [46:0] u_aw_rdata;
    logic u_w_wfull;
    logic u_w_rempty;
    logic [576:0] u_w_rdata;
    logic u_ar_wfull;
    logic u_ar_rempty;
    logic [46:0] u_ar_rdata;
    logic u_b_wfull;
    logic u_b_rempty;
    logic [7:0] u_b_rdata;
    logic u_r_wfull;
    logic u_r_rempty;
    logic [520:0] u_r_rdata;

    assign aw_pack = {s_aw_id, s_aw_len, s_aw_addr};
    assign s_aw_ready = (~u_aw_wfull);
    assign aw_wen = (s_aw_valid & (~u_aw_wfull));
    assign m_aw_valid = (~u_aw_rempty);
    assign aw_ren = (m_aw_ready & (~u_aw_rempty));
    assign m_aw_addr = u_aw_rdata[30:0];
    assign m_aw_len = u_aw_rdata[38:31];
    assign m_aw_id = u_aw_rdata[46:39];
    assign w_pack = {s_w_last, s_w_strb, s_w_data};
    assign s_w_ready = (~u_w_wfull);
    assign w_wen = (s_w_valid & (~u_w_wfull));
    assign m_w_valid = (~u_w_rempty);
    assign w_ren = (m_w_ready & (~u_w_rempty));
    assign m_w_data = u_w_rdata[511:0];
    assign m_w_strb = u_w_rdata[575:512];
    assign m_w_last = u_w_rdata[576];
    assign ar_pack = {s_ar_id, s_ar_len, s_ar_addr};
    assign s_ar_ready = (~u_ar_wfull);
    assign ar_wen = (s_ar_valid & (~u_ar_wfull));
    assign m_ar_valid = (~u_ar_rempty);
    assign ar_ren = (m_ar_ready & (~u_ar_rempty));
    assign m_ar_addr = u_ar_rdata[30:0];
    assign m_ar_len = u_ar_rdata[38:31];
    assign m_ar_id = u_ar_rdata[46:39];
    assign m_b_ready = (~u_b_wfull);
    assign b_wen = (m_b_valid & (~u_b_wfull));
    assign s_b_valid = (~u_b_rempty);
    assign b_ren = (s_b_ready & (~u_b_rempty));
    assign s_b_id = u_b_rdata;
    assign r_pack = {m_r_id, m_r_last, m_r_data};
    assign m_r_ready = (~u_r_wfull);
    assign r_wen = (m_r_valid & (~u_r_wfull));
    assign s_r_valid = (~u_r_rempty);
    assign r_ren = (s_r_ready & (~u_r_rempty));
    assign s_r_data = u_r_rdata[511:0];
    assign s_r_last = u_r_rdata[512];
    assign s_r_id = u_r_rdata[520:513];

    NocAfifo47 u_aw (
        .clk(clk),
        .rst_n(rst_n),
        .rclk(mclk),
        .rrst_n(mrst_n),
        .wen(aw_wen),
        .wdata(aw_pack),
        .ren(aw_ren),
        .wfull(u_aw_wfull),
        .rempty(u_aw_rempty),
        .rdata(u_aw_rdata)
    );
    NocAfifoWs577 u_w (
        .clk(clk),
        .rst_n(rst_n),
        .rclk(mclk),
        .rrst_n(mrst_n),
        .wen(w_wen),
        .wdata(w_pack),
        .ren(w_ren),
        .wfull(u_w_wfull),
        .rempty(u_w_rempty),
        .rdata(u_w_rdata)
    );
    NocAfifo47 u_ar (
        .clk(clk),
        .rst_n(rst_n),
        .rclk(mclk),
        .rrst_n(mrst_n),
        .wen(ar_wen),
        .wdata(ar_pack),
        .ren(ar_ren),
        .wfull(u_ar_wfull),
        .rempty(u_ar_rempty),
        .rdata(u_ar_rdata)
    );
    NocAfifo8 u_b (
        .clk(mclk),
        .rst_n(mrst_n),
        .rclk(clk),
        .rrst_n(rst_n),
        .wen(b_wen),
        .wdata(m_b_id),
        .ren(b_ren),
        .wfull(u_b_wfull),
        .rempty(u_b_rempty),
        .rdata(u_b_rdata)
    );
    NocAfifo521 u_r (
        .clk(mclk),
        .rst_n(mrst_n),
        .rclk(clk),
        .rrst_n(rst_n),
        .wen(r_wen),
        .wdata(r_pack),
        .ren(r_ren),
        .wfull(u_r_wfull),
        .rempty(u_r_rempty),
        .rdata(u_r_rdata)
    );
endmodule
