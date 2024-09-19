.MODEL SMALL
.STACK 100
.DATA

	STR1 DB "1.Search by title$"
	STR2 DB "2.Search by author$"
	STR3 DB "3.Search by genre$"
	STR4 DB "You have select $"
	STR5 DB "Please enter the book title: $"
	STR6 DB "TITLE : $"
	STR7 DB "PRICE : $"
	STR8 DB "LEFT_QUANTITY : $"
	STR9 DB "GENRE : $"
	STR10 DB "AUTHOR : $"
	STR11 DB "Here are the Horror books.$"
	STR12 DB "Here are the Romance books.$"
	STR13 DB "Here are the Adventure books.$"
	STR14 DB "Here are the Non-Fiction books.$"
	STR15 DB "Here are the Education books.$"
    STR16 DB "Please enter the author last name (LOKE XIN YEE = LOKE): $"
	STR17 DB "MENU$"
	STR18 DB "SEARCH BY BOOK TITLE$"
	STR19 DB "SEARCH BY BOOK GENRE$"
	STR20 DB "SEARCH BY BOOK AUTHOR$"
	STR21 DB "4.Display All$"
	STR22 DB "ALL BOOK$"
	QUE1 DB "Enter your choice: $"
	QUE2 DB "Enter your choice (Enter 1 for Horror): $"
	QUE3 DB "Do you want to search for another? : $"
	E1 DB "Invalid input. Please enter again.$"
	E2 DB "Cannot found the book title. Please enter again.$"
	E3 DB "Cannot found the author. Please enter again.$"
	ANS1 DB ?
    ANS2 DB ?
	ANS3 DB ?
	HUN DB 100
	TEN DB 10
	NL DB 0AH,0DH,"$"
	LINE DB "---------------------------$"
	SPACE DB ' '

	;Book name
	WHISPERS    DB "Whispers$"
	ECHO        DB "Echo $"
	LOCKET      DB "Locket $"
	WILLOW      DB "Willow $"
	RENDEZVOUS  DB "Rendezvous $"
	CRIMSON     DB "Crimson $"
	SHADOWS     DB "Shadows $"
	MEMORIES    DB "Memories $"

	BOOKNAME DW OFFSET WHISPERS, OFFSET ECHO, OFFSET Locket, OFFSET Willow, OFFSET Rendezvous, OFFSET Crimson, OFFSET SHADOWS, OFFSET Memories

	BOOKNAME1 DB "7WHISPERS$", "4ECHO$", "6LOCKET$", "6WILLOW$", "10RENDEZVOUS$", "7CRIMSON$", "7SHADOWS$", "8MEMORIES$"

	;Book Price(Floating number)
	BOOKPRICE DD OFFSET 10.5, OFFSET 25.3, OFFSET 16.0, OFFSET 17.9, OFFSET 10.5, OFFSET 12.2, OFFSET 13.0, OFFSET 15.4

	;Book Quantity
	LEFTQUANTITY DW OFFSET 155, OFFSET 288, OFFSET 123, OFFSET 262, OFFSET 165, OFFSET 256, OFFSET 278, OFFSET 132

	KWY DB "Koh Win Yee$"
	CJY DB "Chiam Jian Yu$"
	LZY DB "Lau Zi Lin$"
	LXY DB "Loke Xin Yee$"

	AUTHOR DW OFFSET KWY, OFFSET KWY, OFFSET CJY, OFFSET CJY, OFFSET LZY, OFFSET LZY, OFFSET LXY, OFFSET LXY

	AUTHOR1 DB "3KOH$","5CHIAM$","3LAU$","4LOKE$"

	;Genre
	H DB "Horror$"
    R DB "Romance$"
    A DB "Adventure$"
    N DB "Non-fiction$"
    E DB "Education$"

	GENRE DW OFFSET R, OFFSET H, OFFSET A, OFFSET E, OFFSET R, OFFSET N, OFFSET H, OFFSET R, OFFSET A, OFFSET E

	H1 DB "Horror$"
    R1 DB "Romance$"
    A1 DB "Adventure$"
    N1 DB "Non-fiction$"
    EDUC DB "Education$"

	STR LABEL BYTE
	MAXS DB 50
	ACTS DB ?
	INPUTSTR DB 50 DUP("$")	 

	;floating point display data
    factor DW 10       ; Scaling factor for displaying
	result DW 0       ; Define the result variable as a 16-bit word
	strResult DB 12 DUP ('$')  ; Buffer to store the string representation

	THO DW 1000
	TTH DW 10000
	fraction_count DB 0

	;TEMP REGISTERS?
	TAX DB ?
	TBX DB ?
	TCX DB ?
	TDX DB ?
	TDI DW ?
	TSI DW ?
	TAA DB ?     
	
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

	CALL MENU 

	CONTINUE_9:

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,QUE3
	INT 21H

	;get input
	MOV AH,01H
	INT 21H
	MOV ANS3,AL

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	CMP ANS3,'Y'
	JNE FIN_M

	CALL MENU    

	FIN_M:
	MOV AX,4C00H
	INT 21H

