"""检查连续 MMIO、UART 容量边界与接受边沿计时采样。"""

import argparse
import json
from pathlib import Path
import subprocess


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--sim", required=True)
    parser.add_argument("--cross", default="riscv64-linux-gnu-")
    args = parser.parse_args()
    out = Path("out/peripheral")
    out.mkdir(parents=True, exist_ok=True)
    programs = {
        "hash-collision": """
    li t0, 0x1000
    li t1, 0x55
    li s0, 0
    .rept 59
    nop
    .endr
    sw t1, 0(t0)
    addi s0, s0, 1
    addi s0, s0, 2
    li t2, 3
    bne s0, t2, 9f
    lw t3, 0(t0)
    bne t3, t1, 9f
    ebreak
9:  .word 0xffffffff
""",
        "mmio-pointer": """
    la t0, _start
    lw t1, 0(t0)
    li t2, -48
    lw t3, 0(t2)
    lw t4, 0(t3)
    bne t4, t1, 9f
    ebreak
9:  .word 0xffffffff
""",
        "pointer-two": """
    li t0, 0x1000
    li t1, 0x1002
    sw t1, 0(t0)
    li t2, 0xbeef
    sh t2, 4(t0)
    lw t3, 0(t0)
    lhu t4, 2(t3)
    bne t4, t2, 9f
    lw t3, 0(t0)
    lbu t4, 2(t3)
    li t5, 0xef
    bne t4, t5, 9f
    li t2, 0x89abcdef
    sw t2, 4(t0)
    lw t3, 0(t0)
    lw t4, 2(t3)
    bne t4, t2, 9f
    la t2, 8f
    addi t2, t2, -2
    sw t2, 0(t0)
    lw t3, 0(t0)
    jalr zero, 2(t3)
9:  .word 0xffffffff
    .balign 4
8:  ebreak
""",
        "uart": """
    li t0, -4
    li t1, 33
    li t2, 64
    .rept 260
    sb t1, 0(t0)
    addi t1, t1, 1
    bne t1, t2, 1f
    li t1, 33
1:
    .endr
    li t1, 90
    sb t1, 0(t0)
    li s0, 0x10000
    sb t1, 0(s0)
    lb s1, 0(s0)
    ebreak
""",
        "timer": """
    li t0, -8
    lw t1, 0(t0)
    lw t2, 0(t0)
    ebreak
""",
        "timer-overflow": """
    li t0, -8
    .rept 33
    lw t1, 0(t0)
    .endr
    ebreak
""",
    }
    # 旧 JAL 元数据必须在整字及部分字节代码修改后失效。
    for name, value, store in (
        ("word", "0x0080006f", "sw t2, 0(t0)"),
        ("byte", "0x80", "sb t2, 2(t0)"),
        ("half", "0x0080", "sh t2, 2(t0)"),
    ):
        programs[f"code-prediction-{name}"] = f"""
    la t0, victim
    li t2, {value}
    {store}
    fence
    nop
    jalr zero, 0(t0)
victim:
    jal zero, bad
    .word 0xffffffff
    ebreak
bad:
    .word 0xffffffff
"""
    programs["code-prediction-branch"] = """
    la t0, victim
    li t2, 0x00000463
    sw t2, 0(t0)
    fence
    nop
    jalr zero, 0(t0)
victim:
    beq zero, zero, _start
    .word 0xffffffff
    ebreak
"""
    programs["code-prediction-host-partial"] = """
    li t0, 4
1:  addi t0, t0, -1
    bne t0, zero, 1b
    jal zero, 2f
    .word 0xffffffff
2:  ebreak
"""
    transitions = []
    for mnemonic, offsets in [("sb", range(4)), ("sh", (0, 2))]:
        for offset in offsets:
            transitions.append(f"""
    li t0, 0x1000
    sw zero, 0(t0)
    li t1, 1
    {mnemonic} t1, {offset}(t0)
    lw t2, 0(t0)
    beq t2, zero, fail
    j setup_{mnemonic}_{offset}
zero_{mnemonic}_{offset}:
    j done_{mnemonic}_{offset}
setup_{mnemonic}_{offset}:
    li t1, {1 << (offset * 8)}
    sw t1, 0(t0)
    {mnemonic} zero, {offset}(t0)
    lw t2, 0(t0)
    beq t2, zero, zero_{mnemonic}_{offset}
    j fail
done_{mnemonic}_{offset}:
""")
    programs["zero-hint-partial-stores"] = (
        "\n".join(transitions)
        + """
    ebreak
fail: .word 0xffffffff
"""
    )
    programs["zero-hint-host-set"] = """
    li t0, 0x1000
    lw t1, 0(t0)
    beq t1, zero, fail
    ebreak
fail: .word 0xffffffff
    .org 0x1000
    .word 0
"""
    programs["zero-hint-host-clear"] = """
    j setup
done: ebreak
setup:
    li t0, 0x1000
    lw t1, 0(t0)
    beq t1, zero, done
    .word 0xffffffff
    .org 0x1000
    .word 1
"""
    programs["prediction-window"] = """
    j entry
    .word 0xffffffff
    .org 0x10
entry:
    li t0, 0x10000
    jalr ra, 0(t0)
    li t2, 4
    bne s0, t2, fail
    ebreak
fail: .word 0xffffffff
    .org 0x10000
    j high_entry
    .word 0xffffffff
    .org 0x10010
high_entry:
    li s0, 0
    li t1, 4
1:  addi s0, s0, 1
    addi t1, t1, -1
    bne t1, zero, 1b
    jalr zero, 0(ra)
"""
    programs["prediction-window16"] = (
        programs["prediction-window"].replace("0x10010", "0x4010").replace("0x10000", "0x4000")
    )
    programs["prediction-window32"] = (
        programs["prediction-window"].replace("0x10010", "0x8010").replace("0x10000", "0x8000")
    )
    programs["return-hazards"] = """
    li sp, 0x1f000
    li s0, 0
    jal ra, immediate
    jal ra, nested
    lla ra, wb_returned
    addi s0, s0, 1
    ret
wb_returned:
    li t0, 3
    bne s0, t0, return_fail
    ebreak
immediate:
    addi s0, s0, 1
    ret
nested:
    sw ra, 0(sp)
    jal ra, immediate
    lw ra, 0(sp)
    ret
return_fail: .word 0xffffffff
"""
    programs["return-host-change"] = """
    jal ra, return_site
    addi a0, zero, 1
    ebreak
    .org 0x100
return_site: ret
"""
    programs["return-selfmod"] = """
    li t0, 0x100
    li t1, 0x40
    sb t1, 2(t0)
    jal ra, return_site
    addi a0, zero, 1
    ebreak
    .org 0x100
return_site: ret
"""
    for name, body in programs.items():
        source = out / f"{name}.S"
        elf, image, result = (out / f"{name}{suffix}" for suffix in (".elf", ".bin", ".json"))
        source.write_text(".section .text\n.global _start\n_start:\n" + body)
        subprocess.run(
            [
                args.cross + "gcc",
                "-march=rv32i_zmmul",
                "-mabi=ilp32",
                "-mno-relax",
                "-nostdlib",
                "-static",
                "-no-pie",
                "-Wl,--build-id=none",
                "-Ttext=0",
                "-o",
                str(elf),
                str(source),
            ],
            check=True,
        )
        subprocess.run([args.cross + "objcopy", "-O", "binary", str(elf), str(image)], check=True)
        extra = ["--host-byte-write"] if name == "code-prediction-host-partial" else []
        if name in ("zero-hint-host-set", "zero-hint-host-clear"):
            extra = ["--host-patch", "0x1000", "1" if name.endswith("set") else "0", "1"]
        if name == "return-host-change":
            extra = ["--host-patch", "0x100", "0x00400000", "4"]
        run = subprocess.run(
            [
                args.sim,
                *extra,
                "--image",
                str(image),
                "--check",
                "--max-cycles",
                "1000000",
                "--output",
                str(result),
            ],
            capture_output=True,
            text=True,
        )
        if run.returncode:
            raise RuntimeError(run.stdout + run.stderr)
        data = json.loads(result.read_text())
        assert data["halted"] and data["cause"] == 3 and data["invalid_accesses"] == 0, name
        for sample in data["timer"]:
            assert sample["ticks"] == (sample["cycles"] // 200) & 0xFFFFFFFF, name
        if name == "uart":
            assert data["uart"] == "".join(chr(33 + index % 31) for index in range(260)) + "Z", name
            assert data["cycles"] > 8192, "FIFO backpressure was not exercised"
        elif name == "timer":
            assert len(data["timer"]) == 2 and data["timer_overflow"] == 0, name
            assert data["timer"][1]["cycles"] - data["timer"][0]["cycles"] == 1, name
        elif name == "timer-overflow":
            assert len(data["timer"]) == 32 and data["timer_overflow"] == 1, name
        else:
            assert not data["timer"] and not data["uart"], name
        print(f"PASS: {name} ordering, capacity and acceptance timing")


if __name__ == "__main__":
    main()
