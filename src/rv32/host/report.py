"""将 RTL/板上采集结果按指定 logix CoreMark report.h 的条件验收。"""

import argparse
import json
from pathlib import Path

CPU_HZ = 200_000_000


def require(condition, message):
    if not condition:
        raise ValueError(message)


def validate(result, validation, short=False):
    require(result["halted"] and result["cause"] == 3, "CoreMark 未正常结束")
    require(
        result["invalid_accesses"] == 0 and result["timer_overflow"] == 0, "访存错误或计时采样溢出"
    )
    require(result["retired"] > 0, "未退休指令")
    samples = result["timer"]
    require(len(samples) >= 2 and len(samples) % 2 == 0, "缺少成对计时样本")
    for sample in samples:
        require(sample["ticks"] == (sample["cycles"] // 200) & 0xFFFFFFFF, "计时器与周期计数不同步")
    start, stop = samples[-2:]
    cycles = stop["cycles"] - start["cycles"]
    ticks = (stop["ticks"] - start["ticks"]) & 0xFFFFFFFF
    require(
        0 < cycles < 200 * 2**32 and stop["cycles"] <= result["cycles"], "计时区间错误或多次回绕"
    )
    fields = {}
    for line in result["uart"].splitlines():
        if ":" in line:
            key, value = (x.strip() for x in line.split(":", 1))
            require(key not in fields, f"重复输出字段：{key}")
            fields[key] = value

    def number(name, base=10):
        return int(fields[name], base)

    require(number("CoreMark Size") == 666, "测试数据大小错误")
    require(number("Iterations") > 0, "迭代次数错误")
    require(number("Total ticks") == ticks, "guest ticks 与硬件采样不一致")
    require(number("Total time (secs)") == ticks // 1_000_000, "guest 时间错误")
    if ticks >= 1_000_000:
        require(
            number("Iterations/Sec") == number("Iterations") // (ticks // 1_000_000),
            "guest 迭代速率错误",
        )
    for key, values in {
        "seedcrc": (0xE9F5, 0x18F2),
        "[0]crclist": (0xE714, 0xE3C1),
        "[0]crcmatrix": (0x1FD7, 0x0747),
        "[0]crcstate": (0x8E3A, 0x8D84),
    }.items():
        require(number(key, 16) == values[validation], f"{key} CRC 错误")
    require(0 <= number("[0]crcfinal", 16) <= 65535, "crcfinal 格式错误")
    success = (
        "Correct operation validated. See README.md for run and reporting rules."
        in result["uart"].splitlines()
    )
    errors = [
        line
        for line in result["uart"].splitlines()
        if "ERROR" in line or "Cannot validate" in line or "Errors detected" in line
    ]
    short_error = "ERROR! Must execute for at least 10 secs for a valid result!"
    if short and ticks < 10_000_000:
        require(short_error in errors, "短跑缺少官方运行时间提示")
        require(
            all(line in (short_error, "Errors detected") for line in errors),
            "CoreMark 报告功能错误",
        )
    else:
        require(success and not errors, "缺少验证成功输出或 CoreMark 报告错误")
    if not short:
        require(ticks >= 10_000_000 and cycles >= 10 * CPU_HZ, "正式计时少于 10 秒")
    return fields, cycles, ticks


def report(perf, valid, short=False):
    p, cycles, ticks = validate(perf, False, short)
    v, _, _ = validate(valid, True, short)
    for key in ("Compiler version", "Compiler flags", "Memory location"):
        require(p[key] == v[key] and p[key], f"两次构建信息不同：{key}")
    if short:
        print(f"PASS：短跑双输入 CRC 与计时校验通过；{cycles} cycles，不作为正式 CoreMark 分数。")
    else:
        score = int(p["Iterations"]) * 1_000_000 / ticks
        print(f"CoreMark: {score:.6f}; CoreMark/MHz: {score / 200:.6f}; backend={perf['backend']}")
        print(
            f"{cycles} timed cycles; {ticks} us; code/data/stack in 128 KiB shared BRAM; single context"
        )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--short", action="store_true")
    parser.add_argument("performance", type=Path)
    parser.add_argument("validation", type=Path)
    args = parser.parse_args()
    report(
        json.loads(args.performance.read_text()),
        json.loads(args.validation.read_text()),
        args.short,
    )
