.PHONY: all upload clean

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m33 -mthumb -ffreestanding -O2 -Wall -Wextra


all: blink.uf2

upload: blink.uf2
	cp blink.uf2 /run/media/$(USER)/RP2350/

clean:
	-rm start.o blink.elf blink.bin blink.uf2 main.o

start.o: start.s
	$(AS) -mcpu=cortex-m33 -mthumb start.s -o start.o

rp2350.o: rp2350.c rp2350.h
	$(CC) $(CFLAGS) -c rp2350.c -o rp2350.o

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

blink.elf: start.o main.o memmap.ld rp2350.o
	$(LD) -T memmap.ld start.o main.o rp2350.o -o blink.elf

blink.bin: blink.elf
	$(OBJCOPY) -O binary blink.elf blink.bin

blink.uf2: blink.bin convert.py
	python3 convert.py
