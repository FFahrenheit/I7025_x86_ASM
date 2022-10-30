    ORG 100H
    JMP begin
    DB " X: "       ;Separamos donde se guarda X
    XH DB ?
    XL DB ?         ;Parte alta y baja de X
    DB " Y: "       ;Separamos donde se guarda Y
    YH DB ?
    YL DB ?         ;Parte alta y baja de Y
    DB " "       

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
                                              

    MOV XH, CH      ;Si se presion el click izquierdo
    MOV XL, CL      ;Guardamos las coordenadas en              
    MOV YH, DH      ;La memoria, respetando el
    MOV YL, DL      ;little endian   
    JMP leer        ;Continuamos leyendo el mouse                                  
        