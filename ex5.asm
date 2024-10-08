.global _start

.section .text
_start:
#your code here

movb $0,seconddegree(%rip)  
movl  size(%rip),%r8d # size of series
mov   $3,%r9d # start index (last in line)

CHECK_DIFF_DIFF_SERIES_LOOP_HW1:
cmpl %r8d,%r9d # check ending
jae SUCCESS_HW1

movl series-12(,%r9d,4),%r10d # first
movl series-8(,%r9d,4),%r11d # second
movl series-4(,%r9d,4),%r12d # third
movl series(,%r9d,4),%r13d # fourth

subl %r12d,%r13d # diffrences
subl %r11d,%r12d
subl %r10d,%r11d

subl %r12d,%r13d # check diffrences
subl %r11d,%r12d
cmpl %r12d,%r13d
jne CHECK_DIFF_QUAT_SERIES_START_HW1

incl %r9d # prepare next iteration
jmp CHECK_DIFF_DIFF_SERIES_LOOP_HW1

CHECK_DIFF_QUAT_SERIES_START_HW1:
movl $3,%r9d # restart index

CHECK_DIFF_QUAT_SERIES_LOOP_HW1:
cmpl %r8d,%r9d # check ending
jae SUCCESS_HW1

movl series-12(,%r9d,4),%r10d # first
movl series-8(,%r9d,4),%r11d # second
movl series-4(,%r9d,4),%r12d # third
movl series(,%r9d,4),%r13d # fourth

subl %r12d,%r13d # diffrences
subl %r11d,%r12d
subl %r10d,%r11d

# zero should be tested seperately
testl %r13d,%r13d
je ZERO_FOUND_IN_DIFF_QUAT_HW1
testl %r12d,%r12d
je ZERO_FOUND_IN_DIFF_QUAT_HW1
test   %r11d,%r11d
je ZERO_FOUND_IN_DIFF_QUAT_HW1

# divide
movl %r13d,%eax
movl $0,%edx
cdq
idiv %r12d
movl %eax,%r13d
movl %r12d,%eax
movl $0x0,%edx
cdq
idiv %r11d
movl %eax,%r12d

# check if %r13d/%r12d=%r12d/%r11d
cmpl %r13d,%r12d
jne CHECK_QUAT_DIFF_SERIES_START_HW1
incl %r9d
jmp CHECK_DIFF_QUAT_SERIES_LOOP_HW1

CHECK_QUAT_DIFF_SERIES_START_HW1:
movl $3,%r9d

CHECK_QUAT_DIFF_SERIES_LOOP_HW1:
cmpl %r8d,%r9d # check ending
jae SUCCESS_HW1

movl series-12(,%r9d,4),%r10d # first
movl series-8(,%r9d,4),%r11d # second
movl series-4(,%r9d,4),%r12d # third
movl series(,%r9d,4),%r13d # fourth

# no zeroes allowed here
testl %r13d,%r13d
je END_HW1
testl %r12d,%r12d
je END_HW1
testl %r11d,%r11d
je END_HW1
testl %r10d,%r10d
je END_HW1

# do division for elements
movl %r13d,%eax
movl $0,%edx
cdq
idiv %r12d
movl %eax,%r13d
movl %r12d,%eax
movl $0,%edx
cdq
idiv %r11d
movl %eax,%r12d
movl %r11d,%eax
movl $0,%edx
cdq
idiv %r10d
movl %eax,%r11d

# check diffrences
subl %r12d,%r13d
subl %r11d,%r12d
cmpl %r12d,%r13d
jne CHECK_QUAT_QUAT_SERIES_START_HW1
incl %r9d
jmp CHECK_QUAT_DIFF_SERIES_LOOP_HW1

CHECK_QUAT_QUAT_SERIES_START_HW1:
movl $3,%r9d

CHECK_QUAT_QUAT_SERIES_LOOP_HW1:
cmpl %r8d,%r9d # check ending
jae SUCCESS_HW1

movl series-12(,%r9d,4),%r10d # first
movl series-8(,%r9d,4),%r11d # second
movl series-4(,%r9d,4),%r12d # third
movl series(,%r9d,4),%r13d # fourth

# no zeroes allowed here
testl %r13d,%r13d
je END_HW1
testl %r12d,%r12d
je END_HW1
testl %r11d,%r11d
je END_HW1
testl %r10d,%r10d
je END_HW1

# do division for elements
movl %r13d,%eax
movl $0,%edx
cdq
idiv %r12d
movl %eax,%r13d
movl %r12d,%eax
movl $0,%edx
cdq
idiv %r11d
movl %eax,%r12d
movl %r11d,%eax
movl $0,%edx
cdq
idiv %r10d
movl %eax,%r11d

# check that elements are not zero
testl %r13d,%r13d
je END_HW1
testl   %r12d,%r12d
je END_HW1
testl   %r11d,%r11d
je END_HW1

# make the new quatations
movl %r13d,%eax
movl $0,%edx
cdq
idiv %r12d
movl %eax,%r13d
movl %r12d,%eax
movl $0,%edx
cdq
idiv %r11d
movl %eax,%r12d

# check if %r13d/%r12d=%r12d/%r11d
cmpl %r12d,%r13d
jne END_HW1
incl %r9d
jmp CHECK_QUAT_QUAT_SERIES_LOOP_HW1

ZERO_FOUND_IN_DIFF_QUAT_HW1:
movl $2,%r9d
ZERO_LOOP_DIFF_QUAT_HW1:
cmpl %r8d,%r9d
jae SUCCESS_HW1
movl series-4(,%r9d,4),%r12d
movl series(,%r9d,4),%r13d
cmpl %r12d,%r13d
jne CHECK_QUAT_DIFF_SERIES_START_HW1
incl %r9d
jmp ZERO_LOOP_DIFF_QUAT_HW1

SUCCESS_HW1:
movb $1,seconddegree(%rip)  
jmp END_HW1

END_HW1:
