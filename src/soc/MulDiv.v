module MulDiv #(
    parameter SERIAL = 0,
    parameter EXTERNAL_ARITH = 0,
    parameter PIPE_HIGH = 1,
    parameter SHARED_ALU = 0,
    parameter EXTERNAL = 0,
    parameter HOLD_RESULT = 1
) (
    input external_small,
    input [31:0] external_sum,
    input external_carry,
    input [35:0] storage_partial,
    input [36:0] shared_sum,
    input clk,
    input rst_n,
    input start,
    input consume,
    input [31:0] a,
    input [31:0] b,
    input [31:0] storage_a,
    input [31:0] storage_b,
    input [31:0] storage_high,
    input [2:0] op,
    output logic ready,
    output logic [31:0] result,
    output logic [31:0] operand_next,
    output logic [31:0] quotient_next,
    output logic [35:0] shared_left,
    output logic [35:0] shared_right,
    output logic shared_carry,
    output logic [31:0] high_next,
    output logic accumulating,
    output logic [31:0] high_accumulate,
    output logic partial_capture,
    output logic [35:0] partial_product,
    output logic ready_slow,
    output logic small_eligible
);
    logic u_small_ready;
    logic u_legacy_ready;
    logic [31:0] u_small_result;
    logic [31:0] u_legacy_result;
    logic [31:0] u_small_operand_next;
    logic [31:0] u_small_quotient_next;
    logic [35:0] u_small_shared_left;
    logic [35:0] u_small_shared_right;
    logic u_small_shared_carry;
    logic [31:0] u_small_high_next;
    logic u_small_accumulating;
    logic [31:0] u_small_high_accumulate;
    logic u_small_partial_capture;
    logic [35:0] u_small_partial_product;
    logic u_small_ready_slow;
    logic u_small_small_eligible;

    assign ready = ((SERIAL == 4) ? u_small_ready : u_legacy_ready);
    assign result = ((SERIAL == 4) ? u_small_result : u_legacy_result);
    assign operand_next = u_small_operand_next;
    assign quotient_next = u_small_quotient_next;
    assign shared_left = u_small_shared_left;
    assign shared_right = u_small_shared_right;
    assign shared_carry = u_small_shared_carry;
    assign high_next = u_small_high_next;
    assign accumulating = u_small_accumulating;
    assign high_accumulate = u_small_high_accumulate;
    assign partial_capture = u_small_partial_capture;
    assign partial_product = u_small_partial_product;
    assign ready_slow = ((SERIAL == 4) ? u_small_ready_slow : u_legacy_ready);
    assign small_eligible = ((SERIAL == 4) & u_small_small_eligible);

    LegacyMulDiv #(.SERIAL(SERIAL)) u_legacy (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .consume(consume),
        .a(a),
        .b(b),
        .op(op),
        .fast_small(((EXTERNAL_ARITH != 0) ? external_small : ((a[31:9] == 0) & (b[31:8] == 0)))),
        .ready(u_legacy_ready),
        .result(u_legacy_result)
    );
    CompactMulDiv #(.EXTERNAL_ARITH(EXTERNAL_ARITH), .PIPE_HIGH(PIPE_HIGH), .SHARED_ALU(SHARED_ALU), .EXTERNAL(EXTERNAL), .HOLD_RESULT(HOLD_RESULT)) u_small (
        .clk(clk),
        .rst_n(rst_n),
        .external_small(external_small),
        .external_sum(external_sum),
        .external_carry(external_carry),
        .storage_partial(storage_partial),
        .shared_sum(shared_sum),
        .start(start),
        .consume(consume),
        .a(a),
        .b(b),
        .storage_a(storage_a),
        .storage_b(storage_b),
        .storage_high(storage_high),
        .op(op),
        .ready(u_small_ready),
        .result(u_small_result),
        .operand_next(u_small_operand_next),
        .quotient_next(u_small_quotient_next),
        .shared_left(u_small_shared_left),
        .shared_right(u_small_shared_right),
        .shared_carry(u_small_shared_carry),
        .high_next(u_small_high_next),
        .accumulating(u_small_accumulating),
        .high_accumulate(u_small_high_accumulate),
        .partial_capture(u_small_partial_capture),
        .partial_product(u_small_partial_product),
        .ready_slow(u_small_ready_slow),
        .small_eligible(u_small_small_eligible)
    );
endmodule
