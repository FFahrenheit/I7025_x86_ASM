    PAGE    60,132                    ;-Detalles 
    TITLE   PROG8.EXE                 ; del
    .MODEL  SMALL                     ; programa
    .STACK  64                        ;-Segmento de pila
;_____________________________________|
    .DATA                             ;-Segmento de datos
ENTRA   LABEL   BYTE                  ;-Declaracion de etiqueta
LONMAX  DB 20                         ; con longitud maxima
LONREAL DB ?                          ; longitud real
INTROD  DB 21 DUP (' ')               ; y su contenido (en default)
MEN     DB 'INTRODUCIR NOMBRE: ', '$' ;-Mensaje de entrada a mostrar
;_____________________________________| terminado en $
    .CODE                             ;-Segmento de codigo
BEGIN PROC FAR                        ;-***INICIO BEGIN***
    MOV     AX, @DATA                 ;-Visualizar el segmento
    MOV     DS, AX                    ; de datos
OTRO:                                 ;-Etiqueta OTRO
    CALL    PANT0                     ;-Llamar a PANT0
    MOV     DX, 0502H                 ;-Colocar pos. 5,2 (y,x)
    CALL    CURS0                     ; y llamar a CURS0
    CALL    DESPL0                    ;-Llamar a DESPL0
    CALL    TECLA0                    ;-Llamar a TECLA0
    CMP     LONREAL, 00               ;-Comparar si la longitud es 0
    JE      SALIR                     ;-Si es 0, salta a SALIR
    CALL    CAMPA                     ;-Llamar a CAMA
    CALL    CENTRAR                   ;-Llamar a CENTRAR
    JMP     OTRO                      ;-Rergesar a OTRO
SALIR:                                ;-Etiqueta SALIR
    MOV     AX, 4C00H                 ;-Retornar control al SO
    INT     21H                       ; y ejecutar
BEGIN ENDP                            ;-***FIN BEGIN***
;_____________________________________|
DESPL0 PROC NEAR                      ;-***INICIO DESPL0***
    MOV     AH, 09H                   ;-Mostrar cadena
    LEA     DX, MEN                   ;-Cargar direccion de cadena
    INT     21H                       ;-Llamar a la interrupcion
    RET                               ;-Retornar de la funcion
DESPL0 ENDP                           ;-***FIN DEPSPL0****
;_____________________________________|
TECLA0 PROC NEAR                      ;-***INICIO TECLA0***
    MOV     AH, 0AH                   ;-Leer cadena y almacenar
    LEA     DX, ENTRA                 ;-Direccion de etiqueta label (buffer)
                                      ; con contenido y longitud definida
    INT     21H                       ;-Llamar a interrupcion
    RET                               ;-Retornar de funcion
TECLA0 ENDP                           ;-FIN TECLA0
;_____________________________________|
CAMPA PROC NEAR                       ;-***INICIO CAMPA***
    MOV     BH, 00                    ;-Cargar longitud real de la 
    MOV     BL, LONREAL               ; cadena ingresada
    MOV     INTROD[BX], 07H           ;-Cambiar ultimo caracter por 07 (bell)
    MOV     INTROD[BX+1], '$'         ;-Colocar en sig. posicion "$"
    RET                               ;-Retornar de funcion
CAMPA ENDP                            ;-***FIN CAMPA***
;_____________________________________|
CENTRAR PROC NEAR                     ;-***INICIO CENTRAR***
    MOV     DL, LONREAL               ;-Cargar en DL longitud real
    SHR     DL, 1                     ;-Dividir entre 2 sin residuo
    NEG     DL                        ;-Hacer negativo
    ADD     DL, 40                    ;-Sumar 40 para obtener centro de inicio
    MOV     DH, 12                    ;-Colocar mitad de filas
    CALL    CURS0                     ;-Llamar al CURS0 (colocar)
    MOV     AH, 09H                   ;-Mostrar cadena 
    LEA     DX, INTROD                ;-Direccion del buffer
    INT     21H                       ;-Llamar a interrupcion
    RET                               ;-Retornar de funcion
CENTRAR ENDP                          ;-***FIN CENTRAR***
;_____________________________________|
PANT0 PROC NEAR                       ;-***INICIO PANT0***
    MOV     AX, 0600H                 ;-Desplazar lineas, en modo scroll
                                      ; borra todo
    MOV     BH, 30                    ;-Texto amarillo, fondo azul (1EH)
    MOV     CX, 0000                  ;-Desde 0,0 (col, fila)
    MOV     DX, 184FH                 ;-Hasta 18, 4F (25x80)
    INT     10H                       ;-Llama a la interrupcion
    RET                               ;-Regresa de la funcion
PANT0 ENDP                            ;-***FIN PANT0***
;_____________________________________;
CURS0 PROC NEAR                       ;-***INICIO CURS0***
    MOV     AH, 02H                   ;-Int. para colocar cursor
    MOV     BH, 00                    ;-En la pagina 0
    INT     10H                       ;-Llama a interrupcion, colocando
    RET                               ; en lo que contiene DX y retorna
CURS0 ENDP                            ;-***FIN CURS0***
;_____________________________________;
END BEGIN