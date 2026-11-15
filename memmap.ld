MEMORY
{
	FLASH(rx) : ORIGIN = 0x10000000, LENGTH = 2048k
}

SECTIONS
{
	.text : {
	      KEEP(*(.vectors))
	      KEEP(*(.image_def))
	      *(.text*)
	      *(.rodata*)
	} > FLASH
}
