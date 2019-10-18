; Instituto Tecnológico de Costa Rica
; Escuela de Ingeniería Electrónica 
; Arquitectura de Computadoras
; II Semestre 2019
; Proyecto 1: FFT
; Osvaldo Alfaro Gonzáles
; Alejandro Flores Herrera
; Allan Gutiérrez Quesada
; Eduardo Salazar Villalobos

;Código principal del proyecto
; *** Compilar este archivo ***

;Compilar y correr:
;nasm NASM_FFT.asm -f elf64 -o NASM_FFT.o && gcc -no-pie NASM_FFT.o -o NASM_FFT && ./NASM_FFT

;%include "macrosFFT.asm"

numPuntos equ 32 	; <-- Hay que cambiar aqui el numero de puntos de la fft
					; 		y debe ser igual al tama;o del vector de entrada

;*********************************************************************
;Llamadas al sistema (rax):
SYS_EXIT    equ 60

;*********************************************************************
;Librerias C:
extern printf



section .data
	formato1:  	db "%15.4e	",0
	formato2:  	db "%+.4ej",10,0

	;necesario para calcular seno y coseno:
    pi:         dd 3.14159265359
    piMedios:   dd 1.57079632679
    factor3:    dd 0.1666666   ;1/3!
    factor5:    dd 0.0083333   ;1/5!
    factor7:    dd 0.0001984   ;1/7!
    factor9:    dd 0.0000028   ;1/9!
    negativo:   dd -1.0


	X:
         dd 6.706298, 3.539444, 7.999998, 0.114240, 6.581887, 3.094702, 8.487971, 1.541506, 5.987545
         dd 8.384120, 5.145959, 3.917838, 5.342065, 1.994972, 8.301635, 7.174125, 3.105011, 2.461260
         dd 0.274934, 0.137026, 1.216092, 3.060764, 7.020233, 1.839507, 4.979150, 3.789264, 1.633971
         dd 1.102185, 0.129905, 5.280733, 6.327265, 3.783171



;Registros que no se ven afectados por syscalls:
;rbp, rbx, r12, r13, r14, r15

;*********************************************************************
;macro para salir del programa:
%macro exit 0
	mov eax, SYS_EXIT
	mov edi, 0
	syscall
%endmacro

;*********************************************************************
;Multiplicacion punto flotante
;Entrada: los dos datos
;El resultado queda en xmm0

%macro multiply 2

    movss   xmm0, %1
    mulss   xmm0, %2

%endmacro

;*********************************************************************
;Division punto flotante
;Entrada: los dos datos
;El resultado queda en xmm0
;*xmm0 NO puede ser el divisor*

%macro divide 2

    movss   xmm0, %1
    divss   xmm0, %2 

%endmacro

;*********************************************************************
;Suma punto flotante
;Entrada: los dos datos
;El resultado queda en xmm0

%macro suma 2

    movss   xmm0, %1
    addss   xmm0, %2

%endmacro

;*********************************************************************
;Resta punto flotante
;Entrada: minuendo, sustraendo
;El resultado queda en xmm0

%macro resta 2

    movss   xmm0, %1
    subss   xmm0, %2

%endmacro

;*********************************************************************
;Imprimir numero flotante
;Entradas: el numero, formato

;ejemplo:
;section .rodata
;   formato:    db "%f",0
;   numero:     dd 22.5

;printF [numero],[formato]
;printF xmm0, [formato]         <-- cuando el numero esta en un registro como xmm0

%macro printF 2

    push    rbp
    mov     rbp, rsp

    movss   xmm0, %1
    movss   dword [rbp-4H], xmm0
    cvtss2sd xmm0, dword [rbp-4H]

    lea     rdi, %2
    mov     eax, 1
    call    printf
    mov     rsp, rbp
    pop     rbp
 

    ;movss   xmm0, %1
    ;mov     dword [rsp-4H], xmm0
    ;cvtss2sd    xmm0, dword [rsp-4H]
    ;lea     rdi, %2
    ;mov     eax, 1
    ;call    printf

%endmacro



;*********************************************************************
;Toma un numero y devuelve el equivalente en el rango de -Pi a Pi
;para poder aproximarlo con polinomio de Taylor con un solo periodo de la funcion seno
;Entradas: el numero, el valor de pi
;El resultado queda en xmm0

