"""用板载参考时钟交叉测量功能时钟，跨域计数使用 Gray 编码。"""

from pyrilog.ir import Module, Input, Output, Logic
from pyrilog.hdl.cycle import State


def binary(gray):
    x = gray ^ (gray >> 16)
    x = x ^ (x >> 8)
    x = x ^ (x >> 4)
    x = x ^ (x >> 2)
    return x ^ (x >> 1)


class ClockCounter(Module):
    count = State(32, init=0)
    next_count = Logic(32, count + 1)
    gray_q = State(32, init=0)
    gray = Output(32, gray_q)

    def cycle(self):
        self.count = self.next_count
        self.gray_q = self.next_count ^ (self.next_count >> 1)


class ClockWindow(Module):
    gray_in = Input(32)
    sync1 = State(32, init=0)
    sync2 = State(32, init=0)
    window = State(16, init=0)
    previous = State(32, init=0)
    measured = State(32, init=0)
    current = Logic(32, binary(sync2))
    gray_q = State(32, init=0)
    gray_out = Output(32, gray_q)

    def cycle(self):
        self.sync1 = self.gray_in
        self.sync2 = self.sync1
        self.gray_q = self.measured ^ (self.measured >> 1)
        if self.window == 49999:
            self.window = 0
            self.measured = self.current - self.previous
            self.previous = self.current
        else:
            self.window = self.window + 1


class ClockResult(Module):
    gray_in = Input(32)
    sync1 = State(32, init=0)
    sync2 = State(32, init=0)
    measured = Output(32, binary(sync2))

    def cycle(self):
        self.sync1 = self.gray_in
        self.sync2 = self.sync1
