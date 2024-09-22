.MODEL SMALL
.STACK 100
.DATA


;User Login Data
	;Account
	USERNAME DB "TARUMT$"
	PASS DB "1234$"
	PASSLENGTH DW 4

    ;Message and User Input
    LOGIN_PAGE_HEADER DB "                                   LOGIN PAGE",0AH,0DH,"$"
	INVALID_PASSWORD_USERNAME DB "Invalid Username or Password!!!$"   
	SUCCESS_LOGIN DB "LOGIN SUCCESSFULLY!$"
	PROMPPASS DB "Enter password: $"
	PTITLE DB "                             TARUMT Book Store POS",0AH,0DH,"$"
	PROMPUSN DB "Enter username: $"
    QUIT_LOGIN DB "2.  Quit POS System$"

    ;User Name Input String
	STRU LABEL BYTE
	MAXNU DB 20
	ACTNU DB ?
	INPUTUSN DB 20 DUP("$")
	
    ;Password Input String
    INPUT_PASS_LENGTH DW ?
    USER_PASS DB 100 DUP(0) 
;;;;;


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


;Author Data
	KWY DB "Koh Win Yee$"
	CJY DB "Chiam Jian Yu$"
	LZY DB "Lau Zi Lin$"
	LXY DB "Loke Xin Yee$"

	AUTHOR DW OFFSET KWY, OFFSET KWY, OFFSET CJY, OFFSET CJY, OFFSET LZY, OFFSET LZY, OFFSET LXY, OFFSET LXY

	AUTHOR1 DB "3KOH$","5CHIAM$","3LAU$","4LOKE$"
;;;;;


;Genre Data
	HORROR DB "Horror        $"
    ROMANCE DB "Romance       $"
    ADVENTURE DB "Adventure     $"
    NON_FICTION DB "Non-fiction   $"
    EDUCATION DB "Education     $"

	GENRE DW OFFSET ROMANCE, OFFSET HORROR, OFFSET ADVENTURE, OFFSET EDUCATION, OFFSET ROMANCE
            DW OFFSET NON_FICTION, OFFSET HORROR, OFFSET ROMANCE

	;H1 DB "Horror$"
    ;R1 DB "Romance$"
    ;A1 DB "Adventure$"
    ;N1 DB "Non-fiction$"
    ;EDUC DB "Education$"

    GENRE_DISPLAY DW OFFSET HORROR, OFFSET ROMANCE, OFFSET ADVENTURE
                    DW OFFSET NON_FICTION, OFFSET EDUCATION

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


;Search Function Data
    ;User Input String
	SEARCH_INPUT_STRING LABEL BYTE
	MAXS DB 50
	ACTS DB ?
	INPUTSTR DB 50 DUP("$")	

	BOOKNAME_FOR_SEARCH DB "7WHISPERS$", "4ECHO$", "6LOCKET$", "6WILLOW$", "10RENDEZVOUS$", "7CRIMSON$", "7SHADOWS$", "8MEMORIES$"

    SEARCH_MENU_1 DB "1.  Search by title$"
	SEARCH_MENU_2 DB "2.  Search by author$"
	SEARCH_MENU_3 DB "3.  Search by genre$"
	SEARCH_MENU_4 DB "4.  Display all$"
	SEARCH_MENU_5 DB "5.  Back to Main Menu$"
	CONFIRM_SELECTION DB "You have select $"
	INPUT_BOOK_TITLE DB "Please enter the book title (CAPITAL LETTER ONLY): $"
	D_TITLE DB "TITLE : $"
	D_PRICE DB "PRICE : $"
	D_LQ DB "LEFT_QUANTITY : $"
	D_GENRE DB "GENRE : $"
	D_AUTHOR DB "AUTHOR : $"
	HEARDER_H DB "Here are the Horror books.$"
	HEARDER_R DB "Here are the Romance books.$"
	HEARDER_A DB "Here are the Adventure books.$"
	HEARDER_NF DB "Here are the Non-Fiction books.$"
	HEARDER_E DB "Here are the Education books.$"
	BOOK_SEARCH_MAIN_HEADER DB 0AH,0DH,"                                  BOOK SEARCH", 0AH,0DH, "$"
	HEARDER_SEARCH_TITLE DB 0AH,0DH,"                              SEARCH BY BOOK TITLE", 0AH,0DH, "$"
	HEARDER_SEARCH_GENRE DB 0AH,0DH,"                              SEARCH BY BOOK GENRE", 0AH,0DH, "$"
	HEARDER_SEARCH_AUTHOR DB 0AH,0DH,"                             SEARCH BY BOOK AUTHOR", 0AH,0DH, "$"
	HEARDER_SEARCH_ALL DB 0AH,0DH,"                              DISPLAY ALL BOOKS", 0AH,0DH, "$"
	QUESTION_ONE DB "Enter your choice: $"
	QUESTION_TWO DB "Enter your choice (Enter 1 for Horror): $"
	QUESTION_THREE DB "Do you want to search for another?  (Y/N) : $"
	QUESTION_FOUR DB "Please enter the author last name (LOKE XIN YEE = LOKE): $"
	ERROR_MESSAGE_ONE DB "Invalid input. Please enter again.$"
	ERROR_MESSAGE_TWO DB "Cannot found the book title. Please enter again.$"
	ERROR_MESSAGE_THREE DB "Cannot found the author. Please enter again.$"
	SEARCH_SELECTION_ONE DB ?
    SEARCH_SELECTION_TWO DB ?
	SEARCH_SELECTION_THREE DB ?
	COLUMN_DIS_ALL_HEADERS DB 'No. Title           Price(RM)   Left Quantity   Genre         Author', 0DH, 0AH, '$'
	COLUMN_DIS_GENRE_HEADERS DB 'Title           Price(RM)   Left Quantity   Author', 0DH, 0AH, '$'
    COLUMN_DIS_TITLE_HEADERS DB 'Title           Price(RM)   Left Quantity   Genre         Author', 0DH, 0AH, '$'
	ALL_PRICE_COLUMN_SPACE DB '       ', '$'
	ALL_LQ_COLUMN_SPACE DB '             ', '$'
	ALL_AUTHOR_COLUMN_SPACE DB '   ', '$'
;;;;;


;Create Order Data
    CREATE_HEADER DB 0AH,0DH,"                                  CREATE ORDER", 0AH,0DH, "$"
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
    PAYMENT_MAIN_HEADER DB 0AH,0DH,"                                  PAYMENT", 0AH,0DH, "$"
	NL DB 0AH,0DH,"$"
	PAYMENT_METHOD_MESSAGE DB "Payment Method$"
	PROMPOPT DB 0AH,0DH,"Enter your selection: $"
	PAID_AMOUNT DB 0AH,0DH,"Paid Amount (RM)        : $"
	CHANGE_AMOUNT DB 0AH,0DH,"Change Amount (RM)      : $"
	PINVALID DB "Invalid Input!!!$"
	PINSUFFICIENT DB "Insufficient Amount!!!$"
	ORDER_CONFIRMATION_MESSAGE DB "Confirm to Place Order?$"
	ORDER_CONFIRM DB "Confirm$"
	ORDER_CANCEL_MESSAGE DB "Payment cancelled.$"
	ORDER_CONFIRM_MESSAGE DB "Payment has made successfully!!!", 0AH,0DH, "$"
	ENTAGN DB "1.  Enter again$"
    CANCEL_PAYMENT_MESSAGE DB "2.  Cancel Payment$"
	DOT DB ".  $"
	PRINT_MIDDLE DB "			   	    $"
	TAB DB "             $"
	EACHAMOUNT DD 10 DUP(0.0)
	TOTALAMOUNT DD 0.0
	PAYMENT_SELECTION_ONE DB ?
	PAYMENT_SELECTION_TWO DB ?
	TOTAL_AMOUNT_MESSAGE DB "Grand Total Amount (RM) : $"
	PROMPTPAY DB "	Enter Amount Paid (RM) : $"
    PAYMENT_HEADER DB 'No. Title           Price(RM)   Quantity    Total Amount(RM)', 0DH, 0AH, '$'
	GRAND_TOTAL_AMOUNT_PREFIX DB "                           $"

	;ITERATTION COUNT
	PAYMENT_LOOP_COUNT DB ?
    TEMP_BOOK_QUANTITY DW ?

	;User Input pay amount if using cash
	PAIDAMOUNT_INT DW 0
	PAIDAMOUNT_TOTAL DD 0.0
	PAYMENT_STATUS_WORD DW ?
	TEMP_TOTAL_AMOUNT DD 0.0
;;;;;


;Payment Link to Report Data
    ;Book sold quantity
    SoldQuantity DW 10 DUP(00)
;;;;;


;Report Data
    REPORTMENU DB "                                  REPORT MENU",0AH,0DH,"$"
    OPTION_TOTAL_SALES DB "1. View Total Sales Report$"
    OPTION_INVENTORY DB "2. View Inventory Report$"
    OPTION_RETURN DB "3. Return Main Menu$"
    PROMPTMSG DB "Enter Choice (1-3): $"
    REPORTCHOICE DB ?
    INAVLIDMSG DB "Invalid Choice, Try Again.$"
    TOTAL_SALES_TITLE DB 0AH,0DH,"                              TOTAL SALES REPORT",0AH,0DH,"$"
    INVENTORY_TITLE DB 0AH,0DH,"                                INVENTORY REPORT",0AH,0DH,"$"
    ;BUFFER      DB 6 DUP (?)  ; Buffer to store the ASCII digits
    SALESRPT_HEADER DB "No. Title         Price(RM)      Sold Quantity     Total(RM)$"
    INVENTORYRPT_HEADER DB "No. Title           Stock Quantity$"
    SPACE_PREFIX DB "             $"
