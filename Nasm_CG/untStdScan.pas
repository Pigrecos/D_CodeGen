unit untStdScan;

interface
    uses
       System.SysUtils,
       windows,
       NasmLib,
       OpFlags,
       Nasm_Def,
       tokhash;

const
    STDSCAN_TEMP_DELTA = 256;

type
   TScan = class
     private
       FStdscan_bufptr     : PAnsiChar;
       FStdscan_tempstorage: NativeUInt;

       procedure stdscan_cleanup;
       function  stdscan_handle_brace(var tv: TTokenVal): Int16;
       function  stdscan_copy(p : PAnsiChar; len: Integer): PAnsiChar;
     public
       constructor Create;
       destructor  Destroy; override;
       function    stdscan(var tv: TTokenVal): Integer;
       procedure   stdscan_reset;
       procedure   stdscan_set(str : AnsiString);
       function    stdscan_get: PAnsiChar;

       property stdscan_bufptr : PAnsiChar read stdscan_get ;
   end;

implementation
       uses
         System.Win.Crtl,
         untCrc64;
{ TScan }

constructor TScan.Create;
(************************)
begin
     if FStdscan_bufptr = nil then
     begin
          FStdscan_bufptr      := GetMemory(STDSCAN_TEMP_DELTA);
          FStdscan_tempstorage := NativeUInt(@FStdscan_bufptr^);
     end;
end;

destructor TScan.Destroy;
(************************)
begin
    stdscan_cleanup;
end;

// Libera Memoria
procedure TScan.stdscan_cleanup;
(******************************)
begin
     if Assigned(FStdscan_bufptr) then
    begin
        stdscan_reset;
        FreeMem(FStdscan_bufptr,STDSCAN_TEMP_DELTA);
        FStdscan_bufptr      := nil;
        FStdscan_tempstorage := 0;
    end;
end;

// Preleva Il Buffer
function TScan.stdscan_get: PAnsiChar;
(************************************)
begin
    Result := Pointer(FStdscan_tempstorage)//FStdscan_bufptr;
end;

// Assegna La stringa Passata alla variabile interna
procedure TScan.stdscan_set(str: AnsiString);
(*******************************************)
begin
     stdscan_reset;

     CopyMemory(FStdscan_bufptr,@str[1],Length(str))  ;
end;

// Azzere
procedure TScan.stdscan_reset;
(****************************)
begin
     if FStdscan_bufptr = nil then Exit;

     FStdscan_bufptr := Pointer(FStdscan_tempstorage);
     ZeroMemory(FStdscan_bufptr,STDSCAN_TEMP_DELTA);
end;

// Ritorna la Copia  della stringa Passata comer parametro di lunghezza len
function TScan.stdscan_copy(p : PAnsiChar; len: Integer): PAnsiChar;
(*******************************************************************)
var
  text : PAnsiChar;
begin
    text := nasm_malloc(len + 1);
    memcpy(text, p, len);
    text[len] := #0;

    Result := text;
end;

(*
 * Token Chiuso tra parantesi. Token tipo assegnato in accorodo con token flag
 * dell'operando
 *)
 function TScan.stdscan_handle_brace(var tv: TTokenVal): Int16;
(************************************************************)
begin
    if (tv.t_flag and TFLAG_BRC_ANY) = 0 then
    begin
        (* invalid token is put inside braces *)
        nasm_errore(ERR_NONFATAL, Format('%s is not a valid decorator with braces', [tv.t_charptr]) );
        tv.t_type := TOKEN_INVALID;
    end
    else if (tv.t_flag and TFLAG_BRC_OPT) =  TFLAG_BRC_OPT then
    begin
        if (is_reg_class(OPMASKREG, tv.t_integer)) then
            (* within braces, opmask register is now used as a mask *)
            tv.t_type := TOKEN_OPMASK;
    end;
    Result := tv.t_type;
end;

// Funzione principale ritorna il token attuale
function TScan.stdscan(var tv: TTokenVal): Integer;
(*************************************************)
var
   ourcopy    : array [0..MAX_KEYWORD ] of AnsiChar;
   r, s       : PAnsiChar;

   token_type,
   Token_Len  : Integer;

   rn_error: Boolean;
   is_hex  : Boolean;
   is_float: Boolean;
   has_e   : Boolean;
   c       : AnsiChar;

begin
    FStdscan_bufptr := nasm_skip_spaces(FStdscan_bufptr);
    s :=  FStdscan_bufptr;
    if s = ''then
    begin
        tv.t_type := TOKEN_EOS;
        Result    :=  tv.t_type;
        Exit;
    end;
    (* we have a token; either an id, a number or a char *)
    if (isidstart(FStdscan_bufptr^)) then
    begin
        // per label
        if (FStdscan_bufptr^ = '@') then
        begin
            Inc(FStdscan_bufptr);
        end;

        r := FStdscan_bufptr;
        Inc(FStdscan_bufptr);
        (* read the entire buffer to advance the buffer pointer but... *)
        while (isidchar(FStdscan_bufptr^)) do
            Inc(FStdscan_bufptr);

        (* ... copy only up to IDLEN_MAX-1 characters *)
        if (FStdscan_bufptr - r) < IDLEN_MAX then
           tv.t_charptr := stdscan_copy(r, FStdscan_bufptr - r)
        else
           tv.t_charptr := stdscan_copy(r, IDLEN_MAX - 1) ;

        if ( NativeUInt(FStdscan_bufptr) - NativeUInt(r) > MAX_KEYWORD)  then
        begin
            tv.t_type := TOKEN_ID;       (* bypass all other checks *)
            Result    :=  tv.t_type;
            Exit;
        end;

        s := tv.t_charptr;
        r := @ourcopy[0] ;
        repeat
              if s^ = #0  then Break;
              r^ := nasm_tolower(s^) ;
              inc(r);
              inc(s);
        until False;

        r^ := #0;

        (* right, so we have an identifier sitting in temp storage. now,
         * is it actually a register or instruction name, or what? *)
        token_type := nasm_token_hash(ourcopy, tv);

        if (tv.t_flag and TFLAG_BRC) <> TFLAG_BRC then
        begin
            (* most of the tokens fall into this case *)
            Result :=  token_type;
            Exit;
        end else
        begin
            tv.t_type := TOKEN_ID;
            Result    := tv.t_type;
            Exit;
        end;
    end
    else if isnumstart(FStdscan_bufptr^) then   (* now we've got a number *)
    begin
        is_hex   := false;
        is_float := false;
        has_e    := false;

        r := FStdscan_bufptr;

        if (FStdscan_bufptr^ = '$') then
        begin
            Inc(FStdscan_bufptr);
            is_hex := true;
        end;

        repeat
            c := FStdscan_bufptr^;
            Inc(FStdscan_bufptr);

            if ( not is_hex and ( (c = 'e') or (c = 'E'))) then
            begin
                has_e := true;
                if (FStdscan_bufptr^ = '+') or (FStdscan_bufptr^ = '-') then
                begin
                    (*
                     * e can only be followed by +/- if it is either a
                     * prefixed hex number or a floating-point number
                     *)
                    is_float := true;
                    inc(FStdscan_bufptr);
                end;
            end
            else if (c = 'H') or (c = 'h') or (c = 'X') or (c = 'x') then
                is_hex := true
            else if (c = 'P') or (c = 'p') then
            begin
                is_float := true;
                if (FStdscan_bufptr^ = '+') or (FStdscan_bufptr^ = '-') then
                    inc(FStdscan_bufptr);
            end
            else if (isnumchar(c)) or (c = '_') then
                 (* just advance *)
            else if (c = '.') then
                is_float := true
            else
                break;
        until False ;
        dec(FStdscan_bufptr);       (* Point to first character beyond number *)

        if (has_e) and (not is_hex) then
            (* 1e13 is floating-point, but 1e13h is not *)
            is_float := true;

        if (is_float) then
        begin
            tv.t_charptr := stdscan_copy(r, FStdscan_bufptr - r);
            tv.t_type := TOKEN_FLOAT;
            Result    :=  tv.t_type;
            Exit;
        end  else
        begin
            r := stdscan_copy(r, FStdscan_bufptr - r);

            tv.t_integer := readnum(r, rn_error);
            if (rn_error) then
            begin
                (* some malformation occurred *)
                tv.t_type := TOKEN_ERRNUM;
                Result    :=  tv.t_type;
                Exit;
            end;
            tv.t_charptr := nil;
            tv.t_type    := TOKEN_NUM;
            Result       :=  tv.t_type;
            Exit;
        end;
    end
    else if  FStdscan_bufptr^ = '{' then
    begin
        (* now we've got a decorator *)
        FStdscan_bufptr := nasm_skip_spaces(FStdscan_bufptr);

        inc(FStdscan_bufptr);
        r := FStdscan_bufptr;
        (*
         * read the entire buffer to advance the buffer pointer
         * {rn-sae}, {rd-sae}, {ru-sae}, {rz-sae} contain '-' in tokens.
         *)
        while (isbrcchar( FStdscan_bufptr^)) do
            inc(FStdscan_bufptr);

        token_len := NativeUInt(FStdscan_bufptr) - NativeUInt(r);

        (* ... copy only up to DECOLEN_MAX-1 characters *)
        tv.t_charptr := stdscan_copy(r, IfThen(token_len < DECOLEN_MAX,token_len, DECOLEN_MAX - 1));

        FStdscan_bufptr := nasm_skip_spaces(FStdscan_bufptr);
        (* if brace is not closed properly or token is too long  *)
        if ( FStdscan_bufptr^ <> '}') or (token_len > MAX_KEYWORD) then
        begin
            nasm_errore(ERR_NONFATAL, 'invalid decorator token inside braces');
            tv.t_type  := TOKEN_INVALID ;
            Result     := tv.t_type;
            Exit;
        end;

        inc(FStdscan_bufptr);       (* skip closing brace *)

        s := tv.t_charptr;
        r := @ourcopy[0] ;
        repeat
              if s^ = #0  then Break;
              r^ := nasm_tolower(s^) ;
              inc(r);
              inc(s);
        until False;

        r^ := #0;

        (* right, so we have a decorator sitting in temp storage. *)
        nasm_token_hash(ourcopy, tv);

        (* handle tokens inside braces *)
        Result := stdscan_handle_brace(tv);
        Exit;
    end
    else if (FStdscan_bufptr^ = ';') then
    begin
        (* a comment has happened - stay *)
        tv.t_type := TOKEN_EOS;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '>') and(FStdscan_bufptr[1] = '>') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_SHR;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '<') and (FStdscan_bufptr[1] = '<') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_SHL;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '/') and (FStdscan_bufptr[1] = '/') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_SDIV;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '%') and (FStdscan_bufptr[1] = '%') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_SMOD;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '=') and (FStdscan_bufptr[1] = '=') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_EQ;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '<') and (FStdscan_bufptr[1] = '>') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_NE;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '!') and (FStdscan_bufptr[1] = '=') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_NE;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '<') and (FStdscan_bufptr[1] = '=') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_LE;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '>') and (FStdscan_bufptr[1] = '=') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_GE;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '&') and (FStdscan_bufptr[1] = '&') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_DBL_AND;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '^') and (FStdscan_bufptr[1] = '^') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_DBL_XOR;
        Result := tv.t_type;
        Exit;
    end
    else if (FStdscan_bufptr^ = '|') and (FStdscan_bufptr[1] = '|') then
    begin
        Inc(FStdscan_bufptr,2);
        tv.t_type := TOKEN_DBL_OR;
        Result := tv.t_type;
        Exit;
    end else
    begin                      (* just an ordinary char *)
        tv.t_type := Byte(FStdscan_bufptr^);
        inc(FStdscan_bufptr);
        Result := tv.t_type;
        Exit;
    end;
end;


end.
