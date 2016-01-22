{
  Pe File Unit
  Original by ErazerZ

  ***Modificato  By Max 2012
  -------------------
  -------------------
  **Supporto x86/64
  **Funzioni/Procedure
  ===Generali===
  * LoadFromFile
  * SaveToFile
  * MapFile
  * UnMapFile
  * IsValidPe
  * Is64Bit
  * Is32Bit
  * IsFileDll
  * LoadFromProcess
  * DumpFromProcess
  * DumpMemory
  * DumpModule
  * PastePeHeader
  * RelocaterMakeSnapshot
  * RelocaterCompareTwoSnapshots
  ===Varie===
  * FindCodeCaves
  * Find
  ===Varie Read/Write===
  * InsertBytes
  * DeleteBytes
  * ReadByte
  * WriteByte
  * WriteMemory
  * ReadMemory
  * CopyMemoryToBuffer
  * CopyMemoryFromBuffer
  ===Get Proprietà Pe==
  * GetCharacteristics
  * GetCodeSection
  * GetDataSection
  * GetPE32Data
  ===Modifiche Proprietà Pe==
  * SetPE32Data
  * SetAddressOfEntryPoint
  * SetImageBase
  ===Sezioni===
  * AddSection
  * DeleteSection
  * DumpSection
  * SectionToString
  * StringToSection
  ===Coversioni===
  * RvaToFileOffset
  * FileOffsetToRva
  * VaToFileOffset
  * FileOffsetToVa
  * VaToRva
  * RvaToVa
  * RvaToSection
  * VaToSection
  * FileOffsetToSection
  ===PE Directory===
  * GetResourceSection
  * GetImportAddressTable
  * GetExportsAddressTable
  * GetThreadLocalStorage
  * GetResources
  * GetDebugDirectory
  * GetLoadConfigDirectory
  * GetEntryExceptionDirectory
  ----------------------------------
  ----------------------------------

}
unit untPeFile;

interface

uses Winapi.Windows,System.SysUtils;


type TPeDati = Byte;
     const
        PED_PE_OFFSET              = 0;
        PED_IMAGEBASE              = 1;
        PED_OEP                    = 2;
        PED_SIZEOFIMAGE            = 3;
        PED_SIZEOFHEADERS          = 4;
        PED_SIZEOFOPTIONALHEADER   = 5;
        PED_SECTIONALIGNMENT       = 6;
        PED_IMPORTTABLEADDRESS     = 7;
        PED_IMPORTTABLESIZE        = 8;
        PED_RESOURCETABLEADDRESS   = 9;
        PED_RESOURCETABLESIZE      = 10;
        PED_EXPORTTABLEADDRESS     = 11;
        PED_EXPORTTABLESIZE        = 12;
        PED_TLSTABLEADDRESS        = 13;
        PED_TLSTABLESIZE           = 14;
        PED_RELOCATIONTABLEADDRESS = 15;
        PED_RELOCATIONTABLESIZE    = 16;
        PED_TIMEDATESTAMP          = 17;
        PED_SECTIONNUMBER          = 18;
        PED_CHECKSUM               = 19;
        PED_SUBSYSTEM              = 20;
        PED_CHARACTERISTICS        = 21;
        PED_NUMBEROFRVAANDSIZES    = 22;
        PED_SECTIONNAME            = 23;
        PED_SECTIONVIRTUALOFFSET   = 24;
        PED_SECTIONVIRTUALSIZE     = 25;
        PED_SECTIONRAWOFFSET       = 26;
        PED_SECTIONRAWSIZE         = 27;
        PED_SECTIONFLAGS           = 28;

type
  PCodeCave = ^TCodeCave;
  TCodeCave = packed record
    StartFileOffset: Cardinal;
    StartRVA       : Cardinal;
    CaveSize       : Cardinal;
  end;

const
  // PE header constants
  CENEWHDR = $003C;  // offset of new EXE header
  CEMAGIC  = $5A4D;  // old EXE magic id:  'MZ'
  CPEMAGIC = $4550;  // NT portable executable
  IMAGE_NT_OPTIONAL_HDR32_MAGIC = $10b;  // 32bit PE file
  IMAGE_NT_OPTIONAL_HDR64_MAGIC = $20b;  // 64bit PE file

type
  // PE header types

  { IAT }
  PImportsAPis = ^TImportsAPIs;
  TImportsAPIs = packed record
    ThunkRVA   : ULONGLONG;
    ThunkOffset: ULONGLONG;
    ThunkValue : ULONGLONG;
    Hint       : Word;
    ApiName    : string;
  end;

  PImports = ^TImports;
  TImports = packed record
    LibraryName       : string;
    OriginalFirstThunk: DWORD;
    TimeDateStamp     : DWORD;
    ForwarderChain    : DWORD;
    Name              : DWORD; // Offset
    FirstThunk        : DWORD;
    IatFunctions      : array of TImportsAPIs;
  end;
  PImportsArray = ^TImportsArray;
  TImportsArray = array of TImports;

  {Export Table}
  PExportAPIs = ^TExportAPIs;
  TExportAPIs = packed record
    Ordinal   : Word;
    Rva       : DWORD;
    FileOffset: DWORD;
    ApiName   : string;
  end;

  PExports = ^TExports;
  TExports = packed record
    LibraryName          : string;
    Base                 : DWORD;
    Characteristics      : DWORD;
    TimeDateStamp        : DWORD;
    MajorVersion         : Word;
    MinorVersion         : Word;
    NumberOfFunctions    : DWORD;
    NumberOfNames        : DWORD;
    AddressOfFunctions   : DWORD;
    AddressOfNames       : DWORD;
    AddressOfNameOrdinals: Word;
    ExportFunctions      : array of TExportAPIs;
  end;

  { RESOURCES }
  { Dir Entry }
  PImageResourceDirectoryEntry = ^TImageResourceDirectoryEntry;
  TImageResourceDirectoryEntry = packed record
    Name        : DWORD;
    OffsetToData: DWORD;
  end;
  { Data Entry }
  PImageResourceDataEntry = ^TImageResourceDataEntry;
  TImageResourceDataEntry = packed record
    OffsetToData: DWORD;
    Size        : DWORD;
    CodePage    : DWORD;
    Reserved    : DWORD;
  end;
  { Directory }
  PImageResourceDirectory = ^TImageResourceDirectory;
  TImageResourceDirectory = packed record
    Characteristics     : DWORD;
    TimeDateStamp       : DWORD;
    MajorVersion        : Word;
    MinorVersion        : Word;
    NumberOfNamedEntries: Word;
    NumberOfIdEntries   : Word;
  end;

  TResourceEntries = packed record
    sName    : string;
    sLang    : string;
    dwDataRVA: DWORD;
    lpData   : Pointer;
    dwSize   : DWORD;
  end;
  TResourceTyps = packed record
    sTyp       : string;
    NameEntries: array of TResourceEntries;
  end;
  TResources = packed record
    Dir    : TImageResourceDirectory;
    Entries: array of TResourceTyps;
  end;

  TPeFile = class(TObject)
  private

    lpBuffer : Pointer;
    FFileSize: NativeUInt;
    FFilename: string;
    // NtHeaders
    FNumberOfSections   : Word;
    FAddressOfEntryPoint: Cardinal;
    FImageBase          : NativeUInt;
    FSectionAlign       : Cardinal;
    FFileAlign          : Cardinal;
    procedure getDosAndNtHeader;
    function  ReadPeHeadersFromProcess(const hProcess: THandle): Boolean;
    function  removeIatDirectory: Boolean;
    function  ReadPeHeaders: Boolean;
    procedure WriteImageSectionHeader;
    function  Align(Value, Align: Cardinal): Cardinal;
    function  GetSectionHeaderBasedFileSize: DWORD;
    function  GetSectionHeaderBasedSizeOfImage: DWORD;
    function  GetDataFromEOF(var lpData: Pointer; var dwLength: Cardinal): Boolean;

  public
    pDosHeader   : PImageDosHeader;
    pNTHeaders32 : PImageNtHeaders32;
    pNTHeaders64 : PImageNtHeaders64;
    ImageSections: array of TImageSectionHeader;
    constructor Create;
    destructor Destroy; override;
    // General
    function   LoadFromFile(const sFilename: string): Boolean;
    function   SaveToFile(const sFilename: string; bNewFile : Boolean = True): Boolean;
    procedure  MapFile(var FileHandle,FileMapVA: NativeUInt);
    procedure  UnMapFile(FileHandle, FileMapVA: NativeUInt);
    function   IsValidPe: Boolean;
    function   Is64Bit: Boolean;
    function   Is32Bit: Boolean;
    function   IsFileDll: Boolean;
    function   LoadFromProcess(const hProcess: THandle; sFileName: string; dwImageBase, dwSizeImage: NativeUInt): Boolean;
    function   DumpFromProcess(const hProcess: THandle; sFileName: string;dwImageBase,dwEntryPoint:NativeUInt): Boolean;
    function   DumpMemory(const hProcess: THandle; sFileName: string;MemoryStart,MemorySize:NativeUInt): Boolean;
    function   DumpModule(const hProcess: THandle; sFileName: string;ModuleBase,ModuleSize:NativeUInt): Boolean;
    function   PastePeHeader(const hProcess: THandle; dwImageBase:NativeUInt ;sFileName: string): Boolean;
    // Relocate
    function   RelocaterMakeSnapshot(hProcess:THandle; szSaveFileName:string; MemoryStart,MemorySize:LongInt):boolean;
    function   RelocaterCompareTwoSnapshots(hProcess:THandle; LoadedImageBase,NtSizeOfImage:LongInt; szDumpFile1,szDumpFile2:string; MemStart:LongInt):boolean;
    // Section
    function   AddSection(const sSectionName: string; RawSize: Cardinal; lpData: Pointer; dwDataLength: Cardinal; dwCharacteristics: Cardinal = IMAGE_SCN_MEM_WRITE or IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_EXECUTE or IMAGE_SCN_CNT_CODE): Boolean;
    function   DeleteSection(wSection: Word): Boolean;
    function   DumpSection(wSection: Word; sFilename: string): Boolean;
    function   SectionToString(Section: TImageSectionHeader): string;
    procedure  StringToSection(const sSectionName: string; var Section: TImageSectionHeader);
    // Modifiche
    function  SetPE32Data(const nSezione, tDatiPe: TPeDati; NewVal : UInt64;var strNameSec: string):Boolean;
    procedure SetAddressOfEntryPoint(AddressOfEntryPoint: Cardinal);
    procedure SetImageBase(ImageBase: NativeUInt);
    //Get
    function GetCharacteristics(dwCharacteristics: DWORD): string;
    function GetCodeSection: Word;
    function GetDataSection: Word;
    function GetPE32Data(const nSezione, tDatiPe: TPeDati; var strNameSec: string): UInt64;
    // Varie
    function  FindCodeCaves(FromOffset, Count: Cardinal): TCodeCave;
    function  Find(dwVAStart, MemorySize: DWORD; SearchPattern: array of Byte; PatternSize: DWORD; WildCard: Byte = 0): Cardinal;
    // Varie Read/Write
    function  InsertBytes(FromOffset, Count: Cardinal): Cardinal;
    function  DeleteBytes(FromOffset, Count: Cardinal): Cardinal;
    function  ReadByte(dwVAStart : DWORD): Byte;
    procedure WriteByte(dwVAStart : DWORD; bValue : Byte);
    function  WriteMemory(dwVAStart : DWORD; pBuffer : Pointer; byteCount: Integer): Boolean;
    function  ReadMemory(dwVAStart : DWORD; pBuffer : Pointer; byteCount: Integer):Boolean;
    procedure CopyMemoryToBuffer(CopyToOffset: DWORD; Source: Pointer; Length: DWORD);
    procedure CopyMemoryFromBuffer(CopyFromOffset: DWORD; Destination: Pointer; Length: DWORD);
    // Conversioni
    function  RvaToFileOffset(dwRVA: Cardinal): Cardinal;
    function  FileOffsetToRva(dwFileOffset: Cardinal): Cardinal;
    function  VaToFileOffset(dwVA: Cardinal): Cardinal;
    function  FileOffsetToVa(dwFileOffset: NativeUInt): NativeUInt;
    function  VaToRva(dwVA: Cardinal): Cardinal;
    function  RvaToVa(dwRVA: Cardinal): Cardinal;
    function  RvaToSection(dwRVA: Cardinal): Word;
    function  VaToSection(dwVA: Cardinal): Word;
    function  FileOffsetToSection(dwFileOffset: Cardinal): Word;
    // Directory
    function  GetResourceSection: Word;
    procedure GetImportAddressTable(var Imports: TImportsArray);
    function  GetExportsAddressTable(var ExportData: TExports): DWORD;
    function  GetThreadLocalStorage: Pointer;
    procedure GetResources(var Resources: TResources);
    function  GetDebugDirectory: PImageDebugDirectory;
    function  GetLoadConfigDirectory: PImageLoadConfigDirectory;
    function  GetEntryExceptionDirectory: PImageRuntimeFunctionEntry;

    function RecalcImageSize: DWORD;
    function CalcCheckSum: DWORD;
    function RecalcCheckSum: DWORD;
    function ResizeSection(wSection: Word; Count: Cardinal): Boolean;

  public

    property FileSize           : NativeUInt read FFileSize;
    property Filename           : string     read FFilename;
    // NtHeaders
    property NumberOfSections   : Word       read FNumberOfSections;
    property AddressOfEntryPoint: Cardinal   read FAddressOfEntryPoint write SetAddressOfEntryPoint;
    property ImageBase          : NativeUInt read FImageBase write SetImageBase;
    property SectionAlign       : Cardinal   read FSectionAlign;
    property FileAlign          : Cardinal   read FFileAlign;

  protected

  end;

