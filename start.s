	.syntax unified
	.cpu cortex-m33
	.thumb

	.section .vectors, "a"
	.word 0x20080000  // Top of 512KB SRAM block (stack pointer)
	.word _start + 1  // Reset handler (Thumb bit set)

	// as defined in 5.9.5.1. Minimum Arm IMAGE_DEF
	.section .image_def, "a"
	.align 2
	.word 0xffffded3
	.word 0x10210142
	.word 0x000001ff
	.word 0x00000000
	.word 0xab123579

	.section .text
	.global _start
	.thumb_func
_start:
	bl init
	bl main
