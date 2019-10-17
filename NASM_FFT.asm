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
;nasm FFTfinal.asm -f elf64 -o FFTfinal.o && gcc -no-pie FFTfinal.o -o FFTfinal && ./FFTfinal

%include "macrosFFT.asm"

numPuntos equ 32 	; <-- Hay que cambiar aqui el numero de puntos de la fft
					; 		y debe ser igual al tama;o del vector de entrada

section .data
	formato1:  	db "%15.4f	",0
	formato2:  	db "%+.4fj",10,0

		

	X:
         dd 6.706298, 3.539444, 7.999998, 0.114240, 6.581887, 3.094702, 8.487971, 1.541506, 5.987545
         dd 8.384120, 5.145959, 3.917838, 5.342065, 1.994972, 8.301635, 7.174125, 3.105011, 2.461260
         dd 0.274934, 0.137026, 1.216092, 3.060764, 7.020233, 1.839507, 4.979150, 3.789264, 1.633971
         dd 1.102185, 0.129905, 5.280733, 6.327265, 3.783171

section .text
	global main

main:

	FFT X, numPuntos

	exit
