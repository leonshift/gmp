"""可配置项数的带标签 BTB 与两位饱和方向计数器；按退休指令更新。"""

from pyrilog.ir import Module, Input, Output, Logic
from pyrilog.hdl import bits, concat, mux
from pyrilog.hdl.cycle import State


class Predictor(Module, template=True):
    ENTRIES = 32
    INDEX_BITS = (ENTRIES - 1).bit_length()
    TAG_BITS = 30 - INDEX_BITS
    rst_n = Input(1)
    query_pc = Input(32)
    update = Input(1)
    update_pc = Input(32)
    update_target = Input(32)
    update_taken = Input(1)
    update_control = Input(1)
    present = State(ENTRIES, init=0)
    tags = State(TAG_BITS, depth=ENTRIES)
    targets = State(30, depth=ENTRIES)
    direction = State(2, depth=ENTRIES)
    qi = Logic(INDEX_BITS, query_pc[INDEX_BITS + 1 : 2])
    ui = Logic(INDEX_BITS, update_pc[INDEX_BITS + 1 : 2])
    hit = Logic(1, present[qi] & (tags[qi] == query_pc[31 : INDEX_BITS + 2]))
    train_hit = Logic(1, present[ui] & (tags[ui] == update_pc[31 : INDEX_BITS + 2]))
    counter = Logic(2, direction[ui])
    predict = Logic(1, hit & direction[qi][1])
    next_pc = Output(32, mux(predict, concat(targets[qi], bits(0, 2)), query_pc + 4))

    def cycle(self, reset=rst_n):
        if self.update:
            if self.update_control:
                self.present[self.ui] = 1
                self.tags[self.ui] = self.update_pc[31 : self.INDEX_BITS + 2]
                if self.update_taken:
                    self.targets[self.ui] = self.update_target[31:2]
                if ~self.train_hit:
                    self.direction[self.ui] = mux(self.update_taken, bits(2, 2), bits(1, 2))
                elif self.update_taken:
                    if self.counter != 3:
                        self.direction[self.ui] = self.counter + 1
                elif self.counter != 0:
                    self.direction[self.ui] = self.counter - 1
            elif self.train_hit:
                self.present[self.ui] = 0
