CC := gcc
ASM := nasm
GCCFLAGS := -nostartfiles -no-pie
NASMFLAGS := -f elf64

%.o : %.asm
	$(ASM) $(NASMFLAGS) $< -o $@

exo1: utils.o lazy.o
	$(CC) $(GCCFLAGS) $^ -o $@

exo2: utils.o registers.o
	$(CC) $(GCCFLAGS) $^ -o $@
exo3: utils.o exo3.o
	$(CC) $(GCCFLAGS) $^ -o $@
exo4: utils.o exo4.o
	$(CC) $(GCCFLAGS) $^ -o $@
exo5: utils.o tdc2_memory_access.o
	$(CC) $(GCCFLAGS) $^ -o $@
exo6: utils.o exo6.o
	$(CC) $(GCCFLAGS) $^ -o $@

.PHONY: clean
	
clean:
	rm -f *.o exec exo1 exo2 exo3 exo4 exo5 exo6