MAIN ENDP

AUTHOR_F PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR20
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	AUTHOR_L:
	;Ask user enter the author name
	LEA DX,NL
	INT 21H

	LEA DX,STR16
	INT 21H

	;get input in string
	MOV AH,0AH
	LEA DX,STR
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Compare with KOH
	KOH_CBC:
	MOV CL,ACTS
	MOV SI,1
	MOV DI,0
	MOV BL,0
	KOH:

		MOV BH,AUTHOR1[SI]
		CMP INPUTSTR[DI],BH
		JNE CHIAM_CBC

		INC SI
		INC DI
		INC BL

	LOOP KOH

		KOH_LENGTH:
		MOV SI,0
		MOV DL,BL
		ADD DL,30H
		CMP DL,AUTHOR1[SI]
		JNE CHIAM_CBC

		JMP WP

    ;Compare with CHIAM
	CHIAM_CBC:
	MOV CL,ACTS
	MOV SI,6
	MOV DI,0
	MOV BL,0
	CHIAM:

		MOV BH,AUTHOR1[SI]
		CMP INPUTSTR[DI],BH
		JNE LAU_CBC

		INC SI
		INC DI
		INC BL

	LOOP CHIAM

		CHIAM_LENGTH:
		MOV SI,5
		MOV DL,BL
		ADD DL,30H
		CMP DL,AUTHOR1[SI]
		JNE LAU_CBC

		JMP LK

    ;Compare with LAU
	LAU_CBC:
	MOV CL,ACTS
	MOV SI,13
	MOV DI,0
	MOV BL,0
	LAU:

		MOV BH,AUTHOR1[SI]
		CMP INPUTSTR[DI],BH
		JNE LOKE_CBC

		INC SI
		INC DI
		INC BL

	LOOP LAU

		LAU_LENGTH:
		MOV SI,12
		MOV DL,BL
		ADD DL,30H
		CMP DL,AUTHOR1[SI]
		JNE LOKE_CBC

		JMP RD

    ;Compare with LOKE
	LOKE_CBC:
	MOV CL,ACTS
	MOV SI,18
	MOV DI,0
	MOV BL,0
	LOKE:

		MOV BH,AUTHOR1[SI]
		CMP INPUTSTR[DI],BH
		JNE ER

		INC SI
		INC DI
		INC BL

	LOOP LOKE

		LOKE_LENGTH:
		MOV SI,17
		MOV DL,BL
		ADD DL,30H
		CMP DL,AUTHOR1[SI]
		JNE ER

		JMP SD
        

	ER:
	JMP ERROR_A

	WP:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;WHISPERS
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,0
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,0
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,0
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,0
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 

    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H

	EH:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;ECHO
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,2
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,1
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,2
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,2
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 

    JMP CONTINUE_9

	LK:
    MOV AH,09H 
	LEA DX,STR6
	INT 21H

	;LOCKET
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,4
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,2
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup   

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,4
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,4
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 

    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H


	WL:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;WILLOW
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,6
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,3
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,6
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,6
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	
	JMP CONTINUE_9

	RD:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,8
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,4
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,8
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,8
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 

    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H


	CR:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;CRIMSON
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,10
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,5
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,10
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,10
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	
	JMP CONTINUE_9

	SD:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,12
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,6
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,12
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,12
	MOV AX, [SI]            
	MOV DX, AX             
	MOV AH, 09H           
	INT 21H 
	
    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H

	MM:
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,14
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,7
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup   

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,14
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book Genre
	MOV SI,OFFSET GENRE
	ADD SI,14
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H  
	
	JMP CONTINUE_9
	

	;Invalid input
	ERROR_A:
			MOV AH,09H
			LEA DX,E3
			INT 21H

			LEA DX,NL
			INT 21H
			JMP AUTHOR_L


	FIN_A:
	MOV AX,4C00H
	INT 21H

