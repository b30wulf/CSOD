object TL5Events: TTL5Events
  Left = 1122
  Top = 421
  Width = 798
  Height = 568
  Caption = 'События'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = OnCloseForm
  OnCreate = OnFormCreate
  OnResize = OnFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSplitter1: TAdvSplitter
    Left = 593
    Top = 29
    Width = 4
    Height = 480
    Cursor = crHSplit
    OnMoved = AdvSplitter1Moved
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = 13616833
    Appearance.ColorTo = 12958644
    Appearance.ColorHot = 13891839
    Appearance.ColorHotTo = 7782911
    GripStyle = sgDots
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 29
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
    object AdvToolBar1: TAdvToolBar
      Left = 0
      Top = 0
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
      object AdvGlowMenuButton1: TAdvGlowMenuButton
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
        DropDownMenu = AdvPopupMenu3
      end
      object AdvGlowMenuButton2: TAdvGlowMenuButton
        Left = 113
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
        DropDownMenu = AdvPopupMenu2
      end
      object AdvGlowMenuButton3: TAdvGlowMenuButton
        Left = 2
        Top = 2
        Width = 111
        Height = 25
        Caption = 'Ручной опрос'
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
        DropDownMenu = AdvPopupMenu1
      end
    end
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 509
    Width = 790
    Height = 25
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
    object Label5: TLabel
      Left = 7
      Top = 5
      Width = 139
      Height = 14
      AutoSize = False
      Caption = 'ООО Автоматизация 2000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 29
    Width = 593
    Height = 480
    Align = alLeft
    BevelOuter = bvNone
    Color = 13616833
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
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
    object FsgGrid: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 593
      Height = 480
      Cursor = crDefault
      Align = alClient
      DefaultRowHeight = 21
      RowCount = 5
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLineWidth = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing]
      ParentFont = False
      PopupMenu = PopupMenu1
      ScrollBars = ssVertical
      TabOrder = 0
      GridLineColor = 15062992
      OnGetEditorType = OnGetCellType
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
      FixedFont.Charset = RUSSIAN_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Tahoma'
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
  object AdvPanel4: TAdvPanel
    Left = 597
    Top = 29
    Width = 193
    Height = 480
    Align = alClient
    BevelOuter = bvNone
    Color = 13616833
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
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
    object dtPic2: TAdvSmoothCalendar
      Left = 158
      Top = -1
      Width = 129
      Height = 162
      Year = 2012
      Month = 5
      Fill.Color = 6050636
      Fill.ColorTo = 6050636
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.BackGroundPictureLeft = 0
      Fill.BackGroundPictureTop = 0
      Fill.PictureLeft = 0
      Fill.PictureTop = 0
      Fill.BorderColor = clNone
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Angle = 0
      DateAppearance.DateFont.Charset = DEFAULT_CHARSET
      DateAppearance.DateFont.Color = clWindowText
      DateAppearance.DateFont.Height = -11
      DateAppearance.DateFont.Name = 'Tahoma'
      DateAppearance.DateFont.Style = []
      DateAppearance.DateFill.Color = 16382200
      DateAppearance.DateFill.ColorTo = 15000287
      DateAppearance.DateFill.ColorMirror = 13749191
      DateAppearance.DateFill.ColorMirrorTo = 14868187
      DateAppearance.DateFill.GradientMirrorType = gtVertical
      DateAppearance.DateFill.BackGroundPictureLeft = 0
      DateAppearance.DateFill.BackGroundPictureTop = 0
      DateAppearance.DateFill.PictureLeft = 0
      DateAppearance.DateFill.PictureTop = 0
      DateAppearance.DateFill.BorderColor = clNone
      DateAppearance.DateFill.Rounding = 0
      DateAppearance.DateFill.ShadowOffset = 0
      DateAppearance.DateFill.Angle = 0
      DateAppearance.DayOfWeekFont.Charset = DEFAULT_CHARSET
      DateAppearance.DayOfWeekFont.Color = clWindowText
      DateAppearance.DayOfWeekFont.Height = -11
      DateAppearance.DayOfWeekFont.Name = 'Tahoma'
      DateAppearance.DayOfWeekFont.Style = []
      DateAppearance.DayOfWeekFill.Color = 14736343
      DateAppearance.DayOfWeekFill.ColorTo = 13617090
      DateAppearance.DayOfWeekFill.ColorMirror = clNone
      DateAppearance.DayOfWeekFill.ColorMirrorTo = clNone
      DateAppearance.DayOfWeekFill.BackGroundPictureLeft = 0
      DateAppearance.DayOfWeekFill.BackGroundPictureTop = 0
      DateAppearance.DayOfWeekFill.PictureLeft = 0
      DateAppearance.DayOfWeekFill.PictureTop = 0
      DateAppearance.DayOfWeekFill.BorderColor = clNone
      DateAppearance.DayOfWeekFill.Rounding = 0
      DateAppearance.DayOfWeekFill.ShadowOffset = 0
      DateAppearance.DayOfWeekFill.Angle = 0
      DateAppearance.SelectedDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.SelectedDateFont.Color = clWindowText
      DateAppearance.SelectedDateFont.Height = -11
      DateAppearance.SelectedDateFont.Name = 'Tahoma'
      DateAppearance.SelectedDateFont.Style = []
      DateAppearance.SelectedDateFill.Color = 11196927
      DateAppearance.SelectedDateFill.ColorTo = 7257087
      DateAppearance.SelectedDateFill.ColorMirror = 4370174
      DateAppearance.SelectedDateFill.ColorMirrorTo = 8053246
      DateAppearance.SelectedDateFill.GradientMirrorType = gtVertical
      DateAppearance.SelectedDateFill.BackGroundPictureLeft = 0
      DateAppearance.SelectedDateFill.BackGroundPictureTop = 0
      DateAppearance.SelectedDateFill.PictureLeft = 0
      DateAppearance.SelectedDateFill.PictureTop = 0
      DateAppearance.SelectedDateFill.BorderColor = 4370174
      DateAppearance.SelectedDateFill.Rounding = 0
      DateAppearance.SelectedDateFill.ShadowOffset = 0
      DateAppearance.SelectedDateFill.Angle = 0
      DateAppearance.CurrentDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.CurrentDateFont.Color = clWindowText
      DateAppearance.CurrentDateFont.Height = -11
      DateAppearance.CurrentDateFont.Name = 'Tahoma'
      DateAppearance.CurrentDateFont.Style = []
      DateAppearance.CurrentDateFill.Color = 7778289
      DateAppearance.CurrentDateFill.ColorTo = 4296947
      DateAppearance.CurrentDateFill.ColorMirror = 946929
      DateAppearance.CurrentDateFill.ColorMirrorTo = 5021693
      DateAppearance.CurrentDateFill.GradientMirrorType = gtVertical
      DateAppearance.CurrentDateFill.BackGroundPictureLeft = 0
      DateAppearance.CurrentDateFill.BackGroundPictureTop = 0
      DateAppearance.CurrentDateFill.PictureLeft = 0
      DateAppearance.CurrentDateFill.PictureTop = 0
      DateAppearance.CurrentDateFill.BorderColor = 4548219
      DateAppearance.CurrentDateFill.Rounding = 0
      DateAppearance.CurrentDateFill.ShadowOffset = 0
      DateAppearance.CurrentDateFill.Angle = 0
      DateAppearance.WeekendFill.Color = 16382200
      DateAppearance.WeekendFill.ColorTo = 15000287
      DateAppearance.WeekendFill.ColorMirror = 13749191
      DateAppearance.WeekendFill.ColorMirrorTo = 14868187
      DateAppearance.WeekendFill.GradientMirrorType = gtVertical
      DateAppearance.WeekendFill.BackGroundPictureLeft = 0
      DateAppearance.WeekendFill.BackGroundPictureTop = 0
      DateAppearance.WeekendFill.PictureLeft = 0
      DateAppearance.WeekendFill.PictureTop = 0
      DateAppearance.WeekendFill.BorderColor = clNone
      DateAppearance.WeekendFill.Rounding = 0
      DateAppearance.WeekendFill.ShadowOffset = 0
      DateAppearance.WeekendFill.Angle = 0
      DateAppearance.WeekendFont.Charset = DEFAULT_CHARSET
      DateAppearance.WeekendFont.Color = clBackground
      DateAppearance.WeekendFont.Height = -11
      DateAppearance.WeekendFont.Name = 'Tahoma'
      DateAppearance.WeekendFont.Style = []
      DateAppearance.HoverDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.HoverDateFont.Color = clWindowText
      DateAppearance.HoverDateFont.Height = -11
      DateAppearance.HoverDateFont.Name = 'Tahoma'
      DateAppearance.HoverDateFont.Style = []
      DateAppearance.HoverDateFill.Color = 15465983
      DateAppearance.HoverDateFill.ColorTo = 11332863
      DateAppearance.HoverDateFill.ColorMirror = 5888767
      DateAppearance.HoverDateFill.ColorMirrorTo = 10807807
      DateAppearance.HoverDateFill.GradientMirrorType = gtVertical
      DateAppearance.HoverDateFill.BackGroundPictureLeft = 0
      DateAppearance.HoverDateFill.BackGroundPictureTop = 0
      DateAppearance.HoverDateFill.PictureLeft = 0
      DateAppearance.HoverDateFill.PictureTop = 0
      DateAppearance.HoverDateFill.BorderColor = 10079963
      DateAppearance.HoverDateFill.Rounding = 0
      DateAppearance.HoverDateFill.ShadowOffset = 0
      DateAppearance.HoverDateFill.Angle = 0
      DateAppearance.MonthDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.MonthDateFont.Color = clWindowText
      DateAppearance.MonthDateFont.Height = -11
      DateAppearance.MonthDateFont.Name = 'Tahoma'
      DateAppearance.MonthDateFont.Style = []
      DateAppearance.YearDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.YearDateFont.Color = clWindowText
      DateAppearance.YearDateFont.Height = -11
      DateAppearance.YearDateFont.Name = 'Tahoma'
      DateAppearance.YearDateFont.Style = []
      DateAppearance.WeekNumbers.Font.Charset = DEFAULT_CHARSET
      DateAppearance.WeekNumbers.Font.Color = clWindowText
      DateAppearance.WeekNumbers.Font.Height = -11
      DateAppearance.WeekNumbers.Font.Name = 'Tahoma'
      DateAppearance.WeekNumbers.Font.Style = []
      DateAppearance.WeekNumbers.Fill.Color = 14736343
      DateAppearance.WeekNumbers.Fill.ColorTo = 13617090
      DateAppearance.WeekNumbers.Fill.ColorMirror = clNone
      DateAppearance.WeekNumbers.Fill.ColorMirrorTo = clNone
      DateAppearance.WeekNumbers.Fill.BackGroundPictureLeft = 0
      DateAppearance.WeekNumbers.Fill.BackGroundPictureTop = 0
      DateAppearance.WeekNumbers.Fill.PictureLeft = 0
      DateAppearance.WeekNumbers.Fill.PictureTop = 0
      DateAppearance.WeekNumbers.Fill.BorderColor = clNone
      DateAppearance.WeekNumbers.Fill.Rounding = 0
      DateAppearance.WeekNumbers.Fill.ShadowOffset = 0
      DateAppearance.WeekNumbers.Fill.Angle = 0
      DateAppearance.StartDay = Monday
      DateAppearance.DisabledDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.DisabledDateFont.Color = clGray
      DateAppearance.DisabledDateFont.Height = -11
      DateAppearance.DisabledDateFont.Name = 'Tahoma'
      DateAppearance.DisabledDateFont.Style = []
      DateAppearance.DisabledDateFill.Color = 15921906
      DateAppearance.DisabledDateFill.ColorTo = 11974326
      DateAppearance.DisabledDateFill.ColorMirror = 11974326
      DateAppearance.DisabledDateFill.ColorMirrorTo = 15921906
      DateAppearance.DisabledDateFill.GradientMirrorType = gtVertical
      DateAppearance.DisabledDateFill.BackGroundPictureLeft = 0
      DateAppearance.DisabledDateFill.BackGroundPictureTop = 0
      DateAppearance.DisabledDateFill.PictureLeft = 0
      DateAppearance.DisabledDateFill.PictureTop = 0
      DateAppearance.DisabledDateFill.BorderColor = clNone
      DateAppearance.DisabledDateFill.Rounding = 0
      DateAppearance.DisabledDateFill.ShadowOffset = 0
      DateAppearance.DisabledDateFill.Angle = 0
      DateAppearance.DateBeforeFill.Color = clNone
      DateAppearance.DateBeforeFill.ColorMirror = clNone
      DateAppearance.DateBeforeFill.ColorMirrorTo = clNone
      DateAppearance.DateBeforeFill.BackGroundPictureLeft = 0
      DateAppearance.DateBeforeFill.BackGroundPictureTop = 0
      DateAppearance.DateBeforeFill.PictureLeft = 0
      DateAppearance.DateBeforeFill.PictureTop = 0
      DateAppearance.DateBeforeFill.BorderColor = clNone
      DateAppearance.DateBeforeFill.Rounding = 0
      DateAppearance.DateBeforeFill.ShadowOffset = 0
      DateAppearance.DateBeforeFill.Angle = 0
      DateAppearance.DateAfterFill.Color = clNone
      DateAppearance.DateAfterFill.ColorMirror = clNone
      DateAppearance.DateAfterFill.ColorMirrorTo = clNone
      DateAppearance.DateAfterFill.BackGroundPictureLeft = 0
      DateAppearance.DateAfterFill.BackGroundPictureTop = 0
      DateAppearance.DateAfterFill.PictureLeft = 0
      DateAppearance.DateAfterFill.PictureTop = 0
      DateAppearance.DateAfterFill.BorderColor = clNone
      DateAppearance.DateAfterFill.Rounding = 0
      DateAppearance.DateAfterFill.ShadowOffset = 0
      DateAppearance.DateAfterFill.Angle = 0
      DateAppearance.DateBeforeFont.Charset = DEFAULT_CHARSET
      DateAppearance.DateBeforeFont.Color = clSilver
      DateAppearance.DateBeforeFont.Height = -11
      DateAppearance.DateBeforeFont.Name = 'Tahoma'
      DateAppearance.DateBeforeFont.Style = []
      DateAppearance.DateAfterFont.Charset = DEFAULT_CHARSET
      DateAppearance.DateAfterFont.Color = clSilver
      DateAppearance.DateAfterFont.Height = -11
      DateAppearance.DateAfterFont.Name = 'Tahoma'
      DateAppearance.DateAfterFont.Style = []
      StatusAppearance.Fill.Color = clRed
      StatusAppearance.Fill.ColorMirror = clNone
      StatusAppearance.Fill.ColorMirrorTo = clNone
      StatusAppearance.Fill.GradientType = gtSolid
      StatusAppearance.Fill.BackGroundPictureLeft = 0
      StatusAppearance.Fill.BackGroundPictureTop = 0
      StatusAppearance.Fill.PictureLeft = 0
      StatusAppearance.Fill.PictureTop = 0
      StatusAppearance.Fill.BorderColor = clGray
      StatusAppearance.Fill.Rounding = 0
      StatusAppearance.Fill.ShadowOffset = 0
      StatusAppearance.Fill.Angle = 0
      StatusAppearance.Font.Charset = DEFAULT_CHARSET
      StatusAppearance.Font.Color = clWhite
      StatusAppearance.Font.Height = -11
      StatusAppearance.Font.Name = 'Tahoma'
      StatusAppearance.Font.Style = []
      Header.Fill.Color = 15921648
      Header.Fill.ColorTo = 13222589
      Header.Fill.ColorMirror = clNone
      Header.Fill.ColorMirrorTo = clNone
      Header.Fill.BackGroundPictureLeft = 0
      Header.Fill.BackGroundPictureTop = 0
      Header.Fill.PictureLeft = 0
      Header.Fill.PictureTop = 0
      Header.Fill.BorderColor = 6050636
      Header.Fill.Rounding = 0
      Header.Fill.ShadowOffset = 0
      Header.Fill.Angle = 0
      Header.ArrowColor = 4406327
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = 4406327
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Footer.Fill.Color = 15921648
      Footer.Fill.ColorTo = 13222589
      Footer.Fill.ColorMirror = clNone
      Footer.Fill.ColorMirrorTo = clNone
      Footer.Fill.BackGroundPictureLeft = 0
      Footer.Fill.BackGroundPictureTop = 0
      Footer.Fill.PictureLeft = 0
      Footer.Fill.PictureTop = 0
      Footer.Fill.BorderColor = 6050636
      Footer.Fill.Rounding = 0
      Footer.Fill.ShadowOffset = 0
      Footer.Fill.Angle = 0
      Footer.Font.Charset = DEFAULT_CHARSET
      Footer.Font.Color = 4406327
      Footer.Font.Height = -11
      Footer.Font.Name = 'Tahoma'
      Footer.Font.Style = []
      Version = '1.6.0.2'
      TabOrder = 0
      OnClick = OnChandgeTime
    end
    object EventCheckList: TParamCheckList
      Left = 0
      Top = 192
      Width = 297
      Height = 293
      AdvanceOnReturn = False
      EmptyParam = '?'
      ParamHint = False
      ParamListSorted = False
      SelectionColor = clHighlight
      SelectionFontColor = clHighlightText
      ShadowColor = clGray
      ShadowOffset = 1
      ShowSelection = True
      Duplicates = True
      ItemHeight = 16
      TabOrder = 1
      OnCheckClick = EventCheckListCheckClick
      Version = '1.3.3.0'
    end
    object dtPic1: TAdvSmoothCalendar
      Left = 0
      Top = -1
      Width = 137
      Height = 162
      Year = 2012
      Month = 5
      Fill.Color = 6050636
      Fill.ColorTo = 6050636
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.BackGroundPictureLeft = 0
      Fill.BackGroundPictureTop = 0
      Fill.PictureLeft = 0
      Fill.PictureTop = 0
      Fill.BorderColor = clNone
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Angle = 0
      DateAppearance.DateFont.Charset = DEFAULT_CHARSET
      DateAppearance.DateFont.Color = clWindowText
      DateAppearance.DateFont.Height = -11
      DateAppearance.DateFont.Name = 'Tahoma'
      DateAppearance.DateFont.Style = []
      DateAppearance.DateFill.Color = 16382200
      DateAppearance.DateFill.ColorTo = 15000287
      DateAppearance.DateFill.ColorMirror = 13749191
      DateAppearance.DateFill.ColorMirrorTo = 14868187
      DateAppearance.DateFill.GradientMirrorType = gtVertical
      DateAppearance.DateFill.BackGroundPictureLeft = 0
      DateAppearance.DateFill.BackGroundPictureTop = 0
      DateAppearance.DateFill.PictureLeft = 0
      DateAppearance.DateFill.PictureTop = 0
      DateAppearance.DateFill.BorderColor = clNone
      DateAppearance.DateFill.Rounding = 0
      DateAppearance.DateFill.ShadowOffset = 0
      DateAppearance.DateFill.Angle = 0
      DateAppearance.DayOfWeekFont.Charset = DEFAULT_CHARSET
      DateAppearance.DayOfWeekFont.Color = clWindowText
      DateAppearance.DayOfWeekFont.Height = -11
      DateAppearance.DayOfWeekFont.Name = 'Tahoma'
      DateAppearance.DayOfWeekFont.Style = []
      DateAppearance.DayOfWeekFill.Color = 14736343
      DateAppearance.DayOfWeekFill.ColorTo = 13617090
      DateAppearance.DayOfWeekFill.ColorMirror = clNone
      DateAppearance.DayOfWeekFill.ColorMirrorTo = clNone
      DateAppearance.DayOfWeekFill.BackGroundPictureLeft = 0
      DateAppearance.DayOfWeekFill.BackGroundPictureTop = 0
      DateAppearance.DayOfWeekFill.PictureLeft = 0
      DateAppearance.DayOfWeekFill.PictureTop = 0
      DateAppearance.DayOfWeekFill.BorderColor = clNone
      DateAppearance.DayOfWeekFill.Rounding = 0
      DateAppearance.DayOfWeekFill.ShadowOffset = 0
      DateAppearance.DayOfWeekFill.Angle = 0
      DateAppearance.SelectedDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.SelectedDateFont.Color = clWindowText
      DateAppearance.SelectedDateFont.Height = -11
      DateAppearance.SelectedDateFont.Name = 'Tahoma'
      DateAppearance.SelectedDateFont.Style = []
      DateAppearance.SelectedDateFill.Color = 11196927
      DateAppearance.SelectedDateFill.ColorTo = 7257087
      DateAppearance.SelectedDateFill.ColorMirror = 4370174
      DateAppearance.SelectedDateFill.ColorMirrorTo = 8053246
      DateAppearance.SelectedDateFill.GradientMirrorType = gtVertical
      DateAppearance.SelectedDateFill.BackGroundPictureLeft = 0
      DateAppearance.SelectedDateFill.BackGroundPictureTop = 0
      DateAppearance.SelectedDateFill.PictureLeft = 0
      DateAppearance.SelectedDateFill.PictureTop = 0
      DateAppearance.SelectedDateFill.BorderColor = 4370174
      DateAppearance.SelectedDateFill.Rounding = 0
      DateAppearance.SelectedDateFill.ShadowOffset = 0
      DateAppearance.SelectedDateFill.Angle = 0
      DateAppearance.CurrentDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.CurrentDateFont.Color = clWindowText
      DateAppearance.CurrentDateFont.Height = -11
      DateAppearance.CurrentDateFont.Name = 'Tahoma'
      DateAppearance.CurrentDateFont.Style = []
      DateAppearance.CurrentDateFill.Color = 7778289
      DateAppearance.CurrentDateFill.ColorTo = 4296947
      DateAppearance.CurrentDateFill.ColorMirror = 946929
      DateAppearance.CurrentDateFill.ColorMirrorTo = 5021693
      DateAppearance.CurrentDateFill.GradientMirrorType = gtVertical
      DateAppearance.CurrentDateFill.BackGroundPictureLeft = 0
      DateAppearance.CurrentDateFill.BackGroundPictureTop = 0
      DateAppearance.CurrentDateFill.PictureLeft = 0
      DateAppearance.CurrentDateFill.PictureTop = 0
      DateAppearance.CurrentDateFill.BorderColor = 4548219
      DateAppearance.CurrentDateFill.Rounding = 0
      DateAppearance.CurrentDateFill.ShadowOffset = 0
      DateAppearance.CurrentDateFill.Angle = 0
      DateAppearance.WeekendFill.Color = 16382200
      DateAppearance.WeekendFill.ColorTo = 15000287
      DateAppearance.WeekendFill.ColorMirror = 13749191
      DateAppearance.WeekendFill.ColorMirrorTo = 14868187
      DateAppearance.WeekendFill.GradientMirrorType = gtVertical
      DateAppearance.WeekendFill.BackGroundPictureLeft = 0
      DateAppearance.WeekendFill.BackGroundPictureTop = 0
      DateAppearance.WeekendFill.PictureLeft = 0
      DateAppearance.WeekendFill.PictureTop = 0
      DateAppearance.WeekendFill.BorderColor = clNone
      DateAppearance.WeekendFill.Rounding = 0
      DateAppearance.WeekendFill.ShadowOffset = 0
      DateAppearance.WeekendFill.Angle = 0
      DateAppearance.WeekendFont.Charset = DEFAULT_CHARSET
      DateAppearance.WeekendFont.Color = clBackground
      DateAppearance.WeekendFont.Height = -11
      DateAppearance.WeekendFont.Name = 'Tahoma'
      DateAppearance.WeekendFont.Style = []
      DateAppearance.HoverDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.HoverDateFont.Color = clWindowText
      DateAppearance.HoverDateFont.Height = -11
      DateAppearance.HoverDateFont.Name = 'Tahoma'
      DateAppearance.HoverDateFont.Style = []
      DateAppearance.HoverDateFill.Color = 15465983
      DateAppearance.HoverDateFill.ColorTo = 11332863
      DateAppearance.HoverDateFill.ColorMirror = 5888767
      DateAppearance.HoverDateFill.ColorMirrorTo = 10807807
      DateAppearance.HoverDateFill.GradientMirrorType = gtVertical
      DateAppearance.HoverDateFill.BackGroundPictureLeft = 0
      DateAppearance.HoverDateFill.BackGroundPictureTop = 0
      DateAppearance.HoverDateFill.PictureLeft = 0
      DateAppearance.HoverDateFill.PictureTop = 0
      DateAppearance.HoverDateFill.BorderColor = 10079963
      DateAppearance.HoverDateFill.Rounding = 0
      DateAppearance.HoverDateFill.ShadowOffset = 0
      DateAppearance.HoverDateFill.Angle = 0
      DateAppearance.MonthDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.MonthDateFont.Color = clWindowText
      DateAppearance.MonthDateFont.Height = -11
      DateAppearance.MonthDateFont.Name = 'Tahoma'
      DateAppearance.MonthDateFont.Style = []
      DateAppearance.YearDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.YearDateFont.Color = clWindowText
      DateAppearance.YearDateFont.Height = -11
      DateAppearance.YearDateFont.Name = 'Tahoma'
      DateAppearance.YearDateFont.Style = []
      DateAppearance.WeekNumbers.Font.Charset = DEFAULT_CHARSET
      DateAppearance.WeekNumbers.Font.Color = clWindowText
      DateAppearance.WeekNumbers.Font.Height = -11
      DateAppearance.WeekNumbers.Font.Name = 'Tahoma'
      DateAppearance.WeekNumbers.Font.Style = []
      DateAppearance.WeekNumbers.Fill.Color = 14736343
      DateAppearance.WeekNumbers.Fill.ColorTo = 13617090
      DateAppearance.WeekNumbers.Fill.ColorMirror = clNone
      DateAppearance.WeekNumbers.Fill.ColorMirrorTo = clNone
      DateAppearance.WeekNumbers.Fill.BackGroundPictureLeft = 0
      DateAppearance.WeekNumbers.Fill.BackGroundPictureTop = 0
      DateAppearance.WeekNumbers.Fill.PictureLeft = 0
      DateAppearance.WeekNumbers.Fill.PictureTop = 0
      DateAppearance.WeekNumbers.Fill.BorderColor = clNone
      DateAppearance.WeekNumbers.Fill.Rounding = 0
      DateAppearance.WeekNumbers.Fill.ShadowOffset = 0
      DateAppearance.WeekNumbers.Fill.Angle = 0
      DateAppearance.StartDay = Monday
      DateAppearance.DisabledDateFont.Charset = DEFAULT_CHARSET
      DateAppearance.DisabledDateFont.Color = clGray
      DateAppearance.DisabledDateFont.Height = -11
      DateAppearance.DisabledDateFont.Name = 'Tahoma'
      DateAppearance.DisabledDateFont.Style = []
      DateAppearance.DisabledDateFill.Color = 15921906
      DateAppearance.DisabledDateFill.ColorTo = 11974326
      DateAppearance.DisabledDateFill.ColorMirror = 11974326
      DateAppearance.DisabledDateFill.ColorMirrorTo = 15921906
      DateAppearance.DisabledDateFill.GradientMirrorType = gtVertical
      DateAppearance.DisabledDateFill.BackGroundPictureLeft = 0
      DateAppearance.DisabledDateFill.BackGroundPictureTop = 0
      DateAppearance.DisabledDateFill.PictureLeft = 0
      DateAppearance.DisabledDateFill.PictureTop = 0
      DateAppearance.DisabledDateFill.BorderColor = clNone
      DateAppearance.DisabledDateFill.Rounding = 0
      DateAppearance.DisabledDateFill.ShadowOffset = 0
      DateAppearance.DisabledDateFill.Angle = 0
      DateAppearance.DateBeforeFill.Color = clNone
      DateAppearance.DateBeforeFill.ColorMirror = clNone
      DateAppearance.DateBeforeFill.ColorMirrorTo = clNone
      DateAppearance.DateBeforeFill.BackGroundPictureLeft = 0
      DateAppearance.DateBeforeFill.BackGroundPictureTop = 0
      DateAppearance.DateBeforeFill.PictureLeft = 0
      DateAppearance.DateBeforeFill.PictureTop = 0
      DateAppearance.DateBeforeFill.BorderColor = clNone
      DateAppearance.DateBeforeFill.Rounding = 0
      DateAppearance.DateBeforeFill.ShadowOffset = 0
      DateAppearance.DateBeforeFill.Angle = 0
      DateAppearance.DateAfterFill.Color = clNone
      DateAppearance.DateAfterFill.ColorMirror = clNone
      DateAppearance.DateAfterFill.ColorMirrorTo = clNone
      DateAppearance.DateAfterFill.BackGroundPictureLeft = 0
      DateAppearance.DateAfterFill.BackGroundPictureTop = 0
      DateAppearance.DateAfterFill.PictureLeft = 0
      DateAppearance.DateAfterFill.PictureTop = 0
      DateAppearance.DateAfterFill.BorderColor = clNone
      DateAppearance.DateAfterFill.Rounding = 0
      DateAppearance.DateAfterFill.ShadowOffset = 0
      DateAppearance.DateAfterFill.Angle = 0
      DateAppearance.DateBeforeFont.Charset = DEFAULT_CHARSET
      DateAppearance.DateBeforeFont.Color = clSilver
      DateAppearance.DateBeforeFont.Height = -11
      DateAppearance.DateBeforeFont.Name = 'Tahoma'
      DateAppearance.DateBeforeFont.Style = []
      DateAppearance.DateAfterFont.Charset = DEFAULT_CHARSET
      DateAppearance.DateAfterFont.Color = clSilver
      DateAppearance.DateAfterFont.Height = -11
      DateAppearance.DateAfterFont.Name = 'Tahoma'
      DateAppearance.DateAfterFont.Style = []
      StatusAppearance.Fill.Color = clRed
      StatusAppearance.Fill.ColorMirror = clNone
      StatusAppearance.Fill.ColorMirrorTo = clNone
      StatusAppearance.Fill.GradientType = gtSolid
      StatusAppearance.Fill.BackGroundPictureLeft = 0
      StatusAppearance.Fill.BackGroundPictureTop = 0
      StatusAppearance.Fill.PictureLeft = 0
      StatusAppearance.Fill.PictureTop = 0
      StatusAppearance.Fill.BorderColor = clGray
      StatusAppearance.Fill.Rounding = 0
      StatusAppearance.Fill.ShadowOffset = 0
      StatusAppearance.Fill.Angle = 0
      StatusAppearance.Font.Charset = DEFAULT_CHARSET
      StatusAppearance.Font.Color = clWhite
      StatusAppearance.Font.Height = -11
      StatusAppearance.Font.Name = 'Tahoma'
      StatusAppearance.Font.Style = []
      Header.Fill.Color = 15921648
      Header.Fill.ColorTo = 13222589
      Header.Fill.ColorMirror = clNone
      Header.Fill.ColorMirrorTo = clNone
      Header.Fill.BackGroundPictureLeft = 0
      Header.Fill.BackGroundPictureTop = 0
      Header.Fill.PictureLeft = 0
      Header.Fill.PictureTop = 0
      Header.Fill.BorderColor = 6050636
      Header.Fill.Rounding = 0
      Header.Fill.ShadowOffset = 0
      Header.Fill.Angle = 0
      Header.ArrowColor = 4406327
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = 4406327
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Footer.Fill.Color = 15921648
      Footer.Fill.ColorTo = 13222589
      Footer.Fill.ColorMirror = clNone
      Footer.Fill.ColorMirrorTo = clNone
      Footer.Fill.BackGroundPictureLeft = 0
      Footer.Fill.BackGroundPictureTop = 0
      Footer.Fill.PictureLeft = 0
      Footer.Fill.PictureTop = 0
      Footer.Fill.BorderColor = 6050636
      Footer.Fill.Rounding = 0
      Footer.Fill.ShadowOffset = 0
      Footer.Fill.Angle = 0
      Footer.Font.Charset = DEFAULT_CHARSET
      Footer.Font.Color = 4406327
      Footer.Font.Height = -11
      Footer.Font.Name = 'Tahoma'
      Footer.Font.Style = []
      Version = '1.6.0.2'
      TabOrder = 2
      OnClick = OnChandgeTime1
    end
    object rbJrnlNumb: TAdvOfficeRadioGroup
      Left = 8
      Top = 160
      Width = 313
      Height = 35
      Version = '1.1.1.4'
      ParentCtl3D = True
      TabOrder = 3
      OnClick = rbJrnlNumbClick
      Ellipsis = False
      Columns = 4
      Items.Strings = (
        'УСПД'
        'Связь'
        'Счетчик'
        'АРМ')
    end
  end
  object ImageListEvent1: TImageList
    Left = 397
    Top = 178
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
      00000000000000000000000000000000000000000000FDFDFD00FCFCFC00FBFB
      FB00F9F9F900F7F7F700F9F9F900FBFBFB00FAFAFA00F8F8F800F8F8F800FAFA
      FA00FCFCFC00FDFDFD00FEFEFE000000000000000000FCFCFC009E9E9E008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840088888800E3E3E3000000000000000000FCFCFC009E9E9E008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840088888800E3E3E300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F0F0F000E4E4E400D6D6
      D600D9D9D9008E676300A2321700C0371100BB31100098382700A2949300DDDD
      DD00DDDDDD00EBEBEB00F7F7F7000000000000000000F3F3F300CFCFCF00E6E3
      E100DAD9D900D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800DDDDDD00C3C3C3000000000000000000F3F3F300CFCFCF00E0E2
      E600D9D9DA00D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800DDDDDD00C3C3C300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D8AB
      A600DA541B00E1602400D94F1F00D7441800D23E1A00D43B1C00EF4B2500C830
      1200F8F2F10000000000000000000000000000000000F3F3F300D2D1D100FEF5
      EC00F1EBE400D3D3D300D4D4D400EDEDED00D7D7D700DADADA00D3D3D300D3D3
      D300D3D3D300D6D6D600C1C1C1000000000000000000EBEBEB008CA5A10087A6
      AD00B7CDD400CAD0CF00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D6D6D600C1C1C100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C87E7500E671
      2800E0652300DE602300C24D2900AEA8A900AF7B7100D53C1600D0371900CF30
      1800E43F1F00F6E9E700000000000000000000000000F3F3F300D1D1D100FEF5
      EC00F1EBE400D1D1D100FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4F400D7BF
      A600DB8E4200D3863B0094897C00E9E9E900FBFBFB0013514400004035000056
      4C0000483D000D4A3C00BCC9C700D3D3D300D3D3D300D3D3D300D3D3D300A9B4
      CD00406BC0003964B8007F818E00EAEAEA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EACECB00E97A2800E46F
      2500E16A2400E2642000B79A9500B9B2B300C4462000B6837800D4401B00D038
      1900CC2E1700D2361800000000000000000000000000F3F3F300D1D1D000FEF5
      EC00F0EAE400EFEFEF00FFFFFF00F9F9F900CECECE00D3D3D300F7E4CF00D684
      3400D4873C00D17F2F00D2803000958D8300CED4D30000514300006153000535
      2900016B5D000060580006594D00D3D3D300D3D3D300D3D3D300B0B9CD003060
      BA002B5BB5002B5BB5002C5CB600878992000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C1511A00EB832A00E671
      2500E36D2400E1682400BE6B5100C8D0D200D1471500BD8D8200C2482A00D23F
      1A00D0381900E2402000C98175000000000000000000F3F3F300D0D0D000FEF5
      EC00EFE9E300E9E9E900FFFFFF00DBDBDB00D3D3D300D3D3D300EEA66000D684
      3400E7B78800F0D0B100D6843400CB894800C1CCCA0000847400004A3B00C9DC
      E6009EC1C6000051440000574A00D3D3D300D3D3D300D3D3D3005F89D80087A3
      D7008BA7D800A5BAE1007B9AD400476BB3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F0F000F2A23400ED8E2C00E97D
      2800E56E2400E36A2300D5531400D5DDDF00C0766200D94E1800C54F2C00D445
      1B00D23E1A00CE351800CA3815000000000000000000F3F3F300D4D4D400FEF6
      ED00F0EAE400C9C9C900FAFAFA00EAEAEA00D7D7D700D7D7D700F8C28E00E492
      4200F5D5B700F5D5B600E4924200D1935500F4F4F400077E7100005E53000070
      6000005A4E000052450001665B00C3D1D000C7D3D100D7D7D70080A7EF007C9C
      DA004E7ACD0095AFE100CEDAF1005877B9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D8A39E00F9AE3700F0962E00ED8E
      2C00EB7C2400C16F5300E8651B00D4CBCD00D7D4D700DD531900D7501E00D54A
      1C00D3431B00D03B1900E04C22000000000000000000F3F3F300DADAD900FFF7
      F000F2ECE700C9C9C900EDEDED00ECECEC00DEDEDE00D8D8D800FEFAF500EEA0
      5300E7954500E7954500F3A35300C9C7C50000000000CAD6D50012ADA000007A
      6C0000574900005F540000817300006F5F00007666000D675900D7DAE1004D7D
      D6004171CB004171CB004F7FD900C5C6C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CA817800FBB33900F29E3000F096
      2E00EF902D00D6A08D00C95E3300C8785F00EEF6F800CE481400D9531E00D74E
      1D00D4481B00D2411A00DD4D20000000000000000000F3F3F300E0E0E000FFF8
      F300F3EEEA00E9E9E900F5F5F500F8F8F800E5E5E500E5E5E500E3E3E300FCF9
      F700F8D4B100F7CFA800B8B7B500FEFEFE0000000000F3F3F300DEDFDF00E5EE
      F700DCE3E900009A8A00009B8C0012726A00069C8C0000766A008CB7B100E1E3
      E600A8C3F3009EBBF200B5B5B700FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D8A29E00FFC44000F5A43100F29E
      3000F0962E00EE882100F0E6E900CB4A0200FFFFFF00CA613D00DB551E00D850
      1D00D64B1C00D3441B00D74C1D000000000000000000F3F3F300E4E4E400FFFA
      F600F3F0ED00E5E5E500E7E7E700EDEDED00F5F5F500F7F7F700FFFFFF00E9E9
      E900EAEAEA00EAEAEA00C2C2C2000000000000000000F3F3F300E4E4E400F4F8
      FF00EBEFF30000B4A500009D9300164333000062540000675E0094BDB700EAEA
      EA00EAEAEA00EAEAEA00C2C2C200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F0F000FBD24A00F8AB3300F5A4
      3100F29E3000F0962E00E77E1C00E6C2B900E8C3BA00E36F1E00E36F2500E066
      2300DC5C2100D9521F00C03D13000000000000000000F3F3F300E6E6E600FFFB
      F800F4F1EE00EDEDED00EDEDED00EDEDED00E6E6E600DADADA00DEDDDD00E7E6
      E500E7E6E500E5E4E300CBCBCB000000000000000000F3F3F300E6E6E600F6F9
      FF00EDEFF40081CFC90000A5950000726700005B500025675A00E8E9E900E5E6
      E700E5E6E700E3E3E500CBCBCB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C66E2B00FBB33400F8AC
      3300F5A43100F29E3000F1972F00D6773900E1C6BE00D8672000E5772700E26E
      2500E0672300E3652500CA8176000000000000000000F3F3F300E6E6E600FFFB
      F800F3F0EE00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00F7A45400F6A3
      5300F6A35300B1917100F9F9F9000000000000000000F3F3F300E6E6E600F6F9
      FF00EDEEF300EDEDED00E0E8E800C1D7D400D5DEDD00EDEDED005180DA00507F
      D900507FD9007583A300F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EACDCC00FCE45600FAB1
      3400F8AC3300F5A43100F59F2B00EAD4D400F7F5F500E9D7D700EB802800E577
      2700E26E2500C5471500000000000000000000000000F3F3F300E5E5E500FFFB
      F800F2EFED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00FEB06600FDAD
      6000B4947500F8F8F800000000000000000000000000F3F3F300E5E5E500F6F9
      FF00ECEEF200EDEDED00EDEDED00EDEDED00EDEDED00EDEDED005E8DE7005A89
      E3007987A600F8F8F80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C87C7600FFEA
      5700FAB13300F8AC3300F6A53200DB7D3200F3E6EA00D5825900EC872B00E97E
      2900D5601E00F5E8E700000000000000000000000000F3F3F300E6E6E600FFFB
      F800EFEAE600EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00FFD7B200B6A1
      8C00F8F8F80000000000000000000000000000000000F3F3F300E6E6E600F6F9
      FF00E5E8EE00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00A6C4FC008B97
      B200F8F8F8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DBAA
      A800E3AB3F00FFD34600F9AD3300F6A43100F39A2700F49A3000F39D3200BC48
      1800FAF3F30000000000000000000000000000000000F7F7F700E4E4E400E6E6
      E600E9E9E900EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00B8A69500F8F8
      F80000000000FAFAFA00FCFCFC000000000000000000F7F7F700E4E4E400E6E6
      E600E9E9E900EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00949DB300F8F8
      F80000000000FAFAFA00FCFCFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D4989400BE603900C96E2D00C5622900BD5D4400EACDCB000000
      0000000000000000000000000000000000000000000000000000FAFAFA00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FCFCFC000000
      0000000000000000000000000000000000000000000000000000FAFAFA00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00BDBDB5009C8C73009484
      7300ADADA500FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEDEDE00A59C9C00A59C
      9400D6D6D600FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEF700DEDE
      F700DEDEF700F7F7FF00000000000000000000000000FFFFFF009C9C9C008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008C8C8C00E7E7E700000000000000000000000000D6944A00D694
      5200D6945200D6945200D6945200CE945200CEC6AD00EFC6B500E7734200E77B
      4A00EFCEC600B5A58C00E7E7E700000000000000000000000000D6944A00D694
      5200D6945200D6945200D6945200D6945200C6B5A500EFD6CE00E78C6300E78C
      6300EFDED600A59C9400F7F7F70000000000FFFFFF00F7F7F700EFEFEF00E7E7
      E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7E7E7006B6BC6001010C6001010
      C6001010C6001818B500F7F7FF000000000000000000F7F7F700CECECE00E7E7
      E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00C6C6C600000000000000000000000000DEA56300E7AD
      7300E7AD7300E7AD7300E7AD7300DED6C600E76B3900EF520800DE9C5A00D66B
      1800E7520800E77B5200B5A58C00FFFFFF000000000000000000DEA56300E7AD
      7300E7AD7300E7AD7300DEAD7300DECEBD00E77B5200F7F7F700EFF7F700E763
      2900E7520800E78C6300A59C9400FFFFFF006B6B6B0073737300848484008C8C
      8C009494940094949400949494008C8C8C00393994000000CE000000CE000000
      D6000000CE000000CE001010B500F7F7FF0000000000F7F7F700D6D6D600FFF7
      EF00F7EFE700D6D6D600D6D6D600EFEFEF00D6D6D600DEDEDE00D6D6D600D6D6
      D600D6D6D600D6D6D600C6C6C600000000000000000000000000E7B57B00EFBD
      8C00EFBD8C00EFBD8C00DEAD7300E7BDAD00EF6B1800EF6B1800D6843900DE73
      2100EF6B1800E76B1800EFD6CE00C6C6BD000000000000000000E7B57B00EFBD
      8C00EFBD8C00EFBD8C00DEB58400E7CEBD00EF6B1800F7F7EF00FF7B2100F77B
      2900F7732100EF6B1800EFDED600DEDEDE00525252007373730094949400BDBD
      BD00DEDEDE00F7F7F700DEDEDE00BDBDBD000808D6000000DE000000DE000000
      DE000000DE000000DE000000D600A5A5E70000000000F7F7F700D6D6D600FFF7
      EF00F7EFE700D6D6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700D6BD
      A500DE8C4200D6843900948C7B00EFEFEF000000000000000000EFC68C00F7CE
      A500F7D6A500F7D6A500E7C69C00E7844200EF843100F7843100E79C5A00D6A5
      7300EF843100EF843100EF9C6B00A59484000000000000000000EFC68C00F7CE
      A500F7D6A500F7D6A500E7CEAD00E78C4A00E79C6300FFFFFF00FF943900FF94
      3900DEB59C00F78C3100E7A57300A5A59C00636363008C8C8C00A5A5A500BDBD
      BD00E7E7E700F7F7F700DEDEDE00C6C6C6000808E700ADADFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000E700A5A5E70000000000F7F7F700D6D6D600FFF7
      EF00F7EFE700EFEFEF00FFFFFF00FFFFFF00CECECE00D6D6D600F7E7CE00D684
      3100D6843900D67B2900D6843100948C84000000000000000000F7D6A500FFE7
      BD00FFE7BD00FFE7BD00E7CEA500E78C4A00F79C4200F79C4200FFC69400EFCE
      A500CE9C6300EF944200EF9C7300AD9C8C000000000000000000F7D6A500FFE7
      BD00FFE7BD00FFE7BD00EFDEBD00E7945200FFAD4A00F7E7D600FFAD5200FFAD
      5200FFFFFF00DEBD9400EFA57300ADA5A500636363008C8C8C00A5A5A500BDBD
      BD00EFEFEF00F7F7F700DEDEDE00C6C6C6003131F7001010F7000000FF000000
      FF000000FF000808F7002929F700A5A5E70000000000F7F7F700D6D6D600FFF7
      EF00EFEFE700EFEFEF00FFFFFF00DEDEDE00D6D6D600D6D6D600EFA56300D684
      3100E7B58C00F7D6B500D6843100CE8C4A000000000000000000FFDEB500FFEF
      CE00FFEFD600FFEFD600EFD6AD00DEB5A500F7A54A00EFE7D600F7AD5200EFA5
      4A00DECEBD00EFA54A00F7DED600EFE7E7000000000000000000FFDEB500FFEF
      CE00FFEFD600FFEFD600F7E7C600CEB59C00FFB55A00FFD69C00FFBD7300FFBD
      6B00F7EFDE00F7B56300F7DECE00E7E7E700525252007B7B7B009C9C9C00B5B5
      B500C6C6C600CECECE00C6C6C600B5B5B5004A4AB5005252FF005252FF005A5A
      FF005252FF004A4AFF005A5AFF00FFFFFF0000000000F7F7F700D6D6D600FFF7
      EF00F7EFE700CECECE00FFFFFF00EFEFEF00D6D6D600D6D6D600FFC68C00E794
      4200F7D6B500F7D6B500E7944200D69452000000000000000000FFE7BD00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00F7E7D600E7945200EFAD5A00FFF7EF00FFF7
      EF00EFAD5200EF9C6B00DECEB500000000000000000000000000FFE7BD00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00F7EFE700EFA56300FFB55A00F7C68C00EFF7
      F700FFFFFF00E7A56B00D6CEC60000000000525252007B7B7B009C9C9C00BDBD
      BD00E7E7E700FFFFFF00E7E7E700C6C6C600A5A5A5004242AD00A5A5FF009C9C
      FF009C9CFF008484FF00000000000000000000000000F7F7F700DEDEDE00FFF7
      F700F7EFE700CECECE00EFEFEF00EFEFEF00DEDEDE00DEDEDE00FFFFF700EFA5
      5200E7944200E7944200F7A55200CEC6C6000000000000000000FFE7C600FFF7
      DE00FFFFE700FFFFE700FFFFE700FFF7E700F7E7D600DEBDAD00EF9C6300EF9C
      6300EFD6C600E7D6BD00FFFFFF00000000000000000000000000FFE7C600FFF7
      DE00FFFFE700FFFFE700FFFFE700FFF7E700F7F7EF00D6B59C00E7A55A00E7A5
      5A00DEC6B500E7D6CE00FFFFFF00000000006363630094949400ADADAD00C6C6
      C600EFEFEF00FFFFFF00E7E7E700CECECE00B5B5B5009494940063636B00F7F7
      FF00EFEFF70000000000000000000000000000000000F7F7F700E7E7E700FFFF
      F700F7EFEF00EFEFEF00F7F7F700FFFFFF00E7E7E700E7E7E700E7E7E700FFFF
      F700FFD6B500F7CEAD00BDB5B500FFFFFF000000000000000000FFE7C600FFFF
      E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00F7E7C600E7D6B500EFD6
      B500F7DEBD00F7EFE70000000000000000000000000000000000FFE7C600FFFF
      E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00F7EFD600F7EFD600F7EF
      D600F7E7CE00F7EFE70000000000000000006363630094949400ADADAD00C6C6
      C600F7F7F700FFFFFF00E7E7E700CECECE00B5B5B500949494006B6B6B000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700FFFF
      F700F7F7EF00E7E7E700E7E7E700EFEFEF00F7F7F700F7F7F700FFFFFF00EFEF
      EF00EFEFEF00EFEFEF00C6C6C600000000000000000000000000FFEFCE00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFF7E700F7EFE70000000000000000000000000000000000FFEFCE00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFF7E700F7EFE7000000000000000000525252007B7B7B0094949400ADAD
      AD00C6C6C600CECECE00C6C6C600ADADAD009C9C9C007B7B7B005A5A5A000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700FFFF
      FF00F7F7EF00EFEFEF00EFEFEF00EFEFEF00E7E7E700DEDEDE00DEDEDE00E7E7
      E700E7E7E700E7E7E700CECECE00000000000000000000000000FFEFCE00FFFF
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700F7F7
      E700F7EFDE00EFE7DE00FFFFFF00000000000000000000000000FFEFCE00FFFF
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700F7F7
      E700F7EFDE00EFE7DE00FFFFFF00000000006363630094949400B5B5B500D6D6
      D600F7F7F700FFFFFF00F7F7F700D6D6D600B5B5B5008C8C8C00636363000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700FFFF
      FF00F7F7EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00F7A55200F7A5
      5200F7A55200B5947300FFFFFF00000000000000000000000000FFEFD600FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700EFE7D600CEBDA500CEBD
      A500DECEB500E7E7D600FFFFFF00000000000000000000000000FFEFD600FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700EFE7D600CEBDA500CEBD
      A500DECEB500E7E7D600FFFFFF00000000007B7B7B00ADADAD00CECECE00E7E7
      E700F7F7F700FFFFFF00F7F7F700DEDEDE00C6C6C600A5A5A500737373000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700FFFF
      FF00F7EFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00FFB56300FFAD
      6300B5947300FFFFFF0000000000000000000000000000000000FFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DED6C600F7CE9C00D6B5
      7B00C6A57300FFFFF70000000000000000000000000000000000FFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DED6C600F7CE9C00D6B5
      7B00C6A57300FFFFF700000000000000000084848400B5B5B500CECECE00E7E7
      E700FFFFFF00FFFFFF00F7F7F700DEDEDE00C6C6C600ADADAD00848484000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700FFFF
      FF00EFEFE700EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00FFD6B500B5A5
      8C00FFFFFF000000000000000000000000000000000000000000FFE7D600FFF7
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00E7DECE00FFEFCE00D6BD
      8C00F7F7EF00FFFFFF0000000000000000000000000000000000FFE7D600FFF7
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00E7DECE00FFEFCE00D6BD
      8C00F7F7EF00FFFFFF000000000000000000C6C6C600DEDEDE00EFEFEF00F7F7
      F700FFFFFF00FFFFFF00FFFFFF00F7F7F700E7E7E700D6D6D600C6C6C6000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700E7E7
      E700EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00BDA59400FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000EFDEBD00EFDE
      BD00EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600E7D6BD00D6BD8C00F7F7
      F700FFFFFF000000000000000000000000000000000000000000EFDEBD00EFDE
      BD00EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600E7D6BD00D6BD8C00F7F7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FFFFFF000000
      00000000000000000000000000000000000000000000EFEFEF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600CECECE00FFFFFF000000000000000000EFEFEF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600CECECE00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7EF00F7DEC600F7C6
      8C00FFD6AD00FFFFFF00000000000000000000000000C69C8C00FFDED600FFD6
      D600FFD6CE00FFD6CE00FFCEC600FFCEC600FFC6BD00FFC6B500FFBDB500FFBD
      AD00FFB5AD0084636300FFFFFF000000000000000000C69C8C00FFDED600FFD6
      D600FFD6CE00FFD6CE00FFCEC600FFCEC600FFC6BD00FFC6B500FFBDB500FFBD
      AD00FFB5AD0084636300FFFFFF000000000000000000C6C6C600E7E7E700EFEF
      EF00F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00DEDE
      DE00EFEFEF00EFEFEF00DEDEDE00000000000000000000000000D6944A00D694
      5200D6945200D6945200D6945200D6945200DE944A007B420800BD6B0000DE8C
      0800DE840000EFC69400FFE7CE000000000000000000C69C8C00FFEFE700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEBD00FFDE
      BD00FFD6B50084636300FFFFFF000000000000000000C69C8C00FFEFE700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEBD00FFDE
      BD00FFD6B50084636300FFFFFF000000000000000000BDBDCE0052527300B5B5
      B500ADADAD00ADADAD00ADADAD00B5B5B500B5B5B500B5B5B50073737300BDBD
      BD009C9C9C00BDBDDE009C9CA500000000000000000000000000DEA56300E7AD
      7300E7AD7300E7AD7300E7AD7300E7AD7300BD6B0000CE730000EF940000EF94
      0000EF940000E7A52100E79C1800FFFFFF0000000000C6A58C00FFF7E700FFEF
      E700FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEC600FFDE
      BD00FFD6BD008C6B6300FFFFFF000000000000000000C6A58C00FFF7E700FFEF
      E700FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEC600FFDE
      BD00FFD6BD008C6B6300FFFFFF0000000000000000009494BD00F7F7FF00FFFF
      FF006B6B8C008C8C8C00ADADAD00B5B5B500B5B5B50094949400A58C6B00A5A5
      C600FFFFFF00F7F7FF008C8C9400000000000000000000000000E7B57B00EFBD
      8C00EFBD8C00EFBD8C00EFBD8C00EFBD8C00E78C0000E7940000BD6B0000EF9C
      0000EF9C00009C520000C66B00000000000000000000CEA59400FFF7E700FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFF7F700FFE7D600FFE7CE00FFE7C600FFDE
      C600FFDEBD008C6B6B00FFFFFF000000000000000000CEA59400FFF7E700FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFE7D600FFE7CE00FFE7C600FFDE
      C600FFDEBD008C6B6B00FFFFFF0000000000F7F7F7008484B500D6D6FF00E7E7
      FF00F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFAD3100DEDEE700EFEF
      FF00DEDEFF00DEDEFF007B7B8400FFFFFF000000000000000000EFC68C00F7CE
      A500F7D6A500F7D6A500F7D6A500F7C69400EFA50000C67300006B310000F7BD
      7B00EFAD0000E7A50000C6841000AD5A080000000000CEAD9400FFF7EF00FFFF
      FF0021A5290000AD100000AD0800ADD6AD00FFFFFF00F7F7EF00E7D6CE00FFF7
      E700FFDEC6008C6B6B00FFFFFF000000000000000000CEAD9400FFF7EF00FFFF
      FF00313131001818210018181800B5B5BD00FFFFFF00F7F7F700CECECE00FFEF
      DE00FFDEC6008C6B6B00FFFFFF0000000000000000007373B500BDBDFF00CECE
      FF00DEDEFF00EFEFFF00F7F7FF00FFFFFF00CE630000C6BDB500F7F7FF00D6D6
      FF00C6C6FF00C6C6FF00ADADAD00000000000000000000000000F7D6A500FFE7
      BD00FFE7BD00FFE7BD00FFE7BD00FFE7BD00EFAD1800D6941000C66B0000F7BD
      6B00EFAD0800EFAD0000A5731000E7B5840000000000D6AD9400FFF7F70084BD
      840021C63900FFFFFF009CD6A50000AD0800FFFFF700A55A2100BD947300944A
      1800FFE7CE0094736B00FFFFFF000000000000000000D6AD9400FFF7F7008C8C
      8C0042424200FFFFFF00ADADAD0018181800FFFFF70021212100737373003131
      3100FFE7CE0094736B00FFFFFF0000000000000000006B6BB500ADADF700B5B5
      F700C6C6FF00D6D6FF00E7E7FF00B5A5A500FFDEA500D6D6F700D6D6FF00BDBD
      F700B5B5F700B5B5FF00B5B5B500000000000000000000000000FFDEB500FFEF
      CE00FFEFD600FFEFD600FFEFD600FFEFD600F7BD6300EFCE5200CE941000C684
      1000EFB51800DE9C0000B5630000FFEFD60000000000D6AD9400FFEFDE0063BD
      6B008CE79C00ADDEB50063C66B0000B51800E7C6AD00EFC6B500EFE7DE009C52
      2100FFE7D60094736B00FFFFFF000000000000000000D6AD9400FFEFDE008484
      7B00ADADAD00BDBDBD008484840021212100D6BDAD00C6C6C600D6D6D6002121
      2900FFE7CE0094736B00FFFFFF0000000000000000005A5AB5009C9CF700A5A5
      F700ADADF700BDBDFF00BDCEFF00FF9C21009CA5BD00C6C6FF00B5B5F700ADAD
      F7009C9CF7009C9CFF00B5B5B500000000000000000000000000FFE7BD00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFE7C600EFBD5A00EFCE4A00EFBD
      3100EFB51000EFAD0000EF9C21000000000000000000D6B59400FFEFE700D6C6
      8C0063FF9C009CE7AD0029D64A00089C1000FFDEB500CE8C6300CE845200CE8C
      6300FFDECE0094736B00FFFFFF000000000000000000D6B59400FFEFE700D6B5
      9400ADADA500BDBDBD005A5A5A0021212900FFDEB500847B73006B6B6B00AD94
      7B00FFDECE0094736B00FFFFFF0000000000000000005252B5008C8CF7008C8C
      F7009C9CF700A5A5FF00A5632100FFF7E700A5A5FF00A5A5F7009C9CF7009494
      F7008C8CF7008C8CFF00B5B5B500000000000000000000000000FFE7C600FFF7
      DE00FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFE7C600EFBD3900EFAD
      2100D68C1000EFAD7300000000000000000000000000DEB59C00FFFFF700FFD6
      A500CEB57B005AC6630063AD4A00FFCE9400FFCE9C00FFDEBD00FFE7CE00FFEF
      DE00FFE7D6009C7B7300FFFFFF000000000000000000DEB59C00FFFFF700FFCE
      9C00C69C73008C7B73007B6B5A00FFCE9400FFCE9C00FFDEBD00FFE7CE00FFEF
      DE00FFE7D6009C7B7300FFFFFF0000000000000000004A4AB5007B7BF7008484
      F7008484F7006B63A500FFE7A5007373C6008C8CF7008C8CF7008484F7008C8C
      F7009C9CF700A5A5FF00B5B5B500000000000000000000000000FFE7C600FFFF
      E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7
      DE00FFF7DE00F7EFE700000000000000000000000000DEBD9C00FFFFF700FFFF
      F700FFEFD600FFD6AD00FFDEB500FFF7EF00FFF7E700FFF7E700FFEFDE00FFEF
      DE00FFE7D6009C7B7300FFFFFF000000000000000000DEBD9C00FFFFF700FFFF
      F700FFEFD600FFD6AD00FFDEB500FFF7EF00FFF7E700FFF7E700FFEFDE00FFEF
      DE00FFE7D6009C7B7300FFFFFF0000000000000000004A4AB5007373F7007B7B
      F700737BFF00FFA53100B5B5C6008484FF007B7BF700A5A5F700ADADF700ADAD
      F700A5A5F700B5B5FF00B5B5B500000000000000000000000000FFEFCE00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFF7E700F7EFE700000000000000000000000000E7BD9C00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      DE00FFE7DE009C7B7300FFFFFF000000000000000000E7BD9C00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      DE00FFE7DE009C7B7300FFFFFF0000000000000000006B6BB500A5A5F7007B7B
      F700846384009CADAD007373E700ADADF700BDBDFF00BDBDF700B5B5FF00B5B5
      FF00B5B5FF00C6C6FF00B5B5B500000000000000000000000000FFEFCE00FFFF
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700F7F7
      E700F7EFDE00EFE7DE00FFFFFF000000000000000000E7BD9C00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFDED600A5847300FFFFFF000000000000000000E7BD9C00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFDED600A5847300FFFFFF0000000000000000007B7BB500D6D6FF00DEDE
      FF00A57B4A00B5B5CE00D6D6FF00D6D6FF00D6D6FF00D6D6FF00CECEFF00CECE
      FF00CECEFF00DEDEFF00B5B5B500000000000000000000000000FFEFD600FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700EFE7D600CEBDA500CEBD
      A500DECEB500E7E7D600FFFFFF000000000000000000E7C6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00CE9C7B00CE9C
      6B00C68C5200C6AD9C00000000000000000000000000E7C6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00CE9C7B00CE9C
      6B00C68C5200C6AD9C0000000000000000000000000063639C00FFFFFF00AD8C
      730094949C00F7F7FF00EFEFFF00EFEFFF00EFEFFF00EFEFFF00EFEFFF00EFEF
      FF00EFEFFF00FFFFFF00BDBDBD00000000000000000000000000FFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DED6C600F7CE9C00D6B5
      7B00C6A57300FFFFF700000000000000000000000000EFC6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700DEBD9400EFCE
      9400C6BDAD0000000000000000000000000000000000EFC6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700DEBD9400EFCE
      9400C6BDAD000000000000000000000000000000000000000000848C9C00BDAD
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009494CE00EFEFEF0000000000000000000000000000000000FFE7D600FFF7
      EF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00E7DECE00FFEFCE00D6BD
      8C00F7F7EF00FFFFFF00000000000000000000000000F7CEA500FFE7E700FFE7
      E700FFE7DE00FFDEDE00FFDEDE00FFDED600FFDED600FFD6D600E7C69C00CEC6
      BD000000000000000000000000000000000000000000F7CEA500FFE7E700FFE7
      E700FFE7DE00FFDEDE00FFDEDE00FFDED600FFDED600FFD6D600E7C69C00CEC6
      BD00000000000000000000000000000000000000000000000000BDBDBD000000
      0000A5A5AD008C8CB500E7E7FF00FFFFFF00FFFFFF00CECEF7006B6B9400EFEF
      EF00000000000000000000000000000000000000000000000000EFDEBD00EFDE
      BD00EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600E7D6BD00D6BD8C00F7F7
      F700FFFFFF00000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080018001800100000001800180010000
      E007800180010000C00380000000000080038000000000008001800000000000
      0001800000000000000180008000000000018000800000000001800180010000
      000180018001000080018001800100008003800380030000C003800780070000
      E007800980090000F81FC01FC01F0000FF03FF03FFC38001C001C00100018001
      C000C00000008001C000C00000008000C000C00000008000C000C00000008000
      C000C00000008000C001C00100038000C001C00100078000C003C003001F8001
      C003C003001F8001C001C001001F8001C001C001001F8003C003C003001F8007
      C003C003001F8009C007C007FFFFC01F80018001FFFFFF83800180018001C001
      800180018001C000800180018001C001800180010000C000800180018001C000
      800180018001C000800180018001C001800180018001C003800180018001C003
      800180018001C003800180018001C001800180018001C001800380038001C003
      80078007C003C003800F800FD00FC00700000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Left = 266
    Top = 178
    object N1: TMenuItem
      Caption = 'Загрузить из файла'
      OnClick = OnLoadFromF
    end
  end
  object AdvPreviewDialog1: TAdvPreviewDialog
    CloseAfterPrint = False
    DialogCaption = 'Preview'
    DialogPrevBtn = 'Previous'
    DialogNextBtn = 'Next'
    DialogPrintBtn = 'Print'
    DialogCloseBtn = 'Close'
    PreviewFast = False
    PreviewWidth = 720
    PreviewHeight = 540
    PreviewLeft = 100
    PreviewTop = 100
    PreviewCenter = False
    Left = 769
    Top = 241
  end
  object AdvPreviewDialog2: TAdvPreviewDialog
    CloseAfterPrint = False
    DialogCaption = 'Preview'
    DialogPrevBtn = 'Previous'
    DialogNextBtn = 'Next'
    DialogPrintBtn = 'Print'
    DialogCloseBtn = 'Close'
    PreviewFast = False
    PreviewWidth = 350
    PreviewHeight = 300
    PreviewLeft = 100
    PreviewTop = 100
    PreviewCenter = False
    Left = 570
    Top = 162
  end
  object EventStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2007Obsidian
    Left = 378
    Top = 387
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
    CaptionAppearance.CaptionBorderColor = clHighlight
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
    Left = 154
    Top = 299
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
    Left = 378
    Top = 243
  end
  object AdvPopupMenu1: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 50
    Top = 243
    object N2: TMenuItem
      Caption = 'Запросить события'
      ImageIndex = 8
      OnClick = OnLoadEvents
    end
  end
  object AdvPopupMenu2: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 90
    Top = 243
    object N3: TMenuItem
      Caption = 'Сохранить'
      ImageIndex = 0
      OnClick = OnSetEvents
    end
    object N4: TMenuItem
      Caption = 'Показать все'
      ImageIndex = 1
      OnClick = OnGetAllEvents
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = 'Редактирование'
      ImageIndex = 2
      OnClick = OnEditMode
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Caption = 'Удаление'
      ImageIndex = 6
      OnClick = OnDelAllEvents
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Excell1: TMenuItem
      Caption = 'Экспорт в Excell'
      ImageIndex = 7
      OnClick = OnFix
    end
  end
  object AdvPopupMenu3: TAdvPopupMenu
    Images = ImageListEvent1
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 130
    Top = 243
    object N11: TMenuItem
      Caption = 'События журнала №1'
      ImageIndex = 3
      OnClick = OnGetEv0
    end
    object N21: TMenuItem
      Caption = 'События журнала №2'
      ImageIndex = 4
      OnClick = OnGetEv1
    end
    object N31: TMenuItem
      Caption = 'События журнала №3'
      ImageIndex = 5
      OnClick = OnGetEv3
    end
    object N41: TMenuItem
      Caption = 'События журнала №4'
      ImageIndex = 10
      OnClick = OnGetEv4
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
    Left = 330
    Top = 307
  end
end