var

  ResourceTypeDefaultNames: array[0..20] of record
    ResType    : PChar;
    ResTypeName: string;
  end = (
    (ResType: RT_ACCELERATOR; ResTypeName: 'Accelerator'; ),
    (ResType: RT_ANICURSOR;   ResTypeName: 'Animated Cursor'; ),
    (ResType: RT_ANIICON;     ResTypeName: 'Animated Icon'; ),
    (ResType: RT_BITMAP;      ResTypeName: 'Bitmap'; ),
    (ResType: RT_CURSOR;      ResTypeName: 'Cursor'; ),
    (ResType: RT_DIALOG;      ResTypeName: 'Dialog'; ),
    (ResType: RT_DLGINCLUDE;  ResTypeName: 'Dialog Include'; ),
    (ResType: RT_FONT;        ResTypeName: 'Font'; ),
    (ResType: RT_FONTDIR;     ResTypeName: 'Font Directory'; ),
    (ResType: RT_GROUP_CURSOR;ResTypeName: 'Group Cursor'; ),
    (ResType: RT_GROUP_ICON;  ResTypeName: 'Group Icon'; ),
    (ResType: RT_HTML;        ResTypeName: 'Html'; ),
    (ResType: RT_ICON;        ResTypeName: 'Icon'; ),
    (ResType: RT_MANIFEST;    ResTypeName: 'Manifest'; ),
    (ResType: RT_MENU;        ResTypeName: 'Menu'; ),
    (ResType: RT_MESSAGETABLE;ResTypeName: 'Messagetable'; ),
    (ResType: RT_PLUGPLAY;    ResTypeName: 'Plugplay'; ),
    (ResType: RT_RCDATA;      ResTypeName: 'RC Data'; ),
    (ResType: RT_STRING;      ResTypeName: 'String'; ),
    (ResType: RT_VERSION;     ResTypeName: 'Version'; ),
    (ResType: RT_VXD;         ResTypeName: 'VXD'; )
    );

implementation

constructor TPeFile.Create;
(*******************************************************************************)
begin
  inherited;
end;

destructor TPeFile.Destroy;
(*******************************************************************************)
begin
    if (lpBuffer <> nil) then
      FreeMem(lpBuffer, FFileSize);
    inherited;
end;

function TPeFile.Align(Value, Align: Cardinal): Cardinal;
(*******************************************************************************)
begin
    if ((Value mod Align) = 0) then
      Result := Value
    else
      Result := ((Value + Align - 1) div Align) * Align;
end;

function TPeFile.SectionToString(Section: TImageSectionHeader): string;
(*******************************************************************************)
var
  x: Word;
begin
    Result := '';
    for x := 0 to IMAGE_SIZEOF_SHORT_NAME -1 do
      if (Section.Name[x] <> 0) then
        Result := Result + Chr(Section.Name[x]);
end;

procedure TPeFile.StringToSection(const sSectionName: string; var Section: TImageSectionHeader);
(*******************************************************************************)
var
  x: Word;
begin
    FillChar(Section.Name, SizeOf(Section.Name), #0);
    if (Length(sSectionName) = 0) then Exit;
    for x := 0 to Length(sSectionName) -1 do
      if (x < IMAGE_SIZEOF_SHORT_NAME) then
        Section.Name[x] := Ord(sSectionName[x +1]);
end;

function TPeFile.IsFileDll: Boolean;
(*******************************************************************************)
var
 s1 : string;
begin
     Result := (GetPE32Data(0,PED_CHARACTERISTICS,s1) and $2000) <>  0;
end;

function TPeFile.Is64Bit: Boolean;
(*******************************************************************************)
begin
     Result := pNtHeaders32^.OptionalHeader.Magic = IMAGE_NT_OPTIONAL_HDR64_MAGIC;
end;

function TPeFile.Is32Bit: Boolean;
(*******************************************************************************)
begin
     Result := pNtHeaders32^.OptionalHeader.Magic = IMAGE_NT_OPTIONAL_HDR32_MAGIC
end;

function TPeFile.IsValidPe:Boolean;
(*******************************************************************************)
begin
     Result := False;
     if pDosHeader <> nil then
     if (pDosHeader^.e_magic = IMAGE_DOS_SIGNATURE) then
       if pNtHeaders32 <> nil then
          if (pNtHeaders32^.Signature = IMAGE_NT_SIGNATURE) then
              Result := True;
end;

procedure TPeFile.getDosAndNtHeader;
(*******************************************************************************)
begin
	   pDosHeader   := PImageDosHeader(NativeUInt(lpBuffer));

     pNtHeaders32 := PImageNtHeaders32(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew));
     pNTHeaders64 := PImageNtHeaders64(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew));
end;

function TPeFile.ReadPeHeaders: Boolean;
(*******************************************************************************)
var
  x: Word;
begin
     Result := False;
     getDosAndNtHeader;
     if IsValidPe then
     begin
          FNumberOfSections    := pNtHeaders32^.FileHeader.NumberOfSections;
          if Is32Bit  then
          begin
              FAddressOfEntryPoint := pNtHeaders32^.OptionalHeader.AddressOfEntryPoint;
              FImageBase           := pNtHeaders32^.OptionalHeader.ImageBase;
              FFileAlign           := pNtHeaders32^.OptionalHeader.FileAlignment;
              FSectionAlign        := pNtHeaders32^.OptionalHeader.SectionAlignment;
          end else
          begin
              FAddressOfEntryPoint := pNtHeaders64^.OptionalHeader.AddressOfEntryPoint;
              FImageBase           := pNtHeaders64^.OptionalHeader.ImageBase;
              FFileAlign           := pNtHeaders64^.OptionalHeader.FileAlignment;
              FSectionAlign        := pNtHeaders64^.OptionalHeader.SectionAlignment;
          end;

          SetLength(ImageSections, NumberOfSections);
          for x := Low(ImageSections) to High(ImageSections) do
          begin
               if Is32Bit then
                   CopyMemory(@ImageSections[x],
                   Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders32) + (x * SizeOf(TImageSectionHeader))),
                   SizeOf(TImageSectionHeader))
               else
                  CopyMemory(@ImageSections[x],
                  Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders64) + (x * SizeOf(TImageSectionHeader))),
                  SizeOf(TImageSectionHeader))
          end;
          Result := True;
     end;
end;

Function TPeFile.GetPE32Data(const nSezione, tDatiPe: TPeDati; var strNameSec: string): UInt64;
(*******************************************************************************)
begin

     Result     := 0;
     strNameSec := '';
     if Is32Bit then
     begin
         if(tDatiPe < PED_SECTIONNAME) then
         begin
              case tDatiPe of
                PED_PE_OFFSET           : Result   := pDosHeader._lfanew;
                PED_IMAGEBASE           : Result   := pNtHeaders32^.OptionalHeader.ImageBase;
                PED_OEP                 : Result   := pNtHeaders32^.OptionalHeader.AddressOfEntryPoint;
                PED_SIZEOFIMAGE         : Result   := pNtHeaders32^.OptionalHeader.SizeOfImage;
                PED_SIZEOFHEADERS       : Result   := pNtHeaders32^.OptionalHeader.SizeOfHeaders;
                PED_SIZEOFOPTIONALHEADER: Result   := pNtHeaders32^.FileHeader.SizeOfOptionalHeader;
                PED_SECTIONALIGNMENT    : Result   := pNtHeaders32^.OptionalHeader.SectionAlignment;
                PED_IMPORTTABLEADDRESS  : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
                PED_IMPORTTABLESIZE     : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size;
                PED_RESOURCETABLEADDRESS: Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
                PED_RESOURCETABLESIZE   : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size;
                PED_EXPORTTABLEADDRESS  : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;
                PED_EXPORTTABLESIZE     : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size;
                PED_TLSTABLEADDRESS     : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress;
                PED_TLSTABLESIZE        : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size;
                PED_RELOCATIONTABLEADDRESS: Result := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress;
                PED_RELOCATIONTABLESIZE : Result   := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size;
                PED_TIMEDATESTAMP       : Result   := pNtHeaders32^.FileHeader.TimeDateStamp;
                PED_SECTIONNUMBER       : Result   := pNtHeaders32^.FileHeader.NumberOfSections;
                PED_CHECKSUM            : Result   := pNtHeaders32^.OptionalHeader.CheckSum;
                PED_SUBSYSTEM           : Result   := pNtHeaders32^.OptionalHeader.Subsystem;
                PED_CHARACTERISTICS     : Result   := pNtHeaders32^.FileHeader.Characteristics;
                PED_NUMBEROFRVAANDSIZES : Result   := pNtHeaders32^.OptionalHeader.NumberOfRvaAndSizes;
              else
                Result := 0;
              end;
         end
         else begin
              if(FNumberOfSections >= nSezione) then
              begin
                   case tDatiPe of
                     PED_SECTIONNAME         : strNameSec := SectionToString(ImageSections[nSezione]);
                     PED_SECTIONVIRTUALOFFSET: Result     := ImageSections[nSezione].VirtualAddress;
                     PED_SECTIONVIRTUALSIZE  : Result     := ImageSections[nSezione].Misc.VirtualSize;
                     PED_SECTIONRAWOFFSET    : Result     := ImageSections[nSezione].PointerToRawData;
                     PED_SECTIONRAWSIZE      : Result     := ImageSections[nSezione].SizeOfRawData;
                     PED_SECTIONFLAGS        : Result     := ImageSections[nSezione].Characteristics;
                   else
                     Result := 0;
                   end;
              end;
         end;
     end else
     begin
         if(tDatiPe < PED_SECTIONNAME) then
         begin
              case tDatiPe of
                PED_PE_OFFSET           : Result   := pDosHeader._lfanew;
                PED_IMAGEBASE           : Result   := pNtHeaders64^.OptionalHeader.ImageBase;
                PED_OEP                 : Result   := pNtHeaders64^.OptionalHeader.AddressOfEntryPoint;
                PED_SIZEOFIMAGE         : Result   := pNtHeaders64^.OptionalHeader.SizeOfImage;
                PED_SIZEOFHEADERS       : Result   := pNtHeaders64^.OptionalHeader.SizeOfHeaders;
                PED_SIZEOFOPTIONALHEADER: Result   := pNtHeaders64^.FileHeader.SizeOfOptionalHeader;
                PED_SECTIONALIGNMENT    : Result   := pNtHeaders64^.OptionalHeader.SectionAlignment;
                PED_IMPORTTABLEADDRESS  : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
                PED_IMPORTTABLESIZE     : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size;
                PED_RESOURCETABLEADDRESS: Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
                PED_RESOURCETABLESIZE   : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size;
                PED_EXPORTTABLEADDRESS  : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;
                PED_EXPORTTABLESIZE     : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size;
                PED_TLSTABLEADDRESS     : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress;
                PED_TLSTABLESIZE        : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size;
                PED_RELOCATIONTABLEADDRESS: Result := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress;
                PED_RELOCATIONTABLESIZE : Result   := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size;
                PED_TIMEDATESTAMP       : Result   := pNtHeaders64^.FileHeader.TimeDateStamp;
                PED_SECTIONNUMBER       : Result   := pNtHeaders64^.FileHeader.NumberOfSections;
                PED_CHECKSUM            : Result   := pNtHeaders64^.OptionalHeader.CheckSum;
                PED_SUBSYSTEM           : Result   := pNtHeaders64^.OptionalHeader.Subsystem;
                PED_CHARACTERISTICS     : Result   := pNtHeaders64^.FileHeader.Characteristics;
                PED_NUMBEROFRVAANDSIZES : Result   := pNtHeaders64^.OptionalHeader.NumberOfRvaAndSizes;
              else
                Result := 0;
              end;
         end
         else begin
              if(FNumberOfSections >= nSezione) then
              begin
                   case tDatiPe of
                     PED_SECTIONNAME         : strNameSec := SectionToString(ImageSections[nSezione]);
                     PED_SECTIONVIRTUALOFFSET: Result     := ImageSections[nSezione].VirtualAddress;
                     PED_SECTIONVIRTUALSIZE  : Result     := ImageSections[nSezione].Misc.VirtualSize;
                     PED_SECTIONRAWOFFSET    : Result     := ImageSections[nSezione].PointerToRawData;
                     PED_SECTIONRAWSIZE      : Result     := ImageSections[nSezione].SizeOfRawData;
                     PED_SECTIONFLAGS        : Result     := ImageSections[nSezione].Characteristics;
                   else
                     Result := 0;
                   end;
              end;
         end;
     end;
end;

