module Mac2DUnit (
    input clk,
    input rst_n,
    input ctrl_s_cm_valid,
    output logic ctrl_s_cm_ready,
    input [31:0] ctrl_s_cm_addr,
    input [31:0] ctrl_s_cm_wdata,
    input ctrl_s_cm_write,
    input [23:0] ctrl_s_cm_tag,
    output logic ctrl_s_cr_valid,
    input ctrl_s_cr_ready,
    output logic [31:0] ctrl_s_cr_data,
    output logic [23:0] ctrl_s_cr_tag,
    output logic l1_ar_valid,
    input l1_ar_ready,
    output logic [3:0] l1_ar_id,
    output logic [15:0] l1_ar_tag,
    output logic [7:0] l1_ar_cfg,
    output logic [19:0] l1_ar_off,
    output logic [19:0] l1_ar_bytes,
    output logic [15:0] l1_ar_rows,
    output logic [19:0] l1_ar_stride,
    output logic l1_ar_first,
    output logic l1_ar_last,
    output logic l1_aw_valid,
    input l1_aw_ready,
    output logic [3:0] l1_aw_id,
    output logic [15:0] l1_aw_tag,
    output logic [7:0] l1_aw_cfg,
    output logic [19:0] l1_aw_off,
    output logic [19:0] l1_aw_bytes,
    output logic [15:0] l1_aw_rows,
    output logic [19:0] l1_aw_stride,
    output logic l1_aw_first,
    output logic l1_aw_last,
    output logic l1_w_valid,
    output logic [3:0] l1_w_id,
    output logic [511:0] l1_w_data,
    output logic [63:0] l1_w_strb,
    input [7:0] l1_w_ready,
    input l1_r_valid,
    output logic l1_r_ready,
    input [1023:0] l1_r_data,
    input [3:0] l1_r_id,
    input [15:0] l1_r_tag,
    input l1_r_last,
    input l1_b_valid,
    output logic l1_b_ready,
    input [3:0] l1_b_id,
    input [15:0] l1_b_tag,
    input l1_a_valid,
    input [3:0] l1_a_id,
    input [15:0] l1_a_tag,
    output logic noc_ar_valid,
    input noc_ar_ready,
    output logic [3:0] noc_ar_id,
    output logic [15:0] noc_ar_tag,
    output logic [47:0] noc_ar_addr,
    output logic [19:0] noc_ar_bytes,
    output logic [15:0] noc_ar_rows,
    output logic [19:0] noc_ar_stride,
    output logic noc_ar_first,
    output logic noc_ar_last,
    output logic noc_aw_valid,
    input noc_aw_ready,
    output logic [3:0] noc_aw_id,
    output logic [15:0] noc_aw_tag,
    output logic [47:0] noc_aw_addr,
    output logic [19:0] noc_aw_bytes,
    output logic [15:0] noc_aw_rows,
    output logic [19:0] noc_aw_stride,
    output logic noc_aw_first,
    output logic noc_aw_last,
    output logic noc_w_valid,
    output logic [3:0] noc_w_id,
    output logic [511:0] noc_w_data,
    output logic [63:0] noc_w_strb,
    input [7:0] noc_w_ready,
    input noc_r_valid,
    output logic noc_r_ready,
    input [1023:0] noc_r_data,
    input [3:0] noc_r_id,
    input [15:0] noc_r_tag,
    input noc_r_last,
    input noc_b_valid,
    output logic noc_b_ready,
    input [3:0] noc_b_id,
    input [15:0] noc_b_tag,
    input noc_a_valid,
    input [3:0] noc_a_id,
    input [15:0] noc_a_tag,
    output logic dbg_busy,
    output logic dbg_idle,
    output logic dbg_retire,
    output logic [15:0] dbg_donec,
    output logic [4:0] dbg_occ,
    output logic [5:0] dbg_acc_occ,
    output logic dbg_badacc
);
    logic [31:0] cm_addr;
    logic cm_seg;
    logic [6:0] cm_off;
    logic cm_isram;
    logic cm_kid;
    logic cm_kparam;
    logic cm_busy_r;
    logic cm_donec_r;
    logic cr_v;
    logic [31:0] cr_data_q;
    logic [23:0] cr_tag_q;
    logic [31:0] kparam;
    logic [23:0] prog;
    logic rd_ok;
    logic iss_ready;
    logic cm_fire;
    logic m2d_rst;
    logic do_launch;
    logic do_isram;
    logic u_m2d_issue_ready;
    logic u_m2d_dbg_busy;
    logic u_m2d_dbg_idle;
    logic u_m2d_dbg_retire;
    logic [15:0] u_m2d_dbg_donec;
    logic [4:0] u_m2d_dbg_occ;
    logic [5:0] u_m2d_dbg_acc_occ;
    logic u_m2d_dbg_badacc;

    assign cm_addr = ctrl_s_cm_addr;
    assign cm_seg = ((cm_addr >= 464) & (cm_addr < 528));
    assign cm_off = (cm_addr[6:0] - 7'd80);
    assign cm_isram = ((cm_addr[31:16] == 514) & (cm_addr[15:14] == 2'd0));
    assign cm_kid = (cm_seg & (cm_off == 2));
    assign cm_kparam = (cm_seg & (cm_off == 1));
    assign cm_busy_r = (cm_seg & (cm_off == 33));
    assign cm_donec_r = (cm_seg & (cm_off == 34));
    assign rd_ok = ((~cr_v) | ctrl_s_cr_ready);
    assign ctrl_s_cm_ready = (ctrl_s_cm_write ? (cm_kid ? iss_ready : 1'd1) : rd_ok);
    assign cm_fire = (ctrl_s_cm_valid & ctrl_s_cm_ready);
    assign ctrl_s_cr_valid = cr_v;
    assign ctrl_s_cr_data = cr_data_q;
    assign ctrl_s_cr_tag = cr_tag_q;
    assign do_launch = ((cm_fire & ctrl_s_cm_write) & cm_kid);
    assign do_isram = ((cm_fire & ctrl_s_cm_write) & cm_isram);
    assign iss_ready = u_m2d_issue_ready;
    assign dbg_busy = u_m2d_dbg_busy;
    assign dbg_idle = u_m2d_dbg_idle;
    assign dbg_retire = u_m2d_dbg_retire;
    assign dbg_donec = u_m2d_dbg_donec;
    assign dbg_occ = u_m2d_dbg_occ;
    assign dbg_acc_occ = u_m2d_dbg_acc_occ;
    assign dbg_badacc = u_m2d_dbg_badacc;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            kparam <= 0;
            prog <= 0;
            cr_v <= 0;
            cr_tag_q <= 0;
            cr_data_q <= 0;
        end else begin
            if (((cm_fire & ctrl_s_cm_write) & cm_kparam)) begin
                kparam <= ctrl_s_cm_wdata;
            end
            if (do_launch) begin
                prog <= (prog + 1);
            end
            if ((cr_v & ctrl_s_cr_ready)) begin
                cr_v <= 0;
            end
            if ((cm_fire & (~ctrl_s_cm_write))) begin
                cr_v <= 1;
                cr_tag_q <= ctrl_s_cm_tag;
                cr_data_q <= (cm_busy_r ? {31'd0, dbg_busy} : (cm_donec_r ? {16'd0, dbg_donec} : 32'd0));
            end
        end
    end
    always_ff @(posedge clk) begin
        m2d_rst <= rst_n;
    end

    Mac2D u_m2d (
        .clk(clk),
        .rst_n(m2d_rst),
        .issue_valid(do_launch),
        .issue_is_launch(1'd1),
        .issue_instr(128'd0),
        .issue_launch_id({16'd0, ctrl_s_cm_wdata[15:0]}),
        .issue_launch_off({kparam[7:0], ctrl_s_cm_wdata[31:16]}),
        .issue_launch_len(kparam[23:8]),
        .issue_prog_idx(prog),
        .isram_wen(do_isram),
        .isram_waddr(cm_addr[13:2]),
        .isram_wdata(ctrl_s_cm_wdata),
        .l1_ar_valid(l1_ar_valid),
        .l1_ar_ready(l1_ar_ready),
        .l1_ar_id(l1_ar_id),
        .l1_ar_tag(l1_ar_tag),
        .l1_ar_cfg(l1_ar_cfg),
        .l1_ar_off(l1_ar_off),
        .l1_ar_bytes(l1_ar_bytes),
        .l1_ar_rows(l1_ar_rows),
        .l1_ar_stride(l1_ar_stride),
        .l1_ar_first(l1_ar_first),
        .l1_ar_last(l1_ar_last),
        .l1_aw_valid(l1_aw_valid),
        .l1_aw_ready(l1_aw_ready),
        .l1_aw_id(l1_aw_id),
        .l1_aw_tag(l1_aw_tag),
        .l1_aw_cfg(l1_aw_cfg),
        .l1_aw_off(l1_aw_off),
        .l1_aw_bytes(l1_aw_bytes),
        .l1_aw_rows(l1_aw_rows),
        .l1_aw_stride(l1_aw_stride),
        .l1_aw_first(l1_aw_first),
        .l1_aw_last(l1_aw_last),
        .l1_w_valid(l1_w_valid),
        .l1_w_id(l1_w_id),
        .l1_w_data(l1_w_data),
        .l1_w_strb(l1_w_strb),
        .l1_w_ready(l1_w_ready),
        .l1_r_valid(l1_r_valid),
        .l1_r_ready(l1_r_ready),
        .l1_r_data(l1_r_data),
        .l1_r_id(l1_r_id),
        .l1_r_tag(l1_r_tag),
        .l1_r_last(l1_r_last),
        .l1_b_valid(l1_b_valid),
        .l1_b_ready(l1_b_ready),
        .l1_b_id(l1_b_id),
        .l1_b_tag(l1_b_tag),
        .l1_a_valid(l1_a_valid),
        .l1_a_id(l1_a_id),
        .l1_a_tag(l1_a_tag),
        .noc_ar_valid(noc_ar_valid),
        .noc_ar_ready(noc_ar_ready),
        .noc_ar_id(noc_ar_id),
        .noc_ar_tag(noc_ar_tag),
        .noc_ar_addr(noc_ar_addr),
        .noc_ar_bytes(noc_ar_bytes),
        .noc_ar_rows(noc_ar_rows),
        .noc_ar_stride(noc_ar_stride),
        .noc_ar_first(noc_ar_first),
        .noc_ar_last(noc_ar_last),
        .noc_aw_valid(noc_aw_valid),
        .noc_aw_ready(noc_aw_ready),
        .noc_aw_id(noc_aw_id),
        .noc_aw_tag(noc_aw_tag),
        .noc_aw_addr(noc_aw_addr),
        .noc_aw_bytes(noc_aw_bytes),
        .noc_aw_rows(noc_aw_rows),
        .noc_aw_stride(noc_aw_stride),
        .noc_aw_first(noc_aw_first),
        .noc_aw_last(noc_aw_last),
        .noc_w_valid(noc_w_valid),
        .noc_w_id(noc_w_id),
        .noc_w_data(noc_w_data),
        .noc_w_strb(noc_w_strb),
        .noc_w_ready(noc_w_ready),
        .noc_r_valid(noc_r_valid),
        .noc_r_ready(noc_r_ready),
        .noc_r_data(noc_r_data),
        .noc_r_id(noc_r_id),
        .noc_r_tag(noc_r_tag),
        .noc_r_last(noc_r_last),
        .noc_b_valid(noc_b_valid),
        .noc_b_ready(noc_b_ready),
        .noc_b_id(noc_b_id),
        .noc_b_tag(noc_b_tag),
        .noc_a_valid(noc_a_valid),
        .noc_a_id(noc_a_id),
        .noc_a_tag(noc_a_tag),
        .issue_ready(u_m2d_issue_ready),
        .dbg_busy(u_m2d_dbg_busy),
        .dbg_idle(u_m2d_dbg_idle),
        .dbg_retire(u_m2d_dbg_retire),
        .dbg_donec(u_m2d_dbg_donec),
        .dbg_occ(u_m2d_dbg_occ),
        .dbg_acc_occ(u_m2d_dbg_acc_occ),
        .dbg_badacc(u_m2d_dbg_badacc)
    );
endmodule
