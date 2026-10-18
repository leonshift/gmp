# Use the protected CoreMark sources and port with a multiply-only ISA.
include $(COREMARK_ROOT)/port/Makefile

SOFTDIV := $(abspath sw/softdiv.c)
CFLAGS := $(filter-out -march=%,$(CFLAGS)) -march=rv32i_zmmul -mno-div
LDFLAGS := $(filter-out -march=%,$(LDFLAGS)) -march=rv32i_zmmul -mno-div
OBJS += $(BUILD_DIR)/softdiv.o

$(BUILD_DIR)/softdiv.o: $(SOFTDIV) $(BUILD_DIR)/flags
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/coremark.elf: $(BUILD_DIR)/softdiv.o
