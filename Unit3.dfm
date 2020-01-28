object Form3: TForm3
  Left = 356
  Top = 129
  Width = 1374
  Height = 494
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Работа с OPC-сервером'
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelLog: TLabel
    Left = 932
    Top = 265
    Width = 155
    Height = 13
    Caption = 'Описание работы с сервером:'
  end
  object Label4: TLabel
    Left = 23
    Top = 21
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 673
    Height = 433
    Caption = 'Перечень тегов OPC-сервера'
    TabOrder = 0
    object MyStringGrid: TStringGrid
      Left = 8
      Top = 16
      Width = 657
      Height = 409
      ColCount = 4
      DefaultColWidth = 100
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 704
    Top = 24
    Width = 297
    Height = 121
    Caption = 'Добавление нового ТЕГА'
    TabOrder = 1
    object Label6: TLabel
      Left = 16
      Top = 32
      Width = 112
      Height = 13
      Caption = 'Наименование ТЕГА: '
    end
    object Edit1: TEdit
      Left = 136
      Top = 28
      Width = 137
      Height = 21
      TabOrder = 0
      Text = 'Write_TEG_Here'
    end
    object Button3: TButton
      Left = 56
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Добавить'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 152
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Удалить'
      TabOrder = 2
      OnClick = Button4Click
    end
    object Button6: TButton
      Left = 56
      Top = 88
      Width = 81
      Height = 25
      Caption = 'Сохранить OPC'
      TabOrder = 3
      OnClick = Button6Click
    end
  end
  object ListBox1: TListBox
    Left = 700
    Top = 281
    Width = 633
    Height = 161
    ItemHeight = 13
    TabOrder = 2
  end
  object GroupBox3: TGroupBox
    Left = 1008
    Top = 24
    Width = 353
    Height = 121
    Caption = 'Выбор и настройка OPC-сервера'
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 46
      Width = 106
      Height = 13
      Caption = 'Выбор OPC-сервера:'
    end
    object Label2: TLabel
      Left = 10
      Top = 20
      Width = 131
      Height = 13
      Caption = 'Название/IP компьютера'
    end
    object ComboBox1: TComboBox
      Left = 129
      Top = 42
      Width = 185
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'ComboBox1'
    end
    object Button2: TButton
      Left = 14
      Top = 89
      Width = 75
      Height = 25
      Caption = 'Подключить'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button5: TButton
      Left = 176
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Удалить'
      TabOrder = 2
      OnClick = Button5Click
    end
    object Button1: TButton
      Left = 94
      Top = 89
      Width = 75
      Height = 25
      Caption = 'Обновить '
      TabOrder = 3
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 152
      Top = 16
      Width = 161
      Height = 21
      TabOrder = 4
    end
    object ADDSERV: TButton
      Left = 256
      Top = 88
      Width = 65
      Height = 25
      Caption = 'ДОБАВИТЬ'
      TabOrder = 5
      OnClick = ADDSERVClick
    end
    object Edit3: TEdit
      Left = 128
      Top = 64
      Width = 185
      Height = 21
      TabOrder = 6
    end
  end
  object GroupBox4: TGroupBox
    Left = 704
    Top = 152
    Width = 633
    Height = 105
    Caption = 'Поиск'
    TabOrder = 4
    object Label3: TLabel
      Left = 23
      Top = 21
      Width = 57
      Height = 13
      Caption = 'Label3'
    end
    object Label5: TLabel
      Left = 23
      Top = 45
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Label7: TLabel
      Left = 25
      Top = 65
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object SearchGo: TButton
      Left = 256
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Поиск'
      TabOrder = 0
      OnClick = SearchGoClick
    end
    object SearchIn: TEdit
      Left = 112
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object VMIDOut: TEdit
      Left = 112
      Top = 39
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object UserOut: TEdit
      Left = 112
      Top = 61
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 1108
    Top = 297
  end
end
