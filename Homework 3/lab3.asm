#.data
#	There are four things here: The sentence which used to tell users type the positive integer. Tab. Star. New line.
#.text
#	main:
#
#	GIP:
#
#	Try to get the integer which entered by users. This is a loop. If the user haven't entered the integer which meet
#	the condition, then this loop will never end.
#
#	Prepare for the forI(Initialize some variables)
#
#	forI:
#
#		Prepare for the forII and forIII. The function of forI is iterating for forII and forIII and print new line in 
#		the end.
#
#		forII: 
#
#			forII needs to print tabs. 
#
#		forIII:
#
#			Check if current data meet the condition. If yes, go to funI, or print tab and star. After executing funI,
#			check if current data meet the condition. If yes, go to funII, or quit the loop.
#
#	p.s.: I put funI and funII behind the main, so I put some codes in the end of main to end it manually, or it will 
#   	execute funI or funII again.
.data
	prompt:   .asciiz "Enter the height of the pattern (must be greater than 0):"		#These four are data
	tab:      .asciiz "\t"
	star:     .asciiz "*"
	newline:  .asciiz "\n"
.text
	main:
	
	GIP:
	
	li $v0, 4		#-------------------------------------------------------------
	la $a0, prompt
	syscall			#Try to get what user input in this part
	
	li $v0, 5
	syscall			
	
	move $t0, $v0
	
	blez $t0, GIP		#-------------------------------------------------------------
	addi $t1, $zero, 0	# Prepare for the first loop here
	addi $t7, $zero, 1	#-------------------------------------------------------------
	
	forI:
		beq $t0, $t1, exitI		#-------------------------------------------------------------
		sub $t2, $t0, $t1
		sub $t2, $t2, 1			# Prepare for the second loop here
		add $t3, $zero, 0		#-------------------------------------------------------------
		
		
		forII:
			beq $t2, $t3, exitII	#Condition to quit
			
			li $v0, 4
			la $a0, tab		#Print the tab
			syscall
			
			add $t3, $t3, 1
			j forII
		exitII:
		mul $t4, $t1, 2
		add $t4, $t4, 1		#Prepare for the third loop
		addi $t5, $zero, 0
		
		forIII:
			beq $t4, $t5, exitIII
			mul $t6, $t1, 2
			beqz $t5, funI			# The condition to enter the Function I
			beq $t5, $t6, funI
			beq $t0, $t1, funI
			
			li $v0, 4
			la $a0, star			# Do it if all conditions above are not met
			syscall
			
			li $v0, 4
			la $a0, tab			#Print tab
			syscall 
			
			j back				# finish
			
			cheII:
				blt $t5, $t6, funII		# Check if it will go to Function II, or it will go to back and end here
				
				j back
				
			back:
			
			add $t5, $t5, 1
			j forIII
		exitIII:
		li $v0, 4
		la $a0, newline				# We need to print a new line here
		syscall
		
		add $t1, $t1, 1		
		j forI
	exitI:
		li $v0, 10				#End of whole program
		syscall
	
	funI:
		li $v0, 1
		move $a0, $t7
		syscall					# If Function I is done, then go to Check II to check if it will act Function II
		
		addi $t7, $t7, 1
		
		j cheII
			
	funII:
		li $v0, 4
		la $a0, tab				#If the condition in Check II is met, Function II will be executed
		syscall
		
		j back
