object Form1: TForm1
  Left = 307
  Top = 240
  Width = 630
  Height = 436
  Caption = 'Форма добавления и редактирования email-адресов для рассылки'
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 184
    Top = 352
    Width = 102
    Height = 13
    Caption = 'Прогресс рассылки'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 329
    Caption = 'ПЕРЕЧЕНЬ АДРЕСОВ'
    TabOrder = 0
    object emailListBox: TCheckListBox
      Left = 8
      Top = 16
      Width = 249
      Height = 305
      ItemHeight = 13
      TabOrder = 0
      OnClick = emailListBoxClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 272
    Top = 8
    Width = 233
    Height = 153
    Caption = 'ПОЛЕ РЕДАКТИРОВАНИЯ'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 152
      Height = 13
      Caption = 'Поле для ввода  email-адреса:'
    end
    object MailAddress: TEdit
      Left = 16
      Top = 48
      Width = 209
      Height = 21
      TabOrder = 0
      OnChange = MailAddressChange
    end
    object DeleteEmail: TButton
      Left = 32
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Удалить'
      TabOrder = 1
      OnClick = DeleteEmailClick
    end
    object AddEmail: TButton
      Left = 128
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Создать'
      TabOrder = 2
      OnClick = AddEmailClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 272
    Top = 168
    Width = 233
    Height = 89
    Caption = 'ТЕСТ РАССЫЛКИ'
    TabOrder = 2
    object Button3: TButton
      Left = 32
      Top = 32
      Width = 81
      Height = 25
      Caption = 'Рассылка'
      TabOrder = 0
      OnClick = Button3Click
    end
  end
  object ProgressBar1: TProgressBar
    Left = 72
    Top = 376
    Width = 337
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 272
    Top = 256
    Width = 233
    Height = 81
    TabOrder = 4
    Visible = False
  end
  object MES: TCheckBox
    Left = 512
    Top = 12
    Width = 97
    Height = 17
    Caption = 'МЭС'
    TabOrder = 5
    OnKeyPress = CheckBoxKeyPress
    OnMouseUp = CheckBoxMouseUp
  end
  object BES: TCheckBox
    Left = 512
    Top = 36
    Width = 97
    Height = 17
    Caption = 'БЭС'
    TabOrder = 6
    OnKeyPress = CheckBoxKeyPress
    OnMouseUp = CheckBoxMouseUp
  end
  object KES: TCheckBox
    Left = 512
    Top = 60
    Width = 97
    Height = 17
    Caption = 'КЭС'
    TabOrder = 7
    OnKeyPress = CheckBoxKeyPress
    OnMouseUp = CheckBoxMouseUp
  end
  object Timer1: TTimer
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 448
    Top = 344
  end
end
