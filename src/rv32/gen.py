#!/usr/bin/env python3
"""从随包发布的 Pyrilog 源码生成 Verilog。"""

import hashlib
import json
import os
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
if os.environ.get("PYRILOG_ROOT"):
    sys.path.insert(0, os.environ["PYRILOG_ROOT"])
from pyrilog.hdl import gen_hdl
from rtl.pyrilog.soc import Rv32Soc
from rtl.pyrilog.axi import Rv32Axi
from rtl.pyrilog.clock_check import ClockCounter, ClockWindow, ClockResult
from rtl.pyrilog.config import BP_ENTRIES, ILM_PREDICT_BITS
from rtl.pyrilog.bscan_axi_bridge import BscanAxiBridge


def modules(top, seen):
    if top.__name__ not in seen:
        seen[top.__name__] = top
        for instance in top.instances.values():
            modules(instance.of_cls, seen)


def main():
    seen = {}
    modules(Rv32Soc, seen)
    modules(Rv32Axi, seen)
    for cls in (ClockCounter, ClockWindow, ClockResult):
        modules(cls, seen)
    modules(BscanAxiBridge, seen)
    out = HERE / "gen"
    out.mkdir(exist_ok=True)
    for stale in out.glob("*.v"):
        if stale.stem not in seen:
            stale.unlink()
    for name, cls in seen.items():
        (out / f"{name}.v").write_text(gen_hdl(cls))
        print(f"gen/{name}.v")
    sources = [Path(__file__).resolve(), *sorted((HERE / "rtl/pyrilog").glob("*.py"))]
    manifest = {
        str(path.relative_to(HERE)): hashlib.sha256(path.read_bytes()).hexdigest()
        for path in sources
    }
    (out / "sources.json").write_text(json.dumps(manifest, indent=2) + "\n")
    (out / "structure.json").write_text(
        json.dumps(
            {
                "isa": "rv32i_zmmul",
                "pipeline_stages": 4,
                "multiplier": "compact",
                "bp_entries": BP_ENTRIES,
                "storage": "ff_except_ilm_dlm",
                "ilm_prediction_bytes": 4 * (1 << ILM_PREDICT_BITS),
            }
        )
        + "\n"
    )


if __name__ == "__main__":
    main()
