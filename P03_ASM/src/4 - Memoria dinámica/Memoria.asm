extern malloc
extern free
extern fprintf

section .data

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
	ret

; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
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


