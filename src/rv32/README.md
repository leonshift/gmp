# RV32I_Zmmul

本目录发布四级 RV32I_Zmmul 处理器的 Pyrilog 源码、生成的 Verilog、测试程序和 Verilator 仿真环境，并记录本次发布配置的性能与资源消耗。

本次发布已通过完整功能回归与正式长度的双输入 CoreMark 仿真。完整板级实现的 setup WNS 为 −0.768 ns，尚未满足 200 MHz；下文明确区分仿真性能和 FPGA 时序结果。

处理器采用单发射、顺序执行的 IF、ID、EX、WB 流水线，支持 RV32I 和 `MUL/MULH/MULHSU/MULHU`。除法与取余通过 [sw/softdiv.c](sw/softdiv.c) 实现。程序、数据和栈共享 128 KiB 片上存储，取指与数据访问使用同步双口 RAM。默认 `PREDICT=2`，在 ID 使用静态跳转目标和返回预测；寄存器堆使用 FF，乘法使用 LUT。

## 开始仿真

在 Linux 下准备 Python 3.10 以上版本、GNU Make、支持 C++17 的 G++、Verilator 和 RISC-V GCC/binutils。完整回归还使用 Icarus Verilog 的 `iverilog`、`vvp`。本次验证版本为 Verilator 5.020、GCC/G++ 13.3.0、Icarus Verilog 12.0。

Ubuntu 可安装以下软件包：

```bash
sudo apt-get install python3 make g++ verilator iverilog \
  gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
```

从仓库根目录进入本目录并运行：

```bash
cd src/rv32
make smoke
```

这条命令直接编译 `gen/*.v`，编译 `tb/isa.S` 并启动仿真，使用独立 C++ 指令解释器核对退休事件。成功时输出 `PASS: ... cycles, ... retired, reference=...`，退出状态为 0。直接执行 `make` 也运行这项测试。

仿真使用随包保留的 RTL，所需 CoreMark 源码也在本目录内，启动仿真无需安装 Pyrilog，也无需其他工程目录。

| 命令 | 用途 |
| --- | --- |
| `make lint` | 检查保留的 SoC RTL |
| `make sim` | 编译 Verilator SoC 模型 |
| `make smoke` | 编译并执行 ISA 冒烟测试，逐条核对退休事件 |
| `make test` | 完整回归，包含随机指令、异常、软件除法、外设、停机、复位、访存停顿、取指重放及 AXI |
| `make coremark-short` | 两组输入各运行 10 次迭代，检查 CRC、计时和退休事件 |
| `make -j2 coremark TRACE=0 ITERATIONS=6000` | 并行运行两组正式长度的 CoreMark 仿真并检查结果 |

`coremark-short` 会显示 CoreMark 自带的“至少运行 10 秒”提示，末尾应出现 `PASS：短跑双输入 CRC 与计时校验通过`。短跑只作功能和周期回归，正式分数要求两组输入的计时区间均达到 10 秒。

构建结果放在 `build/`，测试镜像和本次运行结果放在 `out/`，二者均已忽略。默认 SoC 模型路径为 `build/verilator-ff-p2-b8-c0-release-t1/VRv32Soc`。已有从地址 0 链接的 RV32I_Zmmul 小端裸机二进制时，可直接运行：

```bash
make sim
build/verilator-ff-p2-b8-c0-release-t1/VRv32Soc \
  --image path/to/program.bin --check --max-cycles 1000000
```

镜像大小最多为 128 KiB，正常结束使用 `ebreak`；模型默认期望异常原因码为 3。通过 `--expect-cause`、`--expect-pc`、`--expect-tval` 可检查预期异常，通过 `--output result.json` 保存周期、退休数量、计时采样及 UART 输出。

工具路径可在命令行覆盖，例如 `make test PYTHON=python3 CROSS=riscv64-linux-gnu- JOBS=4`。`CROSS` 是工具链前缀，编译器须支持 `-march=rv32i_zmmul -mabi=ilp32`。

## 本次发布的性能

2026-10-18 的测量使用本目录发布的 RTL，参数为 `PREDICT=2 BP_ENTRIES=8 PERF=0`。正式长度仿真关闭退休追踪，使用 `TRACE=0`；功能回归及短跑使用 `TRACE=1`。软件使用 GCC 13.3.0、`-O2 -march=rv32i_zmmul -mabi=ilp32 -mno-div`，CoreMark 算法源码保持原样，并链接软件除法运行库。

