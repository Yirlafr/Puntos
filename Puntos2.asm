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


	ancho 				resb 1

	



section .data
	menu_jugadores:		db "Cuantos personas desean jugar?.", 10
	lenMJugadore:	equ $-menu_jugadores

	menu_tablero: 		db "Seleccione el tamaño del tablero:", 10, "1. Pequeño: 5x5", 10, "2. Mediano: 10x10", 10, "3. Grande:  15x15", 10, "4. Salir", 10
	lenMT:				equ $-menu_tablero

	puntos:				dd ".   "
	lenPuntos: 			equ $-puntos

	punto: 				db ".", 10
	lenPunto:			equ $-punto

	msjX:				db "Ingrese la Posicion X de su primer punto",10
	lenMX:				equ $-msjX

	msjJ:				db "Ingrese la Posicion J de su primer punto",10
	lenMJ:				equ $-msjJ

	msjX2:				db "Ingrese la Posicion X de su segundo punto",10
	lenMX2:				equ $-msjX2

	msjJ2:				db "Ingrese la Posicion J de su segundo punto",10
	lenMJ2:				equ $-msjJ2

	msjseparador:				db "###########################################################",10, "###########################################################",10
	lenMseparador:				equ $-msjseparador

	n:					equ 16

	eleccion_tamano:	dd 1
	lenEleccionTamano:	equ $-eleccion_tamano

	i:				dd 1
	lenI: 			equ i

	j:				dd 1
	lenJ: 			equ j

	i2:				dd 1
	lenI2: 			equ i2

	j2: 			dd 1
	lenJ2: 			equ j2

	pos:			dd 1

	numero1:			dd 1
	numero2:			dd 1

	;i:				equ 0
	;j:				equ 0

	;i2:				equ	1
	;j2:				equ 0

	;ancho:				equ 58

	guardar_tamano: 	equ 1

	linea_H:	db " ___", 10
	linea_V:	db "|" , 10



section .text
	global _start

_start:
	nop

imprimir_menu_jugadores:
	mov ecx, menu_jugadores
	mov edx, lenMJugadore
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
	mov ah, [eleccion_tamano]
	sub ah, 30h
	cmp ah, 1
	je tablero
	cmp ecx, "2"
	je tablero1
	cmp ecx, "3"
	je tablero2
	; call imprimir_error
	cmp ecx, "4"
	je salir
	jmp eleccion_tablero 			

cambiar_tamano1:
	mov dword[guardar_tamano], 2
	jmp tablero1

cambiar_tamano2:
	mov dword[guardar_tamano], 3

tablero:
	;call imprimir
	mov byte[ancho], 18
	mov edx, 0
	mov ecx, 5
	ciclo:
		push ecx
		mov ebx, 0
		mov ecx, 4
		mov eax, dword[puntos]
		ciclo1:
			mov dword[matriz + edx + (ebx * 4)], eax
			inc ebx
		loop ciclo1
		mov eax, dword[punto]
		mov dword[matriz + n + edx], eax
		add edx, [ancho]
		pop ecx
	loop ciclo
	mov dword[matriz+90],0 
	jmp juego

tablero1:
	mov edx, 0
	mov ecx, 10
	mov byte[ancho], 38
	cicloa:
		push ecx
		mov ebx, 0
		mov ecx, 9
		mov eax, dword[puntos]
		ciclob:
			mov dword[matriz + edx + (ebx * 4)], eax
			inc ebx
		loop ciclob
		mov eax, dword[punto]
		mov dword[matriz + 36 + edx], eax
		add edx, 38
		pop ecx
	loop cicloa
	mov dword[matriz+380],0 
	jmp juego
	;jmp poner_rayas
	;jmp imprimir_puntos

tablero2:
	mov edx, 0
	mov ecx, 15
	mov byte[ancho], 58
	cicloa1:
		push ecx
		mov ebx, 0
		mov ecx, 14
		mov eax, dword[puntos]
		ciclob1:
			mov dword[matriz + edx + (ebx * 4)], eax
			inc ebx
		loop ciclob1
		mov eax, dword[punto]
		mov dword[matriz + 56 + edx], eax
		add edx, 58
		pop ecx
	loop cicloa1
	mov dword[matriz+870],0 
	jmp juego
	

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
imprimir_coordenadas:
	call imprimir_men_x
	call imprimir_men_j
	call imprimir_men_x2
	call imprimir_men_j2
	ret

imprimir_men_x:
	mov eax, 4
	mov ebx, 1
	mov ecx, msjX
	mov edx, lenMX
	int 80h
	
	mov eax, 3
 	mov ebx, 0
	mov ecx, i
	mov edx, lenJ
 	int 80h
 	ret 

imprimir_men_j:
	mov eax, 4
	mov ebx, 1
	mov ecx, msjJ
	mov edx, lenMJ
	int 80h

	mov eax, 3
 	mov ebx, 0
	mov ecx, j
	mov edx, lenJ
	int 80h
 	ret
 imprimir_men_x2:
	mov eax, 4
	mov ebx, 1
	mov ecx, msjX2
	mov edx, lenMX2
	int 80h

	mov eax, 3
 	mov ebx, 0
	mov ecx, i2
	mov edx, lenI2
	int 80h
 	ret

