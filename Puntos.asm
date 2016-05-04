section .bss
	matriz				resb 1440				; reservar 1440 bytes para la creación de la matriz			
	lenMatriz			equ $-matriz 			; tamaño del espacio reservado para la matriz

	basura				resb 20					; reservar 20 bytes en buffer			
	lenBasura			equ $-matriz 			; tamaño del espacio reservado para basura

	jugadores			resb 1 					; reservar espacio para guardar la seleccion de la cantidad de usuarios que participan
	lenJugadores		equ $-jugadores 		; tamaño del espacio para la seleccion de la cantidad de usuarios que participan
	
	nombre1				resb 64 				; espacio reservado para introducir el nombre del jugador 1
	lenNombre1			equ $-nombre1			; tamaño del nombre del jugador 1

	nombre2				resb 64 				; espacio reservado para introducir el nombre del jugador 2
	lenNombre2			equ $-nombre2			; tamaño del nombre del jugador 2

	nombre3				resb 64 				; espacio reservado para introducir el nombre del jugador 3
	lenNombre3			equ $-nombre3 			; tamaño del nombre del jugador 3

	nombre4				resb 64 				; espacio reservado para introducir el nombre del jugador 4
	lenNombre4			equ $-nombre4			; tamaño del nombre del jugador 4

	eleccion_tamano		resb 1 					; se reserva un byte para la eleccion del tamaño del tablero del usuario
	lenEleccionTamano	equ $-eleccion_tamano 	; tamaño del eleccion_tamano

	ancho 				resb 1

	;i				resb 2
	;lenI 			equ i

	;j				resb 2
	;lenJ 			equ j

	;i2				resb 2
	;lenI2 			equ i2

	;j2 				resb 2
	;lenJ2 			equ j2

	;n           resb 2
	;lenN		equ $-n



section .data
						; menu que se le muestra al usuario para la seleccion de jugadores a participar
	menu_jugadores:		db "Seleccione la cantidad de jugadores: ", 10, "D. 2 Jugador", 10, "T. 3 Jugadores", 10, "C. 4 Jugadores", 10, "S. Salir", 10
	lenMJugadores:		equ $-menu_jugadores
						
						; menu que se le muestra al usuario para la seleccion del tamaño de los tableros para dos jugadores
	dos_jugadores:		db "Seleccione el tamaño del tablero:", 10, "P. Pequeño 5x5", 10 ,"M. Mediano: 10x10", 10, "G. Grande:  15x15", 10, "S. Salir", 10
	lenDJ:				equ $-dos_jugadores

						; menu que se le muestra al usuario para la seleccion del tamaño de los tableros para tres jugadores
	tres_jugadores: 	db "Seleccione el tamaño del tablero:", 10, "M. Mediano: 10x10", 10, "G. Grande:  15x15", 10, "S. Salir", 10
	lenTJ:				equ $-tres_jugadores

						; guardar en memoria los espacios para despues, en la etiqueta de cada tablero unirlos y crear una matriz de puntos
	puntos:				dd ".   "
	lenPuntos: 			equ $-puntos

						; punto final de cada una de las lineas de la matriz
	punto: 				db ".", 10
	lenPunto:			equ $-punto

						; mensaje en el que se le solicita al usuario que ingrese la primera coordenada de X
	msjX:				db "Ingrese la Posicion X de su primer punto",10
	lenMX:				equ $-msjX

						; mensaje en el que se le solicita al usuario que ingrese la primera coordenada de Y
	msjJ:				db "Ingrese la Posicion J de su primer punto",10
	lenMJ:				equ $-msjJ

						; mensaje en el que se le solicita al usuario que ingrese la segunda coordenada de X
	msjX2:				db "Ingrese la Posicion X de su segundo punto",10
	lenMX2:				equ $-msjX2

						; mensaje en el que se le solicita al usuario que ingrese la segunda coordenada de Y
	msjJ2:				db "Ingrese la Posicion J de su segundo punto",10
	lenMJ2:				equ $-msjJ2

						; mensaje para separar lineas
	msjseparador:		db "###########################################################",10, "###########################################################",10
	lenMseparador:		equ $-msjseparador

	n:					equ 16

	i:					dd 2 
	lenI: 				equ i

	j:					dd 2
	lenJ: 				equ j

	i2:					dd 2
	lenI2: 				equ i2

	j2: 				dd 2
	lenJ2: 				equ j2



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

