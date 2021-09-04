ORG 100h
    JMP MAIN 
MAIN:                       
    ;0X97 + 0X32            '' '' 
    MOV AL, 0X97    ; AL = 10010111 = 0X97 +
    MOV BL, 0X32    ; BL = 00110010 = 0X32 =
    ADD AL, BL      ; AL = 11001001 = 0XC9
                                     
    ;0XF0 + 0X0F + 1        ''''''''
    MOV CL, 0XF0    ; CL =  11110000 = 0XFF +
    MOV DL, 0X0F    ; DL =  00001111 = 0X0F +
    STC             ;  C =         1 = 0X01 =
    ADC CL, DL      ; CL = 100000000 = 0X100 = 0X00 con C=1
                                          
    ;0X75 - 0X40                                      
    MOV AL, 0X75    ; AL = 01110101 = 0X75 -
    MOV BL, 0X40    ; BL = 01000000 = 0X40 = 
    SUB AL, BL      ; AL = 00110101 = 0X35      
                    
    ;0x33 - 0x33 - 1
    MOV CL, 0X33    ; CL = 00110011 = 0X33 -
    MOV DL, 0X33    ; DL = 00110011 = 0X33 -
    STC             ;             1 = 0X01 =
    SBB CL, DL      ; CL = 11111111 = 0XFF
    
                                                                    
    ;0X64 MUL 0X03
    XOR AX, AX      ; AX = 0X0000
    MOV AL, 0X64    ; AL =  01100100 = 0X64 *
    MOV BL, 0X03    ; BL =        11 = 0X03 =
    MUL BL          ;       01100100 +
                    ;      01100100  =
                    ; AX = 100101100 = AH = 0X01, AL = 0X2C
    
    ;0X0A / 0X03
    XOR AX, AX      ; AX = 0X0000
    MOV AL, 0X0A    ; AL = 00001010 = 0X0A /
    MOV BL, 0X03    ; BL = 00000011 = 0X03 =
    DIV BL          ; AL => AH = 0X01, AL = 0X03
    
    RET