#ifndef RP2350_H
#define RP2350_H

#include <stdint.h>

#define RESETS_RESET         (*(volatile uint32_t *)0x40020000)
#define RESETS_RESET_DONE    (*(volatile uint32_t *)0x40020008)
#define IO_BANK0_GPIO15_CTRL (*(volatile uint32_t *)0x4002807c)
#define PADS_BANK0_GPIO15    (*(volatile uint32_t *)0x40038040)
#define SIO_GPIO_OUT_XOR     (*(volatile uint32_t *)0xd0000028)
#define SIO_GPIO_OE_SET      (*(volatile uint32_t *)0xd0000038)

void init(void);
void pin_toggle(int);
void set_pin_15();

#endif // RP2350_H
