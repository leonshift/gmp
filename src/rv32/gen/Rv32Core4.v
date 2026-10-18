module Rv32Core4 #(
    parameter PREDICT = 2,
    parameter TRACE = 1,
    parameter PERF = 0
) (
    input clk,
    input rst_n,
    input i_ready,
    input [31:0] i_data,
    input [17:0] i_prediction,
    input [14:0] program_word,
    input [31:0] program_data,
    input i_error,
    input i_retry,
    input d_ready,
    input d_byte_pause,
    input [31:0] d_data,
    input [1:0] d_zero_hint,
    input d_error,
    output logic program_word_zero,
    output logic d_word_zero,
    output logic [17:0] program_prediction,
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
    logic [31:0] e_pc_address;
    logic [31:0] w_pc_address;
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
    logic [4:0] read_b_address;
    logic [1:0] read_bank_a;
    logic [1:0] read_bank_b;
    logic needs_rf_a;
    logic needs_rf_b;
    logic bank_conflict;
    logic [2:0] read_row_address_0;
    logic [2:0] read_row_address_1;
    logic [2:0] read_row_address_2;
    logic [2:0] read_row_address_3;
    logic [31:0] read_banks_0;
    logic [31:0] read_banks_1;
    logic [31:0] read_banks_2;
    logic [31:0] read_banks_3;
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
    logic misaligned_store;
    logic misaligned_pc;
    logic ex_trap;
    logic memory_fault;
    logic [3:0] ex_cause;
    logic address_spec_retry;
    logic md_wb_a_small;
    logic md_wb_small;
    logic md_a_small;
    logic md_b_small;
    logic md_small_inputs;
    logic md_wait;
    logic memory_wait;
    logic byte_store_wait;
    logic hold;
    logic front_capture_slow;
    logic front_capture_small;
    logic front_capture_enable;
    logic front_hold;
    logic ex_fire;
    logic prediction_miss;
    logic redirect_valid;
    logic ordinary_taken;
    logic ordinary_prediction_miss;
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
    logic [29:0] program_target;
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
    logic fast_branch_enable;
    logic fast_eq_normal;
    logic fast_eq_zero;
    logic fast_eq_request;
    logic fast_branch;
    logic zero_hint_eligible;
    logic zero_hint_when_zero;
    logic zero_hint_when_nonzero;
    logic fast_zero_redirect;
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
    logic u_rf_write_reset_q;
    logic u_rf_write_write_q;
    logic [4:0] u_rf_write_address_q;
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
    logic [31:0] u_md_operand_next;
    logic [31:0] u_md_quotient_next;
    logic [31:0] u_gated_d_pc_q;
    logic [31:0] u_gated_e_pc_q;
    logic [31:0] u_gated_e_inst_q;
    logic [31:0] u_gated_e_use_imm_q;
    logic [31:0] u_gated_e_subtract_q;
    logic [31:0] u_gated_e_branch_q;
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
    logic u_id_use1;
    logic u_id_use2;
    logic [31:0] rf_words_15_q;
    logic [31:0] rf_words_19_q;
    logic [31:0] rf_words_23_q;
    logic [31:0] rf_words_27_q;
    logic [31:0] rf_words_3_q;
    logic [31:0] rf_words_7_q;
    logic [31:0] rf_words_11_q;
    logic [31:0] rf_words_16_q;
    logic [31:0] rf_words_20_q;
    logic [31:0] rf_words_24_q;
    logic [31:0] rf_words_28_q;
    logic [31:0] rf_words_0_q;
    logic [31:0] rf_words_4_q;
    logic [31:0] rf_words_8_q;
    logic [31:0] rf_words_12_q;
    logic [31:0] rf_words_17_q;
    logic [31:0] rf_words_21_q;
    logic [31:0] rf_words_25_q;
    logic [31:0] rf_words_29_q;
    logic [31:0] rf_words_1_q;
    logic [31:0] rf_words_5_q;
    logic [31:0] rf_words_9_q;
    logic [31:0] rf_words_13_q;
    logic [31:0] rf_words_18_q;
    logic [31:0] rf_words_22_q;
    logic [31:0] rf_words_26_q;
    logic [31:0] rf_words_30_q;
    logic [31:0] rf_words_2_q;
    logic [31:0] rf_words_6_q;
    logic [31:0] rf_words_10_q;
    logic [31:0] rf_words_14_q;
    logic u_ex_auipc;
    logic u_ex_jal;
    logic u_ex_lui;
    logic u_ex_jalr;
    logic [31:0] u_alu_result;
    logic u_alu_less_unsigned;
    logic u_ex_br;
    logic u_ex_legal;
    logic u_ex_ebreak;
    logic u_ex_ecall;
    logic u_md_ready;
    logic u_md_ready_slow;
    logic u_md_small_eligible;
    logic [31:0] u_predictor_next_pc;
    logic u_alu_carry16;
    logic [31:0] u_md_result;
    logic u_ex_immop;
    logic u_ex_regop;
    logic u_md_accumulating;
    logic [31:0] u_md_high_accumulate;
    logic [35:0] u_md_partial_product;
    logic u_md_partial_capture;

    assign d_pc = u_gated_d_pc_q[29:0];
    assign e_pc = u_gated_e_pc_q[29:0];
    assign e_inst = u_gated_e_inst_q[31:0];
    assign e_use_imm = u_gated_e_use_imm_q[0];
    assign e_subtract = u_gated_e_subtract_q[0];
    assign e_branch = u_gated_e_branch_q[0];
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
    assign e_pc_address = {e_pc, 2'd0};
    assign w_pc_address = {w_pc, 2'd0};
    assign response_half = (w_result[1] ? d_data[31:16] : d_data[15:0]);
    assign response_byte = (w_result[0] ? response_half[15:8] : response_half[7:0]);
    assign response_sign_byte = ((~w_f3[2]) & response_byte[7]);
    assign response_sign_half = ((~w_f3[2]) & response_half[15]);
    assign response_sign = (w_f3[0] ? response_sign_half : response_sign_byte);
    assign response_aligned_value = (w_f3[1] ? d_data : {{16{response_sign}}, (w_f3[0] ? response_half[15:8] : {8{response_sign_byte}}), response_byte});
    assign wb_data = (w_load ? response_aligned_value : w_result);
    assign wb_bus_error = (((w_load | w_store) & (~w_trap)) & d_error);
    assign wb_stop = (w_v & (w_trap | wb_bus_error));
    assign wb_write = (((w_v & w_writes) & (~wb_stop)) & (~halted));
    assign wb_forward = (w_v & w_writes);
    assign read_b_address = (e_bank_pending ? e_inst[24:20] : u_id_rs2);
    assign read_bank_a = u_id_rs1[1:0];
    assign read_bank_b = read_b_address[1:0];
    assign needs_rf_a = (((u_id_use1 & (u_id_rs1 != 0)) & (~((dependency_producer | load_pending) & depend_a))) & (~(wb_forward & (w_rd == u_id_rs1))));
    assign needs_rf_b = (((u_id_use2 & (u_id_rs2 != 0)) & (~((dependency_producer | load_pending) & depend_b))) & (~(wb_forward & (w_rd == u_id_rs2))));
    assign bank_conflict = ((needs_rf_b & (read_bank_a == read_bank_b)) & (u_id_rs1 != u_id_rs2));
    assign read_row_address_0 = ((e_bank_pending & (e_inst[21:20] == 0)) ? e_inst[24:22] : ((read_bank_a == 0) ? u_id_rs1[4:2] : u_id_rs2[4:2]));
    assign read_banks_0 = (~(read_row_address_0[2] ? (((((read_row_address_0[1:0] == 0) ? rf_words_15_q : 0) | ((read_row_address_0[1:0] == 1) ? rf_words_19_q : 0)) | ((read_row_address_0[1:0] == 2) ? rf_words_23_q : 0)) | ((read_row_address_0[1:0] == 3) ? rf_words_27_q : 0)) : (((((read_row_address_0[1:0] == 0) ? 32'd0 : 0) | ((read_row_address_0[1:0] == 1) ? rf_words_3_q : 0)) | ((read_row_address_0[1:0] == 2) ? rf_words_7_q : 0)) | ((read_row_address_0[1:0] == 3) ? rf_words_11_q : 0))));
    assign read_row_address_1 = ((e_bank_pending & (e_inst[21:20] == 1)) ? e_inst[24:22] : ((read_bank_a == 1) ? u_id_rs1[4:2] : u_id_rs2[4:2]));
    assign read_banks_1 = (~(read_row_address_1[2] ? (((((read_row_address_1[1:0] == 0) ? rf_words_16_q : 0) | ((read_row_address_1[1:0] == 1) ? rf_words_20_q : 0)) | ((read_row_address_1[1:0] == 2) ? rf_words_24_q : 0)) | ((read_row_address_1[1:0] == 3) ? rf_words_28_q : 0)) : (((((read_row_address_1[1:0] == 0) ? rf_words_0_q : 0) | ((read_row_address_1[1:0] == 1) ? rf_words_4_q : 0)) | ((read_row_address_1[1:0] == 2) ? rf_words_8_q : 0)) | ((read_row_address_1[1:0] == 3) ? rf_words_12_q : 0))));
    assign read_row_address_2 = ((e_bank_pending & (e_inst[21:20] == 2)) ? e_inst[24:22] : ((read_bank_a == 2) ? u_id_rs1[4:2] : u_id_rs2[4:2]));
    assign read_banks_2 = (~(read_row_address_2[2] ? (((((read_row_address_2[1:0] == 0) ? rf_words_17_q : 0) | ((read_row_address_2[1:0] == 1) ? rf_words_21_q : 0)) | ((read_row_address_2[1:0] == 2) ? rf_words_25_q : 0)) | ((read_row_address_2[1:0] == 3) ? rf_words_29_q : 0)) : (((((read_row_address_2[1:0] == 0) ? rf_words_1_q : 0) | ((read_row_address_2[1:0] == 1) ? rf_words_5_q : 0)) | ((read_row_address_2[1:0] == 2) ? rf_words_9_q : 0)) | ((read_row_address_2[1:0] == 3) ? rf_words_13_q : 0))));
    assign read_row_address_3 = ((e_bank_pending & (e_inst[21:20] == 3)) ? e_inst[24:22] : ((read_bank_a == 3) ? u_id_rs1[4:2] : u_id_rs2[4:2]));
    assign read_banks_3 = (~(read_row_address_3[2] ? (((((read_row_address_3[1:0] == 0) ? rf_words_18_q : 0) | ((read_row_address_3[1:0] == 1) ? rf_words_22_q : 0)) | ((read_row_address_3[1:0] == 2) ? rf_words_26_q : 0)) | ((read_row_address_3[1:0] == 3) ? rf_words_30_q : 0)) : (((((read_row_address_3[1:0] == 0) ? rf_words_2_q : 0) | ((read_row_address_3[1:0] == 1) ? rf_words_6_q : 0)) | ((read_row_address_3[1:0] == 2) ? rf_words_10_q : 0)) | ((read_row_address_3[1:0] == 3) ? rf_words_14_q : 0))));
    assign rf_value_a = ((read_bank_a == 0) ? read_banks_0 : ((read_bank_a == 1) ? read_banks_1 : ((read_bank_a == 2) ? read_banks_2 : read_banks_3)));
    assign rf_value_b = ((read_bank_b == 0) ? read_banks_0 : ((read_bank_b == 1) ? read_banks_1 : ((read_bank_b == 2) ? read_banks_2 : read_banks_3)));
    assign ex_a = (e_forward_a ? w_result : e_a);
    assign ex_b = (e_forward_b ? w_result : e_b);
    assign immediate = {e_inst[31:25], e_immlow};
    assign upper_immediate = {e_inst[31:12], 12'd0};
    assign alu_b = (e_use_imm ? {immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate} : ex_b);
    assign forwarded_address = (d_data | {30'd0, immediate[1], 1'd0});
    assign ea = (e_address_forward ? forwarded_address : u_alu_sum);
    assign ex_bimm = {e_inst[31], e_inst[7], e_inst[30:25], e_inst[11:8], 1'd0};
    assign ex_jimm = {e_inst[31], e_inst[19:12], e_inst[20], e_inst[30:21], 1'd0};
    assign ex_relative = (e_pc_address + (u_ex_auipc ? upper_immediate : (u_ex_jal ? {ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm[20], ex_jimm} : (e_branch ? {ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm[12], ex_bimm} : 32'd0))));
    assign store_low_sum = u_alu_sum[17:0];
    assign store_high_zero = (ex_a[31:18] == 0);
    assign store_high_max = (ex_a[31:16] == 65535);
    assign integer_result = (u_ex_lui ? upper_immediate : (u_ex_auipc ? ex_relative : ((u_ex_jal | u_ex_jalr) ? (e_pc_address + 4) : u_alu_result)));
    assign response_zero_mask = ((w_f3[1:0] == 2) ? 4'd15 : (w_f3[0] ? (w_result[1] ? 4'd12 : 4'd3) : (4'd1 << w_result[1:0])));
    assign loaded_zero = (((((d_data[3:0] == 4'd0) | (~response_zero_mask[0])) & ((d_data[7:4] == 4'd0) | (~response_zero_mask[0]))) & (((d_data[11:8] == 4'd0) | (~response_zero_mask[1])) & ((d_data[15:12] == 4'd0) | (~response_zero_mask[1])))) & ((((d_data[19:16] == 4'd0) | (~response_zero_mask[2])) & ((d_data[23:20] == 4'd0) | (~response_zero_mask[2]))) & (((d_data[27:24] == 4'd0) | (~response_zero_mask[3])) & ((d_data[31:28] == 4'd0) | (~response_zero_mask[3])))));
    assign branch_equal_high = (ex_a[31:16] == ex_b[31:16]);
    assign branch_equal_low = (ex_a[15:0] == ex_b[15:0]);
    assign branch_equal = (branch_equal_high & branch_equal_low);
    assign branch_unsigned = u_alu_less_unsigned;
    assign branch_signed = ((ex_a[31] != ex_b[31]) ? ex_a[31] : branch_unsigned);
    assign branch_less = (u_ex_f3[1] ? branch_unsigned : branch_signed);
    assign plain_branch_condition = ((u_ex_f3[2] | (~u_ex_f3[1])) & ((u_ex_f3[2] ? branch_less : branch_equal) ^ u_ex_f3[0]));
    assign branch_condition = (e_zero_branch ? (loaded_zero ^ u_ex_f3[0]) : plain_branch_condition);
    assign taken = ((u_ex_jal | u_ex_jalr) | (u_ex_br & branch_condition));
    assign target = (u_ex_jalr ? (ea & 32'd4294967294) : ex_relative);
    assign actual_next = (taken ? target : (e_pc_address + 4));
    assign memory_low = (u_ex_store ? store_low_sum[1:0] : ea[1:0]);
    assign misaligned_data = ((u_ex_load | u_ex_store) & ((u_ex_f3[1:0] == 1) ? memory_low[0] : ((u_ex_f3[1:0] == 2) ? (memory_low != 0) : 1'd0)));
    assign misaligned_store = ((u_ex_f3[1:0] == 1) ? store_low_sum[0] : ((u_ex_f3[1:0] == 2) ? (store_low_sum[1:0] != 0) : 1'd0));
    assign misaligned_pc = ((taken & (target[1:0] != 0)) & (~e_zero_branch));
    assign ex_trap = (((((e_fetch_error | (~u_ex_legal)) | u_ex_ebreak) | u_ex_ecall) | misaligned_data) | misaligned_pc);
    assign memory_fault = ((e_fetch_error | (~u_ex_legal)) | misaligned_data);
    assign ex_cause = (e_fetch_error ? 4'd1 : ((~u_ex_legal) ? 4'd2 : (misaligned_pc ? 4'd0 : (misaligned_data ? (u_ex_store ? 4'd6 : 4'd4) : (u_ex_ebreak ? 4'd3 : 4'd11)))));
    assign address_spec_retry = ((((e_address_forward & immediate[1]) & d_data[1]) & (~e_fetch_error)) & u_ex_legal);
    assign md_wb_a_small = (w_result[31:9] == 0);
    assign md_wb_small = (w_result[31:8] == 0);
    assign md_a_small = (e_a[31:9] == 0);
    assign md_b_small = (e_b[31:8] == 0);
    assign md_small_inputs = ((e_forward_a ? md_wb_a_small : md_a_small) & (e_forward_b ? md_wb_small : md_b_small));
    assign md_wait = ((e_v & e_is_md) & (~u_md_ready));
    assign memory_wait = ((((e_v & (u_ex_load | u_ex_store)) & (~memory_fault)) & (~d_ready)) & (~address_spec_retry));
    assign byte_store_wait = (((e_v & e_is_sb) & (~e_fetch_error)) & d_byte_pause);
    assign hold = ((md_wait | memory_wait) | byte_store_wait);
    assign front_capture_slow = ((((((~halted) & (~wb_stop)) & (~e_pending)) & (~memory_wait)) & (~byte_store_wait)) & ((~(e_v & e_is_md)) | u_md_ready_slow));
    assign front_capture_small = ((~e_pending) & u_md_small_eligible);
    assign front_capture_enable = (front_capture_slow | (front_capture_small & md_small_inputs));
    assign front_hold = (hold | e_pending);
    assign ex_fire = (((e_v & (~hold)) & (~wb_stop)) & (~halted));
    assign prediction_miss = (e_predicted != actual_next);
    assign redirect_valid = ((PREDICT == 1) ? ex_fire : ((e_v & (~wb_stop)) & (~halted)));
    assign ordinary_taken = ((u_ex_jal | u_ex_jalr) | (u_ex_br & plain_branch_condition));
    assign ordinary_prediction_miss = (u_ex_jalr ? (~e_pred_taken) : (ordinary_taken ^ e_pred_taken));
    assign static_redirect_enable = ((redirect_valid & e_control) & ((~u_ex_jalr) | (~ea[1])));
    assign address_replay = (ex_fire & address_spec_retry);
    assign zero_redirect_enable = ((redirect_valid & e_control) & e_zero_branch);
    assign zero_redirect_when_zero = (zero_redirect_enable & (~e_zero_invert));
    assign zero_redirect_when_nonzero = (zero_redirect_enable & e_zero_invert);
    assign ordinary_redirect = ((static_redirect_enable & (~e_zero_branch)) & ordinary_prediction_miss);
    assign static_prediction_redirect = (((ordinary_redirect | address_replay) | (loaded_zero & zero_redirect_when_zero)) | ((~loaded_zero) & zero_redirect_when_nonzero));
    assign redirect = ((PREDICT == 1) ? (((redirect_valid & (~ex_trap)) & prediction_miss) | address_replay) : ((PREDICT == 2) ? static_prediction_redirect : ((static_redirect_enable & taken) | address_replay)));
    assign depend_a = (u_id_rs1 == u_ex_rd);
    assign depend_b = (u_id_rs2 == u_ex_rd);
    assign dependency_producer = (((e_v & u_ex_writes) & (~u_ex_load)) & (u_ex_rd != 0));
    assign load_pending = ((e_v & u_ex_load) & (u_ex_rd != 0));
    assign address_forward = ((((load_pending & (u_ex_f3 == 2)) & depend_a) & (u_id_load | u_id_jalr)) & ((i_data[31:20] == 0) | (u_id_load & (i_data[31:20] == 2))));
    assign zero_branch_forward = (((((load_pending & u_id_br) & (u_id_f3[2:1] == 0)) & (~i_error)) & (~i_data[8])) & (((u_id_rs1 == 0) & depend_b) | ((u_id_rs2 == 0) & depend_a)));
    assign load_hazard = (((load_pending & (depend_a | depend_b)) & (~zero_branch_forward)) & (~address_forward));
    assign fetch_retry = (d_v & i_retry);
    assign id_fire = ((((d_v & (~fetch_retry)) & (~front_hold)) & (~wb_stop)) & (~halted));
    assign program_target = ({15'd0, program_word} + ((program_data[6:0] == 111) ? {{11{program_data[31]}}, {program_data[31], program_data[19:12], program_data[20], program_data[30:22]}} : {{19{program_data[31]}}, {program_data[31], program_data[7], program_data[30:25], program_data[11:9]}}));
    assign program_word_zero = (program_data == 0);
    assign d_word_zero = (ex_b == 0);
    assign program_prediction = {1'd0, (program_data == 32871), {((((program_data[6:0] == 111) | ((program_data[6:0] == 99) & program_data[31])) & (~((program_data[6:0] == 111) ? program_data[21] : program_data[8]))) & (program_target[29:15] == 0)), program_target[14:0]}};
    assign id_control_legal = ((u_id_jal | (u_id_jalr & (u_id_f3 == 0))) | (u_id_br & ((u_id_f3[2:1] == 0) | u_id_f3[2])));
    assign return_target = (~rf_words_0_q);
    assign return_free = ((~(((dependency_producer | load_pending) & (u_ex_rd == 1)) | (wb_forward & (w_rd == 1)))) & (return_target[1:0] == 0));
    assign id_lookup_enable = ((((PREDICT == 2) & d_v) & (~i_error)) & (d_pc[14:12] == 0));
    assign id_lookup_static = (id_lookup_enable & i_prediction[15]);
    assign id_lookup_return = ((id_lookup_enable & i_prediction[16]) & return_free);
    assign id_prediction = (id_lookup_static | id_lookup_return);
    assign id_static_target = {15'd0, i_prediction[14:0], 2'd0};
    assign id_target = (id_lookup_return ? return_target : id_static_target);
    assign id_static = ((id_prediction & id_fire) & (~ex_fetch));
    assign wb_control = (((w_inst[6:0] == 99) | (w_inst[6:0] == 111)) | (w_inst[6:0] == 103));
    assign predicted_next = {u_predictor_next_pc[31:2], 2'd0};
    assign fast_branch_enable = ((((PREDICT == 2) & redirect_valid) & e_control) & e_branch);
    assign fast_eq_normal = ((fast_branch_enable & (~u_ex_f3[2])) & (~e_zero_branch));
    assign fast_eq_zero = (((fast_branch_enable & (~u_ex_f3[2])) & e_zero_branch) & zero_hint_eligible);
    assign fast_eq_request = (fast_eq_normal & (branch_equal ^ e_zero_invert));
    assign fast_branch = fast_eq_request;
    assign zero_hint_eligible = ((w_f3 == 2) & (w_result[31:17] == 0));
    assign zero_hint_when_zero = (fast_eq_zero & (~e_zero_invert));
    assign zero_hint_when_nonzero = (fast_eq_zero & e_zero_invert);
    assign fast_zero_redirect = ((d_zero_hint[0] & zero_hint_when_zero) | (d_zero_hint[1] & zero_hint_when_nonzero));
    assign ex_fetch = (fast_branch | fast_zero_redirect);
    assign fast_recovery_next = (e_pred_taken ? (e_pc_address + 4) : ex_relative);
    assign recovery_next = ((PREDICT == 2) ? (e_pred_taken ? (e_pc_address + 4) : target) : (address_spec_retry ? ex_relative : actual_next));
    assign i_valid = (((~halted) & (~wb_stop)) & (ex_fetch | ((~fetch_retry) & ((~d_v) | (~front_hold)))));
    assign sequential_fetch_address = {(pc_pending ? (pc + 30'd1) : pc), 2'd0};
    assign fast_fetch_target = fast_recovery_next;
    assign early_fetch_address = (ex_fetch ? fast_fetch_target : (id_lookup_return ? return_target : (id_lookup_static ? id_static_target : sequential_fetch_address)));
    assign i_fetch_address = early_fetch_address;
    assign i_addr = i_fetch_address;
    assign if_fire = (i_valid & i_ready);
    assign d_valid = ((((((e_v & (u_ex_load | u_ex_store)) & (~memory_fault)) & (~wb_stop)) & (~halted)) & (~byte_store_wait)) & (~address_spec_retry));
    assign d_write = u_ex_store;
    assign d_store_valid = (((((((e_v & u_ex_store) & (~e_fetch_error)) & u_ex_legal) & (~misaligned_store)) & (~wb_stop)) & (~halted)) & (~byte_store_wait));
    assign d_addr = ea;
    assign d_address_forward = e_address_forward;
    assign d_store_word = store_low_sum[16:2];
    assign d_store_local = (immediate[11] ? (u_alu_carry16 ? (store_high_zero & (~ex_a[17])) : (store_high_zero & (ex_a[17] ^ ex_a[16]))) : (u_alu_carry16 ? (((store_high_zero & (~ex_a[17])) & (~ex_a[16])) | store_high_max) : (store_high_zero & (~ex_a[17]))));
    assign d_wdata = (ex_b << {store_low_sum[1:0], 3'd0});
    assign d_byte = ex_b[7:0];
    assign d_wstrb = ((u_ex_f3 == 0) ? (4'd1 << store_low_sum[1:0]) : ((u_ex_f3 == 1) ? (4'd3 << store_low_sum[1:0]) : 4'd15));
    assign d_f3 = u_ex_f3;
    assign result = (e_is_md ? u_md_result : integer_result);
    assign jump_misaligned = ((u_ex_jal | u_ex_jalr) & target[1]);
    assign normal_result_ok = ((~e_fetch_error) & u_ex_legal);
    assign exception_wb_result = (((((((((e_fetch_error ? e_pc_address : 0) | (((~e_fetch_error) & (~u_ex_legal)) ? e_inst : 0)) | ((normal_result_ok & (u_ex_load | u_ex_store)) ? ea : 0)) | ((normal_result_ok & (u_ex_br | jump_misaligned)) ? target : 0)) | (((normal_result_ok & (u_ex_jal | u_ex_jalr)) & (~jump_misaligned)) ? (e_pc_address + 4) : 0)) | ((normal_result_ok & u_ex_lui) ? upper_immediate : 0)) | ((normal_result_ok & u_ex_auipc) ? ex_relative : 0)) | ((normal_result_ok & e_is_md) ? u_md_result : 0)) | ((normal_result_ok & (u_ex_immop | (u_ex_regop & (~e_is_md)))) ? u_alu_result : 0));
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
    assign rf_capture_b = (((capture_id & (~(wb_forward & (w_rd == u_id_rs2)))) | e_bank_pending) & (read_b_address != 0));
    assign holding_operand_a = ((((((capture_hold & e_address_forward) & (~md_high_workspace)) ? d_data : 0) | ((((capture_hold & (~e_address_forward)) & e_forward_a) & (~md_high_workspace)) ? w_result : 0)) | ((((e_pending & (~e_forward_a)) | ((capture_hold & (~e_address_forward)) & (~e_forward_a))) & (~md_high_workspace)) ? e_a : 0)) | ((md_workspace_write & u_md_accumulating) ? u_md_high_accumulate : 0));
    assign holding_operand_b = (((((capture_hold & e_forward_b) & (~md_partial_capture)) ? w_result : 0) | (((((e_pending & (~e_forward_b)) & (~e_bank_pending)) | (capture_hold & (~e_forward_b))) & (~md_partial_capture)) ? e_b : 0)) | (md_partial_capture ? u_md_partial_product[31:0] : 0));
    assign operand_next_a = ((holding_operand_a | (rf_value_a & {32{rf_capture_a}})) | (wb_data & {32{capture_wb_a}}));
    assign operand_next_b = ((holding_operand_b | (rf_value_b & {32{rf_capture_b}})) | (wb_data & {32{capture_wb_b}}));
    assign md_workspace_write = ((e_v & e_is_md) & hold);
    assign md_partial_capture = ((e_v & e_is_md) & u_md_partial_capture);
    assign md_high_workspace = (md_workspace_write & (~md_partial_capture));
    assign pc_sequential_word = (pc_pending ? (pc + 30'd2) : (pc + 30'd1));
    assign pc_normal_word = (fetch_retry ? d_pc : (id_static ? id_target[31:2] : (if_fire ? ((PREDICT == 1) ? predicted_next[31:2] : pc_sequential_word) : pc)));
    assign pc_next_word = (redirect ? recovery_next[31:2] : pc_normal_word);
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            retired <= 0;
            halted <= 0;
            stop_bus_error <= 0;
            pc <= 0;
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
            retired <= (retired + {63'd0, retire_enable});
            if ((~halted)) begin
                if (wb_stop) begin
                    halted <= 1;
                    stop_bus_error <= wb_bus_error;
                end else begin
                    pc <= pc_next_word;
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

    Decode u_id (
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
        .rs1(u_id_rs1),
        .use1(u_id_use1),
        .use2(u_id_use2)
    );
    Decode u_ex (
        .inst(e_inst),
        .f3(u_ex_f3),
        .rd(u_ex_rd),
        .writes(u_ex_writes),
        .load(u_ex_load),
        .store(u_ex_store),
        .auipc(u_ex_auipc),
        .jal(u_ex_jal),
        .lui(u_ex_lui),
        .jalr(u_ex_jalr),
        .br(u_ex_br),
        .legal(u_ex_legal),
        .ebreak(u_ex_ebreak),
        .ecall(u_ex_ecall),
        .immop(u_ex_immop),
        .regop(u_ex_regop)
    );
    RegisterWriteControl u_rf_write (
        .clk(clk),
        .rst_n(rst_n),
        .write(wb_write),
        .address(w_rd),
        .reset_q(u_rf_write_reset_q),
        .write_q(u_rf_write_write_q),
        .address_q(u_rf_write_address_q)
    );
    ClockedRegister rf_words_0 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 1)))),
        .value((~wb_data)),
        .q(rf_words_0_q)
    );
    ClockedRegister rf_words_1 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 2)))),
        .value((~wb_data)),
        .q(rf_words_1_q)
    );
    ClockedRegister rf_words_2 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 3)))),
        .value((~wb_data)),
        .q(rf_words_2_q)
    );
    ClockedRegister rf_words_3 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 4)))),
        .value((~wb_data)),
        .q(rf_words_3_q)
    );
    ClockedRegister rf_words_4 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 5)))),
        .value((~wb_data)),
        .q(rf_words_4_q)
    );
    ClockedRegister rf_words_5 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 6)))),
        .value((~wb_data)),
        .q(rf_words_5_q)
    );
    ClockedRegister rf_words_6 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 7)))),
        .value((~wb_data)),
        .q(rf_words_6_q)
    );
    ClockedRegister rf_words_7 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 8)))),
        .value((~wb_data)),
        .q(rf_words_7_q)
    );
    ClockedRegister rf_words_8 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 9)))),
        .value((~wb_data)),
        .q(rf_words_8_q)
    );
    ClockedRegister rf_words_9 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 10)))),
        .value((~wb_data)),
        .q(rf_words_9_q)
    );
    ClockedRegister rf_words_10 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 11)))),
        .value((~wb_data)),
        .q(rf_words_10_q)
    );
    ClockedRegister rf_words_11 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 12)))),
        .value((~wb_data)),
        .q(rf_words_11_q)
    );
    ClockedRegister rf_words_12 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 13)))),
        .value((~wb_data)),
        .q(rf_words_12_q)
    );
    ClockedRegister rf_words_13 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 14)))),
        .value((~wb_data)),
        .q(rf_words_13_q)
    );
    ClockedRegister rf_words_14 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 15)))),
        .value((~wb_data)),
        .q(rf_words_14_q)
    );
    ClockedRegister rf_words_15 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 16)))),
        .value((~wb_data)),
        .q(rf_words_15_q)
    );
    ClockedRegister rf_words_16 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 17)))),
        .value((~wb_data)),
        .q(rf_words_16_q)
    );
    ClockedRegister rf_words_17 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 18)))),
        .value((~wb_data)),
        .q(rf_words_17_q)
    );
    ClockedRegister rf_words_18 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 19)))),
        .value((~wb_data)),
        .q(rf_words_18_q)
    );
    ClockedRegister rf_words_19 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 20)))),
        .value((~wb_data)),
        .q(rf_words_19_q)
    );
    ClockedRegister rf_words_20 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 21)))),
        .value((~wb_data)),
        .q(rf_words_20_q)
    );
    ClockedRegister rf_words_21 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 22)))),
        .value((~wb_data)),
        .q(rf_words_21_q)
    );
    ClockedRegister rf_words_22 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 23)))),
        .value((~wb_data)),
        .q(rf_words_22_q)
    );
    ClockedRegister rf_words_23 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 24)))),
        .value((~wb_data)),
        .q(rf_words_23_q)
    );
    ClockedRegister rf_words_24 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 25)))),
        .value((~wb_data)),
        .q(rf_words_24_q)
    );
    ClockedRegister rf_words_25 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 26)))),
        .value((~wb_data)),
        .q(rf_words_25_q)
    );
    ClockedRegister rf_words_26 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 27)))),
        .value((~wb_data)),
        .q(rf_words_26_q)
    );
    ClockedRegister rf_words_27 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 28)))),
        .value((~wb_data)),
        .q(rf_words_27_q)
    );
    ClockedRegister rf_words_28 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 29)))),
        .value((~wb_data)),
        .q(rf_words_28_q)
    );
    ClockedRegister rf_words_29 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 30)))),
        .value((~wb_data)),
        .q(rf_words_29_q)
    );
    ClockedRegister rf_words_30 (
        .clk(clk),
        .rst_n((~u_rf_write_reset_q)),
        .enable((u_rf_write_reset_q | (u_rf_write_write_q & (u_rf_write_address_q == 31)))),
        .value((~wb_data)),
        .q(rf_words_30_q)
    );
    CompactAlu u_alu (
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
    MulDiv #(.EXTERNAL_ARITH(1), .EXTERNAL(1), .HOLD_RESULT(0)) u_md (
        .clk(clk),
        .external_small(md_small_inputs),
        .external_sum(u_alu_sum),
        .external_carry(u_alu_shared_sum[32]),
        .storage_partial({4'd0, e_b}),
        .rst_n(((rst_n & (~halted)) & (~wb_stop))),
        .start(((((e_v & e_is_md) & (~md_started)) & (~wb_stop)) & (~halted))),
        .consume((ex_fire & e_is_md)),
        .a(ex_a),
        .b(ex_b),
        .storage_a(w_result),
        .storage_b({w_mask[1:0], w_pc}),
        .storage_high(e_a),
        .op(u_ex_f3),
        .operand_next(u_md_operand_next),
        .quotient_next(u_md_quotient_next),
        .ready(u_md_ready),
        .ready_slow(u_md_ready_slow),
        .small_eligible(u_md_small_eligible),
        .result(u_md_result),
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
    ClockedPayload u_gated_e_is_md (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, u_id_md}),
        .q(u_gated_e_is_md_q)
    );
    ClockedPayload u_gated_e_is_sb (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, (u_id_store & (u_id_f3 == 0))}),
        .q(u_gated_e_is_sb_q)
    );
    ClockedPayload u_gated_e_inst (
        .clk(clk),
        .enable(front_capture_enable),
        .value(i_data),
        .q(u_gated_e_inst_q)
    );
    ClockedPayload u_gated_e_pc (
        .clk(clk),
        .enable(front_capture_enable),
        .value({2'd0, d_pc}),
        .q(u_gated_e_pc_q)
    );
    ClockedPayload u_gated_e_use_imm (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, (((u_id_immop | u_id_load) | u_id_store) | u_id_jalr)}),
        .q(u_gated_e_use_imm_q)
    );
    ClockedPayload u_gated_e_subtract (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, ((u_id_regop & (u_id_f3 == 0)) & i_data[30])}),
        .q(u_gated_e_subtract_q)
    );
    ClockedPayload u_gated_e_branch (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, u_id_br}),
        .q(u_gated_e_branch_q)
    );
    ClockedPayload u_gated_e_immlow (
        .clk(clk),
        .enable(front_capture_enable),
        .value({27'd0, (u_id_store ? i_data[11:7] : i_data[24:20])}),
        .q(u_gated_e_immlow_q)
    );
    ClockedPayload u_gated_e_pred_taken (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, id_prediction}),
        .q(u_gated_e_pred_taken_q)
    );
    ClockedPayload u_gated_e_control (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, (((~i_error) & id_control_legal) & (u_id_jalr ? 1'd1 : (u_id_jal ? (~i_data[21]) : (~i_data[8]))))}),
        .q(u_gated_e_control_q)
    );
    ClockedPayload u_gated_e_zero_branch (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, zero_branch_forward}),
        .q(u_gated_e_zero_branch_q)
    );
    ClockedPayload u_gated_e_fetch_error (
        .clk(clk),
        .enable(front_capture_enable),
        .value({31'd0, i_error}),
        .q(u_gated_e_fetch_error_q)
    );
    ClockedPayload u_gated_d_pc (
        .clk(clk),
        .enable(((~d_v) | front_capture_enable)),
        .value({2'd0, i_addr[31:2]}),
        .q(u_gated_d_pc_q)
    );
    ClockedPayload u_gated_w_rd (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({27'd0, u_ex_rd}),
        .q(u_gated_w_rd_q)
    );
    ClockedPayload u_gated_w_writes (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, (u_ex_writes & (u_ex_rd != 0))}),
        .q(u_gated_w_writes_q)
    );
    ClockedPayload u_gated_w_load (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, u_ex_load}),
        .q(u_gated_w_load_q)
    );
    ClockedPayload u_gated_w_store (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, u_ex_store}),
        .q(u_gated_w_store_q)
    );
    ClockedPayload u_gated_w_f3 (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({29'd0, u_ex_f3}),
        .q(u_gated_w_f3_q)
    );
    ClockedPayload u_gated_w_trap (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({31'd0, ex_trap}),
        .q(u_gated_w_trap_q)
    );
    ClockedPayload u_gated_w_cause (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value({28'd0, ex_cause}),
        .q(u_gated_w_cause_q)
    );
    ClockedPayload u_gated_w_result (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value((md_workspace_write ? u_md_operand_next : exception_wb_result)),
        .q(u_gated_w_result_q)
    );
    ClockedPayload u_gated_w_pc (
        .clk(clk),
        .enable(((e_v & (~halted)) & (~wb_stop))),
        .value((md_workspace_write ? u_md_quotient_next : {2'd0, e_pc})),
        .q(u_gated_w_pc_q)
    );
endmodule
