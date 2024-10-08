
.data
#Examples
#	Y x num_cols + X = indicie
#       #8 = 7th array indicie, = (1,2) (y,x) = 1 x 5 + 2 = 7
#       #1 = 0th array indicie = (0,0) = 0 x 5 + 0 = 0

	arr: .word 1, 2, 3, 4, 5
	     .word 6, 7, 8, 9, 10
	     .word 11, 12, 13, 14, 15
	     
.text

	lw $a0, arr
	addi $a0, $a0, 4
	li, $v0, 1
	syscall
	
	# (
	addi, $s0, $s0, 1
	addi, $s1, $s1, 2
	
	#add the constant 5 = num of collumns
	addi $t0, $t0, 5
	
	mult $s0, $t0 # Note: Result is stored in $lo (or both $hi if overflow)
	mflo $s0
	add $s0, $s0, $s1
	
	la $a0, 0($s0)
	li $v0, 1
	syscall
	
	
	
	#Exit
	li, $v0, 10
	syscall