imprimir_men_j2:
	mov eax, 4
	mov ebx, 1
	mov ecx, msjJ2
	mov edx, lenMJ2
	int 80h

	mov eax, 3
 	mov ebx, 0
	mov ecx, j2
	mov edx, lenI2
 	int 80h
 	ret


juego:
	mov ecx, 1
	ciclo_juego:
		inc ecx
		push ecx
		call imprimir_puntos
		call imprimir_coordenadas
		call poner_rayas
		pop ecx
	loop ciclo_juego
		
poner_rayas:
	mov al, [i2]
	mov ah, [i]
	sub al, 30h
	sub ah, 30h
	cmp ah, al
	je raya_horizontal
	raya_vertical:
		mov al, [j2]
		mov ah, [i2]
		sub al, 30h
		sub ah, 30h
		mov byte[numero2], al
		mov byte[numero1], ah
		mov ebx, [numero1]
		mov edx, [numero2]
		imul ebx,[ancho]
		imul edx, 4
		add  ebx, edx
		mov byte[matriz+ebx], "|"
		call verificar_cuadrado_ver
	ret
	raya_horizontal:
		mov al, [j]
		mov ah, [i]
		sub al, 30h
		sub ah, 30h
		mov byte[numero2], al
		mov byte[numero1], ah
		mov ebx, [numero1]
		mov edx, [numero2]

		imul ebx,[ancho]
		imul edx, 4
		add ebx, edx
		cmp byte[matriz+ebx], "."
		je raya_punto
		 	mov dword[matriz+ebx], "|___"
		 	call verificar_cuadrado_hor
		 	ret
		raya_punto:
			mov dword[matriz+ebx], ".___"
			call verificar_cuadrado_hor
	ret

verificar_cuadrado_hor:
	mov edx, [i]
	mov ecx,[ancho]
	cmp edx, 0
	je parte_abajo
	cmp dword[matriz + ebx], "|___"
	jne parte_abajo
	cmp byte[matriz + ebx + 4], "|"
	jne parte_abajo
	mov ecx, ebx
	sub ecx, [ancho]
	cmp dword[matriz + (ecx)],"|___"
	jne con_punto2
	mov dword[matriz + ebx],"|_L_"
	jmp parte_abajo
	con_punto2:
		cmp dword[matriz + (ecx)],".___"
		jne parte_abajo
		mov dword[matriz + ebx],"|_L_"
parte_abajo:
		mov edx, [i]
		;sub edx, '0'
		imul edx, 4
		add edx, 2
		cmp edx, [ancho]    
		jne si_esposible2
		ret
		si_esposible2:
			cmp dword[matriz + (ebx + ecx)],"|___"
			je iguales
			ret
			iguales:
				cmp byte[matriz + (ebx + ecx + 4)],"|"
				jne finalH
				mov dword[matriz + (ebx + ecx)],"|_L_"
				finalH:
					ret


verificar_cuadrado_ver:
	mov edx, [j]         ;cuadrado que se podria formar a la izquierda de la raya puesta
	;sub edx, '0'		 ;siempre y cuandon no la este poniendo en la primer columna sino 
	mov ecx,[ancho]
	;sub ecx,'0'
	cmp edx, 0			 ;pasa al parte del cuadrado derecho
	je parte_derecha
	cmp dword[matriz + (ebx-4)],"|___"    	; si tiene las rayas de abajo e izquierda del posible cuadrado
	jne parte_derecha
	mov ecx, ebx
	sub ecx, [ancho]
	cmp dword[matriz + (ecx - 4)], "|___"  ;si tiene la raya de arriba que puede ser con un punto o raya
	jne con_punto
	mov dword[matriz + (ebx-4)],"|_L_"   ;mov byte[matriz+(ebx-2)], byte[nombreactual]
	jmp parte_derecha
	;aqui va lo 
	con_punto:
		mov ecx, ebx
		sub ecx, [ancho]											;esta es la parte por si tiene un punto enves de raya
		cmp dword[matriz + (ecx - 4)], ".___"    
		jne parte_derecha
		mov dword[matriz + (ebx-4)],"|_L_"
	
	parte_derecha:
		mov edx, [j]

		;sub edx, '0'
		imul edx, 4
		add edx, 2
		cmp edx, [ancho]    
		jne si_esposible
		ret
		si_esposible:
			cmp dword[matriz + ebx], "|___"
			je bueno
			ret
			bueno:
				cmp byte[matriz + ebx + 4], "|"
				je bueno2
				ret
				bueno2:
					mov ecx, ebx
					sub ecx, [ancho]
					cmp byte[matriz + (ecx)], ".___"
					jne con_raya
					mov dword[matriz + ebx],"|_L_"
					ret
					con_raya:
						cmp byte[matriz + (ecx)], "|___"
						jne final 
						mov dword[matriz + ebx],"|_L_"
						final:
							ret


imprimir_puntos:
	mov ecx, matriz
	mov edx, lenMatriz	
	mov eax, 4
	mov ebx, 1
	int 80h 
	ret

imprimir_separador:
	mov ecx, msjseparador
	mov edx, lenMseparador	
	mov eax, 4
	mov ebx, 1
	int 80h 
	ret
salir:
	mov ebx, 0
	mov eax, 1
	int 80h


