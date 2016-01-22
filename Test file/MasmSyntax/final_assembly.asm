PUSH 0                                                                    ; ESP=0018FF88
PUSH EBX                                                                  ; ESP=0018FF84
PUSH ESI                                                                  ; ESP=0018FF80
MOV EBX, EAX                                                              ; EBX=75EC3358
XOR EAX, EAX                                                              ; EAX=00000000
PUSH EBP                                                                  ; ESP=0018FF7C
PUSH 0X69F078                                                             ; ESP=0018FF78
PUSH DWORD PTR FS:[EAX]                                                   ; ESP=0018FF74
MOV DWORD PTR FS:[EAX], ESP
JMP 0X1391AF1
JNE 0X1391B1A
JG 0X1391B04
JO 0X1391B04
JO 0X1391B1A
JMP 0X1391B19
PUSHAD                                                                    ; ESP=0018FF54
PUSH EBX                                                                  ; ESP=0018FF50
PUSH EAX                                                                  ; ESP=0018FF4C
PUSH EDX                                                                  ; ESP=0018FF48
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF4C
POP EAX                                                                   ; EAX=00000000, ESP=0018FF50
JMP 0X1391B31
POP EBX                                                                   ; ESP=0018FF54
PUSH EAX                                                                  ; ESP=0018FF50
PUSH EDX                                                                  ; ESP=0018FF4C
PUSHAD                                                                    ; ESP=0018FF2C
POPAD                                                                     ; ESP=0018FF4C
PUSH ECX                                                                  ; ESP=0018FF48
POP ECX                                                                   ; ESP=0018FF4C
PUSH EAX                                                                  ; ESP=0018FF48
PUSH EDX                                                                  ; ESP=0018FF44
POP EDX                                                                   ; ESP=0018FF48
POP EAX                                                                   ; EAX=3C5BE8D5, ESP=0018FF4C
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF50
POP EAX                                                                   ; EAX=00000000, ESP=0018FF54
PUSHAD                                                                    ; ESP=0018FF34
PUSHAD                                                                    ; ESP=0018FF14
POPAD                                                                     ; ESP=0018FF34
JB 0X1391B4C
JGE 0X1391B52
JNS 0X1391B58
POPAD                                                                     ; ESP=0018FF54
POPAD                                                                     ; ESP=0018FF74
PUSHFD                                                                    ; ESP=0018FF70
PUSH EDI                                                                  ; ESP=0018FF6C
MOV DWORD PTR [ESP], 0X4EFA4390
PUSH 0X15456C9B                                                           ; ESP=0018FF68
MOV DWORD PTR [ESP], EAX
MOV EAX, 0XB105C0E6                                                       ; EAX=B105C0E6
ADD DWORD PTR [ESP + 4], EAX
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
ADD ESP, 4                                                                ; ESP=0018FF6C
PUSH ESI                                                                  ; ESP=0018FF68
MOV DWORD PTR [ESP], 0X7F528E22
SUB DWORD PTR [ESP], 0X5F9E7373
OR DWORD PTR [ESP], 0X7DFF02CE
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=7FFF1AEF
INC EDI                                                                   ; EDI=7FFF1AF0
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
SUB DWORD PTR [ESP], 0XB6ACDDB
MOV DWORD PTR [ESP], EAX
MOV DWORD PTR [ESP], 0XF8C029
PUSH ESI                                                                  ; ESP=0018FF64
MOV DWORD PTR [ESP], EBP
MOV DWORD PTR [ESP], 0X155E9B4
MOV DWORD PTR [ESP], EAX
MOV DWORD PTR [ESP], EBX
MOV DWORD PTR [ESP], EAX
SUB ESP, 4                                                                ; ESP=0018FF60
MOV DWORD PTR [ESP], EBP
MOV DWORD PTR [ESP], EAX
MOV DWORD PTR [ESP], EBX
PUSH DWORD PTR [ESP + 0X10]                                               ; ESP=0018FF5C
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF58
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000246
ADD ESP, 4                                                                ; ESP=0018FF5C
PUSH EBP                                                                  ; ESP=0018FF58
MOV EBP, ESP                                                              ; EBP=0018FF58
ADD EBP, 4                                                                ; EBP=0018FF5C
ADD EBP, 4                                                                ; EBP=0018FF60
XCHG DWORD PTR [ESP], EBP                                                 ; EBP=0018FF94
POP ESP                                                                   ; ESP=0018FF60
PUSH DWORD PTR [ESP + 8]                                                  ; ESP=0018FF5C
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF58
MOV EBX, DWORD PTR [ESP]                                                  ; EBX=00F8C029
ADD ESP, 4                                                                ; ESP=0018FF5C
PUSH EDX                                                                  ; ESP=0018FF58
MOV EDX, ESP                                                              ; EDX=0018FF58
ADD EDX, 4                                                                ; EDX=0018FF5C
ADD EDX, 4                                                                ; EDX=0018FF60
XCHG DWORD PTR [ESP], EDX                                                 ; EDX=024C1600
POP ESP                                                                   ; ESP=0018FF60
MOV DWORD PTR [ESP + 8], EAX
MOV DWORD PTR [ESP + 0X10], EBX
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF5C
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF58
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF5C
ADD ESP, 4                                                                ; ESP=0018FF60
PUSH EDX                                                                  ; ESP=0018FF5C
MOV EDX, ESP                                                              ; EDX=0018FF5C
ADD EDX, 4                                                                ; EDX=0018FF60
ADD EDX, 4                                                                ; EDX=0018FF64
XCHG DWORD PTR [ESP], EDX                                                 ; EDX=024C1600
POP ESP                                                                   ; ESP=0018FF64
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
PUSH EAX                                                                  ; ESP=0018FF60
PUSH ESP                                                                  ; ESP=0018FF5C
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=0018FF60
ADD ESP, 4                                                                ; ESP=0018FF60
ADD EAX, 4                                                                ; EAX=0018FF64
ADD EAX, 4                                                                ; EAX=0018FF68
PUSH EAX                                                                  ; ESP=0018FF5C
PUSH DWORD PTR [ESP + 4]                                                  ; ESP=0018FF58
POP EAX                                                                   ; EAX=00000000, ESP=0018FF5C
POP DWORD PTR [ESP]                                                       ; ESP=0018FF60
POP ESP                                                                   ; ESP=0018FF68
JMP 0X997317
PUSH EDI                                                                  ; ESP=0018FF64
PUSH EAX                                                                  ; ESP=0018FF60
PUSH EDX                                                                  ; ESP=0018FF5C
JMP 0X997325
PUSHAD                                                                    ; ESP=0018FF3C
POPAD                                                                     ; ESP=0018FF5C
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF60
POP EAX                                                                   ; EAX=00000000, ESP=0018FF64
POP EDI                                                                   ; ESP=0018FF68
PUSH EAX                                                                  ; ESP=0018FF64
PUSH EDX                                                                  ; ESP=0018FF60
PUSH ECX                                                                  ; ESP=0018FF5C
PUSH EAX                                                                  ; ESP=0018FF58
PUSH EDX                                                                  ; ESP=0018FF54
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF58
POP EAX                                                                   ; EAX=00000000, ESP=0018FF5C
JO 0X99733C
POP ECX                                                                   ; ESP=0018FF60
JMP 0X99734E
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF64
POP EAX                                                                   ; EAX=00000000, ESP=0018FF68
PUSH EBX                                                                  ; ESP=0018FF64
PUSH ESP                                                                  ; ESP=0018FF60
MOV EBX, DWORD PTR [ESP]                                                  ; EBX=0018FF64
PUSH 0XBC1                                                                ; ESP=0018FF5C
MOV DWORD PTR [ESP], EAX
MOV EAX, ESP                                                              ; EAX=0018FF5C
ADD EAX, 4                                                                ; EAX=0018FF60
ADD EAX, 4                                                                ; EAX=0018FF64
XCHG DWORD PTR [ESP], EAX                                                 ; EAX=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF64
ADD EBX, 4                                                                ; EBX=0018FF68
PUSH EDX                                                                  ; ESP=0018FF60
MOV EDX, 0X45FF7896                                                       ; EDX=45FF7896
PUSH EDX                                                                  ; ESP=0018FF5C
MOV DWORD PTR [ESP], ESI
SUB ESP, 4                                                                ; ESP=0018FF58
MOV DWORD PTR [ESP], EDI
MOV EDI, 0X60974038                                                       ; EDI=60974038
PUSH ESI                                                                  ; ESP=0018FF54
MOV ESI, 0XDFF381A                                                        ; ESI=0DFF381A
DEC ESI                                                                   ; ESI=0DFF3819
INC ESI                                                                   ; ESI=0DFF381A
ADD ESI, 0X761C7CF0                                                       ; ESI=841BB50A
XOR ESI, 0XFB17A194                                                       ; ESI=7F0C149E
ADD EDI, ESI                                                              ; EDI=DFA354D6
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=00000000
ADD ESP, 4                                                                ; ESP=0018FF58
ADD EDI, 0X4FF21FCD                                                       ; EDI=2F9574A3
SUB EDI, 0X13AA7E44                                                       ; EDI=1BEAF65F
AND EDI, 0X6EF24EA                                                        ; EDI=02EA244A
ADD EDI, 0X43155448                                                       ; EDI=45FF7892
MOV ESI, EDI                                                              ; ESI=45FF7892
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
ADD ESP, 4                                                                ; ESP=0018FF5C
XOR EDX, ESI                                                              ; EDX=00000004
POP ESI                                                                   ; ESP=0018FF60, ESI=00000000
ADD EBX, 0X33A82EA3                                                       ; EBX=33C12E0B
SUB EBX, EDX                                                              ; EBX=33C12E07
SUB EBX, 0X33A82EA3                                                       ; EBX=0018FF64
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF64
XCHG DWORD PTR [ESP], EBX                                                 ; EBX=75EC3358
POP ESP                                                                   ; kernel32.75EC336A
MOV DWORD PTR [ESP], EAX
PUSH 0X244D                                                               ; ESP=0018FF60
MOV DWORD PTR [ESP], ECX
PUSH EDX                                                                  ; ESP=0018FF5C
MOV EDX, ESP                                                              ; EDX=0018FF5C
PUSH ECX                                                                  ; ESP=0018FF58
MOV ECX, 0X2F691F13                                                       ; ECX=2F691F13
SUB ESP, 4                                                                ; ESP=0018FF54
MOV DWORD PTR [ESP], EDI
MOV EDI, 0X4B543DAB                                                       ; EDI=4B543DAB
SUB ECX, EDI                                                              ; ECX=E414E168
POP EDI                                                                   ; ESP=0018FF58, EDI=00000000
OR ECX, 0X77977D7D                                                        ; ECX=F797FD7D
SUB ECX, 0X3C5C5872                                                       ; ECX=BB3BA50B
PUSH ECX                                                                  ; ESP=0018FF54
DEC DWORD PTR [ESP]                                                       ; kernel32.75EC336A
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=BB3BA50A
ADD ESP, 4                                                                ; ESP=0018FF58
XOR ECX, 0XBB3BA50E                                                       ; ECX=00000004
ADD EDX, ECX                                                              ; EDX=0018FF60
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF54
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=00000000
ADD ESP, 4                                                                ; ESP=0018FF58
ADD ESP, 4                                                                ; ESP=0018FF5C
SUB EDX, 4                                                                ; EDX=0018FF5C
SUB ESP, 4                                                                ; ESP=0018FF58
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH DWORD PTR [ESP + 4]                                                  ; ESP=0018FF54
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF50
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF54
PUSH EAX                                                                  ; ESP=0018FF50
MOV EAX, ESP                                                              ; EAX=0018FF50
ADD EAX, 4                                                                ; EAX=0018FF54
ADD EAX, 4                                                                ; EAX=0018FF58
XCHG DWORD PTR [ESP], EAX                                                 ; EAX=00000000
POP ESP                                                                   ; ESP=0018FF58
POP DWORD PTR [ESP]                                                       ; ESP=0018FF5C
MOV ESP, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH 0X3DE7                                                               ; ESP=0018FF58
MOV DWORD PTR [ESP], EBX
SUB ESP, 4                                                                ; ESP=0018FF54
MOV DWORD PTR [ESP], EDI
PUSH EDX                                                                  ; ESP=0018FF50
MOV DWORD PTR [ESP], ESP
ADD DWORD PTR [ESP], 4
POP EDI                                                                   ; ESP=0018FF54, EDI=0018FF54
PUSH EBX                                                                  ; ESP=0018FF50
MOV EBX, 0X4DA52890                                                       ; EBX=4DA52890
SHR EBX, 3                                                                ; EBX=09B4A512
ADD EBX, 0XF64B5AF2                                                       ; EBX=00000004
PUSH EBP                                                                  ; ESP=0018FF4C
PUSH ESI                                                                  ; ESP=0018FF48
MOV ESI, 0X55401851                                                       ; ESI=55401851
SUB ESI, 0X6E4F77BE                                                       ; ESI=E6F0A093
INC ESI                                                                   ; ESI=E6F0A094
SUB ESI, 0X63331B5D                                                       ; ESI=83BD8537
AND ESI, 0X590905D1                                                       ; ESI=01090511
SUB ESI, 0X66AE7142                                                       ; ESI=9A5A93CF
PUSH ECX                                                                  ; ESP=0018FF44
MOV ECX, 0XBB4B93A9                                                       ; ECX=BB4B93A9
XOR ESI, ECX                                                              ; ESI=21110066
POP ECX                                                                   ; ECX=00000000, ESP=0018FF48
MOV EBP, ESI                                                              ; EBP=21110066
POP ESI                                                                   ; ESP=0018FF4C, ESI=00000000
XOR EBP, 0X33143D87                                                       ; EBP=12053DE1
ADD EDI, 0X31B13577                                                       ; EDI=31CA34CB
SUB EDI, EBP                                                              ; EDI=1FC4F6EA
SUB EDI, 0X31B13577                                                       ; EDI=EE13C173
POP EBP                                                                   ; ESP=0018FF50, EBP=0018FF94
ADD EDI, EBX                                                              ; EDI=EE13C177
PUSH ESI                                                                  ; ESP=0018FF4C
PUSH EDI                                                                  ; ESP=0018FF48
PUSH 0X2D33BE8                                                            ; ESP=0018FF44
POP EDI                                                                   ; ESP=0018FF48, EDI=02D33BE8
XOR EDI, 0X10D60609                                                       ; EDI=12053DE1
MOV ESI, EDI                                                              ; ESI=12053DE1
POP EDI                                                                   ; ESP=0018FF4C, EDI=EE13C177
ADD EDI, ESI                                                              ; EDI=0018FF58
POP ESI                                                                   ; ESP=0018FF50, ESI=00000000
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF54
PUSH ESI                                                                  ; ESP=0018FF50
MOV ESI, 4                                                                ; ESI=00000004
SUB EDI, ESI                                                              ; EDI=0018FF54
POP ESI                                                                   ; ESP=0018FF54, ESI=00000000
XOR EDI, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
XOR DWORD PTR [ESP], EDI
XOR EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
MOV DWORD PTR [ESP], EBX
PUSH 0XD94                                                                ; ESP=0018FF50
MOV DWORD PTR [ESP], EBP
PUSH 0X3E45                                                               ; ESP=0018FF4C
MOV DWORD PTR [ESP], ESI
PUSH EDX                                                                  ; ESP=0018FF48
PUSH ESP                                                                  ; ESP=0018FF44
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
POP EDX                                                                   ; EDX=0018FF48, ESP=0018FF44
ADD ESP, 4                                                                ; ESP=0018FF48
PUSH EBX                                                                  ; ESP=0018FF44
MOV EBX, 4                                                                ; EBX=00000004
SUB EDX, 0X9D42843                                                        ; EDX=F644D705
ADD EDX, EBX                                                              ; EDX=F644D709
ADD EDX, 0X9D42843                                                        ; EDX=0018FF4C
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF48
PUSH EAX                                                                  ; ESP=0018FF44
PUSH EBX                                                                  ; ESP=0018FF40
PUSH 0X328552F                                                            ; ESP=0018FF3C
POP EBX                                                                   ; EBX=0328552F, ESP=0018FF40
XOR EBX, 0X328552B                                                        ; EBX=00000004
PUSH EDI                                                                  ; ESP=0018FF3C
MOV EDI, EBX                                                              ; EDI=00000004
MOV EAX, EDI                                                              ; EAX=00000004
POP EDI                                                                   ; ESP=0018FF40, EDI=00000000
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF44
PUSH EBX                                                                  ; ESP=0018FF40
MOV EBX, 0X562E7C54                                                       ; EBX=562E7C54
ADD EDX, EBX                                                              ; EDX=56477BA0
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF44
SUB EDX, EAX                                                              ; EDX=56477B9C
PUSH EBP                                                                  ; ESP=0018FF40
MOV EBP, 0X562E7C54                                                       ; EBP=562E7C54
SUB EDX, EBP                                                              ; EDX=0018FF48
POP EBP                                                                   ; ESP=0018FF44, EBP=0018FF94
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
ADD ESP, 4                                                                ; ESP=0018FF48
XCHG DWORD PTR [ESP], EDX                                                 ; EDX=024C1600
MOV ESP, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
MOV DWORD PTR [ESP], EBX
MOV DWORD PTR [ESP], EDI
CALL 0X99756D                                                             ; ESP=0018FF44
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=0099756D
PUSH EAX                                                                  ; ESP=0018FF3C
MOV EAX, ESP                                                              ; EAX=0018FF3C
ADD EAX, 4                                                                ; EAX=0018FF40
ADD EAX, 4                                                                ; EAX=0018FF44
XCHG DWORD PTR [ESP], EAX                                                 ; EAX=00000000
POP ESP                                                                   ; ESP=0018FF44
PUSH 0X283A                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV DWORD PTR [ESP], ESI
SUB ESP, 4                                                                ; ESP=0018FF3C
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV DWORD PTR [ESP], ESP
ADD DWORD PTR [ESP], 4
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=0018FF40
ADD ESP, 4                                                                ; ESP=0018FF40
PUSH 0X203F                                                               ; ESP=0018FF3C
MOV DWORD PTR [ESP], EBX
MOV EBX, 4                                                                ; EBX=00000004
ADD ESI, EBX                                                              ; ESI=0018FF44
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF40
PUSH EBX                                                                  ; ESP=0018FF3C
PUSH EBP                                                                  ; ESP=0018FF38
MOV EBP, 0X560304B5                                                       ; EBP=560304B5
ADD EBP, -1                                                               ; EBP=560304B4
SHL EBP, 1                                                                ; EBP=AC060968
NEG EBP                                                                   ; EBP=53F9F698
ADD EBP, 0X328F156F                                                       ; EBP=86890C07
XOR EBP, 0X86890C03                                                       ; EBP=00000004
MOV EBX, EBP                                                              ; EBX=00000004
POP EBP                                                                   ; ESP=0018FF3C, EBP=0018FF94
ADD ESI, EBX                                                              ; ESI=0018FF48
POP EBX                                                                   ; EBX=75EC3358, ESP=0018FF40
XCHG DWORD PTR [ESP], ESI                                                 ; ESI=00000000
POP ESP                                                                   ; ESP=0018FF48
PUSH 0X5F53                                                               ; ESP=0018FF44
MOV DWORD PTR [ESP], ESI
MOV ESI, ESP                                                              ; ESI=0018FF44
ADD ESI, 4                                                                ; ESI=0018FF48
SUB ESI, 4                                                                ; ESI=0018FF44
XCHG DWORD PTR [ESP], ESI                                                 ; ESI=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
MOV DWORD PTR [ESP], ESI
PUSH 0X69F83F99                                                           ; ESP=0018FF40
POP ESI                                                                   ; ESP=0018FF44, ESI=69F83F99
DEC ESI                                                                   ; ESI=69F83F98
SUB ESI, 1                                                                ; ESI=69F83F97
PUSH ECX                                                                  ; ESP=0018FF40
PUSH ESI                                                                  ; ESP=0018FF3C
PUSH 0X6C025E7                                                            ; ESP=0018FF38
POP ESI                                                                   ; ESP=0018FF3C, ESI=06C025E7
PUSH ESI                                                                  ; ESP=0018FF38
MOV ESI, 0X63536AF5                                                       ; ESI=63536AF5
MOV ECX, 0X7279875F                                                       ; ECX=7279875F
SUB ECX, ESI                                                              ; ECX=0F261C6A
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=06C025E7
ADD ESP, 4                                                                ; ESP=0018FF3C
XOR ECX, ESI                                                              ; ECX=09E6398D
POP ESI                                                                   ; ESP=0018FF40, ESI=69F83F97
XOR ESI, ECX                                                              ; ESI=601E061A
POP ECX                                                                   ; ECX=0099756D, ESP=0018FF44
XOR ESI, 0X601E044C                                                       ; ESI=00000256
PUSH ESI                                                                  ; ESP=0018FF40
PUSH EAX                                                                  ; ESP=0018FF3C
PUSH 0X6F3A43A0                                                           ; ESP=0018FF38
POP EAX                                                                   ; EAX=6F3A43A0, ESP=0018FF3C
XOR EAX, 0X68BB322D                                                       ; EAX=0781718D
MOV ESI, EAX                                                              ; ESI=0781718D
POP EAX                                                                   ; EAX=00000000, ESP=0018FF40
SHL ESI, 5                                                                ; ESI=F02E31A0
OR ESI, 0X60E4424                                                         ; ESI=F62E75A4
NOT ESI                                                                   ; ESI=09D18A5B
SUB ESI, 0XED395D25                                                       ; ESI=1C982D36
SUB ECX, ESI                                                              ; ECX=E4014837
POP ESI                                                                   ; ESP=0018FF44, ESI=00000256
SUB ECX, ESI                                                              ; ECX=E40145E1
PUSH EDI                                                                  ; ESP=0018FF40
MOV EDI, 0XD211689                                                        ; EDI=0D211689
OR EDI, 0X3C097392                                                        ; EDI=3D29779B
XOR EDI, 0X21B15AAD                                                       ; EDI=1C982D36
ADD ECX, EDI                                                              ; ECX=00997317
POP EDI                                                                   ; ESP=0018FF44, EDI=00000000
POP ESI                                                                   ; ESP=0018FF48, ESI=00000000
PUSH 0X33EA                                                               ; ESP=0018FF44
MOV DWORD PTR [ESP], EAX
PUSH EBP                                                                  ; ESP=0018FF40
MOV EBP, 0X497128DD                                                       ; EBP=497128DD
PUSH EDX                                                                  ; ESP=0018FF3C
PUSH EDI                                                                  ; ESP=0018FF38
MOV EDI, EBP                                                              ; EDI=497128DD
MOV EDX, EDI                                                              ; EDX=497128DD
POP EDI                                                                   ; ESP=0018FF3C, EDI=00000000
MOV EAX, EDX                                                              ; EAX=497128DD
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF40
POP EBP                                                                   ; ESP=0018FF44, EBP=0018FF94
PUSH ESI                                                                  ; ESP=0018FF40
MOV ESI, 0X1F131475                                                       ; ESI=1F131475
AND EAX, ESI                                                              ; EAX=09110055
POP ESI                                                                   ; ESP=0018FF44, ESI=00000000
SUB ESP, 4                                                                ; ESP=0018FF40
MOV DWORD PTR [ESP], EBP
MOV EBP, 0X59171E3D                                                       ; EBP=59171E3D
SHR EBP, 8                                                                ; EBP=0059171E
ADD EBP, 0XF6EF5BA4                                                       ; EBP=F74872C2
ADD EAX, EBP                                                              ; EAX=00597317
POP EBP                                                                   ; ESP=0018FF44, EBP=0018FF94
SUB ECX, EAX                                                              ; ECX=00400000
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH 0X385F                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], ESI
MOV ESI, ESP                                                              ; ESI=0018FF40
ADD ESI, 4                                                                ; ESI=0018FF44
ADD ESI, 4                                                                ; ESI=0018FF48
PUSH ESI                                                                  ; ESP=0018FF3C
PUSH DWORD PTR [ESP + 4]                                                  ; ESP=0018FF38
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF34
POP ESI                                                                   ; ESP=0018FF38, ESI=00000000
ADD ESP, 4                                                                ; ESP=0018FF3C
POP DWORD PTR [ESP]                                                       ; ESP=0018FF40
POP ESP                                                                   ; ESP=0018FF48
PUSH 0X459925                                                             ; ESP=0018FF44
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
POP EBP                                                                   ; ESP=0018FF44, EBP=00459925
SUB ESP, 4                                                                ; ESP=0018FF40
MOV DWORD PTR [ESP], EAX
PUSH ESP                                                                  ; ESP=0018FF3C
POP EAX                                                                   ; EAX=0018FF40, ESP=0018FF40
PUSH 0X7AEF                                                               ; ESP=0018FF3C
MOV DWORD PTR [ESP], ESI
PUSH 0X2CD97285                                                           ; ESP=0018FF38
POP ESI                                                                   ; ESP=0018FF3C, ESI=2CD97285
PUSH EAX                                                                  ; ESP=0018FF38
MOV EAX, 0X35DD6CCE                                                       ; EAX=35DD6CCE
OR EAX, 0X70A64DE2                                                        ; EAX=75FF6DEE
DEC EAX                                                                   ; EAX=75FF6DED
INC EAX                                                                   ; EAX=75FF6DEE
XOR EAX, 0X4594084C                                                       ; EAX=306B65A2
PUSH EDI                                                                  ; ESP=0018FF34
MOV EDI, 0X4199423F                                                       ; EDI=4199423F
SUB EDI, 0X73BF77A6                                                       ; EDI=CDD9CA99
AND EDI, 0X16C34746                                                       ; EDI=04C14200
SUB EDI, 0XB5B4E504                                                       ; EDI=4F0C5CFC
ADD EAX, EDI                                                              ; EAX=7F77C29E
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
PUSH EDI                                                                  ; ESP=0018FF30
MOV EDI, ESP                                                              ; EDI=0018FF30
ADD EDI, 4                                                                ; EDI=0018FF34
ADD EDI, 4                                                                ; EDI=0018FF38
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
POP ESP                                                                   ; ESP=0018FF38
ADD EAX, 0XC3C2761F                                                       ; EAX=433A38BD
OR ESI, EAX                                                               ; ESI=6FFB7ABD
POP EAX                                                                   ; EAX=0018FF40, ESP=0018FF3C
XOR ESI, 0X6FFB7AB9                                                       ; ESI=00000004
ADD EAX, ESI                                                              ; EAX=0018FF44
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=00000000
ADD ESP, 4                                                                ; ESP=0018FF40
PUSH EBP                                                                  ; ESP=0018FF3C
MOV EBP, 4                                                                ; EBP=00000004
ADD EAX, EBP                                                              ; EAX=0018FF48
POP EBP                                                                   ; ESP=0018FF40, EBP=00459925
XCHG DWORD PTR [ESP], EAX                                                 ; EAX=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF48
PUSH 0XFC1                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], EAX
MOV EAX, 0X3EE244BD                                                       ; EAX=3EE244BD
ADD EBP, 0X57B5D3E                                                        ; EBP=05C0F663
SUB EBP, EAX                                                              ; EBP=C6DEB1A6
PUSH EDI                                                                  ; ESP=0018FF40
MOV EDI, 0X57B5D3E                                                        ; EDI=057B5D3E
SUB EBP, 0X351F6911                                                       ; EBP=91BF4895
SUB EBP, EDI                                                              ; EBP=8C43EB57
ADD EBP, 0X351F6911                                                       ; EBP=C1635468
POP EDI                                                                   ; ESP=0018FF44, EDI=00000000
POP EAX                                                                   ; EAX=00000000, ESP=0018FF48
SUB EBP, 0X51503A32                                                       ; EBP=70131A36
PUSH EDX                                                                  ; ESP=0018FF44
MOV EDX, 0X1DB544D                                                        ; EDX=01DB544D
ADD EDX, 0X7750174                                                        ; EDX=095055C1
ADD EBP, EDX                                                              ; EBP=79636FF7
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF48
ADD EBP, ECX                                                              ; EBP=79A36FF7
SUB EBP, 0X95055C1                                                        ; EBP=70531A36
ADD EBP, 0X51503A32                                                       ; EBP=C1A35468
PUSH 0X18DF                                                               ; ESP=0018FF44
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV EDX, 0X52F67236                                                       ; EDX=52F67236
SHL EDX, 6                                                                ; EDX=BD9C8D80
ADD EDX, 0X4B176068                                                       ; EDX=08B3EDE8
PUSH ECX                                                                  ; ESP=0018FF40
MOV ECX, 0X10525D7C                                                       ; ECX=10525D7C
SHL ECX, 3                                                                ; ECX=8292EBE0
PUSH EAX                                                                  ; ESP=0018FF3C
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV EDX, 0X79962D4F                                                       ; EDX=79962D4F
ADD EDX, 0X20E2353A                                                       ; EDX=9A786289
XOR EDX, 0X167E0E53                                                       ; EDX=8C066CDA
SUB EDX, 0X17C0E0C                                                        ; EDX=8A8A5ECE
SHR EDX, 1                                                                ; EDX=45452F67
ADD EDX, 0XFE114BCE                                                       ; EDX=43567B35
XOR ECX, EDX                                                              ; ECX=C1C490D5
POP EDX                                                                   ; EDX=08B3EDE8, ESP=0018FF40
DEC ECX                                                                   ; ECX=C1C490D4
PUSH EDX                                                                  ; ESP=0018FF3C
MOV EDX, 0XF7953981                                                       ; EDX=F7953981
XOR ECX, EDX                                                              ; ECX=3651A955
POP EDX                                                                   ; EDX=08B3EDE8, ESP=0018FF40
XOR EDX, ECX                                                              ; EDX=3EE244BD
POP ECX                                                                   ; ECX=00400000, ESP=0018FF44
ADD EBP, EDX                                                              ; EBP=00859925
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF48
PUSH 0X55FF                                                               ; ESP=0018FF44
MOV DWORD PTR [ESP], ECX
PUSH 1                                                                    ; ESP=0018FF40
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF3C
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF38
POP ECX                                                                   ; ECX=00000001, ESP=0018FF3C
PUSH EAX                                                                  ; ESP=0018FF38
MOV DWORD PTR [ESP], ESI
PUSH ESP                                                                  ; ESP=0018FF34
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=0018FF38
ADD ESP, 4                                                                ; ESP=0018FF38
ADD ESI, 4                                                                ; ESI=0018FF3C
PUSH EAX                                                                  ; ESP=0018FF34
MOV EAX, 4                                                                ; EAX=00000004
ADD ESI, 0X21404281                                                       ; ESI=215941BD
ADD ESI, EAX                                                              ; ESI=215941C1
SUB ESI, 0X21404281                                                       ; ESI=0018FF40
POP EAX                                                                   ; EAX=00000000, ESP=0018FF38
XOR ESI, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
XOR DWORD PTR [ESP], ESI
XOR ESI, DWORD PTR [ESP]                                                  ; ESI=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF40
PUSH EDI                                                                  ; ESP=0018FF3C
MOV EDI, ESP                                                              ; EDI=0018FF3C
PUSH ESI                                                                  ; ESP=0018FF38
MOV ESI, 4                                                                ; ESI=00000004
ADD EDI, ESI                                                              ; EDI=0018FF40
POP ESI                                                                   ; ESP=0018FF3C, ESI=00000000
ADD EDI, 4                                                                ; EDI=0018FF44
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF44
PUSH EAX                                                                  ; ESP=0018FF40
MOV DWORD PTR [ESP], ECX
MOV ECX, 0X7B                                                             ; ECX=0000007B
PUSH ECX                                                                  ; ESP=0018FF3C
ADD DWORD PTR [ESP], 0X2A03378C
POP EBX                                                                   ; EBX=2A033807, ESP=0018FF40
SUB EBX, 0X2A03378C                                                       ; EBX=0000007B
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF3C
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=00000001
PUSH ESI                                                                  ; ESP=0018FF38
MOV ESI, ESP                                                              ; ESI=0018FF38
ADD ESI, 4                                                                ; ESI=0018FF3C
ADD ESI, 4                                                                ; ESI=0018FF40
XCHG DWORD PTR [ESP], ESI                                                 ; ESI=00000000
POP ESP                                                                   ; ESP=0018FF40
SUB ESP, 4                                                                ; ESP=0018FF3C
MOV DWORD PTR [ESP], EDI
PUSH ESP                                                                  ; ESP=0018FF38
POP EDI                                                                   ; ESP=0018FF3C, EDI=0018FF3C
PUSH ESI                                                                  ; ESP=0018FF38
MOV ESI, 4                                                                ; ESI=00000004
ADD EDI, ESI                                                              ; EDI=0018FF40
POP ESI                                                                   ; ESP=0018FF3C, ESI=00000000
PUSH ESI                                                                  ; ESP=0018FF38
MOV ESI, 4                                                                ; ESI=00000004
ADD EDI, 0X4FB27D95                                                       ; EDI=4FCB7CD5
ADD EDI, 0X45C4539C                                                       ; EDI=958FD071
ADD EDI, ESI                                                              ; EDI=958FD075
SUB EDI, 0X45C4539C                                                       ; EDI=4FCB7CD9
SUB EDI, 0X4FB27D95                                                       ; EDI=0018FF44
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=00000000
ADD ESP, 4                                                                ; ESP=0018FF3C
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF44
XOR EAX, EAX
LOCK CMPXCHG PTR [EBX + EBP], ECX                                   ; LOCK prefix
JE 0X9978E1
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF3C
POP ECX                                                                   ; ECX=00400000, ESP=0018FF40
PUSH EDI                                                                  ; ESP=0018FF3C
MOV EDI, ESP                                                              ; EDI=0018FF3C
ADD EDI, 4                                                                ; EDI=0018FF40
SUB EDI, 4                                                                ; EDI=0018FF3C
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
POP ESP                                                                   ; kernel32.75EC336A
MOV DWORD PTR [ESP], EBX
MOV EBX, ESP                                                              ; EBX=0018FF3C
ADD EBX, 4                                                                ; EBX=0018FF40
ADD EBX, 4                                                                ; EBX=0018FF44
XCHG DWORD PTR [ESP], EBX                                                 ; EBX=0000007B
POP ESP                                                                   ; ESP=0018FF44
PUSH ESI                                                                  ; ESP=0018FF40
PUSH ESP                                                                  ; ESP=0018FF3C
POP ESI                                                                   ; ESP=0018FF40, ESI=0018FF40
ADD ESI, 4                                                                ; ESI=0018FF44
PUSH EAX                                                                  ; ESP=0018FF3C
MOV EAX, 4                                                                ; EAX=00000004
SUB ESI, 0XD056831                                                        ; ESI=F3139713
SUB ESI, 0X1C3F0F8A                                                       ; ESI=D6D48789
ADD ESI, EAX                                                              ; ESI=D6D4878D
ADD ESI, 0X1C3F0F8A                                                       ; ESI=F3139717
ADD ESI, 0XD056831                                                        ; ESI=0018FF48
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
PUSH ECX                                                                  ; ESP=0018FF38
MOV ECX, ESP                                                              ; ECX=0018FF38
ADD ECX, 4                                                                ; ECX=0018FF3C
PUSH EDX                                                                  ; ESP=0018FF34
MOV EDX, 4                                                                ; EDX=00000004
ADD ECX, EDX                                                              ; ECX=0018FF40
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF38
XCHG DWORD PTR [ESP], ECX                                                 ; ECX=00400000
POP ESP                                                                   ; ESP=0018FF40
PUSH ESI                                                                  ; ESP=0018FF3C
PUSH DWORD PTR [ESP + 4]                                                  ; ESP=0018FF38
POP ESI                                                                   ; ESP=0018FF3C, ESI=00000000
POP DWORD PTR [ESP]                                                       ; ESP=0018FF40
POP ESP                                                                   ; ESP=0018FF48
SUB ESP, 4                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], EDI
PUSH 0X336E3281                                                           ; ESP=0018FF40
POP EDI                                                                   ; ESP=0018FF44, EDI=336E3281
PUSH ECX                                                                  ; ESP=0018FF40
MOV ECX, 0X39C37A16                                                       ; ECX=39C37A16
DEC ECX                                                                   ; ECX=39C37A15
PUSH EAX                                                                  ; ESP=0018FF3C
MOV EAX, 0X31A733C9                                                       ; EAX=31A733C9
PUSH EBP                                                                  ; ESP=0018FF38
MOV EBP, 0X38620025                                                       ; EBP=38620025
PUSH EDX                                                                  ; ESP=0018FF34
MOV EDX, 0X6B664DC3                                                       ; EDX=6B664DC3
XOR EBP, EDX                                                              ; EBP=53044DE6
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF38
AND EBP, 0X51796D1E                                                       ; EBP=51004D06
INC EBP                                                                   ; EBP=51004D07
SHR EBP, 4                                                                ; EBP=051004D0
NOT EBP                                                                   ; EBP=FAEFFB2F
XOR EBP, 0X8E19ACF8                                                       ; EBP=74F657D7
AND EAX, EBP                                                              ; EAX=30A613C1
MOV EBP, DWORD PTR [ESP]                                                  ; EBP=00859925
ADD ESP, 4                                                                ; ESP=0018FF3C
XOR EAX, 0X402B6ECA                                                       ; EAX=708D7D0B
SUB ECX, EAX                                                              ; ECX=C935FD0A
POP EAX                                                                   ; EAX=00000000, ESP=0018FF40
ADD ECX, 0X5814F4E                                                        ; ECX=CEB74C58
ADD ECX, 0X570325D9                                                       ; ECX=25BA7231
ADD ECX, 0X22D228C7                                                       ; ECX=488C9AF8
OR ECX, 0X48FF5BB4                                                        ; ECX=48FFDBFC
ADD ECX, 1                                                                ; ECX=48FFDBFD
ADD ECX, 0XB8D0616                                                        ; ECX=548CE213
PUSH EDX                                                                  ; ESP=0018FF3C
MOV EDX, 0X555E7E80                                                       ; EDX=555E7E80
PUSH EBP                                                                  ; ESP=0018FF38
MOV EBP, 0X31F67982                                                       ; EBP=31F67982
OR EDX, EBP                                                               ; EDX=75FE7F82
POP EBP                                                                   ; ESP=0018FF3C, EBP=00859925
NOT EDX                                                                   ; EDX=8A01807D
AND EDX, 0X37D84EB2                                                       ; EDX=02000030
INC EDX                                                                   ; EDX=02000031
ADD EDX, 0X7604EB77                                                       ; EDX=7804EBA8
ADD ECX, 0X2FF539AA                                                       ; ECX=84821BBD
ADD ECX, EDX                                                              ; ECX=FC870765
SUB ECX, 0X2FF539AA                                                       ; ECX=CC91CDBB
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF40
ADD EDI, 0X6A791142                                                       ; EDI=9DE743C3
ADD EDI, ECX                                                              ; EDI=6A79117E
SUB EDI, 0X6A791142                                                       ; EDI=0000003C
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF3C
POP ECX                                                                   ; ECX=00400000, ESP=0018FF40
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH EDI                                                                  ; ESP=0018FF40
POP EBX                                                                   ; EBX=0000003C, ESP=0018FF44
POP EDI                                                                   ; ESP=0018FF48, EDI=00000000
PUSH 0X4B13                                                               ; ESP=0018FF44
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH ESP                                                                  ; ESP=0018FF40
MOV EDX, DWORD PTR [ESP]                                                  ; EDX=0018FF44
ADD ESP, 4                                                                ; ESP=0018FF44
ADD EDX, 4                                                                ; EDX=0018FF48
PUSH EBX                                                                  ; ESP=0018FF40
MOV EBX, ESP                                                              ; EBX=0018FF40
ADD EBX, 4                                                                ; EBX=0018FF44
PUSH EBP                                                                  ; ESP=0018FF3C
MOV EBP, 4                                                                ; EBP=00000004
SUB EBX, EBP                                                              ; EBX=0018FF40
POP EBP                                                                   ; ESP=0018FF40, EBP=00859925
XOR EBX, DWORD PTR [ESP]                                                  ; EBX=0018FF7C
XOR DWORD PTR [ESP], EBX
XOR EBX, DWORD PTR [ESP]                                                  ; EBX=0000003C
POP ESP                                                                   ; kernel32.75EC336A
MOV DWORD PTR [ESP], EBX
MOV EBX, 0X6D71107E                                                       ; EBX=6D71107E
PUSH EDX                                                                  ; ESP=0018FF3C
MOV EDX, 0X928EEF86                                                       ; EDX=928EEF86
ADD EBX, EDX                                                              ; EBX=00000004
POP EDX                                                                   ; EDX=0018FF48, ESP=0018FF40
SUB EDX, 0X227C2DF8                                                       ; EDX=DD9CD150
SUB EDX, EBX                                                              ; EDX=DD9CD14C
ADD EDX, 0X227C2DF8                                                       ; EDX=0018FF44
POP EBX                                                                   ; EBX=0000003C, ESP=0018FF44
PUSH EDX                                                                  ; ESP=0018FF40
PUSH DWORD PTR [ESP + 4]                                                  ; ESP=0018FF3C
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF40
POP DWORD PTR [ESP]                                                       ; ESP=0018FF44
MOV ESP, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
MOV DWORD PTR [ESP], ECX
POP DWORD PTR [EBX + EBP]                                                 ; ESP=0018FF48
PUSH 0X53EC                                                               ; ESP=0018FF44
MOV DWORD PTR [ESP], EDI
MOV EDI, ESP                                                              ; EDI=0018FF44
ADD EDI, 4                                                                ; EDI=0018FF48
SUB EDI, 4                                                                ; EDI=0018FF44
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
POP ESP                                                                   ; kernel32.75EC336A
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH ESI                                                                  ; ESP=0018FF40
PUSH 0X7CFA0916                                                           ; ESP=0018FF3C
POP ESI                                                                   ; ESP=0018FF40, ESI=7CFA0916
NEG ESI                                                                   ; ESI=8305F6EA
PUSH 0X4CA5                                                               ; ESP=0018FF3C
MOV DWORD PTR [ESP], EBP
MOV EBP, 0X8305F6CD                                                       ; EBP=8305F6CD
XOR ESI, EBP                                                              ; ESI=00000027
POP EBP                                                                   ; ESP=0018FF40, EBP=00859925
MOV EDX, ESI                                                              ; EDX=00000027
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=00000000
SUB ESP, 4                                                                ; ESP=0018FF3C
MOV DWORD PTR [ESP], EAX
PUSH ESP                                                                  ; ESP=0018FF38
POP EAX                                                                   ; EAX=0018FF3C, ESP=0018FF3C
ADD EAX, 4                                                                ; EAX=0018FF40
PUSH EDX                                                                  ; ESP=0018FF38
MOV EDX, 0X55E179F1                                                       ; EDX=55E179F1
DEC EDX                                                                   ; EDX=55E179F0
NOT EDX                                                                   ; EDX=AA1E860F
OR EDX, 0X69910329                                                        ; EDX=EB9F872F
XOR EDX, 0XEB9F872B                                                       ; EDX=00000004
ADD EAX, EDX                                                              ; EAX=0018FF44
POP EDX                                                                   ; EDX=00000027, ESP=0018FF3C
XOR EAX, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
XOR DWORD PTR [ESP], EAX
XOR EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF44
MOV EBX, EDX                                                              ; EBX=00000027
MOV EDX, DWORD PTR [ESP]                                                  ; EDX=024C1600
ADD ESP, 4                                                                ; ESP=0018FF48
PUSH EDX                                                                  ; ESP=0018FF44
MOV EDX, 0XB0A2234                                                        ; EDX=0B0A2234
PUSH EBX                                                                  ; ESP=0018FF40
MOV EBX, 0X21875F46                                                       ; EBX=21875F46
OR EDX, EBX                                                               ; EDX=2B8F7F76
MOV EBX, DWORD PTR [ESP]                                                  ; EBX=00000027
ADD ESP, 4                                                                ; ESP=0018FF44
SHL EDX, 4                                                                ; EDX=B8F7F760
PUSH ECX                                                                  ; ESP=0018FF40
MOV DWORD PTR [ESP], EBP
MOV EBP, 0X72E83DF9                                                       ; EBP=72E83DF9
PUSH 0X19F6                                                               ; ESP=0018FF3C
MOV DWORD PTR [ESP], EDI
PUSH ESI                                                                  ; ESP=0018FF38
PUSH 0X1C26052E                                                           ; ESP=0018FF34
POP ESI                                                                   ; ESP=0018FF38, ESI=1C26052E
PUSH EBX                                                                  ; ESP=0018FF34
MOV EBX, 0X379E3C5C                                                       ; EBX=379E3C5C
MOV EDI, 0X509DB745                                                       ; EDI=509DB745
SUB EDI, EBX                                                              ; EDI=18FF7AE9
POP EBX                                                                   ; EBX=00000027, ESP=0018FF38
XOR EDI, ESI                                                              ; EDI=04D97FC7
POP ESI                                                                   ; ESP=0018FF3C, ESI=00000000
XCHG EDI, ECX                                                             ; ECX=04D97FC7, EDI=00400000
NOT ECX                                                                   ; ECX=FB268038
XCHG EDI, ECX                                                             ; ECX=00400000, EDI=FB268038
NEG EDI                                                                   ; EDI=04D97FC8
AND EDI, 0X64924E76                                                       ; EDI=04904E40
PUSH EAX                                                                  ; ESP=0018FF38
MOV EAX, 0X2E871B99                                                       ; EAX=2E871B99
ADD EAX, 0X77F92E77                                                       ; EAX=A6804A10
XOR EAX, 0XB2361C59                                                       ; EAX=14B65649
SUB EDI, EAX                                                              ; EDI=EFD9F7F7
POP EAX                                                                   ; EAX=00000000, ESP=0018FF3C
XOR EDI, 0X31E218A                                                        ; EDI=ECC7D67D
ADD EDI, 0X4B173B86                                                       ; EDI=37DF1203
SUB EBP, EDI                                                              ; EBP=3B092BF6
POP EDI                                                                   ; ESP=0018FF40, EDI=00000000
PUSH EDX                                                                  ; ESP=0018FF3C
MOV EDX, 0X741A351C                                                       ; EDX=741A351C
OR EBP, EDX                                                               ; EBP=7F1B3FFE
POP EDX                                                                   ; EDX=B8F7F760, ESP=0018FF40
XOR EBP, 0X14DF7020                                                       ; EBP=6BC44FDE
AND EDX, EBP                                                              ; EDX=28C44740
POP EBP                                                                   ; ESP=0018FF44, EBP=00859925
XOR EDX, 0X28844740                                                       ; EDX=00400000
PUSH EAX                                                                  ; ESP=0018FF40
MOV EAX, EBX                                                              ; EAX=00000027
PUSH EDI                                                                  ; ESP=0018FF3C
MOV EDI, 0X43513EC9                                                       ; EDI=43513EC9
OR EDI, 0XBD33796                                                         ; EDI=4BD33FDF
DEC EDI                                                                   ; EDI=4BD33FDE
NEG EDI                                                                   ; EDI=B42CC022
DEC EDI                                                                   ; EDI=B42CC021
ADD EDI, 0X4BD33FDF                                                       ; EDI=00000000
ADD EAX, EDI
POP EDI                                                                   ; ESP=0018FF40
ADD EAX, EBP                                                              ; EAX=0085994C
MOV DWORD PTR [EAX], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00000000
ADD ESP, 4                                                                ; ESP=0018FF44
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF48
PUSH EDX                                                                  ; ESP=0018FF44
PUSH EBP                                                                  ; ESP=0018FF40
MOV EBP, 0X2DE16D1A                                                       ; EBP=2DE16D1A
PUSH EBP                                                                  ; ESP=0018FF3C
POP EDX                                                                   ; EDX=2DE16D1A, ESP=0018FF40
POP EBP                                                                   ; ESP=0018FF44, EBP=00859925
PUSH EDI                                                                  ; ESP=0018FF40
MOV EDI, 0X264859C5                                                       ; EDI=264859C5
NOT EDI                                                                   ; EDI=D9B7A63A
XCHG EDI, ECX                                                             ; ECX=D9B7A63A, EDI=00400000
PUSH ECX                                                                  ; ESP=0018FF3C
NOT DWORD PTR [ESP]                                                       ; kernel32.75EC336A
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=264859C5
ADD ESP, 4                                                                ; ESP=0018FF40
XCHG EDI, ECX                                                             ; ECX=00400000, EDI=264859C5
XOR EDI, 0XBA934A0                                                        ; EDI=2DE16D65
SUB ESP, 4                                                                ; ESP=0018FF3C
MOV DWORD PTR [ESP], EBP
MOV EBP, EDI                                                              ; EBP=2DE16D65
PUSH EBP                                                                  ; ESP=0018FF38
POP EBX                                                                   ; EBX=2DE16D65, ESP=0018FF3C
POP EBP                                                                   ; ESP=0018FF40, EBP=00859925
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF3C
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
ADD ESP, 4                                                                ; ESP=0018FF40
PUSH EDI                                                                  ; ESP=0018FF3C
PUSH ESP                                                                  ; ESP=0018FF38
POP EDI                                                                   ; ESP=0018FF3C, EDI=0018FF3C
ADD EDI, 4                                                                ; EDI=0018FF40
ADD EDI, 4                                                                ; EDI=0018FF44
XCHG DWORD PTR [ESP], EDI                                                 ; EDI=00000000
POP ESP                                                                   ; ESP=0018FF44
XOR EBX, EDX                                                              ; EBX=0000007F
MOV EDX, DWORD PTR [ESP]                                                  ; EDX=024C1600
ADD ESP, 4                                                                ; ESP=0018FF48
PUSH DWORD PTR [ESP + 0X28]                                               ; ESP=0018FF44
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=00F8C029
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH 0X2972                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], EDI
MOV EDI, ESP                                                              ; EDI=0018FF40
ADD EDI, 4                                                                ; EDI=0018FF44
PUSH 0X6663                                                               ; ESP=0018FF3C
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV EDX, ESP                                                              ; EDX=0018FF3C
ADD EDX, 4                                                                ; EDX=0018FF40
SUB EDX, 4                                                                ; EDX=0018FF3C
XCHG DWORD PTR [ESP], EDX                                                 ; EDX=024C1600
POP ESP                                                                   ; kernel32.75EC336A
MOV DWORD PTR [ESP], EBX
PUSH EDX                                                                  ; ESP=0018FF38
MOV EDX, 0X582059A8                                                       ; EDX=582059A8
DEC EDX                                                                   ; EDX=582059A7
INC EDX                                                                   ; EDX=582059A8
XOR EDX, 0X16D4096E                                                       ; EDX=4EF450C6
PUSH EBX                                                                  ; ESP=0018FF34
MOV EBX, 0X4BE5625E                                                       ; EBX=4BE5625E
ADD EDX, EBX                                                              ; EDX=9AD9B324
POP EBX                                                                   ; EBX=0000007F, ESP=0018FF38
ADD EDX, 0X65264CE0                                                       ; EDX=00000004
MOV EBX, EDX                                                              ; EBX=00000004
MOV EDX, DWORD PTR [ESP]                                                  ; EDX=024C1600
ADD ESP, 4                                                                ; ESP=0018FF3C
ADD EDI, EBX                                                              ; EDI=0018FF48
MOV EBX, DWORD PTR [ESP]                                                  ; EBX=0000007F
ADD ESP, 4                                                                ; ESP=0018FF40
XOR EDI, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
XOR DWORD PTR [ESP], EDI
XOR EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF48
SUB ESP, 4                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH EBP                                                                  ; ESP=0018FF40
MOV EBP, 0X44D86B12                                                       ; EBP=44D86B12
ADD EBP, 0XFFC8AE93                                                       ; EBP=44A119A5
MOV EDX, EBP                                                              ; EDX=44A119A5
POP EBP                                                                   ; ESP=0018FF44, EBP=00859925
PUSH EBX                                                                  ; ESP=0018FF40
MOV EBX, 0X18BC3186                                                       ; EBX=18BC3186
ADD EAX, EBX                                                              ; EAX=19B4F1AF
POP EBX                                                                   ; EBX=0000007F, ESP=0018FF44
SUB EAX, EDX                                                              ; EAX=D513D80A
SUB EAX, 0X18BC3186                                                       ; EAX=BC57A684
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF48
ADD EAX, ECX                                                              ; EAX=BC97A684
PUSH ECX                                                                  ; ESP=0018FF44
PUSH EAX                                                                  ; ESP=0018FF40
MOV EAX, 0X19136925                                                       ; EAX=19136925
MOV ECX, EAX                                                              ; ECX=19136925
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=BC97A684
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH ECX                                                                  ; ESP=0018FF40
NOT DWORD PTR [ESP]                                                       ; kernel32.75EC336A
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF3C
POP ECX                                                                   ; ECX=E6EC96DA, ESP=0018FF40
ADD ESP, 4                                                                ; ESP=0018FF44
SHR ECX, 5                                                                ; ECX=073764B6
ADD ECX, 0X3D69B4EF                                                       ; ECX=44A119A5
PUSH EDI                                                                  ; ESP=0018FF40
PUSH EBX                                                                  ; ESP=0018FF3C
PUSH 0X7B17224                                                            ; ESP=0018FF38
POP EBX                                                                   ; EBX=07B17224, ESP=0018FF3C
DEC EBX                                                                   ; EBX=07B17223
SHR EBX, 2                                                                ; EBX=01EC5C88
ADD EBX, 0X10C32170                                                       ; EBX=12AF7DF8
SUB EBX, 0XADAA3F68                                                       ; EBX=65053E90
MOV EDI, EBX                                                              ; EDI=65053E90
POP EBX                                                                   ; EBX=0000007F, ESP=0018FF40
ADD EAX, EDI                                                              ; EAX=219CE514
POP EDI                                                                   ; ESP=0018FF44, EDI=00000000
ADD EAX, ECX                                                              ; EAX=663DFEB9
PUSH EDI                                                                  ; ESP=0018FF40
MOV EDI, 0X3B4C2947                                                       ; EDI=3B4C2947
SHL EDI, 6                                                                ; EDI=D30A51C0
SUB EDI, 0X1DF62E0C                                                       ; EDI=B51423B4
AND EDI, 0X2CDF176A                                                       ; EDI=24140320
XOR EDI, 0X41113DB0                                                       ; EDI=65053E90
SUB EAX, EDI                                                              ; EAX=0138C029
POP EDI                                                                   ; ESP=0018FF44, EDI=00000000
POP ECX                                                                   ; ECX=00400000, ESP=0018FF48
PUSH 0X74B                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], ECX
PUSH EAX                                                                  ; ESP=0018FF40
PUSH EDI                                                                  ; ESP=0018FF3C
MOV EDI, 0X36097A2C                                                       ; EDI=36097A2C
PUSH EBP                                                                  ; ESP=0018FF38
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
MOV EDX, 0X2F4C37DD                                                       ; EDX=2F4C37DD
ADD DWORD PTR [ESP + 8], EDX                                              ; Portable.<ModuleEntryPoint>
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF3C
ADD DWORD PTR [ESP + 4], EDI
SUB DWORD PTR [ESP + 4], 0X2F4C37DD
POP EDI                                                                   ; ESP=0018FF40, EDI=00000000
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=37423A55
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH 0X6EFC                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], EBX
MOV EBX, 0X36097A2C                                                       ; EBX=36097A2C
ADD ECX, 0X53E97757                                                       ; ECX=8B2BB1AC
SUB ECX, EBX                                                              ; ECX=55223780
PUSH ESI                                                                  ; ESP=0018FF3C
MOV ESI, 0X1406566                                                        ; ESI=01406566
DEC ESI                                                                   ; ESI=01406565
NOT ESI                                                                   ; ESI=FEBF9A9A
ADD ESI, 0X6000149A                                                       ; ESI=5EBFAF34
NOT ESI                                                                   ; ESI=A14050CB
PUSH ECX                                                                  ; ESP=0018FF38
MOV ECX, 0X4D56D974                                                       ; ECX=4D56D974
SUB ESI, ECX                                                              ; ESI=53E97757
POP ECX                                                                   ; ECX=55223780, ESP=0018FF3C
SUB ECX, ESI                                                              ; ECX=0138C029
POP ESI                                                                   ; ESP=0018FF40, ESI=00000000
MOV EBX, DWORD PTR [ESP]                                                  ; EBX=0000007F
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH ECX                                                                  ; ESP=0018FF40
SUB DWORD PTR [ESP], 0X5C842756
POP DWORD PTR [EBX + EBP]                                                 ; ESP=0018FF44
PUSH EAX                                                                  ; ESP=0018FF40
MOV EAX, EBX                                                              ; EAX=0000007F
ADD EAX, 0
ADD EAX, EBP                                                              ; EAX=008599A4
ADD DWORD PTR [EAX], 0X5C842756
POP EAX                                                                   ; EAX=0138C029, ESP=0018FF44
POP ECX                                                                   ; ECX=00400000, ESP=0018FF48
SUB ESP, 4                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH 0X10331DA1                                                           ; ESP=0018FF40
MOV EDX, DWORD PTR [ESP]                                                  ; EDX=10331DA1
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH ESI                                                                  ; ESP=0018FF40
MOV DWORD PTR [ESP], ECX
MOV ECX, 0X17CB3F77                                                       ; ECX=17CB3F77
PUSH EDX                                                                  ; ESP=0018FF3C
MOV DWORD PTR [ESP], EAX
MOV EAX, 0X7F06638B                                                       ; EAX=7F06638B
AND ECX, EAX                                                              ; ECX=17022303
POP EAX                                                                   ; EAX=0138C029, ESP=0018FF40
XOR ECX, 0X24324A4A                                                       ; ECX=33306949
SHR ECX, 4                                                                ; ECX=03330694
PUSH EDX                                                                  ; ESP=0018FF3C
MOV EDX, 0XF8CAF14E                                                       ; EDX=F8CAF14E
SUB ECX, EDX                                                              ; ECX=0A681546
POP EDX                                                                   ; EDX=10331DA1, ESP=0018FF40
OR EDX, ECX                                                               ; EDX=1A7B1DE7
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=00400000
ADD ESP, 4                                                                ; ESP=0018FF44
SHR EDX, 1                                                                ; EDX=0D3D8EF3
SUB EDX, 0X25795703                                                       ; EDX=E7C437F0
PUSH EDI                                                                  ; ESP=0018FF40
MOV EDI, 0X18952757                                                       ; EDI=18952757
ADD EDX, EDI                                                              ; EDX=00595F47
POP EDI                                                                   ; ESP=0018FF44, EDI=00000000
PUSH 0X5174                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
SUB DWORD PTR [ESP], 0X2874478
MOV EAX, DWORD PTR [ESP]                                                  ; EAX=FDD21ACF
PUSH EBX                                                                  ; ESP=0018FF3C
MOV EBX, ESP                                                              ; EBX=0018FF3C
ADD EBX, 4                                                                ; EBX=0018FF40
ADD EBX, 4                                                                ; EBX=0018FF44
XCHG DWORD PTR [ESP], EBX                                                 ; EBX=0000007F
POP ESP                                                                   ; ESP=0018FF44
PUSH EDI                                                                  ; ESP=0018FF40
PUSH EBX                                                                  ; ESP=0018FF3C
MOV EBX, 0X7974026E                                                       ; EBX=7974026E
MOV EDI, EBX                                                              ; EDI=7974026E
POP EBX                                                                   ; EBX=0000007F, ESP=0018FF40
AND EDI, 0X7E296F63                                                       ; EDI=78200262
ADD EDI, 0X8A674216                                                       ; EDI=02874478
ADD EAX, EDI                                                              ; EAX=00595F47
POP EDI                                                                   ; ESP=0018FF44, EDI=00000000
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF48
SUB ESP, 4                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], EDI
PUSH 0X38CF                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], EBP
MOV EBP, 0X1CA1536F                                                       ; EBP=1CA1536F
PUSH EAX                                                                  ; ESP=0018FF3C
MOV EAX, 0X5FBC5D66                                                       ; EAX=5FBC5D66
OR EBP, EAX                                                               ; EBP=5FBD5F6F
POP EAX                                                                   ; EAX=00595F47, ESP=0018FF40
PUSH ESI                                                                  ; ESP=0018FF3C
MOV ESI, 0X41D97634                                                       ; ESI=41D97634
AND ESI, 0X3FE338D3                                                       ; ESI=01C13010
SHL ESI, 4                                                                ; ESI=1C130100
SHR ESI, 5                                                                ; ESI=00E09808
INC ESI                                                                   ; ESI=00E09809
XOR ESI, 0XF7424644                                                       ; ESI=F7A2DE4D
ADD EBP, ESI                                                              ; EBP=57603DBC
POP ESI                                                                   ; ESP=0018FF40, ESI=00000000
MOV EDI, EBP                                                              ; EDI=57603DBC
POP EBP                                                                   ; ESP=0018FF44, EBP=00859925
ADD EAX, 0X386D578E                                                       ; EAX=38C6B6D5
ADD EAX, EDI                                                              ; EAX=9026F491
SUB EAX, 0X386D578E                                                       ; EAX=57B99D03
POP EDI                                                                   ; ESP=0018FF48, EDI=00000000
PUSH EDI                                                                  ; ESP=0018FF44
PUSH 0X4E564A3B                                                           ; ESP=0018FF40
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=4E564A3B
ADD ESP, 4                                                                ; ESP=0018FF44
SHR EDI, 1                                                                ; EDI=272B251D
ADD EDI, 0X57E10CDD                                                       ; EDI=7F0C31FA
XOR EDI, 0X3E8B00D3                                                       ; EDI=41873129
AND EDI, 0X10D504D3                                                       ; EDI=00850001
SUB EDI, 0XD439E965                                                       ; EDI=2C4B169C
SUB EAX, EDI                                                              ; EAX=2B6E8667
POP EDI                                                                   ; ESP=0018FF48, EDI=00000000
ADD EAX, ECX                                                              ; EAX=2BAE8667
ADD EAX, 0X2C4B169C                                                       ; EAX=57F99D03
PUSH EDI                                                                  ; ESP=0018FF44
MOV DWORD PTR [ESP], EDX                                                  ; Portable.<ModuleEntryPoint>
PUSH 0X57603DBC                                                           ; ESP=0018FF40
POP EDX                                                                   ; EDX=57603DBC, ESP=0018FF44
SUB EAX, 0X6FBF289E                                                       ; EAX=E83A7465
SUB EAX, EDX                                                              ; EAX=90DA36A9
ADD EAX, 0X6FBF289E                                                       ; EAX=00995F47
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF48
SUB ESP, 4                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], ESI
MOV ESI, 0X62DF12CB                                                       ; ESI=62DF12CB
PUSH 0X7734                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], ESI
MOV ESI, 0X30476980                                                       ; ESI=30476980
SUB ESI, 0X93267BC4                                                       ; ESI=9D20EDBC
MOV EBX, ESI                                                              ; EBX=9D20EDBC
MOV ESI, DWORD PTR [ESP]                                                  ; ESI=62DF12CB
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH EDX                                                                  ; ESP=0018FF40
MOV DWORD PTR [ESP], EAX
PUSH 0X2E336DC1                                                           ; ESP=0018FF3C
POP EAX                                                                   ; EAX=2E336DC1, ESP=0018FF40
ADD EBX, 0X727C7057                                                       ; EBX=0F9D5E13
SUB EBX, EAX                                                              ; EBX=E169F052
PUSH ECX                                                                  ; ESP=0018FF3C
MOV ECX, 0X70EF454F                                                       ; ECX=70EF454F
SHR ECX, 3                                                                ; ECX=0E1DE8A9
AND ECX, 0X737714D9                                                       ; ECX=02150089
SUB ECX, 0X8F989032                                                       ; ECX=727C7057
SUB EBX, ECX                                                              ; EBX=6EED7FFB
POP ECX                                                                   ; ECX=00400000, ESP=0018FF40
POP EAX                                                                   ; EAX=00995F47, ESP=0018FF44
PUSH EDI                                                                  ; ESP=0018FF40
MOV EDI, 0X4D2F256D                                                       ; EDI=4D2F256D
ADD EBX, EDI                                                              ; EBX=BC1CA568
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
ADD ESP, 4                                                                ; ESP=0018FF44
ADD EBX, ESI                                                              ; EBX=1EFBB833
SUB EBX, 0X4D2F256D                                                       ; EBX=D1CC92C6
PUSH EDX                                                                  ; ESP=0018FF40
MOV EDX, 0X36303B21                                                       ; EDX=36303B21
INC EDX                                                                   ; EDX=36303B22
SUB EDX, 0X7FCCD61                                                        ; EDX=2E336DC1
ADD EBX, EDX                                                              ; EBX=00000087
POP EDX                                                                   ; EDX=024C1600, ESP=0018FF44
POP ESI                                                                   ; ESP=0018FF48, ESI=00000000
PUSH DWORD PTR [EBX + EBP]                                                ; ESP=0018FF44
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
MOV EDX, DWORD PTR [ESP]                                                  ; EDX=00995F47
ADD ESP, 4                                                                ; ESP=0018FF44
PUSH 0X4C73                                                               ; ESP=0018FF40
MOV DWORD PTR [ESP], EDI
MOV EDI, ESP                                                              ; EDI=0018FF40
PUSH EBP                                                                  ; ESP=0018FF3C
MOV DWORD PTR [ESP], ESI
PUSH 4                                                                    ; ESP=0018FF38
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF34
POP ESI                                                                   ; ESP=0018FF38, ESI=00000004
ADD ESP, 4                                                                ; ESP=0018FF3C
ADD EDI, 0X625D2AC4                                                       ; EDI=62762A04
ADD EDI, ESI                                                              ; EDI=62762A08
PUSH ESI                                                                  ; ESP=0018FF38
MOV ESI, 0X625D2AC4                                                       ; ESI=625D2AC4
SUB EDI, ESI                                                              ; EDI=0018FF44
POP ESI                                                                   ; ESP=0018FF3C, ESI=00000004
POP ESI                                                                   ; ESP=0018FF40, ESI=00000000
ADD EDI, 4                                                                ; EDI=0018FF48
PUSH EDI                                                                  ; ESP=0018FF3C
PUSH DWORD PTR [ESP + 4]                                                  ; ESP=0018FF38
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
ADD ESP, 4                                                                ; ESP=0018FF3C
POP DWORD PTR [ESP]                                                       ; ESP=0018FF40
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF48
CMP EDX, EAX
JE 0X9982DE
PUSH DWORD PTR [ESP + 0X24]                                               ; ESP=0018FF44
PUSH DWORD PTR [ESP]                                                      ; ESP=0018FF40
POP EBX                                                                   ; EBX=00000476, ESP=0018FF44
PUSH EBX                                                                  ; ESP=0018FF40
MOV EBX, ESP                                                              ; EBX=0018FF40
ADD EBX, 4                                                                ; EBX=0018FF44
PUSH EBP                                                                  ; ESP=0018FF3C
MOV DWORD PTR [ESP], ECX
MOV ECX, 4                                                                ; ECX=00000004
SUB EBX, ECX                                                              ; EBX=0018FF40
MOV ECX, DWORD PTR [ESP]                                                  ; ECX=00400000
ADD ESP, 4                                                                ; ESP=0018FF40
XCHG DWORD PTR [ESP], EBX                                                 ; EBX=00000476
MOV ESP, DWORD PTR [ESP]                                                  ; kernel32.75EC336A
MOV DWORD PTR [ESP], ECX
MOV ECX, ESP                                                              ; ECX=0018FF40
PUSH EBP                                                                  ; ESP=0018FF3C
MOV EBP, 4                                                                ; EBP=00000004
ADD ECX, EBP                                                              ; ECX=0018FF44
POP EBP                                                                   ; ESP=0018FF40, EBP=00859925
PUSH EAX                                                                  ; ESP=0018FF3C
PUSH ESI                                                                  ; ESP=0018FF38
PUSH 0X2F1118C5                                                           ; ESP=0018FF34
POP ESI                                                                   ; ESP=0018FF38, ESI=2F1118C5
PUSH ECX                                                                  ; ESP=0018FF34
MOV ECX, 0X2F1118C1                                                       ; ECX=2F1118C1
XOR ESI, ECX                                                              ; ESI=00000004
POP ECX                                                                   ; ECX=0018FF44, ESP=0018FF38
MOV EAX, ESI                                                              ; EAX=00000004
POP ESI                                                                   ; ESP=0018FF3C, ESI=00000000
ADD ECX, EAX                                                              ; ECX=0018FF48
POP EAX                                                                   ; EAX=00995F47, ESP=0018FF40
XOR ECX, DWORD PTR [ESP]                                                  ; ECX=0058FF48
XOR DWORD PTR [ESP], ECX
XOR ECX, DWORD PTR [ESP]                                                  ; ECX=00400000
MOV ESP, DWORD PTR [ESP]                                                  ; ESP=0018FF48
SHL EBX, 2                                                                ; EBX=000011D8
PUSH EBX                                                                  ; ESP=0018FF44
MOV EBX, 0X29513E00                                                       ; EBX=29513E00
PUSH EDX                                                                  ; ESP=0018FF40
MOV DWORD PTR [ESP], EAX
MOV EAX, 0X6C2D5D30                                                       ; EAX=6C2D5D30
NEG EAX                                                                   ; EAX=93D2A2D0
INC EAX                                                                   ; EAX=93D2A2D1
PUSH EBP                                                                  ; ESP=0018FF3C
MOV EBP, 0XAF60664A                                                       ; EBP=AF60664A
ADD EAX, EBP                                                              ; EAX=4333091B
POP EBP                                                                   ; ESP=0018FF40, EBP=00859925
ADD EBX, EAX                                                              ; EBX=6C84471B
POP EAX                                                                   ; EAX=00995F47, ESP=0018FF44
SUB EAX, EBX                                                              ; EAX=9415182C
POP EBX                                                                   ; EBX=000011D8, ESP=0018FF48
ADD EAX, 0X64052F7                                                        ; EAX=9A556B23
PUSH EBP                                                                  ; ESP=0018FF44
MOV EBP, 0X59CF0B55                                                       ; EBP=59CF0B55
SHL EBP, 3                                                                ; EBP=CE785AA8
SHL EBP, 1                                                                ; EBP=9CF0B550
DEC EBP                                                                   ; EBP=9CF0B54F
INC EBP                                                                   ; EBP=9CF0B550
SUB EBP, 0X8CCF67C5                                                       ; EBP=10214D8B
SUB EAX, EBP                                                              ; EAX=8A341D98
POP EBP                                                                   ; ESP=0018FF48, EBP=00859925
ADD EAX, 0X25B928AB                                                       ; EAX=AFED4643
ADD EAX, EBX                                                              ; EAX=AFED581B
PUSH ECX                                                                  ; ESP=0018FF44
MOV ECX, 0X342B55BE                                                       ; ECX=342B55BE
SUB ECX, 0X4C724072                                                       ; ECX=E7B9154C
XOR ECX, 0X27934E1D                                                       ; ECX=C02A5B51
ADD ECX, 0X13927DB9                                                       ; ECX=D3BCD90A
INC ECX                                                                   ; ECX=D3BCD90B
XOR ECX, 0X1F51694F                                                       ; ECX=CCEDB044
XOR ECX, 0XE95498EF                                                       ; ECX=25B928AB
SUB EAX, ECX                                                              ; EAX=8A342F70
POP ECX                                                                   ; ECX=00400000, ESP=0018FF48
ADD EAX, 0X10214D8B                                                       ; EAX=9A557CFB
SUB ESP, 4                                                                ; ESP=0018FF44
MOV DWORD PTR [ESP], EDI
MOV EDI, 0X19B812DF                                                       ; EDI=19B812DF
SHR EDI, 7                                                                ; EDI=00337025
PUSH EBP                                                                  ; ESP=0018FF40
MOV EBP, 0X7A84338A                                                       ; EBP=7A84338A
SUB EBP, 0XF91068                                                         ; EBP=798B2322
SUB EBP, 0X1F7A7B24                                                       ; EBP=5A10A7FE
AND EBP, 0X12D771B0                                                       ; EBP=121021B0
SUB EBP, 0XCF971BBB                                                       ; EBP=427905F5
XOR EDI, EBP                                                              ; EDI=424A75D0
POP EBP                                                                   ; ESP=0018FF44, EBP=00859925
DEC EDI                                                                   ; EDI=424A75CF
INC EDI                                                                   ; EDI=424A75D0
DEC EDI                                                                   ; EDI=424A75CF
ADD EDI, 0XC3F5DD28                                                       ; EDI=064052F7
SUB EAX, EDI                                                              ; EAX=94152A04
MOV EDI, DWORD PTR [ESP]                                                  ; EDI=00000000
ADD ESP, 4                                                                ; ESP=0018FF48
PUSH ECX                                                                  ; ESP=0018FF44
MOV ECX, 0X416A6800                                                       ; ECX=416A6800
SHR ECX, 8                                                                ; ECX=00416A68
XOR ECX, 0X6CC52D73                                                       ; ECX=6C84471B
ADD EAX, ECX                                                              ; EAX=0099711F
POP ECX                                                                   ; ECX=00400000, ESP=0018FF48

