.PHONY:eg1,eg2,test,all,clean,clean-all 
test:
	gcc main.s -m32 -o main.out 
	qemu-i386 main.out
all:$(subst .c,.s,$(wildcard *.c))
%.s:%.c 
	gcc $< -m32 -std=c99 -S -o $@ -O0 -fno-asynchronous-unwind-tables -fno-builtin-fno-common -fno-ident -finhibit-size-directive -fno-pie -march=i386
clean-all:$(subst .c,-del,$(wildcard *.c)) clean 
clean: 
	rm -fr main.out
%-del:%.c
	rm -fr $(basename $<).s
armtest:	
	arm-linux-gnueabi-gcc example.S -o example 
	qemu-arm ./example

comp0:
	gcc -E comp.c -o comp.i 
	gcc -S comp.i -o comp.s
	rm comp.i
comp1:
	gcc comp.s -m32 -o comp.out
	qemu-i386 comp.out
comp2:
	rm comp.out
	rm comp.s