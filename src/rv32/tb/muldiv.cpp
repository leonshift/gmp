#include "VMulDiv.h"
#include "verilated.h"
#include <array>
#include <cstdint>
#include <iostream>
#include <random>
#include <stdexcept>

static uint32_t expected(unsigned op, uint32_t a, uint32_t b) {
    switch (op) {
    case 0: return uint32_t(uint64_t(a) * b);
    case 1: return uint32_t(uint64_t(int64_t(int32_t(a)) * int64_t(int32_t(b))) >> 32);
    case 2: return uint32_t(uint64_t(int64_t(int32_t(a)) * int64_t(b)) >> 32);
    case 3: return uint32_t((uint64_t(a) * b) >> 32);
    }
    throw std::runtime_error("unknown M operation");
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    try {
        VMulDiv t;
        auto tick = [&]() { t.clk = 0; t.eval(); t.clk = 1; t.eval(); };
        t.rst_n = 0; t.start = 0; t.consume = 0; t.a = t.b = t.op = 0;
        tick(); tick(); t.rst_n = 1; tick();
        std::mt19937 rng(0x32ab891);
        uint64_t count = 0;
        auto check = [&](unsigned op, uint32_t a, uint32_t b) {
            t.op = op; t.a = a; t.b = b; t.start = 1; tick(); t.start = 0;
            for (unsigned cycles = 0; !t.ready; ++cycles) {
                if (cycles > 80) throw std::runtime_error("M unit did not complete");
                t.a = rng(); t.b = rng(); t.op = rng() & 7;
                tick();
            }
            uint32_t value = expected(op, a, b);
            if (t.result != value) {
                std::cerr << "op=" << op << " a=" << std::hex << a << " b=" << b
                          << " result=" << t.result << " expected=" << value << '\n';
                throw std::runtime_error("M arithmetic mismatch");
            }
            unsigned wait = rng() % 4;
            for (unsigned i = 0; i < wait; ++i) {
                t.a = rng(); t.b = rng(); t.op = rng() & 7; tick();
                if (!t.ready || t.result != value) throw std::runtime_error("pending M result changed");
            }
            t.consume = 1; tick(); t.consume = 0;
            if (t.ready) throw std::runtime_error("M result was not consumed");
            ++count;
        };
        constexpr std::array<uint32_t, 30> edges = {
            0, 1, 2, 15, 16, 127, 128, 255, 256, 511, 512, 65535, 65536,
            0x00ffffff, 0x01000000, 0x7fffffff, 0x80000000,
            0x80000001, 0xffff0000, 0xfffffffe, 0xffffffff, 0x55555555,
            0xfffffff0, 0xfffffff1, 0xffffff00, 0xffffff01,
            0xfffff000, 0xfffff001, 0xff000000, 0xff000001
        };
        for (unsigned op = 0; op < 4; ++op) {
            for (uint32_t a : edges) for (uint32_t b : edges) check(op, a, b);
            for (unsigned i = 0; i < 2000; ++i) check(op, rng(), rng());
        }
        t.op = 3; t.a = t.b = 0xffffffff; t.start = 1; tick(); t.start = 0; tick();
        t.rst_n = 0; tick(); t.rst_n = 1; tick();
        if (t.ready) throw std::runtime_error("cancelled M result became ready");
        check(0, 123, 456);
        std::cout << "PASS: " << count << " M operations, pending-result hold and reset cancellation\n";
        return 0;
    } catch (const std::exception& e) {
        std::cerr << "FAIL: " << e.what() << '\n';
        return 1;
    }
}
