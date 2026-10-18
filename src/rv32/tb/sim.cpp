#include "VRv32Soc.h"
#include "verilated.h"
#include <array>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
#ifndef RV32_PREDICT
#define RV32_PREDICT 2
#define RV32_TRACE 1
#endif
#ifndef RV32_BP_ENTRIES
#define RV32_BP_ENTRIES 8
#endif

static constexpr uint32_t BASE = 0x20000000;
#include "reference.h"


struct Sim {
    VRv32Soc t;
    uint64_t clocks=0;
    Reference* reference=nullptr;
    void tick() {
        t.clk=0;t.eval();
        if(reference) reference->step(t);
        t.clk=1;t.eval(); ++clocks;
    }
    Sim() {
        t.rst_n=0; t.h_valid=0;t.h_rready=0;
        for(int i=0;i<4;i++)tick();
        t.rst_n=1;tick();
    }
    uint32_t transaction(uint32_t addr,bool write,uint32_t data=0,uint32_t strobe=15) {
        t.h_addr=addr;t.h_write=write;t.h_data=data;t.h_strb=strobe;t.h_valid=1;t.h_rready=0;
        t.clk=0;t.eval();
        for(unsigned i=0;!t.h_ready;i++) {if(i>10000)throw std::runtime_error("host ready timeout");tick();}
        tick(); t.h_valid=0; t.clk=0;t.eval();
        for(unsigned i=0;!t.h_rvalid;i++) {if(i>10000)throw std::runtime_error("host response timeout");tick();}
        uint32_t result=t.h_rdata;
        if(t.h_error) throw std::runtime_error("host bus error");
        if(!write && addr<131072) {
            for(unsigned held=0;held<9;held++) {
                tick();
                if(!t.h_rvalid || t.h_error || t.h_rdata!=result)
                    throw std::runtime_error("host SRAM response changed under backpressure");
            }
        }
        t.h_rready=1;tick();t.h_rready=0;
        return result;
    }
    uint32_t read(uint32_t a) {return transaction(BASE+a,false);}
    void write(uint32_t a,uint32_t d) {transaction(BASE+a,true,d);}
    void drain(std::string& output) {
        const uint32_t n=read(0x18);
        for(uint32_t i=0;i<n;i++) {
            uint32_t x=read(0x14);
            if(!(x&256)) throw std::runtime_error("UART underflow");
            output.push_back(char(x));
        }
    }
};

static std::string json_string(const std::string& s) {
    std::ostringstream o; o<<'"';
    for(unsigned char c:s) {
        if(c=='"'||c=='\\')o<<'\\'<<c;
        else if(c=='\n')o<<"\\n";else if(c=='\r')o<<"\\r";else if(c=='\t')o<<"\\t";
        else if(c<32)o<<"\\u"<<std::hex<<std::setw(4)<<std::setfill('0')<<unsigned(c);
        else o<<c;
    } o<<'"'; return o.str();
}

