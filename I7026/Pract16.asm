    TITLE   PRACT16.COM             ;-Detalles del programa,
    .MODEL  SMALL                   ; se define STACK, modelo
    .CODE                           ; y otros datos              
    ORG     100H                    ;
BEGIN:                              ;
    JMP     SHORT MAIN              ;
;________________________________________________________________
NINE    DB  9                       ;-Longitud de registro
MONIN   DB  '04'                    ;-Mes a mostrar
ALFMON  DB  9 DUP (20H), '$'        ;-Espacio para mes obtenido
MONTAB  DB  'January  ', 'February ';-Tabla con
        DB  'March    ', 'April    '; los meses
        DB  'May      ', 'June     '; en ingles
        DB  'July     ', 'August   '; con 9 caracteres
        DB  'September', 'October  '; por registro
        DB  'November ', 'December ';        
;___________________________________|____________________________
;.386                               ;
MAIN PROC NEAR                      ;-Procedimiento principal
    CALL    C10CONV                 ;-Convierte a binario
    CALL    D10LOC                  ;-Localiza el mes
    CALL    F10DISP                 ;-Muestra el mes
    MOV     AX, 4C00H               ;-Regresa el control 
    INT     21H                     ; al S.O.
MAIN ENDP                           ;
;__________________Convertir ASCII a binario_____________________
C10CONV PROC                        ;
    MOV     AH, MONIN               ;-Lee el mes y lo coloca
    MOV     AL, MONIN+1             ; en AX
    XOR     AX, 3030H               ;-Limpia los 3 del ASCII
    CMP     AH, 00                  ;-El mes esta entrea 01 y 09? 
    JZ      C20                     ;  si, continua
    SUB     AH, AH                  ;  sino, limpiamos AH
    ADD     AL, 10                  ;  y le sumamos 10
C20:                                ;  para ajustar
    RET                             ;
C10CONV ENDP                        ;
;_________________Localizar el mes en la tabla___________________
D10LOC PROC                         ;
    LEA     SI, MONTAB              ;-Leemos la tabla
    DEC     AL                      ;-Restamos 1 para indexar
    MUL     NINE                    ;-Mult. por long. registro
    ADD     SI, AX                  ;-Indexamos el offset
;    MOVZX   CX, NINE               ;-MOVZX no existe en 8086
    XOR     CX, CX                  ; pero limpiamos CX
    MOV     CL, NINE                ; y tomamos el reg. de 8 bits
    CLD                             ;-DF=0 (inc idx en op. string) 
    LEA     DI, ALFMON              ;-Leemos dir. de guardado 
    REP     MOVSB                   ;-Movemos de str a str 
    RET                             ; repitiendo 9 veces
D10LOC ENDP                         ;
;_________________Despliega el mes (alfabetico)__________________
F10DISP PROC                        ;
    MOV     AH, 09H                 ;-Desplegar la cadena
    LEA     DX, ALFMON              ; en pantalla
    INT 21H                         ;
    RET                             ;
F10DISP ENDP                        ;
;________________________________________________________________
    END     BEGIN