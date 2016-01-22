//
// *************************************************************************** //
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
// *************************************************************************** //
//
//
// *************************************************************************** //
// UDisasm library.
//
// Questo file è un completamento per univDisAsm.
//
// https://github.com/MahdiSafsafi/UnivDisasm
//
// The Initial Developer of the Original Code is Mahdi Safsafi.
// Portions created by Mahdi Safsafi . are Copyright (C) 2015 Mahdi Safsafi.
// All Rights Reserved.
// *************************************************************************** //
//

unit uDisAsm;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Math,
  System.Diagnostics,
  System.Generics.Collections,
  System.StrUtils,
  WinApi.Windows,
  WinApi.Messages,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Dialogs,

  UnivDisasm.Disasm,
  UnivDisasm.Cnsts,
  UnivDisasm.Cnsts.Instructions,
  UnivDisasm.SyntaxManager,
  UnivDisasm.Syntax.UnivSyntax;

type
  TInsData = record
    ins  : TInstruction;
    VAddr: PByte;
    nsize: ShortInt;
  end;
  TList___DisAsm = TList<TInsData>;

  TDisAsm = class
  private
       FBinType : Integer;
       FNT      : Pointer;
       FInsData : TInsData;
       FAddr    : PByte;
       FVAddr   : PByte;
       FMpFile  : PByte;
       FhFile   : THandle;
       FoFile   : THandle;
       FOpened  : Boolean;
       FSyntax  : ShortInt;
       FSyntaxOp: ShortInt;

       FInstsCount: Integer;
       FItems: TList<TInsData>;
       procedure Open(const AFile: AnsiString);
       procedure Close;
       function  ReadMemoryB(hProcess : Thandle;address: UInt64): byte;
       function RvaToOffset(Rva: UInt64): UInt64;
       function VaToFileOffset(dwVA: UInt64): UInt64;
       function FileOffsetToRva(dwFileOffset: UInt64): UInt64;
       function FileOffsetToVa(dwFileOffset: UInt64): UInt64;
  public
       constructor Create; overload;
       constructor Create(const sFile: AnsiString);overload;
       destructor  Destroy;override;
       procedure lstAsmClear;
       procedure lstAsmItemDelete(nItem: Integer);
       procedure lstAsmAdd;
       procedure lstAsmAddData(InstD: TInsData);
       procedure DisAssembleVA(VA_Addr: UInt64);
       procedure DisAssemble(FileOffset: UInt64); overload;
       procedure DisAssemble(const hProc: THandle ;VA_Addr: UInt64;is64bitProc:Boolean = False); overload;
       procedure DisAssemble(const pBuff: PByte;is64bitBin:Boolean = False; VA_Addr: UInt64 = 0);overload;

       property  ListDisAsm  : TList<TInsData>  Read  FItems;
       property  InstsCount  : Integer          read  FInstsCount;
       property  InsData     : TInsData         Read  FInsData;
       property  Syntax      : ShortInt         read  FSyntax    write FSyntax;
       property  SyntaxOption: ShortInt         read  FSyntaxOp  write FSyntaxOp;
       property  BinType     : Integer          read  FBinType;
  end;

implementation

{ TDisAssembler }

function IsMemDec(const A: String): Boolean;
  const
    MemDecArray: array [0 .. 7] of String = ( //
      'byte', 'word', 'dword', 'qword', //
      'fword', 'oword', 'yword', 'zword');
  var
    i: Integer;
begin
    Result := False;
    for i := 0 to Length(MemDecArray) - 1 do
    begin
      if SameText(A, MemDecArray[i]) then
        Exit(True);
    end;
end;


function IsSeg(const A: String): Boolean;
  const
    SegArray: array [0 .. 5] of String = ( //
      'cs', { 00 }
      'ds', { 01 }
      'ss', { 02 }
      'es', { 03 }
      'fs', { 04 }
      'gs' { 05 } );
  var
    i: Integer;
 begin
    Result := False;
    for i := 0 to Length(SegArray) - 1 do
    begin
      if SameText(A, SegArray[i]) then
        Exit(True);
    end;
 end;


function IsNumeric(const A: String): Boolean;
  var
    Value: Int64;
