/* Bare-metal RV32IM CoreMark port. No benchmark algorithm is modified.
 * Seeds and iteration count come from read-only simulator configuration.
 * The timer counts microseconds of target time, independently of host speed.
 */
#include "coremark.h"

#define CONFIG_WORD(i) (*(volatile ee_u32 *)(0xFFFFFFD0u + 4u * (i)))
#define MMIO_TIMER     (*(volatile ee_u32 *)0xFFFFFFF8u)
#define MMIO_UART_TX   (*(volatile ee_u8 *)0xFFFFFFFCu)
#define EE_TICKS_PER_SEC 1000000u

ee_s32 portme_sys1(void) { return (ee_s32)CONFIG_WORD(0); }
ee_s32 portme_sys2(void) { return (ee_s32)CONFIG_WORD(1); }
ee_s32 portme_sys3(void) { return (ee_s32)CONFIG_WORD(2); }
ee_s32 portme_sys4(void) { return (ee_s32)CONFIG_WORD(3); }
ee_s32 portme_sys5(void) { return 0; } /* All three algorithms. */

static CORETIMETYPE start_time_val, stop_time_val;

void start_time(void) { start_time_val = MMIO_TIMER; }
void stop_time(void) { stop_time_val = MMIO_TIMER; }
CORE_TICKS get_time(void) { return stop_time_val - start_time_val; }
secs_ret time_in_secs(CORE_TICKS ticks) { return ticks / EE_TICKS_PER_SEC; }

ee_u32 default_num_contexts = 1;

void portable_init(core_portable *p, int *argc, char *argv[])
{
    (void)argc;
    (void)argv;
    if (sizeof(ee_ptr_int) != sizeof(ee_u8 *))
        ee_printf("ERROR! ee_ptr_int size mismatch.\n");
    if (sizeof(ee_u32) != 4)
        ee_printf("ERROR! ee_u32 size mismatch.\n");
    p->portable_id = 1;
}

void portable_fini(core_portable *p) { p->portable_id = 0; }
void uart_send_char(char c) { MMIO_UART_TX = (ee_u8)c; }
