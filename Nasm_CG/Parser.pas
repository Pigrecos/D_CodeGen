unit Parser;

interface
  uses
    System.SysUtils,
    Winapi.Windows,
    Nasm_Def,
    NasmLib,
    OpFlags,
    untStdScan,
    untExpr;

const
  DEF_ABS = 0;
  DEF_REL =1;

type
  TParserNasm = class
    private
       FTokval_p  : TTokenVal;     (* The current token *)
       FScanner   : TScan;
       FOnLogMsg  : TLogMsg;
       FOptimizing: Integer;       (* number of optimization passes to take *)
       FGlobalRel : Integer ;      (* default to relative addressing? *)
       FGlobalBits: Integer ;      (* 16, 32 or 64-bit mode *)
       FErrore    : Integer ;      (* <> 0 indica che si è generato un errorre*)
       procedure DoLogMsg(Severity : Integer; strMsg : string);
       function  Prefix_slot(prefix: Integer): Integer;
       procedure Process_size_override(var Res : TInsn; var op : TOperand);
       function  Parse_braces(var decoflags : decoflags_t): Boolean;
       procedure Mref_set_optype(var op: TOperand);
       function  Parse_mref(var op: TOperand; vect: PAexpr): Integer;
    public
       constructor Create;
       destructor  Destroy; override;
       function    Parse_Line(pass: Integer; buffer: PAnsiChar; var res: TInsn; ldef: TLDEF): TInsn ;

       property OnMsgLog  : TLogMsg     read FOnLogMsg     write FOnLogMsg;
       property Optimizing: Integer     read FOptimizing   write FOptimizing;
       property GlobalRel : Integer     read FGlobalRel    write FGlobalRel;
       property GlobalBits: Integer     read FGlobalBits   write FGlobalBits;
       property Errore    : Integer     read FErrore;
  end;

implementation

constructor TParserNasm.Create;
(******************************)
begin
     FScanner   := TScan.Create;
     FOptimizing:= $3fffffff;
     FGlobalRel := DEF_ABS;
     FGlobalBits:= 32;
end;

destructor TParserNasm.Destroy;
(*****************************)
begin
     FScanner.Free;
end;

procedure TParserNasm.DoLogMsg(Severity : Integer; strMsg : string);
(*******************************************************************************)
begin
    FErrore := 1;
    if Assigned(FOnLogMsg) then  FOnLogMsg(Severity,'[PARSER_NASM] -'+'"'+string(FScanner.stdscan_get)+'" '+ strMsg);
end;

function TParserNasm.Prefix_slot(prefix: Integer): Integer;
(**********************************************************)
begin
    case prefix of
     P_WAIT:     Result := PPS_WAIT;
     R_CS,
     R_DS,
     R_SS,
     R_ES,
     R_FS,
     R_GS:       Result := PPS_SEG;
     P_LOCK:     Result := PPS_LOCK;
     P_REP,
     P_REPE,
     P_REPZ,
     P_REPNE,
     P_REPNZ,
     P_XACQUIRE,
     P_XRELEASE,
     P_BND,
     P_NOBND:    Result := PPS_REP;
     P_O16,
     P_O32,
     P_O64,
     P_OSP:      Result := PPS_OSIZE;
     P_A16,
     P_A32,
     P_A64,
     P_ASP:      Result := PPS_ASIZE;
     P_EVEX,
     P_VEX3,
     P_VEX2:     Result := PPS_VEX;
    else begin
        DoLogMsg(ERR_PANIC, Format('Invalid value %d passed to prefix_slot()', [prefix]));
        Result := -1;
        Exit;
    end;
    end;
end;

