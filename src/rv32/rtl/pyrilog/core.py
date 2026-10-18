"""四级 RV32I_Zmmul 核心的存储与退休接口。"""

from pyrilog.ir import Module, Input, Output, Param
from pyrilog.hdl import concat
from .core4 import Rv32Core4


class Rv32Core(Module):
    PREDICT = Param(int, default=2)
    TRACE = Param(int, default=1)
    PERF = Param(int, default=0)
    # 组合接口显式传入四级实现的时钟与复位。
    clk = Input(1)
    rst_n = Input(1)
    i_ready = Input(1)
    i_data = Input(32)
    i_prediction = Input(18)
    program_word = Input(15)
    program_data = Input(32)
    i_error = Input(1)
    i_retry = Input(1)
    d_ready = Input(1)
    d_byte_pause = Input(1)
    d_data = Input(32)
    d_zero_hint = Input(2)
    d_error = Input(1)
    u_four = Rv32Core4(
        PREDICT=PREDICT,
        TRACE=TRACE,
        PERF=PERF,
        i_ready=i_ready,
        i_data=i_data,
        i_prediction=i_prediction,
        program_word=program_word,
        program_data=program_data,
        i_error=i_error,
        i_retry=i_retry,
        d_ready=d_ready,
        d_byte_pause=d_byte_pause,
        d_data=d_data,
        d_zero_hint=d_zero_hint,
        d_error=d_error,
    )
    program_word_zero = Output(1, u_four.program_word_zero)
    d_word_zero = Output(1, u_four.d_word_zero)
    program_prediction = Output(18, u_four.program_prediction)
    i_valid = Output(1, u_four.i_valid)
    i_addr = Output(32, u_four.i_addr)
    d_valid = Output(1, u_four.d_valid)
    d_write = Output(1, u_four.d_write)
    d_addr = Output(32, u_four.d_addr)
    d_address_forward = Output(1, u_four.d_address_forward)
    d_store_local = Output(1, u_four.d_store_local)
    d_store_valid = Output(1, u_four.d_store_valid)
    d_store_word = Output(15, u_four.d_store_word)
    d_wdata = Output(32, u_four.d_wdata)
    d_byte = Output(8, u_four.d_byte)
    d_wstrb = Output(4, u_four.d_wstrb)
    d_f3 = Output(3, u_four.d_f3)
    d_zero_encode = Output(2, concat((d_f3 == 2) & ~d_word_zero, (d_f3 == 2) & d_word_zero))
    program_zero_encode = Output(2, concat(~program_word_zero, program_word_zero))
    halt_o = Output(1, u_four.halt_o)
    cause_o = Output(4, u_four.cause_o)
    trap_pc_o = Output(32, u_four.trap_pc_o)
    trap_value_o = Output(32, u_four.trap_value_o)
    retired_o = Output(64, u_four.retired_o)
    load_stalls_o = Output(64, u_four.load_stalls_o)
    muldiv_stalls_o = Output(64, u_four.muldiv_stalls_o)
    redirects_o = Output(64, u_four.redirects_o)
    trace_valid = Output(1, u_four.trace_valid)
    trace_pc = Output(32, u_four.trace_pc)
    trace_inst = Output(32, u_four.trace_inst)
    trace_rd = Output(5, u_four.trace_rd)
    trace_data = Output(32, u_four.trace_data)
    trace_store = Output(1, u_four.trace_store)
    trace_addr = Output(32, u_four.trace_addr)
    trace_wdata = Output(32, u_four.trace_wdata)
    trace_mask = Output(4, u_four.trace_mask)
    trace_trap = Output(1, u_four.trace_trap)
