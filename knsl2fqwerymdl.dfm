object TQweryModule: TTQweryModule
  Left = 164
  Top = 176
  Width = 798
  Height = 568
  Caption = '������ ������'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = AdvMainMenu2
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = OnCloseForm
  OnCreate = OnOpenForm
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSplitter1: TAdvSplitter
    Left = 252
    Top = 0
    Width = 3
    Height = 495
    Cursor = crHSplit
    AutoSnap = False
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
    Width = 252
    Height = 495
    Align = alLeft
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
    object FTreeQweryData: TTreeView
      Left = 0
      Top = 28
      Width = 252
      Height = 237
      Align = alTop
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = ImageListQwery
      Indent = 19
      ParentFont = False
      PopupMenu = mnuCluster
      RightClickSelect = True
      TabOrder = 0
      Visible = False
      OnClick = OnClickTree
      OnDragDrop = OnDragVmDrop
      OnDragOver = OnDragVmOver
      OnExpanded = FTreeQweryDataExpanded
      OnMouseDown = FTreeQweryDataMouseDown
    end
    object advTreePanell: TAdvPanel
      Left = 0
      Top = 0
      Width = 252
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      Color = 13616833
      TabOrder = 1
      UseDockManager = True
      Visible = False
      OnResize = OnResizePannel
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
      object advTreeTool: TAdvToolBar
        Left = -32
        Top = -1
        Width = 253
        Height = 29
        AllowFloating = True
        AutoSize = False
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
        ParentOptionPicture = True
        ParentShowHint = False
        ToolBarIndex = -1
        object advButTree: TAdvGlowMenuButton
          Left = 2
          Top = 2
          Width = 199
          Height = 29
          Caption = '�������'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          FocusType = ftHot
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = OnStopAll
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
          DropDownMenu = mnuCtrl
        end
      end
    end
    inline frameQM: TFrameQueryModule
      Top = 265
      Width = 252
      Height = 230
      Align = alClient
      TabOrder = 2
      inherited Panel: TPanel
        Width = 252
        inherited btnStop: TAdvGlowButton
          Width = 250
        end
      end
      inherited TreeView: TTreeView
        Width = 252
        Height = 197
      end
    end
  end
  object sbQwery: TAdvOfficeStatusBar
    Left = 0
    Top = 495
    Width = 790
    Height = 19
    AnchorHint = False
    Panels = <
      item
        AppearanceStyle = psLight
        DateFormat = 'dd.MM.yyyy'
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
        Text = '������ ������ '
        TimeFormat = 'h:mm:ss'
        Width = 100
      end
      item
        AppearanceStyle = psLight
        DateFormat = 'dd.MM.yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 20
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
        Style = psText
        Text = '���������'
        TimeFormat = 'h:mm:ss'
        Width = 100
      end
      item
        AppearanceStyle = psDark
        DateFormat = 'dd.MM.yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piNone
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 50
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 100
        Progress.Level2Perc = 100
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        Progress.ShowPercentage = False
        Style = psProgress
        Text = '��������'
        TimeFormat = 'h:mm:ss'
        Width = 1185
      end>
    SimplePanel = False
    URLColor = clBlue
    Styler = AdvOfficeStatusBarOfficeStyler1
    Version = '1.2.0.6'
  end
  object AdvPanel2: TAdvPanel
    Left = 255
    Top = 0
    Width = 535
    Height = 495
    Align = alClient
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
    object advSrvPager: TAdvOfficePager
      Left = 0
      Top = 0
      Width = 535
      Height = 495
      AdvOfficePagerStyler = AdvOfficePagerOfficeStyler1
      Align = alClient
      ActivePage = AdvOfficePage3
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
      TabSettings.Shape = tsRightRamp
      TabReorder = False
      ShowShortCutHints = False
      TabOrder = 0
      NextPictureChanged = False
      PrevPictureChanged = False
      object AdvOfficePage1: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 533
        Height = 467
        Caption = '������ ������'
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
        object Label8: TLabel
          Left = 26
          Top = 39
          Width = 48
          Height = 13
          Caption = '��������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object edQGName: TAdvEdit
          Left = 93
          Top = 37
          Width = 373
          Height = 21
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWhite
          Enabled = True
          TabOrder = 0
          Visible = True
          Version = '2.8.1.15'
        end
        object cbQGEnable: TCheckBox
          Left = 27
          Top = 63
          Width = 127
          Height = 17
          Caption = '��������� ������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object AdvGlowButton2: TAdvGlowButton
          Left = 416
          Top = 440
          Width = 103
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '���������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 2
          OnClick = OnSaveQGName
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
        end
        object AdvGlowButton3: TAdvGlowButton
          Left = 206
          Top = 440
          Width = 103
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '�������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 3
          OnClick = OnDelQgroup
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
        end
        object AdvGlowButton5: TAdvGlowButton
          Left = 310
          Top = 440
          Width = 103
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '��������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 4
          OnClick = OnAddNewGroup
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
        end
      end
      object AdvOfficePage3: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 533
        Height = 467
        Caption = '��������� �������'
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
        object Label9: TLabel
          Left = 41
          Top = 71
          Width = 125
          Height = 13
          Caption = '������ ������� ������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label10: TLabel
          Left = 41
          Top = 95
          Width = 144
          Height = 13
          Caption = '��������� ������� ������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label20: TLabel
          Left = 42
          Top = 118
          Width = 80
          Height = 13
          Caption = '������ ������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label21: TLabel
          Left = 43
          Top = 516
          Width = 60
          Height = 13
          Caption = '���������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label22: TLabel
          Left = 140
          Top = 516
          Width = 41
          Height = 13
          Caption = '������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label23: TLabel
          Left = 43
          Top = 363
          Width = 84
          Height = 13
          Caption = '������� ������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object GradientLabel2: TGradientLabel
          Left = 43
          Top = 491
          Width = 383
          Height = 17
          AutoSize = False
          Caption = '��������� ������� ������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
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
          Left = 41
          Top = 17
          Width = 356
          Height = 17
          AutoSize = False
          Caption = '��������� ��������������� ������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
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
        object Label24: TLabel
          Left = 41
          Top = 47
          Width = 41
          Height = 13
          Caption = '������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbParam: TLabel
          Left = 97
          Top = 47
          Width = 41
          Height = 13
          Caption = 'Zadacha'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object GradientLabel4: TGradientLabel
          Left = 401
          Top = 17
          Width = 361
          Height = 17
          AutoSize = False
          Caption = '��������� ��������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
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
        object Label98: TLabel
          Left = 406
          Top = 72
          Width = 209
          Height = 13
          Hint = '��� ������� ������'
          Caption = '����� ���������� ������������ ����� '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label103: TLabel
          Left = 405
          Top = 119
          Width = 97
          Height = 13
          Caption = '������� ��������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label25: TLabel
          Left = 42
          Top = 294
          Width = 156
          Height = 13
          Caption = '����������� ������� ������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label26: TLabel
          Left = 42
          Top = 318
          Width = 135
          Height = 13
          Caption = '������� �������� ������:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label27: TLabel
          Left = 43
          Top = 342
          Width = 155
          Height = 13
          Caption = '����� �� ������� ����������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object dtBegin: TDateTimePicker
          Left = 272
          Top = 68
          Width = 93
          Height = 21
          Hint = '����� ������ ��� ������ ���'
          CalAlignment = dtaRight
          Date = 40300.7711754861
          Time = 40300.7711754861
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParseInput = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object dtEnd: TDateTimePicker
          Left = 272
          Top = 92
          Width = 93
          Height = 21
          Hint = '����� ������ ��� ������ ���'
          CalAlignment = dtaRight
          Date = 40300.7711754861
          Time = 40300.7711754861
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParseInput = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object dtPeriod: TDateTimePicker
          Left = 272
          Top = 116
          Width = 93
          Height = 21
          Hint = '����� ������ ��� ������ ���'
          CalAlignment = dtaRight
          Date = 40300.7711754861
          Time = 40300.7711754861
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParseInput = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object cbDayMask: TCheckBox
          Left = 40
          Top = 142
          Width = 145
          Height = 17
          Caption = '��������� ��� ������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = cbDayMaskClick
        end
        object cbMonthMask: TCheckBox
          Left = 225
          Top = 142
          Width = 144
          Height = 18
          Caption = '��������� ��� ������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = cbMonthMaskClick
        end
        object clmDayMask: TParamCheckList
          Left = 40
          Top = 162
          Width = 181
          Height = 121
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
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            '�����������'
            '�����������'
            '�������'
            '�����'
            '�������'
            '�������'
            '�������')
          ParentFont = False
          TabOrder = 5
          Version = '1.3.3.0'
        end
        object clmMonthMask: TParamCheckList
          Left = 225
          Top = 162
          Width = 172
          Height = 121
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
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '20'
            '21'
            '22'
            '23'
            '24'
            '25'
            '26'
            '27'
            '28'
            '29'
            '30'
            '31')
          ParentFont = False
          TabOrder = 6
          Version = '1.3.3.0'
        end
        object mdtEnd: TDateTimePicker
          Left = 42
          Top = 538
          Width = 97
          Height = 21
          Hint = '����� ������ ��� ������ ���'
          CalAlignment = dtaRight
          Date = 40300.7711754861
          Time = 40300.7711754861
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
        end
        object mdtBegin: TDateTimePicker
          Left = 140
          Top = 538
          Width = 97
          Height = 21
          Hint = '����� ������ ��� ������ ���'
          CalAlignment = dtaRight
          Date = 40300.7711754861
          Time = 40300.7711754861
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnChange = mdtBeginChange
        end
        object cbDeepFind: TComboBox
          Left = 226
          Top = 361
          Width = 173
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 9
          Items.Strings = (
            'C ���.������'
            '������� ����'
            '1 ����'
            '2 ���'
            '3 ���'
            '5 ����'
            '7 ����'
            '14 ����'
            '1 �����'
            '2 ������'
            '6 �������'
            '12 �������'
            '���������� �����')
        end
        object cbEnable: TCheckBox
          Left = 42
          Top = 387
          Width = 216
          Height = 17
          Caption = '��������� �������������� �����'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object cbPause: TCheckBox
          Left = 42
          Top = 411
          Width = 128
          Height = 17
          Caption = '�����'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object cbFindUpdate: TCheckBox
          Left = 42
          Top = 435
          Width = 128
          Height = 17
          Caption = '�����/����������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object saveParams: TAdvGlowButton
          Left = 277
          Top = 440
          Width = 242
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '���������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 13
          OnClick = saveParamsClick
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
        end
        object queryStart: TAdvGlowButton
          Left = 116
          Top = 440
          Width = 163
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '�������� '
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 14
          OnClick = queryStartClick
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
        end
        object stopButton: TAdvGlowButton
          Left = -9
          Top = 440
          Width = 123
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '����������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 15
          OnClick = stopButtonClick
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
        end
        object em_strVTPath: TEdit
          Left = 406
          Top = 91
          Width = 307
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7485192
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object autoUnload: TAdvGlowButton
          Left = 716
          Top = 91
          Width = 48
          Height = 22
          Caption = '�����'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 17
          OnClick = autoUnloadClick
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
        end
        object cbm_snVTDeepFind: TComboBox
          Left = 508
          Top = 115
          Width = 174
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 18
          Items.Strings = (
            'C ���.������'
            '������� ����'
            '1 ����'
            '2 ���'
            '3 ���'
            '5 ����'
            '7 ����'
            '14 ����'
            '1 �����'
            '2 ������'
            '6 �������'
            '12 �������')
        end
        object chm_sbyVTEnable: TCheckBox
          Left = 406
          Top = 47
          Width = 154
          Height = 17
          Caption = '��������� ������������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object btUnloadStart: TAdvGlowButton
          Left = 716
          Top = 115
          Width = 48
          Height = 22
          Caption = '����...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 20
          OnClick = btUnloadStartClick
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
        end
        object cbRunStatus: TCheckBox
          Left = 401
          Top = 142
          Width = 172
          Height = 18
          Caption = '��������� �� ��������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
          OnClick = cbRunStatusClick
        end
        object clmRunStatus: TParamCheckList
          Left = 401
          Top = 162
          Width = 313
          Height = 121
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
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            '�������� ���������'
            '�����'
            '���������'
            '������ ����������'
            '����������� �-�� ������'
            '������������� ���������')
          ParentFont = False
          TabOrder = 22
          Version = '1.3.3.0'
        end
        object spinError: TAdvSpinEdit
          Left = 225
          Top = 289
          Width = 172
          Height = 22
          Value = 20
          FloatValue = 20
          TimeValue = 0.833333333333333
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.1
          IncrementFloatPage = 1
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          MaxValue = 100
          TabOrder = 23
          Visible = True
          Version = '1.4.4.5'
        end
        object AdvGlowButton7: TAdvGlowButton
          Left = 368
          Top = 67
          Width = 29
          Height = 24
          Hint = '��������� ������ ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ShowDisabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 24
          OnClick = setGroupParam
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
        end
        object AdvGlowButton8: TAdvGlowButton
          Tag = 1
          Left = 368
          Top = 91
          Width = 29
          Height = 24
          Hint = '��������� ����� ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 25
          OnClick = setGroupParam
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
        end
        object AdvGlowButton9: TAdvGlowButton
          Tag = 2
          Left = 368
          Top = 115
          Width = 29
          Height = 24
          Hint = '��������� ������ ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ShowDisabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 26
          OnClick = setGroupParam
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
        end
        object AdvGlowButton10: TAdvGlowButton
          Tag = 7
          Left = 400
          Top = 289
          Width = 29
          Height = 22
          Hint = '��������� ����������� ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 27
          OnClick = setGroupParam
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
        end
        object AdvGlowButton11: TAdvGlowButton
          Tag = 8
          Left = 401
          Top = 360
          Width = 29
          Height = 22
          Hint = '��������� ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 28
          OnClick = setGroupParam
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
        end
        object AdvGlowButton12: TAdvGlowButton
          Tag = 4
          Left = 192
          Top = 141
          Width = 30
          Height = 20
          Hint = '��������� ��������� ��� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 29
          OnClick = setGroupParam
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
        end
        object AdvGlowButton13: TAdvGlowButton
          Tag = 5
          Left = 368
          Top = 141
          Width = 30
          Height = 20
          Hint = '��������� ��������� ��� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 30
          OnClick = setGroupParam
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
        end
        object AdvGlowButton14: TAdvGlowButton
          Tag = 6
          Left = 684
          Top = 141
          Width = 30
          Height = 20
          Hint = '��������� ������ �� ��������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 31
          OnClick = setGroupParam
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
        end
        object AdvGlowButton15: TAdvGlowButton
          Tag = 9
          Left = 401
          Top = 386
          Width = 30
          Height = 20
          Hint = '��������� �������������� �����'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 32
          OnClick = setGroupParam
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
        end
        object AdvGlowButton16: TAdvGlowButton
          Tag = 10
          Left = 401
          Top = 410
          Width = 30
          Height = 20
          Hint = '��������� �����'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 33
          OnClick = setGroupParam
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
        end
        object AdvGlowButton17: TAdvGlowButton
          Tag = 11
          Left = 401
          Top = 434
          Width = 30
          Height = 20
          Hint = '��������� �����/����������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 34
          OnClick = setGroupParam
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
        end
        object AdvGlowButton18: TAdvGlowButton
          Tag = 3
          Left = 556
          Top = 45
          Width = 29
          Height = 20
          Hint = '��������� ������������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 35
          OnClick = setGroupParam
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
        end
        object AdvGlowButton19: TAdvGlowButton
          Tag = 12
          Left = 685
          Top = 115
          Width = 29
          Height = 22
          Hint = '��������� ������� ������������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 36
          OnClick = setGroupParam
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
        end
        object cbPacket_KUB: TCheckBox
          Left = 43
          Top = 460
          Width = 175
          Height = 17
          Caption = '�������� �������� ��� ���'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 37
        end
        object Init_PACKET_KUB1: TAdvGlowButton
          Tag = 13
          Left = 401
          Top = 458
          Width = 30
          Height = 20
          Hint = '��������� �������� ��������(���)'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 38
          OnClick = setGroupParam
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
        end
        object spinError2: TAdvSpinEdit
          Left = 225
          Top = 313
          Width = 172
          Height = 22
          Value = 20
          FloatValue = 20
          TimeValue = 0.833333333333333
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.1
          IncrementFloatPage = 1
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          MaxValue = 100
          TabOrder = 39
          Visible = True
          Version = '1.4.4.5'
        end
        object AdvGlowButton20: TAdvGlowButton
          Tag = 14
          Left = 400
          Top = 313
          Width = 29
          Height = 22
          Hint = '��������� ����������� ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 40
          OnClick = setGroupParam
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
        end
        object AdvGlowButton21: TAdvGlowButton
          Tag = 15
          Left = 401
          Top = 337
          Width = 29
          Height = 22
          Hint = '��������� ����������� ������� ������'
          Caption = '...'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 41
          OnClick = setGroupParam
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
        end
        object TimeToStop: TDateTimePicker
          Left = 225
          Top = 337
          Width = 172
          Height = 21
          Hint = '����� ������ ��� ������ ���'
          CalAlignment = dtaRight
          Date = 40300.0000115741
          Time = 40300.0000115741
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParseInput = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 42
        end
      end
      object AdvOfficePage2: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 533
        Height = 467
        Caption = '������� ������'
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
        object sgQGroup: TAdvStringGrid
          Left = 2
          Top = 33
          Width = 529
          Height = 432
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
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goRowSelect, goThumbTracking]
          ParentFont = False
          PopupMenu = qgMenu
          ScrollBars = ssBoth
          TabOrder = 0
          OnMouseDown = sgQGroupMouseDown
          OnMouseUp = sgQGroupMouseUp
          GridLineColor = 15062992
          OnClickCell = sgQGroupClickCell
          OnGetEditorType = sgQGroupGetEditorType
          OnButtonClick = sgQGroupButtonClick
          OnCheckBoxClick = sgQGroupCheckBoxClick
          ActiveCellFont.Charset = RUSSIAN_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Times New Roman'
          ActiveCellFont.Style = [fsBold]
          ActiveCellColor = 10344697
          ActiveCellColorTo = 6210033
          Bands.Active = True
          Bands.PrimaryColor = 16310238
          Bands.SecondaryColor = clWhite
          CellNode.ShowTree = False
          ControlLook.FixedGradientFrom = 16250871
          ControlLook.FixedGradientTo = 14606046
          ControlLook.ControlStyle = csClassic
          EnhRowColMove = False
          Filter = <>
          FixedAsButtons = True
          FixedFont.Charset = RUSSIAN_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -11
          FixedFont.Name = 'Tahoma'
          FixedFont.Style = []
          FloatFormat = '%.2f'
          GridImages = ImageListQwery
          MouseActions.DisjunctRowSelect = True
          MouseActions.WheelAction = waScroll
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
        object AdvPanel4: TAdvPanel
          Left = 2
          Top = 2
          Width = 529
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
            Width = 469
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
            ParentOptionPicture = True
            ParentShowHint = False
            ToolBarIndex = -1
            object AdvToolBarSeparator1: TAdvToolBarSeparator
              Left = 224
              Top = 2
              Width = 10
              Height = 23
              LineColor = clBtnShadow
            end
            object statButt: TAdvGlowMenuButton
              Left = 113
              Top = 2
              Width = 111
              Height = 25
              Caption = '����������'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              FocusType = ftHot
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              PopupMenu = advSort
              TabOrder = 0
              Visible = False
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
              DropDownMenu = advSort
            end
            object AdvGlowMenuButton1: TAdvGlowMenuButton
              Left = 2
              Top = 2
              Width = 111
              Height = 25
              Caption = '����������'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              FocusType = ftHot
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 1
              OnClick = statButtClick
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
              DropDownMenu = pmMnuStat
            end
            object FindBtn: TAdvGlowButton
              Left = 355
              Top = 2
              Width = 100
              Height = 25
              Hint = '�����'
              Caption = '�����'
              ImageIndex = 9
              Images = ImageList1
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              TabOrder = 2
              OnClick = FindBtnClick
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
            end
            object FindEdit: TAdvEdit
              Left = 234
              Top = 2
              Width = 121
              Height = 25
              Hint = '�����'
              LabelFont.Charset = DEFAULT_CHARSET
              LabelFont.Color = clWindowText
              LabelFont.Height = -11
              LabelFont.Name = 'MS Sans Serif'
              LabelFont.Style = []
              Lookup.Separator = ';'
              Color = clWindow
              Enabled = True
              TabOrder = 3
              Visible = True
              OnChange = FindEditChange
              Version = '2.8.1.15'
            end
          end
          object btnRefresh: TAdvGlowButton
            Left = 478
            Top = 0
            Width = 92
            Height = 28
            Caption = '��������'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            TabOrder = 1
            OnClick = btnRefreshClick
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
          end
        end
      end
      object AdvOfficePager11: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 533
        Height = 467
        Caption = '��������� �������'
        PageAppearance.BorderColor = 11841710
        PageAppearance.Color = 13616833
        PageAppearance.ColorTo = 12958644
        PageAppearance.ColorMirror = 12958644
        PageAppearance.ColorMirrorTo = 15527141
        PageAppearance.Gradient = ggVertical
        PageAppearance.GradientMirror = ggVertical
        TabVisible = False
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
        object Label12: TLabel
          Left = 137
          Top = 38
          Width = 56
          Height = 15
          Caption = '������ ID'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label18: TLabel
          Left = 26
          Top = 38
          Width = 49
          Height = 15
          Caption = '�������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label19: TLabel
          Left = 26
          Top = 63
          Width = 52
          Height = 15
          Caption = '��������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label3: TLabel
          Left = 26
          Top = 111
          Width = 226
          Height = 15
          Caption = '���-�� �������������� ��� ����������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object edm_snSRVIDsrv: TAdvEdit
          Left = 204
          Top = 37
          Width = 34
          Height = 21
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clBtnFace
          Enabled = True
          ReadOnly = True
          TabOrder = 0
          Visible = True
          Version = '2.8.1.15'
        end
        object edm_snAIDsrv: TAdvEdit
          Left = 93
          Top = 37
          Width = 34
          Height = 21
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clBtnFace
          Enabled = True
          ReadOnly = True
          TabOrder = 1
          Visible = True
          Version = '2.8.1.15'
        end
        object edm_sName: TAdvEdit
          Left = 93
          Top = 61
          Width = 373
          Height = 21
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWhite
          Enabled = True
          TabOrder = 2
          Visible = True
          Version = '2.8.1.15'
        end
        object chm_sbyEnableSrv: TCheckBox
          Left = 27
          Top = 87
          Width = 127
          Height = 17
          Caption = '��������� ������'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object advSaveSrv: TAdvGlowButton
          Left = 416
          Top = 434
          Width = 103
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '���������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 4
          OnClick = advSaveSrvClick
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
        end
        object advLoadSrv: TAdvGlowButton
          Left = 200
          Top = 434
          Width = 103
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '��������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 5
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
        end
        object advCreateSrv: TAdvGlowButton
          Left = 308
          Top = 434
          Width = 103
          Height = 20
          Anchors = [akRight, akBottom]
          Caption = '�������'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 6
          OnClick = advCreateSrvClick
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
        end
        object sem_nSrvWarning: TSpinEdit
          Left = 259
          Top = 108
          Width = 54
          Height = 22
          MaxValue = 50
          MinValue = 2
          TabOrder = 7
          Value = 2
        end
      end
      object AdvOfficePager12: TAdvOfficePage
        Left = 1
        Top = 26
        Width = 533
        Height = 467
        Caption = '��������� ������'
        PageAppearance.BorderColor = 11841710
        PageAppearance.Color = 13616833
        PageAppearance.ColorTo = 12958644
        PageAppearance.ColorMirror = 12958644
        PageAppearance.ColorMirrorTo = 15527141
        PageAppearance.Gradient = ggVertical
        PageAppearance.GradientMirror = ggVertical
        TabVisible = False
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
          Top = 5
          Width = 732
          Height = 511
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
          object Label4: TLabel
            Left = 583
            Top = 4
            Width = 47
            Height = 15
            Caption = '�������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label5: TLabel
            Left = 11
            Top = 222
            Width = 136
            Height = 15
            Caption = '������ ������� ������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label6: TLabel
            Left = 11
            Top = 246
            Width = 157
            Height = 15
            Caption = '��������� ������� ������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 12
            Top = 269
            Width = 88
            Height = 15
            Caption = '������ ������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label13: TLabel
            Left = 316
            Top = 4
            Width = 43
            Height = 15
            Caption = '������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label14: TLabel
            Left = 404
            Top = 4
            Width = 44
            Height = 15
            Caption = '������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label15: TLabel
            Left = 504
            Top = 4
            Width = 31
            Height = 15
            Caption = '����:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label16: TLabel
            Left = 532
            Top = 245
            Width = 65
            Height = 15
            Caption = '���������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label17: TLabel
            Left = 629
            Top = 245
            Width = 44
            Height = 15
            Caption = '������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object GradientLabel1: TGradientLabel
            Left = 370
            Top = 293
            Width = 356
            Height = 17
            AutoSize = False
            Caption = '���������� ��������'
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
          object Label11: TLabel
            Left = 224
            Top = 4
            Width = 52
            Height = 15
            Caption = '�������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label1: TLabel
            Left = 531
            Top = 221
            Width = 166
            Height = 15
            Caption = '�������� ���������� ������'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object lbDeepFind: TLabel
            Left = 140
            Top = 466
            Width = 51
            Height = 15
            Caption = '�������:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 8
            Top = 3
            Width = 154
            Height = 15
            Caption = '������� ��������� ������'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object chm_sbyFindData: TAdvOfficeRadioGroup
            Left = 2
            Top = 455
            Width = 136
            Height = 35
            BorderStyle = bsNone
            Version = '1.1.1.4'
            ParentCtl3D = True
            TabOrder = 33
            OnClick = OnClickFind
            Ellipsis = False
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              '�����'
              '������.')
          end
          object chm_swDayMask: TCheckBox
            Left = 9
            Top = 293
            Width = 184
            Height = 17
            Caption = '��������� ��� ������'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7485192
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = OnClickWDay
          end
          object clm_swDayMask: TParamCheckList
            Left = 10
            Top = 313
            Width = 181
            Height = 121
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
            Enabled = False
            ItemHeight = 16
            Items.Strings = (
              '�����������'
              '�����������'
              '�������'
              '�����'
              '�������'
              '�������'
              '�������')
            TabOrder = 1
            Version = '1.3.3.0'
          end
          object chm_sbyEnable: TCheckBox
            Left = 11
            Top = 490
            Width = 127
            Height = 17
            Caption = '��������� �����'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object clm_sdwMonthMask: TParamCheckList
            Left = 194
            Top = 313
            Width = 172
            Height = 121
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
            Enabled = False
            ItemHeight = 16
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19'
              '20'
              '21'
              '22'
              '23'
              '24'
              '25'
              '26'
              '27'
              '28'
              '29'
              '30'
              '31')
            TabOrder = 3
            Version = '1.3.3.0'
          end
          object chm_sdwMonthMask: TCheckBox
            Left = 193
            Top = 293
            Width = 177
            Height = 17
            Caption = '��������� ��� ������'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7485192
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = chm_sdwMonthMaskClick
          end
          object dtm_sdtPeriod: TDateTimePicker
            Left = 194
            Top = 267
            Width = 93
            Height = 22
            Hint = '����� ������ ��� ������ ���'
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
            TabOrder = 5
          end
          object dtm_sdtEnd: TDateTimePicker
            Left = 194
            Top = 243
            Width = 93
            Height = 22
            Hint = '����� ������ ��� ������ ���'
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
            TabOrder = 6
          end
          object dtm_sdtBegin: TDateTimePicker
            Left = 194
            Top = 219
            Width = 93
            Height = 22
            Hint = '����� ������ ��� ������ ���'
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
            TabOrder = 7
          end
          object edm_snSRVID: TAdvEdit
            Left = 633
            Top = 3
            Width = 95
            Height = 21
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'MS Sans Serif'
            LabelFont.Style = []
            Lookup.Separator = ';'
            Color = clBtnFace
            Enabled = True
            TabOrder = 8
            Visible = True
            Version = '2.8.1.15'
          end
          object edm_snPID: TAdvEdit
            Left = 538
            Top = 3
            Width = 34
            Height = 21
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'MS Sans Serif'
            LabelFont.Style = []
            Lookup.Separator = ';'
            Color = clBtnFace
            Enabled = True
            TabOrder = 9
            Visible = True
            Version = '2.8.1.15'
          end
          object edm_snCLID: TAdvEdit
            Left = 452
            Top = 3
            Width = 34
            Height = 21
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'MS Sans Serif'
            LabelFont.Style = []
            Lookup.Separator = ';'
            Color = clBtnFace
            Enabled = True
            ReadOnly = True
            TabOrder = 10
            Visible = True
            Version = '2.8.1.15'
          end
          object btm_sdtBegin: TAdvGlowButton
            Left = 292
            Top = 219
            Width = 36
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
            OnClick = btm_sdtBeginClick
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
          end
          object AdvGlowButton4: TAdvGlowButton
            Left = 586
            Top = 489
            Width = 142
            Height = 20
            Caption = '���������'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            TabOrder = 12
            OnClick = OnSaveButt
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
          end
          object cbm_snDeepFind: TComboBox
            Left = 194
            Top = 464
            Width = 119
            Height = 21
            ItemHeight = 13
            TabOrder = 13
            Items.Strings = (
              'C ���.������'
              '������� ����'
              '1 ����'
              '2 ���'
              '3 ���'
              '5 ����'
              '7 ����'
              '14 ����'
              '1 �����'
              '2 ������'
              '6 �������'
              '12 �������'
              '���������� �����')
          end
          object btm_sdtEnd: TAdvGlowButton
            Left = 292
            Top = 243
            Width = 36
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 14
            OnClick = btm_sdtEndClick
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
          end
          object btm_sdtPeriod: TAdvGlowButton
            Left = 292
            Top = 267
            Width = 36
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
            OnClick = btm_sdtPeriodClick
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
          end
          object btm_swDayMask: TAdvGlowButton
            Left = 10
            Top = 436
            Width = 87
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 16
            OnClick = btm_swDayMaskClick
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
          end
          object btm_sdwMonthMask: TAdvGlowButton
            Left = 194
            Top = 436
            Width = 85
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
            OnClick = btm_sdwMonthMaskClick
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
          end
          object btm_sbyFindData: TAdvGlowButton
            Left = 316
            Top = 464
            Width = 24
            Height = 20
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            Images = ImageList1
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            OnClick = btm_sbyFindDataClick
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
          end
          object btm_sbyEnable: TAdvGlowButton
            Left = 140
            Top = 489
            Width = 24
            Height = 20
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            Images = ImageList1
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 19
            OnClick = btm_sbyEnableClick
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
          end
          object btm_sExecForGroup: TAdvGlowButton
            Left = 369
            Top = 489
            Width = 70
            Height = 20
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 20
            OnClick = btm_sExecForGroupClick
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
          end
          object edm_snAID: TAdvEdit
            Left = 280
            Top = 3
            Width = 34
            Height = 21
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'MS Sans Serif'
            LabelFont.Style = []
            Lookup.Separator = ';'
            Color = clBtnFace
            Enabled = True
            ReadOnly = True
            TabOrder = 21
            Visible = True
            Version = '2.8.1.15'
          end
          object edm_snSRVIDc: TAdvEdit
            Left = 366
            Top = 3
            Width = 34
            Height = 21
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'MS Sans Serif'
            LabelFont.Style = []
            Lookup.Separator = ';'
            Color = clBtnFace
            Enabled = True
            ReadOnly = True
            TabOrder = 22
            Visible = True
            Version = '2.8.1.15'
          end
          object cbm_strCMDCluster: TParamCheckList
            Left = 368
            Top = 313
            Width = 359
            Height = 121
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
            TabOrder = 23
            Version = '1.3.3.0'
          end
          object dttm_sdtBegin: TDateTimePicker
            Left = 629
            Top = 267
            Width = 97
            Height = 22
            Hint = '����� ������ ��� ������ ���'
            CalAlignment = dtaRight
            Date = 40300.7711754861
            Time = 40300.7711754861
            DateFormat = dfShort
            DateMode = dmComboBox
            Enabled = False
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
            TabOrder = 24
            OnChange = dttm_sdtBeginChange
          end
          object dttm_sdtEnd: TDateTimePicker
            Left = 531
            Top = 267
            Width = 97
            Height = 22
            Hint = '����� ������ ��� ������ ���'
            CalAlignment = dtaRight
            Date = 40300.7711754861
            Time = 40300.7711754861
            DateFormat = dfShort
            DateMode = dmComboBox
            Enabled = False
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
            TabOrder = 25
          end
          object cbm_nAddCommand: TComboBox
            Left = 368
            Top = 437
            Width = 359
            Height = 21
            ItemHeight = 13
            TabOrder = 26
          end
          object btm_nAddParam: TAdvGlowButton
            Left = 658
            Top = 464
            Width = 70
            Height = 20
            Hint = '��������'
            Caption = '+������'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7485192
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 27
            OnClick = btm_nTopParamClick
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
          end
          object btm_nSubParam: TAdvGlowButton
            Left = 514
            Top = 464
            Width = 70
            Height = 20
            Hint = '�������'
            Caption = '���.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7485192
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 28
            OnClick = btm_nSubParamClick
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
          end
          object btm_nTopParam: TAdvGlowButton
            Left = 586
            Top = 464
            Width = 70
            Height = 20
            Hint = '�����'
            Caption = '+�����'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7485192
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 29
            OnClick = btm_nBottParamClick
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
          end
          object btm_nSvClustGr: TAdvGlowButton
            Left = 369
            Top = 464
            Width = 70
            Height = 20
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7485192
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 30
            OnClick = btm_nSvClustGrClick
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
          end
          object chm_sbyPause: TCheckBox
            Left = 195
            Top = 490
            Width = 59
            Height = 17
            Caption = '�����'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            TabOrder = 31
          end
          object btm_sbyPause: TAdvGlowButton
            Left = 316
            Top = 489
            Width = 24
            Height = 20
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            Images = ImageList1
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 32
            OnClick = btm_sbyPauseClick
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
          end
          object btm_sdtBeginSAll: TAdvGlowButton
            Left = 330
            Top = 219
            Width = 36
            Height = 23
            Hint = '��������� ��� ��������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 34
            OnClick = btm_sdtBeginSAllClick
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
          end
          object btm_sdtEndSAll: TAdvGlowButton
            Left = 330
            Top = 243
            Width = 36
            Height = 23
            Hint = '��������� ��� ��������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 35
            OnClick = btm_sdtEndSAllClick
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
          end
          object btm_sdtPeriodSAll: TAdvGlowButton
            Left = 330
            Top = 267
            Width = 36
            Height = 23
            Hint = '��������� ��� ��������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 36
            OnClick = btm_sdtPeriodSAllClick
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
          end
          object btm_swDayMaskSAll: TAdvGlowButton
            Left = 102
            Top = 436
            Width = 90
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 37
            OnClick = btm_swDayMaskSAllClick
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
          end
          object btm_sdwMonthMaskSAll: TAdvGlowButton
            Left = 282
            Top = 436
            Width = 85
            Height = 23
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 38
            OnClick = btm_sdwMonthMaskSAllClick
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
          end
          object btm_sExecForGroupSAll: TAdvGlowButton
            Left = 440
            Top = 489
            Width = 70
            Height = 20
            Hint = '��������� ��� ��������'
            Caption = '...'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 39
            OnClick = btm_sExecForGroupSAllClick
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
          end
          object btm_sbyEnableSAll: TAdvGlowButton
            Left = 167
            Top = 489
            Width = 24
            Height = 20
            Hint = '��������� ��� ��������'
            Caption = '...'
            Images = ImageList1
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 40
            OnClick = btm_sbyEnableSAllClick
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
          end
          object btm_sbyPauseSAll: TAdvGlowButton
            Left = 343
            Top = 489
            Width = 24
            Height = 20
            Hint = '��������� ��� ��������'
            Caption = '...'
            Images = ImageList1
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 41
            OnClick = btm_sbyPauseSAllClick
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
          end
          object btm_sbyFindDataSAll: TAdvGlowButton
            Left = 343
            Top = 464
            Width = 24
            Height = 20
            Hint = '��������� ��� ��������'
            Caption = '...'
            Images = ImageList1
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 42
            OnClick = btm_sbyFindDataSAllClick
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
          end
          object AdvGlowButton1: TAdvGlowButton
            Left = 440
            Top = 464
            Width = 70
            Height = 20
            Hint = '��������� ��� ���� � ������'
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7485192
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 43
            OnClick = btm_nSvClustGrClick
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
          end
          object sgComplette: TAdvStringGrid
            Left = 6
            Top = 24
            Width = 723
            Height = 194
            Cursor = crDefault
            DefaultRowHeight = 21
            RowCount = 5
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 44
            GridLineColor = 15062992
            OnGetCellColor = OnGetCellColor
            ActiveCellFont.Charset = RUSSIAN_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'Times New Roman'
            ActiveCellFont.Style = [fsBold]
            ActiveCellColor = 10344697
            ActiveCellColorTo = 6210033
            Bands.Active = True
            Bands.PrimaryColor = 14811105
            Bands.SecondaryColor = clWhite
            CellNode.ShowTree = False
            ControlLook.FixedGradientFrom = 16250871
            ControlLook.FixedGradientTo = 14606046
            ControlLook.ControlStyle = csClassic
            EnhRowColMove = False
            Filter = <>
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -8
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
          object btm_sAddClsTAll: TAdvGlowButton
            Left = 514
            Top = 489
            Width = 70
            Height = 20
            Hint = '�������� ������� �� ���� ������'
            Caption = '+� ������'
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentShowHint = False
            ShowHint = True
            TabOrder = 45
            OnClick = btm_sAddClsTAllClick
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
          end
        end
      end
    end
  end
  object ExtractListBox: TCheckListBox
    Left = 68
    Top = 472
    Width = 93
    Height = 65
    ItemHeight = 13
    Items.Strings = (
      '11111'
      '22222')
    TabOrder = 0
    Visible = False
    object ExtractBitBtn: TBitBtn
      Left = 0
      Top = 36
      Width = 89
      Height = 25
      Caption = ' ���������'
      TabOrder = 0
      OnClick = ExtractBitBtnClick
      Kind = bkYes
      Layout = blGlyphRight
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
    Left = 176
    Top = 352
  end
  object QweryMdlstyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2007Obsidian
    Left = 176
    Top = 320
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
    Left = 184
    Top = 272
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
    Left = 155
    Top = 180
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
    Left = 27
    Top = 140
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
    Left = 139
    Top = 404
  end
  object ImageListQwery: TImageList
    Left = 87
    Top = 200
    Bitmap = {
      494C010111001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700E7E7E700D6D6D600BDBDBD00B5B5B500D6D6D600E7E7E700F7F7
      F70000000000000000000000000000000000DEDEDE003939420052525200E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE00391018005A5A5A00F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF009C9C94005A63520084CE63005AC642004ACE39007BBD5A00525A4A00848C
      7B00FFFFFF00000000000000000000000000D6D6CE006B6B6B00EFEFE7001818
      180039393900EFEFEF0000000000000000000000000000000000BDBDBD002121
      210052000800C6001000FF001000EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00000000008C8C8C000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700B5CE9C009CC67B006BD64A0031E7390031E7390052CE420094BD7300C6D6
      B500F7F7F700000000000000000000000000C6C6C600F7F7F700ADADAD00D6D6
      D60021212100212121005A5A5A00F7F7F7009C9C9C0021212100212929005200
      0000C6081800FF081800FF001000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004D4D4D000000000000000000000000004D4D4D0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDCEAD00ADD68C0063E7520031FF5A0031FF63004ADE42009CC67B00CEDE
      C600FFFFFF00000000000000000000000000F7F7F700A5A5A500E7DEDE00D6D6
      D600A5A5A500636363003939390031313100313131004239390052000000B500
      1000FF102900E721290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A7000000
      00004D4D4D00D0D0D00000000000D0D0D0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDCEAD00B5D694005AEF4A0039FF520031FF5A0042E74200A5CE8400D6DE
      C6000000000000000000000000000000000000000000FFFFFF00B5B5B500CECE
      CE00D6D6D6006B7373008C8C8C00BDB5BD005A3131007B081000C6000800F718
      2900C6737B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E1E1E1000000
      00000000000000000000000000000000000000000000000000008C8C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDC6AD00B5DE9C004AF74A0031F74A0031FF4A0042E742009CD68400CED6
      C600000000000000000000000000000000000000000000000000FFFFFF00CECE
      CE00D6D6D600E7E7DE00525252009C9C9C00B5292900EF001800F70818007B6B
      730084848400A5A5A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADBDA500ADEF9C004AFF6300000000000000000031F7390094DE7B00C6CE
      BD00000000000000000000000000000000000000000000000000FFFFFF000000
      0000D6D6D600E7E7DE00CECECE0084000800FF5A6B00FF081000949C9C009C9C
      9C00D6D6D600ADADAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5AD9C00C6FFBD00A5FFBD00000000000000000029FF630084EF8400BDC6
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000BDC6C60052525200CED6D6007363630000000000FFFFFF00F7F7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000949C8C00D6DECE00CEDEBD0052D64A0042EF520073B55200C6D6BD00ADB5
      A500000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008C948C00C6C6C600C6CEC600FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8C8C00F7F7F700F7F7F700E7E7E700E7E7E700E7E7E700E7E7E700ADAD
      AD0000000000000000000000000000000000000000000000000000000000DEDE
      DE00CECEC600FFFFFF0000000000DEDEDE00BDBDBD00FFFFFF00525A6300636B
      6B00DEDEDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8C8C00F7F7F700F7F7F700D6D6D600D6D6D600D6D6D600E7E7E700ADAD
      AD000000000000000000000000000000000000000000000000008C8C8C00BDC6
      C60000000000000000000000000000000000E7E7E700636B6B0021292900FFFF
      F700737373000000000000000000000000000000000000000000000000008C8C
      8C00F0F0F000000000000000000000000000E9E9E9008C8C8C00A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00EFEFEF00F7F7F700DEDEDE00DEDEDE00E7E7E700D6D6D600BDBD
      BD000000000000000000000000000000000000000000D6D6D600C6C6CE000000
      0000000000000000000000000000000000007B7B7B006B6B6B00D6D6D600CECE
      CE00B5B5B5000000000000000000000000000000000000000000000000007C7C
      7C0000000000000000000000000000000000000000008C8C8C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF0084848400CECE
      CE00FFFFFF000000000000000000000000000000000000000000000000000000
      0000D9D9D900000000000000000000000000D9D9D90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF008484
      8400E7E7E7000000000000000000000000000000000000000000000000000000
      000000000000E1E1E10000000000E1E1E1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE00FAFA
      FB00F2F2F600ECEBF100E7E6EE00E3E2EB00E3E2EB00E5E4EC00E9E8EF00EFEE
      F300F5F5F800FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5004E4D4E00393A3C00F2F2F200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5004E4D4E00393A3C00F2F2F200000000000000
      00000000000000000000000000000000000000000000FEFEFE00EDECF200BBB7
      CE009791B400857EA7007B73A000746C9B00736B9B00776F9D007E76A2008A83
      AB00A19CBC00CDCADB00F7F7F900000000000000000000000000000000000000
      0000FFFFFF0084CEE700E7CEBD00FFD6AD00F7F7F700FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      00000000000000000000000000000000000000000000FEFEFE00E3E2EB009D97
      B800716999004B3E8000281D5E002D22640031266800362B6B00524785006460
      90007C74A100B4B0C900F3F3F60000000000000000000000000000000000FFFF
      FF0084736B00947B3100FFFFFF00FFFFFF00FFDEB500D6D6D600F7F7F700FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000FBFBFC00B7AF
      C8000D004C000800450013005E0015006500311D790037237C0039287B003B2C
      76007B6FA800F1F1F500FDFDFD00000000000000000000000000000000000000
      0000E7BD9C00FFC68400FFF7E700FFFFFF00FFFFFF00DEDEDE00D6D6D600DEDE
      DE00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000F2F0F5000E00
      5200150062009DEFFF0040C8FF00100058001F0D5400D1E2ED00CBEAF9003C27
      80003B297E007F72AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00E7E7E700ADADAD00F7F7F700D6D6
      D600CECECE00FFFFFF0000000000000000000000000000000000000000000000
      000000000000E1E1E100F5F5F400DEDDDC00D8D7D500E8E7E500F3F3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1E1E100F5F5F400DEDDDC00D8D7D500E8E7E500F3F3F3000000
      0000000000000000000000000000000000000000000000000000110356001501
      67001B01740028DCFF0041DCFF003FDCFF00C3D5DD0055436F000A0050001C01
      78001B0175003927800000000000000000000000000000000000FFFFFF00FFFF
      FF00F7F7F700D6D6D600B5B5B500ADADAD00A5A5A500A5A5A500A5A5A500DEDE
      DE00D6D6D600F7F7F70000000000000000000000000000000000000000000000
      00003B6BCE002766DC00256AE200256BE400256BE3002668E0002865D900CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      00002AABEE0012B3FA000FB8FB000DBBFC000EBAFC0010B6FB0014B0FA00CECE
      CE000000000000000000000000000000000000000000CBC4DA00130164001B01
      76001D017B0021057D0010005A001702650052408B001A056900270D73001D01
      7B001D017B001B0177006D5FA50000000000000000000000000000000000FFFF
      FF00E7E7E700B5847300C6A59400CEA59C00C6A59400BD948C00944A3100FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000CBCD
      D0002767DE00246DE7002271ED002173F1002272F000236FEB00256AE3002864
      D900F5F5F500000000000000000000000000000000000000000000000000CBCF
      D20012B4FB000CBDFC0008C3FE0006C7FE0007C6FE000AC1FD000EB9FC0014B0
      FA00F5F5F5000000000000000000000000000000000031207A00190172002B0F
      86002B0F8600B9C4CD00240E710021CDFF00160559004BD7FF00C9D1D7002B0F
      86002B0F86001E017E00220A7A00000000000000000000000000000000000000
      00009C5A4200C68C8400734A3900845A4A008C5A4A00945A4A009C5A42007B29
      0800FFFFFF000000000000000000000000000000000000000000000000002864
      D900256BE4002172EF002879F400307EF4002D7DF4002275F300236FEA002668
      DF00848EA10000000000000000000000000000000000000000000000000014B0
      FA000DBBFC0007C5FD001CCEFE0036D2FE002ED1FE0009CAFE000AC1FD0010B6
      FB00819AA70000000000000000000000000000000000200E7100341C8A00371C
      9100371C910022B1FF00A99AB7003AB9FF0036B7FF006C5B940054C2FF00371C
      9100371C9100371C91001D027E00000000000000000000000000000000008431
      10007B290800E7E7E700EFEFEF00F7F7F700FFFFFF00F7F7F700DEDEDE00FFFF
      FF00F7F7F7000000000000000000000000000000000000000000FEFEFE002766
      DC00246EE9002276F3003883F500468CF6003E87F6002D7CF4002272EF00256B
      E3002963D7000000000000000000000000000000000000000000FEFEFE0012B3
      FA000BBFFD000BCBFE0049D6FF0075DEFE0063DBFF002DD1FE0007C5FE000EBA
      FC0016AEFA00000000000000000000000000000000004D3C9300432C9700452C
      9C00452C9C006451A000D2DBE5007CCAFF0051B7FF00B4DCF5005CBCFF004930
      9E00452C9C00452C9C00452D9A00000000000000000000000000000000008431
      10007B290800DEDEDE00E7CEC600944A3100AD735A00A5634A00CEA59C008C42
      21007B2908000000000000000000000000000000000000000000FEFEFE002767
      DD00236EE9002477F3003883F400498EF6004289F5002F7DF4002172F000256B
      E4002863D7000000000000000000000000000000000000000000FEFEFE0012B4
      FA000AC0FD0010CBFE004ED7FE0087E1FE0070DDFE0033D2FE0006C6FE000EBA
      FC0015AEFA00000000000000000000000000000000007A6BB600533DA400553D
      A8007D6BBD007D6BBD007B6AB80094D8FF0076CEFF0086D5FD00D6D9E1007D6B
      BD00553DA800553DA8006955B000000000000000000000000000DECEC6007B29
      08007B290800C6C6C600EFD6D6009C634A008C422100A5635200D6B5AD00CE94
      8C007B2908000000000000000000000000000000000000000000000000002765
      DA00246CE6002173F1002D7CF5003782F4003481F5002678F3002370ED002669
      E1002C63D40000000000000000000000000000000000000000000000000013B1
      FA000CBDFD0005C7FE002DD1FF004CD6FE0043D5FF0018CDFE0008C3FE000FB8
      FB0019ABF7000000000000000000000000000000000000000000624DAE00644D
      B4009383CB009383CB009383CB00AAE9FF008FE2FF00B7ABC9009383CB009383
      CB00644DB400644DB400D0C9DE00000000000000000000000000000000007B29
      0800A56B5200E7D6CE006B6B6B00A56B5200A56B5200EFDEDE00E7CEC600CE9C
      8C007B2908000000000000000000000000000000000000000000000000002962
      D6002669E000236EEA002173F1002376F3002175F3002271EE00246CE6002766
      DC00EDEDED0000000000000000000000000000000000000000000000000016AD
      F90010B7FB000AC0FD0005C7FE000ECBFE0008CAFE0007C4FD000DBCFC0013B2
      FA00EDEDED0000000000000000000000000000000000000000008D7EC600735D
      BD00A89BD600A89BD600A89BD600A89BD600A4F1FF00A79BD400A89BD600A89B
      D600735DBE007C68C2000000000000000000000000000000000000000000BD84
      7B00BD948400BD948400BD948400BD948400BD948400EFE7DE00EFD6D600E7C6
      C600BD9484000000000000000000000000000000000000000000000000000000
      00002864D8002669E000246CE600236EE900246DE800256BE4002767DD007F92
      BB00000000000000000000000000000000000000000000000000000000000000
      000015AFFA0010B7FB000CBCFD000BBFFC000BBFFD000EBAFC0012B4FB0078AD
      C800000000000000000000000000000000000000000000000000000000008876
      C800B7ACDF00B9AEE100B9AEE100B9AEE100FEFFFF00B9AEE100B9AEE100B9AE
      E100836FC8000000000000000000000000000000000000000000000000007B29
      0800F7E7E700EFDEDE00D6B5AD00D6B5AD00D6B5AD00F7E7E700E7CECE00EFD6
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000002962D5002765DA002766DC002766DC002864D800E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000017ACF90014B1FA0012B3FA0013B2FA0015AFFA00E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AA9CDB00C8BFE800C7BEE800C7BEE800C7BEE800C7BEE800C7BEE800A08F
      D700000000000000000000000000000000000000000000000000000000000000
      0000944A3100F7EFE700F7EFEF00EFDEDE00EFDEDE00F7EFEF00F7E7E7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B8ABDF00B0A2DF00AFA1DF00AC9DDC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084391800FFFFFF00DECEC600BD948400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F800E7E7E700D9D9D900D5D5D500DCDC
      DC00EBEBEB00FBFBFB0000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5004E4D4E00393A3C00F2F2F200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5004E4D4E00393A3C00F2F2F200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5004E4D4E00393A3C00F2F2F200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE00A49CAD00A895CD00AE91DB00A28F
      C300AAA5AD00DEDEDE00FEFEFE00000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      000000000000000000000000000000000000000000000000000000000000FDFD
      FD00E3D6BC00A2978800F9F9F9007A69B000D1B3F800D9B6F900E0C2FD00CD9A
      F700191D9B00ACA8B700FEFEFE00000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      000000000000000000000000000000000000000000000000000000000000AFB0
      B100DCBA8700E4CB9C008E768700674BBE00D0B2F600F4EFFD00FCFAFF00F4ED
      FC002426BF0011136900F0F0F100000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F5F5F400DEDDDC00D8D7D500E8E7E500000000000000
      0000000000000000000000000000000000000000000000000000DADADA00E0A7
      6E00E6CFAD00EED299000E0F5B007E59E000C392F300F3E2FC00C1ACFC00A48D
      F5002729C40016187200604DD300000000000000000000000000000000000000
      000000000000E1E1E100F5F5F400DEDDDC00D8D7D500E8E7E500F3F3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1E1E100F5F5F400DEDDDC00D8D7D500E8E7E500F3F3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E1E1E100F5F5F400DEDDDC00D8D7D500E8E7E500F3F3F3000000
      00000000000000000000000000000000000000000000EDEDED0085838300A76A
      3900D2A16B00E7BE7D00362FB5005E45D300A76EEC00362FE4004739ED00362F
      DE002023B3001416750025208000000000000000000000000000000000000000
      0000DBDAD900E8E8E700ECEBEA00EDECEC00EDECEB00EAE9E900E6E6E500CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      0000C7A47400CEA77300CFA97700D0AA7900D0AA7800CFA87500CDA67000CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      00004DB57D004DBF830057C38D005CC691005BC5900053C2890048BC7E00CECE
      CE0000000000000000000000000000000000FBFBFB00C3C3C300DA9B6100CAA5
      8600BB804F00D49E5D00312CB300503DCF008560E8004B48D000635CDB004240
      CA002326A70011147000201D780000000000000000000000000000000000D1D1
      D100E9E8E800EEEDED00F2F1F100F3F3F200F3F3F200F0F0EF00ECEBEB00E7E6
      E500F5F5F500000000000000000000000000000000000000000000000000D0CF
      CD00CFA87400D1AB7A00D3AF8000D3B08300D4B08200D2AD7E00D0AA7800CDA6
      7000F5F5F500000000000000000000000000000000000000000000000000CCCF
      CE0050C0850060C895006DCEA10073D1A70071D0A50068CB9C0059C48E0047BC
      7E00F5F5F500000000000000000000000000FAFAFA00B2A9A000BA987700E8CB
      B000E3C9AE00D6B18F002E29B1004D45CA00A89DEE00D2CEFB00CDCBEC00B7B5
      E3008985D50021247C0040319B00ECECEC00000000000000000000000000E6E5
      E500EDECEC00F2F2F100F7F6F600F8F8F800F8F8F800F5F4F400F0F0EF00EAE9
      E900A4A3A300000000000000000000000000000000000000000000000000CDA6
      7000D0AB7900D3AF8100D6B48B00D8B89100D8B78F00D5B28600D2AD7E00CFA8
      7500A099900000000000000000000000000000000000000000000000000047BC
      7D005CC6910070CFA4007FD6B10086D8B70084D8B5007AD4AC0067CB9C0053C1
      8900889C910000000000000000000000000000000000F3D0AD00F7E8D500F2E0
      CD00EEDECA00EEDAC500957EB8007475D100C2C3F200E9E9FD00F0F1FA00E1E2
      F500AEAFDC00494C9200BFBBC200000000000000000000000000FEFEFE00E8E8
      E700EFEFEE00F5F5F400F7F7F700FAFAFA00FBFBFB00F8F8F700F3F2F200ECEC
      EB00E5E4E3000000000000000000000000000000000000000000FEFEFE00CEA7
      7300D2AD7C00D5B28700DABB9600DEC2A100DCBF9C00D7B78E00D4B08200D0AA
      7800CDA56F000000000000000000000000000000000000000000FEFEFE004DBF
      830064CA99007AD4AD008CDABC0098DFC60093DDC20083D7B50071D0A5005AC5
      8F0043BA7A00000000000000000000000000CDC1B400B7A99D00F8EEE100F7ED
      E100F6ECE000F5EBDD00F3E7D8008D7BC600D3D6F400F7F8FD00FEFEFF00F2F2
      FA00C6C9DF009886AA00D9D9D900000000000000000000000000FEFEFE00E9E8
      E700F0EFEF00F5F5F500FAFAFA00FDFDFD00FCFCFC00F8F8F800F3F2F200EDEC
      EB00E5E4E3000000000000000000000000000000000000000000FEFEFE00CEA7
      7300D1AD7D00D5B38800DABC9700DFC4A500DDC19F00D8B89000D3B08300D0AA
      7900CDA56F000000000000000000000000000000000000000000FEFEFE004EBF
      840065CA9A007BD4AE008DDBBC009CE0CA0096DEC40085D8B60073D0A6005BC5
      900044BA7B0000000000000000000000000000000000FFFAF500F8F2EA00F8F4
      ED00F9F5EE00F9F3EE00F8F2EA00F5ECE200D7CACD00CCC2DF00D4CEEE00C0AF
      CC00AC805E00E1E1E2000000000000000000000000000000000000000000E7E6
      E600EEEDED00F4F3F300F8F8F800FAFAFA00FAFAFA00F6F6F600F1F1F000EBEA
      EA00E2E1E000000000000000000000000000000000000000000000000000CDA6
      7100D1AC7A00D4B08400D8B78F00DABB9600DABA9400D6B48A00D3AF8000CFA9
      7600CBA46E000000000000000000000000000000000000000000000000004ABD
      800060C8940075D2A80084D8B5008CDBBC008ADABA007ED5B0006CCD9F0056C3
      8C0042B777000000000000000000000000000000000000000000F4F4F400FFFE
      FC00FAF8F500FCFAF700FBF9F600F9F5EF00F4ECE300ECE0D300E2D0BF00D5BE
      A900D6CBC300EDEDED000000000000000000000000000000000000000000E4E3
      E200EBEAE900F0EFEF00F3F3F300F5F5F500F5F4F400F2F2F100EEEDEC00E8E7
      E600EDEDED00000000000000000000000000000000000000000000000000CCA5
      6E00CFA97600D1AD7D00D4B08400D5B38700D4B28600D3AF8100D0AB7A00CEA7
      7200EDEDED0000000000000000000000000000000000000000000000000041B8
      780054C28A0066CB9B0074D1A8007BD4AD0079D4AC006FCFA2005FC793004CBE
      8200EDEDED000000000000000000000000000000000000000000000000000000
      0000F8F8F800FCFCFC00FDFCFB00FAF8F600F6F1EB00EFE7DE00E7DACD00DAC6
      B500F2F2F2000000000000000000000000000000000000000000000000000000
      0000E6E5E400EAEAE900EEEDED00EFEFEE00EFEEEE00EDECEB00E9E8E700C1C1
      C000000000000000000000000000000000000000000000000000000000000000
      0000CEA67000CFA97500D1AB7A00D1AD7C00D2AC7C00D0AA7800CFA87300B9AA
      9600000000000000000000000000000000000000000000000000000000000000
      000045BB7C0054C28A005FC7940065CA990063C998005BC590004EBF840086B1
      9A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00F4F4F300F6F3EF00EFEAE400E9DFD500FAF8
      F700FEFEFE000000000000000000000000000000000000000000000000000000
      000000000000E4E3E200E7E6E500E8E8E700E8E7E600E6E5E400E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCA56E00CDA67100CEA77300CEA77200CDA57000E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000040B8770049BD7F004DBF83004CBE820046BB7C00E2E2E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F1F1F100F2EDE800E9E9
      E900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E6E2E00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D5CDC800B66C4900D38E620098695600FBFAF9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F800E7E7E700D9D9D900D5D5D500DCDC
      DC00EBEBEB00FBFBFB0000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F800E7E7E700D9D9D900D5D5D500DCDC
      DC00EBEBEB00FBFBFB0000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8F800E7E7E700D9D9D900D5D5D500DCDC
      DC00EBEBEB00FBFBFB0000000000000000000000000000000000000000000000
      0000C5BEBB00D1814F00E5AB7500E5AB7500E5AB7500E5AB7500DC8E5600C2BC
      BC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE008EACAE0074CDD40062D2DD0076C5
      CB009BABAC00DEDEDE00FEFEFE00000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE008FAA990094D3A70090DCB1008AC8
      9F009DAAA200DEDEDE00FEFEFE00000000000000000000000000000000000000
      00000000000000000000FBFBFB00CECECE00B0B0B000D1D1D100DADADA00C8C8
      C800ADADAD00DEDEDE00FEFEFE00000000000000000000000000C3B9B400D693
      6000F5C68800F5C68800F5C68800F5C68800EABE8C008174D8004C4CFE00745E
      B8009E705800F9F8F8000000000000000000000000000000000000000000FDFD
      FD00E3D6BC00A2978800F9F9F90078ABB8005FE5F00067EDF6006AF2FA0053E8
      F600173C5300AFBCBF00FEFEFE0000000000000000000000000000000000FDFD
      FD00E3D6BC00A2978800F9F9F90077BB8A00B2F8D400B6F9E300C2FDEB0099FA
      DB002C6D2700AEBFB400FEFEFE0000000000000000000000000000000000FDFD
      FD00E3D6BC00A2978800F9F9F900AFAFAF00ECECEC00F4F4F400F9F9F900EFEF
      EF0098989800BABABA00FEFEFE000000000000000000C9643900FDD99D00FFDB
      9F00FFDB9F00FFDB9F00E3D7900034E40C002C51CD005252FF004C4CFE000000
      EA00D7BDA800F4BA7B00DCD7D40000000000000000000000000000000000AFB0
      B100DCBA8700E4CB9C009CA38E00439BAD009AEEF500E8FCFD00FBFFFF00DBFD
      FE002E69820017364400F1F2F20000000000000000000000000000000000AFB0
      B100DCBA8700E4CB9C0090A8710050B46B00B2F6D800EFFDF500FAFFFC00ECFD
      F300379436001C4E1B00F1F2F10000000000000000000000000000000000AFB0
      B100DCBA8700E4CB9C00B8A98F00A6A6A600EEEEEE00FDFDFD00FFFFFF00FEFE
      FE00A6A6A6006B6B6B00F2F2F2000000000000000000CF7C5500DBA37D00E6B2
      8A00F6D7A500F2B0520047BD2F002BE401002C5BBF005252FF004C4CFE000000
      EA00B6777700D7976E00EBD2C600000000000000000000000000DADADA00E0A7
      6E00E6CFAD00EED09900213D460075D4E800C1EEF500F4FBFC00CEFAFB00B4ED
      F10047899E00294D5A0074CCE800000000000000000000000000DADADA00E0A7
      6E00E6CFAD00EED09A001545170059E07E0092F3CC00E1FCF600B7FBC10098F1
      AA00379D37001F5A1E0056DC7400000000000000000000000000DADADA00E0A7
      6E00E6CFAD00EDD099004D4E4F00B1B1B100E8E8E800FDFDFD00F5F5F500E6E6
      E600A2A2A2006E6E6E00A7A7A7000000000000000000D1815B00E1B29000E1B2
      9000D4884A00F0AA49004BBD2F002BE401002C67B2005454FE007070FC000000
      EA00BF929100DEAA8500F0D7CA000000000000000000EDEDED0085838300A76A
      3900D2A16B00E6BB7C0058B3D2007FD2E700C4ECF4007BDADF008FE5E90077D2
      D900518FA300345E6A00427486000000000000000000EDEDED0085838300A76A
      3900D2A16B00E7BB7F002FB4420045D361006DEC990043DA43004EE5510041D3
      43002B902C001C5E1D0023752C000000000000000000EDEDED0085838300A76A
      3900D2A16B00E5BB7D00777777009D9D9D00CECECE00B9B9B900C6C6C600B3B3
      B30090909000676767005B5B5B000000000000000000D3866200E5BC9E00E5BC
      9E00D4894B00F0AA490050BD2F002BE4010051BA74006A6AFD00A2A2F600726E
      D800D6AC9800E2B59400F1DACE0000000000FBFBFB00C3C3C300DA9B6100CAA5
      8600BB804F00D2985B0061BEDD0087D6E900B8EBF4008CC7CE00A2D4D90082C2
      C8005993A10038606A004672810000000000FBFBFB00C3C3C300DA9B6100CAA5
      8600BB804F00D49861002BB23D003DCF560060E8800055C4560068D16B004CBD
      4E002C892E00195918001F6B280000000000FBFBFB00C3C3C300DA9B6100CAA5
      8600BB804F00D19A5E007171710091919100BBBBBB00B9B9B900C8C8C800AFAF
      AF00868686005C5C5C00545454000000000000000000D58C6B00EAC8B000EAC8
      B000D58B4D00F0AA490056BD2E002BE401002ED721002FAF0000E7C1A600E7C1
      A600E7C1A600E7C1A600F2DDD30000000000FAFAFA00B2A9A000BA987700E8CB
      B000E3C9AE00D5AD8E0079CDE8009BDCEC00D5F4F900ECFCFD00E1EEF000D3E4
      E700B9DADF00547F870072A7B200ECECEC00FAFAFA00B2A9A000BA987700E8CB
      B000E3C9AE00D6AE910028B03D0045CA57009DEEAB00CEFCD500CEE7CF00B9DC
      BA0087D28E00266C280036994E00ECECEC00FAFAFA00B2A9A000BA987700E8CB
      B000E3C9AE00D4AE90006E6F70008E8E8E00D2D2D200EDEDED00EBEBEB00DFDF
      DF00BBBBBB005E5E5E007B7C7D00ECECEC0000000000D8947500EED4C000EED4
      C000D58D5000F0AA49005ABD2D002BE4010033D826002FAF0000ECCEB900ECCE
      B800ECCEB800ECCEB800F3DFD6000000000000000000F3D0AD00F7E8D500F2E0
      CD00EEDECA00EEDAC500AFD0CE00BFEAF500EAF9FC00FAFEFD00F8FCFB00F1F8
      F800D2E6E80082A6AB00C1C8C7000000000000000000F3D0AD00F7E8D500F2E0
      CD00EEDECA00EEDAC50092C9970074D17900C2F2C600E9FDEB00F1F9F100E2F3
      E200AFD8B1004C874D00C2C9C3000000000000000000F3D0AD00F7E8D500F2E0
      CD00EEDECA00EEDAC500C2BAB200A2A2A200DDDDDD00F5F5F500F7F7F700EEEE
      EE00CBCBCB0073737300C8C8C7000000000000000000DB9A7F00F2DFD200F2DF
      D200D68F5400F0AA490084CB440035E6030037CE010058C83200F1DBCC00F1DB
      CC00F1DBCC00F1DBCC00F3DFD60000000000CDC1B400B7A99D00F8EEE100F7ED
      E100F6ECE000F5EBDD00F2E6D800B0D7DA00F5FBFD00FDFFFF00FEFFFF00FAFD
      FD00E1ECEC00A6BCB800D9D9D90000000000CDC1B400B7A99D00F8EEE100F7ED
      E100F6ECE000F5EBDD00F2E6D80087CA9A00D3F4D500F7FDF800FEFEFE00F2F9
      F200C7DCC7009CBC9B00D9D9D90000000000CDC1B400B7A99D00F8EEE100F7ED
      E100F6ECE000F5EBDD00F2E6D800BDBBBA00E3E3E300FAFAFA00FEFEFE00F6F6
      F600D4D4D400BCB5AD00D9D9D9000000000000000000ECCDC100E9BCA400F6EA
      E000D7925800F0AA4900F8A41800C27F0900E0EAC800F5E7DC00F5E7DC00F5E7
      DC00F5E5D900EBB99700F7E8E2000000000000000000FFFAF500F8F2EA00F8F4
      ED00F9F5EE00F9F3EE00F8F2EA00F5ECE200D9DCD300CCE7E800D2F0F400C1D6
      D500AC816000E1E1E200000000000000000000000000FFFAF500F8F2EA00F8F4
      ED00F9F5EE00F9F3EE00F8F2EA00F5ECE200DFDFCD00D3EBD800DCF4E600C5DA
      C100AE836100E1E1E200000000000000000000000000FFFAF500F8F2EA00F8F4
      ED00F9F5EE00F9F3EE00F8F2EA00F5ECE200E8DDD200E8E5E300F0F1F100DDD4
      CE00AD826000E1E1E2000000000000000000000000000000000000000000EAC4
      B500D58C5200F0AA4900F8A41800C27D0400FAF3EE00F9F0E900F2CFB400E0A1
      8400FDFAF9000000000000000000000000000000000000000000F4F4F400FFFE
      FC00FAF8F500FCFAF700FBF9F600F9F5EF00F4ECE300ECE0D300E2D0BF00D5BE
      A900D6CBC300EDEDED0000000000000000000000000000000000F4F4F400FFFE
      FC00FAF8F500FCFAF700FBF9F600F9F5EF00F4ECE300ECE0D300E2D0BF00D5BE
      A900D6CBC300EDEDED0000000000000000000000000000000000F4F4F400FFFE
      FC00FAF8F500FCFAF700FBF9F600F9F5EF00F4ECE300ECE0D300E2D0BF00D5BE
      A900D6CBC300EDEDED0000000000000000000000000000000000000000000000
      0000DA996300F0AA4A00F7A42200C27D0400E0A17F00F9F1EC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F800FCFCFC00FDFCFB00FAF8F600F6F1EB00EFE7DE00E7DACD00DAC6
      B500F2F2F2000000000000000000000000000000000000000000000000000000
      0000F8F8F800FCFCFC00FDFCFB00FAF8F600F6F1EB00EFE7DE00E7DACD00DAC6
      B500F2F2F2000000000000000000000000000000000000000000000000000000
      0000F8F8F800FCFCFC00FDFCFB00FAF8F600F6F1EB00EFE7DE00E7DACD00DAC6
      B500F2F2F2000000000000000000000000000000000000000000000000000000
      0000ECC09900DC8A3300EC951C00F6B455000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00F4F4F300F6F3EF00EFEAE400E9DFD500FAF8
      F700FEFEFE000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00F4F4F300F6F3EF00EFEAE400E9DFD500FAF8
      F700FEFEFE000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00F4F4F300F6F3EF00EFEAE400E9DFD500FAF8
      F700FEFEFE000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFAF500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F1F1F100F2EDE800E9E9
      E900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F1F1F100F2EDE800E9E9
      E900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F1F1F100F2EDE800E9E9
      E90000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FEFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FC3FFFFFFFFFFFFFF00F0FF0FFFFFFFF
      E00703C0FDFFF8FFE0070000FDFFF07FE0070003FDFFC03FF00F8007FDFFDDDF
      F00FC003FDFFFDFFF00FD003FDFFFDFFF00FF847FDFFFDFFF00FF03FFDFFFDFF
      F00FE207FDFFFDFFF00FCF07C51FFDFFF00F9F07E03FFDFFF00FFF07F07FFDFF
      FFFFFF07F8FFFDFFFFFFFF9FFFFFFFFFFFFFFFFFC003FFFFFC3FFC3F8001F03F
      F83FF83F8001E003F83FF83FC001F005F83FF83FC003FE03F81FF81FC003C003
      F00FF00F8001E007E007E0078001F007E007E0078001E007C007C0078001E007
      C007C0078001C007E007E007C001E007E007E007C003E007F00FF00FE007E00F
      F81FF81FF00FF01FFFFFFFFFFC3FFC3FFFDFFFFFFFFFFFFFFE03FC3FFC3FFC3F
      FC01F83FF83FF83FE001F83FF83FF83FE001F83FF83FF83FC001F81FF81FF81F
      8001F00FF00FF00F0001E007E007E0070000E007E007E0078001C007C007C007
      0001C007C007C0078003E007E007E007C003E007E007E007F007F00FF00FF00F
      FC07F81FF81FF81FFF0FFFFFFFFFFFFFFF7FFFDFFFDFFFDFFC1FFE03FE03FE03
      F00FFC01FC01FC01C003E001E001E0018001E001E001E0018001C001C001C001
      8001800180018001800100010001000180010000000000008001800180018001
      80010001000100018001800380038003E007C003C003C003F03FF007F007F007
      F0FFFC07FC07FC07FDFFFF0FFF0FFF0F00000000000000000000000000000000
      000000000000}
  end
  object mnuCluster: TAdvPopupMenu
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 179
    Top = 56
    object miExecSetClust: TMenuItem
      Caption = '��������� ���������'
      OnClick = miExecSetClustClick
    end
    object N34: TMenuItem
      Caption = '��������/������� ������'
      OnClick = miAddAllClsClick
    end
    object N30: TMenuItem
      Caption = '-'
      Visible = False
    end
    object miDelAllCls: TMenuItem
      Caption = '������� ������'
      OnClick = miDelAllClsClick
    end
    object miDelCls: TMenuItem
      Caption = '������� �������'
      Visible = False
      OnClick = miDelClsClick
    end
  end
  object ImageList1: TImageList
    Left = 59
    Top = 313
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
      000000000000FEFEFE00F9FBFC00F5F8FA00F5F8FA00FAFBFC00FEFEFE000000
      000000000000000000000000000000000000B0B0B0FFD5D5D5FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFD
      FE00E9F2F500CAE1E80097BED0006F9CBA00719EBB009EC3D300D0E4EB00ECF4
      F600FEFEFE00000000000000000000000000878787FF646464FFBFBFBFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BCBCBCFF696969FF646464FF646464FF888888FFF1F1F1FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9FBFC00D2E5
      EB00426FA1001C458E00244E94001D4490001D448F00244B9200183C85005480
      A900D7E7ED00FBFCFD000000000000000000808080FF646464FF646464FFBFBF
      BFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E3E3
      E3FF646464FF646464FF646464FF646464FF646464FF646464FF646464FF7575
      75FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FAFCFC00CAE0E700139A
      F9001F85E4000731890009338A0009328A0008318800082F860004277F002097
      FA001690ED00D5E6EC00FDFDFE000000000000000000808080FF646464FF6464
      64FFBEBEBEFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E1E1E1FF6464
      64FF646464FFBBBBBBFF0000000000000000E5E5E5FFFBFBFBFF727272FF6464
      64FF686868FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1EDF100139BF8001E96
      FF001D9AFF000D449A000B3D92000B3B91000B398F000A388E000E4FAE00188D
      FF00198BFF001C8FE900E9F2F500000000000000000000000000808080FF6464
      64FF646464FFE0E0E0FF00000000F9F9F9FFA3A3A3FF797979FF838383FFC3C3
      C3FF000000000000000000000000000000000000000000000000646464FF6464
      64FFF8F8F8FF0000000000000000000000000000000000000000000000008F8F
      8FFF646464FF9F9F9FFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F8FAFC0062A7D70020A1FF0020A0
      FF00209FFF0021A1FE000D4193000D4497000D4296000B3A8D001E9CFF001B94
      FF001A90FF001898FF008CBAD700FBFCFD000000000000000000000000008080
      80FFAFAFAFFF686868FF7C7C7CFF646464FF838383FFB6B6B6FFADADADFF6868
      68FF646464FFCFCFCFFF000000000000000000000000B6B6B6FF646464FFBEBE
      BEFF00000000ACACACFFFDFDFDFF00000000C3C3C3FF00000000000000000000
      0000646464FF646464FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F6F80015A9FF0023A5FF0023A8
      FF0023A8FF0023A7FF001977CB00114E9E00104A9C001B89E4001F9EFF001E9A
      FF001C97FF001B91FF000D93F400F5F9FA000000000000000000000000000000
      0000CBCBCBFF6D6D6DFF707070FF8D8D8DFFE4E4E4FF0000000000000000B5B5
      B5FFC0C0C0FF646464FFCCCCCCFF0000000000000000666666FF646464FF0000
      000000000000000000006B6B6BFFAFAFAFFF9B9B9BFFD2D2D2FF000000000000
      0000ACACACFF646464FFEDEDEDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D4E5EC001DB2FF0026AEFF0026B0
      FF0027B0FF0027B0FF0028B4FF001354A100145BA90024ACFF0023A5FF0021A2
      FF001F9DFF001D99FF000F9FFF00EBF3F6000000000000000000000000000000
      0000BDBDBDFF656565FF858585FF000000000000000000000000000000000000
      0000FBFBFBFFBEBEBEFF646464FF0000000000000000646464FF646464FF0000
      000000000000969696FFC4C4C4FF646464FFDFDFDFFFCACACAFF000000000000
      0000DFDFDFFF646464FFC8C8C8FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BAD6E50038BEFF0027B5FF002AB8
      FF002AB8FF002AB8FF002AB8FF0026A6EF0028B3FF0027B1FF0026ADFF0024A9
      FF0022A5FF001F9FFF002BAAFF00DAE9EF000000000000000000000000000000
      0000646464FFBDBDBDFF00000000000000000000000000000000000000000000
      000000000000BEBEBEFF717171FFB7B7B7FF00000000646464FF646464FF0000
      00000000000000000000969696FFEBEBEBFF646464FFBDBDBDFFC0C0C0FF0000
      0000AEAEAEFF646464FFD2D2D2FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C4DBE600347DB900357DB9002171
      B400196EB2001A6FB2001A6EB100218ED1001B75BA001763AA00155EA7001156
      A3001C58A4002C60A7002C5FA500E4EEF3000000000000000000000000000000
      0000646464FF878787FF00000000000000000000000000000000000000000000
      00000000000000000000B7B7B7FF747474FF000000007D7D7DFF646464FFFEFE
      FEFF000000000000000000000000646464FFF0F0F0FF757575FF000000000000
      0000818181FF646464FFFEFEFEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F6F8004F98CA003F8EC4004090
      C5004192C600378CC3002A80BC0037CCFF0037C8FF002875B500347CBA003B7C
      BA003875B600366FB2004879B600FDFDFE000000000000000000000000000000
      0000646464FF858585FF00000000000000000000000000000000000000000000
      00000000000000000000B7B7B7FF686868FF00000000EAEAEAFF646464FF7777
      77FF000000000000000000000000C9C9C9FF0000000000000000CFCFCFFFFBFB
      FBFF646464FF646464FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005799CD00469ACB004A9F
      CE004AA0CE004A9FCD0056CFF70058D5FF0057D3FF004FB6E800458DC4004388
      C1004181BD003C78B8004E7EB300FEFEFE000000000000000000000000000000
      0000646464FFA5A5A5FF00000000000000000000000000000000000000000000
      000000000000F5F5F5FFA1A1A1FF8F8F8FFF0000000000000000717171FF6464
      64FF959595FF0000000000000000000000000000000000000000FBFBFBFF6464
      64FF646464FFEAEAEAFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C2DAE70086C7E20053AC
      D50055AFD60057B6DC0062E0FF0061DDFF0060DBFF005FDAFF004E99CB004C93
      C700478AC20083B1D600E5EFF300000000000000000000000000000000000000
      0000787878FF9A9A9AFFDDDDDDFF000000000000000000000000000000000000
      0000000000007E7E7EFF646464FFEDEDEDFF0000000000000000000000006666
      66FF646464FF646464FFAEAEAEFFE2E2E2FFD1D1D1FF818181FF646464FF6464
      64FFBCBCBCFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006AA8D30097D5
      E9005BB9DA006CEAFF006BE7FF006AE4FF0069E1FF0067DEFF0064D7FC00519A
      CB0098C5E00085ADCD00FEFEFE00000000000000000000000000000000000000
      0000FCFCFCFF646464FFC2C2C2FFE1E1E1FF0000000000000000000000000000
      00008C8C8CFF898989FF6E6E6EFF000000000000000000000000000000000000
      0000999999FF646464FF646464FF646464FF646464FF646464FF646464FFEAEA
      EAFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB4
      D900B3F4FC0096F2FF0076EDFF006FEAFF006EE6FF0073E4FF0098E8FF00A5DC
      F0008EB5D3000000000000000000000000000000000000000000000000000000
      000000000000DBDBDBFF646464FFA2A2A2FF969696FF858585FF7E7E7EFFB6B6
      B6FF6F6F6FFF666666FF00000000000000000000000000000000000000000000
      000000000000939393FFEBEBEBFF8C8C8CFFD3D3D3FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EAF2F6007CCBF000A3F4FF00B8FDFF00B5FAFF0098EAFF007AC2EA00F9FB
      FC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFBFF727272FF646464FF646464FF646464FF6464
      64FFA6A6A6FF0000000000000000000000000000000000000000000000000000
      000000000000FDFDFDFFD9D9D9FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC00F5F5F500F0F0
      F000E8E8E800E5E5E500DDDDDD00DDDDDD00DDDDDD00DDDDDD00E6E6E600E8E8
      E800F0F0F000F6F6F600FCFCFC00000000000000000000000000000000000000
      00000000000000000000FDFDFD00F0F0F000E5E5E500E1E1E100E7E7E700F2F2
      F200FCFCFC000000000000000000000000000000000000000000FEFEFE00FAFC
      FB00F2F8F500EBF4F000E6F2ED00E2F0EA00E2F0EA00E4F1EB00E8F3EE00EEF6
      F200F5F9F700FCFDFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900070780000B0B
      8100DDDDDD00DDDDDD00D5D5D500D2D2D200D2D2D200D8D8D800DDDDDD00DEDE
      DE000B0B810044449B00FAFAFA00000000000000000000000000000000000000
      0000F2F2F200B8B8B80022276A001B29B0001C31C4001C245C00494949007878
      7800AFAFAF00DBDBDB00F5F5F5000000000000000000FEFEFE00ECF5F100B8DA
      CB0092C6B00080BCA20075B79B006EB396006DB2950071B5980078B89D0084BF
      A6009DCCB800CAE3D900F7FAF900000000000000000044454700E9E9E900DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00E0E0E00000000000000000000B0B81000B0B81000B0B
      81000B0B81000000000000000000000000000000000000000000000000000B0B
      81000B0B81000B0B81002A2A910000000000000000000000000000000000FCFC
      FC001A2193001E32B200203CC6002243D4002247DF002248E5002045E4001D3A
      D50082828200BEBEBE00E7E7E700FBFBFB0000000000FEFEFE00E2F0EA0098C9
      B4006BB1930040A07C001F845900238A5F00288D63002D8F660049A3800060AA
      890076B79B00B1D6C600F3F8F600000000000000000048494C0059D9FF0047D6
      FF0035D2FF0023CFFF0011CCFF0005C9FF0007C5FE000AC2FE000CBEFD000EBB
      FC0010B7FC0012B4FB0014B1FB0000000000000000000B0B81000B0B81000B0B
      81000B0B82000C0C8200000000000000000000000000000000000C0C84000A0A
      81000B0B81000B0B81000B0B8100000000000000000000000000000000001C28
      A2001E38BE002242CF002448D300274DDB002650E4002650EA00234CEB002045
      E3001D38CB00E0E0E000F6F6F600000000000000000000000000FBFCFC00B3D5
      C5000378470004835200048C5B0004916000219F730028A177002C9F76003099
      710071C1A500F1F7F500FDFDFD0000000000000000004D4D500078DFFF0066DB
      FF0054D8FF0042D5FF0030D2FF001ECEFF000CCBFF0006C8FF0008C4FE000AC1
      FD000CBDFD000EBAFC0010B6FC0000000000000000000B0B81000C0C83000C0C
      85000D0D87000D0D87000C0C880000000000000000000E0E8A000D0D89000D0D
      86000C0C86000C0C82000B0B81000000000000000000000000001B269F001F39
      C600213FCA00203BC4001B33C7001B35CF001B39DB001D3FE3002249E6002249
      E4001F3FD7001B2CB00000000000000000000000000000000000E4EAE7000480
      4E0006905E00079A6900089F6E0008A0700008A0700008A07000089F6E002DA7
      7F002B8C68007FCDB2000000000000000000000000005252540097E4FF0085E1
      FF0073DEFF0062DBFF004FD7FF003DD4FF002BD1FF001ACDFF0008CAFF0006C7
      FE0008C3FE000BC0FD000DBCFD000000000000000000000000000D0D86000E0E
      8A000E0E8C000F0F8C000F0F8D000F0F8F000F0F8F000F0F8D000F0F8C000E0E
      8C000E0E89000D0D8800000000000000000000000000181B90001D32C0001A2F
      C0001D37C500FFFFFF001B38D7001B39DA001B3ADC001B3ADD00FFFFFF001A35
      D6001B36D2001C33C1006365B200000000000000000000000000078554000895
      64000AA271000BA574000BA574000BA574000BA574000BA57400098C6100E4E4
      E300E4E4E3002EA2790000000000000000000000000057565800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F0F
      8E000E0E8F00101092000F0F920011119400111194000F0F9200101091001010
      91000F0F8F00000000000000000000000000000000001926AA001A31C5001B34
      CC00183BE400FFFFFF00FFFFFF001E44EC001C3FE900FFFFFF00FFFFFF001531
      D1001A33CA001A31C60019209A000000000000000000C9E5D900099562000DA5
      75000EAA7A0011A3750011A2740012AB7C0012A97A00C5D2CD00EFEFEF00EFEF
      EF00008F61000DA6760065C3A40000000000000000005B5B5C00E4E4E400D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600F3F3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000111195001010970012129800121299001212990012129700121297001111
      940000000000000000000000000000000000000000001A2CBA001A33CC001B3A
      DF00214AEC00204CEC00FFFFFF00FFFFFF00FFFFFF00FFFFFF001438E5001B34
      CF001A2FC0001A32C70018219E00000000000000000029A77A000EA472001EB1
      8300F2EFF000E9E9E900E8E8E800EAE9E900EAEAEA00ECECEC00EDECEC001EB2
      84001EB4860011AF7E0017AA7A000000000000000000605F600089DABA0083D7
      B4007CD5AE0074D1A7006BCD9F0062C997005AC58F0051C08700D8D8D8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000013139A0013139D0013139E0013139E0013139C0013139C000000
      000000000000000000000000000000000000000000001A30C3001B38D8001F45
      EC00356DED004A90EE003169EC00FFFFFF00FFFFFF002A5EEC002249EC001B39
      DA001A2FC2001A31C5001924A300000000000000000018A572002AB88B00FBF5
      F70051AC8F002CBD920043C49D0052B69700DCDBDC0043B08F002CBD92002CBD
      92002CBD92002CBD920012B07F0000000000000000006564640095DEC3008EDC
      BE0087D9B80081D7B3007AD4AD0072D0A50069CC9D0060C89500D8D8D8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000013139C001313A0001414A2001414A3001414A3001414A20013139F001313
      9E0000000000000000000000000000000000000000001A32C7001B3CE1002A59
      ED004488ED005DB4EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002D5EED001C3C
      E3001B32C9001A31C5001822A100000000000000000046BE94003BC39900D3D3
      D3003CC59C005DD1AE005DD1AE005DD1AE00DADADA005DD0AE005DD1AE0040C8
      9F003CC79E003CC79E003DC69B00000000000000000069686800A1E2CD009AE0
      C80093DDC2008CDBBC0086D8B7007FD6B10078D3AB006FCFA300E3E3E3000000
      0000000000000000000000000000000000000000000000000000000000001313
      9E001414A0001313A3001515A5001414A8001414A8001515A7001515A5001414
      A10013139F00000000000000000000000000000000001A32C9001C3DE4002F62
      ED004B93ED00FFFFFF00FFFFFF00C7CFFA004077EE00FFFFFF00FFFFFF001C3E
      E7001B33CC001A31C600181F9800000000000000000075D7B8004BCEA600DDDD
      DD0075D4B80077DCBE0077DCBE0076D9BD00E7E7E70077DCBE0077DCBE0077DC
      BE004DD1AA004DD1AA0062D5B30000000000000000006E6D6C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000013139C001212
      A0001515A5001616A7001616AB001717AD001717AD001515AA001616A9001515
      A6001414A10013139D000000000000000000000000001A30C3001B3CE2002C5B
      ED00F4F5FE00FFFFFF008BB6F400CFEBFA0062BEEF002C60EC00FFFFFF0099AB
      F7001A33CC001A2FC00018198D000000000000000000000000005BD6B00060CB
      AB00F6F6F6008CD8C1008CDBC300F5F4F40098D5C3008FE6CC008FE6CC008FE6
      CC005DDBB6005DDBB600CFECDE00000000000000000073717000DCDCDC00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00F0F0F0000000000000000000000000000000000013139B0013139E001414
      A4001616A8001717AC001818AE0000000000000000001818B0001717AD001616
      A8001515A5001313A10013139C000000000000000000000000001B39D900224B
      EC003974ED004F9AEE005BB1EE005DB4EF00509DED003C79ED00244FEC001B3A
      DC001B32C8001927AC000000000000000000000000000000000088E5C8006CE2
      C0009CE5CF00FBFBFB00FBFBFB009DE1CD00A4EED900A4EED900A4EED900A4EE
      D9006CE3C10076E5C500000000000000000000000000777574003883F500327F
      F5002B7BF5002477F4002174F2002271EE00246FEA00256CE5002669E1002767
      DD00D9D9D9000000000000000000000000000000000013139B001212A1001515
      A6001616A9001818AF00000000000000000000000000000000001818B0001717
      AC001515A7001414A10013139E00000000000000000000000000717FDE001C3D
      E4002652EC00376FED003F7FEE004081EE003771ED002856ED001C3DE6001A36
      D1001A2DBC00FDFDFE00000000000000000000000000000000000000000082EA
      CB00B4F4E100B5F4E200B5F4E200B5F4E200B5F4E200B5F4E200B5F4E200B5F4
      E2007DEBCB00000000000000000000000000000000007C797800448AF6003D86
      F6003682F500307EF500297AF4002376F4002173F1002370ED00246EE800256B
      E400D9D9D900000000000000000000000000000000000D0D98001414A2001515
      A7001717AC000000000000000000000000000000000000000000000000001717
      AC001616A7001414A20013139D0000000000000000000000000000000000D6DB
      F6001B3CE2001E44EC002550EC002550EC001F44EC001C3CE4001B36D3001A2E
      BE00000000000000000000000000000000000000000000000000000000000000
      0000A5F3DD00C5F7EA00C3F7E900C3F7E900C3F7E900C3F7E900C4F7E9009AF2
      D9000000000000000000000000000000000000000000807D7C004F91F700488D
      F6004289F6003B85F6003581F5002E7DF5002779F4002175F4002272F0002370
      EC00E8E8E800000000000000000000000000000000000000000010109F00A8A8
      FE00000000000000000000000000000000000000000000000000000000000000
      0000A8A8FE002323A80000000000000000000000000000000000000000000000
      0000000000005366DD001B38D9001B38D9001B37D3001A32C8009EA5E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5F5E100ACF6E100ABF6E000A7F5DE00000000000000
      00000000000000000000000000000000000000000000FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC00F5F5F500F0F0
      F000E8E8E800E5E5E500DDDDDD00DDDDDD00DDDDDD00DDDDDD00E6E6E600E8E8
      E800F0F0F000F6F6F600FCFCFC000000000000000000F1F1F100E4E4E400DADA
      DA00D2D2D200CDCDCD00C5C5C500C5C5C500C5C5C500C5C5C500D0D0D000D2D2
      D200DCDCDC00E5E5E500F2F2F20000000000000000000000000000000000B9B9
      B9008E8E8E008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008E8E
      8E00B0B0B000FBFBFB0000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD00F0F0F000E5E5E500E1E1E100E7E7E700F2F2
      F200FCFCFC0000000000000000000000000000000000F9F9F900F0F0F000E8E8
      E800DDDDDD0030B2610033B2640033B2640033B2640033B26400C6D5CC00DEDE
      DE00E8E8E800F1F1F100FAFAFA000000000000000000FDFDFD00F8F8F800F2F2
      F200F1F1F100E8E8E80035B1630035B1630035B1630084C59C00E8E8E800F1F1
      F100F3F3F300F8F8F800FDFDFD00000000000000000000000000000000002B80
      F5001874F4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4002079
      F5001B77F400F9F9F90000000000000000000000000000000000000000000000
      0000F2F2F200B8B8B800275935002493460027A7500020512F00494949007878
      7800AFAFAF00DBDBDB00F5F5F5000000000000000000000000000000000031B6
      690030B6690030B6690030B6690030B6690030B6690030B6690030B6690030B6
      6900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000031B5660031B5660031B5660031B56600000000000000
      0000000000000000000000000000000000000000000000000000000000003083
      F6001C77F5000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF400277E
      F500247CF500000000000000000000000000000000000000000000000000FCFC
      FC0021783A0027974D002BAB5A002DBA62002FC567002FC969002EC8660029B9
      5A0082828200BEBEBE00E7E7E700FBFBFB0000000000000000002FBA6E002FBA
      6E002FBA6E002FBA6E002FBA6E002FBA6E002FBA6E002FBA6E002FBA6E002FBA
      6E002FBA6E000000000000000000000000000000000000000000000000000000
      000000000000000000002EB86D002EB86D002EB86D002EB86D00000000000000
      0000000000000000000000000000000000000000000000000000000000002E82
      F6001F79F5000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF400257C
      F500277DF5000000000000000000000000000000000000000000000000002387
      420029A454002DB5610030BA660031C16C0033CB710033D0710031D06E002EC8
      660029AF5600E0E0E000F6F6F6000000000000000000BDEAD3002BBE71002BBE
      71002BBE71002BBE71002BBE7100FFFFFF00FFFFFF002BBE71002BBE71002BBE
      71002BBE71002BBE710000000000000000000000000000000000000000000000
      000000000000000000002DBC72002DBC72002DBC72002DBC7200000000000000
      0000000000000000000000000000000000000000000000000000000000002B80
      F500217AF5000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF400237A
      F500297EF50000000000000000000000000000000000000000002283400029AA
      57002CAF5D002AA9580027A95100FFFFFF00EAFAEE002BC660002FCB6A002FC8
      69002CBB5E00249448000000000000000000000000002AC077002AC077002AC0
      77002AC077002AC077002AC07700FFFFFF00FFFFFF002AC077002AC077002AC0
      77002AC077002AC077002AC07700000000000000000000000000000000000000
      000000000000000000002AC075002AC075002AC075002AC07500000000000000
      000000000000000000000000000000000000000000000000000000000000297F
      F500237BF50096C1FA00D7E7FD00D7E7FD00D7E7FD00D7E7FD0099C1FA00217A
      F5002B80F500000000000000000000000000000000001F73350026A4500025A3
      4D0028A95300FFFFFF0028B85700FFFFFF00FFFFFF0028BE5900FFFFFF0028B9
      560028B5560028A55100679F7600000000000000000028C5790028C5790028C5
      790028C5790028C5790028C57900FFFFFF00FFFFFF0028C5790028C5790028C5
      790028C5790028C5790028C57900000000000000000000000000E8F8F100E8F8
      F100E8F8F100E8F8F10028C57B0028C57B0028C57B0028C57B00E8F8F100E8F8
      F100E8F8F100E8F8F1000000000000000000000000000000000000000000267D
      F500267DF500D7E7FD00066AF400066AF4000E6FF400066AF40080B3F9001E78
      F5002D81F500BBD6FB00000000000000000000000000238D420026A84F0027AE
      5200A7EBC000FFFFFF002CCF6600FFFFFF00FFFFFF002FCC6900FFFFFF0023BA
      590026AC510026A94F00207E3A000000000027C97E0026C97D0026C97D0023C7
      7C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0026C97D0026C97D0026C97D000000000024C87E0024C87E0024C87E0024C8
      7E0024C87E0024C87E0024C87E0024C87E0024C87E0024C87E0024C87E0024C8
      7E0024C87E0024C87E0024C87E00000000000000000000000000B3D1FC00257C
      F500277EF500D7E7FD00E2EEFE000F6FF4000F6FF400DCEAFD00D7E7FD001C77
      F5003083F5003A88F500000000000000000000000000249D4A0027AE52002AC1
      5B002FD16C003BD7850041DC93005ADA8A0034D2720030D06C0029C45D0027B2
      540025A34C0026AA500021823C000000000024CC810024CC810024CC8100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0024CC810024CC810024CC81000000000023CD830023CD830023CD830023CD
      830023CD830023CD830023CD830023CD830023CD830023CD830023CD830023CD
      830023CD830023CD830023CD83000000000000000000000000004A92F600227A
      F5002A7FF5000C6DF40061A0F8000F6FF4000F6FF4001673F400B6D3FB001B76
      F5003384F6001170F50000000000000000000000000026A64E0028B9580048D7
      8000FFFFFF00FFFFFF00FFFFFF0059E8C4004FE1AE00FFFFFF00FFFFFF00FFFF
      FF0026A54F0026A84F0021873E000000000035D2900022CF860022CF860022CF
      860072E0B10072E0B10072E0B100FFFFFF00FFFFFF0072E0B10072E0B10072E0
      B10022CF860022CF860022CF86000000000020D0850021D0850021D0850021D0
      850021D0850021D0850021D0850021D0850021D0850021D0850021D0850021D0
      850021D0850021D0850021D085000000000000000000000000000F6FF4002079
      F5002C81F5000F6FF400D7E7FD00D7E7FD00D7E7FD00D7E7FD000F6FF4001975
      F5003585F6000F6FF50000000000000000000000000026AA50002AC35C0036D5
      7A00BAEFCC00BAEFCB0055DC92008FF4E40060EDD4009BE8B600BBEFCC00BBEF
      CD0026AB510026A84F0021843D00000000000000000020D2890020D2890020D2
      890020D2890020D2890020D28900FFFFFF00FFFFFF0020D2890020D2890020D2
      890020D2890020D2890089EEBC00000000000000000000000000000000000000
      000000000000000000001ED38A001ED38A001ED38A001ED38A00000000000000
      00000000000000000000000000000000000000000000000000000F6FF5001E78
      F5002F82F5000F6FF400418DF6003686F600D7E7FD001B76F5000F6FF4001874
      F5003787F6000F6FF40000000000000000000000000026AB50002AC65E003AD7
      820053E4B400FFFFFF00F2FEFC00FFFFFF00FFFFFF0050E5B500FFFFFF002AC8
      5F0027AE520026A95000207C39000000000000000000B2F9D0001FD48A001FD4
      8A001FD48A001FD48A001FD48A00FFFFFF00FFFFFF001FD48A001FD48A001FD4
      8A001FD48A001FD48A001ED38A00000000000000000000000000000000000000
      000000000000000000001ED58D001ED58D001ED58D001ED58D00000000000000
      00000000000000000000000000000000000000000000000000000F6FF4001C76
      F5003284F6000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4001774
      F4003988F6000F6FF40000000000000000000000000025A64E0029C45D0037D6
      7C00A8EBBF00FFFFFF00B5F7ED00FFFFFF00FFFFFF0042D88800FFFFFF0025C9
      600027AD520025A34D001E7033000000000000000000FCFEFD001DD68E001DD6
      8E001DD68E001DD68E001DD68E00FFFFFF00FFFFFF001DD68E001DD68E001DD6
      8E001DD68E00B8FBD30000000000000000000000000000000000000000000000
      000000000000000000001BD78E001BD78E001BD78E001BD78E00000000000000
      00000000000000000000000000000000000000000000000000000F6FF4001A75
      F5003485F6000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4000F6FF4001573
      F4003B89F6000F6FF4000000000000000000000000000000000028BB590030D1
      6C0042DC930053E5B6005CECCD00FFFFFF00FFFFFF0044DC980032D2700029BF
      5A0026AB500023904300000000000000000000000000000000001CD890001CD8
      90001CD890001CD890001CD890001CD890001CD890001CD890001CD890001CD8
      900093F2C4000000000000000000000000000000000000000000000000000000
      000000000000000000001BD990001BD990001BD990001BD99000000000000000
      00000000000000000000000000000000000000000000DCDCF800201DCE002B28
      D0003E3CD5001815CD001714CC001614CC001614CC001714CC001815CD002724
      D0004D4AD8001916CD000000000000000000000000000000000077CC93002AC6
      5D0034D3730040DA8E0047DF9E0048DFA00041DB910035D477002AC85F0028B3
      5400259F4B00FDFEFD0000000000000000000000000000000000000000007BE8
      BF00B3F9D1001BD992001BD992001BD992001BD992001BD992001AD992008BF0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000019DA930019DA930019DA930017D99200000000000000
      0000000000000000000000000000000000000000000000000000DCD5D600FFFF
      FF00F4F1F100FFFFFF00E9E4E500ADA3A500EDE9EB00D3CCCE00FFFFFF00ACA3
      A400FDFCFC00D8D0D3000000000000000000000000000000000000000000D9F1
      DF0029C35C002DCF650032D2710033D271002DCF66002AC55E0028B5560025A1
      4C00000000000000000000000000000000000000000000000000000000000000
      00000000000065E5B60016D89000A0F5C9007FEEBA0017D99100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000079EDB9003BE1A0003AE1A000C9F6E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DBD4D700E4DDDF0000000000F8F6F600FBFA
      FA00FAF7F8000000000000000000000000000000000000000000000000000000
      0000000000005CC67F0028BC580028BC590027B5560026AB5100A1D5B1000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F81F3FFFFFFF0000E0071FFFF81F0000
      C0030FFFE00F0000800187FFC30700008001C20FC7E300000000E00389730000
      0000F0619C3100000000F1F1983100000000F3F89C1100000000F3FC8E310000
      0000F3FC8EC300008000F3F8C7C300008001F1F8E0070000C001F0F1F00F0000
      E007F803F87F0000F00FFC07F9FF00008001FC07C003FFFF8001F00180018001
      87E1E0008001800183C1E001C00180018181C003C0038001C0038001C003BFFF
      E00780018001801FF00F80018001801FF81F80018001801FF00F80018001801F
      E00780018001BFFFC0038001C00180078181C003C003800783C1C003E0078007
      87E1E00FF00F8007CFF3F81FFC3FBFFF80018001E003FC0780018001E003F001
      E00FFC3FE007E000C007FC3FE007E0018003FC3FE007C0038001FC3FE0078001
      8001C003E003800100010001C003800100010001C003800100010001C0038001
      8001FC3FC00380018001FC3FC00380018003FC3FC003C003C007FC3F8003C003
      E00FFC3FC003E00FF83FFC3FFE47F81F00000000000000000000000000000000
      000000000000}
  end
  object AdvMainMenu1: TAdvMainMenu
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 184
    Top = 112
    object N17: TMenuItem
      Caption = '������'
      object N19: TMenuItem
        Caption = '���������'
      end
      object N20: TMenuItem
        Caption = '������������'
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object N22: TMenuItem
        Caption = '�������'
      end
      object N23: TMenuItem
        Caption = '������� ���'
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = '�����'
      end
    end
    object N18: TMenuItem
      Caption = '��������'
      object N26: TMenuItem
        Caption = '�������� '
      end
      object N29: TMenuItem
        Caption = '��������� �����'
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object N27: TMenuItem
        Caption = '���������� ��������'
      end
    end
    object N1: TMenuItem
      Caption = '?'
    end
  end
  object mnuCtrl: TAdvPopupMenu
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 56
    Top = 24
    object miStopSAll: TMenuItem
      Caption = '���������� ��� ������ ������'
      OnClick = miStopSAllClick
    end
  end
  object AdvMainMenu2: TAdvMainMenu
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 40
    Top = 192
    object N14: TMenuItem
      Caption = '������'
    end
    object N16: TMenuItem
      Caption = '��������'
    end
  end
  object qgMenu: TAdvPopupMenu
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 467
    Top = 96
    object MenuItem14: TMenuItem
      Caption = '������� ������(�)'
      ImageIndex = 7
      OnClick = OnDelIAbonItem
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object nClearAbons: TMenuItem
      Caption = '����� ���������'
      OnClick = nClearAbonsClick
    end
    object N33: TMenuItem
      Caption = '�������� ����������'
      OnClick = N33Click
    end
    object nSetAbons: TMenuItem
      Caption = '�������� ���'
      OnClick = nSetAbonsClick
    end
    object N32: TMenuItem
      Caption = '-'
    end
    object setNullStateQuality: TMenuItem
      Caption = '�������� ��������� ��������'
      OnClick = setNullStateQualityClick
    end
    object setNullState: TMenuItem
      Caption = '�������� ���������'
      OnClick = setNullStateClick
    end
  end
  object pmMnuStat: TAdvPopupMenu
    OnPopup = pmMnuStatPopup
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 289
    Top = 37
    object itAllGroup: TMenuItem
      Caption = '�� ���� ������'
      ImageIndex = 0
      OnClick = itAllGroupClick
    end
    object itElement: TMenuItem
      Caption = '�� ���������'
      ImageIndex = 0
      OnClick = itElementClick
    end
  end
  object advSort: TAdvPopupMenu
    MenuStyler = AdvMenuOfficeStyler1
    Version = '2.5.2.4'
    Left = 417
    Top = 37
    object nameItem: TMenuItem
      Caption = '��������'
      Checked = True
      Hint = 'townNM,streetNM,aboNM'
      ImageIndex = 0
      OnClick = nameItemClick
    end
    object beginItem: TMenuItem
      Caption = '������'
      Hint = 'DTBEGINH'
      ImageIndex = 0
      OnClick = nameItemClick
    end
    object TypeItem: TMenuItem
      Caption = '��� ��������'
      Hint = 'SBYTYPE'
      OnClick = nameItemClick
    end
    object endItem: TMenuItem
      Caption = '����������'
      Hint = 'DTENDH'
      OnClick = nameItemClick
    end
    object allItem: TMenuItem
      Caption = '�����'
      Hint = 'ALLCOUNTER'
      OnClick = nameItemClick
    end
    object isokItem: TMenuItem
      Caption = '��������'
      Hint = 'ISOK'
      OnClick = nameItemClick
    end
    object iserItem: TMenuItem
      Caption = '�� ��������'
      Hint = 'ISER'
      OnClick = nameItemClick
    end
    object enable: TMenuItem
      Caption = '����������'
      Hint = 'ENABLE'
      OnClick = nameItemClick
    end
    object stateItem: TMenuItem
      Caption = '���������'
      Hint = 'STATE'
      OnClick = nameItemClick
    end
  end
end
