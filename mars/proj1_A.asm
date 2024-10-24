
# Set up and initialize a 2d array of '#' and ' ' which will be 1's and 0's

# if you want to access the element at row i and column j, 
# you can calculate the offset as i * ArraySize + j and load or store the character using that offset.
#
.data
	.eqv ArraySize 3	# arraySize = total number of rows and total number of collumns (square array)
	.eqv DataSize 1		# bytes = 1, word = 4

# This might be needed to be reworked to words later in case i run into alignment issues
	charArr: .space 9	# ArraySize * ArraySize = space, ( no need to multiply dataSize because byte = 1)
	msg: .asciiz  "Testing"


.text

main:
	li $t0, 0	# i = 0 (Make sure index variable stays outside of the loop function)
	la $s1, charArr	# load base address, also needs to be outside of the loop
	li $t1, 99	#this is the number we will be storing(initializing), across the whole array
	li $t2, ArraySize
	mul $t2, $t2, $t2
	jal InitMaze
	
#	jal PrintMaze


#	jal carveMaze

#	jal PrintMaze


	
	
	# end
	li $v0, 10
	syscall
	


# Set all the bytes of the maze to be (0) = '#' = wall, (1) = ' '  = free spot
InitMaze:
	

	sb $t1, 0($s1)	# store the value (99) at $s1 + 0 offset
	addi $s1, $s1, 1# need to move the address stored in $s1 to $s1 + 1 (byte)
	addi $t0, $t0, 1 # i += 1;, 
	blt $t0, $t2, InitMaze	# check that i < arraySize, if not, go  back to InitMaze
		

	jr $ra
	
	

#PrintMaze:


#	jr $ra


printWall:


printSpace: