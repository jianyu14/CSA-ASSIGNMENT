.MODEL SMALL
.STACK 100
.DATA

    REPORTMENU DB "REPORT MENU$"
    OPTION_TOTAL_SALES DB "1. View Total Sales Report$"
    OPTION_INVENTORY DB "2. View Inventory Report$"
    OPTION_RETURN DB "3. Return Main Menu$"
    PROMPTMSG DB "Enter Choice (1-3): $"
    REPORTCHOICE DB ?
    INAVLIDMSG DB "Invalid Choice, Try Again.$"
    TOTAL_SALES_TITLE DB "          TOTAL SALES REPORT$"
    INVENTORY_TITLE DB "            INVENTORY REPORT$"
    BUFFER      DB 6 DUP (?)  ; Buffer to store the ASCII digits
    SALESRPT_HEADER DB "Title         Price(RM)      Sold Quantity     Total(RM)$"
    INVENTORYRPT_HEADER DB "Title         Stock Quantity$"
    SPACE_PREFIX DB "              $"

    ;Book sold quantity
    SoldQuantity DW 5, 10, 20, 15, 30, 35, 40, 45

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
;;;;;


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
;;;;;


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
;;;;;


;TEMP REGISTERS?
	TAL DB ?
	TBL DB ?
	TCL DB ?
	TDL DB ?
	TDI DW ?
	TSI DW ?
	TAA DB ?
;;;;;


;floating point display data
    factor DW 10       ; Scaling factor for displaying
	result DW 0       ; Define the result variable as a 16-bit word
	strResult DB 12 DUP('$')  ; Define a buffer for storing the string result
	fraction_count DB 0
;;;;;


;Create Order Data
    CREATE_HEADER DB "CREATE ORDER", 0AH,0DH, "$"
    COLUMN_HEADERS DB 'No. Title           Price(RM)   Left Quantity', 0DH, 0AH, '$'
    COLUMN_ORDERED_HEADERS DB 'No. Book Order      Order Quantity', 0DH, 0AH, '$'
    BOOK_NO DB 1
    QUANTITY_COLUMN_SPACE DB '       ', '$'

    ORDER_INPUT_TITLE DB 0AH,0DH,"Enter the option to order book (1-8): $"
    INVALID_OPTION DB 0AH,0DH,"Invalid option. Please enter valid option (1-8). ", 0AH,0DH, "$"
    BOOK_QUANTITY_TITLE1 DB 0AH,0DH,"Enter the quantity to order or edit order quantity ($"
    BOOK_QUANTITY_TITLE2 DB "): $"
    INVALID_QUANTITY DB 0AH,0DH,"Invalid quantity. Enter a 1 or 2-digit number. ", 0AH,0DH, "$"
    QUANTITY_LARGER DB 0AH,0DH,"The quantity is larger than stock quantity. Please enter again. ", 0AH,0DH, "$"
    ADD_ORDER_TITLE DB 0AH,0DH,"Any other book to order or edit? (Y/N): $"
    INVALID_ORDER DB 0AH,0DH,"Invalid input. You must enter Y/N only. ", 0AH,0DH, "$"
    CONFIRM_ORDER_TITLE DB 0AH,0DH,"Are you sure you want to proceed order? (Y/N): $"
;;;;;


;Create Order Link to Payment Data
    BOOK_ORDER_QUANTITY DB 8 DUP(0) 
    ORDER_QUANTITY_ARRAY_INDEX DB ?
    QUANTITY_INPUT DB ?
;;;;;


