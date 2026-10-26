module CompactMulDiv #(
    parameter EXTERNAL = 0,
    parameter EXTERNAL_ARITH = 0,
    parameter PIPE_HIGH = 1,
    parameter SHARED_ALU = 0,
    parameter HOLD_RESULT = 1
) (
    input clk,
    input external_small,
    input [31:0] external_sum,
    input external_carry,
    input [35:0] storage_partial,
    input [36:0] shared_sum,
    input rst_n,
    input start,
    input consume,
    input [31:0] a,
    input [31:0] b,
    input [31:0] storage_a,
    input [31:0] storage_b,
    input [2:0] op,
    input [31:0] storage_high,
    output logic partial_capture,
    output logic [35:0] partial_product,
    output logic [35:0] shared_left,
    output logic [35:0] shared_right,
    output logic shared_carry,
    output logic accumulating,
    output logic [31:0] high_accumulate,
    output logic [31:0] high_next,
    output logic ready_slow,
    output logic small_eligible,
    output logic ready,
    output logic [31:0] result,
    output logic [31:0] operand_next,
    output logic [31:0] quotient_next
);
    logic [35:0] partial_saved;
    logic [2:0] phase;
    logic [2:0] fn_saved;
    logic [2:0] fn;
    logic [31:0] operand;
    logic [31:0] quotient;
    logic [31:0] operand_value;
    logic [31:0] quotient_value;
    logic [31:0] high_internal;
    logic [31:0] high;
    logic [4:0] count;
    logic sign_a;
    logic sign_b;
    logic input_sign_a;
    logic input_sign_b;
    logic [31:0] input_operand;
    logic [31:0] input_quotient;
    logic multiply_start;
    logic small_size;
    logic small_start;
    logic [16:0] small_product;
    logic [35:0] partial;
    logic [35:0] saved_partial;
    logic [35:0] run_partial;
    logic [2:0] run_phase;
    logic [2:0] initial_run_phase;
    logic [31:0] finish_unsigned;
    logic finish_negative;
    logic finish_carry;
    logic [35:0] add_left;
    logic [35:0] add_right;
    logic add_carry;
    logic [31:0] narrow_left;
    logic [31:0] narrow_right;
    logic [31:0] narrow_sum;
    logic [36:0] add_sum;
    logic [31:0] high_sum_low;
    logic [3:0] high_sum_upper;
    logic last_low;
    logic [31:0] streaming_result;
    logic [31:0] initial_operand;
    logic [31:0] initial_quotient;
    logic [31:0] corrected_result;

    assign fn = ((EXTERNAL != 0) ? op : fn_saved);
    assign operand_value = ((EXTERNAL != 0) ? storage_a : operand);
    assign quotient_value = ((EXTERNAL != 0) ? storage_b : quotient);
    assign high = ((EXTERNAL != 0) ? storage_high : high_internal);
    assign input_sign_a = (a[31] & ((op == 1) | (op == 2)));
    assign input_sign_b = (b[31] & (op == 1));
    assign input_operand = b;
    assign input_quotient = a;
    assign multiply_start = (((phase == 0) & start) & (op == 0));
    assign small_size = ((EXTERNAL_ARITH != 0) ? external_small : ((a[31:9] == 0) & (b[31:8] == 0)));
    assign small_start = (multiply_start & small_size);
    assign small_product = (a[8:0] * b[7:0]);
    assign partial = (operand_value * quotient_value[0]);
    assign saved_partial = ((EXTERNAL != 0) ? storage_partial : partial_saved);
    assign run_partial = (((PIPE_HIGH != 0) & (fn != 0)) ? saved_partial : partial);
    assign partial_capture = ((PIPE_HIGH != 0) & (phase == 6));
    assign partial_product = partial;
    assign run_phase = (((PIPE_HIGH != 0) & (fn != 0)) ? 3'd6 : 3'd3);
    assign initial_run_phase = (((PIPE_HIGH != 0) & (op != 0)) ? 3'd6 : 3'd3);
    assign finish_unsigned = high;
    assign finish_negative = ((fn != 0) & (sign_a ^ sign_b));
    assign finish_carry = (quotient_value == 0);
    assign add_left = ((phase == 3) ? {4'd0, high} : 36'd0);
    assign add_right = ((phase == 1) ? (~{4'd0, operand_value}) :
                       ((phase == 2) ? (~{4'd0, quotient_value}) :
                       ((phase == 4) ? (~{4'd0, finish_unsigned}) :
                       run_partial)));
    assign add_carry = ((phase == 4) ? finish_carry : (phase != 3));
    assign narrow_left = ((phase == 3) ? high : 32'd0);
    assign narrow_right = (((((phase == 1) ? (~operand_value) : 0) | ((phase == 2) ? (~quotient_value) : 0))
                           | ((phase == 4) ? (~high) : 0)) | ((phase == 3) ? partial[31:0] : 0));
    assign narrow_sum = ((narrow_left + narrow_right) + {31'd0, add_carry});
    assign add_sum = ((EXTERNAL_ARITH != 0) ? {5'd0, narrow_sum} :
                     ((SHARED_ALU != 0) ? shared_sum :
                     (({1'd0, add_left} + {1'd0, add_right}) + {36'd0, add_carry})));
    assign high_sum_low = ((EXTERNAL_ARITH != 0) ? external_sum : add_sum[31:0]);
    assign high_sum_upper = ((EXTERNAL_ARITH != 0) ? (storage_partial[35:32] + {3'd0, external_carry}) : add_sum[35:32]);
    assign shared_left = add_left;
    assign shared_right = add_right;
    assign shared_carry = add_carry;
    assign last_low = (((phase == 3) & (fn == 0)) & (quotient_value[31:1] == 0));
    assign accumulating = (phase == 3);
    assign high_accumulate = ((fn == 0) ? add_sum[31:0] : {high_sum_upper[0], high_sum_low[31:1]});
    assign high_next = (((phase == 0) & start)
                        ? ((((op == 0) & (HOLD_RESULT != 0)) & small_start) ? {15'd0, small_product} : 32'd0) :
                       ((phase == 3) ? high_accumulate :
                       high));
    assign ready_slow = ((phase == 5) | last_low);
    assign small_eligible = multiply_start;
    assign ready = (ready_slow | small_start);
    assign streaming_result = (small_start ? {15'd0, small_product} : ((fn == 0) ? add_sum[31:0] : quotient_value));
    assign result = ((HOLD_RESULT == 0) ? streaming_result :
                    (small_start ? {15'd0, small_product} :
                    (last_low ? add_sum[31:0] :
                    ((fn == 0) ? high :
                    quotient_value))));
    assign initial_operand = input_operand;
    assign initial_quotient = input_quotient;
    assign corrected_result = (finish_negative ? add_sum[31:0] : finish_unsigned);
    assign operand_next = (((phase == 0) & start) ? initial_operand :
                          ((phase == 1) ? add_sum[31:0] :
                          (((phase == 3) & (fn == 0)) ? (operand_value << 1) :
                          operand_value)));
    assign quotient_next = (((phase == 0) & start) ? initial_quotient :
                           ((phase == 2) ? add_sum[31:0] :
                           ((phase == 3) ? ((fn == 0) ? (quotient_value >> 1) : {high_sum_low[0], quotient_value[31:1]})
                            :
                           ((phase == 4) ? corrected_result :
                           quotient_value))));
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            fn_saved <= 0;
            phase <= 0;
            count <= 0;
            sign_a <= 0;
            sign_b <= 0;
        end else begin
            if ((phase == 0)) begin
                if (start) begin
                    fn_saved <= op;
                    if ((op == 0)) begin
                        phase <= (small_start ? (((HOLD_RESULT == 0) | consume) ? 3'd0 : 3'd5) : 3'd3);
                    end else begin
                        phase <= (input_sign_b ? 3'd1 : (input_sign_a ? 3'd2 : initial_run_phase));
                    end
                    count <= 31;
                    sign_a <= input_sign_a;
                    sign_b <= input_sign_b;
                end
            end else begin
                if ((phase == 1)) begin
                    phase <= (sign_a ? 3'd2 : run_phase);
                end else begin
                    if ((phase == 2)) begin
                        phase <= run_phase;
                    end else begin
                        if ((phase == 3)) begin
                            count <= (count - 1);
                            if ((fn == 0)) begin
                                if ((quotient_value[31:1] == 0)) begin
                                    phase <= (((HOLD_RESULT == 0) | consume) ? 3'd0 : 3'd5);
                                end
                            end else begin
                                if ((count == 0)) begin
                                    phase <= 4;
                                end else begin
                                    phase <= ((PIPE_HIGH != 0) ? 3'd6 : 3'd3);
                                end
                            end
                        end else begin
                            if ((phase == 6)) begin
                                phase <= 3;
                            end else begin
                                if ((phase == 4)) begin
                                    phase <= 5;
                                end else begin
                                    if ((phase == 5)) begin
                                        if (((HOLD_RESULT == 0) | consume)) begin
                                            phase <= 0;
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
    always_ff @(posedge clk) begin
        operand <= operand_next;
        quotient <= quotient_next;
        if ((phase == 0)) begin
            if (start) begin
                if ((op == 0)) begin
                    high_internal <= (((HOLD_RESULT != 0) & small_start) ? {15'd0, small_product} : 32'd0);
                end else begin
                    high_internal <= 0;
                end
            end
        end else begin
            if ((!(phase == 1))) begin
                if ((!(phase == 2))) begin
                    if ((phase == 3)) begin
                        high_internal <= high_accumulate;
                    end else begin
                        if ((phase == 6)) begin
                            partial_saved <= partial;
                        end
                    end
                end
            end
        end
    end
endmodule
