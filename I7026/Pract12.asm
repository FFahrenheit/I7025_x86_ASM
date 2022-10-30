    TITLE   PRACT12.EXE               ;-Detalles del programa,
    .MODEL  SMALL                     ; se define STACK y DATA
    .STACK  64                        ; para generar el .exe
    .DATA                             ;
;_____________________________________|
    .CODE                             ;-Codigo, no podemos usar ORG
;    ORG     100H                     ; porque ya definimos segmentos
BEGIN PROC NEAR                       ;
    MOV     AH, 0FH                   ;-Conserva el modo 
    INT     10H                       ; de video (leer modo)
    PUSH    AX                        ; original y guarda en stack
    CALL    B10MODE                   ;-Designa el modo grafico
    CALL    C10DISP                   ;-Despliegue grafico en color
    CALL    D10KEY                    ;-Obtiene respuesta del teclado
    POP     AX                        ;-Restaura el modo original
    MOV     AH, 00H                   ; de video (en AL)
    INT     10H                       ;
    MOV     AX, 4C00H                 ;-Retorna control
    INT     21H                       ; al SO
BEGIN ENDP                            ;
;_____________________________________|
B10MODE PROC NEAR                     ;-Rutina modo grafico
    MOV     AH, 00H                   ;-Establece modo grafico EGA/VGA
    MOV     AL, 10H                   ; 640cols x 350 filas
    INT     10H                       ;
    MOV     AH, 0BH                   ;-Color de fondo y borde
    MOV     BH, 00H                   ;-Fondo
    MOV     BL, 07H                   ; plata
    INT     10H                       ;
    RET                               ;
B10MODE ENDP                          ;
;_____________________________________|
C10DISP PROC NEAR                     ;
    MOV     BX, 0000H                 ;-Deisgna al pagina 00, color 00
    MOV     CX, 64                    ; columna 0x40
    MOV     DX, 70                    ; fila    0x46
C20:                                  ;
    MOV     AH, 0CH                   ;-Escribe el pixel punto
    MOV     AL, BL                    ;-Deisgna el color
    INT     10H                       ;-Conserva BX, CX, DX
    INC     CX                        ;-Incrementa la columna
    CMP     CX, 576                   ;-Compara si la columna es 576
    JNE     C20                       ; si no, repite
    MOV     CX, 64                    ; si si, restuara la columna
    INC     BL                        ;-Cambia el color
    INC     DX                        ;-Compara si el renglon es 280
    CMP     DX, 280                   ; si no, repite
    JNE     C20                       ; si si, termina
    RET                               ;
C10DISP ENDP                          ;
;_____________________________________|
D10KEY PROC NEAR                      ;
    MOV     AH, 10H                   ;-Peticion de teclado
    INT     16H                       ; (system pause)
    RET                               ;
D10KEY ENDP                           ;
;_____________________________________|
    END     BEGIN                     ;
    