;Payment Data
	;Payment method
	TNG DB "Touch N Go$"
	CARD DB "Card$"
	CASH DB "Cash$"

    ;Address holder
    ADDRESS_PRICE DW ?
	ADDRESS_EACH_AMOUNT DW ?

	;General Display DATA
	NL DB 0AH,0DH,"$"
	PAYMENT_METHOD_MESSAGE DB "Payment Method$"
	RM DB "RM $"
	PROMPOPT DB "       Enter your selection: $"
	PAID_AMOUNT DB "Paid Amount: $"
	CHANGE_AMOUNT DB "Change Amount : $"
	PINVALID DB "Invalid Input!!!$"
	PINSUFFICIENT DB "Insufficient Amount!!!$"
	ORDER_CONFIRMATION_MESSAGE DB "Confirm to Place Order?$"
	ORDER_CONFIRM DB "Confirm$"
	ORDER_CANCEL_MESSAGE DB "Payment cancelled.$"
	ORDER_CONFIRM_MESSAGE DB "Payment has made successfully!!!$"
	QUIT DB "2.  Quit$"
	ENTAGN DB "1.  Enter again$"
	DOT DB ".  $"
	PRINT_MIDDLE DB "			   	    $"
	TAB DB "             $"
	PAYMT DB ?
	EACHAMOUNT DD 10 DUP(0.0)
	TOTALAMOUNT DD 0.0
	TOTALP DD 10 DUP(0.0)
	PAYMENT_SELECTION_ONE DB ?
	PAYMENT_SELECTION_TWO DB ?
	TOTAL_AMOUNT_MESSAGE DB "GRAND TOTAL AMOUNT (RM) : $"
    TOTAL_AMOUNT_SPACE DB "                          $"
	PROMPTPAY DB "	ENTER AMOUNT PAID : $"
    PAYMENT_HEADER DB 'No. Title           Price(RM)   Quantity    Total Amount(RM)', 0DH, 0AH, '$'
	BuyQuantity DW 10 DUP(0)

	;ITERATTION COUNT
	COUNT_PAYMENT_MADE DW 0
	PAYMENT_LOOP_COUNT DB ?
    TEMP_BOOK_QUANTITY DW ?

	;User Input pay amount if using cash
	PAIDAMOUNTS DB 10 DUP(0)
	PAIDAMOUNT_INT DW 0
	PAIDAMOUNT_DCM DW 0
	PAIDAMOUNT_TOTAL DD 0.0
	PAYMENT_STATUS_WORD DW ?
	TEMP_TOTAL_AMOUNT DD 0.0
;;;;;


;General Display Data
    OPTION DB ?
    TEN DB 10
    HUNDRED DB 100
    THOUSAND DW 1000
	TEN_THOUSAND DW 10000
;;;;;





.CODE
MAIN PROC

	MOV AX,@DATA
	MOV DS,AX

    ;menu loop
RPTMENU_LOOP:

    ;display menu
    CALL DISPLAYMENU

    ;get user input
    CALL GETINPUT

    ;check input
    CMP REPORTCHOICE,1
    JNE CHECK_CHOICE2
    CALL VIEWTOTALSALESREPORT
    JMP RPTMENU_LOOP  ; Ensure return to menu loop

CHECK_CHOICE2:
    CMP REPORTCHOICE,2
    JNE CHECK_CHOICE3
    CALL VIEWINVENTORYREPORT
    JMP RPTMENU_LOOP  ; Ensure return to menu loop

CHECK_CHOICE3:
    CMP REPORTCHOICE,3
    JNE INVALID_INPUT
    JMP EXITMENU

INVALID_INPUT:
    ;display invalid msg
    CALL DISPLAYINVALID
    JMP RPTMENU_LOOP


DISPLAYMENU PROC

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H
    
 	MOV AH,09H
	LEA DX,REPORTMENU
	INT 21H
    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ;OPTION1
    MOV AH,09H
	LEA DX,OPTION_TOTAL_SALES
	INT 21H
    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ;OPTION2
    MOV AH,09H
	LEA DX,OPTION_INVENTORY
	INT 21H
    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ;OPTION3
    MOV AH,09H
	LEA DX,OPTION_RETURN
	INT 21H
    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ;PROMPT INPUT
    MOV AH,09H
	LEA DX,PROMPTMSG
	INT 21H

    RET
    
DISPLAYMENU ENDP


GETINPUT PROC
	;INPUT
	MOV AH,01H
	INT 21H
	SUB AL,30H
	MOV REPORTCHOICE,AL

    RET
GETINPUT ENDP

DISPLAYINVALID PROC
    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H
    MOV AH,09H
	LEA DX,INAVLIDMSG
	INT 21H
    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H
    
    RET
