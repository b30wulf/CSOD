object Form4: TForm4
  Left = 456
  Top = 198
  Width = 349
  Height = 279
  Caption = '����� OPC-�������'
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 58
    Width = 106
    Height = 13
    Caption = '����� OPC-�������:'
  end
  object ComboBox1: TComboBox
    Left = 136
    Top = 56
    Width = 185
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'ComboBox1'
  end
  object Button1: TButton
    Left = 64
    Top = 112
    Width = 76
    Height = 25
    Caption = '����������'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 112
    Width = 75
    Height = 25
    Caption = '������'
    TabOrder = 2
  end
end
