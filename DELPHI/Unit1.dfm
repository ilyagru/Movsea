object Form1: TForm1
  Left = 238
  Top = 171
  Caption = 'Form1'
  ClientHeight = 486
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 971
    Height = 486
    ActivePage = ts7
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      BorderWidth = 1
      Caption = 'Serv'
      object lbl1: TLabel
        Left = 240
        Top = 0
        Width = 16
        Height = 13
        Caption = 'lbl1'
      end
      object mmo1: TMemo
        Left = 16
        Top = 19
        Width = 497
        Height = 414
        Lines.Strings = (
          'mmo1')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btn2: TButton
        Left = 696
        Top = 84
        Width = 201
        Height = 25
        Caption = 'Start listen'
        TabOrder = 1
        OnClick = btn2Click
      end
      object lbledt4: TLabeledEdit
        Left = 696
        Top = 16
        Width = 121
        Height = 21
        EditLabel.Width = 10
        EditLabel.Height = 13
        EditLabel.Caption = 'IP'
        TabOrder = 2
      end
      object lbledt5: TLabeledEdit
        Left = 824
        Top = 16
        Width = 73
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'PORT'
        TabOrder = 3
      end
      object lbledt6: TLabeledEdit
        Left = 696
        Top = 56
        Width = 201
        Height = 21
        EditLabel.Width = 16
        EditLabel.Height = 13
        EditLabel.Caption = 'File'
        TabOrder = 4
        Text = '7717026'
      end
      object btn11: TButton
        Left = 696
        Top = 112
        Width = 201
        Height = 25
        Caption = 'Start Offline MovTask'
        TabOrder = 5
        OnClick = btn11Click
      end
      object btn12: TButton
        Left = 696
        Top = 143
        Width = 201
        Height = 25
        Caption = 'Start Offline Dot Task'
        TabOrder = 6
      end
      object lst1: TListBox
        Left = 688
        Top = 191
        Width = 201
        Height = 185
        ItemHeight = 13
        TabOrder = 7
      end
      object chk4: TCheckBox
        Left = 536
        Top = 18
        Width = 97
        Height = 17
        Caption = 'Use II'
        TabOrder = 8
      end
      object chk5: TCheckBox
        Left = 536
        Top = 41
        Width = 113
        Height = 17
        Caption = 'Use bitted Check'
        TabOrder = 9
      end
    end
    object ts2: TTabSheet
      Caption = 'Dots'
      ImageIndex = 1
      object btn3: TButton
        Left = 8
        Top = 48
        Width = 89
        Height = 25
        Caption = 'Load Left Dots'
        TabOrder = 0
        OnClick = btn3Click
      end
      object lbledt7: TLabeledEdit
        Left = 8
        Top = 24
        Width = 193
        Height = 21
        EditLabel.Width = 16
        EditLabel.Height = 13
        EditLabel.Caption = 'File'
        TabOrder = 1
        Text = 'F:\TestLib\Trash\Mov1\Some.txt'
      end
      object strngrd1: TStringGrid
        Left = 224
        Top = 8
        Width = 217
        Height = 369
        ColCount = 3
        FixedCols = 0
        FixedRows = 0
        TabOrder = 2
      end
      object strngrd2: TStringGrid
        Left = 456
        Top = 8
        Width = 217
        Height = 369
        ColCount = 3
        FixedCols = 0
        FixedRows = 0
        TabOrder = 3
      end
      object Edit1: TEdit
        Left = 256
        Top = 384
        Width = 121
        Height = 21
        TabOrder = 4
        Text = '0'
      end
      object Edit2: TEdit
        Left = 480
        Top = 384
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '0'
      end
      object btn4: TButton
        Left = 680
        Top = 40
        Width = 89
        Height = 25
        Caption = 'Load Right Dots'
        TabOrder = 6
        OnClick = btn4Click
      end
      object lbledt8: TLabeledEdit
        Left = 680
        Top = 16
        Width = 193
        Height = 21
        EditLabel.Width = 16
        EditLabel.Height = 13
        EditLabel.Caption = 'File'
        TabOrder = 7
        Text = 'F:\TestLib\Trash\Mov1\Some.txt'
      end
      object ud1: TUpDown
        Left = 377
        Top = 384
        Width = 40
        Height = 21
        Associate = Edit1
        Orientation = udHorizontal
        TabOrder = 8
      end
      object ud2: TUpDown
        Left = 601
        Top = 384
        Width = 40
        Height = 21
        Associate = Edit2
        Orientation = udHorizontal
        TabOrder = 9
      end
      object mmo2: TMemo
        Left = 16
        Top = 232
        Width = 177
        Height = 145
        Lines.Strings = (
          'mmo2')
        ScrollBars = ssVertical
        TabOrder = 10
      end
      object btn5: TButton
        Left = 16
        Top = 176
        Width = 75
        Height = 25
        Caption = 'Check'
        TabOrder = 11
        OnClick = btn5Click
      end
      object cbb1: TComboBox
        Left = 96
        Top = 184
        Width = 97
        Height = 21
        ItemIndex = 0
        TabOrder = 12
        Text = 'AB'
        Items.Strings = (
          'AB'
          'A'
          'B'
          'CenterW')
      end
      object btn13: TButton
        Left = 112
        Top = 48
        Width = 89
        Height = 25
        Caption = 'Save Left Dots'
        TabOrder = 13
        OnClick = btn13Click
      end
      object btn14: TButton
        Left = 784
        Top = 40
        Width = 89
        Height = 25
        Caption = 'Save Right Dots'
        TabOrder = 14
      end
      object Edit3: TEdit
        Left = 16
        Top = 208
        Width = 169
        Height = 21
        TabOrder = 15
        Text = '0'
      end
    end
    object ts3: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
      object lbledt9: TLabeledEdit
        Left = 16
        Top = 24
        Width = 153
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'Setting File'
        TabOrder = 0
      end
      object btn6: TButton
        Left = 16
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Load'
        TabOrder = 1
      end
      object grp1: TGroupBox
        Left = 8
        Top = 104
        Width = 185
        Height = 337
        Caption = 'Text DB'
        TabOrder = 2
        object btn19: TButton
          Left = 8
          Top = 16
          Width = 169
          Height = 25
          Caption = 'Open'
          TabOrder = 0
          OnClick = btn19Click
        end
      end
    end
    object ts4: TTabSheet
      Caption = 'Tester'
      ImageIndex = 3
      object img1: TImage
        Left = 176
        Top = 32
        Width = 640
        Height = 360
      end
      object lbledt10: TLabeledEdit
        Left = 8
        Top = 32
        Width = 161
        Height = 21
        EditLabel.Width = 16
        EditLabel.Height = 13
        EditLabel.Caption = 'File'
        TabOrder = 0
      end
      object btn7: TButton
        Left = 8
        Top = 56
        Width = 89
        Height = 25
        Caption = 'Load'
        TabOrder = 1
        OnClick = btn7Click
      end
      object btn8: TButton
        Left = 824
        Top = 320
        Width = 75
        Height = 25
        Caption = 'HashIt'
        TabOrder = 2
        OnClick = btn8Click
      end
      object btn9: TButton
        Left = 824
        Top = 352
        Width = 75
        Height = 25
        Caption = 'PrintDots'
        TabOrder = 3
        OnClick = btn9Click
      end
      object btn10: TButton
        Left = 104
        Top = 56
        Width = 65
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = btn10Click
      end
      object lbledt11: TLabeledEdit
        Left = 824
        Top = 40
        Width = 73
        Height = 21
        EditLabel.Width = 8
        EditLabel.Height = 13
        EditLabel.Caption = 'H'
        TabOrder = 5
        Text = '12'
      end
      object lbledt12: TLabeledEdit
        Left = 823
        Top = 80
        Width = 73
        Height = 21
        EditLabel.Width = 7
        EditLabel.Height = 13
        EditLabel.Caption = 'S'
        TabOrder = 6
        Text = '6'
      end
      object lbledt13: TLabeledEdit
        Left = 823
        Top = 120
        Width = 73
        Height = 21
        EditLabel.Width = 7
        EditLabel.Height = 13
        EditLabel.Caption = 'P'
        TabOrder = 7
        Text = '2,4'
      end
      object cbb2: TComboBox
        Left = 824
        Top = 152
        Width = 81
        Height = 21
        TabOrder = 8
        Text = 'cbb2'
      end
      object mmo3: TMemo
        Left = 8
        Top = 192
        Width = 161
        Height = 193
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -5
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'mmo3')
        ParentFont = False
        TabOrder = 9
      end
    end
    object ts5: TTabSheet
      Caption = 'Library'
      ImageIndex = 4
      object mmo4: TMemo
        Left = 712
        Top = 8
        Width = 185
        Height = 393
        Lines.Strings = (
          'mmo4')
        TabOrder = 0
      end
      object lbledt14: TLabeledEdit
        Left = 16
        Top = 16
        Width = 145
        Height = 21
        EditLabel.Width = 75
        EditLabel.Height = 13
        EditLabel.Caption = 'Library File Path'
        TabOrder = 1
        Text = 'F:\TestLib\LibHashes\'
      end
      object btn15: TButton
        Left = 168
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Load Index'
        TabOrder = 2
        OnClick = btn15Click
      end
      object ScrollBox1: TScrollBox
        Left = 24
        Top = 48
        Width = 449
        Height = 353
        VertScrollBar.Size = 2
        VertScrollBar.Style = ssFlat
        TabOrder = 3
      end
      object chk1: TCheckBox
        Left = 328
        Top = 16
        Width = 97
        Height = 25
        Caption = 'Check All'
        TabOrder = 4
        OnClick = chk1Click
      end
      object lbledt15: TLabeledEdit
        Left = 544
        Top = 40
        Width = 153
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'VideoSource'
        TabOrder = 5
        Text = 'F:\Temp\1\'
      end
      object btn17: TButton
        Left = 488
        Top = 32
        Width = 49
        Height = 25
        Caption = 'Prepare'
        TabOrder = 6
      end
      object btn20: TButton
        Left = 248
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Load Hashs'
        TabOrder = 7
        OnClick = btn20Click
      end
      object btn21: TButton
        Left = 488
        Top = 120
        Width = 209
        Height = 25
        Caption = 'Hash Folder to'
        TabOrder = 8
        OnClick = btn21Click
      end
      object Edit6: TEdit
        Left = 488
        Top = 152
        Width = 209
        Height = 21
        TabOrder = 9
        Text = 'F:\Temp\NewHash.txt'
      end
      object cbb5: TComboBox
        Left = 488
        Top = 176
        Width = 209
        Height = 21
        TabOrder = 10
        Text = 'cbb5'
        Items.Strings = (
          'Use nothing'
          'Matrix 2'
          'Matrix 3'
          'SQR 3')
      end
      object Edit7: TEdit
        Left = 488
        Top = 96
        Width = 209
        Height = 21
        TabOrder = 11
        Text = 'F:\Temp\1\ImgDir\'
      end
      object btn18: TButton
        Left = 488
        Top = 64
        Width = 209
        Height = 25
        Caption = 'Hash Video To'
        TabOrder = 12
        OnClick = btn18Click
      end
    end
    object ts7: TTabSheet
      Caption = #1048#1084#1080#1090#1072#1090#1086#1088
      ImageIndex = 6
      object lbledt18: TLabeledEdit
        Left = 16
        Top = 24
        Width = 161
        Height = 21
        EditLabel.Width = 38
        EditLabel.Height = 13
        EditLabel.Caption = 'FilePath'
        TabOrder = 0
        Text = 'Data\Temp\Videos\7717026.mov'
      end
      object btn22: TButton
        Left = 184
        Top = 24
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 1
      end
      object btn23: TButton
        Left = 215
        Top = 24
        Width = 75
        Height = 21
        Caption = 'Send'
        TabOrder = 2
        OnClick = btn23Click
      end
    end
    object ts8: TTabSheet
      Caption = 'Nodes'
      ImageIndex = 7
      object mmo5: TMemo
        Left = 712
        Top = 8
        Width = 185
        Height = 401
        Lines.Strings = (
          'mmo5')
        TabOrder = 0
      end
    end
    object ts9: TTabSheet
      Caption = 'ImageCompare'
      ImageIndex = 8
      object img3: TImage
        Left = 464
        Top = 32
        Width = 313
        Height = 177
      end
      object img4: TImage
        Left = 464
        Top = 272
        Width = 313
        Height = 177
      end
      object img2: TImage
        Left = 16
        Top = 32
        Width = 313
        Height = 177
        AutoSize = True
        Center = True
        Proportional = True
        Stretch = True
      end
      object img5: TImage
        Left = 16
        Top = 272
        Width = 313
        Height = 177
      end
      object lbl2: TLabel
        Left = 40
        Top = 208
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 536
        Top = 212
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl4: TLabel
        Left = 384
        Top = 176
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 384
        Top = 400
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl6: TLabel
        Left = 168
        Top = 208
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl7: TLabel
        Left = 384
        Top = 200
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl8: TLabel
        Left = 664
        Top = 212
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl9: TLabel
        Left = 384
        Top = 424
        Width = 29
        Height = 24
        Caption = 'lbl2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btn24: TButton
        Left = 336
        Top = 32
        Width = 121
        Height = 25
        Caption = 'Made'
        TabOrder = 0
        OnClick = btn24Click
      end
      object Edit4: TEdit
        Left = 16
        Top = 8
        Width = 217
        Height = 21
        TabOrder = 1
        Text = 'F:\1\5.jpg'
      end
      object btn25: TButton
        Left = 240
        Top = 8
        Width = 33
        Height = 21
        Caption = '...'
        TabOrder = 2
      end
      object btn26: TButton
        Left = 280
        Top = 8
        Width = 49
        Height = 21
        Caption = 'Load'
        TabOrder = 3
        OnClick = btn26Click
      end
      object btn28: TButton
        Left = 280
        Top = 240
        Width = 49
        Height = 21
        Caption = 'Load'
        TabOrder = 4
        OnClick = btn28Click
      end
      object btn27: TButton
        Left = 240
        Top = 240
        Width = 33
        Height = 21
        Caption = '...'
        TabOrder = 5
      end
      object Edit5: TEdit
        Left = 16
        Top = 240
        Width = 217
        Height = 21
        TabOrder = 6
        Text = 'F:\1\some1.jpg'
      end
      object cbb3: TComboBox
        Left = 336
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 7
        Text = 'Step'
        OnChange = cbb3Change
        Items.Strings = (
          '91 Step'
          '11 Eqalize 1 '
          '21 Normalize'
          '22 Sqr'
          '31 Matrix'
          '41 RED*'
          '42 GreenScale*'
          '43 Red* clear'
          '44 RGB* '
          '-51 Simple Binary'
          '-61 Bright Up'
          '-62 Bright To'
          '-63 Bright To Adaptive'
          '-64 Bright To Pic'
          '-71 ResizeSize')
      end
      object btn29: TButton
        Left = 336
        Top = 336
        Width = 121
        Height = 25
        Caption = 'Made'
        Enabled = False
        TabOrder = 8
      end
      object cbb4: TComboBox
        Left = 336
        Top = 368
        Width = 121
        Height = 21
        Enabled = False
        ItemIndex = 0
        TabOrder = 9
        Text = 'Eqalize 1'
        Items.Strings = (
          'Eqalize 1')
      end
      object btn31: TButton
        Left = 360
        Top = 272
        Width = 73
        Height = 25
        Caption = 'DrawDots'
        Enabled = False
        TabOrder = 10
      end
      object btn34: TButton
        Left = 360
        Top = 240
        Width = 75
        Height = 25
        Caption = 'CHeck'
        TabOrder = 11
        OnClick = btn34Click
      end
      object chk2: TCheckBox
        Left = 464
        Top = 8
        Width = 97
        Height = 17
        Caption = 'chk2'
        TabOrder = 12
      end
      object chk3: TCheckBox
        Left = 464
        Top = 248
        Width = 97
        Height = 17
        Caption = 'chk3'
        TabOrder = 13
      end
      object lbledt19: TLabeledEdit
        Left = 336
        Top = 104
        Width = 121
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'lbledt19'
        TabOrder = 14
      end
      object lbledt20: TLabeledEdit
        Left = 336
        Top = 144
        Width = 121
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'lbledt19'
        TabOrder = 15
      end
      object mmo6: TMemo
        Left = 784
        Top = 32
        Width = 185
        Height = 417
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'mmo6')
        ParentFont = False
        TabOrder = 16
      end
      object btn30: TButton
        Left = 528
        Top = 0
        Width = 97
        Height = 25
        Caption = 'SCREENSHOT'
        TabOrder = 17
        OnClick = btn30Click
      end
      object btn32: TButton
        Left = 632
        Top = 0
        Width = 81
        Height = 25
        Caption = 'Image Menu'
        TabOrder = 18
        OnClick = btn32Click
      end
      object btn33: TButton
        Left = 720
        Top = 0
        Width = 75
        Height = 25
        Caption = 'Script Menu'
        TabOrder = 19
        OnClick = btn33Click
      end
    end
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 8000
    Intercept = IdServerInterceptLogFile1
    ListenQueue = 5
    OnConnect = IdHTTPServer1Connect
    TerminateWaitTime = 100000
    Left = 736
    Top = 424
  end
  object IdHTTP1: TIdHTTP
    Intercept = IdLogFile1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 584
    Top = 424
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 828
    Top = 424
  end
  object dlgOpen1: TOpenDialog
    Left = 904
    Top = 424
  end
  object NodeServer: TIdHTTPServer
    Bindings = <>
    DefaultPort = 8001
    Left = 664
    Top = 424
  end
  object IdLogFile1: TIdLogFile
    LogTime = False
    Filename = 'templog.txt'
    Left = 908
    Top = 264
  end
  object IdServerInterceptLogFile1: TIdServerInterceptLogFile
    LogTime = False
    Filename = 'serverLog.txt'
    Left = 908
    Top = 208
  end
end
