CC=gcc
LEX=flex
YACC=bison
CFLAGS=-c -Wall -Wextra -g
LDFLAGS=-Wall -Wextra -g -ll -ly
SRC = src/
INC = include/
OBJ = obj/
BIN = bin/
EXEC=$(BIN)mysh

$(EXEC): $(OBJ)main.o $(OBJ)lexer.o $(OBJ)parser.o $(OBJ)joblist.o | $(OBJ)  $(BIN)
	$(CC) -o $@ $^ $(LDFLAGS)

$(OBJ)main.o: $(SRC)main.c $(OBJ)lexer.h $(OBJ)parser.h $(INC)joblist.h | $(OBJ) 
	$(CC) -o $@ $< $(CFLAGS)

$(OBJ)lexer.o: $(OBJ)lexer.c $(INC)joblist.h $(OBJ)parser.h $(INC)try.h | $(OBJ) 
	$(CC) -o $@ $< $(CFLAGS)

$(OBJ)parser.o: $(OBJ)parser.c $(INC)joblist.h | $(OBJ) 
	$(CC) -o $@ $< $(CFLAGS)

$(OBJ)joblist.o: $(SRC)joblist.c $(INC)joblist.h $(OBJ)parser.h $(INC)try.h | $(OBJ) 
	$(CC) -o $@ $< $(CFLAGS)

$(OBJ)lexer.c: $(SRC)lexer.l | $(OBJ) 
	$(LEX) -o $@ $<

$(OBJ)lexer.h: $(SRC)lexer.l | $(OBJ) 
	$(LEX) -o $(OBJ)lexer.c $<

$(OBJ)parser.c $(OBJ)parser.h: $(SRC)parser.y | $(OBJ) 
	$(YACC) -d -o $(OBJ)parser.c $<

$(OBJ):
	mkdir -p $(OBJ)
$(BIN):
	mkdir -p $(BIN)

.PHONY: clean mrproper test

clean:
	rm -rf $(OBJ)

mrproper: clean
	rm -rf $(BIN)

test: $(EXEC)
	@chmod u+x test
	./test ./mysh
