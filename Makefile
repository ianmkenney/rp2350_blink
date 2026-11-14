.PHONY: all upload clean

all: blink.uf2

upload: blink.uf2
	cp blink.uf2 /run/media/$(USER)/RP2350/

clean:
	-rm blink.o blink.elf blink.bin blink.uf2

blink.o: blink.s
	arm-none-eabi-as -mcpu=cortex-m33 -mthumb blink.s -o blink.o

blink.elf: blink.o memmap.ld
	arm-none-eabi-ld -T memmap.ld blink.o -o blink.elf

blink.bin: blink.elf
	arm-none-eabi-objcopy -O binary blink.elf blink.bin

blink.uf2: blink.bin convert.py
	python3 convert.py