function TPeFile.SetPE32Data(const nSezione, tDatiPe: TPeDati; NewVal : UInt64;var strNameSec: string):Boolean;
(*******************************************************************************)
begin
     Result := True;
     strNameSec := '';
     if Is32Bit then
     begin
         if(tDatiPe < PED_SECTIONNAME) then
         begin
              case tDatiPe of
                PED_PE_OFFSET           : pDosHeader._lfanew                               := DWORD(NewVal);
                PED_IMAGEBASE           : pNtHeaders32^.OptionalHeader.ImageBase           := DWORD(NewVal);
                PED_OEP                 : pNtHeaders32^.OptionalHeader.AddressOfEntryPoint := DWORD(NewVal);
                PED_SIZEOFIMAGE         : pNtHeaders32^.OptionalHeader.SizeOfImage         := DWORD(NewVal);
                PED_SIZEOFHEADERS       : pNtHeaders32^.OptionalHeader.SizeOfHeaders       := DWORD(NewVal);
                PED_SIZEOFOPTIONALHEADER: pNtHeaders32^.FileHeader.SizeOfOptionalHeader    := Word(NewVal);
                PED_SECTIONALIGNMENT    : pNtHeaders32^.OptionalHeader.SectionAlignment    := DWORD(NewVal);
                PED_IMPORTTABLEADDRESS  : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress    := DWORD(NewVal);
                PED_IMPORTTABLESIZE     : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size              := DWORD(NewVal);
                PED_RESOURCETABLEADDRESS: pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress  := DWORD(NewVal) ;
                PED_RESOURCETABLESIZE   : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size            := DWORD(NewVal);
                PED_EXPORTTABLEADDRESS  : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress    := DWORD(NewVal);
                PED_EXPORTTABLESIZE     : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size              := DWORD(NewVal);
                PED_TLSTABLEADDRESS     : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress       := DWORD(NewVal);
                PED_TLSTABLESIZE        : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size                 := DWORD(NewVal);
                PED_RELOCATIONTABLEADDRESS: pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress:= DWORD(NewVal);
                PED_RELOCATIONTABLESIZE : pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size           := DWORD(NewVal);
                PED_TIMEDATESTAMP       : pNtHeaders32^.FileHeader.TimeDateStamp           := DWORD(NewVal);
                PED_SECTIONNUMBER       : pNtHeaders32^.FileHeader.NumberOfSections        := Word(NewVal);
                PED_CHECKSUM            : pNtHeaders32^.OptionalHeader.CheckSum            := DWORD(NewVal);
                PED_SUBSYSTEM           : pNtHeaders32^.OptionalHeader.Subsystem           := Word(NewVal);
                PED_CHARACTERISTICS     : pNtHeaders32^.FileHeader.Characteristics         := Word(NewVal);
                PED_NUMBEROFRVAANDSIZES : pNtHeaders32^.OptionalHeader.NumberOfRvaAndSizes := DWORD(NewVal);
              else
                Result := False;
              end;
         end
         else begin
              if(FNumberOfSections >= nSezione) then
              begin
                   case tDatiPe of
                     PED_SECTIONNAME         : StringToSection(strNameSec,ImageSections[nSezione]);
                     PED_SECTIONVIRTUALOFFSET: ImageSections[nSezione].VirtualAddress   := DWORD(NewVal);
                     PED_SECTIONVIRTUALSIZE  : ImageSections[nSezione].Misc.VirtualSize := DWORD(NewVal);
                     PED_SECTIONRAWOFFSET    : ImageSections[nSezione].PointerToRawData := DWORD(NewVal);
                     PED_SECTIONRAWSIZE      : ImageSections[nSezione].SizeOfRawData    := DWORD(NewVal);
                     PED_SECTIONFLAGS        : ImageSections[nSezione].Characteristics  := DWORD(NewVal);
                   else
                     Result := False;
                   end;
              end;
         end;
     end else
     begin
         if(tDatiPe < PED_SECTIONNAME) then
         begin
              case tDatiPe of
                PED_PE_OFFSET           : pDosHeader._lfanew                               := DWORD(NewVal);
                PED_IMAGEBASE           : pNtHeaders64^.OptionalHeader.ImageBase           := NewVal;
                PED_OEP                 : pNtHeaders64^.OptionalHeader.AddressOfEntryPoint := DWORD(NewVal);
                PED_SIZEOFIMAGE         : pNtHeaders64^.OptionalHeader.SizeOfImage         := DWORD(NewVal);
                PED_SIZEOFHEADERS       : pNtHeaders64^.OptionalHeader.SizeOfHeaders       := DWORD(NewVal);
                PED_SIZEOFOPTIONALHEADER: pNtHeaders64^.FileHeader.SizeOfOptionalHeader    := Word(NewVal);
                PED_SECTIONALIGNMENT    : pNtHeaders64^.OptionalHeader.SectionAlignment    := DWORD(NewVal);
                PED_IMPORTTABLEADDRESS  : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress     := DWORD(NewVal);
                PED_IMPORTTABLESIZE     : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size               := DWORD(NewVal);
                PED_RESOURCETABLEADDRESS: pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress   := DWORD(NewVal) ;
                PED_RESOURCETABLESIZE   : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size             := DWORD(NewVal) ;
                PED_EXPORTTABLEADDRESS  : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress     := DWORD(NewVal);
                PED_EXPORTTABLESIZE     : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size               := DWORD(NewVal);
                PED_TLSTABLEADDRESS     : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress        := DWORD(NewVal);
                PED_TLSTABLESIZE        : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size                  := DWORD(NewVal);
                PED_RELOCATIONTABLEADDRESS: pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress:= DWORD(NewVal);
                PED_RELOCATIONTABLESIZE : pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size            := DWORD(NewVal);
                PED_TIMEDATESTAMP       : pNtHeaders64^.FileHeader.TimeDateStamp           := DWORD(NewVal);
                PED_SECTIONNUMBER       : pNtHeaders64^.FileHeader.NumberOfSections        := Word(NewVal)  ;
                PED_CHECKSUM            : pNtHeaders64^.OptionalHeader.CheckSum            := DWORD(NewVal);
                PED_SUBSYSTEM           : pNtHeaders64^.OptionalHeader.Subsystem           := Word(NewVal);
                PED_CHARACTERISTICS     : pNtHeaders64^.FileHeader.Characteristics         := Word(NewVal);
                PED_NUMBEROFRVAANDSIZES : pNtHeaders64^.OptionalHeader.NumberOfRvaAndSizes := DWORD(NewVal);
              else
                Result := False;
              end;
         end
         else begin
              if(FNumberOfSections >= nSezione) then
              begin
                   case tDatiPe of
                     PED_SECTIONNAME         : StringToSection(strNameSec,ImageSections[nSezione]);
                     PED_SECTIONVIRTUALOFFSET: ImageSections[nSezione].VirtualAddress   := DWORD(NewVal);
                     PED_SECTIONVIRTUALSIZE  : ImageSections[nSezione].Misc.VirtualSize := DWORD(NewVal);
                     PED_SECTIONRAWOFFSET    : ImageSections[nSezione].PointerToRawData := DWORD(NewVal);
                     PED_SECTIONRAWSIZE      : ImageSections[nSezione].SizeOfRawData    := DWORD(NewVal);
                     PED_SECTIONFLAGS        : ImageSections[nSezione].Characteristics  := DWORD(NewVal);
                   else
                     Result := False;
                   end;
              end;
         end;
     end;
     if Result  then    ReadPeHeaders;

end;

function TPeFile.WriteMemory(dwVAStart : DWORD; pBuffer : Pointer; byteCount: Integer): Boolean;
(*******************************************************************************)
var
  i          : Integer;
  FileOffSet : DWORD;

begin
     Result := False;
     if byteCount < 1 then Exit;

     FileOffSet   := VaToFileOffset(dwVAStart);

     for i := 0 to byteCount -1 do
        pByte(NativeUInt(lpBuffer) + FileOffSet )[i] := PByte(pBuffer)[i] ;

     Result := True;
end;


function TPeFile.ReadMemory(dwVAStart : DWORD; pBuffer : Pointer; byteCount: Integer): Boolean;
(*******************************************************************************)
var
  i          : Integer;
  FileOffSet  : DWORD;
  pTmpBuffer  : PByte;
begin
     Result := False;
     if byteCount < 1 then Exit;

     FileOffSet   := VaToFileOffset(dwVAStart);
     pTmpBuffer   := pByte(NativeUInt(lpBuffer) + FileOffSet );

     for i := 0 to byteCount -1 do
        PByte(pBuffer)[i] :=  pTmpBuffer[i];
     Result := True;
end;

procedure TPeFile.WriteByte(dwVAStart : DWORD; bValue : Byte);
(*******************************************************************************)
var
  FileOffSet  : DWORD;

begin
     FileOffSet   := VaToFileOffset(dwVAStart);
     pByte(NativeUInt(lpBuffer) + FileOffSet )[0] := bValue;
end;

function TPeFile.ReadByte(dwVAStart : DWORD): Byte;
(*******************************************************************************)
var
  FileOffSet  : DWORD;
  pBuffer     : PByte;
begin
     FileOffSet   := VaToFileOffset(dwVAStart);
     pBuffer      := pByte(NativeUInt(lpBuffer) + FileOffSet );
     Result       := pBuffer[0];
end;

Function  TPeFile.Find(dwVAStart, MemorySize : DWORD; SearchPattern : Array of Byte;PatternSize: DWORD; WildCard: Byte= 0): Cardinal ;
(*******************************************************************************)
var
   i, j          : Integer;
   pCodeBuffer   : pByte;
   FileOffSet    : NativeUInt;
begin
      Result       := 0;
      FileOffSet   := VaToFileOffset(dwVAStart);

      pCodeBuffer := pByte(NativeUInt(lpBuffer) + FileOffSet );
      try
         if MemorySize >  FFileSize then MemorySize :=  FFileSize;

         for i := 0 To MemorySize -1 do
         begin
              if (NativeUInt(i)+FileOffSet) >= FFileSize then Break;

              for j := 0 To PatternSize -1 do
              begin
                   if(SearchPattern[j] <> WildCard) and (pCodeBuffer[i + j] <> SearchPattern[j]) then break;
              end;

              if j = Integer(PatternSize) then
              begin
                   Result := FileOffsetToVa(FileOffSet + NativeUInt(i));
                   break;
              end;
         end;
      except
         Result := 0;
      end;
end;

procedure TPeFile.WriteImageSectionHeader;
(*******************************************************************************)
var
  dwTemp: DWORD;
  x     : Word;
  bZeroAll: Boolean;
begin
    bZeroAll := True;

    if Is32Bit then
        dwTemp := pDosHeader._lfanew + SizeOf(TImageNtHeaders32) + (FNumberOfSections * SizeOf(TImageSectionHeader))
    else
        dwTemp := pDosHeader._lfanew + SizeOf(TImageNtHeaders64) + (FNumberOfSections * SizeOf(TImageSectionHeader));

    for x := 0 to IMAGE_NUMBEROF_DIRECTORY_ENTRIES -1 do
    begin
         if Is32Bit then
         begin
              if (pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress <> 0) then
              begin
                  if (pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress < pNtHeaders32^.OptionalHeader.SizeOfHeaders) then
                  begin
                      bZeroAll := False;
                      if (pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress > dwTemp) then
                      begin
                          dwTemp := pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress - dwTemp;
                          ZeroMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders32) + (FNumberOfSections * SizeOf(TImageSectionHeader))), dwTemp);
                      end else  bZeroAll := False;
                  end;
              end;
         end  else
         begin
              if (pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress <> 0) then
              begin
                  if (pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress < pNtHeaders64^.OptionalHeader.SizeOfHeaders) then
                  begin
                      bZeroAll := False;
                      if (pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress > dwTemp) then
                      begin
                          dwTemp := pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress - dwTemp;
                          ZeroMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders64) + (FNumberOfSections * SizeOf(TImageSectionHeader))), dwTemp);
                      end else  bZeroAll := False;
                  end;
              end;
         end;
    end;
    if (bZeroAll) then
    begin
        if Is32Bit then
        begin
            dwTemp := pDosHeader._lfanew + SizeOf(TImageNtHeaders32);
            ZeroMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders32)), ImageSections[Low(ImageSections)].PointerToRawData - dwTemp);
        end else
        begin
            dwTemp := pDosHeader._lfanew + SizeOf(TImageNtHeaders64);
            ZeroMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders64)), ImageSections[Low(ImageSections)].PointerToRawData - dwTemp);
        end;
    end;
    if Is32bit then
    begin
        ZeroMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders32)), FNumberOfSections * SizeOf(TImageSectionHeader));
        CopyMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders32)), ImageSections, FNumberOfSections * SizeOf(TImageSectionHeader));
    end else
    begin
        ZeroMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders64)), FNumberOfSections * SizeOf(TImageSectionHeader));
        CopyMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders64)), ImageSections, FNumberOfSections * SizeOf(TImageSectionHeader));
    end;

end;

procedure TPeFile.MapFile(var FileHandle, FileMapVA: NativeUInt);
(*******************************************************************************)
var
hFile,mfFileMap : NativeUInt;
mfFileMapVA     : Pointer;
begin
     hFile := CreateFile(PChar(FFilename), GENERIC_READ+GENERIC_WRITE, FILE_SHARE_READ,nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     if hFile <> INVALID_HANDLE_VALUE then
     begin
         FileHandle := hFile ;
         mfFileMap  := CreateFileMapping(hFile, nil,  PAGE_READWRITE, 0, FFileSize, nil);
         if mfFileMap <> 0 then
         begin
             mfFileMapVA := MapViewOfFile(mfFileMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);
             if mfFileMapVA <> nil then
                FileMapVA := NativeUInt(mfFileMapVA)
         end;
     end;
end;

procedure TPeFile.UnMapFile(FileHandle, FileMapVA: NativeUInt);
(*******************************************************************************)
begin
     UnmapViewOfFile(Pointer(FileMapVA));
     SetEndOfFile(FileHandle);
     CloseHandle(FileHandle);
end;

function TPeFile.DumpModule(const hProcess: THandle; sFileName: string;ModuleBase,ModuleSize:NativeUInt): Boolean;
(*******************************************************************************)
begin
     Result := DumpMemory(hProcess,sFileName,ModuleBase,ModuleSize);
end;

function TPeFile.DumpMemory(const hProcess: THandle; sFileName: string;MemoryStart,MemorySize:NativeUInt): Boolean;
(*******************************************************************************)
const
    DEFAULT_PAGESIZE  : NativeUInt = $1000;
var
  hFile          : THandle;
  dRead          : NativeUInt;
  dWritten       : DWORD;
  readBASE       : NativeUInt;
  MemInfo        : MEMORY_BASIC_INFORMATION;
  ueCopyBuffer   : Pointer;

begin
     Result       := False;
     ueCopyBuffer := GetMemory($2000);
     ReadBase     := MemoryStart;

     try
         hFile := CreateFile(PChar(sFileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, 0, 0);
         try
            if hFile <> INVALID_HANDLE_VALUE then
            begin
                 while(MemorySize > 0) do
                 begin

                      if(MemorySize >= DEFAULT_PAGESIZE)then
                      begin
                            ZeroMemory(ueCopyBuffer,$2000);
                            if( not ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead))then
                            begin
                                  VirtualQueryEx(hProcess, Pointer(ReadBase), MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, PAGE_EXECUTE_READWRITE, MemInfo.Protect);
                                  ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead);
                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, MemInfo.Protect, &MemInfo.Protect);
                            end;
                            WriteFile(hFile, ueCopyBuffer^,  DEFAULT_PAGESIZE, Cardinal(dWritten), nil);
                            MemorySize := MemorySize - DEFAULT_PAGESIZE;
                      end else
                      begin
                            ZeroMemory(ueCopyBuffer, $2000);
                            if( not ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, MemorySize, dRead)) then
                            begin
                                  VirtualQueryEx(hProcess, Pointer(ReadBase), &MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, PAGE_EXECUTE_READWRITE, &MemInfo.Protect);
                                  ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead);
                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, MemInfo.Protect, &MemInfo.Protect);
                            end;
                            WriteFile(hFile, ueCopyBuffer^, MemorySize, dWritten, nil);
                            MemorySize := 0;
                      end;
                      ReadBase := ReadBase + DEFAULT_PAGESIZE;
                 end;
                 Result := True;
            end;
         finally
            CloseHandle(hFile);
         end;
     finally
        FreeMem(ueCopyBuffer);
     end;
end;

