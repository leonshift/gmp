"""以下降沿 FF 保持使能的字级寄存器时钟控制。"""

from pyrilog.ir import Module, Input, Output, Logic
from pyrilog.hdl.cycle import State


class RegisterClock(Module):
    clk = Input(1)
    enable = Input(1)
    held = State(1, reset=False)
    clock = Output(1, clk & held)

    def cycle(self, clk=clk.negedge, reset=None):
        self.held = self.enable


class RegisterWord(Module):
    rst_n = Input(1)
    value = Input(32)
    data = State(32, init=0xFFFFFFFF)
    q = Output(32, data)

    def cycle(self, reset=rst_n):
        self.data = self.value


class ClockedRegister(Module):
    clk = Input(1)
    rst_n = Input(1)
    enable = Input(1)
    value = Input(32)
    gated_clock = Logic(1, clk & enable)
    u_word = RegisterWord(clk=gated_clock, rst_n=rst_n, value=value)
    q = Output(32, u_word.q)


class PayloadWord(Module):
    value = Input(32)
    data = State(32, reset=False)
    q = Output(32, data)

    def cycle(self, reset=None):
        self.data = self.value


class ClockedPayload(Module):
    clk = Input(1)
    enable = Input(1)
    value = Input(32)
    u_gate = RegisterClock(clk=clk, enable=enable)
    u_word = PayloadWord(clk=u_gate.clock, value=value)
    q = Output(32, u_word.q)


class RegisterWriteControl(Module):
    clk = Input(1)
    rst_n = Input(1)
    write = Input(1)
    address = Input(5)
    held_write = State(1, reset=False)
    held_reset = State(1, reset=False)
    held_address = State(5, reset=False)
    write_q = Output(1, held_write)
    reset_q = Output(1, held_reset)
    address_q = Output(5, held_address)

    def cycle(self, clk=clk.negedge, reset=None):
        self.held_write = self.write
        self.held_reset = ~self.rst_n
        self.held_address = self.address
