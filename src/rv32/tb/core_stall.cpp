#include "VRv32Core.h"
#include "verilated.h"
#include "reference.h"
#include <fstream>
#include <iterator>

int main(int argc,char** argv) {
    Verilated::commandArgs(argc,argv);
    try {
        if(argc!=2)throw std::runtime_error("usage: core_stall image.bin");
        std::ifstream input(argv[1],std::ios::binary);
        if(!input)throw std::runtime_error("missing image");
        std::vector<uint8_t> image{std::istreambuf_iterator<char>(input),{}};
        Reference reference(image);std::vector<uint8_t> memory=reference.mem;
        VRv32Core t;t.rst_n=0;t.i_data=t.d_data=t.i_error=t.d_error=t.i_retry=t.d_byte_pause=0;
        t.i_prediction=t.program_word=t.program_data=t.d_zero_hint=0;
        for(unsigned i=0;i<4;i++){t.clk=0;t.eval();t.clk=1;t.eval();}
        t.rst_n=1;uint32_t rng=0x12345678;uint64_t retries=0;
        for(uint64_t cycle=0;cycle<2000000;cycle++) {
            rng=1664525*rng+1013904223;t.i_ready=bool(rng&3);t.d_ready=bool(rng&12);
            t.d_byte_pause=(cycle%31)<9;
            t.clk=0;t.eval();
            if(t.d_valid && t.d_write && bool(t.d_store_local)!=(t.d_addr<memory.size()))
                throw std::runtime_error("store address classification disagrees with full 32-bit address");
            if(bool(t.d_store_valid)!=bool(t.d_valid && t.d_write) ||
               (t.d_store_valid && t.d_store_word!=((t.d_addr>>2)&32767)))
                throw std::runtime_error("store request disagrees with data port");
            if(t.d_valid && ((t.d_addr>>2)&32767)!=
               (t.d_address_forward?((t.d_data>>2)&32767):unsigned(t.d_store_word)))
                throw std::runtime_error("local memory address disagrees with data port");
            reference.step(t);
            const bool fetch=t.i_valid&&t.i_ready, data=t.d_valid&&t.d_ready;
            uint32_t iq=t.i_data,dq=t.d_data,ie=t.i_error,de=0,ir=t.i_retry;
            if(data) {
                if(t.d_addr>=memory.size())de=1;
                else if(t.d_write) {
                    for(unsigned lane=0;lane<4;lane++)if((t.d_wstrb>>lane)&1)memory[(t.d_addr&~3u)+lane]=uint8_t(t.d_wdata>>(8*lane));
                } else {
                    dq=0;for(unsigned lane=0;lane<4;lane++)dq|=uint32_t(memory[(t.d_addr&~3u)+lane])<<(8*lane);
                }
            }
            if(fetch) {
                ie=t.i_addr>=memory.size();iq=0;
                if(!ie)for(unsigned lane=0;lane<4;lane++)iq|=uint32_t(memory[(t.i_addr&~3u)+lane])<<(8*lane);
                ir=data&&t.d_write&&t.d_addr/4==t.i_addr/4;
                if(ir){iq=0xffffffff;++retries;}
            }
            t.clk=1;t.eval();
            t.i_data=iq;t.d_data=dq;t.i_error=ie;t.d_error=de;t.i_retry=ir;t.eval();
            if(t.halt_o) {
                if(t.cause_o!=3)throw std::runtime_error("unexpected trap");
                std::cout<<"PASS: random fetch/data backpressure, "<<reference.instructions<<" compared instructions, "<<retries<<" replayed fetches\n";
                return 0;
            }
        }
        throw std::runtime_error("core stalled indefinitely");
    }catch(const std::exception& e){std::cerr<<"FAIL: "<<e.what()<<'\n';return 1;}
}
