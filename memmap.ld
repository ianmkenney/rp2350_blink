MEMORY
{
	FLASH(rx) : ORIGIN = 0x10000000, LENGTH = 2048k
	RAM(rwx)  : ORIGIN = 0x20000000, LENGTH = 512k
}

SECTIONS
{
	.text : {
	      KEEP(*(.vectors))
	      KEEP(*(.image_def))
	      *(.text*)
	} > FLASH
}
