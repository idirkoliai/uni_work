CC := gcc
ASM := nasm
GCCFLAGS := -nostartfiles -no-pie
NASMFLAGS := -f elf64

%.o: %.asm
	$(ASM) $(NASMFLAGS) $< -o $@

%:  %.o utils.o
	$(CC) $(GCCFLAGS) $^ -o $@

.PHONY: clean

clean:
	rm -f *.o little_endian exo2.1 fibonacci fact premier