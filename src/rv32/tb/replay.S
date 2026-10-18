    .section .text
    .global _start
_start:
    li t0, 0x10000
    li s11, 0x00900393
    la s10, patch1
    sw s11, 0(s10)
    nop
patch1:
    addi t2, zero, 1
    sw t2, 0(t0)
    lw t3, 0(t0)
    la s10, patch2
    sw s11, 0(s10)
    nop
patch2:
    addi t2, zero, 2
    sw t2, 4(t0)
    lw t3, 4(t0)
    la s10, patch3
    sw s11, 0(s10)
    nop
patch3:
    addi t2, zero, 3
    sw t2, 8(t0)
    lw t3, 8(t0)
    la s10, patch4
    sw s11, 0(s10)
    nop
patch4:
    addi t2, zero, 4
    sw t2, 12(t0)
    lw t3, 12(t0)
    ebreak
