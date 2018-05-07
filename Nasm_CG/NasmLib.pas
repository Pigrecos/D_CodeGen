unit NasmLib;

interface
    uses
      System.Win.Crtl,
      System.SysUtils,
      Windows,
      Nasm_Def;

const
     (*
     * These are the error severity codes which get passed as the first
     * argument to an efunc.
     *)

      ERR_DEBUG     = $00000008;      (* put out debugging message *)
      ERR_WARNING   = $00000000;      (* warn only: no further action *)
      ERR_NONFATAL  = $00000001;      (* terminate assembly after phase *)
      ERR_FATAL     = $00000002;      (* instantly fatal: exit with error *)
      ERR_PANIC     = $00000003;      (* internal error: panic instantly
                                       * and dump core for reference *)
      ERR_MASK      = $0000000F;      (* mask off the above codes *)
      ERR_NOFILE    = $00000010;      (* don't give source file name/line *)
      ERR_USAGE     = $00000020;      (* print a usage message *)
      ERR_PASS1     = $00000040;      (* only print this error on pass one *)
      ERR_PASS2     = $00000080;
      ERR_NO_SEVERIT= $00000100;      (* suppress printing severity *)

      ERR_WARN_TERM          = 0;     (* treat warnings as errors *)
      ERR_WARN_MNP           = $1000; (* macro-num-parameters warning *)
      ERR_WARN_MSR           = $2000; (* macro self-reference *)
      ERR_WARN_MDP           = $3000; (* macro default parameters check *)
      ERR_WARN_OL            = $4000; (* orphan label (no colon, and
                                                * alone on line) *)
      ERR_WARN_NOV           = $5000; (* numeric overflow *)
      ERR_WARN_GNUELF        = $6000; (* using GNU ELF extensions *)
      ERR_WARN_FL_OVERFLOW   = $7000; (* FP overflow *)
      ERR_WARN_FL_DENORM     = $8000; (* FP denormal *)
      ERR_WARN_FL_UNDERFLOW  = $9000; (* FP underflow *)
      ERR_WARN_FL_TOOLONG    = $A000; (* FP too many digits *)
      ERR_WARN_USER          = $B000; (* %warning directives *)
      ERR_WARN_LOCK		       = $C000; (* bad LOCK prefixes *)
      ERR_WARN_HLE		       = $D000; (* bad HLE prefixes *)
      ERR_WARN_BND		       = $E000; (* bad BND prefixes *)
      ERR_WARN_MAX           = 14;    (* the highest numbered one *)

      function nasm_isspace(x:  AnsiChar ): Boolean;
      function nasm_isalpha(x:  AnsiChar ): Boolean;
      function nasm_isdigit(x:  AnsiChar ): Boolean;
      function nasm_isalnum(x:  AnsiChar ): Boolean;
      function nasm_isxdigit(x: AnsiChar ): Boolean;

      function lib_isnumchar(c : AnsiChar): Boolean;

      (*
       * isidstart matches any character that may start an identifier, and isidchar
       * matches any character that may appear at places other than the start of an
       * identifier. E.g. a period may only appear at the start of an identifier
       * (for local labels), whereas a number may appear anywhere *but* at the
       * start.
       * isbrcchar matches any character that may placed inside curly braces as a
       * decorator. E.g. {rn-sae}, {1to8}, {k1}{z}
       *)
      function isidstart(c: AnsiChar) : Boolean;
      function isidchar (c: AnsiChar ): Boolean;
      function isbrcchar(c: AnsiChar ): Boolean;

      (* Ditto for numeric constants. *)
      function isnumstart(c: AnsiChar): Boolean;
      function isnumchar (c: AnsiChar ):Boolean ;
      function numvalue  (c: AnsiChar) :Byte;

      function  nasm_skip_spaces(p: pAnsiChar): PAnsiChar;
      function  nasm_tolower    (x: AnsiChar ): AnsiChar;

      procedure nasm_Errore(Severity : Integer; strMsg : string);

      procedure nasm_free(q : Pointer);
      function  nasm_malloc(size: size_t): Pointer;
      function  nasm_realloc(q : Pointer; size: size_t): Pointer;

      function readnum(str: PAnsiChar; var error: Boolean): Int64;

      function IfThen(b:boolean;v1:integer;v2:integer):integer;

      function prefix_name(token: Integer): string;


    var
     nasm_tolower_tab : array[0..255] of Byte;

implementation

function IfThen(b:boolean;v1:integer;v2:integer):integer;
begin
    if   b then result := v1
    else        result := v2;
end;


(*
 * Common list of prefix names
 *)
const prefix_names : array[0..18] of PChar = (
    'a16', 'a32', 'a64', 'asp', 'lock', 'o16', 'o32', 'o64', 'osp',
    'rep', 'repe', 'repne', 'repnz', 'repz', 'times', 'wait',
    'xacquire', 'xrelease', 'bnd');

function prefix_name(token: Integer): string;
var
   prefix : Cardinal;
begin
    prefix := token - PREFIX_ENUM_START;
    if (prefix > High(prefix_names)) then
        Result := ''
    else
        Result := prefix_names[prefix];
end;

(*
 * tolower table -- avoids a function call on some platforms.
 * NOTE: unlike the tolower() function in ctype, EOF is *NOT*
 * a permitted value, for obvious reasons.
 *)
procedure tolower_init;
var
  i : Integer;
begin
    for i := 0 to 255 do
	    nasm_tolower_tab[i] := tolower(i);
end;

function nasm_isspace(x: AnsiChar ): Boolean;
begin
    Result := isspace(Byte(x)) <> 0
end;

function nasm_isalpha(x: AnsiChar ): Boolean;
begin
    Result := isalpha(byte(x)) <> 0
end;

function nasm_isdigit(x: AnsiChar ): Boolean;
begin
    Result := isdigit(byte(x))  <> 0
end;

function nasm_isalnum(x: AnsiChar ): Boolean;
begin
    Result := isalnum(byte(x))  <> 0
end;

function nasm_isxdigit(x: AnsiChar ): Boolean;
begin
    Result := isxdigit(byte(x)) <> 0
end;

function lib_isnumchar(c : AnsiChar): Boolean;
begin
     Result := nasm_isalnum(c) or (c = '$') or (c = '_');
end;

function isidstart(c: AnsiChar): Boolean;
begin
    Result := nasm_isalpha(c) or (c = '_') or (c = '.') or (c = '?') or (c = '@')
end;

function isidchar(c: AnsiChar ): Boolean;
begin
    Result := isidstart(c) or (nasm_isdigit(c) ) or (c = '$') or (c = '#') or (c = '~')
end;

function isbrcchar(c: AnsiChar ): Boolean;
begin
    Result := isidchar(c) or (c = '-')
end;

function isnumstart(c: AnsiChar): Boolean;
begin
    Result := nasm_isdigit(c) or (c = '$')
end;

function isnumchar(c: AnsiChar ): Boolean ;
begin
    Result := nasm_isalnum(c) or (c = '_')
end;

(* This returns the numeric value of a given 'digit'. *)
function numvalue(c: AnsiChar): Byte;
begin
     if Ord(c) >= Ord('a') then Result := Ord(c) - Ord('a') + 10
     else
         if Ord(c) >= Ord('A') then Result := Ord(c) - Ord('A') + 10
         else                       Result := Ord(c) - Ord('0') ;
end;

(* skip leading spaces *)
function nasm_skip_spaces(p : PAnsiChar): PAnsiChar;
begin
     while (p^ <> '') and  (nasm_isspace(p^) ) do inc(p);
     Result := p;
end ;

function nasm_tolower(x: AnsiChar ): AnsiChar;
begin
     Result := AnsiChar (nasm_tolower_tab[ Byte(x) ] )
end;

procedure nasm_Errore(Severity : Integer; strMsg : string);
begin
     //MessageBoxW(0,PChar(strMsg),'Info Errore',MB_OK) ;
end;

procedure nasm_free(q : Pointer);
begin
     if q <> nil then
        free(q);
end;

function nasm_malloc(size: size_t): Pointer;
var
  p : Pointer;
begin
     p := malloc(size);
     if p = nil  then nasm_Errore(ERR_FATAL or ERR_NOFILE, 'out of memory');

     Result := p;
end;

function nasm_realloc(q : Pointer; size: size_t): Pointer;
var
  p : Pointer;
begin
     if q = nil then p := malloc(size)
     else            p := realloc(q, size) ;

     if p = nil then nasm_errore(ERR_FATAL or ERR_NOFILE, 'out of memory');

     Result := p;
end;

function radix_letter(c: AnsiChar): Integer;
begin
    case c of
     'b','B',
     'y','Y': Result := 2;		(* Binary *)
     'o','O',
     'q','Q': Result := 8;		(* Octal *)
     'h','H',
     'x','X': Result := 16;		(* Hexadecimal *)
     'd','D',
     't','T': Result := 10;		(* Decimal *)
    else
	   Result := 0;		(* Not a known radix letter *)
    end;
end;

function readnum(str: PAnsiChar; var error: Boolean): Int64;
var
   r, q                  : PAnsiChar;
   pradix, sradix, radix : Int32;
   plen, slen, len       : Integer;
   res, checklimit       : Int64;
   digit, last           : Integer;
   warn                  : Boolean;
   sign                  : Integer;

begin
    r   := str;
    warn := false;
    sign := 1;
    error:= false;

    while (nasm_isspace(r^)) do  (* find start of number *)
        Inc(r);

    (*
     * If the number came from make_tok_num (as a result of an %assign), it
     * might have a '-' built into it (rather than in a preceeding token).
     *)
    if (r^ = '-') then
    begin
        Inc(r);
        sign := -1;
    end;

    q := r;

    while lib_isnumchar(q^) do  (* find end of number *)
        Inc(q);

    len := NativeUInt(q)- NativeUInt(r);
    if len = 0 then
    begin
	       (* Not numeric *)
	       error := true;
	       Result := 0;
         Exit;
    end;

    (*
     * Handle radix formats:
     *
     * 0<radix-letter><string>
     * $<string>		(hexadecimal)
     * <string><radix-letter>
     *)
    slen   := 0;
    plen   := slen;

    pradix := radix_letter(r[1]);
    if (len > 2) and (r^ = '0') and (pradix <> 0) then
	    plen := 2
    else if (len > 1) and (r^ = '$') then
    begin
	       pradix := 16;
         plen   := 1;
    end;

    sradix := radix_letter(q[-1]) ;
    if (len > 1) and ( sradix <> 0) then
	    slen := 1;

    if (pradix > sradix) then
    begin
	       radix := pradix;
	       Inc(r,plen);
    end
    else if (sradix > pradix) then
    begin
	      radix := sradix;
	      Dec(q,slen);
    end else
    begin
	      (* Either decimal, or invalid -- if invalid, we'll trip up
	         further down. *)
	      radix := 10;
    end;

    (*
     * `checklimit' must be 2**64 / radix. We can't do that in
     * 64-bit arithmetic, which we're (probably) using, so we
     * cheat: since we know that all radices we use are even, we
     * can divide 2**63 by radix/2 instead.
     *)
    checklimit := UInt64($8000000000000000) div (radix shr 1);

    (*
     * Calculate the highest allowable value for the last digit of a
     * 64-bit constant... in radix 10, it is 6, otherwise it is 0
     *)
    if radix = 10 then  last := 6
    else                last := 0;

    res := 0;
    while (r <> nil) and (NativeUInt(r) < NativeUInt(q)) do
    begin
        if (r^ <> '_') then
        begin
            digit := numvalue(r^);
            if ( Ord(r^) < Ord('0') ) or ((Ord(r^) > Ord('9')) and (Ord(r^) < Ord('A'))) or (digit >= radix) then
            begin
                 error := true;
                 Result:=0;
                 Exit;
            end;
            if  (res > checklimit) or ( (res = checklimit) and  (digit >= last) ) then
            begin
               warn := true;
            end;

            res := radix * res + digit;
        end;
        Inc(r);
    end;

    if (warn) then
        nasm_errore(ERR_WARNING or ERR_PASS1 or ERR_WARN_NOV, Format('numeric constant %s does not fit in 64 bits',[str]));

    Result := res * sign;
end;

initialization

    tolower_init;

end.
