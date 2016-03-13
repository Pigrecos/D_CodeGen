unit Labels;

interface
    uses
       System.SysUtils,
       windows,
       System.AnsiStrings;

const
    (* values for label.defn.is_global *)
    DEFINED_BIT   =  1;
    GLOBAL_BIT    =  2;
    EXTERN_BIT    =  4;
    COMMON_BIT    =  8;

    NOT_DEFINED_YET    =  0;
    TYPE_MASK          =  3;
    LOCAL_SYMBOL       =  (DEFINED_BIT);
    GLOBAL_PLACEHOLDER =  (GLOBAL_BIT);
    GLOBAL_SYMBOL      =  (DEFINED_BIT or GLOBAL_BIT);



type
 TLog  = Reference to procedure(Severity : Integer; strMsg : string);

 PLabel = ^TLabel;
 TLabel = record        (* actual label structures *)
    segment  : Int32;
    offset   : UInt64;
    llabel   : PAnsiChar;
    is_global: Int32;
 end;


   TLab = class
     private
       FInitialized : Boolean;
       Flabels : array of TLabel;
       FErrore    : Integer ;           (* <> 0 indica che si è generato un errorre*)
       FOnLogMsg  : TLog;

       procedure DoLogMsg(Severity : Integer; strMsg : string);
       function find_label(llabel: PAnsiChar; Create: Boolean): PLabel;

     public
       constructor Create;
       destructor Destroy;override;
       procedure define_label  (llabel: PAnsiChar; segment: int32; offset: UInt64);
       procedure redefine_label(llabel: PAnsiChar; segment: int32; offset: UInt64);
       function  lookup_label(llabel: PAnsiChar; var segment: Int32; var offset: UInt64): Boolean;

       property OnMsgLog  : TLog     read FOnLogMsg     write FOnLogMsg;
       property Errore    : Integer     read FErrore;
   end;


implementation
     uses
        Nasm_Def,
        NasmLib;

constructor TLab.Create;
begin
     FInitialized :=  True;
     SetLength(Flabels,0);
     FErrore := 0;
end;

destructor TLab.Destroy;
begin
     FInitialized :=  False;
     SetLength(Flabels,0);
end;

procedure TLab.DoLogMsg(Severity : Integer; strMsg : string);
(*******************************************************************************)
begin
    FErrore := 1;
    if Assigned(FOnLogMsg) then  FOnLogMsg(Severity,'[LABEL] - '+ strMsg);
end;
(*
 * Internal routine: finds the `union label' corresponding to the
 * given label name. Creates a new one, if it isn't found, and if
 * `create' is true.
 *)
function TLab.find_label(llabel: PAnsiChar; Create: Boolean): PLabel;
var
 i : Integer;
begin
     Result := nil;
     for i := 0 to High(Flabels) do
     begin
          if AnsiSameText(String(llabel),String(Flabels[i].llabel))  then
          begin
              Result := @Flabels[i];
              Break;
          end;
     end;

     if (Result <> nil) or (Create = False)then Exit;

     (* Create a new label... *)
     SetLength(Flabels,Length(Flabels)+1);
     Flabels[High(Flabels)].llabel := llabel;
     Flabels[High(Flabels)].is_global := NOT_DEFINED_YET;

     Result := @Flabels[High(Flabels)];
end;

function TLab.lookup_label(llabel: PAnsiChar; var segment: Int32; var offset: UInt64): Boolean;
var
  lptr : PLabel;
begin
    if not FInitialized then
    begin
         Exit(False)
    end;

    lptr := find_label(llabel, False);

    if (lptr <> nil ) and ((lptr^.is_global and DEFINED_BIT) = DEFINED_BIT) then
    begin
        segment := lptr^.segment;
        offset  := lptr^.offset;
        Exit(True);
    end;

    Result := False;
end;

procedure TLab.redefine_label(llabel: PAnsiChar;segment: int32;offset: UInt64);
var
  lptr : PLabel;
begin
    lptr := find_label(llabel, True);

    if (lptr = nil ) then
        DoLogMsg(ERR_PANIC, Format('can''t find label `%s on pass two', [llabel]));

    if (lptr.offset <> offset)then
        Inc(Global_offset_changed);

    lptr^.offset  := offset;
    lptr^.segment := segment;
end;

procedure TLab.define_label(llabel: PAnsiChar;segment: int32;offset: UInt64);
var
  lptr : PLabel;
begin
    lptr := find_label(llabel, True);

    if (lptr = nil ) then Exit;

    if (lptr.is_global and DEFINED_BIT) = DEFINED_BIT then
    begin
        DoLogMsg(ERR_PANIC, Format('symbol `%s redefined', [llabel]));
        Exit;
    end;

    lptr^.is_global := lptr^.is_global or DEFINED_BIT;

    lptr^.offset  := offset;
    lptr^.segment := segment;
end;

end.