function TPeFile.DumpFromProcess(const hProcess: THandle; sFileName: string;dwImageBase,dwEntryPoint:NativeUInt): Boolean;
(*******************************************************************************)
const
    DEFAULT_PAGESIZE  = $1000;
var
  i                   : Integer;
  hFile               : THandle;
  dRead               : NativeUInt;
  dWritten            : DWORD;
  DOSFixHeader        : PImageDosHeader;
  PEFixHeader32       : PImageNtHeaders32;
  PEFixHeader64       : PImageNtHeaders64;
  PEFixSection        : PImageSectionHeader;
  readBASE,
  CalcHeaderSize,
  AlignHeaderSize     : NativeUInt;
  MemInfo             : MEMORY_BASIC_INFORMATION;
  RealignedVirtualSize: DWORD;
  SizeOfImageDump     : DWORD;
  ueReadBuffer,
  ueCopyBuffer        : Pointer ;
begin

      Result       := False;
      FFilename    := sFilename;
      readBASE     := dwImageBase;
      ueReadBuffer := AllocMem($2000);
      ueCopyBuffer := AllocMem($2000);
      try
          if ReadProcessMemory(hProcess, Pointer(dwImageBase), ueReadBuffer, $1000, dRead) then
          begin

               pDosHeader   := PImageDosHeader(Pointer(NativeUInt(ueReadBuffer)));
               CalcHeaderSize := Cardinal(pDosHeader._lfanew) + SizeOf(TImageDosHeader) + SizeOf(TImageNtHeaders64);
               if(CalcHeaderSize > $1000)then
               begin
                    if(CalcHeaderSize mod $1000 = 0) then  AlignHeaderSize := $1000
                    else				                           AlignHeaderSize := ((CalcHeaderSize div $1000) + 1) * $1000;

                    ReallocMem(ueReadBuffer,AlignHeaderSize);
                    ReallocMem(ueCopyBuffer,AlignHeaderSize);
                    if not ReadProcessMemory(hProcess, Pointer(NativeUInt(dwImageBase)), ueReadBuffer, AlignHeaderSize, dRead) then Exit;
                    pDosHeader   := PImageDosHeader(Pointer(NativeUInt(ueReadBuffer)));
               end else
               begin
                    AlignHeaderSize := $1000
               end;

               pNtHeaders32 := PImageNtHeaders32(NativeUInt(pDosHeader) + Cardinal(pDosHeader^._lfanew));
               pNTHeaders64 := PImageNtHeaders64(NativeUInt(pDosHeader) + Cardinal(pDosHeader^._lfanew));

               if Is32Bit then
               begin
                   FNumberOfSections := pNtHeaders32^.FileHeader.NumberOfSections+1;

                   if(pNtHeaders32^.OptionalHeader.SizeOfImage mod pNtHeaders32^.OptionalHeader.SectionAlignment = 0) then
                      SizeOfImageDump := ((pNtHeaders32^.OptionalHeader.SizeOfImage div pNtHeaders32^.OptionalHeader.SectionAlignment)) * pNtHeaders32^.OptionalHeader.SectionAlignment
                   else
                      SizeOfImageDump := ((pNtHeaders32^.OptionalHeader.SizeOfImage div pNtHeaders32^.OptionalHeader.SectionAlignment) + 1) * pNtHeaders32^.OptionalHeader.SectionAlignment;
                   SizeOfImageDump := SizeOfImageDump - DWORD(AlignHeaderSize);

                   hFile := CreateFile(PChar(sFileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, 0, 0);
                   try
                       if hFile <> INVALID_HANDLE_VALUE then
                       begin
                            if ReadProcessMemory(hProcess, Pointer(dwImageBase), ueCopyBuffer, AlignHeaderSize, dRead) then
                            begin
                                 DOSFixHeader  := PImageDosHeader(NativeUInt(ueCopyBuffer));
                                 PEFixHeader32 := PImageNtHeaders32(NativeUInt(DOSFixHeader) + Cardinal(DOSFixHeader._lfanew));
                                 PEFixSection  := PImageSectionHeader(NativeUInt(PEFixHeader32) + pNtHeaders32^.FileHeader.SizeOfOptionalHeader + sizeof(IMAGE_FILE_HEADER) + 4);
                                 if(PEFixHeader32.OptionalHeader.FileAlignment > $200) then
                                    PEFixHeader32^.OptionalHeader.FileAlignment := pNtHeaders32^.OptionalHeader.SectionAlignment;
                                 PEFixHeader32^.OptionalHeader.AddressOfEntryPoint := DWORD(dwEntryPoint - dwImageBase);
                                 PEFixHeader32^.OptionalHeader.ImageBase           := DWORD(dwImageBase);
                                 i := FNumberOfSections;
                                 while(i >= 1) do
                                 begin
                                      PEFixSection^.PointerToRawData := PEFixSection.VirtualAddress;
                                      RealignedVirtualSize := (PEFixSection.Misc.VirtualSize div pNTHeaders32^.OptionalHeader.SectionAlignment) * pNTHeaders32^.OptionalHeader.SectionAlignment;
                                      if(RealignedVirtualSize < PEFixSection.Misc.VirtualSize) then
                                             RealignedVirtualSize := RealignedVirtualSize + pNTHeaders32^.OptionalHeader.SectionAlignment;

                                      PEFixSection^.SizeOfRawData    := RealignedVirtualSize;
                                      PEFixSection^.Misc.VirtualSize := RealignedVirtualSize;
                                      PEFixSection                   := PImageSectionHeader(NativeUInt(PEFixSection) + IMAGE_SIZEOF_SECTION_HEADER);
                                      Dec(i);
                                 end;
                                 // scrive tutte l'header del file
                                 WriteFile(hFile, ueCopyBuffer^, AlignHeaderSize, dWritten, nil);

                                 ReadBase := ReadBase + AlignHeaderSize - DEFAULT_PAGESIZE;
                                 while(SizeOfImageDump > 0) do
                                 begin
                                      ReadBase := ReadBase + DEFAULT_PAGESIZE;
                                      if(SizeOfImageDump >= DEFAULT_PAGESIZE)then
                                      begin
                                            ZeroMemory(ueCopyBuffer, AlignHeaderSize);
                                            if( not ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead))then
                                            begin
                                                  VirtualQueryEx(hProcess, Pointer(ReadBase), MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, PAGE_EXECUTE_READWRITE, MemInfo.Protect);
                                                  ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead);
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, MemInfo.Protect, &MemInfo.Protect);
                                            end;
                                            WriteFile(hFile, ueCopyBuffer^, DEFAULT_PAGESIZE, Cardinal(dWritten), nil);
                                            SizeOfImageDump := SizeOfImageDump - DEFAULT_PAGESIZE;
                                      end else
                                      begin
                                            ZeroMemory(ueCopyBuffer, AlignHeaderSize);
                                            if( not ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, SizeOfImageDump, dRead))then
                                            begin
                                                  VirtualQueryEx(hProcess, Pointer(ReadBase), &MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, PAGE_EXECUTE_READWRITE, &MemInfo.Protect);
                                                  ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead);
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, MemInfo.Protect, &MemInfo.Protect);
                                            end;
                                            WriteFile(hFile, ueCopyBuffer^, SizeOfImageDump, Cardinal(dWritten), nil);
                                            SizeOfImageDump := 0;
                                      end;
                                 end;
                                 Result := True;
                            end;
                       end;
                   finally
                     CloseHandle(hFile);
                   end;
               end
               else if Is64Bit then
               begin
                   FNumberOfSections := pNtHeaders64^.FileHeader.NumberOfSections+1;

                   if(pNtHeaders64^.OptionalHeader.SizeOfImage mod pNtHeaders64^.OptionalHeader.SectionAlignment = 0) then
                      SizeOfImageDump := ((pNtHeaders64^.OptionalHeader.SizeOfImage div pNtHeaders64^.OptionalHeader.SectionAlignment)) * pNtHeaders64^.OptionalHeader.SectionAlignment
                   else
                      SizeOfImageDump := ((pNtHeaders64^.OptionalHeader.SizeOfImage div pNtHeaders64^.OptionalHeader.SectionAlignment) + 1) * pNtHeaders64^.OptionalHeader.SectionAlignment;
                   SizeOfImageDump := SizeOfImageDump - DWORD(AlignHeaderSize);

                   hFile := CreateFile(PChar(sFileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, 0, 0);
                   try
                       if hFile <> INVALID_HANDLE_VALUE then
                       begin
                            if ReadProcessMemory(hProcess, Ptr(NativeUInt(dwImageBase)), ueCopyBuffer, AlignHeaderSize, dRead) then
                            begin
                                 DOSFixHeader  := PImageDosHeader(NativeUInt(ueCopyBuffer));
                                 PEFixHeader64 := PImageNtHeaders64(NativeUInt(DOSFixHeader) + Cardinal(DOSFixHeader._lfanew));
                                 PEFixSection  := PImageSectionHeader(NativeUInt(PEFixHeader64) + pNtHeaders64^.FileHeader.SizeOfOptionalHeader + sizeof(IMAGE_FILE_HEADER) + 4);
                                 if(PEFixHeader64.OptionalHeader.FileAlignment > $200) then
                                    PEFixHeader64^.OptionalHeader.FileAlignment := pNtHeaders64^.OptionalHeader.SectionAlignment;
                                 PEFixHeader64^.OptionalHeader.AddressOfEntryPoint := DWORD(dwEntryPoint - dwImageBase);
                                 PEFixHeader64^.OptionalHeader.ImageBase           := DWORD64(dwImageBase);
                                 i := FNumberOfSections;
                                 while(i >= 1) do
                                 begin
                                      PEFixSection^.PointerToRawData := PEFixSection.VirtualAddress;
                                      RealignedVirtualSize := (PEFixSection.Misc.VirtualSize div pNTHeaders64^.OptionalHeader.SectionAlignment) * pNTHeaders64^.OptionalHeader.SectionAlignment;
                                      if(RealignedVirtualSize < PEFixSection.Misc.VirtualSize) then
                                             RealignedVirtualSize := RealignedVirtualSize + pNTHeaders64^.OptionalHeader.SectionAlignment;

                                      PEFixSection^.SizeOfRawData    := RealignedVirtualSize;
                                      PEFixSection^.Misc.VirtualSize := RealignedVirtualSize;
                                      PEFixSection                   := PImageSectionHeader(NativeUInt(PEFixSection) + IMAGE_SIZEOF_SECTION_HEADER);
                                      Dec(i);
                                 end;
                                 // scrive tutte l'header del file
                                 WriteFile(hFile, ueCopyBuffer^, AlignHeaderSize, Cardinal(dWritten), nil);

                                 ReadBase := ReadBase + AlignHeaderSize - DEFAULT_PAGESIZE;
                                 while(SizeOfImageDump > 0) do
                                 begin
                                      ReadBase := ReadBase + DEFAULT_PAGESIZE;
                                      if(SizeOfImageDump >= DEFAULT_PAGESIZE)then
                                      begin
                                            ZeroMemory(ueCopyBuffer, AlignHeaderSize);
                                            if( not ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead))then
                                            begin
                                                  VirtualQueryEx(hProcess, Pointer(ReadBase), MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, PAGE_EXECUTE_READWRITE, MemInfo.Protect);
                                                  ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead);
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, MemInfo.Protect, &MemInfo.Protect);
                                            end;
                                            WriteFile(hFile, ueCopyBuffer^, DEFAULT_PAGESIZE, Cardinal(dWritten), nil);
                                            SizeOfImageDump := SizeOfImageDump - DEFAULT_PAGESIZE;
                                      end else
                                      begin
                                            ZeroMemory(ueCopyBuffer, AlignHeaderSize);
                                            if( not ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, SizeOfImageDump, dRead))then
                                            begin
                                                  VirtualQueryEx(hProcess, Pointer(ReadBase), &MemInfo, sizeof(MEMORY_BASIC_INFORMATION));
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, PAGE_EXECUTE_READWRITE, &MemInfo.Protect);
                                                  ReadProcessMemory(hProcess, Pointer(ReadBase), ueCopyBuffer, DEFAULT_PAGESIZE, dRead);
                                                  VirtualProtectEx(hProcess, Pointer(ReadBase), DEFAULT_PAGESIZE, MemInfo.Protect, &MemInfo.Protect);
                                            end;
                                            WriteFile(hFile, ueCopyBuffer^, SizeOfImageDump, Cardinal(dWritten), nil);
                                            SizeOfImageDump := 0;
                                      end;

                                 end;
                                 Result := True;
                            end;
                       end;
                   finally
                     CloseHandle(hFile);
                   end;
               end;
          end;
      finally
         FreeMem(ueReadBuffer);
         FreeMem(ueCopyBuffer);
      end;
end;

function TPeFile.PastePeHeader(const hProcess: THandle; dwImageBase:NativeUInt ;sFileName: string): Boolean;
(*******************************************************************************)
var
  PEHeaderSize,OldProtect : DWORD;
  nB                      : NativeInt;
begin
      Result := False;
      try
          if Is32Bit then
             PEHeaderSize := (pNTHeaders32^.FileHeader.NumberOfSections * IMAGE_SIZEOF_SECTION_HEADER) +
                              (pNTHeaders32^.FileHeader.SizeOfOptionalHeader + sizeof(IMAGE_FILE_HEADER)) + 4
          else
             PEHeaderSize := (pNTHeaders64^.FileHeader.NumberOfSections * IMAGE_SIZEOF_SECTION_HEADER) +
                             (pNTHeaders64^.FileHeader.SizeOfOptionalHeader + sizeof(IMAGE_FILE_HEADER)) + 4;

          if Is32Bit then
          begin
               pNTHeaders32^.OptionalHeader.ImageBase := dwImageBase;
               if(VirtualProtectEx(hProcess, Pointer(dwImageBase), PEHeaderSize, PAGE_READWRITE, OldProtect)) then
                  if(WriteProcessMemory(hProcess, Pointer(dwImageBase), lpBuffer, NativeUInt(PEHeaderSize), NativeUint(nB))) then
                     Result := True;
          end else
          begin
               pNTHeaders64^.OptionalHeader.ImageBase := dwImageBase;
               if(VirtualProtectEx(hProcess, Pointer(dwImageBase), PEHeaderSize, PAGE_READWRITE, OldProtect)) then
                  if(WriteProcessMemory(hProcess, Pointer(dwImageBase), lpBuffer, NativeUInt(PEHeaderSize), NativeUint(nB))) then
                     Result := True;
          end;
      except
          raise Exception.Create('Errore PastPeHeader');
      end;
