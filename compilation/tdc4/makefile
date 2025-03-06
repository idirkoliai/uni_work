CC := gcc
ASM := nasm
GCCFLAGS := -nostartfiles -no-pie
NASMFLAGS := -f elf64

%.o: %.asm
	$(ASM) $(NASMFLAGS) $< -o $@

%:  %.o utils.o square.o
	$(CC) $(GCCFLAGS) $^ -o $@

.PHONY: clean

clean:
	rm -f *.o exo01 exo02 exo03