imprimir_menu_jugadores: 				; Etiqueta que imprime el menu para seleccionar cuantos jugadores participarán
	mov ecx, menu_jugadores 			; Puntero a la posicion de memoria con el mensaje de las opciones
	mov edx, lenMJugadores 				; Guardar el espacio para la impresion del mensaje
	mov eax, 4 							; Llamada al servicio 4 (write) en eax
	mov ebx, 1							; Salida Standard 
	int 80h								; interrupcion

cantidad_jugadores: 					; Etiqueta "input", permite al ususario ingresar un valor
	mov ecx, jugadores 					; Puntero al espacio de memoria en el que se guarda la elección del usuario
	mov edx, lenJugadores				; Tamaño del espacio de la selección del usuario.
	mov eax, 3							; Llamada al servicio 3 (read) en eax
	mov ebx, 0							; Entrada Standard
	int 80h								; interrupcion

verificar_jugadores: 					; Etiqueta en la que se valida la selección de la cantidad de jugadores
	mov eax, dword[jugadores] 			; Se copia en eax, la elección del usuario

	cmp eax, "D" 						; "D" para dos jugadores
	je opcion_dos_jugadores 			; Si la elección del usuario es igual a D, se brinca a la etiqueta opcion_dos_jugadores

	cmp eax, "T" 						; "T" para dos jugadores
	je opcion_tres_jugadores 			; Si la elección del usuario es igual a T, se brinca a la etiqueta opcion_tres_jugadores

	cmp eax, "C" 						; "C" para dos jugadores
	je tablero2 						; Si la elección del usuario es igual a C, se imprimie directamente el tablero para cuatro jugadores

	cmp eax, "S" 						; "S" para dos jugadores
	je salir 							; Si la elección del usuario es igual a S, se termina el juego

	jmp imprimir_menu_jugadores 		; Si ninguna de las opciones anteriores es seleccionada o no la elección no es válida
										; Se solicita de nuevo al usuario que eliga la cantidad de usuarios que participarán

opcion_dos_jugadores: 					; Etiqueta que imprime las opciones de tamaño de tableros para dos jugadores
	mov ecx, dos_jugadores 				; Puntero a la direccion de memoria en la que se encuentra el mensaje para los jugadores
	mov edx, lenDJ 						; Tamaño del mensaje para la seleccion del tamaño del tablero para dos jugadores
	mov eax, 4 							; Llamada al servicio 4 (write) en eax
	mov ebx, 1							; Salida Standard 
	int 80h								; interrupcion
	jmp eleccion_tablero 				; Brinca a la etiqueta en la que el usuario ingrese su elección

opcion_tres_jugadores: 					; Etiqueta que imprime las opciones de tamaño de tableros para tres jugadores
	mov ecx, tres_jugadores 			; Puntero a la direccion de memoria en la que se encuentra el mensaje para los jugadores
	mov edx, lenTJ 						; Tamaño del mensaje para la seleccion del tamaño del tablero para dos jugadores
	mov eax, 4 							; Llamada al servicio 4 (write) en eax
	mov ebx, 1							; Salida Standard
	int 80h								; interrupcion
	jmp eleccion_tablero 				; Brinca a la etiqueta en la que el usuario ingrese su elección

