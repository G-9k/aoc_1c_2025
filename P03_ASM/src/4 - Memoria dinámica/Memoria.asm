extern malloc
extern free
extern fprintf

section .data
	string_fprintf db "%s", 0

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; punteros por [rdi] [rsi]
strCmp:
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15		; pila alineada devuelta
	push rbx
	sub rsp, 8		; pila alineada

	xor rbx, rbx	; mi minLen

	; resguardo las strings porque el call a strLen me las va a pisar.
	mov r12, rdi		; strings a
	mov r13, rsi		; strings b

	xor r14, r14		; lenA
	xor r15, r15		; lenB

	; en rdi sigo teniendo al string A, lo mando para obtener su longitud

	call strLen
	mov r14, rax	; resguardo lenA

	mov rdi, r13	; cargo el string B para calcularle su len

	call strLen
	mov r15, rax	; resguardo 
	
	xor rdi, rdi	; mi i para el for
	xor r8, r8		; donde guardo el caracter a
	xor r9, r9		; donde guardo el caracter b

	cmp r14, r15
	jg .bMenor		; acá se que b es la de menor longitud

	mov rbx, r14
	jmp .aMenor		; acá se que a es de la menor longitud

.bMenor:
	mov rbx, r15

.aMenor:
	cmp rbx, 0
	jz .finalIfs

	.for:
		cmp rdi, rbx			; aca comparo si i<minLen
		jge .finalIfs

		mov r8b, [r12 + rdi]
		mov r9b, [r13 + rdi]
		cmp r8b, r9b
		jl .return1
		jg .return_1
		inc rdi
		jmp .for

	
.finalIfs:

	cmp r14, r15
	je .return0
	jg .return_1
	jl .return1


.return0:
	xor rax, rax
	jmp .end

.return1:
	xor rax, rax
	inc rax
	jmp .end

.return_1:
	xor rax, rax
	dec rax
	jmp .end

.end:

	add rsp, 8
	pop rbx
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret


; char* strClone(char* a)
strClone:
	push rbp
	mov rbp, rsp
	
	push r12
	push r13
	push r14
	push r15	; alineada, no volatiles resguardados

	mov r12, rdi ; resguardo el puntero al string
	
	call strLen
	mov r13, rax	; resguardo la longitud para que malloc no la pise
	mov rdi, rax	; obtengo la longitud del string
	inc rdi			; le agrego 1 para malloc

	call malloc		; en rax tengo el puntero que debo devolver

	xor r10, r10	; lo uso como contador
	cmp r13, 0
	jz .end

	.for:
		mov r14b, [r12 + r10]	; obtengo el caracter
		mov byte [rax + r10], r14b	; lo meto en la res
		inc r10
		cmp r10, r13	; i < lenA
		jl .for


.end:
	mov byte [rax + r13], 0

	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret

; void strDelete(char* a)
strDelete:
	push rbp
	mov rbp, rsp

	call free

	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	push rbp
	mov rbp, rsp

	; uso el fprintf, el cual espera el pfile como primer argumento.

	push rdi
	mov rdi, rsi		; cambio de lugar los argumentos
	pop rsi

	cmp byte [rsi], 0
	jz .null

	call fprintf

	pop rbp
	ret

.null:

	mov rsi, 0
	call fprintf
	
	pop rbp
	ret

; uint32_t strLen(char* a)
; puntero (8 bytes) [rdi]
strLen:
	push rbp
	mov rbp, rsp

	xor rax, rax	; contador
	xor rdx, rdx 	; donde pondré al caracter para comparar

	mov dl, [rdi]
	cmp dl, 0
	jz .end

	.while:
		inc rax
		mov dl, [rdi+rax]
		cmp dl, 0
		jnz .while

.end:
	pop rbp
	ret


