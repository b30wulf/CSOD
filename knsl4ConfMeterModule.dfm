object ConfMeterModule: TConfMeterModule
  Left = 348
  Top = 154
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Конфигурация прибора'
  ClientHeight = 520
  ClientWidth = 752
  Color = clBtnFace
  Constraints.MaxHeight = 554
  Constraints.MaxWidth = 768
  Constraints.MinHeight = 550
  Constraints.MinWidth = 760
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 513
    BevelOuter = bvNone
    Color = 16445929
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
    Caption.Color = 16773091
    Caption.ColorTo = 16765615
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clBlack
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 15587527
    ColorMirror = 15587527
    ColorMirrorTo = 16773863
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = 16765615
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 7485192
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 16245715
    StatusBar.ColorTo = 16109747
    StatusBar.GradientDirection = gdVertical
    FullHeight = 0
    object Label18: TLabel
      Left = 236
      Top = 71
      Width = 12
      Height = 15
      Caption = 'по'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lbProgressParam: TGradientLabel
      Left = 0
      Top = 473
      Width = 801
      Height = 17
      AutoSize = False
      Caption = 'Перечень загружаемыж данных'
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
    object AdvPanel1: TAdvPanel
      Left = 0
      Top = 0
      Width = 753
      Height = 46
      Align = alTop
      BevelOuter = bvNone
      Color = 16445929
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
      Caption.Color = 16773091
      Caption.ColorTo = 16765615
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clBlack
      Caption.Font.Height = -11
      Caption.Font.Name = 'MS Sans Serif'
      Caption.Font.Style = []
      Caption.GradientDirection = gdVertical
      Caption.Indent = 2
      Caption.ShadeLight = 255
      CollapsColor = clHighlight
      CollapsDelay = 0
      ColorTo = 15587527
      ColorMirror = 15587527
      ColorMirrorTo = 16773863
      ShadowColor = clBlack
      ShadowOffset = 0
      StatusBar.BorderColor = 16765615
      StatusBar.BorderStyle = bsSingle
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = 7485192
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      StatusBar.Color = 16245715
      StatusBar.ColorTo = 16109747
      StatusBar.GradientDirection = gdVertical
      FullHeight = 0
      object Label19: TLabel
        Left = 619
        Top = 5
        Width = 127
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'ООО Автоматизация 2000'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clTeal
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object AdvToolBar1: TAdvToolBar
        Left = 2
        Top = 0
        Width = 156
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
        Images = ImageList2
        ParentOptionPicture = True
        ParentShowHint = False
        ToolBarIndex = -1
        object bClearEv: TAdvToolBarButton
          Left = 52
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Считать с устройства'
          Appearance.CaptionFont.Charset = DEFAULT_CHARSET
          Appearance.CaptionFont.Color = clWindowText
          Appearance.CaptionFont.Height = -11
          Appearance.CaptionFont.Name = 'Tahoma'
          Appearance.CaptionFont.Style = []
          Caption = 'Очистить'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImageIndex = 4
          ParentFont = False
          Position = daTop
          Version = '3.1.6.0'
          OnClick = rbReadClick
        end
        object bEnablEv: TAdvToolBarButton
          Left = 102
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Остановить операцию'
          Appearance.CaptionFont.Charset = DEFAULT_CHARSET
          Appearance.CaptionFont.Color = clWindowText
          Appearance.CaptionFont.Height = -11
          Appearance.CaptionFont.Name = 'Segoe UI'
          Appearance.CaptionFont.Style = []
          Caption = 'Запуск'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImageIndex = 0
          ParentFont = False
          Position = daTop
          Version = '3.1.6.0'
          OnClick = Ondisc
        end
        object AdvToolBarSeparator2: TAdvToolBarSeparator
          Left = 92
          Top = 2
          Width = 10
          Height = 40
          LineColor = clBtnShadow
        end
        object AdvToolBarButton1: TAdvToolBarButton
          Left = 2
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Записать в устройство'
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
          OnClick = rbWriteClick
        end
        object AdvToolBarSeparator1: TAdvToolBarSeparator
          Left = 42
          Top = 2
          Width = 10
          Height = 40
          LineColor = clBtnShadow
        end
      end
    end
    object prProgressParam: TAdvProgress
      Left = 0
      Top = 490
      Width = 753
      Height = 23
      Align = alBottom
      Min = 0
      Max = 100
      Step = 1
      TabOrder = 1
      BarColor = clHighlight
      BkColor = clWindow
      Version = '1.2.0.0'
    end
    object KalenSetPage: TAdvOfficePager
      Left = 0
      Top = 52
      Width = 752
      Height = 428
      AdvOfficePagerStyler = AdvOfficePagerOfficeStyler1
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
      Images = ImageList1
      TabSettings.StartMargin = 4
      TabSettings.Shape = tsLeftRightRamp
      TabReorder = False
      ShowShortCutHints = False
      TabOrder = 2
      NextPictureChanged = False
      PrevPictureChanged = False
      object AdvOfficePager11: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 750
        Height = 400
        Caption = 'Основные настройки'
        ImageIndex = 0
        PageAppearance.BorderColor = 14922381
        PageAppearance.Color = 16445929
        PageAppearance.ColorTo = 15587527
        PageAppearance.ColorMirror = 15587527
        PageAppearance.ColorMirrorTo = 16773863
        PageAppearance.Gradient = ggVertical
        PageAppearance.GradientMirror = ggVertical
        TabAppearance.BorderColor = clNone
        TabAppearance.BorderColorHot = 15383705
        TabAppearance.BorderColorSelected = 14922381
        TabAppearance.BorderColorSelectedHot = 6343929
        TabAppearance.BorderColorDisabled = clNone
        TabAppearance.BorderColorDown = clNone
        TabAppearance.Color = clBtnFace
        TabAppearance.ColorTo = clWhite
        TabAppearance.ColorSelected = 16709360
        TabAppearance.ColorSelectedTo = 16445929
        TabAppearance.ColorDisabled = clWhite
        TabAppearance.ColorDisabledTo = clSilver
        TabAppearance.ColorHot = 14542308
        TabAppearance.ColorHotTo = 16768709
        TabAppearance.ColorMirror = clWhite
        TabAppearance.ColorMirrorTo = clWhite
        TabAppearance.ColorMirrorHot = 14016477
        TabAppearance.ColorMirrorHotTo = 10736609
        TabAppearance.ColorMirrorSelected = 16445929
        TabAppearance.ColorMirrorSelectedTo = 16181984
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
        TabAppearance.GradientMirrorHot = ggVertical
        TabAppearance.GradientSelected = ggVertical
        TabAppearance.GradientMirrorSelected = ggVertical
        TabAppearance.GradientDisabled = ggVertical
        TabAppearance.GradientMirrorDisabled = ggVertical
        TabAppearance.TextColor = 9126421
        TabAppearance.TextColorHot = 9126421
        TabAppearance.TextColorSelected = 9126421
        TabAppearance.TextColorDisabled = clGray
        TabAppearance.ShadowColor = 15255470
        TabAppearance.HighLightColor = 16775871
        TabAppearance.HighLightColorHot = 16643309
        TabAppearance.HighLightColorSelected = 6540536
        TabAppearance.HighLightColorSelectedHot = 12451839
        TabAppearance.HighLightColorDown = 16776144
        TabAppearance.BackGround.Color = 16767935
        TabAppearance.BackGround.ColorTo = clNone
        TabAppearance.BackGround.Direction = gdVertical
        object Label14: TLabel
          Left = 178
          Top = 31
          Width = 120
          Height = 15
          Caption = 'Связной адрес прибора'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label15: TLabel
          Left = 392
          Top = 32
          Width = 39
          Height = 15
          Caption = 'Пароль'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 178
          Top = 56
          Width = 118
          Height = 15
          Caption = 'Сетевой адрес прибора'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label3: TLabel
          Left = 178
          Top = 153
          Width = 72
          Height = 15
          Caption = 'Сетевой адрес'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 178
          Top = 177
          Width = 87
          Height = 15
          Caption = 'Скорость обмена'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label5: TLabel
          Left = 178
          Top = 201
          Width = 67
          Height = 15
          Caption = 'Вид паритета'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 178
          Top = 225
          Width = 77
          Height = 15
          Caption = 'Число стоп-бит'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label7: TLabel
          Left = 178
          Top = 249
          Width = 18
          Height = 15
          Caption = 'KU'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label8: TLabel
          Left = 178
          Top = 273
          Width = 13
          Height = 15
          Caption = 'KI'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label10: TLabel
          Left = 178
          Top = 297
          Width = 92
          Height = 15
          Caption = 'Основной Пароль'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label13: TLabel
          Left = 178
          Top = 321
          Width = 128
          Height = 15
          Caption = 'Дополнительный Пароль'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbTelGsmCon: TLabel
          Left = 392
          Top = 56
          Width = 44
          Height = 15
          Caption = 'Телефон'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbTimeMetAndUSPD: TLabel
          Left = 178
          Top = 129
          Width = 138
          Height = 15
          BiDiMode = bdRightToLeftNoAlign
          Caption = 'Время счетчика неизвестно'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          Transparent = True
        end
        object GradientLabel5: TGradientLabel
          Left = 6
          Top = 108
          Width = 737
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Конфигурация счетчика'
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
        object GradientLabel7: TGradientLabel
          Left = 5
          Top = 4
          Width = 737
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Параметры соединения устройства'
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
        object seVMAddress: TSpinEdit
          Left = 320
          Top = 31
          Width = 49
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 255
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
          OnChange = seVMAddressChange
        end
        object edPassword: TEdit
          Left = 448
          Top = 31
          Width = 126
          Height = 21
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          PasswordChar = '*'
          TabOrder = 1
        end
        object sePHAddress: TSpinEdit
          Left = 320
          Top = 56
          Width = 49
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 255
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 0
          OnChange = sePHAddressChange
        end
        object spNewPHAddress: TSpinEdit
          Left = 336
          Top = 150
          Width = 145
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 255
          MinValue = 0
          ParentFont = False
          TabOrder = 3
          Value = 0
        end
        object cbSpeed: TComboBox
          Left = 336
          Top = 174
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          Items.Strings = (
            '100'
            '300'
            '600'
            '1200'
            '2400'
            '4800'
            '9600'
            '19200'
            '38400')
        end
        object cbParitet: TComboBox
          Left = 336
          Top = 199
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 5
          Items.Strings = (
            'Без паритета'
            'Нечетность'
            'Четность')
        end
        object cbStopBit: TComboBox
          Left = 336
          Top = 223
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 6
          Items.Strings = (
            '1'
            '2')
        end
        object edKU: TEdit
          Left = 336
          Top = 248
          Width = 145
          Height = 21
          TabOrder = 7
        end
        object edKI: TEdit
          Left = 336
          Top = 272
          Width = 145
          Height = 21
          TabOrder = 8
        end
        object edNewPassword: TEdit
          Left = 336
          Top = 297
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 9
        end
        object edAdvPassword: TEdit
          Left = 336
          Top = 321
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 10
        end
        object chbNewPHAddress: TAdvOfficeCheckBox
          Left = 500
          Top = 152
          Width = 89
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 11
          Version = '1.1.1.4'
        end
        object chbSpeed: TAdvOfficeCheckBox
          Left = 500
          Top = 176
          Width = 89
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 12
          Version = '1.1.1.4'
        end
        object chbSetDateTime: TAdvOfficeCheckBox
          Left = 500
          Top = 128
          Width = 105
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 13
          Version = '1.1.1.4'
        end
        object chbParitet: TAdvOfficeCheckBox
          Left = 499
          Top = 201
          Width = 90
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 14
          Version = '1.1.1.4'
        end
        object chbStopBit: TAdvOfficeCheckBox
          Left = 499
          Top = 226
          Width = 90
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 15
          Version = '1.1.1.4'
        end
        object chbKU: TAdvOfficeCheckBox
          Left = 499
          Top = 250
          Width = 90
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 16
          Version = '1.1.1.4'
        end
        object chbKI: TAdvOfficeCheckBox
          Left = 499
          Top = 275
          Width = 90
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 17
          Version = '1.1.1.4'
        end
        object chbNewPassword: TAdvOfficeCheckBox
          Left = 499
          Top = 299
          Width = 90
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 18
          Version = '1.1.1.4'
        end
        object chbAdvPassword: TAdvOfficeCheckBox
          Left = 499
          Top = 324
          Width = 98
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 19
          Version = '1.1.1.4'
        end
        object edTelGsmCon: TEdit
          Left = 448
          Top = 56
          Width = 126
          Height = 21
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 20
        end
        object chbGsmCon: TAdvOfficeCheckBox
          Left = 177
          Top = 80
          Width = 282
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Использовать модем для связи с счетчиком'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 21
          Version = '1.1.1.4'
        end
      end
      object TarifSetPage: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 750
        Height = 400
        Caption = 'Тарифы'
        ImageIndex = 2
        PageAppearance.BorderColor = 14922381
        PageAppearance.Color = 16445929
        PageAppearance.ColorTo = 15587527
        PageAppearance.ColorMirror = 15587527
        PageAppearance.ColorMirrorTo = 16773863
        PageAppearance.Gradient = ggVertical
        PageAppearance.GradientMirror = ggVertical
        TabAppearance.BorderColor = clNone
        TabAppearance.BorderColorHot = 15383705
        TabAppearance.BorderColorSelected = 14922381
        TabAppearance.BorderColorSelectedHot = 6343929
        TabAppearance.BorderColorDisabled = clNone
        TabAppearance.BorderColorDown = clNone
        TabAppearance.Color = clBtnFace
        TabAppearance.ColorTo = clWhite
        TabAppearance.ColorSelected = 16709360
        TabAppearance.ColorSelectedTo = 16445929
        TabAppearance.ColorDisabled = clWhite
        TabAppearance.ColorDisabledTo = clSilver
        TabAppearance.ColorHot = 14542308
        TabAppearance.ColorHotTo = 16768709
        TabAppearance.ColorMirror = clWhite
        TabAppearance.ColorMirrorTo = clWhite
        TabAppearance.ColorMirrorHot = 14016477
        TabAppearance.ColorMirrorHotTo = 10736609
        TabAppearance.ColorMirrorSelected = 16445929
        TabAppearance.ColorMirrorSelectedTo = 16181984
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
        TabAppearance.GradientMirrorHot = ggVertical
        TabAppearance.GradientSelected = ggVertical
        TabAppearance.GradientMirrorSelected = ggVertical
        TabAppearance.GradientDisabled = ggVertical
        TabAppearance.GradientMirrorDisabled = ggVertical
        TabAppearance.TextColor = 9126421
        TabAppearance.TextColorHot = 9126421
        TabAppearance.TextColorSelected = 9126421
        TabAppearance.TextColorDisabled = clGray
        TabAppearance.ShadowColor = 15255470
        TabAppearance.HighLightColor = 16775871
        TabAppearance.HighLightColorHot = 16643309
        TabAppearance.HighLightColorSelected = 6540536
        TabAppearance.HighLightColorSelectedHot = 12451839
        TabAppearance.HighLightColorDown = 16776144
        TabAppearance.BackGround.Color = 16767935
        TabAppearance.BackGround.ColorTo = clNone
        TabAppearance.BackGround.Direction = gdVertical
        object Label1: TLabel
          Left = 185
          Top = 345
          Width = 34
          Height = 15
          Caption = 'Месяц'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 412
          Top = 345
          Width = 117
          Height = 15
          Caption = 'Рабочие/Выходные дни'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sgTariffs: TAdvStringGrid
          Left = 2
          Top = 2
          Width = 746
          Height = 277
          Cursor = crDefault
          BiDiMode = bdLeftToRight
          ColCount = 9
          DefaultColWidth = 80
          DefaultRowHeight = 21
          RowCount = 49
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          GridLineWidth = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          ParentBiDiMode = False
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnDrawCell = sgTariffsDrawCell
          OnSelectCell = sgTariffsSelectCell
          GridLineColor = 15062992
          ActiveCellFont.Charset = RUSSIAN_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Times New Roman'
          ActiveCellFont.Style = [fsBold]
          ActiveCellColor = 10344697
          ActiveCellColorTo = 6210033
          Bands.Active = True
          Bands.PrimaryColor = 16445929
          Bands.SecondaryColor = clWhite
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            'Зона'
            'A'
            'B'
            'C'
            'D'
            'E'
            'F'
            'G'
            'H')
          ControlLook.FixedGradientFrom = 16513526
          ControlLook.FixedGradientTo = 15260626
          ControlLook.ControlStyle = csClassic
          EnableWheel = False
          EnhRowColMove = False
          Filter = <>
          FixedColWidth = 80
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -13
          FixedFont.Name = 'Times New Roman'
          FixedFont.Style = []
          FloatFormat = '%.2f'
          IntegralHeight = True
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
          RowHeaders.Strings = (
            ''
            '00:00'
            '00:30'
            '01:00'
            '01:30'
            '02:00'
            '02:30'
            '03:00'
            '03:30'
            '04:00'
            '04:30'
            '05:00'
            '05:30'
            '06:00'
            '06:30'
            '07:00'
            '07:30'
            '08:00'
            '08:30'
            '09:00'
            '09:30'
            '10:00'
            '10:30'
            '11:00'
            '11:30'
            '12:00'
            '12:30'
            '13:00'
            '13:30'
            '14:00'
            '14:30'
            '15:00'
            '15:30'
            '16:00'
            '16:30'
            '17:00'
            '17:30'
            '18:00'
            '18:30'
            '19:00'
            '19:30'
            '20:00'
            '20:30'
            '21:00'
            '21:30'
            '22:00'
            '22:30'
            '23:00'
            '23:30')
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
          SearchFooter.Color = 16773091
          SearchFooter.ColorTo = 16765615
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
          RowHeights = (
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21
            21)
        end
        object cbMonthTarif: TComboBox
          Left = 185
          Top = 364
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'Январь '
            'Февраль'
            'Март'
            'Апрель'
            'Май'
            'Июнь'
            'Июль'
            'Август'
            'Сентябрь'
            'Октябрь'
            'Ноябрь'
            'Декабрь')
        end
        object cbWorkPrDay: TComboBox
          Left = 412
          Top = 364
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          Items.Strings = (
            'Рабочие дни'
            'Выходные дни')
        end
        object chbSetAllYear: TAdvOfficeCheckBox
          Left = 185
          Top = 287
          Width = 280
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Установить тарифное расписание для всего года'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 3
          Version = '1.1.1.4'
        end
        object AdvGlowButton1: TAdvGlowButton
          Left = 187
          Top = 313
          Width = 100
          Height = 25
          Caption = 'Очистить '
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 4
          OnClick = rbClearTariffsClick
          Appearance.BorderColor = 14727579
          Appearance.BorderColorHot = 10079963
          Appearance.BorderColorDown = 4548219
          Appearance.BorderColorChecked = 4548219
          Appearance.Color = 15653832
          Appearance.ColorTo = 16178633
          Appearance.ColorChecked = 11918331
          Appearance.ColorCheckedTo = 7915518
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 7778289
          Appearance.ColorDownTo = 4296947
          Appearance.ColorHot = 15465983
          Appearance.ColorHotTo = 11332863
          Appearance.ColorMirror = 15586496
          Appearance.ColorMirrorTo = 16245200
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
        end
        object AdvGlowButton2: TAdvGlowButton
          Left = 299
          Top = 313
          Width = 110
          Height = 25
          Caption = 'Загрузить из файла'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 5
          OnClick = rbLoadTrFromFileClick
          Appearance.BorderColor = 14727579
          Appearance.BorderColorHot = 10079963
          Appearance.BorderColorDown = 4548219
          Appearance.BorderColorChecked = 4548219
          Appearance.Color = 15653832
          Appearance.ColorTo = 16178633
          Appearance.ColorChecked = 11918331
          Appearance.ColorCheckedTo = 7915518
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 7778289
          Appearance.ColorDownTo = 4296947
          Appearance.ColorHot = 15465983
          Appearance.ColorHotTo = 11332863
          Appearance.ColorMirror = 15586496
          Appearance.ColorMirrorTo = 16245200
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
        end
        object AdvGlowButton3: TAdvGlowButton
          Left = 419
          Top = 313
          Width = 110
          Height = 25
          Caption = 'Записать в файл'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 6
          OnClick = rbSaveTrFromFileClick
          Appearance.BorderColor = 14727579
          Appearance.BorderColorHot = 10079963
          Appearance.BorderColorDown = 4548219
          Appearance.BorderColorChecked = 4548219
          Appearance.Color = 15653832
          Appearance.ColorTo = 16178633
          Appearance.ColorChecked = 11918331
          Appearance.ColorCheckedTo = 7915518
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 7778289
          Appearance.ColorDownTo = 4296947
          Appearance.ColorHot = 15465983
          Appearance.ColorHotTo = 11332863
          Appearance.ColorMirror = 15586496
          Appearance.ColorMirrorTo = 16245200
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
        end
      end
      object AdvOfficePager13: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 750
        Height = 400
        Caption = 'Календарь'
        ImageIndex = 1
        PageAppearance.BorderColor = 14922381
        PageAppearance.Color = 16445929
        PageAppearance.ColorTo = 15587527
        PageAppearance.ColorMirror = 15587527
        PageAppearance.ColorMirrorTo = 16773863
        PageAppearance.Gradient = ggVertical
        PageAppearance.GradientMirror = ggVertical
        TabAppearance.BorderColor = clNone
        TabAppearance.BorderColorHot = 15383705
        TabAppearance.BorderColorSelected = 14922381
        TabAppearance.BorderColorSelectedHot = 6343929
        TabAppearance.BorderColorDisabled = clNone
        TabAppearance.BorderColorDown = clNone
        TabAppearance.Color = clBtnFace
        TabAppearance.ColorTo = clWhite
        TabAppearance.ColorSelected = 16709360
        TabAppearance.ColorSelectedTo = 16445929
        TabAppearance.ColorDisabled = clWhite
        TabAppearance.ColorDisabledTo = clSilver
        TabAppearance.ColorHot = 14542308
        TabAppearance.ColorHotTo = 16768709
        TabAppearance.ColorMirror = clWhite
        TabAppearance.ColorMirrorTo = clWhite
        TabAppearance.ColorMirrorHot = 14016477
        TabAppearance.ColorMirrorHotTo = 10736609
        TabAppearance.ColorMirrorSelected = 16445929
        TabAppearance.ColorMirrorSelectedTo = 16181984
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
        TabAppearance.GradientMirrorHot = ggVertical
        TabAppearance.GradientSelected = ggVertical
        TabAppearance.GradientMirrorSelected = ggVertical
        TabAppearance.GradientDisabled = ggVertical
        TabAppearance.GradientMirrorDisabled = ggVertical
        TabAppearance.TextColor = 9126421
        TabAppearance.TextColorHot = 9126421
        TabAppearance.TextColorSelected = 9126421
        TabAppearance.TextColorDisabled = clGray
        TabAppearance.ShadowColor = 15255470
        TabAppearance.HighLightColor = 16775871
        TabAppearance.HighLightColorHot = 16643309
        TabAppearance.HighLightColorSelected = 6540536
        TabAppearance.HighLightColorSelectedHot = 12451839
        TabAppearance.HighLightColorDown = 16776144
        TabAppearance.BackGround.Color = 16767935
        TabAppearance.BackGround.ColorTo = clNone
        TabAppearance.BackGround.Direction = gdVertical
        object Label12: TLabel
          Left = 32
          Top = 353
          Width = 97
          Height = 15
          Caption = 'Начало сезона лето'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label17: TLabel
          Left = 224
          Top = 353
          Width = 98
          Height = 15
          Caption = 'Начало сезона зима'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object GradientLabel2: TGradientLabel
          Left = 10
          Top = 262
          Width = 731
          Height = 17
          AutoSize = False
          Caption = 'Параметры перехода на новый сезон'
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
        object sgKalendar: TAdvStringGrid
          Left = 2
          Top = 2
          Width = 746
          Height = 252
          Cursor = crDefault
          Align = alTop
          BiDiMode = bdLeftToRight
          ColCount = 32
          DefaultRowHeight = 21
          RowCount = 13
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          GridLineWidth = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
          ParentBiDiMode = False
          ParentFont = False
          ScrollBars = ssHorizontal
          TabOrder = 0
          OnDrawCell = sgKalendarDrawCell
          GridLineColor = 15062992
          OnDblClickCell = sgKalendarDblClickCell
          ActiveCellFont.Charset = RUSSIAN_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Times New Roman'
          ActiveCellFont.Style = [fsBold]
          ActiveCellColor = 10344697
          ActiveCellColorTo = 6210033
          AutoSize = True
          Bands.Active = True
          Bands.PrimaryColor = 16445929
          Bands.SecondaryColor = clWhite
          CellNode.ShowTree = False
          ControlLook.FixedGradientFrom = 16513526
          ControlLook.FixedGradientTo = 15260626
          ControlLook.ControlStyle = csClassic
          EnableWheel = False
          EnhRowColMove = False
          Filter = <>
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -13
          FixedFont.Name = 'Times New Roman'
          FixedFont.Style = []
          FloatFormat = '%.2f'
          IntegralHeight = True
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
          SearchFooter.Color = 16773091
          SearchFooter.ColorTo = 16765615
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
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22)
          RowHeights = (
            21
            21
            21
            22
            21
            21
            21
            21
            21
            21
            21
            21
            21)
        end
        object rbNoActionKal: TAdvOfficeRadioButton
          Left = 32
          Top = 282
          Width = 321
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Оставить без изменений'
          Checked = True
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 1
          TabStop = True
          Version = '1.1.1.4'
        end
        object rbResetActKal: TAdvOfficeRadioButton
          Left = 32
          Top = 305
          Width = 329
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Восстановить автоматический расчет даты начала сезонов'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 2
          Version = '1.1.1.4'
        end
        object rbUpdateActKal: TAdvOfficeRadioButton
          Left = 32
          Top = 328
          Width = 337
          Height = 22
          Alignment = taLeftJustify
          Caption = 'Изменить дату и время начала сезонов'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 3
          Version = '1.1.1.4'
        end
        object dtSummerSeason: TAdvDateTimePicker
          Left = 32
          Top = 373
          Width = 186
          Height = 23
          CalAlignment = dtaLeft
          Date = 40629.8501736111
          Time = 40629.8501736111
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Kind = dkDateTime
          ParseInput = False
          ParentFont = False
          TabOrder = 4
          BorderStyle = bsSingle
          Ctl3D = True
          DateTime = 40629.8501736111
          Version = '1.0.0.6'
        end
        object dtWinterSeason: TAdvDateTimePicker
          Left = 224
          Top = 373
          Width = 186
          Height = 23
          CalAlignment = dtaLeft
          Date = 40846.8501736111
          Time = 40846.8501736111
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Kind = dkDateTime
          ParseInput = False
          ParentFont = False
          TabOrder = 5
          BorderStyle = bsSingle
          Ctl3D = True
          DateTime = 40846.8501736111
          Version = '1.0.0.6'
        end
        object chbKalUpdate: TAdvOfficeCheckBox
          Left = 414
          Top = 350
          Width = 193
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Редактировать календарь'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          TabOrder = 6
          Version = '1.1.1.4'
        end
        object AdvGlowButton9: TAdvGlowButton
          Left = 415
          Top = 372
          Width = 146
          Height = 23
          Caption = 'Очистить календарь'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 7
          OnClick = rbClearKalClick
          Appearance.BorderColor = 14727579
          Appearance.BorderColorHot = 10079963
          Appearance.BorderColorDown = 4548219
          Appearance.BorderColorChecked = 4548219
          Appearance.Color = 15653832
          Appearance.ColorTo = 16178633
          Appearance.ColorChecked = 11918331
          Appearance.ColorCheckedTo = 7915518
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 7778289
          Appearance.ColorDownTo = 4296947
          Appearance.ColorHot = 15465983
          Appearance.ColorHotTo = 11332863
          Appearance.ColorMirror = 15586496
          Appearance.ColorMirrorTo = 16245200
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
        end
      end
      object TransOpenPage: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 750
        Height = 400
        Caption = 'Транзит'
        ImageIndex = 3
        PageAppearance.BorderColor = 14922381
        PageAppearance.Color = 16445929
        PageAppearance.ColorTo = 15587527
        PageAppearance.ColorMirror = 15587527
        PageAppearance.ColorMirrorTo = 16773863
        PageAppearance.Gradient = ggVertical
        PageAppearance.GradientMirror = ggVertical
        TabAppearance.BorderColor = clNone
        TabAppearance.BorderColorHot = 15383705
        TabAppearance.BorderColorSelected = 14922381
        TabAppearance.BorderColorSelectedHot = 6343929
        TabAppearance.BorderColorDisabled = clNone
        TabAppearance.BorderColorDown = clNone
        TabAppearance.Color = clBtnFace
        TabAppearance.ColorTo = clWhite
        TabAppearance.ColorSelected = 16709360
        TabAppearance.ColorSelectedTo = 16445929
        TabAppearance.ColorDisabled = clWhite
        TabAppearance.ColorDisabledTo = clSilver
        TabAppearance.ColorHot = 14542308
        TabAppearance.ColorHotTo = 16768709
        TabAppearance.ColorMirror = clWhite
        TabAppearance.ColorMirrorTo = clWhite
        TabAppearance.ColorMirrorHot = 14016477
        TabAppearance.ColorMirrorHotTo = 10736609
        TabAppearance.ColorMirrorSelected = 16445929
        TabAppearance.ColorMirrorSelectedTo = 16181984
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
        TabAppearance.GradientMirrorHot = ggVertical
        TabAppearance.GradientSelected = ggVertical
        TabAppearance.GradientMirrorSelected = ggVertical
        TabAppearance.GradientDisabled = ggVertical
        TabAppearance.GradientMirrorDisabled = ggVertical
        TabAppearance.TextColor = 9126421
        TabAppearance.TextColorHot = 9126421
        TabAppearance.TextColorSelected = 9126421
        TabAppearance.TextColorDisabled = clGray
        TabAppearance.ShadowColor = 15255470
        TabAppearance.HighLightColor = 16775871
        TabAppearance.HighLightColorHot = 16643309
        TabAppearance.HighLightColorSelected = 6540536
        TabAppearance.HighLightColorSelectedHot = 12451839
        TabAppearance.HighLightColorDown = 16776144
        TabAppearance.BackGround.Color = 16767935
        TabAppearance.BackGround.ColorTo = clNone
        TabAppearance.BackGround.Direction = gdVertical
        object lbTranzOpen: TLabel
          Left = 108
          Top = 68
          Width = 154
          Height = 15
          Caption = 'Длительность сеанса транзита:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object GradientLabel6: TGradientLabel
          Left = 10
          Top = 12
          Width = 731
          Height = 17
          AutoSize = False
          Caption = 'Открытие транзитного доступа к устройству'
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
        object cbTranzTime: TComboBox
          Left = 267
          Top = 65
          Width = 114
          Height = 23
          Style = csDropDownList
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            '5 секунд'
            '10 секунд'
            '30 секунд'
            '1 минута'
            '2 минуты'
            '4 минуты')
        end
        object AdvGlowButton7: TAdvGlowButton
          Left = 266
          Top = 93
          Width = 115
          Height = 26
          Caption = 'Открыть транзит'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 1
          OnClick = rbTranzOpenClick
          Appearance.BorderColor = 14727579
          Appearance.BorderColorHot = 10079963
          Appearance.BorderColorDown = 4548219
          Appearance.BorderColorChecked = 4548219
          Appearance.Color = 15653832
          Appearance.ColorTo = 16178633
          Appearance.ColorChecked = 11918331
          Appearance.ColorCheckedTo = 7915518
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 7778289
          Appearance.ColorDownTo = 4296947
          Appearance.ColorHot = 15465983
          Appearance.ColorHotTo = 11332863
          Appearance.ColorMirror = 15586496
          Appearance.ColorMirrorTo = 16245200
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
        end
        object cbm_nFreePort: TAdvOfficeCheckBox
          Left = 386
          Top = 65
          Width = 120
          Height = 20
          Alignment = taLeftJustify
          Caption = 'Освобождать порт'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7485192
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ReturnIsTab = False
          State = cbChecked
          TabOrder = 2
          Version = '1.1.1.4'
          Checked = True
        end
        object gbClose: TAdvGlowButton
          Left = 386
          Top = 93
          Width = 115
          Height = 26
          Caption = 'Положить трубку'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 3
          OnClick = OnClosePhone
          Appearance.BorderColor = 14727579
          Appearance.BorderColorHot = 10079963
          Appearance.BorderColorDown = 4548219
          Appearance.BorderColorChecked = 4548219
          Appearance.Color = 15653832
          Appearance.ColorTo = 16178633
          Appearance.ColorChecked = 11918331
          Appearance.ColorCheckedTo = 7915518
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 7778289
          Appearance.ColorDownTo = 4296947
          Appearance.ColorHot = 15465983
          Appearance.ColorHotTo = 11332863
          Appearance.ColorMirror = 15586496
          Appearance.ColorMirrorTo = 16245200
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
          Enabled = False
        end
      end
      object GradientLabel1: TGradientLabel
        Left = -56
        Top = 427
        Width = 801
        Height = 17
        AutoSize = False
        Caption = 'Перечень загружаемыж данных'
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
      object GradientLabel3: TGradientLabel
        Left = 6
        Top = 196
        Width = 731
        Height = 17
        AutoSize = False
        Caption = 'Параметры перехода на новый сезон'
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
      object GradientLabel4: TGradientLabel
        Left = 14
        Top = 204
        Width = 731
        Height = 17
        AutoSize = False
        Caption = 'Параметры перехода на новый сезон'
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
      object sgGroup: TAdvStringGrid
        Left = 0
        Top = 24
        Width = 457
        Height = 289
        Cursor = crDefault
        ColCount = 32
        DefaultRowHeight = 21
        RowCount = 13
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        GridLineWidth = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 3
        GridLineColor = 15062992
        ActiveCellFont.Charset = RUSSIAN_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Times New Roman'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 10344697
        ActiveCellColorTo = 6210033
        AutoSize = True
        Bands.Active = True
        Bands.PrimaryColor = 14811105
        Bands.SecondaryColor = clWhite
        CellNode.ShowTree = False
        ControlLook.FixedGradientFrom = 16513526
        ControlLook.FixedGradientTo = 15260626
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
        SearchFooter.Color = 16773091
        SearchFooter.ColorTo = 16765615
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
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22)
        RowHeights = (
          21
          21
          26
          21
          21
          21
          21
          21
          21
          21
          21
          21
          21)
      end
      object ComboBox1: TComboBox
        Left = 184
        Top = 101
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        Items.Strings = (
          '100'
          '300'
          '600'
          '1200'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400')
      end
      object AdvPanel2: TAdvPanel
        Left = 0
        Top = -224
        Width = 185
        Height = 41
        TabOrder = 6
        UseDockManager = True
        Version = '1.7.9.0'
        Caption.Color = clHighlight
        Caption.ColorTo = clNone
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clHighlightText
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        StatusBar.Font.Charset = DEFAULT_CHARSET
        StatusBar.Font.Color = clWindowText
        StatusBar.Font.Height = -11
        StatusBar.Font.Name = 'Tahoma'
        StatusBar.Font.Style = []
        FullHeight = 0
      end
      object AdvGlowButton4: TAdvGlowButton
        Left = 227
        Top = 121
        Width = 110
        Height = 25
        Caption = 'Открыть транзит'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 7
        OnClick = rbTranzOpenClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
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
      end
      object AdvGlowButton5: TAdvGlowButton
        Left = 418
        Top = 398
        Width = 110
        Height = 23
        Caption = 'Очистить календарь'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 8
        OnClick = rbClearKalClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
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
      end
      object AdvGlowButton6: TAdvGlowButton
        Left = 417
        Top = 394
        Width = 110
        Height = 25
        Caption = 'Очистить календарь'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 9
        OnClick = rbClearKalClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
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
      end
      object AdvGlowButton8: TAdvGlowButton
        Left = 416
        Top = 395
        Width = 110
        Height = 25
        Caption = 'Очистить календарь'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 10
        OnClick = rbClearKalClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
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
      end
      object AdvOfficeCheckBox1: TAdvOfficeCheckBox
        Left = 182
        Top = 235
        Width = 193
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Установить новый календарь'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        ReturnIsTab = False
        TabOrder = 11
        Version = '1.1.1.4'
      end
    end
  end
  object ConfMeterStyler: TAdvFormStyler
    AutoThemeAdapt = True
    Style = tsOffice2007Luna
    Left = 526
    Top = 7
  end
  object WinXP: TWinXP
    Left = 591
    Top = 65535
  end
  object AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler
    Style = psOffice2007Luna
    PageAppearance.BorderColor = 14922381
    PageAppearance.Color = 16445929
    PageAppearance.ColorTo = 15587527
    PageAppearance.ColorMirror = 15587527
    PageAppearance.ColorMirrorTo = 16773863
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = 15383705
    TabAppearance.BorderColorSelected = 14922381
    TabAppearance.BorderColorSelectedHot = 6343929
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 16709360
    TabAppearance.ColorSelectedTo = 16445929
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 14542308
    TabAppearance.ColorHotTo = 16768709
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 14016477
    TabAppearance.ColorMirrorHotTo = 10736609
    TabAppearance.ColorMirrorSelected = 16445929
    TabAppearance.ColorMirrorSelectedTo = 16181984
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
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = 9126421
    TabAppearance.TextColorHot = 9126421
    TabAppearance.TextColorSelected = 9126421
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = 15255470
    TabAppearance.HighLightColor = 16775871
    TabAppearance.HighLightColorHot = 16643309
    TabAppearance.HighLightColorSelected = 6540536
    TabAppearance.HighLightColorSelectedHot = 12451839
    TabAppearance.HighLightColorDown = 16776144
    TabAppearance.BackGround.Color = 16767935
    TabAppearance.BackGround.ColorTo = clNone
    TabAppearance.BackGround.Direction = gdVertical
    GlowButtonAppearance.BorderColor = 14727579
    GlowButtonAppearance.BorderColorHot = 10079963
    GlowButtonAppearance.BorderColorDown = 4548219
    GlowButtonAppearance.BorderColorChecked = 4548219
    GlowButtonAppearance.Color = 15653832
    GlowButtonAppearance.ColorTo = 16178633
    GlowButtonAppearance.ColorChecked = 11918331
    GlowButtonAppearance.ColorCheckedTo = 7915518
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 7778289
    GlowButtonAppearance.ColorDownTo = 4296947
    GlowButtonAppearance.ColorHot = 15465983
    GlowButtonAppearance.ColorHotTo = 11332863
    GlowButtonAppearance.ColorMirror = 15586496
    GlowButtonAppearance.ColorMirrorTo = 16245200
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
    Left = 377
    Top = 2
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Тарифное расписание|*.trf'
    InitialDir = 'c:\a2000\ascue\CounterProfiles'
    Left = 489
    Top = 2
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Тарифное расписание|*.trf'
    InitialDir = 'c:\a2000\ascue\CounterProfiles'
    Left = 561
    Top = 2
  end
  object ImageList2: TImageList
    Height = 32
    Width = 32
    Left = 411
    Top = 8
    Bitmap = {
      494C01010C000E00040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000008000000001002000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE00E8E8
      E800DCDCDC00DADADA00C4C4C400909090007D7D7D007777770083838300B1B1
      B100D5D5D500DCDCDC00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB009F9F9F0082828200818181008181810084848400ADAD
      AD00EEEEEE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5E2E000B1A9A400B2AAA400B3AB
      A400B4ABA500B5ACA500B3ADA500B2AEA500AFAFA600ACB0A600ABB1A700AAB2
      A800A8B2A800A8B2AB00A8B1AC00A7B0AE00A7AEB100A7AEB300A7ADB500A7AC
      B700A7ACB700A7ACB700A8ABB700A8ABB600A9AAB600A9A9B600A9A8B600A9A7
      B600A8A6B300A7A5B300A7A5B200D4D3DC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00FDFBFB00FBF7F600F9F4F200F8F2F000F8F2F000F8F3F100FAF6F500FCFA
      FA00FEFEFE00F0F4EF00CBDAC500C3D4BC00C3D4BC00C4D5BD00E1E9DD00FCFD
      FC000000000000000000000000000000000000000000E6E6E600A07B6900AC6A
      4B00B06F4F007F5B49008C8F9000C1C1C100D0D0D000CBCBCB00AEAFAF006059
      5500623D2B00A86A4D00AF6E4F00AD6D4E00AD6D4E00AD6D4E00AD6D4E00AD6D
      4E00AE6D4E00A26B5200A4A7A800C4C4C400C7C7C700C4C4C400A7A9AA006140
      300081645600ADADAD00F8F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C5C0BE00A97F6900BC805D00B87E
      5A00B87E5A00B87E5A00B87E5A00B87E5A0089925600699D61006AA46A006AA4
      6A006AA46A006AA46A006AA46A0065A073005480BB00638CCC00638CCC00638C
      CC00638CCC00638CCC00638CCC00617EA900726BC300645BA700645AA800645A
      A800645AA800645AA800665EAF00A4A1B0000000000000000000000000000000
      00000000000000000000000000000000000000000000FCF9F900F7F0EE00F1E4
      DF00EBD9D200E7D2CA00E5CEC700E5CDC600E5CDC600E6CFC800E8D3CC00EBDA
      D300F1E4DF00B7C6A8002C8E31002C8E31002D8E30002B8E300072A86B00FEFE
      FE0000000000000000000000000000000000F0F0F000CD784D00EBA99000F0BE
      AA00C7A69800AAAEB000E3E3E300E6E6E600E6E7E700E7E7E700E4E4E400D2D3
      D30078747300A6857700F5C7B200F1C5B000F1C5B000F1C5B000F1C5B000F1C5
      B000F4C7B100B9A19500C9CACB00E9E9E900EBEBEB00E9E9E900CDCECE007165
      6000D8917300A4604100B1B1B100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00F2EFEE00E4DFDD00D5CDC900C5BAB500CDC4
      C000F9F8F800000000000000000000000000C5C1BF00AF7D62009F7B5C009674
      5300967351009673510096735100967451007294530068866100668F6900648F
      6800648F6800648F6800648F68005E8E8100587DB0006173A5006072A5006072
      A5006072A5006072A5006072A5006687BD00736AC800756AA1007063A3006D5F
      A3006D5EA4006D5EA300665DB200A4A2B2000000000000000000000000000000
      0000000000000000000000000000FBF8F700F4EAE600EBD8D100E4CBC300E1C6
      BE00DDBEB300D9B4A300D8AE9B00D6AA9600D6A99300D8AC9700D9B2A100DDBD
      B100E1C6BE0098A67C0003911F00049523000492200004911F00509C5000FDFD
      FD0000000000000000000000000000000000B88F7B00E8AA9200EBBCA900F2C3
      AD0095929000DEDEDE00E5E5E500C2C3C400A19B9800A6A6A500E0E1E100E4E4
      E400B6B8B90075645C00E9C0AA00F1C7B000F1C7B000F1C7B000F1C7B000F1C7
      B000F5C9B2009D938E00DFE0E000E9E9E900EBEBEB00E9E9E900E1E2E2007773
      7100B8938200EB9C79007F675A00F4F4F4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F8F7F600E4DEDC00CDC3
      BF00B4A59F00A4928A009A867A009C887A00A9968600B7A79500C3B5A400A794
      8300B7A8A300000000000000000000000000C6C2BF00AF7E6400A7876B009F82
      65009F7D5D009F7B57009F7A57009F7A57007798570078917000759978006F99
      72006B9870006B986F006B986F00629587005B7FAE006674A1006270A1006270
      A1006270A1006270A1006270A1006686BD007B73CE00948CB3009087B200857B
      B0007C6FB1007668B3006A61B900A5A3B3000000000000000000000000000000
      000000000000FEFDFD00F7F0EE00ECDBD400E5CDC500E2C8C000DBB3A100DCA0
      7E00EBA97E00F7BB9000FFCCA600FFD4B000FFD1AA00FFC79C00F9B78600EDA4
      7200DE9B72009493620005982600009A2400009722000097230057A15800FEFE
      FE0000000000000000000000000000000000D7855E00E9B39F00ECBCA500E8BC
      A400A2A5A700E2E2E200D5D5D60081766E00F3C5AA00E7BEA600A5A5A400E3E4
      E400D8D8D80072696400DBB49C00F4C9AF00F3C8AE00F3C8AE00F3C8AE00F3C8
      AE00F1C6AD0098979800E1E1E100E7E7E700E8E8E800E7E7E700E1E1E1009495
      950095756700EFB39C009A5F4300EBECEC000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00F9F8F700F3F1
      F000E5DFDE00CFC6C200BBADA800A7968E009B867B009A847600A7948300BAAB
      99009A7E7800D3C8B700E2DACA00EBE4D600F1EBDD00F2EDDF00F2EDDF00D8CE
      BD00957E7300B9AEAB00DCDBDB0000000000C7C3C000B1806500B79A8300AE97
      8200AB927900A98B6E00A9856400A9825E007E9D5B008EA185008DA98F0086A6
      89007EA4820077A47B0073A37800679C8C006083B0006F7BA5006877A6006575
      A6006575A6006575A6006575A6006788BE008179D300A8A1C400A69FC3009991
      BF008B80C1008273C3006F66C100A6A4B5000000000000000000000000000000
      0000FDFBFB00F5EBE800EAD6CF00E6D0C900DEBBAB00E1996B00FCAD7100FFCC
      9D00FFD7B300FFDBBD00FFDEC500FFE1C900FFE1C900FEDEC500FEDABC00FFD4
      AF00FFC99800AC92460012A5380000A32B0000A0290004A32E005FA35E00FAF9
      F80000000000FEFEFE00FEFEFE0000000000D5835D00E8B29A00EEBBA100DAB1
      9A00AFB1B300E2E2E200C8C9C90071625700D9AF9700F2C3A6009F9A9500E1E2
      E200D9D9DA007D787500D2AB9100F5C8AC00F4C7AB00F4C7AB00F4C7AB00F5C7
      AB00DEB8A000A9ABAD00E0E0E000E5E5E500E5E5E500E5E5E500E0E0E000AFB0
      B10081695E00EBB09600A0634800EAEAEA000000000000000000000000000000
      0000FBFAFA00F1EEED00E4DFDD00D1C8C500BCAFAA00AB9A9200A18D84009B85
      7900957C7200B6A79600C6B9A800D4CABA00E0D8C900E9E2D400EFE9DC00F4F0
      E300AD959000E6DED200F2EDDF00F2EDDF00F2EDE000F3EEE000F3EFE100E0D8
      C8009B867900D2C4B9007F777500F8F8F800C8C4C100B2816700C8AD9800C6B3
      A200C2AE9B00B79D8600B5947700B58E6A0084A26000A3B39900A7BDA700A1B9
      A20093B2950087B18B007EB083006EA592006587B3007B86AA007582AB006D7C
      AC006979AD006879AD006878AD006789C000837CD800AFA9D000AEA8D000A39B
      CE009589D1008A7AD4007369C900A6A4B700000000000000000000000000FDFB
      FB00F5ECE900EAD8D100E9D5CF00D8A68A00EF965300FFC18900FFCEA800FFD2
      B000FFD9BB00FFE0C900FFE6D300FFE9D900EFDFCA00C8C5A100BFBD9400C1B7
      8900C6B28100879852001AB2470000AC320000A9310006AC38004D9F5100B6C1
      A500C0D1B800C0D2B800C0D2B800DCE6D800D5825C00E8AF9400EEB89B00D9AF
      9700B0B2B400DFDFDF00DCDCDC008B8B89007362560082766D00BEBFC000E0E0
      E000D7D8D800807B7800D3A88D00F7C6A700F5C5A600F5C5A600F5C5A600F7C6
      A600C8A99500B1B4B500DBDBDB00E1E1E100E2E2E200E1E1E100DBDBDB00B5B7
      B800836E6300E9AB8F009F634800EAEAEA00FEFDFD00DAD3D000BEB1AC00AD9D
      95009B857D009F8B7F00A7958500B4A49300C5B8A800D4C9BA00E0D8C900E2D9
      CC00B39C9600F4F0E300F4EFE300F4EFE300F4EFE300F4EFE200F4EFE300F6F2
      E600B6A19B00E0D6CB00EFE8DC00E5DCD100D7CBC100C8B7AF00B8A49D00B5A0
      97009C877900D9CDC100796E6C00F6F6F600C9C5C200B2826700D0B49F00CEBB
      AA00CBB6A400C1A79000C09E8000C09772008AA76400ABBCA100AEC6AF00A9C3
      AA009CBD9E0090BC940086BB8B0073AC98006C8EB8008993B200838FB1007B89
      B2007383B3006D7EB4006C7DB400688AC200847DDB00B3ADD900B1ABD900A89F
      D900998DDC008D7DDE00756ACE00A7A4B8000000000000000000FEFDFD00F8F1
      EF00EEDED800ECDBD500D4997500F3984F00FFC18F00FFC9A100FFCCA600FFD4
      B400FFDDC400FFE3CE00FFE7D500FFEADB00C3C8A5000E9B2B00109F300011A0
      3100119F300011A9390007B9430000B53B0000B23A0000B038000EAB3B000F98
      2C0010962A00109428000B91220063A86400D5815A00E7AA8D00EDB49400DAAC
      9000AEB0B200DDDDDD00DEDEDE00D9D9D900C2C3C400CDCECE00DDDDDD00E0E0
      E000D5D6D600807A7600D1A58700F6C2A000F4C19F00F4C19F00F4C19F00F4C1
      9F00E9BA9B008F929400CECFCF00DBDBDB00DDDDDD00DBDBDB00CFD0D0008F92
      9400C1947C00ECA98B009F634700EAEAEA00EBE7E500A7938600C4B6A600D4C9
      BA00B9A59D00DCD1C600F1ECDF00F4EFE300F5F1E500F5F1E500F5F1E500F2EE
      E200AF979200F9F6EA00F8F4E800F4EFE400EAE2D800DBCFC600C8B8B000B6A1
      9B00977976009B7E7B00A58A8600AE969200BDA9A300CCBCB500DACEC500E0D6
      CA009B867800D8CCC0007A6E6C00F4F4F400C9C6C300B3836900D9BCA700D8C4
      B200D5BFAD00CDB29A00CCA98A00CCA17B0090AC6800B1C5A800B5CFB600B1CD
      B200A5C9A70098C79C008DC6920078B59D007495BF009EA7C0009BA4BF008F9A
      B9008390B9007788BA007285BB006A8CC400847DDD00B0AADF00AFA8DF00A49C
      E000968AE400897AE6007369D200A7A4BA000000000000000000FBF8F700F2E7
      E300F1E4E000D39B7900F0914500FFBA8300FFC19100FFC29400FFC9A100FFD4
      B300FFD9BD00FFDEC500FFE3CE00FFE8D700EFDFCA003EAF510000C94D0000C4
      480000C5490000C3470000BF440000BE440000BB410000B83E0000B33A0000B2
      390000AC340000A73000019F2A00B3D0AF00D47F5700E6A38400ECAF8C00D9A8
      8C00AAADAF00DBDBDB00DFDFDF00DEDEDE00DEDEDE00DDDDDD00DFDFDF00DEDE
      DE00D2D2D3007F797600D2A18000F4BD9900F3BB9800F3BB9800F3BB9800F3BB
      9800F5BD9800DBAE910099928C00CDCECF00D8D8D800CFCFCF0088848100C99B
      8200EDAD8C00E8A281009F634600EAEAEA00EAE4E200ECE6DC00F8F4EA00F7F3
      E900D2C4BD00DBCFC700F7F2E700F4EFE500EFE8DF00E6DDD400DACEC500CCBC
      B50097787600AF979200A78D8900A78D8900B0999400C0ADA700D2C4BC00E3DA
      D100C6B5AE00CFC0B800FAF7EC00F9F5EB00F7F3E900F7F3E800F7F2E800F2ED
      E2009D887A00D1C4B9007B706D00F5F5F500C9C6C300A9775E00DABCA700DAC5
      B300D8C1AE00D2B59D00D1AC8C00D1A47B0092AE6900ADC2A400AAC5AB00A6C4
      A8009BC29E008DC0920082BF880070AF95006F92BA00969FB800959EB8008994
      B2007C8AB1006E80B3006679B3005B7EB7007069CD009C94D2009A92D2008E83
      D4008072D7007464D9006257C500A7A4BA0000000000FEFDFD00F8F2F000F6ED
      EB00DBB49F00E5802F00FFAD6B00FFB37800FFB17500FFB67E00FFC49600FFCC
      A600FFD2B000FFD8BA00FFDEC500FFE3CE00FFE4D000E1D0B0002EB9530006D0
      570000C94B0000CA4C0000C84B0000C64A0000C3470000BF440000BA400000B5
      3B0000B1370010B3430093C2930000000000D47E5400E49D7C00EBA88400D8A4
      8400A8ABAD00D7D7D700DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DCDC
      DC00CFCFD0007E797400D19D7900F3B99100F1B88F00F1B88F00F1B88F00F1B8
      8F00F1B88F00F6BA9000C39E8400B8BABC00D2D2D200BCBDBE007B675900E9A9
      8400E8A58200E69A78009F624400EAEAEA00EFEBEA00DDD3CC00E3D9D100D7CA
      C200B8A49F00AB928E00B59F9B00B19A9600B39D9800BBA7A200C7B6B000D8CC
      C400A88E8A00EEE8DE00F7F3E800FAF6EC00FAF7ED00F9F6EC00F8F5EB00F8F4
      EA00D7CBC400C3B1AC00F9F6EC00F8F4EA00F8F4EA00F8F4EA00F8F4EA00F7F3
      E800A5918200D0C3B8007D726E00F3F3F300CBC7C400B4846900E8C9B400E9D2
      C000E8CFBB00E3C4AB00E2BB9A00E2B2880099B46E00B7CFAD00BAD9BB00B6D8
      B800ACD6AE009ED5A20092D498007CBEA1007A9CC500AAB3CC00A9B2CC009EAA
      C800909FC8008295C9007B8FCA006C8FC8007F77DE00A399E200A298E3009387
      E5008576E8007A69EA006B61D400A8A5BB0000000000FDFBFB00F8F3F100EEDE
      D800D57A3500FE9B4C00FFA35B00FF9F5500FF9F5500FFB57C00FFC39400FFC8
      9F00FFCFAA00FFD4B400FFDABE00FFDEC500FFDFC700FFDBC100C6BC8E0043D4
      760026DE730017D7650012D561000ED25C000DCF59000ECB560012C7550016C3
      540036CC6D0078BC7F00FDFBFB0000000000D37B5200E2977200E9A17B00D79E
      7D00A6AAAC00D5D5D500DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00D9D9
      D900CCCCCC007E777300CF977300F4B48A00F2B38900F2B38900F2B38900F2B3
      8900F2B38900F4B48900C29B8100AFB2B400CDCDCD00B3B5B6007D675800E6A1
      7B00E79F7900E4947000A0624400EAEAEA00F3F1F000B49E9A00C5B4AF00D0C2
      BC00D0C2BC00C0ADA800F2EDE500F8F4EB00FAF7EE00FBF8EF00FBF8EF00FCFA
      F100B49D9900F3EEE500FAF7ED00FAF7ED00FAF7ED00FAF7ED00FAF7ED00FAF7
      ED00E1D7CF00BCA8A300FBF8EF00FAF7ED00FAF7ED00FAF7ED00FAF7ED00FAF7
      EE00A8968800C8BAAF007F737000F4F4F400CBC7C400B5846A00EDCDB800EFD6
      C400EED4C000EBCAB100EBC19E00EBB88C009DB67000B5D2AC00B8DBBA00B4DA
      B700A9D8AC009CD7A00091D796007BC0A0007C9EC700AEB8D200ADB7D200A3AF
      CE0094A4CE00869AD0007E94D2006C90CA008079DF00AEA6E000B2ACE000A69D
      E2008B7DE7007868EB00685FD400ABA9BC0000000000FCFAFA00FEFDFD00D49E
      7D00EA832F00FA944300F8904000F9913F00FF9C4F00FFBC8900FFC19100FFC5
      9900FFCBA300FFD0AD00FFD5B500FFD8BB00FFD9BC00FFD6B800FFD3B100A9B1
      760062EA9C0044E98C0042E5870042E3860043E0830043DD80003FD87B005BE0
      900065A95C00F2F2EE00FDFBFB0000000000D27A5000E1906900E89B7300D69B
      7700A3A7A900D2D2D200D8D8D800D7D7D700D7D7D700D7D7D700D8D8D800D6D6
      D600C9C9C9007D767100CE936C00F3AE8200F1AC8100F1AC8100F1AC8100F1AC
      8100F1AC8100F3AD8100C1987C00ABAEB000C9C9C900AFB1B2007C655700E39C
      7300E5997100E38E66009E614300EAEAEA00F8F6F600DACFCA00FCFAF200FBF9
      F100F0EAE300C3B0AC00FCF9F200FBF8F000FBF8F000FBF8F000FBF8F000FCFA
      F100BCA8A400EDE7E000FBF8F000FBF8F000FBF8F000FBF8F000FBF8F000FCF9
      F000ECE5DE00B49E9B00FDFBF400FCF9F000F7F2EA00EEE8E000E2D9D300D6CA
      C300B2A09200C0B0A60080747000F3F3F300CBC7C400B5846B00F3D0BA00F5DA
      C700F4D7C200F2CEB400F2C5A100F2BB8F009FB87000B1D2A900B5DCB700B0DB
      B300A5D9A80098D89D008DD7930078C09E007EA1CA00B1BBD700B0BBD700A7B4
      D50099AAD500899FD7008097D8006D91CC008780DE00C0BBDE00C0BCDE00B6AF
      E000A198E4008576E9006B61D500ADABBD00FEFEFE0000000000F5ECE800D075
      2E00EA833100EB843300EC853400F28A3800FD9C5100FFC29200FFBD8B00FFC1
      9200FFC79C00FFCCA500FFD0AC00FFD2B000FFD3B200FFD4B300FFD3B200FFD1
      AF0091B4710081F7B7005BED9B0058EB980055E9940051E48E0067EA9F0072C5
      7A00BA6A1700EAD4CA0000000000FEFEFE00D1794D00DF896100E6966900D595
      7100A1A5A700CFCFCF00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D4D4
      D400C5C6C6007D746F00CF8F6400F1AA7900F0A97800F0A97800F0A97800F0A9
      7800F0A97900F4AB7900C4977900AAADAE00C8C8C800AEB0B0007D645400E79A
      6C00E6946900E1885E009F614300EAEAEA00FBFAF900D4C7C300FDFBF400FDFA
      F200F5F1EB00BEABA700FDFBF400FDFAF300FDFAF300FDFAF300FDFAF300FCFA
      F200C7B6B100DED4D000F3EEE700EDE6DF00E3DBD500D8CDC800CEBFBA00C4B2
      AD00B49D990094757300AB928F00A9908D00AC949100B49E9B00C0ADA900CEBF
      BA00B8A89B00B3A1980081757100F3F3F300CCC7C500B5846B00F6D1B900F8DB
      C600F8D8C200F6CFB300F6C6A100F6BC8E009FB86F00ABD1A400AFDBB200AADA
      AE009DD8A20091D7970088D68E0075C09B007FA3CC00B4BFDA00B3BFDB00AAB8
      D9009CAEDB008CA2DD00839ADE006B8FCD00B7B4EC00B0ADE900AFACE900AEAB
      E900ACA8E900A9A5EA00A29EDA00B2B1BD000000000000000000E0BEAA00D46D
      1A00DE772700E0792800E47D2C00EC843200FD9C5100FFC49800FFB98300FFBC
      8A00FFC39400FFC79C00FFCAA200FFCDA700FFD0AD00FFD4B300FFD6B700FFD7
      B800F9D2AF008CC28300A2FCCC007AF0AD006EEEA60074F1AC0088E3A600AC75
      2000D46D1900D4A07E000000000000000000D1764B00DD835900E5906100D491
      69009FA3A500CDCDCD00D3D3D300D4D4D400D4D4D400D4D4D400D4D4D400D2D2
      D200C2C3C3007C746F00CE8B5E00F0A57200EFA37200EFA37200EFA37200EFA4
      7200F3A67000DD935D0099755C00A3A4A800BEBEC100A6A6AA006D564900A265
      3A00C77A4F00E08155009F614200EAEAEA00FCFBFB00CFC2BD00FCFAF500F7F4
      EE00EDE7E300B49F9B00E3DAD400DACEC900CFC0BD00C6B6B200C0ADA900BAA6
      A200A68B8900A78E8B00B8A4A000BDA9A700C6B4B100D0C2BE00DCD0CB00E5DD
      D800E8E0DD00AB929000F8F5EF00FEFCF500FEFCF600FEFCF600FEFCF500FEFD
      F500CBBEB200AD9A8F0082757100F1F1F100CCC7C400B5846B00F7D1B700FADA
      C400F9D8BF00F9CFB000F9C59E00F9BC8C009FB86E00A5D19E00A9DAAD00A4DA
      A80096D89B008BD7900082D6880070C0960080A4CE00B5C2DF00B5C2DF00ACBB
      DF009EB1DF008DA5E100849DE3006A8ECE00FFFEFE00FFFEFE00FFFEFE00FFFE
      FE00FFFEFE00FFFEFE00EAEAE900B5B4BC000000000000000000CB926900D26A
      1700D46D1C00D8712000DC752400E77E2C00FD9C5100FFCDA700FFBF8D00FFB7
      8100FFBA8600FFBF8E00FFC39600FFC9A000FFD1AD00FFD6B800FFDABF00FFDC
      C200FFDBC000E7CAA50099D6A000B4FCD60095F4BF00A6F7CB00957A2300D26B
      1A00D2691700C1773D000000000000000000D0744900DC7D5000E48A5900D48D
      63009DA1A400CBCBCB00D1D1D100D0D0D000D0D0D000D0D0D000D0D0D000D1D1
      D100BEBFC0007B736D00CD875800EFA16B00EDA06A00EDA06A00EEA06B00F5A2
      6600916B73001D49C000336EE8003A73E4003972E3003B73E4003973E9001D51
      CE00302E6400A0552D009F614200EAEAEA00FDFDFD00BFADA900BBA7A400BDA9
      A500C1AEAA00A48A8700CABAB800D6CAC600E0D6D200E9E1DC00EEE9E500F4F0
      EC00D9CECB00CFC1BD00FFFDF700FFFDF700FFFDF700FFFDF600FFFCF600FFFC
      F500F9F6F200AF979400F7F4EF00FFFCF500FFFCF500FFFCF500FFFCF500FFFD
      F600D6CCC000A793880083767200F2F2F200CCC7C400B5846A00F8CFB400FBD8
      BF00FAD6BB00FACDAB00FAC39900FABA8800A0B76D00AAD1A300B3DBB600B2DB
      B500A3D9A8008DD7930082D688006EBF930080A5D000B6C4E200B5C3E200ADBD
      E2009EB4E3008DA7E50084A0E6006A8FCF00FFFFFE00FFFFFE00FFFFFE00FFFF
      FE00FFFFFE00FFFFFE00EAEAEA00B8B8BD000000000000000000BF763C00D067
      1500CF681700D46D1C00D56E1D00E1772400FEA86600FFE4CF00FFDEC500FFCF
      AA00FFD0AD00FFDCC100FFE4CF00FFE9D900FFEEE100FFF0E500FFF0E600FFEF
      E400FFECDF00FFE6D300CFC7A100AEEDC400D4FFEE009BB26F00DB711F00CC65
      1400D1691700C1641B00EDEBE90000000000D1724700DA784900E3855300D289
      5E009CA0A300C9C9C900D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000CECE
      CE00BFC0C0007A726D00CB825100F09D6500EE9C6500EE9C6500F29D6300A877
      7500296CEA008AC6FC0093CFFC0096D1FD0096D1FD0097D1FD0094CFFC008DC9
      FC004D8EF6002E2A670083513500EAEAEA00FEFEFE00CCBEBB00F5F2F000FDFB
      F600FEFDF700C2B0AC00F3EFEC00FFFDF700FFFDF700FFFDF700FFFDF600FFFD
      F600E7DFDB00C5B3B100FFFDF800FFFDF600FFFDF600FFFDF600FFFDF600FFFD
      F600FCFAF500B29B9900F1EDEA00FFFDF600FFFDF600FFFDF600FFFDF600FFFD
      F700DFD7CD00A08A7F0082757100F1F1F100CBC7C300AC7B6100F2C8AA00F5D1
      B500F5CEB000F4C4A000F4BB8E00F4B27E00A0B56A00B0CCA700B6D1B800B5D1
      B700A8D0AB008FCD940079CA7F0066B68B00799FCB00A9B9D900A8B8D9009FB1
      D80091A8DA00809BDC007795DE005F84C500BAB9B900B9B9B900B9B9B900B9B9
      B900B9B9B900B9B9B900ACACAC00B9B9BB0000000000F1F1F100BD672200D46B
      1900D66F1D00D86F1D00D56D1C00E9883C00FFC79B00FFF5EF00FFF9F500FFEC
      DD00FFE2CD00FFE0C900FFE0C800FFE2CD00FFE6D300FFEBDB00FFEFE300FFF3
      EA00FFF3EB00FFECDE00FFE5D300B7CCA50096D19F00FBD5B400E37E2F00CC64
      1200CF681700CB600C00D8D3CF0000000000CF714400D9724300E1814C00CD85
      5A009FA3A600C9C9C900CECECE00CDCDCD00CDCDCD00CDCDCD00CECECE00CDCD
      CD00C0C0C1007D787300B16F4200F09B6000ED985E00EC985E00F79B58002E51
      C00078BCFB0087CCFD008CD1FE008BD0FF008CD1FF008BD1FF008CD0FF0089CE
      FE007EC2FC001F5CE000613B2700E9EAEA0000000000D3C7C400F7F4F000FFFE
      F700FFFEF700C7B7B500ECE6E300FFFEF700FFFEF700FFFEF700FFFEF700FFFE
      F700EFEBE500BDAAA800FFFEF900FFFEF700FFFEF700FFFEF700FFFEF700FEFE
      F700FCFBF700B8A3A000E9E3E000F8F6F200F6F4EF00F5F1EC00F1EDE700ECE7
      E100D7CCC4009D877B0081746F00F0F0F000CCC7C300B1806500F5C8A700F8D0
      B200F8CDAC00F7C39B00F7B98A00F7B07A00A1B46900BAD0B100BFD8C000BAD7
      BC00B1D6B300A1D4A4008CD190006DBB92007BA1CF00AEBEE100ADBDE100A3B7
      E10096AEE30085A2E5007C9BE700648ACB00DDDDDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00CCCCCC00BDBDBD0000000000EDEEED00BD641F00DD73
      1F00E17A2900EE934D00F69E5900F5954C00FCB98500FFEFE300FFF3EA00FFDB
      C000FFD1AF00FFD2B000FFD4B400FFDBBF00FFE1CA00FFE7D500FFEEE100FFF4
      ED00FFF8F300FFF3EA00FFE7D500FFE0C900FFD9BC00FFC89D00DF7B2E00CC64
      1200D0681700CB600C00D1CBC70000000000D0714300D86E3D00E37C4400A379
      6100B0B3B500CACACA00CDCDCD00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CDCD
      CD00C4C4C400989B9D0070482F00DB885200EE955A00ED935900F9965100195D
      E2006EBCFB0076C7FE0078C9FF0078C9FF0078C9FF0078C9FF0078C9FF0077C8
      FE0072C0FC00387EF1004D363E00E9E9E90000000000DAD0CD00F2EFEB00FFFE
      F800FFFEF900D0C2C000E3DBD700FAF8F300F6F4F000F2EEEB00EEE9E600EBE5
      E000DFD6D100AB939100DACECB00D3C6C300CCBCBA00C6B5B300C1AFAC00BCA9
      A500B9A4A0009C807E00A98F8C00B19B9700B19A9700B19B9800B49E9C00B6A1
      9F00C1B0AA00967F73007F716D00F1F1F100CCC7C400B5846900F8C6A300FBCF
      AD00FACBA700FAC09400FAB78500FAAF7600BEAC6500A2C38B00A6D8A600A5D7
      A500A3D7A300A1D7A1009ED69E0084BFA6007B9ED200AFC1E800AFC0E800A5BA
      E90097B1EA0088A6EC007F9FEE00688ED100FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EAEAEA00BEBEBE0000000000EDEEED00BF661F00E982
      3300F7A66800FCA86800E27C2D00DD7C2F00FDC09000FFDFC700FFECE000FFD1
      AE00FFD0AD00FFD2B000FFD4B400FFDABE00FFE0C900FFE6D400FFEDE000FFF4
      EC00FFF8F300FFF3EA00FFE8D800FFD7BA00FFB37800FFAD6E00DE7B2E00CC65
      1300D0691700CA5F0C00D1CBC70000000000CF704200D96A3600BF7045009195
      9800C1C2C200CBCBCB00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
      CD00C8C8C800B9BABA00817E7D007B4B2A00E58D5300EC925600F8944D00155C
      E4005DB6FB0061BFFE0062C0FF0062C0FF0062C0FF0062C0FF0062C0FF0062C0
      FF005DB9FB00317CF0004C364000E9E9E90000000000E2DAD800BCA9A600BEAA
      A800BBA8A500AA928F00AA928F00BAA6A200BAA6A200BCA8A500C1AEAB00C1B0
      AD00C4B3B100A3888600CFC1BE00D8CCC900DED5D000E3DBD600E9E2DE00ECE6
      E300F0ECE900C2B0AE00D8CCC900FAF8F300FDFCF600FEFDF700FFFEF800FFFE
      F800F1EDE600998376007E6F6B00F0F0F000CCC7C400B5846900F8C39D00FBCB
      A700FAC7A100FABB8C00FAB27D00FAAA6F00F19C6200F2C8B400FFFFFE00FFFF
      FE00FFFFFE00FFFFFE00FFFFFE00CBD9EE007898D100ADBFE900ACBFE900A1B7
      E90094AEEB0084A3ED007C9DEE00688ED100FFFFFE00FFFFFE00FFFFFE00FFFF
      FE00FFFFFE00FFFFFE00EAEAE900BEBEBE0000000000F4F5F400C4702B00F698
      4F00FD9D5200FB913E00E7803000F7B48100FFCBA300FFD0AE00FFEEE300FFD6
      B700FFCFAB00FFD1AF00FFD3B200FFD8BA00FFDEC500FFE4D000FFE9DA00FFEE
      E200FFF0E600FFECDE00FFE3CE00FFD6B600FEB07400FFA66100E4823600D068
      1700D0691700C75E0C00DAD5D20000000000D06F4100D066320087878600B9B9
      BA00C8C8C800CCCCCC00CDCDCD00CCCCCC00CCCCCC00CDCDCD00CDCDCD00CDCD
      CD00CCCCCC00C6C6C600AFB0B100746D68009D5D3300EE925500F9944A000D58
      E40048ACFB004BB7FE004CB6FF004BB6FF004BB6FF004BB6FF004CB6FF004BB7
      FF0049B1FB002576EF004D374000E9E9E90000000000EAE5E300DBD1CD00F3F0
      EB00F6F3EF00DFD5D200CFC1BF00FBFAF500FDFBF600FDFDF700FEFEF700FFFE
      F700FBF9F500B7A29F00F9F7F200FFFEF700FFFEF700FFFEF700FFFEF700FFFE
      F700FFFEF700D0C3C000D1C4C100FFFEF700FFFEF700FFFEF700FFFEF700FFFE
      F700F5F2EA00988276007C6C6800F0F0F000CCC7C400B6846900F8C4A000FBD0
      B000FBCFAF00FAC29900FAB27F00FAA96E00F0995E00F1C8B300FFFEFE00FFFE
      FE00FFFEFE00FFFEFE00FFFEFE00CBD9EE007697D100A9BEE900A8BDE9009DB5
      EA008FAAEB0080A0ED00789BEF00678DD100FFFEFE00FFFEFE00FFFEFE00FFFE
      FE00FFFEFE00FFFEFE00EAE9E900BFBFBF000000000000000000C3824800F88C
      3A00FF9C4E00FF9D5200FCB17600FFCAA100FFC9A100FFCDA600FFEBDD00FFE4
      D000FFCEAA00FFD1AE00FFD1AF00FFD5B500FFDABF00FFDFC800FFE4CF00FFE7
      D500FFE7D600FFE3CF00FFDBC000FFCEA900FFB88200FFAC6C00E8863800D971
      2000D56D1A00BC611A00ECEBEB0000000000D26E3F009D705C00AAADAF00C6C6
      C600CBCBCB00CBCBCB00CBCBCB00CCCCCC00CCCCCC00CBCBCB00CBCBCB00CBCB
      CB00CCCCCC00CBCBCB00C2C2C2009FA2A4006D503C00D8834B00FB954B000553
      E30033A4FB0036AEFE0037AFFF0036AFFF0036AFFF0036AFFF0037AFFF0036AF
      FF0033A7FC00196FEE004D374000E9E9E90000000000F0EDEC00DBD1CD00FFFE
      F700FFFEF700EBE5E200CABAB800FFFEF700FFFEF700FFFEF700FFFEF700FFFE
      F700FDFCF600BBA8A400F2EEEB00FFFEF700FFFEF700FFFEF700FFFEF700FFFE
      F700FFFEF800DACFCC00C8B8B600FFFEF800FFFEF700FFFEF700FFFEF700FFFE
      F700F9F8F100A59184007A696400EEEEEE00CBC7C400B6846A00F9CEB000FCDF
      C900FCE0CB00FCD5B800FAC09600FAAD7500F09A6000F1C8B300FFFEFD00FFFE
      FD00FFFEFD00FFFEFD00FFFEFD00CBD9EE007495D100A5B9E900A4B8E90098B1
      EA008AA7EC007C9EED007498EE00668CD100FFFEFD00FFFEFD00FFFEFD00FFFE
      FD00FFFEFD00FFFEFD00EAE9E900BFBFBE000000000000000000C4A57F00FA8C
      3A00FFA76100FFAD6E00FFD2B000FFCCA600FFCBA300FFCCA600FFDEC600FFF3
      EB00FFD2B100FFD0AD00FFD0AD00FFD2AF00FFD6B600FFDABE00FFDDC400FFDF
      C700FFDEC500FFDABE00FFD2B100FFC59800FFB37800FFB57C00EE8A3C00E37C
      2A00DE731F00B57642000000000000000000CE6C3F008A8E9100BCBCBC00D2D2
      D200DCDCDC00E1E1E100E6E6E600E7E7E700E7E7E700E7E7E700E5E5E500E0E0
      E000DCDCDC00D7D7D700CDCDCD00B5B6B60077726F00AF673900FC954C00004F
      E300209BFA0023A6FE0022A7FF0022A6FF0022A6FF0022A6FF0022A6FF0022A7
      FF00219FFC000F68ED004E374000E9E9E90000000000F5F2F200D3C6C300FDFC
      F700FCFBF500EEE9E600C1AFAC00F5F3EE00F4F1EC00F3F0EA00F0EDE700EDE9
      E300EAE6DF00B5A19C00D9D0CB00E6E0D700E2DCD100DED6CC00DAD2C700D8D0
      C500D3CABF00BEAFA400A48D8400C5B9AD00C1B5A800BEB1A300B9AB9D00B5A7
      9900AFA0900088705C0077655F00EEEEEE00CBC7C500B6856B00F9D7C100FDE7
      D600FDE5D300FCDCC400FBCEAD00FAB98900F09F6700F1C8B300FFFEFC00FFFE
      FC00FFFEFC00FFFEFC00FFFEFC00CBD9ED007194D100A0B6EA009FB6EA0092AE
      EB0084A4EC00779BEE006F96EF00658CD100FFFEFD00FFFEFC00FFFEFC00FFFE
      FC00FFFEFC00FFFEFC00EAE9E800BFBEBE000000000000000000D7D7C600F182
      3100FFAF6E00FFBE8C00FFE2CC00FFD3B100FFCDA600FFCFAB00FFD2B000FFF4
      EC00FFE2CD00FFCEAA00FFD0AD00FFCFAC00FFD1AE00FFD4B300FFD6B600FFD6
      B700FFD4B500FFD0AC00FFC99F00FFBA8500FFAF7100FFBD8A00F6914200ED85
      3400E2731E00BAA189000000000000000000BC724F00A8ADB000E1E1E100E8E8
      E800E8E8E800E8E8E800E7E7E700E6E6E600E7E7E700E7E7E700E7E7E700E7E7
      E700E8E8E800E8E8E800E8E8E800E1E1E100A0A4A60096603C00FC934600004A
      E2000F92FA0012A0FE00129FFF00129FFF00129FFF00129FFF00129FFF0012A0
      FF001298FA000663ED004E384000E9E9E90000000000F8F6F500A2907F009581
      6C00937E68008E786300856D58008B765F0089735C0088725A00866F57008771
      5A0087715900826B5400836C5400826C5400846E570087715A00856F5700846E
      5600836E56008570580089745D0088735C0087735C0088735C0089755D008C79
      61008D7A6300836D540072615600ECECEC00CBC8C600B78B7400F1BB9D00F3C1
      A400F3BFA100F3BB9B00F2B79300F2AF8600E89B6C00F3D0BD00FFFDFB00FFFD
      FB00FFFDFB00FFFDFB00FFFDFB00CBD8ED007193D100A2B8EA00A4B9E90098B1
      EB0085A4ED00769BEE006D95F000648CD100FFFDFC00FFFDFB00FFFDFB00FFFD
      FB00FFFDFB00FFFDFB00EAE9E800BFBEBE000000000000000000F8FBF900D68D
      4B00FFAD6E00FFCAA200FFECDD00FFDDC300FFCFAB00FFD1AE00FFCFAB00FFE2
      CD00FFF6F000FFD2B100FFCEA900FFCFAA00FFCEA800FFCDA700FFCEA800FFCE
      A800FFCBA300FFC69A00FFBD8C00FFB07300FFB37900FFC49700FF994A00F68D
      3B00D26D2000E0E0DC000000000000000000B1795D00D3D7D800E8E8E800E9E9
      E900E8E8E800E9E9E900E6E6E600E4E5E500C4C6C700D2D3D400E6E6E600E8E8
      E800E9E9E900E8E8E800E9E9E900E7E7E700B9BABB00907D7000FFD5B000195C
      E000219CFA000097FE000298FF00059AFF00069AFF00069AFF00069AFF00069B
      FF000694FB00005FEC004F384100E9E9E90000000000FDFDFC00C1B5A900B0A1
      9000B1A19000B1A19100B2A392009E8E7F00AF9F8F00B2A29200B2A29200A898
      88008C7C6D00B0A09000B2A29200B2A29200A69787007A6A5C00A0918100B2A3
      9200B2A29200AE9F8F00806F610074635700B1A19100B2A29200B2A29200B2A2
      9200B2A29200A6927F007B685C00EEEEEE00CBC8C70088858200ABA39F00ABA3
      9F00ABA39F00ABA39F00ABA39F00ABA39F00776F6B00ABA8A600ADACAB00ADAC
      AB00ADACAB00ADACAB00ADACAB00919EB2006D8EC9009FB0D900A5B4D8009DAF
      DA00849FDD006A8EDF005F87E000567EC300AEADAB00ADACAB00ADACAB00ADAC
      AB00ADACAB00ADACAB00A2A1A000BDBCBC00000000000000000000000000D4CF
      B100FD965000FFD0AA00FFF1E700FFE9D900FFD6B700FFD2B000FFD2B100FFD2
      B100FFF2EB00FFE9DA00FFD0AD00FFCFAB00FFCDA600FFCAA200FFC89E00FFC6
      9A00FFC29400FFBD8A00FFB57B00FFAD6F00FFC39400FFC89D00FFA05500F888
      3400BE9A7300000000000000000000000000AE7A6000DBDFE000E9E9E900EBEB
      EB00EBEBEB00E9E9E900E5E5E6008F8B8A00CEB3A000BBA79900BABCBD00E9E9
      E900EBEBEB00EBEBEB00EBEBEB00E9E9E900C0C1C20093807300FFDABA003F72
      E100A7D8FD0088CFFF0043B4FF000199FF000095FF000097FF000098FF000099
      FF000091FB00005EEC004F384100E9E9E9000000000000000000D9CDC500CBBB
      AE00CBBBAE00CBBBAE00A6958900806D6200A7968B00CCBCAE00C4B4A7008C7A
      6E0084716600BCAC9F00CBBBAE00C9B9AC008F7C7000907B6F00A5958800CCBC
      AE00CBBBAE00A29083009A84760087736700C7B7AA00CBBBAE00CBBBAE00CBBB
      AE00CBBBAE00C2AE9D00836E5F00ECECEC00CBCAC800C2C1BF00FFFCF900FFFC
      F900FFFCF900FFFCF900FFFCF900FFFCF90099989700FBF8F600FFFCF900FFFC
      F900FFFCF900FFFCF900FFFCF900CBD8EB007898D000B7C5E600BDC9E500B5C4
      E6009FB5E9007EA0ED007097EE00638BD000FFFCFA00FFFCF900FFFCF900FFFC
      F900FFFCF900FFFCF900EAE8E600BFBEBE00000000000000000000000000FAFD
      FA00DEA06100FFBD8C00FFF2E900FFF3EA00FFE1CA00FFD4B400FFD4B400FFD2
      B000FFDCC200FFFBF900FFEBDC00FFDBC000FFCEA900FFC9A000FFC79B00FFC3
      9500FFBF8D00FFB98300FFB27600FFB88100FFD5B500FFC59900FFA05400D97C
      3200E6E9E300000000000000000000000000B57B6000D3D6D800EBEBEB00ECEC
      EC00ECECEC00EBEBEB00B9BBBB00A28F8000FEDBC400FFDAC300A89F9800E8E9
      E900ECECEC00EBEBEB00ECECEC00EAEAEA00B7B8B900A38D7F00FFDFC1004172
      E200A6D8FD00A3D9FF00A7DAFF00A7DBFF0066C1FF0018A2FF000094FF000097
      FF00008FFA00005BEC004F384000E9E9E9000000000000000000D7CCC300B9A3
      9100B9A39100B49E8D00A8928400A08B7D00A9948300B9A49200A8938300B29B
      8C0098847500B5A08E00B9A39100AB958500B39C8D009C877900B09A8900B9A3
      9100B6A08F00A9928300AB9587009D887800B9A49200B9A39100B9A39100B9A3
      9100B9A39100B39B880087736500F4F4F400CCCACA00C2C1BF00FFFCF800FFFC
      F800FFFCF800FFFCF800FFFCF800FFFCF80099989600FBF8F500FFFCF800FFFC
      F800FFFCF800FFFCF800FFFCF800CBD8EB007C9BCF00BFCAE500C2CDE500BAC7
      E500A7BBE80088A7EC007198EE00648BD000FFFCF900FFFCF800FFFCF800FFFC
      F800FFFCF800FFFCF800EAE8E500BFBEBE000000000000000000000000000000
      0000E9F3E200F1934D00FFDBC000FFF8F400FFEADB00FFDABF00FFD6B600FFD5
      B500FFD9BD00FFF2E800FFFFFF00FFEADB00FFD2AF00FFC89F00FFC69B00FFC2
      9400FFBE8C00FFB88100FFB78000FFCDA700FFDFC700FFBB8500F3833100CFCA
      B40000000000000000000000000000000000C4846300BFC4C600ECECEC00EEEE
      EE00EEEEEE00EDEDED00ACADAF00AB948500FCDEC800FBDDC600B5A69C00E6E7
      E800EDEDED00EEEEEE00EDEDED00EBEBEB00A3A5A500C0A79600FFE2C5004474
      E200AEDBFD00A9DCFF00A9DDFF00A9DDFF00ACDEFF00B2E0FF0099D6FF005FBF
      FF0044AFFB002E7BF0004C374100E9E9E9000000000000000000D9D0C900A086
      7800A48C7D00A28A7B00C1AA9C008F7B6E00A58D7E00A48C7C00AC958700BAA4
      9700917B6E00A58D7E00A58C7D00A68E8000C4ADA0008F7A6E00A58C7D00A48C
      7D00A28A7B00C1AA9D00A18C7F009C847600A48C7D00A48C7D00A48C7D00A48C
      7D00A48C7D00A0877700A5918400FEFEFE00CCCBCB00C2C0BE00FFFBF700FFFB
      F700FFFBF700FFFBF700FFFBF700FFFBF70099979600FBF7F400FFFBF700FFFB
      F700FFFBF700FFFBF700FFFBF700CBD7EA00809DCE00C3CDE500C3CDE400BAC7
      E500ACBEE70094AEEA00799DED00648CCF00FFFCF900FFFBF700FFFBF700FFFB
      F700FFFBF700FFFBF700EAE7E500BFBEBD000000000000000000000000000000
      000000000000E1E9CD00F5965000FFE6D400FFF4ED00FFE4D000FFD9BD00FFD6
      B600FFDABE00FFE8D800FFF7F100FFFAF700FFD6B700FFC79C00FFC69B00FFC2
      9400FFBD8A00FFBA8500FFCAA200FFE5D100FFD4B100FB914700CDBE9A000000
      000000000000000000000000000000000000DF967400A1A3A400EDEDED00EEEE
      EE00EFEFEF00EEEEEE00AAABAB00AD998B00FCDECC00FBDDCB00B6A89E00E7E8
      E900EEEEEE00EFEFEF00EEEEEE00EBECEC0086827E00ECD1BF00FFE1C8004775
      E200B5DFFD00B0DFFF00B0DEFF00B0DEFF00B0DEFF00B0DEFF00B1DFFF00B4E0
      FF00B9E2FE007FA9F7004A374300E9EAE9000000000000000000F6F4F300AB99
      8F009B857A009D877C00C1ACA0008E7A7000856D6200876E6300AF998E00A995
      8900866E63007F675B00856B61009F877D00BCA69A007F675B007F675B008068
      5D00896F6300C8B2A6008E796D00836A5E00836D6200826B5F00886D6200886E
      6200896F630090766C00D0C6C10000000000CCCCCB00C2C0BE00FFFBF700FFFB
      F700FFFBF700FFFBF700FFFBF700FFFBF70099979600FBF7F400FFFBF700FFFB
      F700FFFBF700FFFBF700FFFBF700CED9EA007093CC009FB7E1009DB5E10098B3
      E10092AFE20088A8E4007AA0E500658BCB00FFFBF800FFFBF700FFFBF700FFFB
      F700FFFBF700FFFBF700EAE7E400BFBFBE000000000000000000000000000000
      00000000000000000000DEE4C800ED945100FFE2CE00FFF3E900FFE2CD00FFD9
      BC00FFD7B800FFDBC000FFDDC300FFE5D100FFEFE400FFD2B000FFC39500FFC1
      9200FFBF8E00FFCCA400FFE7D500FFDBBF00F8954E00D2C4A000000000000000
      000000000000000000000000000000000000DF957300BBABA600D2D3D400EEEE
      EE00F0F0F000EFEFEF00A9A9AA00B09B8F00FBDFCE00FADECD00B6A8A000E9EA
      EA00EFEFEF00F0F0F000F0F0F000B2B4B500B7A49900FADECD00FFE2C9004470
      DD00BEE1FD00B7E1FE00B7E2FF00B7E2FF00B7E2FF00B7E2FF00B7E2FF00B7E2
      FE00BCE1FD006695F40063464300F3F3F3000000000000000000000000000000
      000000000000E6E1DF00BEACA200B5ADA8009C8A8100B1A6A100CCC1BB00A793
      8900BDB6B2009F8A8000C9C2BF00D3CAC600BDA89E00A99F9900A59389009C8E
      8800EAE6E500CBBAB10099867D00A4989200B09B9000B8ADA900E5E0DE00E2DD
      DB00DFD9D700EEEBEA000000000000000000CACAC900C2C0BD00FFFAF600FFFA
      F600FFFAF600FFFAF600FFFAF600FFFAF60099979500FBF7F300FFFAF600FFFA
      F600FFFAF600FFFAF600FFFAF600DDDDDF006182B4008DAEE2008DAEE2008DAE
      E2008DAEE2008DAEE2008DAFE3006E83A500FFFBF700FFFAF600FFFAF600FFFA
      F600FFFAF600FFFAF600EAE6E300BBBBBA000000000000000000000000000000
      0000000000000000000000000000E4EBDB00D69C6300FCC9A700FFEFE200FFE7
      D400FFDCC000FFD6B700FFD3B200FFCEA800FFD6B700FFE6D400FFD6B800FFC8
      9E00FFD3B000FFE0C800FFC09700EB9D5900DEE3CA0000000000000000000000
      000000000000000000000000000000000000C1907900FBDACD009C989600E9EA
      EA00F1F1F100F0F0F000A1A1A200BEA99D00F9DFCF00F9DECE00BAABA300E5E6
      E700EFEFEF00F1F1F100D7D8D900978E8900F5DACC00F6DCCD00FEE1CC005770
      CC00B3D3FA00C0E4FD00BDE3FE00BDE3FE00BDE3FE00BDE3FE00BDE3FE00BEE2
      FD00C7E6FF002F4FBF009A857700000000000000000000000000000000000000
      000000000000F3F1F000CBBDB6008B7A7200A8908800C5BEBB00DDD7D400BDA9
      A2008B797100A38E8600E1DEDC00EAE7E500CAB8B2008F7B7400A9928900B4AB
      A600FBFBFA00D3C8C400AA958D0096827900A58F8700E0DDDB00000000000000
      000000000000000000000000000000000000CAC9C900C2C0BD00FFFAF500FFFA
      F500FFFAF500FFFAF500FFFAF500FFFAF50099979500FBF6F200FFFAF500FFFA
      F500FFFAF500FFFAF500FFFAF500DFDBD80093918F00FFFAF500FFFAF500FFFA
      F500FFFAF500FFFAF500FFFAF50094928F00FFFBF700FFFAF500FFFAF500FFFA
      F500FFFAF500FFFAF500EAE6E300BABAB9000000000000000000000000000000
      000000000000000000000000000000000000F8FAF800CCC4A900D7A47400FAC9
      A600FFE1C700FFE3C900FFDFC300FFDBBC00FFD6B300FFD5B200FFDEC300FFD6
      B800FBB78900E79D6000D9CC9F00F4FBF4000000000000000000000000000000
      000000000000000000000000000000000000F0EFEF00EA8F6500F5D6C9009D9E
      9F00DADDDF00EFF2F3008C8B8B00E6D1C600F8E0D600F8E1D600D3C4BC00C6CA
      CC00F3F4F500CACED1009C989500F5DDD200F7E0D600F6DFD500F7E0D500F4DE
      D4003661D90099BFFA00CBE8FF00C8E6FF00C8E8FF00C8E6FF00C9E8FF00AED2
      FE003864D9009B675B00F6F6F600000000000000000000000000000000000000
      000000000000FEFEFE00E3DEDB00C8B8B300A5928A00F2F0EF00F8F7F600DCD4
      D100BBA7A100AFA29B00FBFBFA00FDFDFD00E1DAD700C6B4AF00A8958E00EBE9
      E70000000000EEEBEA00D6CBC700B9A59E00B3A7A100FDFCFC00000000000000
      000000000000000000000000000000000000C7C7C70095939200BFBCB900BFBC
      B900BFBCB900BFBCB900BFBCB900BFBCB90077767500BCBAB700BFBCB900BFBC
      B900BFBCB900BFBCB900BFBCB900A9A7A50074727100BFBCB900BFBCB900BFBC
      B900BFBCB900BFBCB900BFBCB90075737200BFBDBB00BFBCB900BFBCB900BFBC
      B900BFBCB900BFBCB900B0AEAD00B7B6B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F5F7F400D0CD
      BD00C4AB8B00D2A47A00DCA77B00E7A87900E7A67400DBA17000D69F6B00CDAF
      8300D6D5BC00F3F8F20000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F2F1F100BD958200D594
      7500B4826A00A9887800CD8E7100DD9B7B00DC9A7A00DC9A7A00DF9B7A00AD8A
      7800AE988E00B8826700DE9D7B00DC9A7A00DC9A7A00DC9A7A00DC9A7A00DD9A
      7A00E39E78008C6882006F659C00746A9E00746A9E00746A9E0072699E007666
      8C00BBA29600FCFCFC0000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD00F4F2F200F4F2F1000000000000000000FBFB
      FA00F0EDEC00F9F9F8000000000000000000FDFCFC00F3F1F000F3F1F0000000
      000000000000FEFEFE00F9F8F700EEECEA00FCFCFC0000000000000000000000
      000000000000000000000000000000000000EEEEEE00C7C7C700CACAC900CBCA
      CA00CCCBCB00CDCCCC00CCCCCB00CCCCCB00CCCBCB00CCCCCB00CCCCCB00CCCC
      CB00CDCCCC00CCCBCB00CBCBCB00CACACB00C9C9CA00C9CACB00C9C9CB00C8C9
      CB00C9CACB00C9CACB00C9CACB00C8C8C900CBCBCB00CBCBCB00CCCCCB00CDCD
      CC00CCCBCB00CBCBCB00CBCACA00E9E8E8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC00F1F2F000EAEBE600EAECE700F0F3F000FBFCFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBFCFB00ECF2EB00ECF2EB00FBFCFB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00F2F6F100DDE6D900D5E0D000D6E1D100D6E1D100E1E9DE00F6F8F5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FEFEFE00FCFC
      FC00FCFCFC00FEFEFE00FEFEFE00FEFEFE000000000000000000000000000000
      0000FEFEFE00E8F0E7006DAA68006AA86500E7F0E600FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FEFEFE00FCFC
      FC00FCFCFC00FEFEFE00FEFEFE00FEFEFE000000000000000000000000000000
      0000BED2B70042903E003F8F3C0041903D003E8D3A0053974C00DDE7D9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FDFDFD00FEFEFE000000
      00000000000000000000000000000000000000000000FEFEFE00FAFAFA00F6F6
      F600F0F0F000EBEBEB00E7E7E700E3E3E300DFDFDF00DEDEDE00DBDBDB00D9D9
      D900D9D9D900DBDBDB00DEDEDE00DFDFDF00E3E3E300E7E7E700EBEBEB00F0F0
      F000E9EDE80084B57F00007A02000079010085B68000F2F6F100000000000000
      00000000000000000000000000000000000000000000FEFEFE00FAFAFA00F6F6
      F600F0F0F000EBEBEB00E7E7E700E3E3E300DFDFDF00DEDEDE00DBDBDB00D9D9
      D900D9D9D900DBDBDB00DEDEDE00DFDFDF00E3E3E300E7E7E700EBEBEB00F0F0
      F00095B98E00099324000C9527000C9325000C9225000E891F00CADBC5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000010101000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000101
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFE00F6F9FB00F0F6F800F4F8FA00FBFC
      FD0000000000000000000000000000000000F0F0F000E5E5E500DDDDDD00D6D6
      D600D1D1D100CDCDCD00CBCBCB00C9C9C900C8C8C800C7C7C700C7C7C700C6C6
      C600C6C6C600C7C7C700C7C7C700C8C8C800C9C9C900CBCBCB00CDCDCD00CACD
      CA008CAF870009820F00007A0200007B03000A831000A5C8A000F7FAF7000000
      000000000000000000000000000000000000F0F0F000E5E5E500DDDDDD00D6D6
      D600D1D1D100CDCDCD00CBCBCB00C9C9C900C8C8C800C7C7C700C7C7C700C6C6
      C600C6C6C600C7C7C700C7C7C700C8C8C800C9C9C900CBCBCB00CDCDCD00D1D1
      D10083A77C00009520000095200000931E0000921D00088B1C00CBDBC6000000
      00000000000000000000000000000000000000000000000000000E0E0E001010
      10000A0A0A001A1A1A0068686800696969006868680068686800686868006868
      6800686868006868680068686800686868006868680068686800686868006868
      6800686868006868680068686800686868006B6B6B005E5E5E00101010000C0C
      0C00121212000B0B0B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFE00F1F6F900DDEBF000D2E5EB00D9E9EE00EDF4
      F700FCFDFD000000000000000000000000008F8F8F006C6C6C00707070007676
      76007D7D7D0082828200878787008B8B8B008E8E8E0091919100939393009696
      960095959500939393008F8F8F008C8C8C0087878700838383007C7E7C005D74
      59000D81180000820A0000820C0000830D0000850E001A8E2500C1D8BD00FAFC
      FA00000000000000000000000000000000008F8F8F006C6C6C00707070007676
      76007D7D7D0082828200878787008B8B8B008E8E8E0091919100939393009696
      960095959500939393008F8F8F008C8C8C0087878700838383007E7E7E007878
      78004C6F45000AA13000009E2700009C2600009A240015982F00CDDCC7000000
      00000000000000000000000000000000000000000000000000001C1C1C000707
      07000202020022222200BABABA00B5B5B500B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B8B8B800A9A9A9000C0C0C000000
      00000C0C0C001515150000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFE00F2F7F900DAE9EF00B3D2DE00599BD30097C2D700DAE9
      EE00F1F6F900FDFDFE0000000000000000004E4E4E00686868007B7B7B009191
      9100A6A6A600B7B7B700C6C6C600D5D5D500E3E3E300EFEFEF00F9F9F900FFFF
      FF00FDFDFD00F3F3F300E7E7E700DBDBDB00CCCCCC00BABBBA00919F8E002388
      2D00008A130000891300008B1600008C1700008C1700008E1800379B4000D7E5
      D400FCFDFC000000000000000000000000004E4E4E00686868007B7B7B009191
      9100A6A6A600B7B7B700C6C6C600D5D5D500E3E3E300EFEFEF00F9F9F900FFFF
      FF00FDFDFD00F3F3F300E5E6E500D6D8D500C4C7C200B4B7B200A4A7A3009596
      940055794D0016AD400000A62E0000A42E0000A22A0024A44000C4D6BD00F8F9
      F700F3F6F200F3F6F200F5F7F400F9FBF9000000000000000000202020002121
      21002A2A2A0031313100BFBFBF00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00C0C0C000AFAFAF000C0C0C000000
      00000B0B0B001E1E1E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFE00F2F7F900DBEAEF00B5D3DF004A95D8003196FF003489E300A9CC
      DC00E2EEF200F7FAFB0000000000000000004444440051515100616161007272
      72008585850096969600A7A7A700B8B8B800CBCBCB00DDDDDD00EAEAEA00F5F5
      F500EEEEEE00DEDEDE00CECECE00BEBEBE00ACADAC008D958B00318438000091
      1B00008F1A0000911D0000931E0000941F0000952000009520000097210057A8
      5D00E6EEE400FEFEFE0000000000000000004444440051515100616161007272
      72008585850096969600A7A7A700B8B8B800CBCBCB00DDDDDD00EAEAEA00F5F5
      F500EEEEEE00DEDEDE00C7C9C60089A0800066895B005E805300547749004C6D
      41003377310017B74A0000AE340000AC350000AA300020AD460072A76B0096B8
      8C0093B7890092B6880091B68700C3D6BD000000000000000000292929001F1F
      1F00262626002F2F2F00C1C1C100C1C1C100C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C3C3C300B1B1B1000C0C0C000000
      00000A0A0A002E2E2E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00F6F9FB00DFECF100B7D4DF004A96D8003299FF0034A0FF00339BFF004591
      D900C7DEE600ECF4F600FCFDFD00000000004F4F4F0061616100747474008989
      890097979700A3A3A300AEAEAE00BBBBBB00CDCDCD00DFDFDF00E9E9E900F0F0
      F000E8E8E800DADADA00CDCDCD00C0C0C000A8ADA700518F5400009821000095
      200000982300009A2500009C2700009D2800009D2800009D2800009E2800009D
      27007AB67B00EFF4EE0000000000000000004F4F4F0061616100747474008989
      890097979700A3A3A300AEAEAE00BBBBBB00CDCDCD00DFDFDF00E9E9E900F0F0
      F000E8E8E800DADADA00C6C8C5002A983D0000AD340000A9320000AB330000AB
      330007B53F0002BA410000B63D0000B43C0000B1390004B0390005A73300009E
      2800009A2500009621000096200066AC69000000000000000000292929000909
      09000707070024242400C7C7C700C5C5C500C4C4C400C4C4C400C4C4C400C4C4
      C400C4C4C400C4C4C400C4C4C400C4C4C400C4C4C400C4C4C400C4C4C400C4C4
      C400C4C4C400C4C4C400C4C4C400C4C4C400C9C9C900B4B4B4000B0B0B000000
      00000A0A0A002D2D2D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00F2F7F900C8DFE8004E99DA003199FF00339EFF00329CFF00339EFF002F92
      FC0078AED400E1EDF100F6F9FB00000000005656560062626200767676008B8B
      8B009A9A9A00A6A6A600B1B1B100BDBDBD00D1D1D100E5E5E500ECECEC00F1F1
      F100E9E9E900DCDCDC00CFCFCF00BABEBA006F9A6E00049C2900009B2600009E
      290000A02B0000A22D0000A32E0000A5300000A5310000A6310000A5300000A6
      310006A22F009CC59900F6F9F600000000005656560062626200767676008B8B
      8B009A9A9A00A6A6A600B1B1B100BDBDBD00D1D1D100E5E5E500ECECEC00F1F1
      F100E9E9E900DCDCDC00CFCFCF0086A7830003BD450001C64A0000C4480000C5
      4A0000C2470000C0460000BF440000BC430000BA400000B53C0000B3390000AF
      370000A9310001A7300016A13700CEDFCB0000000000000000002B2B2B000404
      04000000000024242400CBCBCB00CACACA00C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900CECECE00B7B7B7000F0F0F000000
      00000C0C0C002D2D2D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00FDFDFE0083B5DD006BB2FF003AA2FF00309BFF00329CFF00329CFF00349E
      FF00348CE600BED9E300EEF5F700FDFDFE005454540061616100767676008B8B
      8B009A9A9A00A6A6A600B1B1B100BDBDBD00D3D3D300E9E9E900EFEFEF00F2F2
      F200E9E9E900DCDCDC00CACCC9008CA9890012A1390000A12D0000A12B0000A4
      2D0000A7310000AA330000AB350000AC370000AD370000AD370000AD360000AC
      350000AE380017A73F00BAD4B600F9FBF9005454540061616100767676008B8B
      8B009A9A9A00A6A6A600B1B1B100BDBDBD00D3D3D300E9E9E900EFEFEF00F2F2
      F200E9E9E900DCDCDC00CFCFCF00C2C2C200669D6A0011CE5B0001CB4E0000CA
      4C0000CA4C0000C94C0000C74A0000C4480000C1450000BD420000B83E0000B3
      380004B1390013AF4200B4D1B0000000000000000000000000002C2C2C000B0B
      0B00020202002B2B2B00CFCFCF00CFCFCF00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00D3D3D300BBBBBB00151515000505
      0500121212002F2F2F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00DDEBF10064A5E30065B4FF002F9BFF00329CFF00329CFF00339E
      FF002F95FE007DB2D600E9F2F500FAFCFC005454540061616100767676008B8B
      8B009A9A9A00A6A6A600B1B1B100BCBCBC00D4D4D400ECECEC00F2F2F200F3F3
      F300E9E9E900DCDCDC00B0BFAE002EA850001DB759001BB5550015B652000FB5
      4D0008B4460007B6460005B6450004B7460006B8470006B949000DBC510013BF
      580019C05E001CC466003BB05B00DAE7D8005454540061616100767676008B8B
      8B009A9A9A00A6A6A600B1B1B100BCBCBC00D4D4D400ECECEC00F2F2F200F3F3
      F300E9E9E900DCDCDC00CFCFCF00C2C2C200B5B5B50053A2620038E2800017D7
      650012D561000CD35C0008D1580008CE550008CB53000AC650000EC3500017C1
      530038C86A0093C59500000000000000000000000000000000002F2F2F001212
      1200090909002F2F2F00D2D2D200D4D4D400D2D2D200D2D2D200D2D2D200D2D2
      D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
      D200D2D2D200D2D2D200D2D2D200D2D2D200D7D7D700BEBEBE001B1B1B000C0C
      0C00181818003030300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE0000000000C9DFEA0059A2F00045A6FF002F9BFF00329CFF00329C
      FF00349EFF004897DE00D9E8EE00F7FAFB0050505000A1A1A100AEAEAE00BBBB
      BB00C4C4C400CBCBCB00D1D1D100D8D8D800E8E8E800F9F9F900FBFBFB00FAFA
      FA00F4F4F400ECECEC00A8C7A90038C976003CC677003AC979003CCB7B003DCF
      7E0042D186002BCB74002ACC74002ACD75002ACE760041D589003CD180003DCF
      80003DCD7D003DCC7C0039C97600BFDABE0050505000A1A1A100AEAEAE00BBBB
      BB00C4C4C400CBCBCB00D1D1D100D8D8D800E8E8E800F9F9F900FBFBFB00FAFA
      FA00F4F4F400ECECEC00E4E4E400DCDCDC00D4D4D400C1C5BF005FBE790058EF
      9B003BE482003EE383003CE181003CDE7F003CDB7C003DD87A003CD476005FDE
      90007FC288000000000000000000000000000000000000000000313131001818
      18000F0F0F0035353500D6D6D600D9D9D900D7D7D700D7D7D700D7D7D700D7D7
      D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7
      D700D7D7D700D7D7D700D7D7D700D7D7D700DCDCDC00C2C2C200202020001313
      13001F1F1F003131310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFE00FDFDFE0079B1DC004FA9FF00309DFF00329CFF00329C
      FF00349EFF003090F000B8D6E300F6F9FB00E5E5E50056565600686868007979
      79008A8A8A0098989800A4A4A400B0B0B000B9B9B900C0C0C000C7C7C700CDCD
      CD00CBCBCB00C4C4C400B9BAB8009DAB9D0092A29200889789007D8C7D00667C
      670057B97C004BDC94003AD687003AD788004BDF98006BCF9000CBE1CC00DFED
      DF00DDEBDD00DCEBDC00DFEDDF00FAFCFA00E5E5E50056565600686868007979
      79008A8A8A0098989800A4A4A400B0B0B000B9B9B900C0C0C000C7C7C700CDCD
      CD00CBCBCB00C4C4C400BCBCBC00B3B3B300A8A8A8009C9C9C007B88790067CD
      8A0068F3A7004FEA920050E992004FE78F0050E48D004BDF87006EE9A10076C9
      8A00F2F6F1000000000000000000000000000000000000000000343434001E1E
      1E00161616003A3A3A00DADADA00DEDEDE00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00E1E1E100C5C5C500262626001919
      1900252525003232320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE00BBD7E500439EF60036A4FF00319FFF00329E
      FF00339EFF003096FC0098C3DC00F6F9FA005050500060606000757575008B8B
      8B009F9F9F00B2B2B200C3C3C300D4D4D400E3E3E300F0F0F000FBFBFB00FFFF
      FF00FFFFFF00F3F3F300E7E7E700D8D8D800C8C8C800B7B7B700A4A4A4008F8F
      8F005AAC73005FE7A9004ADF97004AE098005FEAAB007BCC9300FCFDFC000000
      0000000000000000000000000000000000005050500060606000757575008B8B
      8B009F9F9F00B2B2B200C3C3C300D4D4D400E3E3E300F0F0F000FBFBFB00FFFF
      FF00FFFFFF00F3F3F300E7E7E700D8D8D800C8C8C800B7B7B700A4A4A4006F89
      6D008FE9B30081F4B5006CEEA50065EDA0005CEA990079F0AD007FD99D00DDE8
      DA00000000000000000000000000000000000000000000000000353535002525
      25001C1C1C003F3F3F00DDDDDD00E2E2E200E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E5E5E500C9C9C9002B2B2B002020
      20002B2B2B003333330000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFCFD00DCEAF000499EE70038A9FF0031A3FF0032A2
      FF0032A1FF00339CFF0080B5DA00F4F8F9004E4E4E0055555500686868007B7B
      7B008C8C8C009D9D9D00ADADAD00BDBDBD00D0D0D000E2E2E200EFEFEF00FBFB
      FB00F4F4F400E3E3E300D3D3D300C2C2C200B1B1B100A0A0A0008F8F8F007B7D
      7B0059AD75006FEEB7005BE7A6005BE8A7006FF1BA007CCF9700F4F8F4000000
      0000000000000000000000000000000000004E4E4E0055555500686868007B7B
      7B008C8C8C009D9D9D00ADADAD00BDBDBD00D0D0D000E2E2E200EFEFEF00FBFB
      FB00F4F4F400E3E3E300D3D3D300C2C2C200B1B1B100A0A0A0008F8F8F007E7E
      7E00527D5500B2F8D10094F4BF0082F0B20088F5B90094EAB600C2DBC1000000
      0000000000000000000000000000000000000000000000000000383838002C2C
      2C002323230044444400E1E1E100E7E7E700E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500EAEAEA00CCCCCC00313131002626
      26003131310035353500000000000000000000000000FEFEFE00FDFDFE00FCFD
      FD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFC
      FD00FBFCFD00FCFDFD00FEFEFE00000000000000000000000000000000000000
      00000000000000000000FAFCFC00E4EFF30053A2DF0037ABFF0032A7FF0032A6
      FF0032A4FF0035A2FF007AB3DA00F5F9FA0056565600676767007D7D7D009494
      9400A2A2A200AFAFAF00BBBBBB00C8C8C800D9D9D900EBEBEB00F3F3F300FCFC
      FC00F6F6F600E7E7E700D9D9D900CCCCCC00BEBEBE00B2B2B200A4A4A4009395
      920062B57E007EF5C4006AEDB3006AEEB4007EF7C6007FD19A00F4F8F4000000
      00000000000000000000000000000000000056565600676767007D7D7D009494
      9400A2A2A200AFAFAF00BBBBBB00C8C8C800D9D9D900EBEBEB00F3F3F300FCFC
      FC00F6F6F600E7E7E700D9D9D900CCCCCC00BEBEBE00B2B2B200A4A4A4009696
      9600828282005A936400C7FFE300A9F7CC00B4F9D300A8D0AB00000000000000
      00000000000000000000000000000000000000000000000000003A3A3A003232
      32002929290048484800EBEBEB00F3F3F300F1F1F100F1F1F100F1F1F100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F1F1F100F1F1F100F1F1F100F7F7F700D5D5D500353535002D2D
      2D0038383800363636000000000000000000FEFEFE00F9FBFC00EFF5F800E6F0
      F400E2EEF200E2EEF200E2EEF200E2EEF200E2EEF200E2EEF200E2EEF200E2EE
      F200E5F0F300EEF5F700F9FBFC00FEFEFE000000000000000000000000000000
      00000000000000000000F8FAFC00DEEBF0004FA1E00034AEFF0032ABFF0032A9
      FF0032A8FF0039A7FF007EB6DB00F8FAFB0055555500656565007B7B7B009191
      9100A0A0A000ADADAD00BABABA00C7C7C700DADADA00EDEDED00F4F4F400FDFD
      FD00F6F6F600E7E7E700D9D9D900CBCBCB00BDBDBD00B0B0B000A2A2A2009394
      930064BC8500A8FFE30096FCD40098FCD500ABFFE60082D79F00FBFCFB000000
      00000000000000000000000000000000000055555500656565007B7B7B009191
      9100A0A0A000ADADAD00BABABA00C7C7C700DADADA00EDEDED00F4F4F400FDFD
      FD00F6F6F600E7E7E700D9D9D900CBCBCB00BDBDBD00B0B0B000A2A2A2009494
      9400808080006669650068AB7900DFFFF70095CE9E0000000000000000000000
      00000000000000000000000000000000000000000000000000003C3C3C003838
      380033333300373737009F9F9F00CCCCCC00C7C7C700C7C7C700C7C7C700C7C7
      C700C7C7C700C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C7C7
      C700C7C7C700C7C7C700C7C7C700C7C7C700CDCDCD008A8A8A00333333003535
      35003E3E3E00373737000000000000000000FDFDFD00F0F6F800D8E8EE00C0DA
      E300B7D4DF00B7D4DF00B7D4DF00B7D4DF00B7D4DF00B7D4DF00B7D4DF00BCD7
      E100C9DFE700DDEBF000F2F7F900FEFEFE000000000000000000000000000000
      000000000000FEFEFE00F3F8F900CAE0E80040A0E80034B3FF0032AEFF0032AD
      FF0031ACFF003DAAFF008BBDDD00FBFCFD0055555500656565007B7B7B009191
      9100A0A0A000ADADAD00BABABA00C6C6C600DBDBDB00F0F0F000F6F6F600FDFD
      FD00F6F6F600E7E7E700D9D9D900CBCBCB00BDBDBD00B0B0B000A2A2A2009494
      94005C8C670054A974004A9C670089D9A60089DAA700ADDAB600000000000000
      00000000000000000000000000000000000055555500656565007B7B7B009191
      9100A0A0A000ADADAD00BABABA00C6C6C600DBDBDB00F0F0F000F6F6F600FDFD
      FD00F6F6F600E7E7E700D9D9D900CBCBCB00BDBDBD00B0B0B000A2A2A2009494
      9400808080006A6A6A0049544700A0D5AB00F4F8F40000000000000000000000
      00000000000000000000000000000000000000000000000000003E3E3E003E3E
      3E003B3B3B003D3D3D0039393900404040004242420043434300454545004646
      4600474747004848480048484800484848004848480048484800484848004747
      470046464600454545004444440042424200404040003A3A3A003F3F3F003C3C
      3C0043434300383838000000000000000000FDFDFD00EEF5F70081B5DB004E9B
      DC004A9AD9004A9AD9004A9CD9004B9DD9004C9EDA004C9EDA004CA0DA0050A3
      DC0053A3E10096C3E100F9FBFC00000000000000000000000000000000000000
      000000000000FAFCFC00EAF2F500A1C8DC0033A6F80033B6FF0032B2FF0032B0
      FF0032B0FF0040ABFD00A7CCE100FEFEFE0055555500656565007B7B7B009191
      9100A0A0A000ADADAD00BABABA00C5C5C500DCDCDC00F3F3F300F8F8F800FDFD
      FD00F6F6F600E7E7E700D9D9D900CBCBCB00BDBDBD00B0B0B000A2A2A2009494
      9400808080006A6A6A0050505000000000000000000000000000000000000000
      00000000000000000000000000000000000055555500656565007B7B7B009191
      9100A0A0A000ADADAD00BABABA00C5C5C500DCDCDC00F3F3F300F8F8F800FDFD
      FD00F6F6F600E7E7E700D9D9D900CBCBCB00BDBDBD00B0B0B000A2A2A2009494
      9400808080006A6A6A0050505000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000414141004747
      4700414141004444440047474700494949004C4C4C004D4D4D004E4E4E004C4C
      4C004D4D4D004E4E4E004E4E4E004E4E4E004E4E4E004D4D4D004D4D4D004C4C
      4C004B4B4B004A4A4A004B4B4B004C4C4C004949490048484800464646004141
      410049494900393939000000000000000000FDFDFD00EFF5F7005FA3DE0046AD
      FF0032A8FF0032AAFF0034ADFF0034B0FF0034B2FF0034B4FF0034B8FF0036B7
      FF0051A5E700DEECF100FEFEFE00000000000000000000000000000000000000
      0000FDFDFE00EFF5F800D7E7EC0063AAD90036B7FF0032B8FF0031B5FF002FB3
      FF003CB8FF004DABF300CEE2EC00FDFDFE0059595900A3A3A300B1B1B100BEBE
      BE00C8C8C800D1D1D100D9D9D900E0E0E000EFEFEF00FDFDFD00FFFFFF00FFFF
      FF00FDFDFD00F5F5F500ECECEC00E4E4E400DBDBDB00D3D3D300CACACA00C1C1
      C100B4B4B400A7A7A70051515100000000000000000000000000000000000000
      00000000000000000000000000000000000059595900A3A3A300B1B1B100BEBE
      BE00C8C8C800D1D1D100D9D9D900E0E0E000EFEFEF00FDFDFD00FFFFFF00FFFF
      FF00FDFDFD00F5F5F500ECECEC00E4E4E400DBDBDB00D3D3D300CACACA00C1C1
      C100B4B4B400A7A7A70051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000434343005555
      5500505050004F4F4F0048484800474747004A4A4A004B4B4B00505050006464
      6400686868006A6A6A006C6C6C006E6E6E007070700074747400747474007373
      7300727272006E6E6E005858580050505000515151004E4E4E004B4B4B004646
      4600505050003B3B3B000000000000000000FDFDFD00EFF5F70065A7DE005DB9
      FF0049B5FF0039B0FF0030AFFF0030B1FF0032B4FF0032B8FF0034B6FF0055A6
      E300E3EEF30000000000FEFEFE00000000000000000000000000FEFEFE00FBFC
      FD00EEF5F700DAE9EE009AC4D80036A9F40030BEFF0030BAFF0036BBFF0042BD
      FF0063C9FF0068AFE300F2F7F900FDFDFE00E5E5E50056565600676767007878
      78008989890096969600A2A2A200ADADAD00B8B8B800C1C1C100C5C5C500C8C8
      C800C6C6C600C0C0C000B8B8B800AFAFAF00A5A5A500989898008B8B8B007B7B
      7B006969690058585800E5E5E500000000000000000000000000000000000000
      000000000000000000000000000000000000E5E5E50056565600676767007878
      78008989890096969600A2A2A200ADADAD00B8B8B800C1C1C100C5C5C500C8C8
      C800C6C6C600C0C0C000B8B8B800AFAFAF00A5A5A500989898008B8B8B007B7B
      7B006969690058585800E5E5E500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000464646006161
      6100606060005D5D5D004E4E4E0048484800424242003B3B3B007F7F7F00BCBC
      BC00C3C3C300CDCDCD00D7D7D700E2E2E200ECECEC00EFEFEF00F2F2F200F2F2
      F200F4F4F400FAFAFA00CFCFCF00545454005454540054545400555555005858
      5800616161003B3B3B000000000000000000FDFDFD00EFF5F70067A8DE0064BE
      FF005BBEFF005ABFFF004DBCFF003BB8FF0031B8FF0030B7FF00469EE000BED8
      E200E4EFF300F0F6F800F8FAFC00FAFCFC00FAFCFC00F8FAFC00F2F7F900E4EF
      F300D3E5EB00A8CCDB0042A5E50035C3FF003CC4FF004CC7FF0059CAFF005FCC
      FF0070C7FF009AC6E00000000000FEFEFE0070707000727272008A8A8A00A2A2
      A200B5B5B500C3C3C300D0D0D000D9D9D900E1E1E100E7E7E700ECECEC00EEEE
      EE00ECECEC00E8E8E800E1E1E100D8D8D800CDCDCD00BFBFBF00B0B0B0009E9E
      9E00868686006F6F6F0053535300000000000000000000000000000000000000
      00000000000000000000000000000000000070707000727272008A8A8A00A2A2
      A200B5B5B500C3C3C300D0D0D000D9D9D900E1E1E100E7E7E700ECECEC00EEEE
      EE00ECECEC00E8E8E800E1E1E100D8D8D800CDCDCD00BFBFBF00B0B0B0009E9E
      9E00868686006F6F6F0053535300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000484848006D6D
      6D006D6D6D00666666005F5F5F00616161005E5E5E0057575700A0A0A000B9B9
      B900BDBDBD00C7C7C700D2D2D200DFDFDF00DDDDDD00676767005A5A5A005757
      570081818100FFFFFF00F6F6F6006A6A6A00676767006D6D6D006F6F6F006E6E
      6E006E6E6E003C3C3C000000000000000000FDFDFD00EFF5F70069AADF006BC3
      FF0061C3FF0062C4FF0064C7FF0062C8FF0058C8FF004AC3FF0048A5E60088BA
      D300BCD7E100D0E3EA00DAE9EF00E1EDF200E1EDF200DBEAEF00D1E4EA00C2DA
      E3008EBED5004EAAE70051CDFF005BD2FF0063D2FF0064D1FF005FCEFF0079D8
      FF0068B5EE00E3EEF300FEFEFE000000000053535300666666007B7B7B009191
      9100A6A6A600B7B7B700C7C7C700D6D6D600E4E4E400F0F0F000F9F9F900FFFF
      FF00FBFBFB00F1F1F100E4E4E400D6D6D600C6C6C600B4B4B400A1A1A1008D8D
      8D0078787800636363004A4A4A00000000000000000000000000000000000000
      00000000000000000000000000000000000053535300666666007B7B7B009191
      9100A6A6A600B7B7B700C7C7C700D6D6D600E4E4E400F0F0F000F9F9F900FFFF
      FF00FBFBFB00F1F1F100E4E4E400D6D6D600C6C6C600B4B4B400A1A1A1008D8D
      8D0078787800636363004A4A4A00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004B4B4B007878
      780079797900727272006A6A6A006C6C6C006C6C6C006A6A6A00B0B0B000C4C4
      C400BDBDBD00C5C5C500CDCDCD00D9D9D900D6D6D60065656500595959005757
      570081818100FFFFFF00F4F4F400848484007F7F7F007E7E7E007B7B7B007979
      7900787878003D3D3D000000000000000000FDFDFD00EFF5F7006BABDF0073C8
      FF0068C7FF0068C9FF0068CBFF0069CDFF006BD0FF006CD3FF006AD4FF0053B8
      F80059A7DA0081B7D300A2C8D800B1D0DD00B3D1DD00A4C9D90087BAD40060AC
      D90053BBF7006ADAFF006CDBFF006AD8FF0069D7FF0067D4FF0071D8FF0084D2
      FF009CC8E20000000000FEFEFE00000000005A5A5A006F6F6F00868686009E9E
      9E00AFAFAF00BDBDBD00CBCBCB00D7D7D700E5E5E500F1F1F100F9F9F900FEFE
      FE00F9F9F900EFEFEF00E3E3E300D5D5D500C7C7C700B8B8B800A8A8A8009898
      9800838383006B6B6B004F4F4F00000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5A006F6F6F00868686009E9E
      9E00AFAFAF00BDBDBD00CBCBCB00D7D7D700E5E5E500F1F1F100F9F9F900FEFE
      FE00F9F9F900EFEFEF00E3E3E300D5D5D500C7C7C700B8B8B800A8A8A8009898
      9800838383006B6B6B004F4F4F00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D008383
      8300848484007D7D7D0075757500777777007777770074747400BBBBBB00D0D0
      D000C2C2C200C2C2C200CACACA00D5D5D500D4D4D40081818100787878007474
      740094949400FFFFFF00F4F4F4008E8E8E008A8A8A0089898900868686008484
      8400828282003E3E3E000000000000000000FDFDFD00EFF5F7006CACDF007BCD
      FF006ECBFF0071CFFF0071D1FF006FD1FF0070D4FF0070D5FF0070D7FF0074DD
      FF0070D8FF005DC6FC0054B5EE0055AEE40054AEE20056B6ED005BC6FB006FDC
      FF0074E2FF0071DEFF0070DCFF0070DCFF006FDAFF0072DCFF0099E4FF0075B8
      E600F6F9FB00FEFEFE0000000000000000005E5E5E007878780091919100AAAA
      AA00BBBBBB00C8C8C800D5D5D500E0E0E000ECECEC00F7F7F700FCFCFC00FFFF
      FF00FBFBFB00F3F3F300E9E9E900DDDDDD00D0D0D000C2C2C200B3B3B300A4A4
      A4008E8E8E007373730055555500000000000000000000000000000000000000
      0000000000000000000000000000000000005E5E5E007878780091919100AAAA
      AA00BBBBBB00C8C8C800D5D5D500E0E0E000ECECEC00F7F7F700FCFCFC00FFFF
      FF00FBFBFB00F3F3F300E9E9E900DDDDDD00D0D0D000C2C2C200B3B3B300A4A4
      A4008E8E8E007373730055555500000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004F4F4F008E8E
      8E008F8F8F00888888008080800082828200828282007E7E7E00C4C4C400DBDB
      DB00CECECE00C5C5C500C5C5C500CECECE00CFCFCF0089898900818181007E7E
      7E0099999900FEFEFE00F5F5F500989898009494940093939300919191009090
      90008B8B8B003F3F3F000000000000000000FDFDFD00EFF5F7006DADDF007FD0
      FF007DD4FF009DDCFF009BDDFF007DD9FF0074D6FF0077DAFF0077DBFF0077DC
      FF0078DFFF007BE3FF007CE5FF007CE5FF007CE6FF007CE7FF007BE7FF0078E4
      FF0077E3FF0077E1FF0077E1FF0075E0FF007AE1FF009FE9FF0074BCF000E0ED
      F30000000000000000000000000000000000676767008080800097979700AEAE
      AE00BEBEBE00CBCBCB00D6D6D600E1E1E100EDEDED00F9F9F900FCFCFC00FFFF
      FF00FCFCFC00F4F4F400E9E9E900DEDEDE00D2D2D200C5C5C500B7B7B700A8A8
      A800949494007C7C7C0060606000000000000000000000000000000000000000
      000000000000000000000000000000000000676767008080800097979700AEAE
      AE00BEBEBE00CBCBCB00D6D6D600E1E1E100EDEDED00F9F9F900FCFCFC00FFFF
      FF00FCFCFC00F4F4F400E9E9E900DEDEDE00D2D2D200C5C5C500B7B7B700A8A8
      A800949494007C7C7C0060606000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000525252009898
      980099999900929292008A8A8A008C8C8C008C8C8C0089898900CECECE00E5E5
      E500D9D9D900D1D1D100C9C9C900C9C9C900CBCBCB00929292008C8C8C008989
      89009E9E9E00F7F7F700F2F2F200A1A1A1009F9F9F009E9E9E009B9B9B009A9A
      9A0094949400404040000000000000000000FDFDFD00EFF5F7006EAEE00091DA
      FF00A4DFFF006AADE2006DAFE400A5E2FF0091E4FF007BDDFF007DDEFF007FE1
      FF007FE2FF007FE3FF007FE5FF007FE6FF007FE6FF007FE7FF007FE7FF007FE7
      FF007FE7FF007EE5FF007BE5FF008DEAFF00A8ECFF0076BFF000DAEAF1000000
      0000FEFEFE000000000000000000000000006E6E6E00868686009C9C9C00B3B3
      B300C1C1C100CDCDCD00D8D8D800E2E2E200EFEFEF00FAFAFA00FDFDFD00FFFF
      FF00FCFCFC00F4F4F400EAEAEA00DFDFDF00D4D4D400C7C7C700BABABA00ADAD
      AD00999999008282820067676700000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6E00868686009C9C9C00B3B3
      B300C1C1C100CDCDCD00D8D8D800E2E2E200EFEFEF00FAFAFA00FDFDFD00FFFF
      FF00FCFCFC00F4F4F400EAEAEA00DFDFDF00D4D4D400C7C7C700BABABA00ADAD
      AD00999999008282820067676700000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000054545400A1A1
      A100A3A3A3009C9C9C0094949400969696009696960092929200D6D6D600EEEE
      EE00E2E2E200DBDBDB00D3D3D300CDCDCD00C7C7C7009B9B9B00969696009494
      9400A4A4A400F0F0F000EDEDED00A9A9A900A8A8A800A7A7A700A5A5A500A4A4
      A4009D9D9D00414141000000000000000000FDFDFD00F3F7F90074B2E100AFE1
      FF006FAFE400E9F1F500ECF3F7007CB8E30094D4FF00ABEDFF0092E8FF0084E4
      FF0083E5FF0085E6FF0086E8FF0086E9FF0086EAFF0086EAFF0085EAFF0083EA
      FF0084EAFF0090EEFF00A9F3FF009DE1FF007DBEE800E4EFF40000000000FEFE
      FE000000000000000000000000000000000069696900858585009B9B9B00B2B2
      B200C1C1C100CDCDCD00D8D8D800E2E2E200F0F0F000FCFCFC00FDFDFD00FFFF
      FF00FCFCFC00F4F4F400EAEAEA00DFDFDF00D4D4D400C7C7C700BABABA00ACAC
      AC00989898008181810066666600000000000000000000000000000000000000
      00000000000000000000000000000000000069696900858585009B9B9B00B2B2
      B200C1C1C100CDCDCD00D8D8D800E2E2E200F0F0F000FCFCFC00FDFDFD00FFFF
      FF00FCFCFC00F4F4F400EAEAEA00DFDFDF00D4D4D400C7C7C700BABABA00ACAC
      AC00989898008181810066666600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000056565600AAAA
      AA00ADADAD00A5A5A5009E9E9E00A0A0A000A0A0A0009B9B9B00DEDEDE00F6F6
      F600EBEBEB00E4E4E400DDDDDD00D7D7D700CCCCCC00A4A4A400A0A0A0009F9F
      9F00AAAAAA00EAEAEA00E8E8E800B1B1B100B1B1B100B0B0B000AEAEAE00ADAD
      AD00A7A7A700444444000000000000000000FDFDFD00FCFDFD006BACE40068AB
      E600E9F1F500000000000000000000000000B0D2E6007ABCEC009CDBFF00B1F0
      FF00A8F2FF009BF0FF0093EFFF0090EFFF0090EFFF0093F1FF0099F3FF00A5F6
      FF00B0F5FF00A3E6FF0080C7F100A9D1E600FDFDFE0000000000FEFEFE000000
      0000000000000000000000000000000000007C7C7C00C2C2C200CDCDCD00D8D8
      D800E1E1E100E8E8E800EEEEEE00F3F3F300F9F9F900FEFEFE00FEFEFE00FFFF
      FF00FEFEFE00FBFBFB00F7F7F700F2F2F200EDEDED00E6E6E600DFDFDF00D6D6
      D600CBCBCB00C0C0C00067676700000000000000000000000000000000000000
      0000000000000000000000000000000000007C7C7C00C2C2C200CDCDCD00D8D8
      D800E1E1E100E8E8E800EEEEEE00F3F3F300F9F9F900FEFEFE00FEFEFE00FFFF
      FF00FEFEFE00FBFBFB00F7F7F700F2F2F200EDEDED00E6E6E600DFDFDF00D6D6
      D600CBCBCB00C0C0C00067676700000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000058585800B3B3
      B300B6B6B600ADADAD00A7A7A700A9A9A900A9A9A900A4A4A400E4E4E400FDFD
      FD00F2F2F200ECECEC00E6E6E600E0E0E000D5D5D500AAAAAA00A6A6A600A6A6
      A600AFAFAF00E5E5E500E3E3E300B8B8B800BABABA00B8B8B800B6B6B600B9B9
      B900A6A6A6003A3A3A00000000000000000000000000FDFDFE00A6CCE700E3EE
      F40000000000FEFEFE00000000000000000000000000F7FAFB00B6D6E70082BD
      E50086C9F40098DBFF00A7E8FF00ADEEFF00AEF0FF00A8EBFF009CE1FF0089D0
      F80083C4EA00AED4E700F3F8FA00000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDE009F9F9F00A3A3A300A7A7
      A700ABABAB00AFAFAF00B2B2B200B6B6B600B8B8B800BABABA00BDBDBD00BEBE
      BE00BEBEBE00BBBBBB00B8B8B800B6B6B600B2B2B200AEAEAE00AAAAAA00A6A6
      A600A1A1A1009D9D9D009C9C9C00000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDE009F9F9F00A3A3A300A7A7
      A700ABABAB00AFAFAF00B2B2B200B6B6B600B8B8B800BABABA00BDBDBD00BEBE
      BE00BEBEBE00BBBBBB00B8B8B800B6B6B600B2B2B200AEAEAE00AAAAAA00A6A6
      A600A1A1A1009D9D9D009C9C9C00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005B5B5B00BEBE
      BE00C0C0C000B8B8B800B3B3B300B6B6B600B6B6B600B1B1B100EBEBEB00FFFF
      FF00FCFCFC00F6F6F600F0F0F000EAEAEA00E2E2E200D1D1D100CCCCCC00CACA
      CA00D1D1D100E3E3E300E2E2E200C2C2C200C5C5C500C3C3C300C4C4C400B0B0
      B0004E4E4E0023232300000000000000000000000000FDFDFE00000000000000
      0000FEFEFE000000000000000000000000000000000000000000000000000000
      0000EBF3F600C6DFEB00ADD2E6009FCBE4009DCBE400ABD1E600C2DCE900E6F0
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005B5B5B00B4B4
      B400B4B4B400A9A9A9009D9D9D00A0A0A000A1A1A1009B9B9B00D9D9D900F4F4
      F400F3F3F300F0F0F000ECECEC00E9E9E900E5E5E500E4E4E400E0E0E000DDDD
      DD00DDDDDD00E0E0E000DADADA00B4B4B400BABABA00B9B9B900AFAFAF005151
      51001F1F1F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000474747007878
      7800777777006B6B6B00595959005C5C5C005C5C5C0057575700868686009C9C
      9C009B9B9B009A9A9A009A9A9A00999999009999990099999900989898009797
      970097979700989898009191910073737300797979007A7A7A006A6A6A002727
      2700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFBFB00F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500FBFBFB0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FCFCFC00FAFA
      FA00F9F9F900FAFAFA00FBFBFB00FBFBFB00FAFAFA00FBFBFB00FAFAFA00F9F9
      F900FAFAFA00FDFDFD00FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00F9F9F900F4F4
      F400F3F3F300F5F5F500F6F6F600F6F6F600F5F5F500F7F7F700F6F6F600F3F3
      F300F4F4F400F9F9F900FCFCFC00FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00FAFAFA00FAFAFA00FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F300A4A4A4007E7E
      7E007B7B7B008282820094949400939393009393930093939300939393009393
      9300939393009393930093939300939393009393930093939300939393009393
      9300939393009393930093939300939393009393930094949400828282007B7B
      7B007C7C7C00A3A3A300F2F2F200000000000000000000000000000000000000
      0000000000000000000000000000FEFEFE00FBFBFB00F8F8F800F9F9F900F0F0
      F000D9D9D900C3C3C300B2B2B200AFAFAF00B0B0B000B7B7B700C9C9C900E2E2
      E200F5F5F500F9F9F900F9F9F900FCFCFC00FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFD00F7F7F700F1F1F100F2F2F200E2E2
      E200B5B5B500929292008181810081818100818181008585850091919100B4B4
      B400DEDEDE00F1F1F100F2F2F200F6F6F600FCFCFC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500DCDCDC00C2C2C400AEAEB400A8A8B000A8A8B000B3B3B700CACACA00E5E5
      E500FBFBFB000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0E0E000343434003838
      38003535350068686800C9C9C900C1C1C100C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C9C9C900686868003636
      36003939390035353500E1E1E100000000000000000000000000000000000000
      000000000000FEFEFE00FCFCFC00F8F8F800F8F8F800DCDCDC00AFAFAF00AAAA
      AA00C4C4C400DDDDDD00E9E9E900ECECEC00EBEBEB00E7E7E700D5D5D500B9B9
      B900A6A6A600BCBCBC00EBEBEB00F8F8F800F9F9F900FDFDFD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F9F9F900F1F1F100F1F1F100C2C2C2007F7F7F009191
      9100C2C2C200E3E3E300EFEFEF00F5F5F500F5F5F500F3F3F300E9E9E900D1D1
      D100A2A2A20087878700BDBDBD00EEEEEE00F2F2F200F9F9F900FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00D3D3D3008E8EA000504E
      880026238700120D8C0007029000060193000601930009048E0018138B00322F
      860062618C00A5A5AE00E6E6E600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00373737004D4D
      4D004A4A4A0069696900BDBDBD00B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600BDBDBD00676767003838
      38003A3A3A0037373700DEDEDE00000000000000000000000000000000000000
      0000FEFEFE00FAFAFA00F8F8F800E8E8E800ACACAC00BEBEBE00EEEEEE00F7F7
      F700EDEDED00E5E5E500E1E1E100E0E0E000E0E0E000E2E2E200E7E7E700F1F1
      F100F7F7F700E1E1E100AEAEAE00BEBEBE00F4F4F400F8F8F800FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00F6F6F600F1F1F100DADADA007F7F7F00ACACAC00ECECEC00F6F6
      F600ECECEC00E4E4E400DFDFDF00DEDEDE00DDDDDD00DEDEDE00E2E2E200E8E8
      E800F3F3F300F5F5F500C9C9C9008A8A8A00D0D0D000F2F2F200F6F6F600FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D9D9D900727193001F1C890006009B000600
      A3000600A2000400A00002009D0002009C0002009D0002009E000600A1000600
      A3000600A20006019400353287009595A500EFEFEF0000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE003C3C3C002A2A
      2A00262626006D6D6D00C1C1C100BBBBBB00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BBBBBB00C2C2C200686868003B3B
      3B003E3E3E003A3A3A00DEDEDE0000000000000000000000000000000000FEFE
      FE00FAFAFA00F9F9F900CCCCCC00AEAEAE00EFEFEF00F2F2F200E1E1E100DEDE
      DE00E1E1E100E3E3E300E5E5E500E5E5E500E5E5E500E5E5E500E3E3E300E0E0
      E000DFDFDF00E6E6E600F6F6F600DBDBDB00A7A7A700E7E7E700F9F9F900FCFC
      FC00000000000000000000000000000000000000000000000000000000000000
      0000F6F6F600F4F4F400B1B1B1008C8C8C00E7E7E700F4F4F400E3E3E300DEDE
      DE00E1E1E100E4E4E400E5E5E500E6E6E600E6E6E600E6E6E600E5E5E500E3E3
      E300DFDFDF00DFDFDF00EDEDED00F6F6F600AFAFAF00ACACAC00F3F3F300F6F6
      F600FEFEFE000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE00A3A3AE00282589000600A1000600A20002009B000000
      9A000000A1000612AB000F1FB1001425B5001424B4000E1BAE00020CA7000000
      9E0000009A0004009D000600A400060099004A488A00CDCDCE00000000000000
      00000000000000000000000000000000000000000000DEDEDE003E3E3E003232
      32002E2E2E006D6D6D00C7C7C700BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00C7C7C7006B6B6B003F3F
      3F00414141003D3D3D00DEDEDE00000000000000000000000000FEFEFE00FAFA
      FA00FAFAFA00C1C1C100C3C3C300F6F6F600E4E4E400E0E0E000E5E5E500E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E5E5E500E0E0E000EAEAEA00F2F2F200ABABAB00DFDFDF00FAFA
      FA00FCFCFC00000000000000000000000000000000000000000000000000F6F6
      F600F5F5F500A0A0A000A7A7A700F5F5F500E7E7E700E0E0E000E5E5E500E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E7E7E700E6E6E600E2E2E200E1E1E100F4F4F400D2D2D2009C9C9C00F4F4
      F400F6F6F600FEFEFE0000000000000000000000000000000000000000000000
      0000FBFBFB0081819C000A0595000600A300040099000206A200122EBD003158
      D600507AE600658EEE007299F200799EF2007B9FF2007699F0006A8DEA005274
      DF002F4DCB000C1EB10000009D0004009C000600A40024218C00B7B7BE000000
      00000000000000000000000000000000000000000000DEDEDE00404040004545
      4500434343006D6D6D00CBCBCB00C4C4C400C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C4C4C400CBCBCB006D6D6D004242
      42004545450040404000DEDEDE00000000000000000000000000FBFBFB00FBFB
      FB00C3C3C300CACACA00F3F3F300E2E2E200E5E5E500E6E6E600E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E4E4E400E5E5E500F5F5F500ABABAB00E5E5
      E500F9F9F900FDFDFD0000000000000000000000000000000000F8F8F800F6F6
      F600A7A7A700AEAEAE00F5F5F500E3E3E300E4E4E400E6E6E600E6E6E600E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E6E6E600E2E2E200F0F0F000D9D9D900A2A2
      A200F4F4F400F8F8F800FEFEFE00000000000000000000000000000000000000
      000082829E0006009B0006009E000204A0001137C600326BE9004F86F5005489
      F4004980F1003B75EE00306CEC002D6AEB002F69EA00386EEA004879EC005C87
      EE006892F1005E88EC00375DD8000C21B30000009B000600A3001A159000BFBF
      C5000000000000000000000000000000000000000000DEDEDE00454545004949
      49004545450071717100CFCFCF00C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800CFCFCF00707070004646
      46004848480045454500DEDEDE000000000000000000FDFDFD00FAFAFA00D9D9
      D900BDBDBD00F3F3F300E4E4E400E6E6E600E7E7E700E7E7E700E7E7E700E9E9
      E900E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8
      E800E8E8E800E8E8E800E7E7E700E7E7E700E6E6E600E7E7E700F2F2F200A7A7
      A700F3F3F300F9F9F900FEFEFE000000000000000000FCFCFC00F5F5F500CACA
      CA0098989800F3F3F300E5E5E500E6E6E600E7E7E700E7E7E700E7E7E700E8E8
      E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8
      E800E8E8E800E8E8E800E8E8E800E7E7E700E7E7E700E4E4E400F0F0F000CBCB
      CB00BEBEBE00F5F5F500FCFCFC0000000000000000000000000000000000A9A9
      B6000904980006009D00041AB0001557E6002E76F8002E72F3001963F0000458
      EE000053EC000051EB000050EA00004FE900004FE800004DE700004CE600004D
      E6000E54E6002D65E700497BEC004476EB001A41CC000206A1000600A2002926
      8E00E1E1E10000000000000000000000000000000000DEDEDE00484848004C4C
      4C004949490072727200D4D4D400CDCDCD00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CDCDCD00D4D4D400727272004949
      49004C4C4C0048484800DEDEDE000000000000000000FAFAFA00F4F4F400A9A9
      A900F3F3F300E6E6E600E7E7E700E7E7E700E8E8E800E8E8E800E9E9E900E7E7
      E700F0F0F000EEEEEE00E9E9E900E9E9E900EAEAEA00EAEAEA00EAEAEA00E9E9
      E900E9E9E900E9E9E900E8E8E800E8E8E800E8E8E800E7E7E700EBEBEB00E4E4
      E400B4B4B400FCFCFC00FCFCFC000000000000000000F7F7F700F0F0F0008080
      8000EBEBEB00E9E9E900E7E7E700E7E7E700E8E8E800E8E8E800E8E8E800E9E9
      E900E9E9E900E9E9E900EAEAEA00E9E9E900EAEAEA00E9E9E900EAEAEA00EAEA
      EA00E9E9E900E9E9E900E9E9E900E8E8E800E8E8E800E8E8E800E6E6E600F3F3
      F300A3A3A300E6E6E600F7F7F700FEFEFE000000000000000000E4E4E4002623
      910006009F000624B900095FF2001468F7000B60F3000059F1000058F1000058
      F0000058EF000057EE000056ED000055EC000054EB000054EA000053E9000052
      E800004EE600004CE600004FE6001F5EE700316CEC00184CD900040CA5000600
      A20065639800FEFEFE00000000000000000000000000DEDEDE004C4C4C005151
      51004D4D4D0075757500D8D8D800D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D8D8D800747474004E4E
      4E00505050004C4C4C00DEDEDE0000000000FDFDFD00FDFDFD00BCBCBC00DFDF
      DF00EBEBEB00E7E7E700E8E8E800E8E8E800E9E9E900EAEAEA00EDEDED007171
      710075757500DADADA00F7F7F700EDEDED00EAEAEA00EBEBEB00EBEBEB00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00E9E9E900E9E9E900E9E9E900E7E7E700F1F1
      F100BCBCBC00E2E2E200FBFBFB00FEFEFE00FCFCFC00F9F9F900A0A0A000C3C3
      C300EFEFEF00E7E7E700E8E8E800E8E8E800E9E9E900E9E9E900EEEEEE00F4F4
      F400F4F4F400F4F4F400F0F0F000EAEAEA00EBEBEB00EAEAEA00EEEEEE00F5F5
      F500F4F4F400F4F4F400F0F0F000E9E9E900E9E9E900E9E9E900E8E8E800EAEA
      EA00EBEBEB009E9E9E00F9F9F900FCFCFC0000000000000000008181A4000600
      A0000923B7000F64F5000C64F700085FF300045EF300005BF3000055F2000054
      F100005AF1000059F0000058EF000057EE000056ED000056EC000055EC000051
      EA000050E900004DE800004EE700004FE6000852E600165CEA000845D9000409
      A4000C079700C9C9CE00000000000000000000000000DEDEDE004F4F4F005353
      53005050500077777700D6D6D600CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00D6D6D600777777005050
      5000535353004F4F4F00DEDEDE0000000000FCFCFC00F3F3F300AFAFAF00F2F2
      F200E8E8E800E8E8E800E9E9E900E9E9E900EAEAEA00EBEBEB00EDEDED005757
      570021212100404040009A9A9A00EAEAEA00F6F6F600EDEDED00ECECEC00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EAEAEA00EAEAEA00E9E9E900E9E9E900EBEB
      EB00EAEAEA00B0B0B000FEFEFE00FDFDFD00FAFAFA00F1F1F10085858500EEEE
      EE00E9E9E900E8E8E800E9E9E900E9E9E900E9E9E900F0F0F000C1C1C1007575
      75007B7B7B0074747400ACACAC00F2F2F200ECECEC00F1F1F100CDCDCD007878
      78007B7B7B0074747400A3A3A300F0F0F000EAEAEA00E9E9E900E9E9E900E9E9
      E900F1F1F100B0B0B000E5E5E500FAFAFA0000000000F1F1F1002A2794000811
      AC001562EF001469F7001164F4000F63F400005BF4000E61F400A2BFFA007EA6
      F8000053F2000059F200005BF1000059F1000059F0000058EF000051ED000B57
      ED00B1C6F800A6BEF7000E55EA00004BE8000051E8000050E7000255EB00043A
      CF000600A400706EA000000000000000000000000000DEDEDE00535353005858
      5800555555007A7A7A00C8C8C800B1B1B100B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B1B1B100C6C6C6007A7A7A005656
      56005757570053535300DEDEDE0000000000FEFEFE00CACACA00D6D6D600EDED
      ED00E9E9E900E9E9E900EAEAEA00EAEAEA00EBEBEB00ECECEC00EEEEEE005C5C
      5C002D2D2D00303030002929290053535300B7B7B700F5F5F500F4F4F400ECEC
      EC00ECECEC00ECECEC00ECECEC00EBEBEB00EBEBEB00EAEAEA00EAEAEA00E9E9
      E900F1F1F100B4B4B400F0F0F000FCFCFC00FCFCFC00B7B7B700B6B6B600F0F0
      F000E8E8E800E9E9E900EAEAEA00EAEAEA00EBEBEB00F7F7F700989898001E1E
      1E002A2A2A001F1F1F0074747400F6F6F600EDEDED00F6F6F600B1B1B1002121
      21002A2A2A002020200068686800F4F4F400EBEBEB00EAEAEA00EAEAEA00E9E9
      E900ECECEC00E2E2E200B0B0B0000000000000000000C0C0C90004019B00154D
      D9001B70FA001869F4001668F400025FF3002F74F500C7D9FC00FFFFFF00FFFF
      FF0097B8FA000259F3000058F300005CF300005BF2000052F1001B61F100C1D3
      FB00FFFFFF00FFFFFF00CCD9FB00356EEE00004DEA000053E9000052E8000255
      EB00041FBC002F2A9600F5F5F5000000000000000000DEDEDE00575757005A5A
      5A00575757007D7D7D00CCCCCC00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500CACACA007D7D7D005757
      57005A5A5A0057575700DEDEDE000000000000000000AEAEAE00ECECEC00EAEA
      EA00EAEAEA00EAEAEA00EBEBEB00EBEBEB00ECECEC00EDEDED00EFEFEF005C5C
      5C002D2D2D0034343400343434002C2C2C002D2D2D006B6B6B00CFCFCF00FAFA
      FA00F2F2F200EDEDED00EDEDED00ECECEC00ECECEC00EBEBEB00EBEBEB00EAEA
      EA00EDEDED00D4D4D400CECECE00FEFEFE00000000008A8A8A00DCDCDC00ECEC
      EC00E9E9E900EAEAEA00EAEAEA00EBEBEB00ECECEC00F7F7F7009D9D9D002929
      2900343434002A2A2A007B7B7B00F7F7F700EEEEEE00F8F8F800B5B5B5002C2C
      2C00343434002B2B2B006F6F6F00F5F5F500ECECEC00ECECEC00EBEBEB00EAEA
      EA00EBEBEB00F0F0F00099999900FCFCFC00000000008F8FAF000C1DB8002270
      F6001F6EF6001D6CF5000F65F400528BF700ECF2FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B7CDFC001864F4000058F3000054F2002E6FF400D3E0FC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F3F7FE003F77F000004FEB000054EB000056
      EC000245DC000E0E9F00D7D7DB000000000000000000DEDEDE005B5B5B005F5F
      5F005C5C5C007E7E7E00EBEBEB00E4E4E400E4E4E400E4E4E400E4E4E400E4E4
      E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4
      E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400EAEAEA007D7D7D005D5D
      5D005E5E5E005B5B5B00DEDEDE0000000000FAFAFA00B0B0B000EFEFEF00EAEA
      EA00EAEAEA00EBEBEB00ECECEC00ECECEC00EDEDED00EEEEEE00F0F0F0005C5C
      5C002E2E2E003535350035353500353535003434340029292900363636008686
      8600E1E1E100FAFAFA00F0F0F000EDEDED00EDEDED00ECECEC00ECECEC00EBEB
      EB00ECECEC00E7E7E700B5B5B500000000000000000086868600EBEBEB00EBEB
      EB00EAEAEA00EAEAEA00ECECEC00ECECEC00EDEDED00F8F8F8009D9D9D002929
      2900343434002A2A2A007B7B7B00F8F8F800EFEFEF00F9F9F900B5B5B5002C2C
      2C00343434002B2B2B006F6F6F00F5F5F500EEEEEE00ECECEC00ECECEC00ECEC
      EC00EBEBEB00EFEFEF00ACACAC00EFEFEF00000000007474A2001A47D9002878
      FB002370F500226FF500196AF5004F88F700D5E2FC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D2E0FC002A70F5003E7CF600E3ECFD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC5FB00246AF1000054ED000056EC000056
      EC000256ED00041DB700BEBEC9000000000000000000DEDEDE00606060006161
      61005F5F5F007F7F7F00F2F2F200EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00F2F2F2007F7F7F005F5F
      5F006161610060606000DEDEDE0000000000EEEEEE00BEBEBE00EEEEEE00EBEB
      EB00EBEBEB00ECECEC00ECECEC00EDEDED00EEEEEE00F0F0F000F0F0F0005F5F
      5F00323232003A3A3A0039393900393939003838380038383800343434002929
      290044444400A1A1A100EFEFEF00F8F8F800EFEFEF00EDEDED00ECECEC00ECEC
      EC00ECECEC00EEEEEE00ACACAC0000000000EDEDED0097979700EFEFEF00EBEB
      EB00EBEBEB00ECECEC00ECECEC00EDEDED00EEEEEE00F9F9F9009C9C9C002929
      2900343434002A2A2A007A7A7A00F9F9F900F0F0F000FAFAFA00B3B3B3002C2C
      2C00343434002B2B2B006E6E6E00F6F6F600EFEFEF00EEEEEE00EDEDED00ECEC
      EC00ECECEC00EFEFEF00C0C0C000DEDEDE00000000007275A4002764EF002B79
      F9002973F6002572F6002370F500397DF6005189F600B9CDFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7EFFE00EEF4FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFEFF009AB9F9003F7DF5001461F1000058F0000058EF000057
      EE00005BF2000436CE00B9B9C6000000000000000000DEDEDE00656565006666
      6600656565005F5F5F00B0B0B000BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BDBDBD00B1B1B1005E5E5E006666
      66006565650064646400DEDEDE0000000000E4E4E400C5C5C500F1F1F100ECEC
      EC00ECECEC00ECECEC00EEEEEE00EEEEEE00EFEFEF00F0F0F000F0F0F0006363
      6300383838003F3F3F003F3F3F003F3F3F003E3E3E003C3C3C003B3B3B003A3A
      3A00333333002B2B2B0059595900BBBBBB00F0F0F000EFEFEF00EDEDED00ECEC
      EC00EFEFEF00F0F0F000B4B4B400FEFEFE00E0E0E000A0A0A000F1F1F100EEEE
      EE00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00FAFAFA009C9C9C002B2B
      2B00363636002B2B2B0079797900FAFAFA00F1F1F100FBFBFB00B2B2B2002E2E
      2E00363636002C2C2C006E6E6E00F6F6F600EFEFEF00EFEFEF00EEEEEE00EDED
      ED00EDEDED00F1F1F100D2D2D200D3D3D30000000000767FAB002F74FA002F7A
      F7002D76F6002B75F6002974F6002471F6004383F7004984F5009DBAF800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFBFE0086ABF7003C7CF5001464F400005AF300005BF200005AF1000059
      F100005CF3000246E000BABBC7000000000000000000DEDEDE00696969006969
      6900696969006969690065656500646464006464640064646400646464006464
      6400646464006464640064646400646464006464640064646400646464006464
      6400646464006464640064646400646464006464640065656500696969006969
      69006969690069696900DEDEDE0000000000E1E1E100C8C8C800F3F3F300F0F0
      F000EEEEEE00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1F100F1F1F1006767
      67003E3E3E004545450045454500444444004343430042424200404040003F3F
      3F003D3D3D003B3B3B002C2C2C0024242400B2B2B200F8F8F800EEEEEE00F0F0
      F000F2F2F200F2F2F200B5B5B500FEFEFE00DDDDDD00A3A3A300F3F3F300F1F1
      F100EEEEEE00EDEDED00EEEEEE00EFEFEF00EFEFEF00FBFBFB009D9D9D003232
      32003C3C3C00313131007B7B7B00FAFAFA00F3F3F300FBFBFB00B3B3B3003434
      34003C3C3C003232320070707000F6F6F600F1F1F100EFEFEF00EEEEEE00EFEF
      EF00F1F1F100F2F2F200D9D9D900CFCFCF00000000007884AF00337BFE00337C
      F7003179F6002F79F6002E77F6002B75F6002471F600397EF7003177F5007CA3
      F600EFF3FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6ED
      FD006494F500226CF4000F64F400045EF300085FF300045EF300025DF300005C
      F200005DF500024EE700BABCC8000000000000000000DEDEDE006D6D6D006D6D
      6D006B6B6B006D6D6D006C6C6C006D6D6D006C6C6C006D6D6D006C6C6C006D6D
      6D006C6C6C006D6D6D006C6C6C006D6D6D006C6C6C006D6D6D006C6C6C006D6D
      6D006C6C6C006D6D6D006C6C6C006D6D6D006B6B6B006C6C6C006B6B6B006C6C
      6C006C6C6C006D6D6D00DEDEDE0000000000E5E5E500CACACA00F4F4F400F2F2
      F200F2F2F200F1F1F100EFEFEF00EFEFEF00F1F1F100F2F2F200F2F2F2006C6C
      6C00454545004B4B4B004B4B4B004A4A4A004A4A4A0048484800474747004545
      45004141410035353500474747009A9A9A00E7E7E700F3F3F300F2F2F200F2F2
      F200F3F3F300F3F3F300B6B6B60000000000E1E1E100A6A6A600F4F4F400F2F2
      F200F2F2F200F1F1F100F0F0F000EFEFEF00F0F0F000FBFBFB009F9F9F003A3A
      3A0043434300393939007E7E7E00FAFAFA00F5F5F500FDFDFD00B3B3B3003C3C
      3C00434343003A3A3A0073737300F5F5F500F2F2F200F0F0F000F1F1F100F3F3
      F300F2F2F200F3F3F300D6D6D600D6D6D600000000007986B100387EFE00377F
      F700357CF700337CF700327AF6003079F6002E78F6002975F6002974F6001466
      F300BDD0FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1D3
      FB000F64F3000660F4001164F4001164F4000E62F4000C61F4000860F400065E
      F3000260F7000251EB00BDBFCB000000000000000000DEDEDE00727272007070
      7000707070007070700064646400616161006161610061616100606060006262
      6200636363006262620063636300626262006363630062626200626262006262
      62006262620062626200626262006E6E6E007070700070707000707070007070
      70007070700072727200DEDEDE0000000000EFEFEF00C5C5C500F5F5F500F3F3
      F300F3F3F300F4F4F400F4F4F400F2F2F200F2F2F200F3F3F300F2F2F2006F6F
      6F004A4A4A00515151005151510051515100505050004E4E4E004B4B4B004242
      42004646460086868600DFDFDF00FFFFFF00F6F6F600F4F4F400F4F4F400F4F4
      F400F4F4F400F5F5F500B0B0B00000000000000000009F9F9F00F5F5F500F3F3
      F300F3F3F300F4F4F400F4F4F400F3F3F300F2F2F200FBFBFB009F9F9F004040
      40004A4A4A004141410081818100FAFAFA00F6F6F600FDFDFD00B4B4B4004444
      4400494949003F3F3F0074747400F5F5F500F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F6F6F600C8C8C800E0E0E000000000008994B900397EFC003C83
      F7003A80F700387FF700367DF700337CF700337BF6002874F6002F78F600B9D0
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CADAFC003076F6000660F4001567F4001266F4001164F4000F63F4000C62
      F4000963F7000952E500D2D3DA000000000000000000DEDEDE00767676007474
      7400737373005F5F5F003F3F3F0042424200414141003E3E3E008E8E8E00C1C1
      C100CACACA00D4D4D400DFDFDF00EAEAEA00F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00777777007272720073737300727272007373
      73007373730076767600DEDEDE0000000000FDFDFD00B7B7B700F9F9F900F5F5
      F500F4F4F400F5F5F500F6F6F600F6F6F600F6F6F600F7F7F700F4F4F4007F7F
      7F00585858005A5A5A00575757005555550054545400525252004F4F4F007878
      7800CFCFCF00FFFFFF00FCFCFC00F7F7F700F6F6F600F6F6F600F6F6F600F5F5
      F500F6F6F600F2F2F200BABABA0000000000000000008F8F8F00F5F5F500F5F5
      F500F4F4F400F5F5F500F5F5F500F6F6F600F6F6F600FDFDFD00B1B1B1005C5C
      5C005A5A5A004C4C4C0085858500FAFAFA00F7F7F700FEFEFE00B5B5B5005151
      51005F5F5F006565650098989800F9F9F900F8F8F800F6F6F600F6F6F600F5F5
      F500F5F5F500F9F9F900B4B4B400F4F4F40000000000B7BBCC003674F4004287
      F9003E83F7003B82F7003A80F700397FF7002D77F7004184F700CCDCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E1EBFD004C87F7000460F4001869F4001667F4001466F4001265
      F4001167FA00245BD300F2F2F2000000000000000000DEDEDE00797979007777
      7700787878005B5B5B0046464600484848004848480043434300A7A7A700B0B0
      B000BBBBBB00C5C5C500CFCFCF00D8D8D800E9E9E9006F6F6F00505050005050
      500058585800FFFFFF00FFFFFF00939393007575750077777700777777007777
      77007777770079797900DEDEDE000000000000000000B5B5B500F8F8F800F6F6
      F600F5F5F500F6F6F600F6F6F600F7F7F700F8F8F800F9F9F900F8F8F800AFAF
      AF009797970095959500919191008D8D8D00888888009A9A9A00CDCDCD00FCFC
      FC00FFFFFF00FAFAFA00F8F8F800F8F8F800F7F7F700F7F7F700F6F6F600F6F6
      F600F8F8F800E0E0E000D3D3D300000000000000000093939300E8E8E800F7F7
      F700F5F5F500F6F6F600F6F6F600F7F7F700F8F8F800FCFCFC00CBCBCB009A9A
      9A009A9A9A008E8E8E00AEAEAE00FCFCFC00FBFBFB00FEFEFE00CFCFCF009393
      93009D9D9D009C9C9C00B5B5B500F8F8F800F8F8F800F8F8F800F7F7F700F6F6
      F600F7F7F700FAFAFA00A4A4A4000000000000000000EDEDEE00396AD900488D
      FD004285F7004184F7003F83F700327CF700548FF700DCE7FD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC3F700A1BAF600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F6FE006A9BF8001166F5001969F5001969F5001668
      F4001569FD005E7ABF00000000000000000000000000DEDEDE007D7D7D007B7B
      7B007B7B7B005F5F5F004A4A4A004C4C4C004B4B4B0047474700B3B3B300B0B0
      B000AFAFAF00BBBBBB00C5C5C500CFCFCF00DEDEDE006A6A6A00494949004B4B
      4B0050505000FFFFFF00FFFFFF0096969600787878007A7A7A00797979007A7A
      7A007A7A7A007D7D7D00DEDEDE000000000000000000D0D0D000E4E4E400F9F9
      F900F6F6F600F7F7F700F7F7F700F8F8F800F9F9F900F9F9F900F8F8F800B9B9
      B900A8A8A800ABABAB00A8A8A800AEAEAE00D2D2D200F9F9F900FFFFFF00FDFD
      FD00FBFBFB00FAFAFA00F9F9F900F9F9F900F9F9F900F8F8F800F7F7F700F8F8
      F800FCFCFC00C1C1C100F5F5F500FEFEFE00FEFEFE00C2C2C200C5C5C500FBFB
      FB00F7F7F700F7F7F700F8F8F800F8F8F800F9F9F900FDFDFD00CDCDCD00A5A5
      A500A9A9A900A6A6A600C0C0C000FDFDFD00FDFDFD00FFFFFF00D7D7D700A6A6
      A600A9A9A900A5A5A500B9B9B900F8F8F800FAFAFA00F8F8F800F7F7F700F7F7
      F700F8F8F800EFEFEF00BBBBBB000000000000000000000000007188C100468A
      FF004789F7004486F7004184F700659AF800EFF5FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A5BDF600407DF2003A7BF20093B0F400FAFBFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006A9AF700226FF5001B6BF5001D6E
      F7001561F500BABFCF00000000000000000000000000DEDEDE00808080007E7E
      7E007F7F7F00616161005050500051515100515151004A4A4A00C1C1C100BBBB
      BB00AFAFAF00AFAFAF00BBBBBB00C5C5C500D4D4D4006B6B6B004F4F4F005050
      500055555500FFFFFF00FFFFFF009B9B9B007C7C7C007E7E7E007E7E7E007E7E
      7E007E7E7E0080808000DEDEDE0000000000FEFEFE00F9F9F900BFBFBF00FDFD
      FD00F8F8F800F8F8F800F9F9F900F8F8F800F9F9F900FAFAFA00F9F9F900BFBF
      BF00AEAEAE00B2B2B200CACACA00F0F0F000FFFFFF00FEFEFE00FCFCFC00FCFC
      FC00FCFCFC00FBFBFB00FAFAFA00F9F9F900F9F9F900F9F9F900F8F8F800FAFA
      FA00F8F8F800BABABA0000000000FEFEFE00FDFDFD000000000097979700FAFA
      FA00F9F9F900F8F8F800F8F8F800F8F8F800F9F9F900FDFDFD00D4D4D400B2B2
      B200B5B5B500B1B1B100C8C8C800FDFDFD00FDFDFD00FFFFFF00DBDBDB00B3B3
      B300B5B5B500B2B2B200C3C3C300F8F8F800FAFAFA00F9F9F900F8F8F800F9F9
      F900FCFCFC00BEBEBE00EEEEEE00FDFDFD000000000000000000DADBE1003771
      EA004F92FC004789F700498BF80073A0F600C4D3F700FFFFFF00FFFFFF00FFFF
      FF00FCFCFE0096B2F400588DF4004787F7004084F700538BF4007CA0F200EFF2
      FC00FFFFFF00FFFFFF00FFFFFF00ABC0F5006394F400337AF600216EF5002272
      FE004B74CE00FEFEFE00000000000000000000000000DEDEDE00858585008181
      810082828200656565005555550057575700565656004F4F4F00CECECE00C5C5
      C500BBBBBB00AFAFAF00AFAFAF00BBBBBB00C9C9C9006F6F6F00545454005656
      560059595900FFFFFF00FFFFFF00A0A0A0007F7F7F0080808000808080008080
      80008181810085858500DEDEDE0000000000FEFEFE0000000000C6C6C600F0F0
      F000FBFBFB00F9F9F900F9F9F900FAFAFA00FAFAFA00FBFBFB00F9F9F900C7C7
      C700C6C6C600E9E9E900FFFFFF00FFFFFF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FCFCFC00FBFBFB00FAFAFA00FAFAFA00F9F9F900FAFAFA00FDFD
      FD00CECECE00EBEBEB00FEFEFE00000000000000000000000000B0B0B000D7D7
      D700FCFCFC00FAFAFA00F9F9F900FAFAFA00FAFAFA00FAFAFA00F4F4F400EFEF
      EF00F0F0F000F0F0F000F4F4F400FDFDFD00FDFDFD00FDFDFD00F7F7F700F0F0
      F000F1F1F100EFEFEF00F2F2F200FAFAFA00FAFAFA00F9F9F900FAFAFA00FBFB
      FB00F8F8F800AFAFAF0000000000FEFEFE000000000000000000000000008E9E
      C7004487FF005191F900498BF7004D8DF7006294F50096B2F300F7F9FD00FBFB
      FE0085A6F200568DF5004889F700377FF700377EF7003F84F700528CF6006390
      F100E2E9FB00F7F8FD0084A5F2005288F400397EF7002572F6002A77F9002166
      ED00D2D5DD0000000000000000000000000000000000DEDEDE00888888008585
      850086868600676767005A5A5A005B5B5B005B5B5B0051515100D9D9D900D0D0
      D000C4C4C400BBBBBB00AFAFAF00AFAFAF00BEBEBE006F6F6F00595959005A5A
      5A005C5C5C00F4F4F400FCFCFC00A3A3A3008383830085858500858585008585
      85008585850088888800DEDEDE000000000000000000FEFEFE00FCFCFC00BBBB
      BB00FFFFFF00FCFCFC00FAFAFA00FAFAFA00FBFBFB00FBFBFB00FBFBFB00F2F2
      F200FBFBFB00FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FDFD
      FD00FDFDFD00FDFDFD00FCFCFC00FBFBFB00FAFAFA00FBFBFB00FDFDFD00F4F4
      F400C0C0C00000000000FEFEFE000000000000000000FDFDFD00000000009494
      9400FAFAFA00FCFCFC00FAFAFA00FAFAFA00FAFAFA00FBFBFB00FCFCFC00FEFE
      FE00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00FBFBFB00FBFBFB00FAFAFA00FCFCFC00FEFE
      FE00B7B7B700F3F3F300FDFDFD0000000000000000000000000000000000FEFE
      FE006686CE004C8FFF005392F9004B8CF8004F8FF900538DF6006C94F0006B94
      F0004B87F600478AF8003F84F7004084F7003F83F7003A80F7003B82F7004585
      F7004D82F0005987EF004281F500387FF7002B76F600317BF800226EFD00A2B0
      CC000000000000000000000000000000000000000000DEDEDE008B8B8B008989
      89008A8A8A00696969005E5E5E005F5F5F005F5F5F0056565600E2E2E200DBDB
      DB00D0D0D000C4C4C400BBBBBB00AFAFAF00B3B3B300717171005D5D5D005F5F
      5F0060606000E9E9E900F1F1F100A5A5A5008787870089898900898989008989
      8900898989008B8B8B00DEDEDE000000000000000000FEFEFE0000000000E3E3
      E300D5D5D500FFFFFF00FDFDFD00FBFBFB00FBFBFB00FBFBFB00FCFCFC00FFFF
      FF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FDFDFD00FDFDFD00FCFCFC00FBFBFB00FCFCFC00FDFDFD00FFFFFF00BABA
      BA00FDFDFD00FEFEFE0000000000000000000000000000000000FEFEFE00DDDD
      DD00B4B4B400FEFEFE00FDFDFD00FBFBFB00FBFBFB00FBFBFB00FCFCFC00FDFD
      FD00FDFDFD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FDFDFD00FCFCFC00FBFBFB00FBFBFB00FDFDFD00FEFEFE00E0E0
      E000D2D2D20000000000FEFEFE00000000000000000000000000000000000000
      0000F8F8F8006286D2004C90FF005695FA004F8FF8004F8FF9004889F7003F84
      F600498CF8004588F7004587F7004486F7004285F7004184F7003E83F7003C82
      F700377EF700357CF600397FF700357CF6003780FB002572FD0094A7CF000000
      00000000000000000000000000000000000000000000DEDEDE008D8D8D008C8C
      8C008D8D8D006A6A6A0063636300646464006464640059595900E9E9E900E5E5
      E500DBDBDB00D0D0D000C4C4C400BBBBBB00B2B2B20072727200636363006363
      630063636300DFDFDF00E7E7E700A7A7A7008A8A8A008B8B8B008B8B8B008B8B
      8B008C8C8C008D8D8D00DFDFDF00000000000000000000000000FEFEFE000000
      0000D1D1D100E3E3E300FFFFFF00FDFDFD00FCFCFC00FCFCFC00FCFCFC00FDFD
      FD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FEFEFE00FEFE
      FE00FEFEFE00FDFDFD00FCFCFC00FDFDFD00FDFDFD00FFFFFF00C3C3C300F1F1
      F100000000000000000000000000000000000000000000000000FDFDFD000000
      0000BFBFBF00CCCCCC00FFFFFF00FDFDFD00FDFDFD00FCFCFC00FCFCFC00FDFD
      FD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FDFDFD00FCFCFC00FDFDFD00FEFEFE00EDEDED00BABA
      BA0000000000FEFEFE0000000000000000000000000000000000000000000000
      000000000000FCFCFC007F99CD003F84FF005798FF005594F9005090F8004F8F
      F8004D8DF8004C8CF700498AF700478AF7004688F7004587F7004386F7004184
      F7003F83F7003E83F7003F84F8003983FF003677EE00B0BCD200000000000000
      00000000000000000000000000000000000000000000DEDEDE00909090009090
      9000919191006E6E6E006767670068686800686868005F5F5F00F0F0F000F0F0
      F000E4E4E400DBDBDB00D0D0D000C4C4C400BDBDBD0077777700646464006666
      660064646400D4D4D400DBDBDB00A7A7A7008E8E8E0090909000909090009090
      90009090900092929200EDEDED0000000000000000000000000000000000FEFE
      FE0000000000D0D0D000DDDDDD00FFFFFF00FEFEFE00FEFEFE00FDFDFD00FDFD
      FD00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FE00FEFEFE00FEFEFE00FFFFFF00FEFEFE00FFFFFF00C4C4C400EDEDED000000
      0000FEFEFE00000000000000000000000000000000000000000000000000FDFD
      FD0000000000BABABA00C6C6C600FFFFFF00FEFEFE00FEFEFE00FDFDFD00FDFD
      FD00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00EAEAEA00B4B4B4000000
      0000FDFDFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C8D8005885DB004589FE005595FC005795
      FB005493F9005190F8004E8EF8004D8DF8004B8CF700498AF700488AF700478A
      F800468AFB004087FF003479F6006F95DA00E4E6EB0000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00939393009393
      930094949400707070006C6C6C006D6D6D006D6D6D0062626200F4F4F400FBFB
      FB00F0F0F000E4E4E400DBDBDB00CFCFCF00C5C5C500A6A6A600979797009696
      96009D9D9D00C5C5C500D0D0D000A8A8A8009191910092929200929292009292
      9200A1A1A100A9A9A90000000000000000000000000000000000000000000000
      0000FEFEFE0000000000DCDCDC00CBCBCB00FFFFFF00FFFFFF00FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00FFFFFF00F3F3F300BFBFBF00F6F6F60000000000FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD0000000000CDCDCD00AEAEAE00F9F9F900FFFFFF00FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00CDCDCD00C8C8C80000000000FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C5DD006C99EB004986
      EF004387F9004C8DF8004F8FF8004F8FF8004D8DF800488AF7004287F9003980
      F8004883EA0080A1DA00D7DEEB00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4E4E400999999009B9B
      9B009C9C9C007575750074747400747474007474740068686800FCFCFC00FFFF
      FF00FFFFFF00F9F9F900EEEEEE00E5E5E500DADADA00D2D2D200C9C9C900BEBE
      BE00BFBFBF00C8C8C800D3D3D300ADADAD00999999009A9A9A009A9A9A00A5A5
      A500A8A8A8000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE0000000000F8F8F800C1C1C100DBDBDB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F8F800CCCCCC00CFCFCF000000000000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD0000000000000000009D9D9D00CECECE00FDFDFD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E2E2E200A8A8A800ECECEC0000000000FDFDFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DFE5
      F100AEC7EE0089B1F50074A5F80073A4F80072A3F80078A8FA0093B3E900BCCE
      ED00ECF0F7000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900939393009999
      9900999999008D8D8D00888888008888880088888800868686009D9D9D00A0A0
      A000A0A0A0009F9F9F00A0A0A000A0A0A000A0A0A000A0A0A000A1A1A100A0A0
      A000A0A0A000A0A0A000A1A1A1009696960099999900999999009A9A9A00B4B4
      B400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE000000000000000000EEEEEE00C5C5C500C8C8
      C800E2E2E200F6F6F600FCFCFC00FFFFFF00FFFFFF00FBFBFB00F0F0F000D7D7
      D700C2C2C200CFCFCF00FDFDFD0000000000FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFE0000000000E5E5E500A0A0A000B6B6
      B600E0E0E000F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00EBEB
      EB00C2C2C200A6A6A600DFDFDF000000000000000000FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE0000000000000000000000
      0000EBEBEB00D6D6D600C6C6C600C9C9C900C8C8C800C9C9C900DCDCDC00F4F4
      F400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD0000000000000000000000
      0000D8D8D800B1B1B100A1A1A100A4A4A400A3A3A300A6A6A600B2B2B200D7D7
      D700FBFBFB000000000000000000FEFEFE000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000800000000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C0000007FFFFFFFF00000000FFE0000F
      80000001FFFFFFFF00000000FF80000F00000001FFFFFC0700000000FE00000F
      00000000FFFF800700000000F800000F00000000FF80000100000000F0000009
      00000000F000000000000000E0000000000000000000000000000000C0000000
      000000000000000000000000C000000000000000000000000000000080000001
      0000000000000000000000008000000100000000000000000000000080000001
      00000000000000000000000040000002000000000000000000000000C0000003
      000000000000000000000000C0000003000000000000000000000000C0000001
      0000000000000000000000008000000100000000800000000000000080000001
      0000000080000000000000008000000100000000800000000000000080000001
      000000008000000000000000C0000001000000008000000000000000C0000003
      000000008000000000000000C0000003000000008000000000000000C0000003
      000000008000000000000000E000000700000000C000000000000000E0000007
      00000000C000000000000000F000000F00000000C000000000000000F800001F
      00000000C000000100000000FC00003F00000000F800000300000000FE00007F
      00000001F800003F00000000FF0000FF00000001F800083F00000000FFC003FF
      80000003FC63187F00000000FFF81FFFFFFFFFFFFFFFF87FFFFFE01FFE00007F
      FFFFFFFFFF80F03FFF80F01FF000000FFFFFFF1F8000003F8000001F80000001
      FFFFFE0F0000001F0000001F00000000FFFFFC070000000F0000001F00000002
      FFFFF8030000000700000000C0000003FFFFF0030000000300000000C0000003
      FFFFE0010000000300000000C0000003FFFFE0010000000100000000C0000003
      FFFFE0000000000000000001C0000003FFFFF0000000000000000003C0000003
      FFFFF4000000000000000007C0000003FFFFF8000000000000000007C0000003
      FFFFFC000000001F0000000FC0000003FFFFFC000000001F0000001FC0000003
      8001FC000000001F0000003FC00000030000FC000000001F0000007FC0000003
      0000F8000000003F0000007FC00000030001F800000001FF000001FFC0000003
      0001F000000001FF000001FFC00000030005C000000001FF000001FFC0000003
      00000002000001FF000001FFC000000300000001000001FF000001FFC0000003
      00000005000001FF000001FFC000000300000003000001FF000001FFC0000003
      0000000F000001FF000001FFC000000300000017000001FF000001FFC0000003
      0000002F000001FF000001FFC00000030700005F000001FF000001FFC0000003
      8B8001FF000001FF000001FFC0000003B7F00FFFFFFFFFFFFFFFFFFFC0000007
      FFFFFFFFFFFFFFFFFFFFFFFFC000000FFFFFFFFFC0000003FF8001FFFF8000FF
      FFFC3FFF80000001FE00007FFE00007FFFE007FF80000001F800003FF800001F
      FF0001FF80000001F000001FF000000FFE00007F80000001E000000FF0000007
      F800003F80000001C0000007E0000003F000001F80000001C0000003C0000001
      F000000F800000018000000180000001E0000007800000018000000180000000
      C0000003800000010000000000000000C0000003800000010000000000000000
      8000000380000001000000000000000180000001800000018000000080000000
      8000000180000001000000018000000080000001800000010000000100000000
      8000000180000001000000000000000080000001800000010000000000000000
      8000000180000001000000010000000080000001800000010000000180000000
      8000000180000001000000018000000080000001800000018000000180000001
      80000003800000018000000000000001C0000003800000010000000240000000
      C00000038000000140000001C0000002E00000078000000180000005A0000001
      E000000F80000001A0000003C0000005F000001F80000001D000000FD000000B
      F800003F80000001E8000017E8000017FE00007F80000003F400002FF400002F
      FF8001FF80000007FA0000DFFB00005FFFE007FF8000000FFD80017FFE8001BF
      FFFFFFFFFFFFFFFFFF700FFFFF7006FF00000000000000000000000000000000
      000000000000}
  end
  object AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler
    Style = bsOffice2007Luna
    BorderColor = 14141623
    BorderColorHot = 14731181
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
    CaptionAppearance.CaptionColor = 15915714
    CaptionAppearance.CaptionColorTo = 15784385
    CaptionAppearance.CaptionTextColor = 11168318
    CaptionAppearance.CaptionBorderColor = clHighlight
    CaptionAppearance.CaptionColorHot = 16769224
    CaptionAppearance.CaptionColorHotTo = 16772566
    CaptionAppearance.CaptionTextColorHot = 11168318
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = 15587527
    Color.ColorTo = 16181721
    Color.Direction = gdVertical
    Color.Mirror.Color = 15984090
    Color.Mirror.ColorTo = 15785680
    Color.Mirror.ColorMirror = 15587784
    Color.Mirror.ColorMirrorTo = 16510428
    ColorHot.Color = 16773606
    ColorHot.ColorTo = 16444126
    ColorHot.Direction = gdVertical
    ColorHot.Mirror.Color = 16642021
    ColorHot.Mirror.ColorTo = 16576743
    ColorHot.Mirror.ColorMirror = 16509403
    ColorHot.Mirror.ColorMirrorTo = 16510428
    CompactGlowButtonAppearance.BorderColor = 14727579
    CompactGlowButtonAppearance.BorderColorHot = 15193781
    CompactGlowButtonAppearance.BorderColorDown = 12034958
    CompactGlowButtonAppearance.BorderColorChecked = 12034958
    CompactGlowButtonAppearance.Color = 15653832
    CompactGlowButtonAppearance.ColorTo = 16178633
    CompactGlowButtonAppearance.ColorChecked = 14599853
    CompactGlowButtonAppearance.ColorCheckedTo = 13544844
    CompactGlowButtonAppearance.ColorDisabled = 15921906
    CompactGlowButtonAppearance.ColorDisabledTo = 15921906
    CompactGlowButtonAppearance.ColorDown = 14599853
    CompactGlowButtonAppearance.ColorDownTo = 13544844
    CompactGlowButtonAppearance.ColorHot = 16250863
    CompactGlowButtonAppearance.ColorHotTo = 16246742
    CompactGlowButtonAppearance.ColorMirror = 15586496
    CompactGlowButtonAppearance.ColorMirrorTo = 16245200
    CompactGlowButtonAppearance.ColorMirrorHot = 16247491
    CompactGlowButtonAppearance.ColorMirrorHotTo = 16246742
    CompactGlowButtonAppearance.ColorMirrorDown = 16766645
    CompactGlowButtonAppearance.ColorMirrorDownTo = 13014131
    CompactGlowButtonAppearance.ColorMirrorChecked = 16766645
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 13014131
    CompactGlowButtonAppearance.ColorMirrorDisabled = 11974326
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    CompactGlowButtonAppearance.GradientHot = ggVertical
    CompactGlowButtonAppearance.GradientMirrorHot = ggVertical
    CompactGlowButtonAppearance.GradientDown = ggVertical
    CompactGlowButtonAppearance.GradientMirrorDown = ggVertical
    CompactGlowButtonAppearance.GradientChecked = ggVertical
    DockColor.Color = 15587527
    DockColor.ColorTo = 16445929
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 128
    DragGripStyle = dsNone
    FloatingWindowBorderColor = 14922381
    FloatingWindowBorderWidth = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GlowButtonAppearance.BorderColor = 14727579
    GlowButtonAppearance.BorderColorHot = 10079963
    GlowButtonAppearance.BorderColorDown = 4548219
    GlowButtonAppearance.BorderColorChecked = 4548219
    GlowButtonAppearance.Color = 15653832
    GlowButtonAppearance.ColorTo = 16178633
    GlowButtonAppearance.ColorChecked = 11918331
    GlowButtonAppearance.ColorCheckedTo = 7915518
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 7778289
    GlowButtonAppearance.ColorDownTo = 4296947
    GlowButtonAppearance.ColorHot = 15465983
    GlowButtonAppearance.ColorHotTo = 11332863
    GlowButtonAppearance.ColorMirror = 15586496
    GlowButtonAppearance.ColorMirrorTo = 16245200
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
    GroupAppearance.BorderColor = 12763842
    GroupAppearance.Color = 15851212
    GroupAppearance.ColorTo = 14213857
    GroupAppearance.ColorMirror = 14213857
    GroupAppearance.ColorMirrorTo = 10871273
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -11
    GroupAppearance.Font.Name = 'Tahoma'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggVertical
    GroupAppearance.GradientMirror = ggVertical
    GroupAppearance.TextColor = 9126421
    GroupAppearance.CaptionAppearance.CaptionColor = 15915714
    GroupAppearance.CaptionAppearance.CaptionColorTo = 15784385
    GroupAppearance.CaptionAppearance.CaptionTextColor = 11168318
    GroupAppearance.CaptionAppearance.CaptionColorHot = 16769224
    GroupAppearance.CaptionAppearance.CaptionColorHotTo = 16772566
    GroupAppearance.CaptionAppearance.CaptionTextColorHot = 11168318
    GroupAppearance.PageAppearance.BorderColor = 12763842
    GroupAppearance.PageAppearance.Color = 14086910
    GroupAppearance.PageAppearance.ColorTo = 16382457
    GroupAppearance.PageAppearance.ColorMirror = 16382457
    GroupAppearance.PageAppearance.ColorMirrorTo = 16382457
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.PageAppearance.ShadowColor = 12888726
    GroupAppearance.PageAppearance.HighLightColor = 16644558
    GroupAppearance.TabAppearance.BorderColor = 10534860
    GroupAppearance.TabAppearance.BorderColorHot = 10534860
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
    GroupAppearance.TabAppearance.ColorHot = 14542308
    GroupAppearance.TabAppearance.ColorHotTo = 16768709
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = 14016477
    GroupAppearance.TabAppearance.ColorMirrorHotTo = 10736609
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
    GroupAppearance.TabAppearance.TextColor = 9126421
    GroupAppearance.TabAppearance.TextColorHot = 9126421
    GroupAppearance.TabAppearance.TextColorSelected = 9126421
    GroupAppearance.TabAppearance.TextColorDisabled = clWhite
    GroupAppearance.TabAppearance.ShadowColor = 15255470
    GroupAppearance.TabAppearance.HighLightColor = 16775871
    GroupAppearance.TabAppearance.HighLightColorHot = 16643309
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
    PageAppearance.BorderColor = 14922381
    PageAppearance.Color = 15984090
    PageAppearance.ColorTo = 15785680
    PageAppearance.ColorMirror = 15587784
    PageAppearance.ColorMirrorTo = 16774371
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PageAppearance.ShadowColor = 12888726
    PageAppearance.HighLightColor = 16644558
    PagerCaption.BorderColor = 15780526
    PagerCaption.Color = 15525858
    PagerCaption.ColorTo = 15590878
    PagerCaption.ColorMirror = 15524312
    PagerCaption.ColorMirrorTo = 15723487
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clBlue
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -11
    PagerCaption.Font.Name = 'Tahoma'
    PagerCaption.Font.Style = []
    QATAppearance.BorderColor = 14005146
    QATAppearance.Color = 16050142
    QATAppearance.ColorTo = 15653065
    QATAppearance.FullSizeBorderColor = 13476222
    QATAppearance.FullSizeColor = 15584690
    QATAppearance.FullSizeColorTo = 15386026
    RightHandleColor = 14668485
    RightHandleColorTo = 14731181
    RightHandleColorHot = 13891839
    RightHandleColorHotTo = 7782911
    RightHandleColorDown = 557032
    RightHandleColorDownTo = 8182519
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = 15383705
    TabAppearance.BorderColorSelected = 14922381
    TabAppearance.BorderColorSelectedHot = 6343929
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 16709360
    TabAppearance.ColorSelectedTo = 16445929
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 14542308
    TabAppearance.ColorHotTo = 16768709
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 14016477
    TabAppearance.ColorMirrorHotTo = 10736609
    TabAppearance.ColorMirrorSelected = 16445929
    TabAppearance.ColorMirrorSelectedTo = 16181984
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
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = 9126421
    TabAppearance.TextColorHot = 9126421
    TabAppearance.TextColorSelected = 9126421
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = 15255470
    TabAppearance.HighLightColor = 16775871
    TabAppearance.HighLightColorHot = 16643309
    TabAppearance.HighLightColorSelected = 6540536
    TabAppearance.HighLightColorSelectedHot = 12451839
    TabAppearance.HighLightColorDown = 16776144
    TabAppearance.BackGround.Color = 16767935
    TabAppearance.BackGround.ColorTo = clNone
    TabAppearance.BackGround.Direction = gdVertical
    Left = 446
  end
  object ImageList1: TImageList
    Left = 323
    Top = 8
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8E8E800DADADA009090
      900077777700B1B1B100DCDCDC00DBDBDB00DBDBDB00DBDBDB00DBDBDB008282
      820081818100ADADAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1A9A400B3ABA400B5ACA500B2AE
      A500ACB0A600AAB2A800A8B2AB00A7B0AE00A7AEB300A7ACB700A7ACB700A8AB
      B600A9A9B600A9A7B600A7A5B300D4D3DC000000000000000000000000000000
      000000000000FEFEFE00FBF7F600F8F2F000F8F3F100FCFAFA00F0F4EF00C3D4
      BC00C4D5BD00FCFDFC000000000000000000CD784D00F0BEAA00AAAEB000E6E6
      E600E7E7E700D2D3D300A6857700F1C5B000F1C5B000F1C5B000B9A19500E9E9
      E900E9E9E90071656000A4604100000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F2EF
      EE00D5CDC900CDC4C0000000000000000000AF7D620096745300967351009674
      510068866100648F6800648F68005E8E81006173A5006072A5006072A5006687
      BD00756AA1006D5FA3006D5EA300A4A2B200000000000000000000000000FBF8
      F700EBD8D100E1C6BE00D9B4A300D6AA9600D8AC9700DDBDB10098A67C000495
      230004911F00FDFDFD000000000000000000E9B39F00E8BCA400E2E2E2008176
      6E00E7BEA600E3E4E40072696400F4C9AF00F3C8AE00F3C8AE0098979800E7E7
      E700E7E7E70094959500EFB39C00EBECEC000000000000000000000000000000
      0000FDFDFD00F3F1F000CFC6C200A7968E009A847600BAAB9900D3C8B700EBE4
      D600F2EDDF00D8CEBD00B9AEAB0000000000B1806500AE978200A98B6E00A982
      5E008EA1850086A6890077A47B00679C8C006F7BA5006575A6006575A6006788
      BE00A8A1C4009991BF008273C300A6A4B5000000000000000000F5EBE800E6D0
      C900E1996B00FFCC9D00FFDBBD00FFE1C900FEDEC500FFD4AF00AC92460000A3
      2B0004A32E00FAF9F800FEFEFE0000000000E8AF9400D9AF9700DFDFDF008B8B
      890082766D00E0E0E000807B7800F7C6A700F5C5A600F7C6A600B1B4B500E1E1
      E100E1E1E100B5B7B800E9AB8F00EAEAEA00DAD3D000AD9D95009F8B7F00B4A4
      9300D4C9BA00E2D9CC00F4F0E300F4EFE300F4EFE200F6F2E600E0D6CB00E5DC
      D100C8B7AF00B5A09700D9CDC100F6F6F600B2826700CEBBAA00C1A79000C097
      7200ABBCA100A9C3AA0090BC940073AC98008993B2007B89B2006D7EB400688A
      C200B3ADD900A89FD9008D7DDE00A7A4B80000000000F8F1EF00ECDBD500F398
      4F00FFC9A100FFD4B400FFE3CE00FFEADB000E9B2B0011A0310011A9390000B5
      3B0000B038000F982C001094280063A86400E6A38400D9A88C00DBDBDB00DEDE
      DE00DDDDDD00DEDEDE007F797600F4BD9900F3BB9800F3BB9800DBAE9100CDCE
      CF00CFCFCF00C99B8200E8A28100EAEAEA00ECE6DC00F7F3E900DBCFC700F4EF
      E500E6DDD400CCBCB500AF979200A78D8900C0ADA700E3DAD100CFC0B800F9F5
      EB00F7F3E800F2EDE200D1C4B900F5F5F500A9775E00DAC5B300D2B59D00D1A4
      7B00ADC2A400A6C4A8008DC0920070AF9500969FB8008994B2006E80B3005B7E
      B7009C94D2008E83D4007464D900A7A4BA00FEFDFD00F6EDEB00E5802F00FFB3
      7800FFB67E00FFCCA600FFD8BA00FFE3CE00E1D0B00006D0570000CA4C0000C6
      4A0000BF440000B53B0010B3430000000000E2977200D79E7D00D5D5D500DBDB
      DB00DBDBDB00D9D9D9007E777300F4B48A00F2B38900F2B38900F4B48900AFB2
      B400B3B5B600E6A17B00E4947000EAEAEA00B49E9A00D0C2BC00C0ADA800F8F4
      EB00FBF8EF00FCFAF100F3EEE500FAF7ED00FAF7ED00FAF7ED00BCA8A300FAF7
      ED00FAF7ED00FAF7EE00C8BAAF00F4F4F400B5846A00EFD6C400EBCAB100EBB8
      8C00B5D2AC00B4DAB7009CD7A0007BC0A000AEB8D200A3AFCE00869AD0006C90
      CA00AEA6E000A69DE2007868EB00ABA9BC00FCFAFA00D49E7D00FA944300F991
      3F00FFBC8900FFC59900FFD0AD00FFD8BB00FFD6B800A9B1760044E98C0042E3
      860043DD80005BE09000F2F2EE0000000000DF896100D5957100CFCFCF00D6D6
      D600D6D6D600D4D4D4007D746F00F1AA7900F0A97800F0A97800F4AB7900AAAD
      AE00AEB0B000E79A6C00E1885E00EAEAEA00D4C7C300FDFAF200BEABA700FDFA
      F300FDFAF300FCFAF200DED4D000EDE6DF00D8CDC800C4B2AD0094757300A990
      8D00B49E9B00CEBFBA00B3A19800F3F3F300B5846B00F8DBC600F6CFB300F6BC
      8E00ABD1A400AADAAE0091D7970075C09B00B4BFDA00AAB8D9008CA2DD006B8F
      CD00B0ADE900AEABE900A9A5EA00B2B1BD0000000000D46D1A00E0792800EC84
      3200FFC49800FFBC8A00FFC79C00FFCDA700FFD4B300FFD7B8008CC283007AF0
      AD0074F1AC00AC752000D4A07E0000000000DC7D5000D48D6300CBCBCB00D0D0
      D000D0D0D000D1D1D1007B736D00EFA16B00EDA06A00F5A266001D49C0003A73
      E4003B73E4001D51CE00A0552D00EAEAEA00BFADA900BDA9A500A48A8700D6CA
      C600E9E1DC00F4F0EC00CFC1BD00FFFDF700FFFDF600FFFCF500AF979400FFFC
      F500FFFCF500FFFDF600A7938800F2F2F200B5846A00FBD8BF00FACDAB00FABA
      8800AAD1A300B2DBB5008DD793006EBF9300B6C4E200ADBDE2008DA7E5006A8F
      CF00FFFFFE00FFFFFE00FFFFFE00B8B8BD0000000000D0671500D46D1C00E177
      2400FFE4CF00FFCFAA00FFDCC100FFE9D900FFF0E500FFEFE400FFE6D300AEED
      C4009BB26F00CC651400C1641B0000000000D9724300CD855A00C9C9C900CDCD
      CD00CDCDCD00CDCDCD007D787300F09B6000EC985E002E51C00087CCFD008BD0
      FF008BD1FF0089CEFE001F5CE000E9EAEA00D3C7C400FFFEF700C7B7B500FFFE
      F700FFFEF700FFFEF700BDAAA800FFFEF700FFFEF700FEFEF700B8A3A000F8F6
      F200F5F1EC00ECE7E1009D877B00F0F0F000B1806500F8D0B200F7C39B00F7B0
      7A00BAD0B100BAD7BC00A1D4A4006DBB9200AEBEE100A3B7E10085A2E500648A
      CB00DCDCDC00DCDCDC00DCDCDC00BDBDBD00EDEEED00DD731F00EE934D00F595
      4C00FFEFE300FFDBC000FFD2B000FFDBBF00FFE7D500FFF4ED00FFF3EA00FFE0
      C900FFC89D00CC641200CB600C0000000000D96A360091959800CBCBCB00CDCD
      CD00CDCDCD00CDCDCD00B9BABA007B4B2A00EC925600155CE40061BFFE0062C0
      FF0062C0FF0062C0FF00317CF000E9E9E900E2DAD800BEAAA800AA928F00BAA6
      A200BCA8A500C1B0AD00A3888600D8CCC900E3DBD600ECE6E300C2B0AE00FAF8
      F300FEFDF700FFFEF80099837600F0F0F000B5846900FBCBA700FABB8C00FAAA
      6F00F2C8B400FFFFFE00FFFFFE00CBD9EE00ADBFE900A1B7E90084A3ED00688E
      D100FFFFFE00FFFFFE00FFFFFE00BEBEBE00F4F5F400F6984F00FB913E00F7B4
      8100FFD0AE00FFD6B700FFD1AF00FFD8BA00FFE4D000FFEEE200FFECDE00FFD6
      B600FFA66100D0681700C75E0C00000000009D705C00C6C6C600CBCBCB00CCCC
      CC00CBCBCB00CBCBCB00CBCBCB009FA2A400D8834B000553E30036AEFE0036AF
      FF0036AFFF0036AFFF00196FEE00E9E9E900F0EDEC00FFFEF700EBE5E200FFFE
      F700FFFEF700FFFEF700BBA8A400FFFEF700FFFEF700FFFEF700DACFCC00FFFE
      F800FFFEF700FFFEF700A5918400EEEEEE00B6846A00FCDFC900FCD5B800FAAD
      7500F1C8B300FFFEFD00FFFEFD00CBD9EE00A5B9E90098B1EA007C9EED00668C
      D100FFFEFD00FFFEFD00FFFEFD00BFBFBE0000000000FA8C3A00FFAD6E00FFCC
      A600FFCCA600FFF3EB00FFD0AD00FFD2AF00FFDABE00FFDFC700FFDABE00FFC5
      9800FFB57C00E37C2A00B576420000000000A8ADB000E8E8E800E8E8E800E6E6
      E600E7E7E700E7E7E700E8E8E800E1E1E10096603C00004AE20012A0FE00129F
      FF00129FFF0012A0FF000663ED00E9E9E900F8F6F50095816C008E7863008B76
      5F0088725A0087715A00826B5400826C540087715A00846E5600857058008873
      5C0088735C008C796100836D5400ECECEC00B78B7400F3C1A400F3BB9B00F2AF
      8600F3D0BD00FFFDFB00FFFDFB00CBD8ED00A2B8EA0098B1EB00769BEE00648C
      D100FFFDFB00FFFDFB00FFFDFB00BFBEBE0000000000D68D4B00FFCAA200FFDD
      C300FFD1AE00FFE2CD00FFD2B100FFCFAA00FFCDA700FFCEA800FFC69A00FFB0
      7300FFC49700F68D3B00E0E0DC0000000000DBDFE000EBEBEB00E9E9E9008F8B
      8A00BBA79900E9E9E900EBEBEB00E9E9E900938073003F72E10088CFFF000199
      FF000097FF000099FF00005EEC00E9E9E90000000000CBBBAE00CBBBAE00806D
      6200CCBCAE008C7A6E00BCAC9F00C9B9AC00907B6F00CCBCAE00A29083008773
      6700CBBBAE00CBBBAE00C2AE9D00ECECEC00C2C1BF00FFFCF900FFFCF900FFFC
      F900FBF8F600FFFCF900FFFCF900CBD8EB00B7C5E600B5C4E6007EA0ED00638B
      D000FFFCF900FFFCF900FFFCF900BFBEBE0000000000FAFDFA00FFBD8C00FFF3
      EA00FFD4B400FFD2B000FFFBF900FFDBC000FFC9A000FFC39500FFB98300FFB8
      8100FFC59900D97C32000000000000000000BFC4C600EEEEEE00EDEDED00AB94
      8500FBDDC600E6E7E800EEEEEE00EBEBEB00C0A796004474E200A9DCFF00A9DD
      FF00B2E0FF005FBFFF002E7BF000E9E9E90000000000A0867800A28A7B008F7B
      6E00A48C7C00BAA49700A58D7E00A68E80008F7A6E00A48C7D00C1AA9D009C84
      7600A48C7D00A48C7D00A0877700FEFEFE00C2C0BE00FFFBF700FFFBF700FFFB
      F700FBF7F400FFFBF700FFFBF700CBD7EA00C3CDE500BAC7E50094AEEA00648C
      CF00FFFBF700FFFBF700FFFBF700BFBEBD000000000000000000E1E9CD00FFE6
      D400FFE4D000FFD6B600FFE8D800FFFAF700FFC79C00FFC29400FFBA8500FFE5
      D100FB914700000000000000000000000000BBABA600EEEEEE00EFEFEF00B09B
      8F00FADECD00E9EAEA00F0F0F000B2B4B500FADECD004470DD00B7E1FE00B7E2
      FF00B7E2FF00B7E2FE006695F400F3F3F3000000000000000000E6E1DF00B5AD
      A800B1A6A100A79389009F8A8000D3CAC600A99F99009C8E8800CBBAB100A498
      9200B8ADA900E2DDDB00EEEBEA0000000000C2C0BD00FFFAF600FFFAF600FFFA
      F600FBF7F300FFFAF600FFFAF600DDDDDF008DAEE2008DAEE2008DAEE2006E83
      A500FFFAF600FFFAF600FFFAF600BBBBBA00000000000000000000000000E4EB
      DB00FCC9A700FFE7D400FFD6B700FFCEA800FFE6D400FFC89E00FFE0C800EB9D
      590000000000000000000000000000000000EA8F65009D9E9F00EFF2F300E6D1
      C600F8E1D600C6CACC00CACED100F5DDD200F6DFD500F4DED40099BFFA00C8E6
      FF00C8E6FF00AED2FE009B675B00000000000000000000000000FEFEFE00C8B8
      B300F2F0EF00DCD4D100AFA29B00FDFDFD00C6B4AF00EBE9E700EEEBEA00B9A5
      9E00FDFCFC0000000000000000000000000095939200BFBCB900BFBCB900BFBC
      B900BCBAB700BFBCB900BFBCB900A9A7A500BFBCB900BFBCB900BFBCB9007573
      7200BFBCB900BFBCB900BFBCB900B7B6B5000000000000000000000000000000
      000000000000D0CDBD00D2A47A00E7A87900DBA17000CDAF8300F3F8F2000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000008003FFFF0000F8030001FFE30000E003
      0000F0010000C001000000000000800000000000000000010000000000000001
      0000000000008001000000000000800100000000000000010000000000000001
      000000000000800100000000000080010000800000008003000080000000C007
      0000C0010000E00F0001C0070000F81F00000000000000000000000000000000
      000000000000}
  end
end