DISPLAYINVALID ENDP


VIEWTOTALSALESREPORT PROC


    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ; Display the title of the report
    MOV AH,09H
	LEA DX,TOTAL_SALES_TITLE   
	INT 21H

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
    INT 21H

    MOV AH,09H
	LEA DX,SALESRPT_HEADER   
	INT 21H

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
    INT 21H

    ; Set up loop counter for 8 books
    MOV CX, 8
    XOR SI, SI        ; Initialize loop counter for 8 books
    MOV DI, 0

NEXT_BOOK:
    ; Access the book name address by loading from BookNames array
    MOV BX, [BOOK + SI]  ; Load address of the book name into BX
    MOV AH, 09H
    MOV DX, BX
    INT 21H              ; Display the book name


    ; Calculate the correct price index (each DD is 4 bytes)
    MOV BX, SI
    SHR BX, 1            ; Adjust index for DD access
    ADD BX, BX           ; Double the index because each DD is 4 bytes
    ADD BX, BX

    ;Load floating point price
    FLD DWORD PTR [PRICE[DI]]
    FILD WORD PTR [factor]      ; Load scaling factor
    FMUL                         ; Multiply to scale
    FISTP result    ; Store scaled value as integer in 'result'

    ; Display scaled price
    CALL DISPF

    MOV AH,09H
	LEA DX,SPACE_PREFIX  
	INT 21H
    

    MOV BX, SI
    SHR BX, 1

    CALL DISPLAY_SOLD_QUANTITY


     MOV AH,09H
	LEA DX,SPACE_PREFIX  
	INT 21H

    CALL CALCULATE_TOTAL_PRICE

    ; Display New Line
    MOV AH, 09H
    LEA DX, NL
    INT 21H

    ; Increment SI by 2 to point to the next word (since addresses are word-sized)
    ADD SI, 2

    ; Increment DI by 4 for the next price in DD format
    ADD DI, 4

    ; Display New Line for separation between books
    MOV AH, 09H
    LEA DX, NL
    INT 21H
   
    LOOP NEXT_BOOK

    RET
VIEWTOTALSALESREPORT ENDP


CALCULATE_TOTAL_PRICE PROC

    ; Calculate the correct price index (each DD is 4 bytes)
    MOV BX, DI                      ; Using DI for price index, ensure DI is correctly incremented for DD
    FLD DWORD PTR [PRICE + BX]      ; Load the floating-point price

    ; Load and convert the sold quantity
    ;MOV AX, [SoldQuantity + SI]     ; Load sold quantity (assuming SOLD_QUANTITY array exists)
    ; Convert AX to float and push on the FPU stack
    ;MOV BX, AX                      ; Copy to BX for FILD
    FILD WORD PTR [SoldQuantity + SI]              ; Convert integer to float (need to use a memory operand)

    ; Multiply price by sold quantity
    FMUL                            ; Result in ST(0) = price * quantity
    ;FSTP DWORD PTR [buffer]         ; Store the floating-point result temporarily (buffer defined in .DATA)
    ;FILD DWORD PTR [buffer]         ; Load result back as integer scaled by 100 (or your scaling logic)

    ; Store scaled result for display
    FILD WORD PTR [factor]
    FMUL
    FISTP DWORD PTR [result]    ; Convert to integer for display
    CALL DISPF                  ; Display the result
    
    RET

CALCULATE_TOTAL_PRICE ENDP


    DISPLAY_SOLD_QUANTITY PROC
        ; Display sold quantity
        MOV AX, SoldQuantity[SI]
        CALL PRINT_INT
        RET
    DISPLAY_SOLD_QUANTITY ENDP

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



VIEWINVENTORYREPORT PROC

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
	INT 21H

    MOV AH,09H
	LEA DX,INVENTORY_TITLE
	INT 21H

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
    INT 21H

    MOV AH,09H
	LEA DX,INVENTORYRPT_HEADER 
	INT 21H

    ;TO DISPLAY NEW LINE
	MOV AH,09H
	LEA DX,NL
    INT 21H

    ; Set up loop counter for 8 books
    MOV CX, 8
    XOR SI, SI        ; Initialize loop counter for 8 books

