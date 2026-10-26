module G1Cpu (
    input clk,
    input rst_n,
    input hs_valid,
    input [3:0] hs_op,
    input [31:0] hs_addr,
    input [31:0] hs_wdata,
    input [11:0] hs_tag,
    input hr_ready,
    output logic ctrl_cm_valid,
    input ctrl_cm_ready,
    output logic [31:0] ctrl_cm_addr,
    output logic [31:0] ctrl_cm_wdata,
    output logic ctrl_cm_write,
    output logic [23:0] ctrl_cm_tag,
    input ctrl_cr_valid,
    output logic ctrl_cr_ready,
    input [31:0] ctrl_cr_data,
    input [23:0] ctrl_cr_tag,
    input dm_ready,
    input da_valid,
    input dr_valid,
    input [31:0] dr_data,
    output logic hs_ready,
    output logic hr_valid,
    output logic [31:0] hr_data,
    output logic [11:0] hr_tag,
    output logic [7:0] uart_tx_data,
    output logic uart_tx_valid,
    output logic [31:0] trace0,
    output logic [31:0] trace1,
    output logic [31:0] trace2,
    output logic [31:0] trace3,
    output logic [3:0] dbg_state,
    output logic dm_valid,
    output logic [31:0] dm_addr,
    output logic [15:0] dm_nbytes,
    output logic dm_write
);
    logic fetch_rom;
    logic [31:0] if_inst_w;
    logic core_rst_n;
    logic csr_sel_cdma;
    logic [31:0] core_csr_rdata;
    logic ext_busy_q;
    logic mem_gate;
    logic h_in_rom;
    logic h_in_dlm;
    logic h_in_ilm;
    logic h_rom_r;
    logic h_ilm_r;
    logic h_dlm_r;
    logic h_ilm_w;
    logic h_dlm_w;
    logic lm_grant_w;
    logic [31:0] lm_rdata_w;
    logic [9:0] rom_raddr_w;
    logic [13:0] ilm_raddr_w;
    logic ilm_we_w;
    logic [13:0] ilm_waddr_w;
    logic [31:0] ilm_wdata_w;
    logic ext_rgrant;
    logic [11:0] dlm_raddr_w;
    logic ext_wgrant;
    logic dlm_we_w;
    logic [11:0] dlm_waddr_w;
    logic [3:0] dlm_wbe_w;
    logic [31:0] dlm_wdata_w;
    logic uart_q_v;
    logic [7:0] uart_q_d;
    logic [17:0] u_rom_prediction;
    logic [17:0] u_ilm_prediction;
    logic [31:0] u_dlm_rdata;
    logic [3:0] u_dlm_zero_bytes;
    logic u_dlm_pointer_local;
    logic u_ext_ext_rd_ok;
    logic u_ext_ext_dat_ok;
    logic u_ext_ext_q_full;
    logic [31:0] u_ext_ext_rdata;
    logic [13:0] u_host_lm_addr;
    logic u_csr_dbg_stop;
    logic u_csr_dbg_step;
    logic u_host_pc_wen;
    logic u_host_x_wen;
    logic [4:0] u_host_x_idx;
    logic [31:0] u_host_dbg_wdata;
    logic u_core_if_read;
    logic [17:0] u_core_predict_write;
    logic [3:0] u_core_zero_write;
    logic u_core_local_tag_write;
    logic [11:0] u_core_csr_paddr;
    logic [4:0] u_core_csr_pgi_a;
    logic [4:0] u_core_csr_pgi_b;
    logic u_core_csr_en;
    logic u_core_csr_wen;
    logic [11:0] u_core_csr_addr;
    logic [31:0] u_core_csr_wdata;
    logic [31:0] u_core_csr_wo;
    logic u_host_csr_wen;
    logic [11:0] u_host_csr_addr;
    logic u_host_csr_gp;
    logic [4:0] u_host_csr_gi;
    logic [31:0] u_host_csr_wdata;
    logic u_core_halt_o;
    logic u_core_quiet;
    logic u_core_retire;
    logic u_core_ext_wq;
    logic u_core_ext_w2;
    logic u_core_ext_w3;
    logic [2:0] u_core_ext_kind;
    logic [31:0] u_core_ext_addr;
    logic [31:0] u_core_ext_wdata;
    logic u_host_hq_valid;
    logic [2:0] u_host_hq_kind;
    logic [31:0] u_host_hq_data;
    logic [31:0] u_csr_h_rdata;
    logic u_ext_hq_ready;
    logic u_ext_busy_o;
    logic [31:0] u_core_if_pc;
    logic [31:0] u_core_dbg_x_rdata;
    logic u_csr_dbg_stopped;
    logic u_core_if_rom;
    logic [31:0] u_rom_rdata;
    logic [31:0] u_ilm_rdata;
    logic u_csr_go;
    logic [31:0] u_ext_csr_rdata;
    logic [31:0] u_csr_c_rdata;
    logic u_host_lm_rom;
    logic u_host_lm_dlm;
    logic u_host_lm_ilm;
    logic u_host_lm_re;
    logic u_host_lm_we;
    logic [31:0] u_ilm_host_rdata;
    logic [9:0] u_core_if_raddr;
    logic [13:0] u_core_if_iaddr;
    logic u_ext_ilm_we;
    logic [13:0] u_ext_ilm_waddr;
    logic [31:0] u_ext_ilm_wdata;
    logic [31:0] u_host_lm_wdata;
    logic u_ext_dlm_rreq;
    logic u_core_dlm_re;
    logic [11:0] u_core_dlm_raddr;
    logic [11:0] u_ext_dlm_raddr;
    logic u_ext_dlm_wreq;
    logic u_core_dlm_wclaim;
    logic u_core_dlm_we;
    logic [11:0] u_core_dlm_waddr;
    logic [11:0] u_ext_dlm_waddr;
    logic [3:0] u_core_dlm_wbe;
    logic [31:0] u_core_dlm_wdata;
    logic [31:0] u_ext_dlm_wdata;
    logic u_host_hs_ready;
    logic u_host_hr_valid;
    logic [31:0] u_host_hr_data;
    logic [11:0] u_host_hr_tag;
    logic [31:0] u_csr_trace0;
    logic [31:0] u_csr_trace1;
    logic [31:0] u_csr_trace2;
    logic [31:0] u_csr_trace3;
    logic u_ext_cm_valid;
    logic [31:0] u_ext_cm_addr;
    logic [31:0] u_ext_cm_wdata;
    logic u_ext_cm_write;
    logic [23:0] u_ext_cm_tag;
    logic u_ext_dm_valid;
    logic [31:0] u_ext_dm_addr;
    logic [15:0] u_ext_dm_nbytes;
    logic u_ext_dm_write;
    logic u_csr_uart_tx_valid;
    logic [7:0] u_csr_uart_tx_data;

    assign ctrl_cr_ready = 1'd1;
    assign fetch_rom = u_core_if_rom;
    assign if_inst_w = (fetch_rom ? u_rom_rdata : u_ilm_rdata);
    assign core_rst_n = (rst_n & u_csr_go);
    assign csr_sel_cdma = (u_core_csr_addr[11:6] == 47);
    assign core_csr_rdata = (csr_sel_cdma ? u_ext_csr_rdata : u_csr_c_rdata);
    assign mem_gate = (((~u_csr_go) | u_core_quiet) & (~ext_busy_q));
    assign h_in_rom = u_host_lm_rom;
    assign h_in_dlm = u_host_lm_dlm;
    assign h_in_ilm = u_host_lm_ilm;
    assign h_rom_r = ((u_host_lm_re & h_in_rom) & mem_gate);
    assign h_ilm_r = ((u_host_lm_re & h_in_ilm) & mem_gate);
    assign h_dlm_r = ((u_host_lm_re & h_in_dlm) & mem_gate);
    assign h_ilm_w = ((u_host_lm_we & h_in_ilm) & mem_gate);
    assign h_dlm_w = ((u_host_lm_we & h_in_dlm) & mem_gate);
    assign lm_grant_w = ((((h_rom_r | h_ilm_r) | h_dlm_r) | h_ilm_w) | h_dlm_w);
    assign lm_rdata_w = (h_in_rom ? u_rom_rdata : (h_in_ilm ? u_ilm_host_rdata : u_dlm_rdata));
    assign rom_raddr_w = u_core_if_raddr;
    assign ilm_raddr_w = u_core_if_iaddr;
    assign ilm_we_w = (u_ext_ilm_we | h_ilm_w);
    assign ilm_waddr_w = (h_ilm_r ? u_host_lm_addr : (u_ext_ilm_we ? u_ext_ilm_waddr : u_host_lm_addr));
    assign ilm_wdata_w = (u_ext_ilm_we ? u_ext_ilm_wdata : u_host_lm_wdata);
    assign ext_rgrant = (u_ext_dlm_rreq & (~u_core_dlm_re));
    assign dlm_raddr_w = (u_core_dlm_re ? u_core_dlm_raddr : (u_ext_dlm_rreq ? u_ext_dlm_raddr : u_host_lm_addr[11:0]));
    assign ext_wgrant = (u_ext_dlm_wreq & (~u_core_dlm_wclaim));
    assign dlm_we_w = ((u_core_dlm_we | ext_wgrant) | h_dlm_w);
    assign dlm_waddr_w = (u_core_dlm_wclaim ? u_core_dlm_waddr : (ext_wgrant ? u_ext_dlm_waddr : u_host_lm_addr[11:0]));
    assign dlm_wbe_w = (u_core_dlm_wclaim ? u_core_dlm_wbe : 4'd15);
    assign dlm_wdata_w = (u_core_dlm_wclaim ? u_core_dlm_wdata : (ext_wgrant ? u_ext_dlm_wdata : u_host_lm_wdata));
    assign hs_ready = u_host_hs_ready;
    assign hr_valid = u_host_hr_valid;
    assign hr_data = u_host_hr_data;
    assign hr_tag = u_host_hr_tag;
    assign uart_tx_data = uart_q_d;
    assign uart_tx_valid = uart_q_v;
    assign trace0 = u_csr_trace0;
    assign trace1 = u_csr_trace1;
    assign trace2 = u_csr_trace2;
    assign trace3 = u_csr_trace3;
    assign dbg_state = {u_csr_go, u_core_quiet, u_ext_busy_o, u_csr_dbg_stopped};
    assign ctrl_cm_valid = u_ext_cm_valid;
    assign ctrl_cm_addr = u_ext_cm_addr;
    assign ctrl_cm_wdata = u_ext_cm_wdata;
    assign ctrl_cm_write = u_ext_cm_write;
    assign ctrl_cm_tag = u_ext_cm_tag;
    assign dm_valid = u_ext_dm_valid;
    assign dm_addr = u_ext_dm_addr;
    assign dm_nbytes = u_ext_dm_nbytes;
    assign dm_write = u_ext_dm_write;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ext_busy_q <= 0;
            uart_q_v <= 0;
            uart_q_d <= 0;
        end else begin
            ext_busy_q <= u_ext_busy_o;
            uart_q_v <= u_csr_uart_tx_valid;
            uart_q_d <= u_csr_uart_tx_data;
        end
    end

    Rv32Core u_core (
        .clk(clk),
        .rst_n(core_rst_n),
        .if_inst(if_inst_w),
        .if_prediction((fetch_rom ? u_rom_prediction : u_ilm_prediction)),
        .predict_waddr(ilm_waddr_w),
        .predict_wdata(ilm_wdata_w),
        .dlm_rdata(u_dlm_rdata),
        .csr_rdata(core_csr_rdata),
        .dlm_zero_bytes(u_dlm_zero_bytes),
        .dlm_local_hint(u_dlm_pointer_local),
        .zero_wdata(dlm_wdata_w),
        .ext_rd_ok(u_ext_ext_rd_ok),
        .ext_dat_ok(u_ext_ext_dat_ok),
        .ext_q_full(u_ext_ext_q_full),
        .ext_rdata(u_ext_ext_rdata),
        .rom_ovr(h_rom_r),
        .ilm_ovr(h_ilm_r),
        .ovr_addr(u_host_lm_addr),
        .dbg_stop(u_csr_dbg_stop),
        .dbg_step(u_csr_dbg_step),
        .dbg_pc_wen(u_host_pc_wen),
        .dbg_x_wen(u_host_x_wen),
        .dbg_x_idx(u_host_x_idx),
        .dbg_wdata(u_host_dbg_wdata),
        .if_read(u_core_if_read),
        .predict_write(u_core_predict_write),
        .zero_write(u_core_zero_write),
        .local_tag_write(u_core_local_tag_write),
        .csr_paddr(u_core_csr_paddr),
        .csr_pgi_a(u_core_csr_pgi_a),
        .csr_pgi_b(u_core_csr_pgi_b),
        .csr_en(u_core_csr_en),
        .csr_wen(u_core_csr_wen),
        .csr_addr(u_core_csr_addr),
        .csr_wdata(u_core_csr_wdata),
        .csr_wo(u_core_csr_wo),
        .halt_o(u_core_halt_o),
        .quiet(u_core_quiet),
        .retire(u_core_retire),
        .ext_wq(u_core_ext_wq),
        .ext_w2(u_core_ext_w2),
        .ext_w3(u_core_ext_w3),
        .ext_kind(u_core_ext_kind),
        .ext_addr(u_core_ext_addr),
        .ext_wdata(u_core_ext_wdata),
        .if_pc(u_core_if_pc),
        .dbg_x_rdata(u_core_dbg_x_rdata),
        .if_rom(u_core_if_rom),
        .if_raddr(u_core_if_raddr),
        .if_iaddr(u_core_if_iaddr),
        .dlm_re(u_core_dlm_re),
        .dlm_raddr(u_core_dlm_raddr),
        .dlm_wclaim(u_core_dlm_wclaim),
        .dlm_we(u_core_dlm_we),
        .dlm_waddr(u_core_dlm_waddr),
        .dlm_wbe(u_core_dlm_wbe),
        .dlm_wdata(u_core_dlm_wdata)
    );
    CpuRom u_rom (
        .clk(clk),
        .re((u_core_if_read | h_rom_r)),
        .raddr(rom_raddr_w),
        .prediction(u_rom_prediction),
        .rdata(u_rom_rdata)
    );
    CpuIlm u_ilm (
        .clk(clk),
        .re(u_core_if_read),
        .raddr(ilm_raddr_w),
        .host_re(h_ilm_r),
        .we(ilm_we_w),
        .waddr(ilm_waddr_w),
        .wdata(ilm_wdata_w),
        .wprediction(u_core_predict_write),
        .prediction(u_ilm_prediction),
        .rdata(u_ilm_rdata),
        .host_rdata(u_ilm_host_rdata)
    );
    CpuDlm u_dlm (
        .clk(clk),
        .raddr(dlm_raddr_w),
        .we(dlm_we_w),
        .waddr(dlm_waddr_w),
        .wbe(dlm_wbe_w),
        .wdata(dlm_wdata_w),
        .wzero(u_core_zero_write),
        .wlocal(u_core_local_tag_write),
        .rdata(u_dlm_rdata),
        .zero_bytes(u_dlm_zero_bytes),
        .pointer_local(u_dlm_pointer_local)
    );
    CpuCsr u_csr (
        .clk(clk),
        .rst_n(rst_n),
        .p_addr(u_core_csr_paddr),
        .p_gi_a(u_core_csr_pgi_a),
        .p_gi_b(u_core_csr_pgi_b),
        .c_en(u_core_csr_en),
        .c_wen(u_core_csr_wen),
        .c_addr(u_core_csr_addr),
        .c_wdata(u_core_csr_wdata),
        .c_wo(u_core_csr_wo),
        .h_wen(u_host_csr_wen),
        .h_addr(u_host_csr_addr),
        .h_gp(u_host_csr_gp),
        .h_gi(u_host_csr_gi),
        .h_wdata(u_host_csr_wdata),
        .core_halt(u_core_halt_o),
        .core_quiet(u_core_quiet),
        .retire(u_core_retire),
        .dbg_stop(u_csr_dbg_stop),
        .dbg_step(u_csr_dbg_step),
        .h_rdata(u_csr_h_rdata),
        .dbg_stopped(u_csr_dbg_stopped),
        .go(u_csr_go),
        .c_rdata(u_csr_c_rdata),
        .trace0(u_csr_trace0),
        .trace1(u_csr_trace1),
        .trace2(u_csr_trace2),
        .trace3(u_csr_trace3),
        .uart_tx_valid(u_csr_uart_tx_valid),
        .uart_tx_data(u_csr_uart_tx_data)
    );
    CpuCdma u_ext (
        .clk(clk),
        .rst_n(core_rst_n),
        .ext_wq(u_core_ext_wq),
        .ext_w2(u_core_ext_w2),
        .ext_w3(u_core_ext_w3),
        .ext_kind(u_core_ext_kind),
        .ext_addr(u_core_ext_addr),
        .ext_wdata(u_core_ext_wdata),
        .csr_addr(u_core_csr_addr),
        .dlm_rgrant(ext_rgrant),
        .dlm_rdata(u_dlm_rdata),
        .dlm_wgrant(ext_wgrant),
        .cm_ready(ctrl_cm_ready),
        .cr_valid(ctrl_cr_valid),
        .cr_data(ctrl_cr_data),
        .cr_tag(ctrl_cr_tag),
        .dm_ready(dm_ready),
        .da_valid(da_valid),
        .dr_valid(dr_valid),
        .dr_data(dr_data),
        .hq_valid(u_host_hq_valid),
        .hq_kind(u_host_hq_kind),
        .hq_data(u_host_hq_data),
        .ext_rd_ok(u_ext_ext_rd_ok),
        .ext_dat_ok(u_ext_ext_dat_ok),
        .ext_q_full(u_ext_ext_q_full),
        .ext_rdata(u_ext_ext_rdata),
        .hq_ready(u_ext_hq_ready),
        .busy_o(u_ext_busy_o),
        .csr_rdata(u_ext_csr_rdata),
        .ilm_we(u_ext_ilm_we),
        .ilm_waddr(u_ext_ilm_waddr),
        .ilm_wdata(u_ext_ilm_wdata),
        .dlm_rreq(u_ext_dlm_rreq),
        .dlm_raddr(u_ext_dlm_raddr),
        .dlm_wreq(u_ext_dlm_wreq),
        .dlm_waddr(u_ext_dlm_waddr),
        .dlm_wdata(u_ext_dlm_wdata),
        .cm_valid(u_ext_cm_valid),
        .cm_addr(u_ext_cm_addr),
        .cm_wdata(u_ext_cm_wdata),
        .cm_write(u_ext_cm_write),
        .cm_tag(u_ext_cm_tag),
        .dm_valid(u_ext_dm_valid),
        .dm_addr(u_ext_dm_addr),
        .dm_nbytes(u_ext_dm_nbytes),
        .dm_write(u_ext_dm_write)
    );
    CpuHost u_host (
        .clk(clk),
        .rst_n(rst_n),
        .hs_valid(hs_valid),
        .hs_op(hs_op),
        .hs_addr(hs_addr),
        .hs_wdata(hs_wdata),
        .hs_tag(hs_tag),
        .hr_ready(hr_ready),
        .csr_rdata(u_csr_h_rdata),
        .hq_ready(u_ext_hq_ready),
        .cdma_busy(u_ext_busy_o),
        .core_pc(u_core_if_pc),
        .x_rdata(u_core_dbg_x_rdata),
        .stopped(u_csr_dbg_stopped),
        .lm_grant(lm_grant_w),
        .lm_rdata(lm_rdata_w),
        .lm_addr(u_host_lm_addr),
        .pc_wen(u_host_pc_wen),
        .x_wen(u_host_x_wen),
        .x_idx(u_host_x_idx),
        .dbg_wdata(u_host_dbg_wdata),
        .csr_wen(u_host_csr_wen),
        .csr_addr(u_host_csr_addr),
        .csr_gp(u_host_csr_gp),
        .csr_gi(u_host_csr_gi),
        .csr_wdata(u_host_csr_wdata),
        .hq_valid(u_host_hq_valid),
        .hq_kind(u_host_hq_kind),
        .hq_data(u_host_hq_data),
        .lm_rom(u_host_lm_rom),
        .lm_dlm(u_host_lm_dlm),
        .lm_ilm(u_host_lm_ilm),
        .lm_re(u_host_lm_re),
        .lm_we(u_host_lm_we),
        .lm_wdata(u_host_lm_wdata),
        .hs_ready(u_host_hs_ready),
        .hr_valid(u_host_hr_valid),
        .hr_data(u_host_hr_data),
        .hr_tag(u_host_hr_tag)
    );
endmodule
