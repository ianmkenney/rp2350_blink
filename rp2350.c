#include <stdint.h>
#include "rp2350.h"

void init(void) {
  RESETS_RESET &= ~(1 << 6);
  // wait for reset to complete
  while ((RESETS_RESET_DONE & (1 << 6)) == 0) {
  }
}

void set_pin(uint32_t pin_no) {
  volatile uint32_t* pin_base_ctrl = &IO_BANK0_BASE + 2 * pin_no + 1;
  volatile uint32_t* pin_pad = &PADS_BANK0_BASE + (pin_no+1);

  *pin_base_ctrl = 5;
  *pin_pad &= ~(1 << 8);
  SIO_GPIO_OE_SET = (1 << pin_no);
}

void pin_toggle(uint32_t pin_no) {
    SIO_GPIO_OUT_XOR = (1 << pin_no);
}
