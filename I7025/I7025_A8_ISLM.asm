    ORG 100H
    JMP begin
    X DW ?
    Y DW ?
    final DW ?
    W DW 0x000A
    H DW 0x0005

begin: 
    MOV AH, 00H
    MOV AL, 13H     ;Modo video 320x320
    INT 10H         ;Configurar modo video
   
    MOV AX, 0000H   ;Activar el mouse
    INT 33H              
    MOV AX, 0001H   ;Mostrar el mouse
    INT 33H                
    
leer:
    MOV AX, 0003H
    INT 33H         ;Lee el estado del mouse             
    
    CMP BX, 0001H   ;Si no se presiono el click   
    JNZ leer        ;seguimos leyendo el mouse   
    MOV X, CX       ;Si se presion el click izquierdo
    MOV Y, DX       ;Guardamos las coordenadas en X, Y

;Dividir X entre 2 (Por alguna razon se devuelve duplicado) 
dividir:
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX         ;Guardamos los registros

    XOR AX, AX
    XOR CX, CX
    XOR DX, DX 
    MOV AX, X
    MOV BX, 0002    ;Dividimos X/2 con division de 32 bits
    MOV CX, 2
    DIV BX
    MOV X, AX       ;Guardamos el valor real
    
    POP DX
    POP CX
    POP BX
    POP AX          ;Regresamos los registros
        
;Parte 1
    MOV SI, 0
    MOV AL, 0AH 
    MOV CX, X
    MOV DX, Y
    
parte1:
    MOV AH, 0CH
    INT 10H
    
    INC CX
    INC SI
    CMP SI, W
    JNZ parte1

;Parte 2        
    MOV SI, 0
    MOV AL, 0AH
    MOV CX, X
    MOV DX, Y
parte2:      
    MOV AH, 0CH
    INT 10H
    
    INC DX
    INC SI
    CMP SI, H
    JNZ parte2   
    
;Parte 3    
    MOV SI, 0
    MOV AL, 0AH
    MOV CX, X
    ADD CX, W
    DEC CX
    MOV DX, Y
parte3:
    MOV AH, 0CH
    INT 10H
    
    INC DX
    INC SI   
    CMP SI, H
    JNZ parte3
 
;Parte 4    
    MOV SI, 0
    MOV AL, 0AH
    MOV CX, X
    MOV DX, Y
    ADD DX, H
    DEC DX
parte4:
    MOV AH, 0CH
    INT 10H
    
    INC CX
    INC SI
    CMP SI, W
    JNZ parte4
    
        
    JMP leer        ;Continuamos leyendo el mouse    
