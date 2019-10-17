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