extern malloc

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio



section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - es_indice_ordenado
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - indice_a_inventario
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;; La funcion debe verificar si una vista del inventario está correctamente 
;; ordenada de acuerdo a un criterio (comparador)

;; bool es_indice_ordenado(item_t** inventario, uint16_t* indice, uint16_t tamanio, comparador_t comparador);

;; Dónde:
;; - `inventario`: Un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice`: El arreglo de índices en el inventario que representa la vista.
;; - `tamanio`: El tamaño del inventario (y de la vista).
;; - `comparador`: La función de comparación que a utilizar para verificar el
;;   orden.
;; 
;; Tenga en consideración:
;; - `tamanio` es un valor de 16 bits. La parte alta del registro en dónde viene
;;   como parámetro podría tener basura.
;; - `comparador` es una dirección de memoria a la que se debe saltar (vía `jmp` o
;;   `call`) para comenzar la ejecución de la subrutina en cuestión.
;; - Los tamaños de los arrays `inventario` e `indice` son ambos `tamanio`.
;; - `false` es el valor `0` y `true` es todo valor distinto de `0`.
;; - Importa que los ítems estén ordenados según el comparador. No hay necesidad
;;   de verificar que el orden sea estable.

global es_indice_ordenado
es_indice_ordenado:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = item_t**     inventario	(rdi) 8 bytes, puntero
	; r/m64 = uint16_t*    indice		(rsi) 8 bytes, puntero
	; r/m16 = uint16_t     tamanio		(rdx) 2 bytes, uint de 16 bits
	; r/m64 = comparador_t comparador	(rcx) 8 bytes, puntero

	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15

	xor r8, r8
	mov r8w, dx			; Para asegurarme que no tenga basura

	mov r10, rdi		; resguardo inventarios e indice en otros registros
	mov r11, rsi		; ya que al llamar comparador debo tener el rdi y rsi con los valores que quiero comparar
	
	dec r8

loop1A:

	xor r12, r12			; limpiamos los registros
	xor r13, r13

	mov word r12w, [r11]		; le metemos el indice
	mov word r13w, [r11 + 2]

	; shl r12, 3					; multiplicamos por 8, para indexar en el array
	; shl r13, 3					; de punteos

	; add r12, r10				; le sumamos la base de donde está
	; add r13, r10

	mov rdi, [r10 + r12 * 8]
	mov rsi, [r10 + r13 * 8]

	push rcx					; pusheo todos los registro que 
	push r10					; la llamada de rcx me puede alterar
	push r11
	push r8
	
	call rcx

	pop r8
	pop r11
	pop r10
	pop rcx					; restauro todos los registros que pushee

	cmp rax, 0
	jz returnF

	add r11, 2

	dec r8
	cmp r8, 0
	jne loop1A

	mov rax, 1
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret

returnF:

	xor rax, rax

	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret

;; Dado un inventario y una vista, crear un nuevo inventario que mantenga el
;; orden descrito por la misma.

;; La memoria a solicitar para el nuevo inventario debe poder ser liberada
;; utilizando `free(ptr)`.

;; item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio);

;; Donde:
;; - `inventario` un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice` es el arreglo de índices en el inventario que representa la vista
;;   que vamos a usar para reorganizar el inventario.
;; - `tamanio` es el tamaño del inventario.
;; 
;; Tenga en consideración:
;; - Tanto los elementos de `inventario` como los del resultado son punteros a
;;   `ítems`. Se pide *copiar* estos punteros, **no se deben crear ni clonar
;;   ítems**

global indice_a_inventario
indice_a_inventario:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = item_t**  inventario		RDI
	; r/m64 = uint16_t* indice			RSI
	; r/m16 = uint16_t  tamanio			RDX

	push rbp
	mov rbp, rsp

	; primero debo calcular el tanaño que le voy a pedir
	; a malloc, que es 8 bytes por el tamanio en rdx

	push rdi
	push rsi
	push rdx

	shl rdx, 3
	mov rdi, rdx

	call malloc

	; en rax tengo el puntero al array

	pop rdx
	pop rsi
	pop rdi

	xor rcx, rcx	; este será mi I

loop1b:

	cmp rdx, 0
	jz fin

	xor r9, r9

	mov word r9w, [rsi + rcx * 2]		; recordar que si voy a mover word, debería limpiar todo el registro con un xor antes.
	mov r8, [rdi + r9 * 8]
	mov [rax + rcx * 8], r8

	dec rdx
	inc rcx
	jmp loop1b

fin:

	pop rbp
	ret
