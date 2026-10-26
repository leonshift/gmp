module RlinkAxiHost (
    input uclk,
    input urst_n,
    input clk,
    input rst_n,
    input [7:0] rx_tdata,
    input rx_tvalid,
    input rx_tlast,
    input tx_tready,
    input m_awready,
    input m_wready,
    input [1:0] m_bresp,
    input m_bvalid,
    input m_arready,
    input [31:0] m_rdata,
    input [1:0] m_rresp,
    input m_rvalid,
    output logic rx_tready,
    output logic [7:0] tx_tdata,
    output logic tx_tvalid,
    output logic tx_tlast,
    output logic [31:0] m_awaddr,
    output logic m_awvalid,
    output logic [31:0] m_wdata,
    output logic [3:0] m_wstrb,
    output logic m_wvalid,
    output logic m_bready,
    output logic [31:0] m_araddr,
    output logic m_arvalid,
    output logic m_rready
);
    logic u_pack_wen;
    logic [32:0] u_pack_wdata;
    logic u_br_rx_pop;
    logic u_rxf_room;
    logic u_unpack_ren;
    logic u_br_tx_wen;
    logic [32:0] u_br_tx_wdata;
    logic u_txf_rvalid;
    logic [32:0] u_txf_rdata;
    logic u_rxf_rvalid;
    logic [32:0] u_rxf_rdata;
    logic u_txf_room;
    logic u_pack_app_tready;
    logic [7:0] u_unpack_app_tdata;
    logic u_unpack_app_tvalid;
    logic u_unpack_app_tlast;
    logic [31:0] u_br_m_awaddr;
    logic u_br_m_awvalid;
    logic [31:0] u_br_m_wdata;
    logic [3:0] u_br_m_wstrb;
    logic u_br_m_wvalid;
    logic u_br_m_bready;
    logic [31:0] u_br_m_araddr;
    logic u_br_m_arvalid;
    logic u_br_m_rready;

    assign rx_tready = u_pack_app_tready;
    assign tx_tdata = u_unpack_app_tdata;
    assign tx_tvalid = u_unpack_app_tvalid;
    assign tx_tlast = u_unpack_app_tlast;
    assign m_awaddr = u_br_m_awaddr;
    assign m_awvalid = u_br_m_awvalid;
    assign m_wdata = u_br_m_wdata;
    assign m_wstrb = u_br_m_wstrb;
    assign m_wvalid = u_br_m_wvalid;
    assign m_bready = u_br_m_bready;
    assign m_araddr = u_br_m_araddr;
    assign m_arvalid = u_br_m_arvalid;
    assign m_rready = u_br_m_rready;

    RlinkWordFifo u_rxf (
        .clk(uclk),
        .rst_n(urst_n),
        .rclk(clk),
        .rrst_n(rst_n),
        .wen(u_pack_wen),
        .wdata(u_pack_wdata),
        .ren(u_br_rx_pop),
        .room(u_rxf_room),
        .rvalid(u_rxf_rvalid),
        .rdata(u_rxf_rdata)
    );
    RlinkPack u_pack (
        .clk(uclk),
        .rst_n(urst_n),
        .app_tdata(rx_tdata),
        .app_tvalid(rx_tvalid),
        .app_tlast(rx_tlast),
        .room(u_rxf_room),
        .wen(u_pack_wen),
        .wdata(u_pack_wdata),
        .app_tready(u_pack_app_tready)
    );
    RlinkWordFifo u_txf (
        .clk(clk),
        .rst_n(rst_n),
        .rclk(uclk),
        .rrst_n(urst_n),
        .ren(u_unpack_ren),
        .wen(u_br_tx_wen),
        .wdata(u_br_tx_wdata),
        .rvalid(u_txf_rvalid),
        .rdata(u_txf_rdata),
        .room(u_txf_room)
    );
    RlinkUnpack u_unpack (
        .clk(uclk),
        .rst_n(urst_n),
        .rvalid(u_txf_rvalid),
        .rdata(u_txf_rdata),
        .app_tready(tx_tready),
        .ren(u_unpack_ren),
        .app_tdata(u_unpack_app_tdata),
        .app_tvalid(u_unpack_app_tvalid),
        .app_tlast(u_unpack_app_tlast)
    );
    RlinkAxiBridge u_br (
        .clk(clk),
        .rst_n(rst_n),
        .rx_valid(u_rxf_rvalid),
        .rx_data(u_rxf_rdata),
        .tx_room(u_txf_room),
        .m_awready(m_awready),
        .m_wready(m_wready),
        .m_bresp(m_bresp),
        .m_bvalid(m_bvalid),
        .m_arready(m_arready),
        .m_rdata(m_rdata),
        .m_rresp(m_rresp),
        .m_rvalid(m_rvalid),
        .rx_pop(u_br_rx_pop),
        .tx_wen(u_br_tx_wen),
        .tx_wdata(u_br_tx_wdata),
        .m_awaddr(u_br_m_awaddr),
        .m_awvalid(u_br_m_awvalid),
        .m_wdata(u_br_m_wdata),
        .m_wstrb(u_br_m_wstrb),
        .m_wvalid(u_br_m_wvalid),
        .m_bready(u_br_m_bready),
        .m_araddr(u_br_m_araddr),
        .m_arvalid(u_br_m_arvalid),
        .m_rready(u_br_m_rready)
    );
endmodule
