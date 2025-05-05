extern malloc
extern free

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

FILAS EQU 255
COLUMNAS EQU 255

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - optimizar
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - contarCombustibleAsignado
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1C como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - modificarUnidad
global EJERCICIO_1C_HECHO
EJERCICIO_1C_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ATTACKUNIT_CLASE EQU 0
ATTACKUNIT_COMBUSTIBLE EQU 12
ATTACKUNIT_REFERENCES EQU 14
ATTACKUNIT_SIZE EQU 16

global optimizar
optimizar:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = mapa_t           mapa		[rdi] puntero, 8 bytes
	; r/m64 = attackunit_t*    compartida	[rsi] puntero, 8 bytes
	; r/m64 = uint32_t*        fun_hash(attackunit_t*)	[rdx] puntero a función, 8 bytes

	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8

	mov r12, rdi	; resguardo el mapa
	mov r13, rsi	; resguardo la attack unit compartida
	mov r14, rdx	; resguardo la función

	mov rdi, rsi	; pongo la unidad como primer argumento para la función de hash

	call r14	; llamo a la función de hash

	mov r15d, eax	; resguardo el hash del compartido
	mov rbx, FILAS * COLUMNAS	; acá guardo el limite que me hace dejar de recorrer la matriz
	xor r10, r10	; mi contador
	dec r10			; empiezo en -1 porque incremento antes de agarrar un elemento

	.forLoop:
		cmp r10, rbx
		je .end

		inc r10
		mov rdi, [r12 + 8 * r10]	; acá guardo la unidad 
		
		; recordar que de acá para abajo, cuando vuelvo a usar r10
		; r10 no puede haber cambiado, si cambia como lo tenía antes
		; que mi inc r10 estaba despues del mov rdi, entonces el lugar
		; en el que agarro y la que despues coloco en la mapa serán distintos
		; inc r10 JAMAS (me tomo mucho tiempo darme cuenta :'D)

		cmp rdi, 0
		jz .forLoop

		cmp rdi, r13
		je .forLoop

		push r10	; pusheo el r10 porque es volatil, esto es antes de llamar a hash
		push rdi	; y rdi, que es donde está la actual

		call r14

		pop rdi
		pop r10		; consigo devuelta el contador

		cmp eax, r15d	;comparo los hashes de las unidades
		jne .forLoop	; si no son iguales, vuelvo al loop

		inc byte [r13+ATTACKUNIT_REFERENCES]
		dec byte [rdi+ATTACKUNIT_REFERENCES]

		mov [r12 + 8 * r10], r13	; hago que el mapa apunte a la compartida

		xor rax, rax   ; limpio el hash actual

		cmp byte [rdi+ATTACKUNIT_REFERENCES], 0
		jne .forLoop

		push r10
		sub rsp, 8

		call free

		add rsp, 8
		pop r10

		jmp .forLoop

	
	.end:

	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

global contarCombustibleAsignado
contarCombustibleAsignado:
	; r/m64 = mapa_t           mapa	[rdi]
	; r/m64 = uint16_t*        fun_combustible(char*)	[rsi]
	; son ambos punteros, 8 bytes

	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8

	xor r15, r15	; acá planeo guardar el resultado
	xor rbx, rbx	; contador

	mov r12, rdi	; preservo el mapa
	mov r13, rsi	; preservo la función

	.forLoop:
		cmp rbx, COLUMNAS * FILAS
		je .end

		mov rdi, [r12 + rbx * 8]
		inc rbx	; incremento despues porque sé que luego no debo acceder al
		; mapa usando el contador

		cmp rdi, 0
		jz .forLoop

		mov r14, rdi	; preservo la unidad
		mov rdi, r14+ATTACKUNIT_CLASE	; acá cargo el puntero al char (8 bytes)

		call r13

		add word r15w, [r14+ATTACKUNIT_COMBUSTIBLE]
		sub r15w, ax	; porque son 16 bits la respuesta

		jmp .forLoop

	.end:

	xor rax, rax
	mov eax, r15d

	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

global modificarUnidad
modificarUnidad:
	; r/m64 = mapa_t           mapa		[rdi]	puntero
	; r/m8  = uint8_t          x		[sil]	1 byte
	; r/m8  = uint8_t          y		[dl]	1 byte
	; r/m64 = void*            fun_modificar(attackunit_t*)		[rcx] puntero
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8

	mov r12, rdi	; resguardo mapa
	xor r13, r13
	xor r14, r14
	mov rbx, rcx	; resguardo función

	movzx r13, sil	; resguardo x y lo extiendo
	movzx r14, dl	; resguardo y y lo extiendo
	imul r13, FILAS	; uso imul porque es mas facil vivir en paz
	add r13, r14	; lo que tengo en r13 es la coordenada exacta en el mapa
	; r14 ahora lo puedo usar para otro proposito.
	shl r13, 3		; lo shifteo 3 posiciones a izquierda, efectivamente multiplicando por 8

	mov r14, [r12 + r13]	; guardo la unidadAmodificar en r14

	cmp r14, 0
	jz .end

	cmp byte [r14 + ATTACKUNIT_REFERENCES], 1
	jle .modificacion

	; si tiene mas de una referencia, debo llamar a malloc con el tamaño en memoria
	; de la attackunit

	mov rdi, ATTACKUNIT_SIZE
	call malloc

	mov r15, [r14]	; desreferencio la unidad y lo guardo en 
	mov [rax], r15	; la posición en rax

	mov r15, [r14 + 8]	; el struct tiene 16 bytes, arriba movi los primeros 8
	mov [rax + 8], r15	; aca abajo muevo el resto

	mov rdi, rax	; cargo la nueva unidad en rdi
	push rax
	sub rsp, 8

	call rbx		; funcion que no devuelve nada, no está en rax.

	; modifico lo que tengo en el puntero, no el puntero, ese sigue siendo el mismo
	add rsp, 8
	pop rax		; tengo devuelta el puntero en el rax

	mov byte [rax+ATTACKUNIT_REFERENCES], 1	; seteo la referencia de la nueva unidad a 1
	dec byte [r14+ATTACKUNIT_REFERENCES]

	mov [r12 + r13], rax
	jmp .end

	.modificacion
	mov rdi, r14
	call rbx

	.end:

	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

; Clave como imprimir los contenidos de un struct si tengo un 
; puntero en un registro desde gdb
; print *(attackunit_t*) $r14