### CoreMark

下表来自本次发布 RTL 的 Verilator 双输入仿真。计时器按 CPU 每 200 拍产生 1 微秒建模，分数按 200 MHz 换算。FPGA 的实际时序状态另见后面的时序表；这些数值是仿真测量，尚无板上实测结果。

| 指标 | performance 输入 | validation 输入 |
| --- | ---: | ---: |
| 迭代次数 | 6000 | 6000 |
| 正式计时区间周期数 | 2,116,092,999 | 2,155,723,568 |
| 正式计时区间微秒数 | 10,580,465 | 10,778,618 |
| 平均每次迭代周期数 | 352,682.1665 | 359,287.2613 |
| CRC 及官方成功标志 | 通过 | 通过 |

| 性能指标 | 结果 |
| --- | ---: |
| CoreMark，按 performance 输入计算 | 567.082827 |
| CoreMark/MHz | 2.835414 |
| CoreMark/MHz/kGE，使用下文核心标准单元面积 | 0.174602 |

计算方式为 `CoreMark = 迭代次数 × 1,000,000 / 计时微秒数`，`CoreMark/MHz = CoreMark / 200`。CoreMark/MHz/kGE 的分母只包含 `Rv32Core` 的逻辑与 FF，存储宏和测试外围单独统计。汇总数据见 [summary.json](reports/summary.json)。完整原始输出与源码、镜像及 RTL 哈希见 [performance](reports/coremark/perf.json)、[validation](reports/coremark/valid.json)。编译选项中的路径会写入镜像字符串，换目录构建后镜像哈希可能变化。

发布目录的 10 次迭代短跑也已通过逐条退休对照：performance 的计时区间为 3,526,805 拍，validation 为 3,592,449 拍；包含装载后启动和输出阶段的总执行周期分别为 3,617,635、3,683,026。

### 主要执行开销

| 操作 | 当前实现 |
| --- | --- |
| 取指与数据 RAM 读取 | 请求被接受后下一拍返回 |
| 寄存器读取 | 31 个可写寄存器分成四组共享读端口；两个源需要读取同组不同行且无可用旁路时，增加一拍补读 |
| 小操作数 `MUL` | 第一源为 9 位、第二源为 8 位无符号数时，占用 EX 一拍 |
| 其余 `MUL` | 占用 EX 2～33 拍，乘数耗尽时提前结束 |
| `MULH/MULHSU/MULHU` | 占用 EX 67～69 拍 |
| 除法、取余 | 软件运行库实现；硬件 `DIV/DIVU/REM/REMU` 编码触发非法指令异常 |

## 资源消耗与时序

FPGA 统计来自本次发布 RTL 的 Vivado 2022.2 板级实现，目标器件为 `xc7k480tffg1156-2`。板级 `top` 包含 CPU、共享存储、MMIO/UART/计时采样、AXI 封装、JTAG 桥及跨时钟频率测量。FPGA 配置关闭退休追踪和诊断计数器，即 `TRACE=0 PERF=0`。

### FPGA 层次资源

| 范围/实例 | 综合 LUT | 综合 FF | 布线后 LUT | 布线后 FF | RAMB36 | RAMB18 | DSP |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 完整板级 `top` | 5,158 | 6,834 | 4,793 | 6,836 | 36 | 0 | 0 |
| CPU 系统及 AXI 封装 `u_cpu` | 4,724 | 6,095 | 4,374 | 6,097 | 36 | 0 | 0 |
| SoC `u_cpu/u_soc` | 4,719 | 5,990 | 4,371 | 5,992 | 36 | 0 | 0 |
| SoC 自身外围，不含子模块 | 1,507 | 4,571 | 1,469 | 4,571 | 0 | 0 | 0 |
| 处理器核心 `u_core` | 2,796 | 1,419 | 2,500 | 1,421 | 0 | 0 | 0 |
| 核心乘法单元 `u_md` | 450 | 10 | 433 | 10 | 0 | 0 | 0 |
| 核心寄存器写控制 `u_rf_write` | 94 | 7 | 96 | 9 | 0 | 0 | 0 |
| 共享存储及元数据 `u_ilm_dlm` | 416 | 0 | 408 | 0 | 36 | 0 | 0 |
| JTAG/AXI 桥 `u_bridge` | 244 | 432 | 237 | 432 | 0 | 0 | 0 |
| 高速时钟计数 `u_counter` | 17 | 64 | 17 | 64 | 0 | 0 | 0 |
| 参考时钟测量窗口 `u_window` | 127 | 176 | 119 | 176 | 0 | 0 | 0 |
| 测量结果同步 `u_result` | 45 | 64 | 45 | 64 | 0 | 0 | 0 |

