TITLE Assignment1	(Project1.asm)
;Ethan Peterson 4/13/23

Description:
; This program displays my name and description of the program
; as well as takes two integers from the user and returns the 
; sum, product, difference, and quotient with the remainder
; It will finally display a terminating message.

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096 ;SS register
ExitProcess proto,dwExitCode:dword

.data
	into1    BYTE	 "Name: Ethan Peterson, Title: Assignment1 (sum, product, difference, quotient)", 0
	instrc1  BYTE   "The program will ask for two integers.", 0
	instrc2  BYTE   "Once provided, it will display the sum, product, difference, and quotient with the remainder of the two integers.", 0
	prompt1  BYTE   "Please enter a your first integer", 0
	prompt2  BYTE   "Please enter your second integer", 0
	prompt3  BYTE   "SUM: ", 0
	prompt4  BYTE   "DIFFERENCE: ", 0
	prompt5  BYTE   "PRODUCT: ", 0
	prompt6  BYTE   "QUOTIENT: ", 0
	prompt7  BYTE   " REMAINDER: ", 0
	term1    BYTE   "Thank you for using my program!", 0
	int1     dword  ?
	int2     dword  ?
	addVal   dword  ?
	subVal   dword  ?
	multVal  dword  ?
	divVal  dword  ?
	divRemainder  dword ?
	finalVal dword  ?

.code
main PROC
	Introduction:				;displays greeting message as well as instruction for the program
		mov  EDX, OFFSET into1
		call  WriteString
		call  Crlf
		call  Crlf

		mov  EDX, OFFSET instrc1
		call  WriteString
		call  Crlf
		
		mov  EDX, OFFSET instrc2
		call  WriteString
		call  Crlf
		call  Crlf
	
	Get_integers:				;gets integers from the user and stores them in respective variables
		mov  EDX, OFFSET prompt1
		call  WriteString
		call  Crlf
		call ReadInt
		mov int1, EAX

		mov  EDX, OFFSET prompt2
		call  WriteString
		call  Crlf
		call ReadInt
		mov int2, EAX
		call  Crlf

	Calculations:				;calculates each operation for the two integers given by user
		mov EAX, int1
		add EAX, int2
		mov addVal, EAX

		mov EAX, int1
		sub EAX, int2
		mov subVal, EAX

		mov EAX, int1
		mov EBX, int2
		mul EBX
		mov multVal, EAX

		mov EAX, int1
		mov EBX, int2
		xor EDX, EDX
		div ebx
		mov divVal, EAX
		mov divRemainder, EDX

	Results:
		mov EDX, OFFSET prompt3
		call WriteString
		mov EAX, addVal
		call WriteDec
		call Crlf
		call Crlf

		mov EDX, OFFSET prompt4
		call WriteString
		mov EAX, subVal
		call WriteDec
		call Crlf
		call Crlf

		mov EDX, OFFSET prompt5
		call WriteString
		mov EAX, multVal
		call WriteDec
		call Crlf
		call Crlf

		mov EDX, OFFSET prompt6
		call WriteString
		mov EAX, divVal
		call WriteDec
		mov EDX, OFFSET prompt7
		call WriteString
		mov EAX, divRemainder
		call WriteDec
		call Crlf
		call Crlf
		
	Goodbye:
		mov EDX, OFFSET term1
		call WriteString
		call Crlf
		call Crlf
		

	invoke ExitProcess,0
main ENDP
END main