AUTHOR_F ENDP

TITLE_F PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR18
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	TITLE_L:
	;Ask user enter the book title
	LEA DX,NL
	INT 21H

	LEA DX,STR5
	INT 21H

	;get input in string
	MOV AH,0AH
	LEA DX,STR
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Compare with WHISPERS
	WHISPERS_CBC:
	MOV CL,ACTS
	MOV SI,1
	MOV DI,0
	MOV BL,-1
	L2:

		MOV BH,BOOKNAME1[SI]
		CMP INPUTSTR[DI],BH
		JNE ECHO_CBC

		INC SI
		INC DI
		INC BL

	LOOP L2

		WHISPERS_LENGTH:
		MOV SI,0
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE ECHO_CBC

		JMP WP1


	;Compare with ECHO
	ECHO_CBC:
	MOV CL,ACTS
	MOV SI,11
	MOV DI,0
	MOV BL,0
	L3:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE LOCKET_CBC

		INC SI
		INC DI
		INC BL

	LOOP L3

		ECHO_LENGTH:
		MOV SI,10
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE LOCKET_CBC

		JMP EH1

	;Compare with LOCKET
	LOCKET_CBC:
	MOV CL,ACTS
	MOV SI,17
	MOV DI,0
	MOV BL,0
	L4:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE WILLOW_CBC

		INC SI
		INC DI
		INC BL

	LOOP L4

		LOCKET_LENGTH:
		MOV SI,16
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE WILLOW_CBC

		JMP LK1

	;Compare with WILLOW
	WILLOW_CBC:
	MOV CL,ACTS
	MOV SI,25
	MOV DI,0
	MOV BL,0
	L5:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE RD_CBC

		INC SI
		INC DI
		INC BL

	LOOP L5

		WILLOW_LENGTH:
		MOV SI,24
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE RD_CBC

		JMP WL1

	;Compare with Rendezvous
	RD_CBC:
	MOV CL,ACTS
	MOV SI,34
	MOV DI,0
	MOV BX,0
	L6:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE CRIMSON_CBC

		INC SI
		INC DI
		INC BX

	LOOP L6

		;ERROR CODE
		;MOV SI,32
		;MOV DL,BL
		;ADD DL,30H
		;CMP DL,BOOKNAME1[SI]
		;JNE E

		JMP RD1

	;Compare with Crimson
	CRIMSON_CBC:
	MOV CL,ACTS
	MOV SI,46
	MOV DI,0
	MOV BL,0
	L7:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE SHADOWS_CBC

		INC SI
		INC DI
		INC BL

	LOOP L7

		CRIMSON_LENGTH:
		MOV SI,45
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE SHADOWS_CBC

		JMP CR1

	;Compare with SHADOWS
	SHADOWS_CBC:
	MOV CL,ACTS
	MOV SI,55
	MOV DI,0
	MOV BL,0
	L8:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE MEMORIES_CBC

		INC SI
		INC DI
		INC BL

	LOOP L8

		SHADOWS_LENGTH:
		MOV SI,54
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE MEMORIES_CBC

		JMP SD1

	;Compare with MEMORIES
	MEMORIES_CBC:
	MOV CL,ACTS
	MOV SI,64
	MOV DI,0
	MOV BL,0
	L9:

		MOV AL,BOOKNAME1[SI]
		CMP INPUTSTR[DI],AL
		JNE ER2

		INC SI
		INC DI
		INC BL

	LOOP L9

		MEMORIES_LENGTH:
		MOV SI,63
		MOV DL,BL
		ADD DL,30H
		CMP DL,BOOKNAME1[SI]
		JNE ER2

		JMP MM1

	ER2:
		JMP ERROR_T


	WP1:

	MOV AH,09H
	LEA DX,STR6
	INT 21H

	;WHISPERS
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,0
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,0
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,0
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,0
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 

    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H
	JMP CONTINUE_9

	EH1:

	 MOV AH,09H
	LEA DX,STR6
	INT 21H

	;ECHO
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,2
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,1
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,2
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,2
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP CONTINUE_9


	LK1:

	MOV AH,09H 
	LEA DX,STR6
	INT 21H

	;LOCKET
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,4
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,2
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup      

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,4
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,4
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H  
	JMP CONTINUE_9

	WL1:

	MOV AH,09H
	LEA DX,STR6
	INT 21H

	;WILLOW
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,6
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,3
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,6
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,6
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP CONTINUE_9

	RD1:

	MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,8
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,4
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,8
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,8
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 

    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H
	JMP CONTINUE_9

	CR1:

	MOV AH,09H
	LEA DX,STR6
	INT 21H

	;CRIMSON
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,10
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,5
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup      

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,10
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,10
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP CONTINUE_9

	SD1:

	MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,12
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,6
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,12
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book genre
	MOV SI,OFFSET GENRE
	ADD SI,12
	MOV AX, [SI]            
	MOV DX, AX             
	MOV AH, 09H           
	INT 21H 
	
    MOV AH,09H
    LEA DX,NL
	INT 21H

    MOV AH,09H
    LEA DX,NL
	INT 21H
	JMP CONTINUE_9

	MM1:

	MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,14
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,7
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,14
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR9
	INT 21H

	;Display book Genre
	MOV SI,OFFSET GENRE
	ADD SI,14
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H  
	
	JMP CONTINUE_9

	;Invalid input
	ERROR_T:
			MOV AH,09H
			LEA DX,E2
			INT 21H

			LEA DX,NL
			INT 21H
			JMP TITLE_L

