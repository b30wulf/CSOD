object TUserManager: TTUserManager
  Left = 1203
  Top = 397
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Авторизация'
  ClientHeight = 143
  ClientWidth = 291
  Color = clBtnFace
  Constraints.MaxHeight = 177
  Constraints.MaxWidth = 299
  Constraints.MinHeight = 175
  Constraints.MinWidth = 299
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = OnCreateForm
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 3
    Top = 2
    Width = 139
    Height = 14
    Caption = 'ООО Автоматизация 2000'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 0
    Width = 291
    Height = 143
    Align = alClient
    BevelOuter = bvNone
    Color = 16640730
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
      Left = 539
      Top = 67
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
    object Label3: TLabel
      Left = 1077
      Top = 36
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
    object Label6: TLabel
      Left = 1058
      Top = 110
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
    object Label14: TLabel
      Left = 2
      Top = 3
      Width = 139
      Height = 14
      Caption = 'ООО Автоматизация 2000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 6
      Top = 61
      Width = 83
      Height = 16
      Caption = 'Пользователь'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 6
      Top = 86
      Width = 43
      Height = 16
      Caption = 'Пароль'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edUser: TEdit
      Left = 96
      Top = 59
      Width = 184
      Height = 21
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edPassword: TEdit
      Left = 96
      Top = 84
      Width = 116
      Height = 21
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
      OnKeyPress = OnPressKey1
    end
    object RbButton1: TRbButton
      Left = 215
      Top = 84
      Width = 66
      Height = 23
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = OnCheckPass
      TabOrder = 2
      TextShadow = True
      Caption = 'Применить'
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
    object AdvPanel1: TAdvPanel
      Left = 0
      Top = 120
      Width = 291
      Height = 23
      Align = alBottom
      BevelOuter = bvNone
      Color = 16640730
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
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
      object Label11: TLabel
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
      object Label12: TLabel
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
      object Label13: TLabel
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
      object Label15: TLabel
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
      object Label16: TLabel
        Left = 606
        Top = 3
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
      object Label17: TLabel
        Left = 1110
        Top = 0
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
      object Label18: TLabel
        Left = 1091
        Top = -10
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
    end
    object AdvPanel3: TAdvPanel
      Left = 0
      Top = 0
      Width = 291
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
      object Label20: TLabel
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
      object Label21: TLabel
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
      object Label22: TLabel
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
      object Label23: TLabel
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
      object Label24: TLabel
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
      object Label25: TLabel
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
      object Label26: TLabel
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
      object lbCaption: TLabel
        Left = 91
        Top = 16
        Width = 95
        Height = 19
        Caption = 'Авторизация'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clTeal
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
  end
  object ibList1: TibList
    Port = 1
    PortType = 0
    Left = 40
    Top = 56
  end
  object nConnStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2003Blue
    Left = 48
    Top = 24
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
end
