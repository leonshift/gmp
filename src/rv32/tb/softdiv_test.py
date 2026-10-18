"""在核心上验证软件除法，包括零除数、符号与溢出边界。"""

import argparse
from pathlib import Path
import random
import re
import subprocess


def signed(value):
    return value if value < 0x80000000 else value - 0x100000000


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--sim", required=True)
    parser.add_argument("--cross", default="riscv64-linux-gnu-")
    args = parser.parse_args()
    out = Path("out/softdiv")
    out.mkdir(parents=True, exist_ok=True)
    edges = [
        0,
        1,
        2,
        3,
        7,
        16,
        31,
        255,
        65535,
        65536,
        0x7FFFFFFF,
        0x80000000,
        0x80000001,
        0xFFFFFFFE,
        0xFFFFFFFF,
    ]
    rng = random.Random(0x32D171DE)
    pairs = [(a, b) for a in edges for b in edges]
    pairs += [(rng.getrandbits(32), rng.getrandbits(32)) for _ in range(512)]
    rows = []
    for a, b in pairs:
        sa, sb = signed(a), signed(b)
        sq = (abs(sa) // abs(sb)) * (-1 if (sa < 0) != (sb < 0) else 1) if b else -1
        values = [
            a,
            b,
            a // b if b else 0xFFFFFFFF,
            a % b if b else a,
            sq,
            sa - sq * sb if b else sa,
        ]
        rows.append("{" + ",".join(f"0x{v & 0xFFFFFFFF:08x}u" for v in values) + "}")
    source = out / "driver.c"
    source.write_text(
        """#include <stdint.h>
extern uint32_t __udivsi3(uint32_t, uint32_t);
extern uint32_t __umodsi3(uint32_t, uint32_t);
extern int32_t __divsi3(int32_t, int32_t);
extern int32_t __modsi3(int32_t, int32_t);
static const volatile uint32_t cases[][6] = {
"""
        + ",\n".join(rows)
        + """};
void test(void) {
    for (unsigned i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i) {
        uint32_t a = cases[i][0], b = cases[i][1];
        if (__udivsi3(a,b) != cases[i][2] || __umodsi3(a,b) != cases[i][3] ||
            (uint32_t)__divsi3((int32_t)a,(int32_t)b) != cases[i][4] ||
            (uint32_t)__modsi3((int32_t)a,(int32_t)b) != cases[i][5])
            __asm__ volatile (".word 0");
    }
    __asm__ volatile ("ebreak");
}
"""
    )
    start = out / "start.S"
    start.write_text(
        ".section .text.start\n.global _start\n_start:\nli sp,0x1fff0\ncall test\nebreak\n"
    )
    link = out / "link.ld"
    link.write_text(
        "ENTRY(_start)\nSECTIONS { . = 0; .text : { *(.text.start) *(.text*) } "
        ".rodata : { *(.rodata*) } .data : { *(.data*) } .bss : { *(.bss*) } }\n"
    )
    elf, image = out / "test.elf", out / "test.bin"
    subprocess.run(
        [
            args.cross + "gcc",
            "-march=rv32i_zmmul",
            "-mabi=ilp32",
            "-mno-div",
            "-mno-relax",
            "-msmall-data-limit=0",
            "-O2",
            "-ffreestanding",
            "-fno-builtin",
            "-fno-pie",
            "-nostdlib",
            "-static",
            "-no-pie",
            "-Wl,--build-id=none",
            "-T",
            str(link),
            "-o",
            str(elf),
            str(start),
            str(source),
            "sw/softdiv.c",
        ],
        check=True,
    )
    assembly = subprocess.check_output([args.cross + "objdump", "-d", str(elf)], text=True)
    if re.search(r"\s(?:divu?|remu?)\s", assembly):
        raise RuntimeError("software division emitted a hardware division instruction")
    subprocess.run([args.cross + "objcopy", "-O", "binary", str(elf), str(image)], check=True)
    subprocess.run(
        [
            args.sim,
            "--image",
            str(image),
            "--check",
            "--expect-cause",
            "3",
            "--max-cycles",
            "10000000",
        ],
        check=True,
    )
    print(f"PASS: {len(pairs) * 4} software division/remainder results on RV32I_Zmmul")


if __name__ == "__main__":
    main()
