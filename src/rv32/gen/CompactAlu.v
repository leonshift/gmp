module CompactAlu (
    input [31:0] a,
    input [31:0] add_a,
    input [31:0] b,
    input [2:0] f3,
    input subtract,
    input arithmetic,
    output logic carry16,
    output logic [36:0] shared_sum,
    output logic [31:0] sum,
    output logic equal,
    output logic less_unsigned,
    output logic less_signed,
    output logic [31:0] result
);
    logic [31:0] adder_b;
    logic [35:0] add_left;
    logic [35:0] add_right;
    logic carry;
    logic [16:0] adder_low;
    logic [20:0] adder_high;
    logic [36:0] adder_sum;
    logic shift_left;
    logic [31:0] shift_input;
    logic [62:0] shift_extended;
    logic [62:0] shift_value;
    logic [31:0] shift_word;
    logic [31:0] shift_result;
    logic [31:0] logic_value;

    assign adder_b = (b ^ {32{subtract}});
    assign add_left = {4'd0, add_a};
    assign add_right = {4'd0, adder_b};
    assign carry = subtract;
    assign adder_low = (({1'd0, add_left[15:0]} + {1'd0, add_right[15:0]}) + {16'd0, carry});
    assign carry16 = adder_low[16];
    assign adder_high = (({1'd0, add_left[35:16]} + {1'd0, add_right[35:16]}) + {20'd0, adder_low[16]});
    assign adder_sum = {adder_high, adder_low[15:0]};
    assign shared_sum = adder_sum;
    assign sum = adder_sum[31:0];
    assign equal = (a == b);
    assign less_unsigned = (add_a < b);
    assign less_signed = ((add_a[31] != b[31]) ? add_a[31] : less_unsigned);
    assign shift_left = (~f3[2]);
    assign shift_input = (shift_left ? {a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23], a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31]} : a);
    assign shift_extended = {{31{((arithmetic & (~shift_left)) & a[31])}}, shift_input};
    assign shift_value = (shift_extended >> b[4:0]);
    assign shift_word = shift_value[31:0];
    assign shift_result = (shift_left ? {shift_word[0], shift_word[1], shift_word[2], shift_word[3], shift_word[4], shift_word[5], shift_word[6], shift_word[7], shift_word[8], shift_word[9], shift_word[10], shift_word[11], shift_word[12], shift_word[13], shift_word[14], shift_word[15], shift_word[16], shift_word[17], shift_word[18], shift_word[19], shift_word[20], shift_word[21], shift_word[22], shift_word[23], shift_word[24], shift_word[25], shift_word[26], shift_word[27], shift_word[28], shift_word[29], shift_word[30], shift_word[31]} : shift_word);
    assign logic_value = (((a & b) & {32{f3[1]}}) | ((a ^ b) & {32{(~f3[0])}}));
    assign result = ((((((f3 == 0) ? sum : 0) | ((f3[1:0] == 1) ? shift_result : 0)) | ((f3 == 2) ? {31'd0, less_signed} : 0)) | ((f3 == 3) ? {31'd0, less_unsigned} : 0)) | ((f3[2] & (f3[1] | (~f3[0]))) ? logic_value : 0));
endmodule
