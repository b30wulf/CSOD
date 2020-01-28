object TAbonManager: TTAbonManager
  Left = 655
  Top = 56
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Абоненты'
  ClientHeight = 651
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = OnActivate
  OnCreate = OnCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label27: TLabel
    Left = 558
    Top = 466
    Width = 73
    Height = 15
    Caption = 'Тип сч. НКУ:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object aop_AbonPages: TAdvOfficePager
    Left = 0
    Top = 44
    Width = 537
    Height = 607
    AdvOfficePagerStyler = AdvOfficePagerOfficeStyler1
    Align = alClient
    ActivePage = pgImportData
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
    Constraints.MinWidth = 510
    TabSettings.StartMargin = 4
    TabSettings.Shape = tsRightRamp
    TabReorder = False
    ShowShortCutHints = False
    TabOrder = 0
    NextPictureChanged = False
    PrevPictureChanged = False
    object aop_AbonAttributes: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 535
      Height = 579
      Hint = 'Fnh'
      Caption = 'Атрибуты абонента'
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
      object AdvPanel3: TAdvPanel
        Left = 2
        Top = 2
        Width = 531
        Height = 575
        Align = alClient
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
        object Label18: TLabel
          Left = 18
          Top = 78
          Width = 80
          Height = 13
          Caption = 'Название дома:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label25: TLabel
          Left = 17
          Top = 101
          Width = 76
          Height = 13
          Caption = 'Адрес (улица):'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 18
          Top = 54
          Width = 100
          Height = 13
          Caption = 'Дата регистрации :'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbTelToToRing: TLabel
          Left = 17
          Top = 125
          Width = 93
          Height = 13
          Caption = 'Телефон дозвона:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object pbm_sBTIProgress: TAdvProgressBar
          Left = 0
          Top = 536
          Width = 531
          Height = 20
          Align = alBottom
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
        object Label8: TLabel
          Left = 17
          Top = 178
          Width = 107
          Height = 13
          Caption = 'Видимость в дереве:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object lbm_sHouseNumber: TLabel
          Left = 17
          Top = 233
          Width = 43
          Height = 15
          Caption = 'Дом №:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbm_sKorpusNumber: TLabel
          Left = 130
          Top = 233
          Width = 60
          Height = 15
          Caption = 'Корпус №:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 334
          Top = 35
          Width = 50
          Height = 13
          Caption = 'Абонент :'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbHouseGenLabel: TGradientLabel
          Left = -3
          Top = 206
          Width = 538
          Height = 17
          Alignment = taCenter
          Anchors = [akLeft, akRight]
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = 'Параметры генератора бытового учета'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          Layout = tlCenter
          ColorTo = clWhite
          EllipsType = etNone
          GradientType = gtFullHorizontal
          Indent = 0
          LineWidth = 2
          Orientation = goHorizontal
          TransparentText = False
          VAlignment = vaTop
        end
        object lbm_sVmName: TLabel
          Left = 17
          Top = 265
          Width = 89
          Height = 15
          Caption = 'Название учета:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object GradientLabel5: TGradientLabel
          Left = -3
          Top = 3
          Width = 537
          Height = 17
          Alignment = taCenter
          Anchors = [akLeft, akRight]
          AutoSize = False
          Caption = 'Атрибуты абонента'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ColorTo = clWhite
          EllipsType = etNone
          GradientType = gtFullHorizontal
          Indent = 0
          LineWidth = 2
          Orientation = goHorizontal
          TransparentText = False
          VAlignment = vaTop
        end
        object Label11: TLabel
          Left = 446
          Top = 35
          Width = 17
          Height = 13
          Caption = 'ТП:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object TpName: TLabel
          Left = 18
          Top = 30
          Width = 71
          Height = 13
          Caption = 'Название ТП :'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label31: TLabel
          Left = 17
          Top = 289
          Width = 91
          Height = 15
          Caption = 'Город/село (0/1)'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 17
          Top = 154
          Width = 64
          Height = 13
          Caption = 'Активность:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object GradientLabel2: TGradientLabel
          Left = -3
          Top = 313
          Width = 537
          Height = 17
          Alignment = taCenter
          Anchors = [akLeft, akRight]
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = 'Параметры генератора для счетчиков'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          Layout = tlCenter
          ColorTo = clWhite
          EllipsType = etNone
          GradientType = gtFullHorizontal
          Indent = 0
          LineWidth = 2
          Orientation = goHorizontal
          TransparentText = False
          VAlignment = vaTop
        end
        object lbm_snFirstKvartNumber: TLabel
          Left = 17
          Top = 357
          Width = 96
          Height = 15
          Caption = 'Квартирные сч. с'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbm_snEndKvartNumber: TLabel
          Left = 158
          Top = 357
          Width = 14
          Height = 15
          Alignment = taCenter
          Caption = 'по'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lbm_snAmBal1: TLabel
          Left = 17
          Top = 380
          Width = 83
          Height = 15
          Caption = 'К-во Балансных:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbm_snAmBal2: TLabel
          Left = 17
          Top = 432
          Width = 141
          Height = 15
          Caption = 'К-во не кв. учет в балансне:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbm_snAmBal3: TLabel
          Left = 17
          Top = 453
          Width = 146
          Height = 15
          Caption = 'К-во не кв. учет не балансне:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbm_nKvarUchType: TLabel
          Left = 17
          Top = 508
          Width = 57
          Height = 15
          Caption = 'Протокол:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object GradientLabel6: TGradientLabel
          Left = 0
          Top = 334
          Width = 225
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = '1'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          Layout = tlCenter
          ColorTo = clWhite
          EllipsType = etNone
          GradientType = gtFullHorizontal
          Indent = 0
          LineWidth = 2
          Orientation = goHorizontal
          TransparentText = False
          VAlignment = vaTop
        end
        object GradientLabel7: TGradientLabel
          Left = -5
          Top = 404
          Width = 230
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = '2'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          Layout = tlCenter
          ColorTo = clWhite
          EllipsType = etNone
          GradientType = gtFullHorizontal
          Indent = 0
          LineWidth = 2
          Orientation = goHorizontal
          TransparentText = False
          VAlignment = vaTop
        end
        object GradientLabel8: TGradientLabel
          Left = -5
          Top = 482
          Width = 230
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = '3'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          Layout = tlCenter
          ColorTo = clWhite
          EllipsType = etNone
          GradientType = gtFullHorizontal
          Indent = 0
          LineWidth = 2
          Orientation = goHorizontal
          TransparentText = False
          VAlignment = vaTop
        end
        object sbAbon: TAdvOfficeStatusBar
          Left = 0
          Top = 556
          Width = 531
          Height = 19
          AnchorHint = False
          Images = ImageList1
          Panels = <
            item
              Animated = True
              AnimationImages = ImageList1
              AppearanceStyle = psLight
              AutoSize = True
              DateFormat = 'dd.MM.yyyy'
              ImageIndex = 6
              Progress.BackGround = clNone
              Progress.Indication = piPercentage
              Progress.Min = 0
              Progress.Max = 100
              Progress.Position = 0
              Progress.Level0Color = clLime
              Progress.Level0ColorTo = 14811105
              Progress.Level1Color = clYellow
              Progress.Level1ColorTo = 13303807
              Progress.Level2Color = 5483007
              Progress.Level2ColorTo = 11064319
              Progress.Level3Color = clRed
              Progress.Level3ColorTo = 13290239
              Progress.Level1Perc = 70
              Progress.Level2Perc = 90
              Progress.BorderColor = clBlack
              Progress.ShowBorder = False
              Progress.Stacked = False
              Text = 'Абонент предприятия'
              TimeFormat = 'h:mm:ss'
              Width = 141
            end>
          SimplePanel = False
          URLColor = clBlue
          Styler = AdvOfficeStatusBarOfficeStyler1
          Version = '1.2.0.6'
        end
        object edm_swABOID: TEdit
          Left = 389
          Top = 32
          Width = 51
          Height = 21
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edm_sName: TEdit
          Left = 156
          Top = 73
          Width = 372
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object edm_sAddress: TEdit
          Left = 155
          Top = 98
          Width = 297
          Height = 21
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object cbm_sbyEnable: TComboBox
          Left = 155
          Top = 148
          Width = 60
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 4
          Visible = False
        end
        object edm_sdtRegDate: TEdit
          Left = 156
          Top = 51
          Width = 131
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object edm_TelToRing: TEdit
          Left = 155
          Top = 122
          Width = 112
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object cbm_sbyVisible: TComboBox
          Left = 155
          Top = 175
          Width = 60
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 7
          Visible = False
        end
        object edm_sHouseNumber: TEdit
          Left = 72
          Top = 230
          Width = 40
          Height = 22
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object edm_sKorpusNumber: TEdit
          Left = 196
          Top = 230
          Width = 84
          Height = 22
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object edm_sVmName: TEdit
          Left = 116
          Top = 262
          Width = 111
          Height = 22
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          Text = 'кв №'
        end
        object edm_swTPID: TEdit
          Left = 469
          Top = 32
          Width = 51
          Height = 21
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object TPnasp: TEdit
          Left = 157
          Top = 27
          Width = 76
          Height = 21
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object edm_Gors: TEdit
          Left = 116
          Top = 286
          Width = 111
          Height = 22
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          Text = '0'
        end
        object sem_snFirstKvartNumber: TSpinEdit
          Left = 114
          Top = 357
          Width = 40
          Height = 22
          MaxValue = 500
          MinValue = 0
          TabOrder = 14
          Value = 1
        end
        object sem_snEndKvartNumber: TSpinEdit
          Left = 179
          Top = 357
          Width = 40
          Height = 22
          MaxValue = 5000
          MinValue = 0
          TabOrder = 15
          Value = 1
        end
        object sem_snAmBal1: TSpinEdit
          Left = 114
          Top = 377
          Width = 40
          Height = 22
          MaxValue = 500
          MinValue = 0
          TabOrder = 16
          Value = 1
        end
        object sem_snAmBal2: TSpinEdit
          Left = 168
          Top = 428
          Width = 40
          Height = 22
          MaxValue = 500
          MinValue = 0
          TabOrder = 17
          Value = 0
        end
        object sem_snAmBal3: TSpinEdit
          Left = 168
          Top = 453
          Width = 40
          Height = 22
          MaxValue = 500
          MinValue = 0
          TabOrder = 18
          Value = 0
        end
        object cbm_nKvarUchType: TComboBox
          Left = 78
          Top = 506
          Width = 146
          Height = 22
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          TabOrder = 19
        end
      end
    end
    object AdvOfficePager12: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 535
      Height = 579
      Caption = 'Выбор отчетов'
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
      object v_ReportList: TAdvStringGrid
        Left = 2
        Top = 2
        Width = 531
        Height = 556
        Cursor = crDefault
        Align = alClient
        ColCount = 3
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLineWidth = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        GridLineColor = 15062992
        OnGetCellColor = v_ReportListGetCellColor
        OnGetEditorType = v_ReportListGetEditorType
        OnCheckBoxClick = v_ReportListCheckBoxClick
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 10344697
        ActiveCellColorTo = 6210033
        AutoThemeAdapt = True
        Bands.Active = True
        Bands.PrimaryColor = 16445929
        ColumnHeaders.Strings = (
          '№ п/п'
          'Название'
          'Видимость в дереве')
        ControlLook.FixedGradientFrom = 16250871
        ControlLook.FixedGradientTo = 14606046
        Filter = <>
        FixedRowHeight = 22
        FixedFont.Charset = RUSSIAN_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -12
        FixedFont.Name = 'Times New Roman'
        FixedFont.Style = []
        FloatFormat = '%.2f'
        Navigation.AlwaysEdit = True
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
        PrintSettings.PageNumSep = '/'
        RowIndicator.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFE12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFE0FFDFDFE0FFDFDFE0FFDFDFE0FFDFDFE0FFDFDF
          E0FFDFDFE0FFDFDFE0FFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
          DFFFDFDFDFFFDFDFDFFFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FFDFDFE0FFDFDFE0FFDFDFE0FFDFDFE0FFDFDFE0FFDFDFE0FFDFDF
          E0FFDFDFE0FFDFDFE0FFDFDFE0FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFE12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1
          F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FF12A1F1FFFFFFFFFEFFFFFFFEFFFF
          FFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFF
          FFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ScrollWidth = 16
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
        ShowModified.Enabled = True
        ColWidths = (
          64
          577
          132)
      end
      object AdvOfficeStatusBar1: TAdvOfficeStatusBar
        Left = 2
        Top = 558
        Width = 531
        Height = 19
        AnchorHint = False
        Images = ImageList1
        Panels = <
          item
            Animated = True
            AnimationImages = ImageList1
            AppearanceStyle = psLight
            AutoSize = True
            DateFormat = 'dd.MM.yyyy'
            ImageIndex = 6
            Progress.BackGround = clNone
            Progress.Indication = piPercentage
            Progress.Min = 0
            Progress.Max = 100
            Progress.Position = 0
            Progress.Level0Color = clLime
            Progress.Level0ColorTo = 14811105
            Progress.Level1Color = clYellow
            Progress.Level1ColorTo = 13303807
            Progress.Level2Color = 5483007
            Progress.Level2ColorTo = 11064319
            Progress.Level3Color = clRed
            Progress.Level3ColorTo = 13290239
            Progress.Level1Perc = 70
            Progress.Level2Perc = 90
            Progress.BorderColor = clBlack
            Progress.ShowBorder = False
            Progress.Stacked = False
            Text = 'Выбор отчетов'
            TimeFormat = 'h:mm:ss'
            Width = 105
          end>
        SimplePanel = False
        URLColor = clBlue
        Styler = AdvOfficeStatusBarOfficeStyler1
        Version = '1.2.0.6'
      end
    end
    object pgExportData: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 535
      Height = 579
      Caption = 'Экспорт объекта'
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
      object GradientLabel4: TGradientLabel
        Left = 11
        Top = 17
        Width = 782
        Height = 17
        AutoSize = False
        Caption = 'Параметры экспорта'
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
      object exportHouse: TAdvSmoothButton
        Left = 10
        Top = 40
        Width = 214
        Height = 41
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWindowText
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = []
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.BackGroundPictureLeft = 0
        Status.Appearance.Fill.BackGroundPictureTop = 0
        Status.Appearance.Fill.PictureLeft = 0
        Status.Appearance.Fill.PictureTop = 0
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Angle = 0
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Tahoma'
        Status.Appearance.Font.Style = []
        Caption = 'Экспорт абонентов'
        Color = 7237229
        TabOrder = 0
        Version = '1.5.0.1'
        OnClick = exportHouseClick
      end
    end
    object pgImportData: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 535
      Height = 579
      Caption = 'Импорт объекта'
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
      object GradientLabel3: TGradientLabel
        Left = 11
        Top = 17
        Width = 782
        Height = 17
        AutoSize = False
        Caption = 'Параметры импорта'
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
      object pbm_sBTIProgressImport: TAdvProgressBar
        Left = 2
        Top = 538
        Width = 531
        Height = 20
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        Level0ColorTo = 14811105
        Level1Color = clLime
        Level1ColorTo = 14811105
        Level2Color = clLime
        Level2ColorTo = 14811105
        Level3Color = clLime
        Level3ColorTo = 14811105
        Level1Perc = 70
        Level2Perc = 90
        Position = 0
        ShowBorder = True
        Version = '1.2.0.0'
      end
      object importHouse: TAdvSmoothButton
        Left = 8
        Top = 41
        Width = 235
        Height = 41
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWindowText
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = []
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.BackGroundPictureLeft = 0
        Status.Appearance.Fill.BackGroundPictureTop = 0
        Status.Appearance.Fill.PictureLeft = 0
        Status.Appearance.Fill.PictureTop = 0
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Angle = 0
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Tahoma'
        Status.Appearance.Font.Style = []
        Caption = 'Импорт абонентов'
        Color = 7237229
        TabOrder = 0
        Version = '1.5.0.1'
        OnClick = importHouseClick
      end
      object cmbPull: TComboBox
        Left = 31
        Top = 183
        Width = 155
        Height = 22
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
      object sbAbonImport: TAdvOfficeStatusBar
        Left = 2
        Top = 558
        Width = 531
        Height = 19
        AnchorHint = False
        Images = ImageList1
        Panels = <
          item
            Animated = True
            AnimationImages = ImageList1
            AppearanceStyle = psLight
            AutoSize = True
            DateFormat = 'dd.MM.yyyy'
            ImageIndex = 6
            Progress.BackGround = clNone
            Progress.Indication = piPercentage
            Progress.Min = 0
            Progress.Max = 100
            Progress.Position = 0
            Progress.Level0Color = clLime
            Progress.Level0ColorTo = 14811105
            Progress.Level1Color = clYellow
            Progress.Level1ColorTo = 13303807
            Progress.Level2Color = 5483007
            Progress.Level2ColorTo = 11064319
            Progress.Level3Color = clRed
            Progress.Level3ColorTo = 13290239
            Progress.Level1Perc = 70
            Progress.Level2Perc = 90
            Progress.BorderColor = clBlack
            Progress.ShowBorder = False
            Progress.Stacked = False
            Text = 'Абонент предприятия'
            TimeFormat = 'h:mm:ss'
            Width = 141
          end>
        SimplePanel = False
        URLColor = clBlue
        Styler = AdvOfficeStatusBarOfficeStyler1
        Version = '1.2.0.6'
      end
    end
    object pgAbonTreeSett: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 535
      Height = 579
      Caption = 'Настройки загрузкчика дерева'
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
      object cbArchv: TAdvOfficeCheckBox
        Left = 16
        Top = 16
        Width = 120
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать архивы'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        ReturnIsTab = False
        TabOrder = 0
        Version = '1.1.1.4'
      end
      object cbGraph: TAdvOfficeCheckBox
        Left = 16
        Top = 40
        Width = 169
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать графики'
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
      object cbLimit: TAdvOfficeCheckBox
        Left = 16
        Top = 64
        Width = 137
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать лимиты'
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
      object cbPeriod: TAdvOfficeCheckBox
        Left = 16
        Top = 88
        Width = 185
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать периодические'
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
      object cbCurrt: TAdvOfficeCheckBox
        Left = 16
        Top = 112
        Width = 161
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать текущие'
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
      object cbVecDg: TAdvOfficeCheckBox
        Left = 16
        Top = 136
        Width = 249
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать векторную диаграмму'
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
      object cbChndg: TAdvOfficeCheckBox
        Left = 16
        Top = 160
        Width = 153
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать замены'
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
      object cbEvents: TAdvOfficeCheckBox
        Left = 16
        Top = 184
        Width = 161
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать события'
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
      object cbRprts: TAdvOfficeCheckBox
        Left = 16
        Top = 208
        Width = 161
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Загружать отчеты'
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
    end
    object AdvProgressBar1: TAdvProgressBar
      Left = 0
      Top = 587
      Width = 537
      Height = 20
      Align = alBottom
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
    object CheckBox1: TCheckBox
      Left = 131
      Top = 138
      Width = 238
      Height = 17
      Caption = 'Атрибуты бытового учета'
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = cbHouseGenClick
    end
    object ComboBox1: TComboBox
      Left = 161
      Top = 55
      Width = 155
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 6
    end
    object cmbPullAbon: TComboBox
      Left = 159
      Top = 55
      Width = 155
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 7
    end
  end
  object AdvPanel4: TAdvPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    Color = 13616833
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
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
      Left = 391
      Top = 8
      Width = 186
      Height = 23
      Anchors = [akLeft]
      Caption = 'Параметры абонента'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object AdvToolBar1: TAdvToolBar
      Left = 0
      Top = 0
      Width = 326
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
      Images = ImageList1
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object AdvToolBarButton1: TAdvToolBarButton
        Left = 2
        Top = 2
        Width = 40
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
        ImageIndex = 14
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnSaveAbonSett
      end
      object AdvToolBarButton2: TAdvToolBarButton
        Left = 42
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Восстановить'
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
        ImageIndex = 15
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnGetAbonInfo
      end
      object AdvToolBarButton3: TAdvToolBarButton
        Left = 82
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Создать'
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
        ImageIndex = 16
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnCreateAbonSettings
      end
      object AdvToolBarButton4: TAdvToolBarButton
        Left = 122
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Удалить'
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
        ImageIndex = 17
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnDelAbonSettings
      end
      object AdvToolBarSeparator1: TAdvToolBarSeparator
        Left = 242
        Top = 2
        Width = 10
        Height = 40
        LineColor = clBtnShadow
      end
      object advSettAllRep: TAdvToolBarButton
        Left = 262
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Применить настройки отчетов ко всем абонентам'
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
        ImageIndex = 20
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = advSettAllRepClick
      end
      object AdvToolBarSeparator5: TAdvToolBarSeparator
        Left = 252
        Top = 2
        Width = 10
        Height = 40
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator4: TAdvToolBarSeparator
        Left = 302
        Top = 2
        Width = 10
        Height = 40
        LineColor = clBtnShadow
      end
      object AdvToolBarButton8: TAdvToolBarButton
        Left = 202
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Сгенерировать абонента'
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Segoe UI'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 19
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
      end
      object AdvToolBarButton10: TAdvToolBarButton
        Left = 162
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Удалить ТП'
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Segoe UI'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 18
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnDelTp
      end
    end
  end
  object AbonStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2007Obsidian
    Left = 412
    Top = 238
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 344
    Top = 104
    Bitmap = {
      494C010115001800040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000C000000001002000000000000080
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FAFAFAFFB1B1B1FFA7A7A7FFA6A6A6FFA6A6
      A6FFA6A6A6FFA7A7A7FFA7A7A7FFA8A8A8FFA9A9A9FFA9A9A9FFAAAAAAFFAAAA
      AAFFAAAAAAFFBEBEBEFFF4F4F4FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6D6D6FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF717171FFDCDCDCFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5D5D5FF646464FF878787FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6
      C6FFB7B7B7FF6B6B6BFF646464FF6B6B6BFFD8D8D8FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BABABAFF646464FF646464FF6A6A6AFFD8D8D8FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5E5E5FF646464FF646464FF646464FF6B6B6BFFDCDCDCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5D5D5FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F9F9F9FF646464FF646464FF646464FF646464FF6D6D6DFFE1E1
      E1FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7F7FFAAAA
      AAFF909090FFE6E6E6FF00000000E0E0E0FF666666FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFEFEFF646464FF646464FF646464FF646464FF646464FF7171
      71FFE6E6E6FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F9FF838383FF6464
      64FF646464FF686868FFAFAFAFFFFAFAFAFFE0E0E0FFBCBCBCFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFCFF646464FF646464FF646464FF646464FF646464FF6464
      64FF757575FFECECECFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8B8B8FF646464FF6464
      64FF646464FF646464FF646464FF797979FFD4D4D4FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFCFF696969FF646464FF646464FF646464FF646464FF6464
      64FF646464FF828282FFFDFDFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000909090FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF999999FFF0F0F0FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7E7E7FFD3D3D3FFCFCFCFFFC7C7C7FFB1B1B1FF8484
      84FF646464FF646464FFCFCFCFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008E8E8EFF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF6D6D6DFFBDBD
      BDFFFDFDFDFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3A3A3FF646464FFA9A9A9FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F1FF9B9B9BFF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF848484FFE0E0E0FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6D6D6FF646464FF989898FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D7D7
      D7FF7B7B7BFF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF666666FFA7A7A7FFF7F7F7FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFBFFB3B3B3FF696969FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF747474FFCCCCCCFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF939393FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E9E9E9FF8E8E8EFF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF919191FFEBEBEBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C9C9C9FF737373FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF6A6A6AFFB5B5
      B5FFFBFBFBFF0000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EAEAEAFFE9E9E9FFF5F5F5FFA4A4A4FF6565
      65FF646464FF646464FF646464FF646464FF646464FF646464FF646464FFA5A5
      A5FFF7F7F7FF0000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5D5D5FF696969FFC3C3C3FF00000000DEDE
      DEFF818181FF646464FF646464FF646464FF646464FF646464FF707070FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5D5D5FF646464FF9B9B9BFF000000000000
      0000FDFDFDFFBABABAFF6C6C6CFF646464FF646464FF646464FFA4A4A4FF0000
      0000EFEFEFFFB1B1B1FF00000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      00000000000000000000EEEEEEFF969696FF646464FFABABABFF000000000000
      0000888888FF646464FFDCDCDCFF000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      000000000000000000000000000000000000D1D1D1FFD3D3D3FF00000000F0F0
      F0FF6A6A6AFF656565FF939393FF000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFEFF000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D4FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5D5D5FF646464FF9B9B9BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9D9D9FF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5D5D5FF646464FF878787FFC7C7C7FFC7C7
      C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7
      C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7
      C7FFAFAFAFFF646464FF949494FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6D6D6FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF969696FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FAFAFAFFB2B2B2FFA8A8A8FFA9A9A9FFA9A9
      A9FFA9A9A9FFA9A9A9FFA9A9A9FFA9A9A9FFA9A9A9FFA8A8A8FFA8A8A8FFA8A8
      A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA9A9A9FFA9A9A9FFA9A9
      A9FFA9A9A9FFAAAAAAFFE0E0E0FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECECECFFBDBDBDFF858585FF6D6D6DFF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF6D6D6DFF858585FFBDBDBDFFECECECFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECECECFFBDBDBDFF858585FF6D6D6DFF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF6D6D6DFF858585FFBDBDBDFFECECECFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C1C1C1FF6464
      64FF646464FF707070FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9DFF9A9A
      9AFF9A9A9AFF9A9A9AFFA9A9A9FFD8D8D8FF9A9A9AFF9A9A9AFF9A9A9AFF9A9A
      9AFFD0D0D0FFAEAEAEFF9A9A9AFF9A9A9AFF9A9A9AFF9A9A9AFFF7F7F7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EEEEEEFF8B8B8BFF696969FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF696969FF8B8B8BFFEEEEEEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EEEEEEFF8B8B8BFF696969FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF696969FF8B8B8BFFEEEEEEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BCBCBCFF6464
      64FF646464FF656565FFFDFDFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FF838383FF646464FF646464FF646464FF646464FFCFCFCFFFB8B8
      B8FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ECECECFF8B8B8BFF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF8B8B8BFFECEC
      ECFF000000000000000000000000000000000000000000000000000000000000
      0000ECECECFF8B8B8BFF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF8B8B8BFFECEC
      ECFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B7B7B7FF6464
      64FF646464FF646464FFF1F1F1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FF838383FF646464FF646464FF646464FF646464FFCECECEFF8D8D
      8DFFC3C3C3FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBDFF696969FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF696969FFBDBD
      BDFF000000000000000000000000000000000000000000000000000000000000
      0000BDBDBDFF696969FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF696969FFBDBD
      BDFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2B2B2FF6464
      64FF646464FF646464FFE4E4E4FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FF838383FF646464FF646464FF646464FF646464FFCECECEFF8D8D
      8DFF767676FFDBDBDBFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000858585FF646464FF646464FF646464FF9F9F9FFFEBEBEBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EBEBEBFF9F9F9FFF646464FF646464FF646464FF8585
      85FF000000000000000000000000000000000000000000000000000000000000
      0000858585FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF8585
      85FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ADADADFF6464
      64FF646464FF646464FFD6D6D6FF0000000000000000FEFEFEFFECECECFFECEC
      ECFFECECECFFECECECFFECECECFFECECECFFECECECFFECECECFFF0F0F0FF0000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FF838383FF646464FF646464FF646464FF646464FFCECECEFF8D8D
      8DFF767676FF9E9E9EFFC3C3C3FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006D6D6DFF646464FF646464FF646464FFEBEBEBFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EBEBEBFF646464FF646464FF646464FF6D6D
      6DFF000000000000000000000000000000000000000000000000000000000000
      00006D6D6DFF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6D6D
      6DFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A8FF6464
      64FF646464FF646464FFC9C9C9FF0000000000000000FDFDFDFF656565FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF7C7C7CFF0000
      0000000000000000000000000000000000000000000000000000D9D9D9FFD8D8
      D8FFD8D8D8FFD8D8D8FFDDDDDDFFF0F0F0FFD8D8D8FFD7D7D7FFD7D7D7FFD8D8
      D8FFEDEDEDFFD6D6D6FFCDCDCDFFCDCDCDFFCDCDCDFFCCCCCCFFD7D7D7FF8D8D
      8DFF767676FF9D9D9DFFADADADFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A3A3A3FF6464
      64FF646464FF646464FFBCBCBCFF0000000000000000000000006C6C6CFF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF686868FFFEFE
      FEFF000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FFB7B7B7FF757575FF737373FF737373FF747474FF999999FFD0D0
      D0FF767676FF9D9D9DFFADADADFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009E9E9EFF6464
      64FF646464FF646464FFA3A3A3FF000000000000000000000000767676FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FFEEEE
      EEFF000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FF7E7E7EFFBFBFBFFF929292FF929292FF929292FF929292FFD6D6
      D6FFABABABFF9E9E9EFFADADADFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF00000000000000000000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000999999FF6464
      64FF646464FF646464FF646464FF989898FFF4F4F4FF000000007F7F7FFF6464
      64FF646464FFABABABFFC7C7C7FF9F9F9FFF7B7B7BFF666666FF6B6B6BFFE8E8
      E8FF000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB6B6B6FF797979FFA4A4A4FF646464FF646464FF646464FF646464FFC4C4
      C4FF939393FFBCBCBCFFADADADFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000787878FF6464
      64FF646464FF787878FF00000000000000000000000000000000787878FF6464
      64FF646464FF787878FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000949494FF6464
      64FF646464FF646464FF646464FF646464FF747474FFD4D4D4FF888888FF6464
      64FF646464FFB7B7B7FF000000000000000000000000FDFDFDFFFDFDFDFF0000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFC3C3C3FF646464FF646464FF646464FF6464
      64FFB7B7B7FF797979FFA4A4A4FF646464FF646464FF646464FF646464FFC4C4
      C4FF767676FFBABABAFFDCDCDCFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000787878FF6464
      64FF646464FF787878FF00000000000000000000000000000000787878FF6464
      64FF646464FF787878FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEEEEEFF9494
      94FF646464FF646464FF646464FF646464FF646464FF656565FF6B6B6BFF6464
      64FF646464FFBDBDBDFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000909090FF8C8C
      8CFF8C8C8CFF8C8C8CFF9D9D9DFFD2D2D2FF8C8C8CFF8C8C8CFF8C8C8CFF8C8C
      8CFFCBCBCBFF7A7A7AFFA4A4A4FF646464FF646464FF646464FF646464FFC4C4
      C4FF767676FF9E9E9EFFAEAEAEFF0000000000000000F4F4F4FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF00000000000000000000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CDCDCDFF747474FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FFC6C6C6FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B3B3B3FFB0B0
      B0FFB0B0B0FFB0B0B0FFBCBCBCFFF0F0F0FF9D9D9DFF939393FF939393FF9393
      93FF999999FFC4C4C4FFA8A8A8FF646464FF646464FF646464FF646464FFC5C5
      C5FF767676FF9E9E9EFFACACACFF00000000E3E3E3FF717171FFB9B9B9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F6FF9F9F9FFF646464FF646464FF646464FF646464FF6464
      64FF646464FFD2D2D2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFBBBBBBFFB7B7B7FFBBBBBBFFB9B9B9FFBABA
      BAFFBBBBBBFFD2D2D2FFF2F2F2FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFE7E7
      E7FF7E7E7EFF9E9E9EFFADADADFFE2E2E2FF707070FF646464FF646464FFB9B9
      B9FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      000000000000C8C8C8FFD2D2D2FFE1E1E1FFEFEFEFFFFCFCFCFF000000000000
      00000000000000000000FEFEFEFF6C6C6CFF646464FF646464FF646464FF6464
      64FF646464FFE1E1E1FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFB9B9B9FFA4A4A4FF666666FF646464FF6464
      64FF646464FF7F7F7FFFCDCDCDFF9F9F9FFF787878FF777777FF777777FF7E7E
      7EFFCCCCCCFFA6A6A6FFB4B4B4FF707070FF646464FF646464FF646464FF6464
      64FFB9B9B9FF0000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000FDFDFDFF656565FF646464FF646464FF646464FF656565FF707070FF7E7E
      7EFF9D9D9DFF00000000D7D7D7FF646464FF646464FF646464FF646464FF6464
      64FF646464FFEFEFEFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFB9B9B9FFA4A4A4FF676767FF646464FF6464
      64FF646464FF7F7F7FFFB5B5B5FFA9A9A9FFA9A9A9FF8E8E8EFF8D8D8DFF8E8E
      8EFF8E8E8EFFE2E2E2FFB1B1B1FF646464FF646464FF646464FF646464FF6464
      64FF878787FFFCFCFCFF00000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000F0F0F0FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF656565FFEFEFEFFF8C8C8CFF646464FF646464FF646464FF646464FF6464
      64FF8B8B8BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696969FF6464
      64FF646464FF646464FF7B7B7BFFB9B9B9FFA4A4A4FF676767FF646464FF6464
      64FF646464FF7F7F7FFFB4B4B4FFA8A8A8FF898989FF646464FF646464FF6464
      64FF646464FFA3A3A3FFD0D0D0FFA9A9A9FF646464FF646464FF646464FF8686
      86FFF6F6F6FF0000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF00000000000000000000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000E2E2E2FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FFA5A5A5FF646464FF646464FF646464FF646464FF646464FF6666
      66FFE4E4E4FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CFCFCFFFCDCD
      CDFFCDCDCDFFCDCDCDFFD4D4D4FFC1C1C1FFA4A4A4FF676767FF646464FF6464
      64FF646464FF7F7F7FFFB4B4B4FFA8A8A8FF8A8A8AFF646464FF646464FF6464
      64FF646464FFA1A1A1FFADADADFF00000000A9A9A9FF646464FF868686FFF6F6
      F6FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000787878FF6464
      64FF646464FF787878FF00000000000000000000000000000000787878FF6464
      64FF646464FF787878FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000F6F6F6FFD6D6D6FFD0D0D0FFCACACAFFC4C4C4FF808080FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FFA6A6
      A6FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0F0F0FF7F7F
      7FFF686868FF686868FF686868FF8F8F8FFFCFCFCFFF939393FF919191FF9191
      91FF919191FFA5A5A5FFB6B6B6FFA8A8A8FF8A8A8AFF646464FF646464FF6464
      64FF646464FFA1A1A1FFADADADFF0000000000000000BDBDBDFFF6F6F6FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000787878FF6464
      64FF646464FF787878FF00000000000000000000000000000000787878FF6464
      64FF646464FF787878FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FFEBEBEBFF0000
      000000000000EBEBEBFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000909090FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF707070FFF4F4
      F4FF00000000B2B2B2FFD2D2D2FF000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFB3B3B3FF9C9C9CFF9D9D9DFF9D9D9DFFAAAAAAFFCECECEFFA0A0A0FF9F9F
      9FFF9F9F9FFFA1A1A1FFB7B7B7FFB2B2B2FF8A8A8AFF646464FF646464FF6464
      64FF646464FFA2A2A2FFADADADFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF00000000000000000000000000000000C4C4C4FF7878
      78FF787878FFC4C4C4FF0000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF9F9F9FFFEBEB
      EBFFEBEBEBFF9F9F9FFF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B8B8BFF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FFC0C0C0FF0000
      0000D8D8D8FF656565FF656565FFAFAFAFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEEEEEFFABABABFF9E9E9EFF9E9E9EFF9E9E9EFFC0C0C0FFB6B6B6FF9E9E
      9EFF9E9E9EFF9E9E9EFFA1A1A1FFE4E4E4FFDCDCDCFFCECECEFFCECECEFFCECE
      CEFFCECECEFFCECECEFFB1B1B1FF000000000000000000000000FDFDFDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B8B8BFF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF828282FFFDFDFDFFF7F7
      F7FF777777FF646464FF646464FF989898FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EDEDEDFF8B8B8BFF7D7D7DFF7D7D7DFF7E7E7EFFA9A9A9FFA0A0
      A0FF7E7E7EFF7D7D7DFF7D7D7DFF818181FFC4C4C4FF858585FF7D7D7DFF7D7D
      7DFF7D7D7DFF9A9A9AFFF4F4F4FF0000000000000000DCDCDCFF7B7B7BFFE7E7
      E7FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000919191FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FFDADADAFF00000000A0A0
      A0FF646464FF646464FF656565FFE4E4E4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DCDCDCFF6C6C6CFF646464FF7373
      73FFE7E7E7FF0000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A5FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF7E7E7EFFA9A9A9FF6464
      64FF646464FF646464FF979797FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EEEE
      EEFF000000000000000000000000DCDCDCFF6C6C6CFF646464FF646464FF6464
      64FF737373FFE7E7E7FF00000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      0000646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFBFFC4C4C4FF7575
      75FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF656565FFE3E3E3FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6FF6969
      69FFCDCDCDFF00000000000000008B8B8BFF646464FF646464FF646464FF6464
      64FF646464FF9B9B9BFF0000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000E9E9E9FF9B9B9BFF7B7B7BFF8A8A8AFFC4C4
      C4FFA5A5A5FF656565FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF969696FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C6FF666666FF6464
      64FF676767FFCDCDCDFF00000000F4F4F4FF838383FF646464FF646464FF6464
      64FF8E8E8EFFFAFAFAFF0000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF0000000000000000000000000000
      00000000000000000000E8E8E8FF6E6E6EFF646464FF646464FF646464FF6464
      64FFB9B9B9FFC7C7C7FF8C8C8CFF939393FF9B9B9BFFA2A2A2FFA9A9A9FFB1B1
      B1FFB8B8B8FFEAEAEAFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6FF666666FF646464FF6464
      64FF646464FF676767FFCECECEFF00000000F4F4F4FF838383FF646464FF8E8E
      8EFFFAFAFAFF000000000000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF0000000000000000000000000000
      00000000000000000000969696FF646464FF646464FF646464FF646464FF6464
      64FF696969FFF3F3F3FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A1FF646464FF646464FF6464
      64FF646464FF646464FFAAAAAAFF0000000000000000F4F4F4FFA7A7A7FFF9F9
      F9FF00000000000000000000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF0000000000000000000000000000
      000000000000000000006D6D6DFF646464FF646464FF646464FF646464FF6464
      64FF646464FFCECECEFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFA0A0A0FF646464FF6464
      64FF646464FFA8A8A8FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF6F6F6FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF6F6F6FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006A6A6AFF646464FF646464FF646464FF646464FF6464
      64FF646464FFCCCCCCFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFEFFA0A0A0FF6464
      64FFA8A8A8FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000929292FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF929292FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000929292FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF929292FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F8F8FFF646464FF646464FF646464FF646464FF6464
      64FF666666FFEEEEEEFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFEFFC9C9
      C9FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF828282FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF828282FFDEDEDEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF828282FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF828282FFDEDEDEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DFDFDFFF686868FF646464FF646464FF646464FF6464
      64FFAAAAAAFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFDEDEDEFF929292FF6F6F
      6FFF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF6F6F6FFF929292FFDEDEDEFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFDEDEDEFF929292FF6F6F
      6FFF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF6F6F6FFF929292FFDEDEDEFFFDFDFDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DCDCDCFF888888FF696969FF777777FFB8B8
      B8FFFEFEFEFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFEFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
      FBFFFCFCFCFFFDFDFDFFFDFDFDFFFDFDFDFFFEFEFEFFFEFEFEFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFEFFFCFCFCFFFAFAFAFFF9F9F9FFFAFA
      FAFFFAFAFAFFFCFCFCFFFDFDFDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFEFF9F9F9FFF646464FF646464FF646464FF646464FF676767FF6B6B
      6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B
      6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6565
      65FF646464FF676767FF949494FFF3F3F3FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFEFFEBEBEBFFDCDC
      DCFFD2D2D2FFC9C9C9FFC5C5C5FFC0C0C0FFBBBBBBFFBBBBBBFFBBBBBBFFB5B5
      B5FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB2B2
      B2FFB6B6B6FFBBBBBBFFBBBBBBFFBBBBBBFFC1C1C1FFC5C5C5FFCBCBCBFFD3D3
      D3FFDEDEDEFFF1F1F1FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FBFFF1F1F1FFE5E5E5FFD8D8D8FFCCCCCCFFC1C1C1FFBCBCBCFFBABABAFFBCBC
      BCFFC3C3C3FFCCCCCCFFD6D6D6FFE1E1E1FFEBEBEBFFF3F3F3FFFAFAFAFFFEFE
      FEFF00000000000000000000000000000000000000000000000000000000FEFE
      FEFFA0A0A0FF646464FF646464FF646464FF646464FF646464FFAAAAAAFF0000
      000000000000F3F3F3FFF1F1F1FFFAFAFAFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF969696FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFDFFE4E4E4FFD3D3
      D3FFC8C8C8FFBABABFFF1B1B86FF9191ABFFB3B3B3FFB2B2B2FFB2B2B2FFB2B2
      B2FFB1B1B1FFACACACFFACACACFFACACACFFACACACFFACACACFFADADADFFB2B2
      B2FFB2B2B2FFB2B2B2FFB2B2B2FFB5B5B5FF7A7AA4FF28288AFFCBCBC7FFCACA
      CAFFD5D5D5FFEBEBEBFF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F7FFE5E5E5FFCBCB
      CBFFA7A7A7FF787878FF4C4C4CFF323232FF2E2E2EFF393939FF484848FF5555
      55FF646464FF787878FF8F8F8FFFA6A6A6FFBCBCBCFFCFCFCFFFE1E1E1FFEDED
      EDFFF7F7F7FFFDFDFDFF00000000000000000000000000000000FEFEFEFFA0A0
      A0FF646464FF646464FF646464FF646464FF646464FF646464FFAAAAAAFF0000
      0000C0C0C0FF646464FF646464FF787878FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF6A6A6AFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFEFEFFFCACACAFFD2D2D2FFEAEAEAFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080880FF0B0B81FF0B0B81FF0B0B81FF0A0A81FFFAFAFBFFFBFBFBFFFBFB
      FBFFFAFAFAFFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFFBFB
      FBFFFBFBFBFFFBFBFBFFFAFAFBFF0B0B81FF0B0B81FF0B0B81FF0B0B81FF2323
      8FFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFEFFF2F2F2FFD9D9D9FFB5B5B5FF2371
      38FF22823FFF258E47FF27984DFF28A152FF29AA57FF2AB15AFF2AB55AFF2AB9
      5AFF268947FF3E3E3EFF515151FF6C6C6CFF8B8B8BFFA9A9A9FFC3C3C3FFD8D8
      D8FFE9E9E9FFF5F5F5FFFCFCFCFF0000000000000000FEFEFEFFA1A1A1FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FFAAAAAAFF0000
      0000ADADADFF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFBFFB8B8B8FF6C6C6CFF9D9D9DFFB1B1B1FF6A6A6AFFB5B5B5FFFCFC
      FCFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000A0A
      81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B
      81FF292991FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F8FFE9E9E9FF207537FF248442FF2691
      4BFF289C50FF2AA556FF2BAD5BFF2DB55FFF2DBC62FF2DC164FF2EC466FF2EC5
      65FF2DC464FF2CC05FFF29BB5AFF575757FF727272FF939393FFB1B1B1FFCBCB
      CBFFE0E0E0FFEEEEEEFFF9F9F9FFFEFEFEFFFEFEFEFFA3A3A3FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FFAAAAAAFF0000
      0000ADADADFF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D4D4
      D4FF7C7C7CFF646464FF646464FF9D9D9DFFB1B1B1FF646464FF646464FF7E7E
      7EFFDBDBDBFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B0B81FF0B0B
      81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B
      81FF0B0B81FF2A2A91FF00000000000000000000000000000000000000000000
      00000000000000000000000000002B733DFF227E3FFF258E48FF289C50FF2AA7
      57FF2BB05DFF2EB862FF2FBD65FF30C368FF30C76AFF30CA6BFF30CD6CFF2FCD
      6BFF2FCD69FF2ECA67FF2CC463FF29B85BFF558D66FF989898FFB5B5B5FFCDCD
      CDFFE1E1E1FFEFEFEFFFF9F9F9FFFEFEFEFFA3A3A3FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FFAAAAAAFF0000
      0000ADADADFF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      00000000000000000000000000000000000000000000EAEAEAFF949494FF6464
      64FF646464FF646464FF646464FF9D9D9DFFB1B1B1FF646464FF646464FF6464
      64FF656565FFA0A0A0FFF3F3F3FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BEBEDDFF0B0B81FF0B0B
      81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B80FF0B0B82FF0A0A
      81FF000000000000000000000000000000000000000000000000000000000000
      00000A0A83FF0A0A81FF0B0B82FF0B0B81FF0B0B81FF0B0B81FF0B0B81FF0B0B
      81FF0B0B81FF0B0B81FF00000000000000000000000000000000000000000000
      000000000000000000001F7236FF238542FF26934BFF28A254FF2BAD5BFF2DB5
      60FF2EB963FF2FBB66FF30BF69FF31C46CFF31C86EFF32CC70FF31CE6FFF32D0
      6FFF31D06EFF2FCE6BFF2EC967FF2DC061FF29B459FF2B9E50FFCACACAFFDDDD
      DDFFEBEBEBFFF5F5F5FFFCFCFCFF00000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FFAAAAAAFF0000
      0000ADADADFF646464FF646464FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      0000000000000000000000000000F8F8F8FFAEAEAEFF696969FF646464FF6464
      64FF646464FF646464FF646464FF9D9D9DFFB2B2B2FF646464FF646464FF6464
      64FF646464FF646464FF707070FFC1C1C1FFFEFEFEFF00000000000000000000
      00000000000000000000000000000000000000000000141488FF0B0B81FF0B0B
      81FF0B0B81FF0B0B81FF0B0B80FF0B0B82FF0C0C83FF0C0C84FF0C0C83FF0C0C
      85FF0C0C84FF0000000000000000000000000000000000000000000000000B0B
      86FF0C0C84FF0C0C85FF0C0C84FF0C0C82FF0A0A81FF0B0B82FF0B0B81FF0B0B
      81FF0B0B81FF0B0B81FF5858A8FF000000000000000000000000000000000000
      0000000000001F7235FF248743FF26984CFF2AA756FF2CB15DFF2DB560FF2FB6
      63FF2FB865FF31BA69FF31BE6CFF33C46FFF33C872FF33CC73FF33CF73FF33D0
      72FF32D170FF30CF6DFF2FCC6AFF2DC665FF2CBB5EFF28A953FF299348FFF0F0
      F0FFF8F8F8FFFDFDFDFF0000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FFA7A7A7FF0000
      0000C8C8C8FF666666FF646464FF828282FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7FFF646464FF646464FF646464FF666666FF0000000000000000000000000000
      00000000000000000000FEFEFEFF757575FF939393FFE4E4E4FF959595FF6464
      64FF646464FF646464FF646464FF9D9D9DFFB2B2B2FF646464FF646464FF6464
      64FF646464FF787878FFC7C7C7FF828282FF838383FFFDFDFDFF000000000000
      0000000000000000000000000000000000000000000043439CFF0B0B81FF0B0B
      81FF0B0B80FF0A0A81FF0C0C82FF0C0C83FF0C0C84FF0B0B85FF0D0D87FF0D0D
      86FF0D0D88FF0D0D87FF000000000000000000000000000000000D0D87FF0D0D
      88FF0D0D88FF0D0D86FF0D0D87FF0B0B86FF0C0C85FF0C0C84FF0C0C83FF0B0B
      82FF0B0B81FF0B0B81FFCCCCE5FF000000000000000000000000000000000000
      00001F7134FF228541FF279A4DFF29AA56FF2CB15CFF2CB15EFF2DB161FF2EB1
      62FF2EB263FF2EB463FF38C079FF42DDA1FF42DDA1FF30C66BFF32CC70FF32CE
      71FF32CF71FF31CD6EFF30CB6BFF2FC867FF2CBF61FF29B058FF269B4CFF7DB5
      8EFF00000000000000000000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF797979FFF5F5
      F5FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0E0E0FF6666
      66FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      0000000000000000000000000000D2D2D2FFC0C0C0FF767676FFD3D3D3FFA5A5
      A5FF646464FF646464FF646464FF9D9D9DFFB2B2B2FF646464FF646464FF6464
      64FF888888FFC3C3C3FF737373FFBCBCBCFFBDBDBDFFFEFEFEFF000000000000
      00000000000000000000000000000000000000000000000000009393F0FF0B0B
      82FF0C0C82FF0C0C85FF0B0B86FF0D0D87FF0D0D88FF0D0D87FF0C0C88FF0E0E
      8AFF0E0E89FF0E0E8BFF0E0E8BFF00000000000000000E0E8AFF0E0E8BFF0E0E
      8BFF0E0E8AFF0E0E8AFF0D0D89FF0D0D88FF0D0D86FF0D0D85FF0C0C84FF0C0C
      84FF0A0A83FFAEAEFFFF0000000000000000000000000000000000000000AAC6
      B1FF21813EFF25994BFF29AA56FF2BB15BFF2AAC59FF27A550FF25A24DFF26A6
      4EFF26A950FF26AD52FFFEFFFEFFFFFFFFFFFFFFFFFF5BDA8EFF29C15CFF2AC3
      5DFF2AC45DFF2BC55EFF2CC663FF2EC565FF2DC263FF2AB65CFF27A451FF238C
      43FF00000000000000000000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF7070
      70FF8C8C8CFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8A8A8AFF686868FF6464
      64FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      00000000000000000000E8E8E8FF8A8A8AFF646464FF646464FF676767FFC0C0
      C0FFB7B7B7FF656565FF646464FF9D9D9DFFB2B2B2FF646464FF646464FF9D9D
      9DFFB7B7B7FF666666FF646464FF646464FF868686FFE4E4E4FF000000000000
      0000000000000000000000000000000000000000000000000000000000009393
      EFFF0C0C84FF0D0D87FF0D0D88FF0D0D89FF0E0E8AFF0E0E8BFF0E0E8CFF0E0E
      8BFF0D0D8DFF0F0F8CFF0F0F8CFF0F0F8EFF0F0F8EFF0F0F8EFF0F0F8CFF0F0F
      8CFF0D0D8DFF0E0E8CFF0E0E8AFF0E0E89FF0C0C88FF0D0D87FF0D0D86FF0B0B
      85FFADADFFFF0000000000000000000000000000000000000000000000002076
      37FF249448FF28A853FF28AC54FF25A34CFF25A24CFF26A54FFF44DD9AFF45D8
      A2FF27B254FF28B555FFFFFFFFFFFFFFFFFFFFFFFFFF60DB90FF29BF5BFF28BF
      59FF43DD9FFF43DEA1FF28BC58FF28BB59FF28B857FF2AB85BFF29AB55FF2596
      49FF217E3BFF000000000000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      0000FCFCFCFFB5B5B5FF696969FF646464FF646464FF646464FF646464FF6464
      64FFA9A9A9FFC7C7C7FF686868FF9D9D9DFFB2B2B2FF656565FFB3B3B3FFA6A6
      A6FF646464FF646464FF646464FF646464FF646464FF676767FFAEAEAEFFFAFA
      FAFF000000000000000000000000000000000000000000000000000000000000
      00009494F0FF0D0D89FF0E0E89FF0E0E8AFF0E0E8BFF0F0F8CFF0F0F8EFF0F0F
      8FFF0F0F8EFF0E0E90FF0E0E90FF0E0E8FFF0E0E8FFF0E0E90FF0E0E90FF0F0F
      8EFF0F0F8FFF0F0F8DFF0F0F8EFF0D0D8DFF0E0E8CFF0E0E8BFF0E0E8AFFADAD
      FFFF00000000000000000000000000000000000000000000000079A683FF238B
      43FF26A04CFF25A74FFF25A44DFF25A54EFF25A94EFFFFFFFFFFFFFFFFFFFFFF
      FFFF40D888FF29BF5BFFFFFFFFFFFFFFFFFFFFFFFFFF60DB90FF29C05BFFD2F4
      DCFFFFFFFFFFFFFFFFFFA7ECBFFF28B455FF28B455FF27B254FF26AB51FF259D
      4CFF22863FFF000000000000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF000000000000000000000000E0E0
      E0FF818181FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF949494FFD1D1D1FFA6A6A6FFB8B8B8FFC6C6C6FF949494FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF7A7A
      7AFFD6D6D6FF0000000000000000000000000000000000000000000000000000
      0000000000009494F0FF0E0E8BFF0F0F8CFF0F0F8DFF0F0F8EFF10108FFF1010
      91FF101092FF101091FF101093FF101093FF101093FF101093FF101091FF1010
      92FF101090FF101091FF0E0E90FF0F0F8FFF0F0F8EFF0F0F8DFFADADFFFF0000
      0000000000000000000000000000000000000000000000000000207B39FF2393
      45FF25A44DFF25A74EFF26A74FFF27AD52FF27B557FFFFFFFFFFFFFFFFFFFFFF
      FFFFF5FDF7FF2ACB60FFFFFFFFFFFFFFFFFFFFFFFFFF60DC90FF2AC35CFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF26AC50FF27AE52FF27AF52FF27AD51FF249C
      49FF228941FF227036FF0000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF00000000F9F9F9FFABABABFF6666
      66FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF838383FFF0F0F0FFF3F3F3FF858585FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF9D9D9DFFF3F3F3FF000000000000000000000000000000000000
      000000000000000000009494F0FF0F0F90FF101091FF101092FF101093FF0F0F
      92FF111194FF111195FF111195FF111195FF111194FF111195FF111195FF1111
      93FF111194FF0F0F92FF101091FF101090FF10108FFFADADFFFF000000000000
      000000000000000000000000000000000000000000000000000020843DFF249B
      49FF26A74FFF26A84FFF27AF52FF27B757FF29BF5BFFFFFFFFFFFFFFFFFFFFFF
      FFFF3ED474FF32D371FFFFFFFFFFFFFFFFFFFFFFFFFF60DC90FF2ACA61FFE4F9
      EBFFFFFFFFFFFFFFFFFFBDF1CFFF26AA50FF25A64FFF26AB51FF27AC51FF25A2
      4CFF21893FFF1E7033FF0000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FFFCFCFCFF848484FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF717171FFC8C8C8FF0000000000000000C6C6C6FF707070FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF818181FFFCFCFCFF0000000000000000000000000000
      00000000000000000000000000009393F0FF101093FF111194FF111195FF1111
      96FF101097FF121297FF121296FF121298FF121298FF121298FF121296FF1010
      97FF111195FF111194FF111195FF111194FFADADFFFF00000000000000000000
      00000000000000000000000000000000000000000000B4D1BCFF228D42FF25A3
      4DFF26A850FF27AE52FF28B757FF29C15CFF2BCA60FF2FD06AFF3BD373FF2CD1
      71FF3CD885FF3DD888FFC0F0D0FFFFFFFFFFFFFFFFFF30D16DFF2FD069FF2BCD
      61FF2ACA61FF26C55CFF28B555FF26AC51FF26A44DFF26A64EFF26AB50FF25A5
      4DFF228E41FF1E7334FF0000000000000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF00000000E8E8E8FF7A7A7AFF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF9C9C9CFFF3F3F3FF00000000000000000000000000000000F3F3F3FF9E9E
      9EFF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF818181FFEEEEEEFF000000000000000000000000000000000000
      0000000000000000000000000000000000009393F1FF111195FF121296FF1212
      97FF121299FF121298FF12129AFF11119AFF11119AFF11119AFF12129AFF1212
      98FF121299FF121298FF101097FFADADFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000037894DFF239546FF26A7
      4EFF26AD51FF27B556FF2AC05AFF2DCC66FF45DB91FF4EDF9CFF56E1A7FF5DE4
      B0FF61E5B4FF48DFA0FF48DFA0FF46DE9BFF43DC93FF3DD987FF35D57AFF47DC
      92FF3FD889FF3CD085FF3BCA82FF3AC37EFF25A54DFF24A24BFF26A84FFF26A7
      4EFF229143FF1F7737FFF1F5F2FF00000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF0000000000000000F3F3F3FF8989
      89FF646464FF646464FF646464FF646464FF646464FF646464FF777777FFD3D3
      D3FF000000000000000000000000000000000000000000000000000000000000
      0000D7D7D7FF7B7B7BFF646464FF646464FF646464FF646464FF646464FF6464
      64FF8F8F8FFFF7F7F7FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008888E9FF12129AFF1313
      9BFF13139AFF13139CFF13139BFF13139DFF13139DFF13139DFF13139BFF1313
      9CFF13139BFF11119AFFAFAFFFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021863EFF249B48FF26A9
      50FF27B254FF29BC59FF2AC85EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF55DFA1FF54E5B9FF51E3B3FF4CE0A9FF46DE9CFFCFF4DBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0EBBCFF25A14CFF25A54EFF26A8
      4FFF239345FF207A38FFB6CEBCFF00000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF000000000000000000000000FBFB
      FBFF9C9C9CFF646464FF646464FF646464FF656565FFA7A7A7FFF8F8F8FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFAFFAEAEAEFF676767FF646464FF646464FF646464FFA1A1
      A1FFFCFCFCFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013139BFF13139CFF1313
      9DFF13139EFF13139DFF13139FFF13139FFF13139FFF13139FFF13139FFF1313
      9DFF13139CFF13139BFF13139AFF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000228D42FF249F4BFF26AC
      51FF28B656FF29C25CFF2BCE63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF50DD98FF5FEDD2FF5CEBCDFF58E7C1FF50E3B1FFF4FCF6FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0F6DEFF25A34CFF25A44DFF26A9
      4FFF239545FF1F7A38FFA5C3ABFF00000000646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      000000000000B3B3B3FF656565FF7E7E7EFFDDDDDDFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E4E4E4FF868686FF656565FFB7B7B7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000013139CFF13139DFF13139DFF1313
      9EFF1313A0FF1212A1FF1414A0FF1414A2FF1414A2FF1414A0FF1212A1FF1313
      9FFF1313A0FF13139FFF13139EFF13139BFF0000000000000000000000000000
      00000000000000000000000000000000000000000000228C41FF25A24CFF27AE
      52FF29BA58FF2AC75EFF2FD16BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5CE4B1FF7EF2E1FF6FF0DEFF60EDD5FF59E8C4FFCBF2D7FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99E8B5FF25A54EFF25A44DFF26A9
      4FFF239545FF1F7937FFCADDCFFF00000000646464FF646464FF646464FF6464
      64FF646464FF9C9C9CFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAA
      AAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAA
      AAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFFAAAAAAFF9B9B9BFF6464
      64FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      00000000000000000000DCDCDCFFFBFBFBFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFE1E1E1FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000013139BFF13139EFF13139FFF13139FFF1414
      A0FF1414A1FF1414A2FF1414A4FF1313A4FF1313A4FF1414A4FF1414A2FF1414
      A3FF1414A2FF1212A1FF1313A0FF13139DFF13139DFF00000000000000000000
      000000000000000000000000000000000000000000005CAC73FF25A34DFF27B1
      54FF29BE5AFF2ACB60FF33D271FF3CD989FF48DEA0FF53E6B8FF5DEBCEFF6FF0
      DFFF92F5E7FFBBF8EFFFC7F9F1FFAAF7EDFF7DF2E3FF5FEBD1FF55E5BBFF4BE0
      A6FF3FDA8EFF35D476FF2BCE61FF29BF5BFF27B354FF26A74FFF25A44DFF26A8
      4FFF239344FF1F7536FF0000000000000000646464FF646464FF646464FF6464
      64FF808080FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007D7D
      7DFF646464FF646464FF646464FF666666FF0000000000000000000000000000
      000000000000FAFAFAFFAAAAAAFFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1E1E1FFACACACFFFBFBFBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000013139BFF13139EFF1313A0FF1212A0FF1414A3FF1414
      A4FF1515A5FF1515A6FF1515A5FF1515A7FF1515A7FF1515A5FF1515A6FF1515
      A4FF1313A3FF1414A2FF1414A2FF13139FFF13139FFF13139CFF000000000000
      00000000000000000000000000000000000000000000ECF4EFFF25A34DFF27B2
      54FF29BF5AFF2BCD61FF35D476FF3FDA8CFF49DFA3FF57E7BDFF7CE3A9FFA9F1
      D6FFC1F8F0FFFAFEFEFFC0F1D1FFFFFFFFFFFFFFFFFF63DF9EFF58E7C2FF4AE2
      A8FF60E2A9FF54E2A8FF2BCF62FF29C15BFF28B455FF26A94FFF25A64EFF26A6
      4EFF228F43FF1E7133FF0000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      0000F3F3F3FF888888FF646464FF666666FFA8A8A8FFF8F8F8FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FAFAFAFFACACACFF666666FF646464FF888888FFF3F3
      F3FF000000000000000000000000000000000000000000000000000000000000
      00000000000013139CFF13139EFF1313A0FF1414A0FF1414A3FF1313A3FF1515
      A6FF1515A7FF1414A8FF1616A7FF1616A9FF1616A9FF1616A9FF1616A7FF1414
      A8FF1515A7FF1515A4FF1414A4FF1414A1FF1313A1FF13139FFF13139CFF0000
      000000000000000000000000000000000000000000000000000024A14CFF27B2
      54FF29C05BFF2BCD61FF35D475FF3FDA8DFF49E0A4FFFFFFFFFFFFFFFFFFFFFF
      FFFF73DF9BFFFFFFFFFFFEFFFEFFFFFFFFFFFFFFFFFF6DDF99FF58E7C3FFCFF4
      DAFFFFFFFFFFFFFFFFFFA6EBBEFF29C25CFF28B455FF26A950FF26A84FFF25A3
      4CFF228A40FF1E6E32FF0000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF000000000000000000000000E9E9
      E9FF7A7A7AFF646464FF646464FF646464FF646464FF767676FFD0D0D0FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D8D8D8FF7A7A7AFF646464FF646464FF646464FF646464FF7979
      79FFE7E7E7FF0000000000000000000000000000000000000000000000000000
      000013139AFF13139EFF13139EFF1414A0FF1414A2FF1515A5FF1515A7FF1616
      A8FF1616A8FF1616A9FF1515ABFF1515AAFF1717ACFF1515AAFF1616ABFF1616
      AAFF1616A9FF1515A6FF1515A6FF1313A3FF1414A1FF13139FFF13139DFF1313
      9DFF00000000000000000000000000000000000000000000000026A54DFF27B0
      53FF29BE5AFF2BCC61FF33D374FF3ED98AFF4ADFA3FFFFFFFFFFFFFFFFFFFFFF
      FFFFF1FCF5FFF1FDFBFFFEFFFEFFFFFFFFFFFFFFFFFF6DDF99FF56E6BEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF2AC05BFF27B455FF26A950FF26A950FF249D
      49FF20813CFF7AA686FF0000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000DBDBDBFF7070
      70FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF9797
      97FFF0F0F0FF000000000000000000000000000000000000000000000000F6F6
      F6FFA2A2A2FF656565FF646464FF646464FF646464FF646464FF646464FF6464
      64FF6E6E6EFFD7D7D7FF00000000000000000000000000000000000000001111
      99FF13139DFF13139FFF1212A1FF1414A3FF1515A5FF1515A7FF1616A7FF1616
      AAFF1515AAFF1717ADFF1717ACFFACACFFFF9494F3FF1717AEFF1717ADFF1717
      ACFF1616ABFF1616A8FF1414A8FF1515A6FF1414A4FF1414A2FF1313A0FF1313
      9EFF13139CFF0000000000000000000000000000000000000000F4FAF7FF26AC
      51FF28BB59FF2AC960FF31D16FFF3BD784FF46DD9AFFFFFFFFFFFFFFFFFFFFFF
      FFFF53DB90FF9FF4E7FFFFFFFFFFFFFFFFFFFFFFFFFF6CDE98FF52E5B5FFE4F9
      EAFFFFFFFFFFFFFFFFFFBFF1D0FF29BE5AFF27B254FF26AA50FF25A64EFF2394
      45FF1F7737FF000000000000000000000000646464FF646464FF646464FF6464
      64FF797979FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFF7878
      78FF646464FF646464FF646464FF666666FF00000000CBCBCBFF696969FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF6D6D6DFFC0C0C0FFFEFEFEFF000000000000000000000000CECECEFF7474
      74FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF676767FFC3C3C3FF000000000000000000000000121298FF1313
      9AFF13139EFF1313A0FF1414A1FF1313A3FF1515A5FF1616A7FF1616A9FF1717
      ACFF1717ACFF1616AFFFACACFFFF00000000000000009494F3FF1818AEFF1717
      ADFF1717ADFF1515AAFF1616A8FF1414A8FF1515A4FF1414A2FF1212A0FF1313
      9FFF13139DFF111199FF000000000000000000000000000000000000000027AC
      51FF28B757FF2AC65DFF2DCF67FF37D67CFF40DB8FFF4BE0A5FF45D887FF43E0
      A3FF60EDD4FF66EEDAFFFFFFFFFFFFFFFFFFFFFFFFFF6ADE97FF4CE1A9FF43DB
      95FF32D271FF2ACE65FF2BC85FFF28BB58FF27B053FF26AA50FF25A04BFF2289
      40FF4D8E5EFF000000000000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FFFEFEFEFFA5A5A5FF656565FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FF898989FFF1F1F1FFF5F5F5FF979797FF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF656565FFA6A6A6FFFDFDFDFF000000006565BCFF11119AFF1313
      9BFF13139FFF1212A1FF1414A2FF1515A4FF1414A8FF1616AAFF1717ACFF1717
      AEFF1818AEFFACACFFFF000000000000000000000000000000009494F4FF1818
      AFFF1616AFFF1717ADFF1616ABFF1616A9FF1515A7FF1313A3FF1414A1FF1313
      A0FF13139EFF13139AFFE4E4F3FF000000000000000000000000000000000000
      000027B154FF29BF5AFF2BCC61FF32D270FF3AD783FF43DC95FF4BE0A5FF51E4
      B3FF55E7BDFF58E9C4FFFDFEFCFFFFFFFFFFFFFFFFFF60DC91FF45DC99FF3CD9
      87FF34D374FF2BCE62FF29C25CFF28B656FF26AD52FF25A64EFF239546FF207D
      39FF00000000000000000000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000DCDCDCFF7F7F
      7FFF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF646464FF646464FFB0B0B0FF00000000FEFEFEFFABABABFF646464FF6464
      64FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF6464
      64FF7D7D7DFFDCDCDCFF00000000000000000000000017179CFF13139BFF1313
      9CFF13139EFF1414A2FF1313A3FF1515A7FF1616A9FF1515ABFF1717ACFF1818
      AEFFACACFFFF0000000000000000000000000000000000000000000000009595
      F4FF1818AFFF1616ADFF1717ABFF1616AAFF1414A8FF1515A4FF1414A2FF1212
      A1FF13139DFF13139CFF5757B6FF000000000000000000000000000000000000
      0000ACDDBDFF28B757FF2AC55CFF2CCF63FF34D374FF3BD884FF41DB92FF47DF
      9EFF4BE0A7FF4EE2ACFF4FE2AEFF39D98DFF37D888FF43DC95FF3DD987FF36D4
      78FF2DCF66FF2AC75EFF29BC59FF27B154FF26A950FF259C49FF22873EFF0000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF000000000000000000000000FCFC
      FCFFB5B5B5FF696969FF646464FF646464FF646464FF646464FF646464FF6464
      64FF676767FFC5C5C5FF00000000000000000000000000000000C1C1C1FF6767
      67FF646464FF646464FF646464FF646464FF646464FF646464FF676767FFB0B0
      B0FFFBFBFBFF00000000000000000000000000000000B1B1DEFF0D0D97FF1313
      9EFF1313A0FF1414A3FF1515A5FF1414A6FF1616AAFF1717ACFF1616ADFFACAC
      FFFF000000000000000000000000000000000000000000000000000000000000
      00009494F4FF1818B0FF1717ACFF1515ABFF1616A7FF1515A5FF1414A4FF1414
      A0FF13139FFF11119BFF00000000000000000000000000000000000000000000
      00000000000063C682FF28BB58FF2AC75EFF2CCF64FF33D372FF38D67EFF3ED8
      89FF40DA90FF42DC94FF43DC94FF41DB91FF3ED98AFF3AD681FF34D476FF2DCF
      67FF2AC85FFF29BF5AFF28B555FF26AC51FF24A04BFF238D42FFF3F8F5FF0000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF797979FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
      CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFF7878
      78FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      000000000000E8E8E8FF8C8C8CFF646464FF646464FF646464FF646464FF6E6E
      6EFFD7D7D7FF000000000000000000000000000000000000000000000000D6D6
      D6FF6E6E6EFF646464FF646464FF646464FF646464FF858585FFE4E4E4FF0000
      00000000000000000000000000000000000000000000000000000D0D97FF0E0E
      9BFF1313A1FF1414A3FF1515A4FF1414A8FF1616A9FF1717ADFFACACFFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009494F2FF1717AEFF1717ACFF1616A9FF1515A7FF1313A3FF1414
      A2FF0F0F9CFF13139CFF00000000000000000000000000000000000000000000
      0000000000000000000098DAADFF28BB58FF2AC55DFF2BCD62FF2FD06BFF34D3
      73FF37D47AFF37D57DFF38D67EFF36D57BFF34D375FF30D16DFF2BCE63FF2AC7
      5EFF29BF5AFF28B656FF27AC51FF25A24CFF229143FF00000000000000000000
      000000000000000000000000000000000000646464FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF666666FF0000000000000000000000000000
      0000000000000000000000000000C5C5C5FF707070FF646464FF777777FFE5E5
      E5FF000000000000000000000000000000000000000000000000000000000000
      0000E6E6E6FF787878FF646464FF6B6B6BFFBBBBBBFFFDFDFDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000D0D
      99FF0E0E9EFF1414A2FF1515A6FF1616A7FF1616ABFFACACFFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009494F3FF1717ACFF1616A8FF1515A7FF1313A3FF1010
      A0FF13139FFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000028BA58FF29C15BFF2AC75EFF2BCC
      61FF2CCF64FF2DCF66FF2DD067FF2CCF65FF2BCD62FF2AC95FFF29C35CFF28BC
      59FF27B455FF26AB50FF24A04BFF249746FF0000000000000000000000000000
      000000000000000000000000000000000000686868FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF6A6A6AFF0000000000000000000000000000
      000000000000000000000000000000000000F3F3F3FFACACACFFF0F0F0FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F2F2F2FFA5A5A5FFEBEBEBFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000D0D9DFF3030B4FF1313A5FF1212A5FFA9A9FEFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8FDFF1313A7FF1313A6FF5858CDFF1414
      A1FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BEE8CDFF28BB58FF29BE
      5AFF29C25CFF29C45DFF29C45DFF29C25CFF29BF5BFF28BB59FF27B556FF26AF
      52FF25A74EFF25A24CFFFDFEFDFF000000000000000000000000000000000000
      000000000000000000000000000000000000949494FF646464FF646464FF6464
      64FF838383FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008181
      81FF646464FF646464FF646464FF979797FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C7C7EAFF0E0EA0FF9393D7FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006363C4FF0E0EA3FFF2F2FAFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000089D6A1FF28B957FF28B757FF27B455FF27B253FF27B153FF25A64DFFBBE1
      C6FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F3F3FF959595FF696969FF6464
      64FF656565FF696969FF696969FF696969FF696969FF696969FF696969FF6969
      69FF696969FF696969FF696969FF696969FF696969FF696969FF696969FF6969
      69FF696969FF696969FF696969FF696969FF696969FF696969FF696969FF6565
      65FF646464FF696969FF969696FFF4F4F4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00F9F9FD00F0F0
      FA00E5E5F600DDDDF400D9D9F200D6D6F100D6D6F100D6D6F100D6D6F100D6D6
      F100D6D6F100D6D6F100D6D6F100D6D6F100D6D6F100D6D6F100D6D6F100D6D6
      F100D6D6F100D6D6F100D6D6F100D6D6F100D6D6F100D9D9F200DEDEF400E7E7
      F700F2F2FA00FBFBFD00FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFEFFFEFEFEFFFDFDFDFFFCFCFCFFFCFCFCFFFDFDFDFFFEFEFEFFFEFE
      FEFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FCFFDFDFDFFF9E9E9EFF868686FF848484FF848484FF848484FF848484FF8484
      84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
      84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8888
      88FFAEAEAEFFE3E3E3FFFCFCFCFF000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFFCFDFDFFF9FBFCFFF7FAFBFFF5F8FAFFF5F8FAFFF5F8FAFFF8FAFBFFFAFB
      FCFFFDFDFEFFFEFEFEFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F7F7FC00E6E6F700D3D3
      F100BDBDEA00A4A4E3009999DF009797DF009696DE009696DE009696DE009696
      DE009696DE009696DE009696DE009696DE009696DE009696DE009696DE009696
      DE009696DE009696DE009696DE009696DE009797DF009999DF00A7A7E300C1C1
      EB00D7D7F200EAEAF800F9F9FD00FEFEFE000000000000000000000000000000
      0000FDFDFDFFF8F8F8FFF3F3F3FFECECECFFE6E6E6FFDFDFDFFFDADADAFFD4D4
      D4FFD1D1D1FFD0D0D0FFCCCCCCFFC8C8C8FFC8C8C8FFCCCCCCFFD0D0D0FFD1D1
      D1FFD5D5D5FFDADADAFFDFDFDFFFE6E6E6FFECECECFFF3F3F3FFF8F8F8FFFDFD
      FDFF00000000000000000000000000000000000000000000000000000000F8F8
      F8FFA8A8A8FFC4C4C4FFCACACAFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCB
      CBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCB
      CBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCCCCCCFFC1C1
      C1FF8C8C8CFFCECECEFFF8F8F8FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFDFDFFF7FAFBFFEEF5
      F7FFE5F0F4FFDEECF1FFD9E9EFFFD5E7EDFFD5E7EDFFD6E8EDFFDAEAEFFFE0ED
      F1FFE8F1F5FFF1F6F9FFF9FBFCFFFDFDFEFF0000000000000000000000000000
      000000000000000000000000000000000000FAFAFD00E7E7F700CCCCEE008484
      DC004545D1003A3ACE003434CC003434CD003333CD003333CE003333CE003333
      CE003333CF003333CF003333CF003333CF003333CE003333CE003333CE003333
      CD003333CD003333CC003333CC003333CB003434CA003434C9003A3ACB004B4B
      CF009595DE00D3D3F100ECECF900FCFCFE0000000000FAFAFAFFEFEFEFFFE3E3
      E3FFDDDDDDFFD1D1D1FFC7C7C7FFC0C0C0FFBABABAFFB6B6B6FFB3B3B3FFB0B0
      B0FFAFAFAFFFAEAEAEFFADADADFFACACACFFACACACFFADADADFFAEAEAEFFAFAF
      AFFFB0B0B0FFB3B3B3FFB6B6B6FFBABABAFFC0C0C0FFC8C8C8FFD2D2D2FFD8D8
      D8FFE1E1E1FFEFEFEFFFFAFAFAFF00000000000000000000000000000000F3F3
      F3FFC5C5C5FFCFCFCFFFDBDAD9FFE6E3E1FFE5E2DFFFDAD9D9FFD8D8D8FFD8D8
      D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8
      D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD9D9D9FFDDDD
      DDFFA9A9A9FFC3C3C3FFF6F6F6FF000000000000000000000000000000000000
      0000000000000000000000000000FDFDFEFFF6F9FBFFE9F2F5FFDAEAEFFFCAE1
      E8FFB3D2DEFF97BED0FF7EAAC3FF6F9CBAFF6C98B7FF719EBBFF83ADC5FF9EC3
      D3FFBAD7E1FFD0E4EBFFDEECF1FFECF4F6FFF9FBFCFFFEFEFEFF000000000000
      000000000000000000000000000000000000F2F2FA00D7D7F2007070D9003030
      CE002F2FC4001A1ABC001515BC001515BD001515BE001515BE001515BF001515
      C0001515C0001515C0001515C0001515C0001515C0001515C0001515C0001515
      C0001515C0001515BF001515BE001515BD001515BC001515BB001A1ABB002C2C
      C2002D2DC9008A8ADD00DEDEF400F5F5FB00ECECECFFD4D4D4FFC6C6C6FFB2B2
      B2FF676768FF545454FF535354FF555555FF565656FF565657FF575758FF5858
      58FF585859FF5A5A5AFF5B5B5BFF5C5C5CFF5D5D5EFF5E5E5EFF5E5E5EFF5E5E
      5EFF5E5E5EFF5E5E5FFF5D5D5DFF585858FF585858FF575758FF5D5D5EFF9B9B
      9BFFBEBEBEFFC3C3C3FFD5D5D5FFEDEDEDFF000000000000000000000000F3F3
      F3FFC9C9C9FFD1D1D1FFEFE9E2FFFEF5ECFFFDF4EBFFE8E2DDFFD3D3D3FFD3D3
      D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3
      D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD6D6
      D6FFA8A8A8FFC2C2C2FFF6F6F6FF000000000000000000000000000000000000
      00000000000000000000FBFCFDFFEEF5F7FFDCEAF0FFC4DDE6FF91B9CDFF5180
      A9FF25508EFF133B83FF143B84FF183E86FF193E86FF173C84FF123780FF153B
      81FF2C558FFF5E8AAEFF9EC3D3FFCBE1E9FFE0EDF1FFF2F7F9FFFCFDFDFF0000
      000000000000000000000000000000000000EDEDF900A1A1E4002929CE001717
      BD000000B7000000B9000000BB000000BC000000BC000000BD000000BE000000
      BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF000000
      BE000000BE000000BD000000BC000000BC000000BA000000B9000000B7000000
      B5001414BC002929CA00BBBBEA00EFEFF900D3D3D3FFC1C1C1FFC7C7C7FF5252
      53FF151517FF171719FF19191BFF1B1B1DFF1D1D1FFF1F1F21FF212123FF2323
      24FF252526FF262627FF29292AFF2B2B2CFF2D2D2EFF2E2E2FFF303031FF3030
      31FF303031FF313132FF2D2D2EFF242425FF232324FF212122FF202021FF3131
      32FFB7B7B7FFC1C1C1FFC0C0C0FFD4D4D4FF000000000000000000000000F3F3
      F3FFC9C9C9FFD2D1D1FFF7F0E8FFFEF5ECFFFEF5ECFFF1EBE4FFD3D3D3FFD3D3
      D3FFD3D3D3FFD4D4D4FFE7E7E7FFEDEDEDFFDFDFDFFFD7D7D7FFD6D6D6FFDADA
      DAFFD4D4D4FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD6D6
      D6FFA8A8A8FFC1C1C1FFF5F5F5FF000000000000000000000000000000000000
      000000000000F9FBFCFFE9F2F5FFD2E5EBFF9BC2D5FF426FA1FF113B85FF1C45
      8EFF244E94FF244E94FF204892FF1D4490FF1C428FFF1D448FFF214791FF244B
      92FF23498FFF183C85FF14397EFF5480A9FFAECFDDFFD7E7EDFFEDF4F7FFFBFC
      FDFF00000000000000000000000000000000EBEBF8005C5CD9001818C4000000
      BA000000BD000000BF000000C0000000C1000000C1000000C2000000C3000000
      C4000000C3000000C4000000C4000000C5000000C4000000C4000000C4000000
      C4000000C3000000C2000000C1000000C0000000BF000000BE000000BD000000
      BC000000B8000E0EC1007777DA00EEEEF900DEDEDEFFD3D3D3FFCDCDCDFF2D2D
      2EFF141416FF161618FF19191AFF1B1B1CFF1D1D1EFF1F1F20FF212122FF2323
      24FF252526FF262627FF282829FF2A2A2BFF2B2B2CFF2C2C2DFF2C2C2DFF2C2C
      2DFF2C2C2DFF2C2C2CFF29292AFF242425FF222223FF212122FF1E1E20FF1D1D
      1FFFADADAEFFD7D7D7FFD1D1D1FFDFDFDFFF000000000000000000000000F3F3
      F3FFC9C9C9FFD1D1D1FFF7F0E8FFFEF5ECFFFEF5ECFFF1EBE4FFD3D3D3FFD3D3
      D3FFDDDDDDFFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FFF6F6F6FFFEFE
      FEFFEEEEEEFFD5D5D5FFD3D3D3FFD3D3D3FFD3D1CEFFD4CABFFFD4C7BBFFD6CC
      C2FFA8A7A5FFB4B4B4FFEBEBEBFFFBFBFBFF0000000000000000000000000000
      0000F9FBFCFFE8F1F5FFCCE1E8FF75ADD2FF1B8DE5FF1A5BA6FF224C93FF1842
      91FF0D358AFF082F87FF062D86FF062C85FF062B84FF062B84FF062A83FF082C
      84FF0E3286FF1A408DFF224489FF176ABAFF2891E3FF8EBBD4FFD3E5EBFFEBF3
      F6FFFBFCFDFF000000000000000000000000E4E4F6003A3AD3000505C0000000
      BF000000C1000000C3000000C4000000C5000000C6000000C6000000C5000000
      C5000000C5000000C5000000C6000000C8000000C9000000C8000000C8000000
      C8000000C7000000C6000000C5000000C5000000C4000000C2000000C1000000
      C0000000BE000101BE004B4BD100E8E8F700F6F6F6FFEFEFEFFFE6E6E6FF3838
      39FF151517FF171719FF19191BFF1C1C1DFF1E1E1FFF202021FF222224FF2525
      25FF272727FF282829FF2A2A2BFF2C2C2DFF2D2D2DFF2E2E2FFF2F2F30FF2E2E
      2FFF2C2C2DFF282829FF252526FF242425FF232324FF222223FF202021FF2121
      22FFBFBFBFFFEFEFEFFFEDEDEDFFF7F7F7FF000000000000000000000000F3F3
      F3FFC9C9C9FFD1D1D1FFF7F0E8FFFEF5ECFFFEF5ECFFF1EBE4FFD3D3D3FFD1D1
      D1FFF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFF4F4F4FFD5D4D3FFD7BFA6FFDC9A59FFDB8E42FFD68638FFD386
      3BFFBD8044FF94897CFFC3C3C3FFE9E9E9FF000000000000000000000000FAFC
      FCFFE9F2F5FFCAE0E7FF60A2D3FF139AF9FF22B4FFFF1F85E4FF093289FF0731
      89FF08338BFF09338AFF09338BFF09328AFF093389FF083188FF083088FF082F
      86FF072D85FF04277FFF0B3793FF2097FAFF1EB1FFFF1690EDFF7EB1D2FFD5E6
      ECFFEFF5F8FFFDFDFEFF0000000000000000E3E3F5003333D2000101C3000000
      C4000000C5000000C7000000C8000000C9000000C9000000C8002323D1006363
      DF008B8BE7008989E7005656DD000C0CCE000000CB000000CC000000CC000000
      CC000000CB000000CA000000C9000000C9000000C8000000C6000000C5000000
      C4000000C2000000C2003E3ECF00E5E5F6000000000000000000FEFEFEFF3F3F
      41FF161617FF181819FF1A1A1BFF1D1D1EFF1F1F20FF222223FF242425FF2626
      27FF29292AFF2B2B2BFF2B2B2BFF2B2B2CFF2F2F30FF373738FF3D3D3EFF4242
      43FF454545FF444445FF3E3E3EFF333334FF262627FF1F1F20FF1E1E20FF1F1F
      20FFD0D0D0FF00000000FEFEFEFF00000000000000000000000000000000F3F3
      F3FFC9C9C9FFD1D1D1FFF7EFE8FFFEF5ECFFFEF5ECFFF0EAE4FFD3D3D3FFD4D4
      D4FFF9F9F9FFFFFFFFFFFFFFFFFFFDFDFDFFFAFAFAFFFEFEFEFFF7F7F7FFFDFD
      FDFFFFFFFFFFFCFBFAFFDEB68EFFDF8F41FFD78535FFD28030FFD17F2FFFD17F
      2FFFD17F2FFFCF8236FF9E876EFFBFBFBFFF0000000000000000FDFDFEFFEFF5
      F8FFD3E5EBFF63A4D3FF139EFCFF20AAFFFF1D95FFFF1B96FFFF105CBAFF0933
      88FF0A398FFF0A388FFF0A388EFF0A378DFF0A368DFF0A358CFF09358BFF0933
      8AFF093189FF082C82FF116AD6FF168BFFFF1B8EFFFF1EACFFFF1391F1FF88B7
      D4FFDEEBF0FFF4F8FAFFFEFEFEFF00000000E3E3F5003434D3000101C6000000
      C8000000C9000000CA000000CC000000CB000101CC00A1A1ED00F4F4FD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D5D5F7004141DB000000CD000000D0000000
      D0000000CF000000CE000000CD000000CD000000CB000000C9000000C9000000
      C7000000C6000000C5003F3FD000E5E5F6000000000000000000000000006F6F
      70FF161618FF19191AFF1B1B1DFF1E1E1FFF202021FF232324FF252526FF2727
      28FF29292AFF29292AFF2E2E2EFF333333FF323232FF39393AFF434343FF4848
      48FF4D4D4EFF535354FF59595AFF5D5D5DFF585859FF454546FF2C2C2DFF2D2D
      2EFFEBEBEBFF000000000000000000000000000000000000000000000000F3F3
      F3FFC9C9C9FFD1D1D0FFF7EFE8FFFEF5ECFFFEF5ECFFF0EAE4FFD1D1D1FFEFEF
      EFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FFD0D0D0FFCECECEFFCFCFCFFFD3D3
      D3FFF3F3F3FFF7E4CFFFE29245FFD68434FFD17F2FFFD4873CFFD4883DFFD17F
      2FFFD17F2FFFD28030FFD3873CFF958D83FF0000000000000000F7FAFBFFE1ED
      F1FF84B6D5FF139BF8FF1FAAFFFF1E96FFFF1C97FFFF1D9AFFFF1B90F5FF0D44
      9AFF0B3B8FFF0B3D92FF0B3C91FF0B3B91FF0B3A90FF0B398FFF0A398FFF0A38
      8EFF093086FF0E4FAEFF1991FFFF188DFFFF1788FFFF198BFFFF1AA9FFFF1C8F
      E9FFA9CBDCFFE9F2F5FFFAFCFCFF00000000E3E3F5003333D3000101C9000000
      CB000000CC000000CE000000CE001313D4005D5DDD009E9EDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4FD004747DF000000D1000000
      D3000000D3000000D1000000D1000000D0000000CE000000CE000000CD000000
      CB000000CA000000C7003F3FD200E5E5F600000000000000000000000000E8E8
      E8FF3F3F40FF19191BFF1C1C1DFF1E1E20FF212122FF232324FF252526FF2727
      28FF292929FF2B2A2BFF2C2C2CFF2C2C2CFF323232FF3C3C3CFF444444FF4B4B
      4BFF505050FF555555FF5A5A5BFF606060FF686869FF737374FF4A4A4BFF9999
      99FF00000000000000000000000000000000000000000000000000000000F3F3
      F3FFC9C9C9FFD0D0D0FFF6EFE7FFFEF5ECFFFEF5ECFFF0EAE3FFCFCFCFFFF1F1
      F1FFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFD6D6D6FFD3D3D3FFD3D3D3FFD1D1
      D1FFCBCAC9FFEAAD71FFDC8A3AFFD28030FFD58A41FFEECFB1FFE9C29AFFDA99
      59FFD17F2FFFD17F2FFFD98737FFAB7D4DFF00000000FDFDFEFFEEF5F7FFB7D4
      E1FF2495E8FF1BADFFFF1F9AFFFF1E9AFFFF1E9CFFFF1E9BFFFF20A2FFFF1778
      D5FF0B3C90FF0C4195FF0C4194FF0C3F94FF0C4093FF0B3E93FF0B3D92FF0B3A
      8FFF0B3C93FF1886EEFF1B95FFFF1A8FFFFF198EFFFF188AFFFF198EFFFF14A7
      FFFF3F95D9FFD1E3EAFFF3F8F9FFFEFEFEFFE3E3F5003333D5000202CC000202
      D0000202D1000000D1001515D600C4C4F500FFFFFF008A8AE0008A8AD900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4FD004747E2000000
      D4000000D6000000D6000000D4000000D4000000D3000000D2000000D0000000
      CE000000CE000000C9003E3ED300E5E5F6000000000000000000000000000000
      0000EAEAEBFF6B6B6CFF1B1B1DFF1E1E20FF212122FF232324FF252527FF2828
      29FF252525FF1E1D1DFF1F1F1FFF212121FF1F1F1FFF2C2C2CFF464646FF4C4C
      4DFF525253FF585858FF5F5F60FF656566FF616161FF4E4E4FFF9E9E9EFF0000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFC9C9C9FFD0D0D0FFF6EFE7FFFEF5ECFFFEF5ECFFEFE9E3FFCECECEFFE9E9
      E9FFFFFFFFFFFFFFFFFFFDFDFDFFDBDBDBFFD3D3D3FFD3D3D3FFD3D3D3FFD3D3
      D3FFCCC7C1FFEEA660FFDC8A3AFFD68434FFDD9855FFE7B788FFD98C41FFF0D0
      B1FFD68636FFD68434FFDB8939FFCB8948FF00000000F8FAFCFFE3EEF2FF62A7
      D7FF17AAFFFF20A1FFFF1F9EFFFF20A0FFFF20A0FFFF209FFFFF20A0FFFF21A1
      FEFF125BB2FF0D4193FF0E4598FF0D4497FF0D4397FF0D4296FF0C4195FF0B3A
      8DFF146CCAFF1E9CFFFF1C95FFFF1B94FFFF1B91FFFF1A90FFFF188BFFFF1898
      FFFF0F99FAFF8CBAD7FFEBF3F6FFFBFCFDFFE3E3F5003333D7000909CF000D0D
      D6000D0DD6000B0BD700BDBDF500FFFFFF00FFFFFF00FFFFFF008C8CE2008D8D
      DA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4FE004747
      E4000000D8000000D9000000D9000000D7000000D6000000D5000000D4000000
      D2000000D1000000CB003E3ED400E5E5F6000000000000000000000000000000
      00000000000000000000C9C9C9FF717171FF343435FF232324FF252526FF2727
      28FF181818FF151515FF191919FF1A1A1AFF191919FF141414FF373737FF5050
      50FF505051FF515151FF4B4B4BFF525253FF888888FFDEDEDEFF000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFCACACAFFD2D2D2FFF6EFE7FFFEF5ECFFFEF5ECFFF0EAE4FFD3D3D3FFE3E3
      E3FFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAFFD5D5D5FFD5D5D5FFD5D5D5FFD5D5
      D5FFD3CDC8FFF7B574FFE29040FFDE8C3CFFE29952FFF0CBA8FFDE8C3DFFF3D6
      B8FFE09349FFDE8C3CFFE39241FFD6924FFFFEFEFEFFF3F8F9FFBDD7E4FF209A
      EDFF1BACFFFF22A0FFFF21A3FFFF22A4FFFF22A4FFFF22A4FFFF22A3FFFF23A7
      FFFF1E92ECFF0F4A9CFF0F489AFF0F489BFF0F479AFF0E4699FF0D4194FF1052
      A8FF1E9BFCFF1E9CFFFF1D99FFFF1D97FFFF1C95FFFF1B93FFFF1A91FFFF1A8D
      FFFF11A1FFFF3B97DDFFD7E7EDFFF7FAFBFFE3E3F5003232D8000E0ED1001515
      DA001616DB001010DA008282DA00FFFFFD00FFFFFF00FFFFFF00FFFFFF009292
      E4008F8FDB00FFFFFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4
      FE004747E7000000DB000000DC000000DC000000DA000000D8000000D7000000
      D6000000D4000000CD003E3ED600E5E5F6000000000000000000000000000000
      000000000000000000000000000000000000EDEDEDFFBEBEBFFF8F8F8FFF6060
      60FF131313FF0F0F0FFF101010FF111111FF111111FF0C0C0CFF272727FF6060
      60FF6F6F70FF939394FFC4C4C5FFF3F3F3FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFCBCBCBFFD4D4D4FFF6F0E8FFFEF6EDFFFEF6EDFFF0EAE4FFD6D6D6FFC9C9
      C9FFEFEFEFFFFAFAFAFFF7F7F7FFEAEAEAFFD7D7D7FFD7D7D7FFD7D7D7FFD7D7
      D7FFD7D4D1FFF8C28EFFEA994AFFE49242FFE49445FFF5D5B7FFE69B51FFF5D5
      B6FFE79B52FFE49242FFEE9C4CFFD19355FFFDFDFEFFF0F6F8FF83B8D9FF15A9
      FFFF21A7FFFF23A5FFFF23A7FFFF23A8FFFF23A8FFFF23A8FFFF23A8FFFF23A7
      FFFF24ADFFFF1977CBFF104999FF114E9EFF104D9EFF104A9CFF0F4798FF1B89
      E4FF21A5FFFF1F9EFFFF1F9DFFFF1E9AFFFF1D99FFFF1C97FFFF1B95FFFF1B91
      FFFF1598FFFF0D93F4FFACCDDFFFF5F9FAFFE3E3F5003131D9001212D4001D1D
      DE001D1DDF001E1EE2001010D6007F7FD600FFFFFD00FFFFFF00FFFFFF00FFFF
      FF00A1A1EA005252CA005D5DC900BBBBE400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F4F4FE004747E9000000DE000000DF000000DE000000DC000000DB000000
      DA000000D7000000CE003E3ED700E5E5F6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F6FF151515FF0B0B0BFF1A1A1AFF1D1D1DFF151515FF090909FF373737FFFCFC
      FCFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFCDCDCDFFD6D6D6FFF7F1EAFFFEF7EFFFFEF7EFFFF0EBE6FFD9D9D9FFDADA
      DAFFE2E2E2FFCFCFCFFFD8D8D8FFDADADAFFDADADAFFDADADAFFDADADAFFD9D9
      D9FFF4F4F4FFFEE1C6FFF4A961FFE79545FFE79545FFEAA45FFFF4D1ADFFF2C6
      9BFFE79647FFE99747FFF7A555FFB39576FFFBFCFDFFE6F0F3FF4FA4DDFF17B0
      FFFF25A8FFFF24AAFFFF25ABFFFF25ACFFFF25ACFFFF25ACFFFF25ACFFFF25AB
      FFFF25ADFFFF24A7FAFF155EAEFF12509FFF1252A1FF104B9AFF176FC2FF23AA
      FFFF22A4FFFF21A2FFFF20A0FFFF209EFFFF1F9CFFFF1E9AFFFF1D98FFFF1C95
      FFFF1A94FFFF0A9CFFFF78B1D8FFF3F7F9FFE3E3F5003131DB001717D6002525
      E2002525E3002626E4002727E8001717DB008181D700FFFFFD00FFFFFF00FFFF
      FF00CECEEF002727E5002323E8002323D200ADADDF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F4F4FE004747EB000000E1000000E1000000E0000000DE000000
      DD000000DA000000D0003E3ED800E5E5F6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFEF
      EFFF191919FF2A2A2AFF2D2D2DFF262626FF282828FF202020FF444444FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD0D0D0FFDADAD9FFF8F1EBFFFFF7F0FFFFF7F0FFF2ECE7FFDDDDDDFFC9C9
      C9FFDDDDDDFFEDEDEDFFE5E5E5FFECECECFFDEDEDEFFDEDEDEFFDEDEDEFFD8D8
      D8FFE5E5E5FFFEFAF5FFFDD0A4FFEEA053FFE79545FFE79545FFE79546FFE795
      45FFE99747FFF3A353FFDFA064FFC9C7C5FFFBFCFDFFD4E5ECFF31A2E9FF1DB2
      FFFF27ACFFFF26AEFFFF26AFFFFF26B0FFFF27B0FFFF27B0FFFF27B0FFFF27B0
      FFFF27AFFFFF28B4FFFF2092E1FF1354A1FF1354A2FF145BA9FF23A1F5FF24AC
      FFFF23A7FFFF23A5FFFF22A3FFFF21A2FFFF20A0FFFF1F9DFFFF1E9BFFFF1D99
      FFFF1D95FFFF0F9FFFFF4FA0DBFFEBF3F6FFE3E3F5003131DC001C1CD9002C2C
      E6002C2CE7002D2DE8002F2FE9003030ED001F1FDF008383D800FFFFFC00CCCC
      E8003636D2003535EF003C3CF0003939F2002C2CD700ADADDF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F4F4FE004747EC000000E3000000E3000000E2000000
      E0000000DE000000D2003E3EDA00E5E5F6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E0E0
      E0FF343434FF323232FF242424FF262626FF2A2A2AFF2E2E2EFF4D4D4DFFFDFD
      FDFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD1D1D1FFDCDCDCFFF8F2EDFFFFF8F2FFFFF8F2FFF2EDE9FFE0E0E0FFDADA
      DAFFE6E6E6FFFEFEFEFFF8F8F8FFE9E9E9FFE7E7E7FFE1E1E1FFE1E1E1FFE1E1
      E1FFD8D8D8FFF5F5F5FFFFF7F1FFFDD4ACFFF5AD68FFED9E51FFEB9B4DFFEE9F
      52FFF6AB62FFDEA771FFC7C2BDFFF3F3F3FFFCFDFDFFC4DCE7FF26A6F3FF29B7
      FFFF27B0FFFF27B2FFFF28B3FFFF28B4FFFF28B4FFFF29B4FFFF29B4FFFF29B4
      FFFF28B4FFFF28B4FFFF29B6FFFF1B77C3FF13529EFF1F8CDBFF27B4FFFF25AD
      FFFF25ABFFFF24AAFFFF23A8FFFF23A6FFFF22A4FFFF20A1FFFF209FFFFF1E9C
      FFFF1E98FFFF1DA5FFFF3A9CE2FFE1EDF1FFE3E3F5003030DD002121DB003434
      E9003333EA003535EC003636ED003838EE003939F1002E2EE4005C5CCC003D3D
      D4003838F2004141F2004242F2004444F2004242F5003232D900ADADDF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F4F4FE004343ED000000E5000000E5000000
      E4000000E0000000D4003E3EDA00E5E5F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008C8C
      8CFF353535FF252525FF222222FF272727FF2A2A2AFF2D2D2DFF2E2E2EFFC8C8
      C8FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD3D3D3FFE0E0E0FFF8F2EEFFFFF8F3FFFFF8F3FFF3EEEAFFDEDEDEFFE9E9
      E9FFF3F3F3FFF5F5F5FFFCFCFCFFF8F8F8FFEAEAEAFFE5E5E5FFE5E5E5FFE5E5
      E5FFE4E4E4FFE3E3E3FFFFFFFFFFFCF9F7FFEFDECCFFF8D4B1FFF9CFA8FFF7CF
      A8FFC7B29DFFB8B7B5FFF1F1F1FFFEFEFEFFFEFEFEFFBAD6E5FF2AADF9FF38BE
      FFFF2FB7FFFF27B5FFFF29B7FFFF2AB8FFFF2AB8FFFF2AB8FFFF2AB8FFFF2AB8
      FFFF2AB8FFFF2AB8FFFF2ABAFFFF26A6EFFF1B77C1FF28B3FFFF28B3FFFF27B1
      FFFF26AFFFFF26ADFFFF25ABFFFF24A9FFFF23A7FFFF22A5FFFF20A2FFFF1F9F
      FFFF2AA0FFFF2BAAFFFF359DE9FFDAE9EFFFE3E3F5003132DE002626DE003C3C
      EC003A3AEE003C3CEF003E3EF0003F3FF0004141F1004242F4003838F0004141
      F5004747F5004848F5004949F5004B4BF5004D4DF5004C4CF8003838DA00B1B1
      E100FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E8FD001818EB000000E8000000
      E7000000E3000000D6003E3EDC00E5E5F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E4E4E4FF3E3E
      3EFF2D2D2DFF202020FF242424FF272727FF2A2A2AFF2E2E2EFF2E2E2EFF5959
      59FFFCFCFCFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD6D6D6FFE2E2E2FFF8F4F1FFFFFAF6FFFFFAF6FFF3F0EDFFE6E6E6FFD8D8
      D8FFF7F7F7FFF6F6F6FFF2F2F2FFDEDEDEFFE9E9E9FFE9E9E9FFE8E8E8FFE4E4
      E4FFF4F4F4FFFFFFFFFFFEFEFEFFF0F0F0FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8
      E8FFB5B5B5FFC2C2C2FFF6F6F6FF00000000FEFEFEFFB7D4E2FF2A7EC2FF3287
      C7FF3386C7FF2782C5FF1C7BC1FF1C7BC1FF1D7DC2FF1E7DC2FF1E7DC2FF1E7D
      C2FF1D7DC2FF1D7CC2FF1D7AC0FF1E7EC5FF2190D8FF1B75BDFF1B75BEFF1A73
      BDFF1970BCFF196EBBFF186BBAFF1768B8FF1666B6FF1362B4FF1561B4FF2268
      B7FF2A6AB8FF276CB8FF3470B1FFDBE9EFFFE3E3F5003334DE002A2AE0004444
      F0004242F1004343F2004545F3004646F4004848F4004949F5004B4BF6004C4C
      F6004D4DF6004F4FF7005050F7005252F7005454F7005656F7005252FA005050
      E000EAEAF500FFFFFF00FFFFFF00FFFFFF00FFFFFF008282F6000000EA000000
      EA000000E7000000D8003E3EDD00E5E5F6000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFDFF7B7B7BFF3333
      33FF222222FF202020FF272727FF2B2B2BFF2A2A2AFF2E2E2EFF323232FF3434
      34FFA5A5A5FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD7D7D7FFE4E4E4FFF8F4F1FFFFFAF6FFFFFAF6FFF3F0EDFFE9E9E9FFE5E5
      E5FFE0E0E0FFE7E7E7FFD9D9D9FFEDEDEDFFE5E5E5FFF5F5F5FFF9F9F9FFF7F7
      F7FFFCFCFCFFFFFFFFFFFAFAFAFFE9E9E9FFEAEAEAFFEAEAEAFFEAEAEAFFEAEA
      EAFFB8B8B8FFC2C2C2FFF6F6F6FF00000000FEFEFEFFC4DBE6FF3376B5FF347D
      B9FF347BB8FF357DB9FF2E7AB8FF2171B4FF196EB2FF196EB2FF1A6EB2FF1A6F
      B2FF1A6EB2FF1A6EB1FF1867ACFF218ED1FF2CBDFCFF1B75BAFF1762A9FF1763
      AAFF1660A9FF155EA7FF145AA5FF1156A3FF1354A2FF1C58A4FF295FA7FF2C60
      A7FF2A5CA5FF2C5FA5FF3F6BA3FFE4EEF3FFE3E3F5003435DD002C2CE2004B4B
      F3004949F3004B4BF4004C4CF5004D4DF6004F4FF7005050F8005252F9005454
      F9005555FA005656FA005858FA005959FA005B5BFA005C5CFA005E5EFA004E4E
      F600CFCFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00DADAFD002B2BF1000000
      ED000000EA000000DA003E3EDD00E5E5F6000000000000000000000000000000
      00000000000000000000000000000000000000000000C9C9C9FF383838FF2727
      27FF1D1D1DFF222222FF2A2A2AFF343434FF353535FF2E2E2EFF323232FF3636
      36FF3C3C3CFFE1E1E1FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE7E6E6FFF9F5F3FFFFFBF8FFFFFBF8FFF4F1EFFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFE5E5E5FFDFDFDFFFDFDFDFFFE9E9E9FFF5F5F5FFFDFD
      FDFFFDFDFDFFFBFBFBFFE8E8E8FFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFECEC
      ECFFB9B9B9FFC3C3C3FFF6F6F6FF00000000FEFEFEFFD9E8EFFF4485BEFF3F8A
      C2FF3884C0FF3A87C0FF3B88C1FF3B88C1FF3284BFFF277EBCFF1F79BAFF1C77
      B8FF1B76B8FF1A73B5FF1C7DBFFF2BBCFAFF2DC5FFFF26A9EBFF186BB0FF1769
      B0FF1667AFFF1765AEFF1B65AEFF2369AFFF2E6EB2FF3470B3FF336CB1FF3168
      AEFF2E64ACFF396EB0FF5482B1FFF3F7F9FFE3E3F5003437DE003030E5005353
      F5005050F5005252F6005454F7005555F8005656FA005858FA005959FB005B5B
      FB005C5CFC005E5EFC005F5FFC006161FC006363FC006262FC006262FC009292
      FC008C8CE200F3F3F900FFFFFF00FFFFFF00FFFFFF00DEDEFC007070F6002E2E
      F2000000ED000000DD003D3DDF00E5E5F6000000000000000000000000000000
      000000000000000000000000000000000000000000008D8D8DFF323232FF2020
      20FF1E1E1EFF232323FF2D2D2DFF373737FF434343FF3A3A3AFF313131FF3636
      36FF3B3B3BFFB0B0B0FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE6E6E6FFF8F5F3FFFFFBF8FFFFFBF8FFF4F1EEFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFE6E6E6FFE4E4E4FFDADA
      DAFFDCDCDCFFDEDDDDFFE8E7E5FFE7E6E5FFE7E6E5FFE7E6E5FFE7E6E5FFE5E4
      E3FFB7B6B5FFCBCBCBFFF8F8F8FF00000000FEFEFEFFF0F6F8FF5B94C4FF4F98
      CAFF3C8BC3FF3F8EC4FF3F90C5FF4090C5FF4192C7FF4192C6FF3D90C5FF378C
      C3FF3088C1FF2A80BCFF32AFE8FF37CCFFFF35C5FFFF37C8FFFF2C94D2FF2875
      B5FF2E7BBAFF347CBAFF397DBBFF3B7CBAFF3979B8FF3875B6FF3672B4FF366F
      B2FF346BB0FF4879B6FF769FC1FFFDFDFEFFE3E3F5003538DE003535E8005B5B
      F8005858F8005959F8005A5AFA005C5CFB005E5EFC005F5FFC006161FD006262
      FD006363FD006565FD006767FE006868FD006969FE006767FD00B9B9FE00FFFF
      FF00C7C7F1007E7ED500F3F3F900FFFFFF00FFFFFF00C8C8F6007171F8007B7B
      F9002222F2000000DF003E3EDF00E5E5F6000000000000000000000000000000
      00000000000000000000000000000000000000000000717171FF282828FF1C1C
      1CFF1E1E1EFF262626FF313131FF3A3A3AFF454545FF4D4D4DFF373737FF3535
      35FF3B3B3AFF959595FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE6E6E6FFF8F5F2FFFFFBF8FFFFFBF8FFF3F0EEFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFEBE3DAFFE9AE75FFEBA663FFEAA563FFEAA563FFEAA563FFEAA563FFE6A2
      61FFA7917BFFE4E4E4FFFCFCFCFF00000000FEFEFEFFFEFEFEFF82B1D0FF5FA1
      D1FF4695C8FF4395C8FF4597C9FF4598CAFF4599CAFF4599CAFF4699CAFF479A
      CAFF4696C7FF4BA9D9FF55D6FFFF54D2FFFF53D1FFFF53D1FFFF51C9F9FF4492
      C8FF4289C1FF4188C1FF4085BFFF3F82BDFF3D7EBBFF3C7BB9FF3B78B8FF3874
      B5FF457CB9FF4C7BB6FFABC9DAFF00000000E3E3F5003739DD003939EB006363
      FA005F5FFA006161FB006262FC006464FD006565FD006767FE006868FE006969
      FE006B6BFE006C6CFF006E6EFF006F6FFF006868FF00AFAFFF00FFFFFF00FFFF
      FF00FFFFFF00C8C8F2008080D500F3F3F900FFFFFF009C9CED007777FA008585
      FA007676F9000F0FE4003D3EDE00E5E5F6000000000000000000000000000000
      00000000000000000000000000000000000000000000767676FF212121FF1B1B
      1BFF202020FF292929FF343434FF3D3D3DFF474747FF545454FF494949FF3535
      35FF3C3C3CFF858687FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE6E6E6FFF8F4F2FFFFFBF8FFFFFBF8FFF3F0EEFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFF0C194FFF7A454FFF6A353FFF6A353FFF6A353FFF6A353FFF5A354FFB191
      71FFDBDADAFFF9F9F9FF00000000000000000000000000000000C3DBE7FF5799
      CDFF61ABD4FF469ACBFF4A9ECDFF4A9FCEFF4AA0CEFF4AA0CEFF4AA0CEFF4A9F
      CDFF4AA0CFFF56CFF7FF58D9FFFF58D5FFFF57D4FFFF57D3FFFF57D6FFFF4FB6
      E8FF458CC2FF458DC4FF448AC2FF4388C1FF4285BFFF4181BDFF407EBBFF3C78
      B8FF6395C7FF4E7EB3FFE6F0F4FFFEFEFEFFE3E3F500383BDD003F3FEF006A6A
      FC006767FC006868FD006969FD006B6BFE006C6CFE006D6DFF006F6FFF007171
      FF007373FF007575FF007777FF007979FF007878FF007D7DE600E7E7F200FFFF
      FF00FFFFFF00FFFFFF00CACAF2008989D700D1D1EB007B7BEE008686FE008787
      FB009393FC004C4DEC003B3BDD00E5E5F6000000000000000000000000000000
      00000000000000000000000000000000000000000000A6A6A6FF202020FF1B1B
      1BFF212121FF2B2B2BFF363636FF404040FF4A4A4AFF555555FF5B5B5BFF3737
      38FF363534FFDDD5D3FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE6E6E6FFF8F4F2FFFFFBF8FFFFFBF8FFF3EFEDFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFF8C390FFFAA859FFF6A353FFF6A353FFF7A454FFF7A556FFB39272FFDBDB
      DBFFF8F8F8FF0000000000000000000000000000000000000000F8FAFBFF67A1
      CCFF7DBBDEFF57A8D3FF4CA4D1FF4FA6D2FF50A7D2FF50A8D2FF50A8D2FF4FA4
      CFFF56C1E8FF5EDFFFFF5DDAFFFF5CDAFFFF5CD8FFFF5BD7FFFF5BD6FFFF5AD4
      FFFF4EA3D5FF4991C5FF4991C6FF488EC4FF478BC2FF4687C1FF4181BDFF5990
      C5FF6997C8FF87AECBFF00000000FEFEFEFFE3E3F500393CDE004B4BF4007171
      FD006D6DFD006F6FFE007070FF007171FF007474FF007676FF007A7AFF007D7D
      FF007F7FFF008282FF008383FF008585FF008888FF007878F7006C6CD600E6E6
      F200FFFFFF00FFFFFF00FFFFFF00D2D2F5006060D8008888FD008F8FFE008F8F
      FC009898FD006768F2003D3FDE00E6E6F6000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9CFF151515FF1A1A
      1AFF232323FF2E2E2EFF383838FF424242FF4C4C4CFF595959FF545454FF2E2E
      2EFF3A3939FFF6F5F5FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE5E5E5FFF7F4F2FFFFFBF8FFFFFBF8FFF2EFEDFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFF9C89AFFFEB066FFFDAC5FFFFDAD60FFFBAD61FFB49475FFDBDADAFFF8F8
      F8FF00000000000000000000000000000000000000000000000000000000C2DA
      E7FF5FA4D5FF86C7E2FF55ACD5FF53ACD5FF55AED6FF55AFD6FF55ADD4FF57B6
      DCFF62DEFEFF62E0FFFF61DEFFFF61DDFFFF60DBFFFF60DBFFFF5FD8FFFF5FDA
      FFFF5AC9F4FF4E99CBFF4D96C8FF4C93C7FF4C90C5FF478AC2FF5490C5FF83B1
      D6FF5083B9FFE5EFF3FF0000000000000000E5E5F6003C41E0005A5AFA007777
      FF007474FF007575FF007777FF007B7BFF007F7FFF008383FF008686FF008888
      FF008B8BFF008D8DFF008E8EFF009090FF009191FF009595FF008585F9007171
      D600E6E6F200FFFFFF00FFFFFD00A4A4E2008C8CFE009494FF009595FE009696
      FE009E9EFE007A7AF7004345DF00E9E9F7000000000000000000000000000000
      00000000000000000000000000000000000000000000858585FF202020FF3030
      30FF202020FF2F2F2FFF3A3A3AFF444444FF505050FF505050FF2D2D2DFF1919
      19FF191919FFD4D4D4FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE5E5E5FFF7F4F1FFFFFBF8FFFFFBF8FFF2EFEDFFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFF9D2AEFFFFC58DFFFFC288FFFDC088FFB89B80FFDBDADAFFF8F8F8FF0000
      0000000000000000000000000000000000000000000000000000FEFEFEFF0000
      000083B4D5FF80C0E3FF8ACBE4FF5BB5D9FF58B4D9FF5BB6D9FF5BB5D8FF63D7
      F4FF67E6FFFF66E2FFFF66E2FFFF65E0FFFF65DFFFFF64DEFFFF63DCFFFF63DA
      FFFF62DCFFFF59B7E3FF5198C9FF5198CBFF4C93C7FF5997C9FF8CBBDBFF5E91
      C5FFACCADCFF000000000000000000000000E9E9F700484DE3006F6FFE007C7C
      FF007B7BFF007E7EFF008383FF008787FF008A8AFF008D8DFF009090FF009393
      FF009595FF009797FF009999FF009B9BFF009C9CFF009C9CFF00A0A0FF009191
      F9007777D700D5D5EB009A9ADA007A7AEA009F9FFF009C9CFF009C9CFF009D9D
      FF00A2A2FE009293FC005153E100EFEFF9000000000000000000000000000000
      00000000000000000000000000000000000000000000878787FF1A1A1AFF5252
      52FF363636FF303030FF3C3C3CFF474747FF4B4B4BFF393939FF2C2C2CFF1D1D
      1DFF141414FFD3D3D3FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F3FFD8D8D8FFE6E6E6FFF5F0EDFFFFFBF8FFFFFBF8FFEFEAE6FFEBEBEBFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFF9DCC1FFFFD7B2FFFDD3ACFFB6A18CFFDCDBDBFFF8F8F8FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F4F8FAFF6AA8D3FF92D0EAFF97D5E9FF69C0DFFF5BB9DAFF63CCE8FF6CEA
      FFFF6BE7FFFF6BE7FFFF6AE5FFFF6AE4FFFF69E3FFFF69E1FFFF68DFFFFF67DE
      FFFF66DCFFFF64D7FCFF56A7D4FF519ACBFF69A6D2FF98C5E0FF74A6D2FF85AD
      CDFF00000000FEFEFEFF0000000000000000F5F5FB006C72EB008585FF008181
      FF008585FF008989FF008D8DFF009191FF009595FF009898FF009B9BFF009D9D
      FF00A0A0FF00A2A2FF00A3A3FF00A5A5FF00A5A5FF00A6A6FF00A7A7FF00ABAB
      FF009E9EFB006A6AD5008888EC00ACACFF00A6A6FF00A5A5FF00A4A4FF00A5A5
      FF00A6A6FE00AFB0FF007C7DE400FCFCFD000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A3FF101010FF2B2B
      2BFF4E4E4EFF353535FF272727FF2C2C2CFF3F3F3FFF454545FF3A3A3AFF2828
      28FF494949FFFAFAFAFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F4F4
      F4FFD9D9D9FFE9E9E9FFE5E2E1FFF4EFEBFFF2EDE9FFE6E5E3FFEDEDEDFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFF9DFC6FFFDD9B9FFB7A491FFDBDADAFFF8F8F8FF0000000000000000FEFE
      FEFFFCFCFCFFFEFEFEFF00000000000000000000000000000000000000000000
      000000000000EAF2F6FF69AAD6FF93D3EDFFA8E0EEFF85D1E7FF70E7FBFF6CEC
      FFFF6DEAFFFF6FEAFFFF6EE8FFFF6EE8FFFF6DE6FFFF6DE4FFFF6BE2FFFF6AE0
      FFFF67DEFFFF66DEFFFF6BCAF0FF87BADAFFA4D0E6FF77ABD5FF7BA8CBFFFDFD
      FEFF0000000000000000000000000000000000000000A2A5EB008F94FF008E8D
      FF008D8DFF009393FF009797FF009B9BFF009E9EFF00A1A1FF00A4A4FF00A7A7
      FF00A9A9FF00ABABFF00ADADFF00AEAEFF00AFAFFF00B0B0FF00B0B0FF00B0B0
      FF00B2B2FF00B5B5FF00B3B3FF00AFAFFF00AFAFFF00AFAFFF00AEAEFF00AAAA
      FF00BCBCFF00A0A3FF00BCBCEE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0E0E0FF191919FF1313
      13FF2E2E2EFF525252FF5F5F5FFF686868FF606060FF4E4E4EFF3F3F3FFF3636
      36FFD0D0D0FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F7FFDCDCDCFFE4E4E4FFE9E9E9FFE6E6E6FFE7E7E7FFE9E9E9FFEAEAEAFFEAEA
      EAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEA
      EAFFF4DDC7FFB8A695FFDBDBDBFFF8F8F8FF000000000000000000000000FAFA
      FAFFF5F5F5FFFCFCFCFF00000000000000000000000000000000000000000000
      00000000000000000000F0F6F8FF7BB4D9FF84CAEBFFB3F4FCFFAFF9FFFF96F2
      FFFF81F0FFFF76EDFFFF71ECFFFF6FEAFFFF6EE8FFFF6EE6FFFF6FE4FFFF73E4
      FFFF80E4FFFF98E8FFFFAFF2FFFFA5DCF0FF689FCFFF8EB5D3FFFEFEFEFF0000
      000000000000000000000000000000000000FEFEFE00F3F3FB008289F100B4B7
      FF00A7A5FF009E9EFF00A1A0FF00A4A4FF00A8A7FF00ABABFF00AEADFF00B1B0
      FF00B4B3FF00B5B5FF00B8B7FF00B8B8FF00B9B8FF00BABAFF00BABAFF00BBBA
      FF00BCBBFF00BBBBFF00BBBBFF00BABAFF00BBBAFF00BABAFF00BEBDFF00D2D1
      FF00C6C9FF00878AED00FDFDFE00FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000969696FF1515
      15FF171717FF2E2E2EFF474747FF4E4E4EFF505050FF595959FF767676FFC9C9
      C9FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFDEDEDEFFD9D9D9FFD5D5D5FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3
      D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3
      D3FFC1BAB2FFE1E1E1FFF9F9F9FF00000000000000000000000000000000F8F8
      F8FFF8F8F8FFFEFEFEFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7CCE2FF76CCF4FF9FF3FFFFBAFF
      FFFFBCFDFFFFB4F8FFFFAAF5FFFFA2F3FFFFA0F2FFFFA3F1FFFFAAF2FFFFB3F4
      FFFFB9F7FFFFB1F6FFFF8BE2FFFF70B7E5FFBFD7E5FF00000000000000000000
      000000000000000000000000000000000000FEFEFE0000000000ECECF9009199
      EF00AFB7FF00C9CCFF00CED1FF00D1D4FF00D3D6FF00D3D7FF00D6D9FF00D8DB
      FF00DADDFF00DCDFFF00DADEFF00DBDFFF00DCE0FF00DDE0FF00DDE0FF00DADE
      FF00DBDEFF00DBDEFF00DBDEFF00DBDEFF00D5D8FF00D5D8FF00CED2FF009FA5
      FD009194EE00F8F8FC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A7A7
      A7FF292929FF242424FF343434FF404040FF4E4E4EFFCFCFCFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFEFFFAFAFAFFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
      F7FFF9F9F9FFFCFCFCFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EAF2F6FF9ECDE5FF7CCB
      F0FF87E2FFFFA3F4FFFFB1FBFFFFB8FDFFFFB8FDFFFFB5FAFFFFACF6FFFF98EA
      FFFF7CD4FBFF7AC2EAFFAFD2E7FFF9FBFCFF0000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00000000000000
      0000D2D3F200B2B6ED00AEB2EC00AFB3EC00AFB3EC00ADB2EC00AEB2EC00AEB2
      EC00AEB3EC00AEB2EC00ACB0EC00ABB0EC00ABB0EC00ABB0EC00ABAFEC00A8AD
      EC00A7ACEC00A7ABEC00A6ABEC00A6AAEC00A4A8EC00A3A6EC00ACAEEC00DBDB
      F400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2E2E2FF919191FF787878FF979797FFE0E0E0FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FAFC
      FCFFCEE4EDFFA8D1E6FF8FC8E4FF87C8E9FF85C7E8FF88C7E8FF92C7E3FFAFD3
      E6FFDAEAF1FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000912A0000912A
      0000912A0000912A0000912A0000912A0000912A0000912A0000912A0000912A
      0000912A0000912A000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FAFBFA00F2F6
      F100E9EFE600E2EADE00DDE6D900DBE4D600DBE4D600DBE4D600DBE4D600DBE4
      D600DBE4D600DBE4D600DBE4D600DBE4D600DBE4D600DBE4D600DBE4D600DBE4
      D600DBE4D600DBE4D600DBE4D600DBE4D600DBE4D600DCE6D800E2EADE00E8EE
      E500F2F6F100FAFBFA00FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F9F9F900F6F6F600F6F6F600FAFAFA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00F1F1F100EDEDED00EDEDED00F2F2F200FBFBFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000912A0000912A0000912A0000912A
      0000902900009028000090280000902800009028000090280000902800009029
      0000912A0000912A0000912A0000912A00000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F8FAF800E9EFE700DAE3
      D500C6D5BF00AFC8A700A6C29D00A5C19B00A5C19B00A5C19B00A5C19B00A5C1
      9B00A5C19B00A5C19B00A5C19B00A5C19B00A5C19B00A5C19B00A5C19B00A5C1
      9B00A5C19B00A5C19B00A5C19B00A5C19B00A5C19B00A5C29C00AEC7A500C5D5
      BE00D9E3D400E9EFE700F8FAF800FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F8F8F800D9D9
      D900B4B0B0009C8C8C00907973008C6F68008C6F6800927B76009D8F8F00B7B4
      B400DDDDDD00FBFBFB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEEEEE00C7C7
      C700A39898009179730088655B00825C4F00825C4F0088645C00927B7700A79D
      9D00CBCBCB00F2F2F20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000912A0000912A0000912A0000902800009029
      0000932D0000963200009A3800009B3A00009B3A00009A38000097330000932E
      0000912900009028000091290000912A0000912A0000912A0000000000000000
      000000000000000000000000000000000000FBFCFB00EAF0E800D4DFCE0095BC
      8E004BA7550035A5480030A3450031A4460030A4450030A4460030A4460030A5
      460030A5460030A5460030A5460030A5460030A5460030A5460030A4460030A4
      450030A3450030A3440030A2440030A1430031A2430030A0420033A144004AA5
      540093BB8D00D4DFCE00EAF0E800FAFBFA000000000000000000000000000000
      000000000000000000000000000000000000EEEEEE00AFA9A900896458008841
      250096370E00A43C0E00A9411000AC421000AB411000A73D0E009E390D009034
      0E00844029008B686000B6B1B100F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E0E0E0009E8E8E00855342008F3B
      1A00A03A0E00AB421000AF441000AF441000AE441000AC421000A63C0E009935
      0B0089381B0085564800A6999900E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000912A0000912A0000912A000090280000912A000098350000A145
      0100A9530900AE5C1300B1621900B2631C00B2631C00B1621A00AF5E1500AA55
      0C00A34802009A380000922C000090280000912A0000912A0000912A00000000
      000000000000000000000000000000000000F5F8F400DFE7DB0084B7810025A6
      4100229C3800149127000F9024000F9125000F9226000F9327000F9327000F94
      28000F9428000F9428000F9528000F9428000F9428000F9428000F9427000F93
      27000F9226000F9125000F9024000F8F23000F8E22000F8C2100128D22001D95
      3000209F3A007FB47C00DCE5D800F3F6F2000000000000000000000000000000
      00000000000000000000FEFEFE00B8B4B400885644009B3C1200B44A1500B94D
      1700B54A1500B1471100AF440E00AE420E00AD420D00AC410D00AC420E00AD44
      1000AF451000A93E100091320F00865A4D00C0BDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F4F4F400A597970088493100A7421300B84D1800B84D
      1700B34A1400B0461100AF440E00AE430E00AD420D00AC410D00AB410D00AC43
      1000AE451000AC43100099350B00844C3900AEA5A500FAFAFA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000912A0000912A0000912900009028000097340000A44A0300AF5E1400B467
      2200B5692300B6671F00B5651B00B4641900B5641900B5651B00B6671F00B669
      2400B5692300B1611800A74F06009A3800009129000090290000912A0000912A
      000000000000000000000000000000000000F1F4EF00B4CEAD0022A53F001293
      280000881400008B1700008C1900008D1A00008E1A0000901A0000901C000090
      1B0000911C0000911D0000921D0000921D0000911C0000901B0000911C000090
      1B00008E1A00008D1A00008C1800008B1700008A160000881500008713000084
      10000B8A1D001A9D3400ADCAA700EFF3ED000000000000000000000000000000
      000000000000F2F2F200967E780098401900BA541D00B9541D00B44D1900B852
      1900BF5E2100C86D2C00CF783600D27F3E00D17F3E00CE763500C6672700BA56
      1900AF450E00AA3E0D00AD441000AC4210008C3716009C888500F7F7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2E2E2008B655900A3431500BB561F00B8531D00B44E1900BA57
      1C00C4652600CE763400D4814100D8894800D7894800D3803E00CA713000BF5D
      1F00B1491100AB3E0D00AC431000AE43100093340D0090716900EBEBEB000000
      000000000000000000000000000000000000000000000000000000000000912A
      0000912A000090290000912A00009E3E0000AE5B1000B66A2300B7692000B664
      1700B6621200B6621200B7631200B7631300B7631300B7631200B7621200B662
      1200B7641500B8681F00B76B2500B1601500A2450100922C000090280000912A
      0000912A0000000000000000000000000000EFF3ED006DB47200119C2F00008B
      1700008F1C0000911D0000921E0000921F0000941F0000942100009621000096
      2200009721000097220000962200009622000097210000962200009621000094
      21000094200000931F0000911E0000911D0000901C00008E1B00008D1900008B
      1800008713000691200060AE6600EAF0E8000000000000000000000000000000
      0000F0F0F000906A5E00AE4B1C00BE5B2500B9572100C1632500D57F3A00E49B
      5700ECAD6D00EFB57900F0B97E00F0B98000F0BA8200F1BA8300F0B98000EDB1
      7600E39C5C00CF783500B9521700AA410E00AE4410009D380D0091716800F4F4
      F400000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE008C564300B8542000BB5A2500B9582100C8692A00DA874100E7A1
      5E00EDB07100EFB67A00EFB77C00EFB77C00EFB87E00F0BA8200F0BA8200EFB5
      7B00E7A36400D5813E00BC591B00AC420E00AD441000A53C0E00895C4D00E8E8
      E80000000000000000000000000000000000000000000000000000000000912A
      000091290000912A0000A2440100B4641900BA6C2500B9671800B9661500BA67
      1700BB691800BB6A1900BC6A1A00BC6A1A00BC6A1A00BC6A1A00BC6A1900BB69
      1900BA681800BA661500B9671700BA6C2300B6691F00A64D0400932E00009029
      0000912A0000912A00000000000000000000E9EFE70049AC5900049523000091
      1D0000941F000095200000952100009723000098240000992400009720000095
      1A00009418000095180000961B0000992200009B2600009B2500009924000099
      24000099240000982200009621000094210000941F0000921E0000911D00008F
      1B00008D1A00008C180032A34500E1E9DD00000000000000000000000000F8F8
      F800936F6200B7562200BE5F2A00C1642A00D8813800E89D5200ECA65F00E9A0
      5800E6974900E48F3E00E38A3600E2873300E2873300E38A3600E58F3F00E799
      4E00EBA66200EEAE6E00E9A15E00D3793300B34B1300AD431000A43B0E009579
      6F00FCFCFC00000000000000000000000000000000000000000000000000EBEB
      EB008D5A4500BD5B2700BC5E2A00C6682A00DD883D00EA9F5500EBA45C00E79D
      5200E6934400E48C3900E2873300E2853000E2843000E2863300E48C3B00E694
      4800E9A15C00EDAC6C00EBA66300D8813B00B8521500AC431000AB4110008D62
      5400F4F4F4000000000000000000000000000000000000000000912A0000912A
      000090290000A1440100B6671C00BC6E2300BC691800BC6B1A00BE6D1B00BD6B
      1800BF6F1E00C0701F00C0701F00C1712000C1702000C1712000C0701F00C070
      1F00BF6E1D00BD6A1800BD6C1B00BC6A1900BC6E2100B96C2300A74D0500922B
      000091290000912A00000000000000000000E8EEE50043A95300009723000096
      21000098230000992400009A2500009C2600009C260000991D0018A63B0057BF
      71007FCE930080CF940055BF71000FA43400009A1F00009F2900009E2900009E
      2800009D2700009C2600009B2500009924000098230000962200009520000093
      1E0000911D00008E1A0027A23F00DAE5D600000000000000000000000000A795
      8F00B1532200C1643000CC702E00E38D3B00E7984700E6913F00E3883300E284
      2C00E1832B00E1832B00E2832C00E2832C00E1832C00E1822B00E1802800E180
      2800E1802A00E2853200E6944800EB9F5800E28E4200BF5B1B00AE4410009D39
      0D00B0A4A0000000000000000000000000000000000000000000000000009778
      6C00BB5B2800C1653000D1763000E5913D00E7974600E5903D00E2873000E184
      2C00E1812A00E1832B00E2842D00E2842D00E2832D00E1822C00E1812A00E180
      2A00E17F2800E2833000E6914300EA9E5600E6924800C6622000AE441000A73C
      0E00A08A83000000000000000000000000000000000000000000912A00009028
      00009C3B0000B6661900BE712500BE6E1C00C0701F00C1712000C4752500C982
      3900C2701C00C3721D00C5772500C5772500C5772500C5772500C5762500C270
      1C00C3721F00C9823900C2742300C1712000BF6F1D00BF712300BA6C2000A245
      020090280000912A0000912A000000000000E8EEE50043AA5500009B2600009A
      2500009C2600009D2800009F2900009E2500009D22008AD49E00EBF8EF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DBF2E1004BBD6800009D200000A22C0000A2
      2C0000A02A0000A02900009F2900009D2800009C2600009A2500009823000097
      22000095200000921E0027A34100DAE5D6000000000000000000D9D8D8009F51
      2B00C66A3600D1783300E58C3400E58D3800E38A3300E2883000E2883100E288
      3200E2883200E2883100E2873000E2873000E2863000E1812800E3893400E284
      3000E1832D00E1812C00E1802A00E1833000E6914100E68E3E00C5611D00B145
      100091472600E4E4E40000000000000000000000000000000000C4BEBD00A950
      2500C66B3600D57D3300E68D3500E48D3600E3893300E2883100E3883200E288
      3100E5913E00E2852E00E2863000E2873100E2863000E2863000E2852E00E284
      2E00E1832D00E1822C00E1802A00E1822E00E68E3E00E7903F00CA672100B146
      1000973F1900D4D1D100000000000000000000000000912A000090280000942F
      0000B05C0F00C0742800C2722000C3742300C4762500C5742100CD894200FAF3
      ED00EACDAE00D18E4800C7751F00C87A2500CA7D2B00C8792400C7761F00D393
      5100EDD5BB00F7EDE400C97F3300C5752200C4762400C2732100C2752800B665
      17009936000090280000912A000000000000E8EEE50043AB5600009D2900009D
      2800009F290000A12B0000A0270008A6330051BB6B0095C49A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAFEFB0054C3720000A1220000A5
      2F0000A52F0000A42D0000A32C0000A12B0000A02A00009E2800009C2700009B
      2500009923000095210027A44200DAE5D5000000000000000000A1827500C366
      3500D27B3900E58E3600E48C3600E38B3600E38B3600E38C3600E38C3600E38C
      3600E38B3500E38B3500E38A3500E38A3300E1802600EBAE6E00F2CA9D00E182
      2A00E2853000E2842E00E2842E00E1822C00E1812C00E3863200E4853100C35D
      1B00AC421000A68E8400000000000000000000000000FDFDFD009A6C5700C86B
      3900D57F3800E68F3800E38C3600E38C3600E38C3600E38C3600E38C3600E184
      2C00EFC18F00F1C89B00E1832A00E2883100E3893300E3883200E2873000E287
      3000E2863000E2852E00E2842E00E1822C00E1812B00E3853100E6863100C863
      1D00B04410009D796B00000000000000000000000000912A00008F280000A246
      0300BF722300C5772600C6782600C87A2800C97C2A00CA7C2900CB823600F8F0
      E900FFFFFF00FDFAF600E9C7A300D3904600CC7C2400D5954E00ECCEAE00FEFD
      FB00FFFFFF00F3E4D800C97C2B00CA7C2A00C97C2900C7792700C6772500C276
      2800AB530A00912A000091290000912A0000E8EEE50043AB570001A02D0001A2
      2C0001A42E0000A42D0009A73200ACE2BC00FFFFFF0094CC9F0080BA8700FFFE
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAFEFB0054C6750000A4
      250000A9310000A7310000A7300000A62F0000A42D0000A22C0000A02A00009E
      2800009C27000098240026A54300DAE5D50000000000ECECEC00A35C3800D27B
      4100E38E3A00E58F3A00E48E3A00E48F3A00E48F3B00E48F3B00E48E3B00E48E
      3A00E48E3A00E48E3900E38C3600E1832A00ECB27400FEFCFA00F7DBBB00E182
      2A00E2883100E2873000E2863000E2852E00E2842E00E1822C00E3842D00DF80
      2C00BD54170097523400F5F5F5000000000000000000D9D6D600AB582D00D57F
      4100E5903A00E48F3A00E48F3A00E48F3A00E48F3A00E48F3B00E48F3B00E286
      2E00EFC49100FEFEFE00F2CDA100E2883100E2893200E38B3600E38A3500E389
      3300E3883100E2873000E2863000E2852E00E2842E00E1822D00E2832D00E282
      2D00C159190099472200E8E7E70000000000912A000090290000942E0000B461
      1300C77B2B00C97B2900CA7E2C00CC802E00CE823000CE833100CD802D00F1DD
      CB00FFFFFF00FFFFFF00FFFFFF00FBF6EF00F0D8BD00FDFAF600FFFFFF00FFFF
      FF00FFFFFF00ECD1B700CC7E2800CE833000CD822F00CC7F2D00C97C2A00C97C
      2C00BC6D1D009A3801008F270000912A0000E8EEE50043AD580007A635000DAA
      39000DAC3B0006AA3600A7E3BA00FFFFFF00FFFFFF00FFFFFF0094CEA00083BB
      8A00FFFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAFEFB0054C8
      770000A8280000AC340000AB330000AA320000A8310000A62F0000A42D0000A2
      2C0000A02A00009A270026A74400DAE5D50000000000C6BDBB00BA633300E08D
      4200E6923E00E4913D00E4913E00E4913E00E4913E00E4913E00E4913E00E491
      3D00E4913E00E48F3B00E2883000EFBD8600FEFEFC00FEFEFE00F7DDBE00E186
      2E00E38B3400E38A3300E3883200E2873000E2863000E2842E00E2832E00E586
      3000D5732600A5411300D2CDCC0000000000FEFEFE00B5A39A00C76D3A00E18F
      4100E5923E00E4913D00E4913E00E4913E00E4913E00E4913E00E4913E00E289
      3300EFC39100FEFEFE00FEFEFE00F5D6B300E38D3800E38A3300E38D3800E38C
      3600E38B3600E38A3400E2893200E2873000E2863000E2852E00E2832D00E486
      3000D8782800AC451300C2B8B40000000000912A00008F2700009E3F0300C274
      2300CC802E00CC812E00CF833100D0863300D1883500D38A3700D1842D00EACB
      AB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E6BF9600D1842B00D2893600D1873400CF853200CE823000CD81
      2E00C77B2A00A84E0A008F270000912A0000E8EEE50042AE58000CAA3B0015B1
      430015B245000FB1410076BD8400FFFCFD00FFFFFF00FFFFFF00FFFFFF009AD1
      A60085BC8B00FFFDFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAFE
      FB0054CA790000AB2B0000AE360000AE360000AC340000AA320000A7310000A6
      2F0000A42D00009D2A0026A84500DAE5D50000000000B39B9100D27A3F00E795
      4200E5934100E5934200E5934100E5944200E5934200E5944200E5934100E593
      4200E4913E00E38D3600F1C89800FEFEFE00FEFEFE00FEFEFE00F7DDC000E289
      3200E48D3800E38C3600E38B3600E38A3400E3883100E2873000E2853000E285
      2E00E3842E00BB561900BAABA40000000000EFEFEF00A8857500D9824400E796
      4100E5934100E5934100E5944200E5944200E5944200E5944200E5934200E38C
      3600F0C59300FEFEFE00FEFEFE00FEFEFE00F7DFC200E5934100E38B3400E48F
      3B00E48D3900E38C3600E38B3600E38A3400E3883200E2873000E2853000E285
      2E00E4863000C45D1D00AE94890000000000912A00008F280000AA510B00CA7E
      2C00D0853200D1873400D3893600D58C3900D68E3B00D8903C00D78B3300E6BB
      8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E2B07800D78C3300D78F3C00D68D3A00D48B3800D3883500D186
      3300CD833100B6621600922B000090290000E8EEE50042AF59000FAD41001CB7
      4C001DB94E001EBC51000EAB3D0072B47B00FFFCFC00FFFFFF00FFFFFF00FFFF
      FF00A7D8B20059A9660064AA6E00B7D2B700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFEFB0054CC7A0000AE2D0000B1390000B0370000AE360000AC340000A9
      320000A73000009F2C0025A94600DAE5D50000000000AB8D7E00E08B4600E798
      4500E5954400E5964600E6964600E6964500E6974500E6964500E6974600E493
      4100E4923E00F3D2AB00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7DDC100E28C
      3500E4903C00E48F3B00E38E3900E38C3600E38B3600E3893300E2883100E286
      3000E6893000D16C2500B2988D0000000000E1DEDE00AB7C6200E4914800E697
      4400E5964400E5964600E6964500E6974500E6974600E6964500E6964500E38F
      3B00F0C79500FEFEFE00FEFEFE00FEFEFE00FEFEFE00F8E6D000E6994B00E38B
      3500E4903D00E48F3B00E48E3900E38C3600E38B3600E3893300E2883200E286
      3000E6883000D7732700A68576000000000091290000912A0000B6621700D086
      3400D3893600D68C3900D78F3C00D9913E00DB944000DC964200DB913600E5B1
      7500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FEFDFE00E2A86300DB923900DC954100DA933F00D9913D00D78E3B00D48B
      3800D2893600C2732300973302008F280000E8EEE50041AF5A0014B0470024BC
      550024BE560026BF590027C55D0015B2460074B67D00FEFBFC00FFFFFF00FFFF
      FF00E7F1E8002DC05E001FC1580020AA4700A2C9A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FAFEFB0054CE7C0000B0300000B33A0000B2390000AF370000AC
      350000AB330000A12F0025AA4800DAE5D50000000000AB8B7800E7934800E799
      4800E6994900E6994900E6994900E6994900E6994900E6994900E5954400E699
      4900F6DBBB00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7DEC100E48E
      3A00E4923F00E4913E00E4903C00E48F3B00E48D3900E38C3600E38A3400E388
      3200E58A3100DD7B2A00AE91830000000000E0DDDD00AF806100E9994900E699
      4800E6994900E6994900E6994900E6994900E6994900E6994900E6994900E491
      3E00F1C89700FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FAEDDD00E7A1
      5800E38B3600E4913E00E4903D00E48F3B00E48E3900E38C3600E38A3500E388
      3200E4893100E1802D00A98876000000000090290000932D0000BF702400D792
      4400D78F3B00D9913D00DC954100DD974300DF9A4600E0973F00E4A55700F9EA
      D800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7E3CA00E29F4B00DF984000DE994500DD964200DA933F00D890
      3C00D8934400CA8132009A3804008F270000E8EEE50041B15B0019B44E002CC2
      5D002BC35E002DC561002EC7630030CC68001EB8500075B77F00FFFDFF00E7EC
      E4004AB3650031CC69003BD173003AD4740029B45300A2C9A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FAFEFB0054CF7D0000B3310000B53C0000B33A0000B1
      380000AE360000A3320025AB4900DAE5D50000000000AD8D7900E9974900E69B
      4C00E69A4C00E69B4B00E69B4C00E69B4D00E69C4D00E6974700E79E5300F7E3
      C900FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7DFC200E491
      3D00E5944300E5934100E5923F00E4913E00E4903C00E48E3A00E38D3800E38B
      3500E58B3400E2812D00B093830000000000E0DDDD00B2826100EC9B4B00E69B
      4B00E69A4C00E69B4B00E69B4C00E69B4D00E69B4D00E69B4D00E69B4C00E594
      4200F1C89A00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FCF3
      E800E9AA6500E38C3600E5923F00E4913E00E4903C00E48E3A00E38D3800E38B
      3500E48A3400E6863100AC8B7700000000009028000097330200C77D3100DC9C
      5000DD9B4D00DD984400DF9A4500E29D4800E29B4200E7A85A00FAEDDD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F8E6D000E5A55400E29B4300E09C4700DE994400DE9B
      4B00DE9E5200D08B3E009C3B07008F270000E8EEE50041B25C001DB8540033C7
      660032C8670034CA690035CC6B0037CE6E0039D373002AC15E0062AD6E004DB3
      670034D06E0041D67A0041D5790043D57A0043D97D0030B75A00A3C9A500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FAFEFB0052D07D0000B5350000B73E0000B4
      3B0000B1390000A5340025AC4A00DAE5D50000000000AF907A00EC9B4C00E79D
      5000E69D5000E69D5100E69D5100E69D5200E6994A00E7A75F00F9EBD700FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7E0C300E593
      4100E6974600E5964500E5954300E5934200E5913E00E4913D00E48F3B00E48D
      3900E48D3600E6873200B497850000000000E1DDDD00B5846200ED9E5000E69D
      5000E69D5000E69D5100E69D5100E69D5100E69D5100E69D5100E69D5000E598
      4700F1C99C00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FDF7F100ECB27400E38E3800E5934100E5923F00E4913D00E48F3B00E48E
      3900E48D3600E88A3400AE8E7800000000009028000096310100CB843B00E1A3
      5800E2A55A00E4A55900E4A25000E59F4600EAAF6200FBF0E100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FAEAD600E8A85700E5A14B00E5A65800E4A6
      5B00E2A45900D5944A009D3C09008F260000E8EEE50041B25D0022BC59003BCC
      6E003ACE6F003BCF71003DD173003ED3760040D4780042D87C0036CF6E003DD5
      770047DA800047D9800048DA81004ADA81004CDA82004CDE850037BA6000A5CB
      A800FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3FCF70026C65E0000B83A0000B7
      3E0000B53C0000A8370024AD4B00DAE5D50000000000B4978200EC9D5100E7A0
      5300E79F5300E7A05500E7A05400E69D5000EAAF6D00FCF5EB00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7E1C600E596
      4500E6994900E6994900E6974700E5964500E5944300E5923F00E4913E00E490
      3C00E58F3A00E6883400BCA3940000000000E5E2E200B8896800EDA15400E79F
      5300E79F5300E7A05500E7A05400E7A05400E7A05500E7A05400E7A05400E699
      4A00F2CB9D00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFD00EEBD8600E4913E00E5944300E5924100E4913E00E490
      3C00E48F3A00E88C3600B1917A000000000090290000922B0000CA853F00E5AA
      6100E5AB6000E8AE6400EAAF6200EDB66E00FDF8EF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCF1E200ECB36B00EAAF6300E8AD
      6200E5AB6100D89952009C3B070000000000E8EEE50040B45D0025BF5E0043D1
      760041D2760043D4790044D67B0046D77D0047D9800048DA81004BDD84004CDD
      85004DDD86004EDE870050DE880051DF890053DF8A0055DF8B0054E18D0047C0
      6E00DEEBDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF009EE7B80000B9380000BA
      400000B83F0000AA390024AE4B00DAE5D50000000000BFAA9C00E89B5100E8A3
      5800E7A25800E7A25800E7A35900E6A15500E9AC6600F7E2C900FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7E1C700E699
      4800E69B4C00E69A4B00E6994900E6984800E6964600E5954300E5934100E591
      3E00E6913D00E1843400C6B7AD0000000000F5F5F500B8977F00EDA15600E7A2
      5700E7A25800E7A25800E7A35900E7A35800E7A35800E7A35800E7A35900E69C
      4D00F2CCA000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FCF3E800EDBA8000E5944300E6964600E5954300E5934100E591
      3E00E6913D00E68A3600BCA49400000000009129000090270000C47B3900E9B3
      6E00E9B06600ECB46A00EEB66B00EEBA7700EFC8A600F4D7BD00F8E4D300FBF1
      E800FEF9F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDF8F500FBF0E700F8E2D000F3D5B900EFC7A200EEB87200EEB56A00EBB2
      6800EAB36D00D59551009631020000000000E8EEE5003FB45E0026C261004BD5
      7E0048D67E004AD880004CDA82004DDC85004EDD870050DE890051E08A0053E1
      8C0054E28E0056E28F0057E28F0059E390005AE391005CE392005EE293004EDC
      8600BBE9CA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EAFAF00038CE6F0000BD
      3F0000BB410000AD3C0024AF4C00DAE5D50000000000D4CDC800DD914A00EAA8
      5D00E7A55C00E7A55B00E7A55D00E7A65D00E7A35900E7A15700F1C89B00FEFA
      F500FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7E2C800E69B
      4A00E69D5100E69D4E00E69B4C00E69A4A00E6994900E6974700E5954400E593
      4200E7954100D47E3500DFDBD9000000000000000000C5B5AA00E79A5200E9A7
      5C00E7A55B00E7A55B00E7A65C00E7A65D00E7A65D00E7A65D00E7A65C00E69E
      5200F2CEA300FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00F7DEC100E8A86100E6984800E69A4A00E6994900E6974700E5954400E594
      4200E7953F00DC823600D1C8C30000000000912A00008D240000B6632500EBBB
      7B00EEB76E00EFB97100F2BD7400F3BE7400F2B66700F1B36500F2B46700F4B5
      6C00F6B97200F9D0A200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFC00F8CA
      9700F5B97100F4B56B00F2B36600F1B36400F1B66800F2BD7400F1BC7300EFB8
      6E00EFBE7E00C98140008F260000912A0000E8EEE5003FB55F002AC5670053DA
      860050DA850051DD870053DE8A0054E08C0056E28E0057E3900059E492005AE5
      93005BE694005DE696005FE7970060E7980062E7980063E699005EE5950082EB
      AE0088D09C00EEF3ED00FFFFFF00FFFFFF00FFFFFF00EFFBF4007CE0A20033CE
      6C0000BD3F0000B03E0024B04D00DAE5D50000000000F7F7F700C78A5800EEAC
      6300E7A85F00E8A85F00E8A86000E8A86100E8A86000E8AA6400E9AA6400EDB8
      7C00F9EAD700FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7E2C800E69D
      5000E7A05400E79E5300E69D5100E69C4D00E69A4B00E6994900E6984700E596
      4500EC994500C0845600FDFDFD000000000000000000E7E5E400D48C5000EDAC
      6200E7A85E00E7A86000E8A86000E8A86000E8A86000E8A86000E8A85F00E6A1
      5600F2CFA400FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FDF8F300F1C8
      9700E8A76100E7A25700E69D5000E69C4D00E69A4B00E6994900E6984700E596
      4500EA994500C9804800F4F4F400000000000000000000000000A2420B00E6B4
      7600F3C28000F3BE7600F5C27B00F7C57D00F9C98100FCCC8400FDCE8500FECF
      8600FFCF8300FEC97C00FEF0DF00FFFFFF00FFFFFF00FFFFFF00FEE8CF00FEC7
      7800FFCF8400FECE8500FDCD8500FBCB8300F9C78000F7C47C00F4C07800F3C0
      7B00EFC38700B25C1F000000000000000000E8EEE5003EB65F002FC96C005ADE
      8D0057DD8C0059E08E005AE191005BE493005DE595005FE7970060E7990062E8
      9A0063E99C0064EA9D0066EA9E0067EA9F0069EA9F0063E99C009BF0BF00FFFF
      FF00D0EAD6007BBA8500EDF3ED00FFFFFF00FFFFFF00DEF3E40074DE9B007CE2
      A2002BCC660000B23B0024B14D00DAE5D5000000000000000000C1A89400EFA8
      6200E9AB6400E8AA6400E8AA6300E8AB6400E8AB6400E8AA6300E9AC6700EBB5
      7600ECB37500F4D4B000FEFEFE00FEFEFE00FEFEFE00FEFEFE00F7E3C900E69F
      5300E7A25800E7A15600E79F5400E69E5200E69D4E00E69B4C00E6994900E699
      4800E7934500C5B1A30000000000000000000000000000000000C0987900F0AC
      6500E8AA6300E8AA6300E8AA6300E8AB6300E8AB6400E8AB6300E8AA6300E7A4
      5A00F2D0A600FEFEFE00FEFEFE00FEFEFE00FEFEFE00F8E7D300EDB97E00EBB1
      7000E8A86100E7A05400E79F5400E69E5200E69D4E00E69B4C00E6994900E699
      4800EB974700BFA08A000000000000000000000000000000000091290000D18E
      4D00F6D09A00F7C47D00F9C78000FBCA8300FDCD8600FECF8800FFD18B00FFD2
      8D00FFD38F00FFD28B00FFDAA800FFFFFF00FFFFFF00FFFEFD00FFD59C00FFD2
      8C00FFD38F00FFD28C00FFD08A00FECF8700FCCC8500FAC98200F8C57D00F7CF
      9600E2AC6C009A3604000000000000000000E8EEE5003EB6600032CD710062E1
      95005EE1930060E4950061E6980063E79A0064E89C0066EA9E0067EB9F0068EC
      A1006AECA2006BEDA4006DEDA5006EEDA50069ECA20098F3BF00FFFFFF00FFFF
      FF00FFFFFF00D0ECD8007DBA8600EDF3EC00FFFFFF00B5E1C10074E09D0083E5
      A8007CE2A20014BD520020B04B00DAE5D5000000000000000000EFEDED00D293
      5E00EFB16B00E9AC6700E9AC6800E9AD6700E9AC6800E9AD6800E9AC6700E9AC
      6600EDBA7D00EDB87B00EFBE8A00FCF3EA00FEFEFE00FEFEFE00F7E4CB00E7A2
      5600E7A55B00E7A35900E7A25700E7A05500E79E5200E69D5000E69C4C00ED9D
      4C00C98A5900F6F6F60000000000000000000000000000000000E0DCD800DE97
      5B00EDB16A00E8AC6600E9AC6800E9AC6700E9AC6700E9AC6700E9AC6800E7A8
      5D00F2D2A800FEFEFE00FEFEFE00FEFEFE00F3D0A900ECB27600EDB97E00E8A9
      6200E7A35900E7A35900E7A25700E7A05500E79E5200E69D5000E69B4C00EB9D
      4C00D3894D00EAE8E7000000000000000000000000000000000000000000AC51
      1600F0C68E00FBD49C00FCCB8400FECF8900FFD28C00FFD49000FFD59300FFD6
      9500FFD69700FFD99A00FFD49200FFF2E300FFFFFF00FFEFD900FFD49100FFD8
      9900FFD79700FFD69500FFD59200FFD48F00FFD18C00FDCD8600FCD19400F8D4
      A000C17130008D2300000000000000000000E8EEE5003EB7600037D276006AE4
      9B0066E49A0067E79C0069E99E006AEAA1006BECA2006DEDA4006FEEA60073EF
      A90077EFAB007AEFAD007CF0AE007DF0AF007AF2AF0083D9A100E9EDE600FFFF
      FF00FFFFFF00FFFFFF00D2EDD90082BC8A00DDE7DB0085D59F0083E9AC0087E6
      AB0091E8B3005BD389001EB14B00DAE5D500000000000000000000000000CEC1
      B700EAA56500EDB26D00E9AF6B00E9AF6B00E9B06B00E9AF6C00E9AF6C00E9AF
      6A00E8AC6700EBB67700EDBA7F00EBAD6E00F7DFC500FEFEFE00F7E6CF00E7A4
      5A00E7A75E00E7A65D00E7A45A00E7A25800E7A05500E69E5300EAA05100E192
      4D00D4CBC500000000000000000000000000000000000000000000000000C4AB
      9900EFAC6A00EBB16C00E9AF6B00E9AF6C00E9AF6C00E9AF6C00E9AF6B00E7A9
      6100F2D3AB00FEFEFE00FCF2E700EEB98000ECB17300EDB97D00E8A86100E7A8
      5F00E7A75F00E7A65C00E7A45A00E7A25800E7A05500E69E5300E89F5100E898
      4E00C9B8AC000000000000000000000000000000000000000000902900008F26
      0000CE884500FCDDAF00FFD99F00FFD38E00FFD59400FFD79800FFD99B00FFDA
      9D00FFDBA000FFDCA100FFDB9E00FFE1B500FFFEFD00FFE0AF00FFDB9F00FFDC
      A100FFDA9F00FFDA9C00FFD89A00FFD79600FFD49000FFD79900FEE1B400E2A8
      660097310300000000000000000000000000E8EEE5003EB8610042D8810071E7
      A2006DE8A0006EEAA2006FECA40070EDA60073EFA90079F0AD007FF0B00084F1
      B40089F1B7008CF1B8008EF2BA008FF2BA0090F3BC0081EBAE0076C18700E7EE
      E500FFFFFF00FFFFFF00FFFFFF00DEF3E40065B6760081E3A7008EEBB4008EE9
      B20095EAB60076DD9F0024B35100D9E4D5000000000000000000000000000000
      0000C5AC9800EFAF6F00EDB57100EAB16F00EAB16F00EAB17000EAB16F00EAB1
      6F00EAB16E00E9AF6A00EAB26F00ECB97A00E7A25C00F2C89E00F7E3CB00E7A8
      5F00E8A96200E8A86000E7A75D00E7A55B00E7A35800EAA45700EA9D5700CAB5
      A50000000000000000000000000000000000000000000000000000000000FEFE
      FE00C8A18200F2B37200EBB37000EAB16F00EAB17000EAB16F00EAB16E00E8AC
      6600F4D7B300F7DFC800E8A56200EBB27200EBB57500E8AB6400E8AC6500E8AA
      6400E8A96200E8A86000E7A65D00E7A55B00E7A35800E8A35600EFA15900C3A4
      8B00000000000000000000000000000000000000000000000000000000000000
      00009B370600E5AE6D00FFE6BD00FFDFAB00FFD89A00FFDA9E00FFDDA200FFDD
      A500FFDFA700FFE0A900FFE1AC00FFDEA800FFE0AF00FFDFA800FFE1AB00FFE0
      A900FFDEA700FFDDA400FFDBA000FFD99B00FFDDA700FFE7BF00F4C88A00AB4E
      150000000000000000000000000000000000EAEFE70040BA640052E08E0077EA
      A70073EAA50075ECA80076EEAA007BF0AD0083F1B2008AF1B80091F2BB0096F3
      BF009BF3C1009DF3C3009FF4C400A0F4C4009FF3C400A0F6C60090EFB8007BC2
      8B00E6EDE500FFFFFF00FFFFFF00C2DCC40088E7AE0093F0BA0094ECB80095EC
      B8009AEBBA0088E4AD002AB65500DBE6D7000000000000000000000000000000
      000000000000C6AD9800F0B17500EFB97700EAB57400EAB47400EAB47300EAB3
      7300EAB37100EAB27100EAB16F00EAB16D00EBB67600E7A15A00E9AB6800E9AE
      6900E8AB6500E8AA6300E8A86100E7A75E00EDA85D00EA9F5E00CCB6A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F800CCA58600F3B67700EDB87400EAB47300EAB47300EAB47300EAB4
      7200ECB67900E79F5A00EBB47400EAB37100E9AE6B00E9AF6B00E9AD6900E9AC
      6700E8AB6500E8AA6300E8A86000E7A75E00EBA85C00EDA35E00C7A68C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A8491100F0BF7E00FFEBC500FFE7BF00FFE0AB00FFDFA700FFE0
      AB00FFE2AF00FFE3B100FFE4B200FFE4B300FFE3AF00FFE5B400FFE4B200FFE3
      B000FFE1AD00FFE0A900FFE0AA00FFE6BB00FFECC900FAD39700B86224000000
      0000912A0000000000000000000000000000EFF3ED0046BF6B0067E99F007CEB
      AB007BEDAB007CEFAE0081F0B1008AF1B70092F2BD009AF3C100A1F4C500A6F4
      C800ABF5CB00ADF5CD00B0F5CE00B0F5CE00AFF5CE00ADF5CC00ADF8CE009CF0
      C00080C48F00E2EAE000B9D3B9006CC6870098F3C0009AF0BE009BEFBE009DEE
      BD00A0EDBF009BECBC003CBD6400E1EADE000000000000000000000000000000
      00000000000000000000CFC0B300E1AB7A00F1BA7C00EDB97800EBB87700EBB7
      7600EBB67600EBB57400EBB47300EAB37100EAB16F00EAB37100E9AF6B00E9AE
      6A00E9AD6800E9AC6600EAAC6400EFAC6600DFA37100D2C6BC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE00CCB39E00ECB07700F2BC7C00ECB97700EBB77700EBB6
      7600EAB37100EBB67500EAB47300EAB27100EAB27000EAB16E00E9B06C00E9AE
      6A00E9AD6800E8AC6600E9AC6300EEAC6400E5A26700CAB6A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000912A000000000000A7491300EDB77500FFEEC400FFEFD200FFEAC500FFE7
      BA00FFE6B600FFE6B600FFE7B800FFE8B900FFE8BA00FFE8B900FFE7B800FFE6
      B700FFE7B900FFEAC300FFEED100FFF1CE00F9CF9000B7602400000000000000
      000000000000000000000000000000000000F7F9F70065C980007EF1B10081ED
      AF0082EFB10086F1B4008FF2BA0098F3C000A1F4C500A8F5C900AFF5CE00B4F6
      D100B9F7D400BCF7D600BEF7D700BEF7D700BDF7D600BBF6D500B8F6D300B7F9
      D500A8F3C80073BC820079CA9000A3F8CA00A0F4C400A1F2C300A3F1C300A4F0
      C300A5EEC200B0F5CE0068C68000F2F5F1000000000000000000000000000000
      0000000000000000000000000000E9E6E300DBBA9F00E7B07E00EFBA7D00EEBB
      7B00EDBA7A00ECB97700EBB87600EBB67500EBB57300EAB47200EBB37000ECB2
      6E00EEB36E00F0B16F00E7AB7400D4B59C00ECEAE90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DAD3CC00D4AC8A00EEB67D00F2BD7F00EDBA
      7B00ECB97900EBB87700EBB77600EBB67500EBB57300EAB37100EAB27000EBB1
      6D00ECB16C00EDB06C00E9A86B00D9AF8F00DFDAD50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C370700D9965300FFE3AE00FFF6D800FFF5
      DE00FFF2D900FFF1D200FFEFCE00FFEFCD00FFEFCD00FFEFCE00FFF0D200FFF2
      D800FFF5DE00FFF7DD00FFEDBE00E7AE6C00A94B150000000000000000000000
      00000000000000000000000000000000000000000000A2D1A7007DF5B2008DF0
      B70088F1B60092F3BC009CF4C200A5F4C800ADF5CD00B5F6D200BCF7D600C2F8
      D900C6F9DC00C9F9DE00CBF9DF00CBF9DF00CAF9DE00C8F8DD00C4F8DB00C0F7
      D800BDF8D700B8FAD500B4FAD300ACF5CD00A8F4C900A8F4C800AAF2C800A9F1
      C700B3F1CC00B0F9D0009BCEA000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFE9E400E2C8B400E2B7
      9300E7B48200ECB77E00EBB77C00EBB77900EAB67800EBB47700ECB27800E4AE
      7A00DAB08C00D4BFAD00EFEAE600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4D8CF00D4B69B00E4B4
      8800EDB77F00ECB87D00EBB87A00EBB87900EBB77700EAB57600EAB27500E7AE
      7500E1AF8200DFBEA400E3DBD300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B2581F00E4AA6B00FFE0
      AD00FFF7D500FFFDE500FFFEEB00FFFDEC00FFFDED00FFFEEC00FFFEE900FFFB
      DB00FFEABB00EDBB7E00BF6C3000932B00000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F2F6F1006FD58F00A7FE
      D000A1F5C6009EF4C300A6F4C900B0F6CE00B8F6D300C0F7D800C8F8DD00CEF9
      E100D3FAE400D6FAE600D9FBE700D8FBE700D6FBE600D3FAE400D0F9E200CCF9
      DF00C7F8DC00C1F8D900BCF8D600B7F6D300B2F6D000AFF6CE00B3F4CF00C5F6
      DA00D1FFE80074D49100EFF4EE00FEFEFE000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBF8
      F700F4E9E100ECD9CB00EFD4C200F1D3BE00F2D3BF00EAD0BE00E6D4C800EFE6
      E000FAF9F8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F0
      EC00E6D7CB00EAD0BC00F0CCB400F0CBAF00EFCBAF00F0CCB300ECD1BF00EBDC
      D100F4F0ED000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A747
      1100C5763A00DDA16600EBBC8400F6D09B00F6D29D00EFC38D00E1A96F00CD84
      4700AE531B00932B000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE0000000000E7EFE5007ED8
      9800A0FCC900C5FFE300CDFFE800D3FFEC00D9FFEF00DEFFF200E3FFF600E7FF
      F800EAFFFA00E9FFFA00E9FFFA00EAFFFA00E9FFF900E8FFF900E3FFF500DFFF
      F300DDFFF200DBFFF000D9FFEF00D5FFEC00D0FFE900D0FFE900CFFFE800A8F9
      CB0076D39100E5EFE40000000000FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000922900009831010098320100942C0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE0000000000FEFE
      FE00C5E0C6009FD4A800A0D0A500A0D0A5009BD0A3009BD1A3009BD1A3009BD1
      A3009BD1A40098D1A20097D1A10098D1A20098D1A10098D1A10095D09F0093D0
      9E0094CF9E0094CF9D0094CF9D0092CD9B0090CD9A0091CC9A0094D09F00BEDD
      C100FCFDFC0000000000FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00FAFAFA00FAFAFA00FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A1A1A1007A7A7A00EDEDED0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000073A7
      9500649E8A00EDF2F00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00FAFAFA00FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500DCDCDC00C2C2C400AEAEB400A8A8B000A8A8B000B3B3B700CACACA00E5E5
      E500FBFBFB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B7B7B7006D6D6D00323232004C4C4C00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000709D8E00056D
      480000624100ACBDB80000000000FBFBFB00FDFDFD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FBFBFB00E3E3E300C3C3C300BCBCBC00D9D9
      D900F8F8F8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00D3D3D3008E8EA000504E
      880026238700120D8C0007029000060193000601930009048E0018138B00322F
      860062618C00A5A5AE00E6E6E600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C9C9C900717171004E4E4E00181818000C0C0C0030303000C7C7C7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD00FDFDFD00F7F7F700639081000A774F00107C
      5300006241009DB0AA00F7F7F700F1F1F100F7F7F700FBFBFB00FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE0090909000AAAAAA00B7B7B7009393
      9300B5B5B500EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D9D9D900727193001F1C890006009B000600
      A3000600A2000400A00002009D0002009C0002009D0002009E000600A1000600
      A3000600A20006019400353287009595A500EFEFEF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D90072727200585858001B1B1B001B1B1B0013131300040404001B1B1B00ACAC
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00FCFCFC00F3F4F3005E8D7E000B7C520016895B001281
      5600006241008BA19A00EDEDED00E7E7E700EDEDED00F4F4F400FAFAFA00FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00CDCDCD0098989800F0F0F000F8F8F800F7F7F700FFFF
      FF00B6B6B6009B9B9B00DFDFDF00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE00A3A3AE00282589000600A1000600A20002009B000000
      9A000000A1000612AB000F1FB1001425B5001424B4000E1BAE00020CA7000000
      9E0000009A0004009D000600A400060099004A488A00CDCDCE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8E8E8007777
      770061616100212121001D1D1D001C1C1C00626262007C7C7C00272727000B0B
      0B008C8C8C00FAFAFA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00FEFEFE00F3F3F300548877000E835600198F5F00188D5F001689
      5B00006442006C8F8400E3E3E300DDDDDD00E4E4E400ECECEC00F3F3F300F9F9
      F900FDFDFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAFAFA00C8C8C80099999900F8F8F800FCFCFC00F9F9F900F5F5F500F7F7
      F700FFFFFF00DCDCDC008E8E8E00C4C4C400F2F2F20000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFB0081819C000A0595000600A300040099000206A200122EBD003158
      D600507AE600658EEE007299F200799EF2007B9FF2007699F0006A8DEA005274
      DF002F4DCB000C1EB10000009D0004009C000600A40024218C00B7B7BE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F3007F7F7F006868
      680029292900202020001313130082828200FFFFFF00FFFFFF00E6E6E6004D4D
      4D00000000006C6C6C00EFEFEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F2F2F20052877600118759001D9663001B9362001B9363001A90
      600001674400447A6800D7D6D600D5D5D500DCDCDC00E4E4E400ECECEC00F3F3
      F300F9F9F900FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F900C8C8C8009D9D9D00FFFFFF00FFFFFF00FBFBFB00F6F5F500EFEDED00B7B6
      B600EFEEEE00FFFFFF00FCFCFC00A1A1A100A0A0A000E1E1E100FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000082829E0006009B0006009E000204A0001137C600326BE9004F86F5005489
      F4004980F1003B75EE00306CEC002D6AEB002F69EA00386EEA004879EC005C87
      EE006892F1005E88EC00375DD8000C21B30000009B000600A3001A159000BFBF
      C500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFC00898989006C6C6C003131
      3100232323001C1C1C00575757009E9E9E00DFDFDF00FFFFFF00FFFFFF00F8F8
      F80073737300020202004C4C4C00DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F3004D857200148E5E00209C68001F9966001E9966001E986500239B
      6900096E4A0019674D00C2C4C300CFCECE00D3D3D300DBDBDB00E3E3E300ECEC
      EC00F3F3F300F9F9F900FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900C3C3
      C3009E9E9E00FFFFFF00FFFFFF00FEFEFE00FBFAFA00E7E5E500ACABAB00DBDA
      DA00A7A6A600B2B1B100F9F9F900FFFFFF00CBCBCB008B8B8B00C5C5C500F2F2
      F20000000000000000000000000000000000000000000000000000000000A9A9
      B6000904980006009D00041AB0001557E6002E76F8002E72F3001963F0000458
      EE000053EC000051EB000050EA00004FE900004FE800004DE700004CE600004D
      E6000E54E6002D65E700497BEC004476EB001A41CC000206A1000600A2002926
      8E00E1E1E1000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000989898006C6C6C003B3B3B002626
      26001F1F1F004F4F4F00CDCDCD00C5C5C50091919100C8C8C800FFFFFF00FFFF
      FF00FFFFFF009B9B9B001010100030303000C7C7C70000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E3E8
      E60045836E001892610023A16B00219E6900219E6900219E69001F9D680038AA
      7A0024846000005A3B0099A6A200CECCCD00CCCCCC00D2D2D200DBDBDB00E5E5
      E500EDEDED00F4F4F400F9F9F900FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900C2C2C2009F9F
      9F00FFFFFF00C0D1CB007FA3970060907F0058877700577B6E00B4C5BF00E4E4
      E400E3E3E300D2D1D100A3A2A200E8E7E700FFFFFF00F1F1F1009A9A9A009F9F
      9F00E1E1E100FBFBFB0000000000000000000000000000000000E4E4E4002623
      910006009F000624B900095FF2001468F7000B60F3000059F1000058F1000058
      F0000058EF000057EE000056ED000055EC000054EB000054EA000053E9000052
      E800004EE600004CE600004FE6001F5EE700316CEC00184CD900040CA5000600
      A20065639800FEFEFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A7006C6C6C0044444400292929002424
      240043434300C7C7C700D8D8D800D2D2D200CDCDCD009A9A9A00B2B2B200FCFC
      FC00FFFFFF00FFFFFF00C0C0C000262626001B1B1B00ACACAC00000000000000
      0000000000000000000000000000000000000000000000000000000000008BB7
      A900168C5D0026A86F0024A26C0024A36C0024A36C0024A36C0020A16A003BAF
      7D0052A78400005C3C004E7E6E00CAC8C900C6C6C600CBCBCB00D5D5D500DFDF
      DF00E8E8E800EFEFEF00F5F5F500F9F9F900FDFDFD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700BFBFBF009E9E9E00FEFE
      FE0099B6AC002F715A00045D40000761430007614300045C400027695200809D
      9300DBDBDB00E9E9E900DDDDDD009C9B9B00D2D0D000F0F0F000FAFBFB00C0C0
      C000898A8A00C5C5C500F5F5F5000000000000000000000000008181A4000600
      A0000923B7000F64F5000C64F700085FF300045EF300005BF3000055F2000054
      F100005AF1000059F0000058EF000057EE000056ED000056EC000055EC000051
      EA000050E900004DE800004EE700004FE6000852E600165CEA000845D9000409
      A4000C079700C9C9CE0000000000000000000000000000000000000000000000
      00000000000000000000B9B9B9006E6E6E004E4E4E002C2C2C002B2B2B003C3C
      3C00BFBFBF00E1E1E100D6D6D600D4D4D400D3D3D300D4D4D400A9A9A900A0A0
      A000F1F1F100FFFFFF00FFFFFF00DEDEDE00444444000B0B0B008C8C8C00FAFA
      FA000000000000000000000000000000000000000000000000000000000070A5
      94001E97640028AA710027A8700028A8700028A8700028A8700026A76F002AA9
      72007BC9A70021775800045C3D00A3ACA900C8C7C700C6C6C600D0D0D000D9D9
      D900E3E3E300EBEBEB00F1F1F100FBFBFB00F9F9F900F1F1F100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F800BBBBBB00A3A3A300F5F8F7005288
      750006644400217B5C00378A6C003D8D70003F8D71003D8A6F00287B5F000863
      4400487E6C00DCDFDE00F4F4F400F2F2F200A2A2A20097959500D9D7D700EEED
      ED00DFDFDF0095959500C4C4C4000000000000000000F1F1F1002A2794000811
      AC001562EF001469F7001164F4000F63F400005BF4000E61F400A2BFFA007EA6
      F8000053F2000059F200005BF1000059F1000059F0000058EF000051ED000B57
      ED00B1C6F800A6BEF7000E55EA00004BE8000051E8000050E7000255EB00043A
      CF000600A400706EA00000000000000000000000000000000000000000000000
      000000000000CCCCCC006F6F6F0057575700303030003131310034343400B6B6
      B600EBEBEB00DDDDDD00DBDBDB00D8D8D800D6D6D600D4D4D400D7D7D700B9B9
      B90098989800E0E0E000FFFFFF00FFFFFF00F2F2F20069696900010101006C6C
      6C00EFEFEF0000000000000000000000000000000000000000000000000070A5
      9300269B6A0034B07A0034AE790035AF790036AF7A0035AF790034AE79002BAA
      73006CC79E0083BDA70000613D0036735F00C4C4C400C8C8C800CECECE00D9D9
      D900E1E1E100E8E8E800F8F8F800F2F2F200558A79006C978800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7F7F700BBBBBB00A3A3A300FDFEFD0067978700076C
      48001D855D0020875F001B825B001F845E001E815C00177B56001F7D5B00237C
      5D000A6747005F907F00EBECEC00F9F9F900FEFFFF00E1E1E10092929200BCB9
      B900CDC9C900D3D2D2009B9B9B000000000000000000C0C0C90004019B00154D
      D9001B70FA001869F4001668F400025FF3002F74F500C7D9FC00FFFFFF00FFFF
      FF0097B8FA000259F3000058F300005CF300005BF2000052F1001B61F100C1D3
      FB00FFFFFF00FFFFFF00CCD9FB00356EEE00004DEA000053E9000052E8000255
      EB00041FBC002F2A9600F5F5F500000000000000000000000000000000000000
      0000DCDCDC00727272005F5F5F0034343400353535003232320050505000E7E7
      E700E9E9E900E1E1E100DFDFDF00DDDDDD00DBDBDB00D8D8D800D6D6D600D8D8
      D800C9C9C90098989800CBCBCB00FFFFFF00FFFFFF00FFFFFF00888888000E0E
      0E004C4C4C00DEDEDE00000000000000000000000000000000000000000085B1
      A3002C9A6D0044B8850043B5830044B6830044B6840044B6830043B583003FB4
      800040B48100BBE6D3005B9F860000613B00698C8000DBDADA00D4D4D400D9D9
      D900E2E2E200F6F6F600D5DAD80036786300005F3E00387D6600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F600B6B6B600A3A3A300FFFFFF00B7CEC600096B4800178A
      5D0016895B000B83530046A17D00EEF6F300EEF6F300499D7D00017448000D76
      4F000E744F0005634200ADC5BD00F4F4F400FBFBFB00FFFFFF00F6F7F700A2A2
      A200B1AFAF00BEBEBE00A8A8A80000000000000000008F8FAF000C1DB8002270
      F6001F6EF6001D6CF5000F65F400528BF700ECF2FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B7CDFC001864F4000058F3000054F2002E6FF400D3E0FC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F3F7FE003F77F000004FEB000054EB000056
      EC000245DC000E0E9F00D7D7DB0000000000000000000000000000000000EBEB
      EB0078787800666666003A3A3A00373737003737370039393900404040008E8E
      8E00ECECEC00ECECEC00E4E4E400E2E2E200DFDFDF00DDDDDD00DBDBDB00D8D8
      D800D9D9D900D4D4D400A1A1A100B6B6B600FDFDFD00FFFFFF00F8F8F8005A5A
      5A001919190032323200DADADA0000000000000000000000000000000000B3CE
      C400278E660053C1900050BC8C0051BC8D0052BD8D0051BC8D0050BC8C004FBB
      8B0045B7850072C9A300DAEFE600338B6A0000633E008DA79E00FCFCFC00F5F5
      F50000000000B6C3BE0012664A00016241001B885D001B735400E8F0ED000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F6F6F600B4B4B400AAAAAA00FFFFFF00FFFFFF006FA39200188B5D001C95
      6300128F5C00078A540043A67E00FFFFFF00FFFFFF004BA58100007B4900067B
      4E000D7A50000B724C00689D8C00F7F7F700FCFCFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C500D3D3D30000000000000000007474A2001A47D9002878
      FB002370F500226FF500196AF5004F88F700D5E2FC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D2E0FC002A70F5003E7CF600E3ECFD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC5FB00246AF1000054ED000056EC000056
      EC000256ED00041DB700BEBEC900000000000000000000000000F5F5F5008080
      80006A6A6A0040404000383838004141410044444400373737003E3E3E003E3E
      3E0076767600DFDFDF00F1F1F100E6E6E600E4E4E400E2E2E200DFDFDF00DDDD
      DD00DBDBDB00DADADA00DBDBDB00B0B0B000A6A6A600F5F5F500FAFAFA005A5A
      5A00333333002424240077777700F0F0F000000000000000000000000000EAF1
      EF003C8F71005DC395005EC396005FC396005FC396005FC396005EC296005CC2
      94005AC193004EBB8B009DDCC000C1E2D40020845E000067410087ADA1000000
      00008CB1A400025F3F00066B47001B96620040B28000267E5E00C2D7CF000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F600B4B4B400AAAAAA00FFFFFF00FFFFFF00FFFFFF0066A99000209D6800249F
      6B005FB9930062B9940087C9AE00FFFFFF00FFFFFF008CC8AF005CAF8D0061AF
      9000248D64000E7D52005F9E8800FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D0D0D000D3D3D3000000000000000000000000007275A4002764EF002B79
      F9002973F6002572F6002370F500397DF6005189F600B9CDFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7EFFE00EEF4FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFEFF009AB9F9003F7DF5001461F1000058F0000058EF000057
      EE00005BF2000436CE00B9B9C6000000000000000000FDFDFD008B8B8B006C6C
      6C004747470039393900515151007B7B7B0080808000616161003A3A3A003E3E
      3E004040400061616100CACACA00F5F5F500E9E9E900E6E6E600E4E4E400E2E2
      E200DFDFDF00DDDDDD00DBDBDB00DEDEDE00C2C2C200ABABAB00848484003333
      3300373737003E3E3E008D8D8D00F4F4F4000000000000000000000000000000
      000084B5A40052B289006FCDA2006BC99F006CC99F006BC99F006AC99E0069C8
      9D0066C79C0062C599005BC19400A6E0C600A1D5BF001E855D00026C46002578
      5B0002664300168158002BA7710024A86F0041B382004D9B7D0091B6A9000000
      0000000000000000000000000000000000000000000000000000F5F5F500B4B4
      B400A8A8A800FFFFFF00ECECEC0084848400828282003F886B0022A56C0030AA
      7500F5FCF900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004EA883000C83540065A88F00FDFDFD00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00D5D5D50000000000000000000000000000000000767FAB002F74FA002F7A
      F7002D76F6002B75F6002974F6002471F6004383F7004984F5009DBAF800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFBFE0086ABF7003C7CF5001464F400005AF300005BF200005AF1000059
      F100005CF3000246E000BABBC70000000000FCFCFC009B9B9B006C6C6C004E4E
      4E003D3D3D00515151007C7C7C0074747400686868007D7D7D006E6E6E004040
      40003E3E3E004444440052525200AFAFAF00F5F5F500EEEEEE00E8E8E800E6E6
      E600E4E4E400E2E2E200DFDFDF00DEDEDE00E7E7E700898989002F2F2F003A3A
      3A003F3F3F007979790000000000000000000000000000000000000000000000
      0000E1EDE9003B9873007CD3AB0078CFA80078CFA80078CFA80077CFA70075CE
      A60073CDA40070CBA2006AC99E0066C69B0097DABC0088CDAF00248C63000A76
      4D002C986C0042B7840039B27D002CAA740036B07B0076B99E005D9784000000
      00000000000000000000000000000000000000000000F6F6F600B2B2B200AAAA
      AA00FFFFFF00E7E7E70079797900BEBEBE00BFBFBF0062A3880035B07A003DB2
      8000BAE1D100D8EDE400DAEEE600FEFFFE00FFFFFF00DDF0E800D8EEE500D4EC
      E20041A77C00148E5C0076B69D00FFFFFF00FFFFFF00FFFFFF00CECECE00D5D5
      D50000000000000000000000000000000000000000007884AF00337BFE00337C
      F7003179F6002F79F6002E77F6002B75F6002471F600397EF7003177F5007CA3
      F600EFF3FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6ED
      FD006494F500226CF4000F64F400045EF300085FF300045EF300025DF300005C
      F200005DF500024EE700BABCC80000000000D2D2D2006E6E6E00565656004040
      4000505050007B7B7B00787878006A6A6A0093939300C7C7C700BFBFBF008484
      8400494949003E3E3E00474747004C4C4C0093939300EEEEEE00F4F4F400EBEB
      EB00E9E9E900E6E6E600E5E5E500ECECEC009F9F9F003A3A3A003C3C3C004141
      41006E6E6E00FAFAFA0000000000000000000000000000000000000000000000
      0000000000007DB5A10066BE98008ADAB50083D5B00082D5B00081D4AF0080D3
      AE007ED2AC007BD1AA0077CFA70072CCA4006BC99F007ED2AC006EC69F0049B1
      840057C192004DBB8A0043B583003AB17D002FAD760091CEB50043877000FEFE
      FE0000000000000000000000000000000000FBFBFB00BCBCBC00ABABAB00FFFF
      FF00E9E9E90076767600B2B2B200B0B0B000B6B6B6008EAEA1004AB5860054BF
      90004FB98B0058BD91006BC49D00FCFEFD00FFFFFF0062BF970038AD7B002BA6
      7100209E690020986600BCDDD000FFFFFF00FFFFFF00CCCCCC00D5D5D5000000
      000000000000000000000000000000000000000000007986B100387EFE00377F
      F700357CF700337CF700327AF6003079F6002E78F6002975F6002974F6001466
      F300BDD0FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1D3
      FB000F64F3000660F4001164F4001164F4000E62F4000C61F4000860F400065E
      F3000260F7000251EB00BDBFCB0000000000D9D9D900626262004A4A4A005151
      51007A7A7A007C7C7C006E6E6E0092929200D0D0D000CFCFCF00D1D1D100CCCC
      CC00999999005858580040404000484848004C4C4C007B7B7B00DFDFDF00F9F9
      F900EDEDED00EBEBEB00F3F3F300AFAFAF00404040003E3E3E00444444006868
      6800F2F2F2000000000000000000000000000000000000000000000000000000
      000000000000F0F7F400479F7C008ED8B60099DFBF0093DCBA0091DBB9008EDA
      B7008BD8B50088D7B30083D5AF007ED2AC0078CFA7006FCCA2006DCAA00068C9
      9E005EC3960056BE91004EBB8B0045B6840032AE770091D4B700488B7400E2EC
      E80000000000000000000000000000000000F2F2F200A4A4A400FFFFFF00E9E9
      E90073737300B0B0B000AFAFAF00B6B6B600BBBBBB00BEBFBE0070B296006FCB
      A2006DCAA00062C6990080D1AD00FFFFFF00FFFFFF0073C9A30036B07B0030AC
      760027A76F0079C2A300FDFEFE00FFFFFF00CBCBCB00DCDCDC00000000000000
      000000000000000000000000000000000000000000008994B900397EFC003C83
      F7003A80F700387FF700367DF700337CF700337BF6002874F6002F78F600B9D0
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CADAFC003076F6000660F4001567F4001266F4001164F4000F63F4000C62
      F4000963F7000952E500D2D3DA000000000000000000BBBBBB00555555006F6F
      6F00818181007171710092929200CFCFCF00CECECE00CCCCCC00CCCCCC00CECE
      CE00D1D1D100ACACAC006969690045454500474747004F4F4F0069696900CACA
      CA00FDFDFD00FDFDFD00BCBCBC0047474700404040004747470062626200E8E8
      E800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C9E2D80049A58000A9E5C900AEE8CC00A9E4C800A8E4
      C800A6E3C600A4E1C5009FE0C2009ADDBF0093DABA008BD7B40081D2AD0076CE
      A6006BC89E0060C4970056BF90004DBA8A003CB37E0078CDA70063A18B00BAD1
      C80000000000000000000000000000000000F1F1F100CFCFCF00F4F4F4006F6F
      6F00ACACAC00ADADAD00B4B4B400B9B9B900BDBDBD00C2C2C200C1C6C40074BE
      9E0082D4AF0084D6B0007ED0AB008DCCB1008FCDB30069C59C0056BF900047B7
      86006FC49F00F6FBF900FFFFFF00CCCCCC00DDDDDD0000000000000000000000
      00000000000000000000000000000000000000000000B7BBCC003674F4004287
      F9003E83F7003B82F7003A80F700397FF7002D77F7004184F700CCDCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E1EBFD004C87F7000460F4001869F4001667F4001466F4001265
      F4001167FA00245BD300F2F2F200000000000000000000000000DDDDDD007676
      76008181810096969600CDCDCD00CECECE00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00D1D1D100BEBEBE00828282004E4E4E0047474700515151006161
      6100A1A1A1009F9F9F004F4F4F00434343004A4A4A005A5A5A00DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BEDDD1004DA98300ACE4CA00BDEED700B4E9
      D000B4E8CF00B2E8CE00AFE6CD00ACE5CB00A8E3C800A4E0C5009DDDC10095DA
      BB008BD6B4007FD0AB006FC9A1005EC296004BB989005DC3960073B59C0089B2
      A3000000000000000000000000000000000000000000000000009B9B9B00A7A7
      A700ABABAB00B2B2B200B7B7B700BCBCBC00C0C0C000C6C6C600CBCBCB00CECF
      CF009DC9B6008ED3B3008BD8B50083D6B0007CD2AB0075CEA5007ECEAA00B3E0
      CC00FEFFFE00FFFFFF00CDCDCD00DDDDDD000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEDEE00396AD900488D
      FD004285F7004184F7003F83F700327CF700548FF700DCE7FD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC3F700A1BAF600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F6FE006A9BF8001166F5001969F5001969F5001668
      F4001569FD005E7ABF000000000000000000000000000000000000000000F7F7
      F7009D9D9D00CECECE00D4D4D400CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00D1D1D100BEBEBE00969696008D8D8D005A5A5A00494949005353
      53005353530049494900484848004C4C4C005A5A5A00D4D4D400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D4E9E10052AA8600A0DCC100C8F2
      DE00BEEDD700BDECD600BAEBD400B7E9D200B3E7CF00AEE5CC00A9E2C800A2DF
      C3009BDCBE0093D9B9008AD4B3007ECFAB006EC8A00062C499007AC3A4005997
      83000000000000000000000000000000000000000000CECECE0095959500A6A6
      A600AEAEAE00B4B4B400B9B9B900BEBEBE00C3C3C300C8C8C800CDCDCD00D2D2
      D200D7D7D700BDD6CB00ACD8C400A9DCC400A8DCC400B1DECA00D3ECE100FFFF
      FF00FFFFFF00CDCDCD00DEDEDE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007188C100468A
      FF004789F7004486F7004184F700659AF800EFF5FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A5BDF600407DF2003A7BF20093B0F400FAFBFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006A9AF700226FF5001B6BF5001D6E
      F7001561F500BABFCF0000000000000000000000000000000000000000000000
      000000000000BCBCBC00C2C2C200D6D6D600CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00D0D0D000C3C3C300757575005A5A5A0084848400A2A2A200616161004B4B
      4B004D4D4D004D4D4D004F4F4F0058585800C9C9C90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F6FAF90058AE8B0097D6
      BA00D0F5E300C7F0DC00C4EFDB00C1EED900BEECD600B9EAD300B3E7CF00ADE4
      CB00A6E0C6009EDDC00095D9BA008BD4B3007FCFAC0073CAA30080CDAB003D8B
      7000EAF1EE000000000000000000000000000000000000000000CECECE00BBBB
      BB00BCBCBC00B5B5B500BCBCBC00C1C1C100C6C6C600CBCBCB00D0D0D000D5D5
      D500DADADA00DFDFDF00E4E4E400E9E9E900EEEEEE00F7F7F700FFFFFF00FFFF
      FF00CECECE00E5E5E50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DADBE1003771
      EA004F92FC004789F700498BF80073A0F600C4D3F700FFFFFF00FFFFFF00FFFF
      FF00FCFCFE0096B2F400588DF4004787F7004084F700538BF4007CA0F200EFF2
      FC00FFFFFF00FFFFFF00FFFFFF00ABC0F5006394F400337AF600216EF5002272
      FE004B74CE00FEFEFE0000000000000000000000000000000000000000000000
      00000000000000000000D8D8D800B1B1B100D8D8D800CECECE00CCCCCC00CFCF
      CF00C8C8C80081818100666666005F5F5F00AAAAAA00CACACA005C5C5C005050
      5000515151005252520056565600BBBBBB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C1E3D4003BA6790083D0
      AE00D7F7E800D0F4E200CDF2E000CAF1DF00C7EFDC00C2EED900BDEBD600B7E8
      D100B0E5CD00A8E2C8009FDEC10095D9BB008BD4B3007DCEAA007DCFAA00338E
      6B00C5DAD3000000000000000000000000000000000000000000000000000000
      0000C6C6C600D3D3D300C8C8C800C3C3C300C9C9C900CECECE00D3D3D300D8D8
      D800DDDDDD00E2E2E200E6E6E600ECECEC00F5F5F500FEFEFE00FFFFFF00CECE
      CE00E5E5E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008E9E
      C7004487FF005191F900498BF7004D8DF7006294F50096B2F300F7F9FD00FBFB
      FE0085A6F200568DF5004889F700377FF700377EF7003F84F700528CF6006390
      F100E2E9FB00F7F8FD0084A5F2005288F400397EF7002572F6002A77F9002166
      ED00D2D5DD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F2F2F200A9A9A900D3D3D300D3D3D300C5C5
      C5008C8C8C007171710063636300A1A1A100DADADA00898989004F4F4F005454
      54005555550059595900B0B0B000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094D0B70042B08000A0E0C200D8F8
      E800D9F8E900D7F7E700D5F6E600D2F4E400CFF2E200CBF1DF00C6EEDB00C0EC
      D800BAE9D300B2E6CE00A9E2C800A0DEC20095D9BA0089D3B20081D2AE0043A1
      7B0093BEAE000000000000000000000000000000000000000000000000000000
      000000000000D2D2D200C6C6C600D9D9D900D4D4D400D0D0D000D5D5D500DBDB
      DB00E0E0E000E4E4E400EAEAEA00F3F3F300FDFDFD00FFFFFF00D1D1D100E6E6
      E600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE006686CE004C8FFF005392F9004B8CF8004F8FF900538DF6006C94F0006B94
      F0004B87F600478AF8003F84F7004084F7003F83F7003A80F7003B82F7004585
      F7004D82F0005987EF004281F500387FF7002B76F600317BF800226EFD00A2B0
      CC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4B4B400C5C5C500BEBE
      BE00686868006464640098989800DADADA009393930052525200575757005757
      57005D5D5D00A4A4A40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5D9C30066C49B00CAF3DF00EAFFF400E3FC
      EF00DFFAED00DEF9EC00DCF8EA00D9F7E800D6F5E600D3F4E400CEF2E000C8EF
      DD00C2ECD800BBE9D400B2E6CE00A9E2C8009FDDC10093D7B9008AD5B30061B8
      930074AD99000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D1D1D100C7C7C700E2E2E200E1E1E100DEDE
      DE00E2E2E200E7E7E700F1F1F100FCFCFC00FFFFFF00D4D4D400E6E6E6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F8006286D2004C90FF005695FA004F8FF8004F8FF9004889F7003F84
      F600498CF8004588F7004587F7004486F7004285F7004184F7003E83F7003C82
      F700377EF700357CF600397FF700357CF6003780FB002572FD0094A7CF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE00B2B2
      B200BDBDBD009B9B9B00D7D7D7009B9B9B0056565600595959005A5A5A006060
      6000999999000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EC59F00B7EAD200DEF9EC00DFF9EC00E6FC
      F100EBFFF500ECFFF500EDFFF500ECFFF500E8FDF200E2FAEE00DDF8EB00D6F5
      E600CEF1E000C5EDDB00BCEAD500B2E5CE00A7E0C7009CDBBF0098DCBD005EB3
      8F008DBDAB000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1D1D100C8C8C800EAEA
      EA00F0F0F000F1F1F100FDFDFD00FFFFFF00D7D7D700E6E6E600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC007F99CD003F84FF005798FF005594F9005090F8004F8F
      F8004D8DF8004C8CF700498AF700478AF7004688F7004587F7004386F7004184
      F7003F83F7003E83F7003F84F8003983FF003677EE00B0BCD200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECEC
      EC00A6A6A600D3D3D3009E9E9E005A5A5A005D5D5D005E5E5E00646464009191
      9100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B9E3D00095D4B80088CFB0007DCBA90078C8
      A50075C8A40078CAA6007ECCAA0088D0AF0095D5B900A3DBC200ADE0C900B5E4
      CF00BCE8D400C0E9D600BEEAD600BCE9D400B6E7D000ABE3C9008FD4B500439B
      7800D8E8E2000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D1D1
      D100CDCDCD00FCFCFC00FFFFFF00C9C9C900ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C8D8005885DB004589FE005595FC005795
      FB005493F9005190F8004E8EF8004D8DF8004B8CF700498AF700488AF700478A
      F800468AFB004087FF003479F6006F95DA00E4E6EB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A3A3A3005C5C5C0063636300646464006464640089898900FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFDFC00F3FAF700E7F5EF00D8EEE400C8E7DA00B7DFCE00A3D6C00093CE
      B50082C5A90074BEA0006AB8980062B3930059AF8C0053AB87005CAA8B00CBE2
      D900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900C9C9C900CACACA00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C5DD006C99EB004986
      EF004387F9004C8DF8004F8FF8004F8FF8004D8DF800488AF7004287F9003980
      F8004883EA0080A1DA00D7DEEB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C3C3C300A0A0A000A9A9A900C2C2C200F3F3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DFE5
      F100AEC7EE0089B1F50074A5F80073A4F80072A3F80078A8FA0093B3E900BCCE
      ED00ECF0F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000080000000C00000000100010000000000000C00000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF000000000000000000000000
      FE0001FF000000000000000000000000FE0000FF000000000000000000000000
      FE00007F000000000000000000000000FE3FF83F000000000000000000000000
      FE3FF81F000000000000000000000000FE3FF80F000000000000000000000000
      C23FF807000000000000000000000000803FF803000000000000000000000000
      807FF801000000000000000000000000801FFC01000000000000000000000000
      8007FFF10000000000000000000000008003FFF1000000000000000000000000
      E000FFF1000000000000000000000000F0007FF1000000000000000000000000
      FC001FF1000000000000000000000000FF0007F1000000000000000000000000
      FE0007F1000000000000000000000000FE201FF1000000000000000000000000
      FE3013F1000000000000000000000000FE3C31F1000000000000000000000000
      FE3F21F1000000000000000000000000FE3FFDF1000000000000000000000000
      FE3FFFF1000000000000000000000000FE3FFFF1000000000000000000000000
      FE3FFFF1000000000000000000000000FE3FFFF1000000000000000000000000
      FE3FFFF1000000000000000000000000FE000001000000000000000000000000
      FE000001000000000000000000000000FE000001000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFFFC00003FFC00003FFFC3FFFF
      C0001FFFF800001FF800001FFFC1FFFFC0000FFFF000000FF000000FFFC1FFFF
      C00007FFF000000FF000000FFFC1FFFFC00003FFF03FFC0FF000000FFFC1801F
      C00001FFF07FFE0FF000000FFFC1801FC00001FFF0FFFF0FF000000FFFC1C00F
      C00001FFF0FFFF0FF000000FFFC1C00FC00001FFF0C3C30FF000000FFFC0400F
      C00001FFF0C3C30FF018180FFFC0039FC00001FFF0C3C30FF018180FFFC003FF
      C00001BFF0C3C30FF000000FFFF003FFC000011FF0FFFF0FF000000FFFF803FF
      C000000FF0FFFF0FF000000FF83C03FFC0000007F0FFFF0FF000000FF00403FF
      C0000003F0FFFF0FF000000FF00007FFC0000007F0C3C30FF000000FF00007FF
      C000010FF0C3C30FF018180FF0000FFFC000019FF0C3C30FF018180FFF8009FF
      E00001FFF0C3C30FF000000FFF8010FFF00001DFF0FFFF0FF000000FFF8000FF
      F800018FF0FFFF0FF000000FFF8020FFFFFFFF07F0FFFF0FF000000FFF8001FF
      FFFFEE03F0FFFF0FF000000FFF8001FFFFFFC6030000000000000000FE0003FF
      FFFF82030000000000000000FC0003FFFFFF01070000000000000000FC03FFFF
      FFFF018F0000000000000000FC03FFFFFFFF03FFFF0000FFFF0000FFFC03FFFF
      FFFF87FFFF0000FFFF0000FFFC03FFFFFFFFCFFFFF0000FFFF0000FFFC07FFFF
      FFFFFFFFFF0000FFFF0000FFFE07FFFFFC00003FFFFE01FFF0000000FFFFFFFF
      80000003FFE0000FE018FFE0FFFFFFFF80000003FF800003C010FFE0FFFC3FFF
      F000000FFE0000018010FFE0FFF00FFFE03FFC07FE0000000010FFE0FFE007FF
      C01FF803FE0000000010FFE0FF8001FF800FF003FC0000010010FFE0FE00007F
      8007E001F80000030010FFE0FC00003F8003C001F000000F000FFFC0FE00003F
      C0018003E000000F00000000FC00003FE0000007E000000700000000F000000F
      F000000FC000000700000000E0000007F800001FC00000030000000080000001
      FC00003FC00000030000000000018000FE00007F80000003000000008003C001
      FF0000FF8000000100000000C00FF003FF8001FF8000000100000000E01FF807
      FF8001FF8000000100000000F87FFE1FFF0000FF8000000100000000FCFFFF3F
      FE00007F8000000307FFFFE0F8FFFF1FFC00003F8000000307FFFFE0F03FFC0F
      F800001FC000000307FFFFE0E01FF807F000000FC000000307FFFFE0C007E003
      E0000007C0000007000000008001C001C0018003E000000707FFFFE000000000
      8003C001F000000F07FFFFE0C00100038007E001F000001F07FFFFE0E003C007
      800FF003F800001F00000000F807E01FC01FF803FC00007F07FFFFE0FE0FF03F
      E03FFC07FF0000FF07FFFFE0FF1FF8FFF07FFE0FFF8001FF07FFFFE0FFFFFFFF
      F8FFFF1FFFF00FFF00000000FFFFFFFF80000001FFF00FFFE0000001FFE003FF
      00000000F000000FE0000001FF8000FF0000000080000001E0000001FE00003F
      0000000000000000E0000001FC00001F0000000000000000E0000001F800000F
      0000000000000000E0000000F00000070000000000000000E0000000E0000003
      00000000C0000005E0000000C000000100000000E0000007E0000000C0000001
      00000000E000000FE00000008000000000000000F000001FE000000080000000
      00000000FC00003FE00000000000000000000000FF0000FFE000000000000000
      00000000FFE00FFFE00000000000000000000000FFE01FFFE000000000000000
      00000000FFE00FFFE00000000000000000000000FFE00FFFE000000000000000
      00000000FFC007FFE00000010000000000000000FF8007FFE000000100000000
      00000000FF8003FFE00000010000000000000000FF8003FFE000000100000000
      00000000FF8003FFE00000010000000100000000FF8003FFE0000003C0000000
      00000000FF8003FFE0000007C000000200000000FF8003FFE000000FE0000003
      00000000FF8003FFE000001FD000000700000000FF8003FFE000003FF000000B
      00000000FF8003FFE0000063F800000F80000001FF8007FFE00000E3FC00001F
      00000000FFC00FFFE00001E3FF00007F40000003FFE03FFFF00003FFFF8000FF
      B000000FFFF07FFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFFFFFC003FF80000001
      FFFC3FFFFFF81FFFFF0000FF00000000FFC003FFFFC003FFFE00003F00000000
      FF0000FFFF0000FFF800001F00000000FC00007FFC00003FF000000F00000000
      F800001FF800001FE000000700000000F000000FF000000FE000000300000000
      E0000007E0000007C000000300000000E0000007E0000007C000000100000000
      C0000003C00000038000000100000000C0000003800000038000000000000000
      8000000180000001000000000000000080000001000000010000000000000000
      8000000100000001000000000000000080000001000000010000000000000000
      8000000100000001000000000000000080000001000000010000000000000000
      8000000100000001000000000000000080000001000000010000000100000000
      8000000100000001000000010000000080000001800000010000000000000000
      8000000180000001C000000300000000C0000003C0000003C000000300000000
      C0000003C0000003E000000300000000E0000007E0000007C000000700000000
      F000000FE000000FF000000F00000000F800001FF000001FF800001700000000
      FC00003FF800003FF400003F00000000FE00007FFE00007FFE00007F80000001
      FF8001FFFF8001FFFF8000FF00000000FFE007FFFFE007FFFFE003FF40000002
      FFFFFFFFFFFFFFFFFFFC3FFFA0000005FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFCFFFFFFFFFFFFFFFFFFFFFFFC3FFFFFFC7FFFFFE3FFFFFFFF8FFFFFE007FF
      FFF83FFFFFC27FFFFFFE07FFFF0001FFFFF01FFFFC001FFFFFFC03FFFE00007F
      FFE00FFFF8000FFFFFF800FFF800003FFFC003FFF00007FFFFF0007FF000001F
      FF8001FFF80003FFFFE0001FF000000FFF0000FFF00001FFFFC0000FE0000007
      FF00007FE00000FFFF800003C0000003FE00003FE000007FFF000001C0000003
      FC00000FE000003FFE00000180000003F8000007E000003FFC00000180000001
      F0000003E000003FF800000180000001E0000001E000081FF000000180000001
      C0000000E000101FE00000038000000180000000F000001FC000000780000001
      00000003F000001F8000000F8000000100000003F800000F0000001F80000001
      00000007F800000F0000003F800000018000000FFC00000F0000007F80000001
      C000001FFE00000FC00000FF80000003E000003FFF00000F800001FFC0000003
      F800007FFF800007C00003FFC0000003FC0000FFFF800007F00007FFE0000007
      FE0001FFFF000007F8000FFFE000000FFF8003FFFE000007FE001FFFF000001F
      FFC007FFFE000007FF803FFFF800003FFFE00FFFFE000007FFE07FFFFE00007F
      FFF80FFFFFF0000FFFF0FFFFFF8001FFFFFC1FFFFFFFFFFFFFFFFFFFFFE007FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
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
    ButtonAppearance.CaptionFont.Name = 'Segoe UI'
    ButtonAppearance.CaptionFont.Style = []
    CaptionAppearance.CaptionColor = 12105910
    CaptionAppearance.CaptionColorTo = 10526878
    CaptionAppearance.CaptionBorderColor = clWhite
    CaptionAppearance.CaptionColorHot = 11184809
    CaptionAppearance.CaptionColorHotTo = 7237229
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Segoe UI'
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
    Font.Name = 'Segoe UI'
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
    GroupAppearance.Font.Name = 'Segoe UI'
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
    PagerCaption.Font.Name = 'Segoe UI'
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
    TabAppearance.Font.Name = 'Segoe UI'
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
    Left = 276
    Top = 238
  end
  object AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler
    Style = psOffice2007Obsidian
    BorderColor = 4276545
    PanelAppearanceLight.BorderColor = clNone
    PanelAppearanceLight.BorderColorHot = 10079963
    PanelAppearanceLight.BorderColorDown = 4548219
    PanelAppearanceLight.Color = 4276545
    PanelAppearanceLight.ColorTo = 3158063
    PanelAppearanceLight.ColorHot = 16515071
    PanelAppearanceLight.ColorHotTo = 12644607
    PanelAppearanceLight.ColorDown = 7845111
    PanelAppearanceLight.ColorDownTo = 4561657
    PanelAppearanceLight.ColorMirror = 3158063
    PanelAppearanceLight.ColorMirrorTo = 5000268
    PanelAppearanceLight.ColorMirrorHot = 7067903
    PanelAppearanceLight.ColorMirrorHotTo = 10544892
    PanelAppearanceLight.ColorMirrorDown = 1671928
    PanelAppearanceLight.ColorMirrorDownTo = 241407
    PanelAppearanceLight.TextColor = clWhite
    PanelAppearanceLight.TextColorHot = clWhite
    PanelAppearanceLight.TextColorDown = clWhite
    PanelAppearanceLight.TextStyle = []
    PanelAppearanceDark.BorderColor = clNone
    PanelAppearanceDark.BorderColorHot = 10079963
    PanelAppearanceDark.BorderColorDown = 4548219
    PanelAppearanceDark.Color = 10592158
    PanelAppearanceDark.ColorTo = 6512478
    PanelAppearanceDark.ColorHot = 16515071
    PanelAppearanceDark.ColorHotTo = 12644607
    PanelAppearanceDark.ColorDown = 7845111
    PanelAppearanceDark.ColorDownTo = 4561657
    PanelAppearanceDark.ColorMirror = 6512478
    PanelAppearanceDark.ColorMirrorTo = 5459275
    PanelAppearanceDark.ColorMirrorHot = 7067903
    PanelAppearanceDark.ColorMirrorHotTo = 10544892
    PanelAppearanceDark.ColorMirrorDown = 1671928
    PanelAppearanceDark.ColorMirrorDownTo = 241407
    PanelAppearanceDark.TextColor = clWhite
    PanelAppearanceDark.TextColorHot = clWhite
    PanelAppearanceDark.TextColorDown = clWhite
    PanelAppearanceDark.TextStyle = []
    Left = 376
    Top = 237
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
    Left = 444
    Top = 198
  end
  object AdvPanelStyler2: TAdvPanelStyler
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
    Left = 372
    Top = 198
  end
  object AdvPanelStyler3: TAdvPanelStyler
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
    Left = 408
    Top = 197
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
    Left = 480
    Top = 193
  end
  object ImageList: TImageList
    Left = 424
    Top = 100
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFCFF9E9E9EFF8484
      84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
      84FF848484FF888888FFE3E3E3FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F3FFCFCFCFFFE6E3
      E1FFDAD9D9FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8
      D8FFD8D8D8FFDDDDDDFFC3C3C3FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFE8E8E8FFCECECEFFBFBF
      BFFFB8B8B8FFB6B6B6FFBDBDBDFFCACACAFFE2E2E2FFFAFAFAFFF3F3F3FFE5E5
      E5FFE4E4E4FFF1F1F1FF000000000000000000000000F3F3F3FFD2D1D1FFFEF5
      ECFFF1EBE4FFD3D3D3FFD4D4D4FFEDEDEDFFD7D7D7FFDADADAFFD3D3D3FFD3D3
      D3FFD3D3D3FFD6D6D6FFC1C1C1FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000049494BFF171719FF1D1D1EFF2222
      23FF252527FF2B2B2CFF2F2F30FF303031FF242425FF1F1F20FF414142FF5B5B
      5CFF5D5D5DFF595959FF525253FFA5A5A5FF00000000F3F3F3FFD1D1D1FFFEF5
      ECFFF1EBE4FFD1D1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FFD7BF
      A6FFDB8E42FFD3863BFF94897CFFE9E9E9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F1F20FF19191BFF1E1E20FF2424
      25FF2A2A2AFF2D2D2DFF343434FF313131FF242425FF202021FF434344FF5E5E
      5EFF696969FF656565FF505051FFADADAEFF00000000F3F3F3FFD1D1D0FFFEF5
      ECFFF0EAE4FFEFEFEFFFFFFFFFFFF9F9F9FFCECECEFFD3D3D3FFF7E4CFFFD684
      34FFD4873CFFD17F2FFFD28030FF958D83FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000939394FF1B1B1DFF212122FF2727
      28FF2B2B2BFF323232FF444444FF525253FF616161FF5E5E5FFF4B4B4BFF5555
      55FF757575FF818182FF848484FF0000000000000000F3F3F3FFD0D0D0FFFEF5
      ECFFEFE9E3FFE9E9E9FFFFFFFFFFDBDBDBFFD3D3D3FFD3D3D3FFEEA660FFD684
      34FFE7B788FFF0D0B1FFD68434FFCB8948FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E6E6E6FF4E4E4FFF2727
      28FF131314FF181818FF363636FF4B4B4BFF6F6F6FFFD7D7D7FF454545FF4141
      41FFD7D7D7FF00000000000000000000000000000000F3F3F3FFD4D4D4FFFEF6
      EDFFF0EAE4FFC9C9C9FFFAFAFAFFEAEAEAFFD7D7D7FFD7D7D7FFF8C28EFFE492
      42FFF5D5B7FFF5D5B6FFE49242FFD19355FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001F1F1FFF242424FF585858FF0000000000000000CFCFCFFF545454FF5757
      57FFF6F6F6FF00000000000000000000000000000000F3F3F3FFDADAD9FFFFF7
      F0FFF2ECE7FFC9C9C9FFEDEDEDFFECECECFFDEDEDEFFD8D8D8FFFEFAF5FFEEA0
      53FFE79545FFE79545FFF3A353FFC9C7C5FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BDFF252525FF282828FF373737FF0000000000000000606060FF535353FF5A5A
      5AFF6A6A6AFF00000000000000000000000000000000F3F3F3FFE0E0E0FFFFF8
      F3FFF3EEEAFFE9E9E9FFF5F5F5FFF8F8F8FFE5E5E5FFE5E5E5FFE3E3E3FFFCF9
      F7FFF8D4B1FFF7CFA8FFB8B7B5FFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003434
      34FF212121FF303030FF323232FFB5B5B5FFF8F8F8FF4D4D4DFF5A5A5AFF7272
      72FF626161FF00000000000000000000000000000000F3F3F3FFE4E4E4FFFFFA
      F6FFF3F0EDFFE5E5E5FFE7E7E7FFEDEDEDFFF5F5F5FFF7F7F7FFFFFFFFFFE9E9
      E9FFEAEAEAFFEAEAEAFFC2C2C2FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ECECECFF2020
      20FF272727FF414141FF383838FF515050FF000000004C4C4CFF5F5F5FFF7878
      78FF525454FF00000000000000000000000000000000F3F3F3FFE6E6E6FFFFFB
      F8FFF4F1EEFFEDEDEDFFEDEDEDFFEDEDEDFFE6E6E6FFDADADAFFDEDDDDFFE7E6
      E5FFE7E6E5FFE5E4E3FFCBCBCBFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001919
      19FF2D2D2DFF474747FF595959FF888786FF000000005A5A5AFF5D5D5DFF6B6B
      6BFF505050FF00000000000000000000000000000000F3F3F3FFE6E6E6FFFFFB
      F8FFF3F0EEFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFF7A454FFF6A3
      53FFF6A353FFB19171FFF9F9F9FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFBFBFF4242
      42FF303030FF4A4A4AFF292929FF686868FF000000009F9F9FFF5D5D5DFF9090
      90FF0000000000000000000000000000000000000000F3F3F3FFE5E5E5FFFFFB
      F8FFF2EFEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFFEB066FFFDAD
      60FFB49475FFF8F8F8FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001212
      12FF4D4D4DFF616161FF3E3E3EFF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F3FFE6E6E6FFFFFB
      F8FFEFEAE6FFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFFFD7B2FFB6A1
      8CFFF8F8F8FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005E5E5EFF919191FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F7FFE4E4E4FFE6E6
      E6FFE9E9E9FFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFB8A695FFF8F8
      F8FF00000000FAFAFAFFFCFCFCFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FAFAFAFFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFFCFCFCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF800100000000FFFF800100000000
      0003800100000000000080000000000000008000000000000001800000000000
      8007800000000000F187800000000000E187800000000000E007800100000000
      C087800100000000E087800100000000C08F800300000000E1FF800700000000
      F3FF800900000000FFFFC01F0000000000000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Filter = '(a2000 Config Files)|*.a2k'
    Left = 97
    Top = 214
  end
  object SaveDialogHouse: TSaveDialog
    Left = 321
    Top = 198
  end
  object MainMenu1: TMainMenu
    Left = 283
    Top = 104
  end
end