end;

function TPeFile.RelocaterMakeSnapshot(hProcess:THandle; szSaveFileName:string; MemoryStart,MemorySize:LongInt):boolean;
(*******************************************************************************)
begin
     Result := DumpMemory(hProcess,szSaveFileName,MemoryStart,MemorySize)
end;

function TPeFile.RelocaterCompareTwoSnapshots(hProcess:THandle; LoadedImageBase,NtSizeOfImage:LongInt; szDumpFile1,szDumpFile2:string; MemStart:LongInt):boolean;
(*******************************************************************************)
begin

end;

function TPeFile.ReadPeHeadersFromProcess(const hProcess: THandle): Boolean;
(*******************************************************************************)
var
  x,i         : Word;
  PEFixSection: PImageSectionHeader;
begin
     Result := False;
     getDosAndNtHeader;
     if IsValidPe then
     begin
          FNumberOfSections    := pNtHeaders32^.FileHeader.NumberOfSections;
          if Is32Bit  then
          begin
              FAddressOfEntryPoint := pNtHeaders32^.OptionalHeader.AddressOfEntryPoint;
              FImageBase           := pNtHeaders32^.OptionalHeader.ImageBase;
              FFileAlign           := pNtHeaders32^.OptionalHeader.FileAlignment;
              FSectionAlign        := pNtHeaders32^.OptionalHeader.SectionAlignment;

              PEFixSection  := PImageSectionHeader(NativeUInt(pNtHeaders32) + pNtHeaders32^.FileHeader.SizeOfOptionalHeader + sizeof(IMAGE_FILE_HEADER) + 4);
          end else
          begin
              FAddressOfEntryPoint := pNtHeaders64^.OptionalHeader.AddressOfEntryPoint;
              FImageBase           := pNtHeaders64^.OptionalHeader.ImageBase;
              FFileAlign           := pNtHeaders64^.OptionalHeader.FileAlignment;
              FSectionAlign        := pNtHeaders64^.OptionalHeader.SectionAlignment;

              PEFixSection  := PImageSectionHeader(NativeUInt(pNtHeaders64) + pNtHeaders64^.FileHeader.SizeOfOptionalHeader + sizeof(IMAGE_FILE_HEADER) + 4);
          end;

          i := FNumberOfSections+1;
          while(i >= 1) do
          begin
              PEFixSection^.PointerToRawData := PEFixSection.VirtualAddress;
              PEFixSection^.SizeOfRawData    := PEFixSection.Misc.VirtualSize;
              PEFixSection                   := PImageSectionHeader(NativeUInt(PEFixSection) + IMAGE_SIZEOF_SECTION_HEADER);
              Dec(i);
          end;

          SetLength(ImageSections, NumberOfSections);
          for x := Low(ImageSections) to High(ImageSections) do
          begin
               if Is32Bit then
                   CopyMemory(@ImageSections[x],
                   Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders32) + (x * SizeOf(TImageSectionHeader))),
                   SizeOf(TImageSectionHeader))
               else
                  CopyMemory(@ImageSections[x],
                  Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders64) + (x * SizeOf(TImageSectionHeader))),
                  SizeOf(TImageSectionHeader))
          end;
          Result := True;
     end;
end;

function TPeFile.removeIatDirectory: Boolean;
(*******************************************************************************)
var
	searchAddress : DWORD;
  i             : Word;
begin

    Result := False;
    if Is32Bit then
    begin
         searchAddress := pNtHeaders32.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].VirtualAddress;

         pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].VirtualAddress := 0;
         pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].Size           := 0;
    end else
    begin
         searchAddress := pNtHeaders64.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].VirtualAddress;

         pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].VirtualAddress := 0;
         pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].Size           := 0;
    end;

    if (searchAddress <> 0) then
    begin
          for i := 0 to FNumberOfSections do
          begin
            if ((ImageSections[i].VirtualAddress <= searchAddress) and ((ImageSections[i].VirtualAddress + ImageSections[i].Misc.VirtualSize) > searchAddress)) then
               ImageSections[i].Characteristics  :=  ImageSections[i].Characteristics or IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_WRITE;
            Result := True;
          end;
    end;
end;

function TPeFile.LoadFromProcess(const hProcess: THandle; sFileName: string;dwImageBase,dwSizeImage:NativeUInt): Boolean;
(*******************************************************************************)
var
  dRead: NativeUInt;
begin
    Result := False;

    FFilename := sFilename;
    FFileSize := dwSizeImage;
    GetMem(lpBuffer, FileSize);
    ReadProcessMemory(hProcess, Pointer(dwImageBase), lpBuffer, dwSizeImage, dRead);

    if (FileSize = dRead) then Result := ReadPeHeadersFromProcess(hProcess);
    removeIatDirectory;
end;

function TPeFile.LoadFromFile(const sFilename: string): Boolean;
(*******************************************************************************)
var
  hFile: THandle;
  lpNumberOfBytesRead: DWORD;
begin
    Result := False;
    hFile  := CreateFile(PChar(sFilename), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
    if (hFile <> INVALID_HANDLE_VALUE) then
    begin
        FFilename := sFilename;
        FFileSize := GetFileSize(hFile, nil);
        GetMem(lpBuffer, FileSize);
        ReadFile(hFile, lpBuffer^, FileSize, lpNumberOfBytesRead, nil);
        if (FileSize = lpNumberOfBytesRead) then
        begin
             Result := ReadPeHeaders;
        end;
        CloseHandle(hFile);
    end;
end;

function TPeFile.SaveToFile(const sFilename: string; bNewFile : Boolean = True): Boolean;
(*******************************************************************************)
var
  hFile: THandle;
  lpNumberOfBytesWritten: DWORD;
begin
    Result := False;
    if bNewFile then
        hFile := CreateFile(PChar(sFilename), GENERIC_WRITE, FILE_SHARE_READ, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)
    else
        hFile := CreateFile(PChar(sFilename), GENERIC_WRITE or GENERIC_READ, FILE_SHARE_WRITE or FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

    if (hFile <> INVALID_HANDLE_VALUE) then
    begin
        if IsValidPe then
        begin
            CopyMemory(lpBuffer, pDosHeader, SizeOf(TImageDosHeader));
            if Is32Bit then
                 CopyMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew)), pNtHeaders32, SizeOf(TImageNtHeaders))
            else
                CopyMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew)), pNtHeaders64, SizeOf(TImageNtHeaders64)) ;
            WriteImageSectionHeader;
            SetFilePointer(hFile, 0, nil, FILE_BEGIN);
            WriteFile(hFile, lpBuffer^, FileSize, lpNumberOfBytesWritten, nil);
            if (FileSize = lpNumberOfBytesWritten) then
            begin
                Result := True;
            end;
        end;
        CloseHandle(hFile);
    end
    else
      MessageBox(0,PChar(SysErrorMessage(getLastError)),'errore',MB_OK)
end;

procedure TPeFile.SetAddressOfEntryPoint(AddressOfEntryPoint:Cardinal);
(*******************************************************************************)
begin
     if Is32Bit then
     begin
         pNtHeaders32^.OptionalHeader.AddressOfEntryPoint := AddressOfEntryPoint;
         FAddressOfEntryPoint := AddressOfEntryPoint
     end else
     begin
         pNtHeaders64^.OptionalHeader.AddressOfEntryPoint := AddressOfEntryPoint;
         FAddressOfEntryPoint := AddressOfEntryPoint
     end;
end;

procedure TPeFile.SetImageBase(ImageBase: NativeUInt);
(*******************************************************************************)
begin
     if Is32Bit then
     begin
         pNtHeaders32^.OptionalHeader.ImageBase := ImageBase;
         FImageBase := ImageBase;
     end else
     begin
         pNtHeaders64^.OptionalHeader.ImageBase := ImageBase;
         FImageBase := ImageBase;
     end;
end;

function TPeFile.RvaToFileOffset(dwRVA: Cardinal): Cardinal;
(*******************************************************************************)
var
  x: Word;
begin
    Result := 0;
    for x := Low(ImageSections) to High(ImageSections) do
    begin
        if ((dwRVA >= ImageSections[x].VirtualAddress) and (dwRVA < ImageSections[x].VirtualAddress + ImageSections[x].SizeOfRawData)) then
        begin
            Result := dwRVA - ImageSections[x].VirtualAddress + ImageSections[x].PointerToRawData;
            Break;
        end;
    end;
end;

function TPeFile.FileOffsetToRva(dwFileOffset: Cardinal): Cardinal;
(*******************************************************************************)
var
  x: Word;
begin
    Result := 0;
    for x := Low(ImageSections) to High(ImageSections) do
    begin
        if ((dwFileOffset >= ImageSections[x].PointerToRawData) and (dwFileOffset < ImageSections[x].PointerToRawData + ImageSections[x].SizeOfRawData)) then
        begin
            Result := dwFileOffset - ImageSections[x].PointerToRawData + ImageSections[x].VirtualAddress;
            Break;
        end;
    end;
end;

function TPeFile.VaToFileOffset(dwVA: Cardinal): Cardinal;
(*******************************************************************************)
begin
     if Is32Bit then
     begin
          if (dwVA > pNtHeaders32^.OptionalHeader.ImageBase) then
              Result := RvaToFileOffset(dwVA - pNtHeaders32^.OptionalHeader.ImageBase)
          else Result := 0;
     end else
     begin
          if (dwVA > DWord(pNtHeaders64^.OptionalHeader.ImageBase)) then
              Result := RvaToFileOffset(dwVA - pNtHeaders64^.OptionalHeader.ImageBase)
          else Result := 0;
     end
end;

function TPeFile.FileOffsetToVa(dwFileOffset: NativeUInt): NativeUint;
(*******************************************************************************)
begin
     if Is32Bit then
        Result := FileOffsetToRva(dwFileOffset) + pNtHeaders32^.OptionalHeader.ImageBase
     else
        Result := FileOffsetToRva(dwFileOffset) + pNtHeaders64^.OptionalHeader.ImageBase
end;

function TPeFile.VaToRva(dwVA: Cardinal): Cardinal;
(*******************************************************************************)
begin
     if Is32Bit then
        Result := dwVA - pNtHeaders32^.OptionalHeader.ImageBase
     else
        Result := dwVA - pNtHeaders64^.OptionalHeader.ImageBase
end;

function TPeFile.RvaToVa(dwRVA: Cardinal): Cardinal;
(*******************************************************************************)
begin
     if Is32Bit then
         Result := dwRVA + pNtHeaders32^.OptionalHeader.ImageBase
     else
         Result := dwRVA + pNtHeaders64^.OptionalHeader.ImageBase
end;

function TPeFile.RvaToSection(dwRVA: Cardinal): Word;
(*******************************************************************************)
var
  x: Word;
begin
    Result := High(Word);
    for x := Low(ImageSections) to High(ImageSections) do
    begin
        if ((dwRVA >= ImageSections[x].VirtualAddress) and (dwRVA < ImageSections[x].VirtualAddress + ImageSections[x].SizeOfRawData)) then
        begin
            Result := x;
            Break;
        end;
    end;
end;

function TPeFile.VaToSection(dwVA: Cardinal): Word;
(*******************************************************************************)
var
  dwRVA : Cardinal;
begin
     if Is32Bit then
        dwRVA  := dwVA - pNtHeaders32^.OptionalHeader.ImageBase
     else
        dwRVA  := dwVA - pNtHeaders64^.OptionalHeader.ImageBase ;

     Result := RvaToSection(dwRVA);
end;

function TPeFile.FileOffsetToSection(dwFileOffset: Cardinal): Word;
(*******************************************************************************)
var
  x: Word;
begin
    Result := High(Word);
    for x := Low(ImageSections) to High(ImageSections) do
    begin
        if ((dwFileOffset >= ImageSections[x].PointerToRawData) and (dwFileOffset < ImageSections[x].PointerToRawData + ImageSections[x].SizeOfRawData)) then
        begin
            Result := x;
            Break;
        end;
    end;
end;

function TPeFile.InsertBytes(FromOffset, Count: Cardinal): Cardinal;
(*******************************************************************************)
var
  dwCopyFrom, dwCopyLength: Cardinal;
  lpTemp: Pointer;
begin
    Result := 0;
    if (FromOffset > FFileSize) then dwCopyFrom := FFileSize
    else                             dwCopyFrom := FromOffset;
    dwCopyLength := FFileSize - dwCopyFrom;
    ReallocMem(lpBuffer, FFileSize + Count);
    if (dwCopyLength > 0) then
    begin
        GetMem(lpTemp, dwCopyLength);
        CopyMemory(lpTemp, Pointer(NativeUInt(lpBuffer) + dwCopyFrom), dwCopyLength);
        CopyMemory(Pointer(NativeUInt(lpBuffer) + dwCopyFrom + Count), lpTemp, dwCopyLength);
        FreeMem(lpTemp);
    end;
    ZeroMemory(Pointer(NativeUInt(lpBuffer) + dwCopyFrom), Count);
    if ReadPeHeaders then
    begin
        FFileSize := FFileSize + Count;
        Result := FFileSize;
    end;
end;


function TPeFile.DeleteBytes(FromOffset, Count: Cardinal): Cardinal;
(*******************************************************************************)
var
  dwCopyFrom, dwCopyLength: DWORD;
  lpTemp: Pointer;
begin
    Result := 0;
    if (FFileSize >= (FromOffset + Count)) then
    begin
        dwCopyFrom := FromOffset + Count;
        dwCopyLength := FFileSize - dwCopyFrom;
        if (dwCopyLength > 0) then
        begin
            GetMem(lpTemp, dwCopyLength);
            CopyMemory(lpTemp, Pointer(NativeUInt(lpBuffer) + dwCopyFrom), dwCopyLength);
            CopyMemory(Pointer(NativeUInt(lpBuffer) + FromOffset), lpTemp, dwCopyLength);
            FreeMem(lpTemp);
        end;
        ReallocMem(lpBuffer, FFileSize - Count);
        if ReadPeHeaders then
        begin
            FFileSize := FFileSize - Count;
            Result := FFileSize;
        end;
    end;
end;


function TPeFile.FindCodeCaves(FromOffset, Count: Cardinal): TCodeCave;
(*******************************************************************************)
var
  x, TempCave: Cardinal;
