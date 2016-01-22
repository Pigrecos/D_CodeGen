00000000  48895C2408        mov [rsp+0x8],rbx
00000005  4889742418        mov [rsp+0x18],rsi
0000000A  4889542410        mov [rsp+0x10],rdx
0000000F  57                push rdi
00000010  4883EC20          sub rsp,byte +0x20
00000014  488BDA            mov rbx,rdx
00000017  8BF1              mov esi,ecx
00000019  33FF              xor edi,edi
0000001B  33C0              xor eax,eax
0000001D  4885D2            test rdx,rdx
00000020  0F95C0            setnz al
00000023  85C0              test eax,eax
00000025  7518              jnz 0x3f
00000027  E880940000        call qword 0x94ac
0000002C  C70016000000      mov dword [rax],0x16
00000032  E851640000        call qword 0x6488
00000037  83C8FF            or eax,byte -0x1
0000003A  E9C7000000        jmp qword 0x106
0000003F  488BCA            mov rcx,rdx
00000042  E831090000        call qword 0x978
00000047  90                nop
00000048  F6431840          test byte [rbx+0x18],0x40
0000004C  0F8586000000      jnz qword 0xd8
00000052  488BCB            mov rcx,rbx
00000055  E836FC0000        call qword 0xfc90
0000005A  83F8FF            cmp eax,byte -0x1
0000005D  742A              jz 0x89
0000005F  83F8FE            cmp eax,byte -0x2
00000062  7425              jz 0x89
00000064  4863D0            movsxd rdx,eax
00000067  488BCA            mov rcx,rdx
0000006A  48C1F905          sar rcx,byte 0x5
0000006E  4C8D05430B4100    lea r8,[rel 0x410bb8]
00000075  83E21F            and edx,byte +0x1f
00000078  486BD258          imul rdx,rdx,byte +0x58
0000007C  490314C8          add rdx,[r8+rcx*8]
00000080  488D0D71CB3D00    lea rcx,[rel 0x3dcbf8]
00000087  EB11              jmp short 0x9a
00000089  488D0D68CB3D00    lea rcx,[rel 0x3dcbf8]
00000090  488BD1            mov rdx,rcx
00000093  4C8D051E0B4100    lea r8,[rel 0x410bb8]
0000009A  F642387F          test byte [rdx+0x38],0x7f
0000009E  7525              jnz 0xc5
000000A0  83F8FF            cmp eax,byte -0x1
000000A3  741A              jz 0xbf
000000A5  83F8FE            cmp eax,byte -0x2
000000A8  7415              jz 0xbf
000000AA  4863C8            movsxd rcx,eax
000000AD  488BC1            mov rax,rcx
000000B0  48C1F805          sar rax,byte 0x5
000000B4  83E11F            and ecx,byte +0x1f
000000B7  486BC958          imul rcx,rcx,byte +0x58
000000BB  49030CC0          add rcx,[r8+rax*8]
000000BF  F6413880          test byte [rcx+0x38],0x80
000000C3  7413              jz 0xd8
000000C5  E8E2930000        call qword 0x94ac
