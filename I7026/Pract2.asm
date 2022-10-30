;_______________________________; DEFINICION DE PROGRAMA
    PAGE    60,132              ;   
    TITLE   PROG2.EXE           ;
    .MODEL  SMALL               ;
;_______________________________|
.STACK 64                       ; SEGMENTO STACK
;_______________________________|
.DATA                           ; SEGMENTO DATOS
    DAT1    DB 05H              ; BYTE 05H
    DAT2    DB 10H              ; BYTE 10H
    DAT3    DB ?                ; RESERVAR 1 BYTE 
    DAT4    DB 01001000B        ; BYTE EN BINARIO (48H)
    DAT5    DB 10 DUP (0)       ; DEFINE 10 CEROS
    DAT7    DB 'HOLA'           ; DEFINE CADENA
    DAT8    DB 08,'MAYO',01     ; DEFINE FECHA (CADENA Y NUMERO)
    DAT9    DW 0FFFFH           ; CONSTANTE HEX DE 2 BYTES
    DAT10   DD ?                ; RESERVAR 4 BYTES
    DATB    DD 325772           ; VALOR DECIMAL EN 4 BYTES
    DATC    DW ?                ; RESERVAR 2 BYTES
    DATD    DB 10 DUP (?)       ; 10 ESPACIOS EN BLANCO
    TIME    EQU 10              ; VARIABLE "TIME" = 10 (DECIMAL)
    DATE    DB TIME DUP (?)     ; 10 ESPACIOS EN BLANCO
;_______________________________|
.CODE                           ; SEGMENTO CODIGO                                ;
                                ;
BEGIN PROC FAR                  ;
    MOV     AX, @DATA           ;
    MOV     DS, AX              ; CARGAR SEGMENTO DE DATOS
    MOV     AH, DAT1            ;
    ADD     AH, DAT2            ;
    MOV     DAT3, AH            ;
    MOV     AH,TIME             ;
    MOV     AX,4C00H            ;
    INT     21H                 ; RETORNO DE CONTROL
    BEGIN ENDP                  ;
END BEGIN                       ;
;_______________________________|