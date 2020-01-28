object FrmMain: TFrmMain
  Left = 495
  Top = 142
  BorderStyle = bsToolWindow
  Caption = 'Программа управления НСИ (iButton) вер.2.1.U'
  ClientHeight = 468
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = GrUsersKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 244
    Height = 288
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 242
      Height = 44
      Align = alTop
      Caption = 'Действующий пароль'
      TabOrder = 0
      object EdOldPass: TEdit
        Left = 8
        Top = 15
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 0
        OnKeyUp = GrUsersKeyUp
      end
      object EdOldPassOfs: TSpinEdit
        Left = 152
        Top = 14
        Width = 81
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnKeyUp = GrUsersKeyUp
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 45
      Width = 242
      Height = 81
      Align = alTop
      Caption = 'Новый пароль'
      TabOrder = 1
      object EdPass: TEdit
        Left = 8
        Top = 49
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 0
        OnKeyUp = GrUsersKeyUp
      end
      object EdPassOfs: TSpinEdit
        Left = 152
        Top = 19
        Width = 81
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnKeyUp = GrUsersKeyUp
      end
      object BtnSetPass: TButton
        Left = 152
        Top = 50
        Width = 80
        Height = 22
        Caption = 'Уст. пароль'
        TabOrder = 2
        OnClick = BtnSetPassClick
        OnKeyUp = GrUsersKeyUp
      end
      object EdPass2: TEdit
        Left = 8
        Top = 19
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 3
        OnKeyUp = GrUsersKeyUp
      end
    end
    object Notebook1: TNotebook
      Left = 1
      Top = 126
      Width = 242
      Height = 161
      Align = alClient
      TabOrder = 2
      object TPage
        Left = 0
        Top = 0
        Caption = 'pu'
        object Label2: TLabel
          Left = 8
          Top = 65
          Width = 225
          Height = 62
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'Автоматизация - 2000'#13#10'Программа управления носителями '#13#10'секретно' +
            'й информации (НСИ)'#13#10'системы защиты данных АСКУЭ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clPurple
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Image1: TImage
          Left = 104
          Top = 20
          Width = 33
          Height = 33
          Transparent = True
          OnDblClick = Image1DblClick
        end
        object Label3: TLabel
          Left = 16
          Top = 128
          Width = 209
          Height = 25
          Alignment = taCenter
          AutoSize = False
          Caption = 'тел. +375 (17) 230 22 23'#13#10'тел. +375 (17) 230 58 98'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clPurple
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'pa'
        object BtnTestU: TSpeedButton
          Left = 13
          Top = 131
          Width = 212
          Height = 22
          Caption = 'Проверить пользователя'
          OnClick = BtnTestUClick
        end
        object Label1: TLabel
          Left = 90
          Top = 113
          Width = 38
          Height = 13
          Alignment = taRightJustify
          Caption = 'Пароль'
        end
        object Bevel1: TBevel
          Left = 8
          Top = 95
          Width = 225
          Height = 5
        end
        object EdLicDate: TDateTimePicker
          Left = 17
          Top = 13
          Width = 91
          Height = 21
          CalAlignment = dtaLeft
          Date = 37914.7127631944
          Time = 37914.7127631944
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 0
          OnKeyUp = GrUsersKeyUp
        end
        object EdTestUPass: TEdit
          Left = 133
          Top = 109
          Width = 90
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
          OnKeyUp = GrUsersKeyUp
        end
        object EdComment: TEdit
          Left = 17
          Top = 64
          Width = 210
          Height = 21
          MaxLength = 29
          TabOrder = 2
          Text = 'EdComment'
          OnKeyUp = GrUsersKeyUp
        end
        object RadioButton1: TRadioButton
          Tag = 1
          Left = 115
          Top = 11
          Width = 118
          Height = 17
          Caption = 'Срок не ограничен'
          Checked = True
          TabOrder = 3
          TabStop = True
          OnClick = RadioButton2Click
          OnKeyUp = GrUsersKeyUp
        end
        object RadioButton2: TRadioButton
          Tag = 2
          Left = 115
          Top = 29
          Width = 46
          Height = 17
          Caption = 'Срок'
          TabOrder = 4
          OnClick = RadioButton2Click
          OnKeyUp = GrUsersKeyUp
        end
        object RadioButton3: TRadioButton
          Tag = 3
          Left = 115
          Top = 46
          Width = 118
          Height = 17
          Caption = 'Демо версия'
          TabOrder = 6
          OnClick = RadioButton2Click
          OnKeyUp = GrUsersKeyUp
        end
        object EdLicPer: TSpinEdit
          Left = 166
          Top = 26
          Width = 57
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 100
          MinValue = -100
          ParentFont = False
          TabOrder = 5
          Value = 0
          OnKeyUp = GrUsersKeyUp
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 244
    Top = 0
    Width = 167
    Height = 288
    Align = alRight
    TabOrder = 1
    object BtnLoad: TSpeedButton
      Left = 9
      Top = 202
      Width = 145
      Height = 20
      Caption = 'Прочитать'
      NumGlyphs = 2
      OnClick = BtnLoadClick
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 165
      Height = 44
      Align = alTop
      Caption = 'Генерация ключа'
      TabOrder = 0
      object BtnSaveKey: TButton
        Left = 8
        Top = 15
        Width = 145
        Height = 23
        Caption = 'Изменить ключ'
        TabOrder = 0
        OnClick = BtnSaveKeyClick
        OnKeyUp = GrUsersKeyUp
      end
    end
    object GroupBox4: TGroupBox
      Left = 1
      Top = 45
      Width = 165
      Height = 82
      Align = alTop
      Caption = 'Таблица подстановки'
      TabOrder = 1
      object SpeedButton1: TSpeedButton
        Left = 8
        Top = 18
        Width = 145
        Height = 18
        GroupIndex = 1
        Down = True
        Caption = 'По умолчанию'
      end
      object SpeedButton2: TSpeedButton
        Tag = 1
        Left = 8
        Top = 37
        Width = 145
        Height = 18
        GroupIndex = 1
        Caption = 'Из файла'
        Enabled = False
      end
      object SpeedButton3: TSpeedButton
        Tag = 2
        Left = 8
        Top = 55
        Width = 145
        Height = 18
        GroupIndex = 1
        Caption = 'Из iButton'
        Enabled = False
      end
    end
    object BtnNew: TButton
      Left = 9
      Top = 223
      Width = 145
      Height = 20
      Caption = 'Создать новый'
      TabOrder = 2
      OnClick = BtnNewClick
      OnKeyUp = GrUsersKeyUp
    end
    object BtnStore: TButton
      Left = 9
      Top = 244
      Width = 145
      Height = 20
      Caption = 'Сохранить'
      TabOrder = 3
      OnClick = BtnStoreClick
      OnKeyUp = GrUsersKeyUp
    end
    object BtnCopy: TButton
      Left = 9
      Top = 265
      Width = 145
      Height = 20
      Caption = 'Сохранить на новый'
      TabOrder = 4
      OnClick = BtnCopyClick
      OnKeyUp = GrUsersKeyUp
    end
    object ch1: TRadioButton
      Left = 13
      Top = 184
      Width = 65
      Height = 17
      Caption = 'канал 1'
      Checked = True
      TabOrder = 5
      TabStop = True
      OnKeyUp = GrUsersKeyUp
    end
    object ch2: TRadioButton
      Left = 85
      Top = 184
      Width = 65
      Height = 17
      Caption = 'канал 2'
      TabOrder = 6
      OnKeyUp = GrUsersKeyUp
    end
    object PageControl1: TPageControl
      Left = 13
      Top = 129
      Width = 137
      Height = 54
      ActivePage = TabSheet2
      Style = tsButtons
      TabOrder = 7
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = 'RS232 (COM)'
        object EdPort: TSpinEdit
          Left = 72
          Top = -1
          Width = 41
          Height = 22
          MaxValue = 12
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = EdPortChange
          OnKeyUp = GrUsersKeyUp
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'USB'
        ImageIndex = 1
      end
    end
  end
  object GrUsers: TStringGrid
    Left = 0
    Top = 288
    Width = 411
    Height = 180
    Align = alBottom
    ColCount = 4
    DefaultColWidth = 30
    DefaultRowHeight = 18
    DefaultDrawing = False
    RowCount = 8
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
    TabOrder = 2
    OnDrawCell = GrUsersDrawCell
    OnGetEditText = GrUsersGetEditText
    OnKeyUp = GrUsersKeyUp
    OnMouseUp = GrUsersMouseUp
    OnSetEditText = GrUsersSetEditText
    RowHeights = (
      18
      18
      18
      18
      18
      18
      18
      18)
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 25
    Top = 150
  end
  object ImageList1: TImageList
    Left = 185
    Top = 134
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD007B7B7B00FFFF
      FF0000000000000000000000FF0000008400000084000000000000000000FFFF
      FF007B7B7B007B7B7B00000000000000000000000000BDBDBD007B7B7B00FFFF
      FF00000000000000000000FF000000840000008400000000000000000000FFFF
      FF007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00000000000000
      FF00000000000000FF00000084000000FF000000840000008400000000000000
      FF00000000007B7B7B00000000000000000000000000BDBDBD000000000000FF
      00000000000000FF00000084000000FF000000840000008400000000000000FF
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF000000FF000000FF000000840000000000FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF000000FF000000FF00000084000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      FF0000000000FFFFFF000000FF000000FF00000084000000FF00000000000000
      FF0000000000BDBDBD00000000000000000000000000FFFFFF000000000000FF
      000000000000FFFFFF0000FF000000FF00000084000000FF00000000000000FF
      000000000000BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000FF000000000000000000FFFF
      FF007B7B7B00BDBDBD00000000000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FF00000000000000000000FFFF
      FF007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF0000000000BDBD
      BD00BDBDBD000000000000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF0000000000BDBD
      BD00BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F83FF83F00000000
      E00FE00F00000000C007C0070000000080038003000000008003800300000000
      0001000100000000000100010000000000010001000000000001000100000000
      000100010000000080038003000000008003800300000000C007C00700000000
      E00FE00F00000000F83FF83F0000000000000000000000000000000000000000
      000000000000}
  end
  object ibList1: TibList
    Port = 1
    PortType = 0
    Left = 201
    Top = 166
  end
end
