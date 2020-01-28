object Meter_Replace: TMeter_Replace
  Left = 347
  Top = 345
  BorderStyle = bsSingle
  Caption = 'Замена счетчика'
  ClientHeight = 119
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 504
    Height = 119
    Align = alClient
    Color = 13616833
    TabOrder = 0
    object Progress_Meter_Replace: TAdvProgressBar
      Left = 1
      Top = 98
      Width = 502
      Height = 20
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      Level0ColorTo = 14811105
      Level1Color = clLime
      Level1ColorTo = 14811105
      Level2Color = clLime
      Level2ColorTo = 14811105
      Level3Color = clLime
      Level3ColorTo = 14811105
      Level1Perc = 70
      Level2Perc = 90
      Position = 0
      ShowBorder = True
      Version = '1.2.0.0'
    end
    object GradientLabel3: TGradientLabel
      Left = 0
      Top = 9
      Width = 698
      Height = 17
      AutoSize = False
      Caption = 'Параметры импорта'
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
    object Label7: TLabel
      Left = 17
      Top = 42
      Width = 70
      Height = 15
      Caption = 'Пулл портов:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object GradientLabel1: TGradientLabel
      Left = 0
      Top = 73
      Width = 698
      Height = 17
      AutoSize = False
      Caption = 'Процесс замены'
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
    object cmbPull: TComboBox
      Left = -1
      Top = 55
      Width = 155
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object importHouse: TAdvSmoothButton
      Left = 128
      Top = 30
      Width = 235
      Height = 41
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWindowText
      Appearance.Font.Height = -11
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BackGroundPictureLeft = 0
      Status.Appearance.Fill.BackGroundPictureTop = 0
      Status.Appearance.Fill.PictureLeft = 0
      Status.Appearance.Fill.PictureTop = 0
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Angle = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Caption = 'Выбрать файл'
      Color = 7237229
      TabOrder = 1
      Version = '1.5.0.1'
      OnClick = ReplaceHouseClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 584
    Top = 24
  end
end
