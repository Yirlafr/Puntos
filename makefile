NAME= Puntos
CC= nasm

$(NAME): $(NAME).o
	ld -m elf_i386 -o $(NAME) $(NAME).o

		# ld ~ GNU Linker
		# -m ~ emulador
		# elf_i386 ~ arquitectura (32 bits)
		# -o ~ nombrar salida

$(NAME).o: $(NAME).asm
	$(CC) -f elf -g -F stabs $(NAME).asm -l $(NAME).lst

		# nasm ~ compilador
		# -f ~ formato del archivo de salida
		# elf ~ arquitectura (64)
		# -g ~ símbolos para debugger
		# -F ~ formato de los símbolos
		# -l ~ crea un archivo .lst

.PHONY clean:
	rm $(NAME)
	rm $(NAME).lst
	rm $(NAME).o

