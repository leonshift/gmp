module Mac2D #(
    parameter ADDR_W = 48,
    parameter BEAT_W = 512,
    parameter L1_BASE = 8388608
) (
    input clk,
    input rst_n,
    input issue_valid,
    output logic issue_ready,
    input [127:0] issue_instr,
    input issue_is_launch,
    input [31:0] issue_launch_id,
    input [23:0] issue_launch_off,
    input [15:0] issue_launch_len,
    input [23:0] issue_prog_idx,
    input isram_wen,
    input [11:0] isram_waddr,
    input [31:0] isram_wdata,
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
    localparam S_IDLE = 0;
    localparam S_A_ADM = 2;
    localparam S_B_ADM = 8;
    localparam S_ST_WAIT = 14;
    localparam S_ST_RUN = 17;
    localparam S_SC_WAIT = 23;
    localparam S_SC_AR = 26;
    localparam S_SC_RD = 27;
    localparam S_SC_EXT = 28;
    localparam S_CL_WAIT = 32;
    localparam S_NOP = 33;
    localparam S_A_SET = 34;
    localparam S_B_SET = 35;
    localparam S_DEC = 36;
    logic [127:0] cq_i [0:3];
    logic [23:0] cq_p [0:3];
    logic [2:0] cq_wp;
    logic [2:0] cq_rp;
    logic [31:0] lq_id [0:3];
    logic [23:0] lq_off [0:3];
    logic [15:0] lq_len [0:3];
    logic [2:0] lq_wp;
    logic [2:0] lq_rp;
    logic [2:0] lq_n;
    logic [31:0] im0 [0:1023];
    logic [31:0] im1 [0:1023];
    logic [31:0] im2 [0:1023];
    logic [31:0] im3 [0:1023];
    logic [127:0] rd_q;
    logic [15:0] sdq;
    logic ld_v;
    logic [31:0] ld_id;
    logic [23:0] ld_off;
    logic [15:0] ld_len;
    logic [23:0] kprog;
    logic [127:0] dq_ins [0:15];
    logic [31:0] dq_av [0:15];
    logic [31:0] dq_bv [0:15];
    logic [23:0] dq_prog [0:15];
    logic dq_mma_0;
    logic dq_mma_1;
    logic dq_mma_2;
    logic dq_mma_3;
    logic dq_mma_4;
    logic dq_mma_5;
    logic dq_mma_6;
    logic dq_mma_7;
    logic dq_mma_8;
    logic dq_mma_9;
    logic dq_mma_10;
    logic dq_mma_11;
    logic dq_mma_12;
    logic dq_mma_13;
    logic dq_mma_14;
    logic dq_mma_15;
    logic dq_pf_c_0;
    logic dq_pf_c_1;
    logic dq_pf_c_2;
    logic dq_pf_c_3;
    logic dq_pf_c_4;
    logic dq_pf_c_5;
    logic dq_pf_c_6;
    logic dq_pf_c_7;
    logic dq_pf_c_8;
    logic dq_pf_c_9;
    logic dq_pf_c_10;
    logic dq_pf_c_11;
    logic dq_pf_c_12;
    logic dq_pf_c_13;
    logic dq_pf_c_14;
    logic dq_pf_c_15;
    logic [15:0] dq_pf;
    logic dq_npf [0:15];
    logic [4:0] dq_wp;
    logic [4:0] dq_rp;
    logic [4:0] dq_nq;
    logic dq_eq;
    logic ift_v_c_0;
    logic ift_v_c_1;
    logic ift_v_c_2;
    logic ift_v_c_3;
    logic ift_fin_c_0;
    logic ift_fin_c_1;
    logic ift_fin_c_2;
    logic ift_fin_c_3;
    logic [1:0] ift_nd_0;
    logic [1:0] ift_nd_1;
    logic [1:0] ift_nd_2;
    logic [1:0] ift_nd_3;
    logic [3:0] ift_v;
    logic [3:0] ift_fin;
    logic [2:0] cred_l1;
    logic [2:0] cred_llc;
    logic [127:0] cur;
    logic [23:0] cur_prog;
    logic [1:0] cur_slot;
    logic cur_kern;
    logic cur_pf;
    logic [31:0] cur_avar;
    logic [31:0] cur_bvar;
    logic [5:0] state;
    logic [5:0] st_nx;
    logic sc_rd_q;
    logic lda_start;
    logic ldb_start;
    logic pf_v;
    logic [1:0] pf_bset;
    logic [2:0] pf_seq;
    logic [1:0] pf_slot;
    logic ldb_start_p;
    logic [47:0] pf_base;
    logic [31:0] pf_strd;
    logic [8:0] pf_rowb;
    logic [7:0] pf_nrows;
    logic [7:0] pf_cfg;
    logic [7:0] pf_klim;
    logic pf_q8;
    logic pf_kmj;
    logic pf_strm;
    logic [2:0] lda_seq;
    logic [2:0] ldb_seq;
    logic arb_rr;
    logic [511:0] sc_beat;
    logic [1:0] lbeat;
    logic [1:0] lnbeat;
    logic [1:0] aset_cur;
    logic [1:0] bset_cur;
    logic [1:0] aset_new;
    logic [1:0] bset_new;
    logic jd_act;
    logic [5:0] jd_acc;
    logic [6:0] jd_M;
    logic [7:0] jd_N;
    logic [3:0] jd_ncol;
    logic [2:0] jd_nrow;
    logic jd_kmj;
    logic jd_accum;
    logic [1:0] jd_aset;
    logic [1:0] jd_bset;
    logic [1:0] jd_tag;
    logic [7:0] jd_rows;
    logic jd_arl;
    logic av_tab_0;
    logic av_tab_1;
    logic av_tab_2;
    logic av_tab_3;
    logic [2:0] aseq_tab [0:3];
    logic jd_av;
    logic [2:0] jd_bseq;
    logic [7:0] jd_btot;
    logic [7:0] jd_bavail;
    logic jp_v;
    logic [5:0] jp_acc;
    logic [6:0] jp_M;
    logic [7:0] jp_N;
    logic [3:0] jp_ncol;
    logic [2:0] jp_nrow;
    logic jp_kmj;
    logic jp_accum;
    logic [1:0] jp_aset;
    logic [1:0] jp_bset;
    logic [1:0] jp_tag;
    logic jp_arl;
    logic [2:0] jp_bseq;
    logic [7:0] jp_btot;
    logic [1:0] jmi;
    logic [2:0] jni;
    logic [2:0] jdd;
    logic jleg;
    logic job_v;
    logic [27:0] job_w;
    logic [63:0] accm_0 [0:255];
    logic [63:0] accm_1 [0:255];
    logic [63:0] accm_2 [0:255];
    logic [63:0] accm_3 [0:255];
    logic [63:0] accm_4 [0:255];
    logic [63:0] accm_5 [0:255];
    logic [63:0] accm_6 [0:255];
    logic [63:0] accm_7 [0:255];
    logic [63:0] accm_8 [0:255];
    logic [63:0] accm_9 [0:255];
    logic [63:0] accm_10 [0:255];
    logic [63:0] accm_11 [0:255];
    logic [63:0] accm_12 [0:255];
    logic [63:0] accm_13 [0:255];
    logic [63:0] accm_14 [0:255];
    logic [63:0] accm_15 [0:255];
    logic [1023:0] accq;
    logic zf_c_0;
    logic zf_c_1;
    logic zf_c_2;
    logic zf_c_3;
    logic zf_c_4;
    logic zf_c_5;
    logic zf_c_6;
    logic zf_c_7;
    logic zf_c_8;
    logic zf_c_9;
    logic zf_c_10;
    logic zf_c_11;
    logic zf_c_12;
    logic zf_c_13;
    logic zf_c_14;
    logic zf_c_15;
    logic zf_c_16;
    logic zf_c_17;
    logic zf_c_18;
    logic zf_c_19;
    logic zf_c_20;
    logic zf_c_21;
    logic zf_c_22;
    logic zf_c_23;
    logic zf_c_24;
    logic zf_c_25;
    logic zf_c_26;
    logic zf_c_27;
    logic zf_c_28;
    logic zf_c_29;
    logic zf_c_30;
    logic zf_c_31;
    logic [31:0] zf;
    logic badacc;
    logic jv_d1;
    logic jv_d2;
    logic pl_zero_q;
    logic st_act;
    logic [1:0] sr_st;
    logic sr_e;
    logic [5:0] sr_rpf;
    logic [2:0] st_ti;
    logic [63:0] rbm_0 [0:7];
    logic [63:0] rbm_1 [0:7];
    logic [63:0] rbm_2 [0:7];
    logic [63:0] rbm_3 [0:7];
    logic [63:0] rbm_4 [0:7];
    logic [63:0] rbm_5 [0:7];
    logic [63:0] rbm_6 [0:7];
    logic [63:0] rbm_7 [0:7];
    logic [63:0] rbm_8 [0:7];
    logic [63:0] rbm_9 [0:7];
    logic [63:0] rbm_10 [0:7];
    logic [63:0] rbm_11 [0:7];
    logic [63:0] rbm_12 [0:7];
    logic [63:0] rbm_13 [0:7];
    logic [63:0] rbm_14 [0:7];
    logic [63:0] rbm_15 [0:7];
    logic [63:0] rbm_16 [0:7];
    logic [63:0] rbm_17 [0:7];
    logic [63:0] rbm_18 [0:7];
    logic [63:0] rbm_19 [0:7];
    logic [63:0] rbm_20 [0:7];
    logic [63:0] rbm_21 [0:7];
    logic [63:0] rbm_22 [0:7];
    logic [63:0] rbm_23 [0:7];
    logic [63:0] rbm_24 [0:7];
    logic [63:0] rbm_25 [0:7];
    logic [63:0] rbm_26 [0:7];
    logic [63:0] rbm_27 [0:7];
    logic [63:0] rbm_28 [0:7];
    logic [63:0] rbm_29 [0:7];
    logic [63:0] rbm_30 [0:7];
    logic [63:0] rbm_31 [0:7];
    logic rb_v0;
    logic rb_v1;
    logic wr_e;
    logic [5:0] st_rpf;
    logic st_j;
    logic [47:0] st_addr;
    logic aw_sel_done;
    logic aw_pend;
    logic [47:0] aw_addr_q;
    logic [6:0] aw_cnt;
    logic w_act;
    logic [3:0] st_beat;
    logic ws_e;
    logic ws_j;
    logic [3:0] st_nbeat;
    logic [6:0] st_bcnt;
    logic [511:0] sreg;
    logic [3:0] sc_i;
    logic [2:0] sc_ra;
    logic sc_v1;
    logic [2:0] sc_r1;
    logic sc_v2;
    logic [2:0] sc_r2;
    logic sc_v3;
    logic [2:0] sc_r3;
    logic sc_v4;
    logic [2:0] sc_r4;
    logic [1023:0] sc_res_q;
    logic sc_redo_0;
    logic sc_redo_1;
    logic sc_redo_2;
    logic sc_redo_3;
    logic sc_redo_4;
    logic sc_redo_5;
    logic sc_redo_6;
    logic sc_redo_7;
    logic sc_act;
    logic [5:0] sc_acc;
    logic [1:0] sc_islot;
    logic [15:0] nopc;
    logic busy_r;
    logic [15:0] donec;
    logic retire_p;
    logic flush_q;
    logic [4:0] op;
    logic is_mma;
    logic is_aclr;
    logic is_ast;
    logic is_asc;
    logic [5:0] f_acc_c;
    logic [5:0] f_acc;
    logic f_accum;
    logic [7:0] f_apipe;
    logic [21:0] f_aoff;
    logic [6:0] f_M;
    logic [6:0] f_K;
    logic [7:0] f_bpipe;
    logic [21:0] f_boff;
    logic [7:0] f_N;
    logic [2:0] f_bdt;
    logic [12:0] f_ald;
    logic [8:0] f_bld;
    logic f_btr;
    logic f_arl;
    logic [1:0] f_dmem;
    logic [7:0] f_dpipe;
    logic [27:0] f_doff;
    logic [6:0] f_rows;
    logic [11:0] f_bpr;
    logic [19:0] f_dstr;
    logic [2:0] f_dt;
    logic is_q8_c;
    logic is_q8;
    logic kmj_c;
    logic kmj;
    logic [8:0] N16;
    logic [3:0] nCol_c;
    logic [3:0] nCol;
    logic [7:0] M16;
    logic [2:0] nRow_c;
    logic [2:0] nRow;
    logic [5:0] ntile_c;
    logic [5:0] ntile;
    logic [5:0] job_slot;
    logic [6:0] mrem;
    logic [4:0] job_mrows;
    logic [5:0] mr3;
    logic [2:0] job_nblk;
    logic [2:0] jd_nrow_m1;
    logic [3:0] jd_ncol_m1;
    logic [1:0] jd_rmax;
    logic [2:0] jd_cmax;
    logic [2:0] jd_dmax;
    logic [2:0] jdd1;
    logic [2:0] jdm1;
    logic [2:0] jl0_end;
    logic [1:0] jl1_end;
    logic jhas_l1;
    logic jleg_last;
    logic jgo_l1;
    logic jnx_sh;
    logic jnx_l0;
    logic job_last;
    logic [2:0] jmi1;
    logic [7:0] jd_need;
    logic [3:0] jni1;
    logic [7:0] jd_bneed_n;
    logic [7:0] jd_bneed;
    logic jd_go;
    logic jd_oth;
    logic jp_oth;
    logic aclm_0;
    logic aclm_1;
    logic aclm_2;
    logic aclm_3;
    logic bclm_0;
    logic bclm_1;
    logic bclm_2;
    logic bclm_3;
    logic [3:0] aset_busy;
    logic [3:0] bset_busy;
    logic [1:0] aset_nx;
    logic aset_nx_free;
    logic [7:0] st_cols;
    logic [8:0] stC16;
    logic [3:0] st_nCol_c;
    logic [3:0] st_nCol;
    logic d_l3_c;
    logic d_l3;
    logic [7:0] a_cid;
    logic [7:0] b_cid;
    logic [7:0] a_cfg_c;
    logic [7:0] a_cfg;
    logic [7:0] b_cfg_c;
    logic [7:0] b_cfg;
    logic [7:0] d_cfg_c;
    logic [7:0] d_cfg;
    logic [27:0] a_vb;
    logic [27:0] b_vb;
    logic [47:0] a_base_c;
    logic [47:0] a_base;
    logic [47:0] b_base_c;
    logic [47:0] b_base;
    logic [47:0] d_base_c;
    logic [47:0] d_base;
    logic [7:0] K16;
    logic [8:0] a_rowb_c;
    logic [8:0] a_rowb;
    logic [31:0] a_strd_c;
    logic [31:0] a_strd;
    logic [8:0] b_rowb_c;
    logic [8:0] b_rowb;
    logic [9:0] q8_bld;
    logic [31:0] b_strd_c;
    logic [31:0] b_strd;
    logic [7:0] b_rows_c;
    logic [7:0] b_rows;
    logic b_tight;
    logic b_strm_c;
    logic b_strm;
    logic [3:0] dq_ri;
    logic [3:0] dq_wi;
    logic [15:0] pf_cand;
    logic [15:0] pf_hi;
    logic pf_any;
    logic [3:0] pf_idx;
    logic [3:0] pf_idx_q;
    logic pf_any_q;
    logic pq_v;
    logic [3:0] pq_idx;
    logic [127:0] pq_ins;
    logic [31:0] pq_bv;
    logic pq_ok;
    logic [6:0] n_K;
    logic [21:0] n_boff;
    logic [7:0] n_N;
    logic [2:0] n_bdt;
    logic [8:0] n_bld;
    logic n_btr;
    logic n_q8;
    logic n_kmj;
    logic [31:0] n_bvar;
    logic [7:0] n_bcid;
    logic [47:0] n_bbase;
    logic [7:0] n_K16;
    logic [8:0] n_browb;
    logic [9:0] n_q8bld;
    logic [31:0] n_bstrd;
    logic [7:0] n_brows;
    logic [7:0] n_bklim;
    logic n_btight;
    logic n_bstrm;
    logic [1:0] pf_nset;
    logic pf_set_free;
    logic pf_can;
    logic [7:0] b_klim_c;
    logic [7:0] b_klim;
    logic lda_busy;
    logic ldb_busy;
    logic lda_fxfree;
    logic ldb_fxfree;
    logic [7:0] lda_rows;
    logic [7:0] lda_rows1;
    logic [7:0] ldb_rows;
    logic [7:0] ldb_rows1;
    logic [2:0] lda_tag;
    logic [2:0] lda_tag1;
    logic [2:0] ldb_tag;
    logic [2:0] ldb_tag1;
    logic [27:0] job_c;
    logic arr_job_ready;
    logic arr_busy;
    logic arr_held;
    logic [5:0] arr_held_slot;
    logic [3:0] arr_ause;
    logic [3:0] arr_buse;
    logic dr_valid;
    logic [5:0] dr_slot;
    logic [2:0] dr_rp;
    logic dr_last;
    logic [1023:0] dr_data;
    logic [5:0] pl_slot_c;
    logic [2:0] pl_i;
    logic pl_rd;
    logic st_rd_p;
    logic st_rd;
    logic [7:0] sc_redo_v;
    logic sc_redo_any;
    logic [2:0] sc_redo_i;
    logic sc_pipe_empty;
    logic [2:0] sc_nxt;
    logic sc_can;
    logic acc_rd_ok;
    logic sc_rd_ok;
    logic [5:0] st_slot_g;
    logic [5:0] st_ra_slot;
    logic [7:0] acc_ra;
    logic [6:0] rows_p1;
    logic [5:0] st_nrp_c;
    logic [5:0] st_nrp;
    logic sr_free;
    logic sr_next_free;
    logic wr_ready;
    logic sr_last_ti;
    logic [31:0] sc_s0_g_0;
    logic [31:0] sc_s0_g_1;
    logic [31:0] sc_s0_g_2;
    logic [31:0] sc_s0_g_3;
    logic [31:0] sc_s1_g_0;
    logic [31:0] sc_s1_g_1;
    logic [31:0] sc_s1_g_2;
    logic [31:0] sc_s1_g_3;
    logic [31:0] sc_s0_n;
    logic [31:0] sc_s1_n;
    logic zf_cur;
    logic zf_pl;
    logic [1023:0] accq_z;
    logic [1023:0] sc_res;
    logic acc_we_c_0;
    logic acc_we_c_1;
    logic acc_we_c_2;
    logic acc_we_c_3;
    logic acc_we_c_4;
    logic acc_we_c_5;
    logic acc_we_c_6;
    logic acc_we_c_7;
    logic acc_we_c_8;
    logic acc_we_c_9;
    logic acc_we_c_10;
    logic acc_we_c_11;
    logic acc_we_c_12;
    logic acc_we_c_13;
    logic acc_we_c_14;
    logic acc_we_c_15;
    logic [7:0] acc_wa_c_0;
    logic [7:0] acc_wa_c_1;
    logic [7:0] acc_wa_c_2;
    logic [7:0] acc_wa_c_3;
    logic [7:0] acc_wa_c_4;
    logic [7:0] acc_wa_c_5;
    logic [7:0] acc_wa_c_6;
    logic [7:0] acc_wa_c_7;
    logic [7:0] acc_wa_c_8;
    logic [7:0] acc_wa_c_9;
    logic [7:0] acc_wa_c_10;
    logic [7:0] acc_wa_c_11;
    logic [7:0] acc_wa_c_12;
    logic [7:0] acc_wa_c_13;
    logic [7:0] acc_wa_c_14;
    logic [7:0] acc_wa_c_15;
    logic [63:0] acc_wd_c_0;
    logic [63:0] acc_wd_c_1;
    logic [63:0] acc_wd_c_2;
    logic [63:0] acc_wd_c_3;
    logic [63:0] acc_wd_c_4;
    logic [63:0] acc_wd_c_5;
    logic [63:0] acc_wd_c_6;
    logic [63:0] acc_wd_c_7;
    logic [63:0] acc_wd_c_8;
    logic [63:0] acc_wd_c_9;
    logic [63:0] acc_wd_c_10;
    logic [63:0] acc_wd_c_11;
    logic [63:0] acc_wd_c_12;
    logic [63:0] acc_wd_c_13;
    logic [63:0] acc_wd_c_14;
    logic [63:0] acc_wd_c_15;
    logic ra_fill;
    logic ra_zq;
    logic rbq_fill_n;
    logic [2:0] rbq_ti_n;
    logic [2:0] rbq_wa_n;
    logic rbq_we_n_0;
    logic rbq_we_n_1;
    logic rbq_we_0;
    logic rbq_we_1;
    logic rbq_we_2;
    logic rbq_we_3;
    logic rbq_we_4;
    logic rbq_we_5;
    logic rbq_we_6;
    logic rbq_we_7;
    logic rbq_we_8;
    logic rbq_we_9;
    logic rbq_we_10;
    logic rbq_we_11;
    logic rbq_we_12;
    logic rbq_we_13;
    logic rbq_we_14;
    logic rbq_we_15;
    logic rbq_we_16;
    logic rbq_we_17;
    logic rbq_we_18;
    logic rbq_we_19;
    logic rbq_we_20;
    logic rbq_we_21;
    logic rbq_we_22;
    logic rbq_we_23;
    logic rbq_we_24;
    logic rbq_we_25;
    logic rbq_we_26;
    logic rbq_we_27;
    logic rbq_we_28;
    logic rbq_we_29;
    logic rbq_we_30;
    logic rbq_we_31;
    logic [2:0] rbq_wa_0;
    logic [2:0] rbq_wa_1;
    logic [2:0] rbq_wa_2;
    logic [2:0] rbq_wa_3;
    logic [2:0] rbq_wa_4;
    logic [2:0] rbq_wa_5;
    logic [2:0] rbq_wa_6;
    logic [2:0] rbq_wa_7;
    logic [2:0] rbq_wa_8;
    logic [2:0] rbq_wa_9;
    logic [2:0] rbq_wa_10;
    logic [2:0] rbq_wa_11;
    logic [2:0] rbq_wa_12;
    logic [2:0] rbq_wa_13;
    logic [2:0] rbq_wa_14;
    logic [2:0] rbq_wa_15;
    logic [2:0] rbq_wa_16;
    logic [2:0] rbq_wa_17;
    logic [2:0] rbq_wa_18;
    logic [2:0] rbq_wa_19;
    logic [2:0] rbq_wa_20;
    logic [2:0] rbq_wa_21;
    logic [2:0] rbq_wa_22;
    logic [2:0] rbq_wa_23;
    logic [2:0] rbq_wa_24;
    logic [2:0] rbq_wa_25;
    logic [2:0] rbq_wa_26;
    logic [2:0] rbq_wa_27;
    logic [2:0] rbq_wa_28;
    logic [2:0] rbq_wa_29;
    logic [2:0] rbq_wa_30;
    logic [2:0] rbq_wa_31;
    logic rbq_z_0;
    logic rbq_z_1;
    logic rbq_z_2;
    logic rbq_z_3;
    logic rbq_z_4;
    logic rbq_z_5;
    logic rbq_z_6;
    logic rbq_z_7;
    logic rbq_z_8;
    logic rbq_z_9;
    logic rbq_z_10;
    logic rbq_z_11;
    logic rbq_z_12;
    logic rbq_z_13;
    logic rbq_z_14;
    logic rbq_z_15;
    logic rbq_z_16;
    logic rbq_z_17;
    logic rbq_z_18;
    logic rbq_z_19;
    logic rbq_z_20;
    logic rbq_z_21;
    logic rbq_z_22;
    logic rbq_z_23;
    logic rbq_z_24;
    logic rbq_z_25;
    logic rbq_z_26;
    logic rbq_z_27;
    logic rbq_z_28;
    logic rbq_z_29;
    logic rbq_z_30;
    logic rbq_z_31;
    logic rbz_0 [0:7];
    logic rbz_1 [0:7];
    logic rbz_2 [0:7];
    logic rbz_3 [0:7];
    logic rbz_4 [0:7];
    logic rbz_5 [0:7];
    logic rbz_6 [0:7];
    logic rbz_7 [0:7];
    logic rbz_8 [0:7];
    logic rbz_9 [0:7];
    logic rbz_10 [0:7];
    logic rbz_11 [0:7];
    logic rbz_12 [0:7];
    logic rbz_13 [0:7];
    logic rbz_14 [0:7];
    logic rbz_15 [0:7];
    logic rbz_16 [0:7];
    logic rbz_17 [0:7];
    logic rbz_18 [0:7];
    logic rbz_19 [0:7];
    logic rbz_20 [0:7];
    logic rbz_21 [0:7];
    logic rbz_22 [0:7];
    logic rbz_23 [0:7];
    logic rbz_24 [0:7];
    logic rbz_25 [0:7];
    logic rbz_26 [0:7];
    logic rbz_27 [0:7];
    logic rbz_28 [0:7];
    logic rbz_29 [0:7];
    logic rbz_30 [0:7];
    logic rbz_31 [0:7];
    logic [63:0] rbk_d_0;
    logic [63:0] rbk_d_1;
    logic [63:0] rbk_d_2;
    logic [63:0] rbk_d_3;
    logic [63:0] rbk_d_4;
    logic [63:0] rbk_d_5;
    logic [63:0] rbk_d_6;
    logic [63:0] rbk_d_7;
    logic [63:0] rbk_d_8;
    logic [63:0] rbk_d_9;
    logic [63:0] rbk_d_10;
    logic [63:0] rbk_d_11;
    logic [63:0] rbk_d_12;
    logic [63:0] rbk_d_13;
    logic [63:0] rbk_d_14;
    logic [63:0] rbk_d_15;
    logic [63:0] rbk_d_16;
    logic [63:0] rbk_d_17;
    logic [63:0] rbk_d_18;
    logic [63:0] rbk_d_19;
    logic [63:0] rbk_d_20;
    logic [63:0] rbk_d_21;
    logic [63:0] rbk_d_22;
    logic [63:0] rbk_d_23;
    logic [63:0] rbk_d_24;
    logic [63:0] rbk_d_25;
    logic [63:0] rbk_d_26;
    logic [63:0] rbk_d_27;
    logic [63:0] rbk_d_28;
    logic [63:0] rbk_d_29;
    logic [63:0] rbk_d_30;
    logic [63:0] rbk_d_31;
    logic mq_v;
    logic [1023:0] mq_q16;
    logic [3:0] mq_beat;
    logic mq_s16_0;
    logic mq_s16_1;
    logic mq_s16_2;
    logic mq_s16_3;
    logic mq_s16_4;
    logic mq_s16_5;
    logic mq_s16_6;
    logic mq_s16_7;
    logic mq_sh_0;
    logic mq_sh_1;
    logic mq_sh_2;
    logic mq_sh_3;
    logic mq_sh_4;
    logic mq_sh_5;
    logic mq_sh_6;
    logic mq_sh_7;
    logic mq_sl_0;
    logic mq_sl_1;
    logic mq_sl_2;
    logic mq_sl_3;
    logic mq_sl_4;
    logic mq_sl_5;
    logic mq_sl_6;
    logic mq_sl_7;
    logic [9:0] mq_nb;
    logic mq_l3;
    logic [10:0] st_span;
    logic [3:0] st_nb_c_c;
    logic [3:0] st_nb_c;
    logic [511:0] st_wbeat;
    logic [63:0] st_wstrb;
    logic st_last_beat;
    logic [6:0] st_rowi;
    logic [6:0] st_rows;
    logic [47:0] st_addr_n;
    logic st_more;
    logic aw_req;
    logic aw_hs;
    logic [47:0] aw_addr_c;
    logic oq_v;
    logic [511:0] oq_dat;
    logic [63:0] oq_stb;
    logic oq_l3;
    logic oq_acc;
    logic oq_take;
    logic w_hs;
    logic w_last_hs;
    logic w_start;
    logic st_f32;
    logic [3:0] st_beat_n;
    logic rb_e_n;
    logic rb_j_n;
    logic [2:0] rb_ra_n;
    logic [2:0] rb_raq_0;
    logic [2:0] rb_raq_1;
    logic [2:0] rb_raq_2;
    logic [2:0] rb_raq_3;
    logic [2:0] rb_raq_4;
    logic [2:0] rb_raq_5;
    logic [2:0] rb_raq_6;
    logic [2:0] rb_raq_7;
    logic [2:0] rb_raq_8;
    logic [2:0] rb_raq_9;
    logic [2:0] rb_raq_10;
    logic [2:0] rb_raq_11;
    logic [2:0] rb_raq_12;
    logic [2:0] rb_raq_13;
    logic [2:0] rb_raq_14;
    logic [2:0] rb_raq_15;
    logic rb_jq_0;
    logic rb_jq_1;
    logic rb_jq_2;
    logic rb_jq_3;
    logic rb_jq_4;
    logic rb_jq_5;
    logic rb_jq_6;
    logic rb_jq_7;
    logic rb_jq_8;
    logic rb_jq_9;
    logic rb_jq_10;
    logic rb_jq_11;
    logic rb_jq_12;
    logic rb_jq_13;
    logic rb_jq_14;
    logic rb_jq_15;
    logic [63:0] rb_lo_s_0;
    logic [63:0] rb_lo_s_1;
    logic [63:0] rb_lo_s_2;
    logic [63:0] rb_lo_s_3;
    logic [63:0] rb_lo_s_4;
    logic [63:0] rb_lo_s_5;
    logic [63:0] rb_lo_s_6;
    logic [63:0] rb_lo_s_7;
    logic [63:0] rb_hi_s_0;
    logic [63:0] rb_hi_s_1;
    logic [63:0] rb_hi_s_2;
    logic [63:0] rb_hi_s_3;
    logic [63:0] rb_hi_s_4;
    logic [63:0] rb_hi_s_5;
    logic [63:0] rb_hi_s_6;
    logic [63:0] rb_hi_s_7;
    logic [511:0] rb_lo;
    logic [511:0] rb_hi;
    logic [1023:0] st_q16;
    logic b_hs;
    logic st_fin;
    logic st_use_l1;
    logic [7:0] R16;
    logic [2:0] st_nRow_c;
    logic [2:0] st_nRow;
    logic [5:0] ntile_acc_c;
    logic qm_t_0;
    logic qm_t_1;
    logic qm_t_2;
    logic qm_t_3;
    logic qm_t_4;
    logic qm_t_5;
    logic qm_t_6;
    logic qm_t_7;
    logic qm_t_8;
    logic qm_t_9;
    logic qm_t_10;
    logic qm_t_11;
    logic qm_t_12;
    logic qm_t_13;
    logic qm_t_14;
    logic qm_t_15;
    logic qm_t_16;
    logic qm_t_17;
    logic qm_t_18;
    logic qm_t_19;
    logic qm_t_20;
    logic qm_t_21;
    logic qm_t_22;
    logic qm_t_23;
    logic qm_t_24;
    logic qm_t_25;
    logic qm_t_26;
    logic qm_t_27;
    logic qm_t_28;
    logic qm_t_29;
    logic qm_t_30;
    logic qm_t_31;
    logic qm_a_0;
    logic qm_a_1;
    logic qm_a_2;
    logic qm_a_3;
    logic qm_a_4;
    logic qm_a_5;
    logic qm_a_6;
    logic qm_a_7;
    logic qm_a_8;
    logic qm_a_9;
    logic qm_a_10;
    logic qm_a_11;
    logic qm_a_12;
    logic qm_a_13;
    logic qm_a_14;
    logic qm_a_15;
    logic qm_a_16;
    logic qm_a_17;
    logic qm_a_18;
    logic qm_a_19;
    logic qm_a_20;
    logic qm_a_21;
    logic qm_a_22;
    logic qm_a_23;
    logic qm_a_24;
    logic qm_a_25;
    logic qm_a_26;
    logic qm_a_27;
    logic qm_a_28;
    logic qm_a_29;
    logic qm_a_30;
    logic qm_a_31;
    logic qm_b_0;
    logic qm_b_1;
    logic qm_b_2;
    logic qm_b_3;
    logic qm_b_4;
    logic qm_b_5;
    logic qm_b_6;
    logic qm_b_7;
    logic qm_b_8;
    logic qm_b_9;
    logic qm_b_10;
    logic qm_b_11;
    logic qm_b_12;
    logic qm_b_13;
    logic qm_b_14;
    logic qm_b_15;
    logic qm_b_16;
    logic qm_b_17;
    logic qm_b_18;
    logic qm_b_19;
    logic qm_b_20;
    logic qm_b_21;
    logic qm_b_22;
    logic qm_b_23;
    logic qm_b_24;
    logic qm_b_25;
    logic qm_b_26;
    logic qm_b_27;
    logic qm_b_28;
    logic qm_b_29;
    logic qm_b_30;
    logic qm_b_31;
    logic qm_r_0;
    logic qm_r_1;
    logic qm_r_2;
    logic qm_r_3;
    logic qm_r_4;
    logic qm_r_5;
    logic qm_r_6;
    logic qm_r_7;
    logic qm_r_8;
    logic qm_r_9;
    logic qm_r_10;
    logic qm_r_11;
    logic qm_r_12;
    logic qm_r_13;
    logic qm_r_14;
    logic qm_r_15;
    logic qm_r_16;
    logic qm_r_17;
    logic qm_r_18;
    logic qm_r_19;
    logic qm_r_20;
    logic qm_r_21;
    logic qm_r_22;
    logic qm_r_23;
    logic qm_r_24;
    logic qm_r_25;
    logic qm_r_26;
    logic qm_r_27;
    logic qm_r_28;
    logic qm_r_29;
    logic qm_r_30;
    logic qm_r_31;
    logic [6:0] qm_sel;
    logic [31:0] qmask_c;
    logic [31:0] qmask;
    logic [6:0] st_endt_c;
    logic [6:0] st_endt;
    logic [6:0] ab_endt_c;
    logic [6:0] jd_endt;
    logic [6:0] jp_endt;
    logic jd_ahit;
    logic jp_ahit;
    logic [6:0] sc_endt_c;
    logic [6:0] sc_endt;
    logic sc_ahit;
    logic acc_over;
    logic sb_hit;
    logic [4:0] st_zs;
    logic ra_z_n;
    logic fe_idle;
    logic flush_c;
    logic [2:0] nfl_w;
    logic [4:0] dq_n;
    logic dq_full;
    logic dq_empty;
    logic [127:0] dqh_ins;
    logic [31:0] dqh_av;
    logic [31:0] dqh_bv;
    logic [23:0] dqh_prog;
    logic dqh_pf;
    logic dq_pop;
    logic dq_byp;
    logic dq_cq;
    logic ift_take;
    logic seq_due_c;
    logic idle0;
    logic kw_rdy;
    logic lc_go;
    logic [127:0] w_ins;
    logic [5:0] kw_va;
    logic [5:0] kw_vb;
    logic kw_lcrdy;
    logic kern_act;
    logic kw_take;
    logic dq_push;
    logic [4:0] dq_nn;
    logic [9:0] rd_a;
    logic [1:0] fs_idx;
    logic rt_rdy;
    logic [1:0] rt_idx;
    logic [2:0] cq_n;
    logic cred_l1_ok;
    logic cred_nc_ok;
    logic sc_ar;
    logic [47:0] sc_addr;
    logic [9:0] sc_span;
    logic wl1_sc;
    logic wl1_a;
    logic wl1_b;
    logic l1_pa;
    logic l1_pb;
    logic l1ar_go;
    logic [47:0] l1ar_addr;
    logic [19:0] l1ar_bytes;
    logic [7:0] l1ar_cfg;
    logic l1ar_first;
    logic l1ar_last;
    logic [15:0] tag_a;
    logic [15:0] tag_b;
    logic [15:0] tag_sc;
    logic l1ar_fire;
    logic lda_gnt;
    logic ldb_gnt;
    logic sc_gnt;
    logic [1:0] l1_rt;
    logic lda_rv;
    logic ldb_rv;
    logic [1023:0] lda_rd;
    logic [1023:0] ldb_rd;
    logic sc_rv;
    logic [1023:0] rd_beat;
    logic aw_go;
    logic aw_first;
    logic aw_last;
    logic [9:0] row;
    logic [1:0] lane;
    logic lq_push;
    logic l1_dec;
    logic nc_dec;
    logic a_fin;
    logic b_fin;
    logic sc_fin;
    logic st_fin_p;
    logic [1:0] nd_dec__i0;
    logic [1:0] nd_dec__i1;
    logic [1:0] nd_dec__i2;
    logic [1:0] nd_dec__i3;
    logic u_lda_aw_en;
    logic [1:0] u_lda_set_q;
    logic [5:0] u_lda_aw_m;
    logic [3:0] u_lda_aw_en_r;
    logic [23:0] u_lda_aw_m_r;
    logic [7:0] u_lda_aw_set_r;
    logic [1023:0] u_lda_aw_data;
    logic u_lda_aw_e_en;
    logic [9:0] u_lda_aw_e;
    logic u_ldb_bw_en;
    logic [1:0] u_ldb_set_q;
    logic u_ldb_kmj;
    logic [6:0] u_ldb_bw_r;
    logic [1023:0] u_ldb_bw_data;
    logic u_ldb_bw_e_en;
    logic [33:0] u_ldb_bw_eb;
    logic u_ldb_clr_q;
    logic [1:0] u_ldb_clr_set;
    logic [1023:0] u_ldb_bw_data2;
    logic [33:0] u_ldb_bw_eb2;
    logic u_ldb_bw_dual;
    logic u_lda_busy;
    logic u_ldb_busy;
    logic u_lda_fx_free;
    logic u_ldb_fx_free;
    logic [7:0] u_lda_rows_done0;
    logic [7:0] u_lda_rows_done1;
    logic [7:0] u_ldb_rows_done0;
    logic [7:0] u_ldb_rows_done1;
    logic [2:0] u_lda_tag_q0;
    logic [2:0] u_lda_tag_q1;
    logic [2:0] u_ldb_tag_q0;
    logic [2:0] u_ldb_tag_q1;
    logic [4:0] u_arr_jq_cnt;
    logic u_arr_busy;
    logic u_arr_held_valid;
    logic [5:0] u_arr_held_slot;
    logic [3:0] u_arr_ause;
    logic [3:0] u_arr_buse;
    logic u_arr_dr_valid;
    logic [5:0] u_arr_dr_slot;
    logic [2:0] u_arr_dr_rp;
    logic u_arr_dr_last;
    logic [1023:0] u_arr_dr_data;
    logic [5:0] u_arr_pl_rslot;
    logic [2:0] u_arr_pl_rrp;
    logic u_arr_pl_rd;
    logic [31:0] sc_m31_res;
    logic [31:0] sc_m30_res;
    logic [31:0] sc_m29_res;
    logic [31:0] sc_m28_res;
    logic [31:0] sc_m27_res;
    logic [31:0] sc_m26_res;
    logic [31:0] sc_m25_res;
    logic [31:0] sc_m24_res;
    logic [31:0] sc_m23_res;
    logic [31:0] sc_m22_res;
    logic [31:0] sc_m21_res;
    logic [31:0] sc_m20_res;
    logic [31:0] sc_m19_res;
    logic [31:0] sc_m18_res;
    logic [31:0] sc_m17_res;
    logic [31:0] sc_m16_res;
    logic [31:0] sc_m15_res;
    logic [31:0] sc_m14_res;
    logic [31:0] sc_m13_res;
    logic [31:0] sc_m12_res;
    logic [31:0] sc_m11_res;
    logic [31:0] sc_m10_res;
    logic [31:0] sc_m9_res;
    logic [31:0] sc_m8_res;
    logic [31:0] sc_m7_res;
    logic [31:0] sc_m6_res;
    logic [31:0] sc_m5_res;
    logic [31:0] sc_m4_res;
    logic [31:0] sc_m3_res;
    logic [31:0] sc_m2_res;
    logic [31:0] sc_m1_res;
    logic [31:0] sc_m0_res;
    logic [15:0] u_arr_dr_valid_c;
    logic [127:0] u_arr_dr_wa_c;
    logic [511:0] u_sr_seg;
    logic [63:0] u_sr_strb;
    logic u_arr_qbusy;
    logic [127:0] u_kw_out_inst;
    logic u_kw_lc_ready;
    logic u_kw_busy;
    logic u_kw_out_v;
    logic [11:0] u_kw_im_addr;
    logic [5:0] u_arr_acc_occ;
    logic u_lda_ar_req;
    logic u_ldb_ar_req;
    logic [47:0] u_lda_ar_addr;
    logic [47:0] u_ldb_ar_addr;
    logic [19:0] u_lda_ar_bytes;
    logic [19:0] u_ldb_ar_bytes;
    logic [7:0] u_lda_ar_cfg;
    logic [7:0] u_ldb_ar_cfg;
    logic u_lda_ar_first;
    logic u_ldb_ar_first;
    logic u_lda_ar_last;
    logic u_ldb_ar_last;
    logic [1:0] u_lda_slot_q;
    logic [1:0] u_ldb_slot_q;
    logic u_lda_done_p;
    logic u_ldb_done_p;
    logic [1:0] u_lda_done_slot;
    logic [1:0] u_ldb_done_slot;
    logic u_kw_im_req;
    logic [31:0] u_kw_rda_val;
    logic [31:0] u_kw_rdb_val;
    logic qm_t_16_c0;
    logic qm_t_18_c0;
    logic qm_t_22_c0;
    logic qm_t_28_c0;
    logic qm_t_30_c0;
    logic rt_rdy_c0;
    logic rt_rdy_c1;
    logic rt_rdy_c2;
    logic rt_rdy_c3;

    assign ld_v = (lq_n != 0);
    assign ld_id = lq_id[lq_rp[1:0]];
    assign ld_off = lq_off[lq_rp[1:0]];
    assign ld_len = lq_len[lq_rp[1:0]];
    assign dq_pf = {dq_pf_c_15, dq_pf_c_14, dq_pf_c_13, dq_pf_c_12, dq_pf_c_11, dq_pf_c_10, dq_pf_c_9, dq_pf_c_8,
                    dq_pf_c_7, dq_pf_c_6, dq_pf_c_5, dq_pf_c_4, dq_pf_c_3, dq_pf_c_2, dq_pf_c_1, dq_pf_c_0};
    assign ift_v = {ift_v_c_3, ift_v_c_2, ift_v_c_1, ift_v_c_0};
    assign ift_fin = {ift_fin_c_3, ift_fin_c_2, ift_fin_c_1, ift_fin_c_0};
    assign jd_av = ((jd_tag == 0) ? av_tab_0 : ((jd_tag == 1) ? av_tab_1 : ((jd_tag == 2) ? av_tab_2 : av_tab_3)));
    assign zf = {zf_c_31, zf_c_30, zf_c_29, zf_c_28, zf_c_27, zf_c_26, zf_c_25, zf_c_24, zf_c_23, zf_c_22, zf_c_21,
                 zf_c_20, zf_c_19, zf_c_18, zf_c_17, zf_c_16, zf_c_15, zf_c_14, zf_c_13, zf_c_12, zf_c_11, zf_c_10,
                 zf_c_9, zf_c_8, zf_c_7, zf_c_6, zf_c_5, zf_c_4, zf_c_3, zf_c_2, zf_c_1, zf_c_0};
    assign op = cur[4:0];
    assign is_mma = (op == 14);
    assign is_aclr = (op == 15);
    assign is_ast = (op == 16);
    assign is_asc = (op == 17);
    assign f_acc_c = (is_mma ? {1'd0, cur[9:5]} : cur[10:5]);
    assign f_accum = cur[10];
    assign f_apipe = cur[20:13];
    assign f_aoff = cur[42:21];
    assign f_M = cur[49:43];
    assign f_K = cur[56:50];
    assign f_bpipe = cur[66:59];
    assign f_boff = cur[88:67];
    assign f_N = cur[96:89];
    assign f_bdt = cur[102:100];
    assign f_ald = cur[115:103];
    assign f_bld = cur[124:116];
    assign f_btr = cur[125];
    assign f_arl = cur[126];
    assign f_dmem = cur[12:11];
    assign f_dpipe = cur[20:13];
    assign f_doff = cur[48:21];
    assign f_rows = cur[55:49];
    assign f_bpr = cur[67:56];
    assign f_dstr = cur[87:68];
    assign f_dt = cur[90:88];
    assign is_q8_c = (f_bdt == 5);
    assign kmj_c = (f_btr & (~is_q8_c));
    assign N16 = ({1'd0, f_N} + 9'd15);
    assign nCol_c = N16[7:4];
    assign M16 = ({1'd0, f_M} + 8'd15);
    assign nRow_c = M16[6:4];
    assign ntile_c = ({3'd0, nRow_c} * {2'd0, nCol_c});
    assign job_slot = ((jd_acc + ({4'd0, jmi} * {2'd0, jd_ncol})) + {3'd0, jni});
    assign mrem = (jd_M - {jmi, 4'd0});
    assign job_mrows = ((mrem > 16) ? 5'd16 : mrem[4:0]);
    assign mr3 = ({1'd0, job_mrows} + 6'd3);
    assign job_nblk = mr3[4:2];
    assign jd_nrow_m1 = (jd_nrow - 3'd1);
    assign jd_ncol_m1 = (jd_ncol - 4'd1);
    assign jd_rmax = jd_nrow_m1[1:0];
    assign jd_cmax = jd_ncol_m1[2:0];
    assign jd_dmax = (({1'd0, jd_rmax} > jd_cmax) ? {1'd0, jd_rmax} : jd_cmax);
    assign jdd1 = (jdd + 3'd1);
    assign jdm1 = (jdd - 3'd1);
    assign jl0_end = ((jdd > jd_cmax) ? jd_cmax : jdd);
    assign jl1_end = ((jdm1 > {1'd0, jd_rmax}) ? jd_rmax : jdm1[1:0]);
    assign jhas_l1 = ((jdd != 0) & (jdd <= jd_cmax));
    assign jleg_last = (jleg ? (jmi == jl1_end) : (jni == jl0_end));
    assign jgo_l1 = (((~jleg) & jleg_last) & jhas_l1);
    assign jnx_sh = (jleg_last & (~jgo_l1));
    assign jnx_l0 = (jdd1 <= {1'd0, jd_rmax});
    assign job_last = (jnx_sh & (jdd == jd_dmax));
    assign jmi1 = ({1'd0, jmi} + 3'd1);
    assign jd_need = (({1'd0, jd_M} > {jmi1, 4'd0}) ? {jmi1, 4'd0} : {1'd0, jd_M});
    assign jni1 = ({1'd0, jni} + 4'd1);
    assign jd_bneed_n = {jni1, 4'd0};
    assign jd_bneed = ((jd_kmj | (jd_bneed_n > jd_btot)) ? jd_btot : jd_bneed_n);
    assign jd_go = (((jd_act & arr_job_ready) & (jd_rows >= jd_need)) & (jd_bavail >= jd_bneed));
    assign jd_oth = (jd_act & (jd_tag != cur_slot));
    assign jp_oth = (jp_v & (jp_tag != cur_slot));
    assign aclm_0 = (((jd_oth & jd_arl) & (jd_aset == 0)) | ((jp_oth & jp_arl) & (jp_aset == 0)));
    assign aclm_1 = (((jd_oth & jd_arl) & (jd_aset == 1)) | ((jp_oth & jp_arl) & (jp_aset == 1)));
    assign aclm_2 = (((jd_oth & jd_arl) & (jd_aset == 2)) | ((jp_oth & jp_arl) & (jp_aset == 2)));
    assign aclm_3 = (((jd_oth & jd_arl) & (jd_aset == 3)) | ((jp_oth & jp_arl) & (jp_aset == 3)));
    assign bclm_0 = (((jd_act & (jd_bset == 0)) | (jp_v & (jp_bset == 0))) | (pf_v & (pf_bset == 0)));
    assign bclm_1 = (((jd_act & (jd_bset == 1)) | (jp_v & (jp_bset == 1))) | (pf_v & (pf_bset == 1)));
    assign bclm_2 = (((jd_act & (jd_bset == 2)) | (jp_v & (jp_bset == 2))) | (pf_v & (pf_bset == 2)));
    assign bclm_3 = (((jd_act & (jd_bset == 3)) | (jp_v & (jp_bset == 3))) | (pf_v & (pf_bset == 3)));
    assign aset_busy = {(arr_ause[3] | aclm_3), (arr_ause[2] | aclm_2), (arr_ause[1] | aclm_1), (arr_ause[0] | aclm_0)};
    assign bset_busy = {(arr_buse[3] | bclm_3), (arr_buse[2] | bclm_2), (arr_buse[1] | bclm_1), (arr_buse[0] | bclm_0)};
    assign aset_nx = (aset_cur + 2'd1);
    assign aset_nx_free = (~((aset_nx == 0) ? aset_busy[0] :
                            ((aset_nx == 1) ? aset_busy[1] :
                            ((aset_nx == 2) ? aset_busy[2] :
                            aset_busy[3]))));
    assign st_cols = ((f_dt == 1) ? f_bpr[9:2] : f_bpr[8:1]);
    assign stC16 = ({1'd0, st_cols} + 9'd15);
    assign st_nCol_c = stC16[7:4];
    assign d_l3_c = (f_dmem == 1);
    assign a_cid = (({2'd0, cur_avar[28:23]} * 4) + {5'd0, cur_avar[22:20]});
    assign b_cid = (({2'd0, cur_bvar[28:23]} * 4) + {5'd0, cur_bvar[22:20]});
    assign a_cfg_c = (cur_kern ? a_cid : f_apipe);
    assign b_cfg_c = (cur_kern ? b_cid : f_bpipe);
    assign d_cfg_c = (cur_kern ? a_cid : f_dpipe);
    assign a_vb = (cur_kern ? {8'd0, cur_avar[19:0]} : 28'd0);
    assign b_vb = (cur_kern ? {8'd0, cur_bvar[19:0]} : 28'd0);
    assign a_base_c = ({20'd0, ({6'd0, f_aoff} + a_vb)} + L1_BASE);
    assign b_base_c = ({20'd0, ({6'd0, f_boff} + b_vb)} + L1_BASE);
    assign d_base_c = (d_l3_c
                       ? (cur_kern ? ({16'd0, cur_avar} + {20'd0, f_doff}) : {18'd0, {f_dpipe[7:0], f_doff[21:0]}}) :
                      ({20'd0, (f_doff + a_vb)} + L1_BASE));
    assign K16 = ({1'd0, f_K} + 8'd15);
    assign a_rowb_c = ({2'd0, f_K} << 1);
    assign a_strd_c = ({19'd0, f_ald} << 1);
    assign b_rowb_c = (is_q8_c ? ({6'd0, K16[7:5]} * 9'd34) : (kmj_c ? ({1'd0, f_N} << 1) : ({2'd0, f_K} << 1)));
    assign q8_bld = (f_bld >> 5);
    assign b_strd_c = (is_q8_c ? ({22'd0, q8_bld} * 32'd34) : ({23'd0, f_bld} << 1));
    assign b_rows_c = (kmj_c ? {1'd0, f_K} : f_N);
    assign b_tight = (((is_q8_c & (q8_bld[2:0] == K16[7:5])) & (q8_bld[9:3] == 0)) & (K16[7:5] == 2));
    assign b_strm_c = ((b_tight & (b_base_c[6:0] == 0)) & (~f_N[0]));
    assign dq_ri = dq_rp[3:0];
    assign dq_wi = dq_wp[3:0];
    assign pf_cand = {(dq_mma_15 & (~dq_pf[15])), (dq_mma_14 & (~dq_pf[14])), (dq_mma_13 & (~dq_pf[13])),
                      (dq_mma_12 & (~dq_pf[12])), (dq_mma_11 & (~dq_pf[11])), (dq_mma_10 & (~dq_pf[10])),
                      (dq_mma_9 & (~dq_pf[9])), (dq_mma_8 & (~dq_pf[8])), (dq_mma_7 & (~dq_pf[7])),
                      (dq_mma_6 & (~dq_pf[6])), (dq_mma_5 & (~dq_pf[5])), (dq_mma_4 & (~dq_pf[4])),
                      (dq_mma_3 & (~dq_pf[3])), (dq_mma_2 & (~dq_pf[2])), (dq_mma_1 & (~dq_pf[1])),
                      (dq_mma_0 & (~dq_pf[0]))};
    assign pf_hi = {(pf_cand[15] & (4'd15 >= dq_ri)), (pf_cand[14] & (4'd14 >= dq_ri)),
                    (pf_cand[13] & (4'd13 >= dq_ri)), (pf_cand[12] & (4'd12 >= dq_ri)),
                    (pf_cand[11] & (4'd11 >= dq_ri)), (pf_cand[10] & (4'd10 >= dq_ri)), (pf_cand[9] & (4'd9 >= dq_ri)),
                    (pf_cand[8] & (4'd8 >= dq_ri)), (pf_cand[7] & (4'd7 >= dq_ri)), (pf_cand[6] & (4'd6 >= dq_ri)),
                    (pf_cand[5] & (4'd5 >= dq_ri)), (pf_cand[4] & (4'd4 >= dq_ri)), (pf_cand[3] & (4'd3 >= dq_ri)),
                    (pf_cand[2] & (4'd2 >= dq_ri)), (pf_cand[1] & (4'd1 >= dq_ri)), (pf_cand[0] & (4'd0 >= dq_ri))};
    assign pf_any = (pf_cand != 0);
    assign pf_idx = ((pf_hi != 0)
                     ? ((pf_hi[7:0] != 0)
                        ? {1'd0,
                           (pf_hi[0] ? 3'd0 :
                           (pf_hi[1] ? 3'd1 :
                           (pf_hi[2] ? 3'd2 :
                           (pf_hi[3] ? 3'd3 :
                           (pf_hi[4] ? 3'd4 :
                           (pf_hi[5] ? 3'd5 :
                           (pf_hi[6] ? 3'd6 :
                           3'd7)))))))} :
                       {1'd1,
                        (pf_hi[8] ? 3'd0 :
                        (pf_hi[9] ? 3'd1 :
                        (pf_hi[10] ? 3'd2 :
                        (pf_hi[11] ? 3'd3 :
                        (pf_hi[12] ? 3'd4 :
                        (pf_hi[13] ? 3'd5 :
                        (pf_hi[14] ? 3'd6 :
                        3'd7)))))))}) :
                    (pf_any
                     ? ((pf_cand[7:0] != 0)
                        ? {1'd0,
                           (pf_cand[0] ? 3'd0 :
                           (pf_cand[1] ? 3'd1 :
                           (pf_cand[2] ? 3'd2 :
                           (pf_cand[3] ? 3'd3 :
                           (pf_cand[4] ? 3'd4 :
                           (pf_cand[5] ? 3'd5 :
                           (pf_cand[6] ? 3'd6 :
                           3'd7)))))))} :
                       {1'd1,
                        (pf_cand[8] ? 3'd0 :
                        (pf_cand[9] ? 3'd1 :
                        (pf_cand[10] ? 3'd2 :
                        (pf_cand[11] ? 3'd3 :
                        (pf_cand[12] ? 3'd4 :
                        (pf_cand[13] ? 3'd5 :
                        (pf_cand[14] ? 3'd6 :
                        3'd7)))))))}) :
                    dq_ri));
    assign pq_ok = ((((pq_idx == 0) ? dq_mma_0 :
                     ((pq_idx == 1) ? dq_mma_1 :
                     ((pq_idx == 2) ? dq_mma_2 :
                     ((pq_idx == 3) ? dq_mma_3 :
                     ((pq_idx == 4) ? dq_mma_4 :
                     ((pq_idx == 5) ? dq_mma_5 :
                     ((pq_idx == 6) ? dq_mma_6 :
                     ((pq_idx == 7) ? dq_mma_7 :
                     ((pq_idx == 8) ? dq_mma_8 :
                     ((pq_idx == 9) ? dq_mma_9 :
                     ((pq_idx == 10) ? dq_mma_10 :
                     ((pq_idx == 11) ? dq_mma_11 :
                     ((pq_idx == 12) ? dq_mma_12 :
                     ((pq_idx == 13) ? dq_mma_13 :
                     ((pq_idx == 14) ? dq_mma_14 :
                     dq_mma_15))))))))))))))) & (~dq_pf[pq_idx])) & (~dq_npf[pq_idx]));
    assign n_K = pq_ins[56:50];
    assign n_boff = pq_ins[88:67];
    assign n_N = pq_ins[96:89];
    assign n_bdt = pq_ins[102:100];
    assign n_bld = pq_ins[124:116];
    assign n_btr = pq_ins[125];
    assign n_q8 = (n_bdt == 5);
    assign n_kmj = (n_btr & (~n_q8));
    assign n_bvar = pq_bv;
    assign n_bcid = (({2'd0, n_bvar[28:23]} * 4) + {5'd0, n_bvar[22:20]});
    assign n_bbase = ({20'd0, ({6'd0, n_boff} + {8'd0, n_bvar[19:0]})} + L1_BASE);
    assign n_K16 = ({1'd0, n_K} + 8'd15);
    assign n_browb = (n_q8 ? ({6'd0, n_K16[7:5]} * 9'd34) : (n_kmj ? ({1'd0, n_N} << 1) : ({2'd0, n_K} << 1)));
    assign n_q8bld = (n_bld >> 5);
    assign n_bstrd = (n_q8 ? ({22'd0, n_q8bld} * 32'd34) : ({23'd0, n_bld} << 1));
    assign n_brows = (n_kmj ? {1'd0, n_K} : n_N);
    assign n_bklim = (n_kmj ? n_N : {1'd0, n_K});
    assign n_btight = (((n_q8 & (n_q8bld[2:0] == n_K16[7:5])) & (n_q8bld[9:3] == 0)) & (n_K16[7:5] == 2));
    assign n_bstrm = ((n_btight & (n_bbase[6:0] == 0)) & (~n_N[0]));
    assign pf_nset = (bset_cur + 2'd1);
    assign pf_set_free = (~((pf_nset == 0) ? bset_busy[0] :
                           ((pf_nset == 1) ? bset_busy[1] :
                           ((pf_nset == 2) ? bset_busy[2] :
                           bset_busy[3]))));
    assign pf_can = ((((((((((((~pf_v) & pq_v) & pq_ok) & (state != S_B_SET)) & (state != S_B_ADM)) & (state != S_DEC))
                     & (~ift_take)) & pf_set_free) & ldb_fxfree) & (nfl_w < 4)) & (~ldb_start)) & (~ldb_start_p));
    assign b_klim_c = (kmj_c ? f_N : {1'd0, f_K});
    assign lda_busy = u_lda_busy;
    assign ldb_busy = u_ldb_busy;
    assign lda_fxfree = u_lda_fx_free;
    assign ldb_fxfree = u_ldb_fx_free;
    assign lda_rows = u_lda_rows_done0;
    assign lda_rows1 = u_lda_rows_done1;
    assign ldb_rows = u_ldb_rows_done0;
    assign ldb_rows1 = u_ldb_rows_done1;
    assign lda_tag = u_lda_tag_q0;
    assign lda_tag1 = u_lda_tag_q1;
    assign ldb_tag = u_ldb_tag_q0;
    assign ldb_tag1 = u_ldb_tag_q1;
    assign job_c = {jd_tag, job_last, job_slot, job_mrows, jd_accum, jd_kmj, job_nblk, jni, jmi, jd_bset, jd_aset};
    assign arr_job_ready = ((({1'd0, u_arr_jq_cnt} + {5'd0, job_v}) + {5'd0, jv_d1}) < 16);
    assign arr_busy = u_arr_busy;
    assign arr_held = u_arr_held_valid;
    assign arr_held_slot = u_arr_held_slot;
    assign arr_ause = u_arr_ause;
    assign arr_buse = u_arr_buse;
    assign dr_valid = u_arr_dr_valid;
    assign dr_slot = u_arr_dr_slot;
    assign dr_rp = u_arr_dr_rp;
    assign dr_last = u_arr_dr_last;
    assign dr_data = u_arr_dr_data;
    assign pl_slot_c = u_arr_pl_rslot;
    assign pl_i = u_arr_pl_rrp;
    assign pl_rd = u_arr_pl_rd;
    assign st_rd_p = (((st_act & (sr_st == 2)) & (~sr_last_ti)) & acc_rd_ok);
    assign st_rd = ((st_act & (sr_st == 1)) | st_rd_p);
    assign sc_redo_v = {sc_redo_7, sc_redo_6, sc_redo_5, sc_redo_4, sc_redo_3, sc_redo_2, sc_redo_1, sc_redo_0};
    assign sc_redo_any = (sc_redo_v != 0);
    assign sc_redo_i = (sc_redo_v[0] ? 3'd0 :
                       (sc_redo_v[1] ? 3'd1 :
                       (sc_redo_v[2] ? 3'd2 :
                       (sc_redo_v[3] ? 3'd3 :
                       (sc_redo_v[4] ? 3'd4 :
                       (sc_redo_v[5] ? 3'd5 :
                       (sc_redo_v[6] ? 3'd6 :
                       3'd7)))))));
    assign sc_pipe_empty = ((((~sc_v1) & (~sc_v2)) & (~sc_v3)) & (~sc_v4));
    assign sc_nxt = (sc_i[3] ? sc_redo_i : sc_ra);
    assign sc_can = ((sc_act & sc_rd_ok) & (sc_i[3] ? (sc_pipe_empty & sc_redo_any) : 1'd1));
    assign acc_rd_ok = (~pl_rd);
    assign sc_rd_ok = ((~pl_rd) & (~st_rd));
    assign st_slot_g = ((f_acc + ({3'd0, sr_rpf[5:3]} * {2'd0, st_nCol})) + {3'd0, st_ti});
    assign st_ra_slot = (st_rd_p ? (st_slot_g + 6'd1) : st_slot_g);
    assign acc_ra = (pl_rd ? {pl_slot_c[4:0], pl_i} : (st_rd ? {st_ra_slot[4:0], sr_rpf[2:0]} : {sc_acc[4:0], sc_nxt}));
    assign rows_p1 = (f_rows + 7'd1);
    assign st_nrp_c = rows_p1[6:1];
    assign sr_free = (~(sr_e ? rb_v1 : rb_v0));
    assign sr_next_free = (~(sr_e ? rb_v0 : rb_v1));
    assign wr_ready = (wr_e ? rb_v1 : rb_v0);
    assign sr_last_ti = ({1'd0, st_ti} == (st_nCol - 4'd1));
    assign sc_s0_n = ((sc_nxt == 0) ? sreg[31:0] :
                     ((sc_nxt == 1) ? sreg[95:64] :
                     ((sc_nxt == 2) ? sreg[159:128] :
                     ((sc_nxt == 3) ? sreg[223:192] :
                     ((sc_nxt == 4) ? sreg[287:256] :
                     ((sc_nxt == 5) ? sreg[351:320] :
                     ((sc_nxt == 6) ? sreg[415:384] :
                     sreg[479:448])))))));
    assign sc_s1_n = ((sc_nxt == 0) ? sreg[63:32] :
                     ((sc_nxt == 1) ? sreg[127:96] :
                     ((sc_nxt == 2) ? sreg[191:160] :
                     ((sc_nxt == 3) ? sreg[255:224] :
                     ((sc_nxt == 4) ? sreg[319:288] :
                     ((sc_nxt == 5) ? sreg[383:352] :
                     ((sc_nxt == 6) ? sreg[447:416] :
                     sreg[511:480])))))));
    assign zf_cur = zf[f_acc[4:0]];
    assign zf_pl = zf[pl_slot_c[4:0]];
    assign accq_z = accq;
    assign sc_res = {sc_m31_res, sc_m30_res, sc_m29_res, sc_m28_res, sc_m27_res, sc_m26_res, sc_m25_res, sc_m24_res,
                     sc_m23_res, sc_m22_res, sc_m21_res, sc_m20_res, sc_m19_res, sc_m18_res, sc_m17_res, sc_m16_res,
                     sc_m15_res, sc_m14_res, sc_m13_res, sc_m12_res, sc_m11_res, sc_m10_res, sc_m9_res, sc_m8_res,
                     sc_m7_res, sc_m6_res, sc_m5_res, sc_m4_res, sc_m3_res, sc_m2_res, sc_m1_res, sc_m0_res};
    assign acc_we_c_0 = (u_arr_dr_valid_c[0] | (sc_act & sc_v4));
    assign acc_wa_c_0 = (u_arr_dr_valid_c[0] ? u_arr_dr_wa_c[7:0] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_0 = (u_arr_dr_valid_c[0] ? dr_data[63:0] : sc_res_q[63:0]);
    assign acc_we_c_1 = (u_arr_dr_valid_c[1] | (sc_act & sc_v4));
    assign acc_wa_c_1 = (u_arr_dr_valid_c[1] ? u_arr_dr_wa_c[15:8] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_1 = (u_arr_dr_valid_c[1] ? dr_data[127:64] : sc_res_q[127:64]);
    assign acc_we_c_2 = (u_arr_dr_valid_c[2] | (sc_act & sc_v4));
    assign acc_wa_c_2 = (u_arr_dr_valid_c[2] ? u_arr_dr_wa_c[23:16] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_2 = (u_arr_dr_valid_c[2] ? dr_data[191:128] : sc_res_q[191:128]);
    assign acc_we_c_3 = (u_arr_dr_valid_c[3] | (sc_act & sc_v4));
    assign acc_wa_c_3 = (u_arr_dr_valid_c[3] ? u_arr_dr_wa_c[31:24] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_3 = (u_arr_dr_valid_c[3] ? dr_data[255:192] : sc_res_q[255:192]);
    assign acc_we_c_4 = (u_arr_dr_valid_c[4] | (sc_act & sc_v4));
    assign acc_wa_c_4 = (u_arr_dr_valid_c[4] ? u_arr_dr_wa_c[39:32] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_4 = (u_arr_dr_valid_c[4] ? dr_data[319:256] : sc_res_q[319:256]);
    assign acc_we_c_5 = (u_arr_dr_valid_c[5] | (sc_act & sc_v4));
    assign acc_wa_c_5 = (u_arr_dr_valid_c[5] ? u_arr_dr_wa_c[47:40] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_5 = (u_arr_dr_valid_c[5] ? dr_data[383:320] : sc_res_q[383:320]);
    assign acc_we_c_6 = (u_arr_dr_valid_c[6] | (sc_act & sc_v4));
    assign acc_wa_c_6 = (u_arr_dr_valid_c[6] ? u_arr_dr_wa_c[55:48] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_6 = (u_arr_dr_valid_c[6] ? dr_data[447:384] : sc_res_q[447:384]);
    assign acc_we_c_7 = (u_arr_dr_valid_c[7] | (sc_act & sc_v4));
    assign acc_wa_c_7 = (u_arr_dr_valid_c[7] ? u_arr_dr_wa_c[63:56] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_7 = (u_arr_dr_valid_c[7] ? dr_data[511:448] : sc_res_q[511:448]);
    assign acc_we_c_8 = (u_arr_dr_valid_c[8] | (sc_act & sc_v4));
    assign acc_wa_c_8 = (u_arr_dr_valid_c[8] ? u_arr_dr_wa_c[71:64] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_8 = (u_arr_dr_valid_c[8] ? dr_data[575:512] : sc_res_q[575:512]);
    assign acc_we_c_9 = (u_arr_dr_valid_c[9] | (sc_act & sc_v4));
    assign acc_wa_c_9 = (u_arr_dr_valid_c[9] ? u_arr_dr_wa_c[79:72] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_9 = (u_arr_dr_valid_c[9] ? dr_data[639:576] : sc_res_q[639:576]);
    assign acc_we_c_10 = (u_arr_dr_valid_c[10] | (sc_act & sc_v4));
    assign acc_wa_c_10 = (u_arr_dr_valid_c[10] ? u_arr_dr_wa_c[87:80] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_10 = (u_arr_dr_valid_c[10] ? dr_data[703:640] : sc_res_q[703:640]);
    assign acc_we_c_11 = (u_arr_dr_valid_c[11] | (sc_act & sc_v4));
    assign acc_wa_c_11 = (u_arr_dr_valid_c[11] ? u_arr_dr_wa_c[95:88] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_11 = (u_arr_dr_valid_c[11] ? dr_data[767:704] : sc_res_q[767:704]);
    assign acc_we_c_12 = (u_arr_dr_valid_c[12] | (sc_act & sc_v4));
    assign acc_wa_c_12 = (u_arr_dr_valid_c[12] ? u_arr_dr_wa_c[103:96] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_12 = (u_arr_dr_valid_c[12] ? dr_data[831:768] : sc_res_q[831:768]);
    assign acc_we_c_13 = (u_arr_dr_valid_c[13] | (sc_act & sc_v4));
    assign acc_wa_c_13 = (u_arr_dr_valid_c[13] ? u_arr_dr_wa_c[111:104] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_13 = (u_arr_dr_valid_c[13] ? dr_data[895:832] : sc_res_q[895:832]);
    assign acc_we_c_14 = (u_arr_dr_valid_c[14] | (sc_act & sc_v4));
    assign acc_wa_c_14 = (u_arr_dr_valid_c[14] ? u_arr_dr_wa_c[119:112] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_14 = (u_arr_dr_valid_c[14] ? dr_data[959:896] : sc_res_q[959:896]);
    assign acc_we_c_15 = (u_arr_dr_valid_c[15] | (sc_act & sc_v4));
    assign acc_wa_c_15 = (u_arr_dr_valid_c[15] ? u_arr_dr_wa_c[127:120] : {sc_acc[4:0], sc_r4});
    assign acc_wd_c_15 = (u_arr_dr_valid_c[15] ? dr_data[1023:960] : sc_res_q[1023:960]);
    assign ra_fill = (st_act & sr_st[1]);
    assign rbq_fill_n = (st_act & (((sr_st == 1) & acc_rd_ok) | st_rd_p));
    assign rbq_ti_n = ((sr_st == 1) ? st_ti : (st_ti + 1));
    assign rbq_wa_n = {sr_e, rbq_ti_n[2:1]};
    assign rbq_we_n_0 = (rbq_fill_n & (~rbq_ti_n[0]));
    assign rbq_we_n_1 = (rbq_fill_n & rbq_ti_n[0]);
    assign rbk_d_0 = accq[63:0];
    assign rbk_d_1 = accq[127:64];
    assign rbk_d_2 = accq[191:128];
    assign rbk_d_3 = accq[255:192];
    assign rbk_d_4 = accq[319:256];
    assign rbk_d_5 = accq[383:320];
    assign rbk_d_6 = accq[447:384];
    assign rbk_d_7 = accq[511:448];
    assign rbk_d_8 = accq[63:0];
    assign rbk_d_9 = accq[127:64];
    assign rbk_d_10 = accq[191:128];
    assign rbk_d_11 = accq[255:192];
    assign rbk_d_12 = accq[319:256];
    assign rbk_d_13 = accq[383:320];
    assign rbk_d_14 = accq[447:384];
    assign rbk_d_15 = accq[511:448];
    assign rbk_d_16 = accq[575:512];
    assign rbk_d_17 = accq[639:576];
    assign rbk_d_18 = accq[703:640];
    assign rbk_d_19 = accq[767:704];
    assign rbk_d_20 = accq[831:768];
    assign rbk_d_21 = accq[895:832];
    assign rbk_d_22 = accq[959:896];
    assign rbk_d_23 = accq[1023:960];
    assign rbk_d_24 = accq[575:512];
    assign rbk_d_25 = accq[639:576];
    assign rbk_d_26 = accq[703:640];
    assign rbk_d_27 = accq[767:704];
    assign rbk_d_28 = accq[831:768];
    assign rbk_d_29 = accq[895:832];
    assign rbk_d_30 = accq[959:896];
    assign rbk_d_31 = accq[1023:960];
    assign st_span = ({1'd0, f_bpr[9:0]} + 11'd63);
    assign st_nb_c_c = st_span[9:6];
    assign st_wbeat = u_sr_seg;
    assign st_wstrb = u_sr_strb;
    assign st_last_beat = (st_beat == (st_nbeat - 4'd1));
    assign st_rowi = {st_rpf, st_j};
    assign st_addr_n = (st_addr + {28'd0, f_dstr});
    assign st_more = (st_rowi < st_rows);
    assign aw_req = (st_act & (aw_pend | ((st_more & wr_ready) & (~aw_sel_done))));
    assign aw_hs = (aw_go & (d_l3 ? noc_aw_ready : l1_aw_ready));
    assign aw_addr_c = (aw_pend ? aw_addr_q : st_addr);
    assign oq_acc = (oq_v & (oq_l3 ? noc_w_ready[0] : l1_w_ready[0]));
    assign oq_take = ((~oq_v) | oq_acc);
    assign w_hs = (w_act & ((~mq_v) | oq_take));
    assign w_last_hs = (w_hs & st_last_beat);
    assign w_start = ((((st_act & st_more) & wr_ready) & (~aw_pend)) & ((~w_act) | w_last_hs));
    assign st_beat_n = ((st_act & w_start) ? 4'd0 : ((st_act & w_hs) ? (st_beat + 1) : st_beat));
    assign rb_e_n = ((st_act & w_start) ? wr_e : ws_e);
    assign rb_j_n = ((st_act & w_start) ? st_j : ws_j);
    assign rb_ra_n = {rb_e_n, (st_f32 ? st_beat_n[2:1] : st_beat_n[1:0])};
    assign rb_lo_s_0 = (rb_jq_0 ? (rbz_16[rb_raq_0] ? 64'd0 : rbm_16[rb_raq_0]) :
                       (rbz_0[rb_raq_0] ? 64'd0 :
                       rbm_0[rb_raq_0]));
    assign rb_hi_s_0 = (rb_jq_8 ? (rbz_24[rb_raq_8] ? 64'd0 : rbm_24[rb_raq_8]) :
                       (rbz_8[rb_raq_8] ? 64'd0 :
                       rbm_8[rb_raq_8]));
    assign rb_lo_s_1 = (rb_jq_1 ? (rbz_17[rb_raq_1] ? 64'd0 : rbm_17[rb_raq_1]) :
                       (rbz_1[rb_raq_1] ? 64'd0 :
                       rbm_1[rb_raq_1]));
    assign rb_hi_s_1 = (rb_jq_9 ? (rbz_25[rb_raq_9] ? 64'd0 : rbm_25[rb_raq_9]) :
                       (rbz_9[rb_raq_9] ? 64'd0 :
                       rbm_9[rb_raq_9]));
    assign rb_lo_s_2 = (rb_jq_2 ? (rbz_18[rb_raq_2] ? 64'd0 : rbm_18[rb_raq_2]) :
                       (rbz_2[rb_raq_2] ? 64'd0 :
                       rbm_2[rb_raq_2]));
    assign rb_hi_s_2 = (rb_jq_10 ? (rbz_26[rb_raq_10] ? 64'd0 : rbm_26[rb_raq_10]) :
                       (rbz_10[rb_raq_10] ? 64'd0 :
                       rbm_10[rb_raq_10]));
    assign rb_lo_s_3 = (rb_jq_3 ? (rbz_19[rb_raq_3] ? 64'd0 : rbm_19[rb_raq_3]) :
                       (rbz_3[rb_raq_3] ? 64'd0 :
                       rbm_3[rb_raq_3]));
    assign rb_hi_s_3 = (rb_jq_11 ? (rbz_27[rb_raq_11] ? 64'd0 : rbm_27[rb_raq_11]) :
                       (rbz_11[rb_raq_11] ? 64'd0 :
                       rbm_11[rb_raq_11]));
    assign rb_lo_s_4 = (rb_jq_4 ? (rbz_20[rb_raq_4] ? 64'd0 : rbm_20[rb_raq_4]) :
                       (rbz_4[rb_raq_4] ? 64'd0 :
                       rbm_4[rb_raq_4]));
    assign rb_hi_s_4 = (rb_jq_12 ? (rbz_28[rb_raq_12] ? 64'd0 : rbm_28[rb_raq_12]) :
                       (rbz_12[rb_raq_12] ? 64'd0 :
                       rbm_12[rb_raq_12]));
    assign rb_lo_s_5 = (rb_jq_5 ? (rbz_21[rb_raq_5] ? 64'd0 : rbm_21[rb_raq_5]) :
                       (rbz_5[rb_raq_5] ? 64'd0 :
                       rbm_5[rb_raq_5]));
    assign rb_hi_s_5 = (rb_jq_13 ? (rbz_29[rb_raq_13] ? 64'd0 : rbm_29[rb_raq_13]) :
                       (rbz_13[rb_raq_13] ? 64'd0 :
                       rbm_13[rb_raq_13]));
    assign rb_lo_s_6 = (rb_jq_6 ? (rbz_22[rb_raq_6] ? 64'd0 : rbm_22[rb_raq_6]) :
                       (rbz_6[rb_raq_6] ? 64'd0 :
                       rbm_6[rb_raq_6]));
    assign rb_hi_s_6 = (rb_jq_14 ? (rbz_30[rb_raq_14] ? 64'd0 : rbm_30[rb_raq_14]) :
                       (rbz_14[rb_raq_14] ? 64'd0 :
                       rbm_14[rb_raq_14]));
    assign rb_lo_s_7 = (rb_jq_7 ? (rbz_23[rb_raq_7] ? 64'd0 : rbm_23[rb_raq_7]) :
                       (rbz_7[rb_raq_7] ? 64'd0 :
                       rbm_7[rb_raq_7]));
    assign rb_hi_s_7 = (rb_jq_15 ? (rbz_31[rb_raq_15] ? 64'd0 : rbm_31[rb_raq_15]) :
                       (rbz_15[rb_raq_15] ? 64'd0 :
                       rbm_15[rb_raq_15]));
    assign rb_lo = {rb_lo_s_7, rb_lo_s_6, rb_lo_s_5, rb_lo_s_4, rb_lo_s_3, rb_lo_s_2, rb_lo_s_1, rb_lo_s_0};
    assign rb_hi = {rb_hi_s_7, rb_hi_s_6, rb_hi_s_5, rb_hi_s_4, rb_hi_s_3, rb_hi_s_2, rb_hi_s_1, rb_hi_s_0};
    assign st_q16 = {rb_hi, rb_lo};
    assign b_hs = (st_act & (d_l3 ? noc_b_valid : l1_b_valid));
    assign st_fin = (((st_act & (~st_more)) & (~w_act)) & (st_bcnt == st_rows));
    assign st_use_l1 = (~d_l3);
    assign R16 = ({1'd0, f_rows} + 8'd15);
    assign st_nRow_c = R16[6:4];
    assign ntile_acc_c = (is_ast ? ({2'd0, st_nCol_c} * {3'd0, st_nRow_c}) : 6'd1);
    assign qm_sel = {st_nRow_c, st_nCol_c};
    assign qm_t_0 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd1 :
                       ((qm_sel == 18) ? 1'd1 :
                       ((qm_sel == 19) ? 1'd1 :
                       ((qm_sel == 20) ? 1'd1 :
                       ((qm_sel == 21) ? 1'd1 :
                       ((qm_sel == 22) ? 1'd1 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd1 :
                       ((qm_sel == 34) ? 1'd1 :
                       ((qm_sel == 35) ? 1'd1 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd1 :
                       ((qm_sel == 50) ? 1'd1 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd1 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd1 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd1 :
                       ((qm_sel == 94) ? 1'd1 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd1 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd1 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd1 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd1);
    assign qm_t_1 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd1 :
                       ((qm_sel == 19) ? 1'd1 :
                       ((qm_sel == 20) ? 1'd1 :
                       ((qm_sel == 21) ? 1'd1 :
                       ((qm_sel == 22) ? 1'd1 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd1 :
                       ((qm_sel == 34) ? 1'd1 :
                       ((qm_sel == 35) ? 1'd1 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd1 :
                       ((qm_sel == 50) ? 1'd1 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd1 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd1 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd1 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd1 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd1 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd1 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_2 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd1 :
                       ((qm_sel == 20) ? 1'd1 :
                       ((qm_sel == 21) ? 1'd1 :
                       ((qm_sel == 22) ? 1'd1 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd1 :
                       ((qm_sel == 35) ? 1'd1 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd1 :
                       ((qm_sel == 50) ? 1'd1 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd1 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd1 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd1 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd1 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd1 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_3 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd1 :
                       ((qm_sel == 21) ? 1'd1 :
                       ((qm_sel == 22) ? 1'd1 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd1 :
                       ((qm_sel == 35) ? 1'd1 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd1 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd1 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd1 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd1 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd1 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd1 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_4 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd0 :
                       ((qm_sel == 21) ? 1'd1 :
                       ((qm_sel == 22) ? 1'd1 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd0 :
                       ((qm_sel == 35) ? 1'd1 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd1 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd0 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd1 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd1 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd1 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd1 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_5 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd0 :
                       ((qm_sel == 21) ? 1'd0 :
                       ((qm_sel == 22) ? 1'd1 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd0 :
                       ((qm_sel == 35) ? 1'd1 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd1 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd0 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd0 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd1 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd1 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd1 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_6 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd0 :
                       ((qm_sel == 21) ? 1'd0 :
                       ((qm_sel == 22) ? 1'd0 :
                       ((qm_sel == 23) ? 1'd1 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd0 :
                       ((qm_sel == 35) ? 1'd0 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd0 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd0 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd0 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd0 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd0 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd1 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd0 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_7 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd0 :
                       ((qm_sel == 21) ? 1'd0 :
                       ((qm_sel == 22) ? 1'd0 :
                       ((qm_sel == 23) ? 1'd0 :
                       ((qm_sel == 24) ? 1'd1 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd0 :
                       ((qm_sel == 35) ? 1'd0 :
                       ((qm_sel == 36) ? 1'd1 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd0 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd0 :
                       ((qm_sel == 66) ? 1'd1 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd0 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd0 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd0 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd1 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd0 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd0 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_8 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd0 :
                       ((qm_sel == 21) ? 1'd0 :
                       ((qm_sel == 22) ? 1'd0 :
                       ((qm_sel == 23) ? 1'd0 :
                       ((qm_sel == 24) ? 1'd0 :
                       ((qm_sel == 25) ? 1'd1 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd0 :
                       ((qm_sel == 35) ? 1'd0 :
                       ((qm_sel == 36) ? 1'd0 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd0 :
                       ((qm_sel == 51) ? 1'd1 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd0 :
                       ((qm_sel == 66) ? 1'd0 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd0 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd0 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd0 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd0 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd0 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd0 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_9 = (is_ast
                     ? ((qm_sel == 0) ? 1'd0 :
                       ((qm_sel == 1) ? 1'd0 :
                       ((qm_sel == 2) ? 1'd0 :
                       ((qm_sel == 3) ? 1'd0 :
                       ((qm_sel == 4) ? 1'd0 :
                       ((qm_sel == 5) ? 1'd0 :
                       ((qm_sel == 6) ? 1'd0 :
                       ((qm_sel == 7) ? 1'd0 :
                       ((qm_sel == 8) ? 1'd0 :
                       ((qm_sel == 9) ? 1'd0 :
                       ((qm_sel == 10) ? 1'd0 :
                       ((qm_sel == 11) ? 1'd0 :
                       ((qm_sel == 12) ? 1'd0 :
                       ((qm_sel == 13) ? 1'd0 :
                       ((qm_sel == 14) ? 1'd0 :
                       ((qm_sel == 15) ? 1'd0 :
                       ((qm_sel == 16) ? 1'd0 :
                       ((qm_sel == 17) ? 1'd0 :
                       ((qm_sel == 18) ? 1'd0 :
                       ((qm_sel == 19) ? 1'd0 :
                       ((qm_sel == 20) ? 1'd0 :
                       ((qm_sel == 21) ? 1'd0 :
                       ((qm_sel == 22) ? 1'd0 :
                       ((qm_sel == 23) ? 1'd0 :
                       ((qm_sel == 24) ? 1'd0 :
                       ((qm_sel == 25) ? 1'd0 :
                       ((qm_sel == 26) ? 1'd1 :
                       ((qm_sel == 27) ? 1'd1 :
                       ((qm_sel == 28) ? 1'd1 :
                       ((qm_sel == 29) ? 1'd1 :
                       ((qm_sel == 30) ? 1'd1 :
                       ((qm_sel == 31) ? 1'd1 :
                       ((qm_sel == 32) ? 1'd0 :
                       ((qm_sel == 33) ? 1'd0 :
                       ((qm_sel == 34) ? 1'd0 :
                       ((qm_sel == 35) ? 1'd0 :
                       ((qm_sel == 36) ? 1'd0 :
                       ((qm_sel == 37) ? 1'd1 :
                       ((qm_sel == 38) ? 1'd1 :
                       ((qm_sel == 39) ? 1'd1 :
                       ((qm_sel == 40) ? 1'd1 :
                       ((qm_sel == 41) ? 1'd1 :
                       ((qm_sel == 42) ? 1'd1 :
                       ((qm_sel == 43) ? 1'd1 :
                       ((qm_sel == 44) ? 1'd1 :
                       ((qm_sel == 45) ? 1'd1 :
                       ((qm_sel == 46) ? 1'd1 :
                       ((qm_sel == 47) ? 1'd1 :
                       ((qm_sel == 48) ? 1'd0 :
                       ((qm_sel == 49) ? 1'd0 :
                       ((qm_sel == 50) ? 1'd0 :
                       ((qm_sel == 51) ? 1'd0 :
                       ((qm_sel == 52) ? 1'd1 :
                       ((qm_sel == 53) ? 1'd1 :
                       ((qm_sel == 54) ? 1'd1 :
                       ((qm_sel == 55) ? 1'd1 :
                       ((qm_sel == 56) ? 1'd1 :
                       ((qm_sel == 57) ? 1'd1 :
                       ((qm_sel == 58) ? 1'd1 :
                       ((qm_sel == 59) ? 1'd1 :
                       ((qm_sel == 60) ? 1'd1 :
                       ((qm_sel == 61) ? 1'd1 :
                       ((qm_sel == 62) ? 1'd1 :
                       ((qm_sel == 63) ? 1'd1 :
                       ((qm_sel == 64) ? 1'd0 :
                       ((qm_sel == 65) ? 1'd0 :
                       ((qm_sel == 66) ? 1'd0 :
                       ((qm_sel == 67) ? 1'd1 :
                       ((qm_sel == 68) ? 1'd1 :
                       ((qm_sel == 69) ? 1'd1 :
                       ((qm_sel == 70) ? 1'd1 :
                       ((qm_sel == 71) ? 1'd1 :
                       ((qm_sel == 72) ? 1'd1 :
                       ((qm_sel == 73) ? 1'd1 :
                       ((qm_sel == 74) ? 1'd1 :
                       ((qm_sel == 75) ? 1'd1 :
                       ((qm_sel == 76) ? 1'd1 :
                       ((qm_sel == 77) ? 1'd1 :
                       ((qm_sel == 78) ? 1'd1 :
                       ((qm_sel == 79) ? 1'd1 :
                       ((qm_sel == 80) ? 1'd0 :
                       ((qm_sel == 81) ? 1'd0 :
                       ((qm_sel == 82) ? 1'd1 :
                       ((qm_sel == 83) ? 1'd1 :
                       ((qm_sel == 84) ? 1'd1 :
                       ((qm_sel == 85) ? 1'd1 :
                       ((qm_sel == 86) ? 1'd1 :
                       ((qm_sel == 87) ? 1'd1 :
                       ((qm_sel == 88) ? 1'd1 :
                       ((qm_sel == 89) ? 1'd1 :
                       ((qm_sel == 90) ? 1'd1 :
                       ((qm_sel == 91) ? 1'd1 :
                       ((qm_sel == 92) ? 1'd1 :
                       ((qm_sel == 93) ? 1'd0 :
                       ((qm_sel == 94) ? 1'd0 :
                       ((qm_sel == 95) ? 1'd1 :
                       ((qm_sel == 96) ? 1'd0 :
                       ((qm_sel == 97) ? 1'd0 :
                       ((qm_sel == 98) ? 1'd1 :
                       ((qm_sel == 99) ? 1'd1 :
                       ((qm_sel == 100) ? 1'd1 :
                       ((qm_sel == 101) ? 1'd1 :
                       ((qm_sel == 102) ? 1'd1 :
                       ((qm_sel == 103) ? 1'd1 :
                       ((qm_sel == 104) ? 1'd1 :
                       ((qm_sel == 105) ? 1'd1 :
                       ((qm_sel == 106) ? 1'd1 :
                       ((qm_sel == 107) ? 1'd0 :
                       ((qm_sel == 108) ? 1'd0 :
                       ((qm_sel == 109) ? 1'd1 :
                       ((qm_sel == 110) ? 1'd1 :
                       ((qm_sel == 111) ? 1'd1 :
                       ((qm_sel == 112) ? 1'd0 :
                       ((qm_sel == 113) ? 1'd0 :
                       ((qm_sel == 114) ? 1'd1 :
                       ((qm_sel == 115) ? 1'd1 :
                       ((qm_sel == 116) ? 1'd1 :
                       ((qm_sel == 117) ? 1'd1 :
                       ((qm_sel == 118) ? 1'd1 :
                       ((qm_sel == 119) ? 1'd1 :
                       ((qm_sel == 120) ? 1'd1 :
                       ((qm_sel == 121) ? 1'd1 :
                       ((qm_sel == 122) ? 1'd0 :
                       ((qm_sel == 123) ? 1'd1 :
                       ((qm_sel == 124) ? 1'd1 :
                       ((qm_sel == 125) ? 1'd1 :
                       ((qm_sel == 126) ? 1'd1 :
                       1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                     :
                    1'd0);
    assign qm_t_10 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd1 :
                        ((qm_sel == 28) ? 1'd1 :
                        ((qm_sel == 29) ? 1'd1 :
                        ((qm_sel == 30) ? 1'd1 :
                        ((qm_sel == 31) ? 1'd1 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd1 :
                        ((qm_sel == 39) ? 1'd1 :
                        ((qm_sel == 40) ? 1'd1 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd1 :
                        ((qm_sel == 53) ? 1'd1 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd1 :
                        ((qm_sel == 68) ? 1'd1 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd1 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd1 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd1 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd1 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd1 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd1 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_11 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd1 :
                        ((qm_sel == 29) ? 1'd1 :
                        ((qm_sel == 30) ? 1'd1 :
                        ((qm_sel == 31) ? 1'd1 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd1 :
                        ((qm_sel == 39) ? 1'd1 :
                        ((qm_sel == 40) ? 1'd1 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd1 :
                        ((qm_sel == 53) ? 1'd1 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd1 :
                        ((qm_sel == 68) ? 1'd1 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd1 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd1 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd1 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd1 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd1 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_12 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd1 :
                        ((qm_sel == 30) ? 1'd1 :
                        ((qm_sel == 31) ? 1'd1 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd1 :
                        ((qm_sel == 40) ? 1'd1 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd1 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd1 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd1 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd1 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd1 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd1 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_13 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd1 :
                        ((qm_sel == 31) ? 1'd1 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd1 :
                        ((qm_sel == 40) ? 1'd1 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd1 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd1 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd1 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd1 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd1 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_14 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd1 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd1 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd1 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd1 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd1 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_15 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd1 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd1 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_16_c0 = ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd1 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd1 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd1 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign qm_t_16 = (is_ast ? qm_t_16_c0 : 1'd0);
    assign qm_t_17 = (is_ast ? qm_t_16_c0 : 1'd0);
    assign qm_t_18_c0 = ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd1 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd1 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd1 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd1 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd1 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign qm_t_18 = (is_ast ? qm_t_18_c0 : 1'd0);
    assign qm_t_19 = (is_ast ? qm_t_18_c0 : 1'd0);
    assign qm_t_20 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd1 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd1 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_21 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd1 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_22_c0 = ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd1 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd1 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd1 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd1 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign qm_t_22 = (is_ast ? qm_t_22_c0 : 1'd0);
    assign qm_t_23 = (is_ast ? qm_t_22_c0 : 1'd0);
    assign qm_t_24 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd0 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd0 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd0 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd1 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd0 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_25 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd0 :
                        ((qm_sel == 45) ? 1'd1 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd0 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd0 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd0 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd0 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd1 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_26 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd0 :
                        ((qm_sel == 45) ? 1'd0 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd0 :
                        ((qm_sel == 57) ? 1'd1 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd0 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd0 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd0 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd0 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd1 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_27 = (is_ast
                      ? ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd0 :
                        ((qm_sel == 45) ? 1'd0 :
                        ((qm_sel == 46) ? 1'd1 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd0 :
                        ((qm_sel == 57) ? 1'd0 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd0 :
                        ((qm_sel == 71) ? 1'd1 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd0 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd0 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd0 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd1 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd0 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
                      :
                     1'd0);
    assign qm_t_28_c0 = ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd0 :
                        ((qm_sel == 45) ? 1'd0 :
                        ((qm_sel == 46) ? 1'd0 :
                        ((qm_sel == 47) ? 1'd1 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd0 :
                        ((qm_sel == 57) ? 1'd0 :
                        ((qm_sel == 58) ? 1'd1 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd0 :
                        ((qm_sel == 71) ? 1'd0 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd0 :
                        ((qm_sel == 86) ? 1'd1 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd0 :
                        ((qm_sel == 101) ? 1'd1 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd0 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd0 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd0 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign qm_t_28 = (is_ast ? qm_t_28_c0 : 1'd0);
    assign qm_t_29 = (is_ast ? qm_t_28_c0 : 1'd0);
    assign qm_t_30_c0 = ((qm_sel == 0) ? 1'd0 :
                        ((qm_sel == 1) ? 1'd0 :
                        ((qm_sel == 2) ? 1'd0 :
                        ((qm_sel == 3) ? 1'd0 :
                        ((qm_sel == 4) ? 1'd0 :
                        ((qm_sel == 5) ? 1'd0 :
                        ((qm_sel == 6) ? 1'd0 :
                        ((qm_sel == 7) ? 1'd0 :
                        ((qm_sel == 8) ? 1'd0 :
                        ((qm_sel == 9) ? 1'd0 :
                        ((qm_sel == 10) ? 1'd0 :
                        ((qm_sel == 11) ? 1'd0 :
                        ((qm_sel == 12) ? 1'd0 :
                        ((qm_sel == 13) ? 1'd0 :
                        ((qm_sel == 14) ? 1'd0 :
                        ((qm_sel == 15) ? 1'd0 :
                        ((qm_sel == 16) ? 1'd0 :
                        ((qm_sel == 17) ? 1'd0 :
                        ((qm_sel == 18) ? 1'd0 :
                        ((qm_sel == 19) ? 1'd0 :
                        ((qm_sel == 20) ? 1'd0 :
                        ((qm_sel == 21) ? 1'd0 :
                        ((qm_sel == 22) ? 1'd0 :
                        ((qm_sel == 23) ? 1'd0 :
                        ((qm_sel == 24) ? 1'd0 :
                        ((qm_sel == 25) ? 1'd0 :
                        ((qm_sel == 26) ? 1'd0 :
                        ((qm_sel == 27) ? 1'd0 :
                        ((qm_sel == 28) ? 1'd0 :
                        ((qm_sel == 29) ? 1'd0 :
                        ((qm_sel == 30) ? 1'd0 :
                        ((qm_sel == 31) ? 1'd0 :
                        ((qm_sel == 32) ? 1'd0 :
                        ((qm_sel == 33) ? 1'd0 :
                        ((qm_sel == 34) ? 1'd0 :
                        ((qm_sel == 35) ? 1'd0 :
                        ((qm_sel == 36) ? 1'd0 :
                        ((qm_sel == 37) ? 1'd0 :
                        ((qm_sel == 38) ? 1'd0 :
                        ((qm_sel == 39) ? 1'd0 :
                        ((qm_sel == 40) ? 1'd0 :
                        ((qm_sel == 41) ? 1'd0 :
                        ((qm_sel == 42) ? 1'd0 :
                        ((qm_sel == 43) ? 1'd0 :
                        ((qm_sel == 44) ? 1'd0 :
                        ((qm_sel == 45) ? 1'd0 :
                        ((qm_sel == 46) ? 1'd0 :
                        ((qm_sel == 47) ? 1'd0 :
                        ((qm_sel == 48) ? 1'd0 :
                        ((qm_sel == 49) ? 1'd0 :
                        ((qm_sel == 50) ? 1'd0 :
                        ((qm_sel == 51) ? 1'd0 :
                        ((qm_sel == 52) ? 1'd0 :
                        ((qm_sel == 53) ? 1'd0 :
                        ((qm_sel == 54) ? 1'd0 :
                        ((qm_sel == 55) ? 1'd0 :
                        ((qm_sel == 56) ? 1'd0 :
                        ((qm_sel == 57) ? 1'd0 :
                        ((qm_sel == 58) ? 1'd0 :
                        ((qm_sel == 59) ? 1'd1 :
                        ((qm_sel == 60) ? 1'd1 :
                        ((qm_sel == 61) ? 1'd1 :
                        ((qm_sel == 62) ? 1'd1 :
                        ((qm_sel == 63) ? 1'd1 :
                        ((qm_sel == 64) ? 1'd0 :
                        ((qm_sel == 65) ? 1'd0 :
                        ((qm_sel == 66) ? 1'd0 :
                        ((qm_sel == 67) ? 1'd0 :
                        ((qm_sel == 68) ? 1'd0 :
                        ((qm_sel == 69) ? 1'd0 :
                        ((qm_sel == 70) ? 1'd0 :
                        ((qm_sel == 71) ? 1'd0 :
                        ((qm_sel == 72) ? 1'd1 :
                        ((qm_sel == 73) ? 1'd1 :
                        ((qm_sel == 74) ? 1'd1 :
                        ((qm_sel == 75) ? 1'd1 :
                        ((qm_sel == 76) ? 1'd1 :
                        ((qm_sel == 77) ? 1'd1 :
                        ((qm_sel == 78) ? 1'd1 :
                        ((qm_sel == 79) ? 1'd1 :
                        ((qm_sel == 80) ? 1'd0 :
                        ((qm_sel == 81) ? 1'd0 :
                        ((qm_sel == 82) ? 1'd0 :
                        ((qm_sel == 83) ? 1'd0 :
                        ((qm_sel == 84) ? 1'd0 :
                        ((qm_sel == 85) ? 1'd0 :
                        ((qm_sel == 86) ? 1'd0 :
                        ((qm_sel == 87) ? 1'd1 :
                        ((qm_sel == 88) ? 1'd1 :
                        ((qm_sel == 89) ? 1'd1 :
                        ((qm_sel == 90) ? 1'd1 :
                        ((qm_sel == 91) ? 1'd1 :
                        ((qm_sel == 92) ? 1'd1 :
                        ((qm_sel == 93) ? 1'd0 :
                        ((qm_sel == 94) ? 1'd0 :
                        ((qm_sel == 95) ? 1'd0 :
                        ((qm_sel == 96) ? 1'd0 :
                        ((qm_sel == 97) ? 1'd0 :
                        ((qm_sel == 98) ? 1'd0 :
                        ((qm_sel == 99) ? 1'd0 :
                        ((qm_sel == 100) ? 1'd0 :
                        ((qm_sel == 101) ? 1'd0 :
                        ((qm_sel == 102) ? 1'd1 :
                        ((qm_sel == 103) ? 1'd1 :
                        ((qm_sel == 104) ? 1'd1 :
                        ((qm_sel == 105) ? 1'd1 :
                        ((qm_sel == 106) ? 1'd1 :
                        ((qm_sel == 107) ? 1'd0 :
                        ((qm_sel == 108) ? 1'd0 :
                        ((qm_sel == 109) ? 1'd0 :
                        ((qm_sel == 110) ? 1'd0 :
                        ((qm_sel == 111) ? 1'd0 :
                        ((qm_sel == 112) ? 1'd0 :
                        ((qm_sel == 113) ? 1'd0 :
                        ((qm_sel == 114) ? 1'd0 :
                        ((qm_sel == 115) ? 1'd0 :
                        ((qm_sel == 116) ? 1'd0 :
                        ((qm_sel == 117) ? 1'd1 :
                        ((qm_sel == 118) ? 1'd1 :
                        ((qm_sel == 119) ? 1'd1 :
                        ((qm_sel == 120) ? 1'd1 :
                        ((qm_sel == 121) ? 1'd1 :
                        ((qm_sel == 122) ? 1'd0 :
                        ((qm_sel == 123) ? 1'd0 :
                        ((qm_sel == 124) ? 1'd0 :
                        ((qm_sel == 125) ? 1'd0 :
                        ((qm_sel == 126) ? 1'd1 :
                        1'd1)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
    assign qm_t_30 = (is_ast ? qm_t_30_c0 : 1'd0);
    assign qm_t_31 = (is_ast ? qm_t_30_c0 : 1'd0);
    assign qm_a_0 = ((f_acc_c[1:0] == 0) ? qm_t_0 :
                    ((f_acc_c[1:0] == 1) ? qm_t_31 :
                    ((f_acc_c[1:0] == 2) ? qm_t_30 :
                    qm_t_29)));
    assign qm_a_1 = ((f_acc_c[1:0] == 0) ? qm_t_1 :
                    ((f_acc_c[1:0] == 1) ? qm_t_0 :
                    ((f_acc_c[1:0] == 2) ? qm_t_31 :
                    qm_t_30)));
    assign qm_a_2 = ((f_acc_c[1:0] == 0) ? qm_t_2 :
                    ((f_acc_c[1:0] == 1) ? qm_t_1 :
                    ((f_acc_c[1:0] == 2) ? qm_t_0 :
                    qm_t_31)));
    assign qm_a_3 = ((f_acc_c[1:0] == 0) ? qm_t_3 :
                    ((f_acc_c[1:0] == 1) ? qm_t_2 :
                    ((f_acc_c[1:0] == 2) ? qm_t_1 :
                    qm_t_0)));
    assign qm_a_4 = ((f_acc_c[1:0] == 0) ? qm_t_4 :
                    ((f_acc_c[1:0] == 1) ? qm_t_3 :
                    ((f_acc_c[1:0] == 2) ? qm_t_2 :
                    qm_t_1)));
    assign qm_a_5 = ((f_acc_c[1:0] == 0) ? qm_t_5 :
                    ((f_acc_c[1:0] == 1) ? qm_t_4 :
                    ((f_acc_c[1:0] == 2) ? qm_t_3 :
                    qm_t_2)));
    assign qm_a_6 = ((f_acc_c[1:0] == 0) ? qm_t_6 :
                    ((f_acc_c[1:0] == 1) ? qm_t_5 :
                    ((f_acc_c[1:0] == 2) ? qm_t_4 :
                    qm_t_3)));
    assign qm_a_7 = ((f_acc_c[1:0] == 0) ? qm_t_7 :
                    ((f_acc_c[1:0] == 1) ? qm_t_6 :
                    ((f_acc_c[1:0] == 2) ? qm_t_5 :
                    qm_t_4)));
    assign qm_a_8 = ((f_acc_c[1:0] == 0) ? qm_t_8 :
                    ((f_acc_c[1:0] == 1) ? qm_t_7 :
                    ((f_acc_c[1:0] == 2) ? qm_t_6 :
                    qm_t_5)));
    assign qm_a_9 = ((f_acc_c[1:0] == 0) ? qm_t_9 :
                    ((f_acc_c[1:0] == 1) ? qm_t_8 :
                    ((f_acc_c[1:0] == 2) ? qm_t_7 :
                    qm_t_6)));
    assign qm_a_10 = ((f_acc_c[1:0] == 0) ? qm_t_10 :
                     ((f_acc_c[1:0] == 1) ? qm_t_9 :
                     ((f_acc_c[1:0] == 2) ? qm_t_8 :
                     qm_t_7)));
    assign qm_a_11 = ((f_acc_c[1:0] == 0) ? qm_t_11 :
                     ((f_acc_c[1:0] == 1) ? qm_t_10 :
                     ((f_acc_c[1:0] == 2) ? qm_t_9 :
                     qm_t_8)));
    assign qm_a_12 = ((f_acc_c[1:0] == 0) ? qm_t_12 :
                     ((f_acc_c[1:0] == 1) ? qm_t_11 :
                     ((f_acc_c[1:0] == 2) ? qm_t_10 :
                     qm_t_9)));
    assign qm_a_13 = ((f_acc_c[1:0] == 0) ? qm_t_13 :
                     ((f_acc_c[1:0] == 1) ? qm_t_12 :
                     ((f_acc_c[1:0] == 2) ? qm_t_11 :
                     qm_t_10)));
    assign qm_a_14 = ((f_acc_c[1:0] == 0) ? qm_t_14 :
                     ((f_acc_c[1:0] == 1) ? qm_t_13 :
                     ((f_acc_c[1:0] == 2) ? qm_t_12 :
                     qm_t_11)));
    assign qm_a_15 = ((f_acc_c[1:0] == 0) ? qm_t_15 :
                     ((f_acc_c[1:0] == 1) ? qm_t_14 :
                     ((f_acc_c[1:0] == 2) ? qm_t_13 :
                     qm_t_12)));
    assign qm_a_16 = ((f_acc_c[1:0] == 0) ? qm_t_16 :
                     ((f_acc_c[1:0] == 1) ? qm_t_15 :
                     ((f_acc_c[1:0] == 2) ? qm_t_14 :
                     qm_t_13)));
    assign qm_a_17 = ((f_acc_c[1:0] == 0) ? qm_t_17 :
                     ((f_acc_c[1:0] == 1) ? qm_t_16 :
                     ((f_acc_c[1:0] == 2) ? qm_t_15 :
                     qm_t_14)));
    assign qm_a_18 = ((f_acc_c[1:0] == 0) ? qm_t_18 :
                     ((f_acc_c[1:0] == 1) ? qm_t_17 :
                     ((f_acc_c[1:0] == 2) ? qm_t_16 :
                     qm_t_15)));
    assign qm_a_19 = ((f_acc_c[1:0] == 0) ? qm_t_19 :
                     ((f_acc_c[1:0] == 1) ? qm_t_18 :
                     ((f_acc_c[1:0] == 2) ? qm_t_17 :
                     qm_t_16)));
    assign qm_a_20 = ((f_acc_c[1:0] == 0) ? qm_t_20 :
                     ((f_acc_c[1:0] == 1) ? qm_t_19 :
                     ((f_acc_c[1:0] == 2) ? qm_t_18 :
                     qm_t_17)));
    assign qm_a_21 = ((f_acc_c[1:0] == 0) ? qm_t_21 :
                     ((f_acc_c[1:0] == 1) ? qm_t_20 :
                     ((f_acc_c[1:0] == 2) ? qm_t_19 :
                     qm_t_18)));
    assign qm_a_22 = ((f_acc_c[1:0] == 0) ? qm_t_22 :
                     ((f_acc_c[1:0] == 1) ? qm_t_21 :
                     ((f_acc_c[1:0] == 2) ? qm_t_20 :
                     qm_t_19)));
    assign qm_a_23 = ((f_acc_c[1:0] == 0) ? qm_t_23 :
                     ((f_acc_c[1:0] == 1) ? qm_t_22 :
                     ((f_acc_c[1:0] == 2) ? qm_t_21 :
                     qm_t_20)));
    assign qm_a_24 = ((f_acc_c[1:0] == 0) ? qm_t_24 :
                     ((f_acc_c[1:0] == 1) ? qm_t_23 :
                     ((f_acc_c[1:0] == 2) ? qm_t_22 :
                     qm_t_21)));
    assign qm_a_25 = ((f_acc_c[1:0] == 0) ? qm_t_25 :
                     ((f_acc_c[1:0] == 1) ? qm_t_24 :
                     ((f_acc_c[1:0] == 2) ? qm_t_23 :
                     qm_t_22)));
    assign qm_a_26 = ((f_acc_c[1:0] == 0) ? qm_t_26 :
                     ((f_acc_c[1:0] == 1) ? qm_t_25 :
                     ((f_acc_c[1:0] == 2) ? qm_t_24 :
                     qm_t_23)));
    assign qm_a_27 = ((f_acc_c[1:0] == 0) ? qm_t_27 :
                     ((f_acc_c[1:0] == 1) ? qm_t_26 :
                     ((f_acc_c[1:0] == 2) ? qm_t_25 :
                     qm_t_24)));
    assign qm_a_28 = ((f_acc_c[1:0] == 0) ? qm_t_28 :
                     ((f_acc_c[1:0] == 1) ? qm_t_27 :
                     ((f_acc_c[1:0] == 2) ? qm_t_26 :
                     qm_t_25)));
    assign qm_a_29 = ((f_acc_c[1:0] == 0) ? qm_t_29 :
                     ((f_acc_c[1:0] == 1) ? qm_t_28 :
                     ((f_acc_c[1:0] == 2) ? qm_t_27 :
                     qm_t_26)));
    assign qm_a_30 = ((f_acc_c[1:0] == 0) ? qm_t_30 :
                     ((f_acc_c[1:0] == 1) ? qm_t_29 :
                     ((f_acc_c[1:0] == 2) ? qm_t_28 :
                     qm_t_27)));
    assign qm_a_31 = ((f_acc_c[1:0] == 0) ? qm_t_31 :
                     ((f_acc_c[1:0] == 1) ? qm_t_30 :
                     ((f_acc_c[1:0] == 2) ? qm_t_29 :
                     qm_t_28)));
    assign qm_b_0 = ((f_acc_c[3:2] == 0) ? qm_a_0 :
                    ((f_acc_c[3:2] == 1) ? qm_a_28 :
                    ((f_acc_c[3:2] == 2) ? qm_a_24 :
                    qm_a_20)));
    assign qm_b_1 = ((f_acc_c[3:2] == 0) ? qm_a_1 :
                    ((f_acc_c[3:2] == 1) ? qm_a_29 :
                    ((f_acc_c[3:2] == 2) ? qm_a_25 :
                    qm_a_21)));
    assign qm_b_2 = ((f_acc_c[3:2] == 0) ? qm_a_2 :
                    ((f_acc_c[3:2] == 1) ? qm_a_30 :
                    ((f_acc_c[3:2] == 2) ? qm_a_26 :
                    qm_a_22)));
    assign qm_b_3 = ((f_acc_c[3:2] == 0) ? qm_a_3 :
                    ((f_acc_c[3:2] == 1) ? qm_a_31 :
                    ((f_acc_c[3:2] == 2) ? qm_a_27 :
                    qm_a_23)));
    assign qm_b_4 = ((f_acc_c[3:2] == 0) ? qm_a_4 :
                    ((f_acc_c[3:2] == 1) ? qm_a_0 :
                    ((f_acc_c[3:2] == 2) ? qm_a_28 :
                    qm_a_24)));
    assign qm_b_5 = ((f_acc_c[3:2] == 0) ? qm_a_5 :
                    ((f_acc_c[3:2] == 1) ? qm_a_1 :
                    ((f_acc_c[3:2] == 2) ? qm_a_29 :
                    qm_a_25)));
    assign qm_b_6 = ((f_acc_c[3:2] == 0) ? qm_a_6 :
                    ((f_acc_c[3:2] == 1) ? qm_a_2 :
                    ((f_acc_c[3:2] == 2) ? qm_a_30 :
                    qm_a_26)));
    assign qm_b_7 = ((f_acc_c[3:2] == 0) ? qm_a_7 :
                    ((f_acc_c[3:2] == 1) ? qm_a_3 :
                    ((f_acc_c[3:2] == 2) ? qm_a_31 :
                    qm_a_27)));
    assign qm_b_8 = ((f_acc_c[3:2] == 0) ? qm_a_8 :
                    ((f_acc_c[3:2] == 1) ? qm_a_4 :
                    ((f_acc_c[3:2] == 2) ? qm_a_0 :
                    qm_a_28)));
    assign qm_b_9 = ((f_acc_c[3:2] == 0) ? qm_a_9 :
                    ((f_acc_c[3:2] == 1) ? qm_a_5 :
                    ((f_acc_c[3:2] == 2) ? qm_a_1 :
                    qm_a_29)));
    assign qm_b_10 = ((f_acc_c[3:2] == 0) ? qm_a_10 :
                     ((f_acc_c[3:2] == 1) ? qm_a_6 :
                     ((f_acc_c[3:2] == 2) ? qm_a_2 :
                     qm_a_30)));
    assign qm_b_11 = ((f_acc_c[3:2] == 0) ? qm_a_11 :
                     ((f_acc_c[3:2] == 1) ? qm_a_7 :
                     ((f_acc_c[3:2] == 2) ? qm_a_3 :
                     qm_a_31)));
    assign qm_b_12 = ((f_acc_c[3:2] == 0) ? qm_a_12 :
                     ((f_acc_c[3:2] == 1) ? qm_a_8 :
                     ((f_acc_c[3:2] == 2) ? qm_a_4 :
                     qm_a_0)));
    assign qm_b_13 = ((f_acc_c[3:2] == 0) ? qm_a_13 :
                     ((f_acc_c[3:2] == 1) ? qm_a_9 :
                     ((f_acc_c[3:2] == 2) ? qm_a_5 :
                     qm_a_1)));
    assign qm_b_14 = ((f_acc_c[3:2] == 0) ? qm_a_14 :
                     ((f_acc_c[3:2] == 1) ? qm_a_10 :
                     ((f_acc_c[3:2] == 2) ? qm_a_6 :
                     qm_a_2)));
    assign qm_b_15 = ((f_acc_c[3:2] == 0) ? qm_a_15 :
                     ((f_acc_c[3:2] == 1) ? qm_a_11 :
                     ((f_acc_c[3:2] == 2) ? qm_a_7 :
                     qm_a_3)));
    assign qm_b_16 = ((f_acc_c[3:2] == 0) ? qm_a_16 :
                     ((f_acc_c[3:2] == 1) ? qm_a_12 :
                     ((f_acc_c[3:2] == 2) ? qm_a_8 :
                     qm_a_4)));
    assign qm_b_17 = ((f_acc_c[3:2] == 0) ? qm_a_17 :
                     ((f_acc_c[3:2] == 1) ? qm_a_13 :
                     ((f_acc_c[3:2] == 2) ? qm_a_9 :
                     qm_a_5)));
    assign qm_b_18 = ((f_acc_c[3:2] == 0) ? qm_a_18 :
                     ((f_acc_c[3:2] == 1) ? qm_a_14 :
                     ((f_acc_c[3:2] == 2) ? qm_a_10 :
                     qm_a_6)));
    assign qm_b_19 = ((f_acc_c[3:2] == 0) ? qm_a_19 :
                     ((f_acc_c[3:2] == 1) ? qm_a_15 :
                     ((f_acc_c[3:2] == 2) ? qm_a_11 :
                     qm_a_7)));
    assign qm_b_20 = ((f_acc_c[3:2] == 0) ? qm_a_20 :
                     ((f_acc_c[3:2] == 1) ? qm_a_16 :
                     ((f_acc_c[3:2] == 2) ? qm_a_12 :
                     qm_a_8)));
    assign qm_b_21 = ((f_acc_c[3:2] == 0) ? qm_a_21 :
                     ((f_acc_c[3:2] == 1) ? qm_a_17 :
                     ((f_acc_c[3:2] == 2) ? qm_a_13 :
                     qm_a_9)));
    assign qm_b_22 = ((f_acc_c[3:2] == 0) ? qm_a_22 :
                     ((f_acc_c[3:2] == 1) ? qm_a_18 :
                     ((f_acc_c[3:2] == 2) ? qm_a_14 :
                     qm_a_10)));
    assign qm_b_23 = ((f_acc_c[3:2] == 0) ? qm_a_23 :
                     ((f_acc_c[3:2] == 1) ? qm_a_19 :
                     ((f_acc_c[3:2] == 2) ? qm_a_15 :
                     qm_a_11)));
    assign qm_b_24 = ((f_acc_c[3:2] == 0) ? qm_a_24 :
                     ((f_acc_c[3:2] == 1) ? qm_a_20 :
                     ((f_acc_c[3:2] == 2) ? qm_a_16 :
                     qm_a_12)));
    assign qm_b_25 = ((f_acc_c[3:2] == 0) ? qm_a_25 :
                     ((f_acc_c[3:2] == 1) ? qm_a_21 :
                     ((f_acc_c[3:2] == 2) ? qm_a_17 :
                     qm_a_13)));
    assign qm_b_26 = ((f_acc_c[3:2] == 0) ? qm_a_26 :
                     ((f_acc_c[3:2] == 1) ? qm_a_22 :
                     ((f_acc_c[3:2] == 2) ? qm_a_18 :
                     qm_a_14)));
    assign qm_b_27 = ((f_acc_c[3:2] == 0) ? qm_a_27 :
                     ((f_acc_c[3:2] == 1) ? qm_a_23 :
                     ((f_acc_c[3:2] == 2) ? qm_a_19 :
                     qm_a_15)));
    assign qm_b_28 = ((f_acc_c[3:2] == 0) ? qm_a_28 :
                     ((f_acc_c[3:2] == 1) ? qm_a_24 :
                     ((f_acc_c[3:2] == 2) ? qm_a_20 :
                     qm_a_16)));
    assign qm_b_29 = ((f_acc_c[3:2] == 0) ? qm_a_29 :
                     ((f_acc_c[3:2] == 1) ? qm_a_25 :
                     ((f_acc_c[3:2] == 2) ? qm_a_21 :
                     qm_a_17)));
    assign qm_b_30 = ((f_acc_c[3:2] == 0) ? qm_a_30 :
                     ((f_acc_c[3:2] == 1) ? qm_a_26 :
                     ((f_acc_c[3:2] == 2) ? qm_a_22 :
                     qm_a_18)));
    assign qm_b_31 = ((f_acc_c[3:2] == 0) ? qm_a_31 :
                     ((f_acc_c[3:2] == 1) ? qm_a_27 :
                     ((f_acc_c[3:2] == 2) ? qm_a_23 :
                     qm_a_19)));
    assign qm_r_0 = (f_acc_c[4] ? qm_b_16 : qm_b_0);
    assign qm_r_1 = (f_acc_c[4] ? qm_b_17 : qm_b_1);
    assign qm_r_2 = (f_acc_c[4] ? qm_b_18 : qm_b_2);
    assign qm_r_3 = (f_acc_c[4] ? qm_b_19 : qm_b_3);
    assign qm_r_4 = (f_acc_c[4] ? qm_b_20 : qm_b_4);
    assign qm_r_5 = (f_acc_c[4] ? qm_b_21 : qm_b_5);
    assign qm_r_6 = (f_acc_c[4] ? qm_b_22 : qm_b_6);
    assign qm_r_7 = (f_acc_c[4] ? qm_b_23 : qm_b_7);
    assign qm_r_8 = (f_acc_c[4] ? qm_b_24 : qm_b_8);
    assign qm_r_9 = (f_acc_c[4] ? qm_b_25 : qm_b_9);
    assign qm_r_10 = (f_acc_c[4] ? qm_b_26 : qm_b_10);
    assign qm_r_11 = (f_acc_c[4] ? qm_b_27 : qm_b_11);
    assign qm_r_12 = (f_acc_c[4] ? qm_b_28 : qm_b_12);
    assign qm_r_13 = (f_acc_c[4] ? qm_b_29 : qm_b_13);
    assign qm_r_14 = (f_acc_c[4] ? qm_b_30 : qm_b_14);
    assign qm_r_15 = (f_acc_c[4] ? qm_b_31 : qm_b_15);
    assign qm_r_16 = (f_acc_c[4] ? qm_b_0 : qm_b_16);
    assign qm_r_17 = (f_acc_c[4] ? qm_b_1 : qm_b_17);
    assign qm_r_18 = (f_acc_c[4] ? qm_b_2 : qm_b_18);
    assign qm_r_19 = (f_acc_c[4] ? qm_b_3 : qm_b_19);
    assign qm_r_20 = (f_acc_c[4] ? qm_b_4 : qm_b_20);
    assign qm_r_21 = (f_acc_c[4] ? qm_b_5 : qm_b_21);
    assign qm_r_22 = (f_acc_c[4] ? qm_b_6 : qm_b_22);
    assign qm_r_23 = (f_acc_c[4] ? qm_b_7 : qm_b_23);
    assign qm_r_24 = (f_acc_c[4] ? qm_b_8 : qm_b_24);
    assign qm_r_25 = (f_acc_c[4] ? qm_b_9 : qm_b_25);
    assign qm_r_26 = (f_acc_c[4] ? qm_b_10 : qm_b_26);
    assign qm_r_27 = (f_acc_c[4] ? qm_b_11 : qm_b_27);
    assign qm_r_28 = (f_acc_c[4] ? qm_b_12 : qm_b_28);
    assign qm_r_29 = (f_acc_c[4] ? qm_b_13 : qm_b_29);
    assign qm_r_30 = (f_acc_c[4] ? qm_b_14 : qm_b_30);
    assign qm_r_31 = (f_acc_c[4] ? qm_b_15 : qm_b_31);
    assign qmask_c = {qm_r_31, qm_r_30, qm_r_29, qm_r_28, qm_r_27, qm_r_26, qm_r_25, qm_r_24, qm_r_23, qm_r_22, qm_r_21,
                      qm_r_20, qm_r_19, qm_r_18, qm_r_17, qm_r_16, qm_r_15, qm_r_14, qm_r_13, qm_r_12, qm_r_11, qm_r_10,
                      qm_r_9, qm_r_8, qm_r_7, qm_r_6, qm_r_5, qm_r_4, qm_r_3, qm_r_2, qm_r_1, qm_r_0};
    assign st_endt_c = ({1'd0, f_acc_c} + {1'd0, ntile_acc_c});
    assign ab_endt_c = ({1'd0, f_acc} + {1'd0, ntile});
    assign jd_ahit = ((jd_act & ({1'd0, f_acc} < jd_endt)) & ({1'd0, jd_acc} < st_endt));
    assign jp_ahit = ((jp_v & ({1'd0, f_acc} < jp_endt)) & ({1'd0, jp_acc} < st_endt));
    assign sc_endt_c = ({1'd0, f_acc_c} + {1'd0, (is_mma ? ntile_c : ntile_acc_c)});
    assign sc_ahit = ((sc_act & ({1'd0, sc_acc} >= {1'd0, f_acc})) & ({1'd0, sc_acc} < sc_endt));
    assign acc_over = ((((state != S_IDLE) & (state != S_DEC)) & (((is_mma | is_ast) | is_asc) | is_aclr))
                       & (sc_endt > 7'd32));
    assign sb_hit = ((((((u_arr_qbusy | jd_ahit) | jp_ahit) | job_v) | jv_d1) | jv_d2) | sc_ahit);
    assign st_zs = st_ra_slot[4:0];
    assign ra_z_n = ((((state == S_CL_WAIT) & (~sb_hit)) & (f_acc[4:0] == st_zs)) ? 1'd1 :
                    ((dr_valid & (dr_slot[4:0] == st_zs)) ? 1'd0 :
                    zf[st_zs]));
    assign fe_idle = (((((((state == S_IDLE) & (~kern_act)) & (~ld_v)) & (cq_wp == cq_rp)) & (~jd_act)) & (~jp_v))
                      & dq_empty);
    assign flush_c = (((fe_idle | (state == S_ST_WAIT)) | (state == S_SC_WAIT)) | (state == S_CL_WAIT));
    assign nfl_w = ((((3'd0 + {2'd0, ift_v[0]}) + {2'd0, ift_v[1]}) + {2'd0, ift_v[2]}) + {2'd0, ift_v[3]});
    assign dq_n = dq_nq;
    assign dq_full = dq_n[4];
    assign dq_empty = dq_eq;
    assign dqh_ins = dq_ins[dq_ri];
    assign dqh_av = dq_av[dq_ri];
    assign dqh_bv = dq_bv[dq_ri];
    assign dqh_prog = dq_prog[dq_ri];
    assign dqh_pf = dq_pf[dq_ri];
    assign dq_pop = ((idle0 & (~dq_empty)) & ((nfl_w < 4) | dqh_pf));
    assign dq_byp = (((kw_take & dq_empty) & idle0) & (nfl_w < 4));
    assign dq_cq = ((((idle0 & (~dq_pop)) & (~dq_byp)) & (cq_n != 0)) & (nfl_w < 4));
    assign ift_take = (((dq_pop & (~dqh_pf)) | dq_byp) | dq_cq);
    assign seq_due_c = (~sdq[15]);
    assign idle0 = (state == 0);
    assign kw_rdy = ((~dq_full) & seq_due_c);
    assign lc_go = (ld_v & kw_lcrdy);
    assign kw_va = w_ins[18:13];
    assign kw_vb = w_ins[64:59];
    assign w_ins = u_kw_out_inst;
    assign kw_lcrdy = u_kw_lc_ready;
    assign kern_act = u_kw_busy;
    assign kw_take = (kw_rdy & u_kw_out_v);
    assign dq_push = (kw_take & (~dq_byp));
    assign dq_nn = ((dq_nq + {4'd0, dq_push}) - {4'd0, dq_pop});
    assign rd_a = u_kw_im_addr[9:0];
    assign fs_idx = ((~ift_v[0]) ? 2'd0 : ((~ift_v[1]) ? 2'd1 : ((~ift_v[2]) ? 2'd2 : ((~ift_v[3]) ? 2'd3 : 2'd0))));
    assign rt_rdy_c0 = ((ift_v[0] & ift_fin[0]) & (ift_nd_0 == 0));
    assign rt_rdy_c1 = ((ift_v[1] & ift_fin[1]) & (ift_nd_1 == 0));
    assign rt_rdy_c2 = ((ift_v[2] & ift_fin[2]) & (ift_nd_2 == 0));
    assign rt_rdy_c3 = ((ift_v[3] & ift_fin[3]) & (ift_nd_3 == 0));
    assign rt_rdy = ((((1'd0 | rt_rdy_c0) | rt_rdy_c1) | rt_rdy_c2) | rt_rdy_c3);
    assign rt_idx = (rt_rdy_c0 ? 2'd0 : (rt_rdy_c1 ? 2'd1 : (rt_rdy_c2 ? 2'd2 : (rt_rdy_c3 ? 2'd3 : 2'd0))));
    assign cq_n = (cq_wp - cq_rp);
    assign issue_ready = (issue_is_launch ? (lq_n < 4) : (cq_n < 4));
    assign dbg_busy = busy_r;
    assign dbg_idle = ((~busy_r) & (cq_n == 0));
    assign dbg_retire = retire_p;
    assign dbg_donec = donec;
    assign dbg_occ = {2'd0, nfl_w};
    assign dbg_acc_occ = u_arr_acc_occ;
    assign dbg_badacc = badacc;
    assign cred_l1_ok = (cred_l1 != 0);
    assign cred_nc_ok = (cred_llc != 0);
    assign sc_ar = ((state == S_SC_AR) | ((state == S_SC_WAIT) & (~sb_hit)));
    assign sc_addr = d_base;
    assign sc_span = ({3'd0, sc_addr[6:0]} + 10'd191);
    assign wl1_sc = sc_ar;
    assign wl1_a = u_lda_ar_req;
    assign wl1_b = u_ldb_ar_req;
    assign l1_pa = ((wl1_a & (~wl1_sc)) & ((~wl1_b) | (~arb_rr)));
    assign l1_pb = ((wl1_b & (~wl1_sc)) & ((~wl1_a) | arb_rr));
    assign l1ar_go = ((((wl1_sc | l1_pa) | l1_pb) & cred_l1_ok) & (~(aw_go & st_use_l1)));
    assign l1ar_addr = (wl1_sc ? sc_addr : (l1_pa ? u_lda_ar_addr : u_ldb_ar_addr));
    assign l1ar_bytes = (wl1_sc ? 20'd64 : (l1_pa ? u_lda_ar_bytes : u_ldb_ar_bytes));
    assign l1ar_cfg = (wl1_sc ? d_cfg : (l1_pa ? u_lda_ar_cfg : u_ldb_ar_cfg));
    assign l1ar_first = (wl1_sc ? 1'd1 : (l1_pa ? u_lda_ar_first : u_ldb_ar_first));
    assign l1ar_last = (wl1_sc ? 1'd1 : (l1_pa ? u_lda_ar_last : u_ldb_ar_last));
    assign l1_ar_valid = l1ar_go;
    assign l1_ar_off = l1ar_addr[19:0];
    assign l1_ar_cfg = l1ar_cfg;
    assign l1_ar_bytes = l1ar_bytes;
    assign l1_ar_rows = 16'd1;
    assign l1_ar_stride = 20'd0;
    assign l1_ar_first = l1ar_first;
    assign l1_ar_last = l1ar_last;
    assign l1_ar_id = 4'd0;
    assign noc_ar_valid = 1'd0;
    assign noc_ar_addr = 48'd0;
    assign noc_ar_bytes = 20'd0;
    assign noc_ar_rows = 16'd0;
    assign noc_ar_stride = 20'd0;
    assign noc_ar_first = 1'd0;
    assign noc_ar_last = 1'd0;
    assign noc_ar_id = 4'd0;
    assign noc_ar_tag = 16'd0;
    assign tag_a = {12'd0, {2'd0, u_lda_slot_q}};
    assign tag_b = {12'd0, {2'd1, u_ldb_slot_q}};
    assign tag_sc = {12'd0, {2'd2, cur_slot}};
    assign l1_ar_tag = (wl1_sc ? tag_sc : (l1_pa ? tag_a : tag_b));
    assign l1ar_fire = (l1ar_go & l1_ar_ready);
    assign lda_gnt = (l1_pa & l1ar_fire);
    assign ldb_gnt = (l1_pb & l1ar_fire);
    assign sc_gnt = (wl1_sc & l1ar_fire);
    assign l1_rt = l1_r_tag[3:2];
    assign l1_r_ready = (((l1_rt == 0) | (l1_rt == 1)) | ((l1_rt == 2) & sc_rd_q));
    assign noc_r_ready = 1'd0;
    assign lda_rv = (l1_r_valid & (l1_rt == 0));
    assign ldb_rv = (l1_r_valid & (l1_rt == 1));
    assign lda_rd = l1_r_data;
    assign ldb_rd = l1_r_data;
    assign sc_rv = (l1_r_valid & (l1_rt == 2));
    assign rd_beat = l1_r_data;
    assign aw_go = (aw_req & (d_l3 ? cred_nc_ok : cred_l1_ok));
    assign aw_first = (aw_cnt == 0);
    assign aw_last = ((aw_cnt + 7'd1) == st_rows);
    assign l1_aw_valid = (aw_go & st_use_l1);
    assign noc_aw_valid = (aw_go & d_l3);
    assign l1_aw_off = aw_addr_c[19:0];
    assign noc_aw_addr = aw_addr_c;
    assign l1_aw_cfg = d_cfg;
    assign l1_aw_id = 4'd0;
    assign noc_aw_id = 4'd0;
    assign l1_aw_tag = tag_sc;
    assign noc_aw_tag = tag_sc;
    assign l1_aw_bytes = {8'd0, f_bpr};
    assign noc_aw_bytes = {8'd0, f_bpr};
    assign l1_aw_rows = 16'd1;
    assign noc_aw_rows = 16'd1;
    assign l1_aw_stride = 20'd0;
    assign noc_aw_stride = 20'd0;
    assign l1_aw_first = aw_first;
    assign noc_aw_first = aw_first;
    assign l1_aw_last = aw_last;
    assign noc_aw_last = aw_last;
    assign l1_w_valid = (oq_v & (~oq_l3));
    assign noc_w_valid = (oq_v & oq_l3);
    assign l1_w_id = 4'd0;
    assign noc_w_id = 4'd0;
    assign l1_w_data = oq_dat;
    assign noc_w_data = oq_dat;
    assign l1_w_strb = oq_stb;
    assign noc_w_strb = oq_stb;
    assign l1_b_ready = (st_act & st_use_l1);
    assign noc_b_ready = (st_act & d_l3);
    assign row = isram_waddr[11:2];
    assign lane = isram_waddr[1:0];
    assign lq_push = ((issue_valid & issue_is_launch) & (lq_n < 4));
    assign l1_dec = (l1ar_fire | (aw_hs & st_use_l1));
    assign nc_dec = (aw_hs & d_l3);
    assign a_fin = u_lda_done_p;
    assign b_fin = u_ldb_done_p;
    assign sc_fin = (((state == S_SC_RD) & sc_rv) & (lbeat == (lnbeat - 2'd1)));
    assign st_fin_p = st_fin;
    assign nd_dec__i0 = (({1'd0, (a_fin & (u_lda_done_slot == 0))} + {1'd0, (b_fin & (u_ldb_done_slot == 0))})
                         + {1'd0, ((sc_fin | st_fin_p) & (cur_slot == 0))});
    assign nd_dec__i1 = (({1'd0, (a_fin & (u_lda_done_slot == 1))} + {1'd0, (b_fin & (u_ldb_done_slot == 1))})
                         + {1'd0, ((sc_fin | st_fin_p) & (cur_slot == 1))});
    assign nd_dec__i2 = (({1'd0, (a_fin & (u_lda_done_slot == 2))} + {1'd0, (b_fin & (u_ldb_done_slot == 2))})
                         + {1'd0, ((sc_fin | st_fin_p) & (cur_slot == 2))});
    assign nd_dec__i3 = (({1'd0, (a_fin & (u_lda_done_slot == 3))} + {1'd0, (b_fin & (u_ldb_done_slot == 3))})
                         + {1'd0, ((sc_fin | st_fin_p) & (cur_slot == 3))});
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            retire_p <= 0;
            lda_start <= 0;
            ldb_start <= 0;
            ldb_start_p <= 0;
            jv_d1 <= 0;
            jv_d2 <= 0;
            job_v <= 0;
            flush_q <= 0;
            badacc <= 0;
            rd_q <= 0;
            lq_wp <= 0;
            lq_rp <= 0;
            lq_n <= 0;
            cq_wp <= 0;
            cred_l1 <= 4;
            cred_llc <= 4;
            ift_nd_0 <= 0;
            ift_nd_1 <= 0;
            ift_nd_2 <= 0;
            ift_nd_3 <= 0;
            ra_zq <= 0;
            zf_c_0 <= 0;
            zf_c_1 <= 0;
            zf_c_2 <= 0;
            zf_c_3 <= 0;
            zf_c_4 <= 0;
            zf_c_5 <= 0;
            zf_c_6 <= 0;
            zf_c_7 <= 0;
            zf_c_8 <= 0;
            zf_c_9 <= 0;
            zf_c_10 <= 0;
            zf_c_11 <= 0;
            zf_c_12 <= 0;
            zf_c_13 <= 0;
            zf_c_14 <= 0;
            zf_c_15 <= 0;
            zf_c_16 <= 0;
            zf_c_17 <= 0;
            zf_c_18 <= 0;
            zf_c_19 <= 0;
            zf_c_20 <= 0;
            zf_c_21 <= 0;
            zf_c_22 <= 0;
            zf_c_23 <= 0;
            zf_c_24 <= 0;
            zf_c_25 <= 0;
            zf_c_26 <= 0;
            zf_c_27 <= 0;
            zf_c_28 <= 0;
            zf_c_29 <= 0;
            zf_c_30 <= 0;
            zf_c_31 <= 0;
            pl_zero_q <= 0;
            ift_v_c_0 <= 0;
            ift_v_c_1 <= 0;
            ift_v_c_2 <= 0;
            ift_v_c_3 <= 0;
            donec <= 0;
            busy_r <= 0;
            job_w <= 0;
            ift_fin_c_0 <= 0;
            ift_fin_c_1 <= 0;
            ift_fin_c_2 <= 0;
            ift_fin_c_3 <= 0;
            jd_act <= 0;
            jleg <= 0;
            jni <= 0;
            jmi <= 0;
            jdd <= 0;
            jd_rows <= 0;
            jd_bavail <= 0;
            jp_v <= 0;
            jd_acc <= 0;
            jd_endt <= 0;
            jd_M <= 0;
            jd_N <= 0;
            jd_ncol <= 0;
            jd_nrow <= 0;
            jd_kmj <= 0;
            jd_accum <= 0;
            jd_aset <= 0;
            jd_bset <= 0;
            jd_tag <= 0;
            jd_arl <= 0;
            jd_bseq <= 0;
            jd_btot <= 0;
            arb_rr <= 0;
            aw_cnt <= 0;
            aw_pend <= 0;
            aw_sel_done <= 0;
            st_beat <= 0;
            mq_v <= 0;
            oq_v <= 0;
            oq_l3 <= 0;
            w_act <= 0;
            rb_v1 <= 0;
            rb_v0 <= 0;
            st_bcnt <= 0;
            st_nbeat <= 0;
            ws_e <= 0;
            ws_j <= 0;
            st_j <= 0;
            st_rpf <= 0;
            wr_e <= 0;
            rbq_we_0 <= 0;
            rbq_we_1 <= 0;
            rbq_we_2 <= 0;
            rbq_we_3 <= 0;
            rbq_we_4 <= 0;
            rbq_we_5 <= 0;
            rbq_we_6 <= 0;
            rbq_we_7 <= 0;
            rbq_we_8 <= 0;
            rbq_we_9 <= 0;
            rbq_we_10 <= 0;
            rbq_we_11 <= 0;
            rbq_we_12 <= 0;
            rbq_we_13 <= 0;
            rbq_we_14 <= 0;
            rbq_we_15 <= 0;
            rbq_we_16 <= 0;
            rbq_we_17 <= 0;
            rbq_we_18 <= 0;
            rbq_we_19 <= 0;
            rbq_we_20 <= 0;
            rbq_we_21 <= 0;
            rbq_we_22 <= 0;
            rbq_we_23 <= 0;
            rbq_we_24 <= 0;
            rbq_we_25 <= 0;
            rbq_we_26 <= 0;
            rbq_we_27 <= 0;
            rbq_we_28 <= 0;
            rbq_we_29 <= 0;
            rbq_we_30 <= 0;
            rbq_we_31 <= 0;
            st_ti <= 0;
            sr_st <= 0;
            sr_e <= 0;
            sr_rpf <= 0;
            dq_nq <= 0;
            dq_eq <= 1;
            kprog <= 0;
            dq_mma_0 <= 0;
            dq_pf_c_0 <= 0;
            dq_mma_1 <= 0;
            dq_pf_c_1 <= 0;
            dq_mma_2 <= 0;
            dq_pf_c_2 <= 0;
            dq_mma_3 <= 0;
            dq_pf_c_3 <= 0;
            dq_mma_4 <= 0;
            dq_pf_c_4 <= 0;
            dq_mma_5 <= 0;
            dq_pf_c_5 <= 0;
            dq_mma_6 <= 0;
            dq_pf_c_6 <= 0;
            dq_mma_7 <= 0;
            dq_pf_c_7 <= 0;
            dq_mma_8 <= 0;
            dq_pf_c_8 <= 0;
            dq_mma_9 <= 0;
            dq_pf_c_9 <= 0;
            dq_mma_10 <= 0;
            dq_pf_c_10 <= 0;
            dq_mma_11 <= 0;
            dq_pf_c_11 <= 0;
            dq_mma_12 <= 0;
            dq_pf_c_12 <= 0;
            dq_mma_13 <= 0;
            dq_pf_c_13 <= 0;
            dq_mma_14 <= 0;
            dq_pf_c_14 <= 0;
            dq_mma_15 <= 0;
            dq_pf_c_15 <= 0;
            dq_wp <= 0;
            pf_idx_q <= 0;
            pf_any_q <= 0;
            pq_v <= 0;
            pq_idx <= 0;
            ldb_seq <= 0;
            pf_v <= 0;
            pf_seq <= 0;
            pf_bset <= 0;
            pf_slot <= 0;
            av_tab_0 <= 0;
            av_tab_1 <= 0;
            av_tab_2 <= 0;
            av_tab_3 <= 0;
            pf_rowb <= 0;
            pf_nrows <= 0;
            pf_cfg <= 0;
            pf_klim <= 0;
            pf_q8 <= 0;
            pf_kmj <= 0;
            pf_strm <= 0;
            sc_v4 <= 0;
            sc_r4 <= 0;
            sc_v3 <= 0;
            sc_r3 <= 0;
            sc_v2 <= 0;
            sc_r2 <= 0;
            sc_v1 <= 0;
            sc_redo_0 <= 0;
            sc_redo_1 <= 0;
            sc_redo_2 <= 0;
            sc_redo_3 <= 0;
            sc_redo_4 <= 0;
            sc_redo_5 <= 0;
            sc_redo_6 <= 0;
            sc_redo_7 <= 0;
            sc_r1 <= 0;
            sc_i <= 0;
            sc_ra <= 0;
            sc_act <= 0;
            dq_rp <= 0;
            cur <= 0;
            cur_prog <= 0;
            cur_pf <= 0;
            cur_slot <= 0;
            cur_kern <= 0;
            cur_avar <= 0;
            cur_bvar <= 0;
            nopc <= 0;
            st_nx <= 0;
            state <= 0;
            cq_rp <= 0;
            f_acc <= 0;
            is_q8 <= 0;
            st_f32 <= 0;
            kmj <= 0;
            nCol <= 0;
            nRow <= 0;
            ntile <= 0;
            st_nCol <= 0;
            d_l3 <= 0;
            a_cfg <= 0;
            b_cfg <= 0;
            d_cfg <= 0;
            a_rowb <= 0;
            b_rowb <= 0;
            b_rows <= 0;
            b_strm <= 0;
            b_klim <= 0;
            st_nrp <= 0;
            st_nb_c <= 0;
            st_nRow <= 0;
            qmask <= 0;
            st_endt <= 0;
            sc_endt <= 0;
            bset_new <= 0;
            bset_cur <= 0;
            jp_acc <= 0;
            jp_endt <= 0;
            jp_M <= 0;
            jp_N <= 0;
            jp_ncol <= 0;
            jp_nrow <= 0;
            jp_kmj <= 0;
            jp_accum <= 0;
            jp_aset <= 0;
            jp_bset <= 0;
            jp_tag <= 0;
            jp_arl <= 0;
            jp_bseq <= 0;
            jp_btot <= 0;
            aset_new <= 0;
            lda_seq <= 0;
            aset_cur <= 0;
            st_act <= 0;
            lbeat <= 0;
            lnbeat <= 0;
            sc_rd_q <= 0;
            sc_acc <= 0;
            sc_islot <= 0;
            sdq <= 0;
        end else begin
            retire_p <= 0;
            lda_start <= 0;
            ldb_start <= 0;
            ldb_start_p <= 0;
            jv_d1 <= job_v;
            jv_d2 <= jv_d1;
            job_v <= 0;
            flush_q <= (flush_c & arr_held);
            if (acc_over) begin
                badacc <= 1;
            end
            if (u_kw_im_req) begin
                rd_q <= {im3[rd_a], im2[rd_a], im1[rd_a], im0[rd_a]};
            end
            if (lq_push) begin
                lq_wp <= ((lq_wp == 3) ? 3'd0 : (lq_wp + 1));
            end
            if (lc_go) begin
                lq_rp <= ((lq_rp == 3) ? 3'd0 : (lq_rp + 1));
            end
            lq_n <= ((lq_n + {2'd0, lq_push}) - {2'd0, lc_go});
            if (((issue_valid & (~issue_is_launch)) & (cq_n < 4))) begin
                cq_wp <= (cq_wp + 1);
            end
            cred_l1 <= ((cred_l1 + {2'd0, l1_a_valid}) - {2'd0, l1_dec});
            cred_llc <= ((cred_llc + {2'd0, noc_a_valid}) - {2'd0, nc_dec});
            if ((nd_dec__i0 != 0)) begin
                ift_nd_0 <= (ift_nd_0 - nd_dec__i0);
            end
            if ((nd_dec__i1 != 0)) begin
                ift_nd_1 <= (ift_nd_1 - nd_dec__i1);
            end
            if ((nd_dec__i2 != 0)) begin
                ift_nd_2 <= (ift_nd_2 - nd_dec__i2);
            end
            if ((nd_dec__i3 != 0)) begin
                ift_nd_3 <= (ift_nd_3 - nd_dec__i3);
            end
            ra_zq <= ra_z_n;
            if (dr_valid) begin
                if ((dr_slot[4:0] == 0)) begin
                    zf_c_0 <= 0;
                end
                if ((dr_slot[4:0] == 1)) begin
                    zf_c_1 <= 0;
                end
                if ((dr_slot[4:0] == 2)) begin
                    zf_c_2 <= 0;
                end
                if ((dr_slot[4:0] == 3)) begin
                    zf_c_3 <= 0;
                end
                if ((dr_slot[4:0] == 4)) begin
                    zf_c_4 <= 0;
                end
                if ((dr_slot[4:0] == 5)) begin
                    zf_c_5 <= 0;
                end
                if ((dr_slot[4:0] == 6)) begin
                    zf_c_6 <= 0;
                end
                if ((dr_slot[4:0] == 7)) begin
                    zf_c_7 <= 0;
                end
                if ((dr_slot[4:0] == 8)) begin
                    zf_c_8 <= 0;
                end
                if ((dr_slot[4:0] == 9)) begin
                    zf_c_9 <= 0;
                end
                if ((dr_slot[4:0] == 10)) begin
                    zf_c_10 <= 0;
                end
                if ((dr_slot[4:0] == 11)) begin
                    zf_c_11 <= 0;
                end
                if ((dr_slot[4:0] == 12)) begin
                    zf_c_12 <= 0;
                end
                if ((dr_slot[4:0] == 13)) begin
                    zf_c_13 <= 0;
                end
                if ((dr_slot[4:0] == 14)) begin
                    zf_c_14 <= 0;
                end
                if ((dr_slot[4:0] == 15)) begin
                    zf_c_15 <= 0;
                end
                if ((dr_slot[4:0] == 16)) begin
                    zf_c_16 <= 0;
                end
                if ((dr_slot[4:0] == 17)) begin
                    zf_c_17 <= 0;
                end
                if ((dr_slot[4:0] == 18)) begin
                    zf_c_18 <= 0;
                end
                if ((dr_slot[4:0] == 19)) begin
                    zf_c_19 <= 0;
                end
                if ((dr_slot[4:0] == 20)) begin
                    zf_c_20 <= 0;
                end
                if ((dr_slot[4:0] == 21)) begin
                    zf_c_21 <= 0;
                end
                if ((dr_slot[4:0] == 22)) begin
                    zf_c_22 <= 0;
                end
                if ((dr_slot[4:0] == 23)) begin
                    zf_c_23 <= 0;
                end
                if ((dr_slot[4:0] == 24)) begin
                    zf_c_24 <= 0;
                end
                if ((dr_slot[4:0] == 25)) begin
                    zf_c_25 <= 0;
                end
                if ((dr_slot[4:0] == 26)) begin
                    zf_c_26 <= 0;
                end
                if ((dr_slot[4:0] == 27)) begin
                    zf_c_27 <= 0;
                end
                if ((dr_slot[4:0] == 28)) begin
                    zf_c_28 <= 0;
                end
                if ((dr_slot[4:0] == 29)) begin
                    zf_c_29 <= 0;
                end
                if ((dr_slot[4:0] == 30)) begin
                    zf_c_30 <= 0;
                end
                if ((dr_slot[4:0] == 31)) begin
                    zf_c_31 <= 0;
                end
            end
            pl_zero_q <= zf_pl;
            if (rt_rdy) begin
                if ((rt_idx == 0)) begin
                    ift_v_c_0 <= 0;
                end
                if ((rt_idx == 1)) begin
                    ift_v_c_1 <= 0;
                end
                if ((rt_idx == 2)) begin
                    ift_v_c_2 <= 0;
                end
                if ((rt_idx == 3)) begin
                    ift_v_c_3 <= 0;
                end
                donec <= (donec + 1);
                retire_p <= 1;
            end
            busy_r <= ((((((((((((state != S_IDLE) | kern_act) | (nfl_w != 0)) | ld_v) | arr_busy) | jd_act) | jp_v)
                       | pf_v) | lda_busy) | ldb_busy) | sc_act) | (~dq_empty));
            if (jd_go) begin
                job_v <= 1;
                job_w <= job_c;
                if (job_last) begin
                    if ((jd_tag == 0)) begin
                        ift_fin_c_0 <= 1;
                    end
                    if ((jd_tag == 1)) begin
                        ift_fin_c_1 <= 1;
                    end
                    if ((jd_tag == 2)) begin
                        ift_fin_c_2 <= 1;
                    end
                    if ((jd_tag == 3)) begin
                        ift_fin_c_3 <= 1;
                    end
                    jd_act <= 0;
                end else begin
                    if (jgo_l1) begin
                        jleg <= 1;
                        jni <= jdd;
                        jmi <= 0;
                    end else begin
                        if (jnx_sh) begin
                            jdd <= jdd1;
                            if (jnx_l0) begin
                                jleg <= 0;
                                jmi <= jdd1;
                                jni <= 0;
                            end else begin
                                jleg <= 1;
                                jni <= jdd1;
                                jmi <= 0;
                            end
                        end else begin
                            if (jleg) begin
                                jmi <= (jmi + 1);
                            end else begin
                                jni <= (jni + 1);
                            end
                        end
                    end
                end
            end
            if (jd_act) begin
                if ((jd_arl & jd_av)) begin
                    if ((lda_tag == aseq_tab[jd_tag])) begin
                        jd_rows <= lda_rows;
                    end else begin
                        if ((lda_tag1 == aseq_tab[jd_tag])) begin
                            jd_rows <= lda_rows1;
                        end
                    end
                end
                if ((ldb_tag == jd_bseq)) begin
                    jd_bavail <= ldb_rows;
                end else begin
                    if ((ldb_tag1 == jd_bseq)) begin
                        jd_bavail <= ldb_rows1;
                    end
                end
            end
            if (((~jd_act) & jp_v)) begin
                jp_v <= 0;
                jd_act <= 1;
                jd_acc <= jp_acc;
                jd_endt <= jp_endt;
                jd_M <= jp_M;
                jd_N <= jp_N;
                jd_ncol <= jp_ncol;
                jd_nrow <= jp_nrow;
                jd_kmj <= jp_kmj;
                jd_accum <= jp_accum;
                jd_aset <= jp_aset;
                jd_bset <= jp_bset;
                jd_tag <= jp_tag;
                jd_arl <= jp_arl;
                jd_bseq <= jp_bseq;
                jd_btot <= jp_btot;
                jd_rows <= (jp_arl ? 7'd0 : jp_M);
                jd_bavail <= 0;
                jmi <= 0;
                jni <= 0;
                jdd <= 0;
                jleg <= 0;
            end
            if ((lda_gnt | ldb_gnt)) begin
                arb_rr <= (lda_gnt ? 1'd1 : 1'd0);
            end
            if (st_act) begin
                if (aw_hs) begin
                    aw_cnt <= (aw_cnt + 1);
                    if (aw_pend) begin
                        aw_pend <= 0;
                    end else begin
                        aw_sel_done <= 1;
                    end
                end
                if (w_hs) begin
                    st_beat <= (st_beat + 1);
                    mq_v <= 1;
                end else begin
                    if ((mq_v & oq_take)) begin
                        mq_v <= 0;
                    end
                end
                if ((mq_v & oq_take)) begin
                    oq_v <= 1;
                    oq_l3 <= mq_l3;
                end else begin
                    if (oq_acc) begin
                        oq_v <= 0;
                    end
                end
                if (w_last_hs) begin
                    w_act <= 0;
                    if (ws_j) begin
                        if (ws_e) begin
                            rb_v1 <= 0;
                        end else begin
                            rb_v0 <= 0;
                        end
                    end
                end
                if (b_hs) begin
                    st_bcnt <= (st_bcnt + 1);
                end
                if (w_start) begin
                    st_nbeat <= st_nb_c;
                    st_beat <= 0;
                    ws_e <= wr_e;
                    ws_j <= st_j;
                    w_act <= 1;
                    aw_sel_done <= 0;
                    if ((~(aw_sel_done | aw_hs))) begin
                        aw_pend <= 1;
                    end
                    if ((st_j == 0)) begin
                        st_j <= 1;
                    end else begin
                        st_j <= 0;
                        st_rpf <= (st_rpf + 1);
                        wr_e <= (~wr_e);
                    end
                end
            end
            rbq_we_0 <= rbq_we_n_0;
            rbq_we_1 <= rbq_we_n_0;
            rbq_we_2 <= rbq_we_n_0;
            rbq_we_3 <= rbq_we_n_0;
            rbq_we_4 <= rbq_we_n_0;
            rbq_we_5 <= rbq_we_n_0;
            rbq_we_6 <= rbq_we_n_0;
            rbq_we_7 <= rbq_we_n_0;
            rbq_we_8 <= rbq_we_n_1;
            rbq_we_9 <= rbq_we_n_1;
            rbq_we_10 <= rbq_we_n_1;
            rbq_we_11 <= rbq_we_n_1;
            rbq_we_12 <= rbq_we_n_1;
            rbq_we_13 <= rbq_we_n_1;
            rbq_we_14 <= rbq_we_n_1;
            rbq_we_15 <= rbq_we_n_1;
            rbq_we_16 <= rbq_we_n_0;
            rbq_we_17 <= rbq_we_n_0;
            rbq_we_18 <= rbq_we_n_0;
            rbq_we_19 <= rbq_we_n_0;
            rbq_we_20 <= rbq_we_n_0;
            rbq_we_21 <= rbq_we_n_0;
            rbq_we_22 <= rbq_we_n_0;
            rbq_we_23 <= rbq_we_n_0;
            rbq_we_24 <= rbq_we_n_1;
            rbq_we_25 <= rbq_we_n_1;
            rbq_we_26 <= rbq_we_n_1;
            rbq_we_27 <= rbq_we_n_1;
            rbq_we_28 <= rbq_we_n_1;
            rbq_we_29 <= rbq_we_n_1;
            rbq_we_30 <= rbq_we_n_1;
            rbq_we_31 <= rbq_we_n_1;
            if (st_act) begin
                if ((sr_st == 0)) begin
                    if (((sr_rpf < st_nrp) & sr_free)) begin
                        st_ti <= 0;
                        sr_st <= 1;
                    end
                end else begin
                    if ((sr_st == 1)) begin
                        if (acc_rd_ok) begin
                            sr_st <= 2;
                        end
                    end else begin
                        if (sr_last_ti) begin
                            if (sr_e) begin
                                rb_v1 <= 1;
                            end else begin
                                rb_v0 <= 1;
                            end
                            sr_e <= (~sr_e);
                            sr_rpf <= (sr_rpf + 1);
                            if (((((sr_rpf + 6'd1) < st_nrp) & sr_next_free) & acc_rd_ok)) begin
                                st_ti <= 0;
                                sr_st <= 1;
                            end else begin
                                sr_st <= 0;
                            end
                        end else begin
                            st_ti <= (st_ti + 1);
                            sr_st <= (st_rd_p ? 2'd2 : 2'd1);
                        end
                    end
                end
            end
            dq_nq <= dq_nn;
            dq_eq <= (dq_nn == 0);
            if (kw_take) begin
                kprog <= (kprog + 1);
                if ((~dq_byp)) begin
                    if ((dq_wi == 0)) begin
                        dq_mma_0 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_0 <= 0;
                    end
                    if ((dq_wi == 1)) begin
                        dq_mma_1 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_1 <= 0;
                    end
                    if ((dq_wi == 2)) begin
                        dq_mma_2 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_2 <= 0;
                    end
                    if ((dq_wi == 3)) begin
                        dq_mma_3 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_3 <= 0;
                    end
                    if ((dq_wi == 4)) begin
                        dq_mma_4 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_4 <= 0;
                    end
                    if ((dq_wi == 5)) begin
                        dq_mma_5 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_5 <= 0;
                    end
                    if ((dq_wi == 6)) begin
                        dq_mma_6 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_6 <= 0;
                    end
                    if ((dq_wi == 7)) begin
                        dq_mma_7 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_7 <= 0;
                    end
                    if ((dq_wi == 8)) begin
                        dq_mma_8 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_8 <= 0;
                    end
                    if ((dq_wi == 9)) begin
                        dq_mma_9 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_9 <= 0;
                    end
                    if ((dq_wi == 10)) begin
                        dq_mma_10 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_10 <= 0;
                    end
                    if ((dq_wi == 11)) begin
                        dq_mma_11 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_11 <= 0;
                    end
                    if ((dq_wi == 12)) begin
                        dq_mma_12 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_12 <= 0;
                    end
                    if ((dq_wi == 13)) begin
                        dq_mma_13 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_13 <= 0;
                    end
                    if ((dq_wi == 14)) begin
                        dq_mma_14 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_14 <= 0;
                    end
                    if ((dq_wi == 15)) begin
                        dq_mma_15 <= (u_kw_out_inst[4:0] == 14);
                        dq_pf_c_15 <= 0;
                    end
                    dq_wp <= (dq_wp + 1);
                end
            end
            pf_idx_q <= pf_idx;
            pf_any_q <= pf_any;
            pq_v <= pf_any_q;
            pq_idx <= pf_idx_q;
            if (pf_can) begin
                ldb_start_p <= 1;
                ldb_seq <= (ldb_seq + 1);
                pf_v <= 1;
                pf_seq <= (ldb_seq + 1);
                pf_bset <= pf_nset;
                pf_slot <= fs_idx;
                if ((fs_idx == 0)) begin
                    ift_v_c_0 <= 1;
                    ift_fin_c_0 <= 0;
                    ift_nd_0 <= ({1'd0, pq_ins[126]} + 2'd1);
                    av_tab_0 <= 0;
                end
                if ((fs_idx == 1)) begin
                    ift_v_c_1 <= 1;
                    ift_fin_c_1 <= 0;
                    ift_nd_1 <= ({1'd0, pq_ins[126]} + 2'd1);
                    av_tab_1 <= 0;
                end
                if ((fs_idx == 2)) begin
                    ift_v_c_2 <= 1;
                    ift_fin_c_2 <= 0;
                    ift_nd_2 <= ({1'd0, pq_ins[126]} + 2'd1);
                    av_tab_2 <= 0;
                end
                if ((fs_idx == 3)) begin
                    ift_v_c_3 <= 1;
                    ift_fin_c_3 <= 0;
                    ift_nd_3 <= ({1'd0, pq_ins[126]} + 2'd1);
                    av_tab_3 <= 0;
                end
                if ((pq_idx == 0)) begin
                    dq_pf_c_0 <= 1;
                end
                if ((pq_idx == 1)) begin
                    dq_pf_c_1 <= 1;
                end
                if ((pq_idx == 2)) begin
                    dq_pf_c_2 <= 1;
                end
                if ((pq_idx == 3)) begin
                    dq_pf_c_3 <= 1;
                end
                if ((pq_idx == 4)) begin
                    dq_pf_c_4 <= 1;
                end
                if ((pq_idx == 5)) begin
                    dq_pf_c_5 <= 1;
                end
                if ((pq_idx == 6)) begin
                    dq_pf_c_6 <= 1;
                end
                if ((pq_idx == 7)) begin
                    dq_pf_c_7 <= 1;
                end
                if ((pq_idx == 8)) begin
                    dq_pf_c_8 <= 1;
                end
                if ((pq_idx == 9)) begin
                    dq_pf_c_9 <= 1;
                end
                if ((pq_idx == 10)) begin
                    dq_pf_c_10 <= 1;
                end
                if ((pq_idx == 11)) begin
                    dq_pf_c_11 <= 1;
                end
                if ((pq_idx == 12)) begin
                    dq_pf_c_12 <= 1;
                end
                if ((pq_idx == 13)) begin
                    dq_pf_c_13 <= 1;
                end
                if ((pq_idx == 14)) begin
                    dq_pf_c_14 <= 1;
                end
                if ((pq_idx == 15)) begin
                    dq_pf_c_15 <= 1;
                end
                pf_rowb <= n_browb;
                pf_nrows <= n_brows;
                pf_cfg <= n_bcid;
                pf_klim <= n_bklim;
                pf_q8 <= n_q8;
                pf_kmj <= n_kmj;
                pf_strm <= n_bstrm;
            end
            if (sc_act) begin
                sc_v4 <= sc_v3;
                sc_r4 <= sc_r3;
                sc_v3 <= sc_v2;
                sc_r3 <= sc_r2;
                sc_v2 <= sc_v1;
                sc_r2 <= sc_r1;
                sc_v1 <= 0;
                if (sc_v4) begin
                    if ((sc_r4 == 0)) begin
                        sc_redo_0 <= dr_valid;
                    end
                    if ((sc_r4 == 1)) begin
                        sc_redo_1 <= dr_valid;
                    end
                    if ((sc_r4 == 2)) begin
                        sc_redo_2 <= dr_valid;
                    end
                    if ((sc_r4 == 3)) begin
                        sc_redo_3 <= dr_valid;
                    end
                    if ((sc_r4 == 4)) begin
                        sc_redo_4 <= dr_valid;
                    end
                    if ((sc_r4 == 5)) begin
                        sc_redo_5 <= dr_valid;
                    end
                    if ((sc_r4 == 6)) begin
                        sc_redo_6 <= dr_valid;
                    end
                    if ((sc_r4 == 7)) begin
                        sc_redo_7 <= dr_valid;
                    end
                end
                if (sc_can) begin
                    sc_v1 <= 1;
                    sc_r1 <= sc_nxt;
                    if ((~sc_i[3])) begin
                        sc_i <= (sc_i + 1);
                        sc_ra <= (sc_ra + 1);
                    end
                end else begin
                    if (((sc_i[3] & sc_pipe_empty) & (~sc_redo_any))) begin
                        if ((sc_islot == 0)) begin
                            ift_fin_c_0 <= 1;
                        end
                        if ((sc_islot == 1)) begin
                            ift_fin_c_1 <= 1;
                        end
                        if ((sc_islot == 2)) begin
                            ift_fin_c_2 <= 1;
                        end
                        if ((sc_islot == 3)) begin
                            ift_fin_c_3 <= 1;
                        end
                        sc_act <= 0;
                    end
                end
            end
            case (state)
                0: begin
                    if (dq_pop) begin
                        dq_rp <= (dq_rp + 1);
                        if ((dq_ri == 0)) begin
                            dq_mma_0 <= 0;
                        end
                        if ((dq_ri == 1)) begin
                            dq_mma_1 <= 0;
                        end
                        if ((dq_ri == 2)) begin
                            dq_mma_2 <= 0;
                        end
                        if ((dq_ri == 3)) begin
                            dq_mma_3 <= 0;
                        end
                        if ((dq_ri == 4)) begin
                            dq_mma_4 <= 0;
                        end
                        if ((dq_ri == 5)) begin
                            dq_mma_5 <= 0;
                        end
                        if ((dq_ri == 6)) begin
                            dq_mma_6 <= 0;
                        end
                        if ((dq_ri == 7)) begin
                            dq_mma_7 <= 0;
                        end
                        if ((dq_ri == 8)) begin
                            dq_mma_8 <= 0;
                        end
                        if ((dq_ri == 9)) begin
                            dq_mma_9 <= 0;
                        end
                        if ((dq_ri == 10)) begin
                            dq_mma_10 <= 0;
                        end
                        if ((dq_ri == 11)) begin
                            dq_mma_11 <= 0;
                        end
                        if ((dq_ri == 12)) begin
                            dq_mma_12 <= 0;
                        end
                        if ((dq_ri == 13)) begin
                            dq_mma_13 <= 0;
                        end
                        if ((dq_ri == 14)) begin
                            dq_mma_14 <= 0;
                        end
                        if ((dq_ri == 15)) begin
                            dq_mma_15 <= 0;
                        end
                        cur <= dqh_ins;
                        cur_prog <= dqh_prog;
                        cur_pf <= dqh_pf;
                        if (dqh_pf) begin
                            cur_slot <= pf_slot;
                        end else begin
                            cur_slot <= fs_idx;
                            if ((fs_idx == 0)) begin
                                ift_v_c_0 <= 1;
                                ift_fin_c_0 <= 0;
                                ift_nd_0 <= ((dqh_ins[4:0] == 14) ? ({1'd0, dqh_ins[126]} + 2'd1) :
                                            (((dqh_ins[4:0] == 16) | (dqh_ins[4:0] == 17)) ? 2'd1 :
                                            2'd0));
                                av_tab_0 <= 0;
                            end
                            if ((fs_idx == 1)) begin
                                ift_v_c_1 <= 1;
                                ift_fin_c_1 <= 0;
                                ift_nd_1 <= ((dqh_ins[4:0] == 14) ? ({1'd0, dqh_ins[126]} + 2'd1) :
                                            (((dqh_ins[4:0] == 16) | (dqh_ins[4:0] == 17)) ? 2'd1 :
                                            2'd0));
                                av_tab_1 <= 0;
                            end
                            if ((fs_idx == 2)) begin
                                ift_v_c_2 <= 1;
                                ift_fin_c_2 <= 0;
                                ift_nd_2 <= ((dqh_ins[4:0] == 14) ? ({1'd0, dqh_ins[126]} + 2'd1) :
                                            (((dqh_ins[4:0] == 16) | (dqh_ins[4:0] == 17)) ? 2'd1 :
                                            2'd0));
                                av_tab_2 <= 0;
                            end
                            if ((fs_idx == 3)) begin
                                ift_v_c_3 <= 1;
                                ift_fin_c_3 <= 0;
                                ift_nd_3 <= ((dqh_ins[4:0] == 14) ? ({1'd0, dqh_ins[126]} + 2'd1) :
                                            (((dqh_ins[4:0] == 16) | (dqh_ins[4:0] == 17)) ? 2'd1 :
                                            2'd0));
                                av_tab_3 <= 0;
                            end
                        end
                        cur_kern <= 1'd1;
                        cur_avar <= dqh_av;
                        cur_bvar <= dqh_bv;
                        nopc <= dqh_ins[21:6];
                        st_nx <= ((dqh_ins[4:0] == 14) ? S_B_SET :
                                 ((dqh_ins[4:0] == 16) ? S_ST_WAIT :
                                 ((dqh_ins[4:0] == 17) ? S_SC_WAIT :
                                 ((dqh_ins[4:0] == 15) ? S_CL_WAIT :
                                 S_IDLE))));
                        state <= ((dqh_ins[4:0] == 22) ? S_NOP : S_DEC);
                    end else begin
                        if (dq_byp) begin
                            cur <= u_kw_out_inst;
                            cur_prog <= kprog;
                            cur_pf <= 1'd0;
                            if (1'd0) begin
                                cur_slot <= pf_slot;
                            end else begin
                                cur_slot <= fs_idx;
                                if ((fs_idx == 0)) begin
                                    ift_v_c_0 <= 1;
                                    ift_fin_c_0 <= 0;
                                    ift_nd_0 <= ((u_kw_out_inst[4:0] == 14) ? ({1'd0, u_kw_out_inst[126]} + 2'd1) :
                                                (((u_kw_out_inst[4:0] == 16) | (u_kw_out_inst[4:0] == 17)) ? 2'd1 :
                                                2'd0));
                                    av_tab_0 <= 0;
                                end
                                if ((fs_idx == 1)) begin
                                    ift_v_c_1 <= 1;
                                    ift_fin_c_1 <= 0;
                                    ift_nd_1 <= ((u_kw_out_inst[4:0] == 14) ? ({1'd0, u_kw_out_inst[126]} + 2'd1) :
                                                (((u_kw_out_inst[4:0] == 16) | (u_kw_out_inst[4:0] == 17)) ? 2'd1 :
                                                2'd0));
                                    av_tab_1 <= 0;
                                end
                                if ((fs_idx == 2)) begin
                                    ift_v_c_2 <= 1;
                                    ift_fin_c_2 <= 0;
                                    ift_nd_2 <= ((u_kw_out_inst[4:0] == 14) ? ({1'd0, u_kw_out_inst[126]} + 2'd1) :
                                                (((u_kw_out_inst[4:0] == 16) | (u_kw_out_inst[4:0] == 17)) ? 2'd1 :
                                                2'd0));
                                    av_tab_2 <= 0;
                                end
                                if ((fs_idx == 3)) begin
                                    ift_v_c_3 <= 1;
                                    ift_fin_c_3 <= 0;
                                    ift_nd_3 <= ((u_kw_out_inst[4:0] == 14) ? ({1'd0, u_kw_out_inst[126]} + 2'd1) :
                                                (((u_kw_out_inst[4:0] == 16) | (u_kw_out_inst[4:0] == 17)) ? 2'd1 :
                                                2'd0));
                                    av_tab_3 <= 0;
                                end
                            end
                            cur_kern <= 1'd1;
                            cur_avar <= u_kw_rda_val;
                            cur_bvar <= u_kw_rdb_val;
                            nopc <= u_kw_out_inst[21:6];
                            st_nx <= ((u_kw_out_inst[4:0] == 14) ? S_B_SET :
                                     ((u_kw_out_inst[4:0] == 16) ? S_ST_WAIT :
                                     ((u_kw_out_inst[4:0] == 17) ? S_SC_WAIT :
                                     ((u_kw_out_inst[4:0] == 15) ? S_CL_WAIT :
                                     S_IDLE))));
                            state <= ((u_kw_out_inst[4:0] == 22) ? S_NOP : S_DEC);
                        end else begin
                            if (((cq_n != 0) & (nfl_w < 4))) begin
                                cq_rp <= (cq_rp + 1);
                                cur <= cq_i[cq_rp[1:0]];
                                cur_prog <= cq_p[cq_rp[1:0]];
                                cur_pf <= 1'd0;
                                if (1'd0) begin
                                    cur_slot <= pf_slot;
                                end else begin
                                    cur_slot <= fs_idx;
                                    if ((fs_idx == 0)) begin
                                        ift_v_c_0 <= 1;
                                        ift_fin_c_0 <= 0;
                                        ift_nd_0 <= ((cq_i[cq_rp[1:0]][4:0] == 14)
                                                     ? ({1'd0, cq_i[cq_rp[1:0]][126]} + 2'd1) :
                                                    (((cq_i[cq_rp[1:0]][4:0] == 16) | (cq_i[cq_rp[1:0]][4:0] == 17))
                                                     ? 2'd1 :
                                                    2'd0));
                                        av_tab_0 <= 0;
                                    end
                                    if ((fs_idx == 1)) begin
                                        ift_v_c_1 <= 1;
                                        ift_fin_c_1 <= 0;
                                        ift_nd_1 <= ((cq_i[cq_rp[1:0]][4:0] == 14)
                                                     ? ({1'd0, cq_i[cq_rp[1:0]][126]} + 2'd1) :
                                                    (((cq_i[cq_rp[1:0]][4:0] == 16) | (cq_i[cq_rp[1:0]][4:0] == 17))
                                                     ? 2'd1 :
                                                    2'd0));
                                        av_tab_1 <= 0;
                                    end
                                    if ((fs_idx == 2)) begin
                                        ift_v_c_2 <= 1;
                                        ift_fin_c_2 <= 0;
                                        ift_nd_2 <= ((cq_i[cq_rp[1:0]][4:0] == 14)
                                                     ? ({1'd0, cq_i[cq_rp[1:0]][126]} + 2'd1) :
                                                    (((cq_i[cq_rp[1:0]][4:0] == 16) | (cq_i[cq_rp[1:0]][4:0] == 17))
                                                     ? 2'd1 :
                                                    2'd0));
                                        av_tab_2 <= 0;
                                    end
                                    if ((fs_idx == 3)) begin
                                        ift_v_c_3 <= 1;
                                        ift_fin_c_3 <= 0;
                                        ift_nd_3 <= ((cq_i[cq_rp[1:0]][4:0] == 14)
                                                     ? ({1'd0, cq_i[cq_rp[1:0]][126]} + 2'd1) :
                                                    (((cq_i[cq_rp[1:0]][4:0] == 16) | (cq_i[cq_rp[1:0]][4:0] == 17))
                                                     ? 2'd1 :
                                                    2'd0));
                                        av_tab_3 <= 0;
                                    end
                                end
                                cur_kern <= 1'd0;
                                cur_avar <= 32'd0;
                                cur_bvar <= 32'd0;
                                nopc <= cq_i[cq_rp[1:0]][21:6];
                                st_nx <= ((cq_i[cq_rp[1:0]][4:0] == 14) ? S_B_SET :
                                         ((cq_i[cq_rp[1:0]][4:0] == 16) ? S_ST_WAIT :
                                         ((cq_i[cq_rp[1:0]][4:0] == 17) ? S_SC_WAIT :
                                         ((cq_i[cq_rp[1:0]][4:0] == 15) ? S_CL_WAIT :
                                         S_IDLE))));
                                state <= ((cq_i[cq_rp[1:0]][4:0] == 22) ? S_NOP : S_DEC);
                            end
                        end
                    end
                end
                36: begin
                    f_acc <= f_acc_c;
                    is_q8 <= is_q8_c;
                    st_f32 <= (f_dt == 1);
                    kmj <= kmj_c;
                    nCol <= nCol_c;
                    nRow <= nRow_c;
                    ntile <= ntile_c;
                    st_nCol <= st_nCol_c;
                    d_l3 <= d_l3_c;
                    a_cfg <= a_cfg_c;
                    b_cfg <= b_cfg_c;
                    d_cfg <= d_cfg_c;
                    a_rowb <= a_rowb_c;
                    b_rowb <= b_rowb_c;
                    b_rows <= b_rows_c;
                    b_strm <= b_strm_c;
                    b_klim <= b_klim_c;
                    st_nrp <= st_nrp_c;
                    st_nb_c <= st_nb_c_c;
                    st_nRow <= st_nRow_c;
                    qmask <= qmask_c;
                    st_endt <= st_endt_c;
                    sc_endt <= sc_endt_c;
                    state <= st_nx;
                end
                35: begin
                    bset_new <= pf_nset;
                    if (cur_pf) begin
                        if (((~jp_v) & (~sc_ahit))) begin
                            state <= S_B_ADM;
                        end
                    end else begin
                        if ((((pf_set_free & ldb_fxfree) & (~jp_v)) & (~sc_ahit))) begin
                            ldb_start <= 1;
                            ldb_seq <= (ldb_seq + 1);
                            state <= S_B_ADM;
                        end
                    end
                end
                8: begin
                    if (cur_pf) begin
                        pf_v <= 0;
                    end
                    bset_cur <= bset_new;
                    if (jd_act) begin
                        jp_v <= 1;
                        jp_acc <= f_acc;
                        jp_endt <= ab_endt_c;
                        jp_M <= f_M;
                        jp_N <= f_N;
                        jp_ncol <= nCol;
                        jp_nrow <= nRow;
                        jp_kmj <= kmj;
                        jp_accum <= f_accum;
                        jp_aset <= (f_arl ? aset_nx : aset_cur);
                        jp_bset <= bset_new;
                        jp_tag <= cur_slot;
                        jp_arl <= f_arl;
                        jp_bseq <= (cur_pf ? pf_seq : ldb_seq);
                        jp_btot <= b_rows;
                    end else begin
                        jd_act <= 1;
                        jd_acc <= f_acc;
                        jd_endt <= ab_endt_c;
                        jd_M <= f_M;
                        jd_N <= f_N;
                        jd_ncol <= nCol;
                        jd_nrow <= nRow;
                        jd_kmj <= kmj;
                        jd_accum <= f_accum;
                        jd_aset <= (f_arl ? aset_nx : aset_cur);
                        jd_bset <= bset_new;
                        jd_tag <= cur_slot;
                        jd_arl <= f_arl;
                        jd_bseq <= (cur_pf ? pf_seq : ldb_seq);
                        jd_btot <= b_rows;
                        jd_rows <= (f_arl ? 7'd0 : f_M);
                        jd_bavail <= 0;
                        jmi <= 0;
                        jni <= 0;
                        jdd <= 0;
                        jleg <= 0;
                    end
                    if (f_arl) begin
                        state <= S_A_SET;
                    end else begin
                        state <= S_IDLE;
                    end
                end
                34: begin
                    aset_new <= aset_nx;
                    if ((aset_nx_free & lda_fxfree)) begin
                        state <= S_A_ADM;
                    end
                end
                2: begin
                    lda_start <= 1;
                    lda_seq <= (lda_seq + 1);
                    aset_cur <= aset_new;
                    if ((cur_slot == 0)) begin
                        av_tab_0 <= 1;
                    end
                    if ((cur_slot == 1)) begin
                        av_tab_1 <= 1;
                    end
                    if ((cur_slot == 2)) begin
                        av_tab_2 <= 1;
                    end
                    if ((cur_slot == 3)) begin
                        av_tab_3 <= 1;
                    end
                    state <= S_IDLE;
                end
                14: begin
                    if ((~sb_hit)) begin
                        st_rpf <= 0;
                        st_j <= 0;
                        wr_e <= 0;
                        ws_e <= 0;
                        ws_j <= 0;
                        sr_e <= 0;
                        sr_rpf <= 0;
                        sr_st <= 0;
                        rb_v0 <= 0;
                        rb_v1 <= 0;
                        aw_sel_done <= 0;
                        aw_pend <= 0;
                        aw_cnt <= 0;
                        w_act <= 0;
                        st_bcnt <= 0;
                        st_act <= 1;
                        state <= S_ST_RUN;
                    end
                end
                17: begin
                    if (st_fin) begin
                        if ((cur_slot == 0)) begin
                            ift_fin_c_0 <= 1;
                        end
                        if ((cur_slot == 1)) begin
                            ift_fin_c_1 <= 1;
                        end
                        if ((cur_slot == 2)) begin
                            ift_fin_c_2 <= 1;
                        end
                        if ((cur_slot == 3)) begin
                            ift_fin_c_3 <= 1;
                        end
                        st_act <= 0;
                        state <= S_IDLE;
                    end
                end
                23: begin
                    if ((~sb_hit)) begin
                        if (sc_gnt) begin
                            lbeat <= 0;
                            lnbeat <= sc_span[8:7];
                            state <= S_SC_RD;
                            sc_rd_q <= 1;
                        end else begin
                            state <= S_SC_AR;
                        end
                    end
                end
                26: begin
                    if (sc_gnt) begin
                        lbeat <= 0;
                        lnbeat <= sc_span[8:7];
                        state <= S_SC_RD;
                        sc_rd_q <= 1;
                    end
                end
                27: begin
                    if (sc_rv) begin
                        if ((lbeat == (lnbeat - 2'd1))) begin
                            state <= S_SC_EXT;
                            sc_rd_q <= 0;
                        end else begin
                            lbeat <= (lbeat + 1);
                        end
                    end
                end
                28: begin
                    if ((~sc_act)) begin
                        sc_i <= 0;
                        sc_ra <= 0;
                        sc_redo_0 <= 0;
                        sc_redo_1 <= 0;
                        sc_redo_2 <= 0;
                        sc_redo_3 <= 0;
                        sc_redo_4 <= 0;
                        sc_redo_5 <= 0;
                        sc_redo_6 <= 0;
                        sc_redo_7 <= 0;
                        sc_v1 <= 0;
                        sc_v2 <= 0;
                        sc_v3 <= 0;
                        sc_v4 <= 0;
                        if (zf_cur) begin
                            if ((cur_slot == 0)) begin
                                ift_fin_c_0 <= 1;
                            end
                            if ((cur_slot == 1)) begin
                                ift_fin_c_1 <= 1;
                            end
                            if ((cur_slot == 2)) begin
                                ift_fin_c_2 <= 1;
                            end
                            if ((cur_slot == 3)) begin
                                ift_fin_c_3 <= 1;
                            end
                        end else begin
                            sc_act <= 1;
                            sc_acc <= f_acc;
                            sc_islot <= cur_slot;
                        end
                        state <= S_IDLE;
                    end
                end
                32: begin
                    if ((~sb_hit)) begin
                        if ((f_acc[4:0] == 0)) begin
                            zf_c_0 <= 1;
                        end
                        if ((f_acc[4:0] == 1)) begin
                            zf_c_1 <= 1;
                        end
                        if ((f_acc[4:0] == 2)) begin
                            zf_c_2 <= 1;
                        end
                        if ((f_acc[4:0] == 3)) begin
                            zf_c_3 <= 1;
                        end
                        if ((f_acc[4:0] == 4)) begin
                            zf_c_4 <= 1;
                        end
                        if ((f_acc[4:0] == 5)) begin
                            zf_c_5 <= 1;
                        end
                        if ((f_acc[4:0] == 6)) begin
                            zf_c_6 <= 1;
                        end
                        if ((f_acc[4:0] == 7)) begin
                            zf_c_7 <= 1;
                        end
                        if ((f_acc[4:0] == 8)) begin
                            zf_c_8 <= 1;
                        end
                        if ((f_acc[4:0] == 9)) begin
                            zf_c_9 <= 1;
                        end
                        if ((f_acc[4:0] == 10)) begin
                            zf_c_10 <= 1;
                        end
                        if ((f_acc[4:0] == 11)) begin
                            zf_c_11 <= 1;
                        end
                        if ((f_acc[4:0] == 12)) begin
                            zf_c_12 <= 1;
                        end
                        if ((f_acc[4:0] == 13)) begin
                            zf_c_13 <= 1;
                        end
                        if ((f_acc[4:0] == 14)) begin
                            zf_c_14 <= 1;
                        end
                        if ((f_acc[4:0] == 15)) begin
                            zf_c_15 <= 1;
                        end
                        if ((f_acc[4:0] == 16)) begin
                            zf_c_16 <= 1;
                        end
                        if ((f_acc[4:0] == 17)) begin
                            zf_c_17 <= 1;
                        end
                        if ((f_acc[4:0] == 18)) begin
                            zf_c_18 <= 1;
                        end
                        if ((f_acc[4:0] == 19)) begin
                            zf_c_19 <= 1;
                        end
                        if ((f_acc[4:0] == 20)) begin
                            zf_c_20 <= 1;
                        end
                        if ((f_acc[4:0] == 21)) begin
                            zf_c_21 <= 1;
                        end
                        if ((f_acc[4:0] == 22)) begin
                            zf_c_22 <= 1;
                        end
                        if ((f_acc[4:0] == 23)) begin
                            zf_c_23 <= 1;
                        end
                        if ((f_acc[4:0] == 24)) begin
                            zf_c_24 <= 1;
                        end
                        if ((f_acc[4:0] == 25)) begin
                            zf_c_25 <= 1;
                        end
                        if ((f_acc[4:0] == 26)) begin
                            zf_c_26 <= 1;
                        end
                        if ((f_acc[4:0] == 27)) begin
                            zf_c_27 <= 1;
                        end
                        if ((f_acc[4:0] == 28)) begin
                            zf_c_28 <= 1;
                        end
                        if ((f_acc[4:0] == 29)) begin
                            zf_c_29 <= 1;
                        end
                        if ((f_acc[4:0] == 30)) begin
                            zf_c_30 <= 1;
                        end
                        if ((f_acc[4:0] == 31)) begin
                            zf_c_31 <= 1;
                        end
                        if ((cur_slot == 0)) begin
                            ift_fin_c_0 <= 1;
                        end
                        if ((cur_slot == 1)) begin
                            ift_fin_c_1 <= 1;
                        end
                        if ((cur_slot == 2)) begin
                            ift_fin_c_2 <= 1;
                        end
                        if ((cur_slot == 3)) begin
                            ift_fin_c_3 <= 1;
                        end
                        state <= S_IDLE;
                    end
                end
                33: begin
                    if ((nopc <= 2)) begin
                        if ((cur_slot == 0)) begin
                            ift_fin_c_0 <= 1;
                        end
                        if ((cur_slot == 1)) begin
                            ift_fin_c_1 <= 1;
                        end
                        if ((cur_slot == 2)) begin
                            ift_fin_c_2 <= 1;
                        end
                        if ((cur_slot == 3)) begin
                            ift_fin_c_3 <= 1;
                        end
                        state <= S_IDLE;
                    end else begin
                        nopc <= (nopc - 1);
                    end
                end
            endcase
            sdq <= (lc_go ? 16'd1 : (kw_take ? 16'd0 : (sdq + 1)));
        end
    end
    always_ff @(posedge clk) begin
        if (isram_wen) begin
            if ((lane == 0)) begin
                im0[row] <= isram_wdata;
            end else begin
                if ((lane == 1)) begin
                    im1[row] <= isram_wdata;
                end else begin
                    if ((lane == 2)) begin
                        im2[row] <= isram_wdata;
                    end else begin
                        im3[row] <= isram_wdata;
                    end
                end
            end
        end
        if (lq_push) begin
            lq_id[lq_wp[1:0]] <= issue_launch_id;
            lq_off[lq_wp[1:0]] <= issue_launch_off;
            lq_len[lq_wp[1:0]] <= issue_launch_len;
        end
        if (((issue_valid & (~issue_is_launch)) & (cq_n < 4))) begin
            cq_i[cq_wp[1:0]] <= issue_instr;
            cq_p[cq_wp[1:0]] <= issue_prog_idx;
        end
        accq <= {accm_15[acc_ra], accm_14[acc_ra], accm_13[acc_ra], accm_12[acc_ra], accm_11[acc_ra], accm_10[acc_ra],
                 accm_9[acc_ra], accm_8[acc_ra], accm_7[acc_ra], accm_6[acc_ra], accm_5[acc_ra], accm_4[acc_ra],
                 accm_3[acc_ra], accm_2[acc_ra], accm_1[acc_ra], accm_0[acc_ra]};
        if (acc_we_c_0) begin
            accm_0[acc_wa_c_0] <= acc_wd_c_0;
        end
        if (acc_we_c_1) begin
            accm_1[acc_wa_c_1] <= acc_wd_c_1;
        end
        if (acc_we_c_2) begin
            accm_2[acc_wa_c_2] <= acc_wd_c_2;
        end
        if (acc_we_c_3) begin
            accm_3[acc_wa_c_3] <= acc_wd_c_3;
        end
        if (acc_we_c_4) begin
            accm_4[acc_wa_c_4] <= acc_wd_c_4;
        end
        if (acc_we_c_5) begin
            accm_5[acc_wa_c_5] <= acc_wd_c_5;
        end
        if (acc_we_c_6) begin
            accm_6[acc_wa_c_6] <= acc_wd_c_6;
        end
        if (acc_we_c_7) begin
            accm_7[acc_wa_c_7] <= acc_wd_c_7;
        end
        if (acc_we_c_8) begin
            accm_8[acc_wa_c_8] <= acc_wd_c_8;
        end
        if (acc_we_c_9) begin
            accm_9[acc_wa_c_9] <= acc_wd_c_9;
        end
        if (acc_we_c_10) begin
            accm_10[acc_wa_c_10] <= acc_wd_c_10;
        end
        if (acc_we_c_11) begin
            accm_11[acc_wa_c_11] <= acc_wd_c_11;
        end
        if (acc_we_c_12) begin
            accm_12[acc_wa_c_12] <= acc_wd_c_12;
        end
        if (acc_we_c_13) begin
            accm_13[acc_wa_c_13] <= acc_wd_c_13;
        end
        if (acc_we_c_14) begin
            accm_14[acc_wa_c_14] <= acc_wd_c_14;
        end
        if (acc_we_c_15) begin
            accm_15[acc_wa_c_15] <= acc_wd_c_15;
        end
        if (st_act) begin
            if (w_hs) begin
                mq_q16 <= st_q16;
                mq_beat <= st_beat;
                mq_s16_0 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_0 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_0 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_1 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_1 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_1 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_2 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_2 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_2 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_3 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_3 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_3 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_4 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_4 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_4 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_5 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_5 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_5 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_6 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_6 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_6 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_s16_7 <= ((~st_f32) & (st_beat[3:2] == 0));
                mq_sh_7 <= ((st_f32 & (~st_beat[3])) & st_beat[0]);
                mq_sl_7 <= ((st_f32 & (~st_beat[3])) & (~st_beat[0]));
                mq_nb <= f_bpr[9:0];
                mq_l3 <= d_l3;
            end
            if ((mq_v & oq_take)) begin
                oq_dat <= st_wbeat;
                oq_stb <= st_wstrb;
            end
            if (w_start) begin
                if ((~(aw_sel_done | aw_hs))) begin
                    aw_addr_q <= st_addr;
                end
                st_addr <= st_addr_n;
            end
        end
        rbq_wa_0 <= rbq_wa_n;
        rbq_z_0 <= ra_z_n;
        if (rbq_we_0) begin
            rbm_0[rbq_wa_0] <= rbk_d_0;
            rbz_0[rbq_wa_0] <= rbq_z_0;
        end
        rbq_wa_1 <= rbq_wa_n;
        rbq_z_1 <= ra_z_n;
        if (rbq_we_1) begin
            rbm_1[rbq_wa_1] <= rbk_d_1;
            rbz_1[rbq_wa_1] <= rbq_z_1;
        end
        rbq_wa_2 <= rbq_wa_n;
        rbq_z_2 <= ra_z_n;
        if (rbq_we_2) begin
            rbm_2[rbq_wa_2] <= rbk_d_2;
            rbz_2[rbq_wa_2] <= rbq_z_2;
        end
        rbq_wa_3 <= rbq_wa_n;
        rbq_z_3 <= ra_z_n;
        if (rbq_we_3) begin
            rbm_3[rbq_wa_3] <= rbk_d_3;
            rbz_3[rbq_wa_3] <= rbq_z_3;
        end
        rbq_wa_4 <= rbq_wa_n;
        rbq_z_4 <= ra_z_n;
        if (rbq_we_4) begin
            rbm_4[rbq_wa_4] <= rbk_d_4;
            rbz_4[rbq_wa_4] <= rbq_z_4;
        end
        rbq_wa_5 <= rbq_wa_n;
        rbq_z_5 <= ra_z_n;
        if (rbq_we_5) begin
            rbm_5[rbq_wa_5] <= rbk_d_5;
            rbz_5[rbq_wa_5] <= rbq_z_5;
        end
        rbq_wa_6 <= rbq_wa_n;
        rbq_z_6 <= ra_z_n;
        if (rbq_we_6) begin
            rbm_6[rbq_wa_6] <= rbk_d_6;
            rbz_6[rbq_wa_6] <= rbq_z_6;
        end
        rbq_wa_7 <= rbq_wa_n;
        rbq_z_7 <= ra_z_n;
        if (rbq_we_7) begin
            rbm_7[rbq_wa_7] <= rbk_d_7;
            rbz_7[rbq_wa_7] <= rbq_z_7;
        end
        rbq_wa_8 <= rbq_wa_n;
        rbq_z_8 <= ra_z_n;
        if (rbq_we_8) begin
            rbm_8[rbq_wa_8] <= rbk_d_8;
            rbz_8[rbq_wa_8] <= rbq_z_8;
        end
        rbq_wa_9 <= rbq_wa_n;
        rbq_z_9 <= ra_z_n;
        if (rbq_we_9) begin
            rbm_9[rbq_wa_9] <= rbk_d_9;
            rbz_9[rbq_wa_9] <= rbq_z_9;
        end
        rbq_wa_10 <= rbq_wa_n;
        rbq_z_10 <= ra_z_n;
        if (rbq_we_10) begin
            rbm_10[rbq_wa_10] <= rbk_d_10;
            rbz_10[rbq_wa_10] <= rbq_z_10;
        end
        rbq_wa_11 <= rbq_wa_n;
        rbq_z_11 <= ra_z_n;
        if (rbq_we_11) begin
            rbm_11[rbq_wa_11] <= rbk_d_11;
            rbz_11[rbq_wa_11] <= rbq_z_11;
        end
        rbq_wa_12 <= rbq_wa_n;
        rbq_z_12 <= ra_z_n;
        if (rbq_we_12) begin
            rbm_12[rbq_wa_12] <= rbk_d_12;
            rbz_12[rbq_wa_12] <= rbq_z_12;
        end
        rbq_wa_13 <= rbq_wa_n;
        rbq_z_13 <= ra_z_n;
        if (rbq_we_13) begin
            rbm_13[rbq_wa_13] <= rbk_d_13;
            rbz_13[rbq_wa_13] <= rbq_z_13;
        end
        rbq_wa_14 <= rbq_wa_n;
        rbq_z_14 <= ra_z_n;
        if (rbq_we_14) begin
            rbm_14[rbq_wa_14] <= rbk_d_14;
            rbz_14[rbq_wa_14] <= rbq_z_14;
        end
        rbq_wa_15 <= rbq_wa_n;
        rbq_z_15 <= ra_z_n;
        if (rbq_we_15) begin
            rbm_15[rbq_wa_15] <= rbk_d_15;
            rbz_15[rbq_wa_15] <= rbq_z_15;
        end
        rbq_wa_16 <= rbq_wa_n;
        rbq_z_16 <= ra_z_n;
        if (rbq_we_16) begin
            rbm_16[rbq_wa_16] <= rbk_d_16;
            rbz_16[rbq_wa_16] <= rbq_z_16;
        end
        rbq_wa_17 <= rbq_wa_n;
        rbq_z_17 <= ra_z_n;
        if (rbq_we_17) begin
            rbm_17[rbq_wa_17] <= rbk_d_17;
            rbz_17[rbq_wa_17] <= rbq_z_17;
        end
        rbq_wa_18 <= rbq_wa_n;
        rbq_z_18 <= ra_z_n;
        if (rbq_we_18) begin
            rbm_18[rbq_wa_18] <= rbk_d_18;
            rbz_18[rbq_wa_18] <= rbq_z_18;
        end
        rbq_wa_19 <= rbq_wa_n;
        rbq_z_19 <= ra_z_n;
        if (rbq_we_19) begin
            rbm_19[rbq_wa_19] <= rbk_d_19;
            rbz_19[rbq_wa_19] <= rbq_z_19;
        end
        rbq_wa_20 <= rbq_wa_n;
        rbq_z_20 <= ra_z_n;
        if (rbq_we_20) begin
            rbm_20[rbq_wa_20] <= rbk_d_20;
            rbz_20[rbq_wa_20] <= rbq_z_20;
        end
        rbq_wa_21 <= rbq_wa_n;
        rbq_z_21 <= ra_z_n;
        if (rbq_we_21) begin
            rbm_21[rbq_wa_21] <= rbk_d_21;
            rbz_21[rbq_wa_21] <= rbq_z_21;
        end
        rbq_wa_22 <= rbq_wa_n;
        rbq_z_22 <= ra_z_n;
        if (rbq_we_22) begin
            rbm_22[rbq_wa_22] <= rbk_d_22;
            rbz_22[rbq_wa_22] <= rbq_z_22;
        end
        rbq_wa_23 <= rbq_wa_n;
        rbq_z_23 <= ra_z_n;
        if (rbq_we_23) begin
            rbm_23[rbq_wa_23] <= rbk_d_23;
            rbz_23[rbq_wa_23] <= rbq_z_23;
        end
        rbq_wa_24 <= rbq_wa_n;
        rbq_z_24 <= ra_z_n;
        if (rbq_we_24) begin
            rbm_24[rbq_wa_24] <= rbk_d_24;
            rbz_24[rbq_wa_24] <= rbq_z_24;
        end
        rbq_wa_25 <= rbq_wa_n;
        rbq_z_25 <= ra_z_n;
        if (rbq_we_25) begin
            rbm_25[rbq_wa_25] <= rbk_d_25;
            rbz_25[rbq_wa_25] <= rbq_z_25;
        end
        rbq_wa_26 <= rbq_wa_n;
        rbq_z_26 <= ra_z_n;
        if (rbq_we_26) begin
            rbm_26[rbq_wa_26] <= rbk_d_26;
            rbz_26[rbq_wa_26] <= rbq_z_26;
        end
        rbq_wa_27 <= rbq_wa_n;
        rbq_z_27 <= ra_z_n;
        if (rbq_we_27) begin
            rbm_27[rbq_wa_27] <= rbk_d_27;
            rbz_27[rbq_wa_27] <= rbq_z_27;
        end
        rbq_wa_28 <= rbq_wa_n;
        rbq_z_28 <= ra_z_n;
        if (rbq_we_28) begin
            rbm_28[rbq_wa_28] <= rbk_d_28;
            rbz_28[rbq_wa_28] <= rbq_z_28;
        end
        rbq_wa_29 <= rbq_wa_n;
        rbq_z_29 <= ra_z_n;
        if (rbq_we_29) begin
            rbm_29[rbq_wa_29] <= rbk_d_29;
            rbz_29[rbq_wa_29] <= rbq_z_29;
        end
        rbq_wa_30 <= rbq_wa_n;
        rbq_z_30 <= ra_z_n;
        if (rbq_we_30) begin
            rbm_30[rbq_wa_30] <= rbk_d_30;
            rbz_30[rbq_wa_30] <= rbq_z_30;
        end
        rbq_wa_31 <= rbq_wa_n;
        rbq_z_31 <= ra_z_n;
        if (rbq_we_31) begin
            rbm_31[rbq_wa_31] <= rbk_d_31;
            rbz_31[rbq_wa_31] <= rbq_z_31;
        end
        rb_raq_0 <= rb_ra_n;
        rb_jq_0 <= rb_j_n;
        rb_raq_1 <= rb_ra_n;
        rb_jq_1 <= rb_j_n;
        rb_raq_2 <= rb_ra_n;
        rb_jq_2 <= rb_j_n;
        rb_raq_3 <= rb_ra_n;
        rb_jq_3 <= rb_j_n;
        rb_raq_4 <= rb_ra_n;
        rb_jq_4 <= rb_j_n;
        rb_raq_5 <= rb_ra_n;
        rb_jq_5 <= rb_j_n;
        rb_raq_6 <= rb_ra_n;
        rb_jq_6 <= rb_j_n;
        rb_raq_7 <= rb_ra_n;
        rb_jq_7 <= rb_j_n;
        rb_raq_8 <= rb_ra_n;
        rb_jq_8 <= rb_j_n;
        rb_raq_9 <= rb_ra_n;
        rb_jq_9 <= rb_j_n;
        rb_raq_10 <= rb_ra_n;
        rb_jq_10 <= rb_j_n;
        rb_raq_11 <= rb_ra_n;
        rb_jq_11 <= rb_j_n;
        rb_raq_12 <= rb_ra_n;
        rb_jq_12 <= rb_j_n;
        rb_raq_13 <= rb_ra_n;
        rb_jq_13 <= rb_j_n;
        rb_raq_14 <= rb_ra_n;
        rb_jq_14 <= rb_j_n;
        rb_raq_15 <= rb_ra_n;
        rb_jq_15 <= rb_j_n;
        if (kw_take) begin
            if ((~dq_byp)) begin
                dq_ins[dq_wi] <= u_kw_out_inst;
                dq_av[dq_wi] <= u_kw_rda_val;
                dq_bv[dq_wi] <= u_kw_rdb_val;
                dq_prog[dq_wi] <= kprog;
                dq_npf[dq_wi] <= u_kw_out_inst[127];
            end
        end
        pq_ins <= dq_ins[pf_idx_q];
        pq_bv <= dq_bv[pf_idx_q];
        if (pf_can) begin
            pf_base <= n_bbase;
            pf_strd <= n_bstrd;
        end
        sc_res_q <= sc_res;
        sc_s0_g_0 <= sc_s0_n;
        sc_s1_g_0 <= sc_s1_n;
        sc_s0_g_1 <= sc_s0_n;
        sc_s1_g_1 <= sc_s1_n;
        sc_s0_g_2 <= sc_s0_n;
        sc_s1_g_2 <= sc_s1_n;
        sc_s0_g_3 <= sc_s0_n;
        sc_s1_g_3 <= sc_s1_n;
        if (((sc_rd_q & sc_rv) & (lbeat == 0))) begin
            sc_beat <= rd_beat;
        end
        if ((~sc_act)) begin
            sreg <= sc_beat;
        end
        case (state)
            0: begin
            end
            36: begin
                st_rows <= f_rows;
                a_base <= a_base_c;
                b_base <= b_base_c;
                d_base <= d_base_c;
                a_strd <= a_strd_c;
                b_strd <= b_strd_c;
            end
            35: begin
            end
            8: begin
            end
            34: begin
            end
            2: begin
                aseq_tab[cur_slot] <= (lda_seq + 1);
            end
            14: begin
                if ((~sb_hit)) begin
                    st_addr <= d_base;
                end
            end
        endcase
    end

    LoaderA u_lda (
        .clk(clk),
        .rst_n(rst_n),
        .start(lda_start),
        .p_base(a_base),
        .p_strd(a_strd),
        .p_rowb(a_rowb),
        .p_nrows({1'd0, f_M}),
        .p_cfg(a_cfg),
        .p_klim({1'd0, f_K}),
        .p_set(aset_new),
        .p_tag(lda_seq),
        .p_slot(cur_slot),
        .ar_gnt(lda_gnt),
        .r_valid(lda_rv),
        .r_data(lda_rd),
        .aw_en(u_lda_aw_en),
        .set_q(u_lda_set_q),
        .aw_m(u_lda_aw_m),
        .aw_en_r(u_lda_aw_en_r),
        .aw_m_r(u_lda_aw_m_r),
        .aw_set_r(u_lda_aw_set_r),
        .aw_data(u_lda_aw_data),
        .aw_e_en(u_lda_aw_e_en),
        .aw_e(u_lda_aw_e),
        .busy(u_lda_busy),
        .fx_free(u_lda_fx_free),
        .rows_done0(u_lda_rows_done0),
        .rows_done1(u_lda_rows_done1),
        .tag_q0(u_lda_tag_q0),
        .tag_q1(u_lda_tag_q1),
        .ar_req(u_lda_ar_req),
        .ar_addr(u_lda_ar_addr),
        .ar_bytes(u_lda_ar_bytes),
        .ar_cfg(u_lda_ar_cfg),
        .ar_first(u_lda_ar_first),
        .ar_last(u_lda_ar_last),
        .slot_q(u_lda_slot_q),
        .done_p(u_lda_done_p),
        .done_slot(u_lda_done_slot)
    );
    LoaderB u_ldb (
        .clk(clk),
        .rst_n(rst_n),
        .start((ldb_start | ldb_start_p)),
        .p_base((ldb_start_p ? pf_base : b_base)),
        .p_strd((ldb_start_p ? pf_strd : b_strd)),
        .p_rowb((ldb_start_p ? pf_rowb : b_rowb)),
        .p_nrows((ldb_start_p ? pf_nrows : b_rows)),
        .p_cfg((ldb_start_p ? pf_cfg : b_cfg)),
        .p_klim((ldb_start_p ? pf_klim : b_klim)),
        .p_set((ldb_start_p ? pf_bset : bset_new)),
        .p_tag(ldb_seq),
        .p_slot((ldb_start_p ? pf_slot : cur_slot)),
        .p_q8((ldb_start_p ? pf_q8 : is_q8)),
        .p_kmj((ldb_start_p ? pf_kmj : kmj)),
        .p_strm((ldb_start_p ? pf_strm : b_strm)),
        .ar_gnt(ldb_gnt),
        .r_valid(ldb_rv),
        .r_data(ldb_rd),
        .bw_en(u_ldb_bw_en),
        .set_q(u_ldb_set_q),
        .kmj(u_ldb_kmj),
        .bw_r(u_ldb_bw_r),
        .bw_data(u_ldb_bw_data),
        .bw_e_en(u_ldb_bw_e_en),
        .bw_eb(u_ldb_bw_eb),
        .clr_q(u_ldb_clr_q),
        .clr_set(u_ldb_clr_set),
        .bw_data2(u_ldb_bw_data2),
        .bw_eb2(u_ldb_bw_eb2),
        .bw_dual(u_ldb_bw_dual),
        .busy(u_ldb_busy),
        .fx_free(u_ldb_fx_free),
        .rows_done0(u_ldb_rows_done0),
        .rows_done1(u_ldb_rows_done1),
        .tag_q0(u_ldb_tag_q0),
        .tag_q1(u_ldb_tag_q1),
        .ar_req(u_ldb_ar_req),
        .ar_addr(u_ldb_ar_addr),
        .ar_bytes(u_ldb_ar_bytes),
        .ar_cfg(u_ldb_ar_cfg),
        .ar_first(u_ldb_ar_first),
        .ar_last(u_ldb_ar_last),
        .slot_q(u_ldb_slot_q),
        .done_p(u_ldb_done_p),
        .done_slot(u_ldb_done_slot)
    );
    Mac2dArray u_arr (
        .clk(clk),
        .rst_n(rst_n),
        .aw_en(u_lda_aw_en),
        .aw_set(u_lda_set_q),
        .aw_m(u_lda_aw_m),
        .aw_en_rg(u_lda_aw_en_r),
        .aw_m_rg(u_lda_aw_m_r),
        .aw_set_rg(u_lda_aw_set_r),
        .aw_data(u_lda_aw_data),
        .aw_e_en(u_lda_aw_e_en),
        .aw_e(u_lda_aw_e),
        .bw_en(u_ldb_bw_en),
        .bw_set(u_ldb_set_q),
        .bw_kmj(u_ldb_kmj),
        .bw_r(u_ldb_bw_r),
        .bw_data(u_ldb_bw_data),
        .bw_e_en(u_ldb_bw_e_en),
        .bw_eb(u_ldb_bw_eb),
        .bw_clr(u_ldb_clr_q),
        .bw_clr_set(u_ldb_clr_set),
        .bw_data2(u_ldb_bw_data2),
        .bw_eb2(u_ldb_bw_eb2),
        .bw_dual(u_ldb_bw_dual),
        .job_valid(job_v),
        .job_word(job_w),
        .flush(flush_q),
        .pl_rdata(accq),
        .pl_rz(pl_zero_q),
        .dr_ready(1'd1),
        .qmask(qmask),
        .jq_cnt(u_arr_jq_cnt),
        .busy(u_arr_busy),
        .held_valid(u_arr_held_valid),
        .held_slot(u_arr_held_slot),
        .ause(u_arr_ause),
        .buse(u_arr_buse),
        .dr_valid(u_arr_dr_valid),
        .dr_slot(u_arr_dr_slot),
        .dr_rp(u_arr_dr_rp),
        .dr_last(u_arr_dr_last),
        .dr_data(u_arr_dr_data),
        .pl_rslot(u_arr_pl_rslot),
        .pl_rrp(u_arr_pl_rrp),
        .pl_rd(u_arr_pl_rd),
        .dr_valid_c(u_arr_dr_valid_c),
        .dr_wa_c(u_arr_dr_wa_c),
        .qbusy(u_arr_qbusy),
        .acc_occ(u_arr_acc_occ)
    );
    FpMulX sc_m0 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[31:0]),
        .b_in(sc_s0_g_0),
        .res(sc_m0_res)
    );
    FpMulX sc_m1 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[63:32]),
        .b_in(sc_s0_g_0),
        .res(sc_m1_res)
    );
    FpMulX sc_m2 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[95:64]),
        .b_in(sc_s0_g_0),
        .res(sc_m2_res)
    );
    FpMulX sc_m3 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[127:96]),
        .b_in(sc_s0_g_0),
        .res(sc_m3_res)
    );
    FpMulX sc_m4 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[159:128]),
        .b_in(sc_s0_g_1),
        .res(sc_m4_res)
    );
    FpMulX sc_m5 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[191:160]),
        .b_in(sc_s0_g_1),
        .res(sc_m5_res)
    );
    FpMulX sc_m6 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[223:192]),
        .b_in(sc_s0_g_1),
        .res(sc_m6_res)
    );
    FpMulX sc_m7 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[255:224]),
        .b_in(sc_s0_g_1),
        .res(sc_m7_res)
    );
    FpMulX sc_m8 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[287:256]),
        .b_in(sc_s0_g_2),
        .res(sc_m8_res)
    );
    FpMulX sc_m9 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[319:288]),
        .b_in(sc_s0_g_2),
        .res(sc_m9_res)
    );
    FpMulX sc_m10 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[351:320]),
        .b_in(sc_s0_g_2),
        .res(sc_m10_res)
    );
    FpMulX sc_m11 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[383:352]),
        .b_in(sc_s0_g_2),
        .res(sc_m11_res)
    );
    FpMulX sc_m12 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[415:384]),
        .b_in(sc_s0_g_3),
        .res(sc_m12_res)
    );
    FpMulX sc_m13 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[447:416]),
        .b_in(sc_s0_g_3),
        .res(sc_m13_res)
    );
    FpMulX sc_m14 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[479:448]),
        .b_in(sc_s0_g_3),
        .res(sc_m14_res)
    );
    FpMulX sc_m15 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[511:480]),
        .b_in(sc_s0_g_3),
        .res(sc_m15_res)
    );
    FpMulX sc_m16 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[543:512]),
        .b_in(sc_s1_g_0),
        .res(sc_m16_res)
    );
    FpMulX sc_m17 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[575:544]),
        .b_in(sc_s1_g_0),
        .res(sc_m17_res)
    );
    FpMulX sc_m18 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[607:576]),
        .b_in(sc_s1_g_0),
        .res(sc_m18_res)
    );
    FpMulX sc_m19 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[639:608]),
        .b_in(sc_s1_g_0),
        .res(sc_m19_res)
    );
    FpMulX sc_m20 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[671:640]),
        .b_in(sc_s1_g_1),
        .res(sc_m20_res)
    );
    FpMulX sc_m21 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[703:672]),
        .b_in(sc_s1_g_1),
        .res(sc_m21_res)
    );
    FpMulX sc_m22 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[735:704]),
        .b_in(sc_s1_g_1),
        .res(sc_m22_res)
    );
    FpMulX sc_m23 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[767:736]),
        .b_in(sc_s1_g_1),
        .res(sc_m23_res)
    );
    FpMulX sc_m24 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[799:768]),
        .b_in(sc_s1_g_2),
        .res(sc_m24_res)
    );
    FpMulX sc_m25 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[831:800]),
        .b_in(sc_s1_g_2),
        .res(sc_m25_res)
    );
    FpMulX sc_m26 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[863:832]),
        .b_in(sc_s1_g_2),
        .res(sc_m26_res)
    );
    FpMulX sc_m27 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[895:864]),
        .b_in(sc_s1_g_2),
        .res(sc_m27_res)
    );
    FpMulX sc_m28 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[927:896]),
        .b_in(sc_s1_g_3),
        .res(sc_m28_res)
    );
    FpMulX sc_m29 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[959:928]),
        .b_in(sc_s1_g_3),
        .res(sc_m29_res)
    );
    FpMulX sc_m30 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[991:960]),
        .b_in(sc_s1_g_3),
        .res(sc_m30_res)
    );
    FpMulX sc_m31 (
        .clk(clk),
        .rst_n(rst_n),
        .a_in(accq_z[1023:992]),
        .b_in(sc_s1_g_3),
        .res(sc_m31_res)
    );
    StoreRow u_sr (
        .q16(mq_q16),
        .sel16({mq_s16_7, mq_s16_6, mq_s16_5, mq_s16_4, mq_s16_3, mq_s16_2, mq_s16_1, mq_s16_0}),
        .selh({mq_sh_7, mq_sh_6, mq_sh_5, mq_sh_4, mq_sh_3, mq_sh_2, mq_sh_1, mq_sh_0}),
        .sell({mq_sl_7, mq_sl_6, mq_sl_5, mq_sl_4, mq_sl_3, mq_sl_2, mq_sl_1, mq_sl_0}),
        .nbytes(mq_nb),
        .beat(mq_beat),
        .seg(u_sr_seg),
        .strb(u_sr_strb)
    );
    KSeqWalker u_kw (
        .clk(clk),
        .rst_n(rst_n),
        .im_data(rd_q),
        .lc_v(lc_go),
        .lc_id(ld_id[15:0]),
        .lc_first(ld_off),
        .lc_len(ld_len),
        .out_rdy(kw_rdy),
        .rd_idx(6'd0),
        .rda_idx(kw_va),
        .rdb_idx(kw_vb),
        .inval(isram_wen),
        .out_inst(u_kw_out_inst),
        .lc_ready(u_kw_lc_ready),
        .busy(u_kw_busy),
        .out_v(u_kw_out_v),
        .im_addr(u_kw_im_addr),
        .im_req(u_kw_im_req),
        .rda_val(u_kw_rda_val),
        .rdb_val(u_kw_rdb_val)
    );
endmodule
