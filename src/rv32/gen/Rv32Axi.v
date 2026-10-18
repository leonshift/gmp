module Rv32Axi #(
    parameter PREDICT = 2,
    parameter PERF = 0
) (
    input clk,
    input rst_n,
    input [31:0] clock_measurement,
    input [31:0] s_awaddr,
    input s_awvalid,
    input [31:0] s_wdata,
    input [3:0] s_wstrb,
    input s_wvalid,
    input s_bready,
    input [31:0] s_araddr,
    input s_arvalid,
    input s_rready,
    output logic s_awready,
    output logic s_wready,
    output logic s_arready,
    output logic s_bvalid,
    output logic [1:0] s_bresp,
    output logic s_rvalid,
    output logic [1:0] s_rresp,
    output logic [31:0] s_rdata,
    output logic halted,
    output logic fault
);
    logic aw_pending;
    logic [31:0] aw_addr;
    logic w_pending;
    logic [31:0] w_data;
    logic [3:0] w_strb;
    logic active;
    logic active_write;
    logic bvalid;
    logic [1:0] bresp;
    logic rvalid;
    logic [1:0] rresp;
    logic [31:0] rdata;
    logic idle;
    logic writing;
    logic request;
    logic u_soc_h_ready;
    logic u_soc_halt_o;
    logic [3:0] u_soc_cause_o;
    logic u_soc_h_rvalid;
    logic u_soc_h_error;
    logic [31:0] u_soc_h_rdata;

    assign idle = (((~active) & (~bvalid)) & (~rvalid));
    assign writing = (aw_pending & w_pending);
    assign request = (idle & (writing | ((s_arvalid & (~aw_pending)) & (~w_pending))));
    assign s_awready = (idle & (~aw_pending));
    assign s_wready = (idle & (~w_pending));
    assign s_arready = (((idle & (~aw_pending)) & (~w_pending)) & u_soc_h_ready);
    assign s_bvalid = bvalid;
    assign s_bresp = bresp;
    assign s_rvalid = rvalid;
    assign s_rresp = rresp;
    assign s_rdata = rdata;
    assign halted = u_soc_halt_o;
    assign fault = (u_soc_halt_o & (u_soc_cause_o != 3));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            aw_pending <= 0;
            aw_addr <= 0;
            w_pending <= 0;
            w_data <= 0;
            w_strb <= 0;
            active <= 0;
            active_write <= 0;
            bvalid <= 0;
            bresp <= 0;
            rvalid <= 0;
            rresp <= 0;
            rdata <= 0;
        end else begin
            if ((s_awvalid & s_awready)) begin
                aw_pending <= 1;
                aw_addr <= s_awaddr;
            end
            if ((s_wvalid & s_wready)) begin
                w_pending <= 1;
                w_data <= s_wdata;
                w_strb <= s_wstrb;
            end
            if ((request & u_soc_h_ready)) begin
                active <= 1;
                active_write <= writing;
                if (writing) begin
                    aw_pending <= 0;
                    w_pending <= 0;
                end
            end
            if ((active & u_soc_h_rvalid)) begin
                active <= 0;
                if (active_write) begin
                    bvalid <= 1;
                    bresp <= (u_soc_h_error ? 2'd2 : 2'd0);
                end else begin
                    rvalid <= 1;
                    rresp <= (u_soc_h_error ? 2'd2 : 2'd0);
                    rdata <= u_soc_h_rdata;
                end
            end
            if ((bvalid & s_bready)) begin
                bvalid <= 0;
            end
            if ((rvalid & s_rready)) begin
                rvalid <= 0;
            end
        end
    end

    Rv32Soc #(.PREDICT(PREDICT), .TRACE(0), .PERF(PERF)) u_soc (
        .clk(clk),
        .rst_n(rst_n),
        .clock_measurement(clock_measurement),
        .h_valid(request),
        .h_write(writing),
        .h_addr((writing ? aw_addr : s_araddr)),
        .h_data(w_data),
        .h_strb(w_strb),
        .h_rready(active),
        .h_ready(u_soc_h_ready),
        .halt_o(u_soc_halt_o),
        .cause_o(u_soc_cause_o),
        .h_rvalid(u_soc_h_rvalid),
        .h_error(u_soc_h_error),
        .h_rdata(u_soc_h_rdata)
    );
endmodule