表中每行包含该层次的子模块，父子行不可相加。Vivado 会跨层次合并 LUT，部分子项的 LUT 总和也可能大于父项。完整层次（含寄存器、流水载荷、乘法单元和各 RAM 位平面）见 [布局布线资源报告](reports/fpga/util.rpt)，综合阶段数据见 [综合资源报告](reports/fpga/util_synth.rpt)。

乘法实例使用的外部计算工作区复用核心 EX/WB 寄存器，这些 FF 计入核心层次，未全部出现在乘法实例行。核心的 31×32 位通用寄存器占 992 个 FF。SoC 外围的 FF 还用于 128 字节 UART FIFO、32 项计时采样缓冲、主机接口和运行状态。乘法、寄存器堆与这些缓冲均使用逻辑或 FF，资源检查要求 DSP、LUTRAM、SRL 为零，所有 BRAM 均位于 `u_ilm_dlm`。本次资源检查结果见 [resources_route.json](reports/fpga/resources_route.json)。

### 36 个 RAMB36 的分配

| 存储内容 | 组织 | 声明容量 | RAMB36 |
| --- | --- | ---: | ---: |
| 程序、数据及栈 | 32 个 32768×1 位平面 | 1,048,576 bit，即 128 KiB | 32 |
| 静态取指元数据 | 2 个 4096×9 存储体，覆盖程序前 16 KiB | 73,728 bit，即 9 KiB | 2 |
| 整字零值与非零值标记 | 2 个 32768×1 位平面，覆盖全部程序/数据地址 | 65,536 bit，即 8 KiB | 2 |
| 合计 | 全部位于共享存储层次 | 1,187,840 bit，即 145 KiB | 36 |

36 个 RAMB36 的物理容量合计为 162 KiB，组织方式带来部分未用位。软件可寻址空间是 128 KiB，额外容量保存硬件元数据。

### 标准单元面积

使用 Yosys/ABC 和 Nangate45 typical 库，将全部映射单元面积除以 `NAND2_X1` 的 0.798 µm² 面积，得到 NAND2 等效门数。ABC 组合逻辑映射目标为 5000 ps；这一统计用于面积比较，FPGA 布线时序单独验证。

| 范围 | 映射面积 | NAND2 等效门数 | 包含内容 |
| --- | ---: | ---: | --- |
| `Rv32Core` | 12,958.988 µm² | 16,239.333 GE | 核心逻辑和全部核心 FF |
| `Rv32Soc` | 48,801.424 µm² | 61,154.667 GE | 核心、主机控制、UART、计时采样等逻辑与 FF；共享存储宏单独排除 |

`Rv32Soc` 标准单元面积不包含板级 JTAG 桥及频率测量电路，完整 FPGA `top` 的资源范围见前表。标准单元中的触发器数量与 Vivado FPGA FF 数量会因映射优化不同而变化。标准单元库 SHA-256 为 `8d540a4d4cf6d09d27c87ad067857a9c0c2eeb023ab7a56e058cd3113db4e9b1`。单元明细、工具版本、标准单元库及输入 HDL 哈希见 [核心面积](reports/gates/core.json) 和 [SoC 面积](reports/gates/soc.json)。

### 板级时序

| 指标 | 结果 |
| --- | ---: |
| CPU 约束周期 / 频率 | 5.000 ns / 200 MHz |
| setup WNS / TNS | -0.768 ns / -18.487 ns |
| setup 失败端点 | 80 |
| hold WHS / THS | +0.093 ns / 0.000 ns |
| hold 失败端点 | 0 |
| 脉宽失败端点 | 0 |
| 无时钟、未约束内部端点及组合环检查失败数 | 0 |
| DRC 错误 / 严重警告 / 普通警告 | 0 / 0 / 0 |
| DSP / LUTRAM / SRL | 0 / 0 / 0 |