TITLE_F ENDP

GENRE_F PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,NL
    INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
    INT 21H

	LEA DX,STR19
    INT 21H

	LEA DX,NL
    INT 21H

	LEA DX,LINE
    INT 21H

	GENRE_L:
	LEA DX,NL
    INT 21H

    LEA DX,H1
    INT 21H

    LEA DX,NL
    INT 21H

    LEA DX,R1
    INT 21H

    LEA DX,NL
    INT 21H

    LEA DX,A1
    INT 21H

    LEA DX,NL
    INT 21H

    LEA DX,N1
    INT 21H

    LEA DX,NL
    INT 21H

    LEA DX,EDUC
    INT 21H

    LEA DX,NL
    INT 21H

	LEA DX,NL
    INT 21H

	;ask user enter thier choose
	LEA DX,QUE2
	INT 21H

	;get input
	MOV AH,01H
	INT 21H
	SUB AL,30H
	MOV ANS2,AL

	MOV AH,09H
	LEA DX,NL
	INT 21H

	CMP ANS2,1
	JAE CONTINUE_3 
	JMP ERROR_G     

	CONTINUE_3:
	CMP ANS2,5
	JBE CONTINUE_4  
	JMP ERROR_G      

	CONTINUE_4:
   	MOV AH,09H
	LEA DX,STR4
	INT 21H

	MOV AH,02H
	MOV DL,ANS2
	ADD DL,30H
	INT 21H

	MOV AH,09H 
	LEA DX,NL
	INT 21H

	;If user enter 1 display Horror book
	CMP ANS2,1
	JE HR

	CMP ANS2,2
	JNE CONTINUE_5

	JMP RM

	CONTINUE_5:
	CMP ANS2,3
	JNE CONTINUE_6

	JMP AV

	CONTINUE_6:
	CMP ANS2,4
	JNE CONTINUE_7

	JMP NF

	CONTINUE_7:
	CMP ANS2,5
	JNE ER3

	JMP ED

	ER3:
	JMP ERROR_G

	;Horror
	HR:
	MOV AH,09H
	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Display what genre now
	LEA DX,STR11
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;ECHO
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,2
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,1
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup       

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,2
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,2
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	
	;SHADOWS
	;Second book
	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,12
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,6
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,12
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,12
	MOV AX, [SI]            
	MOV DX, AX             
	MOV AH, 09H           
	INT 21H 
	JMP CONTINUE_9

	;Romance
	RM:
	MOV AH,09H
	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Display what genre now
	LEA DX,STR12
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;WHISPERS
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,0
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,0
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,0
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,0
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	
	;MEMORIES
	;Second book
	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,14
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,7
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,14
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,14
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	
	;RENDEZVOUS
	;Third book
	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,8
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,4
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,8
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,8
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP CONTINUE_9

	;Adventure
	AV:
	MOV AH,09H
	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Display what genre now
	LEA DX,STR13
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;LOCKET
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,4
	MOV AX, [SI]             ; Load the offset of the second book name into AX
	MOV DX, AX               ; Move the offset into DX (required for INT 21H)
	MOV AH, 09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,2
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,4
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,4
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP FIN_G

	;Non-fiction
	NF:
	MOV AH,09H
	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Display what genre now
	LEA DX,STR14
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;CRIMSON
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,10
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,5
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup    

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,10
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,10
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP CONTINUE_9

	;Education
	ED:
	MOV AH,09H
	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Display what genre now
	LEA DX,STR15
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR6
	INT 21H

	;WILLOW
	;Display bookname
	MOV SI,OFFSET BOOKNAME
	ADD SI,6
	MOV AX,[SI]             ; Load the offset of the second book name into AX
	MOV DX,AX               ; Move the offset into DX (required for INT 21H)
	MOV AH,09H              ; DOS print string function
	INT 21H      

	LEA DX,NL
	INT 21H 

	LEA DX,STR7
	INT 21H  
	
	;Display bookprice
	;Price
    ; Load the floating-point values into the FPU and multiply
	MOV DI,3
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup     

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR8
	INT 21H

	;Display left quantity
	MOV SI,6
	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
	DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR10
	INT 21H

	;Display book author
	MOV SI,OFFSET AUTHOR
	ADD SI,6
	MOV AX,[SI]            
	MOV DX,AX             
	MOV AH,09H           
	INT 21H 
	JMP CONTINUE_9

	ERROR_G:
			MOV AH,09H
			LEA DX,E1
			INT 21H

			LEA DX,NL
			INT 21H
			JMP GENRE_L

	FIN_G:
	MOV AX,4C00H
	INT 21H

