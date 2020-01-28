object TAddRegions: TTAddRegions
  Left = 860
  Top = 278
  Width = 597
  Height = 377
  Caption = 'Регионы'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = OnCloseRegion
  OnCreate = OnFormCreate
  OnResize = OnFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 45
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
    Styler = AdvPanelStyler1
    FullHeight = 0
    object AdvToolBar2: TAdvToolBar
      Left = 0
      Top = -1
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
      Images = ImageList2
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
        ImageIndex = 0
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnSaveGrid
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
        ImageIndex = 1
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnSetGrid
      end
      object AdvToolBarButton3: TAdvToolBarButton
        Left = 92
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
        ImageIndex = 2
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnAddRow
      end
      object AdvToolBarButton4: TAdvToolBarButton
        Left = 132
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Клонировать'
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
        ImageIndex = 3
        ParentFont = False
        Position = daTop
        Version = '3.1.6.0'
        OnClick = OnCloneRow
      end
      object AdvToolBarButton6: TAdvToolBarButton
        Left = 222
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Удалить все'
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
        OnClick = OnDelAllRow
      end
      object AdvToolBarSeparator1: TAdvToolBarSeparator
        Left = 82
        Top = 2
        Width = 10
        Height = 40
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator2: TAdvToolBarSeparator
        Left = 172
        Top = 2
        Width = 10
        Height = 40
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator4: TAdvToolBarSeparator
        Left = 262
        Top = 2
        Width = 10
        Height = 40
        LineColor = clBtnShadow
      end
      object cnlChngButt: TAdvToolBarButton
        Left = 272
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Режим отображения'
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
        OnClick = OnSetEditReg
      end
      object AdvToolBarButton5: TAdvToolBarButton
        Left = 182
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Удалить запись'
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
        OnClick = OnDelRow
      end
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 45
    Width = 589
    Height = 298
    Align = alClient
    BevelOuter = bvNone
    Color = 16445929
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
    Styler = AdvPanelStyler1
    FullHeight = 0
    object sgGrid: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 589
      Height = 275
      Cursor = crDefault
      Align = alClient
      DefaultRowHeight = 21
      RowCount = 5
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      GridLineWidth = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goRowSelect]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      GridLineColor = 15062992
      OnClickCell = OnClockCell
      OnGetEditorType = OnGetType
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
    object AdvPanel2: TAdvPanel
      Left = 0
      Top = 275
      Width = 589
      Height = 23
      Align = alBottom
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
      Styler = AdvPanelStyler1
      FullHeight = 0
      object Label1: TLabel
        Left = 447
        Top = 4
        Width = 139
        Height = 14
        Anchors = [akRight]
        Caption = 'ООО Автоматизация 2000'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clTeal
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
    end
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
    Settings.Caption.Color = 16773091
    Settings.Caption.ColorTo = 16765615
    Settings.Caption.Font.Charset = DEFAULT_CHARSET
    Settings.Caption.Font.Color = clBlack
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
    Settings.Color = 16445929
    Settings.ColorTo = 15587527
    Settings.ColorMirror = 15587527
    Settings.ColorMirrorTo = 16773863
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
    Settings.StatusBar.BorderColor = 16765615
    Settings.StatusBar.BorderStyle = bsSingle
    Settings.StatusBar.Font.Charset = DEFAULT_CHARSET
    Settings.StatusBar.Font.Color = 7485192
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 16245715
    Settings.StatusBar.ColorTo = 16109747
    Settings.StatusBar.GradientDirection = gdVertical
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Style = psOffice2007Luna
    Left = 344
    Top = 65533
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
    CaptionAppearance.CaptionBorderColor = clWhite
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
    TabAppearance.BackGround.Direction = gdHorizontal
    Left = 376
    Top = 8
  end
  object AdvFormStyler1: TAdvFormStyler
    AutoThemeAdapt = True
    Style = tsOffice2007Luna
    Left = 406
    Top = 7
  end
  object ImageList2: TImageList
    Height = 32
    Width = 32
    Left = 437
    Top = 2
    Bitmap = {
      494C010108000900040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC00DFDFDF009E9E9E0086868600848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008888
      8800AEAEAE00E3E3E300FCFCFC00000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000000000F8F8
      F800A8A8A800C4C4C400CACACA00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CCCCCC00C1C1
      C1008C8C8C00CECECE00F8F8F800000000000000000000000000000000000000
      0000ECDAC300CFA77D00CDA57D00CEA67D00CEA67E00CEA77E00CEA77E00CEA7
      7E00CEA77E00CEA77E00CEA77E00CEA77E00CEA77E00CEA77E00CEA77E00CEA7
      7E00CEA77E00CEA77E00CEA77E00CEA67E00CDA57C00CCA47C00C9A27900F7F2
      EC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00FBFB
      FB00FBFBFB00F9F9F900F9F9F900F7F7F700F7F7F700F9F9F900F9F9F900FBFB
      FB00FBFBFB00FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500DCDCDC00C2C2C400AEAEB400A8A8B000A8A8B000B3B3B700CACACA00E5E5
      E500FBFBFB000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F300C5C5C500CFCFCF00DBDAD900E6E3E100E5E2DF00DAD9D900D8D8D800D8D8
      D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D9D9D900DDDD
      DD00A9A9A900C3C3C300F6F6F600000000000000000000000000000000000000
      0000E3C8A100D5904E00D5925300D5945600D5955700D5965700D5965700D596
      5700D5965700D5965700D5965700D5965700D5965700D5965700D5965700D596
      5700D5965700D5965700D5965700D5955700D5955600D5935400C3814000F3EA
      E10000000000000000000000000000000000000000000000000000000000FBFB
      FB00F5F5F500EFEFEF00E8E8E800E4E4E400D0D0D000D9D9D900D5D5D500CECE
      CE00CCCCCC00CCCCCC00C8C8C800C7C7C700C7C7C700CACACA00CCCCCC00CCCC
      CC00CECECE00DADADA00D0D0D000D7D7D700E4E4E400E9E9E900EFEFEF00F7F7
      F700FDFDFD000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00D3D3D3008E8EA000504E
      880026238700120D8C0007029000060193000601930009048E0018138B00322F
      860062618C00A5A5AE00E6E6E600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F300C9C9C900D1D1D100EFE9E200FEF5EC00FDF4EB00E8E2DD00D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D6D6
      D600A8A8A800C2C2C200F6F6F600000000000000000000000000000000000000
      0000E2C9A200DA9C5B00DCA06300DCA36600DCA46800DCA46800DCA46800DCA4
      6800DCA46800DCA46800DCA46800DCA46800DCA46800DCA46800DCA46800DCA4
      6800DCA46800DCA46800DCA46800DCA46800DCA46700DCA16400C98B4B00F3EB
      E10000000000000000000000000000000000FBFBFB00EFEFEF00DEDEDE00D1D1
      D100CACACA00C5C5C500C0C0C000CFCFCF007E7E7E0076767600D1D1D100BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00C5C5C500AEAEAE007A7A7A00A7A7A700C3C3C300C1C1C100C5C5C500CCCC
      CC00D5D5D500E2E2E200F1F1F100FDFDFD000000000000000000000000000000
      0000000000000000000000000000D9D9D900727193001F1C890006009B000600
      A3000600A2000400A00002009D0002009C0002009D0002009E000600A1000600
      A3000600A20006019400353287009595A500EFEFEF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F300C9C9C900D2D1D100F7F0E800FEF5EC00FEF5EC00F1EBE400D3D3D300D3D3
      D300D3D3D300D4D4D400E7E7E700EDEDED00DFDFDF00D7D7D700D6D6D600DADA
      DA00D4D4D400D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D6D6
      D600A8A8A800C1C1C100F5F5F500000000000000000000000000000000000000
      0000E3C9A400DEA36500DEA76D00D2A16B00CE9F6A00D1A26C00D6A66F00DAA9
      7100DDAB7200DEAC7300DFAD7400E0AE7400E0AE7400E0AE7400E0AE7400E0AE
      7400E0AE7400E0AE7400E0AE7400E0AE7400E0AD7300E0AA6F00CC915300F3EB
      E20000000000000000000000000000000000EFEFEF00D5D5D500CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CECECE00E2E2E20082828200BEBEBE008E8E8E00E0E0
      E000CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00D1D1
      D100D9D9D900808080009C9C9C00BDBDBD00D3D3D300CECECE00CCCCCC00CCCC
      CC00CCCCCC00CECECE00DADADA00F3F3F3000000000000000000000000000000
      000000000000FEFEFE00A3A3AE00282589000600A1000600A20002009B000000
      9A000000A1000612AB000F1FB1001425B5001424B4000E1BAE00020CA7000000
      9E0000009A0004009D000600A400060099004A488A00CDCDCE00000000000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F300C9C9C900D1D1D100F7F0E800FEF5EC00FEF5EC00F1EBE400D3D3D300D3D3
      D300DDDDDD00F1F1F100FFFFFF00FFFFFF00FFFFFF00F9F9F900F6F6F600FEFE
      FE00EEEEEE00D5D5D500D3D3D300D3D3D300D3D1CE00D4CABF00D4C7BB00D6CC
      C200A8A7A500B4B4B400EBEBEB00FBFBFB000000000000000000000000000000
      0000E4CBA600E1AA6F00D3A470007F644600775F4300876D4D009E805B00AD8A
      6100B8936700C29B6D00CEA47300DCB07C00E3B58000E4B68000E4B68000E4B6
      8000E4B68000E4B68000E4B68000E4B68000E4B57E00E4B27B00CF975B00F3EC
      E20000000000000000000000000000000000F9F9F900EDEDED00E6E6E600E2E2
      E200E0E0E000E0E0E000DEDEDE00EDEDED00A5A5A500C3C3C3009E9E9E00B9B9
      B900EBEBEB00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00F3F3
      F30091919100AFAFAF0085858500E8E8E800E2E2E200DEDEDE00E0E0E000E0E0
      E000E2E2E200E8E8E800EFEFEF00FBFBFB000000000000000000000000000000
      0000FBFBFB0081819C000A0595000600A300040099000206A200122EBD003158
      D600507AE600658EEE007299F200799EF2007B9FF2007699F0006A8DEA005274
      DF002F4DCB000C1EB10000009D0004009C000600A40024218C00B7B7BE000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F300C9C9C900D1D1D100F7F0E800FEF5EC00FEF5EC00F1EBE400D3D3D300D1D1
      D100F5F5F500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FEFEFE00F4F4F400D5D4D300D7BFA600DC9A5900DB8E4200D6863800D386
      3B00BD80440094897C00C3C3C300E9E9E9000000000000000000000000000000
      0000E5CDA800E5B27800C9A1740055524F002A2A29002C3B3E0043A7C40051A2
      B8006097A000718E8A00908A7300BF9D7300DEB78600E7BE8B00E8BF8C00E8BF
      8C00E8BF8C00E8BF8C00E8BF8C00E8BF8C00E8BD8A00E8BA8600D29D6300F4EC
      E300000000000000000000000000000000000000000000000000FDFDFD00FBFB
      FB00F9F9F900F7F7F700F5F5F500F7F7F700F1F1F10093939300CCCCCC009292
      920000000000F3F3F300F1F1F100F1F1F100F1F1F100F1F1F100F7F7F700D5D5
      D5009B9B9B00B8B8B8007878780000000000F3F3F300F5F5F500F7F7F700F9F9
      F900FDFDFD000000000000000000000000000000000000000000000000000000
      000082829E0006009B0006009E000204A0001137C600326BE9004F86F5005489
      F4004980F1003B75EE00306CEC002D6AEB002F69EA00386EEA004879EC005C87
      EE006892F1005E88EC00375DD8000C21B30000009B000600A3001A159000BFBF
      C50000000000000000000000000000000000000000000000000000000000F3F3
      F300C9C9C900D1D1D100F7EFE800FEF5EC00FEF5EC00F0EAE400D3D3D300D4D4
      D400F9F9F900FFFFFF00FFFFFF00FDFDFD00FAFAFA00FEFEFE00F7F7F700FDFD
      FD00FFFFFF00FCFBFA00DEB68E00DF8F4100D7853500D2803000D17F2F00D17F
      2F00D17F2F00CF8236009E876E00BFBFBF000000000000000000000000000000
      0000E5CFAA00E9BA8300E3BB8B0099948C007272720051737B0045D1FA0045D2
      FF0044D2FF0042CEFD0059A3BE008E7B6200C1A37C00E4C19300ECC79800ECC8
      9900ECC89900ECC89900ECC89900ECC89900ECC69700ECC39200D5A56C00F4ED
      E400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00CECECE00C0C0
      C000BFBFBF000000000000000000000000000000000000000000000000009E9E
      9E00C3C3C3009C9C9C00D4D4D400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A9A9
      B6000904980006009D00041AB0001557E6002E76F8002E72F3001963F0000458
      EE000053EC000051EB000050EA00004FE900004FE800004DE700004CE600004D
      E6000E54E6002D65E700497BEC004476EB001A41CC000206A1000600A2002926
      8E00E1E1E100000000000000000000000000000000000000000000000000F3F3
      F300C9C9C900D1D1D000F7EFE800FEF5EC00FEF5EC00F0EAE400D1D1D100EFEF
      EF00FFFFFF00FFFFFF00FFFFFF00F9F9F900D0D0D000CECECE00CFCFCF00D3D3
      D300F3F3F300F7E4CF00E2924500D6843400D17F2F00D4873C00D4883D00D17F
      2F00D17F2F00D2803000D3873C00958D83000000000000000000000000000000
      0000E6D1AC00ECC18E00EAC69900B0A59400778B90005BC2DC0057DAFF0057DA
      FF0057DAFF0055D8FF004DA7C40072686300917F6800C8AE8900E7C99F00EFD0
      A400F0D0A500F0D0A500F0D0A500F0D0A500F0CFA300F0CC9E00D8AA7400F4ED
      E400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F9009D9D9D00DCDC
      DC00ABABAB000000000000000000000000000000000000000000DEDEDE00B6B6
      B600B1B1B100A4A4A40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E4E4E4002623
      910006009F000624B900095FF2001468F7000B60F3000059F1000058F1000058
      F0000058EF000057EE000056ED000055EC000054EB000054EA000053E9000052
      E800004EE600004CE600004FE6001F5EE700316CEC00184CD900040CA5000600
      A20065639800FEFEFE000000000000000000000000000000000000000000F3F3
      F300C9C9C900D0D0D000F6EFE700FEF5EC00FEF5EC00F0EAE300CFCFCF00F1F1
      F100FFFFFF00FFFFFF00FFFFFF00FAFAFA00D6D6D600D3D3D300D3D3D300D1D1
      D100CBCAC900EAAD7100DC8A3A00D2803000D58A4100EECFB100E9C29A00DA99
      5900D17F2F00D17F2F00D9873700AB7D4D000000000000000000000000000000
      0000E8D2AF00F0CA9800F2D2A700BABCA7005CD3F8006BE1FF006CE1FF006CE1
      FF006BE1FF0068DFFF0048A3BF0036302E006D635D0096867000C9B49300EDD3
      AC00F4DAB100F4DAB200F4DAB200F4DAB200F4D8AF00F4D5AA00DBB17D00F4EE
      E500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B8B8B800C1C1
      C100CACACA00C1C1C10000000000000000000000000000000000A4A4A400C2C2
      C20090909000EEEEEE0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008181A4000600
      A0000923B7000F64F5000C64F700085FF300045EF300005BF3000055F2000054
      F100005AF1000059F0000058EF000057EE000056ED000056EC000055EC000051
      EA000050E900004DE800004EE700004FE6000852E600165CEA000845D9000409
      A4000C079700C9C9CE000000000000000000000000000000000000000000F3F3
      F300C9C9C900D0D0D000F6EFE700FEF5EC00FEF5EC00EFE9E300CECECE00E9E9
      E900FFFFFF00FFFFFF00FDFDFD00DBDBDB00D3D3D300D3D3D300D3D3D300D3D3
      D300CCC7C100EEA66000DC8A3A00D6843400DD985500E7B78800D98C4100F0D0
      B100D6863600D6843400DB893900CB8948000000000000000000000000000000
      0000E9D5B100F3D1A100F7DBB300E1CEAE006BD5F4007BE6FF007EE9FF007EE9
      FF007DE8FF0071E0FF0043B2D50010202600342B27006D635C009A8C7700D5C2
      A200F2DCB900F7E1BC00F8E2BD00F8E2BD00F8E0BA00F8DDB500DEB78400F5EE
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD009797
      9700DCDCDC00A5A5A500F7F7F7000000000000000000C9C9C900B9B9B900ACAC
      AC00A3A3A3000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F1002A2794000811
      AC001562EF001469F7001164F4000F63F400005BF4000E61F400A2BFFA007EA6
      F8000053F2000059F200005BF1000059F1000059F0000058EF000051ED000B57
      ED00B1C6F800A6BEF7000E55EA00004BE8000051E8000050E7000255EB00043A
      CF000600A400706EA0000000000000000000000000000000000000000000F3F3
      F300CACACA00D2D2D200F6EFE700FEF5EC00FEF5EC00F0EAE400D3D3D300E3E3
      E300FFFFFF00FFFFFF00FFFFFF00EAEAEA00D5D5D500D5D5D500D5D5D500D5D5
      D500D3CDC800F7B57400E2904000DE8C3C00E2995200F0CBA800DE8C3D00F3D6
      B800E0934900DE8C3C00E3924100D6924F000000000000000000000000000000
      0000EAD7B400F6D7AA00FBE3BD00F1DEBC009DD3D70088EAFF0091F0FF008FEF
      FF0084E8FF0070E7FF005AE8FE0035AECF000B1D240030262400685E5800A195
      8000DBCCAE00F6E4C400FBE9C800FBE9C800FBE7C500FBE4C000E1BC8C00F5EE
      E600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000BBBBBB00D4D4D400A6A6A60000000000FDFDFD009D9D9D00C2C2C2008E8E
      8E00F3F3F3000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C90004019B00154D
      D9001B70FA001869F4001668F400025FF3002F74F500C7D9FC00FFFFFF00FFFF
      FF0097B8FA000259F3000058F300005CF300005BF2000052F1001B61F100C1D3
      FB00FFFFFF00FFFFFF00CCD9FB00356EEE00004DEA000053E9000052E8000255
      EB00041FBC002F2A9600F5F5F50000000000000000000000000000000000F3F3
      F300CBCBCB00D4D4D400F6F0E800FEF6ED00FEF6ED00F0EAE400D6D6D600C9C9
      C900EFEFEF00FAFAFA00F7F7F700EAEAEA00D7D7D700D7D7D700D7D7D700D7D7
      D700D7D4D100F8C28E00EA994A00E4924200E4944500F5D5B700E69B5100F5D5
      B600E79B5200E4924200EE9C4C00D19355000000000000000000000000000000
      0000EBD8B600F8DCB200FDE8C600FAE8CA00C6D8CB0083E6FE008CE9FC007DD9
      EE0087E6FC0090F7FF0079F6FF005BE9FF0038B6D8000F2A330029211F00695F
      5700A69C8800E0D2B800F8E9CC00FDEED000FDEDCE00FDE9C800E2C09100F5EF
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000098989800DADADA00ACACAC00F4F4F400B5B5B500BDBDBD00A7A7A700ABAB
      AB00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F8FAF000C1DB8002270
      F6001F6EF6001D6CF5000F65F400528BF700ECF2FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B7CDFC001864F4000058F3000054F2002E6FF400D3E0FC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F3F7FE003F77F000004FEB000054EB000056
      EC000245DC000E0E9F00D7D7DB0000000000000000000000000000000000F3F3
      F300CDCDCD00D6D6D600F7F1EA00FEF7EF00FEF7EF00F0EBE600D9D9D900DADA
      DA00E2E2E200CFCFCF00D8D8D800DADADA00DADADA00DADADA00DADADA00D9D9
      D900F4F4F400FEE1C600F4A96100E7954500E7954500EAA45F00F4D1AD00F2C6
      9B00E7964700E9974700F7A55500B39576000000000000000000000000000000
      0000ECD9B700F9DFB700FFECCD00FEF0D300EEE7D0009FC2C4006C888F002B37
      39005A828300A2F3FA0096F8FF007BF6FF005FECFE003DBEDE00133F4D00261E
      1C00635A5300A9A08F00DFD5BD00FAEED300FFF0D500FFEDCF00E3C39600F5EF
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C9C9C900B8B8B800D7D7D7008E8E8E009D9D9D00BEBEBE008D8D8D00F9F9
      F900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007474A2001A47D9002878
      FB002370F500226FF500196AF5004F88F700D5E2FC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D2E0FC002A70F5003E7CF600E3ECFD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC5FB00246AF1000054ED000056EC000056
      EC000256ED00041DB700BEBEC90000000000000000000000000000000000F3F3
      F300D0D0D000DADAD900F8F1EB00FFF7F000FFF7F000F2ECE700DDDDDD00C9C9
      C900DDDDDD00EDEDED00E5E5E500ECECEC00DEDEDE00DEDEDE00DEDEDE00D8D8
      D800E5E5E500FEFAF500FDD0A400EEA05300E7954500E7954500E7954600E795
      4500E9974700F3A35300DFA06400C9C7C5000000000000000000000000000000
      0000ECDAB800F9E2BB00FFEED000FFF3D700FCF3D900ECE3CC00AFA99E005D57
      5600211F1F005C858700A1F1F70095F8FF007BF7FF005EEBFF0040C4E5001239
      4500251D1A00675F5700ACA69400E6DDC500FCF0D600FEEFD200E3C59900F4EF
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900D3D3D300A8A8A8009A9A9A00A5A5A500B3B3B3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007275A4002764EF002B79
      F9002973F6002572F6002370F500397DF6005189F600B9CDFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7EFFE00EEF4FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFEFF009AB9F9003F7DF5001461F1000058F0000058EF000057
      EE00005BF2000436CE00B9B9C60000000000000000000000000000000000F3F3
      F300D1D1D100DCDCDC00F8F2ED00FFF8F200FFF8F200F2EDE900E0E0E000DADA
      DA00E6E6E600FEFEFE00F8F8F800E9E9E900E7E7E700E1E1E100E1E1E100E1E1
      E100D8D8D800F5F5F500FFF7F100FDD4AC00F5AD6800ED9E5100EB9B4D00EE9F
      5200F6AB6200DEA77100C7C2BD00F3F3F3000000000000000000000000000000
      0000ECDAB900F9E3BE00FFF0D400FFF5DC00FFF7DF00FDF5DE00F3ECD500BAB4
      A800635E5D002321200048676800A2F2F80098F8FF007EF7FF0063EEFF0042CB
      EC00124455002119170062595200B2AD9C00E9E0C900FCEFD400E3C69C00F4EE
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D8D8D800B0B0B000BDBDBD009898980086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000767FAB002F74FA002F7A
      F7002D76F6002B75F6002974F6002471F6004383F7004984F5009DBAF800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFBFE0086ABF7003C7CF5001464F400005AF300005BF200005AF1000059
      F100005CF3000246E000BABBC70000000000000000000000000000000000F3F3
      F300D3D3D300E0E0E000F8F2EE00FFF8F300FFF8F300F3EEEA00DEDEDE00E9E9
      E900F3F3F300F5F5F500FCFCFC00F8F8F800EAEAEA00E5E5E500E5E5E500E5E5
      E500E4E4E400E3E3E300FFFFFF00FCF9F700EFDECC00F8D4B100F9CFA800F7CF
      A800C7B29D00B8B7B500F1F1F100FEFEFE000000000000000000000000000000
      0000ECDBBA00F9E4C100FFF1D700FFF6DF00FFF8E200FFF8E200FEF7E200F5F0
      DA00C6C1B3006B666400282423004D6D6F00A0EEF40098F8FF0081F7FF0063EE
      FF0045D0F100154A5B00201D1C005F5D5600B7B2A100EDE2CA00E3C79D00F3ED
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4E4E4008F8F8F00AAAAAA00B2B2B2009A9A9A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007884AF00337BFE00337C
      F7003179F6002F79F6002E77F6002B75F6002471F600397EF7003177F5007CA3
      F600EFF3FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6ED
      FD006494F500226CF4000F64F400045EF300085FF300045EF300025DF300005C
      F200005DF500024EE700BABCC80000000000000000000000000000000000F3F3
      F300D6D6D600E2E2E200F8F4F100FFFAF600FFFAF600F3F0ED00E6E6E600D8D8
      D800F7F7F700F6F6F600F2F2F200DEDEDE00E9E9E900E9E9E900E8E8E800E4E4
      E400F4F4F400FFFFFF00FEFEFE00F0F0F000E8E8E800E8E8E800E8E8E800E8E8
      E800B5B5B500C2C2C200F6F6F600000000000000000000000000000000000000
      0000ECDBBA00F9E6C400FFF3DA00FFF7E200FFFAE600FFFAE600FFFAE600FEF9
      E500F8F4E000D3CFC1007F7A77002C272700395050009AE5EA009CF8FF0083F7
      FF0066F0FF004BCFEC003E565D0031313100706E6900C9C1AF00E3C8A000F3ED
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD009D9D9900A7A7A800A6A6A600C4C4C400ABABAB00A6A6A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007986B100387EFE00377F
      F700357CF700337CF700327AF6003079F6002E78F6002975F6002974F6001466
      F300BDD0FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1D3
      FB000F64F3000660F4001164F4001164F4000E62F4000C61F4000860F400065E
      F3000260F7000251EB00BDBFCB0000000000000000000000000000000000F3F3
      F300D7D7D700E4E4E400F8F4F100FFFAF600FFFAF600F3F0ED00E9E9E900E5E5
      E500E0E0E000E7E7E700D9D9D900EDEDED00E5E5E500F5F5F500F9F9F900F7F7
      F700FCFCFC00FFFFFF00FAFAFA00E9E9E900EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00B8B8B800C2C2C200F6F6F600000000000000000000000000000000000000
      0000ECDBBB00F9E6C600FFF4DD00FFF9E500FFFBE900FFFBE900FFFBE900FFFB
      E900FEFBE800F9F6E400DDD9CB007F7A77002E2929003D56570097DFE4009BF8
      FF0086F7FE0098CFD5006C6C6E003B3B3B004B4A6C00A6A0B300E3C9A200F2ED
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005E5EC100BBBBCB00C1C1B9009191910090909000A2A29A00747498008080
      E700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008994B900397EFC003C83
      F7003A80F700387FF700367DF700337CF700337BF6002874F6002F78F600B9D0
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CADAFC003076F6000660F4001567F4001266F4001164F4000F63F4000C62
      F4000963F7000952E500D2D3DA0000000000000000000000000000000000F3F3
      F300D8D8D800E7E6E600F9F5F300FFFBF800FFFBF800F4F1EF00EBEBEB00EDED
      ED00EDEDED00EDEDED00E5E5E500DFDFDF00DFDFDF00E9E9E900F5F5F500FDFD
      FD00FDFDFD00FBFBFB00E8E8E800EDEDED00EDEDED00EDEDED00EDEDED00ECEC
      EC00B9B9B900C3C3C300F6F6F600000000000000000000000000000000000000
      0000ECDBBB00F9E8C800FFF5E000FFFAE800FFFCEC00FFFCEC00FFFCEC00FFFC
      EC00FFFCEC00FEFCEC00FCF9E900E5E2D5008F8B8600322D2D002B3A3B009AE0
      E400CBEBEF00C6C7CB007D7D8000727274006760C0009D96BE00E3CAA400F2EC
      E600000000000000000000000000000000000000000000000000000000000000
      000000000000F7F7FD00ACACEC00A4A4EB00E9E9FE0000000000000000005757
      FB000000CC001818BA00ADADBA00000000000000000076769D000505BB000000
      D2009B9BFB000000000000000000D3D3FB009C9CE800B7B7EF00000000000000
      00000000000000000000000000000000000000000000B7BBCC003674F4004287
      F9003E83F7003B82F7003A80F700397FF7002D77F7004184F700CCDCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E1EBFD004C87F7000460F4001869F4001667F4001466F4001265
      F4001167FA00245BD300F2F2F20000000000000000000000000000000000F3F3
      F300D8D8D800E6E6E600F8F5F300FFFBF800FFFBF800F4F1EE00EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00E6E6E600E4E4E400DADA
      DA00DCDCDC00DEDDDD00E8E7E500E7E6E500E7E6E500E7E6E500E7E6E500E5E4
      E300B7B6B500CBCBCB00F8F8F800000000000000000000000000000000000000
      0000ECDBBC00F9E8CB00FFF6E200FFFAEB00FFFDEE00FFFDEE00FFFDEE00FFFD
      EE00FFFDEE00FFFDEE00FEFCEE00FCFAEC00EBE9DC009E9B96006D6A6A008283
      84008D8D8E0097979900CBCACF00A399CD007B6AD700A89FB900E3CAA500F0EB
      E600000000000000000000000000000000000000000000000000000000000000
      00008E8EE8000707CE000A0AD7000E0EDC000B0BE5005757F7003D3DF4000000
      D7000000C5002B2BCC00000000000000000000000000FBFBFD000B0BC6000000
      C6000202DE005959F7003A3AF5000C0CE1000E0EDC000808D4001313CF00C5C5
      F4000000000000000000000000000000000000000000EDEDEE00396AD900488D
      FD004285F7004184F7003F83F700327CF700548FF700DCE7FD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC3F700A1BAF600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F6FE006A9BF8001166F5001969F5001969F5001668
      F4001569FD005E7ABF000000000000000000000000000000000000000000F3F3
      F300D8D8D800E6E6E600F8F5F200FFFBF800FFFBF800F3F0EE00EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EBE3DA00E9AE7500EBA66300EAA56300EAA56300EAA56300EAA56300E6A2
      6100A7917B00E4E4E400FCFCFC00000000000000000000000000000000000000
      0000ECDBBC00F9E9CD00FFF6E500FFFBED00FFFDF000FFFDF000FFFDF000FFFD
      F000FFFDF000FFFDF000FFFDF000FFFDF000FDFCEF00F2F1E500DDDCD600B3B3
      B30080808000ACA9B100C4B8E0009279D000816ABF00C4BBBC00E1C8A400EEEA
      E500FEFEFE00000000000000000000000000000000000000000000000000AFAF
      F1000000D1000404D3006161F0006F6FFB001D1DF7001F1FEE000808E7000505
      DA000404D000DADAF700000000000000000000000000000000009B9BEB000000
      D1000808DD000707E9002525F0002A2AFA007B7BFA004747EC000000D2000808
      D400E6E6FA0000000000000000000000000000000000000000007188C100468A
      FF004789F7004486F7004184F700659AF800EFF5FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A5BDF600407DF2003A7BF20093B0F400FAFBFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006A9AF700226FF5001B6BF5001D6E
      F7001561F500BABFCF000000000000000000000000000000000000000000F3F3
      F300D8D8D800E6E6E600F8F4F200FFFBF800FFFBF800F3F0EE00EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00F0C19400F7A45400F6A35300F6A35300F6A35300F6A35300F5A35400B191
      7100DBDADA00F9F9F90000000000000000000000000000000000000000000000
      0000ECDCBD00F9E9CE00FFF7E700FFFBEF00FFFEF300FFFEF300FFFEF300FFFE
      F300FFFEF300FFFEF300FFFEF300FFFEF300FFFEF300FDFCF100F1F0E500C4C1
      C1008475A0009179B7009478BF00866AB400A395B400E1D8C800DCC29F00E9E3
      DB00FDFCFC00FEFEFE0000000000000000000000000000000000000000001818
      DE000000C600BEBEEF000000000000000000FBFBFE002626F7002020F7000707
      E6007B7BEB000000000000000000000000000000000000000000000000003A3A
      E2000E0EEB002020F8004444F9000000000000000000000000007171DB000000
      CE004E4EE6000000000000000000000000000000000000000000DADBE1003771
      EA004F92FC004789F700498BF80073A0F600C4D3F700FFFFFF00FFFFFF00FFFF
      FF00FCFCFE0096B2F400588DF4004787F7004084F700538BF4007CA0F200EFF2
      FC00FFFFFF00FFFFFF00FFFFFF00ABC0F5006394F400337AF600216EF5002272
      FE004B74CE00FEFEFE000000000000000000000000000000000000000000F3F3
      F300D8D8D800E6E6E600F8F4F200FFFBF800FFFBF800F3EFED00EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00F8C39000FAA85900F6A35300F6A35300F7A45400F7A55600B3927200DBDB
      DB00F8F8F8000000000000000000000000000000000000000000000000000000
      0000ECDCBD00F9E9D000FFF7E800FFFBF000FFFEF400FFFEF400FFFEF400FFFE
      F400FFFEF400FFFEF400FFFEF400FFFEF400FFFEF400FEFDF400FAF8EE00ECE8
      DD00CFC6C500B8A9B500B8A9B400CABFBA00DCD4C300E7DCC800D4B99500E5DF
      D500FBFAF900FEFEFD0000000000000000000000000000000000D3D3F9000000
      DD002222B600000000000000000000000000000000005D5DEA000303E8002727
      EB0000000000000000000000000000000000000000000000000000000000EFEF
      FD000909E9000303E500ADADF400000000000000000000000000FDFDFE000505
      B6000A0AE400FDFDFE0000000000000000000000000000000000000000008E9E
      C7004487FF005191F900498BF7004D8DF7006294F50096B2F300F7F9FD00FBFB
      FE0085A6F200568DF5004889F700377FF700377EF7003F84F700528CF6006390
      F100E2E9FB00F7F8FD0084A5F2005288F400397EF7002572F6002A77F9002166
      ED00D2D5DD00000000000000000000000000000000000000000000000000F3F3
      F300D8D8D800E5E5E500F7F4F200FFFBF800FFFBF800F2EFED00EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00F9C89A00FEB06600FDAC5F00FDAD6000FBAD6100B4947500DBDADA00F8F8
      F800000000000000000000000000000000000000000000000000000000000000
      0000ECDCBE00F9E9D100FFF7EA00FFFBF200FFFEF600FFFEF600FFFEF600FFFE
      F600FFFEF600FFFEF600FFFEF600FFFEF600FFFEF600FDFCF500F7F5EB00EAE4
      D600D8CEBA00CABEA500C7BAA200CCBEA600D4C6AF00DDCDB600CFB38D00E5DF
      D500FAF9F800FEFEFE00000000000000000000000000000000009E9EF7000000
      D6006161B800000000000000000000000000000000001818D7000303F400E0E0
      FD00000000000000000000000000000000000000000000000000000000000000
      0000A0A0FA000000F0004F4FDA00000000000000000000000000000000002222
      A7000101E500E9E9FD000000000000000000000000000000000000000000FEFE
      FE006686CE004C8FFF005392F9004B8CF8004F8FF900538DF6006C94F0006B94
      F0004B87F600478AF8003F84F7004084F7003F83F7003A80F7003B82F7004585
      F7004D82F0005987EF004281F500387FF7002B76F600317BF800226EFD00A2B0
      CC0000000000000000000000000000000000000000000000000000000000F3F3
      F300D8D8D800E5E5E500F7F4F100FFFBF800FFFBF800F2EFED00EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00F9D2AE00FFC58D00FFC28800FDC08800B89B8000DBDADA00F8F8F8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ECDCBE00F9E9D300FFF7EB00FFFBF400FFFEF800FFFEF800FFFEF800FFFE
      F800FFFEF800FFFEF800FFFEF800FFFEF800FEFDF800FCFBF500F4F1E800E2DA
      CC00CCB58D00C8A36800B59D7500B8A68900C7B49900D0B58D00C8B39100F3F0
      EC00FCFBFA00FEFEFE0000000000000000000000000000000000A3A3FA000000
      DC005454AB000000000000000000000000006969CF000000EF008686FE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004040FF000000E100B2B2E3000000000000000000000000001818
      9A000101ED00EDEDFD0000000000000000000000000000000000000000000000
      0000F8F8F8006286D2004C90FF005695FA004F8FF8004F8FF9004889F7003F84
      F600498CF8004588F7004587F7004486F7004285F7004184F7003E83F7003C82
      F700377EF700357CF600397FF700357CF6003780FB002572FD0094A7CF000000
      000000000000000000000000000000000000000000000000000000000000F3F3
      F300D8D8D800E6E6E600F5F0ED00FFFBF800FFFBF800EFEAE600EBEBEB00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00F9DCC100FFD7B200FDD3AC00B6A18C00DCDBDB00F8F8F800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ECDBBE00F9E9D400FFF7EC00FFFBF500FFFDF900FFFDF900FFFDF900FFFD
      F900FFFDF900FFFDF900FFFDF900FFFDF900FEFDF900FCFAF500F3EFE700DED6
      C700D3B37E00F5CD9D00E4BF8700D5B27B00D6B07600C2A57400EAE5DD00F9F8
      F500FDFDFC000000000000000000000000000000000000000000E6E6FE000202
      F60005059E00C1C1DE00F9F9FB006F6FBB000F0FDC003E3EFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F9F9FF001C1CFF000D0DC600A2A2CF00FDFDFD009191C4000000
      B6001717FC000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC007F99CD003F84FF005798FF005594F9005090F8004F8F
      F8004D8DF8004C8CF700498AF700478AF7004688F7004587F7004386F7004184
      F7003F83F7003E83F7003F84F8003983FF003677EE00B0BCD200000000000000
      000000000000000000000000000000000000000000000000000000000000F4F4
      F400D9D9D900E9E9E900E5E2E100F4EFEB00F2EDE900E6E5E300EDEDED00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00F9DFC600FDD9B900B7A49100DBDADA00F8F8F8000000000000000000FEFE
      FE00FCFCFC00FEFEFE0000000000000000000000000000000000000000000000
      0000ECDBBC00F9E8D300FFF5EC00FFFAF400FFFCF700FFFCF800FFFCF800FFFC
      F800FFFCF800FFFCF800FFFCF800FFFCF800FEFCF800FCF9F500F4EFE700E0D8
      CB00DDBA7C00FEE6C200FEE7C400FDE4C000CAAB7500E6E0D700F5F3F000FDFC
      FC00000000000000000000000000000000000000000000000000000000006666
      FF000909F1001515B3003030AF003636E2003A3AFF00F4F4FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C9C9FF002F2FFF003434D2002B2BA9001414BF000707
      FB00AAAAFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C8D8005885DB004589FE005595FC005795
      FB005493F9005190F8004E8EF8004D8DF8004B8CF700498AF700488AF700478A
      F800468AFB004087FF003479F6006F95DA00E4E6EB0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DCDCDC00E4E4E400E9E9E900E6E6E600E7E7E700E9E9E900EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00F4DDC700B8A69500DBDBDB00F8F8F800000000000000000000000000FAFA
      FA00F5F5F500FCFCFC0000000000000000000000000000000000000000000000
      0000EBDABB00F9E5D000FFF2E700FFF6EE00FFF8F100FFF8F200FFF8F200FFF8
      F200FFF8F200FFF8F200FFF8F200FFF8F200FEF8F200FDF6EF00F6EEE500E7DC
      CE00E2BE8300FFE9CD00FDE9CD00D3B88800E2DBD100F4F2EE00FCFBFA00FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      00008989FF006161FF009696FF008484FF00EFEFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D1D1FF008080FF009393FF005B5BFF00B1B1
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C5DD006C99EB004986
      EF004387F9004C8DF8004F8FF8004F8FF8004D8DF800488AF7004287F9003980
      F8004883EA0080A1DA00D7DEEB00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00DEDEDE00D9D9D900D5D5D500D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300C1BAB200E1E1E100F9F9F90000000000000000000000000000000000F8F8
      F800F8F8F800FEFEFE0000000000000000000000000000000000000000000000
      0000EBDABB00F9E4CC00FFEFE100FFF2E700FFF4EA00FFF4EA00FFF4EA00FFF4
      EA00FFF4EA00FFF4EA00FFF4EA00FFF4EA00FFF4EA00FEF3E900FAEFE400F3E5
      D800DFBE8800FCE5CB00DDC39A00DFD7CA00F4F1EE00FCFBFA00FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DFE5
      F100AEC7EE0089B1F50074A5F80073A4F80072A3F80078A8FA0093B3E900BCCE
      ED00ECF0F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00FAFAFA00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F9F9F900FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F5EBDB00EBD8B900EDDBBD00EDDCBF00EEDDC200EEDEC300EEDEC300EEDE
      C300EEDEC300EEDEC300EEDEC300EEDEC300EDDDC300ECDBC000E9D9BC00E7D5
      B800D6BF9900D0B88E00DBD0BC00F6F5F100FCFBFA00FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00FEFDFD00FCFCFB00FDFCFB00FEFDFD00FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F5E00001F5E00001F5E00001F5E
      00001F5D0000205B0000205B0000215A0000215A0000205B0000205B00001F5D
      00001F5E00001F5E00001F5E00001F5E00000000000000000000000000000000
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
      000000000000000000001F5E00001F5E00001F5E00001F5D0000215A0000205B
      00001C620200166C0700137009000F760C0010760C0013700900176B07001D62
      0200205C0000205A00001F5D00001F5E00001F5E00001F5E0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000001F5E00001F5E00001F5E0000215A00001E60020012750D000A88
      19000D952500159C30001E9F380023A03B00219F39001B9D350013992C000B92
      22000A86170014730C001F5F0100215A00001F5E00001F5E00001F5E00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00FAFAFA00FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B7B7B7006D6D6D00323232004C4C4C00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000709D8E00056D
      480000624100ACBDB80000000000FBFBFB00FDFDFD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001F5E00001F5E0000205C0000205C000013760E000994210017A236002BA6
      450032A447002EA04200279C3B00259B3900249A3800259B39002A9D3D002C9E
      3F00249E3B00129B2E00088F1D0014740D00205C0000205C00001F5E00001F5E
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FBFBFB00E3E3E300C3C3C300BCBCBC00D9D9
      D900F8F8F8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C9C9C900717171004E4E4E00181818000C0C0C0030303000C7C7C7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD00FDFDFD00F7F7F700639081000A774F00107C
      5300006241009DB0AA00F7F7F700F1F1F100F7F7F700FBFBFB00FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F5E
      00001F5E0000205B00001D630400098D1B0010A5350027A74400239F3C001096
      2900028F1D00008D1800008C1700008C1600008C1700008C1700008C1700038E
      1C000F9327001F9A3500209D38000C9B2A000A8818001E620300205B00001F5E
      00001F5E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE0090909000AAAAAA00B7B7B7009393
      9300B5B5B500EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D90072727200585858001B1B1B001B1B1B0013131300040404001B1B1B00ACAC
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00FCFCFC00F3F4F3005E8D7E000B7C520016895B001281
      5600006241008BA19A00EDEDED00E7E7E700EDEDED00F4F4F400FAFAFA00FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F5E00001F5E
      0000215B00001B6706000699240017A93D001EA23C000895240000901A000091
      1C0000921E0000931F0000931F0000931F0000931E0000921E0000921E000091
      1D00008F1A00008D1900089222001A9A3300119C2F0006921F001C650500205B
      00001F5E00001F5E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00CDCDCD0098989800F0F0F000F8F8F800F7F7F700FFFF
      FF00B6B6B6009B9B9B00DFDFDF00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8E8E8007777
      770061616100212121001D1D1D001C1C1C00626262007C7C7C00272727000B0B
      0B008C8C8C00FAFAFA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00FEFEFE00F3F3F300548877000E835600198F5F00188D5F001689
      5B00006442006C8F8400E3E3E300DDDDDD00E4E4E400ECECEC00F3F3F300F9F9
      F900FDFDFD000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F5E0000205B
      00001C650500069D280016AB3E00119E310000931E0000952000009621000097
      2300009823000097220000951D0000951C0000951C0000941C00009621000096
      2200009521000094200000911D0000901C000F972B00109C2F00069521001D64
      0500205C00001F5E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAFAFA00C8C8C80099999900F8F8F800FCFCFC00F9F9F900F5F5F500F7F7
      F700FFFFFF00DCDCDC008E8E8E00C4C4C400F2F2F20000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F3007F7F7F006868
      680029292900202020001313130082828200FFFFFF00FFFFFF00E6E6E6004D4D
      4D00000000006C6C6C00EFEFEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F2F2F20052877600118759001D9663001B9362001B9363001A90
      600001674400447A6800D7D6D600D5D5D500DCDCDC00E4E4E400ECECEC00F3F3
      F300F9F9F900FDFDFD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F5E00001F5D00001F5E
      01000798240010AD3D000B9E2E000096200000992400009A2600009B2600009C
      2700009C2600059E2C0027AC48002BAD4B002BAD4C0026AB4700039D2900009A
      2500009A250000982400009723000095210000931D000A9728000A9D2D00098F
      1E00205D01001F5E00001F5E0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F900C8C8C8009D9D9D00FFFFFF00FFFFFF00FBFBFB00F6F5F500EFEDED00B7B6
      B600EFEEEE00FFFFFF00FCFCFC00A1A1A100A0A0A000E1E1E100FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFC00898989006C6C6C003131
      3100232323001C1C1C00575757009E9E9E00DFDFDF00FFFFFF00FFFFFF00F8F8
      F80073737300020202004C4C4C00DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F3004D857200148E5E00209C68001F9966001E9966001E986500239B
      6900096E4A0019674D00C2C4C300CFCECE00D3D3D300DBDBDB00E3E3E300ECEC
      EC00F3F3F300F9F9F900FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000001F5E00001F5E0000215900000F84
      180008B03A000AA1310000992400009C2700009E2900009F2A0000A02A0000A1
      2B00009C200060C57B00F9FDFA00FBFEFC00FBFEFC00F8FDFA0054BF6F00009A
      1F00009E2900009D2800009B2700009A2500009823000095200008982800049F
      2B00117F1400215A00001F5E0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900C3C3
      C3009E9E9E00FFFFFF00FFFFFF00FEFEFE00FBFAFA00E7E5E500ACABAB00DBDA
      DA00A7A6A600B2B1B100F9F9F900FFFFFF00CBCBCB008B8B8B00C5C5C500F2F2
      F200000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000989898006C6C6C003B3B3B002626
      26001F1F1F004F4F4F00CDCDCD00C5C5C50091919100C8C8C800FFFFFF00FFFF
      FF00FFFFFF009B9B9B001010100030303000C7C7C70000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E3E8
      E60045836E001892610023A16B00219E6900219E6900219E69001F9D680038AA
      7A0024846000005A3B0099A6A200CECCCD00CCCCCC00D2D2D200DBDBDB00E5E5
      E500EDEDED00F4F4F400F9F9F900FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000001F5E0000205C00001B68060004AB
      330009A93600009C2700009F290000A12C0000A32D0000A42E0000A52F0000A5
      2F0000A1230073CE8D00FFFFFF00FFFFFF00FFFFFF00FFFFFF0064C88000009F
      210000A32D0000A22C0000A02B00009E2800009D2800009A250000992300069B
      2900039E28001D660600205C00001F5E00000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900C2C2C2009F9F
      9F00FFFFFF00C0D1CB007FA3970060907F0058877700577B6E00B4C5BF00E4E4
      E400E3E3E300D2D1D100A3A2A200E8E7E700FFFFFF00F1F1F1009A9A9A009F9F
      9F00E1E1E100FBFBFB0000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A7006C6C6C0044444400292929002424
      240043434300C7C7C700D8D8D800D2D2D200CDCDCD009A9A9A00B2B2B200FCFC
      FC00FFFFFF00FFFFFF00C0C0C000262626001B1B1B00ACACAC00000000000000
      0000000000000000000000000000000000000000000000000000000000008BB7
      A900168C5D0026A86F0024A26C0024A36C0024A36C0024A36C0020A16A003BAF
      7D0052A78400005C3C004E7E6E00CAC8C900C6C6C600CBCBCB00D5D5D500DFDF
      DF00E8E8E800EFEFEF00F5F5F500F9F9F900FDFDFD0000000000000000000000
      0000000000000000000000000000000000001F5E0000215900000E8B1D0004B4
      3B0002A22D0000A22B0000A42E0000A6300000A7310000A8320000A9330000AA
      320000A6280070D08D00FFFFFF00FFFFFF00FFFFFF00FFFFFF0061CA800000A4
      260000A7310000A6300000A52E0000A32D0000A12B00009F2900009C2700029B
      270002A22B0010841800215900001F5E00000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700BFBFBF009E9E9E00FEFE
      FE0099B6AC002F715A00045D40000761430007614300045C400027695200809D
      9300DBDBDB00E9E9E900DDDDDD009C9B9B00D2D0D000F0F0F000FAFBFB00C0C0
      C000898A8A00C5C5C500F5F5F500000000000000000000000000000000000000
      00000000000000000000B9B9B9006E6E6E004E4E4E002C2C2C002B2B2B003C3C
      3C00BFBFBF00E1E1E100D6D6D600D4D4D400D3D3D300D4D4D400A9A9A900A0A0
      A000F1F1F100FFFFFF00FFFFFF00DEDEDE00444444000B0B0B008C8C8C00FAFA
      FA000000000000000000000000000000000000000000000000000000000070A5
      94001E97640028AA710027A8700028A8700028A8700028A8700026A76F002AA9
      72007BC9A70021775800045C3D00A3ACA900C8C7C700C6C6C600D0D0D000D9D9
      D900E3E3E300EBEBEB00F1F1F100FBFBFB00F9F9F900F1F1F100000000000000
      0000000000000000000000000000000000001F5D00001E61020005AA320003AD
      360000A42D0000A7300000A9320000AA330000AC350000AD360000AE370000AF
      370000AB2B0070D38F00FFFFFF00FFFFFF00FFFFFF00FFFFFF0061CD820000A9
      2B0000AC350000AB340000A9320000A8310000A62E0000A42D0000A12B00009E
      2900019E2900069C26001F6002001F5D00000000000000000000000000000000
      0000000000000000000000000000F8F8F800BBBBBB00A3A3A300F5F8F7005288
      750006644400217B5C00378A6C003D8D70003F8D71003D8A6F00287B5F000863
      4400487E6C00DCDFDE00F4F4F400F2F2F200A2A2A20097959500D9D7D700EEED
      ED00DFDFDF0095959500C4C4C400000000000000000000000000000000000000
      000000000000CCCCCC006F6F6F0057575700303030003131310034343400B6B6
      B600EBEBEB00DDDDDD00DBDBDB00D8D8D800D6D6D600D4D4D400D7D7D700B9B9
      B90098989800E0E0E000FFFFFF00FFFFFF00F2F2F20069696900010101006C6C
      6C00EFEFEF0000000000000000000000000000000000000000000000000070A5
      9300269B6A0034B07A0034AE790035AF790036AF7A0035AF790034AE79002BAA
      73006CC79E0083BDA70000613D0036735F00C4C4C400C8C8C800CECECE00D9D9
      D900E1E1E100E8E8E800F8F8F800F2F2F200558A79006C978800000000000000
      000000000000000000000000000000000000205A000017740E0001B83C0001A9
      330000A8310000AC330000AD360000AE360000AF360000B0370000B2380000B3
      380000AF2C006ED59000FFFFFF00FFFFFF00FFFFFF00FFFFFF005FCF830000AD
      2B0000B0360000AE350000AC330000AA320000A9320000A8310000A62F0000A2
      2C0000A02A0001A52C0019700C00205B00000000000000000000000000000000
      00000000000000000000F7F7F700BBBBBB00A3A3A300FDFEFD0067978700076C
      48001D855D0020875F001B825B001F845E001E815C00177B56001F7D5B00237C
      5D000A6747005F907F00EBECEC00F9F9F900FEFFFF00E1E1E10092929200BCB9
      B900CDC9C900D3D2D2009B9B9B00000000000000000000000000000000000000
      0000DCDCDC00727272005F5F5F0034343400353535003232320050505000E7E7
      E700E9E9E900E1E1E100DFDFDF00DDDDDD00DBDBDB00D8D8D800D6D6D600D8D8
      D800C9C9C90098989800CBCBCB00FFFFFF00FFFFFF00FFFFFF00888888000E0E
      0E004C4C4C00DEDEDE00000000000000000000000000000000000000000085B1
      A3002C9A6D0044B8850043B5830044B6830044B6840044B6830043B583003FB4
      800040B48100BBE6D3005B9F860000613B00698C8000DBDADA00D4D4D400D9D9
      D900E2E2E200F6F6F600D5DAD80036786300005F3E00387D6600000000000000
      0000000000000000000000000000000000002158000011881C0000BB3E0000AB
      330000AD360000B0380000B1390000B43B000CB846000BBA46000BBB47000BBC
      48000BB83D0076DA9900FFFFFF00FFFFFF00FFFFFF00FFFFFF0068D48D000BB6
      3C000BB945000BB744000BB542000CB4410000AE360000AB340000AA320000A7
      300000A32D0000A82E0013831700215900000000000000000000000000000000
      000000000000F6F6F600B6B6B600A3A3A300FFFFFF00B7CEC600096B4800178A
      5D0016895B000B83530046A17D00EEF6F300EEF6F300499D7D00017448000D76
      4F000E744F0005634200ADC5BD00F4F4F400FBFBFB00FFFFFF00F6F7F700A2A2
      A200B1AFAF00BEBEBE00A8A8A80000000000000000000000000000000000EBEB
      EB0078787800666666003A3A3A00373737003737370039393900404040008E8E
      8E00ECECEC00ECECEC00E4E4E400E2E2E200DFDFDF00DDDDDD00DBDBDB00D8D8
      D800D9D9D900D4D4D400A1A1A100B6B6B600FDFDFD00FFFFFF00F8F8F8005A5A
      5A001919190032323200DADADA0000000000000000000000000000000000B3CE
      C400278E660053C1900050BC8C0051BC8D0052BD8D0051BC8D0050BC8C004FBB
      8B0045B7850072C9A300DAEFE600338B6A0000633E008DA79E00FCFCFC00F5F5
      F50000000000B6C3BE0012664A00016241001B885D001B735400E8F0ED000000
      000000000000000000000000000000000000205900000D9A280007BE450000AE
      360000B1390000B33B0000B333006FD79200E2F7E900E1F7E900E1F7E900E1F7
      E900E0F7E800EEFBF300FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECFAF100E0F6
      E700E1F7E900E1F7E800E1F7E800E2F6E80069D28B0000AC2E0000AE350000AA
      330000A8310006AC36000F8D1F00215900000000000000000000000000000000
      0000F6F6F600B4B4B400AAAAAA00FFFFFF00FFFFFF006FA39200188B5D001C95
      6300128F5C00078A540043A67E00FFFFFF00FFFFFF004BA58100007B4900067B
      4E000D7A50000B724C00689D8C00F7F7F700FCFCFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C500D3D3D300000000000000000000000000F5F5F5008080
      80006A6A6A0040404000383838004141410044444400373737003E3E3E003E3E
      3E0076767600DFDFDF00F1F1F100E6E6E600E4E4E400E2E2E200DFDFDF00DDDD
      DD00DBDBDB00DADADA00DBDBDB00B0B0B000A6A6A600F5F5F500FAFAFA005A5A
      5A00333333002424240077777700F0F0F000000000000000000000000000EAF1
      EF003C8F71005DC395005EC396005FC396005FC396005FC396005EC296005CC2
      94005AC193004EBB8B009DDCC000C1E2D40020845E000067410087ADA1000000
      00008CB1A400025F3F00066B47001B96620040B28000267E5E00C2D7CF000000
      000000000000000000000000000000000000205A00000CA6320013C350000DB6
      430000B63C0000B83E0000B6350094E3B000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0095E1AE0000AF300000B1380000AE
      36000EB03F0012B141000D9A2900205A0000000000000000000000000000F6F6
      F600B4B4B400AAAAAA00FFFFFF00FFFFFF00FFFFFF0066A99000209D6800249F
      6B005FB9930062B9940087C9AE00FFFFFF00FFFFFF008CC8AF005CAF8D0061AF
      9000248D64000E7D52005F9E8800FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D0D0D000D3D3D300000000000000000000000000FDFDFD008B8B8B006C6C
      6C004747470039393900515151007B7B7B0080808000616161003A3A3A003E3E
      3E004040400061616100CACACA00F5F5F500E9E9E900E6E6E600E4E4E400E2E2
      E200DFDFDF00DDDDDD00DBDBDB00DEDEDE00C2C2C200ABABAB00848484003333
      3300373737003E3E3E008D8D8D00F4F4F4000000000000000000000000000000
      000084B5A40052B289006FCDA2006BC99F006CC99F006BC99F006AC99E0069C8
      9D0066C79C0062C599005BC19400A6E0C600A1D5BF001E855D00026C46002578
      5B0002664300168158002BA7710024A86F0041B382004D9B7D0091B6A9000000
      0000000000000000000000000000000000001E5A000012AB39001AC8580019BD
      510010BE4D0001BC430000BA38008FE3AD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008FE0AB0000B3320002B53D0012B7
      47001AB74B0019B74A0012A131001F5B00000000000000000000F5F5F500B4B4
      B400A8A8A800FFFFFF00ECECEC0084848400828282003F886B0022A56C0030AA
      7500F5FCF900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004EA883000C83540065A88F00FDFDFD00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00D5D5D500000000000000000000000000FCFCFC009B9B9B006C6C6C004E4E
      4E003D3D3D00515151007C7C7C0074747400686868007D7D7D006E6E6E004040
      40003E3E3E004444440052525200AFAFAF00F5F5F500EEEEEE00E8E8E800E6E6
      E600E4E4E400E2E2E200DFDFDF00DEDEDE00E7E7E700898989002F2F2F003A3A
      3A003F3F3F007979790000000000000000000000000000000000000000000000
      0000E1EDE9003B9873007CD3AB0078CFA80078CFA80078CFA80077CFA70075CE
      A60073CDA40070CBA2006AC99E0066C69B0097DABC0088CDAF00248C63000A76
      4D002C986C0042B7840039B27D002CAA740036B07B0076B99E005D9784000000
      0000000000000000000000000000000000001E59000016AB3B0022CF62001CC1
      55001EC55A0019C6580002C2440094E6B300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0095E4B10002BB3E0019C053001EBE
      54001CBB4F0022BE5400169C2F001F59000000000000F6F6F600B2B2B200AAAA
      AA00FFFFFF00E7E7E70079797900BEBEBE00BFBFBF0062A3880035B07A003DB2
      8000BAE1D100D8EDE400DAEEE600FEFFFE00FFFFFF00DDF0E800D8EEE500D4EC
      E20041A77C00148E5C0076B69D00FFFFFF00FFFFFF00FFFFFF00CECECE00D5D5
      D50000000000000000000000000000000000D2D2D2006E6E6E00565656004040
      4000505050007B7B7B00787878006A6A6A0093939300C7C7C700BFBFBF008484
      8400494949003E3E3E00474747004C4C4C0093939300EEEEEE00F4F4F400EBEB
      EB00E9E9E900E6E6E600E5E5E500ECECEC009F9F9F003A3A3A003C3C3C004141
      41006E6E6E00FAFAFA0000000000000000000000000000000000000000000000
      0000000000007DB5A10066BE98008ADAB50083D5B00082D5B00081D4AF0080D3
      AE007ED2AC007BD1AA0077CFA70072CCA4006BC99F007ED2AC006EC69F0049B1
      840057C192004DBB8A0043B583003AB17D002FAD760091CEB50043877000FEFE
      FE00000000000000000000000000000000001F570000189D31002DD86F0020C6
      5B0021CA5F0022CC620016CC5B007AE3A200DBF8E700D8F7E400D3F7E100D3F7
      E100D3F7E000E7FBEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4FAED00D3F6
      E000D3F6E100D3F6E100D8F7E400DBF7E50075DE9C0016C5560022C55B0021C3
      580020BF55002EC761001792270020570000FBFBFB00BCBCBC00ABABAB00FFFF
      FF00E9E9E90076767600B2B2B200B0B0B000B6B6B6008EAEA1004AB5860054BF
      90004FB98B0058BD91006BC49D00FCFEFD00FFFFFF0062BF970038AD7B002BA6
      7100209E690020986600BCDDD000FFFFFF00FFFFFF00CCCCCC00D5D5D5000000
      000000000000000000000000000000000000D9D9D900626262004A4A4A005151
      51007A7A7A007C7C7C006E6E6E0092929200D0D0D000CFCFCF00D1D1D100CCCC
      CC00999999005858580040404000484848004C4C4C007B7B7B00DFDFDF00F9F9
      F900EDEDED00EBEBEB00F3F3F300AFAFAF00404040003E3E3E00444444006868
      6800F2F2F2000000000000000000000000000000000000000000000000000000
      000000000000F0F7F400479F7C008ED8B60099DFBF0093DCBA0091DBB9008EDA
      B7008BD8B50088D7B30083D5AF007ED2AC0078CFA7006FCCA2006DCAA00068C9
      9E005EC3960056BE91004EBB8B0045B6840032AE770091D4B700488B7400E2EC
      E8000000000000000000000000000000000020580000158A1F0038E07A0027CC
      640025CE640026D1670026D3690024D469002AD76F0026D86E001ED8690015D8
      65000AD5580076E9A600FFFFFF00FFFFFF00FFFFFF00FFFFFF0068E59B000AD2
      560016D462001ED3660027D36A0029D26A0023CE630026CC630026C9600025C6
      5E0029C35D0036CD6B001582180000000000F2F2F200A4A4A400FFFFFF00E9E9
      E90073737300B0B0B000AFAFAF00B6B6B600BBBBBB00BEBFBE0070B296006FCB
      A2006DCAA00062C6990080D1AD00FFFFFF00FFFFFF0073C9A30036B07B0030AC
      760027A76F0079C2A300FDFEFE00FFFFFF00CBCBCB00DCDCDC00000000000000
      00000000000000000000000000000000000000000000BBBBBB00555555006F6F
      6F00818181007171710092929200CFCFCF00CECECE00CCCCCC00CCCCCC00CECE
      CE00D1D1D100ACACAC006969690045454500474747004F4F4F0069696900CACA
      CA00FDFDFD00FDFDFD00BCBCBC0047474700404040004747470062626200E8E8
      E800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C9E2D80049A58000A9E5C900AEE8CC00A9E4C800A8E4
      C800A6E3C600A4E1C5009FE0C2009ADDBF0093DABA008BD7B40081D2AD0076CE
      A6006BC89E0060C4970056BF90004DBA8A003CB37E0078CDA70063A18B00BAD1
      C8000000000000000000000000000000000000000000156F080037DC76003AD6
      760027D168002AD56D002AD76F0029D8700027DA700028DC720029DE740029DF
      75001ADE6D0085EEB100FFFFFF00FFFFFF00FFFFFF00FFFFFF0078EAA8001BDB
      6B0029DB720029D9700027D76E0027D46B0029D26B002AD069002ACD660026C9
      61003DCC6F0033CA6500166B060000000000F1F1F100CFCFCF00F4F4F4006F6F
      6F00ACACAC00ADADAD00B4B4B400B9B9B900BDBDBD00C2C2C200C1C6C40074BE
      9E0082D4AF0084D6B0007ED0AB008DCCB1008FCDB30069C59C0056BF900047B7
      86006FC49F00F6FBF900FFFFFF00CCCCCC00DDDDDD0000000000000000000000
      0000000000000000000000000000000000000000000000000000DDDDDD007676
      76008181810096969600CDCDCD00CECECE00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00D1D1D100BEBEBE00828282004E4E4E0047474700515151006161
      6100A1A1A1009F9F9F004F4F4F00434343004A4A4A005A5A5A00DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BEDDD1004DA98300ACE4CA00BDEED700B4E9
      D000B4E8CF00B2E8CE00AFE6CD00ACE5CB00A8E3C800A4E0C5009DDDC10095DA
      BB008BD6B4007FD0AB006FC9A1005EC296004BB989005DC3960073B59C0089B2
      A300000000000000000000000000000000001F5D00001B5B000022C0530057E9
      93002CD46D002DD872002EDB74002EDD76002EDF78002DE179002DE27A002DE4
      7B0020E474008AF1B600FFFFFF00FFFFFF00FFFFFF00FFFFFF007DEDAD0022DF
      72002EE078002DDE76002EDC75002ED873002ED770002ED46E002DD06B002DCD
      680058DA87001EB144001C5A00001F5E000000000000000000009B9B9B00A7A7
      A700ABABAB00B2B2B200B7B7B700BCBCBC00C0C0C000C6C6C600CBCBCB00CECF
      CF009DC9B6008ED3B3008BD8B50083D6B0007CD2AB0075CEA5007ECEAA00B3E0
      CC00FEFFFE00FFFFFF00CDCDCD00DDDDDD000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F7009D9D9D00CECECE00D4D4D400CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00D1D1D100BEBEBE00969696008D8D8D005A5A5A00494949005353
      53005353530049494900484848004C4C4C005A5A5A00D4D4D400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D4E9E10052AA8600A0DCC100C8F2
      DE00BEEDD700BDECD600BAEBD400B7E9D200B3E7CF00AEE5CC00A9E2C800A2DF
      C3009BDCBE0093D9B9008AD4B3007ECFAB006EC8A00062C499007AC3A4005997
      8300000000000000000000000000000000000000000000000000128A1D0054F1
      97004DE088002CDB740032DF790032E07B0031E37D0031E57E0033E7810037E8
      840030E7800093F3BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080F0B10026E4
      780031E47D0031E27C0032DF790032DD780032DA750032D773002DD36D0052D8
      84004FDE850012831700000000000000000000000000CECECE0095959500A6A6
      A600AEAEAE00B4B4B400B9B9B900BEBEBE00C3C3C300C8C8C800CDCDCD00D2D2
      D200D7D7D700BDD6CB00ACD8C400A9DCC400A8DCC400B1DECA00D3ECE100FFFF
      FF00FFFFFF00CDCDCD00DEDEDE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BCBCBC00C2C2C200D6D6D600CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00D0D0D000C3C3C300757575005A5A5A0084848400A2A2A200616161004B4B
      4B004D4D4D004D4D4D004F4F4F0058585800C9C9C90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F6FAF90058AE8B0097D6
      BA00D0F5E300C7F0DC00C4EFDB00C1EED900BEECD600B9EAD300B3E7CF00ADE4
      CB00A6E0C6009EDDC00095D9BA008BD4B3007FCFAC0073CAA30080CDAB003D8B
      7000EAF1EE000000000000000000000000000000000000000000195F000025CD
      5E0076F6AF0041E0830031E17C0035E5810036E683003CE8870045EA8D004DEB
      920049E98F00A2F4C600FFFFFF00FFFFFF00FFFFFF00FFFFFF008EF2BA0034E7
      820037E7840035E5810035E37F0036E07D0036DD7A0031D9750046DA800074E7
      A10020BD4F001A5D00001F5D0000000000000000000000000000CECECE00BBBB
      BB00BCBCBC00B5B5B500BCBCBC00C1C1C100C6C6C600CBCBCB00D0D0D000D5D5
      D500DADADA00DFDFDF00E4E4E400E9E9E900EEEEEE00F7F7F700FFFFFF00FFFF
      FF00CECECE00E5E5E50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D8D8D800B1B1B100D8D8D800CECECE00CCCCCC00CFCF
      CF00C8C8C80081818100666666005F5F5F00AAAAAA00CACACA005C5C5C005050
      5000515151005252520056565600BBBBBB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C1E3D4003BA6790083D0
      AE00D7F7E800D0F4E200CDF2E000CAF1DF00C7EFDC00C2EED900BDEBD600B7E8
      D100B0E5CD00A8E2C8009FDEC10095D9BB008BD4B3007DCEAA007DCFAA00338E
      6B00C5DAD300000000000000000000000000000000000000000000000000117F
      140049F2920080F4B40042E5880037E7840045E98D0051EB94005BEC9A0063EC
      9F0062EC9E00A0F4C500F5FEF900F5FEF900F5FEF900F4FEF8008FF2BA004CEA
      910048EA8E003DE8880039E6840039E3820034E07C0046DF850082E9AA0042DF
      7E0012780F000000000000000000000000000000000000000000000000000000
      0000C6C6C600D3D3D300C8C8C800C3C3C300C9C9C900CECECE00D3D3D300D8D8
      D800DDDDDD00E2E2E200E6E6E600ECECEC00F5F5F500FEFEFE00FFFFFF00CECE
      CE00E5E5E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F2F2F200A9A9A900D3D3D300D3D3D300C5C5
      C5008C8C8C007171710063636300A1A1A100DADADA00898989004F4F4F005454
      54005555550059595900B0B0B000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094D0B70042B08000A0E0C200D8F8
      E800D9F8E900D7F7E700D5F6E600D2F4E400CFF2E200CBF1DF00C6EEDB00C0EC
      D800BAE9D300B2E6CE00A9E2C800A0DEC20095D9BA0089D3B20081D2AE0043A1
      7B0093BEAE0000000000000000000000000000000000000000001F5E00000000
      000012A2310063FFAB008AF7BB005AEB990053EB950063ED9F006EEEA70077EF
      AC007DF0AF0082F1B2008DF2B8008CF2B80089F1B60083F0B20071EEA80066ED
      A1005CEC9A004EEB920040E8890038E5820052E691008BEDB3005CEE98001199
      2900000000001F5E000000000000000000000000000000000000000000000000
      000000000000D2D2D200C6C6C600D9D9D900D4D4D400D0D0D000D5D5D500DBDB
      DB00E0E0E000E4E4E400EAEAEA00F3F3F300FDFDFD00FFFFFF00D1D1D100E6E6
      E600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4B4B400C5C5C500BEBE
      BE00686868006464640098989800DADADA009393930052525200575757005757
      57005D5D5D00A4A4A40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5D9C30066C49B00CAF3DF00EAFFF400E3FC
      EF00DFFAED00DEF9EC00DCF8EA00D9F7E800D6F5E600D3F4E400CEF2E000C8EF
      DD00C2ECD800BBE9D400B2E6CE00A9E2C8009FDDC10093D7B9008AD5B30061B8
      930074AD99000000000000000000000000000000000000000000000000000000
      00001B59000015B6430073FFB700A9FBCF0088F1B60076EFAB007EF0AF0089F1
      B60092F2BC0097F3BF0097F3BF0095F3BE0091F2BB008AF1B70083F0B30078F0
      AC006AEEA3005AEC9A0054EB96006FEEA60097F3BE0063F39F0012A836001C59
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D1D1D100C7C7C700E2E2E200E1E1E100DEDE
      DE00E2E2E200E7E7E700F1F1F100FCFCFC00FFFFFF00D4D4D400E6E6E6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE00B2B2
      B200BDBDBD009B9B9B00D7D7D7009B9B9B0056565600595959005A5A5A006060
      6000999999000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EC59F00B7EAD200DEF9EC00DFF9EC00E6FC
      F100EBFFF500ECFFF500EDFFF500ECFFF500E8FDF200E2FAEE00DDF8EB00D6F5
      E600CEF1E000C5EDDB00BCEAD500B2E5CE00A7E0C7009CDBBF0098DCBD005EB3
      8F008DBDAB000000000000000000000000000000000000000000000000000000
      0000000000001A5B000016AD3C0071FEB200C0FFE000BAF8D500A7F4C800A1F4
      C500A4F4C700A9F5CA00ABF5CC00AAF5CB00A5F4C8009DF4C20092F2BC0088F1
      B50084F0B3008DF1B900A0F5C5009BFAC50054F2970012A535001C5900000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1D1D100C8C8C800EAEA
      EA00F0F0F000F1F1F100FDFDFD00FFFFFF00D7D7D700E6E6E600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECEC
      EC00A6A6A600D3D3D3009E9E9E005A5A5A005D5D5D005E5E5E00646464009191
      9100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B9E3D00095D4B80088CFB0007DCBA90078C8
      A50075C8A40078CAA6007ECCAA0088D0AF0095D5B900A3DBC200ADE0C900B5E4
      CF00BCE8D400C0E9D600BEEAD600BCE9D400B6E7D000ABE3C9008FD4B500439B
      7800D8E8E2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000119023004EE88C00B0FFDB00DAFFEE00D9FC
      E900D1FAE300CEF9E100CDF9E000CAF8DE00C5F8DB00C1F7D900BDF7D600BBF8
      D500B8FAD500A9FED0007BFFB70033E07600118B1E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D1D1
      D100CDCDCD00FCFCFC00FFFFFF00C9C9C900ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A3A3A3005C5C5C0063636300646464006464640089898900FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFDFC00F3FAF700E7F5EF00D8EEE400C8E7DA00B7DFCE00A3D6C00093CE
      B50082C5A90074BEA0006AB8980062B3930059AF8C0053AB87005CAA8B00CBE2
      D900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000116A04001CAF420060EB9900AAFF
      D500D3FFEE00E1FFF300E3FFF200E0FFF000D8FFEC00CCFFE500B7FFDC0095FF
      CC006CFFB1003AE67F0016AA3B00156603000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900C9C9C900CACACA00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C3C3C300A0A0A000A9A9A900C2C2C200F3F3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000116802001593
      27002FC05A004EDD820061F09D0068F1A10061F19D004FF0920037DC750020BE
      5000139024001566030000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000145E000011680000126801001268020013680100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
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
      00000000000000000000000000000000FFFFFFFFFFFFFFFFE0000001FFFFFFFF
      FFFFFFFFFFFC3FFFE0000001F000000FFFC003FFFFE007FFE0000001F000000F
      E0000007FF0001FFE0000001F000000F00000000FE00007FE0000001F000000F
      00000000F800003FE0000000F000000F00000000F000001FE0000000F000000F
      C0080107F000000FE0000000F000000FFF87E1FFE0000007E0000000F000000F
      FF87C3FFC0000003E0000000F000000FFFC3C3FFC0000003E0000000F000000F
      FFC187FF80000003E0000000F000000FFFE107FF80000001E0000000F000000F
      FFF00FFF80000001E0000000F000000FFFF00FFF80000001E0000000F000000F
      FFF81FFF80000001E0000000F000000FFFF83FFF80000001E0000000F000000F
      FFF83FFF80000001E0000001F000000FFFF01FFF80000001E0000001F000000F
      FFF00FFF80000001E0000001F000000FF861863F80000001E0000001F000000F
      F003800F80000003E0000001F0000007E003C007C0000003E0000003F0000003
      E307E1C7C0000003E0000007F0000003C78FE1C3E0000007E000000FF0000003
      C78FF1E3E000000FE000001FF0000003C71FF8E3F000001FE000003FF0000007
      C03FF807F800003FE0000063F000000FE03FFC07FE00007FE00000E3F000000F
      F07FFE0FFF8001FFE00001E3F000001FFFFFFFFFFFE007FFF00003FFF000003F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFE07FFFFFFFFFFFFFFFFFFF0000FFFFFFFFFF
      FFFCFFFFFFFFFFFFFC00003FFFFFFFFFFFFC7FFFFFE3FFFFF800001FFFFF8FFF
      FFF83FFFFFC27FFFF000000FFFFE07FFFFF01FFFFC001FFFE0000007FFFC03FF
      FFE00FFFF8000FFFC0000003FFF800FFFFC003FFF00007FFC0000003FFF0007F
      FF8001FFF80003FF80000001FFE0001FFF0000FFF00001FF00000001FFC0000F
      FF00007FE00000FF00000000FF800003FE00003FE000007F00000000FF000001
      FC00000FE000003F00000000FE000001F8000007E000003F00000000FC000001
      F0000003E000003F00000000F8000001E0000001E000081F00000000F0000001
      C0000000E000101F00000000E000000380000000F000001F00000000C0000007
      00000003F000001F000000008000000F00000003F800000F000000000000001F
      00000007F800000F000000010000003F8000000FFC00000F800000010000007F
      C000001FFE00000F00000000C00000FFE000003FFF00000FC0000003800001FF
      F800007FFF800007C0000001C00003FFFC0000FFFF800007E0000007F00007FF
      FE0001FFFF000007D000000BF8000FFFFF8003FFFE000007F000000FFE001FFF
      FFC007FFFE000007F800001FFF803FFFFFE00FFFFE000007FE00007FFFE07FFF
      FFF80FFFFFF0000FFF0000FFFFF0FFFFFFFC1FFFFFFFFFFFFFC003FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFF83FFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