;ejemplo:
;section .data
    ;num:        dd 32.0
    ;pi:         dd 3.1415927

;rango [num],[pi]

%macro rango 2
    movss xmm0, %1
    pxor xmm1, xmm1     ;xor para que xmm1 sea 0
    ucomiss xmm0, xmm1  ;comparacion con 0

    je %%fin             ;si es cero, salta al fin
    jbe %%negativo       ;si es menor, a negativo
    jmp %%positivo       ;si es mayor, a postivo

%%positivo:
    ucomiss xmm0, %2  ;compara con pi:
    jbe %%fin            ;si es menor, salta a _fin

    resta xmm0, %2    ;se le resta 2*pi
    resta xmm0, %2

    xor eax, eax
    cmp eax, 0
    je %%positivo

%%negativo:
    ;se le cambia el signo para que quede positivo
    mulss   xmm0, [negativo]

;se hace lo mismo que cuando es positivo:
%%negativo2:
    ucomiss xmm0, %2  ;compara con pi:
    jbe %%cambioSigno            ;si es menor, salta a cambio de signo

    resta xmm0, %2    ;se le resta 2*pi
    resta xmm0, %2

    xor eax, eax
    cmp eax, 0
    je %%negativo2

%%cambioSigno: ;cambia el signo del resultado, porque -sin(x)=sin(-x)

    mulss   xmm0, [negativo] ;se multiplica por -1

    xor eax, eax ;se salta a fin
    cmp eax, 0
    je %%fin

%%fin:
%endmacro

;*********************************************************************
;Aproximacion de funcion Seno
;Entradas: el numero en radianes
;El resultado queda en xmm0

;ejemplo:
;section .data
    ;num:        dd 32.0

;sen [num]
%macro sen 1
    rango %1, [pi] ;se pone el numero en el rango de -pi a pi
    movss %1, xmm0

    ;la suma se va almacenando en xmm1:

    ;primer termino de la serie:    x
    movss xmm1, %1

    ;segundo termino de la serie:   -x^3/3!
    movss xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, [factor3]
    multiply xmm0, [negativo] ;se multiplica por -1

    suma xmm0,xmm1      ;se suma con el termino anterior, resultado en xmm0
    movss xmm1, xmm0    ;se almacena el resultado en xmm1

    ;tercer termino de la serie:    x^5/5!
    movss xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, [factor5]

    suma xmm0,xmm1      ;se suma con los terminos anteriores, resultado en xmm0
    movss xmm1, xmm0    ;se almacena el resultado en xmm1       

    ;cuarto termino de la serie:    -x^7/7!
    movss xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, [factor7]
    multiply xmm0, [negativo] ;se multiplica por -1

    suma xmm0,xmm1      ;se suma con los terminos anteriores, resultado en xmm0
    movss xmm1, xmm0    ;se almacena el resultado en xmm1 

    ;quinto termino de la serie:    x^9/9!
    movss xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, %1
    multiply xmm0, [factor9]

    suma xmm0,xmm1      ;se suma con los terminos anteriores, resultado en xmm0
%endmacro

;*********************************************************************
;Aproximacion de funcion Coseno
;Entradas: el numero en radianes
;El resultado queda en xmm0

;ejemplo:
;section .data
    ;num:        dd 32.0

;cos [num]
%macro cos 1
    movss xmm0, %1
    suma xmm0, [piMedios] ;se le suma pi medios para calcular coseno a partir de seno
    movss %1, xmm0
    sen %1
%endmacro

;*********************************************************************
;Coeficiente real de la matriz W
;Entradas:
;       *1 Valor de k
;       *2 Valor de n
;       *3 Valor de N (numero de puntos)

;ejemplo:

;coefReal r12, r13, numPuntos (r12 contiene k y r13 contiene n) 
%macro coefRe 3
    mov eax, 2
    cvtsi2ss xmm0, eax      ;se guarda un 2 en xmm0
    multiply xmm0, [pi]     ;se multiplica por pi

    mov eax, %1 ;k
    cvtsi2ss xmm1, eax
    multiply xmm0, xmm1     ; se multiplica por k

    mov eax, %2 ;n
    cvtsi2ss xmm1, eax
    multiply xmm0, xmm1     ; se multiplica por n

    mov eax, %3 ;N
    cvtsi2ss xmm1, eax
    divide xmm0, xmm1       ; se divide entre N

    mov eax, 16
    cvtsi2ss xmm1, eax
    divide xmm0, xmm1   ; se divide entre 16, porque los contadores de k y n tienen un factor de 4

    movss xmm10, xmm0       ; es mejor no usar xmm0 para calcular el coseno,
    cos xmm10               ; porque xmm0 se modifica dentro del macro