GENRE_F ENDP

MENU PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR17
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	;Display the menu
	MOV AH,09H
	LEA DX,STR1
	INT 21H
	
	LEA DX,NL
	INT 21H

	LEA DX,STR2
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR3
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR21
	INT 21H

	LEA DX,NL
	INT 21H

	;ask user enter thier choose
	MOV AH,09H
	LEA DX,QUE1
	INT 21H

	;get input
	MOV AH,01H
	INT 21H
	SUB AL,30H
	MOV ANS1,AL

	MOV AH,09H
	LEA DX,NL
	INT 21H

	CMP ANS1, 1
	JAE CONTINUE_1  ; Jump if ANS1 >= 1
	JMP ERROR       ; If not, jump to ERROR

	CONTINUE_1:
	; Validation if ans1 > 3
	CMP ANS1, 4
	JBE CONTINUE_2  ; Jump if ANS1 <= 3
	JMP ERROR      ; If not, jump to ERROR

		
	CONTINUE_2:
	;Display the selected option
	MOV AH,09H
	LEA DX,STR4
	INT 21H

	MOV AH,02H
	MOV DL,ANS1
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	OP1:
	CMP ANS1,1
	JNE OP2

	CALL TITLE_F

	OP2:
	CMP ANS1,2
	JNE OP3

	CALL AUTHOR_F

	OP3:
	CMP ANS1,3
	JNE OP4

	CALL GENRE_F

	OP4:
	CMP ANS1,4
	JNE ERROR

	CALL D_ALL

	;Invalid input
	ERROR:
			MOV AH,09H
			LEA DX,E1
			INT 21H

			LEA DX,NL
			INT 21H
			JMP FIN


	FIN:
	MOV AX,4C00H
	INT 21H

MENU ENDP

D_ALL PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,STR20
	INT 21H

	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

MOV CX,8
MOV SI,0
MOV DI,0
DISPLAY:    
    MOV AH,09H
	LEA DX,STR6
	INT 21H

	;Display bookname
	MOV AX, [BOOKNAME + SI]   ; Get the address of the book name
	MOV DX, AX                ; Move the address to DX for printing
	MOV AH, 09H               ; DOS function to print string
	INT 21H  

	MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,STR7
	INT 21H  
	
	;Price
    ; Load the floating-point values into the FPU and multiply
    FLD DWORD PTR [BOOKPRICE[DI]]  ; Load num1 into the FPU stack
    FILD WORD PTR [factor] ; Load factor
    FMUL                  ; Multiply result by factor to scale
    FISTP result          ; Store integer part in result

    CALL DISPF  ;below no need, do until here is cukup

    ;Display left quantity
	CALL CALCULATION_QUANTITY

	D_SECOND:

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,STR9
	INT 21H

	MOV AX, [GENRE + SI]   ; Get the address of the book name
	MOV DX, AX                ; Move the address to DX for printing
	MOV AH, 09H               ; DOS function to print string
	INT 21H 

	MOV AH,09H
	LEA DX,NL
	INT 21H

    MOV AH,09H
	LEA DX,STR10
	INT 21H

	;Display book author
	MOV AX, [AUTHOR + SI]     ; Get the address of the author
	MOV DX, AX
	MOV AH, 09H
	INT 21H

    MOV AH,09H
	LEA DX,NL
	INT 21H

	LEA DX,LINE
	INT 21H

	LEA DX,NL
	INT 21H

    ADD SI, 2