本次完整板级实现尚未通过 200 MHz 验收，具体失败项见上表。CoreMark 表采用 200 MHz 计时模型，不能据此声称本次 FPGA 实现已达到该运行频率；实物运行尚未验证。

最差 setup 路径从共享 RAM 输出到通用寄存器写入端，数据路径延迟为 5.552 ns，其中布线延迟为 3.623 ns。详细路径见 [setup.rpt](reports/fpga/setup.rpt)，hold 路径见 [hold.rpt](reports/fpga/hold.rpt)。

时序表依据完整板级布局布线报告，原始数据见 [timing.rpt](reports/fpga/timing.rpt)、[clocks.rpt](reports/fpga/clocks.rpt)、[drc.rpt](reports/fpga/drc.rpt) 和 [构建配置](reports/fpga/config.json)。

## 文件与重新生成

| 路径 | 内容 |
| --- | --- |
| `gen/` | 22 个生成的 Verilog 文件、源文件哈希及结构参数 |
| `rtl/pyrilog/` | 处理器、SoC、AXI、存储、时钟测量及 JTAG 桥的 Pyrilog 源码 |
| `tb/` | Verilator C++ 仿真平台、独立指令解释器、汇编与 Python 测试、AXI 测试平台 |
| `sw/` | 软件除法运行库、CoreMark 构建包装、CoreMark 原始算法与裸机移植层 |
| `host/` | 双输入 CoreMark 结果检查，以及保留的板上测试代码 |
| `board/k480t/` | 板级顶层和器件约束 |
| `syn/` | FPGA 资源属性、资源检查、布局布线和标准单元面积统计脚本 |
| `reports/` | 本次发布配置的性能、资源、时序原始数据与发布文件哈希 |

只有修改 Pyrilog 源码并重新生成 RTL 时，才需要 Pyrilog 工具。安装兼容的 Pyrilog 后可运行 `make gen`；也可指定本地 Pyrilog 仓库根目录：

```bash
make gen PYRILOG_ROOT=/path/to/pyrilog
make test
```

`PREDICT=0/1/2` 分别选择关闭预测、动态预测、ID 静态目标与返回预测。默认静态配置会优化掉动态预测器。`TRACE` 控制退休事件输出以供指令对照，`PERF` 控制诊断计数器；完整回归与冒烟测试要求 `TRACE=1`。`BP_ENTRIES` 是生成阶段参数，保留的 RTL 使用 8 项；更改后需先运行 `make gen BP_ENTRIES=16 PYRILOG_ROOT=/path/to/pyrilog`，再以相同 `BP_ENTRIES` 构建。`REV` 只区分构建目录，不切换源码版本。修改 Pyrilog 源码后，应先重新生成，仿真始终编译 `gen/` 中的 RTL。

需要复现 FPGA 报告时，准备 Vivado 2022.2 和对应器件支持，在本目录运行：

```bash
make fpga RUN_TAG=my-build VIVADO_SETTINGS=/path/to/Vivado/2022.2/settings64.sh
```

若 `vivado` 已在 `PATH` 中可省略 `VIVADO_SETTINGS`。流程从当前 `gen/` 生成综合副本，先准备参考布局，再实现实际 PLL 时钟下的完整顶层；结果位于 `build/board/my-build/`。每次修改输入或参数后使用新的 `RUN_TAG`，参考布局会检查输入一致性。时序失败时保留分析报告并返回非零状态。

板上测试程序保留在 `host/run.py`，运行时通过 `--board-host` 指定 GMP 的 `board_host.py` 驱动模块。该驱动需要相应 JTAG 硬件与主机环境，仿真流程不依赖它。

标准单元面积可使用本机的 Yosys 和 Nangate45 库复现，例如：

```bash
python3 syn/gates.py --source build/board/my-build/src \
  --output build/gates-core --top Rv32Core \
  --liberty /path/to/NangateOpenCellLibrary_typical.lib
```

本次 `make test` 与 `make smoke` 均通过，包含两种工作区模式各 11,601 项算术操作、8 个随机程序、2,948 项软件除法/取余结果及 540 种停机相位检查。

将 `--top` 改为 `Rv32Soc` 可统计 SoC，`--yosys /path/to/yosys` 可指定工具。CoreMark 原始源码及许可证保留在 [sw/coremark/src](sw/coremark/src/)，构建前通过 `verify_sources.py` 校验六个算法源文件；移植层来自原工程的裸机测试环境。
