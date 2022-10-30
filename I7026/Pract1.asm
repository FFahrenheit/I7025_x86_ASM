    PAGE 60,132             ; Tamaño de pagina
    TITLE PRACT1.EXE        ; Nombre del programa
    .MODEL SMALL            ; Incorpora SS, DS, CS                       
    .STACK 64               ; Size de la pila
;_______________________________
    .DATA                   ; Segmento de datos
DAT1    DB  05H             ; Variable DAT1 1 byte = 0x05
DAT2    DB  10H             ; Variable DAT1 1 byte = 0x10
DAT3    DB  ?               ; Variable DAT1 1 byte sin inicializar
;_______________________________
    .CODE                   ; Segmento de codigo

PRACT1  PROC    FAR         ; Declarar el procedimiento

        MOV AX, @DATA       ; Obtener la direccion del segmento de datos 
        MOV DS, AX          ; Moverlo al segmento de datos
        MOV AH, DAT1        ; Se carga DAT1 a AH
        ADD AH, DAT2        ; Se suma DAT2 a AH
        MOV DAT3, AH        ; Se carga el valor de la suma a DAT3
        MOV AX,4C00H        ; Se carga el valor para retornar al DOS
        INT 21H             ; Y se llama

PRACT1  ENDP                ; Se cierra el procedimiento
                            ; Y el programa
END     PRACT1

;_______________________________