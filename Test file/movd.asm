movd    mm0,eax
movd    mm0,[eax]
movd    [eax],mm0
movd    eax,mm0
movd    xmm0,eax
movd    xmm0,[eax]
movd    [eax],xmm0
movd    eax,xmm0

mov cl, [eax - 1]
mov cl, [eax + 0xffffffff]
mov cl, [eax + 0x1ffffffff]
mov cl, [byte eax + 0xffffffff]
mov cl, [byte eax + 0x1ffffffff]
mov cl, [byte eax + 0x1000ffff]