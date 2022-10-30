    PAGE    60, 132                     ;
    TITLE   PRACT13.EXE                 ;-Detalles del programa,
    .MODEL  SMALL                       ; se define STACK, modelo
    .STACK  64                          ; y otros datos 
;____________________________________________________________________
    .DATA                               ;      
TOPROW  EQU 00                          ;-Fila superior menu
BOTROW  EQU 07                          ;-Fila inferior menu
LEFCOL  EQU 16                          ;-Col. izquierda menu
COL     DB  00                          ;-Columna actual
ROW     DB  00                          ;-Fila actual
COUNT   DB  ?                           ;-Caracteres en linea
LINES   DB  7                           ;-Lineas excluidas
ATTRIB  DB  ?                           ;-Atributo pantalla
NINTEEN DB  19                          ;-Ancho menu
MENU    DB  0xC9, 17 DUP(0xCD), 0xBB    ;-Impresion
    DB  0xBA, ' Add records     ', 0xBA ; del menu
    DB  0xBA, ' Delete records  ', 0xBA ; 
    DB  0XBA, ' Enter orders    ', 0xBA ;
    DB  0xBA, ' Print report    ', 0xBA ;
    DB  0xBA, ' Update accounts ', 0xBA ;
    DB  0xBA, ' View records    ', 0xBA ;
    DB  0xC8, 17 DUP(0xCD), 0xBC        ;
PROMPT  DB 09, 'To select an item, use ';-Impresion del
    DB  'up/down arrow and press Enter.'; prompt
    DB  13, 10, 09,                     ;
    DB  'Press Esc to exit.'            ;
;____________________________________________________________________     
    .CODE                               ; 
BEGIN PROC FAR                          ;
    MOV     AX, @DATA                   ;-Hacemos visible
    MOV     DS, AX                      ; segmento de datos
    MOV     ES, AX                      ; 
    CALL    Q10CLR                      ;-Limpiar pantalla
    MOV     ROW, BOTROW + 2             ;
    MOV     COL, 00                     ;
    CALL    Q20CURS                     ;-Fijar cursor
    MOV     AH, 40H                     ;-Mostrar pantalla
    MOV     BX, 01                      ;-Caracteres
    MOV     CX, 75                      ;-Mensaje
    LEA     DX, PROMPT                  ;-Llamar int.
    INT     21H                         ;
A10LOOP:                                ;
    CALL    B10MENU                     ;-Mostrar menu
    MOV     COL, LEFCOL+1               ;
    CALL    Q20CURS                     ;-Fijar cursor
    MOV     ROW, TOPROW+1               ;-Fijar opcion primera fila
    MOV     ATTRIB, 16H                 ;-Color inverso a menu
    CALL    H10DISP                     ;-Resltar linea del menu
    CALL    D10INPT                     ;-Seleccion de menu
    CMP     AL, 0DH                     ;-Se presiono tecla?
    JE      A10LOOP                     ;- Si, continuar
    MOV     AX, 0600H                   ;- Esc. (acabar)
    CALL    Q10CLR                      ;-Limpiar panatalla
    MOV     AX, 4C00H                   ;-Retornar control al 
    INT     21H                         ; sistema operativo
BEGIN ENDP                              ;
;_________________________Mostrar todo el menu_______________________
B10MENU PROC NEAR                       ;
    MOV     ROW, TOPROW                 ;-Fila superior
    MOV     LINES, 08                   ;-Numero de lineas
    LEA     SI, MENU                    ;-Leer menu
    MOV     ATTRIB, 71H                 ;-Azul sobre blanco
B20:                                    ;-Fijar col. izquierda
    MOV     COL, LEFCOL                 ;
    MOV     COUNT, 19                   ;
B30:                                    ;
    CALL    Q20CURS                     ;-Fijar sig. columna
    MOV     AH, 09H                     ;-Mostrar pantalla
    MOV     AL, [SI]                    ;-Obtener caracter menu
    MOV     BH, 00                      ;-Pagina 0
    MOV     BL, 71H                     ;-Nuevo atributo
    MOV     CX, 01                      ;-Un caracter
    INT     10H                         ;
    INC     COL                         ;-Sig. columna
    INC     SI                          ;-Fijar sig. caracter
    DEC     COUNT                       ;-Ultimo caracter?
    JNZ     B30                         ;- No, repetir
    INC     ROW                         ;- Siguiente fila
    DEC     LINES                       ;
    JNZ     B20                         ;-Se imprimio todo?
    RET                                 ;- si, terminar
