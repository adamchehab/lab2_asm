format PE console

entry Start

include 'C:\fasmw17327\INCLUDE\win32a.inc'

section '.data' data readable writable
	strA db 'Enter A: ', 0
	strB db 'Enter B: ', 0

	resStr db 'A + B = %d', 0

	spaceStr db ' %d', 0
	
	; input numbers
	a dd ?
	b dd ?

section '.code' code readable executable

    Start:
	; INPUT
		; A
		push strA
		call [printf]

		push a
		push spaceStr
		call [scanf]

		; B
		push strB
		call [printf]

		push b
		push spaceStr
		call [scanf]

	; CALCULATE
		mov eax, [a]
		add eax, [b]

	; OUTPUT RESULT
        push eax
        push resStr
        call [printf]

	; LEAVE PROGRAMM
        ; prevent console from closing
        call [getch]                

        ; leave programm
        push 0
        call [ExitProcess]


; section for libraries
section '.idata' import data readable
	library kernel, 'kernel32.dll',\
			msvcrt, 'msvcrt.dll'
	
	import  kernel,\
			ExitProcess, 'ExitProcess'

	import  msvcrt,\
			printf, 'printf',\
			scanf, 'scanf',\
			getch, '_getch'