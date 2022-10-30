ORG 100h
    JMP MAIN 
MAIN:                       
    ;NOT 0X97
    MOV AL, 0X97    ; AL = 10010111 = 0X97 => NOT
    NOT AL          ; AL = 01101000 = 0X68
     
    ;0X97 en complemento a 2  
    MOV BL, 0X97    ; BL = 10010111 = 0X97
    NEG BL          ; BL = 01101000 +
                    ;             1 =
                    ;    = 01101001 = 0X69  
                                          
    ;0X97 AND 0X0F                                      
    MOV AL, 0X97    ; AL = 10010111 = 0X97 => AND BL
    MOV BL, 0X0F    ; BL = 00001111 = 0X0F 
    AND AL, BL      ;    = 00000111 = 0X07        
                    
    ;0x97 OR 0x49
    MOV CL, 0X97    ; CL = 10010111 = 0X97 => OR DL
    MOV DL, 0X49    ; DL = 01001001 = 0X49
    OR  CL, DL      ;    = 11011111 = 0XDF
    
 
    ;0X97 XOR 0X32
    MOV CL, 0X97    ; CL = 10010111 = 0X97 => XOR DL
    MOV DL, 0X32    ; DL = 00110010 = 0X32
    XOR CL, DL      ;    = 10100101 = 0XA5
    
    RET