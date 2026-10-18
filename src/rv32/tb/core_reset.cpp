#include "VRv32Core.h"
#include "verilated.h"
#include "reference.h"

static uint32_t fetch(VRv32Core& t, const std::vector<uint32_t>& memory) {
    if(!t.i_valid || !t.i_ready)return t.i_data;
    return t.i_addr/4<memory.size()?memory[t.i_addr/4]:0x00100013;
}

static void cycle(VRv32Core& t, const std::vector<uint32_t>& memory, Reference* reference=nullptr) {
    t.clk=0;t.eval();
    if(reference)reference->step(t);
    const uint32_t instruction=fetch(t,memory);
    t.clk=1;t.eval();t.i_data=instruction;t.eval();
}

int main(int argc,char** argv) {
    Verilated::commandArgs(argc,argv);
    try {
        VRv32Core t;
        t.i_ready=t.d_ready=1;
        t.i_data=t.d_data=t.i_error=t.d_error=t.i_retry=t.d_byte_pause=0;
        t.i_prediction=t.program_word=t.program_data=0;
        t.rst_n=0;
        const std::vector<uint32_t> warmup={0x00700193,0x00b00213};
        for(unsigned i=0;i<4;i++)cycle(t,warmup);
        t.rst_n=1;
        for(unsigned i=0;i<60;i++)cycle(t,warmup);

        // One complete reset period, asserted after a falling edge and released
        // after the next falling edge; the first instruction must see zero GPRs.
        t.clk=0;t.eval();t.rst_n=0;t.eval();t.clk=1;t.eval();
        t.clk=0;t.eval();t.rst_n=1;t.eval();
        const std::vector<uint32_t> program={0x00418533,0x00100073};
        const uint32_t instruction=fetch(t,program);
        t.clk=1;t.eval();t.i_data=instruction;t.eval();
        std::vector<uint8_t> bytes;
        for(uint32_t word:program)for(unsigned lane=0;lane<4;lane++)bytes.push_back(word>>(8*lane));
        Reference reference(bytes);
        for(unsigned i=0;i<256;i++) {
            cycle(t,program,&reference);
            if(t.halt_o) {
                if(t.cause_o!=3 || t.trap_pc_o!=4 || reference.instructions!=2)
                    throw std::runtime_error("incorrect reset restart");
                std::cout<<"PASS: one-period reset clears architectural GPRs across both clock phases\n";
                return 0;
            }
        }
        throw std::runtime_error("reset restart timed out");
    } catch(const std::exception& error) {
        std::cerr<<"FAIL: "<<error.what()<<'\n';return 1;
    }
}
