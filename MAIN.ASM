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
	;BuyQuantity DW 10 DUP(0)

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


;Payment Link to Report Data
    ;Book sold quantity
    SoldQuantity DW 10 DUP(0)
;;;;;


;Report Data
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
;;;;;


;General Display Data
    OPTION DB ?
    TEN DB 10
    HUNDRED DB 100
    THOUSAND DW 1000
	TEN_THOUSAND DW 10000
;;;;;


;User Login Data
	;Account
	USERNAME DB "LegoGuy$"
	PASS DB "1234$"
	PASSLENGTH DB 4

    ;Message and User Input
	INV DB "Invalid Username or Password!!!$"   
	SUC DB "LOGIN SUCCESSFULLY!$"
	PROMPPASS DB "Enter password: $"
	PTITLE DB "Book Lego Guy Book POS$"
	PROMPUSN DB "Enter username: $"

    ;User Name Input String
	STRU LABEL BYTE
	MAXNU DB 20
	ACTNU DB ?
	INPUTUSN DB 20 DUP("$")
	
    ;Password Input String
	STRP LABEL BYTE
	MAXNP DB 20
	ACTNP DB ?
	INPUTPASS DB 20 DUP("$")

;;;;;


;Temporary Main Menu Display Data and Selection for Testing Purposes
    MAIN_MENU_MESSAGE DB "CHOOSE FUNCTION:  $"
    CREATE_ORDER_FUNTION_SELECTION DB "1.  CREATE ORDER$"
    REPORT_FUNCTION_SELECTION DB "2.  VIEW REPORT$"
    MAIN_MENU_SELECTION DB ?
;;;;;



.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

        CALL LOGIN_FUNCTION
        CMP AL,0
        JNE EXIT_WHOLE_FUNCTION
        

    MAIN_AGAIN:
    ;MAIN MENU HERE
    MOV AH,09H 
    LEA DX,NL   
    INT 21H
    LEA DX,NL   
    INT 21H
    LEA DX,NL   
    INT 21H
    LEA DX,CREATE_ORDER_FUNTION_SELECTION
    INT 21H 
    LEA DX,NL  
    INT 21H  
    LEA DX,REPORT_FUNCTION_SELECTION
    INT 21H  
    LEA DX,NL  
    INT 21H  
    LEA DX,MAIN_MENU_MESSAGE
    INT 21H  

    MOV AH,01H
    INT 21H  
    MOV MAIN_MENU_SELECTION,AL


    CMP MAIN_MENU_SELECTION,'1'
    JNE CHECK_NEXT
    ;CREATE ORDER FUNCTION
    CALL CREATE_ORDER_FUNCTION_MAIN      ;CALL PAYMENT FUNCTION IN HERE
    JMP MAIN_AGAIN


    CHECK_NEXT:
    CMP MAIN_MENU_SELECTION,'2'
    JNE QUIT_MAIN
    ;REPORT FUNCTION
    CALL REPORT_FUNCTION_MAIN


    QUIT_MAIN:
    CMP MAIN_MENU_SELECTION,'3'
    JNE MAIN_AGAIN

    EXIT_WHOLE_FUNCTION:

        MOV AX, 4C00H
        INT 21H
MAIN ENDP




