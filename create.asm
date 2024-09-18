.MODEL SMALL
.STACK 100
.DATA
    ; Book (8)
    Whispers    DB "Whispers        $"
    Echo        DB "Echo            $"
    Locket      DB "Locket          $"
    Willow      DB "Willow          $"
    Rendezvous  DB "Rendezvous      $"
    Crimson     DB "Crimson         $"
    Shadows     DB "Shadows         $"
    Memories    DB "Memories        $"

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

LeftQuantity DW 155,288,123,262,165,256,278,132

    CREATE_HEADER DB 0AH,0DH,0AH,0DH,"CREATE ORDER", 0AH,0DH, "$"
    BOOK_LIST_HEADER DB 'Available Books:', 0DH, 0AH, '$'
    COLUMN_HEADERS DB 'No. Title           Price(RM)   Left Quantity', 0DH, 0AH, '$'
    COLUMN_ORDERED_HEADERS DB 0DH, 0AH,'No. Book Order      Order Quantity', 0DH, 0AH, '$'
    BOOK_NO DB 1
    QUANTITY_COLUMN_SPACE DB '       ', '$'

    ORDER_INPUT_TITLE DB 0AH,0DH,"Enter the option to order book (1-8): $"
    INVALID_OPTION DB 0AH,0DH,"Invalid option. Please enter valid option (1-8). ", 0AH,0DH, "$"
    BOOK_QUANTITY_TITLE1 DB 0AH,0DH,"Enter the quantity to order or edit order quantity ($"
    BOOK_QUANTITY_TITLE2 DB "): $"
    INVALID_QUANTITY DB 0AH,0DH,"Invalid quantity. Please enter 1 or 2 digits number to order or edit order quantity. ", 0AH,0DH, "$"
    ADD_ORDER_TITLE DB 0AH,0DH,"Any other book to order or edit? (Y/N): $"
    INVALID_ORDER DB 0AH,0DH,"Invalid input. You must enter Y/N only. ", 0AH,0DH, "$"
    CONFIRM_ORDER_TITLE DB 0AH,0DH,"Are you sure you want to proceed order? (Y/N): $"

    ;TEMP REGISTERS?
	TAX DB ?
	TBX DB ?
	TCX DB ?
	TDX DB ?
	TDI DW ?
	TSI DW ?
	TAA DB ?

    ;floating point display data
    factor DW 10       ; Scaling factor for displaying
	result DW 0       ; Define the result variable as a 16-bit word

    QUANTITY_OFFSET DB ?
    BOOK_ORDER_QUANTITY DB 8 DUP(0)
    ORDER_QUANTITY_ARRAY_INDEX DB ?

    QUANTITY_INPUT DB ?
    OPTION DB ?
    TEN DB 10
    HUNDRED DB 100
    NL DB 0AH,0DH, "$"      ; New line character

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL CREATE_ORDER
    
    FINISH:
        MOV AX, 4C00H
        INT 21H
MAIN ENDP

CREATE_ORDER PROC
    CREATE_ORDER_START:
        ; Print header
        MOV AH,09H     
        LEA DX,CREATE_HEADER
        INT 21H

        ; Print new line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        CALL DISPLAY_BOOK_LIST
        CALL GET_BOOK_OPTION
        CALL GET_QUANTITY
        CALL ASK_ADD_ORDER
        CMP AL, 'Y'
        JE CREATE_ORDER_START
        CMP AL, 'y'
        JE CREATE_ORDER_START

        MOV AH,09H
        LEA DX, NL
        INT 21H

        CALL DISPLAY_ORDER
        CALL CONFIRM_ORDER

        ;CMP AL, 'Y'
        ;JE PAYMENT FUNCTION
        ;CMP AL, 'y'
        ;JE PAYMENT FUNCTION
        
    RET
CREATE_ORDER ENDP

