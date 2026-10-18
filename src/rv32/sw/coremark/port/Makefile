# Build one RV32IM image for both official input sets (runtime MMIO seeds).
CROSS ?= riscv64-linux-gnu-
CC = $(CROSS)gcc
OBJCOPY = $(CROSS)objcopy
PYTHON ?= python3

HERE := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
ROOT := $(abspath $(HERE)/..)
BUILD_DIR ?= $(ROOT)/build
SRC_DIR := $(ROOT)/src

COREMARK_SRCS := core_main.c core_list_join.c core_matrix.c core_state.c core_util.c
OBJS := $(addprefix $(BUILD_DIR)/,$(COREMARK_SRCS:.c=.o) core_portme.o ee_printf.o crt0.o)
# Identical flags for every C source. FLAGS_STR is omitted from its own value.
CFLAGS := -march=rv32im -mabi=ilp32 -mcmodel=medlow -mno-relax -msmall-data-limit=0 -O2 \
          -ffreestanding -fno-builtin -fno-common -fno-pie \
          -nostdlib -nostartfiles -I$(HERE) -I$(SRC_DIR) \
          -DTOTAL_DATA_SIZE=2000 -DMAIN_HAS_NOARGC=1 \
          -Wall -Wno-unused-but-set-variable -Wno-unused-variable
LDFLAGS := -march=rv32im -mabi=ilp32 -mcmodel=medlow -mno-relax -nostdlib \
           -nostartfiles -static -no-pie -T$(HERE)/link.ld -Wl,--gc-sections \
           -Wl,-Map=$(BUILD_DIR)/coremark.map

.PHONY: all check FORCE clean
all: check $(BUILD_DIR)/coremark.bin $(BUILD_DIR)/coremark.elf
check:
	$(PYTHON) $(ROOT)/verify_sources.py $(SRC_DIR)

$(BUILD_DIR):
	mkdir -p $@

# Rebuild when compiler or flags change, including a change of CROSS.
$(BUILD_DIR)/flags: FORCE | $(BUILD_DIR)
	@{ $(CC) --version; printf '%s\n' '$(CFLAGS)' '$(LDFLAGS)'; } > $@.tmp
	@cmp -s $@.tmp $@ || cp $@.tmp $@
	@rm -f $@.tmp

vpath %.c $(SRC_DIR) $(HERE)
vpath %.S $(HERE)
$(BUILD_DIR)/%.o: %.c $(BUILD_DIR)/flags $(SRC_DIR)/coremark.h $(HERE)/core_portme.h
	$(CC) $(CFLAGS) -DFLAGS_STR='"$(CFLAGS) [link] $(LDFLAGS)"' -c -o $@ $<

$(BUILD_DIR)/%.o: %.S $(BUILD_DIR)/flags
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/coremark.elf: $(OBJS) $(HERE)/link.ld
	$(CC) $(LDFLAGS) -o $@ $(OBJS)
	$(CROSS)size $@

$(BUILD_DIR)/coremark.bin: $(BUILD_DIR)/coremark.elf
	$(OBJCOPY) -O binary --pad-to=0x20000 $< $@

clean:
	rm -rf $(BUILD_DIR)