;LOGIN_FUNCTION
    LOGIN_FUNCTION PROC

            MOV AH,09H
            LEA DX,NL
            INT 21H

            LEA DX,PTITLE
            INT 21H

        LOGIN:
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H

            LEA DX,PROMPUSN
            INT 21H

            MOV AH,0AH
            LEA DX,STRU
            INT 21H
            
            MOV AH,09H  
            LEA DX,NL
            INT 21H
            
            LEA DX,PROMPPASS
            INT 21H
            
            MOV AH,0AH
            LEA DX,STRP
            INT 21H

            MOV AH,09H
            LEA DX,NL
            INT 21H
            
            ;LOOP TO CHECK USER NAME FIRST
            MOV SI,0
            MOV CX,0H
            MOV CL,ACTNU
            VERIFYU:
                MOV BL,INPUTUSN[SI]
                CMP USERNAME[SI],BL
                JNE INVALID
                
                INC SI
                
            LOOP VERIFYU

            ;NOW LOOP TO CHECK PASSWORD
            MOV SI,0
            MOV CX,0H
            MOV CL,ACTNP
            VERIFYP:

                MOV BL,INPUTPASS[SI]
                CMP PASS[SI],BL
                JNE INVALID
                
                INC SI
                
            LOOP VERIFYP

            MOV Al,PASSLENGTH
            CMP ACTNP,Al
            JNE INVALID
            
            MOV AH,09H
            LEA DX,SUC
            INT 21H
            JMP FINISH_LOGIN_SUCCESS

            INVALID:
                MOV AH,09H
                LEA DX,INV
                INT 21H

                ;IF INVALID,PROMPT CONTINUE?
                LEA DX,NL
                INT 21H
                
                LEA DX,PINVALID
                INT 21H
                
                LEA DX,NL
                INT 21H
                
                ;Enter Again?
                MOV AH,09H
                LEA DX,ENTAGN
                INT 21H
                
                LEA DX,NL
                INT 21H
                
                ;Quit?
                MOV AH,09H
                LEA DX,QUIT
                INT 21H
                
                LEA DX,NL
                INT 21H
                
                ;PROMT USER INPUT 
                LEA DX,PROMPOPT
                INT 21H
                
                MOV AH,01H
                INT 21H
                MOV MAIN_MENU_SELECTION,AL
                
                CMP MAIN_MENU_SELECTION,'1'
                JNE FINISH_LOGIN_FAILED ;QUIT
                JMP LOGIN


            FINISH_LOGIN_SUCCESS:
                MOV AL,0
                RET

            FINISH_LOGIN_FAILED:
                MOV AL,1
                RET



    LOGIN_FUNCTION ENDP
;;;;;




;CREATE_ORDER_FUNCTION
    CREATE_ORDER_FUNCTION_MAIN PROC
        CREATE_ORDER_START:
            ; Print header

            MOV AH,09H   
            LEA DX,NL
            INT 21H  
            LEA DX,PRINT_MIDDLE
            INT 21H
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

            CMP AL, 'N'
            JE RESET_BOOK_QUANTITY
            CMP AL, 'n'
            JE RESET_BOOK_QUANTITY

            ;LINK PAYMENT FUNCTION HERE
                CALL PAYMENT_FUNCTION_MAIN
            ;;;;;

            RESET_BOOK_QUANTITY:

                MOV SI,0
                MOV CX,8
                RESET_LOOP:
                    MOV BOOK_ORDER_QUANTITY[SI], 0        ; Set the quantity to 0
                    MOV AL,BOOK_ORDER_QUANTITY[SI]
                    INC SI                                ; Move to the next book

                LOOP RESET_LOOP 

            
        RET
    CREATE_ORDER_FUNCTION_MAIN ENDP


    DISPLAY_BOOK_LIST PROC
        ; Print header

        CALL DISPLAY_DASH

        ; Print column headers
        MOV AH, 09H
        LEA DX, COLUMN_HEADERS
        INT 21H

        CALL DISPLAY_DASH

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
            MOV AH,09H
            LEA DX,DOT
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
        
        MOV DI, 0           
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
            MOV BX,0
            MOV BL,QUANTITY_INPUT
            CMP BX, LeftQuantity[SI]
            JG QUANTITY_LARGER_LABEL

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

        QUANTITY_LARGER_LABEL:
            MOV AH,09H
            LEA DX,QUANTITY_LARGER
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
        LEA DX,NL
        INT 21H

        CALL DISPLAY_DASH

        MOV AH,09H
        LEA DX, COLUMN_ORDERED_HEADERS
        INT 21H

        CALL DISPLAY_DASH

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
            MOV AH,09H
            LEA DX,DOT
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
;;;;; CREATE ORDER FUNCTION END




