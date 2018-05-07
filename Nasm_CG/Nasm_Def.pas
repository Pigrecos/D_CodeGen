unit Nasm_Def;

interface
    uses
      OpFlags,
      Labels;

const
  IDLEN_MAX   = 4096;
  DECOLEN_MAX = 32;

  NO_SEG      = -1;             (* null segment value *)
  SEG_ABS     = $40000000;      (* mask for far-absolute segments *)

  PI_MODO_32  = 32;
  PI_MODO_64  = 64;

type
  decoflags_t = UInt16;
  opflags_t   = UInt64;
  iflag_t     =  array[0..3] of NativeUInt;
(*
 * Token types returned by the scanner, in addition to ordinary
 * ASCII character values, and zero for end-of-string.
 *)
 type  token_type = Int16 ;  (* token types, other than chars *)
    const
      TOKEN_INVALID  = -1;     (* a placeholder value *)
      TOKEN_EOS      = 0;      (* end of string *)
      TOKEN_EQ       = Ord('=');
      TOKEN_GT       = Ord('>');
      TOKEN_LT       = Ord('<');(* aliases *)
      TOKEN_ID       = 256;    (* identifier *)
      TOKEN_NUM      = 257;    (* numeric constant *)
      TOKEN_ERRNUM   = 258;    (* malformed numeric constant *)
      TOKEN_STR      = 259;    (* string constant *)
      TOKEN_ERRSTR   = 260;    (* unterminated string constant *)
      TOKEN_FLOAT    = 261;    (* floating-point constant *)
      TOKEN_REG      = 262;    (* register name *)
      TOKEN_INSN     = 263;    (* instruction name *)
      TOKEN_HERE     = 264;    (* $ *)
      TOKEN_BASE     = 265;    (* $$ *)
      TOKEN_SPECIAL  = 266;    (* BYTE, WORD, DWORD, QWORD, FAR, NEAR, etc *)
      TOKEN_PREFIX   = 267;    (* A32, O16, LOCK, REPNZ, TIMES, etc *)
      TOKEN_SHL      = 268;    (* << *)
      TOKEN_SHR      = 269;    (* >> *)
      TOKEN_SDIV     = 270;    (* // *)
      TOKEN_SMOD     = 271;    (* %% *)
      TOKEN_GE       = 272;    (* >= *)
      TOKEN_LE       = 273;    (* <= *)
      TOKEN_NE       = 274;    (* <> (!= is same as <>) *)
      TOKEN_DBL_AND  = 275;    (* && *)
      TOKEN_DBL_OR   = 276;    (* || *)
      TOKEN_DBL_XOR  = 277;    (* ^^ *)
      TOKEN_SEG      = 278;    (* SEG *)
      TOKEN_WRT      = 279;    (* WRT *)
      TOKEN_FLOATIZE = 280;    (* __floatX__ *)
      TOKEN_STRFUNC  = 281;    (* __utf16*__, __utf32*__ *)
      TOKEN_IFUNC    = 282;    (* __ilog2*__ *)
      TOKEN_DECORATOR= 283;    (* decorators such as {...} *)
      TOKEN_OPMASK   = 284;    (* translated token for opmask registers *)

(*Mantenuti solo x compatibilità*)
 type floatize = Byte ;
   const
    FLOAT_8    = 1;
    FLOAT_16   = 2;
    FLOAT_32   = 3;
    FLOAT_64   = 4;
    FLOAT_80M  = 5;
    FLOAT_80E  = 6;
    FLOAT_128L = 7;
    FLOAT_128H = 8;

(* Must match the list in string_transform(), in strfunc.c *)
 type strfunc  = Byte ;
   const
    STRFUNC_UTF16   = 1;
    STRFUNC_UTF16LE = 2;
    STRFUNC_UTF16BE = 3;
    STRFUNC_UTF32   = 4;
    STRFUNC_UTF32LE = 5;
    STRFUNC_UTF32BE = 6;

 type ifunc = Byte;
   const
    IFUNC_ILOG2E  = 1;
    IFUNC_ILOG2W  = 2;
    IFUNC_ILOG2F  = 3;
    IFUNC_ILOG2C  = 4;
(****************************)

type ccode  = Integer ; (* condition code names *)
   const
     C_A   = $0;
     C_AE  = $1;
     C_B   = $2;
     C_BE  = $3;
     C_C   = $4;
     C_E   = $5;
     C_G   = $6;
     C_GE  = $7;
     C_L   = $8;
     C_LE  = $9;
     C_NA  = $A;
     C_NAE = $B;
     C_NB  = $C;
     C_NBE = $D;
     C_NC  = $E;
     C_NE  = $F;
     C_NG  = $10;
     C_NGE = $11;
     C_NL  = $12;
     C_NLE = $13;
     C_NO  = $14;
     C_NP  = $15;
     C_NS  = $16;
     C_NZ  = $17;
     C_O   = $18;
     C_P   = $19;
     C_PE  = $1A;
     C_PO  = $1B;
     C_S   = $1C;
     C_Z   = $1D;
     C_none= -1;

(*
 * token flags
 *)
const
   TFLAG_BRC       = 1;                          (* valid only with braces. {1to8}, {rd-sae}, ...*)
   TFLAG_BRC_OPT   = 2;                          (* may or may not have braces. opmasks {k1} *)
   TFLAG_BRC_ANY   = TFLAG_BRC or TFLAG_BRC_OPT;
   TFLAG_BRDCAST   = 4;                          (* broadcasting decorator *)

   MAX_KEYWORD      = 16;

   // Array Indicew registri
   nasm_reg_flags : array[0..240] of UInt64 = ( {$I  'Include/RegFlags.inc'}

   // Array Indice istruzione
   {$I 'Include/inst_Idx.inc'}
   // Array Indice Registri
   {$I 'Include/regs.inc'}

   {$I 'Include/regvals.inc'}


(*
 * REX flags
 *)
 const
  REX_MASK    = $4f;    (* Actual REX prefix bits *)
  REX_B       = $01;    (* ModRM r/m extension *)
  REX_X       = $02;    (* SIB index extension *)
  REX_R       = $04;    (* ModRM reg extension *)
  REX_W       = $08;    (* 64-bit operand size *)
  REX_L       = $20;    (* Use LOCK prefix instead of REX.R *)
  REX_P       = $40;    (* REX prefix present/required *)
  REX_H       = $80;    (* High register present, REX forbidden *)
  REX_V       = $0100;  (* Instruction uses VEX/XOP instead of REX *)
  REX_NH      = $0200;  (* Instruction which doesn't use high regs *)
  REX_EV      = $0400;  (* Instruction uses EVEX instead of REX *)

(*
 * EVEX bit field
 *)
  EVEX_P0MM       = $03;        (* EVEX P[1:0] : Legacy escape        *)
  EVEX_P0RP       = $10;        (* EVEX P[4] : High-16 reg            *)
  EVEX_P0X        = $40;        (* EVEX P[6] : High-16 rm             *)
  EVEX_P1PP       = $03;        (* EVEX P[9:8] : Legacy prefix        *)
  EVEX_P1VVVV     = $78;        (* EVEX P[14:11] : NDS register       *)
  EVEX_P1W        = $80;        (* EVEX P[15] : Osize extension       *)
  EVEX_P2AAA      = $07;        (* EVEX P[18:16] : Embedded opmask    *)
  EVEX_P2VP       = $08;        (* EVEX P[19] : High-16 NDS reg       *)
  EVEX_P2B        = $10;        (* EVEX P[20] : Broadcast / RC / SAE  *)
  EVEX_P2LL       = $60;        (* EVEX P[22:21] : Vector length      *)
  EVEX_P2RC       = EVEX_P2LL;  (* EVEX P[22:21] : Rounding control   *)
  EVEX_P2Z        = $80;        (* EVEX P[23] : Zeroing/Merging       *)

(*
 * REX_V "classes" (prefixes which behave like VEX)
 *)
type
vex_class = (
    RV_VEX      = 0,    (* C4/C5 *)
    RV_XOP      = 1,    (* 8F *)
    RV_EVEX     = 2);   (* 62 *)


(*
 * Note that because segment registers may be used as instruction
 * prefixes, we must ensure the enumerations for prefixes and
 * register names do not overlap.
 *)
 type prefixes  = Int16;  (* instruction prefixes *)
   const
    P_none            = 0;
    PREFIX_ENUM_START = REG_ENUM_LIMIT;
    P_A16             = PREFIX_ENUM_START;
    P_A32             = PREFIX_ENUM_START + 1;
    P_A64             = PREFIX_ENUM_START + 2;
    P_ASP             = PREFIX_ENUM_START + 3;
    P_LOCK            = PREFIX_ENUM_START + 4;
    P_O16             = PREFIX_ENUM_START + 5;
    P_O32             = PREFIX_ENUM_START + 6;
    P_O64             = PREFIX_ENUM_START + 7;
    P_OSP             = PREFIX_ENUM_START + 8;
    P_REP             = PREFIX_ENUM_START + 9;
    P_REPE            = PREFIX_ENUM_START + 10;
    P_REPNE           = PREFIX_ENUM_START + 11;
    P_REPNZ           = PREFIX_ENUM_START + 12;
    P_REPZ            = PREFIX_ENUM_START + 13;
    P_TIMES           = PREFIX_ENUM_START + 14;
    P_WAIT            = PREFIX_ENUM_START + 15;
    P_XACQUIRE        = PREFIX_ENUM_START + 16;
    P_XRELEASE        = PREFIX_ENUM_START + 17;
    P_BND             = PREFIX_ENUM_START + 18;
    P_NOBND           = PREFIX_ENUM_START + 19;
    P_EVEX            = PREFIX_ENUM_START + 20;
    P_VEX3            = PREFIX_ENUM_START + 21;
    P_VEX2            = PREFIX_ENUM_START + 22;
    PREFIX_ENUM_LIMIT = PREFIX_ENUM_START + 23;

 type  ea_flags  = Byte;  (* special EA flags *)
   const
    EAF_BYTEOFFS    =  1;   (* force offset part to byte size *)
    EAF_WORDOFFS    =  2;   (* force offset part to [d]word size *)
    EAF_TIMESTWO    =  4;   (* really do EAX*2 not EAX+EAX *)
    EAF_REL         =  8;   (* IP-relative addressing *)
    EAF_ABS         = 16;   (* non-IP-relative addressing *)
    EAF_FSGS        = 32;   (* fs/gs segment override present *)
    EAF_MIB         = 64;   (* mib operand *)

 type eval_hint = Byte; (* values for `hinttype' *)
   const
    EAH_NOHINT   = 0;       (* no hint at all - our discretion *)
    EAH_MAKEBASE = 1;       (* try to make given reg the base *)
    EAH_NOTBASE  = 2;       (* try _not_ to make reg the base *)
    EAH_SUMMED   = 3;       (* base and index are summed into index *)

 type
 POperand = ^TOperand;
 TOperand  = record (* operand to an instruction *)
    tipo      : UInt64;    (* type of operand *)
    disp_size : Integer;   (* 0 means default; 16; 32; 64 *)
    basereg   : reg_enum;
    indexreg  : reg_enum;  (* address registers *)
    scale     : Integer;   (* index scale *)
    hintbase  : Integer;
    hinttype  : eval_hint; (* hint as to real base register *)
    segment   : Int32;     (* immediate segment, if needed *)
    offset    : Int64 ;    (* any immediate number *)
    wrt       : Int32;     (* segment base it's relative to *)
    eaflags   : Integer;   (* special EA flags *)
    opflags   : Integer;   (* see OPFLAG_* defines below *)
    decoflags : Word;      (* decorator flags such as {...} *)
 end;

const
  OPFLAG_FORWARD  =    1;   (* operand is a forward reference   *)
  OPFLAG_EXTERN   =    2;   (* operand is an external reference *)
  OPFLAG_UNKNOWN  =    4;   (* operand is an unknown reference
                               always a forward reference also  *)

 type ea_type  = Byte;
   const
    EA_INVALID  = 0;     (* Not a valid EA at all *)
    EA_SCALAR   = 1;     (* Scalar EA *)
    EA_XMMVSIB  = 2;     (* XMM vector EA *)
    EA_YMMVSIB  = 3;     (* YMM vector EA *)
    EA_ZMMVSIB  = 4;     (* ZMM vector EA *)

type out_type  = Byte;
   const
    OUT_RAWDATA = 0;  (* Plain bytes *)
    OUT_ADDRESS = 1;  (* An address (symbol value) *)
    OUT_RESERVE = 2;  (* Reserved bytes (RESB et al) *)
    OUT_REL1ADR = 3;  (* 1-byte relative address *)
    OUT_REL2ADR = 4;  (* 2-byte relative address *)
    OUT_REL4ADR = 5;  (* 4-byte relative address *)
    OUT_REL8ADR = 6;  (* 8-byte relative address *)

(*
 * Prefix positions: each type of prefix goes in a specific slot.
 * This affects the final ordering of the assembled output, which
 * shouldn't matter to the processor, but if you have stylistic
 * preferences, you can change this.  REX prefixes are handled
 * differently for the time being.
 *
 * LOCK and REP used to be one slot; this is no longer the case since
 * the introduction of HLE.
 *)
 type prefix_pos  = byte;
   const
    PPS_WAIT  = 0;  (* WAIT (technically not a prefix!) *)
    PPS_REP   = 1;  (* REP/HLE prefix *)
    PPS_LOCK  = 2;  (* LOCK prefix *)
    PPS_SEG   = 3;  (* Segment override prefix *)
    PPS_OSIZE = 4;  (* Operand size prefix *)
    PPS_ASIZE = 5;  (* Address size prefix *)
    PPS_VEX   = 6;  (* VEX type *)
    MAXPREFIX = 7;  (* Total number of prefix slots *)

(*
 * Tuple types that are used when determining Disp8*N eligibility
 * The order must match with a hash %tuple_codes in insns.pl
 *)
 type ttypes =  Byte;
   const
    FV    = 1;
    HV    = 2;
    FVM   = 3;
    T1S8  = 4;
    T1S16 = 5;
    T1S   = 6;
    T1F32 = 7;
    T1F64 = 8;
    T2    = 9;
    T4    = 10;
    T8    = 11;
    HVM   = 12;
    QVM   = 13;
    OVM   = 14;
    M128  = 15;
    DUP   = 16;

(* EVEX.L'L : Vector length on vector insns *)
 type vectlens = Byte;
   const
    VL128 = 0;
    VL256 = 1;
    VL512 = 2;
    VLMAX = 3;

(* If you need to change this, also change it in insns.pl *)
  MAX_OPERANDS  = 5;

 type
 TInsn = record (* an instruction itself *)
    llabel     : PAnsiChar;                            (* the label defined, or NULL *)
    prefixes   : array [0..MAXPREFIX-1] of Integer;    (* instruction prefixes, if any *)
    opcode     : TOpCode;                              (* the opcode - not just the string *)
    condition  : ccode;                                (* the condition code, if Jcc/SETcc *)
    operands   : Integer;                              (* how many operands? 0-3 (more if db et al) *)
    addr_size  : Integer;                              (* address size *)
    oprs       : array[0..MAX_OPERANDS-1] of TOperand; (* the operands, defined as above *)
    forw_ref   : Boolean;                              (* is there a forward reference? *)
    rex_done   : Boolean ;                             (* REX prefix emitted? *)
    rex        : SmallInt;                             (* Special REX Prefix *)
    vexreg     : Integer ;                             (* Register encoded in VEX prefix *)
    vex_cm     : Integer;                              (* Class and M field for VEX prefix *)
    vex_wlp    : Integer;                              (* W, P and L information for VEX prefix *)
    evex_p     : array[0..2] of Byte ;                 (* EVEX.P0: [RXB,R',00,mm], P1: [W,vvvv,1,pp] *)
                                                       (* EVEX.P2: [z,L'L,b,V',aaa] *)
    evex_tuple : ttypes;                               (* Tuple type for compressed Disp8*N *)
    evex_rm    : Integer;                              (* static rounding mode for AVX512 (EVEX) *)
    evex_brerop: Int8 ;                                (* BR/ER/SAE operand position *)
 end;

 type special_tokens  = Int16;
   const
    SPECIAL_ENUM_START  = PREFIX_ENUM_LIMIT;
    S_ABS               = SPECIAL_ENUM_START;
    S_BYTE              = SPECIAL_ENUM_START + 1;
    S_DWORD             = SPECIAL_ENUM_START + 2;
    S_FAR               = SPECIAL_ENUM_START + 3;
    S_LONG              = SPECIAL_ENUM_START + 4;
    S_NEAR              = SPECIAL_ENUM_START + 5;
    S_NOSPLIT           = SPECIAL_ENUM_START + 6;
    S_OWORD             = SPECIAL_ENUM_START + 7;
    S_QWORD             = SPECIAL_ENUM_START + 8;
    S_REL               = SPECIAL_ENUM_START + 9;
    S_SHORT             = SPECIAL_ENUM_START + 10;
    S_STRICT            = SPECIAL_ENUM_START + 11;
    S_TO                = SPECIAL_ENUM_START + 12;
    S_TWORD             = SPECIAL_ENUM_START + 13;
    S_WORD              = SPECIAL_ENUM_START + 14;
    S_YWORD             = SPECIAL_ENUM_START + 15;
    S_ZWORD             = SPECIAL_ENUM_START + 16;
    SPECIAL_ENUM_LIMIT  = SPECIAL_ENUM_START + 17;

 type decorator_tokens  = Int16;
   Const
    DECORATOR_ENUM_START = SPECIAL_ENUM_LIMIT;
    BRC_1TO2             = DECORATOR_ENUM_START;
    BRC_1TO4             = DECORATOR_ENUM_START + 1;
    BRC_1TO8             = DECORATOR_ENUM_START + 2;
    BRC_1TO16            = DECORATOR_ENUM_START + 3;
    BRC_RN               = DECORATOR_ENUM_START + 4;
    BRC_RD               = DECORATOR_ENUM_START + 5;
    BRC_RU               = DECORATOR_ENUM_START + 6;
    BRC_RZ               = DECORATOR_ENUM_START + 7;
    BRC_SAE              = DECORATOR_ENUM_START + 8;
    BRC_Z                = DECORATOR_ENUM_START + 9;
    DECORATOR_ENUM_LIMIT = DECORATOR_ENUM_START + 10;

type
   TTokenVal = record
      t_charptr : PAnsiChar ;
      t_integer : Int64;
      t_inttwo  : Int64;
      t_type    : token_type;
      t_flag    : Byte;
   end;
   PTTokenVal = ^TTokenVal;

 TLocation = record
    offset : UInt64;
    segment: Int32;
    known  : Boolean;
 end;

 TScanner = Reference to function(var tv: TTokenVal): Integer;
 TLogMsg  = Reference to procedure(Severity : Integer; strMsg : string);

 TLDEF = Reference to procedure(llabel: PAnsiChar; segment: int32; offset: UInt64);

 TOutCmdB = TArray<Byte>;
 type
  TAssembled = record                // struttura per singola istruzione
    Address: Cardinal;               // Indirizzo Istruzione
    Bytes  : TOutCmdB;               // Byte dell'istruzione
end;
TTAssembled = array of TAssembled;

var
 Location              : TLocation;
 Global_offset_changed : UInt64;
 lab                   : TLab ;

implementation

end.
