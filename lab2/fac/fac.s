    .section    .data
    .bss
    .align 4
i:
    .zero 4

    .align 4
n:
    .zero 4

    .align 4
f:
    .zero 4

    .section    .rodata
STR0:
    .string "%d"
STR1:
    .string "result is: %d\n"

    .text
    .globl main
    .type main,@function
main:
    pushl   $n
    pushl   $STR0
    call    scanf
    movl    $1,f
    movl    $2,i
    addl    $8,%esp
    jmp	    L2
L1:
    movl	f, %eax
    movl    i, %ebx
	imull	%ebx, %eax
	movl	%eax, f
    addl	$1, i
    jmp     L2
L2:
    movl    n, %eax
    addl    $1,%eax
    movl    i, %ebx
	cmpl	%eax, %ebx
    jl	    L1

L3:
    pushl	f
    pushl   $STR1
    call    printf
    addl    $8,%esp
    movl    $0,%eax
    ret
    .section    .note.GNU-stack,"",@progbits