/* Linker script for the pyrilog RV32I CPU.
 *
 * Single 128 KiB region — the CPU's Imem (read by PC) and Dmem (read
 * by LW/LH/LB) are separate hardware arrays but BOTH are loaded with
 * the same image at sim init via $readmemh. So an LW from 0x10000
 * reads .rodata from Dmem, while an instruction fetch from 0x100
 * reads code from Imem — both consistent with the linked ELF.
 *
 * Layout:
 *   0x00000000 - 0x0001FFFF   one MEM region (128 KiB)
 *     .text.init   — _start at 0x0
 *     .text        — code
 *     .rodata      — string literals, const tables
 *     .data        — initialised globals
 *     .bss         — zero-initialised globals (zeroed by crt0)
 *     stack        — grows downward from _stack_top = 0x00020000
 */

OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY
{
    MEM (rwx) : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
    .text :
    {
        KEEP(*(.text.init))
        *(.text .text.*)
    } > MEM

    .rodata :
    {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    } > MEM

    .data :
    {
        *(.data .data.*)
        *(.sdata .sdata.*)
    } > MEM

    .bss :
    {
        __bss_start = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        *(COMMON)
        __bss_end = .;
    } > MEM

    _stack_top = ORIGIN(MEM) + LENGTH(MEM);

    /DISCARD/ : { *(.eh_frame) *(.note.*) *(.comment) }
}