const
  IGNORE_BYTES = 4;
begin
    ZeroMemory(@Result, SizeOf(TCodeCave));
    if (Count > 0) then
    begin
        TempCave := 0;
        for x := 0 to Count do
        begin
            if (PByte(NativeUInt(lpBuffer) + FromOffset + x)^ = 0) then  Inc(TempCave)
            else                                                       TempCave := 0;
            if ((TempCave > Result.CaveSize) and (TempCave > IGNORE_BYTES)) then
            begin
                with Result do
                begin
                    StartFileOffset := FromOffset + (x - TempCave) + IGNORE_BYTES;
                    StartRVA := FileOffsetToRva(StartFileOffset);
                    CaveSize := TempCave - IGNORE_BYTES;
                end;
            end;
        end;
    end;
end;

function TPeFile.AddSection(const sSectionName: string; RawSize: Cardinal;
                            lpData: Pointer; dwDataLength: Cardinal;
                            dwCharacteristics: Cardinal = IMAGE_SCN_MEM_WRITE or IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_EXECUTE or IMAGE_SCN_CNT_CODE): Boolean;
(*******************************************************************************)
var
  Section,FirstSection: TImageSectionHeader;

  FileAlign,SectionAlign,

  dwHighestSectionSize,SpaceLeft: Cardinal;
begin
     Result    := False;

     if Is32Bit then
     begin
          FileAlign    := pNtHeaders32^.OptionalHeader.FileAlignment;
          SectionAlign := pNtHeaders32^.OptionalHeader.SectionAlignment
     end else
     begin
          FileAlign    := pNtHeaders64^.OptionalHeader.FileAlignment;
          SectionAlign := pNtHeaders32^.OptionalHeader.SectionAlignment;
     end;

     if (lpData = nil) then  dwDataLength := 0;
     if ((RawSize = DWORD(-1)) or (RawSize = 0)) then Exit;

     if (dwDataLength > RawSize) then
     begin
          repeat
               RawSize := Align(RawSize +1, FileAlign);
          until (Align(RawSize, FileAlign) >= dwDataLength);
     end;

     FirstSection := ImageSections[0];
     if Is32Bit then
          SpaceLeft := FirstSection.PointerToRawData - (FNumberOfSections * SizeOf(IMAGE_SIZEOF_SECTION_HEADER)) - Cardinal(pDOSHeader._lfanew) - sizeof(IMAGE_NT_HEADERS32)
     else
          SpaceLeft := FirstSection.PointerToRawData - (FNumberOfSections * SizeOf(IMAGE_SIZEOF_SECTION_HEADER)) - Cardinal(pDOSHeader._lfanew) - sizeof(IMAGE_NT_HEADERS64);

     { TODO -oMax -c : Aggiungere la gestione nel caso non ci sia spazio per l'header della sezione 29/09/2012 16:08:09 }
     if SpaceLeft <  IMAGE_SIZEOF_SECTION_HEADER then  Exit;

     ZeroMemory(@Section,IMAGE_SIZEOF_SECTION_HEADER);
     StringToSection(sSectionName, Section);
     with Section do
     begin
          VirtualAddress   := Align(getSectionHeaderBasedSizeOfImage, SectionAlign);
          PointerToRawData := Align(GetSectionHeaderBasedFileSize, FileAlign);
          SizeOfRawData    := Align(RawSize, FileAlign);
          Misc.VirtualSize := Align(RawSize, SectionAlign);
          Characteristics  := dwCharacteristics;
     end;

     FFileSize := FFileSize + Section.SizeOfRawData;
     dwHighestSectionSize := getSectionHeaderBasedFileSize;

     if Is32Bit then Inc(pNtHeaders32^.FileHeader.NumberOfSections)
     else            Inc(pNtHeaders64^.FileHeader.NumberOfSections);

     if Is32Bit then
          CopyMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders32) +
                     (FNumberOfSections * SizeOf(TImageSectionHeader))), @Section, SizeOf(TImageSectionHeader))
     else
          CopyMemory(Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader._lfanew) + SizeOf(TImageNtHeaders64) +
                     (FNumberOfSections * SizeOf(TImageSectionHeader))), @Section, SizeOf(TImageSectionHeader));

     ReallocMem(lpBuffer, FFileSize);
     Result := ReadPeHeaders;
     ZeroMemory(Pointer(NativeUInt(lpBuffer) + dwHighestSectionSize), FFileSize - dwHighestSectionSize);

     if ((lpData <> nil) and (dwDataLength > 0)) then
         CopyMemory(Pointer(NativeUInt(lpBuffer) + dwHighestSectionSize), lpData, dwDataLength);
    RecalcImageSize;
    RecalcCheckSum;
end;

function TPeFile.DeleteSection(wSection: Word): Boolean;
(*******************************************************************************)
var
  dwTempFileSize, dwTemp,
  SectionOffset, SectionSize: Cardinal;
  x: Word;
begin
      Result := False;
      if ((wSection < FNumberOfSections) and (wSection <> High(Word))) then
      begin
          SectionOffset  := ImageSections[wSection].PointerToRawData;
          SectionSize    := ImageSections[wSection].SizeOfRawData;
          dwTempFileSize := FFileSize;
          DeleteBytes(SectionOffset, SectionSize);
          if (FFileSize = dwTempFileSize - SectionSize) then
          begin
              if Is32Bit then
              begin
                  if (wSection > 0) then
                  begin
                      for x := Low(ImageSections) to wSection -1 do
                      begin
                          CopyMemory(
                            Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders32) + (x * SizeOf(TImageSectionHeader))),
                            @ImageSections[x],
                            SizeOf(TImageSectionHeader));
                      end;
                  end;
                  for x := wSection +1 to FNumberOfSections -1 do
                  begin
                      CopyMemory(
                        Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders32) + ((x -1) * SizeOf(TImageSectionHeader))),
                         @ImageSections[x],
                         SizeOf(TImageSectionHeader));
                  end;
                  for x := 0 to IMAGE_NUMBEROF_DIRECTORY_ENTRIES -1 do
                  begin
                      if ((pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress <> 0) and (pNtHeaders32^.OptionalHeader.DataDirectory[x].Size <> 0)) then
                      begin
                          dwTemp := RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress);
                          if (dwTemp = 0) then
                            dwTemp := pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress;
                          if (dwTemp = SectionOffset) then
                          begin
                              pNtHeaders32^.OptionalHeader.DataDirectory[x].VirtualAddress := 0;
                              pNtHeaders32^.OptionalHeader.DataDirectory[x].Size := 0;
                          end;
                      end;
                  end;
              end else
              begin
                  if (wSection > 0) then
                  begin
                      for x := Low(ImageSections) to wSection -1 do
                      begin
                          CopyMemory(
                            Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders64) + (x * SizeOf(TImageSectionHeader))),
                            @ImageSections[x],
                            SizeOf(TImageSectionHeader));
                      end;
                  end;
                  for x := wSection +1 to FNumberOfSections -1 do
                  begin
                      CopyMemory(
                        Pointer(NativeUInt(lpBuffer) + Cardinal(pDosHeader^._lfanew) + SizeOf(TImageNtHeaders64) + ((x -1) * SizeOf(TImageSectionHeader))),
                         @ImageSections[x],
                         SizeOf(TImageSectionHeader));
                  end;
                  for x := 0 to IMAGE_NUMBEROF_DIRECTORY_ENTRIES -1 do
                  begin
                      if ((pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress <> 0) and (pNtHeaders64^.OptionalHeader.DataDirectory[x].Size <> 0)) then
                      begin
                          dwTemp := RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress);
                          if (dwTemp = 0) then
                            dwTemp := pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress;
                          if (dwTemp = SectionOffset) then
                          begin
                              pNtHeaders64^.OptionalHeader.DataDirectory[x].VirtualAddress := 0;
                              pNtHeaders64^.OptionalHeader.DataDirectory[x].Size := 0;
                          end;
                      end;
                  end;
              end;
              if Is32Bit then Dec(pNtHeaders32^.FileHeader.NumberOfSections)
              else            Dec(pNtHeaders64^.FileHeader.NumberOfSections);
              Dec(FNumberOfSections);
              Result := ReadPeHeaders;
              RecalcImageSize;
              RecalcCheckSum;
          end;
      end;
end;

function TPeFile.GetCharacteristics(dwCharacteristics: DWORD): string;
(*******************************************************************************)
type
  TCharacteristics = packed record
    Mask: DWORD;
    InfoChar: Char;
  end;
const
  Info: array[0..8] of TCharacteristics = (
    (Mask: IMAGE_SCN_CNT_CODE;               InfoChar: 'C'),
    (Mask: IMAGE_SCN_MEM_EXECUTE;            InfoChar: 'E'),
    (Mask: IMAGE_SCN_MEM_READ;               InfoChar: 'R'),
    (Mask: IMAGE_SCN_MEM_WRITE;              InfoChar: 'W'),
    (Mask: IMAGE_SCN_MEM_NOT_PAGED;          InfoChar: 'P'),
    (Mask: IMAGE_SCN_CNT_INITIALIZED_DATA;   InfoChar: 'I'),
    (Mask: IMAGE_SCN_CNT_UNINITIALIZED_DATA; InfoChar: 'U'),
    (Mask: IMAGE_SCN_MEM_SHARED;             InfoChar: 'S'),
    (Mask: IMAGE_SCN_MEM_DISCARDABLE;        InfoChar: 'D'));
var
  x: Word;
begin
    for x := Low(Info) to High(Info) do
    begin
      if ((dwCharacteristics and Info[x].Mask) = Info[x].Mask) then
        Result := Result + Info[x].InfoChar;
    end;
end;

function TPeFile.GetCodeSection: Word;
(*******************************************************************************)
begin
     if Is32Bit then
        Result := RvaToSection(pNtHeaders32^.OptionalHeader.BaseOfCode)
     else
        Result := RvaToSection(pNtHeaders64^.OptionalHeader.BaseOfCode)
end;

function TPeFile.GetDataSection: Word;
(*******************************************************************************)
begin
     if Is32Bit then
        Result := RvaToSection(pNtHeaders32^.OptionalHeader.BaseOfData)
     else
        Result := $FFFF
end;

function TPeFile.GetResourceSection: Word;
(*******************************************************************************)
var
  stmp  : string;
  dwTemp: Cardinal;
begin
    Result := High(Word);
    dwTemp := GetPE32Data(0,PED_RESOURCETABLEADDRESS,stmp);
    if (dwTemp <> 0) then
      Result := RvaToSection(dwTemp);
end;

procedure TPeFile.GetImportAddressTable(var Imports: TImportsArray);
(*******************************************************************************)
var
  x, y                 : Cardinal;
  ImportDescriptor     : PImageImportDescriptor;
  lpszLibraryName      : PAnsiChar;
  ImageThunk32         : PImageThunkData32;
  ImageThunk64         : PImageThunkData64;
  pByName              : PIMAGE_IMPORT_BY_NAME;
  lpszAPIName          : PAnsiChar;
  { Is Import By Ordinal? }
  function IsImportByOrdinal(ImportDescriptor: ULONGLONG): Boolean;
  begin
       if Is32Bit then  Result := (DWORD(ImportDescriptor) and IMAGE_ORDINAL_FLAG32) <> 0
       else             Result := (ImportDescriptor        and IMAGE_ORDINAL_FLAG64) <> 0
  end;
begin
    x := 0;
    SetLength(Imports, 1);
    ZeroMemory(Imports, SizeOf(Imports) * High(Imports));

    if Is32Bit then
    begin
        if ((pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress <> 0) and
            (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size <> 0)) then
        begin
            ImportDescriptor := PImageImportDescriptor(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress));
            while (ImportDescriptor^.Name <> 0) do
            begin
                SetLength(Imports, x +1);
                lpszLibraryName               := PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(ImportDescriptor^.Name));
                Imports[x].LibraryName        := string(lpszLibraryName);
                Imports[x].OriginalFirstThunk := ImportDescriptor^.OriginalFirstThunk;
                Imports[x].TimeDateStamp      := ImportDescriptor^.TimeDateStamp;
                Imports[x].ForwarderChain     := ImportDescriptor^.ForwarderChain;
                Imports[x].Name               := ImportDescriptor^.Name;
                Imports[x].FirstThunk         := ImportDescriptor^.FirstThunk;
                if (ImportDescriptor^.OriginalFirstThunk <> 0) then
                  ImageThunk32 := PImageThunkData32(NativeUInt(lpBuffer)+RvaToFileOffset(ImportDescriptor^.OriginalFirstThunk))
                else
                  ImageThunk32 := PImageThunkData32(NativeUInt(lpBuffer)+RvaToFileOffset(ImportDescriptor^.FirstThunk));
                y := 0;
                while (ImageThunk32^._Function <> 0) do
                begin
                    SetLength(Imports[x].IatFunctions, y +1);
                    if IsImportByOrdinal(ImageThunk32^.Ordinal) then
                    begin
                        lpszAPIName := '(by ordinal)';
                        Imports[x].IatFunctions[y].Hint := ImageThunk32^.Ordinal and $ffff;
                    end else
                    begin
                        pByName                         := PIMAGE_IMPORT_BY_NAME(NativeUInt(lpBuffer)+RvaToFileOffset(ImageThunk32^.AddressOfData));
                        lpszAPIName                     := PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(ImageThunk32^.AddressOfData + SizeOf(Word)));
                        Imports[x].IatFunctions[y].Hint := pByName^.Hint;
                    end;
                    Imports[x].IatFunctions[y].ThunkOffset := Cardinal(ImageThunk32) - Cardinal(lpBuffer);
                    if (ImportDescriptor^.OriginalFirstThunk <> 0) then
                      Imports[x].IatFunctions[y].ThunkRVA := ImportDescriptor^.OriginalFirstThunk + DWORD(y * SizeOf(DWORD))
                    else
                      Imports[x].IatFunctions[y].ThunkRVA := ImportDescriptor^.FirstThunk + DWORD(y * SizeOf(DWORD));
                    Imports[x].IatFunctions[y].ThunkValue := ImageThunk32^.AddressOfData;
                    Imports[x].IatFunctions[y].ApiName    := string(lpszAPIName);
                    Inc(y);
                    Inc(ImageThunk32);
                end;
                Inc(x);
                Inc(ImportDescriptor);
            end;
        end;
    end else  //64 bit
    begin
        if ((pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress <> 0) and
           (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size <> 0)) then
        begin
            ImportDescriptor := PImageImportDescriptor(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress));
            while (ImportDescriptor^.Name <> 0) do
            begin
                SetLength(Imports, x +1);
                lpszLibraryName               := PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(ImportDescriptor^.Name));
                Imports[x].LibraryName        := string(lpszLibraryName);
                Imports[x].OriginalFirstThunk := ImportDescriptor^.OriginalFirstThunk;
                Imports[x].TimeDateStamp      := ImportDescriptor^.TimeDateStamp;
                Imports[x].ForwarderChain     := ImportDescriptor^.ForwarderChain;
                Imports[x].Name               := ImportDescriptor^.Name;
                Imports[x].FirstThunk         := ImportDescriptor^.FirstThunk;
                if (ImportDescriptor^.OriginalFirstThunk <> 0) then
                  ImageThunk64 := PImageThunkData64(NativeUInt(lpBuffer)+RvaToFileOffset(ImportDescriptor^.OriginalFirstThunk))
                else
                  ImageThunk64 := PImageThunkData64(NativeUInt(lpBuffer)+RvaToFileOffset(ImportDescriptor^.FirstThunk));
                y := 0;
                while (ImageThunk64^._Function <> 0) do
                begin
                    SetLength(Imports[x].IatFunctions, y +1);
                    if IsImportByOrdinal(ImageThunk64^.Ordinal) then
                    begin
                        lpszAPIName := '(by ordinal)';
                        Imports[x].IatFunctions[y].Hint := ImageThunk64^.Ordinal and $ffff;
                    end else
                    begin
                        pByName                         := PIMAGE_IMPORT_BY_NAME(NativeUInt(lpBuffer)+RvaToFileOffset(ImageThunk64^.AddressOfData));
                        lpszAPIName                     := PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(ImageThunk64^.AddressOfData + SizeOf(Word)));
                        Imports[x].IatFunctions[y].Hint := pByName^.Hint;;
                    end;
                    Imports[x].IatFunctions[y].ThunkOffset := UInt64(ImageThunk64) - NativeUint(lpBuffer);
                    if (ImportDescriptor^.OriginalFirstThunk <> 0) then
                      Imports[x].IatFunctions[y].ThunkRVA := ImportDescriptor^.OriginalFirstThunk + UInt64(y * SizeOf(UInt64))
                    else
                      Imports[x].IatFunctions[y].ThunkRVA := ImportDescriptor^.FirstThunk + UInt64(y * SizeOf(UInt64));
                    Imports[x].IatFunctions[y].ThunkValue := ImageThunk64^.AddressOfData;
                    Imports[x].IatFunctions[y].ApiName    := string(lpszAPIName);
                    Inc(y);
                    Inc(ImageThunk64);
                end;
                Inc(x);
                Inc(ImportDescriptor);
            end;
        end;
    end;

