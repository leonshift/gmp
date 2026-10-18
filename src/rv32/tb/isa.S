    .section .text
    .global _start
_start:
    li sp, 0x1fff0
    li t0, 0x10000
    li t1, 0x89abcdef
    sw t1, 0(t0)
    lw t2, 0(t0)
    add t3, t2, t1
    sub t4, t3, t2
    xor t5, t4, t1
    or t5, t5, t1
    and t6, t5, t1
    sb t1, 5(t0)
    sh t1, 6(t0)
    lb t2, 5(t0)
    lbu t3, 5(t0)
    lh t4, 6(t0)
    lhu t5, 6(t0)
    slt t6, t2, t3
    sltu t6, t2, t3
    slti t6, t2, -1
    sltiu t6, t2, -1
    slli t2, t1, 31
    srli t3, t1, 31
    srai t4, t1, 31
    li t6, 17
    sll t2, t1, t6
    srl t3, t1, t6
    sra t4, t1, t6
    xori t2, t1, -1
    ori t3, t1, 123
    andi t4, t1, 234
    li t1, 0x80000000
    li t2, -1
    mul t3, t1, t2
    mulh t4, t1, t2
    mulhsu t5, t1, t2
    mulhu t6, t1, t2
    li t1, -1234567
    li t2, 321
    mul s3, t1, t2
    sw s3, 8(t0)
    lw s4, 8(t0)
    sw s4, 12(t0)
    lw s5, 12(t0)
    beq s4, s5, 1f
    sw zero, 0(zero)
1:  bne s4, zero, 2f
    sw zero, 0(zero)
2:  blt t1, t2, 3f
    sw zero, 0(zero)
3:  bge t2, t1, 4f
    sw zero, 0(zero)
4:  bltu t2, t1, 5f
    sw zero, 0(zero)
5:  bgeu t1, t2, 6f
    sw zero, 0(zero)
6:  jal ra, function
    la t1, final
    jalr zero, t1, 1
    sw zero, 0(zero)
function:
    addi s0, s0, 1
    ret
final:
    # 后向分支既覆盖预测命中，也覆盖退出循环时的预测失败。
    # 紧邻 load 的分支还会在随机数据端口背压下执行。
    li s8, 7
prediction_loop:
    addi s8, s8, -1
    sw s8, 16(t0)
    lw s9, 16(t0)
    bne s9, zero, prediction_loop
    blt s9, zero, prediction_loop
    jal zero, prediction_done
    sw zero, 0(zero)
    ebreak
prediction_done:
    # 同步 LW 返回值分别用于跳转、乘除法和后续访存地址。
    la s10, load_jump
    sw s10, 20(t0)
    lw s10, 20(t0)
    jalr zero, s10, 0
    sw zero, 0(zero)
load_jump:
    li s10, 19
    sw s10, 24(t0)
    lw s10, 24(t0)
    mul s11, s10, s10
    sw s11, 28(t0)
    lw s11, 28(t0)
    mulhu s11, s11, s10
    sw t0, 32(t0)
    lw s10, 32(t0)
    lw s11, 0(s10)
    # 低字节相同、完整字不同，验证推测跳转的取消与完整比较。
    li s4, 0x12340123
    li s5, 0x56780123
    bne s4, s5, partial_different
    .word 0
partial_different:
    beq s4, s5, partial_wrong
    jal zero, partial_done
partial_wrong:
    .word 0
partial_done:
    # EX 写入链接寄存器时，ID 不使用旧值提前跳转。
    la t2, link_from_ex
    addi ra, t2, 0
    jalr zero, ra, 0
    .word 0
link_from_ex:
    # WB 的字 load 与半字 load 分别覆盖提前跳转和延后修正。
    la t2, link_from_word
    sw t2, 40(t0)
    lw ra, 40(t0)
    nop
    jalr zero, ra, 0
    .word 0
link_from_word:
    la t2, link_from_half
    sw t2, 40(t0)
    lhu ra, 40(t0)
    nop
    jalr zero, ra, 0
    .word 0
link_from_half:
    la t2, link_from_load
    sw t2, 40(t0)
    lw ra, 40(t0)
    jalr zero, ra, 0
    .word 0
link_from_load:
    # EX 的 AUIPC 优先于同拍 WB 对 ra 的较早写入。
    lw ra, 40(t0)
link_auipc:
    auipc ra, %pcrel_hi(link_after_auipc)
    jalr zero, ra, %pcrel_lo(link_auipc)
    .word 0
link_after_auipc:
    la ra, link_odd
    ori ra, ra, 1
    nop
    jalr zero, ra, 0
    .word 0
link_odd:
    # x5 是另一链接寄存器；跳转后恢复测试用数据基地址。
    mv s3, t0
    la t0, link_x5
    nop
    jalr zero, t0, 0
    .word 0
link_x5:
    mv t0, s3
    li s8, 0
    sb s8, 49(t0)
    lb s9, 49(t0)
    beq s9, zero, byte_zero_done
    .word 0
byte_zero_done:
    li s8, 0x80
    sb s8, 51(t0)
    lb s9, 51(t0)
    bne s9, zero, byte_nonzero_done
    .word 0
byte_nonzero_done:
    sh zero, 50(t0)
    lhu s9, 50(t0)
    beq s9, zero, half_zero_done
    .word 0
half_zero_done:
    li s8, 0x8000
    sh s8, 50(t0)
    lh s9, 50(t0)
    bne s9, zero, half_nonzero_done
    .word 0
half_nonzero_done:
    addi zero, zero, 123
    fence
    li a0, 0
    ebreak
    sb zero, 0(zero)