eleccion_tablero: 						; Etiqueta en la que se le permite al usuario ingresar un valor para su elección
	mov ecx, basura 					
	mov edx, lenBasura
	mov eax, 3
	mov ebx, 0
	int 80h
	; Debido a fallas en nasm debimos crear la variable basura y engañar al sistema haciendo la solicitud de datos de manera doble
	; Y así obligar al sistema a permitir al usuario ingresar su elección

	mov ecx, eleccion_tamano 			; Puntero a la direccion de memoria en la que se almacenara la elección del usuario
	mov edx, lenEleccionTamano 			; Tamaño de la elección del usuario
	mov eax, 3							; Llamada al servicio 3 (read) en eax
	mov ebx, 0							; Entrada Standard
	int 80h								; Interrupción
	jmp comparacion 					; Brinca a la etiqueta de comparacion de la selección del usuario

comparacion: 							; Etiqueta de comparación de la selección del usuario 
	mov ecx, dword[eleccion_tamano] 	; Copiar el valor de la selección del usuario en el registro ecx 

	cmp ecx, "P" 						; "P" para el tablero o matriz pequeña
	je tablero 							; Si el usuario selecciona P se imprime el tablero o matriz pequeña

	cmp ecx, "M" 						; "M" para el tablero o matriz mediana
	je tablero1							; Si el usuario selecciona M se imprime el tablero o matriz mediana 

	cmp ecx, "G" 						; "G" para el tablero o matriz grande
	je tablero2 						; Si el usuario selecciona G se imprime el tablero o matriz grande

	jmp imprimir_menu_jugadores 		; Si ninguna de las anteriores es seleccionada o el valor elegido no es valido 
										; Se solicita nuevamente la cantidad de jugadores y el tablero a preferir		


tablero: 								; Etiqueta en la que se crea el tablero de tamaño Pequeño
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
	;jmp poner_rayas
	;jmp imprimir_puntos

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
	;jmp poner_rayas
	;jmp imprimir_puntos	


;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
imprimir_coordenadas:
	call imprimir_men_x
	call imprimir_men_j
	call imprimir_men_x
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
	mov ecx, j
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
	;mov ecx, 1
	;ciclo_juego:
		;inc ecx
		;push ecx
		
		;poner lo de pedir coordenadas
		;call imprimir_coordenadas
		mov dword[i],0
		mov dword[j],1
		mov dword[i2],0
		mov dword[j2],2
		call poner_rayas
		call imprimir_puntos
		mov dword[i],0
		mov dword[j],2
		mov dword[i2],1
		mov dword[j2],2
		call poner_rayas
		call imprimir_separador
		call imprimir_puntos
		mov dword[i],1
		mov dword[j],1
		mov dword[i2],1
		mov dword[j2],2
		call poner_rayas
		call imprimir_separador
		call imprimir_puntos
		mov dword[i],0
		mov dword[j],1
		mov dword[i2],1
		mov dword[j2],1
		call poner_rayas
		call imprimir_separador
		call imprimir_puntos
	

		jmp salir
		;pop ecx
	;loop ciclo_juego
		
poner_rayas:
	;call imprimir_puntos
	mov ebx, [i2]
	mov edx, [i]
	;sub ebx, '0'
	;sub edx, '0'
	cmp ebx, edx
	je raya_horizontal
	raya_vertical:
		mov edx, [j2]
		mov ebx, [i2]
		;sub ebx, '0'
		;sub edx, '0'

		imul ebx,[ancho]
		imul edx, 4
		add ebx, edx
		;sub ebx, edx
		mov byte[matriz+ebx], "|"
		call verificar_cuadrado_ver
	ret
	raya_horizontal:
		mov ebx, [i]
		mov edx, [j]
		;sub ebx, '0'
		;sub edx, '0'
		imul ebx,[ancho]
		imul edx, 4
		add ebx, edx
		;sub ebx, edx
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
	;sub edx, '0'
	mov ecx,[ancho]
	;sub ecx,'0'
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