end;

function TPeFile.GetExportsAddressTable(var ExportData: TExports): DWORD;
(*******************************************************************************)
type
  PDWORDArray = ^TDWORDArray;
  TDWORDArray = array[Word] of DWORD;
  PWordArray = ^TWordArray;
  TWordArray = array[Word] of Word;
var
  ExportDirectory: PImageExportDirectory;
  Functions      : PDWORDArray;
  Ordinals       : PWordArray;
  Names          : PDWORDArray;
  CounterFunctions,
  CounterOrdinals: DWORD;
  VA             : DWORD;
  sName          : string;
  x: Integer;
begin
    Result := 0;
    SetLength(ExportData.ExportFunctions, 1);
    ZeroMemory(@ExportData, SizeOf(ExportData));
    ZeroMemory(ExportData.ExportFunctions, SizeOf(ExportData.ExportFunctions) * High(ExportData.ExportFunctions));
    if Is32Bit then
    begin
        if ((pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress <> 0) and
            (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size <> 0)) then
        begin
            Result          := RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress);
            ExportDirectory := PImageExportDirectory(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress));
            Functions       := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(Cardinal(ExportDirectory^.AddressOfFunctions)));
            Ordinals        := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(Cardinal(ExportDirectory^.AddressOfNameOrdinals)));
            Names           := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(Cardinal(ExportDirectory^.AddressOfNames)));
            with ExportData do
            begin
                LibraryName           := string(PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(ExportDirectory^.Name)));
                Base                  := ExportDirectory^.Base;
                Characteristics       := ExportDirectory^.Characteristics;
                TimeDateStamp         := ExportDirectory^.TimeDateStamp;
                MajorVersion          := ExportDirectory^.MajorVersion;
                MinorVersion          := ExportDirectory^.MinorVersion;
                NumberOfFunctions     := ExportDirectory^.NumberOfFunctions;
                NumberOfNames         := ExportDirectory^.NumberOfNames;
                AddressOfFunctions    := DWORD(ExportDirectory^.AddressOfFunctions);
                AddressOfNames        := DWORD(ExportDirectory^.AddressOfNames);
                AddressOfNameOrdinals := Word(ExportDirectory^.AddressOfNameOrdinals);
            end;
            if (Functions <> nil) then
            begin
                x := 0;
                for CounterFunctions := 0 to ExportDirectory^.NumberOfFunctions -1 do
                begin
                    sName := '';
                    if (Functions[CounterFunctions] = 0) then
                      continue;
                    SetLength(ExportData.ExportFunctions, x +1);
                    ExportData.ExportFunctions[x].Ordinal := CounterFunctions + ExportDirectory^.Base;
                    if (Ordinals <> nil) and (Names <> nil) then
                    begin
                        for CounterOrdinals := 0 to ExportDirectory^.NumberOfNames -1 do
                        begin
                            if (Ordinals[CounterOrdinals] = CounterFunctions) then
                            begin
                                sName := string(PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(Names[CounterOrdinals])));
                                Break;
                            end;
                        end;
                    end;
                    VA := Functions[CounterFunctions];
                    if DWORD(VA - pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress) <
                              pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size then
                    begin
                        sName := string(PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(Va)));
                        VA := 0;
                    end;
                    ExportData.ExportFunctions[x].Rva        := VA;
                    ExportData.ExportFunctions[x].FileOffset := RvaToFileOffset(VA);
                    ExportData.ExportFunctions[x].ApiName    := sName;
                    Inc(x);
                end;
            end;
        end;
    end else
    begin   // 64 bit module
        if ((pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress <> 0) and
            (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size <> 0)) then
        begin
            Result          := RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress);
            ExportDirectory := PImageExportDirectory(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress));
            Functions       := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(Cardinal(ExportDirectory^.AddressOfFunctions)));
            Ordinals        := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(Cardinal(ExportDirectory^.AddressOfNameOrdinals)));
            Names           := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(Cardinal(ExportDirectory^.AddressOfNames)));
            with ExportData do
            begin
                LibraryName           := string(PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(ExportDirectory^.Name)));
                Base                  := ExportDirectory^.Base;
                Characteristics       := ExportDirectory^.Characteristics;
                TimeDateStamp         := ExportDirectory^.TimeDateStamp;
                MajorVersion          := ExportDirectory^.MajorVersion;
                MinorVersion          := ExportDirectory^.MinorVersion;
                NumberOfFunctions     := ExportDirectory^.NumberOfFunctions;
                NumberOfNames         := ExportDirectory^.NumberOfNames;
                AddressOfFunctions    := DWORD(ExportDirectory^.AddressOfFunctions);
                AddressOfNames        := DWORD(ExportDirectory^.AddressOfNames);
                AddressOfNameOrdinals := Word(ExportDirectory^.AddressOfNameOrdinals);
            end;
            if (Functions <> nil) then
            begin
                x := 0;
                for CounterFunctions := 0 to ExportDirectory^.NumberOfFunctions -1 do
                begin
                    sName := '';
                    if (Functions[CounterFunctions] = 0) then
                      continue;
                    SetLength(ExportData.ExportFunctions, x +1);
                    ExportData.ExportFunctions[x].Ordinal := CounterFunctions + ExportDirectory^.Base;
                    if (Ordinals <> nil) and (Names <> nil) then
                    begin
                        for CounterOrdinals := 0 to ExportDirectory^.NumberOfNames -1 do
                        begin
                            if (Ordinals[CounterOrdinals] = CounterFunctions) then
                            begin
                                sName := string(PAnsiChar(NativeUInt(lpBuffer)+RvaToFileOffset(Names[CounterOrdinals])));
                                Break;
                            end;
                        end;
                    end;
                    VA := Functions[CounterFunctions];
                    if DWORD(VA - pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress) <
                              pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size then
                    begin
                        sName := string(PAnsiChar(RvaToVa(Va)));
                        VA := 0;
                    end;
                    ExportData.ExportFunctions[x].Rva        := VA;
                    ExportData.ExportFunctions[x].FileOffset := RvaToFileOffset(VA);
                    ExportData.ExportFunctions[x].ApiName    := sName;
                    Inc(x);
                end;
            end;
        end;
    end;
end;

function TPeFile.GetThreadLocalStorage: Pointer;
(*******************************************************************************)
begin
    Result := nil;
    if Is32Bit then
    begin
        if (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress <> 0) then
        begin
          Result := PImageTLSDirectory32(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress));
        end;
    end else
    begin
        if (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress <> 0) then
        begin
          Result := PImageTLSDirectory64(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress));
        end;
    end;
end;

function TPeFile.GetDebugDirectory: PImageDebugDirectory;
(*******************************************************************************)
begin
    Result := nil;
    if Is32Bit then
    begin
        if (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress <> 0) then
        begin
              Result := PImageDebugDirectory(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress));
        end;
    end else
    begin
        if (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress <> 0) then
        begin
              Result := PImageDebugDirectory(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress));
        end;
    end;
end;

function TPeFile.GetLoadConfigDirectory: PImageLoadConfigDirectory;
(*******************************************************************************)
begin
    Result := nil;
    if Is32Bit then
    begin
        if (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress <> 0) then
        begin
              Result := PImageLoadConfigDirectory(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress));
        end;
    end else
    begin
        if (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress <> 0) then
        begin
              Result := PImageLoadConfigDirectory(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress));
        end;
    end;
end;

function TPeFile.GetEntryExceptionDirectory: PImageRuntimeFunctionEntry;
(*******************************************************************************)
begin
    Result := nil;
    if Is32Bit then
    begin
        if (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress <> 0) then
        begin
              Result := PImageRuntimeFunctionEntry(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress));
        end;
    end else
    begin
        if (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress <> 0) then
        begin
              Result := PImageRuntimeFunctionEntry(NativeUInt(lpBuffer)+RvaToFileOffset(pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress));
        end;
    end;
end;

procedure TPeFile.GetResources(var Resources: TResources);
(*******************************************************************************)
var
  Table: PImageResourceDirectory;
  VA   : DWORD;
  TypCount, NameCountPublic: Integer;

  function WideCharToMultiByteEx(var lp: PWideChar): AnsiString;
  var
    len: Word;
  begin
      len := Word(lp^);
      SetLength(Result, len);
      Inc(lp);
      WideCharToMultiByte(CP_ACP, 0, lp, Len, PansiChar(Result), Len +1, nil, nil);
      Inc(lp, len);
      Result := PAnsiChar(Result);
  end;

  function GetResourceStr(IsResID: Boolean; IsType: Boolean; Addr: DWORD): String;
  var
    lpTmp: PWideChar;
    x: Word;
  begin
      if IsResID then
      begin
          if IsType then
          begin
              for x := 0 to Length(ResourceTypeDefaultNames) -1 do
              begin
                  if (MAKEINTRESOURCE(Addr) = MAKEINTRESOURCE(ResourceTypeDefaultNames[x].ResType)) then
                  begin
                      Result := ResourceTypeDefaultNames[x].ResTypeName;
                      Exit;
                  end;
              end;
          end;
        Str(Addr, Result);
      end else
      begin
          lpTmp  := PWideChar(NativeUInt(lpBuffer)+RvaToFileOffset(VA + (Addr and $7fffffff)));
          Result := string(WideCharToMultiByteEx(lpTmp));
      end;
  end;

  procedure ParseResources(Offset: DWORD; Level: Byte);
  var
    Table     : PImageResourceDirectory;
    Entry     : PImageResourceDirectoryEntry;
    EntryData : PImageResourceDataEntry;
    i, Count  : Integer;
    IsResID   : Boolean;
    NameCount,
    LangsCount: Integer;
  begin
      NameCount  := 0;
      LangsCount := 0;
      Table      := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(VA + Offset));
      Count      := Table^.NumberOfNamedEntries + Table^.NumberOfIdEntries;
      Entry      := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(VA + Offset + SizeOf(TImageResourceDirectory)));
      for i := 0 to Count -1 do
      begin
          IsResID := i >= Table^.NumberOfNamedEntries;
          case Level of
            0:
              begin
                  // Typen
                  NameCountPublic := 0;
                  SetLength(Resources.Entries, TypCount +1);
                  Resources.Entries[TypCount].sTyp := GetResourceStr(IsResId, True, Entry^.Name);
                  Inc(TypCount);
              end;
            1:
              begin
                  // Namen
                  SetLength(Resources.Entries[TypCount -1].NameEntries, NameCount +1);
                  Resources.Entries[TypCount -1].NameEntries[NameCount].sName := GetResourceStr(IsResId, False, Entry^.Name);
                  Inc(NameCount);
                  Inc(NameCountPublic);
              end;
            2:
              begin
                  // Langs
                  EntryData := PImageResourceDataEntry(NativeUInt(lpBuffer)+RvaToFileOffset(VA + Entry^.OffsetToData));
                  Resources.Entries[TypCount -1].NameEntries[(NameCountPublic-1) + LangsCount].sLang     := GetResourceStr(IsResId, False, Entry^.Name);
                  Resources.Entries[TypCount -1].NameEntries[(NameCountPublic-1) + LangsCount].lpData    := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(EntryData^.OffsetToData));
                  Resources.Entries[TypCount -1].NameEntries[(NameCountPublic-1) + LangsCount].dwDataRVA := EntryData^.OffsetToData;
                  Resources.Entries[TypCount -1].NameEntries[(NameCountPublic-1) + LangsCount].dwSize    := EntryData^.Size;
                  Inc(LangsCount);
              end;
          end;
          if (Entry^.OffsetToData and $80000000) > 0 then
            ParseResources(Entry^.OffsetToData and $7fffffff, Level +1);
          Inc(Entry);
      end;
  end;
