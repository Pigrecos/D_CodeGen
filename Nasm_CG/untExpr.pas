unit untExpr;

interface
      uses Nasm_Def,
      NasmLib;

(*
 * Expression-evaluator datatype. Expressions, within the
 * evaluator, are stored as an array of these beasts, terminated by
 * a record with type==0. Mostly, it's a vector type: each type
 * denotes some kind of a component, and the value denotes the
 * multiple of that component present in the expression. The
 * exception is the WRT type, whose `value' field denotes the
 * segment to which the expression is relative. These segments will
 * be segment-base types, i.e. either odd segment values or SEG_ABS
 * types. So it is still valid to assume that anything with a
 * `value' field of zero is insignificant.
 *)
type
TExpr = record
    tipo : Int32;                  (* a register, or EXPR_xxx *)
    value: int64;                  (* must be >= 32 bits *)
end;
Pexpr = ^TExpr;
Aexpr = array of TExpr;
PAexpr = ^Aexpr;

(*
 * The evaluator can also return hints about which of two registers
 * used in an expression should be the base register. See also the
 * `operand' structure.
 *)
Peval_hints = ^eval_hints;
eval_hints  = record
    base: Int64;
    tipo: Integer;
end;

type TexprFun =  reference to function: Aexpr;

const
  (*
   * Special values for expr->type.
   * These come after EXPR_REG_END as defined in regs.h.
   * Expr types : 0 ~ EXPR_REG_END, EXPR_UNKNOWN, EXPR_...., EXPR_RDSAE,
   *              EXPR_SEGBASE ~ EXPR_SEGBASE + SEG_ABS, ...
   *)
 EXPR_UNKNOWN    = EXPR_REG_END+1; (* forward references *)
 EXPR_SIMPLE     = EXPR_REG_END+2;
 EXPR_WRT        = EXPR_REG_END+3;
 EXPR_RDSAE      = EXPR_REG_END+4;
 EXPR_SEGBASE    = EXPR_REG_END+5;

 function evaluate(sc: TScanner; tv: PTTokenVal; fwref: Integer; hints: Peval_hints): Aexpr;
 function is_just_unknown(vvect: PAexpr) : Boolean;
 function is_reloc(vvect: PAexpr): Boolean;
 function reloc_value(vvect: PAexpr): Int64;
 function reloc_seg(vvect: PAexpr): int32;
 function reloc_wrt(vvect: PAexpr): int32;
 function is_simple(vvect: PAexpr) : Boolean;

 function expr5: Aexpr;
 function expr6: Aexpr;

 var
  tokval_ex  : PTTokenVal; (* The current token *)

  bexpr   : TexprFun;
  scan    : TScanner;
  hint    : eval_hints;
  opflags : Integer;
  i_Tok   : Integer;
  tempexpr: Aexpr;

implementation

(**********************************//     Start Expr.c  *****)
(************************************************************)
(*
 * Return true if the argument is a simple scalar. (Or a far-
 * absolute, which counts.)
 *)
function is_simple(vvect: PAexpr) : Boolean;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and (vect[i].value = 0) do
        Inc(i);

    if (vect[i].tipo) = 0 then
    begin
        Result := True;
        Exit;
    end;

    if (vect[i].tipo <> EXPR_SIMPLE) then
    begin
        Result := False;
        Exit;
    end;

    Inc(i);
    while (vect[i].tipo <> 0) and (vect[i].value = 0) do
        Inc(i);

    if (vect[i].tipo <> 0) and (vect[i].tipo < EXPR_SEGBASE + SEG_ABS) then
    begin
        Result := False;
        Exit;
    end;
    Result := True;
end;

(*
 * Return true if the argument is a simple scalar, _NOT_ a far-
 * absolute.
 *)
function is_really_simple(vvect: PAexpr) : Boolean;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and (vect[i].value = 0) do
        Inc(i);

    if (vect[i].tipo) = 0 then
    begin
        Result := True;
        Exit;
    end;

    if (vect[i].tipo <> EXPR_SIMPLE) then
    begin
        Result := False;
        Exit;
    end;

    Inc(i);
    while (vect[i].tipo <> 0) and (vect[i].value = 0) do
        Inc(i);

    if (vect[i].tipo) = 0 then
    begin
        Result := False;
        Exit;
    end;
    Result := True;
end;

(*
 * Return true if the argument is relocatable (i.e. a simple
 * scalar, plus at most one segment-base, plus possibly a WRT).
 *)
function is_reloc(vvect: PAexpr): Boolean;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and (vect[i].value = 0) do  (* skip initial value-0 terms *)
        Inc(i);

    if (vect[i].tipo) = 0 then        (* trivially return true if nothing *)
    begin
        Result := true;               (* is present apart from value-0s *)
        Exit;
    end;

    if (vect[i].tipo < EXPR_SIMPLE) then     (* false if a register is present *)
    begin
        Result := False;
        Exit;
    end;

    if (vect[i].tipo = EXPR_SIMPLE) then     (* skip over a pure number term... *)
    begin
        inc(i);
        while (vect[i].tipo <>0) and (vect[i].value = 0 )do
            Inc(i);

        if (vect[i].tipo) = 0 then       (* ...returning true if that's all *)
        begin
            Result := true;
            Exit;
        end;
    end;

    if (vect[i].tipo = EXPR_WRT) then       (* skip over a WRT term... *)
    begin
        inc(i);
        while (vect[i].tipo <>0) and (vect[i].value = 0 )do
            Inc(i);

        if (vect[i].tipo) = 0 then       (* ...returning true if that's all *)
        begin
            Result := true;
            Exit;
        end;
    end;

    if (vect[i].value <> 0) and (vect[i].value <> 1) then
    begin
        Result := False;               (* segment base multiplier non-unity *)
        Exit;
    end;

    inc(i);
    while (vect[i].tipo <>0) and (vect[i].value = 0 )do      (* skip over _one_ seg-base term... *)
            Inc(i);

    if (vect[i].tipo) = 0 then       (* ...returning true if that's all *)
    begin
        Result := true;
        Exit;
    end;

    Result := False;                   (* And return false if there's more *)
end;

(*
 * Return true if the argument contains an `unknown' part.
 *)
function is_unknown(vvect: PAexpr) : Boolean;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and (vect[i].tipo < EXPR_UNKNOWN) do
        Inc(i);

    Result := vect[i].tipo = EXPR_UNKNOWN;
end;

(*
 * Return true if the argument contains nothing but an `unknown'
 * part.
 *)
function is_just_unknown(vvect: PAexpr) : Boolean;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;
    while (vect[i].tipo <> 0) and (vect[i].value = 0) do
        Inc(i);
    Result := (vect[i].tipo = EXPR_UNKNOWN);
end;

(*
 * Return the scalar part of a relocatable vector. (Including
 * simple scalar vectors - those qualify as relocatable.)
 *)
function reloc_value(vvect: PAexpr): Int64;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and (vect[i].value = 0) do
        Inc(i);

    if (vect[i].tipo) = 0 then
    begin
        Result := 0;
        Exit;
    end;

    if (vect[i].tipo = EXPR_SIMPLE) then
        Result := vect[i].value
    else
        Result := 0;
end;

(*
 * Return the segment number of a relocatable vector, or NO_SEG for
 * simple scalars.
 *)
function reloc_seg(vvect: PAexpr): int32;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and ((vect[i].tipo = EXPR_WRT) or (vect[i].value = 0)) do
        Inc(i);

    if (vect[i].tipo = EXPR_SIMPLE) then
    begin
        Inc(i);
        while (vect[i].tipo <> 0) and ((vect[i].tipo = EXPR_WRT) or (vect[i].value = 0)) do
           Inc(i);
    end;

    if (vect[i].tipo) = 0 then
        Result := NO_SEG
    else
        Result := vect[i].tipo - EXPR_SEGBASE;
end;

(*
 * Return the WRT segment number of a relocatable vector, or NO_SEG
 * if no WRT part is present.
 *)
function reloc_wrt(vvect: PAexpr): int32;
var
  vect : Aexpr;
  i    : Integer;
begin
    vect := vvect^;
    i     := 0;

    while (vect[i].tipo <> 0) and (vect[i].tipo < EXPR_WRT) do
        Inc(i);

    if (vect[i].tipo = EXPR_WRT) then
        Result := vect[i].value
    else
        Result := NO_SEG;
end;
(**********************************//     End Expr.c  *******)
(************************************************************)

(**********************************//     Start Eval.c ******)
(************************************************************)


(*
 * Construct a temporary expression.
 *)
procedure  begintemp;
begin
    SetLength(tempexpr,0);
end;

procedure addtotemp(tipo : Int32; value: Int64);
begin
    SetLength(tempexpr,Length(tempexpr)+ 1);

    tempexpr[High(tempexpr)].tipo  := tipo;
    tempexpr[High(tempexpr)].value := value;
end;

function finishtemp: Aexpr;
begin
    addtotemp(0, 0);          (* terminate *)

    Result := tempexpr;
end;
(*
 * Add two vector datatypes. We have some bizarre behaviour on far-
 * absolute segment types: we preserve them during addition _only_
 * if one of the segments is a truly pure scalar.
 *)
function add_vectors(p, q: Aexpr): Aexpr;
var
  preserve  : Boolean;
  xp,xq     : Integer;
  lasttype  : Integer;
  sum       : Int64;
begin
    preserve := is_really_simple(@p) or is_really_simple(@q);

    begintemp;
    xp := 0;
    xq := 0;

    while (p[xp].tipo <> 0) and (q[xq].tipo <> 0)  and
           (p[xp].tipo < EXPR_SEGBASE + SEG_ABS) and
           (q[xq].tipo < EXPR_SEGBASE + SEG_ABS) do
    begin


        if (p[xp].tipo > q[xq].tipo) then
        begin
            addtotemp(q[xq].tipo, q[xq].value);
            inc(xq);
            lasttype := q[xq].tipo;
        end
        else if (p[xp].tipo < q[xq].tipo) then
        begin
            addtotemp(p[xp].tipo, p[xp].value);
            inc(xp);
            lasttype := p[xp].tipo;
        end else         (* *p and *q have same type *)
        begin
            sum := p[xp].value + q[xq].value;
            if (sum) <> 0 then
            begin
                addtotemp(p[xp].tipo, sum);
                //if (hint) then
                hint.tipo := EAH_SUMMED;
            end;
            lasttype := p[xp].tipo;
            Inc(xp);
            Inc(xq);
        end;
        if (lasttype = EXPR_UNKNOWN) then
        begin
            Result := finishtemp;
            Exit;
        end;
    end;
    while (p[xp].tipo <> 0) and ( (preserve) or (p[xp].tipo < EXPR_SEGBASE + SEG_ABS)) do
    begin
        addtotemp(p[xp].tipo, p[xp].value);
        Inc(xp);
    end;
    while (q[xq].tipo <> 0) and ( (preserve) or (q[xq].tipo < EXPR_SEGBASE + SEG_ABS)) do
    begin
        addtotemp(q[xq].tipo, q[xq].value);
        Inc(xq);
    end;

    Result := finishtemp;
end;

(*
 * Multiply a vector by a scalar. Strip far-absolute segment part
 * if present.
 *
 * Explicit treatment of UNKNOWN is not required in this routine,
 * since it will silently do the Right Thing anyway.
 *
 * If `affect_hints' is set, we also change the hint type to
 * NOTBASE if a MAKEBASE hint points at a register being
 * multiplied. This allows [eax*1+ebx] to hint EBX rather than EAX
 * as the base register.
 *)
function scalar_mult(vect: Aexpr; scalar: Int64; affect_hints: Boolean): Aexpr;
var
   p : Aexpr;
   x : Integer;
begin
    p := vect;
    x := 0;
    while (p[x].tipo <> 0) and (p[x].tipo < EXPR_SEGBASE + SEG_ABS) do
    begin
        p[x].value := scalar * p[x].value;
        if (hint.tipo = EAH_MAKEBASE) and (p[x].tipo = hint.base) and (affect_hints)  then
            hint.tipo := EAH_NOTBASE;
        inc(x);
    end;
    p[x].tipo := 0;

    Result := p;
end;

function scalarvect(scalar: Int64): Aexpr;
begin
    begintemp();
    addtotemp(EXPR_SIMPLE, scalar);
    Result := finishtemp();
end;

function unknown_expr: Aexpr;
begin
    begintemp();
    addtotemp(EXPR_UNKNOWN, 1);
    Result :=  finishtemp();
end;

(*
 * The SEG operator: calculate the segment part of a relocatable
 * value. Return NULL, as usual, if an error occurs. Report the
 * error too.
 *)
function segment_part(e: Aexpr) : Aexpr;
var
   seg,
   base : Int32;
begin


    if is_unknown(@e) then
    begin
        Result := unknown_expr;
        Exit;
    end;

    if not is_reloc(@e) then
    begin
        nasm_Errore(ERR_NONFATAL, 'cannot apply SEG to a non-relocatable value');
        SetLength(Result,0);
        Exit;
    end;

    seg := reloc_seg(@e);
    if (seg = NO_SEG) then
    begin
        nasm_Errore(ERR_NONFATAL, 'cannot apply SEG to a non-relocatable value');
        SetLength(Result,0);
        Exit;
    end
    else if (seg and SEG_ABS) <> 0 then
    begin
        Result := scalarvect(seg and ( not SEG_ABS));
    end
    else if (seg and 1) <> 0 then
    begin
        nasm_Errore(ERR_NONFATAL, 'SEG applied to something which is already a segment base');
        SetLength(Result,0);
        Exit;
    end else
    begin
        base := seg;   // outfmt->segbase(seg + 1);

        begintemp();
        addtotemp( IfThen(base = NO_SEG, EXPR_UNKNOWN, EXPR_SEGBASE + base), 1);
        Result := finishtemp;
    end;
