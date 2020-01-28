object frmEditExpr: TfrmEditExpr
  Left = 509
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = ' Редактирование формулы'
  ClientHeight = 487
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 57
    Align = alTop
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
    Styler = AdvPanelStyler1
    FullHeight = 0
    object Label2: TLabel
      Left = 4
      Top = 6
      Width = 112
      Height = 14
      Caption = 'Автоматизация 2000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object clbEditNode: TLabel
      Left = 238
      Top = 20
      Width = 123
      Height = 19
      Caption = 'Редактор формул'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 522
      Top = 39
      Width = 100
      Height = 14
      Caption = 'http:://www.a2000.by'
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
    Top = 458
    Width = 628
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    Color = 13627626
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
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
    Styler = AdvPanelStyler1
    FullHeight = 0
    object RBGenerate: TRbButton
      Left = 178
      Top = 4
      Width = 159
      Height = 21
      OnClick = OnReplaceFormula
      TabOrder = 0
      TextShadow = True
      Caption = 'Сгенерировать по шаблону'
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
      Default = True
      GradientBorder = True
    end
    object RbButton4: TRbButton
      Left = 343
      Top = 4
      Width = 90
      Height = 21
      OnClick = OnClear
      TabOrder = 1
      TextShadow = True
      Caption = 'Очистить'
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
      Default = True
      GradientBorder = True
    end
    object RbButton1: TRbButton
      Left = 435
      Top = 4
      Width = 90
      Height = 21
      OnClick = RbButton1Click
      TabOrder = 2
      TextShadow = True
      Caption = 'Сохранить'
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
      Default = True
      GradientBorder = True
    end
    object RbButton2: TRbButton
      Left = 527
      Top = 4
      Width = 90
      Height = 21
      OnClick = RbButton2Click
      TabOrder = 3
      TextShadow = True
      Caption = 'Отменить'
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
      Cancel = True
      GradientBorder = True
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 57
    Width = 628
    Height = 401
    Align = alClient
    BevelOuter = bvNone
    Color = 13627626
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
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
    Styler = AdvPanelStyler1
    FullHeight = 0
    object Label4: TLabel
      Left = 16
      Top = 16
      Width = 62
      Height = 13
      Caption = 'Выражение:'
    end
    object LFormula: TLabel
      Left = 32
      Top = 208
      Width = 54
      Height = 13
      Caption = 'Формула :'
    end
    object Label7: TLabel
      Left = 24
      Top = 231
      Width = 68
      Height = 13
      Caption = ' Параметры: '
    end
    object e_expr: TEdit
      Left = 80
      Top = 12
      Width = 458
      Height = 21
      TabOrder = 0
    end
    object RbButton3: TRbButton
      Left = 540
      Top = 12
      Width = 75
      Height = 22
      OnClick = RbButton3Click
      TabOrder = 1
      TextShadow = True
      Caption = 'Проверить'
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
    object GroupBox1: TGroupBox
      Left = 16
      Top = 40
      Width = 599
      Height = 73
      Caption = ' Операции '
      TabOrder = 2
      object SpeedButton1: TSpeedButton
        Left = 28
        Top = 21
        Width = 23
        Height = 22
        Caption = '+'
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 52
        Top = 21
        Width = 23
        Height = 22
        Caption = '-'
        OnClick = SpeedButton2Click
      end
      object SpeedButton3: TSpeedButton
        Left = 77
        Top = 21
        Width = 23
        Height = 22
        Caption = '/'
        OnClick = SpeedButton3Click
      end
      object SpeedButton4: TSpeedButton
        Left = 102
        Top = 21
        Width = 23
        Height = 22
        Caption = '*'
        OnClick = SpeedButton4Click
      end
      object SpeedButton5: TSpeedButton
        Left = 176
        Top = 21
        Width = 23
        Height = 22
        Caption = 'sin'
        OnClick = SpeedButton5Click
      end
      object SpeedButton6: TSpeedButton
        Left = 201
        Top = 21
        Width = 23
        Height = 22
        Caption = 'cos'
        OnClick = SpeedButton6Click
      end
      object SpeedButton7: TSpeedButton
        Left = 226
        Top = 21
        Width = 23
        Height = 22
        Caption = 'tg'
        OnClick = SpeedButton7Click
      end
      object SpeedButton8: TSpeedButton
        Left = 250
        Top = 21
        Width = 23
        Height = 22
        Caption = 'ctg'
        OnClick = SpeedButton8Click
      end
      object SpeedButton9: TSpeedButton
        Left = 275
        Top = 21
        Width = 23
        Height = 22
        Caption = '('
        OnClick = SpeedButton9Click
      end
      object SpeedButton10: TSpeedButton
        Left = 300
        Top = 21
        Width = 23
        Height = 22
        Caption = ')'
        OnClick = k
      end
      object SpeedButton11: TSpeedButton
        Left = 127
        Top = 21
        Width = 23
        Height = 22
        Caption = '^'
        OnClick = SpeedButton11Click
      end
      object SpeedButton12: TSpeedButton
        Left = 151
        Top = 21
        Width = 23
        Height = 22
        Caption = 'exp'
        OnClick = SpeedButton12Click
      end
      object SpeedButton13: TSpeedButton
        Left = 3
        Top = 21
        Width = 23
        Height = 22
        Caption = '[x]'
        OnClick = SpeedButton13Click
      end
      object SpeedButton14: TSpeedButton
        Left = 349
        Top = 21
        Width = 23
        Height = 22
        Caption = '0'
        OnClick = OnSet0
      end
      object SpeedButton15: TSpeedButton
        Left = 374
        Top = 21
        Width = 23
        Height = 22
        Caption = '1'
        OnClick = OnSet1
      end
      object SpeedButton16: TSpeedButton
        Left = 399
        Top = 21
        Width = 23
        Height = 22
        Caption = '2'
        OnClick = OnSet2
      end
      object SpeedButton17: TSpeedButton
        Left = 424
        Top = 21
        Width = 23
        Height = 22
        Caption = '3'
        OnClick = OnSet3
      end
      object SpeedButton18: TSpeedButton
        Left = 448
        Top = 21
        Width = 23
        Height = 22
        Caption = '4'
        OnClick = OnSet4
      end
      object SpeedButton19: TSpeedButton
        Left = 473
        Top = 21
        Width = 23
        Height = 22
        Caption = '5'
        OnClick = OnSet5
      end
      object SpeedButton20: TSpeedButton
        Left = 498
        Top = 21
        Width = 23
        Height = 22
        Caption = '6'
        OnClick = OnSet6
      end
      object SpeedButton21: TSpeedButton
        Left = 523
        Top = 21
        Width = 23
        Height = 22
        Caption = '7'
        OnClick = OnSet7
      end
      object SpeedButton22: TSpeedButton
        Left = 547
        Top = 21
        Width = 23
        Height = 22
        Caption = '8'
        OnClick = OnSet8
      end
      object SpeedButton23: TSpeedButton
        Left = 572
        Top = 21
        Width = 23
        Height = 22
        Caption = '9'
        OnClick = OnSet9
      end
      object SpeedButton24: TSpeedButton
        Left = 325
        Top = 21
        Width = 23
        Height = 22
        Caption = '.'
        OnClick = OnComa
      end
      object SpeedButton25: TSpeedButton
        Left = 3
        Top = 45
        Width = 23
        Height = 22
        Caption = 'Lim'
        OnClick = OnSetLimit
      end
      object SpeedButton26: TSpeedButton
        Left = 28
        Top = 45
        Width = 23
        Height = 22
        Caption = 'Mlim'
      end
      object SpeedButton27: TSpeedButton
        Left = 52
        Top = 45
        Width = 23
        Height = 22
        Caption = 'Glm'
        OnClick = OnGenerateLim
      end
      object SpeedButton28: TSpeedButton
        Left = 77
        Top = 45
        Width = 23
        Height = 22
        Caption = 'Gml'
        OnClick = OnGenMLimit
      end
      object chb_GenAllParams: TCheckBox
        Left = 105
        Top = 48
        Width = 160
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = 'Применить ко всем в списке'
        ParentBiDiMode = False
        TabOrder = 0
      end
    end
    object chb_dir: TCheckBox
      Left = 17
      Top = 121
      Width = 96
      Height = 17
      Caption = 'Группа:'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chb_GrCounter: TCheckBox
      Left = 17
      Top = 140
      Width = 88
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Сумм. сч.:'
      ParentBiDiMode = False
      TabOrder = 4
      OnClick = chb_GrCounterClick
    end
    object chb_SGrCounter: TCheckBox
      Left = 17
      Top = 160
      Width = 88
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Групп сч.:'
      ParentBiDiMode = False
      TabOrder = 5
      OnClick = OnSuperGroup
    end
    object chb_partype: TCheckBox
      Left = 17
      Top = 179
      Width = 103
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Тип параметров:'
      Checked = True
      ParentBiDiMode = False
      State = cbChecked
      TabOrder = 6
    end
    object sg_Params: TAdvStringGrid
      Left = 0
      Top = 246
      Width = 628
      Height = 154
      Cursor = crDefault
      ColCount = 7
      DefaultRowHeight = 21
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 7
      OnClickCell = sg_ParamsClickCell
      OnDblClickCell = sg_ParamsDblClickCell
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'MS Sans Serif'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = 9758459
      ActiveCellColorTo = 1414638
      Bands.Active = True
      Bands.PrimaryColor = 14811105
      CellNode.ShowTree = False
      ControlLook.FixedGradientFrom = 13627626
      ControlLook.FixedGradientTo = 9224369
      ControlLook.ControlStyle = csClassic
      EnhRowColMove = False
      Filter = <>
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
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
      ScrollWidth = 16
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
        64
        65
        65
        100
        100
        75
        80)
      RowHeights = (
        21
        21)
    end
    object cb_dir: TComboBox
      Left = 117
      Top = 127
      Width = 498
      Height = 23
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 8
      OnChange = cb_Change
    end
    object cb_abonent: TComboBox
      Left = 117
      Top = 152
      Width = 498
      Height = 23
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 9
      OnChange = OnChVmid
    end
    object cb_partype: TComboBox
      Left = 117
      Top = 176
      Width = 305
      Height = 23
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 10
      OnChange = OnChPrid
    end
    object E_formula: TEdit
      Left = 117
      Top = 200
      Width = 495
      Height = 21
      TabOrder = 11
    end
    object bt_sumbyall: TRbButton
      Left = 421
      Top = 176
      Width = 99
      Height = 22
      OnClick = OnSummAll
      TabOrder = 12
      TextShadow = True
      Caption = 'Сумма всех'
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
    object RbButton5: TRbButton
      Left = 521
      Top = 176
      Width = 93
      Height = 22
      OnClick = OnSummAll1
      TabOrder = 13
      TextShadow = True
      Caption = 'Сумма без см.сч.'
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
  object AdvPanelStyler1: TAdvPanelStyler
    Tag = 0
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
    Left = 90
    Top = 387
  end
  object RedactorStyler: TAdvFormStyler
    AutoThemeAdapt = True
    Style = tsOffice2003Olive
    Left = 258
    Top = 379
  end
  object IdIcmpClient1: TIdIcmpClient
    Left = 136
    Top = 24
  end
end
