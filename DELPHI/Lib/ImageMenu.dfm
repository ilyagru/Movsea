object Form2: TForm2
  Left = 661
  Top = 115
  BorderStyle = bsSingle
  Caption = 'Form2'
  ClientHeight = 212
  ClientWidth = 364
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
  object img1: TImage
    Left = 145
    Top = 88
    Width = 217
    Height = 122
  end
  object lst1: TListBox
    Left = 0
    Top = 0
    Width = 145
    Height = 209
    ItemHeight = 13
    Items.Strings = (
      'adad'
      'ad'
      'ada'
      'da'
      'da'
      'd'
      'ad'
      'a')
    TabOrder = 0
    OnMouseUp = lst1MouseUp
  end
  object btn1: TButton
    Left = 160
    Top = 0
    Width = 193
    Height = 25
    Caption = 'Load as Upper'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 161
    Top = 24
    Width = 192
    Height = 25
    Caption = 'Load as Down'
    TabOrder = 2
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 296
    Top = 56
    Width = 58
    Height = 25
    Caption = 'Search'
    TabOrder = 3
    OnClick = btn3Click
  end
  object Edit1: TEdit
    Left = 160
    Top = 56
    Width = 129
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
end
