module Rv32Core #(
    parameter PREDICT = 2,
    parameter TRACE = 0,
    parameter MUL_SERIAL = 0,
    parameter PERF = 0,
    parameter CORE_OPT = 0
) (
    input clk,
    input rst_n,
    input [31:0] if_inst,
    input [17:0] if_prediction,
    input [13:0] predict_waddr,
    input [31:0] predict_wdata,
    output logic [17:0] predict_write,
    input [31:0] dlm_rdata,
    input [3:0] dlm_zero_bytes,
    input dlm_local_hint,
    input [31:0] zero_wdata,
    output logic [3:0] zero_write,
    output logic local_tag_write,
    input [31:0] csr_rdata,
    input ext_rd_ok,
    input ext_dat_ok,
    input ext_q_full,
    input [31:0] ext_rdata,
    input rom_ovr,
    input ilm_ovr,
    input [13:0] ovr_addr,
    input dbg_stop,
    input dbg_step,
    input dbg_pc_wen,
    input dbg_x_wen,
    input [4:0] dbg_x_idx,
    input [31:0] dbg_wdata,
    output logic [11:0] csr_paddr,
    output logic [4:0] csr_pgi_a,
    output logic [4:0] csr_pgi_b,
    output logic [11:0] csr_addr,
    output logic csr_en,
    output logic csr_wen,
    output logic [31:0] csr_wdata,
    output logic [31:0] csr_wo,
    output logic [2:0] ext_kind,
    output logic [31:0] ext_addr,
    output logic [31:0] ext_wdata,
    output logic ext_w2,
    output logic ext_w3,
    output logic ext_wq,
    output logic dlm_re,
    output logic [11:0] dlm_raddr,
    output logic dlm_we,
    output logic dlm_wclaim,
    output logic [11:0] dlm_waddr,
    output logic [3:0] dlm_wbe,
    output logic [31:0] dlm_wdata,
    output logic if_read,
    output logic [9:0] if_raddr,
    output logic [13:0] if_iaddr,
    output logic if_rom,
    output logic [31:0] if_pc,
    output logic quiet,
    output logic retire,
    output logic [31:0] dbg_x_rdata,
    output logic i_valid,
    output logic [31:0] i_addr,
    output logic d_valid,
    output logic d_write,
    output logic d_store_valid,
    output logic [31:0] d_addr,
    output logic d_address_forward,
    output logic [14:0] d_store_word,
    output logic d_store_local,
    output logic [31:0] d_wdata,
    output logic [7:0] d_byte,
    output logic [3:0] d_wstrb,
    output logic [2:0] d_f3,
    output logic halt_o,
    output logic [3:0] cause_o,
    output logic [31:0] trap_pc_o,
    output logic [31:0] trap_value_o,
    output logic [63:0] retired_o,
    output logic [63:0] load_stalls_o,
    output logic [63:0] muldiv_stalls_o,
    output logic [63:0] redirects_o,
    output logic trace_valid,
    output logic [31:0] trace_pc,
    output logic [31:0] trace_inst,
    output logic [4:0] trace_rd,
    output logic [31:0] trace_data,
    output logic trace_store,
    output logic [31:0] trace_addr,
    output logic [31:0] trace_wdata,
    output logic [3:0] trace_mask,
    output logic trace_trap
);
    logic [29:0] predict_write_target;
    logic i_ready;
    logic [31:0] i_data;
    logic i_error;
    logic i_retry;
    logic memory_prepared;
    logic memory_ctrl;
    logic memory_data;
    logic memory_local_saved;
    logic memory_ctrl_number_saved;
    logic memory_fault_saved;
    logic [31:0] memory_address;
    logic [31:0] memory_write_data;
    logic d_ready;
    logic response_external;
    logic response_local_hint;
    logic [31:0] response_data;
    logic response_error;
    logic [31:0] d_data;
    logic d_error;
    logic local_word_zero;
    logic [1:0] d_zero_hint;
    logic d_byte_pause;
    logic step_credit;
    logic csr_prepared;
    logic fetch_rom;
    logic [29:0] pc;
    logic pc_pending;
    logic halted;
    logic d_v;
    logic [29:0] d_pc;
    logic [31:0] d_predicted;
    logic e_v;
    logic e_pending;
    logic e_bank_pending;
    logic [29:0] e_pc;
    logic [31:0] e_inst;
    logic e_use_imm;
    logic e_subtract;
    logic e_branch;
    logic e_jalr;
    logic [4:0] e_immlow;
    logic [31:0] e_a;
    logic [31:0] e_b;
    logic e_forward_a;
    logic e_forward_b;
    logic [31:0] e_predicted;
    logic e_pred_taken;
    logic e_control;
    logic e_zero_branch;
    logic e_zero_invert;
    logic e_address_forward;
    logic e_fetch_error;
    logic e_is_md;
    logic e_is_sb;
    logic md_started;
    logic w_v;
    logic [29:0] w_pc;
    logic [31:0] w_inst;
    logic [4:0] w_rd;
    logic w_writes;
    logic w_load;
    logic w_store;
    logic [31:0] w_result;
    logic [31:0] w_data;
    logic [3:0] w_mask;
    logic [2:0] w_f3;
    logic w_trap;
    logic [3:0] w_cause;
    logic w_taken;
    logic [31:0] w_target;
    logic stop_bus_error;
    logic [63:0] retired;
    logic [63:0] stalls_load;
    logic [63:0] stalls_muldiv;
    logic [63:0] redirects;
    logic [31:0] pc_address;
    logic [31:0] d_pc_address;
    logic [31:0] e_pc_address;
    logic [31:0] w_pc_address;
    logic [31:0] response_shifted;
    logic [15:0] response_half;
    logic [7:0] response_byte;
    logic response_sign_byte;
    logic response_sign_half;
    logic response_sign;
    logic [31:0] response_aligned_value;
    logic [31:0] wb_data;
    logic wb_bus_error;
    logic wb_stop;
    logic wb_write;
    logic wb_forward;
    logic wb_operand_forward;
    logic [31:0] rf [0:31];
    logic rf_write;
    logic [4:0] rf_address;
    logic [31:0] rf_write_data;
    logic [4:0] read_b_address;
    logic bank_conflict;
    logic [31:0] rf_value_a;
    logic [31:0] rf_value_b;
    logic [31:0] ex_a;
    logic [31:0] ex_b;
    logic [11:0] immediate;
    logic [31:0] upper_immediate;
    logic [31:0] alu_b;
    logic [31:0] forwarded_address;
    logic [31:0] ea;
    logic [12:0] ex_bimm;
    logic [20:0] ex_jimm;
    logic [31:0] ex_relative;
    logic [17:0] store_low_sum;
    logic store_high_zero;
    logic store_high_max;
    logic [31:0] integer_result;
    logic [3:0] response_zero_mask;
    logic local_loaded_zero;
    logic loaded_zero;
    logic branch_equal_high;
    logic branch_equal_low;
    logic branch_equal;
    logic branch_unsigned;
    logic branch_signed;
    logic branch_less;
    logic plain_branch_condition;
    logic branch_condition;
    logic taken;
    logic [31:0] target;
    logic [31:0] actual_next;
    logic [1:0] memory_low;
    logic misaligned_data;
    logic memory_alignment;
    logic misaligned_store;
    logic misaligned_pc;
    logic ex_trap;
    logic memory_fault;
    logic memory_request_fault;
    logic csr_fault;
    logic [3:0] ex_cause;
    logic [31:0] ex_tval;
    logic address_spec_retry;
    logic native_ctrl_number;
    logic native_local;
    logic native_ctrl;
    logic native_ctrl_read;
    logic native_ctrl_write;
    logic native_data_read;
    logic native_unmapped;
    logic csr_write;
    logic [31:0] csr_source;
    logic csr_cdma;
    logic csr_cdma_write;
    logic csr_wait;
    logic [31:0] memory_shifted_write;
    logic external_request_valid;
    logic store_alignment;
    logic dlm_store_allowed;
    logic [31:0] fetch_address;
    logic [17:0] i_prediction;
    logic md_wb_a_small;
    logic md_wb_small;
    logic md_a_small;
    logic md_b_small;
    logic md_small_inputs;
    logic md_wait;
    logic response_pointer_local;
    logic memory_fast_local;
    logic memory_prepare;
    logic memory_wait;
    logic memory_commit;
    logic memory_response_error;
    logic byte_store_wait;
    logic hold;
    logic front_capture_slow;
    logic front_capture_small;
    logic front_capture_enable;
    logic front_hold;
    logic ex_fire;
    logic prediction_miss;
    logic control_fault;
    logic redirect_valid;
    logic ordinary_taken;
    logic ordinary_prediction_miss;
    logic local_prediction_miss;
    logic static_redirect_enable;
    logic address_replay;
    logic zero_redirect_enable;
    logic zero_redirect_when_zero;
    logic zero_redirect_when_nonzero;
    logic ordinary_redirect;
    logic static_prediction_redirect;
    logic redirect;
    logic depend_a;
    logic depend_b;
    logic dependency_producer;
    logic load_pending;
    logic address_forward;
    logic zero_branch_forward;
    logic load_hazard;
    logic fetch_retry;
    logic id_fire;
    logic id_control_legal;
    logic [31:0] return_target;
    logic return_free;
    logic id_lookup_enable;
    logic id_lookup_static;
    logic id_lookup_return;
    logic id_prediction;
    logic [31:0] id_static_target;
    logic [31:0] id_target;
    logic id_static;
    logic wb_control;
    logic [31:0] predicted_next;
    logic fast_taken;
    logic fast_branch_enable;
    logic fast_eq_normal;
    logic fast_eq_zero;
    logic fast_eq_request;
    logic fast_branch;
    logic fast_jalr;
    logic [31:0] fast_jalr_target;
    logic zero_hint_eligible;
    logic zero_hint_when_zero;
    logic zero_hint_when_nonzero;
    logic fast_zero_redirect;
    logic fast_fetch_zero;
    logic fast_fetch_nonzero;
    logic ex_fetch;
    logic [31:0] fast_recovery_next;
    logic [31:0] recovery_next;
    logic [31:0] sequential_fetch_address;
    logic [31:0] fast_fetch_target;
    logic [31:0] early_fetch_address;
    logic [31:0] i_fetch_address;
    logic if_fire;
    logic [31:0] result;
    logic jump_misaligned;
    logic normal_result_ok;
    logic [31:0] exception_wb_result;
    logic [31:0] wb_background;
    logic wb_md_result;
    logic [31:0] wb_payload;
    logic halt;
    logic retire_enable;
    logic capture_id;
    logic capture_hold;
    logic capture_wb_a;
    logic capture_wb_b;
    logic rf_capture_a;
    logic rf_capture_b;
    logic [31:0] holding_operand_a;
    logic [31:0] holding_operand_b;
    logic [31:0] operand_next_a;
    logic [31:0] operand_next_b;
    logic md_workspace_write;
    logic md_partial_capture;
    logic md_high_workspace;
    logic [29:0] pc_sequential_word;
    logic [29:0] pc_normal_word;
    logic [29:0] pc_next_word;
    logic [35:0] u_md_shared_left;
    logic [35:0] u_md_shared_right;
    logic u_md_shared_carry;
    logic [2:0] u_ex_f3;
    logic [31:0] u_alu_sum;
    logic [36:0] u_alu_shared_sum;
    logic u_id_md;
    logic u_id_store;
    logic [2:0] u_id_f3;
    logic u_id_immop;
    logic u_id_load;
    logic u_id_jalr;
    logic u_id_regop;
    logic u_id_br;
    logic u_id_jal;
    logic [4:0] u_ex_rd;
    logic u_ex_writes;
    logic u_ex_load;
    logic u_ex_store;
    logic [31:0] u_md_quotient_next;
    logic [31:0] u_gated_d_pc_q;
    logic [31:0] u_gated_e_pc_q;
    logic [31:0] u_gated_e_inst_q;
    logic [31:0] u_gated_e_use_imm_q;
    logic [31:0] u_gated_e_subtract_q;
    logic [31:0] u_gated_e_branch_q;
    logic [31:0] u_gated_e_jalr_q;
    logic [31:0] u_gated_e_immlow_q;
    logic [31:0] u_gated_e_pred_taken_q;
    logic [31:0] u_gated_e_control_q;
    logic [31:0] u_gated_e_zero_branch_q;
    logic [31:0] u_gated_e_fetch_error_q;
    logic [31:0] u_gated_e_is_md_q;
    logic [31:0] u_gated_e_is_sb_q;
    logic [31:0] u_gated_w_pc_q;
    logic [31:0] u_gated_w_rd_q;
    logic [31:0] u_gated_w_writes_q;
    logic [31:0] u_gated_w_load_q;
    logic [31:0] u_gated_w_store_q;
    logic [31:0] u_gated_w_result_q;
    logic [31:0] u_gated_w_f3_q;
    logic [31:0] u_gated_w_trap_q;
    logic [31:0] u_gated_w_cause_q;
    logic [4:0] u_id_rs2;
    logic [4:0] u_id_rs1;
    logic u_ex_auipc;
    logic u_ex_jal;
    logic u_ex_csr;
    logic u_ex_lui;
    logic u_ex_jalr;
    logic [31:0] u_alu_result;
    logic u_alu_less_unsigned;
    logic u_ex_br;
    logic u_ex_ebreak;
    logic u_ex_ecall;
    logic u_ex_legal;
    logic [4:0] u_ex_rs1;
    logic u_md_ready;
    logic u_md_ready_slow;
    logic u_md_small_eligible;
    logic [31:0] u_predictor_next_pc;
    logic u_alu_carry16;
    logic [31:0] u_md_result;
    logic u_ex_immop;
    logic u_ex_regop;
    logic [31:0] u_md_operand_next;
    logic u_md_accumulating;
    logic [31:0] u_md_high_accumulate;
    logic [35:0] u_md_partial_product;
    logic u_md_partial_capture;
    logic misaligned_data_c0;

    initial begin
        for (int _i = 0; _i < 32; _i++) rf[_i] = 32'd4294967295;
    end

    assign predict_write_target = ({16'd0, predict_waddr}
                                   + ((predict_wdata[6:0] == 111)
                                      ? {{11{predict_wdata[31]}},
                                         {predict_wdata[31], predict_wdata[19:12], predict_wdata[20],
                                          predict_wdata[30:22]}} :
                                     {{19{predict_wdata[31]}},
                                      {predict_wdata[31], predict_wdata[7], predict_wdata[30:25], predict_wdata[11:9]}}));
    assign predict_write = {1'd0, (predict_wdata == 32871),
                            {((((predict_wdata[6:0] == 111) | ((predict_wdata[6:0] == 99) & predict_wdata[31]))
                              & (~((predict_wdata[6:0] == 111) ? predict_wdata[21] : predict_wdata[8])))
                              & (predict_write_target[29:15] == 0)), predict_write_target[14:0]}};
    assign zero_write = {(zero_wdata[31:24] == 0), (zero_wdata[23:16] == 0), (zero_wdata[15:8] == 0),
                         (zero_wdata[7:0] == 0)};
    assign local_tag_write = (zero_wdata[23:16] == 64);
    assign i_ready = ((~rom_ovr) & (~ilm_ovr));
    assign i_data = (i_error ? 32'd0 : if_inst);
    assign i_retry = 1'd0;
    assign d_ready = (memory_fault_saved
                      | ((memory_ctrl & u_ex_load) ? ext_rd_ok :
                        (memory_data ? ext_dat_ok :
                        ((memory_ctrl & u_ex_store) ? (~ext_q_full) :
                        1'd1))));
    assign d_data = (response_external ? response_data : dlm_rdata);
    assign d_error = response_error;
    assign local_word_zero = (dlm_zero_bytes == 15);
    assign d_zero_hint = {(~local_word_zero), local_word_zero};
    assign d_byte_pause = 1'd0;
    assign d_pc = u_gated_d_pc_q[29:0];
    assign e_pc = u_gated_e_pc_q[29:0];
    assign e_inst = u_gated_e_inst_q[31:0];
    assign e_use_imm = u_gated_e_use_imm_q[0];
    assign e_subtract = u_gated_e_subtract_q[0];
    assign e_branch = u_gated_e_branch_q[0];
    assign e_jalr = u_gated_e_jalr_q[0];
    assign e_immlow = u_gated_e_immlow_q[4:0];
    assign e_pred_taken = u_gated_e_pred_taken_q[0];
    assign e_control = u_gated_e_control_q[0];
    assign e_zero_branch = u_gated_e_zero_branch_q[0];
    assign e_zero_invert = (e_inst[12] ^ e_pred_taken);
    assign e_fetch_error = u_gated_e_fetch_error_q[0];
    assign e_is_md = u_gated_e_is_md_q[0];
    assign e_is_sb = u_gated_e_is_sb_q[0];
    assign w_pc = u_gated_w_pc_q[29:0];
    assign w_rd = u_gated_w_rd_q[4:0];
    assign w_writes = u_gated_w_writes_q[0];
    assign w_load = u_gated_w_load_q[0];
    assign w_store = u_gated_w_store_q[0];
    assign w_result = u_gated_w_result_q[31:0];
    assign w_f3 = u_gated_w_f3_q[2:0];
    assign w_trap = u_gated_w_trap_q[0];
    assign w_cause = u_gated_w_cause_q[3:0];
    assign pc_address = {pc, 2'd0};
    assign d_pc_address = {d_pc, 2'd0};
    assign e_pc_address = {e_pc, 2'd0};
    assign w_pc_address = {w_pc, 2'd0};
    assign response_shifted = (d_data >> {w_result[1:0], 3'd0});
    assign response_half = (w_result[1] ? d_data[31:16] : d_data[15:0]);
    assign response_byte = (w_result[0] ? response_half[15:8] : response_half[7:0]);
    assign response_sign_byte = ((~w_f3[2]) & response_byte[7]);
    assign response_sign_half = ((~w_f3[2]) & response_half[15]);
    assign response_sign = (w_f3[0] ? response_sign_half : response_sign_byte);
    assign response_aligned_value = (w_f3[1] ? d_data :
                                    {{16{response_sign}}, (w_f3[0] ? response_half[15:8] : {8{response_sign_byte}}),
                                     response_byte});
    assign wb_data = (w_load ? response_aligned_value : w_result);
    assign wb_bus_error = (((w_load | w_store) & (~w_trap)) & d_error);
    assign wb_stop = (w_v & (w_trap | wb_bus_error));
    assign wb_write = (((w_v & w_writes) & (~wb_stop)) & (~halted));
    assign wb_forward = (w_v & w_writes);
    assign wb_operand_forward = (wb_forward & (~w_load));
    assign rf_write = (wb_write | dbg_x_wen);
    assign rf_address = (dbg_x_wen ? dbg_x_idx : w_rd);
    assign rf_write_data = (dbg_x_wen ? dbg_wdata : wb_data);
    assign read_b_address = u_id_rs2;
    assign bank_conflict = 1'd0;
    assign rf_value_a = ((u_id_rs1 == 0) ? 32'd0 : (~rf[u_id_rs1]));
    assign rf_value_b = ((u_id_rs2 == 0) ? 32'd0 : (~rf[u_id_rs2]));
    assign ex_a = (e_forward_a ? w_result : e_a);
    assign ex_b = (e_forward_b ? w_result : e_b);
    assign immediate = {e_inst[31:25], e_immlow};
    assign upper_immediate = {e_inst[31:12], 12'd0};
    assign alu_b = (e_use_imm
                    ? {immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11],
                       immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11],
                       immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11],
                       immediate[11], immediate[11], immediate} :
                   ex_b);
    assign forwarded_address = (d_data | {30'd0, immediate[1], 1'd0});
    assign ea = (e_address_forward ? forwarded_address : u_alu_sum);
    assign ex_bimm = {e_inst[31], e_inst[7], e_inst[30:25], e_inst[11:8], 1'd0};
    assign ex_jimm = {e_inst[31], e_inst[19:12], e_inst[20], e_inst[30:21], 1'd0};
    assign ex_relative = (e_pc_address
                          + (u_ex_auipc ? upper_immediate :
                            (u_ex_jal
                             ? {ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20],
                                ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm} :
                            (e_branch
                             ? {ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12],
                                ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12],
                                ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12],
                                ex_bimm[12], ex_bimm} :
                            32'd0))));
    assign store_low_sum = u_alu_sum[17:0];
    assign store_high_zero = (ex_a[31:18] == 0);
    assign store_high_max = (ex_a[31:16] == 65535);
    assign integer_result = (u_ex_csr ? csr_rdata :
                            (u_ex_lui ? upper_immediate :
                            (u_ex_auipc ? ex_relative :
                            ((u_ex_jal | u_ex_jalr) ? (e_pc_address + 4) :
                            u_alu_result))));
    assign response_zero_mask = ((w_f3[1:0] == 2) ? 4'd15 :
                                (w_f3[0] ? (w_result[1] ? 4'd12 : 4'd3) :
                                (4'd1 << w_result[1:0])));
    assign local_loaded_zero = (((dlm_zero_bytes[0] | (~response_zero_mask[0]))
                                & (dlm_zero_bytes[1] | (~response_zero_mask[1])))
                                & ((dlm_zero_bytes[2] | (~response_zero_mask[2]))
                                   & (dlm_zero_bytes[3] | (~response_zero_mask[3]))));
    assign loaded_zero = (response_external
                          ? (((((response_data[3:0] == 4'd0) | (~response_zero_mask[0]))
                             & ((response_data[7:4] == 4'd0) | (~response_zero_mask[0])))
                             & (((response_data[11:8] == 4'd0) | (~response_zero_mask[1]))
                                & ((response_data[15:12] == 4'd0) | (~response_zero_mask[1]))))
                             & ((((response_data[19:16] == 4'd0) | (~response_zero_mask[2]))
                                & ((response_data[23:20] == 4'd0) | (~response_zero_mask[2])))
                                & (((response_data[27:24] == 4'd0) | (~response_zero_mask[3]))
                                   & ((response_data[31:28] == 4'd0) | (~response_zero_mask[3]))))) :
                         local_loaded_zero);
    assign branch_equal_high = (ex_a[31:16] == ex_b[31:16]);
    assign branch_equal_low = (ex_a[15:0] == ex_b[15:0]);
    assign branch_equal = (branch_equal_high & branch_equal_low);
    assign branch_unsigned = u_alu_less_unsigned;
    assign branch_signed = ((ex_a[31] != ex_b[31]) ? ex_a[31] : branch_unsigned);
    assign branch_less = (u_ex_f3[1] ? branch_unsigned : branch_signed);
    assign plain_branch_condition = ((u_ex_f3[2] | (~u_ex_f3[1]))
                                     & ((u_ex_f3[2] ? branch_less : branch_equal) ^ u_ex_f3[0]));
    assign branch_condition = (e_zero_branch ? (loaded_zero ^ u_ex_f3[0]) : plain_branch_condition);
    assign taken = ((u_ex_jal | u_ex_jalr) | (u_ex_br & branch_condition));
    assign target = (u_ex_jalr ? (ea & 32'd4294967294) : ex_relative);
    assign actual_next = (taken ? target : (e_pc_address + 4));
    assign memory_low = (u_ex_store ? store_low_sum[1:0] : ea[1:0]);
    assign misaligned_data_c0 = ((u_ex_f3[1:0] == 1) ? memory_low[0] : ((u_ex_f3[1:0] == 2) ? (memory_low != 0) : 1'd0));
    assign misaligned_data = (((u_ex_load | u_ex_store) & (~native_ctrl_number)) & misaligned_data_c0);
    assign memory_alignment = ((u_ex_load | u_ex_store) & misaligned_data_c0);
    assign misaligned_store = ((~native_ctrl_number) & store_alignment);
    assign misaligned_pc = ((taken & (target[1:0] != 0)) & (~e_zero_branch));
    assign ex_trap = (((memory_request_fault | u_ex_ebreak) | u_ex_ecall) | misaligned_pc);
    assign memory_fault = ((e_fetch_error | (~u_ex_legal)) | misaligned_data);
    assign memory_request_fault = (memory_prepared ? memory_fault_saved :
                                  ((e_fetch_error | (~u_ex_legal)) | memory_alignment));
    assign csr_fault = (e_fetch_error | (~u_ex_legal));
    assign ex_cause = (e_fetch_error ? 4'd1 :
                      ((~u_ex_legal) ? 4'd2 :
                      (misaligned_pc ? 4'd0 :
                      (memory_request_fault ? (u_ex_store ? 4'd6 : 4'd4) :
                      (u_ex_ebreak ? 4'd3 :
                      4'd11)))));
    assign ex_tval = (e_fetch_error ? e_pc_address :
                     ((~u_ex_legal) ? e_inst :
                     (((u_ex_br | u_ex_jal) | u_ex_jalr) ? target :
                     ((u_ex_load | u_ex_store) ? ea :
                     32'd0))));
    assign address_spec_retry = ((((((~memory_prepared) & e_address_forward) & immediate[1]) & d_data[1])
                                 & (~e_fetch_error)) & u_ex_legal);
    assign native_ctrl_number = ((ea >= 336) & (ea < 1552));
    assign native_local = (ea[31:14] == 256);
    assign native_ctrl = (((((ea >= 336) & (ea < 1552)) | ((ea >= 33554432) & (ea < 33570816)))
                          | ((ea >= 33619968) & (ea < 33636352))) | ((ea >= 33685504) & (ea < 33701888)));
    assign native_ctrl_read = (u_ex_load & native_ctrl);
    assign native_ctrl_write = (u_ex_store & native_ctrl);
    assign native_data_read = (u_ex_load & (ea >= 32'd50331648));
    assign native_unmapped = (((~native_local) & (~native_ctrl)) & (~native_data_read));
    assign csr_write = ((u_ex_f3[1:0] == 1) | (u_ex_rs1 != 0));
    assign csr_source = (u_ex_f3[2] ? {27'd0, u_ex_rs1} : ex_a);
    assign csr_cdma = (e_inst[31:26] == 47);
    assign csr_cdma_write = ((csr_cdma & csr_write) & (e_inst[25:20] < 5));
    assign csr_wait = (((e_v & u_ex_csr) & (~csr_fault)) & ((~csr_prepared) | (csr_cdma_write & ext_q_full)));
    assign csr_paddr = e_inst[31:20];
    assign csr_pgi_a = (e_inst[24:20] - 5'd16);
    assign csr_pgi_b = (e_inst[24:20] - 5'd16);
    assign csr_addr = e_inst[31:20];
    assign csr_en = ((((((e_v & u_ex_csr) & csr_prepared) & ((~csr_cdma_write) | (~ext_q_full))) & (~csr_fault))
                     & (~wb_stop)) & (~halted));
    assign csr_wen = (csr_en & csr_write);
    assign csr_wdata = ((u_ex_f3[1:0] == 1) ? csr_source :
                       ((u_ex_f3[1:0] == 2) ? (csr_rdata | csr_source) :
                       (csr_rdata & (~csr_source))));
    assign csr_wo = ((u_ex_f3[1:0] == 3) ? 32'd0 : csr_source);
    assign ext_kind = (u_ex_csr ? 3'd4 : (memory_ctrl ? (u_ex_load ? 3'd2 : 3'd1) : (memory_data ? 3'd3 : 3'd4)));
    assign ext_addr = (u_ex_csr ? {20'd0, csr_addr} : memory_address);
    assign memory_shifted_write = (memory_write_data << {memory_address[1:0], 3'd0});
    assign ext_wdata = (u_ex_csr ? csr_wo : (memory_ctrl_number_saved ? memory_write_data : memory_shifted_write));
    assign external_request_valid = (((((e_v & (u_ex_load | u_ex_store)) & memory_prepared) & (~memory_fault_saved))
                                     & (~wb_stop)) & (~halted));
    assign ext_w2 = ((external_request_valid & memory_ctrl) & u_ex_load);
    assign ext_w3 = (external_request_valid & memory_data);
    assign ext_wq = (((external_request_valid & memory_ctrl) & u_ex_store)
                     | ((((((e_v & u_ex_csr) & csr_prepared) & csr_cdma_write) & (~csr_fault)) & (~wb_stop))
                        & (~halted)));
    assign dlm_re = ((((e_v & u_ex_load) & (~wb_stop)) & (~halted)) & ((~memory_prepared) | memory_local_saved));
    assign dlm_raddr = ea[13:2];
    assign store_alignment = ((u_ex_f3[1:0] == 1) ? store_low_sum[0] :
                             ((u_ex_f3[1:0] == 2) ? (store_low_sum[1:0] != 0) :
                             1'd0));
    assign dlm_store_allowed = (memory_prepared ? (memory_local_saved & (~memory_fault_saved)) :
                               (((ex_a[31:16] == 64) & (store_low_sum[16:14] == 0)) & (~store_alignment)));
    assign dlm_we = ((((((e_v & u_ex_store) & (~e_fetch_error)) & u_ex_legal) & (~wb_stop)) & (~halted))
                     & dlm_store_allowed);
    assign dlm_wclaim = ((((e_v & u_ex_store) & (~wb_stop)) & (~halted)) & ((~memory_prepared) | memory_local_saved));
    assign dlm_waddr = store_low_sum[13:2];
    assign dlm_wbe = d_wstrb;
    assign dlm_wdata = d_wdata;
    assign fetch_address = (rst_n ? i_addr : 32'd1048576);
    assign if_read = (if_fire | (~rst_n));
    assign if_raddr = (rom_ovr ? ovr_addr[9:0] : fetch_address[11:2]);
    assign if_iaddr = fetch_address[15:2];
    assign if_rom = fetch_rom;
    assign if_pc = pc_address;
    assign quiet = (halted | ((((dbg_stop & (~d_v)) & (~e_v)) & (~w_v)) & (~e_pending)));
    assign retire = (w_v & (~halted));
    assign dbg_x_rdata = ((dbg_x_idx == 0) ? 32'd0 : (~rf[dbg_x_idx]));
    assign i_prediction = if_prediction;
    assign md_wb_a_small = (w_result[31:9] == 0);
    assign md_wb_small = (w_result[31:8] == 0);
    assign md_a_small = (e_a[31:9] == 0);
    assign md_b_small = (e_b[31:8] == 0);
    assign md_small_inputs = ((e_forward_a ? md_wb_a_small : md_a_small) & (e_forward_b ? md_wb_small : md_b_small));
    assign md_wait = ((e_v & e_is_md) & (~u_md_ready));
    assign response_pointer_local = (response_external ? response_local_hint : dlm_local_hint);
    assign memory_fast_local = (e_address_forward ? response_pointer_local : (ex_a[31:16] == 64));
    assign memory_prepare = (((((e_v & (u_ex_load | u_ex_store)) & (~memory_prepared)) & (~memory_fast_local))
                             & (~wb_stop)) & (~halted));
    assign memory_wait = (((e_v & (u_ex_load | u_ex_store)) & (memory_prepared ? (~d_ready) : (~memory_fast_local)))
                          & (~address_spec_retry));
    assign memory_commit = (((((e_v & (u_ex_load | u_ex_store)) & (~memory_wait)) & (~wb_stop)) & (~halted))
                            & (~byte_store_wait));
    assign memory_response_error = (memory_prepared ? (~((memory_local_saved | memory_ctrl) | memory_data)) :
                                   ((~memory_fast_local) | (ea[16:14] != 0)));
    assign byte_store_wait = (((e_v & e_is_sb) & (~e_fetch_error)) & d_byte_pause);
    assign hold = (((md_wait | memory_wait) | byte_store_wait) | csr_wait);
    assign front_capture_slow = (((((((~halted) & (~wb_stop)) & (~e_pending)) & (~memory_wait)) & (~byte_store_wait))
                                 & (~csr_wait)) & ((~(e_v & e_is_md)) | u_md_ready_slow));
    assign front_capture_small = ((~e_pending) & u_md_small_eligible);
    assign front_capture_enable = (front_capture_slow | (front_capture_small & md_small_inputs));
    assign front_hold = (hold | e_pending);
    assign ex_fire = (((e_v & (~hold)) & (~wb_stop)) & (~halted));
    assign prediction_miss = (e_predicted != actual_next);
    assign control_fault = ((e_fetch_error | (~u_ex_legal)) | (target[1:0] != 0));
    assign redirect_valid = ((PREDICT == 1) ? ex_fire : ((e_v & (~wb_stop)) & (~halted)));
    assign ordinary_taken = ((u_ex_jal | u_ex_jalr) | (u_ex_br & plain_branch_condition));
    assign ordinary_prediction_miss = (u_ex_jalr ? (~e_pred_taken) : (ordinary_taken ^ e_pred_taken));
    assign local_prediction_miss = (e_zero_branch ? (loaded_zero ^ e_zero_invert) : ordinary_prediction_miss);
    assign static_redirect_enable = ((redirect_valid & e_control) & ((~u_ex_jalr) | (~ea[1])));
    assign address_replay = (ex_fire & address_spec_retry);
    assign zero_redirect_enable = ((redirect_valid & e_control) & e_zero_branch);
    assign zero_redirect_when_zero = (zero_redirect_enable & (~e_zero_invert));
    assign zero_redirect_when_nonzero = (zero_redirect_enable & e_zero_invert);
    assign ordinary_redirect = ((static_redirect_enable & (~e_zero_branch)) & ordinary_prediction_miss);
    assign static_prediction_redirect = (((ordinary_redirect | address_replay)
                                         | (loaded_zero & zero_redirect_when_zero))
                                         | ((~loaded_zero) & zero_redirect_when_nonzero));
    assign redirect = ((PREDICT == 1) ? (((redirect_valid & (~ex_trap)) & prediction_miss) | address_replay) :
                      ((PREDICT == 2) ? static_prediction_redirect :
                      ((static_redirect_enable & taken) | address_replay)));
    assign depend_a = (u_id_rs1 == u_ex_rd);
    assign depend_b = (u_id_rs2 == u_ex_rd);
    assign dependency_producer = (((e_v & u_ex_writes) & (~u_ex_load)) & (u_ex_rd != 0));
    assign load_pending = ((e_v & u_ex_load) & (u_ex_rd != 0));
    assign address_forward = ((((load_pending & (u_ex_f3 == 2)) & depend_a) & (u_id_load | u_id_jalr))
                              & ((i_data[31:20] == 0) | (u_id_load & (i_data[31:20] == 2))));
    assign zero_branch_forward = (((((load_pending & u_id_br) & (u_id_f3[2:1] == 0)) & (~i_error)) & (~i_data[8]))
                                  & (((u_id_rs1 == 0) & depend_b) | ((u_id_rs2 == 0) & depend_a)));
    assign load_hazard = (((load_pending & (depend_a | depend_b)) & (~zero_branch_forward)) & (~address_forward));
    assign fetch_retry = (d_v & i_retry);
    assign id_fire = ((((d_v & (~fetch_retry)) & (~front_hold)) & (~wb_stop)) & (~halted));
    assign id_control_legal = ((u_id_jal | (u_id_jalr & (u_id_f3 == 0)))
                               | (u_id_br & ((u_id_f3[2:1] == 0) | u_id_f3[2])));
    assign return_free = ((~(((dependency_producer | load_pending) & (u_ex_rd == 1)) | (wb_forward & (w_rd == 1))))
                          & (return_target[1:0] == 0));
    assign id_lookup_enable = (((PREDICT == 2) & d_v) & (~i_error));
    assign id_lookup_static = (id_lookup_enable & i_prediction[15]);
    assign id_lookup_return = ((id_lookup_enable & i_prediction[16]) & return_free);
    assign id_prediction = (id_lookup_static | id_lookup_return);
    assign id_static_target = {d_pc[29:15], i_prediction[14:0], 2'd0};
    assign id_target = (id_lookup_return ? return_target : id_static_target);
    assign id_static = ((id_prediction & id_fire) & (~ex_fetch));
    assign wb_control = (((w_inst[6:0] == 99) | (w_inst[6:0] == 111)) | (w_inst[6:0] == 103));
    assign predicted_next = {u_predictor_next_pc[31:2], 2'd0};
    assign fast_taken = (u_ex_jal | (u_ex_br & plain_branch_condition));
    assign fast_branch_enable = ((((PREDICT == 2) & redirect_valid) & e_control) & e_branch);
    assign fast_eq_normal = ((fast_branch_enable & (~u_ex_f3[2])) & (~e_zero_branch));
    assign fast_eq_zero = (((fast_branch_enable & (~u_ex_f3[2])) & e_zero_branch) & zero_hint_eligible);
    assign fast_eq_request = (fast_eq_normal & (branch_equal ^ e_zero_invert));
    assign fast_branch = fast_eq_request;
    assign fast_jalr = 1'd0;
    assign fast_jalr_target = 32'd0;
    assign zero_hint_eligible = (((w_f3 == 2) & (~response_external)) & (~response_error));
    assign zero_hint_when_zero = (fast_eq_zero & (~e_zero_invert));
    assign zero_hint_when_nonzero = (fast_eq_zero & e_zero_invert);
    assign fast_zero_redirect = ((d_zero_hint[0] & zero_hint_when_zero) | (d_zero_hint[1] & zero_hint_when_nonzero));
    assign fast_fetch_zero = (fast_branch | zero_hint_when_zero);
    assign fast_fetch_nonzero = (fast_branch | zero_hint_when_nonzero);
    assign ex_fetch = (local_word_zero ? fast_fetch_zero : fast_fetch_nonzero);
    assign fast_recovery_next = (e_pred_taken ? (e_pc_address + 4) : ex_relative);
    assign recovery_next = ((PREDICT == 2) ? (e_pred_taken ? (e_pc_address + 4) : target) :
                           (address_spec_retry ? ex_relative :
                           actual_next));
    assign i_valid = (((((~dbg_stop) | step_credit) & (~halted)) & (~wb_stop))
                      & (ex_fetch | ((~fetch_retry) & ((~d_v) | (~front_hold)))));
    assign sequential_fetch_address = {(pc_pending ? (pc + 30'd1) : pc), 2'd0};
    assign fast_fetch_target = fast_recovery_next;
    assign early_fetch_address = (ex_fetch ? fast_fetch_target :
                                 (id_lookup_return ? return_target :
                                 (id_lookup_static ? id_static_target :
                                 sequential_fetch_address)));
    assign i_fetch_address = early_fetch_address;
    assign i_addr = i_fetch_address;
    assign if_fire = (i_valid & i_ready);
    assign d_valid = (((((((e_v & (u_ex_load | u_ex_store)) & (~memory_request_fault)) & (~wb_stop)) & (~halted))
                      & (~byte_store_wait)) & (~address_spec_retry)) & (memory_fast_local | memory_prepared));
    assign d_write = u_ex_store;
    assign d_store_valid = ((((((e_v & u_ex_store) & (~memory_request_fault)) & (~wb_stop)) & (~halted))
                            & (~byte_store_wait)) & (memory_fast_local | memory_prepared));
    assign d_addr = ea;
    assign d_address_forward = e_address_forward;
    assign d_store_word = store_low_sum[16:2];
    assign d_store_local = (immediate[11]
                            ? (u_alu_carry16 ? (store_high_zero & (~ex_a[17])) :
                              (store_high_zero & (ex_a[17] ^ ex_a[16]))) :
                           (u_alu_carry16 ? (((store_high_zero & (~ex_a[17])) & (~ex_a[16])) | store_high_max) :
                           (store_high_zero & (~ex_a[17]))));
    assign d_wdata = (ex_b << {store_low_sum[1:0], 3'd0});
    assign d_byte = ex_b[7:0];
    assign d_wstrb = ((u_ex_f3 == 0) ? (4'd1 << store_low_sum[1:0]) :
                     ((u_ex_f3 == 1) ? (4'd3 << store_low_sum[1:0]) :
                     4'd15));
    assign d_f3 = u_ex_f3;
    assign result = (e_is_md ? u_md_result : integer_result);
    assign jump_misaligned = ((u_ex_jal | u_ex_jalr) & target[1]);
    assign normal_result_ok = ((~e_fetch_error) & u_ex_legal);
    assign exception_wb_result = (((((((((e_fetch_error ? e_pc_address : 0)
                                  | (((~e_fetch_error) & (~u_ex_legal)) ? e_inst : 0))
                                  | ((normal_result_ok & (u_ex_load | u_ex_store)) ? ea : 0))
                                  | ((normal_result_ok & (u_ex_br | jump_misaligned)) ? target : 0))
                                  | (((normal_result_ok & (u_ex_jal | u_ex_jalr)) & (~jump_misaligned))
                                     ? (e_pc_address + 4) :
                                    0)) | ((normal_result_ok & u_ex_lui) ? upper_immediate : 0))
                                  | ((normal_result_ok & u_ex_auipc) ? ex_relative : 0))
                                  | ((normal_result_ok & (u_ex_immop | (u_ex_regop & (~e_is_md)))) ? u_alu_result : 0))
                                  | ((normal_result_ok & u_ex_csr) ? csr_rdata : 0));
    assign wb_background = (md_workspace_write ? u_md_operand_next : exception_wb_result);
    assign wb_md_result = ((normal_result_ok & e_is_md) & (~md_workspace_write));
    assign wb_payload = (wb_background | (u_md_result & {32{wb_md_result}}));
    assign halt = halted;
    assign halt_o = halted;
    assign cause_o = (halted ? (stop_bus_error ? (w_store ? 4'd7 : 4'd5) : w_cause) : 4'd0);
    assign trap_pc_o = (halted ? w_pc_address : 32'd0);
    assign trap_value_o = (halted ? w_result : 32'd0);
    assign retired_o = retired;
    assign load_stalls_o = stalls_load;
    assign muldiv_stalls_o = stalls_muldiv;
    assign redirects_o = redirects;
    assign trace_valid = (((TRACE != 0) & w_v) & (~halted));
    assign trace_pc = ((TRACE != 0) ? w_pc_address : 32'd0);
    assign trace_inst = ((TRACE != 0) ? w_inst : 32'd0);
    assign trace_rd = (((TRACE != 0) & wb_write) ? w_rd : 5'd0);
    assign trace_data = ((TRACE != 0) ? wb_data : 32'd0);
    assign trace_store = ((((TRACE != 0) & w_v) & w_store) & (~wb_stop));
    assign trace_addr = ((TRACE != 0) ? w_result : 32'd0);
    assign trace_wdata = ((TRACE != 0) ? w_data : 32'd0);
    assign trace_mask = ((TRACE != 0) ? w_mask : 4'd0);
    assign trace_trap = ((TRACE != 0) & wb_stop);
    assign retire_enable = (((~halted) & (~wb_stop)) & w_v);
    assign capture_id = ((~e_pending) & (~hold));
    assign capture_hold = ((~e_pending) & hold);
    assign capture_wb_a = (((capture_id & wb_forward) & (w_rd == u_id_rs1)) | (e_pending & e_forward_a));
    assign capture_wb_b = (((capture_id & wb_forward) & (w_rd == u_id_rs2)) | (e_pending & e_forward_b));
    assign rf_capture_a = ((capture_id & (u_id_rs1 != 0)) & (~(wb_forward & (w_rd == u_id_rs1))));
    assign rf_capture_b = (((capture_id & (~(wb_forward & (w_rd == u_id_rs2)))) | e_bank_pending)
                           & (read_b_address != 0));
    assign holding_operand_a = ((((((capture_hold & e_address_forward) & (~md_high_workspace)) ? d_data : 0)
                                | ((((capture_hold & (~e_address_forward)) & e_forward_a) & (~md_high_workspace))
                                   ? w_result :
                                  0))
                                | ((((e_pending & (~e_forward_a))
                                     | ((capture_hold & (~e_address_forward)) & (~e_forward_a))) & (~md_high_workspace))
                                   ? e_a :
                                  0)) | ((md_workspace_write & u_md_accumulating) ? u_md_high_accumulate : 0));
    assign holding_operand_b = (((((capture_hold & e_forward_b) & (~md_partial_capture)) ? w_result : 0)
                                | (((((e_pending & (~e_forward_b)) & (~e_bank_pending))
                                     | (capture_hold & (~e_forward_b))) & (~md_partial_capture)) ? e_b :
                                  0)) | (md_partial_capture ? u_md_partial_product[31:0] : 0));
    assign operand_next_a = ((holding_operand_a | (rf_value_a & {32{rf_capture_a}})) | (wb_data & {32{capture_wb_a}}));
    assign operand_next_b = ((holding_operand_b | (rf_value_b & {32{rf_capture_b}})) | (wb_data & {32{capture_wb_b}}));
    assign md_workspace_write = ((((MUL_SERIAL == 4) & e_v) & e_is_md) & hold);
    assign md_partial_capture = ((((MUL_SERIAL == 4) & e_v) & e_is_md) & u_md_partial_capture);
    assign md_high_workspace = (md_workspace_write & (~md_partial_capture));
    assign pc_sequential_word = (pc_pending ? (pc + 30'd2) : (pc + 30'd1));
    assign pc_normal_word = (fetch_retry ? d_pc :
                            (id_static ? id_target[31:2] :
                            (if_fire ? ((PREDICT == 1) ? predicted_next[31:2] : pc_sequential_word) :
                            pc)));
    assign pc_next_word = (redirect ? recovery_next[31:2] : pc_normal_word);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            return_target <= 0;
            step_credit <= 0;
            fetch_rom <= 1;
            i_error <= 0;
            csr_prepared <= 0;
            memory_prepared <= 0;
            response_external <= 0;
            response_error <= 0;
            retired <= 0;
            halted <= 0;
            stop_bus_error <= 0;
            pc <= 262144;
            w_v <= 0;
            e_pending <= 0;
            e_bank_pending <= 0;
            e_v <= 0;
            md_started <= 0;
            pc_pending <= 0;
            d_v <= 0;
            stalls_load <= 0;
            stalls_muldiv <= 0;
            redirects <= 0;
        end else begin
            if ((rf_write & (rf_address != 0))) begin
                rf[rf_address] <= (~rf_write_data);
                if ((rf_address == 1)) begin
                    return_target <= rf_write_data;
                end
            end
            if (dbg_step) begin
                step_credit <= 1;
            end else begin
                if ((if_fire & dbg_stop)) begin
                    step_credit <= 0;
                end
            end
            if (if_fire) begin
                fetch_rom <= (i_addr[31:12] == 256);
                i_error <= (~((i_addr[31:12] == 256) | ((i_addr >= 32'd8388608) & (i_addr < 32'd8437760))));
            end
            if (ex_fire) begin
                csr_prepared <= 0;
            end else begin
                if ((e_v & u_ex_csr)) begin
                    csr_prepared <= 1;
                end
            end
            if (ex_fire) begin
                memory_prepared <= 0;
            end else begin
                if (memory_prepare) begin
                    memory_prepared <= 1;
                end
            end
            if (memory_commit) begin
                response_external <= (memory_prepared & (memory_ctrl | memory_data));
                response_error <= memory_response_error;
            end else begin
                response_error <= 0;
            end
            retired <= (retired + {63'd0, retire_enable});
            if ((~halted)) begin
                if (wb_stop) begin
                    halted <= 1;
                    stop_bus_error <= wb_bus_error;
                end else begin
                    pc <= (dbg_pc_wen ? dbg_wdata[31:2] : pc_next_word);
                    w_v <= (ex_fire & (~address_spec_retry));
                    if (e_pending) begin
                        e_pending <= 0;
                        e_bank_pending <= 0;
                        e_v <= 1;
                    end else begin
                        if (hold) begin
                            if ((e_v & e_is_md)) begin
                                md_started <= 1;
                            end
                        end else begin
                            e_v <= (id_fire & (~(load_hazard | bank_conflict)));
                            e_pending <= (id_fire & (load_hazard | bank_conflict));
                            e_bank_pending <= (id_fire & bank_conflict);
                            md_started <= 0;
                        end
                    end
                    if (if_fire) begin
                        pc_pending <= id_static;
                        d_v <= 1;
                    end else begin
                        if (id_fire) begin
                            d_v <= 0;
                        end
                    end
                    if ((id_static & (~if_fire))) begin
                        pc_pending <= 0;
                        d_v <= 0;
                    end
                    if (fetch_retry) begin
                        pc_pending <= 0;
                        d_v <= 0;
                    end
                    if (redirect) begin
                        pc_pending <= (ex_fetch & if_fire);
                    end
                    if (redirect) begin
                        d_v <= (ex_fetch & if_fire);
                        e_v <= 0;
                        e_pending <= 0;
                        e_bank_pending <= 0;
                    end
                    if (((((PERF != 0) & d_v) & load_hazard) & (~hold))) begin
                        stalls_load <= (stalls_load + 1);
                    end
                    if (((PERF != 0) & md_wait)) begin
                        stalls_muldiv <= (stalls_muldiv + 1);
                    end
                    if (((PERF != 0) & (redirect | id_static))) begin
                        redirects <= (redirects + 1);
                    end
                end
            end
        end
    end
    always_ff @(posedge clk) begin
        if ((!ex_fire)) begin
            if (memory_prepare) begin
                memory_ctrl <= native_ctrl;
                memory_data <= native_data_read;
                memory_local_saved <= native_local;
                memory_ctrl_number_saved <= native_ctrl_number;
                memory_fault_saved <= memory_fault;
                memory_address <= ea;
                memory_write_data <= ex_b;
            end
        end
        if (memory_commit) begin
            response_data <= ext_rdata;
            response_local_hint <= (ext_rdata[31:16] == 64);
        end
        e_a <= operand_next_a;
        e_b <= operand_next_b;
        if ((~halted)) begin
            if ((!wb_stop)) begin
                if (ex_fire) begin
                    w_inst <= e_inst;
                    w_data <= d_wdata;
                    w_mask <= d_wstrb;
                    w_taken <= taken;
                    w_target <= actual_next;
                end else begin
                    if (md_workspace_write) begin
                        w_mask <= {w_mask[3:2], u_md_quotient_next[31:30]};
                    end
                end
                if (e_pending) begin
                    e_forward_a <= 0;
                    e_forward_b <= 0;
                    e_address_forward <= 0;
                end else begin
                    if (hold) begin
                        e_forward_a <= 0;
                        e_forward_b <= 0;
                        e_address_forward <= 0;
                    end else begin
                        e_forward_a <= ((dependency_producer | load_pending) & depend_a);
                        e_forward_b <= ((dependency_producer | load_pending) & depend_b);
                        e_predicted <= d_predicted;
                        e_address_forward <= address_forward;
                    end
                end
                if (if_fire) begin
                    d_predicted <= ((PREDICT == 1) ? predicted_next : (i_addr + 4));
                end
            end
        end
    end

    CpuDecode u_id (
        .inst(i_data),
        .md(u_id_md),
        .store(u_id_store),
        .f3(u_id_f3),
        .immop(u_id_immop),
        .load(u_id_load),
        .jalr(u_id_jalr),
        .regop(u_id_regop),
        .br(u_id_br),
        .jal(u_id_jal),
        .rs2(u_id_rs2),
        .rs1(u_id_rs1)
    );
    CpuDecode u_ex (
        .inst(e_inst),
        .f3(u_ex_f3),
        .rd(u_ex_rd),
        .writes(u_ex_writes),
        .load(u_ex_load),
        .store(u_ex_store),
        .auipc(u_ex_auipc),
        .jal(u_ex_jal),
        .csr(u_ex_csr),
        .lui(u_ex_lui),
        .jalr(u_ex_jalr),
        .br(u_ex_br),
        .ebreak(u_ex_ebreak),
        .ecall(u_ex_ecall),
        .legal(u_ex_legal),
        .rs1(u_ex_rs1),
        .immop(u_ex_immop),
        .regop(u_ex_regop)
    );
    CompactAlu #(.SHARED_ALU(0)) u_alu (
        .shared_active(e_is_md),
        .shared_left(u_md_shared_left),
        .shared_right(u_md_shared_right),
        .shared_carry(u_md_shared_carry),
        .a(ex_a),
        .add_a(ex_a),
        .b(alu_b),
        .f3(u_ex_f3),
        .subtract(e_subtract),
        .arithmetic(e_inst[30]),
        .sum(u_alu_sum),
        .shared_sum(u_alu_shared_sum),
        .result(u_alu_result),
        .less_unsigned(u_alu_less_unsigned),
        .carry16(u_alu_carry16)
    );
    MulDiv #(.EXTERNAL_ARITH(1), .SHARED_ALU(0), .SERIAL(MUL_SERIAL), .EXTERNAL(1), .HOLD_RESULT(0)) u_md (
        .clk(clk),
        .external_small(md_small_inputs),
        .external_sum(u_alu_sum),
        .external_carry(u_alu_shared_sum[32]),
        .storage_partial({4'd0, e_b}),
        .shared_sum(u_alu_shared_sum),
        .rst_n(((rst_n & (~halted)) & (~wb_stop))),
        .start(((((e_v & e_is_md) & (~md_started)) & (~wb_stop)) & (~halted))),
        .consume((ex_fire & e_is_md)),
        .a(ex_a),
        .b(ex_b),
        .storage_a(w_result),
        .storage_b({w_mask[1:0], w_pc}),
        .storage_high(e_a),
        .op(u_ex_f3),
        .shared_left(u_md_shared_left),
        .shared_right(u_md_shared_right),
        .shared_carry(u_md_shared_carry),
        .quotient_next(u_md_quotient_next),
        .ready(u_md_ready),
        .ready_slow(u_md_ready_slow),
        .small_eligible(u_md_small_eligible),
        .result(u_md_result),
        .operand_next(u_md_operand_next),
        .accumulating(u_md_accumulating),
        .high_accumulate(u_md_high_accumulate),
        .partial_product(u_md_partial_product),
        .partial_capture(u_md_partial_capture)
    );
    Predictor_ENTRIES8 u_predictor (
        .clk(clk),
        .rst_n(rst_n),
        .query_pc(pc_address),
        .update(((((PREDICT == 1) & w_v) & (~wb_stop)) & (~halted))),
        .update_pc(w_pc_address),
        .update_target(w_target),
        .update_taken(w_taken),
        .update_control(wb_control),
        .next_pc(u_predictor_next_pc)
    );
    CpuPayload u_gated_e_is_md (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, u_id_md}),
        .q(u_gated_e_is_md_q)
    );
    CpuPayload u_gated_e_is_sb (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, (u_id_store & (u_id_f3 == 0))}),
        .q(u_gated_e_is_sb_q)
    );
    CpuPayload u_gated_e_inst (
        .clk(clk),
        .enable(front_capture_enable),
        .value(i_data),
        .q(u_gated_e_inst_q)
    );
    CpuPayload u_gated_e_pc (
        .clk(clk),
        .enable(front_capture_enable),
        .value({2'd0, d_pc}),
        .q(u_gated_e_pc_q)
    );
    CpuPayload u_gated_e_use_imm (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, (((u_id_immop | u_id_load) | u_id_store) | u_id_jalr)}),
        .q(u_gated_e_use_imm_q)
    );
    CpuPayload u_gated_e_subtract (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, ((u_id_regop & (u_id_f3 == 0)) & i_data[30])}),
        .q(u_gated_e_subtract_q)
    );
    CpuPayload u_gated_e_branch (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, u_id_br}),
        .q(u_gated_e_branch_q)
    );
    CpuPayload u_gated_e_jalr (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, u_id_jalr}),
        .q(u_gated_e_jalr_q)
    );
    CpuPayload u_gated_e_immlow (
        .clk(clk),
        .enable(front_capture_enable),
        .value({27'd0, (u_id_store ? i_data[11:7] : i_data[24:20])}),
        .q(u_gated_e_immlow_q)
    );
    CpuPayload u_gated_e_pred_taken (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, id_prediction}),
        .q(u_gated_e_pred_taken_q)
    );
    CpuPayload u_gated_e_control (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0,
                (((~i_error) & id_control_legal) & (u_id_jalr ? 1'd1 : (u_id_jal ? (~i_data[21]) : (~i_data[8]))))}),
        .q(u_gated_e_control_q)
    );
    CpuPayload u_gated_e_zero_branch (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, zero_branch_forward}),
        .q(u_gated_e_zero_branch_q)
    );
    CpuPayload u_gated_e_fetch_error (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, i_error}),
        .q(u_gated_e_fetch_error_q)
    );
    CpuPayload u_gated_d_pc (
        .clk(clk),
        .enable(((~d_v) | front_capture_enable)),
        .value({2'd0, i_addr[31:2]}),
        .q(u_gated_d_pc_q)
    );
    CpuPayload u_gated_w_rd (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({27'd0, u_ex_rd}),
        .q(u_gated_w_rd_q)
    );
    CpuPayload u_gated_w_writes (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, (u_ex_writes & (u_ex_rd != 0))}),
        .q(u_gated_w_writes_q)
    );
    CpuPayload u_gated_w_load (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, u_ex_load}),
        .q(u_gated_w_load_q)
    );
    CpuPayload u_gated_w_store (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, u_ex_store}),
        .q(u_gated_w_store_q)
    );
    CpuPayload u_gated_w_f3 (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({29'd0, u_ex_f3}),
        .q(u_gated_w_f3_q)
    );
    CpuPayload u_gated_w_trap (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, ex_trap}),
        .q(u_gated_w_trap_q)
    );
    CpuPayload u_gated_w_cause (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({28'd0, ex_cause}),
        .q(u_gated_w_cause_q)
    );
    CpuPayload u_gated_w_result (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value(wb_payload),
        .q(u_gated_w_result_q)
    );
    CpuPayload u_gated_w_pc (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value((md_workspace_write ? u_md_quotient_next : {2'd0, e_pc})),
        .q(u_gated_w_pc_q)
    );
endmodule