end;

function expr4: Aexpr ;
var
  e, f : Aexpr;
  j    : Integer;
begin
    e := expr5;
    if Length(e) = 0 then
    begin
        SetLength(Result,0);
        Exit;
    end;
    while (i_Tok = ord('+')) or (i_Tok = ord('-')) do
    begin
        j     := i_Tok;
        i_Tok := scan(tokval_ex^);
        f     := expr5;
        if Length(f) = 0 then
        begin
            SetLength(Result,0);
            Exit;
        end;
        case j of
         ord('+'): e := add_vectors(e, f);
         ord('-'): e := add_vectors(e, scalar_mult(f, -1, false));
        end;
    end;
    Result := e;
end;

function expr5: Aexpr;
var
  e, f : Aexpr;
  j    : Integer;
begin

    e := expr6;
    if Length(e) = 0 then
    begin
        SetLength(Result,0);
        Exit;
    end;
    while (i_Tok = ord('*')) do
    begin
        j     := i_Tok;
        i_Tok := scan(tokval_ex^);
        f     := expr6;
        if Length(f) = 0 then
        begin
            SetLength(Result,0);
            Exit;
        end;
        if (is_simple(@e)) then
            e := scalar_mult(f, reloc_value(@e), true)
        else if (is_simple(@f)) then
            e := scalar_mult(e, reloc_value(@f), true)
        else if (is_just_unknown(@e) and is_just_unknown(@f)) then
            e := unknown_expr()
        else begin
            nasm_Errore(ERR_NONFATAL, 'unable to multiply two non-scalar objects');
            SetLength(Result,0);
            Exit;
        end;

    end;
    Result := e;
