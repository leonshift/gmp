module Rv32Core #(
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
    output logic [31:0] d_addr,
    output logic d_address_forward,
    output logic d_store_local,
    output logic d_store_valid,
    output logic [14:0] d_store_word,
    output logic [31:0] d_wdata,
    output logic [7:0] d_byte,
    output logic [3:0] d_wstrb,
    output logic [2:0] d_f3,
    output logic [1:0] d_zero_encode,
    output logic [1:0] program_zero_encode,
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
    logic u_four_program_word_zero;
    logic u_four_d_word_zero;
    logic [17:0] u_four_program_prediction;
    logic u_four_i_valid;
    logic [31:0] u_four_i_addr;
    logic u_four_d_valid;
    logic u_four_d_write;
    logic [31:0] u_four_d_addr;
    logic u_four_d_address_forward;
    logic u_four_d_store_local;
    logic u_four_d_store_valid;
    logic [14:0] u_four_d_store_word;
    logic [31:0] u_four_d_wdata;
    logic [7:0] u_four_d_byte;
    logic [3:0] u_four_d_wstrb;
    logic [2:0] u_four_d_f3;
    logic u_four_halt_o;
    logic [3:0] u_four_cause_o;
    logic [31:0] u_four_trap_pc_o;
    logic [31:0] u_four_trap_value_o;
    logic [63:0] u_four_retired_o;
    logic [63:0] u_four_load_stalls_o;
    logic [63:0] u_four_muldiv_stalls_o;
    logic [63:0] u_four_redirects_o;
    logic u_four_trace_valid;
    logic [31:0] u_four_trace_pc;
    logic [31:0] u_four_trace_inst;
    logic [4:0] u_four_trace_rd;
    logic [31:0] u_four_trace_data;
    logic u_four_trace_store;
    logic [31:0] u_four_trace_addr;
    logic [31:0] u_four_trace_wdata;
    logic [3:0] u_four_trace_mask;
    logic u_four_trace_trap;

    assign program_word_zero = u_four_program_word_zero;
    assign d_word_zero = u_four_d_word_zero;
    assign program_prediction = u_four_program_prediction;
    assign i_valid = u_four_i_valid;
    assign i_addr = u_four_i_addr;
    assign d_valid = u_four_d_valid;
    assign d_write = u_four_d_write;
    assign d_addr = u_four_d_addr;
    assign d_address_forward = u_four_d_address_forward;
    assign d_store_local = u_four_d_store_local;
    assign d_store_valid = u_four_d_store_valid;
    assign d_store_word = u_four_d_store_word;
    assign d_wdata = u_four_d_wdata;
    assign d_byte = u_four_d_byte;
    assign d_wstrb = u_four_d_wstrb;
    assign d_f3 = u_four_d_f3;
    assign d_zero_encode = {((d_f3 == 2) & (~d_word_zero)), ((d_f3 == 2) & d_word_zero)};
    assign program_zero_encode = {(~program_word_zero), program_word_zero};
    assign halt_o = u_four_halt_o;
    assign cause_o = u_four_cause_o;
    assign trap_pc_o = u_four_trap_pc_o;
    assign trap_value_o = u_four_trap_value_o;
    assign retired_o = u_four_retired_o;
    assign load_stalls_o = u_four_load_stalls_o;
    assign muldiv_stalls_o = u_four_muldiv_stalls_o;
    assign redirects_o = u_four_redirects_o;
    assign trace_valid = u_four_trace_valid;
    assign trace_pc = u_four_trace_pc;
    assign trace_inst = u_four_trace_inst;
    assign trace_rd = u_four_trace_rd;
    assign trace_data = u_four_trace_data;
    assign trace_store = u_four_trace_store;
    assign trace_addr = u_four_trace_addr;
    assign trace_wdata = u_four_trace_wdata;
    assign trace_mask = u_four_trace_mask;
    assign trace_trap = u_four_trace_trap;

    Rv32Core4 #(.PREDICT(PREDICT), .TRACE(TRACE), .PERF(PERF)) u_four (
        .clk(clk),
        .rst_n(rst_n),
        .i_ready(i_ready),
        .i_data(i_data),
        .i_prediction(i_prediction),
        .program_word(program_word),
        .program_data(program_data),
        .i_error(i_error),
        .i_retry(i_retry),
        .d_ready(d_ready),
        .d_byte_pause(d_byte_pause),
        .d_data(d_data),
        .d_zero_hint(d_zero_hint),
        .d_error(d_error),
        .program_word_zero(u_four_program_word_zero),
        .d_word_zero(u_four_d_word_zero),
        .program_prediction(u_four_program_prediction),
        .i_valid(u_four_i_valid),
        .i_addr(u_four_i_addr),
        .d_valid(u_four_d_valid),
        .d_write(u_four_d_write),
        .d_addr(u_four_d_addr),
        .d_address_forward(u_four_d_address_forward),
        .d_store_local(u_four_d_store_local),
        .d_store_valid(u_four_d_store_valid),
        .d_store_word(u_four_d_store_word),
        .d_wdata(u_four_d_wdata),
        .d_byte(u_four_d_byte),
        .d_wstrb(u_four_d_wstrb),
        .d_f3(u_four_d_f3),
        .halt_o(u_four_halt_o),
        .cause_o(u_four_cause_o),
        .trap_pc_o(u_four_trap_pc_o),
        .trap_value_o(u_four_trap_value_o),
        .retired_o(u_four_retired_o),
        .load_stalls_o(u_four_load_stalls_o),
        .muldiv_stalls_o(u_four_muldiv_stalls_o),
        .redirects_o(u_four_redirects_o),
        .trace_valid(u_four_trace_valid),
        .trace_pc(u_four_trace_pc),
        .trace_inst(u_four_trace_inst),
        .trace_rd(u_four_trace_rd),
        .trace_data(u_four_trace_data),
        .trace_store(u_four_trace_store),
        .trace_addr(u_four_trace_addr),
        .trace_wdata(u_four_trace_wdata),
        .trace_mask(u_four_trace_mask),
        .trace_trap(u_four_trace_trap)
    );
endmodule
