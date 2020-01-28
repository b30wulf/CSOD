object RPGomelBalans: TRPGomelBalans
  Left = 703
  Top = 216
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Вычисление потребления по предприятию (Абоненты - Субабоненты)'
  ClientHeight = 417
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 0
    Width = 746
    Height = 417
    Align = alClient
    BevelOuter = bvNone
    Color = 13627626
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
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
    Styler = ReportPanelStyler
    FullHeight = 0
    object GradientLabel: TGradientLabel
      Left = 14
      Top = 29
      Width = 355
      Height = 17
      AutoSize = False
      Caption = 'Группы '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
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
    object GradientLabel1: TGradientLabel
      Left = 397
      Top = 29
      Width = 356
      Height = 17
      AutoSize = False
      Caption = 'Абоненты'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
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
    object GradientLabel2: TGradientLabel
      Left = 398
      Top = 211
      Width = 355
      Height = 17
      AutoSize = False
      Caption = 'Субоненты'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
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
    object sgGroups: TAdvStringGrid
      Left = 12
      Top = 46
      Width = 358
      Height = 347
      Cursor = crDefault
      BiDiMode = bdLeftToRight
      ColCount = 2
      DefaultColWidth = 80
      DefaultRowHeight = 21
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      GridLineWidth = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentBiDiMode = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDblClick = sgGroupsDblClick
      ActiveCellFont.Charset = RUSSIAN_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Times New Roman'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = 9758459
      ActiveCellColorTo = 1414638
      Bands.Active = True
      Bands.PrimaryColor = 14811105
      Bands.SecondaryColor = clWhite
      CellNode.ShowTree = False
      ColumnHeaders.Strings = (
        '№ п. п.'
        'Название группы')
      ControlLook.FixedGradientFrom = 13627626
      ControlLook.FixedGradientTo = 9224369
      ControlLook.ControlStyle = csClassic
      EnableWheel = False
      EnhRowColMove = False
      Filter = <>
      FixedColWidth = 44
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
      SearchFooter.Color = 13627626
      SearchFooter.ColorTo = 9224369
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
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      WordWrap = False
      ColWidths = (
        44
        259)
      RowHeights = (
        21
        21)
    end
    object sgBalansVM: TAdvStringGrid
      Left = 396
      Top = 46
      Width = 358
      Height = 163
      Cursor = crDefault
      BiDiMode = bdLeftToRight
      ColCount = 3
      DefaultColWidth = 80
      DefaultRowHeight = 21
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      GridLineWidth = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentBiDiMode = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      ActiveCellFont.Charset = RUSSIAN_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Times New Roman'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = 9758459
      ActiveCellColorTo = 1414638
      Bands.Active = True
      Bands.PrimaryColor = 14811105
      Bands.SecondaryColor = clWhite
      CellNode.ShowTree = False
      ColumnHeaders.Strings = (
        '№ п. п.'
        'Название точки учета'
        'Зав. номер')
      ControlLook.FixedGradientFrom = 13627626
      ControlLook.FixedGradientTo = 9224369
      ControlLook.ControlStyle = csClassic
      EnableWheel = False
      EnhRowColMove = False
      Filter = <>
      FixedColWidth = 48
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
      ScrollBarAlways = saVert
      ScrollWidth = 14
      SearchFooter.Color = 13627626
      SearchFooter.ColorTo = 9224369
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
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      WordWrap = False
      ColWidths = (
        48
        195
        90)
      RowHeights = (
        21
        21)
    end
    object AdvGlowButton1: TAdvGlowButton
      Left = 370
      Top = 119
      Width = 25
      Height = 29
      Caption = '=>'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 2
      OnClick = AdvGlowButton1Click
      Appearance.BorderColor = 9224369
      Appearance.BorderColorHot = 10079963
      Appearance.BorderColorDown = 4548219
      Appearance.BorderColorChecked = clBlack
      Appearance.Color = 13627626
      Appearance.ColorTo = 13627626
      Appearance.ColorChecked = 11918331
      Appearance.ColorCheckedTo = 7915518
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 7778289
      Appearance.ColorDownTo = 4296947
      Appearance.ColorHot = 15465983
      Appearance.ColorHotTo = 11332863
      Appearance.ColorMirror = 13627626
      Appearance.ColorMirrorTo = 9224369
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
      Left = 371
      Top = 303
      Width = 25
      Height = 29
      Caption = '=>'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 3
      OnClick = AdvGlowButton2Click
      Appearance.BorderColor = 9224369
      Appearance.BorderColorHot = 10079963
      Appearance.BorderColorDown = 4548219
      Appearance.BorderColorChecked = clBlack
      Appearance.Color = 13627626
      Appearance.ColorTo = 13627626
      Appearance.ColorChecked = 11918331
      Appearance.ColorCheckedTo = 7915518
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 7778289
      Appearance.ColorDownTo = 4296947
      Appearance.ColorHot = 15465983
      Appearance.ColorHotTo = 11332863
      Appearance.ColorMirror = 13627626
      Appearance.ColorMirrorTo = 9224369
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
    object sgCalcVM: TAdvStringGrid
      Left = 397
      Top = 230
      Width = 358
      Height = 163
      Cursor = crDefault
      BiDiMode = bdLeftToRight
      ColCount = 3
      DefaultColWidth = 80
      DefaultRowHeight = 21
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      GridLineWidth = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentBiDiMode = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 4
      ActiveCellFont.Charset = RUSSIAN_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Times New Roman'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = 9758459
      ActiveCellColorTo = 1414638
      Bands.Active = True
      Bands.PrimaryColor = 14811105
      Bands.SecondaryColor = clWhite
      CellNode.ShowTree = False
      ColumnHeaders.Strings = (
        '№ п. п.'
        'Название точки учета'
        'Зав. номер')
      ControlLook.FixedGradientFrom = 13627626
      ControlLook.FixedGradientTo = 9224369
      ControlLook.ControlStyle = csClassic
      EnableWheel = False
      EnhRowColMove = False
      Filter = <>
      FixedColWidth = 48
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
      ScrollBarAlways = saVert
      ScrollWidth = 14
      SearchFooter.Color = 13627626
      SearchFooter.ColorTo = 9224369
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
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      WordWrap = False
      ColWidths = (
        48
        195
        90)
      RowHeights = (
        21
        21)
    end
    object Panel5: TAdvPanel
      Left = 0
      Top = 392
      Width = 746
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      Color = 13627626
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
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
      Styler = ReportPanelStyler
      FullHeight = 0
      object rbCreateReport: TRbButton
        Left = 510
        Top = 1
        Width = 122
        Height = 23
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        OnClick = rbCreateReportClick
        TabOrder = 0
        TextShadow = True
        Caption = 'Сформировать отчет'
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
      object btnCancel: TRbButton
        Left = 633
        Top = 1
        Width = 122
        Height = 23
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        OnClick = btnCancelClick
        TabOrder = 1
        TextShadow = True
        Caption = 'Выйти'
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
    end
    object AdvPanel1: TAdvPanel
      Left = 0
      Top = 0
      Width = 746
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      Color = 13627626
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
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
      Styler = ReportPanelStyler
      FullHeight = 0
      object Label5: TLabel
        Left = 227
        Top = 6
        Width = 37
        Height = 15
        BiDiMode = bdRightToLeftNoAlign
        Caption = 'Начало'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 501
        Top = 6
        Width = 55
        Height = 15
        BiDiMode = bdRightToLeftNoAlign
        Caption = 'Окончание'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
      end
      object dtBegin: TDateTimePicker
        Left = 270
        Top = 3
        Width = 113
        Height = 22
        CalAlignment = dtaLeft
        Date = 40427.5278374537
        Time = 40427.5278374537
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object dtEnd: TDateTimePicker
        Left = 386
        Top = 3
        Width = 113
        Height = 22
        CalAlignment = dtaLeft
        Date = 40427.5278374537
        Time = 40427.5278374537
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
    end
  end
  object frDesigner1: TfrDesigner
    Left = 600
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frReport1GetValue
    OnManualBuild = frReport1ManualBuild
    Left = 560
    ReportForm = {
      17000000D723000017000000000F0044656661756C74207072696E74657200FF
      09000000340800009A0B000000000000000000000000000000000000000000FF
      FF000000000000000002000B0050616765486561646572310000000000000000
      00F00200006F0000003000020001000000000000000000FFFFFF1F0000000000
      0000000000000000FFFF02000B0050616765466F6F746572310000000000B803
      0000F00200006C0000003000030001000000000000000000FFFFFF1F00000000
      000000000000000000FFFF02000B004D617374657244617461310000000000CD
      000000F0020000190000003000050001000000000000000000FFFFFF1F000000
      0001003100000000000000FFFF02000D004D6173746572486561646572310000
      00000074000000F0020000550000003000040001000000000000000000FFFFFF
      1F00000000000000000000000000FFFF02000B004D6173746572446174613200
      00000000A3010000F0020000460000003000050001000000000000000000FFFF
      FF1F0000000001003100000000000000FFFF02000D004D617374657248656164
      657232000000000033010000F00200004C000000300004000100000000000000
      0000FFFFFF1F00000000000000000000000000FFFF02000D004D617374657248
      6561646572330000000000FE010000F002000041000000300004000100000000
      0000000000FFFFFF1F00000000000000000000000000FFFF02000B004D617374
      65724461746133000000000055020000F0020000320000003000050001000000
      000000000000FFFFFF1F0000000001003100000000000000FFFF02000D004D61
      73746572466F6F74657231000000000008010000F00200001400000030000600
      01000000000000000000FFFFFF1F00000000000000000000000000FFFF000005
      004D656D6F38001300000026000000C2010000120000000300000001000000C0
      C0C0000000FFFFFF002E02000000000001001800CFF0E5E4EFF0E8FFF2E8E53A
      205B576F726B734E616D655D00000000FFFF130054696D6573204E657720526F
      6D616E20435952000A000000020000000000000000000000020000000000FFFF
      FF00000000000006004D656D6F35320012000000BA0300000002000016000000
      0300000001000000000000000000FFFFFF1F2E02000000000001000B005B4669
      7273745369676E5D00000000FFFF130054696D6573204E657720526F6D616E20
      435952000B000000000000000000080000000000020000000000FFFFFF000000
      00000006004D656D6F35330012000000CF030000000200001400000003000000
      01000000000000000000FFFFFF1F2E02000000000001000C005B5365636F6E64
      5369676E5D00000000FFFF130054696D6573204E657720526F6D616E20435952
      000B000000000000000000080000000000020000000000FFFFFF000000000000
      06004D656D6F313100130000008D000000590100001200000003000000010000
      00000000000000FFFFFF1F2E020000000000010008005B4B696E64456E5D0000
      0000FFFF130054696D6573204E657720526F6D616E20435952000A0000000200
      00000000080000000000020000000000FFFFFF00000000000006004D656D6F31
      330013000000A1000000A10000002800000003000F0001000000000000000000
      FFFFFF1F2E02000000000002000600CEE1FAE5EAF20D080028E3F0F3EFEFE029
      00000000FFFF130054696D6573204E657720526F6D616E204359520007000000
      0000000000000A0000000000020000000000FFFFFF00000000000006004D656D
      6F31340013000000CD000000A10000001900000003000F000100000000000000
      0000FFFFFF1F2E02000000000001000D005B4E616D65436F756E7465725D0000
      0000FFFF130054696D6573204E657720526F6D616E2043595200070000000000
      000000000A0000000000020000000000FFFFFF00000000000006004D656D6F31
      370084010000A1000000570000002800000003000F0001000000000000000000
      FFFFFF1F2E02000000000001002400CFEEEAE0E7E0EDE8FF20F1F7E5F2F7E8EA
      EEE220EDE020EAEEEDE5F620EFE5F0E8EEE4E000000000FFFF130054696D6573
      204E657720526F6D616E2043595200070000000000000000000A000000000002
      0000000000FFFFFF00000000000006004D656D6F3138002D010000CD00000057
      0000001900000003000F0001000000000000000000FFFFFF1F2E020000000000
      01000B005B506F6B456E657267425D00000000FFFF130054696D6573204E6577
      20526F6D616E2043595200080000000000000000000A00000000000200000000
      00FFFFFF00000000000006004D656D6F323900B4000000A10000002800000028
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001000300
      CAF2F000000000FFFF130054696D6573204E657720526F6D616E204359520007
      0000000000000000000A0000000000020000000000FFFFFF0000000000000600
      4D656D6F333000B4000000CD000000280000001900000003000F000100000000
      0000000000FFFFFF1F2E020000000000010008005B4B6F656654315D00000000
      FFFF130054696D6573204E657720526F6D616E20435952000800000000000000
      00000A0000000000020000000000FFFFFF00000000000006004D656D6F333300
      9D020000A1000000400000002800000003000F0001000000000000000000FFFF
      FF1F2E02000000000001000D00CFEE20E2F1E5EC20E7EEEDE0EC00000000FFFF
      130054696D6573204E657720526F6D616E204359520007000000000000000000
      0A0000000000020000000000FFFFFF00000000000006004D656D6F3334009D02
      0000CD000000400000001900000003000F0001000000000000000000FFFFFF1F
      2E020000000000010009005B456E65726754735D00000000FFFF130054696D65
      73204E657720526F6D616E2043595200080000000000000000000A0000000000
      020000000000FFFFFF00000000000006004D656D6F3438000A02000026000000
      C8000000120000000300000001000000000000000000FFFFFF1F2E0200000000
      0001001F00CEF2F7E5F220F1F4EEF0ECE8F0EEE2E0ED3A5B444154455D205B54
      494D455D00000000FFFF130054696D6573204E657720526F6D616E2043595200
      07000000000000000000010000000000020000000000FFFFFF00000000000006
      004D656D6F3535006E020000E30300005A000000140000000300000001000000
      000000000000FFFFFF1F2E020000000000010007005B50414745235D00000000
      FFFF130054696D6573204E657720526F6D616E20435952000C00000000000000
      0000010000000000020000000000FFFFFF00000000000005004D656D6F350012
      000000E303000000020000140000000300000001000000000000000000FFFFFF
      1F2E02000000000001000B005B54686972645369676E5D00000000FFFF130054
      696D6573204E657720526F6D616E20435952000B000000000000000000080000
      000000020000000000FFFFFF00000000000006004D656D6F3739009600000043
      000000C4010000120000000300000001000000000000000000FFFFFF1F2E0200
      0000000001002000CEF2F7E5F2EDFBE920EFE5F0E8EEE43A5B44617465425D2D
      205B44617465455D00000000FFFF130054696D6573204E657720526F6D616E20
      435952000A000000020000000000020000000000020000000000FFFFFF000000
      00000005004D656D6F3400DC000000A1000000390000002800000003000F0001
      000000000000000000FFFFFF1F2E02000000000002000100B90D0800F1F7E5F2
      F7E8EAE000000000FFFF130054696D6573204E657720526F6D616E2043595200
      070000000000000000000A0000000000020000000000FFFFFF00000000000006
      004D656D6F323200DC000000CD000000390000001900000003000F0001000000
      000000000000FFFFFF1F2E020000000000010008005B4D657465724E5D000000
      00FFFF130054696D6573204E657720526F6D616E204359520008000000000000
      0000000A0000000000020000000000FFFFFF00000000000005004D656D6F3200
      DB010000A1000000400000002800000003000F0001000000000000000000FFFF
      FF1F2E02000000000002000800E7EEEDE020EFE8EA0D0D0030383A3030202D20
      31313A303000000000FFFF130054696D6573204E657720526F6D616E20435952
      00070000000000000000000A0000000000020000000000FFFFFF000000000000
      05004D656D6F3300DB010000CD000000400000001900000003000F0001000000
      000000000000FFFFFF1F2E020000000000010009005B456E65726754315D0000
      0000FFFF130054696D6573204E657720526F6D616E2043595200080000000000
      000000000A0000000000020000000000FFFFFF00000000000006004D656D6F32
      37001B020000A1000000400000002800000003000F0001000000000000000000
      FFFFFF1F2E02000000000003000700EFEEEBF3EFE8EA0D0B0030363A30302D30
      383A30300D0B0031313A30302D32333A303000000000FFFF130054696D657320
      4E657720526F6D616E2043595200070000000000000000000A00000000000200
      00000000FFFFFF00000000000006004D656D6F3238001B020000CD0000004000
      00001900000003000F0001000000000000000000FFFFFF1F2E02000000000001
      0009005B456E65726754325D00000000FFFF130054696D6573204E657720526F
      6D616E2043595200080000000000000000000A0000000000020000000000FFFF
      FF00000000000006004D656D6F3538005B020000A10000004200000028000000
      03000F0001000000000000000000FFFFFF1F2E02000000000002000400EDEEF7
      FC0D0B0032333A30302D30363A303000000000FFFF130054696D6573204E6577
      20526F6D616E2043595200070000000000000000000A00000000000200000000
      00FFFFFF00000000000006004D656D6F3539005B020000CD0000004200000019
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001000900
      5B456E65726754335D00000000FFFF130054696D6573204E657720526F6D616E
      2043595200080000000000000000000A0000000000020000000000FFFFFF0000
      0000000006004D656D6F313500DB0100008C000000C20000001500000003000F
      0001000000000000000000FFFFFF1F2E02000000000001001800D0E0F1F5EEE4
      20C0DD20EFEE20E7EEEDE0EC20F1F3F2EEEA00000000FFFF130054696D657320
      4E657720526F6D616E20435952000A0000000000000000000A00000000000200
      00000000FFFFFF00000000000005004D656D6F36001300000045010000FD0000
      00160000000300000001000000000000000000FFFFFF1F2E0200000000000100
      2300312E3320C8D2CEC3CE20C0EAF2E8E2EDE0FF20DDEDE5F0E3E8FF28EAC2F2
      2EF7E0F12900000000FFFF130054696D6573204E657720526F6D616E20435952
      000A000000020000000000080000000000020000000000FFFFFF000000000000
      05004D656D6F37001101000045010000590100001600000003000F0001000000
      000000000000FFFFFF1F2E02000000000001001800D0E0F1F5EEE420C0DD20EF
      EE20E7EEEDE0EC20F1F3F2EEEA00000000FFFF130054696D6573204E65772052
      6F6D616E20435952000A0000000000000000000A0000000000020000000000FF
      FFFF00000000000005004D656D6F39006A0200005B0100007300000024000000
      03000F0001000000000000000000FFFFFF1F2E02000000000001000D00CFEE20
      E2F1E5EC20E7EEEDE0EC00000000FFFF130054696D6573204E657720526F6D61
      6E2043595200070000000000000000000A0000000000020000000000FFFFFF00
      000000000006004D656D6F3130006A020000A301000073000000190000000300
      0F0001000000000000000000FFFFFF1F2E02000000000001000C005B456E6572
      547353756D425D00000000FFFF130054696D6573204E657720526F6D616E2043
      595200080000000000000000000A0000000000020000000000FFFFFF00000000
      000006004D656D6F313600110100005B010000730000002400000003000F0001
      000000000000000000FFFFFF1F2E02000000000002000800E7EEEDE020EFE8EA
      0D0D0030383A3030202D2031313A303000000000FFFF130054696D6573204E65
      7720526F6D616E2043595200070000000000000000000A000000000002000000
      0000FFFFFF00000000000006004D656D6F31390011010000A301000073000000
      1900000003000F0001000000000000000000FFFFFF1F2E02000000000001000C
      005B456E6572543153756D425D00000000FFFF130054696D6573204E65772052
      6F6D616E2043595200080000000000000000000A0000000000020000000000FF
      FFFF00000000000006004D656D6F323000840100005B01000073000000240000
      0003000F0001000000000000000000FFFFFF1F2E02000000000003000700EFEE
      EBF3EFE8EA0D0B0030363A30302D30383A30300D0B0031313A30302D32333A30
      3000000000FFFF130054696D6573204E657720526F6D616E2043595200070000
      000000000000000A0000000000020000000000FFFFFF00000000000006004D65
      6D6F32330084010000A3010000730000001900000003000F0001000000000000
      000000FFFFFF1F2E02000000000001000C005B456E6572543253756D425D0000
      0000FFFF130054696D6573204E657720526F6D616E2043595200080000000000
      000000000A0000000000020000000000FFFFFF00000000000006004D656D6F32
      3400F70100005B010000730000002400000003000F0001000000000000000000
      FFFFFF1F2E02000000000002000400EDEEF7FC0D0B0032333A30302D30363A30
      3000000000FFFF130054696D6573204E657720526F6D616E2043595200070000
      000000000000000A0000000000020000000000FFFFFF00000000000006004D65
      6D6F323500F7010000A3010000730000001900000003000F0001000000000000
      000000FFFFFF1F2E02000000000001000C005B456E6572543353756D425D0000
      0000FFFF130054696D6573204E657720526F6D616E2043595200080000000000
      000000000A0000000000020000000000FFFFFF00000000000006004D656D6F32
      3600130000005B010000FE0000002400000003000F0001000000000000000000
      FFFFFF1F2E02000000000002000600CEE1FAE5EAF20D080028E3F0F3EFEFE029
      00000000FFFF130054696D6573204E657720526F6D616E204359520008000000
      0000000000000A0000000000020000000000FFFFFF00000000000006004D656D
      6F33350013000000A3010000FE0000001900000003000F000100000000000000
      0000FFFFFF1F2E02000000000001000E00C0EAF2E8E2EDE0FF20EFF0E8B8EC00
      000000FFFF130054696D6573204E657720526F6D616E20435952000800000000
      0000000000080000000000020000000000FFFFFF00000000000006004D656D6F
      3336006A020000BC010000730000001A00000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000C005B456E6572547353756D525D00000000
      FFFF130054696D6573204E657720526F6D616E20435952000800000000000000
      00000A0000000000020000000000FFFFFF00000000000006004D656D6F333700
      11010000BC010000730000001A00000003000F0001000000000000000000FFFF
      FF1F2E02000000000001000C005B456E6572543153756D525D00000000FFFF13
      0054696D6573204E657720526F6D616E2043595200080000000000000000000A
      0000000000020000000000FFFFFF00000000000006004D656D6F333800840100
      00BC010000730000001A00000003000F0001000000000000000000FFFFFF1F2E
      02000000000001000C005B456E6572543253756D525D00000000FFFF13005469
      6D6573204E657720526F6D616E2043595200080000000000000000000A000000
      0000020000000000FFFFFF00000000000006004D656D6F333900F7010000BC01
      0000730000001A00000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000C005B456E6572543353756D525D00000000FFFF130054696D6573
      204E657720526F6D616E2043595200080000000000000000000A000000000002
      0000000000FFFFFF00000000000006004D656D6F34300013000000BC010000FE
      0000001A00000003000F0001000000000000000000FFFFFF1F2E020000000000
      01001300C0EAF2E8E2EDE0FF2028F0E0F7E5F2EDE0FF2900000000FFFF130054
      696D6573204E657720526F6D616E204359520008000000000000000000080000
      000000020000000000FFFFFF00000000000006004D656D6F3431001300000001
      020000FE0000001E0000000300000001000000000000000000FFFFFF1F2E0200
      0000000001001800322ECCEEF9EDEEF1F2FC20C0EAF2E8E2EDE0FF28EAC2F229
      00000000FFFF130054696D6573204E657720526F6D616E20435952000A000000
      020000000000080000000000020000000000FFFFFF00000000000006004D656D
      6F3432001101000001020000CC0100001E00000003000F000100000000000000
      0000FFFFFF1F2E02000000000002002B00CCE0EAF1E8ECF3ECFB20ECEEF9EDEE
      F1F2E820C0DD20EFEE20E7EEEDE0EC20F1F3F2EEEA2C20EAC2F22C200D0A00C2
      F0E5ECFF20C4E0F2E000000000FFFF130054696D6573204E657720526F6D616E
      20435952000A0000000000000000000A0000000000020000000000FFFFFF0000
      0000000006004D656D6F343300430200001F0200009A0000002000000003000F
      0001000000000000000000FFFFFF1F2E02000000000001000A00C0E1F1EEEBFE
      F2EDFBE900000000FFFF130054696D6573204E657720526F6D616E2043595200
      080000000000000000000A0000000000020000000000FFFFFF00000000000006
      004D656D6F343400110100001F020000990000002000000003000F0001000000
      000000000000FFFFFF1F2E02000000000002000C00F3F2F0E5EDEDE8E920EFE8
      EA0D0B0030383A30302D31313A303000000000FFFF130054696D6573204E6577
      20526F6D616E2043595200080000000000000000000A00000000000200000000
      00FFFFFF00000000000006004D656D6F343500AA0100001F0200009900000020
      00000003000F0001000000000000000000FFFFFF1F2E02000000000002000C00
      C2E5F7E5F0EDE8E920EFE8EA0D0B0031373A30302D32303A303000000000FFFF
      130054696D6573204E657720526F6D616E204359520008000000000000000000
      0A0000000000020000000000FFFFFF00000000000006004D656D6F3437001300
      00001F020000FE0000002000000003000F0001000000000000000000FFFFFF1F
      2E02000000000002000600CEE1FAE5EAF20D080028E3F0F3EFEFE02900000000
      FFFF130054696D6573204E657720526F6D616E20435952000800000000000000
      00000A0000000000020000000000FFFFFF00000000000006004D656D6F353400
      1300000055020000FE0000001900000003000F0001000000000000000000FFFF
      FF1F2E02000000000001000E00C0EAF2E8E2EDE0FF20EFF0E8E5EC00000000FF
      FF130054696D6573204E657720526F6D616E2043595200080000000000000000
      00080000000000020000000000FFFFFF00000000000006004D656D6F34360011
      01000055020000990000001900000003000F0001000000000000000000FFFFFF
      1F2E020000000000010008005B4D61785031425D00000000FFFF130054696D65
      73204E657720526F6D616E2043595200080000000000000000000A0000000000
      020000000000FFFFFF00000000000006004D656D6F343900AA01000055020000
      990000001900000003000F0001000000000000000000FFFFFF1F2E0200000000
      00010008005B4D61785032425D00000000FFFF130054696D6573204E65772052
      6F6D616E2043595200080000000000000000000A0000000000020000000000FF
      FFFF00000000000006004D656D6F35300043020000550200009A000000190000
      0003000F0001000000000000000000FFFFFF1F2E020000000000010008005B4D
      61785041425D00000000FFFF130054696D6573204E657720526F6D616E204359
      5200080000000000000000000A0000000000020000000000FFFFFF0000000000
      0006004D656D6F353100130000006E020000FE0000001900000003000F000100
      0000000000000000FFFFFF1F2E02000000000001001400C0EAF2E8E2EDE0FF20
      28F0E0F1F7E5F2EDE0FF2900000000FFFF130054696D6573204E657720526F6D
      616E204359520008000000000000000000080000000000020000000000FFFFFF
      00000000000006004D656D6F353600110100006E020000990000001900000003
      000F0001000000000000000000FFFFFF1F2E020000000000010008005B4D6178
      5031525D00000000FFFF130054696D6573204E657720526F6D616E2043595200
      080000000000000000000A0000000000020000000000FFFFFF00000000000006
      004D656D6F353700AA0100006E020000990000001900000003000F0001000000
      000000000000FFFFFF1F2E020000000000010008005B4D61785032525D000000
      00FFFF130054696D6573204E657720526F6D616E204359520008000000000000
      0000000A0000000000020000000000FFFFFF00000000000006004D656D6F3630
      00430200006E0200009A0000001900000003000F0001000000000000000000FF
      FFFF1F2E020000000000010008005B4D61785041525D00000000FFFF13005469
      6D6573204E657720526F6D616E2043595200080000000000000000000A000000
      0000020000000000FFFFFF00000000000006004D656D6F313200DB0100000801
      0000400000001400000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000A005B456E6572675431535D00000000FFFF130054696D6573204E
      657720526F6D616E2043595200080000000000000000000A0000000000020000
      000000FFFFFF00000000000006004D656D6F3231001B02000008010000400000
      001400000003000F0001000000000000000000FFFFFF1F2E0200000000000100
      0A005B456E6572675432535D00000000FFFF130054696D6573204E657720526F
      6D616E2043595200080000000000000000000A0000000000020000000000FFFF
      FF00000000000006004D656D6F3331005B020000080100004200000014000000
      03000F0001000000000000000000FFFFFF1F2E02000000000001000A005B456E
      6572675433535D00000000FFFF130054696D6573204E657720526F6D616E2043
      595200080000000000000000000A0000000000020000000000FFFFFF00000000
      000006004D656D6F3332009D02000008010000400000001400000003000F0001
      000000000000000000FFFFFF1F2E02000000000001000A005B456E6572675473
      535D00000000FFFF130054696D6573204E657720526F6D616E20435952000800
      00000000000000000A0000000000020000000000FFFFFF00000000000006004D
      656D6F3631009600000058000000C40100001200000003000000010000000000
      00000000FFFFFF1F2E02000000000001001100312E20DDEBE5EAF2F0EEFDEDE5
      F0E3E8FF00000000FFFF130054696D6573204E657720526F6D616E2043595200
      0B000000020000000000020000000000020000000000FFFFFF00000000000006
      004D656D6F36320015010000A1000000180000002800000003000F0001000000
      000000000000FFFFFF1F2E02000000000002000300D2E8EF0D0200DDED000000
      00FFFF130054696D6573204E657720526F6D616E204359520007000000000000
      0000000A0000000000020000000000FFFFFF00000000000006004D656D6F3633
      0015010000CD000000180000001900000003000F0001000000000000000000FF
      FFFF1F2E02000000000001000200412B00000000FFFF130054696D6573204E65
      7720526F6D616E2043595200080000000000000000000A000000000002000000
      0000FFFFFF00000000000006004D656D6F3634001300000008010000C8010000
      1400000003000F0001000000000000000000FFFFFF1F2E02000000000001000B
      005B4B696E64456E416C6C5D00000000FFFF130054696D6573204E657720526F
      6D616E204359520008000000020000000000090000000000020000000000FFFF
      FF00000000000006004D656D6F3635002D010000A10000005700000028000000
      03000F0001000000000000000000FFFFFF1F2E02000000000001002500CFEEEA
      E0E7E0EDE8FF20F1F7E5F2F7E8EAEEE220EDE020EDE0F7E0EBEE20EFE5F0E8EE
      E4E000000000FFFF130054696D6573204E657720526F6D616E20435952000700
      00000000000000000A0000000000020000000000FFFFFF00000000000006004D
      656D6F36360084010000CD000000570000001900000003000F00010000000000
      00000000FFFFFF1F2E02000000000001000B005B506F6B456E657267455D0000
      0000FFFF130054696D6573204E657720526F6D616E2043595200080000000000
      000000000A0000000000020000000000FFFFFF00000000FE00000000000000}
  end
  object ReportFormStyler1: TAdvFormStyler
    AutoThemeAdapt = True
    Style = tsOffice2003Olive
    Left = 649
    Top = 65535
  end
  object ReportPanelStyler: TAdvPanelStyler
    Tag = 0
    AutoThemeAdapt = True
    Settings.AnchorHint = False
    Settings.BevelInner = bvNone
    Settings.BevelOuter = bvNone
    Settings.BevelWidth = 1
    Settings.BorderColor = clGray
    Settings.BorderShadow = False
    Settings.BorderStyle = bsNone
    Settings.BorderWidth = 0
    Settings.CanMove = False
    Settings.CanSize = False
    Settings.Caption.Color = 13037543
    Settings.Caption.ColorTo = 9747893
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
    Settings.Color = 13627626
    Settings.ColorTo = 9224369
    Settings.ColorMirror = clNone
    Settings.ColorMirrorTo = clNone
    Settings.Cursor = crDefault
    Settings.Font.Charset = DEFAULT_CHARSET
    Settings.Font.Color = clWindowText
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
    Settings.StatusBar.BorderColor = clNone
    Settings.StatusBar.BorderStyle = bsSingle
    Settings.StatusBar.Font.Charset = DEFAULT_CHARSET
    Settings.StatusBar.Font.Color = clBlack
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 8433825
    Settings.StatusBar.ColorTo = 13886691
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Style = psOffice2003Olive
    Left = 624
    Top = 65528
  end
end