;PAYMENT_FUNCTION
    PAYMENT_FUNCTION_MAIN PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

            FINIT
            FLDZ                          ; Load 0.0 into FPU stack
            FSTP DWORD PTR [TOTALAMOUNT]  ; Store 0.0 in TOTALAMOUNT

            MOV AH,09H	
            LEA DX,NL
            INT 21H	
            LEA DX,NL
            INT 21H

            CALL DISPLAY_DASH

            ;display the header here			
            LEA DX,PAYMENT_HEADER
            INT 21H


    ;TO CALCULATE TOTAL AND DISPLAY EACH AMOUNT
    MOV ADDRESS_PRICE,0
    MOV ADDRESS_EACH_AMOUNT,0
    MOV SI,0
    MOV PAYMENT_LOOP_COUNT,8
    MOV DI,0
    MOV BOOK_NO,1
    L1:

        CMP BOOK_ORDER_QUANTITY[DI],0 				;COMPARE IF BOOK QUANTITY WANT TO BUY IF 0, THEN SKIP IT
        JNE BOOK_QUANTITY_NOT_EQUAL_ZERO

        JMP AGAIN

        BOOK_QUANTITY_NOT_EQUAL_ZERO:
        ;INC BOOKC   				  ;MIGHT BE REDUNDANT DATA
        MOV AX,0H

        XOR CX,CX
        MOV CL,BOOK_ORDER_QUANTITY[DI]
        MOV TEMP_BOOK_QUANTITY,CX
        FILD WORD PTR [TEMP_BOOK_QUANTITY] ;LOAD QUANTITY

            MOV TDI,DI				;USING DIFFERENT ADDRESS_PRICE FOR FLOATING POINT AND GENERAL DATA
            MOV DI,ADDRESS_PRICE

        FLD DWORD PTR [PRICE[DI]]  ;LOAD PRICE INTO FPU STACK
        FMUL						;MULTIPLE THE PRICE AND THE QUANTITY BUY

            MOV DI,ADDRESS_EACH_AMOUNT		;THE COUNT FOR FLOATING POINT VARIABLE PRICE AND EACHAMOUNT MAY BE DIFFRENT
                                    ;REGARD WHETHER THE BUY QUANTITY IS ZERO OR NOT

        FSTP DWORD PTR [EACHAMOUNT[DI]]		;STORE THE RESULT INTO EACHAMOUNT

            MOV DI,TDI				;RESET THE ADDRESS_PRICE BACK TO NORMAL

        CALL DISPLAY_DASH			;LOOP TO PRINT THE LINE IN THE TABLE

    ;display the quantity, name, and total here

        ;MOV AH,09H		;display the new line
        ;LEA DX,NL
        ;INT 21H

        ; Load the pointer to the book name from the BOOK array

        MOV AH, 02H          ; DOS interrupt to print character
        MOV DL, BOOK_NO           ; Load the book number into DL
        ADD DL, 30H          ; Convert number to ASCII (1 - 8)
        INT 21H

        INC BOOK_NO
        ; Print a period and space after the number
        MOV AH,09H
        LEA DX,DOT
        INT 21H

        MOV AH,09H 
        MOV DX,BOOK[SI] 	;display the book name of customer buying
        INT 21H  		

            MOV TDI,DI			;store the original address into temporary register first
            MOV DI,ADDRESS_PRICE		;load the floating point number into DI

        FLD DWORD PTR [PRICE[DI]]  ;Load price into the FPU stack

            MOV DI,TDI			;restore the original address

        FILD WORD PTR [factor] ;Load factor(10)
        FMUL                  ;Multiply price by factor to scale so can pass into function for display
        FISTP result          ; Store integer part in result
        
        CALL DISPF			;call the display floating point function

        ;;;;;;;

        MOV AH,09H 
        LEA DX,TAB	
        INT 21H

        MOV AX,0H
        MOV AL,BOOK_ORDER_QUANTITY[DI]		;to display the number of book quantity in order
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

        ;;;;;

        MOV AH,09H 
        LEA DX,TAB	
        INT 21H

            MOV TDI,DI
            MOV DI,ADDRESS_EACH_AMOUNT

        FLD DWORD PTR [EACHAMOUNT[DI]]  ; Load each amount into the FPU stack

        FLD DWORD PTR [TOTALAMOUNT]		;load total amount into FPU stack

        FADD							;add each amount and total amount together, to calculate the total amount
                                        ;of that order
        FSTP DWORD PTR [TOTALAMOUNT]    ;and store the result back into TOTALAMOUNT

        FINIT						;initialize the FPU stack, to avoid bugs

        FLD DWORD PTR [EACHAMOUNT[DI]]  ;Load each amount into the FPU stack again
        FILD WORD PTR [factor] 			;Load factor
        FMUL							;multiply to scale the each amount
        FISTP result         			;Store integer part in result

        CALL DISPF						;call the display floating point number function

        MOV DI,TDI

        MOV BX,4						;each floating point takes up to 4 bytes
        ADD ADDRESS_EACH_AMOUNT,BX				;update the each amount address by add 4
        
        ;;;;

        MOV AH,09H			
        LEA DX,NL						;display newline after each book done
        INT 21H

        AGAIN:

            ADD SI,2					;update SI, each data takes up to 2 bytes in DW
            INC DI						;update DI, simple add 1
            MOV BX,4					;each floating point takes up to 4 bytes
            ADD ADDRESS_PRICE,BX				;update the price address by add 4
        
            DEC PAYMENT_LOOP_COUNT						;use PAYMENT_LOOP_COUNT to count 10 books for a loop
            CMP PAYMENT_LOOP_COUNT,0					;check if 10 books loop already done or not?
            JE FINISH_DISPLAY_PAYMENT					;if yes, jump to finish
        
        JMP L1

        FINISH_DISPLAY_PAYMENT:


        CALL DISPLAY_DASH


        FINIT

        MOV AH,09H 
        LEA DX,TOTAL_AMOUNT_SPACE
        INT 21H
        LEA DX,TOTAL_AMOUNT_MESSAGE
        INT 21H
        
        FINIT
        ; Display the total amount
        FLD DWORD PTR [TOTALAMOUNT]
        FILD WORD PTR [FACTOR] ; Load factor
        FMUL
        FISTP result          ; Store integer part in result
        CALL DISPF

        MOV AH,09H
        LEA DX,NL
        INT 21H

        CALL CHOOSEPAY   ;prompt user to choose payment method

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    PAYMENT_FUNCTION_MAIN ENDP


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


    CHOOSEPAY PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

        ;Prompt Payment Method
        CHOOSE_PAYMENT_METHOD:
        MOV AH,09H
        LEA DX,NL
        INT 21H

        LEA DX,PAYMENT_METHOD_MESSAGE
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Option TNG
        MOV AH,02H
        MOV DL,1
        ADD DL,30H
        INT 21H
        
        MOV AH,09H
        LEA DX,DOT
        INT 21H
        
        LEA DX,TNG
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Option CARD
        MOV AH,02H
        MOV DL,2
        ADD DL,30H
        INT 21H
        
        MOV AH,09H
        LEA DX,DOT
        INT 21H
        
        LEA DX,CARD
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Option CASH
        MOV AH,02H
        MOV DL,3
        ADD DL,30H
        INT 21H
        
        MOV AH,09H
        LEA DX,DOT
        INT 21H
        
        LEA DX,CASH
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Prompt User Input
        LEA DX,PROMPOPT
        INT 21H
        
        MOV AH,01H
        INT 21H
        MOV PAYMENT_SELECTION_ONE,AL
        
        ;Compare User Input
        ;Check Valid
        CMP PAYMENT_SELECTION_ONE,'1'
        JE TGO
        CMP PAYMENT_SELECTION_ONE,'2'
        JE CAD_INTERCHANGE
        CMP PAYMENT_SELECTION_ONE,'3'
        JE CAH_INTERCHANGE
        
        INVALID_PAYMENT_METHOD_INPUT:
        ;IF INVALID,PROMPT CONTINUE?
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H

            CALL DISPLAY_DASH
            
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            LEA DX,PINVALID
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,QUIT
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT 
            LEA DX,PROMPOPT
            INT 21H
            
            MOV AH,01H
            INT 21H	
            MOV PAYMENT_SELECTION_TWO,AL

            MOV AH,09H
            LEA DX,NL
            INT 21H
            
            CMP PAYMENT_SELECTION_TWO,'2'
            JE FINISHPM ;QUIT
            CMP PAYMENT_SELECTION_TWO,'1'
            JNE INVALID_PAYMENT_METHOD_INPUT
            JMP CHOOSE_PAYMENT_METHOD
            CAD_INTERCHANGE:
                JMP CAD
            CAH_INTERCHANGE:
                JMP CAH
        
        TGO:
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            CALL DISPLAY_DASH
            LEA DX,PRINT_MIDDLE
            INT 21H
            
            LEA DX,TNG
            INT 21H

            CALL ORDER_CONFIRMATION
            JMP FINISHPM
        
        CAD:
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            CALL DISPLAY_DASH
            LEA DX,PRINT_MIDDLE
            INT 21H
            
            LEA DX,CARD
            INT 21H
            CALL ORDER_CONFIRMATION
            JMP FINISHPM
        
        CAH:
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            CALL DISPLAY_DASH
            LEA DX,PRINT_MIDDLE
            INT 21H
            
            LEA DX,CASH
            INT 21H
            CALL CASHCHANGE
            CALL ORDER_CONFIRMATION
            JMP FINISHPM
            
            ;CHOOSE_PAYMENT_METHOD_INTERCHANGE:
                ;JMP CHOOSE_PAYMENT_METHOD

        FINISHPM:
        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    CHOOSEPAY ENDP


    CASHCHANGE PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

        INPUT_CASH_AGAIN:
        FINIT
        FLDZ
        ; Prompt the user to input the payment amount
        MOV AH, 09H
        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H
        LEA DX, PROMPTPAY
        INT 21H
        LEA DX,RM
        INT 21H

        ; Initialize registers and variables
        XOR AX, AX              ; Clear AX (this will hold the final value)
        XOR BX, BX              ; Clear BX
        XOR CX, CX              ; Clear CX
        MOV PAIDAMOUNT_INT, AX     ; Ensure PAIDAMOUNT_INT starts at 0
        MOV SI, 0               ; SI will be used as an index for input buffer
        MOV TDI,0 		;USE TO TRACK IF GOT DECIMAL POINT OR NOT

        ; Loop to input and convert each digit
    LOOP_INPUT_CASH:
        MOV AH, 01H             ; Read user input (one character at a time)
        INT 21H

        CMP AL,'.'
        JNE CONTINUE_WITHOUT_DECIMAL

            INC TDI
            MOV AX,TDI
            CMP AX,1
            JG INVALID_CASH_INPUT
            JMP LOOP_INPUT_CASH

        CONTINUE_WITHOUT_DECIMAL:

        CMP AL, 0DH             ; Check if Enter is pressed (0Dh in ASCII)
        JE END_OF_CASH_INPUT_INTERCHANGE

        SUB AL, 30H             ; Convert ASCII to a number (0-9)
        CMP AL, 0
        JL INVALID_CASH_INPUT    ; If invalid, exit
        CMP AL, 9
        JG INVALID_CASH_INPUT

        MOV TAL, AL             ; Store the current digit in TAL

        ; Multiply the current result by 10 using PAIDAMOUNT_INT
        MOV AX, PAIDAMOUNT_INT     ; Load the current result
        MOV CX, 10              ; Multiply by 10
        MUL CX                  ; AX = AX * 10
        MOV PAIDAMOUNT_INT, AX     ; Store back the result in PAIDAMOUNT_INT

        ; Add the new digit to the result using TAL
        XOR AX,AX
        MOV AL,TAL
        ADD PAIDAMOUNT_INT,AX    ; Add the digit to the final result

        INC SI                  ; Move to the next character
        CMP SI, 10              ; Limit input to 10 characters
        JGE END_OF_CASH_INPUT_INTERCHANGE

        CMP TDI, 1              ; Limit input to 10 characters
        JE END_OF_CASH_INPUT_INTERCHANGE

        JMP LOOP_INPUT_CASH

        END_OF_CASH_INPUT_INTERCHANGE:
            JMP END_OF_CASH_INPUT

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        INVALID_CASH_INPUT:
            ;IF INVALID,PROMPT CONTINUE?
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H

            LEA DX,PINVALID
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,QUIT
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT 
            LEA DX,PROMPOPT
            INT 21H
            
            MOV AH,01H
            INT 21H
            MOV PAYMENT_SELECTION_TWO,AL

            MOV AH,09H
            LEA DX,NL
            INT 21H
            
            CMP PAYMENT_SELECTION_TWO,'2'
            JE FINISH_CASH_INPUT_INTERCHANGE ;QUIT
            CMP PAYMENT_SELECTION_TWO,'1'
            JNE	INVALID_CASH_INPUT
            JMP INPUT_CASH_AGAIN

        ;;;;;;;;;

    END_OF_CASH_INPUT:

        MOV AH,09H
        LEA DX,NL
        INT 21H
        CALL DISPLAY_DASH
        LEA DX,NL
        INT 21H

        MOV AH,09H
        LEA DX,TOTAL_AMOUNT_MESSAGE
        INT 21H

        FINIT
        ; Display the total amount
        FLD DWORD PTR [TOTALAMOUNT]
        FILD WORD PTR [FACTOR] ; Load factor
        FMUL
        FISTP result          ; Store integer part in result
        CALL DISPF

        MOV AH,09H
        LEA DX,NL  
        INT 21H
        LEA DX,PAID_AMOUNT
        INT 21H
        LEA DX,RM
        INT 21H

        MOV AX,TDI
        CMP AX,0
        JNE PRICE_GOT_DECIMAL

            ;PRICE_DON'T_GOT_DECIMAL
            ;Display the result using DISPF
            FINIT
            FILD WORD PTR [PAIDAMOUNT_INT]  ; Load num1 into the FPU stack
            FILD WORD PTR [factor] ; Load factor
            FMUL
            FISTP result          ; Store integer part in result
            CALL DISPF
            FINIT
            FILD WORD PTR [PAIDAMOUNT_INT]  ; Load num1 into the FPU stack
            FSTP DWORD PTR [PAIDAMOUNT_TOTAL]
            FINISH_CASH_INPUT_INTERCHANGE:
                JMP FINISH_CASH_INPUT

        PRICE_GOT_DECIMAL:
        ;Display the result using DISPF
        FINIT
        FILD WORD PTR [PAIDAMOUNT_INT]  ; Load num1 into the FPU stack
        FISTP result          ; Store integer part in result
        CALL DISPF
        FINIT
        FILD WORD PTR [PAIDAMOUNT_INT]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FDIV
        FSTP DWORD PTR [PAIDAMOUNT_TOTAL]

        FINISH_CASH_INPUT:

        ;NOW NEED TO CHECK IF THE PRICE ENTER IS ENOUGH TO PAY
        FLD DWORD PTR [TOTALAMOUNT]
        FLD DWORD PTR [PAIDAMOUNT_TOTAL]
        FCOM                            ; Compare total amount and paid amount
        FSTSW PAYMENT_STATUS_WORD   ; Store the floating-point status word in memory
        MOV AX, PAYMENT_STATUS_WORD ; Move the status word into AX
        SAHF                            ; Transfer status to flags

        JAE GO_TO_PAY         ; jump if enough to pay, if not, go below

            INSUFFICIENT_CASH_INPUT:
            ;IF INSUFFICIENT,PROMPT AGAIN?
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            
            LEA DX,PINSUFFICIENT
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,QUIT
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT 
            LEA DX,PROMPOPT
            INT 21H
            
            MOV AH,01H
            INT 21H
            MOV PAYMENT_SELECTION_TWO,AL

            MOV AH,09H
            LEA DX,NL
            INT 21H
            
            CMP PAYMENT_SELECTION_TWO,'2'
            JE FINISH_ALL ;QUIT
            CMP PAYMENT_SELECTION_TWO,'1'
            JNE INSUFFICIENT_CASH_INPUT
            JMP INPUT_CASH_AGAIN

        ;;;;;;;;;

        GO_TO_PAY:
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H

            LEA DX,CHANGE_AMOUNT
            INT 21H
            LEA DX,RM
            INT 21H

            FLD DWORD PTR [TOTALAMOUNT]
            FSTP DWORD PTR [TEMP_TOTAL_AMOUNT]
            FINIT
            FLD DWORD PTR [PAIDAMOUNT_TOTAL]
            FLD DWORD PTR [TEMP_TOTAL_AMOUNT]
            FSUB
            FILD WORD PTR [FACTOR]
            FMUL
            FISTP result
            CALL DISPF

        FINISH_ALL:

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    CASHCHANGE ENDP


    DEDUCTBOOK PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

        MOV CX,8
        MOV SI,0
        MOV DI,0
        MOV BX,0
        DEDUCT:
        XOR BX,BX
            MOV BL,BOOK_ORDER_QUANTITY[DI]
            SUB LeftQuantity[SI],BX
            ADD SoldQuantity[SI],BX
            ADD SI,2
            INC DI
        LOOP DEDUCT

        ;MOV CX,8
        ;MOV DI,0
        ;INITIALIZE_BOOK_ORDER_QUANTITY:
            ;MOV BOOK_ORDER_QUANTITY[DI],0
            ;INC DI
        ;LOOP INITIALIZE_BOOK_ORDER_QUANTITY

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    DEDUCTBOOK ENDP


    DISPLAY_DASH PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

        MOV CX,80
        DASH:
                MOV AH,02H			;LOOP TO PRINT THE LINE
                MOV DL,'-'
                INT 21H
                
        LOOP DASH

            ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    DISPLAY_DASH ENDP


    ORDER_CONFIRMATION PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

    lOOP_ORDER_CONFIRMATION:
        MOV AH,09H
        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H
            
        lEA DX,ORDER_CONFIRMATION_MESSAGE
        INT 21H
            
        LEA DX,NL
        INT 21H
            
        ;Confirm?
        MOV AH,02H
        MOV DL,'1'
        INT 21H
            
        MOV AH,09H
        LEA DX,DOT
        INT 21H
            
        LEA DX,ORDER_CONFIRM
        INT 21H
            
        LEA DX,NL
        INT 21H
            
        ;Quit?
        MOV AH,09H	
        LEA DX,QUIT
        INT 21H
            
        LEA DX,NL
        INT 21H
            
        ;PROMT USER INPUT 
        LEA DX,PROMPOPT
        INT 21H
            
        MOV AH,01H
        INT 21H
        MOV PAYMENT_SELECTION_TWO,AL
            
        CMP PAYMENT_SELECTION_TWO,'1'
        JE ORDER_CONFIRMED ;order confirm
        CMP PAYMENT_SELECTION_TWO,'2'
        JE ORDER_CANCEL_INTERCHANGE

            INVALID_ORDER_CONFIRM_INPUT:
            ;IF INVALID,PROMPT CONTINUE?
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            
            LEA DX,PINVALID
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,QUIT
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT 
            LEA DX,PROMPOPT
            INT 21H
            
            MOV AH,01H
            INT 21H
            MOV PAYMENT_SELECTION_TWO,AL
            
            CMP PAYMENT_SELECTION_TWO,'2'
            JE ORDER_CANCEL
            CMP PAYMENT_SELECTION_TWO,'1'
            JNE INVALID_ORDER_CONFIRM_INPUT
            JMP lOOP_ORDER_CONFIRMATION ;order confirm

            ORDER_CANCEL_INTERCHANGE:
            JMP ORDER_CANCEL

        ;;;;;;;;;

        ORDER_CONFIRMED:
        ;DISPLAY ORDER CONFIRM
        MOV AH,09

        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H

        MOV AH,09H
        LEA DX,ORDER_CONFIRM_MESSAGE
        INT 21H
        ;UPDATE ITERATTION
        INC COUNT_PAYMENT_MADE
        ;STORE ARRAY HERE, AND DEDUCT QUANTITY, ALL KIND OF UPDATE	
        CALL DEDUCTBOOK
        ; Store total amount in TOTALAMOUNT
        ;MOV AX,COUNT_PAYMENT_MADE
        ;DEC COUNT_PAYMENT_MADE
        ;MOV DI,AX
        ;FLD DWORD PTR [TOTALAMOUNT] 
        ;FSTP DWORD PTR [TOTALP[DI]]
        JMP END_OF_PAYMENT

        ;;;;;
        ORDER_CANCEL:
        ;DISPLAY ORDER CANCEL
        MOV AH,09  

        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H

        LEA DX,ORDER_CANCEL_MESSAGE
        INT 21H

        END_OF_PAYMENT:

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    ORDER_CONFIRMATION ENDP
;;;;;PAYMENT FUNCTION END




;REPORT_FUNCTION
    REPORT_FUNCTION_MAIN PROC

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

        EXITMENU:
            RET

    REPORT_FUNCTION_MAIN ENDP


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

        RET
    VIEWINVENTORYREPORT ENDP
;;;;;

END MAIN