int main(int argc,char** argv) {
    Verilated::commandArgs(argc,argv);
    try {
        std::string image,output;uint32_t iterations=1;uint64_t limit=1000000000;
        bool validation=false,check=false,host_byte_write=false;unsigned expected_cause=3;
        std::vector<std::array<uint32_t,3>> host_patches;
        uint32_t expected_pc=~0u, expected_tval=~0u;
        std::vector<std::pair<uint32_t,uint32_t>> expected_words;
        for(int i=1;i<argc;i++) {
            std::string a=argv[i];
            if(a=="--image")image=argv[++i];else if(a=="--output")output=argv[++i];
            else if(a=="--iterations")iterations=std::stoul(argv[++i]);
            else if(a=="--max-cycles")limit=std::stoull(argv[++i]);
            else if(a=="--host-byte-write")host_byte_write=true;
            else if(a=="--host-patch") {
                std::array<uint32_t,3> patch;
                for(auto& value:patch)value=std::stoul(argv[++i],nullptr,0);
                host_patches.push_back(patch);
            }
            else if(a=="--validation")validation=true;else if(a=="--check")check=true;
            else if(a=="--expect-cause")expected_cause=std::stoul(argv[++i],nullptr,0);
            else if(a=="--expect-pc")expected_pc=std::stoul(argv[++i],nullptr,0);
            else if(a=="--expect-tval")expected_tval=std::stoul(argv[++i],nullptr,0);
            else if(a=="--expect-word") {
                uint32_t address=std::stoul(argv[++i],nullptr,0),value=std::stoul(argv[++i],nullptr,0);
                expected_words.emplace_back(address,value);
            }
            else throw std::runtime_error("unknown option: "+a);
        }
        std::ifstream f(image,std::ios::binary);
        if(!f)throw std::runtime_error("image not found: "+image);
        std::vector<uint8_t> bytes{std::istreambuf_iterator<char>(f),{}};
        if(bytes.size()>131072)throw std::runtime_error("image exceeds SRAM");
        Reference ref(bytes);Sim sim;
        if(sim.read(0)!=0x52563332)throw std::runtime_error("wrong system ID");
        for(uint32_t i=0;i<bytes.size();i+=4) {
            uint32_t w=0;for(unsigned j=0;j<4 && i+j<bytes.size();j++)w|=uint32_t(bytes[i+j])<<(8*j);
            sim.transaction(i,true,w);
        }
        if(host_byte_write) {
            for(uint32_t i=0;i<bytes.size();i++) {
                const unsigned lane=i&3;
                sim.transaction(i&~3u,true,uint32_t(bytes[i])<<(8*lane),1u<<lane);
            }
        }
        for(auto [address,data,strobe]:host_patches) {
            if((address&3) || uint64_t(address)+4>ref.mem.size() || strobe>15)
                throw std::runtime_error("invalid host patch");
            sim.transaction(address,true,data,strobe);
            for(unsigned lane=0;lane<4;lane++)if(strobe&(1u<<lane))
                ref.mem[address+lane]=uint8_t(data>>(lane*8));
        }
        ref.seed[0]=ref.seed[1]=validation?0x3415:0;ref.seed[2]=0x66;ref.seed[3]=iterations;
        for(unsigned i=0;i<4;i++)sim.write(0x30+4*i,ref.seed[i]);
        if(check)sim.reference=&ref;
        sim.write(4,1);
        uint64_t begin=sim.clocks;std::string uart;
        while(!sim.t.halt_o) {
            sim.tick();
            if(sim.clocks-begin>limit)throw std::runtime_error("CPU timeout");
            if((sim.clocks&8191)==0)sim.drain(uart);
            if((sim.clocks-begin)%200000000==0)std::cerr<<"Progress: "<<(sim.clocks-begin)<<" CPU cycles\n";
        }
        sim.drain(uart);
        std::cout<<uart;
        const unsigned cause=sim.t.cause_o;
        if(cause!=expected_cause) {
            std::ostringstream msg;msg<<"CPU exception "<<cause<<" pc=0x"<<std::hex<<sim.read(0x10)<<" tval=0x"<<sim.read(0x48);
            throw std::runtime_error(msg.str());
        }
        if(expected_pc!=~0u && sim.read(0x10)!=expected_pc) throw std::runtime_error("wrong trap PC");
        if(expected_tval!=~0u && sim.read(0x48)!=expected_tval) throw std::runtime_error("wrong trap value");
        const uint64_t cycles=sim.read(0x1c)|(uint64_t(sim.read(0x20))<<32);
        const uint64_t retired=sim.read(0x24)|(uint64_t(sim.read(0x28))<<32);
        std::ostringstream result;
        result<<"{\"backend\":\"verilator\",\"predict\":"<<RV32_PREDICT<<",\"trace\":"<<RV32_TRACE
              <<",\"bp_entries\":"<<RV32_BP_ENTRIES<<",\"pipeline_stages\":4"
              <<",\"halted\":true,\"cause\":"<<cause<<",\"cycles\":"<<cycles
              <<",\"retired\":"<<retired<<",\"invalid_accesses\":"<<sim.read(0x2c)
              <<",\"timer_overflow\":"<<sim.read(0x44)<<",\"load_stalls\":"<<sim.read(0x50)
              <<",\"muldiv_stalls\":"<<sim.read(0x54)<<",\"redirects\":"<<sim.read(0x58)<<",\"timer\":[";
        const unsigned n=sim.read(0x40);
        for(unsigned i=0;i<n;i++) {
            uint64_t c=sim.read(0x100+16*i)|(uint64_t(sim.read(0x104+16*i))<<32);
            uint32_t ticks=sim.read(0x108+16*i);
            if(i)result<<',';result<<"{\"cycles\":"<<c<<",\"ticks\":"<<ticks<<'}';
        }
        result<<"],\"uart\":"<<json_string(uart)<<"}\n";
        if(!output.empty()){std::ofstream out(output);out<<result.str();if(!out)throw std::runtime_error("result write failed");}
        std::cout<<"PASS: "<<cycles<<" cycles, "<<retired<<" retired, reference="<<ref.instructions<<"\n";
        if(check && !ref.instructions)throw std::runtime_error("reference check requested but trace is disabled");
        if(!expected_words.empty()) {
            sim.reference=nullptr;sim.write(4,0);
            for(auto [address,value]:expected_words) if(sim.transaction(address,false)!=value) throw std::runtime_error("unexpected memory side effect");
        }
        return 0;
    } catch(const std::exception& e) {std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}
}