begin
    Result := TryStrToInt64(Trim(A), Value);
end;


function TDisAsm.RvaToOffset(Rva: UInt64): UInt64;
var
  i      : Word;
  Img    : PImageSectionHeader;
  Offset,
  Limit  : UInt64;
  numSec   : Word;
begin
    Result := 0;
    Offset := Rva;
    Img    := PImageSectionHeader(FNT);

    if FBinType = CPUX32 then
        Inc(PImageNtHeaders32(Img))
    else
        Inc(PImageNtHeaders64(Img)) ;

    if (Rva < Img.PointerToRawData) then
    begin
        Result := Rva;
        Exit;
    end;

    i := 0;
    if FBinType = CPUX32 then
         numSec := PImageNtHeaders32(FNT)^.FileHeader.NumberOfSections
    else
         numSec := PImageNtHeaders64(FNT)^.FileHeader.NumberOfSections ;

    while i < numSec do
    begin
        if (Img.SizeOfRawData <> 0) then
        begin
            Limit := Img.SizeOfRawData;
        end
        else
            Limit := Img.Misc.VirtualSize;
        if (Rva >= Img.VirtualAddress) and (Rva < (Img.VirtualAddress + Limit)) then
        begin
            if (Img.PointerToRawData <> 0) then
            begin
                Dec(Offset, Img.VirtualAddress);
                Inc(Offset, Img.PointerToRawData);
            end;
            Result := Offset;
            Break;
        end;
        Inc(Img);
        Inc(i);
    end;
end;


function TDisAsm.VaToFileOffset(dwVA: UInt64): UInt64;
(*******************************************************************************)
begin
     if FBinType = CPUX32 then
     begin
          if (dwVA > PImageNtHeaders32(FNT)^.OptionalHeader.ImageBase) then
              Result := RvaToOffset(dwVA - PImageNtHeaders32(FNT)^.OptionalHeader.ImageBase)
          else Result := 0;
     end else
     begin
          if (dwVA > DWord(PImageNtHeaders64(FNT)^.OptionalHeader.ImageBase)) then
              Result := RvaToOffset(dwVA - PImageNtHeaders64(FNT)^.OptionalHeader.ImageBase)
          else Result := 0;
     end

end;


function TDisAsm.FileOffsetToRva(dwFileOffset: UInt64): UInt64;
(*******************************************************************************)
var
  x      : Word;
  Img    : PImageSectionHeader;
  numSec : Word;
begin
    Result := 0;
    Img    := PImageSectionHeader(FNT);
    x      := 0;

    if FBinType = CPUX32 then
         numSec := PImageNtHeaders32(FNT)^.FileHeader.NumberOfSections
    else
         numSec := PImageNtHeaders64(FNT)^.FileHeader.NumberOfSections ;

    while x < numSec do
    begin
        if ((dwFileOffset >= Img.PointerToRawData) and (dwFileOffset < Img.PointerToRawData + Img.SizeOfRawData)) then
        begin
            Result := dwFileOffset - Img.PointerToRawData + Img.VirtualAddress;
            Break;
        end;
        Inc(Img);
        Inc(x);
    end;
end;


function TDisAsm.FileOffsetToVa(dwFileOffset: UInt64): UInt64;
(*******************************************************************************)
begin
     if FBinType = CPUX32 then
         Result := FileOffsetToRva(dwFileOffset) + PImageNtHeaders32(FNT)^.OptionalHeader.ImageBase
     else
         Result := FileOffsetToRva(dwFileOffset) + PImageNtHeaders64(FNT)^.OptionalHeader.ImageBase
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Legge un byte dall'indirizzo di memoria specificato
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
function TDisAsm.ReadMemoryB(hProcess : THandle;address: UInt64): byte;
(*******************************************************************************)
var
  a        : byte;
  ret      : boolean;
  BufCnt   : NativeUInt;

begin

  ret:= ReadProcessMemory(
                hProcess,                // HANDLE hProcess,	              // handle del processo da cui leggere
                Pointer(Address),        // LPVOID lpBaseAddress,	          // Indirizzo da cui inizare la lettura
                @a,                      // LPVOID lpBuffer,	              // pointer al buffer che riceve i dati
                1,                       // DWORD nSize,        	          // numero di byte da leggere
                BufCnt);                 // LPDWORD lpNumberOfBytesWritten 	// numero di byte letti effettivamente

  if not ret then SysErrorMessage(GetLastError());
  Result:= a;
