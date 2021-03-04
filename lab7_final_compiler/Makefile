.PHONY: all clean main run git testall debug t0 m0 t1 m1 t2 m2 t3 m3
all: run
main.tab.cc: main.y
	bison -o main.tab.cc -v main.y
lex.yy.cc: main.lex
	flex -o lex.yy.cc main.lex
main:
	g++ $(shell ls *.cpp *.cc) -o main.out
run: lex.yy.cc main.tab.cc main
clean:
	rm -f *.output *.yy.* *.tab.* *.out test/*.res
test:run
	./main.out <test/test.c >test/test.res
	./main.out <test/test.c >test/test.s
	rm -f *.output *.yy.* *.tab.*
m:
	gcc test/test.s -m32 -o test/test.out
	qemu-i386 test/test.out <test/testin >test/ASM0.res
	rm -f test/*.out test/*.s
