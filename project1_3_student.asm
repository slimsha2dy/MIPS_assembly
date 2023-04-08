.data
equation: .asciiz "2023-3102=" # -1079

.text
.main:
	la $a0, equation
	
	li $s0, '='
	li $s1, '+'
	li $s2, '-'
	
	li $t0, 0	# temporary integer value
	li $t1, 10	# to mutifly
	
Loop:	# while (str[i] != '=')
	lb $t2, ($a0)		# load character from equation
	beq $t2, $s0, Exit
	beq $t2, $s1, Add	# add function
	beq $t2, $s2, Sub	# sub function
	
	jal Int
	
	j Loop
	
Int:	# get integer
	lb $t2, ($a0)
	
	# while (str[i] != '=' && str[i] != '+' && str[i] != '-')
	beq $t2, $s0, Jumpreg
	beq $t2, $s1, Jumpreg
	beq $t2, $s2, Jumpreg
	
	mul $t0, $t0, $t1	# return value * 10
	subi $t2, $t2, '0'	# char to integer
	add $t0, $t0, $t2	# return value + units
	
	addi $a0, $a0, 1	# incrementing pointer to point to next character
	
	j Int
	
Jumpreg:# jump to return register
	jr $ra
	
Add:	# store previous integer value in $t4
	move $t4, $t0
	
	li $t0, 0		# initialization
	
	addi $a0, $a0, 1
	jal Int			# store next integer in $t0
	add $t4, $t4, $t0	# add action
	move $t0, $t4		# restore temporary value in $t0

	j Loop
	
Sub:	# store previous integer value in $t4
	move $t4, $t0
	
	li $t0, 0		# initialization
	
	addi $a0, $a0, 1
	jal Int			# store next integer in $t0
	sub $t4, $t4, $t0	# sub action
	move $t0, $t4		# restore temporary value in $t0
	
	j Loop
	
Exit:	move $a0, $t4		# move return value to $a0
	
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall