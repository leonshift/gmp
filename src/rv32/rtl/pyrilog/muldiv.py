"""Zmmul 乘法接口，连接核心复用的工作区与整数 ALU。"""

from pyrilog.ir import Module, Input, Output, Param
from .muldiv_small import CompactMulDiv


class MulDiv(Module):
    EXTERNAL_ARITH = Param(int, default=0)
    external_small = Input(1)
    external_sum = Input(32)
    external_carry = Input(1)
    storage_partial = Input(36)
    EXTERNAL = Param(int, default=0)
    HOLD_RESULT = Param(int, default=1)
    # 纯组合包装显式提供时序子模块的时钟与复位。
    clk = Input(1)
    rst_n = Input(1)
    start = Input(1)
    consume = Input(1)
    a = Input(32)
    b = Input(32)
    storage_a = Input(32)
    storage_b = Input(32)
    storage_high = Input(32)
    op = Input(3)
    u_small = CompactMulDiv(
        EXTERNAL_ARITH=EXTERNAL_ARITH,
        external_small=external_small,
        external_sum=external_sum,
        external_carry=external_carry,
        storage_partial=storage_partial,
        EXTERNAL=EXTERNAL,
        HOLD_RESULT=HOLD_RESULT,
        start=start,
        consume=consume,
        a=a,
        b=b,
        storage_a=storage_a,
        storage_b=storage_b,
        storage_high=storage_high,
        op=op,
    )
    ready = Output(1, u_small.ready)
    result = Output(32, u_small.result)
    operand_next = Output(32, u_small.operand_next)
    quotient_next = Output(32, u_small.quotient_next)
    high_next = Output(32, u_small.high_next)
    accumulating = Output(1, u_small.accumulating)
    high_accumulate = Output(32, u_small.high_accumulate)
    partial_capture = Output(1, u_small.partial_capture)
    partial_product = Output(36, u_small.partial_product)
    ready_slow = Output(1, u_small.ready_slow)
    small_eligible = Output(1, u_small.small_eligible)
