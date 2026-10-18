// Bare-metal RV32I crt0 for the pyrilog 5-stage pipeline.
//
// Responsibilities:
//   1. Set sp to top of the 128 KiB memory region (link.ld defines _stack_top).
//   2. Zero .bss so global statics start at 0 (CoreMark relies on this).
//   3. Call main(0, NULL).
//   4. Trigger EBREAK so the harness sees `halt_o` go high and stops.
//
// Entry point address is 0x00000000 — placed by the linker via .text.init
// being the first input section.

    .section .text.init, "ax"
    .global _start
    .type _start, @function
_start:
    // Set up stack pointer
    la      sp, _stack_top

    // Zero .bss
    la      a0, __bss_start
    la      a1, __bss_end
1:
    bge     a0, a1, 2f
    sw      zero, 0(a0)
    addi    a0, a0, 4
    j       1b
2:
    // Call main(0, NULL). Return value lands in a0; we ignore it.
    li      a0, 0
    li      a1, 0
    call    main

    // Tell the harness we're done. EBREAK is decoded as halt by the CPU.
3:
    ebreak
    j       3b
    .size _start, .-_start
