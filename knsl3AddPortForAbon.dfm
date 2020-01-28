object PortForAbon: TPortForAbon
  Left = 800
  Top = 173
  Width = 297
  Height = 298
  BorderIcons = [biSystemMenu]
  Caption = 'Добавление канала'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = OnCloseAdd
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 264
    Align = alClient
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
    Styler = AdvPanelStyler3
    OnClose = OnCloseAddPort
    FullHeight = 0
    object Label5: TLabel
      Left = 7
      Top = 58
      Width = 23
      Height = 15
      Caption = 'Тип:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbPortNumb: TLabel
      Left = 7
      Top = 177
      Width = 101
      Height = 15
      Caption = 'Номер COM порта:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbIPPort: TLabel
      Left = 7
      Top = 129
      Width = 41
      Height = 15
      Caption = 'IP Порт'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbIPAdr: TLabel
      Left = 7
      Top = 153
      Width = 46
      Height = 15
      Caption = 'IP Адрес'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbPortName: TLabel
      Left = 7
      Top = 105
      Width = 50
      Height = 15
      Caption = 'Название '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 7
      Top = 81
      Width = 79
      Height = 15
      Caption = 'Тип протокола:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 7
      Top = 225
      Width = 54
      Height = 15
      Caption = 'ID Канала:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object cb_PortType: TComboBox
      Left = 72
      Top = 54
      Width = 209
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
      OnChange = cb_PortTypeChange
      Items.Strings = (
        'Последовательный порт'
        'GSM на последовательном порте'
        'Порт TCP/IP')
    end
    object edIPPort: TEdit
      Left = 109
      Top = 125
      Width = 92
      Height = 22
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edIPAdr: TEdit
      Left = 109
      Top = 149
      Width = 92
      Height = 22
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edPortName: TEdit
      Left = 109
      Top = 101
      Width = 172
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object AdvPanel2: TAdvPanel
      Left = 0
      Top = 241
      Width = 289
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
      TabOrder = 4
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
      Styler = AdvPanelStyler3
      FullHeight = 0
      object Label1: TLabel
        Left = 581
        Top = 5
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
    end
    object AdvPanel1: TAdvPanel
      Left = 0
      Top = 0
      Width = 289
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
      TabOrder = 5
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
      Styler = AdvPanelStyler3
      FullHeight = 0
      object Label2: TLabel
        Left = 581
        Top = 16
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
      object AdvToolBar1: TAdvToolBar
        Left = 0
        Top = 0
        Width = 146
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
          Left = 42
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Добавить порт'
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
          OnClick = AddPortBtnClick
        end
        object AdvToolBarButton2: TAdvToolBarButton
          Left = 92
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Отменить'
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
          OnClick = RbButton1Click
        end
        object AdvToolBarSeparator1: TAdvToolBarSeparator
          Left = 82
          Top = 2
          Width = 10
          Height = 40
          LineColor = clBtnShadow
        end
        object abSaveButt: TAdvToolBarButton
          Left = 2
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Сохранить'
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
          Visible = False
          OnClick = OnSaveEdit
        end
      end
    end
    object cbProtID: TComboBox
      Left = 109
      Top = 78
      Width = 172
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 6
      OnChange = cb_PortTypeChange
      Items.Strings = (
        'Последовательный порт'
        'GSM на последовательном порте'
        'Порт TCP/IP')
    end
    object chbReaddr: TCheckBox
      Left = 8
      Top = 199
      Width = 97
      Height = 17
      Caption = 'Переадр. на '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chbReaddrClick
    end
    object cbPorts: TComboBox
      Left = 109
      Top = 197
      Width = 172
      Height = 22
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 8
      OnChange = cb_PortTypeChange
      Items.Strings = (
        'Последовательный порт'
        'GSM на последовательном порте'
        'Порт TCP/IP')
    end
    object edNumPort: TEdit
      Left = 109
      Top = 173
      Width = 92
      Height = 22
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object edPortID: TEdit
      Left = 109
      Top = 221
      Width = 36
      Height = 22
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
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
    Left = 136
    Top = 5
  end
  object AbonStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2007Luna
    Left = 172
    Top = 6
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
    Left = 204
    Top = 6
  end
  object AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler
    Style = psOffice2007Luna
    BorderColor = 11566422
    PanelAppearanceLight.BorderColor = clNone
    PanelAppearanceLight.BorderColorHot = 10079963
    PanelAppearanceLight.BorderColorDown = 4548219
    PanelAppearanceLight.Color = 16377559
    PanelAppearanceLight.ColorTo = 16309447
    PanelAppearanceLight.ColorHot = 16515071
    PanelAppearanceLight.ColorHotTo = 12644607
    PanelAppearanceLight.ColorDown = 7845111
    PanelAppearanceLight.ColorDownTo = 4561657
    PanelAppearanceLight.ColorMirror = 16109747
    PanelAppearanceLight.ColorMirrorTo = 16244941
    PanelAppearanceLight.ColorMirrorHot = 7067903
    PanelAppearanceLight.ColorMirrorHotTo = 10544892
    PanelAppearanceLight.ColorMirrorDown = 1671928
    PanelAppearanceLight.ColorMirrorDownTo = 241407
    PanelAppearanceLight.TextColor = 6365193
    PanelAppearanceLight.TextColorHot = clBlack
    PanelAppearanceLight.TextColorDown = clBlack
    PanelAppearanceLight.TextStyle = []
    PanelAppearanceDark.BorderColor = clNone
    PanelAppearanceDark.BorderColorHot = 10079963
    PanelAppearanceDark.BorderColorDown = 4548219
    PanelAppearanceDark.Color = 16309445
    PanelAppearanceDark.ColorTo = 16103047
    PanelAppearanceDark.ColorHot = 16515071
    PanelAppearanceDark.ColorHotTo = 12644607
    PanelAppearanceDark.ColorDown = 7845111
    PanelAppearanceDark.ColorDownTo = 4561657
    PanelAppearanceDark.ColorMirror = 15382160
    PanelAppearanceDark.ColorMirrorTo = 12752244
    PanelAppearanceDark.ColorMirrorHot = 7067903
    PanelAppearanceDark.ColorMirrorHotTo = 10544892
    PanelAppearanceDark.ColorMirrorDown = 1671928
    PanelAppearanceDark.ColorMirrorDownTo = 241407
    PanelAppearanceDark.TextColor = 6365193
    PanelAppearanceDark.TextColorHot = 6365193
    PanelAppearanceDark.TextColorDown = 6365193
    PanelAppearanceDark.TextStyle = []
    Left = 104
    Top = 5
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 370
    Top = 163
    Bitmap = {
      494C010105000900040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFFDFBFBFFFBF7F6FFF9F4F2FFF8F2F0FFF8F2F0FFF8F3F1FFFAF6F5FFFCFA
      FAFFFEFEFEFFF0F4EFFFCBDAC5FFC3D4BCFFC3D4BCFFC4D5BDFFE1E9DDFFFCFD
      FCFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCF9F9FFF7F0EEFFF1E4
      DFFFEBD9D2FFE7D2CAFFE5CEC7FFE5CDC6FFE5CDC6FFE6CFC8FFE8D3CCFFEBDA
      D3FFF1E4DFFFB7C6A8FF2C8E31FF2C8E31FF2D8E30FF2B8E30FF72A86BFFFEFE
      FEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FBF8F7FFF4EAE6FFEBD8D1FFE4CBC3FFE1C6
      BEFFDDBEB3FFD9B4A3FFD8AE9BFFD6AA96FFD6A993FFD8AC97FFD9B2A1FFDDBD
      B1FFE1C6BEFF98A67CFF03911FFF049523FF049220FF04911FFF509C50FFFDFD
      FDFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFDFDFFF7F0EEFFECDBD4FFE5CDC5FFE2C8C0FFDBB3A1FFDCA0
      7EFFEBA97EFFF7BB90FFFFCCA6FFFFD4B0FFFFD1AAFFFFC79CFFF9B786FFEDA4
      72FFDE9B72FF949362FF059826FF009A24FF009722FF009723FF57A158FFFEFE
      FEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFBFBFFF5EBE8FFEAD6CFFFE6D0C9FFDEBBABFFE1996BFFFCAD71FFFFCC
      9DFFFFD7B3FFFFDBBDFFFFDEC5FFFFE1C9FFFFE1C9FFFEDEC5FFFEDABCFFFFD4
      AFFFFFC998FFAC9246FF12A538FF00A32BFF00A029FF04A32EFF5FA35EFFFAF9
      F8FF00000000FEFEFEFFFEFEFEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFB
      FBFFF5ECE9FFEAD8D1FFE9D5CFFFD8A68AFFEF9653FFFFC189FFFFCEA8FFFFD2
      B0FFFFD9BBFFFFE0C9FFFFE6D3FFFFE9D9FFEFDFCAFFC8C5A1FFBFBD94FFC1B7
      89FFC6B281FF879852FF1AB247FF00AC32FF00A931FF06AC38FF4D9F51FFB6C1
      A5FFC0D1B8FFC0D2B8FFC0D2B8FFDCE6D8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFDFDFFF8F1
      EFFFEEDED8FFECDBD5FFD49975FFF3984FFFFFC18FFFFFC9A1FFFFCCA6FFFFD4
      B4FFFFDDC4FFFFE3CEFFFFE7D5FFFFEADBFFC3C8A5FF0E9B2BFF109F30FF11A0
      31FF119F30FF11A939FF07B943FF00B53BFF00B23AFF00B038FF0EAB3BFF0F98
      2CFF10962AFF109428FF0B9122FF63A864FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBF8F7FFF2E7
      E3FFF1E4E0FFD39B79FFF09145FFFFBA83FFFFC191FFFFC294FFFFC9A1FFFFD4
      B3FFFFD9BDFFFFDEC5FFFFE3CEFFFFE8D7FFEFDFCAFF3EAF51FF00C94DFF00C4
      48FF00C549FF00C347FF00BF44FF00BE44FF00BB41FF00B83EFF00B33AFF00B2
      39FF00AC34FF00A730FF019F2AFFB3D0AFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFDFDFFF8F2F0FFF6ED
      EBFFDBB49FFFE5802FFFFFAD6BFFFFB378FFFFB175FFFFB67EFFFFC496FFFFCC
      A6FFFFD2B0FFFFD8BAFFFFDEC5FFFFE3CEFFFFE4D0FFE1D0B0FF2EB953FF06D0
      57FF00C94BFF00CA4CFF00C84BFF00C64AFF00C347FF00BF44FF00BA40FF00B5
      3BFF00B137FF10B343FF93C293FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFBFBFFF8F3F1FFEEDE
      D8FFD57A35FFFE9B4CFFFFA35BFFFF9F55FFFF9F55FFFFB57CFFFFC394FFFFC8
      9FFFFFCFAAFFFFD4B4FFFFDABEFFFFDEC5FFFFDFC7FFFFDBC1FFC6BC8EFF43D4
      76FF26DE73FF17D765FF12D561FF0ED25CFF0DCF59FF0ECB56FF12C755FF16C3
      54FF36CC6DFF78BC7FFFFDFBFBFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFAFAFFFEFDFDFFD49E
      7DFFEA832FFFFA9443FFF89040FFF9913FFFFF9C4FFFFFBC89FFFFC191FFFFC5
      99FFFFCBA3FFFFD0ADFFFFD5B5FFFFD8BBFFFFD9BCFFFFD6B8FFFFD3B1FFA9B1
      76FF62EA9CFF44E98CFF42E587FF42E386FF43E083FF43DD80FF3FD87BFF5BE0
      90FF65A95CFFF2F2EEFFFDFBFBFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFF00000000F5ECE8FFD075
      2EFFEA8331FFEB8433FFEC8534FFF28A38FFFD9C51FFFFC292FFFFBD8BFFFFC1
      92FFFFC79CFFFFCCA5FFFFD0ACFFFFD2B0FFFFD3B2FFFFD4B3FFFFD3B2FFFFD1
      AFFF91B471FF81F7B7FF5BED9BFF58EB98FF55E994FF51E48EFF67EA9FFF72C5
      7AFFBA6A17FFEAD4CAFF00000000FEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0BEAAFFD46D
      1AFFDE7727FFE07928FFE47D2CFFEC8432FFFD9C51FFFFC498FFFFB983FFFFBC
      8AFFFFC394FFFFC79CFFFFCAA2FFFFCDA7FFFFD0ADFFFFD4B3FFFFD6B7FFFFD7
      B8FFF9D2AFFF8CC283FFA2FCCCFF7AF0ADFF6EEEA6FF74F1ACFF88E3A6FFAC75
      20FFD46D19FFD4A07EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9269FFD26A
      17FFD46D1CFFD87120FFDC7524FFE77E2CFFFD9C51FFFFCDA7FFFFBF8DFFFFB7
      81FFFFBA86FFFFBF8EFFFFC396FFFFC9A0FFFFD1ADFFFFD6B8FFFFDABFFFFFDC
      C2FFFFDBC0FFE7CAA5FF99D6A0FFB4FCD6FF95F4BFFFA6F7CBFF957A23FFD26B
      1AFFD26917FFC1773DFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BF763CFFD067
      15FFCF6817FFD46D1CFFD56E1DFFE17724FFFEA866FFFFE4CFFFFFDEC5FFFFCF
      AAFFFFD0ADFFFFDCC1FFFFE4CFFFFFE9D9FFFFEEE1FFFFF0E5FFFFF0E6FFFFEF
      E4FFFFECDFFFFFE6D3FFCFC7A1FFAEEDC4FFD4FFEEFF9BB26FFFDB711FFFCC65
      14FFD16917FFC1641BFFEDEBE9FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F1FFBD6722FFD46B
      19FFD66F1DFFD86F1DFFD56D1CFFE9883CFFFFC79BFFFFF5EFFFFFF9F5FFFFEC
      DDFFFFE2CDFFFFE0C9FFFFE0C8FFFFE2CDFFFFE6D3FFFFEBDBFFFFEFE3FFFFF3
      EAFFFFF3EBFFFFECDEFFFFE5D3FFB7CCA5FF96D19FFFFBD5B4FFE37E2FFFCC64
      12FFCF6817FFCB600CFFD8D3CFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEEEDFFBD641FFFDD73
      1FFFE17A29FFEE934DFFF69E59FFF5954CFFFCB985FFFFEFE3FFFFF3EAFFFFDB
      C0FFFFD1AFFFFFD2B0FFFFD4B4FFFFDBBFFFFFE1CAFFFFE7D5FFFFEEE1FFFFF4
      EDFFFFF8F3FFFFF3EAFFFFE7D5FFFFE0C9FFFFD9BCFFFFC89DFFDF7B2EFFCC64
      12FFD06817FFCB600CFFD1CBC7FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEEEDFFBF661FFFE982
      33FFF7A668FFFCA868FFE27C2DFFDD7C2FFFFDC090FFFFDFC7FFFFECE0FFFFD1
      AEFFFFD0ADFFFFD2B0FFFFD4B4FFFFDABEFFFFE0C9FFFFE6D4FFFFEDE0FFFFF4
      ECFFFFF8F3FFFFF3EAFFFFE8D8FFFFD7BAFFFFB378FFFFAD6EFFDE7B2EFFCC65
      13FFD06917FFCA5F0CFFD1CBC7FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F4F5F4FFC4702BFFF698
      4FFFFD9D52FFFB913EFFE78030FFF7B481FFFFCBA3FFFFD0AEFFFFEEE3FFFFD6
      B7FFFFCFABFFFFD1AFFFFFD3B2FFFFD8BAFFFFDEC5FFFFE4D0FFFFE9DAFFFFEE
      E2FFFFF0E6FFFFECDEFFFFE3CEFFFFD6B6FFFEB074FFFFA661FFE48236FFD068
      17FFD06917FFC75E0CFFDAD5D2FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C38248FFF88C
      3AFFFF9C4EFFFF9D52FFFCB176FFFFCAA1FFFFC9A1FFFFCDA6FFFFEBDDFFFFE4
      D0FFFFCEAAFFFFD1AEFFFFD1AFFFFFD5B5FFFFDABFFFFFDFC8FFFFE4CFFFFFE7
      D5FFFFE7D6FFFFE3CFFFFFDBC0FFFFCEA9FFFFB882FFFFAC6CFFE88638FFD971
      20FFD56D1AFFBC611AFFECEBEBFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4A57FFFFA8C
      3AFFFFA761FFFFAD6EFFFFD2B0FFFFCCA6FFFFCBA3FFFFCCA6FFFFDEC6FFFFF3
      EBFFFFD2B1FFFFD0ADFFFFD0ADFFFFD2AFFFFFD6B6FFFFDABEFFFFDDC4FFFFDF
      C7FFFFDEC5FFFFDABEFFFFD2B1FFFFC598FFFFB378FFFFB57CFFEE8A3CFFE37C
      2AFFDE731FFFB57642FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7D7C6FFF182
      31FFFFAF6EFFFFBE8CFFFFE2CCFFFFD3B1FFFFCDA6FFFFCFABFFFFD2B0FFFFF4
      ECFFFFE2CDFFFFCEAAFFFFD0ADFFFFCFACFFFFD1AEFFFFD4B3FFFFD6B6FFFFD6
      B7FFFFD4B5FFFFD0ACFFFFC99FFFFFBA85FFFFAF71FFFFBD8AFFF69142FFED85
      34FFE2731EFFBAA189FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F8FBF9FFD68D
      4BFFFFAD6EFFFFCAA2FFFFECDDFFFFDDC3FFFFCFABFFFFD1AEFFFFCFABFFFFE2
      CDFFFFF6F0FFFFD2B1FFFFCEA9FFFFCFAAFFFFCEA8FFFFCDA7FFFFCEA8FFFFCE
      A8FFFFCBA3FFFFC69AFFFFBD8CFFFFB073FFFFB379FFFFC497FFFF994AFFF68D
      3BFFD26D20FFE0E0DCFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D4CF
      B1FFFD9650FFFFD0AAFFFFF1E7FFFFE9D9FFFFD6B7FFFFD2B0FFFFD2B1FFFFD2
      B1FFFFF2EBFFFFE9DAFFFFD0ADFFFFCFABFFFFCDA6FFFFCAA2FFFFC89EFFFFC6
      9AFFFFC294FFFFBD8AFFFFB57BFFFFAD6FFFFFC394FFFFC89DFFFFA055FFF888
      34FFBE9A73FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FAFD
      FAFFDEA061FFFFBD8CFFFFF2E9FFFFF3EAFFFFE1CAFFFFD4B4FFFFD4B4FFFFD2
      B0FFFFDCC2FFFFFBF9FFFFEBDCFFFFDBC0FFFFCEA9FFFFC9A0FFFFC79BFFFFC3
      95FFFFBF8DFFFFB983FFFFB276FFFFB881FFFFD5B5FFFFC599FFFFA054FFD97C
      32FFE6E9E3FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E9F3E2FFF1934DFFFFDBC0FFFFF8F4FFFFEADBFFFFDABFFFFFD6B6FFFFD5
      B5FFFFD9BDFFFFF2E8FFFFFFFFFFFFEADBFFFFD2AFFFFFC89FFFFFC69BFFFFC2
      94FFFFBE8CFFFFB881FFFFB780FFFFCDA7FFFFDFC7FFFFBB85FFF38331FFCFCA
      B4FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1E9CDFFF59650FFFFE6D4FFFFF4EDFFFFE4D0FFFFD9BDFFFFD6
      B6FFFFDABEFFFFE8D8FFFFF7F1FFFFFAF7FFFFD6B7FFFFC79CFFFFC69BFFFFC2
      94FFFFBD8AFFFFBA85FFFFCAA2FFFFE5D1FFFFD4B1FFFB9147FFCDBE9AFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEE4C8FFED9451FFFFE2CEFFFFF3E9FFFFE2CDFFFFD9
      BCFFFFD7B8FFFFDBC0FFFFDDC3FFFFE5D1FFFFEFE4FFFFD2B0FFFFC395FFFFC1
      92FFFFBF8EFFFFCCA4FFFFE7D5FFFFDBBFFFF8954EFFD2C4A0FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E4EBDBFFD69C63FFFCC9A7FFFFEFE2FFFFE7
      D4FFFFDCC0FFFFD6B7FFFFD3B2FFFFCEA8FFFFD6B7FFFFE6D4FFFFD6B8FFFFC8
      9EFFFFD3B0FFFFE0C8FFFFC097FFEB9D59FFDEE3CAFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F8FAF8FFCCC4A9FFD7A474FFFAC9
      A6FFFFE1C7FFFFE3C9FFFFDFC3FFFFDBBCFFFFD6B3FFFFD5B2FFFFDEC3FFFFD6
      B8FFFBB789FFE79D60FFD9CC9FFFF4FBF4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F5F7F4FFD0CD
      BDFFC4AB8BFFD2A47AFFDCA77BFFE7A879FFE7A674FFDBA170FFD69F6BFFCDAF
      83FFD6D5BCFFF3F8F2FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFCFFF1F2F0FFEAEBE6FFEAECE7FFF0F3F0FFFBFCFBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00EFEF
      EF00CECECE00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600CECE
      CE00EFEFEF00FFFFFF0000000000000000000000000000000000FFFFFF00EFEF
      EF00CECECE00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600CECE
      CE00EFEFEF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFF7F700DEDE
      DE00B5B5B500A59C9C009C9C9400A59C9400B5ADAD00D6D6D600F7F7F700FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFF7
      EF00FFF7EF00F7DEC600EFC68C00F7C68C00F7C68C00FFD6AD00FFEFDE00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFF700B5A5
      9C00947B730094736B0094736B0094736B008C736B008C736B008C736B008C6B
      63008C6B63008C6B63008C6B63008C6B6300846B630084636300846363008463
      63008463630084636300846363007B5A63007B5A5A007B5A5A007B5A5A008473
      7300D6D6D600FFFFFF0000000000000000000000000000000000FFFFF700B5A5
      9C00947B730094736B0094736B0094736B008C736B008C736B008C736B008C6B
      63008C6B63008C6B63008C6B63008C6B6300846B630084636300846363008463
      63008463630084636300846363007B5A63007B5A5A007B5A5A007B5A5A008473
      7300D6D6D600FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEC600CEA57B00CEA57B00CEA57B00CEA57B00CEA57B00CEA57B00CEA5
      7B00CEA57B00CEA58400CEA58400CEA58400CEA58400A58C73009C8C8400B5AD
      A500D6CECE00DEDEDE00DEDEDE00D6DEDE00CECEC600ADA59C0094847B00C6C6
      C600FFFFF7000000000000000000000000000000000000000000000000000000
      0000EFDEC600CEA57B00CEA57B00CEA57B00CEA57B00CEA57B00CEA57B00CEA5
      7B00CEA57B00CEA57B00CEA57B00CEA57B00CEA57B00CEA57300D69C6300C684
      3100EFAD2100E7A52100AD6B1000CE8C1800BD730800C67B0800D67B0800FFEF
      E700000000000000000000000000000000000000000000000000FFF7F700C69C
      8C00F7C6C600FFDED600FFD6D600FFD6D600FFD6CE00FFD6CE00FFD6CE00FFD6
      CE00FFCECE00FFCEC600FFCEC600FFCEC600FFC6BD00FFC6BD00FFC6BD00FFC6
      B500FFBDB500FFBDB500FFBDB500FFBDAD00FFB5AD00FFB5AD00BD737B008463
      6300CECECE00FFFFFF0000000000000000000000000000000000FFF7F700C69C
      8C00F7C6C600FFDED600FFD6D600FFD6D600FFD6CE00FFD6CE00FFD6CE00FFD6
      CE00FFCECE00FFCEC600FFCEC600FFCEC600FFC6BD00FFC6BD00FFC6BD00FFC6
      B500FFBDB500FFBDB500FFBDAD00FFBDAD00FFB5AD00FFB5AD00BD7B7B008463
      6300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000E7CEA500D6944A00D6945200D6945200D6945200D6945200D6945200D694
      5200D6945200D6945200D6945200D6945200BD8C5200C6B5A500DEDEDE00EFD6
      CE00EFAD8C00E78C6300E7845200E78C6300EFB59400EFDED600D6D6D600A59C
      9400B5B5AD00F7F7F70000000000000000000000000000000000000000000000
      0000E7CEA500D6944A00D6945200D6945200D6945200D6945200D6945200D694
      5200D6945200D6945200D6945200D6945200D6945200DE944A00944A08007B42
      0800B56B0000BD6B0000C66B0000DE8C0800DE840000DE840000E7840000EFC6
      9400FFCE9C00FFE7CE0000000000000000000000000000000000FFF7F700C69C
      8C00F7CEC600FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFEF
      D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7C600FFE7C600FFDE
      C600FFDEBD00FFDEBD00FFDEBD00FFDEB500FFDEB500FFD6B500BD7B7B008463
      6300CECECE00FFFFFF0000000000000000000000000000000000FFF7F700C69C
      8C00F7CEC600FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFE7
      D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7C600FFDEC600FFDE
      C600FFDEBD00FFDEBD00FFDEBD00FFDEB500FFDEB500FFD6B500BD7B7B008463
      6300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000E7CEA500DE9C5A00DEA56300DEA56300DEA56300DEA56300DEA56300DEA5
      6300DEA56300DEA56300DEA56300C6946300D6CEC600EFE7E700E7947300D66B
      4200CE7B5A00D65A2100EF4A0000E74A0000E74A0000E75A1800E79C7300E7E7
      E700B5ADA500B5B5AD00FFFFFF00000000000000000000000000000000000000
      0000E7CEA500DE9C5A00DEA56300DEA56300DEA56300DEA56300DEA56300DEA5
      6300DEA56300DEA56300DEA56300DEA56300DEA56300E79C5200AD5A0800944A
      0000BD630000DE7B0000E78C0000E78C0000E78C0000CE841000E7AD2100EF94
      0000EF940000F7941800FFEFD600000000000000000000000000FFF7F700C69C
      8C00F7CECE00FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFEF
      D600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7C600FFDE
      C600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFDEB500FFD6B500BD7B7B008463
      6300CECECE00FFFFFF0000000000000000000000000000000000FFF7F700C69C
      8C00F7CECE00FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFEF
      D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDE
      C600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFDEB500FFD6B500BD7B7B008463
      6300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000E7CEA500DEA56300E7AD6B00E7AD7300E7AD7300E7AD7300E7AD7300E7AD
      7300E7AD7300DEAD7300D6A56B00DECEBD00EFE7DE00E77B5200DE7B4A00F7F7
      F700FFFFFF00EFF7F700DEB5A500E7632900EF520800E7520800E7520800E78C
      6300EFE7E700A59C9400CECECE00FFFFFF000000000000000000000000000000
      0000E7CEA500DEA56300E7AD6B00E7AD7300E7AD7300E7AD7300E7AD7300E7AD
      7300E7AD7300E7AD7300E7AD7300E7AD7300D68C3100BD6B0000A5520000CE73
      0000E78C0000EF940000EF940000EF940000EF940000EF940000EF940000E7A5
      2100E7940800E79C1800F7B55A00FFFFFF000000000000000000FFF7F700C6A5
      8C00F7CECE00FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      D600FFE7D600FFEFD600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7C600FFE7
      C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6B500C67B7B008C63
      6300CECECE00FFFFFF0000000000000000000000000000000000FFF7F700C6A5
      8C00F7CECE00FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      D600FFE7D600FFEFD600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7C600FFE7
      C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6B500C67B7B008C63
      6300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000E7CEA500E7AD6B00E7B57B00E7B57B00E7B58400E7B58400E7B58400E7B5
      8400E7B58400DEB57B00D6BD9400EFEFE700E7946B00EF5A1000EFC6AD00FFFF
      FF00EFCEBD00EF9C6B00EFAD7B00DEBDA500E77B4200EF631000EF5A1000E75A
      1000E79C7B00DEDEDE009C948C00F7F7F7000000000000000000000000000000
      0000E7CEA500E7AD6B00E7B57B00E7B57B00E7B58400E7B58400E7B58400E7B5
      8400E7B58400E7B58400E7B58400E7B57B00D6730800C66B0000DE840000E78C
      0000EF940000EF940000EF940000EF940000EF940000EF940000EF9C0000D694
      1800A5630800AD5A0800FFDEBD00000000000000000000000000FFF7F700C6A5
      8C00F7CECE00FFF7E700FFF7E700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFD600FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFD6BD00C67B7B008C6B
      6300CECECE00FFFFFF0000000000000000000000000000000000FFF7F700C6A5
      8C00F7CECE00FFF7E700FFF7E700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFD600FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFD6BD00C67B7B008C6B
      6300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFCEAD00E7B57B00EFBD8400EFBD8C00EFBD8C00EFBD8C00EFBD8C00EFBD
      8C00EFBD8C00DEB58400E7DECE00E7CEBD00EF6B1800EF6B1800F7D6C600F7F7
      EF00EF7B2900FF7B2100FF7B2100F77B2900E7945A00F7732100F76B1800EF6B
      1800E76B2900EFDED600B5ADA500DEDEDE000000000000000000000000000000
      0000EFCEAD00E7B57B00EFBD8400EFBD8C00EFBD8C00EFBD8C00EFBD8C00EFBD
      8C00EFBD8C00EFBD8C00EFBD8C00EFBD8C00EF9C3900E78C0000EF940000E794
      0000B56B0000BD6B0000E78C0000EF9C0000EF9C0000EF9C0000EFA500009C52
      0000944A0000C66B0000F7CE9C00000000000000000000000000FFF7F700CEA5
      8C00F7CECE00FFF7E700FFEFE700FFF7E700FFEFDE00FFEFE700FFF7EF00FFF7
      EF00FFF7EF00FFF7E700FFEFDE00FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7C600FFE7C600FFDEC600FFDEC600FFDEBD00FFD6BD00C67B7B008C6B
      6300CECECE00FFFFFF0000000000000000000000000000000000FFF7F700CEA5
      8C00F7CECE00FFF7E700FFEFE700FFF7E700FFEFDE00FFEFE700FFF7EF00FFF7
      EF00FFF7EF00FFF7E700FFEFD600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7C600FFE7C600FFDEC600FFDEC600FFDEBD00FFD6BD00C67B7B008C6B
      6300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFD6AD00EFBD8400EFC69400EFC69400EFCE9C00EFCE9C00EFCE9C00EFCE
      9C00EFC69C00DEBD9C00EFEFEF00DE9C7300EF732100F77B2100F7D6BD00E7E7
      DE00E7843900EF8C4200FF8C3100FF8C3100FF8C3100EF843900FF842900EF7B
      2900E7732100EFBD9C00D6D6D600B5B5B5000000000000000000000000000000
      0000EFD6AD00EFBD8400EFC69400EFC69400EFCE9C00EFCE9C00EFCE9C00EFCE
      9C00EFCE9C00EFCE9C00EFCE9C00EFCE9C00F7B56300EF940000EF9C0000C67B
      0000C66B0000C66B0000DE8C2100EFA52100EFAD0000EFAD0000EFAD0000E794
      0000E7840000E78C0000EF942100FFBD6B000000000000000000FFF7F700CEA5
      9400F7CECE00FFF7E700FFF7E700FFF7E700FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFEFDE00FFE7D600FFE7CE00FFE7
      CE00FFE7CE00FFE7C600FFDEC600FFDEC600FFDEC600FFDEBD00C67B7B008C6B
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFF7F700CEA5
      9400F7CECE00FFF7E700FFF7E700FFF7E700FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFEFDE00FFE7D600FFE7CE00FFE7
      CE00FFE7CE00FFE7C600FFDEC600FFDEC600FFDEC600FFDEBD00C67B7B008C6B
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFD6AD00EFC68C00F7CE9C00F7CEA500F7D6A500F7D6A500F7D6A500F7D6
      A500EFCEA500E7CEAD00EFEFEF00E78C4A00EF843100E79C6300EFD6C600FFFF
      FF00DECEC600FF943900FF943900FF943900FF9C4A00DEB59C00F7944200F78C
      3100EF843100E7A57300E7E7E700A5A59C000000000000000000000000000000
      0000EFD6AD00EFC68C00F7CE9C00F7CEA500F7D6A500F7D6A500F7D6A500F7D6
      A500F7D6A500F7D6A500F7D6A500F7C69400F79C1000EFA50000EFAD0000C673
      0000944A00006B310000C67B3900F7BD7B00EFAD0000EFAD0000EFAD0000E7A5
      0000DE9C2100C6841000A56B1000AD5A08000000000000000000FFF7F700CEA5
      9400F7CECE00FFF7EF00FFF7EF00FFFFF700FFFFFF00F7F7F70094C6940063B5
      6B0063B563008CC68C00EFF7EF00FFFFFF00FFFFFF00FFF7F700FFEFE700FFEF
      DE00FFE7D600FFE7CE00FFE7C600FFDEC600FFE7C600FFDEBD00C67B7B008C6B
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFF7F700CEA5
      9400F7CECE00FFF7EF00FFF7EF00FFFFF700FFFFFF00EFEFEF00949494007373
      7B007B7B7B009C9C9C00F7F7F700FFFFFF00FFFFFF00FFF7F700FFEFE700FFEF
      DE00FFE7D600FFE7CE00FFE7C600FFDEC600FFE7C600FFDEBD00C67B7B008C6B
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFD6B500F7CE9C00F7D6AD00F7DEAD00F7DEB500F7DEB500F7DEB500F7DE
      B500F7DEB500EFD6BD00E7E7E700E78C4200F7943900F7A55200F7D6BD00FFFF
      FF00E7B58C00FFA54200FFA54200FFA54200F7AD6300FFFFFF00DEC6AD00EF9C
      4A00EF943900E79C6300EFEFEF00A59C9C000000000000000000000000000000
      0000EFD6B500F7CE9C00F7D6AD00F7DEAD00F7DEB500F7DEB500F7DEB500F7DE
      B500F7DEB500F7DEB500F7DEB500F7D6A500EF9C0000EFAD0000EFAD00009C5A
      00007B3900009C520000D67B1800F7D6A500F79C1000EFAD0000EFAD0000EFB5
      0000EFB500009C6B10006B290000944200000000000000000000FFFFF700CEAD
      9400F7D6CE00FFF7EF00FFFFF700FFFFFF00B5D6B50021A5290000AD080000AD
      100000AD100000AD0800189C2100ADD6AD00FFFFFF00FFFFFF00FFFFFF00F7F7
      EF00E7D6CE00E7D6CE00F7EFE700FFF7E700FFE7C600FFDEC600C6847B008C6B
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700CEAD
      9400F7D6CE00FFF7EF00FFFFFF00FFFFFF00B5B5B50031313100181818001818
      2100181821001818180039393900B5B5BD00FFFFFF00FFFFFF00FFFFFF00F7F7
      F700CECECE00CECECE00EFE7E700FFEFDE00FFE7C600FFDEC600C6847B008C6B
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFD6B500F7D6A500FFDEB500FFE7BD00FFE7BD00FFE7BD00FFE7BD00FFE7
      BD00F7E7BD00EFDEBD00E7E7EF00E7945200F79C4A00FFAD4A00FFB56B00F7E7
      D600DEA56300FFAD5200FFAD5200FFAD5200EFC69C00FFFFFF00F7F7EF00DEBD
      9400EF9C4A00EFA57300EFEFEF00ADA5A5000000000000000000000000000000
      0000EFD6B500F7D6A500FFDEB500FFE7BD00FFE7BD00FFE7BD00FFE7BD00FFE7
      BD00FFE7BD00FFE7BD00FFE7BD00FFE7BD00F7AD4A00EFAD1800EFB51800D694
      1000BD630000C66B0000DE840000F7BD6B00F7A52100EFAD0800EFAD0000EFAD
      0000EFB50000A5731000944A1000E7B584000000000000000000FFFFF700CEAD
      9400F7D6CE00FFF7EF00FFFFFF00E7EFE700189C210000B5100008B518007BCE
      84007BCE840008AD100000B51000189C2100DEEFDE00FFFFFF00EFE7E700B57B
      5A009C5A21009C522100AD6B4A00DEC6BD00FFF7E700FFDEC600C6847B00946B
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700CEAD
      9400F7D6CE00FFF7EF00FFFFFF00E7E7E7003131310021212100292929008C8C
      8C0084848400212121002121210031313900EFEFEF00FFFFFF00D6D6D6006363
      6300292929002929290052525200CECECE00FFF7DE00FFDEC600C6847B00946B
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFD6B500F7D6AD00FFE7BD00FFE7C600FFEFCE00FFEFCE00FFEFCE00FFEF
      CE00FFEFC600EFDEBD00EFEFEF00DE9C6B00F7AD5200FFB55200FFC67B00F7CE
      9400EFB56300FFB55A00FFB55A00F7B56300E7C69C00F7EFDE00E7DED600EFAD
      5A00F7A55200EFBD9C00EFEFEF00BDBDB5000000000000000000000000000000
      0000EFD6B500F7D6AD00FFE7BD00FFE7C600FFEFCE00FFEFCE00FFEFCE00FFEF
      CE00FFEFCE00FFEFCE00FFEFCE00FFEFCE00FFE7C600F7BD4A00EFC63900E7C6
      3900E79C0000E79C0000EFA50000E78C0000EFAD1800EFB51000EFAD0800EFAD
      0000844A0000AD630000DEA56300FFFFFF000000000000000000FFFFF700D6AD
      9400FFD6CE00FFF7F700FFFFFF0084BD840018C6310021C63900ADDEB500FFFF
      FF00FFFFFF009CD6A50010B5180000AD080073BD7300FFFFF700AD734A00A55A
      2100B57B5200BD9473009C521800944A1800F7E7DE00FFE7CE00C6847B009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700D6AD
      9400FFD6CE00FFF7F700FFFFFF008C8C8C004242420042424200BDBDBD00FFFF
      FF00FFFFFF00ADADAD002121210018181800948C8C00FFFFF7004A4A4A002121
      21006B6B6B00737373001818180031313100F7EFE700FFE7CE00C6847B009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEB500FFDEB500FFEFC600FFEFCE00FFEFD600FFEFD600FFEFD600FFEF
      D600FFEFD600F7E7C600F7EFDE00CEB59C00F7AD5200FFB55A00FFBD6B00FFD6
      9C00E7BD8C00FFBD7300FFBD6300FFBD6B00FFBD7300F7EFDE00EFE7E700F7B5
      6300EFAD5A00F7DECE00D6CEC600E7E7E7000000000000000000000000000000
      0000EFDEB500FFDEB500FFEFC600FFEFCE00FFEFD600FFEFD600FFEFD600FFEF
      D600FFEFD600FFEFD600FFEFD600FFEFD600FFEFCE00F7BD6300E7CE5200EFCE
      5200E7C64200CE941000B56B0000C6841000EFBD2100EFB51800EFB50800DE9C
      0000944A0000B5630000EF942100FFEFD6000000000000000000FFFFF700D6AD
      9400FFD6CE00FFF7EF00F7EFE70063BD630031D652008CD69400FFFFF700EFF7
      EF00EFF7EF00F7FFF7007BCE840000B510004AAD4A00E7D6C600B56B3900BD84
      5200C68C6B00D6B59C00A55A29009C521800D6B59C00FFE7D600CE847B009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700D6AD
      9400FFD6CE00FFF7EF00F7EFE7007B73730063636300A5A5A500FFFFFF00EFEF
      EF00EFEFEF00F7F7F7007B7B8400212121006B636300DECEC6004A4A4A005A5A
      5A0094949400848484003131310018182100B5B5AD00FFE7D600CE847B009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEB500FFDEB500FFEFCE00FFF7D600FFF7D600FFF7D600FFF7D600FFF7
      D600FFF7D600FFF7D600F7E7CE00E7E7E700DE9C6B00FFB55A00FFB55A00FFC6
      7B00EFCEA500DECEBD00E7CEA500E7C69400E7C6A500FFFFFF00EFE7DE00F7B5
      5A00E7AD8400F7F7F700B5ADA500FFFFFF000000000000000000000000000000
      0000EFDEB500FFDEB500FFEFCE00FFF7D600FFF7D600FFF7D600FFF7D600FFF7
      D600FFF7D600FFF7D600FFF7D600FFF7D600FFF7D600F7C67B00EFCE6B00E7CE
      6300EFCE5A00EFCE4A00E7C63900EFBD3100EFBD2100EFB51800EFB51000DEA5
      1000D6840800E7941800EFA53100FFF7E7000000000000000000FFFFF700D6AD
      9400FFD6CE00FFEFDE00F7E7CE0063BD6B004AEF7B008CE79C007BD68C00ADDE
      B500B5DEBD0063C66B006BC6730000B5180042AD4200E7C6AD00CE845A00EFC6
      B500EFDED600EFE7DE00DEBDAD009C522100D6AD8C00FFE7D600CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700D6AD
      9400FFD6CE00FFEFDE00F7E7CE0084847B008C8C8400ADADAD009C9C9C00BDBD
      BD00BDBDC600848484007B7B7B0021212100635A5200D6BDAD0073737300C6C6
      C600E7E7E700D6D6D600B5B5B50021212900ADA59400FFE7CE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7BD00FFEFD600FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00F7EFCE00F7EFE700D6CEC600EFA56300FFB55A00FFB5
      5A00FFBD6300F7C68C00EFE7D600EFF7F700FFFFFF00FFFFFF00EFD6BD00E7A5
      6B00EFE7E700D6CEC600DEDED600000000000000000000000000000000000000
      0000EFDEBD00FFE7BD00FFEFD600FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFE7C600F7C67300EFBD
      5A00EFCE5A00EFCE4A00EFC63900EFBD3100EFBD2100EFB51000EFAD0800EFAD
      0000E7BD3100EF9C2100F7D6A500000000000000000000000000FFFFF700D6B5
      9400FFD6CE00FFEFDE00FFDEBD007BB56B005AFF8C005AF78C004AEF7B00B5E7
      BD00BDE7BD0021C6390008B5180000B5100063AD5200FFDEBD00CE845A00EFAD
      8400EFD6C600EFDECE00B5734200944A1800EFC6A500FFE7CE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700D6AD
      9400FFD6CE00FFEFD600FFDEBD0094847B009C9C9C009C9494008C848400C6C6
      C600C6C6C6004A4A4A002929290018182100847B6B00F7D6BD007B7B7300A5A5
      9C00D6D6D600D6D6D6004A4A4A0021212100E7CEB500FFE7CE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7BD00FFF7D600FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00F7E7CE00FFF7F700D6CEC600DE9C6B00FFB5
      5A00FFB55A00FFB55A00F7B56300EFC68C00EFD6B500EFC69C00DEA57B00EFE7
      DE00EFEFE700CEC6C600FFFFFF00000000000000000000000000000000000000
      0000EFDEBD00FFE7BD00FFF7D600FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFD6
      AD00EFC64A00EFC64200EFC63100EFBD2100EFB51800EFAD1000E7940000E7B5
      1000F7AD3900FFEFD600FFFFFF00000000000000000000000000FFFFF700D6B5
      9400FFD6D600FFEFE700FFD6AD00D6C68C0042CE6B0063FF9C005AF794009CE7
      AD009CDEA50029D64A0010BD2900089C1000CEBD8C00FFDEB500E7B58C00CE8C
      6300DE946B00CE845200B56B3900CE8C6300FFE7C600FFDECE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700D6B5
      9400FFD6D600FFEFE700FFDEAD00D6B5940084847B00ADADA5009C9C9C00BDBD
      BD00ADADAD005A5A5A003131310021212900DEBD9C00FFDEB500BDA58400847B
      7300848484006B6B6B00524A4A00AD947B00FFE7C600FFDECE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7C600FFF7D600FFF7DE00FFFFE700FFFFE700FFFFE700FFFF
      E700FFFFE700FFFFE700FFFFE700FFF7E700F7E7CE00F7F7EF00E7E7E700D6B5
      9C00DEAD7300E7A55A00EFA55A00E7A55A00DEAD7B00DEC6B500EFEFEF00E7D6
      CE00CEC6C600FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7C600FFF7D600FFF7DE00FFFFE700FFFFE700FFFFE700FFFF
      E700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFE7
      C600F7BD4A00EFBD3900EFAD2900EFAD2100EFB51000D68C10009C520000EFAD
      7300FFFFF7000000000000000000000000000000000000000000FFFFF700DEB5
      9C00FFD6CE00FFFFF700FFD6AD00FFCE9C0094B5630042D66B0063FF9C0063F7
      94004AE7730031DE5A0010AD210084A55200FFCEA500FFCE9C00FFCE9C00EFBD
      8400DE9C6B00D6946300E7B58400FFD6AD00FFEFD600FFE7CE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000FFFFF700DEB5
      9C00FFD6CE00FFFFF700FFD6AD00FFD69C009C846B0084848400ADA5A5009C9C
      9C00848484006363630039313900947B6300FFD6A500FFCE9C00FFCE9C00DEB5
      8C00BD9C7B00B5947300D6AD8400FFDEB500FFEFD600FFE7CE00CE8484009473
      6B00CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7C600FFF7DE00FFF7E700FFFFE700FFFFE700FFFFE700FFFF
      E700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700F7EFD600F7EFD600F7EF
      E700EFEFEF00E7E7E700E7E7E700EFEFEF00F7F7EF00F7EFE700DECEAD00DEDE
      D600FFFFFF000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7C600FFF7DE00FFF7E700FFFFE700FFFFE700FFFFE700FFFF
      E700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFFFE700FFFF
      E700FFF7DE00FFD69C00FFEFC600FFC67300EFAD2100E7A54A00DEAD6B00F7EF
      E700000000000000000000000000000000000000000000000000FFFFF700DEB5
      9C00FFD6CE00FFFFF700FFF7E700FFD6A500FFCE9400CEB57B0073B55A005AC6
      630052BD520063AD4A00CEB57300FFCE9400FFCE9400FFCE9C00FFDEB500FFDE
      BD00FFE7CE00FFE7CE00FFE7D600FFEFDE00FFEFD600FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700DEB5
      9C00FFD6CE00FFFFF700FFEFE700FFCE9C00FFCE9400C69C73008C7B6B008C7B
      73007B7363007B6B5A00D6AD7B00FFCE9400FFCE9400FFCE9C00FFDEB500FFDE
      BD00FFE7CE00FFE7CE00FFEFD600FFEFDE00FFEFD600FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7C600FFF7DE00FFFFE700FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFE700F7EF
      D600F7EFD600F7EFD600F7EFDE00F7EFD600F7E7D600F7E7CE00E7C69C00F7EF
      E700000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7C600FFF7DE00FFFFE700FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFF7DE00FFEFD600FFF7DE00E7CEA500F7EF
      E700000000000000000000000000000000000000000000000000FFFFF700DEB5
      9C00FFD6CE00FFFFF700FFFFF700FFF7E700FFD6A500FFCE9400F7C68C00E7C6
      8400E7C68C00F7C68C00FFCE9400FFD6A500FFE7CE00FFEFDE00FFF7E700FFF7
      E700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700DEB5
      9C00FFD6CE00FFFFF700FFFFF700FFEFE700FFD6A500FFCE9400F7C68C00EFBD
      8C00EFBD8C00F7C68C00FFCE9400FFD6A500FFE7CE00FFEFDE00FFF7E700FFF7
      E700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7E700E7CEA500F7EF
      E700000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7E700E7CEA500F7EF
      E700000000000000000000000000000000000000000000000000FFFFF700DEBD
      9C00FFD6CE00FFFFF700FFFFF700FFFFF700FFFFF700FFEFD600FFDEB500FFD6
      AD00FFD6AD00FFDEB500FFE7CE00FFF7EF00FFF7EF00FFF7E700FFF7E700FFF7
      E700FFF7E700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700DEBD
      9C00FFD6CE00FFFFF700FFFFF700FFFFF700FFF7F700FFEFD600FFDEB500FFD6
      AD00FFD6AD00FFDEB500FFEFD600FFF7EF00FFF7EF00FFF7E700FFF7E700FFF7
      E700FFF7E700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7E700E7CEA500F7EF
      E700000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7E700E7CEA500F7EF
      E700000000000000000000000000000000000000000000000000FFFFF700DEBD
      9C00FFD6D600FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFEFE700FFF7E700FFEFDE00FFEFDE00FFEFDE00FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700DEBD
      9C00FFD6D600FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFEFE700FFF7E700FFEFDE00FFEFDE00FFEFDE00FFE7D600CE8C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7E700E7CEA500F7EF
      E700FFFFFF000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      EF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFFFEF00FFF7E700E7CEA500F7EF
      E700FFFFFF000000000000000000000000000000000000000000FFFFF700E7BD
      9C00FFD6D600FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFF7E700FFF7E700FFEFDE00FFEFDE00FFE7DE00D68C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700E7BD
      9C00FFD6D600FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFF7E700FFF7E700FFEFDE00FFEFDE00FFE7DE00D68C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7
      EF00F7F7E700F7EFE700F7EFE700F7F7E700F7F7E700F7EFDE00DEC69C00EFE7
      DE00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFCE00FFF7E700FFFFEF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7
      EF00F7F7E700F7EFE700F7EFE700F7F7E700F7F7E700F7EFDE00DEC69C00EFE7
      DE00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFF700E7BD
      9C00FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFF7F700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFE7DE00D68C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700E7BD
      9C00FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFF7F700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFE7DE00D68C84009C7B
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFEF00F7EF
      E700EFE7D600E7DECE00E7DEC600E7DECE00E7DECE00EFDECE00D6BD9400E7DE
      D600FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFEF00F7EF
      E700EFE7D600E7DECE00E7DEC600E7DECE00E7DECE00EFDECE00D6BD9400E7DE
      D600FFFFFF00FFFFFF0000000000000000000000000000000000FFFFF700E7BD
      9C00FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFEFE700FFE7DE00FFE7D600FFE7DE00FFDED600D68C8400A584
      7300CECECE00FFFFFF0000000000000000000000000000000000FFFFF700E7BD
      9C00FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFEFE700FFE7DE00FFE7D600FFE7D600FFDED600D68C8400A584
      7300CECECE00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700F7F7EF00EFE7
      D600DECEBD00CEBDA500C6BDA500CEBDA500D6C6AD00DECEB500CEB58C00E7E7
      D600FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700F7F7EF00EFE7
      D600DECEBD00CEBDA500C6BDA500CEBDA500D6C6AD00DECEB500CEB58C00E7E7
      D600FFFFFF00FFFFFF0000000000000000000000000000000000FFFFF700E7C6
      A500FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFF700FFFFF700FFF7F700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700EFC6BD00E7949400EF9C9400EF9C9400EF9C9C00CE8C8400AD8C
      7B00D6D6D600FFFFFF0000000000000000000000000000000000FFFFF700E7C6
      A500FFD6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFF700FFFFF700FFF7F700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700EFC6BD00E7949400EF9C9400EF9C9400EF9C9C00CE8C8400AD8C
      7B00D6D6D600FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7F7EF00E7DE
      CE00CEB58C00CEA56B00B59C7300BDA58C00C6B59C00D6B58C00CEB59400F7F7
      EF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7F7EF00E7DE
      CE00CEB58C00CEA56B00B59C7300BDA58C00C6B59C00D6B58C00CEB59400F7F7
      EF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFF700E7C6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7
      EF00F7E7D600CE9C7B00D6AD7B00CE9C6B00CE945A00C68C5200BD845200C6AD
      9C00F7F7F7000000000000000000000000000000000000000000FFFFF700E7C6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7
      EF00F7E7D600CE9C7B00D6AD7B00CE9C6B00CE945A00C68C5200BD845200C6AD
      9C00F7F7F7000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7EFE700DED6
      C600D6B57B00F7CE9C00E7BD8400D6B57B00D6B57300C6A57300EFE7DE00FFFF
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7EFE700DED6
      C600D6B57B00F7CE9C00E7BD8400D6B57B00D6B57300C6A57300EFE7DE00FFFF
      F700FFFFFF000000000000000000000000000000000000000000FFFFF700EFC6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7F700FFFFF700FFF7EF00FFF7
      EF00F7E7DE00DEB58C00EFD69400E7BD7B00DEAD6B00D69C5A00C6B5A500F7F7
      F700000000000000000000000000000000000000000000000000FFFFF700EFC6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7F700FFFFF700FFF7EF00FFF7
      EF00F7E7D600DEB58C00EFD69400E7BD7B00DEAD6300D69C5A00C6B5A500F7F7
      F700000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7EFE700E7DE
      CE00DEBD7B00FFE7C600FFE7C600FFE7C600CEAD7300E7E7D600F7F7F700FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFEFD600FFF7EF00FFFFF700FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7EFE700E7DE
      CE00DEBD7B00FFE7C600FFE7C600FFE7C600CEAD7300E7E7D600F7F7F700FFFF
      FF00000000000000000000000000000000000000000000000000FFFFF700EFC6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7F700FFF7
      F700F7E7DE00DEBD9400F7DEA500EFCE9400DEBD8400C6BDAD00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFF700EFC6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7F700FFF7
      F700F7E7DE00DEBD9400F7DEA500EFCE9400DEBD8400C6BDAD00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7D600FFF7E700FFF7EF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700E7DE
      CE00E7BD8400FFEFCE00FFEFCE00D6BD8C00E7DED600F7F7EF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7D600FFF7E700FFF7EF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFF7EF00F7EFE700E7DE
      CE00E7BD8400FFEFCE00FFEFCE00D6BD8C00E7DED600F7F7EF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFF700EFC6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFF
      F700F7E7DE00E7BD9C00F7E7AD00EFDEA500C6BDB500F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000FFFFF700EFC6
      A500FFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFF
      F700F7E7DE00E7BD9C00F7E7AD00EFD6A500C6BDB500F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7CE00FFEFE700FFF7E700FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFEFE700F7E7
      DE00DEBD8C00FFE7CE00DEC69C00DED6CE00F7F7EF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFDEBD00FFE7CE00FFEFE700FFF7E700FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFEFE700F7E7
      DE00DEBD8C00FFE7CE00DEC69C00DED6CE00F7F7EF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7CE
      A500FFD6CE00FFE7E700FFE7E700FFE7E700FFE7E700FFE7DE00FFE7DE00FFDE
      DE00FFDEDE00FFDEDE00FFDEDE00FFDED600FFDED600FFDED600FFD6D600FFD6
      D600F7CEBD00E7C69C00EFE7B500CEC6BD00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7CE
      A500FFD6CE00FFE7E700FFE7E700FFE7E700FFE7E700FFE7DE00FFE7DE00FFDE
      DE00FFDEDE00FFDEDE00FFDEDE00FFDED600FFDED600FFDED600FFD6D600FFD6
      D600F7CEBD00E7C69C00EFE7B500CEC6BD00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7EFDE00EFDEBD00EFDEBD00EFDEBD00EFDEC600EFDEC600EFDEC600EFDE
      C600EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600EFDEBD00E7D6
      BD00D6BD9C00D6BD8C00DED6BD00F7F7F700FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7EFDE00EFDEBD00EFDEBD00EFDEBD00EFDEC600EFDEC600EFDEC600EFDE
      C600EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600EFDEC600EFDEBD00E7D6
      BD00D6BD9C00D6BD8C00DED6BD00F7F7F700FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFDE
      BD00FFCEAD00F7CEAD00F7CEAD00F7C6A500F7C6A500EFC6A500EFC6A500EFBD
      A500EFBDA500EFBDA500E7BDA500E7BD9C00E7B59C00E7B59C00E7B59C00E7B5
      9C00DEAD9400E7C6A500DEDECE00F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFDE
      BD00FFCEAD00F7CEAD00F7CEAD00F7C6A500F7C6A500EFC6A500EFC6A500EFBD
      A500EFBDA500EFBDA500E7BDA500E7BD9C00E7B59C00E7B59C00E7B59C00E7B5
      9C00DEAD9400E7C6A500DEDECE00F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
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
      00000000000000000000000000000000FFE0000F000000000000000000000000
      FF80000F000000000000000000000000FE00000F000000000000000000000000
      F800000F000000000000000000000000F0000009000000000000000000000000
      E0000000000000000000000000000000C0000000000000000000000000000000
      C000000000000000000000000000000080000001000000000000000000000000
      8000000100000000000000000000000080000001000000000000000000000000
      40000002000000000000000000000000C0000003000000000000000000000000
      C0000003000000000000000000000000C0000001000000000000000000000000
      8000000100000000000000000000000080000001000000000000000000000000
      8000000100000000000000000000000080000001000000000000000000000000
      C0000001000000000000000000000000C0000003000000000000000000000000
      C0000003000000000000000000000000C0000003000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      F000000F000000000000000000000000F800001F000000000000000000000000
      FC00003F000000000000000000000000FE00007F000000000000000000000000
      FF0000FF000000000000000000000000FFC003FF000000000000000000000000
      FFF81FFF000000000000000000000000C0000003C0000003FFFF800FFFFFE00F
      C0000003C0000003F0000007F000000FC0000003C0000003F0000003F0000003
      C0000003C0000003F0000001F0000001C0000003C0000003F0000000F0000000
      C0000003C0000003F0000000F0000001C0000003C0000003F0000000F0000001
      C0000003C0000003F0000000F0000000C0000003C0000003F0000000F0000000
      C0000003C0000003F0000000F0000000C0000003C0000003F0000000F0000000
      C0000003C0000003F0000000F0000000C0000003C0000003F0000000F0000000
      C0000003C0000003F0000000F0000000C0000003C0000003F0000001F0000001
      C0000003C0000003F0000001F0000001C0000003C0000003F0000003F0000007
      C0000003C0000003F0000007F000000FC0000003C0000003F000000FF000000F
      C0000003C0000003F000000FF000000FC0000003C0000003F000000FF000000F
      C0000003C0000003F0000007F0000007C0000003C0000003F0000003F0000003
      C0000003C0000003F0000003F0000003C0000003C0000003F0000003F0000003
      C0000003C0000003F0000003F0000003C0000007C0000007F0000007F0000007
      C000000FC000000FF000000FF000000FC000001FC000001FF000000FF000000F
      C000003FC000003FF000001FF000001FC000007FC000007FF000003FF000003F
      C00000FFC00000FFFFFFE07FFFFFE07F00000000000000000000000000000000
      000000000000}
  end
  object ImageList2: TImageList
    Height = 32
    Width = 32
    Left = 232
    Top = 8
    Bitmap = {
      494C010104000900040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBFCFBFFECF2EBFFECF2EBFFFBFCFBFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F5E00001F5E00001F5E00001F5D0000215A0000205B
      00001C620200166C0700137009000F760C0010760C0013700900176B07001D62
      0200205C0000205A00001F5D00001F5E00001F5E00001F5E0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00FAFAFA00FAFAFA00FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFEFFFEFEFEFFFCFC
      FCFFFCFCFCFFFEFEFEFFFEFEFEFFFEFEFEFF0000000000000000000000000000
      0000FEFEFEFFE8F0E7FF6DAA68FF6AA865FFE7F0E6FFFEFEFEFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001F5E00001F5E00001F5E0000215A00001E60020012750D000A88
      19000D952500159C30001E9F380023A03B00219F39001B9D350013992C000B92
      22000A86170014730C001F5F0100215A00001F5E00001F5E00001F5E00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500DCDCDC00C2C2C400AEAEB400A8A8B000A8A8B000B3B3B700CACACA00E5E5
      E500FBFBFB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00FAFAFA00FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFEFFFAFAFAFFF6F6
      F6FFF0F0F0FFEBEBEBFFE7E7E7FFE3E3E3FFDFDFDFFFDEDEDEFFDBDBDBFFD9D9
      D9FFD9D9D9FFDBDBDBFFDEDEDEFFDFDFDFFFE3E3E3FFE7E7E7FFEBEBEBFFF0F0
      F0FFE9EDE8FF84B57FFF007A02FF007901FF85B680FFF2F6F1FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001F5E00001F5E0000205C0000205C000013760E000994210017A236002BA6
      450032A447002EA04200279C3B00259B3900249A3800259B39002A9D3D002C9E
      3F00249E3B00129B2E00088F1D0014740D00205C0000205C00001F5E00001F5E
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00D3D3D3008E8EA000504E
      880026238700120D8C0007029000060193000601930009048E0018138B00322F
      860062618C00A5A5AE00E6E6E600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FBFBFB00E3E3E300C3C3C300BCBCBC00D9D9
      D900F8F8F8000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F0FFE5E5E5FFDDDDDDFFD6D6
      D6FFD1D1D1FFCDCDCDFFCBCBCBFFC9C9C9FFC8C8C8FFC7C7C7FFC7C7C7FFC6C6
      C6FFC6C6C6FFC7C7C7FFC7C7C7FFC8C8C8FFC9C9C9FFCBCBCBFFCDCDCDFFCACD
      CAFF8CAF87FF09820FFF007A02FF007B03FF0A8310FFA5C8A0FFF7FAF7FF0000
      0000000000000000000000000000000000000000000000000000000000001F5E
      00001F5E0000205B00001D630400098D1B0010A5350027A74400239F3C001096
      2900028F1D00008D1800008C1700008C1600008C1700008C1700008C1700038E
      1C000F9327001F9A3500209D38000C9B2A000A8818001E620300205B00001F5E
      00001F5E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D9D9D900727193001F1C890006009B000600
      A3000600A2000400A00002009D0002009C0002009D0002009E000600A1000600
      A3000600A20006019400353287009595A500EFEFEF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE0090909000AAAAAA00B7B7B7009393
      9300B5B5B500EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F8F8FFF6C6C6CFF707070FF7676
      76FF7D7D7DFF828282FF878787FF8B8B8BFF8E8E8EFF919191FF939393FF9696
      96FF959595FF939393FF8F8F8FFF8C8C8CFF878787FF838383FF7C7E7CFF5D74
      59FF0D8118FF00820AFF00820CFF00830DFF00850EFF1A8E25FFC1D8BDFFFAFC
      FAFF0000000000000000000000000000000000000000000000001F5E00001F5E
      0000215B00001B6706000699240017A93D001EA23C000895240000901A000091
      1C0000921E0000931F0000931F0000931F0000931E0000921E0000921E000091
      1D00008F1A00008D1900089222001A9A3300119C2F0006921F001C650500205B
      00001F5E00001F5E000000000000000000000000000000000000000000000000
      000000000000FEFEFE00A3A3AE00282589000600A1000600A20002009B000000
      9A000000A1000612AB000F1FB1001425B5001424B4000E1BAE00020CA7000000
      9E0000009A0004009D000600A400060099004A488A00CDCDCE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFAFA00CDCDCD0098989800F0F0F000F8F8F800F7F7F700FFFF
      FF00B6B6B6009B9B9B00DFDFDF00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000004E4E4EFF686868FF7B7B7BFF9191
      91FFA6A6A6FFB7B7B7FFC6C6C6FFD5D5D5FFE3E3E3FFEFEFEFFFF9F9F9FFFFFF
      FFFFFDFDFDFFF3F3F3FFE7E7E7FFDBDBDBFFCCCCCCFFBABBBAFF919F8EFF2388
      2DFF008A13FF008913FF008B16FF008C17FF008C17FF008E18FF379B40FFD7E5
      D4FFFCFDFCFF00000000000000000000000000000000000000001F5E0000205B
      00001C650500069D280016AB3E00119E310000931E0000952000009621000097
      2300009823000097220000951D0000951C0000951C0000941C00009621000096
      2200009521000094200000911D0000901C000F972B00109C2F00069521001D64
      0500205C00001F5E000000000000000000000000000000000000000000000000
      0000FBFBFB0081819C000A0595000600A300040099000206A200122EBD003158
      D600507AE600658EEE007299F200799EF2007B9FF2007699F0006A8DEA005274
      DF002F4DCB000C1EB10000009D0004009C000600A40024218C00B7B7BE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAFAFA00C8C8C80099999900F8F8F800FCFCFC00F9F9F900F5F5F500F7F7
      F700FFFFFF00DCDCDC008E8E8E00C4C4C400F2F2F20000000000000000000000
      000000000000000000000000000000000000444444FF515151FF616161FF7272
      72FF858585FF969696FFA7A7A7FFB8B8B8FFCBCBCBFFDDDDDDFFEAEAEAFFF5F5
      F5FFEEEEEEFFDEDEDEFFCECECEFFBEBEBEFFACADACFF8D958BFF318438FF0091
      1BFF008F1AFF00911DFF00931EFF00941FFF009520FF009520FF009721FF57A8
      5DFFE6EEE4FFFEFEFEFF0000000000000000000000001F5E00001F5D00001F5E
      01000798240010AD3D000B9E2E000096200000992400009A2600009B2600009C
      2700009C2600059E2C0027AC48002BAD4B002BAD4C0026AB4700039D2900009A
      2500009A250000982400009723000095210000931D000A9728000A9D2D00098F
      1E00205D01001F5E00001F5E0000000000000000000000000000000000000000
      000082829E0006009B0006009E000204A0001137C600326BE9004F86F5005489
      F4004980F1003B75EE00306CEC002D6AEB002F69EA00386EEA004879EC005C87
      EE006892F1005E88EC00375DD8000C21B30000009B000600A3001A159000BFBF
      C500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F900C8C8C8009D9D9D00FFFFFF00FFFFFF00FBFBFB00F6F5F500EFEDED00B7B6
      B600EFEEEE00FFFFFF00FCFCFC00A1A1A100A0A0A000E1E1E100FCFCFC000000
      0000000000000000000000000000000000004F4F4FFF616161FF747474FF8989
      89FF979797FFA3A3A3FFAEAEAEFFBBBBBBFFCDCDCDFFDFDFDFFFE9E9E9FFF0F0
      F0FFE8E8E8FFDADADAFFCDCDCDFFC0C0C0FFA8ADA7FF518F54FF009821FF0095
      20FF009823FF009A25FF009C27FF009D28FF009D28FF009D28FF009E28FF009D
      27FF7AB67BFFEFF4EEFF00000000000000001F5E00001F5E0000215900000F84
      180008B03A000AA1310000992400009C2700009E2900009F2A0000A02A0000A1
      2B00009C200060C57B00F9FDFA00FBFEFC00FBFEFC00F8FDFA0054BF6F00009A
      1F00009E2900009D2800009B2700009A2500009823000095200008982800049F
      2B00117F1400215A00001F5E000000000000000000000000000000000000A9A9
      B6000904980006009D00041AB0001557E6002E76F8002E72F3001963F0000458
      EE000053EC000051EB000050EA00004FE900004FE800004DE700004CE600004D
      E6000E54E6002D65E700497BEC004476EB001A41CC000206A1000600A2002926
      8E00E1E1E1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900C3C3
      C3009E9E9E00FFFFFF00FFFFFF00FEFEFE00FBFAFA00E7E5E500ACABAB00DBDA
      DA00A7A6A600B2B1B100F9F9F900FFFFFF00CBCBCB008B8B8B00C5C5C500F2F2
      F20000000000000000000000000000000000565656FF626262FF767676FF8B8B
      8BFF9A9A9AFFA6A6A6FFB1B1B1FFBDBDBDFFD1D1D1FFE5E5E5FFECECECFFF1F1
      F1FFE9E9E9FFDCDCDCFFCFCFCFFFBABEBAFF6F9A6EFF049C29FF009B26FF009E
      29FF00A02BFF00A22DFF00A32EFF00A530FF00A531FF00A631FF00A530FF00A6
      31FF06A22FFF9CC599FFF6F9F6FF000000001F5E0000205C00001B68060004AB
      330009A93600009C2700009F290000A12C0000A32D0000A42E0000A52F0000A5
      2F0000A1230073CE8D00FFFFFF00FFFFFF00FFFFFF00FFFFFF0064C88000009F
      210000A32D0000A22C0000A02B00009E2800009D2800009A250000992300069B
      2900039E28001D660600205C00001F5E00000000000000000000E4E4E4002623
      910006009F000624B900095FF2001468F7000B60F3000059F1000058F1000058
      F0000058EF000057EE000056ED000055EC000054EB000054EA000053E9000052
      E800004EE600004CE600004FE6001F5EE700316CEC00184CD900040CA5000600
      A20065639800FEFEFE0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900C2C2C2009F9F
      9F00FFFFFF00C0D1CB007FA3970060907F0058877700577B6E00B4C5BF00E4E4
      E400E3E3E300D2D1D100A3A2A200E8E7E700FFFFFF00F1F1F1009A9A9A009F9F
      9F00E1E1E100FBFBFB000000000000000000545454FF616161FF767676FF8B8B
      8BFF9A9A9AFFA6A6A6FFB1B1B1FFBDBDBDFFD3D3D3FFE9E9E9FFEFEFEFFFF2F2
      F2FFE9E9E9FFDCDCDCFFCACCC9FF8CA989FF12A139FF00A12DFF00A12BFF00A4
      2DFF00A731FF00AA33FF00AB35FF00AC37FF00AD37FF00AD37FF00AD36FF00AC
      35FF00AE38FF17A73FFFBAD4B6FFF9FBF9FF1F5E0000215900000E8B1D0004B4
      3B0002A22D0000A22B0000A42E0000A6300000A7310000A8320000A9330000AA
      320000A6280070D08D00FFFFFF00FFFFFF00FFFFFF00FFFFFF0061CA800000A4
      260000A7310000A6300000A52E0000A32D0000A12B00009F2900009C2700029B
      270002A22B0010841800215900001F5E000000000000000000008181A4000600
      A0000923B7000F64F5000C64F700085FF300045EF300005BF3000055F2000054
      F100005AF1000059F0000058EF000057EE000056ED000056EC000055EC000051
      EA000050E900004DE800004EE700004FE6000852E600165CEA000845D9000409
      A4000C079700C9C9CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700BFBFBF009E9E9E00FEFE
      FE0099B6AC002F715A00045D40000761430007614300045C400027695200809D
      9300DBDBDB00E9E9E900DDDDDD009C9B9B00D2D0D000F0F0F000FAFBFB00C0C0
      C000898A8A00C5C5C500F5F5F50000000000545454FF616161FF767676FF8B8B
      8BFF9A9A9AFFA6A6A6FFB1B1B1FFBCBCBCFFD4D4D4FFECECECFFF2F2F2FFF3F3
      F3FFE9E9E9FFDCDCDCFFB0BFAEFF2EA850FF1DB759FF1BB555FF15B652FF0FB5
      4DFF08B446FF07B646FF05B645FF04B746FF06B847FF06B949FF0DBC51FF13BF
      58FF19C05EFF1CC466FF3BB05BFFDAE7D8FF1F5D00001E61020005AA320003AD
      360000A42D0000A7300000A9320000AA330000AC350000AD360000AE370000AF
      370000AB2B0070D38F00FFFFFF00FFFFFF00FFFFFF00FFFFFF0061CD820000A9
      2B0000AC350000AB340000A9320000A8310000A62E0000A42D0000A12B00009E
      2900019E2900069C26001F6002001F5D000000000000F1F1F1002A2794000811
      AC001562EF001469F7001164F4000F63F400005BF4000E61F400A2BFFA007EA6
      F8000053F2000059F200005BF1000059F1000059F0000058EF000051ED000B57
      ED00B1C6F800A6BEF7000E55EA00004BE8000051E8000050E7000255EB00043A
      CF000600A400706EA00000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F800BBBBBB00A3A3A300F5F8F7005288
      750006644400217B5C00378A6C003D8D70003F8D71003D8A6F00287B5F000863
      4400487E6C00DCDFDE00F4F4F400F2F2F200A2A2A20097959500D9D7D700EEED
      ED00DFDFDF0095959500C4C4C40000000000505050FFA1A1A1FFAEAEAEFFBBBB
      BBFFC4C4C4FFCBCBCBFFD1D1D1FFD8D8D8FFE8E8E8FFF9F9F9FFFBFBFBFFFAFA
      FAFFF4F4F4FFECECECFFA8C7A9FF38C976FF3CC677FF3AC979FF3CCB7BFF3DCF
      7EFF42D186FF2BCB74FF2ACC74FF2ACD75FF2ACE76FF41D589FF3CD180FF3DCF
      80FF3DCD7DFF3DCC7CFF39C976FFBFDABEFF205A000017740E0001B83C0001A9
      330000A8310000AC330000AD360000AE360000AF360000B0370000B2380000B3
      380000AF2C006ED59000FFFFFF00FFFFFF00FFFFFF00FFFFFF005FCF830000AD
      2B0000B0360000AE350000AC330000AA320000A9320000A8310000A62F0000A2
      2C0000A02A0001A52C0019700C00205B000000000000C0C0C90004019B00154D
      D9001B70FA001869F4001668F400025FF3002F74F500C7D9FC00FFFFFF00FFFF
      FF0097B8FA000259F3000058F300005CF300005BF2000052F1001B61F100C1D3
      FB00FFFFFF00FFFFFF00CCD9FB00356EEE00004DEA000053E9000052E8000255
      EB00041FBC002F2A9600F5F5F500000000000000000000000000000000000000
      00000000000000000000F7F7F700BBBBBB00A3A3A300FDFEFD0067978700076C
      48001D855D0020875F001B825B001F845E001E815C00177B56001F7D5B00237C
      5D000A6747005F907F00EBECEC00F9F9F900FEFFFF00E1E1E10092929200BCB9
      B900CDC9C900D3D2D2009B9B9B0000000000E5E5E5FF565656FF686868FF7979
      79FF8A8A8AFF989898FFA4A4A4FFB0B0B0FFB9B9B9FFC0C0C0FFC7C7C7FFCDCD
      CDFFCBCBCBFFC4C4C4FFB9BAB8FF9DAB9DFF92A292FF889789FF7D8C7DFF667C
      67FF57B97CFF4BDC94FF3AD687FF3AD788FF4BDF98FF6BCF90FFCBE1CCFFDFED
      DFFFDDEBDDFFDCEBDCFFDFEDDFFFFAFCFAFF2158000011881C0000BB3E0000AB
      330000AD360000B0380000B1390000B43B000CB846000BBA46000BBB47000BBC
      48000BB83D0076DA9900FFFFFF00FFFFFF00FFFFFF00FFFFFF0068D48D000BB6
      3C000BB945000BB744000BB542000CB4410000AE360000AB340000AA320000A7
      300000A32D0000A82E001383170021590000000000008F8FAF000C1DB8002270
      F6001F6EF6001D6CF5000F65F400528BF700ECF2FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B7CDFC001864F4000058F3000054F2002E6FF400D3E0FC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F3F7FE003F77F000004FEB000054EB000056
      EC000245DC000E0E9F00D7D7DB00000000000000000000000000000000000000
      000000000000F6F6F600B6B6B600A3A3A300FFFFFF00B7CEC600096B4800178A
      5D0016895B000B83530046A17D00EEF6F300EEF6F300499D7D00017448000D76
      4F000E744F0005634200ADC5BD00F4F4F400FBFBFB00FFFFFF00F6F7F700A2A2
      A200B1AFAF00BEBEBE00A8A8A80000000000505050FF606060FF757575FF8B8B
      8BFF9F9F9FFFB2B2B2FFC3C3C3FFD4D4D4FFE3E3E3FFF0F0F0FFFBFBFBFFFFFF
      FFFFFFFFFFFFF3F3F3FFE7E7E7FFD8D8D8FFC8C8C8FFB7B7B7FFA4A4A4FF8F8F
      8FFF5AAC73FF5FE7A9FF4ADF97FF4AE098FF5FEAABFF7BCC93FFFCFDFCFF0000
      000000000000000000000000000000000000205900000D9A280007BE450000AE
      360000B1390000B33B0000B333006FD79200E2F7E900E1F7E900E1F7E900E1F7
      E900E0F7E800EEFBF300FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECFAF100E0F6
      E700E1F7E900E1F7E800E1F7E800E2F6E80069D28B0000AC2E0000AE350000AA
      330000A8310006AC36000F8D1F0021590000000000007474A2001A47D9002878
      FB002370F500226FF500196AF5004F88F700D5E2FC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D2E0FC002A70F5003E7CF600E3ECFD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC5FB00246AF1000054ED000056EC000056
      EC000256ED00041DB700BEBEC900000000000000000000000000000000000000
      0000F6F6F600B4B4B400AAAAAA00FFFFFF00FFFFFF006FA39200188B5D001C95
      6300128F5C00078A540043A67E00FFFFFF00FFFFFF004BA58100007B4900067B
      4E000D7A50000B724C00689D8C00F7F7F700FCFCFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C500D3D3D300000000004E4E4EFF555555FF686868FF7B7B
      7BFF8C8C8CFF9D9D9DFFADADADFFBDBDBDFFD0D0D0FFE2E2E2FFEFEFEFFFFBFB
      FBFFF4F4F4FFE3E3E3FFD3D3D3FFC2C2C2FFB1B1B1FFA0A0A0FF8F8F8FFF7B7D
      7BFF59AD75FF6FEEB7FF5BE7A6FF5BE8A7FF6FF1BAFF7CCF97FFF4F8F4FF0000
      000000000000000000000000000000000000205A00000CA6320013C350000DB6
      430000B63C0000B83E0000B6350094E3B000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0095E1AE0000AF300000B1380000AE
      36000EB03F0012B141000D9A2900205A0000000000007275A4002764EF002B79
      F9002973F6002572F6002370F500397DF6005189F600B9CDFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7EFFE00EEF4FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFEFF009AB9F9003F7DF5001461F1000058F0000058EF000057
      EE00005BF2000436CE00B9B9C60000000000000000000000000000000000F6F6
      F600B4B4B400AAAAAA00FFFFFF00FFFFFF00FFFFFF0066A99000209D6800249F
      6B005FB9930062B9940087C9AE00FFFFFF00FFFFFF008CC8AF005CAF8D0061AF
      9000248D64000E7D52005F9E8800FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D0D0D000D3D3D3000000000000000000565656FF676767FF7D7D7DFF9494
      94FFA2A2A2FFAFAFAFFFBBBBBBFFC8C8C8FFD9D9D9FFEBEBEBFFF3F3F3FFFCFC
      FCFFF6F6F6FFE7E7E7FFD9D9D9FFCCCCCCFFBEBEBEFFB2B2B2FFA4A4A4FF9395
      92FF62B57EFF7EF5C4FF6AEDB3FF6AEEB4FF7EF7C6FF7FD19AFFF4F8F4FF0000
      0000000000000000000000000000000000001E5A000012AB39001AC8580019BD
      510010BE4D0001BC430000BA38008FE3AD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008FE0AB0000B3320002B53D0012B7
      47001AB74B0019B74A0012A131001F5B000000000000767FAB002F74FA002F7A
      F7002D76F6002B75F6002974F6002471F6004383F7004984F5009DBAF800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFBFE0086ABF7003C7CF5001464F400005AF300005BF200005AF1000059
      F100005CF3000246E000BABBC700000000000000000000000000F5F5F500B4B4
      B400A8A8A800FFFFFF00ECECEC0084848400828282003F886B0022A56C0030AA
      7500F5FCF900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004EA883000C83540065A88F00FDFDFD00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00D5D5D500000000000000000000000000555555FF656565FF7B7B7BFF9191
      91FFA0A0A0FFADADADFFBABABAFFC7C7C7FFDADADAFFEDEDEDFFF4F4F4FFFDFD
      FDFFF6F6F6FFE7E7E7FFD9D9D9FFCBCBCBFFBDBDBDFFB0B0B0FFA2A2A2FF9394
      93FF64BC85FFA8FFE3FF96FCD4FF98FCD5FFABFFE6FF82D79FFFFBFCFBFF0000
      0000000000000000000000000000000000001E59000016AB3B0022CF62001CC1
      55001EC55A0019C6580002C2440094E6B300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0095E4B10002BB3E0019C053001EBE
      54001CBB4F0022BE5400169C2F001F590000000000007884AF00337BFE00337C
      F7003179F6002F79F6002E77F6002B75F6002471F600397EF7003177F5007CA3
      F600EFF3FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6ED
      FD006494F500226CF4000F64F400045EF300085FF300045EF300025DF300005C
      F200005DF500024EE700BABCC8000000000000000000F6F6F600B2B2B200AAAA
      AA00FFFFFF00E7E7E70079797900BEBEBE00BFBFBF0062A3880035B07A003DB2
      8000BAE1D100D8EDE400DAEEE600FEFFFE00FFFFFF00DDF0E800D8EEE500D4EC
      E20041A77C00148E5C0076B69D00FFFFFF00FFFFFF00FFFFFF00CECECE00D5D5
      D50000000000000000000000000000000000555555FF656565FF7B7B7BFF9191
      91FFA0A0A0FFADADADFFBABABAFFC6C6C6FFDBDBDBFFF0F0F0FFF6F6F6FFFDFD
      FDFFF6F6F6FFE7E7E7FFD9D9D9FFCBCBCBFFBDBDBDFFB0B0B0FFA2A2A2FF9494
      94FF5C8C67FF54A974FF4A9C67FF89D9A6FF89DAA7FFADDAB6FF000000000000
      0000000000000000000000000000000000001F570000189D31002DD86F0020C6
      5B0021CA5F0022CC620016CC5B007AE3A200DBF8E700D8F7E400D3F7E100D3F7
      E100D3F7E000E7FBEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4FAED00D3F6
      E000D3F6E100D3F6E100D8F7E400DBF7E50075DE9C0016C5560022C55B0021C3
      580020BF55002EC761001792270020570000000000007986B100387EFE00377F
      F700357CF700337CF700327AF6003079F6002E78F6002975F6002974F6001466
      F300BDD0FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1D3
      FB000F64F3000660F4001164F4001164F4000E62F4000C61F4000860F400065E
      F3000260F7000251EB00BDBFCB0000000000FBFBFB00BCBCBC00ABABAB00FFFF
      FF00E9E9E90076767600B2B2B200B0B0B000B6B6B6008EAEA1004AB5860054BF
      90004FB98B0058BD91006BC49D00FCFEFD00FFFFFF0062BF970038AD7B002BA6
      7100209E690020986600BCDDD000FFFFFF00FFFFFF00CCCCCC00D5D5D5000000
      000000000000000000000000000000000000555555FF656565FF7B7B7BFF9191
      91FFA0A0A0FFADADADFFBABABAFFC5C5C5FFDCDCDCFFF3F3F3FFF8F8F8FFFDFD
      FDFFF6F6F6FFE7E7E7FFD9D9D9FFCBCBCBFFBDBDBDFFB0B0B0FFA2A2A2FF9494
      94FF808080FF6A6A6AFF505050FF000000000000000000000000000000000000
      00000000000000000000000000000000000020580000158A1F0038E07A0027CC
      640025CE640026D1670026D3690024D469002AD76F0026D86E001ED8690015D8
      65000AD5580076E9A600FFFFFF00FFFFFF00FFFFFF00FFFFFF0068E59B000AD2
      560016D462001ED3660027D36A0029D26A0023CE630026CC630026C9600025C6
      5E0029C35D0036CD6B001582180000000000000000008994B900397EFC003C83
      F7003A80F700387FF700367DF700337CF700337BF6002874F6002F78F600B9D0
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CADAFC003076F6000660F4001567F4001266F4001164F4000F63F4000C62
      F4000963F7000952E500D2D3DA0000000000F2F2F200A4A4A400FFFFFF00E9E9
      E90073737300B0B0B000AFAFAF00B6B6B600BBBBBB00BEBFBE0070B296006FCB
      A2006DCAA00062C6990080D1AD00FFFFFF00FFFFFF0073C9A30036B07B0030AC
      760027A76F0079C2A300FDFEFE00FFFFFF00CBCBCB00DCDCDC00000000000000
      000000000000000000000000000000000000595959FFA3A3A3FFB1B1B1FFBEBE
      BEFFC8C8C8FFD1D1D1FFD9D9D9FFE0E0E0FFEFEFEFFFFDFDFDFFFFFFFFFFFFFF
      FFFFFDFDFDFFF5F5F5FFECECECFFE4E4E4FFDBDBDBFFD3D3D3FFCACACAFFC1C1
      C1FFB4B4B4FFA7A7A7FF515151FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000156F080037DC76003AD6
      760027D168002AD56D002AD76F0029D8700027DA700028DC720029DE740029DF
      75001ADE6D0085EEB100FFFFFF00FFFFFF00FFFFFF00FFFFFF0078EAA8001BDB
      6B0029DB720029D9700027D76E0027D46B0029D26B002AD069002ACD660026C9
      61003DCC6F0033CA6500166B06000000000000000000B7BBCC003674F4004287
      F9003E83F7003B82F7003A80F700397FF7002D77F7004184F700CCDCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E1EBFD004C87F7000460F4001869F4001667F4001466F4001265
      F4001167FA00245BD300F2F2F20000000000F1F1F100CFCFCF00F4F4F4006F6F
      6F00ACACAC00ADADAD00B4B4B400B9B9B900BDBDBD00C2C2C200C1C6C40074BE
      9E0082D4AF0084D6B0007ED0AB008DCCB1008FCDB30069C59C0056BF900047B7
      86006FC49F00F6FBF900FFFFFF00CCCCCC00DDDDDD0000000000000000000000
      000000000000000000000000000000000000E5E5E5FF565656FF676767FF7878
      78FF898989FF969696FFA2A2A2FFADADADFFB8B8B8FFC1C1C1FFC5C5C5FFC8C8
      C8FFC6C6C6FFC0C0C0FFB8B8B8FFAFAFAFFFA5A5A5FF989898FF8B8B8BFF7B7B
      7BFF696969FF585858FFE5E5E5FF000000000000000000000000000000000000
      0000000000000000000000000000000000001F5D00001B5B000022C0530057E9
      93002CD46D002DD872002EDB74002EDD76002EDF78002DE179002DE27A002DE4
      7B0020E474008AF1B600FFFFFF00FFFFFF00FFFFFF00FFFFFF007DEDAD0022DF
      72002EE078002DDE76002EDC75002ED873002ED770002ED46E002DD06B002DCD
      680058DA87001EB144001C5A00001F5E000000000000EDEDEE00396AD900488D
      FD004285F7004184F7003F83F700327CF700548FF700DCE7FD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC3F700A1BAF600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F6FE006A9BF8001166F5001969F5001969F5001668
      F4001569FD005E7ABF00000000000000000000000000000000009B9B9B00A7A7
      A700ABABAB00B2B2B200B7B7B700BCBCBC00C0C0C000C6C6C600CBCBCB00CECF
      CF009DC9B6008ED3B3008BD8B50083D6B0007CD2AB0075CEA5007ECEAA00B3E0
      CC00FEFFFE00FFFFFF00CDCDCD00DDDDDD000000000000000000000000000000
      000000000000000000000000000000000000707070FF727272FF8A8A8AFFA2A2
      A2FFB5B5B5FFC3C3C3FFD0D0D0FFD9D9D9FFE1E1E1FFE7E7E7FFECECECFFEEEE
      EEFFECECECFFE8E8E8FFE1E1E1FFD8D8D8FFCDCDCDFFBFBFBFFFB0B0B0FF9E9E
      9EFF868686FF6F6F6FFF535353FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000128A1D0054F1
      97004DE088002CDB740032DF790032E07B0031E37D0031E57E0033E7810037E8
      840030E7800093F3BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080F0B10026E4
      780031E47D0031E27C0032DF790032DD780032DA750032D773002DD36D0052D8
      84004FDE850012831700000000000000000000000000000000007188C100468A
      FF004789F7004486F7004184F700659AF800EFF5FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A5BDF600407DF2003A7BF20093B0F400FAFBFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006A9AF700226FF5001B6BF5001D6E
      F7001561F500BABFCF00000000000000000000000000CECECE0095959500A6A6
      A600AEAEAE00B4B4B400B9B9B900BEBEBE00C3C3C300C8C8C800CDCDCD00D2D2
      D200D7D7D700BDD6CB00ACD8C400A9DCC400A8DCC400B1DECA00D3ECE100FFFF
      FF00FFFFFF00CDCDCD00DEDEDE00000000000000000000000000000000000000
      000000000000000000000000000000000000535353FF666666FF7B7B7BFF9191
      91FFA6A6A6FFB7B7B7FFC7C7C7FFD6D6D6FFE4E4E4FFF0F0F0FFF9F9F9FFFFFF
      FFFFFBFBFBFFF1F1F1FFE4E4E4FFD6D6D6FFC6C6C6FFB4B4B4FFA1A1A1FF8D8D
      8DFF787878FF636363FF4A4A4AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000195F000025CD
      5E0076F6AF0041E0830031E17C0035E5810036E683003CE8870045EA8D004DEB
      920049E98F00A2F4C600FFFFFF00FFFFFF00FFFFFF00FFFFFF008EF2BA0034E7
      820037E7840035E5810035E37F0036E07D0036DD7A0031D9750046DA800074E7
      A10020BD4F001A5D00001F5D0000000000000000000000000000DADBE1003771
      EA004F92FC004789F700498BF80073A0F600C4D3F700FFFFFF00FFFFFF00FFFF
      FF00FCFCFE0096B2F400588DF4004787F7004084F700538BF4007CA0F200EFF2
      FC00FFFFFF00FFFFFF00FFFFFF00ABC0F5006394F400337AF600216EF5002272
      FE004B74CE00FEFEFE0000000000000000000000000000000000CECECE00BBBB
      BB00BCBCBC00B5B5B500BCBCBC00C1C1C100C6C6C600CBCBCB00D0D0D000D5D5
      D500DADADA00DFDFDF00E4E4E400E9E9E900EEEEEE00F7F7F700FFFFFF00FFFF
      FF00CECECE00E5E5E50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5AFF6F6F6FFF868686FF9E9E
      9EFFAFAFAFFFBDBDBDFFCBCBCBFFD7D7D7FFE5E5E5FFF1F1F1FFF9F9F9FFFEFE
      FEFFF9F9F9FFEFEFEFFFE3E3E3FFD5D5D5FFC7C7C7FFB8B8B8FFA8A8A8FF9898
      98FF838383FF6B6B6BFF4F4F4FFF000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000117F
      140049F2920080F4B40042E5880037E7840045E98D0051EB94005BEC9A0063EC
      9F0062EC9E00A0F4C500F5FEF900F5FEF900F5FEF900F4FEF8008FF2BA004CEA
      910048EA8E003DE8880039E6840039E3820034E07C0046DF850082E9AA0042DF
      7E0012780F000000000000000000000000000000000000000000000000008E9E
      C7004487FF005191F900498BF7004D8DF7006294F50096B2F300F7F9FD00FBFB
      FE0085A6F200568DF5004889F700377FF700377EF7003F84F700528CF6006390
      F100E2E9FB00F7F8FD0084A5F2005288F400397EF7002572F6002A77F9002166
      ED00D2D5DD000000000000000000000000000000000000000000000000000000
      0000C6C6C600D3D3D300C8C8C800C3C3C300C9C9C900CECECE00D3D3D300D8D8
      D800DDDDDD00E2E2E200E6E6E600ECECEC00F5F5F500FEFEFE00FFFFFF00CECE
      CE00E5E5E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005E5E5EFF787878FF919191FFAAAA
      AAFFBBBBBBFFC8C8C8FFD5D5D5FFE0E0E0FFECECECFFF7F7F7FFFCFCFCFFFFFF
      FFFFFBFBFBFFF3F3F3FFE9E9E9FFDDDDDDFFD0D0D0FFC2C2C2FFB3B3B3FFA4A4
      A4FF8E8E8EFF737373FF555555FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F5E00000000
      000012A2310063FFAB008AF7BB005AEB990053EB950063ED9F006EEEA70077EF
      AC007DF0AF0082F1B2008DF2B8008CF2B80089F1B60083F0B20071EEA80066ED
      A1005CEC9A004EEB920040E8890038E5820052E691008BEDB3005CEE98001199
      2900000000001F5E00000000000000000000000000000000000000000000FEFE
      FE006686CE004C8FFF005392F9004B8CF8004F8FF900538DF6006C94F0006B94
      F0004B87F600478AF8003F84F7004084F7003F83F7003A80F7003B82F7004585
      F7004D82F0005987EF004281F500387FF7002B76F600317BF800226EFD00A2B0
      CC00000000000000000000000000000000000000000000000000000000000000
      000000000000D2D2D200C6C6C600D9D9D900D4D4D400D0D0D000D5D5D500DBDB
      DB00E0E0E000E4E4E400EAEAEA00F3F3F300FDFDFD00FFFFFF00D1D1D100E6E6
      E600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FF808080FF979797FFAEAE
      AEFFBEBEBEFFCBCBCBFFD6D6D6FFE1E1E1FFEDEDEDFFF9F9F9FFFCFCFCFFFFFF
      FFFFFCFCFCFFF4F4F4FFE9E9E9FFDEDEDEFFD2D2D2FFC5C5C5FFB7B7B7FFA8A8
      A8FF949494FF7C7C7CFF606060FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001B59000015B6430073FFB700A9FBCF0088F1B60076EFAB007EF0AF0089F1
      B60092F2BC0097F3BF0097F3BF0095F3BE0091F2BB008AF1B70083F0B30078F0
      AC006AEEA3005AEC9A0054EB96006FEEA60097F3BE0063F39F0012A836001C59
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F8006286D2004C90FF005695FA004F8FF8004F8FF9004889F7003F84
      F600498CF8004588F7004587F7004486F7004285F7004184F7003E83F7003C82
      F700377EF700357CF600397FF700357CF6003780FB002572FD0094A7CF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D1D1D100C7C7C700E2E2E200E1E1E100DEDE
      DE00E2E2E200E7E7E700F1F1F100FCFCFC00FFFFFF00D4D4D400E6E6E6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFF868686FF9C9C9CFFB3B3
      B3FFC1C1C1FFCDCDCDFFD8D8D8FFE2E2E2FFEFEFEFFFFAFAFAFFFDFDFDFFFFFF
      FFFFFCFCFCFFF4F4F4FFEAEAEAFFDFDFDFFFD4D4D4FFC7C7C7FFBABABAFFADAD
      ADFF999999FF828282FF676767FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001A5B000016AD3C0071FEB200C0FFE000BAF8D500A7F4C800A1F4
      C500A4F4C700A9F5CA00ABF5CC00AAF5CB00A5F4C8009DF4C20092F2BC0088F1
      B50084F0B3008DF1B900A0F5C5009BFAC50054F2970012A535001C5900000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC007F99CD003F84FF005798FF005594F9005090F8004F8F
      F8004D8DF8004C8CF700498AF700478AF7004688F7004587F7004386F7004184
      F7003F83F7003E83F7003F84F8003983FF003677EE00B0BCD200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1D1D100C8C8C800EAEA
      EA00F0F0F000F1F1F100FDFDFD00FFFFFF00D7D7D700E6E6E600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000696969FF858585FF9B9B9BFFB2B2
      B2FFC1C1C1FFCDCDCDFFD8D8D8FFE2E2E2FFF0F0F0FFFCFCFCFFFDFDFDFFFFFF
      FFFFFCFCFCFFF4F4F4FFEAEAEAFFDFDFDFFFD4D4D4FFC7C7C7FFBABABAFFACAC
      ACFF989898FF818181FF666666FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000119023004EE88C00B0FFDB00DAFFEE00D9FC
      E900D1FAE300CEF9E100CDF9E000CAF8DE00C5F8DB00C1F7D900BDF7D600BBF8
      D500B8FAD500A9FED0007BFFB70033E07600118B1E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C8D8005885DB004589FE005595FC005795
      FB005493F9005190F8004E8EF8004D8DF8004B8CF700498AF700488AF700478A
      F800468AFB004087FF003479F6006F95DA00E4E6EB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D1D1
      D100CDCDCD00FCFCFC00FFFFFF00C9C9C900ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007C7C7CFFC2C2C2FFCDCDCDFFD8D8
      D8FFE1E1E1FFE8E8E8FFEEEEEEFFF3F3F3FFF9F9F9FFFEFEFEFFFEFEFEFFFFFF
      FFFFFEFEFEFFFBFBFBFFF7F7F7FFF2F2F2FFEDEDEDFFE6E6E6FFDFDFDFFFD6D6
      D6FFCBCBCBFFC0C0C0FF676767FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000116A04001CAF420060EB9900AAFF
      D500D3FFEE00E1FFF300E3FFF200E0FFF000D8FFEC00CCFFE500B7FFDC0095FF
      CC006CFFB1003AE67F0016AA3B00156603000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C5DD006C99EB004986
      EF004387F9004C8DF8004F8FF8004F8FF8004D8DF800488AF7004287F9003980
      F8004883EA0080A1DA00D7DEEB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900C9C9C900CACACA00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF9F9F9FFFA3A3A3FFA7A7
      A7FFABABABFFAFAFAFFFB2B2B2FFB6B6B6FFB8B8B8FFBABABAFFBDBDBDFFBEBE
      BEFFBEBEBEFFBBBBBBFFB8B8B8FFB6B6B6FFB2B2B2FFAEAEAEFFAAAAAAFFA6A6
      A6FFA1A1A1FF9D9D9DFF9C9C9CFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000116802001593
      27002FC05A004EDD820061F09D0068F1A10061F19D004FF0920037DC750020BE
      5000139024001566030000000000000000000000000000000000000000000000
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
      000000000000145E000011680000126801001268020013680100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000FFFFFFFFFFFFFFFFFFFFFFF87F
      FC00003FFFFC3FFFFFFFFFFFFF80F03FF800001FFFE007FFFFFF8FFF8000003F
      F000000FFF0001FFFFFE07FF0000001FE0000007FE00007FFFFC03FF0000000F
      C0000003F800003FFFF800FF00000007C0000003F000001FFFF0007F00000003
      80000001F000000FFFE0001F0000000300000001E0000007FFC0000F00000001
      00000000C0000003FF8000030000000000000000C0000003FF00000100000000
      0000000080000003FE000001000000000000000080000001FC00000100000000
      0000000080000001F80000010000001F0000000080000001F00000010000001F
      0000000080000001E00000030000001F0000000080000001C00000070000001F
      00000000800000018000000F0000003F00000000800000010000001F000001FF
      00000001800000010000003F000001FF80000001800000010000007F000001FF
      0000000080000003C00000FF000001FFC0000003C0000003800001FF000001FF
      C0000001C0000003C00003FF000001FFE0000007E0000007F00007FF000001FF
      D000000BE000000FF8000FFF000001FFF000000FF000001FFE001FFF000001FF
      F800001FF800003FFF803FFF000001FFFE00007FFE00007FFFE07FFF000001FF
      FF0000FFFF8001FFFFF0FFFF000001FFFFC003FFFFE007FFFFFFFFFFFFFFFFFF
      FFF83FFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
