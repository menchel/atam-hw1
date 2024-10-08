.global _start

.section .text
_start:
#your code here

# load new node
# check sorted before
# check sorted after

movb $0, %r11b # counter for result
leaq nodes(%rip), %rdx # start of list of nodes
movl $0, %r15d

LOOP_FIRST_HW1:
    cmp $3,%r15d
    je ENDING_CHECK_HW1

    jmp CHECK_RESULT_HW1
CONTINUE_FIRST_LOOP_HW1:
    addq $8, %rdx
    incl %r15d
    jmp LOOP_FIRST_HW1

ENDING_CHECK_HW1:
movb %r11b, result(%rip)
jmp ENDING_HW1

# main
CHECK_RESULT_HW1:
    movq $0,%r12 # counter for sorted parts
    # prev
    cmp $0, (%rdx)
    jne RUN_TEST_PREV_HW1
    incq %r12
    jmp TEST_AFTER_HW1
RUN_TEST_PREV_HW1:
    movq $0, %rdi # first element exists
    movq $0, %rsi # last element
    movq $0, %rcx # sorting way 0 not decided 1 up 2 down
    movq %rdx, %r8
    jmp CHECK_SORTED_BEFORE_HW1
CONTINUE_LOOP_BEFORE_HW1:
    movq %r8, %rdx

    cmp $0, %r12 # if not sorted
    jz END_CHECK_HW1

TEST_AFTER_HW1:
    # after
    lea 12(%rdx), %r13
    cmp $0, %r13
    jne RUN_TEST_NEXT_HW1
    incq %r12
    jmp END_CHECK_HW1

RUN_TEST_NEXT_HW1:
    movq %r8, %rdx
    movq $0, %rdi # first element exists
    movl $0, %esi # last element
    movq $0, %rcx # sorting way 0 not decided 1 up 2 down
    movq %rdx, %r8
    jmp CHECK_SORTED_AFTER_HW1
CONTINUE_LOOP_AFTER_HW1:
    movq %r8, %rdx

END_CHECK_HW1:
    cmp $2, %r12
    jne RETURN_LOOP_HW1
    incb %r11b
RETURN_LOOP_HW1:
    movq %r8, %rdx
    jmp CONTINUE_FIRST_LOOP_HW1

# before check function
CHECK_SORTED_BEFORE_HW1:
    movq (%rdx), %rdx
    movq (%rdx), %rdx
    # body
LOOP_BEFORE_HW1:
    cmpq $0,%rdx
    je SORTED_BEFORE_HW1
    movl 8(%rdx), %r14d # current element
    cmpq $0, %rdi
    je FIRST_VALUE_BEFORE_HW1
    cmpl %esi, %r14d # if they are equal it is okay
    je END_OF_LOOP_BEFORE_HW1
    cmpq $0, %rcx # no sorting yet
    je ACTIVATE_SORTING_ORDER_BEFORE_HW1
    cmpq $1, %rcx # soring up
    je CHECK_IF_SORTED_UP_BEFORE_HW1
    # sorted down

CHECK_IF_SORTED_DOWN_BEFORE_HW1:
    cmpl %esi, %r14d
    jl END_OF_LOOP_BEFORE_HW1
    jmp LOOP_END_BEFORE_HW1

CHECK_IF_SORTED_UP_BEFORE_HW1:
    cmpl %esi, %r14d
    jg END_OF_LOOP_BEFORE_HW1
    jmp LOOP_END_BEFORE_HW1
FIRST_VALUE_BEFORE_HW1:
    movq $1, %rdi
    jmp END_OF_LOOP_BEFORE_HW1

ACTIVATE_SORTING_ORDER_BEFORE_HW1:
    cmpl %esi, %r14d
    jg SORTING_UP_BEFORE_HW1
    movq $2, %rcx # soring down
    jmp END_OF_LOOP_BEFORE_HW1

SORTING_UP_BEFORE_HW1:
    movq $1, %rcx
END_OF_LOOP_BEFORE_HW1:
    movl %r14d, %esi
    movq (%rdx), %rdx
    jmp LOOP_BEFORE_HW1

SORTED_BEFORE_HW1:
    incq %r12
LOOP_END_BEFORE_HW1:
    jmp CONTINUE_LOOP_BEFORE_HW1


# before check function
CHECK_SORTED_AFTER_HW1:
    movq (%rdx), %rdx
    movq 12(%rdx), %rdx
    # body
LOOP_AFTER_HW1:
    cmpq $0,%rdx
    je SORTED_AFTER_HW1
    movl 8(%rdx), %r14d # current element
    cmpq $0, %rdi
    je FIRST_VALUE_AFTER_HW1
    cmpl %esi, %r14d # if they are equal it is okay
    je END_OF_LOOP_AFTER_HW1
    cmpq $0, %rcx # no sorting yet
    je ACTIVATE_SORTING_ORDER_AFTER_HW1
    cmpq $1, %rcx # soring up
    je CHECK_IF_SORTED_UP_AFTER_HW1
    # sorted down

CHECK_IF_SORTED_DOWN_AFTER_HW1:
    cmpl %esi, %r14d
    jl END_OF_LOOP_AFTER_HW1
    jmp LOOP_END_AFTER_HW1

CHECK_IF_SORTED_UP_AFTER_HW1:
    cmpl %esi, %r14d
    jg END_OF_LOOP_AFTER_HW1
    jmp LOOP_END_AFTER_HW1
FIRST_VALUE_AFTER_HW1:
    movq $1, %rdi
    jmp END_OF_LOOP_AFTER_HW1

ACTIVATE_SORTING_ORDER_AFTER_HW1:
    cmpl %esi, %r14d
    jg SORTING_UP_AFTER_HW1
    movq $2, %rcx # soring down
    jmp END_OF_LOOP_AFTER_HW1

SORTING_UP_AFTER_HW1:
    movq $1, %rcx
END_OF_LOOP_AFTER_HW1:
    movl %r14d, %esi
    movq 12(%rdx), %rdx
    jmp LOOP_AFTER_HW1

SORTED_AFTER_HW1:
    incq %r12
LOOP_END_AFTER_HW1:
    jmp CONTINUE_LOOP_AFTER_HW1

ENDING_HW1:
