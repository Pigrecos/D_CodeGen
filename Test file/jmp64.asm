;Testname=test; Arguments=-fbin -ojmp64.bin; Files=stdout stderr jmp64.bin

	bits 32
	jmp 0x401000
	jmp [0x401000]
	
	call far [cs:$401000]
	bits 64
	jmp rcx
	jmp [rax]
	jmp qword [rax]
	jmp near [rax]
	jmp near qword [rax]
	jmp far [rax]
	jmp far dword [rax]
	jmp far qword [rax]
	call rcx
	call [rax]
	call qword [rax]
	call near [rax]
	call near qword [rax]
	call far [rax]
	call far dword [rax]
	call far qword [rax]
	
	
