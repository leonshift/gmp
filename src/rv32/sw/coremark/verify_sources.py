"""Check the unmodified EEMBC files, without requiring network access."""

import hashlib
from pathlib import Path
import sys

# https://github.com/eembc/coremark/tree/1f483d5b8316753a742cbf5590caf5bd0a4e4777
HASHES = {
    "core_main.c": "17884c93c5b94378eb0ff02b4df3725756cf2addb9b8cbcaa6200a4649ff5ca7",
    "core_list_join.c": "ca00e4e010ece47d7f040cb92aa50a95345a00d3171b59d088f6b243be06ce7b",
    "core_matrix.c": "ecdff717b5a5c4907d221a606760e25499899cbf617582c05d40db71c91351e4",
    "core_state.c": "f4b84bb0a3452c45a4daa664ab502bfdccbd31cb57d93e9ac490c60937717a4e",
    "core_util.c": "a3fbfcb9bb943b638624b8ece01c5836dd56a96d7bcde2697b248d077447327f",
    "coremark.h": "42642b9a06c7ed2b3bd9eda971b7c3868c4f5d27bf7ef6c4bba11291a0c2598a",
}


def main():
    source_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).parent / "src"
    for name, expected in HASHES.items():
        actual = hashlib.sha256((source_dir / name).read_bytes()).hexdigest()
        if actual != expected:
            raise SystemExit(f"CoreMark source differs from EEMBC: {name}: {actual}")


if __name__ == "__main__":
    main()
