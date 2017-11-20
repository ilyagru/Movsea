object Form4: TForm4
  Left = 769
  Top = 128
  BorderStyle = bsSingle
  Caption = 'Text DB'
  ClientHeight = 493
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btn3: TButton
    Left = 96
    Top = 376
    Width = 60
    Height = 25
    Caption = 'Redump as'
    TabOrder = 4
  end
  object btn2: TButton
    Left = 96
    Top = 400
    Width = 60
    Height = 25
    Caption = 'Save as'
    TabOrder = 3
  end
  object lst1: TListBox
    Left = 0
    Top = 0
    Width = 153
    Height = 233
    ItemHeight = 13
    TabOrder = 0
    OnMouseUp = lst1MouseUp
  end
  object mmo1: TMemo
    Left = 160
    Top = 0
    Width = 265
    Height = 489
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btn1: TButton
    Left = 96
    Top = 424
    Width = 60
    Height = 25
    Caption = 'Update'
    TabOrder = 2
  end
  object mmo2: TMemo
    Left = 0
    Top = 240
    Width = 153
    Height = 105
    Lines.Strings = (
      'mmo2')
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 0
    Top = 352
    Width = 153
    Height = 21
    TabOrder = 6
    Text = 'Edit1'
  end
  object btn4: TButton
    Left = 96
    Top = 448
    Width = 60
    Height = 25
    Caption = 'Delete'
    TabOrder = 7
  end
  object btn6: TButton
    Left = 8
    Top = 376
    Width = 81
    Height = 49
    Caption = 'ALL In One'
    TabOrder = 8
    OnClick = btn6Click
  end
end
