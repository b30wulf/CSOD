object Prognoz: TPrognoz
  Left = 488
  Top = 113
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Прогноз расхода'
  ClientHeight = 270
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Tag = -1
    Left = 32
    Top = 48
    Width = 33
    Height = 13
    Caption = 'Лимит'
  end
  object Label2: TLabel
    Tag = -1
    Left = 32
    Top = 67
    Width = 43
    Height = 13
    Caption = 'Прогноз'
  end
  object Label3: TLabel
    Tag = -1
    Left = 33
    Top = 88
    Width = 36
    Height = 13
    Caption = 'Расход'
  end
  object Label4: TLabel
    Tag = -1
    Left = 32
    Top = 163
    Width = 33
    Height = 13
    Caption = 'Лимит'
  end
  object Label5: TLabel
    Tag = -1
    Left = 32
    Top = 182
    Width = 43
    Height = 13
    Caption = 'Прогноз'
  end
  object Label6: TLabel
    Tag = -1
    Left = 32
    Top = 200
    Width = 36
    Height = 13
    Caption = 'Расход'
  end
  object Label7: TLabel
    Tag = -1
    Left = 40
    Top = 24
    Width = 195
    Height = 20
    Caption = 'Активная энергия (кВт*ч)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Tag = -1
    Left = 32
    Top = 136
    Width = 221
    Height = 20
    Caption = 'Реактивная энергия (кВар*ч)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Tag = 131000
    Left = 216
    Top = 50
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label10: TLabel
    Tag = 131001
    Left = 217
    Top = 70
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label11: TLabel
    Tag = 131002
    Left = 217
    Top = 90
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label12: TLabel
    Tag = 131003
    Left = 218
    Top = 163
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label13: TLabel
    Tag = 131004
    Left = 218
    Top = 182
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label14: TLabel
    Tag = 131005
    Left = 218
    Top = 202
    Width = 6
    Height = 13
    Caption = '0'
  end
  object AdvProgressBar1: TAdvProgressBar
    Tag = 131000
    Left = 80
    Top = 48
    Width = 128
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1ColorTo = 13303807
    Level2Color = 5483007
    Level2ColorTo = 11064319
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Version = '1.2.0.0'
  end
  object AdvProgressBar2: TAdvProgressBar
    Tag = 131001
    Left = 80
    Top = 68
    Width = 128
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1ColorTo = 13303807
    Level2Color = 5483007
    Level2ColorTo = 11064319
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Version = '1.2.0.0'
  end
  object AdvProgressBar3: TAdvProgressBar
    Tag = 131002
    Left = 80
    Top = 88
    Width = 128
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1ColorTo = 13303807
    Level2Color = 5483007
    Level2ColorTo = 11064319
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Version = '1.2.0.0'
  end
  object AdvProgressBar4: TAdvProgressBar
    Tag = 131003
    Left = 80
    Top = 160
    Width = 128
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1ColorTo = 13303807
    Level2Color = 5483007
    Level2ColorTo = 11064319
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Version = '1.2.0.0'
  end
  object AdvProgressBar5: TAdvProgressBar
    Tag = 131004
    Left = 80
    Top = 180
    Width = 128
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1ColorTo = 13303807
    Level2Color = 5483007
    Level2ColorTo = 11064319
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Version = '1.2.0.0'
  end
  object AdvProgressBar6: TAdvProgressBar
    Tag = 131005
    Left = 80
    Top = 200
    Width = 128
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1ColorTo = 13303807
    Level2Color = 5483007
    Level2ColorTo = 11064319
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    ShowBorder = True
    Version = '1.2.0.0'
  end
end
