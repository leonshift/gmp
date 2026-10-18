#include "VRv32Soc.h"
#include "verilated.h"
#include <algorithm>
#include <cstdint>
#include <iostream>
#include <stdexcept>

static constexpr uint32_t HOST = 0x20000000;
static constexpr uint32_t TIMER_LOAD = 0x0002a303;
static constexpr uint32_t UART_STORE = 0x00628023;

struct Harness {
    VRv32Soc t;
    bool running = false;
    unsigned timer_retired = 0, uart_retired = 0;

    Harness() {
        t.rst_n = 0;
        t.h_valid = t.h_rready = 0;
        t.clock_measurement = 0;
        for (unsigned i = 0; i < 4; ++i) tick();
        t.rst_n = 1;
        tick();
    }

    void tick() {
        t.clk = 0;
        t.eval();
        if (running) {
            if (t.halt_o) throw std::runtime_error("loop halted unexpectedly");
            if (t.trace_valid && t.trace_inst == TIMER_LOAD) ++timer_retired;
            if (t.trace_store && t.trace_inst == UART_STORE) ++uart_retired;
        }
        t.clk = 1;
        t.eval();
    }

    uint32_t transaction(uint32_t address, bool write, uint32_t data = 0) {
        t.h_addr = address;
        t.h_write = write;
        t.h_data = data;
        t.h_strb = 15;
        t.h_valid = 1;
        t.h_rready = 0;
        t.clk = 0;
        t.eval();
        unsigned wait = 0;
        while (!t.h_ready) {
            if (++wait > 10000) throw std::runtime_error("request timeout");
            tick();
        }
        tick();
        if (write && address == HOST + 4) running = data & 1;
        t.h_valid = 0;
        t.clk = 0;
        t.eval();
        wait = 0;
        while (!t.h_rvalid) {
            if (++wait > 10000) throw std::runtime_error("response timeout");
            tick();
        }
        if (t.h_error) throw std::runtime_error("host bus error");
        const uint32_t result = t.h_rdata;
        t.h_rready = 1;
        tick();
        t.h_rready = 0;
        return result;
    }

    uint32_t read(uint32_t offset) { return transaction(HOST + offset, false); }
    void control(bool run) { transaction(HOST + 4, true, run); }
};

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    try {
        unsigned exercised_timer = 0, exercised_uart = 0;
        for (unsigned mode = 0; mode < 2; ++mode) {
            for (unsigned phase = 0; phase < 270; ++phase) {
                Harness h;
                if (mode == 0) {
                    h.transaction(0, true, 0xff800293); // addi t0, zero, -8
                    h.transaction(4, true, TIMER_LOAD);
                    h.transaction(8, true, 0xffdff06f); // jal zero, -4
                } else {
                    h.transaction(0, true, 0xffc00293); // addi t0, zero, -4
                    h.transaction(4, true, 0x04100313); // addi t1, zero, 'A'
                    h.transaction(8, true, UART_STORE);
                    h.transaction(12, true, 0xffdff06f);
                }
                h.control(true);
                for (unsigned i = 0; i < phase; ++i) h.tick();
                h.control(false);
                if (h.read(4) != 0) throw std::runtime_error("stop did not clear go");
                const unsigned timers = h.read(0x40), chars = h.read(0x18);
                if (timers != std::min(h.timer_retired, 32u))
                    throw std::runtime_error("stop lost or added a retired timer sample at phase " + std::to_string(phase));
                if (h.read(0x44) != unsigned(h.timer_retired > 32))
                    throw std::runtime_error("wrong timer overflow after stop");
                if (chars != h.uart_retired)
                    throw std::runtime_error("stop lost or added a retired UART byte at phase " + std::to_string(phase));
                for (unsigned i = 0; i < 16; ++i) h.tick();
                if (h.read(0x40) != timers || h.read(0x18) != chars)
                    throw std::runtime_error("peripheral committed after stop");
                for (unsigned i = 0; i < timers; ++i) {
                    const uint64_t cycles = h.read(0x100 + 16*i) |
                        (uint64_t(h.read(0x104 + 16*i)) << 32);
                    if (h.read(0x108 + 16*i) != uint32_t(cycles / 200))
                        throw std::runtime_error("wrong timer acceptance snapshot");
                }
                for (unsigned i = 0; i < chars; ++i)
                    if (h.read(0x14) != 0x141) throw std::runtime_error("wrong stopped UART data");
                if (h.read(0x18) != 0) throw std::runtime_error("UART did not drain");
                exercised_timer += h.timer_retired;
                exercised_uart += h.uart_retired;
            }
        }
        if (!exercised_timer || !exercised_uart) throw std::runtime_error("stop boundary was not exercised");
        std::cout << "PASS: 540 stop phases, accepted timer/UART retirement, overflow, FIFO capacity and stopped-state stability\n";
        return 0;
    } catch (const std::exception& e) {
        std::cerr << "FAIL: " << e.what() << '\n';
        return 1;
    }
}
