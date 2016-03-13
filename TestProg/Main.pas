unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  NasmLib, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,System.Diagnostics,System.TimeSpan,
  System.Win.Crtl, Vcl.ComCtrls,  AdvListV;

type
  TfrmMain = class(TForm)
    OpenDialog1: TOpenDialog;
    btnAsm: TButton;
    edtAsmFile: TEdit;
    btnSaveAsm: TBitBtn;
    btnDumpBIn: TBitBtn;
    btnBinToASm: TBitBtn;
    Memo1: TMemo;
    lblNumLinee: TLabel;
    lblNumByte: TLabel;
    lblTempo: TLabel;
    chkBin: TCheckBox;
    chkVisCode: TCheckBox;
    rgTipoSintax: TRadioGroup;
    Label2: TLabel;
    edtAddr: TEdit;
    Label3: TLabel;
    lvAsm: TAdvListView;
    BitBtn1: TBitBtn;
    cbDecAut: TCheckBox;
    rgCPU: TRadioGroup;
    Label1: TLabel;
    lstDecFile: TAdvListView;
    BitBtn3: TBitBtn;
    procedure btnAsmClick(Sender: TObject);
    procedure btnSaveAsmClick(Sender: TObject);
    procedure btnDumpBInClick(Sender: TObject);
    procedure btnBinToASmClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    procedure ParserLogMsg(Severity: Integer; strMsg: string);
    procedure Decompila(buffer  : TArray<Byte> ;VAAddr: UInt64;bits : Byte );
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation
      uses
        Nasm_Def,
        Parser,
        untStdScan,
        untCrc64,
        CodeGen,
        uDisAsm,
        UnivDisasm.Disasm,
        untPeFile,
        DSiWin32,
        System.StrUtils;

{$R *.dfm}

procedure TfrmMain.ParserLogMsg(Severity : Integer; strMsg : string);
begin
     Memo1.Lines.Add(Format('Errore: %.8x  - %s',[Severity,strMsg]));
end;

//testcase	{ 0xc4, 0xe2, 0xe9, 0x92, 0x4c, 0x7d, 0x00			}, { vgatherdpd xmm1,QWORD [ebp+xmm7*2+0x0],xmm2	}
procedure Split(S, Delimiter: string; Strings: TStrings);
var
  P, OldP: integer;
  Token: string;
  count : Integer;
begin
    // Prevent any errors due to bogus parameters
    if (Strings = nil) or (Length(S) = 0) or (Length(Delimiter) = 0) then
        exit;

    P    := Pos(Delimiter, S);
    OldP := 1;
    count:= 0;
    while P > 0 do
    begin
        Token := Copy(S, OldP, P-OldP);
        Strings.Add(Token);

        Inc(count);

        OldP := P + 1;
        P := PosEx(Delimiter, S, OldP);

        if count >= 2 then
        begin
             P := 0;
             Break;
        end;

    end;
    if P = 0 then
       Strings.Add(Copy(S, OldP, Length(S)));
end;

procedure TfrmMain.btnSaveAsmClick(Sender: TObject);
begin
   lvAsm.SaveToFile('Codice__.txt')

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
    lvAsm.LoadFromFile('Codice__.txt')
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  sFile   : string;
  CG      : TCodeGen;
  AsmOut  : TTAssembled;
  BinArray: TArray<Byte> ;
  i,j     : Integer;
  StartOfs: UInt64;
begin
     OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName)+'\test';
     OpenDialog1.Filter     := 'Asm files (*.Asm)|*.ASM';
     if OpenDialog1.Execute then
     begin
          sfile := OpenDialog1.FileName;
     end;
     edtAsmFile.Text := sfile;

     if sFile = '' then Exit;

     if not FileExists(sFile)  then
     begin
          ShowMessage('file : '+ sfile+ 'non trovato' );
          Exit;
     end;

     if rgTipoSintax.ItemIndex = 0 then
        CG := TCodeGen.Create
     else
        CG := TCodeGen.Create(MASM_SYNTAX);
     CG.OnMsgLog     := ParserLogMsg;
     try
       CG.Assembly_File(sFile,AsmOut,StartOfs);

       for j := 0 to High(AsmOut) do
       begin
           for i := 0 to High(AsmOut[j].Bytes) do
           begin
                SetLength(binArray,Length(binArray)+1);
                binArray[High(binArray)] := AsmOut[j].Bytes[i];
           end;
       end;

       Decompila(binArray,StartOfs,CG.Bits);
     finally

     end;

end;

procedure TfrmMain.btnAsmClick(Sender: TObject);
var
  buffer : TOutCmdB;
  s,sFile: String;
  binArray : TArray<Byte>;

  linea    : AnsiString;
  bits     : Byte;
  i,x,pBits,
  pComm    : Integer;
  VAAddr   : Int64;

  tx  : TStreamReader;

  BinFile : TFileStream;

  pCmdAsm: TArray<AnsiString>;

  numBytes : Int64;
  numLinee : Int64;
  TempoPass : TStopwatch;
  macro : TStringList;
  list   : TListItem;

  CG     : TCodeGen;
