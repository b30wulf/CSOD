object LightControlForm: TLightControlForm
  Left = 267
  Top = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Управление освещением'
  ClientHeight = 274
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 274
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
    Styler = AdvPanelStyler1
    FullHeight = 0
    object gLite1: TGroupBox
      Left = 8
      Top = 8
      Width = 169
      Height = 217
      Caption = 'Дежурное освещение'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 72
        Top = 38
        Width = 6
        Height = 20
        Caption = ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 72
        Top = 96
        Width = 6
        Height = 20
        Caption = ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 14
        Top = 72
        Width = 113
        Height = 20
        Caption = 'Выключение:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 14
        Top = 16
        Width = 101
        Height = 20
        Caption = 'Включение:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object seDLightOnH: TSpinEdit
        Left = 14
        Top = 38
        Width = 50
        Height = 26
        MaxValue = 23
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object seDLightOnM: TSpinEdit
        Left = 88
        Top = 38
        Width = 50
        Height = 26
        MaxValue = 59
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object seDLightOffH: TSpinEdit
        Left = 14
        Top = 96
        Width = 50
        Height = 26
        MaxValue = 23
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object seDLightOffM: TSpinEdit
        Left = 88
        Top = 96
        Width = 50
        Height = 26
        MaxValue = 59
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object chAutoDLight: TCheckBox
        Left = 16
        Top = 128
        Width = 137
        Height = 17
        Caption = 'Автоматически'
        TabOrder = 4
      end
      object swDezur: TCheckBox
        Left = 16
        Top = 152
        Width = 97
        Height = 17
        Caption = 'Вкл/Выкл'
        TabOrder = 5
      end
    end
    object gLite2: TGroupBox
      Left = 184
      Top = 8
      Width = 169
      Height = 217
      Caption = 'Рабочее освещение 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label5: TLabel
        Left = 72
        Top = 38
        Width = 6
        Height = 20
        Caption = ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 72
        Top = 96
        Width = 6
        Height = 20
        Caption = ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 14
        Top = 72
        Width = 113
        Height = 20
        Caption = 'Выключение:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 14
        Top = 16
        Width = 101
        Height = 20
        Caption = 'Включение:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object seR1LightOnH: TSpinEdit
        Left = 14
        Top = 38
        Width = 50
        Height = 26
        MaxValue = 23
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object seR1LightOnM: TSpinEdit
        Left = 88
        Top = 38
        Width = 50
        Height = 26
        MaxValue = 59
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object seR1LightOffH: TSpinEdit
        Left = 14
        Top = 96
        Width = 50
        Height = 26
        MaxValue = 23
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object seR1LightOffM: TSpinEdit
        Left = 88
        Top = 96
        Width = 50
        Height = 26
        MaxValue = 59
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object chAutoR1Light: TCheckBox
        Left = 16
        Top = 128
        Width = 145
        Height = 17
        Caption = 'Автоматически'
        TabOrder = 4
      end
      object swRab: TCheckBox
        Left = 16
        Top = 152
        Width = 97
        Height = 17
        Caption = 'Вкл/Выкл'
        TabOrder = 5
      end
    end
    object gLite3: TGroupBox
      Left = 360
      Top = 8
      Width = 169
      Height = 217
      Caption = 'Рабочее освещение 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label9: TLabel
        Left = 72
        Top = 38
        Width = 6
        Height = 20
        Caption = ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 72
        Top = 96
        Width = 6
        Height = 20
        Caption = ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 14
        Top = 72
        Width = 113
        Height = 20
        Caption = 'Выключение:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 14
        Top = 16
        Width = 101
        Height = 20
        Caption = 'Включение:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object seR2LightOnH: TSpinEdit
        Left = 14
        Top = 38
        Width = 50
        Height = 26
        MaxValue = 23
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object seR2LightOnM: TSpinEdit
        Left = 88
        Top = 38
        Width = 50
        Height = 26
        MaxValue = 59
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object seR2LightOffH: TSpinEdit
        Left = 14
        Top = 96
        Width = 50
        Height = 26
        MaxValue = 23
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object seR2LightOffM: TSpinEdit
        Left = 88
        Top = 96
        Width = 50
        Height = 26
        MaxValue = 59
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
    end
    object btnApplyChange: TAdvGlowButton
      Left = 40
      Top = 232
      Width = 113
      Height = 33
      Caption = 'Применить'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 3
      OnClick = btnSetTimeClick
      Appearance.BorderColor = 14727579
      Appearance.BorderColorHot = 10079963
      Appearance.BorderColorDown = 4548219
      Appearance.Color = 15653832
      Appearance.ColorTo = 16178633
      Appearance.ColorChecked = 11918331
      Appearance.ColorCheckedTo = 7915518
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 7778289
      Appearance.ColorDownTo = 4296947
      Appearance.ColorHot = 15465983
      Appearance.ColorHotTo = 11332863
      Appearance.ColorMirror = 15586496
      Appearance.ColorMirrorTo = 16245200
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
    object btnCloseForm: TAdvGlowButton
      Left = 376
      Top = 232
      Width = 113
      Height = 33
      Caption = 'Отмена'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 4
      OnClick = btnCloseFormClick
      Appearance.BorderColor = 14727579
      Appearance.BorderColorHot = 10079963
      Appearance.BorderColorDown = 4548219
      Appearance.Color = 15653832
      Appearance.ColorTo = 16178633
      Appearance.ColorChecked = 11918331
      Appearance.ColorCheckedTo = 7915518
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 7778289
      Appearance.ColorDownTo = 4296947
      Appearance.ColorHot = 15465983
      Appearance.ColorHotTo = 11332863
      Appearance.ColorMirror = 15586496
      Appearance.ColorMirrorTo = 16245200
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
    Left = 264
    Top = 208
  end
  object LightStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2003Blue
    Left = 378
    Top = 387
  end
end
