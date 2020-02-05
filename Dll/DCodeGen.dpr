library DCodeGen;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  CodeGen,
  Nasm_Def,
  System.SysUtils,
  System.Classes;

{$R *.res}


function Compile(is64Bit : Boolean; Address : Int64; sCmd: PAnsiChar; var pOutBuff: PByte; var Len: Cardinal): Boolean;  stdcall;
var
 CG     : TCodeGen;
 bits   : Byte;
 buffer : TOutCmdB;
begin
    Result := False;
    // default 32 bit
    bits := 32;
    if is64Bit then bits := 64;

    CG := TCodeGen.Create(bits,MASM_SYNTAX);
    try
      CG.Pi_Asm(Address,sCmd) ;
      Buffer := CG.Encode;

      if Length(buffer) > 0 then
      begin
          pOutBuff := @buffer[0];
          Len      := Length(buffer);
          Result   := True;
      end ;
    finally
      CG.Free;
    end;

end;

exports Compile;

begin
end.
