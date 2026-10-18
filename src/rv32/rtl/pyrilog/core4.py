"""IF、ID、EX、WB 四级流水线；EX 直接发起同步数据访问。"""

from pyrilog.ir import Module, Input, Output, Logic, Param
from pyrilog.hdl import bits, concat, mux, zext, sext, one_hot_mux, repeat
from pyrilog.hdl.cycle import State
from .config import BP_ENTRIES, ILM_PREDICT_BITS
from .isa import instruction_prediction_target, local_instruction_prediction, Decode, balanced_and
from .execute import CompactAlu
from .muldiv import MulDiv
from .predictor import Predictor
from .registers import ClockedRegister, ClockedPayload, RegisterWriteControl


def masked_response_zero(word, mask):
    return balanced_and(
        [(word[index + 3 : index] == bits(0, 4)) | ~mask[index // 8] for index in range(0, 32, 4)]
    )


def select_bank(banks, index):
    return mux(index, banks)


def read_encoded_bank(rf, index, row):
    grants = [row[1:0] == k for k in range(4)]
    lo = one_hot_mux(
        grants, [bits(0, 32) if k * 4 + index == 0 else rf[k * 4 + index] for k in range(4)]
    )
    hi = one_hot_mux(grants, [rf[(k + 4) * 4 + index] for k in range(4)])
    return ~mux(row[2], hi, lo)


class Rv32Core4(Module):
    PREDICT = Param(int, default=2)
    TRACE = Param(int, default=1)
    PERF = Param(int, default=0)
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
    pc = State(30, init=0)
    pc_pending = State(1, init=0)
    halted = State(1, init=0)
    d_v = State(1, init=0)
    d_pc = Logic(30, u_gated_d_pc.q[29:0])
    d_predicted = State(32, reset=False)
    e_v = State(1, init=0)
    e_pending = State(1, init=0)
    e_bank_pending = State(1, init=0)
    e_pc = Logic(30, u_gated_e_pc.q[29:0])
    e_inst = Logic(32, u_gated_e_inst.q[31:0])
    e_use_imm = Logic(1, u_gated_e_use_imm.q[0:0])
    e_subtract = Logic(1, u_gated_e_subtract.q[0:0])
    e_branch = Logic(1, u_gated_e_branch.q[0:0])
    e_immlow = Logic(5, u_gated_e_immlow.q[4:0])
    e_a = State(32, reset=False)
    e_b = State(32, reset=False)
    e_forward_a = State(1, reset=False)
    e_forward_b = State(1, reset=False)
    e_predicted = State(32, reset=False)
    e_pred_taken = Logic(1, u_gated_e_pred_taken.q[0:0])
    e_control = Logic(1, u_gated_e_control.q[0:0])
    e_zero_branch = Logic(1, u_gated_e_zero_branch.q[0:0])
    e_zero_invert = Logic(1, e_inst[12] ^ e_pred_taken)
    e_address_forward = State(1, reset=False)
    e_fetch_error = Logic(1, u_gated_e_fetch_error.q[0:0])
    e_is_md = Logic(1, u_gated_e_is_md.q[0])
    e_is_sb = Logic(1, u_gated_e_is_sb.q[0])
    md_started = State(1, init=0)
    w_v = State(1, init=0)
    w_pc = Logic(30, u_gated_w_pc.q[29:0])
    w_inst = State(32, reset=False)
    w_rd = Logic(5, u_gated_w_rd.q[4:0])
    w_writes = Logic(1, u_gated_w_writes.q[0:0])
    w_load = Logic(1, u_gated_w_load.q[0:0])
    w_store = Logic(1, u_gated_w_store.q[0:0])
    w_result = Logic(32, u_gated_w_result.q[31:0])
    w_data = State(32, reset=False)
    w_mask = State(4, reset=False)
    w_f3 = Logic(3, u_gated_w_f3.q[2:0])
    w_trap = Logic(1, u_gated_w_trap.q[0:0])
    w_cause = Logic(4, u_gated_w_cause.q[3:0])
    w_taken = State(1, reset=False)
    w_target = State(32, reset=False)
    stop_bus_error = State(1, init=0)
    retired = State(64, init=0)
    stalls_load = State(64, init=0)
    stalls_muldiv = State(64, init=0)
    redirects = State(64, init=0)
    pc_address = Logic(32, concat(pc, bits(0, 2)))
    e_pc_address = Logic(32, concat(e_pc, bits(0, 2)))
    w_pc_address = Logic(32, concat(w_pc, bits(0, 2)))
    u_id = Decode(inst=i_data)
    u_ex = Decode(inst=e_inst)
    response_half = Logic(16, mux(w_result[1], d_data[31:16], d_data[15:0]))
    response_byte = Logic(8, mux(w_result[0], response_half[15:8], response_half[7:0]))
    response_sign_byte = Logic(1, ~w_f3[2] & response_byte[7])
    response_sign_half = Logic(1, ~w_f3[2] & response_half[15])
    response_sign = Logic(1, mux(w_f3[0], response_sign_half, response_sign_byte))
    response_aligned_value = Logic(
        32,
        mux(
            w_f3[1],
            d_data,
            concat(
                repeat(response_sign, 16),
                mux(w_f3[0], response_half[15:8], repeat(response_sign_byte, 8)),
                response_byte,
            ),
        ),
    )
    wb_data = Logic(32, mux(w_load, response_aligned_value, w_result))
    wb_bus_error = Logic(1, (w_load | w_store) & ~w_trap & d_error)
    wb_stop = Logic(1, w_v & (w_trap | wb_bus_error))
    wb_write = Logic(1, w_v & w_writes & ~wb_stop & ~halted)
    wb_forward = Logic(1, w_v & w_writes)
    u_rf_write = RegisterWriteControl(clk=clk, rst_n=rst_n, write=wb_write, address=w_rd)
    rf_words = []
    rf = [bits(0xFFFFFFFF, 32)]
    for _index in range(1, 32):
        rf_words.append(
            ClockedRegister(
                clk=clk,
                rst_n=~u_rf_write.reset_q,
                enable=u_rf_write.reset_q | (u_rf_write.write_q & (u_rf_write.address_q == _index)),
                value=~wb_data,
            )
        )
        rf.append(rf_words[-1].q)
    del _index
    read_b_address = Logic(5, mux(e_bank_pending, e_inst[24:20], u_id.rs2))
    read_bank_a = Logic(2, u_id.rs1[1:0])
    read_bank_b = Logic(2, read_b_address[1:0])
    needs_rf_a = Logic(
        1,
        u_id.use1
        & (u_id.rs1 != 0)
        & ~((dependency_producer | load_pending) & depend_a)
        & ~(wb_forward & (w_rd == u_id.rs1)),
    )
    needs_rf_b = Logic(
        1,
        u_id.use2
        & (u_id.rs2 != 0)
        & ~((dependency_producer | load_pending) & depend_b)
        & ~(wb_forward & (w_rd == u_id.rs2)),
    )
    bank_conflict = Logic(1, needs_rf_b & (read_bank_a == read_bank_b) & (u_id.rs1 != u_id.rs2))
    read_row_address = []
    read_banks = []
    for _bank in range(4):
        read_row_address.append(
            Logic(
                3,
                mux(
                    e_bank_pending & (e_inst[21:20] == _bank),
                    e_inst[24:22],
                    mux(read_bank_a == _bank, u_id.rs1[4:2], u_id.rs2[4:2]),
                ),
            )
        )
        read_banks.append(Logic(32, read_encoded_bank(rf, _bank, read_row_address[-1])))
    del _bank
    rf_value_a = Logic(32, select_bank(read_banks, read_bank_a))
    rf_value_b = Logic(32, select_bank(read_banks, read_bank_b))
    ex_a = Logic(32, mux(e_forward_a, w_result, e_a))
    ex_b = Logic(32, mux(e_forward_b, w_result, e_b))
    immediate = Logic(12, concat(e_inst[31:25], e_immlow))
    upper_immediate = Logic(32, concat(e_inst[31:12], bits(0, 12)))
    alu_b = Logic(32, mux(e_use_imm, sext(immediate, 32), ex_b))
    u_alu = CompactAlu(
        a=ex_a, add_a=ex_a, b=alu_b, f3=u_ex.f3, subtract=e_subtract, arithmetic=e_inst[30]
    )
    forwarded_address = Logic(32, d_data | concat(bits(0, 30), immediate[1], bits(0, 1)))
    ea = Logic(32, mux(e_address_forward, forwarded_address, u_alu.sum))
    ex_bimm = Logic(13, concat(e_inst[31], e_inst[7], e_inst[30:25], e_inst[11:8], bits(0, 1)))
    ex_jimm = Logic(21, concat(e_inst[31], e_inst[19:12], e_inst[20], e_inst[30:21], bits(0, 1)))
    ex_relative = Logic(
        32,
        e_pc_address
        + mux(
            u_ex.auipc,
            upper_immediate,
            mux(u_ex.jal, sext(ex_jimm, 32), mux(e_branch, sext(ex_bimm, 32), bits(0, 32))),
        ),
    )
    store_low_sum = Logic(18, u_alu.sum[17:0])
    store_high_zero = Logic(1, ex_a[31:18] == 0)
    store_high_max = Logic(1, ex_a[31:16] == 0xFFFF)
    integer_result = Logic(
        32,
        mux(
            u_ex.lui,
            upper_immediate,
            mux(u_ex.auipc, ex_relative, mux(u_ex.jal | u_ex.jalr, e_pc_address + 4, u_alu.result)),
        ),
    )
    # 分支比较分段计算，符号位差异单独处理。
    response_zero_mask = Logic(
        4,
        mux(
            w_f3[1:0] == 2,
            bits(15, 4),
            mux(w_f3[0], mux(w_result[1], bits(12, 4), bits(3, 4)), bits(1, 4) << w_result[1:0]),
        ),
    )
    loaded_zero = Logic(1, masked_response_zero(d_data, response_zero_mask))
    branch_equal_high = Logic(1, ex_a[31:16] == ex_b[31:16])
    branch_equal_low = Logic(1, ex_a[15:0] == ex_b[15:0])
    branch_equal = Logic(1, branch_equal_high & branch_equal_low)
    branch_unsigned = Logic(1, u_alu.less_unsigned)
    branch_signed = Logic(1, mux(ex_a[31] != ex_b[31], ex_a[31], branch_unsigned))
    branch_less = Logic(1, mux(u_ex.f3[1], branch_unsigned, branch_signed))
    plain_branch_condition = Logic(
        1, (u_ex.f3[2] | ~u_ex.f3[1]) & (mux(u_ex.f3[2], branch_less, branch_equal) ^ u_ex.f3[0])
    )
    branch_condition = Logic(
        1, mux(e_zero_branch, loaded_zero ^ u_ex.f3[0], plain_branch_condition)
    )
    taken = Logic(1, u_ex.jal | u_ex.jalr | (u_ex.br & branch_condition))
    target = Logic(32, mux(u_ex.jalr, ea & bits(0xFFFFFFFE, 32), ex_relative))
    actual_next = Logic(32, mux(taken, target, e_pc_address + 4))
    memory_low = Logic(2, mux(u_ex.store, store_low_sum[1:0], ea[1:0]))
    misaligned_data = Logic(
        1,
        (u_ex.load | u_ex.store)
        & mux(
            u_ex.f3[1:0] == 1, memory_low[0], mux(u_ex.f3[1:0] == 2, memory_low != 0, bits(0, 1))
        ),
    )
    misaligned_store = Logic(
        1,
        mux(
            u_ex.f3[1:0] == 1,
            store_low_sum[0],
            mux(u_ex.f3[1:0] == 2, store_low_sum[1:0] != 0, bits(0, 1)),
        ),
    )
    misaligned_pc = Logic(1, taken & (target[1:0] != 0) & ~e_zero_branch)
    ex_trap = Logic(
        1, e_fetch_error | ~u_ex.legal | u_ex.ebreak | u_ex.ecall | misaligned_data | misaligned_pc
    )
    memory_fault = Logic(1, e_fetch_error | ~u_ex.legal | misaligned_data)
    ex_cause = Logic(
        4,
        mux(
            e_fetch_error,
            bits(1, 4),
            mux(
                ~u_ex.legal,
                bits(2, 4),
                mux(
                    misaligned_pc,
                    bits(0, 4),
                    mux(
                        misaligned_data,
                        mux(u_ex.store, bits(6, 4), bits(4, 4)),
                        mux(u_ex.ebreak, bits(3, 4), bits(11, 4)),
                    ),
                ),
            ),
        ),
    )
    address_spec_retry = Logic(
        1, e_address_forward & immediate[1] & d_data[1] & ~e_fetch_error & u_ex.legal
    )
    # 较早 WB 事件按边沿前状态退休，等待边沿后复用其数据寄存器保存 A/Q。
    md_wb_a_small = Logic(1, w_result[31:9] == 0)
    md_wb_small = Logic(1, w_result[31:8] == 0)
    md_a_small = Logic(1, e_a[31:9] == 0)
    md_b_small = Logic(1, e_b[31:8] == 0)
    md_small_inputs = Logic(
        1, mux(e_forward_a, md_wb_a_small, md_a_small) & mux(e_forward_b, md_wb_small, md_b_small)
    )
    u_md = MulDiv(
        EXTERNAL_ARITH=1,
        external_small=md_small_inputs,
        external_sum=u_alu.sum,
        external_carry=u_alu.shared_sum[32],
        storage_partial=zext(e_b, 36),
        EXTERNAL=1,
        HOLD_RESULT=0,
        rst_n=rst_n & ~halted & ~wb_stop,
        start=e_v & e_is_md & ~md_started & ~wb_stop & ~halted,
        consume=ex_fire & e_is_md,
        a=ex_a,
        b=ex_b,
        storage_a=w_result,
        storage_b=concat(w_mask[1:0], w_pc),
        storage_high=e_a,
        op=u_ex.f3,
    )
    md_wait = Logic(1, e_v & e_is_md & ~u_md.ready)
    memory_wait = Logic(
        1, e_v & (u_ex.load | u_ex.store) & ~memory_fault & ~d_ready & ~address_spec_retry
    )
    byte_store_wait = Logic(1, e_v & e_is_sb & ~e_fetch_error & d_byte_pause)
    hold = Logic(1, md_wait | memory_wait | byte_store_wait)
    front_capture_slow = Logic(
        1,
        ~halted
        & ~wb_stop
        & ~e_pending
        & ~memory_wait
        & ~byte_store_wait
        & (~(e_v & e_is_md) | u_md.ready_slow),
    )
    front_capture_small = Logic(1, ~e_pending & u_md.small_eligible)
    front_capture_enable = Logic(1, front_capture_slow | (front_capture_small & md_small_inputs))
    front_hold = Logic(1, hold | e_pending)
    ex_fire = Logic(1, e_v & ~hold & ~wb_stop & ~halted)
    prediction_miss = Logic(1, actual_next != e_predicted)
    redirect_valid = Logic(1, mux(PREDICT == 1, ex_fire, e_v & ~wb_stop & ~halted))
    ordinary_taken = Logic(1, u_ex.jal | u_ex.jalr | (u_ex.br & plain_branch_condition))
    ordinary_prediction_miss = Logic(
        1, mux(u_ex.jalr, ~e_pred_taken, ordinary_taken ^ e_pred_taken)
    )
    static_redirect_enable = Logic(1, redirect_valid & e_control & (~u_ex.jalr | ~ea[1]))
    address_replay = Logic(1, ex_fire & address_spec_retry)
    zero_redirect_enable = Logic(1, redirect_valid & e_control & e_zero_branch)
    zero_redirect_when_zero = Logic(1, zero_redirect_enable & ~e_zero_invert)
    zero_redirect_when_nonzero = Logic(1, zero_redirect_enable & e_zero_invert)
    ordinary_redirect = Logic(1, static_redirect_enable & ~e_zero_branch & ordinary_prediction_miss)
    static_prediction_redirect = Logic(
        1,
        ordinary_redirect
        | address_replay
        | (loaded_zero & zero_redirect_when_zero)
        | (~loaded_zero & zero_redirect_when_nonzero),
    )
    redirect = Logic(
        1,
        mux(
            PREDICT == 1,
            (redirect_valid & ~ex_trap & prediction_miss) | address_replay,
            mux(
                PREDICT == 2,
                static_prediction_redirect,
                (static_redirect_enable & taken) | address_replay,
            ),
        ),
    )
    depend_a = Logic(1, u_id.rs1 == u_ex.rd)
    depend_b = Logic(1, u_id.rs2 == u_ex.rd)
    dependency_producer = Logic(1, e_v & u_ex.writes & ~u_ex.load & (u_ex.rd != 0))
    load_pending = Logic(1, e_v & u_ex.load & (u_ex.rd != 0))
    address_forward = Logic(
        1,
        load_pending
        & (u_ex.f3 == 2)
        & depend_a
        & (u_id.load | u_id.jalr)
        & ((i_data[31:20] == 0) | (u_id.load & (i_data[31:20] == 2))),
    )
    zero_branch_forward = Logic(
        1,
        load_pending
        & u_id.br
        & (u_id.f3[2:1] == 0)
        & ~i_error
        & ~i_data[8]
        & (((u_id.rs1 == 0) & depend_b) | ((u_id.rs2 == 0) & depend_a)),
    )
    load_hazard = Logic(
        1, load_pending & (depend_a | depend_b) & ~zero_branch_forward & ~address_forward
    )
    fetch_retry = Logic(1, d_v & i_retry)
    id_fire = Logic(1, d_v & ~fetch_retry & ~front_hold & ~wb_stop & ~halted)
    # ILM 的分支元数据在主机写入时生成；动态修改的字清除预测有效位。
    program_target = Logic(30, instruction_prediction_target(program_word, program_data))
    program_word_zero = Output(1, program_data == 0)
    d_word_zero = Output(1, ex_b == 0)
    program_prediction = Output(
        18,
        concat(
            bits(0, 1),
            program_data == 0x00008067,
            local_instruction_prediction(program_target, program_data),
        ),
    )
    id_control_legal = Logic(
        1, u_id.jal | (u_id.jalr & (u_id.f3 == 0)) | (u_id.br & ((u_id.f3[2:1] == 0) | u_id.f3[2]))
    )
    return_target = Logic(32, ~rf[1])
    return_free = Logic(
        1,
        ~(((dependency_producer | load_pending) & (u_ex.rd == 1)) | (wb_forward & (w_rd == 1)))
        & (return_target[1:0] == 0),
    )
    id_lookup_enable = Logic(1, (PREDICT == 2) & d_v & ~i_error & (d_pc[14:ILM_PREDICT_BITS] == 0))
    id_lookup_static = Logic(1, id_lookup_enable & i_prediction[15])
    id_lookup_return = Logic(1, id_lookup_enable & i_prediction[16] & return_free)
    id_prediction = Logic(1, id_lookup_static | id_lookup_return)
    id_static_target = Logic(32, concat(bits(0, 15), i_prediction[14:0], bits(0, 2)))
    id_target = Logic(32, mux(id_lookup_return, return_target, id_static_target))
    id_static = Logic(1, id_prediction & id_fire & ~ex_fetch)
    wb_control = Logic(1, (w_inst[6:0] == 0x63) | (w_inst[6:0] == 0x6F) | (w_inst[6:0] == 0x67))
    u_predictor = Predictor.spec(ENTRIES=BP_ENTRIES)(
        query_pc=pc_address,
        update=(PREDICT == 1) & w_v & ~wb_stop & ~halted,
        update_pc=w_pc_address,
        update_target=w_target,
        update_taken=w_taken,
        update_control=wb_control,
    )
    predicted_next = Logic(32, concat(u_predictor.next_pc[31:2], bits(0, 2)))
    fast_branch_enable = Logic(1, (PREDICT == 2) & redirect_valid & e_control & e_branch)
    fast_eq_normal = Logic(1, fast_branch_enable & ~u_ex.f3[2] & ~e_zero_branch)
    fast_eq_zero = Logic(1, fast_branch_enable & ~u_ex.f3[2] & e_zero_branch & zero_hint_eligible)
    fast_eq_request = Logic(1, fast_eq_normal & (branch_equal ^ e_zero_invert))
    fast_branch = Logic(1, fast_eq_request)
    zero_hint_eligible = Logic(1, (w_f3 == 2) & (w_result[31:17] == 0))
    zero_hint_when_zero = Logic(1, fast_eq_zero & ~e_zero_invert)
    zero_hint_when_nonzero = Logic(1, fast_eq_zero & e_zero_invert)
    fast_zero_redirect = Logic(
        1, (d_zero_hint[0] & zero_hint_when_zero) | (d_zero_hint[1] & zero_hint_when_nonzero)
    )
    ex_fetch = Logic(1, fast_branch | fast_zero_redirect)
    fast_recovery_next = Logic(32, mux(e_pred_taken, e_pc_address + 4, ex_relative))
    recovery_next = Logic(
        32,
        mux(
            PREDICT == 2,
            mux(e_pred_taken, e_pc_address + 4, target),
            mux(address_spec_retry, ex_relative, actual_next),
        ),
    )
    i_valid = Output(1, ~halted & ~wb_stop & (ex_fetch | (~fetch_retry & (~d_v | ~front_hold))))
    sequential_fetch_address = Logic(32, concat(mux(pc_pending, pc + bits(1, 30), pc), bits(0, 2)))
    fast_fetch_target = Logic(32, fast_recovery_next)
    early_fetch_address = Logic(
        32,
        mux(
            ex_fetch,
            fast_fetch_target,
            mux(
                id_lookup_return,
                return_target,
                mux(id_lookup_static, id_static_target, sequential_fetch_address),
            ),
        ),
    )
    i_fetch_address = Logic(32, early_fetch_address)
    i_addr = Output(32, i_fetch_address)
    if_fire = Logic(1, i_valid & i_ready)
    d_valid = Output(
        1,
        e_v
        & (u_ex.load | u_ex.store)
        & ~memory_fault
        & ~wb_stop
        & ~halted
        & ~byte_store_wait
        & ~address_spec_retry,
    )
    d_write = Output(1, u_ex.store)
    d_store_valid = Output(
        1,
        e_v
        & u_ex.store
        & ~e_fetch_error
        & u_ex.legal
        & ~misaligned_store
        & ~wb_stop
        & ~halted
        & ~byte_store_wait,
    )
    d_addr = Output(32, ea)
    d_address_forward = Output(1, e_address_forward)
    d_store_word = Output(15, store_low_sum[16:2])
    d_store_local = Output(
        1,
        mux(
            immediate[11],
            mux(
                u_alu.carry16, store_high_zero & ~ex_a[17], store_high_zero & (ex_a[17] ^ ex_a[16])
            ),
            mux(
                u_alu.carry16,
                (store_high_zero & ~ex_a[17] & ~ex_a[16]) | store_high_max,
                store_high_zero & ~ex_a[17],
            ),
        ),
    )
    d_wdata = Output(32, ex_b << concat(store_low_sum[1:0], bits(0, 3)))
    d_byte = Output(8, ex_b[7:0])
    d_wstrb = Output(
        4,
        mux(
            u_ex.f3 == 0,
            bits(1, 4) << store_low_sum[1:0],
            mux(u_ex.f3 == 1, bits(3, 4) << store_low_sum[1:0], bits(15, 4)),
        ),
    )
    d_f3 = Output(3, u_ex.f3)
    result = Logic(32, mux(e_is_md, u_md.result, integer_result))
    jump_misaligned = Logic(1, (u_ex.jal | u_ex.jalr) & target[1])
    normal_result_ok = Logic(1, ~e_fetch_error & u_ex.legal)
    exception_wb_result = Logic(
        32,
        one_hot_mux(
            [
                e_fetch_error,
                ~e_fetch_error & ~u_ex.legal,
                normal_result_ok & (u_ex.load | u_ex.store),
                normal_result_ok & (u_ex.br | jump_misaligned),
                normal_result_ok & (u_ex.jal | u_ex.jalr) & ~jump_misaligned,
                normal_result_ok & u_ex.lui,
                normal_result_ok & u_ex.auipc,
                normal_result_ok & e_is_md,
                normal_result_ok & (u_ex.immop | (u_ex.regop & ~e_is_md)),
            ],
            [
                e_pc_address,
                e_inst,
                ea,
                target,
                e_pc_address + 4,
                upper_immediate,
                ex_relative,
                u_md.result,
                u_alu.result,
            ],
        ),
    )
    halt_o = Output(1, halted)
    cause_o = Output(
        4,
        mux(halted, mux(stop_bus_error, mux(w_store, bits(7, 4), bits(5, 4)), w_cause), bits(0, 4)),
    )
    trap_pc_o = Output(32, mux(halted, w_pc_address, bits(0, 32)))
    trap_value_o = Output(32, mux(halted, w_result, bits(0, 32)))
    retired_o = Output(64, retired)
    load_stalls_o = Output(64, stalls_load)
    muldiv_stalls_o = Output(64, stalls_muldiv)
    redirects_o = Output(64, redirects)
    trace_valid = Output(1, (TRACE != 0) & w_v & ~halted)
    trace_pc = Output(32, mux(TRACE != 0, w_pc_address, bits(0, 32)))
    trace_inst = Output(32, mux(TRACE != 0, w_inst, bits(0, 32)))
    trace_rd = Output(5, mux((TRACE != 0) & wb_write, w_rd, bits(0, 5)))
    trace_data = Output(32, mux(TRACE != 0, wb_data, bits(0, 32)))
    trace_store = Output(1, (TRACE != 0) & w_v & w_store & ~wb_stop)
    trace_addr = Output(32, mux(TRACE != 0, w_result, bits(0, 32)))
    trace_wdata = Output(32, mux(TRACE != 0, w_data, bits(0, 32)))
    trace_mask = Output(4, mux(TRACE != 0, w_mask, bits(0, 4)))
    trace_trap = Output(1, (TRACE != 0) & wb_stop)
    retire_enable = Logic(1, ~halted & ~wb_stop & w_v)
    capture_id = Logic(1, ~e_pending & ~hold)
    capture_hold = Logic(1, ~e_pending & hold)
    capture_wb_a = Logic(
        1, (capture_id & wb_forward & (w_rd == u_id.rs1)) | (e_pending & e_forward_a)
    )
    capture_wb_b = Logic(
        1, (capture_id & wb_forward & (w_rd == u_id.rs2)) | (e_pending & e_forward_b)
    )
    rf_capture_a = Logic(1, capture_id & (u_id.rs1 != 0) & ~(wb_forward & (w_rd == u_id.rs1)))
    rf_capture_b = Logic(
        1,
        ((capture_id & ~(wb_forward & (w_rd == u_id.rs2))) | e_bank_pending)
        & (read_b_address != 0),
    )
    holding_operand_a = Logic(
        32,
        one_hot_mux(
            [
                capture_hold & e_address_forward & ~md_high_workspace,
                capture_hold & ~e_address_forward & e_forward_a & ~md_high_workspace,
                ((e_pending & ~e_forward_a) | (capture_hold & ~e_address_forward & ~e_forward_a))
                & ~md_high_workspace,
                md_workspace_write & u_md.accumulating,
            ],
            [d_data, w_result, e_a, u_md.high_accumulate],
        ),
    )
    holding_operand_b = Logic(
        32,
        one_hot_mux(
            [
                capture_hold & e_forward_b & ~md_partial_capture,
                ((e_pending & ~e_forward_b & ~e_bank_pending) | (capture_hold & ~e_forward_b))
                & ~md_partial_capture,
                md_partial_capture,
            ],
            [w_result, e_b, u_md.partial_product[31:0]],
        ),
    )
    operand_next_a = Logic(
        32,
        holding_operand_a
        | (rf_value_a & repeat(rf_capture_a, 32))
        | (wb_data & repeat(capture_wb_a, 32)),
    )
    operand_next_b = Logic(
        32,
        holding_operand_b
        | (rf_value_b & repeat(rf_capture_b, 32))
        | (wb_data & repeat(capture_wb_b, 32)),
    )
    md_workspace_write = Logic(1, e_v & e_is_md & hold)
    md_partial_capture = Logic(1, e_v & e_is_md & u_md.partial_capture)
    md_high_workspace = Logic(1, md_workspace_write & ~md_partial_capture)

    pc_sequential_word = Logic(30, mux(pc_pending, pc + bits(2, 30), pc + bits(1, 30)))
    pc_normal_word = Logic(
        30,
        mux(
            fetch_retry,
            d_pc,
            mux(
                id_static,
                id_target[31:2],
                mux(if_fire, mux(PREDICT == 1, predicted_next[31:2], pc_sequential_word), pc),
            ),
        ),
    )
    pc_next_word = Logic(30, mux(redirect, recovery_next[31:2], pc_normal_word))

    u_gated_e_is_md = ClockedPayload(clk=clk, enable=front_capture_enable, value=zext(u_id.md, 32))
    u_gated_e_is_sb = ClockedPayload(
        clk=clk, enable=front_capture_enable, value=zext(u_id.store & (u_id.f3 == 0), 32)
    )
    u_gated_e_inst = ClockedPayload(clk=clk, enable=front_capture_enable, value=i_data)
    u_gated_e_pc = ClockedPayload(clk=clk, enable=front_capture_enable, value=zext(d_pc, 32))
    u_gated_e_use_imm = ClockedPayload(
        clk=clk,
        enable=front_capture_enable,
        value=zext(u_id.immop | u_id.load | u_id.store | u_id.jalr, 32),
    )
    u_gated_e_subtract = ClockedPayload(
        clk=clk,
        enable=front_capture_enable,
        value=zext(u_id.regop & (u_id.f3 == 0) & i_data[30], 32),
    )
    u_gated_e_branch = ClockedPayload(clk=clk, enable=front_capture_enable, value=zext(u_id.br, 32))
    u_gated_e_immlow = ClockedPayload(
        clk=clk,
        enable=front_capture_enable,
        value=zext(mux(u_id.store, i_data[11:7], i_data[24:20]), 32),
    )
    u_gated_e_pred_taken = ClockedPayload(
        clk=clk, enable=front_capture_enable, value=zext(id_prediction, 32)
    )
    u_gated_e_control = ClockedPayload(
        clk=clk,
        enable=front_capture_enable,
        value=zext(
            ~i_error
            & id_control_legal
            & mux(u_id.jalr, bits(1, 1), mux(u_id.jal, ~i_data[21], ~i_data[8])),
            32,
        ),
    )
    u_gated_e_zero_branch = ClockedPayload(
        clk=clk, enable=front_capture_enable, value=zext(zero_branch_forward, 32)
    )
    u_gated_e_fetch_error = ClockedPayload(
        clk=clk, enable=front_capture_enable, value=zext(i_error, 32)
    )
    u_gated_d_pc = ClockedPayload(
        clk=clk, enable=~d_v | front_capture_enable, value=zext(i_addr[31:2], 32)
    )
    u_gated_w_rd = ClockedPayload(clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(u_ex.rd, 32))
    u_gated_w_writes = ClockedPayload(
        clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(u_ex.writes & (u_ex.rd != 0), 32)
    )
    u_gated_w_load = ClockedPayload(
        clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(u_ex.load, 32)
    )
    u_gated_w_store = ClockedPayload(
        clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(u_ex.store, 32)
    )
    u_gated_w_f3 = ClockedPayload(clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(u_ex.f3, 32))
    u_gated_w_trap = ClockedPayload(
        clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(ex_trap, 32)
    )
    u_gated_w_cause = ClockedPayload(
        clk=clk, enable=e_v & ~halted & ~wb_stop, value=zext(ex_cause, 32)
    )
    u_gated_w_result = ClockedPayload(
        clk=clk,
        enable=e_v & ~halted & ~wb_stop,
        value=mux(md_workspace_write, u_md.operand_next, exception_wb_result),
    )
    u_gated_w_pc = ClockedPayload(
        clk=clk,
        enable=e_v & ~halted & ~wb_stop,
        value=mux(md_workspace_write, u_md.quotient_next, concat(bits(0, 2), e_pc)),
    )

    def cycle(self, reset=rst_n):
        # 数据寄存器由 valid 保护；计算结果无需在空拍或停机期间保持。
        self.e_a = self.operand_next_a
        self.e_b = self.operand_next_b
        self.retired = self.retired + zext(self.retire_enable, 64)
        if ~self.halted:
            if self.wb_stop:
                self.halted = 1
                self.stop_bus_error = self.wb_bus_error
            else:
                self.pc = self.pc_next_word
                self.w_v = self.ex_fire & ~self.address_spec_retry
                if self.ex_fire:
                    self.w_inst = self.e_inst
                    self.w_data = self.d_wdata
                    self.w_mask = self.d_wstrb
                    self.w_taken = self.taken
                    self.w_target = self.actual_next
                elif self.md_workspace_write:
                    self.w_mask = concat(self.w_mask[3:2], self.u_md.quotient_next[31:30])
                if self.e_pending:
                    self.e_pending = 0
                    self.e_bank_pending = 0
                    self.e_v = 1
                    self.e_forward_a = 0
                    self.e_forward_b = 0
                    self.e_address_forward = 0
                elif self.hold:
                    self.e_forward_a = 0
                    self.e_forward_b = 0
                    self.e_address_forward = 0
                    if self.e_v & self.e_is_md:
                        self.md_started = 1
                else:
                    self.e_v = self.id_fire & ~(self.load_hazard | self.bank_conflict)
                    self.e_pending = self.id_fire & (self.load_hazard | self.bank_conflict)
                    self.e_bank_pending = self.id_fire & self.bank_conflict
                    self.md_started = 0
                    self.e_forward_a = (
                        self.dependency_producer | self.load_pending
                    ) & self.depend_a
                    self.e_forward_b = (
                        self.dependency_producer | self.load_pending
                    ) & self.depend_b
                    self.e_predicted = self.d_predicted
                    self.e_address_forward = self.address_forward
                if self.if_fire:
                    self.pc_pending = self.id_static
                    self.d_predicted = mux(self.PREDICT == 1, self.predicted_next, self.i_addr + 4)
                    self.d_v = 1
                elif self.id_fire:
                    self.d_v = 0
                if self.id_static & ~self.if_fire:
                    self.pc_pending = 0
                    self.d_v = 0
                if self.fetch_retry:
                    self.pc_pending = 0
                    self.d_v = 0
                if self.redirect:
                    self.pc_pending = self.ex_fetch & self.if_fire
                if self.redirect:
                    self.d_v = self.ex_fetch & self.if_fire
                    self.e_v = 0
                    self.e_pending = 0
                    self.e_bank_pending = 0
                if (self.PERF != 0) & self.d_v & self.load_hazard & ~self.hold:
                    self.stalls_load = self.stalls_load + 1
                if (self.PERF != 0) & self.md_wait:
                    self.stalls_muldiv = self.stalls_muldiv + 1
                if (self.PERF != 0) & (self.redirect | self.id_static):
                    self.redirects = self.redirects + 1