LOOP DISPLAY


	JMP CONTINUE_9

D_ALL ENDP

DISPF PROC
    ; Preserve registers
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH SI

	MOV fraction_count,0

    ; Load the value of 'result' into AX (assuming result is 16-bit)
    MOV AX, result       ; AX now holds the value, e.g., 15000

    ; Division by 10000 to extract the ten-thousands place
    MOV CX, TTH         ; Divisor for ten-thousands
    XOR DX, DX            ; Clear DX to avoid overflow
    DIV CX                ; AX = AX / 10000, DX = remainder
    MOV TAX, AL         ; Store the ten-thousands digit in TAX
    MOV AX, DX            ; AX now holds the remainder

    ; Division by 1000 to extract the thousands place
    MOV CX, THO          ; Divisor for thousands
    XOR DX, DX            ; Clear DX
    DIV CX                ; AX = AX / 1000, DX = remainder
    MOV TBX, AL         ; Store the thousands digit in TBX
    MOV AX, DX            ; AX now holds the remainder

    ; Division by 100 to extract the hundreds place
	XOR CX,CX
    MOV CL, HUN           ; Divisor for hundreds
    XOR DX, DX            ; Clear DX
    DIV CX                ; AX = AX / 100, DX = remainder
    MOV TCX, AL         ; Store the hundreds digit in TCX
    MOV AX, DX            ; AX now holds the remainder

    ; Division by 10 to extract the tens place
	XOR CX,CX
    MOV CL, TEN            ; Divisor for tens
    XOR DX, DX            ; Clear DX
    DIV CX                ; AX = AX / 10, DX = remainder
    MOV TDX, AL         ; Store the tens digit in TDX
    MOV TAA, DL         ; Store the remainder (units place) in TSI

    ; Print the ten-thousands digit (if it's not zero)
    CMP TAX, 0
    JZ SkipTenThousands   ; If the ten-thousands digit is 0, skip it
	INC fraction_count
    MOV AL, TAX         ; Load the ten-thousands digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

SkipTenThousands:

    ; Print the thousands digit
	CMP fraction_count,1
	JGE NO_NEED_SKIP_TEN_THOUSANDS
    CMP TBX, 0
    JZ SkipThousands      ; If the thousands digit is 0, skip it (after 10000 case)
	NO_NEED_SKIP_TEN_THOUSANDS:
	INC fraction_count
    MOV AL, TBX         ; Load the thousands digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

SkipThousands:

    ; Print the hundreds digit
	CMP fraction_count,1
	JGE NO_NEED_SKIP_THOUSANDS
    CMP TCX, 0
    JZ SkipHundreds       ; If the hundreds digit is 0, skip it (after 1000 case)
	NO_NEED_SKIP_THOUSANDS:
	INC fraction_count
    MOV AL, TBX         ; Load the thousands digit
    MOV AL, TCX         ; Load the hundreds digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

SkipHundreds:

    ; Print the tens digit
    MOV AL, TDX         ; Load the tens digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

	;Print the decimal point (for floating-point representation, if needed)
    MOV AH, 02H
    MOV DL, '.'
    INT 21H

    ; Print the units digit
    MOV AL, TAA         ; Load the units digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

	MOV AH,02H
	MOV DL,'0'
	INT 21H

    ; Restore registers
    POP SI
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
	RET
DISPF ENDP

CALCULATION_QUANTITY PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,STR8
	INT 21H

 	MOV AH,0H
	MOV AX,LEFTQUANTITY[SI]
    DIV HUN
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV AH,0H
	MOV AL,BH
	DIV TEN 
	MOV BX,AX

	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H
	
	MOV DL,BH
	ADD DL,30H
	INT 21H

	JMP D_SECOND

CALCULATION_QUANTITY ENDP

END MAIN

