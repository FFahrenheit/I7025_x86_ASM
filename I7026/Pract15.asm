    TITLE   PRACT15.EXE               ;-Detalles del programa
    .MODEL  SMALL                     ;
;_____________________________________|
    .CODE                             ;-Empezamos el codigo en 
    ORG     100H                      ; 100H, saltamos a el
BEGIN:                                ; inicio del codigo
    JMP     SHORT MAIN                ;
;_____________________________________|
    ASCVAL  DB  '1234'                ;-Definimos los datos  
    BINVAL  DW  0                     ; y variables auxiliares
    ASCLEN  DW  4                     ; posteriormente
    MULT10  DW  1                     ;
;_____________________________________|
MAIN PROC NEAR                        ;-Empezamos el codigo real
    MOV     BX, 10                    ;-Factor de multiplicacion
    MOV     CX, ASCLEN                ;-Contador (digitos del valor)
    LEA     SI, ASCVAL+3              ;-Direccion (ultimo digito) del
B20:                                  ; valor en ASCII
    MOV     AL, [SI]                  ;-Selecciona el caracter actual
    AND     AX, 000FH                 ;-Borra el 3 del valor
    MUL     MULT10                    ;-Multiplica por el factor
    ADD     BINVAL, AX                ;-Suma al binario
    MOV     AX, MULT10                ;-Calcula el siguiente factor
    MUL     BX                        ; que sera multuplicado por
    MOV     MULT10, AX                ; 10 y lo asigna
    DEC     SI                        ;
    LOOP    B20                       ;-Es el ultimo caracter?
    MOV     AX, 4C00H                 ; si no, continuar
    INT     21H                       ;-Retorna control al S.O.
MAIN ENDP                             ;
;_____________________________________|
    END     BEGIN
      
 