"""冻结仿真 HDL 及生成配置，避免不同实验复用或覆盖彼此的源文件。"""

import argparse
import hashlib
import json
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parents[1]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", type=Path)
    parser.add_argument("--predict", type=int, required=True)
    parser.add_argument("--entries", type=int, required=True)
    parser.add_argument("--trace", type=int, default=1)
    parser.add_argument("--perf", type=int, default=1)
    parser.add_argument("--rev", default=None)
    args = parser.parse_args()
    generated = ROOT / "gen"
    structure = json.loads((generated / "structure.json").read_text())
    if structure["bp_entries"] != args.entries:
        raise ValueError("生成配置与当前实验不一致")
    output = args.directory / "src"
    output.mkdir(parents=True, exist_ok=True)
    for path in generated.glob("*.v"):
        shutil.copyfile(path, output / path.name)
    result = {
        "parameters": {
            "predict": args.predict,
            "bp_entries": args.entries,
            "trace": args.trace,
            "perf": args.perf,
            "rev": args.rev,
        },
        "pipeline_stages": 4,
        "structure": structure,
        "rtl_sha256": {
            path.name: hashlib.sha256(path.read_bytes()).hexdigest() for path in output.glob("*.v")
        },
        "source_sha256": json.loads((generated / "sources.json").read_text()),
    }
    (args.directory / "manifest.json").write_text(json.dumps(result, indent=2) + "\n")
