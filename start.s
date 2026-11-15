	.syntax unified
	.cpu cortex-m33
	.thumb

	.section .vectors, "a"
	.word 0x20080000  // Top of 512KB SRAM block (stack pointer)
	.word _start + 1  // Reset handler (Thumb bit set)

	.section .image_def, "a"
	.align 2
	.word 0xffffded3  // PICOBIN_BLOCK_MARKER_START
	.word 0x10210142  // Image type: Arm Secure EXE
	.word 0x000001ff  // Item size / end
	.word 0x00000000  // Loop link
	.word 0xab123579  // PICOBIN_BLOCK_MARKER_END

	.section .text
	.global _start
	.thumb_func
_start:
	bl main
