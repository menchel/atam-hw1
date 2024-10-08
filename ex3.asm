.global _start

.section .text
_start:

/*
there is a limit to how deep the tree can be, so:
%rdx first degree
%r8 second degree
%r9 third degree
%r10 fourth degree
%r11 fifth degree
%r12 sixth degree
%r13 seventh degree
*/
    movb $0, rich(%rip)
    movq $0, %rdi   # number of vertices
    movq $0, %rsi   # number of leafs
    leaq root(%rip), %rdx

    testq %rdx, %rdx
    jz RICH_HW1   # Jump to HW1_RICH if tree is empty

    jmp FIRST_DEGREE_LOOP_HW1

END_ALL_DEGREES_HW1:
    movq %rdi, %rax   
    movq $0, %rdx     
    divq %rsi         

    # Compare result with 3
    cmpq $3, %rax
    jb RICH_HW1      

    cmpq $3, %rax
    jne END_HW1

    testq %rdx, %rdx # if is 3 but there is a remainder
    je RICH_HW1
    jmp END_HW1

FIRST_DEGREE_LOOP_HW1:   
    incq %rdi
    movq (%rdx), %r8
    testq %r8, %r8 # leaf
    jne FIRST_DEGREE_INNER_LOOP_HW1
    incq %rsi
    jmp END_ALL_DEGREES_HW1
FIRST_DEGREE_INNER_LOOP_HW1:
    addq $8, %rdx
    jmp SECOND_DEGREE_LOOP_HW1
FIRST_DEGREE_RETURN_FROM_PREV_HW1:
    movq (%rdx), %r8
    testq %r8, %r8 # ending
    je END_ALL_DEGREES_HW1
    jmp FIRST_DEGREE_INNER_LOOP_HW1

SECOND_DEGREE_LOOP_HW1:   
    incq %rdi
    movq (%r8), %r9
    testq %r9, %r9 # leaf
    jne SECOND_DEGREE_INNER_LOOP_HW1
    incq %rsi
    jmp FIRST_DEGREE_RETURN_FROM_PREV_HW1
SECOND_DEGREE_INNER_LOOP_HW1:
    addq $8, %r8
    jmp THIRD_DEGREE_LOOP_HW1
SECOND_DEGREE_RETURN_FROM_PREV_HW1:
    movq (%r8), %r9
    testq %r9, %r9 # ending
    je FIRST_DEGREE_RETURN_FROM_PREV_HW1
    jmp SECOND_DEGREE_INNER_LOOP_HW1

THIRD_DEGREE_LOOP_HW1:   
    incq %rdi
    movq (%r9), %r10
    testq %r10, %r10 # leaf
    jne THIRD_DEGREE_INNER_LOOP_HW1
    incq %rsi
    jmp SECOND_DEGREE_RETURN_FROM_PREV_HW1
THIRD_DEGREE_INNER_LOOP_HW1:
    addq $8, %r9
    jmp FOURTH_DEGREE_LOOP_HW1
THIRD_DEGREE_RETURN_FROM_PREV_HW1:
    movq (%r9), %r10
    testq %r10, %r10 # ending
    je SECOND_DEGREE_RETURN_FROM_PREV_HW1
    jmp THIRD_DEGREE_INNER_LOOP_HW1

FOURTH_DEGREE_LOOP_HW1:   
    incq %rdi
    movq (%r10), %r11
    testq %r11, %r11 # leaf
    jne FOURTH_DEGREE_INNER_LOOP_HW1
    incq %rsi
    jmp THIRD_DEGREE_RETURN_FROM_PREV_HW1
FOURTH_DEGREE_INNER_LOOP_HW1:
    addq $8, %r10
    jmp FIFTH_DEGREE_LOOP_HW1
FOURTH_DEGREE_RETURN_FROM_PREV_HW1:
    movq (%r10), %r11
    testq %r11, %r11 # ending
    je THIRD_DEGREE_RETURN_FROM_PREV_HW1
    jmp FOURTH_DEGREE_INNER_LOOP_HW1

FIFTH_DEGREE_LOOP_HW1:   
    incq %rdi
    movq (%r11), %r12
    testq %r12, %r12 # leaf
    jne FIFTH_DEGREE_INNER_LOOP_HW1
    incq %rsi
    jmp FOURTH_DEGREE_RETURN_FROM_PREV_HW1
FIFTH_DEGREE_INNER_LOOP_HW1:
    addq $8, %r11
    jmp SIXTH_DEGREE_LOOP_HW1
FIFTH_DEGREE_RETURN_FROM_PREV_HW1:
    movq (%r11), %r12
    testq %r12, %r12 # ending
    je FOURTH_DEGREE_RETURN_FROM_PREV_HW1
    jmp FIFTH_DEGREE_INNER_LOOP_HW1

SIXTH_DEGREE_LOOP_HW1:   
    incq %rdi
    movq (%r12), %r13
    testq %r13, %r13 # leaf
    jne SIXTH_DEGREE_INNER_LOOP_HW1
    incq %rsi
    jmp FIFTH_DEGREE_RETURN_FROM_PREV_HW1
SIXTH_DEGREE_INNER_LOOP_HW1:
    addq $8, %r12
    jmp FIFTH_DEGREE_LOOP_HW1
SIXTH_DEGREE_RETURN_FROM_PREV_HW1:
    movq (%r12), %r13
    testq %r13, %r13 # ending
    je FIFTH_DEGREE_RETURN_FROM_PREV_HW1
    jmp SIXTH_DEGREE_INNER_LOOP_HW1

SEVENTH_DEGREE_LOOP_HW1:
    incq %rdi
    jmp SIXTH_DEGREE_RETURN_FROM_PREV_HW1
# no more than six deep

RICH_HW1:
    # Set Rich to 1
    movb $1, rich(%rip)
    jmp END_HW1  

END_HW1:
