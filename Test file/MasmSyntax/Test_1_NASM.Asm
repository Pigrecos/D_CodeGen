00000000  8BFF                    mov edi,edi
00000002  55                      push ebp
00000003  8BEC                    mov ebp,esp
00000005  81EC28030000            sub esp,0x328
0000000B  A340464200              mov [0x424640],eax
00000010  890D3C464200            mov [dword 0x42463c],ecx
00000016  891538464200            mov [dword 0x424638],edx
0000001C  891D34464200            mov [dword 0x424634],ebx
00000022  893530464200            mov [dword 0x424630],esi
00000028  893D2C464200            mov [dword 0x42462c],edi
0000002E  668C1558464200          o16 mov [dword 0x424658],ss
00000035  668C0D4C464200          o16 mov [dword 0x42464c],cs
0000003C  668C1D28464200          o16 mov [dword 0x424628],ds
00000043  668C0524464200          o16 mov [dword 0x424624],es
0000004A  668C2520464200          o16 mov [dword 0x424620],fs
00000051  668C2D1C464200          o16 mov [dword 0x42461c],gs
00000058  9C                      pushfd
00000059  8F0550464200            pop dword [dword 0x424650]
0000005F  8B4500                  mov eax,[ebp+0x0]
00000062  A344464200              mov [0x424644],eax
00000067  8B4504                  mov eax,[ebp+0x4]
0000006A  A348464200              mov [0x424648],eax
0000006F  8D4508                  lea eax,[ebp+0x8]
00000072  A354464200              mov [0x424654],eax
00000077  8B85E0FCFFFF            mov eax,[ebp-0x320]
0000007D  C7059045420001000100    mov dword [dword 0x424590],0x10001
00000087  A148464200              mov eax,[0x424648]
0000008C  A344454200              mov [0x424544],eax
00000091  C70538454200090400C0    mov dword [dword 0x424538],0xc0000409
0000009B  C7053C45420001000000    mov dword [dword 0x42453c],0x1
000000A5  A130334200              mov eax,[0x423330]
000000AA  8985D8FCFFFF            mov [ebp-0x328],eax
000000B0  A134334200              mov eax,[0x423334]
000000B5  8985DCFCFFFF            mov [ebp-0x324],eax
000000BB  FF15F0D14100            call dword [dword 0x41d1f0]
000000C1  A388454200              mov [0x424588],eax
000000C6  6A01                    push byte +0x1
000000C8  E87D110000              call dword 0x124a
000000CD  59                      pop ecx
000000CE  6A00                    push byte +0x0
000000D0  FF15ECD14100            call dword [dword 0x41d1ec]
000000D6  68C0E94100              push dword 0x41e9c0
000000DB  FF15E8D14100            call dword [dword 0x41d1e8]
000000E1  833D8845420000          cmp dword [dword 0x424588],byte +0x0
000000E8  7508                    jnz 0xf2
000000EA  6A01                    push byte +0x1
000000EC  E859110000              call dword 0x124a
000000F1  59                      pop ecx
000000F2  68090400C0              push dword 0xc0000409
000000F7  FF159CD04100            call dword [dword 0x41d09c]
000000FD  50                      push eax
000000FE  FF15E4D14100            call dword [dword 0x41d1e4]
00000104  C9                      leave
00000105  C3                      ret
00000106  55                      push ebp
00000107  8BEC                    mov ebp,esp
00000109  83EC04                  sub esp,byte +0x4
0000010C  897DFC                  mov [ebp-0x4],edi
0000010F  8B7D08                  mov edi,[ebp+0x8]
00000112  8B4D0C                  mov ecx,[ebp+0xc]
00000115  C1E907                  shr ecx,byte 0x7
00000118  660FEFC0                pxor xmm0,xmm0
0000011C  EB08                    jmp short 0x126
0000011E  8DA42400000000          lea esp,[esp+0x0]
00000125  90                      nop
00000126  660F7F07                movdqa [edi],xmm0
0000012A  660F7F4710              movdqa [edi+0x10],xmm0
0000012F  660F7F4720              movdqa [edi+0x20],xmm0
00000134  660F7F4730              movdqa [edi+0x30],xmm0
00000139  660F7F4740              movdqa [edi+0x40],xmm0
0000013E  660F7F4750              movdqa [edi+0x50],xmm0
00000143  660F7F4760              movdqa [edi+0x60],xmm0
00000148  660F7F4770              movdqa [edi+0x70],xmm0
0000014D  8DBF80000000            lea edi,[edi+0x80]
00000153  49                      dec ecx
00000154  75D0                    jnz 0x126
00000156  8B7DFC                  mov edi,[ebp-0x4]
00000159  8BE5                    mov esp,ebp
0000015B  5D                      pop ebp
0000015C  C3                      ret
