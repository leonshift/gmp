module Vec1D #(
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
    input [511:0] l1_r_data,
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
    input [511:0] noc_r_data,
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
    output logic dbg_wb,
    output logic dbg_badop,
    output logic [31:0] nopc
);
    localparam S_IDLE = 0;
    localparam S_EX = 1;
    localparam S_RCP = 2;
    localparam S_RED = 3;
    localparam S_LDREQ = 5;
    localparam S_LDRD = 6;
    localparam S_FRD = 7;
    localparam S_LDWB = 8;
    localparam S_STW = 11;
    localparam S_STB = 12;
    localparam S_SEX = 13;
    localparam S_FUN = 14;
    localparam S_SLDREQ = 15;
    localparam S_SLDRD = 16;
    localparam S_SLDWB = 17;
    localparam S_SSTREQ = 18;
    localparam S_SSTW = 19;
    localparam S_SSTB = 20;
    localparam S_SFUN = 21;
    localparam S_RXWAIT = 27;
    localparam S_RXWB = 28;
    localparam S_IXCVT = 29;
    localparam S_IXADD = 30;
    localparam S_IXMUL = 25;
    localparam S_NOP = 31;
    logic [127:0] cq_i [0:7];
    logic [3:0] cq_wp;
    logic [3:0] cq_rp;
    logic [31:0] lq_id [0:7];
    logic [23:0] lq_off [0:7];
    logic [15:0] lq_len [0:7];
    logic [3:0] lq_wp;
    logic [3:0] lq_rp;
    logic [3:0] lq_n;
    logic [31:0] im0 [0:1023];
    logic [31:0] im1 [0:1023];
    logic [31:0] im2 [0:1023];
    logic [31:0] im3 [0:1023];
    logic [127:0] rd_q;
    logic [15:0] seqfree;
    logic ld_v;
    logic [31:0] ld_id;
    logic [23:0] ld_off;
    logic [15:0] ld_len;
    logic [15:0] tick;
    logic [127:0] gA0 [0:255];
    logic [127:0] gA1 [0:255];
    logic [127:0] gA2 [0:255];
    logic [127:0] gA3 [0:255];
    logic [127:0] gA4 [0:255];
    logic [127:0] gA5 [0:255];
    logic [127:0] gA6 [0:255];
    logic [127:0] gA7 [0:255];
    logic [127:0] gB0 [0:255];
    logic [127:0] gB1 [0:255];
    logic [127:0] gB2 [0:255];
    logic [127:0] gB3 [0:255];
    logic [127:0] gB4 [0:255];
    logic [127:0] gB5 [0:255];
    logic [127:0] gB6 [0:255];
    logic [127:0] gB7 [0:255];
    logic [7:0] gAE [0:255];
    logic [7:0] gBE [0:255];
    logic [127:0] ra0;
    logic [127:0] ra1;
    logic [127:0] ra2;
    logic [127:0] ra3;
    logic [127:0] ra4;
    logic [127:0] ra5;
    logic [127:0] ra6;
    logic [127:0] ra7;
    logic [127:0] rb0;
    logic [127:0] rb1;
    logic [127:0] rb2;
    logic [127:0] rb3;
    logic [127:0] rb4;
    logic [127:0] rb5;
    logic [127:0] rb6;
    logic [127:0] rb7;
    logic [7:0] ra_e;
    logic [7:0] d1_ea;
    logic [7:0] d1_eb;
    logic [3:0] d1_op;
    logic d1_isw;
    logic [7:0] d1_evt;
    logic [15:0] d1_vt;
    logic [16:0] oha_c;
    logic [16:0] ohb_c;
    logic [16:0] oha_g_0;
    logic [16:0] oha_g_1;
    logic [16:0] oha_g_2;
    logic [16:0] oha_g_3;
    logic [16:0] oha_g_4;
    logic [16:0] oha_g_5;
    logic [16:0] oha_g_6;
    logic [16:0] oha_g_7;
    logic [16:0] ohb_g_0;
    logic [16:0] ohb_g_1;
    logic [16:0] ohb_g_2;
    logic [16:0] ohb_g_3;
    logic [16:0] ohb_g_4;
    logic [16:0] ohb_g_5;
    logic [16:0] ohb_g_6;
    logic [16:0] ohb_g_7;
    logic [9:0] d_eo;
    logic [16:0] d_voh_g_0;
    logic [16:0] d_voh_g_1;
    logic [16:0] d_voh_g_2;
    logic [16:0] d_voh_g_3;
    logic [16:0] d_voh_g_4;
    logic [16:0] d_voh_g_5;
    logic [16:0] d_voh_g_6;
    logic [16:0] d_voh_g_7;
    logic [15:0] d_vt_g_0;
    logic [15:0] d_vt_g_1;
    logic [15:0] d_vt_g_2;
    logic [15:0] d_vt_g_3;
    logic [15:0] d_vt_g_4;
    logic [15:0] d_vt_g_5;
    logic [15:0] d_vt_g_6;
    logic [15:0] d_vt_g_7;
    logic [15:0] vtq_g_0;
    logic [15:0] vtq_g_1;
    logic [15:0] vtq_g_2;
    logic [15:0] vtq_g_3;
    logic [15:0] vtq_g_4;
    logic [15:0] vtq_g_5;
    logic [15:0] vtq_g_6;
    logic [15:0] vtq_g_7;
    logic [31:0] sr [0:15];
    logic ift_v_0;
    logic ift_v_1;
    logic ift_v_2;
    logic ift_v_3;
    logic ift_mem [0:3];
    logic ift_mdone [0:3];
    logic [4:0] ift_wb [0:3];
    logic sq_act;
    logic [5:0] sq_out;
    logic sq_all;
    logic [1:0] sq_slot;
    logic sq_l1;
    logic [2:0] cred_l1;
    logic [2:0] cred_llc;
    logic [127:0] cur;
    logic [1:0] cur_slot;
    logic [4:0] cur_ns;
    logic [4:0] cur_nsm1;
    logic [63:0] cur_tlm;
    logic [15:0] cur_rid;
    logic [3:0] cur_ra;
    logic [3:0] cur_rb;
    logic [3:0] slice_i;
    logic exph;
    logic [4:0] ar_sl;
    logic [4:0] aw_sl;
    logic [4:0] pr_sl;
    logic pr_v;
    logic w_act;
    logic [3:0] beat;
    logic cur_port;
    logic [6:0] cur_tl;
    logic [47:0] cur_laddr;
    logic [47:0] ar_nx;
    logic [47:0] aw_nx;
    logic [8:0] ld_step;
    logic [7:0] cur_cfg;
    logic cur_sf;
    logic [31:0] cur_c32;
    logic cur_cint;
    logic [2:0] cur_nb;
    logic [2:0] cur_wnb;
    logic [2:0] cur_wns;
    logic [7:0] cur_wlb;
    logic [2:0] bt_nb_f;
    logic [2:0] bt_nb_t;
    logic [2:0] bt_wnb_f;
    logic [2:0] bt_wnb_t;
    logic [7:0] bt_wlb_f;
    logic [7:0] bt_wlb_t;
    logic [8:0] bt_by_t;
    logic [2:0] pa_st;
    logic [127:0] pa_ins;
    logic [47:0] pa_lad;
    logic [29:0] pa_u;
    logic pa_ng;
    logic [17:0] pa_s;
    logic [18:0] pa_sp;
    logic [47:0] pa_pl;
    logic [47:0] pa_ph;
    logic [3:0] pa_rp;
    logic [19:0] pa_bytes;
    logic [7:0] pa_cfg;
    logic pa_port;
    logic pa_scal;
    logic pa_last;
    logic [4:0] pa_sl;
    logic [4:0] pa_ns;
    logic [1:0] pa_vsh;
    logic [6:0] pa_tl;
    logic [47:0] pa_nx;
    logic [8:0] pa_step;
    logic [8:0] pa_by_t;
    logic [2:0] rcp_c;
    logic rcp_sc;
    logic rcp_sf;
    logic [31:0] rcp_r;
    logic v0_v;
    logic v0_ph;
    logic [1:0] v0_src;
    logic [3:0] v0_op;
    logic v0_isw;
    logic v0_bm_g_0;
    logic v0_bm_g_1;
    logic v0_bm_g_2;
    logic v0_bm_g_3;
    logic v0_bm_g_4;
    logic v0_bm_g_5;
    logic v0_bm_g_6;
    logic v0_bm_g_7;
    logic [15:0] v0_b16_g_0;
    logic [15:0] v0_b16_g_1;
    logic [15:0] v0_b16_g_2;
    logic [15:0] v0_b16_g_3;
    logic [15:0] v0_b16_g_4;
    logic [15:0] v0_b16_g_5;
    logic [15:0] v0_b16_g_6;
    logic [15:0] v0_b16_g_7;
    logic [31:0] v0_c32;
    logic [31:0] v0_lbase;
    logic [7:0] v0_dst8;
    logic [1:0] v0_slot;
    logic v1_v;
    logic v1_ph;
    logic [3:0] v1_op_g_0;
    logic [3:0] v1_op_g_1;
    logic [3:0] v1_op_g_2;
    logic [3:0] v1_op_g_3;
    logic [3:0] v1_op_g_4;
    logic [3:0] v1_op_g_5;
    logic [3:0] v1_op_g_6;
    logic [3:0] v1_op_g_7;
    logic v1_isw_g_0;
    logic v1_isw_g_1;
    logic v1_isw_g_2;
    logic v1_isw_g_3;
    logic v1_isw_g_4;
    logic v1_isw_g_5;
    logic v1_isw_g_6;
    logic v1_isw_g_7;
    logic [1:0] v1_src;
    logic [31:0] v1_c32;
    logic [31:0] v1_lbase;
    logic [7:0] v1_dst8;
    logic [1:0] v1_slot;
    logic v2_v;
    logic v2_ph;
    logic [1:0] v2_src;
    logic [31:0] v2_c32;
    logic [31:0] v2_lbase;
    logic [7:0] v2_dst8;
    logic [1:0] v2_slot;
    logic v3_v;
    logic v3_ph;
    logic [1:0] v3_src;
    logic [31:0] v3_c32;
    logic [31:0] v3_lbase;
    logic [7:0] v3_dst8;
    logic [1:0] v3_slot;
    logic v4_v;
    logic v4_ph;
    logic [1:0] v4_src;
    logic [31:0] v4_lbase;
    logic [15:0] v4_cf;
    logic [7:0] v4_ce;
    logic [7:0] v4_dst8;
    logic [1:0] v4_slot;
    logic v5_v;
    logic v5_ph;
    logic [1:0] v5_src;
    logic [15:0] v5_cf_g_0;
    logic [15:0] v5_cf_g_1;
    logic [15:0] v5_cf_g_2;
    logic [15:0] v5_cf_g_3;
    logic [15:0] v5_cf_g_4;
    logic [15:0] v5_cf_g_5;
    logic [15:0] v5_cf_g_6;
    logic [15:0] v5_cf_g_7;
    logic [7:0] v5_ce;
    logic [7:0] v5_dst8;
    logic [1:0] v5_slot;
    logic w_v;
    logic [1:0] w_src;
    logic [15:0] w_cf_g_0;
    logic [15:0] w_cf_g_1;
    logic [15:0] w_cf_g_2;
    logic [15:0] w_cf_g_3;
    logic [15:0] w_cf_g_4;
    logic [15:0] w_cf_g_5;
    logic [15:0] w_cf_g_6;
    logic [15:0] w_cf_g_7;
    logic [7:0] w_e;
    logic [7:0] w_dst8;
    logic [1:0] w_slot;
    logic [19:0] r0_meta;
    logic [63:0] r0_lm;
    logic [31:0] racc;
    logic [31:0] raccm;
    logic rph;
    logic r9d_v;
    logic r9d_first;
    logic r9d_last;
    logic [1:0] r9d_kind;
    logic r9d_mode;
    logic r9d_acc;
    logic [3:0] r9d_gix;
    logic [3:0] r9d_dst;
    logic [1:0] r9d_slot;
    logic [31:0] r9d_res;
    logic rw_v;
    logic [31:0] rw_val;
    logic [31:0] rw_valm;
    logic [1:0] rw_kind;
    logic [3:0] rw_dst;
    logic [1:0] rw_slot;
    logic [23:0] gres [0:15];
    logic gw_v;
    logic [3:0] gw_idx;
    logic [31:0] gw_s;
    logic [31:0] gw_m;
    logic gw_k;
    logic [31:0] gw_sel;
    logic [3:0] rg_sh_q;
    logic [3:0] rx_wg_q;
    logic [3:0] rx_wsl_n;
    logic [23:0] gres_rd;
    logic sb_v;
    logic [15:0] sb_f_g_0;
    logic [15:0] sb_f_g_1;
    logic [15:0] sb_f_g_2;
    logic [15:0] sb_f_g_3;
    logic [15:0] sb_f_g_4;
    logic [15:0] sb_f_g_5;
    logic [15:0] sb_f_g_6;
    logic [15:0] sb_f_g_7;
    logic [7:0] sb_e;
    logic [7:0] sb_dst8;
    logic [1:0] sb_slot;
    logic [1:0] fb;
    logic [255:0] fx0_x;
    logic [7:0] fx0_es_g_0;
    logic [7:0] fx0_es_g_1;
    logic [7:0] fx0_es_g_2;
    logic [7:0] fx0_es_g_3;
    logic [2:0] fx0_fn_g_0;
    logic [2:0] fx0_fn_g_1;
    logic [2:0] fx0_fn_g_2;
    logic [2:0] fx0_fn_g_3;
    logic [15:0] fx0_kc_g_0;
    logic [15:0] fx0_kc_g_1;
    logic [15:0] fx0_kc_g_2;
    logic [15:0] fx0_kc_g_3;
    logic [13:0] fm0;
    logic [13:0] fm1;
    logic [13:0] fm2;
    logic [13:0] fm3;
    logic [13:0] fm4;
    logic [13:0] fm5;
    logic [13:0] fm6;
    logic [13:0] fm7;
    logic [13:0] fm8;
    logic [13:0] fm9;
    logic [13:0] fm10;
    logic [13:0] fm11;
    logic [303:0] fq_m0;
    logic [303:0] fq_m1;
    logic [303:0] fq_m2;
    logic [143:0] fq_e0;
    logic [143:0] fq_e1;
    logic [143:0] fq_e2;
    logic [15:0] fq_s0;
    logic [15:0] fq_s1;
    logic [15:0] fq_s2;
    logic [63:0] pkh_s;
    logic [1215:0] pkh_m;
    logic [575:0] pkh_e;
    logic pk_v;
    logic [7:0] pk_dst8;
    logic [1:0] pk_slot;
    logic pk2_v;
    logic [7:0] pk2_dst8;
    logic [1:0] pk2_slot;
    logic pk3_v;
    logic [7:0] pk3_dst8;
    logic [1:0] pk3_slot;
    logic pk4_v;
    logic [7:0] pk4_dst8;
    logic [1:0] pk4_slot;
    logic pk5_v;
    logic [7:0] pk5_dst8;
    logic [1:0] pk5_slot;
    logic l5_v;
    logic [7:0] l5_e;
    logic [7:0] l5_dst8;
    logic [1:0] l5_slot;
    logic sf2_v;
    logic [31:0] sf2_val;
    logic [3:0] sf2_dst;
    logic [1:0] sf2_slot;
    logic s0_v;
    logic [31:0] s0_a32;
    logic [31:0] s0_b32;
    logic [3:0] s0_op;
    logic s0_isc;
    logic [31:0] s0_c32;
    logic s0_cint;
    logic [3:0] s0_dst;
    logic [1:0] s0_slot;
    logic s1_v;
    logic s1_isc;
    logic [31:0] s1_c32;
    logic s1_cint;
    logic [38:0] s1_cpk;
    logic [3:0] s1_dst;
    logic [1:0] s1_slot;
    logic s2_v;
    logic [31:0] s2_val;
    logic [3:0] s2_dst;
    logic [1:0] s2_slot;
    logic l2_v;
    logic [1023:0] l2_row;
    logic l2f_g_0;
    logic l2f_g_1;
    logic l2f_g_2;
    logic l2f_g_3;
    logic l2f_g_4;
    logic l2f_g_5;
    logic l2f_g_6;
    logic l2f_g_7;
    logic l2f_g_8;
    logic l2f_g_9;
    logic l2f_g_10;
    logic l2f_g_11;
    logic l2f_g_12;
    logic l2f_g_13;
    logic l2f_g_14;
    logic l2f_g_15;
    logic [7:0] l2_e;
    logic [7:0] l2_dst8;
    logic [1:0] l2_slot;
    logic sl2_v;
    logic [31:0] sl2_val;
    logic sl2_i;
    logic [38:0] sl2_ipk;
    logic [3:0] sl2_dst;
    logic [1:0] sl2_slot;
    logic [2:0] ldw_st;
    logic ldw_go;
    logic [63:0] vlm_q;
    logic [87:0] ld0;
    logic [511:0] ldp;
    logic [511:0] ldq;
    logic ex_v;
    logic [3:0] ex_beat;
    logic ld_hs_pre;
    logic [511:0] lbw;
    logic lbw_ce;
    logic lbw_v;
    logic [3:0] lbw_beat;
    logic lbw_tail;
    logic hs2;
    logic lbq_v;
    logic [3:0] lbq_beat;
    logic lbq_tail;
    logic hs3;
    logic [15:0] lbq_s0;
    logic [15:0] lbq_s1;
    logic [15:0] lbq_s2;
    logic [15:0] lbq_s3;
    logic [127:0] lbq_e0;
    logic [127:0] lbq_e1;
    logic [127:0] lbq_e2;
    logic [127:0] lbq_e3;
    logic [239:0] lbq_m0;
    logic [239:0] lbq_m1;
    logic [239:0] lbq_m2;
    logic [239:0] lbq_m3;
    logic lx_en_0;
    logic lx_en_1;
    logic lx_en_2;
    logic lx_en_3;
    logic [1:0] lx_src_0;
    logic [1:0] lx_src_1;
    logic [1:0] lx_src_2;
    logic [1:0] lx_src_3;
    logic [15:0] lxs0;
    logic [15:0] lxs1;
    logic [15:0] lxs2;
    logic [15:0] lxs3;
    logic [127:0] lxe0;
    logic [127:0] lxe1;
    logic [127:0] lxe2;
    logic [127:0] lxe3;
    logic [239:0] lxm0;
    logic [239:0] lxm1;
    logic [239:0] lxm2;
    logic [239:0] lxm3;
    logic ld_hs;
    logic ldw_busy;
    logic [3:0] ldw_sl;
    logic [3:0] ldw_dst;
    logic [1:0] ldw_slot;
    logic [63:0] ldw_vlm;
    logic [4:0] state;
    logic [3:0] rx_wsl;
    logic busy_r;
    logic [15:0] donec;
    logic retire_p;
    logic wb_p;
    logic badop_r;
    logic [1023:0] ra_row;
    logic [1023:0] rb_row;
    logic [7:0] ae_c;
    logic [7:0] be_c;
    logic is_vdiv;
    logic is_sdiv;
    logic [31:0] vop_b;
    logic [31:0] sop_b;
    logic [31:0] vb_sr;
    logic [31:0] vb_im;
    logic vb_is_sr;
    logic [7:0] b2s_e;
    logic [15:0] b2s_f;
    logic [31:0] vt_sr;
    logic [31:0] vt_im;
    logic [7:0] vt2s_e;
    logic [15:0] vt2s_f;
    logic bmode_c;
    logic [7:0] eb_c;
    logic [3:0] op_c;
    logic isw_c;
    logic [8:0] vdt9;
    logic [16:0] voh_c;
    logic [47:0] vta_p_0;
    logic [47:0] vta_p_1;
    logic [47:0] vta_p_2;
    logic [47:0] vta_p_3;
    logic [47:0] vta_p_4;
    logic [47:0] vta_p_5;
    logic [47:0] vta_p_6;
    logic [47:0] vta_p_7;
    logic [15:0] vtal_g_0;
    logic [15:0] vtal_g_1;
    logic [15:0] vtal_g_2;
    logic [15:0] vtal_g_3;
    logic [15:0] vtal_g_4;
    logic [15:0] vtal_g_5;
    logic [15:0] vtal_g_6;
    logic [15:0] vtal_g_7;
    logic [127:0] b_row_g_0;
    logic [127:0] b_row_g_1;
    logic [127:0] b_row_g_2;
    logic [127:0] b_row_g_3;
    logic [127:0] b_row_g_4;
    logic [127:0] b_row_g_5;
    logic [127:0] b_row_g_6;
    logic [127:0] b_row_g_7;
    logic [1023:0] b_row;
    logic nrm_rv;
    logic lidx_v;
    logic [127:0] exd_g_0;
    logic [127:0] exd_g_1;
    logic [127:0] exd_g_2;
    logic [127:0] exd_g_3;
    logic [127:0] exd_g_4;
    logic [127:0] exd_g_5;
    logic [127:0] exd_g_6;
    logic [127:0] exd_g_7;
    logic [1023:0] w_f;
    logic [7:0] exd_e;
    logic [2:0] mem_dt;
    logic esz4;
    logic [2:0] esz;
    logic [2:0] vdt_q;
    logic [2:0] vdt;
    logic [1:0] vsh;
    logic is_rseg;
    logic [3:0] rsl;
    logic is_rx;
    logic [3:0] rg_sh;
    logic [4:0] rg_msk_w;
    logic [3:0] rg_msk;
    logic [7:0] rdst;
    logic r_first;
    logic r_last;
    logic [15:0] red_ident;
    logic [1023:0] red_row;
    logic [63:0] red_lm_c;
    logic [31:0] red_res;
    logic [19:0] red_mo;
    logic r9_v;
    logic r9_first;
    logic r9_last;
    logic [1:0] r9_kind;
    logic r9_mode;
    logic [3:0] r9_sl;
    logic r9_acc;
    logic [3:0] r9_dst;
    logic [1:0] r9_slot;
    logic [19:0] bo_m;
    logic bo_v;
    logic [7:0] bo_dst;
    logic [1:0] bo_slot;
    logic [31:0] racc_n;
    logic mm_lt;
    logic mm_sel;
    logic [31:0] raccm_n;
    logic [31:0] rw_out;
    logic [31:0] s1_val;
    logic [31:0] rcp_in;
    logic vl_last;
    logic [6:0] vl_cur;
    logic [63:0] vl_lm;
    logic in_ldwb;
    logic [511:0] lb_hi;
    logic [511:0] lb_lo;
    logic [1023:0] lb_pair;
    logic [567:0] lb_c;
    logic [567:0] lb_al;
    logic [511:0] lb_dat;
    logic [15:0] lbx_s_0;
    logic [15:0] lbx_s_1;
    logic [15:0] lbx_s_2;
    logic [15:0] lbx_s_3;
    logic [127:0] lbx_e_0;
    logic [127:0] lbx_e_1;
    logic [127:0] lbx_e_2;
    logic [127:0] lbx_e_3;
    logic [239:0] lbx_m_0;
    logic [239:0] lbx_m_1;
    logic [239:0] lbx_m_2;
    logic [239:0] lbx_m_3;
    logic [9:0] ld_na;
    logic [2:0] ld_na6;
    logic ld_byp;
    logic is32v;
    logic is8v;
    logic tl0;
    logic tl1;
    logic tl2;
    logic tl3;
    logic [1:0] bysrc_0;
    logic [1:0] bysrc_1;
    logic [1:0] bysrc_2;
    logic [1:0] bysrc_3;
    logic is16v;
    logic lxw_c_0;
    logic lxw_c_1;
    logic lxw_c_2;
    logic lxw_c_3;
    logic [1:0] lxsrc_c_0;
    logic [1:0] lxsrc_c_1;
    logic [1:0] lxsrc_c_2;
    logic [1:0] lxsrc_c_3;
    logic [15:0] lxq_s_0;
    logic [15:0] lxq_s_1;
    logic [15:0] lxq_s_2;
    logic [15:0] lxq_s_3;
    logic [127:0] lxq_e_0;
    logic [127:0] lxq_e_1;
    logic [127:0] lxq_e_2;
    logic [127:0] lxq_e_3;
    logic [239:0] lxq_m_0;
    logic [239:0] lxq_m_1;
    logic [239:0] lxq_m_2;
    logic [239:0] lxq_m_3;
    logic [63:0] vlm;
    logic [15:0] lgs0;
    logic [15:0] lgs1;
    logic [15:0] lgs2;
    logic [15:0] lgs3;
    logic [127:0] lge0;
    logic [127:0] lge1;
    logic [127:0] lge2;
    logic [127:0] lge3;
    logic [239:0] lgm0;
    logic [239:0] lgm1;
    logic [239:0] lgm2;
    logic [239:0] lgm3;
    logic [63:0] lgs_q;
    logic [959:0] lgm_q;
    logic [511:0] lge_q;
    logic ldw_go_q;
    logic [1535:0] lgm_pad;
    logic [1023:0] ra_row_q;
    logic [7:0] ra_e_q;
    logic [511:0] li_q;
    logic li_f;
    logic [1:0] beat_n;
    logic st_is32;
    logic [511:0] li_nx;
    logic [511:0] li_in;
    logic [56:0] st_seg_c;
    logic rb_v;
    logic [511:0] rb_dat;
    logic [511:0] sld_in;
    logic [87:0] sld_c;
    logic [87:0] sld_sh2;
    logic [31:0] sld_raw;
    logic sld_hz;
    logic [7:0] sld_he;
    logic [31:0] sld_hv;
    logic [31:0] sld_el;
    logic [31:0] sl2_wv;
    logic [31:0] sst_src;
    logic [31:0] sst_v;
    logic g_v2;
    logic g_l5;
    logic g_sb;
    logic g_l2;
    logic [3:0] rx_dsl;
    logic [3:0] rx_gix;
    logic g_rw;
    logic g_s2;
    logic g_sf2;
    logic g_sl2;
    logic l2_free;
    logic sl2_free;
    logic fpipe_e;
    logic is_sfun;
    logic fen_v;
    logic fen_s;
    logic fen;
    logic [255:0] fx_v;
    logic [31:0] sfx_src;
    logic [255:0] fx_s;
    logic [255:0] func_x;
    logic [7:0] func_es;
    logic [2:0] func_sel;
    logic [15:0] func_kc_c;
    logic [7:0] fdst;
    logic [1:0] fq_i;
    logic [13:0] fm_in;
    logic fo_v;
    logic fo_sc;
    logic [7:0] fo_dst;
    logic [1:0] fo_slot;
    logic fo_row_p;
    logic fq_we0_p;
    logic fq_we1_p;
    logic fq_we2_p;
    logic fo_row_q;
    logic fq_we0;
    logic fq_we1;
    logic fq_we2;
    logic fo_row;
    logic [303:0] fo_m3;
    logic [143:0] fo_e3;
    logic [15:0] fo_s3;
    logic [1215:0] frow_m;
    logic [575:0] frow_ed;
    logic [63:0] frow_s;
    logic g_wen;
    logic [7:0] g_waddr;
    logic [127:0] sb_row_g_0;
    logic [127:0] sb_row_g_1;
    logic [127:0] sb_row_g_2;
    logic [127:0] sb_row_g_3;
    logic [127:0] sb_row_g_4;
    logic [127:0] sb_row_g_5;
    logic [127:0] sb_row_g_6;
    logic [127:0] sb_row_g_7;
    logic [1023:0] sb_row;
    logic [1023:0] g_wdata;
    logic [7:0] g_we;
    logic [1:0] g_wslot;
    logic wp_v;
    logic [7:0] wp_addr;
    logic [1023:0] wp_row;
    logic [7:0] wp_e;
    logic [1:0] wp_slot;
    logic s_wen;
    logic [31:0] s_wval;
    logic [3:0] s_wdst;
    logic [1:0] s_wslot;
    logic [2:0] nfl_w;
    logic [2:0] memoutst;
    logic seq_due_c;
    logic idle0;
    logic kw_rdy;
    logic lc_go;
    logic [127:0] w_ins;
    logic kw_is_sl;
    logic [5:0] kw_vid;
    logic [5:0] kw_vid_b;
    logic kw_lcrdy;
    logic kern_act;
    logic kw_take;
    logic [9:0] rd_a;
    logic ws_v;
    logic [127:0] ws_ins;
    logic [31:0] ws_kv;
    logic [31:0] ws_kvb;
    logic [31:0] kv;
    logic [7:0] kv_cid;
    logic [31:0] kvb;
    logic [127:0] dq_ins [0:7];
    logic [47:0] dq_lad [0:7];
    logic [7:0] dq_cfg [0:7];
    logic [31:0] dq_c32 [0:7];
    logic [70:0] dq_pd [0:7];
    logic [3:0] dq_wp;
    logic [3:0] dq_rp;
    logic [2:0] dq_wi;
    logic [2:0] dq_ri;
    logic [3:0] dq_n;
    logic dq_full;
    logic dq_empty;
    logic [127:0] dqh_ins;
    logic [47:0] dqh_lad;
    logic [7:0] dqh_cfg;
    logic [31:0] dqh_c32;
    logic [70:0] dqh_pd;
    logic [6:0] dqh_tl;
    logic [63:0] dqh_tlm;
    logic ld_wb_ok;
    logic dq_pop;
    logic dq_byp;
    logic ws_is_sl;
    logic [27:0] kw_boff;
    logic kw_is_l1;
    logic [47:0] kw_lad;
    logic [5:0] ws_lo6;
    logic ws_df_0;
    logic ws_df_1;
    logic [4:0] ws_df_2;
    logic [4:0] ws_df_3;
    logic ws_df_4;
    logic [4:0] ws_df_5;
    logic [4:0] ws_df_6;
    logic [6:0] ws_df_7;
    logic [8:0] ws_df_8;
    logic [2:0] ws_df_9;
    logic [2:0] ws_df_10;
    logic [7:0] ws_df_11;
    logic [8:0] ws_df_12;
    logic [8:0] ws_df_13;
    logic [70:0] ws_pd;
    logic [63:0] ws_tlm;
    logic [127:0] cq_w;
    logic [47:0] cq_lad;
    logic [7:0] cq_cfg;
    logic [5:0] cq_lo6;
    logic cq_df_0;
    logic cq_df_1;
    logic [4:0] cq_df_2;
    logic [4:0] cq_df_3;
    logic cq_df_4;
    logic [4:0] cq_df_5;
    logic [4:0] cq_df_6;
    logic [6:0] cq_df_7;
    logic [8:0] cq_df_8;
    logic [2:0] cq_df_9;
    logic [2:0] cq_df_10;
    logic [7:0] cq_df_11;
    logic [8:0] cq_df_12;
    logic [8:0] cq_df_13;
    logic [70:0] cq_pd;
    logic [63:0] cq_tlm;
    logic [1:0] fs_idx;
    logic rt_rdy;
    logic [1:0] rt_idx;
    logic iss_alu;
    logic red_go;
    logic iss_red;
    logic f_adv;
    logic pr_go;
    logic rd_en;
    logic [3:0] cq_n;
    logic cred_ok;
    logic [3:0] ra_sel;
    logic [3:0] pr_sl_l;
    logic [3:0] rd_sl;
    logic [7:0] rd_addr_a;
    logic [3:0] rb_sel;
    logic [7:0] rd_addr_b;
    logic is_smem;
    logic in_streq;
    logic use_l1;
    logic [3:0] ix_isel;
    logic [31:0] ix_src;
    logic [29:0] ix_u;
    logic ix_ng;
    logic [17:0] ix_s;
    logic [18:0] ix_sp;
    logic [17:0] ix_s_c;
    logic [18:0] ix_sn_c;
    logic [47:0] ix_cz;
    logic [17:0] pa_s_c;
    logic [18:0] pa_sn_c;
    logic [47:0] pa_cz;
    logic [47:0] ix_pl;
    logic [47:0] ix_ph;
    logic [47:0] ix_laddr;
    logic [6:0] ix_lo7;
    logic [4:0] pah_op;
    logic pah_vdt_ok;
    logic pah_ld;
    logic pah_idx;
    logic pah_npre;
    logic pah_raw;
    logic pa_ok;
    logic pa_cvt;
    logic pa_cv2;
    logic pa_mul;
    logic pa_add;
    logic pa_sent;
    logic pa_hit;
    logic pa_fire_d;
    logic pa_hit_d;
    logic [4:0] pa_cnt_d;
    logic [2:0] pa_nb;
    logic pah_l1;
    logic pah_scal;
    logic [2:0] pah_mdt;
    logic [2:0] pah_esz;
    logic [2:0] pah_vdt;
    logic [1:0] pah_vsh;
    logic [11:0] pah_nl;
    logic [4:0] pah_ns;
    logic [5:0] pah_tlf;
    logic [6:0] pah_tl;
    logic [6:0] pah_lanes0;
    logic [19:0] pah_by;
    logic pah_last;
    logic [47:0] pa_sum;
    logic [47:0] pa_lad_al;
    logic [47:0] pa_addr;
    logic [47:0] pa_nx1;
    logic [19:0] pa_bytes_c;
    logic pa_last_c;
    logic pa_more;
    logic ld_act;
    logic ar_pend;
    logic [47:0] ar_seg;
    logic in_sldreq;
    logic [47:0] ar_addr_m;
    logic [19:0] ar_bytes_m;
    logic ar_first_m;
    logic ar_last_m;
    logic ar_go;
    logic pa_req;
    logic ar_any;
    logic ar_port;
    logic ar_cred;
    logic [47:0] ar_addr_c;
    logic [19:0] ar_bytes_c;
    logic ar_first_c;
    logic ar_last_c;
    logic ar_fire;
    logic [47:0] seg;
    logic [47:0] seg_al;
    logic [8:0] aw_by;
    logic [19:0] ax_bytes;
    logic ax_first;
    logic ax_last;
    logic [7:0] ax_cfg;
    logic [7:0] ar_cfg_c;
    logic [19:0] ax_off;
    logic ld_stall;
    logic lbw_hs1;
    logic lbw_tl_n;
    logic rr_q;
    logic ld_lastb;
    logic ld_rv_c;
    logic ld_arack_c;
    logic rr_run;
    logic rb_fire;
    logic [511:0] rb_in;
    logic st_ok;
    logic aw_pend;
    logic aw_go;
    logic xq_v;
    logic xq_s;
    logic [735:0] xq_pk;
    logic [56:0] xq_e_g_0;
    logic [56:0] xq_e_g_1;
    logic [56:0] xq_e_g_2;
    logic [56:0] xq_e_g_3;
    logic [56:0] xq_e_g_4;
    logic [56:0] xq_e_g_5;
    logic [56:0] xq_e_g_6;
    logic [56:0] xq_e_g_7;
    logic xq_32;
    logic [31:0] xq_sv;
    logic [5:0] xq_la;
    logic [63:0] xq_stb;
    logic xq_l1;
    logic [511:0] vbeat;
    logic [87:0] sst_w;
    logic [63:0] sbs_0;
    logic [63:0] sbs_1;
    logic [63:0] sbs_2;
    logic [63:0] sbs_3;
    logic [63:0] sbs_4;
    logic [63:0] sbs_5;
    logic [63:0] sbs_6;
    logic [63:0] sbs_7;
    logic [511:0] sbeat;
    logic [511:0] wbeat_al;
    logic [63:0] lstrb;
    logic [7:0] sselm;
    logic [5:0] sla6;
    logic [63:0] sstrb;
    logic [63:0] vstrb;
    logic [63:0] wstrb_al;
    logic [511:0] wq_d_0;
    logic [511:0] wq_d_1;
    logic [511:0] wq_d_2;
    logic [63:0] wq_s_0;
    logic [63:0] wq_s_1;
    logic [63:0] wq_s_2;
    logic wq_l_0;
    logic wq_l_1;
    logic wq_l_2;
    logic [1:0] wq_wp;
    logic [1:0] wq_rp;
    logic [1:0] wq_n;
    logic wq_vl;
    logic wq_vn;
    logic wq_v;
    logic oq_v;
    logic [511:0] wq_hd;
    logic [63:0] wq_hs;
    logic oq_acc;
    logic w_go;
    logic wq_room;
    logic oq_take;
    logic [1:0] wq_rpn;
    logic [1:0] wq_nn;
    logic wq_hln;
    logic st_aw_fire;
    logic st_wdone;
    logic w_last_sl;
    logic st_fin;
    logic [4:0] pr_sl_m1;
    logic [3:0] hs_sl;
    logic w_start;
    logic sq_bv;
    logic nx_hs3;
    logic nx_lbq;
    logic [9:0] row;
    logic [1:0] lane;
    logic lq_push;
    logic f_l1;
    logic f_nc;
    logic l2_done;
    logic l2v_n;
    logic cmp_n;
    logic [543:0] u_alu_res;
    logic [303:0] u_func_m;
    logic [143:0] u_func_ed;
    logic [15:0] u_func_sgn;
    logic [7:0] u_b2s_r_e;
    logic [7:0] u_b2s_s_e;
    logic [7:0] u_b2s_i_e;
    logic [15:0] u_b2s_r_f;
    logic [15:0] u_b2s_s_f;
    logic [15:0] u_b2s_i_f;
    logic [7:0] u_vt2s_s_e;
    logic [7:0] u_vt2s_i_e;
    logic [15:0] u_vt2s_s_f;
    logic [15:0] u_vt2s_i_f;
    logic [47:0] u_vta_0_p;
    logic [47:0] u_vta_1_p;
    logic [47:0] u_vta_2_p;
    logic [47:0] u_vta_3_p;
    logic [47:0] u_vta_4_p;
    logic [47:0] u_vta_5_p;
    logic [47:0] u_vta_6_p;
    logic [47:0] u_vta_7_p;
    logic [16:0] u_segx_oha;
    logic [16:0] u_segx_ohb;
    logic [1023:0] u_nrm_fq;
    logic [1023:0] u_lidx_fq;
    logic [7:0] u_nrm_e;
    logic [7:0] u_lidx_e;
    logic [31:0] u_red_res;
    logic [19:0] u_red_mo;
    logic [19:0] u_red_bm;
    logic [31:0] u_racs_res;
    logic [31:0] u_s1c_res;
    logic [31:0] u_salu_res;
    logic [15:0] u_lbx_o_0_s;
    logic [127:0] u_lbx_o_0_e;
    logic [239:0] u_lbx_o_0_m;
    logic [15:0] u_lbx_o_1_s;
    logic [127:0] u_lbx_o_1_e;
    logic [239:0] u_lbx_o_1_m;
    logic [15:0] u_lbx_o_2_s;
    logic [127:0] u_lbx_o_2_e;
    logic [239:0] u_lbx_o_2_m;
    logic [15:0] u_lbx_o_3_s;
    logic [127:0] u_lbx_o_3_e;
    logic [239:0] u_lbx_o_3_m;
    logic [31:0] u_sl2i_res;
    logic [31:0] u_sstc_res;
    logic [15:0] u_sf2s_f;
    logic [7:0] u_sf2s_e;
    logic [1023:0] u_pk_fq;
    logic [127:0] u_kw_out_inst;
    logic u_kw_lc_ready;
    logic u_kw_busy;
    logic u_kw_out_v;
    logic [11:0] u_kw_im_addr;
    logic [511:0] u_stb_res;
    logic [735:0] u_sta_pk;
    logic [9:0] u_segx_eo;
    logic u_kw_im_req;
    logic [15:0] u_c2s_f;
    logic [7:0] u_c2s_e;
    logic [38:0] u_s0c_pk;
    logic [7:0] u_lpk_e;
    logic [1023:0] u_lpk_f;
    logic [7:0] u_pk_e;
    logic [31:0] u_sf32_res;
    logic [7:0] u_g2s_e;
    logic [15:0] u_g2s_f;
    logic [1023:0] u_red_bf;
    logic [7:0] u_red_be;
    logic [31:0] u_kw_rda_val;
    logic [31:0] u_kw_rdb_val;
    logic [31:0] u_ix_u;
    logic u_ix_ng;
    logic [47:0] u_pal_p;
    logic [47:0] u_pah_p;
    logic [47:0] u_ixl_p;
    logic [47:0] u_ixh_p;
    logic u_red_obusy;
    logic [31:0] u_rcp_res;
    logic [38:0] u_sldi_pk;
    logic ws_is_sl_c0;
    logic ws_df_0_c0;
    logic ws_df_0_c1;
    logic ws_df_0_c2;
    logic ws_df_0_c3;
    logic ws_df_0_c4;
    logic [11:0] ws_df_0_c5;
    logic ws_df_0_c6;
    logic ws_df_0_c7;
    logic ws_df_0_c8;
    logic ws_df_1_c0;
    logic [5:0] ws_df_7_c0;
    logic [2:0] ws_df_8_c0;
    logic [1:0] ws_df_8_c1;
    logic cq_lad_c0;
    logic cq_df_0_c0;
    logic cq_df_0_c1;
    logic cq_df_0_c2;
    logic cq_df_0_c3;
    logic [11:0] cq_df_0_c4;
    logic cq_df_0_c5;
    logic cq_df_0_c6;
    logic cq_df_0_c7;
    logic cq_df_1_c0;
    logic [5:0] cq_df_7_c0;
    logic [2:0] cq_df_8_c0;
    logic [1:0] cq_df_8_c1;

    assign ld_v = (lq_n != 0);
    assign ld_id = lq_id[lq_rp[2:0]];
    assign ld_off = lq_off[lq_rp[2:0]];
    assign ld_len = lq_len[lq_rp[2:0]];
    assign gw_sel = (gw_k ? gw_s : gw_m);
    assign rx_wsl_n = (rx_wsl + 4'd1);
    assign gres_rd = gres[rx_wg_q];
    assign ra_row = {ra7, ra6, ra5, ra4, ra3, ra2, ra1, ra0};
    assign rb_row = {rb7, rb6, rb5, rb4, rb3, rb2, rb1, rb0};
    assign ae_c = gAE[rd_addr_a];
    assign be_c = gBE[rd_addr_b];
    assign is_vdiv = (((cur[4:0] == 4) & (cur[18:15] == 3)) & (cur[20:19] != 0));
    assign is_sdiv = ((cur[4:0] == 11) & (cur[16:13] == 3));
    assign vop_b = ((cur[20:19] == 1) ? sr[cur[24:21]] : cur[52:21]);
    assign sop_b = (cur[17] ? cur[49:18] : sr[cur[21:18]]);
    assign vb_sr = sr[cur[24:21]];
    assign vb_im = cur[52:21];
    assign vb_is_sr = (cur[20:19] == 1);
    assign b2s_e = (is_vdiv ? u_b2s_r_e : (vb_is_sr ? u_b2s_s_e : u_b2s_i_e));
    assign b2s_f = (is_vdiv ? u_b2s_r_f : (vb_is_sr ? u_b2s_s_f : u_b2s_i_f));
    assign vt_sr = sr[cur[19:16]];
    assign vt_im = cur[47:16];
    assign vt2s_e = (cur[15] ? u_vt2s_s_e : u_vt2s_i_e);
    assign vt2s_f = (cur[15] ? u_vt2s_s_f : u_vt2s_i_f);
    assign bmode_c = ((cur[4:0] == 4) & (cur[20:19] != 0));
    assign eb_c = (bmode_c ? b2s_e : be_c);
    assign op_c = (is_vdiv ? 4'd2 : cur[18:15]);
    assign isw_c = (cur[4:0] == 7);
    assign vdt9 = ({1'd0, d1_eb} - {1'd0, d1_evt});
    assign voh_c = (vdt9[8] ? 17'd65536 : ((vdt9[7:4] != 4'd0) ? 17'd0 : (17'd65536 >> vdt9[3:0])));
    assign vta_p_0 = u_vta_0_p;
    assign vtal_g_0 = vta_p_0[31:16];
    assign vta_p_1 = u_vta_1_p;
    assign vtal_g_1 = vta_p_1[31:16];
    assign vta_p_2 = u_vta_2_p;
    assign vtal_g_2 = vta_p_2[31:16];
    assign vta_p_3 = u_vta_3_p;
    assign vtal_g_3 = vta_p_3[31:16];
    assign vta_p_4 = u_vta_4_p;
    assign vtal_g_4 = vta_p_4[31:16];
    assign vta_p_5 = u_vta_5_p;
    assign vtal_g_5 = vta_p_5[31:16];
    assign vta_p_6 = u_vta_6_p;
    assign vtal_g_6 = vta_p_6[31:16];
    assign vta_p_7 = u_vta_7_p;
    assign vtal_g_7 = vta_p_7[31:16];
    assign oha_c = u_segx_oha;
    assign ohb_c = u_segx_ohb;
    assign b_row_g_0 = (v0_bm_g_0 ? {8{v0_b16_g_0}} : rb_row[127:0]);
    assign b_row_g_1 = (v0_bm_g_1 ? {8{v0_b16_g_1}} : rb_row[255:128]);
    assign b_row_g_2 = (v0_bm_g_2 ? {8{v0_b16_g_2}} : rb_row[383:256]);
    assign b_row_g_3 = (v0_bm_g_3 ? {8{v0_b16_g_3}} : rb_row[511:384]);
    assign b_row_g_4 = (v0_bm_g_4 ? {8{v0_b16_g_4}} : rb_row[639:512]);
    assign b_row_g_5 = (v0_bm_g_5 ? {8{v0_b16_g_5}} : rb_row[767:640]);
    assign b_row_g_6 = (v0_bm_g_6 ? {8{v0_b16_g_6}} : rb_row[895:768]);
    assign b_row_g_7 = (v0_bm_g_7 ? {8{v0_b16_g_7}} : rb_row[1023:896]);
    assign b_row = {b_row_g_7, b_row_g_6, b_row_g_5, b_row_g_4, b_row_g_3, b_row_g_2, b_row_g_1, b_row_g_0};
    assign nrm_rv = (v2_v & (v2_src == 0));
    assign lidx_v = (v4_v & (v4_src == 2));
    assign exd_g_0 = ((w_src == 0) ? u_nrm_fq[127:0] :
                     ((w_src == 1) ? {8{w_cf_g_0}} :
                     ((w_src == 2) ? u_lidx_fq[127:0] :
                     {8{w_cf_g_0}})));
    assign exd_g_1 = ((w_src == 0) ? u_nrm_fq[255:128] :
                     ((w_src == 1) ? {8{w_cf_g_1}} :
                     ((w_src == 2) ? u_lidx_fq[255:128] :
                     {8{w_cf_g_1}})));
    assign exd_g_2 = ((w_src == 0) ? u_nrm_fq[383:256] :
                     ((w_src == 1) ? {8{w_cf_g_2}} :
                     ((w_src == 2) ? u_lidx_fq[383:256] :
                     {8{w_cf_g_2}})));
    assign exd_g_3 = ((w_src == 0) ? u_nrm_fq[511:384] :
                     ((w_src == 1) ? {8{w_cf_g_3}} :
                     ((w_src == 2) ? u_lidx_fq[511:384] :
                     {8{w_cf_g_3}})));
    assign exd_g_4 = ((w_src == 0) ? u_nrm_fq[639:512] :
                     ((w_src == 1) ? {8{w_cf_g_4}} :
                     ((w_src == 2) ? u_lidx_fq[639:512] :
                     {8{w_cf_g_4}})));
    assign exd_g_5 = ((w_src == 0) ? u_nrm_fq[767:640] :
                     ((w_src == 1) ? {8{w_cf_g_5}} :
                     ((w_src == 2) ? u_lidx_fq[767:640] :
                     {8{w_cf_g_5}})));
    assign exd_g_6 = ((w_src == 0) ? u_nrm_fq[895:768] :
                     ((w_src == 1) ? {8{w_cf_g_6}} :
                     ((w_src == 2) ? u_lidx_fq[895:768] :
                     {8{w_cf_g_6}})));
    assign exd_g_7 = ((w_src == 0) ? u_nrm_fq[1023:896] :
                     ((w_src == 1) ? {8{w_cf_g_7}} :
                     ((w_src == 2) ? u_lidx_fq[1023:896] :
                     {8{w_cf_g_7}})));
    assign w_f = {exd_g_7, exd_g_6, exd_g_5, exd_g_4, exd_g_3, exd_g_2, exd_g_1, exd_g_0};
    assign exd_e = ((v5_src == 0) ? u_nrm_e : ((v5_src == 1) ? v5_ce : ((v5_src == 2) ? u_lidx_e : v5_ce)));
    assign mem_dt = ((cur[4:0] == 24) ? cur[71:69] : cur[49:47]);
    assign esz4 = ((mem_dt == 1) | (mem_dt == 2));
    assign esz = (esz4 ? 3'd4 : 3'd2);
    assign vdt = vdt_q;
    assign vsh = (((vdt == 1) | (vdt == 2)) ? 2'd2 : (((vdt == 3) | (vdt == 4)) ? 2'd0 : 2'd1));
    assign is_rseg = ((cur[4:0] == 13) & cur[17]);
    assign rsl = cur[21:18];
    assign is_rx = (is_rseg & (rsl > 4'd6));
    assign rg_sh = (rsl - 4'd6);
    assign rg_msk_w = ((5'd1 << rg_sh) - 5'd1);
    assign rg_msk = rg_msk_w[3:0];
    assign rdst = (is_rseg ? {cur[8:5], slice_i} : {4'd0, cur[8:5]});
    assign r_first = (is_rx ? ((slice_i & rg_msk) == 4'd0) : (slice_i == 0));
    assign r_last = (is_rx ? ((slice_i & rg_msk) == rg_msk) : (slice_i == cur_nsm1));
    assign red_ident = cur_rid;
    assign red_lm_c = ((slice_i == cur_nsm1) ? cur_tlm : (~64'd0));
    assign red_row = {(r0_lm[63] ? ra_row[1023:1008] : red_ident), (r0_lm[62] ? ra_row[1007:992] : red_ident),
                      (r0_lm[61] ? ra_row[991:976] : red_ident), (r0_lm[60] ? ra_row[975:960] : red_ident),
                      (r0_lm[59] ? ra_row[959:944] : red_ident), (r0_lm[58] ? ra_row[943:928] : red_ident),
                      (r0_lm[57] ? ra_row[927:912] : red_ident), (r0_lm[56] ? ra_row[911:896] : red_ident),
                      (r0_lm[55] ? ra_row[895:880] : red_ident), (r0_lm[54] ? ra_row[879:864] : red_ident),
                      (r0_lm[53] ? ra_row[863:848] : red_ident), (r0_lm[52] ? ra_row[847:832] : red_ident),
                      (r0_lm[51] ? ra_row[831:816] : red_ident), (r0_lm[50] ? ra_row[815:800] : red_ident),
                      (r0_lm[49] ? ra_row[799:784] : red_ident), (r0_lm[48] ? ra_row[783:768] : red_ident),
                      (r0_lm[47] ? ra_row[767:752] : red_ident), (r0_lm[46] ? ra_row[751:736] : red_ident),
                      (r0_lm[45] ? ra_row[735:720] : red_ident), (r0_lm[44] ? ra_row[719:704] : red_ident),
                      (r0_lm[43] ? ra_row[703:688] : red_ident), (r0_lm[42] ? ra_row[687:672] : red_ident),
                      (r0_lm[41] ? ra_row[671:656] : red_ident), (r0_lm[40] ? ra_row[655:640] : red_ident),
                      (r0_lm[39] ? ra_row[639:624] : red_ident), (r0_lm[38] ? ra_row[623:608] : red_ident),
                      (r0_lm[37] ? ra_row[607:592] : red_ident), (r0_lm[36] ? ra_row[591:576] : red_ident),
                      (r0_lm[35] ? ra_row[575:560] : red_ident), (r0_lm[34] ? ra_row[559:544] : red_ident),
                      (r0_lm[33] ? ra_row[543:528] : red_ident), (r0_lm[32] ? ra_row[527:512] : red_ident),
                      (r0_lm[31] ? ra_row[511:496] : red_ident), (r0_lm[30] ? ra_row[495:480] : red_ident),
                      (r0_lm[29] ? ra_row[479:464] : red_ident), (r0_lm[28] ? ra_row[463:448] : red_ident),
                      (r0_lm[27] ? ra_row[447:432] : red_ident), (r0_lm[26] ? ra_row[431:416] : red_ident),
                      (r0_lm[25] ? ra_row[415:400] : red_ident), (r0_lm[24] ? ra_row[399:384] : red_ident),
                      (r0_lm[23] ? ra_row[383:368] : red_ident), (r0_lm[22] ? ra_row[367:352] : red_ident),
                      (r0_lm[21] ? ra_row[351:336] : red_ident), (r0_lm[20] ? ra_row[335:320] : red_ident),
                      (r0_lm[19] ? ra_row[319:304] : red_ident), (r0_lm[18] ? ra_row[303:288] : red_ident),
                      (r0_lm[17] ? ra_row[287:272] : red_ident), (r0_lm[16] ? ra_row[271:256] : red_ident),
                      (r0_lm[15] ? ra_row[255:240] : red_ident), (r0_lm[14] ? ra_row[239:224] : red_ident),
                      (r0_lm[13] ? ra_row[223:208] : red_ident), (r0_lm[12] ? ra_row[207:192] : red_ident),
                      (r0_lm[11] ? ra_row[191:176] : red_ident), (r0_lm[10] ? ra_row[175:160] : red_ident),
                      (r0_lm[9] ? ra_row[159:144] : red_ident), (r0_lm[8] ? ra_row[143:128] : red_ident),
                      (r0_lm[7] ? ra_row[127:112] : red_ident), (r0_lm[6] ? ra_row[111:96] : red_ident),
                      (r0_lm[5] ? ra_row[95:80] : red_ident), (r0_lm[4] ? ra_row[79:64] : red_ident),
                      (r0_lm[3] ? ra_row[63:48] : red_ident), (r0_lm[2] ? ra_row[47:32] : red_ident),
                      (r0_lm[1] ? ra_row[31:16] : red_ident), (r0_lm[0] ? ra_row[15:0] : red_ident)};
    assign red_res = u_red_res;
    assign red_mo = u_red_mo;
    assign r9_v = red_mo[0];
    assign r9_first = red_mo[1];
    assign r9_last = red_mo[2];
    assign r9_kind = red_mo[4:3];
    assign r9_mode = red_mo[5];
    assign r9_sl = red_mo[9:6];
    assign r9_acc = ((~r9_mode) | (r9_sl > 4'd6));
    assign r9_dst = red_mo[13:10];
    assign r9_slot = red_mo[19:18];
    assign bo_m = u_red_bm;
    assign bo_v = bo_m[0];
    assign bo_dst = bo_m[17:10];
    assign bo_slot = bo_m[19:18];
    assign racc_n = (r9d_first ? r9d_res : u_racs_res);
    assign mm_lt = (((raccm[30:23] == 0) & (r9d_res[30:23] == 0)) ? 1'd0 :
                   ((raccm[30:23] == 0) ? ((~r9d_res[31]) & (~(r9d_res[30:23] == 0))) :
                   ((r9d_res[30:23] == 0) ? raccm[31] :
                   ((raccm[31] ^ r9d_res[31]) ? raccm[31] :
                   (raccm[31] ? (raccm[30:0] > r9d_res[30:0]) :
                   (raccm[30:0] < r9d_res[30:0]))))));
    assign mm_sel = (mm_lt ^ r9d_kind[0]);
    assign raccm_n = (r9d_first ? r9d_res : (mm_sel ? raccm : r9d_res));
    assign rw_out = ((rw_kind == 2'd0) ? rw_val : rw_valm);
    assign s1_val = (s1_isc ? (s1_cint ? u_s1c_res : s1_c32) : u_salu_res);
    assign rcp_in = (rcp_sf ? sfx_src : (rcp_sc ? sop_b : vop_b));
    assign vl_last = (slice_i == cur_nsm1);
    assign vl_cur = (vl_last ? cur_tl : 7'd64);
    assign vl_lm = (vl_last ? cur_tlm : (~64'd0));
    assign in_ldwb = ld_hs;
    assign lb_hi = (in_ldwb ? 512'd0 : ldp);
    assign lb_lo = (in_ldwb ? ldp : ldq);
    assign lb_pair = {lb_hi, lb_lo};
    assign lb_c = ((cur_laddr[5:3] == 0) ? lb_pair[567:0] :
                  ((cur_laddr[5:3] == 1) ? lb_pair[631:64] :
                  ((cur_laddr[5:3] == 2) ? lb_pair[695:128] :
                  ((cur_laddr[5:3] == 3) ? lb_pair[759:192] :
                  ((cur_laddr[5:3] == 4) ? lb_pair[823:256] :
                  ((cur_laddr[5:3] == 5) ? lb_pair[887:320] :
                  ((cur_laddr[5:3] == 6) ? lb_pair[951:384] :
                  lb_pair[1015:448])))))));
    assign lb_al = (lb_c >> {cur_laddr[2:0], 3'd0});
    assign lb_dat = lb_al[511:0];
    assign lbx_s_0 = u_lbx_o_0_s;
    assign lbx_e_0 = u_lbx_o_0_e;
    assign lbx_m_0 = u_lbx_o_0_m;
    assign lbx_s_1 = u_lbx_o_1_s;
    assign lbx_e_1 = u_lbx_o_1_e;
    assign lbx_m_1 = u_lbx_o_1_m;
    assign lbx_s_2 = u_lbx_o_2_s;
    assign lbx_e_2 = u_lbx_o_2_e;
    assign lbx_m_2 = u_lbx_o_2_m;
    assign lbx_s_3 = u_lbx_o_3_s;
    assign lbx_e_3 = u_lbx_o_3_e;
    assign lbx_m_3 = u_lbx_o_3_m;
    assign ld_na = (({3'd0, vl_cur} << vsh) + 10'd63);
    assign ld_na6 = ld_na[8:6];
    assign ld_byp = (cur_nb == ld_na6);
    assign is32v = ((vdt == 1) | (vdt == 2));
    assign is8v = ((vdt == 3) | (vdt == 4));
    assign tl0 = (ld_byp & (is8v | (ld_na6 == 1)));
    assign tl1 = (ld_byp & (is8v | (is32v ? (ld_na6 == 2) : (ld_na6 == 1))));
    assign tl2 = (ld_byp & (is8v | (is32v ? (ld_na6 == 3) : (ld_na6 == 2))));
    assign tl3 = (ld_byp & (is8v | (is32v ? (ld_na6 == 4) : (ld_na6 == 2))));
    assign bysrc_0 = 2'd0;
    assign bysrc_1 = (is32v ? 2'd0 : 2'd1);
    assign bysrc_2 = (is8v ? 2'd2 : 2'd0);
    assign bysrc_3 = (is32v ? 2'd0 : (is8v ? 2'd3 : 2'd1));
    assign is16v = (vdt == 0);
    assign lxw_c_0 = ((is8v | (is16v & (lbw_beat == 1))) | (((~is8v) & (~is16v)) & (lbw_beat == 1)));
    assign lxw_c_1 = ((is8v | (is16v & (lbw_beat == 1))) | (((~is8v) & (~is16v)) & (lbw_beat == 2)));
    assign lxw_c_2 = ((is8v | (is16v & (lbw_beat != 1))) | (((~is8v) & (~is16v)) & (lbw_beat == 3)));
    assign lxw_c_3 = ((is8v | (is16v & (lbw_beat != 1)))
                      | (((((~is8v) & (~is16v)) & (lbw_beat != 1)) & (lbw_beat != 2)) & (lbw_beat != 3)));
    assign lxsrc_c_0 = 2'd0;
    assign lxsrc_c_1 = ((is8v | is16v) ? 2'd1 : 2'd0);
    assign lxsrc_c_2 = (is8v ? 2'd2 : 2'd0);
    assign lxsrc_c_3 = (is8v ? 2'd3 : (is16v ? 2'd1 : 2'd0));
    assign lxq_s_0 = ((lx_src_0 == 0) ? lbq_s0 : ((lx_src_0 == 1) ? lbq_s1 : ((lx_src_0 == 2) ? lbq_s2 : lbq_s3)));
    assign lxq_e_0 = ((lx_src_0 == 0) ? lbq_e0 : ((lx_src_0 == 1) ? lbq_e1 : ((lx_src_0 == 2) ? lbq_e2 : lbq_e3)));
    assign lxq_m_0 = ((lx_src_0 == 0) ? lbq_m0 : ((lx_src_0 == 1) ? lbq_m1 : ((lx_src_0 == 2) ? lbq_m2 : lbq_m3)));
    assign lxq_s_1 = ((lx_src_1 == 0) ? lbq_s0 : ((lx_src_1 == 1) ? lbq_s1 : ((lx_src_1 == 2) ? lbq_s2 : lbq_s3)));
    assign lxq_e_1 = ((lx_src_1 == 0) ? lbq_e0 : ((lx_src_1 == 1) ? lbq_e1 : ((lx_src_1 == 2) ? lbq_e2 : lbq_e3)));
    assign lxq_m_1 = ((lx_src_1 == 0) ? lbq_m0 : ((lx_src_1 == 1) ? lbq_m1 : ((lx_src_1 == 2) ? lbq_m2 : lbq_m3)));
    assign lxq_s_2 = ((lx_src_2 == 0) ? lbq_s0 : ((lx_src_2 == 1) ? lbq_s1 : ((lx_src_2 == 2) ? lbq_s2 : lbq_s3)));
    assign lxq_e_2 = ((lx_src_2 == 0) ? lbq_e0 : ((lx_src_2 == 1) ? lbq_e1 : ((lx_src_2 == 2) ? lbq_e2 : lbq_e3)));
    assign lxq_m_2 = ((lx_src_2 == 0) ? lbq_m0 : ((lx_src_2 == 1) ? lbq_m1 : ((lx_src_2 == 2) ? lbq_m2 : lbq_m3)));
    assign lxq_s_3 = ((lx_src_3 == 0) ? lbq_s0 : ((lx_src_3 == 1) ? lbq_s1 : ((lx_src_3 == 2) ? lbq_s2 : lbq_s3)));
    assign lxq_e_3 = ((lx_src_3 == 0) ? lbq_e0 : ((lx_src_3 == 1) ? lbq_e1 : ((lx_src_3 == 2) ? lbq_e2 : lbq_e3)));
    assign lxq_m_3 = ((lx_src_3 == 0) ? lbq_m0 : ((lx_src_3 == 1) ? lbq_m1 : ((lx_src_3 == 2) ? lbq_m2 : lbq_m3)));
    assign vlm = vl_lm;
    assign lgs0 = (lxs0 & ldw_vlm[15:0]);
    assign lgs1 = (lxs1 & ldw_vlm[31:16]);
    assign lgs2 = (lxs2 & ldw_vlm[47:32]);
    assign lgs3 = (lxs3 & ldw_vlm[63:48]);
    assign lge0 = (lxe0
                   & {{8{ldw_vlm[15]}}, {8{ldw_vlm[14]}}, {8{ldw_vlm[13]}}, {8{ldw_vlm[12]}}, {8{ldw_vlm[11]}},
                      {8{ldw_vlm[10]}}, {8{ldw_vlm[9]}}, {8{ldw_vlm[8]}}, {8{ldw_vlm[7]}}, {8{ldw_vlm[6]}},
                      {8{ldw_vlm[5]}}, {8{ldw_vlm[4]}}, {8{ldw_vlm[3]}}, {8{ldw_vlm[2]}}, {8{ldw_vlm[1]}},
                      {8{ldw_vlm[0]}}});
    assign lge1 = (lxe1
                   & {{8{ldw_vlm[31]}}, {8{ldw_vlm[30]}}, {8{ldw_vlm[29]}}, {8{ldw_vlm[28]}}, {8{ldw_vlm[27]}},
                      {8{ldw_vlm[26]}}, {8{ldw_vlm[25]}}, {8{ldw_vlm[24]}}, {8{ldw_vlm[23]}}, {8{ldw_vlm[22]}},
                      {8{ldw_vlm[21]}}, {8{ldw_vlm[20]}}, {8{ldw_vlm[19]}}, {8{ldw_vlm[18]}}, {8{ldw_vlm[17]}},
                      {8{ldw_vlm[16]}}});
    assign lge2 = (lxe2
                   & {{8{ldw_vlm[47]}}, {8{ldw_vlm[46]}}, {8{ldw_vlm[45]}}, {8{ldw_vlm[44]}}, {8{ldw_vlm[43]}},
                      {8{ldw_vlm[42]}}, {8{ldw_vlm[41]}}, {8{ldw_vlm[40]}}, {8{ldw_vlm[39]}}, {8{ldw_vlm[38]}},
                      {8{ldw_vlm[37]}}, {8{ldw_vlm[36]}}, {8{ldw_vlm[35]}}, {8{ldw_vlm[34]}}, {8{ldw_vlm[33]}},
                      {8{ldw_vlm[32]}}});
    assign lge3 = (lxe3
                   & {{8{ldw_vlm[63]}}, {8{ldw_vlm[62]}}, {8{ldw_vlm[61]}}, {8{ldw_vlm[60]}}, {8{ldw_vlm[59]}},
                      {8{ldw_vlm[58]}}, {8{ldw_vlm[57]}}, {8{ldw_vlm[56]}}, {8{ldw_vlm[55]}}, {8{ldw_vlm[54]}},
                      {8{ldw_vlm[53]}}, {8{ldw_vlm[52]}}, {8{ldw_vlm[51]}}, {8{ldw_vlm[50]}}, {8{ldw_vlm[49]}},
                      {8{ldw_vlm[48]}}});
    assign lgm0 = (lxm0
                   & {{15{ldw_vlm[15]}}, {15{ldw_vlm[14]}}, {15{ldw_vlm[13]}}, {15{ldw_vlm[12]}}, {15{ldw_vlm[11]}},
                      {15{ldw_vlm[10]}}, {15{ldw_vlm[9]}}, {15{ldw_vlm[8]}}, {15{ldw_vlm[7]}}, {15{ldw_vlm[6]}},
                      {15{ldw_vlm[5]}}, {15{ldw_vlm[4]}}, {15{ldw_vlm[3]}}, {15{ldw_vlm[2]}}, {15{ldw_vlm[1]}},
                      {15{ldw_vlm[0]}}});
    assign lgm1 = (lxm1
                   & {{15{ldw_vlm[31]}}, {15{ldw_vlm[30]}}, {15{ldw_vlm[29]}}, {15{ldw_vlm[28]}}, {15{ldw_vlm[27]}},
                      {15{ldw_vlm[26]}}, {15{ldw_vlm[25]}}, {15{ldw_vlm[24]}}, {15{ldw_vlm[23]}}, {15{ldw_vlm[22]}},
                      {15{ldw_vlm[21]}}, {15{ldw_vlm[20]}}, {15{ldw_vlm[19]}}, {15{ldw_vlm[18]}}, {15{ldw_vlm[17]}},
                      {15{ldw_vlm[16]}}});
    assign lgm2 = (lxm2
                   & {{15{ldw_vlm[47]}}, {15{ldw_vlm[46]}}, {15{ldw_vlm[45]}}, {15{ldw_vlm[44]}}, {15{ldw_vlm[43]}},
                      {15{ldw_vlm[42]}}, {15{ldw_vlm[41]}}, {15{ldw_vlm[40]}}, {15{ldw_vlm[39]}}, {15{ldw_vlm[38]}},
                      {15{ldw_vlm[37]}}, {15{ldw_vlm[36]}}, {15{ldw_vlm[35]}}, {15{ldw_vlm[34]}}, {15{ldw_vlm[33]}},
                      {15{ldw_vlm[32]}}});
    assign lgm3 = (lxm3
                   & {{15{ldw_vlm[63]}}, {15{ldw_vlm[62]}}, {15{ldw_vlm[61]}}, {15{ldw_vlm[60]}}, {15{ldw_vlm[59]}},
                      {15{ldw_vlm[58]}}, {15{ldw_vlm[57]}}, {15{ldw_vlm[56]}}, {15{ldw_vlm[55]}}, {15{ldw_vlm[54]}},
                      {15{ldw_vlm[53]}}, {15{ldw_vlm[52]}}, {15{ldw_vlm[51]}}, {15{ldw_vlm[50]}}, {15{ldw_vlm[49]}},
                      {15{ldw_vlm[48]}}});
    assign lgm_pad = {lgm_q[959:945], 9'd0, lgm_q[944:930], 9'd0, lgm_q[929:915], 9'd0, lgm_q[914:900], 9'd0,
                      lgm_q[899:885], 9'd0, lgm_q[884:870], 9'd0, lgm_q[869:855], 9'd0, lgm_q[854:840], 9'd0,
                      lgm_q[839:825], 9'd0, lgm_q[824:810], 9'd0, lgm_q[809:795], 9'd0, lgm_q[794:780], 9'd0,
                      lgm_q[779:765], 9'd0, lgm_q[764:750], 9'd0, lgm_q[749:735], 9'd0, lgm_q[734:720], 9'd0,
                      lgm_q[719:705], 9'd0, lgm_q[704:690], 9'd0, lgm_q[689:675], 9'd0, lgm_q[674:660], 9'd0,
                      lgm_q[659:645], 9'd0, lgm_q[644:630], 9'd0, lgm_q[629:615], 9'd0, lgm_q[614:600], 9'd0,
                      lgm_q[599:585], 9'd0, lgm_q[584:570], 9'd0, lgm_q[569:555], 9'd0, lgm_q[554:540], 9'd0,
                      lgm_q[539:525], 9'd0, lgm_q[524:510], 9'd0, lgm_q[509:495], 9'd0, lgm_q[494:480], 9'd0,
                      lgm_q[479:465], 9'd0, lgm_q[464:450], 9'd0, lgm_q[449:435], 9'd0, lgm_q[434:420], 9'd0,
                      lgm_q[419:405], 9'd0, lgm_q[404:390], 9'd0, lgm_q[389:375], 9'd0, lgm_q[374:360], 9'd0,
                      lgm_q[359:345], 9'd0, lgm_q[344:330], 9'd0, lgm_q[329:315], 9'd0, lgm_q[314:300], 9'd0,
                      lgm_q[299:285], 9'd0, lgm_q[284:270], 9'd0, lgm_q[269:255], 9'd0, lgm_q[254:240], 9'd0,
                      lgm_q[239:225], 9'd0, lgm_q[224:210], 9'd0, lgm_q[209:195], 9'd0, lgm_q[194:180], 9'd0,
                      lgm_q[179:165], 9'd0, lgm_q[164:150], 9'd0, lgm_q[149:135], 9'd0, lgm_q[134:120], 9'd0,
                      lgm_q[119:105], 9'd0, lgm_q[104:90], 9'd0, lgm_q[89:75], 9'd0, lgm_q[74:60], 9'd0, lgm_q[59:45],
                      9'd0, lgm_q[44:30], 9'd0, lgm_q[29:15], 9'd0, lgm_q[14:0], 9'd0};
    assign beat_n = (beat[1:0] + 2'd1);
    assign st_is32 = (vdt == 1);
    assign li_nx = {(beat_n[0] ? ra_row_q[1023:1008] : ra_row_q[511:496]),
                    (beat_n[0] ? ra_row_q[1007:992] : ra_row_q[495:480]),
                    (beat_n[0] ? ra_row_q[991:976] : ra_row_q[479:464]),
                    (beat_n[0] ? ra_row_q[975:960] : ra_row_q[463:448]),
                    (beat_n[0] ? ra_row_q[959:944] : ra_row_q[447:432]),
                    (beat_n[0] ? ra_row_q[943:928] : ra_row_q[431:416]),
                    (beat_n[0] ? ra_row_q[927:912] : ra_row_q[415:400]),
                    (beat_n[0] ? ra_row_q[911:896] : ra_row_q[399:384]),
                    (beat_n[0] ? ra_row_q[895:880] : ra_row_q[383:368]),
                    (beat_n[0] ? ra_row_q[879:864] : ra_row_q[367:352]),
                    (beat_n[0] ? ra_row_q[863:848] : ra_row_q[351:336]),
                    (beat_n[0] ? ra_row_q[847:832] : ra_row_q[335:320]),
                    (beat_n[0] ? ra_row_q[831:816] : ra_row_q[319:304]),
                    (beat_n[0] ? ra_row_q[815:800] : ra_row_q[303:288]),
                    (beat_n[0] ? ra_row_q[799:784] : ra_row_q[287:272]),
                    (beat_n[0] ? ra_row_q[783:768] : ra_row_q[271:256]),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[255:240] :
                       ((beat_n == 1) ? ra_row_q[511:496] :
                       ((beat_n == 2) ? ra_row_q[767:752] :
                       ra_row_q[1023:1008]))) :
                    (beat_n[0] ? ra_row_q[767:752] :
                    ra_row_q[255:240])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[239:224] :
                       ((beat_n == 1) ? ra_row_q[495:480] :
                       ((beat_n == 2) ? ra_row_q[751:736] :
                       ra_row_q[1007:992]))) :
                    (beat_n[0] ? ra_row_q[751:736] :
                    ra_row_q[239:224])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[223:208] :
                       ((beat_n == 1) ? ra_row_q[479:464] :
                       ((beat_n == 2) ? ra_row_q[735:720] :
                       ra_row_q[991:976]))) :
                    (beat_n[0] ? ra_row_q[735:720] :
                    ra_row_q[223:208])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[207:192] :
                       ((beat_n == 1) ? ra_row_q[463:448] :
                       ((beat_n == 2) ? ra_row_q[719:704] :
                       ra_row_q[975:960]))) :
                    (beat_n[0] ? ra_row_q[719:704] :
                    ra_row_q[207:192])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[191:176] :
                       ((beat_n == 1) ? ra_row_q[447:432] :
                       ((beat_n == 2) ? ra_row_q[703:688] :
                       ra_row_q[959:944]))) :
                    (beat_n[0] ? ra_row_q[703:688] :
                    ra_row_q[191:176])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[175:160] :
                       ((beat_n == 1) ? ra_row_q[431:416] :
                       ((beat_n == 2) ? ra_row_q[687:672] :
                       ra_row_q[943:928]))) :
                    (beat_n[0] ? ra_row_q[687:672] :
                    ra_row_q[175:160])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[159:144] :
                       ((beat_n == 1) ? ra_row_q[415:400] :
                       ((beat_n == 2) ? ra_row_q[671:656] :
                       ra_row_q[927:912]))) :
                    (beat_n[0] ? ra_row_q[671:656] :
                    ra_row_q[159:144])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[143:128] :
                       ((beat_n == 1) ? ra_row_q[399:384] :
                       ((beat_n == 2) ? ra_row_q[655:640] :
                       ra_row_q[911:896]))) :
                    (beat_n[0] ? ra_row_q[655:640] :
                    ra_row_q[143:128])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[127:112] :
                       ((beat_n == 1) ? ra_row_q[383:368] :
                       ((beat_n == 2) ? ra_row_q[639:624] :
                       ra_row_q[895:880]))) :
                    (beat_n[0] ? ra_row_q[639:624] :
                    ra_row_q[127:112])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[111:96] :
                       ((beat_n == 1) ? ra_row_q[367:352] :
                       ((beat_n == 2) ? ra_row_q[623:608] :
                       ra_row_q[879:864]))) :
                    (beat_n[0] ? ra_row_q[623:608] :
                    ra_row_q[111:96])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[95:80] :
                       ((beat_n == 1) ? ra_row_q[351:336] :
                       ((beat_n == 2) ? ra_row_q[607:592] :
                       ra_row_q[863:848]))) :
                    (beat_n[0] ? ra_row_q[607:592] :
                    ra_row_q[95:80])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[79:64] :
                       ((beat_n == 1) ? ra_row_q[335:320] :
                       ((beat_n == 2) ? ra_row_q[591:576] :
                       ra_row_q[847:832]))) :
                    (beat_n[0] ? ra_row_q[591:576] :
                    ra_row_q[79:64])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[63:48] :
                       ((beat_n == 1) ? ra_row_q[319:304] :
                       ((beat_n == 2) ? ra_row_q[575:560] :
                       ra_row_q[831:816]))) :
                    (beat_n[0] ? ra_row_q[575:560] :
                    ra_row_q[63:48])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[47:32] :
                       ((beat_n == 1) ? ra_row_q[303:288] :
                       ((beat_n == 2) ? ra_row_q[559:544] :
                       ra_row_q[815:800]))) :
                    (beat_n[0] ? ra_row_q[559:544] :
                    ra_row_q[47:32])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[31:16] :
                       ((beat_n == 1) ? ra_row_q[287:272] :
                       ((beat_n == 2) ? ra_row_q[543:528] :
                       ra_row_q[799:784]))) :
                    (beat_n[0] ? ra_row_q[543:528] :
                    ra_row_q[31:16])),
                    (st_is32
                     ? ((beat_n == 0) ? ra_row_q[15:0] :
                       ((beat_n == 1) ? ra_row_q[271:256] :
                       ((beat_n == 2) ? ra_row_q[527:512] :
                       ra_row_q[783:768]))) :
                    (beat_n[0] ? ra_row_q[527:512] :
                    ra_row_q[15:0]))};
    assign li_in = (li_f ? ra_row_q[511:0] : li_q);
    assign st_seg_c = {(ra_e_q == 8'd255),
                       {(ra_e_q >= 8'd158), (ra_e_q >= 8'd157), (ra_e_q >= 8'd156), (ra_e_q >= 8'd155),
                        (ra_e_q >= 8'd154), (ra_e_q >= 8'd153), (ra_e_q >= 8'd152), (ra_e_q >= 8'd151),
                        (ra_e_q >= 8'd150), (ra_e_q >= 8'd149), (ra_e_q >= 8'd148), (ra_e_q >= 8'd147),
                        (ra_e_q >= 8'd146), (ra_e_q >= 8'd145), (ra_e_q >= 8'd144), (ra_e_q >= 8'd143)},
                       {(ra_e_q <= 8'd127), (ra_e_q <= 8'd126), (ra_e_q <= 8'd125), (ra_e_q <= 8'd124),
                        (ra_e_q <= 8'd123), (ra_e_q <= 8'd122), (ra_e_q <= 8'd121), (ra_e_q <= 8'd120),
                        (ra_e_q <= 8'd119), (ra_e_q <= 8'd118), (ra_e_q <= 8'd117), (ra_e_q <= 8'd116),
                        (ra_e_q <= 8'd115), (ra_e_q <= 8'd114), (ra_e_q <= 8'd113), (ra_e_q <= 8'd112)},
                       {(ra_e_q <= 8'd15), (ra_e_q <= 8'd14), (ra_e_q <= 8'd13), (ra_e_q <= 8'd12), (ra_e_q <= 8'd11),
                        (ra_e_q <= 8'd10), (ra_e_q <= 8'd9), (ra_e_q <= 8'd8), (ra_e_q <= 8'd7), (ra_e_q <= 8'd6),
                        (ra_e_q <= 8'd5), (ra_e_q <= 8'd4), (ra_e_q <= 8'd3), (ra_e_q <= 8'd2), (ra_e_q <= 8'd1),
                        (ra_e_q <= 8'd0)}, ra_e_q};
    assign sld_in = (rb_v ? rb_dat : rb_in);
    assign sld_c = ((cur_laddr[5:3] == 0) ? sld_in[87:0] :
                   ((cur_laddr[5:3] == 1) ? sld_in[151:64] :
                   ((cur_laddr[5:3] == 2) ? sld_in[215:128] :
                   ((cur_laddr[5:3] == 3) ? sld_in[279:192] :
                   ((cur_laddr[5:3] == 4) ? sld_in[343:256] :
                   ((cur_laddr[5:3] == 5) ? sld_in[407:320] :
                   ((cur_laddr[5:3] == 6) ? sld_in[471:384] :
                   {24'd0, sld_in[511:448]})))))));
    assign sld_sh2 = (ld0 >> {cur_laddr[2:0], 3'd0});
    assign sld_raw = sld_sh2[31:0];
    assign sld_hz = (sld_raw[14:10] == 5'd0);
    assign sld_he = ({3'd0, sld_raw[14:10]} + 8'd112);
    assign sld_hv = (sld_hz ? 32'd0 : {sld_raw[15], sld_he, sld_raw[9:0], 13'd0});
    assign sld_el = ((mem_dt == 1) ? sld_raw : sld_hv);
    assign sl2_wv = (sl2_i ? u_sl2i_res : sl2_val);
    assign sst_src = sr[cur[8:5]];
    assign sst_v = u_sstc_res;
    assign g_v2 = w_v;
    assign g_l5 = l5_v;
    assign g_sb = sb_v;
    assign g_l2 = (l2_v & (~((w_v | l5_v) | sb_v)));
    assign rx_dsl = red_mo[13:10];
    assign rx_gix = (rx_dsl >> (red_mo[9:6] - 4'd6));
    assign g_rw = rw_v;
    assign g_s2 = s2_v;
    assign g_sf2 = sf2_v;
    assign g_sl2 = (sl2_v & (~((rw_v | s2_v) | sf2_v)));
    assign l2_free = ((~l2_v) | g_l2);
    assign sl2_free = ((~sl2_v) | g_sl2);
    assign fpipe_e = ((((((((((((fm0[0] | fm1[0]) | fm2[0]) | fm3[0]) | fm4[0]) | fm5[0]) | fm6[0]) | fm7[0]) | fm8[0])
                       | fm9[0]) | fm10[0]) | fm11[0]) == 0);
    assign is_sfun = (state == S_SFUN);
    assign fen_v = (state == S_FUN);
    assign fen_s = (is_sfun & fpipe_e);
    assign fen = (fen_v | fen_s);
    assign fx_v = {((fb == 0) ? ra_row[975:960] :
                   ((fb == 1) ? ra_row[991:976] :
                   ((fb == 2) ? ra_row[1007:992] :
                   ra_row[1023:1008]))),
                   ((fb == 0) ? ra_row[911:896] :
                   ((fb == 1) ? ra_row[927:912] :
                   ((fb == 2) ? ra_row[943:928] :
                   ra_row[959:944]))),
                   ((fb == 0) ? ra_row[847:832] :
                   ((fb == 1) ? ra_row[863:848] :
                   ((fb == 2) ? ra_row[879:864] :
                   ra_row[895:880]))),
                   ((fb == 0) ? ra_row[783:768] :
                   ((fb == 1) ? ra_row[799:784] :
                   ((fb == 2) ? ra_row[815:800] :
                   ra_row[831:816]))),
                   ((fb == 0) ? ra_row[719:704] :
                   ((fb == 1) ? ra_row[735:720] :
                   ((fb == 2) ? ra_row[751:736] :
                   ra_row[767:752]))),
                   ((fb == 0) ? ra_row[655:640] :
                   ((fb == 1) ? ra_row[671:656] :
                   ((fb == 2) ? ra_row[687:672] :
                   ra_row[703:688]))),
                   ((fb == 0) ? ra_row[591:576] :
                   ((fb == 1) ? ra_row[607:592] :
                   ((fb == 2) ? ra_row[623:608] :
                   ra_row[639:624]))),
                   ((fb == 0) ? ra_row[527:512] :
                   ((fb == 1) ? ra_row[543:528] :
                   ((fb == 2) ? ra_row[559:544] :
                   ra_row[575:560]))),
                   ((fb == 0) ? ra_row[463:448] :
                   ((fb == 1) ? ra_row[479:464] :
                   ((fb == 2) ? ra_row[495:480] :
                   ra_row[511:496]))),
                   ((fb == 0) ? ra_row[399:384] :
                   ((fb == 1) ? ra_row[415:400] :
                   ((fb == 2) ? ra_row[431:416] :
                   ra_row[447:432]))),
                   ((fb == 0) ? ra_row[335:320] :
                   ((fb == 1) ? ra_row[351:336] :
                   ((fb == 2) ? ra_row[367:352] :
                   ra_row[383:368]))),
                   ((fb == 0) ? ra_row[271:256] :
                   ((fb == 1) ? ra_row[287:272] :
                   ((fb == 2) ? ra_row[303:288] :
                   ra_row[319:304]))),
                   ((fb == 0) ? ra_row[207:192] :
                   ((fb == 1) ? ra_row[223:208] :
                   ((fb == 2) ? ra_row[239:224] :
                   ra_row[255:240]))),
                   ((fb == 0) ? ra_row[143:128] :
                   ((fb == 1) ? ra_row[159:144] :
                   ((fb == 2) ? ra_row[175:160] :
                   ra_row[191:176]))),
                   ((fb == 0) ? ra_row[79:64] :
                   ((fb == 1) ? ra_row[95:80] :
                   ((fb == 2) ? ra_row[111:96] :
                   ra_row[127:112]))),
                   ((fb == 0) ? ra_row[15:0] :
                   ((fb == 1) ? ra_row[31:16] :
                   ((fb == 2) ? ra_row[47:32] :
                   ra_row[63:48])))};
    assign sfx_src = sr[cur[12:9]];
    assign fx_s = {240'd0, u_sf2s_f};
    assign func_x = (cur_sf ? fx_s : fx_v);
    assign func_es = (cur_sf ? u_sf2s_e : ra_e);
    assign func_sel = (cur_sf ? cur[15:13] : cur[17:15]);
    assign func_kc_c = (((func_sel == 3'd3) | (func_sel == 3'd4)) ? 16'd20861 : 16'd47274);
    assign fdst = (is_sfun ? {4'd0, cur[8:5]} : {cur[8:5], slice_i});
    assign fq_i = (is_sfun ? 2'd0 : fb);
    assign fm_in = {cur_slot, fdst, fq_i, is_sfun, 1'd1};
    assign fo_v = fm11[0];
    assign fo_sc = fm11[1];
    assign fo_dst = fm11[11:4];
    assign fo_slot = fm11[13:12];
    assign fo_row = fo_row_q;
    assign fo_m3 = u_func_m;
    assign fo_e3 = u_func_ed;
    assign fo_s3 = u_func_sgn;
    assign frow_m = {fo_m3[303:285], fq_m2[303:285], fq_m1[303:285], fq_m0[303:285], fo_m3[284:266], fq_m2[284:266],
                     fq_m1[284:266], fq_m0[284:266], fo_m3[265:247], fq_m2[265:247], fq_m1[265:247], fq_m0[265:247],
                     fo_m3[246:228], fq_m2[246:228], fq_m1[246:228], fq_m0[246:228], fo_m3[227:209], fq_m2[227:209],
                     fq_m1[227:209], fq_m0[227:209], fo_m3[208:190], fq_m2[208:190], fq_m1[208:190], fq_m0[208:190],
                     fo_m3[189:171], fq_m2[189:171], fq_m1[189:171], fq_m0[189:171], fo_m3[170:152], fq_m2[170:152],
                     fq_m1[170:152], fq_m0[170:152], fo_m3[151:133], fq_m2[151:133], fq_m1[151:133], fq_m0[151:133],
                     fo_m3[132:114], fq_m2[132:114], fq_m1[132:114], fq_m0[132:114], fo_m3[113:95], fq_m2[113:95],
                     fq_m1[113:95], fq_m0[113:95], fo_m3[94:76], fq_m2[94:76], fq_m1[94:76], fq_m0[94:76], fo_m3[75:57],
                     fq_m2[75:57], fq_m1[75:57], fq_m0[75:57], fo_m3[56:38], fq_m2[56:38], fq_m1[56:38], fq_m0[56:38],
                     fo_m3[37:19], fq_m2[37:19], fq_m1[37:19], fq_m0[37:19], fo_m3[18:0], fq_m2[18:0], fq_m1[18:0],
                     fq_m0[18:0]};
    assign frow_ed = {fo_e3[143:135], fq_e2[143:135], fq_e1[143:135], fq_e0[143:135], fo_e3[134:126], fq_e2[134:126],
                      fq_e1[134:126], fq_e0[134:126], fo_e3[125:117], fq_e2[125:117], fq_e1[125:117], fq_e0[125:117],
                      fo_e3[116:108], fq_e2[116:108], fq_e1[116:108], fq_e0[116:108], fo_e3[107:99], fq_e2[107:99],
                      fq_e1[107:99], fq_e0[107:99], fo_e3[98:90], fq_e2[98:90], fq_e1[98:90], fq_e0[98:90],
                      fo_e3[89:81], fq_e2[89:81], fq_e1[89:81], fq_e0[89:81], fo_e3[80:72], fq_e2[80:72], fq_e1[80:72],
                      fq_e0[80:72], fo_e3[71:63], fq_e2[71:63], fq_e1[71:63], fq_e0[71:63], fo_e3[62:54], fq_e2[62:54],
                      fq_e1[62:54], fq_e0[62:54], fo_e3[53:45], fq_e2[53:45], fq_e1[53:45], fq_e0[53:45], fo_e3[44:36],
                      fq_e2[44:36], fq_e1[44:36], fq_e0[44:36], fo_e3[35:27], fq_e2[35:27], fq_e1[35:27], fq_e0[35:27],
                      fo_e3[26:18], fq_e2[26:18], fq_e1[26:18], fq_e0[26:18], fo_e3[17:9], fq_e2[17:9], fq_e1[17:9],
                      fq_e0[17:9], fo_e3[8:0], fq_e2[8:0], fq_e1[8:0], fq_e0[8:0]};
    assign frow_s = {fo_s3[15], fq_s2[15], fq_s1[15], fq_s0[15], fo_s3[14], fq_s2[14], fq_s1[14], fq_s0[14], fo_s3[13],
                     fq_s2[13], fq_s1[13], fq_s0[13], fo_s3[12], fq_s2[12], fq_s1[12], fq_s0[12], fo_s3[11], fq_s2[11],
                     fq_s1[11], fq_s0[11], fo_s3[10], fq_s2[10], fq_s1[10], fq_s0[10], fo_s3[9], fq_s2[9], fq_s1[9],
                     fq_s0[9], fo_s3[8], fq_s2[8], fq_s1[8], fq_s0[8], fo_s3[7], fq_s2[7], fq_s1[7], fq_s0[7], fo_s3[6],
                     fq_s2[6], fq_s1[6], fq_s0[6], fo_s3[5], fq_s2[5], fq_s1[5], fq_s0[5], fo_s3[4], fq_s2[4], fq_s1[4],
                     fq_s0[4], fo_s3[3], fq_s2[3], fq_s1[3], fq_s0[3], fo_s3[2], fq_s2[2], fq_s1[2], fq_s0[2], fo_s3[1],
                     fq_s2[1], fq_s1[1], fq_s0[1], fo_s3[0], fq_s2[0], fq_s1[0], fq_s0[0]};
    assign g_wen = (((g_v2 | g_l2) | g_l5) | g_sb);
    assign g_waddr = (g_v2 ? w_dst8 : (g_l2 ? l2_dst8 : (g_l5 ? l5_dst8 : sb_dst8)));
    assign sb_row_g_0 = {8{sb_f_g_0}};
    assign sb_row_g_1 = {8{sb_f_g_1}};
    assign sb_row_g_2 = {8{sb_f_g_2}};
    assign sb_row_g_3 = {8{sb_f_g_3}};
    assign sb_row_g_4 = {8{sb_f_g_4}};
    assign sb_row_g_5 = {8{sb_f_g_5}};
    assign sb_row_g_6 = {8{sb_f_g_6}};
    assign sb_row_g_7 = {8{sb_f_g_7}};
    assign sb_row = {sb_row_g_7, sb_row_g_6, sb_row_g_5, sb_row_g_4, sb_row_g_3, sb_row_g_2, sb_row_g_1, sb_row_g_0};
    assign g_wdata = (g_v2 ? w_f : (g_l2 ? l2_row : (g_l5 ? u_pk_fq : sb_row)));
    assign g_we = (g_v2 ? w_e : (g_l2 ? l2_e : (g_l5 ? l5_e : sb_e)));
    assign g_wslot = (g_v2 ? w_slot : (g_l2 ? l2_slot : (g_l5 ? l5_slot : sb_slot)));
    assign s_wen = (((g_rw | g_s2) | g_sl2) | g_sf2);
    assign s_wval = (g_rw ? rw_out : (g_s2 ? s2_val : (g_sl2 ? sl2_wv : sf2_val)));
    assign s_wdst = (g_rw ? rw_dst : (g_s2 ? s2_dst : (g_sl2 ? sl2_dst : sf2_dst)));
    assign s_wslot = (g_rw ? rw_slot : (g_s2 ? s2_slot : (g_sl2 ? sl2_slot : sf2_slot)));
    assign nfl_w = ((((3'd0 + {2'd0, ift_v_0}) + {2'd0, ift_v_1}) + {2'd0, ift_v_2}) + {2'd0, ift_v_3});
    assign memoutst = ((((3'd0 + {2'd0, ((ift_v_0 & ift_mem[0]) & (~ift_mdone[0]))})
                       + {2'd0, ((ift_v_1 & ift_mem[1]) & (~ift_mdone[1]))})
                       + {2'd0, ((ift_v_2 & ift_mem[2]) & (~ift_mdone[2]))})
                       + {2'd0, ((ift_v_3 & ift_mem[3]) & (~ift_mdone[3]))});
    assign seq_due_c = (((tick - seqfree) & 16'd32768) == 0);
    assign idle0 = (state == 0);
    assign kw_rdy = (((~dq_full) & (~(ws_v & (dq_n == 4'd7)))) & seq_due_c);
    assign lc_go = (ld_v & kw_lcrdy);
    assign kw_is_sl = (((w_ins[4:0] == 9) | (w_ins[4:0] == 10)) | (w_ins[4:0] == 24));
    assign kw_vid = (kw_is_sl ? w_ins[16:11] : w_ins[17:12]);
    assign kw_vid_b = w_ins[15:10];
    assign w_ins = u_kw_out_inst;
    assign kw_lcrdy = u_kw_lc_ready;
    assign kern_act = u_kw_busy;
    assign kw_take = (kw_rdy & u_kw_out_v);
    assign rd_a = u_kw_im_addr[9:0];
    assign kv = ws_kv;
    assign kv_cid = (({2'd0, kv[28:23]} * 4) + {5'd0, kv[22:20]});
    assign kvb = ws_kvb;
    assign dq_wi = dq_wp[2:0];
    assign dq_ri = dq_rp[2:0];
    assign dq_n = (dq_wp - dq_rp);
    assign dq_full = dq_n[3];
    assign dq_empty = (dq_wp == dq_rp);
    assign dqh_ins = dq_ins[dq_ri];
    assign dqh_lad = dq_lad[dq_ri];
    assign dqh_cfg = dq_cfg[dq_ri];
    assign dqh_c32 = dq_c32[dq_ri];
    assign dqh_pd = dq_pd[dq_ri];
    assign dqh_tl = dqh_pd[29:23];
    assign dqh_tlm = {(dqh_tl > 63), (dqh_tl > 62), (dqh_tl > 61), (dqh_tl > 60), (dqh_tl > 59), (dqh_tl > 58),
                      (dqh_tl > 57), (dqh_tl > 56), (dqh_tl > 55), (dqh_tl > 54), (dqh_tl > 53), (dqh_tl > 52),
                      (dqh_tl > 51), (dqh_tl > 50), (dqh_tl > 49), (dqh_tl > 48), (dqh_tl > 47), (dqh_tl > 46),
                      (dqh_tl > 45), (dqh_tl > 44), (dqh_tl > 43), (dqh_tl > 42), (dqh_tl > 41), (dqh_tl > 40),
                      (dqh_tl > 39), (dqh_tl > 38), (dqh_tl > 37), (dqh_tl > 36), (dqh_tl > 35), (dqh_tl > 34),
                      (dqh_tl > 33), (dqh_tl > 32), (dqh_tl > 31), (dqh_tl > 30), (dqh_tl > 29), (dqh_tl > 28),
                      (dqh_tl > 27), (dqh_tl > 26), (dqh_tl > 25), (dqh_tl > 24), (dqh_tl > 23), (dqh_tl > 22),
                      (dqh_tl > 21), (dqh_tl > 20), (dqh_tl > 19), (dqh_tl > 18), (dqh_tl > 17), (dqh_tl > 16),
                      (dqh_tl > 15), (dqh_tl > 14), (dqh_tl > 13), (dqh_tl > 12), (dqh_tl > 11), (dqh_tl > 10),
                      (dqh_tl > 9), (dqh_tl > 8), (dqh_tl > 7), (dqh_tl > 6), (dqh_tl > 5), (dqh_tl > 4), (dqh_tl > 3),
                      (dqh_tl > 2), (dqh_tl > 1), (dqh_tl > 0)};
    assign ld_wb_ok = ((~l2_v) & sl2_free);
    assign dq_pop = (((idle0 & (~dq_empty)) & (nfl_w < 4)) & ld_wb_ok);
    assign dq_byp = ((((ws_v & dq_empty) & idle0) & (nfl_w < 4)) & ld_wb_ok);
    assign ws_is_sl_c0 = ((ws_ins[4:0] == 9) | (ws_ins[4:0] == 10));
    assign ws_is_sl = (ws_is_sl_c0 | (ws_ins[4:0] == 24));
    assign kw_boff = (ws_is_sl ? ws_ins[46:19] : ws_ins[47:20]);
    assign kw_is_l1 = (ws_is_sl ? (ws_ins[10:9] == 0) : (ws_ins[11:10] == 0));
    assign kw_lad = (kw_is_l1 ? {20'd0, (kv[19:0] + kw_boff)} : (kv + kw_boff));
    assign ws_lo6 = kw_lad[5:0];
    assign ws_df_0_c0 = ((((ws_ins[4:0] >= 5'd1) & (ws_ins[4:0] <= 5'd13)) | (ws_ins[4:0] == 22)) | (ws_ins[4:0] == 23));
    assign ws_df_0_c1 = ((ws_ins[4:0] == 5) & (ws_ins[17:15] > 3'd4));
    assign ws_df_0_c2 = ((ws_ins[4:0] == 12) & (ws_ins[15:13] > 3'd5));
    assign ws_df_0_c3 = ((ws_ins[21:18] > 4'd6) & (ws_ins[21:18] <= 4'd10));
    assign ws_df_0_c4 = ((ws_ins[4:0] == 1) | (ws_ins[4:0] == 2));
    assign ws_df_0_c5 = (ws_df_0_c4 ? ws_ins[59:48] :
                        ((ws_ins[4:0] == 23) ? ws_ins[81:70] :
                        ((ws_is_sl_c0 | (ws_ins[4:0] == 24)) ? 12'd1 :
                        ws_ins[64:53])));
    assign ws_df_0_c6 = ((((ws_df_0_c5 == 0) ? 12'd16 : ((ws_df_0_c5 + 12'd63) >> 6))
                          & ({6'd0, (6'd1 << (ws_ins[21:18] - 4'd6))} - 12'd1)) == 12'd0);
    assign ws_df_0_c7 = ((((((((ws_ins[4:0] >= 5'd1) & (ws_ins[4:0] <= 5'd7)) | (ws_ins[4:0] == 23))
                             | ((ws_ins[4:0] == 13) & ws_ins[17])) & ws_ins[9])
                         | (((((ws_ins[4:0] == 4) | (ws_ins[4:0] == 5)) | (ws_ins[4:0] == 7)) | (ws_ins[4:0] == 13))
                            & ws_ins[14])) | (((ws_ins[4:0] == 4) & (ws_ins[20:19] == 2'd0)) & ws_ins[25]))
                         | ((ws_ins[4:0] == 7) & ws_ins[52]));
    assign ws_df_0_c8 = ((((((ws_ins[4:0] == 1) & (ws_ins[62:60] != 0)) & (ws_ins[62:60] != 1)) & (ws_ins[62:60] != 3))
                          & (ws_ins[62:60] != 4))
                         | (((((ws_ins[4:0] == 23) & (ws_ins[84:82] != 0)) & (ws_ins[84:82] != 1))
                            & (ws_ins[84:82] != 3)) & (ws_ins[84:82] != 4)));
    assign ws_df_0 = ((((((ws_df_0_c0 | (ws_ins[4:0] == 24)) & (~ws_df_0_c1)) & (~ws_df_0_c2))
                      & (((~((ws_ins[4:0] == 13) & ws_ins[17])) | (ws_ins[21:18] == 4'd6)) | (ws_df_0_c3 & ws_df_0_c6)))
                      & (~ws_df_0_c7)) & (~ws_df_0_c8));
    assign ws_df_1_c0 = ((ws_df_0_c4 | (ws_ins[4:0] == 9)) | (ws_ins[4:0] == 10));
    assign ws_df_1 = (ws_df_1_c0
                      & ((((((ws_df_0_c0 | (ws_ins[4:0] == 24)) & (~ws_df_0_c1)) & (~ws_df_0_c2))
                         & (((~((ws_ins[4:0] == 13) & ws_ins[17])) | (ws_ins[21:18] == 4'd6))
                            | (ws_df_0_c3 & ws_df_0_c6))) & (~ws_df_0_c7)) & (~ws_df_0_c8)));
    assign ws_df_2 = ((~((((((ws_df_0_c0 | (ws_ins[4:0] == 24)) & (~ws_df_0_c1)) & (~ws_df_0_c2))
                         & (((~((ws_ins[4:0] == 13) & ws_ins[17])) | (ws_ins[21:18] == 4'd6))
                            | (ws_df_0_c3 & ws_df_0_c6))) & (~ws_df_0_c7)) & (~ws_df_0_c8))) ? 5'd0 :
                     ((((((ws_ins[4:0] == 4) & (ws_ins[18:15] == 3)) & (ws_ins[20:19] != 0))
                       | ((ws_ins[4:0] == 11) & (ws_ins[16:13] == 3))) | ((ws_ins[4:0] == 12) & (ws_ins[15:13] == 5)))
                      ? 5'd2 :
                     (((((ws_ins[4:0] == 3) | (ws_ins[4:0] == 4)) | (ws_ins[4:0] == 6)) | (ws_ins[4:0] == 7)) ? 5'd1 :
                     ((ws_ins[4:0] == 5) ? 5'd7 :
                     ((ws_ins[4:0] == 12) ? ((ws_ins[15:13] == 5) ? 5'd2 : 5'd21) :
                     ((ws_ins[4:0] == 13) ? 5'd3 :
                     (((ws_ins[4:0] == 23) | (ws_ins[4:0] == 24)) ? 5'd29 :
                     ((ws_ins[4:0] == 1) ? 5'd6 :
                     ((ws_ins[4:0] == 2) ? 5'd11 :
                     ((ws_ins[4:0] == 9) ? 5'd15 :
                     ((ws_ins[4:0] == 10) ? 5'd18 :
                     (((ws_ins[4:0] == 8) | (ws_ins[4:0] == 11)) ? 5'd13 :
                     ((ws_ins[4:0] == 22) ? 5'd31 :
                     5'd0)))))))))))));
    assign ws_df_3 = ((~((((((ws_df_0_c0 | (ws_ins[4:0] == 24)) & (~ws_df_0_c1)) & (~ws_df_0_c2))
                         & (((~((ws_ins[4:0] == 13) & ws_ins[17])) | (ws_ins[21:18] == 4'd6))
                            | (ws_df_0_c3 & ws_df_0_c6))) & (~ws_df_0_c7)) & (~ws_df_0_c8))) ? 12'd0 :
                     (((((((((ws_ins[4:0] == 1) | (ws_ins[4:0] == 3)) | (ws_ins[4:0] == 4)) | (ws_ins[4:0] == 5))
                       | (ws_ins[4:0] == 6)) | (ws_ins[4:0] == 7)) | (ws_ins[4:0] == 23))
                       | ((ws_ins[4:0] == 13) & ws_ins[17]))
                      ? ((ws_df_0_c5 == 0) ? 12'd16 : ((ws_df_0_c5 + 12'd63) >> 6)) :
                     ((((ws_ins[4:0] == 2) | (ws_ins[4:0] == 10)) | (ws_ins[4:0] == 22)) ? 12'd0 :
                     12'd1)));
    assign ws_df_4 = (((((((ws_df_0_c0 | (ws_ins[4:0] == 24)) & (~ws_df_0_c1)) & (~ws_df_0_c2))
                      & (((~((ws_ins[4:0] == 13) & ws_ins[17])) | (ws_ins[21:18] == 4'd6)) | (ws_df_0_c3 & ws_df_0_c6)))
                      & (~ws_df_0_c7)) & (~ws_df_0_c8)) & ((ws_df_1_c0 | (ws_ins[4:0] == 23)) | (ws_ins[4:0] == 24)));
    assign ws_df_5 = ((ws_df_0_c5 == 0) ? 12'd16 : ((ws_df_0_c5 + 12'd63) >> 6));
    assign ws_df_6 = (((ws_df_0_c5 == 0) ? 12'd16 : ((ws_df_0_c5 + 12'd63) >> 6)) - 1);
    assign ws_df_7_c0 = ((ws_ins[4:0] == 23) ? ws_ins[75:70] :
                        ((ws_df_0_c4 | (ws_is_sl_c0 | (ws_ins[4:0] == 24))) ? ws_ins[53:48] :
                        ws_ins[58:53]));
    assign ws_df_7 = ((ws_df_7_c0 == 0) ? 7'd64 : {1'd0, ws_df_7_c0});
    assign ws_df_8_c0 = ((ws_ins[4:0] == 23) ? ws_ins[84:82] : ws_ins[62:60]);
    assign ws_df_8_c1 = (((ws_df_8_c0 == 1) | (ws_df_8_c0 == 2)) ? 2'd2 :
                        (((ws_df_8_c0 == 3) | (ws_df_8_c0 == 4)) ? 2'd0 :
                        2'd1));
    assign ws_df_8 = ({2'd0, ((((ws_df_0_c5 == 0) ? 12'd16 : ((ws_df_0_c5 + 12'd63) >> 6)) == 1) ? ws_df_7 : 7'd64)}
                      << ws_df_8_c1);
    assign ws_df_9 = ((({4'd0, ws_lo6} + {1'd0, ws_df_8}) + 10'd63) >> 6);
    assign ws_df_10 = (({2'd0, ws_df_8} + 11'd63) >> 6);
    assign ws_df_11 = (((ws_df_8 & 9'd63) == 0) ? 9'd64 : (ws_df_8 & 9'd63));
    assign ws_df_12 = ({2'd0, ws_df_7} << ws_df_8_c1);
    assign ws_df_13 = (9'd64 << ws_df_8_c1);
    assign ws_pd = {ws_df_13, ws_df_12, ws_df_11, ws_df_10, ws_df_9, ws_df_8, ws_df_7, ws_df_6, ws_df_5, ws_df_4,
                    ws_df_3, ws_df_2, ws_df_1, ws_df_0};
    assign ws_tlm = {(ws_df_7 > 63), (ws_df_7 > 62), (ws_df_7 > 61), (ws_df_7 > 60), (ws_df_7 > 59), (ws_df_7 > 58),
                     (ws_df_7 > 57), (ws_df_7 > 56), (ws_df_7 > 55), (ws_df_7 > 54), (ws_df_7 > 53), (ws_df_7 > 52),
                     (ws_df_7 > 51), (ws_df_7 > 50), (ws_df_7 > 49), (ws_df_7 > 48), (ws_df_7 > 47), (ws_df_7 > 46),
                     (ws_df_7 > 45), (ws_df_7 > 44), (ws_df_7 > 43), (ws_df_7 > 42), (ws_df_7 > 41), (ws_df_7 > 40),
                     (ws_df_7 > 39), (ws_df_7 > 38), (ws_df_7 > 37), (ws_df_7 > 36), (ws_df_7 > 35), (ws_df_7 > 34),
                     (ws_df_7 > 33), (ws_df_7 > 32), (ws_df_7 > 31), (ws_df_7 > 30), (ws_df_7 > 29), (ws_df_7 > 28),
                     (ws_df_7 > 27), (ws_df_7 > 26), (ws_df_7 > 25), (ws_df_7 > 24), (ws_df_7 > 23), (ws_df_7 > 22),
                     (ws_df_7 > 21), (ws_df_7 > 20), (ws_df_7 > 19), (ws_df_7 > 18), (ws_df_7 > 17), (ws_df_7 > 16),
                     (ws_df_7 > 15), (ws_df_7 > 14), (ws_df_7 > 13), (ws_df_7 > 12), (ws_df_7 > 11), (ws_df_7 > 10),
                     (ws_df_7 > 9), (ws_df_7 > 8), (ws_df_7 > 7), (ws_df_7 > 6), (ws_df_7 > 5), (ws_df_7 > 4),
                     (ws_df_7 > 3), (ws_df_7 > 2), (ws_df_7 > 1), (ws_df_7 > 0)};
    assign cq_w = cq_i[cq_rp[2:0]];
    assign cq_lad_c0 = (((cq_w[4:0] == 9) | (cq_w[4:0] == 10)) | (cq_w[4:0] == 24));
    assign cq_lad = {20'd0, (cq_lad_c0 ? cq_w[46:19] : cq_w[47:20])};
    assign cq_cfg = (cq_lad_c0 ? cq_w[18:11] : cq_w[19:12]);
    assign cq_lo6 = (cq_lad_c0 ? cq_w[24:19] : cq_w[25:20]);
    assign cq_df_0_c0 = ((((cq_w[4:0] >= 5'd1) & (cq_w[4:0] <= 5'd13)) | (cq_w[4:0] == 22)) | (cq_w[4:0] == 23));
    assign cq_df_0_c1 = ((cq_w[4:0] == 5) & (cq_w[17:15] > 3'd4));
    assign cq_df_0_c2 = ((cq_w[4:0] == 12) & (cq_w[15:13] > 3'd5));
    assign cq_df_0_c3 = ((cq_w[21:18] > 4'd6) & (cq_w[21:18] <= 4'd10));
    assign cq_df_0_c4 = (((cq_w[4:0] == 1) | (cq_w[4:0] == 2)) ? cq_w[59:48] :
                        ((cq_w[4:0] == 23) ? cq_w[81:70] :
                        (cq_lad_c0 ? 12'd1 :
                        cq_w[64:53])));
    assign cq_df_0_c5 = ((((cq_df_0_c4 == 0) ? 12'd16 : ((cq_df_0_c4 + 12'd63) >> 6))
                          & ({6'd0, (6'd1 << (cq_w[21:18] - 4'd6))} - 12'd1)) == 12'd0);
    assign cq_df_0_c6 = ((((((((cq_w[4:0] >= 5'd1) & (cq_w[4:0] <= 5'd7)) | (cq_w[4:0] == 23))
                             | ((cq_w[4:0] == 13) & cq_w[17])) & cq_w[9])
                         | (((((cq_w[4:0] == 4) | (cq_w[4:0] == 5)) | (cq_w[4:0] == 7)) | (cq_w[4:0] == 13)) & cq_w[14]))
                         | (((cq_w[4:0] == 4) & (cq_w[20:19] == 2'd0)) & cq_w[25])) | ((cq_w[4:0] == 7) & cq_w[52]));
    assign cq_df_0_c7 = ((((((cq_w[4:0] == 1) & (cq_w[62:60] != 0)) & (cq_w[62:60] != 1)) & (cq_w[62:60] != 3))
                          & (cq_w[62:60] != 4))
                         | (((((cq_w[4:0] == 23) & (cq_w[84:82] != 0)) & (cq_w[84:82] != 1)) & (cq_w[84:82] != 3))
                            & (cq_w[84:82] != 4)));
    assign cq_df_0 = ((((((cq_df_0_c0 | (cq_w[4:0] == 24)) & (~cq_df_0_c1)) & (~cq_df_0_c2))
                      & (((~((cq_w[4:0] == 13) & cq_w[17])) | (cq_w[21:18] == 4'd6)) | (cq_df_0_c3 & cq_df_0_c5)))
                      & (~cq_df_0_c6)) & (~cq_df_0_c7));
    assign cq_df_1_c0 = (((cq_w[4:0] == 1) | (cq_w[4:0] == 2)) | (cq_w[4:0] == 9));
    assign cq_df_1 = ((cq_df_1_c0 | (cq_w[4:0] == 10))
                      & ((((((cq_df_0_c0 | (cq_w[4:0] == 24)) & (~cq_df_0_c1)) & (~cq_df_0_c2))
                         & (((~((cq_w[4:0] == 13) & cq_w[17])) | (cq_w[21:18] == 4'd6)) | (cq_df_0_c3 & cq_df_0_c5)))
                         & (~cq_df_0_c6)) & (~cq_df_0_c7)));
    assign cq_df_2 = ((~((((((cq_df_0_c0 | (cq_w[4:0] == 24)) & (~cq_df_0_c1)) & (~cq_df_0_c2))
                         & (((~((cq_w[4:0] == 13) & cq_w[17])) | (cq_w[21:18] == 4'd6)) | (cq_df_0_c3 & cq_df_0_c5)))
                         & (~cq_df_0_c6)) & (~cq_df_0_c7))) ? 5'd0 :
                     ((((((cq_w[4:0] == 4) & (cq_w[18:15] == 3)) & (cq_w[20:19] != 0))
                       | ((cq_w[4:0] == 11) & (cq_w[16:13] == 3))) | ((cq_w[4:0] == 12) & (cq_w[15:13] == 5))) ? 5'd2 :
                     (((((cq_w[4:0] == 3) | (cq_w[4:0] == 4)) | (cq_w[4:0] == 6)) | (cq_w[4:0] == 7)) ? 5'd1 :
                     ((cq_w[4:0] == 5) ? 5'd7 :
                     ((cq_w[4:0] == 12) ? ((cq_w[15:13] == 5) ? 5'd2 : 5'd21) :
                     ((cq_w[4:0] == 13) ? 5'd3 :
                     (((cq_w[4:0] == 23) | (cq_w[4:0] == 24)) ? 5'd29 :
                     ((cq_w[4:0] == 1) ? 5'd6 :
                     ((cq_w[4:0] == 2) ? 5'd11 :
                     ((cq_w[4:0] == 9) ? 5'd15 :
                     ((cq_w[4:0] == 10) ? 5'd18 :
                     (((cq_w[4:0] == 8) | (cq_w[4:0] == 11)) ? 5'd13 :
                     ((cq_w[4:0] == 22) ? 5'd31 :
                     5'd0)))))))))))));
    assign cq_df_3 = ((~((((((cq_df_0_c0 | (cq_w[4:0] == 24)) & (~cq_df_0_c1)) & (~cq_df_0_c2))
                         & (((~((cq_w[4:0] == 13) & cq_w[17])) | (cq_w[21:18] == 4'd6)) | (cq_df_0_c3 & cq_df_0_c5)))
                         & (~cq_df_0_c6)) & (~cq_df_0_c7))) ? 12'd0 :
                     (((((((((cq_w[4:0] == 1) | (cq_w[4:0] == 3)) | (cq_w[4:0] == 4)) | (cq_w[4:0] == 5))
                       | (cq_w[4:0] == 6)) | (cq_w[4:0] == 7)) | (cq_w[4:0] == 23)) | ((cq_w[4:0] == 13) & cq_w[17]))
                      ? ((cq_df_0_c4 == 0) ? 12'd16 : ((cq_df_0_c4 + 12'd63) >> 6)) :
                     ((((cq_w[4:0] == 2) | (cq_w[4:0] == 10)) | (cq_w[4:0] == 22)) ? 12'd0 :
                     12'd1)));
    assign cq_df_4 = (((((((cq_df_0_c0 | (cq_w[4:0] == 24)) & (~cq_df_0_c1)) & (~cq_df_0_c2))
                      & (((~((cq_w[4:0] == 13) & cq_w[17])) | (cq_w[21:18] == 4'd6)) | (cq_df_0_c3 & cq_df_0_c5)))
                      & (~cq_df_0_c6)) & (~cq_df_0_c7))
                      & (((cq_df_1_c0 | (cq_w[4:0] == 10)) | (cq_w[4:0] == 23)) | (cq_w[4:0] == 24)));
    assign cq_df_5 = ((cq_df_0_c4 == 0) ? 12'd16 : ((cq_df_0_c4 + 12'd63) >> 6));
    assign cq_df_6 = (((cq_df_0_c4 == 0) ? 12'd16 : ((cq_df_0_c4 + 12'd63) >> 6)) - 1);
    assign cq_df_7_c0 = ((cq_w[4:0] == 23) ? cq_w[75:70] :
                        ((((cq_w[4:0] == 1) | (cq_w[4:0] == 2)) | cq_lad_c0) ? cq_w[53:48] :
                        cq_w[58:53]));
    assign cq_df_7 = ((cq_df_7_c0 == 0) ? 7'd64 : {1'd0, cq_df_7_c0});
    assign cq_df_8_c0 = ((cq_w[4:0] == 23) ? cq_w[84:82] : cq_w[62:60]);
    assign cq_df_8_c1 = (((cq_df_8_c0 == 1) | (cq_df_8_c0 == 2)) ? 2'd2 :
                        (((cq_df_8_c0 == 3) | (cq_df_8_c0 == 4)) ? 2'd0 :
                        2'd1));
    assign cq_df_8 = ({2'd0, ((((cq_df_0_c4 == 0) ? 12'd16 : ((cq_df_0_c4 + 12'd63) >> 6)) == 1) ? cq_df_7 : 7'd64)}
                      << cq_df_8_c1);
    assign cq_df_9 = ((({4'd0, cq_lo6} + {1'd0, cq_df_8}) + 10'd63) >> 6);
    assign cq_df_10 = (({2'd0, cq_df_8} + 11'd63) >> 6);
    assign cq_df_11 = (((cq_df_8 & 9'd63) == 0) ? 9'd64 : (cq_df_8 & 9'd63));
    assign cq_df_12 = ({2'd0, cq_df_7} << cq_df_8_c1);
    assign cq_df_13 = (9'd64 << cq_df_8_c1);
    assign cq_pd = {cq_df_13, cq_df_12, cq_df_11, cq_df_10, cq_df_9, cq_df_8, cq_df_7, cq_df_6, cq_df_5, cq_df_4,
                    cq_df_3, cq_df_2, cq_df_1, cq_df_0};
    assign cq_tlm = {(cq_df_7 > 63), (cq_df_7 > 62), (cq_df_7 > 61), (cq_df_7 > 60), (cq_df_7 > 59), (cq_df_7 > 58),
                     (cq_df_7 > 57), (cq_df_7 > 56), (cq_df_7 > 55), (cq_df_7 > 54), (cq_df_7 > 53), (cq_df_7 > 52),
                     (cq_df_7 > 51), (cq_df_7 > 50), (cq_df_7 > 49), (cq_df_7 > 48), (cq_df_7 > 47), (cq_df_7 > 46),
                     (cq_df_7 > 45), (cq_df_7 > 44), (cq_df_7 > 43), (cq_df_7 > 42), (cq_df_7 > 41), (cq_df_7 > 40),
                     (cq_df_7 > 39), (cq_df_7 > 38), (cq_df_7 > 37), (cq_df_7 > 36), (cq_df_7 > 35), (cq_df_7 > 34),
                     (cq_df_7 > 33), (cq_df_7 > 32), (cq_df_7 > 31), (cq_df_7 > 30), (cq_df_7 > 29), (cq_df_7 > 28),
                     (cq_df_7 > 27), (cq_df_7 > 26), (cq_df_7 > 25), (cq_df_7 > 24), (cq_df_7 > 23), (cq_df_7 > 22),
                     (cq_df_7 > 21), (cq_df_7 > 20), (cq_df_7 > 19), (cq_df_7 > 18), (cq_df_7 > 17), (cq_df_7 > 16),
                     (cq_df_7 > 15), (cq_df_7 > 14), (cq_df_7 > 13), (cq_df_7 > 12), (cq_df_7 > 11), (cq_df_7 > 10),
                     (cq_df_7 > 9), (cq_df_7 > 8), (cq_df_7 > 7), (cq_df_7 > 6), (cq_df_7 > 5), (cq_df_7 > 4),
                     (cq_df_7 > 3), (cq_df_7 > 2), (cq_df_7 > 1), (cq_df_7 > 0)};
    assign fs_idx = ((~ift_v_0) ? 2'd0 : ((~ift_v_1) ? 2'd1 : ((~ift_v_2) ? 2'd2 : ((~ift_v_3) ? 2'd3 : 2'd0))));
    assign rt_rdy = ((((1'd0 | ((ift_v_0 & (ift_wb[0] == 0)) & ((~ift_mem[0]) | ift_mdone[0])))
                     | ((ift_v_1 & (ift_wb[1] == 0)) & ((~ift_mem[1]) | ift_mdone[1])))
                     | ((ift_v_2 & (ift_wb[2] == 0)) & ((~ift_mem[2]) | ift_mdone[2])))
                     | ((ift_v_3 & (ift_wb[3] == 0)) & ((~ift_mem[3]) | ift_mdone[3])));
    assign rt_idx = (((ift_v_0 & (ift_wb[0] == 0)) & ((~ift_mem[0]) | ift_mdone[0])) ? 2'd0 :
                    (((ift_v_1 & (ift_wb[1] == 0)) & ((~ift_mem[1]) | ift_mdone[1])) ? 2'd1 :
                    (((ift_v_2 & (ift_wb[2] == 0)) & ((~ift_mem[2]) | ift_mdone[2])) ? 2'd2 :
                    (((ift_v_3 & (ift_wb[3] == 0)) & ((~ift_mem[3]) | ift_mdone[3])) ? 2'd3 :
                    2'd0))));
    assign iss_alu = (state == S_EX);
    assign red_go = (state == S_RED);
    assign iss_red = (red_go & rph);
    assign f_adv = (fen_v & (fb == 2'd3));
    assign pr_go = (((state == S_STW) & (~pr_v)) & (pr_sl < cur_ns));
    assign rd_en = (((((iss_alu & (~exph)) | iss_red) | f_adv) | pr_go) | (state == S_FRD));
    assign cq_n = (cq_wp - cq_rp);
    assign issue_ready = (issue_is_launch ? (lq_n < 8) : (cq_n < 8));
    assign cred_ok = (cur_port ? (cred_l1 != 0) : (cred_llc != 0));
    assign dbg_busy = busy_r;
    assign dbg_idle = ((~busy_r) & (cq_n == 0));
    assign dbg_retire = retire_p;
    assign dbg_donec = donec;
    assign dbg_occ = {2'd0, nfl_w};
    assign dbg_wb = wb_p;
    assign dbg_badop = badop_r;
    assign ra_sel = cur_ra;
    assign pr_sl_l = pr_sl[3:0];
    assign rd_sl = ((state == S_FUN) ? (slice_i + 4'd1) : ((state == S_STW) ? pr_sl_l : slice_i));
    assign rd_addr_a = {ra_sel, rd_sl};
    assign rb_sel = cur_rb;
    assign rd_addr_b = {rb_sel, slice_i};
    assign is_smem = ((((((state == S_SLDREQ) | (state == S_SLDRD)) | (state == S_SLDWB)) | (state == S_SSTREQ))
                      | (state == S_SSTW)) | (state == S_SSTB));
    assign in_streq = (state == S_SSTREQ);
    assign use_l1 = cur_port;
    assign ix_isel = (pa_cv2 ? ((pa_ins[4:0] == 23) ? pa_ins[51:48] : pa_ins[50:47]) :
                     ((cur[4:0] == 23) ? cur[51:48] :
                     cur[50:47]));
    assign ix_src = sr[ix_isel];
    assign ix_s_c = ((cur[4:0] == 23) ? cur[69:52] : cur[68:51]);
    assign ix_sn_c = (19'd0 - {1'd0, ix_s_c});
    assign ix_cz = ((ix_ng & (ix_u != 30'd0)) ? ({30'd0, ix_s} << 30) : 48'd0);
    assign pa_s_c = ((pa_ins[4:0] == 23) ? pa_ins[69:52] : pa_ins[68:51]);
    assign pa_sn_c = (19'd0 - {1'd0, pa_s_c});
    assign pa_cz = ((pa_ng & (pa_u != 30'd0)) ? ({30'd0, pa_s} << 30) : 48'd0);
    assign ix_laddr = ((cur_laddr + ix_pl) + (ix_ph << 17));
    assign ix_lo7 = ix_laddr[6:0];
    assign pah_op = dqh_ins[4:0];
    assign pah_vdt_ok = ((((pah_vdt == 0) | (pah_vdt == 1)) | (pah_vdt == 3)) | (pah_vdt == 4));
    assign pah_ld = (((((pah_op == 1) | (pah_op == 23)) & pah_vdt_ok) | (pah_op == 9)) | (pah_op == 24));
    assign pah_idx = ((pah_op == 23) | (pah_op == 24));
    assign pah_npre = ((pah_op == 23) ? dqh_ins[88] : dqh_ins[72]);
    assign pah_raw = (pah_idx & pah_npre);
    assign pa_ok = ((((((((state == S_LDRD) & (ar_sl == cur_ns)) | (state == S_SLDRD)) | (state == S_NOP))
                    | (state == S_EX)) | (state == S_FUN)) | (state == S_RED)) | ((state == S_STW) & (aw_sl == cur_ns)));
    assign pa_cvt = (((((pa_st == 0) & pa_ok) & (~dq_empty)) & pah_ld) & (~pah_raw));
    assign pa_cv2 = (pa_st == 4);
    assign pa_mul = (pa_st == 5);
    assign pa_add = (pa_st == 1);
    assign pa_sent = ((pa_st == 3) | (pa_req & ar_fire));
    assign pa_hit = (pa_sent & (pa_rp == dq_rp));
    assign pa_fire_d = (((pa_st == 2) & (pa_port ? (cred_l1 != 0) : (cred_llc != 0)))
                        & (pa_port ? l1_ar_ready : noc_ar_ready));
    assign pa_hit_d = (((pa_st == 3) | pa_fire_d) & (pa_rp == dq_rp));
    assign pa_cnt_d = (pa_sl + {4'd0, pa_fire_d});
    assign pa_nb = ((({4'd0, pa_lad[5:0]} + {1'd0, dqh_pd[38:30]}) + 10'd63) >> 6);
    assign pah_l1 = ((((dqh_ins[4:0] == 9) | (dqh_ins[4:0] == 10)) | (dqh_ins[4:0] == 24)) ? (dqh_ins[10:9] == 0) :
                    (dqh_ins[11:10] == 0));
    assign pah_scal = ((pah_op == 9) | (pah_op == 24));
    assign pah_mdt = ((pah_op == 24) ? dqh_ins[71:69] : dqh_ins[49:47]);
    assign pah_esz = (((pah_mdt == 1) | (pah_mdt == 2)) ? 3'd4 : 3'd2);
    assign pah_vdt = ((pah_op == 23) ? dqh_ins[84:82] : dqh_ins[62:60]);
    assign pah_vsh = (((pah_vdt == 1) | (pah_vdt == 2)) ? 2'd2 : (((pah_vdt == 3) | (pah_vdt == 4)) ? 2'd0 : 2'd1));
    assign pah_nl = ((pah_op == 1) ? dqh_ins[59:48] : ((pah_op == 23) ? dqh_ins[81:70] : 12'd1));
    assign pah_ns = ((pah_nl == 0) ? 5'd16 : ((pah_nl + 12'd63) >> 6));
    assign pah_tlf = ((pah_op == 23) ? dqh_ins[75:70] : dqh_ins[53:48]);
    assign pah_tl = ((pah_tlf == 0) ? 7'd64 : {1'd0, pah_tlf});
    assign pah_lanes0 = ((pah_ns == 1) ? pah_tl : 7'd64);
    assign pah_by = (pah_scal ? {17'd0, pah_esz} : ({13'd0, pah_lanes0} << pah_vsh));
    assign pah_last = (pah_scal ? 1'd1 : (pah_ns == 1));
    assign pa_sum = ((pa_lad + pa_pl) + (pa_ph << 17));
    assign pa_lad_al = {pa_lad[47:6], 6'd0};
    assign pa_addr = (pa_scal ? pa_lad_al : pa_nx);
    assign pa_nx1 = (pa_nx + {39'd0, pa_step});
    assign pa_bytes_c = (pa_scal ? pa_bytes : {11'd0, ((pa_sl == (pa_ns - 1)) ? pa_by_t : pa_step)});
    assign pa_last_c = (pa_scal ? 1'd1 : (pa_sl == (pa_ns - 1)));
    assign pa_more = ((((pa_st == 3) & (~pa_scal)) & (pa_sl < pa_ns)) & pa_ok);
    assign ld_act = (state == S_LDRD);
    assign ar_pend = (ld_act & (ar_sl < cur_ns));
    assign ar_seg = ar_nx;
    assign in_sldreq = (state == S_SLDREQ);
    assign ar_addr_m = (in_sldreq ? {cur_laddr[47:6], 6'd0} : ar_seg);
    assign ar_bytes_m = (in_sldreq ? {17'd0, esz} : {11'd0, ((ar_sl == cur_nsm1) ? bt_by_t : ld_step)});
    assign ar_first_m = (in_sldreq ? 1'd1 : (ar_sl == 0));
    assign ar_last_m = (in_sldreq ? 1'd1 : (ar_sl == cur_nsm1));
    assign ar_go = (ar_pend | in_sldreq);
    assign pa_req = (((pa_st == 2) | pa_more) & (~ar_go));
    assign ar_any = (ar_go | pa_req);
    assign ar_port = (pa_req ? pa_port : cur_port);
    assign ar_cred = (ar_port ? (cred_l1 != 0) : (cred_llc != 0));
    assign ar_addr_c = (pa_req ? pa_addr : ar_addr_m);
    assign ar_bytes_c = (pa_req ? pa_bytes_c : ar_bytes_m);
    assign ar_first_c = (pa_req ? (pa_sl == 0) : ar_first_m);
    assign ar_last_c = (pa_req ? pa_last_c : ar_last_m);
    assign ar_fire = ((ar_any & ar_cred) & (ar_port ? l1_ar_ready : noc_ar_ready));
    assign seg = aw_nx;
    assign seg_al = (is_smem ? {cur_laddr[47:6], 6'd0} : seg);
    assign aw_by = ((aw_sl == cur_nsm1) ? bt_by_t : ld_step);
    assign ax_bytes = (is_smem ? {17'd0, esz} : {11'd0, aw_by});
    assign ax_first = (is_smem ? 1'd1 : (aw_sl == 0));
    assign ax_last = (is_smem ? 1'd1 : (aw_sl == cur_nsm1));
    assign ax_cfg = cur_cfg;
    assign ar_cfg_c = (pa_req ? pa_cfg : cur_cfg);
    assign ax_off = seg_al[19:0];
    assign l1_ar_valid = ((ar_any & ar_port) & ar_cred);
    assign noc_ar_valid = ((ar_any & (~ar_port)) & ar_cred);
    assign l1_ar_id = 4'd0;
    assign noc_ar_id = 4'd0;
    assign l1_ar_tag = {14'd0, cur_slot};
    assign noc_ar_tag = {14'd0, cur_slot};
    assign l1_ar_cfg = ar_cfg_c;
    assign l1_ar_off = ar_addr_c[19:0];
    assign noc_ar_addr = ar_addr_c;
    assign l1_ar_bytes = ar_bytes_c;
    assign noc_ar_bytes = ar_bytes_c;
    assign l1_ar_rows = 16'd1;
    assign noc_ar_rows = 16'd1;
    assign l1_ar_stride = 20'd0;
    assign noc_ar_stride = 20'd0;
    assign l1_ar_first = ar_first_c;
    assign noc_ar_first = ar_first_c;
    assign l1_ar_last = ar_last_c;
    assign noc_ar_last = ar_last_c;
    assign ld_stall = ((ld_hs | ld_hs_pre) | hs2);
    assign lbw_hs1 = ((((state == S_LDRD) & (~hs2)) & ld_hs) & (~ldw_busy));
    assign lbw_tl_n = ((((ld_hs | ld_hs_pre) & (~lbw_hs1)) & (~((state == S_LDRD) & hs2)))
                       & (~(ldw_busy & (~((ldw_st == 6) & l2_free)))));
    assign ld_lastb = (beat == (cur_nb - 1));
    assign ld_rv_c = (rb_v | rb_fire);
    assign ld_arack_c = ((cur_port ? l1_ar_ready : noc_ar_ready) & cred_ok);
    assign rr_run = ((state == S_LDRD) ? ((~ld_stall) & (~(ld_rv_c & ld_lastb))) :
                    ((state == S_SLDRD) ? (~ld_rv_c) :
                    ((state == S_SLDREQ) ? (ld_arack_c & (~rb_v)) :
                    ((state == S_LDWB) ? ((((slice_i != cur_nsm1) & (ldw_st >= 5)) & (~rb_v)) & (~ld_stall)) :
                    ((state == S_IXADD) ? (((cur[4:0] == 23) & (~rb_v)) & (~ld_stall)) :
                    ((state == S_LDREQ) ? ((ld_arack_c & (~rb_v)) & (~ld_stall)) :
                    1'd0))))));
    assign l1_r_ready = (rr_q & use_l1);
    assign noc_r_ready = (rr_q & (~use_l1));
    assign rb_fire = ((l1_r_valid & l1_r_ready) | (noc_r_valid & noc_r_ready));
    assign rb_in = (cur_port ? l1_r_data : noc_r_data);
    assign st_ok = ((~sq_act) | (sq_slot == cur_slot));
    assign aw_pend = ((state == S_STW) & (aw_sl < cur_ns));
    assign aw_go = (((aw_pend | in_streq) & cred_ok) & st_ok);
    assign l1_aw_valid = (aw_go & use_l1);
    assign noc_aw_valid = (aw_go & (~use_l1));
    assign l1_aw_id = 4'd0;
    assign noc_aw_id = 4'd0;
    assign l1_aw_tag = {14'd0, cur_slot};
    assign noc_aw_tag = {14'd0, cur_slot};
    assign l1_aw_cfg = ax_cfg;
    assign l1_aw_off = ax_off;
    assign noc_aw_addr = seg_al;
    assign l1_aw_bytes = ax_bytes;
    assign noc_aw_bytes = ax_bytes;
    assign l1_aw_rows = 16'd1;
    assign noc_aw_rows = 16'd1;
    assign l1_aw_stride = 20'd0;
    assign noc_aw_stride = 20'd0;
    assign l1_aw_first = ax_first;
    assign noc_aw_first = ax_first;
    assign l1_aw_last = ax_last;
    assign noc_aw_last = ax_last;
    assign vbeat = u_stb_res;
    assign sst_w = ({56'd0, xq_sv} << {xq_la[2:0], 3'd0});
    assign sbs_0 = ((xq_la[5:3] == 0) ? sst_w[63:0] : 64'd0);
    assign sbs_1 = ((xq_la[5:3] == 1) ? sst_w[63:0] : ((xq_la[5:3] == 0) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbs_2 = ((xq_la[5:3] == 2) ? sst_w[63:0] : ((xq_la[5:3] == 1) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbs_3 = ((xq_la[5:3] == 3) ? sst_w[63:0] : ((xq_la[5:3] == 2) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbs_4 = ((xq_la[5:3] == 4) ? sst_w[63:0] : ((xq_la[5:3] == 3) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbs_5 = ((xq_la[5:3] == 5) ? sst_w[63:0] : ((xq_la[5:3] == 4) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbs_6 = ((xq_la[5:3] == 6) ? sst_w[63:0] : ((xq_la[5:3] == 5) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbs_7 = ((xq_la[5:3] == 7) ? sst_w[63:0] : ((xq_la[5:3] == 6) ? {40'd0, sst_w[87:64]} : 64'd0));
    assign sbeat = {sbs_7, sbs_6, sbs_5, sbs_4, sbs_3, sbs_2, sbs_1, sbs_0};
    assign wbeat_al = (xq_s ? sbeat : vbeat);
    assign lstrb = {(cur_wlb > 63), (cur_wlb > 62), (cur_wlb > 61), (cur_wlb > 60), (cur_wlb > 59), (cur_wlb > 58),
                    (cur_wlb > 57), (cur_wlb > 56), (cur_wlb > 55), (cur_wlb > 54), (cur_wlb > 53), (cur_wlb > 52),
                    (cur_wlb > 51), (cur_wlb > 50), (cur_wlb > 49), (cur_wlb > 48), (cur_wlb > 47), (cur_wlb > 46),
                    (cur_wlb > 45), (cur_wlb > 44), (cur_wlb > 43), (cur_wlb > 42), (cur_wlb > 41), (cur_wlb > 40),
                    (cur_wlb > 39), (cur_wlb > 38), (cur_wlb > 37), (cur_wlb > 36), (cur_wlb > 35), (cur_wlb > 34),
                    (cur_wlb > 33), (cur_wlb > 32), (cur_wlb > 31), (cur_wlb > 30), (cur_wlb > 29), (cur_wlb > 28),
                    (cur_wlb > 27), (cur_wlb > 26), (cur_wlb > 25), (cur_wlb > 24), (cur_wlb > 23), (cur_wlb > 22),
                    (cur_wlb > 21), (cur_wlb > 20), (cur_wlb > 19), (cur_wlb > 18), (cur_wlb > 17), (cur_wlb > 16),
                    (cur_wlb > 15), (cur_wlb > 14), (cur_wlb > 13), (cur_wlb > 12), (cur_wlb > 11), (cur_wlb > 10),
                    (cur_wlb > 9), (cur_wlb > 8), (cur_wlb > 7), (cur_wlb > 6), (cur_wlb > 5), (cur_wlb > 4),
                    (cur_wlb > 3), (cur_wlb > 2), (cur_wlb > 1), (cur_wlb > 0)};
    assign sselm = (esz4 ? 8'd15 : 8'd3);
    assign sstrb = ({56'd0, sselm} << sla6);
    assign vstrb = ((beat == (cur_wns - 1)) ? lstrb : (~64'd0));
    assign wstrb_al = (is_smem ? sstrb : vstrb);
    assign wq_v = (wq_vl | wq_vn);
    assign oq_v = wq_v;
    assign wq_hd = ((wq_rp == 0) ? wq_d_0 : ((wq_rp == 1) ? wq_d_1 : ((wq_rp == 2) ? wq_d_2 : wq_d_2)));
    assign wq_hs = ((wq_rp == 0) ? wq_s_0 : ((wq_rp == 1) ? wq_s_1 : ((wq_rp == 2) ? wq_s_2 : wq_s_2)));
    assign oq_acc = ((wq_vl & l1_w_ready[0]) | (wq_vn & noc_w_ready[0]));
    assign w_go = (((state == S_STW) & w_act) | (state == S_SSTW));
    assign wq_room = (~((wq_n == 2'd3) | ((wq_n == 2'd2) & xq_v)));
    assign oq_take = (w_go & wq_room);
    assign l1_w_valid = wq_vl;
    assign noc_w_valid = wq_vn;
    assign wq_rpn = (oq_acc ? ((wq_rp == 2'd2) ? 2'd0 : (wq_rp + 1)) : wq_rp);
    assign wq_nn = ((wq_n + {1'd0, xq_v}) - {1'd0, oq_acc});
    assign wq_hln = ((xq_v & (wq_wp == wq_rpn)) ? xq_l1 :
                    ((wq_rpn == 0) ? wq_l_0 :
                    ((wq_rpn == 1) ? wq_l_1 :
                    ((wq_rpn == 2) ? wq_l_2 :
                    wq_l_2))));
    assign l1_w_id = 4'd0;
    assign noc_w_id = 4'd0;
    assign l1_w_data = wq_hd;
    assign noc_w_data = wq_hd;
    assign l1_w_strb = wq_hs;
    assign noc_w_strb = wq_hs;
    assign l1_b_ready = (sq_act & sq_l1);
    assign noc_b_ready = (sq_act & (~sq_l1));
    assign st_aw_fire = (aw_go & (cur_port ? l1_aw_ready : noc_aw_ready));
    assign st_wdone = (oq_take & (is_smem ? 1'd1 : (beat == (cur_wnb - 1))));
    assign w_last_sl = (is_smem ? 1'd1 : (slice_i == cur_nsm1));
    assign st_fin = (st_wdone & w_last_sl);
    assign pr_sl_m1 = (pr_sl - 5'd1);
    assign hs_sl = pr_sl_m1[3:0];
    assign w_start = ((((state == S_STW) & pr_v) & (aw_sl >= pr_sl)) & ((~w_act) | st_wdone));
    assign sq_bv = (sq_act & (sq_l1 ? l1_b_valid : noc_b_valid));
    assign nx_hs3 = ((state == S_LDRD) & hs2);
    assign nx_lbq = (lbw_v & (~lbw_tail));
    assign row = isram_waddr[11:2];
    assign lane = isram_waddr[1:0];
    assign lq_push = ((issue_valid & issue_is_launch) & (lq_n < 8));
    assign f_l1 = ((ar_fire & ar_port) | (st_aw_fire & cur_port));
    assign f_nc = ((ar_fire & (~ar_port)) | (st_aw_fire & (~cur_port)));
    assign l2_done = ((ldw_busy & (ldw_st == 6)) & l2_free);
    assign l2v_n = (l2_done | (l2_v & (~g_l2)));
    assign cmp_n = ((((v5_v & v5_ph) | pk5_v) | bo_v) | (state == S_RXWB));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rb_v <= 0;
            rb_dat <= 0;
            retire_p <= 0;
            wb_p <= 0;
            bt_by_t <= 0;
            pa_by_t <= 0;
            bt_nb_f <= 0;
            bt_nb_t <= 0;
            bt_wnb_f <= 0;
            bt_wnb_t <= 0;
            bt_wlb_f <= 0;
            bt_wlb_t <= 0;
            vlm_q <= 0;
            sla6 <= 0;
            ex_v <= 0;
            ld_hs_pre <= 0;
            lbw_v <= 0;
            rr_q <= 0;
            lbw <= 0;
            lbw_ce <= 0;
            lbq_v <= 0;
            lbq_beat <= 0;
            lbq_tail <= 0;
            lbq_s0 <= 0;
            lbq_e0 <= 0;
            lbq_m0 <= 0;
            lbq_s1 <= 0;
            lbq_e1 <= 0;
            lbq_m1 <= 0;
            lbq_s2 <= 0;
            lbq_e2 <= 0;
            lbq_m2 <= 0;
            lbq_s3 <= 0;
            lbq_e3 <= 0;
            lbq_m3 <= 0;
            lxs0 <= 0;
            lxe0 <= 0;
            lxm0 <= 0;
            lxs1 <= 0;
            lxe1 <= 0;
            lxm1 <= 0;
            lxs2 <= 0;
            lxe2 <= 0;
            lxm2 <= 0;
            lxs3 <= 0;
            lxe3 <= 0;
            lxm3 <= 0;
            lx_en_0 <= 0;
            lx_src_0 <= 0;
            lx_en_1 <= 0;
            lx_src_1 <= 0;
            lx_en_2 <= 0;
            lx_src_2 <= 0;
            lx_en_3 <= 0;
            lx_src_3 <= 0;
            lgs_q <= 0;
            lgm_q <= 0;
            lge_q <= 0;
            ldw_go_q <= 0;
            ld_hs <= 0;
            xq_v <= 0;
            xq_s <= 0;
            xq_pk <= 0;
            xq_e_g_0 <= 0;
            xq_e_g_1 <= 0;
            xq_e_g_2 <= 0;
            xq_e_g_3 <= 0;
            xq_e_g_4 <= 0;
            xq_e_g_5 <= 0;
            xq_e_g_6 <= 0;
            xq_e_g_7 <= 0;
            xq_32 <= 0;
            li_q <= 0;
            li_f <= 0;
            xq_sv <= 0;
            xq_la <= 0;
            xq_stb <= 0;
            xq_l1 <= 0;
            wq_d_0 <= 0;
            wq_s_0 <= 0;
            wq_l_0 <= 0;
            wq_d_1 <= 0;
            wq_s_1 <= 0;
            wq_l_1 <= 0;
            wq_d_2 <= 0;
            wq_s_2 <= 0;
            wq_l_2 <= 0;
            wq_wp <= 0;
            wq_rp <= 0;
            wq_n <= 0;
            wq_vl <= 0;
            wq_vn <= 0;
            ra0 <= 0;
            ra1 <= 0;
            ra2 <= 0;
            ra3 <= 0;
            ra4 <= 0;
            ra5 <= 0;
            ra6 <= 0;
            ra7 <= 0;
            rb0 <= 0;
            rb1 <= 0;
            rb2 <= 0;
            rb3 <= 0;
            rb4 <= 0;
            rb5 <= 0;
            rb6 <= 0;
            rb7 <= 0;
            ra_e <= 0;
            d1_ea <= 0;
            d1_eb <= 0;
            d1_op <= 0;
            d1_isw <= 0;
            d1_evt <= 0;
            d1_vt <= 0;
            oha_g_0 <= 0;
            ohb_g_0 <= 0;
            oha_g_1 <= 0;
            ohb_g_1 <= 0;
            oha_g_2 <= 0;
            ohb_g_2 <= 0;
            oha_g_3 <= 0;
            ohb_g_3 <= 0;
            oha_g_4 <= 0;
            ohb_g_4 <= 0;
            oha_g_5 <= 0;
            ohb_g_5 <= 0;
            oha_g_6 <= 0;
            ohb_g_6 <= 0;
            oha_g_7 <= 0;
            ohb_g_7 <= 0;
            d_eo <= 0;
            d_voh_g_0 <= 0;
            d_vt_g_0 <= 0;
            d_voh_g_1 <= 0;
            d_vt_g_1 <= 0;
            d_voh_g_2 <= 0;
            d_vt_g_2 <= 0;
            d_voh_g_3 <= 0;
            d_vt_g_3 <= 0;
            d_voh_g_4 <= 0;
            d_vt_g_4 <= 0;
            d_voh_g_5 <= 0;
            d_vt_g_5 <= 0;
            d_voh_g_6 <= 0;
            d_vt_g_6 <= 0;
            d_voh_g_7 <= 0;
            d_vt_g_7 <= 0;
            rd_q <= 0;
            lq_wp <= 0;
            lq_rp <= 0;
            lq_n <= 0;
            cq_wp <= 0;
            ar_nx <= 0;
            ar_sl <= 0;
            cred_l1 <= 4;
            cred_llc <= 4;
            wp_v <= 0;
            wp_addr <= 0;
            wp_row <= 0;
            wp_e <= 0;
            wp_slot <= 0;
            v1_v <= 0;
            v1_ph <= 0;
            v1_op_g_0 <= 0;
            v1_isw_g_0 <= 0;
            v1_op_g_1 <= 0;
            v1_isw_g_1 <= 0;
            v1_op_g_2 <= 0;
            v1_isw_g_2 <= 0;
            v1_op_g_3 <= 0;
            v1_isw_g_3 <= 0;
            v1_op_g_4 <= 0;
            v1_isw_g_4 <= 0;
            v1_op_g_5 <= 0;
            v1_isw_g_5 <= 0;
            v1_op_g_6 <= 0;
            v1_isw_g_6 <= 0;
            v1_op_g_7 <= 0;
            v1_isw_g_7 <= 0;
            v1_src <= 0;
            v1_c32 <= 0;
            v1_lbase <= 0;
            v1_dst8 <= 0;
            v1_slot <= 0;
            v2_v <= 0;
            v2_ph <= 0;
            v2_src <= 0;
            v2_c32 <= 0;
            v2_lbase <= 0;
            v2_dst8 <= 0;
            v2_slot <= 0;
            v3_v <= 0;
            v3_ph <= 0;
            v3_src <= 0;
            v3_c32 <= 0;
            v3_lbase <= 0;
            v3_dst8 <= 0;
            v3_slot <= 0;
            v4_v <= 0;
            v4_ph <= 0;
            v4_src <= 0;
            v4_lbase <= 0;
            v4_cf <= 0;
            v4_ce <= 0;
            v4_dst8 <= 0;
            v4_slot <= 0;
            v5_v <= 0;
            v5_ph <= 0;
            v5_src <= 0;
            v5_cf_g_0 <= 0;
            v5_cf_g_1 <= 0;
            v5_cf_g_2 <= 0;
            v5_cf_g_3 <= 0;
            v5_cf_g_4 <= 0;
            v5_cf_g_5 <= 0;
            v5_cf_g_6 <= 0;
            v5_cf_g_7 <= 0;
            v5_ce <= 0;
            v5_dst8 <= 0;
            v5_slot <= 0;
            w_v <= 0;
            w_src <= 0;
            w_cf_g_0 <= 0;
            w_cf_g_1 <= 0;
            w_cf_g_2 <= 0;
            w_cf_g_3 <= 0;
            w_cf_g_4 <= 0;
            w_cf_g_5 <= 0;
            w_cf_g_6 <= 0;
            w_cf_g_7 <= 0;
            w_e <= 0;
            w_dst8 <= 0;
            w_slot <= 0;
            v0_v <= 0;
            s1_v <= 0;
            s1_isc <= 0;
            s1_c32 <= 0;
            s1_cint <= 0;
            s1_cpk <= 0;
            s1_dst <= 0;
            s1_slot <= 0;
            s2_v <= 0;
            s2_val <= 0;
            s2_dst <= 0;
            s2_slot <= 0;
            s0_v <= 0;
            l2_v <= 0;
            ldw_go <= 0;
            ldw_st <= 0;
            ldw_busy <= 0;
            l2_e <= 0;
            l2_dst8 <= 0;
            l2_slot <= 0;
            l2_row <= 0;
            l2f_g_0 <= 1;
            l2f_g_1 <= 1;
            l2f_g_2 <= 1;
            l2f_g_3 <= 1;
            l2f_g_4 <= 1;
            l2f_g_5 <= 1;
            l2f_g_6 <= 1;
            l2f_g_7 <= 1;
            l2f_g_8 <= 1;
            l2f_g_9 <= 1;
            l2f_g_10 <= 1;
            l2f_g_11 <= 1;
            l2f_g_12 <= 1;
            l2f_g_13 <= 1;
            l2f_g_14 <= 1;
            l2f_g_15 <= 1;
            hs3 <= 0;
            sl2_v <= 0;
            l5_v <= 0;
            sf2_v <= 0;
            fm0 <= 0;
            fx0_x <= 0;
            fx0_es_g_0 <= 0;
            fx0_fn_g_0 <= 0;
            fx0_kc_g_0 <= 0;
            fx0_es_g_1 <= 0;
            fx0_fn_g_1 <= 0;
            fx0_kc_g_1 <= 0;
            fx0_es_g_2 <= 0;
            fx0_fn_g_2 <= 0;
            fx0_kc_g_2 <= 0;
            fx0_es_g_3 <= 0;
            fx0_fn_g_3 <= 0;
            fx0_kc_g_3 <= 0;
            fm1 <= 0;
            fm2 <= 0;
            fm3 <= 0;
            fm4 <= 0;
            fm5 <= 0;
            fm6 <= 0;
            fm7 <= 0;
            fm8 <= 0;
            fm9 <= 0;
            fm10 <= 0;
            fm11 <= 0;
            fq_m0 <= 0;
            fq_e0 <= 0;
            fq_s0 <= 0;
            fq_m1 <= 0;
            fq_e1 <= 0;
            fq_s1 <= 0;
            fq_m2 <= 0;
            fq_e2 <= 0;
            fq_s2 <= 0;
            fo_row_p <= 0;
            fq_we0_p <= 0;
            fq_we1_p <= 0;
            fq_we2_p <= 0;
            fo_row_q <= 0;
            fq_we0 <= 0;
            fq_we1 <= 0;
            fq_we2 <= 0;
            pkh_m <= 0;
            pkh_e <= 0;
            pkh_s <= 0;
            pk_v <= 0;
            pk_dst8 <= 0;
            pk_slot <= 0;
            pk2_v <= 0;
            pk2_dst8 <= 0;
            pk2_slot <= 0;
            pk3_v <= 0;
            pk3_dst8 <= 0;
            pk3_slot <= 0;
            pk4_v <= 0;
            pk4_dst8 <= 0;
            pk4_slot <= 0;
            pk5_v <= 0;
            pk5_dst8 <= 0;
            pk5_slot <= 0;
            l5_e <= 0;
            l5_dst8 <= 0;
            l5_slot <= 0;
            sf2_val <= 0;
            sf2_dst <= 0;
            sf2_slot <= 0;
            r9d_v <= 0;
            r9d_first <= 0;
            r9d_last <= 0;
            r9d_kind <= 0;
            r9d_mode <= 0;
            r9d_acc <= 0;
            r9d_gix <= 0;
            r9d_dst <= 0;
            r9d_slot <= 0;
            r9d_res <= 0;
            racc <= 0;
            raccm <= 0;
            rw_v <= 0;
            gw_v <= 0;
            gw_idx <= 0;
            gw_s <= 0;
            gw_m <= 0;
            gw_k <= 0;
            rg_sh_q <= 0;
            rw_val <= 0;
            rw_valm <= 0;
            rw_kind <= 0;
            rw_dst <= 0;
            rw_slot <= 0;
            sb_v <= 0;
            sb_f_g_0 <= 0;
            sb_f_g_1 <= 0;
            sb_f_g_2 <= 0;
            sb_f_g_3 <= 0;
            sb_f_g_4 <= 0;
            sb_f_g_5 <= 0;
            sb_f_g_6 <= 0;
            sb_f_g_7 <= 0;
            sb_e <= 0;
            sb_dst8 <= 0;
            sb_slot <= 0;
            r0_meta <= 0;
            ift_v_0 <= 0;
            ift_v_1 <= 0;
            ift_v_2 <= 0;
            ift_v_3 <= 0;
            donec <= 0;
            busy_r <= 0;
            ws_v <= 0;
            seqfree <= 0;
            ws_ins <= 0;
            ws_kv <= 0;
            ws_kvb <= 0;
            dq_wp <= 0;
            pa_ins <= 0;
            pa_rp <= 0;
            pa_cfg <= 0;
            pa_lad <= 0;
            pa_nx <= 0;
            pa_step <= 0;
            pa_port <= 0;
            pa_scal <= 0;
            pa_bytes <= 0;
            pa_last <= 0;
            pa_sl <= 0;
            pa_ns <= 0;
            pa_vsh <= 0;
            pa_tl <= 0;
            pa_st <= 0;
            pa_u <= 0;
            pa_ng <= 0;
            pa_s <= 0;
            pa_sp <= 0;
            pa_pl <= 0;
            pa_ph <= 0;
            pr_sl <= 0;
            pr_v <= 0;
            aw_nx <= 0;
            aw_sl <= 0;
            w_act <= 0;
            beat <= 0;
            ra_row_q <= 0;
            ra_e_q <= 0;
            slice_i <= 0;
            cur_nb <= 0;
            cur_wnb <= 0;
            cur_wns <= 0;
            cur_wlb <= 0;
            sq_act <= 0;
            sq_all <= 0;
            sq_slot <= 0;
            sq_l1 <= 0;
            sq_out <= 0;
            dq_rp <= 0;
            cur <= 0;
            vdt_q <= 0;
            exph <= 0;
            fb <= 0;
            rcp_c <= 0;
            rph <= 1;
            cur_slot <= 0;
            nopc <= 0;
            cur_port <= 0;
            cur_ns <= 0;
            cur_nsm1 <= 0;
            cur_rid <= 0;
            cur_c32 <= 0;
            cur_cint <= 0;
            cur_sf <= 0;
            cur_tl <= 0;
            cur_tlm <= 0;
            cur_ra <= 0;
            cur_rb <= 0;
            cur_laddr <= 0;
            ld_step <= 0;
            cur_cfg <= 0;
            badop_r <= 0;
            rcp_sc <= 0;
            rcp_sf <= 0;
            state <= 0;
            cq_rp <= 0;
            v0_ph <= 0;
            v0_src <= 0;
            v0_op <= 0;
            v0_isw <= 0;
            v0_bm_g_0 <= 0;
            v0_b16_g_0 <= 0;
            v0_bm_g_1 <= 0;
            v0_b16_g_1 <= 0;
            v0_bm_g_2 <= 0;
            v0_b16_g_2 <= 0;
            v0_bm_g_3 <= 0;
            v0_b16_g_3 <= 0;
            v0_bm_g_4 <= 0;
            v0_b16_g_4 <= 0;
            v0_bm_g_5 <= 0;
            v0_b16_g_5 <= 0;
            v0_bm_g_6 <= 0;
            v0_b16_g_6 <= 0;
            v0_bm_g_7 <= 0;
            v0_b16_g_7 <= 0;
            v0_c32 <= 0;
            v0_lbase <= 0;
            v0_dst8 <= 0;
            v0_slot <= 0;
            r0_lm <= 0;
            ix_u <= 0;
            ix_ng <= 0;
            ix_s <= 0;
            ix_sp <= 0;
            ix_pl <= 0;
            ix_ph <= 0;
            rx_wsl <= 0;
            rx_wg_q <= 0;
            lbw_beat <= 0;
            lbw_tail <= 0;
            hs2 <= 0;
            ldw_sl <= 0;
            ldw_dst <= 0;
            ldw_slot <= 0;
            ldw_vlm <= 0;
            ldq <= 0;
            ldp <= 0;
            ex_beat <= 0;
            rcp_r <= 0;
            s0_isc <= 0;
            s0_c32 <= 0;
            s0_cint <= 0;
            s0_a32 <= 0;
            s0_b32 <= 0;
            s0_op <= 0;
            s0_dst <= 0;
            s0_slot <= 0;
            ld0 <= 0;
            sl2_val <= 0;
            sl2_i <= 0;
            sl2_ipk <= 0;
            sl2_dst <= 0;
            sl2_slot <= 0;
            tick <= 0;
        end else begin
            if (rb_fire) begin
                rb_v <= 1;
                rb_dat <= rb_in;
            end
            retire_p <= 0;
            wb_p <= 0;
            bt_by_t <= ({2'd0, cur_tl} << vsh);
            pa_by_t <= ({2'd0, pa_tl} << pa_vsh);
            bt_nb_f <= ((({4'd0, cur_laddr[5:0]} + (10'd64 << vsh)) + 10'd63) >> 6);
            bt_nb_t <= ((({4'd0, cur_laddr[5:0]} + ({3'd0, cur_tl} << vsh)) + 10'd63) >> 6);
            bt_wnb_f <= (((11'd64 << vsh) + 11'd63) >> 6);
            bt_wnb_t <= ((({4'd0, cur_tl} << vsh) + 11'd63) >> 6);
            bt_wlb_f <= ((((10'd64 << vsh) & 10'd63) == 0) ? 8'd64 : ((10'd64 << vsh) & 10'd63));
            bt_wlb_t <= (((({3'd0, cur_tl} << vsh) & 10'd63) == 0) ? 8'd64 : (({3'd0, cur_tl} << vsh) & 10'd63));
            vlm_q <= vlm;
            sla6 <= cur_laddr[5:0];
            ex_v <= 0;
            ld_hs_pre <= 0;
            lbw_v <= 0;
            rr_q <= rr_run;
            if (lbw_ce) begin
                lbw <= lb_dat;
            end
            lbw_ce <= lbw_tl_n;
            lbq_v <= lbw_v;
            lbq_beat <= lbw_beat;
            lbq_tail <= lbw_tail;
            lbq_s0 <= lbx_s_0;
            lbq_e0 <= lbx_e_0;
            lbq_m0 <= lbx_m_0;
            lbq_s1 <= lbx_s_1;
            lbq_e1 <= lbx_e_1;
            lbq_m1 <= lbx_m_1;
            lbq_s2 <= lbx_s_2;
            lbq_e2 <= lbx_e_2;
            lbq_m2 <= lbx_m_2;
            lbq_s3 <= lbx_s_3;
            lbq_e3 <= lbx_e_3;
            lbq_m3 <= lbx_m_3;
            if (lx_en_0) begin
                lxs0 <= lxq_s_0;
                lxe0 <= lxq_e_0;
                lxm0 <= lxq_m_0;
            end
            if (lx_en_1) begin
                lxs1 <= lxq_s_1;
                lxe1 <= lxq_e_1;
                lxm1 <= lxq_m_1;
            end
            if (lx_en_2) begin
                lxs2 <= lxq_s_2;
                lxe2 <= lxq_e_2;
                lxm2 <= lxq_m_2;
            end
            if (lx_en_3) begin
                lxs3 <= lxq_s_3;
                lxe3 <= lxq_e_3;
                lxm3 <= lxq_m_3;
            end
            lx_en_0 <= ((nx_hs3 & tl0) | (nx_lbq & lxw_c_0));
            lx_src_0 <= (nx_hs3 ? bysrc_0 : lxsrc_c_0);
            lx_en_1 <= ((nx_hs3 & tl1) | (nx_lbq & lxw_c_1));
            lx_src_1 <= (nx_hs3 ? bysrc_1 : lxsrc_c_1);
            lx_en_2 <= ((nx_hs3 & tl2) | (nx_lbq & lxw_c_2));
            lx_src_2 <= (nx_hs3 ? bysrc_2 : lxsrc_c_2);
            lx_en_3 <= ((nx_hs3 & tl3) | (nx_lbq & lxw_c_3));
            lx_src_3 <= (nx_hs3 ? bysrc_3 : lxsrc_c_3);
            if (ldw_go) begin
                lgs_q <= {lgs3, lgs2, lgs1, lgs0};
                lgm_q <= {lgm3, lgm2, lgm1, lgm0};
                lge_q <= {lge3, lge2, lge1, lge0};
            end
            ldw_go_q <= ldw_go;
            if (ld_hs_pre) begin
                ld_hs <= 1;
            end
            xq_v <= oq_take;
            if (oq_take) begin
                xq_s <= is_smem;
                xq_pk <= u_sta_pk;
                xq_e_g_0 <= st_seg_c;
                xq_e_g_1 <= st_seg_c;
                xq_e_g_2 <= st_seg_c;
                xq_e_g_3 <= st_seg_c;
                xq_e_g_4 <= st_seg_c;
                xq_e_g_5 <= st_seg_c;
                xq_e_g_6 <= st_seg_c;
                xq_e_g_7 <= st_seg_c;
                xq_32 <= (vdt == 1);
                li_q <= li_nx;
                li_f <= 0;
                xq_sv <= sst_v;
                xq_la <= sla6;
                xq_stb <= wstrb_al;
                xq_l1 <= use_l1;
            end
            if (xq_v) begin
                if ((wq_wp == 0)) begin
                    wq_d_0 <= wbeat_al;
                    wq_s_0 <= xq_stb;
                    wq_l_0 <= xq_l1;
                end
                if ((wq_wp == 1)) begin
                    wq_d_1 <= wbeat_al;
                    wq_s_1 <= xq_stb;
                    wq_l_1 <= xq_l1;
                end
                if ((wq_wp == 2)) begin
                    wq_d_2 <= wbeat_al;
                    wq_s_2 <= xq_stb;
                    wq_l_2 <= xq_l1;
                end
                wq_wp <= ((wq_wp == 2) ? 2'd0 : (wq_wp + 1));
            end
            if (oq_acc) begin
                wq_rp <= ((wq_rp == 2) ? 2'd0 : (wq_rp + 1));
            end
            wq_n <= wq_nn;
            wq_vl <= ((wq_nn != 0) & wq_hln);
            wq_vn <= ((wq_nn != 0) & (~wq_hln));
            if (rd_en) begin
                ra0 <= gA0[rd_addr_a];
                ra1 <= gA1[rd_addr_a];
                ra2 <= gA2[rd_addr_a];
                ra3 <= gA3[rd_addr_a];
                ra4 <= gA4[rd_addr_a];
                ra5 <= gA5[rd_addr_a];
                ra6 <= gA6[rd_addr_a];
                ra7 <= gA7[rd_addr_a];
                rb0 <= gB0[rd_addr_b];
                rb1 <= gB1[rd_addr_b];
                rb2 <= gB2[rd_addr_b];
                rb3 <= gB3[rd_addr_b];
                rb4 <= gB4[rd_addr_b];
                rb5 <= gB5[rd_addr_b];
                rb6 <= gB6[rd_addr_b];
                rb7 <= gB7[rd_addr_b];
                ra_e <= ae_c;
                d1_ea <= ae_c;
                d1_eb <= eb_c;
                d1_op <= op_c;
                d1_isw <= isw_c;
                d1_evt <= vt2s_e;
                d1_vt <= vt2s_f;
            end
            oha_g_0 <= oha_c;
            ohb_g_0 <= ohb_c;
            oha_g_1 <= oha_c;
            ohb_g_1 <= ohb_c;
            oha_g_2 <= oha_c;
            ohb_g_2 <= ohb_c;
            oha_g_3 <= oha_c;
            ohb_g_3 <= ohb_c;
            oha_g_4 <= oha_c;
            ohb_g_4 <= ohb_c;
            oha_g_5 <= oha_c;
            ohb_g_5 <= ohb_c;
            oha_g_6 <= oha_c;
            ohb_g_6 <= ohb_c;
            oha_g_7 <= oha_c;
            ohb_g_7 <= ohb_c;
            d_eo <= u_segx_eo;
            d_voh_g_0 <= voh_c;
            d_vt_g_0 <= d1_vt;
            d_voh_g_1 <= voh_c;
            d_vt_g_1 <= d1_vt;
            d_voh_g_2 <= voh_c;
            d_vt_g_2 <= d1_vt;
            d_voh_g_3 <= voh_c;
            d_vt_g_3 <= d1_vt;
            d_voh_g_4 <= voh_c;
            d_vt_g_4 <= d1_vt;
            d_voh_g_5 <= voh_c;
            d_vt_g_5 <= d1_vt;
            d_voh_g_6 <= voh_c;
            d_vt_g_6 <= d1_vt;
            d_voh_g_7 <= voh_c;
            d_vt_g_7 <= d1_vt;
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
            if (u_kw_im_req) begin
                rd_q <= {im3[rd_a], im2[rd_a], im1[rd_a], im0[rd_a]};
            end
            if (lq_push) begin
                lq_id[lq_wp[2:0]] <= issue_launch_id;
                lq_off[lq_wp[2:0]] <= issue_launch_off;
                lq_len[lq_wp[2:0]] <= issue_launch_len;
                lq_wp <= ((lq_wp == 7) ? 4'd0 : (lq_wp + 1));
            end
            if (lc_go) begin
                lq_rp <= ((lq_rp == 7) ? 4'd0 : (lq_rp + 1));
            end
            lq_n <= ((lq_n + {3'd0, lq_push}) - {3'd0, lc_go});
            if (((issue_valid & (~issue_is_launch)) & (cq_n < 8))) begin
                cq_i[cq_wp[2:0]] <= issue_instr;
                cq_wp <= (cq_wp + 1);
            end
            if ((ar_pend & ((cur_port ? l1_ar_ready : noc_ar_ready) & cred_ok))) begin
                ar_nx <= (ar_nx + {39'd0, ld_step});
                ar_sl <= (ar_sl + 1);
            end
            if ((f_l1 & (~l1_a_valid))) begin
                cred_l1 <= (cred_l1 - 1);
            end else begin
                if ((l1_a_valid & (~f_l1))) begin
                    cred_l1 <= (cred_l1 + 1);
                end
            end
            if ((f_nc & (~noc_a_valid))) begin
                cred_llc <= (cred_llc - 1);
            end else begin
                if ((noc_a_valid & (~f_nc))) begin
                    cred_llc <= (cred_llc + 1);
                end
            end
            wp_v <= g_wen;
            wp_addr <= g_waddr;
            wp_row <= g_wdata;
            wp_e <= g_we;
            wp_slot <= g_wslot;
            if (wp_v) begin
                wb_p <= 1;
                ift_wb[wp_slot] <= (ift_wb[wp_slot] - 1);
                gA0[wp_addr] <= wp_row[127:0];
                gB0[wp_addr] <= wp_row[127:0];
                gA1[wp_addr] <= wp_row[255:128];
                gB1[wp_addr] <= wp_row[255:128];
                gA2[wp_addr] <= wp_row[383:256];
                gB2[wp_addr] <= wp_row[383:256];
                gA3[wp_addr] <= wp_row[511:384];
                gB3[wp_addr] <= wp_row[511:384];
                gA4[wp_addr] <= wp_row[639:512];
                gB4[wp_addr] <= wp_row[639:512];
                gA5[wp_addr] <= wp_row[767:640];
                gB5[wp_addr] <= wp_row[767:640];
                gA6[wp_addr] <= wp_row[895:768];
                gB6[wp_addr] <= wp_row[895:768];
                gA7[wp_addr] <= wp_row[1023:896];
                gB7[wp_addr] <= wp_row[1023:896];
                gAE[wp_addr] <= wp_e;
                gBE[wp_addr] <= wp_e;
            end
            if (s_wen) begin
                wb_p <= 1;
                sr[s_wdst] <= s_wval;
                ift_wb[s_wslot] <= (ift_wb[s_wslot] - 1);
            end
            v1_v <= v0_v;
            v1_ph <= v0_ph;
            v1_op_g_0 <= v0_op;
            v1_isw_g_0 <= v0_isw;
            v1_op_g_1 <= v0_op;
            v1_isw_g_1 <= v0_isw;
            v1_op_g_2 <= v0_op;
            v1_isw_g_2 <= v0_isw;
            v1_op_g_3 <= v0_op;
            v1_isw_g_3 <= v0_isw;
            v1_op_g_4 <= v0_op;
            v1_isw_g_4 <= v0_isw;
            v1_op_g_5 <= v0_op;
            v1_isw_g_5 <= v0_isw;
            v1_op_g_6 <= v0_op;
            v1_isw_g_6 <= v0_isw;
            v1_op_g_7 <= v0_op;
            v1_isw_g_7 <= v0_isw;
            v1_src <= v0_src;
            v1_c32 <= v0_c32;
            v1_lbase <= v0_lbase;
            v1_dst8 <= v0_dst8;
            v1_slot <= v0_slot;
            v2_v <= v1_v;
            v2_ph <= v1_ph;
            v2_src <= v1_src;
            v2_c32 <= v1_c32;
            v2_lbase <= v1_lbase;
            v2_dst8 <= v1_dst8;
            v2_slot <= v1_slot;
            v3_v <= v2_v;
            v3_ph <= v2_ph;
            v3_src <= v2_src;
            v3_c32 <= v2_c32;
            v3_lbase <= v2_lbase;
            v3_dst8 <= v2_dst8;
            v3_slot <= v2_slot;
            v4_v <= v3_v;
            v4_ph <= v3_ph;
            v4_src <= v3_src;
            v4_lbase <= v3_lbase;
            v4_cf <= u_c2s_f;
            v4_ce <= u_c2s_e;
            v4_dst8 <= v3_dst8;
            v4_slot <= v3_slot;
            v5_v <= v4_v;
            v5_ph <= v4_ph;
            v5_src <= v4_src;
            v5_cf_g_0 <= v4_cf;
            v5_cf_g_1 <= v4_cf;
            v5_cf_g_2 <= v4_cf;
            v5_cf_g_3 <= v4_cf;
            v5_cf_g_4 <= v4_cf;
            v5_cf_g_5 <= v4_cf;
            v5_cf_g_6 <= v4_cf;
            v5_cf_g_7 <= v4_cf;
            v5_ce <= v4_ce;
            v5_dst8 <= v4_dst8;
            v5_slot <= v4_slot;
            w_v <= (v5_v & v5_ph);
            w_src <= v5_src;
            w_cf_g_0 <= v5_cf_g_0;
            w_cf_g_1 <= v5_cf_g_1;
            w_cf_g_2 <= v5_cf_g_2;
            w_cf_g_3 <= v5_cf_g_3;
            w_cf_g_4 <= v5_cf_g_4;
            w_cf_g_5 <= v5_cf_g_5;
            w_cf_g_6 <= v5_cf_g_6;
            w_cf_g_7 <= v5_cf_g_7;
            w_e <= exd_e;
            w_dst8 <= v5_dst8;
            w_slot <= v5_slot;
            v0_v <= 0;
            s1_v <= s0_v;
            s1_isc <= s0_isc;
            s1_c32 <= s0_c32;
            s1_cint <= s0_cint;
            s1_cpk <= u_s0c_pk;
            s1_dst <= s0_dst;
            s1_slot <= s0_slot;
            s2_v <= s1_v;
            s2_val <= s1_val;
            s2_dst <= s1_dst;
            s2_slot <= s1_slot;
            s0_v <= 0;
            if (g_l2) begin
                l2_v <= 0;
            end
            ldw_go <= 0;
            if (ldw_busy) begin
                if ((ldw_st != 6)) begin
                    ldw_st <= (ldw_st + 1);
                end else begin
                    if (l2_free) begin
                        ldw_st <= 0;
                        ldw_busy <= 0;
                        l2_v <= 1;
                        l2_e <= u_lpk_e;
                        l2_dst8 <= {ldw_dst, ldw_sl};
                        l2_slot <= ldw_slot;
                    end
                end
            end
            if (l2f_g_0) begin
                l2_row[63:0] <= u_lpk_f[63:0];
            end
            if (l2f_g_1) begin
                l2_row[127:64] <= u_lpk_f[127:64];
            end
            if (l2f_g_2) begin
                l2_row[191:128] <= u_lpk_f[191:128];
            end
            if (l2f_g_3) begin
                l2_row[255:192] <= u_lpk_f[255:192];
            end
            if (l2f_g_4) begin
                l2_row[319:256] <= u_lpk_f[319:256];
            end
            if (l2f_g_5) begin
                l2_row[383:320] <= u_lpk_f[383:320];
            end
            if (l2f_g_6) begin
                l2_row[447:384] <= u_lpk_f[447:384];
            end
            if (l2f_g_7) begin
                l2_row[511:448] <= u_lpk_f[511:448];
            end
            if (l2f_g_8) begin
                l2_row[575:512] <= u_lpk_f[575:512];
            end
            if (l2f_g_9) begin
                l2_row[639:576] <= u_lpk_f[639:576];
            end
            if (l2f_g_10) begin
                l2_row[703:640] <= u_lpk_f[703:640];
            end
            if (l2f_g_11) begin
                l2_row[767:704] <= u_lpk_f[767:704];
            end
            if (l2f_g_12) begin
                l2_row[831:768] <= u_lpk_f[831:768];
            end
            if (l2f_g_13) begin
                l2_row[895:832] <= u_lpk_f[895:832];
            end
            if (l2f_g_14) begin
                l2_row[959:896] <= u_lpk_f[959:896];
            end
            if (l2f_g_15) begin
                l2_row[1023:960] <= u_lpk_f[1023:960];
            end
            l2f_g_0 <= ((~l2v_n) | (~cmp_n));
            l2f_g_1 <= ((~l2v_n) | (~cmp_n));
            l2f_g_2 <= ((~l2v_n) | (~cmp_n));
            l2f_g_3 <= ((~l2v_n) | (~cmp_n));
            l2f_g_4 <= ((~l2v_n) | (~cmp_n));
            l2f_g_5 <= ((~l2v_n) | (~cmp_n));
            l2f_g_6 <= ((~l2v_n) | (~cmp_n));
            l2f_g_7 <= ((~l2v_n) | (~cmp_n));
            l2f_g_8 <= ((~l2v_n) | (~cmp_n));
            l2f_g_9 <= ((~l2v_n) | (~cmp_n));
            l2f_g_10 <= ((~l2v_n) | (~cmp_n));
            l2f_g_11 <= ((~l2v_n) | (~cmp_n));
            l2f_g_12 <= ((~l2v_n) | (~cmp_n));
            l2f_g_13 <= ((~l2v_n) | (~cmp_n));
            l2f_g_14 <= ((~l2v_n) | (~cmp_n));
            l2f_g_15 <= ((~l2v_n) | (~cmp_n));
            if (hs3) begin
                hs3 <= 0;
                ldw_go <= 1;
            end
            if (g_sl2) begin
                sl2_v <= 0;
            end
            if (g_l5) begin
                l5_v <= 0;
            end
            if (g_sf2) begin
                sf2_v <= 0;
            end
            if (fen) begin
                fm0 <= fm_in;
            end else begin
                fm0 <= 0;
            end
            fx0_x <= func_x;
            fx0_es_g_0 <= func_es;
            fx0_fn_g_0 <= func_sel;
            fx0_kc_g_0 <= func_kc_c;
            fx0_es_g_1 <= func_es;
            fx0_fn_g_1 <= func_sel;
            fx0_kc_g_1 <= func_kc_c;
            fx0_es_g_2 <= func_es;
            fx0_fn_g_2 <= func_sel;
            fx0_kc_g_2 <= func_kc_c;
            fx0_es_g_3 <= func_es;
            fx0_fn_g_3 <= func_sel;
            fx0_kc_g_3 <= func_kc_c;
            fm1 <= fm0;
            fm2 <= fm1;
            fm3 <= fm2;
            fm4 <= fm3;
            fm5 <= fm4;
            fm6 <= fm5;
            fm7 <= fm6;
            fm8 <= fm7;
            fm9 <= fm8;
            fm10 <= fm9;
            fm11 <= fm10;
            if (fq_we0) begin
                fq_m0 <= u_func_m;
                fq_e0 <= u_func_ed;
                fq_s0 <= u_func_sgn;
            end
            if (fq_we1) begin
                fq_m1 <= u_func_m;
                fq_e1 <= u_func_ed;
                fq_s1 <= u_func_sgn;
            end
            if (fq_we2) begin
                fq_m2 <= u_func_m;
                fq_e2 <= u_func_ed;
                fq_s2 <= u_func_sgn;
            end
            fo_row_p <= ((fm9[0] & (~fm9[1])) & (fm9[3:2] == 3));
            fq_we0_p <= ((fm9[0] & (~fm9[1])) & (fm9[3:2] == 0));
            fq_we1_p <= ((fm9[0] & (~fm9[1])) & (fm9[3:2] == 1));
            fq_we2_p <= ((fm9[0] & (~fm9[1])) & (fm9[3:2] == 2));
            fo_row_q <= fo_row_p;
            fq_we0 <= fq_we0_p;
            fq_we1 <= fq_we1_p;
            fq_we2 <= fq_we2_p;
            if (fo_row) begin
                pkh_m <= frow_m;
                pkh_e <= frow_ed;
                pkh_s <= frow_s;
            end
            pk_v <= fo_row;
            pk_dst8 <= fo_dst;
            pk_slot <= fo_slot;
            pk2_v <= pk_v;
            pk2_dst8 <= pk_dst8;
            pk2_slot <= pk_slot;
            pk3_v <= pk2_v;
            pk3_dst8 <= pk2_dst8;
            pk3_slot <= pk2_slot;
            pk4_v <= pk3_v;
            pk4_dst8 <= pk3_dst8;
            pk4_slot <= pk3_slot;
            pk5_v <= pk4_v;
            pk5_dst8 <= pk4_dst8;
            pk5_slot <= pk4_slot;
            l5_e <= u_pk_e;
            if (pk5_v) begin
                l5_v <= 1;
                l5_dst8 <= pk5_dst8;
                l5_slot <= pk5_slot;
            end
            if ((fo_v & fo_sc)) begin
                sf2_v <= 1;
                sf2_val <= u_sf32_res;
                sf2_dst <= fo_dst[3:0];
                sf2_slot <= fo_slot;
            end
            r9d_v <= r9_v;
            r9d_first <= r9_first;
            r9d_last <= r9_last;
            r9d_kind <= r9_kind;
            r9d_mode <= r9_mode;
            r9d_acc <= r9_acc;
            r9d_gix <= rx_gix;
            r9d_dst <= r9_dst;
            r9d_slot <= r9_slot;
            r9d_res <= red_res;
            if ((r9d_v & r9d_acc)) begin
                racc <= racc_n;
                raccm <= raccm_n;
            end
            if (g_rw) begin
                rw_v <= 0;
            end
            gw_v <= (((r9d_v & r9d_last) & r9d_mode) & r9d_acc);
            gw_idx <= r9d_gix;
            gw_s <= racc_n;
            gw_m <= raccm_n;
            gw_k <= (r9d_kind == 2'd0);
            if (gw_v) begin
                gres[gw_idx] <= {u_g2s_e, u_g2s_f};
            end
            rg_sh_q <= rg_sh;
            if (((r9d_v & r9d_last) & (~r9d_mode))) begin
                rw_v <= 1;
                rw_val <= racc_n;
                rw_valm <= raccm_n;
                rw_kind <= r9d_kind;
                rw_dst <= r9d_dst;
                rw_slot <= r9d_slot;
            end
            if (g_sb) begin
                sb_v <= 0;
            end
            if (bo_v) begin
                sb_v <= 1;
                sb_f_g_0 <= u_red_bf[15:0];
                sb_f_g_1 <= u_red_bf[15:0];
                sb_f_g_2 <= u_red_bf[15:0];
                sb_f_g_3 <= u_red_bf[15:0];
                sb_f_g_4 <= u_red_bf[15:0];
                sb_f_g_5 <= u_red_bf[15:0];
                sb_f_g_6 <= u_red_bf[15:0];
                sb_f_g_7 <= u_red_bf[15:0];
                sb_e <= u_red_be;
                sb_dst8 <= bo_dst;
                sb_slot <= bo_slot;
            end
            r0_meta <= 0;
            if (rt_rdy) begin
                if ((rt_idx == 0)) begin
                    ift_v_0 <= 0;
                end
                if ((rt_idx == 1)) begin
                    ift_v_1 <= 0;
                end
                if ((rt_idx == 2)) begin
                    ift_v_2 <= 0;
                end
                if ((rt_idx == 3)) begin
                    ift_v_3 <= 0;
                end
                donec <= (donec + 1);
                retire_p <= 1;
            end
            busy_r <= ((((((state != S_IDLE) | kern_act) | (nfl_w != 0)) | ld_v) | (~dq_empty)) | ws_v);
            ws_v <= kw_take;
            if (kw_take) begin
                seqfree <= (tick + 1);
                ws_ins <= w_ins;
                ws_kv <= u_kw_rda_val;
                ws_kvb <= u_kw_rdb_val;
            end
            if ((ws_v & (~dq_byp))) begin
                dq_ins[dq_wi] <= ws_ins;
                dq_lad[dq_wi] <= kw_lad;
                dq_cfg[dq_wi] <= kv_cid;
                dq_c32[dq_wi] <= kvb;
                dq_pd[dq_wi] <= ws_pd;
                dq_wp <= (dq_wp + 1);
            end
            if (pa_cvt) begin
                pa_ins <= dqh_ins;
                pa_rp <= dq_rp;
                pa_cfg <= dqh_cfg;
                pa_lad <= dqh_lad;
                pa_nx <= dqh_lad;
                pa_step <= (9'd64 << pah_vsh);
                pa_by_t <= ({2'd0, pah_tl} << pah_vsh);
                pa_port <= pah_l1;
                pa_scal <= pah_scal;
                pa_bytes <= pah_by;
                pa_last <= pah_last;
                pa_sl <= 0;
                pa_ns <= pah_ns;
                pa_vsh <= pah_vsh;
                pa_tl <= pah_tl;
                if (pah_idx) begin
                    pa_st <= 4;
                end else begin
                    pa_st <= 2;
                end
            end
            if (pa_cv2) begin
                pa_u <= u_ix_u[29:0];
                pa_ng <= u_ix_ng;
                pa_s <= pa_s_c;
                pa_sp <= (u_ix_ng ? pa_sn_c : {1'd0, pa_s_c});
                pa_st <= 5;
            end
            if (pa_mul) begin
                pa_pl <= u_pal_p;
                pa_ph <= u_pah_p;
                pa_st <= 1;
            end
            if (pa_add) begin
                pa_lad <= pa_sum;
                pa_nx <= pa_sum;
                pa_st <= 2;
            end
            if ((pa_req & ar_fire)) begin
                pa_nx <= pa_nx1;
                pa_st <= 3;
                pa_sl <= (pa_sl + 1);
            end
            if (pr_go) begin
                pr_sl <= (pr_sl + 1);
                pr_v <= 1;
            end
            if ((aw_pend & st_aw_fire)) begin
                aw_nx <= (aw_nx + {39'd0, ld_step});
                aw_sl <= (aw_sl + 1);
            end
            if (st_wdone) begin
                w_act <= 0;
            end else begin
                if (oq_take) begin
                    beat <= (beat + 1);
                end
            end
            if (w_start) begin
                ra_row_q <= ra_row;
                ra_e_q <= ra_e;
                li_f <= 1;
                slice_i <= hs_sl;
                cur_nb <= ((pr_sl_m1 == cur_nsm1) ? bt_nb_t : bt_nb_f);
                cur_wnb <= ((pr_sl_m1 == cur_nsm1) ? bt_wnb_t : bt_wnb_f);
                cur_wns <= ((pr_sl_m1 == cur_nsm1) ? bt_wnb_t : bt_wnb_f);
                cur_wlb <= ((pr_sl_m1 == cur_nsm1) ? bt_wlb_t : bt_wlb_f);
                beat <= 0;
                w_act <= 1;
                pr_v <= 0;
            end
            if (st_aw_fire) begin
                if ((~sq_act)) begin
                    sq_act <= 1;
                    sq_all <= 0;
                    sq_slot <= cur_slot;
                    sq_l1 <= use_l1;
                end
            end
            if (st_fin) begin
                sq_all <= 1;
            end
            sq_out <= ((sq_out + {5'd0, st_aw_fire}) - {5'd0, sq_bv});
            if (((sq_act & sq_all) & (sq_out == 0))) begin
                ift_mdone[sq_slot] <= 1;
                sq_act <= 0;
            end
            case (state)
                0: begin
                    if (dq_pop) begin
                        dq_rp <= (dq_rp + 1);
                        cur <= dqh_ins;
                        vdt_q <= ((dqh_ins[4:0] == 23) ? dqh_ins[84:82] : dqh_ins[62:60]);
                        slice_i <= 0;
                        exph <= 0;
                        ld_hs <= 0;
                        beat <= 0;
                        fb <= 0;
                        rcp_c <= 0;
                        rph <= 1;
                        cur_slot <= fs_idx;
                        nopc <= dqh_ins[21:6];
                        if ((fs_idx == 0)) begin
                            ift_v_0 <= 1;
                        end
                        if ((fs_idx == 1)) begin
                            ift_v_1 <= 1;
                        end
                        if ((fs_idx == 2)) begin
                            ift_v_2 <= 1;
                        end
                        if ((fs_idx == 3)) begin
                            ift_v_3 <= 1;
                        end
                        ift_mdone[fs_idx] <= 0;
                        ift_mem[fs_idx] <= dqh_pd[12];
                        cur_port <= ((((dqh_ins[4:0] == 9) | (dqh_ins[4:0] == 10)) | (dqh_ins[4:0] == 24))
                                     ? (dqh_ins[10:9] == 0) :
                                    (dqh_ins[11:10] == 0));
                        cur_ns <= dqh_pd[17:13];
                        cur_nsm1 <= dqh_pd[22:18];
                        cur_rid <= ((dqh_ins[16:15] == 1) ? 16'd32768 : ((dqh_ins[16:15] == 2) ? 16'd32767 : 16'd0));
                        cur_c32 <= (((dqh_ins[4:0] == 8) & dqh_ins[9]) ? dqh_c32 : dqh_ins[41:10]);
                        cur_cint <= ((dqh_ins[4:0] == 8) & dqh_ins[9]);
                        cur_sf <= (dqh_ins[4:0] == 12);
                        cur_tl <= dqh_pd[29:23];
                        cur_tlm <= dqh_tlm;
                        cur_ra <= (((dqh_ins[4:0] == 1) | (dqh_ins[4:0] == 2)) ? dqh_ins[8:5] : dqh_ins[13:10]);
                        cur_rb <= ((dqh_ins[4:0] == 7) ? dqh_ins[51:48] : dqh_ins[24:21]);
                        cur_laddr <= dqh_lad;
                        ar_nx <= dqh_lad;
                        aw_nx <= dqh_lad;
                        ld_step <= dqh_pd[70:62];
                        bt_by_t <= dqh_pd[61:53];
                        cur_cfg <= dqh_cfg;
                        ift_wb[fs_idx] <= dqh_pd[11:7];
                        if (dqh_pd[1]) begin
                            cur_nb <= dqh_pd[41:39];
                            cur_wnb <= dqh_pd[44:42];
                            cur_wns <= dqh_pd[44:42];
                            cur_wlb <= dqh_pd[52:45];
                            ar_sl <= 0;
                            aw_sl <= 0;
                            pr_sl <= 0;
                            pr_v <= 0;
                            w_act <= 0;
                        end
                        if ((~dqh_pd[0])) begin
                            badop_r <= 1;
                        end
                        rcp_sc <= ((dqh_ins[4:0] == 11) & (dqh_ins[16:13] == 3));
                        rcp_sf <= ((dqh_ins[4:0] == 12) & (dqh_ins[15:13] == 5));
                        state <= dqh_pd[6:2];
                        rr_q <= (((dqh_pd[6:2] == 6) & (~rb_v)) & (~hs2));
                        pa_st <= 0;
                        if (pa_hit_d) begin
                            cur_laddr <= pa_lad;
                            ar_nx <= (pa_fire_d ? pa_nx1 : pa_nx);
                            cur_nb <= pa_nb;
                            cur_wnb <= dqh_pd[44:42];
                            cur_wns <= dqh_pd[44:42];
                            cur_wlb <= dqh_pd[52:45];
                            ar_sl <= pa_cnt_d;
                            aw_sl <= 0;
                            pr_sl <= 0;
                            pr_v <= 0;
                            w_act <= 0;
                            state <= (pah_scal ? S_SLDRD : S_LDRD);
                            rr_q <= ((~rb_v) & (pah_scal | (~hs2)));
                        end
                    end else begin
                        if (dq_byp) begin
                            cur <= ws_ins;
                            vdt_q <= ((ws_ins[4:0] == 23) ? ws_ins[84:82] : ws_ins[62:60]);
                            slice_i <= 0;
                            exph <= 0;
                            ld_hs <= 0;
                            beat <= 0;
                            fb <= 0;
                            rcp_c <= 0;
                            rph <= 1;
                            cur_slot <= fs_idx;
                            nopc <= ws_ins[21:6];
                            if ((fs_idx == 0)) begin
                                ift_v_0 <= 1;
                            end
                            if ((fs_idx == 1)) begin
                                ift_v_1 <= 1;
                            end
                            if ((fs_idx == 2)) begin
                                ift_v_2 <= 1;
                            end
                            if ((fs_idx == 3)) begin
                                ift_v_3 <= 1;
                            end
                            ift_mdone[fs_idx] <= 0;
                            ift_mem[fs_idx] <= ws_pd[12];
                            cur_port <= ((((ws_ins[4:0] == 9) | (ws_ins[4:0] == 10)) | (ws_ins[4:0] == 24))
                                         ? (ws_ins[10:9] == 0) :
                                        (ws_ins[11:10] == 0));
                            cur_ns <= ws_pd[17:13];
                            cur_nsm1 <= ws_pd[22:18];
                            cur_rid <= ((ws_ins[16:15] == 1) ? 16'd32768 : ((ws_ins[16:15] == 2) ? 16'd32767 : 16'd0));
                            cur_c32 <= (((ws_ins[4:0] == 8) & ws_ins[9]) ? kvb : ws_ins[41:10]);
                            cur_cint <= ((ws_ins[4:0] == 8) & ws_ins[9]);
                            cur_sf <= (ws_ins[4:0] == 12);
                            cur_tl <= ws_pd[29:23];
                            cur_tlm <= ws_tlm;
                            cur_ra <= (((ws_ins[4:0] == 1) | (ws_ins[4:0] == 2)) ? ws_ins[8:5] : ws_ins[13:10]);
                            cur_rb <= ((ws_ins[4:0] == 7) ? ws_ins[51:48] : ws_ins[24:21]);
                            cur_laddr <= kw_lad;
                            ar_nx <= kw_lad;
                            aw_nx <= kw_lad;
                            ld_step <= ws_pd[70:62];
                            bt_by_t <= ws_pd[61:53];
                            cur_cfg <= kv_cid;
                            ift_wb[fs_idx] <= ws_pd[11:7];
                            if (ws_pd[1]) begin
                                cur_nb <= ws_pd[41:39];
                                cur_wnb <= ws_pd[44:42];
                                cur_wns <= ws_pd[44:42];
                                cur_wlb <= ws_pd[52:45];
                                ar_sl <= 0;
                                aw_sl <= 0;
                                pr_sl <= 0;
                                pr_v <= 0;
                                w_act <= 0;
                            end
                            if ((~ws_pd[0])) begin
                                badop_r <= 1;
                            end
                            rcp_sc <= ((ws_ins[4:0] == 11) & (ws_ins[16:13] == 3));
                            rcp_sf <= ((ws_ins[4:0] == 12) & (ws_ins[15:13] == 5));
                            state <= ws_pd[6:2];
                            rr_q <= (((ws_pd[6:2] == 6) & (~rb_v)) & (~hs2));
                        end else begin
                            if (((((cq_n != 0) & (nfl_w < 4)) & ld_wb_ok) & (~ws_v))) begin
                                cq_rp <= (cq_rp + 1);
                                cur <= cq_w;
                                vdt_q <= ((cq_w[4:0] == 23) ? cq_w[84:82] : cq_w[62:60]);
                                slice_i <= 0;
                                exph <= 0;
                                ld_hs <= 0;
                                beat <= 0;
                                fb <= 0;
                                rcp_c <= 0;
                                rph <= 1;
                                cur_slot <= fs_idx;
                                nopc <= cq_w[21:6];
                                if ((fs_idx == 0)) begin
                                    ift_v_0 <= 1;
                                end
                                if ((fs_idx == 1)) begin
                                    ift_v_1 <= 1;
                                end
                                if ((fs_idx == 2)) begin
                                    ift_v_2 <= 1;
                                end
                                if ((fs_idx == 3)) begin
                                    ift_v_3 <= 1;
                                end
                                ift_mdone[fs_idx] <= 0;
                                ift_mem[fs_idx] <= cq_pd[12];
                                cur_port <= ((((cq_w[4:0] == 9) | (cq_w[4:0] == 10)) | (cq_w[4:0] == 24))
                                             ? (cq_w[10:9] == 0) :
                                            (cq_w[11:10] == 0));
                                cur_ns <= cq_pd[17:13];
                                cur_nsm1 <= cq_pd[22:18];
                                cur_rid <= ((cq_w[16:15] == 1) ? 16'd32768 : ((cq_w[16:15] == 2) ? 16'd32767 : 16'd0));
                                cur_c32 <= (((cq_w[4:0] == 8) & cq_w[9]) ? kvb : cq_w[41:10]);
                                cur_cint <= ((cq_w[4:0] == 8) & cq_w[9]);
                                cur_sf <= (cq_w[4:0] == 12);
                                cur_tl <= cq_pd[29:23];
                                cur_tlm <= cq_tlm;
                                cur_ra <= (((cq_w[4:0] == 1) | (cq_w[4:0] == 2)) ? cq_w[8:5] : cq_w[13:10]);
                                cur_rb <= ((cq_w[4:0] == 7) ? cq_w[51:48] : cq_w[24:21]);
                                cur_laddr <= cq_lad;
                                ar_nx <= cq_lad;
                                aw_nx <= cq_lad;
                                ld_step <= cq_pd[70:62];
                                bt_by_t <= cq_pd[61:53];
                                cur_cfg <= cq_cfg;
                                ift_wb[fs_idx] <= cq_pd[11:7];
                                if (cq_pd[1]) begin
                                    cur_nb <= cq_pd[41:39];
                                    cur_wnb <= cq_pd[44:42];
                                    cur_wns <= cq_pd[44:42];
                                    cur_wlb <= cq_pd[52:45];
                                    ar_sl <= 0;
                                    aw_sl <= 0;
                                    pr_sl <= 0;
                                    pr_v <= 0;
                                    w_act <= 0;
                                end
                                if ((~cq_pd[0])) begin
                                    badop_r <= 1;
                                end
                                rcp_sc <= ((cq_w[4:0] == 11) & (cq_w[16:13] == 3));
                                rcp_sf <= ((cq_w[4:0] == 12) & (cq_w[15:13] == 5));
                                state <= cq_pd[6:2];
                                rr_q <= (((cq_pd[6:2] == 6) & (~rb_v)) & (~hs2));
                            end
                        end
                    end
                end
                1: begin
                    v0_v <= 1;
                    v0_ph <= exph;
                    v0_src <= ((cur[4:0] == 3) ? 2'd1 : ((cur[4:0] == 6) ? 2'd2 : 2'd0));
                    v0_op <= op_c;
                    v0_isw <= isw_c;
                    v0_bm_g_0 <= bmode_c;
                    v0_b16_g_0 <= b2s_f;
                    v0_bm_g_1 <= bmode_c;
                    v0_b16_g_1 <= b2s_f;
                    v0_bm_g_2 <= bmode_c;
                    v0_b16_g_2 <= b2s_f;
                    v0_bm_g_3 <= bmode_c;
                    v0_b16_g_3 <= b2s_f;
                    v0_bm_g_4 <= bmode_c;
                    v0_b16_g_4 <= b2s_f;
                    v0_bm_g_5 <= bmode_c;
                    v0_b16_g_5 <= b2s_f;
                    v0_bm_g_6 <= bmode_c;
                    v0_b16_g_6 <= b2s_f;
                    v0_bm_g_7 <= bmode_c;
                    v0_b16_g_7 <= b2s_f;
                    v0_c32 <= cur[41:10];
                    v0_lbase <= (cur[41:10] + {22'd0, {slice_i, 6'd0}});
                    v0_dst8 <= {cur[8:5], slice_i};
                    v0_slot <= cur_slot;
                    if (exph) begin
                        exph <= 0;
                        if ((slice_i == cur_nsm1)) begin
                            state <= S_IDLE;
                        end else begin
                            slice_i <= (slice_i + 1);
                        end
                    end else begin
                        exph <= 1;
                    end
                end
                3: begin
                    if (red_go) begin
                        rph <= (~rph);
                    end
                    if (iss_red) begin
                        r0_meta <= {cur_slot, rdst, rsl, is_rseg, cur[16:15], r_last, r_first, 1'd1};
                        r0_lm <= red_lm_c;
                        if ((slice_i == cur_nsm1)) begin
                            slice_i <= 0;
                            state <= (is_rx ? S_RXWAIT : S_IDLE);
                        end else begin
                            slice_i <= (slice_i + 1);
                        end
                    end
                end
                29: begin
                    ix_u <= u_ix_u[29:0];
                    ix_ng <= u_ix_ng;
                    ix_s <= ix_s_c;
                    ix_sp <= (u_ix_ng ? ix_sn_c : {1'd0, ix_s_c});
                    state <= S_IXMUL;
                end
                25: begin
                    ix_pl <= u_ixl_p;
                    ix_ph <= u_ixh_p;
                    state <= S_IXADD;
                end
                30: begin
                    cur_laddr <= ix_laddr;
                    ar_nx <= ix_laddr;
                    cur_nb <= ((({3'd0, (ix_lo7 & 7'd63)} + ({3'd0, ((cur_ns == 1) ? cur_tl : 7'd64)} << vsh)) + 10'd63)
                               >> 6);
                    cur_wnb <= ((({4'd0, ((cur_ns == 1) ? cur_tl : 7'd64)} << vsh) + 11'd63) >> 6);
                    cur_wns <= ((({4'd0, ((cur_ns == 1) ? cur_tl : 7'd64)} << vsh) + 11'd63) >> 6);
                    cur_wlb <= (((({3'd0, ((cur_ns == 1) ? cur_tl : 7'd64)} << vsh) & 10'd63) == 0) ? 8'd64 :
                               (({3'd0, ((cur_ns == 1) ? cur_tl : 7'd64)} << vsh) & 10'd63));
                    ar_sl <= 5'd0;
                    aw_sl <= 0;
                    pr_sl <= 0;
                    pr_v <= 0;
                    w_act <= 0;
                    beat <= 0;
                    state <= ((cur[4:0] == 23) ? S_LDRD : S_SLDREQ);
                end
                31: begin
                    if ((nopc <= 2)) begin
                        state <= S_IDLE;
                    end else begin
                        nopc <= (nopc - 1);
                    end
                end
                27: begin
                    if (((~u_red_obusy) & (~r9d_v))) begin
                        rx_wsl <= 0;
                        rx_wg_q <= 0;
                        state <= S_RXWB;
                    end
                end
                28: begin
                    sb_v <= 1;
                    sb_f_g_0 <= gres_rd[15:0];
                    sb_f_g_1 <= gres_rd[15:0];
                    sb_f_g_2 <= gres_rd[15:0];
                    sb_f_g_3 <= gres_rd[15:0];
                    sb_f_g_4 <= gres_rd[15:0];
                    sb_f_g_5 <= gres_rd[15:0];
                    sb_f_g_6 <= gres_rd[15:0];
                    sb_f_g_7 <= gres_rd[15:0];
                    sb_e <= gres_rd[23:16];
                    sb_dst8 <= {cur[8:5], rx_wsl};
                    sb_slot <= cur_slot;
                    if ((rx_wsl == cur_nsm1)) begin
                        state <= S_IDLE;
                    end else begin
                        rx_wsl <= (rx_wsl + 1);
                        rx_wg_q <= (rx_wsl_n >> rg_sh_q);
                    end
                end
                5: begin
                    if (((cur_port ? l1_ar_ready : noc_ar_ready) & cred_ok)) begin
                        beat <= 0;
                        state <= S_LDRD;
                    end
                end
                6: begin
                    if (ex_v) begin
                        lbw_v <= 1;
                        lbw_beat <= ex_beat;
                        lbw_tail <= 0;
                    end
                    if (hs2) begin
                        hs2 <= 0;
                        hs3 <= 1;
                        ldw_busy <= 1;
                        ldw_sl <= slice_i;
                        ldw_dst <= cur[8:5];
                        ldw_slot <= cur_slot;
                        ldw_vlm <= vlm_q;
                        state <= S_LDWB;
                    end else begin
                        if ((ld_hs & (~ldw_busy))) begin
                            ld_hs <= 0;
                            hs2 <= 1;
                            lbw_v <= 1;
                            lbw_tail <= 1;
                        end else begin
                            if (((rb_v | rb_fire) & (~ld_stall))) begin
                                rb_v <= 0;
                                ldq <= ldp;
                                ldp <= (rb_v ? rb_dat : rb_in);
                                if ((beat != 0)) begin
                                    ex_v <= 1;
                                    ex_beat <= beat;
                                    lbw_ce <= 1;
                                end
                                if ((beat == (cur_nb - 1))) begin
                                    if ((slice_i == cur_nsm1)) begin
                                        ift_mdone[cur_slot] <= 1;
                                    end
                                    ld_hs_pre <= 1;
                                end else begin
                                    beat <= (beat + 1);
                                end
                            end
                        end
                    end
                end
                2: begin
                    if ((rcp_c == 5)) begin
                        if (rcp_sf) begin
                            if (fpipe_e) begin
                                sf2_v <= 1;
                                sf2_val <= u_rcp_res;
                                sf2_dst <= cur[8:5];
                                sf2_slot <= cur_slot;
                                state <= S_IDLE;
                            end
                        end else begin
                            rcp_r <= u_rcp_res;
                            state <= (rcp_sc ? S_SEX : S_EX);
                        end
                    end else begin
                        rcp_c <= (rcp_c + 1);
                    end
                end
                7: begin
                    fb <= 0;
                    state <= S_FUN;
                end
                14: begin
                    if (fen) begin
                        if ((fb == 3)) begin
                            fb <= 0;
                            if ((slice_i == cur_nsm1)) begin
                                state <= S_IDLE;
                            end else begin
                                slice_i <= (slice_i + 1);
                            end
                        end else begin
                            fb <= (fb + 1);
                        end
                    end
                end
                21: begin
                    if (fen) begin
                        state <= S_IDLE;
                    end
                end
                8: begin
                    if ((slice_i == cur_nsm1)) begin
                        if ((~ldw_busy)) begin
                            state <= S_IDLE;
                        end
                    end else begin
                        if ((ldw_st >= 5)) begin
                            slice_i <= (slice_i + 1);
                            cur_nb <= (((slice_i + 1) == cur_nsm1) ? bt_nb_t : bt_nb_f);
                            cur_wnb <= (((slice_i + 1) == cur_nsm1) ? bt_wnb_t : bt_wnb_f);
                            cur_wns <= (((slice_i + 1) == cur_nsm1) ? bt_wnb_t : bt_wnb_f);
                            cur_wlb <= (((slice_i + 1) == cur_nsm1) ? bt_wlb_t : bt_wlb_f);
                            beat <= 0;
                            state <= S_LDRD;
                        end
                    end
                end
                11: begin
                    if (st_fin) begin
                        state <= S_IDLE;
                    end
                end
                13: begin
                    s0_v <= 1;
                    s0_isc <= (cur[4:0] == 8);
                    s0_c32 <= cur_c32;
                    s0_cint <= cur_cint;
                    s0_a32 <= sr[cur[12:9]];
                    s0_b32 <= (is_sdiv ? rcp_r : sop_b);
                    s0_op <= (is_sdiv ? 4'd2 : cur[16:13]);
                    s0_dst <= cur[8:5];
                    s0_slot <= cur_slot;
                    state <= S_IDLE;
                end
                15: begin
                    if (((cur_port ? l1_ar_ready : noc_ar_ready) & cred_ok)) begin
                        state <= S_SLDRD;
                    end
                end
                16: begin
                    if ((rb_v | rb_fire)) begin
                        rb_v <= 0;
                        ld0 <= sld_c;
                        ift_mdone[cur_slot] <= 1;
                        state <= S_SLDWB;
                    end
                end
                17: begin
                    if (sl2_free) begin
                        sl2_v <= 1;
                        sl2_val <= sld_el;
                        sl2_i <= (mem_dt == 2);
                        sl2_ipk <= u_sldi_pk;
                        sl2_dst <= cur[8:5];
                        sl2_slot <= cur_slot;
                        state <= S_IDLE;
                    end
                end
                18: begin
                    if ((((cur_port ? l1_aw_ready : noc_aw_ready) & cred_ok) & st_ok)) begin
                        state <= S_SSTW;
                    end
                end
                default: begin
                    if (oq_take) begin
                        state <= S_IDLE;
                    end
                end
            endcase
            if (lc_go) begin
                seqfree <= tick;
            end
            tick <= (tick + 1);
        end
    end
    always_ff @(posedge clk) begin
        vtq_g_0 <= vtal_g_0;
        vtq_g_1 <= vtal_g_1;
        vtq_g_2 <= vtal_g_2;
        vtq_g_3 <= vtal_g_3;
        vtq_g_4 <= vtal_g_4;
        vtq_g_5 <= vtal_g_5;
        vtq_g_6 <= vtal_g_6;
        vtq_g_7 <= vtal_g_7;
    end

    F32ToSeg u_g2s (
        .x(gw_sel),
        .e(u_g2s_e),
        .f(u_g2s_f)
    );
    F32ToSeg u_b2s_s (
        .x(vb_sr),
        .e(u_b2s_s_e),
        .f(u_b2s_s_f)
    );
    F32ToSeg u_b2s_i (
        .x(vb_im),
        .e(u_b2s_i_e),
        .f(u_b2s_i_f)
    );
    F32ToSeg u_b2s_r (
        .x(rcp_r),
        .e(u_b2s_r_e),
        .f(u_b2s_r_f)
    );
    F32ToSeg u_vt2s_s (
        .x(vt_sr),
        .e(u_vt2s_s_e),
        .f(u_vt2s_s_f)
    );
    F32ToSeg u_vt2s_i (
        .x(vt_im),
        .e(u_vt2s_i_e),
        .f(u_vt2s_i_f)
    );
    SMul16x17 u_vta_0 (
        .a(d_vt_g_0),
        .b(d_voh_g_0),
        .c(48'd32768),
        .p(u_vta_0_p)
    );
    SMul16x17 u_vta_1 (
        .a(d_vt_g_1),
        .b(d_voh_g_1),
        .c(48'd32768),
        .p(u_vta_1_p)
    );
    SMul16x17 u_vta_2 (
        .a(d_vt_g_2),
        .b(d_voh_g_2),
        .c(48'd32768),
        .p(u_vta_2_p)
    );
    SMul16x17 u_vta_3 (
        .a(d_vt_g_3),
        .b(d_voh_g_3),
        .c(48'd32768),
        .p(u_vta_3_p)
    );
    SMul16x17 u_vta_4 (
        .a(d_vt_g_4),
        .b(d_voh_g_4),
        .c(48'd32768),
        .p(u_vta_4_p)
    );
    SMul16x17 u_vta_5 (
        .a(d_vt_g_5),
        .b(d_voh_g_5),
        .c(48'd32768),
        .p(u_vta_5_p)
    );
    SMul16x17 u_vta_6 (
        .a(d_vt_g_6),
        .b(d_voh_g_6),
        .c(48'd32768),
        .p(u_vta_6_p)
    );
    SMul16x17 u_vta_7 (
        .a(d_vt_g_7),
        .b(d_voh_g_7),
        .c(48'd32768),
        .p(u_vta_7_p)
    );
    AluSegExp u_segx (
        .ea(d1_ea),
        .eb(d1_eb),
        .op(d1_op),
        .evt(d1_evt),
        .vt(d1_vt),
        .is_where(d1_isw),
        .oha(u_segx_oha),
        .ohb(u_segx_ohb),
        .eo(u_segx_eo)
    );
    Alu64Fix u_alu (
        .clk(clk),
        .rst_n(rst_n),
        .a(ra_row),
        .b(b_row),
        .op_g({v1_op_g_7, v1_op_g_6, v1_op_g_5, v1_op_g_4, v1_op_g_3, v1_op_g_2, v1_op_g_1, v1_op_g_0}),
        .oh_a({oha_g_7, oha_g_6, oha_g_5, oha_g_4, oha_g_3, oha_g_2, oha_g_1, oha_g_0}),
        .oh_b({ohb_g_7, ohb_g_6, ohb_g_5, ohb_g_4, ohb_g_3, ohb_g_2, ohb_g_1, ohb_g_0}),
        .vtq_g({vtq_g_7, vtq_g_6, vtq_g_5, vtq_g_4, vtq_g_3, vtq_g_2, vtq_g_1, vtq_g_0}),
        .isw_g({v1_isw_g_7, v1_isw_g_6, v1_isw_g_5, v1_isw_g_4, v1_isw_g_3, v1_isw_g_2, v1_isw_g_1, v1_isw_g_0}),
        .ph(v0_ph),
        .en(1'd1),
        .res(u_alu_res)
    );
    SegNorm64 u_nrm (
        .clk(clk),
        .rst_n(rst_n),
        .r(u_alu_res),
        .rv(nrm_rv),
        .rph(v2_ph),
        .eo(d_eo),
        .en(1'd1),
        .fq(u_nrm_fq),
        .e(u_nrm_e)
    );
    F32ToSeg u_c2s (
        .x(v3_c32),
        .f(u_c2s_f),
        .e(u_c2s_e)
    );
    LaneIdxFix64 u_lidx (
        .clk(clk),
        .rst_n(rst_n),
        .base(v4_lbase),
        .base_pre(v3_lbase),
        .base_pre2(v2_lbase),
        .v(lidx_v),
        .ph(v4_ph),
        .en(1'd1),
        .fq(u_lidx_fq),
        .e(u_lidx_e)
    );
    ReduceFix64 u_red (
        .clk(clk),
        .rst_n(rst_n),
        .x(red_row),
        .xe(ra_e),
        .mi(r0_meta),
        .hold(1'd0),
        .res(u_red_res),
        .mo(u_red_mo),
        .bm(u_red_bm),
        .bf(u_red_bf),
        .be(u_red_be),
        .obusy(u_red_obusy)
    );
    FpAddP u_racs (
        .clk(clk),
        .rst_n(rst_n),
        .a(racc),
        .b(red_res),
        .res(u_racs_res)
    );
    SAluF32 u_salu (
        .clk(clk),
        .rst_n(rst_n),
        .a(s0_a32),
        .b(s0_b32),
        .op(s0_op),
        .res(u_salu_res)
    );
    I32ToF32A u_s0c (
        .a(s0_c32),
        .pk(u_s0c_pk)
    );
    I32ToF32B u_s1c (
        .pk(s1_cpk),
        .res(u_s1c_res)
    );
    RecipF32 u_rcp (
        .clk(clk),
        .rst_n(rst_n),
        .b(rcp_in),
        .res(u_rcp_res)
    );
    LoadBeatExtract u_lbx (
        .bdat(lbw),
        .dt(vdt),
        .o_0_s(u_lbx_o_0_s),
        .o_0_e(u_lbx_o_0_e),
        .o_0_m(u_lbx_o_0_m),
        .o_1_s(u_lbx_o_1_s),
        .o_1_e(u_lbx_o_1_e),
        .o_1_m(u_lbx_o_1_m),
        .o_2_s(u_lbx_o_2_s),
        .o_2_e(u_lbx_o_2_e),
        .o_2_m(u_lbx_o_2_m),
        .o_3_s(u_lbx_o_3_s),
        .o_3_e(u_lbx_o_3_e),
        .o_3_m(u_lbx_o_3_m)
    );
    SegPackLd u_lpk (
        .clk(clk),
        .rst_n(rst_n),
        .s(lgs_q),
        .m(lgm_pad),
        .ed(lge_q),
        .start(ldw_go_q),
        .en(1'd1),
        .e(u_lpk_e),
        .f(u_lpk_f)
    );
    I32ToF32A u_sldi (
        .a(sld_raw),
        .pk(u_sldi_pk)
    );
    I32ToF32B u_sl2i (
        .pk(sl2_ipk),
        .res(u_sl2i_res)
    );
    CastFromF32 u_sstc (
        .a(sst_src),
        .dt(mem_dt),
        .res(u_sstc_res)
    );
    F32ToSeg u_sf2s (
        .x(sfx_src),
        .f(u_sf2s_f),
        .e(u_sf2s_e)
    );
    FuncBankFix u_func (
        .clk(clk),
        .rst_n(rst_n),
        .x(fx0_x),
        .es_g({fx0_es_g_3, fx0_es_g_2, fx0_es_g_1, fx0_es_g_0}),
        .func_g({fx0_fn_g_3, fx0_fn_g_2, fx0_fn_g_1, fx0_fn_g_0}),
        .kc_g({fx0_kc_g_3, fx0_kc_g_2, fx0_kc_g_1, fx0_kc_g_0}),
        .en(fm0[0]),
        .adv(1'd1),
        .m(u_func_m),
        .ed(u_func_ed),
        .sgn(u_func_sgn)
    );
    SegPackFunc u_pk (
        .clk(clk),
        .rst_n(rst_n),
        .s(pkh_s),
        .m(pkh_m),
        .ed(pkh_e),
        .start(pk_v),
        .en(1'd1),
        .fq(u_pk_fq),
        .e(u_pk_e)
    );
    FuncSegToF32 u_sf32 (
        .m(u_func_m[18:0]),
        .ed(u_func_ed[8:0]),
        .sgn(u_func_sgn[0]),
        .res(u_sf32_res)
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
        .rda_idx(kw_vid),
        .rdb_idx(kw_vid_b),
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
    F32ToI32 u_ix (
        .a(ix_src),
        .u(u_ix_u),
        .ng(u_ix_ng)
    );
    SMulIdx u_ixl (
        .a(ix_sp),
        .b(ix_u[16:0]),
        .c(ix_cz),
        .p(u_ixl_p)
    );
    SMulIdx u_ixh (
        .a(ix_sp),
        .b({4'd0, ix_u[29:17]}),
        .c(48'd0),
        .p(u_ixh_p)
    );
    SMulIdx u_pal (
        .a(pa_sp),
        .b(pa_u[16:0]),
        .c(pa_cz),
        .p(u_pal_p)
    );
    SMulIdx u_pah (
        .a(pa_sp),
        .b({4'd0, pa_u[29:17]}),
        .c(48'd0),
        .p(u_pah_p)
    );
    StoreCastBeatB u_stb (
        .pk(xq_pk),
        .sg({xq_e_g_7, xq_e_g_6, xq_e_g_5, xq_e_g_4, xq_e_g_3, xq_e_g_2, xq_e_g_1, xq_e_g_0}),
        .is32d(xq_32),
        .res(u_stb_res)
    );
    StoreCastBeatA u_sta (
        .li(li_in),
        .pk(u_sta_pk)
    );
endmodule