NEXT_BOOK2:
    ; Access the book name address by loading from BookNames array
    MOV BX, [BOOK + SI]  ; Load address of the book name into BX
    MOV AH, 09H
    MOV DX, BX
    INT 21H              ; Display the book name



    MOV BX, SI
    SHR BX, 1

    ; Display left quantity
    CALL DISPLAY_QUANTITY



    ; Display New Line
    MOV AH, 09H
    LEA DX, NL
    INT 21H

    ; Increment SI by 2 to point to the next word (since addresses are word-sized)
    ADD SI, 2

       ; Display New Line for separation between books
    MOV AH, 09H
    LEA DX, NL
    INT 21H

   
    LOOP NEXT_BOOK2

    JMP RPTMENU_LOOP
VIEWINVENTORYREPORT ENDP

    DISPLAY_QUANTITY PROC
        ; Display left quantity
        MOV AX, LeftQuantity[SI]
        CALL PRINT_INT
        RET
    DISPLAY_QUANTITY ENDP

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
        MOV CX, TEN_THOUSAND         ; Divisor for ten-thousands
        XOR DX, DX            ; Clear DX to avoid overflow
        DIV CX                ; AX = AX / 10000, DX = remainder
        MOV TAL, AL         ; Store the ten-thousands digit in TAL
        MOV AX, DX            ; AX now holds the remainder

        ; Division by 1000 to extract the thousands place
        MOV CX, THOUSAND          ; Divisor for thousands
        XOR DX, DX            ; Clear DX
        DIV CX                ; AX = AX / 1000, DX = remainder
        MOV TBL, AL         ; Store the thousands digit in TBL
        MOV AX, DX            ; AX now holds the remainder

        ; Division by 100 to extract the hundreds place
        XOR CX,CX
        MOV CL, HUNDRED           ; Divisor for hundreds
        XOR DX, DX            ; Clear DX
        DIV CX                ; AX = AX / 100, DX = remainder
        MOV TCL, AL         ; Store the hundreds digit in TCL
        MOV AX, DX            ; AX now holds the remainder

        ; Division by 10 to extract the tens place
        XOR CX,CX
        MOV CL, TEN            ; Divisor for tens
        XOR DX, DX            ; Clear DX
        DIV CX                ; AX = AX / 10, DX = remainder
        MOV TDL, AL         ; Store the tens digit in TDL
        MOV TAA, DL         ; Store the remainder (units place) in TSI

        ; Print the ten-thousands digit (if it's not zero)
        CMP TAL, 0
        JZ SkipTenThousands   ; If the ten-thousands digit is 0, skip it
        INC fraction_count
        MOV AL, TAL         ; Load the ten-thousands digit
        ADD AL, '0'           ; Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H               ; Print the character

    SkipTenThousands:

        ; Print the thousands digit
        CMP fraction_count,1
        JGE NO_NEED_SKIP_TEN_THOUSANDS
        CMP TBL, 0
        JZ SkipThousands      ; If the thousands digit is 0, skip it (after 10000 case)
        NO_NEED_SKIP_TEN_THOUSANDS:
        INC fraction_count
        MOV AL, TBL         ; Load the thousands digit
        ADD AL, '0'           ; Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H               ; Print the character

    SkipThousands:

        ; Print the hundreds digit
        CMP fraction_count,1
        JGE NO_NEED_SKIP_THOUSANDS
        CMP TCL, 0
        JZ SkipHundreds       ; If the hundreds digit is 0, skip it (after 1000 case)
        NO_NEED_SKIP_THOUSANDS:
        INC fraction_count
        MOV AL, TBL         ; Load the thousands digit
        MOV AL, TCL         ; Load the hundreds digit
        ADD AL, '0'           ; Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H               ; Print the character

    SkipHundreds:

        ; Print the tens digit
        MOV AL, TDL         ; Load the tens digit
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







EXITMENU PROC
MOV AX,4C00H
	INT 21H

EXITMENU ENDP

MAIN ENDP
END MAIN