#include "rp2350.h"

void init(void) {
  RESETS_RESET &= ~(1 << 6);
  // wait for reset to complete
  while ((RESETS_RESET_DONE & (1 << 6)) == 0) {
  }
}

void set_pin_15() {
  int pin_no = 15;

  IO_BANK0_GPIO15_CTRL = 5;
  PADS_BANK0_GPIO15 &= ~(1 << 8);
  SIO_GPIO_OE_SET = (1 << pin_no);
}

void pin_toggle(int pin_no) {
    SIO_GPIO_OUT_XOR = (1 << pin_no);
}
