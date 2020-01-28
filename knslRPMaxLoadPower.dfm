object rpMaxPowerLoad: TrpMaxPowerLoad
  Left = 380
  Top = 173
  Width = 828
  Height = 544
  BorderIcons = [biSystemMenu]
  Caption = 'Проверка нагрузки'
  Color = clBtnFace
  Constraints.MaxHeight = 544
  Constraints.MaxWidth = 828
  Constraints.MinHeight = 544
  Constraints.MinWidth = 828
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnResize = OnFormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSplitter1: TAdvSplitter
    Left = 0
    Top = 289
    Width = 820
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = clWhite
    Appearance.ColorTo = clSilver
    Appearance.ColorHot = clWhite
    Appearance.ColorHotTo = clGray
    GripStyle = sgDots
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 820
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 13627626
    TabOrder = 0
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 13037543
    Caption.ColorTo = 9747893
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
    ColorTo = 9224369
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 8433825
    StatusBar.ColorTo = 13886691
    StatusBar.GradientDirection = gdVertical
    Styler = TL5Config.AdvPanelStyler1
    FullHeight = 0
    object lbGenSettings: TLabel
      Left = 342
      Top = 20
      Width = 191
      Height = 21
      Anchors = [akLeft]
      Caption = 'Вычисление максимума'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 6
      Top = 7
      Width = 139
      Height = 14
      Anchors = [akLeft]
      Caption = 'ООО Автоматизация 2000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 715
      Top = 27
      Width = 96
      Height = 14
      Anchors = [akLeft]
      Caption = 'http://www.a2000.by'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 488
    Width = 820
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Color = 13627626
    TabOrder = 1
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 13037543
    Caption.ColorTo = 9747893
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
    ColorTo = 9224369
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 8433825
    StatusBar.ColorTo = 13886691
    StatusBar.GradientDirection = gdVertical
    Styler = TL5Config.AdvPanelStyler1
    FullHeight = 0
    object Label6: TLabel
      Left = 677
      Top = 6
      Width = 139
      Height = 14
      Anchors = [akLeft]
      Caption = 'ООО Автоматизация 2000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 5
      Width = 150
      Height = 15
      Min = 0
      Max = 100
      TabOrder = 0
      Visible = False
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 292
    Width = 820
    Height = 196
    Align = alClient
    BevelOuter = bvNone
    Color = 13627626
    TabOrder = 2
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 13037543
    Caption.ColorTo = 9747893
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
    ColorTo = 9224369
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 8433825
    StatusBar.ColorTo = 13886691
    StatusBar.GradientDirection = gdVertical
    Styler = TL5Config.AdvPanelStyler1
    FullHeight = 0
    object AdvStringGrid2: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 820
      Height = 193
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
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      GridLineColor = clGray
      OnGetCellColor = OnGetCellColorEvent
      ActiveCellFont.Charset = RUSSIAN_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Times New Roman'
      ActiveCellFont.Style = [fsBold]
      Bands.Active = True
      Bands.PrimaryColor = 14811105
      CellNode.ShowTree = False
      ControlLook.ControlStyle = csClassic
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
      SelectionColor = clAqua
      SelectionTextColor = clHighlightText
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
  object AdvPanel4: TAdvPanel
    Left = 0
    Top = 265
    Width = 820
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Color = 13627626
    TabOrder = 3
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 13037543
    Caption.ColorTo = 9747893
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
    ColorTo = 9224369
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 8433825
    StatusBar.ColorTo = 13886691
    StatusBar.GradientDirection = gdVertical
    Styler = TL5Config.AdvPanelStyler1
    FullHeight = 0
    object CheckBox1: TCheckBox
      Left = 65
      Top = 4
      Width = 57
      Height = 17
      Caption = 'Сумма'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cbGroup: TComboBox
      Left = 124
      Top = 1
      Width = 157
      Height = 23
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 1
      OnChange = cbGroupChange
      Items.Strings = (
        'Выборка по группам '
        'Выборка по точкам учета')
    end
    object cbTariff: TComboBox
      Left = 282
      Top = 1
      Width = 182
      Height = 23
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 2
    end
    object dtDate: TDateTimePicker
      Left = 466
      Top = 1
      Width = 154
      Height = 23
      CalAlignment = dtaLeft
      Date = 40433.7998473611
      Time = 40433.7998473611
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 3
    end
    object cbKindEnerg: TComboBox
      Left = 623
      Top = 1
      Width = 153
      Height = 23
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 4
      OnChange = cbKindEnergChange
      Items.Strings = (
        'Активная принимаемая'
        'Активная выдаваемая'
        'Реактивная принимаемая'
        'Реактивная выдаваемая')
    end
  end
  object AdvPanel5: TAdvPanel
    Left = 0
    Top = 81
    Width = 820
    Height = 184
    Align = alTop
    BevelOuter = bvNone
    Color = 13627626
    TabOrder = 4
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 13037543
    Caption.ColorTo = 9747893
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
    ColorTo = 9224369
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 8433825
    StatusBar.ColorTo = 13886691
    StatusBar.GradientDirection = gdVertical
    Styler = TL5Config.AdvPanelStyler1
    FullHeight = 0
    object AdvStringGrid1: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 820
      Height = 172
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
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      GridLineColor = clGray
      OnGetCellColor = OnGetCellColorEvent
      OnDblClickCell = AdvStringGrid1DblClickCell
      ActiveCellFont.Charset = RUSSIAN_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Times New Roman'
      ActiveCellFont.Style = [fsBold]
      Bands.Active = True
      Bands.PrimaryColor = 14811105
      CellNode.ShowTree = False
      ControlLook.ControlStyle = csClassic
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
      SelectionColor = clAqua
      SelectionTextColor = clHighlightText
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
  object AdvPanel6: TAdvPanel
    Left = 0
    Top = 41
    Width = 820
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Color = 13627626
    TabOrder = 5
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 13037543
    Caption.ColorTo = 9747893
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
    ColorTo = 9224369
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 8433825
    StatusBar.ColorTo = 13886691
    StatusBar.GradientDirection = gdVertical
    Styler = TL5Config.AdvPanelStyler1
    FullHeight = 0
    object AdvToolBar1: TAdvToolBar
      Left = 0
      Top = 0
      Width = 143
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
      ToolBarStyler = TL5Config.AdvToolBarOfficeStyler1
      ParentStyler = False
      Images = ImageList1
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object AdvToolBarButton1: TAdvToolBarButton
        Left = 9
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Создать отчет'
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
        OnClick = Button1Click
      end
      object AdvToolBarButton2: TAdvToolBarButton
        Left = 49
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Удалить записи'
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
        OnClick = Button2Click
      end
      object AdvToolBarButton3: TAdvToolBarButton
        Left = 89
        Top = 2
        Width = 40
        Height = 40
        Hint = 'Сфрмировать в exel'
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
        OnClick = ToolButtonOnXLReport
      end
    end
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frReport1GetValue
    OnManualBuild = frReport1ManualBuild
    Left = 320
    Top = 400
    ReportForm = {
      17000000B10F000017000000000800646F50444620763700FF09000000340800
      009A0B000048000000240000002400000024000000000000FFFF000000000000
      000002000B00506167654865616465723100000000000C000000F00200008200
      00003000020001000000000000000000FFFFFF1F000000000000000000000000
      00FFFF02000D004D6173746572486561646572310000000000F0000000F00200
      00360000003000040001000000000000000000FFFFFF1F000000000000000000
      00000000FFFF02000B004D6173746572446174613100000000002E010000F002
      0000140000003000050001000000000000000000FFFFFF1F0000000001003100
      000000000000FFFF02000D004D61737465724865616465723200000000005401
      0000F0020000260000003000040001000000000000000000FFFFFF1F00000000
      000000000000000000FFFF02000B004D6173746572446174613200000000007F
      010000F0020000140000003000050001000000000000000000FFFFFF1F000000
      0001003100000000000000FFFF02000B0050616765466F6F7465723100000000
      00AE030000F00200005D0000003000030001000000000000000000FFFFFF1F00
      000000000000000000000000FFFF02000B004D61737465724461746133000000
      0000A4010000F0020000280000003000050001000000000000000000FFFFFF1F
      0000000001003100000000000000FFFF000005004D656D6F3100D00000005C00
      000060010000160000000300000001000000000000000000FFFFFF1F2E020000
      00000001002300C0EAF220EFF0EEE2E5F0EAE820EDE0E3F0F3E7EAE820FDEDE5
      F0E3EEF1E8F1F2E5ECFB00000000FFFF130054696D6573204E657720526F6D61
      6E20435952000C0000000200000000000A0000000000020000000000FFFFFF00
      000000000005004D656D6F3800B6000000200000008401000012000000030000
      0001000000C0C0C0000000FFFFFF002E02000000000001000B005B576F726B73
      4E616D655D00000000FFFF130054696D6573204E657720526F6D616E20437972
      000A000000020000000000020000000000020000000000FFFFFF000000000000
      06004D656D6F3535004A00000078000000A00100001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001000C005B4B696E64456E657267
      795D00000000FFFF130054696D6573204E657720526F6D616E20435952000B00
      0000000000000000080000000000020000000000FFFFFF00000000000005004D
      656D6F32001202000078000000A5000000120000000300000001000000000000
      000000FFFFFF1F2E020000000000010006005B446174655D00000000FFFF1300
      54696D6573204E657720526F6D616E20435952000B0000000000000000000800
      00000000020000000000FFFFFF00000000000005004D656D6F33006A00000010
      010000780000001200000003000F0001000000000000000000FFFFFF1F2E0200
      0000000001000500C2F0E5ECFF00000000FFFF130054696D6573204E65772052
      6F6D616E20435952000A0000000000000000000A0000000000020000000000FF
      FFFF00000000000005004D656D6F340050000000F40000006402000012000000
      0300000001000000000000000000B1B1F5002E02000000000001000B005B506F
      696E744E616D655D00000000FFFF130054696D6573204E657720526F6D616E20
      435952000A000000000000000000080000000000020000000000FFFFFF000000
      00000005004D656D6F3500E600000010010000880000001200000003000F0001
      000000000000000000FFFFFF1F2E02000000000001001200CFEEEAE0E7E0EDE8
      E520F1F7E5F2F7E8EAE000000000FFFF130054696D6573204E657720526F6D61
      6E20435952000A0000000000000000000A0000000000020000000000FFFFFF00
      000000000005004D656D6F36007201000010010000880000001200000003000F
      0001000000000000000000FFFFFF1F2E02000000000001000800D0E0E7EDEEF1
      F2FC00000000FFFF130054696D6573204E657720526F6D616E20435952000A00
      00000000000000000A0000000000020000000000FFFFFF00000000000005004D
      656D6F3700FE01000010010000880000001200000003000F0001000000000000
      000000FFFFFF1F2E02000000000001000600D0E0F1F5EEE400000000FFFF1300
      54696D6573204E657720526F6D616E20435952000A0000000000000000000A00
      00000000020000000000FFFFFF00000000000005004D656D6F39006A00000030
      010000780000001200000003000F0001000000000000000000FFFFFF1F2E0200
      00000000010006005B54696D655D00000000FFFF130054696D6573204E657720
      526F6D616E20435952000A0000000000000000000A0000000000020000000000
      FFFFFF00000000000006004D656D6F313000E600000030010000880000001200
      000003000F0001000000000000000000FFFFFF1F2E02000000000001000E005B
      506F6B617A436F756E7465725D00000000FFFF130054696D6573204E65772052
      6F6D616E20435952000A000000000000000000090000000000020000000000FF
      FFFF00000000000006004D656D6F313100720100003001000088000000120000
      0003000F0001000000000000000000FFFFFF1F2E02000000000001000C005B53
      7562436F756E7465725D00000000FFFF130054696D6573204E657720526F6D61
      6E20435952000A000000000000000000090000000000020000000000FFFFFF00
      000000000006004D656D6F313200FE0100003001000088000000120000000300
      0F0001000000000000000000FFFFFF1F2E02000000000001000D005B52617378
      436F756E7465725D00000000FFFF130054696D6573204E657720526F6D616E20
      435952000A000000000000000000090000000000020000000000FFFFFF000000
      00000006004D656D6F313300F600000064010000780000001200000003000F00
      01000000000000000000FFFFFF1F2E02000000000001000500C2F0E5ECFF0000
      0000FFFF130054696D6573204E657720526F6D616E20435952000A0000000000
      000000000A0000000000020000000000FFFFFF00000000000006004D656D6F31
      34007201000064010000880000001200000003000F0001000000000000000000
      FFFFFF1F2E02000000000001001000D1F3ECECE0F0EDFBE920F0E0F1F5EEE400
      000000FFFF130054696D6573204E657720526F6D616E20435952000A00000000
      00000000000A0000000000020000000000FFFFFF00000000000006004D656D6F
      313500F600000080010000780000001200000003000F00010000000000000000
      00FFFFFF1F2E020000000000010009005B54696D6553756D5D00000000FFFF13
      0054696D6573204E657720526F6D616E20435952000A0000000000000000000A
      0000000000020000000000FFFFFF00000000000006004D656D6F313600720100
      0080010000880000001200000003000F0001000000000000000000FFFFFF1F2E
      020000000000010009005B5261737853756D5D00000000FFFF130054696D6573
      204E657720526F6D616E20435952000A00000000000000000009000000000002
      0000000000FFFFFF00000000000006004D656D6F34340052000000F20300006F
      000000120000000300000001000000000000000000FFFFFF1F2E020000000000
      01001100CEF2F7E5F220F1F4EEF0ECE8F0EEE2E0ED00000000FFFF130054696D
      6573204E657720526F6D616E2043595200090000000000000000000800000000
      00020000000000FFFFFF00000000000006004D656D6F343500C1000000F20300
      004C000000120000000300000001000000000000000000FFFFFF1F2E02000000
      0000010006005B444154455D00000000FFFF130054696D6573204E657720526F
      6D616E204359520009000000000000000000080000000000020000000000FFFF
      FF00000000000006004D656D6F3436000D010000F20300005400000012000000
      0300000001000000000000000000FFFFFF1F2E020000000000010006005B5449
      4D455D00000000FFFF130054696D6573204E657720526F6D616E204359520009
      000000000000000000080000000000020000000000FFFFFF0000000000000600
      4D656D6F343800D2000000B1030000DC01000016000000030000000100000000
      0000000000FFFFFF1F2E02000000000001000B005B46697273745369676E5D00
      000000FFFF130054696D6573204E657720526F6D616E20435952000B00000000
      0000000000080000000000020000000000FFFFFF00000000000006004D656D6F
      343900D3000000C7030000DC0100001400000003000000010000000000000000
      00FFFFFF1F2E02000000000001000C005B5365636F6E645369676E5D00000000
      FFFF130054696D6573204E657720526F6D616E20435952000B00000000000000
      0000080000000000020000000000FFFFFF00000000000006004D656D6F313700
      52020000F203000060000000120000000300000001000000000000000000FFFF
      FF002E020000000000010007005B50414745235D00000000FFFF130054696D65
      73204E657720526F6D616E20435952000A000000000000000000090000000000
      020000000000FFFFFF00000000000006004D656D6F31380050000000B0010000
      60020000120000000300000001000000000000000000FFFFFF1F2E0200000000
      0001000A005B4D6178506F7765725D00000000FFFF130054696D6573204E6577
      20526F6D616E20435952000A0000000000000000000000000000000200000000
      00FFFFFF00000000000006004D656D6F313900900100000C0000002401000012
      0000000300000001000000000000000000FFFFFF002E02000000000001002600
      C0D0CC20DDEDE5F0E3E5F2E8EAE02E20CECECE20C0E2F2EEECE0F2E8E7E0F6E8
      FF2D3230303000000000FFFF130054696D6573204E657720526F6D616E204359
      52000A0000000200C0C0C000000000000000020000000000FFFFFF0000000000
      0006004D656D6F323000D1000000DC030000E001000014000000030000000100
      0000000000000000FFFFFF1F2E02000000000001000B005B5468697264536967
      6E5D00000000FFFF130054696D6573204E657720526F6D616E20435952000B00
      0000000000000000080000000000020000000000FFFFFF00000000000006004D
      656D6F373800B400000034000000880100001200000003000000010000000000
      00000000FFFFFF1F2E02000000000001000C005B4E616D654F626A6563745D00
      000000FFFF130054696D6573204E657720526F6D616E20437972000A00000000
      0000000000020000000000020000000000FFFFFF00000000000006004D656D6F
      373900B400000048000000880100001200000003000000010000000000000000
      00FFFFFF1F2E020000000000010008005B4164726573735D00000000FFFF1300
      54696D6573204E657720526F6D616E20437972000A0000000000000000000200
      00000000020000000000FFFFFF00000000FE00000000000000}
  end
  object frDesigner1: TfrDesigner
    Left = 376
    Top = 376
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 547
    Top = 148
    Bitmap = {
      494C010103000400040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000002000000001002000000000000040
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00DEDEDE009C9C9C0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008C8C
      8C00ADADAD00E7E7E700FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F9F9F900EFEFEF00E9E9E900E9E9E900E9E9
      E900EFEFEF00F9F9F90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00ADADAD00C6C6C600CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00C6C6
      C6008C8C8C00CECECE00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00F7F7F700DEDEDE00D6D6D600CECECE00D6D6D600E7E7E700FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F9F9F900EFEFEF00E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E900E9E9E900DDDDDD00C9C9C900BDBDBD00BDBDBD00BDBD
      BD00CDCDCD00EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700C6C6C600CECECE00DEDEDE00E7E7E700E7E7E700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00ADADAD00C6C6C600F7F7F700000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700C6C6C6008C94
      8C0073846300637B4A005A8442005A8439005A8439005A7B3900527339005A73
      5200737B7300A5A5A500DEDEDE00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00EFEFEF00E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E900DDDDDD00C9C9C900BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00B7B7B70012853D0011843C0011843C001286
      3E0015884000EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700E7E7E700D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600ADADAD00C6C6C600F7F7F700000000000000000000000000000000000000
      0000000000000000000000000000E7E7E700848C7B00527B4200528C31005A9C
      310063A5390063A539006BAD39006BAD39006BA5390063A53100639C29005A94
      290052842900296B8C00295A8C004A637300ADADB500FFFFFF00000000000000
      00000000000000000000000000000000000000000000EFEFEF00CFCFCF00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00B7B7B700028742000F853D0011843C0011843C001184
      3C0011843C0012853D0013863E0010823A005BD1850059CF82005AD0840068D7
      8F0014873F00F5F5F50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600CECECE00D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600ADADAD00C6C6C600F7F7F700000000000000000000000000000000000000
      000000000000EFEFEF008C9484004A7B290052942900529429005A9C31005A9C
      310063A5390063A539006BAD39006BAD39006BA5390063A531005A9C29005A94
      2900528C290029739C00216BBD00216BBD002163A500425A7300BDBDBD00FFFF
      FF000000000000000000000000000000000000000000E9E9E900B8872400B67E
      0E00B57C0900B47B0900B47B0900B47B0900B47B0900B47B0900B47B0900B47B
      0900B47B0900B67B0800C17B0600007E34006BD7940057CE820058CD820059CD
      83005BCF84005DD287000D80380056C9810051C57C0050C57C006BD093000D81
      3900C7C7C700E3E3E300F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600CECECE00A5A5A500B5B5B500D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6C6C600D6C6C600D6CE
      CE00A5A5A500B5B5B500EFEFEF00FFFFFF000000000000000000000000000000
      0000CECECE005A734200428418004A8C2100528C2100529429005A9C31005A9C
      310063A5390063A539006BAD39006BAD39006BA5390063A531005A9C29005A94
      2900528C290029739C00216BBD00216BBD00216BBD00216BBD0021528C00848C
      8C00FFFFFF0000000000000000000000000000000000E9E9E900B67E0E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000077280070D297004DC37B0050C4
      7D0054C780000A7D340050C37E004CC07B004AC07A0075D19A000B80370088C9
      A20014873F00D9D9D900F5F5F500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600CECECE00ADADAD00B5B5B500D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6BDB500CE848400CE737300C6736B00BD73
      6B00A56B6B0094848400C6C6C600EFEFEF00000000000000000000000000CECE
      CE0042732900427B1800428418004A8C2100528C2100529429005A9C31005A9C
      310063A5390063A5390063AD390063AD390063A53100639C31005A9429005A94
      2900528C290029739C00216BBD00216BBD00216BBD00216BB500216BB500215A
      9C00737B8400FFFFFF00000000000000000000000000E9E9E900B57B09000000
      0000E6D6AF00E6D6B000E7D7B100E7D7B100E7D7B100E7D7B100E7D7B100E7D7
      B100E7D7B100E7D7B100E8D7B200EFDAB500FFE0BF0000782A007DD4A3004DC2
      7D000A7D34004CBE7B0048BC780046BB77007DD3A50005823A000E863F001387
      400016894100178A4200F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600CECECE00B5B5B500BDBDBD00CECECE00D6D6D600D6D6
      D600D6D6D600D6D6D600CEA5A500D67B7300C66B6B00BD6B6300BD6B6300BD6B
      6300BD6B6300BD6B63009C848400C6C6C6000000000000000000EFEFEF005273
      310039731000427B1800428418004A8C2100528C2100529429005A9C310063A5
      390073B54A0084BD4A0084C64A0084C64A0084BD420084BD42007BB539006BA5
      39005A8C310029739C00216BB500216BBD00216BBD00216BB500216BB500216B
      AD00215A94009C9CA500000000000000000000000000E9E9E900B47B09000000
      0000E6D7B000E7D7B300E8D8B400E8D8B400E8D8B400E8D8B400E8D8B400E8D8
      B400E8D8B400E8D8B400E8D9B400EAD9B500F2DCBA00FFE3C500007E32000A7F
      350049BA790045B7750042B673008AD4AC0002823A00DF841300E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600CECECE00DEDEDE00CECECE00D6D6D600D6D6
      D600D6D6D600D6BDBD00D67B7300C6736B00BD736B00BD6B6B00BD6B6300BD6B
      6B00BD6B6B00C6736B00C6736B00948C8C0000000000FFFFFF007B9473003173
      100039731000427B1800428418004A8C21005A94290073AD39007BC6390073C6
      210063BD080052B500004AB500004AB500004AB500004AB5000052B5000063BD
      080073BD290042A5C600318CCE002973BD00216BBD00216BB500216BB500216B
      AD002163AD00315A7B00E7E7E7000000000000000000E9E9E900B47B09000000
      0000E7D7B100E8D8B400E8D9B500E8D9B500E8D9B500E8D9B500E8D9B500E8D9
      B500E8D9B500E8D9B500E8D9B500EADAB600F3DDBB00FFE4C500017F320043B6
      790040B374003CB1710096D6B300077F340005853D00DE851500DDDDDD00F9F9
      F900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600C6C6C600DEDEDE00C6C6C600D6D6D600D6D6
      D600D6D6D600D68C8C00CE736B00DEADAD00D6A5A500E7BDBD00CE8C8C00DEAD
      AD00DEADAD00D69C9C00C66B6B00A5736B0000000000E7E7E700427321003173
      100039731000397B18004A8C21006BAD310073C621005ABD08004AB5000042B5
      000042B5000042B5000042B5000042B5000042B5000042B5000042B5000042B5
      000031A54A000884F700108CF700299CEF00318CD6002973BD00216BB500216B
      AD002163A50021639C009C9CA5000000000000000000E9E9E900B47B09000000
      0000E6D7B000E7D8B300E8D9B400E8D9B400E8D9B400E8D9B400E8D9B400E8D9
      B400E8D9B400E8D9B400EAD9B500F0DCB900FFE1C100007B2C003AAE73003BAD
      710037AB6E009FD8BB00027C2E003EB275003FB47A0006853D00C3C3C300E3E3
      E300F9F9F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600BDBDBD00C6C6C600BDBDBD00D6D6D600D6D6
      D600D6CECE00DE949400C6736B00D69C9C00CE8C8400CE8C8400F7E7DE00CE84
      7B00D6A59C00CE8C8400C6736B00BD73730000000000CED6C600316B10003173
      100039731000528C21006BBD210052C6080042BD000042BD000042BD000042BD
      000042BD000042BD000042BD000042BD000042BD000042BD000042BD000042BD
      0000108CC6000884F7000884F7000884F700108CF700319CE700317BBD002163
      AD002163A5002163A500637B8C00FFFFFF0000000000E9E9E900B47B08000000
      0000E5D5AD00E6D6AF00E6D6AF00E6D6AF00E6D6AF00E6D6AF00E6D6AF00E6D6
      AF00E6D6AF00E7D7B000EED9B500FEE0BF00007929002EA66B0032A66B0030A5
      6A00A8D9C30000792800AADCC40033A76C0034A86E0037AB72000A843900C9C9
      C900EFEFEF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600BDBDBD00F7F7F700CECECE00D6D6D600D6D6
      D600D6D6D600E7A59C00CE7B7300D6949400DEADAD00D6949400EFCEC600E7B5
      B500D69C9C00DEADAD00D67B7B00CE7B7B0000000000C6CEBD00316B08003173
      08005294210063C6100042C6000039C6000039C6000039C6000039C6000039C6
      000039C6000039C6000039C6000039C6000039C6000039C6000039C6000031AD
      4A000884F7000884F7000884F7000884F7000884F7000884F700299CEF003184
      BD002163A5002163A5005A738C00FFFFFF0000000000E9E9E900B47A08000000
      0000FBF8F100FBF8F000FBF8F100FBF8F100FBF8F100FBF8F100FBF8F100FBF8
      F100FBF8F100FEFAF300FFFFFC0000772400B3E1CE00B5DFCC00B4DFCB00B2DE
      CA00007521000000000000752100B2DECA00B5DFCC00B8E1CF00C0E6D7001086
      3C00EFEFEF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600CECECE00F7F7F700E7E7E700D6D6D600D6D6
      D600D6D6D600EFB5B500D6847B00DE9C9400EFD6D600DE949400D6848400D694
      9400DEA59C00EFD6D600DE8C8400C6847B0000000000BDCEAD00316B08004A8C
      18005AD6080039CE000039CE000039CE000039CE000039CE000039CE000039CE
      000039CE000039CE000039CE000039CE000039CE000039CE000039CE08001894
      C6000884F7000884F7000884F7000884F7000884F7000884F7000884F70029A5
      F700317BBD002163A5005A738C00FFFFFF0000000000E9E9E900B47A08000000
      0000F9F5EB00F8F4EA00F8F5EA00F8F5EA00F8F5EA00F8F5EA00F8F5EA00F8F5
      EA00F8F5EA00FBF6EC00FFFCF600007521000079270000782600007725000074
      2000FFFFFB00FFFCF500FFFFFB0000742000007A29000080340008853A001288
      3F00F9F9F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CECECE00D6D6D600EFEFEF00F7F7F700F7F7F700EFEFEF00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00D6D6D600E7E7E700E7E7E700D6D6D600DEDE
      DE00DEDEDE00E7CECE00DE949400D6847B00D68C8C00CE7B7B00CE7B7B00CE7B
      7B00D6847B00DE8C8C00EF8C8C00AD948C0000000000B5C6A500427B100063CE
      100031D6000031D6000031D6000031D6000031D6000031D6000031D6000031D6
      000031D6000031D6000031D6000031D6000031D6000031D6000029BD5200108C
      F700108CF700108CF700108CF700108CF700108CF700108CF700108CF700108C
      F70031A5E7002973AD005A738C00FFFFFF0000000000E9E9E900B47A08000000
      0000F7F2E700F7F2E600F7F2E600F7F2E600F7F2E600F7F2E600F7F2E600F7F2
      E600F7F2E600F8F2E700FDF5EB00FFFAF200FFFCF600FFFCF600FFFBF500FFFA
      F200FFF5EC00FAF4E900FFF5EB00FFFAF30000000000CE7C0700E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700D6D6D600DEDEDE00F7F7F700F7F7F700F7F7F700EFEFEF00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6D600E7E7E700D6D6D600DEDE
      DE00DEDEDE00DEDEDE00EFC6BD00D68C8400CE7B7B00CE7B7B00CE7B7B00CE7B
      7B00D6847B00E78C8400D68C8C00CECECE00FFFFFF00ADC69C005AAD100039DE
      000031DE000031DE000031DE000031DE000031DE000031DE000031DE000031DE
      000031DE000031DE000031DE000031DE000031DE000031D60800189CBD00108C
      F700108CF700108CF700108CF700108CF700108CF700108CF700108CF700108C
      F7001894F700429CD6005A738C00FFFFFF0000000000E9E9E900B47A08000000
      0000F6F1E400F6F1E300F6F1E300F6F1E300F6F1E300F6F1E300F6F1E300F6F1
      E300F6F1E300F6F1E300F7F1E400F9F3E500F9F3E600FAF3E600F9F3E600F9F3
      E500F7F1E400F6F1E300F7F1E300F9F3E60000000000BC7B0700E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700D6D6D600DEDEDE00F7F7F700F7F7F700F7F7F700EFEFEF00E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700D6D6D600E7E7E700F7F7F700CECECE00DEDE
      DE00E7E7E700E7E7E700E7DEDE00E7C6C600DE9C9400D68C8400D6848400DE8C
      8400E7949400D69C9400CEC6C600F7F7F700FFFFFF00A5B59C0052DE080029E7
      000029E7000029E7000029E7000029E7000029E7000029E7000029E7000029E7
      000029E7000029E7000029E7000029E7000029E7000021C64A00108CF700108C
      F700108CF700108CF700108CF700108CF700108CF700108CF700108CF700108C
      F700108CF70031A5EF00637B9400FFFFFF0000000000E9E9E900B47A08000000
      0000F5EFE000F5EFE000F5EFE000F5EFE000F5EFE000F5EFE000F5EFE000F5EF
      E000F5EFE000F5EFE000F5EFE000F5EFE000F5EFE000F5EFE000F5EFE000F5EF
      E000F5EFE000F5EFE000F5EFE000F5EFE00000000000B67A0700E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700D6D6D600E7E7E700F7F7F700F7F7F700F7F7F700EFEFEF00E7E7E700E7E7
      E700E7E7E700E7E7E700CECECE00BDBDBD00BDBDBD00DEDEDE00BDBDBD00C6C6
      C600B5B5B500D6D6D600E7E7E700E7E7E700E7DEDE00E7CECE00EFC6C600EFC6
      C600BDADAD00BDBDBD00F7F7F700FFFFFF00FFFFFF00ADC6940031EF000029EF
      000029EF000029EF000029EF000029EF000029EF000029EF000029EF000029EF
      000029EF000029EF000029EF000029EF000029E7080018A5C6001894F7001894
      F7001894F7001894F7001894F7001894F7001894F7001894F7001894F7001894
      F7001894F700219CF700638C9C00F7F7F70000000000E9E9E900B47A08000000
      0000F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EE
      DD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EEDD00F4EE
      DD00F4EEDD00F4EEDD00F4EEDD00F4EEDD0000000000B47A0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700D6D6D600E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00E7E7E700E7E7
      E700CECECE00B5B5B500B5B5B500DEDEDE00DEDEDE00D6D6D600CECECE00E7E7
      E700DEDEDE00ADADAD00A5A5A500C6C6C600DEDEDE00DEDEDE00E7E7E700EFEF
      EF00B5B5B500C6C6C600F7F7F70000000000FFFFFF00BDFFA50029F7000021EF
      000021EF000021EF000021EF000021EF000021EF000021EF000021EF000021EF
      000021EF000021EF000021EF000021F7000021D64A001894F7001894F7001894
      F7001894F7001894F7001894F7001894F7001894F7001894F7001894F7001894
      F7001894F7001894F7006BA5BD00E7E7E70000000000E9E9E900B47B08000000
      0000F4ECDA00F4ECD900F4ECDA00F4ECDA00F4ECDA00F4ECDA00F4ECDA00F4EC
      DA00F4ECDA00F4ECDA00F4ECDA00F4ECDA00F4ECDA00F4ECDA00F4ECDA00F4EC
      DA00F4ECDA00F4ECDA00F4ECD900F4ECDA0000000000B47B0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700D6D6D600E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00DEDEDE00BDBD
      BD00A5A5A500ADADAD00CECECE00CECECE00C6C6C600C6C6C600CECECE00C6C6
      C600CECECE00DEDEDE00B5B5B5009C9C9C00B5B5B500B5B5B500DEDEDE00EFEF
      EF00BDBDBD00C6C6C600F7F7F70000000000FFFFFF00BDFFA50021F7000021F7
      000021F7000021F7000021F7000021F7000021F7000021F7000021F7000021F7
      000021F7000029EF080031E7080039DE100021A5C6001894F7001894F7001894
      F7001894F7001894F7001894F7001894F7001894F7001894F7001894F7001894
      F7001894F7001894F70073B5D600E7E7E70000000000E9E9E900B47B08000000
      0000F3EBD700F3EBD600F3EBD700F3EBD700F3EBD700F3EBD700F3EBD700F3EB
      D700F3EBD700F3EBD700F3EBD700F3EBD700F3EBD700F3EBD700F3EBD700F3EB
      D700F3EBD700F3EBD700F3EBD600F3EBD70000000000B47B0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00F7F7F700E7E7E700ADAD
      AD00ADADAD00ADADAD00D6D6D600DEDEDE00CECECE00F7F7F700FFFFFF00F7F7
      F700EFEFEF00F7F7F700D6D6D600CECECE00D6D6D600E7E7E700E7E7E700EFEF
      EF00BDBDBD00C6C6C600F7F7F70000000000FFFFFF00BDFFA50021FF000018FF
      000018FF000021F7000021EF000029DE080031CE100039C618004AB5210052B5
      29005AAD310063AD390063AD39008C7B4A005A7BB500189CF700219CF700219C
      F700219CF700219CF700219CF700219CF700219CF700219CF700219CF700219C
      F700219CF700189CF7007BB5D600E7E7E70000000000E9E9E900B47B08000000
      0000F2E9D300F2E9D300F2E9D400F2E9D400F2E9D400F2E9D400F2E9D400F2E9
      D400F2E9D400F2E9D400F2E9D400F2E9D400F2E9D400F2E9D400F2E9D400F2E9
      D400F2E9D400F2E9D400F2E9D300F2E9D30000000000B47B0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7
      E700E7E7E700E7E7E700DEDEDE00DEDEDE00DEDEDE00CECECE00C6C6C600D6D6
      D600DEDEDE00C6C6C600BDB5B500ADADAD00ADADAD00ADA5A500B5B5B500E7E7
      E700B5B5B500CECECE00FFFFFF0000000000FFFFFF00C6EFAD0029A508003194
      080039841000397B1800428418004A842100528C2100529429005A9C31005A9C
      310063A5390063A539007B8C4200A55A52009C6363003194DE00219CF700219C
      F700219CF700219CF700219CF700219CF700219CF700219CF700219CF700219C
      F700219CF700219CF7008CB5CE00F7F7F70000000000E9E9E900B47B08000000
      0000F1E8D000F1E8D000F1E8D100F1E8D100F1E8D100F1E8D100F1E8D100F1E8
      D100F1E8D100F1E8D100F1E8D100F1E8D100F1E8D100F1E8D100F1E8D100F1E8
      D100F1E8D100F1E8D100F1E8D000F1E8D00000000000B47B0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFE7E700E79C9C00E7948C00E7948C00E7948C00E7948C00E7948C00E78C
      8C00A58C8C00E7E7E700FFFFFF0000000000FFFFFF00E7EFDE00427B10003173
      100039731000427B1800428418004A8C2100528C2100529429005A9C31005A9C
      310063A53900739C4200A5635A00AD635A00AD635A0084738C00299CF700219C
      F700219CF700219CF700219CF700219CF700219CF700219CF700219CF700219C
      F700219CF70031ADFF009CADBD00FFFFFF0000000000E9E9E900B47B08000000
      0000F0E5CC00F0E6CD00F0E6CE00F0E6CE00F0E6CE00F0E6CE00F0E6CE00F0E6
      CE00F0E6CE00F0E6CE00F0E6CE00F0E6CE00F0E6CE00F0E6CE00F0E6CD00F0E6
      CD00F0E6CD00F0E6CD00EFE5CC00EFE5CC0000000000B47B0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00E7B5B500F78C8400F78C8400F78C8400F78C8400F78C8400F78C8400AD84
      8400DEDEDE00FFFFFF00000000000000000000000000FFFFFF00739C42003173
      080039731000427B1800428418004A8C2100528C2100529429005A9C31005A9C
      3100639C39009C735200AD635A00AD635A00AD635A00AD6363005A8CBD0021A5
      F70021A5F70021A5F70021A5F70021A5F70021A5F70021A5F70021A5F70021A5
      F70021A5F7005ABDF700BDC6C6000000000000000000E9E9E900B47B08000000
      0000EEE3C900EFE4CA00EFE4CB00EFE4CB00EFE4CB00EFE4CB00EFE4CB00EFE4
      CB00EFE4CB00EFE4CB00EFE4CB00EFE4CB00EFE4CA00EEE3C900EEE2C800EEE3
      C800EEE3C900EEE3C900EEE2C800EEE2C80000000000B47B0800E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFB5B500F7948C00F78C8400F78C8400F78C8400F78C8C00AD8C8400DEDE
      DE00FFFFFF0000000000000000000000000000000000FFFFFF00CEDEBD003973
      100039731000427B1800428418004A8C2100528C2100529429005A9C31005A9C
      3100947B5200B56B6300B56B6300B56B6300B56B6300B56B6300A56B7300399C
      EF0029A5FF0029A5FF0029A5FF0029A5FF0029A5FF0029A5FF0029A5FF0029A5
      FF0029ADFF009CC6D600EFEFEF000000000000000000E9E9E900B47B08000000
      0000EDE2C600EEE3C700EEE3C800EEE3C800EEE3C800EEE3C800EEE3C800EEE3
      C800EEE3C800EEE3C800EEE3C800EEE3C800EDE2C600F5EFE100000000000000
      00000000000000000000000000000000000000000000B47B0900E9E9E9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFBDBD00FF9C9400FF948C00FF949400F7949400AD8C8C00DEDEDE00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF008CB5
      6B0039731000427B1800428418004A8C2100528C2100529429005A9C31007B8C
      4A00B56B6B00B56B6B00B56B6B00B56B6B00B56B6B00B56B6B00B56B63008C84
      940029A5FF0029A5FF0029A5FF0029A5FF0029A5FF0029A5FF0029A5FF0029A5
      FF007BC6F700CECECE00000000000000000000000000E9E9E900B47B08000000
      0000ECE0C300EDE1C400EDE1C500EDE1C500EDE1C500EDE1C500EDE1C500EDE1
      C500EDE1C500EDE1C500EDE1C500EDE1C400ECDFC20000000000CFAA6000AE6F
      0000AE700000AE700000AE6F0000AC6D000000000000B57D0C00EFEFEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFCEC600FFB5AD00FFADAD00FFADAD00AD949400DEDEDE00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      F7006B9C4200427B1800428418004A8C2100528C2100529429006B943900B573
      6B00B5736B00BD736B00BD736B00BD736B00BD736B00BD736B00BD736B00BD73
      6B005A94CE0029ADFF0029ADFF0029ADFF0029ADFF0029ADFF0029ADFF005AC6
      FF00C6C6C600FFFFFF00000000000000000000000000E9E9E900B47B08000000
      0000EBDFBF00ECE0C100ECE0C200ECE0C200ECE0C200ECE0C200ECE0C200ECE0
      C200ECE0C200ECE0C200ECE0C200ECE0C100EBDEBF0000000000AD6F00000000
      0000FDFDFB00F9F4EA00F4ECDA0000000000EBDBBC00BC892500FBFBFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700F7F7F700FFFFFF00FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFD6D600FFCECE00FFC6C600AD9C9C00DEDEDE00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00F7F7EF007BAD5A00428418004A8C2100528C21005A943100AD7B6300BD73
      7300BD737300BD737300BD737300BD737300BD737300BD737300BD737300BD73
      7300AD7B840039A5EF0029ADFF0031ADFF0031ADFF0031ADFF006BC6FF00BDC6
      CE00FFFFFF0000000000000000000000000000000000E9E9E900B47B09000000
      0000EADCBC00EBDEBE00EBDEBF00EBDEBF00EBDEBF00EBDEBF00EBDEBF00EBDE
      BF00EBDEBF00EBDEBF00EBDEBF00EBDEBE00EADCBC0000000000AE700000FDFD
      FB00F6EFDF00F0E6CD0000000000EAD8B700BB882400FBFBFB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00EFEFEF00E7E7E700EFEFEF00EFEFEF00E7E7E700EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFDED600FFD6CE00AD9C9C00DEDEDE00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00A5C68C0052942900528C210094845A00BD7B7300BD7B
      7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B
      7300BD7B7300848CAD0031ADFF0031ADFF0039B5FF0094D6F700DEE7E700FFFF
      FF000000000000000000000000000000000000000000E9E9E900B47B09000000
      0000E9DBB900EADDBB00EADDBC00EADDBC00EADDBC00EADDBC00EADDBC00EADD
      BC00EADDBC00EADDBC00EADDBC00EADDBB00E9DBB90000000000AE700000F9F4
      EA00F0E6CE0000000000E9D7B400BB882200FBFBFB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700DEDEDE00E7E7E700EFEFEF00E7E7E700E7E7E700EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFD6D600ADA5A500DEDEDE00FFFFFF00000000000000000000000000FFFF
      FF00F7F7F700FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00EFF7E700ADBD8C00C68C8400C67B7B00C67B
      7B00C67B7B00C67B7B00C67B7B00C67B7B00C67B7B00C67B7B00C67B7B00C67B
      7B00C67B7B00BD847B006BADDE007BCEFF00DEEFF700F7F7F700000000000000
      00000000000000000000000000000000000000000000E9E9E900B47B09000000
      0000E7D9B400E8D9B700E9DAB700E9DAB700E9DAB700E9DAB700E9DAB700E9DA
      B700E9DAB700E9DAB700E9DAB700E8D9B700E7D9B40000000000AE6F0000F3EC
      DA0000000000E9D7B400BB872000FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00DEDEDE00DEDEDE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600BDBDBD00E7E7E700FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00F7F7EF00E7D6CE00D6AD
      A500CE948C00C68C8400C6847B00C6847B00C6847B00C6847B00C68C8400CE94
      8C00D6ADA500E7D6D600EFF7F700FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000EBEBEB00B57B09000000
      0000E7D7B100E7D7B200E8D8B300E8D8B300E8D8B300E8D8B300E8D8B300E8D8
      B300E8D8B300E8D8B300E8D8B300E7D7B200E7D7B00000000000AC6D00000000
      0000EAD8B600C8A25800FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7EF00F7E7E700F7DEDE00EFDEDE00EFE7E700F7F7EF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F300B67E0E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EBDB
      BC00C7A25800FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00CAA65B00B67E
      0E00B57B0900B47B0900B47B0900B47B0900B47B0900B47B0900B47B0900B47B
      0900B47B0900B47B0900B47B0900B47B0900B47B0900B47B0900B57D0C00CAA5
      5A00FBFBFB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000200000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF00E0000001FFFFFFFFFFFFFE0300000000
      E0000001FFF00FFFFFFC000300000000E0000001FF8000FF8000000300000000
      E0000001FE00003F8000000300000000E0000001F800000F8000000100000000
      E0000000F00000079FFF000100000000E0000000E00000039000000100000000
      E0000000C00000039000001F00000000E0000000800000019000000F00000000
      E0000000800000019000000700000000E0000000800000009000000700000000
      E0000000800000009000040700000000E0000000800000009000000700000000
      E0000000800000009000009F00000000E0000000000000009000009F00000000
      E0000000000000009000009F00000000E0000000000000009000009F00000000
      E0000001000000009000009F00000000E0000001000000009000009F00000000
      E0000001000000009000009F00000000E0000001000000009000009F00000000
      E0000001000000009000009F00000000E0000003800000019000009F00000000
      E00000078000000190003F9F00000000E000000FC00000039000409F00000000
      E000001FE00000039000511F00000000E000003FE00000079000423F00000000
      E0000063F000000F9000447F00000000E00000E3FC00003F900048FF00000000
      E00001E3FE00007F900051FF00000000F00003FFFF8001FF9FFFE3FF00000000
      FFFFFFFFFFF00FFF800007FF0000000000000000000000000000000000000000
      000000000000}
  end
end