;;;;;


;General Display Data
    OPTION DB ?
    TEN DB 10
    HUNDRED DB 100
    THOUSAND DW 1000
	TEN_THOUSAND DW 10000

    MAIN_MENU_HEADER DB "                                   MAIN MENU",0AH,0DH,"$"
;;;;;


;Temporary Main Menu Display Data and Selection for Testing Purposes
    MAIN_MENU_MESSAGE DB "Choose Function:  $"
    SEARCH_BOOK_FUNCTION_SELECTION DB "1.  SEARCH BOOK$"
    CREATE_ORDER_FUNTION_SELECTION DB "2.  CREATE ORDER$"
    REPORT_FUNCTION_SELECTION DB "3.  VIEW REPORT$"
    QUIT_MAIN_MENU_SELECTION DB "4.  QUIT$"
    MAIN_MENU_SELECTION DB ?
    MAIN_MENU_INVALID_MESSAGE DB 0AH,0DH,"INVALID INPUT, INPUT AGAIN!!!",0AH,0DH,"$"
;;;;;




.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

        CALL LOGIN_FUNCTION
        CMP AL,0
        JNE EXIT_WHOLE_FUNCTION
        
        CALL MAIN_MENU
   

    EXIT_WHOLE_FUNCTION:
        MOV AX, 4C00H
        INT 21H
MAIN ENDP




;MAIN_MENU
    MAIN_MENU PROC
        MAIN_AGAIN:
        ;MAIN MENU HERE
        MOV AH,09H 
        LEA DX,NL   
        INT 21H
        LEA DX,NL   
        INT 21H
        LEA DX,MAIN_MENU_HEADER
        INT 21H
        LEA DX,NL   
        INT 21H
        LEA DX,SEARCH_BOOK_FUNCTION_SELECTION
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
        LEA DX,QUIT_MAIN_MENU_SELECTION
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
        ;SEARCH BOOK FUNCTION
        CALL SEARCH_BOOK_FUNCTION_MAIN
        JMP MAIN_AGAIN

        CHECK_NEXT:
        CMP MAIN_MENU_SELECTION,'2'
        JNE CHECK_NEXT_TWO
        ;CREATE ORDER FUNCTION
        CALL CREATE_ORDER_FUNCTION_MAIN      ;CALL PAYMENT FUNCTION IN CREATE ORDER FUNCTION
        JMP MAIN_AGAIN


        CHECK_NEXT_TWO:
        CMP MAIN_MENU_SELECTION,'3'
        JNE QUIT_MAIN
        ;REPORT FUNCTION
        CALL REPORT_FUNCTION_MAIN
        JMP MAIN_AGAIN

        QUIT_MAIN:
        CMP MAIN_MENU_SELECTION,'4'
        JE EXIT_MAIN_MENU

            MOV AH,09H
            LEA DX,MAIN_MENU_INVALID_MESSAGE
            INT 21H  
            JMP MAIN_AGAIN

        EXIT_MAIN_MENU:

        RET
    MAIN_MENU ENDP
;;;;;




;LOGIN_FUNCTION
    LOGIN_FUNCTION PROC

            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,PTITLE
            INT 21H
            LEA DX,NL
            INT 21H
            LEA DX,LOGIN_PAGE_HEADER
            INT 21H

        LOGIN:
            MOV AH,09H
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

            MOV SI,0
            LOOP_INPUT_PASS:
            
                MOV AH,07H
                INT 21H

                MOV USER_PASS[SI],AL   

                CMP AL, 0DH                         ;Check if Enter is pressed (0Dh in ASCII)
                JE END_OF_PASS_INPUT                ;If enter is pressed, then end the input loop

                MOV AH,02H  
                MOV DL,'*'
                INT 21H  

                INC SI
            JMP LOOP_INPUT_PASS

            END_OF_PASS_INPUT:
            MOV INPUT_PASS_LENGTH,SI

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
            MOV CX,INPUT_PASS_LENGTH
            VERIFYP:

                MOV BL,USER_PASS[SI]
                CMP PASS[SI],BL
                JNE INVALID
                
                INC SI
                
            LOOP VERIFYP


            MOV AX,PASSLENGTH
            CMP INPUT_PASS_LENGTH,AX
            JNE INVALID
            
            MOV AH,09H
            LEA DX,SUCCESS_LOGIN
            INT 21H
            JMP FINISH_LOGIN_SUCCESS


            INVALID:
                MOV AH,09H
                LEA DX,NL
                INT 21H
                LEA DX,INVALID_PASSWORD_USERNAME
                INT 21H

                ;IF INVALID,PROMPT CONTINUE?
                LEA DX,NL
                INT 21H
                
            INVALID_AGAIN:

                ;Enter Again?
                MOV AH,09H
                LEA DX,ENTAGN
                INT 21H
                
                LEA DX,NL
                INT 21H
                
                ;Quit?
                MOV AH,09H
                LEA DX,QUIT_LOGIN
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
                JE LOGIN_INTERCHANGE                        ;Let User input Username and Password again
                CMP MAIN_MENU_SELECTION,'2'
                JE FINISH_LOGIN_FAILED

                MOV AH,09H
                LEA DX,NL
                INT 21H
                LEA DX,MAIN_MENU_INVALID_MESSAGE
                INT 21H
                JMP INVALID_AGAIN


            LOGIN_INTERCHANGE:
                JMP LOGIN


            FINISH_LOGIN_SUCCESS:
                MOV AL,0
                RET

            FINISH_LOGIN_FAILED:
                MOV AL,1
                RET

    LOGIN_FUNCTION ENDP
;;;;;




