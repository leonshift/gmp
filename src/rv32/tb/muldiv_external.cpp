#include "VMulDiv.h"
#include "verilated.h"
#include "reference.h"
#include <random>

struct Trace {
    uint32_t trace_valid=1,trace_inst=0,trace_pc=0,trace_trap=0;
    uint32_t trace_rd=10,trace_data=0,trace_store=0,trace_addr=0,trace_wdata=0,trace_mask=0;
};

int main(int argc,char** argv) {
    Verilated::commandArgs(argc,argv);
    try {
        VMulDiv t;
        auto refresh=[&]() {
            t.external_small=(t.a>>9)==0 && (t.b>>8)==0;
            const uint64_t sum=uint64_t(t.storage_high)+uint32_t(t.storage_partial);
            t.external_sum=sum;t.external_carry=sum>>32;
            t.eval();
        };
        auto tick=[&]() {
            t.clk=0;refresh();
            const bool work=t.rst_n && !t.ready;
            const uint32_t a=t.operand_next,q=t.quotient_next;
            const bool partial=t.partial_capture;
            const uint64_t product=t.partial_product;
            const uint32_t h=t.accumulating?t.high_accumulate:(partial?t.storage_high:0);
            t.clk=1;t.eval();
            if(work) {
                t.storage_a=a;t.storage_b=q;t.storage_high=h;
                if(partial)t.storage_partial=product;
                refresh();
            }
        };
        t.rst_n=t.start=t.consume=t.a=t.b=t.op=0;
        t.storage_a=t.storage_b=t.storage_high=0;
        t.storage_partial=0;
        tick();tick();t.rst_n=1;tick();
        Reference reference(std::vector<uint8_t>(4));
        std::mt19937 rng(0x32ab891);
        uint64_t count=0;
        auto check=[&](unsigned op,uint32_t a,uint32_t b) {
            t.op=op;t.a=a;t.b=b;t.start=1;t.clk=0;refresh();
            if(op==0 && (a>>9)==0 && (b>>8)==0 && !t.ready)
                throw std::runtime_error("small multiply did not complete in its request cycle");
            for(unsigned cycles=0;!t.ready;cycles++) {
                if(cycles>80)throw std::runtime_error("external M unit did not complete");
                tick();t.start=0;t.a=t.storage_high;t.eval();
            }
            Trace trace;
            trace.trace_inst=0x02000033|(op<<12)|(10<<7)|(11<<15)|(12<<20);
            trace.trace_data=t.result;
            reference.pc=0;reference.instructions=0;reference.r.fill(0);
            reference.r[11]=a;reference.r[12]=b;
            for(unsigned lane=0;lane<4;lane++)reference.mem[lane]=trace.trace_inst>>(8*lane);
            reference.step(trace);
            t.consume=1;tick();t.start=t.consume=0;t.eval();
            if(t.ready)throw std::runtime_error("external M result was not consumed");
            ++count;
        };
        constexpr std::array<uint32_t,30> edges={
            0,1,2,15,16,127,128,255,256,511,512,65535,65536,
            0x00ffffff,0x01000000,0x7fffffff,0x80000000,
            0x80000001,0xffff0000,0xfffffffe,0xffffffff,0x55555555,
            0xfffffff0,0xfffffff1,0xffffff00,0xffffff01,
            0xfffff000,0xfffff001,0xff000000,0xff000001
        };
        for(unsigned op=0;op<4;op++) {
            for(uint32_t a:edges)for(uint32_t b:edges)check(op,a,b);
            for(unsigned i=0;i<2000;i++)check(op,rng(),rng());
        }
        t.op=3;t.a=t.b=0xffffffff;t.start=1;tick();t.start=0;tick();
        t.rst_n=0;tick();t.rst_n=1;tick();
        if(t.ready)throw std::runtime_error("cancelled external M result became ready");
        check(0,123,456);
        std::cout<<"PASS: "<<count<<" external-workspace M operations, ready-cycle consumption and reset cancellation\n";
        return 0;
    } catch(const std::exception& error) {
        std::cerr<<"FAIL: "<<error.what()<<'\n';return 1;
    }
}
