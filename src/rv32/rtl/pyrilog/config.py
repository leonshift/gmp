"""生成阶段的结构参数。"""

import os

BP_ENTRIES = int(os.environ.get("BP_ENTRIES", "8"))
if BP_ENTRIES not in (8, 16, 32, 64, 128):
    raise ValueError("BP_ENTRIES must be 8, 16, 32, 64 or 128")

ILM_PREDICT_BITS = 12
