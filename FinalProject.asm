TITLE FinalProject (FinalProject.asm)
; Author: Ethan Peterson 5/31/23

;Description:
; 

INCLUDE Irvine32.inc

.const
	maxhealth = 3

.data

;Strings

	TitleMSG		BYTE			"*--------------------------------------*", 10, 13, "     MYSTICAL MAGIC MATH WORLD III!",10, 13, "*--------------------------------------*", 10, 13, 0
	startgame		BYTE			"Press enter to start a new game!", 0
	gameOver		BYTE			"GAME OVER THANK YOU FOR PLAYING",
							10, "Enter 1 to keep playing, and 0 to quit", 0
	dia1			BYTE			"You open your eyes to see the bright sun gleaming down on you",
							10, "You quikly get up in a burst of light to see a castle ahead of you",
							10, "You begin to walk until you reach to start of the castle entarance", 
							10, "Right outside the gate door you see a chest", 0
	openChest1	BYTE			"Press 1 to open or 0 to pass", 0
	openChest2	BYTE			"You opened a mathematical Finisher",
							10, "This kill card can instantly kill any boss in one move", 0
	continue		BYTE			"Enter any key to continue", 0
	addmsg		BYTE			"1 Mathematical Finisher added to your inventory", 0

	dia2			BYTE			"You then open the castle doors with all your might",
							10, "When you step inside you see a very large and powerful addition goblin standing in the middle of what seems to be a collesium",
							10, "He says that to get through his castle you must kill him by solving his math problems or he will eat you", 0
	fight		BYTE			"Type a 1 to fight him or 0 to have him eat you right away", 0
	inv			BYTE			"Would you like to use the item in your inventory to skip the boss?", 0
	

	dia3			BYTE			"*-------------------------------*", 10, 13, "     ADDITION GOBLIN",10, 13, "*-------------------------------*", 10, 13, 0,
							10, "Addition Goblin: What is ", 0
	dia4			BYTE			" + ", 0
	correctmsg	BYTE			"That is correct, The boss lost 1 health", 0
	incorrectmsg	BYTE			"That is incorrect, You have lost 1 health", 0
	PhMsg		BYTE			"Your Health is: ", 0
	BhMsg		BYTE			"The Bosses Health is: ", 0
	BossDeath		BYTE			"You have succesfully killed the boss!", 0
	playerDeath	BYTE			"You have ran out of health, YOU ARE DEAD!", 0
	questionmark	BYTE			"?", 0
	emptyinv		BYTE			"You have no items in your inventory", 0
	chooseinv		BYTE			"You have ", 0
	chooseinv2	BYTE			" items in your inventory, Would you like to use one of your mathematical finishers on this boss?",
							10, "(1 for YES or 2 for NO)", 0
	BossDeathtoitem		BYTE			"You have succesfully killed the boss using your mathematical finisher!",
									10, "Press enter to continue", 0
							
	
	
	
	

; Arrays
	playerInventory	DW	2	DUP(0)

; Variables
	playerHealth	dword	3
	bossHealth	dword	3
	numOfItems	dd	0
	num1			dd	?
	num2			dd	?
	ans			dd	?

; MACROS
HEALTH_CHECK MACRO
    cmp dword ptr [playerHealth], 0
    je GameOver
ENDM

BOSS_HEALTH_CHECK MACRO
    cmp bossHealth, 0
    je GameOver
ENDM

.code

; Procedures
addInv PROC
		mov ax, word ptr [playerInventory]
		cmp ax, 1
		je idx1
		jmp idx2

	idx1:
		mov word ptr [playerInventory], 1
		mov EDX, OFFSET addmsg
		call WriteString
		call Crlf
		jmp endz

	idx2:
		mov word ptr [playerInventory + 2], 1
		mov EDX, OFFSET addmsg
		call WriteString
		call Crlf

	endz:

	ret
addINV ENDP

clearScreen PROC
    mov ecx, 100

clearLoop:
    call Crlf 
    loop clearLoop

    ret
clearScreen ENDP



