;______________________________________|
                                       ;
    PAGE    60,132                     ;-Datos
    TITLE   PROG7.EXE                  ; del
    .MODEL  SMALL                      ; programa
    .STACK  64                         ;-Segmento de stack
;______________________________________|
                                       ;
    .DATA                              ;-Segmento de datos
ETIQ DB 'ISMAEL IVAN LOPEZ MURILLO'    ;-Mensaje a mostrar       
    DB ' ',1,'$'                       ; usamos 1 para carita
;______________________________________;
    .CODE                              ;-Segmento de codigo
BEGIN PROC FAR                         ;-Proc. principal begin
    MOV     AX, @DATA                  ;-Cargar el segmento
    MOV     DS, AX                     ; de datos
    CALL    PANT0                      ;-Llamar a PANT0
    CALL    CURSOR                     ;-Llamar a CURSOR
    CALL    DESPL0                     ;-Llamar a DESPL0
    MOV     AX, 4C00H                  ;-INT 21H para retornar
    INT     21H                        ; control al S.O.
BEGIN ENDP                             ;
;______________________________________|
PANT0 PROC NEAR                        ;-Proc. PANT0
    MOV     AX, 0600H                  ;-Scroll, borrar todo
    MOV     BH, 0AH                    ;-Con color, Cyan/Negro
    MOV     CX, 0000H                  ;-Desde 0,0   (y,x)
    MOV     DX, 184FH                  ;-Hasta 18,4F (25x80)
    INT     10H                        ;-INT 10H (pantalla)
    RET                                ;-Retornamos y fin
PANT0 ENDP                             ; de procedimiento
;______________________________________|
CURSOR PROC NEAR                       ;-Proc. CURSOR
    MOV     AH, 02H                    ;-Poner en posicion
    MOV     BH, 00                     ;-Pagina 00
    MOV     DX, 0D1BH                  ;-Posicion 5,2  (y,x)
    INT     10H                        ;-INT 1OH (pantalla)
    RET                                ;-Retornamos y fin
CURSOR ENDP                            ; de procedimiento
;______________________________________|
DESPL0 PROC NEAR                       ;
    MOV     AH, 09H                    ;-Ver cadena caracteres 
    LEA     DX, ETIQ                   ;-Cargar pos. cadena
    INT     21H                        ;-INT 21H (mostrar cad.)
    RET                                ;-Retornamos y fin
DESPL0 ENDP                            ; de procedimiento
;______________________________________|
END BEGIN                              ;  
;______________________________________|-Fin del programa