;SEARCH_BOOK_FUNCTION
    SEARCH_BOOK_FUNCTION_MAIN PROC
        CALL SEARCH_MENU ;Display the search function menu 
        CMP BX,0 
        JE RETURN_FROM_SEARCH

	;Display the message to ask the user want to continue searching or not
        CONTINUE_9:

        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV AH,09H
        LEA DX,NL
        INT 21H

	;ask the user want to continue searching or not
        MOV AH,09H
        LEA DX,QUESTION_THREE
        INT 21H

        ;get answer
        MOV AH,01H
        INT 21H
        MOV SEARCH_SELECTION_THREE,AL

        MOV AH,09H
        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H

	;Compare the anser is Y or not
        CMP SEARCH_SELECTION_THREE,'Y'
        JE CALL_MENU

        CMP SEARCH_SELECTION_THREE,'y'
        JE CALL_MENU

        CMP SEARCH_SELECTION_THREE,'N'
        JE RETURN_FROM_SEARCH

        CMP SEARCH_SELECTION_THREE,'n'
        JE RETURN_FROM_SEARCH 

            MOV AH,09H
            LEA DX,ERROR_MESSAGE_ONE
            INT 21H

            LEA DX,NL
            INT 21H 

        JMP CONTINUE_9

    ;If equal to n go back to the main menu

        CALL_MENU:
            CALL SEARCH_MENU

        RETURN_FROM_SEARCH:
            MOV BX,0
            RET

    SEARCH_BOOK_FUNCTION_MAIN ENDP


    AUTHOR_F PROC

	;Display the header
        MOV AH,09H
        LEA DX,NL
        INT 21H

        LEA DX,HEARDER_SEARCH_AUTHOR
        INT 21H

        LEA DX,NL
        INT 21H

        AUTHOR_L:
        LEA DX,NL
        INT 21H

	;Ask user enter the author name
        LEA DX,QUESTION_FOUR
        INT 21H

        ;get input in string
        MOV AH,0AH
        LEA DX,SEARCH_INPUT_STRING
        INT 21H

        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;Compare the input with KOH character by character
        KOH_CBC:
        MOV CL,ACTS
        MOV SI,1
        MOV DI,0
        MOV BL,0
        KOH:

            MOV BH,AUTHOR1[SI]
            CMP INPUTSTR[DI],BH
            JNE CHIAM_CBC ;if the input not same with current author will jump to next author

            INC SI
            INC DI
            INC BL

        LOOP KOH

	    ;Compare the length 
            KOH_LENGTH:
            MOV SI,0
            MOV DL,BL
            ADD DL,30H
            CMP DL,AUTHOR1[SI]
            JNE CHIAM_CBC ;if the input not same current author jump to next author

            JMP WP ;if the input same with current author will jump to the book information

        ;Compare the input with CHIAM character by character
        CHIAM_CBC:
        MOV CL,ACTS
        MOV SI,6
        MOV DI,0
        MOV BL,0
        CHIAM:

            MOV BH,AUTHOR1[SI]
            CMP INPUTSTR[DI],BH 
            JNE LAU_CBC ;if the input not same with current author will jump to next author

            INC SI
            INC DI
            INC BL

        LOOP CHIAM

	    ;Compare the length
            CHIAM_LENGTH:
            MOV SI,5
            MOV DL,BL
            ADD DL,30H
            CMP DL,AUTHOR1[SI]
            JNE LAU_CBC  ;if the input not same current author jump to next author

            JMP LK ;if the input same with current author will jump to the book information

        ;Compare the input with LAU character by character
        LAU_CBC:
        MOV CL,ACTS
        MOV SI,13
        MOV DI,0
        MOV BL,0
        LAU:

            MOV BH,AUTHOR1[SI]
            CMP INPUTSTR[DI],BH
            JNE LOKE_CBC ;if the input not same with current author will jump to next author

            INC SI
            INC DI
            INC BL

        LOOP LAU

	    ;Compare the length
            LAU_LENGTH:
            MOV SI,12
            MOV DL,BL
            ADD DL,30H
            CMP DL,AUTHOR1[SI]
            JNE LOKE_CBC ;if the input not same with current author will jump to next author

            JMP RD ;if the input same with current author will jump to the book information

        ;Compare the input with LOKE character by character
        LOKE_CBC:
        MOV CL,ACTS
        MOV SI,18
        MOV DI,0
        MOV BL,0
        LOKE:

            MOV BH,AUTHOR1[SI]
            CMP INPUTSTR[DI],BH
            JNE ER ;if the input not same with current author will jump the error message 

            INC SI
            INC DI
            INC BL

        LOOP LOKE

	    ;Compare the length
            LOKE_LENGTH:
            MOV SI,17
            MOV DL,BL
            ADD DL,30H
            CMP DL,AUTHOR1[SI]
            JNE ER ;if the input not same with current author will jump the error message 

            JMP SD ;if the input same with current author will jump to the book information
            

        ER:
        JMP ERROR_A ;Jump to the error message

	;WHISPERS
        WP:
        
		CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,0
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      

        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,0
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF  

        MOV AH, 09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,0
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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

		MOV AH, 09H          ; print string
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,0
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,0
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE

        LEA DX,NL
        INT 21H

	;ECHO
        EH:

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,2
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      

        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,4
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,2
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,2
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,2
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;LOCKET
        LK:
        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,4
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,8
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,4
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,4
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H  

        MOV SI,OFFSET AUTHOR
        ADD SI,4
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        MOV AH,09H
        LEA DX,NL
        INT 21H


	;Willow
        WL:

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,6
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,12
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,6
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,6
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,6
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not


	;Rendezvous
        RD:
        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,8
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ;Price
        ; Load the floating-point values into the FPU and multiply
        MOV DI,16
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,8
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,8
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,8
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H 

        MOV AH,09H
        LEA DX,NL
        INT 21H


	;CRIMSON
        CR:
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,10
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ;Price
        ; Load the floating-point values into the FPU and multiply
        MOV DI,20
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,10
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,10
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,10
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;Shadows
        SD:
        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,12
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H       
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,24
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,12
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,12
        MOV AX, [SI]            
        MOV DX, AX             
        MOV AH, 09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,12
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

		LEA DX,NL 
		INT 21H 

	;Memories
        MM:
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,14
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H     
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,28
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF 

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,14
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book Genre
        MOV SI,OFFSET GENRE
        ADD SI,14
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H  

        MOV SI,OFFSET AUTHOR
        ADD SI,14
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H 

        LEA DX,NL
        INT 21H
        
        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not
        

        ;Invalid input
        ERROR_A:
                MOV AH,09H
                LEA DX,ERROR_MESSAGE_THREE ;Display the error message and ask the user enter again
                INT 21H

                LEA DX,NL
                INT 21H
                JMP AUTHOR_L ;Jump to the AUTHOR_L again 


        FIN_A:

        RET

    AUTHOR_F ENDP


    TITLE_F PROC

	;Display the header
        MOV AH,09H
        LEA DX,HEARDER_SEARCH_TITLE 
        INT 21H

        LEA DX,NL
        INT 21H

        TITLE_L:
        ;Ask user enter the book title
        LEA DX,NL
        INT 21H

        LEA DX,INPUT_BOOK_TITLE
        INT 21H

        ;get input in string
        MOV AH,0AH
        LEA DX,SEARCH_INPUT_STRING
        INT 21H

        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;Compare the input with WHISPERS character by character
        WHISPERS_CBC:
        MOV CL,ACTS
        MOV SI,1
        MOV DI,0
        MOV BL,-1
        L2:

            MOV BH,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],BH
            JNE ECHO_CBC ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BL

        LOOP L2

	    ;Compare the length
            WHISPERS_LENGTH:
            MOV SI,0
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE ECHO_CBC ;if the input and the current book not same, jump to next book

            JMP WP1 ;if the input and the current book is same, jump to display the book information


        ;Compare the input with ECHO character by character
        ECHO_CBC:
        MOV CL,ACTS
        MOV SI,11
        MOV DI,0
        MOV BL,0
        L3:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE LOCKET_CBC ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BL

        LOOP L3

	    ;Compare the length
            ECHO_LENGTH:
            MOV SI,10
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE LOCKET_CBC ;if the input and the current book not same, jump to next book

            JMP EH1 ;if the input and the current book is same, jump to display the book information

       ;Compare the input with LOCKET character by character
        LOCKET_CBC:
        MOV CL,ACTS
        MOV SI,17
        MOV DI,0
        MOV BL,0
        L4:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE WILLOW_CBC ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BL

        LOOP L4

	    ;Compare the length
            LOCKET_LENGTH:
            MOV SI,16
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE WILLOW_CBC ;if the input and the current book not same, jump to next book

            JMP LK1 ;if the input and the current book is same, jump to display the book information

        ;Compare the input with WILLOW character by character
        WILLOW_CBC:
        MOV CL,ACTS
        MOV SI,25
        MOV DI,0
        MOV BL,0
        L5:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE RD_CBC ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BL

        LOOP L5

	    ;Compare the length
            WILLOW_LENGTH:
            MOV SI,24
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE RD_CBC ;if the input and the current book not same, jump to next book

            JMP WL1 ;if the input and the current book is same, jump to display the book information

        ;Compare the input with RENDEZVOUS character by character
        RD_CBC:
        MOV CL,ACTS
        MOV SI,34
        MOV DI,0
        MOV BX,0
        L6:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE CRIMSON_CBC  ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BX

        LOOP L6

            JMP RD1 ;if the input and the current book is same, jump to display the book information

        ;Compare the input with CRIMSON character by character
        CRIMSON_CBC:
        MOV CL,ACTS
        MOV SI,46
        MOV DI,0
        MOV BL,0
        L7:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE SHADOWS_CBC  ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BL

        LOOP L7

	    ;Compare the length
            CRIMSON_LENGTH:
            MOV SI,45
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE SHADOWS_CBC  ;if the input and the current book not same, jump to next book

            JMP CR1 ;if the input and the current book is same, jump to display the book information

       ;Compare the input with SHADOWS character by character
        SHADOWS_CBC:
        MOV CL,ACTS
        MOV SI,55
        MOV DI,0
        MOV BL,0
        L8:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE MEMORIES_CBC ;if the input and the current book not same, jump to next book

            INC SI
            INC DI
            INC BL

        LOOP L8

	    ;Compare the length
            SHADOWS_LENGTH:
            MOV SI,54
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE MEMORIES_CBC ;if the input and the current book not same, jump to next book

            JMP SD1 ;if the input and the current book is same, jump to display the book information

        ;Compare the input with MEMORIES character by character
        MEMORIES_CBC:
        MOV CL,ACTS
        MOV SI,64
        MOV DI,0
        MOV BL,0
        L9:

            MOV AL,BOOKNAME_FOR_SEARCH[SI]
            CMP INPUTSTR[DI],AL
            JNE ER2  ;if the input and the current book not same, display the error message

            INC SI
            INC DI
            INC BL

        LOOP L9

	    ;Compare the length
            MEMORIES_LENGTH:
            MOV SI,63
            MOV DL,BL
            ADD DL,30H
            CMP DL,BOOKNAME_FOR_SEARCH[SI]
            JNE ER2 ;if the input and the current book not same, display the error message

            JMP MM1 ;if the input and the current book is same, jump to display the book information

        ER2:
            JMP ERROR_T

		;WHISPERS
        WP1:
		
		CALL DISPLAY_DASH

        MOV AH,09H
		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,0
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      

        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,0
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF  

        MOV AH, 09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,0
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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

		MOV AH, 09H          ; print string
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,0
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,0
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;ECHO
        EH1:

       	CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,2
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      

        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,4
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,2
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,2
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,2
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;LOCKET
        LK1:

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,4
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,8
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,4
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,4
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H  

        MOV SI,OFFSET AUTHOR
        ADD SI,4
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;WILLOW
        WL1:

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,6
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,12
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,6
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,6
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,6
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;RENDEZVOUS
        RD1:

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,8
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ;Price
        ; Load the floating-point values into the FPU and multiply
        MOV DI,16
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,8
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,8
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,8
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

		;CRIMSON
        CR1:

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,10
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ;Price
        ; Load the floating-point values into the FPU and multiply
        MOV DI,20
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,10
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,10
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,10
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;SHADOWS
        SD1:

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,12
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H       
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,24
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,12
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book genre
        MOV SI,OFFSET GENRE
        ADD SI,12
        MOV AX, [SI]            
        MOV DX, AX             
        MOV AH, 09H           
        INT 21H 

        MOV SI,OFFSET AUTHOR
        ADD SI,12
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        LEA DX,NL
        INT 21H

        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

	;MEMORIES
        MM1:

       CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_TITLE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,14
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H     
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,28
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF 

        MOV AH,09H
        LEA DX,ALL_PRICE_COLUMN_SPACE
        INT 21H

        ;Display left quantity
        MOV SI,14
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
        LEA DX,ALL_LQ_COLUMN_SPACE
        INT 21H

        ;Display book Genre
        MOV SI,OFFSET GENRE
        ADD SI,14
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H  

        MOV SI,OFFSET AUTHOR
        ADD SI,14
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

        MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H 

        LEA DX,NL
        INT 21H
        
        JMP CONTINUE_9 ;End this author and jump to continue_9 to ask the user want to continue or not

        ;Invalid input
        ERROR_T:
                MOV AH,09H
                LEA DX,ERROR_MESSAGE_TWO ;Display the error massege and ask the user enter again
                INT 21H

                LEA DX,NL
                INT 21H
                JMP TITLE_L ;jump to the TITLE_L
        RET
    TITLE_F ENDP


    GENRE_F PROC

	;Display the header
        MOV AH,09H
        LEA DX,NL
        INT 21H

        LEA DX,HEARDER_SEARCH_GENRE
        INT 21H

        LEA DX,NL
        INT 21H

        GENRE_L:
	;display all genre
        LEA DX,NL
        INT 21H

        MOV CX,5
        MOV SI,0
        MOV BOOK_NO,1
        SEARCH_BOOK_DISPLAY_GENRE:
            ; Print the genre number
        
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
            MOV DX,GENRE_DISPLAY[SI]
            INT 21H

            LEA DX,NL
            INT 21H

            ADD SI,2

        LOOP SEARCH_BOOK_DISPLAY_GENRE
        ;;;;;

        LEA DX,NL
        INT 21H

        LEA DX,NL
        INT 21H

        ;ask user enter thier choose
        LEA DX,QUESTION_TWO
        INT 21H

        ;get input
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV SEARCH_SELECTION_TWO,AL

        MOV AH,09H
        LEA DX,NL
        INT 21H

        CMP SEARCH_SELECTION_TWO,1
        JAE CONTINUE_3 
        JMP ERROR_G     

        CONTINUE_3:
        CMP SEARCH_SELECTION_TWO,5
        JBE CONTINUE_4  
        JMP ERROR_G      

        CONTINUE_4:
        MOV AH,09H
        LEA DX,CONFIRM_SELECTION
        INT 21H

        MOV AH,02H
        MOV DL,SEARCH_SELECTION_TWO
        ADD DL,30H
        INT 21H

        MOV AH,09H 
        LEA DX,NL
        INT 21H

        ;If user enter 1 display Horror book
        CMP SEARCH_SELECTION_TWO,1
        JE HR

        CMP SEARCH_SELECTION_TWO,2
        JNE CONTINUE_5

        JMP RM

        CONTINUE_5:
        CMP SEARCH_SELECTION_TWO,3
        JNE CONTINUE_6

        JMP AV

        CONTINUE_6:
        CMP SEARCH_SELECTION_TWO,4
        JNE CONTINUE_7

        JMP NF

        CONTINUE_7:
        CMP SEARCH_SELECTION_TWO,5
        JNE ER3

        JMP ED

        ER3:
        JMP ERROR_G

        ;Horror
        HR:
        MOV AH,09H
		LEA DX,NL 
		INT 21H 

        ;Display what genre now
        LEA DX,HEARDER_H
        INT 21H

		LEA DX,NL 
		INT 21H

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_GENRE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;ECHO
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,2
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,4
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF      

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,2
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H


        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,2
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H
        
        ;SHADOWS
        ;Second book
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,12
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      

        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,24
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF  ;below no need, do until here is cukup     

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,12
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,12
        MOV AX, [SI]            
        MOV DX, AX             
        MOV AH, 09H           
        INT 21H 

		MOV AH,09H
		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

		LEA DX,NL 
		INT 21H 

        JMP CONTINUE_9

        ;Romance
        RM:
		MOV AH,09H
		LEA DX,NL 
		INT 21H 

        ;Display what genre now
        LEA DX,HEARDER_R
        INT 21H

        LEA DX,NL
        INT 21H

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_GENRE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;WHISPERS
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,0
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H       
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,0
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF     

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,0
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,0
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H
        
        ;MEMORIES
        ;Second book
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,14
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H       
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,28
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF   

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,14
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,14
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H
        
        ;RENDEZVOUS
        ;Third book
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,8
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,16
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,8
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,8
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        JMP CONTINUE_9

        ;Adventure
        AV:
		MOV AH,09H
		LEA DX,NL 
		INT 21H 

        ;Display what genre now
        LEA DX,HEARDER_A
        INT 21H

        LEA DX,NL
        INT 21H

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_GENRE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;LOCKET
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,4
        MOV AX, [SI]             ; Load the offset of the second book name into AX
        MOV DX, AX               ; Move the offset into DX (required for INT 21H)
        MOV AH, 09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,8
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF    

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,4
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,4
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        JMP CONTINUE_9

        ;Non-fiction
        NF:

		MOV AH,09H
		LEA DX,NL 
		INT 21H 

        ;Display what genre now
        LEA DX,HEARDER_NF
        INT 21H

        LEA DX,NL
        INT 21H

        CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_GENRE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;CRIMSON
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,10
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ; Load the floating-point values into the FPU and multiply
        MOV DI,20
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF   

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,10
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,10
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        JMP CONTINUE_9

        ;Education
        ED:

		MOV AH,09H
		LEA DX,NL 
		INT 21H 

        ;Display what genre now
        LEA DX,HEARDER_E
        INT 21H

		LEA DX,NL 
		INT 21H 

		CALL DISPLAY_DASH

		LEA DX,COLUMN_DIS_GENRE_HEADERS
		INT 21H

		CALL DISPLAY_DASH

        ;WILLOW
        ;Display bookname
        MOV SI,OFFSET BOOK
        ADD SI,6
        MOV AX,[SI]             ; Load the offset of the second book name into AX
        MOV DX,AX               ; Move the offset into DX (required for INT 21H)
        MOV AH,09H              ; DOS print string function
        INT 21H      
        
        ;Display bookprice
        ;Price
        ; Load the floating-point values into the FPU and multiply
        MOV DI,12
        FLD DWORD PTR [Price[DI]]  ; Load num1 into the FPU stack
        FILD WORD PTR [factor] ; Load factor
        FMUL                  ; Multiply result by factor to scale
        FISTP result          ; Store integer part in result

        CALL DISPF   

        MOV AH,09H
		LEA DX,ALL_PRICE_COLUMN_SPACE
		INT 21H

        ;Display left quantity
        MOV SI,6
        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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
		LEA DX,ALL_LQ_COLUMN_SPACE
		INT 21H

        ;Display book author
        MOV SI,OFFSET AUTHOR
        ADD SI,6
        MOV AX,[SI]            
        MOV DX,AX             
        MOV AH,09H           
        INT 21H 

		LEA DX,ALL_AUTHOR_COLUMN_SPACE
		INT 21H

        JMP CONTINUE_9

        ERROR_G:
                MOV AH,09H
                LEA DX,ERROR_MESSAGE_ONE
                INT 21H

                LEA DX,NL
                INT 21H
                JMP GENRE_L

        FIN_G:
        RET

    GENRE_F ENDP


    SEARCH_MENU PROC

        BOOK_SERACH_MENU_LABEL:

            MOV AH,09H
            LEA DX,NL
            INT 21H

            LEA DX,BOOK_SEARCH_MAIN_HEADER
            INT 21H

            LEA DX,NL
            INT 21H

            ;Display the menu
            MOV AH,09H
            LEA DX,SEARCH_MENU_1
            INT 21H
            
            LEA DX,NL
            INT 21H

            LEA DX,SEARCH_MENU_2
            INT 21H

            LEA DX,NL
            INT 21H

            LEA DX,SEARCH_MENU_3
            INT 21H

            LEA DX,NL
            INT 21H

            LEA DX,SEARCH_MENU_4
            INT 21H

            LEA DX,NL
            INT 21H

            LEA DX,SEARCH_MENU_5
            INT 21H

            LEA DX,NL
            INT 21H

            ;ask user enter thier choose
            MOV AH,09H
            LEA DX,QUESTION_ONE
            INT 21H

            ;get input
            MOV AH,01H
            INT 21H
            SUB AL,30H
            MOV SEARCH_SELECTION_ONE,AL

            MOV AH,09H
            LEA DX,NL
            INT 21H

            ;;;;;

            ;Display the selected option
                MOV AH,09H
                LEA DX,CONFIRM_SELECTION
                INT 21H

                MOV AH,02H
                MOV DL,SEARCH_SELECTION_ONE
                ADD DL,30H
                INT 21H

                MOV AH,09H
                LEA DX,NL
                INT 21H
            ;;;;;

            OP1:
            CMP SEARCH_SELECTION_ONE,1
            JNE OP2
            CALL TITLE_F
            JMP FIN

            OP2:
            CMP SEARCH_SELECTION_ONE,2
            JNE OP3
            CALL AUTHOR_F
            JMP FIN

            OP3:
            CMP SEARCH_SELECTION_ONE,3
            JNE OP4
            CALL GENRE_F
            JMP FIN

            OP4:
            CMP SEARCH_SELECTION_ONE,4
            JNE OP5
            CALL D_ALL
            JMP FIN


            OP5:
            CMP SEARCH_SELECTION_ONE,5
            JE EXIT_SEARCH_FUNCTION

            ;Invalid input
            ;ERROR:
                MOV AH,09H
                LEA DX,ERROR_MESSAGE_ONE
                INT 21H

                LEA DX,NL
                INT 21H
                JMP BOOK_SERACH_MENU_LABEL

            FIN:
                RET

            EXIT_SEARCH_FUNCTION:
                MOV BX,0   
                RET

    SEARCH_MENU ENDP


    D_ALL PROC

        MOV AH,09H
        LEA DX,NL
        INT 21H

        LEA DX,HEARDER_SEARCH_ALL
        INT 21H

        MOV AH,09H
        LEA DX,NL
        INT 21H

        CALL DISPLAY_DASH

        MOV AH,09H
        LEA DX,COLUMN_DIS_ALL_HEADERS
        INT 21H

        CALL DISPLAY_DASH

        MOV CX,8
        MOV SI,0
        MOV DI,0
        MOV BOOK_NO,1
        DISPLAY_SEARCH:    

            MOV AH, 02H          ; DOS interrupt to print character
            MOV DL, BOOK_NO           ; Load the book number into DL
            ADD DL, 30H          ; Convert number to ASCII (1 - 8)
            INT 21H

            INC BOOK_NO
            ; Print a period and space after the number
            MOV AH,09H
            LEA DX,DOT
            INT 21H

            ;Display bookname
            MOV AX, [BOOK + SI]   ; Get the address of the book name
            MOV DX, AX                ; Move the address to DX for printing
            MOV AH, 09H               ; DOS function to print string
            INT 21H  
        
            ;Price
            ; Load the floating-point values into the FPU and multiply
            FLD DWORD PTR [Price[DI]]   ; Load num1 into the FPU stack
            FILD WORD PTR [factor]      ; Load factor
            FMUL                  ; Multiply result by factor to scale
            FISTP result          ; Store integer part in result

            CALL DISPF  ;below no need, do until here is cukup

            MOV AH, 09H          ; print string
            LEA DX, ALL_PRICE_COLUMN_SPACE
            INT 21H

            ;Display left quantity
            CALL CALCULATION_QUANTITY

            D_SECOND:

            MOV AX, [GENRE + SI]   ; Get the address of the book name
            MOV DX, AX                ; Move the address to DX for printing
            MOV AH, 09H               ; DOS function to print string
            INT 21H 

            ;Display book author
            MOV AX, [AUTHOR + SI]     ; Get the address of the author
            MOV DX, AX
            MOV AH, 09H
            INT 21H

            LEA DX,NL
            INT 21H

            ADD SI, 2
            ADD DI,4
        LOOP DISPLAY_SEARCH


        JMP CONTINUE_9
        RET
    D_ALL ENDP


    CALCULATION_QUANTITY PROC

        MOV AH,0H
        MOV AX,LeftQuantity[SI]
        DIV HUNDRED
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

        MOV AH, 09H          ; print string
        LEA DX, ALL_LQ_COLUMN_SPACE
        INT 21H

        RET

    CALCULATION_QUANTITY ENDP
