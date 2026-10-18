/* RV32I division helpers. All intermediate arithmetic is unsigned, including
 * INT_MIN / -1; division by zero follows the RISC-V DIV/REM result values. */
#include <stdint.h>

static uint32_t divide(uint32_t dividend, uint32_t divisor, uint32_t *remainder)
{
    uint32_t quotient = 0, bit = 1;
    if (!divisor) {
        *remainder = dividend;
        return UINT32_MAX;
    }
    while (!(divisor & UINT32_C(0x80000000)) && divisor < dividend) {
        divisor <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (dividend >= divisor) {
            dividend -= divisor;
            quotient |= bit;
        }
        divisor >>= 1;
        bit >>= 1;
    }
    *remainder = dividend;
    return quotient;
}

uint32_t __udivsi3(uint32_t a, uint32_t b)
{
    uint32_t remainder;
    return divide(a, b, &remainder);
}

uint32_t __umodsi3(uint32_t a, uint32_t b)
{
    uint32_t remainder;
    divide(a, b, &remainder);
    return remainder;
}

int32_t __divsi3(int32_t a, int32_t b)
{
    if (!b) return -1;
    uint32_t ua = (uint32_t)a, ub = (uint32_t)b, remainder;
    uint32_t quotient = divide(a < 0 ? -ua : ua, b < 0 ? -ub : ub, &remainder);
    return (int32_t)(((a < 0) != (b < 0)) ? -quotient : quotient);
}

int32_t __modsi3(int32_t a, int32_t b)
{
    uint32_t ua = (uint32_t)a, ub = (uint32_t)b, remainder;
    divide(a < 0 ? -ua : ua, b < 0 ? -ub : ub, &remainder);
    return (int32_t)(a < 0 ? -remainder : remainder);
}
