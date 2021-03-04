
	.bss

	.text
	.section	.rodata
STR0:
	.string "sahdfiashdi"
STR1:
	.string "hh %s"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	$STR0
	subl	$4, %ebp
	pushl	$STR1
	call	printf
	addl	$4, %ebp
	addl	$8, %esp
	popl	%ebp
	movl	$0, %eax
	ret
	.section	.note.GNU-stack,"",@progbits

# 0	program					child: 1
# 1	function				child: 2 3 4 9
# 2	type		INTEGER		child:
# 3	variable	main			child:
# 4	statement	DECL		child: 5 6
# 5	type		STRING		child:
# 6	assign					child: 7 8
# 7	variable	a			child:
# 8	conststr	sahdfiashdi			child:
# 9	statement	PRINTF		child: 10 11
# 10	conststr	hh %s			child:
# 11	variable	a			child:
