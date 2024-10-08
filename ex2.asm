.global _start

.section .text
_start:
#your code here

#labales
#size
#data
#type


movq size(%rip), %r8 # size of data
movq $0, %r9 # current index of data
movq $1, %r10 # place in data (start from 1)
movb $1, %r12b # is simple ascii
movb $1, %r13b # is scientific ascii

# start loop
MAIN_LOOP_HW1:

cmpq %r8, %r9 # empty data
je NOT_NULL_TERMINATED_HW1

movb data(,%r9,1), %r11b # the current byte to read
cmpb $0, %r11b
je NULL_TERMINATOR_FOUND_HW1
jmp SIMPLE_ASCII_CHECK_HW1

AFTER_CHECK_MAIN_HW1:
testb %r12b, %r12b
jne END_LOOP_HW1
testb %r13b, %r13b
jne END_LOOP_HW1
# we got here, it is not 1 or 2
jmp NOT_NULL_TERMINATED_HW1

END_LOOP_HW1:
incq %r9
incq %r10
jmp MAIN_LOOP_HW1

# end loop

NULL_TERMINATOR_FOUND_HW1:
cmpq %r8, %r10 # is last place
je NULL_TERMINATED_HW1
jmp NOT_NULL_TERMINATED_HW1

SIMPLE_ASCII_CHECK_HW1:
# lets check all possibilities

CHECK_NUM_HW1:
cmpb $48, %r11b
jb CHECK_BIG_LETTERS_HW1
cmpb $57, %r11b
ja CHECK_BIG_LETTERS_HW1
jmp ALL_ASCII_CHECK_HW1

CHECK_BIG_LETTERS_HW1:
cmpb $65, %r11b
jb CHECK_SMALL_LETTERS_HW1
cmpb $90, %r11b
ja CHECK_SMALL_LETTERS_HW1
jmp ALL_ASCII_CHECK_HW1

CHECK_SMALL_LETTERS_HW1:
cmpb $97, %r11b
jb CHECK_SPECIFIC_HW1
cmpb $122, %r11b
ja CHECK_SPECIFIC_HW1
jmp ALL_ASCII_CHECK_HW1

CHECK_SPECIFIC_HW1:
# check .
cmpb $46, %r11b
je ALL_ASCII_CHECK_HW1

# check ,
cmpb $44, %r11b
je ALL_ASCII_CHECK_HW1

# check ?
cmpb $63, %r11b
je ALL_ASCII_CHECK_HW1

# check (space)
cmpb $32, %r11b
je ALL_ASCII_CHECK_HW1

# check (!)
cmpb $33, %r11b
je ALL_ASCII_CHECK_HW1

# we got here, so it is not simple
jmp NOT_SIMPLE_ASCII_HW1

NOT_SIMPLE_ASCII_HW1:
movb $0, %r12b
jmp ALL_ASCII_CHECK_HW1

ALL_ASCII_CHECK_HW1:
cmpb $32, %r11b # less than 32
jb NOT_ALL_ASCII_HW1
cmpb $162, %r11b # more than
ja NOT_ALL_ASCII_HW1
jmp AFTER_CHECK_MAIN_HW1

NOT_ALL_ASCII_HW1:
movb $0, %r13b
jmp AFTER_CHECK_MAIN_HW1

NULL_TERMINATED_HW1:
# we got here so it is null terminated AND last place
cmpb $1, %r12b # is simple
je OPTION1_HW1
cmpb $1, %r13b # is scientific
je OPTION2_HW1
jmp NOT_NULL_TERMINATED_HW1

NOT_NULL_TERMINATED_HW1:
# either 3 or 4
# check division by 8

    movq %r8, %rax
    movq $8, %rbx
    movq $0, %rdx
    div %rbx
    testq %rdx, %rdx 
    jne OPTION4_HW1 # not divisible

# now check that all quads are not zero

movq $0, %r11 # clear %r11
movq $0, %r9 # clear %r9
QUADS_NOT_ZERO_LOOP_HW1:

testq %r8, %r8 # finished, havent found zeroes
je OPTION3_HW1

movq data(,%r9,8), %r11 # check for zero quad
testq %r11, %r11
je OPTION4_HW1

addq $1,%r9
subq $8, %r8
jmp QUADS_NOT_ZERO_LOOP_HW1


OPTION1_HW1:
movb $1,type(%rip)
jmp END_HW1

OPTION2_HW1:
movb $2,type(%rip)
jmp END_HW1

OPTION3_HW1:
movb $3,type(%rip)
jmp END_HW1

OPTION4_HW1:
movb $4,type(%rip)
jmp END_HW1

END_HW1:
