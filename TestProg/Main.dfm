object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Nasm'
  ClientHeight = 632
  ClientWidth = 1005
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblNumLinee: TLabel
    Left = 516
    Top = 35
    Width = 44
    Height = 14
    Caption = 'Linee : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNumByte: TLabel
    Left = 684
    Top = 35
    Width = 42
    Height = 14
    Caption = 'Bytes :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTempo: TLabel
    Left = 824
    Top = 35
    Width = 37
    Height = 14
    Caption = 'Elab. :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 481
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Decompilazione di verifica:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 516
    Top = 540
    Width = 108
    Height = 13
    Caption = 'Addr Start(VA in Hex):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 505
    Width = 481
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Log:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnAsm: TButton
    Left = 963
    Top = 8
    Width = 34
    Height = 21
    Caption = '...'
    TabOrder = 0
    OnClick = btnAsmClick
  end
  object edtAsmFile: TEdit
    Left = 516
    Top = 8
    Width = 441
    Height = 21
    TabOrder = 1
  end
  object btnSaveAsm: TBitBtn
    Left = 888
    Top = 495
    Width = 109
    Height = 25
    Caption = 'Salva Codice'
    TabOrder = 2
    OnClick = btnSaveAsmClick
  end
  object btnDumpBIn: TBitBtn
    Left = 516
    Top = 495
    Width = 109
    Height = 25
    Caption = 'Code To Bin'
    TabOrder = 3
    OnClick = btnDumpBInClick
  end
  object btnBinToASm: TBitBtn
    Left = 631
    Top = 495
    Width = 109
    Height = 25
    Caption = 'Bin To Asm(NASM)'
    TabOrder = 4
    OnClick = btnBinToASmClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 521
    Width = 481
    Height = 103
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object chkBin: TCheckBox
    Left = 798
    Top = 562
    Width = 75
    Height = 17
    Caption = 'Cre Bin File'
    TabOrder = 6
  end
  object chkVisCode: TCheckBox
    Left = 663
    Top = 562
    Width = 97
    Height = 17
    Caption = 'Visualizza codice'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object rgTipoSintax: TRadioGroup
    Left = 888
    Top = 539
    Width = 109
    Height = 40
    Caption = 'Tipo Sintassi:'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'NASM'
      'MASM')
    TabOrder = 8
  end
  object edtAddr: TEdit
    Left = 516
    Top = 560
    Width = 141
    Height = 21
    Alignment = taCenter
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    Text = '000000013FD0DD88'
  end
  object lvAsm: TAdvListView
    Left = 516
    Top = 68
    Width = 481
    Height = 421
    Color = clCream
    Columns = <
      item
        Caption = 'Addr'
        Width = 100
      end
      item
        Caption = 'Bytes'
        Width = 200
      end
      item
        Caption = 'Cmd'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    RowSelect = True
    ParentFont = False
    TabOrder = 10
    ViewStyle = vsReport
    FilterTimeOut = 0
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = [fsBold]
    ProgressSettings.ValueFormat = '%d%%'
    DetailView.Font.Charset = DEFAULT_CHARSET
    DetailView.Font.Color = clBlue
    DetailView.Font.Height = -11
    DetailView.Font.Name = 'Tahoma'
    DetailView.Font.Style = []
    Version = '1.6.10.4'
  end
  object BitBtn1: TBitBtn
    Left = 773
    Top = 495
    Width = 109
    Height = 25
    Caption = 'Carica Codice'
    TabOrder = 11
    OnClick = BitBtn1Click
  end
  object cbDecAut: TCheckBox
    Left = 663
    Top = 539
    Width = 162
    Height = 17
    Caption = 'Decompila Automaticamente'
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object rgCPU: TRadioGroup
    Left = 888
    Top = 585
    Width = 109
    Height = 39
    Caption = 'x86/x64'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'x32'
      'x64')
    TabOrder = 13
  end
  object lstDecFile: TAdvListView
    Left = 8
    Top = 52
    Width = 481
    Height = 437
    Color = clCream
    Columns = <
      item
        Caption = 'Addr'
        Width = 100
      end
      item
        Caption = 'Bytes'
        Width = 200
      end
      item
        Caption = 'Cmd'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    RowSelect = True
    ParentFont = False
    TabOrder = 14
    ViewStyle = vsReport
    FilterTimeOut = 0
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = [fsBold]
    ProgressSettings.ValueFormat = '%d%%'
    DetailView.Font.Charset = DEFAULT_CHARSET
    DetailView.Font.Color = clBlue
    DetailView.Font.Height = -11
    DetailView.Font.Name = 'Tahoma'
    DetailView.Font.Style = []
    Version = '1.6.10.4'
  end
  object OpenDialog1: TOpenDialog
    InitialDir = 'D:\Applicazioni\CodeBlocks\test_pro\Nasm_Test\bin\debug'
    Left = 488
    Top = 16
  end
end