begin
     OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName)+'\test';
     OpenDialog1.Filter     := 'Asm files (*.Asm)|*.ASM';
     if OpenDialog1.Execute then
     begin
          sfile := OpenDialog1.FileName;
     end;
     edtAsmFile.Text := sfile;

     if sFile = '' then Exit;

     if not FileExists(sFile)  then
     begin
          ShowMessage('file : '+ sfile+ 'non trovato' );
          Exit;
     end;

     if rgCpu.ItemIndex = 0 then bits := 32
     else                        bits := 64;

     Memo1.Lines.Clear;

     macro := TStringList.Create;
     tx    := TStreamReader.Create(sFile);
     try
       ///file to array
       SetLength(pCmdAsm,0);

       while not tx.EndOfStream do
       begin
           linea := tx.ReadLine;
           linea := StringReplace(linea, #9, ' ', [rfReplaceAll]);

           // macro testcase
           if Pos('testcase',Linea) > 0 then
           begin
               macro.Clear;
               Split(linea,'{',macro);
               if macro.Count < 2 then Continue;

               macro.Strings[1] := TrimRight(macro.Strings[1]);
               macro.Strings[2] := TrimRight(macro.Strings[2]);
               macro.Strings[1] := Copy(macro.Strings[1],1,Length(macro.Strings[1])-2);
               macro.Strings[2] := Copy(macro.Strings[2],1,Length(macro.Strings[2])-1);
               linea := macro.Strings[2];
               SetLength(pCmdAsm,Length(pCmdAsm)+1);
               pCmdAsm[High(pCmdAsm)] := linea;
               Continue;
           end;

           pBits := Pos('bits',LowerCase(Linea));
           pComm := Pos(';',LowerCase(Linea));

           if ( pBits > 0) and( (pComm = 0) or ( (pComm > 0) and (pComm > pBits) ) ) then
           begin
                if      (Pos('64',LowerCase(Linea)) > 0) then bits := 64
                else if (Pos('32',LowerCase(Linea)) > 0) then bits := 32
                else if (Pos('16',LowerCase(Linea)) > 0) then bits := 16
                else begin
                     ShowMessage('errore nello specificare numero bits programma');
                     Exit;
                end;
                SetLength(pCmdAsm,Length(pCmdAsm)+1);
                pCmdAsm[High(pCmdAsm)] := 'Bits '+ Inttostr(bits);
                Continue;
           end;

           if linea <> '' then
             linea := nasm_skip_spaces(@linea[1]);

           if (linea = '') then   Continue;
           if linea[1] = ';' then Continue;

           SetLength(pCmdAsm,Length(pCmdAsm)+1);
           pCmdAsm[High(pCmdAsm)] := linea;
       end;
     finally
         tx.Free;
         macro.Free
     end;

     if rgTipoSintax.ItemIndex = 0 then
        CG := TCodeGen.Create
     else
        CG := TCodeGen.Create(MASM_SYNTAX);
     CG.OnMsgLog     := ParserLogMsg;

     VAAddr := StrToInt64('$'+edtAddr.Text);

     SetLength(binArray,0);
     lvAsm.Items.Clear;
     lvAsm.Items.BeginUpdate;
     try
       numLinee := 0;
       numBytes := 0;

       TempoPass.Create;
       TempoPass.Start;
       for x := 0 to  High(pCmdAsm) do
       begin
           linea := pCmdAsm[x];
           pBits := Pos('bits',LowerCase(Linea));

           if  pBits > 0 then
           begin
                if      (Pos('64',LowerCase(Linea)) > 0) then bits := 64
                else if (Pos('32',LowerCase(Linea)) > 0) then bits := 32
                else if (Pos('16',LowerCase(Linea)) > 0) then bits := 16;
                Continue;
           end;

           Buffer := CG.Assemble_Cmd(VAAddr,@linea[1],bits);

           s := '';

           if Length(buffer) > 0 then
           begin
                VAAddr := VAAddr + Length(buffer);
                for i := 0 to High(buffer) do
                begin
                    if (chkBin.Checked) or (cbDecAut.Checked) then
                    begin
                        SetLength(binArray,Length(binArray)+1);
                        binArray[High(binArray)] := buffer[i];
                    end;
                    if chkVisCode.Checked then
                       s := s +  IntToHex(buffer[i],2);
                end;
                inc(numLinee);
                numBytes := numBytes + Length(buffer);
           end
           else s := ' errore';

           if chkVisCode.Checked then
           begin
                if (linea <> '') and (linea[1] <> ';') then
                begin
                    list         := lvAsm.Items.Add;
                    list.Caption := Format('%.8x:',[VAAddr-Length(buffer)]);
                    list.SubItems.Add(s);
                    list.SubItems.Add(linea);
                    linea := TrimLeft(linea);
                end;
           end;
       end;
       if chkBin.Checked then
       begin
           sFile := ChangeFileExt(sFile,'.bin') ;
           BinFile := TFileStream.Create(sFile,fmCreate);

           BinFile.Write(binArray[0],Length(binArray));

           BinFile.Free;
       end;

     finally
       lvAsm.Items.EndUpdate;
       CG.Free;
     end;
     TempoPass.Stop;
     lblTempo.Caption:= 'Elab.: '+FormatDateTime('hh:nn:ss.zzz', TempoPass.ElapsedMilliseconds / (SecsPerDay*1000.0)) ;

     lblNumLinee.Caption := 'Linee: '+IntToStr(numLinee);
     lblNumByte .Caption := 'Bytes: '+IntToStr(numBytes);

     if cbDecAut.Checked then
       Decompila(binArray,StrToUInt64('$'+edtAddr.Text),bits);
end;

procedure TfrmMain.Decompila(buffer  : TArray<Byte> ;VAAddr: UInt64;bits : Byte );
var
  DisAsm  : TDisAsm;
  list    : TListItem;
  len,i   : Integer;
  Count   : Uint64;
  bx86    : Boolean;
  P       : PByte;
  sBytes  : string;
begin
     if bits = 32 then  bx86 := True
     else               bx86 := False;

     DisAsm := TDisAsm.Create;

     P     := @buffer[0] ;

     Count := 0;
     lstDecFile.Items.Clear;
     lstDecFile.Items.BeginUpdate;
     try
       repeat
             sBytes := '';
             DisAsm.DisAssemble(P,not bx86 ,VAAddr);

             len := DisAsm.InsData.nsize;
                 if len <= 0 then len := 1;

             for i := 0 to len - 1 do
             begin
                  sBytes := sBytes + IntToHex(P[i],2);
             end;
             sBytes := sBytes + '       ';

              list         := lstDecFile.Items.Add;
              list.Caption := Format('%.8x:',[VAAddr]);
              list.SubItems.Add(sBytes);
              list.SubItems.Add(DisAsm.InsData.ins.InstStr);

             P       := DisAsm.InsData.ins.NextInst;
             Count   := Count  + len;
             VAAddr  := VAAddr + len;
       until Count > High(buffer);
     finally
       lstDecFile.Items.EndUpdate ;
     end;

end;

procedure TfrmMain.btnBinToASmClick(Sender: TObject);
var
  exitCode : Cardinal;
  Bits : Cardinal;
  fASmFile,sfile,app,workDir,sCmd : string;
begin
    OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName)+'\test';
    OpenDialog1.Filter     := 'Bin files (*.Bin)|*.BIN';
    if OpenDialog1.Execute then
     begin
          sfile := OpenDialog1.FileName;
     end;

     if not FileExists(sFile)  then
     begin
          ShowMessage('file : '+ sfile+ 'non trovato' );
          Exit;
     end;

    sCmd := 'cmd.exe /c ';
    workDir  := ExtractFileDir(sfile);

    fASmFile := ChangeFileExt(sfile,'.Asm') ;
    fASmFile := ExtractFileName(fASmFile);

    sFile := ExtractFileName(sFile);

    app := workDir+ '\nDisAsm.Exe' ;
    if not FileExists(app)  then
    begin
          ShowMessage('file : '+ sfile+ 'non trovato' );
          Exit;
    end;

   if MessageBox(0,'Imposto a 64 bit?','Scelta Bit',MB_YESNO) = mrYes then  Bits := 64
   else                                                                     Bits := 32;
   app := 'nDisAsm.Exe '+' '+ '-b '+ IntToStr(Bits) ;
   DSiExecuteAndCapture(sCmd + app+ ' ' + sfile + ' > '+ fASmFile, Memo1.Lines, WorkDir,exitcode);

   ShowMessage('Operazione completata')

end;

procedure TfrmMain.btnDumpBInClick(Sender: TObject);
var
  sFile  : string;
  winFile : TPeFile;
begin
     OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName)+'\test';
     if OpenDialog1.Execute then
     begin
          sfile := OpenDialog1.FileName;
     end;
     edtAsmFile.Text := sfile;

     if sFile = '' then Exit;

     if not FileExists(sFile)  then
     begin
          ShowMessage('file : '+ sfile+ 'non trovato' );
          Exit;
     end;

     winFile := TPeFile.Create;
     winFile.LoadFromFile(sFile);
     winFile.DumpSection(winFile.GetCodeSection,ChangeFileExt(sFile,'.bin'));
end;

end.
