object Form1: TForm1
  Left = 258
  Top = 209
  Width = 982
  Height = 586
  Caption = 'Form1'
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
  object pnl1: TPanel
    Left = 152
    Top = 88
    Width = 648
    Height = 368
    Caption = 'pnl1'
    TabOrder = 0
    object img1: TImage
      Left = 4
      Top = 4
      Width = 640
      Height = 360
    end
  end
  object Edit1: TEdit
    Left = 24
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 24
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 24
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Edit4: TEdit
    Left = 24
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object Edit5: TEdit
    Left = 24
    Top = 224
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
  object Edit6: TEdit
    Left = 24
    Top = 256
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit2'
  end
  object btn1: TButton
    Left = 160
    Top = 472
    Width = 89
    Height = 25
    Caption = #1061#1077#1096
    TabOrder = 7
  end
  object btn2: TButton
    Left = 264
    Top = 472
    Width = 89
    Height = 25
    Caption = #1042#1099#1074#1077#1089#1090#1080
    TabOrder = 8
  end
  object Edit7: TEdit
    Left = 392
    Top = 56
    Width = 97
    Height = 21
    TabOrder = 9
    Text = '1'
  end
  object ud1: TUpDown
    Left = 489
    Top = 56
    Width = 40
    Height = 21
    Associate = Edit7
    Orientation = udHorizontal
    Position = 1
    TabOrder = 10
  end
  object btn3: TButton
    Left = 432
    Top = 464
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 11
    OnClick = btn3Click
  end
  object Edit8: TEdit
    Left = 512
    Top = 464
    Width = 233
    Height = 21
    TabOrder = 12
    Text = 'F:\A1.jpg'
  end
  object btn4: TButton
    Left = 752
    Top = 464
    Width = 49
    Height = 25
    Caption = '...'
    TabOrder = 13
  end
end
