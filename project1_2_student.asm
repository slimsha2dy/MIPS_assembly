.data
input: .asciiz "input an integer: "

.text
.main:
	li $v0, 4		# prompt input
	la $a0, input
	syscall
	
	li $v0, 5		# get input
	syscall
	move $a0, $v0
	
	li $t3, 1		# return value
	
	jal product
	
	# print return value
	move $a0, $t3
	li $v0, 1
	syscall
	
	# exit program
	li $v0, 10
	syscall

product:
	# store $a0 and $r0
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	
	li $t0, 10
	div $a0, $t0
	mflo $t1		# quotient
	mfhi $t2		# remainder
	
	sw $t2, 0($sp)		# store remainder in stack
	
	# next step
	move $a0, $t1
	beqz $a0, return
	jal product
	
return:
	# load remainder and $ra from stack
	lw $t0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	mul $t3, $t3, $t0	# mutiply return value and digit
	
	# return
	jr $ra