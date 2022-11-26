    PAGE    60, 132                     ;
    TITLE   PRACT14.EXE                 ;-Detalles del programa,
    .MODEL  SMALL                       ; se define STACK, modelo
    .STACK  64                          ; y otros datos 
;____________________________________________________________________
    .DATA                               ;      
NAMEPAR LABEL BYTE                      ;-Etiqueta con parametros
    MAXLEN  DB  31                      ;-Longitud maxima
    ACTLEN  DB  ?                       ;-Longitud ingresada
    NAMEFLD DB  31 DUP(' ')             ;-Buffer del nombre
    COL     DB  00                      ;
    COUNT   DB  ?                       ;
    PROMPT  DB  'Name?', '$'            ;-Prompt a mostrar
    NAMEDSP DB  31 DUP(' '), 13, 10, '$';
    ROW     DB  00                      ;
;____________________________________________________________________     
    .CODE                               ;-Procedimiento principal
BEGIN PROC FAR                          ;-Inicializa y hace visible 
    MOV     AX, @DATA                   ; el segmento de datos
    MOV     DS, AX                      ;
    MOV     ES, AX                      ;
    MOV     AX, 0600H                   ;-Limpia y despeja
    CALL    Q10SCR                      ; la pantalla
    SUB     DX, DX                      ;-Fija cursor e
    CALL    Q20CURS                     ; posicion 0,0
A10LOOP:                                ;                     
    CALL    B10INPT                     ;-Peticion de recibir nombre
    TEST    ACTLEN, 0FFH                ;-Hay nombre? 
    JZ      A90                         ;  no, terminar
    CALL    D10SCAS                     ;-Buscar asteriscos
    CMP     AL, '*'                     ;-Hay asterisco?
    JE      A10LOOP                     ;  si, repetir entrada
    CALL    E10RGHT                     ;  no, justificar derecha
    CALL    F10CLNM                     ;-Despejar nombre
    JMP     A10LOOP                     ;
A90:                                    ;
    MOV     AX, 4C00H                   ;-Salir a DOS
    INT     21H                         ;
BEGIN ENDP                              ;                        
;____________________Acepta entrada de un nombre____________________
B10INPT PROC                            ;
    MOV     AH, 09H                     ;-Mostrar prompt
    LEA     DX, PROMPT                  ;
    INT     21H                         ;
    MOV     AH, 0AH                     ;
    LEA     DX, NAMEPAR                 ;-Aceptar entrada
    INT     21H                         ; en etiqueta 
    RET                                 ;
B10INPT ENDP                            ;
;____________________Buscar asterisco en nombre_____________________
D10SCAS PROC                            ;                            
    CLD                                 ;-DF = 0
    MOV     AL, '*'                     ;-Caracter a buscar
    MOV     CH, 00H
    MOV     CL, ACTLEN                  ;-Buscar en 30 caracteres
    LEA     DI, NAMEFLD                 ;-Buscar en buffer
    REPNE   SCASB                       ;-Busca lo de AL en DX
    JE      D20                         ;-No encontro, salir
    MOV     AL, 20H                     ;-Encontro, limpiar '*'
D20:                                    ;
    RET                                 ;
D10SCAS ENDP                            ;
;_______________Justificar a la derecha y exhibir nombre____________
E10RGHT PROC                            ;                             
    STD                                 ;-Izquierda a derecha DF = 1
    MOV     CH, 00                      ;
    MOV     CL, ACTLEN                  ;-Longitud a repetir en CX
    LEA     SI, NAMEFLD                 ;-Lee direccion nombre
    ADD     SI, CX                      ;-Calcular posicion mas a la
    DEC     SI                          ; derecha de lo ingresado
    LEA     DI, NAMEDSP+30              ;-Posicion a la derecha 
    REP     MOVSB                       ;-Mover cadena der-izq
    MOV     DH, ROW                     ;
    MOV     DL, 48                      ;
    CALL    Q20CURS                     ;-Fijar cursor
    MOV     AH, 09H                     ;-Exhibir nombre
    LEA     DX, NAMEDSP                 ;
    INT     21H                         ;
    CMP     ROW, 20                     ;-Parte inferior pantalla?
    JAE     E20                         ;  no, continua
    INC     ROW                         ;  incrementa hilera
    JMP     E90                         ;
E20:                                    ;
    MOV     AX, 0601H                   ;
    CALL    Q10SCR                      ;  si, 
    MOV     DH, ROW                     ;  recorrer
    MOV     DL, 00                      ;  y fijar cursor
    CALL    Q20CURS                     ;
E90:                                    ;
    RET                                 ;
E10RGHT ENDP                            ;
;__________________________Limpiar nombre___________________________
F10CLNM PROC                            ;
    CLD                                 ;-Izquierda a derecha
    MOV     AX, 2020H                   ;
    MOV     CX, 15                      ;-Despejar 15 palabras
    LEA     DI, NAMEDSP                 ;
    REP     STOSW                       ;
    RET                                 ;
F10CLNM ENDP                            ;
;_________________________Recorre la pantalla_______________________
Q10SCR PROC                             ;-AX se fija al inicio
    MOV     BH, 30                      ;-Atributo de color
    MOV     CX, 00                      ;
    MOV     DX, 184FH                   ;-Pantalla completa
    INT     10H                         ;
    RET                                 ;
Q10SCR ENDP                             ;
;___________________________Coloca el cursor________________________                                                                    
Q20CURS PROC                            ;-DX se fija al inicio
    MOV     AH, 02H                     ;
    SUB     BH, BH                      ;-Pagina
    INT     10H                         ;
    RET                                 ;
Q20CURS ENDP                            ;                                
;____________________________________________________________________
    END     BEGIN