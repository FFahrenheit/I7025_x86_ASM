;_____________________________________|
    PAGE    60,132                    ;
    TITLE   PROG6.EXE                 ; IDENTIFICADOR PROGRAMA
    .MODEL  SMALL                     ;
;_____________________________________|
    .STACK  64                        ; SEGMENTO DE STACK
;_____________________________________|
    .DATA                             ; SEGMENTO DE DATOS
MEN DB 'CAMBIAR A MINÚSCULAS'         ; DECLARAMOS UN STRING EN MAYUSCULAS
;_____________________________________| 
    .CODE                             ; SEGMENTO DE CODIGO
MAIN PROC NEAR                        ; INICIO DEL PROCEDIMIENTO
    MOV     AX, @DATA                 ; CARGAMOS EL SEGMENTO DE DATOS
    MOV     DS, AX                    ;     
AGAIN:                                ; HACER EL PROCESO DESDE INICIO   
    LEA     BX, MEN                   ; CARGAMOS LA ADDRESS REAL DEL STRING
    MOV     CX, 20                    ; CARGAMOS EL TAMAÑO DEL STRING (20) EN CX
                                      ; AL SER INDEFINIDO, IGNORAMOS CX
OTRO:                                 ; MOVEMOS A AH LO QUE APUNTA BX
    MOV     AH, [BX]                  ; (LA ADDRESS DEL CARACTER ACTUAL)
    CMP     AH, 41H                   ; COMPARAMOS AH CON 41H (A) (REG. ZF, CF) 
    JB      NEXT                      ; SALTA SI ES MENOR A 41H
    CMP     AH, 5AH                   ; COMPARAMOS AH CON 5AH (Z)
    JA      OTRO2                     ; SALTA A OTRO2 SI ES MAYOR A 5AH
    OR      AH, 00100000B             ; SUMA 32 A AH, HACIENDOLO minuscula
    MOV     [BX], AH                  ; MOVEMOS LA MINUSCULA A SU POSICION
    JMP     NEXT                      ; SALTAMOS LA PARTE DE CONVERSIÓN 
OTRO2:                                ; A MINÍSCULA (ESTA PARTE)
    CMP     AH, 61H                   ; COMPARAMOS CON 'a'
    JB      NEXT                      ; NOS SALTAMOS SI ES MENOR
    CMP     AH, 7AH                   ; COMPARAMOS CON 'z'
    JA      NEXT                      ; SALTAMOS SI ESTA FUERA DE RANGO
    AND     AH, 11011111b             ; RESTA 32 A AH HACIENDOLO MAYUSCULA
    MOV     [BX], AH                  ; MOVEMOS LA MAYUSCULA A SU POSICION
NEXT:                                 ;
    INC     BX                        ; INCREMENTAMOS BX EN 1 (SIG. CARACTER)
    LOOP    OTRO                      ; HACEMOS LOOP, DECREMENTANDO CX
    JMP     AGAIN                     ; REPETIR DESDE EL INICIO SI ACABA
    MOV     AX, 4C00H                 ; 
    INT     21H                       ; RETORNAR AL SISTEMA OPERATIVO
MAIN ENDP                             ; (NO LLEGA)
END MAIN                              ;
;_____________________________________|
