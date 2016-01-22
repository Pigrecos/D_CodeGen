mov     fs:[0],eax
MOV     EDI,EDI            ; 00412AAE
PUSH    EBP
MOV     EBP,ESP
SUB     ESP,328
MOV     DWORD PTR [424640],EAX
MOV     DWORD PTR [42463C],ECX
MOV     DWORD PTR [424638],EDX                                            ; Portable.<ModuleEntryPoint>
MOV     DWORD PTR [424634],EBX
MOV     DWORD PTR [424630],ESI
MOV     DWORD PTR [42462C],EDI
MOV     WORD PTR [424658],SS
MOV     WORD PTR [42464C],CS
MOV     WORD PTR [424628],DS
MOV     WORD PTR [424624],ES
MOV     WORD PTR [424620],FS
MOV     WORD PTR [42461C],GS
PUSHFD
POP     DWORD PTR [424650]                                                ; kernel32.775D336A
MOV     EAX,DWORD PTR [EBP]
MOV     DWORD PTR [424644],EAX
MOV     EAX,DWORD PTR [EBP+4]                                             ; ntdll.77E392B2
MOV     DWORD PTR [424648],EAX
LEA     EAX,DWORD PTR [EBP+8]
MOV     DWORD PTR [424654],EAX
MOV     EAX,DWORD PTR [EBP-320]                                           ; ntdll.77E30179
MOV     DWORD PTR [424590],10001
MOV     EAX,DWORD PTR [424648]
MOV     DWORD PTR [424544],EAX
MOV     DWORD PTR [424538],0C0000409
MOV     DWORD PTR [42453C],1
MOV     EAX,DWORD PTR [423330]
MOV     DWORD PTR [EBP-328],EAX
MOV     EAX,DWORD PTR [423334]
MOV     DWORD PTR [EBP-324],EAX
CALL    DWORD PTR [41D1F0]                                                ; kernel32.IsDebuggerPresent
MOV     DWORD PTR [424588],EAX
PUSH    1
CALL    $00413CF8
POP     ECX                                                               ; kernel32.775D336A
PUSH    0
CALL    DWORD PTR [$41D1EC]                                                ; kernel32.SetUnhandledExceptionFilter
PUSH    $0041E9C0                                                 ; ASCII "8EB"
CALL    DWORD PTR [$41D1E8]                                                ; kernel32.UnhandledExceptionFilter
CMP     DWORD PTR [$424588],0
JNZ     $00412BA0
PUSH    $1
CALL    $00413CF8
POP     ECX                                                               ; kernel32.775D336A
PUSH    0C0000409
CALL    DWORD PTR [$41D09C]                                                ; kernel32.GetCurrentProcess
PUSH    EAX
CALL    DWORD PTR [$41D1E4]                                                ; kernel32.TerminateProcess
LEAVE
RETN
PUSH    EBP
MOV     EBP,ESP
SUB     ESP,4
MOV     DWORD PTR [EBP-4],EDI
MOV     EDI,DWORD PTR [EBP+8]
MOV     ECX,DWORD PTR [EBP+0C]                                             ; SHELL32.772260C6
SHR     ECX,7
PXOR    xmm0,xmm0
JMP     $00412BD4
LEA     ESP,DWORD PTR [ESP]
NOP
movdqa  dqword ptr [edi],xmm0
movdqa  dqword ptr [edi+10],xmm0
movdqa  dqword ptr [edi+20],xmm0
movdqa  dqword ptr [edi+30],xmm0
movdqa  dqword ptr [edi+40],xmm0
movdqa  dqword ptr [edi+50],xmm0
movdqa  dqword ptr [edi+60],xmm0
movdqa  dqword ptr [edi+70],xmm0
LEA     EDI,DWORD PTR [EDI+80]
DEC     ECX
JNZ     $00412BD4
MOV     EDI,DWORD PTR [EBP-4]
MOV     ESP,EBP
POP     EBP                                                               ; kernel32.775D336A
RETN