%endmacro

;*********************************************************************
;Coeficiente imaginario de la matriz W
;Entradas:
;       *1 Valor de k
;       *2 Valor de n
;       *3 Valor de N (numero de puntos)

;ejemplo:

;coefIm r12, r13, numPuntos (r12 contiene k y r13 contiene n) 
%macro coefIm 3
    mov eax, 2
    cvtsi2ss xmm0, eax      ;se guarda un 2 en xmm0
    multiply xmm0, [pi]     ;se multiplica por pi
    multiply xmm0, [negativo];se multiplica por -1

    mov eax, %1 ;k
    cvtsi2ss xmm1, eax
    multiply xmm0, xmm1     ; se multiplica por k

    mov eax, %2 ;n
    cvtsi2ss xmm1, eax
    multiply xmm0, xmm1     ; se multiplica por n

    mov eax, %3 ;N
    cvtsi2ss xmm1, eax
    divide xmm0, xmm1       ; se divide entre N

    mov eax, 16
    cvtsi2ss xmm1, eax
    divide xmm0, xmm1  ; se divide entre 16, porque los contadores de k y n tienen un factor de 4


    movss xmm10, xmm0       ; es mejor no usar xmm0 para calcular el seno,
    sen xmm10               ; porque xmm0 se modifica dentro del macro
%endmacro

;*********************************************************************
;FFT con calculo de coeficientes
;Entradas:
;   Direcciones de:
;       *1 vector columna de entrada
;       *2 dimension del vector (cantidad de puntos)

;ejemplo:

;FFT entrada, 6
%macro FFT 2
    mov eax, %2 ;tama;o de las matrices

    mov ebx, 4 ;hay 4 bytes en un dd
    mul ebx
    mov ebx, eax ;se mueve a rbx porque rbx no se ve afectado por llamadas

    mov r12d, 0 ;Contador para  k
    mov r13d, 0 ;Contador para  n
    mov r14d, 0 ;Contador para cantidad de X(k) calculados

    pxor xmm4, xmm4 ; se usa xmm4 para almacenar la suma real
    pxor xmm5, xmm5 ; se usa xmm5 para almacenar la suma imaginaria

%%ciclo1:
    ;multiplicacion parte real
    coefRe r12d, r13d, %2 ;se calcula cos(2*pi*k*n/N), se guarda en xmm0
    multiply xmm0,[%1+r13d]    ;se multiplica por el elemento del vector entrada, resultado se guarda en xmm0
    suma xmm0, xmm4   ;suma el resultado de la multip. con lo que hay en xmm4
    movss xmm4, xmm0 ;guarda eso de nuevo en xmm4
    
    ;multiplicacion parte imaginaria
    coefIm r12d, r13d, %2 ;se calcula -sen(2*pi*k*n/N), se guarda en xmm0
    multiply xmm0,[%1+r13d]    ;resultado se guarda en xmm0
    suma xmm0, xmm5   ;suma el resultado de la multip. con lo que hay en xmm5
    movss xmm5, xmm0 ;guarda eso de nuevo en xmm5

    add r13d, 4 ;se aumenta n

    cmp r13d, ebx ;cuando rbx sea igual a r13 es porque termino una fila
    jne %%ciclo1

    printF xmm4, [formato1] ;se imprime parte real e imaginaria
    printF xmm5, [formato2]

    pxor xmm4, xmm4 ; se reinicia la suma
    pxor xmm5, xmm5 ; se reinicia la suma

    add r12d, 4 ;se aumenta k
    mov r13d, 0 ;se reinicia n

    cmp r12d, ebx ;se verifica si ya se calcularon todos los X(k)
    jne %%ciclo1
%endmacro


section .text
	global main

main:

	FFT X, numPuntos

	exit



; *************************************************************************************************************************
