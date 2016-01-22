MOV     EAX,$5A4D                            ; 00412779
CMP     WORD PTR [$400000],AX
JNZ     $004127BF
MOV     EAX,DWORD PTR [$40003C]
CMP     DWORD PTR [EAX+$400000],$4550
JNZ     $004127BF
MOV     ECX,$10B
CMP     WORD PTR [EAX+$400018],CX
JNZ     $004127BF
CMP     DWORD PTR [EAX+$400074],$0E
JBE     $004127BF
XOR     ECX,ECX
CMP     DWORD PTR [EAX+$4000E8],ESI
SETNE   CL
MOV     DWORD PTR [EBP-$1C],ECX
JMP     $004127C2
MOV     DWORD PTR [EBP-$1C],ESI
XOR     EBX,EBX
INC     EBX
PUSH    EBX
CALL    $00412F4E
POP     ECX                                                               ; kernel32.74DB336A
TEST    EAX,EAX
JNZ     $004127D8
PUSH    $1C
CALL    $0041272F
POP     ECX                                                               ; kernel32.74DB336A
CALL    $00414110
TEST    EAX,EAX
JNZ     $004127E9
PUSH    $10
CALL    $0041272F
POP     ECX                                                               ; kernel32.74DB336A
CALL    $00416F32
MOV     DWORD PTR [EBP-4],EBX
CALL    $00416CDE
TEST    EAX,EAX
JGE     $00412802
PUSH    $1B
CALL    $004142CD
POP     ECX                                                               ; kernel32.74DB336A
CALL    $00749a2a4a
MOV     DWORD PTR [$4264FC],EAX
CALL    $00416C81
MOV     DWORD PTR [$42452C],EAX
CALL    $00416BD3
TEST    EAX,EAX
JGE     $00412827
PUSH    $8
CALL    $004142CD
POP     ECX                                                               ; kernel32.74DB336A
CALL    $004169A4

