00000000  8B00              mov eax,[eax]
00000002  E8BC71FFFF        call dword 0xffff71c3
00000007  8B0D88A24B00      mov ecx,[dword 0x4ba288]
0000000D  A16CA14B00        mov eax,[0x4ba16c]
00000012  8B00              mov eax,[eax]
00000014  8B15AC0F4B00      mov edx,[dword 0x4b0fac]
0000001A  E8BC71FFFF        call dword 0xffff71db
0000001F  A16CA14B00        mov eax,[0x4ba16c]
00000024  8B00              mov eax,[eax]
00000026  66                o16
00000027  0FC8              bswap eax
00000029  0FC8              bswap eax
0000002B  E81BE9F4FF        call dword 0xfff4e94b