procedure TParserNasm.Process_size_override(var Res : TInsn; var op : TOperand);
(********************************************************************************)
begin
    (* Standard NASM compatible syntax *)
    case Ftokval_p.t_integer of
     S_NOSPLIT: op.eaflags := op.eaflags or EAF_TIMESTWO;
     S_REL:     op.eaflags := op.eaflags or EAF_REL;
     S_ABS:     op.eaflags := op.eaflags or EAF_ABS;
     S_BYTE:
           begin
                op.disp_size := 8;
                op.eaflags   := op.eaflags or EAF_BYTEOFFS;
           end;
     P_A16,
     P_A32,
     P_A64:
           begin
                if (Res.prefixes[PPS_ASIZE] <> 0) and (Res.prefixes[PPS_ASIZE] <> Ftokval_p.t_integer)  then
                    DoLogMsg(ERR_NONFATAL, 'conflicting address size specifications')
                else
                    Res.prefixes[PPS_ASIZE] := Ftokval_p.t_integer;
           end;
     S_WORD:
           begin
                op.disp_size := 16;
                op.eaflags   := op.eaflags or EAF_WORDOFFS;
           end;
     S_DWORD,
     S_LONG:
           begin
                op.disp_size := 32;
                op.eaflags   := op.eaflags or EAF_WORDOFFS;
           end;
     S_QWORD:
           begin
                op.disp_size := 64;
                op.eaflags   := op.eaflags or EAF_WORDOFFS;
           end;
    else
        DoLogMsg(ERR_NONFATAL, 'invalid size specification in effective address');

    end;
end;

(*
 * when two or more decorators follow a register operand,
 * consecutive decorators are parsed here.
 * opmask and zeroing decorators can be placed in any order.
 * e.g. zmm1 {k2}{z} or zmm2 {z}{k3}
 * decorator(s) are placed at the end of an operand.
 *)
function TParserNasm.Parse_braces(var decoflags : decoflags_t): Boolean;
(************************************************************************)
var
  i       : Integer;
  recover : Boolean;
begin
    recover := false;

    i := Ftokval_p.t_type;
    while True do
    begin
        if (i = TOKEN_OPMASK)  then
        begin
            if ( decoflags and OPMASK_MASK) <> 0 then
            begin
                DoLogMsg(ERR_NONFATAL, Format('opmask k%"PRIu64 is already set',[decoflags and OPMASK_MASK]));
                decoflags := decoflags and ( not OPMASK_MASK);
            end;
            decoflags :=  decoflags or VAL_OPMASK(nasm_regvals[Ftokval_p.t_integer]);
        end
        else if (i = TOKEN_DECORATOR) then
        begin
            case (Ftokval_p.t_integer) of
             BRC_Z:
                (*
                 * according to AVX512 spec, only zeroing/merging decorator
                 * is supported with opmask
                 *)
                decoflags := decoflags or GEN_Z(0);
            else
                DoLogMsg(ERR_NONFATAL, Format('{%s} is not an expected decorator', [Ftokval_p.t_charptr]));
            end;
        end
        else if (i = ord(',')) or (i = TOKEN_EOS)then
        begin
            break;
        end else
        begin
            DoLogMsg(ERR_NONFATAL, 'only a series of valid decorators expected');
            recover := true;
            break;
        end;
        i := FScanner.stdscan(Ftokval_p);
    end;

    Result := recover;
end;

procedure TParserNasm.Mref_set_optype(var op: TOperand);
(*******************************************************)
var
  b, i, s : Integer;
  is_rel  : Boolean;
  iclass  : opflags_t;

begin
    b := op.basereg;
    i := op.indexreg;
    s := op.scale;

    (* It is memory, but it can match any r/m operand *)
    op.tipo := op.tipo or MEMORY_ANY;

    if (b = -1) and  ((i = -1) or (s = 0)) then
    begin
        is_rel := (FGlobalBits = 64) and ((op.eaflags and EAF_ABS) = 0) and
                  (((FGlobalrel <> 0) and  ((op.eaflags and EAF_FSGS)= 0 )) or
                   ((op.eaflags and EAF_REL) <> 0));
        op.tipo := op.tipo or IfThen(is_rel,IP_REL,MEM_OFFS);
    end;

    if (i <> -1) then
    begin
        iclass := nasm_reg_flags[i];

        if      (is_class(XMMREG,iclass)) then  op.tipo := op.tipo or XMEM
        else if (is_class(YMMREG,iclass)) then  op.tipo := op.tipo or YMEM
        else if (is_class(ZMMREG,iclass)) then  op.tipo := op.tipo or ZMEM;
    end;
