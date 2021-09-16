    ORG 100h
    JMP begin
    ;Nombre del archivo
    filename DB "C:\emu8086\MyBuild\actividad5.txt",0
    ;Contenido a escribir en el archivo
    contenido DB "La burlona burbuja, burbujea hoy aqui, burbuja burlona que siempre se burla de mi",0 
    ;Variable auxiliar para leer
    aux DB "$"
    ;Contador de caracteres b
    cont DB 0x00
    ;Handler del archivo
    handle DW ?    
    
begin:                                            

    ;Creamos y abrimos el archivo en modo escritura 
    MOV AL, 0x02                ;Abrir en modo escritura
    MOV AH, 0x3C                ;AH = 3C para crear archivo
    MOV DX, offset filename     ;Cargamos el nombre del archivo en DS:DX
    MOV CX, 0X00                ;Al solo crear, CX = 0 
    INT 0x21                    ;Creamos el archivo 
    
    JC error   
    MOV handle, AX              ;Guardamos el handle
    
    
    ;Obtenemos la longitud de cadena
    MOV BX, offset contenido    ;Iteramos sobre la cadena para obtener
    MOV SI, 0x00                ;su longitud con direccionamiento
length:                         ;base + indice
    MOV AL, [BX+SI]
    CMP AL, 0x00                ;Al leer el fin de cadena
     
    JZ write                    ;se pasa a escribir, guardando la longitud en  
    INC SI                      ;SI              
    JMP length
    
    ;Escribimos en el archivo
write:                         
    MOV BX, handle              ;Cargamos el handle en BX
    MOV AH, 0x40                ;para escribir en el archivo
    MOV DX, offset contenido    ;el contendio                     
    MOV CX, SI                  ;con la longitud calculada
        
       
    INT 21H
    JC error    
                                      
    ;Cerramos este archivo, posteriormente lo abriremos de nuevo 
    MOV BX, handle              ;Cargamos en handle en BX
    MOV AH, 0x3E                ;para cerrar el archivo                            
    INT 0x21                    ;y lo cerramos                          
    
    
    ;Abrir archivo para su lectura 
    MOV AL, 0x00                ;Solo lectura
    MOV AH, 0x3D                ;Abrir
    MOV DX, offset filename     ;Nombre del archivo
    
    INT 0x21
    
    JC error                    ;Guardamos en handle si no hay error
    MOV handle, AX                                                          
                                                               
read:                                                              
    MOV BX, handle                                                
    MOV CX, 1                   ;Leeremos caracter por caracter
    MOV DX, offset aux          ;lo cargaremos en aux
    MOV AH, 0x3F                ;Opcion leer
    
    INT 0x21                    ;Ejecutamos la instruccion de lectura
    
    CMP AX, 0x00                ;Observamos si no llegamos al EOF
    JZ ending                                                    
    
    MOV DL, aux[0]              ;Leemos el caracter obtenido del buffer
    CMP DL, "b"                 ;Lo comparamos con "b"
    JNZ read                    ;Si no es 0 (=b) seguimos leyendo
    INC cont                    ;Si lo es, sumamos 1 y seguimos leyendo
    JMP read
    

;Cerramos el archivo y guardamos en AL la cantidad de "b"
ending:     
    MOV BX, handle              ;Cargamos en handle en BX
    MOV AH, 0x3E                ;para cerrar el archivo                            
    INT 0x21                    ;y lo cerramos  
    MOV AL, cont
    
                       
    
error:
    RET    