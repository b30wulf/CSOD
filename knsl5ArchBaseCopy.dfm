object ArchBaseCopy: TArchBaseCopy
  Left = 678
  Top = 160
  Width = 517
  Height = 444
  Caption = '–едактор архивации базы данных'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object mMySQLECmpl: TLabel
    Left = 108
    Top = 163
    Width = 36
    Height = 15
    Caption = 'xx:xx:xx'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object mMySQLENext: TLabel
    Left = 108
    Top = 185
    Width = 36
    Height = 15
    Caption = 'xx:xx:xx'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label47: TLabel
    Left = 2
    Top = 185
    Width = 106
    Height = 15
    Caption = '—ледующий экс.в : '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label48: TLabel
    Left = 2
    Top = 163
    Width = 95
    Height = 15
    Caption = 'Ёкс.завершен в : '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label51: TLabel
    Left = 2
    Top = 75
    Width = 79
    Height = 15
    Caption = 'јрхиваци€ из '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label56: TLabel
    Left = 252
    Top = 49
    Width = 48
    Height = 15
    Caption = 'ѕериод: '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object GradientLabel3: TGradientLabel
    Left = 2
    Top = 28
    Width = 391
    Height = 17
    AutoSize = False
    Caption = '—осто€ние архивации базы'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
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
  object Label25: TLabel
    Left = 95
    Top = 124
    Width = 3
    Height = 15
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label50: TLabel
    Left = 3
    Top = 51
    Width = 76
    Height = 15
    Caption = '–азрешение : '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label84: TLabel
    Left = 2
    Top = 99
    Width = 70
    Height = 15
    Caption = 'јрхиваци€ в'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label85: TLabel
    Left = 134
    Top = 49
    Width = 41
    Height = 15
    Caption = 'Ќачало'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object GradientLabel5: TGradientLabel
    Left = 3
    Top = 207
    Width = 286
    Height = 26
    AutoSize = False
    Caption = 'Ћогирование архивации'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
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
  object Label1: TLabel
    Left = 0
    Top = 124
    Width = 256
    Height = 13
    Caption = 'ќчищать мес€чные данные в базе данных старше'
  end
  object Label2: TLabel
    Left = 0
    Top = 148
    Width = 252
    Height = 13
    Caption = 'ќчищать суточные данные в базе данных старше'
  end
  object AdvPanel9: TAdvPanel
    Left = 0
    Top = 0
    Width = 509
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
    FullHeight = 0
    object AdvToolBar8: TAdvToolBar
      Left = 0
      Top = -1
      Width = 415
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
      ParentStyler = False
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object AdvGlowMenuButton19: TAdvGlowMenuButton
        Left = 9
        Top = 2
        Width = 111
        Height = 25
        Caption = 'ƒанные'
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
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        DropDownButton = True
        DropDownMenu = pmExportBase
      end
      object AdvGlowMenuButton20: TAdvGlowMenuButton
        Left = 290
        Top = 2
        Width = 111
        Height = 25
        Caption = '”правление'
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
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        DropDownButton = True
        DropDownMenu = pmExportBaseCntrl
      end
      object AdvGlowMenuButton21: TAdvGlowMenuButton
        Left = 120
        Top = 2
        Width = 170
        Height = 25
        Caption = 'Ёкспорт/јрхирование'
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
        TabOrder = 2
        OnClick = AdvGlowMenuButton21Click
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        DropDownButton = True
        DropDownMenu = pmExportBaseExp
      end
    end
  end
  object mMySQLStat: TMemo
    Left = 0
    Top = 237
    Width = 505
    Height = 172
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object edm_sArchPath: TEdit
    Left = 82
    Top = 96
    Width = 296
    Height = 22
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object cbm_byEnableArchiv: TComboBox
    Left = 82
    Top = 48
    Width = 51
    Height = 20
    Style = csOwnerDrawFixed
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 3
    Items.Strings = (
      'Ќет'
      'ƒа')
  end
  object cbm_tmArchPeriod: TComboBox
    Left = 305
    Top = 47
    Width = 89
    Height = 20
    Style = csOwnerDrawFixed
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      'ежедневно'
      '1 раз в мес€ц'
      '2 раза в мес€ц'
      '3 раза в мес€ц'
      '4 раза в мес€ц'
      '5 раз в мес€ц'
      '6 раз в мес€ц'
      '7 раз в мес€ц'
      '8 раз в мес€ц'
      '9 раз в мес€ц'
      '10 раз в мес€ц')
  end
  object edm_sSrcPath: TEdit
    Left = 82
    Top = 72
    Width = 296
    Height = 22
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object RbButton5: TRbButton
    Left = 378
    Top = 72
    Width = 15
    Height = 22
    Enabled = False
    OnClick = RbButton5Click
    TabOrder = 6
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
  object RbButton4: TRbButton
    Left = 378
    Top = 96
    Width = 15
    Height = 22
    Enabled = False
    OnClick = RbButton4Click
    TabOrder = 7
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
  object tmm_dtEnterArchTime: TDateTimePicker
    Left = 177
    Top = 47
    Width = 73
    Height = 23
    CalAlignment = dtaLeft
    Date = 40739.4647639699
    Time = 40739.4647639699
    DateFormat = dfShort
    DateMode = dmComboBox
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    Kind = dtkTime
    ParseInput = False
    ParentFont = False
    TabOrder = 8
  end
  object cbbStoragePeriodM: TComboBox
    Left = 264
    Top = 120
    Width = 129
    Height = 21
    Enabled = False
    ItemHeight = 13
    TabOrder = 9
    Text = 'cbbStoragePeriodM'
  end
  object cbbStoragePeriodD: TComboBox
    Left = 264
    Top = 144
    Width = 129
    Height = 21
    Enabled = False
    ItemHeight = 13
    TabOrder = 10
    Text = 'cbbStoragePeriodD'
  end
  object pmExportBase: TAdvPopupMenu
    Version = '2.5.2.4'
    Left = 8
    object miDBFSave: TMenuItem
      Caption = '—охранить параметры'
      OnClick = miDBFSaveClick
    end
    object miDBFRead: TMenuItem
      Caption = 'ѕрочитать параметры'
      OnClick = miDBFReadClick
    end
  end
  object pmExportBaseExp: TAdvPopupMenu
    Version = '2.5.2.4'
    Left = 120
    object miHandExport: TMenuItem
      Caption = 'Ёкспортировать данные'
      ImageIndex = 25
      OnClick = miHandExportClick
    end
  end
  object pmExportBaseCntrl: TAdvPopupMenu
    Version = '2.5.2.4'
    Left = 344
    object N1: TMenuItem
      Caption = '–едактирование'
      OnClick = N1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object miOnSetDBF: TMenuItem
      Caption = 'ѕрименить'
      OnClick = miOnSetDBFClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 456
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    Left = 456
    Top = 96
  end
end
