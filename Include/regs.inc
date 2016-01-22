(* automatically generated from regs.dat - do not edit *)

Const EXPR_REG_START = 1;

type reg_enum = Int16;
   Const
    R_zero           =   0;
    R_none           =   -1;
    R_AH             =   EXPR_REG_START;
    R_AL             =   2;
    R_AX             =   3;
    R_BH             =   4;
    R_BL             =   5;
    R_BND0           =   6;
    R_BND1           =   7;
    R_BND2           =   8;
    R_BND3           =   9;
    R_BP             =  10;
    R_BPL            =  11;
    R_BX             =  12;
    R_CH             =  13;
    R_CL             =  14;
    R_CR0            =  15;
    R_CR1            =  16;
    R_CR10           =  17;
    R_CR11           =  18;
    R_CR12           =  19;
    R_CR13           =  20;
    R_CR14           =  21;
    R_CR15           =  22;
    R_CR2            =  23;
    R_CR3            =  24;
    R_CR4            =  25;
    R_CR5            =  26;
    R_CR6            =  27;
    R_CR7            =  28;
    R_CR8            =  29;
    R_CR9            =  30;
    R_CS             =  31;
    R_CX             =  32;
    R_DH             =  33;
    R_DI             =  34;
    R_DIL            =  35;
    R_DL             =  36;
    R_DR0            =  37;
    R_DR1            =  38;
    R_DR10           =  39;
    R_DR11           =  40;
    R_DR12           =  41;
    R_DR13           =  42;
    R_DR14           =  43;
    R_DR15           =  44;
    R_DR2            =  45;
    R_DR3            =  46;
    R_DR4            =  47;
    R_DR5            =  48;
    R_DR6            =  49;
    R_DR7            =  50;
    R_DR8            =  51;
    R_DR9            =  52;
    R_DS             =  53;
    R_DX             =  54;
    R_EAX            =  55;
    R_EBP            =  56;
    R_EBX            =  57;
    R_ECX            =  58;
    R_EDI            =  59;
    R_EDX            =  60;
    R_ES             =  61;
    R_ESI            =  62;
    R_ESP            =  63;
    R_FS             =  64;
    R_GS             =  65;
    R_K0             =  66;
    R_K1             =  67;
    R_K2             =  68;
    R_K3             =  69;
    R_K4             =  70;
    R_K5             =  71;
    R_K6             =  72;
    R_K7             =  73;
    R_MM0            =  74;
    R_MM1            =  75;
    R_MM2            =  76;
    R_MM3            =  77;
    R_MM4            =  78;
    R_MM5            =  79;
    R_MM6            =  80;
    R_MM7            =  81;
    R_R10            =  82;
    R_R10B           =  83;
    R_R10D           =  84;
    R_R10W           =  85;
    R_R11            =  86;
    R_R11B           =  87;
    R_R11D           =  88;
    R_R11W           =  89;
    R_R12            =  90;
    R_R12B           =  91;
    R_R12D           =  92;
    R_R12W           =  93;
    R_R13            =  94;
    R_R13B           =  95;
    R_R13D           =  96;
    R_R13W           =  97;
    R_R14            =  98;
    R_R14B           =  99;
    R_R14D           = 100;
    R_R14W           = 101;
    R_R15            = 102;
    R_R15B           = 103;
    R_R15D           = 104;
    R_R15W           = 105;
    R_R8             = 106;
    R_R8B            = 107;
    R_R8D            = 108;
    R_R8W            = 109;
    R_R9             = 110;
    R_R9B            = 111;
    R_R9D            = 112;
    R_R9W            = 113;
    R_RAX            = 114;
    R_RBP            = 115;
    R_RBX            = 116;
    R_RCX            = 117;
    R_RDI            = 118;
    R_RDX            = 119;
    R_RSI            = 120;
    R_RSP            = 121;
    R_SEGR6          = 122;
    R_SEGR7          = 123;
    R_SI             = 124;
    R_SIL            = 125;
    R_SP             = 126;
    R_SPL            = 127;
    R_SS             = 128;
    R_ST0            = 129;
    R_ST1            = 130;
    R_ST2            = 131;
    R_ST3            = 132;
    R_ST4            = 133;
    R_ST5            = 134;
    R_ST6            = 135;
    R_ST7            = 136;
    R_TR0            = 137;
    R_TR1            = 138;
    R_TR2            = 139;
    R_TR3            = 140;
    R_TR4            = 141;
    R_TR5            = 142;
    R_TR6            = 143;
    R_TR7            = 144;
    R_XMM0           = 145;
    R_XMM1           = 146;
    R_XMM10          = 147;
    R_XMM11          = 148;
    R_XMM12          = 149;
    R_XMM13          = 150;
    R_XMM14          = 151;
    R_XMM15          = 152;
    R_XMM16          = 153;
    R_XMM17          = 154;
    R_XMM18          = 155;
    R_XMM19          = 156;
    R_XMM2           = 157;
    R_XMM20          = 158;
    R_XMM21          = 159;
    R_XMM22          = 160;
    R_XMM23          = 161;
    R_XMM24          = 162;
    R_XMM25          = 163;
    R_XMM26          = 164;
    R_XMM27          = 165;
    R_XMM28          = 166;
    R_XMM29          = 167;
    R_XMM3           = 168;
    R_XMM30          = 169;
    R_XMM31          = 170;
    R_XMM4           = 171;
    R_XMM5           = 172;
    R_XMM6           = 173;
    R_XMM7           = 174;
    R_XMM8           = 175;
    R_XMM9           = 176;
    R_YMM0           = 177;
    R_YMM1           = 178;
    R_YMM10          = 179;
    R_YMM11          = 180;
    R_YMM12          = 181;
    R_YMM13          = 182;
    R_YMM14          = 183;
    R_YMM15          = 184;
    R_YMM16          = 185;
    R_YMM17          = 186;
    R_YMM18          = 187;
    R_YMM19          = 188;
    R_YMM2           = 189;
    R_YMM20          = 190;
    R_YMM21          = 191;
    R_YMM22          = 192;
    R_YMM23          = 193;
    R_YMM24          = 194;
    R_YMM25          = 195;
    R_YMM26          = 196;
    R_YMM27          = 197;
    R_YMM28          = 198;
    R_YMM29          = 199;
    R_YMM3           = 200;
    R_YMM30          = 201;
    R_YMM31          = 202;
    R_YMM4           = 203;
    R_YMM5           = 204;
    R_YMM6           = 205;
    R_YMM7           = 206;
    R_YMM8           = 207;
    R_YMM9           = 208;
    R_ZMM0           = 209;
    R_ZMM1           = 210;
    R_ZMM10          = 211;
    R_ZMM11          = 212;
    R_ZMM12          = 213;
    R_ZMM13          = 214;
    R_ZMM14          = 215;
    R_ZMM15          = 216;
    R_ZMM16          = 217;
    R_ZMM17          = 218;
    R_ZMM18          = 219;
    R_ZMM19          = 220;
    R_ZMM2           = 221;
    R_ZMM20          = 222;
    R_ZMM21          = 223;
    R_ZMM22          = 224;
    R_ZMM23          = 225;
    R_ZMM24          = 226;
    R_ZMM25          = 227;
    R_ZMM26          = 228;
    R_ZMM27          = 229;
    R_ZMM28          = 230;
    R_ZMM29          = 231;
    R_ZMM3           = 232;
    R_ZMM30          = 233;
    R_ZMM31          = 234;
    R_ZMM4           = 235;
    R_ZMM5           = 236;
    R_ZMM6           = 237;
    R_ZMM7           = 238;
    R_ZMM8           = 239;
    R_ZMM9           = 240;
    REG_ENUM_LIMIT = 241;

    EXPR_REG_END   = 240;

    REG_NUM_AH      =  4;
    REG_NUM_AL      =  0;
    REG_NUM_AX      =  0;
    REG_NUM_BH      =  7;
    REG_NUM_BL      =  3;
    REG_NUM_BND0    =  0;
    REG_NUM_BND1    =  1;
    REG_NUM_BND2    =  2;
    REG_NUM_BND3    =  3;
    REG_NUM_BP      =  5;
    REG_NUM_BPL     =  5;
    REG_NUM_BX      =  3;
    REG_NUM_CH      =  5;
    REG_NUM_CL      =  1;
    REG_NUM_CR0     =  0;
    REG_NUM_CR1     =  1;
    REG_NUM_CR10    = 10;
    REG_NUM_CR11    = 11;
    REG_NUM_CR12    = 12;
    REG_NUM_CR13    = 13;
    REG_NUM_CR14    = 14;
    REG_NUM_CR15    = 15;
    REG_NUM_CR2     =  2;
    REG_NUM_CR3     =  3;
    REG_NUM_CR4     =  4;
    REG_NUM_CR5     =  5;
    REG_NUM_CR6     =  6;
    REG_NUM_CR7     =  7;
    REG_NUM_CR8     =  8;
    REG_NUM_CR9     =  9;
    REG_NUM_CS      =  1;
    REG_NUM_CX      =  1;
    REG_NUM_DH      =  6;
    REG_NUM_DI      =  7;
    REG_NUM_DIL     =  7;
    REG_NUM_DL      =  2;
    REG_NUM_DR0     =  0;
    REG_NUM_DR1     =  1;
    REG_NUM_DR10    = 10;
    REG_NUM_DR11    = 11;
    REG_NUM_DR12    = 12;
    REG_NUM_DR13    = 13;
    REG_NUM_DR14    = 14;
    REG_NUM_DR15    = 15;
    REG_NUM_DR2     =  2;
    REG_NUM_DR3     =  3;
    REG_NUM_DR4     =  4;
    REG_NUM_DR5     =  5;
    REG_NUM_DR6     =  6;
    REG_NUM_DR7     =  7;
    REG_NUM_DR8     =  8;
    REG_NUM_DR9     =  9;
    REG_NUM_DS      =  3;
    REG_NUM_DX      =  2;
    REG_NUM_EAX     =  0;
    REG_NUM_EBP     =  5;
    REG_NUM_EBX     =  3;
    REG_NUM_ECX     =  1;
    REG_NUM_EDI     =  7;
    REG_NUM_EDX     =  2;
    REG_NUM_ES      =  0;
    REG_NUM_ESI     =  6;
    REG_NUM_ESP     =  4;
    REG_NUM_FS      =  4;
    REG_NUM_GS      =  5;
    REG_NUM_K0      =  0;
    REG_NUM_K1      =  1;
    REG_NUM_K2      =  2;
    REG_NUM_K3      =  3;
    REG_NUM_K4      =  4;
    REG_NUM_K5      =  5;
    REG_NUM_K6      =  6;
    REG_NUM_K7      =  7;
    REG_NUM_MM0     =  0;
    REG_NUM_MM1     =  1;
    REG_NUM_MM2     =  2;
    REG_NUM_MM3     =  3;
    REG_NUM_MM4     =  4;
    REG_NUM_MM5     =  5;
    REG_NUM_MM6     =  6;
    REG_NUM_MM7     =  7;
    REG_NUM_R10     = 10;
    REG_NUM_R10B    = 10;
    REG_NUM_R10D    = 10;
    REG_NUM_R10W    = 10;
    REG_NUM_R11     = 11;
    REG_NUM_R11B    = 11;
    REG_NUM_R11D    = 11;
    REG_NUM_R11W    = 11;
    REG_NUM_R12     = 12;
    REG_NUM_R12B    = 12;
    REG_NUM_R12D    = 12;
    REG_NUM_R12W    = 12;
    REG_NUM_R13     = 13;
    REG_NUM_R13B    = 13;
    REG_NUM_R13D    = 13;
    REG_NUM_R13W    = 13;
    REG_NUM_R14     = 14;
    REG_NUM_R14B    = 14;
    REG_NUM_R14D    = 14;
    REG_NUM_R14W    = 14;
    REG_NUM_R15     = 15;
    REG_NUM_R15B    = 15;
    REG_NUM_R15D    = 15;
    REG_NUM_R15W    = 15;
    REG_NUM_R8      =  8;
    REG_NUM_R8B     =  8;
    REG_NUM_R8D     =  8;
    REG_NUM_R8W     =  8;
    REG_NUM_R9      =  9;
    REG_NUM_R9B     =  9;
    REG_NUM_R9D     =  9;
    REG_NUM_R9W     =  9;
    REG_NUM_RAX     =  0;
    REG_NUM_RBP     =  5;
    REG_NUM_RBX     =  3;
    REG_NUM_RCX     =  1;
    REG_NUM_RDI     =  7;
    REG_NUM_RDX     =  2;
    REG_NUM_RSI     =  6;
    REG_NUM_RSP     =  4;
    REG_NUM_SEGR6   =  6;
    REG_NUM_SEGR7   =  7;
    REG_NUM_SI      =  6;
    REG_NUM_SIL     =  6;
    REG_NUM_SP      =  4;
    REG_NUM_SPL     =  4;
    REG_NUM_SS      =  2;
    REG_NUM_ST0     =  0;
    REG_NUM_ST1     =  1;
    REG_NUM_ST2     =  2;
    REG_NUM_ST3     =  3;
    REG_NUM_ST4     =  4;
    REG_NUM_ST5     =  5;
    REG_NUM_ST6     =  6;
    REG_NUM_ST7     =  7;
    REG_NUM_TR0     =  0;
    REG_NUM_TR1     =  1;
    REG_NUM_TR2     =  2;
    REG_NUM_TR3     =  3;
    REG_NUM_TR4     =  4;
    REG_NUM_TR5     =  5;
    REG_NUM_TR6     =  6;
    REG_NUM_TR7     =  7;
    REG_NUM_XMM0    =  0;
    REG_NUM_XMM1    =  1;
    REG_NUM_XMM10   = 10;
    REG_NUM_XMM11   = 11;
    REG_NUM_XMM12   = 12;
    REG_NUM_XMM13   = 13;
    REG_NUM_XMM14   = 14;
    REG_NUM_XMM15   = 15;
    REG_NUM_XMM16   = 16;
    REG_NUM_XMM17   = 17;
    REG_NUM_XMM18   = 18;
    REG_NUM_XMM19   = 19;
    REG_NUM_XMM2    =  2;
    REG_NUM_XMM20   = 20;
    REG_NUM_XMM21   = 21;
    REG_NUM_XMM22   = 22;
    REG_NUM_XMM23   = 23;
    REG_NUM_XMM24   = 24;
    REG_NUM_XMM25   = 25;
    REG_NUM_XMM26   = 26;
    REG_NUM_XMM27   = 27;
    REG_NUM_XMM28   = 28;
    REG_NUM_XMM29   = 29;
    REG_NUM_XMM3    =  3;
    REG_NUM_XMM30   = 30;
    REG_NUM_XMM31   = 31;
    REG_NUM_XMM4    =  4;
    REG_NUM_XMM5    =  5;
    REG_NUM_XMM6    =  6;
    REG_NUM_XMM7    =  7;
    REG_NUM_XMM8    =  8;
    REG_NUM_XMM9    =  9;
    REG_NUM_YMM0    =  0;
    REG_NUM_YMM1    =  1;
    REG_NUM_YMM10   = 10;
    REG_NUM_YMM11   = 11;
    REG_NUM_YMM12   = 12;
    REG_NUM_YMM13   = 13;
    REG_NUM_YMM14   = 14;
    REG_NUM_YMM15   = 15;
    REG_NUM_YMM16   = 16;
    REG_NUM_YMM17   = 17;
    REG_NUM_YMM18   = 18;
    REG_NUM_YMM19   = 19;
    REG_NUM_YMM2    =  2;
    REG_NUM_YMM20   = 20;
    REG_NUM_YMM21   = 21;
    REG_NUM_YMM22   = 22;
    REG_NUM_YMM23   = 23;
    REG_NUM_YMM24   = 24;
    REG_NUM_YMM25   = 25;
    REG_NUM_YMM26   = 26;
    REG_NUM_YMM27   = 27;
    REG_NUM_YMM28   = 28;
    REG_NUM_YMM29   = 29;
    REG_NUM_YMM3    =  3;
    REG_NUM_YMM30   = 30;
    REG_NUM_YMM31   = 31;
    REG_NUM_YMM4    =  4;
    REG_NUM_YMM5    =  5;
    REG_NUM_YMM6    =  6;
    REG_NUM_YMM7    =  7;
    REG_NUM_YMM8    =  8;
    REG_NUM_YMM9    =  9;
    REG_NUM_ZMM0    =  0;
    REG_NUM_ZMM1    =  1;
    REG_NUM_ZMM10   = 10;
    REG_NUM_ZMM11   = 11;
    REG_NUM_ZMM12   = 12;
    REG_NUM_ZMM13   = 13;
    REG_NUM_ZMM14   = 14;
    REG_NUM_ZMM15   = 15;
    REG_NUM_ZMM16   = 16;
    REG_NUM_ZMM17   = 17;
    REG_NUM_ZMM18   = 18;
    REG_NUM_ZMM19   = 19;
    REG_NUM_ZMM2    =  2;
    REG_NUM_ZMM20   = 20;
    REG_NUM_ZMM21   = 21;
    REG_NUM_ZMM22   = 22;
    REG_NUM_ZMM23   = 23;
    REG_NUM_ZMM24   = 24;
    REG_NUM_ZMM25   = 25;
    REG_NUM_ZMM26   = 26;
    REG_NUM_ZMM27   = 27;
    REG_NUM_ZMM28   = 28;
    REG_NUM_ZMM29   = 29;
    REG_NUM_ZMM3    =  3;
    REG_NUM_ZMM30   = 30;
    REG_NUM_ZMM31   = 31;
    REG_NUM_ZMM4    =  4;
    REG_NUM_ZMM5    =  5;
    REG_NUM_ZMM6    =  6;
    REG_NUM_ZMM7    =  7;
    REG_NUM_ZMM8    =  8;
    REG_NUM_ZMM9    =  9;

