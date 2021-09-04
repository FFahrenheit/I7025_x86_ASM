    .model small
    
    .data
    var1    DB  0X0FA
;desplazamiento 0
    array1  DB  1, 3, 5, 7, 9, 11, 13, 15, 17
;desplazamiento 1  2  3  4  5   6   7   8   9
    
    .code
    ;Cargamos en DS la direccion de code
    MOV AX, @data
    MOV DS, AX
    
                           
    ;Inmediato                       
    MOV AL, 0X55    ;Cargamos en AL el dato 0X55H
                    ;es decir, un dato constante
              
    ;De registro             
    MOV CL, AL      ;Cargamos a CL lo que hay en AL
                    ;es decir, de registro a registro
                    
    ;Directo
    MOV [10], CL    ;Cargamos en el desplazamiento 10
                    ;lo que hay en CL (0X55)
                    ;DR = DS * 10 + 10
                    ;DR = 710H * 10H + AH = 0710A
                    ;Tambien funciona MOV CL, [10]
                    ;para la operacion inversa       
    
    ;De registro indirecto
    MOV BX, 0X000B  ;Cargamos en BX = 11d
                    ;Solo podemos usar BX para esto
    MOV AL, 0X77    ;Cargamos en BH 77H                         
    MOV [BX], AL    ;Cargamos en la memoria en la 
                    ;posicion de lo que guarda AH (11d)
                    ;lo que hay en el registro BH (0X77)
                    ;DR = DS * 10H + AH
                    ;DR = 710H * 10H + 0B = 0710B
                    ;Tambien funciona MOV AL, [BX]
                    ;para la operacion inversa 
    
    ;De base mas indice
    MOV BX, 0X000A  ;Cargamos una base en BX = 10
                    ;Solo podemos usar BX para la base
    MOV SI, 2       ;Cargamos un indice = 2
    MOV DL, 0X33    ;Cargamos un dato en DL = 0X33
    MOV [BX+SI], DL ;Cargamos lo que hay en DL (0X33)
                    ;en la memoria dada por CH + SI
                    ;DR = DS * 10H + CH + SI
                    ;DR = 710H * 10H + 10 + 2 = 0710C
                    ;Tambien funciona MOV DL, [BX+SI]
                    ;para la operacion inversa
                    
    
    ;De registro relativo
    MOV BX, 0x000A  ;Cargamos la base con BX = 10
    MOV DL, [BX + 1];Cargamos en DL lo que hay en 
                    ;BX + 1 (desplazamiento 11)
                    ;DR = DS * 10H + 10 + 1
                    ;DR = 710H * 10H + 0B = 0X710B
                    ;Tambien funciona MOV [BX + 1], DL
                    ;para la operacion inversa
   
    ;De base relativa mas indice  
    MOV AL, 0X47    ;Cargamos AL con 0x47
    MOV BX, 0X000A  ;Cargamos la base con BX = 10
    MOV SI, 2       ;Cargamos el indice con 2
    MOV array1[BX + SI], AL
                    ;Cargamos en la posicion BX + SI del 
                    ;arreglo lo que hay en AL
                    ;DR = DS * 10H + array1 + BX + SI
                    ;DR = DS * 10H + 1 + 10 + 2 = 0710D
                    ;Ademas de la operacion inversa, tambien
                    ;se puede usar array[BX+SI+constante]
    
    ;De indice escalado
    MOV DL, 0X66    ;Cargamos DL con 0x66
    MOV BX, 0X000A  ;Cargamos la base con BX = 10
    MOV SI, 2       ;Cargamos nuestro indice con 2
    MOV [BX + 2 * SI], DL
                    ;Cargamos en la posicion BX + 2*SI
                    ;lo que hay en DL, es decir, el segundo
                    ;par con desplazamiento 10 de la memoria
                    ;DR = DS * 10H + BX + K + SI
                    ;DR = 710H * 10H + 10 + 2 * 2 = 0710E
                    ;Se puede usar MOV DL, [BX+2*SI]
                    ;Ademas de agregar una constante al
                    ;desplazamiento : [BX + 2 * SI + n]                    
                     
    RET 
                    