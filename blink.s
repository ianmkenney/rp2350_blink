	.syntax unified
	.cpu cortex-m33
	.thumb

	.section .vectors, "a"
	.word 0x20080000  // stack pointer
	.word _start + 1  // first instruction

	.section .image_def, "a"  // See 5.9.5.1 Minimum Arm IMAGE_DEF RP2350 datasheet
	.align 2  // the below magic number must appear on a 4 byte boundary, could possibly be missed if misaligned
	.word 0xffffded3 // magic header PICOBIN_BLOCK_MARKER_START
	.word 0x10210142 // pulled from example in datasheet
	.word 0x000001ff // pulled from example in datasheet
	.word 0x00000000 // loop
	.word 0xab123579 // magic footer PICOBIN_BLOCK_MARKER_END

	.section .text
	.global _start
	.thumb_func
_start:
	// Deassert reset
	LDR r0, =0x40020000 // load address of controller register from memory
	LDR r1, [r0]
	BIC r1, #(1 << 6) // flip bit 6
	STR r1, [r0]

wait_reset:
	LDR r1, [r0, #0x8] // load RESET_DONE register
	TST r1, #(1 << 6)  // check if IO_BANK0 is reset
	BEQ wait_reset  // if not, goto wait_reset

	// Set GPIO 15 function to SIO
	ldr r0, =0x40028000 // user bank io registers
	movs r1, #5
	str r1, [r0, #0x7c] // user bank gpio 15 ctrl offset

	// Clear pad isolation on GPIO 15
	ldr r0, =0x40038000  // pad registers
	ldr r1, [r0, #0x40]  // gpio 15 pad offset
	bic r1, r1, #(1 << 8) // close the pad connection
	str r1, [r0, #0x40] // store

	// Enable GPIO 15 output
	ldr r0, =0xd0000000 // SIO registers
	movs r1, #(1 << 15) // set bit 15 to 1
	str r1, [r0, #0x38] // set in memory

loop:
	str r1, [r0, #0x28] // GPIO_OUT_XOR, flip bit 1 << 15, i.e. turn on or off
	ldr r2, =9000000 // Roughly 3 sec
delay:
	subs r2, #1 // subtract 1, and compare to zero
	bne delay  // if not zero goto delay
	b loop // goto loop
