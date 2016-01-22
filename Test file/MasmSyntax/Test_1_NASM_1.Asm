mov edi,edi
push ebp
mov ebp,esp
sub esp,0x328
mov [0x424640],eax
mov [dword 0x42463c],ecx
mov [dword 0x424638],edx
mov [dword 0x424634],ebx
mov [dword 0x424630],esi
mov [dword 0x42462c],edi
o16 mov [dword 0x424658],ss
o16 mov [dword 0x42464c],cs
o16 mov [dword 0x424628],ds
o16 mov [dword 0x424624],es
o16 mov [dword 0x424620],fs
o16 mov [dword 0x42461c],gs
pushfd
pop dword [dword 0x424650]
mov eax,[ebp+0x0]
mov [0x424644],eax
mov eax,[ebp+0x4]
mov [0x424648],eax
lea eax,[ebp+0x8]
mov [0x424654],eax
mov eax,[ebp-0x320]
mov dword [dword 0x424590],0x10001
mov eax,[0x424648]
mov [0x424544],eax
mov dword [dword 0x424538],0xc0000409
mov dword [dword 0x42453c],0x1
mov eax,[0x423330]
mov [ebp-0x328],eax
mov eax,[0x423334]
mov [ebp-0x324],eax
call dword [dword 0x41d1f0]
mov [0x424588],eax
push byte +0x1
call dword 0x124a
pop ecx
push byte +0x0
call dword [dword 0x41d1ec]
push dword 0x41e9c0
call dword [dword 0x41d1e8]
cmp dword [dword 0x424588],byte +0x0
jnz 0xf2
push byte +0x1
call dword 0x124a
pop ecx
push dword 0xc0000409
call dword [dword 0x41d09c]
push eax
call dword [dword 0x41d1e4]
leave
ret
push ebp
mov ebp,esp
sub esp,byte +0x4
mov [ebp-0x4],edi
mov edi,[ebp+0x8]
mov ecx,[ebp+0xc]
shr ecx,byte 0x7
pxor xmm0,xmm0
jmp short 0x126
lea esp,[esp+0x0]
nop
movdqa [edi],xmm0
movdqa [edi+0x10],xmm0
movdqa [edi+0x20],xmm0
movdqa [edi+0x30],xmm0
movdqa [edi+0x40],xmm0
movdqa [edi+0x50],xmm0
movdqa [edi+0x60],xmm0
movdqa [edi+0x70],xmm0
lea edi,[edi+0x80]
dec ecx
jnz 0x126
mov edi,[ebp-0x4]
mov esp,ebp
pop ebp
ret
