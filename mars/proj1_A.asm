
.data
    array: .space 100
    newline: .asciiz "\n"

.text

    la $t0, array
    li $t1, 100
    li $t2, 0



#Exit
    li $v0, 10
    syscall