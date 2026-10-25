<div align="center">

<h1>GMP</h1>
<p><strong>AI Native 端到端大模型推理芯片</strong></p>
<p>单片 Kintex-7 FPGA 运行 Qwen3-0.6B，完成全部 28 层计算</p>

<p>
  <img src="https://img.shields.io/badge/Decode-19.22_token%2Fs-2563eb?style=flat-square" alt="decode 速度：板上实测 19.22 token/s">
  <img src="https://img.shields.io/badge/Prefill_64_tokens-0.36_s-2563eb?style=flat-square" alt="64 个 token 的 prefill 耗时：按周期数与时钟频率计算为 0.36 秒">
  <img src="https://img.shields.io/badge/Clock-150_MHz-2563eb?style=flat-square" alt="芯片运行频率：150 MHz">
</p>

<p><a href="README.en.md">English</a> · <a href="#g1架构">G1架构</a> · <a href="#快速开始">快速开始</a> · <a href="docs/bitstream.md">性能与资源</a></p>

</div>

- **单片 FPGA 完成整网推理**：Qwen3-0.6B 的 prefill 和 decode 均在 FPGA 上执行，覆盖全部 28 层。主机负责分词、数据传输和显示生成结果。
- **一个月完成软硬件开发**：模型编译器、逐拍模型、RTL 和主机驱动的代码均由 AI Agent 编写。开发涉及三个仓库，共完成 541 次提交，人未直接编写代码。
- **用 Python 描述硬件**：通过 Pyrilog，将 3.6 万行硬件描述代码转换为 12.6 万行 Verilog，共生成 278 个模块。

<p align="center">
  <img src="demo/chat.gif" alt="Kintex-7 FPGA 运行 Qwen3-0.6B 的对话演示" width="800">
</p>
<p align="center"><a href="docs/usage.md">板上运行记录</a> · <a href="docs/bitstream.md">性能与资源</a> · <a href="demo/board_front_back.jpg">板卡照片</a></p>

## G1架构

G1 面向端侧大模型推理，在单片 Kintex-7 FPGA（`xc7k480t`）上实现，模型权重存放在板载双通道 DDR3 中。
模型编译器生成整网执行程序，片上 RV32 控制核执行该程序，驱动矩阵单元和向量单元完成计算。主机通过千兆以太网与芯片通信。

![G1 系统架构](docs/overview.svg)

编译器根据片上缓冲容量和计算指令的执行延迟，预先确定调度方案。整网 prefill 和 decode 编译后的程序镜像共 **52 KB**。
编译器将权重分块存放，并按照 DRAM 的行结构安排访存，使每步 decode 的实际读取量从 **1,114 MB 降至 662 MB**。

当前发布版本支持的上下文长度为 128 个 token。decode 速度采用板上实测值，prefill 耗时根据运行周期数和 150 MHz 时钟频率计算。
硬件配置、资源占用和时序结果见[性能与资源报告](docs/bitstream.md)。

## 开发方式

人负责顶层架构和系统抽象，并决定采用哪些设计方案。通用 AI Agent 参与微架构、流水线划分和算子实现方案的讨论，并编写各层代码。
开发范围包括模型编译器、算子参考实现、用 C++ 编写的逐拍模型、RTL、综合与布局布线流程，以及主机驱动。
CPU 核、加速指令集和配套工具均为自研。FPGA 实现中使用了 DDR3 控制器、时钟原语和第三方以太网 MAC。

硬件逻辑使用 **Pyrilog** 编写，再由生成器转换为 Verilog。一个 Python 类对应一个硬件模块，时序逻辑写在 `cycle` 方法中，
时钟和复位由工具自动连接。同一份 Pyrilog 代码始终生成相同的 Verilog 文件，生成时还会检查信号引用。

**逐拍建模框架**使用 C++ 协程模拟各硬件单元。在 RTL 实现之前，就可以运行完整网络、验证设计并评估新硬件。
统计结果以 JSON 格式输出，供 Agent 分析。编译器、逐拍模型和 RTL 使用相同的参考数据进行自动检查。
设计依据记录在分层文档中，写作和协作要求写入自动加载的 skill。

## 快速开始

**在 FPGA 上运行**：按照[环境搭建](docs/setup.md)准备板卡、Linux 主机和连接线缆，安装依赖并配置权限，然后执行：

```bash
python host/soc_generate.py --chat "请用一句话介绍一下你自己。"
```

脚本会检查板卡状态，按需烧录 bitstream 并加载权重，随后开始生成文本。首次运行约需一分钟。
烧录通过仓库中的 pyjtag 完成，不需要安装 Vivado。使用方法和故障排查见[使用指南](docs/usage.md)。

**在仿真中运行**：预编译的整机仿真程序支持 Linux x86-64，需要 Python 3.9 或更新版本及 NumPy：

```bash
pip install numpy
python host/soc_generate.py --sim --chat "请用一句话介绍一下你自己。"
```

整机仿真通过 Verilator 运行芯片 RTL，主机程序与 FPGA 运行时相同。仿真速度明显低于 FPGA，内存和运行要求见[仿真指南](docs/simulation.md)。

仓库包含以下文件和源码：

- [预编译文件](prebuilt/)和[模型数据](data/)：bitstream、整机仿真程序、Qwen3-0.6B 定点权重、启动镜像和分词词表。
- [主机程序](host/)和 [JTAG 烧录工具](tools/pyjtag/)：推理控制、以太网通信和 bitstream 烧录的源码。
- [独立的 RV32I_Zmmul 处理器核](src/rv32/)：Pyrilog 源码、生成的 Verilog、测试程序、仿真环境和性能报告。

推理芯片的完整 RTL、模型编译器、综合脚本，以及 Pyrilog 和逐拍建模框架的完整源码未随仓库发布。
预编译的推理文件用于运行 Qwen3-0.6B，不能用来重新生成推理 bitstream 或编译其他模型。

## 许可证

本仓库采用 [MIT License](LICENSE)。Qwen3-0.6B 词表遵循 Apache-2.0，随 Xilinx 线缆分发的固件保留原有授权。
预编译仿真程序链接了 Verilator 5.020 运行时，该运行时采用 LGPL-3.0-only 或 Artistic-2.0 双重许可。
CoreMark 源码的许可证见其目录内的 [LICENSE.md](src/rv32/sw/coremark/src/LICENSE.md)。
