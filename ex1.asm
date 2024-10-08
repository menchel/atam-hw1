.global _start

.section .text
_start:

#labales
#Adress
#Index
#length
#Legal
#num

# potential problems:
# 1 length 0
# 2 index<0 (unsigned so okay)
# 3 index>=length
# 4 overflow (place of arr+index is more than 0xFFFFFFFF)

#your code here

# problem 1
movq $0, %rdx
movl length(%rip), %r8d
testl %r8d,%r8d
je INVALID_HW1
jmp CHECK_INDEX_HW1

INVALID_HW1:
    movb $0, Legal(%rip)
    jmp ENDING_HW1

CHECK_INDEX_HW1:
# problem 3
movl Index(%rip), %r9d
cmpl %r8d, %r9d
jae INVALID_HW1
jmp CHECK_ADRESS_HW1

CHECK_ADRESS_HW1:
# problem 4 
movq Adress(%rip), %r12  
leaq (%r12), %r10
movslq %r9d, %r9

# check carry
shlq $2, %r9 
jc INVALID_HW1               
addq %r9, %r10
jc INVALID_HW1             

VALID_HW1:
#valid
    movb $1, Legal(%rip)
    movl (%r10), %r11d
    movl %r11d, num(%rip)
    jmp ENDING_HW1

ENDING_HW1:

