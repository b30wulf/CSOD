object Form1: TForm1
  Left = 840
  Top = 124
  Width = 691
  Height = 564
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'View'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 80
    Width = 665
    Height = 441
    ItemHeight = 13
    TabOrder = 1
  end
  object Button2: TButton
    Left = 96
    Top = 8
    Width = 105
    Height = 25
    Caption = 'AddEvent'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 96
    Top = 40
    Width = 105
    Height = 25
    Caption = 'AddEventGroup'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 208
    Top = 8
    Width = 145
    Height = 25
    Caption = 'AddEventString'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 208
    Top = 40
    Width = 145
    Height = 25
    Caption = 'AddEventStringGroup'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 368
    Top = 8
    Width = 75
    Height = 25
    Caption = 'AddBLOB'
    TabOrder = 6
    OnClick = Button6Click
  end
end
