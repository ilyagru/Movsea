object Form3: TForm3
  Left = 373
  Top = 83
  BorderStyle = bsSingle
  Caption = 'Scripter'
  ClientHeight = 487
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    672
    487)
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 0
    Top = 136
    Width = 233
    Height = 279
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 421
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    Text = 'TempScript.txt'
  end
  object btn1: TButton
    Left = 128
    Top = 421
    Width = 57
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Load'
    TabOrder = 2
    OnClick = btn1Click
  end
  object mmo2: TMemo
    Left = 394
    Top = 0
    Width = 278
    Height = 455
    Anchors = [akTop, akRight, akBottom]
    Lines.Strings = (
      'mmo2')
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object Edit2: TEdit
    Left = 397
    Top = 457
    Width = 196
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 4
    Text = 'TempRes.Txt'
  end
  object btn2: TButton
    Left = 597
    Top = 457
    Width = 65
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
    TabOrder = 5
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 240
    Top = 120
    Width = 145
    Height = 25
    Caption = 'Start'
    TabOrder = 6
    OnClick = btn3Click
  end
  object btn5: TButton
    Left = 240
    Top = 144
    Width = 145
    Height = 25
    Caption = 'Stop'
    TabOrder = 7
    OnClick = btn5Click
  end
  object lbledt20: TLabeledEdit
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = 'Param2'
    TabOrder = 8
  end
  object lbledt19: TLabeledEdit
    Left = 248
    Top = 48
    Width = 121
    Height = 21
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = 'Param1'
    TabOrder = 9
  end
  object cbb3: TComboBox
    Left = 248
    Top = 8
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 10
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
      '62 Bright To'
      '-61 Bright Up'
      '-63 Bright To Adaptive'
      '-64 Bright To Pic'
      '-71 ResizeSize')
  end
  object btn6: TButton
    Left = 184
    Top = 421
    Width = 49
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
    TabOrder = 11
    OnClick = btn6Click
  end
  object mmo3: TMemo
    Left = 0
    Top = 0
    Width = 233
    Height = 105
    Lines.Strings = (
      'mmo3')
    ScrollBars = ssVertical
    TabOrder = 12
  end
  object btn7: TButton
    Left = 184
    Top = 110
    Width = 49
    Height = 21
    Caption = 'Save'
    TabOrder = 13
    OnClick = btn7Click
  end
  object btn8: TButton
    Left = 128
    Top = 110
    Width = 57
    Height = 21
    Caption = 'Load'
    TabOrder = 14
    OnClick = btn8Click
  end
  object Edit3: TEdit
    Left = 8
    Top = 110
    Width = 121
    Height = 21
    TabOrder = 15
    Text = 'TempScript.txt'
  end
  object chk1: TCheckBox
    Left = 264
    Top = 208
    Width = 97
    Height = 17
    Caption = 'Sound'
    TabOrder = 16
  end
  object chk2: TCheckBox
    Left = 264
    Top = 224
    Width = 97
    Height = 17
    Caption = 'Clear'
    TabOrder = 17
  end
  object chk3: TCheckBox
    Left = 264
    Top = 240
    Width = 97
    Height = 17
    Caption = 'Save'
    TabOrder = 18
  end
  object lbledt1: TLabeledEdit
    Left = 8
    Top = 457
    Width = 233
    Height = 21
    Anchors = [akLeft, akBottom]
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Set path'
    TabOrder = 19
    Text = 'Sets\'
  end
  object chk4: TCheckBox
    Left = 272
    Top = 288
    Width = 97
    Height = 17
    Caption = 'PRELOAD'
    TabOrder = 20
  end
  object btn4: TButton
    Left = 256
    Top = 336
    Width = 89
    Height = 41
    Caption = 'Open Text DB'
    TabOrder = 21
    OnClick = btn4Click
  end
end
