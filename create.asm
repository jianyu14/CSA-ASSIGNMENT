.MODEL SMALL
.STACK 100
.DATA
    ; Book (10)
    Whispers    DB "Whispers", 0AH,0DH, "$"
    Echo        DB "Echo", 0AH,0DH, "$"
    Locket      DB "Locket", 0AH,0DH, "$"
    Willow      DB "Willow", 0AH,0DH, "$"
    Rendezvous  DB "Rendezvous", 0AH,0DH, "$"
    Crimson     DB "Crimson", 0AH,0DH, "$"
    Shadows     DB "Shadows", 0AH,0DH, "$"
    Memories    DB "Memories", 0AH,0DH, "$"

    BOOK DW OFFSET Whispers, OFFSET Echo, OFFSET Locket, OFFSET Willow
         DW OFFSET Rendezvous, OFFSET Crimson, OFFSET Shadows, OFFSET Memories

    ;Book Price(Floating number)
    WhispersP    DD 10.5
    EchP         DD 25.3
	LocketP      DD 16.0
	WillowP      DD 17.9
	RendezvousP  DD 10.5
	CrimsonP     DD 12.2
	ShadowsP     DD 13.0
	MemoriesP    DD 15.4

    Price DD 10.5,25.3,16.0,17.9,10.5,12.2,13.0,15.4

    ;Book left quantity
   	WhispersQ    DW 155
	EchQ         DW 288
	LocketQ      DW 123
	WillowQ      DW 262
	RendezvousQ  DW 165
	CrimsonQ     DW 256
	ShadowsQ     DW 278
	MemoriesQ    DW 132

LeftQuantity DW 155,288,123,262,165,256,278,132,265,164



    CREATE_HEADER DB "CREATE ORDER", 0AH,0DH, "$"
    ORDER_INPUT_TITLE DB "Enter the option to order a book (1-8): $"
    INVALID_OPTION DB 0AH,0DH,"Invalid option. Please try again. (1-8)", 0AH,0DH, "$"
    BOOK_QUANTITY_TITLE DB 0AH,0DH,"Enter the quantity to order your book: $"
    INVALID_QUANTITY DB 0AH,0DH,"Invalid quantity. Please try again. (Quantity must at least be 1)", 0AH,0DH, "$"

    QUANTITY_OFFSET DB ?
    BOOK_ORDER_QUANTITY DB 8 DUP(0)

    ;output db      "The current date is: "
    ;date db      "00/00/0000", 0dh, 0ah
    ;     db      "The current time is: "
    ;time db      "00:00:00", 0dh, 0ah, '$'

    ;ORDER_INPUT LABEL BYTE
	;MAXN_ORDER_INPUT DB 10
	;ACTN_ORDER_INPUT DB ?
	;INPUTSTR DB 8 DUP("$")
    QUANTITY_INPUT DB ?
    OPTION DB ?
    TEN DB 10
    errorMsg db 0AH,0DH, "Invalid option. Please enter valid option (1-8). $"
    NL DB 0AH,0DH, "$"      ; New line character

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Print header
    MOV AH,09H     
    LEA DX,CREATE_HEADER
    INT 21H

    ; Print new line
    MOV AH,09H
    LEA DX,NL
    INT 21H

    ; Loop through BOOK array and print each string with its number (1-8)
    MOV CX, 8            ; size of book array
    MOV SI, 0            ; Index for BOOK array
    MOV BX, 1            ; Counter for book numbers (1-8)

    BOOK_LIST:
        ; Print the book number
        MOV DL, BL           ; Load the book number into DL
        ADD DL, 30H          ; Convert number to ASCII ('1' - '8')
        MOV AH, 02H          ; DOS interrupt to print character
        INT 21H

        ; Print a period and space after the number
        MOV DL, '.'
        INT 21H
        MOV DL, ' '
        INT 21H

        ; Print the book name
        MOV AH, 09H          ; DOS interrupt to print string
        MOV DX, BOOK[SI]           ; Load the string address into DX
        INT 21H

        ADD SI, 2            ; Move to the next pointer (each is 2 bytes)
        INC BX               ; Increment book number
    LOOP BOOK_LIST

    CREATE_ORDER:
        MOV AH,09H
        LEA DX,ORDER_INPUT_TITLE
        INT 21H

        ; Prompt user to enter a book option
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV OPTION, AL

        ; Validate the input (should be between 1 and 8)
        CMP OPTION, 1
        JL INVALID_OPTION_INPUT

        CMP OPTION, 8
        JG INVALID_OPTION_INPUT

        MOV AL, OPTION      ; Move option to AL
        DEC AL              ; Subtract 1 (since options are 1-based, array is 0-based)
        MOV AH, 0
        MOV BX,AX
        MOV SI, BX          ; Move to SI (index)
        SHL SI, 1           ; Multiply by 2 to get correct offset (each entry is 2 bytes)
        
        MOV DI, 0           ;MOV QUANTITY_OFFSET,DI
        MOV CX,8
        FIND_QUANTITY_LABEL:
            CMP BX,DI
            JE ORDER_QUANTITY_INPUT
            INC DI
        LOOP FIND_QUANTITY_LABEL

        MOV AH, 09H         
        MOV DX, BOOK[SI]    ; Load the address of the selected book              
        INT 21H

        JMP FINISH

    INVALID_OPTION_INPUT:
        ; Print invalid option message
        MOV AH, 09H
        LEA DX, INVALID_OPTION
        INT 21H
        JMP CREATE_ORDER     ; Prompt the user to enter the option again        

        JMP FINISH

    ORDER_QUANTITY_INPUT:
        MOV AH,09H
        LEA DX,BOOK_QUANTITY_TITLE
        INT 21H

        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV QUANTITY_INPUT,AL

        CMP QUANTITY_INPUT,0
        JLE INVALID_QUANTITY_INPUT

        CMP QUANTITY_INPUT,9
        JG INVALID_QUANTITY_INPUT

        MOV BL,QUANTITY_INPUT
        MOV BOOK_ORDER_QUANTITY[DI],BL

        MOV AH,02H
        MOV DL,BOOK_ORDER_QUANTITY[DI]
        ADD DL,30H
        INT 21H

    JMP FINISH

    INVALID_QUANTITY_INPUT:
        MOV AH,09H
        LEA DX,INVALID_QUANTITY
        INT 21H

        JMP CREATE_ORDER

    FINISH:
        MOV AX, 4C00H
        INT 21H
MAIN ENDP
END MAIN