begin
    if Is32Bit then
    begin
        if (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress <> 0) then
        begin
            TypCount := 0;
            VA := pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
            FillChar(Resources, SizeOf(TResources), #0);
            Table := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(VA));
            with Resources.Dir do
            begin
                Characteristics      := Table^.Characteristics;
                TimeDateStamp        := Table^.TimeDateStamp;
                MajorVersion         := Table^.MajorVersion;
                MinorVersion         := Table^.MinorVersion;
                NumberOfNamedEntries := Table^.NumberOfNamedEntries;
                NumberOfIdEntries    := Table^.NumberOfIdEntries;
            end;
            ParseResources(0, 0);
        end;
    end else
    begin
        if (pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress <> 0) then
        begin
            TypCount := 0;
            VA := pNtHeaders64^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
            FillChar(Resources, SizeOf(TResources), #0);
            Table := Pointer(NativeUInt(lpBuffer)+RvaToFileOffset(VA));
            with Resources.Dir do
            begin
                Characteristics      := Table^.Characteristics;
                TimeDateStamp        := Table^.TimeDateStamp;
                MajorVersion         := Table^.MajorVersion;
                MinorVersion         := Table^.MinorVersion;
                NumberOfNamedEntries := Table^.NumberOfNamedEntries;
                NumberOfIdEntries    := Table^.NumberOfIdEntries;
            end;
            ParseResources(0, 0);
        end;
    end;

end;

procedure TPeFile.CopyMemoryToBuffer(CopyToOffset: DWORD; Source: Pointer; Length: DWORD);
(*******************************************************************************)
begin
     CopyMemory(Pointer(NativeUInt(lpBuffer) + CopyToOffset), Source, Length);
end;

procedure TPeFile.CopyMemoryFromBuffer(CopyFromOffset: DWORD; Destination: Pointer; Length: DWORD);
(*******************************************************************************)
begin
     CopyMemory(Destination, Pointer(NativeUInt(lpBuffer) + CopyFromOffset), Length);
end;

function TPeFile.DumpSection(wSection: Word; sFilename: string): Boolean;
(*******************************************************************************)
var
  hFile: THandle;
  lpNumberOfBytesWritten: DWORD;
  lpBuff: Pointer;
begin
    Result := False;
    if (wSection <> High(Word)) then
    begin
      hFile := CreateFile(PChar(sFilename), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, 0, 0);
      if (hFile <> INVALID_HANDLE_VALUE) then
      begin
          lpBuff := Pointer(NativeUInt(lpBuffer) + ImageSections[wSection].PointerToRawData);
          WriteFile(hFile, lpBuff^, ImageSections[wSection].SizeOfRawData, lpNumberOfBytesWritten, nil);
          Result := lpNumberOfBytesWritten = ImageSections[wSection].SizeOfRawData;
          CloseHandle(hFile);
      end;
    end;
end;

function TPeFile.RecalcImageSize: DWORD;
(*******************************************************************************)
var
  x        : Word;
  ImageSize: DWORD;
begin
      if Is32Bit then
      begin
          if (pNtHeaders32^.OptionalHeader.SizeOfHeaders mod SectionAlign = 0) then
              ImageSize := pNtHeaders32^.OptionalHeader.SizeOfHeaders
          else
              ImageSize := Align(pNtHeaders32^.OptionalHeader.SizeOfHeaders, SectionAlign);
      end else
      begin
           if (pNtHeaders64^.OptionalHeader.SizeOfHeaders mod SectionAlign = 0) then
               ImageSize := pNtHeaders64^.OptionalHeader.SizeOfHeaders
           else
               ImageSize := Align(pNtHeaders64^.OptionalHeader.SizeOfHeaders, SectionAlign);
      end;

      for x := Low(ImageSections) to High(ImageSections) do
      begin
          if (ImageSections[x].Misc.VirtualSize mod SectionAlign = 0) then
            ImageSize := ImageSize + ImageSections[x].Misc.VirtualSize
          else
            ImageSize := ImageSize + Align(ImageSections[x].Misc.VirtualSize, SectionAlign);
      end;
      if Is32Bit then  pNtHeaders32^.OptionalHeader.SizeOfImage := ImageSize
      else             pNtHeaders64^.OptionalHeader.SizeOfImage := ImageSize;
      WriteImageSectionHeader;
      Result := ImageSize;
end;

function TPeFile.GetSectionHeaderBasedFileSize: DWORD;
(*******************************************************************************)
var
  x: Word;
begin
      Result := 0;
      for x := Low(ImageSections) to High(ImageSections) do
      begin
            if (ImageSections[x].PointerToRawData + ImageSections[x].SizeOfRawData > Result) then
              Result := ImageSections[x].PointerToRawData + ImageSections[x].SizeOfRawData;
      end;
end;

function TPeFile.GetSectionHeaderBasedSizeOfImage: DWORD;
(*******************************************************************************)
var
  x: Word;
begin
      Result := 0;
      for x := Low(ImageSections) to High(ImageSections) do
      begin
            if (ImageSections[x].VirtualAddress + ImageSections[x].Misc.VirtualSize > Result) then
              Result := ImageSections[x].VirtualAddress + ImageSections[x].Misc.VirtualSize;
      end;
end;

function TPeFile.GetDataFromEOF(var lpData: Pointer; var dwLength: Cardinal): Boolean;
(*******************************************************************************)
var
  dwHighestSize: DWORD;
begin
    Result := False;
    dwHighestSize := getSectionHeaderBasedFileSize;
    if (dwHighestSize <> 0) then
    begin
        dwLength := FFileSize - dwHighestSize;
        Result := (dwLength <> 0);
        if Result then
        begin
            GetMem(lpData, dwLength);
            CopyMemory(lpData, Pointer(NativeUInt(lpBuffer) + dwHighestSize), dwLength);
        end;
    end;
end;

function TPeFile.CalcCheckSum: DWORD;
  function CalcCheckSumWord: Word;
  var
    WordCount, Sum, x: DWORD;
    Ptr: PWord;
  begin
      Sum := 0;
      Ptr := PWord(NativeUInt(lpBuffer));
      WordCount := (FFileSize + 1) div SizeOf(Word);
      for x := 0 to WordCount -1 do
      begin
        Sum := Sum + Word(Ptr^);
        if (HiWord(Sum) <> 0) then
          Sum := LoWord(Sum) + HiWord(Sum);
        Inc(Ptr);
      end;
      Result := Word(LoWord(Sum) + HiWord(Sum));
  end;
var
  CalcSum, HeaderSum: DWORD;
begin
    CalcSum := CalcCheckSumWord;
    if Is32Bit then HeaderSum := pNtHeaders32^.OptionalHeader.CheckSum
    else            HeaderSum := pNtHeaders64^.OptionalHeader.CheckSum ;

    if (LoWord(CalcSum) >= LoWord(HeaderSum)) then
      CalcSum := CalcSum - LoWord(HeaderSum)
    else
      CalcSum := ((LoWord(CalcSum) - LoWord(HeaderSum)) and $ffff) -1;

    if (LoWord(CalcSum) >= HiWord(HeaderSum)) then
      CalcSum := CalcSum - HiWord(HeaderSum)
    else
      CalcSum := ((LoWord(CalcSum) - HiWord(HeaderSum)) and $ffff) -1;
    CalcSum := CalcSum + FFileSize;
    Result := CalcSum;
end;

function TPeFile.RecalcCheckSum: DWORD;
begin
     if Is32Bit then
     begin
          pNtHeaders32^.OptionalHeader.CheckSum := CalcCheckSum;
          Result := pNtHeaders32^.OptionalHeader.CheckSum;
     end else
     begin
          pNtHeaders64^.OptionalHeader.CheckSum := CalcCheckSum;
          Result := pNtHeaders64^.OptionalHeader.CheckSum;
     end;
end;

{
  Achtung:
    Man darf nicht einfach so eine Sektion vergrößern. Wenn man zum Beispiel
    die Code-Sektion vergrößern will und da gibt es zufälligerweise Befehle wie
    JMP DWORD PTR DS:[402004], dann darf man die Code-Sektion nicht vergrößern
    sonst zeigen die JMP's und CALL's auf falsche Addressen und das Programm stürzt
    einfach ab!
}
function TPeFile.ResizeSection(wSection: Word; Count: Cardinal): Boolean;
var
  x , y: Word;
  SectionOffset, SectionSize, FileAlign, SectionAlign, dwTemp: Cardinal;
  lpDirectoryEntries: array[0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES -1] of Byte;
  lpEOFData: Pointer;
  dwEOFDataLength: DWORD;
  {
    Diese prozedur ändert den OffsetToData in Ressourcen, damit die Ressourcen
    immer noch lesbar sind.
  }
  procedure RecalcResourceSection(VA, Add: DWORD);
    procedure ParseResources(Offset: DWORD; Level: Byte);
    var
      Table: PImageResourceDirectory;
      Entry: PImageResourceDirectoryEntry;
      EntryData: PImageResourceDataEntry;
      i, Count: Integer;
    begin
      Table := Pointer(RvaToVa(VA  + Offset));
      Count := Table^.NumberOfNamedEntries + Table^.NumberOfIdEntries;
      Entry := Pointer(RvaToVa(VA + Offset + SizeOf(TImageResourceDirectory)));
      for i := 0 to Count -1 do
      begin
        case Level of
          { Langs }
          2:
            begin
              EntryData := PImageResourceDataEntry(RvaToVa(VA + Entry^.OffsetToData));
              EntryData^.OffsetToData := EntryData^.OffsetToData + Add;
            end;
        end;
        if (Entry^.OffsetToData and $80000000) > 0 then
          ParseResources(Entry^.OffsetToData and $7fffffff, Level +1);
        Inc(Entry);
      end;
    end;
  begin
    if (pNtHeaders32^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress <> 0) then
    begin
      ParseResources(0, 0);
    end;
  end;
begin
  Result := False;
  FillChar(lpDirectoryEntries, SizeOf(lpDirectoryEntries), #0);
  if ((wSection < FNumberOfSections) and (wSection <> High(Word)) and (Count > 0)) then
  begin
    lpEOFData := nil;
    dwEOFDataLength := 0;
    GetDataFromEOF(lpEOFData, dwEOFDataLength);
    SectionOffset := ImageSections[wSection].PointerToRawData;
    SectionSize := ImageSections[wSection].SizeOfRawData;
    FileAlign := pNtHeaders32^.OptionalHeader.FileAlignment;
    SectionAlign := pNtHeaders32^.OptionalHeader.SectionAlignment;
    Count := Align(Count, FileAlign);
    // einfügen
    InsertBytes(SectionOffset + SectionSize, Count);
    // die größe der aktuellen sektion vergrößern
    ImageSections[wSection].SizeOfRawData := ImageSections[wSection].SizeOfRawData + Count;
    // wenn virtualsize kleiner ist als sizeofrawdata dann passen wir die größe natürlich an :)
    if (ImageSections[wSection].Misc.VirtualSize < ImageSections[wSection].SizeOfRawData) then
    begin
      ImageSections[wSection].Misc.VirtualSize := Align(ImageSections[wSection].SizeOfRawData, SectionAlign);
    end;
    // wenns unter der vorletzten sektion ist dann gehts los
    if (wSection < FNumberOfSections -1) then
    begin
      for x := wSection +1 to High(ImageSections) do
      begin
        // virtuelle addressen und größen anpassen!
        ImageSections[x].PointerToRawData := ImageSections[x].PointerToRawData + Count;
        ImageSections[x].Misc.VirtualSize := Align(ImageSections[x].Misc.VirtualSize + Count, SectionAlign);
      end;
      // virtuelle addresse von datadirectories ändern
      for x := wSection to High(ImageSections) do
      begin
        if (x < FNumberOfSections) then
        begin
          if ((ImageSections[x].VirtualAddress + ImageSections[x].Misc.VirtualSize) > ImageSections[x +1].VirtualAddress) then
          begin
            // alle directories durchlaufen und prüfen ob wir schon geupdatet haben
            // falls ja wird auf der "selben stelle" im array lpdirectoryentries ein <nonzero> wert stehen
            for y := 0 to IMAGE_NUMBEROF_DIRECTORY_ENTRIES -1 do
            begin
              if ((pNtHeaders32^.OptionalHeader.DataDirectory[y].VirtualAddress <> 0) and
                  (pNtHeaders32^.OptionalHeader.DataDirectory[y].Size <> 0)) then
              begin
                dwTemp := pNtHeaders32^.OptionalHeader.DataDirectory[y].VirtualAddress;
                if (dwTemp = ImageSections[x +1].VirtualAddress) then
                begin
                  if (lpDirectoryEntries[y] = 0) then
                  begin
                    pNtHeaders32^.OptionalHeader.DataDirectory[y].VirtualAddress := Align(ImageSections[x].VirtualAddress + ImageSections[x].Misc.VirtualSize, SectionAlign);
                    lpDirectoryEntries[y] := y +1;
                    if (y = IMAGE_DIRECTORY_ENTRY_RESOURCE) then
                    begin
                      // die OffsetToData bei den Resourcen ändern!
                      RecalcResourceSection(dwTemp, pNtHeaders32^.OptionalHeader.DataDirectory[y].VirtualAddress - dwTemp);
                    end;
                    Break;
                  end;
                end;
              end;
            end;
            // startaddresse der nächsten sektion ändern!
            ImageSections[x +1].VirtualAddress := Align(ImageSections[x].VirtualAddress + ImageSections[x].Misc.VirtualSize, SectionAlign);
          end;
        end; 
      end;
    end;
    RecalcImageSize;
    // noch am ende die EOF Daten kopieren
    if ((lpEOFData <> nil) and (dwEOFDataLength <> 0)) then
    begin
      // die größte/letzte sektion herausfinden
      CopyMemory(Pointer(Cardinal(lpBuffer) + getSectionHeaderBasedFileSize), lpEOFData, dwEOFDataLength);
      FreeMem(lpEOFData, dwEOFDataLength);
    end;
    RecalcCheckSum;
  end;
end;

end.
