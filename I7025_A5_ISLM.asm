    ORG 100h
    JMP inicio
    ;Nombre del archivo
    filename DB "C:\emu8086\MyBuild\actividad5.txt",0
    ;Contenido a escribir en el archivo
    contenido DB "abcdef",0 
    aux db "$"
    cont db 0
    ;Handler del archivo
    handle DW ?    
    
inicio: 
    MOV AL, 0x02                ;Abrir en modo escritura
    MOV AH, 0x3C                ;AH = 3C para crear archivo
    MOV DX, offset filename     ;Cargamos el nombre del archivo en DS:DX
    MOV CX, 0X00                ;Al solo crear, no hay que escribir nada, longitud = 0
    INT 0x21                    ;Creamos el archivo 
    
    JC error   
    MOV handle, AX              ;Guardamos el handle
    
    
    ;Obtenemos la longitud de cadena
    MOV BX, offset contenido    ;Iteramos sobre la cadena para obtener
    MOV SI, 0x00                ;su longitud con direccionamiento
length:                         ;base + indice
    MOV AL, [BX+SI]
    CMP AL, 0X00                ;Al leer el fin de cadena
     
    JZ write                    ;se pasa a escribir, guardando la longitud en  
    INC SI                      ;SI              
    JMP length
    
write:                         
    MOV BX, handle      ;Cargamos el handle en BX
    MOV AH, 0x40        ;para escribir en el archivo
    MOV DX, offset contenido                        
    MOV CX, SI
    
       
    INT 21H
    JC error    
                                      
cerrar:    
    MOV BX, handle      ;Cargamos en handle en BX
    MOV AH, 0X3E        ;para cerrar el archivo                            
    INT 0X21            ;y lo cerramos
                       
    
error:
    RET    