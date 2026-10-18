SHELL := /bin/bash
.DEFAULT_GOAL := smoke
PYTHON ?= python3
CROSS ?= riscv64-linux-gnu-
VERILATOR ?= verilator
IVERILOG ?= iverilog
VVP ?= vvp
JOBS ?= 4
COREMARK_ROOT ?= $(CURDIR)/sw/coremark
VIVADO ?= vivado
VIVADO_SETTINGS ?=
PART ?= xc7k480tffg1156-2
RUN_TAG ?= release-p$(PREDICT)-b$(BP_ENTRIES)-c$(PERF)

RTL := $(wildcard gen/*.v) gen/sources.json gen/structure.json
PREDICT ?= 2
TRACE ?= 1
ITERATIONS ?= 0
BP_ENTRIES ?= 8
PERF ?= 0
REV ?= release
export BP_ENTRIES PYRILOG_ROOT PYTHON PREDICT PERF REV RUN_TAG
SIM_DIR := build/verilator-ff-p$(PREDICT)-b$(BP_ENTRIES)-c$(PERF)-$(REV)-t$(TRACE)
SIM := $(SIM_DIR)/VRv32Soc
RESULT_DIR ?= out/coremark/ff-p$(PREDICT)-b$(BP_ENTRIES)-c$(PERF)-$(REV)-t$(TRACE)
CHECK_ARG := $(if $(filter 1,$(TRACE)),--check,)
RUN_MODEL = $(PYTHON) tb/run.py --model $(SIM) --coremark-root $(COREMARK_ROOT) --
.PHONY: gen lint sim test smoke coremark-image coremark-short coremark coremark-perf coremark-valid fpga

gen:
	$(PYTHON) gen.py

lint:
	$(VERILATOR) --lint-only --top-module Rv32Soc -Wno-PINMISSING gen/*.v

$(SIM): $(RTL) Makefile tb/sim.cpp tb/reference.h tb/snapshot.py
	mkdir -p $(SIM_DIR)
	$(PYTHON) tb/snapshot.py $(SIM_DIR) --predict $(PREDICT) --entries $(BP_ENTRIES) --trace $(TRACE) --perf $(PERF) --rev $(REV)
	$(VERILATOR) --cc --exe --build -j $(JOBS) --top-module Rv32Soc -Wno-PINMISSING \
	  --Mdir $(SIM_DIR) -GPREDICT=$(PREDICT) -GTRACE=$(TRACE) -GPERF=$(PERF) \
	  -CFLAGS '-O3 -std=c++17 -DRV32_PREDICT=$(PREDICT) -DRV32_TRACE=$(TRACE) -DRV32_BP_ENTRIES=$(BP_ENTRIES)' \
	  $(CURDIR)/$(SIM_DIR)/src/*.v $(CURDIR)/tb/sim.cpp

sim: $(SIM)

smoke: $(SIM) out/isa.bin
	@test "$(TRACE)" = 1 || { echo 'smoke requires TRACE=1'; exit 1; }
	$(SIM) --image out/isa.bin --check --max-cycles 1000000

out:
	mkdir -p out

coremark-image:
	$(MAKE) -f sw/coremark.mk COREMARK_ROOT=$(COREMARK_ROOT) BUILD_DIR=$(CURDIR)/out/coremark PYTHON=$(PYTHON) CROSS=$(CROSS)

coremark-short: $(SIM) coremark-image
	mkdir -p $(RESULT_DIR)
	$(RUN_MODEL) --image out/coremark/coremark.bin --iterations 10 $(CHECK_ARG) --output $(RESULT_DIR)/short-perf.json
	$(RUN_MODEL) --image out/coremark/coremark.bin --iterations 10 --validation $(CHECK_ARG) --output $(RESULT_DIR)/short-valid.json
	$(PYTHON) host/report.py --short $(RESULT_DIR)/short-perf.json $(RESULT_DIR)/short-valid.json

coremark-perf: $(SIM) coremark-image
	mkdir -p $(RESULT_DIR)
	$(RUN_MODEL) --image out/coremark/coremark.bin --iterations $(ITERATIONS) --max-cycles 60000000000 --output $(RESULT_DIR)/perf.json

coremark-valid: $(SIM) coremark-image
	mkdir -p $(RESULT_DIR)
	$(RUN_MODEL) --image out/coremark/coremark.bin --iterations $(ITERATIONS) --validation --max-cycles 60000000000 --output $(RESULT_DIR)/valid.json

coremark: coremark-perf coremark-valid
	$(PYTHON) host/report.py $(RESULT_DIR)/perf.json $(RESULT_DIR)/valid.json

out/isa.bin: tb/isa.S Makefile | out
	$(CROSS)gcc -march=rv32i_zmmul -mabi=ilp32 -mno-relax -nostdlib -static -no-pie -Wl,--build-id=none -Ttext=0 -o out/isa.elf $<
	$(CROSS)objcopy -O binary out/isa.elf $@

out/replay.bin: tb/replay.S Makefile | out
	$(CROSS)gcc -march=rv32i_zmmul -mabi=ilp32 -mno-relax -nostdlib -static -no-pie -Wl,--build-id=none -Ttext=0 -o out/replay.elf $<
	$(CROSS)objcopy -O binary out/replay.elf $@

CORE_SIM_DIR := build/core-ff-p$(PREDICT)-b$(BP_ENTRIES)-c$(PERF)-$(REV)
CORE_SIM := $(CORE_SIM_DIR)/VRv32Core
$(CORE_SIM): $(RTL) Makefile tb/core_stall.cpp tb/reference.h tb/snapshot.py
	mkdir -p $(CORE_SIM_DIR)
	$(PYTHON) tb/snapshot.py $(CORE_SIM_DIR) --predict $(PREDICT) --entries $(BP_ENTRIES) --perf $(PERF) --rev $(REV)
	$(VERILATOR) --cc --exe --build -j $(JOBS) --top-module Rv32Core -Wno-PINMISSING \
	  --Mdir $(CORE_SIM_DIR) -GPREDICT=$(PREDICT) -GPERF=$(PERF) -CFLAGS '-O3 -std=c++17' \
	  $(CURDIR)/$(CORE_SIM_DIR)/src/*.v $(CURDIR)/tb/core_stall.cpp

MD_SIM_DIR := build/muldiv-$(REV)
MD_SIM := $(MD_SIM_DIR)/VMulDiv
$(MD_SIM): $(RTL) Makefile tb/muldiv.cpp
	mkdir -p $(MD_SIM_DIR)
	$(VERILATOR) --cc --exe --build -j $(JOBS) --top-module MulDiv --Mdir $(MD_SIM_DIR) \
	  -CFLAGS '-O3 -std=c++17' \
	  $(CURDIR)/gen/*MulDiv.v $(CURDIR)/tb/muldiv.cpp

MD_EXTERNAL_DIR := build/muldiv-external-$(REV)
MD_EXTERNAL_SIM := $(MD_EXTERNAL_DIR)/VMulDiv
$(MD_EXTERNAL_SIM): $(RTL) Makefile tb/muldiv_external.cpp tb/reference.h
	mkdir -p $(MD_EXTERNAL_DIR)
	$(VERILATOR) --cc --exe --build -j $(JOBS) --top-module MulDiv --Mdir $(MD_EXTERNAL_DIR) \
	  -GEXTERNAL=1 -GHOLD_RESULT=0 -GEXTERNAL_ARITH=1 -CFLAGS '-O3 -std=c++17' \
	  $(CURDIR)/gen/*MulDiv.v $(CURDIR)/tb/muldiv_external.cpp

HOST_STOP_SIM := $(SIM_DIR)/host_stop
VERILATOR_INCLUDE := $(shell $(VERILATOR) -getenv VERILATOR_ROOT)/include
$(HOST_STOP_SIM): $(SIM) tb/host_stop.cpp
	$(CXX) -O3 -std=c++17 -I$(SIM_DIR) -I$(VERILATOR_INCLUDE) -I$(VERILATOR_INCLUDE)/vltstd \
	  tb/host_stop.cpp $(SIM_DIR)/VRv32Soc__ALL.a $(SIM_DIR)/verilated.o $(SIM_DIR)/verilated_threads.o \
	  -pthread -latomic -o $@

CORE_RESET_SIM := $(CORE_SIM_DIR)/core_reset
$(CORE_RESET_SIM): $(CORE_SIM) tb/core_reset.cpp tb/reference.h
	$(CXX) -O3 -std=c++17 -I$(CORE_SIM_DIR) -I$(VERILATOR_INCLUDE) -I$(VERILATOR_INCLUDE)/vltstd \
	  tb/core_reset.cpp $(CORE_SIM_DIR)/VRv32Core__ALL.a $(CORE_SIM_DIR)/verilated.o $(CORE_SIM_DIR)/verilated_threads.o \
	  -pthread -latomic -o $@

test: lint $(SIM) $(CORE_SIM) $(MD_SIM) $(MD_EXTERNAL_SIM) $(CORE_RESET_SIM) $(HOST_STOP_SIM) out/isa.bin out/replay.bin
	@test "$(TRACE)" = 1 || { echo 'test requires TRACE=1'; exit 1; }
	$(MD_SIM)
	$(MD_EXTERNAL_SIM)
	$(SIM) --image out/isa.bin --check --max-cycles 1000000
	$(PYTHON) tb/random_test.py --sim $(SIM)
	$(PYTHON) tb/trap_test.py --sim $(SIM)
	$(PYTHON) tb/softdiv_test.py --sim $(SIM) --cross $(CROSS)
	$(PYTHON) tb/peripheral_test.py --sim $(SIM) --cross $(CROSS)
	$(HOST_STOP_SIM)
	$(CORE_SIM) out/isa.bin
	$(CORE_RESET_SIM)
	$(SIM) --image out/replay.bin --check --max-cycles 1000000
	$(CORE_SIM) out/replay.bin
	for image in out/random/*.bin; do $(CORE_SIM) $$image || exit 1; done
	$(IVERILOG) -g2012 -s axi_tb -Paxi_tb.PREDICT=$(PREDICT) -Paxi_tb.PERF=$(PERF) -o out/axi.vvp tb/axi_tb.sv gen/*.v
	$(VVP) out/axi.vvp

fpga:
	$(PYTHON) syn/prepare.py build/board/$(RUN_TAG)/src --board
	mkdir -p build/board/$(RUN_TAG)
	cp syn/vivado.tcl build/board/$(RUN_TAG)/flow.tcl
	$(if $(strip $(VIVADO_SETTINGS)),source "$(VIVADO_SETTINGS)" && ,)RV32_PYTHON="$(shell command -v $(PYTHON))" $(VIVADO) -mode batch \
	  -source build/board/$(RUN_TAG)/flow.tcl -log build/board/$(RUN_TAG)/vivado.log \
	  -journal build/board/$(RUN_TAG)/vivado.jou -tclargs $(PART) board
