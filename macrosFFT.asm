; Instituto Tecnológico de Costa Rica
; Escuela de Ingeniería Electrónica 
; Arquitectura de Computadoras
; II Semestre 2019
; Proyecto 1: FFT
; Osvaldo Alfaro Gonzáles
; Alejandro Flores Herrera
; Allan Gutiérrez Quesada
; Eduardo Salazar Villalobos

;Macros del proyecto

;Registros que no se ven afectados por syscalls:
;rbp, rbx, r12, r13, r14, r15

;*********************************************************************
;Llamadas al sistema (rax):
SYS_EXIT    equ 60

;*********************************************************************
;Librerias C:
extern printf

;*********************************************************************
;Datos importantes:

section .data
;necesario para calcular seno y coseno:
    pi:         dd 3.14159265359
    piMedios:   dd 1.57079632679
    factor3:    dd 0.1666666   ;1/3!
    factor5:    dd 0.0083333   ;1/5!
    factor7:    dd 0.0001984   ;1/7!
    factor9:    dd 0.0000028   ;1/9!
    negativo:   dd -1.0

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
    movss   dword [rbp-4], xmm0
    cvtss2sd xmm0, dword [rbp-4]

    lea     edi, %2
    mov     eax, 1
    call    printf
    mov     rsp, rbp
    pop     rbp
 
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
    mulss xmm0, [negativo]

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

    mulss xmm0, [negativo] ;se multiplica por -1

    xor eax, eax ;se salta a fin
    cmp eax, 0
    je %%fin

%%fin:
%endmacro