00000000  B84D5A0000        mov eax,0x5a4d
00000005  66390500004000    cmp [dword 0x400000],ax
0000000C  7538              jnz 0x46
0000000E  A13C004000        mov eax,[0x40003c]
00000013  81B8000040005045  cmp dword [eax+0x400000],0x4550
         -0000
0000001D  7527              jnz 0x46
0000001F  B90B010000        mov ecx,0x10b
00000024  66398818004000    cmp [eax+0x400018],cx
0000002B  7519              jnz 0x46
0000002D  83B8740040000E    cmp dword [eax+0x400074],byte +0xe
00000034  7610              jna 0x46
00000036  33C9              xor ecx,ecx
00000038  39B0E8004000      cmp [eax+0x4000e8],esi
0000003E  0F95C1            setnz cl
00000041  894DE4            mov [ebp-0x1c],ecx
00000044  EB03              jmp short 0x49
00000046  8975E4            mov [ebp-0x1c],esi
00000049  33DB              xor ebx,ebx
0000004B  43                inc ebx
0000004C  53                push ebx
0000004D  E883070000        call dword 0x7d5
00000052  59                pop ecx
00000053  85C0              test eax,eax
00000055  7508              jnz 0x5f
00000057  6A1C              push byte +0x1c
00000059  E858FFFFFF        call dword 0xffffffb6
0000005E  59                pop ecx
0000005F  E833190000        call dword 0x1997
00000064  85C0              test eax,eax
00000066  7508              jnz 0x70
00000068  6A10              push byte +0x10
0000006A  E847FFFFFF        call dword 0xffffffb6
0000006F  59                pop ecx
00000070  E844470000        call dword 0x47b9
00000075  895DFC            mov [ebp-0x4],ebx
00000078  E8E8440000        call dword 0x4565
0000007D  85C0              test eax,eax
0000007F  7D08              jnl 0x89
00000081  6A1B              push byte +0x1b
00000083  E8CC1A0000        call dword 0x1b54
00000088  59                pop ecx
00000089  E8BC299A74        call dword 0x749a2a4a
0000008E  A3FC644200        mov [0x4264fc],eax
00000093  E870440000        call dword 0x4508
00000098  A32C454200        mov [0x42452c],eax
0000009D  E8B8430000        call dword 0x445a
000000A2  85C0              test eax,eax
000000A4  7D08              jnl 0xae
000000A6  6A08              push byte +0x8
000000A8  E8A71A0000        call dword 0x1b54
000000AD  59                pop ecx
000000AE  E878410000        call dword 0x422b
