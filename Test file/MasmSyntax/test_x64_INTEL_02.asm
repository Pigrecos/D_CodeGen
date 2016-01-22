[Bits 64]
lea r8, qword ptr [0x108550] ; 13FB18550:"70c2441db366d92ea7be1342b3bf629026ba92bb675f06e684bdd34511097434"
not rcx
lea rdx, qword ptr [rcx-0x01]
lea rcx, qword ptr [0x13B160]
call 0x3AB74
cmp eax, r13d ; eax:BaseThreadInitThunk
je 0x34BB5
mov rcx, r13
lea rsi, qword ptr [0x13B060]
mov al, byte ptr [rcx+rsi]
inc rcx
mov byte ptr [rsp+rcx+0x0000055F], al
cmp al, r13b
jnz 0x34ABD
or rsi, 0xFFFFFFFFFFFFFFFF
xor eax, eax ; eax:BaseThreadInitThunk
lea rdi, qword ptr [rsp+0x00000560]
mov rcx, rsi
repne scasb 
xor ecx, ecx
mov al, byte ptr [r14+rcx]
inc rcx
mov byte ptr [rdi+rcx-0x02], al
test al, al
jnz 0x34AE4
mov rdx, r13
mov al, byte ptr [rsp+rdx+0x00000560]
inc rdx
mov byte ptr [rsp+rdx+0x0000095F], al
cmp al, r13b
jnz 0x34AF6
xor eax, eax ; eax:BaseThreadInitThunk
lea rdi, qword ptr [rsp+0x00000560]
mov rcx, rsi
repne scasb 
lea r9, qword ptr [0x13B460]
lea r8, qword ptr [0x108550] ; 13FB18550:"70c2441db366d92ea7be1342b3bf629026ba92bb675f06e684bdd34511097434"
not rcx
lea rdi, qword ptr [rcx-0x01]
lea rdx, qword ptr [rcx-0x01]
lea rcx, qword ptr [rsp+0x00000560]
call 0x3AB74
cmp eax, r13d ; eax:BaseThreadInitThunk
je 0x34BB5
mov rcx, r13
mov al, byte ptr [rsp+rcx+0x00000960]
inc rcx
mov byte ptr [rsp+rcx+0x0000055F], al
cmp al, r13b
jnz 0x34B49
lea r9, qword ptr [rsp+0x60]
lea r8, qword ptr [0x13B360]
lea rcx, qword ptr [rsp+0x00000560]
mov rdx, rdi
call 0x3A9E4
mov rdx, r13
mov al, byte ptr [rsp+rdx+0x00000960]
inc rdx
mov byte ptr [rsp+rdx+0x0000055F], al
cmp al, r13b
jnz 0x34B7E
lea r9, qword ptr [rsp+0x60]
lea rcx, qword ptr [rsp+0x00000560]
mov r8, r14
mov rdx, rdi
call 0x3AB74
cmp eax, r13d ; eax:BaseThreadInitThunk
je 0x34BB5
mov al, 0x01
jmp 0x34BB7
xor al, al
mov rcx, qword ptr [rsp+0x00000D60]
xor rcx, rsp
call 0x0E65B0
mov rbx, qword ptr [rsp+0x00000DC0]
add rsp, 0x0000000000000D70
pop r15
pop r14
pop r13
pop r12
pop rdi
pop rsi
pop rbp
ret 
