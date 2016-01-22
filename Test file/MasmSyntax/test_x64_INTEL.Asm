Bits 64

mov qword ptr [rsp+0x8],rbx           ; 000000013FD0DD88
mov qword ptr [rsp+0x18],rsi
mov qword ptr [rsp+0x10],rdx
push rdi
sub rsp,0x20
mov rbx,rdx
mov esi,ecx
xor edi,edi
xor eax,eax
test rdx,rdx
setne al
test eax,eax
jnz 0x13FD0DDC7
call 0x13FD17234
mov dword ptr [rax],0x16
call 0x13FD14210
or eax,0xFFFFFFFF
jmp 0x13FD0DE8E
mov rcx,rdx
call 0x13FD0E700
nop
test byte ptr [rbx+0x18],0x40
jnz 0x13FD0DE60
mov rcx,rbx
call 0x13FD1DA18
cmp eax,0xFFFFFFFF
je 0x13FD0DE11
cmp eax,0xFFFFFFFE
je 0x13FD0DE11
movsxd rdx,eax
mov rcx,rdx
sar rcx,0x5
lea r8,qword ptr [0x14011E940]
and edx,0x1F
imul rdx,rdx,0x58
add rdx,qword ptr [r8+rcx*0x8]
lea rcx,qword ptr [0x1400EA980]
jmp 0x13FD0DE22
lea rcx,qword ptr [0x1400EA980]
mov rdx,rcx
lea r8,qword ptr [0x14011E940]
test byte ptr [rdx+0x38],0x7F
jnz 0x13FD0DE4D
cmp eax,0xFFFFFFFF
je 0x13FD0DE47
cmp eax,0xFFFFFFFE
je 0x13FD0DE47
movsxd rcx,eax
mov rax,rcx
sar rax,0x5
and ecx,0x1F
imul rcx,rcx,0x58
add rcx,qword ptr [r8+rax*0x8]
test byte ptr [rcx+0x38],0x80
je 0x13FD0DE60
call 0x13FD17234