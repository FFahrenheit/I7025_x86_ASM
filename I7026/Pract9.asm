    PAGE    60,132                    ;-Detalles del
    TITLE   PROG9.EXE                 ; programa
    .MODEL  MEDIUM                    ;-Medium porque es grande
    .STACK  64                        ;
;_____________________________________;
    .DATA                             ;
ENTRADA1 LABEL BYTE                   ;-Label para nombre
    LONMAX1     DB 20                 ;
    LONREAL1    DB ?                  ;
    INTRO1      DB 21 DUP (' ')       ;
                                      ;
ENTRADA2 LABEL BYTE                   ;-Label para carrera
    LONMAX2     DB 25                 ;
    LONREAL2    DB ?                  ;
    INTRO2      DB 21 DUP (' ')       ;
                                      ; 
ENTRADA3 LABEL BYTE                   ;-Label para registro
    LONMAX3     DB 20                 ;
    LONREAL3    DB ?                  ;
    INTRO3      DB 21 DUP (' ')       ;
                                      ; 
    ETIQ1       DB 'NOMBRE : ','$'    ;-Mensajes a 
    ETIQ2       DB 'CARRERA : ','$'   ; mostrar al pedir 
    ETIQ3       DB 'REGISTRO : ','$'  ; la entrada
;_____________________________________|
    .CODE                             ;
MAIN PROC FAR                         ;-Proc. FAR al crecer el 
    MOV     AX, @DATA                 ; codigo
    MOV     DS, AX                    ;
    CALL    PANT0                     ;-Mostrar pantalla
    MOV     DX, 0404H                 ;
    CALL    CURS0                     ;-Pedir entrada 1
    LEA     DX, ETIQ1                 ;
    CALL    DESPM0                    ;
    LEA     DX, ENTRADA1              ;
    CALL    TECLA0                    ;
    CALL    CAMPANA1                  ;
    MOV     DX, 0C04H                 ;
    CALL    CURS0                     ;-Pedir entrada 2
    LEA     DX, ETIQ2                 ;
    CALL    DESPM0                    ;
    LEA     DX, ENTRADA2              ;
    CALL    TECLA0                    ;
    CALL    CAMPANA2                  ;
    MOV     DX, 1304H                 ;
    CALL    CURS0                     ;-Pedir entrada 3
    LEA     DX, ETIQ3                 ;
    CALL    DESPM0                    ;
    LEA     DX, ENTRADA3              ;                                      
    CALL    TECLA0                    ;                             
    CALL    CAMPANA3                  ;
    MOV     DX, 0427H                 ;                                 
    CALL    CURS0                     ;
    LEA     DX, INTRO1                ;-Mostrar entrada 1                                      
    CALL    DESPM0                    ;
    MOV     DX, 0C27H                 ;
    CALL    CURS0                     ;
    LEA     DX, INTRO2                ;-Mostrar entrada 2
    CALL    DESPM0                    ;
    MOV     DX, 1327H                 ;
    CALL    CURS0                     ;
    LEA     DX, INTRO3                ;-Mostrar entrada 3
    CALL    DESPM0                    ;
    MOV     AX, 4C00H                 ;
    INT     21H                       ;
MAIN ENDP                             ;
;_____________________________________|
PANT0 PROC NEAR                       ;-Mostrar pantalla
    MOV     AX, 0600H                 ;
    MOV     BH, 0AH                   ;
    MOV     CX, 0000H                 ;
    MOV     DX, 184FH                 ;
    INT     10H                       ;
    RET                               ;
PANT0 ENDP                            ;
;_____________________________________|
CURS0 PROC NEAR                       ;-Posicionar cursor
    MOV     AH,02H                    ;
    MOV     BH,00H                    ;
    INT     10H                       ;
    RET                               ;
CURS0 ENDP                            ;
;_____________________________________|
DESPM0 PROC NEAR                      ;-Mostrar mensaje
    MOV     AH, 09H                   ;
    INT     21H                       ;
    RET                               ;
DESPM0 ENDP                           ;
;_____________________________________|
TECLA0 PROC NEAR                      ;-Recibir entrada
    MOV     AH, 0AH                   ;
    INT     21H                       ;
    RET                               ;
TECLA0 ENDP                           ;
;_____________________________________|
CAMPANA1 PROC NEAR                    ;-Campana 1
    MOV     BX, 00H                   ;
    MOV     BL, LONREAL1              ;
    MOV     INTRO1[BX], 07H           ;-Sonido de camana
    MOV     INTRO1[BX+1], '$'         ;-Delimitar cadena
    RET                               ;
CAMPANA1 ENDP                         ;
;_____________________________________|
CAMPANA2 PROC NEAR                    ;-Campana 2
    MOV     BX, 00H                   ;
    MOV     BL, LONREAL2              ;
    MOV     INTRO2[BX], 07H           ;
    MOV     INTRO2[BX+1], '$'         ;
    RET                               ;
CAMPANA2 ENDP                         ;
;_____________________________________|
CAMPANA3 PROC NEAR                    ;-Campana 3
    MOV     BX, 00H                   ;
    MOV     BL, LONREAL3              ;
    MOV     INTRO3[BX], 07H           ;
    MOV     INTRO3[BX+1], '$'         ;
    RET                               ;
CAMPANA3 ENDP                         ;
;_____________________________________|
END MAIN