end;


function expr6: Aexpr;
var
  e : Aexpr;

begin

    case i_Tok of
     Ord('-'):
             begin
                 i_Tok := scan(tokval_ex^);
                 e     := expr6;

                 if Length(e) = 0 then
                 begin
                     SetLength(Result,0);
                     Exit;
                 end;
                 Result := scalar_mult(e, -1, false);
                 Exit;
             end;
     Ord('+'):
             begin
                 i_Tok  := scan(tokval_ex^);
                 Result := expr6;
             end;
     TOKEN_NUM,
     TOKEN_REG,
     TOKEN_ID,
     TOKEN_INSN,            (* Opcodes that occur here are really labels *)
     TOKEN_DECORATOR:
                    begin
                        begintemp;
                        case i_Tok of
                         TOKEN_NUM: addtotemp(EXPR_SIMPLE, tokval_ex^.t_integer);
                         TOKEN_REG:
                                  begin
                                      addtotemp(tokval_ex^.t_integer, 1);
                                      if (hint.tipo = EAH_NOHINT) then
                                      begin
                                          hint.base := tokval_ex^.t_integer;
                                          hint.tipo := EAH_MAKEBASE;
                                      end;
                                  end;
                         TOKEN_ID,
                         TOKEN_INSN:
                                  begin
                                       nasm_errore(ERR_NONFATAL, '($) Symbol Declaration or Instruction labeling Not Supportated!!');
                                       SetLength(Result,0);
                                       Exit;
                                  end;
                         TOKEN_DECORATOR: addtotemp(EXPR_RDSAE, tokval_ex^.t_integer);

                        end;
                        i_Tok  := scan(tokval_ex^);
                        Result := finishtemp();
                    end;
    else begin
        nasm_Errore(ERR_NONFATAL, 'expression syntax error');
        SetLength(Result,0);
        Exit;
    end;
    end
end;

(*
 * The evaluator itself.
 *)
function evaluate(sc: TScanner; tv: PTTokenVal; fwref: Integer; hints: Peval_hints): Aexpr;
var
  e,f  : Aexpr;
  g    : Aexpr;
  value: Int64;
begin
    hint := hints^;
    if (hints) <> nil then
        hint.tipo := EAH_NOHINT;

    bexpr := expr4;

    scan       := sc;
    tokval_ex  := tv;
    opflags    := fwref;

    if (tokval_ex^.t_type = TOKEN_INVALID) then
        i_Tok := scan(tokval_ex^)
    else
        i_Tok := tokval_ex^.t_type;


    e := bexpr;
    if Length(e) = 0 then
    begin
        SetLength(Result,0);
        Exit;
    end;

    if (i_Tok = TOKEN_WRT) then
    begin
        i_Tok := scan(tokval_ex^);       (* eat the WRT *)
        f     := expr6;
        if Length(f) = 0 then
        begin
             SetLength(Result,0);
             Exit;
        end;
    end;

    e := scalar_mult(e, 1, false);      (* strip far-absolute segment part *)
    if Length(f) > 0 then
    begin
        if is_just_unknown(@f) then
            g := unknown_expr()
        else begin
            begintemp();
            if  not is_reloc(@f) then
            begin
                nasm_Errore(ERR_NONFATAL, 'invalid right-hand operand to WRT');
                SetLength(Result,0);
                Exit;
            end;
            value := reloc_seg(@f);
            if (value = NO_SEG)  then
                value := reloc_value(@f) or SEG_ABS
            else if ((value and SEG_ABS)= 0) and ((value mod 2)= 0)  then
            begin
                nasm_Errore(ERR_NONFATAL, 'invalid right-hand operand to WRT');
                SetLength(Result,0);
                Exit;
            end;
            addtotemp(EXPR_WRT, value);
            g := finishtemp();
        end;
        e := add_vectors(e, g);
    end;
    Result := e;

end;

end.
