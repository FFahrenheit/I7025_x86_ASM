;_____________________________________|
    PAGE    60,132                    ; DETALLES E IDENTIFICACION DEL PROGRAMA
    TITLE   PROG5.EXE                 ; 
    .MODEL  SMALL                     ; MODELO SMALL
;_____________________________________|
    .STACK  64                        ; DECLARACION DEL SEGMENTO STACK
    .DATA                             ; DECLARACION DEL SEGMENTO DE DATOS
;_____________________________________|
    .CODE                             ; DECLARACION DEL SEGMENTO DE CODIGO   
BEGIN PROC FAR                        ; INCIO DEL CODIGO Y PROCEDIMIENTO BEGIN
    MOV     AX,01H                    ;
    MOV     BX,01H                    ; INSTRUCCIONES MOV 01H A AX, BX
    CALL    B10                       ; SE LLAMA AL PROCEDIMIENTO B10, SE GUARDA
                                      ; IP EN EL STACK Y SE SALTA A B10
    MOV     AX,4C00H                  ; AL REGRESAR, SE CARGA AX CON 4C00H
    INT     21H                       ; Y SE RETORNA EL CONTROL AL S.O.
BEGIN ENDP                            ; FINALIZA PROCESO BEGIN
;_____________________________________|
B10 PROC NEAR                         ; INICIO PROCEDIMIENTO B10
    MOV     CX,01H                    ; SE MODIFICA CX A 01H
    CALL    C10                       ; SE LLAMA A LA FUNCION C10, SE GUARDA
                                      ; IP EN EL STACK Y SE SALTA A C10
    SHL     CX,1                      ; AL REGRESAR, SE HACE SHIFT A CX 1 BIT 
    RET                               ; SE RETORNA, HACE PUSH AL STACK Y SE 
                                      ; RETORNA A ESA DIRECCION (BEGIN)
B10 ENDP
;_____________________________________|
C10 PROC NEAR                         ; INICIO DEL PROCEDIMIENTO C10
    ADD     AX,01H                    ; SE SUMA 01H A AX, 01 + 01 = 02H
    ADD     BX, AX                    ; SE SUMA AX A BX, 01 + 02 = 03H
    RET                               ; SE RETORNA, SE HACE PUSH AL STACK Y SE 
                                      ; REGRESA A ESA DIRECCION (B10)
C10 ENDP                              ; FIN DEL PROCEDIMIENTO C10
;_____________________________________|
END BEGIN                             ; FIN DEL CODIGO
;_____________________________________|