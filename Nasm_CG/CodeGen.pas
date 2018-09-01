(* Doc x Encoding Instruction
 * http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf
 * AVX Encoding
 * https://software.intel.com/sites/default/files/managed/0d/53/319433-022.pdf


    1  byte  (8 bit):   byte,
    2  bytes (16 bit):  word,
    4  bytes (32 bit):  dword,
    8  bytes (64 bit):  qword,
    10 bytes (80 bit):  tword,
    16 bytes (128 bit): oword,
    32 bytes (256 bit): yword,
    64 bytes (512 bit): zword

 *)

 (*
 * code generation
 *
 * Bytecode specification
 * ----------------------
 *
 *
 * Codes(Octale)            Mnemonic        Explanation
 *
 * \0                                       terminates the code. (Unless it's a literal of course.)
 * \1..\4                                   that many literal bytes follow in the code stream
 * \5                                       add 4 to the primary operand number (b, low octdigit)
 * \6                                       add 4 to the secondary operand number (a, middle octdigit)
 * \7                                       add 4 to both the primary and the secondary operand number
 * \10..\13                                 a literal byte follows in the code stream, to be added
 *                                          to the register value of operand 0..3
 * \14..\17                                 the position of index register operand in MIB (BND insns)
 * \20..\23         ib                      a byte immediate operand, from operand 0..3
 * \24..\27         ib,u                    a zero-extended byte immediate operand, from operand 0..3
 * \30..\33         iw                      a word immediate operand, from operand 0..3
 * \34..\37         iwd                     select between \3[0-3] and \4[0-3] depending on 16/32 bit
 *                                          assembly mode or the operand-size override on the operand
 * \40..\43         id                      a long immediate operand, from operand 0..3
 * \44..\47         iwdq                    select between \3[0-3], \4[0-3] and \5[4-7]
 *                                          depending on the address size of the instruction.
 * \50..\53         rel8                    a byte relative operand, from operand 0..3
 * \54..\57         iq                      a qword immediate operand, from operand 0..3
 * \60..\63         rel16                   a word relative operand, from operand 0..3
 * \64..\67         rel                     select between \6[0-3] and \7[0-3] depending on 16/32 bit
 *                                          assembly mode or the operand-size override on the operand
 * \70..\73         rel32                   a long relative operand, from operand 0..3
 * \74..\77         seg                     a word constant, from the _segment_ part of operand 0..3
 * \1ab                                     a ModRM, calculated on EA in operand a, with the spare
 *                                          field the register value of operand b.
 * \172\ab                                  the register number from operand a in bits 7..4, with
 *                                          the 4-bit immediate from operand b in bits 3..0.
 * \173\xab                                 the register number from operand a in bits 7..4, with
 *                                          the value b in bits 3..0.
 * \174..\177                               the register number from operand 0..3 in bits 7..4, and
 *                                          an arbitrary value in bits 3..0 (assembled as zero.)
 * \2ab                                     a ModRM, calculated on EA in operand a, with the spare
 *                                          field equal to digit b.
 *
 * \240..\243                               this instruction uses EVEX rather than REX or VEX/XOP, with the
 *                                          V field taken from operand 0..3.
 * \250                                     this instruction uses EVEX rather than REX or VEX/XOP, with the
 *                                          V field set to 1111b.
 *
 * EVEX prefixes are followed by the sequence:
 * \cm\wlp\tup    where cm is:
 *                  cc 000 0mm
 *                  c = 2 for EVEX and m is the legacy escape (0f, 0f38, 0f3a)
 *                and wlp is:
 *                  00 wwl lpp
 *                  [l0]  ll = 0 (.128, .lz)
 *                  [l1]  ll = 1 (.256)
 *                  [l2]  ll = 2 (.512)
 *                  [lig] ll = 3 for EVEX.L'L don't care (always assembled as 0)
 *
 *                  [w0]  ww = 0 for W = 0
 *                  [w1]  ww = 1 for W = 1
 *                  [wig] ww = 2 for W don't care (always assembled as 0)
 *                  [ww]  ww = 3 for W used as REX.W
 *
 *                  [p0]  pp = 0 for no prefix
 *                  [60]  pp = 1 for legacy prefix 60
 *                  [f3]  pp = 2
 *                  [f2]  pp = 3
 *
 *                tup is tuple type for Disp8*N from %tuple_codes in insns.pl
 *                    (compressed displacement encoding)
 *
 * \254..\257       id,s                        a signed 32-bit operand to be extended to 64 bits.
 * \260..\263                                   this instruction uses VEX/XOP rather than REX, with the
 *                                              V field taken from operand 0..3.
 * \270                                         this instruction uses VEX/XOP rather than REX, with the
 *                                              V field set to 1111b.
 *
 * VEX/XOP prefixes are followed by the sequence:
 * \tmm\wlp        where mm is the M field; and wlp is:
 *                 00 wwl lpp
 *                 [l0]  ll = 0 for L = 0 (.128, .lz)
 *                 [l1]  ll = 1 for L = 1 (.256)
 *                 [lig] ll = 2 for L don't care (always assembled as 0)
 *
 *                 [w0]  ww = 0 for W = 0
 *                 [w1 ] ww = 1 for W = 1
 *                 [wig] ww = 2 for W don't care (always assembled as 0)
 *                 [ww]  ww = 3 for W used as REX.W
 *
 * t = 0 for VEX (C4/C5), t = 1 for XOP (8F).
 *
 * \271             hlexr                       instruction takes XRELEASE (F3) with or without lock
 * \272             hlenl                       instruction takes XACQUIRE/XRELEASE with or without lock
 * \273             hle                         instruction takes XACQUIRE/XRELEASE with lock only
 * \274..\277       ib,s                        a byte immediate operand, from operand 0..3, sign-extended
 *                                              to the operand size (if o16/o32/o64 present) or the bit size
 * \310             a16                         indicates fixed 16-bit address size, i.e. optional 0x67.
 * \311             a32                         indicates fixed 32-bit address size, i.e. optional 0x67.
 * \312             adf                         (disassembler only) invalid with non-default address size.
 * \313             a64                         indicates fixed 64-bit address size, 0x67 invalid.
 * \314             norexb                      (disassembler only) invalid with REX.B
 * \315             norexx                      (disassembler only) invalid with REX.X
 * \316             norexr                      (disassembler only) invalid with REX.R
 * \317             norexw                      (disassembler only) invalid with REX.W
 * \320             o16                         indicates fixed 16-bit operand size, i.e. optional 0x66.
 * \321             o32                         indicates fixed 32-bit operand size, i.e. optional 0x66.
 * \322             odf                         indicates that this instruction is only valid when the
 *                                              operand size is the default (instruction to disassembler,
 *                                              generates no code in the assembler)
 * \323             o64nw                       indicates fixed 64-bit operand size, REX on extensions only.
 * \324             o64                         indicates 64-bit operand size requiring REX prefix.
 * \325             nohi                        instruction which always uses spl/bpl/sil/dil
 * \326             nof3                        instruction not valid with 0xF3 REP prefix.  Hint for
                                                disassembler only; for SSE instructions.
 * \330                                         a literal byte follows in the code stream, to be added
 *                                              to the condition code value of the instruction.
 * \331             norep                       instruction not valid with REP prefix.  Hint for
 *                                              disassembler only; for SSE instructions.
 * \332             f2i                         REP prefix (0xF2 byte) used as opcode extension.
 * \333             f3i                         REP prefix (0xF3 byte) used as opcode extension.
 * \334             rex.l                       LOCK prefix used as REX.R (used in non-64-bit mode)
 * \335             repe                        disassemble a rep (0xF3 byte) prefix as repe not rep.
 * \336             mustrep                     force a REP(E) prefix (0xF3) even if not specified.
 * \337             mustrepne                   force a REPNE prefix (0xF2) even if not specified.
 *                                              \336-\337 are still listed as prefixes in the disassembler.
 * \340             resb                        reserve <operand 0> bytes of uninitialized storage.
 *                                              Operand 0 had better be a segmentless constant.
 * \341             wait                        this instruction needs a WAIT "prefix"
 * \360             np                          no SSE prefix (== \364\331)
 * \361                                         66 SSE prefix (== \366\331)
 * \364             !osp                        operand-size prefix (0x66) not permitted
 * \365             !asp                        address-size prefix (0x67) not permitted
 * \366                                         operand-size prefix (0x66) used as opcode extension
 * \367                                         address-size prefix (0x67) used as opcode extension
 * \370,\371        jcc8                        match only if operand 0 meets byte jump criteria.
 *                  jmp8                        370 is used for Jcc, 371 is used for JMP.
 * \373             jlen                        assemble 0x03 if bits==16, 0x05 if bits==32;
 *                                              used for conditional jump over longer jump
 * \374             vsibx|vm32x|vm64x           this instruction takes an XMM VSIB memory EA
 * \375             vsiby|vm32y|vm64y           this instruction takes an YMM VSIB memory EA
 * \376             vsibz|vm32z|vm64z           this instruction takes an ZMM VSIB memory EA
 *)
unit CodeGen;

interface

     uses
       System.SysUtils, windows, System.AnsiStrings, System.Classes,
       Parser,
       Nasm_Def,
       OpFlags;

type
  (* if changed, ITEMPLATE_END should be also changed accordingly *)
 TItemplate  = record
    opcode    : TOpCode;                                (* the token, passed from "parser.c" *)
    operands  : Integer  ;                              (* number of operands *)
    opd       : array[0..MAX_OPERANDS-1] of Int64;      (* bit flags for operand types *)
    deco      : array[0..MAX_OPERANDS-1] of Int16;      (* bit flags for operand decorators *)
    code      : PByte;                                  (* the code it assembles to *)
    iflag_idx : Int32;                                  (* some flags referenced by index *)
 end;
 pItemplate = ^TItemplate;


 {$I  'Include/inst_ByteCode.inc'}  (****ByteCode table****)
 {$I  'Include/inst_A.inc'}         (****Instruction Table****)
 {$I  'Include/iflaggen.inc'}       (****Flag for Instruction table****)


Type

 T_EA = record
    tipo        : ea_type;   (* what kind of EA is this? *)
    sib_present : Integer;   (* is a SIB byte necessary? *)
    bytes       : Integer;   (* # of bytes of offset needed *)
    size        : Integer;   (* lazy - this is sib+bytes+1 *)
    modrm, sib,
    rex, rip    : Byte;      (* the bytes themselves *)
    disp8       : int8;      (* compressed displacement for EVEX *)
 end;

type match_result =  Byte;
   const
    (*
     * Matching errors.  These should be sorted so that more specific
     * errors come later in the sequence.
     *)
    MERR_INVALOP        = 0;
    MERR_OPSIZEMISSING  = 1;
    MERR_OPSIZEMISMATCH = 2;
    MERR_BRNUMMISMATCH  = 3;
    MERR_BADCPU         = 4;
    MERR_BADMODE        = 5;
    MERR_BADHLE         = 6;
    MERR_ENCMISMATCH    = 7;
    MERR_BADBND         = 8;
    MERR_BADREPNE       = 9;
    (*
     * Matching success; the conditional ones first
     *)
    MOK_JUMP            = 10;   (* Matching OK but needs jmp_match() *)
    MOK_GOOD            = 11;   (* Matching unconditionally OK *)

    NASM_SYNTAX = 01;
    MASM_SYNTAX = 02;

(*
 * Prefix information
 *)
type
prefix_info = record
    osize  : Byte ;                (* Operand size *)
    asize  : Byte;                 (* Address size *)
    osp    : Byte;                 (* Operand size prefix present *)
    asp    : Byte;                 (* Address size prefix present *)
    rep    : Byte;                 (* Rep prefix present *)
    seg    : Byte;                 (* Segment override prefix present *)
    wait   : Byte;                 (* WAIT "prefix" present *)
    lock   : Byte;                 (* Lock prefix present *)
    vex    : array[0..2] of Byte;  (* VEX prefix present *)
    vex_c  : Byte;                 (* VEX "class" (VEX, XOP, ...) *)
    vex_m  : Byte;                 (* VEX.M field *)
    vex_v  : Byte;
    vex_lp : Byte ;                (* VEX.LP fields *)
    rex    : Byte;                 (* REX prefix present *)
    evex   : array[0..2] of Byte;  (* EVEX prefix present *)
end;



 TCodeGen = class
   private
      FOptimizing   : UInt64;       // ottimizzazione si/no
      FCodeBuffer   : TOutCmdB;     // contiene il bytecode generato
      FTipoSyntax   : Integer;
      FSegment      : Integer;
      FBits         : Byte;
      FLenAsmBytes  : Cardinal;

      FCurrent_loc  : Uint64;       // tiene traccia della posizione attuale in FcodeBuffre
      FBytes_Written: UInt64;       // Numero di byte scritti
      FDefaulOffset : UInt64;       // valore di Start offset di default

      FOnLogMsg     : TLogMsg;

      FParser       : TParserNasm;
      FErrore       : Integer;

      procedure DoLogMsg(Severity : Integer; strMsg : string);
      procedure ResetBuffer;
      procedure OutputByte( vbyte : Byte) ;
      procedure OutputCodeByte( vbyte : Byte );
      procedure FillDataBytes( vbyte : Byte; len: Integer );
      procedure OutData(data: PByte; size: Cardinal);

      function  get_disp8N(ins: TInsn) : UInt8;
      function  is_disp8n(input: TOperand; ins: TInsn; var compdisp: Int8): Boolean;
      function  GEN_SIB(scale, index, base: Byte) : Byte;
      function  GEN_MODRM(mod_, reg, rm: Byte ): Byte;
      function  size_name(size: Integer): string;
      function  overflow_general(value: Int64; vbytes: Integer): Boolean;
      function  overflow_signed(value: Int64; bytes: Integer): Boolean;
      procedure warn_overflow(pass, size: Integer);
      procedure warn_overflow_opd(o: TOperand; size: Integer);
      function  signed_bits(value: Int64; bits: Integer): Int64;
      procedure WRITEADDR(Dest,Src: Pointer;Size : NativeUInt);
      procedure InternalOut(data: Pointer; size: UInt64; tipo: out_type);
      function  is_register(reg: Integer): Boolean;
      function  regval(o: TOperand): int32;
      function  regflag(o: TOperand): UInt64;
      function  evexflags(nval: Integer; deco: Word; mask: Integer; nbyte : Byte): Integer;
      function  op_evexflags(o: TOperand;mask: Integer; nbyte: Byte): Integer;
      function  rexflags(nVal: Integer; flags: opflags_t; mask: Integer): Integer;
      function  op_rexflags(o: TOperand;mask: Integer): Integer;
      procedure add_asp(var ins : TInsn; addrbits: Cardinal);
      function  itemp_has(itemp: pItemplate; vbit: Cardinal): Boolean;
      function  _itemp_smask(idx: Integer):Cardinal;
      function  _itemp_armask(idx: Integer):Cardinal;
      function  _itemp_arg(idx: Integer):Cardinal;
      function  itemp_smask(itemp: pItemplate): Cardinal;
      function  itemp_armask(itemp: pItemplate): Cardinal;
      function  itemp_arg(itemp: pItemplate): Cardinal;
      function  get_broadcast_num(opflags: opflags_t; brsize: opflags_t): Byte;
      function  has_prefix(ins: TInsn; vpos: prefix_pos; prefix: Integer): Boolean;
      procedure assert_no_prefix(ins: TInsn; pos: prefix_pos) ;
      function  get_cond_opcode(c: ccode) : Byte;
      procedure out_imm8(opx: TOperand; asize: Integer);
      function  Emit_Rex(var ins: TInsn): Integer;
      function  process_ea(input: TOperand; var output: T_EA; rfield : Integer; rflags: opflags_t; var ins: TInsn): ea_type;
      procedure bad_hle_warn(ins: TInsn ; hleok: Byte );
      function  calcsize(var ins: TInsn; temp: PItemplate): Int64;
      function  jmp_match(offset: Int64; var ins: TInsn; temp: pItemplate): Boolean;
      function  matches(itemp : pItemplate; instruction: TInsn): match_result;
      function  find_match(var tempp: pItemplate; instruction: TInsn; offset: Int64): match_result;
      procedure GenCode(offset: Int64; ins: TInsn; temp : pItemplate; insn_end: Int64);
      procedure SetOptimizing(const Value: UInt64);
      procedure SetOnLogMsg(const Value: TLogMsg);
      function  InternalMasmToNam(sCmd: PAnsiChar):AnsiString;
      function  Assemble_Array(const offsetStart:UInt64;const pCmdAsm: TArray<AnsiString>;var vAssembled: TTAssembled): boolean;
      function  insn_size(offset: Int64; bits: Integer; instruction: TInsn): Int64;
      function  Assemble(offset:Int64; bits : Integer; instruction: TInsn):int64;
      procedure SetBits(const Value: Byte);

   public
      constructor Create(Modo: Byte; TipoSyntax : Integer = NASM_SYNTAX);
      destructor  Destroy; override;
      procedure   Reset;
      function    Assembly_File(sFile: string; var vAssembled: TTAssembled; var StartOfs: UInt64): Boolean; overload;
      function    Assembly_File(lstString: TStringList;var vAssembled : TTAssembled; var StartOfs: UInt64):Boolean; overload;

      function    Pi_Asm(Address : Int64;sCmd: PAnsiChar ):Integer ; overload ;
      function    Pi_Asm(sCmd: PAnsiChar):Integer ; overload;

      property OnMsgLog    : TLogMsg     read FOnLogMsg     write SetOnLogMsg;
      property Encode      : TOutCmdB    read FCodeBuffer;
      property Optimizing  : UInt64      read FOptimizing   write SetOptimizing;
      property AsmSize     : Cardinal    read FLenAsmBytes;
      property DefaulOffset: UInt64      read FDefaulOffset write FDefaulOffset;
      property Errore      : Integer     read FErrore;
      property Modo        : Byte        read FBits         write SetBits;

 end;

implementation
        uses NasmLib,
             Labels;

constructor TCodeGen.Create(Modo: Byte; TipoSyntax : Integer = NASM_SYNTAX);
begin
    ResetBuffer;
    FOptimizing   := $3fffffff;
    FDefaulOffset := $00400000;

    FParser := TParserNasm.Create;

    FTipoSyntax       := TipoSyntax;

    FSegment          := NO_SEG;
    SetBits(Modo);
    FParser.GlobalRel := DEF_REL;
    FLenAsmBytes      := 0;

    FParser.Optimizing       := FOptimizing;
end;

destructor TCodeGen.Destroy;
begin
     if Assigned(FParser) then
       FParser.Free;
end;

procedure TCodeGen.DoLogMsg(Severity : Integer; strMsg : string);
(*******************************************************************************)
begin
    FErrore := 1;
    if Assigned(FOnLogMsg) then  FOnLogMsg(Severity,'[CODEGEN] -'+strMsg);
end;

procedure TCodeGen.SetBits(const Value: Byte);
var
 bit : Byte;
begin
    bit := 0;
    if      Value = 4 then  bit := PI_MODO_32
    else if Value = 8 then  bit := PI_MODO_64
    else                    bit := Value;

    FBits := bit;

    if (FBits <> PI_MODO_32) and (FBits <> PI_MODO_64) then
      raise Exception.Create('Modo Compilatore non supportatato');
end;

procedure TCodeGen.SetOnLogMsg(const Value: TLogMsg);
begin
  FOnLogMsg := Value;
  if Assigned(FParser) then
     FParser.OnMsgLog := Value;

end;

 function IsSegment(segStr : PAnsiChar):Boolean;
begin
    if System.AnsiStrings.StrLIComp(segStr, 'gs', 2) = 0 then
        Result :=  true
    else if System.AnsiStrings.StrLIComp(segStr, 'fs', 2) = 0 then
        Result :=  true
    else if System.AnsiStrings.StrLIComp(segStr, 'es', 2) = 0 then
        Result :=  true
    else if System.AnsiStrings.StrLIComp(segStr, 'ds', 2) = 0 then
        Result :=  true
    else if System.AnsiStrings.StrLIComp(segStr, 'cs', 2) = 0 then
        Result :=  true
    else if System.AnsiStrings.StrLIComp(segStr, 'ss', 2) = 0 then
        Result :=  true
    else
        Result :=  false;
end;

function TCodeGen.InternalMasmToNam(sCmd: PAnsiChar):AnsiString;
var
  stmp,stmp1 : AnsiString;
  pTmp       : PAnsiChar;
  isLea,
  isRip      : Boolean;

begin
     stmp := '';
     isLea:= False;
     isRip:= False;

     while sCmd^ <> #0 do
     begin
        if System.AnsiStrings.StrLIComp(sCmd, 'rip', 3) = 0 then //caso rip
        begin
            isRip := True;
        end
        else if System.AnsiStrings.StrLIComp(sCmd, 'lea ', 3) = 0 then //caso lea
        begin
            isLea := True;
        end
        else if System.AnsiStrings.StrLIComp(sCmd, 'ptr', 3) = 0 then //remove "ptr"
        begin
            Inc(sCmd,3);
            if(sCmd^ = ' ') then
                Inc(sCmd);
            Continue;
        end
        else if System.AnsiStrings.StrLIComp(sCmd, 'st(', 3) = 0 then //Registri St fix"
        begin
            stmp := stmp + sCmd^ + sCmd[1];
            Inc(sCmd,3);

            stmp := stmp + sCmd^;
            Inc(sCmd);

            if(sCmd^ = ')') then
                Inc(sCmd);
            Continue;
        end
        else if System.AnsiStrings.StrLIComp(sCmd, '  ', 2) = 0 then //remove double spaces
        begin
            Inc(sCmd);
            Continue
        end
        else if(sCmd^ = #9) then //tab=space
        begin
             stmp := stmp + ' ';
             Inc(sCmd);
             Continue;
        end
        else if System.AnsiStrings.StrLIComp(sCmd, 'dqword', 6) = 0 then //remove "dqword"
        begin
            Inc(sCmd,6);
            if(sCmd^ = ' ') then
                Inc(sCmd);
            Continue;
        end
        else if isLea then
        begin
             if (System.AnsiStrings.StrLIComp(sCmd, 'dword', 5) = 0) or
                (System.AnsiStrings.StrLIComp(sCmd, 'qword', 5) = 0)   then
             begin
                  Inc(sCmd,5);
                  if(sCmd^ = ' ') then
                      Inc(sCmd);
                  Continue;
             end;
        end;

        stmp := stmp + sCmd^;
        Inc(sCmd);
     end;
     // rip support
     if isRip then
       stmp := StringReplace(stmp,'rip','rel',[rfReplaceAll]);

     pTmp := PAnsiChar(AnsiString(stmp)) ;
     stmp1:= '';

     //len := System.AnsiStrings.StrLen(pTmp);
     while pTmp^ <> #0 do
     begin
        if(pTmp^ =' ') and (pTmp[1] =',') then
        begin
            inc(pTmp);
            Continue
        end
        else if(pTmp^ =',') and (pTmp[1] =' ') then
        begin
            stmp1 := stmp1 + ',';
            inc(pTmp,2);
            Continue;
        end
        else if(issegment(pTmp)) and (pTmp[3] =' ') then
        begin
            stmp1 := stmp1 + pTmp^ + pTmp[1];
            Inc(pTmp,2);
            Continue;
        end
        else if(pTmp^ =':') and (pTmp[1] =' ') then
        begin
            stmp1 := stmp1 + ':';
            Inc(pTmp);
            Continue;
        end;
        stmp1 := stmp1 + pTmp^;
        Inc(pTmp);
     end;
     //Dec(pTmp,len);
     stmp := '';

     pTmp := PAnsiChar(AnsiString(stmp1)) ;

     //len := System.AnsiStrings.StrLen(pTmp);
     while pTmp^ <> #0 do
     begin
          if(issegment(pTmp))and (pTmp[2] =':') and (pTmp[3] ='[') then
          begin
              stmp := stmp + '['+pTmp^ + pTmp[1] + ':';
              inc(pTmp,4);
              Continue;
          end;
          stmp := stmp + pTmp^;
          Inc(pTmp);

     end;
     Result := LowerCase(stmp);

     //lods
     if Pos('lods',Result) > 0  then
     begin
          if      Pos('byte',Result) > 0  then Result := 'lodsb'
          else if Pos('dword',Result) > 0  then Result := 'lodsd'
          else if Pos('qword',Result) > 0  then Result := 'lodsq'
          else if Pos('word',Result) > 0  then Result := 'lodsw'
     end;
     //movs
     if Pos('movs',Result) > 0  then
     begin
          if      Pos('byte',Result) > 0  then Result := 'movsb'
          else if Pos('dword',Result) > 0  then Result := 'movsd'
          else if Pos('qword',Result) > 0  then Result := 'movsq'
          else if Pos('word',Result) > 0  then Result := 'movsw'
     end;
     //scas
     if Pos('scas',Result) > 0  then
     begin
          if      Pos('byte',Result) > 0  then Result := 'scasb'
          else if Pos('dword',Result) > 0  then Result := 'scasd'
          else if Pos('qword',Result) > 0  then Result := 'scasq'
          else if Pos('word',Result) > 0  then Result := 'scasw'
     end;
     //stos
     if Pos('stos',Result) > 0  then
     begin
          if      Pos('byte',Result) > 0  then Result := 'stosb'
          else if Pos('dword',Result) > 0  then Result := 'stosd'
          else if Pos('qword',Result) > 0  then Result := 'stosq'
          else if Pos('word',Result) > 0  then Result := 'stosw'
     end;
     //cmps
     if Pos('cmps',Result) > 0  then
     begin
          if      Pos('byte',Result) > 0  then Result := 'cmpsb'
          else if Pos('dword',Result) > 0  then Result := 'cmpsd'
          else if Pos('qword',Result) > 0  then Result := 'cmpsq'
          else if Pos('word',Result) > 0  then Result := 'cmpsw'
     end;
     //movabs
     if Pos('movabs',Result) > 0  then
     begin
         Result := StringReplace(Result,'movabs','mov',[rfReplaceAll])
     end;
     if Pos('pushal',Result) > 0  then
     begin
           Result := StringReplace(Result,'pushal','pushad',[rfReplaceAll])
     end;
     if Pos('popal',Result) > 0  then
     begin
           Result := StringReplace(Result,'popal','popad',[rfReplaceAll])
     end;

end;

function TCodeGen.Assemble(offset:Int64; bits : Integer; instruction: TInsn):Int64;
var
  temp     : PItemplate;
  j        : Integer;
  m        : match_result;
  insn_end,
  start,
  insn_size: Int64;   (* size for DB etc. *)
  c        : Byte;

begin
      FLenAsmBytes := 0;
      start        := offset;
      FBits        := bits;

      //nel caso delle definizione delle label
      if instruction.opcode = I_none then
      begin
           Result := 0;
           Exit;
      end;

      (* Check to see if we need an address-size prefix*)
      add_asp(instruction, bits);

      m := find_match(temp, instruction, offset);

      if (m = MOK_GOOD) then   (* Matches!*)
      begin
          insn_size := calcsize(instruction, temp);
          if (insn_size < 0) then (* shouldn't be, on pass two*)
          begin
              DoLogMsg(ERR_PANIC, 'errors made it through from pass one');
          end else
          begin
              for j := 0 to MAXPREFIX -1 do
              begin
                   c := 0;
                   case instruction.prefixes[j] of
                     P_WAIT:     c := $9B;
                     P_LOCK:     c := $F0;
                     P_REPNE,
                     P_REPNZ,
                     P_XACQUIRE,
                     P_BND:      c := $F2;
                     P_REPE,
                     P_REPZ,
                     P_REP,
                     P_XRELEASE: c := $F3;
                     R_CS:
                         begin
                             if (bits = 64) then DoLogMsg(ERR_WARNING or ERR_PASS2, 'cs segment base generated, but will be ignored in 64-bit mode');
                             c := $2E;
                         end;
                     R_DS:
                         begin
                             if (bits = 64) then  DoLogMsg(ERR_WARNING or ERR_PASS2, 'ds segment base generated, but will be ignored in 64-bit mode');
                             c := $3E;
                         end;
                     R_ES:
                         begin
                             if (bits = 64) then DoLogMsg(ERR_WARNING or ERR_PASS2, 'es segment base generated, but will be ignored in 64-bit mode');
                             c := $26;
                         end;
                     R_FS: c := $64;
                     R_GS: c := $65;
                     R_SS:
                         begin
                             if (bits = 64) then DoLogMsg(ERR_WARNING or ERR_PASS2, 'ss segment base generated, but will be ignored in 64-bit mode');
                             c := $36;
                         end;
                     R_SEGR6,
                     R_SEGR7: DoLogMsg(ERR_NONFATAL, 'segr6 and segr7 cannot be used as prefixes');
                     P_A16:
                          begin
                              if (bits = 64)       then  DoLogMsg(ERR_NONFATAL,'16-bit addressing is not supported in 64-bit mode')
                              else if (bits <> 16) then c := $67;
                          end;
                     P_A32:
                          begin
                              if (bits <> 32) then c := $67;
                          end;
                     P_A64:
                          begin
                              if (bits <> 64) then DoLogMsg(ERR_NONFATAL, '64-bit addressing is only supported in 64-bit mode');
                          end;
                     P_ASP: c := $67;
                     P_O16:
                          begin
                              if (bits <> 16) then c := $66;
                          end;
                     P_O32:
                          begin
                               if (bits = 16) then c := $66;
                          end;
                     P_O64:
                          begin
                            (* REX.W*)
                          end;
                     P_OSP: c := $66;
                     P_EVEX,
                     P_VEX3,
                     P_VEX2,
                     P_NOBND,
                     P_none:
                           begin
                           end;
                   else
                      DoLogMsg(ERR_PANIC, 'invalid instruction prefix');
                   end; // case
                   if (c <> 0) then
                   begin
                      InternalOut(@c, 1,OUT_RAWDATA);
                      offset := offset + 1;
                   end;
              end ;// ciclo for prefix
              insn_end := offset + insn_size;
              gencode(offset, instruction,temp, insn_end);
              offset := offset + insn_size;
          end;
          FLenAsmBytes := offset - start;
      end else
      begin  (* No match*)
          case m of
            MERR_OPSIZEMISSING:   DoLogMsg(ERR_NONFATAL, 'operation size not specified');
            MERR_OPSIZEMISMATCH:  DoLogMsg(ERR_NONFATAL, 'mismatch in operand sizes');
            MERR_BRNUMMISMATCH:   DoLogMsg(ERR_NONFATAL, 'mismatch in the number of broadcasting elements');
            MERR_BADCPU:          DoLogMsg(ERR_NONFATAL, 'no instruction for this cpu level');
            MERR_BADMODE:         DoLogMsg(ERR_NONFATAL, format('instruction not supported in %d-bit mode',  [bits]));
            MERR_ENCMISMATCH:     DoLogMsg(ERR_NONFATAL, 'specific encoding scheme not available');
            MERR_BADBND:          DoLogMsg(ERR_NONFATAL, 'bnd prefix is not allowed');
            MERR_BADREPNE:        DoLogMsg(ERR_NONFATAL, 'repne/repnz prefix is not allowed');
          else
              DoLogMsg(ERR_NONFATAL, 'invalid combination of opcode and operands');
          end;
      end;
      Result := FLenAsmBytes;

end;

function TCodeGen.Pi_Asm(Address : Int64;sCmd: PAnsiChar):Integer ;
var
    line       : AnsiString;
    output_ins : TInsn;

begin
     FErrore            := 0;
     FParser.GlobalBits := FBits;
     Reset;
     ZeroMemory(@output_ins,SizeOf(TInsn));

     if FTipoSyntax = MASM_SYNTAX then  line  := InternalMasmToNam(sCmd)
     else                               line  := sCmd ;

     FParser.parse_line(1, @line[1], output_ins,nil);

     // errore parsing non trovato opcode o identificatore
     if (output_ins.opcode = - 1) or (FParser.Errore <> 0) then
     begin
         if (output_ins.opcode = - 1) then
            raise Exception.Create('[PARSING]- Identificatore sconosciuto Istruzione '+ '"'+string(line)+'"')
         else
            raise Exception.Create('[PARSING]- Errore nel parsing dell''Istruzione '+ '"'+string(line)+'"')
     end;

     Assemble(Address, FBits, output_ins);
     Result := FLenAsmBytes;

     if FErrore <> 0 then
         DoLogMsg(ERR_NONFATAL, 'Warning!! nella compilazione dell''Istruzione '+ '"'+string(line)+'"');
         //  raise Exception.Create('[CODEGEN]- Errore nella compilazione dell''Istruzione '+ '"'+string(line)+'"');

end;

function TCodeGen.Pi_Asm(sCmd: PAnsiChar):Integer ;
begin
     Result := Pi_Asm(0,sCmd)
end;

function TCodeGen.Assembly_File(lstString: TStringList;var vAssembled : TTAssembled; var StartOfs: UInt64):Boolean;
var
  nCount  : Integer;
  pCmdAsm : TArray<AnsiString>;
  linea   : AnsiString;
  pBits,
  pComm   : Integer;
  Ofs     : UInt64;
begin
     ofs   := $FFFFFFFF;

     try
       ///file to array
       SetLength(pCmdAsm,0);
       nCount := 0;
       while nCount <= (lstString.Count - 1) do
       begin
           linea := lstString[nCount];
           linea := StringReplace(linea, #9, ' ', [rfReplaceAll]);

           pBits := Pos('bits',LowerCase(Linea));
           pComm := Pos(';',LowerCase(Linea));

           if ( pBits > 0) and( (pComm = 0) or ( (pComm > 0) and (pComm > pBits) ) ) then
           begin
                if      (Pos('64',LowerCase(Linea)) > 0) then FBits := 64
                else if (Pos('32',LowerCase(Linea)) > 0) then FBits := 32
                else if (Pos('16',LowerCase(Linea)) > 0) then FBits := 16
                else begin
                     DoLogMsg(ERR_NONFATAL,'errore nello specificare numero bits programma');
                     Result := False;
                     Exit;
                end;

                SetLength(pCmdAsm,Length(pCmdAsm)+1);
                pCmdAsm[High(pCmdAsm)] := 'Bits '+ Inttostr(FBits);

                Inc(nCount);
                Continue;
           end;

           if linea <> '' then
             linea := nasm_skip_spaces(@linea[1]);

           if Pos(';<',LowerCase(Linea)) > 0 then
              ofs := StrToUInt64('$'+ Copy(linea, 3, length(Linea)- 3));

           if (linea = '') then
           begin
                Inc(nCount);
                Continue;
           end;
           if linea[1] = ';' then
           begin
               Inc(nCount);
               Continue;
           end;

           SetLength(pCmdAsm,Length(pCmdAsm)+1);
           pCmdAsm[High(pCmdAsm)] := linea;

           Inc(nCount);
       end;
     finally

     end;

     if ofs = $FFFFFFFF then Ofs := FDefaulOffset;
     StartOfs := Ofs;

     Result :=  Assemble_Array(ofs,pCmdAsm,vAssembled) ;

end;

function TCodeGen.Assembly_File(sFile: string;var vAssembled : TTAssembled; var StartOfs: UInt64):Boolean;
var
  tx      : TStreamReader;
  pCmdAsm : TArray<AnsiString>;
  linea   : AnsiString;
  pBits,
  pComm   : Integer;
  Ofs     : UInt64;
begin
     ofs   := $FFFFFFFF;
     tx    := TStreamReader.Create(sFile);
     try
       ///file to array
       SetLength(pCmdAsm,0);

       while not tx.EndOfStream do
       begin
           linea := tx.ReadLine;
           linea := StringReplace(linea, #9, ' ', [rfReplaceAll]);


           pBits := Pos('bits',LowerCase(Linea));
           pComm := Pos(';',LowerCase(Linea));

           if ( pBits > 0) and( (pComm = 0) or ( (pComm > 0) and (pComm > pBits) ) ) then
           begin
                if      (Pos('64',LowerCase(Linea)) > 0) then FBits := 64
                else if (Pos('32',LowerCase(Linea)) > 0) then FBits := 32
                else if (Pos('16',LowerCase(Linea)) > 0) then FBits := 16
                else begin
                     DoLogMsg(ERR_NONFATAL,'errore nello specificare numero bits programma');
                     Result := False;
                     Exit;
                end;

                SetLength(pCmdAsm,Length(pCmdAsm)+1);
                pCmdAsm[High(pCmdAsm)] := 'Bits '+ Inttostr(FBits);
                Continue;
           end;

           if linea <> '' then
             linea := nasm_skip_spaces(@linea[1]);

           if Pos(';<',LowerCase(Linea)) > 0 then
              ofs := StrToUInt64('$'+ Copy(linea, 3, length(Linea)- 3));

           if (linea = '') then   Continue;
           if linea[1] = ';' then Continue;

           SetLength(pCmdAsm,Length(pCmdAsm)+1);
           pCmdAsm[High(pCmdAsm)] := linea;
       end;
     finally
         tx.Free;
     end;

     if ofs = $FFFFFFFF then Ofs := FDefaulOffset;
     StartOfs := Ofs;

     Result :=  Assemble_Array(ofs,pCmdAsm,vAssembled) ;

end;

function TCodeGen.Assemble_Array(const offsetStart:UInt64;const  pCmdAsm: TArray<AnsiString>; var vAssembled : TTAssembled):boolean;
var
  linea       : AnsiString;
  output_ins  : TInsn;
  bits        : Byte;
  x,Passn,Pass1,
  Pass0       : Integer;
  l, offs     : UInt64;
  lDef        : TLDEF;

begin
     bits  := FBits;

     lab := TLab.Create;
     try
       Location.known   := False;
       Location.segment := NO_SEG;

       Passn := 1;
       Pass0 := 0;
       repeat
             SetLength(vAssembled,0);
             offs  := offsetStart;
             Result:= False;

             if Pass0 = 4  then Pass1 := 4
             else               Pass1 := 1;

             if   Passn > 1  then lDef := lab.redefine_label
             else                 lDef := lab.define_label;

             if   Passn = 1 then Location.known := True;

             Location.offset       := offs;
             Global_offset_changed := 0;

             for x := 0 to  High(pCmdAsm) do
             begin
                 linea := pCmdAsm[x];

                 if  Pos('bits',LowerCase(string(Linea))) > 0 then
                 begin
                      if      (Pos('64',LowerCase(string(Linea))) > 0) then bits := 64
                      else if (Pos('32',LowerCase(string(Linea))) > 0) then bits := 32
                      else if (Pos('16',LowerCase(string(Linea))) > 0) then bits := 16;
                      Continue;
                 end;
                 // reset
                 FErrore            := 0;
                 FParser.GlobalBits := bits;
                 Reset;
                 ZeroMemory(@output_ins,SizeOf(TInsn));

                 if FTipoSyntax = MASM_SYNTAX then  linea  := InternalMasmToNam(@linea[1])
                 else                               linea  := linea ;
                 // parser linea
                 //=============
                 FParser.parse_line(Pass1, @linea[1], output_ins,lDef);

                 // errore parsing non trovato opcode o identificatore
                 if {(output_ins.opcode = - 1) or}(FParser.Errore <> 0) then
                 begin
                     if (output_ins.opcode = - 1) then
                        raise Exception.Create('[PARSING]- Identificatore sconosciuto Istruzione '+ '"'+string(linea)+'"')
                     else
                        raise Exception.Create('[PARSING]- Errore nel parsing dell''Istruzione '+ '"'+string(linea)+'"')
                 end;

                 if Pass1 = 1 then
                 begin
                     l := insn_size(offs, bits, output_ins);
                     if (l <> -1) then
                         offs := offs + l;
                 end else
                 begin
                       // assemble
                       offs := offs + Assemble(offs, bits, output_ins);
                       if FErrore <> 0 then
                         DoLogMsg(ERR_NONFATAL, 'Warning!! nella compilazione dell''Istruzione '+ '"'+string(linea)+'"');

                       Result := True;

                       if Length(FCodeBuffer) > 0 then
                       begin
                           SetLength(vAssembled,Length(vAssembled)+1);
                           vAssembled[High(vAssembled)].Address := offs - Length(FCodeBuffer);
                           vAssembled[High(vAssembled)].Bytes   := FCodeBuffer;
                       end;
                 end;
                 // Aggiorna offset
                 Location.offset := offs;
             end;

             if ((passn > 1) and (Global_offset_changed = 0)) {or (pass0 = 4) }then Inc(Pass0);
             inc(Passn);
       until Pass0 > 4;
     finally
       lab.Free;
     end;
end;


procedure TCodeGen.SetOptimizing(const Value: UInt64);
begin
  FOptimizing        := Value;
  FParser.Optimizing := FOptimizing;
end;

procedure TCodeGen.Reset;
begin
     ResetBuffer;
end;


procedure TCodeGen.ResetBuffer;
(***************************************)
begin
     FCurrent_loc   := 0;
     FBytes_Written := 0;

     SetLength(FCodeBuffer,0);
end;

procedure TCodeGen.OutputByte( vbyte : Byte) ;
(***********************************)
begin
     FCurrent_loc   := FCurrent_loc +1 ;
     FBytes_written := FBytes_written + 1;

     SetLength(FCodeBuffer,Length(FCodeBuffer)+1);
     FCodeBuffer[High(FCodeBuffer)]  := vbyte;

end;

procedure TCodeGen.OutputCodeByte( vbyte : Byte );
(***************************************)
begin
     OutputByte( vbyte );
end;

procedure TCodeGen.FillDataBytes( vbyte : Byte; len: Integer );
(***************************************************)
var
  i : Integer;
begin

    for i := 0  to len - 1 do
        OutputByte( vbyte );
end;

procedure TCodeGen.OutData(data: PByte; size: Cardinal);
var
  i : Integer;
begin
     for i := 0 to size - 1  do
      OutputCodeByte(data[i])

end;


(*
 * Find N value for compressed displacement (disp8 * N)
 *)
function TCodeGen.get_disp8N(ins: TInsn) : UInt8;
  const fv_n:array[0..1,0..1,0..VLMAX-1]of  UInt8 =  ( ( ( 16 ,  32 ,  64 )  ,( 4 ,  4 ,  4 ) ) ,
                                                       ( ( 16 ,  32 ,  64 ) ,( 8 ,  8 ,  8 ) ) ) ;
  const hv_n:array[0..1,0..VLMAX-1]     of  UInt8 =  ( ( 8 ,  16 ,  32 ) ,  ( 4 ,  4 ,  4 ) ) ;
  const dup_n:array[0..VLMAX-1]         of  UInt8 =  ( 8 ,  32 ,  64 ) ;

  function BoolToByte(b:Boolean): Byte;
  begin
       if b then  Result := 1
       else       Result := 0;
  end;
var
  evex_b,
  evex_w : Boolean;
  tuple  : ttypes;
  vectlen: vectlens;
  n      : UInt8;
begin
    evex_b := Boolean( (ins.evex_p[2] and EVEX_P2B) shr 4);
    tuple  := ins.evex_tuple;
    vectlen:= (ins.evex_p[2] and EVEX_P2LL) shr 5;
    evex_w := Boolean( (ins.evex_p[1] and EVEX_P1W) shr 7);
    n      := 0;

    case tuple of
     FV:    n := fv_n[BoolToByte(evex_w)][BoolToByte(evex_b)][vectlen];
     HV:    n := hv_n[BoolToByte(evex_b)][vectlen];
     FVM:   n := 1 shl (vectlen + 4);         (* 16, 32, 64 for VL 128, 256, 512 respectively*)
     T1S8,                                    (* N = 1 *)
     T1S16: n := tuple - T1S8 + 1;            (* N = 2 *)
     T1S:   n := IfThen(evex_w, 8 ,4);        (* N = 4 for 32bit, 8 for 64bit *)
     T1F32,
     T1F64: n := IfThen( (tuple = T1F32),4,8);(* N = 4 for 32bit, 8 for 64bit *)
     T2,
     T4,
     T8:begin
            if (vectlen + 7 <= (BoolToByte(evex_w) + 5) + (tuple - T2 + 1)) then
                n := 0
            else
                n := 1 shl (tuple - T2 + BoolToByte(evex_w) + 3);
        end;
     HVM,
     QVM,
     OVM:   n := 1 shl (OVM - tuple + vectlen + 1);
     M128:  n := 16;
     DUP:   n := dup_n[vectlen];
    else
    end;

    Result := n;
end;

(*
 * Check if offset is a multiple of N with corresponding tuple type
 * if Disp8*N is available, compressed displacement is stored in compdisp
 *)
function TCodeGen.is_disp8n(input: TOperand; ins: TInsn; var compdisp: Int8): Boolean;
var
  off, disp8 : Int32;
  n          : UInt8;

begin
    off := input.offset;
    n   := get_disp8N(ins);

    if (n <> 0) and ( (off and (n - 1)) = 0)   then
    begin
        disp8 := off div n;
        (* if it fits in Disp8 *)
        if (disp8 >= -128) and (disp8 <= 127) then
        begin
            compdisp := disp8;
            Result   := True;
            Exit;
        end;
    end;

    compdisp := 0;
    Result   := False;
end;

function TCodeGen.GEN_SIB(scale, index, base: Byte) : Byte;
begin
    Result := (((scale) shl 6) or ((index) shl 3) or ((base)))
end;

function TCodeGen.GEN_MODRM(mod_, reg, rm: Byte ): Byte;
begin
     Result := (((mod_) shl 6) or (((reg) and 7) shl 3) or ((rm) and 7))
end;


function TCodeGen.size_name(size: Integer): string;
begin
    case size of
     1: Result :=  'byte';
     2: Result :=  'word';
     4: Result :=  'dword';
     8: Result :=  'qword';
     10:Result :=  'tword';
     16:Result :=  'oword';
     32:Result :=  'yword';
     64:Result :=  'zword';
    else  Result :=  '???';
    end;
end;

function TCodeGen.overflow_general(value: Int64; vbytes: Integer): Boolean;
var
    sbit       : Integer;
    vmax, vmin : Int64;
begin
     if vbytes >= 8 then
     begin
        Result := False;
        Exit;
     end;

     sbit := (vbytes shl 3) - 1;
     vmax :=  (int64(2) shl sbit) - 1;
     vmin := -(int64(1) shl sbit);

     Result := (value < vmin) or (value > vmax);
end ;

function TCodeGen.overflow_signed(value: Int64; bytes: Integer): Boolean;
var
  sbit       : Integer;
  vmax, vmin : int64;
begin
    if (bytes >= 8) then
    begin
        Result := False;
        Exit;
    end;

    sbit := (bytes shl 3) - 1;
    vmax :=  (Int64(1) shl sbit) - 1;
    vmin := -(Int64(1) shl sbit);

    Result := (value < vmin) or (value > vmax);
end;

procedure TCodeGen.warn_overflow(pass, size: Integer);
begin
    nasm_Errore(ERR_WARNING or pass or ERR_WARN_NOV,
            Format('%s data exceeds bounds', [size_name(size)]));
end;


procedure TCodeGen.warn_overflow_opd(o: TOperand; size: Integer);
begin
    if (o.wrt = NO_SEG) and (o.segment = NO_SEG) then
        if overflow_general(o.offset, size) then
            warn_overflow(ERR_PASS2, size);

end;

function TCodeGen.signed_bits(value: Int64; bits: Integer): Int64;
begin
    if (bits < 64) then
    begin
        value := value and ( (Int64(1) shl bits) - 1);
        if (value and (Int64(1) shl (bits - 1)))  <> 0 then
            value := value or (Int64(-1) shl bits);
    end;
    Result := value;
end;

procedure TCodeGen.WRITEADDR(Dest,Src: Pointer;Size : NativeUInt);
begin
     CopyMemory(Dest,Src,Size);
end;

(*
 * This routine wrappers the real output format's output routine,
 * in order to pass a copy of the data off to the listing file
 * generator at the same time.
 *)
procedure TCodeGen.InternalOut(data: Pointer; size: UInt64; tipo: out_type);
var
 p : array[0..7] of Byte;
 q : PByte;
begin
    if (tipo = OUT_ADDRESS)  then
    begin
        (*
         * This is a non-relocated address, and we're going to
         * convert it into RAWDATA format.
         *)
        q := @p[0];

        size := abs(Integer(size));
        if (size > 8) then
        begin
            DoLogMsg(ERR_PANIC, 'OUT_ADDRESS with size > 8');
            Exit;
        end;

        WRITEADDR(q, data, size);
        data := @p[0];
    end;

    OutData(data, size);

end;


(* Verify value to be a valid register *)
function TCodeGen.is_register(reg: Integer): Boolean;
begin
     Result := (reg >= EXPR_REG_START) and (reg < REG_ENUM_LIMIT);
end;

function TCodeGen.regval(o: TOperand): int32;
begin
    if not is_register(o.basereg) then
        nasm_Errore(ERR_PANIC, 'invalid operand passed to regval()');

    Result :=  nasm_regvals[o.basereg];
end;

function TCodeGen.regflag(o: TOperand): UInt64;
begin
    if  not is_register(o.basereg) then
        nasm_Errore(ERR_PANIC, 'invalid operand passed to regflag()');

    Result := nasm_reg_flags[o.basereg];
end;

function TCodeGen.evexflags(nval: Integer; deco: Word; mask: Integer; nbyte : Byte): Integer;
var
   evex : Integer;
begin
    evex := 0;

    case nbyte of
     0:
      begin
         if (nval >= 0) and  ((nval and 16)<> 0) then
             evex := evex or (EVEX_P0RP or EVEX_P0X);
      end;
     2:
      begin
          if (nval >= 0) and ((nval and 16)<>0 ) then   evex := evex or EVEX_P2VP;
          if (deco and Z) <> 0                   then   evex := evex or EVEX_P2Z;
          if (deco and OPMASK_MASK) <> 0         then   evex := evex or (deco and EVEX_P2AAA);
      end;
    end;

    Result := evex and mask;
end;

function TCodeGen.op_evexflags(o: TOperand;mask: Integer; nbyte: Byte): Integer;
var
    nval : Integer;
begin
    nval  := nasm_regvals[o.basereg];

    Result:= evexflags(nval, o.decoflags, mask, nbyte);
end;

function TCodeGen.rexflags(nVal: Integer; flags: opflags_t; mask: Integer): Integer;
var
  rex : Integer;
begin
    rex := 0;

    if (nVal >= 0) and ( (nVal and 8) <> 0 ) then  rex := rex or REX_B or REX_X or REX_R;

    if (flags and BITS64) <> 0 then  rex := rex or REX_W;
    (* AH, CH, DH, BH *)
    if   (REG_HIGH and  (not flags)) = 0  then rex := rex  or REX_H
    (* SPL, BPL, SIL, DIL *)
    else if  ((REG8 and (not flags)= 0)) and (nVal >= 4)   then   rex := rex or REX_P;

    Result := rex and mask;
end;


function TCodeGen.op_rexflags(o: TOperand;mask: Integer): Integer;
var
  flags : opflags_t;
  nVal  : Integer;
begin

    if not is_register(o.basereg) then
        nasm_Errore(ERR_PANIC, 'invalid operand passed to op_rexflags()');

    flags := nasm_reg_flags[o.basereg];
    nVal  := nasm_regvals[o.basereg];

    Result := rexflags(nVal, flags, mask);
end;

procedure TCodeGen.add_asp(var ins : TInsn; addrbits: Cardinal);
var
  j, valid,
  defdisp,
  ds        : Integer;
  i, b      : opflags_t;
begin
    valid := IfThen(addrbits = 64,64 or 32, 32 or 16) ;


    case ins.prefixes[PPS_ASIZE] of
      P_A16: valid := valid and 16;
      P_A32: valid := valid and 32;
      P_A64: valid := valid and 64;
      P_ASP: valid := valid and IfThen(addrbits = 32,16, 32)
    end;

    for j := 0 to ins.operands - 1  do
    begin
        if (is_class(MEMORY, ins.oprs[j].tipo)) then
        begin
            (* Verify as Register *)
            if  not is_register(ins.oprs[j].indexreg) then
                i := 0
            else
                i := nasm_reg_flags[ins.oprs[j].indexreg];

            (* Verify as Register *)
            if not is_register(ins.oprs[j].basereg) then
                b := 0
            else
                b := nasm_reg_flags[ins.oprs[j].basereg];

            if (ins.oprs[j].scale = 0) then
                i := 0;

            if (i = 0) and (b = 0) then
            begin
                ds := ins.oprs[j].disp_size;
                if ( (addrbits <> 64) and (ds > 8)) or ((addrbits = 64) and (ds = 16)) then
                    valid := valid and ds;
            end else
            begin
                if ((REG16 and (not b))= 0) then  valid := valid and 16;
                if ((REG32 and (not b))= 0) then  valid := valid and 32;
                if ((REG64 and (not b))= 0) then  valid := valid and 64;

                if ((REG16 and (not i))= 0) then  valid := valid and 16;
                if ((REG32 and (not i))= 0) then  valid := valid and 32;
                if ((REG64 and (not i))= 0) then  valid := valid and 64;
            end;
        end;
    end;

    if (valid and addrbits) <> 0 then
    begin
        ins.addr_size := addrbits;
    end
    else if valid and IfThen(addrbits = 32,16,32) <> 0 then
    begin
        (* Add an address size prefix *)
        ins.prefixes[PPS_ASIZE] :=  IfThen(addrbits = 32, P_A16, P_A32);
        ins.addr_size           :=  IfThen(addrbits = 32, 16, 32);
    end else
    begin
        (* Impossible... *)
        nasm_Errore(ERR_NONFATAL, 'impossible combination of address sizes');
        ins.addr_size := addrbits; (* Error recovery *)
    end;

    defdisp := IfThen(ins.addr_size = 16, 16, 32);

    for j := 0 to ins.operands - 1 do
    begin
        if (MEM_OFFS and  (not ins.oprs[j].tipo) = 0) and
           (IfThen(ins.oprs[j].disp_size <> 0, ins.oprs[j].disp_size,defdisp) <> ins.addr_size) then
        begin
             (*
              * mem_offs sizes must match the address size; if not,
              * strip the MEM_OFFS bit and match only EA instructions
              *)
              ins.oprs[j].tipo :=  ins.oprs[j].tipo and (not(MEM_OFFS and ( not MEMORY)));

        end;
    end;

end;

function TCodeGen.itemp_has(itemp: pItemplate; vbit: Cardinal): Boolean;

     function iflag_test(f: iflag_t; bit: Cardinal): Cardinal;
     var
       index : Cardinal;
     begin
          index  := bit div 32;
          Result := f[index] and (NativeUInt(1) shl (bit - (index * 32)));
     end;
begin
     Result := iflag_test(insns_flags[itemp^.iflag_idx], vbit) > 0 ;
end;

function  TCodeGen._itemp_smask(idx: Integer):Cardinal;
begin
    Result := (insns_flags[idx][0] and IF_SMASK)
end;

function  TCodeGen._itemp_armask(idx: Integer):Cardinal;
begin
    Result := (insns_flags[idx][0] and IF_ARMASK)
end;

function  TCodeGen._itemp_arg(idx: Integer):Cardinal;
begin
    Result := (_itemp_armask(idx) shr IF_AR0) - 1
end;


function TCodeGen.itemp_smask(itemp: pItemplate): Cardinal;
begin
     Result :=  _itemp_smask(itemp^.iflag_idx)
end;

function TCodeGen.itemp_armask(itemp: pItemplate): Cardinal;
begin
     Result :=  _itemp_armask(itemp^.iflag_idx)
end;

function TCodeGen.itemp_arg(itemp: pItemplate): Cardinal;
begin
     Result :=  _itemp_arg(itemp^.iflag_idx)
end;

// calcolo {1to<brcast_num>}
function TCodeGen.get_broadcast_num(opflags: opflags_t; brsize: opflags_t): Byte;
var
  opsize    : opflags_t;
  brcast_num: Byte;
begin
    opsize := opflags and SIZE_MASK;

    (*
     * Due to discontinuity between BITS64 and BITS128 (BITS80),
     * this cannot be a simple arithmetic calculation.
     *)
    if (brsize > BITS64) then
        nasm_Errore(ERR_FATAL, 'size of broadcasting element is greater than 64 bits');

    if opsize  = BITS64 then  brcast_num := BITS64 div brsize
    else                      brcast_num := (opsize div BITS128) * (BITS64 div brsize) * 2;

    Result := brcast_num;
end;

function TCodeGen.has_prefix(ins: TInsn; vpos: prefix_pos; prefix: Integer): Boolean;
begin
    Result := ins.prefixes[vpos] = prefix;
end;

procedure TCodeGen.assert_no_prefix(ins: TInsn; pos: prefix_pos) ;
begin
    if (ins.prefixes[pos]) <> 0 then
        nasm_Errore(ERR_NONFATAL, Format('invalid %s prefix',[ prefix_name(ins.prefixes[pos]) ]) );
end;


function TCodeGen.get_cond_opcode(c: ccode) : Byte;
const
    ccode_opcodes : array[0..29] of Byte = ( $7, $3, $2, $6, $2, $4, $f, $d, $c, $e, $6, $2,
                                             $3, $7, $3, $5, $e, $c, $d, $f, $1, $b, $9, $5,
                                             $0, $a, $a, $b, $8, $4);
begin
     Result := ccode_opcodes[c];
end;

procedure TCodeGen.out_imm8(opx: TOperand; asize: Integer);
var
  data  : UInt64;
  vbyte : Byte;
begin
    if (opx.segment <> NO_SEG) then
    begin
        data := opx.offset;
        InternalOut(@data, asize,OUT_ADDRESS);
    end else
    begin
        vbyte := opx.offset;
        InternalOut(@vbyte, 1,OUT_RAWDATA);
    end;
end;

function TCodeGen.Emit_Rex(var ins: TInsn): Integer;
var
  rex : Integer;
begin
    if (Fbits = 64) then
    begin
        if ((ins.rex and REX_MASK)<> 0) and
           ((ins.rex and(REX_V or REX_EV) )= 0)  and
           (ins.rex_done = False) then
        begin
            rex := (ins.rex and REX_MASK) or REX_P;
            InternalOut(@rex, 1,OUT_RAWDATA);
            ins.rex_done := true;
            result := 1;
            Exit;
        end;
    end;

    result := 0;
end;


function TCodeGen.process_ea(input: TOperand; var output: T_EA; rfield : Integer; rflags: opflags_t; var ins: TInsn): ea_type;
var
  forw_ref : Boolean;
  addrbits,
  eaflags  : Integer;

  seg      : Int32;
  i,b,s,
  hb,ht,
  t,it,bt  : Integer;  (* register numbers *)
  x, ix, bx: opflags_t;(* register flags *)

  sok      : opflags_t;
  o        : Int32 ;
  rm,
  _mod,
  scale,
  index,
  base,
  tmp     : Integer;

  label err;

          (*
           * Check if ModR/M.mod should/can be 01.
           * - EAF_BYTEOFFS is set
           * - offset can fit in a byte when EVEX is not used
           * - offset can be compressed when EVEX is used
           *)
          function IS_MOD_01: Boolean;
          begin
               Result :=

               ((input.eaflags and EAF_BYTEOFFS) <> 0) or
               (
                (o >= -128) and (o <= 127) and
                (seg = NO_SEG) and  ( not forw_ref) and
                ((input.eaflags and EAF_WORDOFFS)= 0) and
                ((ins.rex and REX_EV)= 0)
               ) or
               (
                ((ins.rex and REX_EV) <> 0) and
                (is_disp8n(input, ins, output.disp8))
               ) ;
          end;


begin
    forw_ref := (input.opflags and OPFLAG_UNKNOWN) <> 0;
    addrbits := ins.addr_size;
    eaflags  := input.eaflags;

    output.tipo    := EA_SCALAR;
    output.rip     := 0;
    output.disp8   := 0;

    (* REX flags for the rfield operand *)
    output.rex     := output.rex or rexflags(rfield, rflags, REX_R or REX_P or REX_W or REX_H);
    (* EVEX.R' flag for the REG operand *)
    ins.evex_p[0]  :=  ins.evex_p[0] or evexflags(rfield, 0, EVEX_P0RP, 0);

    if (is_class(REGISTER_, input.tipo)) then
    begin
        (*
         * It's a direct register.
         *)
        if not is_register(input.basereg)  then  goto err;

        if not is_reg_class(REG_EA, input.basereg) then  goto err;

        (* broadcasting is not available with a direct register operand. *)
        if (input.decoflags and BRDCAST_MASK) <> 0 then
        begin
            DoLogMsg(ERR_NONFATAL, 'Broadcasting not allowed from a register');
            goto err;
        end;

        output.rex         := output.rex or op_rexflags(input, REX_B or REX_P or REX_W or REX_H);
        ins.evex_p[0]      := ins.evex_p[0] or op_evexflags(input, EVEX_P0X, 0);
        output.sib_present := 0;        (* no SIB necessary *)
        output.bytes       := 0;        (* no offset necessary either *)
        output.modrm       := GEN_MODRM(3, rfield, nasm_regvals[input.basereg]);
    end else
    begin
        (*
         * It's a memory reference.
         *)

        (* Embedded rounding or SAE is not available with a mem ref operand. *)
        if (input.decoflags and (ER or SAE)) <> 0 then
        begin
            DoLogMsg(ERR_NONFATAL, 'Embedded rounding is available only with reg-reg op.');
            Result := UInt8(-1);
            Exit;
        end;

        if (input.basereg = -1) and ((input.indexreg = -1) or (input.scale = 0)) then
        begin
            (*
             * It's a pure offset.
             *)
            if (Fbits = 64) and ((input.tipo and IP_REL)  = IP_REL) and (input.segment = -3{NO_SEG}) then
            begin
                DoLogMsg(ERR_WARNING or ERR_PASS1, 'absolute address can not be RIP-relative');
                input.tipo := input.tipo and (not IP_REL);
                input.tipo := input.tipo or MEMORY;
            end;

            if (Fbits = 64) and  ((IP_REL and (not input.tipo))= 0) and ((eaflags and EAF_MIB) <> 0) then
            begin
                DoLogMsg(ERR_NONFATAL, 'RIP-relative addressing is prohibited for mib.');
                Result := UInt8(-1);
                Exit;
            end;

            if ((eaflags and EAF_BYTEOFFS) <> 0) then
              DoLogMsg(ERR_WARNING or ERR_PASS1, 'displacement size ignored on absolute address');

            if ((eaflags and EAF_WORDOFFS) <> 0)  then
            begin
                 if addrbits <> 16 then
                 begin
                      if (input.disp_size <> 32) then
                         DoLogMsg(ERR_WARNING or ERR_PASS1, 'displacement size ignored on absolute address');
                 end else
                 begin
                      if (input.disp_size <> 16) then
                         DoLogMsg(ERR_WARNING or ERR_PASS1, 'displacement size ignored on absolute address');
                 end;
            end;

            if (Fbits = 64) and ( ((not input.tipo) and IP_REL) <> 0) then
            begin
                output.sib_present := 1;
                output.sib         := GEN_SIB(0, 4, 5);
                output.bytes       := 4;
                output.modrm       := GEN_MODRM(0, rfield, 4);
                output.rip         := 0;
            end else
            begin
                output.sib_present := 0;
                if addrbits <> 16 then   output.bytes := 4
                else                     output.bytes := 2;
                if addrbits <> 16 then   output.modrm := GEN_MODRM(0, rfield, 5)
                else                     output.modrm := GEN_MODRM(0, rfield, 6);
                if Fbits = 64 then  output.rip := 1
                else               output.rip := 0;
            end;
        end else
        begin
            (*
             * It's an indirection.
             *)
            i   := input.indexreg; b := input.basereg; s := input.scale;
            seg := input.segment;
            hb  := input.hintbase; ht := input.hinttype;

            if (s = 0) then i := -1; (* make this easy, at least *)

            if is_register(i) then
            begin
                it := nasm_regvals[i];
                ix := nasm_reg_flags[i];
            end else
            begin
                it := -1;
                ix := 0;
            end;

            if is_register(b) then
            begin
                bt := nasm_regvals[b];
                bx := nasm_reg_flags[b];
            end else
            begin
                bt := -1;
                bx := 0;
            end;

            (* if either one are a vector register... *)
             if ( (ix or bx )  and  ( XMMREG or YMMREG or ZMMREG )  and  (not REG_EA) <> 0) then
             begin
                 sok := BITS32 or BITS64;
                 o   := input.offset;
                (*
                 * For a vector SIB, one has to be a vector and the other,
                 * if present, a GPR.  The vector must be the index operand.
                 *)
                if ( ( it =  - 1 ) or (  ( bx and  ( XMMREG or YMMREG or ZMMREG )  and  not REG_EA ) <> 0 ) ) then
                begin
                     if       ( s =  0 ) then   s :=  1
                     else if ( s <>  1 ) then   goto err ;
                     t :=  bt ;  bt :=  it ;  it :=  t ;
                     x :=  bx ;  bx :=  ix ;  ix :=  x ;
                end;
                if (bt <> -1) then
                begin
                    if (REG_GPR and (not bx)) <> 0 then
                        goto err;
                    if ((REG64 and ( not bx) )= 0) or ((REG32 and ( not bx) )= 0) then
                        sok := sok and bx
                    else
                        goto err;
                end;

                (*
                 * While we're here, ensure the user didn't specify
                 * WORD or QWORD
                 *)
                if (input.disp_size = 16) or (input.disp_size = 64) then
                    goto err;

                if (addrbits = 16) or ((addrbits = 32) and ( (sok and BITS32)= 0) ) or  ((addrbits = 64) and ( (sok and BITS64)= 0) )  then
                    goto err;

                output.tipo :=  IfThen((ix and  ZMMREG and  (not REG_EA) ) <> 0,  EA_ZMMVSIB,
                                IfThen((ix and  YMMREG and  (not REG_EA) ) <> 0, EA_YMMVSIB  , EA_XMMVSIB ) )  ;

                output.rex    := output.rex or rexflags(it, ix, REX_X);
                output.rex    := output.rex or rexflags(bt, bx, REX_B);
                ins.evex_p[2] := ins.evex_p[2] or evexflags(it, 0, EVEX_P2VP, 2);

                index := it and 7; (* it is known to be != -1 *)

                case s of
                 1:scale := 0;
                 2:scale := 1;
                 4:scale := 2;
                 8:scale := 3;
                else             (* then what the smeg is it? *)
                    goto err;    (* panic *)
                end;

                if (bt = -1) then
                begin
                    base := 5;
                    _mod := 0;
                end else
                begin
                    base := (bt and 7);
                    if (base <> REG_NUM_EBP) and (o = 0) and (seg = NO_SEG) and ( not forw_ref) and
                        ((eaflags and (EAF_BYTEOFFS or EAF_WORDOFFS)) = 0)  then
                        _mod := 0
                    else if (IS_MOD_01())  then
                        _mod := 1
                    else
                        _mod := 2;
                end;

                output.sib_present := 1;
                output.bytes       := IfThen((bt = -1) or (_mod = 2), 4 , _mod);
                output.modrm       := GEN_MODRM(_mod, rfield, 4);
                output.sib         := GEN_SIB(scale, index, base);
            end
            else if ((ix or bx) and (BITS32 or BITS64)) <> 0 then
            begin
                (*
                 * it must be a 32/64-bit memory reference. Firstly we have
                 * to check that all registers involved are type E/Rxx.
                 *)
                sok := BITS32 or BITS64;
                o   := input.offset;

                if (it <> -1) then
                begin
                    if ((REG64 and ( not ix))= 0) or ((REG32 and ( not ix))= 0) then
                        sok := sok and ix
                    else
                        goto err;
                end;

                if (bt <> -1) then
                begin
                    if (REG_GPR and ( not bx)) <> 0 then
                        goto err; (* Invalid register *)
                    if ( ( not sok) and bx and SIZE_MASK) <> 0 then
                        goto err; (* Invalid size *)
                    sok := sok and bx;
                end;

                (*
                 * While we're here, ensure the user didn't specify
                 * WORD or QWORD
                 *)
                if (input.disp_size = 16) or (input.disp_size = 64) then
                    goto err;

                if (addrbits = 16) or
                   ( (addrbits = 32) and ((sok and BITS32)= 0) ) or
                   ( (addrbits = 64) and ((sok and BITS64)= 0) )  then
                    goto err;

                (* now reorganize base/index *)
                if (s = 1) and (bt <> it) and (bt <> -1) and (it <> -1) and
                    (( (hb = b) and (ht = EAH_NOTBASE ) ) or
                     ( (hb = i) and (ht = EAH_MAKEBASE) )) then
                begin
                    (* swap if hints say so *)
                    t := bt; bt := it; it := t;
                    x := bx; bx := ix; ix := x;
                end;

                if (bt = -1) and (s = 1) and ( not ((hb = i) and (ht = EAH_NOTBASE))) then
                begin
                    (* make single reg base, unless hint *)
                    bt := it; bx := ix; it := -1; ix := 0;
                end;

                if (eaflags and EAF_MIB) <> 0 then
                begin
                    (* only for mib operands *)
                    if (it = -1) and ((hb = b) and (ht = EAH_NOTBASE)) then
                    begin
                        (*
                         * make a single reg index [reg*1].
                         * gas uses this form for an explicit index register.
                         *)
                        it := bt; ix := bx; bt := -1; bx := 0; s := 1;
                    end;
                    if (ht = EAH_SUMMED) and (bt = -1) then
                    begin
                        (* separate once summed index into [base, index] *)
                        bt := it; bx := ix; s := s - 1;
                    end;
                end else
                begin
                    if (( (s = 2) and (it <> REG_NUM_ESP) and
                          ( ((eaflags and EAF_TIMESTWO) = 0) or (ht = EAH_SUMMED) )) or
                         (s = 3) or (s = 5) or (s = 9) ) and (bt = -1) then
                    begin
                        (* convert 3*EAX to EAX+2*EAX *)
                        bt := it; bx := ix; s := s - 1;
                    end;
                    if (it = -1) and ((bt and 7) <> REG_NUM_ESP) and
                        ((eaflags and EAF_TIMESTWO) <> 0) and
                        ((hb = b) and (ht = EAH_NOTBASE)) then
                    begin
                        (*
                         * convert [NOSPLIT EAX*1]
                         * to sib format with 0x0 displacement - [EAX*1+0].
                         *)
                        it := bt; ix := bx; bt := -1; bx := 0; s := 1;
                    end;
                end;
                if (s = 1) and (it = REG_NUM_ESP) then
                begin
                    (* swap ESP into base if scale is 1 *)
                    t := it; it := bt; bt := t;
                    x := ix; ix := bx; bx := x;
                end;
                if (it = REG_NUM_ESP) or
                   ((s <> 1) and (s <> 2) and (s <> 4) and (s <> 8) and (it <> -1)) then
                    goto err;        (* wrong, for various reasons *)

                output.rex := output.rex or rexflags(it, ix, REX_X);
                output.rex := output.rex or rexflags(bt, bx, REX_B);

                if (it = -1) and ((bt and 7) <> REG_NUM_ESP) then
                begin
                    (* no SIB needed *)

                    if (bt = -1) then
                    begin
                        rm   := 5;
                        _mod := 0;
                    end else
                    begin
                        rm := (bt and 7);
                        if (rm <> REG_NUM_EBP) and (o = 0) and
                           (seg = NO_SEG) and (forw_ref = False) and
                           ((eaflags and (EAF_BYTEOFFS or EAF_WORDOFFS)) = 0) then
                            _mod := 0
                        else if (IS_MOD_01()) then
                            _mod := 1
                        else
                            _mod := 2;
                    end;

                    output.sib_present := 0;
                    output.bytes       := IfThen((bt = -1) or (_mod = 2), 4,_mod);
                    output.modrm       := GEN_MODRM(_mod, rfield, rm);
                end  else
                begin
                    (* we need a SIB *)

                    if (it = -1) then
                    begin
                        index := 4;
                        s     := 1
                    end
                    else
                        index := (it and 7);

                    case  s of
                     1: scale := 0;
                     2: scale := 1;
                     4: scale := 2;
                     8: scale := 3;
                    else   (* then what the smeg is it? *)
                        goto err;    (* panic *)
                    end;

                    if (bt = -1) then
                    begin
                        base := 5;
                        _mod := 0;
                    end else
                    begin
                        base := (bt and 7);
                        if (base <> REG_NUM_EBP) and (o = 0) and
                           (seg = NO_SEG) and (forw_ref = False) and
                           ((eaflags and (EAF_BYTEOFFS or EAF_WORDOFFS) = 0)) then
                            _mod := 0
                        else if (IS_MOD_01()) then
                            _mod := 1
                        else
                            _mod := 2;
                    end;

                    output.sib_present := 1;
                    output.bytes       := IfThen((bt = -1) or (_mod = 2), 4, _mod);
                    output.modrm       := GEN_MODRM(_mod, rfield, 4);
                    output.sib         := GEN_SIB(scale, index, base);
                end;
            end else
            begin            (* it's 16-bit *)
                o := input.offset;

                (* check for 64-bit long mode *)
                if (addrbits = 64) then
                    goto err;

                (* check all registers are BX, BP, SI or DI *)
                if ( (b <> -1) and (b <> R_BP) and (b <> R_BX) and (b <> R_SI) and (b <> R_DI) ) or
                   ( (i <> -1) and (i <> R_BP) and (i <> R_BX) and (i <> R_SI) and (i <> R_DI)) then
                    goto err;

                (* ensure the user didn't specify DWORD/QWORD *)
                if (input.disp_size = 32) or (input.disp_size = 64) then
                    goto err;

                if (s <> 1) and (i <> -1) then
                    goto err;        (* no can do, in 16-bit EA *)
                if (b = -1) and (i <> -1) then
                begin
                    tmp := b;
                    b   := i;
                    i   := tmp;
                end;               (* swap *)
                if ((b = R_SI) or (b = R_DI)) and (i <> -1) then
                begin
                    tmp := b;
                    b   := i;
                    i   := tmp;
                end;
                (* have BX/BP as base, SI/DI index *)
                if (b = i) then
                    goto err;        (* shouldn't ever happen, in theory *)
                if (i <> -1) and (b <> -1) and
                   ( (i = R_BP) or (i = R_BX) or (b = R_SI) or (b = R_DI) ) then
                    goto err;        (* invalid combinations *)
                if (b = -1) then     (* pure offset: handled above *)
                    goto err;        (* so if it gets to here, panic! *)

                rm := -1;
                if (i <> -1) then
                begin
                    case (i * 256 + b) of
                     R_SI * 256 + R_BX: rm := 0;
                     R_DI * 256 + R_BX: rm := 1;
                     R_SI * 256 + R_BP: rm := 2;
                     R_DI * 256 + R_BP: rm := 3;
                    end;
                end else
                begin
                    case b of
                     R_SI: rm := 4;
                     R_DI: rm := 5;
                     R_BP: rm := 6;
                     R_BX: rm := 7;
                    end;
                end ;
                if (rm = -1) then          (* can't happen, in theory *)
                    goto err;              (* so panic if it does *)

                if (o = 0) and (seg = NO_SEG) and (forw_ref = False) and (rm <> 6) and
                   ((eaflags and (EAF_BYTEOFFS or EAF_WORDOFFS)) = 0) then
                    _mod := 0
                else if (IS_MOD_01()) then
                    _mod := 1
                else
                    _mod := 2;

                output.sib_present := 0;         (* no SIB - it's 16-bit *)
                output.bytes       := _mod;      (* bytes of offset needed *)
                output.modrm       := GEN_MODRM(_mod, rfield, rm);
            end;
        end;
    end;

    output.size := 1 + output.sib_present + output.bytes;
    Result      := output.tipo;
    Exit;

err:
    output.tipo := EA_INVALID;
    Result      := output.tipo;

end;

procedure TCodeGen.bad_hle_warn(ins: TInsn ; hleok: Byte );
type whatwarn = Byte;
const
  w_none = 0;
  w_lock = 1;
  w_inval= 2;

  warn : array[0..1,0..3] of whatwarn = (
         (w_inval, w_inval, w_none, w_lock ),  (* XACQUIRE *)
         (w_inval, w_none,  w_none, w_lock )); (* XRELEASE *)

var
  rep_pfx : prefixes;
  ww      : whatwarn;
  n       : Cardinal;
begin
     rep_pfx := ins.prefixes[PPS_REP];



    n := rep_pfx - P_XACQUIRE;
    if (n > 1) then
        Exit;                 (* Not XACQUIRE/XRELEASE *)

    ww := warn[n][hleok];
    if not is_class(MEMORY, ins.oprs[0].tipo) then
        ww := w_inval;           (* HLE requires operand 0 to be memory *)

    case ww of
     w_none:begin end;


     w_lock:
           begin
                if (ins.prefixes[PPS_LOCK] <> P_LOCK) then
                begin
                    DoLogMsg(ERR_WARNING or ERR_WARN_HLE or ERR_PASS2,
                           Format('%s with this instruction requires lock', [prefix_name(rep_pfx)]) );
                end

           end;

     w_inval:
        DoLogMsg(ERR_WARNING or ERR_WARN_HLE or ERR_PASS2,
                Format('%s invalid with this instruction', [prefix_name(rep_pfx)]) );

    end;
end;


function TCodeGen.calcsize(var ins: TInsn; temp: PItemplate): Int64;
var
  codes    : PByte;
  Length_  : Int64;
  c,opex   : Byte;
  hleok    : Byte;
  rex_mask_: Integer;
  op1, op2 : Integer;
  opx      : TOperand;
  eat      : ea_type;
  lockcheck: Boolean;
  mib_index: reg_enum;

  pfx      : prefixes;

  ea_data  : T_EA;
  rfield   : Integer;
  rflags   : opflags_t;
  opy      : POperand ;
  op_er_sae: POperand;

  bad32    : Integer;
begin
    codes    := temp.code;
    length_  := 0;
    rex_mask_:= not 0;
    opex     := 0;
    hleok    := 0;
    lockcheck:= True;
    mib_index:= R_none;         (* For a separate index MIB reg form *)

    ins.rex  := 0;              (* Ensure REX is reset *)
    eat      := EA_SCALAR;      (* Expect a scalar EA *)
    ZeroMemory(@ins.evex_p[0],Length(ins.evex_p));   (* Ensure EVEX is reset *)

    if (ins.prefixes[PPS_OSIZE] = P_O64)  then
        ins.rex := ins.rex or REX_W;

    while codes^ <> 0 do
    begin
        c := codes^;
        Inc(codes);
        op1 := (c and 3) + ((opex and 1) shl 2);
        op2 := ((c shr 3) and 3) + ((opex and 2) shl 1);
        opx := ins.oprs[op1];
        opex := 0;               (* For the next iteration *)

        case  c of
        1,
        2,
        3,
        4:
          begin
              codes   := codes + c;
              length_ := length_ + c;
          end;
        5,
        6,
        7: opex := c;

        8,
        9,
        10,
        11:
           begin
               ins.rex := ins.rex or op_rexflags(opx, REX_B or REX_H or REX_P or REX_W);
               Inc(codes);
               length_ := length_ + 1 ;
           end;
        12,
        13,
        14,
        15: mib_index := opx.basereg;   (* this is an index reg of MIB operand *)

        16,
        17,                     // imm8  o   Unsigned imm8
        18,
        19,
        20,
        21,
        22,
        23: length_ := length_ + 1 ;

        24,                     // # imm16
        25,
        26,
        27: length_ := length_ + 2;

        28,                     //  imm16 or imm32, depending on opsize
        29,
        30,
        31:
           begin
               if (opx.tipo and (BITS16 or BITS32 or BITS64)) <> 0 then
                    length_ :=  length_ + IfThen((opx.tipo and BITS16) <> 0, 2,4)
               else
                    length_ := length_ + IfThen((Fbits = 16),2,4);
           end;
        32,                     // imm32
        33,
        34,
        35: length_ := length_ + 4;

        36,                     // imm16/32/64, depending on addrsize
        37,
        38,
        39: length_ := length_ + (ins.addr_size shr 3);

        40,
        41,
        42,
        43: length_ := length_ + 1;

        44,
        45,
        46,
        47: length_ := length_ + 8; (* MOV reg64/imm *)

        48,
        49,
        50,
        51: length_ := length_ + 2;

        52,                     // 16 or 32 bit relative operand
        53,
        54,
        55:
           begin
               if (opx.tipo and (BITS16 or BITS32 or BITS64)) <> 0 then
                  length_ := length_ + ifthen ((opx.tipo and BITS16) <> 0, 2, 4)
               else
                  length_ := length_ + IfThen((Fbits = 16), 2, 4);
           end;
        56,
        57,
        58,
        59: length_ := length_ + 4;

        60,
        61,
        62,
        63: length_ := length_ + 2;

        122,
        123:
            begin
                Inc(codes);
                length_ := length_ + 1;
            end;
        124,
        125,
        126,
        127: length_ := length_ + 1;

        160,
        161,
        162,
        163:
            begin
                ins.rex        := ins.rex or REX_EV;
                ins.vexreg     := regval(opx);
                ins.evex_p[2]  := ins.evex_p[2] or op_evexflags(opx, EVEX_P2VP, 2); (* High-16 NDS *)
                ins.vex_cm     := codes^;
                inc(codes);
                ins.vex_wlp    := codes^;
                inc(codes);
                ins.evex_tuple := ( codes^ - 192);
                inc(codes);
            end;
        168:
            begin
                ins.rex        := ins.rex or REX_EV;
                ins.vexreg     := 0;
                ins.vex_cm     := codes^;
                inc(codes);
                ins.vex_wlp    := codes^;
                inc(codes);
                ins.evex_tuple := ( codes^ - 192);
                inc(codes);
            end;
        172,               // imm32 sign-extended to 64 bits
        173,
        174,
        175: length_ := length_ + 4;

        176,
        177,
        178,
        179:
            begin
                ins.rex    := ins.rex or REX_V;
                ins.vexreg := regval(opx);
                ins.vex_cm  := codes^;
                inc(codes);
                ins.vex_wlp := codes^;
                inc(codes);
            end;
        184:
            begin
                ins.rex    := ins.rex or REX_V;
                ins.vexreg := 0;
                ins.vex_cm := codes^;
                inc(codes);
                ins.vex_wlp:= codes^;
                inc(codes);
            end;
        185,
        186,
        187: hleok := c and 3;

        188,                 // imm8 sign-extended to opsize or bits
        189,
        190,
        191: length_ := length_ + 1;

        192,
        193,
        194,
        195:begin end;

        200:
            begin
                if (Fbits = 64) then
                begin
                    Result := -1;
                    Exit;
                end;
                length_ :=  length_ + Integer((Fbits <> 16) and has_prefix(ins, PPS_ASIZE, P_A16) = False) ;
            end;

        201: length_ := length_ + Integer((Fbits <> 32) and has_prefix(ins, PPS_ASIZE, P_A32) = False);

        202:begin end;   // Address size is default

        203:
            begin
                if (Fbits <> 64) or (has_prefix(ins, PPS_ASIZE, P_A16)) or (has_prefix(ins, PPS_ASIZE, P_A32)) then
                begin
                    Result := -1;
                    Exit;
                end;
            end;

        204,
        205,
        206,
        207: begin end;

        208:          // 16-bit operand size
            begin
                pfx := ins.prefixes[PPS_OSIZE];
                if (pfx = P_O16) then
                    break;
                if (pfx <> P_none) then
                    DoLogMsg(ERR_WARNING or ERR_PASS2, 'invalid operand size prefix')
                else
                    ins.prefixes[PPS_OSIZE] := P_O16;
            end;
        209:          //  32-bit operand size
            begin
                pfx := ins.prefixes[PPS_OSIZE];
                if (pfx = P_O32)  then
                    break;
                if (pfx <> P_none) then
                    DoLogMsg(ERR_WARNING or ERR_PASS2, 'invalid operand size prefix')
                else
                    ins.prefixes[PPS_OSIZE] := P_O32;
            end;
        210:begin end;  // Operand size is default

        211: rex_mask_ :=  rex_mask_ and ( not REX_W);   // 64-bit operand size requiring REX.W

        212: ins.rex := ins.rex or REX_W;                //  Implied 64-bit operand size (no REX.W)

        213: ins.rex := ins.rex or REX_NH;               //  Use spl/bpl/sil/dil even without REX

        214:begin end;                                   //  No REP 0xF3 prefix permitted

        216:
           begin
               Inc(codes);
               Inc(length_);
           end;

        217:begin end;      // No REP prefix permitted

        218,                // F2 prefix, but 66 for operand size is OK
        219: Inc(length_);

        220: ins.rex := ins.rex or REX_L;

        221:begin end;

        222:
           begin
               if ins.prefixes[PPS_REP] = 0 then
                   ins.prefixes[PPS_REP] := P_REP;
           end;
        223:
           begin
               if ins.prefixes[PPS_REP] = 0 then
                   ins.prefixes[PPS_REP] := P_REPNE;
           end;

        224:
           begin
               if (ins.oprs[0].segment <>  NO_SEG) then
                    DoLogMsg(ERR_NONFATAL, 'attempt to reserve non-constant  quantity of BSS space')
               else
                    length_ := length_ + ins.oprs[0].offset;
           end;

        225:          // Needs a wait prefix
           begin
               if ins.prefixes[PPS_WAIT] = 0 then
                   ins.prefixes[PPS_WAIT] := P_WAIT;
           end;
        240:begin end;      // No prefix

        241: Inc(length_);

        244,
        245:begin end;

        246,
        247: Inc(length_);

        248,                // Match only if Jcc possible with single byte
        249:begin end;      // Match only if JMP possible with single byte

        251: Inc(length_); // Length of jump

        252: eat := EA_XMMVSIB;   // This instruction takes XMM VSIB

        253: eat := EA_YMMVSIB;   // This instruction takes YMM VSIB

        254: eat := EA_ZMMVSIB;  // This instruction takes ZMM VSIB

        64,65,66,67,
        72,73,74,75,
        80,81,82,83,
        88,89,90,91,
        128,129,130,131,
        132,133,134,135,
        136,137,138,139,
        140,141,142,143,
        144,145,146,147,
        148,149,150,151,
        152,153,154,155,
        156,157,158,159:
            begin
                opy := @ins.oprs[op2];

                ea_data.rex := 0;           (* Ensure ea.REX is initially 0 *)

                if (c <= 127) then
                begin
                    (* pick rfield from operand b (opx) *)
                    rflags := regflag(opx);
                    rfield := nasm_regvals[opx.basereg];
                end else
                begin
                    rflags := 0;
                    rfield := c and 7;
                end;

                (* EVEX.b1 : evex_brerop contains the operand position *)
                op_er_sae := nil;
                if ins.evex_brerop >= 0 then op_er_sae := @ins.oprs[ins.evex_brerop];

                if (op_er_sae <> nil) and ((op_er_sae.decoflags and (ER or SAE)) <> 0) then
                begin
                    (* set EVEX.b *)
                    ins.evex_p[2] := ins.evex_p[2] or EVEX_P2B;
                    if (op_er_sae.decoflags and ER) <> 0 then
                    begin
                        (* set EVEX.RC (rounding control) *)
                        ins.evex_p[2] := ins.evex_p[2] or (((ins.evex_rm - BRC_RN) shl 5) and EVEX_P2RC);
                    end;
                end else
                begin
                    (* set EVEX.L'L (vector length) *)
                    ins.evex_p[2] := ins.evex_p[2] or ((ins.vex_wlp shl (5 - 2)) and EVEX_P2LL);
                    ins.evex_p[1] := ins.evex_p[1] or ((ins.vex_wlp shl (7 - 4)) and EVEX_P1W);
                    if (opy^.decoflags and BRDCAST_MASK) <> 0 then
                    begin
                        (* set EVEX.b *)
                        ins.evex_p[2] := ins.evex_p[2] or EVEX_P2B;
                    end;
                end;

                if itemp_has(temp, IF_MIB) then
                begin
                    opy^.eaflags := opy^.eaflags or EAF_MIB;
                    (*
                     * if a separate form of MIB (ICC style) is used,
                     * the index reg info is merged into mem operand
                     *)
                    if (mib_index <> R_none) then
                    begin
                        opy^.indexreg := mib_index;
                        opy^.scale    := 1;
                        opy^.hintbase := mib_index;
                        opy^.hinttype := EAH_NOTBASE;
                    end;
                end;

                if (process_ea(opy^, ea_data, rfield, rflags, ins) <> eat) then
                begin
                    DoLogMsg(ERR_NONFATAL, 'invalid effective address');
                    Result := -1;
                    Exit;
                end  else
                begin
                    ins.rex := ins.rex or ea_data.rex;
                    length_ := length_ + ea_data.size;
                end;
            end


        else
            DoLogMsg(ERR_PANIC,
                        Format('internal instruction table corrupt : instruction code \\%o (0x%02X) given', [c, c]));
        end;
    end;

    ins.rex := ins.rex and rex_mask_;

    if (ins.rex and REX_NH) <> 0 then
    begin
        if (ins.rex and REX_H) <> 0 then
        begin
            DoLogMsg(ERR_NONFATAL, 'instruction cannot use high registers');
            Result := -1;
            Exit;
        end;
        ins.rex := ins.rex and ( not REX_P);        (* Don't force REX prefix due to high reg *)
    end;

    case ins.prefixes[PPS_VEX] of
     P_EVEX:
           begin
              if (ins.rex and REX_EV) = 0 then
              begin
                  Result := -1;
                  Exit;
              end;
           end;
     P_VEX3,
     P_VEX2:
           begin
              if (ins.rex and REX_V) = 0 then
              begin
                  Result := -1;
                  Exit;
              end;
           end
    else
    end;

    if (ins.rex and (REX_V or REX_EV)) <> 0 then
    begin
        bad32 := REX_R or REX_W or REX_X or REX_B;

        if (ins.rex and REX_H) <> 0 then
        begin
            DoLogMsg(ERR_NONFATAL, 'cannot use high register in AVX instruction');
            Result := -1;
            Exit;
        end;
        case ins.vex_wlp and  48 of
         0,
        32: ins.rex := ins.rex and ( not REX_W);
        16:
          begin
              ins.rex := ins.rex or REX_W;
              bad32   := bad32 and (not REX_W);
          end;
        48: begin end;
            (* Follow REX_W *)
        end;

        if (Fbits <> 64) and ( ((ins.rex and bad32) <> 0) or (ins.vexreg > 7) ) then
        begin
            DoLogMsg(ERR_NONFATAL, 'invalid operands in non-64-bit mode');
            Result := -1;
            Exit;
        end
        else if ((ins.rex and REX_EV) = 0) and ((ins.vexreg > 15) or ((ins.evex_p[0] and $f0)<> 0)) then
        begin
            DoLogMsg(ERR_NONFATAL, 'invalid high-16 register in non-AVX-512');
            Result := -1;
            Exit;
        end;
        if (ins.rex and REX_EV) <> 0 then
            length_ := length_ + 4
        else if (ins.vex_cm <> 1) or ((ins.rex and (REX_W or REX_X or REX_B)) <> 0) or (ins.prefixes[PPS_VEX] = P_VEX3) then
            length_ := length_ + 3
        else
            length_ := length_ + 2;
    end
    else if (ins.rex and REX_MASK) <>0 then
    begin
        if (ins.rex and REX_H) <> 0 then
        begin
            DoLogMsg(ERR_NONFATAL, 'cannot use high register in rex instruction');
            Result := -1;
            exit;
        end
        else if (Fbits = 64) then
        begin
            length_ := length_ + 1;
        end
        else if ((ins.rex and REX_L) <> 0) and
                   ((ins.rex and (REX_P or REX_W or REX_X or REX_B)) = 0) then
                   //and  iflag_ffs(&cpu) >= IF_X86_64) then
        begin
            (* LOCK-as-REX.R *)
            assert_no_prefix(ins, PPS_LOCK);
            lockcheck := false;  (* Already errored, no need for warning *)
            length_   := length_ + 1;
        end else
        begin
            DoLogMsg(ERR_NONFATAL, 'invalid operands in non-64-bit mode');
            Result := -1;
            exit;
        end;
    end;

    if (has_prefix(ins, PPS_LOCK, P_LOCK)) and (lockcheck) and
        ( (itemp_has(temp,IF_LOCK) = False) or (is_class(MEMORY, ins.oprs[0].tipo) = False) ) then
    begin
        DoLogMsg(ERR_WARNING or ERR_WARN_LOCK or ERR_PASS2 , 'instruction is not lockable');
    end;

    bad_hle_warn(ins, hleok);

    (*
     * when BND prefix is set by DEFAULT directive,
     * BND prefix is added to every appropriate instruction line
     * unless it is overridden by NOBND prefix.
     *)
    {if (globalbnd) and
       ( (itemp_has(temp, IF_BND)) and (has_prefix(ins, PPS_REP, P_NOBND) = False) ) then
            ins.prefixes[PPS_REP] = P_BND; }

    Result := length_;

end;

function TCodeGen.jmp_match(offset: Int64; var ins: TInsn; temp: pItemplate): Boolean;
var
  isize  : Int64;
  code   : PByte;
  c      : Byte;
  is_byte: Boolean;
begin
    code := temp^.code;
    c    := code[0];

    if ( (c and  ( not 1)) <> $F8) or ((ins.oprs[0].tipo and STRICT_) <> 0) then
    begin
        Result := false;
        Exit;
    end;
    if FOptimizing = 0 then
    begin
        Result := false;
        exit;
    end;
    if (FOptimizing < 0) and (c = $F9) then
    begin
        Result := False;
        exit;
    end;
    isize := calcsize(ins, temp);

    if (ins.oprs[0].opflags and OPFLAG_UNKNOWN) <> 0 then
    begin
        (* Be optimistic in pass 1 *)
        Result := True;
        Exit;
    end;

  (*  if (ins.oprs[0].segment <> segment) then
    begin
        Result := False;
        Exit;
    end;   *)

    isize   := ins.oprs[0].offset - offset - isize;    (* isize is delta *)
    is_byte := (isize >= -128) and (isize <= 127);    (* is it byte size? *)

    if (is_byte = True)  and (c = $F9) and (ins.prefixes[PPS_REP] = P_BND)  then
    begin
        (* jmp short (opcode eb) cannot be used with bnd prefix. *)
        ins.prefixes[PPS_REP] := P_none;
        DoLogMsg(ERR_WARNING or ERR_WARN_BND or ERR_PASS2 ,'jmp short does not init bnd regs - bnd prefix dropped.');
    end;

    Result := is_byte;

end;

function TCodeGen.matches(itemp : pItemplate; instruction: TInsn): match_result;
var
   Size          : array[0..MAX_OPERANDS-1] of opflags_t;
   asize         : opflags_t;
   opsizemissing : Boolean;
   i,j,oprs        : Integer;

   tipo          : opflags_t;
   deco,
   deco_brsize   : decoflags_t;
   is_broadcast  : Boolean;
   brcast_num    : Byte;
   template_opsize,
   insn_opsize   : opflags_t;

begin
     opsizemissing := false;

    (*
     * Check the opcode
     *)
    if (itemp^.opcode <> instruction.opcode) then
    begin
         Result := MERR_INVALOP;
         Exit;
    end;

    (*
     * Count the operands
     *)
    if (itemp^.operands <> instruction.operands) then
    begin
         Result := MERR_INVALOP;
         Exit;
    end;

    (*
     * Is it legal?
     *)
    if ( not (FOptimizing > 0) ) and (itemp_has(itemp, IF_OPT))   then
    begin
	       Result := MERR_INVALOP;
         Exit;
    end;
    (*
     * {evex} available?
     *)
    case instruction.prefixes[PPS_VEX] of
      P_EVEX:
           begin
                if ( not itemp_has(itemp, IF_EVEX)) then
                begin
                   Result := MERR_ENCMISMATCH;
                   Exit;
                end;
           end;
      P_VEX3,
      P_VEX2:
           begin
                if ( not itemp_has(itemp, IF_VEX)) then
                begin
                    Result := MERR_ENCMISMATCH;
                    Exit;
                end;
           end
    else

    end;

    (*
     * Check that no spurious colons or TOs are present
     *)
    for i := 0 to itemp^.operands - 1 do
    begin
        if (instruction.oprs[i].tipo) and  (not itemp^.opd[i]) and (COLON or TO_) <> 0 then
        begin
            Result := MERR_INVALOP;
            Exit;
        end;
    end;

    (*
     * Process size flags
     *)
    if itemp_smask(itemp)       =  IF_GENBIT(IF_SB) then   asize := BITS8
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SW) then   asize := BITS16
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SD) then   asize := BITS32
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SQ) then   asize := BITS64
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SO) then   asize := BITS128
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SY) then   asize := BITS256
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SZ) then   asize := BITS512
    else if itemp_smask(itemp)  =  IF_GENBIT(IF_SIZE) then
    begin
        case (Fbits) of
          16: asize := BITS16;
          32: asize := BITS32;
          64: asize := BITS64;
        else
            asize := 0;
        end;
    end else asize := 0;

    if itemp_armask(itemp) <> 0 then
    begin
        (* S- flags only apply to a specific operand *)
        i := itemp_arg(itemp);
        ZeroMemory(@size[0],sizeof(size));
        size[i] := asize;
    end else
    begin
        (* S- flags apply to all operands *)
        for i := 0 to MAX_OPERANDS - 1 do
            size[i] := asize;
    end;

    (*
     * Check that the operand flags all match up,
     * it's a bit tricky so lets be verbose:
     *
     * 1) Find out the size of operand. If instruction
     *    doesn't have one specified -- we're trying to
     *    guess it either from template (IF_S* flag) or
     *    from code bits.
     *
     * 2) If template operand do not match the instruction OR
     *    template has an operand size specified AND this size differ
     *    from which instruction has (perhaps we got it from code bits)
     *    we are:
     *      a)  Check that only size of instruction and operand is differ
     *          other characteristics do match
     *      b)  Perhaps it's a register specified in instruction so
     *          for such a case we just mark that operand as "size
     *          missing" and this will turn on fuzzy operand size
     *          logic facility (handled by a caller)
     *)
    for i := 0 to itemp^.operands - 1 do
    begin
        tipo         := instruction.oprs[i].tipo;
        deco         := instruction.oprs[i].decoflags;
        is_broadcast := (deco and BRDCAST_MASK) <> 0;
        brcast_num   := 0;

        if ((tipo and SIZE_MASK)= 0) then
            tipo := tipo or size[i];

        insn_opsize     := tipo and SIZE_MASK;
        if not is_broadcast then
        begin
            template_opsize := itemp^.opd[i] and SIZE_MASK;
        end else
        begin
             deco_brsize := itemp^.deco[i] and BRSIZE_MASK;
            (*
             * when broadcasting, the element size depends on
             * the instruction type. decorator flag should match.
             *)

            if deco_brsize <> 0 then
            begin
                if deco_brsize = BR_BITS32 then template_opsize :=  BITS32
                else                            template_opsize :=  BITS64;
                (* calculate the proper number : {1to<brcast_num>} *)
                brcast_num := get_broadcast_num(itemp^.opd[i], template_opsize);
            end else
            begin
                template_opsize := 0;
            end;
        end;

        if ( itemp^.opd[i] and  (not tipo) and  ( not SIZE_MASK) <> 0) or
            (deco and  ( not itemp^.deco[i]) and  (not BRNUM_MASK) <> 0 ) then
        begin
            Result := MERR_INVALOP;
            Exit;
        end
        else if template_opsize <> 0 then
        begin
            if (template_opsize <> insn_opsize) then
            begin
                if insn_opsize <> 0 then
                begin
                    Result := MERR_INVALOP;
                    Exit;
                end
                else if  is_class(REGISTER_, tipo)= false then
                begin
                    (*
                     * Note: we don't honor extrinsic operand sizes for registers,
                     * so "missing operand size" for a register should be
                     * considered a wildcard match rather than an error.
                     *)
                    opsizemissing := true;
                end;
            end
            else if (is_broadcast) and
                       (brcast_num <> (UInt8(2) shl ((deco and BRNUM_MASK) shr BRNUM_SHIFT))) then
            begin
                (*
                 * broadcasting opsize matches but the number of repeated memory
                 * element does not match.
                 * if 64b double precision float is broadcasted to ymm (256b),
                 * broadcasting decorator must be {1to4}.
                 *)
                Result := MERR_BRNUMMISMATCH;
                Exit;
            end;
        end;
    end;

    if (opsizemissing) then
    begin
        Result := MERR_OPSIZEMISSING;
        Exit;
    end;
    (*
     * Check operand sizes
     *)
    if itemp_has(itemp, IF_SM) or itemp_has(itemp, IF_SM2) then
    begin
        if itemp_has(itemp, IF_SM2)  then oprs := 2
        else                              oprs := itemp^.operands;

        for i := 0 to oprs - 1  do
        begin
            asize := itemp^.opd[i] and SIZE_MASK;
            if asize <> 0 then
            begin
                for j := 0 to  oprs - 1 do
                    size[j] := asize;
                break;
            end;
        end;
    end
    else  oprs := itemp^.operands;


    for i := 0 to itemp^.operands do
    begin
        if ( (itemp^.opd[i] and SIZE_MASK)= 0 ) and
            (instruction.oprs[i].tipo and SIZE_MASK and ( not size[i]) <> 0 ) then
        begin
            Result := MERR_OPSIZEMISMATCH;
            Exit;
        end;
    end;

    (*
     * Verify the appropriate long mode flag.
     *)
    if Fbits = 64 then
    begin
        if itemp_has(itemp, IF_NOLONG)  then
        begin
             Result := MERR_BADMODE;
             Exit;
        end;
    end else
    begin
        if itemp_has(itemp, IF_LONG)  then
        begin
             Result := MERR_BADMODE;
             Exit;
        end;
    end;

    (*
     * If we have a HLE prefix, look for the NOHLE flag
     *)
    if (itemp_has(itemp, IF_NOHLE)) and
       ( (has_prefix(instruction, PPS_REP, P_XACQUIRE)) or
         (has_prefix(instruction, PPS_REP, P_XRELEASE))
       ) then
    begin
        Result := MERR_BADHLE;
        Exit;
    end;
    (*
     * Check if special handling needed for Jumps
     *)
    if ((itemp^.code[0] and (not 1)) = $F8) then
    begin
        Result := MOK_JUMP;
        Exit;
    end;
    (*
     * Check if BND prefix is allowed.
     * Other 0xF2 (REPNE/REPNZ) prefix is prohibited.
     *)
    if ( not itemp_has(itemp, IF_BND)) and
       ( (has_prefix(instruction, PPS_REP, P_BND)) or
         (has_prefix(instruction, PPS_REP, P_NOBND))
       ) then
    begin
        Result := MERR_BADBND;
        Exit;
    end
    else if (itemp_has(itemp, IF_BND)) and
            ( (has_prefix(instruction, PPS_REP, P_REPNE)) or
              (has_prefix(instruction, PPS_REP, P_REPNZ))
              ) then
    begin
        Result := MERR_BADREPNE;
        Exit;
    end;

    Result := MOK_GOOD;


end;


function TCodeGen.find_match(var tempp: pItemplate; instruction: TInsn; offset: Int64): match_result;
const
   BRSIZE_MASK  =  $300;
   SIZE_MASK    =  $7FF00000000 ;
var
   temp          : pItemplate;
   m, merr       : match_result;
   xsizeflags    : array[0..MAX_OPERANDS-1] of UInt64;
   opsizemissing : Boolean ;
   broadcast     : Int8;
   i             : Integer;
   label           done;
begin
    opsizemissing := False;
    broadcast     := instruction.evex_brerop;

    (* broadcasting uses a different data element size *)
    for i := 0 to instruction.operands do
    begin
        if i = broadcast then
            xsizeflags[i] := instruction.oprs[i].decoflags and BRSIZE_MASK
        else
            xsizeflags[i] := instruction.oprs[i].tipo and SIZE_MASK;
    end;
    merr := MERR_INVALOP;

    temp := nasm_instructions[instruction.opcode];

    while temp^.opcode <> I_none do
    begin
        m := matches(temp, instruction);
        if (m = MOK_JUMP) then
        begin
            if (jmp_match(offset, instruction, temp)) then  m := MOK_GOOD
            else                                                           m := MERR_INVALOP;
        end
        else if (m = MERR_OPSIZEMISSING) and ( not itemp_has(temp, IF_SX)) then
        begin
            (*
             * Missing operand size and a candidate for fuzzy matching...
             *)
            for i := 0 to  temp^.operands -1 do
            begin
                if (i = broadcast) then  xsizeflags[i] := xsizeflags[i] or (temp^.deco[i] and BRSIZE_MASK)
                else                     xsizeflags[i] := xsizeflags[i] or (temp^.opd[i] and SIZE_MASK);
                opsizemissing := true;
            end;
        end;
        if (m > merr)  then  merr := m;
        if (merr = MOK_GOOD) then goto done;

        Inc(temp);
    end;


    (* No match, but see if we can get a fuzzy operand size match... *)
    if  not opsizemissing then goto done;

    for i := 0 to instruction.operands - 1 do
    begin
        (*
         * We ignore extrinsic operand sizes on registers, so we should
         * never try to fuzzy-match on them.  This also resolves the case
         * when we have e.g. "xmmrm128" in two different positions.
         *)
        if (is_class(REGISTER_, instruction.oprs[i].tipo)) then
            continue;

        (* This tests if xsizeflags[i] has more than one bit set *)
        if ( xsizeflags[i] and (xsizeflags[i]-1)) <> 0  then
            goto done;                (* No luck *)

        if (i = broadcast) then
        begin
            instruction.oprs[i].decoflags := instruction.oprs[i].decoflags or xsizeflags[i];
            if xsizeflags[i] = BR_BITS32 then  instruction.oprs[i].tipo := instruction.oprs[i].tipo or BITS32
            else                               instruction.oprs[i].tipo := instruction.oprs[i].tipo or BITS64
        end
        else  instruction.oprs[i].tipo := instruction.oprs[i].tipo or xsizeflags[i]; (* Set the size *)
    end;

    (* Try matching again... *)
    temp := nasm_instructions[instruction.opcode];
    while temp^.opcode <> I_none do
    begin
        m := matches(temp, instruction);
        if (m = MOK_JUMP) then
        begin
            if (jmp_match(offset, instruction, temp)) then  m := MOK_GOOD
            else                                                           m := MERR_INVALOP;
        end;
        if m > merr then merr := m;
        if merr = MOK_GOOD then  goto done;
        Inc(temp);
    end;

done:
    tempp  := temp;
    Result := merr;

end;


procedure TCodeGen.GenCode(offset: Int64; ins: TInsn; temp : pItemplate; insn_end: Int64);
(***************************************************************************************************************)
var
  c,opex    : Byte;
  bytes     : array[0..3] of Byte;
  size,data : Int64;
  op1, op2,s: Integer;
  opx       : TOperand;
  codes     : PByte;
  eat       : ea_type;
  uv, um    : UInt64;

  ea_data   : T_EA;
  rfield,
  asize,
  atype     : Integer;
  rflags    : UInt64;
  p         : PByte;
  opy       : TOperand;

  segment   : int32;

begin
     codes        := temp^.code;
     opex         := 0;
     eat          := EA_SCALAR;
     ins.rex_done := False;

     segment      := FSegment;

     while codes^ <> 0 do
     begin
          c := codes^;
          Inc(codes);

        op1 := (c and 3) + ((opex and 1) shl 2);
        op2 := ((c shr 3) and 3) + ((opex and 2) shl 1);
        opx := ins.oprs[op1];
        opex:= 0;                (* For the next iteration *)

        case c of
         01,
         02,
         03,
         04:
           begin
              offset := offset + emit_rex(ins);
              InternalOut(codes, c,OUT_RAWDATA);
              codes  := codes + c;
              offset := offset + c;
           end;

         05,
         06,
         07:  opex := c;

         8,
         9,
         10,
         11:
           begin
              offset   := offset + emit_rex(ins);
              bytes[0] := codes^ + (regval(opx) and 7);
              Inc(codes);
              InternalOut(@bytes[0], 1,OUT_RAWDATA);
              offset :=  offset + 1;
           end;

         12,
         13,
         14,
         15:
           begin
           end;

         16,            // imm8
         17,
         18,
         19:
           begin
              if (opx.offset < -256) or (opx.offset > 255) then
                  DoLogMsg(ERR_WARNING or  ERR_PASS2 or ERR_WARN_NOV, 'byte value exceeds bounds');

              out_imm8(opx, -1);
              offset := offset + 1;
           end;

         20,            // Unsigned imm8
         21,
         22,
         23:
           begin
              if (opx.offset < 0) or (opx.offset > 255) then
                  DoLogMsg(ERR_WARNING or ERR_PASS2 or ERR_WARN_NOV,'unsigned byte value exceeds bounds');

              out_imm8(opx, 1);
              offset := offset + 1;
           end;

         24,            // imm16
         25,
         26,
         27:
           begin
              warn_overflow_opd(opx, 2);
              data := opx.offset;
              InternalOut(@data, 2,OUT_ADDRESS);
              offset := offset+ 2;
           end;

         28,            // imm16 or imm32, depending on opsize
         29,
         30,
         31:
           begin
              if (opx.tipo and (BITS16 or BITS32)) <> 0 then
              begin
                  if (opx.tipo and BITS16) <> 0  then size := 2
                  else                                size := 4;
              end else
              begin
                  if (Fbits = 16) then size := 2
                  else                size := 4;
              end;

              warn_overflow_opd(opx, size);
              data := opx.offset;
              InternalOut(@data, size,OUT_ADDRESS);
              offset := offset + size;
           end;

         32,            // imm32
         33,
         34,
         35:
           begin
              warn_overflow_opd(opx, 4);
              data := opx.offset;
              InternalOut(@data, 4,OUT_ADDRESS);
              offset := offset + 4;
           end;

         36,            // imm16/32/64, depending on addrsize
         37,
         38,
         39:
           begin
              data := opx.offset;
              size := ins.addr_size shr 3;
              warn_overflow_opd(opx, size);
              InternalOut(@data, size,OUT_ADDRESS);
              offset := offset + size;
           end;

         40,
         41,
         42,
         43:
           begin
              if (opx.segment <> segment) then
              begin
                  data := opx.offset;
                  InternalOut(@data, insn_end - offset,OUT_REL1ADR);
              end else
              begin
                  data := opx.offset - insn_end;
                  if (data > 127) or (data < -128) then
                      DoLogMsg(ERR_NONFATAL, 'short jump is out of range');
                  InternalOut(@data, 1,OUT_ADDRESS);
              end;
              offset := offset + 1;
           end;

         44,
         45,
         46,
         47:
           begin
              data := opx.offset;
              InternalOut(@data, 8,OUT_ADDRESS);
              offset := offset + 8;
           end;

         48,
         49,
         50,
         51:
           begin
              if (opx.segment <> segment) then
              begin
                  data := opx.offset;
                  InternalOut(@data, insn_end - offset,OUT_REL2ADR);
              end else
              begin
                  data := opx.offset - insn_end;
                  InternalOut(@data, 2,OUT_ADDRESS);
              end;
              offset := offset + 2;
           end;

         52,    //  16 or 32 bit relative operand
         53,
         54,
         55:
           begin
              if (opx.tipo and (BITS16 or BITS32 or BITS64))  <>  0 then
              begin
                    if (opx.tipo and BITS16) <> 0 then  size := 2
                    else                                size := 4;
              end
              else begin
                    if (Fbits = 16) then  size := 2
                    else                  size := 4;
              end;
              if (opx.segment <> segment) then
              begin
                  data := opx.offset;
                  if size = 2  then  InternalOut(@data, insn_end - offset,OUT_REL2ADR)
                  else               InternalOut(@data, insn_end - offset,OUT_REL4ADR);
              end  else
              begin
                  data := opx.offset - insn_end;
                  InternalOut(@data, size,OUT_ADDRESS);
              end;
              offset := offset + size;
           end;

         56,
         57,
         58,
         59:
           begin
              if (opx.segment <> segment) then
              begin
                  data := opx.offset;
                  InternalOut(@data, insn_end - offset,OUT_REL4ADR);
              end else
              begin
                  data := opx.offset - insn_end;
                  InternalOut(@data, 4,OUT_ADDRESS);
              end;
              offset := offset + 4;
           end;

         60,
         61,
         62,
         63:
           begin
            if (opx.segment = NO_SEG) then
                DoLogMsg(ERR_NONFATAL, 'value referenced by FAR is not  relocatable');
            data := 0;
            InternalOut(@data, 2,OUT_ADDRESS);
            offset := offset + 2;
           end;

         122:
           begin
              c := codes^;
              Inc(codes);

              opx      := ins.oprs[c shr 3];
              bytes[0] := nasm_regvals[opx.basereg] shl 4;
              opx      := ins.oprs[c and 7];
              if (opx.segment <> NO_SEG) or (opx.wrt <> NO_SEG) then
                  DoLogMsg(ERR_NONFATAL, Format('non-absolute expression not permitted as argument %d',[c and 7]))
              else
                  if ( opx.offset and (not(15)) ) <> 0 then
                      DoLogMsg(ERR_WARNING or ERR_PASS2 or ERR_WARN_NOV, 'four-bit argument exceeds bounds');

              bytes[0] := bytes[0] or (opx.offset and 15);
              InternalOut(@bytes[0], 1,OUT_RAWDATA);
              offset := offset +1;
           end;

         123:
           begin
              c := codes^;
              Inc(codes);

              opx      := ins.oprs[c shr 4];
              bytes[0] := nasm_regvals[opx.basereg] shl 4;
              bytes[0] := bytes[0] or (c and 15);
              InternalOut(@bytes[0], 1,OUT_RAWDATA);
              offset := offset +1;
           end;

         124,
         125,
         126,
         127:
           begin
              bytes[0] := nasm_regvals[opx.basereg] shl 4;
              InternalOut(@bytes[0], 1,OUT_RAWDATA);
              offset := offset +1;
           end;

         172,    // imm32 sign-extended to 64 bits
         173,
         174,
         175:
           begin
                data := opx.offset;
                if (opx.wrt = NO_SEG) and (opx.segment = NO_SEG) and (int32(data) <> int64(data)) then
                    DoLogMsg(ERR_WARNING or ERR_PASS2 or ERR_WARN_NOV, 'signed dword immediate exceeds bounds');

                InternalOut(@data, UInt64(-4),OUT_ADDRESS);
                offset := offset + 4;
           end;

         160,
         161,
         162,
         163,
         168:
           begin
                codes := codes + 3;
                ins.evex_p[2] := ins.evex_p[2] or op_evexflags(ins.oprs[0], EVEX_P2Z or EVEX_P2AAA, 2);
                ins.evex_p[2] := ins.evex_p[2] xor EVEX_P2VP;        (* 1's complement *)
                bytes[0] := $62;
                (* EVEX.X can be set by either REX or EVEX for different reasons *)
                bytes[1] :=  ( ( ( ( ins.rex and  7 )  shl  5 )  or ( ins.evex_p[0] and  ( EVEX_P0X or  EVEX_P0RP ) ) )  xor  $f0 )  or ( ins.vex_cm and  3 ) ;
                bytes[2] :=  ( ( ins.rex and  REX_W )  shl  ( 7 -  3 ) )  or ( ( not ins.vexreg and  15 )  shl  3 )  or ( 1 shl  2 )  or  ( ins.vex_wlp and  3 ) ;
                bytes[3] := ins.evex_p[2];
                InternalOut(@bytes[0], 4,OUT_RAWDATA);
                offset := offset + 4;
           end;

         176,
         177,
         178,
         179,
         184:
           begin
                codes := codes + 2;
                if (ins.vex_cm <> 1) or (ins.rex and (REX_W or REX_X or REX_B)<> 0) or (ins.prefixes[PPS_VEX] = P_VEX3) then
                begin

                    bytes[0] := IfThen((ins.vex_cm shr 6) <> 0, $8f,$c4) ;
                    bytes[1] := ( ins.vex_cm and  31 )  or  ( ( not ins.rex and  7 )  shl  5 ) ;
                    bytes[2] := ( ( ins. rex and  REX_W )  shl  ( 7 - 3 ) )  or
                                ( ( not ins.vexreg and  15 ) shl  3 )  or  ( ins.vex_wlp and  07 ) ;

                    InternalOut(@bytes[0], 3,OUT_RAWDATA);
                    offset := offset + 3;
                end else
                begin
                    bytes[0] := $c5;
                    bytes[1] :=  ( ( not ins.rex and  REX_R )  shl  ( 7 - 2 ) )  or ( ( not ins.vexreg and  15 )  shl  3 )  or  ( ins.vex_wlp and  07 ) ;
                    InternalOut(@bytes[0], 2,OUT_RAWDATA);
                    offset := offset + 2;
                end;
           end;

         185,
         186,
         187:
           begin

           end;

         188,    // imm8 sign-extended to opsize or bits
         189,
         190,
         191:
           begin
                if (ins.rex and  REX_W) <> 0             then s := 64
                else if (ins.prefixes[PPS_OSIZE] = P_O16)then s := 16
                else if (ins.prefixes[PPS_OSIZE] = P_O32)then s := 32
                else                                          s := Fbits;

                um := UInt64(2) shl (s-1);
                uv := opx.offset;

                if (uv > 127) and (uv < SizeOf(UInt64)-128) and  ((uv < um-128) or (uv > um-1)) then
                begin
                    (* If this wasn't explicitly byte-sized, warn as though we
                     * had fallen through to the imm16/32/64 case.
                     *)
                    DoLogMsg(ERR_WARNING or ERR_PASS2 or ERR_WARN_NOV,  'value exceeds bounds byte/word/dword');
                end;
                if (opx.segment <> NO_SEG) then
                begin
                    data := uv;
                    InternalOut(@data, 1,OUT_ADDRESS);
                end else
                begin
                    bytes[0] := uv;
                    InternalOut(@bytes[0], 1,OUT_RAWDATA);
                end;
                offset := offset + 1;
           end;

         192,
         193,
         194,
         195:
           begin

           end;

         200:
           begin
                if (Fbits = 32) and ( not has_prefix(ins, PPS_ASIZE, P_A16)) then
                begin
                    bytes[0] := $67;
                    InternalOut(@bytes[0], 1,OUT_RAWDATA);
                    offset := offset + 1;
                end
                else
                    offset := offset + 0;
           end;

         201:
           begin
                if (Fbits = 32) and ( not has_prefix(ins, PPS_ASIZE, P_A32)) then
                begin
                    bytes[0] := $67;
                    InternalOut(@bytes[0], 1,OUT_RAWDATA);
                    offset := offset + 1;
                end
                else
                    offset := offset + 0;
           end;

         202,    // Address size is default
         221,
         222,
         223:
           begin

           end;

         203:
           begin
                ins.rex := 0;
           end;

         204,
         205,
         206,
         207,
         217,    // No REP prefix permitted
         225:    // Needs a wait prefix
           begin

           end;

         208,     // 16-bit operand size
         209,     // 32-bit operand size
         210,     // Operand size is default
         211,     // Implied 64-bit operand size (no REX.W)
         213,     // Use spl/bpl/sil/dil even without REX
         214:     // No REP 0xF3 prefix permitted
           begin

           end;

         212:     // 64-bit operand size requiring REX.W
           begin
                ins.rex := ins.rex or REX_W;
           end;

         216:
           begin
                bytes[0] := codes^ xor get_cond_opcode(ins.condition);
                inc(codes);
                InternalOut(@bytes[0], 1,OUT_RAWDATA);
                offset := offset + 1;
           end;

         240,    // No prefix
         244,
         245,
         248,   // Match only if Jcc possible with single byte
         249,   // Match only if JMP possible with single byte
         250:
           begin

           end;

         218,     // F2 prefix, but 66 for operand size is OK
         219:     // F3 prefix, but 66 for operand size is OK
           begin
               bytes[0] :=  c - 218 + $F2;
               InternalOut(@bytes[0], 1,OUT_RAWDATA);
               offset := offset + 1;
           end;

         220:
           begin
               if (ins.rex and REX_R) <> 0 then
               begin
                  bytes[0] := $F0;
                  InternalOut(@bytes[0], 1,OUT_RAWDATA);
                  offset := offset + 1;
               end;
               ins.rex :=  ins.rex and (not(REX_L or REX_R));
           end;

         224:
           begin
               if (ins.oprs[0].segment <> NO_SEG)  then
                   DoLogMsg(ERR_PANIC, 'non-constant BSS size in pass two')
               else begin
                   if (ins.oprs[0].offset > 0) then
                       InternalOut(nil, ins.oprs[0].offset,OUT_RESERVE);
                   offset := offset + ins.oprs[0].offset;
               end;
           end;

         241:
           begin
               bytes[0] := $66;
               InternalOut(@bytes[0],1,OUT_RAWDATA);
               offset := offset + 1;
           end ;

         246,
         247:
           begin
               bytes[0] := c - 246 + $66;
               InternalOut(@bytes[0],1,OUT_RAWDATA);
               offset := offset + 1;
           end;

         251:       // Length of jump
           begin
               if  Fbits = 16 then bytes[0] := 3
               else               bytes[0] := 5;

               InternalOut(@bytes[0], 1,OUT_RAWDATA);
               offset := offset + 1;
           end;

         252:                          // This instruction takes XMM VSIB
           begin
               eat := EA_XMMVSIB;
           end;

         253:                          // This instruction takes YMM VSIB
           begin
               eat := EA_YMMVSIB;
           end;

         254:                          // This instruction takes ZMM VSIB
           begin
               eat := EA_ZMMVSIB;
           end;

         64..67,
         72..75,
         80..83,
         88..91,
         128..159:
           begin
                opy := ins.oprs[op2];

                if (c <= 127) then
                begin
                    (* pick rfield from operand b (opx) *)
                    rflags := regflag(opx);
                    rfield := nasm_regvals[opx.basereg];
                end  else
                begin
                    (* rfield is constant *)
                    rflags := 0;
                    rfield := c and 7;
                end;

                if (process_ea(opy, ea_data, rfield, rflags, ins) <> eat) then
                    DoLogMsg(ERR_NONFATAL, 'invalid effective address');

                p  := @bytes[0];
                p^ := ea_data.modrm;
                inc(p);
                if (ea_data.sib_present) <> 0 then
                begin
                    p^ := ea_data.sib;
                    inc(p);
                end;
                s := Cardinal(p) - Cardinal(@bytes[0]);
                InternalOut(@bytes[0],s,OUT_RAWDATA);

                (*
                 * Make sure the address gets the right offset in case
                 * the line breaks in the .lst file (BR 1197827)
                 *)
                offset := offset + s;
                s      := 0;

                if (ea_data.bytes) <> 0 then
                begin
                    (* use compressed displacement, if available *)
                    if ea_data.disp8 <> 0 then  data := ea_data.disp8
                    else                        data := opy.offset;

                    s := s + ea_data.bytes;
                    if (ea_data.rip) <> 0 then
                    begin
                        if (opy.segment = segment) then
                        begin
                            data := data - insn_end;
                            if (overflow_signed(data, ea_data.bytes)) then
                                warn_overflow(ERR_PASS2, ea_data.bytes);
                            InternalOut(@data, ea_data.bytes,OUT_ADDRESS);
                        end else
                        begin
                            (* overflow check in output/linker? *)
                            InternalOut(@data,insn_end - offset,OUT_REL4ADR);
                        end;
                    end else
                    begin
                        asize := ins.addr_size shr 3;
                        atype := ea_data.bytes;

                        if (overflow_general(data, asize)) or
                           ( signed_bits(data, ins.addr_size) <> signed_bits(data, ea_data.bytes shl 3)) then
                            warn_overflow(ERR_PASS2, ea_data.bytes);

                        if (asize > ea_data.bytes) then
                        begin
                            (*
                             * If the address isn't the full width of
                             * the address size, treat is as signed...
                             *)
                            atype := -atype;
                        end;

                        InternalOut(@data, atype,OUT_ADDRESS);
                    end;
                end;
                offset := offset + s;
           end
        else begin
                DoLogMsg(ERR_PANIC, 'internal instruction table corrupt ');
        end;

        end;
     end;
end;

function TCodeGen.insn_size(offset:Int64; bits : Integer; instruction: TInsn):Int64;
var
  temp     : PItemplate;
  j        : Integer;
  m        : match_result;
  iSize    : Int64;

begin
      //nel caso delle definizione delle label
      if instruction.opcode = I_none then
      begin
           Result := 0;
           Exit;
      end;

      (* Check to see if we need an address-size prefix*)
      add_asp(instruction, bits);

      m := find_match(temp, instruction, offset);

      if (m = MOK_GOOD) then   (* Matches!*)
      begin
          iSize := calcsize(instruction, temp);
          if (iSize < 0) then (* shouldn't be, on pass two*)
          begin
              Result := -1;
              Exit;
          end ;
          for j := 0 to MAXPREFIX -1 do
          begin
               case instruction.prefixes[j] of
                 P_A16:
                      begin
                          if (bits <> 16) then inc(iSize);
                      end;
                 P_A32:
                      begin
                          if (bits <> 32) then inc(iSize);
                      end;
                 P_O16:
                      begin
                          if (bits <> 16) then inc(iSize);
                      end;
                 P_O32:
                      begin
                           if (bits = 16) then inc(iSize);
                      end;
                 P_A64,
                 P_O64,
                 P_EVEX,
                 P_VEX3,
                 P_VEX2,
                 P_NOBND,
                 P_none:
                       begin
                       end;
               else
                  inc(iSize);
               end; // case
          end;
          Result := iSize
      end
      else Result := -1;
end;

end.
