; Mohamed Mahmoud

.model small
.stack 100h
.data
	sPromptNum1 db "nothing: $"
	SPromptNum2 db "Please input triangle size: $"
	sPromptChar1 db "Please input triangle symbol: $"
	;sPromptChar2 db "Char 2: $"

	sNewline db 10, 13, "$"

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Print Symbol Function ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printSymbol:
	num1 equ word ptr ss:[bp+4]
	num2 equ word ptr ss:[bp+6]
	char1 equ word ptr ss:[bp+8]
	;char2 equ word ptr ss:[bp+10]
	push bp
	mov bp, sp

	push ax
	push dx

	sub sp, 4
	i equ word ptr ss:[bp-4]
	j equ word ptr ss:[bp-6]

	mov i, 1

printManylines:
	mov ax, i
	cmp ax, num2
	jg printManylinesEnd

	mov j, 0

printline:
	mov ax, j
	mov cx, i
	cmp ax, cx
	jge printlineEnd

	mov ah, 2
	mov dx, char1
	int 21h

	;mov ah, 2
	;mov dx, char2
	;int 21h

	inc j
	jmp printline

printlineEnd:
	call printNewline
	inc i
	jmp printManylines

printManylinesEnd:
	pop dx
	pop ax

	mov sp, bp
	pop bp

	ret 8

printNewline:
	push bp
	mov bp, sp

	push ax
	push dx

	mov dx, offset sNewline
	mov ah, 9
	int 21h

	pop dx
	pop ax

	mov sp, bp
	pop bp

	ret

promptAndInput:
	prompt equ WORD PTR ss:[bp+4]

	push bp
	mov bp, sp

	push dx

	mov dx, prompt
	mov ah, 9
	int 21h

	mov ah, 1
	int 21h

	call printNewline

	pop dx

	mov sp, bp
	pop bp

	ret 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Start of Program ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:
	mov ax, @data
	mov ds, ax

	;push offset sPromptNum1
	;call promptAndInput

	sub al, '0'
	xor ah, ah
	push ax

	push offset sPromptNum2
	call promptAndInput

	sub al, '0'
	xor ah, ah
	push ax

	push offset sPromptChar1
	call promptAndInput

	xor ah, ah
	push ax

	;push offset sPromptChar2
	;call promptAndInput

	pop bx
	pop cx
	pop dx

	push ax
	push bx
	push cx
	push dx
	call printSymbol

	mov ax, 4c00h
	int 21h
end start
