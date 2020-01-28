object TDataFinder: TTDataFinder
  Left = 412
  Top = 199
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Данные за отчетный период'
  ClientHeight = 430
  ClientWidth = 728
  Color = clBtnFace
  Constraints.MaxHeight = 464
  Constraints.MaxWidth = 736
  Constraints.MinHeight = 464
  Constraints.MinWidth = 736
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = OnFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 0
    Width = 728
    Height = 430
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
    FullHeight = 0
    object GradientLabel1: TGradientLabel
      Left = 4
      Top = 45
      Width = 719
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Перечень загружаемых данных'
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
    object cbm_nArchEN111: TGradientLabel
      Left = 30
      Top = 94
      Width = 317
      Height = 17
      AutoSize = False
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
    object GradientLabel2: TGradientLabel
      Left = 366
      Top = 94
      Width = 331
      Height = 17
      AutoSize = False
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
    object GradientLabel3: TGradientLabel
      Left = 142
      Top = 69
      Width = 101
      Height = 17
      AutoSize = False
      Caption = 'Период загрузки'
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
    object Label1: TLabel
      Left = 350
      Top = 70
      Width = 12
      Height = 15
      Caption = 'по'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 246
      Top = 69
      Width = 5
      Height = 15
      Caption = 'с'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object GradientLabel4: TGradientLabel
      Left = 30
      Top = 221
      Width = 318
      Height = 17
      AutoSize = False
      Caption = '     '
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
    object GradientLabel5: TGradientLabel
      Left = 366
      Top = 277
      Width = 331
      Height = 17
      AutoSize = False
      Caption = 'Общие'
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
    object GradientLabel6: TGradientLabel
      Left = 366
      Top = 116
      Width = 331
      Height = 17
      AutoSize = False
      Caption = '       '
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
    object ewew: TGradientLabel
      Left = 366
      Top = 159
      Width = 331
      Height = 17
      AutoSize = False
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
    object AdvPanel1: TAdvPanel
      Left = 0
      Top = 0
      Width = 728
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
      FullHeight = 0
      object Label2: TLabel
        Left = 593
        Top = 2
        Width = 127
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'ООО Автоматизация 2000'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clTeal
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 229
        Top = 12
        Width = 266
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Загрузка отсутствующих данных'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object AdvToolBar1: TAdvToolBar
        Left = 0
        Top = 0
        Width = 176
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
        object bClearEv: TAdvToolBarButton
          Left = 2
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Очистка '
          Appearance.CaptionFont.Charset = DEFAULT_CHARSET
          Appearance.CaptionFont.Color = clWindowText
          Appearance.CaptionFont.Height = -11
          Appearance.CaptionFont.Name = 'Tahoma'
          Appearance.CaptionFont.Style = []
          Caption = 'Очистить'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImageIndex = 0
          ParentFont = False
          Position = daTop
          Version = '3.1.6.0'
          Visible = False
          OnClick = bClearEvClick
        end
        object bEnablEv: TAdvToolBarButton
          Left = 82
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Запуск'
          Appearance.CaptionFont.Charset = DEFAULT_CHARSET
          Appearance.CaptionFont.Color = clWindowText
          Appearance.CaptionFont.Height = -11
          Appearance.CaptionFont.Name = 'Segoe UI'
          Appearance.CaptionFont.Style = []
          Caption = 'Запуск'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImageIndex = 2
          ParentFont = False
          Position = daTop
          Version = '3.1.6.0'
          OnClick = bEnablEvClick
        end
        object bDisablEv: TAdvToolBarButton
          Left = 122
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Стоп'
          Appearance.CaptionFont.Charset = DEFAULT_CHARSET
          Appearance.CaptionFont.Color = clWindowText
          Appearance.CaptionFont.Height = -11
          Appearance.CaptionFont.Name = 'Segoe UI'
          Appearance.CaptionFont.Style = []
          Caption = 'Стоп'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImageIndex = 3
          ParentFont = False
          Position = daTop
          Version = '3.1.6.0'
          OnClick = bDisablEvClick
        end
        object AdvToolBarButton1: TAdvToolBarButton
          Left = 42
          Top = 2
          Width = 40
          Height = 40
          Hint = 'Выполнить поиск'
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
          ImageIndex = 4
          ParentFont = False
          Position = daTop
          Version = '3.1.6.0'
          Visible = False
          OnClick = OnFindHoles
        end
      end
    end
    object dtETime: TDateTimePicker
      Left = 259
      Top = 67
      Width = 89
      Height = 22
      Hint = 'Используется для выбора периода'
      BiDiMode = bdRightToLeft
      CalAlignment = dtaRight
      Date = 40300.7711754861
      Time = 40300.7711754861
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowFrame
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentBiDiMode = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object dtFTime: TDateTimePicker
      Left = 365
      Top = 67
      Width = 89
      Height = 22
      Hint = 'Используется для выбора периода'
      BiDiMode = bdRightToLeft
      CalAlignment = dtaRight
      Date = 40300.7711754861
      Time = 40300.7711754861
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowFrame
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentBiDiMode = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbm_nPar6: TAdvOfficeCheckBox
      Left = 370
      Top = 92
      Width = 239
      Height = 20
      Alignment = taLeftJustify
      Caption = '3.Учет тепловой энергии(архивы)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 3
      Version = '1.1.1.4'
    end
    object advStatus: TAdvOfficeStatusBar
      Left = 0
      Top = 411
      Width = 728
      Height = 19
      AnchorHint = False
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'dd.MM.yyyy'
          MinWidth = 100
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
          Text = 'Загрузка данных'
          TimeFormat = 'h:mm:ss'
          Width = 200
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'dd.MM.yyyy'
          MinWidth = 100
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
          Text = 'Период'
          TimeFormat = 'h:mm:ss'
          Width = 200
        end
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
          Text = 'Выполнено'
          TimeFormat = 'h:mm:ss'
          Width = 566
        end>
      SimplePanel = False
      URLColor = clBlue
      Styler = AdvOfficeStatusBarOfficeStyler1
      Version = '1.2.0.6'
    end
    object cbm_nPriDay: TAdvOfficeCheckBox
      Left = 49
      Top = 114
      Width = 251
      Height = 20
      Alignment = taLeftJustify
      Caption = '1.1 Приращение энергии за день'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 5
      Version = '1.1.1.4'
    end
    object cbm_nPriMonth: TAdvOfficeCheckBox
      Left = 49
      Top = 134
      Width = 251
      Height = 20
      Alignment = taLeftJustify
      Caption = '2.1 Приращение энергии за месяц'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 6
      Version = '1.1.1.4'
    end
    object cbm_nPri30: TAdvOfficeCheckBox
      Left = 49
      Top = 154
      Width = 251
      Height = 20
      Alignment = taLeftJustify
      Caption = '3.1 Cрез 30 мин энергии '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 7
      Version = '1.1.1.4'
    end
    object cbm_nNakDay: TAdvOfficeCheckBox
      Left = 49
      Top = 174
      Width = 251
      Height = 20
      Alignment = taLeftJustify
      Caption = '4.1 Энергия на начало суток'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 8
      Version = '1.1.1.4'
    end
    object cbm_nNakMonth: TAdvOfficeCheckBox
      Left = 49
      Top = 194
      Width = 251
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.1 Энергия на начало месяца'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 9
      Version = '1.1.1.4'
    end
    object cbAllAbon: TAdvOfficeCheckBox
      Left = 374
      Top = 298
      Width = 201
      Height = 20
      Alignment = taLeftJustify
      Caption = 'Применить для всех абонентов'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 10
      Version = '1.1.1.4'
    end
    object cbRecalc: TAdvOfficeCheckBox
      Left = 374
      Top = 335
      Width = 307
      Height = 20
      Alignment = taLeftJustify
      Caption = 'Перерасчет по окончанию загрузки'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 11
      Version = '1.1.1.4'
    end
    object cbm_byCurrent: TAdvOfficeCheckBox
      Left = 33
      Top = 219
      Width = 296
      Height = 20
      Alignment = taLeftJustify
      Caption = '2.Текущие параметры'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 12
      OnClick = OnClickCurr
      Version = '1.1.1.4'
    end
    object cbm_byCorrTM: TAdvOfficeCheckBox
      Left = 374
      Top = 316
      Width = 179
      Height = 20
      Alignment = taLeftJustify
      Caption = 'Коррекция времени'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 13
      Version = '1.1.1.4'
    end
    object cbm_bySumEn: TAdvOfficeCheckBox
      Left = 48
      Top = 243
      Width = 251
      Height = 19
      Alignment = taLeftJustify
      Caption = '2.1.Суммарная накопленная энергия'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 14
      Version = '1.1.1.4'
    end
    object cbm_byMAP: TAdvOfficeCheckBox
      Left = 48
      Top = 262
      Width = 251
      Height = 20
      Alignment = taLeftJustify
      Caption = '2.2.Мгновенная активная мощность'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 15
      Version = '1.1.1.4'
    end
    object cbm_byMRAP: TAdvOfficeCheckBox
      Left = 48
      Top = 281
      Width = 251
      Height = 19
      Alignment = taLeftJustify
      Caption = '2.3.Мгновенная реактивная мощность'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 16
      Version = '1.1.1.4'
    end
    object cbm_byU: TAdvOfficeCheckBox
      Left = 48
      Top = 299
      Width = 144
      Height = 19
      Alignment = taLeftJustify
      Caption = '2.4.Напряжение'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 17
      Version = '1.1.1.4'
    end
    object cbm_byI: TAdvOfficeCheckBox
      Left = 48
      Top = 318
      Width = 88
      Height = 19
      Alignment = taLeftJustify
      Caption = '2.5.Ток'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 18
      Version = '1.1.1.4'
    end
    object cbm_byJEn: TAdvOfficeCheckBox
      Left = 370
      Top = 114
      Width = 247
      Height = 21
      Alignment = taLeftJustify
      Caption = '4.События системы/устройства'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 19
      OnClick = OnClickEvents
      Version = '1.1.1.4'
    end
    object cbm_byJ0: TAdvOfficeCheckBox
      Left = 388
      Top = 136
      Width = 67
      Height = 20
      Alignment = taLeftJustify
      Caption = '4.1 №1'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 20
      Version = '1.1.1.4'
    end
    object cbm_byJ1: TAdvOfficeCheckBox
      Left = 450
      Top = 136
      Width = 67
      Height = 20
      Alignment = taLeftJustify
      Caption = '4.1 №2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 21
      Version = '1.1.1.4'
    end
    object cbm_byJ2: TAdvOfficeCheckBox
      Left = 513
      Top = 136
      Width = 67
      Height = 20
      Alignment = taLeftJustify
      Caption = '4.1 №3'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 22
      Version = '1.1.1.4'
    end
    object cbm_byJ3: TAdvOfficeCheckBox
      Left = 575
      Top = 136
      Width = 67
      Height = 20
      Alignment = taLeftJustify
      Caption = '4.1 №4'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 23
      Version = '1.1.1.4'
    end
    object cbm_byPNetEn: TAdvOfficeCheckBox
      Left = 370
      Top = 157
      Width = 175
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.Архивы параметров сети'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 24
      OnClick = OnClickANetEN
      Version = '1.1.1.4'
    end
    object cbm_byPNetU: TAdvOfficeCheckBox
      Left = 388
      Top = 178
      Width = 93
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.1 U(А,B,C)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 25
      Version = '1.1.1.4'
    end
    object cbm_byPNetI: TAdvOfficeCheckBox
      Left = 388
      Top = 197
      Width = 85
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.2 I(А,B,C)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 26
      Version = '1.1.1.4'
    end
    object cbm_byPNetFi: TAdvOfficeCheckBox
      Left = 388
      Top = 216
      Width = 93
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.3 Fi(А,B,C)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 27
      Version = '1.1.1.4'
    end
    object cbm_byPNetCosFi: TAdvOfficeCheckBox
      Left = 388
      Top = 235
      Width = 77
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.4 cos(fi)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 28
      Version = '1.1.1.4'
    end
    object cbm_nArchEN: TAdvOfficeCheckBox
      Left = 34
      Top = 92
      Width = 263
      Height = 20
      Alignment = taLeftJustify
      Caption = '1.Учет электрической энергии(архивы)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 29
      OnClick = OnClickAEN
      Version = '1.1.1.4'
    end
    object cbm_byPNetF: TAdvOfficeCheckBox
      Left = 388
      Top = 254
      Width = 67
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.5 F'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 30
      Version = '1.1.1.4'
    end
    object cbm_byPNetP: TAdvOfficeCheckBox
      Left = 514
      Top = 179
      Width = 111
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.6 P(А,B,C)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 31
      Version = '1.1.1.4'
    end
    object cbm_byPNetQ: TAdvOfficeCheckBox
      Left = 514
      Top = 198
      Width = 103
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.7 Q(А,B,C)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 32
      Version = '1.1.1.4'
    end
    object cbm_byMPNetEn: TAdvOfficeCheckBox
      Left = 538
      Top = 157
      Width = 159
      Height = 20
      Alignment = taLeftJustify
      Caption = '5.1.Архивы мониторинга'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 33
      OnClick = OnClickANetEN
      Version = '1.1.1.4'
    end
    object cbm_byFreq: TAdvOfficeCheckBox
      Left = 48
      Top = 337
      Width = 96
      Height = 19
      Alignment = taLeftJustify
      Caption = '2.6.Частота'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 34
      Version = '1.1.1.4'
    end
    object cbm_byCosFi: TAdvOfficeCheckBox
      Left = 48
      Top = 355
      Width = 145
      Height = 19
      Alignment = taLeftJustify
      Caption = '2.7.Коэфф.мощности'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReturnIsTab = False
      TabOrder = 35
      Version = '1.1.1.4'
    end
  end
  object pbm_sBTIProgress: TAdvProgress
    Left = 3
    Top = 389
    Width = 725
    Height = 20
    Min = 0
    Max = 100
    Position = 100
    TabOrder = 4
    BarColor = clHighlight
    BkColor = clWindow
    Version = '1.2.0.0'
  end
  object EventBoxStyler: TAdvFormStyler
    AutoThemeAdapt = False
    Style = tsOffice2007Luna
    Left = 444
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
    Left = 409
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
    Left = 374
  end
  object ImageList2: TImageList
    Height = 32
    Width = 32
    Left = 339
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FDFDFD00FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFE00F6F9FB00F0F6F800F4F8FA00FBFC
      FD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFE00F1F6F900DDEBF000D2E5EB00D9E9EE00EDF4
      F700FCFDFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFE00F2F7F900DAE9EF00B3D2DE00599BD30097C2D700DAE9
      EE00F1F6F900FDFDFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFE00F2F7F900DBEAEF00B5D3DF004A95D8003196FF003489E300A9CC
      DC00E2EEF200F7FAFB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      FE00F6F9FB00DFECF100B7D4DF004A96D8003299FF0034A0FF00339BFF004591
      D900C7DEE600ECF4F600FCFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      FE00F2F7F900C8DFE8004E99DA003199FF00339EFF00329CFF00339EFF002F92
      FC0078AED400E1EDF100F6F9FB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      FE00FDFDFE0083B5DD006BB2FF003AA2FF00309BFF00329CFF00329CFF00349E
      FF00348CE600BED9E300EEF5F700FDFDFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE00DDEBF10064A5E30065B4FF002F9BFF00329CFF00329CFF00339E
      FF002F95FE007DB2D600E9F2F500FAFCFC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE0000000000C9DFEA0059A2F00045A6FF002F9BFF00329CFF00329C
      FF00349EFF004897DE00D9E8EE00F7FAFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFE00FDFDFE0079B1DC004FA9FF00309DFF00329CFF00329C
      FF00349EFF003090F000B8D6E300F6F9FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE00BBD7E500439EF60036A4FF00319FFF00329E
      FF00339EFF003096FC0098C3DC00F6F9FA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFCFD00DCEAF000499EE70038A9FF0031A3FF0032A2
      FF0032A1FF00339CFF0080B5DA00F4F8F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FDFDFE00FCFD
      FD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFCFD00FBFC
      FD00FBFCFD00FCFDFD00FEFEFE00000000000000000000000000000000000000
      00000000000000000000FAFCFC00E4EFF30053A2DF0037ABFF0032A7FF0032A6
      FF0032A4FF0035A2FF007AB3DA00F5F9FA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00F9FBFC00EFF5F800E6F0
      F400E2EEF200E2EEF200E2EEF200E2EEF200E2EEF200E2EEF200E2EEF200E2EE
      F200E5F0F300EEF5F700F9FBFC00FEFEFE000000000000000000000000000000
      00000000000000000000F8FAFC00DEEBF0004FA1E00034AEFF0032ABFF0032A9
      FF0032A8FF0039A7FF007EB6DB00F8FAFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00F0F6F800D8E8EE00C0DA
      E300B7D4DF00B7D4DF00B7D4DF00B7D4DF00B7D4DF00B7D4DF00B7D4DF00BCD7
      E100C9DFE700DDEBF000F2F7F900FEFEFE000000000000000000000000000000
      000000000000FEFEFE00F3F8F900CAE0E80040A0E80034B3FF0032AEFF0032AD
      FF0031ACFF003DAAFF008BBDDD00FBFCFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EEF5F70081B5DB004E9B
      DC004A9AD9004A9AD9004A9CD9004B9DD9004C9EDA004C9EDA004CA0DA0050A3
      DC0053A3E10096C3E100F9FBFC00000000000000000000000000000000000000
      000000000000FAFCFC00EAF2F500A1C8DC0033A6F80033B6FF0032B2FF0032B0
      FF0032B0FF0040ABFD00A7CCE100FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F7005FA3DE0046AD
      FF0032A8FF0032AAFF0034ADFF0034B0FF0034B2FF0034B4FF0034B8FF0036B7
      FF0051A5E700DEECF100FEFEFE00000000000000000000000000000000000000
      0000FDFDFE00EFF5F800D7E7EC0063AAD90036B7FF0032B8FF0031B5FF002FB3
      FF003CB8FF004DABF300CEE2EC00FDFDFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F70065A7DE005DB9
      FF0049B5FF0039B0FF0030AFFF0030B1FF0032B4FF0032B8FF0034B6FF0055A6
      E300E3EEF30000000000FEFEFE00000000000000000000000000FEFEFE00FBFC
      FD00EEF5F700DAE9EE009AC4D80036A9F40030BEFF0030BAFF0036BBFF0042BD
      FF0063C9FF0068AFE300F2F7F900FDFDFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F70067A8DE0064BE
      FF005BBEFF005ABFFF004DBCFF003BB8FF0031B8FF0030B7FF00469EE000BED8
      E200E4EFF300F0F6F800F8FAFC00FAFCFC00FAFCFC00F8FAFC00F2F7F900E4EF
      F300D3E5EB00A8CCDB0042A5E50035C3FF003CC4FF004CC7FF0059CAFF005FCC
      FF0070C7FF009AC6E00000000000FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F70069AADF006BC3
      FF0061C3FF0062C4FF0064C7FF0062C8FF0058C8FF004AC3FF0048A5E60088BA
      D300BCD7E100D0E3EA00DAE9EF00E1EDF200E1EDF200DBEAEF00D1E4EA00C2DA
      E3008EBED5004EAAE70051CDFF005BD2FF0063D2FF0064D1FF005FCEFF0079D8
      FF0068B5EE00E3EEF300FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F7006BABDF0073C8
      FF0068C7FF0068C9FF0068CBFF0069CDFF006BD0FF006CD3FF006AD4FF0053B8
      F80059A7DA0081B7D300A2C8D800B1D0DD00B3D1DD00A4C9D90087BAD40060AC
      D90053BBF7006ADAFF006CDBFF006AD8FF0069D7FF0067D4FF0071D8FF0084D2
      FF009CC8E20000000000FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F7006CACDF007BCD
      FF006ECBFF0071CFFF0071D1FF006FD1FF0070D4FF0070D5FF0070D7FF0074DD
      FF0070D8FF005DC6FC0054B5EE0055AEE40054AEE20056B6ED005BC6FB006FDC
      FF0074E2FF0071DEFF0070DCFF0070DCFF006FDAFF0072DCFF0099E4FF0075B8
      E600F6F9FB00FEFEFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F7006DADDF007FD0
      FF007DD4FF009DDCFF009BDDFF007DD9FF0074D6FF0077DAFF0077DBFF0077DC
      FF0078DFFF007BE3FF007CE5FF007CE5FF007CE6FF007CE7FF007BE7FF0078E4
      FF0077E3FF0077E1FF0077E1FF0075E0FF007AE1FF009FE9FF0074BCF000E0ED
      F300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00EFF5F7006EAEE00091DA
      FF00A4DFFF006AADE2006DAFE400A5E2FF0091E4FF007BDDFF007DDEFF007FE1
      FF007FE2FF007FE3FF007FE5FF007FE6FF007FE6FF007FE7FF007FE7FF007FE7
      FF007FE7FF007EE5FF007BE5FF008DEAFF00A8ECFF0076BFF000DAEAF1000000
      0000FEFEFE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00F3F7F90074B2E100AFE1
      FF006FAFE400E9F1F500ECF3F7007CB8E30094D4FF00ABEDFF0092E8FF0084E4
      FF0083E5FF0085E6FF0086E8FF0086E9FF0086EAFF0086EAFF0085EAFF0083EA
      FF0084EAFF0090EEFF00A9F3FF009DE1FF007DBEE800E4EFF40000000000FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00FCFDFD006BACE40068AB
      E600E9F1F500000000000000000000000000B0D2E6007ABCEC009CDBFF00B1F0
      FF00A8F2FF009BF0FF0093EFFF0090EFFF0090EFFF0093F1FF0099F3FF00A5F6
      FF00B0F5FF00A3E6FF0080C7F100A9D1E600FDFDFE0000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFE00A6CCE700E3EE
      F40000000000FEFEFE00000000000000000000000000F7FAFB00B6D6E70082BD
      E50086C9F40098DBFF00A7E8FF00ADEEFF00AEF0FF00A8EBFF009CE1FF0089D0
      F80083C4EA00AED4E700F3F8FA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFE00000000000000
      0000FEFEFE000000000000000000000000000000000000000000000000000000
      0000EBF3F600C6DFEB00ADD2E6009FCBE4009DCBE400ABD1E600C2DCE900E6F0
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFBFB00F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500FBFBFB0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00FCFCFC00FAFA
      FA00F9F9F900FAFAFA00FBFBFB00FBFBFB00FAFAFA00FBFBFB00FAFAFA00F9F9
      F900FAFAFA00FDFDFD00FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00F9F9F900F4F4
      F400F3F3F300F5F5F500F6F6F600F6F6F600F5F5F500F7F7F700F6F6F600F3F3
      F300F4F4F400F9F9F900FCFCFC00FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FCFCFC00FAFAFA00FAFAFA00FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F300A4A4A4007E7E
      7E007B7B7B008282820094949400939393009393930093939300939393009393
      9300939393009393930093939300939393009393930093939300939393009393
      9300939393009393930093939300939393009393930094949400828282007B7B
      7B007C7C7C00A3A3A300F2F2F200000000000000000000000000000000000000
      0000000000000000000000000000FEFEFE00FBFBFB00F8F8F800F9F9F900F0F0
      F000D9D9D900C3C3C300B2B2B200AFAFAF00B0B0B000B7B7B700C9C9C900E2E2
      E200F5F5F500F9F9F900F9F9F900FCFCFC00FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFD00F7F7F700F1F1F100F2F2F200E2E2
      E200B5B5B500929292008181810081818100818181008585850091919100B4B4
      B400DEDEDE00F1F1F100F2F2F200F6F6F600FCFCFC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500DCDCDC00C2C2C400AEAEB400A8A8B000A8A8B000B3B3B700CACACA00E5E5
      E500FBFBFB000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0E0E000343434003838
      38003535350068686800C9C9C900C1C1C100C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C9C9C900686868003636
      36003939390035353500E1E1E100000000000000000000000000000000000000
      000000000000FEFEFE00FCFCFC00F8F8F800F8F8F800DCDCDC00AFAFAF00AAAA
      AA00C4C4C400DDDDDD00E9E9E900ECECEC00EBEBEB00E7E7E700D5D5D500B9B9
      B900A6A6A600BCBCBC00EBEBEB00F8F8F800F9F9F900FDFDFD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F9F9F900F1F1F100F1F1F100C2C2C2007F7F7F009191
      9100C2C2C200E3E3E300EFEFEF00F5F5F500F5F5F500F3F3F300E9E9E900D1D1
      D100A2A2A20087878700BDBDBD00EEEEEE00F2F2F200F9F9F900FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00D3D3D3008E8EA000504E
      880026238700120D8C0007029000060193000601930009048E0018138B00322F
      860062618C00A5A5AE00E6E6E600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00373737004D4D
      4D004A4A4A0069696900BDBDBD00B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600BDBDBD00676767003838
      38003A3A3A0037373700DEDEDE00000000000000000000000000000000000000
      0000FEFEFE00FAFAFA00F8F8F800E8E8E800ACACAC00BEBEBE00EEEEEE00F7F7
      F700EDEDED00E5E5E500E1E1E100E0E0E000E0E0E000E2E2E200E7E7E700F1F1
      F100F7F7F700E1E1E100AEAEAE00BEBEBE00F4F4F400F8F8F800FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00F6F6F600F1F1F100DADADA007F7F7F00ACACAC00ECECEC00F6F6
      F600ECECEC00E4E4E400DFDFDF00DEDEDE00DDDDDD00DEDEDE00E2E2E200E8E8
      E800F3F3F300F5F5F500C9C9C9008A8A8A00D0D0D000F2F2F200F6F6F600FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D9D9D900727193001F1C890006009B000600
      A3000600A2000400A00002009D0002009C0002009D0002009E000600A1000600
      A3000600A20006019400353287009595A500EFEFEF0000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE003C3C3C002A2A
      2A00262626006D6D6D00C1C1C100BBBBBB00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BBBBBB00C2C2C200686868003B3B
      3B003E3E3E003A3A3A00DEDEDE0000000000000000000000000000000000FEFE
      FE00FAFAFA00F9F9F900CCCCCC00AEAEAE00EFEFEF00F2F2F200E1E1E100DEDE
      DE00E1E1E100E3E3E300E5E5E500E5E5E500E5E5E500E5E5E500E3E3E300E0E0
      E000DFDFDF00E6E6E600F6F6F600DBDBDB00A7A7A700E7E7E700F9F9F900FCFC
      FC00000000000000000000000000000000000000000000000000000000000000
      0000F6F6F600F4F4F400B1B1B1008C8C8C00E7E7E700F4F4F400E3E3E300DEDE
      DE00E1E1E100E4E4E400E5E5E500E6E6E600E6E6E600E6E6E600E5E5E500E3E3
      E300DFDFDF00DFDFDF00EDEDED00F6F6F600AFAFAF00ACACAC00F3F3F300F6F6
      F600FEFEFE000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE00A3A3AE00282589000600A1000600A20002009B000000
      9A000000A1000612AB000F1FB1001425B5001424B4000E1BAE00020CA7000000
      9E0000009A0004009D000600A400060099004A488A00CDCDCE00000000000000
      00000000000000000000000000000000000000000000DEDEDE003E3E3E003232
      32002E2E2E006D6D6D00C7C7C700BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00C7C7C7006B6B6B003F3F
      3F00414141003D3D3D00DEDEDE00000000000000000000000000FEFEFE00FAFA
      FA00FAFAFA00C1C1C100C3C3C300F6F6F600E4E4E400E0E0E000E5E5E500E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E5E5E500E0E0E000EAEAEA00F2F2F200ABABAB00DFDFDF00FAFA
      FA00FCFCFC00000000000000000000000000000000000000000000000000F6F6
      F600F5F5F500A0A0A000A7A7A700F5F5F500E7E7E700E0E0E000E5E5E500E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E7E7E700E6E6E600E2E2E200E1E1E100F4F4F400D2D2D2009C9C9C00F4F4
      F400F6F6F600FEFEFE0000000000000000000000000000000000000000000000
      0000FBFBFB0081819C000A0595000600A300040099000206A200122EBD003158
      D600507AE600658EEE007299F200799EF2007B9FF2007699F0006A8DEA005274
      DF002F4DCB000C1EB10000009D0004009C000600A40024218C00B7B7BE000000
      00000000000000000000000000000000000000000000DEDEDE00404040004545
      4500434343006D6D6D00CBCBCB00C4C4C400C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C4C4C400CBCBCB006D6D6D004242
      42004545450040404000DEDEDE00000000000000000000000000FBFBFB00FBFB
      FB00C3C3C300CACACA00F3F3F300E2E2E200E5E5E500E6E6E600E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E4E4E400E5E5E500F5F5F500ABABAB00E5E5
      E500F9F9F900FDFDFD0000000000000000000000000000000000F8F8F800F6F6
      F600A7A7A700AEAEAE00F5F5F500E3E3E300E4E4E400E6E6E600E6E6E600E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E6E6E600E2E2E200F0F0F000D9D9D900A2A2
      A200F4F4F400F8F8F800FEFEFE00000000000000000000000000000000000000
      000082829E0006009B0006009E000204A0001137C600326BE9004F86F5005489
      F4004980F1003B75EE00306CEC002D6AEB002F69EA00386EEA004879EC005C87
      EE006892F1005E88EC00375DD8000C21B30000009B000600A3001A159000BFBF
      C5000000000000000000000000000000000000000000DEDEDE00454545004949
      49004545450071717100CFCFCF00C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800CFCFCF00707070004646
      46004848480045454500DEDEDE000000000000000000FDFDFD00FAFAFA00D9D9
      D900BDBDBD00F3F3F300E4E4E400E6E6E600E7E7E700E7E7E700E7E7E700E9E9
      E900E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8
      E800E8E8E800E8E8E800E7E7E700E7E7E700E6E6E600E7E7E700F2F2F200A7A7
      A700F3F3F300F9F9F900FEFEFE000000000000000000FCFCFC00F5F5F500CACA
      CA0098989800F3F3F300E5E5E500E6E6E600E7E7E700E7E7E700E7E7E700E8E8
      E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8
      E800E8E8E800E8E8E800E8E8E800E7E7E700E7E7E700E4E4E400F0F0F000CBCB
      CB00BEBEBE00F5F5F500FCFCFC0000000000000000000000000000000000A9A9
      B6000904980006009D00041AB0001557E6002E76F8002E72F3001963F0000458
      EE000053EC000051EB000050EA00004FE900004FE800004DE700004CE600004D
      E6000E54E6002D65E700497BEC004476EB001A41CC000206A1000600A2002926
      8E00E1E1E10000000000000000000000000000000000DEDEDE00484848004C4C
      4C004949490072727200D4D4D400CDCDCD00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CDCDCD00D4D4D400727272004949
      49004C4C4C0048484800DEDEDE000000000000000000FAFAFA00F4F4F400A9A9
      A900F3F3F300E6E6E600E7E7E700E7E7E700E8E8E800E8E8E800E9E9E900E7E7
      E700F0F0F000EEEEEE00E9E9E900E9E9E900EAEAEA00EAEAEA00EAEAEA00E9E9
      E900E9E9E900E9E9E900E8E8E800E8E8E800E8E8E800E7E7E700EBEBEB00E4E4
      E400B4B4B400FCFCFC00FCFCFC000000000000000000F7F7F700F0F0F0008080
      8000EBEBEB00E9E9E900E7E7E700E7E7E700E8E8E800E8E8E800E8E8E800E9E9
      E900E9E9E900E9E9E900EAEAEA00E9E9E900EAEAEA00E9E9E900EAEAEA00EAEA
      EA00E9E9E900E9E9E900E9E9E900E8E8E800E8E8E800E8E8E800E6E6E600F3F3
      F300A3A3A300E6E6E600F7F7F700FEFEFE000000000000000000E4E4E4002623
      910006009F000624B900095FF2001468F7000B60F3000059F1000058F1000058
      F0000058EF000057EE000056ED000055EC000054EB000054EA000053E9000052
      E800004EE600004CE600004FE6001F5EE700316CEC00184CD900040CA5000600
      A20065639800FEFEFE00000000000000000000000000DEDEDE004C4C4C005151
      51004D4D4D0075757500D8D8D800D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D8D8D800747474004E4E
      4E00505050004C4C4C00DEDEDE0000000000FDFDFD00FDFDFD00BCBCBC00DFDF
      DF00EBEBEB00E7E7E700E8E8E800E8E8E800E9E9E900EAEAEA00EDEDED007171
      710075757500DADADA00F7F7F700EDEDED00EAEAEA00EBEBEB00EBEBEB00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00E9E9E900E9E9E900E9E9E900E7E7E700F1F1
      F100BCBCBC00E2E2E200FBFBFB00FEFEFE00FCFCFC00F9F9F900A0A0A000C3C3
      C300EFEFEF00E7E7E700E8E8E800E8E8E800E9E9E900E9E9E900EEEEEE00F4F4
      F400F4F4F400F4F4F400F0F0F000EAEAEA00EBEBEB00EAEAEA00EEEEEE00F5F5
      F500F4F4F400F4F4F400F0F0F000E9E9E900E9E9E900E9E9E900E8E8E800EAEA
      EA00EBEBEB009E9E9E00F9F9F900FCFCFC0000000000000000008181A4000600
      A0000923B7000F64F5000C64F700085FF300045EF300005BF3000055F2000054
      F100005AF1000059F0000058EF000057EE000056ED000056EC000055EC000051
      EA000050E900004DE800004EE700004FE6000852E600165CEA000845D9000409
      A4000C079700C9C9CE00000000000000000000000000DEDEDE004F4F4F005353
      53005050500077777700D6D6D600CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00D6D6D600777777005050
      5000535353004F4F4F00DEDEDE0000000000FCFCFC00F3F3F300AFAFAF00F2F2
      F200E8E8E800E8E8E800E9E9E900E9E9E900EAEAEA00EBEBEB00EDEDED005757
      570021212100404040009A9A9A00EAEAEA00F6F6F600EDEDED00ECECEC00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EAEAEA00EAEAEA00E9E9E900E9E9E900EBEB
      EB00EAEAEA00B0B0B000FEFEFE00FDFDFD00FAFAFA00F1F1F10085858500EEEE
      EE00E9E9E900E8E8E800E9E9E900E9E9E900E9E9E900F0F0F000C1C1C1007575
      75007B7B7B0074747400ACACAC00F2F2F200ECECEC00F1F1F100CDCDCD007878
      78007B7B7B0074747400A3A3A300F0F0F000EAEAEA00E9E9E900E9E9E900E9E9
      E900F1F1F100B0B0B000E5E5E500FAFAFA0000000000F1F1F1002A2794000811
      AC001562EF001469F7001164F4000F63F400005BF4000E61F400A2BFFA007EA6
      F8000053F2000059F200005BF1000059F1000059F0000058EF000051ED000B57
      ED00B1C6F800A6BEF7000E55EA00004BE8000051E8000050E7000255EB00043A
      CF000600A400706EA000000000000000000000000000DEDEDE00535353005858
      5800555555007A7A7A00C8C8C800B1B1B100B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B1B1B100C6C6C6007A7A7A005656
      56005757570053535300DEDEDE0000000000FEFEFE00CACACA00D6D6D600EDED
      ED00E9E9E900E9E9E900EAEAEA00EAEAEA00EBEBEB00ECECEC00EEEEEE005C5C
      5C002D2D2D00303030002929290053535300B7B7B700F5F5F500F4F4F400ECEC
      EC00ECECEC00ECECEC00ECECEC00EBEBEB00EBEBEB00EAEAEA00EAEAEA00E9E9
      E900F1F1F100B4B4B400F0F0F000FCFCFC00FCFCFC00B7B7B700B6B6B600F0F0
      F000E8E8E800E9E9E900EAEAEA00EAEAEA00EBEBEB00F7F7F700989898001E1E
      1E002A2A2A001F1F1F0074747400F6F6F600EDEDED00F6F6F600B1B1B1002121
      21002A2A2A002020200068686800F4F4F400EBEBEB00EAEAEA00EAEAEA00E9E9
      E900ECECEC00E2E2E200B0B0B0000000000000000000C0C0C90004019B00154D
      D9001B70FA001869F4001668F400025FF3002F74F500C7D9FC00FFFFFF00FFFF
      FF0097B8FA000259F3000058F300005CF300005BF2000052F1001B61F100C1D3
      FB00FFFFFF00FFFFFF00CCD9FB00356EEE00004DEA000053E9000052E8000255
      EB00041FBC002F2A9600F5F5F5000000000000000000DEDEDE00575757005A5A
      5A00575757007D7D7D00CCCCCC00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500CACACA007D7D7D005757
      57005A5A5A0057575700DEDEDE000000000000000000AEAEAE00ECECEC00EAEA
      EA00EAEAEA00EAEAEA00EBEBEB00EBEBEB00ECECEC00EDEDED00EFEFEF005C5C
      5C002D2D2D0034343400343434002C2C2C002D2D2D006B6B6B00CFCFCF00FAFA
      FA00F2F2F200EDEDED00EDEDED00ECECEC00ECECEC00EBEBEB00EBEBEB00EAEA
      EA00EDEDED00D4D4D400CECECE00FEFEFE00000000008A8A8A00DCDCDC00ECEC
      EC00E9E9E900EAEAEA00EAEAEA00EBEBEB00ECECEC00F7F7F7009D9D9D002929
      2900343434002A2A2A007B7B7B00F7F7F700EEEEEE00F8F8F800B5B5B5002C2C
      2C00343434002B2B2B006F6F6F00F5F5F500ECECEC00ECECEC00EBEBEB00EAEA
      EA00EBEBEB00F0F0F00099999900FCFCFC00000000008F8FAF000C1DB8002270
      F6001F6EF6001D6CF5000F65F400528BF700ECF2FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B7CDFC001864F4000058F3000054F2002E6FF400D3E0FC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F3F7FE003F77F000004FEB000054EB000056
      EC000245DC000E0E9F00D7D7DB000000000000000000DEDEDE005B5B5B005F5F
      5F005C5C5C007E7E7E00EBEBEB00E4E4E400E4E4E400E4E4E400E4E4E400E4E4
      E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4
      E400E4E4E400E4E4E400E4E4E400E4E4E400E4E4E400EAEAEA007D7D7D005D5D
      5D005E5E5E005B5B5B00DEDEDE0000000000FAFAFA00B0B0B000EFEFEF00EAEA
      EA00EAEAEA00EBEBEB00ECECEC00ECECEC00EDEDED00EEEEEE00F0F0F0005C5C
      5C002E2E2E003535350035353500353535003434340029292900363636008686
      8600E1E1E100FAFAFA00F0F0F000EDEDED00EDEDED00ECECEC00ECECEC00EBEB
      EB00ECECEC00E7E7E700B5B5B500000000000000000086868600EBEBEB00EBEB
      EB00EAEAEA00EAEAEA00ECECEC00ECECEC00EDEDED00F8F8F8009D9D9D002929
      2900343434002A2A2A007B7B7B00F8F8F800EFEFEF00F9F9F900B5B5B5002C2C
      2C00343434002B2B2B006F6F6F00F5F5F500EEEEEE00ECECEC00ECECEC00ECEC
      EC00EBEBEB00EFEFEF00ACACAC00EFEFEF00000000007474A2001A47D9002878
      FB002370F500226FF500196AF5004F88F700D5E2FC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D2E0FC002A70F5003E7CF600E3ECFD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC5FB00246AF1000054ED000056EC000056
      EC000256ED00041DB700BEBEC9000000000000000000DEDEDE00606060006161
      61005F5F5F007F7F7F00F2F2F200EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00F2F2F2007F7F7F005F5F
      5F006161610060606000DEDEDE0000000000EEEEEE00BEBEBE00EEEEEE00EBEB
      EB00EBEBEB00ECECEC00ECECEC00EDEDED00EEEEEE00F0F0F000F0F0F0005F5F
      5F00323232003A3A3A0039393900393939003838380038383800343434002929
      290044444400A1A1A100EFEFEF00F8F8F800EFEFEF00EDEDED00ECECEC00ECEC
      EC00ECECEC00EEEEEE00ACACAC0000000000EDEDED0097979700EFEFEF00EBEB
      EB00EBEBEB00ECECEC00ECECEC00EDEDED00EEEEEE00F9F9F9009C9C9C002929
      2900343434002A2A2A007A7A7A00F9F9F900F0F0F000FAFAFA00B3B3B3002C2C
      2C00343434002B2B2B006E6E6E00F6F6F600EFEFEF00EEEEEE00EDEDED00ECEC
      EC00ECECEC00EFEFEF00C0C0C000DEDEDE00000000007275A4002764EF002B79
      F9002973F6002572F6002370F500397DF6005189F600B9CDFA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7EFFE00EEF4FE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFEFF009AB9F9003F7DF5001461F1000058F0000058EF000057
      EE00005BF2000436CE00B9B9C6000000000000000000DEDEDE00656565006666
      6600656565005F5F5F00B0B0B000BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BDBDBD00B1B1B1005E5E5E006666
      66006565650064646400DEDEDE0000000000E4E4E400C5C5C500F1F1F100ECEC
      EC00ECECEC00ECECEC00EEEEEE00EEEEEE00EFEFEF00F0F0F000F0F0F0006363
      6300383838003F3F3F003F3F3F003F3F3F003E3E3E003C3C3C003B3B3B003A3A
      3A00333333002B2B2B0059595900BBBBBB00F0F0F000EFEFEF00EDEDED00ECEC
      EC00EFEFEF00F0F0F000B4B4B400FEFEFE00E0E0E000A0A0A000F1F1F100EEEE
      EE00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00FAFAFA009C9C9C002B2B
      2B00363636002B2B2B0079797900FAFAFA00F1F1F100FBFBFB00B2B2B2002E2E
      2E00363636002C2C2C006E6E6E00F6F6F600EFEFEF00EFEFEF00EEEEEE00EDED
      ED00EDEDED00F1F1F100D2D2D200D3D3D30000000000767FAB002F74FA002F7A
      F7002D76F6002B75F6002974F6002471F6004383F7004984F5009DBAF800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFBFE0086ABF7003C7CF5001464F400005AF300005BF200005AF1000059
      F100005CF3000246E000BABBC7000000000000000000DEDEDE00696969006969
      6900696969006969690065656500646464006464640064646400646464006464
      6400646464006464640064646400646464006464640064646400646464006464
      6400646464006464640064646400646464006464640065656500696969006969
      69006969690069696900DEDEDE0000000000E1E1E100C8C8C800F3F3F300F0F0
      F000EEEEEE00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1F100F1F1F1006767
      67003E3E3E004545450045454500444444004343430042424200404040003F3F
      3F003D3D3D003B3B3B002C2C2C0024242400B2B2B200F8F8F800EEEEEE00F0F0
      F000F2F2F200F2F2F200B5B5B500FEFEFE00DDDDDD00A3A3A300F3F3F300F1F1
      F100EEEEEE00EDEDED00EEEEEE00EFEFEF00EFEFEF00FBFBFB009D9D9D003232
      32003C3C3C00313131007B7B7B00FAFAFA00F3F3F300FBFBFB00B3B3B3003434
      34003C3C3C003232320070707000F6F6F600F1F1F100EFEFEF00EEEEEE00EFEF
      EF00F1F1F100F2F2F200D9D9D900CFCFCF00000000007884AF00337BFE00337C
      F7003179F6002F79F6002E77F6002B75F6002471F600397EF7003177F5007CA3
      F600EFF3FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6ED
      FD006494F500226CF4000F64F400045EF300085FF300045EF300025DF300005C
      F200005DF500024EE700BABCC8000000000000000000DEDEDE006D6D6D006D6D
      6D006B6B6B006D6D6D006C6C6C006D6D6D006C6C6C006D6D6D006C6C6C006D6D
      6D006C6C6C006D6D6D006C6C6C006D6D6D006C6C6C006D6D6D006C6C6C006D6D
      6D006C6C6C006D6D6D006C6C6C006D6D6D006B6B6B006C6C6C006B6B6B006C6C
      6C006C6C6C006D6D6D00DEDEDE0000000000E5E5E500CACACA00F4F4F400F2F2
      F200F2F2F200F1F1F100EFEFEF00EFEFEF00F1F1F100F2F2F200F2F2F2006C6C
      6C00454545004B4B4B004B4B4B004A4A4A004A4A4A0048484800474747004545
      45004141410035353500474747009A9A9A00E7E7E700F3F3F300F2F2F200F2F2
      F200F3F3F300F3F3F300B6B6B60000000000E1E1E100A6A6A600F4F4F400F2F2
      F200F2F2F200F1F1F100F0F0F000EFEFEF00F0F0F000FBFBFB009F9F9F003A3A
      3A0043434300393939007E7E7E00FAFAFA00F5F5F500FDFDFD00B3B3B3003C3C
      3C00434343003A3A3A0073737300F5F5F500F2F2F200F0F0F000F1F1F100F3F3
      F300F2F2F200F3F3F300D6D6D600D6D6D600000000007986B100387EFE00377F
      F700357CF700337CF700327AF6003079F6002E78F6002975F6002974F6001466
      F300BDD0FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1D3
      FB000F64F3000660F4001164F4001164F4000E62F4000C61F4000860F400065E
      F3000260F7000251EB00BDBFCB000000000000000000DEDEDE00727272007070
      7000707070007070700064646400616161006161610061616100606060006262
      6200636363006262620063636300626262006363630062626200626262006262
      62006262620062626200626262006E6E6E007070700070707000707070007070
      70007070700072727200DEDEDE0000000000EFEFEF00C5C5C500F5F5F500F3F3
      F300F3F3F300F4F4F400F4F4F400F2F2F200F2F2F200F3F3F300F2F2F2006F6F
      6F004A4A4A00515151005151510051515100505050004E4E4E004B4B4B004242
      42004646460086868600DFDFDF00FFFFFF00F6F6F600F4F4F400F4F4F400F4F4
      F400F4F4F400F5F5F500B0B0B00000000000000000009F9F9F00F5F5F500F3F3
      F300F3F3F300F4F4F400F4F4F400F3F3F300F2F2F200FBFBFB009F9F9F004040
      40004A4A4A004141410081818100FAFAFA00F6F6F600FDFDFD00B4B4B4004444
      4400494949003F3F3F0074747400F5F5F500F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F6F6F600C8C8C800E0E0E000000000008994B900397EFC003C83
      F7003A80F700387FF700367DF700337CF700337BF6002874F6002F78F600B9D0
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CADAFC003076F6000660F4001567F4001266F4001164F4000F63F4000C62
      F4000963F7000952E500D2D3DA000000000000000000DEDEDE00767676007474
      7400737373005F5F5F003F3F3F0042424200414141003E3E3E008E8E8E00C1C1
      C100CACACA00D4D4D400DFDFDF00EAEAEA00F5F5F500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00777777007272720073737300727272007373
      73007373730076767600DEDEDE0000000000FDFDFD00B7B7B700F9F9F900F5F5
      F500F4F4F400F5F5F500F6F6F600F6F6F600F6F6F600F7F7F700F4F4F4007F7F
      7F00585858005A5A5A00575757005555550054545400525252004F4F4F007878
      7800CFCFCF00FFFFFF00FCFCFC00F7F7F700F6F6F600F6F6F600F6F6F600F5F5
      F500F6F6F600F2F2F200BABABA0000000000000000008F8F8F00F5F5F500F5F5
      F500F4F4F400F5F5F500F5F5F500F6F6F600F6F6F600FDFDFD00B1B1B1005C5C
      5C005A5A5A004C4C4C0085858500FAFAFA00F7F7F700FEFEFE00B5B5B5005151
      51005F5F5F006565650098989800F9F9F900F8F8F800F6F6F600F6F6F600F5F5
      F500F5F5F500F9F9F900B4B4B400F4F4F40000000000B7BBCC003674F4004287
      F9003E83F7003B82F7003A80F700397FF7002D77F7004184F700CCDCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E1EBFD004C87F7000460F4001869F4001667F4001466F4001265
      F4001167FA00245BD300F2F2F2000000000000000000DEDEDE00797979007777
      7700787878005B5B5B0046464600484848004848480043434300A7A7A700B0B0
      B000BBBBBB00C5C5C500CFCFCF00D8D8D800E9E9E9006F6F6F00505050005050
      500058585800FFFFFF00FFFFFF00939393007575750077777700777777007777
      77007777770079797900DEDEDE000000000000000000B5B5B500F8F8F800F6F6
      F600F5F5F500F6F6F600F6F6F600F7F7F700F8F8F800F9F9F900F8F8F800AFAF
      AF009797970095959500919191008D8D8D00888888009A9A9A00CDCDCD00FCFC
      FC00FFFFFF00FAFAFA00F8F8F800F8F8F800F7F7F700F7F7F700F6F6F600F6F6
      F600F8F8F800E0E0E000D3D3D300000000000000000093939300E8E8E800F7F7
      F700F5F5F500F6F6F600F6F6F600F7F7F700F8F8F800FCFCFC00CBCBCB009A9A
      9A009A9A9A008E8E8E00AEAEAE00FCFCFC00FBFBFB00FEFEFE00CFCFCF009393
      93009D9D9D009C9C9C00B5B5B500F8F8F800F8F8F800F8F8F800F7F7F700F6F6
      F600F7F7F700FAFAFA00A4A4A4000000000000000000EDEDEE00396AD900488D
      FD004285F7004184F7003F83F700327CF700548FF700DCE7FD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ACC3F700A1BAF600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F6FE006A9BF8001166F5001969F5001969F5001668
      F4001569FD005E7ABF00000000000000000000000000DEDEDE007D7D7D007B7B
      7B007B7B7B005F5F5F004A4A4A004C4C4C004B4B4B0047474700B3B3B300B0B0
      B000AFAFAF00BBBBBB00C5C5C500CFCFCF00DEDEDE006A6A6A00494949004B4B
      4B0050505000FFFFFF00FFFFFF0096969600787878007A7A7A00797979007A7A
      7A007A7A7A007D7D7D00DEDEDE000000000000000000D0D0D000E4E4E400F9F9
      F900F6F6F600F7F7F700F7F7F700F8F8F800F9F9F900F9F9F900F8F8F800B9B9
      B900A8A8A800ABABAB00A8A8A800AEAEAE00D2D2D200F9F9F900FFFFFF00FDFD
      FD00FBFBFB00FAFAFA00F9F9F900F9F9F900F9F9F900F8F8F800F7F7F700F8F8
      F800FCFCFC00C1C1C100F5F5F500FEFEFE00FEFEFE00C2C2C200C5C5C500FBFB
      FB00F7F7F700F7F7F700F8F8F800F8F8F800F9F9F900FDFDFD00CDCDCD00A5A5
      A500A9A9A900A6A6A600C0C0C000FDFDFD00FDFDFD00FFFFFF00D7D7D700A6A6
      A600A9A9A900A5A5A500B9B9B900F8F8F800FAFAFA00F8F8F800F7F7F700F7F7
      F700F8F8F800EFEFEF00BBBBBB000000000000000000000000007188C100468A
      FF004789F7004486F7004184F700659AF800EFF5FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A5BDF600407DF2003A7BF20093B0F400FAFBFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006A9AF700226FF5001B6BF5001D6E
      F7001561F500BABFCF00000000000000000000000000DEDEDE00808080007E7E
      7E007F7F7F00616161005050500051515100515151004A4A4A00C1C1C100BBBB
      BB00AFAFAF00AFAFAF00BBBBBB00C5C5C500D4D4D4006B6B6B004F4F4F005050
      500055555500FFFFFF00FFFFFF009B9B9B007C7C7C007E7E7E007E7E7E007E7E
      7E007E7E7E0080808000DEDEDE0000000000FEFEFE00F9F9F900BFBFBF00FDFD
      FD00F8F8F800F8F8F800F9F9F900F8F8F800F9F9F900FAFAFA00F9F9F900BFBF
      BF00AEAEAE00B2B2B200CACACA00F0F0F000FFFFFF00FEFEFE00FCFCFC00FCFC
      FC00FCFCFC00FBFBFB00FAFAFA00F9F9F900F9F9F900F9F9F900F8F8F800FAFA
      FA00F8F8F800BABABA0000000000FEFEFE00FDFDFD000000000097979700FAFA
      FA00F9F9F900F8F8F800F8F8F800F8F8F800F9F9F900FDFDFD00D4D4D400B2B2
      B200B5B5B500B1B1B100C8C8C800FDFDFD00FDFDFD00FFFFFF00DBDBDB00B3B3
      B300B5B5B500B2B2B200C3C3C300F8F8F800FAFAFA00F9F9F900F8F8F800F9F9
      F900FCFCFC00BEBEBE00EEEEEE00FDFDFD000000000000000000DADBE1003771
      EA004F92FC004789F700498BF80073A0F600C4D3F700FFFFFF00FFFFFF00FFFF
      FF00FCFCFE0096B2F400588DF4004787F7004084F700538BF4007CA0F200EFF2
      FC00FFFFFF00FFFFFF00FFFFFF00ABC0F5006394F400337AF600216EF5002272
      FE004B74CE00FEFEFE00000000000000000000000000DEDEDE00858585008181
      810082828200656565005555550057575700565656004F4F4F00CECECE00C5C5
      C500BBBBBB00AFAFAF00AFAFAF00BBBBBB00C9C9C9006F6F6F00545454005656
      560059595900FFFFFF00FFFFFF00A0A0A0007F7F7F0080808000808080008080
      80008181810085858500DEDEDE0000000000FEFEFE0000000000C6C6C600F0F0
      F000FBFBFB00F9F9F900F9F9F900FAFAFA00FAFAFA00FBFBFB00F9F9F900C7C7
      C700C6C6C600E9E9E900FFFFFF00FFFFFF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FCFCFC00FBFBFB00FAFAFA00FAFAFA00F9F9F900FAFAFA00FDFD
      FD00CECECE00EBEBEB00FEFEFE00000000000000000000000000B0B0B000D7D7
      D700FCFCFC00FAFAFA00F9F9F900FAFAFA00FAFAFA00FAFAFA00F4F4F400EFEF
      EF00F0F0F000F0F0F000F4F4F400FDFDFD00FDFDFD00FDFDFD00F7F7F700F0F0
      F000F1F1F100EFEFEF00F2F2F200FAFAFA00FAFAFA00F9F9F900FAFAFA00FBFB
      FB00F8F8F800AFAFAF0000000000FEFEFE000000000000000000000000008E9E
      C7004487FF005191F900498BF7004D8DF7006294F50096B2F300F7F9FD00FBFB
      FE0085A6F200568DF5004889F700377FF700377EF7003F84F700528CF6006390
      F100E2E9FB00F7F8FD0084A5F2005288F400397EF7002572F6002A77F9002166
      ED00D2D5DD0000000000000000000000000000000000DEDEDE00888888008585
      850086868600676767005A5A5A005B5B5B005B5B5B0051515100D9D9D900D0D0
      D000C4C4C400BBBBBB00AFAFAF00AFAFAF00BEBEBE006F6F6F00595959005A5A
      5A005C5C5C00F4F4F400FCFCFC00A3A3A3008383830085858500858585008585
      85008585850088888800DEDEDE000000000000000000FEFEFE00FCFCFC00BBBB
      BB00FFFFFF00FCFCFC00FAFAFA00FAFAFA00FBFBFB00FBFBFB00FBFBFB00F2F2
      F200FBFBFB00FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FDFD
      FD00FDFDFD00FDFDFD00FCFCFC00FBFBFB00FAFAFA00FBFBFB00FDFDFD00F4F4
      F400C0C0C00000000000FEFEFE000000000000000000FDFDFD00000000009494
      9400FAFAFA00FCFCFC00FAFAFA00FAFAFA00FAFAFA00FBFBFB00FCFCFC00FEFE
      FE00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00FBFBFB00FBFBFB00FAFAFA00FCFCFC00FEFE
      FE00B7B7B700F3F3F300FDFDFD0000000000000000000000000000000000FEFE
      FE006686CE004C8FFF005392F9004B8CF8004F8FF900538DF6006C94F0006B94
      F0004B87F600478AF8003F84F7004084F7003F83F7003A80F7003B82F7004585
      F7004D82F0005987EF004281F500387FF7002B76F600317BF800226EFD00A2B0
      CC000000000000000000000000000000000000000000DEDEDE008B8B8B008989
      89008A8A8A00696969005E5E5E005F5F5F005F5F5F0056565600E2E2E200DBDB
      DB00D0D0D000C4C4C400BBBBBB00AFAFAF00B3B3B300717171005D5D5D005F5F
      5F0060606000E9E9E900F1F1F100A5A5A5008787870089898900898989008989
      8900898989008B8B8B00DEDEDE000000000000000000FEFEFE0000000000E3E3
      E300D5D5D500FFFFFF00FDFDFD00FBFBFB00FBFBFB00FBFBFB00FCFCFC00FFFF
      FF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FDFDFD00FDFDFD00FCFCFC00FBFBFB00FCFCFC00FDFDFD00FFFFFF00BABA
      BA00FDFDFD00FEFEFE0000000000000000000000000000000000FEFEFE00DDDD
      DD00B4B4B400FEFEFE00FDFDFD00FBFBFB00FBFBFB00FBFBFB00FCFCFC00FDFD
      FD00FDFDFD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FDFDFD00FCFCFC00FBFBFB00FBFBFB00FDFDFD00FEFEFE00E0E0
      E000D2D2D20000000000FEFEFE00000000000000000000000000000000000000
      0000F8F8F8006286D2004C90FF005695FA004F8FF8004F8FF9004889F7003F84
      F600498CF8004588F7004587F7004486F7004285F7004184F7003E83F7003C82
      F700377EF700357CF600397FF700357CF6003780FB002572FD0094A7CF000000
      00000000000000000000000000000000000000000000DEDEDE008D8D8D008C8C
      8C008D8D8D006A6A6A0063636300646464006464640059595900E9E9E900E5E5
      E500DBDBDB00D0D0D000C4C4C400BBBBBB00B2B2B20072727200636363006363
      630063636300DFDFDF00E7E7E700A7A7A7008A8A8A008B8B8B008B8B8B008B8B
      8B008C8C8C008D8D8D00DFDFDF00000000000000000000000000FEFEFE000000
      0000D1D1D100E3E3E300FFFFFF00FDFDFD00FCFCFC00FCFCFC00FCFCFC00FDFD
      FD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FEFEFE00FEFE
      FE00FEFEFE00FDFDFD00FCFCFC00FDFDFD00FDFDFD00FFFFFF00C3C3C300F1F1
      F100000000000000000000000000000000000000000000000000FDFDFD000000
      0000BFBFBF00CCCCCC00FFFFFF00FDFDFD00FDFDFD00FCFCFC00FCFCFC00FDFD
      FD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FDFDFD00FCFCFC00FDFDFD00FEFEFE00EDEDED00BABA
      BA0000000000FEFEFE0000000000000000000000000000000000000000000000
      000000000000FCFCFC007F99CD003F84FF005798FF005594F9005090F8004F8F
      F8004D8DF8004C8CF700498AF700478AF7004688F7004587F7004386F7004184
      F7003F83F7003E83F7003F84F8003983FF003677EE00B0BCD200000000000000
      00000000000000000000000000000000000000000000DEDEDE00909090009090
      9000919191006E6E6E006767670068686800686868005F5F5F00F0F0F000F0F0
      F000E4E4E400DBDBDB00D0D0D000C4C4C400BDBDBD0077777700646464006666
      660064646400D4D4D400DBDBDB00A7A7A7008E8E8E0090909000909090009090
      90009090900092929200EDEDED0000000000000000000000000000000000FEFE
      FE0000000000D0D0D000DDDDDD00FFFFFF00FEFEFE00FEFEFE00FDFDFD00FDFD
      FD00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FE00FEFEFE00FEFEFE00FFFFFF00FEFEFE00FFFFFF00C4C4C400EDEDED000000
      0000FEFEFE00000000000000000000000000000000000000000000000000FDFD
      FD0000000000BABABA00C6C6C600FFFFFF00FEFEFE00FEFEFE00FDFDFD00FDFD
      FD00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00EAEAEA00B4B4B4000000
      0000FDFDFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C8D8005885DB004589FE005595FC005795
      FB005493F9005190F8004E8EF8004D8DF8004B8CF700498AF700488AF700478A
      F800468AFB004087FF003479F6006F95DA00E4E6EB0000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00939393009393
      930094949400707070006C6C6C006D6D6D006D6D6D0062626200F4F4F400FBFB
      FB00F0F0F000E4E4E400DBDBDB00CFCFCF00C5C5C500A6A6A600979797009696
      96009D9D9D00C5C5C500D0D0D000A8A8A8009191910092929200929292009292
      9200A1A1A100A9A9A90000000000000000000000000000000000000000000000
      0000FEFEFE0000000000DCDCDC00CBCBCB00FFFFFF00FFFFFF00FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00FFFFFF00F3F3F300BFBFBF00F6F6F60000000000FEFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD0000000000CDCDCD00AEAEAE00F9F9F900FFFFFF00FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00CDCDCD00C8C8C80000000000FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C5DD006C99EB004986
      EF004387F9004C8DF8004F8FF8004F8FF8004D8DF800488AF7004287F9003980
      F8004883EA0080A1DA00D7DEEB00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4E4E400999999009B9B
      9B009C9C9C007575750074747400747474007474740068686800FCFCFC00FFFF
      FF00FFFFFF00F9F9F900EEEEEE00E5E5E500DADADA00D2D2D200C9C9C900BEBE
      BE00BFBFBF00C8C8C800D3D3D300ADADAD00999999009A9A9A009A9A9A00A5A5
      A500A8A8A8000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE0000000000F8F8F800C1C1C100DBDBDB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F8F800CCCCCC00CFCFCF000000000000000000FEFEFE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD0000000000000000009D9D9D00CECECE00FDFDFD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E2E2E200A8A8A800ECECEC0000000000FDFDFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DFE5
      F100AEC7EE0089B1F50074A5F80073A4F80072A3F80078A8FA0093B3E900BCCE
      ED00ECF0F7000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900939393009999
      9900999999008D8D8D00888888008888880088888800868686009D9D9D00A0A0
      A000A0A0A0009F9F9F00A0A0A000A0A0A000A0A0A000A0A0A000A1A1A100A0A0
      A000A0A0A000A0A0A000A1A1A1009696960099999900999999009A9A9A00B4B4
      B400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE000000000000000000EEEEEE00C5C5C500C8C8
      C800E2E2E200F6F6F600FCFCFC00FFFFFF00FFFFFF00FBFBFB00F0F0F000D7D7
      D700C2C2C200CFCFCF00FDFDFD0000000000FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFE0000000000E5E5E500A0A0A000B6B6
      B600E0E0E000F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00EBEB
      EB00C2C2C200A6A6A600DFDFDF000000000000000000FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE0000000000000000000000
      0000EBEBEB00D6D6D600C6C6C600C9C9C900C8C8C800C9C9C900DCDCDC00F4F4
      F400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD0000000000000000000000
      0000D8D8D800B1B1B100A1A1A100A4A4A400A3A3A300A6A6A600B2B2B200D7D7
      D700FBFBFB000000000000000000FEFEFE000000000000000000000000000000
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
      00000000000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFF1F000000000000000000000000
      FFFFFE0F000000000000000000000000FFFFFC07000000000000000000000000
      FFFFF803000000000000000000000000FFFFF003000000000000000000000000
      FFFFE001000000000000000000000000FFFFE001000000000000000000000000
      FFFFE000000000000000000000000000FFFFF000000000000000000000000000
      FFFFF400000000000000000000000000FFFFF800000000000000000000000000
      FFFFFC00000000000000000000000000FFFFFC00000000000000000000000000
      8001FC000000000000000000000000000000FC00000000000000000000000000
      0000F8000000000000000000000000000001F800000000000000000000000000
      0001F0000000000000000000000000000005C000000000000000000000000000
      0000000200000000000000000000000000000001000000000000000000000000
      0000000500000000000000000000000000000003000000000000000000000000
      0000000F00000000000000000000000000000017000000000000000000000000
      0000002F0000000000000000000000000700005F000000000000000000000000
      8B8001FF000000000000000000000000B7F00FFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFFC0000003FF8001FFFF8000FF
      FFFC3FFF80000001FE00007FFE00007FFFE007FF80000001F800003FF800001F
      FF0001FF80000001F000001FF000000FFE00007F80000001E000000FF0000007
      F800003F80000001C0000007E0000003F000001F80000001C0000003C0000001
      F000000F800000018000000180000001E0000007800000018000000180000000
      C0000003800000010000000000000000C0000003800000010000000000000000
      8000000380000001000000000000000180000001800000018000000080000000
      8000000180000001000000018000000080000001800000010000000100000000
      8000000180000001000000000000000080000001800000010000000000000000
      8000000180000001000000010000000080000001800000010000000180000000
      8000000180000001000000018000000080000001800000018000000180000001
      80000003800000018000000000000001C0000003800000010000000240000000
      C00000038000000140000001C0000002E00000078000000180000005A0000001
      E000000F80000001A0000003C0000005F000001F80000001D000000FD000000B
      F800003F80000001E8000017E8000017FE00007F80000003F400002FF400002F
      FF8001FF80000007FA0000DFFB00005FFFE007FF8000000FFD80017FFE8001BF
      FFFFFFFFFFFFFFFFFF700FFFFF7006FF00000000000000000000000000000000
      000000000000}
  end
  object m_sdSaveLog: TSaveDialog
    DefaultExt = 'log'
    Filter = 'Файлы отчетов о работе|*.log;*.txt;'
    FilterIndex = 0
    Left = 304
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
    Left = 480
  end
end
