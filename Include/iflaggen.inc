(* This file is auto-generated. Don't edit. *)

Const

IF_SM               =   0; (* Size match                                                       *)
IF_SM2              =   1; (* Size match first two operands                                    *)
IF_SB               =   2; (* Unsized operands can't be non-byte                               *)
IF_SW               =   3; (* Unsized operands can't be non-word                               *)
IF_SD               =   4; (* Unsized operands can't be non-dword                              *)
IF_SQ               =   5; (* Unsized operands can't be non-qword                              *)
IF_SO               =   6; (* Unsized operands can't be non-oword                              *)
IF_SY               =   7; (* Unsized operands can't be non-yword                              *)
IF_SZ               =   8; (* Unsized operands can't be non-zword                              *)
IF_SIZE             =   9; (* Unsized operands must match the bitsize                          *)
IF_SX               =  10; (* Unsized operands not allowed                                     *)
IF_AR0              =  11; (* SB, SW, SD applies to argument 0                                 *)
IF_AR1              =  12; (* SB, SW, SD applies to argument 1                                 *)
IF_AR2              =  13; (* SB, SW, SD applies to argument 2                                 *)
IF_AR3              =  14; (* SB, SW, SD applies to argument 3                                 *)
IF_AR4              =  15; (* SB, SW, SD applies to argument 4                                 *)
IF_OPT              =  16; (* Optimizing assembly only                                         *)
IF_PRIV             =  32; (* Privileged instruction                                           *)
IF_SMM              =  33; (* Only valid in SMM                                                *)
IF_PROT             =  34; (* Protected mode only                                              *)
IF_LOCK             =  35; (* Lockable if operand 0 is memory                                  *)
IF_NOLONG           =  36; (* Not available in long mode                                       *)
IF_LONG             =  37; (* Long mode                                                        *)
IF_NOHLE            =  38; (* HLE prefixes forbidden                                           *)
IF_MIB              =  39; (* disassemble with split EA                                        *)
IF_BND              =  40; (* BND (0xF2) prefix available                                      *)
IF_UNDOC            =  41; (* Undocumented                                                     *)
IF_HLE              =  42; (* HLE prefixed                                                     *)
IF_FPU              =  43; (* FPU                                                              *)
IF_MMX              =  44; (* MMX                                                              *)
IF_3DNOW            =  45; (* 3DNow!                                                           *)
IF_SSE              =  46; (* SSE (KNI, MMX2)                                                  *)
IF_SSE2             =  47; (* SSE2                                                             *)
IF_SSE3             =  48; (* SSE3 (PNI)                                                       *)
IF_VMX              =  49; (* VMX                                                              *)
IF_SSSE3            =  50; (* SSSE3                                                            *)
IF_SSE4A            =  51; (* AMD SSE4a                                                        *)
IF_SSE41            =  52; (* SSE4.1                                                           *)
IF_SSE42            =  53; (* SSE4.2                                                           *)
IF_SSE5             =  54; (* SSE5                                                             *)
IF_AVX              =  55; (* AVX (128b)                                                       *)
IF_AVX2             =  56; (* AVX2 (256b)                                                      *)
IF_FMA              =  57; (*                                                                  *)
IF_BMI1             =  58; (*                                                                  *)
IF_BMI2             =  59; (*                                                                  *)
IF_TBM              =  60; (*                                                                  *)
IF_RTM              =  61; (*                                                                  *)
IF_INVPCID          =  62; (*                                                                  *)
IF_AVX512           =  64; (* AVX-512F (512b)                                                  *)
IF_AVX512CD         =  65; (* AVX-512 Conflict Detection                                       *)
IF_AVX512ER         =  66; (* AVX-512 Exponential and Reciprocal                               *)
IF_AVX512PF         =  67; (* AVX-512 Prefetch                                                 *)
IF_MPX              =  68; (* MPX                                                              *)
IF_SHA              =  69; (* SHA                                                              *)
IF_PREFETCHWT1      =  70; (* PREFETCHWT1                                                      *)
IF_AVX512VL         =  71; (* AVX-512 Vector Length Orthogonality                              *)
IF_AVX512DQ         =  72; (* AVX-512 Dword and Qword                                          *)
IF_AVX512BW         =  73; (* AVX-512 Byte and Word                                            *)
IF_AVX512IFMA       =  74; (* AVX-512 IFMA instructions                                        *)
IF_AVX512VBMI       =  75; (* AVX-512 VBMI instructions                                        *)
IF_VEX              =  94; (* VEX or XOP encoded instruction                                   *)
IF_EVEX             =  95; (* EVEX encoded instruction                                         *)
IF_8086             =  96; (* 8086                                                             *)
IF_186              =  97; (* 186+                                                             *)
IF_286              =  98; (* 286+                                                             *)
IF_386              =  99; (* 386+                                                             *)
IF_486              = 100; (* 486+                                                             *)
IF_PENT             = 101; (* Pentium                                                          *)
IF_P6               = 102; (* P6                                                               *)
IF_KATMAI           = 103; (* Katmai                                                           *)
IF_WILLAMETTE       = 104; (* Willamette                                                       *)
IF_PRESCOTT         = 105; (* Prescott                                                         *)
IF_X86_64           = 106; (* x86-64 (long or legacy mode)                                     *)
IF_NEHALEM          = 107; (* Nehalem                                                          *)
IF_WESTMERE         = 108; (* Westmere                                                         *)
IF_SANDYBRIDGE      = 109; (* Sandy Bridge                                                     *)
IF_FUTURE           = 110; (* Future processor (not yet disclosed)                             *)
IF_IA64             = 111; (* IA64 (in x86 mode)                                               *)
IF_CYRIX            = 126; (* Cyrix-specific                                                   *)
IF_AMD              = 127; (* AMD-specific                                                     *)

(* Global flags referenced from instruction templates *)

const insns_flags : Array [0..224] of iflag_t = (
    (*    0 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000001) ),
    (*    1 *) ( NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000001) ),
    (*    2 *) ( NativeUInt($00000004),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000001) ),
    (*    3 *) ( NativeUInt($00000001),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000001) ),
    (*    4 *) ( NativeUInt($00000001),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000008) ),
    (*    5 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000008) ),
    (*    6 *) ( NativeUInt($00000001),NativeUInt($00000028),NativeUInt($00000000),NativeUInt($00000400) ),
    (*    7 *) ( NativeUInt($00000000),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*    8 *) ( NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000001) ),
    (*    9 *) ( NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   10 *) ( NativeUInt($00000001),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   11 *) ( NativeUInt($00000000),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   12 *) ( NativeUInt($00000000),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   13 *) ( NativeUInt($00000000),NativeUInt($00000028),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   14 *) ( NativeUInt($00000001),NativeUInt($00000018),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   15 *) ( NativeUInt($00000001),NativeUInt($00000014),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   16 *) ( NativeUInt($00000000),NativeUInt($00000014),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   17 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($40000020) ),
    (*   18 *) ( NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000002) ),
    (*   19 *) ( NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   20 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000010) ),
    (*   21 *) ( NativeUInt($00000004),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   22 *) ( NativeUInt($00000004),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   23 *) ( NativeUInt($00000004),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   24 *) ( NativeUInt($00000004),NativeUInt($00000028),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   25 *) ( NativeUInt($00000000),NativeUInt($00000100),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   26 *) ( NativeUInt($00000000),NativeUInt($00000110),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   27 *) ( NativeUInt($00000000),NativeUInt($00000110),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   28 *) ( NativeUInt($00000000),NativeUInt($00000120),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   29 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   30 *) ( NativeUInt($00000001),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   31 *) ( NativeUInt($00000001),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   32 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   33 *) ( NativeUInt($00000001),NativeUInt($00000208),NativeUInt($00000000),NativeUInt($00000010) ),
    (*   34 *) ( NativeUInt($00000000),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000010) ),
    (*   35 *) ( NativeUInt($00000000),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   36 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($40000040) ),
    (*   37 *) ( NativeUInt($00000000),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   38 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000002) ),
    (*   39 *) ( NativeUInt($00000000),NativeUInt($00000800),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   40 *) ( NativeUInt($00000000),NativeUInt($00000800),NativeUInt($00000000),NativeUInt($00000040) ),
    (*   41 *) ( NativeUInt($00000000),NativeUInt($00000800),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   42 *) ( NativeUInt($00000000),NativeUInt($00002000),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   43 *) ( NativeUInt($00000000),NativeUInt($00000a00),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   44 *) ( NativeUInt($00000000),NativeUInt($00000800),NativeUInt($00000000),NativeUInt($00000200) ),
    (*   45 *) ( NativeUInt($00000008),NativeUInt($00000800),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   46 *) ( NativeUInt($00000000),NativeUInt($00000800),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   47 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   48 *) ( NativeUInt($00000008),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   49 *) ( NativeUInt($00000000),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   50 *) ( NativeUInt($00000010),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   51 *) ( NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000002) ),
    (*   52 *) ( NativeUInt($00000004),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   53 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000010) ),
    (*   54 *) ( NativeUInt($00000000),NativeUInt($40000011),NativeUInt($00000000),NativeUInt($00004000) ),
    (*   55 *) ( NativeUInt($00000000),NativeUInt($40000021),NativeUInt($00000000),NativeUInt($00004000) ),
    (*   56 *) ( NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($80000400) ),
    (*   57 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000400) ),
    (*   58 *) ( NativeUInt($00000000),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($80000400) ),
    (*   59 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00008000) ),
    (*   60 *) ( NativeUInt($00000008),NativeUInt($00000004),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   61 *) ( NativeUInt($00000000),NativeUInt($00000004),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   62 *) ( NativeUInt($00000000),NativeUInt($00000004),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   63 *) ( NativeUInt($00000000),NativeUInt($00000024),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   64 *) ( NativeUInt($00000008),NativeUInt($00000004),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   65 *) ( NativeUInt($00000008),NativeUInt($00000024),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   66 *) ( NativeUInt($00000000),NativeUInt($00000005),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   67 *) ( NativeUInt($00000000),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000004) ),
    (*   68 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000200) ),
    (*   69 *) ( NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000200) ),
    (*   70 *) ( NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   71 *) ( NativeUInt($00010000),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   72 *) ( NativeUInt($00010000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   73 *) ( NativeUInt($00010000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   74 *) ( NativeUInt($00000001),NativeUInt($00000040),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   75 *) ( NativeUInt($00000001),NativeUInt($00000040),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   76 *) ( NativeUInt($00000001),NativeUInt($00000060),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   77 *) ( NativeUInt($00000000),NativeUInt($00000011),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   78 *) ( NativeUInt($00000000),NativeUInt($00000021),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   79 *) ( NativeUInt($00010001),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   80 *) ( NativeUInt($00000010),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   81 *) ( NativeUInt($00000400),NativeUInt($00001020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   82 *) ( NativeUInt($00000020),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   83 *) ( NativeUInt($00000000),NativeUInt($00001020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   84 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000040) ),
    (*   85 *) ( NativeUInt($00000020),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($40000020) ),
    (*   86 *) ( NativeUInt($00000020),NativeUInt($00002000),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   87 *) ( NativeUInt($00000001),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($40000020) ),
    (*   88 *) ( NativeUInt($00000000),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   89 *) ( NativeUInt($00000a00),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000002) ),
    (*   90 *) ( NativeUInt($00000a00),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   91 *) ( NativeUInt($00000010),NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000008) ),
    (*   92 *) ( NativeUInt($00000a00),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   93 *) ( NativeUInt($00000000),NativeUInt($00000002),NativeUInt($00000000),NativeUInt($40000040) ),
    (*   94 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   95 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000400) ),
    (*   96 *) ( NativeUInt($00000008),NativeUInt($00000100),NativeUInt($00000000),NativeUInt($00000001) ),
    (*   97 *) ( NativeUInt($00000000),NativeUInt($00000002),NativeUInt($00000000),NativeUInt($40000010) ),
    (*   98 *) ( NativeUInt($00000000),NativeUInt($00000002),NativeUInt($00000000),NativeUInt($00000020) ),
    (*   99 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000004) ),
    (*  100 *) ( NativeUInt($00002006),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000008) ),
    (*  101 *) ( NativeUInt($00002006),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  102 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($40000010) ),
    (*  103 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000040) ),
    (*  104 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000040) ),
    (*  105 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($80000040) ),
    (*  106 *) ( NativeUInt($00000000),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000002) ),
    (*  107 *) ( NativeUInt($00000001),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000008) ),
    (*  108 *) ( NativeUInt($00000001),NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000010) ),
    (*  109 *) ( NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000040) ),
    (*  110 *) ( NativeUInt($00000000),NativeUInt($00000100),NativeUInt($00000000),NativeUInt($00000008) ),
    (*  111 *) ( NativeUInt($00000000),NativeUInt($00004000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  112 *) ( NativeUInt($00002004),NativeUInt($00004000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  113 *) ( NativeUInt($00000000),NativeUInt($00005000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  114 *) ( NativeUInt($00001010),NativeUInt($00004000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  115 *) ( NativeUInt($00001020),NativeUInt($00004020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  116 *) ( NativeUInt($00001010),NativeUInt($00004020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  117 *) ( NativeUInt($00000020),NativeUInt($00005000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  118 *) ( NativeUInt($00000000),NativeUInt($00004020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  119 *) ( NativeUInt($00000000),NativeUInt($00004800),NativeUInt($00000000),NativeUInt($00000040) ),
    (*  120 *) ( NativeUInt($00000000),NativeUInt($00004820),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  121 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000800) ),
    (*  122 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000800) ),
    (*  123 *) ( NativeUInt($00000000),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000800) ),
    (*  124 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  125 *) ( NativeUInt($00000000),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  126 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  127 *) ( NativeUInt($00000000),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  128 *) ( NativeUInt($00000020),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  129 *) ( NativeUInt($00002004),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  130 *) ( NativeUInt($00002006),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000080) ),
    (*  131 *) ( NativeUInt($00000000),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  132 *) ( NativeUInt($00000040),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  133 *) ( NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  134 *) ( NativeUInt($00000020),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  135 *) ( NativeUInt($00000010),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  136 *) ( NativeUInt($00000020),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  137 *) ( NativeUInt($00000000),NativeUInt($00008020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  138 *) ( NativeUInt($00000020),NativeUInt($00001000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  139 *) ( NativeUInt($00002004),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  140 *) ( NativeUInt($00002006),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  141 *) ( NativeUInt($00001004),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  142 *) ( NativeUInt($00001020),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  143 *) ( NativeUInt($00001020),NativeUInt($00008020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  144 *) ( NativeUInt($00001010),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  145 *) ( NativeUInt($00002005),NativeUInt($00008000),NativeUInt($00000000),NativeUInt($00000100) ),
    (*  146 *) ( NativeUInt($00000040),NativeUInt($00010000),NativeUInt($00000000),NativeUInt($00000200) ),
    (*  147 *) ( NativeUInt($00000000),NativeUInt($00010000),NativeUInt($00000000),NativeUInt($00000200) ),
    (*  148 *) ( NativeUInt($00000000),NativeUInt($00020000),NativeUInt($00000000),NativeUInt($80000000) ),
    (*  149 *) ( NativeUInt($00000000),NativeUInt($00020000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  150 *) ( NativeUInt($00000010),NativeUInt($00020010),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  151 *) ( NativeUInt($00000020),NativeUInt($00020020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  152 *) ( NativeUInt($00000040),NativeUInt($00020010),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  153 *) ( NativeUInt($00000040),NativeUInt($00020020),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  154 *) ( NativeUInt($00000020),NativeUInt($00041000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  155 *) ( NativeUInt($00000000),NativeUInt($00040000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  156 *) ( NativeUInt($00000000),NativeUInt($00080000),NativeUInt($00000000),NativeUInt($80000000) ),
    (*  157 *) ( NativeUInt($00000020),NativeUInt($00080000),NativeUInt($00000000),NativeUInt($80000000) ),
    (*  158 *) ( NativeUInt($00000010),NativeUInt($00080000),NativeUInt($00000000),NativeUInt($80000000) ),
    (*  159 *) ( NativeUInt($00000000),NativeUInt($00100000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  160 *) ( NativeUInt($00000000),NativeUInt($00100020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  161 *) ( NativeUInt($00000010),NativeUInt($00100000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  162 *) ( NativeUInt($00002004),NativeUInt($00100000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  163 *) ( NativeUInt($00002004),NativeUInt($00100020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  164 *) ( NativeUInt($00000020),NativeUInt($00100000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  165 *) ( NativeUInt($00000008),NativeUInt($00100000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  166 *) ( NativeUInt($00000000),NativeUInt($00200000),NativeUInt($00000000),NativeUInt($00000000) ),
    (*  167 *) ( NativeUInt($00000000),NativeUInt($00200020),NativeUInt($00000000),NativeUInt($00000400) ),
    (*  168 *) ( NativeUInt($00000008),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000800) ),
    (*  169 *) ( NativeUInt($00000010),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000800) ),
    (*  170 *) ( NativeUInt($00000020),NativeUInt($00000020),NativeUInt($00000000),NativeUInt($00000c00) ),
    (*  171 *) ( NativeUInt($00000020),NativeUInt($00002000),NativeUInt($00000000),NativeUInt($40000020) ),
    (*  172 *) ( NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000800) ),
    (*  173 *) ( NativeUInt($00000000),NativeUInt($00004000),NativeUInt($00000000),NativeUInt($00001000) ),
    (*  174 *) ( NativeUInt($00000000),NativeUInt($00800000),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  175 *) ( NativeUInt($00000040),NativeUInt($00800000),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  176 *) ( NativeUInt($00000080),NativeUInt($00800000),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  177 *) ( NativeUInt($00000000),NativeUInt($00800020),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  178 *) ( NativeUInt($00000010),NativeUInt($00800000),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  179 *) ( NativeUInt($00000020),NativeUInt($00800020),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  180 *) ( NativeUInt($00000020),NativeUInt($00800000),NativeUInt($40000000),NativeUInt($00002000) ),
    (*  181 *) ( NativeUInt($00000000),NativeUInt($02000000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  182 *) ( NativeUInt($00000000),NativeUInt($00800000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  183 *) ( NativeUInt($00000000),NativeUInt($00000001),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  184 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($40000000),NativeUInt($80000008) ),
    (*  185 *) ( NativeUInt($00000000),NativeUInt($00000020),NativeUInt($40000000),NativeUInt($80000400) ),
    (*  186 *) ( NativeUInt($00000000),NativeUInt($00400000),NativeUInt($40000000),NativeUInt($80000000) ),
    (*  187 *) ( NativeUInt($00000000),NativeUInt($01000000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  188 *) ( NativeUInt($00000000),NativeUInt($20000000),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  189 *) ( NativeUInt($00000000),NativeUInt($20000010),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  190 *) ( NativeUInt($00000000),NativeUInt($20000020),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  191 *) ( NativeUInt($00000000),NativeUInt($20000400),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  192 *) ( NativeUInt($00000000),NativeUInt($04000000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  193 *) ( NativeUInt($00000000),NativeUInt($04000020),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  194 *) ( NativeUInt($00000000),NativeUInt($10000000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  195 *) ( NativeUInt($00000000),NativeUInt($10000020),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  196 *) ( NativeUInt($00000000),NativeUInt($08000000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  197 *) ( NativeUInt($00000000),NativeUInt($08000020),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  198 *) ( NativeUInt($00000000),NativeUInt($04000000),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  199 *) ( NativeUInt($00000000),NativeUInt($04000020),NativeUInt($00000000),NativeUInt($00004000) ),
    (*  200 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000040),NativeUInt($00004000) ),
    (*  201 *) ( NativeUInt($00000000),NativeUInt($00000080),NativeUInt($00000010),NativeUInt($00004000) ),
    (*  202 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00004000) ),
    (*  203 *) ( NativeUInt($00000000),NativeUInt($00000010),NativeUInt($00000010),NativeUInt($00004000) ),
    (*  204 *) ( NativeUInt($00000000),NativeUInt($00000020),NativeUInt($00000010),NativeUInt($00004000) ),
    (*  205 *) ( NativeUInt($00000000),NativeUInt($00000090),NativeUInt($00000010),NativeUInt($00004000) ),
    (*  206 *) ( NativeUInt($00000000),NativeUInt($000000a0),NativeUInt($00000010),NativeUInt($00004000) ),
    (*  207 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($40000000),NativeUInt($00004000) ),
    (*  208 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($00000020),NativeUInt($00004000) ),
    (*  209 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000081),NativeUInt($00004000) ),
    (*  210 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000001),NativeUInt($00004000) ),
    (*  211 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000180),NativeUInt($00004000) ),
    (*  212 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000100),NativeUInt($00004000) ),
    (*  213 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000280),NativeUInt($00004000) ),
    (*  214 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000200),NativeUInt($00004000) ),
    (*  215 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000004),NativeUInt($00004000) ),
    (*  216 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000008),NativeUInt($00004000) ),
    (*  217 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000082),NativeUInt($00004000) ),
    (*  218 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000002),NativeUInt($00004000) ),
    (*  219 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000880),NativeUInt($00004000) ),
    (*  220 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000800),NativeUInt($00004000) ),
    (*  221 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000480),NativeUInt($00004000) ),
    (*  222 *) ( NativeUInt($00000000),NativeUInt($00000000),NativeUInt($80000400),NativeUInt($00004000) ),
    (*  223 *) ( NativeUInt($00000000),NativeUInt($00000200),NativeUInt($00000000),NativeUInt($00000040) ),
    (*  224 *) ( NativeUInt($00000000),NativeUInt($00000220),NativeUInt($00000000),NativeUInt($00000400) )
);

