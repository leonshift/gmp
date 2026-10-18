"""生成有依赖的 RV32I_Zmmul 随机程序，由独立 C++ 指令解释器逐次核对退休。"""

import argparse
from pathlib import Path
import random
import struct
import subprocess


def reg(op, rd, f3, rs1, rs2, f7=0):
    return (f7 << 25) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | op


def imm(op, rd, f3, rs1, value):
    return ((value & 4095) << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | op


def program(seed):
    rng = random.Random(seed)
    words = [0x00010FB7]  # x31 = scratch SRAM 0x10000
    for r in range(1, 31):
        value = rng.getrandbits(32)
        words += [
            (value & 0xFFFFF000) | (r << 7) | 0x37,
            imm(0x13, r, 0, r, rng.randrange(-2048, 2048)),
        ]
    for offset in range(0, 256, 4):
        words.append(reg(0x23, offset & 31, 2, 31, 0, offset >> 5))
    for _ in range(2500):
        rd, a, b = (rng.randrange(31) for _ in range(3))
        kind = rng.randrange(7)
        if kind < 2:
            f = rng.randrange(8)
            words.append(reg(0x33, rd, f, a, b, 0x20 if f in (0, 5) and rng.getrandbits(1) else 0))
        elif kind == 2:
            words.append(reg(0x33, rd, rng.randrange(4), a, b, 1))
        elif kind == 3:
            f = rng.randrange(8)
            value = rng.randrange(-2048, 2048)
            if f in (1, 5):
                value = rng.randrange(32) | (0x400 if f == 5 and rng.getrandbits(1) else 0)
            words.append(imm(0x13, rd, f, a, value))
        elif kind == 4:
            f = rng.choice((0, 1, 2, 4, 5))
            offset = rng.randrange(256) & ~((1 << (f & 3)) - 1)
            words.append(imm(3, rd, f, 31, offset))
        elif kind == 5:
            f = rng.randrange(3)
            offset = rng.randrange(256) & ~((1 << f) - 1)
            words.append(reg(0x23, offset & 31, f, 31, b, offset >> 5))
        else:
            f = rng.choice((0, 1, 4, 5, 6, 7))
            words += [reg(0x63, 8, f, a, b), imm(0x13, rd, 0, a, 1)]  # 分支跳过下一条。
    words += [0x00100073, 0x000FA023]
    return struct.pack(f"<{len(words)}I", *words)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--sim", required=True)
    args = parser.parse_args()
    directory = Path("out/random")
    directory.mkdir(parents=True, exist_ok=True)
    for seed in range(8):
        image = directory / f"{seed}.bin"
        image.write_bytes(program(seed))
        subprocess.run(
            [args.sim, "--image", str(image), "--check", "--max-cycles", "1000000"], check=True
        )
    print("PASS: 8 randomized RV32I_Zmmul programs")


if __name__ == "__main__":
    main()
