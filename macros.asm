;Registros que no se ven afectados por syscalls:
;rbp, rbx, r12, r13, r14, r15

;*********************************************************************
;Llamadas al sistema (rax):
SYS_READ    equ 0
SYS_WRITE   equ 1
SYS_EXIT    equ 60

;*********************************************************************
;Valores para llamadas al sistema:
STDIN   equ 0
STDOUT  equ 1
STDERR  equ 2

;*********************************************************************
;macro para salir del programa:
%macro exit 0
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
%endmacro

;*********************************************************************
;macro para imprimir un string (debe terminar en 0)
;input: string o registro que contenga la direccion del string
%macro printStr 1
	mov rax, %1
	push rax
	mov rbx, 0
%%printLoop:
	inc rax
	inc rbx
	mov cl, [rax]
	cmp cl, 0
	jne %%printLoop

	mov rax, SYS_WRITE
	mov rdi, STDOUT
	pop rsi ; en el stack esta el texto
	mov rdx, rbx ;rbx contiene el tama;o del string
	syscall
%endmacro

;*********************************************************************
;macro para imprimir un numero entero
;input: numero o registro con el numero
;se debe reservar lo siguiente:
;section .bss
    ;digitSpace resb 100
    ;digitSpacePos resb 8
%macro printInt 1
	mov rax, %1
    mov rcx, digitSpace
    ;mov rbx, 10
    ;mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx
 
%%printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48
 
    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx
   
    pop rax
    cmp rax, 0
    jne %%printRAXLoop
 
%%printRAXLoop2:
    mov rcx, [digitSpacePos]
 
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, rcx
    mov rdx, 1
    syscall
 
    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx
 
    cmp rcx, digitSpace
    jge %%printRAXLoop2
 %endmacro

;*********************************************************************
