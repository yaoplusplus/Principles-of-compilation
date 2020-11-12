.PHONY:lc,lcc,clean
lc:
	flex sysy.l
	gcc lex.yy.c -o lc.out
	./lc.out <testin >testout
lcc:
	flex -+ sysycc.l
	g++ lex.yy.cc -o lcc.out
	./lcc.out <testin >testout
clean:
	rm lcc.out lex.yy.cc