B10MENU ENDP                            ;
;______________________Aceptar entrada a pedido______________________
D10INPT PROC NEAR                       ;
    MOV     AH, 10H                     ;-Pedir entrada del
    INT     16H                         ; teclado
    CMP     AH, 50H                     ;-Flecha hacia abajo?
    JE      D20                         ;- si, ve a D20
    CMP     AH, 48H                     ;-Flecha hacia arriba?
    JE      D30                         ;- si, ve a D30
    CMP     AL, 0DH                     ;-Enter?
    JE      D40                         ;- si, ve a D40
    CMP     AL, 1BH                     ;-Tecla enter?
    JE      D90                         ;- si, ve a D90     
    JMP     D10INPT                     ;-Ninguna, procesar de nuevo
D20:                                    ;
    MOV     ATTRIB, 71H                 ;-Azul sobre blanco
    CALL    H10DISP                     ;-Fijar linea ant. a normal
    INC     ROW                         ;
    CMP     ROW, BOTROW-1               ;-Se paso la ultima fila?
    JBE     D40                         ;- no, continuar a D40
    MOV     ROW, TOPROW+1               ;- si, restablecer 
    JMP     D40                         ;  a primera fila
D30:                                    ;
    MOV     ATTRIB, 71H                 ;-Video normal
    CALL    H10DISP                     ;-Fijar linea ant. a normal 
    DEC     ROW                         ;
    CMP     ROW, TOPROW+1               ;-Se paso primera fila
    JAE     D40                         ;- no, continuar
    MOV     ROW, BOTROW-1               ;- si, restablecer a 
D40:                                    ;  ultima fila
    CALL    Q20CURS                     ;-Fijar cursor
    MOV     ATTRIB, 16H                 ;-Video inverso
    CALL    H10DISP                     ;-Nueva linea a video inverso
    JMP     D10INPT                     ;
D90:                                    ;
    RET                                 ;
D10INPT ENDP                            ;
;________________Fijar linea de menu a normal/resltada_______________
H10DISP PROC NEAR                       ;
    MOV     AH, 00                      ;
    MOV     AL, ROW                     ;-La fila dice que linea fijar
    MUL     NINTEEN                     ;-Mult. por long. de la linea
    LEA     SI, MENU+1                  ; por la linea seleccionada
    ADD     SI, AX                      ;
    MOV     COUNT, 17                   ;-Caracteres a exhibir
H20:                                    ;
    CALL    Q20CURS                     ;-Fijar cursor en columna
    MOV     AH, 09H                     ;-Int. a pantalla
    MOV     AL, [SI]                    ;-Obtener caracter del menu
    MOV     BH, 00                      ;-Pagina 0
    MOV     BL, ATTRIB                  ;-Atributo seleccionado
    MOV     CX, 01                      ;-Un caracter
    INT     10H                         ;
    INC     COL                         ;-Siguiente columna
    INC     SI                          ;-Fijar sig. caracter
    DEC     COUNT                       ;-Ultimo caracter?
    JNZ     H20                         ;- no, repetir
    MOV     COL, LEFCOL+1               ;-Restablecer columna a izq.
    CALL    Q20CURS                     ;-Fijar cursor
    RET                                 ;
H10DISP ENDP                            ;
;_________________________Despejar pantalla__________________________
Q10CLR PROC NEAR                        ;
    MOV     AX, 0600H                   ;
    MOV     BH, 61H                     ;-Azul sobre cafe
    MOV     CX, 0000                    ;
    MOV     DX, 184FH                   ;
    INT     10H                         ;-Llamar interrupcion
    RET                                 ;
Q10CLR  ENDP                            ;
;_____________________Fijar cursor fila:columna______________________
Q20CURS PROC NEAR                       ;
    MOV     AH, 02H                     ;
    MOV     BH, 00                      ;-Pagina 0
    MOV     DH, ROW                     ;-Fila
    MOV     DL, COL                     ;-Columna
    INT     10H                         ;-Llamar interrupcion
    RET                                 ;
 Q20CURS ENDP                           ;
;____________________________________________________________________
    END BEGIN                           ;

    
               