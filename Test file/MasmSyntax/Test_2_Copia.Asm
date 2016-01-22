mov eax,0x5a4d
cmp [dword 0x400000],ax
jnz 0x46
mov eax,[0x40003c]
cmp dword [eax+0x400000],0x4550

jnz 0x46
mov ecx,0x10b
cmp [eax+0x400018],cx
jnz 0x46
cmp dword [eax+0x400074],byte +0xe
jna 0x46
xor ecx,ecx
cmp [eax+0x4000e8],esi
setnz cl
mov [ebp-0x1c],ecx
jmp short 0x49
mov [ebp-0x1c],esi
xor ebx,ebx
inc ebx
push ebx
call dword 0x7d5
pop ecx
test eax,eax
jnz 0x5f
push byte +0x1c
call dword 0xffffffb6
pop ecx
call dword 0x1997
test eax,eax
jnz 0x70
push byte +0x10
call dword 0xffffffb6
pop ecx
call dword 0x47b9
mov [ebp-0x4],ebx
call dword 0x4565
test eax,eax
jnl 0x89
push byte +0x1b
call dword 0x1b54
pop ecx
call dword 0x749a2a4a
mov [0x4264fc],eax
call dword 0x4508
mov [0x42452c],eax
call dword 0x445a
test eax,eax
jnl 0xae
push byte +0x8
call dword 0x1b54
pop ecx
call dword 0x422b
lock cmpxchg [ebx+ebp],ecx
