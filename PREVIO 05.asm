INICIO: LD SP,27FFH  ;Inicializa la dirección de la pila
SIGUE: LD A,80H      ;Palabra de control del PPI
       OUT (03H),A   ;Configura el puerto de control

       LD E,08H
       LD A,01H      ;Enciende el bit 0 del acumulador
       LD HL,2000H   ;Inicializa la localidad de la variable
       LD (HL),A     ;Guarda el ultimo valor del registro
CICLO: LD A,(HL)     ;Recupera el valor desde la SRAM
       OUT (00H),A   ;Saca el valor por el puerto
       CALL RETARDO1 ;Consume RETARDO1
       LD A,00H      ;Apaga todos los leds del puerto
       OUT (00H),A
       CALL RETARDO2 ;Consume RETARDO2
       RLC (HL)      ;Rota el registro a la izquierda
       DEC E
       JP NZ,CICLO

       LD E,08H
       LD A,080H     ;Enciende el bit 8 del acumulador
       LD HL,2000H   ;Inicializa la localidad de la variable
       LD (HL),A     ;Guarda el ultimo valor del registro
CICLO2:LD A,(HL)     ;Recupera el valor desde la SRAM
       OUT (00H),A   ;Saca el valor por el puerto
       CALL RETARDO1 ;Consume RETARDO1
       LD A,00H      ;Apaga todos los leds del puerto
       OUT (00H),A
       CALL RETARDO2 ;Consume RETARDO2
       RRC (HL)      ;Rota el registro a la derecha
       DEC E
       JP NZ,CICLO2
       JP SIGUE
RETARDO1: LD B,05H   ;Realiza el consumo de tiempo a traves
TIEMPOA:  LD D,020H  ;de un decremento anidado de 2 registros
TIEMPOB:  DEC D      ;B=05 Y D=20
          JP NZ,TIEMPOB
          DEC B
          JP NZ,TIEMPOA
          RET

RETARDO2: LD C,04H       ;Se repite 5 veces (05H) la subrutina
SEG2:     CALL RETARDO1  ;RETARDO1
          DEC C
          JP NZ,SEG2
          RET

          END



