00000000  9C                pushfd
00000001  83EC04            sub esp,byte +0x4
00000004  893C24            mov [esp],edi
00000007  55                push ebp
00000008  51                push ecx
00000009  B9FA317547        mov ecx,0x477531fa
0000000E  C1E906            shr ecx,byte 0x6
00000011  C1E106            shl ecx,byte 0x6
00000014  49                dec ecx
00000015  81E1F2E97E5F      and ecx,0x5f7ee9f2
0000001B  81F108A89930      xor ecx,0x3099a808
00000021  89CD              mov ebp,ecx
00000023  59                pop ecx
00000024  896C2404          mov [esp+0x4],ebp
00000028  5D                pop ebp
00000029  8104240B771288    add dword [esp],0x8812770b
00000030  52                push edx
00000031  C70424D7C8F97D    mov dword [esp],0x7df9c8d7
00000038  810C2468F9D77B    or dword [esp],0x7bd7f968
0000003F  C12C2404          shr dword [esp],byte 0x4
00000043  813424D0F8EC4F    xor dword [esp],0x4fecf8d0
0000004A  57                push edi
0000004B  BF3E9EAF3A        mov edi,0x3aaf9e3e
00000050  017C2404          add [esp+0x4],edi
00000054  8B3C24            mov edi,[esp]
00000057  83C404            add esp,byte +0x4
0000005A  C12C2405          shr dword [esp],byte 0x5
0000005E  812C242EE06DC5    sub dword [esp],0xc56de02e
00000065  FF0424            inc dword [esp]
00000068  8104242EAA2DC2    add dword [esp],0xc22daa2e
0000006F  50                push eax
00000070  C704240D497D7F    mov dword [esp],0x7f7d490d
00000077  F71424            not dword [esp]
0000007A  FF0424            inc dword [esp]
0000007D  8124242B98F145    and dword [esp],0x45f1982b
00000084  C1242405          shl dword [esp],byte 0x5
00000088  F71424            not dword [esp]
0000008B  810C241954737F    or dword [esp],0x7f735419
00000092  81042497A4F90E    add dword [esp],0xef9a497
00000099  890C24            mov [esp],ecx
0000009C  890424            mov [esp],eax
0000009F  53                push ebx
000000A0  C70424BD64FB1B    mov dword [esp],0x1bfb64bd
000000A7  8134248D616044    xor dword [esp],0x4460618d
000000AE  57                push edi
000000AF  BF96B4CF2E        mov edi,0x2ecfb496
000000B4  217C2404          and [esp+0x4],edi
000000B8  5F                pop edi
000000B9  8104245B92523D    add dword [esp],0x3d52925b
000000C0  891C24            mov [esp],ebx
000000C3  FF742410          push dword [esp+0x10]
000000C7  8B0424            mov eax,[esp]
000000CA  51                push ecx
000000CB  89E1              mov ecx,esp
000000CD  83C104            add ecx,byte +0x4
000000D0  83C104            add ecx,byte +0x4
000000D3  870C24            xchg ecx,[esp]
000000D6  5C                pop esp
000000D7  FF742408          push dword [esp+0x8]
000000DB  8B1C24            mov ebx,[esp]
000000DE  55                push ebp
000000DF  89E5              mov ebp,esp
000000E1  83C504            add ebp,byte +0x4
000000E4  83C504            add ebp,byte +0x4
000000E7  872C24            xchg ebp,[esp]
000000EA  8B2424            mov esp,[esp]
000000ED  89442408          mov [esp+0x8],eax
000000F1  895C2410          mov [esp+0x10],ebx
000000F5  FF3424            push dword [esp]
000000F8  8B1C24            mov ebx,[esp]
000000FB  51                push ecx
000000FC  89E1              mov ecx,esp
000000FE  52                push edx
000000FF  BAD325173F        mov edx,0x3f1725d3
00000104  81EACF25173F      sub edx,0x3f1725cf
0000010A  01D1              add ecx,edx
0000010C  5A                pop edx
0000010D  83C104            add ecx,byte +0x4
00000110  870C24            xchg ecx,[esp]
00000113  5C                pop esp
00000114  83C404            add esp,byte +0x4
00000117  8B0424            mov eax,[esp]
0000011A  55                push ebp
0000011B  89E5              mov ebp,esp
0000011D  68304EB508        push dword 0x8b54e30
00000122  893424            mov [esp],esi
00000125  BE4059AF7B        mov esi,0x7baf5940
0000012A  81F6222EF831      xor esi,0x31f82e22
00000130  F7DE              neg esi
00000132  4E                dec esi
00000133  4E                dec esi
00000134  81F69888A8B5      xor esi,0xb5a88898
0000013A  01F5              add ebp,esi
0000013C  5E                pop esi
0000013D  83C504            add ebp,byte +0x4
00000140  872C24            xchg ebp,[esp]
00000143  8B2424            mov esp,[esp]
00000146  68C8050000        push dword 0x5c8
0000014B  890424            mov [esp],eax
0000014E  68B3370000        push dword 0x37b3
00000153  891C24            mov [esp],ebx
00000156  890C24            mov [esp],ecx
00000159  682F350000        push dword 0x352f
0000015E  891424            mov [esp],edx
00000161  89E2              mov edx,esp
00000163  83C204            add edx,byte +0x4
00000166  83EA04            sub edx,byte +0x4
00000169  871424            xchg edx,[esp]
0000016C  8B2424            mov esp,[esp]
0000016F  890C24            mov [esp],ecx
00000172  89E1              mov ecx,esp
00000174  50                push eax
00000175  B8F42D2C55        mov eax,0x552c2df4
0000017A  35F02D2C55        xor eax,0x552c2df0
0000017F  01C1              add ecx,eax
00000181  8B0424            mov eax,[esp]
00000184  83C404            add esp,byte +0x4
00000187  57                push edi
00000188  52                push edx
00000189  56                push esi
0000018A  68840D0000        push dword 0xd84
0000018F  893C24            mov [esp],edi
00000192  BFE86B6A11        mov edi,0x116a6be8
00000197  51                push ecx
00000198  B91D30ED57        mov ecx,0x57ed301d
0000019D  81E95F40861C      sub ecx,0x1c86405f
000001A3  83C101            add ecx,byte +0x1
000001A6  F7D1              not ecx
000001A8  81C1AC5BD14C      add ecx,0x4cd15bac
000001AE  89CE              mov esi,ecx
000001B0  59                pop ecx
000001B1  29FE              sub esi,edi
000001B3  5F                pop edi
000001B4  89F2              mov edx,esi
000001B6  5E                pop esi
000001B7  89D7              mov edi,edx
000001B9  5A                pop edx
000001BA  29F9              sub ecx,edi
000001BC  8B3C24            mov edi,[esp]
000001BF  56                push esi
000001C0  89E6              mov esi,esp
000001C2  50                push eax
000001C3  B804000000        mov eax,0x4
000001C8  01C6              add esi,eax
000001CA  58                pop eax
000001CB  83C604            add esi,byte +0x4
000001CE  873424            xchg esi,[esp]
000001D1  5C                pop esp
000001D2  51                push ecx
000001D3  8B4C2404          mov ecx,[esp+0x4]
000001D7  8F0424            pop dword [esp]
000001DA  8B2424            mov esp,[esp]
000001DD  891424            mov [esp],edx
000001E0  682B290000        push dword 0x292b
000001E5  891C24            mov [esp],ebx
000001E8  68E44C0000        push dword 0x4ce4
000001ED  891C24            mov [esp],ebx
000001F0  54                push esp
000001F1  FF3424            push dword [esp]
000001F4  8B1C24            mov ebx,[esp]
000001F7  83C404            add esp,byte +0x4
000001FA  83C404            add esp,byte +0x4
000001FD  57                push edi
000001FE  56                push esi
000001FF  BED97C0124        mov esi,0x24017cd9
00000204  68A5770000        push dword 0x77a5
00000209  890C24            mov [esp],ecx
0000020C  89F1              mov ecx,esi
0000020E  89CF              mov edi,ecx
00000210  59                pop ecx
00000211  5E                pop esi
00000212  55                push ebp
00000213  891424            mov [esp],edx
00000216  51                push ecx
00000217  57                push edi
00000218  BF2B83FEDB        mov edi,0xdbfe832b
0000021D  89F9              mov ecx,edi
0000021F  5F                pop edi
00000220  89CA              mov edx,ecx
00000222  8B0C24            mov ecx,[esp]
00000225  83C404            add esp,byte +0x4
00000228  01D7              add edi,edx
0000022A  5A                pop edx
0000022B  81EBC54EE436      sub ebx,0x36e44ec5
00000231  01FB              add ebx,edi
00000233  81C3C54EE436      add ebx,0x36e44ec5
00000239  5F                pop edi
0000023A  55                push ebp
0000023B  BD04000000        mov ebp,0x4
00000240  29EB              sub ebx,ebp
00000242  5D                pop ebp
00000243  331C24            xor ebx,[esp]
00000246  311C24            xor [esp],ebx
00000249  331C24            xor ebx,[esp]
0000024C  5C                pop esp
0000024D  891C24            mov [esp],ebx
00000250  6852310000        push dword 0x3152
00000255  891424            mov [esp],edx
00000258  892C24            mov [esp],ebp
0000025B  683A180000        push dword 0x183a
00000260  893424            mov [esp],esi
00000263  68235A0000        push dword 0x5a23
00000268  893C24            mov [esp],edi
0000026B  E800000000        call dword 0x270
00000270  8B0C24            mov ecx,[esp]
00000273  83EC04            sub esp,byte +0x4
00000276  893424            mov [esp],esi
00000279  892C24            mov [esp],ebp
0000027C  89E5              mov ebp,esp
0000027E  83EC04            sub esp,byte +0x4
00000281  893424            mov [esp],esi
00000284  BE5B212B61        mov esi,0x612b215b
00000289  81C6A9DED49E      add esi,0x9ed4dea9
0000028F  81ED4B3F0A3D      sub ebp,0x3d0a3f4b
00000295  01F5              add ebp,esi
00000297  81C54B3F0A3D      add ebp,0x3d0a3f4b
0000029D  8B3424            mov esi,[esp]
000002A0  53                push ebx
000002A1  89E3              mov ebx,esp
000002A3  50                push eax
000002A4  B804000000        mov eax,0x4
000002A9  81C36A29BA70      add ebx,0x70ba296a
000002AF  01C3              add ebx,eax
000002B1  56                push esi
000002B2  BE6A29BA70        mov esi,0x70ba296a
000002B7  29F3              sub ebx,esi
000002B9  5E                pop esi
000002BA  58                pop eax
000002BB  55                push ebp
000002BC  52                push edx
000002BD  BAD6597A73        mov edx,0x737a59d6
000002C2  81F2D2597A73      xor edx,0x737a59d2
000002C8  89D5              mov ebp,edx
000002CA  5A                pop edx
000002CB  01EB              add ebx,ebp
000002CD  5D                pop ebp
000002CE  871C24            xchg ebx,[esp]
000002D1  5C                pop esp
000002D2  53                push ebx
000002D3  890424            mov [esp],eax
000002D6  B804000000        mov eax,0x4
000002DB  01C5              add ebp,eax
000002DD  58                pop eax
000002DE  83EC04            sub esp,byte +0x4
000002E1  892C24            mov [esp],ebp
000002E4  FF742404          push dword [esp+0x4]
000002E8  8B2C24            mov ebp,[esp]
000002EB  83C404            add esp,byte +0x4
000002EE  8F0424            pop dword [esp]
000002F1  8B2424            mov esp,[esp]
000002F4  83EC04            sub esp,byte +0x4
000002F7  891424            mov [esp],edx
000002FA  BA5E27D652        mov edx,0x52d6275e
000002FF  56                push esi
00000300  BE2842201E        mov esi,0x1e204228
00000305  81C2DD015270      add edx,0x705201dd
0000030B  01F2              add edx,esi
0000030D  56                push esi
0000030E  BE5B34C347        mov esi,0x47c3345b
00000313  81C682CD8E28      add esi,0x288ecd82
00000319  29F2              sub edx,esi
0000031B  5E                pop esi
0000031C  5E                pop esi
0000031D  42                inc edx
0000031E  81C29113FB2A      add edx,0x2afb1391
00000324  57                push edi
00000325  68F2790000        push dword 0x79f2
0000032A  891424            mov [esp],edx
0000032D  51                push ecx
0000032E  B9BB2C431E        mov ecx,0x1e432cbb
00000333  F7D9              neg ecx
00000335  C1E902            shr ecx,byte 0x2
00000338  C1E104            shl ecx,byte 0x4
0000033B  81C99B61B75C      or ecx,0x5cb7619b
00000341  81C135B0412F      add ecx,0x2f41b035
00000347  89CA              mov edx,ecx
00000349  8B0C24            mov ecx,[esp]
0000034C  53                push ebx
0000034D  89E3              mov ebx,esp
0000034F  83C304            add ebx,byte +0x4
00000352  83C304            add ebx,byte +0x4
00000355  871C24            xchg ebx,[esp]
00000358  8B2424            mov esp,[esp]
0000035B  53                push ebx
0000035C  89D3              mov ebx,edx
0000035E  89DF              mov edi,ebx
00000360  5B                pop ebx
00000361  8B1424            mov edx,[esp]
00000364  83C404            add esp,byte +0x4
00000367  81F76C13561C      xor edi,0x1c56136c
0000036D  4F                dec edi
0000036E  F7D7              not edi
00000370  81CF6C1DE466      or edi,0x66e41d6c
00000376  55                push ebp
00000377  BD00000000        mov ebp,0x0
0000037C  29FD              sub ebp,edi
0000037E  87FD              xchg edi,ebp
00000380  5D                pop ebp
00000381  50                push eax
00000382  B85C5D955B        mov eax,0x5b955d5c
00000387  05A42F3C7D        add eax,0x7d3c2fa4
0000038C  2582724332        and eax,0x32437282
00000391  83C001            add eax,byte +0x1
00000394  40                inc eax
00000395  2DBD11B719        sub eax,0x19b711bd
0000039A  29C7              sub edi,eax
0000039C  58                pop eax
0000039D  31FA              xor edx,edi
0000039F  5F                pop edi
000003A0  F7D2              not edx
000003A2  81F2FB978F7D      xor edx,0x7d8f97fb
000003A8  29D1              sub ecx,edx
000003AA  8B1424            mov edx,[esp]
000003AD  83C404            add esp,byte +0x4
000003B0  57                push edi
000003B1  BFA607BC00        mov edi,0xbc07a6
000003B6  55                push ebp
000003B7  BDC11FB164        mov ebp,0x64b11fc1
000003BC  01E9              add ecx,ebp
000003BE  5D                pop ebp
000003BF  81C19B64A504      add ecx,0x4a5649b
000003C5  29F9              sub ecx,edi
000003C7  81E99B64A504      sub ecx,0x4a5649b
000003CD  81E9C11FB164      sub ecx,0x64b11fc1
000003D3  8B3C24            mov edi,[esp]
000003D6  68DD150000        push dword 0x15dd
000003DB  893424            mov [esp],esi
000003DE  893C24            mov [esp],edi
000003E1  89E7              mov edi,esp
000003E3  83C704            add edi,byte +0x4
000003E6  68F40D0000        push dword 0xdf4
000003EB  892C24            mov [esp],ebp
000003EE  BD1658CE4C        mov ebp,0x4cce5816
000003F3  81E5F853E42A      and ebp,0x2ae453f8
000003F9  50                push eax
000003FA  B8C53C852A        mov eax,0x2a853cc5
000003FF  09C5              or ebp,eax
00000401  58                pop eax
00000402  31D5              xor ebp,edx
00000404  31EA              xor edx,ebp
00000406  31D5              xor ebp,edx
00000408  52                push edx
00000409  F71424            not dword [esp]
0000040C  5A                pop edx
0000040D  87EA              xchg ebp,edx
0000040F  52                push edx
00000410  BAA366026B        mov edx,0x6b0266a3
00000415  09D5              or ebp,edx
00000417  5A                pop edx
00000418  52                push edx
00000419  BA4105FA5F        mov edx,0x5ffa0541
0000041E  81C2663B5748      add edx,0x48573b66
00000424  81F208A76B57      xor edx,0x576ba708
0000042A  31D5              xor ebp,edx
0000042C  5A                pop edx
0000042D  81C77107FF08      add edi,0x8ff0771
00000433  01EF              add edi,ebp
00000435  81EF7107FF08      sub edi,0x8ff0771
0000043B  52                push edx
0000043C  89E2              mov edx,esp
0000043E  83C204            add edx,byte +0x4
00000441  83C204            add edx,byte +0x4
00000444  871424            xchg edx,[esp]
00000447  5C                pop esp
00000448  873C24            xchg edi,[esp]
0000044B  5C                pop esp
0000044C  6893580000        push dword 0x5893
00000451  893C24            mov [esp],edi
00000454  BFAA3B9404        mov edi,0x4943baa
00000459  57                push edi
0000045A  891424            mov [esp],edx
0000045D  BAFA503405        mov edx,0x53450fa
00000462  68123F0000        push dword 0x3f12
00000467  891424            mov [esp],edx
0000046A  812C2415224025    sub dword [esp],0x25402215
00000471  8B2C24            mov ebp,[esp]
00000474  53                push ebx
00000475  89E3              mov ebx,esp
00000477  83C304            add ebx,byte +0x4
0000047A  83C304            add ebx,byte +0x4
0000047D  871C24            xchg ebx,[esp]
00000480  8B2424            mov esp,[esp]
00000483  81C515224025      add ebp,0x25402215
00000489  8B1424            mov edx,[esp]
0000048C  50                push eax
0000048D  89E0              mov eax,esp
0000048F  83C004            add eax,byte +0x4
00000492  83C004            add eax,byte +0x4
00000495  330424            xor eax,[esp]
00000498  310424            xor [esp],eax
0000049B  330424            xor eax,[esp]
0000049E  5C                pop esp
0000049F  81C53A33A90A      add ebp,0xaa9333a
000004A5  29FD              sub ebp,edi
000004A7  81ED3A33A90A      sub ebp,0xaa9333a
000004AD  8B3C24            mov edi,[esp]
000004B0  56                push esi
000004B1  89E6              mov esi,esp
000004B3  83C604            add esi,byte +0x4
000004B6  83EE04            sub esi,byte +0x4
000004B9  873424            xchg esi,[esp]
000004BC  5C                pop esp
000004BD  893C24            mov [esp],edi
000004C0  89E7              mov edi,esp
000004C2  83C704            add edi,byte +0x4
000004C5  83C704            add edi,byte +0x4
000004C8  57                push edi
000004C9  8B7C2404          mov edi,[esp+0x4]
000004CD  8F0424            pop dword [esp]
000004D0  5C                pop esp
000004D1  53                push ebx
000004D2  56                push esi
000004D3  BE32617272        mov esi,0x72726132
000004D8  56                push esi
000004D9  8134245A38C630    xor dword [esp],0x30c6385a
000004E0  8B1C24            mov ebx,[esp]
000004E3  83C404            add esp,byte +0x4
000004E6  81F35A38C630      xor ebx,0x30c6385a
000004EC  8B3424            mov esi,[esp]
000004EF  83C404            add esp,byte +0x4
000004F2  57                push edi
000004F3  53                push ebx
000004F4  BB90318B7D        mov ebx,0x7d8b3190
000004F9  89DF              mov edi,ebx
000004FB  8B1C24            mov ebx,[esp]
000004FE  83C404            add esp,byte +0x4
00000501  81CF1068D21E      or edi,0x1ed26810
00000507  81EF0744E165      sub edi,0x65e14407
0000050D  81EF68386D0D      sub edi,0xd6d3868
00000513  C1E704            shl edi,byte 0x4
00000516  81E70902C914      and edi,0x14c90209
0000051C  81F7ED15C607      xor edi,0x7c615ed
00000522  29FB              sub ebx,edi
00000524  8B3C24            mov edi,[esp]
00000527  52                push edx
00000528  54                push esp
00000529  8B1424            mov edx,[esp]
0000052C  83C404            add esp,byte +0x4
0000052F  83C204            add edx,byte +0x4
00000532  83C204            add edx,byte +0x4
00000535  52                push edx
00000536  FF742404          push dword [esp+0x4]
0000053A  8B1424            mov edx,[esp]
0000053D  83C404            add esp,byte +0x4
00000540  8F0424            pop dword [esp]
00000543  8B2424            mov esp,[esp]
00000546  29DD              sub ebp,ebx
00000548  FF3424            push dword [esp]
0000054B  8B1C24            mov ebx,[esp]
0000054E  83C404            add esp,byte +0x4
00000551  83C404            add esp,byte +0x4
00000554  01CD              add ebp,ecx
00000556  81C54549636B      add ebp,0x6b634945
0000055C  50                push eax
0000055D  83EC04            sub esp,byte +0x4
00000560  892424            mov [esp],esp
00000563  83042404          add dword [esp],byte +0x4
00000567  58                pop eax
00000568  6803790000        push dword 0x7903
0000056D  891424            mov [esp],edx
00000570  BAF31CBF44        mov edx,0x44bf1cf3
00000575  50                push eax
00000576  B85F25F610        mov eax,0x10f6255f
0000057B  48                dec eax
0000057C  0DD57AD638        or eax,0x38d67ad5
00000581  0D350F220C        or eax,0xc220f35
00000586  50                push eax
00000587  FF0424            inc dword [esp]
0000058A  58                pop eax
0000058B  2DD51EA4EA        sub eax,0xeaa41ed5
00000590  31C2              xor edx,eax
00000592  58                pop eax
00000593  53                push ebx
00000594  55                push ebp
00000595  BDAD365A47        mov ebp,0x475a36ad
0000059A  81E5680ECC2A      and ebp,0x2acc0e68
000005A0  81ED27064802      sub ebp,0x2480627
000005A6  89EB              mov ebx,ebp
000005A8  5D                pop ebp
000005A9  29DA              sub edx,ebx
000005AB  5B                pop ebx
000005AC  81EABA563509      sub edx,0x93556ba
000005B2  81EA985EA221      sub edx,0x21a25e98
000005B8  51                push ecx
000005B9  56                push esi
000005BA  BE6C07804C        mov esi,0x4c80076c
000005BF  81E6AA2A5F42      and esi,0x425f2aaa
000005C5  C1E603            shl esi,byte 0x3
000005C8  81CEE05A1137      or esi,0x37115ae0
000005CE  F7D6              not esi
000005D0  C1EE04            shr esi,byte 0x4
000005D3  57                push edi
000005D4  BF5855485B        mov edi,0x5b485558
000005D9  4F                dec edi
000005DA  81EF95A2A362      sub edi,0x62a3a295
000005E0  29FE              sub esi,edi
000005E2  5F                pop edi
000005E3  56                push esi
000005E4  813424624DFC60    xor dword [esp],0x60fc4d62
000005EB  59                pop ecx
000005EC  81F1624DFC60      xor ecx,0x60fc4d62
000005F2  5E                pop esi
000005F3  81EAD22EAF2D      sub edx,0x2daf2ed2
000005F9  81EA0F583739      sub edx,0x3937580f
000005FF  81C22E2F8A3B      add edx,0x3b8a2f2e
00000605  01CA              add edx,ecx
00000607  81EA2E2F8A3B      sub edx,0x3b8a2f2e
0000060D  81C20F583739      add edx,0x3937580f
00000613  81C2D22EAF2D      add edx,0x2daf2ed2
00000619  59                pop ecx
0000061A  01D0              add eax,edx
0000061C  5A                pop edx
0000061D  83E804            sub eax,byte +0x4
00000620  870424            xchg eax,[esp]
00000623  8B2424            mov esp,[esp]
00000626  890C24            mov [esp],ecx
00000629  68C9630000        push dword 0x63c9
0000062E  893C24            mov [esp],edi
00000631  56                push esi
00000632  BEBA439861        mov esi,0x619843ba
00000637  89F7              mov edi,esi
00000639  5E                pop esi
0000063A  81C747BC679E      add edi,0x9e67bc47
00000640  57                push edi
00000641  68DB7D0000        push dword 0x7ddb
00000646  891C24            mov [esp],ebx
00000649  891424            mov [esp],edx
0000064C  BADD706866        mov edx,0x666870dd
00000651  31542404          xor [esp+0x4],edx
00000655  8B1424            mov edx,[esp]
00000658  83C404            add esp,byte +0x4
0000065B  8B0C24            mov ecx,[esp]
0000065E  57                push edi
0000065F  89E7              mov edi,esp
00000661  83C704            add edi,byte +0x4
00000664  51                push ecx
00000665  B904000000        mov ecx,0x4
0000066A  01CF              add edi,ecx
0000066C  59                pop ecx
0000066D  333C24            xor edi,[esp]
00000670  313C24            xor [esp],edi
00000673  5C                pop esp
00000674  50                push eax
00000675  56                push esi
00000676  682B64207A        push dword 0x7a20642b
0000067B  8B3424            mov esi,[esp]
0000067E  83C404            add esp,byte +0x4
00000681  50                push eax
00000682  B8B20C48EC        mov eax,0xec480cb2
00000687  01C6              add esi,eax
00000689  58                pop eax
0000068A  89F0              mov eax,esi
0000068C  5E                pop esi
0000068D  31C1              xor ecx,eax
0000068F  58                pop eax
00000690  8B3C24            mov edi,[esp]
00000693  83EC04            sub esp,byte +0x4
00000696  890424            mov [esp],eax
00000699  89E0              mov eax,esp
0000069B  83C004            add eax,byte +0x4
0000069E  83C004            add eax,byte +0x4
000006A1  870424            xchg eax,[esp]
000006A4  5C                pop esp
000006A5  BB817F8557        mov ebx,0x57857f81
000006AA  68A3670000        push dword 0x67a3
000006AF  893424            mov [esp],esi
000006B2  BE550B941E        mov esi,0x1e940b55
000006B7  F7DE              neg esi
000006B9  81C60C5C6D7D      add esi,0x7d6d5c0c
000006BF  09F3              or ebx,esi
000006C1  5E                pop esi
000006C2  52                push edx
000006C3  890424            mov [esp],eax
000006C6  51                push ecx
000006C7  B904079B53        mov ecx,0x539b0704
000006CC  89C8              mov eax,ecx
000006CE  59                pop ecx
000006CF  31C3              xor ebx,eax
000006D1  58                pop eax
000006D2  83EC04            sub esp,byte +0x4
000006D5  893424            mov [esp],esi
000006D8  890424            mov [esp],eax
000006DB  B8092C1437        mov eax,0x37142c09
000006E0  C1E803            shr eax,byte 0x3
000006E3  53                push ebx
000006E4  BB9114E740        mov ebx,0x40e71491
000006E9  81EB3D422A58      sub ebx,0x582a423d
000006EF  C1E305            shl ebx,byte 0x5
000006F2  50                push eax
000006F3  B88C16501D        mov eax,0x1d50168c
000006F8  354B46CE08        xor eax,0x8ce464b
000006FD  354613863F        xor eax,0x3f861346
00000702  F7D0              not eax
00000704  68D4710000        push dword 0x71d4
00000709  893C24            mov [esp],edi
0000070C  BFF92BCB40        mov edi,0x40cb2bf9
00000711  31F8              xor eax,edi
00000713  8B3C24            mov edi,[esp]
00000716  83C404            add esp,byte +0x4
00000719  C1E804            shr eax,byte 0x4
0000071C  2D3A8D7BEE        sub eax,0xee7b8d3a
00000721  21C3              and ebx,eax
00000723  58                pop eax
00000724  C1E306            shl ebx,byte 0x6
00000727  81EB9AA41287      sub ebx,0x8712a49a
0000072D  29D8              sub eax,ebx
0000072F  8B1C24            mov ebx,[esp]
00000732  83C404            add esp,byte +0x4
00000735  354439A50D        xor eax,0xda53944
0000073A  052F2EEF35        add eax,0x35ef2e2f
0000073F  21C3              and ebx,eax
00000741  8B0424            mov eax,[esp]
00000744  83C404            add esp,byte +0x4
00000747  81EBE1781C21      sub ebx,0x211c78e1
0000074D  55                push ebp
0000074E  BD28C34B8B        mov ebp,0x8b4bc328
00000753  29EB              sub ebx,ebp
00000755  5D                pop ebp
00000756  4B                dec ebx
00000757  81F3F86FBE61      xor ebx,0x61be6ff8
0000075D  C1EB05            shr ebx,byte 0x5
00000760  81EB0A13D301      sub ebx,0x1d3130a
00000766  31C0              xor eax,eax
00000768  F00FB14C1D00      lock cmpxchg [ebp+ebx+0x0],ecx
0000076E  7402              jz 0x772
00000770  EBF4              jmp short 0x766
00000772  FF3424            push dword [esp]
00000775  FF3424            push dword [esp]
00000778  8B0C24            mov ecx,[esp]
0000077B  83C404            add esp,byte +0x4
0000077E  52                push edx
0000077F  893424            mov [esp],esi
00000782  83EC04            sub esp,byte +0x4
00000785  892424            mov [esp],esp
00000788  83042404          add dword [esp],byte +0x4
0000078C  8B3424            mov esi,[esp]
0000078F  686C6E0000        push dword 0x6e6c
00000794  890424            mov [esp],eax
00000797  89E0              mov eax,esp
00000799  83C004            add eax,byte +0x4
0000079C  83C004            add eax,byte +0x4
0000079F  330424            xor eax,[esp]
000007A2  310424            xor [esp],eax
000007A5  330424            xor eax,[esp]
000007A8  5C                pop esp
000007A9  83C604            add esi,byte +0x4
000007AC  83C604            add esi,byte +0x4
000007AF  873424            xchg esi,[esp]
000007B2  5C                pop esp
000007B3  83EC04            sub esp,byte +0x4
000007B6  893424            mov [esp],esi
000007B9  51                push ecx
000007BA  892424            mov [esp],esp
000007BD  83042404          add dword [esp],byte +0x4
000007C1  5E                pop esi
000007C2  83C604            add esi,byte +0x4
000007C5  83C604            add esi,byte +0x4
000007C8  333424            xor esi,[esp]
000007CB  313424            xor [esp],esi
000007CE  333424            xor esi,[esp]
000007D1  5C                pop esp
000007D2  BB2745545E        mov ebx,0x5e544527
000007D7  50                push eax
000007D8  B80124A514        mov eax,0x14a52401
000007DD  C1E004            shl eax,byte 0x4
000007E0  0D48344243        or eax,0x43423448
000007E5  F7D8              neg eax
000007E7  C1E806            shr eax,byte 0x6
000007EA  83E8FF            sub eax,byte -0x1
000007ED  55                push ebp
000007EE  56                push esi
000007EF  BE8109F501        mov esi,0x1f50981
000007F4  81E6A527F211      and esi,0x11f227a5
000007FA  81EE18A5AC8A      sub esi,0x8aaca518
00000800  89F5              mov ebp,esi
00000802  8B3424            mov esi,[esp]
00000805  83C404            add esp,byte +0x4
00000808  81C5E910C844      add ebp,0x44c810e9
0000080E  F7D5              not ebp
00000810  F7DD              neg ebp
00000812  50                push eax
00000813  57                push edi
00000814  BF2F6A7010        mov edi,0x10706a2f
00000819  B8CE7CE44F        mov eax,0x4fe47cce
0000081E  29F8              sub eax,edi
00000820  5F                pop edi
00000821  81C5745C1844      add ebp,0x44185c74
00000827  01C5              add ebp,eax
00000829  81ED745C1844      sub ebp,0x44185c74
0000082F  8B0424            mov eax,[esp]
00000832  83C404            add esp,byte +0x4
00000835  29E8              sub eax,ebp
00000837  5D                pop ebp
00000838  81EB805DD21B      sub ebx,0x1bd25d80
0000083E  29C3              sub ebx,eax
00000840  81C3805DD21B      add ebx,0x1bd25d80
00000846  58                pop eax
00000847  55                push ebp
00000848  BDD2427D68        mov ebp,0x687d42d2
0000084D  21EB              and ebx,ebp
0000084F  5D                pop ebp
00000850  F7DB              neg ebx
00000852  68271E0000        push dword 0x1e27
00000857  892C24            mov [esp],ebp
0000085A  6852560000        push dword 0x5652
0000085F  891C24            mov [esp],ebx
00000862  BB7B28AA06        mov ebx,0x6aa287b
00000867  BDA9D454B9        mov ebp,0xb954d4a9
0000086C  31DD              xor ebp,ebx
0000086E  8B1C24            mov ebx,[esp]
00000871  50                push eax
00000872  89E0              mov eax,esp
00000874  51                push ecx
00000875  B98C4DCF12        mov ecx,0x12cf4d8c
0000087A  C1E106            shl ecx,byte 0x6
0000087D  81E96A286824      sub ecx,0x2468286a
00000883  81F1923A6B8F      xor ecx,0x8f6b3a92
00000889  01C8              add eax,ecx
0000088B  59                pop ecx
0000088C  83C004            add eax,byte +0x4
0000088F  870424            xchg eax,[esp]
00000892  5C                pop esp
00000893  29EB              sub ebx,ebp
00000895  8B2C24            mov ebp,[esp]
00000898  83C404            add esp,byte +0x4
0000089B  83EC04            sub esp,byte +0x4
0000089E  891424            mov [esp],edx
000008A1  890C24            mov [esp],ecx
000008A4  687C140000        push dword 0x147c
000008A9  890424            mov [esp],eax
000008AC  53                push ebx
000008AD  BB3060C63C        mov ebx,0x3cc66030
000008B2  81F38A728947      xor ebx,0x4789728a
000008B8  89D8              mov eax,ebx
000008BA  8B1C24            mov ebx,[esp]
000008BD  52                push edx
000008BE  89E2              mov edx,esp
000008C0  83C204            add edx,byte +0x4
000008C3  83C204            add edx,byte +0x4
000008C6  871424            xchg edx,[esp]
000008C9  8B2424            mov esp,[esp]
000008CC  29442404          sub [esp+0x4],eax
000008D0  8B0424            mov eax,[esp]
000008D3  83C404            add esp,byte +0x4
000008D6  8F441D00          pop dword [ebp+ebx+0x0]
000008DA  51                push ecx
000008DB  89D9              mov ecx,ebx
000008DD  52                push edx
000008DE  BA2E617F39        mov edx,0x397f612e
000008E3  57                push edi
000008E4  BF1F370D2F        mov edi,0x2f0d371f
000008E9  81C74C3B4E5F      add edi,0x5f4e3b4c
000008EF  47                inc edi
000008F0  81F70169DB0C      xor edi,0xcdb6901
000008F6  81EF74ADC40E      sub edi,0xec4ad74
000008FC  09FA              or edx,edi
000008FE  5F                pop edi
000008FF  F7D2              not edx
00000901  42                inc edx
00000902  51                push ecx
00000903  B901920084        mov ecx,0x84009201
00000908  31CA              xor edx,ecx
0000090A  59                pop ecx
0000090B  81C1AA2FE319      add ecx,0x19e32faa
00000911  01D1              add ecx,edx
00000913  57                push edi
00000914  BF4F622877        mov edi,0x7728624f
00000919  81E7F24FF32D      and edi,0x2df34ff2
0000091F  50                push eax
00000920  B88825C426        mov eax,0x26c42588
00000925  051B00071B        add eax,0x1b07001b
0000092A  40                inc eax
0000092B  C1E002            shl eax,byte 0x2
0000092E  254306F419        and eax,0x19f40643
00000933  056420DE1C        add eax,0x1cde2064
00000938  21C7              and edi,eax
0000093A  58                pop eax
0000093B  81F7EA2DE31D      xor edi,0x1de32dea
00000941  29F9              sub ecx,edi
00000943  5F                pop edi
00000944  8B1424            mov edx,[esp]
00000947  83C404            add esp,byte +0x4
0000094A  81C1A753303C      add ecx,0x3c3053a7
00000950  01E9              add ecx,ebp
00000952  81E9A753303C      sub ecx,0x3c3053a7
00000958  8101BA124F7B      add dword [ecx],0x7b4f12ba
0000095E  59                pop ecx
0000095F  6A43              push byte +0x43
00000961  FF3424            push dword [esp]
00000964  8B1C24            mov ebx,[esp]
00000967  50                push eax
00000968  89E0              mov eax,esp
0000096A  83C004            add eax,byte +0x4
0000096D  83C004            add eax,byte +0x4
00000970  870424            xchg eax,[esp]
00000973  5C                pop esp
00000974  6897470000        push dword 0x4797
00000979  893424            mov [esp],esi
0000097C  890424            mov [esp],eax
0000097F  89E0              mov eax,esp
00000981  50                push eax
00000982  89E0              mov eax,esp
00000984  83C004            add eax,byte +0x4
00000987  83E804            sub eax,byte +0x4
0000098A  870424            xchg eax,[esp]
0000098D  5C                pop esp
0000098E  891C24            mov [esp],ebx
00000991  BB04000000        mov ebx,0x4
00000996  057D05E54E        add eax,0x4ee5057d
0000099B  01D8              add eax,ebx
0000099D  2D7D05E54E        sub eax,0x4ee5057d
000009A2  8B1C24            mov ebx,[esp]
000009A5  83C404            add esp,byte +0x4
000009A8  51                push ecx
000009A9  893424            mov [esp],esi
000009AC  BE04000000        mov esi,0x4
000009B1  01F0              add eax,esi
000009B3  8B3424            mov esi,[esp]
000009B6  83C404            add esp,byte +0x4
000009B9  330424            xor eax,[esp]
000009BC  310424            xor [esp],eax
000009BF  330424            xor eax,[esp]
000009C2  8B2424            mov esp,[esp]
000009C5  68D7020000        push dword 0x2d7
000009CA  893424            mov [esp],esi
000009CD  893C24            mov [esp],edi
000009D0  6874024116        push dword 0x16410274
000009D5  8B3C24            mov edi,[esp]
000009D8  83C404            add esp,byte +0x4
000009DB  56                push esi
000009DC  893C24            mov [esp],edi
000009DF  F71424            not dword [esp]
000009E2  5F                pop edi
000009E3  83EC04            sub esp,byte +0x4
000009E6  892C24            mov [esp],ebp
000009E9  BD4A754634        mov ebp,0x3446754a
000009EE  83C5FF            add ebp,byte -0x1
000009F1  4D                dec ebp
000009F2  81F5C38838DD      xor ebp,0xdd3888c3
000009F8  81EF0C3C161B      sub edi,0x1b163c0c
000009FE  29EF              sub edi,ebp
00000A00  81C70C3C161B      add edi,0x1b163c0c
00000A06  5D                pop ebp
00000A07  897C1D00          mov [ebp+ebx+0x0],edi
00000A0B  FF3424            push dword [esp]
00000A0E  FF3424            push dword [esp]
00000A11  8B3C24            mov edi,[esp]
00000A14  83C404            add esp,byte +0x4
00000A17  52                push edx
00000A18  89E2              mov edx,esp
00000A1A  83C204            add edx,byte +0x4
00000A1D  83C204            add edx,byte +0x4
00000A20  871424            xchg edx,[esp]
00000A23  5C                pop esp
00000A24  55                push ebp
00000A25  89E5              mov ebp,esp
00000A27  83C504            add ebp,byte +0x4
00000A2A  83C504            add ebp,byte +0x4
00000A2D  872C24            xchg ebp,[esp]
00000A30  5C                pop esp
00000A31  50                push eax
00000A32  B8EB04AB0F        mov eax,0xfab04eb
00000A37  55                push ebp
00000A38  890424            mov [esp],eax
00000A3B  53                push ebx
00000A3C  BBFA05C565        mov ebx,0x65c505fa
00000A41  81CB6B622D41      or ebx,0x412d626b
00000A47  81CBE5701726      or ebx,0x261770e5
00000A4D  81CB605BF668      or ebx,0x68f65b60
00000A53  81CB9B095066      or ebx,0x6650099b
00000A59  F7DB              neg ebx
00000A5B  81EB560A2643      sub ebx,0x43260a56
00000A61  89D8              mov eax,ebx
00000A63  83C404            add esp,byte +0x4
00000A66  05812C5A7C        add eax,0x7c5a2c81
00000A6B  48                dec eax
00000A6C  35C5B6AAD1        xor eax,0xd1aab6c5
00000A71  BBD0234676        mov ebx,0x764623d0
00000A76  C1E305            shl ebx,byte 0x5
00000A79  4B                dec ebx
00000A7A  81E3F93C5D66      and ebx,0x665d3cf9
00000A80  52                push edx
00000A81  BAB0DEF297        mov edx,0x97f2deb0
00000A86  31D3              xor ebx,edx
00000A88  5A                pop edx
00000A89  81C360139E13      add ebx,0x139e1360
00000A8F  81C30A19D904      add ebx,0x4d9190a
00000A95  01C3              add ebx,eax
00000A97  50                push eax
00000A98  B80A19D904        mov eax,0x4d9190a
00000A9D  29C3              sub ebx,eax
00000A9F  58                pop eax
00000AA0  51                push ecx
00000AA1  B95819260C        mov ecx,0xc261958
00000AA6  49                dec ecx
00000AA7  81C98D383C0E      or ecx,0xe3c388d
00000AAD  50                push eax
00000AAE  B881D95F05        mov eax,0x55fd981
00000AB3  01C1              add ecx,eax
00000AB5  58                pop eax
00000AB6  29CB              sub ebx,ecx
00000AB8  8B0C24            mov ecx,[esp]
00000ABB  83C404            add esp,byte +0x4
00000ABE  58                pop eax
00000ABF  50                push eax
00000AC0  53                push ebx
00000AC1  BBD875F202        mov ebx,0x2f275d8
00000AC6  B801E80F5D        mov eax,0x5d0fe801
00000ACB  29D8              sub eax,ebx
00000ACD  5B                pop ebx
00000ACE  29C3              sub ebx,eax
00000AD0  58                pop eax
00000AD1  01C3              add ebx,eax
00000AD3  57                push edi
00000AD4  BF29721D5A        mov edi,0x5a1d7229
00000AD9  01FB              add ebx,edi
00000ADB  5F                pop edi
00000ADC  83C404            add esp,byte +0x4
00000ADF  FF742428          push dword [esp+0x28]
00000AE3  FF3424            push dword [esp]
00000AE6  8B0424            mov eax,[esp]
00000AE9  83C404            add esp,byte +0x4
00000AEC  686D320000        push dword 0x326d
00000AF1  893424            mov [esp],esi
00000AF4  89E6              mov esi,esp
00000AF6  83EC04            sub esp,byte +0x4
00000AF9  891424            mov [esp],edx
00000AFC  53                push ebx
00000AFD  BBD1405D61        mov ebx,0x615d40d1
00000B02  89DA              mov edx,ebx
00000B04  5B                pop ebx
00000B05  81EACD405D61      sub edx,0x615d40cd
00000B0B  01D6              add esi,edx
00000B0D  8B1424            mov edx,[esp]
00000B10  83C404            add esp,byte +0x4
00000B13  57                push edi
00000B14  BF04000000        mov edi,0x4
00000B19  01FE              add esi,edi
00000B1B  8B3C24            mov edi,[esp]
00000B1E  83C404            add esp,byte +0x4
00000B21  51                push ecx
00000B22  893424            mov [esp],esi
00000B25  FF742404          push dword [esp+0x4]
00000B29  8B3424            mov esi,[esp]
00000B2C  6830730000        push dword 0x7330
00000B31  891C24            mov [esp],ebx
00000B34  89E3              mov ebx,esp
00000B36  83C304            add ebx,byte +0x4
00000B39  83C304            add ebx,byte +0x4
00000B3C  871C24            xchg ebx,[esp]
00000B3F  5C                pop esp
00000B40  8F0424            pop dword [esp]
00000B43  8B2424            mov esp,[esp]
00000B46  51                push ecx
00000B47  50                push eax
00000B48  53                push ebx
00000B49  BBFF6A233B        mov ebx,0x3b236aff
00000B4E  89D8              mov eax,ebx
00000B50  8B1C24            mov ebx,[esp]
00000B53  83C404            add esp,byte +0x4
00000B56  C1E807            shr eax,byte 0x7
00000B59  35B650A710        xor eax,0x10a750b6
00000B5E  89C1              mov ecx,eax
00000B60  8B0424            mov eax,[esp]
00000B63  57                push edi
00000B64  89E7              mov edi,esp
00000B66  83C704            add edi,byte +0x4
00000B69  83C704            add edi,byte +0x4
00000B6C  873C24            xchg edi,[esp]
00000B6F  5C                pop esp
00000B70  81C9502C5778      or ecx,0x78572c50
00000B76  87CA              xchg ecx,edx
00000B78  87D7              xchg edx,edi
00000B7A  57                push edi
00000B7B  F71424            not dword [esp]
00000B7E  5F                pop edi
00000B7F  87D7              xchg edx,edi
00000B81  87CA              xchg ecx,edx
00000B83  81E96B63947B      sub ecx,0x7b94636b
00000B89  83E901            sub ecx,byte +0x1
00000B8C  55                push ebp
00000B8D  56                push esi
00000B8E  BE677EDA13        mov esi,0x13da7e67
00000B93  4E                dec esi
00000B94  81F63A1ECE27      xor esi,0x27ce1e3a
00000B9A  81EE31F50A04      sub esi,0x40af531
00000BA0  56                push esi
00000BA1  812C24DA03A835    sub dword [esp],0x35a803da
00000BA8  5D                pop ebp
00000BA9  81C5DA03A835      add ebp,0x35a803da
00000BAF  5E                pop esi
00000BB0  31E9              xor ecx,ebp
00000BB2  5D                pop ebp
00000BB3  01C8              add eax,ecx
00000BB5  8B0C24            mov ecx,[esp]
00000BB8  83C404            add esp,byte +0x4
00000BBB  2DA03FAF0C        sub eax,0xcaf3fa0
00000BC0  01C8              add eax,ecx
00000BC2  51                push ecx
00000BC3  B9A03FAF0C        mov ecx,0xcaf3fa0
00000BC8  01C8              add eax,ecx
00000BCA  8B0C24            mov ecx,[esp]
00000BCD  83C404            add esp,byte +0x4
00000BD0  51                push ecx
00000BD1  B90B359D3B        mov ecx,0x3b9d350b
00000BD6  29C8              sub eax,ecx
00000BD8  59                pop ecx
00000BD9  53                push ebx
00000BDA  89E3              mov ebx,esp
00000BDC  50                push eax
00000BDD  B8284DDE36        mov eax,0x36de4d28
00000BE2  056872F045        add eax,0x45f07268
00000BE7  F7D0              not eax
00000BE9  57                push edi
00000BEA  BFDC760475        mov edi,0x750476dc
00000BEF  83C701            add edi,byte +0x1
00000BF2  F7DF              neg edi
00000BF4  4F                dec edi
00000BF5  81EF6E54613F      sub edi,0x3f61546e
00000BFB  31F8              xor eax,edi
00000BFD  5F                pop edi
00000BFE  05298B5437        add eax,0x37548b29
00000C03  81EBF02DF442      sub ebx,0x42f42df0
00000C09  01C3              add ebx,eax
00000C0B  81C3F02DF442      add ebx,0x42f42df0
00000C11  58                pop eax
00000C12  83EB04            sub ebx,byte +0x4
00000C15  871C24            xchg ebx,[esp]
00000C18  5C                pop esp
00000C19  891C24            mov [esp],ebx
00000C1C  89E3              mov ebx,esp
00000C1E  56                push esi
00000C1F  BE3A39CB49        mov esi,0x49cb393a
00000C24  F7DE              neg esi
00000C26  F7D6              not esi
00000C28  4E                dec esi
00000C29  F7DE              neg esi
00000C2B  81F6DE087438      xor esi,0x387408de
00000C31  81C6EE31BF71      add esi,0x71bf31ee
00000C37  01F3              add ebx,esi
00000C39  5E                pop esi
00000C3A  83EC04            sub esp,byte +0x4
00000C3D  891424            mov [esp],edx
00000C40  BA04000000        mov edx,0x4
00000C45  29D3              sub ebx,edx
00000C47  8B1424            mov edx,[esp]
00000C4A  83C404            add esp,byte +0x4
00000C4D  871C24            xchg ebx,[esp]
00000C50  5C                pop esp
00000C51  891424            mov [esp],edx
00000C54  89C2              mov edx,eax
00000C56  89541D00          mov [ebp+ebx+0x0],edx
00000C5A  8B1424            mov edx,[esp]
00000C5D  83EC04            sub esp,byte +0x4
00000C60  893C24            mov [esp],edi
00000C63  890424            mov [esp],eax
00000C66  89E0              mov eax,esp
00000C68  51                push ecx
00000C69  B904000000        mov ecx,0x4
00000C6E  01C8              add eax,ecx
00000C70  59                pop ecx
00000C71  83C004            add eax,byte +0x4
00000C74  870424            xchg eax,[esp]
00000C77  5C                pop esp
00000C78  57                push edi
00000C79  BF3143755A        mov edi,0x5a754331
00000C7E  C1EF02            shr edi,byte 0x2
00000C81  57                push edi
00000C82  56                push esi
00000C83  8B3C24            mov edi,[esp]
00000C86  83C404            add esp,byte +0x4
00000C89  8B3424            mov esi,[esp]
00000C8C  83C404            add esp,byte +0x4
00000C8F  83C6FF            add esi,byte -0x1
00000C92  87FE              xchg edi,esi
00000C94  47                inc edi
00000C95  68C2760000        push dword 0x76c2
00000C9A  890424            mov [esp],eax
00000C9D  B822456C47        mov eax,0x476c4522
00000CA2  2DA0A44531        sub eax,0x3145a4a0
00000CA7  31C7              xor edi,eax
00000CA9  58                pop eax
00000CAA  55                push ebp
00000CAB  893424            mov [esp],esi
00000CAE  89FE              mov esi,edi
00000CB0  83EC04            sub esp,byte +0x4
00000CB3  893424            mov [esp],esi
00000CB6  810424D56AAA39    add dword [esp],0x39aa6ad5
00000CBD  8B0424            mov eax,[esp]
00000CC0  56                push esi
00000CC1  89E6              mov esi,esp
00000CC3  83C604            add esi,byte +0x4
00000CC6  83C604            add esi,byte +0x4
00000CC9  873424            xchg esi,[esp]
00000CCC  8B2424            mov esp,[esp]
00000CCF  2DD56AAA39        sub eax,0x39aa6ad5
00000CD4  FF3424            push dword [esp]
00000CD7  8B3424            mov esi,[esp]
00000CDA  57                push edi
00000CDB  89E7              mov edi,esp
00000CDD  83C704            add edi,byte +0x4
00000CE0  83C704            add edi,byte +0x4
00000CE3  873C24            xchg edi,[esp]
00000CE6  5C                pop esp
00000CE7  55                push ebp
00000CE8  89E5              mov ebp,esp
00000CEA  83C504            add ebp,byte +0x4
00000CED  83C504            add ebp,byte +0x4
00000CF0  872C24            xchg ebp,[esp]
00000CF3  5C                pop esp
00000CF4  5F                pop edi
00000CF5  6876480000        push dword 0x4876
00000CFA  891C24            mov [esp],ebx
00000CFD  83EC04            sub esp,byte +0x4
00000D00  890424            mov [esp],eax
00000D03  B88D475E09        mov eax,0x95e478d
00000D08  89C3              mov ebx,eax
00000D0A  58                pop eax
00000D0B  56                push esi
00000D0C  68CC079478        push dword 0x789407cc
00000D11  8B3424            mov esi,[esp]
00000D14  83C404            add esp,byte +0x4
00000D17  53                push ebx
00000D18  BB5557A366        mov ebx,0x66a35755
00000D1D  31DE              xor esi,ebx
00000D1F  5B                pop ebx
00000D20  F7DE              neg esi
00000D22  53                push ebx
00000D23  83EC04            sub esp,byte +0x4
00000D26  893424            mov [esp],esi
00000D29  BEF1645D5D        mov esi,0x5d5d64f1
00000D2E  BBA7DF01B2        mov ebx,0xb201dfa7
00000D33  01F3              add ebx,esi
00000D35  5E                pop esi
00000D36  F7D3              not ebx
00000D38  43                inc ebx
00000D39  C1E305            shl ebx,byte 0x5
00000D3C  51                push ecx
00000D3D  50                push eax
00000D3E  B85022E026        mov eax,0x26e02250
00000D43  89C1              mov ecx,eax
00000D45  58                pop eax
00000D46  52                push edx
00000D47  BA025E8A1A        mov edx,0x1a8a5e02
00000D4C  21D1              and ecx,edx
00000D4E  5A                pop edx
00000D4F  81E9178EE382      sub ecx,0x82e38e17
00000D55  09CB              or ebx,ecx
00000D57  59                pop ecx
00000D58  81EBF6950DFE      sub ebx,0xfe0d95f6
00000D5E  81EE356FA770      sub esi,0x70a76f35
00000D64  29DE              sub esi,ebx
00000D66  81C6356FA770      add esi,0x70a76f35
00000D6C  5B                pop ebx
00000D6D  01F3              add ebx,esi
00000D6F  5E                pop esi
00000D70  01D8              add eax,ebx
00000D72  83C404            add esp,byte +0x4
00000D75  01C8              add eax,ecx
00000D77  2D010D9569        sub eax,0x69950d01
00000D7C  6A4E              push byte +0x4e
00000D7E  8B1C24            mov ebx,[esp]
00000D81  52                push edx
00000D82  89E2              mov edx,esp
00000D84  83C204            add edx,byte +0x4
00000D87  83EA04            sub edx,byte +0x4
00000D8A  871424            xchg edx,[esp]
00000D8D  8B2424            mov esp,[esp]
00000D90  891424            mov [esp],edx
00000D93  89E2              mov edx,esp
00000D95  83C204            add edx,byte +0x4
00000D98  83EA04            sub edx,byte +0x4
00000D9B  871424            xchg edx,[esp]
00000D9E  8B2424            mov esp,[esp]
00000DA1  890C24            mov [esp],ecx
00000DA4  89E1              mov ecx,esp
00000DA6  50                push eax
00000DA7  55                push ebp
00000DA8  BD6C1FF263        mov ebp,0x63f21f6c
00000DAD  81C589210203      add ebp,0x3022189
00000DB3  81F5F140F466      xor ebp,0x66f440f1
00000DB9  89E8              mov eax,ebp
00000DBB  8B2C24            mov ebp,[esp]
00000DBE  53                push ebx
00000DBF  89E3              mov ebx,esp
00000DC1  83C304            add ebx,byte +0x4
00000DC4  83C304            add ebx,byte +0x4
00000DC7  871C24            xchg ebx,[esp]
00000DCA  5C                pop esp
00000DCB  01C1              add ecx,eax
00000DCD  58                pop eax
00000DCE  57                push edi
00000DCF  BF04000000        mov edi,0x4
00000DD4  81C1206CE47D      add ecx,0x7de46c20
00000DDA  01F9              add ecx,edi
00000DDC  68EE190000        push dword 0x19ee
00000DE1  892C24            mov [esp],ebp
00000DE4  BDF05EA92D        mov ebp,0x2da95ef0
00000DE9  81ED9A5D8002      sub ebp,0x2805d9a
00000DEF  F7D5              not ebp
00000DF1  81F5899232A9      xor ebp,0xa9329289
00000DF7  29E9              sub ecx,ebp
00000DF9  5D                pop ebp
00000DFA  8B3C24            mov edi,[esp]
00000DFD  83C404            add esp,byte +0x4
00000E00  870C24            xchg ecx,[esp]
00000E03  5C                pop esp
00000E04  FF741D00          push dword [ebp+ebx+0x0]
00000E08  56                push esi
00000E09  89E6              mov esi,esp
00000E0B  83C604            add esi,byte +0x4
00000E0E  83EE04            sub esi,byte +0x4
00000E11  56                push esi
00000E12  FF742404          push dword [esp+0x4]
00000E16  8B3424            mov esi,[esp]
00000E19  83C404            add esp,byte +0x4
00000E1C  8F0424            pop dword [esp]
00000E1F  5C                pop esp
00000E20  893424            mov [esp],esi
00000E23  BEB21B8E38        mov esi,0x388e1bb2
00000E28  01742404          add [esp+0x4],esi
00000E2C  5E                pop esi
00000E2D  5A                pop edx
00000E2E  6846360000        push dword 0x3646
00000E33  891C24            mov [esp],ebx
00000E36  BB8F719615        mov ebx,0x1596718f
00000E3B  56                push esi
00000E3C  BEBA1D2B28        mov esi,0x282b1dba
00000E41  C1E604            shl esi,byte 0x4
00000E44  81F63223CB16      xor esi,0x16cb2332
00000E4A  81F6FDCB0895      xor esi,0x9508cbfd
00000E50  01F3              add ebx,esi
00000E52  8B3424            mov esi,[esp]
00000E55  83C404            add esp,byte +0x4
00000E58  56                push esi
00000E59  57                push edi
00000E5A  BF1F5B3515        mov edi,0x15355b1f
00000E5F  53                push ebx
00000E60  89FB              mov ebx,edi
00000E62  89DE              mov esi,ebx
00000E64  5B                pop ebx
00000E65  5F                pop edi
00000E66  81C62D64511A      add esi,0x1a51642d
00000E6C  31F3              xor ebx,esi
00000E6E  5E                pop esi
00000E6F  51                push ecx
00000E70  B91C6C2009        mov ecx,0x9206c1c
00000E75  01CA              add edx,ecx
00000E77  59                pop ecx
00000E78  81EA5A060647      sub edx,0x4706065a
00000E7E  29DA              sub edx,ebx
00000E80  81C25A060647      add edx,0x4706065a
00000E86  81EA1C6C2009      sub edx,0x9206c1c
00000E8C  8B1C24            mov ebx,[esp]
00000E8F  56                push esi
00000E90  89E6              mov esi,esp
00000E92  83C604            add esi,byte +0x4
00000E95  83C604            add esi,byte +0x4
00000E98  873424            xchg esi,[esp]
00000E9B  8B2424            mov esp,[esp]
00000E9E  39C2              cmp edx,eax
00000EA0  0F841F040000      jz dword 0x12c5
00000EA6  6895430000        push dword 0x4395
00000EAB  893C24            mov [esp],edi
00000EAE  890C24            mov [esp],ecx
00000EB1  891C24            mov [esp],ebx
00000EB4  6875690000        push dword 0x6975
00000EB9  893C24            mov [esp],edi
00000EBC  6858170000        push dword 0x1758
00000EC1  8B3C24            mov edi,[esp]
00000EC4  52                push edx
00000EC5  89E2              mov edx,esp
00000EC7  83C204            add edx,byte +0x4
00000ECA  83C204            add edx,byte +0x4
00000ECD  331424            xor edx,[esp]
00000ED0  311424            xor [esp],edx
00000ED3  331424            xor edx,[esp]
00000ED6  8B2424            mov esp,[esp]
00000ED9  6831460000        push dword 0x4631
00000EDE  893C24            mov [esp],edi
00000EE1  812C24211B1C24    sub dword [esp],0x241c1b21
00000EE8  5B                pop ebx
00000EE9  83EC04            sub esp,byte +0x4
00000EEC  893424            mov [esp],esi
00000EEF  89E6              mov esi,esp
00000EF1  52                push edx
00000EF2  BA04000000        mov edx,0x4
00000EF7  01D6              add esi,edx
00000EF9  5A                pop edx
00000EFA  83EE04            sub esi,byte +0x4
00000EFD  333424            xor esi,[esp]
00000F00  313424            xor [esp],esi
00000F03  333424            xor esi,[esp]
00000F06  5C                pop esp
00000F07  891424            mov [esp],edx
00000F0A  893424            mov [esp],esi
00000F0D  BE211B1C24        mov esi,0x241c1b21
00000F12  01F3              add ebx,esi
00000F14  8B3424            mov esi,[esp]
00000F17  83C404            add esp,byte +0x4
00000F1A  8B3C24            mov edi,[esp]
00000F1D  83C404            add esp,byte +0x4
00000F20  C1EB02            shr ebx,byte 0x2
00000F23  68265C0000        push dword 0x5c26
00000F28  890424            mov [esp],eax
00000F2B  89E0              mov eax,esp
00000F2D  83C004            add eax,byte +0x4
00000F30  57                push edi
00000F31  89E7              mov edi,esp
00000F33  51                push ecx
00000F34  B92D5AE102        mov ecx,0x2e15a2d
00000F39  81C991151922      or ecx,0x22191591
00000F3F  81E9B95FF922      sub ecx,0x22f95fb9
00000F45  01CF              add edi,ecx
00000F47  59                pop ecx
00000F48  83EF04            sub edi,byte +0x4
00000F4B  57                push edi
00000F4C  8B7C2404          mov edi,[esp+0x4]
00000F50  8F0424            pop dword [esp]
00000F53  5C                pop esp
00000F54  893424            mov [esp],esi
00000F57  890C24            mov [esp],ecx
00000F5A  55                push ebp
00000F5B  50                push eax
00000F5C  B865667C09        mov eax,0x97c6665
00000F61  0D6D547009        or eax,0x970546d
00000F66  57                push edi
00000F67  BFED4A6058        mov edi,0x58604aed
00000F6C  87FE              xchg edi,esi
00000F6E  F7D6              not esi
00000F70  87FE              xchg edi,esi
00000F72  C1E707            shl edi,byte 0x7
00000F75  81F7EF1ED164      xor edi,0x64d11eef
00000F7B  81C75083EA5A      add edi,0x5aea8350
00000F81  01F8              add eax,edi
00000F83  5F                pop edi
00000F84  F7D8              neg eax
00000F86  35506E8DF0        xor eax,0xf08d6e50
00000F8B  50                push eax
00000F8C  813424C541013A    xor dword [esp],0x3a0141c5
00000F93  5D                pop ebp
00000F94  81F5C541013A      xor ebp,0x3a0141c5
00000F9A  8B0424            mov eax,[esp]
00000F9D  83C404            add esp,byte +0x4
00000FA0  89E9              mov ecx,ebp
00000FA2  8B2C24            mov ebp,[esp]
00000FA5  83C404            add esp,byte +0x4
00000FA8  29C8              sub eax,ecx
00000FAA  8B0C24            mov ecx,[esp]
00000FAD  83C404            add esp,byte +0x4
00000FB0  330424            xor eax,[esp]
00000FB3  310424            xor [esp],eax
00000FB6  330424            xor eax,[esp]
00000FB9  8B2424            mov esp,[esp]
00000FBC  890424            mov [esp],eax
00000FBF  85DB              test ebx,ebx
00000FC1  0F84B0010000      jz dword 0x1177
00000FC7  6884130000        push dword 0x1384
00000FCC  892C24            mov [esp],ebp
00000FCF  893C24            mov [esp],edi
00000FD2  891424            mov [esp],edx
00000FD5  68FB500000        push dword 0x50fb
00000FDA  893424            mov [esp],esi
00000FDD  892C24            mov [esp],ebp
00000FE0  BD5D251F45        mov ebp,0x451f255d
00000FE5  87EE              xchg ebp,esi
00000FE7  83C601            add esi,byte +0x1
00000FEA  87EE              xchg ebp,esi
00000FEC  53                push ebx
00000FED  55                push ebp
00000FEE  BD61385A39        mov ebp,0x395a3861
00000FF3  BBF4DB482D        mov ebx,0x2d48dbf4
00000FF8  01EB              add ebx,ebp
00000FFA  5D                pop ebp
00000FFB  31DD              xor ebp,ebx
00000FFD  8B1C24            mov ebx,[esp]
00001000  56                push esi
00001001  89E6              mov esi,esp
00001003  83C604            add esi,byte +0x4
00001006  83C604            add esi,byte +0x4
00001009  873424            xchg esi,[esp]
0000100C  5C                pop esp
0000100D  4D                dec ebp
0000100E  51                push ecx
0000100F  B90A31BC23        mov ecx,0x23bc310a
00001014  29CD              sub ebp,ecx
00001016  59                pop ecx
00001017  53                push ebx
00001018  89E3              mov ebx,esp
0000101A  83C304            add ebx,byte +0x4
0000101D  57                push edi
0000101E  BF04000000        mov edi,0x4
00001023  29FB              sub ebx,edi
00001025  5F                pop edi
00001026  871C24            xchg ebx,[esp]
00001029  5C                pop esp
0000102A  892C24            mov [esp],ebp
0000102D  53                push ebx
0000102E  BB1440983C        mov ebx,0x3c984014
00001033  015C2404          add [esp+0x4],ebx
00001037  5B                pop ebx
00001038  5A                pop edx
00001039  81EA1440983C      sub edx,0x3c984014
0000103F  5D                pop ebp
00001040  01C2              add edx,eax
00001042  50                push eax
00001043  B800000000        mov eax,0x0
00001048  01D0              add eax,edx
0000104A  0108              add [eax],ecx
0000104C  58                pop eax
0000104D  5A                pop edx
0000104E  50                push eax
0000104F  893424            mov [esp],esi
00001052  68B96E0000        push dword 0x6eb9
00001057  891424            mov [esp],edx
0000105A  687E08667B        push dword 0x7b66087e
0000105F  FF3424            push dword [esp]
00001062  8B1424            mov edx,[esp]
00001065  83C404            add esp,byte +0x4
00001068  83C404            add esp,byte +0x4
0000106B  50                push eax
0000106C  89E0              mov eax,esp
0000106E  57                push edi
0000106F  BFDB303C2E        mov edi,0x2e3c30db
00001074  47                inc edi
00001075  81C7007E0F0D      add edi,0xd0f7e00
0000107B  47                inc edi
0000107C  81F7D9AE4B3B      xor edi,0x3b4baed9
00001082  01F8              add eax,edi
00001084  5F                pop edi
00001085  83E804            sub eax,byte +0x4
00001088  870424            xchg eax,[esp]
0000108B  5C                pop esp
0000108C  891C24            mov [esp],ebx
0000108F  68C2676A07        push dword 0x76a67c2
00001094  8B1C24            mov ebx,[esp]
00001097  83C404            add esp,byte +0x4
0000109A  52                push edx
0000109B  BAE327C367        mov edx,0x67c327e3
000010A0  C1EA07            shr edx,byte 0x7
000010A3  81CAA8200E29      or edx,0x290e20a8
000010A9  56                push esi
000010AA  BE68685227        mov esi,0x27526868
000010AF  01F2              add edx,esi
000010B1  5E                pop esi
000010B2  C1EA04            shr edx,byte 0x4
000010B5  81C2789ED423      add edx,0x23d49e78
000010BB  01D3              add ebx,edx
000010BD  8B1424            mov edx,[esp]
000010C0  83C404            add esp,byte +0x4
000010C3  09DA              or edx,ebx
000010C5  8B1C24            mov ebx,[esp]
000010C8  83C404            add esp,byte +0x4
000010CB  C1EA08            shr edx,byte 0x8
000010CE  81C2D58884FF      add edx,0xff8488d5
000010D4  89D6              mov esi,edx
000010D6  5A                pop edx
000010D7  01F0              add eax,esi
000010D9  8B3424            mov esi,[esp]
000010DC  83C404            add esp,byte +0x4
000010DF  50                push eax
000010E0  891424            mov [esp],edx
000010E3  51                push ecx
000010E4  57                push edi
000010E5  53                push ebx
000010E6  BBD3298F78        mov ebx,0x788f29d3
000010EB  81C3420E7D0F      add ebx,0xf7d0e42
000010F1  55                push ebp
000010F2  BD13F3F919        mov ebp,0x19f9f313
000010F7  29EB              sub ebx,ebp
000010F9  5D                pop ebp
000010FA  89DF              mov edi,ebx
000010FC  5B                pop ebx
000010FD  B9D3BAE5D4        mov ecx,0xd4e5bad3
00001102  29F9              sub ecx,edi
00001104  5F                pop edi
00001105  52                push edx
00001106  683F478402        push dword 0x284473f
0000110B  8B1424            mov edx,[esp]
0000110E  83C404            add esp,byte +0x4
00001111  21D1              and ecx,edx
00001113  83C404            add esp,byte +0x4
00001116  81E11E4A0C6A      and ecx,0x6a0c4a1e
0000111C  81E911400002      sub ecx,0x2004011
00001122  89CA              mov edx,ecx
00001124  59                pop ecx
00001125  83EC04            sub esp,byte +0x4
00001128  890424            mov [esp],eax
0000112B  B8B342B810        mov eax,0x10b842b3
00001130  C1E006            shl eax,byte 0x6
00001133  51                push ecx
00001134  B90D43F332        mov ecx,0x32f3430d
00001139  09C8              or eax,ecx
0000113B  59                pop ecx
0000113C  48                dec eax
0000113D  3567C46848        xor eax,0x4868c467
00001142  01C3              add ebx,eax
00001144  8B0424            mov eax,[esp]
00001147  53                push ebx
00001148  89E3              mov ebx,esp
0000114A  83C304            add ebx,byte +0x4
0000114D  83C304            add ebx,byte +0x4
00001150  871C24            xchg ebx,[esp]
00001153  5C                pop esp
00001154  56                push esi
00001155  BEC91D282B        mov esi,0x2b281dc9
0000115A  01F3              add ebx,esi
0000115C  5E                pop esi
0000115D  01D3              add ebx,edx
0000115F  81EBC91D282B      sub ebx,0x2b281dc9
00001165  81EBAB2B9B76      sub ebx,0x769b2bab
0000116B  8B1424            mov edx,[esp]
0000116E  83C404            add esp,byte +0x4
00001171  E949FEFFFF        jmp dword 0xfbf
00001176  FF3424            push dword [esp]
00001179  FF3424            push dword [esp]
0000117C  8B0424            mov eax,[esp]
0000117F  50                push eax
00001180  89E0              mov eax,esp
00001182  57                push edi
00001183  BFF164226D        mov edi,0x6d2264f1
00001188  47                inc edi
00001189  C1E705            shl edi,byte 0x5
0000118C  81F7449E4CA4      xor edi,0xa44c9e44
00001192  01F8              add eax,edi
00001194  5F                pop edi
00001195  53                push ebx
00001196  BB04000000        mov ebx,0x4
0000119B  01D8              add eax,ebx
0000119D  5B                pop ebx
0000119E  50                push eax
0000119F  8B442404          mov eax,[esp+0x4]
000011A3  8F0424            pop dword [esp]
000011A6  5C                pop esp
000011A7  52                push edx
000011A8  50                push eax
000011A9  68160F0000        push dword 0xf16
000011AE  892424            mov [esp],esp
000011B1  51                push ecx
000011B2  B904000000        mov ecx,0x4
000011B7  014C2404          add [esp+0x4],ecx
000011BB  59                pop ecx
000011BC  58                pop eax
000011BD  83C004            add eax,byte +0x4
000011C0  83E804            sub eax,byte +0x4
000011C3  870424            xchg eax,[esp]
000011C6  5C                pop esp
000011C7  892424            mov [esp],esp
000011CA  83042404          add dword [esp],byte +0x4
000011CE  5A                pop edx
000011CF  83C204            add edx,byte +0x4
000011D2  83C204            add edx,byte +0x4
000011D5  871424            xchg edx,[esp]
000011D8  8B2424            mov esp,[esp]
000011DB  56                push esi
000011DC  89E6              mov esi,esp
000011DE  83C604            add esi,byte +0x4
000011E1  83C604            add esi,byte +0x4
000011E4  873424            xchg esi,[esp]
000011E7  5C                pop esp
000011E8  FF3424            push dword [esp]
000011EB  FF3424            push dword [esp]
000011EE  8B1C24            mov ebx,[esp]
000011F1  83C404            add esp,byte +0x4
000011F4  83C404            add esp,byte +0x4
000011F7  51                push ecx
000011F8  893424            mov [esp],esi
000011FB  89E6              mov esi,esp
000011FD  68F6560000        push dword 0x56f6
00001202  891424            mov [esp],edx
00001205  681D120000        push dword 0x121d
0000120A  890424            mov [esp],eax
0000120D  B8D4273A73        mov eax,0x733a27d4
00001212  40                inc eax
00001213  25A72D8A11        and eax,0x118a2da7
00001218  40                inc eax
00001219  50                push eax
0000121A  F71424            not dword [esp]
0000121D  FF0424            inc dword [esp]
00001220  8B0424            mov eax,[esp]
00001223  83C404            add esp,byte +0x4
00001226  35419402B8        xor eax,0xb8029441
0000122B  89C2              mov edx,eax
0000122D  8B0424            mov eax,[esp]
00001230  83C404            add esp,byte +0x4
00001233  81C2C9B108A9      add edx,0xa908b1c9
00001239  81EE3D260727      sub esi,0x2707263d
0000123F  81C66073184E      add esi,0x4e187360
00001245  01D6              add esi,edx
00001247  81EE6073184E      sub esi,0x4e187360
0000124D  81C63D260727      add esi,0x2707263d
00001253  8B1424            mov edx,[esp]
00001256  83C404            add esp,byte +0x4
00001259  83C604            add esi,byte +0x4
0000125C  333424            xor esi,[esp]
0000125F  313424            xor [esp],esi
00001262  333424            xor esi,[esp]
00001265  5C                pop esp
00001266  52                push edx
00001267  890424            mov [esp],eax
0000126A  83EC04            sub esp,byte +0x4
0000126D  892424            mov [esp],esp
00001270  83042404          add dword [esp],byte +0x4
00001274  8B0424            mov eax,[esp]
00001277  83C404            add esp,byte +0x4
0000127A  56                push esi
0000127B  89E6              mov esi,esp
0000127D  83C604            add esi,byte +0x4
00001280  83EE04            sub esi,byte +0x4
00001283  873424            xchg esi,[esp]
00001286  8B2424            mov esp,[esp]
00001289  891C24            mov [esp],ebx
0000128C  BB386D0101        mov ebx,0x1016d38
00001291  F7D3              not ebx
00001293  C1EB06            shr ebx,byte 0x6
00001296  53                push ebx
00001297  89EB              mov ebx,ebp
00001299  5D                pop ebp
0000129A  F7D5              not ebp
0000129C  87DD              xchg ebx,ebp
0000129E  52                push edx
0000129F  BAB00504FC        mov edx,0xfc0405b0
000012A4  31D3              xor ebx,edx
000012A6  5A                pop edx
000012A7  01D8              add eax,ebx
000012A9  8B1C24            mov ebx,[esp]
000012AC  83C404            add esp,byte +0x4
000012AF  83E804            sub eax,byte +0x4
000012B2  50                push eax
000012B3  8B442404          mov eax,[esp+0x4]
000012B7  8F0424            pop dword [esp]
000012BA  8B2424            mov esp,[esp]
000012BD  890424            mov [esp],eax
000012C0  8F441D00          pop dword [ebp+ebx+0x0]
000012C4  FF742424          push dword [esp+0x24]
000012C8  FF3424            push dword [esp]
000012CB  FF3424            push dword [esp]
000012CE  FF3424            push dword [esp]
000012D1  8B1C24            mov ebx,[esp]
000012D4  83C404            add esp,byte +0x4
000012D7  83EC04            sub esp,byte +0x4
000012DA  893424            mov [esp],esi
000012DD  89E6              mov esi,esp
000012DF  83C604            add esi,byte +0x4
000012E2  83C604            add esi,byte +0x4
000012E5  873424            xchg esi,[esp]
000012E8  5C                pop esp
000012E9  53                push ebx
000012EA  54                push esp
000012EB  8B1C24            mov ebx,[esp]
000012EE  83C404            add esp,byte +0x4
000012F1  83C304            add ebx,byte +0x4
000012F4  52                push edx
000012F5  893424            mov [esp],esi
000012F8  BE04000000        mov esi,0x4
000012FD  81C382107E1A      add ebx,0x1a7e1082
00001303  01F3              add ebx,esi
00001305  81EB82107E1A      sub ebx,0x1a7e1082
0000130B  8B3424            mov esi,[esp]
0000130E  55                push ebp
0000130F  89E5              mov ebp,esp
00001311  83C504            add ebp,byte +0x4
00001314  83C504            add ebp,byte +0x4
00001317  872C24            xchg ebp,[esp]
0000131A  5C                pop esp
0000131B  331C24            xor ebx,[esp]
0000131E  311C24            xor [esp],ebx
00001321  331C24            xor ebx,[esp]
00001324  5C                pop esp
00001325  83C404            add esp,byte +0x4
00001328  C1E302            shl ebx,byte 0x2
0000132B  55                push ebp
0000132C  891424            mov [esp],edx
0000132F  BAE6294336        mov edx,0x364329e6
00001334  83EC04            sub esp,byte +0x4
00001337  891424            mov [esp],edx
0000133A  F71424            not dword [esp]
0000133D  5A                pop edx
0000133E  81E29D2B3653      and edx,0x53362b9d
00001344  81E267753056      and edx,0x56307567
0000134A  83EC04            sub esp,byte +0x4
0000134D  891424            mov [esp],edx
00001350  F71424            not dword [esp]
00001353  8B1424            mov edx,[esp]
00001356  83C404            add esp,byte +0x4
00001359  C1EA02            shr edx,byte 0x2
0000135C  83EC04            sub esp,byte +0x4
0000135F  890C24            mov [esp],ecx
00001362  B93D268848        mov ecx,0x4888263d
00001367  01CA              add edx,ecx
00001369  59                pop ecx
0000136A  29D0              sub eax,edx
0000136C  5A                pop edx
0000136D  01D8              add eax,ebx
0000136F  57                push edi
00001370  83EC04            sub esp,byte +0x4
00001373  891424            mov [esp],edx
00001376  BA5762DC51        mov edx,0x51dc6257
0000137B  C1E207            shl edx,byte 0x7
0000137E  C1EA04            shr edx,byte 0x4
00001381  C1EA08            shr edx,byte 0x8
00001384  55                push ebp
00001385  BD0741D709        mov ebp,0x9d74107
0000138A  81C52302966E      add ebp,0x6e960223
00001390  01EA              add edx,ebp
00001392  5D                pop ebp
00001393  52                push edx
00001394  53                push ebx
00001395  891424            mov [esp],edx
00001398  891C24            mov [esp],ebx
0000139B  BB950FB354        mov ebx,0x54b30f95
000013A0  015C2404          add [esp+0x4],ebx
000013A4  5B                pop ebx
000013A5  5F                pop edi
000013A6  81EF950FB354      sub edi,0x54b30f95
000013AC  5A                pop edx
000013AD  01F8              add eax,edi
000013AF  8B3C24            mov edi,[esp]
000013B2  83C404            add esp,byte +0x4
000013B5  FF20              jmp dword [eax]
