section .bss
	matriz				resb 1440				
	lenMatriz			equ $-matriz

	jugadores			resb 32
	lenJugadores		equ $-jugadores
	
	nombre1				resb 64
	lenNombre1			equ $-nombre1

	nombre2				resb 64
	lenNombre2			equ $-nombre2

	nombre3				resb 64
	lenNombre3			equ $-nombre3

	nombre4				resb 64
	lenNombre4			equ $-nombre4

	eleccion_tamano		resb 1
	lenEleccionTamano	equ $-eleccion_tamano

	;n           resb 2
	;lenN		equ $-n



section .data
	menu_jugadores:		db "Cuantos personas desean jugar?.", 10
	lenMJ:	equ $-menu_jugadores

	menu_tablero: 		db "Seleccione el tamaño del tablero:", 10, "1. Pequeño: 5x5", 10, "2. Mediano: 10x10", 10, "3. Grande:  15x15", 10, "4. Salir", 10
	lenMT:				equ $-menu_tablero

	puntos:				dd ".   "
	lenPuntos: 			equ $-puntos

	punto: 				db ".", 10
	lenPunto:			equ $-punto

	n:					equ 16

	guardar_tamano: 	equ 1

	;linea_H:	db " __", 10
	;linea_V:	db "|" , 10



section .text
	global _start

_start:
	nop

imprimir_menu_jugadores:
	mov ecx, menu_jugadores
	mov edx, lenMJ
	mov eax, 4
	mov ebx, 1
	int 80h

imprimir_opciones:
	mov ecx, menu_tablero
	mov edx, lenMT
	mov eax, 4
	mov ebx, 1
	int 80h

eleccion_tablero:
	mov ecx, eleccion_tamano
	mov edx, lenEleccionTamano
 	mov eax, 3
 	mov ebx, 0
 	int 80h

comaparcion_eleccion:
	mov ecx, dword[eleccion_tamano]
	cmp ecx, "1"
	je tablero
	cmp ecx, "2"
	je cambiar_tamano1
	cmp ecx, "3"
	je cambiar_tamano2
	; call imprimir_error
	cmp ecx, "4"
	je salir
	jmp eleccion_tablero 			; arreglar despues porque no hace nada

cambiar_tamano1:
	mov dword[guardar_tamano], 2
	jmp tablero

cambiar_tamano2:
	mov dword[guardar_tamano], 3

tablero:
	mov edx, 0
	mov ecx, 5
	ciclo:
		imul ecx, guardar_tamano
		push ecx
		mov ebx, 0
		mov ecx, 4
		imul ecx, guardar_tamano
		mov eax, dword[puntos]
		ciclo1:
			mov dword[matriz + edx + (ebx * 4)], eax
			inc ebx
		loop ciclo1
		mov eax, dword[punto]
		mov dword[matriz + n + edx], eax
		add edx, 18
		imul edx, guardar_tamano
		pop ecx
	loop ciclo

imprimir_puntos:
	mov ecx, matriz
	mov edx, lenMatriz	
	mov eax, 4
	mov ebx, 1
	int 80h 

salir:
	mov ebx, 0
	mov eax, 1
	int 80h


