object ConnForm: TConnForm
  Left = 510
  Top = 384
  Width = 332
  Height = 201
  BorderIcons = [biSystemMenu]
  Caption = 'Соединение'
  Color = clBtnFace
  Constraints.MaxHeight = 201
  Constraints.MaxWidth = 332
  Constraints.MinHeight = 201
  Constraints.MinWidth = 332
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = OnCreateForm
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 324
    Height = 167
    Align = alClient
    BevelOuter = bvNone
    Color = 16640730
    TabOrder = 0
    UseDockManager = True
    Version = '1.7.9.0'
    BorderColor = clGray
    Caption.Color = 14059353
    Caption.ColorTo = 9648131
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
    ColorTo = 14986888
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWhite
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 14716773
    StatusBar.ColorTo = 16374724
    StatusBar.GradientDirection = gdVertical
    Styler = nConnStyler1
    FullHeight = 0
    object Label3: TLabel
      Left = 6
      Top = 57
      Width = 87
      Height = 17
      Caption = 'Подключение'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 6
      Top = 87
      Width = 87
      Height = 17
      Caption = 'Пользователь'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 6
      Top = 115
      Width = 46
      Height = 17
      Caption = 'Пароль'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object cbConnectionStr: TComboBox
      Left = 124
      Top = 54
      Width = 197
      Height = 23
      Color = clWhite
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
      OnChange = OnComboChandge
    end
    object edUser: TEdit
      Left = 125
      Top = 83
      Width = 196
      Height = 23
      Color = clWhite
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      TabOrder = 1
    end
    object edPassword: TEdit
      Left = 125
      Top = 112
      Width = 157
      Height = 23
      Color = clWhite
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 2
      OnKeyPress = OnKeyPress
    end
    object RbButton1: TRbButton
      Left = 284
      Top = 112
      Width = 36
      Height = 24
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      OnClick = OnSetPassw
      TabOrder = 3
      TextShadow = True
      Caption = 'Да'
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
    object AdvPanel16: TAdvPanel
      Left = 0
      Top = 141
      Width = 324
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Color = 16640730
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UseDockManager = True
      Version = '1.7.9.0'
      BorderColor = clGray
      Caption.Color = 14059353
      Caption.ColorTo = 9648131
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
      ColorTo = 14986888
      Ellipsis = True
      ShadowColor = clBlack
      ShadowOffset = 0
      StatusBar.BorderColor = clNone
      StatusBar.BorderStyle = bsSingle
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWhite
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      StatusBar.Color = 14716773
      StatusBar.ColorTo = 16374724
      StatusBar.GradientDirection = gdVertical
      Styler = nConnStyler1
      FullHeight = 60
      object lbCurrUser: TLabel
        Left = 386
        Top = 6
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object lbScheduler: TLabel
        Left = 386
        Top = 19
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object lbSchedTime: TLabel
        Left = 386
        Top = 31
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object lbSetTmState: TLabel
        Left = 386
        Top = 44
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object lbUserInfo: TLabel
        Left = 606
        Top = 5
        Width = 96
        Height = 19
        Anchors = []
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object lbProName: TLabel
        Left = 1110
        Top = 1
        Width = 81
        Height = 15
        Anchors = [akRight]
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label21: TLabel
        Left = 1091
        Top = -7
        Width = 100
        Height = 14
        Anchors = [akRight, akBottom]
        Caption = 'http::\\www.a2000.by'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 194
        Top = 7
        Width = 127
        Height = 14
        Caption = 'ООО Автоматизация 2000'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clTeal
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object AdvPanel2: TAdvPanel
      Left = 0
      Top = 0
      Width = 324
      Height = 51
      Align = alTop
      BevelOuter = bvNone
      Color = 16640730
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
      Caption.Color = 14059353
      Caption.ColorTo = 9648131
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
      ColorTo = 14986888
      Ellipsis = True
      ShadowColor = clBlack
      ShadowOffset = 0
      StatusBar.BorderColor = clNone
      StatusBar.BorderStyle = bsSingle
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWhite
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      StatusBar.Color = 14716773
      StatusBar.ColorTo = 16374724
      StatusBar.GradientDirection = gdVertical
      Styler = nConnStyler1
      FullHeight = 60
      object Label2: TLabel
        Left = 386
        Top = 6
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 386
        Top = 19
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 386
        Top = 31
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 386
        Top = 44
        Width = 69
        Height = 14
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 606
        Top = 18
        Width = 96
        Height = 19
        Anchors = []
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 1110
        Top = 8
        Width = 81
        Height = 15
        Anchors = [akRight]
        Caption = 'Automation 2k'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 1091
        Top = 18
        Width = 100
        Height = 14
        Anchors = [akRight, akBottom]
        Caption = 'http::\\www.a2000.by'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
      end
      object lbConnnInfo: TLabel
        Left = 121
        Top = 22
        Width = 80
        Height = 17
        Caption = 'Авторизация'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 2
        Top = 3
        Width = 127
        Height = 14
        Caption = 'ООО Автоматизация 2000'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clTeal
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
  end
  object nConnStyler1: TAdvPanelStyler
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
    Settings.Caption.Color = 14059353
    Settings.Caption.ColorTo = 9648131
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
    Settings.Color = 16640730
    Settings.ColorTo = 14986888
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
    Settings.StatusBar.Font.Color = clWhite
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 14716773
    Settings.StatusBar.ColorTo = 16374724
    Settings.StatusBar.GradientDirection = gdVertical
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Style = psOffice2003Blue
    Left = 48
    Top = 80
  end
  object nConnStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2003Blue
    Left = 48
    Top = 24
  end
end
