"""Zmmul 紧凑乘法：低半乘积逐位累加，高半乘积复用整数 ALU。"""

from pyrilog.ir import Module, Input, Output, Logic, Param
from pyrilog.hdl import bits, concat, mux, zext, one_hot_mux
from pyrilog.hdl.cycle import State


class CompactMulDiv(Module):
    """外部模式复用 EX/WB 寄存器保存工作区，内部模式保持结果直至消费。"""

    EXTERNAL = Param(int, default=0)
    EXTERNAL_ARITH = Param(int, default=0)
    external_small = Input(1)
    external_sum = Input(32)
    external_carry = Input(1)
    storage_partial = Input(36)
    partial_saved = State(36, reset=False)
    # 关闭保持时，调用方必须在 ready 当前拍消费或复位；EX 停顿控制满足此条件。
    HOLD_RESULT = Param(int, default=1)
    rst_n = Input(1)
    start = Input(1)
    consume = Input(1)
    a = Input(32)
    b = Input(32)
    storage_a = Input(32)
    storage_b = Input(32)
    op = Input(3)
    phase = State(3, init=0)
    fn_saved = State(3, init=0)
    fn = Logic(3, mux(EXTERNAL != 0, op, fn_saved))
    operand = State(32, reset=False)
    quotient = State(32, reset=False)
    operand_value = Logic(32, mux(EXTERNAL != 0, storage_a, operand))
    quotient_value = Logic(32, mux(EXTERNAL != 0, storage_b, quotient))
    storage_high = Input(32)
    high_internal = State(32, reset=False)
    high = Logic(32, mux(EXTERNAL != 0, storage_high, high_internal))
    count = State(5, init=0)
    sign_a = State(1, init=0)
    sign_b = State(1, init=0)
    input_sign_a = Logic(1, a[31] & ((op == 1) | (op == 2)))
    input_sign_b = Logic(1, b[31] & (op == 1))
    input_operand = Logic(32, b)
    input_quotient = Logic(32, a)
    multiply_start = Logic(1, (phase == 0) & start & (op == 0))
    small_size = Logic(1, mux(EXTERNAL_ARITH != 0, external_small, (a[31:9] == 0) & (b[31:8] == 0)))
    small_start = Logic(1, multiply_start & small_size)
    small_product = Logic(17, a[8:0] * b[7:0])
    partial = Logic(36, operand_value * quotient_value[0:0])
    saved_partial = Logic(36, mux(EXTERNAL != 0, storage_partial, partial_saved))
    run_partial = Logic(36, mux(fn != 0, saved_partial, partial))
    partial_capture = Output(1, phase == 6)
    partial_product = Output(36, partial)
    run_phase = Logic(3, mux(fn != 0, bits(6, 3), bits(3, 3)))
    initial_run_phase = Logic(3, mux(op != 0, bits(6, 3), bits(3, 3)))
    finish_unsigned = Logic(32, high)
    finish_negative = Logic(1, (fn != 0) & (sign_a ^ sign_b))
    finish_carry = Logic(1, quotient_value == 0)
    add_left = Logic(36, mux(phase == 3, zext(high, 36), bits(0, 36)))
    add_right = Logic(
        36,
        mux(
            phase == 1,
            ~zext(operand_value, 36),
            mux(
                phase == 2,
                ~zext(quotient_value, 36),
                mux(phase == 4, ~zext(finish_unsigned, 36), run_partial),
            ),
        ),
    )
    add_carry = Logic(1, mux(phase == 4, finish_carry, phase != 3))
    narrow_left = Logic(32, mux(phase == 3, high, bits(0, 32)))
    narrow_right = Logic(
        32,
        one_hot_mux(
            [phase == 1, phase == 2, phase == 4, phase == 3],
            [~operand_value, ~quotient_value, ~high, partial[31:0]],
        ),
    )
    narrow_sum = Logic(32, narrow_left + narrow_right + zext(add_carry, 32))
    add_sum = Logic(
        37,
        mux(
            EXTERNAL_ARITH != 0,
            zext(narrow_sum, 37),
            zext(add_left, 37) + zext(add_right, 37) + zext(add_carry, 37),
        ),
    )
    high_sum_low = Logic(32, mux(EXTERNAL_ARITH != 0, external_sum, add_sum[31:0]))
    high_sum_upper = Logic(
        4,
        mux(EXTERNAL_ARITH != 0, storage_partial[35:32] + zext(external_carry, 4), add_sum[35:32]),
    )
    last_low = Logic(1, (phase == 3) & (fn == 0) & (quotient_value[31:1] == 0))
    accumulating = Output(1, phase == 3)
    high_accumulate = Output(
        32, mux(fn == 0, add_sum[31:0], concat(high_sum_upper[0:0], high_sum_low[31:1]))
    )
    high_next = Output(
        32,
        mux(
            (phase == 0) & start,
            mux((op == 0) & (HOLD_RESULT != 0) & small_start, zext(small_product, 32), bits(0, 32)),
            mux(phase == 3, high_accumulate, high),
        ),
    )
    ready_slow = Output(1, (phase == 5) | last_low)
    small_eligible = Output(1, multiply_start)
    ready = Output(1, ready_slow | small_start)
    streaming_result = Logic(
        32, mux(small_start, zext(small_product, 32), mux(fn == 0, add_sum[31:0], quotient_value))
    )
    result = Output(
        32,
        mux(
            HOLD_RESULT == 0,
            streaming_result,
            mux(
                small_start,
                zext(small_product, 32),
                mux(last_low, add_sum[31:0], mux(fn == 0, high, quotient_value)),
            ),
        ),
    )
    initial_operand = Logic(32, input_operand)
    initial_quotient = Logic(32, input_quotient)
    corrected_result = Logic(32, mux(finish_negative, add_sum[31:0], finish_unsigned))
    operand_next = Output(
        32,
        mux(
            (phase == 0) & start,
            initial_operand,
            mux(
                phase == 1,
                add_sum[31:0],
                mux((phase == 3) & (fn == 0), operand_value << 1, operand_value),
            ),
        ),
    )
    quotient_next = Output(
        32,
        mux(
            (phase == 0) & start,
            initial_quotient,
            mux(
                phase == 2,
                add_sum[31:0],
                mux(
                    phase == 3,
                    mux(
                        fn == 0,
                        quotient_value >> 1,
                        concat(high_sum_low[0:0], quotient_value[31:1]),
                    ),
                    mux(phase == 4, corrected_result, quotient_value),
                ),
            ),
        ),
    )

    def cycle(self, reset=rst_n):
        self.operand = self.operand_next
        self.quotient = self.quotient_next
        if self.phase == 0:
            if self.start:
                self.fn_saved = self.op
                if self.op == 0:
                    self.high_internal = mux(
                        (self.HOLD_RESULT != 0) & self.small_start,
                        zext(self.small_product, 32),
                        bits(0, 32),
                    )
                    self.phase = mux(
                        self.small_start,
                        mux((self.HOLD_RESULT == 0) | self.consume, bits(0, 3), bits(5, 3)),
                        bits(3, 3),
                    )
                else:
                    self.high_internal = 0
                    self.phase = mux(
                        self.input_sign_b,
                        bits(1, 3),
                        mux(self.input_sign_a, bits(2, 3), self.initial_run_phase),
                    )
                self.count = 31
                self.sign_a = self.input_sign_a
                self.sign_b = self.input_sign_b
        elif self.phase == 1:
            self.phase = mux(self.sign_a, bits(2, 3), self.run_phase)
        elif self.phase == 2:
            self.phase = self.run_phase
        elif self.phase == 3:
            self.count = self.count - 1
            self.high_internal = self.high_accumulate
            if self.fn == 0:
                # 低半乘法按模 2**32 累加；每拍左移操作数，结果无需动态对齐。
                if self.quotient_value[31:1] == 0:
                    self.phase = mux((self.HOLD_RESULT == 0) | self.consume, bits(0, 3), bits(5, 3))
            else:
                if self.count == 0:
                    self.phase = 4
                else:
                    self.phase = 6
        elif self.phase == 6:
            self.partial_saved = self.partial
            self.phase = 3
        elif self.phase == 4:
            self.phase = 5
        elif self.phase == 5:
            if (self.HOLD_RESULT == 0) | self.consume:
                self.phase = 0
