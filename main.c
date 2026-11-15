#include <stdint.h>

#define RESETS_RESET         (*(volatile uint32_t *)0x40020000)
#define RESETS_RESET_DONE    (*(volatile uint32_t *)0x40020008)
#define IO_BANK0_GPIO15_CTRL (*(volatile uint32_t *)0x4002807c)
#define PADS_BANK0_GPIO15    (*(volatile uint32_t *)0x40038040)
#define SIO_GPIO_OUT_XOR     (*(volatile uint32_t *)0xd0000028)
#define SIO_GPIO_OE_SET      (*(volatile uint32_t *)0xd0000038)

const float cycles_per_loop = 11.0; // retroactively applied after
                                    // inspecting the generated
                                    // assembly. Dumb as hell, I know.
const float target_time = 4.0; // 4 sec
const float freq = 12e6;  // 12 MHz
const uint32_t default_delay = (uint32_t)target_time * freq / cycles_per_loop;

int main(void) {

  RESETS_RESET &= ~(1 << 6);

  while ((RESETS_RESET_DONE & (1 << 6)) == 0) {
  }

  IO_BANK0_GPIO15_CTRL = 5;
  PADS_BANK0_GPIO15 &= ~(1 << 8);
  SIO_GPIO_OE_SET = (1 << 15);

  while (1) {
    SIO_GPIO_OUT_XOR = (1 << 15);

    for (uint32_t delay = default_delay; delay > 0; delay--) {
      __asm__ volatile ("nop");
    }
  }

  return 0;
}
