"""同步异常与错路取消的定向检查。"""

import argparse
from pathlib import Path
import struct
import subprocess


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--sim", required=True)
    args = parser.parse_args()
    out = Path("out/trap")
    out.mkdir(parents=True, exist_ok=True)
    # 每个故障后接 store，观察停机后存储器未被年轻指令更改。
    cases = [
        ("illegal", [0xFFFFFFFF], 2, 0, None),
        ("ecall", [0x00000073], 11, 0, 0),
        ("load-misaligned", [0x00102083], 4, 0, 1),
        ("store-misaligned", [0x00002123], 6, 0, 2),
        ("jump-misaligned", [0x0020006F], 0, 0, 2),
        ("load-unmapped", [0x000200B7, 0x0000A103], 5, 4, 0x20000),
        ("store-unmapped", [0x000200B7, 0x0000A023], 7, 4, 0x20000),
        ("fetch-unmapped", [0x000200B7, 0x00008067], 1, 0x20000, 0x20000),
        ("fetch-physical-alias", [0x000200B7, 0x00002023, 0x00008067], 1, 0x20000, 0x20000),
        ("wrong-path", [0x00C0006F, 0xFFFFFFFF, 0x00002023, 0x00100073], 3, 12, 0),
        # BNE x0,x0,-4：静态预测会读取越界目标，实际不跳转时必须取消该取指错误。
        ("predicted-fetch-error", [0xFE001EE3, 0x00100073], 3, 4, 0),
        ("predicted-misaligned-not-taken", [0xFE001FE3, 0x00100073], 3, 4, 0),
        ("load-zero-unmapped", [0x000200B7, 0x0000A003], 5, 4, 0x20000),
        (
            "load-zero-branch-misaligned",
            [0x000010B7, 0x0000A023, 0x0000A103, 0x00010163],
            0,
            12,
            14,
        ),
        (
            "load-zero-branch-misaligned-not-taken",
            [0x000010B7, 0x0000A023, 0x0000A103, 0x00011163, 0x00100073],
            3,
            16,
            0,
        ),
        ("store-address-wrap", [0xFF000093, 0x05A00113, 0x0220A823, 0x00100073], 3, 12, 0),
        ("store-address-borrow", [0x000200B7, 0x05A00113, 0xFE20AE23, 0x00100073], 3, 12, 0),
        (
            "store-address-overflow",
            [0x000200B7, 0xFF008093, 0x05A00113, 0x0220A023],
            7,
            12,
            0x20010,
        ),
        (
            "store-address-underflow",
            [0x000200B7, 0x05A00113, 0xFE20AE23, 0x00000093, 0x05B00113, 0xFE20AE23],
            7,
            20,
            0xFFFFFFFC,
        ),
    ]
    for function, name in enumerate(("div", "divu", "rem", "remu"), 4):
        for rd in (0, 3):
            instruction = 0x02000033 | (function << 12) | (rd << 7)
            cases.append((f"illegal-{name}-rd{rd}", [instruction], 2, 0, instruction))
    cases.append(("wrong-path-div", [0x00C0006F, 0x02004033, 0x00002023, 0x00100073], 3, 12, 0))
    guards = {
        "store-address-wrap": (32, 90),
        "store-address-borrow": (0x1FFFC, 90),
        "store-address-overflow": (16, 0x00002023),
        "store-address-underflow": (0x1FFFC, 90),
    }
    # WB 故障与年轻乘除法相遇时，保留原始故障 PC 和异常值。
    faults = [
        ("illegal", [0x000200B7, 0x0000007F], 2, 4, 0x7F),
        ("load", [0x000200B7, 0x0000A103], 5, 4, 0x20000),
        ("store", [0x000200B7, 0x0000A023], 7, 4, 0x20000),
        ("break", [0x000200B7, 0x00100073], 3, 4, 0),
    ]
    for operation, function in (("mul", 0), ("div", 4), ("remu", 7)):
        for fault, prefix, cause, pc, tval in faults:
            cases.append(
                (
                    f"{fault}-before-{operation}",
                    [*prefix, 0x020081B3 | (function << 12)],
                    cause,
                    pc,
                    tval,
                )
            )
    for name, words, cause, pc, tval in cases:
        words += [0x00002023, 0x00100073]
        path = out / f"{name}.bin"
        path.write_bytes(struct.pack(f"<{len(words)}I", *words))
        first_word = 0 if name == "fetch-physical-alias" else words[0]
        command = [
            args.sim,
            "--image",
            str(path),
            "--expect-cause",
            str(cause),
            "--expect-pc",
            str(pc),
            "--max-cycles",
            "10000",
            "--expect-word",
            "0",
            str(first_word),
        ]
        if tval is not None:
            command += ["--expect-tval", str(tval)]
        if name in guards:
            address, value = guards[name]
            command += ["--expect-word", str(address), str(value)]
        subprocess.run(command, check=True)
    print("PASS: precise trap and wrong-path tests")


if __name__ == "__main__":
    main()
