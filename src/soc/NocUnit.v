module NocUnit (
    input clk,
    input rst_n,
    input p_0_ar_valid,
    output logic p_0_ar_ready,
    input [3:0] p_0_ar_id,
    input [15:0] p_0_ar_tag,
    input [47:0] p_0_ar_addr,
    input [19:0] p_0_ar_bytes,
    input [15:0] p_0_ar_rows,
    input [19:0] p_0_ar_stride,
    input p_0_ar_first,
    input p_0_ar_last,
    input p_0_aw_valid,
    output logic p_0_aw_ready,
    input [3:0] p_0_aw_id,
    input [15:0] p_0_aw_tag,
    input [47:0] p_0_aw_addr,
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
    input [47:0] p_1_ar_addr,
    input [19:0] p_1_ar_bytes,
    input [15:0] p_1_ar_rows,
    input [19:0] p_1_ar_stride,
    input p_1_ar_first,
    input p_1_ar_last,
    input p_1_aw_valid,
    output logic p_1_aw_ready,
    input [3:0] p_1_aw_id,
    input [15:0] p_1_aw_tag,
    input [47:0] p_1_aw_addr,
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
    input [47:0] p_2_ar_addr,
    input [19:0] p_2_ar_bytes,
    input [15:0] p_2_ar_rows,
    input [19:0] p_2_ar_stride,
    input p_2_ar_first,
    input p_2_ar_last,
    input p_2_aw_valid,
    output logic p_2_aw_ready,
    input [3:0] p_2_aw_id,
    input [15:0] p_2_aw_tag,
    input [47:0] p_2_aw_addr,
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
    input p_3_ar_valid,
    output logic p_3_ar_ready,
    input [3:0] p_3_ar_id,
    input [15:0] p_3_ar_tag,
    input [47:0] p_3_ar_addr,
    input [19:0] p_3_ar_bytes,
    input [15:0] p_3_ar_rows,
    input [19:0] p_3_ar_stride,
    input p_3_ar_first,
    input p_3_ar_last,
    input p_3_aw_valid,
    output logic p_3_aw_ready,
    input [3:0] p_3_aw_id,
    input [15:0] p_3_aw_tag,
    input [47:0] p_3_aw_addr,
    input [19:0] p_3_aw_bytes,
    input [15:0] p_3_aw_rows,
    input [19:0] p_3_aw_stride,
    input p_3_aw_first,
    input p_3_aw_last,
    input p_3_w_valid,
    input [3:0] p_3_w_id,
    input [1023:0] p_3_w_data,
    input [127:0] p_3_w_strb,
    output logic [7:0] p_3_w_ready,
    output logic p_3_r_valid,
    input p_3_r_ready,
    output logic [1023:0] p_3_r_data,
    output logic [3:0] p_3_r_id,
    output logic [15:0] p_3_r_tag,
    output logic p_3_r_last,
    output logic p_3_b_valid,
    input p_3_b_ready,
    output logic [3:0] p_3_b_id,
    output logic [15:0] p_3_b_tag,
    output logic p_3_a_valid,
    output logic [3:0] p_3_a_id,
    output logic [15:0] p_3_a_tag,
    input p_4_ar_valid,
    output logic p_4_ar_ready,
    input [3:0] p_4_ar_id,
    input [15:0] p_4_ar_tag,
    input [47:0] p_4_ar_addr,
    input [19:0] p_4_ar_bytes,
    input [15:0] p_4_ar_rows,
    input [19:0] p_4_ar_stride,
    input p_4_ar_first,
    input p_4_ar_last,
    input p_4_aw_valid,
    output logic p_4_aw_ready,
    input [3:0] p_4_aw_id,
    input [15:0] p_4_aw_tag,
    input [47:0] p_4_aw_addr,
    input [19:0] p_4_aw_bytes,
    input [15:0] p_4_aw_rows,
    input [19:0] p_4_aw_stride,
    input p_4_aw_first,
    input p_4_aw_last,
    input p_4_w_valid,
    input [3:0] p_4_w_id,
    input [1023:0] p_4_w_data,
    input [127:0] p_4_w_strb,
    output logic [7:0] p_4_w_ready,
    output logic p_4_r_valid,
    input p_4_r_ready,
    output logic [1023:0] p_4_r_data,
    output logic [3:0] p_4_r_id,
    output logic [15:0] p_4_r_tag,
    output logic p_4_r_last,
    output logic p_4_b_valid,
    input p_4_b_ready,
    output logic [3:0] p_4_b_id,
    output logic [15:0] p_4_b_tag,
    output logic p_4_a_valid,
    output logic [3:0] p_4_a_id,
    output logic [15:0] p_4_a_tag,
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
    input stat_clr_all,
    output logic [31:0] st_req,
    output logic [31:0] st_fill,
    output logic [31:0] st_wt,
    output logic [15:0] dbg_pend_write,
    output logic dbg_admit,
    output logic [3:0] dbg_port_stall,
    output logic dbg_idle,
    output logic [7:0] dbg_win_occ,
    output logic [5:0] dbg_infl_occ,
    output logic [5:0] dbg_rd_out,
    output logic [5:0] dbg_asm_occ,
    output logic [15:0] dbg_asm_blk,
    output logic [3:0] dbg_lane_busy,
    output logic [5:0] dbg_occ0,
    output logic [5:0] dbg_occ1,
    output logic [5:0] dbg_occ2,
    output logic [5:0] dbg_occ3,
    output logic [5:0] dbg_occ4
);
    logic u_ing_0_rd_v;
    logic u_ing_0_rd_nz;
    logic u_ing_0_rd_n1;
    logic u_ing_0_rd_nm;
    logic u_ing_0_rd_psh;
    logic u_ing_0_rd_pop;
    logic u_ing_0_rd_loc;
    logic [3:0] u_ing_0_rd_id;
    logic [15:0] u_ing_0_rd_tag;
    logic [47:0] u_ing_0_rd_addr;
    logic [19:0] u_ing_0_rd_bytes;
    logic [15:0] u_ing_0_rd_rows;
    logic [19:0] u_ing_0_rd_stride;
    logic u_ing_1_rd_v;
    logic u_ing_1_rd_nz;
    logic u_ing_1_rd_n1;
    logic u_ing_1_rd_nm;
    logic u_ing_1_rd_psh;
    logic u_ing_1_rd_pop;
    logic u_ing_1_rd_loc;
    logic [3:0] u_ing_1_rd_id;
    logic [15:0] u_ing_1_rd_tag;
    logic [47:0] u_ing_1_rd_addr;
    logic [19:0] u_ing_1_rd_bytes;
    logic [15:0] u_ing_1_rd_rows;
    logic [19:0] u_ing_1_rd_stride;
    logic u_ing_2_rd_v;
    logic u_ing_2_rd_nz;
    logic u_ing_2_rd_n1;
    logic u_ing_2_rd_nm;
    logic u_ing_2_rd_psh;
    logic u_ing_2_rd_pop;
    logic u_ing_2_rd_loc;
    logic [3:0] u_ing_2_rd_id;
    logic [15:0] u_ing_2_rd_tag;
    logic [47:0] u_ing_2_rd_addr;
    logic [19:0] u_ing_2_rd_bytes;
    logic [15:0] u_ing_2_rd_rows;
    logic [19:0] u_ing_2_rd_stride;
    logic u_ing_3_rd_v;
    logic u_ing_3_rd_nz;
    logic u_ing_3_rd_n1;
    logic u_ing_3_rd_nm;
    logic u_ing_3_rd_psh;
    logic u_ing_3_rd_pop;
    logic u_ing_3_rd_loc;
    logic [3:0] u_ing_3_rd_id;
    logic [15:0] u_ing_3_rd_tag;
    logic [47:0] u_ing_3_rd_addr;
    logic [19:0] u_ing_3_rd_bytes;
    logic [15:0] u_ing_3_rd_rows;
    logic [19:0] u_ing_3_rd_stride;
    logic u_ing_4_rd_v;
    logic u_ing_4_rd_nz;
    logic u_ing_4_rd_n1;
    logic u_ing_4_rd_nm;
    logic u_ing_4_rd_psh;
    logic u_ing_4_rd_pop;
    logic u_ing_4_rd_loc;
    logic [3:0] u_ing_4_rd_id;
    logic [15:0] u_ing_4_rd_tag;
    logic [47:0] u_ing_4_rd_addr;
    logic [19:0] u_ing_4_rd_bytes;
    logic [15:0] u_ing_4_rd_rows;
    logic [19:0] u_ing_4_rd_stride;
    logic u_ing_0_wr_v;
    logic u_ing_0_wr_nz;
    logic u_ing_0_wr_n1;
    logic u_ing_0_wr_nm;
    logic u_ing_0_wr_psh;
    logic u_ing_0_wr_pop;
    logic u_ing_0_wr_loc;
    logic [3:0] u_ing_0_wr_id;
    logic [15:0] u_ing_0_wr_tag;
    logic [47:0] u_ing_0_wr_addr;
    logic [19:0] u_ing_0_wr_bytes;
    logic [15:0] u_ing_0_wr_rows;
    logic [19:0] u_ing_0_wr_stride;
    logic u_ing_1_wr_v;
    logic u_ing_1_wr_nz;
    logic u_ing_1_wr_n1;
    logic u_ing_1_wr_nm;
    logic u_ing_1_wr_psh;
    logic u_ing_1_wr_pop;
    logic u_ing_1_wr_loc;
    logic [3:0] u_ing_1_wr_id;
    logic [15:0] u_ing_1_wr_tag;
    logic [47:0] u_ing_1_wr_addr;
    logic [19:0] u_ing_1_wr_bytes;
    logic [15:0] u_ing_1_wr_rows;
    logic [19:0] u_ing_1_wr_stride;
    logic u_ing_2_wr_v;
    logic u_ing_2_wr_nz;
    logic u_ing_2_wr_n1;
    logic u_ing_2_wr_nm;
    logic u_ing_2_wr_psh;
    logic u_ing_2_wr_pop;
    logic u_ing_2_wr_loc;
    logic [3:0] u_ing_2_wr_id;
    logic [15:0] u_ing_2_wr_tag;
    logic [47:0] u_ing_2_wr_addr;
    logic [19:0] u_ing_2_wr_bytes;
    logic [15:0] u_ing_2_wr_rows;
    logic [19:0] u_ing_2_wr_stride;
    logic u_ing_3_wr_v;
    logic u_ing_3_wr_nz;
    logic u_ing_3_wr_n1;
    logic u_ing_3_wr_nm;
    logic u_ing_3_wr_psh;
    logic u_ing_3_wr_pop;
    logic u_ing_3_wr_loc;
    logic [3:0] u_ing_3_wr_id;
    logic [15:0] u_ing_3_wr_tag;
    logic [47:0] u_ing_3_wr_addr;
    logic [19:0] u_ing_3_wr_bytes;
    logic [15:0] u_ing_3_wr_rows;
    logic [19:0] u_ing_3_wr_stride;
    logic u_ing_4_wr_v;
    logic u_ing_4_wr_nz;
    logic u_ing_4_wr_n1;
    logic u_ing_4_wr_nm;
    logic u_ing_4_wr_psh;
    logic u_ing_4_wr_pop;
    logic u_ing_4_wr_loc;
    logic [3:0] u_ing_4_wr_id;
    logic [15:0] u_ing_4_wr_tag;
    logic [47:0] u_ing_4_wr_addr;
    logic [19:0] u_ing_4_wr_bytes;
    logic [15:0] u_ing_4_wr_rows;
    logic [19:0] u_ing_4_wr_stride;
    logic [31:0] u_agg_st_req;
    logic [31:0] u_agg_st_fill;
    logic [31:0] u_agg_st_wt;
    logic u_ent_agg_b_ok0;
    logic u_ent_agg_b_ok1;
    logic u_ent_agg_b_ok2;
    logic u_ent_agg_b_ok3;
    logic u_ent_agg_b_ok4;
    logic u_ent_agg_rq0_push;
    logic [7:0] u_ent_agg_rq0_tk;
    logic [47:0] u_ent_agg_rq0_addr;
    logic [4:0] u_ent_agg_rq0_slot;
    logic u_ent_agg_rq0_ok;
    logic u_ent_agg_rq1_push;
    logic [7:0] u_ent_agg_rq1_tk;
    logic [47:0] u_ent_agg_rq1_addr;
    logic [4:0] u_ent_agg_rq1_slot;
    logic u_ent_agg_rq1_ok;
    logic u_ent_agg_rq2_push;
    logic [7:0] u_ent_agg_rq2_tk;
    logic [47:0] u_ent_agg_rq2_addr;
    logic [4:0] u_ent_agg_rq2_slot;
    logic u_ent_agg_rq2_ok;
    logic u_ent_agg_rq3_push;
    logic [7:0] u_ent_agg_rq3_tk;
    logic [47:0] u_ent_agg_rq3_addr;
    logic [4:0] u_ent_agg_rq3_slot;
    logic u_ent_agg_rq3_ok;
    logic u_ent_agg_wq_push;
    logic [2:0] u_ent_agg_wq_m;
    logic [3:0] u_ent_agg_wq_wid;
    logic [47:0] u_ent_agg_wq_addr;
    logic [8:0] u_ent_agg_wq_eoff;
    logic u_ent_agg_wq_last;
    logic [15:0] u_ent_agg_wq_tag;
    logic u_ent_agg_wq_loc;
    logic u_ent_agg_wq_ok;
    logic u_ent_agg_ra_en;
    logic [5:0] u_ent_agg_ra_addr;
    logic [1023:0] u_ent_agg_ra_data;
    logic u_ent_agg_rb_en;
    logic [5:0] u_ent_agg_rb_addr;
    logic [1023:0] u_ent_agg_rb_data;
    logic u_ent_agg_ed0_v;
    logic [4:0] u_ent_agg_ed0_slot;
    logic u_ent_agg_ed1_v;
    logic [4:0] u_ent_agg_ed1_slot;
    logic u_ent_agg_asm_ok0_c0;
    logic [4:0] u_ent_agg_asm_s0_c0;
    logic u_ent_agg_asm_ok1_c0;
    logic [4:0] u_ent_agg_asm_s1_c0;
    logic u_ent_agg_asm_ok0_c1;
    logic [4:0] u_ent_agg_asm_s0_c1;
    logic u_ent_agg_asm_ok1_c1;
    logic [4:0] u_ent_agg_asm_s1_c1;
    logic u_ent_agg_asm_rv0;
    logic u_ent_agg_asm_rv1;
    logic u_ent_agg_asm_pa_c0;
    logic u_ent_agg_asm_pa_c1;
    logic u_ent_agg_asm_pb_c0;
    logic u_ent_agg_asm_pb_c1;
    logic u_ent_agg_wk0_v;
    logic [7:0] u_ent_agg_wk0_tk;
    logic [4:0] u_ent_agg_wk0_asl;
    logic u_ent_agg_wk1_v;
    logic [7:0] u_ent_agg_wk1_tk;
    logic [4:0] u_ent_agg_wk1_asl;
    logic u_ent_agg_bev_v;
    logic [2:0] u_ent_agg_bev_m;
    logic [3:0] u_ent_agg_bev_wid;
    logic [15:0] u_ent_agg_bev_tag;
    logic u_ent_agg_bev_loc;
    logic [15:0] u_ent_dbg_pend_write;
    logic u_ent_dbg_admit;
    logic [3:0] u_ent_dbg_port_stall;
    logic [7:0] u_ent_dbg_win_occ;
    logic [5:0] u_agg_dbg_infl_occ;
    logic [5:0] u_agg_dbg_rd_out;
    logic [3:0] u_agg_dbg_lane_busy;
    logic [5:0] u_agg_dbg_asm_occ;
    logic [15:0] u_ent_dbg_asm_blk;
    logic [3:0] u_ing_0_occ;
    logic [3:0] u_ing_1_occ;
    logic [3:0] u_ing_2_occ;
    logic [3:0] u_ing_3_occ;
    logic [3:0] u_ing_4_occ;
    logic u_ent_dbg_idle;
    logic u_agg_dbg_idle;

    assign st_req = u_agg_st_req;
    assign st_fill = u_agg_st_fill;
    assign st_wt = u_agg_st_wt;
    assign dbg_pend_write = u_ent_dbg_pend_write;
    assign dbg_admit = u_ent_dbg_admit;
    assign dbg_port_stall = u_ent_dbg_port_stall;
    assign dbg_win_occ = u_ent_dbg_win_occ;
    assign dbg_infl_occ = u_agg_dbg_infl_occ;
    assign dbg_rd_out = u_agg_dbg_rd_out;
    assign dbg_lane_busy = u_agg_dbg_lane_busy;
    assign dbg_asm_occ = u_agg_dbg_asm_occ;
    assign dbg_asm_blk = u_ent_dbg_asm_blk;
    assign dbg_occ0 = u_ing_0_occ;
    assign dbg_occ1 = u_ing_1_occ;
    assign dbg_occ2 = u_ing_2_occ;
    assign dbg_occ3 = u_ing_3_occ;
    assign dbg_occ4 = u_ing_4_occ;
    assign dbg_idle = ((((((u_ent_dbg_idle & u_agg_dbg_idle) & (u_ing_0_occ == 0)) & (u_ing_1_occ == 0))
                       & (u_ing_2_occ == 0)) & (u_ing_3_occ == 0)) & (u_ing_4_occ == 0));

    NocIngress u_ing_0 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_0_ar_valid),
        .ar_ready(p_0_ar_ready),
        .ar_id(p_0_ar_id),
        .ar_tag(p_0_ar_tag),
        .ar_addr(p_0_ar_addr),
        .ar_bytes(p_0_ar_bytes),
        .ar_rows(p_0_ar_rows),
        .ar_stride(p_0_ar_stride),
        .ar_first(p_0_ar_first),
        .ar_last(p_0_ar_last),
        .aw_valid(p_0_aw_valid),
        .aw_ready(p_0_aw_ready),
        .aw_id(p_0_aw_id),
        .aw_tag(p_0_aw_tag),
        .aw_addr(p_0_aw_addr),
        .aw_bytes(p_0_aw_bytes),
        .aw_rows(p_0_aw_rows),
        .aw_stride(p_0_aw_stride),
        .aw_first(p_0_aw_first),
        .aw_last(p_0_aw_last),
        .rd_v(u_ing_0_rd_v),
        .rd_nz(u_ing_0_rd_nz),
        .rd_n1(u_ing_0_rd_n1),
        .rd_nm(u_ing_0_rd_nm),
        .rd_psh(u_ing_0_rd_psh),
        .rd_pop(u_ing_0_rd_pop),
        .rd_loc(u_ing_0_rd_loc),
        .rd_id(u_ing_0_rd_id),
        .rd_tag(u_ing_0_rd_tag),
        .rd_addr(u_ing_0_rd_addr),
        .rd_bytes(u_ing_0_rd_bytes),
        .rd_rows(u_ing_0_rd_rows),
        .rd_stride(u_ing_0_rd_stride),
        .wr_v(u_ing_0_wr_v),
        .wr_nz(u_ing_0_wr_nz),
        .wr_n1(u_ing_0_wr_n1),
        .wr_nm(u_ing_0_wr_nm),
        .wr_psh(u_ing_0_wr_psh),
        .wr_pop(u_ing_0_wr_pop),
        .wr_loc(u_ing_0_wr_loc),
        .wr_id(u_ing_0_wr_id),
        .wr_tag(u_ing_0_wr_tag),
        .wr_addr(u_ing_0_wr_addr),
        .wr_bytes(u_ing_0_wr_bytes),
        .wr_rows(u_ing_0_wr_rows),
        .wr_stride(u_ing_0_wr_stride),
        .occ(u_ing_0_occ)
    );
    NocIngress u_ing_1 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_1_ar_valid),
        .ar_ready(p_1_ar_ready),
        .ar_id(p_1_ar_id),
        .ar_tag(p_1_ar_tag),
        .ar_addr(p_1_ar_addr),
        .ar_bytes(p_1_ar_bytes),
        .ar_rows(p_1_ar_rows),
        .ar_stride(p_1_ar_stride),
        .ar_first(p_1_ar_first),
        .ar_last(p_1_ar_last),
        .aw_valid(p_1_aw_valid),
        .aw_ready(p_1_aw_ready),
        .aw_id(p_1_aw_id),
        .aw_tag(p_1_aw_tag),
        .aw_addr(p_1_aw_addr),
        .aw_bytes(p_1_aw_bytes),
        .aw_rows(p_1_aw_rows),
        .aw_stride(p_1_aw_stride),
        .aw_first(p_1_aw_first),
        .aw_last(p_1_aw_last),
        .rd_v(u_ing_1_rd_v),
        .rd_nz(u_ing_1_rd_nz),
        .rd_n1(u_ing_1_rd_n1),
        .rd_nm(u_ing_1_rd_nm),
        .rd_psh(u_ing_1_rd_psh),
        .rd_pop(u_ing_1_rd_pop),
        .rd_loc(u_ing_1_rd_loc),
        .rd_id(u_ing_1_rd_id),
        .rd_tag(u_ing_1_rd_tag),
        .rd_addr(u_ing_1_rd_addr),
        .rd_bytes(u_ing_1_rd_bytes),
        .rd_rows(u_ing_1_rd_rows),
        .rd_stride(u_ing_1_rd_stride),
        .wr_v(u_ing_1_wr_v),
        .wr_nz(u_ing_1_wr_nz),
        .wr_n1(u_ing_1_wr_n1),
        .wr_nm(u_ing_1_wr_nm),
        .wr_psh(u_ing_1_wr_psh),
        .wr_pop(u_ing_1_wr_pop),
        .wr_loc(u_ing_1_wr_loc),
        .wr_id(u_ing_1_wr_id),
        .wr_tag(u_ing_1_wr_tag),
        .wr_addr(u_ing_1_wr_addr),
        .wr_bytes(u_ing_1_wr_bytes),
        .wr_rows(u_ing_1_wr_rows),
        .wr_stride(u_ing_1_wr_stride),
        .occ(u_ing_1_occ)
    );
    NocIngress u_ing_2 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_2_ar_valid),
        .ar_ready(p_2_ar_ready),
        .ar_id(p_2_ar_id),
        .ar_tag(p_2_ar_tag),
        .ar_addr(p_2_ar_addr),
        .ar_bytes(p_2_ar_bytes),
        .ar_rows(p_2_ar_rows),
        .ar_stride(p_2_ar_stride),
        .ar_first(p_2_ar_first),
        .ar_last(p_2_ar_last),
        .aw_valid(p_2_aw_valid),
        .aw_ready(p_2_aw_ready),
        .aw_id(p_2_aw_id),
        .aw_tag(p_2_aw_tag),
        .aw_addr(p_2_aw_addr),
        .aw_bytes(p_2_aw_bytes),
        .aw_rows(p_2_aw_rows),
        .aw_stride(p_2_aw_stride),
        .aw_first(p_2_aw_first),
        .aw_last(p_2_aw_last),
        .rd_v(u_ing_2_rd_v),
        .rd_nz(u_ing_2_rd_nz),
        .rd_n1(u_ing_2_rd_n1),
        .rd_nm(u_ing_2_rd_nm),
        .rd_psh(u_ing_2_rd_psh),
        .rd_pop(u_ing_2_rd_pop),
        .rd_loc(u_ing_2_rd_loc),
        .rd_id(u_ing_2_rd_id),
        .rd_tag(u_ing_2_rd_tag),
        .rd_addr(u_ing_2_rd_addr),
        .rd_bytes(u_ing_2_rd_bytes),
        .rd_rows(u_ing_2_rd_rows),
        .rd_stride(u_ing_2_rd_stride),
        .wr_v(u_ing_2_wr_v),
        .wr_nz(u_ing_2_wr_nz),
        .wr_n1(u_ing_2_wr_n1),
        .wr_nm(u_ing_2_wr_nm),
        .wr_psh(u_ing_2_wr_psh),
        .wr_pop(u_ing_2_wr_pop),
        .wr_loc(u_ing_2_wr_loc),
        .wr_id(u_ing_2_wr_id),
        .wr_tag(u_ing_2_wr_tag),
        .wr_addr(u_ing_2_wr_addr),
        .wr_bytes(u_ing_2_wr_bytes),
        .wr_rows(u_ing_2_wr_rows),
        .wr_stride(u_ing_2_wr_stride),
        .occ(u_ing_2_occ)
    );
    NocIngress u_ing_3 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_3_ar_valid),
        .ar_ready(p_3_ar_ready),
        .ar_id(p_3_ar_id),
        .ar_tag(p_3_ar_tag),
        .ar_addr(p_3_ar_addr),
        .ar_bytes(p_3_ar_bytes),
        .ar_rows(p_3_ar_rows),
        .ar_stride(p_3_ar_stride),
        .ar_first(p_3_ar_first),
        .ar_last(p_3_ar_last),
        .aw_valid(p_3_aw_valid),
        .aw_ready(p_3_aw_ready),
        .aw_id(p_3_aw_id),
        .aw_tag(p_3_aw_tag),
        .aw_addr(p_3_aw_addr),
        .aw_bytes(p_3_aw_bytes),
        .aw_rows(p_3_aw_rows),
        .aw_stride(p_3_aw_stride),
        .aw_first(p_3_aw_first),
        .aw_last(p_3_aw_last),
        .rd_v(u_ing_3_rd_v),
        .rd_nz(u_ing_3_rd_nz),
        .rd_n1(u_ing_3_rd_n1),
        .rd_nm(u_ing_3_rd_nm),
        .rd_psh(u_ing_3_rd_psh),
        .rd_pop(u_ing_3_rd_pop),
        .rd_loc(u_ing_3_rd_loc),
        .rd_id(u_ing_3_rd_id),
        .rd_tag(u_ing_3_rd_tag),
        .rd_addr(u_ing_3_rd_addr),
        .rd_bytes(u_ing_3_rd_bytes),
        .rd_rows(u_ing_3_rd_rows),
        .rd_stride(u_ing_3_rd_stride),
        .wr_v(u_ing_3_wr_v),
        .wr_nz(u_ing_3_wr_nz),
        .wr_n1(u_ing_3_wr_n1),
        .wr_nm(u_ing_3_wr_nm),
        .wr_psh(u_ing_3_wr_psh),
        .wr_pop(u_ing_3_wr_pop),
        .wr_loc(u_ing_3_wr_loc),
        .wr_id(u_ing_3_wr_id),
        .wr_tag(u_ing_3_wr_tag),
        .wr_addr(u_ing_3_wr_addr),
        .wr_bytes(u_ing_3_wr_bytes),
        .wr_rows(u_ing_3_wr_rows),
        .wr_stride(u_ing_3_wr_stride),
        .occ(u_ing_3_occ)
    );
    NocIngress u_ing_4 (
        .clk(clk),
        .rst_n(rst_n),
        .ar_valid(p_4_ar_valid),
        .ar_ready(p_4_ar_ready),
        .ar_id(p_4_ar_id),
        .ar_tag(p_4_ar_tag),
        .ar_addr(p_4_ar_addr),
        .ar_bytes(p_4_ar_bytes),
        .ar_rows(p_4_ar_rows),
        .ar_stride(p_4_ar_stride),
        .ar_first(p_4_ar_first),
        .ar_last(p_4_ar_last),
        .aw_valid(p_4_aw_valid),
        .aw_ready(p_4_aw_ready),
        .aw_id(p_4_aw_id),
        .aw_tag(p_4_aw_tag),
        .aw_addr(p_4_aw_addr),
        .aw_bytes(p_4_aw_bytes),
        .aw_rows(p_4_aw_rows),
        .aw_stride(p_4_aw_stride),
        .aw_first(p_4_aw_first),
        .aw_last(p_4_aw_last),
        .rd_v(u_ing_4_rd_v),
        .rd_nz(u_ing_4_rd_nz),
        .rd_n1(u_ing_4_rd_n1),
        .rd_nm(u_ing_4_rd_nm),
        .rd_psh(u_ing_4_rd_psh),
        .rd_pop(u_ing_4_rd_pop),
        .rd_loc(u_ing_4_rd_loc),
        .rd_id(u_ing_4_rd_id),
        .rd_tag(u_ing_4_rd_tag),
        .rd_addr(u_ing_4_rd_addr),
        .rd_bytes(u_ing_4_rd_bytes),
        .rd_rows(u_ing_4_rd_rows),
        .rd_stride(u_ing_4_rd_stride),
        .wr_v(u_ing_4_wr_v),
        .wr_nz(u_ing_4_wr_nz),
        .wr_n1(u_ing_4_wr_n1),
        .wr_nm(u_ing_4_wr_nm),
        .wr_psh(u_ing_4_wr_psh),
        .wr_pop(u_ing_4_wr_pop),
        .wr_loc(u_ing_4_wr_loc),
        .wr_id(u_ing_4_wr_id),
        .wr_tag(u_ing_4_wr_tag),
        .wr_addr(u_ing_4_wr_addr),
        .wr_bytes(u_ing_4_wr_bytes),
        .wr_rows(u_ing_4_wr_rows),
        .wr_stride(u_ing_4_wr_stride),
        .occ(u_ing_4_occ)
    );
    NocEntrance u_ent (
        .clk(clk),
        .rst_n(rst_n),
        .rd_0_v(u_ing_0_rd_v),
        .rd_0_nz(u_ing_0_rd_nz),
        .rd_0_n1(u_ing_0_rd_n1),
        .rd_0_nm(u_ing_0_rd_nm),
        .rd_0_psh(u_ing_0_rd_psh),
        .rd_0_pop(u_ing_0_rd_pop),
        .rd_0_loc(u_ing_0_rd_loc),
        .rd_0_id(u_ing_0_rd_id),
        .rd_0_tag(u_ing_0_rd_tag),
        .rd_0_addr(u_ing_0_rd_addr),
        .rd_0_bytes(u_ing_0_rd_bytes),
        .rd_0_rows(u_ing_0_rd_rows),
        .rd_0_stride(u_ing_0_rd_stride),
        .rd_1_v(u_ing_1_rd_v),
        .rd_1_nz(u_ing_1_rd_nz),
        .rd_1_n1(u_ing_1_rd_n1),
        .rd_1_nm(u_ing_1_rd_nm),
        .rd_1_psh(u_ing_1_rd_psh),
        .rd_1_pop(u_ing_1_rd_pop),
        .rd_1_loc(u_ing_1_rd_loc),
        .rd_1_id(u_ing_1_rd_id),
        .rd_1_tag(u_ing_1_rd_tag),
        .rd_1_addr(u_ing_1_rd_addr),
        .rd_1_bytes(u_ing_1_rd_bytes),
        .rd_1_rows(u_ing_1_rd_rows),
        .rd_1_stride(u_ing_1_rd_stride),
        .rd_2_v(u_ing_2_rd_v),
        .rd_2_nz(u_ing_2_rd_nz),
        .rd_2_n1(u_ing_2_rd_n1),
        .rd_2_nm(u_ing_2_rd_nm),
        .rd_2_psh(u_ing_2_rd_psh),
        .rd_2_pop(u_ing_2_rd_pop),
        .rd_2_loc(u_ing_2_rd_loc),
        .rd_2_id(u_ing_2_rd_id),
        .rd_2_tag(u_ing_2_rd_tag),
        .rd_2_addr(u_ing_2_rd_addr),
        .rd_2_bytes(u_ing_2_rd_bytes),
        .rd_2_rows(u_ing_2_rd_rows),
        .rd_2_stride(u_ing_2_rd_stride),
        .rd_3_v(u_ing_3_rd_v),
        .rd_3_nz(u_ing_3_rd_nz),
        .rd_3_n1(u_ing_3_rd_n1),
        .rd_3_nm(u_ing_3_rd_nm),
        .rd_3_psh(u_ing_3_rd_psh),
        .rd_3_pop(u_ing_3_rd_pop),
        .rd_3_loc(u_ing_3_rd_loc),
        .rd_3_id(u_ing_3_rd_id),
        .rd_3_tag(u_ing_3_rd_tag),
        .rd_3_addr(u_ing_3_rd_addr),
        .rd_3_bytes(u_ing_3_rd_bytes),
        .rd_3_rows(u_ing_3_rd_rows),
        .rd_3_stride(u_ing_3_rd_stride),
        .rd_4_v(u_ing_4_rd_v),
        .rd_4_nz(u_ing_4_rd_nz),
        .rd_4_n1(u_ing_4_rd_n1),
        .rd_4_nm(u_ing_4_rd_nm),
        .rd_4_psh(u_ing_4_rd_psh),
        .rd_4_pop(u_ing_4_rd_pop),
        .rd_4_loc(u_ing_4_rd_loc),
        .rd_4_id(u_ing_4_rd_id),
        .rd_4_tag(u_ing_4_rd_tag),
        .rd_4_addr(u_ing_4_rd_addr),
        .rd_4_bytes(u_ing_4_rd_bytes),
        .rd_4_rows(u_ing_4_rd_rows),
        .rd_4_stride(u_ing_4_rd_stride),
        .wr_0_v(u_ing_0_wr_v),
        .wr_0_nz(u_ing_0_wr_nz),
        .wr_0_n1(u_ing_0_wr_n1),
        .wr_0_nm(u_ing_0_wr_nm),
        .wr_0_psh(u_ing_0_wr_psh),
        .wr_0_pop(u_ing_0_wr_pop),
        .wr_0_loc(u_ing_0_wr_loc),
        .wr_0_id(u_ing_0_wr_id),
        .wr_0_tag(u_ing_0_wr_tag),
        .wr_0_addr(u_ing_0_wr_addr),
        .wr_0_bytes(u_ing_0_wr_bytes),
        .wr_0_rows(u_ing_0_wr_rows),
        .wr_0_stride(u_ing_0_wr_stride),
        .wr_1_v(u_ing_1_wr_v),
        .wr_1_nz(u_ing_1_wr_nz),
        .wr_1_n1(u_ing_1_wr_n1),
        .wr_1_nm(u_ing_1_wr_nm),
        .wr_1_psh(u_ing_1_wr_psh),
        .wr_1_pop(u_ing_1_wr_pop),
        .wr_1_loc(u_ing_1_wr_loc),
        .wr_1_id(u_ing_1_wr_id),
        .wr_1_tag(u_ing_1_wr_tag),
        .wr_1_addr(u_ing_1_wr_addr),
        .wr_1_bytes(u_ing_1_wr_bytes),
        .wr_1_rows(u_ing_1_wr_rows),
        .wr_1_stride(u_ing_1_wr_stride),
        .wr_2_v(u_ing_2_wr_v),
        .wr_2_nz(u_ing_2_wr_nz),
        .wr_2_n1(u_ing_2_wr_n1),
        .wr_2_nm(u_ing_2_wr_nm),
        .wr_2_psh(u_ing_2_wr_psh),
        .wr_2_pop(u_ing_2_wr_pop),
        .wr_2_loc(u_ing_2_wr_loc),
        .wr_2_id(u_ing_2_wr_id),
        .wr_2_tag(u_ing_2_wr_tag),
        .wr_2_addr(u_ing_2_wr_addr),
        .wr_2_bytes(u_ing_2_wr_bytes),
        .wr_2_rows(u_ing_2_wr_rows),
        .wr_2_stride(u_ing_2_wr_stride),
        .wr_3_v(u_ing_3_wr_v),
        .wr_3_nz(u_ing_3_wr_nz),
        .wr_3_n1(u_ing_3_wr_n1),
        .wr_3_nm(u_ing_3_wr_nm),
        .wr_3_psh(u_ing_3_wr_psh),
        .wr_3_pop(u_ing_3_wr_pop),
        .wr_3_loc(u_ing_3_wr_loc),
        .wr_3_id(u_ing_3_wr_id),
        .wr_3_tag(u_ing_3_wr_tag),
        .wr_3_addr(u_ing_3_wr_addr),
        .wr_3_bytes(u_ing_3_wr_bytes),
        .wr_3_rows(u_ing_3_wr_rows),
        .wr_3_stride(u_ing_3_wr_stride),
        .wr_4_v(u_ing_4_wr_v),
        .wr_4_nz(u_ing_4_wr_nz),
        .wr_4_n1(u_ing_4_wr_n1),
        .wr_4_nm(u_ing_4_wr_nm),
        .wr_4_psh(u_ing_4_wr_psh),
        .wr_4_pop(u_ing_4_wr_pop),
        .wr_4_loc(u_ing_4_wr_loc),
        .wr_4_id(u_ing_4_wr_id),
        .wr_4_tag(u_ing_4_wr_tag),
        .wr_4_addr(u_ing_4_wr_addr),
        .wr_4_bytes(u_ing_4_wr_bytes),
        .wr_4_rows(u_ing_4_wr_rows),
        .wr_4_stride(u_ing_4_wr_stride),
        .a_0_valid(p_0_a_valid),
        .a_0_id(p_0_a_id),
        .a_0_tag(p_0_a_tag),
        .a_1_valid(p_1_a_valid),
        .a_1_id(p_1_a_id),
        .a_1_tag(p_1_a_tag),
        .a_2_valid(p_2_a_valid),
        .a_2_id(p_2_a_id),
        .a_2_tag(p_2_a_tag),
        .a_3_valid(p_3_a_valid),
        .a_3_id(p_3_a_id),
        .a_3_tag(p_3_a_tag),
        .a_4_valid(p_4_a_valid),
        .a_4_id(p_4_a_id),
        .a_4_tag(p_4_a_tag),
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
        .r_3_valid(p_3_r_valid),
        .r_3_ready(p_3_r_ready),
        .r_3_data(p_3_r_data),
        .r_3_id(p_3_r_id),
        .r_3_tag(p_3_r_tag),
        .r_3_last(p_3_r_last),
        .r_4_valid(p_4_r_valid),
        .r_4_ready(p_4_r_ready),
        .r_4_data(p_4_r_data),
        .r_4_id(p_4_r_id),
        .r_4_tag(p_4_r_tag),
        .r_4_last(p_4_r_last),
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
        .b_3_valid(p_3_b_valid),
        .b_3_ready(p_3_b_ready),
        .b_3_id(p_3_b_id),
        .b_3_tag(p_3_b_tag),
        .b_4_valid(p_4_b_valid),
        .b_4_ready(p_4_b_ready),
        .b_4_id(p_4_b_id),
        .b_4_tag(p_4_b_tag),
        .st_req(u_agg_st_req),
        .st_fill(u_agg_st_fill),
        .st_wt(u_agg_st_wt),
        .agg_b_ok0(u_ent_agg_b_ok0),
        .agg_b_ok1(u_ent_agg_b_ok1),
        .agg_b_ok2(u_ent_agg_b_ok2),
        .agg_b_ok3(u_ent_agg_b_ok3),
        .agg_b_ok4(u_ent_agg_b_ok4),
        .agg_rq0_push(u_ent_agg_rq0_push),
        .agg_rq0_tk(u_ent_agg_rq0_tk),
        .agg_rq0_addr(u_ent_agg_rq0_addr),
        .agg_rq0_slot(u_ent_agg_rq0_slot),
        .agg_rq0_ok(u_ent_agg_rq0_ok),
        .agg_rq1_push(u_ent_agg_rq1_push),
        .agg_rq1_tk(u_ent_agg_rq1_tk),
        .agg_rq1_addr(u_ent_agg_rq1_addr),
        .agg_rq1_slot(u_ent_agg_rq1_slot),
        .agg_rq1_ok(u_ent_agg_rq1_ok),
        .agg_rq2_push(u_ent_agg_rq2_push),
        .agg_rq2_tk(u_ent_agg_rq2_tk),
        .agg_rq2_addr(u_ent_agg_rq2_addr),
        .agg_rq2_slot(u_ent_agg_rq2_slot),
        .agg_rq2_ok(u_ent_agg_rq2_ok),
        .agg_rq3_push(u_ent_agg_rq3_push),
        .agg_rq3_tk(u_ent_agg_rq3_tk),
        .agg_rq3_addr(u_ent_agg_rq3_addr),
        .agg_rq3_slot(u_ent_agg_rq3_slot),
        .agg_rq3_ok(u_ent_agg_rq3_ok),
        .agg_wq_push(u_ent_agg_wq_push),
        .agg_wq_m(u_ent_agg_wq_m),
        .agg_wq_wid(u_ent_agg_wq_wid),
        .agg_wq_addr(u_ent_agg_wq_addr),
        .agg_wq_eoff(u_ent_agg_wq_eoff),
        .agg_wq_last(u_ent_agg_wq_last),
        .agg_wq_tag(u_ent_agg_wq_tag),
        .agg_wq_loc(u_ent_agg_wq_loc),
        .agg_wq_ok(u_ent_agg_wq_ok),
        .agg_ra_en(u_ent_agg_ra_en),
        .agg_ra_addr(u_ent_agg_ra_addr),
        .agg_ra_data(u_ent_agg_ra_data),
        .agg_rb_en(u_ent_agg_rb_en),
        .agg_rb_addr(u_ent_agg_rb_addr),
        .agg_rb_data(u_ent_agg_rb_data),
        .agg_ed0_v(u_ent_agg_ed0_v),
        .agg_ed0_slot(u_ent_agg_ed0_slot),
        .agg_ed1_v(u_ent_agg_ed1_v),
        .agg_ed1_slot(u_ent_agg_ed1_slot),
        .agg_asm_ok0_c0(u_ent_agg_asm_ok0_c0),
        .agg_asm_s0_c0(u_ent_agg_asm_s0_c0),
        .agg_asm_ok1_c0(u_ent_agg_asm_ok1_c0),
        .agg_asm_s1_c0(u_ent_agg_asm_s1_c0),
        .agg_asm_ok0_c1(u_ent_agg_asm_ok0_c1),
        .agg_asm_s0_c1(u_ent_agg_asm_s0_c1),
        .agg_asm_ok1_c1(u_ent_agg_asm_ok1_c1),
        .agg_asm_s1_c1(u_ent_agg_asm_s1_c1),
        .agg_asm_rv0(u_ent_agg_asm_rv0),
        .agg_asm_rv1(u_ent_agg_asm_rv1),
        .agg_asm_pa_c0(u_ent_agg_asm_pa_c0),
        .agg_asm_pa_c1(u_ent_agg_asm_pa_c1),
        .agg_asm_pb_c0(u_ent_agg_asm_pb_c0),
        .agg_asm_pb_c1(u_ent_agg_asm_pb_c1),
        .agg_wk0_v(u_ent_agg_wk0_v),
        .agg_wk0_tk(u_ent_agg_wk0_tk),
        .agg_wk0_asl(u_ent_agg_wk0_asl),
        .agg_wk1_v(u_ent_agg_wk1_v),
        .agg_wk1_tk(u_ent_agg_wk1_tk),
        .agg_wk1_asl(u_ent_agg_wk1_asl),
        .agg_bev_v(u_ent_agg_bev_v),
        .agg_bev_m(u_ent_agg_bev_m),
        .agg_bev_wid(u_ent_agg_bev_wid),
        .agg_bev_tag(u_ent_agg_bev_tag),
        .agg_bev_loc(u_ent_agg_bev_loc),
        .dbg_pend_write(u_ent_dbg_pend_write),
        .dbg_admit(u_ent_dbg_admit),
        .dbg_port_stall(u_ent_dbg_port_stall),
        .dbg_win_occ(u_ent_dbg_win_occ),
        .dbg_asm_blk(u_ent_dbg_asm_blk),
        .dbg_idle(u_ent_dbg_idle)
    );
    NocAgg u_agg (
        .clk(clk),
        .rst_n(rst_n),
        .stat_clr_all(stat_clr_all),
        .ent_b_ok0(u_ent_agg_b_ok0),
        .ent_b_ok1(u_ent_agg_b_ok1),
        .ent_b_ok2(u_ent_agg_b_ok2),
        .ent_b_ok3(u_ent_agg_b_ok3),
        .ent_b_ok4(u_ent_agg_b_ok4),
        .ent_rq0_push(u_ent_agg_rq0_push),
        .ent_rq0_tk(u_ent_agg_rq0_tk),
        .ent_rq0_addr(u_ent_agg_rq0_addr),
        .ent_rq0_slot(u_ent_agg_rq0_slot),
        .ent_rq0_ok(u_ent_agg_rq0_ok),
        .ent_rq1_push(u_ent_agg_rq1_push),
        .ent_rq1_tk(u_ent_agg_rq1_tk),
        .ent_rq1_addr(u_ent_agg_rq1_addr),
        .ent_rq1_slot(u_ent_agg_rq1_slot),
        .ent_rq1_ok(u_ent_agg_rq1_ok),
        .ent_rq2_push(u_ent_agg_rq2_push),
        .ent_rq2_tk(u_ent_agg_rq2_tk),
        .ent_rq2_addr(u_ent_agg_rq2_addr),
        .ent_rq2_slot(u_ent_agg_rq2_slot),
        .ent_rq2_ok(u_ent_agg_rq2_ok),
        .ent_rq3_push(u_ent_agg_rq3_push),
        .ent_rq3_tk(u_ent_agg_rq3_tk),
        .ent_rq3_addr(u_ent_agg_rq3_addr),
        .ent_rq3_slot(u_ent_agg_rq3_slot),
        .ent_rq3_ok(u_ent_agg_rq3_ok),
        .ent_wq_push(u_ent_agg_wq_push),
        .ent_wq_m(u_ent_agg_wq_m),
        .ent_wq_wid(u_ent_agg_wq_wid),
        .ent_wq_addr(u_ent_agg_wq_addr),
        .ent_wq_eoff(u_ent_agg_wq_eoff),
        .ent_wq_last(u_ent_agg_wq_last),
        .ent_wq_tag(u_ent_agg_wq_tag),
        .ent_wq_loc(u_ent_agg_wq_loc),
        .ent_wq_ok(u_ent_agg_wq_ok),
        .ent_ra_en(u_ent_agg_ra_en),
        .ent_ra_addr(u_ent_agg_ra_addr),
        .ent_ra_data(u_ent_agg_ra_data),
        .ent_rb_en(u_ent_agg_rb_en),
        .ent_rb_addr(u_ent_agg_rb_addr),
        .ent_rb_data(u_ent_agg_rb_data),
        .ent_ed0_v(u_ent_agg_ed0_v),
        .ent_ed0_slot(u_ent_agg_ed0_slot),
        .ent_ed1_v(u_ent_agg_ed1_v),
        .ent_ed1_slot(u_ent_agg_ed1_slot),
        .ent_asm_ok0_c0(u_ent_agg_asm_ok0_c0),
        .ent_asm_s0_c0(u_ent_agg_asm_s0_c0),
        .ent_asm_ok1_c0(u_ent_agg_asm_ok1_c0),
        .ent_asm_s1_c0(u_ent_agg_asm_s1_c0),
        .ent_asm_ok0_c1(u_ent_agg_asm_ok0_c1),
        .ent_asm_s0_c1(u_ent_agg_asm_s0_c1),
        .ent_asm_ok1_c1(u_ent_agg_asm_ok1_c1),
        .ent_asm_s1_c1(u_ent_agg_asm_s1_c1),
        .ent_asm_rv0(u_ent_agg_asm_rv0),
        .ent_asm_rv1(u_ent_agg_asm_rv1),
        .ent_asm_pa_c0(u_ent_agg_asm_pa_c0),
        .ent_asm_pa_c1(u_ent_agg_asm_pa_c1),
        .ent_asm_pb_c0(u_ent_agg_asm_pb_c0),
        .ent_asm_pb_c1(u_ent_agg_asm_pb_c1),
        .ent_wk0_v(u_ent_agg_wk0_v),
        .ent_wk0_tk(u_ent_agg_wk0_tk),
        .ent_wk0_asl(u_ent_agg_wk0_asl),
        .ent_wk1_v(u_ent_agg_wk1_v),
        .ent_wk1_tk(u_ent_agg_wk1_tk),
        .ent_wk1_asl(u_ent_agg_wk1_asl),
        .ent_bev_v(u_ent_agg_bev_v),
        .ent_bev_m(u_ent_agg_bev_m),
        .ent_bev_wid(u_ent_agg_bev_wid),
        .ent_bev_tag(u_ent_agg_bev_tag),
        .ent_bev_loc(u_ent_agg_bev_loc),
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
        .w_3_valid(p_3_w_valid),
        .w_3_id(p_3_w_id),
        .w_3_data(p_3_w_data),
        .w_3_strb(p_3_w_strb),
        .w_3_ready(p_3_w_ready),
        .w_4_valid(p_4_w_valid),
        .w_4_id(p_4_w_id),
        .w_4_data(p_4_w_data),
        .w_4_strb(p_4_w_strb),
        .w_4_ready(p_4_w_ready),
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
        .st_req(u_agg_st_req),
        .st_fill(u_agg_st_fill),
        .st_wt(u_agg_st_wt),
        .dbg_infl_occ(u_agg_dbg_infl_occ),
        .dbg_rd_out(u_agg_dbg_rd_out),
        .dbg_lane_busy(u_agg_dbg_lane_busy),
        .dbg_asm_occ(u_agg_dbg_asm_occ),
        .dbg_idle(u_agg_dbg_idle)
    );
endmodule
