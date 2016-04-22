section .bss
	matriz		resb 90				
	lenMatriz	equ $-matriz			
	;n           resb 2
	;lenN		equ $-n


section .data
	puntos:		dd ".   "
	punto: 		db ".", 10
	;n:			equ 0

	;linea_H:	db "___", 10
	;linea_V:	db "|" , 10

	lenPuntos: equ $-puntos



section .text
	global _start

_start:
	nop


tablero:
	mov ebx, 0
	mov ecx, 4
	mov eax, dword[puntos]
	ciclo:
		mov dword[matriz + ebx * 4], eax
		inc ebx
	loop ciclo
	mov eax, dword[punto]
	mov dword[matriz + 16], eax

	mov ebx, 0
	mov ecx, 4
	mov eax, dword[puntos]
	ciclo1:
		mov dword[matriz + 18 +ebx * 4], eax
		inc ebx
	loop ciclo1
	mov eax, dword[punto]
	mov dword[matriz + 34], eax

	mov ebx, 0
	mov ecx, 4
	mov eax, dword[puntos]
	ciclo2:
		mov dword[matriz + 36 + ebx * 4], eax
		inc ebx
	loop ciclo2
	mov eax, dword[punto]
	mov dword[matriz + 52], eax

	mov ebx, 0
	mov ecx, 4
	mov eax, dword[puntos]
	ciclo3:
		mov dword[matriz + 54+ ebx * 4], eax
		inc ebx
	loop ciclo3
	mov eax, dword[punto]
	mov dword[matriz + 70], eax

	mov ebx, 0
	mov ecx, 4
	mov eax, dword[puntos]
	ciclo4:
		mov dword[matriz + 72 + ebx * 4], eax
		inc ebx
	loop ciclo4
	mov eax, dword[punto]
	mov dword[matriz + 88], eax
	;mov eax, dword[puntos]
	;mov dword[matriz +18], eax

imprimir:
	mov ecx, matriz
	mov edx, lenMatriz	
	mov eax, 4
	mov ebx, 1
	int 80h 



salir:
	mov ebx, 0
	mov eax, 1
	int 80h


