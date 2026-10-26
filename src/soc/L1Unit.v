module L1Unit (
    input clk,
    input rst_n,
    input p_0_ar_valid,
    output logic p_0_ar_ready,
    input [3:0] p_0_ar_id,
    input [15:0] p_0_ar_tag,
    input [7:0] p_0_ar_cfg,
    input [19:0] p_0_ar_off,
    input [19:0] p_0_ar_bytes,
    input [15:0] p_0_ar_rows,
    input [19:0] p_0_ar_stride,
    input p_0_ar_first,
    input p_0_ar_last,
    input p_0_aw_valid,
    output logic p_0_aw_ready,
    input [3:0] p_0_aw_id,
    input [15:0] p_0_aw_tag,
    input [7:0] p_0_aw_cfg,
    input [19:0] p_0_aw_off,
    input [19:0] p_0_aw_bytes,
    input [15:0] p_0_aw_rows,
    input [19:0] p_0_aw_stride,
    input p_0_aw_first,
    input p_0_aw_last,
    input p_0_w_valid,
    input [3:0] p_0_w_id,
    input [1023:0] p_0_w_data,
    input [127:0] p_0_w_strb,
    output logic [7:0] p_0_w_ready,
    output logic p_0_r_valid,
    input p_0_r_ready,
    output logic [1023:0] p_0_r_data,
    output logic [3:0] p_0_r_id,
    output logic [15:0] p_0_r_tag,
    output logic p_0_r_last,
    output logic p_0_b_valid,
    input p_0_b_ready,
    output logic [3:0] p_0_b_id,
    output logic [15:0] p_0_b_tag,
    output logic p_0_a_valid,
    output logic [3:0] p_0_a_id,
    output logic [15:0] p_0_a_tag,
    input p_1_ar_valid,
    output logic p_1_ar_ready,
    input [3:0] p_1_ar_id,
    input [15:0] p_1_ar_tag,
    input [7:0] p_1_ar_cfg,
    input [19:0] p_1_ar_off,
    input [19:0] p_1_ar_bytes,
    input [15:0] p_1_ar_rows,
    input [19:0] p_1_ar_stride,
    input p_1_ar_first,
    input p_1_ar_last,
    input p_1_aw_valid,
    output logic p_1_aw_ready,
    input [3:0] p_1_aw_id,
    input [15:0] p_1_aw_tag,
    input [7:0] p_1_aw_cfg,
    input [19:0] p_1_aw_off,
    input [19:0] p_1_aw_bytes,
    input [15:0] p_1_aw_rows,
    input [19:0] p_1_aw_stride,
    input p_1_aw_first,
    input p_1_aw_last,
    input p_1_w_valid,
    input [3:0] p_1_w_id,
    input [511:0] p_1_w_data,
    input [63:0] p_1_w_strb,
    output logic [7:0] p_1_w_ready,
    output logic p_1_r_valid,
    input p_1_r_ready,
    output logic [511:0] p_1_r_data,
    output logic [3:0] p_1_r_id,
    output logic [15:0] p_1_r_tag,
    output logic p_1_r_last,
    output logic p_1_b_valid,
    input p_1_b_ready,
    output logic [3:0] p_1_b_id,
    output logic [15:0] p_1_b_tag,
    output logic p_1_a_valid,
    output logic [3:0] p_1_a_id,
    output logic [15:0] p_1_a_tag,
    input p_2_ar_valid,
    output logic p_2_ar_ready,
    input [3:0] p_2_ar_id,
    input [15:0] p_2_ar_tag,
    input [7:0] p_2_ar_cfg,
    input [19:0] p_2_ar_off,
    input [19:0] p_2_ar_bytes,
    input [15:0] p_2_ar_rows,
    input [19:0] p_2_ar_stride,
    input p_2_ar_first,
    input p_2_ar_last,
    input p_2_aw_valid,
    output logic p_2_aw_ready,
    input [3:0] p_2_aw_id,
    input [15:0] p_2_aw_tag,
    input [7:0] p_2_aw_cfg,
    input [19:0] p_2_aw_off,
    input [19:0] p_2_aw_bytes,
    input [15:0] p_2_aw_rows,
    input [19:0] p_2_aw_stride,
    input p_2_aw_first,
    input p_2_aw_last,
    input p_2_w_valid,
    input [3:0] p_2_w_id,
    input [511:0] p_2_w_data,
    input [63:0] p_2_w_strb,
    output logic [7:0] p_2_w_ready,
    output logic p_2_r_valid,
    input p_2_r_ready,
    output logic [1023:0] p_2_r_data,
    output logic [3:0] p_2_r_id,
    output logic [15:0] p_2_r_tag,
    output logic p_2_r_last,
    output logic p_2_b_valid,
    input p_2_b_ready,
    output logic [3:0] p_2_b_id,
    output logic [15:0] p_2_b_tag,
    output logic p_2_a_valid,
    output logic [3:0] p_2_a_id,
    output logic [15:0] p_2_a_tag,
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
    output logic [15:0] dbg_pend_write,
    output logic [31:0] dbg_mismatch,
    output logic [15:0] dbg_torn,
    output logic [1:0] dbg_gate_block,
    output logic [1:0] dbg_admit,
    output logic [7:0] dbg_cfg_pend,
    output logic [7:0] dbg_live_slots,
    output logic [31:0] dbg_instq,
    output logic [31:0] dbg_gateq,
    output logic [31:0] dbg_gateq2,
    output logic [1:0] dbg_grant,
    output logic [1:0] dbg_stall,
    output logic [7:0] dbg_occ0,
    output logic [7:0] dbg_occ1,
    output logic [7:0] dbg_occ2
);
    logic u_ent_0_hd_valid;
    logic [2:0] u_ent_0_hd_q;
    logic [7:0] u_ent_0_hd_cid;
    logic u_ent_0_hd_dir;
    logic [19:0] u_ent_0_hd_off;
    logic [19:0] u_ent_0_hd_bytes;
    logic [15:0] u_ent_0_hd_rows;
    logic [19:0] u_ent_0_hd_stride;
    logic [15:0] u_ent_0_hd_tag;
    logic u_ent_0_hd_first;
    logic u_ent_0_hd_last;
    logic u_ent_0_hd_pop;
    logic u_ent_1_hd_valid;
    logic [2:0] u_ent_1_hd_q;
    logic [7:0] u_ent_1_hd_cid;
    logic u_ent_1_hd_dir;
    logic [19:0] u_ent_1_hd_off;
    logic [19:0] u_ent_1_hd_bytes;
    logic [15:0] u_ent_1_hd_rows;
    logic [19:0] u_ent_1_hd_stride;
    logic [15:0] u_ent_1_hd_tag;
    logic u_ent_1_hd_first;
    logic u_ent_1_hd_last;
    logic u_ent_1_hd_pop;
    logic u_ent_2_hd_valid;
    logic [2:0] u_ent_2_hd_q;
    logic [7:0] u_ent_2_hd_cid;
    logic u_ent_2_hd_dir;
    logic [19:0] u_ent_2_hd_off;
    logic [19:0] u_ent_2_hd_bytes;
    logic [15:0] u_ent_2_hd_rows;
    logic [19:0] u_ent_2_hd_stride;
    logic [15:0] u_ent_2_hd_tag;
    logic u_ent_2_hd_first;
    logic u_ent_2_hd_last;
    logic u_ent_2_hd_pop;
    logic u_pipe_p_0_s_valid;
    logic u_pipe_p_0_s_ready;
    logic [19:0] u_pipe_p_0_s_addr;
    logic [19:0] u_pipe_p_0_s_bytes;
    logic u_pipe_p_0_s_dir;
    logic [15:0] u_pipe_p_0_s_tag;
    logic [2:0] u_pipe_p_0_s_q;
    logic [3:0] u_pipe_p_0_s_mid;
    logic u_pipe_p_0_s_last;
    logic [7:0] u_pipe_p_0_s_cid;
    logic u_pipe_p_0_s_cnt;
    logic u_pipe_p_0_dsp_ok;
    logic u_pipe_p_0_dsp;
    logic [7:0] u_pipe_p_0_dsp_cid;
    logic u_pipe_p_0_sdone;
    logic u_pipe_p_0_sdone_dir;
    logic u_pipe_p_0_sdone_w;
    logic u_pipe_p_0_sdone_last;
    logic [15:0] u_pipe_p_0_sdone_tag;
    logic [3:0] u_pipe_p_0_sdone_mid;
    logic u_pipe_p_1_s_valid;
    logic u_pipe_p_1_s_ready;
    logic [19:0] u_pipe_p_1_s_addr;
    logic [19:0] u_pipe_p_1_s_bytes;
    logic u_pipe_p_1_s_dir;
    logic [15:0] u_pipe_p_1_s_tag;
    logic [2:0] u_pipe_p_1_s_q;
    logic [3:0] u_pipe_p_1_s_mid;
    logic u_pipe_p_1_s_last;
    logic [7:0] u_pipe_p_1_s_cid;
    logic u_pipe_p_1_s_cnt;
    logic u_pipe_p_1_dsp_ok;
    logic u_pipe_p_1_dsp;
    logic [7:0] u_pipe_p_1_dsp_cid;
    logic u_pipe_p_1_sdone;
    logic u_pipe_p_1_sdone_dir;
    logic u_pipe_p_1_sdone_w;
    logic u_pipe_p_1_sdone_last;
    logic [15:0] u_pipe_p_1_sdone_tag;
    logic [3:0] u_pipe_p_1_sdone_mid;
    logic u_pipe_p_2_s_valid;
    logic u_pipe_p_2_s_ready;
    logic [19:0] u_pipe_p_2_s_addr;
    logic [19:0] u_pipe_p_2_s_bytes;
    logic u_pipe_p_2_s_dir;
    logic [15:0] u_pipe_p_2_s_tag;
    logic [2:0] u_pipe_p_2_s_q;
    logic [3:0] u_pipe_p_2_s_mid;
    logic u_pipe_p_2_s_last;
    logic [7:0] u_pipe_p_2_s_cid;
    logic u_pipe_p_2_s_cnt;
    logic u_pipe_p_2_dsp_ok;
    logic u_pipe_p_2_dsp;
    logic [7:0] u_pipe_p_2_dsp_cid;
    logic u_pipe_p_2_sdone;
    logic u_pipe_p_2_sdone_dir;
    logic u_pipe_p_2_sdone_w;
    logic u_pipe_p_2_sdone_last;
    logic [15:0] u_pipe_p_2_sdone_tag;
    logic [3:0] u_pipe_p_2_sdone_mid;
    logic [7:0] u_ent_0_dbg_occ;
    logic [7:0] u_ent_1_dbg_occ;
    logic [7:0] u_ent_2_dbg_occ;
    logic [15:0] u_pipe_dbg_pend_write;
    logic [31:0] u_pipe_dbg_mismatch_o;
    logic [15:0] u_pipe_dbg_torn_o;
    logic [1:0] u_pipe_dbg_gate_block;
    logic [1:0] u_pipe_dbg_admit;
    logic [7:0] u_pipe_dbg_cfg_pend;
    logic [7:0] u_pipe_dbg_live_slots;
    logic [31:0] u_pipe_dbg_instq;
    logic [31:0] u_pipe_dbg_gateq;
    logic [31:0] u_pipe_dbg_gateq2;
    logic [1:0] u_bank_dbg_grant;
    logic [1:0] u_bank_dbg_stall;

    assign dbg_occ0 = u_ent_0_dbg_occ;
    assign dbg_occ1 = u_ent_1_dbg_occ;
    assign dbg_occ2 = u_ent_2_dbg_occ;
    assign dbg_pend_write = u_pipe_dbg_pend_write;
    assign dbg_mismatch = u_pipe_dbg_mismatch_o;
    assign dbg_torn = u_pipe_dbg_torn_o;
    assign dbg_gate_block = u_pipe_dbg_gate_block;
    assign dbg_admit = u_pipe_dbg_admit;
    assign dbg_cfg_pend = u_pipe_dbg_cfg_pend;
    assign dbg_live_slots = u_pipe_dbg_live_slots;
    assign dbg_instq = u_pipe_dbg_instq;
    assign dbg_gateq = u_pipe_dbg_gateq;
    assign dbg_gateq2 = u_pipe_dbg_gateq2;
    assign dbg_grant = u_bank_dbg_grant;
    assign dbg_stall = u_bank_dbg_stall;

    L1Entrance4 u_ent_0 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_0_ar_valid),
        .ar_ready(p_0_ar_ready),
        .ar_id(p_0_ar_id),
        .ar_tag(p_0_ar_tag),
        .ar_cfg(p_0_ar_cfg),
        .ar_off(p_0_ar_off),
        .ar_bytes(p_0_ar_bytes),
        .ar_rows(p_0_ar_rows),
        .ar_stride(p_0_ar_stride),
        .ar_first(p_0_ar_first),
        .ar_last(p_0_ar_last),
        .aw_valid(p_0_aw_valid),
        .aw_ready(p_0_aw_ready),
        .aw_id(p_0_aw_id),
        .aw_tag(p_0_aw_tag),
        .aw_cfg(p_0_aw_cfg),
        .aw_off(p_0_aw_off),
        .aw_bytes(p_0_aw_bytes),
        .aw_rows(p_0_aw_rows),
        .aw_stride(p_0_aw_stride),
        .aw_first(p_0_aw_first),
        .aw_last(p_0_aw_last),
        .hd_valid(u_ent_0_hd_valid),
        .hd_q(u_ent_0_hd_q),
        .hd_cid(u_ent_0_hd_cid),
        .hd_dir(u_ent_0_hd_dir),
        .hd_off(u_ent_0_hd_off),
        .hd_bytes(u_ent_0_hd_bytes),
        .hd_rows(u_ent_0_hd_rows),
        .hd_stride(u_ent_0_hd_stride),
        .hd_tag(u_ent_0_hd_tag),
        .hd_first(u_ent_0_hd_first),
        .hd_last(u_ent_0_hd_last),
        .hd_pop(u_ent_0_hd_pop),
        .dbg_occ(u_ent_0_dbg_occ)
    );
    L1Entrance1 u_ent_1 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_1_ar_valid),
        .ar_ready(p_1_ar_ready),
        .ar_id(p_1_ar_id),
        .ar_tag(p_1_ar_tag),
        .ar_cfg(p_1_ar_cfg),
        .ar_off(p_1_ar_off),
        .ar_bytes(p_1_ar_bytes),
        .ar_rows(p_1_ar_rows),
        .ar_stride(p_1_ar_stride),
        .ar_first(p_1_ar_first),
        .ar_last(p_1_ar_last),
        .aw_valid(p_1_aw_valid),
        .aw_ready(p_1_aw_ready),
        .aw_id(p_1_aw_id),
        .aw_tag(p_1_aw_tag),
        .aw_cfg(p_1_aw_cfg),
        .aw_off(p_1_aw_off),
        .aw_bytes(p_1_aw_bytes),
        .aw_rows(p_1_aw_rows),
        .aw_stride(p_1_aw_stride),
        .aw_first(p_1_aw_first),
        .aw_last(p_1_aw_last),
        .hd_valid(u_ent_1_hd_valid),
        .hd_q(u_ent_1_hd_q),
        .hd_cid(u_ent_1_hd_cid),
        .hd_dir(u_ent_1_hd_dir),
        .hd_off(u_ent_1_hd_off),
        .hd_bytes(u_ent_1_hd_bytes),
        .hd_rows(u_ent_1_hd_rows),
        .hd_stride(u_ent_1_hd_stride),
        .hd_tag(u_ent_1_hd_tag),
        .hd_first(u_ent_1_hd_first),
        .hd_last(u_ent_1_hd_last),
        .hd_pop(u_ent_1_hd_pop),
        .dbg_occ(u_ent_1_dbg_occ)
    );
    L1Entrance1 u_ent_2 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_2_ar_valid),
        .ar_ready(p_2_ar_ready),
        .ar_id(p_2_ar_id),
        .ar_tag(p_2_ar_tag),
        .ar_cfg(p_2_ar_cfg),
        .ar_off(p_2_ar_off),
        .ar_bytes(p_2_ar_bytes),
        .ar_rows(p_2_ar_rows),
        .ar_stride(p_2_ar_stride),
        .ar_first(p_2_ar_first),
        .ar_last(p_2_ar_last),
        .aw_valid(p_2_aw_valid),
        .aw_ready(p_2_aw_ready),
        .aw_id(p_2_aw_id),
        .aw_tag(p_2_aw_tag),
        .aw_cfg(p_2_aw_cfg),
        .aw_off(p_2_aw_off),
        .aw_bytes(p_2_aw_bytes),
        .aw_rows(p_2_aw_rows),
        .aw_stride(p_2_aw_stride),
        .aw_first(p_2_aw_first),
        .aw_last(p_2_aw_last),
        .hd_valid(u_ent_2_hd_valid),
        .hd_q(u_ent_2_hd_q),
        .hd_cid(u_ent_2_hd_cid),
        .hd_dir(u_ent_2_hd_dir),
        .hd_off(u_ent_2_hd_off),
        .hd_bytes(u_ent_2_hd_bytes),
        .hd_rows(u_ent_2_hd_rows),
        .hd_stride(u_ent_2_hd_stride),
        .hd_tag(u_ent_2_hd_tag),
        .hd_first(u_ent_2_hd_first),
        .hd_last(u_ent_2_hd_last),
        .hd_pop(u_ent_2_hd_pop),
        .dbg_occ(u_ent_2_dbg_occ)
    );
    L1Pipe u_pipe (
        .clk(clk),
        .rst_n(rst_n),
        .ctrl_s_cm_valid(ctrl_s_cm_valid),
        .ctrl_s_cm_ready(ctrl_s_cm_ready),
        .ctrl_s_cm_addr(ctrl_s_cm_addr),
        .ctrl_s_cm_wdata(ctrl_s_cm_wdata),
        .ctrl_s_cm_write(ctrl_s_cm_write),
        .ctrl_s_cm_tag(ctrl_s_cm_tag),
        .ctrl_s_cr_valid(ctrl_s_cr_valid),
        .ctrl_s_cr_ready(ctrl_s_cr_ready),
        .ctrl_s_cr_data(ctrl_s_cr_data),
        .ctrl_s_cr_tag(ctrl_s_cr_tag),
        .h_0_valid(u_ent_0_hd_valid),
        .h_0_q(u_ent_0_hd_q),
        .h_0_cid(u_ent_0_hd_cid),
        .h_0_dir(u_ent_0_hd_dir),
        .h_0_off(u_ent_0_hd_off),
        .h_0_bytes(u_ent_0_hd_bytes),
        .h_0_rows(u_ent_0_hd_rows),
        .h_0_stride(u_ent_0_hd_stride),
        .h_0_tag(u_ent_0_hd_tag),
        .h_0_first(u_ent_0_hd_first),
        .h_0_last(u_ent_0_hd_last),
        .h_0_pop(u_ent_0_hd_pop),
        .h_1_valid(u_ent_1_hd_valid),
        .h_1_q(u_ent_1_hd_q),
        .h_1_cid(u_ent_1_hd_cid),
        .h_1_dir(u_ent_1_hd_dir),
        .h_1_off(u_ent_1_hd_off),
        .h_1_bytes(u_ent_1_hd_bytes),
        .h_1_rows(u_ent_1_hd_rows),
        .h_1_stride(u_ent_1_hd_stride),
        .h_1_tag(u_ent_1_hd_tag),
        .h_1_first(u_ent_1_hd_first),
        .h_1_last(u_ent_1_hd_last),
        .h_1_pop(u_ent_1_hd_pop),
        .h_2_valid(u_ent_2_hd_valid),
        .h_2_q(u_ent_2_hd_q),
        .h_2_cid(u_ent_2_hd_cid),
        .h_2_dir(u_ent_2_hd_dir),
        .h_2_off(u_ent_2_hd_off),
        .h_2_bytes(u_ent_2_hd_bytes),
        .h_2_rows(u_ent_2_hd_rows),
        .h_2_stride(u_ent_2_hd_stride),
        .h_2_tag(u_ent_2_hd_tag),
        .h_2_first(u_ent_2_hd_first),
        .h_2_last(u_ent_2_hd_last),
        .h_2_pop(u_ent_2_hd_pop),
        .a_0_valid(p_0_a_valid),
        .a_0_id(p_0_a_id),
        .a_0_tag(p_0_a_tag),
        .a_1_valid(p_1_a_valid),
        .a_1_id(p_1_a_id),
        .a_1_tag(p_1_a_tag),
        .a_2_valid(p_2_a_valid),
        .a_2_id(p_2_a_id),
        .a_2_tag(p_2_a_tag),
        .b_0_valid(p_0_b_valid),
        .b_0_ready(p_0_b_ready),
        .b_0_id(p_0_b_id),
        .b_0_tag(p_0_b_tag),
        .b_1_valid(p_1_b_valid),
        .b_1_ready(p_1_b_ready),
        .b_1_id(p_1_b_id),
        .b_1_tag(p_1_b_tag),
        .b_2_valid(p_2_b_valid),
        .b_2_ready(p_2_b_ready),
        .b_2_id(p_2_b_id),
        .b_2_tag(p_2_b_tag),
        .p_0_s_valid(u_pipe_p_0_s_valid),
        .p_0_s_ready(u_pipe_p_0_s_ready),
        .p_0_s_addr(u_pipe_p_0_s_addr),
        .p_0_s_bytes(u_pipe_p_0_s_bytes),
        .p_0_s_dir(u_pipe_p_0_s_dir),
        .p_0_s_tag(u_pipe_p_0_s_tag),
        .p_0_s_q(u_pipe_p_0_s_q),
        .p_0_s_mid(u_pipe_p_0_s_mid),
        .p_0_s_last(u_pipe_p_0_s_last),
        .p_0_s_cid(u_pipe_p_0_s_cid),
        .p_0_s_cnt(u_pipe_p_0_s_cnt),
        .p_0_dsp_ok(u_pipe_p_0_dsp_ok),
        .p_0_dsp(u_pipe_p_0_dsp),
        .p_0_dsp_cid(u_pipe_p_0_dsp_cid),
        .p_0_sdone(u_pipe_p_0_sdone),
        .p_0_sdone_dir(u_pipe_p_0_sdone_dir),
        .p_0_sdone_w(u_pipe_p_0_sdone_w),
        .p_0_sdone_last(u_pipe_p_0_sdone_last),
        .p_0_sdone_tag(u_pipe_p_0_sdone_tag),
        .p_0_sdone_mid(u_pipe_p_0_sdone_mid),
        .p_1_s_valid(u_pipe_p_1_s_valid),
        .p_1_s_ready(u_pipe_p_1_s_ready),
        .p_1_s_addr(u_pipe_p_1_s_addr),
        .p_1_s_bytes(u_pipe_p_1_s_bytes),
        .p_1_s_dir(u_pipe_p_1_s_dir),
        .p_1_s_tag(u_pipe_p_1_s_tag),
        .p_1_s_q(u_pipe_p_1_s_q),
        .p_1_s_mid(u_pipe_p_1_s_mid),
        .p_1_s_last(u_pipe_p_1_s_last),
        .p_1_s_cid(u_pipe_p_1_s_cid),
        .p_1_s_cnt(u_pipe_p_1_s_cnt),
        .p_1_dsp_ok(u_pipe_p_1_dsp_ok),
        .p_1_dsp(u_pipe_p_1_dsp),
        .p_1_dsp_cid(u_pipe_p_1_dsp_cid),
        .p_1_sdone(u_pipe_p_1_sdone),
        .p_1_sdone_dir(u_pipe_p_1_sdone_dir),
        .p_1_sdone_w(u_pipe_p_1_sdone_w),
        .p_1_sdone_last(u_pipe_p_1_sdone_last),
        .p_1_sdone_tag(u_pipe_p_1_sdone_tag),
        .p_1_sdone_mid(u_pipe_p_1_sdone_mid),
        .p_2_s_valid(u_pipe_p_2_s_valid),
        .p_2_s_ready(u_pipe_p_2_s_ready),
        .p_2_s_addr(u_pipe_p_2_s_addr),
        .p_2_s_bytes(u_pipe_p_2_s_bytes),
        .p_2_s_dir(u_pipe_p_2_s_dir),
        .p_2_s_tag(u_pipe_p_2_s_tag),
        .p_2_s_q(u_pipe_p_2_s_q),
        .p_2_s_mid(u_pipe_p_2_s_mid),
        .p_2_s_last(u_pipe_p_2_s_last),
        .p_2_s_cid(u_pipe_p_2_s_cid),
        .p_2_s_cnt(u_pipe_p_2_s_cnt),
        .p_2_dsp_ok(u_pipe_p_2_dsp_ok),
        .p_2_dsp(u_pipe_p_2_dsp),
        .p_2_dsp_cid(u_pipe_p_2_dsp_cid),
        .p_2_sdone(u_pipe_p_2_sdone),
        .p_2_sdone_dir(u_pipe_p_2_sdone_dir),
        .p_2_sdone_w(u_pipe_p_2_sdone_w),
        .p_2_sdone_last(u_pipe_p_2_sdone_last),
        .p_2_sdone_tag(u_pipe_p_2_sdone_tag),
        .p_2_sdone_mid(u_pipe_p_2_sdone_mid),
        .dbg_pend_write(u_pipe_dbg_pend_write),
        .dbg_mismatch_o(u_pipe_dbg_mismatch_o),
        .dbg_torn_o(u_pipe_dbg_torn_o),
        .dbg_gate_block(u_pipe_dbg_gate_block),
        .dbg_admit(u_pipe_dbg_admit),
        .dbg_cfg_pend(u_pipe_dbg_cfg_pend),
        .dbg_live_slots(u_pipe_dbg_live_slots),
        .dbg_instq(u_pipe_dbg_instq),
        .dbg_gateq(u_pipe_dbg_gateq),
        .dbg_gateq2(u_pipe_dbg_gateq2)
    );
    L1Bank u_bank (
        .clk(clk),
        .rst_n(rst_n),
        .p_0_s_valid(u_pipe_p_0_s_valid),
        .p_0_s_ready(u_pipe_p_0_s_ready),
        .p_0_s_addr(u_pipe_p_0_s_addr),
        .p_0_s_bytes(u_pipe_p_0_s_bytes),
        .p_0_s_dir(u_pipe_p_0_s_dir),
        .p_0_s_tag(u_pipe_p_0_s_tag),
        .p_0_s_q(u_pipe_p_0_s_q),
        .p_0_s_mid(u_pipe_p_0_s_mid),
        .p_0_s_last(u_pipe_p_0_s_last),
        .p_0_s_cid(u_pipe_p_0_s_cid),
        .p_0_s_cnt(u_pipe_p_0_s_cnt),
        .p_0_dsp_ok(u_pipe_p_0_dsp_ok),
        .p_0_dsp(u_pipe_p_0_dsp),
        .p_0_dsp_cid(u_pipe_p_0_dsp_cid),
        .p_0_sdone(u_pipe_p_0_sdone),
        .p_0_sdone_dir(u_pipe_p_0_sdone_dir),
        .p_0_sdone_w(u_pipe_p_0_sdone_w),
        .p_0_sdone_last(u_pipe_p_0_sdone_last),
        .p_0_sdone_tag(u_pipe_p_0_sdone_tag),
        .p_0_sdone_mid(u_pipe_p_0_sdone_mid),
        .p_1_s_valid(u_pipe_p_1_s_valid),
        .p_1_s_ready(u_pipe_p_1_s_ready),
        .p_1_s_addr(u_pipe_p_1_s_addr),
        .p_1_s_bytes(u_pipe_p_1_s_bytes),
        .p_1_s_dir(u_pipe_p_1_s_dir),
        .p_1_s_tag(u_pipe_p_1_s_tag),
        .p_1_s_q(u_pipe_p_1_s_q),
        .p_1_s_mid(u_pipe_p_1_s_mid),
        .p_1_s_last(u_pipe_p_1_s_last),
        .p_1_s_cid(u_pipe_p_1_s_cid),
        .p_1_s_cnt(u_pipe_p_1_s_cnt),
        .p_1_dsp_ok(u_pipe_p_1_dsp_ok),
        .p_1_dsp(u_pipe_p_1_dsp),
        .p_1_dsp_cid(u_pipe_p_1_dsp_cid),
        .p_1_sdone(u_pipe_p_1_sdone),
        .p_1_sdone_dir(u_pipe_p_1_sdone_dir),
        .p_1_sdone_w(u_pipe_p_1_sdone_w),
        .p_1_sdone_last(u_pipe_p_1_sdone_last),
        .p_1_sdone_tag(u_pipe_p_1_sdone_tag),
        .p_1_sdone_mid(u_pipe_p_1_sdone_mid),
        .p_2_s_valid(u_pipe_p_2_s_valid),
        .p_2_s_ready(u_pipe_p_2_s_ready),
        .p_2_s_addr(u_pipe_p_2_s_addr),
        .p_2_s_bytes(u_pipe_p_2_s_bytes),
        .p_2_s_dir(u_pipe_p_2_s_dir),
        .p_2_s_tag(u_pipe_p_2_s_tag),
        .p_2_s_q(u_pipe_p_2_s_q),
        .p_2_s_mid(u_pipe_p_2_s_mid),
        .p_2_s_last(u_pipe_p_2_s_last),
        .p_2_s_cid(u_pipe_p_2_s_cid),
        .p_2_s_cnt(u_pipe_p_2_s_cnt),
        .p_2_dsp_ok(u_pipe_p_2_dsp_ok),
        .p_2_dsp(u_pipe_p_2_dsp),
        .p_2_dsp_cid(u_pipe_p_2_dsp_cid),
        .p_2_sdone(u_pipe_p_2_sdone),
        .p_2_sdone_dir(u_pipe_p_2_sdone_dir),
        .p_2_sdone_w(u_pipe_p_2_sdone_w),
        .p_2_sdone_last(u_pipe_p_2_sdone_last),
        .p_2_sdone_tag(u_pipe_p_2_sdone_tag),
        .p_2_sdone_mid(u_pipe_p_2_sdone_mid),
        .w_0_valid(p_0_w_valid),
        .w_0_id(p_0_w_id),
        .w_0_data(p_0_w_data),
        .w_0_strb(p_0_w_strb),
        .w_0_ready(p_0_w_ready),
        .w_1_valid(p_1_w_valid),
        .w_1_id(p_1_w_id),
        .w_1_data(p_1_w_data),
        .w_1_strb(p_1_w_strb),
        .w_1_ready(p_1_w_ready),
        .w_2_valid(p_2_w_valid),
        .w_2_id(p_2_w_id),
        .w_2_data(p_2_w_data),
        .w_2_strb(p_2_w_strb),
        .w_2_ready(p_2_w_ready),
        .r_0_valid(p_0_r_valid),
        .r_0_ready(p_0_r_ready),
        .r_0_data(p_0_r_data),
        .r_0_id(p_0_r_id),
        .r_0_tag(p_0_r_tag),
        .r_0_last(p_0_r_last),
        .r_1_valid(p_1_r_valid),
        .r_1_ready(p_1_r_ready),
        .r_1_data(p_1_r_data),
        .r_1_id(p_1_r_id),
        .r_1_tag(p_1_r_tag),
        .r_1_last(p_1_r_last),
        .r_2_valid(p_2_r_valid),
        .r_2_ready(p_2_r_ready),
        .r_2_data(p_2_r_data),
        .r_2_id(p_2_r_id),
        .r_2_tag(p_2_r_tag),
        .r_2_last(p_2_r_last),
        .dbg_grant(u_bank_dbg_grant),
        .dbg_stall(u_bank_dbg_stall)
    );
endmodule
