"""RV32I_Zmmul 的组合译码与定宽运算。"""

from pyrilog.ir import Module, Input, Output, Logic
from pyrilog.hdl import bits, concat, mux, sext, zext, repeat


def instruction_prediction_target(word, instruction):
    jal = instruction[6:0] == 0x6F
    jword = concat(instruction[31], instruction[19:12], instruction[20], instruction[30:22])
    bword = concat(instruction[31], instruction[7], instruction[30:25], instruction[11:9])
    return zext(word, 30) + mux(
        jal, concat(repeat(instruction[31], 11), jword), concat(repeat(instruction[31], 19), bword)
    )


def local_instruction_prediction(target, instruction):
    """给出本地存储范围内且四字节对齐的静态预测目标及有效位。"""
    jal = instruction[6:0] == 0x6F
    backward = (instruction[6:0] == 0x63) & instruction[31]
    valid = (jal | backward) & ~mux(jal, instruction[21], instruction[8]) & (target[29:15] == 0)
    return concat(valid, target[14:0])


def balanced_and(values):
    terms = list(values)
    while len(terms) > 1:
        following = [terms[index] & terms[index + 1] for index in range(0, len(terms) - 1, 2)]
        if len(terms) % 2:
            following.append(terms[-1])
        terms = following
    return terms[0]


class Decode(Module):
    inst = Input(32)
    op = Output(7, inst[6:0])
    rd = Output(5, inst[11:7])
    f3 = Output(3, inst[14:12])
    rs1 = Output(5, inst[19:15])
    rs2 = Output(5, inst[24:20])
    f7 = Logic(7, inst[31:25])
    regop = Output(1, op == 0x33)
    immop = Output(1, op == 0x13)
    load = Output(1, op == 0x03)
    store = Output(1, op == 0x23)
    br = Output(1, op == 0x63)
    jal = Output(1, op == 0x6F)
    jalr = Output(1, op == 0x67)
    lui = Output(1, op == 0x37)
    auipc = Output(1, op == 0x17)
    md = Output(1, regop & (f7 == 1) & ~f3[2])
    use1 = Output(1, regop | immop | load | store | br | jalr)
    use2 = Output(1, regop | store | br)
    writes = Output(1, regop | immop | load | jal | jalr | lui | auipc)
    ebreak = Output(1, inst == 0x00100073)
    ecall = Output(1, inst == 0x00000073)
    fence = Output(1, (op == 0x0F) & (f3 == 0))
    imm_i = Logic(32, sext(inst[31:20], 32))
    raw_s = Logic(12, concat(inst[31:25], inst[11:7]))
    imm_s = Logic(32, sext(raw_s, 32))
    raw_b = Logic(13, concat(inst[31], inst[7], inst[30:25], inst[11:8], bits(0, 1)))
    imm_b = Logic(32, sext(raw_b, 32))
    raw_j = Logic(21, concat(inst[31], inst[19:12], inst[20], inst[30:21], bits(0, 1)))
    imm_j = Logic(32, sext(raw_j, 32))
    imm = Output(
        32,
        mux(
            store,
            imm_s,
            mux(
                br,
                imm_b,
                mux(jal, imm_j, mux(lui | auipc, concat(inst[31:12], bits(0, 12)), imm_i)),
            ),
        ),
    )
    legal_reg = Logic(
        1, regop & ((f7 == 0) | ((f7 == 1) & ~f3[2]) | ((f7 == 0x20) & ((f3 == 0) | (f3 == 5))))
    )
    legal_imm = Logic(
        1, immop & mux(f3 == 1, f7 == 0, mux(f3 == 5, (f7 == 0) | (f7 == 0x20), bits(1, 1)))
    )
    legal = Output(
        1,
        legal_reg
        | legal_imm
        | lui
        | auipc
        | jal
        | (jalr & (f3 == 0))
        | (load & ((f3 == 0) | (f3 == 1) | (f3 == 2) | (f3 == 4) | (f3 == 5)))
        | (store & (f3 <= 2))
        | (br & ((f3 == 0) | (f3 == 1) | (f3 >= 4)))
        | fence
        | ebreak
        | ecall,
    )
