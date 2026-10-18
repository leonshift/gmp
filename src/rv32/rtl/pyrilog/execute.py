"""共享加减、比较和双向移位的 RV32 整数执行单元。"""

from pyrilog.ir import Module, Input, Output, Logic
from pyrilog.hdl import concat, mux, one_hot_mux, repeat, zext


def reverse_word(value):
    return concat(*(value[index] for index in range(32)))


class CompactAlu(Module):
    a = Input(32)
    add_a = Input(32)
    b = Input(32)
    f3 = Input(3)
    subtract = Input(1)
    arithmetic = Input(1)
    adder_b = Logic(32, b ^ repeat(subtract, 32))
    add_left = Logic(36, zext(add_a, 36))
    add_right = Logic(36, zext(adder_b, 36))
    carry = Logic(1, subtract)
    adder_low = Logic(17, zext(add_left[15:0], 17) + zext(add_right[15:0], 17) + zext(carry, 17))
    carry16 = Output(1, adder_low[16])
    adder_high = Logic(
        21, zext(add_left[35:16], 21) + zext(add_right[35:16], 21) + zext(adder_low[16], 21)
    )
    adder_sum = Logic(37, concat(adder_high, adder_low[15:0]))
    shared_sum = Output(37, adder_sum)
    sum = Output(32, adder_sum[31:0])
    equal = Output(1, a == b)
    less_unsigned = Output(1, add_a < b)
    less_signed = Output(1, mux(add_a[31] != b[31], add_a[31], less_unsigned))
    shift_left = Logic(1, ~f3[2])
    shift_input = Logic(32, mux(shift_left, reverse_word(a), a))
    # 最大右移 31 位，先复制符号位，使逻辑右移直接完成填充。
    shift_extended = Logic(63, concat(repeat(arithmetic & ~shift_left & a[31], 31), shift_input))
    shift_value = Logic(63, shift_extended >> b[4:0])
    shift_word = Logic(32, shift_value[31:0])
    shift_result = Logic(32, mux(shift_left, reverse_word(shift_word), shift_word))
    logic_value = Logic(32, (a & b & repeat(f3[1], 32)) | ((a ^ b) & repeat(~f3[0], 32)))
    result = Output(
        32,
        one_hot_mux(
            [f3 == 0, f3[1:0] == 1, f3 == 2, f3 == 3, f3[2] & (f3[1] | ~f3[0])],
            [sum, shift_result, zext(less_signed, 32), zext(less_unsigned, 32), logic_value],
        ),
    )