end;


constructor TDisAsm.Create;
begin
     FBinType    := CPUX32;
     FSyntax     := SX_UNIV_SYNTAX;
     FSyntaxOp   := USO_SHOW_MEM_SIZE ;//or USO_ZERO_PADDING or USO_SHOW_DISP8; //USO_DEFAULT;
     FInstsCount := 0;
     FNT         := nil;
     FItems      := TList<TInsData>.Create();
     FOpened     := False;
     FInstsCount := 0;
end;

constructor TDisAsm.Create(const sFile: AnsiString);
begin
     FBinType    := CPUX32;
     FSyntax     := SX_UNIV_SYNTAX;
     FSyntaxOp   := USO_SHOW_MEM_SIZE ;//or USO_ZERO_PADDING or USO_SHOW_DISP8;;//USO_DEFAULT;
     FInstsCount := 0;
     FNT         := nil;
     FItems      := TList<TInsData>.Create();
     FOpened     := False;
     FInstsCount := 0;

     Open(sFile);
end;

destructor TDisAsm.Destroy;
begin
    if FOpened then Close;
    FItems.Clear;
    FItems.Destroy;
end;


procedure TDisAsm.lstAsmClear;
begin
    FItems.Clear;
    FInstsCount := 0;
end;


procedure TDisAsm.lstAsmItemDelete(nItem: Integer);
begin
     FItems.Delete(nItem);
     Dec(FInstsCount);
end;


procedure TDisAsm.lstAsmAdd;
begin
     FItems.Add(FInsData);
     Inc(FInstsCount);
end;


procedure TDisAsm.lstAsmAddData(InstD: TInsData);
begin
     FItems.Add(InstD);
     Inc(FInstsCount);
end;

procedure TDisAsm.DisAssembleVA(VA_Addr: UInt64);
var
  fOffset: UInt64;
  P      : PByte;
  ins    : TInstruction;
  sz     : Integer;
begin

     fOffset := VaToFileOffset(VA_Addr);

     FAddr  := (FMpFile + fOffset);
     FVAddr := PByte(VA_Addr);

     P := FAddr;

     ins               := default (TInstruction);
     ins.Syntax        := FSyntax;
     ins.SyntaxOptions := FSyntaxOp;
     ins.Arch          := FBinType;
     ins.VirtualAddr   := FVAddr;
     ins.Addr          := P;
     try
       sz := Disasm(@ins);
     except
       raise Exception.Create('Errore Durante DisAsm. Errore num.° '+ IntToHex(ins.Errors,8));
     end;

     FInsData.ins   := ins;
     FInsData.nsize := sz;
     FInsData.VAddr := FVAddr ;
end;


procedure TDisAsm.DisAssemble(FileOffset: UInt64);
var
 P   : PByte;
 ins : TInstruction;
 sz  : Integer;
begin

     FAddr  := (FMpFile + FileOffset);
     FVAddr := PByte(FileOffsetToVa(FileOffset));

     P := FAddr;

     ins               := default (TInstruction);
     ins.Syntax        := FSyntax;
     ins.SyntaxOptions := FSyntaxOp;
     ins.Arch          := FBinType;
     ins.VirtualAddr   := FVAddr;
     ins.Addr          := P;
     try
       sz := Disasm(@ins);
     except
       raise Exception.Create('Errore Durante DisAsm. Errore num.° '+ IntToHex(ins.Errors,8));
     end;

     FInsData.ins   := ins;
     FInsData.nsize := sz;
     FInsData.VAddr := FVAddr ;
end;


procedure TDisAsm.DisAssemble(const hProc: THandle ;VA_Addr: UInt64;is64bitProc:Boolean = False);
var
  i          : Byte;
  buffer     : Array[0..15] of byte;
  OldProtect : DWORD;
  MemInfo    : MEMORY_BASIC_INFORMATION;
  P          : PByte;
  ins        : TInstruction;
  sz         : Integer;