introduction PROC
	
	mov EDX, OFFSET TitleMSG
	call WriteString
	call CRLF

	mov EDX, OFFSET startgame
	call WriteString
	call Crlf
	
	call ReadDec

	ret
introduction ENDP

scene1 PROC

	mov EDX, OFFSET dia1
	call WriteString
	call Crlf
	call Crlf

	mov EDX, OFFSET openChest1
	call WriteString
	call Crlf
	call ReadDec
	cmp EAX, 0
	je skip

	inc numOfItems
	call clearScreen
	mov EDX, OFFSET openChest2
	call WriteString
	call Crlf
	call Crlf
	call addInv
	mov EDX, OFFSET continue
	call WriteString
	call Crlf
	call ReadDec

	skip:
		call clearScreen

	ret
scene1 ENDP

generateRandomNumbers PROC
    call Randomize    ; Initialize the seed for the random number generator

    mov  eax, 101     ; Generate a random number between 0 and 100
    call RandomRange
    mov  num1, eax    ; Store the random number in num1

    mov  eax, 101     ; Generate another random number
    call RandomRange
    mov  num2, eax    ; Store the random number in num2

    ret
generateRandomNumbers ENDP

scene2 PROC

	mov EDX, OFFSET dia2
	call WriteString
	call Crlf
	call Crlf
	
	mov EDX, OFFSET fight
	call WriteString
	call Crlf
	call ReadDec
	
	cmp eax, 0
	je ended
	call clearScreen

	invent:
		cmp numOfItems, 0
		je empty
		mov EDX, OFFSET chooseINV
		call WriteString
		mov eax, numofitems
		call WriteDec
		mov EDX, OFFSET chooseinv2
		call WriteString
		call Crlf
		call ReadDec
		cmp eax, 1
		je diedtoitem
		
		jmp fightloop

	empty:
		mov EDX, OFFSET emptyinv
		call WriteString
		call Crlf
		call Crlf
		
	
	fightloop:
		call generateRandomNumbers
		mov eax, num1
		add eax, num2
		mov ans, eax

		mov EDX, OFFSET bhMsg
		call WriteString
		mov eax, bossHealth
		call WriteDec
		call Crlf
		mov EDX, OFFSET phMsg
		call WriteString
		mov eax, playerHealth
		call WriteDec
		call Crlf

		mov EDX, OFFSET dia3
		call WriteString
		mov EAX, num1
		call WriteDec
		mov EDX, OFFSET dia4
		call WriteString
		mov EAX, num2
		call WriteDec
		mov EDX, OFFSET questionmark
		call WriteString
		call Crlf
		call ReadDec

		cmp ans, eax
		je correct
		jmp incorrect

	correct:
		call Crlf
		mov EDX, OFFSET correctmsg
		call WriteString
		call Crlf
		call Crlf
		dec bossHealth
		cmp bossHealth, 0
		je killed
		jmp fightloop

	incorrect:
		call Crlf
		mov EDX, OFFSET incorrectmsg
		call WriteString
		call Crlf
		call Crlf
		dec playerHealth
		cmp playerHealth, 0
		je died
		jmp fightloop
	
	killed:
		mov EDX, OFFSET BossDeath
		call WriteString
		jmp ended

	died:
		mov EDX, OFFSET playerDeath
		call WriteString
		jmp ended
	
	diedtoitem:
		mov EDX, OFFSET BossDeathtoitem
		call WriteString
		call Crlf
		call readDEc

	ended:
	

	ret
scene2 ENDP


main PROC ; calls all necessary procedures and pushes data to the stack for use by procedures.

	Intro:
		call clearScreen
		call introduction

	Scenes1:
		call clearScreen
		call scene1

	Scenes2:
		call clearScreen
		call scene2
		cmp playerhealth, 0
		je ENDGAME
		

	ENDGAME:
		call clearScreen
		mov edx, OFFSET gameOver
		call WriteString
		call Crlf
		call ReadDec
		cmp eax, 1
		je restart
		jmp endGAMES

	restart:
		mov playerHealth, 3
		mov bossHealth, 3
		mov numOfItems, 0
		jmp Intro

	endGAMES:

	exit 
main ENDP
END main




