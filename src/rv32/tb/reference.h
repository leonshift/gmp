#pragma once
#include <array>
#include <cstdint>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <vector>

static uint32_t sx(uint32_t x, unsigned n) { return uint32_t(int32_t(x << (32-n)) >> (32-n)); }

struct Reference {
    std::array<uint32_t, 32> r{};
    std::vector<uint8_t> mem;
    uint32_t pc = 0;
    uint32_t seed[4]{};
    uint64_t instructions = 0;
    explicit Reference(const std::vector<uint8_t>& image): mem(131072) {
        std::copy(image.begin(), image.end(), mem.begin());
    }
    uint32_t word(uint32_t a, unsigned n) {
        if (uint64_t(a) + n > mem.size()) throw std::runtime_error("reference memory range");
        uint32_t v=0;
        for(unsigned i=0;i<n;i++) v |= uint32_t(mem[a+i]) << (8*i);
        return v;
    }
    template<class Top> void step(Top& t) {
        if (!t.trace_valid) return;
        const uint32_t ins=t.trace_inst, op=ins&127, rd=(ins>>7)&31, f=(ins>>12)&7;
        const uint32_t a=r[(ins>>15)&31], b=r[(ins>>20)&31], f7=ins>>25;
        uint32_t next=pc+4, value=0, addr=0, data=0, mask=0;
        bool writes=false, store=false, trap=false;
        if (pc != t.trace_pc || word(pc,4) != ins) fail(t,"PC/instruction");
        switch(op) {
        case 0x37: value=ins&0xfffff000; writes=true; break;
        case 0x17: value=pc+(ins&0xfffff000); writes=true; break;
        case 0x6f:
            value=pc+4; writes=true;
            next=pc+sx(((ins>>31)<<20)|(((ins>>12)&255)<<12)|(((ins>>20)&1)<<11)|(((ins>>21)&1023)<<1),21);
            break;
        case 0x67: value=pc+4; writes=true; next=(a+sx(ins>>20,12))&~1u; break;
        case 0x63: {
            uint32_t imm=sx(((ins>>31)<<12)|(((ins>>7)&1)<<11)|(((ins>>25)&63)<<5)|(((ins>>8)&15)<<1),13);
            bool take=false;
            switch(f) {case 0:take=a==b;break;case 1:take=a!=b;break;case 4:take=int32_t(a)<int32_t(b);break;
            case 5:take=int32_t(a)>=int32_t(b);break;case 6:take=a<b;break;case 7:take=a>=b;break;}
            if(take) next=pc+imm;
            break;
        }
        case 0x13: case 0x33: {
            writes=true;
            uint32_t z=op==0x13?sx(ins>>20,12):b;
            if(op==0x33 && f7==1) {
                switch(f) {
                case 0:value=uint32_t(uint64_t(a)*b);break;
                case 1:value=uint32_t((int64_t(int32_t(a))*int64_t(int32_t(b)))>>32);break;
                case 2:value=uint32_t((int64_t(int32_t(a))*int64_t(uint64_t(b)))>>32);break;
                case 3:value=uint32_t((uint64_t(a)*b)>>32);break;
                default:trap=true;writes=false;break;
                }
            } else switch(f) {
                case 0:value=(op==0x33&&f7==0x20)?a-z:a+z;break;
                case 1:value=a<<(z&31);break;
                case 2:value=int32_t(a)<int32_t(z);break;
                case 3:value=a<z;break;
                case 4:value=a^z;break;
                case 5:value=(ins&(1u<<30))?uint32_t(int32_t(a)>>(z&31)):a>>(z&31);break;
                case 6:value=a|z;break;case 7:value=a&z;break;
            }
            break;
        }
        case 3: {
            writes=true; addr=a+sx(ins>>20,12); unsigned n=1u<<(f&3);
            if(addr>=0xffffffd0 && addr<=0xffffffdc) value=seed[(addr-0xffffffd0)/4];
            else if(addr==0xfffffff8) value=t.trace_data; // 时间由另一条快照检查链独立验证。
            else value=word(addr,n);
            if(f==0) value=sx(value,8); if(f==1) value=sx(value,16);
            break;
        }
        case 0x23: {
            store=true; addr=a+sx(((ins>>25)<<5)|((ins>>7)&31),12);
            unsigned n=1u<<f; mask=((1u<<n)-1)<<(addr&3); data=b<<((addr&3)*8);
            if(addr!=0xfffffffc) {
                if(uint64_t(addr)+n>mem.size()) fail(t,"store range");
                for(unsigned i=0;i<n;i++) mem[addr+i]=uint8_t(b>>(8*i));
            }
            break;
        }
        case 0x0f: break;
        case 0x73: trap=true; break;
        default: fail(t,"unsupported reference instruction");
        }
        if(bool(t.trace_trap)!=trap) fail(t,"trap");
        const uint32_t expected_rd=writes&&rd?rd:0;
        if(t.trace_rd!=expected_rd || (expected_rd && value!=t.trace_data)) {
            std::cerr<<"expected x"<<expected_rd<<"=0x"<<std::hex<<value<<" got x"<<unsigned(t.trace_rd)<<"=0x"<<t.trace_data<<"\n";
            fail(t,"register write");
        }
        if(bool(t.trace_store)!=store || (store&&(addr!=t.trace_addr || data!=t.trace_wdata || mask!=t.trace_mask))) fail(t,"store");
        if(expected_rd) r[rd]=value;
        r[0]=0; pc=next; ++instructions;
    }
    template<class Top> [[noreturn]] void fail(Top& t,const char* why) {
        std::ostringstream s; s<<why<<" after "<<instructions<<" instructions, pc=0x"<<std::hex<<pc<<" RTL=0x"<<t.trace_pc<<" inst=0x"<<t.trace_inst;
        throw std::runtime_error(s.str());
    }
};