;;;;;SEARCH BOOK FUNCTION END




;CREATE_ORDER_FUNCTION
    CREATE_ORDER_FUNCTION_MAIN PROC
        CREATE_ORDER_START:
            ; Print header

            MOV AH,09H   
            LEA DX,NL
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
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI


            FINIT                         ;Initialize the FPU Stack
            FLDZ                          ; Load 0.0 into FPU stack
            FSTP DWORD PTR [TOTALAMOUNT]  ; Store 0.0 in TOTALAMOUNT

            MOV AH,09H	
            LEA DX,NL                     ;Display New Line
            INT 21H	
            LEA DX,PAYMENT_MAIN_HEADER    ;Print the Payment Main Header
            INT 21H
            LEA DX,NL
            INT 21H

            CALL DISPLAY_DASH             ;Call the Display Dash method to print a line

            ;display the header here			
            LEA DX,PAYMENT_HEADER         ;Print the Payment Header
            INT 21H


    ;To Calculate Total and Display Total Amount
    MOV ADDRESS_PRICE,0             ;Initialize the Price Adress
    MOV ADDRESS_EACH_AMOUNT,0       ;Initialize the Each Amount Adress
    MOV SI,0
    MOV PAYMENT_LOOP_COUNT,8        ;Loop 8 Times, because got 8 books in the system
    MOV DI,0
    MOV BOOK_NO,1                   ;Book_No set to 1 to display the No. before each book name
    L1:

        CMP BOOK_ORDER_QUANTITY[DI],0 			;Compare the Buy Quantity of each book, if equal 0, then skip
        JNE BOOK_QUANTITY_NOT_EQUAL_ZERO        ;that particular one book and proceed to next book

        JMP AGAIN                               ;If book quantity = 0, Jump to Again

        BOOK_QUANTITY_NOT_EQUAL_ZERO:
        MOV AX,0H
        XOR CX,CX                               ;Initialize CX to 0
        MOV CL,BOOK_ORDER_QUANTITY[DI]          ;Mov order quantity (8-bit) into CL(8-bit)
        MOV TEMP_BOOK_QUANTITY,CX               ;Mov CX(16-bit) into temporary book quantity

        FILD WORD PTR [TEMP_BOOK_QUANTITY]      ;Load quantity from temporary book quantity into the
                                                ;FPU stack, because can't move (8-bit) data into the 
                                                ;FPU stack

            MOV TDI,DI				;Mov the current DI into TDI(temporary DI)
            MOV DI,ADDRESS_PRICE    ;Mov the price address into DI, because book quantity(DB) use up to 1-bit
                                    ;per data, but for price(DD) use up to 4-bit per data


        FLD DWORD PTR [PRICE[DI]]  ;Load price into FPU stack
        FMUL						;Multiple the price and the buy quantity to get thee total for a particular book

            MOV DI,ADDRESS_EACH_AMOUNT		;Mov the each amount address into the DI, this step is neccessary
                                            ;although both price and each amount is DD data, and use up to 
                                            ;4-bit per data, but the count of the DI will be differ because 
                                            ;some book's buy quantity might be 0

        FSTP DWORD PTR [EACHAMOUNT[DI]]		;Store the result of (price * buy quantity) into each amount for each book

            MOV DI,TDI				;Restore the DI

        CALL DISPLAY_DASH			;Call the display dash function to display a line

        MOV AH,02H   
        MOV DL,BOOK_NO      ;Display Book No. to enchance the ease of visibility and tidy of the table
        ADD DL,30H
        INT 21H

        INC BOOK_NO         ;Increase the Book No. for the next loop
        MOV AH,09H
        LEA DX,DOT          ;Display a dot(.) after the Book No
        INT 21H

        MOV AH,09H 
        MOV DX,BOOK[SI] 	;Display the book name of customer buying
        INT 21H  		

            MOV TDI,DI			        ;Mov the original address into temporary DI
            MOV DI,ADDRESS_PRICE		;Mov the price adress into DI

        FLD DWORD PTR [PRICE[DI]]  ;Load price into the FPU stack

            MOV DI,TDI			;Restore the DI

        FILD WORD PTR [factor] ;Load factor(10) in the FPU stack
        FMUL                    ;Multiply price by factor to scale so can pass into function for display
                                ;For example (price = 10.9) * (factor = 10) = 109

        FISTP result          ;Store the answer in result
        
        CALL DISPF			;Call the display floating point function
        ;;;;;;;

        MOV AH,09H 
        LEA DX,TAB	        ;Display a Tab after display the Price
        INT 21H

        MOV AX,0H
        MOV AL,BOOK_ORDER_QUANTITY[DI]		;To display the number of book order quantity
        DIV TEN				                ;Divide Ten(10) to break the number down
        MOV BX,AX                           ;Mov the answer in AX into BX

        MOV AH,02H
        MOV DL,BL                           ;Display the BL first
        ADD DL,30H
        INT 21H

        MOV AH,02H
        MOV DL,BH                           ;Display the BH(remainder) after
        ADD DL,30H
        INT 21H
        ;;;;;

        MOV AH,09H 
        LEA DX,TAB	                        ;Display a Tab after the quantity order
        INT 21H

            MOV TDI,DI                      ;Mov the DI into temporary DI
            MOV DI,ADDRESS_EACH_AMOUNT      ;Mov the each amount address into DI

        FLD DWORD PTR [EACHAMOUNT[DI]]  ;Load each amount into the FPU stack

        FLD DWORD PTR [TOTALAMOUNT]		;Load total amount into FPU stack

        FADD							;add each amount and total amount together, to calculate the total amount
                                        ;of the order

        FSTP DWORD PTR [TOTALAMOUNT]    ;store the result back into TOTALAMOUNT

        FINIT						;Initialize the FPU stack, because it keeps bugging here

        FLD DWORD PTR [EACHAMOUNT[DI]]  ;Load each amount into the FPU stack again
        FILD WORD PTR [factor] 			;Load factor(10)
        FMUL							;Multiply to scale the each amount
        FISTP result         			;Store integer part in result

        CALL DISPF						;Call the display floating point number function

        MOV DI,TDI                      ;Restore the DI

        ADD ADDRESS_EACH_AMOUNT,4		;Update the each amount address by add 4, because each DD variable
                                        ;takes up to 4-bytes
        ;;;;

        MOV AH,09H			
        LEA DX,NL						;Display newline after each book done
        INT 21H

        AGAIN:

            ADD SI,2					;Update SI, each DW data takes up to 2-bytes
            INC DI						;Update DI, simple add 1
            ADD ADDRESS_PRICE,4			;Update the price address by add 4, each DD data takes up to 4-bytes
        
            DEC PAYMENT_LOOP_COUNT					;Use PAYMENT_LOOP_COUNT to count 8 books for a loop
            CMP PAYMENT_LOOP_COUNT,0				;Check if 8 books loop already done or not?
            JE FINISH_DISPLAY_PAYMENT				;If yes, jump to finish
        
        JMP L1

        FINISH_DISPLAY_PAYMENT:


        CALL DISPLAY_DASH                       ;Call the display dash function to print a line                                 

        MOV AH,09H 
        LEA DX,GRAND_TOTAL_AMOUNT_PREFIX        ;Print the prefix of the message to place the message in the middle
        INT 21H
        LEA DX,TOTAL_AMOUNT_MESSAGE             ;Print the total amount message
        INT 21H
        
        FINIT                                   ;Initialize the FPU stack again after the loop
        ; Display the total amount
        FLD DWORD PTR [TOTALAMOUNT]             ;Load the total amount into the FPU stack
        FILD WORD PTR [FACTOR]                  ;Load factor(10)
        FMUL                                    ;Multiply to scale the data
        FISTP result                            ;Store the answer in result
        CALL DISPF                              ;Call the display floating point function

        MOV AH,09H
        LEA DX,NL
        INT 21H

        CALL CHOOSEPAY                          ;Prompt user to choose payment method

        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    PAYMENT_FUNCTION_MAIN ENDP


    DISPF PROC
        ; Preserve registers, to avoid interruption of loop in the calling function
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

        MOV fraction_count,0        ;initialize the count, to avoid unwanted truncate of 0

        MOV AX, result              ;Load the value of 'result' into AX 

        ;Division by 10000 to extract the ten-thousands place
        MOV CX, TEN_THOUSAND         ;Mov ten thousand(10000) into CX 
        XOR DX, DX                   ;Clear DX to avoid overflow
        DIV CX                       ;AX = AX / 10000, DX = remainder
        MOV TAL, AL                  ;Store the ten-thousands digit in TAL(temporary AL)
        MOV AX, DX                   ;AX now holds the remainder

        ;Division by 1000 to extract the thousands place
        MOV CX, THOUSAND             ;Mov thousand(1000) into CX
        XOR DX, DX                   ;Clear DX to avoid overflow
        DIV CX                       ;AX = AX / 1000, DX = remainder
        MOV TBL, AL                  ;Store the thousands digit in TBL(temporary BL)
        MOV AX, DX                   ;AX now holds the remainder

        ;Division by 100 to extract the hundreds place
        XOR CX,CX                    ;Clear CX
        MOV CL, HUNDRED              ;Mov hundred(100) into CL
        XOR DX, DX                   ;Clear DX to avoid overflow
        DIV CX                       ;AX = AX / 100, DX = remainder
        MOV TCL, AL                  ;Store the hundreds digit in TCL(temporary CL)
        MOV AX, DX                   ;AX now holds the remainder

        ;Division by 10 to extract the tens place
        XOR CX,CX                    ;Clear CX
        MOV CL, TEN                  ;Mov ten(10) into CL
        XOR DX, DX                   ;Clear DX to avoid overflow
        DIV CX                       ;AX = AX / 10, DX = remainder
        MOV TDL, AL                  ;Store the tens digit in TDL
        MOV TAA, DL                  ;Store the remainder in TAA

        ;Print the ten-thousands digit
        CMP TAL, 0                  ;Compare if the TAL is Zero or not, if yes, skip the print
        JZ SkipTenThousands         ;If the ten-thousands digit is 0, skip it
        INC fraction_count          ;Increase the fraction count if it didn't skip, so it won't 
                                    ;skip or truncate zero in the middle of the whole digit

        MOV AL, TAL                 ;Load the ten-thousands digit
        ADD AL, '0'                 ;Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H

    SkipTenThousands:

        ;Print the thousands digit
        CMP fraction_count,1            ;If the fraction count is 1, means there's number(not zero) before this
                                        ;number, so don't need to skip this even it's zero

        JGE NO_NEED_SKIP_TEN_THOUSANDS  ;If >= 1, then no need to skip to print this digit
        CMP TBL, 0                      ;Compare if the digit is zero
        JZ SkipThousands                ;If the thousands digit is 0, skip it
        NO_NEED_SKIP_TEN_THOUSANDS:
        INC fraction_count              ;If it's not zero, increase the fraction count
        MOV AL, TBL                     ;Load the thousands digit
        ADD AL, '0'                     ;Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H

    SkipThousands:

        ;Print the hundreds digit
        CMP fraction_count,1            ;If the fraction count is 1, means there's number(not zero) before this
                                        ;number, so don't need to skip this even it's zero
        
        JGE NO_NEED_SKIP_THOUSANDS      ;If >= 1, then no need to skip to print this digit
        CMP TCL, 0                      ;Compare if the digit is zero
        JZ SkipHundreds                 ;If the hundreds digit is 0, skip it
        NO_NEED_SKIP_THOUSANDS:
        INC fraction_count              ;If it's not zero, increase the fraction count
        MOV AL, TBL                     ;Load the thousands digit
        MOV AL, TCL                     ;Load the hundreds digit
        ADD AL, '0'                     ;Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H      

    SkipHundreds:

        ;Print the tens digit
        MOV AL, TDL                     ;Load the tens digit
        ADD AL, '0'                     ;Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H      

        ;Print the decimal point
        MOV AH, 02H
        MOV DL, '.'
        INT 21H

        ;Print the units digit
        MOV AL, TAA                     ;Load the units digit
        ADD AL, '0'                     ;Convert to ASCII
        MOV AH, 02H
        MOV DL, AL
        INT 21H     

        MOV AH,02H
        MOV DL,'0'                      ;Manually print out the last '0'
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

        LEA DX,PAYMENT_METHOD_MESSAGE       ;Print the payment method header
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Option TNG
        MOV AH,02H
        MOV DL,1                            ;Print the No. of the option
        ADD DL,30H
        INT 21H
        
        MOV AH,09H
        LEA DX,DOT                          ;Print a dot(.) after the No.
        INT 21H
        
        LEA DX,TNG                          ;Print the option(Touch n Go)
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Option CARD
        MOV AH,02H
        MOV DL,2                            ;Print the No. of the option
        ADD DL,30H
        INT 21H
        
        MOV AH,09H
        LEA DX,DOT                          ;Print a dot(.) after the No.
        INT 21H
        
        LEA DX,CARD                          ;Print the option(Card)
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Option CASH
        MOV AH,02H
        MOV DL,3                            ;Print the No. of the option
        ADD DL,30H
        INT 21H
        
        MOV AH,09H
        LEA DX,DOT                          ;Print a dot(.) after the No.
        INT 21H
        
        LEA DX,CASH                          ;Print the option(Cash)
        INT 21H
        
        LEA DX,NL
        INT 21H
        
        ;Prompt User Input
        LEA DX,PROMPOPT                     ;Print the message to prompt user input
        INT 21H
        
        MOV AH,01H                          ;Read user input
        INT 21H
        MOV PAYMENT_SELECTION_ONE,AL        ;Mov user input into payment selection
        
        ;Compare User Input
        CMP PAYMENT_SELECTION_ONE,'1'       ;If choose 1, then jump to Touch n Go part
        JE TGO
        CMP PAYMENT_SELECTION_ONE,'2'       ;If choose 2, then jump to Card part
        JE CAD
        CMP PAYMENT_SELECTION_ONE,'3'       ;If choose 3, then jump to Cash part
        JE CAH
        
        INVALID_PAYMENT_METHOD_INPUT:       ;If the input didn't meet any of the above selection, it's invalid
        ;IF INVALID,PROMPT CONTINUE?
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H

            CALL DISPLAY_DASH               ;To print a line
            
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            LEA DX,PINVALID                 ;Prompt user the invalid message
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN                   ;Print the message (Enter again?)
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,CANCEL_PAYMENT_MESSAGE       ;Print the message (Cancel Payment?)
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT 
            LEA DX,PROMPOPT                     ;Print the prompt message
            INT 21H
            
            MOV AH,01H                          ;Read user input
            INT 21H	
            MOV PAYMENT_SELECTION_TWO,AL        ;Store user input into payment selection two

            MOV AH,09H
            LEA DX,NL
            INT 21H
            
            CMP PAYMENT_SELECTION_TWO,'2'       ;If user input 2, go to finish payment(quit)
            JE FINISHPM ;QUIT
            CMP PAYMENT_SELECTION_TWO,'1'      
            JNE INVALID_PAYMENT_METHOD_INPUT    ;If user's not input 1, go to invalid again
            JMP CHOOSE_PAYMENT_METHOD           ;If user input 1, go to choose payment method again
        
        TGO:
            CALL TouchNGoPayment
            JMP FINISHPM
        
        CAD:
            CALL CardPayment
            JMP FINISHPM
        
        CAH:
            CALL CashPayment
            JMP FINISHPM

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


    TouchNGoPayment PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            CALL DISPLAY_DASH               ;Display a line on the screen
            LEA DX,PRINT_MIDDLE             ;To print the header on the middle
            INT 21H
            MOV AH,09H
            LEA DX,TNG                      ;Print the header Touch N Go
            INT 21H

            CALL ORDER_CONFIRMATION         ;Ask if user the payment is make or not

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    TouchNGoPayment ENDP


    CardPayment PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            CALL DISPLAY_DASH               ;Display a line on the screen
            LEA DX,PRINT_MIDDLE             ;To print the header on the middle
            INT 21H
            MOV AH,09H
            LEA DX,CARD                     ;Print the header Card
            INT 21H

            CALL ORDER_CONFIRMATION         ;Ask if user the payment is make or not

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    CardPayment ENDP


    CashPayment PROC
        ; Preserve registers
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI
        PUSH SI

            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            CALL DISPLAY_DASH               ;Display a line on the screen
            LEA DX,PRINT_MIDDLE             ;To print the header on the middle
            INT 21H
            MOV AH,09H
            LEA DX,CASH                     ;Print the header Cash
            INT 21H

            CALL CASHCHANGE                 ;To calculate the change if customer use cash to make payment
            CMP BX,1
            JE EXIT_PAYMENT_FUNCTION

            CALL ORDER_CONFIRMATION         ;Ask if user the payment is make or not

            EXIT_PAYMENT_FUNCTION:

        ; Restore registers
        POP SI
        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    CashPayment ENDP


    CASHCHANGE PROC

        INPUT_CASH_AGAIN:
        FINIT                   ;Initialize the FPU stack
        FLDZ                    ;Set the FPU stack to 0.0
        ; Prompt the user to input the payment amount
        MOV AH, 09H
        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H
        LEA DX, PROMPTPAY       ;Prompt the user to enter the amount of Money received
        INT 21H

        ; Initialize registers and variables
        XOR AX, AX                  ;Clear AX
        XOR BX, BX                  ;Clear BX
        XOR CX, CX                  ;Clear CX
        MOV PAIDAMOUNT_INT, AX      ;To ensure PAIDAMOUNT_INT starts at 0
        MOV SI, 0                   ;SI will be used as an index for input buffer
        MOV TDI,0 		            ;Use to track if the decimal(.) is entered or not

        ;Loop to input and convert each digit
    LOOP_INPUT_CASH:
        MOV AH, 01H             ;Read user input, one character at a time
        INT 21H

        CMP AL,'.'                          ;Check everytime did the user entered the decimal point(.)
        JNE CONTINUE_WITHOUT_DECIMAL     

            INC TDI                         ;If entered decimal point(.), increase the count
            MOV AX,TDI                      ;Mov the TDI(decimal count) into AX to do the compare
            CMP AX,1
            JG INVALID_CASH_INPUT           ;If the TDI is greater than 1, means the decimal point is
                                            ;entered more than once, means that it's not a valid value anymore

            JMP LOOP_INPUT_CASH             ;Automatically back onto the start of the input loop(from the above)

        CONTINUE_WITHOUT_DECIMAL:           ;If no decimal point input so far

        CMP AL, 0DH                         ;Check if Enter is pressed (0Dh in ASCII)
        JE END_OF_CASH_INPUT_INTERCHANGE    ;If enter is pressed, then end the input loop

        SUB AL, 30H                         ;Convert user input into a number
        CMP AL, 0
        JL INVALID_CASH_INPUT               ;If invalid(less than 0, or greater than 9), jump to
        CMP AL, 9                           ;handle invalid part
        JG INVALID_CASH_INPUT

        MOV TAL, AL                         ;Store the current digit in TAL

        ;Multiply the current result by 10 using PAIDAMOUNT_INT
        MOV AX, PAIDAMOUNT_INT              ;Mov the current result into AX
        MOV CX, 10                          ;Multiply by 10
        MUL CX                              ;AX = AX * 10
        MOV PAIDAMOUNT_INT, AX              ;Store back the result in PAIDAMOUNT_INT

        ;Add the new digit to the result using TAL
        XOR AX,AX                           ;Clear the AX
        MOV AL,TAL                          ;Mov the TAL into AL
        ADD PAIDAMOUNT_INT,AX               ;Add the digit to the final result

        INC SI                              ;Move to the next character
        CMP SI, 10                          ;Limit input to 10 characters
        JGE END_OF_CASH_INPUT_INTERCHANGE   ;If already entered 10 characters, end the loop

        CMP TDI, 1                          ;Limit input to 10 characters
        JE END_OF_CASH_INPUT_INTERCHANGE    ;User only can input one more digit after they input a decimal point(.)

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

            LEA DX,PINVALID             ;Prompt user that their input is invalid
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN               ;Prompt (enter again?) Message
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,CANCEL_PAYMENT_MESSAGE       ;Prompt (Cancel payment?) Message
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT   
            LEA DX,PROMPOPT                     ;Prompt user input
            INT 21H
            
            MOV AH,01H                          ;Read user input
            INT 21H
            MOV PAYMENT_SELECTION_TWO,AL        ;Mov user input into payment selection two

            MOV AH,09H
            LEA DX,NL
            INT 21H
            
            CMP PAYMENT_SELECTION_TWO,'2'               ;If user choose 2, then quit
            JE FINISH_CASH_INPUT_INTERCHANGE ;QUIT
            CMP PAYMENT_SELECTION_TWO,'1'       
            JNE	INVALID_CASH_INPUT                      ;If user input not equal1, then jump invalid again
            JMP INPUT_CASH_AGAIN                        ;If user choose 1, jump to input cash again

        ;;;;;;;;;

    END_OF_CASH_INPUT:

        MOV AH,09H
        LEA DX,NL
        INT 21H
        CALL DISPLAY_DASH                   ;To display a line on the screen
        LEA DX,NL
        INT 21H

        MOV AH,09H
        LEA DX,TOTAL_AMOUNT_MESSAGE         ;Print the total amount message
        INT 21H

        ; Display the total amount
        FLD DWORD PTR [TOTALAMOUNT]             ;Load the total amount into the FPU stack
        FILD WORD PTR [FACTOR]                  ;Load factor(10)
        FMUL                                    ;Multiply total amount and the factor for scalling purposes
        FISTP result                            ;Store the result into result
        CALL DISPF                              ;Call the display floating point function

        MOV AH,09H
        LEA DX,NL  
        INT 21H
        LEA DX,PAID_AMOUNT                      ;Print the message Paid Amount
        INT 21H

        MOV AX,TDI                              ;Compare the TDI(decimal count), if it's non zero                      
        CMP AX,0                                ;means user got entered decimal, and the price will
        JNE PRICE_GOT_DECIMAL                   ;need another way of scalling

                ;PRICE_DON'T_GOT_DECIMAL
                FINIT                               ;Initialize the FPU stack again
                FILD WORD PTR [PAIDAMOUNT_INT]      ;Load paid amount int into the FPU stack
                FILD WORD PTR [factor]              ;Load factor(10)
                FMUL                                ;Scale the paidamount int
                FISTP result                        ;Store the answer in result
                CALL DISPF                          ;Display the paidamount using display floating point function
            
                FINIT                               ;Initialize the FPU stack again
                FILD WORD PTR [PAIDAMOUNT_INT]      ;Load paid amount int into the FPU stack
                FSTP DWORD PTR [PAIDAMOUNT_TOTAL]   ;And store it inside paid amount total, which will need to calculate
                                                    ;the change for later

            JMP FINISH_CASH_INPUT

            FINISH_CASH_INPUT_INTERCHANGE:
                JMP FINISH_ALL

        PRICE_GOT_DECIMAL:

            ;PRICE DON'T HAVE DECIMAL   
            FINIT                                   ;Initialize the FPU stack
            FILD WORD PTR [PAIDAMOUNT_INT]          ;Load paid amount int into the FPU stack
            FISTP result                            ;Direct store paid amount into result, no need scalling
            CALL DISPF                              ;Call the dislay floating point function to display it

            FINIT                                   ;Initialze the FPU stack again
            FILD WORD PTR [PAIDAMOUNT_INT]          ;Load paid amount int into the FPU stack
            FILD WORD PTR [factor]                  ;Load factor(10)
            FDIV                                    ;Scalling it by divide 10
            FSTP DWORD PTR [PAIDAMOUNT_TOTAL]       ;Store the answer into the paid amount total

        FINISH_CASH_INPUT:

        ;NOW NEED TO CHECK IF THE PRICE ENTER IS ENOUGH TO PAY
        FINIT                                   ;Initialze the FPU stack again
        FLD DWORD PTR [TOTALAMOUNT]             ;Load the total amount into the FPU stack
        FLD DWORD PTR [PAIDAMOUNT_TOTAL]        ;Load the paid amount total into the FPU stack
        FCOM                                    ;Compare total amount and paid amount
        FSTSW PAYMENT_STATUS_WORD               ;Store the floating-point status word in payment status
        MOV AX, PAYMENT_STATUS_WORD             ;Move the status word into AX
        SAHF                                    ;Transfer status to flags

        JAE GO_TO_PAY                           ;Jump if enough to pay, if not, go below

            INSUFFICIENT_CASH_INPUT:
                ;IF INSUFFICIENT,PROMPT AGAIN?
                MOV AH,09H
                LEA DX,NL
                INT 21H
                LEA DX,NL
                INT 21H
                
                LEA DX,PINSUFFICIENT            ;Print the insufficient message
                INT 21H
                
                LEA DX,NL
                INT 21H
                
                ;Enter Again?
                MOV AH,09H
                LEA DX,ENTAGN                   ;Prompt (Enter again?)
                INT 21H 
                
                LEA DX,NL
                INT 21H
                
                ;Quit?
                MOV AH,09H
                LEA DX,CANCEL_PAYMENT_MESSAGE   ;Prompt (Cancel Payment?)
                INT 21H
                
                LEA DX,NL
                INT 21H
                
                ;PROMT USER INPUT 
                LEA DX,PROMPOPT                 ;Prompt user input
                INT 21H
                
                MOV AH,01H                      ;Read user input
                INT 21H
                MOV PAYMENT_SELECTION_TWO,AL    ;Mov the user input into the payment selection two

                MOV AH,09H
                LEA DX,NL
                INT 21H
                
                CMP PAYMENT_SELECTION_TWO,'2'       ;If user choose two, exit
                JE FINISH_ALL ;QUIT
                CMP PAYMENT_SELECTION_TWO,'1'
                JNE INSUFFICIENT_CASH_INPUT         ;If user didn't press 1, go to insufficient again
                JMP INPUT_CASH_AGAIN                ;If user choose 1, go to input cash again

        ;;;;;;;;;

        GO_TO_PAY:
            MOV AH,09H
            LEA DX,NL
            INT 21H

            LEA DX,CHANGE_AMOUNT                ;Print the message (Change Amount: )
            INT 21H

            FLD DWORD PTR [TOTALAMOUNT]         ;Load the totalamount into the FPU stack
            FSTP DWORD PTR [TEMP_TOTAL_AMOUNT]  ;Store it inside temporary variable
            FINIT                               ;Initialize the FPU stack
            FLD DWORD PTR [PAIDAMOUNT_TOTAL]    ;Load the Paid amount total into the FPU stack
            FLD DWORD PTR [TEMP_TOTAL_AMOUNT]   ;Load the temporary total amount into the FPU stack
            FSUB                                ;Subtract the two value from above
            FILD WORD PTR [FACTOR]              ;Load the factor(10)
            FMUL                                ;Multiply the answer with the factor
            FISTP result                        ;Store the answer inside result
            CALL DISPF                          ;Call the display floating point function

            RET

        FINISH_ALL:
            MOV BX,1

            MOV AH,09H 
            LEA DX,ORDER_CANCEL_MESSAGE
            INT 21H
            LEA DX,NL
            INT 21H

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

        MOV CX,8                                ;Loop for eight times, because got 8 books
        MOV SI,0
        MOV DI,0
        MOV BX,0
        DEDUCT:
        XOR BX,BX
            MOV BL,BOOK_ORDER_QUANTITY[DI]      ;Mov book order quantity into BL
            SUB LeftQuantity[SI],BX             ;Deduct the order quantity from the left quantity
            ADD SoldQuantity[SI],BX             ;Increase the sold quantity
            ADD SI,2
            INC DI
        LOOP DEDUCT

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
            
        lEA DX,ORDER_CONFIRMATION_MESSAGE       ;Prompt if user confirm to place the order or not?
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
            
        LEA DX,ORDER_CONFIRM                ;Prompt order confirm
        INT 21H
            
        LEA DX,NL
        INT 21H
            
        ;Quit?
        MOV AH,09H	
        LEA DX,CANCEL_PAYMENT_MESSAGE       ;Prompt payment cancel
        INT 21H
            
        LEA DX,NL
        INT 21H
            
        ;PROMT USER INPUT 
        LEA DX,PROMPOPT                     ;Prompt user input
        INT 21H
            
        MOV AH,01H                          ;Read user input
        INT 21H
        MOV PAYMENT_SELECTION_TWO,AL        ;Mov user input into payment selection
            
        CMP PAYMENT_SELECTION_TWO,'1'
        JE ORDER_CONFIRMED ;order confirm       ;If user choose 1, order confirm
        CMP PAYMENT_SELECTION_TWO,'2'
        JE ORDER_CANCEL_INTERCHANGE             ;If user choose 2, payment canceled

            INVALID_ORDER_CONFIRM_INPUT:
            ;IF INVALID,PROMPT CONTINUE?
            MOV AH,09H
            LEA DX,NL
            INT 21H
            LEA DX,NL
            INT 21H
            
            LEA DX,PINVALID                    ;Prompt user invalid message
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Enter Again?
            MOV AH,09H
            LEA DX,ENTAGN                       ;Prompt user to enter again or not
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;Quit?
            MOV AH,09H
            LEA DX,CANCEL_PAYMENT_MESSAGE       ;Prompt user to cancel payment or not
            INT 21H
            
            LEA DX,NL
            INT 21H
            
            ;PROMT USER INPUT 
            LEA DX,PROMPOPT                     ;Prompt user input
            INT 21H
            
            MOV AH,01H                          ;Read user input
            INT 21H
            MOV PAYMENT_SELECTION_TWO,AL
            
            CMP PAYMENT_SELECTION_TWO,'2'
            JE ORDER_CANCEL                             ;If user choose 2, order canceled
            CMP PAYMENT_SELECTION_TWO,'1'
            JNE INVALID_ORDER_CONFIRM_INPUT             ;If user didn't press 1, invalid
            JMP lOOP_ORDER_CONFIRMATION                 ;If user choose 1, order confirmed

            ORDER_CANCEL_INTERCHANGE:
            JMP ORDER_CANCEL

        ;;;;;;;;;

        ORDER_CONFIRMED:
        MOV AH,09
        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H

        MOV AH,09H
        LEA DX,ORDER_CONFIRM_MESSAGE            ;Display order confirm message
        INT 21H

        CALL DEDUCTBOOK                         ;Call the deduct book function
        JMP END_OF_PAYMENT

        ;;;;;
        ORDER_CANCEL:
        MOV AH,09  
        LEA DX,NL
        INT 21H
        LEA DX,NL
        INT 21H

        LEA DX,ORDER_CANCEL_MESSAGE            ;Prompt order canceled
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
        CALL DISPLAYMENU ;display choices for the report menu

        ;get user input
        CALL GETINPUT  

        ;check input
        CMP REPORTCHOICE,1
        JNE CHECK_CHOICE2  ; if not equal to 1, jump to check_choice2
        CALL VIEWTOTALSALESREPORT ;if equal 1, call procedure to total sales report
        JMP RPTMENU_LOOP  ;return to menu loop

    CHECK_CHOICE2:
        CMP REPORTCHOICE,2
        JNE CHECK_CHOICE3 ; if not equal to 2, jump to check_choice3
        CALL VIEWINVENTORYREPORT ; if equal 2, call procedure to inventory report
        JMP RPTMENU_LOOP  ;return to menu loop

    CHECK_CHOICE3:
        CMP REPORTCHOICE,3
        JE EXITMENU  ; if equal 3, jump to exit menu 
        

    ;INVALID_INPUT:
        ;display invalid msg
        CALL DISPLAYINVALID ; if input is invalid, display invalid message and loop the report menu
        JMP RPTMENU_LOOP

    EXITMENU:
        RET ; return to the main menu

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

	;display menu header
        MOV AH,09H ;sets up 21H for string display
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
        MOV AH,01H ; set up dos to get input from user
        INT 21H ; trigger interrupt 21h to read a single key
        SUB AL,30H ; convert ASCII number to digit, sub '0'
        MOV REPORTCHOICE,AL ; store result in reportchoice

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

        
        MOV CX, 8	; set loop counter to 8 books
        XOR SI, SI       ; Initialize SI for index
        MOV DI, 0 	 ; initilize DI for prices
        MOV BOOK_NO,1	; initiliaze book number to 1

    NEXT_BOOK:

        ;Display Number
            MOV AH, 02H          ; DOS interrupt to print character
            MOV DL, BOOK_NO           ; Load the book number into DL
            ADD DL, 30H          ; Convert number to ASCII (1 - 8)
            INT 21H

            INC BOOK_NO  	; increment book number
            
            MOV AH,09H
            LEA DX,DOT
            INT 21H

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
        FLD DWORD PTR [PRICE[DI]]	;Call procedure to display floating-point price
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
        ;MOV AH, 09H
        ;LEA DX, NL
        ;INT 21H

        ; Increment SI by 2 to point to the next word (since addresses are word-sized)
        ADD SI, 2

        ; Increment DI by 4 for the next price in DD format
        ADD DI, 4

        ; Display New Line for separation between books
        MOV AH, 09H
        LEA DX, NL
        INT 21H
    
        LOOP NEXT_BOOK ; repeat for all 8 books

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
        MOV CX, 8		; Initialize loop counter for 8 books
        XOR SI, SI		; initilaze SI for indexing        
        MOV BOOK_NO,1		; initialize book number to 1

    NEXT_BOOK2:

        ;Display Number
            MOV AH, 02H          ; DOS interrupt to print character
            MOV DL, BOOK_NO           ; Load the book number into DL
            ADD DL, 30H          ; Convert number to ASCII (1 - 8)
            INT 21H

            INC BOOK_NO
            ; Print a period and space after the number
            MOV AH,09H
            LEA DX,DOT
            INT 21H


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
        ;MOV AH, 09H
        ;LEA DX, NL
        ;INT 21H

        ; Increment SI by 2 to point to the next word (since addresses are word-sized)
        ADD SI, 2

        ; Display New Line for separation between books
        MOV AH, 09H
        LEA DX, NL
        INT 21H

    
        LOOP NEXT_BOOK2

        RET
    VIEWINVENTORYREPORT ENDP
;;;;;REPORT FUNCTION END

END MAIN
