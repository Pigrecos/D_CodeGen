;Testname=unoptimized; Arguments=-O0 -fbin -obr1879590.bin; Files=stdout stderr br1879590.bin
;Testname=optimized;   Arguments=-Ox -fbin -obr1879590.bin; Files=stdout stderr br1879590.bin

	bits 32
	mov eax,[fs:0]
	mov Eax, $313233 
	mov eax,[ebx+8,ecx*4]
	repnz scasb
    mov eax,[eax+ecx*4+8]
	
	pavgb mm0,[ebx]
	pavgb mm0,qword [ebx]
	pavgw mm0,[ebx]
	pavgw mm0,qword [ebx]
	pavgb xmm0,[ebx]
	pavgb xmm0,oword [ebx]
	pavgw xmm0,[ebx]
	pavgw xmm0,oword [ebx]
	
	mov cl, [eax - 1]
	mov cl, [eax + 0xffffffff]
	mov cl, [eax + 0x1ffffffff]
	mov cl, [byte eax + 0xffffffff]
	mov cl, [byte eax + 0x1ffffffff]
	mov cl, [byte eax + 0x1000ffff]
	mov ecx,[Ecx+eax*4+0x400]
	
	




