object TL5Config: TTL5Config
  Left = 338
  Top = 170
  Width = 875
  Height = 560
  Caption = 'Настройки'
  Color = clBtnFace
  Constraints.MaxHeight = 560
  Constraints.MaxWidth = 875
  Constraints.MinHeight = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = OnCloseConf
  OnCreate = OnCreateForm
  OnResize = OnFormResize1
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 794
    Top = 97
    Width = 3
    Height = 14
    Anchors = [akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 0
    Width = 190
    Height = 504
    Align = alLeft
    BevelOuter = bvNone
    Color = 13616833
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = 16765615
    Caption.Color = 12105910
    Caption.ColorTo = 10526878
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWhite
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 12958644
    ColorMirror = 12958644
    ColorMirrorTo = 15527141
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWhite
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 10592158
    StatusBar.ColorTo = 5459275
    StatusBar.GradientDirection = gdVertical
    Styler = AdvPanelStyler1
    FullHeight = 0
    object lbGenSettings: TLabel
      Left = 5
      Top = 11
      Width = 90
      Height = 19
      Alignment = taCenter
      BiDiMode = bdRightToLeftReadingOnly
      Caption = 'Automation 2k'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Transparent = True
    end
    object FTreeModuleData: TTreeView
      Left = 0
      Top = 0
      Width = 190
      Height = 504
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clAqua
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      Indent = 19
      ParentFont = False
      RightClickSelect = True
      TabOrder = 0
      Visible = False
      OnClick = OnClickQweryTree
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 504
    Width = 867
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Color = 13616833
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = 16765615
    Caption.Color = 12105910
    Caption.ColorTo = 10526878
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWhite
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 12958644
    ColorMirror = 12958644
    ColorMirrorTo = 15527141
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWhite
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 10592158
    StatusBar.ColorTo = 5459275
    StatusBar.GradientDirection = gdVertical
    Styler = AdvPanelStyler1
    FullHeight = 0
    object lbBottInfo: TLabel
      Left = 382
      Top = 3
      Width = 79
      Height = 15
      Anchors = [akLeft]
      Caption = 'Automation 2k'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbEnter: TLabel
      Left = 570
      Top = 3
      Width = 73
      Height = 14
      Anchors = [akRight]
      Caption = 'Текущее время'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbPeriod: TLabel
      Left = 724
      Top = 3
      Width = 36
      Height = 14
      Anchors = [akRight]
      Caption = 'Период'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object dtQryPicker: TDateTimePicker
      Left = 647
      Top = -1
      Width = 73
      Height = 22
      Hint = 'Выбор срезов для одного дня'
      Anchors = [akRight]
      CalAlignment = dtaRight
      Date = 40300.7711754861
      Time = 40300.7711754861
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      Kind = dtkTime
      ParseInput = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object cbQryPeriod: TComboBox
      Left = 766
      Top = -1
      Width = 97
      Height = 22
      Style = csDropDownList
      Anchors = [akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 1
      Items.Strings = (
        'Сумма По Тарифам'
        '1 Тариф'
        '2 Тариф'
        '3 Тариф'
        '4 Тариф')
    end
  end
  object pgGenSettings: TAdvOfficePager
    Left = 190
    Top = 0
    Width = 677
    Height = 504
    AdvOfficePagerStyler = AdvOfficePagerOfficeStyler1
    Align = alClient
    ActivePage = TabSheet2
    ButtonSettings.CloseButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001000001010100000100
      0000000202000100020200000000000202020002020200000000010002020202
      0200010000000101000202020001010000000100020202020200010000000002
      0202000202020000000000020200010002020000000001000001010100000100
      0000}
    ButtonSettings.PageListButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000101010100
      0000010101000200010101000000010100020202000101000000010002020202
      0200010000000002020200020202000000000002020001000202000000000100
      0001010100000100000001010101010101010100000001010101010101010100
      0000}
    ButtonSettings.ScrollButtonPrevPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000001010100
      0000010101000202000101000000010100020202000101000000010002020200
      0101010000000002020200010101010000000100020202000101010000000101
      0002020200010100000001010100020200010100000001010101000001010100
      0000}
    ButtonSettings.ScrollButtonNextPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010000010101010100
      0000010002020001010101000000010002020200010101000000010100020202
      0001010000000101010002020200010000000101000202020001010000000100
      0202020001010100000001000202000101010100000001010000010101010100
      0000}
    ButtonSettings.CloseButtonHint = 'Close'
    ButtonSettings.PageListButtonHint = 'Page List'
    ButtonSettings.ScrollButtonsAlways = True
    ButtonSettings.ScrollButtonNextHint = 'Next'
    ButtonSettings.ScrollButtonPrevHint = 'Previous'
    TabSettings.StartMargin = 4
    TabSettings.Shape = tsRightRamp
    TabReorder = False
    ShowShortCutHints = False
    OnChange = OnChandgeSett
    TabOrder = 5
    NextPictureChanged = False
    PrevPictureChanged = False
    object tbGenSetiings: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 675
      Height = 476
      Caption = 'Основные'
      ImageIndex = 0
      PageAppearance.BorderColor = 11841710
      PageAppearance.Color = 13616833
      PageAppearance.ColorTo = 12958644
      PageAppearance.ColorMirror = 12958644
      PageAppearance.ColorMirrorTo = 15527141
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabAppearance.BorderColor = clNone
      TabAppearance.BorderColorHot = 9870494
      TabAppearance.BorderColorSelected = 14922381
      TabAppearance.BorderColorSelectedHot = 6343929
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = clNone
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 15724269
      TabAppearance.ColorSelectedTo = 15724269
      TabAppearance.ColorDisabled = clWhite
      TabAppearance.ColorDisabledTo = clSilver
      TabAppearance.ColorHot = 5992568
      TabAppearance.ColorHotTo = 9803415
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 4413279
      TabAppearance.ColorMirrorHotTo = 1617645
      TabAppearance.ColorMirrorSelected = 13816526
      TabAppearance.ColorMirrorSelectedTo = 13816526
      TabAppearance.ColorMirrorDisabled = clWhite
      TabAppearance.ColorMirrorDisabledTo = clSilver
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggRadial
      TabAppearance.GradientMirrorHot = ggRadial
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clWhite
      TabAppearance.TextColorHot = clWhite
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clBlack
      TabAppearance.HighLightColor = 9803929
      TabAppearance.HighLightColorHot = 9803929
      TabAppearance.HighLightColorSelected = 6540536
      TabAppearance.HighLightColorSelectedHot = 12451839
      TabAppearance.HighLightColorDown = 16776144
      TabAppearance.BackGround.Color = 5460819
      TabAppearance.BackGround.ColorTo = 3815994
      TabAppearance.BackGround.Direction = gdVertical
      object GroupBox1: TGroupBox
        Left = 2
        Top = 33
        Width = 671
        Height = 441
        Align = alClient
        Caption = 'Параметры приложения'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label3: TLabel
          Left = 9
          Top = 73
          Width = 77
          Height = 13
          Caption = 'Режим работы:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 9
          Top = 120
          Width = 94
          Height = 13
          Caption = 'Автосжатие базы:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 9
          Top = 144
          Width = 134
          Height = 13
          Caption = 'Период автосжатия базы:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 9
          Top = 191
          Width = 125
          Height = 13
          Caption = 'Период сохр протокола:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 9
          Top = 215
          Width = 137
          Height = 13
          Caption = 'Период опраш. счетчиков:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 9
          Top = 168
          Width = 139
          Height = 13
          Caption = 'Глубина хранения данных:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 9
          Top = 49
          Width = 48
          Height = 13
          Caption = 'IP Адрес:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 9
          Top = 96
          Width = 81
          Height = 13
          Caption = 'Режим доступа:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 9
          Top = 27
          Width = 97
          Height = 13
          Caption = 'Название проекта:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 9
          Top = 262
          Width = 114
          Height = 13
          Caption = 'Лимит мощности(кВт):'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 9
          Top = 286
          Width = 152
          Height = 13
          Caption = 'Процент прев. лим. мощн(%):'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 9
          Top = 239
          Width = 154
          Height = 13
          Caption = 'Предварит-й опрос графиков:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 9
          Top = 310
          Width = 60
          Height = 13
          Caption = 'Тип опроса:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 9
          Top = 334
          Width = 137
          Height = 13
          Caption = 'Автосворач. при загрузке:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 281
          Top = 96
          Width = 177
          Height = 13
          Caption = 'Запускать опрос после включения'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 281
          Top = 73
          Width = 94
          Height = 13
          Caption = 'Размещение базы:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 281
          Top = 192
          Width = 124
          Height = 13
          Caption = 'Направление коррекции'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 281
          Top = 215
          Width = 108
          Height = 13
          Caption = 'Задержка коррекции'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label30: TLabel
          Left = 281
          Top = 120
          Width = 94
          Height = 13
          Caption = 'Выгрузка данных:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label31: TLabel
          Left = 281
          Top = 409
          Width = 155
          Height = 13
          Caption = 'Разовая выгрузка данных за :'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label32: TLabel
          Left = 589
          Top = 410
          Width = 22
          Height = 14
          Caption = 'сут.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label33: TLabel
          Left = 589
          Top = 195
          Width = 23
          Height = 14
          Caption = 'сек.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 281
          Top = 239
          Width = 168
          Height = 13
          Caption = 'Internet синхронизация времени:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label35: TLabel
          Left = 281
          Top = 287
          Width = 166
          Height = 13
          Caption = 'Название модемного соединеня:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 281
          Top = 334
          Width = 137
          Height = 13
          Caption = 'Задержка синхронизации: '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label36: TLabel
          Left = 281
          Top = 263
          Width = 109
          Height = 13
          Caption = 'Использовать модем:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label37: TLabel
          Left = 589
          Top = 337
          Width = 23
          Height = 14
          Caption = 'сек.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 281
          Top = 311
          Width = 114
          Height = 13
          Caption = 'Канал синхронизации:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 9
          Top = 358
          Width = 174
          Height = 13
          Caption = 'Переход на зимнене время и обр.:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 281
          Top = 168
          Width = 162
          Height = 13
          Caption = 'Направление экспорта данных:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 281
          Top = 49
          Width = 48
          Height = 13
          Caption = 'IP Маска:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label57: TLabel
          Left = 384
          Top = 363
          Width = 131
          Height = 13
          Caption = 'Кол-во знаков в расходе:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label59: TLabel
          Left = 281
          Top = 142
          Width = 122
          Height = 13
          Caption = 'Период поиска данных:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label66: TLabel
          Left = 433
          Top = 49
          Width = 47
          Height = 13
          Caption = 'IP Шлюз:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label67: TLabel
          Left = 281
          Top = 385
          Width = 100
          Height = 13
          Caption = 'Время соединения: '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbSExpired: TLabel
          Left = 589
          Top = 385
          Width = 23
          Height = 14
          Caption = 'сек.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label62: TLabel
          Left = 9
          Top = 405
          Width = 135
          Height = 13
          Caption = 'Время активности сессии: '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label64: TLabel
          Left = 9
          Top = 382
          Width = 122
          Height = 13
          Caption = 'Активность календаря:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cbm_sbyMode: TComboBox
          Left = 182
          Top = 70
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
        end
        object cbm_sbyAutoPack: TComboBox
          Left = 182
          Top = 118
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
        end
        object cbm_sStorePeriod: TComboBox
          Left = 182
          Top = 142
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
        end
        object cbm_sStoreProto: TComboBox
          Left = 182
          Top = 190
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
        end
        object cbm_sPoolPeriod: TComboBox
          Left = 182
          Top = 214
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
        end
        object cbm_sStoreClrTime: TComboBox
          Left = 182
          Top = 166
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 5
        end
        object cbm_sbyLocation: TComboBox
          Left = 182
          Top = 94
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 6
          OnChange = OnChandgerEMmODE
        end
        object edm_sProjectName: TEdit
          Left = 182
          Top = 21
          Width = 403
          Height = 21
          TabOrder = 7
        end
        object edm_sPowerLimit: TEdit
          Left = 182
          Top = 261
          Width = 81
          Height = 21
          TabOrder = 8
        end
        object sem_sPowerLimit: TSpinEdit
          Left = 182
          Top = 284
          Width = 81
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object cbm_sPrePoolGraph: TComboBox
          Left = 182
          Top = 238
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 10
        end
        object cbm_sQryScheduler: TComboBox
          Left = 128
          Top = 308
          Width = 135
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 11
          OnChange = OnChandgeQueryMode
        end
        object cbm_sAutoTray: TComboBox
          Left = 182
          Top = 332
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 12
        end
        object sem_sPrecise: TSpinEdit
          Left = 537
          Top = 357
          Width = 49
          Height = 22
          MaxValue = 5
          MinValue = 3
          TabOrder = 13
          Value = 3
        end
        object sem_sPreciseExpense: TSpinEdit
          Left = 592
          Top = 37
          Width = 45
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 14
          Value = 0
          Visible = False
        end
        object cbm_sBaseLocation: TComboBox
          Left = 496
          Top = 69
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 15
        end
        object cbm_sCorrDir: TComboBox
          Left = 472
          Top = 190
          Width = 114
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 16
        end
        object edm_sKorrDelay: TEdit
          Left = 537
          Top = 214
          Width = 49
          Height = 21
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 17
          Text = '0.0'
        end
        object cbm_sSetForETelecom: TComboBox
          Left = 496
          Top = 118
          Width = 91
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 18
          OnChange = OnChandgeExport
        end
        object sem_sExport: TSpinEdit
          Left = 496
          Top = 406
          Width = 48
          Height = 22
          MaxValue = 60
          MinValue = 1
          TabOrder = 19
          Value = 10
          Visible = False
        end
        object rbm_sButtExport: TRbButton
          Left = 544
          Top = 406
          Width = 42
          Height = 22
          Visible = False
          OnClick = OnSaveEnergoData
          TabOrder = 20
          TextShadow = True
          Caption = '...'
          ModalResult = 0
          Spacing = 2
          Layout = blGlyphLeft
          Colors.DefaultFrom = clWhite
          Colors.DefaultTo = 13745839
          Colors.OverFrom = clWhite
          Colors.OverTo = 12489846
          Colors.ClickedFrom = 13029334
          Colors.ClickedTo = 15463415
          Colors.HotTrack = clBlue
          Colors.BorderColor = clGray
          Colors.TextShadow = clWhite
          FadeSpeed = fsMedium
          ShowFocusRect = True
          HotTrack = False
          GradientBorder = True
        end
        object cbm_sInterSet: TComboBox
          Left = 520
          Top = 238
          Width = 67
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 21
          OnChange = OnChsynchro
        end
        object edm_sMdmJoinName: TEdit
          Left = 472
          Top = 286
          Width = 114
          Height = 21
          TabOrder = 22
        end
        object cbm_sUseModem: TComboBox
          Left = 520
          Top = 262
          Width = 67
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 23
          OnChange = OnChModem
        end
        object edm_sInterDelay: TEdit
          Left = 537
          Top = 334
          Width = 49
          Height = 21
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 24
          Text = '0.0'
        end
        object GroupBox3: TGroupBox
          Left = 272
          Top = 184
          Width = 124
          Height = 8
          TabOrder = 25
        end
        object GroupBox4: TGroupBox
          Left = 272
          Top = 112
          Width = 124
          Height = 8
          TabOrder = 26
        end
        object GroupBox5: TGroupBox
          Left = 272
          Top = 64
          Width = 121
          Height = 8
          TabOrder = 27
        end
        object GroupBox6: TGroupBox
          Left = 272
          Top = 352
          Width = 124
          Height = 8
          TabOrder = 28
        end
        object GroupBox7: TGroupBox
          Left = 6
          Top = 302
          Width = 115
          Height = 8
          TabOrder = 29
        end
        object GroupBox8: TGroupBox
          Left = 6
          Top = 255
          Width = 124
          Height = 8
          TabOrder = 30
        end
        object GroupBox9: TGroupBox
          Left = 6
          Top = 183
          Width = 124
          Height = 8
          TabOrder = 31
        end
        object GroupBox10: TGroupBox
          Left = 6
          Top = 64
          Width = 124
          Height = 8
          TabOrder = 32
        end
        object GroupBox11: TGroupBox
          Left = 6
          Top = 111
          Width = 124
          Height = 8
          TabOrder = 33
        end
        object cbm_sChannSyn: TComboBox
          Left = 520
          Top = 310
          Width = 67
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 34
          OnChange = OnChModem
          OnDropDown = OnDropSunChan1
        end
        object cbAllowInDConn: TCheckBox
          Left = 281
          Top = 362
          Width = 96
          Height = 17
          Caption = 'Откл.вх.соед'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 35
        end
        object cbm_sTransTime: TComboBox
          Left = 182
          Top = 356
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 36
        end
        object cbm_ChooseEnergo: TComboBox
          Left = 472
          Top = 166
          Width = 114
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 37
        end
        object cbm_blOnStartCvery: TComboBox
          Left = 496
          Top = 94
          Width = 91
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 38
        end
        object sem_swAddres: TEdit
          Left = 182
          Top = 45
          Width = 81
          Height = 21
          TabOrder = 39
          Text = '192.168.1.4'
        end
        object edm_swMask: TEdit
          Left = 336
          Top = 45
          Width = 89
          Height = 21
          TabOrder = 40
          Text = '255.255.255.0'
        end
        object cbm_DeltaFH: TComboBox
          Left = 496
          Top = 142
          Width = 91
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 41
          Items.Strings = (
            'C нач.месяца'
            '1 день'
            '2 дня'
            '3 дня'
            '5 дней'
            '7 дней'
            '14 дней'
            '1 месяц'
            '2 месяца'
            '6 месяцев'
            '12 месяцев')
        end
        object edm_swGate: TEdit
          Left = 496
          Top = 45
          Width = 89
          Height = 21
          TabOrder = 42
          Text = '255.255.255.0'
        end
        object cbOpenSessionTime: TComboBox
          Left = 488
          Top = 382
          Width = 99
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 43
          OnChange = OnChSesion
          Items.Strings = (
            '1 минута'
            '2 минуты'
            '5 минут'
            '10 минут'
            '30 минут'
            '1 час'
            '2 часа')
        end
        object cbM_NSESSIONTIME: TComboBox
          Left = 168
          Top = 404
          Width = 95
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 44
          Items.Strings = (
            '1 минута'
            '2 минуты'
            '5 минут'
            '10 минут'
            '30 минут'
            '1 час'
            '2 часа'
            'неограниченно')
        end
        object cbm_sCalendOn: TComboBox
          Left = 182
          Top = 380
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 45
          Items.Strings = (
            'Нет'
            'Да')
        end
      end
      object AdvPanel4: TAdvPanel
        Left = 2
        Top = 2
        Width = 671
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        Color = 13616833
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7485192
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UseDockManager = True
        Version = '1.7.9.0'
        BorderColor = 16765615
        Caption.Color = 12105910
        Caption.ColorTo = 10526878
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        Caption.GradientDirection = gdVertical
        Caption.Indent = 2
        Caption.ShadeLight = 255
        CollapsColor = clHighlight
        CollapsDelay = 0
        ColorTo = 12958644
        ColorMirror = 12958644
        ColorMirrorTo = 15527141
        ShadowColor = clBlack
        ShadowOffset = 0
        StatusBar.BorderStyle = bsSingle
        StatusBar.Font.Charset = DEFAULT_CHARSET
        StatusBar.Font.Color = clWhite
        StatusBar.Font.Height = -11
        StatusBar.Font.Name = 'Tahoma'
        StatusBar.Font.Style = []
        StatusBar.Color = 10592158
        StatusBar.ColorTo = 5459275
        StatusBar.GradientDirection = gdVertical
        Styler = AdvPanelStyler1
        FullHeight = 0
        object AdvToolBar2: TAdvToolBar
          Left = 0
          Top = -1
          Width = 349
          Height = 29
          AllowFloating = True
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'MS Sans Serif'
          CaptionFont.Style = []
          CompactImageIndex = -1
          TextAutoOptionMenu = 'Add or Remove Buttons'
          TextOptionMenu = 'Options'
          ToolBarStyler = AdvToolBarOfficeStyler1
          ParentStyler = False
          Images = ImageListSet2
          ParentOptionPicture = True
          ParentShowHint = False
          ToolBarIndex = -1
          object AdvGlowMenuButton3: TAdvGlowMenuButton
            Left = 224
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Система'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 0
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = ppMainSystem
          end
          object AdvGlowMenuButton1: TAdvGlowMenuButton
            Left = 113
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Время'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 1
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmMainTime
          end
          object AdvGlowMenuButton2: TAdvGlowMenuButton
            Left = 2
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Данные'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 2
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmMainData
          end
        end
      end
    end
    object AdvOfficePage2: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 675
      Height = 476
      Caption = 'Время'
      ImageIndex = 7
      PageAppearance.BorderColor = 11841710
      PageAppearance.Color = 13616833
      PageAppearance.ColorTo = 12958644
      PageAppearance.ColorMirror = 12958644
      PageAppearance.ColorMirrorTo = 15527141
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabAppearance.BorderColor = clNone
      TabAppearance.BorderColorHot = 9870494
      TabAppearance.BorderColorSelected = 14922381
      TabAppearance.BorderColorSelectedHot = 6343929
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = clNone
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 15724269
      TabAppearance.ColorSelectedTo = 15724269
      TabAppearance.ColorDisabled = clWhite
      TabAppearance.ColorDisabledTo = clSilver
      TabAppearance.ColorHot = 5992568
      TabAppearance.ColorHotTo = 9803415
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 4413279
      TabAppearance.ColorMirrorHotTo = 1617645
      TabAppearance.ColorMirrorSelected = 13816526
      TabAppearance.ColorMirrorSelectedTo = 13816526
      TabAppearance.ColorMirrorDisabled = clWhite
      TabAppearance.ColorMirrorDisabledTo = clSilver
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggRadial
      TabAppearance.GradientMirrorHot = ggRadial
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clWhite
      TabAppearance.TextColorHot = clWhite
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clBlack
      TabAppearance.HighLightColor = 9803929
      TabAppearance.HighLightColorHot = 9803929
      TabAppearance.HighLightColorSelected = 6540536
      TabAppearance.HighLightColorSelectedHot = 12451839
      TabAppearance.HighLightColorDown = 16776144
      TabAppearance.BackGround.Color = 5460819
      TabAppearance.BackGround.ColorTo = 3815994
      TabAppearance.BackGround.Direction = gdVertical
      object AdvPanel37: TAdvPanel
        Left = 2
        Top = 2
        Width = 671
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        Color = 13616833
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7485192
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UseDockManager = True
        Version = '1.7.9.0'
        BorderColor = 16765615
        Caption.Color = 12105910
        Caption.ColorTo = 10526878
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        Caption.GradientDirection = gdVertical
        Caption.Indent = 2
        Caption.ShadeLight = 255
        CollapsColor = clHighlight
        CollapsDelay = 0
        ColorTo = 12958644
        ColorMirror = 12958644
        ColorMirrorTo = 15527141
        ShadowColor = clBlack
        ShadowOffset = 0
        StatusBar.BorderStyle = bsSingle
        StatusBar.Font.Charset = DEFAULT_CHARSET
        StatusBar.Font.Color = clWhite
        StatusBar.Font.Height = -11
        StatusBar.Font.Name = 'Tahoma'
        StatusBar.Font.Style = []
        StatusBar.Color = 10592158
        StatusBar.ColorTo = 5459275
        StatusBar.GradientDirection = gdVertical
        Styler = AdvPanelStyler1
        FullHeight = 0
        object AdvToolBar18: TAdvToolBar
          Left = 0
          Top = -1
          Width = 238
          Height = 29
          AllowFloating = True
          Caption = '2'
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'MS Sans Serif'
          CaptionFont.Style = []
          CompactImageIndex = -1
          TextAutoOptionMenu = 'Add or Remove Buttons'
          TextOptionMenu = 'Options'
          ToolBarStyler = AdvToolBarOfficeStyler1
          ParentStyler = False
          Images = ImageListSet2
          ParentOptionPicture = True
          ParentShowHint = False
          ToolBarIndex = -1
          object AdvGlowMenuButton5: TAdvGlowMenuButton
            Left = 113
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Редактор'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 0
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmTimeEdit
          end
          object AdvGlowMenuButton6: TAdvGlowMenuButton
            Left = 2
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Данные'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 1
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmTimeData
          end
        end
      end
      object sgTransTime: TAdvStringGrid
        Left = 2
        Top = 33
        Width = 671
        Height = 441
        Cursor = crDefault
        Align = alClient
        DefaultRowHeight = 21
        RowCount = 5
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        GridLineWidth = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
        OnMouseDown = OnMDownTTime
        GridLineColor = 15062992
        OnClickCell = OnClickTTimeGrid
        OnGetEditorType = OnChannelGetCellTTIimeType
        ActiveCellFont.Charset = RUSSIAN_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Times New Roman'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 10344697
        ActiveCellColorTo = 6210033
        Bands.Active = True
        Bands.PrimaryColor = 16445929
        Bands.SecondaryColor = clBtnHighlight
        CellNode.ShowTree = False
        ControlLook.FixedGradientFrom = 16250871
        ControlLook.FixedGradientTo = 14606046
        ControlLook.ControlStyle = csClassic
        EnhRowColMove = False
        Filter = <>
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -13
        FixedFont.Name = 'Times New Roman'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'MS Sans Serif'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PageNumSep = '/'
        RowIndicator.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001F5C00FF1F5B00FF1F5C00FFFFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001B6100FF156B06FF1D5F00FF205D00FFFFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00176301FF0D7910FF167510FF1B6001FF205D
          00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001A6403FF057709FF097A0EFF157B16FF1A64
          03FF205B00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001C6606FF0C861AFF007E0BFF068314FF1486
          1EFF186C0AFF1F5B00FF1F5D00FFFFFFFF00FFFFFF00FFFFFF001E5B00FF1F5D
          00FF1F5D00FF1F5D00FF1F5B00FF1F6C0DFF13952AFF008B17FF008A17FF038B
          1AFF129025FF177712FF1D5D00FF205D00FFFFFFFF00FFFFFF001D5C00FF0878
          0BFF058212FF058414FF058516FF0D9225FF079C2AFF009823FF009823FF0095
          20FF01931FFF0F982AFF17841DFF1C6102FF205C00FF1E5C00FF1C5C00FF078E
          1EFF009B24FF009F28FF00A32BFF00A42DFF00A42DFF00A52EFF00A42EFF00A1
          2CFF009E28FF009923FF0A9C2CFF148F25FF1A6A08FF1E5A00FF1B5C00FF2BA2
          42FF0DAA39FF05AA35FF01AD36FF00AF36FF00B037FF00B137FF00AF36FF00AD
          34FF00AA32FF01A630FF05A12DFF15A73BFF169127FF1C5B00FF195C00FF56BC
          6EFF39C86AFF32C766FF2FCB67FF29CA63FF23C65DFF23C65DFF23C55CFF25C3
          5BFF28C15AFF2CBE5BFF36C162FF229E39FF1A6707FFFFFFFF001A5B00FF3E9B
          45FF2FA748FF2AA645FF2AA746FF3BBE61FF4DDB85FF46D97FFF47D87EFF45D5
          7BFF48D57DFF50D581FF2C9D3EFF1B6002FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0028781BFF6CE8A0FF56E692FF56E390FF60E7
          99FF63DF93FF2C9135FF1A5900FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002B781DFF87F0B5FF6FEFA7FF7FF6B5FF6DDE
          97FF258124FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002D7B20FFAEF7CFFFADFED4FF70D28EFF1C70
          11FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002D7F23FFC5FFE3FF62BF77FF146303FFFFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0020690DFF2E8F36FF155A00FFFFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        ScrollWidth = 14
        SearchFooter.Color = 15921648
        SearchFooter.ColorTo = 13222589
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'MS Sans Serif'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionColor = 6210033
        WordWrap = False
        ColWidths = (
          64
          64
          64
          64
          64)
        RowHeights = (
          21
          21
          21
          21
          21)
      end
    end
    object TabSheet5: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 675
      Height = 476
      Caption = 'График опроса'
      ImageIndex = 5
      PageAppearance.BorderColor = 11841710
      PageAppearance.Color = 13616833
      PageAppearance.ColorTo = 12958644
      PageAppearance.ColorMirror = 12958644
      PageAppearance.ColorMirrorTo = 15527141
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabAppearance.BorderColor = clNone
      TabAppearance.BorderColorHot = 9870494
      TabAppearance.BorderColorSelected = 14922381
      TabAppearance.BorderColorSelectedHot = 6343929
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = clNone
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 15724269
      TabAppearance.ColorSelectedTo = 15724269
      TabAppearance.ColorDisabled = clWhite
      TabAppearance.ColorDisabledTo = clSilver
      TabAppearance.ColorHot = 5992568
      TabAppearance.ColorHotTo = 9803415
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 4413279
      TabAppearance.ColorMirrorHotTo = 1617645
      TabAppearance.ColorMirrorSelected = 13816526
      TabAppearance.ColorMirrorSelectedTo = 13816526
      TabAppearance.ColorMirrorDisabled = clWhite
      TabAppearance.ColorMirrorDisabledTo = clSilver
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggRadial
      TabAppearance.GradientMirrorHot = ggRadial
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clWhite
      TabAppearance.TextColorHot = clWhite
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clBlack
      TabAppearance.HighLightColor = 9803929
      TabAppearance.HighLightColorHot = 9803929
      TabAppearance.HighLightColorSelected = 6540536
      TabAppearance.HighLightColorSelectedHot = 12451839
      TabAppearance.HighLightColorDown = 16776144
      TabAppearance.BackGround.Color = 5460819
      TabAppearance.BackGround.ColorTo = 3815994
      TabAppearance.BackGround.Direction = gdVertical
      object AdvPanel5: TAdvPanel
        Left = 2
        Top = 2
        Width = 671
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        Color = 13616833
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7485192
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UseDockManager = True
        Version = '1.7.9.0'
        BorderColor = 16765615
        Caption.Color = 12105910
        Caption.ColorTo = 10526878
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        Caption.GradientDirection = gdVertical
        Caption.Indent = 2
        Caption.ShadeLight = 255
        CollapsColor = clHighlight
        CollapsDelay = 0
        ColorTo = 12958644
        ColorMirror = 12958644
        ColorMirrorTo = 15527141
        ShadowColor = clBlack
        ShadowOffset = 0
        StatusBar.BorderStyle = bsSingle
        StatusBar.Font.Charset = DEFAULT_CHARSET
        StatusBar.Font.Color = clWhite
        StatusBar.Font.Height = -11
        StatusBar.Font.Name = 'Tahoma'
        StatusBar.Font.Style = []
        StatusBar.Color = 10592158
        StatusBar.ColorTo = 5459275
        StatusBar.GradientDirection = gdVertical
        Styler = AdvPanelStyler1
        FullHeight = 0
        object AdvToolBar3: TAdvToolBar
          Left = 0
          Top = -1
          Width = 349
          Height = 29
          AllowFloating = True
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'MS Sans Serif'
          CaptionFont.Style = []
          CompactImageIndex = -1
          TextAutoOptionMenu = 'Add or Remove Buttons'
          TextOptionMenu = 'Options'
          ToolBarStyler = AdvToolBarOfficeStyler1
          ParentStyler = False
          Images = ImageListEvent1
          ParentOptionPicture = True
          ParentShowHint = False
          ToolBarIndex = -1
          object AdvGlowMenuButton7: TAdvGlowMenuButton
            Left = 224
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Управление'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 0
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmQuerGrContr
          end
          object AdvGlowMenuButton8: TAdvGlowMenuButton
            Left = 113
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Редактор'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 1
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmQuerGrEdit
          end
          object AdvGlowMenuButton9: TAdvGlowMenuButton
            Left = 2
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Данные'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 2
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmQuerGrData
          end
        end
      end
      object AdvOfficePager1: TAdvOfficePager
        Left = 2
        Top = 33
        Width = 671
        Height = 441
        AdvOfficePagerStyler = AdvOfficePagerOfficeStyler1
        Align = alClient
        ActivePage = AdvOfficePager11
        ButtonSettings.CloseButtonPicture.Data = {
          424DA20400000000000036040000280000000900000009000000010008000000
          00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001000001010100000100
          0000000202000100020200000000000202020002020200000000010002020202
          0200010000000101000202020001010000000100020202020200010000000002
          0202000202020000000000020200010002020000000001000001010100000100
          0000}
        ButtonSettings.PageListButtonPicture.Data = {
          424DA20400000000000036040000280000000900000009000000010008000000
          00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000101010100
          0000010101000200010101000000010100020202000101000000010002020202
          0200010000000002020200020202000000000002020001000202000000000100
          0001010100000100000001010101010101010100000001010101010101010100
          0000}
        ButtonSettings.ScrollButtonPrevPicture.Data = {
          424DA20400000000000036040000280000000900000009000000010008000000
          00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000001010100
          0000010101000202000101000000010100020202000101000000010002020200
          0101010000000002020200010101010000000100020202000101010000000101
          0002020200010100000001010100020200010100000001010101000001010100
          0000}
        ButtonSettings.ScrollButtonNextPicture.Data = {
          424DA20400000000000036040000280000000900000009000000010008000000
          00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010000010101010100
          0000010002020001010101000000010002020200010101000000010100020202
          0001010000000101010002020200010000000101000202020001010000000100
          0202020001010100000001000202000101010100000001010000010101010100
          0000}
        ButtonSettings.CloseButtonHint = 'Close'
        ButtonSettings.PageListButtonHint = 'Page List'
        ButtonSettings.ScrollButtonNextHint = 'Next'
        ButtonSettings.ScrollButtonPrevHint = 'Previous'
        TabSettings.StartMargin = 4
        TabSettings.Shape = tsLeftRightRamp
        TabReorder = False
        ShowShortCutHints = False
        TabOrder = 1
        NextPictureChanged = False
        PrevPictureChanged = False
        object AdvOfficePager11: TAdvOfficePage
          Left = 1
          Top = 26
          Width = 669
          Height = 413
          Caption = 'График опроса'
          PageAppearance.BorderColor = 11841710
          PageAppearance.Color = 13616833
          PageAppearance.ColorTo = 12958644
          PageAppearance.ColorMirror = 12958644
          PageAppearance.ColorMirrorTo = 15527141
          PageAppearance.Gradient = ggVertical
          PageAppearance.GradientMirror = ggVertical
          TabAppearance.BorderColor = clNone
          TabAppearance.BorderColorHot = 9870494
          TabAppearance.BorderColorSelected = 14922381
          TabAppearance.BorderColorSelectedHot = 6343929
          TabAppearance.BorderColorDisabled = clNone
          TabAppearance.BorderColorDown = clNone
          TabAppearance.Color = clBtnFace
          TabAppearance.ColorTo = clWhite
          TabAppearance.ColorSelected = 15724269
          TabAppearance.ColorSelectedTo = 15724269
          TabAppearance.ColorDisabled = clWhite
          TabAppearance.ColorDisabledTo = clSilver
          TabAppearance.ColorHot = 5992568
          TabAppearance.ColorHotTo = 9803415
          TabAppearance.ColorMirror = clWhite
          TabAppearance.ColorMirrorTo = clWhite
          TabAppearance.ColorMirrorHot = 4413279
          TabAppearance.ColorMirrorHotTo = 1617645
          TabAppearance.ColorMirrorSelected = 13816526
          TabAppearance.ColorMirrorSelectedTo = 13816526
          TabAppearance.ColorMirrorDisabled = clWhite
          TabAppearance.ColorMirrorDisabledTo = clSilver
          TabAppearance.Font.Charset = DEFAULT_CHARSET
          TabAppearance.Font.Color = clWindowText
          TabAppearance.Font.Height = -11
          TabAppearance.Font.Name = 'Tahoma'
          TabAppearance.Font.Style = []
          TabAppearance.Gradient = ggVertical
          TabAppearance.GradientMirror = ggVertical
          TabAppearance.GradientHot = ggRadial
          TabAppearance.GradientMirrorHot = ggRadial
          TabAppearance.GradientSelected = ggVertical
          TabAppearance.GradientMirrorSelected = ggVertical
          TabAppearance.GradientDisabled = ggVertical
          TabAppearance.GradientMirrorDisabled = ggVertical
          TabAppearance.TextColor = clWhite
          TabAppearance.TextColorHot = clWhite
          TabAppearance.TextColorSelected = clBlack
          TabAppearance.TextColorDisabled = clGray
          TabAppearance.ShadowColor = clBlack
          TabAppearance.HighLightColor = 9803929
          TabAppearance.HighLightColorHot = 9803929
          TabAppearance.HighLightColorSelected = 6540536
          TabAppearance.HighLightColorSelectedHot = 12451839
          TabAppearance.HighLightColorDown = 16776144
          TabAppearance.BackGround.Color = 5460819
          TabAppearance.BackGround.ColorTo = 3815994
          TabAppearance.BackGround.Direction = gdVertical
          object sgQryTable: TAdvStringGrid
            Left = 2
            Top = 2
            Width = 645
            Height = 206
            Cursor = crDefault
            DefaultRowHeight = 21
            RowCount = 5
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clAqua
            Font.Height = -12
            Font.Name = 'Times New Roman'
            Font.Style = []
            GridLineWidth = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
            ParentFont = False
            PopupMenu = PopupMenu1
            ScrollBars = ssBoth
            TabOrder = 0
            GridLineColor = 15062992
            OnGetCellColor = OnGetCellColor
            OnClickCell = OnClickGrid
            OnGetEditorType = OnGetCellType
            OnComboChange = OnComboChandge
            ActiveCellFont.Charset = RUSSIAN_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'Times New Roman'
            ActiveCellFont.Style = [fsBold]
            ActiveCellColor = 10344697
            ActiveCellColorTo = 6210033
            Bands.Active = True
            Bands.PrimaryColor = 16445929
            CellNode.ShowTree = False
            ControlLook.FixedGradientFrom = 16250871
            ControlLook.FixedGradientTo = 14606046
            ControlLook.ControlStyle = csClassic
            EnhRowColMove = False
            Filter = <>
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -13
            FixedFont.Name = 'Times New Roman'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'MS Sans Serif'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF001F5C00FF1F5B00FF1F5C00FFFFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF001B6100FF156B06FF1D5F00FF205D00FFFFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00176301FF0D7910FF167510FF1B6001FF205D
              00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF001A6403FF057709FF097A0EFF157B16FF1A64
              03FF205B00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF001C6606FF0C861AFF007E0BFF068314FF1486
              1EFF186C0AFF1F5B00FF1F5D00FFFFFFFF00FFFFFF00FFFFFF001E5B00FF1F5D
              00FF1F5D00FF1F5D00FF1F5B00FF1F6C0DFF13952AFF008B17FF008A17FF038B
              1AFF129025FF177712FF1D5D00FF205D00FFFFFFFF00FFFFFF001D5C00FF0878
              0BFF058212FF058414FF058516FF0D9225FF079C2AFF009823FF009823FF0095
              20FF01931FFF0F982AFF17841DFF1C6102FF205C00FF1E5C00FF1C5C00FF078E
              1EFF009B24FF009F28FF00A32BFF00A42DFF00A42DFF00A52EFF00A42EFF00A1
              2CFF009E28FF009923FF0A9C2CFF148F25FF1A6A08FF1E5A00FF1B5C00FF2BA2
              42FF0DAA39FF05AA35FF01AD36FF00AF36FF00B037FF00B137FF00AF36FF00AD
              34FF00AA32FF01A630FF05A12DFF15A73BFF169127FF1C5B00FF195C00FF56BC
              6EFF39C86AFF32C766FF2FCB67FF29CA63FF23C65DFF23C65DFF23C55CFF25C3
              5BFF28C15AFF2CBE5BFF36C162FF229E39FF1A6707FFFFFFFF001A5B00FF3E9B
              45FF2FA748FF2AA645FF2AA746FF3BBE61FF4DDB85FF46D97FFF47D87EFF45D5
              7BFF48D57DFF50D581FF2C9D3EFF1B6002FFFFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF0028781BFF6CE8A0FF56E692FF56E390FF60E7
              99FF63DF93FF2C9135FF1A5900FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF002B781DFF87F0B5FF6FEFA7FF7FF6B5FF6DDE
              97FF258124FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF002D7B20FFAEF7CFFFADFED4FF70D28EFF1C70
              11FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF002D7F23FFC5FFE3FF62BF77FF146303FFFFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF0020690DFF2E8F36FF155A00FFFFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            ScrollWidth = 14
            SearchFooter.Color = 15921648
            SearchFooter.ColorTo = 13222589
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'MS Sans Serif'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SelectionColor = 6210033
            WordWrap = False
            ColWidths = (
              64
              64
              64
              64
              64)
            RowHeights = (
              21
              21
              21
              21
              21)
          end
          object cbm_nWekEN: TAdvOfficeCheckBox
            Left = 8
            Top = 209
            Width = 249
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.Использовать привязку к дням недели'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 1
            Version = '1.1.1.4'
          end
          object cbm_nPon: TAdvOfficeCheckBox
            Left = 25
            Top = 231
            Width = 96
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Понедельник'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 2
            Version = '1.1.1.4'
          end
          object cbm_nWto: TAdvOfficeCheckBox
            Left = 25
            Top = 251
            Width = 72
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Вторник'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 3
            Version = '1.1.1.4'
          end
          object cbm_nSrd: TAdvOfficeCheckBox
            Left = 25
            Top = 271
            Width = 49
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Среда'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 4
            Version = '1.1.1.4'
          end
          object cbm_nCht: TAdvOfficeCheckBox
            Left = 25
            Top = 292
            Width = 64
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Четверг'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 5
            Version = '1.1.1.4'
          end
          object cbm_nPtn: TAdvOfficeCheckBox
            Left = 25
            Top = 312
            Width = 72
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Пятница'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 6
            Version = '1.1.1.4'
          end
          object cbm_nSub: TAdvOfficeCheckBox
            Left = 25
            Top = 332
            Width = 80
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Суббота'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 7
            Version = '1.1.1.4'
          end
          object cbm_nVos: TAdvOfficeCheckBox
            Left = 25
            Top = 351
            Width = 96
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Воскресенье'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 8
            Version = '1.1.1.4'
          end
          object cbm_nMonthEN: TAdvOfficeCheckBox
            Left = 304
            Top = 209
            Width = 244
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.Использовать привязку к дням месяца'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 9
            Version = '1.1.1.4'
          end
          object cbm_nDay1: TAdvOfficeCheckBox
            Left = 321
            Top = 231
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '1 '
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 10
            Version = '1.1.1.4'
          end
          object cbm_nDay2: TAdvOfficeCheckBox
            Left = 321
            Top = 251
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '2'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 11
            Version = '1.1.1.4'
          end
          object cbm_nDay3: TAdvOfficeCheckBox
            Left = 321
            Top = 271
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '3'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 12
            Version = '1.1.1.4'
          end
          object cbm_nDay4: TAdvOfficeCheckBox
            Left = 321
            Top = 292
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '4'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 13
            Version = '1.1.1.4'
          end
          object cbm_nDay5: TAdvOfficeCheckBox
            Left = 321
            Top = 312
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '5'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 14
            Version = '1.1.1.4'
          end
          object cbm_nDay6: TAdvOfficeCheckBox
            Left = 321
            Top = 332
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '6'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 15
            Version = '1.1.1.4'
          end
          object cbm_nDay7: TAdvOfficeCheckBox
            Left = 321
            Top = 351
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '7'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 16
            Version = '1.1.1.4'
          end
          object cbm_nDay8: TAdvOfficeCheckBox
            Left = 361
            Top = 231
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '8'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 17
            Version = '1.1.1.4'
          end
          object cbm_nDay9: TAdvOfficeCheckBox
            Left = 361
            Top = 251
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '9'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 18
            Version = '1.1.1.4'
          end
          object cbm_nDay10: TAdvOfficeCheckBox
            Left = 361
            Top = 271
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '10'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 19
            Version = '1.1.1.4'
          end
          object cbm_nDay11: TAdvOfficeCheckBox
            Left = 361
            Top = 292
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '11'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 20
            Version = '1.1.1.4'
          end
          object cbm_nDay12: TAdvOfficeCheckBox
            Left = 361
            Top = 312
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '12'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 21
            Version = '1.1.1.4'
          end
          object cbm_nDay13: TAdvOfficeCheckBox
            Left = 361
            Top = 332
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '13'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 22
            Version = '1.1.1.4'
          end
          object cbm_nDay14: TAdvOfficeCheckBox
            Left = 361
            Top = 351
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '14'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 23
            Version = '1.1.1.4'
          end
          object cbm_nDay15: TAdvOfficeCheckBox
            Left = 401
            Top = 231
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '15'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 24
            Version = '1.1.1.4'
          end
          object cbm_nDay16: TAdvOfficeCheckBox
            Left = 401
            Top = 251
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '16'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 25
            Version = '1.1.1.4'
          end
          object cbm_nDay17: TAdvOfficeCheckBox
            Left = 401
            Top = 271
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '17'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 26
            Version = '1.1.1.4'
          end
          object cbm_nDay18: TAdvOfficeCheckBox
            Left = 401
            Top = 292
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '18'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 27
            Version = '1.1.1.4'
          end
          object cbm_nDay19: TAdvOfficeCheckBox
            Left = 401
            Top = 312
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '19'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 28
            Version = '1.1.1.4'
          end
          object cbm_nDay20: TAdvOfficeCheckBox
            Left = 401
            Top = 332
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '20'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 29
            Version = '1.1.1.4'
          end
          object cbm_nDay21: TAdvOfficeCheckBox
            Left = 401
            Top = 351
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '21'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 30
            Version = '1.1.1.4'
          end
          object cbm_nDay22: TAdvOfficeCheckBox
            Left = 441
            Top = 230
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '22'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 31
            Version = '1.1.1.4'
          end
          object cbm_nDay23: TAdvOfficeCheckBox
            Left = 441
            Top = 250
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '23'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 32
            Version = '1.1.1.4'
          end
          object cbm_nDay24: TAdvOfficeCheckBox
            Left = 441
            Top = 270
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '24'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 33
            Version = '1.1.1.4'
          end
          object cbm_nDay25: TAdvOfficeCheckBox
            Left = 441
            Top = 291
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '25'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 34
            Version = '1.1.1.4'
          end
          object cbm_nDay26: TAdvOfficeCheckBox
            Left = 441
            Top = 311
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '26'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 35
            Version = '1.1.1.4'
          end
          object cbm_nDay27: TAdvOfficeCheckBox
            Left = 441
            Top = 331
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '27'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 36
            Version = '1.1.1.4'
          end
          object cbm_nDay28: TAdvOfficeCheckBox
            Left = 441
            Top = 350
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '28'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 37
            Version = '1.1.1.4'
          end
          object cbm_nDay29: TAdvOfficeCheckBox
            Left = 479
            Top = 230
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '29'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 38
            Version = '1.1.1.4'
          end
          object cbm_nDay30: TAdvOfficeCheckBox
            Left = 479
            Top = 250
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '30'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 39
            Version = '1.1.1.4'
          end
          object cbm_nDay31: TAdvOfficeCheckBox
            Left = 479
            Top = 270
            Width = 32
            Height = 20
            Alignment = taRightJustify
            Caption = '31'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 40
            Version = '1.1.1.4'
          end
          object dtPicShed: TDateTimePicker
            Left = 580
            Top = 229
            Width = 86
            Height = 22
            Hint = 'Используется для выбора периода'
            Anchors = [akRight]
            CalAlignment = dtaRight
            Date = 40300.7711754861
            Time = 40300.7711754861
            DateFormat = dfShort
            DateMode = dmComboBox
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowFrame
            Font.Height = -11
            Font.Name = 'Times New Roman'
            Font.Style = []
            Kind = dtkDate
            ParseInput = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 41
          end
        end
        object AdvOfficePager12: TAdvOfficePage
          Left = 1
          Top = 26
          Width = 669
          Height = 413
          Caption = 'Перечень опрашиваемых параметров'
          PageAppearance.BorderColor = 11841710
          PageAppearance.Color = 13616833
          PageAppearance.ColorTo = 12958644
          PageAppearance.ColorMirror = 12958644
          PageAppearance.ColorMirrorTo = 15527141
          PageAppearance.Gradient = ggVertical
          PageAppearance.GradientMirror = ggVertical
          TabAppearance.BorderColor = clNone
          TabAppearance.BorderColorHot = 9870494
          TabAppearance.BorderColorSelected = 14922381
          TabAppearance.BorderColorSelectedHot = 6343929
          TabAppearance.BorderColorDisabled = clNone
          TabAppearance.BorderColorDown = clNone
          TabAppearance.Color = clBtnFace
          TabAppearance.ColorTo = clWhite
          TabAppearance.ColorSelected = 15724269
          TabAppearance.ColorSelectedTo = 15724269
          TabAppearance.ColorDisabled = clWhite
          TabAppearance.ColorDisabledTo = clSilver
          TabAppearance.ColorHot = 5992568
          TabAppearance.ColorHotTo = 9803415
          TabAppearance.ColorMirror = clWhite
          TabAppearance.ColorMirrorTo = clWhite
          TabAppearance.ColorMirrorHot = 4413279
          TabAppearance.ColorMirrorHotTo = 1617645
          TabAppearance.ColorMirrorSelected = 13816526
          TabAppearance.ColorMirrorSelectedTo = 13816526
          TabAppearance.ColorMirrorDisabled = clWhite
          TabAppearance.ColorMirrorDisabledTo = clSilver
          TabAppearance.Font.Charset = DEFAULT_CHARSET
          TabAppearance.Font.Color = clWindowText
          TabAppearance.Font.Height = -11
          TabAppearance.Font.Name = 'Tahoma'
          TabAppearance.Font.Style = []
          TabAppearance.Gradient = ggVertical
          TabAppearance.GradientMirror = ggVertical
          TabAppearance.GradientHot = ggRadial
          TabAppearance.GradientMirrorHot = ggRadial
          TabAppearance.GradientSelected = ggVertical
          TabAppearance.GradientMirrorSelected = ggVertical
          TabAppearance.GradientDisabled = ggVertical
          TabAppearance.GradientMirrorDisabled = ggVertical
          TabAppearance.TextColor = clWhite
          TabAppearance.TextColorHot = clWhite
          TabAppearance.TextColorSelected = clBlack
          TabAppearance.TextColorDisabled = clGray
          TabAppearance.ShadowColor = clBlack
          TabAppearance.HighLightColor = 9803929
          TabAppearance.HighLightColorHot = 9803929
          TabAppearance.HighLightColorSelected = 6540536
          TabAppearance.HighLightColorSelectedHot = 12451839
          TabAppearance.HighLightColorDown = 16776144
          TabAppearance.BackGround.Color = 5460819
          TabAppearance.BackGround.ColorTo = 3815994
          TabAppearance.BackGround.Direction = gdVertical
          object cbm_nArchEN: TAdvOfficeCheckBox
            Left = 12
            Top = 17
            Width = 245
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.Учет электрической энергии(архивы)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 0
            OnClick = OnClickAEN
            Version = '1.1.1.4'
          end
          object cbm_nPriDayF: TAdvOfficeCheckBox
            Left = 28
            Top = 38
            Width = 224
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.1 Приращение энергии за день'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 1
            Version = '1.1.1.4'
          end
          object cbm_nPriMonthF: TAdvOfficeCheckBox
            Left = 28
            Top = 58
            Width = 216
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.2 Приращение энергии за месяц'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 2
            Version = '1.1.1.4'
          end
          object cbm_nPri30F: TAdvOfficeCheckBox
            Left = 28
            Top = 77
            Width = 208
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.3 Cрез 30 мин энергии '
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 3
            Version = '1.1.1.4'
          end
          object cbm_nNakDayF: TAdvOfficeCheckBox
            Left = 28
            Top = 97
            Width = 200
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.4 Энергия на начало суток'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 4
            Version = '1.1.1.4'
          end
          object cbm_nNakMonthF: TAdvOfficeCheckBox
            Left = 28
            Top = 116
            Width = 208
            Height = 20
            Alignment = taLeftJustify
            Caption = '1.5 Энергия на начало месяца'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 5
            Version = '1.1.1.4'
          end
          object cbm_byCurrent: TAdvOfficeCheckBox
            Left = 12
            Top = 135
            Width = 251
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.Текущие параметры'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 6
            OnClick = OnClickCurr
            Version = '1.1.1.4'
          end
          object cbm_bySumEn: TAdvOfficeCheckBox
            Left = 28
            Top = 156
            Width = 251
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.1.Суммарная накопленная энергия'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 7
            Version = '1.1.1.4'
          end
          object cbm_byMAP: TAdvOfficeCheckBox
            Left = 28
            Top = 175
            Width = 251
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.2.Мгновенная реактивная мощность'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 8
            Version = '1.1.1.4'
          end
          object cbm_byMRAP: TAdvOfficeCheckBox
            Left = 28
            Top = 194
            Width = 251
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.3.Мгновенная реактивная мощность'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 9
            Version = '1.1.1.4'
          end
          object cbm_byU: TAdvOfficeCheckBox
            Left = 28
            Top = 214
            Width = 251
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.4.Напряжение'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 10
            Version = '1.1.1.4'
          end
          object cbm_byI: TAdvOfficeCheckBox
            Left = 28
            Top = 233
            Width = 251
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.5.Ток'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 11
            Version = '1.1.1.4'
          end
          object cbm_byFreq: TAdvOfficeCheckBox
            Left = 28
            Top = 252
            Width = 88
            Height = 20
            Alignment = taLeftJustify
            Caption = '2.6.Частота'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 12
            Version = '1.1.1.4'
          end
          object cbm_nPar6: TAdvOfficeCheckBox
            Left = 265
            Top = 17
            Width = 231
            Height = 18
            Alignment = taLeftJustify
            Caption = '3.Учет тепловой энергии(архивы)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 13
            Version = '1.1.1.4'
          end
          object cbm_byJEn: TAdvOfficeCheckBox
            Left = 265
            Top = 38
            Width = 247
            Height = 21
            Alignment = taLeftJustify
            Caption = '4.События системы/устройства'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 14
            OnClick = OnClickEvent
            Version = '1.1.1.4'
          end
          object cbm_byJ0: TAdvOfficeCheckBox
            Left = 282
            Top = 58
            Width = 67
            Height = 20
            Alignment = taLeftJustify
            Caption = '4.1 №1'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 15
            Version = '1.1.1.4'
          end
          object cbm_byJ1: TAdvOfficeCheckBox
            Left = 342
            Top = 58
            Width = 67
            Height = 20
            Alignment = taLeftJustify
            Caption = '4.1 №2'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 16
            Version = '1.1.1.4'
          end
          object cbm_byJ2: TAdvOfficeCheckBox
            Left = 471
            Top = 58
            Width = 67
            Height = 20
            Alignment = taLeftJustify
            Caption = '4.1 №3'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 17
            Version = '1.1.1.4'
          end
          object cbm_byJ3: TAdvOfficeCheckBox
            Left = 403
            Top = 58
            Width = 67
            Height = 20
            Alignment = taLeftJustify
            Caption = '4.1 №4'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 18
            Version = '1.1.1.4'
          end
          object cbm_byPNetEn: TAdvOfficeCheckBox
            Left = 265
            Top = 135
            Width = 184
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.Архивы параметров сети'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 19
            OnClick = OnClickANetEN
            Version = '1.1.1.4'
          end
          object cbm_byPNetU: TAdvOfficeCheckBox
            Left = 283
            Top = 156
            Width = 93
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.1 U(А,B,C)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 20
            Version = '1.1.1.4'
          end
          object cbm_byPNetI: TAdvOfficeCheckBox
            Left = 283
            Top = 176
            Width = 85
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.2 I(А,B,C)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 21
            Version = '1.1.1.4'
          end
          object cbm_byPNetFi: TAdvOfficeCheckBox
            Left = 283
            Top = 196
            Width = 93
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.3 Fi(А,B,C)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 22
            Version = '1.1.1.4'
          end
          object cbm_byPNetCosFi: TAdvOfficeCheckBox
            Left = 283
            Top = 215
            Width = 77
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.4 cos(fi)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 23
            Version = '1.1.1.4'
          end
          object cbm_byPNetF: TAdvOfficeCheckBox
            Left = 283
            Top = 235
            Width = 67
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.5 F'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 24
            Version = '1.1.1.4'
          end
          object cbm_byPNetP: TAdvOfficeCheckBox
            Left = 409
            Top = 155
            Width = 111
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.6 P(А,B,C)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 25
            Version = '1.1.1.4'
          end
          object cbm_byPNetQ: TAdvOfficeCheckBox
            Left = 409
            Top = 176
            Width = 103
            Height = 20
            Alignment = taLeftJustify
            Caption = '5.7 Q(А,B,C)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 26
            Version = '1.1.1.4'
          end
          object cbm_byCorrTM: TAdvOfficeCheckBox
            Left = 266
            Top = 251
            Width = 219
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Коррекция времени'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 27
            Version = '1.1.1.4'
          end
          object cbm_byRecalc: TAdvOfficeCheckBox
            Left = 266
            Top = 270
            Width = 219
            Height = 20
            Alignment = taLeftJustify
            Caption = 'Дорасчет'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReturnIsTab = False
            TabOrder = 28
            Version = '1.1.1.4'
          end
        end
      end
    end
    object TabSheet1: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 675
      Height = 476
      Caption = 'События'
      ImageIndex = 1
      PageAppearance.BorderColor = 11841710
      PageAppearance.Color = 13616833
      PageAppearance.ColorTo = 12958644
      PageAppearance.ColorMirror = 12958644
      PageAppearance.ColorMirrorTo = 15527141
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabAppearance.BorderColor = clNone
      TabAppearance.BorderColorHot = 9870494
      TabAppearance.BorderColorSelected = 14922381
      TabAppearance.BorderColorSelectedHot = 6343929
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = clNone
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 15724269
      TabAppearance.ColorSelectedTo = 15724269
      TabAppearance.ColorDisabled = clWhite
      TabAppearance.ColorDisabledTo = clSilver
      TabAppearance.ColorHot = 5992568
      TabAppearance.ColorHotTo = 9803415
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 4413279
      TabAppearance.ColorMirrorHotTo = 1617645
      TabAppearance.ColorMirrorSelected = 13816526
      TabAppearance.ColorMirrorSelectedTo = 13816526
      TabAppearance.ColorMirrorDisabled = clWhite
      TabAppearance.ColorMirrorDisabledTo = clSilver
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggRadial
      TabAppearance.GradientMirrorHot = ggRadial
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clWhite
      TabAppearance.TextColorHot = clWhite
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clBlack
      TabAppearance.HighLightColor = 9803929
      TabAppearance.HighLightColorHot = 9803929
      TabAppearance.HighLightColorSelected = 6540536
      TabAppearance.HighLightColorSelectedHot = 12451839
      TabAppearance.HighLightColorDown = 16776144
      TabAppearance.BackGround.Color = 5460819
      TabAppearance.BackGround.ColorTo = 3815994
      TabAppearance.BackGround.Direction = gdVertical
      object AdvPanel6: TAdvPanel
        Left = 2
        Top = 2
        Width = 671
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        Color = 13616833
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7485192
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UseDockManager = True
        Version = '1.7.9.0'
        BorderColor = 16765615
        Caption.Color = 12105910
        Caption.ColorTo = 10526878
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        Caption.GradientDirection = gdVertical
        Caption.Indent = 2
        Caption.ShadeLight = 255
        CollapsColor = clHighlight
        CollapsDelay = 0
        ColorTo = 12958644
        ColorMirror = 12958644
        ColorMirrorTo = 15527141
        ShadowColor = clBlack
        ShadowOffset = 0
        StatusBar.BorderStyle = bsSingle
        StatusBar.Font.Charset = DEFAULT_CHARSET
        StatusBar.Font.Color = clWhite
        StatusBar.Font.Height = -11
        StatusBar.Font.Name = 'Tahoma'
        StatusBar.Font.Style = []
        StatusBar.Color = 10592158
        StatusBar.ColorTo = 5459275
        StatusBar.GradientDirection = gdVertical
        Styler = AdvPanelStyler1
        FullHeight = 0
        object AdvToolBar4: TAdvToolBar
          Left = 0
          Top = -1
          Width = 349
          Height = 29
          AllowFloating = True
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'MS Sans Serif'
          CaptionFont.Style = []
          CompactImageIndex = -1
          TextAutoOptionMenu = 'Add or Remove Buttons'
          TextOptionMenu = 'Options'
          ToolBarStyler = AdvToolBarOfficeStyler1
          ParentStyler = False
          Images = ImageListEvent1
          ParentOptionPicture = True
          ParentShowHint = False
          ToolBarIndex = -1
          object AdvGlowMenuButton10: TAdvGlowMenuButton
            Left = 224
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Тип журнала'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 0
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmEventTJrnl
          end
          object AdvGlowMenuButton11: TAdvGlowMenuButton
            Left = 113
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Редактор'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 1
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmEventEdit
          end
          object AdvGlowMenuButton12: TAdvGlowMenuButton
            Left = 2
            Top = 2
            Width = 111
            Height = 25
            Caption = 'Данные'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Images = ImageListEvent1
            FocusType = ftHot
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            TabOrder = 2
            Appearance.BorderColor = 12631218
            Appearance.BorderColorHot = 10079963
            Appearance.BorderColorDown = 4548219
            Appearance.BorderColorChecked = 4548219
            Appearance.Color = 14671574
            Appearance.ColorTo = 15000283
            Appearance.ColorChecked = 11918331
            Appearance.ColorCheckedTo = 7915518
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 7778289
            Appearance.ColorDownTo = 4296947
            Appearance.ColorHot = 15465983
            Appearance.ColorHotTo = 11332863
            Appearance.ColorMirror = 14144974
            Appearance.ColorMirrorTo = 15197664
            Appearance.ColorMirrorHot = 5888767
            Appearance.ColorMirrorHotTo = 10807807
            Appearance.ColorMirrorDown = 946929
            Appearance.ColorMirrorDownTo = 5021693
            Appearance.ColorMirrorChecked = 10480637
            Appearance.ColorMirrorCheckedTo = 5682430
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            DropDownButton = True
            DropDownMenu = pmEventData
          end
        end
      end
      object FsgGrid: TAdvStringGrid
        Left = 2
        Top = 33
        Width = 671
        Height = 441
        Cursor = crDefault
        Align = alClient
        DefaultRowHeight = 21
        RowCount = 5
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clAqua
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        GridLineWidth = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing]
        ParentFont = False
        PopupMenu = PopupMenu1
        ScrollBars = ssBoth
        TabOrder = 1
        GridLineColor = 15062992
        OnGetCellColor = OnGetCellColorEvent
        OnGetEditorType = OnGetEditTypeEvent
        ActiveCellFont.Charset = RUSSIAN_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Times New Roman'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 10344697
        ActiveCellColorTo = 6210033
        Bands.Active = True
        Bands.PrimaryColor = 16445929
        CellNode.ShowTree = False
        ControlLook.FixedGradientFrom = 16250871
        ControlLook.FixedGradientTo = 14606046
        ControlLook.ControlStyle = csClassic
        EnhRowColMove = False
        Filter = <>
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -13
        FixedFont.Name = 'Times New Roman'
        FixedFont.Style = []
        FloatFormat = '%.2f'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'MS Sans Serif'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PageNumSep = '/'
        RowIndicator.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001F5C00FF1F5B00FF1F5C00FFFFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001B6100FF156B06FF1D5F00FF205D00FFFFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00176301FF0D7910FF167510FF1B6001FF205D
          00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001A6403FF057709FF097A0EFF157B16FF1A64
          03FF205B00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF001C6606FF0C861AFF007E0BFF068314FF1486
          1EFF186C0AFF1F5B00FF1F5D00FFFFFFFF00FFFFFF00FFFFFF001E5B00FF1F5D
          00FF1F5D00FF1F5D00FF1F5B00FF1F6C0DFF13952AFF008B17FF008A17FF038B
          1AFF129025FF177712FF1D5D00FF205D00FFFFFFFF00FFFFFF001D5C00FF0878
          0BFF058212FF058414FF058516FF0D9225FF079C2AFF009823FF009823FF0095
          20FF01931FFF0F982AFF17841DFF1C6102FF205C00FF1E5C00FF1C5C00FF078E
          1EFF009B24FF009F28FF00A32BFF00A42DFF00A42DFF00A52EFF00A42EFF00A1
          2CFF009E28FF009923FF0A9C2CFF148F25FF1A6A08FF1E5A00FF1B5C00FF2BA2
          42FF0DAA39FF05AA35FF01AD36FF00AF36FF00B037FF00B137FF00AF36FF00AD
          34FF00AA32FF01A630FF05A12DFF15A73BFF169127FF1C5B00FF195C00FF56BC
          6EFF39C86AFF32C766FF2FCB67FF29CA63FF23C65DFF23C65DFF23C55CFF25C3
          5BFF28C15AFF2CBE5BFF36C162FF229E39FF1A6707FFFFFFFF001A5B00FF3E9B
          45FF2FA748FF2AA645FF2AA746FF3BBE61FF4DDB85FF46D97FFF47D87EFF45D5
          7BFF48D57DFF50D581FF2C9D3EFF1B6002FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0028781BFF6CE8A0FF56E692FF56E390FF60E7
          99FF63DF93FF2C9135FF1A5900FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002B781DFF87F0B5FF6FEFA7FF7FF6B5FF6DDE
          97FF258124FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002D7B20FFAEF7CFFFADFED4FF70D28EFF1C70
          11FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002D7F23FFC5FFE3FF62BF77FF146303FFFFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0020690DFF2E8F36FF155A00FFFFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        ScrollWidth = 14
        SearchFooter.Color = 15921648
        SearchFooter.ColorTo = 13222589
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'MS Sans Serif'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionColor = 6210033
        WordWrap = False
        ColWidths = (
          64
          64
          64
          64
          64)
        RowHeights = (
          21
          21
          21
          21
          21)
      end
    end
    object TabSheet2: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 675
      Height = 476
      Caption = 'Темы'
      ImageIndex = 3
      PageAppearance.BorderColor = 11841710
      PageAppearance.Color = 13616833
      PageAppearance.ColorTo = 12958644
      PageAppearance.ColorMirror = 12958644
      PageAppearance.ColorMirrorTo = 15527141
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabAppearance.BorderColor = clNone
      TabAppearance.BorderColorHot = 9870494
      TabAppearance.BorderColorSelected = 14922381
      TabAppearance.BorderColorSelectedHot = 6343929
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = clNone
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 15724269
      TabAppearance.ColorSelectedTo = 15724269
      TabAppearance.ColorDisabled = clWhite
      TabAppearance.ColorDisabledTo = clSilver
      TabAppearance.ColorHot = 5992568
      TabAppearance.ColorHotTo = 9803415
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 4413279
      TabAppearance.ColorMirrorHotTo = 1617645
      TabAppearance.ColorMirrorSelected = 13816526
      TabAppearance.ColorMirrorSelectedTo = 13816526
      TabAppearance.ColorMirrorDisabled = clWhite
      TabAppearance.ColorMirrorDisabledTo = clSilver
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggRadial
      TabAppearance.GradientMirrorHot = ggRadial
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clWhite
      TabAppearance.TextColorHot = clWhite
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clBlack
      TabAppearance.HighLightColor = 9803929
      TabAppearance.HighLightColorHot = 9803929
      TabAppearance.HighLightColorSelected = 6540536
      TabAppearance.HighLightColorSelectedHot = 12451839
      TabAppearance.HighLightColorDown = 16776144
      TabAppearance.BackGround.Color = 5460819
      TabAppearance.BackGround.ColorTo = 3815994
      TabAppearance.BackGround.Direction = gdVertical
      object Label22: TLabel
        Left = 25
        Top = 40
        Width = 104
        Height = 15
        Caption = 'Параметры шрифта:'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 25
        Top = 70
        Width = 70
        Height = 15
        Caption = 'Цвет панелей:'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 25
        Top = 100
        Width = 25
        Height = 15
        Caption = 'Тема'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object GradientLabel2: TGradientLabel
        Left = 4
        Top = 11
        Width = 141
        Height = 17
        AutoSize = False
        Caption = 'Темы'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        ColorTo = clWhite
        EllipsType = etNone
        GradientType = gtFullHorizontal
        Indent = 0
        LineWidth = 2
        Orientation = goHorizontal
        TransparentText = False
        VAlignment = vaTop
      end
      object StyleForm: TComboBox
        Left = 144
        Top = 97
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = StyleFormChange
      end
      object Edit2: TEdit
        Left = 144
        Top = 67
        Width = 121
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object Edit1: TEdit
        Left = 144
        Top = 37
        Width = 121
        Height = 21
        ReadOnly = True
        TabOrder = 2
      end
      object RbButton1: TRbButton
        Left = 267
        Top = 37
        Width = 25
        Height = 23
        OnClick = OnSetFontClick
        TabOrder = 3
        TextShadow = True
        Caption = '...'
        ModalResult = 0
        Spacing = 2
        Layout = blGlyphLeft
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        FadeSpeed = fsMedium
        ShowFocusRect = True
        HotTrack = False
        GradientBorder = True
      end
      object RbButton2: TRbButton
        Left = 267
        Top = 67
        Width = 25
        Height = 22
        OnClick = OnSetColor_PanelClick
        TabOrder = 4
        TextShadow = True
        Caption = '...'
        ModalResult = 0
        Spacing = 2
        Layout = blGlyphLeft
        Colors.DefaultFrom = clWhite
        Colors.DefaultTo = 13745839
        Colors.OverFrom = clWhite
        Colors.OverTo = 12489846
        Colors.ClickedFrom = 13029334
        Colors.ClickedTo = 15463415
        Colors.HotTrack = clBlue
        Colors.BorderColor = clGray
        Colors.TextShadow = clWhite
        FadeSpeed = fsMedium
        ShowFocusRect = True
        HotTrack = False
        GradientBorder = True
      end
      object GroupBox2: TGroupBox
        Left = 152
        Top = 14
        Width = 489
        Height = 7
        TabOrder = 5
      end
    end
    object Label60: TLabel
      Left = 25
      Top = 40
      Width = 104
      Height = 15
      Caption = 'Параметры шрифта:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object AdvToolBar5: TAdvToolBar
      Left = 0
      Top = 27
      Width = 136
      Height = 44
      AllowFloating = True
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = AdvToolBarOfficeStyler1
      ParentStyler = False
      Images = ImageListSet2
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object AdvToolBarButton24: TAdvToolBarButton
        Left = 2
        Top = 2
        Width = 24
        Height = 40
        Hint = 'Записать'
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 0
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
      end
      object AdvToolBarButton25: TAdvToolBarButton
        Left = 26
        Top = 2
        Width = 24
        Height = 40
        Hint = 'Прочитать'
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 1
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnGetGenData
      end
      object AdvToolBarButton29: TAdvToolBarButton
        Left = 50
        Top = 2
        Width = 24
        Height = 40
        Hint = 'Установить удаленное подключение'
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 4
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
      end
      object AdvToolBarButton30: TAdvToolBarButton
        Left = 74
        Top = 2
        Width = 24
        Height = 40
        Hint = 'Разорвать удаленное подключение '
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 5
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
      end
      object AdvToolBarButton31: TAdvToolBarButton
        Left = 98
        Top = 2
        Width = 24
        Height = 40
        Hint = 'Перезагрузить ПО'
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 6
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
      end
    end
  end
  object ImageListSet1: TImageList
    Left = 789
    Top = 42
    Bitmap = {
      494C010108000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      000000000000FDFDFD00FBFBFB00F9F9F900FBFBFB00FDFDFD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECECECFFE2E2E3FFE2E2
      E3FFE2E2E3FFE2E2E3FFE2E2E3FFE2E2E3FFE2E2E3FFE2E2E3FFE2E2E3FFE2E2
      E3FFE2E2E3FFE3E4E4FF00000000000000000000000000000000000000000000
      00000000000029100000BD9C5200F7D68C00E7C6730084632100000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500E4E4E400C3C3C3008C828000786A680097929200D7D7D700E6E6E600F9F9
      F9000000000000000000000000000000000000000000C2C2C2FFE7E7E7FFEDED
      EDFFF5F5F5FFFAFAFAFFFCFCFCFFFDFDFDFFFDFDFDFFF8F8F8FFEFEFEFFFDADA
      DAFFECECECFFEFEFEFFFD9D9D9FF00000000CB7950FFF1BEA9FFF0C2AEFFF0C3
      AFFFF0C4AEFFF0C4AEFFF0C4AEFFF0C4AEFFF0C4AEFFF0C4AEFFF0C4AEFFF0C3
      AFFFEFC1ACFFE4B4A1FFA26242FF000000000000000000000000000000003110
      0000FFFFC600FFFFB500FFFFA500FFF7A500FFFFA500FFFFAD00FFFFC600E7BD
      63000000000000000000000000000000000000000000FBFBFB00E6E6E600968C
      8900E8AD9C00F9BBA900EEAA9700DA947E00B7604700CD705500AC634E00C0C0
      C000EFEFEF0000000000000000000000000000000000BDBDCDFF525275FFB6B6
      B6FFAFAFAFFFAEAEAEFFAFAFAFFFB0B0B0FFB0B0B0FFB1B1B1FF747475FFBABA
      BAFF9B9B9BFFBCBCDDFF9999A2FF00000000ECB49FFF95999BFFEABFA6FFC5A2
      8DFFF3C8AEFFF3C8AEFFF3C8AEFFEFC5ABFFF1C7ACFFF3C8AEFFF3C8AEFFF0C5
      ABFFBA9784FFA1A5A6FFEDB19AFFEBEBEBFF0000000000000000B5631000D6C6
      84009C844A00BD733100C6945200BD7B4200C6945200C6844A00C69C5A00BD8C
      5200FFFFB500000000000000000000000000FBFBFB00E4E4E400104D7A00FFE7
      DC00F5D6CC00E6B2A100E0A59300DFA29000DA998600E4B1A200F3CBBF00FCBA
      A700958C8800EFEFEF000000000000000000000000009696BAFFF5F5FFFFFFFF
      FFFF68688DFF8A8A8AFFAFAFAFFFB7B7B7FFB6B6B6FF909090FFA6886FFFA1A1
      C7FFFFFFFFFFF6F6FFFF898990FF00000000E8AF93FFF3BFA1FFB4B1B0FF5A4F
      48FFF5C5A6FFF5C5A6FFFAC8A7FF8C8886FFB8947BFFF5C5A6FFF5C5A6FF9691
      8EFF6A6967FFF0BDA0FFE9AB8FFFE9E9E9FF000000009C390000FFFF9C00CE94
      4200A56B5200529CD60063BDFF0073635A00C6734200C6733900BD6B3900BD6B
      3900FFFF7B00F7E77B000000000000000000EBEBEB00158CC9007ACEF0008E85
      8900EEAB9800EEB2A000EEB3A200EEAF9D00EAA28E00EDA89600EBA59200E5A4
      9100FFD0C200BDBCBB00FBFBFB0000000000F5F5F5FF8383B6FFD6D6FCFFE3E3
      FEFFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFFAB32FFD8DDE7FFEFEF
      FFFFDDDDFCFFDBDBFFFF7E7E85FFFDFDFDFFE6A384FFF1B593FF757779FF483E
      38FFF3BC98FFF3BB98FF987D6BFFC7C7C7FF9B7A62FFF3BC98FFF3BB98FF5F62
      64FF434446FFEFB390FFE7A180FFE9E9E9FF00000000FFF78400FFE76300EF9C
      4A00E7B584007B94BD00396BCE004284CE005AB5FF00EFBD8C00E7AD8400EFB5
      8400FFB54200FFFF84009431000000000000558193005FC6EE00139BDB0053B7
      E3009EA2AB00ECA39000ECA59200E99F8A00DF937C00E4998300E69B8700E499
      8400E2988200E8BCAE00F3F3F30000000000000000007575B5FFBDBDF9FFC9C9
      F9FFDDDDFCFFEDEDFDFFF5F5FDFFFFFFFFFFCB6700FFC2BAB2FFF0F2FFFFD6D6
      FBFFC3C3F8FFC1C1FFFFABABAFFF00000000E29772FFEFAA81FF606366FF6E60
      56FFF2B389FFF2B389FF9A7B66FFA2A2A2FF9B745AFFF2B389FFF2B389FF5055
      59FF4D5254FFEBA780FFE3936FFFE9E9E9FF00000000FFFF7B00FFBD4200FF9C
      3900EF8C3900BD6B29006384E7001031A500ADCED60094D6FF00B56B2100FF9C
      3900FFA53900FFDE5A00E7BD4A000000000070DCFF00158ECD001BA1DE0020B0
      ED0052C1EE00B7B5BA00E1937D00DD907900D4846B00D98B7300DD8F7900DC8E
      7700D7897100EEA58F00E6E6E600FBFBFB00000000006C6CB4FFADADF6FFB7B7
      F7FFC5C5F8FFD7D7FBFFE3E4FFFFB3A6A6FFFFDFA1FFD2D5F3FFD1D1FBFFBFBF
      F7FFB2B2F7FFB2B2FFFFB2B2B7FF00000000DF8960FFEB9E70FFCCA083FFCCA1
      83FFF1A978FFF0A978FF96755EFF999C9DFFBE8A66FFF0A978FFF1A978FFCCA1
      83FFCB9F82FFEA9C6FFFE0875DFFE9E9EAFFD69C8400FFE77300FFB54200FFA5
      4200EF943900C6733100FFDEB5009CC6F7001063C600FFE7BD00D68C4A006B5A
      5200FFAD4200FFC64A00FFF77300000000001A93D200178CCA001999D6001CA5
      E30023B2ED005FCEF600D1BBB600DC8D7500CE7B6200CC796000D17F6700D484
      6C00D9897000E9957600A3A3A300E4E4E400000000005D5DB3FF9999F4FFA3A3
      F5FFAEAEF7FFB9B9F9FFBCC9FFFFFF9821FF9DA5BDFFC1C1FBFFB4B4F7FFA9A9
      F6FF9E9EF4FF9F9FFFFFB2B2B7FF00000000DD7D50FFA0A5A6FFF8F8F7FFF8F8
      F7FF9FA3A5FFEEA06AFFEEA06BFFEFA06BFFEEA06BFFEEA06AFF9FA3A5FFF8F8
      F7FFF8F8F7FFA0A3A6FFDF7D51FFE9E9EAFFDEAD8400FFD67300FFCE7300FFAD
      4A00F7943900C6733100B55A2900B5521800B5632900ADB5BD00CE843100FF9C
      3900FFC66300FFD67300FFDE6B00000000001179B900178FCD001CA3E1001EAD
      EB002BB5EE0038BAEF004CC7F700BCB39600C69182009F7F86006B516C003F34
      7B003B35AB005F5BE400B5A7FF00A195BD00000000005656B1FF8888F3FF8D8D
      F3FF9898F3FFA2A6FFFFA76227FFF9F5E2FFA6A6FFFFA3A3F5FF9D9DF3FF9393
      F3FF8A8AF3FF8D8DFEFFB2B2B7FF00000000DB703EFFDBDDDEFFFAFAFAFFF6F6
      F6FFDBDDDEFFF0975BFFEC985EFFEC985EFFEC985EFFF0975BFFDBDDDEFFF6F6
      F6FFF7F7F7FFE1E2E2FFE28559FFE9E9E9FFDE9C8400FFEF8C00FFD67B00FFC6
      7B00FFBD7B00CE945A00E7C6AD00DEBDA500E7C6AD00C6B5A500C6CED600FFC6
      7B00FFCE7B00FFDE8400FFFF840000000000199BDC001A9CD9001CA3E1001EAB
      E90024B2EE002DB6EF003CB1C40062D08E001E8F57003D44FF00464DDF008586
      F900AAA1FD00A299FB00837DF6007169BA00000000004F4FB0FF7E7EF1FF8181
      F2FF8586F4FF6B63A7FFFFE3A3FF7375C5FF8D8DF4FF8C8CF3FF8484F2FF8D8D
      F3FF9999F3FFA5A5FFFFB2B2B7FF00000000D86933FFCDCECDFFB5B6B6FFF5F5
      F5FFC8C7C7FFEE9052FFEE9254FFEF9253FFEE9254FFEE9052FFC8C8C7FFF4F5
      F5FF848484FFD6D7D6FFE38D64FFE9E9E9FF00000000FFFFB500FFDE8C00FFCE
      8C00FFC68400D69C6300AD522100B54A1000AD521800AD4A0800FFC68400FFC6
      8400FFD68C00FFEF9C00EFBD5200000000001BA2E4001B9FDD001DA6E4001DAB
      E9002DB5F6003DC08C0070ECA60026D26C0065E89A00A2A7EE00CAC0FD00F2EF
      FF00D6CDFD00AC9DFC007C71FC005652C000000000004D4DB0FF7171F1FF7A7A
      F0FF767EFFFFFFA736FFB0B7C3FF8282FBFF7E7EF2FFA2A2F5FFAFAFF7FFABAB
      F6FFA7A7F6FFB1B1FFFFB1B1B6FF00000000D76935FFD3895DFFC6C7C9FFC6C9
      CBFFD99566FFDC8C57FF909395FFA9ABABFF909395FFDB8C56FFDBA078FFD9DB
      DBFFD7DBDCFFE1AF93FFE59B79FFE9E9E9FF00000000FFF79400FFFFAD00F7CE
      8C00D6AD7B00BD8C6300EFD6C600EFD6BD00EFD6C600F7E7D600DEAD8400D6B5
      7B00FFE79C00FFFFBD00A5310000000000003192BE001BA3E10019A7E60051C3
      F30057E0820053E58C003FDF7D0040E07F003CDB770056EC8A00C4C6F500D2C9
      FD00C7BBFD00A79AFC006A62FB008A87A700000000006C6CB4FFA6A6F6FF7A7B
      F3FF826183FF9EABADFF7373E6FFABABF6FFBFBFF8FFBABAF7FFB7B7F8FFB5B5
      F8FFB3B3F8FFC1C1FFFFB1B1B6FF00000000E49D7BFFF0B999FFF4C09CFFF3B9
      91FFF1A26DFF9A9C9EFFF7F7F7FFF4F4F4FFF7F7F7FFC3C6C7FFF5C09CFFF4BF
      9BFFF3BE9AFFEFB796FFE9AA8DFFE9E9E9FF00000000A5420000FFFFD600CEA5
      6300AD521800B5521000AD521800AD4A1000B5521800AD4A1000B55A1800A542
      0800FFFFC600F7E78C0000000000000000000000000040C8FF0084D9E1005FE8
      80004CDC79004ADE7B0049DF7E0049E07F004AE07D004DDE7B0059EB8100C1BB
      F900B0A3FD009F91FC009386FF0000000000000000007979B6FFD3D3FCFFD8DF
      FFFFA07C4FFFB0B0CEFFD4D4FCFFD0D0FAFFD0D0FAFFD0D0F9FFCDCDF9FFCDCD
      F9FFCDCDF9FFDCDCFFFFB1B1B7FF00000000EBBAA2FFF2C4A9FFF5CAADFFF6CB
      AEFFF7CAABFFE7E7E7FFFAFAFAFFF7F7F7FFFAFAFAFFE7E7E7FFF7CAABFFF6CB
      AEFFF5CAADFFF0C3A8FFEEBAA3FFE9E9E9FF0000000000000000BD631000D6BD
      A500E7C6AD00DEB59400E7C6AD00E7C6A500E7C6AD00F7D6BD00E7BDA500EFC6
      AD00FFFFD600000000000000000000000000000000000000000069EE830057DA
      770056DE7B0055E07F0054E1800054E1810055E1800057E07F005BDF7D0066E9
      7D00AA9CFA009688FC008F8DB100000000000000000064649FFFFFFFFFFFAB8D
      72FF91969EFFF4F4FFFFEDEDFDFFEBEBFDFFEAEAFDFFECECFCFFECECFCFFEBEB
      FDFFECECFFFFFFFFFFFFBCBCBFFF00000000EEC6B3FFF4CEB8FFF7D3BCFFF7D4
      BDFFF7D3BBFFE4E4E4FFFEFEFEFFF8FAFAFFFBFBFBFFE4E4E4FFF7D3BBFFF7D4
      BDFFF6D3BCFFF2CDB7FFF2C8B4FFE9E9E9FF000000000000000000000000B552
      0000FFFFEF00FFFFDE00FFFFD600FFFFD600FFFFD600FFFFD600FFFFE700EFC6
      7B00000000000000000000000000000000000000000000000000D4D8D50084FC
      9B0064E2810061E3810062E4840062E5840062E4830062E380007AF293006DA7
      770000000000817FB1000000000000000000000000000000000086889FFFB8A9
      97FFFFFFFFFFFFFFFFFFFDFDFFFFFCFCFFFFFCFCFFFFFCFCFFFFFFFFFFFFFFFF
      FFFF9696CEFFEAEAEAFF0000000000000000F1D0C2FFD6D4D2FFF6D8C5FFF7D9
      C7FFF7D9C7FFEBDFD8FFEEEDECFFF5EEECFFEEEDECFFEBDFD7FFF7D9C7FFF7D9
      C7FFF6D8C5FFD7D4D2FFF5D2C5FFF2F2F2FF0000000000000000000000000000
      000000000000AD420000DEA56300EFCE9400E7BD8400C67B2900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A1B3A50095E0A400A4FDB600A3FCB6009FF1B00084AF8D00000000000000
      0000000000000000000000000000000000000000000000000000BBBAB9FF0000
      0000A3A3ACFF8989B7FFE7E7FFFFFFFFFFFFFFFFFFFFCACAF3FF6F6F97FFEAEA
      EAFF00000000000000000000000000000000E78F66FFEDDDD8FFF6DDD3FFF6DE
      D3FFF6DED3FFF6DED3FFF6DED2FFF3E1D9FFF6DED2FFF6DED3FFF6DED3FFF6DE
      D3FFF5DDD3FFEDDDD7FFBF7E5EFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002121
      2100313131001818180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000420000009C210800C6311000BD3110008C180000210000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002939420029313900394A5200A5B5C6005252630021293900949CA500394A
      5200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000018181800A5A5
      9C009C9C940094948C005A5A5A00313131001818180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009410
      0000DE521800E7632100DE4A1800D6421800D6391800D6391800EF4A2100CE29
      080084100000000000000000000000000000000000000000000000000000949C
      AD00636B7B006B737B00A5B5C600526373005A636B00949CAD0094A5B50094A5
      B5002931420052636B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031313100C6C6
      BD00EFEFE700EFEFE700CECEC60094948C0094948C005A5A5A00313131001818
      18000000000000000000000000000000000000000000000000009C100000E773
      2900E7632100DE632100C64A2900ADADAD00AD7B7300D6391000D6311800CE31
      1800E7391800A518000000000000000000000000000039424A00A5B5C6005252
      6300A5B5CE006B737B00391800003918000042210000000000004A4A52006373
      8C004252630031394A00424A5200000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C0000000000000000000000000018181800EFEF
      E700EFEFE700EFEFE700EFEFE700EFEFE700EFEFE700CECEBD0094948C009494
      8C005A5A5200313131001818180000000000000000009C100000EF7B2900E76B
      2100E76B2100E7632100B59C9400BDB5B500C6422100B5847B00D6421800D639
      1800CE291000D63118000000000000000000000000008494A500636B7300737B
      840021000000633910009C6B4200A5734200734A2100311000004A1800000000
      0000394A5A009CADBD0031425200000000009C9C9C00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE0000000000000000002929290010100800A5A5
      9C00D6BD6B006BCE84005AB56300DED6C600E7E7DE00EFEFE700EFEFE700EFE7
      DE00CECEBD0094948C007B7B73004A4A4A0000000000C64A1000EF842900E773
      2100E76B2100E76B2100BD6B5200CED6D600D6421000BD8C8400C64A2900D639
      1800D6391800E74221009C1000000000000000000000525A630039424A005A29
      0000DE9C7B00D68C7300C67B6B00BD6B6300CE7B7B00BD7B7300636B7B003110
      0000525A5A00738494008C94A500000000009C9C9C00E7E7E700ADADAD00DEDE
      DE00FFFFFF00F7FFFF00DEDEDE00FFFFFF00FFFFFF00DEDEDE00FFFFFF00FFFF
      FF00DEDEDE00ADADAD00E7E7E70000000000000000003131290042393100F7EF
      E700C6940000CEAD2100B5C66300C6942900AD6B1800C6945200D6CEAD00E7E7
      DE00EFEFE700EFE7DE00E7E7DE00636363009C100000F7A53100EF8C2900EF7B
      2900E76B2100E76B2100D6521000D6DEDE00C6736300DE4A1800C64A2900D642
      1800D6391800CE311800CE39100000000000525A6B007B84940039312100DE9C
      7300D69C6B00DE9C730063E7C6006BC6AD006B947B008C9CB5009CA5B500849C
      B500180800004252630000000000000000009C9C9C00F7F7F700ADADAD00F7EF
      EF009CE7FF009CDEFF00F7EFEF00D6EFD600D6EFD600F7EFEF00E7E7FF00E7E7
      FF00F7EFEF00C6C6C600EFEFEF000000000018181800292921007B736B00EFDE
      CE00D6B56B00E7D68400DEC66B00DEBD5200DEC65A00CEAD3900BD8C2100AD6B
      1800D6D6CE00EFEFE700EFEFE7005A5A5A009C080000FFAD3100F7942900EF8C
      2900EF7B2100C66B5200EF631800D6CECE00D6D6D600DE521800D6521800D64A
      1800D6421800D6391800E74A210000000000000000007B849C00DE9C6B00DEAD
      7B00CE9C6B00DEAD730063F7D6006BDEB50073738C00E7F7FF00DEEFF700ADBD
      C600738494002931420000000000000000009C9C9C00F7F7F700ADADAD00FFFF
      F70094DEFF0094DEFF00FFFFF700B5DEB500B5DEB500FFFFF700B5B5F700B5B5
      F700FFFFF700CECECE00F7F7F70000000000313131005A524A00F7F7EF00AD6B
      1800EFDEC600EFDEAD00E7D69400E7D68400DEC66B00CEAD2100CEA50800C694
      0000E7E7DE00BDB5AD006B6B6B00000000009C100000FFB53900F79C3100F794
      2900EF942900D6A58C00CE5A3100CE7B5A00EFF7FF00CE4A1000DE521800D64A
      1800D64A1800D6421800DE4A210000000000000000004A312100E7C69C00AD9C
      730042846300E7BD8400EFC67B0063738C00CED6E700CED6E700CED6E700C6CE
      DE00B5BDC6008C9CA50031394A00000000009C9C9C00FFFFFF00ADADAD00FFFF
      FF006BB5DE006BB5DE00DEDEDE0094D6940094D69400D6D6D600848CEF00848C
      EF00D6D6D600D6D6D600FFFFFF000000000031313100FFFFF700F7F7EF00AD5A
      2100F7EFEF00EFE7CE00EFDEB500E7D69C00E7CE7B00DEBD6300CEA54200C6A5
      6300EFEFE700D6CECE0029292900000000009C080000FFC64200F7A53100F79C
      3100F7942900EF8C2100F7E7EF00CE4A0000FFFFFF00CE633900DE521800DE52
      1800D64A1800D6421800D64A180000000000391800009C6B3900EFCEA50073C6
      AD007BAD8C00DEC684008C8C7B00B5BDC600B5BDCE00BDC6D600BDC6D600B5BD
      CE00ADB5C600A5ADB50039425200000000009C9C9C00FFFFFF00ADADAD00FFFF
      FF00FFFFFF00F7F7F700FFFFFF0073C6730073C67300FFFFFF009C9CF7009C9C
      F700FFFFFF00CECECE00FFFFFF000000000029292900FFFFF700FFFFF700D6AD
      8C00A5521000D6AD8400F7E7DE00EFDEC600E7CEA500DEBD8C00BD8C4200DEDE
      D600C6BDB500B5ADAD0000000000000000009C080000FFD64A00FFAD3100F7A5
      3100F79C3100F7942900E77B1800E7C6BD00EFC6BD00E76B1800E76B2100E763
      2100DE5A2100DE521800C63910000000000000000000946B3900D6BDA50094D6
      C6008CC6AD0084AD8C0073849C00A5ADB500ADB5BD00ADB5C600ADB5C600ADB5
      BD00A5ADB50094A5BD0018212900000000009C9C9C00FFFFFF00ADADAD00FFFF
      FF00FFFFFF00EFEFEF00FFFFFF0073C6730073C67300FFFFFF00E7E7FF00E7E7
      FF00FFFFFF00CECECE00FFFFFF0000000000000000003131310073737300F7F7
      EF00FFFFF700F7F7EF00CEAD8C00A55A1000C68C5A00DEC6AD00A5632900F7F7
      EF00B5B5AD0031313100000000000000000000000000C66B2100FFB53100FFAD
      3100F7A53100F79C3100F7942900D6733900E7C6BD00DE632100E7732100E76B
      2100E7632100E76321009C100000000000000000000063311000B5FFF700A5E7
      CE009CD6C60084C6AD00F7DEB5007B848C009CA5B5009CADB5009CA5B5009CAD
      BD00635252002110080000000000000000009C9C9C00FFFFFF00ADADAD00FFFF
      FF00F7F7F700EFEFEF00DEDEDE009CD69C009CD69C00D6D6D600D6D6D600D6D6
      CE00D6D6D600CECECE00FFFFFF00000000000000000000000000000000001010
      1000313131006B6B6B00EFEFEF00FFFFF700EFEFE700C6AD9400DED6CE00FFF7
      F700EFEFE700181818000000000000000000000000009C080000FFE75200FFB5
      3100FFAD3100F7A53100F79C2900EFD6D600F7F7F700EFD6D600EF842900E773
      2100E76B2100C642100000000000000000000000000000000000C6FFFF00B5EF
      E700ADE7D600A5D6C6008CC6B500DECE9C00AD9C84008C8CA5005A737B005A84
      5A00633110000000000000000000000000009C9C9C00FFFFFF00ADADAD00FFFF
      FF00FFFFFF00F7F7F700FFFFFF00E7F7E700E7F7E700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CECECE00FFFFFF00000000000000000000000000000000000000
      0000000000000000000010101000313131006B6B6B00EFEFE700FFFFF700B5AD
      AD005252520000000000000000000000000000000000000000009C080000FFEF
      5200FFB53100FFAD3100F7A53100DE7B3100F7E7EF00D6845A00EF842900EF7B
      2900D66318009C1000000000000000000000000000000000000073391800D6FF
      FF00EFE7CE00A5E7DE009CDECE00EFD6AD00E7C69C007BEFCE007BCEB5008C84
      6300000000000000000000000000000000009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010101000313131003131
      3100101010000000000000000000000000000000000000000000000000009400
      0000E7AD3900FFD64200FFAD3100F7A53100F79C2100F79C3100F79C3100BD42
      10009C1000000000000000000000000000000000000000000000000000007B42
      1000FFFFEF00F7EFD600F7E7BD00EFDEBD00EFCEA5009CFFF700948C6B000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C080000B5421000C6632100C6521800A52900009C0800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B59C7B00BD946300BD946300C6AD94006B392900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C003F83FFFFF80038003E00F80010001
      E00F800780010000C00700038001000080030001000000008001000180010000
      8001000080010000000100008001000000010000800100000001000080010000
      800100008001000080010000800100008003800180010000C007C00180010000
      E00FC00BC0030000F83FF03FD00F0001FFFF8001FFFFFFFFE3FF0001F00F8001
      C07FE007E0038001C00FC0038041000180018003801100018000800180010001
      8000000100030001000000018003000100010001800100010001000100010001
      00010001800100018003800180030001E0038003C0070001FC07C003C00F0001
      FF87E007E01F0001FFFFF81FF83FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageListSet2: TImageList
    Left = 789
    Top = 282
    Bitmap = {
      494C01011E002200040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
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
      000000000000000000000000000000000000E6E2E0FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDCDD300CECED600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7E7E700B4B4B400AEAEAE00FEFEFE000000000000000000000000000000
      00000000000000000000D5CDC8FFB66C49FFD38E62FF986956FFFBFAF9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001A1ECC002423D2003842BF000000
      000000000000000000000000000000000000000000000000000000000000AEAE
      AE00D0D0D000C6C6C600C5C5C500F8F8F8000000000000000000000000000000
      0000C5BEBBFFD1814FFFE5AB75FFE5AB75FFE5AB75FFE5AB75FFDC8E56FFC2BC
      BCFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007474BC005453ED002B2BDB000C16
      AA00000000000000000000000000000000000000000000000000B3B3B300DFDF
      DF00C9C9C900B3B3B300E2E2E200000000000000000000000000C3B9B4FFD693
      60FFF5C688FFF5C688FFF5C688FFF5C688FFEABE8CFF8174D8FF4C4CFEFF745E
      B8FF9E7058FFF9F8F8FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002E35C0004D4DE9002C2C
      DB000C16AA0000000000000000000000000000000000B3B3B300C9C9C900C3C3
      C300CACACA00E0E0E000EAEAEA000000000000000000C96439FFFDD99DFFFFDB
      9FFFFFDB9FFFFFDB9FFFE3D790FF34E40CFF2C51CDFF5252FFFF4C4CFEFF0000
      EAFFD7BDA8FFF4BA7BFFDCD7D4FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000252CC2004D4D
      E9002B2BDA00212CBA000000000000000000B4B4B400C6C6C600C6C6C600B1B1
      B100E0E0E000D6D6D600000000000000000000000000CF7C55FFDBA37DFFE6B2
      8AFFF6D7A5FFF2B052FF47BD2FFF2BE401FF2C5BBFFF5252FFFF4C4CFEFF0000
      EAFFB67777FFD7976EFFEBD2C6FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002D34
      C4004E4EEA002827D6009C9EBC00EDEDED00C7C7C700C6C6C600C4C4C400E2E2
      E200D2D2D20000000000000000000000000000000000D1815BFFE1B290FFE1B2
      90FFD4884AFFF0AA49FF4BBD2FFF2BE401FF2C67B2FF5454FEFF7070FCFF0000
      EAFFBF9291FFDEAA85FFF0D7CAFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003F49C2005150EE001F24AB0097979100C3C3C300C5C5C500E2E2E200E8E8
      E8000000000000000000000000000000000000000000D38662FFE5BC9EFFE5BC
      9EFFD4894BFFF0AA49FF50BD2FFF2BE401FF51BA74FF6A6AFDFFA2A2F6FF726E
      D8FFD6AC98FFE2B594FFF1DACEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F700D0D0D500ADADAD009F9F9F00D7D7D700000000000000
      00000000000000000000000000000000000000000000D58C6BFFEAC8B0FFEAC8
      B0FFD58B4DFFF0AA49FF56BD2EFF2BE401FF2ED721FF2FAF00FFE7C1A6FFE7C1
      A6FFE7C1A6FFE7C1A6FFF2DDD3FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000AAAA
      AA009E9E9E00A9A9A900C7C7C700DFDFDF00B5B5B50000000000000000000000
      00000000000000000000000000000000000000000000D89475FFEED4C0FFEED4
      C0FFD58D50FFF0AA49FF5ABD2DFF2BE401FF33D826FF2FAF00FFECCEB9FFECCE
      B8FFECCEB8FFECCEB8FFF3DFD6FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AFAFAF00C7C7C700C6C6
      C600C6C6C600C6C6C600C6C6C600DCDCDC00E5E5E500B1B1B100000000000000
      00000000000000000000000000000000000000000000DB9A7FFFF2DFD2FFF2DF
      D2FFD68F54FFF0AA49FF84CB44FF35E603FF37CE01FF58C832FFF1DBCCFFF1DB
      CCFFF1DBCCFFF1DBCCFFF3DFD6FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CBCBCB00C8C8C800CECE
      CE00C6C6C600C6C6C600D2D2D200EAEAEA0000000000E5E5E500B1B1B1000000
      00000000000000000000000000000000000000000000ECCDC1FFE9BCA4FFF6EA
      E0FFD79258FFF0AA49FFF8A418FFC27F09FFE0EAC8FFF5E7DCFFF5E7DCFFF5E7
      DCFFF5E5D9FFEBB997FFF7E8E2FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D2D2D200B0B0B0000000
      0000E1E1E100C6C6C600C8C8C800DADADA000000000000000000E6E6E600EBEB
      EB0000000000000000000000000000000000000000000000000000000000EAC4
      B5FFD58C52FFF0AA49FFF8A418FFC27D04FFFAF3EEFFF9F0E9FFF2CFB4FFE0A1
      84FFFDFAF9FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00000000000000
      0000AEAEAE00C6C6C600E2E2E200EAEAEA00000000000000000000000000D6D6
      D600E2E2E2000000000000000000000000000000000000000000000000000000
      0000DA9963FFF0AA4AFFF7A422FFC27D04FFE0A17FFFF9F1ECFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BABA
      BA00C9C9C900DEDEDE00BCBCBC00000000000000000000000000000000000000
      0000DADADA000000000000000000000000000000000000000000000000000000
      0000ECC099FFDC8A33FFEC951CFFF6B455FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00B8B8
      B800AEAEAE00CBCBCB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFAF5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBDBD00A3A2A00085848300696766003F3C3C00A3A1A0001D6CB1001D6B
      B2001E6CB200A4A2A1001E1DA7000505C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0BAB700FAFAFA00FFFFFF00F8F8F900F6F7F500F5F5F500F2F4F400F2F3
      F300F1F1F200F2F3F300F2F3F4001F1DA6000000000000000000000000000000
      0000ECEDEE00EDEEEF00919BA000A6B1C500666B78009DA1A600909AA500A8AC
      B200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F9F4F200EFE0DB00EAD8D100EBDAD300F3E9E500FCF9
      F900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D008585
      8500FDFDFD0000000000000000000000000000000000000000009EB8C000A088
      6F00BCA99800FBFDFF00CA994C00E3E2E100C8BABC00CABEBF00CBC0C100CDC2
      C300CEC4C500DED9DB00F5F6F6003B3AA800000000000000000000000000959B
      AF00666E7A0069727B00A0B1C2006F7989005D656E00939EAE0099A9B90096A1
      B100555A6500828B95000000000000000000BBBBBB0083838300000000000000
      0000F6EEEB00E3C9BF00DAAF9B00EBAD8500FECDA700FBC09300E19F7500DFC0
      B400EBD8D100FCFAFA0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2E2E200C3C3C300AEAE
      AE00FAFAFA000000000000000000000000000000000000000000ECCDAC00E6C6
      A900C8B6A700FAFAFA00F0F0F000DAB66D00F9F8F800F8F7F700F7F7F700F6F6
      F600F5F5F500F4F4F400F3F3F3008591980000000000F4F5F500A7B7C4005358
      6300A2B4CB00B3B5B900F7F6F500F3F1F000F9F8F70000000000E4E5E500B2BB
      C50085929A00545A6300979DA400000000006262620020202000837E7C00F3E9
      E500E3C9BE00FAA76700FFCDA800FFDDC400FFE7D600FFE6D300FFD5B600FEC4
      9700DA884E00E9D4CC00FCF9F900000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFC0088888800929292009999
      9900000000000000000000000000000000000000000000000000FFEAD100FFE1
      C400CEBFB500FCFDFF00CFB48C00F0EFEF00E8E2CE00F8F8F800F7F7F800F8F8
      F800F7F7F700F6F6F600F5F6F6008B929700000000008493A00063697600ADB2
      B700E2DEDE0093765700A16E4800A4724800906C4C00A99B9300E2DBD7000000
      0000E5E7E9009BAAB900CDD0D40000000000000000004444440027272700876D
      6100F9A56300FFBF8F00FFCFAB00FFDBC100FFE6D400FFE4D000FFDBC000FFCF
      AA00FFBA8400D77A3100F1E4DF00FEFEFE000000000000000000000000000000
      00000000000000000000000000000000000083838300C2C2C200484848000000
      0000000000000000000000000000000000006E70AD00FFF5EA00FEF0E400E5C2
      A100CEC7C200FDFDFD00F2EBE000D3C3A800F1EFEF00F0EDEE00EFEDED00ECEA
      EB00EBE9EA00EFEDED00F5F5F5007595A500000000005158630096999F00A186
      6E00DC997800D08C7500C67B6B00B96C6600C97F7A00BC7A71006C6F7D00C2B9
      B400CACCCE007E8896008993A4000000000000000000000000004F4F4F002E2E
      2E00895C3900FEA76500FDC49800F8CDAC00F9D7BD00F5D1B600F7C8A400FFC2
      9400FFAA6800FE9C5000D2987300FCFAFA00000000000000000000000000F8F8
      F800BEBEBE0093939200A5A5A500DFDFDF00B0B0B0005F5F5F00F8F8F8000000
      00000000000000000000000000000000000029558200FFF1E500FAE8D900EEE5
      D500BBB7B300FDFDFD00FCFBFC00EEDDB400F6F6F600F9FAFA00F9F9F800F8F8
      F800F7F7F700F6F6F600F5F5F500A7A7A700A9AEB5007C849400726A5D00DC9F
      7500D39C6F00D89B710062E3C6006FC6AD006B967A008C9DB1009AA7B000869A
      B500BBB6B2007A848E0000000000000000000000000000000000E9D4C8008787
      870065656500D5B39800DED4CC00E7D7CA00C8BEB7008E827900FFD3B100EFB9
      9000FFB37A00E7802F00D66F1E00FEFCFC000000000000000000D1D1D100B2AE
      A700D6D3CC00DFDBD400D0CCC500ACA9A300B6B3AE00EAEAEA00000000000000
      00000000000000000000000000000000000000000000FFF2E600DFBFA200C8AF
      9600A7B7BF00FDFDFD00D1C7C900D6D1D700D4CBCE00D3CACC00D3CACB00D2C9
      CA00D2C8C900DED9DB00F5F6F600789BAB00000000007A879800DC9E6A00D9AB
      7800C99D6C00D9A8720061F5D50069DBB50074728F00E5F4F800DEECF100AABA
      C400748090007E838A0000000000000000000000000000000000CE7F3F00D16A
      1900D5D0CD00FDE1BF00FFE4D000FFE5D200FFEDE000FFF2E900817D7B00FED8
      BC00FBCEAB00E17C2D00CD661500FBF6F20000000000F1F1F100E6E3DD00E9E7
      E200CAB9A500CAB07A00DFD9CB00E4E1DB00DCD8D0009C9A9500FEFEFE000000
      000000000000000000000000000000000000FFF2E400947C6300D7BA9F00A888
      7000B5B9BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFF00FDFE
      FE00FAFBFB00F8F9F900F9FAFA00909BA0000000000081726500E5C69E00AC9D
      700047806200E6BF8000ECC47E0065708800CDD5E100CBD7E000CCD5E000C4CD
      D800B1B8C4008B98A700878C9400000000000000000000000000C55E0D00DF78
      2700F6D7A600FEECDC00FFF3EA00FFEADA00FFEEE000FFF3EB00FAF5F200F5E3
      D600F1D8C600F09C5A00CE671600EACBB30000000000DEDAD500DBD9D3009C46
      0C00A2550900B57A0500CAA34500DEC78900E3E0DA00D5D1C900D0D0D0000000
      000000000000000000000000000000000000FFF1E300F7E7DA00C4B2A2009474
      5E00B4BDC400D3D3D200CED0CE00BBC2C400CCC4BD00CEC7C200CDC5BF00BEB5
      AD00C2C1BF00BEB8B400C2BDBA009CACB300FEFEFE00A9835D00EFCFA30077C0
      AB0078AA8C00DFC182008C8A7F00B1BCC400B5BECA00BCC5D100BCC5D100B6BF
      CB00ABB4C000A0A9B400797F8B00000000000000000000000000CA651500F19F
      5F00F1BB5D00FEE3CE00FFEEE200FFE7D500FFEBDB00FFF1E700FFF7F200CEC1
      B800F1BE9600EF934B00CE671600EDD4C100FBFBFB00EEECE700A05A2B009C46
      0C009D4A0A00AD6A0700BA860E00C4972F00C69D3F00E3E0DA00929190000000
      00000000000000000000000000000000000000000000E9E0D700EEE3D700C9B9
      AA00000000000000000000000000C2D1CA00FFFEF800FFF6EE00FFF6EF00FFFF
      FB00A6AC9E0000000000000000000000000000000000A1815900D2BCA00091D7
      C2008AC2AC0082AD8F0075839800A0AEB500A8B1BE00ACB6C200ACB6C200A8B1
      BE00A3AAB60097A5BB00C5C7C800000000000000000000000000D49D6C00FDAA
      6900FCEDE200FAE7D800FFF8F300FFE5D200FFE6D300FFEFE400FFF4EC00E8CD
      B900FDBA8700F5995200DA732200FEFDFD00F2F2F100EFEDE800AF6B4500A95F
      35009C470D00A0500A00AA650700AF6F0600AD6A0700E3E0DA00949391000000
      000000000000000000000000000000000000E3DED900E1D9D100E5DDD600D6CF
      C500E7DFD700DED3CA00D9CEC500F6EBE200FDF0E600FEF9F300CBBEA800CDBA
      A0000000000000000000000000000000000000000000B1998900B7FAF100A6E2
      CF009CD4C00085C3AA00F2D9B60079818B009DA7B4009CA9B6009DA7B4009BAC
      BF0061535200FDFDFD0000000000000000000000000000000000FBF9F600FFB4
      7A00D0CDCB00FEF1E700F9EEE600FFF5ED00FFF1E700FFF1E600CBC4BE00EEB5
      8900FFAD6F00FEA66100D66F1E0000000000FEFEFE00F0EEEA00AD6C4500C08B
      7300AD6741009E4A13009C470B009D490B009C470B00E4E1DB00ACACAA000000
      000000000000000000000000000000000000EAE4DB00DBD5CF00D8D1CB00DDD8
      D100E6E0D900F0EAE300EEE6E000EFE5DD00F3EAE100C6B8AA00000000000000
      0000000000000000000000000000000000000000000000000000C1FFFF00B7EE
      E100ABE4D400A1D7C3008AC5B000DACA9C00AA9F81008B8CA7005A737F005981
      5800C3B1A500000000000000000000000000000000000000000000000000DFA0
      6000FDF3EB00CEC6C100FEFAF700F5F4F300F0EDEB00C7BDB500F8CDAC00FFB7
      7F00FFC89F00FEA76300EEE6DB000000000000000000EAE7E100B1ABA200D5B3
      A600C5948000B16F4D00A1501C009C460C00CAA48600E4E1DB00F7F7F7000000
      0000000000000000000000000000000000000000000000000000C2C4CB00D3CE
      C800D8D1CB00D2CDC600E5DFD700ECE5E000EAE3DA00F0E6E0006A89B1000000
      0000000000000000000000000000000000000000000000000000A98B7500D6FF
      FF00EAE4CC00A6E6DA0099D9CA00EFD6AB00E7C39A007AE8C9007BCCB2008B83
      6100000000000000000000000000000000000000000000000000000000000000
      0000EE9B5800FFECDF00F4E6DC00E7E2DF00F3EDEA00FECAA200FFC09100FFC6
      9A00FFD9BD00D4C09D00000000000000000000000000FEFEFE00EFEDE800B4B0
      A800B47E5F00BC836800AB643B00D2BAA600E5E2DD00BCBAB800000000000000
      0000000000000000000000000000000000000000000000000000BDB7B200CDC9
      C600D2C7B400D2CEC800DCD5D200C7BDAA00ECE8DE00A3947C00000000000000
      000000000000000000000000000000000000000000000000000000000000A27B
      5D00FEFEEC00F7E9D200F3E4BF00EADDBA00EBCAA70099FFF500918D6A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D0B38A00FEE2CE00FFDABE00FFD2B000FFD5B600FFD4B400F6B2
      7D00F2F1E400000000000000000000000000000000000000000000000000E5E2
      DC00EEECE700E9E7E200EAE7E200E6E3DE00D6D5D40000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFA
      F80000000000CAC4C100D1CAC300F1EEE7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0A99000BA926400BE966200C7AE9600E3DBD800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F3EFE900DFCAB400E3D6C400FDFCFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFD00F3F3F800F8F8FA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006C6C9C000E0EE7000101E5000101E5000101E6000101E6002F2FBE00F4F4
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000C24AF000404C6000618AB00060EB000050AB6001B349B00D3D3
      D5008D9FB900ADB5C000BDC2C800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEE4
      E1002AB06F0008D2760008D376001FBC7000D1D9D50000000000000000000000
      0000000000000000000000000000000000000000000000000000ECECF2000707
      E1000001DF000001E0000001E0000001E1000101E2000101E2000000E3000000
      E3008686A4000000000000000000000000000000000000000000000000000000
      000000000000171729000002DA000092F7000314C2000000ED000000ED000000
      0000DDA64800DDA6470000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000013BA6A0008C8
      6F0007C8700007C9700008CA710008CA710008CB71000AC97000FEFEFE000000
      00000000000000000000000000000000000000000000F4F4F7000001DA000000
      DC000001DB00000EBF0008BF7500000000000000000003459C000000DF000000
      DF000000E0008080A40000000000000000000000000000000000000000000000
      00000203C20014173E0008BA7400008FF60008A77A000000EB000000EB000000
      0000DBA34600DBA3460000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000ABD690007C06A0007C1
      6B0007BD67007FD2A70086D4AC0009BD670007C36D0007C46D0008C76F000000
      000000000000000000000000000000000000000000000405D6000001D6000001
      D70007B56B000000000000000000000000000000000000000000000000000101
      D7000101DC000101DC00F5F5F800000000000000000000000000000000000000
      0000000000002227250081CFA900008BF50007A077000001E7000001E7000000
      0000D89E4400D89E440000000000000000000000000000000000000000000000
      000000000000000000005277AF00000000000000000000000000000000000000
      0000000000000000000000000000000000007FA4900055C08B0022BC7300CAEB
      DA0000000000000000000000000000000000E8F6EF0007BE690008BE69004AA0
      7500FAFBFA000000000000000000000000005E7A7A000001D4000001D300B2CF
      D20000000000000000001414D9001717DD001818DD0000000000000000000000
      00000000D8000000D9000F0FC90000000000718383005755A8005755A8009DA6
      A700878686003C3C3C005C5AA4000083F6004E64B0000001E5000000E6007494
      8300D5984100D59841004D4CA700000000000000000000000000000000000000
      0000000000000000000053B4E8004475B0000000000000000000000000000000
      00000000000000000000000000000000000055C08B0055C08B005EB587000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFF3F10019B168000000000000000000292ACD003132DA000001CE000000
      000000000000000000000101D0000101D0000101D00000000000000000000000
      00007B7DB7000000D5000000D600000000008080BC00D7D6D800D7D6D800C3C3
      C300D8D7D8003D3D3D00D0CFD1001786F60099B8D8000101E2000000E300D9D8
      D900D2923F00D2923F00A3A3BB00000000000000000000000000000000000000
      0000000000000000000082BDE400339EE100253D730000000000000000000000
      00000000000000000000000000000000000055C08B0055C08B00000000000000
      00000000000000000000000000000000000007B9660007BB670007BE690008C0
      6A0008C36C0008C06A000DBC6A00000000003D3EDB003839DB007474AA000000
      000000000000000000000101CA000101CB000001CA0000000000000000000000
      0000000000000000D2000000D300F9F9FB008889C200DAD9DB00DAD9DB00C5C5
      C5005D5D5D0035353500D2D1D300599EF7009BB8DA00494AE0004E4DDE00DBDA
      DB00D8A57700D49B6000A4A4BC00000000000000000000000000000000000000
      00000000000083B9D4000000000024BFEF001D8FDD004D7FB800000000000000
      00000000000000000000000000000000000055C08B0055C08B00000000000000
      00000000000000000000000000000000000055C08B003DBB7D000BB1610007B3
      610007B7640008BA660008BD6900B6D7C6004344DC003D3EDB00B4B4D1000000
      000000000000000000000101C4000101C4000001C40000000000000000000000
      0000000000000000CF000000CF00AECEC2008A8BC300B4C5CE00B5C6CE00A7B8
      C100B5C6CE004A4D4F00AEBEC7005E9FF70080A7D000B4C6CD00ACBDC500B5C6
      CF00D8A57700D2985F00A5A5BD00000000000000000000000000000000000000
      000000000000699CB600376887003768870045BEE1001E8FDD00576C9A000000
      00000000000000000000000000000000000055C08B0055C08B00F9FBFA000000
      00000000000000000000000000000000000065BE900066C1920065C1910063C3
      91005CB7870056C18C00B1DAC50000000000494ADD004344DC006162A0000000
      000000000000000000002020CE000101C0000001C00000000000000000000000
      00005BB486000000CC000000CC00FDFDFE008E8EC5009CC4D9009CC4D90092B8
      CA005D5D5D003B3B3B009CC4D9009CC4D9009CC4D9009CC5D90095BCCF009DC6
      D900D8A57700D0945D00A7A6BD00000000000000000000000000000000000000
      0000000000000000000073DDF40007A8E900407ED3007A93A800000000000000
      00000000000000000000000000000000000055C08B0055C08B0042A070000000
      00000000000000000000000000000000000000000000D8DDDA00D7DDDA00D7DD
      DA00F0F4F200ABD7C00000000000000000003C40C900494ADD004243DB000000
      000000000000000000004343DC003D3DDB003838DA0000000000000000000000
      000054559D001717D8001717D800000000008A8BBD0090CAE80090CAE80085BB
      D50091CBE800454F540090CAE80090CAE80090CAE80091CBE80089C0DB0091CB
      E80091CBE80091CBE800ABABC100000000000000000000000000000000000000
      0000000000000000000090CFEE004DD0F3000A9DE5005375CE006E8E9D000000
      000000000000000000000000000000000000C1DDCE0055C08B0055C08B007297
      83000000000000000000000000000000000093A59B0055C18C0055C18C008DBF
      A40000000000000000000000000000000000B3CCC9004F50DD00494ADD00475E
      630000000000000000004545CD003939CE003030CD0000000000000000008ABB
      A3001717D7001616D7002E2EC20000000000B6BFBF009AD8F8009AD8F8008BC3
      DE00779EB100779EB1009AD8F8009AD8F8009AD8F8009AD9F80090CBE8009BD9
      F8009AD8F8009AD8F800AFAFC000000000000000000000000000000000000000
      0000000000000000000000000000ABF0F70029C2F0001893DF00626FCA00AAAA
      A50000000000000000000000000000000000000000004FB4800055C08B0055C0
      8B0055C08B00469C70004999700054C08A0055C18C0055C18C0050BD86000000
      000000000000000000000000000000000000000000005657DC004F50DD004A4B
      DD00387E670000000000000000000000000000000000000000004CB383002121
      D8001C1CD7001717D7000000000000000000D3D3D3008BC3DF008BC3DF0081B5
      D0008BC3DE008BC4DE008BC4DE008BC4DF008BC4DF008BC4DF0084BBD5008BC3
      DF008BC3DF008BC3DF00C8C8C800000000000000000000000000000000000000
      000000000000000000000000000094D1EB008ECFEE0081CCEC006CB5DB005E8C
      AC0000000000000000000000000000000000000000000000000060B5890055C0
      8B0055C08B0055C08B0055C08B0055C08B0055C08B0055B38300000000000000
      00000000000000000000000000000000000000000000000000005859DF005051
      DD004B4CDD003B3CD6002C646200489F7D00387F66001C23B2002C2CD9002727
      D9002222D800D1D1F0000000000000000000D4D4D500F1F1F100F0F0F100D6D6
      D700F0F0F100F0F0F100F0F0F000F0F1F000F0F0F000F0F0F100DFDFE000F0F0
      F100F0F0F100F1F1F100CACACA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008DC9AA0054BA860051B9840085C8A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006767
      E1005151DD004B4CDD004647DC004242DC003D3DDB003737DA003232DA002F2F
      DA00E1E1F500000000000000000000000000D5D5D6005992E2005992E2005286
      D0005891E2005891E2005891E2005891E2005891E2005891E200548AD6005891
      E2005992E2005992E200CCCCCC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6D6F0006E6EE1004D4DDD004747DC004242DC005A5AE2007F7FD2000000
      000000000000000000000000000000000000F2F2F200E8E9EB00E7E8EB00E7E8
      EB00C9CAE0007C7DD5006465D2005F60D1005C5DD1006D6ED600898ACA00E7E8
      EB00E7E8EB00E8E9EB00EAEBEC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFCFB00ECF2
      EB00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00DDE6D900D6E1
      D100E1E9DE000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FAF5EE00F5DEC200F3C4
      8900F8D5AB00FEFEFD0000000000000000000000000009A7320013962A000B90
      2300119D2D00000A030000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F6F6F600EBEBEB00E3E3
      E300DEDEDE00D9D9D900DBDBDB00DFDFDF00E7E7E700F0F0F00084B57F000079
      0100F2F6F100000000000000000000000000FEFEFE00F6F6F600EBEBEB00E3E3
      E300DEDEDE00D9D9D900DBDBDB00DFDFDF00E7E7E700F0F0F000099324000C93
      25000E891F000000000000000000000000000000000000000000D5904E00D594
      5600D5965700D5965700D5965700D5965700DA934D007D460E00B96D0500DC8E
      0F00DF850000EFC69400FBE5CB000000000002B13600009D270023AF49000FA7
      3700009D2500009F240072686E009D9B9B00A5A4A4007D7D7D00121313000000
      0000000000000000000000000000000000006C6C6C0076767600828282008B8B
      8B009191910096969600939393008C8C8C00838383005D74590000820A000083
      0D001A8E2500FAFCFA0000000000000000006C6C6C0076767600828282008B8B
      8B009191910096969600939393008C8C8C0083838300787878000AA13000009C
      260015982F000000000000000000000000000000000000000000DDA36400E0AC
      7200E0AD7400E0AD7400E0AD7400E0AD7400BA680100C8700000E8900000E892
      0000E8950200E7A72000E49D1800FEFCFB0001B0370038C466006ED79200FFFF
      FF0052CC7A0000A82C00A4BAA800DCDAD900EFEFEE00FFFFFF00FFFFFF00DCDB
      DA0008080800000000000000000000000000515151007272720096969600B8B8
      B800DDDDDD00F5F5F500DEDEDE00BEBEBE008D958B0000911B0000911D000094
      1F000095200057A85D00FEFEFE0000000000515151007272720096969600B8B8
      B800DDDDDD00F5F5F500DEDEDE0089A080005E8053004C6D410017B74A0000AC
      350020AD460096B88C0092B68800C3D6BD000000000000000000E5B27800E8BD
      8900E8BF8C00E8BF8C00E8BF8C00E8BE8B00E68E0000E5930000BF6E0000E89C
      0000E89E000098530300C16A01000000000026CB620016C95800FFFFFF00FFFF
      FF00FFFFFF0013C15000BCD8C400DFDEDD00DEDDDC00DBD9D800DFDEDD00ECEC
      EC00C1BEBD00000000000000000000000000626262008B8B8B00A6A6A600BDBD
      BD00E5E5E500F1F1F100DCDCDC00BABEBA00049C2900009E290000A22D0000A5
      300000A6310000A631009CC5990000000000626262008B8B8B00A6A6A600BDBD
      BD00E5E5E500F1F1F100DCDCDC0086A7830001C64A0000C54A0000C0460000BC
      430000B53C0000AF370001A73000CEDFCB000000000000000000ECC18E00F0CF
      A200F0D0A500F0D0A500F0D0A500F2C69200E8A40000C47700006D320000F3BD
      7D00E8AF0000E5A60100C4851700AB5F0E002EE876002EE27B0066EEA100FFFF
      FF002EE27B0042DD7E00BCB2B600CAC9C800E1E0DF00E8E8E800D2D1D000CCCA
      C900E4E4E300363635000000000000000000616161008B8B8B00A6A6A600BCBC
      BC00ECECEC00F3F3F300DCDCDC002EA850001BB555000FB54D0007B6460004B7
      460006B9490013BF58001CC46600DAE7D800616161008B8B8B00A6A6A600BCBC
      BC00ECECEC00F3F3F300DCDCDC00C2C2C20053A2620017D765000CD35C0008CE
      55000AC6500017C1530093C59500000000000000000000000000F3D1A100F8E0
      BA00F8E2BD00F8E2BD00F8E2BD00F8E2BC00EBAD1900D3921300C56D0000F6B9
      6900E8AD0800E8AE0000A7741600E5B48000000000006BDF9D00BCFBD800A8F6
      CA007FF5B3009FB0A300CECDCB00E5E5E400F2F2F100FFFFFF00FFFFFF00DCDA
      DA00BAB9B700545454000000000000000000565656007979790098989800B0B0
      B000C0C0C000CDCDCD00C4C4C4009DAB9D0088978900667C67004BDC94003AD7
      88006BCF9000DFEDDF00DCEBDC00FAFCFA00565656007979790098989800B0B0
      B000C0C0C000CDCDCD00C4C4C400B3B3B3009C9C9C0067CD8A004FEA92004FE7
      8F004BDF870076C98A0000000000000000000000000000000000F8DCB200FDED
      CD00FDEED000FDEED000FDEED000FDEED000F5BE6600E8CB5300CB901100C184
      1500E8B21900DE9E0400B3610000F8E8D50000000000000000006B6E6C00D0DB
      D400EAE1E500DBDAD900DDDCDB00DDDCDB00DBDAD900D9D8D700D8D6D500EBEB
      EB00B3B1AF002D2D2D000000000000000000555555007B7B7B009D9D9D00BDBD
      BD00E2E2E200FBFBFB00E3E3E300C2C2C200A0A0A0007B7D7B006FEEB7005BE8
      A7007CCF9700000000000000000000000000555555007B7B7B009D9D9D00BDBD
      BD00E2E2E200FBFBFB00E3E3E300C2C2C200A0A0A0007E7E7E00B2F8D10082F0
      B20094EAB6000000000000000000000000000000000000000000F9E2BB00FFF3
      D800FFF5DB00FFF5DB00FFF5DB00FFF5DB00FEE5C000EFBF5F00E8CA4D00E8BE
      3000E8B21700E8AD0500EE9C2300000000000000000000000000C9C8C800D0CF
      CD00C6C4C300AEABA900B4B1AF00CFCDCC00E9E8E800FBFBFB00E3E3E300C8C7
      C500DFDFDE009493930000000000000000006565650091919100ADADAD00C7C7
      C700EDEDED00FDFDFD00E7E7E700CBCBCB00B0B0B00093949300A8FFE30098FC
      D50082D79F000000000000000000000000006565650091919100ADADAD00C7C7
      C700EDEDED00FDFDFD00E7E7E700CBCBCB00B0B0B0009494940066696500DFFF
      F700000000000000000000000000000000000000000000000000F9E4C100FFF6
      DF00FFF8E200FFF8E200FFF8E200FFF8E200FFF8E200FFE7C400E9BE3C00ECAF
      2100D18B1100EBAF700000000000000000000000000000000000C6C6C600C7C6
      C500ADAAA800C7C5C400E5E4E400EDEDEC00EFEFEE00F8F8F700FFFFFF00DDDC
      DB00B3B2B000A8A8A80000000000000000006565650091919100ADADAD00C5C5
      C500F3F3F300FDFDFD00E7E7E700CBCBCB00B0B0B000949494006A6A6A000000
      0000000000000000000000000000000000006565650091919100ADADAD00C5C5
      C500F3F3F300FDFDFD00E7E7E700CBCBCB00B0B0B000949494006A6A6A000000
      0000000000000000000000000000000000000000000000000000F9E6C600FFF9
      E500FFFBE900FFFBE900FFFBE900FFFBE900FFFBE900FFFBE900FFFBE900FFF4
      DC00FFF3DC00F5EEE30000000000000000000000000000000000ACACAC00E6E6
      E500DDDCDB00D6D5D300DAD9D700DCDAD900DBDAD800D9D8D600D4D3D100E0DF
      DE00BEBCBB00989898000000000000000000565656007878780096969600ADAD
      AD00C1C1C100C8C8C800C0C0C000AFAFAF00989898007B7B7B00585858000000
      000000000000000000000000000000000000565656007878780096969600ADAD
      AD00C1C1C100C8C8C800C0C0C000AFAFAF00989898007B7B7B00585858000000
      0000000000000000000000000000000000000000000000000000F9E8CB00FFFA
      EB00FFFDEE00FFFDEE00FFFDEE00FFFDEE00FFFDEE00FEFCEE00FEFCEE00FEFC
      EE00FEF7E400F3EEE60000000000000000000000000000000000CCCCCC00C6C4
      C200CECCCA00D1CFCE00D3D2D000D4D3D200D3D3D100D2D1CF00D0CECD00CCCB
      C900D2D1D0009292920000000000000000006666660091919100B7B7B700D6D6
      D600F0F0F000FFFFFF00F1F1F100D6D6D600B4B4B4008D8D8D00636363000000
      0000000000000000000000000000000000006666660091919100B7B7B700D6D6
      D600F0F0F000FFFFFF00F1F1F100D6D6D600B4B4B4008D8D8D00636363000000
      0000000000000000000000000000000000000000000000000000F9E9CE00FFFB
      EF00FFFEF300FFFEF300FFFEF300FFFEF300FEFDF200FAF7EB00F2EFE100F5F1
      E400F6EDDB00EAE5DC00FEFEFE00000000000000000000000000C3C3C300C8C6
      C400C8C7C500C9C8C600CBC9C800CCCAC900CCCAC800CAC9C700C9C7C500C8C6
      C400C3C1C000AAAAAA00000000000000000078787800AAAAAA00C8C8C800E0E0
      E000F7F7F700FFFFFF00F3F3F300DDDDDD00C2C2C200A4A4A400737373000000
      00000000000000000000000000000000000078787800AAAAAA00C8C8C800E0E0
      E000F7F7F700FFFFFF00F3F3F300DDDDDD00C2C2C200A4A4A400737373000000
      0000000000000000000000000000000000000000000000000000F9E9D100FFFB
      F200FFFEF600FFFEF600FFFEF600FFFEF600FDFCF500EAE4D600CABEA500CCBE
      A600DDCDB600E6E0D600FEFEFE00000000000000000000000000A2A2A300BAB9
      B700D3D1D000D3D1D000D4D2D100D4D3D100D4D2D100D3D2D100D3D1D000D5D3
      D200B9B7B50093939300000000000000000086868600B3B3B300CDCDCD00E2E2
      E200FAFAFA00FFFFFF00F4F4F400DFDFDF00C7C7C700ADADAD00828282000000
      00000000000000000000000000000000000086868600B3B3B300CDCDCD00E2E2
      E200FAFAFA00FFFFFF00F4F4F400DFDFDF00C7C7C700ADADAD00828282000000
      0000000000000000000000000000000000000000000000000000F9E9D400FFFB
      F500FFFDF900FFFDF900FFFDF900FFFDF900FCFAF500DED6C700F5CD9D00D5B2
      7B00C2A57400F9F8F6000000000000000000000000000000000000000000B9B9
      B800B0AFAD00DEDDDC00E2E1E000E0DFDE00E0DFDE00E3E2E100D9D7D600B0AF
      AD00A6A7A700000000000000000000000000C2C2C200D8D8D800E8E8E800F3F3
      F300FEFEFE00FFFFFF00FBFBFB00F2F2F200E6E6E600D6D6D600C0C0C0000000
      000000000000000000000000000000000000C2C2C200D8D8D800E8E8E800F3F3
      F300FEFEFE00FFFFFF00FBFBFB00F2F2F200E6E6E600D6D6D600C0C0C0000000
      0000000000000000000000000000000000000000000000000000F9E5D000FFF6
      EE00FFF8F200FFF8F200FFF8F200FFF8F200FDF6EF00E7DCCE00FFE9CD00D3B8
      8800F4F2EE00FEFEFE0000000000000000000000000000000000000000000000
      000097979700B7B7B700B5B4B300B0AFAD00B0AFAE00B6B5B400B3B3B3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EBD8B900EDDC
      BF00EEDEC300EEDEC300EEDEC300EEDEC300ECDBC000E7D5B800D0B88E00F6F5
      F100FEFEFE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEF400DCDC
      F300DBDBF300F5F5FB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00FAFAFA00FAFAFA00FBFBFB00FBFBFB00F9F9F900FDFDFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00F9F9F900FAFAFA00FAFAFA00FBFBFB00F9F9F900FBFBFB00FEFE
      FE0000000000000000000000000000000000FEFEFE00F6F6F600EBEBEB00E3E3
      E300DEDEDE00D9D9D900DBDBDB00DFDFDF00E7E7E7006A6AC5001717C6001414
      C5001515C4001818B200F4F4FB00000000000000000000000000000000000000
      000000000000FBFBFB00F9F9F900F7F7F700F9F9F900FBFBFB00FDFDFD000000
      0000000000000000000000000000000000000000000000000000FEFEFE00F8F8
      F800DCDCDC00AAAAAA00DDDDDD00ECECEC00E7E7E700B9B9B900BCBCBC00F8F8
      F800FDFDFD000000000000000000000000000000000000000000FEFEFE00F8F8
      F800E1E1E100AAAAAA00E3E3E300F5F5F500F3F3F300D4D4D400A7A7A700F5F5
      F500FBFBFB000000000000000000000000006C6C6C0076767600828282008B8B
      8B009191910096969600939393008C8C8C003B3B96000707CF000000CF000000
      D0000000CF000000CC001313B600F4F4FB00EFEFEF00D1D1D100C5C5C500CFCF
      CF0076767600BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00AEAEAE00A7A7
      A700C1C1C100CCCCCC00E2E2E200FDFDFD0000000000FEFEFE00F9F9F900AEAE
      AE00F2F2F200DEDEDE00E3E3E300E5E5E500E5E5E500E0E0E000E6E6E600DBDB
      DB00E7E7E700FCFCFC0000000000000000000000000000000000FAFAFA00A7A7
      A700F4F4F400DEDEDE00E4E4E400E6E6E600E6E6E600E3E3E300DFDFDF00F6F6
      F600BCBCBC00F9F9F9000000000000000000515151007272720096969600B8B8
      B800DDDDDD00F5F5F500DEDEDE00BEBEBE000D0DD5000000DA000000DD000000
      DE000000DE000000DB000000D700A0A0E000EDEDED00E2E2E200E0E0E000EDED
      ED00C3C3C300B9B9B900DEDEDE00DEDEDE00DEDEDE00F3F3F300AFAFAF00E8E8
      E800DEDEDE00E0E0E000E8E8E800FBFBFB0000000000FBFBFB00CACACA00E2E2
      E200E6E6E600E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E4E4
      E400F5F5F500E5E5E500FDFDFD000000000000000000FAFAFA00B7B7B700E3E3
      E300E6E6E600E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E6E6
      E600F0F0F000B2B2B200FAFAFA0000000000626262008B8B8B00A6A6A600BDBD
      BD00E5E5E500F1F1F100DCDCDC00C2C2C2000F0FE200ACACF800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000E300A4A4E2000000000000000000000000000000
      00009D9D9D00C0C0C0000000000000000000000000009E9E9E009C9C9C000000
      000000000000000000000000000000000000FAFAFA00A9A9A900E6E6E600E7E7
      E700E8E8E800E7E7E700EEEEEE00E9E9E900EAEAEA00E9E9E900E9E9E900E8E8
      E800E7E7E700E4E4E400FCFCFC0000000000FCFCFC00ADADAD00E9E9E900E7E7
      E700E8E8E800E9E9E900E9E9E900E9E9E900E9E9E900EAEAEA00E9E9E900E8E8
      E800E8E8E800F3F3F300E9E9E900FEFEFE00616161008B8B8B00A6A6A600BCBC
      BC00ECECEC00F3F3F300DCDCDC00C2C2C2003737F2001616F6000101F9000101
      FA000000F9000909F6002828F400A2A2E3000000000000000000000000000000
      000000000000C1C1C100C1C1C1000000000000000000C2C2C200EEEEEE000000
      000000000000000000000000000000000000F3F3F300F2F2F200E8E8E800E9E9
      E900EBEBEB005757570040404000EAEAEA00EDEDED00EBEBEB00EBEBEB00EAEA
      EA00E9E9E900EBEBEB00B0B0B000FDFDFD00FDFDFD00EEEEEE00E8E8E800E9E9
      E900F0F0F0007575750074747400F2F2F200F1F1F1007878780074747400F0F0
      F000E9E9E900E9E9E900BBBBBB00FCFCFC00565656007979790098989800B0B0
      B000C0C0C000CDCDCD00C4C4C400B3B3B3004F4FB5005656FF005454FF005858
      FF005656FF004949FF005959F800FEFEFE000000000000000000000000000000
      000000000000C0C0C000D4D4D400000000009D9D9D008E8E8E00000000000000
      000000000000000000000000000000000000AEAEAE00EAEAEA00EAEAEA00EBEB
      EB00EDEDED005C5C5C00343434002C2C2C006B6B6B00FAFAFA00EDEDED00ECEC
      EC00EBEBEB00EAEAEA00D4D4D400FEFEFE00C4C4C400ECECEC00EAEAEA00EBEB
      EB00F7F7F700292929002A2A2A00F7F7F700F8F8F8002C2C2C002B2B2B00F5F5
      F500ECECEC00EAEAEA00F0F0F000FDFDFD00555555007B7B7B009D9D9D00BDBD
      BD00E2E2E200FBFBFB00E3E3E300C2C2C200A0A0A0004646AC00A0A0FF009E9E
      FF009B9BFF008383FC0000000000000000000000000000000000000000000000
      00000000000000000000B8B8B8008E8E8E00BEBEBE00F9F9F900000000000000
      000000000000000000000000000000000000BEBEBE00EBEBEB00ECECEC00EDED
      ED00F0F0F0005F5F5F003A3A3A00393939003838380029292900A1A1A100F8F8
      F800EDEDED00ECECEC00EEEEEE0000000000AFAFAF00EBEBEB00ECECEC00EDED
      ED00F9F9F900292929002A2A2A00F9F9F900FAFAFA002C2C2C002B2B2B00F6F6
      F600EEEEEE00ECECEC00EFEFEF00DEDEDE006565650091919100ADADAD00C7C7
      C700EDEDED00FDFDFD00E7E7E700CBCBCB00B0B0B0009494940064646C00F0F0
      F800EFEFF7000000000000000000000000000000000000000000000000000000
      00000000000000000000D8D8D800BDBDBD008686860000000000000000000000
      000000000000000000000000000000000000C8C8C800F0F0F000EDEDED00EFEF
      EF00F1F1F100676767004545450044444400424242003F3F3F003B3B3B002424
      2400F8F8F800F0F0F000F2F2F200FEFEFE00B2B2B200F1F1F100EDEDED00EFEF
      EF00FBFBFB003232320031313100FAFAFA00FBFBFB003434340032323200F6F6
      F600EFEFEF00EFEFEF00F2F2F200D0D0D0006565650091919100ADADAD00C5C5
      C500F3F3F300FDFDFD00E7E7E700CBCBCB00B0B0B000949494006A6A6A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009D9D9900A6A6A600ABABAB0000000000000000000000
      000000000000000000000000000000000000C5C5C500F3F3F300F4F4F400F2F2
      F200F3F3F3006F6F6F0051515100515151004E4E4E004242420086868600FFFF
      FF00F4F4F400F4F4F400F5F5F50000000000B5B5B500F3F3F300F4F4F400F3F3
      F300FBFBFB004040400041414100FAFAFA00FDFDFD00444444003F3F3F00F5F5
      F500F4F4F400F4F4F400F6F6F600E0E0E000565656007878780096969600ADAD
      AD00C1C1C100C8C8C800C0C0C000AFAFAF00989898007B7B7B00585858000000
      0000000000000000000000000000000000000000000000000000F7F7FD00A4A4
      EB00000000005757FB001818BA000000000076769D000000D20000000000D3D3
      FB00B7B7EF00000000000000000000000000B5B5B500F6F6F600F6F6F600F7F7
      F700F9F9F900AFAFAF00959595008D8D8D009A9A9A00FCFCFC00FAFAFA00F8F8
      F800F7F7F700F6F6F600E0E0E00000000000CACACA00F7F7F700F6F6F600F7F7
      F700FCFCFC009A9A9A008E8E8E00FCFCFC00FEFEFE00939393009C9C9C00F8F8
      F800F8F8F800F6F6F600FAFAFA00000000006666660091919100B7B7B700D6D6
      D600F0F0F000FFFFFF00F1F1F100D6D6D600B4B4B4008D8D8D00636363000000
      00000000000000000000000000000000000000000000AFAFF1000404D3006F6F
      FB001F1FEE000505DA00DADAF70000000000000000000000D1000707E9002A2A
      FA004747EC000808D4000000000000000000F9F9F900FDFDFD00F8F8F800F8F8
      F800FAFAFA00BFBFBF00B2B2B200F0F0F000FEFEFE00FCFCFC00FBFBFB00F9F9
      F900F9F9F900FAFAFA00BABABA00FEFEFE0000000000FAFAFA00F8F8F800F8F8
      F800FDFDFD00B2B2B200B1B1B100FDFDFD00FFFFFF00B3B3B300B2B2B200F8F8
      F800F9F9F900F9F9F900C9C9C900FEFEFE0078787800AAAAAA00C8C8C800E0E0
      E000F7F7F700FFFFFF00F3F3F300DDDDDD00C2C2C200A4A4A400737373000000
      000000000000000000000000000000000000000000000000DD00000000000000
      00005D5DEA002727EB00000000000000000000000000EFEFFD000303E5000000
      0000000000000505B600FDFDFE0000000000FEFEFE00BBBBBB00FCFCFC00FAFA
      FA00FBFBFB00F2F2F200FFFFFF00FEFEFE00FEFEFE00FDFDFD00FDFDFD00FBFB
      FB00FBFBFB00F4F4F4000000000000000000FEFEFE00BABABA00FCFCFC00FAFA
      FA00FBFBFB00FEFEFE00FFFFFF00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FBFB
      FB00FAFAFA00FEFEFE00F3F3F3000000000086868600B3B3B300CDCDCD00E2E2
      E200FAFAFA00FFFFFF00F4F4F400DFDFDF00C7C7C700ADADAD00828282000000
      000000000000000000000000000000000000000000000000DC00000000000000
      00000000EF0000000000000000000000000000000000000000004040FF00B2B2
      E3000000000018189A00EDEDFD00000000000000000000000000E3E3E300FDFD
      FD00FCFCFC00FDFDFD00FEFEFE00FEFEFE00FFFFFF00FEFEFE00FDFDFD00FDFD
      FD00FFFFFF00F1F1F10000000000000000000000000000000000D1D1D100FDFD
      FD00FCFCFC00FDFDFD00FEFEFE00FEFEFE00FFFFFF00FEFEFE00FEFEFE00FCFC
      FC00FEFEFE00C3C3C300FEFEFE0000000000C2C2C200D8D8D800E8E8E800F3F3
      F300FEFEFE00FFFFFF00FBFBFB00F2F2F200E6E6E600D6D6D600C0C0C0000000
      000000000000000000000000000000000000000000006666FF001515B3003636
      E200F4F4FF000000000000000000000000000000000000000000000000002F2F
      FF002B2BA9000707FB000000000000000000000000000000000000000000CBCB
      CB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00F3F3
      F300F6F6F600FEFEFE000000000000000000000000000000000000000000C1C1
      C100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CFCFCF00FEFEFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEEEEE00C8C8C800F6F6F600FFFFFF00FBFBFB00D7D7D700CFCFCF000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00F5F5F500C8C8C800F8F8F800FFFFFF00FFFFFF00EDEDED00C0C0C0000000
      0000FEFEFE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F3F6F200E5ECE200E2EA
      DF00E2EADF00E2EADF00E2EADF00E2EADF00E2EADF00E2EADF00E2EADF00E2EA
      DF00E3EBE000EFF3ED00FDFDFD000000000000000000FBFBFD00F1F1FA00EEEE
      F900EEEEF900EEEEF900EEEEF900EEEEF900EEEEF900EEEEF900EEEEF900EEEE
      F900EFEFF900F7F7FC00FEFEFE00000000000000000000000000000000000000
      00001F5E00001F5E0000205B0000215A0000205B00001F5D00001F5E00001F5E
      0000000000000000000000000000000000000000000000000000D5904E00D594
      5600D5965700D5965700D5965700D5965700D5965700D5965700D5965700D595
      5700D5935400F3EAE1000000000000000000EAF0E80094BB8D0036A4490034A4
      480034A4480034A5480034A5490034A5480034A4480034A4480034A4470034A2
      460034A1450073AF7100E2EADE00FEFEFE00F6F6FC00CACAEE006969D6005D5D
      D4005D5DD4005D5DD4005D5DD4005D5DD4005D5DD4005D5DD3005D5DD3005D5D
      D3005E5ED200A3A3E200E7E7F700FEFEFE0000000000000000001F5E00001F5E
      00001E6002000A881900159C300023A03B001B9D35000B92220014730C00215A
      00001F5E00000000000000000000000000000000000000000000DEA36500D2A1
      6B00D1A26C00DAA97100DEAC7300E0AE7400E0AE7400E0AE7400E0AE7400E0AE
      7400E0AA6F00F3EBE2000000000000000000ABC9A5000F902400008B1700008D
      1900008F1A0000901B0000911C0000911C0000901B00008F1A00008D1900008B
      1600008714000284130066AE6A00F7F9F700DADAF3003232CC000000B7000000
      B9000000BA000000BC000000BC000000BD000000BC000000BC000000BA000000
      B8000000B6001919BB008B8BDD00F9F9FC00000000001F5E0000205B0000098D
      1B0027A7440010962900008D1800008C1600008C1700038E1C001F9A35000C9B
      2A001E6203001F5E000000000000000000000000000000000000E5B278005552
      4F002C3B3E0051A2B800718E8A00BF9D7300E7BE8B00E8BF8C00E8BF8C00E8BF
      8C00E8BA8600F4ECE30000000000000000003EA64E0000911D00009521000098
      220000992500009B2600009B2500009B2500009A250000982400009623000094
      200000921D00008E1A0002952100F7F9F7007B7BDE000000BC000000C1000000
      C3000000C4000000C6000000C7000000C7000000C7000000C6000000C4000000
      C3000000C0000000BD000909C300F5F5FB0000000000205B0000069D2800119E
      310000952000009723000097220000951C0000941C0000962200009420000090
      1C00109C2F001D6405001F5E0000000000000000000000000000ECC18E00B0A5
      94005BC2DC0057DAFF0055D8FF0072686300C8AE8900EFD0A400F0D0A500F0D0
      A500F0CC9E00F4EDE400000000000000000038A54B00009A2500009E2700009F
      2A0000A22B0000A32C0037B75B00009E2000009D1F0015AA3D0000A02900009D
      2700009A24000096210000982400F7F9F7006464DA000000C6000000C9000000
      CB000000CD000000CD000101CF000000CE000000CD000000CD000000CC000000
      CB000000C8000000C6000202C500F6F6FB001F5E00000F8418000AA13100009C
      2700009F2A0000A12B0060C57B00FBFEFC00F8FDFA00009A1F00009D2800009A
      250000952000049F2B00215A0000000000000000000000000000F3D1A100E1CE
      AE007BE6FF007EE9FF0071E0FF00102026006D635C00D5C2A200F7E1BC00F8E2
      BD00F8DDB500F5EEE600000000000000000038A74E0002A32E0002A6300001A9
      320000AA330000A92B0070B17700FFFFFF00FFFBFF0028A0410000A4270000A5
      2F0000A22B00009E2800009C2900F7F9F7006565DC000000CD000000D0000000
      D2000000D4000000D500F0F0F200EAEAFE00FFFFFF002222D1000000D4000000
      D3000000D0000000CD000202C900F6F6FB002159000004B43B0000A22B0000A6
      300000A8320000AA320070D08D00FFFFFF00FFFFFF0000A4260000A6300000A3
      2D00009F2900029B2700108418001F5E00000000000000000000F8DCB200FAE8
      CA0083E6FE007DD9EE0090F7FF005BE9FF000F2A3300695F5700E0D2B800FDEE
      D000FDE9C800F5EFE600000000000000000038A9500016B2440018B649001BB9
      4E0038C56600FFFFFF002DC35F0000B02F0000AF2A004EC87300FFFFFF0003AC
      310000AA320000A52E0000A02D00F7F9F7006464DE001212D7001515DB001919
      DE002B2BE200C4C4F7000000E0000000CE000000D7003E3EE5009F9FF2000000
      D9000000D7000000D4000202CC00F6F6FB0017740E0001A9330000AC330000AE
      360000B0370000B338006ED59000FFFFFF00FFFFFF0000AD2B0000AE350000AA
      320000A8310000A22C0001A52C00205B00000000000000000000F9E2BB00FFF3
      D700ECE3CC005D5756005C85870095F8FF005EEBFF0012394500675F5700E6DD
      C500FEEFD200F4EFE700000000000000000037AC520026BD560027C15A0024C3
      5B0025B04E00FFFBFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D4E1D20000B0
      320000AF340000AD350000A43200F7F9F7006464E0002222DF002424E3001D1D
      E5006868D300FFFFFF00FFFFFF00F7F7FE00FFFFFF00FFFFFF00D6D6EA000000
      E1000000DF000000DC000202D000F6F6FB000D9A280000AE360000B33B006FD7
      9200E1F7E900E1F7E900EEFBF300FFFFFF00FFFFFF00E0F6E700E1F7E800E2F6
      E80000AC2E0000AA330006AC3600215900000000000000000000F9E4C100FFF6
      DF00FFF8E200F5F0DA006B6664004D6D6F0098F8FF0063EEFF00154A5B005F5D
      5600EDE2CA00F3EDE600000000000000000036AE540035C868002CC96300FFFF
      FF008BE4AC002BCD67004AA85D0090BD930088BB8C003CAB57003ED37600C4F0
      D300DFF6E70000B0320000A73600F7F9F7006464E2003232E6002828EA00FFFF
      FF003F3FF1002828D7009898D700D2D2EA00B9B9E1004949CD003333F100D5D5
      FB004C4CED000000E3000202D400F6F6FB0012AB390019BD510001BC43008FE3
      AD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000B3320012B7470019B74A001F5B00000000000000000000F9E6C600FFF9
      E500FFFBE900FFFBE900F9F6E4007F7A77003D5657009BF8FF0098CFD5003B3B
      3B00A6A0B300F2EDE600000000000000000035B056003ED27400FFFFFF00FFFF
      FF00FFFFFF00FDFFFE0099ECBA006DE79E0075E7A300B8F0CE00FFFFFF00FFFF
      FF00FFFFFF00A7E1B90000AB3A00F7F9F7006465E1003938EC00FFFFFF00FFFF
      FF00FFFFFF00C9C9FC006262FA005050FB005C5CFB009E9EFA00FFFFFF00FFFF
      FF00FFFFFF002A2AEC000101D800F6F6FB00189D310020C65B0022CC62007AE3
      A200D8F7E400D3F7E100E7FBEF00FFFFFF00FFFFFF00D3F6E000D3F6E100DBF7
      E50016C5560021C358002EC76100205700000000000000000000F9E8CB00FFFA
      EB00FFFDEE00FFFDEE00FFFDEE00FCFAEC009E9B96008283840097979900A399
      CD00A89FB900F0EBE600000000000000000034B2560055DA88003DC86E00F0F1
      ED00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B6D1B60018C7550000AE3E00F7F9F7006768E1005252F4004B4BD400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A7A7DC000C0CF2000101DB00F6F6FB00156F08003AD676002AD56D0029D8
      700028DC720029DF750085EEB100FFFFFF00FFFFFF001BDB6B0029D9700027D4
      6B002AD0690026C9610033CA6500000000000000000000000000F9E9CE00FFFB
      EF00FFFEF300FFFEF300FFFEF300FFFEF300FDFCF100C4C1C1009179B700866A
      B400E1D8C800E9E3DB00FEFEFE000000000034B3580064E2960062E597005FE8
      990069B37600F3F4F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00D7E3D50059B4
      6E0083EBAE008AE6AD0003B34100F7F9F700686AE1006060F8006161FC004949
      E900AEAEDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E3E3F0005858
      D4008181FE008989FA000101DE00F6F6FB000000000054F197002CDB740032E0
      7B0031E57E0037E8840093F3BD00FFFFFF00FFFFFF0026E4780031E27C0032DD
      780032D7730052D8840012831700000000000000000000000000F9E9D100FFFB
      F200FFFEF600FFFEF600FFFEF600FFFEF600FDFCF500EAE4D600CABEA500CCBE
      A600DDCDB600E5DFD500FEFEFE000000000034B65B0073E8A30070EBA40074EE
      A90081F2B3008AF4B90072D5960068C3830067C5840072DD9B008BF6BB008BEE
      B5008EEBB40091E9B40030C56900F7F9F700696CE0007171FE006E6EFE007171
      FF007A7AFF006969F4005B5BDA006262D4005D5DD5006666E8008A8AFF008989
      FF008D8DFE009090FC003334E700F6F6FB0000000000117F140080F4B40037E7
      840051EB940063EC9F00A0F4C500F5FEF900F4FEF8004CEA91003DE8880039E3
      820046DF850042DF7E0000000000000000000000000000000000F9E9D400FFFB
      F500FFFDF900FFFDF900FFFDF900FFFDF900FCFAF500DED6C700F5CD9D00D5B2
      7B00C2A57400F9F8F500000000000000000047C16C007EECAC0080F0B00091F2
      BC00A1F4C500ADF5CC00B4F6D100B5F6D200B1F6CF00AAF5CB00A1F4C5009AF2
      C0009DF0C000A0EEBF0067DC9500FEFEFE007579E3007E7EFF007E7EFF008787
      FF008E8EFF009494FF009898FF009C9CFF009D9DFF009E9EFF009E9EFF009D9D
      FF009D9DFF009E9EFE006567F300FDFDFE00000000000000000015B64300A9FB
      CF0076EFAB0089F1B60097F3BF0095F3BE008AF1B70078F0AC005AEC9A006FEE
      A60063F39F001C59000000000000000000000000000000000000F9E5D000FFF6
      EE00FFF8F200FFF8F200FFF8F200FFF8F200FDF6EF00E7DCCE00FFE9CD00D3B8
      8800F4F2EE00FEFEFE000000000000000000BCDABC009AF3C10097F3BF00ABF5
      CB00BBF7D500C7F9DD00CFF9E100CFFAE200CAF9DE00C2F8D900B8F7D300ADF5
      CC00AAF4C900B5F2CF0081CD9100FDFDFD00DADAF4009A98FF009393FF009B9B
      FF00A1A1FF00A8A8FF00ACACFF00AEAEFF00B0B0FF00B1B1FF00B1B1FF00B0B0
      FF00AFAFFF00AEAEFF007E82F000FEFEFE000000000000000000000000001190
      2300B0FFDB00D9FCE900CEF9E100CAF8DE00C1F7D900BBF8D500A9FED00033E0
      7600000000000000000000000000000000000000000000000000EBD8B900EDDC
      BF00EEDEC300EEDEC300EEDEC300EEDEC300ECDBC000E7D5B800D0B88E00F6F5
      F100FEFEFE0000000000000000000000000000000000B3D9B7009FF3C100A9FA
      CD00AFFCD100AEFED100AFFED200B1FED200A5FCCB00A4FACA009EF8C40099F5
      BF0096F0BA0089D098000000000000000000FEFEFE00B6B9EE00B9C0FF00C9CE
      FF00C8CEFF00CDD3FF00CFD5FF00CCD3FF00CED4FF00C9CFFF00C8CEFF00C7CC
      FF00C1C6FF00878DF10000000000000000000000000000000000000000000000
      000000000000159327004EDD820068F1A1004FF0920020BE5000156603000000
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
      0000676767005252520000000000000000000000000000000000000000000000
      00000000000000000000000000000000000007269D00082FC0001C3CBC001C3C
      BC001C3CBC001C3CBC001C3CBC00082FC000082FC000082FC000082FC000082F
      C000082FC000082FC00007269D00000000000000000000000000000000000000
      000000000000FAFCFC00EEF5F700E6F0F400EAF2F600F4F8FA00FDFDFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000068686800333131004931290043312B0032323200A3A3
      A300000000000000000000000000000000000000000000000000000000007D7D
      7E00CACACA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000939DB001648E4002C51E2002C51
      E2002C51E2002C51E2002C51E2002C51E2001648E4001648E4001648E4000939
      DB000939DB000939DB00082FC00000000000000000000000000000000000F8FA
      FC00D5E7EE0080A7B6002C444F00172227001D2C32004F707D00B5D4DF00E9F2
      F500FEFEFE0000000000000000000000000000000000636363005B5B5B005A5A
      5A005F5F5F008D8C8800D0B6A70092300E0092300E0092300E0092300E008A30
      10003231310000000000000000000000000000000000000000005F5F5F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000939DB002C51E2003959E4003959
      E4003959E4008799FA00EAF3FD00FEFEFE00EAF3FD007589FC001648E4001648
      E4001648E4000939DB00082FC000000000000000000000000000F1F6F90098C3
      D900131D23001B1E2100060A0D0001040800020508000F121400211B1800358B
      CE00DBEAEF00FDFDFE000000000000000000585858006B6A6700333533008D8E
      8300626559002A3B23007A877100B1775F0092300E009F49330092300E009230
      0E0092300E00353130000000000000000000000000000000000072727200F8F8
      F800F4F4F400F1F1F100FDFDFD00D8D8DC00D6D6DA00FCFCFC00F1F1F100F4F4
      F400F8F8F800FCFCFC0000000000000000001648E4003959E4004664E7004664
      E700FFFFFF00EAF3FD006882EA003959E4006486FE00DAF0FB00FEFEFE001648
      E4001648E4000939DB00082FC0000000000000000000F7FAFB0087B8D5001FAD
      FF001990F8000002040001080E0001080D0001070C0001060B0006294D001C91
      FF00168FEE00E2EEF2000000000000000000323232009E9C99005C5F5C009F9D
      950094928900BDC3B30046744400C19B77009E4B0A00B2705100973B14009230
      0E0092300E0092300E005B5B5B0000000000F6F6F600F8F8F80085858500ECEC
      EC00E6E6E600A5A5B8003737BB003B3BBE003838BD003636BA008F8FAF00EDED
      ED00E9E9E900E4E4E400EDEDED00FAFAFA002C51E2003959E400546FE700FEFE
      FE008698DE004664E7004664E7003959E4003959E4003959E4007589FC00F9FE
      FE001648E4001648E4001C3CBC000000000000000000D1E4EA001AACFF001E9A
      FF001E9CFF000D457200020D1500020C1400020B1200000001001C9BFF00198F
      FF00198EFF004397D900F6F9FB0000000000000000005F5F5E00A1AE9F00D5D5
      D400CDCCC700739B6F009ABD9600BA882E00BB852F00CBA16E00B17030009C46
      0B0092310D0092300F004A31280000000000EEEEEE00F0F0F000A3A3A3006362
      62006E6D7D003D3DBD009D9DB900F4F4F400000000004848C2003A3AB9004847
      6600AFAFAF00E9E9E900E7E7E700F2F2F2002C51E2004664E7008799FA00EAF3
      FD00546FE7004664E7004664E700FFFFFF003959E4002C51E2002C51E200EAF3
      FD007589FC001648E4001C3CBC0000000000F9FBFC003A9DE10022A1FF0022A4
      FF0022A4FF0024ADFF00020A100003111B00030F18001773BB001E99FF001C96
      FF001A91FF0011A0FF00DDEBF0000000000000000000CFCFCF0036363600E4E3
      E000FCFAF4001F692200E3E1D800D0AF4600E2CD9100DEC68D00D5B67E00B77D
      3300B16F44009F4931007D301500FAFAFA00FDFDFD00C6C6C6009A9998004E4C
      4A004343B4006F6FBA00F1F1F100FEFEFE006060D6005959D8007D7DB4003F3F
      BC00969692005F5D5D0000000000FEFEFE003959E400546FE700EAF3FD006882
      EA00546FE7004664E7004664E700F9FEFE003959E4002C51E2002C51E200546F
      E700EAF3FD001648E4001C3CBC0000000000F5F9FA0016ADFF0024A9FF0025AB
      FF0025ADFF0025ACFF001F90D60005162100071E2D0023A9FF0021A1FF001F9D
      FF001D98FF001B94FF0081B6D800000000000000000000000000323232000C18
      04000F2C0900D4D8CB00D3BB5700CCAB2000D0B23400D5B94800E4D19700D7B8
      7D00C5956100AE69460095391D00F2F2F20000000000D9D8D800A5A5A4005453
      4C004E4ECD00C7C7CF00000000007474E7006D6DE700EDEDED00E4E4E8004B4B
      CC0083827B008A88880000000000000000003959E400546FE700FFFFFF00546F
      E700546FE7004664E7004664E700FEFEFE003959E4002C51E2002C51E2001648
      E400FFFFFF001648E4001C3CBC0000000000E7F0F4002DBFFF0028B7FF0029B9
      FF002AB9FF002AB9FF002ABCFF000B31460028B5FF0026B1FF0025ADFF0023A9
      FF0021A4FF00209DFF0045A1E300FDFDFE0000000000000000004A4A4A00F7F5
      ED00F0EFE700E1D39B00D7BE5300DBC46300F7F1DB00F4EDD200ECDFAD00E0CA
      8A00CFA96A00B87D4D00863E2500F8F8F80000000000E6E6E600A7A6A6005958
      55007171D800BABAF1008989F5008080F300FAFAFA0000000000CCCCF6007272
      DD0095958F009A99990000000000000000004664E700546FE700EAF3FD006882
      EA00546FE7004664E7004664E700FEFEFE003959E4002C51E2002C51E2004664
      E700F5F6FE002C51E2001C3CBC0000000000E5EFF30025424E0020405000092E
      3F000B3141000B3141000B2F4000196D960007212E000825350007213000051B
      2A000C1F2B001F2D37003B5460000000000000000000000000009F9F9F00C7A6
      3200D6BB4B00DAC25C00E4D28A00E9DA9F00F3EACA00EADDA400F0E6BF00E4D2
      8D00D4B46C00BE894E0052382800000000000000000000000000FBFAFA005757
      580062608800A7A7F400B8B8FF00000000000000000000000000ABABF0006D6D
      AC00F7F7F900FBF9F9000000000000000000546FE7006882EA009FACFA00EAF3
      FD00546FE7004664E7003959E400FEFEFE003959E4002C51E2002C51E200DAF0
      FB008698DE002C51E2001C3CBC0000000000FBFCFD003E5A66002F5361003156
      6500264E5D00143F4F000B3140002FCBFF001C7CA6000C2E3E00183442002A40
      4C00293B470026353F006A889500000000000000000000000000000000004B45
      2B00DDC66900E2CF8100F6F1DB00F4ECD000F0E6BE00F0E7C000E1CD7C00D4B7
      4000D5B66600BC8843004C4C4C00000000000000000000000000E5E5E6000000
      0000000000009999F000D6D6FF00C0C0FF00B9B9FF00CFCFFF00BDBDFF000000
      000000000000000000000000000000000000546FE7006882EA006882EA00FEFE
      FE009FACFA004664E7004664E7003959E4003959E4002C51E200546FE700FEFE
      FE002C51E2002C51E2001C3CBC0000000000000000004A6E8200376170003B67
      75003B6876003B66730053C3E70057D4FF0057D8FF003757640036546100344E
      5B00334955004C5B6400D7E5EB0000000000000000000000000000000000ABAB
      AB009F8D4100EEE2B400F6F0DA00F6F0DA00F1E8C300E6D59100D7BE5300C8A4
      0F00BC8C03003D382F0000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000D4D4FF00E2E2FF0000000000000000000000
      0000BEBFBF000000000000000000000000006882EA008698DE008698DE006882
      EA00FEFEFE00EAF3FD006882EA004664E700546FE700EAF3FD00FEFEFE002C51
      E2002C51E2002C51E2001E41C3000000000000000000C1D8E2007298A1004679
      8600477B88004A88980060E0FF005FDCFF005ED8FF005ACBF2003F606D003E5C
      6A003A5361004B5E680000000000000000000000000000000000000000000000
      00008E8E8E007C724A00E8D89900EBDEAA00E9DA9F00E0CB7600D3B73F00C49E
      030038362F00F6F6F60000000000000000000000000000000000000000005856
      5600F7F7F7000000000000000000000000000000000000000000000000007573
      7300C5C5C5000000000000000000000000006882EA009FACFA008698DE006882
      EA006882EA009FACFA00F5F6FE00FFFFFF00F5F6FE009FACFA004664E7004664
      E7003959E4003959E4001C3CBC000000000000000000000000005F8EA8007FAB
      B3004E8792006BEBFF0069E5FF0068E3FF0067DFFF0066DDFF0050899D004A6B
      790086969D00F3F7F90000000000000000000000000000000000000000000000
      000000000000F4F4F400494949004E4A3D007C734C006D643D00343331007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      000063626200605E5E0093929200CDCDCD00C4C3C3006A69690060616100CECE
      CE00000000000000000000000000000000008698DE009FACFA008698DE008698
      DE006882EA006882EA006882EA006882EA006882EA006882EA00546FE700546F
      E7004664E7002C51E2001C3CBC0000000000000000000000000000000000689A
      B400B1E9EC0087F0FF0070ECFF006DE9FF006CE5FF0073E2FF00A0EEFF007E93
      9B00E6EFF3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009B9B9B007F7F7F0080808000C0C0C000000000000000
      0000000000000000000000000000000000004664E7007589FC006882EA006882
      EA00546FE700546FE700546FE700546FE7004664E7004664E7004664E7003959
      E4002C51E2002348CD0007269D00000000000000000000000000000000000000
      0000D8E9F1007ED2F600ADF8FF00BBFEFF00B4F9FF008DE2FF008FC5E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADADAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADADAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00F7F7F700CECECE00A5A5A5009C9C9C00C6C6C600E7E7E700FFFF
      FF000000000000000000000000000000000000000000AD736300FFDED600FFD6
      D600FFD6CE00FFD6CE00FFCEC600FFCEC600FFC6BD00FFC6B500FFBDB500FFBD
      AD00FFB5AD0063313900ADADAD000000000000000000AD736300FFDED600FFD6
      D600FFD6CE00FFD6CE00FFCEC600FFCEC600FFC6BD00FFC6B500FFBDB500FFBD
      AD00FFB5AD0063313900ADADAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00B5ADA500D6843100A55210008C4208009C7B6B0094420800C66B21009494
      8C00E7E7E70000000000000000000000000000000000B57B6300FFEFE700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEBD00FFDE
      BD00FFD6B50063393900ADADAD000000000000000000B57B6300FFEFE700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEBD00FFDE
      BD00FFD6B50063393900ADADAD000000000000000000BDBDCE0031315A000000
      0000000000000000000000000000000000000000000000000000393942000000
      000000000000BDBDDE0000001800000000000000000000000000F7F7F700D6A5
      6B00C67329009C5A180094521800944A100084847B008C847B00843908009442
      00009C6B4A00DEDEDE00000000000000000000000000B57B6300FFF7E700FFEF
      E700FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEC600FFDE
      BD00FFD6BD006B393900ADADAD000000000000000000B57B6300FFF7E700FFEF
      E700FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEC600FFDE
      BD00FFD6BD006B393900ADADAD0000000000000000009494BD00F7F7FF00FFFF
      FF00525284000000000000000000000000000000000000000000A58C6B00A5A5
      C600FFFFFF00F7F7FF00000010000000000000000000FFFFFF00D6B57B00C68C
      5200BD8C5A00BD845200BD7B4200B5733900AD947B00A5A5A50094948C007B42
      08007B3900008C634200EFEFEF000000000000000000BD846300FFF7E700FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFF7F700FFE7D600FFE7CE00FFE7C600FFDE
      C600FFDEBD006B423900ADADAD000000000000000000BD846300FFF7E700FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFE7D600FFE7CE00FFE7C600FFDE
      C600FFDEBD006B423900ADADAD0000000000000000008484B500D6D6FF00E7E7
      FF00F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFAD3100DEDEE700EFEF
      FF00DEDEFF00DEDEFF00000008000000000000000000CECEC600E7BD9400CEA5
      7B00C69C7300CE9C6B00CE945A00C68C5200BDBDBD00BDBDBD00ADADAD009494
      940084390800844A18009C9C9400FFFFFF0000000000BD8C6B00FFF7EF00FFFF
      FF0021A5290000AD100000AD0800ADD6AD00FFFFFF00F7F7EF00E7D6CE00FFF7
      E700FFDEC60073424200ADADAD000000000000000000BD8C6B00FFF7EF00FFFF
      FF00313131001818210018181800B5B5BD00FFFFFF00F7F7F700CECECE00FFEF
      DE00FFDEC60073424200ADADAD0000000000000000007373B500BDBDFF00CECE
      FF00DEDEFF00EFEFFF00F7F7FF00FFFFFF00CE630000C6BDB500F7F7FF00D6D6
      FF00C6C6FF00C6C6FF000000080000000000FFFFFF00EFDEB500DEC69C00CEAD
      8C00C6A58400DEAD7B00D69C6B00CECEC600D6D6D600CECECE00BDBDBD00ADAD
      AD00946B4A00844A180094735200EFEFEF0000000000C68C6B00FFF7F70084BD
      840021C63900FFFFFF009CD6A50000AD0800FFFFF700A55A2100BD947300944A
      1800FFE7CE00734A4200ADADAD000000000000000000C68C6B00FFF7F7008C8C
      8C0042424200FFFFFF00ADADAD0018181800FFFFF70021212100737373003131
      3100FFE7CE00734A4200ADADAD0000000000000000006B6BB500ADADF700B5B5
      F700C6C6FF00D6D6FF00E7E7FF00B5A5A500FFDEA500D6D6F700D6D6FF00BDBD
      F700B5B5F700B5B5FF000000100000000000FFFFFF00EFE7C600E7CEAD00D6BD
      9C00D6B59400D6AD8C00CEA57B00E7BD9400DEDEDE00D6D6D600CECECE00B573
      3900A563290084421000A57B6300CECECE0000000000C6946B00FFEFDE0063BD
      6B008CE79C00ADDEB50063C66B0000B51800E7C6AD00EFC6B500EFE7DE009C52
      2100FFE7D600734A4200ADADAD000000000000000000C6947300FFEFDE008484
      7B00ADADAD00BDBDBD008484840021212100D6BDAD00C6C6C600D6D6D6002121
      2900FFE7CE00734A4200ADADAD0000000000000000005A5AB5009C9CF700A5A5
      F700ADADF700BDBDFF00BDCEFF00FF9C21009CA5BD00C6C6FF00B5B5F700ADAD
      F7009C9CF7009C9CFF000000100000000000EFEFEF00EFE7CE00EFDEBD00E7D6
      B500DEC6A500DEBD9C00F7D6B500EFC69400E7CEB500DEB58C00D6945A00C684
      4A00B573390094521800A5846B00BDBDBD0000000000CE947300FFEFE700D6C6
      8C0063FF9C009CE7AD0029D64A00089C1000FFDEB500CE8C6300CE845200CE8C
      6300FFDECE007B524200ADADAD000000000000000000CE947300FFEFE700D6B5
      9400ADADA500BDBDBD005A5A5A0021212900FFDEB500847B73006B6B6B00AD94
      7B00FFDECE007B524200ADADAD0000000000000000005252B5008C8CF7008C8C
      F7009C9CF700A5A5FF00A5632100FFF7E700A5A5FF00A5A5F7009C9CF7009494
      F7008C8CF7008C8CFF000000100000000000EFEFEF00EFEFD600EFDECE00E7D6
      BD00F7DEC600F7EFDE00FFE7C600F7D6AD00EFD6B500E7B57B00DEA56B00CE94
      5A00BD7B4A00A56B3900C6C6C600C6C6C60000000000CE9C7300FFFFF700FFD6
      A500CEB57B005AC6630063AD4A00FFCE9400FFCE9C00FFDEBD00FFE7CE00FFEF
      DE00FFE7D6007B524A00ADADAD000000000000000000CE9C7300FFFFF700FFCE
      9C00C69C73008C7B73007B6B5A00FFCE9400FFCE9C00FFDEBD00FFE7CE00FFEF
      DE00FFE7D6007B524A00ADADAD0000000000000000004A4AB5007B7BF7008484
      F7008484F7006B63A500FFE7A5007373C6008C8CF7008C8CF7008484F7008C8C
      F7009C9CF700A5A5FF000000100000000000FFFFFF00EFEFDE00F7E7D600F7E7
      D600F7EFEF00F7EFDE00EFD6B500F7DEBD00EFCEA500EFC69400E7B57B00D6A5
      6B00C68C5A00B5846300D6D6D600E7E7E70000000000D69C7300FFFFF700FFFF
      F700FFEFD600FFD6AD00FFDEB500FFF7EF00FFF7E700FFF7E700FFEFDE00FFEF
      DE00FFE7D60084524A00ADADAD000000000000000000D69C7300FFFFF700FFFF
      F700FFEFD600FFD6AD00FFDEB500FFF7EF00FFF7E700FFF7E700FFEFDE00FFEF
      DE00FFE7D60084524A00ADADAD0000000000000000004A4AB5007373F7007B7B
      F700737BFF00FFA53100B5B5C6008484FF007B7BF700A5A5F700ADADF700ADAD
      F700A5A5F700B5B5FF00000010000000000000000000EFEFD600EFEFDE00F7E7
      D600F7F7F700F7F7F700FFFFFF00F7F7F700EFD6B500F7D6AD00EFC6A500D6AD
      7B00C69C6B00BDA58C00BDBDBD00FFFFFF0000000000D6A57B00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      DE00FFE7DE00845A4A00ADADAD000000000000000000D6A57B00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      DE00FFE7DE00845A4A00ADADAD0000000000000000006B6BB500A5A5F7007B7B
      F700846384009CADAD007373E700ADADF700BDBDFF00BDBDF700B5B5FF00B5B5
      FF00B5B5FF00C6C6FF00000010000000000000000000DEDEDE00EFEFE700F7EF
      DE00F7F7F700F7F7F700F7F7F700F7F7F700F7EFE700F7DEC600EFD6B500D6B5
      9C00CEA58400D6CEC600CECECE000000000000000000DEA57B00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFDED600845A4A00ADADAD000000000000000000DEA57B00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFDED600845A4A00ADADAD0000000000000000007B7BB500D6D6FF00DEDE
      FF00A57B4A00B5B5CE00D6D6FF00D6D6FF00D6D6FF00D6D6FF00CECEFF00CECE
      FF00CECEFF00DEDEFF0000001000000000000000000000000000D6D6CE00EFEF
      E700EFEFEF00F7F7F700F7F7F700F7EFEF00F7F7F700EFE7D600E7D6C600CEB5
      9C00CEC6BD00B5B5B500FFFFFF000000000000000000DEAD7B00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00CE9C7B00CE9C
      6B00C68C520084522900000000000000000000000000DEAD7B00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00CE9C7B00CE9C
      6B00C68C5200845229000000000000000000000000005A5A9C00FFFFFF00AD8C
      730094949C00F7F7FF00EFEFFF00EFEFFF00EFEFFF00EFEFFF00EFEFFF00EFEF
      FF00EFEFFF00FFFFFF000000080000000000000000000000000000000000D6D6
      C600EFEFE700EFEFEF00F7F7F700F7F7EF00F7EFEF00F7EFEF00DED6CE00DED6
      CE00BDBDBD00FFFFFF00000000000000000000000000E7B58400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700DEBD9400EFCE
      94006352310000000000000000000000000000000000E7B58400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700DEBD9400EFCE
      940063523100000000000000000000000000000000000000000000083900BDAD
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009494CE000000000000000000000000000000000000000000000000000000
      0000E7E7E700DED6BD00E7DECE00E7E7DE00E7E7E700DED6CE00C6C6BD00E7E7
      E700FFFFFF0000000000000000000000000000000000EFB58400FFE7E700FFE7
      E700FFE7DE00FFDEDE00FFDEDE00FFDED600FFDED600FFD6D600E7C69C00736B
      52000000000000000000000000000000000000000000EFB58400FFE7E700FFE7
      E700FFE7DE00FFDEDE00FFDEDE00FFDED600FFDED600FFD6D600E7C69C00736B
      5200000000000000000000000000000000000000000000000000312929000000
      0000000018008C8CB500E7E7FF00FFFFFF00FFFFFF00CECEF700525284000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFF7F000000003FF0FC1F00000000
      1FE0F00F000000000FC1C003000000008781800100000000C303800100000000
      E007800100000000F00F800100000000F83F800100000000C07F800100000000
      803F800100000000809F80010000000090CFE00700000000B0E7F03F00000000
      E1F7F0FF00000000C3FFFDFF00000000F000FFFFFFFFFFFFF000F00FFC0FFFC7
      C000E0033003FF87C00080410001FF0FC00080118000FF1F00008001C000E01F
      00000003C000C03F80008003C000801F00008001C000801F00000001C000001F
      8E078001C000001F000F8003C001001F003FC007E001801FC01FC00FF003803F
      C03FE01FF807E07FE8FFF83FFE1FFFFFFFFFFC7FFFFFFFFFFFFFF00FF801FFFF
      E07FC007F813FFFFC01F8183F013FFFF801F87E1F813FDFF0F070C710001FCFF
      1FF31C710001FC7F3F011C780001FA3F3F001C780001F81F1F011C700001FC3F
      1F831C710001FC1F0F0F0C610001FE0F801F87C30001FE0FC03FC0030001FFFF
      F0FFE0070001FFFFFFFFF01F0001FFFFFFFFFFCFFF87FF83800F00070007C001
      000300030007C000000100010000C001000100010000C000000100000001C000
      800100000003C000C00300070007C001C0030007000FC003C003001F001FC003
      C003001F001FC003C003001F001FC001C003001F001FC001C003001F001FC003
      E007001F001FC003F01FFFFFFFFFC007FFC3FFFFF01FF00F0001F81FC007C007
      000000008003C00300000000800180010000F39F000100000000F99F00000000
      0000F93F000000000003FC3F000100000007FC7F00000000001FFC7F00010000
      001FC92700010001001F818300008000001FB39900030001001FB7C9C003C001
      001F87E3E003E003FFFFFFFFF01FE017FFFF00018001F00FC00300000000C007
      C003000000008003C003000000008001C003000000000001C003000000000000
      C003000000000000C003000000000000C003000000000000C003000000000000
      C003000000000001C001000000008001C001000000008003C00300000000C003
      C00300000000E00FC00780030003F81FFFFFFFFFFFFFFFFFFFFFF3FF0001F81F
      FC0FE7FF0001E0078007DFFF0001C0030003C003000180030001000000018001
      80010080000100018000000200010001C000820300010000C000804300010001
      C001C1C300010001E001D81F00018001E003DE7700018003F003E7E70001C003
      F80FF00F0001E007FFFFFC3F0001F01F80018001FFFFF00F800180018001E007
      800180018001C003800180018001800180018001000080008001800180010000
      8001800180010000800180018001000080018001800100008001800180010000
      80018001800180008001800180018001800180018001C001800380038001E003
      80078007C003F007800F800FD00FFC3F00000000000000000000000000000000
      000000000000}
  end
  object ImageListEvent1: TImageList
    Left = 589
    Top = 42
    Bitmap = {
      494C01010B000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
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
      00000000000000000000000000000000000000000000FCFCFC009E9E9E008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840088888800E3E3E300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFCFC00EEF5F700E6F0F400EAF2F600F4F8FA00FDFDFE000000
      00000000000000000000000000000000000000000000F3F3F300CFCFCF00E0E2
      E600D9D9DA00D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800DDDDDD00C3C3C300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000068686800333131004931290043312B0032323200A3A3
      A30000000000000000000000000000000000000000000000000000000000F8FA
      FC00D5E7EE0080A7B6002C444F00172227001D2C32004F707D00B5D4DF00E9F2
      F500FEFEFE0000000000000000000000000000000000EBEBEB008CA5A10087A6
      AD00B7CDD400CAD0CF00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D6D6D600C1C1C100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000636363005B5B5B005A5A
      5A005F5F5F008D8C8800D0B6A70092300E0092300E0092300E0092300E008A30
      1000323131000000000000000000000000000000000000000000F1F6F90098C3
      D900131D23001B1E2100060A0D0001040800020508000F121400211B1800358B
      CE00DBEAEF00FDFDFE000000000000000000FBFBFB0013514400004035000056
      4C0000483D000D4A3C00BCC9C700D3D3D300D3D3D300D3D3D300D3D3D300A9B4
      CD00406BC0003964B8007F818E00EAEAEA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000585858006B6A6700333533008D8E
      8300626559002A3B23007A877100B1775F0092300E009F49330092300E009230
      0E0092300E0035313000000000000000000000000000F7FAFB0087B8D5001FAD
      FF001990F8000002040001080E0001080D0001070C0001060B0006294D001C91
      FF00168FEE00E2EEF2000000000000000000CED4D30000514300006153000535
      2900016B5D000060580006594D00D3D3D300D3D3D300D3D3D300B0B9CD003060
      BA002B5BB5002B5BB5002C5CB600878992000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000323232009E9C99005C5F5C009F9D
      950094928900BDC3B30046744400C19B77009E4B0A00B2705100973B14009230
      0E0092300E0092300E005B5B5B000000000000000000D1E4EA001AACFF001E9A
      FF001E9CFF000D457200020D1500020C1400020B1200000001001C9BFF00198F
      FF00198EFF004397D900F6F9FB0000000000C1CCCA0000847400004A3B00C9DC
      E6009EC1C6000051440000574A00D3D3D300D3D3D300D3D3D3005F89D80087A3
      D7008BA7D800A5BAE1007B9AD400476BB3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F5F5E00A1AE9F00D5D5
      D400CDCCC700739B6F009ABD9600BA882E00BB852F00CBA16E00B17030009C46
      0B0092310D0092300F004A31280000000000F9FBFC003A9DE10022A1FF0022A4
      FF0022A4FF0024ADFF00020A100003111B00030F18001773BB001E99FF001C96
      FF001A91FF0011A0FF00DDEBF00000000000F4F4F400077E7100005E53000070
      6000005A4E000052450001665B00C3D1D000C7D3D100D7D7D70080A7EF007C9C
      DA004E7ACD0095AFE100CEDAF1005877B9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CFCFCF0036363600E4E3
      E000FCFAF4001F692200E3E1D800D0AF4600E2CD9100DEC68D00D5B67E00B77D
      3300B16F44009F4931007D301500FAFAFA00F5F9FA0016ADFF0024A9FF0025AB
      FF0025ADFF0025ACFF001F90D60005162100071E2D0023A9FF0021A1FF001F9D
      FF001D98FF001B94FF0081B6D8000000000000000000CAD6D50012ADA000007A
      6C0000574900005F540000817300006F5F00007666000D675900D7DAE1004D7D
      D6004171CB004171CB004F7FD900C5C6C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000323232000C18
      04000F2C0900D4D8CB00D3BB5700CCAB2000D0B23400D5B94800E4D19700D7B8
      7D00C5956100AE69460095391D00F2F2F200E7F0F4002DBFFF0028B7FF0029B9
      FF002AB9FF002AB9FF002ABCFF000B31460028B5FF0026B1FF0025ADFF0023A9
      FF0021A4FF00209DFF0045A1E300FDFDFE0000000000F3F3F300DEDFDF00E5EE
      F700DCE3E900009A8A00009B8C0012726A00069C8C0000766A008CB7B100E1E3
      E600A8C3F3009EBBF200B5B5B700FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A4A4A00F7F5
      ED00F0EFE700E1D39B00D7BE5300DBC46300F7F1DB00F4EDD200ECDFAD00E0CA
      8A00CFA96A00B87D4D00863E2500F8F8F800E5EFF30025424E0020405000092E
      3F000B3141000B3141000B2F4000196D960007212E000825350007213000051B
      2A000C1F2B001F2D37003B5460000000000000000000F3F3F300E4E4E400F4F8
      FF00EBEFF30000B4A500009D9300164333000062540000675E0094BDB700EAEA
      EA00EAEAEA00EAEAEA00C2C2C200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009F9F9F00C7A6
      3200D6BB4B00DAC25C00E4D28A00E9DA9F00F3EACA00EADDA400F0E6BF00E4D2
      8D00D4B46C00BE894E005238280000000000FBFCFD003E5A66002F5361003156
      6500264E5D00143F4F000B3140002FCBFF001C7CA6000C2E3E00183442002A40
      4C00293B470026353F006A8895000000000000000000F3F3F300E6E6E600F6F9
      FF00EDEFF40081CFC90000A5950000726700005B500025675A00E8E9E900E5E6
      E700E5E6E700E3E3E500CBCBCB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004B45
      2B00DDC66900E2CF8100F6F1DB00F4ECD000F0E6BE00F0E7C000E1CD7C00D4B7
      4000D5B66600BC8843004C4C4C0000000000000000004A6E8200376170003B67
      75003B6876003B66730053C3E70057D4FF0057D8FF003757640036546100344E
      5B00334955004C5B6400D7E5EB000000000000000000F3F3F300E6E6E600F6F9
      FF00EDEEF300EDEDED00E0E8E800C1D7D400D5DEDD00EDEDED005180DA00507F
      D900507FD9007583A300F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB009F8D4100EEE2B400F6F0DA00F6F0DA00F1E8C300E6D59100D7BE5300C8A4
      0F00BC8C03003D382F00000000000000000000000000C1D8E2007298A1004679
      8600477B88004A88980060E0FF005FDCFF005ED8FF005ACBF2003F606D003E5C
      6A003A5361004B5E6800000000000000000000000000F3F3F300E5E5E500F6F9
      FF00ECEEF200EDEDED00EDEDED00EDEDED00EDEDED00EDEDED005E8DE7005A89
      E3007987A600F8F8F80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008E8E8E007C724A00E8D89900EBDEAA00E9DA9F00E0CB7600D3B73F00C49E
      030038362F00F6F6F600000000000000000000000000000000005F8EA8007FAB
      B3004E8792006BEBFF0069E5FF0068E3FF0067DFFF0066DDFF0050899D004A6B
      790086969D00F3F7F900000000000000000000000000F3F3F300E6E6E600F6F9
      FF00E5E8EE00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00A6C4FC008B97
      B200F8F8F8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F4F4F400494949004E4A3D007C734C006D643D00343331007F7F
      7F0000000000000000000000000000000000000000000000000000000000689A
      B400B1E9EC0087F0FF0070ECFF006DE9FF006CE5FF0073E2FF00A0EEFF007E93
      9B00E6EFF30000000000000000000000000000000000F7F7F700E4E4E400E6E6
      E600E9E9E900EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00949DB300F8F8
      F80000000000FAFAFA00FCFCFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D8E9F1007ED2F600ADF8FF00BBFEFF00B4F9FF008DE2FF008FC5E4000000
      0000000000000000000000000000000000000000000000000000FAFAFA00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00BDBDB5009C8C73009484
      7300ADADA500FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEF700DEDE
      F700DEDEF700F7F7FF0000000000000000000000000000000000000000000000
      0000FFFFFF00F7F7F700CECECE00A5A5A5009C9C9C00C6C6C600E7E7E700FFFF
      FF00000000000000000000000000000000000000000000000000D6944A00D694
      5200D6945200D6945200D6945200CE945200CEC6AD00EFC6B500E7734200E77B
      4A00EFCEC600B5A58C00E7E7E7000000000000000000C6C6C600E7E7E700EFEF
      EF00F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00DEDE
      DE00EFEFEF00EFEFEF00DEDEDE0000000000FFFFFF00F7F7F700EFEFEF00E7E7
      E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7E7E7006B6BC6001010C6001010
      C6001010C6001818B500F7F7FF0000000000000000000000000000000000FFFF
      FF00B5ADA500D6843100A55210008C4208009C7B6B0094420800C66B21009494
      8C00E7E7E7000000000000000000000000000000000000000000DEA56300E7AD
      7300E7AD7300E7AD7300E7AD7300DED6C600E76B3900EF520800DE9C5A00D66B
      1800E7520800E77B5200B5A58C00FFFFFF0000000000BDBDCE0052527300B5B5
      B500ADADAD00ADADAD00ADADAD00B5B5B500B5B5B500B5B5B50073737300BDBD
      BD009C9C9C00BDBDDE009C9CA500000000006B6B6B0073737300848484008C8C
      8C009494940094949400949494008C8C8C00393994000000CE000000CE000000
      D6000000CE000000CE001010B500F7F7FF000000000000000000F7F7F700D6A5
      6B00C67329009C5A180094521800944A100084847B008C847B00843908009442
      00009C6B4A00DEDEDE0000000000000000000000000000000000E7B57B00EFBD
      8C00EFBD8C00EFBD8C00DEAD7300E7BDAD00EF6B1800EF6B1800D6843900DE73
      2100EF6B1800E76B1800EFD6CE00C6C6BD00000000009494BD00F7F7FF00FFFF
      FF006B6B8C008C8C8C00ADADAD00B5B5B500B5B5B50094949400A58C6B00A5A5
      C600FFFFFF00F7F7FF008C8C940000000000525252007373730094949400BDBD
      BD00DEDEDE00F7F7F700DEDEDE00BDBDBD000808D6000000DE000000DE000000
      DE000000DE000000DE000000D600A5A5E70000000000FFFFFF00D6B57B00C68C
      5200BD8C5A00BD845200BD7B4200B5733900AD947B00A5A5A50094948C007B42
      08007B3900008C634200EFEFEF00000000000000000000000000EFC68C00F7CE
      A500F7D6A500F7D6A500E7C69C00E7844200EF843100F7843100E79C5A00D6A5
      7300EF843100EF843100EF9C6B00A5948400F7F7F7008484B500D6D6FF00E7E7
      FF00F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFAD3100DEDEE700EFEF
      FF00DEDEFF00DEDEFF007B7B8400FFFFFF00636363008C8C8C00A5A5A500BDBD
      BD00E7E7E700F7F7F700DEDEDE00C6C6C6000808E700ADADFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000E700A5A5E70000000000CECEC600E7BD9400CEA5
      7B00C69C7300CE9C6B00CE945A00C68C5200BDBDBD00BDBDBD00ADADAD009494
      940084390800844A18009C9C9400FFFFFF000000000000000000F7D6A500FFE7
      BD00FFE7BD00FFE7BD00E7CEA500E78C4A00F79C4200F79C4200FFC69400EFCE
      A500CE9C6300EF944200EF9C7300AD9C8C00000000007373B500BDBDFF00CECE
      FF00DEDEFF00EFEFFF00F7F7FF00FFFFFF00CE630000C6BDB500F7F7FF00D6D6
      FF00C6C6FF00C6C6FF00ADADAD0000000000636363008C8C8C00A5A5A500BDBD
      BD00EFEFEF00F7F7F700DEDEDE00C6C6C6003131F7001010F7000000FF000000
      FF000000FF000808F7002929F700A5A5E700FFFFFF00EFDEB500DEC69C00CEAD
      8C00C6A58400DEAD7B00D69C6B00CECEC600D6D6D600CECECE00BDBDBD00ADAD
      AD00946B4A00844A180094735200EFEFEF000000000000000000FFDEB500FFEF
      CE00FFEFD600FFEFD600EFD6AD00DEB5A500F7A54A00EFE7D600F7AD5200EFA5
      4A00DECEBD00EFA54A00F7DED600EFE7E700000000006B6BB500ADADF700B5B5
      F700C6C6FF00D6D6FF00E7E7FF00B5A5A500FFDEA500D6D6F700D6D6FF00BDBD
      F700B5B5F700B5B5FF00B5B5B50000000000525252007B7B7B009C9C9C00B5B5
      B500C6C6C600CECECE00C6C6C600B5B5B5004A4AB5005252FF005252FF005A5A
      FF005252FF004A4AFF005A5AFF00FFFFFF00FFFFFF00EFE7C600E7CEAD00D6BD
      9C00D6B59400D6AD8C00CEA57B00E7BD9400DEDEDE00D6D6D600CECECE00B573
      3900A563290084421000A57B6300CECECE000000000000000000FFE7BD00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00F7E7D600E7945200EFAD5A00FFF7EF00FFF7
      EF00EFAD5200EF9C6B00DECEB50000000000000000005A5AB5009C9CF700A5A5
      F700ADADF700BDBDFF00BDCEFF00FF9C21009CA5BD00C6C6FF00B5B5F700ADAD
      F7009C9CF7009C9CFF00B5B5B50000000000525252007B7B7B009C9C9C00BDBD
      BD00E7E7E700FFFFFF00E7E7E700C6C6C600A5A5A5004242AD00A5A5FF009C9C
      FF009C9CFF008484FF000000000000000000EFEFEF00EFE7CE00EFDEBD00E7D6
      B500DEC6A500DEBD9C00F7D6B500EFC69400E7CEB500DEB58C00D6945A00C684
      4A00B573390094521800A5846B00BDBDBD000000000000000000FFE7C600FFF7
      DE00FFFFE700FFFFE700FFFFE700FFF7E700F7E7D600DEBDAD00EF9C6300EF9C
      6300EFD6C600E7D6BD00FFFFFF0000000000000000005252B5008C8CF7008C8C
      F7009C9CF700A5A5FF00A5632100FFF7E700A5A5FF00A5A5F7009C9CF7009494
      F7008C8CF7008C8CFF00B5B5B500000000006363630094949400ADADAD00C6C6
      C600EFEFEF00FFFFFF00E7E7E700CECECE00B5B5B5009494940063636B00F7F7
      FF00EFEFF700000000000000000000000000EFEFEF00EFEFD600EFDECE00E7D6
      BD00F7DEC600F7EFDE00FFE7C600F7D6AD00EFD6B500E7B57B00DEA56B00CE94
      5A00BD7B4A00A56B3900C6C6C600C6C6C6000000000000000000FFE7C600FFFF
      E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00F7E7C600E7D6B500EFD6
      B500F7DEBD00F7EFE7000000000000000000000000004A4AB5007B7BF7008484
      F7008484F7006B63A500FFE7A5007373C6008C8CF7008C8CF7008484F7008C8C
      F7009C9CF700A5A5FF00B5B5B500000000006363630094949400ADADAD00C6C6
      C600F7F7F700FFFFFF00E7E7E700CECECE00B5B5B500949494006B6B6B000000
      000000000000000000000000000000000000FFFFFF00EFEFDE00F7E7D600F7E7
      D600F7EFEF00F7EFDE00EFD6B500F7DEBD00EFCEA500EFC69400E7B57B00D6A5
      6B00C68C5A00B5846300D6D6D600E7E7E7000000000000000000FFEFCE00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFF7E700F7EFE7000000000000000000000000004A4AB5007373F7007B7B
      F700737BFF00FFA53100B5B5C6008484FF007B7BF700A5A5F700ADADF700ADAD
      F700A5A5F700B5B5FF00B5B5B50000000000525252007B7B7B0094949400ADAD
      AD00C6C6C600CECECE00C6C6C600ADADAD009C9C9C007B7B7B005A5A5A000000
      00000000000000000000000000000000000000000000EFEFD600EFEFDE00F7E7
      D600F7F7F700F7F7F700FFFFFF00F7F7F700EFD6B500F7D6AD00EFC6A500D6AD
      7B00C69C6B00BDA58C00BDBDBD00FFFFFF000000000000000000FFEFCE00FFFF
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700F7F7
      E700F7EFDE00EFE7DE00FFFFFF0000000000000000006B6BB500A5A5F7007B7B
      F700846384009CADAD007373E700ADADF700BDBDFF00BDBDF700B5B5FF00B5B5
      FF00B5B5FF00C6C6FF00B5B5B500000000006363630094949400B5B5B500D6D6
      D600F7F7F700FFFFFF00F7F7F700D6D6D600B5B5B5008C8C8C00636363000000
      00000000000000000000000000000000000000000000DEDEDE00EFEFE700F7EF
      DE00F7F7F700F7F7F700F7F7F700F7F7F700F7EFE700F7DEC600EFD6B500D6B5
      9C00CEA58400D6CEC600CECECE00000000000000000000000000FFEFD600FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700EFE7D600CEBDA500CEBD
      A500DECEB500E7E7D600FFFFFF0000000000000000007B7BB500D6D6FF00DEDE
      FF00A57B4A00B5B5CE00D6D6FF00D6D6FF00D6D6FF00D6D6FF00CECEFF00CECE
      FF00CECEFF00DEDEFF00B5B5B500000000007B7B7B00ADADAD00CECECE00E7E7
      E700F7F7F700FFFFFF00F7F7F700DEDEDE00C6C6C600A5A5A500737373000000
      0000000000000000000000000000000000000000000000000000D6D6CE00EFEF
      E700EFEFEF00F7F7F700F7F7F700F7EFEF00F7F7F700EFE7D600E7D6C600CEB5
      9C00CEC6BD00B5B5B500FFFFFF00000000000000000000000000FFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DED6C600F7CE9C00D6B5
      7B00C6A57300FFFFF70000000000000000000000000063639C00FFFFFF00AD8C
      730094949C00F7F7FF00EFEFFF00EFEFFF00EFEFFF00EFEFFF00EFEFFF00EFEF
      FF00EFEFFF00FFFFFF00BDBDBD000000000084848400B5B5B500CECECE00E7E7
      E700FFFFFF00FFFFFF00F7F7F700DEDEDE00C6C6C600ADADAD00848484000000
      000000000000000000000000000000000000000000000000000000000000D6D6
      C600EFEFE700EFEFEF00F7F7F700F7F7EF00F7EFEF00F7EFEF00DED6CE00DED6
      CE00BDBDBD00FFFFFF0000000000000000000000000000000000FFE7D600FFF7
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00E7DECE00FFEFCE00D6BD
      8C00F7F7EF00FFFFFF0000000000000000000000000000000000848C9C00BDAD
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009494CE00EFEFEF000000000000000000C6C6C600DEDEDE00EFEFEF00F7F7
      F700FFFFFF00FFFFFF00FFFFFF00F7F7F700E7E7E700D6D6D600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7E7E700DED6BD00E7DECE00E7E7DE00E7E7E700DED6CE00C6C6BD00E7E7
      E700FFFFFF000000000000000000000000000000000000000000EFDEBD00EFDE
      BD00EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600E7D6BD00D6BD8C00F7F7
      F700FFFFFF000000000000000000000000000000000000000000BDBDBD000000
      0000A5A5AD008C8CB500E7E7FF00FFFFFF00FFFFFF00CECEF7006B6B9400EFEF
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000EFEFEF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600CECECE00FFFFFF000000000000000000EFEFEF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600CECECE00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7EF00F7DEC600F7C6
      8C00FFD6AD00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEDEDE00A59C9C00A59C
      9400D6D6D600FFFFFF00000000000000000000000000C69C8C00FFDED600FFD6
      D600FFD6CE00FFD6CE00FFCEC600FFCEC600FFC6BD00FFC6B500FFBDB500FFBD
      AD00FFB5AD0084636300FFFFFF000000000000000000C69C8C00FFDED600FFD6
      D600FFD6CE00FFD6CE00FFCEC600FFCEC600FFC6BD00FFC6B500FFBDB500FFBD
      AD00FFB5AD0084636300FFFFFF00000000000000000000000000D6944A00D694
      5200D6945200D6945200D6945200D6945200DE944A007B420800BD6B0000DE8C
      0800DE840000EFC69400FFE7CE00000000000000000000000000D6944A00D694
      5200D6945200D6945200D6945200D6945200C6B5A500EFD6CE00E78C6300E78C
      6300EFDED600A59C9400F7F7F7000000000000000000C69C8C00FFEFE700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEBD00FFDE
      BD00FFD6B50084636300FFFFFF000000000000000000C69C8C00FFEFE700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEBD00FFDE
      BD00FFD6B50084636300FFFFFF00000000000000000000000000DEA56300E7AD
      7300E7AD7300E7AD7300E7AD7300E7AD7300BD6B0000CE730000EF940000EF94
      0000EF940000E7A52100E79C1800FFFFFF000000000000000000DEA56300E7AD
      7300E7AD7300E7AD7300DEAD7300DECEBD00E77B5200F7F7F700EFF7F700E763
      2900E7520800E78C6300A59C9400FFFFFF0000000000C6A58C00FFF7E700FFEF
      E700FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEC600FFDE
      BD00FFD6BD008C6B6300FFFFFF000000000000000000C6A58C00FFF7E700FFEF
      E700FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEC600FFDE
      BD00FFD6BD008C6B6300FFFFFF00000000000000000000000000E7B57B00EFBD
      8C00EFBD8C00EFBD8C00EFBD8C00EFBD8C00E78C0000E7940000BD6B0000EF9C
      0000EF9C00009C520000C66B0000000000000000000000000000E7B57B00EFBD
      8C00EFBD8C00EFBD8C00DEB58400E7CEBD00EF6B1800F7F7EF00FF7B2100F77B
      2900F7732100EF6B1800EFDED600DEDEDE0000000000CEA59400FFF7E700FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFF7F700FFE7D600FFE7CE00FFE7C600FFDE
      C600FFDEBD008C6B6B00FFFFFF000000000000000000CEA59400FFF7E700FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFE7D600FFE7CE00FFE7C600FFDE
      C600FFDEBD008C6B6B00FFFFFF00000000000000000000000000EFC68C00F7CE
      A500F7D6A500F7D6A500F7D6A500F7C69400EFA50000C67300006B310000F7BD
      7B00EFAD0000E7A50000C6841000AD5A08000000000000000000EFC68C00F7CE
      A500F7D6A500F7D6A500E7CEAD00E78C4A00E79C6300FFFFFF00FF943900FF94
      3900DEB59C00F78C3100E7A57300A5A59C0000000000CEAD9400FFF7EF00FFFF
      FF0021A5290000AD100000AD0800ADD6AD00FFFFFF00F7F7EF00E7D6CE00FFF7
      E700FFDEC6008C6B6B00FFFFFF000000000000000000CEAD9400FFF7EF00FFFF
      FF00313131001818210018181800B5B5BD00FFFFFF00F7F7F700CECECE00FFEF
      DE00FFDEC6008C6B6B00FFFFFF00000000000000000000000000F7D6A500FFE7
      BD00FFE7BD00FFE7BD00FFE7BD00FFE7BD00EFAD1800D6941000C66B0000F7BD
      6B00EFAD0800EFAD0000A5731000E7B584000000000000000000F7D6A500FFE7
      BD00FFE7BD00FFE7BD00EFDEBD00E7945200FFAD4A00F7E7D600FFAD5200FFAD
      5200FFFFFF00DEBD9400EFA57300ADA5A50000000000D6AD9400FFF7F70084BD
      840021C63900FFFFFF009CD6A50000AD0800FFFFF700A55A2100BD947300944A
      1800FFE7CE0094736B00FFFFFF000000000000000000D6AD9400FFF7F7008C8C
      8C0042424200FFFFFF00ADADAD0018181800FFFFF70021212100737373003131
      3100FFE7CE0094736B00FFFFFF00000000000000000000000000FFDEB500FFEF
      CE00FFEFD600FFEFD600FFEFD600FFEFD600F7BD6300EFCE5200CE941000C684
      1000EFB51800DE9C0000B5630000FFEFD6000000000000000000FFDEB500FFEF
      CE00FFEFD600FFEFD600F7E7C600CEB59C00FFB55A00FFD69C00FFBD7300FFBD
      6B00F7EFDE00F7B56300F7DECE00E7E7E70000000000D6AD9400FFEFDE0063BD
      6B008CE79C00ADDEB50063C66B0000B51800E7C6AD00EFC6B500EFE7DE009C52
      2100FFE7D60094736B00FFFFFF000000000000000000D6AD9400FFEFDE008484
      7B00ADADAD00BDBDBD008484840021212100D6BDAD00C6C6C600D6D6D6002121
      2900FFE7CE0094736B00FFFFFF00000000000000000000000000FFE7BD00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFE7C600EFBD5A00EFCE4A00EFBD
      3100EFB51000EFAD0000EF9C2100000000000000000000000000FFE7BD00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00F7EFE700EFA56300FFB55A00F7C68C00EFF7
      F700FFFFFF00E7A56B00D6CEC6000000000000000000D6B59400FFEFE700D6C6
      8C0063FF9C009CE7AD0029D64A00089C1000FFDEB500CE8C6300CE845200CE8C
      6300FFDECE0094736B00FFFFFF000000000000000000D6B59400FFEFE700D6B5
      9400ADADA500BDBDBD005A5A5A0021212900FFDEB500847B73006B6B6B00AD94
      7B00FFDECE0094736B00FFFFFF00000000000000000000000000FFE7C600FFF7
      DE00FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFE7C600EFBD3900EFAD
      2100D68C1000EFAD730000000000000000000000000000000000FFE7C600FFF7
      DE00FFFFE700FFFFE700FFFFE700FFF7E700F7F7EF00D6B59C00E7A55A00E7A5
      5A00DEC6B500E7D6CE00FFFFFF000000000000000000DEB59C00FFFFF700FFD6
      A500CEB57B005AC6630063AD4A00FFCE9400FFCE9C00FFDEBD00FFE7CE00FFEF
      DE00FFE7D6009C7B7300FFFFFF000000000000000000DEB59C00FFFFF700FFCE
      9C00C69C73008C7B73007B6B5A00FFCE9400FFCE9C00FFDEBD00FFE7CE00FFEF
      DE00FFE7D6009C7B7300FFFFFF00000000000000000000000000FFE7C600FFFF
      E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7
      DE00FFF7DE00F7EFE70000000000000000000000000000000000FFE7C600FFFF
      E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00F7EFD600F7EFD600F7EF
      D600F7E7CE00F7EFE700000000000000000000000000DEBD9C00FFFFF700FFFF
      F700FFEFD600FFD6AD00FFDEB500FFF7EF00FFF7E700FFF7E700FFEFDE00FFEF
      DE00FFE7D6009C7B7300FFFFFF000000000000000000DEBD9C00FFFFF700FFFF
      F700FFEFD600FFD6AD00FFDEB500FFF7EF00FFF7E700FFF7E700FFEFDE00FFEF
      DE00FFE7D6009C7B7300FFFFFF00000000000000000000000000FFEFCE00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFF7E700F7EFE70000000000000000000000000000000000FFEFCE00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFF7E700F7EFE700000000000000000000000000E7BD9C00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      DE00FFE7DE009C7B7300FFFFFF000000000000000000E7BD9C00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      DE00FFE7DE009C7B7300FFFFFF00000000000000000000000000FFEFCE00FFFF
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700F7F7
      E700F7EFDE00EFE7DE00FFFFFF00000000000000000000000000FFEFCE00FFFF
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700F7F7
      E700F7EFDE00EFE7DE00FFFFFF000000000000000000E7BD9C00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFDED600A5847300FFFFFF000000000000000000E7BD9C00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFDED600A5847300FFFFFF00000000000000000000000000FFEFD600FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700EFE7D600CEBDA500CEBD
      A500DECEB500E7E7D600FFFFFF00000000000000000000000000FFEFD600FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700EFE7D600CEBDA500CEBD
      A500DECEB500E7E7D600FFFFFF000000000000000000E7C6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00CE9C7B00CE9C
      6B00C68C5200C6AD9C00000000000000000000000000E7C6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00CE9C7B00CE9C
      6B00C68C5200C6AD9C0000000000000000000000000000000000FFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DED6C600F7CE9C00D6B5
      7B00C6A57300FFFFF70000000000000000000000000000000000FFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DED6C600F7CE9C00D6B5
      7B00C6A57300FFFFF700000000000000000000000000EFC6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700DEBD9400EFCE
      9400C6BDAD0000000000000000000000000000000000EFC6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700DEBD9400EFCE
      9400C6BDAD000000000000000000000000000000000000000000FFE7D600FFF7
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00E7DECE00FFEFCE00D6BD
      8C00F7F7EF00FFFFFF0000000000000000000000000000000000FFE7D600FFF7
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00E7DECE00FFEFCE00D6BD
      8C00F7F7EF00FFFFFF00000000000000000000000000F7CEA500FFE7E700FFE7
      E700FFE7DE00FFDEDE00FFDEDE00FFDED600FFDED600FFD6D600E7C69C00CEC6
      BD000000000000000000000000000000000000000000F7CEA500FFE7E700FFE7
      E700FFE7DE00FFDEDE00FFDEDE00FFDED600FFDED600FFD6D600E7C69C00CEC6
      BD00000000000000000000000000000000000000000000000000EFDEBD00EFDE
      BD00EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600E7D6BD00D6BD8C00F7F7
      F700FFFFFF000000000000000000000000000000000000000000EFDEBD00EFDE
      BD00EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600E7D6BD00D6BD8C00F7F7
      F700FFFFFF00000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF80010000FFFFF81F80010000
      FC0FE007800100008007C0030000000000038003000000000001800100000000
      80010001000000008000000180000000C000000080000000C000000180010000
      C001000180010000E001800180010000E003800380030000F003C00380070000
      F80FE00780090000FFFFF01FC01F0000FF03FFFFFFC3F00FC00180010001E007
      C00080010000C003C000800100008001C000000000008000C000800100000000
      C000800100000000C001800100030000C001800100070000C0038001001F0000
      C0038001001F8000C0018001001F8001C0018001001FC001C0038001001FE003
      C003C003001FF007C007D00FFFFFFC3F80018001FF83FF0380018001C001C001
      80018001C000C00080018001C001C00080018001C000C00080018001C000C000
      80018001C000C00080018001C001C00180018001C003C00180018001C003C003
      80018001C003C00380018001C001C00180018001C001C00180038003C003C003
      80078007C003C003800F800FC007C00700000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Left = 607
    Top = 116
    object N1: TMenuItem
      Caption = 'Загрузить из файла'
      OnClick = OnLoadFromF
    end
    object N2: TMenuItem
      Caption = 'Применить для всех'
      OnClick = OnSetAll
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 653
    Top = 26
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 685
    Top = 378
  end
  object odm_OpenDialog: TOpenDialog
    Left = 592
    Top = 24
  end
  object AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler
    Style = psOffice2007Obsidian
    PageAppearance.BorderColor = 11841710
    PageAppearance.Color = 13616833
    PageAppearance.ColorTo = 12958644
    PageAppearance.ColorMirror = 12958644
    PageAppearance.ColorMirrorTo = 15527141
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = 9870494
    TabAppearance.BorderColorSelected = 14922381
    TabAppearance.BorderColorSelectedHot = 6343929
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 15724269
    TabAppearance.ColorSelectedTo = 15724269
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 5992568
    TabAppearance.ColorHotTo = 9803415
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 4413279
    TabAppearance.ColorMirrorHotTo = 1617645
    TabAppearance.ColorMirrorSelected = 13816526
    TabAppearance.ColorMirrorSelectedTo = 13816526
    TabAppearance.ColorMirrorDisabled = clWhite
    TabAppearance.ColorMirrorDisabledTo = clSilver
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Tahoma'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggRadial
    TabAppearance.GradientMirrorHot = ggRadial
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clWhite
    TabAppearance.TextColorHot = clWhite
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = clBlack
    TabAppearance.HighLightColor = 9803929
    TabAppearance.HighLightColorHot = 9803929
    TabAppearance.HighLightColorSelected = 6540536
    TabAppearance.HighLightColorSelectedHot = 12451839
    TabAppearance.HighLightColorDown = 16776144
    TabAppearance.BackGround.Color = 5460819
    TabAppearance.BackGround.ColorTo = 3815994
    TabAppearance.BackGround.Direction = gdVertical
    GlowButtonAppearance.BorderColor = 12631218
    GlowButtonAppearance.BorderColorHot = 10079963
    GlowButtonAppearance.BorderColorDown = 4548219
    GlowButtonAppearance.BorderColorChecked = 4548219
    GlowButtonAppearance.Color = 14671574
    GlowButtonAppearance.ColorTo = 15000283
    GlowButtonAppearance.ColorChecked = 11918331
    GlowButtonAppearance.ColorCheckedTo = 7915518
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 7778289
    GlowButtonAppearance.ColorDownTo = 4296947
    GlowButtonAppearance.ColorHot = 15465983
    GlowButtonAppearance.ColorHotTo = 11332863
    GlowButtonAppearance.ColorMirror = 14144974
    GlowButtonAppearance.ColorMirrorTo = 15197664
    GlowButtonAppearance.ColorMirrorHot = 5888767
    GlowButtonAppearance.ColorMirrorHotTo = 10807807
    GlowButtonAppearance.ColorMirrorDown = 946929
    GlowButtonAppearance.ColorMirrorDownTo = 5021693
    GlowButtonAppearance.ColorMirrorChecked = 10480637
    GlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    GlowButtonAppearance.ColorMirrorDisabled = 11974326
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    Left = 624
    Top = 32
  end
  object AdvPanelStyler1: TAdvPanelStyler
    Tag = 0
    Settings.AnchorHint = False
    Settings.BevelInner = bvNone
    Settings.BevelOuter = bvNone
    Settings.BevelWidth = 1
    Settings.BorderColor = 16765615
    Settings.BorderShadow = False
    Settings.BorderStyle = bsNone
    Settings.BorderWidth = 0
    Settings.CanMove = False
    Settings.CanSize = False
    Settings.Caption.Color = 12105910
    Settings.Caption.ColorTo = 10526878
    Settings.Caption.Font.Charset = DEFAULT_CHARSET
    Settings.Caption.Font.Color = clWhite
    Settings.Caption.Font.Height = -11
    Settings.Caption.Font.Name = 'MS Sans Serif'
    Settings.Caption.Font.Style = []
    Settings.Caption.GradientDirection = gdVertical
    Settings.Caption.Indent = 2
    Settings.Caption.ShadeLight = 255
    Settings.Collaps = False
    Settings.CollapsColor = clHighlight
    Settings.CollapsDelay = 0
    Settings.CollapsSteps = 0
    Settings.Color = 13616833
    Settings.ColorTo = 12958644
    Settings.ColorMirror = 12958644
    Settings.ColorMirrorTo = 15527141
    Settings.Cursor = crDefault
    Settings.Font.Charset = DEFAULT_CHARSET
    Settings.Font.Color = 7485192
    Settings.Font.Height = -11
    Settings.Font.Name = 'MS Sans Serif'
    Settings.Font.Style = []
    Settings.FixedTop = False
    Settings.FixedLeft = False
    Settings.FixedHeight = False
    Settings.FixedWidth = False
    Settings.Height = 120
    Settings.Hover = False
    Settings.HoverColor = clNone
    Settings.HoverFontColor = clNone
    Settings.Indent = 0
    Settings.ShadowColor = clBlack
    Settings.ShadowOffset = 0
    Settings.ShowHint = False
    Settings.ShowMoveCursor = False
    Settings.StatusBar.BorderStyle = bsSingle
    Settings.StatusBar.Font.Charset = DEFAULT_CHARSET
    Settings.StatusBar.Font.Color = clWhite
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 10592158
    Settings.StatusBar.ColorTo = 5459275
    Settings.StatusBar.GradientDirection = gdVertical
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Style = psOffice2007Obsidian
    Left = 712
    Top = 48
  end
  object CofigStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2007Obsidian
    Left = 800
    Top = 336
  end
  object AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler
    Style = bsOffice2007Obsidian
    BorderColor = 11841710
    BorderColorHot = 11841710
    ButtonAppearance.Color = 13627626
    ButtonAppearance.ColorTo = 9224369
    ButtonAppearance.ColorChecked = 9229823
    ButtonAppearance.ColorCheckedTo = 5812223
    ButtonAppearance.ColorDown = 5149182
    ButtonAppearance.ColorDownTo = 9556991
    ButtonAppearance.ColorHot = 13432063
    ButtonAppearance.ColorHotTo = 9556223
    ButtonAppearance.BorderDownColor = 3693887
    ButtonAppearance.BorderHotColor = 3693887
    ButtonAppearance.BorderCheckedColor = 3693887
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'Tahoma'
    ButtonAppearance.CaptionFont.Style = []
    CaptionAppearance.CaptionColor = 12105910
    CaptionAppearance.CaptionColorTo = 10526878
    CaptionAppearance.CaptionBorderColor = clHighlight
    CaptionAppearance.CaptionColorHot = 11184809
    CaptionAppearance.CaptionColorHotTo = 7237229
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = 12958644
    Color.ColorTo = 15527141
    Color.Direction = gdVertical
    Color.Mirror.Color = 14736343
    Color.Mirror.ColorTo = 13617090
    Color.Mirror.ColorMirror = 13024437
    Color.Mirror.ColorMirrorTo = 15000281
    ColorHot.Color = 15921390
    ColorHot.ColorTo = 16316662
    ColorHot.Direction = gdVertical
    ColorHot.Mirror.Color = 15789804
    ColorHot.Mirror.ColorTo = 15592168
    ColorHot.Mirror.ColorMirror = 15131103
    ColorHot.Mirror.ColorMirrorTo = 16185075
    CompactGlowButtonAppearance.BorderColor = 12631218
    CompactGlowButtonAppearance.BorderColorHot = 10079963
    CompactGlowButtonAppearance.BorderColorDown = 4548219
    CompactGlowButtonAppearance.BorderColorChecked = 4548219
    CompactGlowButtonAppearance.Color = 14671574
    CompactGlowButtonAppearance.ColorTo = 15000283
    CompactGlowButtonAppearance.ColorChecked = 11918331
    CompactGlowButtonAppearance.ColorCheckedTo = 7915518
    CompactGlowButtonAppearance.ColorDisabled = 15921906
    CompactGlowButtonAppearance.ColorDisabledTo = 15921906
    CompactGlowButtonAppearance.ColorDown = 7778289
    CompactGlowButtonAppearance.ColorDownTo = 4296947
    CompactGlowButtonAppearance.ColorHot = 15465983
    CompactGlowButtonAppearance.ColorHotTo = 11332863
    CompactGlowButtonAppearance.ColorMirror = 14144974
    CompactGlowButtonAppearance.ColorMirrorTo = 15197664
    CompactGlowButtonAppearance.ColorMirrorHot = 5888767
    CompactGlowButtonAppearance.ColorMirrorHotTo = 10807807
    CompactGlowButtonAppearance.ColorMirrorDown = 946929
    CompactGlowButtonAppearance.ColorMirrorDownTo = 5021693
    CompactGlowButtonAppearance.ColorMirrorChecked = 10480637
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    CompactGlowButtonAppearance.ColorMirrorDisabled = 11974326
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    CompactGlowButtonAppearance.GradientHot = ggVertical
    CompactGlowButtonAppearance.GradientMirrorHot = ggVertical
    CompactGlowButtonAppearance.GradientDown = ggVertical
    CompactGlowButtonAppearance.GradientMirrorDown = ggVertical
    CompactGlowButtonAppearance.GradientChecked = ggVertical
    DockColor.Color = 13616833
    DockColor.ColorTo = 12958644
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 128
    DragGripStyle = dsNone
    FloatingWindowBorderColor = 11841710
    FloatingWindowBorderWidth = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GlowButtonAppearance.BorderColor = 12631218
    GlowButtonAppearance.BorderColorHot = 10079963
    GlowButtonAppearance.BorderColorDown = 4548219
    GlowButtonAppearance.BorderColorChecked = 4548219
    GlowButtonAppearance.Color = 14671574
    GlowButtonAppearance.ColorTo = 15000283
    GlowButtonAppearance.ColorChecked = 11918331
    GlowButtonAppearance.ColorCheckedTo = 7915518
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 7778289
    GlowButtonAppearance.ColorDownTo = 4296947
    GlowButtonAppearance.ColorHot = 15465983
    GlowButtonAppearance.ColorHotTo = 11332863
    GlowButtonAppearance.ColorMirror = 14144974
    GlowButtonAppearance.ColorMirrorTo = 15197664
    GlowButtonAppearance.ColorMirrorHot = 5888767
    GlowButtonAppearance.ColorMirrorHotTo = 10807807
    GlowButtonAppearance.ColorMirrorDown = 946929
    GlowButtonAppearance.ColorMirrorDownTo = 5021693
    GlowButtonAppearance.ColorMirrorChecked = 10480637
    GlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    GlowButtonAppearance.ColorMirrorDisabled = 11974326
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    GroupAppearance.BorderColor = 8878963
    GroupAppearance.Color = 4413279
    GroupAppearance.ColorTo = 3620416
    GroupAppearance.ColorMirror = 4413279
    GroupAppearance.ColorMirrorTo = 1617645
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -11
    GroupAppearance.Font.Name = 'Tahoma'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggRadial
    GroupAppearance.GradientMirror = ggRadial
    GroupAppearance.TextColor = clWhite
    GroupAppearance.CaptionAppearance.CaptionColor = 12105910
    GroupAppearance.CaptionAppearance.CaptionColorTo = 10526878
    GroupAppearance.CaptionAppearance.CaptionColorHot = 11184809
    GroupAppearance.CaptionAppearance.CaptionColorHotTo = 7237229
    GroupAppearance.PageAppearance.BorderColor = 12763842
    GroupAppearance.PageAppearance.Color = 15530237
    GroupAppearance.PageAppearance.ColorTo = 16382457
    GroupAppearance.PageAppearance.ColorMirror = 16382457
    GroupAppearance.PageAppearance.ColorMirrorTo = 16382457
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.PageAppearance.ShadowColor = clBlack
    GroupAppearance.PageAppearance.HighLightColor = 15526887
    GroupAppearance.TabAppearance.BorderColor = 10534860
    GroupAppearance.TabAppearance.BorderColorHot = 9870494
    GroupAppearance.TabAppearance.BorderColorSelected = 10534860
    GroupAppearance.TabAppearance.BorderColorSelectedHot = 10534860
    GroupAppearance.TabAppearance.BorderColorDisabled = clNone
    GroupAppearance.TabAppearance.BorderColorDown = clNone
    GroupAppearance.TabAppearance.Color = clBtnFace
    GroupAppearance.TabAppearance.ColorTo = clWhite
    GroupAppearance.TabAppearance.ColorSelected = 10412027
    GroupAppearance.TabAppearance.ColorSelectedTo = 12249340
    GroupAppearance.TabAppearance.ColorDisabled = clNone
    GroupAppearance.TabAppearance.ColorDisabledTo = clNone
    GroupAppearance.TabAppearance.ColorHot = 5992568
    GroupAppearance.TabAppearance.ColorHotTo = 9803415
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = 4413279
    GroupAppearance.TabAppearance.ColorMirrorHotTo = 1617645
    GroupAppearance.TabAppearance.ColorMirrorSelected = 12249340
    GroupAppearance.TabAppearance.ColorMirrorSelectedTo = 13955581
    GroupAppearance.TabAppearance.ColorMirrorDisabled = clNone
    GroupAppearance.TabAppearance.ColorMirrorDisabledTo = clNone
    GroupAppearance.TabAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.TabAppearance.Font.Color = clWindowText
    GroupAppearance.TabAppearance.Font.Height = -11
    GroupAppearance.TabAppearance.Font.Name = 'Tahoma'
    GroupAppearance.TabAppearance.Font.Style = []
    GroupAppearance.TabAppearance.Gradient = ggRadial
    GroupAppearance.TabAppearance.GradientMirror = ggRadial
    GroupAppearance.TabAppearance.GradientHot = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorHot = ggVertical
    GroupAppearance.TabAppearance.GradientSelected = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorSelected = ggVertical
    GroupAppearance.TabAppearance.GradientDisabled = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorDisabled = ggVertical
    GroupAppearance.TabAppearance.TextColor = clWhite
    GroupAppearance.TabAppearance.TextColorHot = clWhite
    GroupAppearance.TabAppearance.TextColorSelected = 9126421
    GroupAppearance.TabAppearance.TextColorDisabled = clWhite
    GroupAppearance.TabAppearance.ShadowColor = clBlack
    GroupAppearance.TabAppearance.HighLightColor = 9803929
    GroupAppearance.TabAppearance.HighLightColorHot = 9803929
    GroupAppearance.TabAppearance.HighLightColorSelected = 6540536
    GroupAppearance.TabAppearance.HighLightColorSelectedHot = 12451839
    GroupAppearance.TabAppearance.HighLightColorDown = 16776144
    GroupAppearance.ToolBarAppearance.BorderColor = 13423059
    GroupAppearance.ToolBarAppearance.BorderColorHot = 13092807
    GroupAppearance.ToolBarAppearance.Color.Color = 15530237
    GroupAppearance.ToolBarAppearance.Color.ColorTo = 16382457
    GroupAppearance.ToolBarAppearance.Color.Direction = gdHorizontal
    GroupAppearance.ToolBarAppearance.ColorHot.Color = 15660277
    GroupAppearance.ToolBarAppearance.ColorHot.ColorTo = 16645114
    GroupAppearance.ToolBarAppearance.ColorHot.Direction = gdHorizontal
    PageAppearance.BorderColor = 11841710
    PageAppearance.Color = 14736343
    PageAppearance.ColorTo = 13617090
    PageAppearance.ColorMirror = 13024437
    PageAppearance.ColorMirrorTo = 15790311
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PageAppearance.ShadowColor = 5263440
    PageAppearance.HighLightColor = 15526887
    PagerCaption.BorderColor = clBlack
    PagerCaption.Color = 5392195
    PagerCaption.ColorTo = 4866108
    PagerCaption.ColorMirror = 3158063
    PagerCaption.ColorMirrorTo = 4079166
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clBlue
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -11
    PagerCaption.Font.Name = 'Tahoma'
    PagerCaption.Font.Style = []
    QATAppearance.BorderColor = 2697513
    QATAppearance.Color = 8683131
    QATAppearance.ColorTo = 4671303
    QATAppearance.FullSizeBorderColor = 13552843
    QATAppearance.FullSizeColor = 9407882
    QATAppearance.FullSizeColorTo = 9407882
    RightHandleColor = 13289414
    RightHandleColorTo = 11841710
    RightHandleColorHot = 13891839
    RightHandleColorHotTo = 7782911
    RightHandleColorDown = 557032
    RightHandleColorDownTo = 8182519
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = 9870494
    TabAppearance.BorderColorSelected = 14922381
    TabAppearance.BorderColorSelectedHot = 6343929
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 15724269
    TabAppearance.ColorSelectedTo = 15724269
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 5992568
    TabAppearance.ColorHotTo = 9803415
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 4413279
    TabAppearance.ColorMirrorHotTo = 1617645
    TabAppearance.ColorMirrorSelected = 13816526
    TabAppearance.ColorMirrorSelectedTo = 13816526
    TabAppearance.ColorMirrorDisabled = clWhite
    TabAppearance.ColorMirrorDisabledTo = clSilver
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Tahoma'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggRadial
    TabAppearance.GradientMirrorHot = ggRadial
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clWhite
    TabAppearance.TextColorHot = clWhite
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = clBlack
    TabAppearance.HighLightColor = 9803929
    TabAppearance.HighLightColorHot = 9803929
    TabAppearance.HighLightColorSelected = 6540536
    TabAppearance.HighLightColorSelectedHot = 12451839
    TabAppearance.HighLightColorDown = 16776144
    TabAppearance.BackGround.Color = 5460819
    TabAppearance.BackGround.ColorTo = 3815994
    TabAppearance.BackGround.Direction = gdVertical
    Left = 680
    Top = 33
  end
  object OpenDialog1: TOpenDialog
    Left = 632
    Top = 400
  end
  object SaveDialog1: TSaveDialog
    Left = 464
    Top = 48
  end
  object pmMainData: TAdvPopupMenu
    Images = ImageListSet2
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 1
    Top = 65533
    object few1: TMenuItem
      Caption = 'Записать'
      ImageIndex = 0
      OnClick = OnSaveGenData
    end
    object N3: TMenuItem
      Caption = 'Прочитать'
      ImageIndex = 1
      OnClick = OnGetGenData
    end
    object N4: TMenuItem
      Caption = 'Применить'
      ImageIndex = 2
      OnClick = OnSetSettings
    end
    object N75: TMenuItem
      Caption = 'Установить удаленно'
      ImageIndex = 3
      OnClick = OnSetRemSettings
    end
  end
  object pmMainTime: TAdvPopupMenu
    Images = ImageListSet2
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 25
    Top = 65533
    object N6: TMenuItem
      Caption = 'Синхронизировать время'
      ImageIndex = 4
      OnClick = OnSettTime
    end
    object N7: TMenuItem
      Caption = 'Разорвать соединение'
      ImageIndex = 5
      OnClick = OnRepplMdm
    end
  end
  object ppMainSystem: TAdvPopupMenu
    Images = ImageListSet2
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 57
    Top = 65533
    object N15: TMenuItem
      Caption = 'Перезагрузить ПО УСПД'
      ImageIndex = 23
      OnClick = OnSendReload
    end
    object N63: TMenuItem
      Caption = '-'
    end
  end
  object pmTimeData: TAdvPopupMenu
    Images = ImageListSet2
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 3
    Top = 23
    object N16: TMenuItem
      Caption = 'Записать'
      ImageIndex = 17
      OnClick = OnSaveGridTTime
    end
    object N17: TMenuItem
      Caption = 'Прочитать'
      ImageIndex = 18
      OnClick = OnSetGridTTime
    end
    object N18: TMenuItem
      Caption = 'Режим редактирования'
      ImageIndex = 2
      OnClick = OnSetEditTTime
    end
  end
  object pmTimeEdit: TAdvPopupMenu
    Images = ImageListSet2
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 27
    Top = 23
    object N19: TMenuItem
      Caption = 'Загрузка модуля переходов'
      ImageIndex = 19
      OnClick = OnLoadModule
    end
    object N20: TMenuItem
      Caption = 'Создать'
      ImageIndex = 11
      OnClick = OnAddTTime
    end
    object N21: TMenuItem
      Caption = 'Клонировать'
      ImageIndex = 16
      OnClick = OnCloneTTime
    end
    object N22: TMenuItem
      Caption = 'Удалить запись'
      ImageIndex = 13
      OnClick = OnDellRowTTime
    end
    object N23: TMenuItem
      Caption = 'Удалить всё'
      ImageIndex = 12
      OnClick = OnDelAllRowTTime
    end
  end
  object pmQuerGrData: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 65533
    Top = 55
    object N26: TMenuItem
      Caption = 'Записать'
      ImageIndex = 0
      OnClick = OnSetSdl
    end
    object N27: TMenuItem
      Caption = 'Восстановить'
      ImageIndex = 1
      OnClick = OnGetSdl
    end
  end
  object pmQuerGrEdit: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 30
    Top = 59
    object N28: TMenuItem
      Caption = 'Генерировать'
      ImageIndex = 2
      OnClick = OnGenSdl
    end
    object N29: TMenuItem
      Caption = 'Сброс состояния'
      ImageIndex = 3
      OnClick = OnResetAllState
    end
    object N30: TMenuItem
      Caption = 'Режим редактирования'
      ImageIndex = 5
      OnClick = OnSetMode
    end
    object N31: TMenuItem
      Caption = 'Удалить'
      ImageIndex = 6
      OnClick = OnDelSdl
    end
  end
  object pmQuerGrContr: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 74
    Top = 63
    object N32: TMenuItem
      Caption = 'Установить изменения'
      ImageIndex = 4
      OnClick = OSdlInit
    end
  end
  object pmEventData: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 3
    Top = 95
    object N33: TMenuItem
      Caption = 'Записать'
      ImageIndex = 0
      OnClick = OnSetEvents
    end
    object N34: TMenuItem
      Caption = 'Восстановить'
      ImageIndex = 1
      OnClick = OnGetAllEvents
    end
  end
  object pmEventEdit: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 27
    Top = 95
    object N35: TMenuItem
      Caption = 'Режим редактирования'
      ImageIndex = 5
      OnClick = OnSetMode
    end
    object N36: TMenuItem
      Caption = 'Удалить'
      ImageIndex = 6
      OnClick = OnDelAllEvent
    end
  end
  object pmEventTJrnl: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 59
    Top = 104
    object N110: TMenuItem
      Caption = 'Журнал №1'
      ImageIndex = 2
      OnClick = OnGetEv0
    end
    object N210: TMenuItem
      Caption = 'Журнал №2'
      ImageIndex = 3
      OnClick = OnGetEv1
    end
    object N37: TMenuItem
      Caption = 'Журнал №3'
      ImageIndex = 4
      OnClick = OnGetEv2
    end
    object N41: TMenuItem
      Caption = 'Журнал №4'
      ImageIndex = 10
      OnClick = OnGetEv3
    end
  end
  object AdvMenuOfficeStyler1: TAdvMenuOfficeStyler
    AntiAlias = aaNone
    AutoThemeAdapt = False
    Style = osOffice2007Obsidian
    Background.Position = bpCenter
    Background.Color = 16185078
    Background.ColorTo = 16185078
    ButtonAppearance.DownColor = 13421257
    ButtonAppearance.DownColorTo = 15395047
    ButtonAppearance.HoverColor = 14737117
    ButtonAppearance.HoverColorTo = 16052977
    ButtonAppearance.DownBorderColor = 11906984
    ButtonAppearance.HoverBorderColor = 11906984
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'Tahoma'
    ButtonAppearance.CaptionFont.Style = []
    IconBar.Color = 15658729
    IconBar.ColorTo = 15658729
    IconBar.CheckBorder = clNavy
    IconBar.RadioBorder = clNavy
    IconBar.SeparatorColor = 12961221
    SelectedItem.Color = 15465983
    SelectedItem.ColorTo = 11267071
    SelectedItem.ColorMirror = 6936319
    SelectedItem.ColorMirrorTo = 9889023
    SelectedItem.BorderColor = 10079963
    SelectedItem.Font.Charset = DEFAULT_CHARSET
    SelectedItem.Font.Color = clWindowText
    SelectedItem.Font.Height = -11
    SelectedItem.Font.Name = 'Tahoma'
    SelectedItem.Font.Style = []
    SelectedItem.NotesFont.Charset = DEFAULT_CHARSET
    SelectedItem.NotesFont.Color = clWindowText
    SelectedItem.NotesFont.Height = -8
    SelectedItem.NotesFont.Name = 'Tahoma'
    SelectedItem.NotesFont.Style = []
    SelectedItem.CheckBorder = clNavy
    SelectedItem.RadioBorder = clNavy
    RootItem.Color = 12105910
    RootItem.ColorTo = 10526878
    RootItem.GradientDirection = gdVertical
    RootItem.Font.Charset = DEFAULT_CHARSET
    RootItem.Font.Color = clWindowText
    RootItem.Font.Height = -11
    RootItem.Font.Name = 'Tahoma'
    RootItem.Font.Style = []
    RootItem.SelectedColor = 7778289
    RootItem.SelectedColorTo = 4296947
    RootItem.SelectedColorMirror = 946929
    RootItem.SelectedColorMirrorTo = 5021693
    RootItem.SelectedBorderColor = 4548219
    RootItem.HoverColor = 15465983
    RootItem.HoverColorTo = 11267071
    RootItem.HoverColorMirror = 6936319
    RootItem.HoverColorMirrorTo = 9889023
    RootItem.HoverBorderColor = 10079963
    Glyphs.SubMenu.Data = {
      5A000000424D5A000000000000003E0000002800000004000000070000000100
      0100000000001C0000000000000000000000020000000200000000000000FFFF
      FF0070000000300000001000000000000000100000003000000070000000}
    Glyphs.Check.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FDFF0000F8FF0000F07F0000F23F
      0000F71F0000FF8F0000FFCF0000FFEF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    Glyphs.Radio.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FC3F0000F81F0000F81F
      0000F81F0000F81F0000FC3F0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    SideBar.Font.Charset = DEFAULT_CHARSET
    SideBar.Font.Color = clWhite
    SideBar.Font.Height = -19
    SideBar.Font.Name = 'Tahoma'
    SideBar.Font.Style = [fsBold, fsItalic]
    SideBar.Image.Position = bpCenter
    SideBar.Background.Position = bpCenter
    SideBar.SplitterColorTo = clBlack
    Separator.Color = 12961221
    Separator.GradientType = gtBoth
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clGray
    NotesFont.Height = -8
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    MenuBorderColor = clSilver
    Left = 706
    Top = 123
  end
end