DISPLAY_BOOK_LIST PROC
    ; Print header
    MOV AH, 09H
    LEA DX, BOOK_LIST_HEADER
    INT 21H

    ; Print column headers
    MOV AH, 09H
    LEA DX, COLUMN_HEADERS
    INT 21H

    ; Loop through BOOK array and print each string with its number (1-8)
    MOV CX, 8            ; size of book array
    MOV SI, 0            ; Index for BOOK array
    MOV DI,0
    MOV BOOK_NO,1

    BOOK_LIST:
        ; Print the book number
        
        MOV AH, 02H          ; DOS interrupt to print character
        MOV DL, BOOK_NO           ; Load the book number into DL
        ADD DL, 30H          ; Convert number to ASCII (1 - 8)
        INT 21H

        INC BOOK_NO
        ; Print a period and space after the number
        MOV DL, '.'
        INT 21H
        MOV DL, ' '
        INT 21H
        MOV DL, ' '
        INT 21H

        ; Print the book name
        MOV AH, 09H          ; print string
        MOV DX, BOOK[SI]     ; Load the string address into DX
        INT 21H
        
        FLD DWORD PTR [PRICE[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL
        FISTP result          ; Store integer part in result
        
        CALL DISPF

        MOV AH, 09H          ; print string
        LEA DX, QUANTITY_COLUMN_SPACE
        INT 21H

        CALL DISPLAY_QUANTITY

        MOV AH, 09H          ; print string
        LEA DX, NL
        INT 21H

        ADD SI, 2            ; Move to the next pointer (each is 2 bytes)
        ADD DI,4
    LOOP BOOK_LIST
    RET
DISPLAY_BOOK_LIST ENDP

DISPF PROC
    ; Preserve registers
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH SI

    ; Load the value of 'result' into AX (assuming result is 16-bit)
    MOV AX, result       ; AX now holds the value, e.g., 15000

    ; Division by 10000 to extract the ten-thousands place
    MOV CX, 10000         ; Divisor for ten-thousands
    XOR DX, DX            ; Clear DX to avoid overflow
    DIV CX                ; AX = AX / 10000, DX = remainder
    MOV TAX, AL         ; Store the ten-thousands digit in TAX
    MOV AX, DX            ; AX now holds the remainder

    ; Division by 1000 to extract the thousands place
    MOV CX, 1000          ; Divisor for thousands
    XOR DX, DX            ; Clear DX
    DIV CX                ; AX = AX / 1000, DX = remainder
    MOV TBX, AL         ; Store the thousands digit in TBX
    MOV AX, DX            ; AX now holds the remainder

    ; Division by 100 to extract the hundreds place
    MOV CX, 100           ; Divisor for hundreds
    XOR DX, DX            ; Clear DX
    DIV CX                ; AX = AX / 100, DX = remainder
    MOV TCX, AL         ; Store the hundreds digit in TCX
    MOV AX, DX            ; AX now holds the remainder

    ; Division by 10 to extract the tens place
    MOV CX, 10            ; Divisor for tens
    XOR DX, DX            ; Clear DX
    DIV CX                ; AX = AX / 10, DX = remainder
    MOV TDX, AL         ; Store the tens digit in TDX
    MOV TAA, DL         ; Store the remainder (units place) in TSI

    ; Print the ten-thousands digit (if it's not zero)
    CMP TAX, 0
    JZ SkipTenThousands   ; If the ten-thousands digit is 0, skip it
    MOV AL, TAX         ; Load the ten-thousands digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

SkipTenThousands:

    ; Print the thousands digit
    CMP TBX, 0
    JZ SkipThousands      ; If the thousands digit is 0, skip it (after 10000 case)
    MOV AL, TBX         ; Load the thousands digit
    ADD AL, '0'           ; Convert to ASCII
    MOV AH, 02H
    MOV DL, AL
    INT 21H               ; Print the character

SkipThousands:

    ; Print the hundreds digit
    CMP TCX, 0
    JZ SkipHundreds       ; If the hundreds digit is 0, skip it (after 1000 case)
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

DISPLAY_QUANTITY PROC
    ; Display left quantity
    MOV AX, LeftQuantity[SI]
    CALL PRINT_INT
    RET
DISPLAY_QUANTITY ENDP

PRINT_INT PROC
    ; Print a 16-bit integer in AX
    PUSH DX
    PUSH BX
    PUSH CX

    MOV CX, 0         ; Clear CX (digit count)
    MOV BH, 0
    MOV BL, TEN        ; Base 10 for decimal numbers

    PRINT_LOOP:
        MOV DX, 0         ; Clear DX
        DIV BX             ; Divide AX by 10, quotient in AX, remainder in DX
        PUSH DX            ; Push remainder (digit) onto stack
        INC CX             ; Increment digit count
        TEST AX, AX        ; Check if quotient is zero
        JNZ PRINT_LOOP     ; If not, continue loop

    PRINT_DIGITS:
        POP DX             ; Get the last digit
        ADD DL, 30H        ; Convert to ASCII
        MOV AH, 02H        ; Print character
        INT 21H
        LOOP PRINT_DIGITS  ; Repeat for all digits

        POP CX
        POP BX
        POP DX
        RET
PRINT_INT ENDP

GET_BOOK_OPTION PROC
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
    MOV ORDER_QUANTITY_ARRAY_INDEX, BL
    SHL SI, 1           ; Multiply by 2 to get correct offset (each entry is 2 bytes)
    
    MOV DI, 0           ;MOV QUANTITY_OFFSET,DI
    MOV CX,8
    FIND_QUANTITY_LABEL:
        CMP BX,DI
        JE GET_BOOK_OPTION_END
        INC DI
    LOOP FIND_QUANTITY_LABEL

    INVALID_OPTION_INPUT:
        ; Print invalid option message
        MOV AH, 09H
        LEA DX, INVALID_OPTION
        INT 21H
        JMP GET_BOOK_OPTION

    GET_BOOK_OPTION_END:
        RET
GET_BOOK_OPTION ENDP

GET_QUANTITY PROC
    MOV AH,09H
    LEA DX,BOOK_QUANTITY_TITLE1
    INT 21H

    MOV AH,09H
    MOV DX,BOOK[SI]
    INT 21H

    MOV AH,09H
    LEA DX,BOOK_QUANTITY_TITLE2
    INT 21H

    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV QUANTITY_INPUT,AL

    CMP QUANTITY_INPUT,0
    JL INVALID_QUANTITY_INPUT

    CMP QUANTITY_INPUT,9
    JG INVALID_QUANTITY_INPUT

    MOV AH,01H
    INT 21H

    CMP AL, 0DH   ; Check if user pressed ENTER KEY
    JE KEY_IN_QUANTITY_LABEL
    
    SUB AL,30H
    CMP AL,0
    JL INVALID_QUANTITY_INPUT

    CMP AL,9
    JG INVALID_QUANTITY_INPUT
    
    MOV BL, AL
    MOV AL, QUANTITY_INPUT

    MUL TEN       ; multiply the previous value with 10

    ADD AL, BL   ; previous value + new value ( after previous value is multiplyed with 10 )
    MOV QUANTITY_INPUT, AL
    
    KEY_IN_QUANTITY_LABEL:
        MOV AX,0
        MOV AL,ORDER_QUANTITY_ARRAY_INDEX
        MOV BL,QUANTITY_INPUT
        MOV DI,AX
        MOV BOOK_ORDER_QUANTITY[DI],BL
        JMP GET_QUANTITY_END

    INVALID_QUANTITY_INPUT:
        MOV AH,09H
        LEA DX,INVALID_QUANTITY
        INT 21H
        JMP GET_QUANTITY

    GET_QUANTITY_END:
        RET
GET_QUANTITY ENDP

ASK_ADD_ORDER PROC
    MOV AH, 09H
    LEA DX, ADD_ORDER_TITLE
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,'Y'
    JE ASK_ADD_ORDER_END
    CMP AL,'y'
    JE ASK_ADD_ORDER_END
    CMP AL,'N'
    JE ASK_ADD_ORDER_END
    CMP AL,'n'
    JE ASK_ADD_ORDER_END

    ; If invalid input
    MOV AH,09H
    LEA DX,INVALID_ORDER
    INT 21H
    JMP ASK_ADD_ORDER

    ASK_ADD_ORDER_END:
        RET
ASK_ADD_ORDER ENDP

DISPLAY_ORDER PROC
    MOV AH,09H
    LEA DX, COLUMN_ORDERED_HEADERS
    INT 21H

    MOV CX,8
    MOV SI,0
    MOV DI,0
    MOV BOOK_NO,1
    DISPLAY_ORDER_LABEL:

        CMP BOOK_ORDER_QUANTITY[DI],0
        JE NEXT

        MOV AH,02H
        MOV DL,BOOK_NO
        ADD DL,30H
        INT 21H

        INC BOOK_NO
        ; Print a period and space after the number
        MOV DL, '.'
        INT 21H
        MOV DL, ' '
        INT 21H
        MOV DL, ' '
        INT 21H 

        MOV AH,09H
        MOV DX,BOOK[SI]
        INT 21H

        MOV AX,0
        MOV AL,BOOK_ORDER_QUANTITY[DI]
        DIV TEN
        MOV BX,AX

        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV AH,09H
        LEA DX,NL
        INT 21H

        NEXT:
            ADD SI,2
            INC DI
    LOOP DISPLAY_ORDER_LABEL
    RET
DISPLAY_ORDER ENDP

CONFIRM_ORDER PROC
    MOV AH,09H
    LEA DX, CONFIRM_ORDER_TITLE
    INT 21H

    MOV AH,01H
    INT 21H
    
    CMP AL,'Y'
    JE CONFIRM_ORDER_END
    CMP AL,'y'
    JE CONFIRM_ORDER_END
    CMP AL,'N'
    JE CONFIRM_ORDER_END
    CMP AL,'n'
    JE CONFIRM_ORDER_END

    ; If invalid input
    MOV AH,09H
    LEA DX,INVALID_ORDER
    INT 21H
    JMP CONFIRM_ORDER
    
    CONFIRM_ORDER_END:
        RET
CONFIRM_ORDER ENDP


END MAIN