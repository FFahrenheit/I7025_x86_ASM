;___________________________________|
    PAGE    60,132                  ;
    TITLE   PROG4.EXE               ;
    .MODEL  SMALL                   ;TIPO COM
;___________________________________|
.CODE                               ;PRIMEROS 256 PARA CONTROL
    ORG 100H                        ;VECTOR DE INICIO DE CODIGO
MAIN PROC NEAR                      ;
                                    ;
    MOV     AX,01                   ;
    MOV     BX,01                   ;
    MOV     DX,01                   ;MOV 0AH a CX
    MOV     CX,10                   ;MOV 01 a AX, BX, DX
A20:                                ;
    INC     AX                      ;
    ADD     BX, AX                  ;MODIFICAMOS LOS 4 REGISTROS
    SHL     DX,1                    ;ROTA DX UN BIT IZQUIERDA
    LOOP    A20                     ;SALTO A A20. DECREMENTA A CX
                                    ;SI CX = 0 NO SALTA
    MOV     AX,4C00H                ;
    INT     21H                     ;LLEGA TRAS 10 CICLOS
                                    ;
MAIN ENDP                           ;
END MAIN                            ;
;___________________________________|