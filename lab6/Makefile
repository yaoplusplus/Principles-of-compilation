CC := g++
CFLAGS := -w -Wextra -std=c++11 # without debug //-Wall 显示所有警告 -w 不显示警告 , ==null
TARGET := ./bin/main

all: run

src/main.lex.yy.c: src/main.lex
	 flex --noyywrap -o src/main.lex.yy.cpp  src/main.lex 

src/main.tab.c: src/main.y
	bison -o src/main.tab.cpp --defines=src/main.tab.h -v src/main.y 

src/pch.h.gch: src/pch.h
	g++ -x c++-header -o src/pch.h.gch -c src/pch.h

lex: src/main.lex.yy.c

yacc: src/main.tab.c

main: src/pch.h.gch
	$(CC) $(CFLAGS) $(shell ls ./src/*.cpp) -o ./bin/main

.PHONY: all clean main run lex yacc test debug link testscope asm nasm example-code out

run: lex yacc main

clean:
	rm -f src/*.output src/main.lex.yy.cpp src/main.tab.cpp src/main.tab.h src/main.output src/pch.h.gch $(TARGET) *.o ./bin/* 
	rm result.txt result1.txt result2.txt
test: 
	./bin/main tests/test.c > result.txt
test1:
	./bin/main tests/test1.c > result1.txt
test2:
	./bin/main tests/test2.c > result2.txt
