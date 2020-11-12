# 函数 max
    .text
    .global max
    .type   max,@function
max:
# exif(a>=b)
    movl    4(%esp),%eax
    cmpl    8(%esp),%eax
    jl      L2
# return a
    movl    4(%esp),%eax
    jmp     L3
L2:
# return b
    movl    8(%esp),%eax
L3:
    ret

# bss 段 存储全局变量
    .bss
# comm 声明未初始化的数据区域 
# zero 声明初始化的数据区域
# comm 用法
#   .comm a,4
#   .comm b,8
    .align  4 # 令数据地址按 4 对齐
a:
    .zero   4
    .align  4
b:
    .zero   4
# 开辟数组
    .align  4
c:
    .zero   8

# rodata段 存储常量
    .section    .rodata
STR0:
    .string "%d %d"
STR1:
    .string "max is: %d\n"

# 主函数
    .text 
    .globl  main 
    .type   main, @function 
main: 
# scanf("%d %d", &a, &b);
    pushl   $b # 从右向左压入参数 
    pushl   $a
    pushl   $STR0 
    call    scanf
    addl    $12,%esp # 不再需要参数
# printf("max is: %d\n", max(a, b)); 
    movl    b,%edx 
    movl    a,%eax
    pushl   %edx 
    pushl   %eax
    call    max 
    addl    $8,%esp
    pushl   %eax 
    pushl   $STR1
    call    printf
    addl    $8,%esp
# return 0; 
    movl    $0,%eax
    ret
# 可执行堆栈段 不清楚具体含义的话建议保留 
    .section    .note.GNU-stack,"",@progbits
    