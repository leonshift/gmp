"""运行基准仿真，将本次模型、镜像和受保护源码的哈希附入结果。"""

import argparse
import hashlib
import json
from pathlib import Path
import subprocess


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", type=Path, required=True)
    parser.add_argument("--coremark-root", type=Path, required=True)
    parser.add_argument("arguments", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    arguments = args.arguments[1:] if args.arguments[:1] == ["--"] else args.arguments
    image = Path(arguments[arguments.index("--image") + 1])
    output = Path(arguments[arguments.index("--output") + 1])

    def fingerprint(path):
        return hashlib.sha256(path.read_bytes()).hexdigest()

    image_hash = fingerprint(image)
    model_hash = fingerprint(args.model)
    manifest = json.loads((args.model.parent / "manifest.json").read_text())
    benchmark = {
        path.name: fingerprint(path)
        for path in sorted((args.coremark_root / "src").iterdir())
        if path.is_file()
    }
    software = [
        *sorted((args.coremark_root / "port").glob("*.c")),
        *sorted((args.coremark_root / "port").glob("*.h")),
        args.coremark_root / "port/crt0.S",
        args.coremark_root / "port/link.ld",
        Path(__file__).resolve().parents[1] / "sw/coremark.mk",
        Path(__file__).resolve().parents[1] / "sw/softdiv.c",
    ]
    software_hashes = {str(path.resolve()): fingerprint(path) for path in software}
    subprocess.run([str(args.model), *arguments], check=True)
    if fingerprint(image) != image_hash or fingerprint(args.model) != model_hash:
        raise ValueError("运行期间镜像或仿真模型被替换")
    result = json.loads(output.read_text())
    result["model_manifest"] = manifest
    result["image_sha256"] = image_hash
    result["model_sha256"] = model_hash
    result["benchmark_source_sha256"] = benchmark
    if software_hashes != {str(path.resolve()): fingerprint(path) for path in software}:
        raise ValueError("运行期间软件源文件被替换")
    result["software_source_sha256"] = software_hashes
    output.write_text(json.dumps(result, indent=2) + "\n")
