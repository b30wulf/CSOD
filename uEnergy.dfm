object frmEnergy: TfrmEnergy
  Left = 407
  Top = 176
  Width = 793
  Height = 470
  Caption = 'frmEnergy'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object QuickRep1: TQuickRep
    Left = 0
    Top = 0
    Width = 786
    Height = 556
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    BeforePrint = QuickRep1BeforePrint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Values = (
      50
      2100
      50
      2970
      50
      50
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 70
    object QRBand2: TQRBand
      Left = 13
      Top = 144
      Width = 760
      Height = 16
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        60.4761904761905
        2872.61904761905)
      BandType = rbGroupFooter
      object QRShapeMs: TQRShape
        Left = 169
        Top = 1
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          638.779761904762
          3.7797619047619
          238.125)
        Shape = qrsRectangle
      end
      object sT1Es: TQRShape
        Left = 296
        Top = 1
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1118.80952380952
          3.7797619047619
          238.125)
        Shape = qrsRectangle
      end
      object sT2Es: TQRShape
        Left = 423
        Top = 1
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1598.83928571429
          3.7797619047619
          238.125)
        Shape = qrsRectangle
      end
      object sT3Es: TQRShape
        Left = 550
        Top = 1
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          2078.86904761905
          3.7797619047619
          238.125)
        Shape = qrsRectangle
      end
      object sT4Es: TQRShape
        Left = 677
        Top = 1
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          2558.89880952381
          3.7797619047619
          238.125)
        Shape = qrsRectangle
      end
      object lT2Es: TQRExpr
        Left = 424
        Top = 2
        Width = 58
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1602.61904761905
          7.55952380952381
          219.22619047619)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = True
        Transparent = True
        WordWrap = True
        Expression = 'sum(sqlEnergy.T2_night)'
        Mask = '0.00'
        FontSize = 8
      end
      object lT4Es: TQRExpr
        Left = 678
        Top = 2
        Width = 58
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2562.67857142857
          7.55952380952381
          219.22619047619)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = True
        Transparent = True
        WordWrap = True
        Expression = 'sum(sqlEnergy.T4_rezerv)'
        Mask = '0.00'
        FontSize = 8
      end
      object lT3Es: TQRExpr
        Left = 551
        Top = 2
        Width = 58
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2082.64880952381
          7.55952380952381
          219.22619047619)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = True
        Transparent = True
        WordWrap = True
        Expression = 'sum(sqlEnergy.T3_pik)'
        Mask = '0.00'
        FontSize = 8
      end
      object lT1Es: TQRExpr
        Left = 297
        Top = 2
        Width = 58
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1122.58928571429
          7.55952380952381
          219.22619047619)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = True
        Transparent = True
        WordWrap = True
        Expression = 'sum(sqlEnergy.T1_day)'
        Mask = '0.00'
        FontSize = 8
      end
      object QRExprSum: TQRExpr
        Left = 170
        Top = 2
        Width = 58
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          642.559523809524
          7.55952380952381
          219.22619047619)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = True
        Transparent = True
        WordWrap = True
        Expression = 'sum(sqlEnergy.Sum_T)'
        Mask = '0.00'
        FontSize = 8
      end
    end
    object QRGroup1: TQRGroup
      Left = 13
      Top = 49
      Width = 760
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        113.392857142857
        2872.61904761905)
      Expression = 'sqlEnergy.NewGroup'
      FooterBand = QRBand2
      Master = QuickRep1
      ReprintOnNewPage = False
      object QRDBTextName: TQRDBText
        Left = 32
        Top = 18
        Width = 49
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          120.952380952381
          68.0357142857143
          185.208333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'NameGroup'
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 664
        Top = 2
        Width = 59
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2509.7619047619
          7.55952380952381
          223.005952380952)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'OptionNumber'
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
      object lDetail: TQRLabel
        Left = 664
        Top = 18
        Width = 26
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2509.7619047619
          68.0357142857143
          98.2738095238095)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'lDetail'
        Color = clWhite
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
    end
    object QRBand3: TQRBand
      Left = 13
      Top = 133
      Width = 760
      Height = 11
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        41.577380952381
        2872.61904761905)
      BandType = rbDetail
      object sT3detailSumVal: TQRShape
        Left = 550
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          2078.86904761905
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT3detailVal: TQRShape
        Left = 487
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1840.74404761905
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT1detailSumVal: TQRShape
        Left = 296
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1118.80952380952
          0
          238.125)
        Shape = qrsRectangle
      end
      object QRShapeM: TQRShape
        Left = 169
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          638.779761904762
          0
          238.125)
        Shape = qrsRectangle
      end
      object QRShape21: TQRShape
        Left = 0
        Top = 0
        Width = 57
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          0
          0
          215.446428571429)
        Shape = qrsRectangle
      end
      object QRShape22: TQRShape
        Left = 56
        Top = 0
        Width = 51
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          211.666666666667
          0
          192.767857142857)
        Shape = qrsRectangle
      end
      object QRShape23: TQRShape
        Left = 106
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          400.654761904762
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT4detailSumVal: TQRShape
        Left = 677
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          2558.89880952381
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT1detailVal: TQRShape
        Left = 233
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          880.684523809524
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT4detailVal: TQRShape
        Left = 614
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          2320.77380952381
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT2detailVal: TQRShape
        Left = 360
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1360.71428571429
          0
          238.125)
        Shape = qrsRectangle
      end
      object sT2detailSumVal: TQRShape
        Left = 423
        Top = 0
        Width = 63
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1598.83928571429
          0
          238.125)
        Shape = qrsRectangle
      end
      object QRDBText2: TQRDBText
        Left = 4
        Top = 1
        Width = 50
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          15.1190476190476
          3.7797619047619
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'udate'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object QRDBTextSumm: TQRDBText
        Left = 107
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          404.434523809524
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'Sum_T'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object QRDBTextSummS: TQRDBText
        Left = 170
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          642.559523809524
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'Sum_Ts'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT1DetailSumVal: TQRDBText
        Left = 297
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1122.58928571429
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T1_days'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT4DetailVal: TQRDBText
        Left = 615
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          2324.55357142857
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T4_rezerv'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT2DetailVal: TQRDBText
        Left = 361
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1364.49404761905
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T2_night'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT2DetailSumVal: TQRDBText
        Left = 424
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1602.61904761905
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T2_nights'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT3DetailVal: TQRDBText
        Left = 488
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          1844.52380952381
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T3_pik'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT4DetailSumVal: TQRDBText
        Left = 678
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          2562.67857142857
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T4_rezervs'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT1DetailVal: TQRDBText
        Left = 234
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          884.464285714286
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T1_day'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT3DetailSumVal: TQRDBText
        Left = 551
        Top = 1
        Width = 60
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          2082.64880952381
          3.7797619047619
          226.785714285714)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'T3_piks'
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object QRDBText3: TQRDBText
        Left = 62
        Top = 1
        Width = 40
        Height = 10
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          234.345238095238
          3.7797619047619
          151.190476190476)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataField = 'procCurHH'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
    end
    object QRBand7: TQRBand
      Left = 13
      Top = 13
      Width = 760
      Height = 36
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        136.071428571429
        2872.61904761905)
      BandType = rbPageHeader
      object lProdUser: TQRLabel
        Left = 7
        Top = 1
        Width = 139
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          26.4583333333333
          3.77976190476191
          525.386904761905)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'ООО "Автоматизация - 2000"'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
      object QRLabelTitul: TQRLabel
        Left = 258
        Top = 12
        Width = 234
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          975.178571428571
          45.3571428571429
          884.464285714286)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Расход электроэнергии по субабонентам'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 12
      end
      object QRLabel3: TQRLabel
        Left = 599
        Top = 1
        Width = 125
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2264.07738095238
          3.77976190476191
          472.470238095238)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'ООО Автоматизация-2000'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 10
      end
    end
    object ChildBand2: TQRChildBand
      Left = 13
      Top = 79
      Width = 760
      Height = 54
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        204.107142857143
        2872.61904761905)
      ParentBand = QRGroup1
      object sT4: TQRShape
        Left = 614
        Top = 0
        Width = 126
        Height = 40
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          151.190476190476
          2320.77380952381
          0
          476.25)
        Shape = qrsRectangle
      end
      object sT4Val: TQRShape
        Left = 614
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          2320.77380952381
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object QRShape1: TQRShape
        Left = 0
        Top = 0
        Width = 57
        Height = 54
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          204.107142857143
          0
          0
          215.446428571429)
        Shape = qrsRectangle
      end
      object lDate: TQRLabel
        Left = 3
        Top = 2
        Width = 50
        Height = 50
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          188.988095238095
          11.3392857142857
          7.55952380952381
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'Дата'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRShape6: TQRShape
        Left = 56
        Top = 0
        Width = 51
        Height = 54
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          204.107142857143
          211.666666666667
          0
          192.767857142857)
        Shape = qrsRectangle
      end
      object QRShape4: TQRShape
        Left = 106
        Top = 0
        Width = 126
        Height = 40
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          151.190476190476
          400.654761904762
          0
          476.25)
        Shape = qrsRectangle
      end
      object QRShape2: TQRShape
        Left = 106
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          400.654761904762
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object QRShape5: TQRShape
        Left = 169
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          638.779761904762
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object sT1: TQRShape
        Left = 233
        Top = 0
        Width = 126
        Height = 40
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          151.190476190476
          880.684523809524
          0
          476.25)
        Shape = qrsRectangle
      end
      object sT2: TQRShape
        Left = 360
        Top = 0
        Width = 126
        Height = 40
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          151.190476190476
          1360.71428571429
          0
          476.25)
        Shape = qrsRectangle
      end
      object sT3: TQRShape
        Left = 487
        Top = 0
        Width = 126
        Height = 40
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          151.190476190476
          1840.74404761905
          0
          476.25)
        Shape = qrsRectangle
      end
      object sT1SumVal: TQRShape
        Left = 296
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1118.80952380952
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object sT2Val: TQRShape
        Left = 360
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1360.71428571429
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object sT2SumVal: TQRShape
        Left = 423
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1598.83928571429
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object sT1Val: TQRShape
        Left = 233
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          880.684523809524
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object sT3Val: TQRShape
        Left = 487
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1840.74404761905
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object sT3SumVal: TQRShape
        Left = 550
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          2078.86904761905
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object lData: TQRLabel
        Left = 59
        Top = 2
        Width = 46
        Height = 50
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          188.988095238095
          223.005952380952
          7.55952380952381
          173.869047619048)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'Данные'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object lAll: TQRLabel
        Left = 120
        Top = 2
        Width = 96
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          453.571428571429
          7.55952380952381
          362.857142857143)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Общее потребление, кВт ч'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT1: TQRLabel
        Left = 267
        Top = 1
        Width = 56
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1009.19642857143
          3.77976190476191
          211.666666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Т1 - день, кВт ч'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT2: TQRLabel
        Left = 395
        Top = 1
        Width = 56
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1493.00595238095
          3.77976190476191
          211.666666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Т2 - ночь, кВт ч'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT3: TQRLabel
        Left = 524
        Top = 1
        Width = 51
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1980.59523809524
          3.77976190476191
          192.767857142857)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Т3 - пик, кВт ч'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT4: TQRLabel
        Left = 645
        Top = 1
        Width = 64
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2437.94642857143
          3.77976190476191
          241.904761904762)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Т4 - резерв, кВт ч'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lOnDay: TQRLabel
        Left = 122
        Top = 41
        Width = 32
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          461.130952380952
          154.970238095238
          120.952380952381)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'За сутки'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT1Val: TQRLabel
        Left = 246
        Top = 41
        Width = 35
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          929.821428571429
          154.970238095238
          132.291666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Значение'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT1SumVal: TQRLabel
        Left = 302
        Top = 41
        Width = 50
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1141.4880952381
          154.970238095238
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'С нар. итогом'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT4Val: TQRLabel
        Left = 627
        Top = 41
        Width = 35
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2369.91071428571
          154.970238095238
          132.291666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Значение'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT2Val: TQRLabel
        Left = 373
        Top = 41
        Width = 35
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1409.85119047619
          154.970238095238
          132.291666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Значение'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT3Val: TQRLabel
        Left = 500
        Top = 41
        Width = 35
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1889.88095238095
          154.970238095238
          132.291666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Значение'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object sT4SumVal: TQRShape
        Left = 677
        Top = 40
        Width = 63
        Height = 14
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          2558.89880952381
          151.190476190476
          238.125)
        Shape = qrsRectangle
      end
      object lT4SumVal: TQRLabel
        Left = 682
        Top = 41
        Width = 50
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2577.79761904762
          154.970238095238
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'С нар. итогом'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT3SumVal: TQRLabel
        Left = 555
        Top = 41
        Width = 50
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2097.76785714286
          154.970238095238
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'С нар. итогом'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lT2SumVal: TQRLabel
        Left = 428
        Top = 41
        Width = 50
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          1617.7380952381
          154.970238095238
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'С нар. итогом'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lAllSumVal: TQRLabel
        Left = 174
        Top = 41
        Width = 50
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          657.678571428571
          154.970238095238
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'С нар. итогом'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lTime1: TQRLabel
        Left = 236
        Top = 12
        Width = 117
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          94.4940476190476
          892.02380952381
          45.3571428571429
          442.232142857143)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'lTime1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lTime2: TQRLabel
        Left = 365
        Top = 12
        Width = 116
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          105.833333333333
          1379.6130952381
          45.3571428571429
          438.452380952381)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'lTime1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lTime3: TQRLabel
        Left = 494
        Top = 12
        Width = 115
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          105.833333333333
          1867.20238095238
          45.3571428571429
          434.672619047619)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'lTime3'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
      object lTime4: TQRLabel
        Left = 615
        Top = 12
        Width = 122
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          105.833333333333
          2324.55357142857
          45.3571428571429
          461.130952380952)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'lTime4'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        FontSize = 8
      end
    end
    object QRBand5: TQRBand
      Left = 13
      Top = 206
      Width = 760
      Height = 45
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        170.089285714286
        2872.61904761905)
      BandType = rbPageFooter
      object QRSysData3: TQRSysData
        Left = 691
        Top = 23
        Width = 34
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          49.1369047619048
          2611.81547619048
          86.9345238095238
          128.511904761905)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsPageNumber
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
        FontSize = 10
      end
      object QRSysData4: TQRSysData
        Left = 108
        Top = 25
        Width = 51
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          49.1369047619048
          408.214285714286
          94.4940476190476
          192.767857142857)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
        FontSize = 10
      end
      object lBuilded: TQRLabel
        Left = 17
        Top = 25
        Width = 87
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          64.2559523809524
          94.4940476190476
          328.839285714286)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Отчет сформирован:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lOneFio: TQRLabel
        Left = 210
        Top = 4
        Width = 442
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          793.75
          15.1190476190476
          1670.65476190476)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Представитель Энергонадзора   __________________________________' +
          '____________________________'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lTwoFio: TQRLabel
        Left = 210
        Top = 20
        Width = 442
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          793.75
          75.5952380952381
          1670.65476190476)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Представитель Потребителя     __________________________________' +
          '_____________________________'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lPage: TQRLabel
        Left = 679
        Top = 25
        Width = 18
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          2566.45833333333
          94.4940476190476
          68.0357142857143)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Стр.'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QuickRep2: TQuickRep
      Left = 0
      Top = 264
      Width = 786
      Height = 556
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Functions.Strings = (
        'PAGENUMBER'
        'COLUMNNUMBER'
        'REPORTTITLE')
      Functions.DATA = (
        '0'
        '0'
        #39#39)
      Options = [FirstPageHeader, LastPageFooter]
      Page.Columns = 1
      Page.Orientation = poLandscape
      Page.PaperSize = A4
      Page.Ruler = False
      Page.Values = (
        50
        2100
        50
        2970
        50
        50
        0)
      PrinterSettings.Copies = 1
      PrinterSettings.Duplex = False
      PrinterSettings.FirstPage = 0
      PrinterSettings.LastPage = 0
      PrinterSettings.OutputBin = Auto
      PrintIfEmpty = True
      SnapToGrid = True
      Units = MM
      Zoom = 70
      object QRBand4: TQRBand
        Left = 13
        Top = 65
        Width = 760
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          45.3571428571429
          2872.61904761905)
        BandType = rbDetail
        object QRShape39: TQRShape
          Left = 402
          Top = 0
          Width = 110
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1519.46428571429
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRShape27: TQRShape
          Left = 511
          Top = 0
          Width = 110
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1931.45833333333
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRShape30: TQRShape
          Left = 293
          Top = 0
          Width = 110
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1107.47023809524
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRShape31: TQRShape
          Left = 167
          Top = 0
          Width = 127
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            631.220238095238
            0
            480.029761904762)
          Shape = qrsRectangle
        end
        object QRShape32: TQRShape
          Left = 0
          Top = 0
          Width = 168
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            0
            0
            635)
          Shape = qrsRectangle
        end
        object QRShape37: TQRShape
          Left = 620
          Top = 0
          Width = 110
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            2343.45238095238
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRDBText7: TQRDBText
          Left = 170
          Top = 0
          Width = 120
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            642.559523809524
            0
            453.571428571429)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'Sum_Ts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRDBText8: TQRDBText
          Left = 298
          Top = 0
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1126.36904761905
            0
            377.97619047619)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'sum_T1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRDBText11: TQRDBText
          Left = 407
          Top = 0
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1538.3630952381
            0
            377.97619047619)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'sum_T2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRDBText13: TQRDBText
          Left = 626
          Top = 1
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            2366.13095238095
            3.7797619047619
            377.97619047619)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'sum_T4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRDBText15: TQRDBText
          Left = 517
          Top = 0
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1954.1369047619
            0
            377.97619047619)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'sum_T3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRDBText1: TQRDBText
          Left = 4
          Top = 0
          Width = 164
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            15.1190476190476
            0
            619.880952380952)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'eg_name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
      end
      object QRBand6: TQRBand
        Left = 13
        Top = 13
        Width = 760
        Height = 36
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          136.071428571429
          2872.61904761905)
        BandType = rbPageHeader
        object lProdUsers: TQRLabel
          Left = 7
          Top = 1
          Width = 139
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            26.4583333333333
            3.77976190476191
            525.386904761905)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'ООО "Автоматизация - 2000"'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 10
        end
        object QRLabelTitulSum: TQRLabel
          Left = 258
          Top = 12
          Width = 234
          Height = 14
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.9166666666667
            975.178571428571
            45.3571428571429
            884.464285714286)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Расход электроэнергии по субабонентам'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 12
        end
        object QRLabel8: TQRLabel
          Left = 599
          Top = 1
          Width = 125
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            2264.07738095238
            3.77976190476191
            472.470238095238)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'ООО Автоматизация-2000'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 10
        end
        object lDetails: TQRLabel
          Left = 663
          Top = 23
          Width = 59
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            2505.98214285714
            86.9345238095238
            223.005952380952)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'QRLabelDetail'
          Color = clWhite
          Transparent = True
          WordWrap = True
          FontSize = 10
        end
      end
      object QRBand8: TQRBand
        Left = 13
        Top = 77
        Width = 760
        Height = 45
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          170.089285714286
          2872.61904761905)
        BandType = rbPageFooter
        object QRSysData1: TQRSysData
          Left = 690
          Top = 21
          Width = 34
          Height = 13
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            49.1369047619048
            2608.03571428571
            79.375
            128.511904761905)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = True
          Color = clWhite
          Data = qrsPageNumber
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = False
          FontSize = 10
        end
        object QRSysData2: TQRSysData
          Left = 107
          Top = 23
          Width = 51
          Height = 13
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            49.1369047619048
            404.434523809524
            86.9345238095238
            192.767857142857)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          Color = clWhite
          Data = qrsDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = False
          FontSize = 10
        end
        object llBuilded: TQRLabel
          Left = 16
          Top = 23
          Width = 87
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            60.4761904761905
            86.9345238095238
            328.839285714286)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Отчет сформирован:'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object lOneFios: TQRLabel
          Left = 210
          Top = 4
          Width = 442
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            793.75
            15.1190476190476
            1670.65476190476)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 
            'Представитель Энергонадзора   __________________________________' +
            '____________________________'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object lTwoFios: TQRLabel
          Left = 210
          Top = 20
          Width = 442
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            793.75
            75.5952380952381
            1670.65476190476)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 
            'Представитель Потребителя     __________________________________' +
            '_____________________________'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object llPage: TQRLabel
          Left = 678
          Top = 23
          Width = 18
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            2562.67857142857
            86.9345238095238
            68.0357142857143)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Стр.'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object QRBand1: TQRBand
        Left = 13
        Top = 49
        Width = 760
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          60.4761904761905
          2872.61904761905)
        BandType = rbColumnHeader
        object QRShape43: TQRShape
          Left = 0
          Top = 0
          Width = 168
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            0
            0
            635)
          Shape = qrsRectangle
        end
        object llObject: TQRLabel
          Left = 43
          Top = 2
          Width = 27
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.7976190476191
            162.529761904762
            7.55952380952381
            102.053571428571)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Объект'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 8
        end
        object QRShape45: TQRShape
          Left = 167
          Top = 0
          Width = 127
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            631.220238095238
            0
            480.029761904762)
          Shape = qrsRectangle
        end
        object QRLabel24: TQRLabel
          Left = 167
          Top = 2
          Width = 127
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            631.220238095238
            7.55952380952381
            480.029761904762)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = 'Общее потребление  (кВтч, кВАрч)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRShape48: TQRShape
          Left = 293
          Top = 0
          Width = 110
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            1107.47023809524
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRLabel25: TQRLabel
          Left = 298
          Top = 2
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1126.36904761905
            7.55952380952381
            377.97619047619)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = 'Т1 - день (кВтч, кВАрч)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRShape49: TQRShape
          Left = 402
          Top = 0
          Width = 110
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            1519.46428571429
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRLabel26: TQRLabel
          Left = 407
          Top = 2
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1538.3630952381
            7.55952380952381
            377.97619047619)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = 'Т2 - ночь (кВтч, кВАрч)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRShape50: TQRShape
          Left = 511
          Top = 0
          Width = 110
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            1931.45833333333
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRLabel27: TQRLabel
          Left = 516
          Top = 2
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            1950.35714285714
            7.55952380952381
            377.97619047619)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = 'Т3 - пик (кВтч, кВАрч)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
        object QRShape57: TQRShape
          Left = 620
          Top = 0
          Width = 110
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            2343.45238095238
            0
            415.77380952381)
          Shape = qrsRectangle
        end
        object QRLabel28: TQRLabel
          Left = 625
          Top = 2
          Width = 100
          Height = 10
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            2362.35119047619
            7.55952380952381
            377.97619047619)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = 'Т4 - резерв (кВтч, кВАрч)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          FontSize = 8
        end
      end
      object blSum: TQRBand
        Left = 13
        Top = 122
        Width = 760
        Height = 46
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          173.869047619048
          2872.61904761905)
        BandType = rbGroupFooter
        object llOne: TQRLabel
          Left = 204
          Top = 6
          Width = 442
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            771.071428571429
            22.6785714285714
            1670.65476190476)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 
            'Представитель Энергонадзора   __________________________________' +
            '____________________________'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object llTwo: TQRLabel
          Left = 204
          Top = 22
          Width = 442
          Height = 12
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            45.3571428571429
            771.071428571429
            83.1547619047619
            1670.65476190476)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 
            'Представитель Потребителя     __________________________________' +
            '_____________________________'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
    end
    object bSum: TQRBand
      Left = 13
      Top = 160
      Width = 760
      Height = 46
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        173.869047619048
        2872.61904761905)
      BandType = rbSummary
      object lOne: TQRLabel
        Left = 204
        Top = 6
        Width = 442
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          771.071428571429
          22.6785714285714
          1670.65476190476)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Представитель Энергонадзора   __________________________________' +
          '____________________________'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lTwo: TQRLabel
        Left = 204
        Top = 22
        Width = 442
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          45.3571428571429
          771.071428571429
          83.1547619047619
          1670.65476190476)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 
          'Представитель Потребителя     __________________________________' +
          '_____________________________'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object QRLabel2: TQRLabel
    Left = 734
    Top = 1
    Width = 300
    Height = 17
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      45.3571428571429
      1942.79761904762
      3.7797619047619
      793.75)
    Alignment = taRightJustify
    AlignToBand = False
    AutoSize = True
    AutoStretch = False
    Caption = 'АРМ Энергетика. ООО Автоматизация-2000'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = False
    WordWrap = True
    FontSize = 10
  end
end