end;

function TParserNasm.Parse_mref(var op: TOperand; vect: PAexpr): Integer;
(*************************************************************************)
var
  b,i,s,x : Integer;  (* basereg, indexreg, scale *)
  o       : Int64;    (* offset *)
  e       : Aexpr;
  is_gpr  : Boolean;
begin
    i := -1;
    b := i ;
    s := 0;
    o := s;

    x := 0;
    e := vect^;

    if (e[x].tipo <> 0) and (e[x].tipo <= EXPR_REG_END) then    (* this bit's a register *)
    begin
        is_gpr := is_class(REG_GPR,nasm_reg_flags[e[x].tipo]);

        if (is_gpr) and (e[x].value = 1) then
            b := e[x].tipo 	(* It can be basereg *)
        else begin               	(* No, it has to be indexreg *)
            i := e[x].tipo;
            s := e[x].value;
        end;
        inc(x);
    end;

    if (e[x].tipo <> 0) and (e[x].tipo <= EXPR_REG_END) then   (* it's a 2nd register *)
    begin
        is_gpr := is_class(REG_GPR,nasm_reg_flags[e[x].tipo]);

        if (b <> -1) then    (* If the first was the base, ... *)
        begin
            i := e[x].tipo;   (* second has to be indexreg *)
            s := e[x].value;
        end
        else if ( is_gpr = False) or (e[x].value <> 1) then
        begin
            (* If both want to be index *)
            DoLogMsg(ERR_NONFATAL, 'invalid effective address: two index registers');
            Result := -1;
            Exit;
        end else
            b := e[x].tipo;
        Inc(x);
    end;

    if (e[x].tipo <> 0) then (* is there an offset? *)
    begin
        if (e[x].tipo <= EXPR_REG_END) then  (* in fact, is there an error? *)
        begin
            DoLogMsg(ERR_NONFATAL, 'beroset-p-603-invalid effective address');
            Result := -1;
            Exit;
        end else
        begin
            if (e[x].tipo = EXPR_UNKNOWN) then
            begin
                op.opflags := op.opflags or OPFLAG_UNKNOWN;
                o          := 0;  (* doesn't matter what *)
                op.wrt     := NO_SEG;     (* nor this *)
                op.segment := NO_SEG; (* or this *)
                while (e[x].tipo) <> 0 do
                    Inc(x);        (* go to the end of the line *)
            end else
            begin
                if (e[x].tipo = EXPR_SIMPLE) then
                begin
                    o := e[x].value;
                    inc(x);
                end;
                if (e[x].tipo = EXPR_WRT) then
                begin
                    op.wrt := e[x].value;
                    inc(x);
                end else
                    op.wrt := NO_SEG;
                (*
                 * Look for a segment base type.
                 *)
                if (e[x].tipo <> 0) and (e[x].tipo < EXPR_SEGBASE) then
                begin
                    DoLogMsg(ERR_NONFATAL, 'beroset-p-630-invalid effective address');
                    Result := -1;
                    Exit;
                end;
                while (e[x].tipo <> 0) and (e[x].value = 0) do
                    Inc(x);
                if (e[x].tipo <> 0) and (e[x].value <> 1) then
                begin
                    DoLogMsg(ERR_NONFATAL, 'beroset-p-637-invalid effective address');
                    Result := -1;
                    Exit;
                end;
                if (e[x].tipo) <> 0 then
                begin
                    op.segment := e[x].tipo - EXPR_SEGBASE;
                    inc(x);
                end else
                    op.segment := NO_SEG;
                while (e[x].tipo <> 0) and (e[x].value = 0)  do
                    inc(x);
                if (e[x].tipo) <> 0 then
                begin
                    DoLogMsg(ERR_NONFATAL, 'beroset-p-650-invalid effective address');
                    Result := -1;
                    Exit;
                end;
            end;
        end;
    end else
    begin
        o          := 0;
        op.wrt     := NO_SEG;
        op.segment := NO_SEG;
    end;

    if (e[x].tipo <> 0) then  (* there'd better be nothing left! *)
    begin
        DoLogMsg(ERR_NONFATAL,   'beroset-p-663-invalid effective address');
        Result := -1;
        Exit;
    end;

    op.basereg  := b;
    op.indexreg := i;
    op.scale    := s;
    op.offset   := o;
    Result      := 0;

end;

function  TParserNasm.Parse_line(pass: Integer; buffer: PAnsiChar; var res: TInsn; ldef: TLDEF): TInsn ;
(******************************************************************************************)
var
  hints         : eval_hints;
  opnum         : Integer;
  recover       : Boolean;
  i_Tok         : Integer ;      (* The t_type of tokval *)
  slot,j,
  Critical      : Integer;
  pfx           : prefixes;
  insn_is_label,
  first         : Boolean;

  op            : POperand ;
  value         : Aexpr ;        (* used most of the time *)
  mref,                          (* is this going to be a memory ref? *)
  bracket,                       (* is it a [] mref, or a & mref? *)
  mib           : Boolean ;      (* compound (mib) mref? *)
  setsize       : Integer;
  brace_flags   : decoflags_t;   (* flags for decorators in braces *)

  o1, o2        : TOperand;      (* Partial operands *)

  n             : UInt64;
  rs            : opflags_t;

  label fail,restart_parse;
begin
    insn_is_label   := False;

 restart_parse:
    Res.forw_ref    := false;
    Res.llabel      := nil;  (* Assume no label *)
    Res.operands    := 0;    (* must initialize this *)
    Res.evex_rm     := 0;    (* Ensure EVEX rounding mode is reset *)
    Res.evex_brerop := -1;   (* Reset EVEX broadcasting/ER op position *)

    FErrore         := 0;
    first           := True;

    FScanner.stdscan_reset();
    FScanner.stdscan_set(buffer);
    i_Tok := FScanner.stdscan(Ftokval_p);

    (* Ignore blank lines *)
    if (i_Tok = TOKEN_EOS) then goto fail;

    if (i_Tok <> TOKEN_INSN) and (i_Tok <> TOKEN_PREFIX) and (i_Tok <> TOKEN_ID) then
    begin
         DoLogMsg(ERR_NONFATAL, 'label or instruction expected at start of line');
         goto fail;
    end;

    if (i_Tok = TOKEN_ID) or ((insn_is_label) and (i_Tok = TOKEN_INSN)) then
    begin
        (* there's a label here *)
        first      := false;
        Res.llabel := Ftokval_p.t_charptr;
        i_Tok      := FScanner.stdscan(Ftokval_p);
        (* skip over the optional colon *)
        if (i_Tok = Ord(':')) then
            i_Tok := FScanner.stdscan(Ftokval_p)
        else if (i_Tok = TOKEN_EOS) then
             DoLogMsg(ERR_WARNING or ERR_WARN_OL or ERR_PASS1, 'label alone on a line without a colon might be in error');

        if (i_Tok <> TOKEN_INSN) or (Ftokval_p.t_integer <> I_EQU) then
             ldef(Res.llabel, NO_SEG,Location.offset);
    end;

    (* Just a label here *)
    if (i_Tok = TOKEN_EOS) then goto fail;

    ZeroMemory(@Res.prefixes[0],sizeof(Res.prefixes[0])* Length(Res.prefixes));

    while (i_Tok = TOKEN_PREFIX)  do
    begin
        first := False;
        slot := prefix_slot(Ftokval_p.t_integer);
        if (Res.prefixes[slot]) <> 0 then
        begin
           if (Res.prefixes[slot] = Ftokval_p.t_integer) then
                DoLogMsg(ERR_WARNING or ERR_PASS1, 'instruction has redundant prefixes')
           else
                DoLogMsg(ERR_NONFATAL, 'instruction has conflicting prefixes');
        end;
        Res.prefixes[slot] := Ftokval_p.t_integer;
        i_Tok              := FScanner.stdscan(Ftokval_p);
    end;

    if (i_Tok <> TOKEN_INSN) then
    begin
        for j := 0 to  MAXPREFIX -1 do
        begin
             pfx := Res.prefixes[j];
             if (pfx <> P_none) then  break;
        end;

        if (i_Tok = 0) and (pfx <> P_none) then
        begin
            DoLogMsg(ERR_NONFATAL, 'parser: instruction expected');
            goto fail;
        end;
    end;

    Res.opcode    := Ftokval_p.t_integer;
    Res.condition := Ftokval_p.t_inttwo;

    if pass = 2 then Critical := 2
    else             Critical := 0;

    (*
     * Now we begin to parse the operands. There may be up to four
     * of these, separated by commas, and terminated by a zero token.
     *)
    opnum := 0;
    repeat
        op          := @Res.oprs[opnum];
        setsize     := 0;
        brace_flags := 0;

        op^.disp_size := 0;    (* have to zero this whatever *)
        op^.eaflags   := 0;    (* and this *)
        op^.opflags   := 0;
        op^.decoflags := 0;

        i_Tok := FScanner.stdscan(Ftokval_p);
        if (i_Tok = TOKEN_EOS) then Break    (* end of operands: get out of here *)
        else if (first) and (i_Tok = Ord(':')) then
        begin
              insn_is_label := True;
              goto restart_parse;
        end;
        first := False;

        op^.tipo := 0; (* so far, no override *)

        while (i_Tok = TOKEN_SPECIAL) do
        begin    (* size specifiers *)
            case Ftokval_p.t_integer of
             S_BYTE:
                   begin
                        if setsize = 0 then   (* we want to use only the first *)
                            op^.tipo := op^.tipo or BITS8;
                        setsize := 1;
                   end;
             S_WORD:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS16;
                        setsize := 1;
                   end;
             S_DWORD,
             S_LONG:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS32;
                        setsize := 1;
                   end;
             S_QWORD:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS64;
                        setsize := 1;
                   end;
             S_TWORD:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS80;
                        setsize := 1;
                   end;
             S_OWORD:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS128;
                        setsize := 1;
                   end;
             S_YWORD:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS256;
                        setsize := 1;
                   end;
             S_ZWORD:
                   begin
                        if setsize = 0 then
                            op^.tipo := op^.tipo or BITS512;
                        setsize := 1;
                   end;
             S_TO:      op^.tipo := op^.tipo or TO_;
             S_STRICT:  op^.tipo := op^.tipo or STRICT_;
             S_FAR:     op^.tipo := op^.tipo or FAR_;
             S_NEAR:    op^.tipo := op^.tipo or NEAR_;
             S_SHORT:   op^.tipo := op^.tipo or SHORT;
            else
                DoLogMsg(ERR_NONFATAL, 'invalid operand size specification');
            end;
            i_Tok := FScanner.stdscan(Ftokval_p);
        end;

        if (i_Tok = ord('[')) or (i_Tok = ord('&')) then  (* memory reference *)
        begin
            mref    := true;
            bracket := (i_Tok = ord('['));
            i_Tok       := FScanner.stdscan(Ftokval_p); (* then skip the colon *)
            while (i_Tok = TOKEN_SPECIAL) or (i_Tok = TOKEN_PREFIX) do
            begin
                process_size_override(Res, op^);
                i_Tok := FScanner.stdscan(Ftokval_p);
            end;
            (* when a comma follows an opening bracket - [ , eax*4] *)
            if (i_Tok = Ord(',')) then
            begin
                (* treat as if there is a zero displacement virtually *)
                Ftokval_p.t_type    := TOKEN_NUM;
                Ftokval_p.t_integer := 0;
                FScanner.stdscan_set(FScanner.stdscan_bufptr - 1);     (* rewind the comma *)
            end;
        end else
        begin                (* immediate operand, or register *)
            mref    := false;
            bracket := false;    (* placate optimisers *)
        end;

        if ((op^.tipo and FAR_) <> 0) and  (mref = False) and
           (Res.opcode <> I_JMP) and (Res.opcode <> I_CALL) then
              DoLogMsg(ERR_NONFATAL, 'invalid use of FAR operand specifier');

        value := evaluate(FScanner.stdscan, @Ftokval_p, op^.opflags,Critical, @hints);
        i_Tok := Ftokval_p.t_type;
        if (op^.opflags and OPFLAG_FORWARD) <> 0 then   Res.forw_ref := true;

        if Length(value) = 0 then goto fail;                (* Error in evaluator *)

        if (i_Tok = Ord(':')) and (mref) then (* it was seg:offset *)
        begin
            (*
             * Process the segment override.
             *)
            if ( (Length(value) > 0) and (value[1].tipo   <> 0)) or (value[0].value  <> 1)  or (IS_SREG(value[0].tipo)= False)  then
                DoLogMsg(ERR_NONFATAL, 'invalid segment override')
            else if (Res.prefixes[PPS_SEG] <> 0) then
                DoLogMsg(ERR_NONFATAL, 'instruction has conflicting segment overrides')
            else begin
                Res.prefixes[PPS_SEG] := value[0].tipo;
                if (IS_FSGS(value[0].tipo)) then
                    op^.eaflags := op^.eaflags or EAF_FSGS;
            end;

            i_Tok := FScanner.stdscan(Ftokval_p); (* then skip the colon *)
            while (i_Tok = TOKEN_SPECIAL) or (i_Tok = TOKEN_PREFIX) do
            begin
                process_size_override(result, op^);
                i_Tok := FScanner.stdscan(Ftokval_p);
            end;
            value := evaluate(FScanner.stdscan, @Ftokval_p, op^.opflags, Critical, @hints);
            i_Tok := Ftokval_p.t_type;

            if (op^.opflags and OPFLAG_FORWARD) <> 0 then Res.forw_ref := true;

            (* and get the offset *)
            if Length(value) = 0 then  goto fail;            (* Error in evaluator *)

        end;

        mib := false;
        if (mref) and (bracket) and (i_Tok = Ord(',')) then
        begin
            (* [seg:base+offset,index*scale] syntax (mib) -- Es. mov eax,[ebx+8,ecx*4] -- *)

            if parse_mref(o1, @value) <> 0 then goto fail;

            //i_Tok     := FScanner.stdscan(Ftokval_p); (* Eat comma *)
            value := evaluate(FScanner.stdscan, @Ftokval_p, op^.opflags, Critical, @hints);
            i_Tok     := Ftokval_p.t_type;
            if value = nil then goto fail;

            if parse_mref(o2, @value) <> 0 then goto fail;

            if (o2.basereg <> -1) and (o2.indexreg = -1) then
            begin
                o2.indexreg := o2.basereg;
                o2.scale    := 1;
                o2.basereg  := -1;
            end;

            if (o1.indexreg <> -1) or (o2.basereg <> -1) or (o2.offset <> 0) or
               (o2.segment <> NO_SEG) or (o2.wrt <> NO_SEG) then
            begin
                DoLogMsg(ERR_NONFATAL, 'invalid mib expression');
                goto fail;
            end;

            op^.basereg  := o1.basereg;
            op^.indexreg := o2.indexreg;
            op^.scale    := o2.scale;
            op^.offset   := o1.offset;
            op^.segment  := o1.segment;
            op^.wrt      := o1.wrt;

            if (op^.basereg <> -1) then
            begin
                op^.hintbase := op^.basereg;
                op^.hinttype := EAH_MAKEBASE;
            end
            else if (op^.indexreg <> -1) then
            begin
                op^.hintbase := op^.indexreg;
                op^.hinttype := EAH_NOTBASE;
            end else
            begin
                op^.hintbase := -1;
                op^.hinttype := EAH_NOHINT;
            end;

            mib := true;
        end;

        recover := false;
        if (mref and bracket) then  (* find ] at the end *)
        begin
            if i_Tok <> Ord(']') then
            begin
                DoLogMsg(ERR_NONFATAL, 'expecting ]');
                recover := true;
            end else             (* we got the required ] *)
            begin
                i_Tok := FScanner.stdscan(Ftokval_p);
                if ((i_Tok = TOKEN_DECORATOR) or (i_Tok = TOKEN_OPMASK)) then
                begin
                    (*
                     * according to AVX512 spec, broacast or opmask decorator
                     * is expected for memory reference operands
                     *)
                    if (Ftokval_p.t_flag and TFLAG_BRDCAST) <> 0 then
                    begin
                        brace_flags := brace_flags or GEN_BRDCAST(0) or VAL_BRNUM(Ftokval_p.t_integer - BRC_1TO2);
                        i_Tok := FScanner.stdscan(Ftokval_p);
                    end
                    else if (i_Tok = TOKEN_OPMASK) then
                    begin
                        brace_flags := brace_flags or VAL_OPMASK(nasm_regvals[Ftokval_p.t_integer]);
                        i_Tok := FScanner.stdscan(Ftokval_p);
                    end else
                    begin
                        DoLogMsg(ERR_NONFATAL, 'broadcast or opmask decorator expected inside braces');
                        recover := true;
                    end;
                end;

                if (i_Tok <> 0) and (i_Tok <> ord(',')) then
                begin
                    DoLogMsg(ERR_NONFATAL, 'comma or end of line expected');
                    recover := true;
                end;
            end;
        end else                 (* immediate operand *)
        begin
            if (i_Tok <> 0) and (i_Tok <> Ord(',')) and (i_Tok <> Ord(':')) and (i_Tok <> TOKEN_DECORATOR) and (i_Tok <> TOKEN_OPMASK) then
            begin
                DoLogMsg(ERR_NONFATAL, 'comma, colon, decorator or end of line expected after operand');
                recover := true;
            end
            else if (i_Tok = Ord(':')) then
            begin
                op^.tipo := op^.tipo or COLON;
            end
            else if (i_Tok = TOKEN_DECORATOR) or (i_Tok = TOKEN_OPMASK) then
            begin
                (* parse opmask (and zeroing) after an operand *)
                recover := parse_braces(brace_flags);
            end;
        end;
        if (recover) then
        begin
            i_Tok := FScanner.stdscan(Ftokval_p);
            while (i_Tok <> 0) and (i_Tok <> ord(',')) do            (* error recovery *)
            begin
                i_Tok := FScanner.stdscan(Ftokval_p);
            end;
        end;

        (*
         * now convert the exprs returned from evaluate()
         * into operand descriptions...
         *)
        op^.decoflags := op^.decoflags or brace_flags;

        if (mref) then             (* it's a memory reference *)
        begin
            (* A mib reference was fully parsed already *)
            if  not mib then
            begin
                if parse_mref(op^, @value) <> 0 then goto fail;
                op^.hintbase := hints.base;
                op^.hinttype := hints.tipo;
            end;
            mref_set_optype(op^);
        end else                 (* it's not a memory reference *)
        begin
            if (is_just_unknown(@value)) then       (* it's immediate but unknown *)
            begin
                op^.tipo      := op^.tipo or IMMEDIATE;
                op^.opflags   := op^.opflags or OPFLAG_UNKNOWN;
                op^.offset    := 0;        (* don't care *)
                op^.segment   := NO_SEG;   (* don't care again *)
                op^.wrt       := NO_SEG;   (* still don't care *)

                if(FOptimizing >= 0) and ((op^.tipo and STRICT_)= 0) then
                begin
                    (* Be optimistic *)
                    op^.tipo := op^.tipo or UNITY or SBYTEWORD or SBYTEDWORD or UDWORD or SDWORD;
                end;
            end
            else if (is_reloc(@value)) then       (* it's immediate *)
            begin
                op^.tipo      := op^.tipo or IMMEDIATE;
                op^.offset    := reloc_value(@value);
                op^.segment   := reloc_seg(@value);
                op^.wrt       := reloc_wrt(@value);

                if (is_simple(@value)) then
                begin
                    n := reloc_value(@value);
                    if (n = 1) then
                        op^.tipo := op^.tipo or UNITY;
                    if (FOptimizing >= 0) and ((op^.tipo and STRICT_) = 0) then
                    begin
                        if (Cardinal(n + 128) <= 255)  then  op^.tipo := op^.tipo or SBYTEDWORD;
                        if (UInt16(n + 128) <= 255)    then  op^.tipo := op^.tipo or SBYTEWORD;
                        if (n <= $FFFFFFFF)            then  op^.tipo := op^.tipo or UDWORD;
                        if (n + $80000000 <= $FFFFFFFF)then  op^.tipo := op^.tipo or SDWORD;
                    end;
                end;
            end
            else if(value[0].tipo = EXPR_RDSAE) then
            begin
                (*
                 * it's not an operand but a rounding or SAE decorator.
                 * put the decorator information in the (opflag_t) type field
                 * of previous operand.
                 *)
                Dec(opnum);
                Dec(op);
                case value[0].value of
                 BRC_RN,
                 BRC_RU,
                 BRC_RD,
                 BRC_RZ,
                 BRC_SAE:
                        begin
                            op^.decoflags := op^.decoflags or IfThen(value[0].value = BRC_SAE, SAE, ER);
                            Res.evex_rm   := value[0].value;
                        end
                else
                    DoLogMsg(ERR_NONFATAL, 'invalid decorator');
                    break;
                end;
            end else             (* it's a register *)
            begin

                if (value[0].tipo >= EXPR_SIMPLE) or (value[0].value <> 1) then
                begin
                    DoLogMsg(ERR_NONFATAL, 'invalid operand type');
                    goto fail;
                end;

                (*
                 * check that its only 1 register, not an expression...
                 *)
                for i_Tok := 1 to High(value)  do
                begin
                    if value[i_Tok].tipo = 0 then Break;

                    if (value[i_Tok].value) <> 0 then
                    begin
                        DoLogMsg(ERR_NONFATAL, 'invalid operand type');
                        goto fail;
                    end;
                end;

                (* clear overrides, except TO which applies to FPU regs *)
                if op^.tipo and ( not TO_) <> 0 then
                begin
                    (*
                     * we want to produce a warning iff the specified size
                     * is different from the register size
                     *)
                    rs := op^.tipo and SIZE_MASK;
                end else
                    rs := 0;

                op^.tipo      := op^.tipo and TO_;
                op^.tipo      := op^.tipo or REGISTER_;
                op^.tipo      := op^.tipo or nasm_reg_flags[value[0].tipo];
                op^.decoflags := op^.decoflags or brace_flags;
                op^.basereg   := value[0].tipo;

                if ((rs and (op^.tipo and SIZE_MASK)) <> rs) then
                    DoLogMsg(ERR_WARNING or ERR_PASS1, 'register size specification ignored');
            end;
        end;

        (* remember the position of operand having broadcasting/ER mode *)
        if (op^.decoflags and (BRDCAST_MASK or ER or SAE)) <> 0 then
            Res.evex_brerop := opnum;

        Inc(opnum);

    until (opnum >=  MAX_OPERANDS);

    Res.operands := opnum; (* set operand count *)

    (* clear remaining operands *)
    while (opnum < MAX_OPERANDS) do
    begin
        Res.oprs[opnum].tipo := 0;
        inc(opnum);
    end;
    Result     := Res    ;
    Exit;

fail:
    Res.opcode := I_none;
    Result     := Res    ;

end;

initialization


end.
