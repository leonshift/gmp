/* softmul.c — minimal libgcc-equivalent for RV32I targets that don't
 * have a matching libgcc.a multilib (Ubuntu's gcc-riscv64-linux-gnu
 * ships rv64gc libgcc only, so linking -lgcc here fails).
 *
 * We implement the symbols GCC's codegen calls when it lowers `a*b`,
 * `a/b`, `a%b` on 32-bit ints with -march=rv32i. CoreMark's matrix
 * kernel needs __mulsi3; the rest are included pre-emptively because
 * pinpointing exactly which CoreMark path needs which is brittle.
 *
 * These are NOT performance-tuned — `__mulsi3` is the standard
 * shift-add loop, `__udivsi3` / `__umodsi3` share the long-division
 * loop. CoreMark on this CPU runs ~50× slower than with HW MUL, which
 * matches what real RV32I-without-M cores look like and is exactly
 * what we want measured.
 */

typedef unsigned int  u32;
typedef int           i32;

u32 __mulsi3(u32 a, u32 b)
{
    u32 r = 0;
    while (a) {
        if (a & 1u) r += b;
        a >>= 1;
        b <<= 1;
    }
    return r;
}

/* Single function returning both quotient and remainder via *rem. */
static u32 udivmod32(u32 a, u32 b, u32 *rem)
{
    u32 q = 0, r = 0;
    int i;
    if (b == 0) { if (rem) *rem = a; return 0xFFFFFFFFu; }
    for (i = 31; i >= 0; i--) {
        r = (r << 1) | ((a >> i) & 1u);
        if (r >= b) { r -= b; q |= (1u << i); }
    }
    if (rem) *rem = r;
    return q;
}

u32 __udivsi3(u32 a, u32 b) { return udivmod32(a, b, 0); }
u32 __umodsi3(u32 a, u32 b) { u32 r; udivmod32(a, b, &r); return r; }

i32 __divsi3(i32 a, i32 b)
{
    int neg = 0;
    u32 ua, ub, q;
    if (a < 0) { ua = (u32)-a; neg ^= 1; } else ua = (u32)a;
    if (b < 0) { ub = (u32)-b; neg ^= 1; } else ub = (u32)b;
    q = udivmod32(ua, ub, 0);
    return neg ? -(i32)q : (i32)q;
}

i32 __modsi3(i32 a, i32 b)
{
    int neg_a = a < 0;
    u32 ua, ub, r;
    ua = neg_a ? (u32)-a : (u32)a;
    ub = b < 0 ? (u32)-b : (u32)b;
    udivmod32(ua, ub, &r);
    return neg_a ? -(i32)r : (i32)r;
}

/* Some CoreMark paths sneak in long-long divides via printf %lld or
 * the validation harness. Provide the bare minimum 64-bit divide too
 * — slow ripple loop, but only invoked off the hot path. */
typedef unsigned long long u64;
typedef long long          i64;

static u64 udivmod64(u64 a, u64 b, u64 *rem)
{
    u64 q = 0, r = 0;
    int i;
    if (b == 0) { if (rem) *rem = a; return ~(u64)0; }
    for (i = 63; i >= 0; i--) {
        r = (r << 1) | ((a >> i) & 1ULL);
        if (r >= b) { r -= b; q |= (1ULL << i); }
    }
    if (rem) *rem = r;
    return q;
}

u64 __udivdi3(u64 a, u64 b) { return udivmod64(a, b, 0); }
u64 __umoddi3(u64 a, u64 b) { u64 r; udivmod64(a, b, &r); return r; }
i64 __divdi3(i64 a, i64 b)
{
    int neg = 0;
    u64 ua = a < 0 ? (u64)-a : (u64)a;
    u64 ub = b < 0 ? (u64)-b : (u64)b;
    u64 q;
    if (a < 0) neg ^= 1;
    if (b < 0) neg ^= 1;
    q = udivmod64(ua, ub, 0);
    return neg ? -(i64)q : (i64)q;
}
i64 __moddi3(i64 a, i64 b)
{
    int neg_a = a < 0;
    u64 ua = neg_a ? (u64)-a : (u64)a;
    u64 ub = b < 0 ? (u64)-b : (u64)b;
    u64 r;
    udivmod64(ua, ub, &r);
    return neg_a ? -(i64)r : (i64)r;
}

u64 __muldi3(u64 a, u64 b)
{
    u64 r = 0;
    while (a) { if (a & 1ULL) r += b; a >>= 1; b <<= 1; }
    return r;
}
