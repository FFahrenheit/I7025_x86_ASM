;___________________________________|
    PAGE    60,132                  ;
    TITLE   PROG3.EXE               ;
    .MODEL  SMALL                   ;TIPO COM
;___________________________________|
.CODE                               ;PRIMEROS 256 PARA CONTROL
    ORG 100H                        ;VECTOR DE INICIO DE CODIGO
MAIN PROC NEAR                      ;
                                    ;
    MOV AX,01                       ;
    MOV BX,01                       ;
    MOV CX,01                       ;MOV 01 a AX, BX, CX
A20:                                ;
    ADD AX,01                       ;
    ADD BX, AX                      ;MODIFICAMOS LOS 3 REGISTROS
    SHL CX,1                        ;ROTA CX UN BIT IZQUIERDA 
    JMP A20                         ;SALTO INCONDICIONAL A A20
    MOV AX,4C00H                    ;
    INT 21H                         ;NUNCA LLEGA, BUCLE INFINITO
                                    ;
MAIN ENDP                           ;
END MAIN                            ;
;___________________________________|