.MODEL SMALL
.STACK 100
.DATA
    ; Book (10)
    Whispers    DB "Whispers", 10, "$"
    Echo        DB "Echo", 10, "$"
    Locket      DB "Locket", 10, "$"
    Willow      DB "Willow", 10, "$"
    Rendezvous  DB "Rendezvous", 10, "$"
    Crimson     DB "Crimson", 10, "$"
    Shadows     DB "Shadows", 10, "$"
    Memories    DB "Memories",10,"$"
    Serenade    DB "Serenade",10,"$"
    Dream       DB "Dream",10,"$"

    BOOK DW OFFSET Whispers, OFFSET Echo, OFFSET Locket, OFFSET Willow
         DW OFFSET Rendezvous, OFFSET Crimson, OFFSET Shadows
         DW OFFSET Memories, OFFSET Serenade, OFFSET Dream

    CREATE_HEADER DB "CREATE ORDER", 10, "$"
    ORDER_INPUT_TITLE DB "Enter the option to order a book (1-10): $"
    INVALID_OPTION DB "Invalid option, please try again.", 10, "$"

    ORDER_INPUT LABEL BYTE
	MAXN_ORDER_INPUT DB 10
	ACTN_ORDER_INPUT DB ?
	INPUTSTR DB 10 DUP("$")

    num1 DB ?
    num2 DB ?
    OPTION DB ?
    TEN DB 10
    errorMsg db 10,13,"Invalid input! Please enter digits only.$"
    resultMsg db 10,13,"The combined number is: $"
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

    ; Loop through BOOK array and print each string with its number (1-10)
    MOV CX, 10           ; size of book array
    MOV SI, 0            ; Index for BOOK array

BOOK_LIST:
    ; Print the book name
    MOV AH, 09H          ; DOS interrupt to print string
    MOV DX, BOOK[SI]           ; Load the string address into DX
    INT 21H

    ADD SI, 2            ; Move to the next pointer (each is 2 bytes)
LOOP BOOK_LIST

CREATE_ORDER:
    ; Prompt user to enter a book option
    MOV AH, 09H
    LEA DX, ORDER_INPUT_TITLE
    INT 21H

getFirstDigit:
    MOV AH,01H    ; Read character from input
    INT 21H
    SUB AL,30H
    CMP AL, 0   ; Validate if it's between '0' and '9'
    JB invalidInput
    CMP AL, 9
    JA invalidInput
    MOV num1, AL  ; Store the first digit in num1

    ; Get the second digit
getSecondDigit:
    MOV AH,01H    ; Read character from input
    INT 21H
    SUB AL, 30H
    CMP AL, 0AH
    JE SINGLE_DIGIT
    CMP AL, 0   ; Validate if it's between '0' and '9'
    JB invalidInput
    CMP AL, 9
    JA invalidInput
    MOV num2, AL  ; Store the second digit in num2

    ; Combine the two digits (num1 * 10 + num2)
    MOV AL, num1
    MOV AH, 0
    MOV BL, 10
    MUL BL         ; Multiply num1 by 10
    ADD AL, num2   ; Add num2 to form the combined number
    MOV OPTION,AL

    JMP CHECK_INPUT_NUM

    SINGLE_DIGIT:
    MOV AL,NUM1
    MOV OPTION,AL
    INT 21H

    ;MOV AH,0

    ;DIV TEN

    ;MOV AH,02H
    ;MOV DL,AH
    ;ADD DL,30H
    ;INT 21H

    ;MOV AH,02H
    ;MOV DL,AL
    ;ADD DL,30H
    ;INT 21H

    

    jmp finish
    invalidInput:
    ; Display error message for invalid input
    MOV DX, OFFSET errorMsg
    MOV AH, 09H
    INT 21H
    JMP MAIN      ; Restart the program

    ; Convert the result to ASCII
    ADD AL, '0'

    ; Display the combined number
    MOV DL, AL
    MOV AH, 02H   ; Function to print character
    INT 21H

    ;MOV AH,0AH     
	;LEA DX,ORDER_INPUT
	;INT 21H

    CHECK_INPUT_NUM:
    MOV SI,0
    MOV CX,10
        MOV AH,0
        MOV AL,OPTION
        CMP AX,BOOK[SI]
        JE PRINT_BOOK
        INC SI
        LOOP CHECK_INPUT_NUM

    ; Get user input
    ;MOV AH,01H           ; Read a single character
    ;INT 21H
    ;SUB AL,30H           ; Convert ASCII input to a numeric value
    ;MOV INPUT,AL         ; Store the input in INPUT

    ; Validate the input (should be between 1 and 10)
    CMP AL, 1
    JL INVALID_INPUT     ; If less than 1, go to invalid input
    CMP AL, 10
    JG INVALID_INPUT     ; If greater than 10, go to invalid input

    ; Select book based on input (subtract 1 from input for zero-indexing)
    DEC AL
    MOV SI, AX           ; Store the user input in SI for index (multiplied by 2)
    ADD SI, SI           ; Multiply index by 2 to get the correct offset in BOOK array

    PRINT_BOOK:
    ; Print the selected book
    MOV BX, BOOK[SI]     ; Load the offset of the selected book
    MOV DX, BX           ; Load the address into DX for printing
    MOV AH, 09H          ; DOS interrupt to print the string
    INT 21H

    JMP FINISH           ; End program

INVALID_INPUT:
    ; Print invalid option message
    MOV AH, 09H
    LEA DX, INVALID_OPTION
    INT 21H
    JMP CREATE_ORDER     ; Prompt the user to enter the option again

FINISH:
    ; Exit program
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN