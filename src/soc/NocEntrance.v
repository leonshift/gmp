module NocEntrance (
    input clk,
    input rst_n,
    input rd_0_v,
    input rd_0_nz,
    input rd_0_n1,
    input rd_0_nm,
    input rd_0_psh,
    output logic rd_0_pop,
    input rd_0_loc,
    input [3:0] rd_0_id,
    input [15:0] rd_0_tag,
    input [47:0] rd_0_addr,
    input [19:0] rd_0_bytes,
    input [15:0] rd_0_rows,
    input [19:0] rd_0_stride,
    input rd_1_v,
    input rd_1_nz,
    input rd_1_n1,
    input rd_1_nm,
    input rd_1_psh,
    output logic rd_1_pop,
    input rd_1_loc,
    input [3:0] rd_1_id,
    input [15:0] rd_1_tag,
    input [47:0] rd_1_addr,
    input [19:0] rd_1_bytes,
    input [15:0] rd_1_rows,
    input [19:0] rd_1_stride,
    input rd_2_v,
    input rd_2_nz,
    input rd_2_n1,
    input rd_2_nm,
    input rd_2_psh,
    output logic rd_2_pop,
    input rd_2_loc,
    input [3:0] rd_2_id,
    input [15:0] rd_2_tag,
    input [47:0] rd_2_addr,
    input [19:0] rd_2_bytes,
    input [15:0] rd_2_rows,
    input [19:0] rd_2_stride,
    input rd_3_v,
    input rd_3_nz,
    input rd_3_n1,
    input rd_3_nm,
    input rd_3_psh,
    output logic rd_3_pop,
    input rd_3_loc,
    input [3:0] rd_3_id,
    input [15:0] rd_3_tag,
    input [47:0] rd_3_addr,
    input [19:0] rd_3_bytes,
    input [15:0] rd_3_rows,
    input [19:0] rd_3_stride,
    input rd_4_v,
    input rd_4_nz,
    input rd_4_n1,
    input rd_4_nm,
    input rd_4_psh,
    output logic rd_4_pop,
    input rd_4_loc,
    input [3:0] rd_4_id,
    input [15:0] rd_4_tag,
    input [47:0] rd_4_addr,
    input [19:0] rd_4_bytes,
    input [15:0] rd_4_rows,
    input [19:0] rd_4_stride,
    input wr_0_v,
    input wr_0_nz,
    input wr_0_n1,
    input wr_0_nm,
    input wr_0_psh,
    output logic wr_0_pop,
    input wr_0_loc,
    input [3:0] wr_0_id,
    input [15:0] wr_0_tag,
    input [47:0] wr_0_addr,
    input [19:0] wr_0_bytes,
    input [15:0] wr_0_rows,
    input [19:0] wr_0_stride,
    input wr_1_v,
    input wr_1_nz,
    input wr_1_n1,
    input wr_1_nm,
    input wr_1_psh,
    output logic wr_1_pop,
    input wr_1_loc,
    input [3:0] wr_1_id,
    input [15:0] wr_1_tag,
    input [47:0] wr_1_addr,
    input [19:0] wr_1_bytes,
    input [15:0] wr_1_rows,
    input [19:0] wr_1_stride,
    input wr_2_v,
    input wr_2_nz,
    input wr_2_n1,
    input wr_2_nm,
    input wr_2_psh,
    output logic wr_2_pop,
    input wr_2_loc,
    input [3:0] wr_2_id,
    input [15:0] wr_2_tag,
    input [47:0] wr_2_addr,
    input [19:0] wr_2_bytes,
    input [15:0] wr_2_rows,
    input [19:0] wr_2_stride,
    input wr_3_v,
    input wr_3_nz,
    input wr_3_n1,
    input wr_3_nm,
    input wr_3_psh,
    output logic wr_3_pop,
    input wr_3_loc,
    input [3:0] wr_3_id,
    input [15:0] wr_3_tag,
    input [47:0] wr_3_addr,
    input [19:0] wr_3_bytes,
    input [15:0] wr_3_rows,
    input [19:0] wr_3_stride,
    input wr_4_v,
    input wr_4_nz,
    input wr_4_n1,
    input wr_4_nm,
    input wr_4_psh,
    output logic wr_4_pop,
    input wr_4_loc,
    input [3:0] wr_4_id,
    input [15:0] wr_4_tag,
    input [47:0] wr_4_addr,
    input [19:0] wr_4_bytes,
    input [15:0] wr_4_rows,
    input [19:0] wr_4_stride,
    output logic a_0_valid,
    output logic [3:0] a_0_id,
    output logic [15:0] a_0_tag,
    output logic a_1_valid,
    output logic [3:0] a_1_id,
    output logic [15:0] a_1_tag,
    output logic a_2_valid,
    output logic [3:0] a_2_id,
    output logic [15:0] a_2_tag,
    output logic a_3_valid,
    output logic [3:0] a_3_id,
    output logic [15:0] a_3_tag,
    output logic a_4_valid,
    output logic [3:0] a_4_id,
    output logic [15:0] a_4_tag,
    output logic r_0_valid,
    input r_0_ready,
    output logic [1023:0] r_0_data,
    output logic [3:0] r_0_id,
    output logic [15:0] r_0_tag,
    output logic r_0_last,
    output logic r_1_valid,
    input r_1_ready,
    output logic [511:0] r_1_data,
    output logic [3:0] r_1_id,
    output logic [15:0] r_1_tag,
    output logic r_1_last,
    output logic r_2_valid,
    input r_2_ready,
    output logic [1023:0] r_2_data,
    output logic [3:0] r_2_id,
    output logic [15:0] r_2_tag,
    output logic r_2_last,
    output logic r_3_valid,
    input r_3_ready,
    output logic [1023:0] r_3_data,
    output logic [3:0] r_3_id,
    output logic [15:0] r_3_tag,
    output logic r_3_last,
    output logic r_4_valid,
    input r_4_ready,
    output logic [1023:0] r_4_data,
    output logic [3:0] r_4_id,
    output logic [15:0] r_4_tag,
    output logic r_4_last,
    output logic b_0_valid,
    input b_0_ready,
    output logic [3:0] b_0_id,
    output logic [15:0] b_0_tag,
    output logic b_1_valid,
    input b_1_ready,
    output logic [3:0] b_1_id,
    output logic [15:0] b_1_tag,
    output logic b_2_valid,
    input b_2_ready,
    output logic [3:0] b_2_id,
    output logic [15:0] b_2_tag,
    output logic b_3_valid,
    input b_3_ready,
    output logic [3:0] b_3_id,
    output logic [15:0] b_3_tag,
    output logic b_4_valid,
    input b_4_ready,
    output logic [3:0] b_4_id,
    output logic [15:0] b_4_tag,
    output logic agg_b_ok0,
    output logic agg_b_ok1,
    output logic agg_b_ok2,
    output logic agg_b_ok3,
    output logic agg_b_ok4,
    output logic agg_rq0_push,
    output logic [7:0] agg_rq0_tk,
    output logic [47:0] agg_rq0_addr,
    output logic [4:0] agg_rq0_slot,
    input agg_rq0_ok,
    output logic agg_rq1_push,
    output logic [7:0] agg_rq1_tk,
    output logic [47:0] agg_rq1_addr,
    output logic [4:0] agg_rq1_slot,
    input agg_rq1_ok,
    output logic agg_rq2_push,
    output logic [7:0] agg_rq2_tk,
    output logic [47:0] agg_rq2_addr,
    output logic [4:0] agg_rq2_slot,
    input agg_rq2_ok,
    output logic agg_rq3_push,
    output logic [7:0] agg_rq3_tk,
    output logic [47:0] agg_rq3_addr,
    output logic [4:0] agg_rq3_slot,
    input agg_rq3_ok,
    output logic agg_wq_push,
    output logic [2:0] agg_wq_m,
    output logic [3:0] agg_wq_wid,
    output logic [47:0] agg_wq_addr,
    output logic [8:0] agg_wq_eoff,
    output logic agg_wq_last,
    output logic [15:0] agg_wq_tag,
    output logic agg_wq_loc,
    input agg_wq_ok,
    output logic agg_ra_en,
    output logic [5:0] agg_ra_addr,
    input [1023:0] agg_ra_data,
    output logic agg_rb_en,
    output logic [5:0] agg_rb_addr,
    input [1023:0] agg_rb_data,
    output logic agg_ed0_v,
    output logic [4:0] agg_ed0_slot,
    output logic agg_ed1_v,
    output logic [4:0] agg_ed1_slot,
    input agg_asm_ok0_c0,
    input [4:0] agg_asm_s0_c0,
    input agg_asm_ok1_c0,
    input [4:0] agg_asm_s1_c0,
    input agg_asm_ok0_c1,
    input [4:0] agg_asm_s0_c1,
    input agg_asm_ok1_c1,
    input [4:0] agg_asm_s1_c1,
    output logic agg_asm_rv0,
    output logic agg_asm_rv1,
    output logic agg_asm_pa_c0,
    output logic agg_asm_pa_c1,
    output logic agg_asm_pb_c0,
    output logic agg_asm_pb_c1,
    input agg_wk0_v,
    input [7:0] agg_wk0_tk,
    input [4:0] agg_wk0_asl,
    input agg_wk1_v,
    input [7:0] agg_wk1_tk,
    input [4:0] agg_wk1_asl,
    input agg_bev_v,
    input [2:0] agg_bev_m,
    input [3:0] agg_bev_wid,
    input [15:0] agg_bev_tag,
    input agg_bev_loc,
    input [31:0] st_req,
    input [31:0] st_fill,
    input [31:0] st_wt,
    output logic [15:0] dbg_pend_write,
    output logic dbg_admit,
    output logic [3:0] dbg_port_stall,
    output logic dbg_idle,
    output logic [7:0] dbg_win_occ,
    output logic [15:0] dbg_asm_blk
);
    logic [3:0] raq_id_0 [0:7];
    logic [3:0] raq_id_1 [0:7];
    logic [3:0] raq_id_2 [0:7];
    logic [3:0] raq_id_3 [0:7];
    logic [3:0] raq_id_4 [0:7];
    logic [15:0] raq_tag_0 [0:7];
    logic [15:0] raq_tag_1 [0:7];
    logic [15:0] raq_tag_2 [0:7];
    logic [15:0] raq_tag_3 [0:7];
    logic [15:0] raq_tag_4 [0:7];
    logic [47:0] raq_addr_0 [0:7];
    logic [47:0] raq_addr_1 [0:7];
    logic [47:0] raq_addr_2 [0:7];
    logic [47:0] raq_addr_3 [0:7];
    logic [47:0] raq_addr_4 [0:7];
    logic [19:0] raq_bytes_0 [0:7];
    logic [19:0] raq_bytes_1 [0:7];
    logic [19:0] raq_bytes_2 [0:7];
    logic [19:0] raq_bytes_3 [0:7];
    logic [19:0] raq_bytes_4 [0:7];
    logic [15:0] raq_rows_0 [0:7];
    logic [15:0] raq_rows_1 [0:7];
    logic [15:0] raq_rows_2 [0:7];
    logic [15:0] raq_rows_3 [0:7];
    logic [15:0] raq_rows_4 [0:7];
    logic [19:0] raq_stride_0 [0:7];
    logic [19:0] raq_stride_1 [0:7];
    logic [19:0] raq_stride_2 [0:7];
    logic [19:0] raq_stride_3 [0:7];
    logic [19:0] raq_stride_4 [0:7];
    logic raq_loc_0 [0:7];
    logic raq_loc_1 [0:7];
    logic raq_loc_2 [0:7];
    logic raq_loc_3 [0:7];
    logic raq_loc_4 [0:7];
    logic [3:0] waq_id_0 [0:7];
    logic [3:0] waq_id_1 [0:7];
    logic [3:0] waq_id_2 [0:7];
    logic [3:0] waq_id_3 [0:7];
    logic [3:0] waq_id_4 [0:7];
    logic [15:0] waq_tag_0 [0:7];
    logic [15:0] waq_tag_1 [0:7];
    logic [15:0] waq_tag_2 [0:7];
    logic [15:0] waq_tag_3 [0:7];
    logic [15:0] waq_tag_4 [0:7];
    logic [47:0] waq_addr_0 [0:7];
    logic [47:0] waq_addr_1 [0:7];
    logic [47:0] waq_addr_2 [0:7];
    logic [47:0] waq_addr_3 [0:7];
    logic [47:0] waq_addr_4 [0:7];
    logic [19:0] waq_bytes_0 [0:7];
    logic [19:0] waq_bytes_1 [0:7];
    logic [19:0] waq_bytes_2 [0:7];
    logic [19:0] waq_bytes_3 [0:7];
    logic [19:0] waq_bytes_4 [0:7];
    logic [15:0] waq_rows_0 [0:7];
    logic [15:0] waq_rows_1 [0:7];
    logic [15:0] waq_rows_2 [0:7];
    logic [15:0] waq_rows_3 [0:7];
    logic [15:0] waq_rows_4 [0:7];
    logic [19:0] waq_stride_0 [0:7];
    logic [19:0] waq_stride_1 [0:7];
    logic [19:0] waq_stride_2 [0:7];
    logic [19:0] waq_stride_3 [0:7];
    logic [19:0] waq_stride_4 [0:7];
    logic waq_loc_0 [0:7];
    logic waq_loc_1 [0:7];
    logic waq_loc_2 [0:7];
    logic waq_loc_3 [0:7];
    logic waq_loc_4 [0:7];
    logic [20:0] raq_gs_0 [0:7];
    logic [20:0] raq_gs_1 [0:7];
    logic [20:0] raq_gs_2 [0:7];
    logic [20:0] raq_gs_3 [0:7];
    logic [20:0] raq_gs_4 [0:7];
    logic [7:0] raq_c1_0 [0:7];
    logic [7:0] raq_c1_1 [0:7];
    logic [7:0] raq_c1_2 [0:7];
    logic [7:0] raq_c1_3 [0:7];
    logic [7:0] raq_c1_4 [0:7];
    logic [7:0] raq_c2_0 [0:7];
    logic [7:0] raq_c2_1 [0:7];
    logic [7:0] raq_c2_2 [0:7];
    logic [7:0] raq_c2_3 [0:7];
    logic [7:0] raq_c2_4 [0:7];
    logic [20:0] waq_gs_0 [0:7];
    logic [20:0] waq_gs_1 [0:7];
    logic [20:0] waq_gs_2 [0:7];
    logic [20:0] waq_gs_3 [0:7];
    logic [20:0] waq_gs_4 [0:7];
    logic [7:0] waq_c1_0 [0:7];
    logic [7:0] waq_c1_1 [0:7];
    logic [7:0] waq_c1_2 [0:7];
    logic [7:0] waq_c1_3 [0:7];
    logic [7:0] waq_c1_4 [0:7];
    logic [7:0] waq_c2_0 [0:7];
    logic [7:0] waq_c2_1 [0:7];
    logic [7:0] waq_c2_2 [0:7];
    logic [7:0] waq_c2_3 [0:7];
    logic [7:0] waq_c2_4 [0:7];
    logic mst_0_cand_rd;
    logic mst_0_cand_wr;
    logic mst_0_adm_rd;
    logic mst_0_adm_wr;
    logic mst_0_rload;
    logic mst_0_wload;
    logic [4:0] mst_0_slot;
    logic mst_0_em_want;
    logic mst_0_ew1;
    logic mst_0_ew0;
    logic mst_0_em;
    logic mst_0_wem;
    logic mst_0_pb;
    logic mst_0_pl;
    logic [2:0] mst_0_ra_wp;
    logic [2:0] mst_0_ra_rp;
    logic [3:0] mst_0_ra_cnt;
    logic mst_0_ra_fq;
    logic mst_0_ra_neq;
    logic mst_0_ra_f_n;
    logic mst_0_ra_ne_n;
    logic mst_0_ra_fn0;
    logic mst_0_ra_fn1;
    logic [2:0] mst_0_wa_wp;
    logic [2:0] mst_0_wa_rp;
    logic [3:0] mst_0_wa_cnt;
    logic mst_0_wa_fq;
    logic mst_0_wa_neq;
    logic mst_0_wa_f_n;
    logic mst_0_wa_ne_n;
    logic mst_0_wa_fn0;
    logic mst_0_wa_fn1;
    logic mst_0_ga_act;
    logic [3:0] mst_0_ga_id;
    logic [15:0] mst_0_ga_tag;
    logic [47:0] mst_0_ga_cur;
    logic [47:0] mst_0_ga_rs;
    logic [20:0] mst_0_ga_gs;
    logic [20:0] mst_0_ga_ngs;
    logic [7:0] mst_0_ga_c2;
    logic [19:0] mst_0_ga_bytes;
    logic [15:0] mst_0_ga_rrem;
    logic [19:0] mst_0_ga_stride;
    logic mst_0_ga_loc;
    logic mst_0_ga_rowend;
    logic mst_0_ga_lastrow;
    logic [8:0] mst_0_ga_eoff;
    logic mst_0_ga_al;
    logic [47:0] mst_0_ga_rsn;
    logic [47:0] mst_0_ga_cnx;
    logic [20:0] mst_0_ga_gsd;
    logic [20:0] mst_0_ga_ngn;
    logic [1:0] mst_0_ga_lane;
    logic mst_0_ga_lane_ok;
    logic [2:0] mst_0_ga_nbeat;
    logic [1:0] mst_0_ga_b0;
    logic [5:0] mst_0_ga_off;
    logic mst_0_ga_base;
    logic mst_0_ga_ch;
    logic mst_0_ga_ok0;
    logic mst_0_ga_want;
    logic mst_0_gw_act;
    logic [3:0] mst_0_gw_id;
    logic [15:0] mst_0_gw_tag;
    logic [47:0] mst_0_gw_cur;
    logic [47:0] mst_0_gw_rs;
    logic [20:0] mst_0_gw_gs;
    logic [20:0] mst_0_gw_ngs;
    logic [7:0] mst_0_gw_c2;
    logic [19:0] mst_0_gw_bytes;
    logic [15:0] mst_0_gw_rrem;
    logic [19:0] mst_0_gw_stride;
    logic mst_0_gw_loc;
    logic mst_0_gw_rowend;
    logic mst_0_gw_lastrow;
    logic [8:0] mst_0_gw_eoff;
    logic mst_0_gw_al;
    logic [47:0] mst_0_gw_rsn;
    logic [47:0] mst_0_gw_cnx;
    logic [20:0] mst_0_gw_gsd;
    logic [20:0] mst_0_gw_ngn;
    logic [31:0] mst_0_w_wrd;
    logic [4:0] mst_0_w_wh;
    logic [4:0] mst_0_w_wt;
    logic [5:0] mst_0_w_wc;
    logic mst_0_w_wfq;
    logic mst_0_w_wf_n;
    logic [1:0] mst_0_w_ek;
    logic mst_0_w_hvq;
    logic [31:0] mst_0_w_rdys;
    logic mst_0_w_hit0;
    logic mst_0_w_hit1;
    logic mst_0_w_hn0;
    logic mst_0_w_hn1;
    logic mst_0_w_hbyp;
    logic [4:0] mst_0_w_hasl;
    logic [1:0] mst_0_w_hb0;
    logic [2:0] mst_0_w_hnb;
    logic [15:0] mst_0_w_htag;
    logic [3:0] mst_0_w_hid;
    logic mst_0_w_hloc;
    logic mst_0_w_hal;
    logic [4:0] mst_0_w_nasl;
    logic [1:0] mst_0_w_nb0;
    logic [2:0] mst_0_w_nnb;
    logic [15:0] mst_0_w_ntag;
    logic [3:0] mst_0_w_nid;
    logic mst_0_w_nloc;
    logic mst_0_w_nal;
    logic mst_0_w_hlast;
    logic [1:0] mst_0_w_hu;
    logic mst_0_w_hwi;
    logic mst_0_w_hhf;
    logic mst_0_loc_act;
    logic [2:0] mst_0_loc_cnt;
    logic [4:0] mst_0_loc_slot;
    logic [5:0] mst_0_loc_off;
    logic [31:0] mst_0_loc_val;
    logic [31:0] mst_0_loc_rd;
    logic mst_0_loc_done;
    logic mst_0_bq_v0;
    logic [3:0] mst_0_bq_id0;
    logic [15:0] mst_0_bq_tag0;
    logic mst_0_bq_v1;
    logic [3:0] mst_0_bq_id1;
    logic [15:0] mst_0_bq_tag1;
    logic mst_0_bq_pop;
    logic mst_0_bq_push;
    logic mst_0_aq_v;
    logic [3:0] mst_0_aq_id;
    logic [15:0] mst_0_aq_tag;
    logic [3:0] mst_0_rhd_id;
    logic [15:0] mst_0_rhd_tag;
    logic [47:0] mst_0_rhd_addr;
    logic [19:0] mst_0_rhd_bytes;
    logic [15:0] mst_0_rhd_rows;
    logic [19:0] mst_0_rhd_stride;
    logic mst_0_rhd_loc;
    logic [20:0] mst_0_rhd_gs;
    logic [7:0] mst_0_rhd_c1;
    logic [7:0] mst_0_rhd_c2;
    logic [20:0] mst_0_rhd_ngs;
    logic [3:0] mst_0_whd_id;
    logic [15:0] mst_0_whd_tag;
    logic [47:0] mst_0_whd_addr;
    logic [19:0] mst_0_whd_bytes;
    logic [15:0] mst_0_whd_rows;
    logic [19:0] mst_0_whd_stride;
    logic mst_0_whd_loc;
    logic [20:0] mst_0_whd_gs;
    logic [7:0] mst_0_whd_c1;
    logic [7:0] mst_0_whd_c2;
    logic [20:0] mst_0_whd_ngs;
    logic mst_1_cand_rd;
    logic mst_1_cand_wr;
    logic mst_1_adm_rd;
    logic mst_1_adm_wr;
    logic mst_1_rload;
    logic mst_1_wload;
    logic [4:0] mst_1_slot;
    logic mst_1_em_want;
    logic mst_1_ew1;
    logic mst_1_ew0;
    logic mst_1_em;
    logic mst_1_wem;
    logic mst_1_pb;
    logic mst_1_pl;
    logic [2:0] mst_1_ra_wp;
    logic [2:0] mst_1_ra_rp;
    logic [3:0] mst_1_ra_cnt;
    logic mst_1_ra_fq;
    logic mst_1_ra_neq;
    logic mst_1_ra_f_n;
    logic mst_1_ra_ne_n;
    logic mst_1_ra_fn0;
    logic mst_1_ra_fn1;
    logic [2:0] mst_1_wa_wp;
    logic [2:0] mst_1_wa_rp;
    logic [3:0] mst_1_wa_cnt;
    logic mst_1_wa_fq;
    logic mst_1_wa_neq;
    logic mst_1_wa_f_n;
    logic mst_1_wa_ne_n;
    logic mst_1_wa_fn0;
    logic mst_1_wa_fn1;
    logic mst_1_ga_act;
    logic [3:0] mst_1_ga_id;
    logic [15:0] mst_1_ga_tag;
    logic [47:0] mst_1_ga_cur;
    logic [47:0] mst_1_ga_rs;
    logic [20:0] mst_1_ga_gs;
    logic [20:0] mst_1_ga_ngs;
    logic [7:0] mst_1_ga_c2;
    logic [19:0] mst_1_ga_bytes;
    logic [15:0] mst_1_ga_rrem;
    logic [19:0] mst_1_ga_stride;
    logic mst_1_ga_loc;
    logic mst_1_ga_rowend;
    logic mst_1_ga_lastrow;
    logic [8:0] mst_1_ga_eoff;
    logic mst_1_ga_al;
    logic [47:0] mst_1_ga_rsn;
    logic [47:0] mst_1_ga_cnx;
    logic [20:0] mst_1_ga_gsd;
    logic [20:0] mst_1_ga_ngn;
    logic [1:0] mst_1_ga_lane;
    logic mst_1_ga_lane_ok;
    logic [2:0] mst_1_ga_nbeat;
    logic [1:0] mst_1_ga_b0;
    logic [5:0] mst_1_ga_off;
    logic mst_1_ga_base;
    logic mst_1_ga_ch;
    logic mst_1_ga_ok0;
    logic mst_1_ga_want;
    logic mst_1_gw_act;
    logic [3:0] mst_1_gw_id;
    logic [15:0] mst_1_gw_tag;
    logic [47:0] mst_1_gw_cur;
    logic [47:0] mst_1_gw_rs;
    logic [20:0] mst_1_gw_gs;
    logic [20:0] mst_1_gw_ngs;
    logic [7:0] mst_1_gw_c2;
    logic [19:0] mst_1_gw_bytes;
    logic [15:0] mst_1_gw_rrem;
    logic [19:0] mst_1_gw_stride;
    logic mst_1_gw_loc;
    logic mst_1_gw_rowend;
    logic mst_1_gw_lastrow;
    logic [8:0] mst_1_gw_eoff;
    logic mst_1_gw_al;
    logic [47:0] mst_1_gw_rsn;
    logic [47:0] mst_1_gw_cnx;
    logic [20:0] mst_1_gw_gsd;
    logic [20:0] mst_1_gw_ngn;
    logic [31:0] mst_1_w_wrd;
    logic [4:0] mst_1_w_wh;
    logic [4:0] mst_1_w_wt;
    logic [5:0] mst_1_w_wc;
    logic mst_1_w_wfq;
    logic mst_1_w_wf_n;
    logic [1:0] mst_1_w_ek;
    logic mst_1_w_hvq;
    logic [31:0] mst_1_w_rdys;
    logic mst_1_w_hit0;
    logic mst_1_w_hit1;
    logic mst_1_w_hn0;
    logic mst_1_w_hn1;
    logic mst_1_w_hbyp;
    logic [4:0] mst_1_w_hasl;
    logic [1:0] mst_1_w_hb0;
    logic [2:0] mst_1_w_hnb;
    logic [15:0] mst_1_w_htag;
    logic [3:0] mst_1_w_hid;
    logic mst_1_w_hloc;
    logic mst_1_w_hal;
    logic [4:0] mst_1_w_nasl;
    logic [1:0] mst_1_w_nb0;
    logic [2:0] mst_1_w_nnb;
    logic [15:0] mst_1_w_ntag;
    logic [3:0] mst_1_w_nid;
    logic mst_1_w_nloc;
    logic mst_1_w_nal;
    logic mst_1_w_hlast;
    logic [1:0] mst_1_w_hu;
    logic mst_1_w_hwi;
    logic mst_1_w_hhf;
    logic mst_1_loc_act;
    logic [2:0] mst_1_loc_cnt;
    logic [4:0] mst_1_loc_slot;
    logic [5:0] mst_1_loc_off;
    logic [31:0] mst_1_loc_val;
    logic [31:0] mst_1_loc_rd;
    logic mst_1_loc_done;
    logic mst_1_bq_v0;
    logic [3:0] mst_1_bq_id0;
    logic [15:0] mst_1_bq_tag0;
    logic mst_1_bq_v1;
    logic [3:0] mst_1_bq_id1;
    logic [15:0] mst_1_bq_tag1;
    logic mst_1_bq_pop;
    logic mst_1_bq_push;
    logic mst_1_aq_v;
    logic [3:0] mst_1_aq_id;
    logic [15:0] mst_1_aq_tag;
    logic [3:0] mst_1_rhd_id;
    logic [15:0] mst_1_rhd_tag;
    logic [47:0] mst_1_rhd_addr;
    logic [19:0] mst_1_rhd_bytes;
    logic [15:0] mst_1_rhd_rows;
    logic [19:0] mst_1_rhd_stride;
    logic mst_1_rhd_loc;
    logic [20:0] mst_1_rhd_gs;
    logic [7:0] mst_1_rhd_c1;
    logic [7:0] mst_1_rhd_c2;
    logic [20:0] mst_1_rhd_ngs;
    logic [3:0] mst_1_whd_id;
    logic [15:0] mst_1_whd_tag;
    logic [47:0] mst_1_whd_addr;
    logic [19:0] mst_1_whd_bytes;
    logic [15:0] mst_1_whd_rows;
    logic [19:0] mst_1_whd_stride;
    logic mst_1_whd_loc;
    logic [20:0] mst_1_whd_gs;
    logic [7:0] mst_1_whd_c1;
    logic [7:0] mst_1_whd_c2;
    logic [20:0] mst_1_whd_ngs;
    logic mst_2_cand_rd;
    logic mst_2_cand_wr;
    logic mst_2_adm_rd;
    logic mst_2_adm_wr;
    logic mst_2_rload;
    logic mst_2_wload;
    logic [4:0] mst_2_slot;
    logic mst_2_em_want;
    logic mst_2_ew1;
    logic mst_2_ew0;
    logic mst_2_em;
    logic mst_2_wem;
    logic mst_2_pb;
    logic mst_2_pl;
    logic [2:0] mst_2_ra_wp;
    logic [2:0] mst_2_ra_rp;
    logic [3:0] mst_2_ra_cnt;
    logic mst_2_ra_fq;
    logic mst_2_ra_neq;
    logic mst_2_ra_f_n;
    logic mst_2_ra_ne_n;
    logic mst_2_ra_fn0;
    logic mst_2_ra_fn1;
    logic [2:0] mst_2_wa_wp;
    logic [2:0] mst_2_wa_rp;
    logic [3:0] mst_2_wa_cnt;
    logic mst_2_wa_fq;
    logic mst_2_wa_neq;
    logic mst_2_wa_f_n;
    logic mst_2_wa_ne_n;
    logic mst_2_wa_fn0;
    logic mst_2_wa_fn1;
    logic mst_2_ga_act;
    logic [3:0] mst_2_ga_id;
    logic [15:0] mst_2_ga_tag;
    logic [47:0] mst_2_ga_cur;
    logic [47:0] mst_2_ga_rs;
    logic [20:0] mst_2_ga_gs;
    logic [20:0] mst_2_ga_ngs;
    logic [7:0] mst_2_ga_c2;
    logic [19:0] mst_2_ga_bytes;
    logic [15:0] mst_2_ga_rrem;
    logic [19:0] mst_2_ga_stride;
    logic mst_2_ga_loc;
    logic mst_2_ga_rowend;
    logic mst_2_ga_lastrow;
    logic [8:0] mst_2_ga_eoff;
    logic mst_2_ga_al;
    logic [47:0] mst_2_ga_rsn;
    logic [47:0] mst_2_ga_cnx;
    logic [20:0] mst_2_ga_gsd;
    logic [20:0] mst_2_ga_ngn;
    logic [1:0] mst_2_ga_lane;
    logic mst_2_ga_lane_ok;
    logic [2:0] mst_2_ga_nbeat;
    logic [1:0] mst_2_ga_b0;
    logic [5:0] mst_2_ga_off;
    logic mst_2_ga_base;
    logic mst_2_ga_ch;
    logic mst_2_ga_ok0;
    logic mst_2_ga_want;
    logic mst_2_gw_act;
    logic [3:0] mst_2_gw_id;
    logic [15:0] mst_2_gw_tag;
    logic [47:0] mst_2_gw_cur;
    logic [47:0] mst_2_gw_rs;
    logic [20:0] mst_2_gw_gs;
    logic [20:0] mst_2_gw_ngs;
    logic [7:0] mst_2_gw_c2;
    logic [19:0] mst_2_gw_bytes;
    logic [15:0] mst_2_gw_rrem;
    logic [19:0] mst_2_gw_stride;
    logic mst_2_gw_loc;
    logic mst_2_gw_rowend;
    logic mst_2_gw_lastrow;
    logic [8:0] mst_2_gw_eoff;
    logic mst_2_gw_al;
    logic [47:0] mst_2_gw_rsn;
    logic [47:0] mst_2_gw_cnx;
    logic [20:0] mst_2_gw_gsd;
    logic [20:0] mst_2_gw_ngn;
    logic [31:0] mst_2_w_wrd;
    logic [4:0] mst_2_w_wh;
    logic [4:0] mst_2_w_wt;
    logic [5:0] mst_2_w_wc;
    logic mst_2_w_wfq;
    logic mst_2_w_wf_n;
    logic [1:0] mst_2_w_ek;
    logic mst_2_w_hvq;
    logic [31:0] mst_2_w_rdys;
    logic mst_2_w_hit0;
    logic mst_2_w_hit1;
    logic mst_2_w_hn0;
    logic mst_2_w_hn1;
    logic mst_2_w_hbyp;
    logic [4:0] mst_2_w_hasl;
    logic [1:0] mst_2_w_hb0;
    logic [2:0] mst_2_w_hnb;
    logic [15:0] mst_2_w_htag;
    logic [3:0] mst_2_w_hid;
    logic mst_2_w_hloc;
    logic mst_2_w_hal;
    logic [4:0] mst_2_w_nasl;
    logic [1:0] mst_2_w_nb0;
    logic [2:0] mst_2_w_nnb;
    logic [15:0] mst_2_w_ntag;
    logic [3:0] mst_2_w_nid;
    logic mst_2_w_nloc;
    logic mst_2_w_nal;
    logic mst_2_w_hlast;
    logic [1:0] mst_2_w_hu;
    logic mst_2_w_hwi;
    logic mst_2_w_hhf;
    logic mst_2_loc_act;
    logic [2:0] mst_2_loc_cnt;
    logic [4:0] mst_2_loc_slot;
    logic [5:0] mst_2_loc_off;
    logic [31:0] mst_2_loc_val;
    logic [31:0] mst_2_loc_rd;
    logic mst_2_loc_done;
    logic mst_2_bq_v0;
    logic [3:0] mst_2_bq_id0;
    logic [15:0] mst_2_bq_tag0;
    logic mst_2_bq_v1;
    logic [3:0] mst_2_bq_id1;
    logic [15:0] mst_2_bq_tag1;
    logic mst_2_bq_pop;
    logic mst_2_bq_push;
    logic mst_2_aq_v;
    logic [3:0] mst_2_aq_id;
    logic [15:0] mst_2_aq_tag;
    logic [3:0] mst_2_rhd_id;
    logic [15:0] mst_2_rhd_tag;
    logic [47:0] mst_2_rhd_addr;
    logic [19:0] mst_2_rhd_bytes;
    logic [15:0] mst_2_rhd_rows;
    logic [19:0] mst_2_rhd_stride;
    logic mst_2_rhd_loc;
    logic [20:0] mst_2_rhd_gs;
    logic [7:0] mst_2_rhd_c1;
    logic [7:0] mst_2_rhd_c2;
    logic [20:0] mst_2_rhd_ngs;
    logic [3:0] mst_2_whd_id;
    logic [15:0] mst_2_whd_tag;
    logic [47:0] mst_2_whd_addr;
    logic [19:0] mst_2_whd_bytes;
    logic [15:0] mst_2_whd_rows;
    logic [19:0] mst_2_whd_stride;
    logic mst_2_whd_loc;
    logic [20:0] mst_2_whd_gs;
    logic [7:0] mst_2_whd_c1;
    logic [7:0] mst_2_whd_c2;
    logic [20:0] mst_2_whd_ngs;
    logic mst_3_cand_rd;
    logic mst_3_cand_wr;
    logic mst_3_adm_rd;
    logic mst_3_adm_wr;
    logic mst_3_rload;
    logic mst_3_wload;
    logic [4:0] mst_3_slot;
    logic mst_3_em_want;
    logic mst_3_ew1;
    logic mst_3_ew0;
    logic mst_3_em;
    logic mst_3_wem;
    logic mst_3_pb;
    logic mst_3_pl;
    logic [2:0] mst_3_ra_wp;
    logic [2:0] mst_3_ra_rp;
    logic [3:0] mst_3_ra_cnt;
    logic mst_3_ra_fq;
    logic mst_3_ra_neq;
    logic mst_3_ra_f_n;
    logic mst_3_ra_ne_n;
    logic mst_3_ra_fn0;
    logic mst_3_ra_fn1;
    logic [2:0] mst_3_wa_wp;
    logic [2:0] mst_3_wa_rp;
    logic [3:0] mst_3_wa_cnt;
    logic mst_3_wa_fq;
    logic mst_3_wa_neq;
    logic mst_3_wa_f_n;
    logic mst_3_wa_ne_n;
    logic mst_3_wa_fn0;
    logic mst_3_wa_fn1;
    logic mst_3_ga_act;
    logic [3:0] mst_3_ga_id;
    logic [15:0] mst_3_ga_tag;
    logic [47:0] mst_3_ga_cur;
    logic [47:0] mst_3_ga_rs;
    logic [20:0] mst_3_ga_gs;
    logic [20:0] mst_3_ga_ngs;
    logic [7:0] mst_3_ga_c2;
    logic [19:0] mst_3_ga_bytes;
    logic [15:0] mst_3_ga_rrem;
    logic [19:0] mst_3_ga_stride;
    logic mst_3_ga_loc;
    logic mst_3_ga_rowend;
    logic mst_3_ga_lastrow;
    logic [8:0] mst_3_ga_eoff;
    logic mst_3_ga_al;
    logic [47:0] mst_3_ga_rsn;
    logic [47:0] mst_3_ga_cnx;
    logic [20:0] mst_3_ga_gsd;
    logic [20:0] mst_3_ga_ngn;
    logic [1:0] mst_3_ga_lane;
    logic mst_3_ga_lane_ok;
    logic [2:0] mst_3_ga_nbeat;
    logic [1:0] mst_3_ga_b0;
    logic [5:0] mst_3_ga_off;
    logic mst_3_ga_base;
    logic mst_3_ga_ch;
    logic mst_3_ga_ok0;
    logic mst_3_ga_want;
    logic mst_3_gw_act;
    logic [3:0] mst_3_gw_id;
    logic [15:0] mst_3_gw_tag;
    logic [47:0] mst_3_gw_cur;
    logic [47:0] mst_3_gw_rs;
    logic [20:0] mst_3_gw_gs;
    logic [20:0] mst_3_gw_ngs;
    logic [7:0] mst_3_gw_c2;
    logic [19:0] mst_3_gw_bytes;
    logic [15:0] mst_3_gw_rrem;
    logic [19:0] mst_3_gw_stride;
    logic mst_3_gw_loc;
    logic mst_3_gw_rowend;
    logic mst_3_gw_lastrow;
    logic [8:0] mst_3_gw_eoff;
    logic mst_3_gw_al;
    logic [47:0] mst_3_gw_rsn;
    logic [47:0] mst_3_gw_cnx;
    logic [20:0] mst_3_gw_gsd;
    logic [20:0] mst_3_gw_ngn;
    logic [31:0] mst_3_w_wrd;
    logic [4:0] mst_3_w_wh;
    logic [4:0] mst_3_w_wt;
    logic [5:0] mst_3_w_wc;
    logic mst_3_w_wfq;
    logic mst_3_w_wf_n;
    logic [1:0] mst_3_w_ek;
    logic mst_3_w_hvq;
    logic [31:0] mst_3_w_rdys;
    logic mst_3_w_hit0;
    logic mst_3_w_hit1;
    logic mst_3_w_hn0;
    logic mst_3_w_hn1;
    logic mst_3_w_hbyp;
    logic [4:0] mst_3_w_hasl;
    logic [1:0] mst_3_w_hb0;
    logic [2:0] mst_3_w_hnb;
    logic [15:0] mst_3_w_htag;
    logic [3:0] mst_3_w_hid;
    logic mst_3_w_hloc;
    logic mst_3_w_hal;
    logic [4:0] mst_3_w_nasl;
    logic [1:0] mst_3_w_nb0;
    logic [2:0] mst_3_w_nnb;
    logic [15:0] mst_3_w_ntag;
    logic [3:0] mst_3_w_nid;
    logic mst_3_w_nloc;
    logic mst_3_w_nal;
    logic mst_3_w_hlast;
    logic [1:0] mst_3_w_hu;
    logic mst_3_w_hwi;
    logic mst_3_w_hhf;
    logic mst_3_loc_act;
    logic [2:0] mst_3_loc_cnt;
    logic [4:0] mst_3_loc_slot;
    logic [5:0] mst_3_loc_off;
    logic [31:0] mst_3_loc_val;
    logic [31:0] mst_3_loc_rd;
    logic mst_3_loc_done;
    logic mst_3_bq_v0;
    logic [3:0] mst_3_bq_id0;
    logic [15:0] mst_3_bq_tag0;
    logic mst_3_bq_v1;
    logic [3:0] mst_3_bq_id1;
    logic [15:0] mst_3_bq_tag1;
    logic mst_3_bq_pop;
    logic mst_3_bq_push;
    logic mst_3_aq_v;
    logic [3:0] mst_3_aq_id;
    logic [15:0] mst_3_aq_tag;
    logic [3:0] mst_3_rhd_id;
    logic [15:0] mst_3_rhd_tag;
    logic [47:0] mst_3_rhd_addr;
    logic [19:0] mst_3_rhd_bytes;
    logic [15:0] mst_3_rhd_rows;
    logic [19:0] mst_3_rhd_stride;
    logic mst_3_rhd_loc;
    logic [20:0] mst_3_rhd_gs;
    logic [7:0] mst_3_rhd_c1;
    logic [7:0] mst_3_rhd_c2;
    logic [20:0] mst_3_rhd_ngs;
    logic [3:0] mst_3_whd_id;
    logic [15:0] mst_3_whd_tag;
    logic [47:0] mst_3_whd_addr;
    logic [19:0] mst_3_whd_bytes;
    logic [15:0] mst_3_whd_rows;
    logic [19:0] mst_3_whd_stride;
    logic mst_3_whd_loc;
    logic [20:0] mst_3_whd_gs;
    logic [7:0] mst_3_whd_c1;
    logic [7:0] mst_3_whd_c2;
    logic [20:0] mst_3_whd_ngs;
    logic mst_4_cand_rd;
    logic mst_4_cand_wr;
    logic mst_4_adm_rd;
    logic mst_4_adm_wr;
    logic mst_4_rload;
    logic mst_4_wload;
    logic [4:0] mst_4_slot;
    logic mst_4_em_want;
    logic mst_4_ew1;
    logic mst_4_ew0;
    logic mst_4_em;
    logic mst_4_wem;
    logic mst_4_pb;
    logic mst_4_pl;
    logic [2:0] mst_4_ra_wp;
    logic [2:0] mst_4_ra_rp;
    logic [3:0] mst_4_ra_cnt;
    logic mst_4_ra_fq;
    logic mst_4_ra_neq;
    logic mst_4_ra_f_n;
    logic mst_4_ra_ne_n;
    logic mst_4_ra_fn0;
    logic mst_4_ra_fn1;
    logic [2:0] mst_4_wa_wp;
    logic [2:0] mst_4_wa_rp;
    logic [3:0] mst_4_wa_cnt;
    logic mst_4_wa_fq;
    logic mst_4_wa_neq;
    logic mst_4_wa_f_n;
    logic mst_4_wa_ne_n;
    logic mst_4_wa_fn0;
    logic mst_4_wa_fn1;
    logic mst_4_ga_act;
    logic [3:0] mst_4_ga_id;
    logic [15:0] mst_4_ga_tag;
    logic [47:0] mst_4_ga_cur;
    logic [47:0] mst_4_ga_rs;
    logic [20:0] mst_4_ga_gs;
    logic [20:0] mst_4_ga_ngs;
    logic [7:0] mst_4_ga_c2;
    logic [19:0] mst_4_ga_bytes;
    logic [15:0] mst_4_ga_rrem;
    logic [19:0] mst_4_ga_stride;
    logic mst_4_ga_loc;
    logic mst_4_ga_rowend;
    logic mst_4_ga_lastrow;
    logic [8:0] mst_4_ga_eoff;
    logic mst_4_ga_al;
    logic [47:0] mst_4_ga_rsn;
    logic [47:0] mst_4_ga_cnx;
    logic [20:0] mst_4_ga_gsd;
    logic [20:0] mst_4_ga_ngn;
    logic [1:0] mst_4_ga_lane;
    logic mst_4_ga_lane_ok;
    logic [2:0] mst_4_ga_nbeat;
    logic [1:0] mst_4_ga_b0;
    logic [5:0] mst_4_ga_off;
    logic mst_4_ga_base;
    logic mst_4_ga_ch;
    logic mst_4_ga_ok0;
    logic mst_4_ga_want;
    logic mst_4_gw_act;
    logic [3:0] mst_4_gw_id;
    logic [15:0] mst_4_gw_tag;
    logic [47:0] mst_4_gw_cur;
    logic [47:0] mst_4_gw_rs;
    logic [20:0] mst_4_gw_gs;
    logic [20:0] mst_4_gw_ngs;
    logic [7:0] mst_4_gw_c2;
    logic [19:0] mst_4_gw_bytes;
    logic [15:0] mst_4_gw_rrem;
    logic [19:0] mst_4_gw_stride;
    logic mst_4_gw_loc;
    logic mst_4_gw_rowend;
    logic mst_4_gw_lastrow;
    logic [8:0] mst_4_gw_eoff;
    logic mst_4_gw_al;
    logic [47:0] mst_4_gw_rsn;
    logic [47:0] mst_4_gw_cnx;
    logic [20:0] mst_4_gw_gsd;
    logic [20:0] mst_4_gw_ngn;
    logic [31:0] mst_4_w_wrd;
    logic [4:0] mst_4_w_wh;
    logic [4:0] mst_4_w_wt;
    logic [5:0] mst_4_w_wc;
    logic mst_4_w_wfq;
    logic mst_4_w_wf_n;
    logic [1:0] mst_4_w_ek;
    logic mst_4_w_hvq;
    logic [31:0] mst_4_w_rdys;
    logic mst_4_w_hit0;
    logic mst_4_w_hit1;
    logic mst_4_w_hn0;
    logic mst_4_w_hn1;
    logic mst_4_w_hbyp;
    logic [4:0] mst_4_w_hasl;
    logic [1:0] mst_4_w_hb0;
    logic [2:0] mst_4_w_hnb;
    logic [15:0] mst_4_w_htag;
    logic [3:0] mst_4_w_hid;
    logic mst_4_w_hloc;
    logic mst_4_w_hal;
    logic [4:0] mst_4_w_nasl;
    logic [1:0] mst_4_w_nb0;
    logic [2:0] mst_4_w_nnb;
    logic [15:0] mst_4_w_ntag;
    logic [3:0] mst_4_w_nid;
    logic mst_4_w_nloc;
    logic mst_4_w_nal;
    logic mst_4_w_hlast;
    logic [1:0] mst_4_w_hu;
    logic mst_4_w_hwi;
    logic mst_4_w_hhf;
    logic mst_4_loc_act;
    logic [2:0] mst_4_loc_cnt;
    logic [4:0] mst_4_loc_slot;
    logic [5:0] mst_4_loc_off;
    logic [31:0] mst_4_loc_val;
    logic [31:0] mst_4_loc_rd;
    logic mst_4_loc_done;
    logic mst_4_bq_v0;
    logic [3:0] mst_4_bq_id0;
    logic [15:0] mst_4_bq_tag0;
    logic mst_4_bq_v1;
    logic [3:0] mst_4_bq_id1;
    logic [15:0] mst_4_bq_tag1;
    logic mst_4_bq_pop;
    logic mst_4_bq_push;
    logic mst_4_aq_v;
    logic [3:0] mst_4_aq_id;
    logic [15:0] mst_4_aq_tag;
    logic [3:0] mst_4_rhd_id;
    logic [15:0] mst_4_rhd_tag;
    logic [47:0] mst_4_rhd_addr;
    logic [19:0] mst_4_rhd_bytes;
    logic [15:0] mst_4_rhd_rows;
    logic [19:0] mst_4_rhd_stride;
    logic mst_4_rhd_loc;
    logic [20:0] mst_4_rhd_gs;
    logic [7:0] mst_4_rhd_c1;
    logic [7:0] mst_4_rhd_c2;
    logic [20:0] mst_4_rhd_ngs;
    logic [3:0] mst_4_whd_id;
    logic [15:0] mst_4_whd_tag;
    logic [47:0] mst_4_whd_addr;
    logic [19:0] mst_4_whd_bytes;
    logic [15:0] mst_4_whd_rows;
    logic [19:0] mst_4_whd_stride;
    logic mst_4_whd_loc;
    logic [20:0] mst_4_whd_gs;
    logic [7:0] mst_4_whd_c1;
    logic [7:0] mst_4_whd_c2;
    logic [20:0] mst_4_whd_ngs;
    logic [4:0] wp_asl_0 [0:31];
    logic [4:0] wp_asl_1 [0:31];
    logic [4:0] wp_asl_2 [0:31];
    logic [4:0] wp_asl_3 [0:31];
    logic [4:0] wp_asl_4 [0:31];
    logic [1:0] wp_b0_0 [0:31];
    logic [1:0] wp_b0_1 [0:31];
    logic [1:0] wp_b0_2 [0:31];
    logic [1:0] wp_b0_3 [0:31];
    logic [1:0] wp_b0_4 [0:31];
    logic [2:0] wp_nb_0 [0:31];
    logic [2:0] wp_nb_1 [0:31];
    logic [2:0] wp_nb_2 [0:31];
    logic [2:0] wp_nb_3 [0:31];
    logic [2:0] wp_nb_4 [0:31];
    logic [15:0] wp_tag_0 [0:31];
    logic [15:0] wp_tag_1 [0:31];
    logic [15:0] wp_tag_2 [0:31];
    logic [15:0] wp_tag_3 [0:31];
    logic [15:0] wp_tag_4 [0:31];
    logic [3:0] wp_id_0 [0:31];
    logic [3:0] wp_id_1 [0:31];
    logic [3:0] wp_id_2 [0:31];
    logic [3:0] wp_id_3 [0:31];
    logic [3:0] wp_id_4 [0:31];
    logic wp_loc_0 [0:31];
    logic wp_loc_1 [0:31];
    logic wp_loc_2 [0:31];
    logic wp_loc_3 [0:31];
    logic wp_loc_4 [0:31];
    logic wp_al_0 [0:31];
    logic wp_al_1 [0:31];
    logic wp_al_2 [0:31];
    logic wp_al_3 [0:31];
    logic wp_al_4 [0:31];
    logic [4:0] win_wh1_0;
    logic [4:0] win_wh1_1;
    logic [4:0] win_wh1_2;
    logic [4:0] win_wh1_3;
    logic [4:0] win_wh1_4;
    logic ra_v;
    logic ra_last;
    logic [15:0] ra_tag;
    logic [3:0] ra_id;
    logic ra_loc;
    logic [31:0] ra_lval;
    logic rb_v;
    logic rb_last;
    logic [15:0] rb_tag;
    logic [3:0] rb_id;
    logic rb_loc;
    logic [31:0] rb_lval;
    logic [2:0] rb_m;
    logic [1:0] rb_rr;
    logic rb_hf;
    logic [9:0] adm_msk;
    logic [9:0] adm_cq;
    logic [9:0] adm_hq;
    logic [1:0] ldB_rr;
    logic [1:0] lwB_rr;
    logic [1:0] emB_rr;
    logic [2:0] wq_rr;
    logic [15:0] pend_write;
    logic [15:0] pw_inc;
    logic [15:0] pw_dec;
    logic ed0_q;
    logic [4:0] ed0s_q;
    logic ed1_q;
    logic [4:0] ed1s_q;
    logic [15:0] asm_blk;
    logic asm_blk_q;
    logic [7:0] win_occ_q;
    logic [9:0] adm_c;
    logic [9:0] adm_hi;
    logic adm_hi_any;
    logic adm_any;
    logic [9:0] adm_g;
    logic [9:0] adm_msk_n;
    logic [9:0] adm_msk_nx;
    logic adm_wr_dram;
    logic [3:0] n_cand;
    logic ldB_g_0;
    logic ldB_g_1;
    logic ldB_g_2;
    logic ldB_g_3;
    logic lwB_g_0;
    logic lwB_g_1;
    logic lwB_g_2;
    logic lwB_g_3;
    logic ldB_any;
    logic [1:0] ldB_k;
    logic lwB_any;
    logic [1:0] lwB_k;
    logic adm_t_0_0;
    logic adm_t_0_1;
    logic adm_t_0_2;
    logic adm_t_0_3;
    logic adm_t_1_0;
    logic adm_t_1_1;
    logic adm_t_1_2;
    logic adm_t_1_3;
    logic adm_t_2_0;
    logic adm_t_2_1;
    logic adm_t_2_2;
    logic adm_t_2_3;
    logic adm_t_3_0;
    logic adm_t_3_1;
    logic adm_t_3_2;
    logic adm_t_3_3;
    logic adm_t_4_0;
    logic adm_t_4_1;
    logic adm_t_4_2;
    logic adm_t_4_3;
    logic adm_t_5_0;
    logic adm_t_5_1;
    logic adm_t_5_2;
    logic adm_t_5_3;
    logic adm_t_6_0;
    logic adm_t_6_1;
    logic adm_t_6_2;
    logic adm_t_6_3;
    logic adm_t_7_0;
    logic adm_t_7_1;
    logic adm_t_7_2;
    logic adm_t_7_3;
    logic adm_t_8_0;
    logic adm_t_8_1;
    logic adm_t_8_2;
    logic adm_t_8_3;
    logic adm_t_9_0;
    logic adm_t_9_1;
    logic adm_t_9_2;
    logic adm_t_9_3;
    logic adm_th_0_0;
    logic adm_th_0_1;
    logic adm_th_1_0;
    logic adm_th_1_1;
    logic adm_th_2_0;
    logic adm_th_2_1;
    logic adm_th_3_0;
    logic adm_th_3_1;
    logic adm_th_4_0;
    logic adm_th_4_1;
    logic adm_th_5_0;
    logic adm_th_5_1;
    logic adm_th_6_0;
    logic adm_th_6_1;
    logic adm_th_7_0;
    logic adm_th_7_1;
    logic adm_th_8_0;
    logic adm_th_8_1;
    logic adm_th_9_0;
    logic adm_th_9_1;
    logic [9:0] adm_c_n;
    logic [9:0] adm_h_n;
    logic emA;
    logic emA_dram;
    logic asm_blk_ev;
    logic emB_gs_0_0;
    logic emB_gs_0_1;
    logic emB_gs_0_2;
    logic emB_gs_0_3;
    logic emB_gs_1_0;
    logic emB_gs_1_1;
    logic emB_gs_1_2;
    logic emB_gs_1_3;
    logic emB_anys_0;
    logic emB_anys_1;
    logic [1:0] emB_ks_0;
    logic [1:0] emB_ks_1;
    logic [2:0] emB_ms_0;
    logic [2:0] emB_ms_1;
    logic emB_drams_0;
    logic emB_drams_1;
    logic [47:0] emB_curs_0;
    logic [47:0] emB_curs_1;
    logic [7:0] emB_tks_0;
    logic [7:0] emB_tks_1;
    logic [4:0] emB_slots_0;
    logic [4:0] emB_slots_1;
    logic emB_rqs_0_0;
    logic emB_rqs_0_1;
    logic emB_rqs_0_2;
    logic emB_rqs_0_3;
    logic emB_rqs_1_0;
    logic emB_rqs_1_1;
    logic emB_rqs_1_2;
    logic emB_rqs_1_3;
    logic emB_pbs_0_0;
    logic emB_pbs_0_1;
    logic emB_pbs_1_0;
    logic emB_pbs_1_1;
    logic emB_g_0;
    logic emB_g_1;
    logic emB_g_2;
    logic emB_g_3;
    logic emB_any;
    logic [1:0] emB_k;
    logic emB_dram;
    logic [7:0] emA_tk;
    logic wq_g_0;
    logic wq_g_1;
    logic wq_g_2;
    logic wq_g_3;
    logic wq_g_4;
    logic wq_any;
    logic [2:0] wq_k;
    logic [2:0] wk_m_0;
    logic [2:0] wk_m_1;
    logic [4:0] wk_slot_0;
    logic [4:0] wk_slot_1;
    logic wk_v_0;
    logic wk_v_1;
    logic hA_loc;
    logic hA_al;
    logic goA;
    logic lastA;
    logic rb_free;
    logic goB_g_0;
    logic goB_g_1;
    logic goB_g_2;
    logic goB_g_3;
    logic goB_any;
    logic [1:0] goB_k;
    logic goB;
    logic [2:0] goB_m;
    logic hB_loc;
    logic hB_al;
    logic [4:0] hB_asl;
    logic [15:0] hB_tag;
    logic [3:0] hB_id;
    logic lastB;
    logic wiB;
    logic hfB;
    logic [31:0] hB_lval;
    logic [1023:0] rb_dout;
    logic [511:0] rb_nar_0;
    logic [7:0] win_occ;
    logic rpush__m0;
    logic wpush__m0;
    logic rload__m0;
    logic wload__m0;
    logic em__m0;
    logic pl__m0;
    logic [31:0] slot_clr__m0;
    logic bpush__m0;
    logic bpop__m0;
    logic rpush__m1;
    logic wpush__m1;
    logic rload__m1;
    logic wload__m1;
    logic em__m1;
    logic pl__m1;
    logic [31:0] slot_clr__m1;
    logic bpush__m1;
    logic bpop__m1;
    logic rpush__m2;
    logic wpush__m2;
    logic rload__m2;
    logic wload__m2;
    logic em__m2;
    logic pl__m2;
    logic [31:0] slot_clr__m2;
    logic bpush__m2;
    logic bpop__m2;
    logic rpush__m3;
    logic wpush__m3;
    logic rload__m3;
    logic wload__m3;
    logic em__m3;
    logic pl__m3;
    logic [31:0] slot_clr__m3;
    logic bpush__m3;
    logic bpop__m3;
    logic rpush__m4;
    logic wpush__m4;
    logic rload__m4;
    logic wload__m4;
    logic em__m4;
    logic pl__m4;
    logic [31:0] slot_clr__m4;
    logic bpush__m4;
    logic bpop__m4;
    logic bdone;
    logic adm_g_c0;
    logic adm_g_c1;
    logic adm_g_c2;
    logic adm_g_c3;
    logic adm_g_c4;
    logic adm_g_c5;
    logic adm_g_c6;
    logic [4:0] mst_1_slot_c0;
    logic mst_1_ga_want_c0;
    logic mst_1_ga_want_c1;
    logic [4:0] mst_2_slot_c0;
    logic mst_2_ga_want_c0;
    logic mst_2_ga_want_c1;
    logic [4:0] mst_3_slot_c0;
    logic mst_3_ga_want_c0;
    logic mst_3_ga_want_c1;
    logic [4:0] mst_4_slot_c0;
    logic mst_4_ga_want_c0;
    logic mst_4_ga_want_c1;
    logic [2:0] wq_k_c0;
    logic [2:0] wq_k_c1;

    assign pw_inc = (pend_write + 1);
    assign pw_dec = (pend_write - 1);
    assign mst_0_cand_rd = adm_cq[0];
    assign mst_0_cand_wr = adm_cq[1];
    assign mst_1_cand_rd = adm_cq[2];
    assign mst_1_cand_wr = adm_cq[3];
    assign mst_2_cand_rd = adm_cq[4];
    assign mst_2_cand_wr = adm_cq[5];
    assign mst_3_cand_rd = adm_cq[6];
    assign mst_3_cand_wr = adm_cq[7];
    assign mst_4_cand_rd = adm_cq[8];
    assign mst_4_cand_wr = adm_cq[9];
    assign adm_c = adm_cq;
    assign adm_hi = adm_hq;
    assign adm_hi_any = (adm_hi != 0);
    assign adm_any = (adm_c != 0);
    assign adm_g_c0 = (((1'd0 | adm_hi[0]) | adm_hi[1]) | adm_hi[2]);
    assign adm_g_c1 = ((adm_g_c0 | adm_hi[3]) | adm_hi[4]);
    assign adm_g_c2 = ((adm_g_c1 | adm_hi[5]) | adm_hi[6]);
    assign adm_g_c3 = ((adm_g_c2 | adm_hi[7]) | adm_hi[8]);
    assign adm_g_c4 = (((1'd0 | adm_c[0]) | adm_c[1]) | adm_c[2]);
    assign adm_g_c5 = (((adm_g_c4 | adm_c[3]) | adm_c[4]) | adm_c[5]);
    assign adm_g_c6 = (((adm_g_c5 | adm_c[6]) | adm_c[7]) | adm_c[8]);
    assign adm_g = (adm_hi_any
                    ? {(adm_hi[9] & (~adm_g_c3)), (adm_hi[8] & (~(adm_g_c2 | adm_hi[7]))), (adm_hi[7] & (~adm_g_c2)),
                       (adm_hi[6] & (~(adm_g_c1 | adm_hi[5]))), (adm_hi[5] & (~adm_g_c1)),
                       (adm_hi[4] & (~(adm_g_c0 | adm_hi[3]))), (adm_hi[3] & (~adm_g_c0)),
                       (adm_hi[2] & (~((1'd0 | adm_hi[0]) | adm_hi[1]))), (adm_hi[1] & (~(1'd0 | adm_hi[0]))),
                       (adm_hi[0] & (~1'd0))} :
                   {(adm_c[9] & (~adm_g_c6)), (adm_c[8] & (~((adm_g_c5 | adm_c[6]) | adm_c[7]))),
                    (adm_c[7] & (~(adm_g_c5 | adm_c[6]))), (adm_c[6] & (~adm_g_c5)),
                    (adm_c[5] & (~((adm_g_c4 | adm_c[3]) | adm_c[4]))), (adm_c[4] & (~(adm_g_c4 | adm_c[3]))),
                    (adm_c[3] & (~adm_g_c4)), (adm_c[2] & (~((1'd0 | adm_c[0]) | adm_c[1]))),
                    (adm_c[1] & (~(1'd0 | adm_c[0]))), (adm_c[0] & (~1'd0))});
    assign adm_msk_n = {(adm_hi_any ? adm_g_c3 : adm_g_c6),
                        (adm_hi_any ? (adm_g_c2 | adm_hi[7]) : ((adm_g_c5 | adm_c[6]) | adm_c[7])),
                        (adm_hi_any ? adm_g_c2 : (adm_g_c5 | adm_c[6])),
                        (adm_hi_any ? (adm_g_c1 | adm_hi[5]) : adm_g_c5),
                        (adm_hi_any ? adm_g_c1 : ((adm_g_c4 | adm_c[3]) | adm_c[4])),
                        (adm_hi_any ? (adm_g_c0 | adm_hi[3]) : (adm_g_c4 | adm_c[3])),
                        (adm_hi_any ? adm_g_c0 : adm_g_c4),
                        (adm_hi_any ? ((1'd0 | adm_hi[0]) | adm_hi[1]) : ((1'd0 | adm_c[0]) | adm_c[1])),
                        (adm_hi_any ? (1'd0 | adm_hi[0]) : (1'd0 | adm_c[0])), 1'd0};
    assign adm_msk_nx = (adm_any ? adm_msk_n : adm_msk);
    assign mst_0_adm_rd = adm_g[0];
    assign mst_0_adm_wr = adm_g[1];
    assign rd_0_pop = mst_0_adm_rd;
    assign wr_0_pop = mst_0_adm_wr;
    assign mst_1_adm_rd = adm_g[2];
    assign mst_1_adm_wr = adm_g[3];
    assign rd_1_pop = mst_1_adm_rd;
    assign wr_1_pop = mst_1_adm_wr;
    assign mst_2_adm_rd = adm_g[4];
    assign mst_2_adm_wr = adm_g[5];
    assign rd_2_pop = mst_2_adm_rd;
    assign wr_2_pop = mst_2_adm_wr;
    assign mst_3_adm_rd = adm_g[6];
    assign mst_3_adm_wr = adm_g[7];
    assign rd_3_pop = mst_3_adm_rd;
    assign wr_3_pop = mst_3_adm_wr;
    assign mst_4_adm_rd = adm_g[8];
    assign mst_4_adm_wr = adm_g[9];
    assign rd_4_pop = mst_4_adm_rd;
    assign wr_4_pop = mst_4_adm_wr;
    assign adm_wr_dram = (((((1'd0 | (mst_0_adm_wr & (~wr_0_loc))) | (mst_1_adm_wr & (~wr_1_loc)))
                          | (mst_2_adm_wr & (~wr_2_loc))) | (mst_3_adm_wr & (~wr_3_loc)))
                          | (mst_4_adm_wr & (~wr_4_loc)));
    assign n_cand = ((((((((((4'd0 + {3'd0, mst_0_cand_rd}) + {3'd0, mst_0_cand_wr}) + {3'd0, mst_1_cand_rd})
                     + {3'd0, mst_1_cand_wr}) + {3'd0, mst_2_cand_rd}) + {3'd0, mst_2_cand_wr}) + {3'd0, mst_3_cand_rd})
                     + {3'd0, mst_3_cand_wr}) + {3'd0, mst_4_cand_rd}) + {3'd0, mst_4_cand_wr});
    assign dbg_port_stall = (adm_any ? (n_cand - 1) : 4'd0);
    assign dbg_admit = adm_any;
    assign mst_0_rhd_id = raq_id_0[mst_0_ra_rp];
    assign mst_0_rhd_tag = raq_tag_0[mst_0_ra_rp];
    assign mst_0_rhd_addr = raq_addr_0[mst_0_ra_rp];
    assign mst_0_rhd_bytes = raq_bytes_0[mst_0_ra_rp];
    assign mst_0_rhd_rows = raq_rows_0[mst_0_ra_rp];
    assign mst_0_rhd_stride = raq_stride_0[mst_0_ra_rp];
    assign mst_0_rhd_loc = raq_loc_0[mst_0_ra_rp];
    assign mst_0_rhd_gs = raq_gs_0[mst_0_ra_rp];
    assign mst_0_rhd_c1 = raq_c1_0[mst_0_ra_rp];
    assign mst_0_rhd_c2 = raq_c2_0[mst_0_ra_rp];
    assign mst_0_rhd_ngs = ({1'd0, mst_0_rhd_bytes} + {13'd0, mst_0_rhd_c1});
    assign mst_0_whd_id = waq_id_0[mst_0_wa_rp];
    assign mst_0_whd_tag = waq_tag_0[mst_0_wa_rp];
    assign mst_0_whd_addr = waq_addr_0[mst_0_wa_rp];
    assign mst_0_whd_bytes = waq_bytes_0[mst_0_wa_rp];
    assign mst_0_whd_rows = waq_rows_0[mst_0_wa_rp];
    assign mst_0_whd_stride = waq_stride_0[mst_0_wa_rp];
    assign mst_0_whd_loc = waq_loc_0[mst_0_wa_rp];
    assign mst_0_whd_gs = waq_gs_0[mst_0_wa_rp];
    assign mst_0_whd_c1 = waq_c1_0[mst_0_wa_rp];
    assign mst_0_whd_c2 = waq_c2_0[mst_0_wa_rp];
    assign mst_0_whd_ngs = ({1'd0, mst_0_whd_bytes} + {13'd0, mst_0_whd_c1});
    assign mst_1_rhd_id = raq_id_1[mst_1_ra_rp];
    assign mst_1_rhd_tag = raq_tag_1[mst_1_ra_rp];
    assign mst_1_rhd_addr = raq_addr_1[mst_1_ra_rp];
    assign mst_1_rhd_bytes = raq_bytes_1[mst_1_ra_rp];
    assign mst_1_rhd_rows = raq_rows_1[mst_1_ra_rp];
    assign mst_1_rhd_stride = raq_stride_1[mst_1_ra_rp];
    assign mst_1_rhd_loc = raq_loc_1[mst_1_ra_rp];
    assign mst_1_rhd_gs = raq_gs_1[mst_1_ra_rp];
    assign mst_1_rhd_c1 = raq_c1_1[mst_1_ra_rp];
    assign mst_1_rhd_c2 = raq_c2_1[mst_1_ra_rp];
    assign mst_1_rhd_ngs = ({1'd0, mst_1_rhd_bytes} + {13'd0, mst_1_rhd_c1});
    assign mst_1_whd_id = waq_id_1[mst_1_wa_rp];
    assign mst_1_whd_tag = waq_tag_1[mst_1_wa_rp];
    assign mst_1_whd_addr = waq_addr_1[mst_1_wa_rp];
    assign mst_1_whd_bytes = waq_bytes_1[mst_1_wa_rp];
    assign mst_1_whd_rows = waq_rows_1[mst_1_wa_rp];
    assign mst_1_whd_stride = waq_stride_1[mst_1_wa_rp];
    assign mst_1_whd_loc = waq_loc_1[mst_1_wa_rp];
    assign mst_1_whd_gs = waq_gs_1[mst_1_wa_rp];
    assign mst_1_whd_c1 = waq_c1_1[mst_1_wa_rp];
    assign mst_1_whd_c2 = waq_c2_1[mst_1_wa_rp];
    assign mst_1_whd_ngs = ({1'd0, mst_1_whd_bytes} + {13'd0, mst_1_whd_c1});
    assign mst_2_rhd_id = raq_id_2[mst_2_ra_rp];
    assign mst_2_rhd_tag = raq_tag_2[mst_2_ra_rp];
    assign mst_2_rhd_addr = raq_addr_2[mst_2_ra_rp];
    assign mst_2_rhd_bytes = raq_bytes_2[mst_2_ra_rp];
    assign mst_2_rhd_rows = raq_rows_2[mst_2_ra_rp];
    assign mst_2_rhd_stride = raq_stride_2[mst_2_ra_rp];
    assign mst_2_rhd_loc = raq_loc_2[mst_2_ra_rp];
    assign mst_2_rhd_gs = raq_gs_2[mst_2_ra_rp];
    assign mst_2_rhd_c1 = raq_c1_2[mst_2_ra_rp];
    assign mst_2_rhd_c2 = raq_c2_2[mst_2_ra_rp];
    assign mst_2_rhd_ngs = ({1'd0, mst_2_rhd_bytes} + {13'd0, mst_2_rhd_c1});
    assign mst_2_whd_id = waq_id_2[mst_2_wa_rp];
    assign mst_2_whd_tag = waq_tag_2[mst_2_wa_rp];
    assign mst_2_whd_addr = waq_addr_2[mst_2_wa_rp];
    assign mst_2_whd_bytes = waq_bytes_2[mst_2_wa_rp];
    assign mst_2_whd_rows = waq_rows_2[mst_2_wa_rp];
    assign mst_2_whd_stride = waq_stride_2[mst_2_wa_rp];
    assign mst_2_whd_loc = waq_loc_2[mst_2_wa_rp];
    assign mst_2_whd_gs = waq_gs_2[mst_2_wa_rp];
    assign mst_2_whd_c1 = waq_c1_2[mst_2_wa_rp];
    assign mst_2_whd_c2 = waq_c2_2[mst_2_wa_rp];
    assign mst_2_whd_ngs = ({1'd0, mst_2_whd_bytes} + {13'd0, mst_2_whd_c1});
    assign mst_3_rhd_id = raq_id_3[mst_3_ra_rp];
    assign mst_3_rhd_tag = raq_tag_3[mst_3_ra_rp];
    assign mst_3_rhd_addr = raq_addr_3[mst_3_ra_rp];
    assign mst_3_rhd_bytes = raq_bytes_3[mst_3_ra_rp];
    assign mst_3_rhd_rows = raq_rows_3[mst_3_ra_rp];
    assign mst_3_rhd_stride = raq_stride_3[mst_3_ra_rp];
    assign mst_3_rhd_loc = raq_loc_3[mst_3_ra_rp];
    assign mst_3_rhd_gs = raq_gs_3[mst_3_ra_rp];
    assign mst_3_rhd_c1 = raq_c1_3[mst_3_ra_rp];
    assign mst_3_rhd_c2 = raq_c2_3[mst_3_ra_rp];
    assign mst_3_rhd_ngs = ({1'd0, mst_3_rhd_bytes} + {13'd0, mst_3_rhd_c1});
    assign mst_3_whd_id = waq_id_3[mst_3_wa_rp];
    assign mst_3_whd_tag = waq_tag_3[mst_3_wa_rp];
    assign mst_3_whd_addr = waq_addr_3[mst_3_wa_rp];
    assign mst_3_whd_bytes = waq_bytes_3[mst_3_wa_rp];
    assign mst_3_whd_rows = waq_rows_3[mst_3_wa_rp];
    assign mst_3_whd_stride = waq_stride_3[mst_3_wa_rp];
    assign mst_3_whd_loc = waq_loc_3[mst_3_wa_rp];
    assign mst_3_whd_gs = waq_gs_3[mst_3_wa_rp];
    assign mst_3_whd_c1 = waq_c1_3[mst_3_wa_rp];
    assign mst_3_whd_c2 = waq_c2_3[mst_3_wa_rp];
    assign mst_3_whd_ngs = ({1'd0, mst_3_whd_bytes} + {13'd0, mst_3_whd_c1});
    assign mst_4_rhd_id = raq_id_4[mst_4_ra_rp];
    assign mst_4_rhd_tag = raq_tag_4[mst_4_ra_rp];
    assign mst_4_rhd_addr = raq_addr_4[mst_4_ra_rp];
    assign mst_4_rhd_bytes = raq_bytes_4[mst_4_ra_rp];
    assign mst_4_rhd_rows = raq_rows_4[mst_4_ra_rp];
    assign mst_4_rhd_stride = raq_stride_4[mst_4_ra_rp];
    assign mst_4_rhd_loc = raq_loc_4[mst_4_ra_rp];
    assign mst_4_rhd_gs = raq_gs_4[mst_4_ra_rp];
    assign mst_4_rhd_c1 = raq_c1_4[mst_4_ra_rp];
    assign mst_4_rhd_c2 = raq_c2_4[mst_4_ra_rp];
    assign mst_4_rhd_ngs = ({1'd0, mst_4_rhd_bytes} + {13'd0, mst_4_rhd_c1});
    assign mst_4_whd_id = waq_id_4[mst_4_wa_rp];
    assign mst_4_whd_tag = waq_tag_4[mst_4_wa_rp];
    assign mst_4_whd_addr = waq_addr_4[mst_4_wa_rp];
    assign mst_4_whd_bytes = waq_bytes_4[mst_4_wa_rp];
    assign mst_4_whd_rows = waq_rows_4[mst_4_wa_rp];
    assign mst_4_whd_stride = waq_stride_4[mst_4_wa_rp];
    assign mst_4_whd_loc = waq_loc_4[mst_4_wa_rp];
    assign mst_4_whd_gs = waq_gs_4[mst_4_wa_rp];
    assign mst_4_whd_c1 = waq_c1_4[mst_4_wa_rp];
    assign mst_4_whd_c2 = waq_c2_4[mst_4_wa_rp];
    assign mst_4_whd_ngs = ({1'd0, mst_4_whd_bytes} + {13'd0, mst_4_whd_c1});
    assign mst_0_rload = ((~mst_0_ga_act) & mst_0_ra_neq);
    assign mst_0_wload = ((~mst_0_gw_act) & mst_0_wa_neq);
    assign ldB_g_0 = ((((1'd0 | ((ldB_rr == 0) & ((~mst_1_ga_act) & mst_1_ra_neq)))
                      | ((ldB_rr == 1)
                         & (((((~mst_1_ga_act) & mst_1_ra_neq) & (~((~mst_2_ga_act) & mst_2_ra_neq)))
                            & (~((~mst_3_ga_act) & mst_3_ra_neq))) & (~((~mst_4_ga_act) & mst_4_ra_neq)))))
                      | ((ldB_rr == 2)
                         & ((((~mst_1_ga_act) & mst_1_ra_neq) & (~((~mst_3_ga_act) & mst_3_ra_neq)))
                            & (~((~mst_4_ga_act) & mst_4_ra_neq)))))
                      | ((ldB_rr == 3) & (((~mst_1_ga_act) & mst_1_ra_neq) & (~((~mst_4_ga_act) & mst_4_ra_neq)))));
    assign ldB_g_1 = ((((1'd0
                      | ((ldB_rr == 0) & (((~mst_2_ga_act) & mst_2_ra_neq) & (~((~mst_1_ga_act) & mst_1_ra_neq)))))
                      | ((ldB_rr == 1) & ((~mst_2_ga_act) & mst_2_ra_neq)))
                      | ((ldB_rr == 2)
                         & (((((~mst_2_ga_act) & mst_2_ra_neq) & (~((~mst_3_ga_act) & mst_3_ra_neq)))
                            & (~((~mst_4_ga_act) & mst_4_ra_neq))) & (~((~mst_1_ga_act) & mst_1_ra_neq)))))
                      | ((ldB_rr == 3)
                         & ((((~mst_2_ga_act) & mst_2_ra_neq) & (~((~mst_4_ga_act) & mst_4_ra_neq)))
                            & (~((~mst_1_ga_act) & mst_1_ra_neq)))));
    assign ldB_g_2 = ((((1'd0
                      | ((ldB_rr == 0)
                         & ((((~mst_3_ga_act) & mst_3_ra_neq) & (~((~mst_1_ga_act) & mst_1_ra_neq)))
                            & (~((~mst_2_ga_act) & mst_2_ra_neq)))))
                      | ((ldB_rr == 1) & (((~mst_3_ga_act) & mst_3_ra_neq) & (~((~mst_2_ga_act) & mst_2_ra_neq)))))
                      | ((ldB_rr == 2) & ((~mst_3_ga_act) & mst_3_ra_neq)))
                      | ((ldB_rr == 3)
                         & (((((~mst_3_ga_act) & mst_3_ra_neq) & (~((~mst_4_ga_act) & mst_4_ra_neq)))
                            & (~((~mst_1_ga_act) & mst_1_ra_neq))) & (~((~mst_2_ga_act) & mst_2_ra_neq)))));
    assign ldB_g_3 = ((((1'd0
                      | ((ldB_rr == 0)
                         & (((((~mst_4_ga_act) & mst_4_ra_neq) & (~((~mst_1_ga_act) & mst_1_ra_neq)))
                            & (~((~mst_2_ga_act) & mst_2_ra_neq))) & (~((~mst_3_ga_act) & mst_3_ra_neq)))))
                      | ((ldB_rr == 1)
                         & ((((~mst_4_ga_act) & mst_4_ra_neq) & (~((~mst_2_ga_act) & mst_2_ra_neq)))
                            & (~((~mst_3_ga_act) & mst_3_ra_neq)))))
                      | ((ldB_rr == 2) & (((~mst_4_ga_act) & mst_4_ra_neq) & (~((~mst_3_ga_act) & mst_3_ra_neq)))))
                      | ((ldB_rr == 3) & ((~mst_4_ga_act) & mst_4_ra_neq)));
    assign lwB_g_0 = ((((1'd0 | ((lwB_rr == 0) & ((~mst_1_gw_act) & mst_1_wa_neq)))
                      | ((lwB_rr == 1)
                         & (((((~mst_1_gw_act) & mst_1_wa_neq) & (~((~mst_2_gw_act) & mst_2_wa_neq)))
                            & (~((~mst_3_gw_act) & mst_3_wa_neq))) & (~((~mst_4_gw_act) & mst_4_wa_neq)))))
                      | ((lwB_rr == 2)
                         & ((((~mst_1_gw_act) & mst_1_wa_neq) & (~((~mst_3_gw_act) & mst_3_wa_neq)))
                            & (~((~mst_4_gw_act) & mst_4_wa_neq)))))
                      | ((lwB_rr == 3) & (((~mst_1_gw_act) & mst_1_wa_neq) & (~((~mst_4_gw_act) & mst_4_wa_neq)))));
    assign lwB_g_1 = ((((1'd0
                      | ((lwB_rr == 0) & (((~mst_2_gw_act) & mst_2_wa_neq) & (~((~mst_1_gw_act) & mst_1_wa_neq)))))
                      | ((lwB_rr == 1) & ((~mst_2_gw_act) & mst_2_wa_neq)))
                      | ((lwB_rr == 2)
                         & (((((~mst_2_gw_act) & mst_2_wa_neq) & (~((~mst_3_gw_act) & mst_3_wa_neq)))
                            & (~((~mst_4_gw_act) & mst_4_wa_neq))) & (~((~mst_1_gw_act) & mst_1_wa_neq)))))
                      | ((lwB_rr == 3)
                         & ((((~mst_2_gw_act) & mst_2_wa_neq) & (~((~mst_4_gw_act) & mst_4_wa_neq)))
                            & (~((~mst_1_gw_act) & mst_1_wa_neq)))));
    assign lwB_g_2 = ((((1'd0
                      | ((lwB_rr == 0)
                         & ((((~mst_3_gw_act) & mst_3_wa_neq) & (~((~mst_1_gw_act) & mst_1_wa_neq)))
                            & (~((~mst_2_gw_act) & mst_2_wa_neq)))))
                      | ((lwB_rr == 1) & (((~mst_3_gw_act) & mst_3_wa_neq) & (~((~mst_2_gw_act) & mst_2_wa_neq)))))
                      | ((lwB_rr == 2) & ((~mst_3_gw_act) & mst_3_wa_neq)))
                      | ((lwB_rr == 3)
                         & (((((~mst_3_gw_act) & mst_3_wa_neq) & (~((~mst_4_gw_act) & mst_4_wa_neq)))
                            & (~((~mst_1_gw_act) & mst_1_wa_neq))) & (~((~mst_2_gw_act) & mst_2_wa_neq)))));
    assign lwB_g_3 = ((((1'd0
                      | ((lwB_rr == 0)
                         & (((((~mst_4_gw_act) & mst_4_wa_neq) & (~((~mst_1_gw_act) & mst_1_wa_neq)))
                            & (~((~mst_2_gw_act) & mst_2_wa_neq))) & (~((~mst_3_gw_act) & mst_3_wa_neq)))))
                      | ((lwB_rr == 1)
                         & ((((~mst_4_gw_act) & mst_4_wa_neq) & (~((~mst_2_gw_act) & mst_2_wa_neq)))
                            & (~((~mst_3_gw_act) & mst_3_wa_neq)))))
                      | ((lwB_rr == 2) & (((~mst_4_gw_act) & mst_4_wa_neq) & (~((~mst_3_gw_act) & mst_3_wa_neq)))))
                      | ((lwB_rr == 3) & ((~mst_4_gw_act) & mst_4_wa_neq)));
    assign ldB_any = (((((~mst_1_ga_act) & mst_1_ra_neq) | ((~mst_2_ga_act) & mst_2_ra_neq))
                      | ((~mst_3_ga_act) & mst_3_ra_neq)) | ((~mst_4_ga_act) & mst_4_ra_neq));
    assign ldB_k = ((ldB_rr == 0)
                    ? (((~mst_1_ga_act) & mst_1_ra_neq) ? 2'd0 :
                      (((~mst_2_ga_act) & mst_2_ra_neq) ? 2'd1 :
                      (((~mst_3_ga_act) & mst_3_ra_neq) ? 2'd2 :
                      2'd3))) :
                   ((ldB_rr == 1)
                    ? (((~mst_2_ga_act) & mst_2_ra_neq) ? 2'd1 :
                      (((~mst_3_ga_act) & mst_3_ra_neq) ? 2'd2 :
                      (((~mst_4_ga_act) & mst_4_ra_neq) ? 2'd3 :
                      2'd0))) :
                   ((ldB_rr == 2)
                    ? (((~mst_3_ga_act) & mst_3_ra_neq) ? 2'd2 :
                      (((~mst_4_ga_act) & mst_4_ra_neq) ? 2'd3 :
                      (((~mst_1_ga_act) & mst_1_ra_neq) ? 2'd0 :
                      2'd1))) :
                   (((~mst_4_ga_act) & mst_4_ra_neq) ? 2'd3 :
                   (((~mst_1_ga_act) & mst_1_ra_neq) ? 2'd0 :
                   (((~mst_2_ga_act) & mst_2_ra_neq) ? 2'd1 :
                   2'd2))))));
    assign lwB_any = (((((~mst_1_gw_act) & mst_1_wa_neq) | ((~mst_2_gw_act) & mst_2_wa_neq))
                      | ((~mst_3_gw_act) & mst_3_wa_neq)) | ((~mst_4_gw_act) & mst_4_wa_neq));
    assign lwB_k = ((lwB_rr == 0)
                    ? (((~mst_1_gw_act) & mst_1_wa_neq) ? 2'd0 :
                      (((~mst_2_gw_act) & mst_2_wa_neq) ? 2'd1 :
                      (((~mst_3_gw_act) & mst_3_wa_neq) ? 2'd2 :
                      2'd3))) :
                   ((lwB_rr == 1)
                    ? (((~mst_2_gw_act) & mst_2_wa_neq) ? 2'd1 :
                      (((~mst_3_gw_act) & mst_3_wa_neq) ? 2'd2 :
                      (((~mst_4_gw_act) & mst_4_wa_neq) ? 2'd3 :
                      2'd0))) :
                   ((lwB_rr == 2)
                    ? (((~mst_3_gw_act) & mst_3_wa_neq) ? 2'd2 :
                      (((~mst_4_gw_act) & mst_4_wa_neq) ? 2'd3 :
                      (((~mst_1_gw_act) & mst_1_wa_neq) ? 2'd0 :
                      2'd1))) :
                   (((~mst_4_gw_act) & mst_4_wa_neq) ? 2'd3 :
                   (((~mst_1_gw_act) & mst_1_wa_neq) ? 2'd0 :
                   (((~mst_2_gw_act) & mst_2_wa_neq) ? 2'd1 :
                   2'd2))))));
    assign mst_1_rload = ldB_g_0;
    assign mst_1_wload = lwB_g_0;
    assign mst_2_rload = ldB_g_1;
    assign mst_2_wload = lwB_g_1;
    assign mst_3_rload = ldB_g_2;
    assign mst_3_wload = lwB_g_2;
    assign mst_4_rload = ldB_g_3;
    assign mst_4_wload = lwB_g_3;
    assign mst_0_ra_fn0 = (mst_0_rload ? (mst_0_ra_cnt == 9) : (mst_0_ra_cnt == 8));
    assign mst_0_ra_fn1 = (mst_0_rload ? (mst_0_ra_cnt == 8) : (mst_0_ra_cnt == 7));
    assign mst_0_ra_f_n = (mst_0_adm_rd ? mst_0_ra_fn1 : mst_0_ra_fn0);
    assign mst_0_ra_ne_n = ((mst_0_adm_rd & (~mst_0_rload)) ? (mst_0_ra_cnt != 15) :
                           ((mst_0_rload & (~mst_0_adm_rd)) ? (mst_0_ra_cnt != 1) :
                           (mst_0_ra_cnt != 0)));
    assign adm_t_0_0 = (rd_0_nz & (~mst_0_ra_fn0));
    assign adm_t_0_1 = (rd_0_nm & (~mst_0_ra_fn0));
    assign adm_t_0_2 = (rd_0_n1 & (~mst_0_ra_fn1));
    assign adm_t_0_3 = (rd_0_nz & (~mst_0_ra_fn1));
    assign adm_th_0_0 = (adm_t_0_0 & adm_msk_nx[0]);
    assign adm_th_0_1 = (adm_t_0_1 & adm_msk_nx[0]);
    assign mst_0_wa_fn0 = (mst_0_wload ? (mst_0_wa_cnt == 9) : (mst_0_wa_cnt == 8));
    assign mst_0_wa_fn1 = (mst_0_wload ? (mst_0_wa_cnt == 8) : (mst_0_wa_cnt == 7));
    assign mst_0_wa_f_n = (mst_0_adm_wr ? mst_0_wa_fn1 : mst_0_wa_fn0);
    assign mst_0_wa_ne_n = ((mst_0_adm_wr & (~mst_0_wload)) ? (mst_0_wa_cnt != 15) :
                           ((mst_0_wload & (~mst_0_adm_wr)) ? (mst_0_wa_cnt != 1) :
                           (mst_0_wa_cnt != 0)));
    assign adm_t_1_0 = (wr_0_nz & (~mst_0_wa_fn0));
    assign adm_t_1_1 = (wr_0_nm & (~mst_0_wa_fn0));
    assign adm_t_1_2 = (wr_0_n1 & (~mst_0_wa_fn1));
    assign adm_t_1_3 = (wr_0_nz & (~mst_0_wa_fn1));
    assign adm_th_1_0 = (adm_t_1_0 & adm_msk_nx[1]);
    assign adm_th_1_1 = (adm_t_1_1 & adm_msk_nx[1]);
    assign mst_1_ra_fn0 = (mst_1_rload ? (mst_1_ra_cnt == 9) : (mst_1_ra_cnt == 8));
    assign mst_1_ra_fn1 = (mst_1_rload ? (mst_1_ra_cnt == 8) : (mst_1_ra_cnt == 7));
    assign mst_1_ra_f_n = (mst_1_adm_rd ? mst_1_ra_fn1 : mst_1_ra_fn0);
    assign mst_1_ra_ne_n = ((mst_1_adm_rd & (~mst_1_rload)) ? (mst_1_ra_cnt != 15) :
                           ((mst_1_rload & (~mst_1_adm_rd)) ? (mst_1_ra_cnt != 1) :
                           (mst_1_ra_cnt != 0)));
    assign adm_t_2_0 = (rd_1_nz & (~mst_1_ra_fn0));
    assign adm_t_2_1 = (rd_1_nm & (~mst_1_ra_fn0));
    assign adm_t_2_2 = (rd_1_n1 & (~mst_1_ra_fn1));
    assign adm_t_2_3 = (rd_1_nz & (~mst_1_ra_fn1));
    assign adm_th_2_0 = (adm_t_2_0 & adm_msk_nx[2]);
    assign adm_th_2_1 = (adm_t_2_1 & adm_msk_nx[2]);
    assign mst_1_wa_fn0 = (mst_1_wload ? (mst_1_wa_cnt == 9) : (mst_1_wa_cnt == 8));
    assign mst_1_wa_fn1 = (mst_1_wload ? (mst_1_wa_cnt == 8) : (mst_1_wa_cnt == 7));
    assign mst_1_wa_f_n = (mst_1_adm_wr ? mst_1_wa_fn1 : mst_1_wa_fn0);
    assign mst_1_wa_ne_n = ((mst_1_adm_wr & (~mst_1_wload)) ? (mst_1_wa_cnt != 15) :
                           ((mst_1_wload & (~mst_1_adm_wr)) ? (mst_1_wa_cnt != 1) :
                           (mst_1_wa_cnt != 0)));
    assign adm_t_3_0 = (wr_1_nz & (~mst_1_wa_fn0));
    assign adm_t_3_1 = (wr_1_nm & (~mst_1_wa_fn0));
    assign adm_t_3_2 = (wr_1_n1 & (~mst_1_wa_fn1));
    assign adm_t_3_3 = (wr_1_nz & (~mst_1_wa_fn1));
    assign adm_th_3_0 = (adm_t_3_0 & adm_msk_nx[3]);
    assign adm_th_3_1 = (adm_t_3_1 & adm_msk_nx[3]);
    assign mst_2_ra_fn0 = (mst_2_rload ? (mst_2_ra_cnt == 9) : (mst_2_ra_cnt == 8));
    assign mst_2_ra_fn1 = (mst_2_rload ? (mst_2_ra_cnt == 8) : (mst_2_ra_cnt == 7));
    assign mst_2_ra_f_n = (mst_2_adm_rd ? mst_2_ra_fn1 : mst_2_ra_fn0);
    assign mst_2_ra_ne_n = ((mst_2_adm_rd & (~mst_2_rload)) ? (mst_2_ra_cnt != 15) :
                           ((mst_2_rload & (~mst_2_adm_rd)) ? (mst_2_ra_cnt != 1) :
                           (mst_2_ra_cnt != 0)));
    assign adm_t_4_0 = (rd_2_nz & (~mst_2_ra_fn0));
    assign adm_t_4_1 = (rd_2_nm & (~mst_2_ra_fn0));
    assign adm_t_4_2 = (rd_2_n1 & (~mst_2_ra_fn1));
    assign adm_t_4_3 = (rd_2_nz & (~mst_2_ra_fn1));
    assign adm_th_4_0 = (adm_t_4_0 & adm_msk_nx[4]);
    assign adm_th_4_1 = (adm_t_4_1 & adm_msk_nx[4]);
    assign mst_2_wa_fn0 = (mst_2_wload ? (mst_2_wa_cnt == 9) : (mst_2_wa_cnt == 8));
    assign mst_2_wa_fn1 = (mst_2_wload ? (mst_2_wa_cnt == 8) : (mst_2_wa_cnt == 7));
    assign mst_2_wa_f_n = (mst_2_adm_wr ? mst_2_wa_fn1 : mst_2_wa_fn0);
    assign mst_2_wa_ne_n = ((mst_2_adm_wr & (~mst_2_wload)) ? (mst_2_wa_cnt != 15) :
                           ((mst_2_wload & (~mst_2_adm_wr)) ? (mst_2_wa_cnt != 1) :
                           (mst_2_wa_cnt != 0)));
    assign adm_t_5_0 = (wr_2_nz & (~mst_2_wa_fn0));
    assign adm_t_5_1 = (wr_2_nm & (~mst_2_wa_fn0));
    assign adm_t_5_2 = (wr_2_n1 & (~mst_2_wa_fn1));
    assign adm_t_5_3 = (wr_2_nz & (~mst_2_wa_fn1));
    assign adm_th_5_0 = (adm_t_5_0 & adm_msk_nx[5]);
    assign adm_th_5_1 = (adm_t_5_1 & adm_msk_nx[5]);
    assign mst_3_ra_fn0 = (mst_3_rload ? (mst_3_ra_cnt == 9) : (mst_3_ra_cnt == 8));
    assign mst_3_ra_fn1 = (mst_3_rload ? (mst_3_ra_cnt == 8) : (mst_3_ra_cnt == 7));
    assign mst_3_ra_f_n = (mst_3_adm_rd ? mst_3_ra_fn1 : mst_3_ra_fn0);
    assign mst_3_ra_ne_n = ((mst_3_adm_rd & (~mst_3_rload)) ? (mst_3_ra_cnt != 15) :
                           ((mst_3_rload & (~mst_3_adm_rd)) ? (mst_3_ra_cnt != 1) :
                           (mst_3_ra_cnt != 0)));
    assign adm_t_6_0 = (rd_3_nz & (~mst_3_ra_fn0));
    assign adm_t_6_1 = (rd_3_nm & (~mst_3_ra_fn0));
    assign adm_t_6_2 = (rd_3_n1 & (~mst_3_ra_fn1));
    assign adm_t_6_3 = (rd_3_nz & (~mst_3_ra_fn1));
    assign adm_th_6_0 = (adm_t_6_0 & adm_msk_nx[6]);
    assign adm_th_6_1 = (adm_t_6_1 & adm_msk_nx[6]);
    assign mst_3_wa_fn0 = (mst_3_wload ? (mst_3_wa_cnt == 9) : (mst_3_wa_cnt == 8));
    assign mst_3_wa_fn1 = (mst_3_wload ? (mst_3_wa_cnt == 8) : (mst_3_wa_cnt == 7));
    assign mst_3_wa_f_n = (mst_3_adm_wr ? mst_3_wa_fn1 : mst_3_wa_fn0);
    assign mst_3_wa_ne_n = ((mst_3_adm_wr & (~mst_3_wload)) ? (mst_3_wa_cnt != 15) :
                           ((mst_3_wload & (~mst_3_adm_wr)) ? (mst_3_wa_cnt != 1) :
                           (mst_3_wa_cnt != 0)));
    assign adm_t_7_0 = (wr_3_nz & (~mst_3_wa_fn0));
    assign adm_t_7_1 = (wr_3_nm & (~mst_3_wa_fn0));
    assign adm_t_7_2 = (wr_3_n1 & (~mst_3_wa_fn1));
    assign adm_t_7_3 = (wr_3_nz & (~mst_3_wa_fn1));
    assign adm_th_7_0 = (adm_t_7_0 & adm_msk_nx[7]);
    assign adm_th_7_1 = (adm_t_7_1 & adm_msk_nx[7]);
    assign mst_4_ra_fn0 = (mst_4_rload ? (mst_4_ra_cnt == 9) : (mst_4_ra_cnt == 8));
    assign mst_4_ra_fn1 = (mst_4_rload ? (mst_4_ra_cnt == 8) : (mst_4_ra_cnt == 7));
    assign mst_4_ra_f_n = (mst_4_adm_rd ? mst_4_ra_fn1 : mst_4_ra_fn0);
    assign mst_4_ra_ne_n = ((mst_4_adm_rd & (~mst_4_rload)) ? (mst_4_ra_cnt != 15) :
                           ((mst_4_rload & (~mst_4_adm_rd)) ? (mst_4_ra_cnt != 1) :
                           (mst_4_ra_cnt != 0)));
    assign adm_t_8_0 = (rd_4_nz & (~mst_4_ra_fn0));
    assign adm_t_8_1 = (rd_4_nm & (~mst_4_ra_fn0));
    assign adm_t_8_2 = (rd_4_n1 & (~mst_4_ra_fn1));
    assign adm_t_8_3 = (rd_4_nz & (~mst_4_ra_fn1));
    assign adm_th_8_0 = (adm_t_8_0 & adm_msk_nx[8]);
    assign adm_th_8_1 = (adm_t_8_1 & adm_msk_nx[8]);
    assign mst_4_wa_fn0 = (mst_4_wload ? (mst_4_wa_cnt == 9) : (mst_4_wa_cnt == 8));
    assign mst_4_wa_fn1 = (mst_4_wload ? (mst_4_wa_cnt == 8) : (mst_4_wa_cnt == 7));
    assign mst_4_wa_f_n = (mst_4_adm_wr ? mst_4_wa_fn1 : mst_4_wa_fn0);
    assign mst_4_wa_ne_n = ((mst_4_adm_wr & (~mst_4_wload)) ? (mst_4_wa_cnt != 15) :
                           ((mst_4_wload & (~mst_4_adm_wr)) ? (mst_4_wa_cnt != 1) :
                           (mst_4_wa_cnt != 0)));
    assign adm_t_9_0 = (wr_4_nz & (~mst_4_wa_fn0));
    assign adm_t_9_1 = (wr_4_nm & (~mst_4_wa_fn0));
    assign adm_t_9_2 = (wr_4_n1 & (~mst_4_wa_fn1));
    assign adm_t_9_3 = (wr_4_nz & (~mst_4_wa_fn1));
    assign adm_th_9_0 = (adm_t_9_0 & adm_msk_nx[9]);
    assign adm_th_9_1 = (adm_t_9_1 & adm_msk_nx[9]);
    assign adm_c_n = {(mst_4_adm_wr ? (wr_4_psh ? adm_t_9_3 : adm_t_9_2) : (wr_4_psh ? adm_t_9_1 : adm_t_9_0)),
                      (mst_4_adm_rd ? (rd_4_psh ? adm_t_8_3 : adm_t_8_2) : (rd_4_psh ? adm_t_8_1 : adm_t_8_0)),
                      (mst_3_adm_wr ? (wr_3_psh ? adm_t_7_3 : adm_t_7_2) : (wr_3_psh ? adm_t_7_1 : adm_t_7_0)),
                      (mst_3_adm_rd ? (rd_3_psh ? adm_t_6_3 : adm_t_6_2) : (rd_3_psh ? adm_t_6_1 : adm_t_6_0)),
                      (mst_2_adm_wr ? (wr_2_psh ? adm_t_5_3 : adm_t_5_2) : (wr_2_psh ? adm_t_5_1 : adm_t_5_0)),
                      (mst_2_adm_rd ? (rd_2_psh ? adm_t_4_3 : adm_t_4_2) : (rd_2_psh ? adm_t_4_1 : adm_t_4_0)),
                      (mst_1_adm_wr ? (wr_1_psh ? adm_t_3_3 : adm_t_3_2) : (wr_1_psh ? adm_t_3_1 : adm_t_3_0)),
                      (mst_1_adm_rd ? (rd_1_psh ? adm_t_2_3 : adm_t_2_2) : (rd_1_psh ? adm_t_2_1 : adm_t_2_0)),
                      (mst_0_adm_wr ? (wr_0_psh ? adm_t_1_3 : adm_t_1_2) : (wr_0_psh ? adm_t_1_1 : adm_t_1_0)),
                      (mst_0_adm_rd ? (rd_0_psh ? adm_t_0_3 : adm_t_0_2) : (rd_0_psh ? adm_t_0_1 : adm_t_0_0))};
    assign adm_h_n = {(mst_4_adm_wr ? 1'd0 : (wr_4_psh ? adm_th_9_1 : adm_th_9_0)),
                      (mst_4_adm_rd ? 1'd0 : (rd_4_psh ? adm_th_8_1 : adm_th_8_0)),
                      (mst_3_adm_wr ? 1'd0 : (wr_3_psh ? adm_th_7_1 : adm_th_7_0)),
                      (mst_3_adm_rd ? 1'd0 : (rd_3_psh ? adm_th_6_1 : adm_th_6_0)),
                      (mst_2_adm_wr ? 1'd0 : (wr_2_psh ? adm_th_5_1 : adm_th_5_0)),
                      (mst_2_adm_rd ? 1'd0 : (rd_2_psh ? adm_th_4_1 : adm_th_4_0)),
                      (mst_1_adm_wr ? 1'd0 : (wr_1_psh ? adm_th_3_1 : adm_th_3_0)),
                      (mst_1_adm_rd ? 1'd0 : (rd_1_psh ? adm_th_2_1 : adm_th_2_0)),
                      (mst_0_adm_wr ? 1'd0 : (wr_0_psh ? adm_th_1_1 : adm_th_1_0)),
                      (mst_0_adm_rd ? 1'd0 : (rd_0_psh ? adm_th_0_1 : adm_th_0_0))};
    assign mst_0_ga_lane = mst_0_ga_cur[9:8];
    assign mst_0_ga_eoff = (mst_0_ga_rowend ? mst_0_ga_gs[8:0] : 9'd256);
    assign mst_0_ga_al = (mst_0_ga_rowend & mst_0_ga_lastrow);
    assign mst_0_ga_rsn = (mst_0_ga_rs + {28'd0, mst_0_ga_stride});
    assign mst_0_ga_cnx = {(mst_0_ga_cur[47:8] + 40'd1), 8'd0};
    assign mst_0_ga_gsd = (mst_0_ga_gs - 21'd256);
    assign mst_0_ga_ngn = ({1'd0, mst_0_ga_bytes} + {13'd0, mst_0_ga_c2});
    assign mst_0_ga_lane_ok = ((mst_0_ga_lane == 0) ? agg_rq0_ok :
                              ((mst_0_ga_lane == 1) ? agg_rq1_ok :
                              ((mst_0_ga_lane == 2) ? agg_rq2_ok :
                              agg_rq3_ok)));
    assign mst_0_ga_nbeat = (({1'd0, mst_0_ga_eoff[8:7]} + {2'd0, (mst_0_ga_eoff[6:0] != 0)}) - {2'd0, mst_0_ga_cur[7]});
    assign mst_0_ga_b0 = {1'd0, mst_0_ga_cur[7]};
    assign mst_0_ga_off = mst_0_ga_cur[7:2];
    assign mst_0_ga_base = ((mst_0_ga_act & (~mst_0_w_wfq)) & (mst_0_ga_loc ? (~mst_0_loc_act) : mst_0_ga_lane_ok));
    assign mst_0_ga_ch = mst_0_ga_cur[8];
    assign mst_0_ga_ok0 = ((mst_0_ga_ch == 0) ? agg_asm_ok0_c0 : agg_asm_ok0_c1);
    assign mst_0_gw_eoff = (mst_0_gw_rowend ? mst_0_gw_gs[8:0] : 9'd256);
    assign mst_0_gw_al = (mst_0_gw_rowend & mst_0_gw_lastrow);
    assign mst_0_gw_rsn = (mst_0_gw_rs + {28'd0, mst_0_gw_stride});
    assign mst_0_gw_cnx = {(mst_0_gw_cur[47:8] + 40'd1), 8'd0};
    assign mst_0_gw_gsd = (mst_0_gw_gs - 21'd256);
    assign mst_0_gw_ngn = ({1'd0, mst_0_gw_bytes} + {13'd0, mst_0_gw_c2});
    assign mst_1_ga_lane = mst_1_ga_cur[9:8];
    assign mst_1_ga_eoff = (mst_1_ga_rowend ? mst_1_ga_gs[8:0] : 9'd256);
    assign mst_1_ga_al = (mst_1_ga_rowend & mst_1_ga_lastrow);
    assign mst_1_ga_rsn = (mst_1_ga_rs + {28'd0, mst_1_ga_stride});
    assign mst_1_ga_cnx = {(mst_1_ga_cur[47:8] + 40'd1), 8'd0};
    assign mst_1_ga_gsd = (mst_1_ga_gs - 21'd256);
    assign mst_1_ga_ngn = ({1'd0, mst_1_ga_bytes} + {13'd0, mst_1_ga_c2});
    assign mst_1_ga_lane_ok = ((mst_1_ga_lane == 0) ? agg_rq0_ok :
                              ((mst_1_ga_lane == 1) ? agg_rq1_ok :
                              ((mst_1_ga_lane == 2) ? agg_rq2_ok :
                              agg_rq3_ok)));
    assign mst_1_ga_nbeat = ((mst_1_ga_eoff[8:6] + {2'd0, (mst_1_ga_eoff[5:0] != 0)}) - {1'd0, mst_1_ga_cur[7:6]});
    assign mst_1_ga_b0 = mst_1_ga_cur[7:6];
    assign mst_1_ga_off = mst_1_ga_cur[7:2];
    assign mst_1_ga_base = ((mst_1_ga_act & (~mst_1_w_wfq)) & (mst_1_ga_loc ? (~mst_1_loc_act) : mst_1_ga_lane_ok));
    assign mst_1_ga_ch = mst_1_ga_cur[8];
    assign mst_1_ga_ok0 = ((mst_1_ga_ch == 0) ? agg_asm_ok0_c0 : agg_asm_ok0_c1);
    assign mst_1_gw_eoff = (mst_1_gw_rowend ? mst_1_gw_gs[8:0] : 9'd256);
    assign mst_1_gw_al = (mst_1_gw_rowend & mst_1_gw_lastrow);
    assign mst_1_gw_rsn = (mst_1_gw_rs + {28'd0, mst_1_gw_stride});
    assign mst_1_gw_cnx = {(mst_1_gw_cur[47:8] + 40'd1), 8'd0};
    assign mst_1_gw_gsd = (mst_1_gw_gs - 21'd256);
    assign mst_1_gw_ngn = ({1'd0, mst_1_gw_bytes} + {13'd0, mst_1_gw_c2});
    assign mst_2_ga_lane = mst_2_ga_cur[9:8];
    assign mst_2_ga_eoff = (mst_2_ga_rowend ? mst_2_ga_gs[8:0] : 9'd256);
    assign mst_2_ga_al = (mst_2_ga_rowend & mst_2_ga_lastrow);
    assign mst_2_ga_rsn = (mst_2_ga_rs + {28'd0, mst_2_ga_stride});
    assign mst_2_ga_cnx = {(mst_2_ga_cur[47:8] + 40'd1), 8'd0};
    assign mst_2_ga_gsd = (mst_2_ga_gs - 21'd256);
    assign mst_2_ga_ngn = ({1'd0, mst_2_ga_bytes} + {13'd0, mst_2_ga_c2});
    assign mst_2_ga_lane_ok = ((mst_2_ga_lane == 0) ? agg_rq0_ok :
                              ((mst_2_ga_lane == 1) ? agg_rq1_ok :
                              ((mst_2_ga_lane == 2) ? agg_rq2_ok :
                              agg_rq3_ok)));
    assign mst_2_ga_nbeat = (({1'd0, mst_2_ga_eoff[8:7]} + {2'd0, (mst_2_ga_eoff[6:0] != 0)}) - {2'd0, mst_2_ga_cur[7]});
    assign mst_2_ga_b0 = {1'd0, mst_2_ga_cur[7]};
    assign mst_2_ga_off = mst_2_ga_cur[7:2];
    assign mst_2_ga_base = ((mst_2_ga_act & (~mst_2_w_wfq)) & (mst_2_ga_loc ? (~mst_2_loc_act) : mst_2_ga_lane_ok));
    assign mst_2_ga_ch = mst_2_ga_cur[8];
    assign mst_2_ga_ok0 = ((mst_2_ga_ch == 0) ? agg_asm_ok0_c0 : agg_asm_ok0_c1);
    assign mst_2_gw_eoff = (mst_2_gw_rowend ? mst_2_gw_gs[8:0] : 9'd256);
    assign mst_2_gw_al = (mst_2_gw_rowend & mst_2_gw_lastrow);
    assign mst_2_gw_rsn = (mst_2_gw_rs + {28'd0, mst_2_gw_stride});
    assign mst_2_gw_cnx = {(mst_2_gw_cur[47:8] + 40'd1), 8'd0};
    assign mst_2_gw_gsd = (mst_2_gw_gs - 21'd256);
    assign mst_2_gw_ngn = ({1'd0, mst_2_gw_bytes} + {13'd0, mst_2_gw_c2});
    assign mst_3_ga_lane = mst_3_ga_cur[9:8];
    assign mst_3_ga_eoff = (mst_3_ga_rowend ? mst_3_ga_gs[8:0] : 9'd256);
    assign mst_3_ga_al = (mst_3_ga_rowend & mst_3_ga_lastrow);
    assign mst_3_ga_rsn = (mst_3_ga_rs + {28'd0, mst_3_ga_stride});
    assign mst_3_ga_cnx = {(mst_3_ga_cur[47:8] + 40'd1), 8'd0};
    assign mst_3_ga_gsd = (mst_3_ga_gs - 21'd256);
    assign mst_3_ga_ngn = ({1'd0, mst_3_ga_bytes} + {13'd0, mst_3_ga_c2});
    assign mst_3_ga_lane_ok = ((mst_3_ga_lane == 0) ? agg_rq0_ok :
                              ((mst_3_ga_lane == 1) ? agg_rq1_ok :
                              ((mst_3_ga_lane == 2) ? agg_rq2_ok :
                              agg_rq3_ok)));
    assign mst_3_ga_nbeat = (({1'd0, mst_3_ga_eoff[8:7]} + {2'd0, (mst_3_ga_eoff[6:0] != 0)}) - {2'd0, mst_3_ga_cur[7]});
    assign mst_3_ga_b0 = {1'd0, mst_3_ga_cur[7]};
    assign mst_3_ga_off = mst_3_ga_cur[7:2];
    assign mst_3_ga_base = ((mst_3_ga_act & (~mst_3_w_wfq)) & (mst_3_ga_loc ? (~mst_3_loc_act) : mst_3_ga_lane_ok));
    assign mst_3_ga_ch = mst_3_ga_cur[8];
    assign mst_3_ga_ok0 = ((mst_3_ga_ch == 0) ? agg_asm_ok0_c0 : agg_asm_ok0_c1);
    assign mst_3_gw_eoff = (mst_3_gw_rowend ? mst_3_gw_gs[8:0] : 9'd256);
    assign mst_3_gw_al = (mst_3_gw_rowend & mst_3_gw_lastrow);
    assign mst_3_gw_rsn = (mst_3_gw_rs + {28'd0, mst_3_gw_stride});
    assign mst_3_gw_cnx = {(mst_3_gw_cur[47:8] + 40'd1), 8'd0};
    assign mst_3_gw_gsd = (mst_3_gw_gs - 21'd256);
    assign mst_3_gw_ngn = ({1'd0, mst_3_gw_bytes} + {13'd0, mst_3_gw_c2});
    assign mst_4_ga_lane = mst_4_ga_cur[9:8];
    assign mst_4_ga_eoff = (mst_4_ga_rowend ? mst_4_ga_gs[8:0] : 9'd256);
    assign mst_4_ga_al = (mst_4_ga_rowend & mst_4_ga_lastrow);
    assign mst_4_ga_rsn = (mst_4_ga_rs + {28'd0, mst_4_ga_stride});
    assign mst_4_ga_cnx = {(mst_4_ga_cur[47:8] + 40'd1), 8'd0};
    assign mst_4_ga_gsd = (mst_4_ga_gs - 21'd256);
    assign mst_4_ga_ngn = ({1'd0, mst_4_ga_bytes} + {13'd0, mst_4_ga_c2});
    assign mst_4_ga_lane_ok = ((mst_4_ga_lane == 0) ? agg_rq0_ok :
                              ((mst_4_ga_lane == 1) ? agg_rq1_ok :
                              ((mst_4_ga_lane == 2) ? agg_rq2_ok :
                              agg_rq3_ok)));
    assign mst_4_ga_nbeat = (({1'd0, mst_4_ga_eoff[8:7]} + {2'd0, (mst_4_ga_eoff[6:0] != 0)}) - {2'd0, mst_4_ga_cur[7]});
    assign mst_4_ga_b0 = {1'd0, mst_4_ga_cur[7]};
    assign mst_4_ga_off = mst_4_ga_cur[7:2];
    assign mst_4_ga_base = ((mst_4_ga_act & (~mst_4_w_wfq)) & (mst_4_ga_loc ? (~mst_4_loc_act) : mst_4_ga_lane_ok));
    assign mst_4_ga_ch = mst_4_ga_cur[8];
    assign mst_4_ga_ok0 = ((mst_4_ga_ch == 0) ? agg_asm_ok0_c0 : agg_asm_ok0_c1);
    assign mst_4_gw_eoff = (mst_4_gw_rowend ? mst_4_gw_gs[8:0] : 9'd256);
    assign mst_4_gw_al = (mst_4_gw_rowend & mst_4_gw_lastrow);
    assign mst_4_gw_rsn = (mst_4_gw_rs + {28'd0, mst_4_gw_stride});
    assign mst_4_gw_cnx = {(mst_4_gw_cur[47:8] + 40'd1), 8'd0};
    assign mst_4_gw_gsd = (mst_4_gw_gs - 21'd256);
    assign mst_4_gw_ngn = ({1'd0, mst_4_gw_bytes} + {13'd0, mst_4_gw_c2});
    assign mst_0_ga_want = (mst_0_ga_base & (mst_0_ga_loc | mst_0_ga_ok0));
    assign emA = mst_0_ga_want;
    assign emA_dram = (emA & (~mst_0_ga_loc));
    assign mst_0_slot = ((mst_0_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1);
    assign mst_1_slot_c0 = ((mst_1_ga_ch == mst_0_ga_ch) ? ((mst_1_ga_ch == 0) ? agg_asm_s1_c0 : agg_asm_s1_c1) :
                           ((mst_1_ga_ch == 0) ? agg_asm_s0_c0 :
                           agg_asm_s0_c1));
    assign mst_1_slot = (emA_dram ? mst_1_slot_c0 : ((mst_1_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1));
    assign mst_1_ga_want_c0 = ((mst_1_ga_ch == mst_0_ga_ch) ? ((mst_1_ga_ch == 0) ? agg_asm_ok1_c0 : agg_asm_ok1_c1) :
                              mst_1_ga_ok0);
    assign mst_1_ga_want_c1 = (emA_dram ? mst_1_ga_want_c0 : mst_1_ga_ok0);
    assign mst_1_ga_want = (mst_1_ga_base & (mst_1_ga_loc | mst_1_ga_want_c1));
    assign mst_1_ew1 = (mst_1_ga_base & (mst_1_ga_loc | (mst_1_ga_want_c0 & (mst_1_ga_lane != mst_0_ga_lane))));
    assign mst_1_ew0 = (mst_1_ga_base & (mst_1_ga_loc | mst_1_ga_ok0));
    assign mst_1_em_want = (emA_dram ? mst_1_ew1 : mst_1_ew0);
    assign mst_2_slot_c0 = ((mst_2_ga_ch == mst_0_ga_ch) ? ((mst_2_ga_ch == 0) ? agg_asm_s1_c0 : agg_asm_s1_c1) :
                           ((mst_2_ga_ch == 0) ? agg_asm_s0_c0 :
                           agg_asm_s0_c1));
    assign mst_2_slot = (emA_dram ? mst_2_slot_c0 : ((mst_2_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1));
    assign mst_2_ga_want_c0 = ((mst_2_ga_ch == mst_0_ga_ch) ? ((mst_2_ga_ch == 0) ? agg_asm_ok1_c0 : agg_asm_ok1_c1) :
                              mst_2_ga_ok0);
    assign mst_2_ga_want_c1 = (emA_dram ? mst_2_ga_want_c0 : mst_2_ga_ok0);
    assign mst_2_ga_want = (mst_2_ga_base & (mst_2_ga_loc | mst_2_ga_want_c1));
    assign mst_2_ew1 = (mst_2_ga_base & (mst_2_ga_loc | (mst_2_ga_want_c0 & (mst_2_ga_lane != mst_0_ga_lane))));
    assign mst_2_ew0 = (mst_2_ga_base & (mst_2_ga_loc | mst_2_ga_ok0));
    assign mst_2_em_want = (emA_dram ? mst_2_ew1 : mst_2_ew0);
    assign mst_3_slot_c0 = ((mst_3_ga_ch == mst_0_ga_ch) ? ((mst_3_ga_ch == 0) ? agg_asm_s1_c0 : agg_asm_s1_c1) :
                           ((mst_3_ga_ch == 0) ? agg_asm_s0_c0 :
                           agg_asm_s0_c1));
    assign mst_3_slot = (emA_dram ? mst_3_slot_c0 : ((mst_3_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1));
    assign mst_3_ga_want_c0 = ((mst_3_ga_ch == mst_0_ga_ch) ? ((mst_3_ga_ch == 0) ? agg_asm_ok1_c0 : agg_asm_ok1_c1) :
                              mst_3_ga_ok0);
    assign mst_3_ga_want_c1 = (emA_dram ? mst_3_ga_want_c0 : mst_3_ga_ok0);
    assign mst_3_ga_want = (mst_3_ga_base & (mst_3_ga_loc | mst_3_ga_want_c1));
    assign mst_3_ew1 = (mst_3_ga_base & (mst_3_ga_loc | (mst_3_ga_want_c0 & (mst_3_ga_lane != mst_0_ga_lane))));
    assign mst_3_ew0 = (mst_3_ga_base & (mst_3_ga_loc | mst_3_ga_ok0));
    assign mst_3_em_want = (emA_dram ? mst_3_ew1 : mst_3_ew0);
    assign mst_4_slot_c0 = ((mst_4_ga_ch == 0) ? agg_asm_s1_c0 : agg_asm_s1_c1);
    assign mst_4_slot = (emA_dram
                         ? ((mst_4_ga_ch == mst_0_ga_ch) ? mst_4_slot_c0 :
                           ((mst_4_ga_ch == 0) ? agg_asm_s0_c0 :
                           agg_asm_s0_c1)) :
                        ((mst_4_ga_ch == 0) ? agg_asm_s0_c0 :
                        agg_asm_s0_c1));
    assign mst_4_ga_want_c0 = ((mst_4_ga_ch == mst_0_ga_ch) ? ((mst_4_ga_ch == 0) ? agg_asm_ok1_c0 : agg_asm_ok1_c1) :
                              mst_4_ga_ok0);
    assign mst_4_ga_want_c1 = (emA_dram ? mst_4_ga_want_c0 : mst_4_ga_ok0);
    assign mst_4_ga_want = (mst_4_ga_base & (mst_4_ga_loc | mst_4_ga_want_c1));
    assign mst_4_ew1 = (mst_4_ga_base & (mst_4_ga_loc | (mst_4_ga_want_c0 & (mst_4_ga_lane != mst_0_ga_lane))));
    assign mst_4_ew0 = (mst_4_ga_base & (mst_4_ga_loc | mst_4_ga_ok0));
    assign mst_4_em_want = (emA_dram ? mst_4_ew1 : mst_4_ew0);
    assign asm_blk_ev = ((((((((mst_0_ga_act & (~mst_0_ga_loc)) & (~mst_0_w_wfq)) & mst_0_ga_lane_ok) & (~mst_0_ga_ok0))
                         | (((((mst_1_ga_act & (~mst_1_ga_loc)) & (~mst_1_w_wfq)) & mst_1_ga_lane_ok)
                            & (~(emA_dram & (mst_1_ga_lane == mst_0_ga_lane)))) & (~mst_1_ga_want_c1)))
                         | (((((mst_2_ga_act & (~mst_2_ga_loc)) & (~mst_2_w_wfq)) & mst_2_ga_lane_ok)
                            & (~(emA_dram & (mst_2_ga_lane == mst_0_ga_lane)))) & (~mst_2_ga_want_c1)))
                         | (((((mst_3_ga_act & (~mst_3_ga_loc)) & (~mst_3_w_wfq)) & mst_3_ga_lane_ok)
                            & (~(emA_dram & (mst_3_ga_lane == mst_0_ga_lane)))) & (~mst_3_ga_want_c1)))
                         | (((((mst_4_ga_act & (~mst_4_ga_loc)) & (~mst_4_w_wfq)) & mst_4_ga_lane_ok)
                            & (~(emA_dram & (mst_4_ga_lane == mst_0_ga_lane)))) & (~mst_4_ga_want_c1)));
    assign emB_gs_0_0 = ((((1'd0 | ((emB_rr == 0) & mst_1_ew0))
                         | ((emB_rr == 1) & (((mst_1_ew0 & (~mst_2_ew0)) & (~mst_3_ew0)) & (~mst_4_ew0))))
                         | ((emB_rr == 2) & ((mst_1_ew0 & (~mst_3_ew0)) & (~mst_4_ew0))))
                         | ((emB_rr == 3) & (mst_1_ew0 & (~mst_4_ew0))));
    assign emB_gs_0_1 = ((((1'd0 | ((emB_rr == 0) & (mst_2_ew0 & (~mst_1_ew0)))) | ((emB_rr == 1) & mst_2_ew0))
                         | ((emB_rr == 2) & (((mst_2_ew0 & (~mst_3_ew0)) & (~mst_4_ew0)) & (~mst_1_ew0))))
                         | ((emB_rr == 3) & ((mst_2_ew0 & (~mst_4_ew0)) & (~mst_1_ew0))));
    assign emB_gs_0_2 = ((((1'd0 | ((emB_rr == 0) & ((mst_3_ew0 & (~mst_1_ew0)) & (~mst_2_ew0))))
                         | ((emB_rr == 1) & (mst_3_ew0 & (~mst_2_ew0)))) | ((emB_rr == 2) & mst_3_ew0))
                         | ((emB_rr == 3) & (((mst_3_ew0 & (~mst_4_ew0)) & (~mst_1_ew0)) & (~mst_2_ew0))));
    assign emB_gs_0_3 = ((((1'd0 | ((emB_rr == 0) & (((mst_4_ew0 & (~mst_1_ew0)) & (~mst_2_ew0)) & (~mst_3_ew0))))
                         | ((emB_rr == 1) & ((mst_4_ew0 & (~mst_2_ew0)) & (~mst_3_ew0))))
                         | ((emB_rr == 2) & (mst_4_ew0 & (~mst_3_ew0)))) | ((emB_rr == 3) & mst_4_ew0));
    assign emB_anys_0 = (((mst_1_ew0 | mst_2_ew0) | mst_3_ew0) | mst_4_ew0);
    assign emB_ks_0 = ((emB_rr == 0) ? (mst_1_ew0 ? 2'd0 : (mst_2_ew0 ? 2'd1 : (mst_3_ew0 ? 2'd2 : 2'd3))) :
                      ((emB_rr == 1) ? (mst_2_ew0 ? 2'd1 : (mst_3_ew0 ? 2'd2 : (mst_4_ew0 ? 2'd3 : 2'd0))) :
                      ((emB_rr == 2) ? (mst_3_ew0 ? 2'd2 : (mst_4_ew0 ? 2'd3 : (mst_1_ew0 ? 2'd0 : 2'd1))) :
                      (mst_4_ew0 ? 2'd3 :
                      (mst_1_ew0 ? 2'd0 :
                      (mst_2_ew0 ? 2'd1 :
                      2'd2))))));
    assign emB_ms_0 = ({1'd0, emB_ks_0} + 1);
    assign emB_drams_0 = ((((emB_gs_0_0 & (~mst_1_ga_loc)) | (emB_gs_0_1 & (~mst_2_ga_loc)))
                          | (emB_gs_0_2 & (~mst_3_ga_loc))) | (emB_gs_0_3 & (~mst_4_ga_loc)));
    assign emB_curs_0 = ((emB_ks_0 == 0) ? mst_1_ga_cur :
                        ((emB_ks_0 == 1) ? mst_2_ga_cur :
                        ((emB_ks_0 == 2) ? mst_3_ga_cur :
                        mst_4_ga_cur)));
    assign emB_tks_0 = {emB_ms_0,
                        ((emB_ks_0 == 0) ? mst_1_w_wt :
                        ((emB_ks_0 == 1) ? mst_2_w_wt :
                        ((emB_ks_0 == 2) ? mst_3_w_wt :
                        mst_4_w_wt)))};
    assign emB_slots_0 = ((emB_ks_0 == 0) ? ((mst_1_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1) :
                         ((emB_ks_0 == 1) ? ((mst_2_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1) :
                         ((emB_ks_0 == 2) ? ((mst_3_ga_ch == 0) ? agg_asm_s0_c0 : agg_asm_s0_c1) :
                         ((mst_4_ga_ch == 0) ? agg_asm_s0_c0 :
                         agg_asm_s0_c1))));
    assign emB_rqs_0_0 = (((((emB_gs_0_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 0))
                          | ((emB_gs_0_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 0)))
                          | ((emB_gs_0_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 0)))
                          | ((emB_gs_0_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 0)));
    assign emB_rqs_0_1 = (((((emB_gs_0_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 1))
                          | ((emB_gs_0_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 1)))
                          | ((emB_gs_0_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 1)))
                          | ((emB_gs_0_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 1)));
    assign emB_rqs_0_2 = (((((emB_gs_0_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 2))
                          | ((emB_gs_0_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 2)))
                          | ((emB_gs_0_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 2)))
                          | ((emB_gs_0_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 2)));
    assign emB_rqs_0_3 = (((((emB_gs_0_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 3))
                          | ((emB_gs_0_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 3)))
                          | ((emB_gs_0_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 3)))
                          | ((emB_gs_0_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 3)));
    assign emB_pbs_0_0 = (((((emB_gs_0_0 & (~mst_1_ga_loc)) & (mst_1_ga_ch == 0))
                          | ((emB_gs_0_1 & (~mst_2_ga_loc)) & (mst_2_ga_ch == 0)))
                          | ((emB_gs_0_2 & (~mst_3_ga_loc)) & (mst_3_ga_ch == 0)))
                          | ((emB_gs_0_3 & (~mst_4_ga_loc)) & (mst_4_ga_ch == 0)));
    assign emB_pbs_0_1 = (((((emB_gs_0_0 & (~mst_1_ga_loc)) & (mst_1_ga_ch == 1))
                          | ((emB_gs_0_1 & (~mst_2_ga_loc)) & (mst_2_ga_ch == 1)))
                          | ((emB_gs_0_2 & (~mst_3_ga_loc)) & (mst_3_ga_ch == 1)))
                          | ((emB_gs_0_3 & (~mst_4_ga_loc)) & (mst_4_ga_ch == 1)));
    assign emB_gs_1_0 = ((((1'd0 | ((emB_rr == 0) & mst_1_ew1))
                         | ((emB_rr == 1) & (((mst_1_ew1 & (~mst_2_ew1)) & (~mst_3_ew1)) & (~mst_4_ew1))))
                         | ((emB_rr == 2) & ((mst_1_ew1 & (~mst_3_ew1)) & (~mst_4_ew1))))
                         | ((emB_rr == 3) & (mst_1_ew1 & (~mst_4_ew1))));
    assign emB_gs_1_1 = ((((1'd0 | ((emB_rr == 0) & (mst_2_ew1 & (~mst_1_ew1)))) | ((emB_rr == 1) & mst_2_ew1))
                         | ((emB_rr == 2) & (((mst_2_ew1 & (~mst_3_ew1)) & (~mst_4_ew1)) & (~mst_1_ew1))))
                         | ((emB_rr == 3) & ((mst_2_ew1 & (~mst_4_ew1)) & (~mst_1_ew1))));
    assign emB_gs_1_2 = ((((1'd0 | ((emB_rr == 0) & ((mst_3_ew1 & (~mst_1_ew1)) & (~mst_2_ew1))))
                         | ((emB_rr == 1) & (mst_3_ew1 & (~mst_2_ew1)))) | ((emB_rr == 2) & mst_3_ew1))
                         | ((emB_rr == 3) & (((mst_3_ew1 & (~mst_4_ew1)) & (~mst_1_ew1)) & (~mst_2_ew1))));
    assign emB_gs_1_3 = ((((1'd0 | ((emB_rr == 0) & (((mst_4_ew1 & (~mst_1_ew1)) & (~mst_2_ew1)) & (~mst_3_ew1))))
                         | ((emB_rr == 1) & ((mst_4_ew1 & (~mst_2_ew1)) & (~mst_3_ew1))))
                         | ((emB_rr == 2) & (mst_4_ew1 & (~mst_3_ew1)))) | ((emB_rr == 3) & mst_4_ew1));
    assign emB_anys_1 = (((mst_1_ew1 | mst_2_ew1) | mst_3_ew1) | mst_4_ew1);
    assign emB_ks_1 = ((emB_rr == 0) ? (mst_1_ew1 ? 2'd0 : (mst_2_ew1 ? 2'd1 : (mst_3_ew1 ? 2'd2 : 2'd3))) :
                      ((emB_rr == 1) ? (mst_2_ew1 ? 2'd1 : (mst_3_ew1 ? 2'd2 : (mst_4_ew1 ? 2'd3 : 2'd0))) :
                      ((emB_rr == 2) ? (mst_3_ew1 ? 2'd2 : (mst_4_ew1 ? 2'd3 : (mst_1_ew1 ? 2'd0 : 2'd1))) :
                      (mst_4_ew1 ? 2'd3 :
                      (mst_1_ew1 ? 2'd0 :
                      (mst_2_ew1 ? 2'd1 :
                      2'd2))))));
    assign emB_ms_1 = ({1'd0, emB_ks_1} + 1);
    assign emB_drams_1 = ((((emB_gs_1_0 & (~mst_1_ga_loc)) | (emB_gs_1_1 & (~mst_2_ga_loc)))
                          | (emB_gs_1_2 & (~mst_3_ga_loc))) | (emB_gs_1_3 & (~mst_4_ga_loc)));
    assign emB_curs_1 = ((emB_ks_1 == 0) ? mst_1_ga_cur :
                        ((emB_ks_1 == 1) ? mst_2_ga_cur :
                        ((emB_ks_1 == 2) ? mst_3_ga_cur :
                        mst_4_ga_cur)));
    assign emB_tks_1 = {emB_ms_1,
                        ((emB_ks_1 == 0) ? mst_1_w_wt :
                        ((emB_ks_1 == 1) ? mst_2_w_wt :
                        ((emB_ks_1 == 2) ? mst_3_w_wt :
                        mst_4_w_wt)))};
    assign emB_slots_1 = ((emB_ks_1 == 0) ? mst_1_slot_c0 :
                         ((emB_ks_1 == 1) ? mst_2_slot_c0 :
                         ((emB_ks_1 == 2) ? mst_3_slot_c0 :
                         ((mst_4_ga_ch == mst_0_ga_ch) ? mst_4_slot_c0 :
                         ((mst_4_ga_ch == 0) ? agg_asm_s0_c0 :
                         agg_asm_s0_c1)))));
    assign emB_rqs_1_0 = (((((emB_gs_1_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 0))
                          | ((emB_gs_1_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 0)))
                          | ((emB_gs_1_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 0)))
                          | ((emB_gs_1_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 0)));
    assign emB_rqs_1_1 = (((((emB_gs_1_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 1))
                          | ((emB_gs_1_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 1)))
                          | ((emB_gs_1_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 1)))
                          | ((emB_gs_1_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 1)));
    assign emB_rqs_1_2 = (((((emB_gs_1_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 2))
                          | ((emB_gs_1_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 2)))
                          | ((emB_gs_1_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 2)))
                          | ((emB_gs_1_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 2)));
    assign emB_rqs_1_3 = (((((emB_gs_1_0 & (~mst_1_ga_loc)) & (mst_1_ga_lane == 3))
                          | ((emB_gs_1_1 & (~mst_2_ga_loc)) & (mst_2_ga_lane == 3)))
                          | ((emB_gs_1_2 & (~mst_3_ga_loc)) & (mst_3_ga_lane == 3)))
                          | ((emB_gs_1_3 & (~mst_4_ga_loc)) & (mst_4_ga_lane == 3)));
    assign emB_pbs_1_0 = (((((emB_gs_1_0 & (~mst_1_ga_loc)) & (mst_1_ga_ch == 0))
                          | ((emB_gs_1_1 & (~mst_2_ga_loc)) & (mst_2_ga_ch == 0)))
                          | ((emB_gs_1_2 & (~mst_3_ga_loc)) & (mst_3_ga_ch == 0)))
                          | ((emB_gs_1_3 & (~mst_4_ga_loc)) & (mst_4_ga_ch == 0)));
    assign emB_pbs_1_1 = (((((emB_gs_1_0 & (~mst_1_ga_loc)) & (mst_1_ga_ch == 1))
                          | ((emB_gs_1_1 & (~mst_2_ga_loc)) & (mst_2_ga_ch == 1)))
                          | ((emB_gs_1_2 & (~mst_3_ga_loc)) & (mst_3_ga_ch == 1)))
                          | ((emB_gs_1_3 & (~mst_4_ga_loc)) & (mst_4_ga_ch == 1)));
    assign emB_g_0 = (emA_dram ? emB_gs_1_0 : emB_gs_0_0);
    assign emB_g_1 = (emA_dram ? emB_gs_1_1 : emB_gs_0_1);
    assign emB_g_2 = (emA_dram ? emB_gs_1_2 : emB_gs_0_2);
    assign emB_g_3 = (emA_dram ? emB_gs_1_3 : emB_gs_0_3);
    assign emB_any = (emA_dram ? emB_anys_1 : emB_anys_0);
    assign emB_k = (emA_dram ? emB_ks_1 : emB_ks_0);
    assign emB_dram = (emA_dram ? emB_drams_1 : emB_drams_0);
    assign emA_tk = {3'd0, mst_0_w_wt};
    assign agg_rq0_push = (emA_dram ? ((mst_0_ga_lane == 0) | emB_rqs_1_0) : emB_rqs_0_0);
    assign agg_rq0_tk = ((emA_dram & (mst_0_ga_lane == 0)) ? emA_tk : (emA_dram ? emB_tks_1 : emB_tks_0));
    assign agg_rq0_addr = ((emA_dram & (mst_0_ga_lane == 0)) ? mst_0_ga_cur : (emA_dram ? emB_curs_1 : emB_curs_0));
    assign agg_rq0_slot = ((emA_dram & (mst_0_ga_lane == 0)) ? mst_0_slot : (emA_dram ? emB_slots_1 : emB_slots_0));
    assign agg_rq1_push = (emA_dram ? ((mst_0_ga_lane == 1) | emB_rqs_1_1) : emB_rqs_0_1);
    assign agg_rq1_tk = ((emA_dram & (mst_0_ga_lane == 1)) ? emA_tk : (emA_dram ? emB_tks_1 : emB_tks_0));
    assign agg_rq1_addr = ((emA_dram & (mst_0_ga_lane == 1)) ? mst_0_ga_cur : (emA_dram ? emB_curs_1 : emB_curs_0));
    assign agg_rq1_slot = ((emA_dram & (mst_0_ga_lane == 1)) ? mst_0_slot : (emA_dram ? emB_slots_1 : emB_slots_0));
    assign agg_rq2_push = (emA_dram ? ((mst_0_ga_lane == 2) | emB_rqs_1_2) : emB_rqs_0_2);
    assign agg_rq2_tk = ((emA_dram & (mst_0_ga_lane == 2)) ? emA_tk : (emA_dram ? emB_tks_1 : emB_tks_0));
    assign agg_rq2_addr = ((emA_dram & (mst_0_ga_lane == 2)) ? mst_0_ga_cur : (emA_dram ? emB_curs_1 : emB_curs_0));
    assign agg_rq2_slot = ((emA_dram & (mst_0_ga_lane == 2)) ? mst_0_slot : (emA_dram ? emB_slots_1 : emB_slots_0));
    assign agg_rq3_push = (emA_dram ? ((mst_0_ga_lane == 3) | emB_rqs_1_3) : emB_rqs_0_3);
    assign agg_rq3_tk = ((emA_dram & (mst_0_ga_lane == 3)) ? emA_tk : (emA_dram ? emB_tks_1 : emB_tks_0));
    assign agg_rq3_addr = ((emA_dram & (mst_0_ga_lane == 3)) ? mst_0_ga_cur : (emA_dram ? emB_curs_1 : emB_curs_0));
    assign agg_rq3_slot = ((emA_dram & (mst_0_ga_lane == 3)) ? mst_0_slot : (emA_dram ? emB_slots_1 : emB_slots_0));
    assign agg_asm_rv0 = emA_dram;
    assign agg_asm_rv1 = emB_dram;
    assign agg_asm_pa_c0 = (emA_dram & (mst_0_ga_ch == 0));
    assign agg_asm_pb_c0 = (emA_dram ? emB_pbs_1_0 : emB_pbs_0_0);
    assign agg_asm_pa_c1 = (emA_dram & (mst_0_ga_ch == 1));
    assign agg_asm_pb_c1 = (emA_dram ? emB_pbs_1_1 : emB_pbs_0_1);
    assign mst_0_em = emA;
    assign mst_1_em = emB_g_0;
    assign mst_2_em = emB_g_1;
    assign mst_3_em = emB_g_2;
    assign mst_4_em = emB_g_3;
    assign wq_g_0 = ((((((((1'd0 | ((wq_rr == 0) & (mst_0_gw_act & agg_wq_ok)))
                     | ((wq_rr == 1)
                        & (((((mst_0_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok)))
                           & (~(mst_2_gw_act & agg_wq_ok))) & (~(mst_3_gw_act & agg_wq_ok)))
                           & (~(mst_4_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 2)
                        & ((((mst_0_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok)))
                           & (~(mst_3_gw_act & agg_wq_ok))) & (~(mst_4_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 3)
                        & (((mst_0_gw_act & agg_wq_ok) & (~(mst_3_gw_act & agg_wq_ok))) & (~(mst_4_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 4) & ((mst_0_gw_act & agg_wq_ok) & (~(mst_4_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 5) & (mst_0_gw_act & agg_wq_ok)))
                     | ((wq_rr == 6)
                        & (((((mst_0_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok)))
                           & (~(mst_2_gw_act & agg_wq_ok))) & (~(mst_3_gw_act & agg_wq_ok)))
                           & (~(mst_4_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 7)
                        & ((((mst_0_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok)))
                           & (~(mst_3_gw_act & agg_wq_ok))) & (~(mst_4_gw_act & agg_wq_ok)))));
    assign wq_g_1 = ((((((((1'd0 | ((wq_rr == 0) & ((mst_1_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 1) & (mst_1_gw_act & agg_wq_ok)))
                     | ((wq_rr == 2)
                        & (((((mst_1_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok)))
                           & (~(mst_3_gw_act & agg_wq_ok))) & (~(mst_4_gw_act & agg_wq_ok)))
                           & (~(mst_0_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 3)
                        & ((((mst_1_gw_act & agg_wq_ok) & (~(mst_3_gw_act & agg_wq_ok)))
                           & (~(mst_4_gw_act & agg_wq_ok))) & (~(mst_0_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 4)
                        & (((mst_1_gw_act & agg_wq_ok) & (~(mst_4_gw_act & agg_wq_ok))) & (~(mst_0_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 5) & ((mst_1_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 6) & (mst_1_gw_act & agg_wq_ok)))
                     | ((wq_rr == 7)
                        & (((((mst_1_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok)))
                           & (~(mst_3_gw_act & agg_wq_ok))) & (~(mst_4_gw_act & agg_wq_ok)))
                           & (~(mst_0_gw_act & agg_wq_ok)))));
    assign wq_g_2 = ((((((((1'd0
                     | ((wq_rr == 0)
                        & (((mst_2_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok))) & (~(mst_1_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 1) & ((mst_2_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 2) & (mst_2_gw_act & agg_wq_ok)))
                     | ((wq_rr == 3)
                        & (((((mst_2_gw_act & agg_wq_ok) & (~(mst_3_gw_act & agg_wq_ok)))
                           & (~(mst_4_gw_act & agg_wq_ok))) & (~(mst_0_gw_act & agg_wq_ok)))
                           & (~(mst_1_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 4)
                        & ((((mst_2_gw_act & agg_wq_ok) & (~(mst_4_gw_act & agg_wq_ok)))
                           & (~(mst_0_gw_act & agg_wq_ok))) & (~(mst_1_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 5)
                        & (((mst_2_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok))) & (~(mst_1_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 6) & ((mst_2_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 7) & (mst_2_gw_act & agg_wq_ok)));
    assign wq_g_3 = ((((((((1'd0
                     | ((wq_rr == 0)
                        & ((((mst_3_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok)))
                           & (~(mst_1_gw_act & agg_wq_ok))) & (~(mst_2_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 1)
                        & (((mst_3_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok))) & (~(mst_2_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 2) & ((mst_3_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 3) & (mst_3_gw_act & agg_wq_ok)))
                     | ((wq_rr == 4)
                        & (((((mst_3_gw_act & agg_wq_ok) & (~(mst_4_gw_act & agg_wq_ok)))
                           & (~(mst_0_gw_act & agg_wq_ok))) & (~(mst_1_gw_act & agg_wq_ok)))
                           & (~(mst_2_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 5)
                        & ((((mst_3_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok)))
                           & (~(mst_1_gw_act & agg_wq_ok))) & (~(mst_2_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 6)
                        & (((mst_3_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok))) & (~(mst_2_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 7) & ((mst_3_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok)))));
    assign wq_g_4 = ((((((((1'd0
                     | ((wq_rr == 0)
                        & (((((mst_4_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok)))
                           & (~(mst_1_gw_act & agg_wq_ok))) & (~(mst_2_gw_act & agg_wq_ok)))
                           & (~(mst_3_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 1)
                        & ((((mst_4_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok)))
                           & (~(mst_2_gw_act & agg_wq_ok))) & (~(mst_3_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 2)
                        & (((mst_4_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok))) & (~(mst_3_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 3) & ((mst_4_gw_act & agg_wq_ok) & (~(mst_3_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 4) & (mst_4_gw_act & agg_wq_ok)))
                     | ((wq_rr == 5)
                        & (((((mst_4_gw_act & agg_wq_ok) & (~(mst_0_gw_act & agg_wq_ok)))
                           & (~(mst_1_gw_act & agg_wq_ok))) & (~(mst_2_gw_act & agg_wq_ok)))
                           & (~(mst_3_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 6)
                        & ((((mst_4_gw_act & agg_wq_ok) & (~(mst_1_gw_act & agg_wq_ok)))
                           & (~(mst_2_gw_act & agg_wq_ok))) & (~(mst_3_gw_act & agg_wq_ok)))))
                     | ((wq_rr == 7)
                        & (((mst_4_gw_act & agg_wq_ok) & (~(mst_2_gw_act & agg_wq_ok))) & (~(mst_3_gw_act & agg_wq_ok)))));
    assign wq_any = (agg_wq_ok & ((((mst_0_gw_act | mst_1_gw_act) | mst_2_gw_act) | mst_3_gw_act) | mst_4_gw_act));
    assign wq_k_c0 = (mst_0_gw_act ? 3'd0 :
                     (mst_1_gw_act ? 3'd1 :
                     (mst_2_gw_act ? 3'd2 :
                     (mst_3_gw_act ? 3'd3 :
                     3'd4))));
    assign wq_k_c1 = (mst_1_gw_act ? 3'd1 :
                     (mst_2_gw_act ? 3'd2 :
                     (mst_3_gw_act ? 3'd3 :
                     (mst_4_gw_act ? 3'd4 :
                     3'd0))));
    assign wq_k = ((wq_rr == 0) ? wq_k_c0 :
                  ((wq_rr == 1) ? wq_k_c1 :
                  ((wq_rr == 2)
                   ? (mst_2_gw_act ? 3'd2 :
                     (mst_3_gw_act ? 3'd3 :
                     (mst_4_gw_act ? 3'd4 :
                     (mst_0_gw_act ? 3'd0 :
                     3'd1)))) :
                  ((wq_rr == 3)
                   ? (mst_3_gw_act ? 3'd3 :
                     (mst_4_gw_act ? 3'd4 :
                     (mst_0_gw_act ? 3'd0 :
                     (mst_1_gw_act ? 3'd1 :
                     3'd2)))) :
                  ((wq_rr == 4)
                   ? (mst_4_gw_act ? 3'd4 :
                     (mst_0_gw_act ? 3'd0 :
                     (mst_1_gw_act ? 3'd1 :
                     (mst_2_gw_act ? 3'd2 :
                     3'd3)))) :
                  ((wq_rr == 5) ? wq_k_c0 :
                  ((wq_rr == 6) ? wq_k_c1 :
                  (mst_2_gw_act ? 3'd2 :
                  (mst_3_gw_act ? 3'd3 :
                  (mst_4_gw_act ? 3'd4 :
                  (mst_0_gw_act ? 3'd0 :
                  3'd1)))))))))));
    assign agg_wq_push = wq_any;
    assign agg_wq_m = wq_k;
    assign agg_wq_wid = ((wq_k == 0) ? mst_0_gw_id :
                        ((wq_k == 1) ? mst_1_gw_id :
                        ((wq_k == 2) ? mst_2_gw_id :
                        ((wq_k == 3) ? mst_3_gw_id :
                        mst_4_gw_id))));
    assign agg_wq_addr = ((wq_k == 0) ? mst_0_gw_cur :
                         ((wq_k == 1) ? mst_1_gw_cur :
                         ((wq_k == 2) ? mst_2_gw_cur :
                         ((wq_k == 3) ? mst_3_gw_cur :
                         mst_4_gw_cur))));
    assign agg_wq_eoff = ((wq_k == 0) ? mst_0_gw_eoff :
                         ((wq_k == 1) ? mst_1_gw_eoff :
                         ((wq_k == 2) ? mst_2_gw_eoff :
                         ((wq_k == 3) ? mst_3_gw_eoff :
                         mst_4_gw_eoff))));
    assign agg_wq_last = ((wq_k == 0) ? mst_0_gw_al :
                         ((wq_k == 1) ? mst_1_gw_al :
                         ((wq_k == 2) ? mst_2_gw_al :
                         ((wq_k == 3) ? mst_3_gw_al :
                         mst_4_gw_al))));
    assign agg_wq_tag = ((wq_k == 0) ? mst_0_gw_tag :
                        ((wq_k == 1) ? mst_1_gw_tag :
                        ((wq_k == 2) ? mst_2_gw_tag :
                        ((wq_k == 3) ? mst_3_gw_tag :
                        mst_4_gw_tag))));
    assign agg_wq_loc = ((wq_k == 0) ? mst_0_gw_loc :
                        ((wq_k == 1) ? mst_1_gw_loc :
                        ((wq_k == 2) ? mst_2_gw_loc :
                        ((wq_k == 3) ? mst_3_gw_loc :
                        mst_4_gw_loc))));
    assign mst_0_wem = wq_g_0;
    assign mst_1_wem = wq_g_1;
    assign mst_2_wem = wq_g_2;
    assign mst_3_wem = wq_g_3;
    assign mst_4_wem = wq_g_4;
    assign mst_0_loc_rd = ((mst_0_loc_off == 1) ? {31'd0, (pend_write != 0)} :
                          ((mst_0_loc_off == 8) ? st_req :
                          ((mst_0_loc_off == 10) ? st_fill :
                          ((mst_0_loc_off == 11) ? st_wt :
                          32'd0))));
    assign mst_0_loc_done = (mst_0_loc_act & (mst_0_loc_cnt == 0));
    assign mst_1_loc_rd = ((mst_1_loc_off == 1) ? {31'd0, (pend_write != 0)} :
                          ((mst_1_loc_off == 8) ? st_req :
                          ((mst_1_loc_off == 10) ? st_fill :
                          ((mst_1_loc_off == 11) ? st_wt :
                          32'd0))));
    assign mst_1_loc_done = (mst_1_loc_act & (mst_1_loc_cnt == 0));
    assign mst_2_loc_rd = ((mst_2_loc_off == 1) ? {31'd0, (pend_write != 0)} :
                          ((mst_2_loc_off == 8) ? st_req :
                          ((mst_2_loc_off == 10) ? st_fill :
                          ((mst_2_loc_off == 11) ? st_wt :
                          32'd0))));
    assign mst_2_loc_done = (mst_2_loc_act & (mst_2_loc_cnt == 0));
    assign mst_3_loc_rd = ((mst_3_loc_off == 1) ? {31'd0, (pend_write != 0)} :
                          ((mst_3_loc_off == 8) ? st_req :
                          ((mst_3_loc_off == 10) ? st_fill :
                          ((mst_3_loc_off == 11) ? st_wt :
                          32'd0))));
    assign mst_3_loc_done = (mst_3_loc_act & (mst_3_loc_cnt == 0));
    assign mst_4_loc_rd = ((mst_4_loc_off == 1) ? {31'd0, (pend_write != 0)} :
                          ((mst_4_loc_off == 8) ? st_req :
                          ((mst_4_loc_off == 10) ? st_fill :
                          ((mst_4_loc_off == 11) ? st_wt :
                          32'd0))));
    assign mst_4_loc_done = (mst_4_loc_act & (mst_4_loc_cnt == 0));
    assign wk_v_0 = agg_wk0_v;
    assign wk_m_0 = agg_wk0_tk[7:5];
    assign wk_slot_0 = agg_wk0_tk[4:0];
    assign wk_v_1 = agg_wk1_v;
    assign wk_m_1 = agg_wk1_tk[7:5];
    assign wk_slot_1 = agg_wk1_tk[4:0];
    assign mst_0_w_nasl = wp_asl_0[win_wh1_0];
    assign mst_0_w_nb0 = wp_b0_0[win_wh1_0];
    assign mst_0_w_nnb = wp_nb_0[win_wh1_0];
    assign mst_0_w_ntag = wp_tag_0[win_wh1_0];
    assign mst_0_w_nid = wp_id_0[win_wh1_0];
    assign mst_0_w_nloc = wp_loc_0[win_wh1_0];
    assign mst_0_w_nal = wp_al_0[win_wh1_0];
    assign mst_0_w_hlast = (({1'd0, mst_0_w_ek} + 3'd1) == mst_0_w_hnb);
    assign mst_0_w_hu = (mst_0_w_hb0 + mst_0_w_ek);
    assign mst_0_w_hwi = mst_0_w_hu[0];
    assign mst_0_w_hhf = mst_0_w_hu[0];
    assign mst_1_w_nasl = wp_asl_1[win_wh1_1];
    assign mst_1_w_nb0 = wp_b0_1[win_wh1_1];
    assign mst_1_w_nnb = wp_nb_1[win_wh1_1];
    assign mst_1_w_ntag = wp_tag_1[win_wh1_1];
    assign mst_1_w_nid = wp_id_1[win_wh1_1];
    assign mst_1_w_nloc = wp_loc_1[win_wh1_1];
    assign mst_1_w_nal = wp_al_1[win_wh1_1];
    assign mst_1_w_hlast = (({1'd0, mst_1_w_ek} + 3'd1) == mst_1_w_hnb);
    assign mst_1_w_hu = (mst_1_w_hb0 + mst_1_w_ek);
    assign mst_1_w_hwi = mst_1_w_hu[1];
    assign mst_1_w_hhf = mst_1_w_hu[0];
    assign mst_2_w_nasl = wp_asl_2[win_wh1_2];
    assign mst_2_w_nb0 = wp_b0_2[win_wh1_2];
    assign mst_2_w_nnb = wp_nb_2[win_wh1_2];
    assign mst_2_w_ntag = wp_tag_2[win_wh1_2];
    assign mst_2_w_nid = wp_id_2[win_wh1_2];
    assign mst_2_w_nloc = wp_loc_2[win_wh1_2];
    assign mst_2_w_nal = wp_al_2[win_wh1_2];
    assign mst_2_w_hlast = (({1'd0, mst_2_w_ek} + 3'd1) == mst_2_w_hnb);
    assign mst_2_w_hu = (mst_2_w_hb0 + mst_2_w_ek);
    assign mst_2_w_hwi = mst_2_w_hu[0];
    assign mst_2_w_hhf = mst_2_w_hu[0];
    assign mst_3_w_nasl = wp_asl_3[win_wh1_3];
    assign mst_3_w_nb0 = wp_b0_3[win_wh1_3];
    assign mst_3_w_nnb = wp_nb_3[win_wh1_3];
    assign mst_3_w_ntag = wp_tag_3[win_wh1_3];
    assign mst_3_w_nid = wp_id_3[win_wh1_3];
    assign mst_3_w_nloc = wp_loc_3[win_wh1_3];
    assign mst_3_w_nal = wp_al_3[win_wh1_3];
    assign mst_3_w_hlast = (({1'd0, mst_3_w_ek} + 3'd1) == mst_3_w_hnb);
    assign mst_3_w_hu = (mst_3_w_hb0 + mst_3_w_ek);
    assign mst_3_w_hwi = mst_3_w_hu[0];
    assign mst_3_w_hhf = mst_3_w_hu[0];
    assign mst_4_w_nasl = wp_asl_4[win_wh1_4];
    assign mst_4_w_nb0 = wp_b0_4[win_wh1_4];
    assign mst_4_w_nnb = wp_nb_4[win_wh1_4];
    assign mst_4_w_ntag = wp_tag_4[win_wh1_4];
    assign mst_4_w_nid = wp_id_4[win_wh1_4];
    assign mst_4_w_nloc = wp_loc_4[win_wh1_4];
    assign mst_4_w_nal = wp_al_4[win_wh1_4];
    assign mst_4_w_hlast = (({1'd0, mst_4_w_ek} + 3'd1) == mst_4_w_hnb);
    assign mst_4_w_hu = (mst_4_w_hb0 + mst_4_w_ek);
    assign mst_4_w_hwi = mst_4_w_hu[0];
    assign mst_4_w_hhf = mst_4_w_hu[0];
    assign mst_0_w_rdys = (((mst_0_loc_done ? (32'd1 << mst_0_loc_slot) : 32'd0)
                           | ((wk_v_0 & (wk_m_0 == 0)) ? (32'd1 << wk_slot_0) : 32'd0))
                           | ((wk_v_1 & (wk_m_1 == 0)) ? (32'd1 << wk_slot_1) : 32'd0));
    assign mst_0_w_hit0 = (((mst_0_loc_done & (mst_0_loc_slot == mst_0_w_wh))
                           | ((wk_v_0 & (wk_m_0 == 0)) & (wk_slot_0 == mst_0_w_wh)))
                           | ((wk_v_1 & (wk_m_1 == 0)) & (wk_slot_1 == mst_0_w_wh)));
    assign mst_0_w_hit1 = (((mst_0_loc_done & (win_wh1_0 == mst_0_loc_slot))
                           | ((wk_v_0 & (wk_m_0 == 0)) & (win_wh1_0 == wk_slot_0)))
                           | ((wk_v_1 & (wk_m_1 == 0)) & (win_wh1_0 == wk_slot_1)));
    assign mst_0_w_hn0 = (mst_0_w_hvq | ((mst_0_w_wc != 0) & mst_0_w_hit0));
    assign mst_0_w_hn1 = ((mst_0_w_wc[5:1] != 0)
                          & (((win_wh1_0 == 0) ? mst_0_w_wrd[0] :
                             ((win_wh1_0 == 1) ? mst_0_w_wrd[1] :
                             ((win_wh1_0 == 2) ? mst_0_w_wrd[2] :
                             ((win_wh1_0 == 3) ? mst_0_w_wrd[3] :
                             ((win_wh1_0 == 4) ? mst_0_w_wrd[4] :
                             ((win_wh1_0 == 5) ? mst_0_w_wrd[5] :
                             ((win_wh1_0 == 6) ? mst_0_w_wrd[6] :
                             ((win_wh1_0 == 7) ? mst_0_w_wrd[7] :
                             ((win_wh1_0 == 8) ? mst_0_w_wrd[8] :
                             ((win_wh1_0 == 9) ? mst_0_w_wrd[9] :
                             ((win_wh1_0 == 10) ? mst_0_w_wrd[10] :
                             ((win_wh1_0 == 11) ? mst_0_w_wrd[11] :
                             ((win_wh1_0 == 12) ? mst_0_w_wrd[12] :
                             ((win_wh1_0 == 13) ? mst_0_w_wrd[13] :
                             ((win_wh1_0 == 14) ? mst_0_w_wrd[14] :
                             ((win_wh1_0 == 15) ? mst_0_w_wrd[15] :
                             ((win_wh1_0 == 16) ? mst_0_w_wrd[16] :
                             ((win_wh1_0 == 17) ? mst_0_w_wrd[17] :
                             ((win_wh1_0 == 18) ? mst_0_w_wrd[18] :
                             ((win_wh1_0 == 19) ? mst_0_w_wrd[19] :
                             ((win_wh1_0 == 20) ? mst_0_w_wrd[20] :
                             ((win_wh1_0 == 21) ? mst_0_w_wrd[21] :
                             ((win_wh1_0 == 22) ? mst_0_w_wrd[22] :
                             ((win_wh1_0 == 23) ? mst_0_w_wrd[23] :
                             ((win_wh1_0 == 24) ? mst_0_w_wrd[24] :
                             ((win_wh1_0 == 25) ? mst_0_w_wrd[25] :
                             ((win_wh1_0 == 26) ? mst_0_w_wrd[26] :
                             ((win_wh1_0 == 27) ? mst_0_w_wrd[27] :
                             ((win_wh1_0 == 28) ? mst_0_w_wrd[28] :
                             ((win_wh1_0 == 29) ? mst_0_w_wrd[29] :
                             ((win_wh1_0 == 30) ? mst_0_w_wrd[30] :
                             mst_0_w_wrd[31]))))))))))))))))))))))))))))))) | mst_0_w_hit1));
    assign mst_1_w_rdys = (((mst_1_loc_done ? (32'd1 << mst_1_loc_slot) : 32'd0)
                           | ((wk_v_0 & (wk_m_0 == 1)) ? (32'd1 << wk_slot_0) : 32'd0))
                           | ((wk_v_1 & (wk_m_1 == 1)) ? (32'd1 << wk_slot_1) : 32'd0));
    assign mst_1_w_hit0 = (((mst_1_loc_done & (mst_1_loc_slot == mst_1_w_wh))
                           | ((wk_v_0 & (wk_m_0 == 1)) & (wk_slot_0 == mst_1_w_wh)))
                           | ((wk_v_1 & (wk_m_1 == 1)) & (wk_slot_1 == mst_1_w_wh)));
    assign mst_1_w_hit1 = (((mst_1_loc_done & (win_wh1_1 == mst_1_loc_slot))
                           | ((wk_v_0 & (wk_m_0 == 1)) & (win_wh1_1 == wk_slot_0)))
                           | ((wk_v_1 & (wk_m_1 == 1)) & (win_wh1_1 == wk_slot_1)));
    assign mst_1_w_hn0 = (mst_1_w_hvq | ((mst_1_w_wc != 0) & mst_1_w_hit0));
    assign mst_1_w_hn1 = ((mst_1_w_wc[5:1] != 0)
                          & (((win_wh1_1 == 0) ? mst_1_w_wrd[0] :
                             ((win_wh1_1 == 1) ? mst_1_w_wrd[1] :
                             ((win_wh1_1 == 2) ? mst_1_w_wrd[2] :
                             ((win_wh1_1 == 3) ? mst_1_w_wrd[3] :
                             ((win_wh1_1 == 4) ? mst_1_w_wrd[4] :
                             ((win_wh1_1 == 5) ? mst_1_w_wrd[5] :
                             ((win_wh1_1 == 6) ? mst_1_w_wrd[6] :
                             ((win_wh1_1 == 7) ? mst_1_w_wrd[7] :
                             ((win_wh1_1 == 8) ? mst_1_w_wrd[8] :
                             ((win_wh1_1 == 9) ? mst_1_w_wrd[9] :
                             ((win_wh1_1 == 10) ? mst_1_w_wrd[10] :
                             ((win_wh1_1 == 11) ? mst_1_w_wrd[11] :
                             ((win_wh1_1 == 12) ? mst_1_w_wrd[12] :
                             ((win_wh1_1 == 13) ? mst_1_w_wrd[13] :
                             ((win_wh1_1 == 14) ? mst_1_w_wrd[14] :
                             ((win_wh1_1 == 15) ? mst_1_w_wrd[15] :
                             ((win_wh1_1 == 16) ? mst_1_w_wrd[16] :
                             ((win_wh1_1 == 17) ? mst_1_w_wrd[17] :
                             ((win_wh1_1 == 18) ? mst_1_w_wrd[18] :
                             ((win_wh1_1 == 19) ? mst_1_w_wrd[19] :
                             ((win_wh1_1 == 20) ? mst_1_w_wrd[20] :
                             ((win_wh1_1 == 21) ? mst_1_w_wrd[21] :
                             ((win_wh1_1 == 22) ? mst_1_w_wrd[22] :
                             ((win_wh1_1 == 23) ? mst_1_w_wrd[23] :
                             ((win_wh1_1 == 24) ? mst_1_w_wrd[24] :
                             ((win_wh1_1 == 25) ? mst_1_w_wrd[25] :
                             ((win_wh1_1 == 26) ? mst_1_w_wrd[26] :
                             ((win_wh1_1 == 27) ? mst_1_w_wrd[27] :
                             ((win_wh1_1 == 28) ? mst_1_w_wrd[28] :
                             ((win_wh1_1 == 29) ? mst_1_w_wrd[29] :
                             ((win_wh1_1 == 30) ? mst_1_w_wrd[30] :
                             mst_1_w_wrd[31]))))))))))))))))))))))))))))))) | mst_1_w_hit1));
    assign mst_2_w_rdys = (((mst_2_loc_done ? (32'd1 << mst_2_loc_slot) : 32'd0)
                           | ((wk_v_0 & (wk_m_0 == 2)) ? (32'd1 << wk_slot_0) : 32'd0))
                           | ((wk_v_1 & (wk_m_1 == 2)) ? (32'd1 << wk_slot_1) : 32'd0));
    assign mst_2_w_hit0 = (((mst_2_loc_done & (mst_2_loc_slot == mst_2_w_wh))
                           | ((wk_v_0 & (wk_m_0 == 2)) & (wk_slot_0 == mst_2_w_wh)))
                           | ((wk_v_1 & (wk_m_1 == 2)) & (wk_slot_1 == mst_2_w_wh)));
    assign mst_2_w_hit1 = (((mst_2_loc_done & (win_wh1_2 == mst_2_loc_slot))
                           | ((wk_v_0 & (wk_m_0 == 2)) & (win_wh1_2 == wk_slot_0)))
                           | ((wk_v_1 & (wk_m_1 == 2)) & (win_wh1_2 == wk_slot_1)));
    assign mst_2_w_hn0 = (mst_2_w_hvq | ((mst_2_w_wc != 0) & mst_2_w_hit0));
    assign mst_2_w_hn1 = ((mst_2_w_wc[5:1] != 0)
                          & (((win_wh1_2 == 0) ? mst_2_w_wrd[0] :
                             ((win_wh1_2 == 1) ? mst_2_w_wrd[1] :
                             ((win_wh1_2 == 2) ? mst_2_w_wrd[2] :
                             ((win_wh1_2 == 3) ? mst_2_w_wrd[3] :
                             ((win_wh1_2 == 4) ? mst_2_w_wrd[4] :
                             ((win_wh1_2 == 5) ? mst_2_w_wrd[5] :
                             ((win_wh1_2 == 6) ? mst_2_w_wrd[6] :
                             ((win_wh1_2 == 7) ? mst_2_w_wrd[7] :
                             ((win_wh1_2 == 8) ? mst_2_w_wrd[8] :
                             ((win_wh1_2 == 9) ? mst_2_w_wrd[9] :
                             ((win_wh1_2 == 10) ? mst_2_w_wrd[10] :
                             ((win_wh1_2 == 11) ? mst_2_w_wrd[11] :
                             ((win_wh1_2 == 12) ? mst_2_w_wrd[12] :
                             ((win_wh1_2 == 13) ? mst_2_w_wrd[13] :
                             ((win_wh1_2 == 14) ? mst_2_w_wrd[14] :
                             ((win_wh1_2 == 15) ? mst_2_w_wrd[15] :
                             ((win_wh1_2 == 16) ? mst_2_w_wrd[16] :
                             ((win_wh1_2 == 17) ? mst_2_w_wrd[17] :
                             ((win_wh1_2 == 18) ? mst_2_w_wrd[18] :
                             ((win_wh1_2 == 19) ? mst_2_w_wrd[19] :
                             ((win_wh1_2 == 20) ? mst_2_w_wrd[20] :
                             ((win_wh1_2 == 21) ? mst_2_w_wrd[21] :
                             ((win_wh1_2 == 22) ? mst_2_w_wrd[22] :
                             ((win_wh1_2 == 23) ? mst_2_w_wrd[23] :
                             ((win_wh1_2 == 24) ? mst_2_w_wrd[24] :
                             ((win_wh1_2 == 25) ? mst_2_w_wrd[25] :
                             ((win_wh1_2 == 26) ? mst_2_w_wrd[26] :
                             ((win_wh1_2 == 27) ? mst_2_w_wrd[27] :
                             ((win_wh1_2 == 28) ? mst_2_w_wrd[28] :
                             ((win_wh1_2 == 29) ? mst_2_w_wrd[29] :
                             ((win_wh1_2 == 30) ? mst_2_w_wrd[30] :
                             mst_2_w_wrd[31]))))))))))))))))))))))))))))))) | mst_2_w_hit1));
    assign mst_3_w_rdys = (((mst_3_loc_done ? (32'd1 << mst_3_loc_slot) : 32'd0)
                           | ((wk_v_0 & (wk_m_0 == 3)) ? (32'd1 << wk_slot_0) : 32'd0))
                           | ((wk_v_1 & (wk_m_1 == 3)) ? (32'd1 << wk_slot_1) : 32'd0));
    assign mst_3_w_hit0 = (((mst_3_loc_done & (mst_3_loc_slot == mst_3_w_wh))
                           | ((wk_v_0 & (wk_m_0 == 3)) & (wk_slot_0 == mst_3_w_wh)))
                           | ((wk_v_1 & (wk_m_1 == 3)) & (wk_slot_1 == mst_3_w_wh)));
    assign mst_3_w_hit1 = (((mst_3_loc_done & (win_wh1_3 == mst_3_loc_slot))
                           | ((wk_v_0 & (wk_m_0 == 3)) & (win_wh1_3 == wk_slot_0)))
                           | ((wk_v_1 & (wk_m_1 == 3)) & (win_wh1_3 == wk_slot_1)));
    assign mst_3_w_hn0 = (mst_3_w_hvq | ((mst_3_w_wc != 0) & mst_3_w_hit0));
    assign mst_3_w_hn1 = ((mst_3_w_wc[5:1] != 0)
                          & (((win_wh1_3 == 0) ? mst_3_w_wrd[0] :
                             ((win_wh1_3 == 1) ? mst_3_w_wrd[1] :
                             ((win_wh1_3 == 2) ? mst_3_w_wrd[2] :
                             ((win_wh1_3 == 3) ? mst_3_w_wrd[3] :
                             ((win_wh1_3 == 4) ? mst_3_w_wrd[4] :
                             ((win_wh1_3 == 5) ? mst_3_w_wrd[5] :
                             ((win_wh1_3 == 6) ? mst_3_w_wrd[6] :
                             ((win_wh1_3 == 7) ? mst_3_w_wrd[7] :
                             ((win_wh1_3 == 8) ? mst_3_w_wrd[8] :
                             ((win_wh1_3 == 9) ? mst_3_w_wrd[9] :
                             ((win_wh1_3 == 10) ? mst_3_w_wrd[10] :
                             ((win_wh1_3 == 11) ? mst_3_w_wrd[11] :
                             ((win_wh1_3 == 12) ? mst_3_w_wrd[12] :
                             ((win_wh1_3 == 13) ? mst_3_w_wrd[13] :
                             ((win_wh1_3 == 14) ? mst_3_w_wrd[14] :
                             ((win_wh1_3 == 15) ? mst_3_w_wrd[15] :
                             ((win_wh1_3 == 16) ? mst_3_w_wrd[16] :
                             ((win_wh1_3 == 17) ? mst_3_w_wrd[17] :
                             ((win_wh1_3 == 18) ? mst_3_w_wrd[18] :
                             ((win_wh1_3 == 19) ? mst_3_w_wrd[19] :
                             ((win_wh1_3 == 20) ? mst_3_w_wrd[20] :
                             ((win_wh1_3 == 21) ? mst_3_w_wrd[21] :
                             ((win_wh1_3 == 22) ? mst_3_w_wrd[22] :
                             ((win_wh1_3 == 23) ? mst_3_w_wrd[23] :
                             ((win_wh1_3 == 24) ? mst_3_w_wrd[24] :
                             ((win_wh1_3 == 25) ? mst_3_w_wrd[25] :
                             ((win_wh1_3 == 26) ? mst_3_w_wrd[26] :
                             ((win_wh1_3 == 27) ? mst_3_w_wrd[27] :
                             ((win_wh1_3 == 28) ? mst_3_w_wrd[28] :
                             ((win_wh1_3 == 29) ? mst_3_w_wrd[29] :
                             ((win_wh1_3 == 30) ? mst_3_w_wrd[30] :
                             mst_3_w_wrd[31]))))))))))))))))))))))))))))))) | mst_3_w_hit1));
    assign mst_4_w_rdys = (((mst_4_loc_done ? (32'd1 << mst_4_loc_slot) : 32'd0)
                           | ((wk_v_0 & (wk_m_0 == 4)) ? (32'd1 << wk_slot_0) : 32'd0))
                           | ((wk_v_1 & (wk_m_1 == 4)) ? (32'd1 << wk_slot_1) : 32'd0));
    assign mst_4_w_hit0 = (((mst_4_loc_done & (mst_4_loc_slot == mst_4_w_wh))
                           | ((wk_v_0 & (wk_m_0 == 4)) & (wk_slot_0 == mst_4_w_wh)))
                           | ((wk_v_1 & (wk_m_1 == 4)) & (wk_slot_1 == mst_4_w_wh)));
    assign mst_4_w_hit1 = (((mst_4_loc_done & (win_wh1_4 == mst_4_loc_slot))
                           | ((wk_v_0 & (wk_m_0 == 4)) & (win_wh1_4 == wk_slot_0)))
                           | ((wk_v_1 & (wk_m_1 == 4)) & (win_wh1_4 == wk_slot_1)));
    assign mst_4_w_hn0 = (mst_4_w_hvq | ((mst_4_w_wc != 0) & mst_4_w_hit0));
    assign mst_4_w_hn1 = ((mst_4_w_wc[5:1] != 0)
                          & (((win_wh1_4 == 0) ? mst_4_w_wrd[0] :
                             ((win_wh1_4 == 1) ? mst_4_w_wrd[1] :
                             ((win_wh1_4 == 2) ? mst_4_w_wrd[2] :
                             ((win_wh1_4 == 3) ? mst_4_w_wrd[3] :
                             ((win_wh1_4 == 4) ? mst_4_w_wrd[4] :
                             ((win_wh1_4 == 5) ? mst_4_w_wrd[5] :
                             ((win_wh1_4 == 6) ? mst_4_w_wrd[6] :
                             ((win_wh1_4 == 7) ? mst_4_w_wrd[7] :
                             ((win_wh1_4 == 8) ? mst_4_w_wrd[8] :
                             ((win_wh1_4 == 9) ? mst_4_w_wrd[9] :
                             ((win_wh1_4 == 10) ? mst_4_w_wrd[10] :
                             ((win_wh1_4 == 11) ? mst_4_w_wrd[11] :
                             ((win_wh1_4 == 12) ? mst_4_w_wrd[12] :
                             ((win_wh1_4 == 13) ? mst_4_w_wrd[13] :
                             ((win_wh1_4 == 14) ? mst_4_w_wrd[14] :
                             ((win_wh1_4 == 15) ? mst_4_w_wrd[15] :
                             ((win_wh1_4 == 16) ? mst_4_w_wrd[16] :
                             ((win_wh1_4 == 17) ? mst_4_w_wrd[17] :
                             ((win_wh1_4 == 18) ? mst_4_w_wrd[18] :
                             ((win_wh1_4 == 19) ? mst_4_w_wrd[19] :
                             ((win_wh1_4 == 20) ? mst_4_w_wrd[20] :
                             ((win_wh1_4 == 21) ? mst_4_w_wrd[21] :
                             ((win_wh1_4 == 22) ? mst_4_w_wrd[22] :
                             ((win_wh1_4 == 23) ? mst_4_w_wrd[23] :
                             ((win_wh1_4 == 24) ? mst_4_w_wrd[24] :
                             ((win_wh1_4 == 25) ? mst_4_w_wrd[25] :
                             ((win_wh1_4 == 26) ? mst_4_w_wrd[26] :
                             ((win_wh1_4 == 27) ? mst_4_w_wrd[27] :
                             ((win_wh1_4 == 28) ? mst_4_w_wrd[28] :
                             ((win_wh1_4 == 29) ? mst_4_w_wrd[29] :
                             ((win_wh1_4 == 30) ? mst_4_w_wrd[30] :
                             mst_4_w_wrd[31]))))))))))))))))))))))))))))))) | mst_4_w_hit1));
    assign hA_loc = mst_0_w_hloc;
    assign hA_al = mst_0_w_hal;
    assign goA = (mst_0_w_hvq & ((~ra_v) | r_0_ready));
    assign lastA = mst_0_w_hlast;
    assign agg_ra_en = (goA & (~hA_loc));
    assign agg_ra_addr = {mst_0_w_hasl, mst_0_w_hwi};
    assign rb_free = ((~rb_v)
                      | ((rb_m == 0) ? r_0_ready :
                        ((rb_m == 1) ? r_1_ready :
                        ((rb_m == 2) ? r_2_ready :
                        ((rb_m == 3) ? r_3_ready :
                        r_4_ready)))));
    assign goB_g_0 = ((((1'd0 | ((rb_rr == 0) & mst_1_w_hvq))
                      | ((rb_rr == 1) & (((mst_1_w_hvq & (~mst_2_w_hvq)) & (~mst_3_w_hvq)) & (~mst_4_w_hvq))))
                      | ((rb_rr == 2) & ((mst_1_w_hvq & (~mst_3_w_hvq)) & (~mst_4_w_hvq))))
                      | ((rb_rr == 3) & (mst_1_w_hvq & (~mst_4_w_hvq))));
    assign goB_g_1 = ((((1'd0 | ((rb_rr == 0) & (mst_2_w_hvq & (~mst_1_w_hvq)))) | ((rb_rr == 1) & mst_2_w_hvq))
                      | ((rb_rr == 2) & (((mst_2_w_hvq & (~mst_3_w_hvq)) & (~mst_4_w_hvq)) & (~mst_1_w_hvq))))
                      | ((rb_rr == 3) & ((mst_2_w_hvq & (~mst_4_w_hvq)) & (~mst_1_w_hvq))));
    assign goB_g_2 = ((((1'd0 | ((rb_rr == 0) & ((mst_3_w_hvq & (~mst_1_w_hvq)) & (~mst_2_w_hvq))))
                      | ((rb_rr == 1) & (mst_3_w_hvq & (~mst_2_w_hvq)))) | ((rb_rr == 2) & mst_3_w_hvq))
                      | ((rb_rr == 3) & (((mst_3_w_hvq & (~mst_4_w_hvq)) & (~mst_1_w_hvq)) & (~mst_2_w_hvq))));
    assign goB_g_3 = ((((1'd0 | ((rb_rr == 0) & (((mst_4_w_hvq & (~mst_1_w_hvq)) & (~mst_2_w_hvq)) & (~mst_3_w_hvq))))
                      | ((rb_rr == 1) & ((mst_4_w_hvq & (~mst_2_w_hvq)) & (~mst_3_w_hvq))))
                      | ((rb_rr == 2) & (mst_4_w_hvq & (~mst_3_w_hvq)))) | ((rb_rr == 3) & mst_4_w_hvq));
    assign goB_any = (((mst_1_w_hvq | mst_2_w_hvq) | mst_3_w_hvq) | mst_4_w_hvq);
    assign goB_k = ((rb_rr == 0) ? (mst_1_w_hvq ? 2'd0 : (mst_2_w_hvq ? 2'd1 : (mst_3_w_hvq ? 2'd2 : 2'd3))) :
                   ((rb_rr == 1) ? (mst_2_w_hvq ? 2'd1 : (mst_3_w_hvq ? 2'd2 : (mst_4_w_hvq ? 2'd3 : 2'd0))) :
                   ((rb_rr == 2) ? (mst_3_w_hvq ? 2'd2 : (mst_4_w_hvq ? 2'd3 : (mst_1_w_hvq ? 2'd0 : 2'd1))) :
                   (mst_4_w_hvq ? 2'd3 :
                   (mst_1_w_hvq ? 2'd0 :
                   (mst_2_w_hvq ? 2'd1 :
                   2'd2))))));
    assign goB = (goB_any & rb_free);
    assign goB_m = ({1'd0, goB_k} + 1);
    assign hB_loc = ((goB_k == 0) ? mst_1_w_hloc :
                    ((goB_k == 1) ? mst_2_w_hloc :
                    ((goB_k == 2) ? mst_3_w_hloc :
                    mst_4_w_hloc)));
    assign hB_al = ((goB_k == 0) ? mst_1_w_hal :
                   ((goB_k == 1) ? mst_2_w_hal :
                   ((goB_k == 2) ? mst_3_w_hal :
                   mst_4_w_hal)));
    assign hB_asl = ((goB_k == 0) ? mst_1_w_hasl :
                    ((goB_k == 1) ? mst_2_w_hasl :
                    ((goB_k == 2) ? mst_3_w_hasl :
                    mst_4_w_hasl)));
    assign hB_tag = ((goB_k == 0) ? mst_1_w_htag :
                    ((goB_k == 1) ? mst_2_w_htag :
                    ((goB_k == 2) ? mst_3_w_htag :
                    mst_4_w_htag)));
    assign hB_id = ((goB_k == 0) ? mst_1_w_hid :
                   ((goB_k == 1) ? mst_2_w_hid :
                   ((goB_k == 2) ? mst_3_w_hid :
                   mst_4_w_hid)));
    assign lastB = ((goB_k == 0) ? mst_1_w_hlast :
                   ((goB_k == 1) ? mst_2_w_hlast :
                   ((goB_k == 2) ? mst_3_w_hlast :
                   mst_4_w_hlast)));
    assign wiB = ((goB_k == 0) ? mst_1_w_hwi :
                 ((goB_k == 1) ? mst_2_w_hwi :
                 ((goB_k == 2) ? mst_3_w_hwi :
                 mst_4_w_hwi)));
    assign hfB = ((goB_k == 0) ? mst_1_w_hhf :
                 ((goB_k == 1) ? mst_2_w_hhf :
                 ((goB_k == 2) ? mst_3_w_hhf :
                 mst_4_w_hhf)));
    assign agg_rb_en = (goB & (~hB_loc));
    assign agg_rb_addr = {hB_asl, wiB};
    assign hB_lval = ((goB_k == 0) ? mst_1_loc_val :
                     ((goB_k == 1) ? mst_2_loc_val :
                     ((goB_k == 2) ? mst_3_loc_val :
                     mst_4_loc_val)));
    assign mst_0_pb = goA;
    assign mst_0_pl = (goA & lastA);
    assign mst_1_pb = (goB & goB_g_0);
    assign mst_1_pl = (mst_1_pb & mst_1_w_hlast);
    assign mst_2_pb = (goB & goB_g_1);
    assign mst_2_pl = (mst_2_pb & mst_2_w_hlast);
    assign mst_3_pb = (goB & goB_g_2);
    assign mst_3_pl = (mst_3_pb & mst_3_w_hlast);
    assign mst_4_pb = (goB & goB_g_3);
    assign mst_4_pl = (mst_4_pb & mst_4_w_hlast);
    assign mst_0_w_wf_n = ((mst_0_em & (~mst_0_pl)) ? (mst_0_w_wc == 31) :
                          ((mst_0_pl & (~mst_0_em)) ? (mst_0_w_wc == 33) :
                          (mst_0_w_wc == 32)));
    assign mst_0_w_hbyp = (mst_0_em & (mst_0_pl ? (win_wh1_0 == mst_0_w_wt) : (mst_0_w_wt == mst_0_w_wh)));
    assign mst_1_w_wf_n = ((mst_1_em & (~mst_1_pl)) ? (mst_1_w_wc == 31) :
                          ((mst_1_pl & (~mst_1_em)) ? (mst_1_w_wc == 33) :
                          (mst_1_w_wc == 32)));
    assign mst_1_w_hbyp = (mst_1_em & (mst_1_pl ? (win_wh1_1 == mst_1_w_wt) : (mst_1_w_wt == mst_1_w_wh)));
    assign mst_2_w_wf_n = ((mst_2_em & (~mst_2_pl)) ? (mst_2_w_wc == 31) :
                          ((mst_2_pl & (~mst_2_em)) ? (mst_2_w_wc == 33) :
                          (mst_2_w_wc == 32)));
    assign mst_2_w_hbyp = (mst_2_em & (mst_2_pl ? (win_wh1_2 == mst_2_w_wt) : (mst_2_w_wt == mst_2_w_wh)));
    assign mst_3_w_wf_n = ((mst_3_em & (~mst_3_pl)) ? (mst_3_w_wc == 31) :
                          ((mst_3_pl & (~mst_3_em)) ? (mst_3_w_wc == 33) :
                          (mst_3_w_wc == 32)));
    assign mst_3_w_hbyp = (mst_3_em & (mst_3_pl ? (win_wh1_3 == mst_3_w_wt) : (mst_3_w_wt == mst_3_w_wh)));
    assign mst_4_w_wf_n = ((mst_4_em & (~mst_4_pl)) ? (mst_4_w_wc == 31) :
                          ((mst_4_pl & (~mst_4_em)) ? (mst_4_w_wc == 33) :
                          (mst_4_w_wc == 32)));
    assign mst_4_w_hbyp = (mst_4_em & (mst_4_pl ? (win_wh1_4 == mst_4_w_wt) : (mst_4_w_wt == mst_4_w_wh)));
    assign r_0_valid = ra_v;
    assign r_0_last = ra_last;
    assign r_0_tag = ra_tag;
    assign r_0_id = ra_id;
    assign r_0_data = (ra_loc
                       ? {ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval,
                          ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval,
                          ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval, ra_lval,
                          ra_lval, ra_lval} :
                      agg_ra_data);
    assign rb_dout = (rb_loc
                      ? {rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval,
                         rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval,
                         rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval, rb_lval,
                         rb_lval, rb_lval} :
                     agg_rb_data);
    assign rb_nar_0 = ((rb_hf == 0) ? rb_dout[511:0] : rb_dout[1023:512]);
    assign r_1_valid = (rb_v & (rb_m == 1));
    assign r_1_last = rb_last;
    assign r_1_tag = rb_tag;
    assign r_1_id = rb_id;
    assign r_1_data = rb_nar_0;
    assign r_2_valid = (rb_v & (rb_m == 2));
    assign r_2_last = rb_last;
    assign r_2_tag = rb_tag;
    assign r_2_id = rb_id;
    assign r_2_data = rb_dout;
    assign r_3_valid = (rb_v & (rb_m == 3));
    assign r_3_last = rb_last;
    assign r_3_tag = rb_tag;
    assign r_3_id = rb_id;
    assign r_3_data = rb_dout;
    assign r_4_valid = (rb_v & (rb_m == 4));
    assign r_4_last = rb_last;
    assign r_4_tag = rb_tag;
    assign r_4_id = rb_id;
    assign r_4_data = rb_dout;
    assign agg_ed0_v = ed0_q;
    assign agg_ed0_slot = ed0s_q;
    assign agg_ed1_v = ed1_q;
    assign agg_ed1_slot = ed1s_q;
    assign a_0_valid = mst_0_aq_v;
    assign a_0_id = mst_0_aq_id;
    assign a_0_tag = mst_0_aq_tag;
    assign b_0_valid = mst_0_bq_v0;
    assign b_0_id = mst_0_bq_id0;
    assign b_0_tag = mst_0_bq_tag0;
    assign agg_b_ok0 = (~mst_0_bq_v1);
    assign mst_0_bq_pop = (mst_0_bq_v0 & b_0_ready);
    assign mst_0_bq_push = (agg_bev_v & (agg_bev_m == 0));
    assign a_1_valid = mst_1_aq_v;
    assign a_1_id = mst_1_aq_id;
    assign a_1_tag = mst_1_aq_tag;
    assign b_1_valid = mst_1_bq_v0;
    assign b_1_id = mst_1_bq_id0;
    assign b_1_tag = mst_1_bq_tag0;
    assign agg_b_ok1 = (~mst_1_bq_v1);
    assign mst_1_bq_pop = (mst_1_bq_v0 & b_1_ready);
    assign mst_1_bq_push = (agg_bev_v & (agg_bev_m == 1));
    assign a_2_valid = mst_2_aq_v;
    assign a_2_id = mst_2_aq_id;
    assign a_2_tag = mst_2_aq_tag;
    assign b_2_valid = mst_2_bq_v0;
    assign b_2_id = mst_2_bq_id0;
    assign b_2_tag = mst_2_bq_tag0;
    assign agg_b_ok2 = (~mst_2_bq_v1);
    assign mst_2_bq_pop = (mst_2_bq_v0 & b_2_ready);
    assign mst_2_bq_push = (agg_bev_v & (agg_bev_m == 2));
    assign a_3_valid = mst_3_aq_v;
    assign a_3_id = mst_3_aq_id;
    assign a_3_tag = mst_3_aq_tag;
    assign b_3_valid = mst_3_bq_v0;
    assign b_3_id = mst_3_bq_id0;
    assign b_3_tag = mst_3_bq_tag0;
    assign agg_b_ok3 = (~mst_3_bq_v1);
    assign mst_3_bq_pop = (mst_3_bq_v0 & b_3_ready);
    assign mst_3_bq_push = (agg_bev_v & (agg_bev_m == 3));
    assign a_4_valid = mst_4_aq_v;
    assign a_4_id = mst_4_aq_id;
    assign a_4_tag = mst_4_aq_tag;
    assign b_4_valid = mst_4_bq_v0;
    assign b_4_id = mst_4_bq_id0;
    assign b_4_tag = mst_4_bq_tag0;
    assign agg_b_ok4 = (~mst_4_bq_v1);
    assign mst_4_bq_pop = (mst_4_bq_v0 & b_4_ready);
    assign mst_4_bq_push = (agg_bev_v & (agg_bev_m == 4));
    assign dbg_pend_write = pend_write;
    assign dbg_asm_blk = asm_blk;
    assign win_occ = (((((8'd0 + {2'd0, mst_0_w_wc}) + {2'd0, mst_1_w_wc}) + {2'd0, mst_2_w_wc}) + {2'd0, mst_3_w_wc})
                      + {2'd0, mst_4_w_wc});
    assign dbg_win_occ = win_occ_q;
    assign dbg_idle = ((((((((((((((((((((((((((((((((((((((((((((((((~ra_v) & (~rb_v)) & (~adm_any))
                       & (mst_0_ra_cnt == 0)) & (mst_0_wa_cnt == 0)) & (~mst_0_ga_act)) & (~mst_0_gw_act))
                       & (mst_0_w_wc == 0)) & (~mst_0_bq_v0)) & (~mst_0_loc_act)) & (~rd_0_v)) & (~wr_0_v))
                       & (mst_1_ra_cnt == 0)) & (mst_1_wa_cnt == 0)) & (~mst_1_ga_act)) & (~mst_1_gw_act))
                       & (mst_1_w_wc == 0)) & (~mst_1_bq_v0)) & (~mst_1_loc_act)) & (~rd_1_v)) & (~wr_1_v))
                       & (mst_2_ra_cnt == 0)) & (mst_2_wa_cnt == 0)) & (~mst_2_ga_act)) & (~mst_2_gw_act))
                       & (mst_2_w_wc == 0)) & (~mst_2_bq_v0)) & (~mst_2_loc_act)) & (~rd_2_v)) & (~wr_2_v))
                       & (mst_3_ra_cnt == 0)) & (mst_3_wa_cnt == 0)) & (~mst_3_ga_act)) & (~mst_3_gw_act))
                       & (mst_3_w_wc == 0)) & (~mst_3_bq_v0)) & (~mst_3_loc_act)) & (~rd_3_v)) & (~wr_3_v))
                       & (mst_4_ra_cnt == 0)) & (mst_4_wa_cnt == 0)) & (~mst_4_ga_act)) & (~mst_4_gw_act))
                       & (mst_4_w_wc == 0)) & (~mst_4_bq_v0)) & (~mst_4_loc_act)) & (~rd_4_v)) & (~wr_4_v));
    assign rpush__m0 = mst_0_adm_rd;
    assign wpush__m0 = mst_0_adm_wr;
    assign rload__m0 = mst_0_rload;
    assign wload__m0 = mst_0_wload;
    assign em__m0 = mst_0_em;
    assign pl__m0 = mst_0_pl;
    assign slot_clr__m0 = (pl__m0 ? (32'd1 << mst_0_w_wh) : 32'd0);
    assign bpush__m0 = mst_0_bq_push;
    assign bpop__m0 = mst_0_bq_pop;
    assign rpush__m1 = mst_1_adm_rd;
    assign wpush__m1 = mst_1_adm_wr;
    assign rload__m1 = mst_1_rload;
    assign wload__m1 = mst_1_wload;
    assign em__m1 = mst_1_em;
    assign pl__m1 = mst_1_pl;
    assign slot_clr__m1 = (pl__m1 ? (32'd1 << mst_1_w_wh) : 32'd0);
    assign bpush__m1 = mst_1_bq_push;
    assign bpop__m1 = mst_1_bq_pop;
    assign rpush__m2 = mst_2_adm_rd;
    assign wpush__m2 = mst_2_adm_wr;
    assign rload__m2 = mst_2_rload;
    assign wload__m2 = mst_2_wload;
    assign em__m2 = mst_2_em;
    assign pl__m2 = mst_2_pl;
    assign slot_clr__m2 = (pl__m2 ? (32'd1 << mst_2_w_wh) : 32'd0);
    assign bpush__m2 = mst_2_bq_push;
    assign bpop__m2 = mst_2_bq_pop;
    assign rpush__m3 = mst_3_adm_rd;
    assign wpush__m3 = mst_3_adm_wr;
    assign rload__m3 = mst_3_rload;
    assign wload__m3 = mst_3_wload;
    assign em__m3 = mst_3_em;
    assign pl__m3 = mst_3_pl;
    assign slot_clr__m3 = (pl__m3 ? (32'd1 << mst_3_w_wh) : 32'd0);
    assign bpush__m3 = mst_3_bq_push;
    assign bpop__m3 = mst_3_bq_pop;
    assign rpush__m4 = mst_4_adm_rd;
    assign wpush__m4 = mst_4_adm_wr;
    assign rload__m4 = mst_4_rload;
    assign wload__m4 = mst_4_wload;
    assign em__m4 = mst_4_em;
    assign pl__m4 = mst_4_pl;
    assign slot_clr__m4 = (pl__m4 ? (32'd1 << mst_4_w_wh) : 32'd0);
    assign bpush__m4 = mst_4_bq_push;
    assign bpop__m4 = mst_4_bq_pop;
    assign bdone = (agg_bev_v & (~agg_bev_loc));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            mst_0_aq_v <= 0;
            mst_0_aq_id <= 0;
            mst_0_aq_tag <= 0;
            mst_1_aq_v <= 0;
            mst_1_aq_id <= 0;
            mst_1_aq_tag <= 0;
            mst_2_aq_v <= 0;
            mst_2_aq_id <= 0;
            mst_2_aq_tag <= 0;
            mst_3_aq_v <= 0;
            mst_3_aq_id <= 0;
            mst_3_aq_tag <= 0;
            mst_4_aq_v <= 0;
            mst_4_aq_id <= 0;
            mst_4_aq_tag <= 0;
            adm_msk <= 1023;
            adm_cq <= 0;
            adm_hq <= 0;
            ldB_rr <= 0;
            lwB_rr <= 0;
            emB_rr <= 0;
            wq_rr <= 0;
            mst_0_ra_wp <= 0;
            mst_0_ra_rp <= 0;
            mst_0_ra_cnt <= 0;
            mst_0_ra_fq <= 0;
            mst_0_ra_neq <= 0;
            mst_0_wa_wp <= 0;
            mst_0_wa_rp <= 0;
            mst_0_wa_cnt <= 0;
            mst_0_wa_fq <= 0;
            mst_0_wa_neq <= 0;
            mst_0_ga_act <= 0;
            mst_0_ga_id <= 0;
            mst_0_ga_tag <= 0;
            mst_0_ga_cur <= 0;
            mst_0_ga_rs <= 0;
            mst_0_ga_gs <= 0;
            mst_0_ga_rowend <= 0;
            mst_0_ga_ngs <= 0;
            mst_0_ga_c2 <= 0;
            mst_0_ga_bytes <= 0;
            mst_0_ga_rrem <= 0;
            mst_0_ga_lastrow <= 0;
            mst_0_ga_stride <= 0;
            mst_0_ga_loc <= 0;
            mst_0_gw_act <= 0;
            mst_0_gw_id <= 0;
            mst_0_gw_tag <= 0;
            mst_0_gw_cur <= 0;
            mst_0_gw_rs <= 0;
            mst_0_gw_gs <= 0;
            mst_0_gw_rowend <= 0;
            mst_0_gw_ngs <= 0;
            mst_0_gw_c2 <= 0;
            mst_0_gw_bytes <= 0;
            mst_0_gw_rrem <= 0;
            mst_0_gw_lastrow <= 0;
            mst_0_gw_stride <= 0;
            mst_0_gw_loc <= 0;
            mst_0_w_wt <= 0;
            mst_0_w_wh <= 0;
            win_wh1_0 <= 1;
            mst_0_w_wc <= 0;
            mst_0_w_wfq <= 0;
            mst_0_w_wrd <= 0;
            mst_0_w_hvq <= 0;
            mst_0_w_hasl <= 0;
            mst_0_w_hb0 <= 0;
            mst_0_w_hnb <= 0;
            mst_0_w_htag <= 0;
            mst_0_w_hid <= 0;
            mst_0_w_hloc <= 0;
            mst_0_w_hal <= 0;
            mst_0_w_ek <= 0;
            mst_0_loc_act <= 0;
            mst_0_loc_cnt <= 0;
            mst_0_loc_slot <= 0;
            mst_0_loc_off <= 0;
            mst_0_loc_val <= 0;
            mst_0_bq_v0 <= 0;
            mst_0_bq_id0 <= 0;
            mst_0_bq_tag0 <= 0;
            mst_0_bq_v1 <= 0;
            mst_0_bq_id1 <= 0;
            mst_0_bq_tag1 <= 0;
            mst_1_ra_wp <= 0;
            mst_1_ra_rp <= 0;
            mst_1_ra_cnt <= 0;
            mst_1_ra_fq <= 0;
            mst_1_ra_neq <= 0;
            mst_1_wa_wp <= 0;
            mst_1_wa_rp <= 0;
            mst_1_wa_cnt <= 0;
            mst_1_wa_fq <= 0;
            mst_1_wa_neq <= 0;
            mst_1_ga_act <= 0;
            mst_1_ga_id <= 0;
            mst_1_ga_tag <= 0;
            mst_1_ga_cur <= 0;
            mst_1_ga_rs <= 0;
            mst_1_ga_gs <= 0;
            mst_1_ga_rowend <= 0;
            mst_1_ga_ngs <= 0;
            mst_1_ga_c2 <= 0;
            mst_1_ga_bytes <= 0;
            mst_1_ga_rrem <= 0;
            mst_1_ga_lastrow <= 0;
            mst_1_ga_stride <= 0;
            mst_1_ga_loc <= 0;
            mst_1_gw_act <= 0;
            mst_1_gw_id <= 0;
            mst_1_gw_tag <= 0;
            mst_1_gw_cur <= 0;
            mst_1_gw_rs <= 0;
            mst_1_gw_gs <= 0;
            mst_1_gw_rowend <= 0;
            mst_1_gw_ngs <= 0;
            mst_1_gw_c2 <= 0;
            mst_1_gw_bytes <= 0;
            mst_1_gw_rrem <= 0;
            mst_1_gw_lastrow <= 0;
            mst_1_gw_stride <= 0;
            mst_1_gw_loc <= 0;
            mst_1_w_wt <= 0;
            mst_1_w_wh <= 0;
            win_wh1_1 <= 1;
            mst_1_w_wc <= 0;
            mst_1_w_wfq <= 0;
            mst_1_w_wrd <= 0;
            mst_1_w_hvq <= 0;
            mst_1_w_hasl <= 0;
            mst_1_w_hb0 <= 0;
            mst_1_w_hnb <= 0;
            mst_1_w_htag <= 0;
            mst_1_w_hid <= 0;
            mst_1_w_hloc <= 0;
            mst_1_w_hal <= 0;
            mst_1_w_ek <= 0;
            mst_1_loc_act <= 0;
            mst_1_loc_cnt <= 0;
            mst_1_loc_slot <= 0;
            mst_1_loc_off <= 0;
            mst_1_loc_val <= 0;
            mst_1_bq_v0 <= 0;
            mst_1_bq_id0 <= 0;
            mst_1_bq_tag0 <= 0;
            mst_1_bq_v1 <= 0;
            mst_1_bq_id1 <= 0;
            mst_1_bq_tag1 <= 0;
            mst_2_ra_wp <= 0;
            mst_2_ra_rp <= 0;
            mst_2_ra_cnt <= 0;
            mst_2_ra_fq <= 0;
            mst_2_ra_neq <= 0;
            mst_2_wa_wp <= 0;
            mst_2_wa_rp <= 0;
            mst_2_wa_cnt <= 0;
            mst_2_wa_fq <= 0;
            mst_2_wa_neq <= 0;
            mst_2_ga_act <= 0;
            mst_2_ga_id <= 0;
            mst_2_ga_tag <= 0;
            mst_2_ga_cur <= 0;
            mst_2_ga_rs <= 0;
            mst_2_ga_gs <= 0;
            mst_2_ga_rowend <= 0;
            mst_2_ga_ngs <= 0;
            mst_2_ga_c2 <= 0;
            mst_2_ga_bytes <= 0;
            mst_2_ga_rrem <= 0;
            mst_2_ga_lastrow <= 0;
            mst_2_ga_stride <= 0;
            mst_2_ga_loc <= 0;
            mst_2_gw_act <= 0;
            mst_2_gw_id <= 0;
            mst_2_gw_tag <= 0;
            mst_2_gw_cur <= 0;
            mst_2_gw_rs <= 0;
            mst_2_gw_gs <= 0;
            mst_2_gw_rowend <= 0;
            mst_2_gw_ngs <= 0;
            mst_2_gw_c2 <= 0;
            mst_2_gw_bytes <= 0;
            mst_2_gw_rrem <= 0;
            mst_2_gw_lastrow <= 0;
            mst_2_gw_stride <= 0;
            mst_2_gw_loc <= 0;
            mst_2_w_wt <= 0;
            mst_2_w_wh <= 0;
            win_wh1_2 <= 1;
            mst_2_w_wc <= 0;
            mst_2_w_wfq <= 0;
            mst_2_w_wrd <= 0;
            mst_2_w_hvq <= 0;
            mst_2_w_hasl <= 0;
            mst_2_w_hb0 <= 0;
            mst_2_w_hnb <= 0;
            mst_2_w_htag <= 0;
            mst_2_w_hid <= 0;
            mst_2_w_hloc <= 0;
            mst_2_w_hal <= 0;
            mst_2_w_ek <= 0;
            mst_2_loc_act <= 0;
            mst_2_loc_cnt <= 0;
            mst_2_loc_slot <= 0;
            mst_2_loc_off <= 0;
            mst_2_loc_val <= 0;
            mst_2_bq_v0 <= 0;
            mst_2_bq_id0 <= 0;
            mst_2_bq_tag0 <= 0;
            mst_2_bq_v1 <= 0;
            mst_2_bq_id1 <= 0;
            mst_2_bq_tag1 <= 0;
            mst_3_ra_wp <= 0;
            mst_3_ra_rp <= 0;
            mst_3_ra_cnt <= 0;
            mst_3_ra_fq <= 0;
            mst_3_ra_neq <= 0;
            mst_3_wa_wp <= 0;
            mst_3_wa_rp <= 0;
            mst_3_wa_cnt <= 0;
            mst_3_wa_fq <= 0;
            mst_3_wa_neq <= 0;
            mst_3_ga_act <= 0;
            mst_3_ga_id <= 0;
            mst_3_ga_tag <= 0;
            mst_3_ga_cur <= 0;
            mst_3_ga_rs <= 0;
            mst_3_ga_gs <= 0;
            mst_3_ga_rowend <= 0;
            mst_3_ga_ngs <= 0;
            mst_3_ga_c2 <= 0;
            mst_3_ga_bytes <= 0;
            mst_3_ga_rrem <= 0;
            mst_3_ga_lastrow <= 0;
            mst_3_ga_stride <= 0;
            mst_3_ga_loc <= 0;
            mst_3_gw_act <= 0;
            mst_3_gw_id <= 0;
            mst_3_gw_tag <= 0;
            mst_3_gw_cur <= 0;
            mst_3_gw_rs <= 0;
            mst_3_gw_gs <= 0;
            mst_3_gw_rowend <= 0;
            mst_3_gw_ngs <= 0;
            mst_3_gw_c2 <= 0;
            mst_3_gw_bytes <= 0;
            mst_3_gw_rrem <= 0;
            mst_3_gw_lastrow <= 0;
            mst_3_gw_stride <= 0;
            mst_3_gw_loc <= 0;
            mst_3_w_wt <= 0;
            mst_3_w_wh <= 0;
            win_wh1_3 <= 1;
            mst_3_w_wc <= 0;
            mst_3_w_wfq <= 0;
            mst_3_w_wrd <= 0;
            mst_3_w_hvq <= 0;
            mst_3_w_hasl <= 0;
            mst_3_w_hb0 <= 0;
            mst_3_w_hnb <= 0;
            mst_3_w_htag <= 0;
            mst_3_w_hid <= 0;
            mst_3_w_hloc <= 0;
            mst_3_w_hal <= 0;
            mst_3_w_ek <= 0;
            mst_3_loc_act <= 0;
            mst_3_loc_cnt <= 0;
            mst_3_loc_slot <= 0;
            mst_3_loc_off <= 0;
            mst_3_loc_val <= 0;
            mst_3_bq_v0 <= 0;
            mst_3_bq_id0 <= 0;
            mst_3_bq_tag0 <= 0;
            mst_3_bq_v1 <= 0;
            mst_3_bq_id1 <= 0;
            mst_3_bq_tag1 <= 0;
            mst_4_ra_wp <= 0;
            mst_4_ra_rp <= 0;
            mst_4_ra_cnt <= 0;
            mst_4_ra_fq <= 0;
            mst_4_ra_neq <= 0;
            mst_4_wa_wp <= 0;
            mst_4_wa_rp <= 0;
            mst_4_wa_cnt <= 0;
            mst_4_wa_fq <= 0;
            mst_4_wa_neq <= 0;
            mst_4_ga_act <= 0;
            mst_4_ga_id <= 0;
            mst_4_ga_tag <= 0;
            mst_4_ga_cur <= 0;
            mst_4_ga_rs <= 0;
            mst_4_ga_gs <= 0;
            mst_4_ga_rowend <= 0;
            mst_4_ga_ngs <= 0;
            mst_4_ga_c2 <= 0;
            mst_4_ga_bytes <= 0;
            mst_4_ga_rrem <= 0;
            mst_4_ga_lastrow <= 0;
            mst_4_ga_stride <= 0;
            mst_4_ga_loc <= 0;
            mst_4_gw_act <= 0;
            mst_4_gw_id <= 0;
            mst_4_gw_tag <= 0;
            mst_4_gw_cur <= 0;
            mst_4_gw_rs <= 0;
            mst_4_gw_gs <= 0;
            mst_4_gw_rowend <= 0;
            mst_4_gw_ngs <= 0;
            mst_4_gw_c2 <= 0;
            mst_4_gw_bytes <= 0;
            mst_4_gw_rrem <= 0;
            mst_4_gw_lastrow <= 0;
            mst_4_gw_stride <= 0;
            mst_4_gw_loc <= 0;
            mst_4_w_wt <= 0;
            mst_4_w_wh <= 0;
            win_wh1_4 <= 1;
            mst_4_w_wc <= 0;
            mst_4_w_wfq <= 0;
            mst_4_w_wrd <= 0;
            mst_4_w_hvq <= 0;
            mst_4_w_hasl <= 0;
            mst_4_w_hb0 <= 0;
            mst_4_w_hnb <= 0;
            mst_4_w_htag <= 0;
            mst_4_w_hid <= 0;
            mst_4_w_hloc <= 0;
            mst_4_w_hal <= 0;
            mst_4_w_ek <= 0;
            mst_4_loc_act <= 0;
            mst_4_loc_cnt <= 0;
            mst_4_loc_slot <= 0;
            mst_4_loc_off <= 0;
            mst_4_loc_val <= 0;
            mst_4_bq_v0 <= 0;
            mst_4_bq_id0 <= 0;
            mst_4_bq_tag0 <= 0;
            mst_4_bq_v1 <= 0;
            mst_4_bq_id1 <= 0;
            mst_4_bq_tag1 <= 0;
            ra_v <= 0;
            ra_last <= 0;
            ra_tag <= 0;
            ra_id <= 0;
            ra_loc <= 0;
            rb_v <= 0;
            rb_m <= 1;
            rb_last <= 0;
            rb_tag <= 0;
            rb_id <= 0;
            rb_loc <= 0;
            rb_hf <= 0;
            rb_rr <= 0;
            ed0_q <= 0;
            ed0s_q <= 0;
            ed1_q <= 0;
            ed1s_q <= 0;
            asm_blk_q <= 0;
            asm_blk <= 0;
            win_occ_q <= 0;
            pend_write <= 0;
        end else begin
            mst_0_aq_v <= (mst_0_adm_rd | mst_0_adm_wr);
            if ((mst_0_adm_rd | mst_0_adm_wr)) begin
                mst_0_aq_id <= (mst_0_adm_rd ? rd_0_id : wr_0_id);
                mst_0_aq_tag <= (mst_0_adm_rd ? rd_0_tag : wr_0_tag);
            end
            mst_1_aq_v <= (mst_1_adm_rd | mst_1_adm_wr);
            if ((mst_1_adm_rd | mst_1_adm_wr)) begin
                mst_1_aq_id <= (mst_1_adm_rd ? rd_1_id : wr_1_id);
                mst_1_aq_tag <= (mst_1_adm_rd ? rd_1_tag : wr_1_tag);
            end
            mst_2_aq_v <= (mst_2_adm_rd | mst_2_adm_wr);
            if ((mst_2_adm_rd | mst_2_adm_wr)) begin
                mst_2_aq_id <= (mst_2_adm_rd ? rd_2_id : wr_2_id);
                mst_2_aq_tag <= (mst_2_adm_rd ? rd_2_tag : wr_2_tag);
            end
            mst_3_aq_v <= (mst_3_adm_rd | mst_3_adm_wr);
            if ((mst_3_adm_rd | mst_3_adm_wr)) begin
                mst_3_aq_id <= (mst_3_adm_rd ? rd_3_id : wr_3_id);
                mst_3_aq_tag <= (mst_3_adm_rd ? rd_3_tag : wr_3_tag);
            end
            mst_4_aq_v <= (mst_4_adm_rd | mst_4_adm_wr);
            if ((mst_4_adm_rd | mst_4_adm_wr)) begin
                mst_4_aq_id <= (mst_4_adm_rd ? rd_4_id : wr_4_id);
                mst_4_aq_tag <= (mst_4_adm_rd ? rd_4_tag : wr_4_tag);
            end
            adm_msk <= adm_msk_nx;
            adm_cq <= adm_c_n;
            adm_hq <= adm_h_n;
            if (ldB_any) begin
                ldB_rr <= (ldB_k + 1);
            end
            if (lwB_any) begin
                lwB_rr <= (lwB_k + 1);
            end
            if (emB_any) begin
                emB_rr <= (emB_k + 1);
            end
            if (wq_any) begin
                wq_rr <= (wq_k + 1);
            end
            mst_0_ra_wp <= (mst_0_ra_wp + {2'd0, rpush__m0});
            mst_0_ra_rp <= (mst_0_ra_rp + {2'd0, rload__m0});
            mst_0_ra_cnt <= ((mst_0_ra_cnt + {3'd0, rpush__m0}) - {3'd0, rload__m0});
            mst_0_ra_fq <= mst_0_ra_f_n;
            mst_0_ra_neq <= mst_0_ra_ne_n;
            mst_0_wa_wp <= (mst_0_wa_wp + {2'd0, wpush__m0});
            mst_0_wa_rp <= (mst_0_wa_rp + {2'd0, wload__m0});
            mst_0_wa_cnt <= ((mst_0_wa_cnt + {3'd0, wpush__m0}) - {3'd0, wload__m0});
            mst_0_wa_fq <= mst_0_wa_f_n;
            mst_0_wa_neq <= mst_0_wa_ne_n;
            if (rload__m0) begin
                mst_0_ga_act <= 1;
                mst_0_ga_id <= mst_0_rhd_id;
                mst_0_ga_tag <= mst_0_rhd_tag;
                mst_0_ga_cur <= mst_0_rhd_addr;
                mst_0_ga_rs <= mst_0_rhd_addr;
                mst_0_ga_gs <= mst_0_rhd_gs;
                mst_0_ga_rowend <= (mst_0_rhd_gs <= 256);
                mst_0_ga_ngs <= mst_0_rhd_ngs;
                mst_0_ga_c2 <= mst_0_rhd_c2;
                mst_0_ga_bytes <= mst_0_rhd_bytes;
                mst_0_ga_rrem <= mst_0_rhd_rows;
                mst_0_ga_lastrow <= (mst_0_rhd_rows <= 1);
                mst_0_ga_stride <= mst_0_rhd_stride;
                mst_0_ga_loc <= mst_0_rhd_loc;
            end else begin
                if (mst_0_em) begin
                    if ((mst_0_ga_loc | mst_0_ga_al)) begin
                        mst_0_ga_act <= 0;
                    end else begin
                        if (mst_0_ga_rowend) begin
                            mst_0_ga_rrem <= (mst_0_ga_rrem - 1);
                            mst_0_ga_lastrow <= (mst_0_ga_rrem == 2);
                            mst_0_ga_rs <= mst_0_ga_rsn;
                            mst_0_ga_cur <= mst_0_ga_rsn;
                            mst_0_ga_gs <= mst_0_ga_ngs;
                            mst_0_ga_rowend <= (mst_0_ga_ngs <= 256);
                            mst_0_ga_ngs <= mst_0_ga_ngn;
                            mst_0_ga_c2 <= (mst_0_ga_c2 + mst_0_ga_stride[7:0]);
                        end else begin
                            mst_0_ga_cur <= mst_0_ga_cnx;
                            mst_0_ga_gs <= mst_0_ga_gsd;
                            mst_0_ga_rowend <= (mst_0_ga_gs <= 512);
                        end
                    end
                end
            end
            if (wload__m0) begin
                mst_0_gw_act <= 1;
                mst_0_gw_id <= mst_0_whd_id;
                mst_0_gw_tag <= mst_0_whd_tag;
                mst_0_gw_cur <= mst_0_whd_addr;
                mst_0_gw_rs <= mst_0_whd_addr;
                mst_0_gw_gs <= mst_0_whd_gs;
                mst_0_gw_rowend <= (mst_0_whd_gs <= 256);
                mst_0_gw_ngs <= mst_0_whd_ngs;
                mst_0_gw_c2 <= mst_0_whd_c2;
                mst_0_gw_bytes <= mst_0_whd_bytes;
                mst_0_gw_rrem <= mst_0_whd_rows;
                mst_0_gw_lastrow <= (mst_0_whd_rows <= 1);
                mst_0_gw_stride <= mst_0_whd_stride;
                mst_0_gw_loc <= mst_0_whd_loc;
            end else begin
                if (mst_0_wem) begin
                    if ((mst_0_gw_loc | mst_0_gw_al)) begin
                        mst_0_gw_act <= 0;
                    end else begin
                        if (mst_0_gw_rowend) begin
                            mst_0_gw_rrem <= (mst_0_gw_rrem - 1);
                            mst_0_gw_lastrow <= (mst_0_gw_rrem == 2);
                            mst_0_gw_rs <= mst_0_gw_rsn;
                            mst_0_gw_cur <= mst_0_gw_rsn;
                            mst_0_gw_gs <= mst_0_gw_ngs;
                            mst_0_gw_rowend <= (mst_0_gw_ngs <= 256);
                            mst_0_gw_ngs <= mst_0_gw_ngn;
                            mst_0_gw_c2 <= (mst_0_gw_c2 + mst_0_gw_stride[7:0]);
                        end else begin
                            mst_0_gw_cur <= mst_0_gw_cnx;
                            mst_0_gw_gs <= mst_0_gw_gsd;
                            mst_0_gw_rowend <= (mst_0_gw_gs <= 512);
                        end
                    end
                end
            end
            mst_0_w_wt <= (mst_0_w_wt + {4'd0, em__m0});
            mst_0_w_wh <= (mst_0_w_wh + {4'd0, pl__m0});
            win_wh1_0 <= (win_wh1_0 + {4'd0, pl__m0});
            mst_0_w_wc <= ((mst_0_w_wc + {5'd0, em__m0}) - {5'd0, pl__m0});
            mst_0_w_wfq <= mst_0_w_wf_n;
            mst_0_w_wrd <= ((mst_0_w_wrd | mst_0_w_rdys) & (~slot_clr__m0));
            mst_0_w_hvq <= (pl__m0 ? mst_0_w_hn1 : mst_0_w_hn0);
            if (mst_0_w_hbyp) begin
                mst_0_w_hasl <= mst_0_slot;
                mst_0_w_hb0 <= mst_0_ga_b0;
                mst_0_w_hnb <= (mst_0_ga_loc ? 3'd1 : mst_0_ga_nbeat);
                mst_0_w_htag <= mst_0_ga_tag;
                mst_0_w_hid <= mst_0_ga_id;
                mst_0_w_hloc <= mst_0_ga_loc;
                mst_0_w_hal <= (mst_0_ga_loc | mst_0_ga_al);
            end else begin
                if (pl__m0) begin
                    mst_0_w_hasl <= mst_0_w_nasl;
                    mst_0_w_hb0 <= mst_0_w_nb0;
                    mst_0_w_hnb <= mst_0_w_nnb;
                    mst_0_w_htag <= mst_0_w_ntag;
                    mst_0_w_hid <= mst_0_w_nid;
                    mst_0_w_hloc <= mst_0_w_nloc;
                    mst_0_w_hal <= mst_0_w_nal;
                end
            end
            if (pl__m0) begin
                mst_0_w_ek <= 0;
            end else begin
                if (mst_0_pb) begin
                    mst_0_w_ek <= (mst_0_w_ek + 1);
                end
            end
            if ((em__m0 & mst_0_ga_loc)) begin
                mst_0_loc_act <= 1;
                mst_0_loc_cnt <= 5;
                mst_0_loc_slot <= mst_0_w_wt;
                mst_0_loc_off <= mst_0_ga_off;
            end else begin
                if (mst_0_loc_done) begin
                    mst_0_loc_act <= 0;
                end else begin
                    if (mst_0_loc_act) begin
                        mst_0_loc_cnt <= (mst_0_loc_cnt - 1);
                    end
                end
            end
            if (mst_0_loc_done) begin
                mst_0_loc_val <= mst_0_loc_rd;
            end
            if ((bpop__m0 & (~bpush__m0))) begin
                mst_0_bq_v0 <= mst_0_bq_v1;
                mst_0_bq_id0 <= mst_0_bq_id1;
                mst_0_bq_tag0 <= mst_0_bq_tag1;
                mst_0_bq_v1 <= 0;
            end else begin
                if ((bpush__m0 & (~bpop__m0))) begin
                    if ((~mst_0_bq_v0)) begin
                        mst_0_bq_v0 <= 1;
                        mst_0_bq_id0 <= agg_bev_wid;
                        mst_0_bq_tag0 <= agg_bev_tag;
                    end else begin
                        mst_0_bq_v1 <= 1;
                        mst_0_bq_id1 <= agg_bev_wid;
                        mst_0_bq_tag1 <= agg_bev_tag;
                    end
                end else begin
                    if ((bpush__m0 & bpop__m0)) begin
                        if (mst_0_bq_v1) begin
                            mst_0_bq_id0 <= mst_0_bq_id1;
                            mst_0_bq_tag0 <= mst_0_bq_tag1;
                            mst_0_bq_id1 <= agg_bev_wid;
                            mst_0_bq_tag1 <= agg_bev_tag;
                        end else begin
                            mst_0_bq_id0 <= agg_bev_wid;
                            mst_0_bq_tag0 <= agg_bev_tag;
                        end
                    end
                end
            end
            mst_1_ra_wp <= (mst_1_ra_wp + {2'd0, rpush__m1});
            mst_1_ra_rp <= (mst_1_ra_rp + {2'd0, rload__m1});
            mst_1_ra_cnt <= ((mst_1_ra_cnt + {3'd0, rpush__m1}) - {3'd0, rload__m1});
            mst_1_ra_fq <= mst_1_ra_f_n;
            mst_1_ra_neq <= mst_1_ra_ne_n;
            mst_1_wa_wp <= (mst_1_wa_wp + {2'd0, wpush__m1});
            mst_1_wa_rp <= (mst_1_wa_rp + {2'd0, wload__m1});
            mst_1_wa_cnt <= ((mst_1_wa_cnt + {3'd0, wpush__m1}) - {3'd0, wload__m1});
            mst_1_wa_fq <= mst_1_wa_f_n;
            mst_1_wa_neq <= mst_1_wa_ne_n;
            if (rload__m1) begin
                mst_1_ga_act <= 1;
                mst_1_ga_id <= mst_1_rhd_id;
                mst_1_ga_tag <= mst_1_rhd_tag;
                mst_1_ga_cur <= mst_1_rhd_addr;
                mst_1_ga_rs <= mst_1_rhd_addr;
                mst_1_ga_gs <= mst_1_rhd_gs;
                mst_1_ga_rowend <= (mst_1_rhd_gs <= 256);
                mst_1_ga_ngs <= mst_1_rhd_ngs;
                mst_1_ga_c2 <= mst_1_rhd_c2;
                mst_1_ga_bytes <= mst_1_rhd_bytes;
                mst_1_ga_rrem <= mst_1_rhd_rows;
                mst_1_ga_lastrow <= (mst_1_rhd_rows <= 1);
                mst_1_ga_stride <= mst_1_rhd_stride;
                mst_1_ga_loc <= mst_1_rhd_loc;
            end else begin
                if (mst_1_em) begin
                    if ((mst_1_ga_loc | mst_1_ga_al)) begin
                        mst_1_ga_act <= 0;
                    end else begin
                        if (mst_1_ga_rowend) begin
                            mst_1_ga_rrem <= (mst_1_ga_rrem - 1);
                            mst_1_ga_lastrow <= (mst_1_ga_rrem == 2);
                            mst_1_ga_rs <= mst_1_ga_rsn;
                            mst_1_ga_cur <= mst_1_ga_rsn;
                            mst_1_ga_gs <= mst_1_ga_ngs;
                            mst_1_ga_rowend <= (mst_1_ga_ngs <= 256);
                            mst_1_ga_ngs <= mst_1_ga_ngn;
                            mst_1_ga_c2 <= (mst_1_ga_c2 + mst_1_ga_stride[7:0]);
                        end else begin
                            mst_1_ga_cur <= mst_1_ga_cnx;
                            mst_1_ga_gs <= mst_1_ga_gsd;
                            mst_1_ga_rowend <= (mst_1_ga_gs <= 512);
                        end
                    end
                end
            end
            if (wload__m1) begin
                mst_1_gw_act <= 1;
                mst_1_gw_id <= mst_1_whd_id;
                mst_1_gw_tag <= mst_1_whd_tag;
                mst_1_gw_cur <= mst_1_whd_addr;
                mst_1_gw_rs <= mst_1_whd_addr;
                mst_1_gw_gs <= mst_1_whd_gs;
                mst_1_gw_rowend <= (mst_1_whd_gs <= 256);
                mst_1_gw_ngs <= mst_1_whd_ngs;
                mst_1_gw_c2 <= mst_1_whd_c2;
                mst_1_gw_bytes <= mst_1_whd_bytes;
                mst_1_gw_rrem <= mst_1_whd_rows;
                mst_1_gw_lastrow <= (mst_1_whd_rows <= 1);
                mst_1_gw_stride <= mst_1_whd_stride;
                mst_1_gw_loc <= mst_1_whd_loc;
            end else begin
                if (mst_1_wem) begin
                    if ((mst_1_gw_loc | mst_1_gw_al)) begin
                        mst_1_gw_act <= 0;
                    end else begin
                        if (mst_1_gw_rowend) begin
                            mst_1_gw_rrem <= (mst_1_gw_rrem - 1);
                            mst_1_gw_lastrow <= (mst_1_gw_rrem == 2);
                            mst_1_gw_rs <= mst_1_gw_rsn;
                            mst_1_gw_cur <= mst_1_gw_rsn;
                            mst_1_gw_gs <= mst_1_gw_ngs;
                            mst_1_gw_rowend <= (mst_1_gw_ngs <= 256);
                            mst_1_gw_ngs <= mst_1_gw_ngn;
                            mst_1_gw_c2 <= (mst_1_gw_c2 + mst_1_gw_stride[7:0]);
                        end else begin
                            mst_1_gw_cur <= mst_1_gw_cnx;
                            mst_1_gw_gs <= mst_1_gw_gsd;
                            mst_1_gw_rowend <= (mst_1_gw_gs <= 512);
                        end
                    end
                end
            end
            mst_1_w_wt <= (mst_1_w_wt + {4'd0, em__m1});
            mst_1_w_wh <= (mst_1_w_wh + {4'd0, pl__m1});
            win_wh1_1 <= (win_wh1_1 + {4'd0, pl__m1});
            mst_1_w_wc <= ((mst_1_w_wc + {5'd0, em__m1}) - {5'd0, pl__m1});
            mst_1_w_wfq <= mst_1_w_wf_n;
            mst_1_w_wrd <= ((mst_1_w_wrd | mst_1_w_rdys) & (~slot_clr__m1));
            mst_1_w_hvq <= (pl__m1 ? mst_1_w_hn1 : mst_1_w_hn0);
            if (mst_1_w_hbyp) begin
                mst_1_w_hasl <= mst_1_slot;
                mst_1_w_hb0 <= mst_1_ga_b0;
                mst_1_w_hnb <= (mst_1_ga_loc ? 3'd1 : mst_1_ga_nbeat);
                mst_1_w_htag <= mst_1_ga_tag;
                mst_1_w_hid <= mst_1_ga_id;
                mst_1_w_hloc <= mst_1_ga_loc;
                mst_1_w_hal <= (mst_1_ga_loc | mst_1_ga_al);
            end else begin
                if (pl__m1) begin
                    mst_1_w_hasl <= mst_1_w_nasl;
                    mst_1_w_hb0 <= mst_1_w_nb0;
                    mst_1_w_hnb <= mst_1_w_nnb;
                    mst_1_w_htag <= mst_1_w_ntag;
                    mst_1_w_hid <= mst_1_w_nid;
                    mst_1_w_hloc <= mst_1_w_nloc;
                    mst_1_w_hal <= mst_1_w_nal;
                end
            end
            if (pl__m1) begin
                mst_1_w_ek <= 0;
            end else begin
                if (mst_1_pb) begin
                    mst_1_w_ek <= (mst_1_w_ek + 1);
                end
            end
            if ((em__m1 & mst_1_ga_loc)) begin
                mst_1_loc_act <= 1;
                mst_1_loc_cnt <= 5;
                mst_1_loc_slot <= mst_1_w_wt;
                mst_1_loc_off <= mst_1_ga_off;
            end else begin
                if (mst_1_loc_done) begin
                    mst_1_loc_act <= 0;
                end else begin
                    if (mst_1_loc_act) begin
                        mst_1_loc_cnt <= (mst_1_loc_cnt - 1);
                    end
                end
            end
            if (mst_1_loc_done) begin
                mst_1_loc_val <= mst_1_loc_rd;
            end
            if ((bpop__m1 & (~bpush__m1))) begin
                mst_1_bq_v0 <= mst_1_bq_v1;
                mst_1_bq_id0 <= mst_1_bq_id1;
                mst_1_bq_tag0 <= mst_1_bq_tag1;
                mst_1_bq_v1 <= 0;
            end else begin
                if ((bpush__m1 & (~bpop__m1))) begin
                    if ((~mst_1_bq_v0)) begin
                        mst_1_bq_v0 <= 1;
                        mst_1_bq_id0 <= agg_bev_wid;
                        mst_1_bq_tag0 <= agg_bev_tag;
                    end else begin
                        mst_1_bq_v1 <= 1;
                        mst_1_bq_id1 <= agg_bev_wid;
                        mst_1_bq_tag1 <= agg_bev_tag;
                    end
                end else begin
                    if ((bpush__m1 & bpop__m1)) begin
                        if (mst_1_bq_v1) begin
                            mst_1_bq_id0 <= mst_1_bq_id1;
                            mst_1_bq_tag0 <= mst_1_bq_tag1;
                            mst_1_bq_id1 <= agg_bev_wid;
                            mst_1_bq_tag1 <= agg_bev_tag;
                        end else begin
                            mst_1_bq_id0 <= agg_bev_wid;
                            mst_1_bq_tag0 <= agg_bev_tag;
                        end
                    end
                end
            end
            mst_2_ra_wp <= (mst_2_ra_wp + {2'd0, rpush__m2});
            mst_2_ra_rp <= (mst_2_ra_rp + {2'd0, rload__m2});
            mst_2_ra_cnt <= ((mst_2_ra_cnt + {3'd0, rpush__m2}) - {3'd0, rload__m2});
            mst_2_ra_fq <= mst_2_ra_f_n;
            mst_2_ra_neq <= mst_2_ra_ne_n;
            mst_2_wa_wp <= (mst_2_wa_wp + {2'd0, wpush__m2});
            mst_2_wa_rp <= (mst_2_wa_rp + {2'd0, wload__m2});
            mst_2_wa_cnt <= ((mst_2_wa_cnt + {3'd0, wpush__m2}) - {3'd0, wload__m2});
            mst_2_wa_fq <= mst_2_wa_f_n;
            mst_2_wa_neq <= mst_2_wa_ne_n;
            if (rload__m2) begin
                mst_2_ga_act <= 1;
                mst_2_ga_id <= mst_2_rhd_id;
                mst_2_ga_tag <= mst_2_rhd_tag;
                mst_2_ga_cur <= mst_2_rhd_addr;
                mst_2_ga_rs <= mst_2_rhd_addr;
                mst_2_ga_gs <= mst_2_rhd_gs;
                mst_2_ga_rowend <= (mst_2_rhd_gs <= 256);
                mst_2_ga_ngs <= mst_2_rhd_ngs;
                mst_2_ga_c2 <= mst_2_rhd_c2;
                mst_2_ga_bytes <= mst_2_rhd_bytes;
                mst_2_ga_rrem <= mst_2_rhd_rows;
                mst_2_ga_lastrow <= (mst_2_rhd_rows <= 1);
                mst_2_ga_stride <= mst_2_rhd_stride;
                mst_2_ga_loc <= mst_2_rhd_loc;
            end else begin
                if (mst_2_em) begin
                    if ((mst_2_ga_loc | mst_2_ga_al)) begin
                        mst_2_ga_act <= 0;
                    end else begin
                        if (mst_2_ga_rowend) begin
                            mst_2_ga_rrem <= (mst_2_ga_rrem - 1);
                            mst_2_ga_lastrow <= (mst_2_ga_rrem == 2);
                            mst_2_ga_rs <= mst_2_ga_rsn;
                            mst_2_ga_cur <= mst_2_ga_rsn;
                            mst_2_ga_gs <= mst_2_ga_ngs;
                            mst_2_ga_rowend <= (mst_2_ga_ngs <= 256);
                            mst_2_ga_ngs <= mst_2_ga_ngn;
                            mst_2_ga_c2 <= (mst_2_ga_c2 + mst_2_ga_stride[7:0]);
                        end else begin
                            mst_2_ga_cur <= mst_2_ga_cnx;
                            mst_2_ga_gs <= mst_2_ga_gsd;
                            mst_2_ga_rowend <= (mst_2_ga_gs <= 512);
                        end
                    end
                end
            end
            if (wload__m2) begin
                mst_2_gw_act <= 1;
                mst_2_gw_id <= mst_2_whd_id;
                mst_2_gw_tag <= mst_2_whd_tag;
                mst_2_gw_cur <= mst_2_whd_addr;
                mst_2_gw_rs <= mst_2_whd_addr;
                mst_2_gw_gs <= mst_2_whd_gs;
                mst_2_gw_rowend <= (mst_2_whd_gs <= 256);
                mst_2_gw_ngs <= mst_2_whd_ngs;
                mst_2_gw_c2 <= mst_2_whd_c2;
                mst_2_gw_bytes <= mst_2_whd_bytes;
                mst_2_gw_rrem <= mst_2_whd_rows;
                mst_2_gw_lastrow <= (mst_2_whd_rows <= 1);
                mst_2_gw_stride <= mst_2_whd_stride;
                mst_2_gw_loc <= mst_2_whd_loc;
            end else begin
                if (mst_2_wem) begin
                    if ((mst_2_gw_loc | mst_2_gw_al)) begin
                        mst_2_gw_act <= 0;
                    end else begin
                        if (mst_2_gw_rowend) begin
                            mst_2_gw_rrem <= (mst_2_gw_rrem - 1);
                            mst_2_gw_lastrow <= (mst_2_gw_rrem == 2);
                            mst_2_gw_rs <= mst_2_gw_rsn;
                            mst_2_gw_cur <= mst_2_gw_rsn;
                            mst_2_gw_gs <= mst_2_gw_ngs;
                            mst_2_gw_rowend <= (mst_2_gw_ngs <= 256);
                            mst_2_gw_ngs <= mst_2_gw_ngn;
                            mst_2_gw_c2 <= (mst_2_gw_c2 + mst_2_gw_stride[7:0]);
                        end else begin
                            mst_2_gw_cur <= mst_2_gw_cnx;
                            mst_2_gw_gs <= mst_2_gw_gsd;
                            mst_2_gw_rowend <= (mst_2_gw_gs <= 512);
                        end
                    end
                end
            end
            mst_2_w_wt <= (mst_2_w_wt + {4'd0, em__m2});
            mst_2_w_wh <= (mst_2_w_wh + {4'd0, pl__m2});
            win_wh1_2 <= (win_wh1_2 + {4'd0, pl__m2});
            mst_2_w_wc <= ((mst_2_w_wc + {5'd0, em__m2}) - {5'd0, pl__m2});
            mst_2_w_wfq <= mst_2_w_wf_n;
            mst_2_w_wrd <= ((mst_2_w_wrd | mst_2_w_rdys) & (~slot_clr__m2));
            mst_2_w_hvq <= (pl__m2 ? mst_2_w_hn1 : mst_2_w_hn0);
            if (mst_2_w_hbyp) begin
                mst_2_w_hasl <= mst_2_slot;
                mst_2_w_hb0 <= mst_2_ga_b0;
                mst_2_w_hnb <= (mst_2_ga_loc ? 3'd1 : mst_2_ga_nbeat);
                mst_2_w_htag <= mst_2_ga_tag;
                mst_2_w_hid <= mst_2_ga_id;
                mst_2_w_hloc <= mst_2_ga_loc;
                mst_2_w_hal <= (mst_2_ga_loc | mst_2_ga_al);
            end else begin
                if (pl__m2) begin
                    mst_2_w_hasl <= mst_2_w_nasl;
                    mst_2_w_hb0 <= mst_2_w_nb0;
                    mst_2_w_hnb <= mst_2_w_nnb;
                    mst_2_w_htag <= mst_2_w_ntag;
                    mst_2_w_hid <= mst_2_w_nid;
                    mst_2_w_hloc <= mst_2_w_nloc;
                    mst_2_w_hal <= mst_2_w_nal;
                end
            end
            if (pl__m2) begin
                mst_2_w_ek <= 0;
            end else begin
                if (mst_2_pb) begin
                    mst_2_w_ek <= (mst_2_w_ek + 1);
                end
            end
            if ((em__m2 & mst_2_ga_loc)) begin
                mst_2_loc_act <= 1;
                mst_2_loc_cnt <= 5;
                mst_2_loc_slot <= mst_2_w_wt;
                mst_2_loc_off <= mst_2_ga_off;
            end else begin
                if (mst_2_loc_done) begin
                    mst_2_loc_act <= 0;
                end else begin
                    if (mst_2_loc_act) begin
                        mst_2_loc_cnt <= (mst_2_loc_cnt - 1);
                    end
                end
            end
            if (mst_2_loc_done) begin
                mst_2_loc_val <= mst_2_loc_rd;
            end
            if ((bpop__m2 & (~bpush__m2))) begin
                mst_2_bq_v0 <= mst_2_bq_v1;
                mst_2_bq_id0 <= mst_2_bq_id1;
                mst_2_bq_tag0 <= mst_2_bq_tag1;
                mst_2_bq_v1 <= 0;
            end else begin
                if ((bpush__m2 & (~bpop__m2))) begin
                    if ((~mst_2_bq_v0)) begin
                        mst_2_bq_v0 <= 1;
                        mst_2_bq_id0 <= agg_bev_wid;
                        mst_2_bq_tag0 <= agg_bev_tag;
                    end else begin
                        mst_2_bq_v1 <= 1;
                        mst_2_bq_id1 <= agg_bev_wid;
                        mst_2_bq_tag1 <= agg_bev_tag;
                    end
                end else begin
                    if ((bpush__m2 & bpop__m2)) begin
                        if (mst_2_bq_v1) begin
                            mst_2_bq_id0 <= mst_2_bq_id1;
                            mst_2_bq_tag0 <= mst_2_bq_tag1;
                            mst_2_bq_id1 <= agg_bev_wid;
                            mst_2_bq_tag1 <= agg_bev_tag;
                        end else begin
                            mst_2_bq_id0 <= agg_bev_wid;
                            mst_2_bq_tag0 <= agg_bev_tag;
                        end
                    end
                end
            end
            mst_3_ra_wp <= (mst_3_ra_wp + {2'd0, rpush__m3});
            mst_3_ra_rp <= (mst_3_ra_rp + {2'd0, rload__m3});
            mst_3_ra_cnt <= ((mst_3_ra_cnt + {3'd0, rpush__m3}) - {3'd0, rload__m3});
            mst_3_ra_fq <= mst_3_ra_f_n;
            mst_3_ra_neq <= mst_3_ra_ne_n;
            mst_3_wa_wp <= (mst_3_wa_wp + {2'd0, wpush__m3});
            mst_3_wa_rp <= (mst_3_wa_rp + {2'd0, wload__m3});
            mst_3_wa_cnt <= ((mst_3_wa_cnt + {3'd0, wpush__m3}) - {3'd0, wload__m3});
            mst_3_wa_fq <= mst_3_wa_f_n;
            mst_3_wa_neq <= mst_3_wa_ne_n;
            if (rload__m3) begin
                mst_3_ga_act <= 1;
                mst_3_ga_id <= mst_3_rhd_id;
                mst_3_ga_tag <= mst_3_rhd_tag;
                mst_3_ga_cur <= mst_3_rhd_addr;
                mst_3_ga_rs <= mst_3_rhd_addr;
                mst_3_ga_gs <= mst_3_rhd_gs;
                mst_3_ga_rowend <= (mst_3_rhd_gs <= 256);
                mst_3_ga_ngs <= mst_3_rhd_ngs;
                mst_3_ga_c2 <= mst_3_rhd_c2;
                mst_3_ga_bytes <= mst_3_rhd_bytes;
                mst_3_ga_rrem <= mst_3_rhd_rows;
                mst_3_ga_lastrow <= (mst_3_rhd_rows <= 1);
                mst_3_ga_stride <= mst_3_rhd_stride;
                mst_3_ga_loc <= mst_3_rhd_loc;
            end else begin
                if (mst_3_em) begin
                    if ((mst_3_ga_loc | mst_3_ga_al)) begin
                        mst_3_ga_act <= 0;
                    end else begin
                        if (mst_3_ga_rowend) begin
                            mst_3_ga_rrem <= (mst_3_ga_rrem - 1);
                            mst_3_ga_lastrow <= (mst_3_ga_rrem == 2);
                            mst_3_ga_rs <= mst_3_ga_rsn;
                            mst_3_ga_cur <= mst_3_ga_rsn;
                            mst_3_ga_gs <= mst_3_ga_ngs;
                            mst_3_ga_rowend <= (mst_3_ga_ngs <= 256);
                            mst_3_ga_ngs <= mst_3_ga_ngn;
                            mst_3_ga_c2 <= (mst_3_ga_c2 + mst_3_ga_stride[7:0]);
                        end else begin
                            mst_3_ga_cur <= mst_3_ga_cnx;
                            mst_3_ga_gs <= mst_3_ga_gsd;
                            mst_3_ga_rowend <= (mst_3_ga_gs <= 512);
                        end
                    end
                end
            end
            if (wload__m3) begin
                mst_3_gw_act <= 1;
                mst_3_gw_id <= mst_3_whd_id;
                mst_3_gw_tag <= mst_3_whd_tag;
                mst_3_gw_cur <= mst_3_whd_addr;
                mst_3_gw_rs <= mst_3_whd_addr;
                mst_3_gw_gs <= mst_3_whd_gs;
                mst_3_gw_rowend <= (mst_3_whd_gs <= 256);
                mst_3_gw_ngs <= mst_3_whd_ngs;
                mst_3_gw_c2 <= mst_3_whd_c2;
                mst_3_gw_bytes <= mst_3_whd_bytes;
                mst_3_gw_rrem <= mst_3_whd_rows;
                mst_3_gw_lastrow <= (mst_3_whd_rows <= 1);
                mst_3_gw_stride <= mst_3_whd_stride;
                mst_3_gw_loc <= mst_3_whd_loc;
            end else begin
                if (mst_3_wem) begin
                    if ((mst_3_gw_loc | mst_3_gw_al)) begin
                        mst_3_gw_act <= 0;
                    end else begin
                        if (mst_3_gw_rowend) begin
                            mst_3_gw_rrem <= (mst_3_gw_rrem - 1);
                            mst_3_gw_lastrow <= (mst_3_gw_rrem == 2);
                            mst_3_gw_rs <= mst_3_gw_rsn;
                            mst_3_gw_cur <= mst_3_gw_rsn;
                            mst_3_gw_gs <= mst_3_gw_ngs;
                            mst_3_gw_rowend <= (mst_3_gw_ngs <= 256);
                            mst_3_gw_ngs <= mst_3_gw_ngn;
                            mst_3_gw_c2 <= (mst_3_gw_c2 + mst_3_gw_stride[7:0]);
                        end else begin
                            mst_3_gw_cur <= mst_3_gw_cnx;
                            mst_3_gw_gs <= mst_3_gw_gsd;
                            mst_3_gw_rowend <= (mst_3_gw_gs <= 512);
                        end
                    end
                end
            end
            mst_3_w_wt <= (mst_3_w_wt + {4'd0, em__m3});
            mst_3_w_wh <= (mst_3_w_wh + {4'd0, pl__m3});
            win_wh1_3 <= (win_wh1_3 + {4'd0, pl__m3});
            mst_3_w_wc <= ((mst_3_w_wc + {5'd0, em__m3}) - {5'd0, pl__m3});
            mst_3_w_wfq <= mst_3_w_wf_n;
            mst_3_w_wrd <= ((mst_3_w_wrd | mst_3_w_rdys) & (~slot_clr__m3));
            mst_3_w_hvq <= (pl__m3 ? mst_3_w_hn1 : mst_3_w_hn0);
            if (mst_3_w_hbyp) begin
                mst_3_w_hasl <= mst_3_slot;
                mst_3_w_hb0 <= mst_3_ga_b0;
                mst_3_w_hnb <= (mst_3_ga_loc ? 3'd1 : mst_3_ga_nbeat);
                mst_3_w_htag <= mst_3_ga_tag;
                mst_3_w_hid <= mst_3_ga_id;
                mst_3_w_hloc <= mst_3_ga_loc;
                mst_3_w_hal <= (mst_3_ga_loc | mst_3_ga_al);
            end else begin
                if (pl__m3) begin
                    mst_3_w_hasl <= mst_3_w_nasl;
                    mst_3_w_hb0 <= mst_3_w_nb0;
                    mst_3_w_hnb <= mst_3_w_nnb;
                    mst_3_w_htag <= mst_3_w_ntag;
                    mst_3_w_hid <= mst_3_w_nid;
                    mst_3_w_hloc <= mst_3_w_nloc;
                    mst_3_w_hal <= mst_3_w_nal;
                end
            end
            if (pl__m3) begin
                mst_3_w_ek <= 0;
            end else begin
                if (mst_3_pb) begin
                    mst_3_w_ek <= (mst_3_w_ek + 1);
                end
            end
            if ((em__m3 & mst_3_ga_loc)) begin
                mst_3_loc_act <= 1;
                mst_3_loc_cnt <= 5;
                mst_3_loc_slot <= mst_3_w_wt;
                mst_3_loc_off <= mst_3_ga_off;
            end else begin
                if (mst_3_loc_done) begin
                    mst_3_loc_act <= 0;
                end else begin
                    if (mst_3_loc_act) begin
                        mst_3_loc_cnt <= (mst_3_loc_cnt - 1);
                    end
                end
            end
            if (mst_3_loc_done) begin
                mst_3_loc_val <= mst_3_loc_rd;
            end
            if ((bpop__m3 & (~bpush__m3))) begin
                mst_3_bq_v0 <= mst_3_bq_v1;
                mst_3_bq_id0 <= mst_3_bq_id1;
                mst_3_bq_tag0 <= mst_3_bq_tag1;
                mst_3_bq_v1 <= 0;
            end else begin
                if ((bpush__m3 & (~bpop__m3))) begin
                    if ((~mst_3_bq_v0)) begin
                        mst_3_bq_v0 <= 1;
                        mst_3_bq_id0 <= agg_bev_wid;
                        mst_3_bq_tag0 <= agg_bev_tag;
                    end else begin
                        mst_3_bq_v1 <= 1;
                        mst_3_bq_id1 <= agg_bev_wid;
                        mst_3_bq_tag1 <= agg_bev_tag;
                    end
                end else begin
                    if ((bpush__m3 & bpop__m3)) begin
                        if (mst_3_bq_v1) begin
                            mst_3_bq_id0 <= mst_3_bq_id1;
                            mst_3_bq_tag0 <= mst_3_bq_tag1;
                            mst_3_bq_id1 <= agg_bev_wid;
                            mst_3_bq_tag1 <= agg_bev_tag;
                        end else begin
                            mst_3_bq_id0 <= agg_bev_wid;
                            mst_3_bq_tag0 <= agg_bev_tag;
                        end
                    end
                end
            end
            mst_4_ra_wp <= (mst_4_ra_wp + {2'd0, rpush__m4});
            mst_4_ra_rp <= (mst_4_ra_rp + {2'd0, rload__m4});
            mst_4_ra_cnt <= ((mst_4_ra_cnt + {3'd0, rpush__m4}) - {3'd0, rload__m4});
            mst_4_ra_fq <= mst_4_ra_f_n;
            mst_4_ra_neq <= mst_4_ra_ne_n;
            mst_4_wa_wp <= (mst_4_wa_wp + {2'd0, wpush__m4});
            mst_4_wa_rp <= (mst_4_wa_rp + {2'd0, wload__m4});
            mst_4_wa_cnt <= ((mst_4_wa_cnt + {3'd0, wpush__m4}) - {3'd0, wload__m4});
            mst_4_wa_fq <= mst_4_wa_f_n;
            mst_4_wa_neq <= mst_4_wa_ne_n;
            if (rload__m4) begin
                mst_4_ga_act <= 1;
                mst_4_ga_id <= mst_4_rhd_id;
                mst_4_ga_tag <= mst_4_rhd_tag;
                mst_4_ga_cur <= mst_4_rhd_addr;
                mst_4_ga_rs <= mst_4_rhd_addr;
                mst_4_ga_gs <= mst_4_rhd_gs;
                mst_4_ga_rowend <= (mst_4_rhd_gs <= 256);
                mst_4_ga_ngs <= mst_4_rhd_ngs;
                mst_4_ga_c2 <= mst_4_rhd_c2;
                mst_4_ga_bytes <= mst_4_rhd_bytes;
                mst_4_ga_rrem <= mst_4_rhd_rows;
                mst_4_ga_lastrow <= (mst_4_rhd_rows <= 1);
                mst_4_ga_stride <= mst_4_rhd_stride;
                mst_4_ga_loc <= mst_4_rhd_loc;
            end else begin
                if (mst_4_em) begin
                    if ((mst_4_ga_loc | mst_4_ga_al)) begin
                        mst_4_ga_act <= 0;
                    end else begin
                        if (mst_4_ga_rowend) begin
                            mst_4_ga_rrem <= (mst_4_ga_rrem - 1);
                            mst_4_ga_lastrow <= (mst_4_ga_rrem == 2);
                            mst_4_ga_rs <= mst_4_ga_rsn;
                            mst_4_ga_cur <= mst_4_ga_rsn;
                            mst_4_ga_gs <= mst_4_ga_ngs;
                            mst_4_ga_rowend <= (mst_4_ga_ngs <= 256);
                            mst_4_ga_ngs <= mst_4_ga_ngn;
                            mst_4_ga_c2 <= (mst_4_ga_c2 + mst_4_ga_stride[7:0]);
                        end else begin
                            mst_4_ga_cur <= mst_4_ga_cnx;
                            mst_4_ga_gs <= mst_4_ga_gsd;
                            mst_4_ga_rowend <= (mst_4_ga_gs <= 512);
                        end
                    end
                end
            end
            if (wload__m4) begin
                mst_4_gw_act <= 1;
                mst_4_gw_id <= mst_4_whd_id;
                mst_4_gw_tag <= mst_4_whd_tag;
                mst_4_gw_cur <= mst_4_whd_addr;
                mst_4_gw_rs <= mst_4_whd_addr;
                mst_4_gw_gs <= mst_4_whd_gs;
                mst_4_gw_rowend <= (mst_4_whd_gs <= 256);
                mst_4_gw_ngs <= mst_4_whd_ngs;
                mst_4_gw_c2 <= mst_4_whd_c2;
                mst_4_gw_bytes <= mst_4_whd_bytes;
                mst_4_gw_rrem <= mst_4_whd_rows;
                mst_4_gw_lastrow <= (mst_4_whd_rows <= 1);
                mst_4_gw_stride <= mst_4_whd_stride;
                mst_4_gw_loc <= mst_4_whd_loc;
            end else begin
                if (mst_4_wem) begin
                    if ((mst_4_gw_loc | mst_4_gw_al)) begin
                        mst_4_gw_act <= 0;
                    end else begin
                        if (mst_4_gw_rowend) begin
                            mst_4_gw_rrem <= (mst_4_gw_rrem - 1);
                            mst_4_gw_lastrow <= (mst_4_gw_rrem == 2);
                            mst_4_gw_rs <= mst_4_gw_rsn;
                            mst_4_gw_cur <= mst_4_gw_rsn;
                            mst_4_gw_gs <= mst_4_gw_ngs;
                            mst_4_gw_rowend <= (mst_4_gw_ngs <= 256);
                            mst_4_gw_ngs <= mst_4_gw_ngn;
                            mst_4_gw_c2 <= (mst_4_gw_c2 + mst_4_gw_stride[7:0]);
                        end else begin
                            mst_4_gw_cur <= mst_4_gw_cnx;
                            mst_4_gw_gs <= mst_4_gw_gsd;
                            mst_4_gw_rowend <= (mst_4_gw_gs <= 512);
                        end
                    end
                end
            end
            mst_4_w_wt <= (mst_4_w_wt + {4'd0, em__m4});
            mst_4_w_wh <= (mst_4_w_wh + {4'd0, pl__m4});
            win_wh1_4 <= (win_wh1_4 + {4'd0, pl__m4});
            mst_4_w_wc <= ((mst_4_w_wc + {5'd0, em__m4}) - {5'd0, pl__m4});
            mst_4_w_wfq <= mst_4_w_wf_n;
            mst_4_w_wrd <= ((mst_4_w_wrd | mst_4_w_rdys) & (~slot_clr__m4));
            mst_4_w_hvq <= (pl__m4 ? mst_4_w_hn1 : mst_4_w_hn0);
            if (mst_4_w_hbyp) begin
                mst_4_w_hasl <= mst_4_slot;
                mst_4_w_hb0 <= mst_4_ga_b0;
                mst_4_w_hnb <= (mst_4_ga_loc ? 3'd1 : mst_4_ga_nbeat);
                mst_4_w_htag <= mst_4_ga_tag;
                mst_4_w_hid <= mst_4_ga_id;
                mst_4_w_hloc <= mst_4_ga_loc;
                mst_4_w_hal <= (mst_4_ga_loc | mst_4_ga_al);
            end else begin
                if (pl__m4) begin
                    mst_4_w_hasl <= mst_4_w_nasl;
                    mst_4_w_hb0 <= mst_4_w_nb0;
                    mst_4_w_hnb <= mst_4_w_nnb;
                    mst_4_w_htag <= mst_4_w_ntag;
                    mst_4_w_hid <= mst_4_w_nid;
                    mst_4_w_hloc <= mst_4_w_nloc;
                    mst_4_w_hal <= mst_4_w_nal;
                end
            end
            if (pl__m4) begin
                mst_4_w_ek <= 0;
            end else begin
                if (mst_4_pb) begin
                    mst_4_w_ek <= (mst_4_w_ek + 1);
                end
            end
            if ((em__m4 & mst_4_ga_loc)) begin
                mst_4_loc_act <= 1;
                mst_4_loc_cnt <= 5;
                mst_4_loc_slot <= mst_4_w_wt;
                mst_4_loc_off <= mst_4_ga_off;
            end else begin
                if (mst_4_loc_done) begin
                    mst_4_loc_act <= 0;
                end else begin
                    if (mst_4_loc_act) begin
                        mst_4_loc_cnt <= (mst_4_loc_cnt - 1);
                    end
                end
            end
            if (mst_4_loc_done) begin
                mst_4_loc_val <= mst_4_loc_rd;
            end
            if ((bpop__m4 & (~bpush__m4))) begin
                mst_4_bq_v0 <= mst_4_bq_v1;
                mst_4_bq_id0 <= mst_4_bq_id1;
                mst_4_bq_tag0 <= mst_4_bq_tag1;
                mst_4_bq_v1 <= 0;
            end else begin
                if ((bpush__m4 & (~bpop__m4))) begin
                    if ((~mst_4_bq_v0)) begin
                        mst_4_bq_v0 <= 1;
                        mst_4_bq_id0 <= agg_bev_wid;
                        mst_4_bq_tag0 <= agg_bev_tag;
                    end else begin
                        mst_4_bq_v1 <= 1;
                        mst_4_bq_id1 <= agg_bev_wid;
                        mst_4_bq_tag1 <= agg_bev_tag;
                    end
                end else begin
                    if ((bpush__m4 & bpop__m4)) begin
                        if (mst_4_bq_v1) begin
                            mst_4_bq_id0 <= mst_4_bq_id1;
                            mst_4_bq_tag0 <= mst_4_bq_tag1;
                            mst_4_bq_id1 <= agg_bev_wid;
                            mst_4_bq_tag1 <= agg_bev_tag;
                        end else begin
                            mst_4_bq_id0 <= agg_bev_wid;
                            mst_4_bq_tag0 <= agg_bev_tag;
                        end
                    end
                end
            end
            if (goA) begin
                ra_v <= 1;
                ra_last <= (lastA & hA_al);
                ra_tag <= mst_0_w_htag;
                ra_id <= mst_0_w_hid;
                ra_loc <= hA_loc;
            end else begin
                if ((ra_v & r_0_ready)) begin
                    ra_v <= 0;
                end
            end
            if (goB) begin
                rb_v <= 1;
                rb_m <= goB_m;
                rb_last <= (lastB & hB_al);
                rb_tag <= hB_tag;
                rb_id <= hB_id;
                rb_loc <= hB_loc;
                rb_hf <= hfB;
                rb_rr <= (goB_k + 1);
            end else begin
                if ((rb_v & rb_free)) begin
                    rb_v <= 0;
                end
            end
            ed0_q <= ((goA & lastA) & (~hA_loc));
            ed0s_q <= mst_0_w_hasl;
            ed1_q <= ((goB & lastB) & (~hB_loc));
            ed1s_q <= hB_asl;
            asm_blk_q <= asm_blk_ev;
            if ((asm_blk_q & (asm_blk != 65535))) begin
                asm_blk <= (asm_blk + 1);
            end
            win_occ_q <= win_occ;
            if ((adm_wr_dram & (~bdone))) begin
                pend_write <= pw_inc;
            end else begin
                if ((bdone & (~adm_wr_dram))) begin
                    pend_write <= pw_dec;
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        if (mst_0_adm_rd) begin
            raq_id_0[mst_0_ra_wp] <= rd_0_id;
            raq_tag_0[mst_0_ra_wp] <= rd_0_tag;
            raq_addr_0[mst_0_ra_wp] <= rd_0_addr;
            raq_bytes_0[mst_0_ra_wp] <= rd_0_bytes;
            raq_rows_0[mst_0_ra_wp] <= rd_0_rows;
            raq_stride_0[mst_0_ra_wp] <= rd_0_stride;
            raq_loc_0[mst_0_ra_wp] <= rd_0_loc;
            raq_gs_0[mst_0_ra_wp] <= ({1'd0, rd_0_bytes} + {13'd0, rd_0_addr[7:0]});
            raq_c1_0[mst_0_ra_wp] <= (rd_0_addr[7:0] + rd_0_stride[7:0]);
            raq_c2_0[mst_0_ra_wp] <= (rd_0_addr[7:0] + {rd_0_stride[6:0], 1'd0});
        end
        if (mst_0_adm_wr) begin
            waq_id_0[mst_0_wa_wp] <= wr_0_id;
            waq_tag_0[mst_0_wa_wp] <= wr_0_tag;
            waq_addr_0[mst_0_wa_wp] <= wr_0_addr;
            waq_bytes_0[mst_0_wa_wp] <= wr_0_bytes;
            waq_rows_0[mst_0_wa_wp] <= wr_0_rows;
            waq_stride_0[mst_0_wa_wp] <= wr_0_stride;
            waq_loc_0[mst_0_wa_wp] <= wr_0_loc;
            waq_gs_0[mst_0_wa_wp] <= ({1'd0, wr_0_bytes} + {13'd0, wr_0_addr[7:0]});
            waq_c1_0[mst_0_wa_wp] <= (wr_0_addr[7:0] + wr_0_stride[7:0]);
            waq_c2_0[mst_0_wa_wp] <= (wr_0_addr[7:0] + {wr_0_stride[6:0], 1'd0});
        end
        if (mst_1_adm_rd) begin
            raq_id_1[mst_1_ra_wp] <= rd_1_id;
            raq_tag_1[mst_1_ra_wp] <= rd_1_tag;
            raq_addr_1[mst_1_ra_wp] <= rd_1_addr;
            raq_bytes_1[mst_1_ra_wp] <= rd_1_bytes;
            raq_rows_1[mst_1_ra_wp] <= rd_1_rows;
            raq_stride_1[mst_1_ra_wp] <= rd_1_stride;
            raq_loc_1[mst_1_ra_wp] <= rd_1_loc;
            raq_gs_1[mst_1_ra_wp] <= ({1'd0, rd_1_bytes} + {13'd0, rd_1_addr[7:0]});
            raq_c1_1[mst_1_ra_wp] <= (rd_1_addr[7:0] + rd_1_stride[7:0]);
            raq_c2_1[mst_1_ra_wp] <= (rd_1_addr[7:0] + {rd_1_stride[6:0], 1'd0});
        end
        if (mst_1_adm_wr) begin
            waq_id_1[mst_1_wa_wp] <= wr_1_id;
            waq_tag_1[mst_1_wa_wp] <= wr_1_tag;
            waq_addr_1[mst_1_wa_wp] <= wr_1_addr;
            waq_bytes_1[mst_1_wa_wp] <= wr_1_bytes;
            waq_rows_1[mst_1_wa_wp] <= wr_1_rows;
            waq_stride_1[mst_1_wa_wp] <= wr_1_stride;
            waq_loc_1[mst_1_wa_wp] <= wr_1_loc;
            waq_gs_1[mst_1_wa_wp] <= ({1'd0, wr_1_bytes} + {13'd0, wr_1_addr[7:0]});
            waq_c1_1[mst_1_wa_wp] <= (wr_1_addr[7:0] + wr_1_stride[7:0]);
            waq_c2_1[mst_1_wa_wp] <= (wr_1_addr[7:0] + {wr_1_stride[6:0], 1'd0});
        end
        if (mst_2_adm_rd) begin
            raq_id_2[mst_2_ra_wp] <= rd_2_id;
            raq_tag_2[mst_2_ra_wp] <= rd_2_tag;
            raq_addr_2[mst_2_ra_wp] <= rd_2_addr;
            raq_bytes_2[mst_2_ra_wp] <= rd_2_bytes;
            raq_rows_2[mst_2_ra_wp] <= rd_2_rows;
            raq_stride_2[mst_2_ra_wp] <= rd_2_stride;
            raq_loc_2[mst_2_ra_wp] <= rd_2_loc;
            raq_gs_2[mst_2_ra_wp] <= ({1'd0, rd_2_bytes} + {13'd0, rd_2_addr[7:0]});
            raq_c1_2[mst_2_ra_wp] <= (rd_2_addr[7:0] + rd_2_stride[7:0]);
            raq_c2_2[mst_2_ra_wp] <= (rd_2_addr[7:0] + {rd_2_stride[6:0], 1'd0});
        end
        if (mst_2_adm_wr) begin
            waq_id_2[mst_2_wa_wp] <= wr_2_id;
            waq_tag_2[mst_2_wa_wp] <= wr_2_tag;
            waq_addr_2[mst_2_wa_wp] <= wr_2_addr;
            waq_bytes_2[mst_2_wa_wp] <= wr_2_bytes;
            waq_rows_2[mst_2_wa_wp] <= wr_2_rows;
            waq_stride_2[mst_2_wa_wp] <= wr_2_stride;
            waq_loc_2[mst_2_wa_wp] <= wr_2_loc;
            waq_gs_2[mst_2_wa_wp] <= ({1'd0, wr_2_bytes} + {13'd0, wr_2_addr[7:0]});
            waq_c1_2[mst_2_wa_wp] <= (wr_2_addr[7:0] + wr_2_stride[7:0]);
            waq_c2_2[mst_2_wa_wp] <= (wr_2_addr[7:0] + {wr_2_stride[6:0], 1'd0});
        end
        if (mst_3_adm_rd) begin
            raq_id_3[mst_3_ra_wp] <= rd_3_id;
            raq_tag_3[mst_3_ra_wp] <= rd_3_tag;
            raq_addr_3[mst_3_ra_wp] <= rd_3_addr;
            raq_bytes_3[mst_3_ra_wp] <= rd_3_bytes;
            raq_rows_3[mst_3_ra_wp] <= rd_3_rows;
            raq_stride_3[mst_3_ra_wp] <= rd_3_stride;
            raq_loc_3[mst_3_ra_wp] <= rd_3_loc;
            raq_gs_3[mst_3_ra_wp] <= ({1'd0, rd_3_bytes} + {13'd0, rd_3_addr[7:0]});
            raq_c1_3[mst_3_ra_wp] <= (rd_3_addr[7:0] + rd_3_stride[7:0]);
            raq_c2_3[mst_3_ra_wp] <= (rd_3_addr[7:0] + {rd_3_stride[6:0], 1'd0});
        end
        if (mst_3_adm_wr) begin
            waq_id_3[mst_3_wa_wp] <= wr_3_id;
            waq_tag_3[mst_3_wa_wp] <= wr_3_tag;
            waq_addr_3[mst_3_wa_wp] <= wr_3_addr;
            waq_bytes_3[mst_3_wa_wp] <= wr_3_bytes;
            waq_rows_3[mst_3_wa_wp] <= wr_3_rows;
            waq_stride_3[mst_3_wa_wp] <= wr_3_stride;
            waq_loc_3[mst_3_wa_wp] <= wr_3_loc;
            waq_gs_3[mst_3_wa_wp] <= ({1'd0, wr_3_bytes} + {13'd0, wr_3_addr[7:0]});
            waq_c1_3[mst_3_wa_wp] <= (wr_3_addr[7:0] + wr_3_stride[7:0]);
            waq_c2_3[mst_3_wa_wp] <= (wr_3_addr[7:0] + {wr_3_stride[6:0], 1'd0});
        end
        if (mst_4_adm_rd) begin
            raq_id_4[mst_4_ra_wp] <= rd_4_id;
            raq_tag_4[mst_4_ra_wp] <= rd_4_tag;
            raq_addr_4[mst_4_ra_wp] <= rd_4_addr;
            raq_bytes_4[mst_4_ra_wp] <= rd_4_bytes;
            raq_rows_4[mst_4_ra_wp] <= rd_4_rows;
            raq_stride_4[mst_4_ra_wp] <= rd_4_stride;
            raq_loc_4[mst_4_ra_wp] <= rd_4_loc;
            raq_gs_4[mst_4_ra_wp] <= ({1'd0, rd_4_bytes} + {13'd0, rd_4_addr[7:0]});
            raq_c1_4[mst_4_ra_wp] <= (rd_4_addr[7:0] + rd_4_stride[7:0]);
            raq_c2_4[mst_4_ra_wp] <= (rd_4_addr[7:0] + {rd_4_stride[6:0], 1'd0});
        end
        if (mst_4_adm_wr) begin
            waq_id_4[mst_4_wa_wp] <= wr_4_id;
            waq_tag_4[mst_4_wa_wp] <= wr_4_tag;
            waq_addr_4[mst_4_wa_wp] <= wr_4_addr;
            waq_bytes_4[mst_4_wa_wp] <= wr_4_bytes;
            waq_rows_4[mst_4_wa_wp] <= wr_4_rows;
            waq_stride_4[mst_4_wa_wp] <= wr_4_stride;
            waq_loc_4[mst_4_wa_wp] <= wr_4_loc;
            waq_gs_4[mst_4_wa_wp] <= ({1'd0, wr_4_bytes} + {13'd0, wr_4_addr[7:0]});
            waq_c1_4[mst_4_wa_wp] <= (wr_4_addr[7:0] + wr_4_stride[7:0]);
            waq_c2_4[mst_4_wa_wp] <= (wr_4_addr[7:0] + {wr_4_stride[6:0], 1'd0});
        end
        if (em__m0) begin
            wp_asl_0[mst_0_w_wt] <= mst_0_slot;
            wp_b0_0[mst_0_w_wt] <= mst_0_ga_b0;
            wp_nb_0[mst_0_w_wt] <= (mst_0_ga_loc ? 3'd1 : mst_0_ga_nbeat);
            wp_tag_0[mst_0_w_wt] <= mst_0_ga_tag;
            wp_id_0[mst_0_w_wt] <= mst_0_ga_id;
            wp_loc_0[mst_0_w_wt] <= mst_0_ga_loc;
            wp_al_0[mst_0_w_wt] <= (mst_0_ga_loc | mst_0_ga_al);
        end
        if (em__m1) begin
            wp_asl_1[mst_1_w_wt] <= mst_1_slot;
            wp_b0_1[mst_1_w_wt] <= mst_1_ga_b0;
            wp_nb_1[mst_1_w_wt] <= (mst_1_ga_loc ? 3'd1 : mst_1_ga_nbeat);
            wp_tag_1[mst_1_w_wt] <= mst_1_ga_tag;
            wp_id_1[mst_1_w_wt] <= mst_1_ga_id;
            wp_loc_1[mst_1_w_wt] <= mst_1_ga_loc;
            wp_al_1[mst_1_w_wt] <= (mst_1_ga_loc | mst_1_ga_al);
        end
        if (em__m2) begin
            wp_asl_2[mst_2_w_wt] <= mst_2_slot;
            wp_b0_2[mst_2_w_wt] <= mst_2_ga_b0;
            wp_nb_2[mst_2_w_wt] <= (mst_2_ga_loc ? 3'd1 : mst_2_ga_nbeat);
            wp_tag_2[mst_2_w_wt] <= mst_2_ga_tag;
            wp_id_2[mst_2_w_wt] <= mst_2_ga_id;
            wp_loc_2[mst_2_w_wt] <= mst_2_ga_loc;
            wp_al_2[mst_2_w_wt] <= (mst_2_ga_loc | mst_2_ga_al);
        end
        if (em__m3) begin
            wp_asl_3[mst_3_w_wt] <= mst_3_slot;
            wp_b0_3[mst_3_w_wt] <= mst_3_ga_b0;
            wp_nb_3[mst_3_w_wt] <= (mst_3_ga_loc ? 3'd1 : mst_3_ga_nbeat);
            wp_tag_3[mst_3_w_wt] <= mst_3_ga_tag;
            wp_id_3[mst_3_w_wt] <= mst_3_ga_id;
            wp_loc_3[mst_3_w_wt] <= mst_3_ga_loc;
            wp_al_3[mst_3_w_wt] <= (mst_3_ga_loc | mst_3_ga_al);
        end
        if (em__m4) begin
            wp_asl_4[mst_4_w_wt] <= mst_4_slot;
            wp_b0_4[mst_4_w_wt] <= mst_4_ga_b0;
            wp_nb_4[mst_4_w_wt] <= (mst_4_ga_loc ? 3'd1 : mst_4_ga_nbeat);
            wp_tag_4[mst_4_w_wt] <= mst_4_ga_tag;
            wp_id_4[mst_4_w_wt] <= mst_4_ga_id;
            wp_loc_4[mst_4_w_wt] <= mst_4_ga_loc;
            wp_al_4[mst_4_w_wt] <= (mst_4_ga_loc | mst_4_ga_al);
        end
        if (goA) begin
            ra_lval <= mst_0_loc_val;
        end
        if (goB) begin
            rb_lval <= hB_lval;
        end
    end
endmodule
