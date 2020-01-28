object TKnsMonitor: TTKnsMonitor
  Left = 791
  Top = 330
  BorderStyle = bsSingle
  Caption = 'Monitor V1'
  ClientHeight = 203
  ClientWidth = 229
  Color = clBtnFace
  Constraints.MaxHeight = 250
  Constraints.MaxWidth = 282
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnCreate = OnCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pass: TLabel
    Left = 20
    Top = 181
    Width = 38
    Height = 13
    Caption = 'Пароль'
  end
  object btnStart: TButton
    Left = 2
    Top = 1
    Width = 63
    Height = 25
    Caption = 'Запустить'
    TabOrder = 0
    OnClick = OnStart
  end
  object btnStop: TButton
    Left = 1
    Top = 26
    Width = 226
    Height = 25
    Caption = 'Закрыть программу ЦСОД'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = OnCloseProc
  end
  object edWMKonus: TEdit
    Left = 2
    Top = 73
    Width = 107
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object edWMReload: TEdit
    Left = 113
    Top = 73
    Width = 113
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object edWMElapsed: TEdit
    Left = 2
    Top = 96
    Width = 49
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object btnReStart: TButton
    Left = 136
    Top = 1
    Width = 91
    Height = 25
    Caption = 'Перезапустить'
    TabOrder = 5
    OnClick = btnReStartClick
  end
  object edUpdateState: TEdit
    Left = 113
    Top = 96
    Width = 113
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object lbElTime: TEdit
    Left = 53
    Top = 96
    Width = 57
    Height = 21
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 7
  end
  object btStop: TButton
    Left = 66
    Top = 1
    Width = 71
    Height = 25
    Caption = 'Остановиить'
    TabOrder = 8
    OnClick = btStopClick
  end
  object RestartProg: TEdit
    Left = 2
    Top = 50
    Width = 225
    Height = 21
    BiDiMode = bdLeftToRight
    Color = clScrollBar
    ParentBiDiMode = False
    ReadOnly = True
    TabOrder = 9
  end
  object writelog: TCheckBox
    Left = 2
    Top = 121
    Width = 145
    Height = 17
    Caption = 'Включить логирование'
    TabOrder = 10
  end
  object StartOpros: TCheckBox
    Left = 2
    Top = 139
    Width = 145
    Height = 17
    Caption = 'Автоматический опрос'
    TabOrder = 11
  end
  object User: TCheckBox
    Left = 2
    Top = 159
    Width = 103
    Height = 17
    Caption = 'Пользователь'
    TabOrder = 12
  end
  object UserName: TEdit
    Left = 112
    Top = 157
    Width = 113
    Height = 21
    TabOrder = 13
  end
  object Passw: TEdit
    Left = 112
    Top = 178
    Width = 113
    Height = 21
    TabOrder = 14
  end
end
