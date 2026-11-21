#include <stdint.h>
#include "rp2350.h"

// TODO: Use AON timer
const float cycles_per_loop = 11.0; // retroactively applied after
                                    // inspecting the generated
                                    // assembly. Dumb as hell, I know.
const float target_time = 4.0; // 4 sec
const float freq = 12e6;  // 12 MHz
const uint32_t default_delay = (uint32_t)target_time * freq / cycles_per_loop;

int main(void) {
  set_pin(15);
  set_pin(14);

  while (1) {
    pin_toggle(15);
    pin_toggle(14);

    for (uint32_t delay = default_delay; delay > 0; delay--) {
      __asm__ volatile ("nop");
    }
  }

  return 0;
}
