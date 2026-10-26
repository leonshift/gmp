module NocHostPort (
    input clk,
    input rst_n,
    input calib,
    input h_wen,
    input [5:0] h_addr,
    input [31:0] h_wdata,
    input [5:0] h_raddr,
    output logic [31:0] h_rdata,
    input b_we,
    input b_re,
    input [11:0] b_addr,
    input [31:0] b_wdata,
    output logic [31:0] b_rdata,
    output logic p_0_ar_valid,
    input p_0_ar_ready,
    output logic [3:0] p_0_ar_id,
    output logic [15:0] p_0_ar_tag,
    output logic [47:0] p_0_ar_addr,
    output logic [19:0] p_0_ar_bytes,
    output logic [15:0] p_0_ar_rows,
    output logic [19:0] p_0_ar_stride,
    output logic p_0_ar_first,
    output logic p_0_ar_last,
    output logic p_0_aw_valid,
    input p_0_aw_ready,
    output logic [3:0] p_0_aw_id,
    output logic [15:0] p_0_aw_tag,
    output logic [47:0] p_0_aw_addr,
    output logic [19:0] p_0_aw_bytes,
    output logic [15:0] p_0_aw_rows,
    output logic [19:0] p_0_aw_stride,
    output logic p_0_aw_first,
    output logic p_0_aw_last,
    output logic p_0_w_valid,
    output logic [3:0] p_0_w_id,
    output logic [1023:0] p_0_w_data,
    output logic [127:0] p_0_w_strb,
    input [7:0] p_0_w_ready,
    input p_0_r_valid,
    output logic p_0_r_ready,
    input [1023:0] p_0_r_data,
    input [3:0] p_0_r_id,
    input [15:0] p_0_r_tag,
    input p_0_r_last,
    input p_0_b_valid,
    output logic p_0_b_ready,
    input [3:0] p_0_b_id,
    input [15:0] p_0_b_tag,
    input p_0_a_valid,
    input [3:0] p_0_a_id,
    input [15:0] p_0_a_tag,
    output logic p_1_ar_valid,
    input p_1_ar_ready,
    output logic [3:0] p_1_ar_id,
    output logic [15:0] p_1_ar_tag,
    output logic [47:0] p_1_ar_addr,
    output logic [19:0] p_1_ar_bytes,
    output logic [15:0] p_1_ar_rows,
    output logic [19:0] p_1_ar_stride,
    output logic p_1_ar_first,
    output logic p_1_ar_last,
    output logic p_1_aw_valid,
    input p_1_aw_ready,
    output logic [3:0] p_1_aw_id,
    output logic [15:0] p_1_aw_tag,
    output logic [47:0] p_1_aw_addr,
    output logic [19:0] p_1_aw_bytes,
    output logic [15:0] p_1_aw_rows,
    output logic [19:0] p_1_aw_stride,
    output logic p_1_aw_first,
    output logic p_1_aw_last,
    output logic p_1_w_valid,
    output logic [3:0] p_1_w_id,
    output logic [511:0] p_1_w_data,
    output logic [63:0] p_1_w_strb,
    input [7:0] p_1_w_ready,
    input p_1_r_valid,
    output logic p_1_r_ready,
    input [511:0] p_1_r_data,
    input [3:0] p_1_r_id,
    input [15:0] p_1_r_tag,
    input p_1_r_last,
    input p_1_b_valid,
    output logic p_1_b_ready,
    input [3:0] p_1_b_id,
    input [15:0] p_1_b_tag,
    input p_1_a_valid,
    input [3:0] p_1_a_id,
    input [15:0] p_1_a_tag,
    output logic p_2_ar_valid,
    input p_2_ar_ready,
    output logic [3:0] p_2_ar_id,
    output logic [15:0] p_2_ar_tag,
    output logic [47:0] p_2_ar_addr,
    output logic [19:0] p_2_ar_bytes,
    output logic [15:0] p_2_ar_rows,
    output logic [19:0] p_2_ar_stride,
    output logic p_2_ar_first,
    output logic p_2_ar_last,
    output logic p_2_aw_valid,
    input p_2_aw_ready,
    output logic [3:0] p_2_aw_id,
    output logic [15:0] p_2_aw_tag,
    output logic [47:0] p_2_aw_addr,
    output logic [19:0] p_2_aw_bytes,
    output logic [15:0] p_2_aw_rows,
    output logic [19:0] p_2_aw_stride,
    output logic p_2_aw_first,
    output logic p_2_aw_last,
    output logic p_2_w_valid,
    output logic [3:0] p_2_w_id,
    output logic [511:0] p_2_w_data,
    output logic [63:0] p_2_w_strb,
    input [7:0] p_2_w_ready,
    input p_2_r_valid,
    output logic p_2_r_ready,
    input [1023:0] p_2_r_data,
    input [3:0] p_2_r_id,
    input [15:0] p_2_r_tag,
    input p_2_r_last,
    input p_2_b_valid,
    output logic p_2_b_ready,
    input [3:0] p_2_b_id,
    input [15:0] p_2_b_tag,
    input p_2_a_valid,
    input [3:0] p_2_a_id,
    input [15:0] p_2_a_tag,
    output logic p_3_ar_valid,
    input p_3_ar_ready,
    output logic [3:0] p_3_ar_id,
    output logic [15:0] p_3_ar_tag,
    output logic [47:0] p_3_ar_addr,
    output logic [19:0] p_3_ar_bytes,
    output logic [15:0] p_3_ar_rows,
    output logic [19:0] p_3_ar_stride,
    output logic p_3_ar_first,
    output logic p_3_ar_last,
    output logic p_3_aw_valid,
    input p_3_aw_ready,
    output logic [3:0] p_3_aw_id,
    output logic [15:0] p_3_aw_tag,
    output logic [47:0] p_3_aw_addr,
    output logic [19:0] p_3_aw_bytes,
    output logic [15:0] p_3_aw_rows,
    output logic [19:0] p_3_aw_stride,
    output logic p_3_aw_first,
    output logic p_3_aw_last,
    output logic p_3_w_valid,
    output logic [3:0] p_3_w_id,
    output logic [1023:0] p_3_w_data,
    output logic [127:0] p_3_w_strb,
    input [7:0] p_3_w_ready,
    input p_3_r_valid,
    output logic p_3_r_ready,
    input [1023:0] p_3_r_data,
    input [3:0] p_3_r_id,
    input [15:0] p_3_r_tag,
    input p_3_r_last,
    input p_3_b_valid,
    output logic p_3_b_ready,
    input [3:0] p_3_b_id,
    input [15:0] p_3_b_tag,
    input p_3_a_valid,
    input [3:0] p_3_a_id,
    input [15:0] p_3_a_tag,
    output logic p_4_ar_valid,
    input p_4_ar_ready,
    output logic [3:0] p_4_ar_id,
    output logic [15:0] p_4_ar_tag,
    output logic [47:0] p_4_ar_addr,
    output logic [19:0] p_4_ar_bytes,
    output logic [15:0] p_4_ar_rows,
    output logic [19:0] p_4_ar_stride,
    output logic p_4_ar_first,
    output logic p_4_ar_last,
    output logic p_4_aw_valid,
    input p_4_aw_ready,
    output logic [3:0] p_4_aw_id,
    output logic [15:0] p_4_aw_tag,
    output logic [47:0] p_4_aw_addr,
    output logic [19:0] p_4_aw_bytes,
    output logic [15:0] p_4_aw_rows,
    output logic [19:0] p_4_aw_stride,
    output logic p_4_aw_first,
    output logic p_4_aw_last,
    output logic p_4_w_valid,
    output logic [3:0] p_4_w_id,
    output logic [1023:0] p_4_w_data,
    output logic [127:0] p_4_w_strb,
    input [7:0] p_4_w_ready,
    input p_4_r_valid,
    output logic p_4_r_ready,
    input [1023:0] p_4_r_data,
    input [3:0] p_4_r_id,
    input [15:0] p_4_r_tag,
    input p_4_r_last,
    input p_4_b_valid,
    output logic p_4_b_ready,
    input [3:0] p_4_b_id,
    input [15:0] p_4_b_tag,
    input p_4_a_valid,
    input [3:0] p_4_a_id,
    input [15:0] p_4_a_tag
);
    logic hw_en;
    logic [5:0] hw_addr;
    logic [31:0] hw_data;
    logic hb_we;
    logic [11:0] hb_addr;
    logic [31:0] hb_wdata;
    logic fwd_q;
    logic [31:0] fwd_d;
    logic rl_v;
    logic [6:0] rl_waddr;
    logic [1023:0] rl_data;
    logic [47:0] s_addr;
    logic [19:0] s_bytes;
    logic [15:0] s_rows;
    logic [19:0] s_stride;
    logic [2:0] s_port;
    logic s_dir;
    logic [3:0] s_wid;
    logic [6:0] s_off;
    logic [7:0] s_nb;
    logic [2:0] c_port [0:63];
    logic c_dir [0:63];
    logic [3:0] c_wid [0:63];
    logic [47:0] c_addr [0:63];
    logic [19:0] c_bytes [0:63];
    logic [15:0] c_rows [0:63];
    logic [19:0] c_stride [0:63];
    logic [6:0] c_off [0:63];
    logic [7:0] c_nb [0:63];
    logic [7:0] c_rb [0:63];
    logic [6:0] c_sh [0:63];
    logic [6:0] c_e [0:63];
    logic [6:0] n_cmd;
    logic [6:0] n_rd;
    logic [6:0] n_wr;
    logic [6:0] ip;
    logic busy;
    logic done;
    logic [31:0] t;
    logic [31:0] t_first;
    logic t_first_v;
    logic [31:0] t_all;
    logic [6:0] n_issued;
    logic [6:0] n_rlast;
    logic [6:0] n_b;
    logic [15:0] n_admit;
    logic [15:0] n_rbeats;
    logic [15:0] n_wbeats;
    logic [7:0] pt_0_rcnt;
    logic [3:0] pt_0_wf_wp;
    logic [3:0] pt_0_wf_rp;
    logic [4:0] pt_0_wf_cnt;
    logic [7:0] pt_0_wcnt;
    logic [7:0] pt_0_wrow;
    logic [7:0] pt_0_ra8;
    logic pt_0_ar_v;
    logic pt_0_aw_v;
    logic pt_0_acc;
    logic pt_0_rsel;
    logic pt_0_hc_v;
    logic [3:0] pt_0_hc_wid;
    logic [7:0] pt_0_hc_nb;
    logic [7:0] pt_0_hc_rb1;
    logic [6:0] pt_0_hc_sh;
    logic [6:0] pt_0_hc_e;
    logic [6:0] pt_0_hc_off;
    logic [7:0] pt_0_hc_a8;
    logic [7:0] pt_0_hc_s8;
    logic [7:0] pt_0_wrsh;
    logic pt_0_wwant;
    logic [6:0] pt_0_d_raddr;
    logic [127:0] pt_0_d_strb;
    logic pt_0_d_lastb;
    logic pt_0_d_rowend;
    logic [7:0] pt_0_d_ra8;
    logic [7:0] pt_0_d_ra8n;
    logic [7:0] pt_1_rcnt;
    logic [3:0] pt_1_wf_wp;
    logic [3:0] pt_1_wf_rp;
    logic [4:0] pt_1_wf_cnt;
    logic [7:0] pt_1_wcnt;
    logic [7:0] pt_1_wrow;
    logic [7:0] pt_1_ra8;
    logic pt_1_ar_v;
    logic pt_1_aw_v;
    logic pt_1_acc;
    logic pt_1_rsel;
    logic pt_1_hc_v;
    logic [3:0] pt_1_hc_wid;
    logic [7:0] pt_1_hc_nb;
    logic [7:0] pt_1_hc_rb1;
    logic [6:0] pt_1_hc_sh;
    logic [6:0] pt_1_hc_e;
    logic [6:0] pt_1_hc_off;
    logic [7:0] pt_1_hc_a8;
    logic [7:0] pt_1_hc_s8;
    logic [7:0] pt_1_wrsh;
    logic pt_1_wwant;
    logic [6:0] pt_1_d_raddr;
    logic [127:0] pt_1_d_strb;
    logic pt_1_d_lastb;
    logic pt_1_d_rowend;
    logic [7:0] pt_1_d_ra8;
    logic [7:0] pt_1_d_ra8n;
    logic [7:0] pt_2_rcnt;
    logic [3:0] pt_2_wf_wp;
    logic [3:0] pt_2_wf_rp;
    logic [4:0] pt_2_wf_cnt;
    logic [7:0] pt_2_wcnt;
    logic [7:0] pt_2_wrow;
    logic [7:0] pt_2_ra8;
    logic pt_2_ar_v;
    logic pt_2_aw_v;
    logic pt_2_acc;
    logic pt_2_rsel;
    logic pt_2_hc_v;
    logic [3:0] pt_2_hc_wid;
    logic [7:0] pt_2_hc_nb;
    logic [7:0] pt_2_hc_rb1;
    logic [6:0] pt_2_hc_sh;
    logic [6:0] pt_2_hc_e;
    logic [6:0] pt_2_hc_off;
    logic [7:0] pt_2_hc_a8;
    logic [7:0] pt_2_hc_s8;
    logic [7:0] pt_2_wrsh;
    logic pt_2_wwant;
    logic [6:0] pt_2_d_raddr;
    logic [127:0] pt_2_d_strb;
    logic pt_2_d_lastb;
    logic pt_2_d_rowend;
    logic [7:0] pt_2_d_ra8;
    logic [7:0] pt_2_d_ra8n;
    logic [7:0] pt_3_rcnt;
    logic [3:0] pt_3_wf_wp;
    logic [3:0] pt_3_wf_rp;
    logic [4:0] pt_3_wf_cnt;
    logic [7:0] pt_3_wcnt;
    logic [7:0] pt_3_wrow;
    logic [7:0] pt_3_ra8;
    logic pt_3_ar_v;
    logic pt_3_aw_v;
    logic pt_3_acc;
    logic pt_3_rsel;
    logic pt_3_hc_v;
    logic [3:0] pt_3_hc_wid;
    logic [7:0] pt_3_hc_nb;
    logic [7:0] pt_3_hc_rb1;
    logic [6:0] pt_3_hc_sh;
    logic [6:0] pt_3_hc_e;
    logic [6:0] pt_3_hc_off;
    logic [7:0] pt_3_hc_a8;
    logic [7:0] pt_3_hc_s8;
    logic [7:0] pt_3_wrsh;
    logic pt_3_wwant;
    logic [6:0] pt_3_d_raddr;
    logic [127:0] pt_3_d_strb;
    logic pt_3_d_lastb;
    logic pt_3_d_rowend;
    logic [7:0] pt_3_d_ra8;
    logic [7:0] pt_3_d_ra8n;
    logic [7:0] pt_4_rcnt;
    logic [3:0] pt_4_wf_wp;
    logic [3:0] pt_4_wf_rp;
    logic [4:0] pt_4_wf_cnt;
    logic [7:0] pt_4_wcnt;
    logic [7:0] pt_4_wrow;
    logic [7:0] pt_4_ra8;
    logic pt_4_ar_v;
    logic pt_4_aw_v;
    logic pt_4_acc;
    logic pt_4_rsel;
    logic pt_4_hc_v;
    logic [3:0] pt_4_hc_wid;
    logic [7:0] pt_4_hc_nb;
    logic [7:0] pt_4_hc_rb1;
    logic [6:0] pt_4_hc_sh;
    logic [6:0] pt_4_hc_e;
    logic [6:0] pt_4_hc_off;
    logic [7:0] pt_4_hc_a8;
    logic [7:0] pt_4_hc_s8;
    logic [7:0] pt_4_wrsh;
    logic pt_4_wwant;
    logic [6:0] pt_4_d_raddr;
    logic [127:0] pt_4_d_strb;
    logic pt_4_d_lastb;
    logic pt_4_d_rowend;
    logic [7:0] pt_4_d_ra8;
    logic [7:0] pt_4_d_ra8n;
    logic [2:0] credit_0;
    logic [2:0] credit_1;
    logic [2:0] credit_2;
    logic [2:0] credit_3;
    logic [2:0] credit_4;
    logic [5:0] wf [0:127];
    logic sv;
    logic [2:0] sport;
    logic [3:0] swid;
    logic [4:0] soh;
    logic [7:0] swoh;
    logic [127:0] sstrb;
    logic [7:0] rq_0;
    logic [7:0] rq_1;
    logic [7:0] rq_2;
    logic [7:0] rq_3;
    logic [7:0] rq_4;
    logic [4:0] b_word_q;
    logic i_ok;
    logic [2:0] i_port;
    logic i_dir;
    logic [3:0] i_wid;
    logic [47:0] i_addr;
    logic [19:0] i_bytes;
    logic [15:0] i_rows;
    logic [19:0] i_stride;
    logic acc_any;
    logic [6:0] wf_widx;
    logic rl_free;
    logic r_any;
    logic [2:0] r_p;
    logic [15:0] r_tag;
    logic r_last;
    logic [1023:0] r_data;
    logic [7:0] r_cnt;
    logic [6:0] r_off;
    logic [6:0] r_waddr;
    logic [6:0] bw_sh;
    logic [127:0] bw_strb;
    logic buf_wen;
    logic [6:0] buf_waddr;
    logic [1023:0] buf_wdata;
    logic [127:0] buf_wstrb;
    logic fwd;
    logic take_p_0;
    logic take_p_1;
    logic take_p_2;
    logic take_p_3;
    logic take_p_4;
    logic take;
    logic [7:0] s_rq;
    logic [7:0] s_rqsh;
    logic drop;
    logic w_new_any;
    logic [2:0] w_new_p;
    logic f_go;
    logic [2:0] f_p;
    logic [6:0] f_raddr;
    logic [127:0] f_strb;
    logic [3:0] f_wid;
    logic buf_ren;
    logic [6:0] buf_raddr;
    logic [1023:0] buf_rdata;
    logic hl_any;
    logic [2:0] hl_p;
    logic [5:0] hl_h;
    logic hl_nar;
    logic [7:0] hl_rb1;
    logic [6:0] hl_sh;
    logic [6:0] hl_e;
    logic [3:0] hl_wid;
    logic [7:0] hl_nb;
    logic [6:0] hl_off;
    logic [7:0] hl_a8;
    logic [7:0] hl_s8;
    logic s_nar;
    logic [20:0] s_rbn;
    logic [20:0] s_rbsum;
    logic [8:0] s_esum;
    logic go_c;
    logic done_c;
    logic b_any;
    logic [2:0] b_sum;
    logic [2:0] a_sum;
    logic [5:0] k;
    logic [511:0] u_buf_1_rdata;
    logic [511:0] u_buf_0_rdata;

    assign i_ok = (busy & (ip != n_cmd));
    assign i_port = c_port[ip[5:0]];
    assign i_dir = c_dir[ip[5:0]];
    assign i_wid = c_wid[ip[5:0]];
    assign i_addr = c_addr[ip[5:0]];
    assign i_bytes = c_bytes[ip[5:0]];
    assign i_rows = c_rows[ip[5:0]];
    assign i_stride = c_stride[ip[5:0]];
    assign pt_0_ar_v = (((i_ok & (~i_dir)) & (i_port == 0)) & (credit_0 != 0));
    assign pt_0_aw_v = (((i_ok & i_dir) & (i_port == 0)) & (credit_0 != 0));
    assign pt_0_acc = ((pt_0_ar_v & p_0_ar_ready) | (pt_0_aw_v & p_0_aw_ready));
    assign p_0_ar_valid = pt_0_ar_v;
    assign p_0_ar_id = i_wid;
    assign p_0_ar_tag = {10'd0, ip[5:0]};
    assign p_0_ar_addr = i_addr;
    assign p_0_ar_bytes = i_bytes;
    assign p_0_ar_rows = i_rows;
    assign p_0_ar_stride = i_stride;
    assign p_0_ar_first = 1'd1;
    assign p_0_ar_last = 1'd1;
    assign p_0_aw_valid = pt_0_aw_v;
    assign p_0_aw_id = i_wid;
    assign p_0_aw_tag = {10'd0, ip[5:0]};
    assign p_0_aw_addr = i_addr;
    assign p_0_aw_bytes = i_bytes;
    assign p_0_aw_rows = i_rows;
    assign p_0_aw_stride = i_stride;
    assign p_0_aw_first = 1'd1;
    assign p_0_aw_last = 1'd1;
    assign p_0_b_ready = 1'd1;
    assign pt_1_ar_v = (((i_ok & (~i_dir)) & (i_port == 1)) & (credit_1 != 0));
    assign pt_1_aw_v = (((i_ok & i_dir) & (i_port == 1)) & (credit_1 != 0));
    assign pt_1_acc = ((pt_1_ar_v & p_1_ar_ready) | (pt_1_aw_v & p_1_aw_ready));
    assign p_1_ar_valid = pt_1_ar_v;
    assign p_1_ar_id = i_wid;
    assign p_1_ar_tag = {10'd0, ip[5:0]};
    assign p_1_ar_addr = i_addr;
    assign p_1_ar_bytes = i_bytes;
    assign p_1_ar_rows = i_rows;
    assign p_1_ar_stride = i_stride;
    assign p_1_ar_first = 1'd1;
    assign p_1_ar_last = 1'd1;
    assign p_1_aw_valid = pt_1_aw_v;
    assign p_1_aw_id = i_wid;
    assign p_1_aw_tag = {10'd0, ip[5:0]};
    assign p_1_aw_addr = i_addr;
    assign p_1_aw_bytes = i_bytes;
    assign p_1_aw_rows = i_rows;
    assign p_1_aw_stride = i_stride;
    assign p_1_aw_first = 1'd1;
    assign p_1_aw_last = 1'd1;
    assign p_1_b_ready = 1'd1;
    assign pt_2_ar_v = (((i_ok & (~i_dir)) & (i_port == 2)) & (credit_2 != 0));
    assign pt_2_aw_v = (((i_ok & i_dir) & (i_port == 2)) & (credit_2 != 0));
    assign pt_2_acc = ((pt_2_ar_v & p_2_ar_ready) | (pt_2_aw_v & p_2_aw_ready));
    assign p_2_ar_valid = pt_2_ar_v;
    assign p_2_ar_id = i_wid;
    assign p_2_ar_tag = {10'd0, ip[5:0]};
    assign p_2_ar_addr = i_addr;
    assign p_2_ar_bytes = i_bytes;
    assign p_2_ar_rows = i_rows;
    assign p_2_ar_stride = i_stride;
    assign p_2_ar_first = 1'd1;
    assign p_2_ar_last = 1'd1;
    assign p_2_aw_valid = pt_2_aw_v;
    assign p_2_aw_id = i_wid;
    assign p_2_aw_tag = {10'd0, ip[5:0]};
    assign p_2_aw_addr = i_addr;
    assign p_2_aw_bytes = i_bytes;
    assign p_2_aw_rows = i_rows;
    assign p_2_aw_stride = i_stride;
    assign p_2_aw_first = 1'd1;
    assign p_2_aw_last = 1'd1;
    assign p_2_b_ready = 1'd1;
    assign pt_3_ar_v = (((i_ok & (~i_dir)) & (i_port == 3)) & (credit_3 != 0));
    assign pt_3_aw_v = (((i_ok & i_dir) & (i_port == 3)) & (credit_3 != 0));
    assign pt_3_acc = ((pt_3_ar_v & p_3_ar_ready) | (pt_3_aw_v & p_3_aw_ready));
    assign p_3_ar_valid = pt_3_ar_v;
    assign p_3_ar_id = i_wid;
    assign p_3_ar_tag = {10'd0, ip[5:0]};
    assign p_3_ar_addr = i_addr;
    assign p_3_ar_bytes = i_bytes;
    assign p_3_ar_rows = i_rows;
    assign p_3_ar_stride = i_stride;
    assign p_3_ar_first = 1'd1;
    assign p_3_ar_last = 1'd1;
    assign p_3_aw_valid = pt_3_aw_v;
    assign p_3_aw_id = i_wid;
    assign p_3_aw_tag = {10'd0, ip[5:0]};
    assign p_3_aw_addr = i_addr;
    assign p_3_aw_bytes = i_bytes;
    assign p_3_aw_rows = i_rows;
    assign p_3_aw_stride = i_stride;
    assign p_3_aw_first = 1'd1;
    assign p_3_aw_last = 1'd1;
    assign p_3_b_ready = 1'd1;
    assign pt_4_ar_v = (((i_ok & (~i_dir)) & (i_port == 4)) & (credit_4 != 0));
    assign pt_4_aw_v = (((i_ok & i_dir) & (i_port == 4)) & (credit_4 != 0));
    assign pt_4_acc = ((pt_4_ar_v & p_4_ar_ready) | (pt_4_aw_v & p_4_aw_ready));
    assign p_4_ar_valid = pt_4_ar_v;
    assign p_4_ar_id = i_wid;
    assign p_4_ar_tag = {10'd0, ip[5:0]};
    assign p_4_ar_addr = i_addr;
    assign p_4_ar_bytes = i_bytes;
    assign p_4_ar_rows = i_rows;
    assign p_4_ar_stride = i_stride;
    assign p_4_ar_first = 1'd1;
    assign p_4_ar_last = 1'd1;
    assign p_4_aw_valid = pt_4_aw_v;
    assign p_4_aw_id = i_wid;
    assign p_4_aw_tag = {10'd0, ip[5:0]};
    assign p_4_aw_addr = i_addr;
    assign p_4_aw_bytes = i_bytes;
    assign p_4_aw_rows = i_rows;
    assign p_4_aw_stride = i_stride;
    assign p_4_aw_first = 1'd1;
    assign p_4_aw_last = 1'd1;
    assign p_4_b_ready = 1'd1;
    assign acc_any = (i_ok
                      & ((i_port == 0) ? pt_0_acc :
                        ((i_port == 1) ? pt_1_acc :
                        ((i_port == 2) ? pt_2_acc :
                        ((i_port == 3) ? pt_3_acc :
                        ((i_port == 4) ? pt_4_acc :
                        1'd0))))));
    assign wf_widx = {i_port,
                      ((i_port == 0) ? pt_0_wf_wp :
                      ((i_port == 1) ? pt_1_wf_wp :
                      ((i_port == 2) ? pt_2_wf_wp :
                      ((i_port == 3) ? pt_3_wf_wp :
                      ((i_port == 4) ? pt_4_wf_wp :
                      4'd0)))))};
    assign rl_free = ((~rl_v) | (~hb_we));
    assign pt_0_rsel = (p_0_r_valid & (~(~rl_free)));
    assign p_0_r_ready = pt_0_rsel;
    assign pt_1_rsel = (p_1_r_valid & (~((~rl_free) | p_0_r_valid)));
    assign p_1_r_ready = pt_1_rsel;
    assign pt_2_rsel = (p_2_r_valid & (~(((~rl_free) | p_0_r_valid) | p_1_r_valid)));
    assign p_2_r_ready = pt_2_rsel;
    assign pt_3_rsel = (p_3_r_valid & (~((((~rl_free) | p_0_r_valid) | p_1_r_valid) | p_2_r_valid)));
    assign p_3_r_ready = pt_3_rsel;
    assign pt_4_rsel = (p_4_r_valid & (~(((((~rl_free) | p_0_r_valid) | p_1_r_valid) | p_2_r_valid) | p_3_r_valid)));
    assign p_4_r_ready = pt_4_rsel;
    assign r_any = (rl_free & ((((p_0_r_valid | p_1_r_valid) | p_2_r_valid) | p_3_r_valid) | p_4_r_valid));
    assign r_p = (pt_0_rsel ? 3'd0 : (pt_1_rsel ? 3'd1 : (pt_2_rsel ? 3'd2 : (pt_3_rsel ? 3'd3 : 3'd4))));
    assign r_tag = ((r_p == 0) ? p_0_r_tag :
                   ((r_p == 1) ? p_1_r_tag :
                   ((r_p == 2) ? p_2_r_tag :
                   ((r_p == 3) ? p_3_r_tag :
                   ((r_p == 4) ? p_4_r_tag :
                   16'd0)))));
    assign r_last = ((r_p == 0) ? p_0_r_last :
                    ((r_p == 1) ? p_1_r_last :
                    ((r_p == 2) ? p_2_r_last :
                    ((r_p == 3) ? p_3_r_last :
                    ((r_p == 4) ? p_4_r_last :
                    1'd0)))));
    assign r_data = ((r_p == 0) ? p_0_r_data :
                    ((r_p == 1) ? {512'd0, p_1_r_data} :
                    ((r_p == 2) ? p_2_r_data :
                    ((r_p == 3) ? p_3_r_data :
                    ((r_p == 4) ? p_4_r_data :
                    1024'd0)))));
    assign r_cnt = ((r_p == 0) ? pt_0_rcnt :
                   ((r_p == 1) ? pt_1_rcnt :
                   ((r_p == 2) ? pt_2_rcnt :
                   ((r_p == 3) ? pt_3_rcnt :
                   ((r_p == 4) ? pt_4_rcnt :
                   8'd0)))));
    assign r_off = c_off[r_tag[5:0]];
    assign r_waddr = (r_off + r_cnt);
    assign bw_sh = {hb_addr[4:0], 2'd0};
    assign bw_strb = ({124'd0, 4'd15} << bw_sh);
    assign buf_wen = (hb_we | rl_v);
    assign buf_waddr = (hb_we ? hb_addr[11:5] : rl_waddr);
    assign buf_wdata = (hb_we ? {32{hb_wdata}} : rl_data);
    assign buf_wstrb = (hb_we ? bw_strb : (~128'd0));
    assign fwd = ((b_re & hb_we) & (b_addr == hb_addr));
    assign pt_0_wrsh = (rq_0 >> pt_0_hc_wid);
    assign pt_0_wwant = (pt_0_hc_v & pt_0_wrsh[0]);
    assign pt_0_d_raddr = (pt_0_hc_off + pt_0_wcnt[6:0]);
    assign pt_0_d_strb = (((pt_0_wrow == 0) ? ((~128'd0) << pt_0_hc_sh) : (~128'd0))
                          & ((pt_0_wrow == pt_0_hc_rb1) ? ((~128'd0) >> (~pt_0_hc_e)) : (~128'd0)));
    assign pt_0_d_lastb = ((pt_0_wcnt + 1) == pt_0_hc_nb);
    assign pt_0_d_rowend = (pt_0_wrow == pt_0_hc_rb1);
    assign pt_0_d_ra8 = ((pt_0_wcnt == 0) ? pt_0_hc_a8 : pt_0_ra8);
    assign pt_0_d_ra8n = (pt_0_d_ra8 + pt_0_hc_s8);
    assign pt_1_wrsh = (rq_1 >> pt_1_hc_wid);
    assign pt_1_wwant = (pt_1_hc_v & pt_1_wrsh[0]);
    assign pt_1_d_raddr = (pt_1_hc_off + pt_1_wcnt[6:0]);
    assign pt_1_d_strb = (((pt_1_wrow == 0) ? ((~128'd0) << pt_1_hc_sh) : (~128'd0))
                          & ((pt_1_wrow == pt_1_hc_rb1) ? ((~128'd0) >> (~pt_1_hc_e)) : (~128'd0)));
    assign pt_1_d_lastb = ((pt_1_wcnt + 1) == pt_1_hc_nb);
    assign pt_1_d_rowend = (pt_1_wrow == pt_1_hc_rb1);
    assign pt_1_d_ra8 = ((pt_1_wcnt == 0) ? pt_1_hc_a8 : pt_1_ra8);
    assign pt_1_d_ra8n = (pt_1_d_ra8 + pt_1_hc_s8);
    assign pt_2_wrsh = (rq_2 >> pt_2_hc_wid);
    assign pt_2_wwant = (pt_2_hc_v & pt_2_wrsh[0]);
    assign pt_2_d_raddr = (pt_2_hc_off + pt_2_wcnt[6:0]);
    assign pt_2_d_strb = (((pt_2_wrow == 0) ? ((~128'd0) << pt_2_hc_sh) : (~128'd0))
                          & ((pt_2_wrow == pt_2_hc_rb1) ? ((~128'd0) >> (~pt_2_hc_e)) : (~128'd0)));
    assign pt_2_d_lastb = ((pt_2_wcnt + 1) == pt_2_hc_nb);
    assign pt_2_d_rowend = (pt_2_wrow == pt_2_hc_rb1);
    assign pt_2_d_ra8 = ((pt_2_wcnt == 0) ? pt_2_hc_a8 : pt_2_ra8);
    assign pt_2_d_ra8n = (pt_2_d_ra8 + pt_2_hc_s8);
    assign pt_3_wrsh = (rq_3 >> pt_3_hc_wid);
    assign pt_3_wwant = (pt_3_hc_v & pt_3_wrsh[0]);
    assign pt_3_d_raddr = (pt_3_hc_off + pt_3_wcnt[6:0]);
    assign pt_3_d_strb = (((pt_3_wrow == 0) ? ((~128'd0) << pt_3_hc_sh) : (~128'd0))
                          & ((pt_3_wrow == pt_3_hc_rb1) ? ((~128'd0) >> (~pt_3_hc_e)) : (~128'd0)));
    assign pt_3_d_lastb = ((pt_3_wcnt + 1) == pt_3_hc_nb);
    assign pt_3_d_rowend = (pt_3_wrow == pt_3_hc_rb1);
    assign pt_3_d_ra8 = ((pt_3_wcnt == 0) ? pt_3_hc_a8 : pt_3_ra8);
    assign pt_3_d_ra8n = (pt_3_d_ra8 + pt_3_hc_s8);
    assign pt_4_wrsh = (rq_4 >> pt_4_hc_wid);
    assign pt_4_wwant = (pt_4_hc_v & pt_4_wrsh[0]);
    assign pt_4_d_raddr = (pt_4_hc_off + pt_4_wcnt[6:0]);
    assign pt_4_d_strb = (((pt_4_wrow == 0) ? ((~128'd0) << pt_4_hc_sh) : (~128'd0))
                          & ((pt_4_wrow == pt_4_hc_rb1) ? ((~128'd0) >> (~pt_4_hc_e)) : (~128'd0)));
    assign pt_4_d_lastb = ((pt_4_wcnt + 1) == pt_4_hc_nb);
    assign pt_4_d_rowend = (pt_4_wrow == pt_4_hc_rb1);
    assign pt_4_d_ra8 = ((pt_4_wcnt == 0) ? pt_4_hc_a8 : pt_4_ra8);
    assign pt_4_d_ra8n = (pt_4_d_ra8 + pt_4_hc_s8);
    assign take_p_0 = ((sv & soh[0]) & ((p_0_w_ready & swoh) != 0));
    assign take_p_1 = ((sv & soh[1]) & ((p_1_w_ready & swoh) != 0));
    assign take_p_2 = ((sv & soh[2]) & ((p_2_w_ready & swoh) != 0));
    assign take_p_3 = ((sv & soh[3]) & ((p_3_w_ready & swoh) != 0));
    assign take_p_4 = ((sv & soh[4]) & ((p_4_w_ready & swoh) != 0));
    assign take = ((((take_p_0 | take_p_1) | take_p_2) | take_p_3) | take_p_4);
    assign p_0_w_valid = (sv & (sport == 0));
    assign p_0_w_id = swid;
    assign p_0_w_strb = sstrb[127:0];
    assign p_1_w_valid = (sv & (sport == 1));
    assign p_1_w_id = swid;
    assign p_1_w_strb = sstrb[63:0];
    assign p_2_w_valid = (sv & (sport == 2));
    assign p_2_w_id = swid;
    assign p_2_w_strb = sstrb[63:0];
    assign p_3_w_valid = (sv & (sport == 3));
    assign p_3_w_id = swid;
    assign p_3_w_strb = sstrb[127:0];
    assign p_4_w_valid = (sv & (sport == 4));
    assign p_4_w_id = swid;
    assign p_4_w_strb = sstrb[127:0];
    assign s_rq = ((sport == 0) ? rq_0 :
                  ((sport == 1) ? rq_1 :
                  ((sport == 2) ? rq_2 :
                  ((sport == 3) ? rq_3 :
                  ((sport == 4) ? rq_4 :
                  8'd0)))));
    assign s_rqsh = (s_rq >> swid);
    assign drop = ((sv & (~take)) & (~s_rqsh[0]));
    assign w_new_any = ((((pt_0_wwant | pt_1_wwant) | pt_2_wwant) | pt_3_wwant) | pt_4_wwant);
    assign w_new_p = (pt_0_wwant ? 3'd0 : (pt_1_wwant ? 3'd1 : (pt_2_wwant ? 3'd2 : (pt_3_wwant ? 3'd3 : 3'd4))));
    assign f_go = (((~sv) & (~b_re)) & w_new_any);
    assign f_p = w_new_p;
    assign f_raddr = ((f_p == 0) ? pt_0_d_raddr :
                     ((f_p == 1) ? pt_1_d_raddr :
                     ((f_p == 2) ? pt_2_d_raddr :
                     ((f_p == 3) ? pt_3_d_raddr :
                     ((f_p == 4) ? pt_4_d_raddr :
                     7'd0)))));
    assign f_strb = ((f_p == 0) ? pt_0_d_strb :
                    ((f_p == 1) ? pt_1_d_strb :
                    ((f_p == 2) ? pt_2_d_strb :
                    ((f_p == 3) ? pt_3_d_strb :
                    ((f_p == 4) ? pt_4_d_strb :
                    128'd0)))));
    assign f_wid = ((f_p == 0) ? pt_0_hc_wid :
                   ((f_p == 1) ? pt_1_hc_wid :
                   ((f_p == 2) ? pt_2_hc_wid :
                   ((f_p == 3) ? pt_3_hc_wid :
                   ((f_p == 4) ? pt_4_hc_wid :
                   4'd0)))));
    assign buf_ren = (b_re | f_go);
    assign buf_raddr = (b_re ? b_addr[11:5] : f_raddr);
    assign buf_rdata = {u_buf_1_rdata, u_buf_0_rdata};
    assign p_0_w_data = buf_rdata[1023:0];
    assign p_1_w_data = buf_rdata[511:0];
    assign p_2_w_data = buf_rdata[511:0];
    assign p_3_w_data = buf_rdata[1023:0];
    assign p_4_w_data = buf_rdata[1023:0];
    assign b_rdata = (fwd_q ? fwd_d :
                     ((b_word_q == 0) ? buf_rdata[31:0] :
                     ((b_word_q == 1) ? buf_rdata[63:32] :
                     ((b_word_q == 2) ? buf_rdata[95:64] :
                     ((b_word_q == 3) ? buf_rdata[127:96] :
                     ((b_word_q == 4) ? buf_rdata[159:128] :
                     ((b_word_q == 5) ? buf_rdata[191:160] :
                     ((b_word_q == 6) ? buf_rdata[223:192] :
                     ((b_word_q == 7) ? buf_rdata[255:224] :
                     ((b_word_q == 8) ? buf_rdata[287:256] :
                     ((b_word_q == 9) ? buf_rdata[319:288] :
                     ((b_word_q == 10) ? buf_rdata[351:320] :
                     ((b_word_q == 11) ? buf_rdata[383:352] :
                     ((b_word_q == 12) ? buf_rdata[415:384] :
                     ((b_word_q == 13) ? buf_rdata[447:416] :
                     ((b_word_q == 14) ? buf_rdata[479:448] :
                     ((b_word_q == 15) ? buf_rdata[511:480] :
                     ((b_word_q == 16) ? buf_rdata[543:512] :
                     ((b_word_q == 17) ? buf_rdata[575:544] :
                     ((b_word_q == 18) ? buf_rdata[607:576] :
                     ((b_word_q == 19) ? buf_rdata[639:608] :
                     ((b_word_q == 20) ? buf_rdata[671:640] :
                     ((b_word_q == 21) ? buf_rdata[703:672] :
                     ((b_word_q == 22) ? buf_rdata[735:704] :
                     ((b_word_q == 23) ? buf_rdata[767:736] :
                     ((b_word_q == 24) ? buf_rdata[799:768] :
                     ((b_word_q == 25) ? buf_rdata[831:800] :
                     ((b_word_q == 26) ? buf_rdata[863:832] :
                     ((b_word_q == 27) ? buf_rdata[895:864] :
                     ((b_word_q == 28) ? buf_rdata[927:896] :
                     ((b_word_q == 29) ? buf_rdata[959:928] :
                     ((b_word_q == 30) ? buf_rdata[991:960] :
                     buf_rdata[1023:992]))))))))))))))))))))))))))))))));
    assign hl_any = ((((((~pt_0_hc_v) & (pt_0_wf_cnt != 0)) | ((~pt_1_hc_v) & (pt_1_wf_cnt != 0)))
                     | ((~pt_2_hc_v) & (pt_2_wf_cnt != 0))) | ((~pt_3_hc_v) & (pt_3_wf_cnt != 0)))
                     | ((~pt_4_hc_v) & (pt_4_wf_cnt != 0)));
    assign hl_p = (((~pt_0_hc_v) & (pt_0_wf_cnt != 0)) ? 3'd0 :
                  (((~pt_1_hc_v) & (pt_1_wf_cnt != 0)) ? 3'd1 :
                  (((~pt_2_hc_v) & (pt_2_wf_cnt != 0)) ? 3'd2 :
                  (((~pt_3_hc_v) & (pt_3_wf_cnt != 0)) ? 3'd3 :
                  3'd4))));
    assign hl_h = wf[{hl_p, ((hl_p == 0) ? pt_0_wf_rp : ((hl_p == 1) ? pt_1_wf_rp : ((hl_p == 2) ? pt_2_wf_rp : ((hl_p == 3) ? pt_3_wf_rp : ((hl_p == 4) ? pt_4_wf_rp : 4'd0)))))}];
    assign hl_nar = ((hl_p == 0) ? 1'd0 :
                    ((hl_p == 1) ? 1'd1 :
                    ((hl_p == 2) ? 1'd1 :
                    ((hl_p == 3) ? 1'd0 :
                    ((hl_p == 4) ? 1'd0 :
                    1'd0)))));
    assign hl_rb1 = (c_rb[hl_h] - 1);
    assign hl_sh = (hl_nar ? {1'd0, c_sh[hl_h][5:0]} : c_sh[hl_h]);
    assign hl_e = (hl_nar ? {1'd0, c_e[hl_h][5:0]} : c_e[hl_h]);
    assign hl_wid = c_wid[hl_h];
    assign hl_nb = c_nb[hl_h];
    assign hl_off = c_off[hl_h];
    assign hl_a8 = c_addr[hl_h][7:0];
    assign hl_s8 = c_stride[hl_h][7:0];
    assign s_nar = ((s_port == 0) ? 1'd0 :
                   ((s_port == 1) ? 1'd1 :
                   ((s_port == 2) ? 1'd1 :
                   ((s_port == 3) ? 1'd0 :
                   ((s_port == 4) ? 1'd0 :
                   1'd0)))));
    assign s_rbn = (({15'd0, s_addr[5:0]} + {1'd0, s_bytes}) + 63);
    assign s_rbsum = (s_nar ? {s_rbn[19:0], 1'd0} : (({14'd0, s_addr[6:0]} + {1'd0, s_bytes}) + 127));
    assign s_esum = (({2'd0, s_addr[6:0]} + {2'd0, s_bytes[6:0]}) + 127);
    assign go_c = (((((hw_en & (hw_addr == 0)) & hw_data[0]) & (~busy)) & calib) & (n_cmd != 0));
    assign done_c = (((busy & (ip == n_cmd)) & (n_rlast == n_rd)) & (n_b == n_wr));
    assign b_any = ((((p_0_b_valid | p_1_b_valid) | p_2_b_valid) | p_3_b_valid) | p_4_b_valid);
    assign b_sum = (((({2'd0, p_0_b_valid} + {2'd0, p_1_b_valid}) + {2'd0, p_2_b_valid}) + {2'd0, p_3_b_valid})
                    + {2'd0, p_4_b_valid});
    assign a_sum = (((({2'd0, p_0_a_valid} + {2'd0, p_1_a_valid}) + {2'd0, p_2_a_valid}) + {2'd0, p_3_a_valid})
                    + {2'd0, p_4_a_valid});
    assign h_rdata = ((h_raddr == 0) ? {8'd0, {1'd0, n_issued}, {1'd0, n_cmd}, 5'd0, calib, done, busy} :
                     ((h_raddr == 1) ? s_addr[31:0] :
                     ((h_raddr == 2) ? {16'd0, s_addr[47:32]} :
                     ((h_raddr == 3) ? {12'd0, s_bytes} :
                     ((h_raddr == 4) ? {16'd0, s_rows} :
                     ((h_raddr == 5) ? {12'd0, s_stride} :
                     ((h_raddr == 6) ? {s_nb, s_off, 4'd0, s_wid, 3'd0, s_dir, 1'd0, s_port} :
                     ((h_raddr == 7) ? 32'd0 :
                     ((h_raddr == 8) ? {25'd0, n_cmd} :
                     ((h_raddr == 9) ? {25'd0, n_issued} :
                     ((h_raddr == 10) ? {25'd0, n_rlast} :
                     ((h_raddr == 11) ? {25'd0, n_b} :
                     ((h_raddr == 12) ? {16'd0, n_admit} :
                     ((h_raddr == 13) ? {16'd0, n_rbeats} :
                     ((h_raddr == 14) ? t_first :
                     ((h_raddr == 15) ? t_all :
                     ((h_raddr == 16)
                      ? {7'd0, {2'd0, credit_4}, {2'd0, credit_3}, {2'd0, credit_2}, {2'd0, credit_1}, {2'd0, credit_0}}
                      :
                     ((h_raddr == 17) ? {16'd0, n_wbeats} :
                     ((h_raddr == 18) ? {9'd0, n_wr, 9'd0, n_rd} :
                     ((h_raddr == 19) ? {7'd0, pt_4_wf_cnt, pt_3_wf_cnt, pt_2_wf_cnt, pt_1_wf_cnt, pt_0_wf_cnt} :
                     32'd0))))))))))))))))))));
    assign k = n_cmd[5:0];
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            hw_en <= 0;
            hw_addr <= 0;
            hw_data <= 0;
            hb_we <= 0;
            fwd_q <= 0;
            s_addr <= 0;
            s_bytes <= 0;
            s_rows <= 1;
            s_stride <= 0;
            s_nb <= 0;
            s_off <= 0;
            s_wid <= 0;
            s_dir <= 0;
            s_port <= 0;
            n_cmd <= 0;
            n_wr <= 0;
            n_rd <= 0;
            done <= 0;
            n_issued <= 0;
            n_rlast <= 0;
            n_b <= 0;
            n_admit <= 0;
            n_rbeats <= 0;
            n_wbeats <= 0;
            t_first <= 0;
            t_all <= 0;
            t <= 0;
            t_first_v <= 0;
            rl_v <= 0;
            ip <= 0;
            credit_0 <= 4;
            pt_0_wf_wp <= 0;
            pt_0_wf_cnt <= 0;
            pt_0_rcnt <= 0;
            pt_0_wcnt <= 0;
            pt_0_wrow <= 0;
            pt_0_wf_rp <= 0;
            pt_0_hc_v <= 0;
            pt_0_ra8 <= 0;
            pt_0_hc_wid <= 0;
            pt_0_hc_nb <= 0;
            pt_0_hc_rb1 <= 0;
            pt_0_hc_sh <= 0;
            pt_0_hc_e <= 0;
            pt_0_hc_off <= 0;
            pt_0_hc_a8 <= 0;
            pt_0_hc_s8 <= 0;
            credit_1 <= 4;
            pt_1_wf_wp <= 0;
            pt_1_wf_cnt <= 0;
            pt_1_rcnt <= 0;
            pt_1_wcnt <= 0;
            pt_1_wrow <= 0;
            pt_1_wf_rp <= 0;
            pt_1_hc_v <= 0;
            pt_1_ra8 <= 0;
            pt_1_hc_wid <= 0;
            pt_1_hc_nb <= 0;
            pt_1_hc_rb1 <= 0;
            pt_1_hc_sh <= 0;
            pt_1_hc_e <= 0;
            pt_1_hc_off <= 0;
            pt_1_hc_a8 <= 0;
            pt_1_hc_s8 <= 0;
            credit_2 <= 4;
            pt_2_wf_wp <= 0;
            pt_2_wf_cnt <= 0;
            pt_2_rcnt <= 0;
            pt_2_wcnt <= 0;
            pt_2_wrow <= 0;
            pt_2_wf_rp <= 0;
            pt_2_hc_v <= 0;
            pt_2_ra8 <= 0;
            pt_2_hc_wid <= 0;
            pt_2_hc_nb <= 0;
            pt_2_hc_rb1 <= 0;
            pt_2_hc_sh <= 0;
            pt_2_hc_e <= 0;
            pt_2_hc_off <= 0;
            pt_2_hc_a8 <= 0;
            pt_2_hc_s8 <= 0;
            credit_3 <= 4;
            pt_3_wf_wp <= 0;
            pt_3_wf_cnt <= 0;
            pt_3_rcnt <= 0;
            pt_3_wcnt <= 0;
            pt_3_wrow <= 0;
            pt_3_wf_rp <= 0;
            pt_3_hc_v <= 0;
            pt_3_ra8 <= 0;
            pt_3_hc_wid <= 0;
            pt_3_hc_nb <= 0;
            pt_3_hc_rb1 <= 0;
            pt_3_hc_sh <= 0;
            pt_3_hc_e <= 0;
            pt_3_hc_off <= 0;
            pt_3_hc_a8 <= 0;
            pt_3_hc_s8 <= 0;
            credit_4 <= 4;
            pt_4_wf_wp <= 0;
            pt_4_wf_cnt <= 0;
            pt_4_rcnt <= 0;
            pt_4_wcnt <= 0;
            pt_4_wrow <= 0;
            pt_4_wf_rp <= 0;
            pt_4_hc_v <= 0;
            pt_4_ra8 <= 0;
            pt_4_hc_wid <= 0;
            pt_4_hc_nb <= 0;
            pt_4_hc_rb1 <= 0;
            pt_4_hc_sh <= 0;
            pt_4_hc_e <= 0;
            pt_4_hc_off <= 0;
            pt_4_hc_a8 <= 0;
            pt_4_hc_s8 <= 0;
            rq_0 <= 0;
            rq_1 <= 0;
            rq_2 <= 0;
            rq_3 <= 0;
            rq_4 <= 0;
            sv <= 0;
            sport <= 0;
            soh <= 0;
            swoh <= 0;
            swid <= 0;
            sstrb <= 0;
            b_word_q <= 0;
            busy <= 0;
        end else begin
            hw_en <= h_wen;
            hw_addr <= h_addr;
            hw_data <= h_wdata;
            hb_we <= b_we;
            fwd_q <= fwd;
            if (hw_en) begin
                if ((hw_addr == 1)) begin
                    s_addr <= {s_addr[47:32], hw_data};
                end else begin
                    if ((hw_addr == 2)) begin
                        s_addr <= {hw_data[15:0], s_addr[31:0]};
                    end else begin
                        if ((hw_addr == 3)) begin
                            s_bytes <= hw_data[19:0];
                        end else begin
                            if ((hw_addr == 4)) begin
                                s_rows <= hw_data[15:0];
                            end else begin
                                if ((hw_addr == 5)) begin
                                    s_stride <= hw_data[19:0];
                                end else begin
                                    if ((hw_addr == 6)) begin
                                        s_nb <= hw_data[31:24];
                                        s_off <= hw_data[23:16];
                                        s_wid <= hw_data[11:8];
                                        s_dir <= hw_data[4];
                                        s_port <= hw_data[2:0];
                                    end else begin
                                        if ((hw_addr == 7)) begin
                                            if (((n_cmd != 64) & (~busy))) begin
                                                n_cmd <= (n_cmd + 1);
                                                if (s_dir) begin
                                                    n_wr <= (n_wr + 1);
                                                end else begin
                                                    n_rd <= (n_rd + 1);
                                                end
                                            end
                                        end else begin
                                            if ((hw_addr == 0)) begin
                                                if ((hw_data[1] & (~busy))) begin
                                                    n_cmd <= 0;
                                                    n_rd <= 0;
                                                    n_wr <= 0;
                                                    done <= 0;
                                                    n_issued <= 0;
                                                    n_rlast <= 0;
                                                    n_b <= 0;
                                                    n_admit <= 0;
                                                    n_rbeats <= 0;
                                                    n_wbeats <= 0;
                                                    t_first <= 0;
                                                    t_all <= 0;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            t <= (t + 1);
            n_admit <= (n_admit + {13'd0, a_sum});
            n_b <= (n_b + {4'd0, b_sum});
            if (r_any) begin
                n_rbeats <= (n_rbeats + 1);
                n_rlast <= (n_rlast + {6'd0, r_last});
            end
            if (((r_any | b_any) & (~t_first_v))) begin
                t_first_v <= 1;
                t_first <= t;
            end
            if (r_any) begin
                rl_v <= 1;
            end else begin
                if ((~hb_we)) begin
                    rl_v <= 0;
                end
            end
            if (acc_any) begin
                ip <= (ip + 1);
                n_issued <= (n_issued + 1);
            end
            credit_0 <= ((credit_0 + {2'd0, p_0_a_valid}) - {2'd0, pt_0_acc});
            if ((pt_0_acc & i_dir)) begin
                pt_0_wf_wp <= (pt_0_wf_wp + 1);
            end
            pt_0_wf_cnt <= ((pt_0_wf_cnt + {4'd0, (pt_0_acc & i_dir)}) - {4'd0, (take_p_0 & pt_0_d_lastb)});
            if (pt_0_rsel) begin
                if (p_0_r_last) begin
                    pt_0_rcnt <= 0;
                end else begin
                    pt_0_rcnt <= (pt_0_rcnt + 1);
                end
            end
            if (take_p_0) begin
                if (pt_0_d_lastb) begin
                    pt_0_wcnt <= 0;
                    pt_0_wrow <= 0;
                    pt_0_wf_rp <= (pt_0_wf_rp + 1);
                    pt_0_hc_v <= 0;
                end else begin
                    pt_0_wcnt <= (pt_0_wcnt + 1);
                    if (pt_0_d_rowend) begin
                        pt_0_wrow <= 0;
                        pt_0_ra8 <= pt_0_d_ra8n;
                    end else begin
                        pt_0_wrow <= (pt_0_wrow + 1);
                        pt_0_ra8 <= pt_0_d_ra8;
                    end
                end
            end else begin
                if ((hl_any & (hl_p == 0))) begin
                    pt_0_hc_v <= 1;
                    pt_0_hc_wid <= hl_wid;
                    pt_0_hc_nb <= hl_nb;
                    pt_0_hc_rb1 <= hl_rb1;
                    pt_0_hc_sh <= hl_sh;
                    pt_0_hc_e <= hl_e;
                    pt_0_hc_off <= hl_off;
                    pt_0_hc_a8 <= hl_a8;
                    pt_0_hc_s8 <= hl_s8;
                end
            end
            credit_1 <= ((credit_1 + {2'd0, p_1_a_valid}) - {2'd0, pt_1_acc});
            if ((pt_1_acc & i_dir)) begin
                pt_1_wf_wp <= (pt_1_wf_wp + 1);
            end
            pt_1_wf_cnt <= ((pt_1_wf_cnt + {4'd0, (pt_1_acc & i_dir)}) - {4'd0, (take_p_1 & pt_1_d_lastb)});
            if (pt_1_rsel) begin
                if (p_1_r_last) begin
                    pt_1_rcnt <= 0;
                end else begin
                    pt_1_rcnt <= (pt_1_rcnt + 1);
                end
            end
            if (take_p_1) begin
                if (pt_1_d_lastb) begin
                    pt_1_wcnt <= 0;
                    pt_1_wrow <= 0;
                    pt_1_wf_rp <= (pt_1_wf_rp + 1);
                    pt_1_hc_v <= 0;
                end else begin
                    pt_1_wcnt <= (pt_1_wcnt + 1);
                    if (pt_1_d_rowend) begin
                        pt_1_wrow <= 0;
                        pt_1_ra8 <= pt_1_d_ra8n;
                    end else begin
                        pt_1_wrow <= (pt_1_wrow + 1);
                        pt_1_ra8 <= pt_1_d_ra8;
                    end
                end
            end else begin
                if ((hl_any & (hl_p == 1))) begin
                    pt_1_hc_v <= 1;
                    pt_1_hc_wid <= hl_wid;
                    pt_1_hc_nb <= hl_nb;
                    pt_1_hc_rb1 <= hl_rb1;
                    pt_1_hc_sh <= hl_sh;
                    pt_1_hc_e <= hl_e;
                    pt_1_hc_off <= hl_off;
                    pt_1_hc_a8 <= hl_a8;
                    pt_1_hc_s8 <= hl_s8;
                end
            end
            credit_2 <= ((credit_2 + {2'd0, p_2_a_valid}) - {2'd0, pt_2_acc});
            if ((pt_2_acc & i_dir)) begin
                pt_2_wf_wp <= (pt_2_wf_wp + 1);
            end
            pt_2_wf_cnt <= ((pt_2_wf_cnt + {4'd0, (pt_2_acc & i_dir)}) - {4'd0, (take_p_2 & pt_2_d_lastb)});
            if (pt_2_rsel) begin
                if (p_2_r_last) begin
                    pt_2_rcnt <= 0;
                end else begin
                    pt_2_rcnt <= (pt_2_rcnt + 1);
                end
            end
            if (take_p_2) begin
                if (pt_2_d_lastb) begin
                    pt_2_wcnt <= 0;
                    pt_2_wrow <= 0;
                    pt_2_wf_rp <= (pt_2_wf_rp + 1);
                    pt_2_hc_v <= 0;
                end else begin
                    pt_2_wcnt <= (pt_2_wcnt + 1);
                    if (pt_2_d_rowend) begin
                        pt_2_wrow <= 0;
                        pt_2_ra8 <= pt_2_d_ra8n;
                    end else begin
                        pt_2_wrow <= (pt_2_wrow + 1);
                        pt_2_ra8 <= pt_2_d_ra8;
                    end
                end
            end else begin
                if ((hl_any & (hl_p == 2))) begin
                    pt_2_hc_v <= 1;
                    pt_2_hc_wid <= hl_wid;
                    pt_2_hc_nb <= hl_nb;
                    pt_2_hc_rb1 <= hl_rb1;
                    pt_2_hc_sh <= hl_sh;
                    pt_2_hc_e <= hl_e;
                    pt_2_hc_off <= hl_off;
                    pt_2_hc_a8 <= hl_a8;
                    pt_2_hc_s8 <= hl_s8;
                end
            end
            credit_3 <= ((credit_3 + {2'd0, p_3_a_valid}) - {2'd0, pt_3_acc});
            if ((pt_3_acc & i_dir)) begin
                pt_3_wf_wp <= (pt_3_wf_wp + 1);
            end
            pt_3_wf_cnt <= ((pt_3_wf_cnt + {4'd0, (pt_3_acc & i_dir)}) - {4'd0, (take_p_3 & pt_3_d_lastb)});
            if (pt_3_rsel) begin
                if (p_3_r_last) begin
                    pt_3_rcnt <= 0;
                end else begin
                    pt_3_rcnt <= (pt_3_rcnt + 1);
                end
            end
            if (take_p_3) begin
                if (pt_3_d_lastb) begin
                    pt_3_wcnt <= 0;
                    pt_3_wrow <= 0;
                    pt_3_wf_rp <= (pt_3_wf_rp + 1);
                    pt_3_hc_v <= 0;
                end else begin
                    pt_3_wcnt <= (pt_3_wcnt + 1);
                    if (pt_3_d_rowend) begin
                        pt_3_wrow <= 0;
                        pt_3_ra8 <= pt_3_d_ra8n;
                    end else begin
                        pt_3_wrow <= (pt_3_wrow + 1);
                        pt_3_ra8 <= pt_3_d_ra8;
                    end
                end
            end else begin
                if ((hl_any & (hl_p == 3))) begin
                    pt_3_hc_v <= 1;
                    pt_3_hc_wid <= hl_wid;
                    pt_3_hc_nb <= hl_nb;
                    pt_3_hc_rb1 <= hl_rb1;
                    pt_3_hc_sh <= hl_sh;
                    pt_3_hc_e <= hl_e;
                    pt_3_hc_off <= hl_off;
                    pt_3_hc_a8 <= hl_a8;
                    pt_3_hc_s8 <= hl_s8;
                end
            end
            credit_4 <= ((credit_4 + {2'd0, p_4_a_valid}) - {2'd0, pt_4_acc});
            if ((pt_4_acc & i_dir)) begin
                pt_4_wf_wp <= (pt_4_wf_wp + 1);
            end
            pt_4_wf_cnt <= ((pt_4_wf_cnt + {4'd0, (pt_4_acc & i_dir)}) - {4'd0, (take_p_4 & pt_4_d_lastb)});
            if (pt_4_rsel) begin
                if (p_4_r_last) begin
                    pt_4_rcnt <= 0;
                end else begin
                    pt_4_rcnt <= (pt_4_rcnt + 1);
                end
            end
            if (take_p_4) begin
                if (pt_4_d_lastb) begin
                    pt_4_wcnt <= 0;
                    pt_4_wrow <= 0;
                    pt_4_wf_rp <= (pt_4_wf_rp + 1);
                    pt_4_hc_v <= 0;
                end else begin
                    pt_4_wcnt <= (pt_4_wcnt + 1);
                    if (pt_4_d_rowend) begin
                        pt_4_wrow <= 0;
                        pt_4_ra8 <= pt_4_d_ra8n;
                    end else begin
                        pt_4_wrow <= (pt_4_wrow + 1);
                        pt_4_ra8 <= pt_4_d_ra8;
                    end
                end
            end else begin
                if ((hl_any & (hl_p == 4))) begin
                    pt_4_hc_v <= 1;
                    pt_4_hc_wid <= hl_wid;
                    pt_4_hc_nb <= hl_nb;
                    pt_4_hc_rb1 <= hl_rb1;
                    pt_4_hc_sh <= hl_sh;
                    pt_4_hc_e <= hl_e;
                    pt_4_hc_off <= hl_off;
                    pt_4_hc_a8 <= hl_a8;
                    pt_4_hc_s8 <= hl_s8;
                end
            end
            rq_0 <= p_0_w_ready;
            rq_1 <= p_1_w_ready;
            rq_2 <= p_2_w_ready;
            rq_3 <= p_3_w_ready;
            rq_4 <= p_4_w_ready;
            if (f_go) begin
                sv <= 1;
                sport <= f_p;
                soh <= (5'd1 << f_p);
                swoh <= (8'd1 << f_wid[2:0]);
                swid <= f_wid;
                sstrb <= f_strb;
            end else begin
                if ((take | drop)) begin
                    sv <= 0;
                end
            end
            if (take) begin
                n_wbeats <= (n_wbeats + 1);
            end
            if (b_re) begin
                b_word_q <= b_addr[4:0];
            end
            if (go_c) begin
                busy <= 1;
                done <= 0;
                ip <= 0;
                t <= 0;
                t_first_v <= 0;
                t_first <= 0;
                t_all <= 0;
                n_issued <= 0;
                n_rlast <= 0;
                n_b <= 0;
                n_admit <= 0;
                n_rbeats <= 0;
                n_wbeats <= 0;
            end else begin
                if (done_c) begin
                    busy <= 0;
                    done <= 1;
                    t_all <= t;
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        hb_addr <= b_addr;
        hb_wdata <= b_wdata;
        if (fwd) begin
            fwd_d <= hb_wdata;
        end
        if (hw_en) begin
            if ((!(hw_addr == 1))) begin
                if ((!(hw_addr == 2))) begin
                    if ((!(hw_addr == 3))) begin
                        if ((!(hw_addr == 4))) begin
                            if ((!(hw_addr == 5))) begin
                                if ((!(hw_addr == 6))) begin
                                    if ((hw_addr == 7)) begin
                                        if (((n_cmd != 64) & (~busy))) begin
                                            c_port[k] <= s_port;
                                            c_dir[k] <= s_dir;
                                            c_wid[k] <= s_wid;
                                            c_addr[k] <= s_addr;
                                            c_bytes[k] <= s_bytes;
                                            c_rows[k] <= s_rows;
                                            c_stride[k] <= s_stride;
                                            c_off[k] <= s_off;
                                            c_nb[k] <= s_nb;
                                            c_rb[k] <= s_rbsum[14:7];
                                            c_sh[k] <= s_addr[6:0];
                                            c_e[k] <= s_esum[6:0];
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if (r_any) begin
            rl_waddr <= r_waddr;
            rl_data <= r_data;
        end
        if (acc_any) begin
            if (i_dir) begin
                wf[wf_widx] <= ip[5:0];
            end
        end
    end

    NocDramSram #(.DEPTH(128), .AW(7)) u_buf_0 (
        .clk(clk),
        .wen(buf_wen),
        .waddr(buf_waddr),
        .wdata(buf_wdata[511:0]),
        .wstrb(buf_wstrb[63:0]),
        .ren(buf_ren),
        .raddr(buf_raddr),
        .rdata(u_buf_0_rdata)
    );
    NocDramSram #(.DEPTH(128), .AW(7)) u_buf_1 (
        .clk(clk),
        .wen(buf_wen),
        .waddr(buf_waddr),
        .wdata(buf_wdata[1023:512]),
        .wstrb(buf_wstrb[127:64]),
        .ren(buf_ren),
        .raddr(buf_raddr),
        .rdata(u_buf_1_rdata)
    );
endmodule
