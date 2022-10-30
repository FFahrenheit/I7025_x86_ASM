    PAGE    60,132                    ;-Detalles del programa:
    TITLE   PRACT10.EXE               ; Hacer video de 1 minuto
    .MODEL  SMALL                     ; mostrando 120 cambios
;_____________________________________|
    .STACK 64                         ;-Segmento de stack
    .DATA                             ;-Segmento de datos
REG0    DW 0x7FFF                     ;-Registros auxiliares para
REG1    DW 0x7FFF                     ;-delay, se repetira
REG2    DW 0x7FFF                     ;-0xFFFF + 0xFFFFH + 0xFFFF
COLOR   DB 0x01                       ;-Arg. color (1 para ver)       
MSJE    DB "RETARDO DE COLORES",1,"$" ;-Mensaje a mostrar
;_____________________________________|
    .CODE                             ;-Codigo principal
INICIO PROC FAR                       ;
    MOV     AX, @DATA                 ;-Hacemos visible segmento de 
    MOV     DS, AX                    ; codigo
    CALL    PANT1                     ;-Pintamos la pantalla
    CALL    CAMBIO
    CALL    CURSOR1                   ;-Cambiamos el cursor
    MOV     AX, 4C00H                 ;-Regresamos control al SO
    INT     21H                       ;
INICIO ENDP                           ;
;_____________________________________|
PANT0 PROC NEAR                       ;-Usando la INT 10H
    MOV     AX, 0600H                 ; definimos el tama�o
    MOV     BH, COLOR                 ; de la pantalla, asi
    MOV     CX, 0205H                 ; como el argumento para
    MOV     DX, 1545H                 ; el color de fuente y 
    INT     10H                       ; fondo
    RET                               ;
PANT0 ENDP                            ;
;_____________________________________|
                                      ;-Usando la INT 10H
PANT1 PROC NEAR                       ; marcamos un borde en la 
    MOV     AX, 0600H                 ; pantalla de un color 
    MOV     BH, 10H                   ; fijo y un tama�o 
    MOV     CX, 0000H                 ; ligeramente mayor
    MOV     DX, 1950H                 ;
    INT     10H                       ;
    RET                               ;
PANT1 ENDP                            ;
;_____________________________________|
CURSOR0 PROC NEAR                     ;-Colocamos el cursor
    MOV     AH, 02H                   ; en 0C,1A usando la 
    MOV     BH, 00H                   ; INT 10H
    MOV     DX, 0C1AH                 ; (aprox el centro)
    INT     10H                       ;
    RET                               ;
CURSOR0 ENDP                          ;
;_____________________________________|
CURSOR1 PROC NEAR                     ;-Colocamos el cursor
    MOV     AH, 02H                   ; en 14,00 usando la 
    MOV     BH, 00H                   ; INT 10H
    MOV     DX, 1400H                 ;
    INT     10H                       ;
    RET                               ;
CURSOR1 ENDP                          ;
;_____________________________________;
CAMBIO PROC NEAR                      ;-Rutina de cambio de color
    CALL    PANT0                     ;-Imprimimos pantalla color
    CALL    CURSOR0                   ;-Posicionamos cursor
    CALL    DESP                      ;-Mostramos mensaje
    CALL    RETARd                    ;-Retardo decrementando
    CALL    RETARi                    ;-Retardo incrementando
    CALL    RETARd                    ;-Retardo decrementando
    CALL    RETARi                    ;-Retardo incrementando
    INC     COLOR                     ;-Cambiamos arg. de color
    CMP     COLOR, 0FFH               ;-Comparamos con 0xFF 
    JE      SALE                      ;-Si es 0xFF salimos
    JMP     CAMBIO                    ;-Sino continuamos
SALE:                                 ;-Terminamos rutina
    RET                               ;
CAMBIO ENDP                           ;
;_____________________________________|
DESP PROC NEAR                        ;-Usando la INT 21H
    MOV     AH, 09H                   ; desplegamos un mensaje
    LEA     DX, MSJE                  ;
    INT     21H                       ;
    RET                               ;
DESP ENDP                             ;
;_____________________________________|
RETARd PROC NEAR                      ;-Retardo decrementando
DECR0:                                ;
    DEC     REG0                      ;-Decrementamos REG0
    CMP     REG0, 0x0000              ;-Comparamos si llega a 0
    JE      DECR1                     ;-Si llego, saltamos a DECR1
    JMP     DECR0                     ;-Sino, volvemos a DECR0 
DECR1:                                ;
    DEC     REG1                      ;-Decrementamos REG2
    CMP     REG1, 00000H              ;-Comparamos si llega a 0
    JE      DECR2                     ;-Si llego, saltamos a DECR2
    JMP     DECR1                     ;-Sino volvemos a DECR1
DECR2:                                ;
    DEC     REG2                      ;-Decrementamos REG2
    CMP     REG2, 00000H              ;-Comparamos si llega a 0
    JE      SALIR0                    ;-Si llego, salimos de la rutina
    JMP     DECR2                     ;-Sino, volvemos a DECR2
SALIR0:                               ;
    RET                               ;-Salida de rutina
RETARd ENDP                           ;
;_____________________________________|
RETARi PROC NEAR                      ;-Retardo incrementando
INCR0:                                ;
    INC     REG0                      ;-Incrementamos REG0
    CMP     REG0, 0x7FFF              ;-Comparamos si llega a 0x7FFF
    JE      INCR1                     ;-Si llega, saltamos a INCR1
    JMP     INCR0                     ;-Sino, volvemos a INCR0
INCR1:                                ;
    INC     REG1                      ;-Incrementamos REG1
    CMP     REG1, 0x7FFF              ;-Comparamos si llega a 0x7FFF
    JE      INCR2                     ;-Si llega, saltamos a INCR2
    JMP     INCR1                     ;-Sino, volvemos a INCR1
INCR2:                                ;
    INC     REG2                      ;-Incrementamos REG2
    CMP     REG2, 0x7FFF              ;-Comparamos si llega a 0x7FFF
    JE      SALIR1                    ;-Si llega, salimos de la rutina
    JMP     INCR2                     ;-Sino, regresamos a INCR2
SALIR1:                               ;
    RET                               ;-Salida de rutina 
RETARi ENDP                           ;
;_____________________________________|
END INICIO                            ;