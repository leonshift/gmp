"""128 KiB ILM/DLM；前 16 KiB 附加静态取指译码，整字零值标志覆盖全部地址空间。"""

from pyrilog.ir import Module, Input, Output
from pyrilog.hdl import always, concat, bits
from pyrilog.hdl.cycle import State
from .config import ILM_PREDICT_BITS


class IlmDlmBitPlane(Module):
    """规范例外 2：TDP BRAM 推断要求每个端口独立时序过程。

    两个过程使用同一 clk，存储和输出均无复位。调用方排除跨口同字读写冲突。
    """

    clk = Input(1)
    a_en = Input(1)
    a_addr = Input(15)
    a_write = Input(1)
    a_data = Input(1)
    a_q = Output(1)
    b_en = Input(1)
    b_addr = Input(15)
    b_write = Input(1)
    b_data = Input(1)
    b_q = Output(1)
    mem = State(1, depth=32768)

    @always(clk)
    def port_a(self):
        if self.a_en:
            self.a_q = self.mem[self.a_addr]
            if self.a_write:
                self.mem[self.a_addr] = self.a_data

    @always(clk)
    def port_b(self):
        if self.b_en:
            self.b_q = self.mem[self.b_addr]
            if self.b_write:
                self.mem[self.b_addr] = self.b_data


class IlmDlmPredictionWord(Module):
    """ILM 预测信息使用同一时钟下的双端口存储，按九位宽存储字合并推断 BRAM。"""

    clk = Input(1)
    a_en = Input(1)
    a_addr = Input(ILM_PREDICT_BITS)
    a_q = Output(9)
    b_en = Input(1)
    b_addr = Input(ILM_PREDICT_BITS)
    b_write = Input(1)
    b_data = Input(9)
    b_q = Output(9)
    mem = State(9, depth=1 << ILM_PREDICT_BITS)

    @always(clk)
    def port_a(self):
        if self.a_en:
            self.a_q = self.mem[self.a_addr]

    @always(clk)
    def port_b(self):
        if self.b_en:
            self.b_q = self.mem[self.b_addr]
            if self.b_write:
                self.mem[self.b_addr] = self.b_data


class IlmDlmRam(Module):
    """32 个数据位平面、2 个九位预测存储字及 2 个整字零值位平面。"""

    clk = Input(1)
    a_en = Input(1)
    a_addr = Input(15)
    a_mask = Input(4)
    a_data = Input(32)
    b_en = Input(1)
    b_addr = Input(15)
    b_mask = Input(4)
    b_data = Input(32)
    b_prediction = Input(18)
    b_zero_hint = Input(2)
    b_prediction_write = Input(1)
    planes = []
    for _bit in range(32):
        planes.append(
            IlmDlmBitPlane(
                clk=clk,
                a_en=a_en,
                a_addr=a_addr,
                a_write=a_mask[_bit // 8],
                a_data=a_data[_bit],
                b_en=b_en,
                b_addr=b_addr,
                b_write=b_mask[_bit // 8],
                b_data=b_data[_bit],
            )
        )
    del _bit
    prediction_words = []
    for _word in range(2):
        prediction_words.append(
            IlmDlmPredictionWord(
                clk=clk,
                a_en=a_en,
                a_addr=a_addr[ILM_PREDICT_BITS - 1 : 0],
                b_en=b_en,
                b_addr=b_addr[ILM_PREDICT_BITS - 1 : 0],
                b_write=b_prediction_write & (b_addr[14:ILM_PREDICT_BITS] == 0),
                b_data=b_prediction[9 * _word + 8 : 9 * _word],
            )
        )
    del _word
    zero_planes = []
    for _bit in range(2):
        zero_planes.append(
            IlmDlmBitPlane(
                clk=clk,
                a_en=a_en,
                a_addr=a_addr,
                a_write=bits(0, 1),
                a_data=bits(0, 1),
                b_en=b_en,
                b_addr=b_addr,
                b_write=b_prediction_write,
                b_data=b_zero_hint[_bit],
            )
        )
    del _bit
    b_zero_hint_q = Output(2, concat(*(p.b_q for p in zero_planes[::-1])))
    a_prediction = Output(18, concat(*(word.a_q for word in prediction_words[::-1])))
    a_q = Output(32, concat(*(plane.a_q for plane in planes[::-1])))
    b_q = Output(32, concat(*(plane.b_q for plane in planes[::-1])))