begin
     VirtualQueryEx(hProc, Pointer(VA_Addr), MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
     OldProtect := MemInfo.AllocationProtect;
     VirtualProtectEx(hProc, Pointer(VA_Addr), 20, PAGE_EXECUTE_READWRITE, OldProtect);

     if is64bitProc then FBinType := CPUX64
     else                FBinType := CPUX32 ;

     for i:= 0 to 15 do
     begin
          buffer[i]:= ReadMemoryB(hProc,VA_Addr+i);
     end;

     P := @buffer[0];

     ins               := default (TInstruction);
     ins.Syntax        := FSyntax;
     ins.SyntaxOptions := FSyntaxOp;
     ins.Arch          := FBinType;
     ins.VirtualAddr   := Pbyte(VA_Addr);
     ins.Addr          := P;

     try
       sz := Disasm(@ins);
     except
       raise Exception.Create('Errore Durante DisAsm. Errore num.° '+ IntToHex(ins.Errors,8));
     end;

     FInsData.ins   := ins;
     FInsData.nsize := sz;
     FInsData.VAddr := Pbyte(VA_Addr) ;
end;

Procedure TDisAsm.DisAssemble(const pBuff: PByte;is64bitBin:Boolean = False; VA_Addr: UInt64 = 0);
var
  ins        : TInstruction;
  sz         : Integer;
begin
     if is64bitBin then FBinType := CPUX64
     else               FBinType := CPUX32 ;

     ins               := default (TInstruction);
     ins.Syntax        := FSyntax;
     ins.SyntaxOptions := FSyntaxOp;
     ins.Arch          := FBinType;
     if VA_Addr <> 0 then
        ins.VirtualAddr   := Pbyte(VA_Addr);
     ins.Addr          := pBuff;

     try
       sz := Disasm(@ins);
     except
       raise Exception.Create('Errore Durante DisAsm. Errore num.° '+ IntToHex(ins.Errors,8));
     end;

     FInsData.ins   := ins;
     FInsData.nsize := sz;
     if VA_Addr <> 0 then
       FInsData.VAddr :=Pbyte(VA_Addr)
     else
       FInsData.VAddr := pBuff ;
end;


procedure TDisAsm.Open(const AFile: AnsiString);
var
  PDosHeader: PImageDosHeader;
  PNtHeader : Pointer;//PImageNtHeaders;
  BinType   : DWORD;

begin
    if FOpened then Close;

    FOpened := True;


    GetBinaryTypeA(PAnsiChar(AFile), BinType);

    if BinType = SCS_64BIT_BINARY then  FBinType := CPUX64
    else                                FBinType := CPUX32;

    FhFile     := CreateFileA(PAnsiChar(AFile), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    FoFile     := CreateFileMappingA(FhFile, nil, PAGE_READONLY, 0, 0, nil);
    FMpFile    := MapViewOfFile(FoFile, FILE_MAP_READ, 0, 0, 0);
    PDosHeader := PImageDosHeader(FMpFile);

    if PDosHeader.e_magic <> IMAGE_DOS_SIGNATURE then  Exit;

    if BinType = CPUX32 then
    begin
       PNtHeader := PImageNtHeaders32(UInt64(PDosHeader) + PDosHeader._lfanew) ;
       if PImageNtHeaders32(PNtHeader).Signature <> IMAGE_NT_SIGNATURE then Exit;
    end
    else begin
       PNtHeader := PImageNtHeaders64(UInt64(PDosHeader) + PDosHeader._lfanew);
       if PImageNtHeaders64(PNtHeader).Signature <> IMAGE_NT_SIGNATURE then Exit;
    end;


    FNT := PNtHeader;
end;

procedure TDisAsm.Close;
begin
    if FOpened then
    begin
        FOpened := False;
        FItems.Clear;
        UnMapViewOfFile(FMpFile);
        CloseHandle(FoFile);
        CloseHandle(FhFile);
    end;
end;

procedure AggiornaIstrStr(PInst: PInstruction);
begin
     SyntaxManager.SyntaxDecoderArray[PInst.InternalData.SyntaxID](PInst);
end;

end.
