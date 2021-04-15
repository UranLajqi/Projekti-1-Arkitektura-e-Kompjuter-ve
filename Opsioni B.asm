.data
  teskti1:	.asciiz "Enter positive integer to check: "
  teskti2:	.asciiz " is a prime number."
  teskti3:	.asciiz " is not a prime number."
  
.text
main:
  li $t0, 0	# flag = 0
  li $v0, 4		
  la $a0, teskti1	# Printohet teskti1
  syscall		
	
  li $v0, 5	# i mundeson perdoruesit te shenoj numrin
  syscall
	
  move $a0, $v0		# e vendosim vleren e dhene nga tastiera ne $a0  
  			# sepse na duhet te perdoret si argument 

  li $v0, 1	# e printojm numrin e shenuar nga perdoruesi
  syscall
	
  jal prime	# e thirrim funksionin prime
	
  add $t0, $zero, $v1	 #  $v1 vleren qe e kthen funksioni prime e vendosim ne $t0
	
  li $t4, 1	# ne $t4 e vendosim numrin 1
	
  beq $t0, $t4, nukEshte    # nese flag eshte 1 atehre numri nuk eshte prime
  			     # atehere programi do te vazhdoj te labeli Eshte
  			     # nese jo programi vazhdon ne rreshtin e rradhes
  li $v0, 4
  la $a0, teskti2	# printohet teksti2
  syscall
  
  j Exit	# behet jump(kercim) te labeli Exit
		
  nukEshte:		
  	li $v0, 4
	la $a0, teskti3		# printohet teksti3
	syscall
  
  Exit:	
	li $v0, 10	# terminohet programi
	syscall

  # funksioni prime
  prime:
	addi $t0, $zero, 2 # e inicializojm i=2
  	div $t5, $a0, 2 # n / 2
  	
  loop: 
	bge $t5, $t0 IF    # nese i <= n/2 atehere programi 
			   # vazhdon te labeli IF
			   # nese jo programi vazhdon ne rreshtin e rradhes
		
	li $v1, 0     # kthen rezultatin 0
	jr $ra
	
	IF:
		div $t6, $a0, $t0       # n % i == 0
		mfhi $t7                # metja
		beqz $t7, true		# nese mbetja eshte e barabart me zero
					# atehere programi shkon te labeli true
	addi $t0, $t0, 1        # i++
	j loop		# kercen te labeli loop

  true:
	li $v1, 1       # kthen rezultatin 1
	jr $ra

	
		
