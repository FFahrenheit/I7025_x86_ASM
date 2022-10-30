    PAGE    60, 132                     ;
    TITLE   PRACT11.EXE                 ;-Detalles del programa,
    .MODEL  SMALL                       ; se define STACK, modelo
    .STACK  64                          ; y otros datos 
;____________________________________________________________________
    .DATA                               ;      
NAMEPAR LABEL BYTE                      ;-Etiqueta con parametros
    MAXLEN  DB  20                      ;-Longitud maxima
    ACTLEN  DB  ?                       ;-Longitud ingresada
    NAMEFLD DB  20 DUP(' ')             ;-Buffer del nombre
    COL     DB  00                      ;
    COUNT   DB  ?                       ;
    PROMPT  DB  'Name? '                ;-Prompt a mostrar
    ROW     DB  00                      ;
;____________________________________________________________________     
    .CODE                               ; 
BEGIN PROC FAR                          ;-Inicializa y hace visible 
    MOV     AX, @DATA                   ; el segmento de datos
    MOV     DS, AX                      ;
    MOV     ES, AX                      ;
    MOV     AX, 0600H                   ;-Limpia la pantalla
    CALL    Q10SCR                      ; pantalla
A20LOOP:                                ;
    MOV     COL, 00                     ;-Establece columna 0
    CALL    Q20CURS                     ; y lo posiciona
    CALL    B10PRMP                     ;-Muestra prompt
    CALL    D10INPT                     ;-Pide entrada de nombre
    CMP     ACTLEN, 00                  ;-Hay nombre?
    JNE     A30                         ;  si, salta a continuar
    MOV     AX, 0600H                   ;  no, limpia pantalla
    CALL    Q10SCR                      ;  y sale al
    MOV     AX, 4C00H                   ;  DOS
    INT     21H                         ;
A30:                                    ;
    CALL    E10NAME                     ;-Despliega nombre y 
    JMP     A20LOOP                     ; repite
BEGIN ENDP                              ;
;______________________Despliega la indicacion______________________
B10PRMP PROC NEAR                       ;
    LEA     SI, PROMPT                  ;-Direccion del prompt
    MOV     COUNT, 05                   ;-Caracteres a mostrar
B20:                                    ;
    MOV     BL, 71H                     ;-Video inverso
    CALL    F10DISP                     ;-Rutina de despliegue
    INC     SI                          ;-Siguiente caracter
    INC     COL                         ;-Siguiente columna cursor
    CALL    Q20CURS                     ;-Posiciona cursor
    DEC     COUNT                       ;-Cuenta descendente
    JNZ     B20                         ;-Repite el ciclo n veces
    RET                                 ;
B10PRMP ENDP                            ;
;____________________Acepta entrada de un nombre____________________
D10INPT PROC NEAR                       ;
    MOV     AH, 0AH                     ;-Peticion de entrada
    LEA     DX, NAMEPAR                 ; desde el teclado
    INT     21H                         ; en etiqueta 
    RET                                 ;
D10INPT ENDP                            ;
;______Despliega el nombre en video inverso y con intermitencia_____
E10NAME PROC NEAR                       ;
    LEA     SI, NAMEFLD                 ;-Lee direccion nombre
    MOV     COL, 40                     ;-Columna 40
E20:                                    ;
    CALL    Q20CURS                     ;-Coloca el cursor
    MOV     BL, 0F1H                    ;-Video inverso intermitente
    CALL    F10DISP                     ; y despliega
    INC     SI                          ;-Siguiente caracter
    INC     COL                         ;-Siguiente columna
    DEC     ACTLEN                      ;-Disminuye longitud nombre
    JNZ     E20                         ;-Repite el ciclo n veces
    CMP     ROW, 20                     ;-Borde inferior de pantalla?
    JAE     E30                         ;  
    INC     ROW                         ;  no, incrementa renglon
    RET                                 ;
E30:                                    ;
    MOV     AX, 0601H                   ;  si, recorre la pantalla
    CALL    Q10SCR                      ;
    RET                                 ;
E10NAME ENDP                            ;
;____________________________Despliegue_____________________________
F10DISP PROC NEAR                       ;-BL atributo ya definido
    MOV     AH, 09H                     ;-Peticion de despliegue
    MOV     AL, [SI]                    ;-Obtiene caracter de nombre
    MOV     BH, 00                      ;-Numero de pagina
    MOV     CX, 01                      ;-Un caracter
    INT     10H                         ;
    RET                                 ;
F10DISP ENDP                            ;
;_________________________Recorre la pantalla_______________________
Q10SCR PROC NEAR                        ;-AX se despliega antes
    MOV     BH, 17H                     ;-Blanco sobre azul
    MOV     CX, 0000                    ;
    MOV     DX, 184FH                   ;-Pantalla completa
    INT     10H                         ;
    RET                                 ;
Q10SCR ENDP                             ;
;___________________________Coloca el cursor________________________                                                                    
Q20CURS PROC NEAR                       ;
    MOV     AH, 02H                     ;
    MOV     BH, 00                      ;-Pagina
    MOV     DH, ROW                     ;-Renglon
    MOV     DL, COL                     ;-Columna
    INT     10H                         ;
    RET                                 ;
Q20CURS ENDP                            ;                                
;____________________________________________________________________
    END     BEGIN