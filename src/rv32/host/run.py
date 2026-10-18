#!/usr/bin/env python3
"""GMP k480t JTAG 通道：烧录、镜像读回、双输入 CoreMark 与原始结果采集。"""

import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import struct
import time

from report import report, require

ROOT = Path(__file__).resolve().parents[1]
BASE = 0x20000000


def board_module(path):
    spec = importlib.util.spec_from_file_location("rv32_board", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def drain(transport, output):
    count = transport.read32(BASE + 0x18)
    require(count <= 1024, "UART count 不合法")
    words = transport.read32_many([BASE + 0x14] * count) if count else []
    for word in words:
        require(word & 0x100, "UART 消费时无数据")
        output.append(word & 255)


def run(transport, image, validation, iterations, timeout):
    def read(offset):
        return transport.read32(BASE + offset)

    transport.write32(BASE + 4, 0)
    require(read(0) == 0x52563332, "bitstream 标识错误")
    padded = image + bytes((-len(image)) % 4)
    words = list(struct.unpack(f"<{len(padded) // 4}I", padded))
    require(len(padded) <= 131072, "镜像超过 SRAM")
    transport.write_burst(0, words)
    # 全镜像读回确认装载与字节顺序，含零填充。
    require(transport.read_burst(0, len(words)) == words, "SRAM 镜像读回不一致")
    seeds = [0x3415 if validation else 0, 0x3415 if validation else 0, 0x66, iterations]
    transport.write32_many([(BASE + 0x30 + 4 * i, value) for i, value in enumerate(seeds)])
    measured = read(0x4C)
    require(abs(measured - 200000) <= 4, f"功能时钟不是参考时钟的四倍：{measured} cycles/ms")
    output = bytearray()
    start = time.monotonic()
    transport.write32(BASE + 4, 1)
    last_progress = start
    while not read(8) & 2:
        drain(transport, output)
        require(time.monotonic() - start <= timeout, "板上运行超时")
        if time.monotonic() - last_progress >= 10:
            print(f"板上运行 {time.monotonic() - start:.1f}s", flush=True)
            last_progress = time.monotonic()
        time.sleep(0.01)
    wall_seconds = time.monotonic() - start
    drain(transport, output)
    cause = read(0xC)
    require(cause == 3, f"CPU 异常 cause={cause} pc={read(0x10):08x} tval={read(0x48):08x}")
    count = read(0x40)
    require(count <= 32, "计时采样数超界")
    samples = []
    for index in range(count):
        off = 0x100 + 16 * index
        samples.append({"cycles": read(off) | (read(off + 4) << 32), "ticks": read(off + 8)})
    result = {
        "backend": "xc7k480t",
        "halted": True,
        "cause": cause,
        "cycles": read(0x1C) | (read(0x20) << 32),
        "retired": read(0x24) | (read(0x28) << 32),
        "invalid_accesses": read(0x2C),
        "timer_overflow": read(0x44),
        "load_stalls": read(0x50),
        "muldiv_stalls": read(0x54),
        "redirects": read(0x58),
        "timer": samples,
        "uart": output.decode("ascii"),
        "wall_seconds": wall_seconds,
        "clock_cycles_per_ms": measured,
        "image_sha256": hashlib.sha256(image).hexdigest(),
    }
    require(result["cycles"] / 200e6 <= wall_seconds + 0.1, "板上周期计数与主机时间不一致")
    print(result["uart"], end="", flush=True)
    transport.write32(BASE + 4, 0)
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--board-host", type=Path, required=True, help="GMP board_host.py 驱动模块路径")
    parser.add_argument("--program", type=Path)
    parser.add_argument("--identify", action="store_true")
    parser.add_argument("--image", type=Path)
    parser.add_argument("--output", type=Path, default=ROOT / "out/board")
    parser.add_argument("--iterations", type=int, default=0)
    parser.add_argument("--repeats", type=int, default=3)
    parser.add_argument("--timeout", type=float, default=300)
    args = parser.parse_args()
    module = board_module(args.board_host)
    transport = module.open_jtag()
    try:
        ok, info = module.identify(transport)
        require(ok, info)
        print(info, flush=True)
        if args.program:
            require(module.program_jtag(transport, str(args.program.resolve())), "FPGA DONE 未置位")
            time.sleep(0.05)
        if args.image:
            args.output.mkdir(parents=True, exist_ok=True)
            image = args.image.read_bytes()
            for repeat in range(args.repeats):
                results = []
                for validation in (False, True):
                    result = run(transport, image, validation, args.iterations, args.timeout)
                    if args.program:
                        result["bit_sha256"] = hashlib.sha256(args.program.read_bytes()).hexdigest()
                    name = f"{repeat}-{'validation' if validation else 'performance'}"
                    (args.output / f"{name}.json").write_text(json.dumps(result, indent=2) + "\n")
                    (args.output / f"{name}.log").write_text(result["uart"])
                    results.append(result)
                report(*results, short=args.iterations != 0)
    finally:
        transport.close()


if __name__ == "__main__":
    main()
