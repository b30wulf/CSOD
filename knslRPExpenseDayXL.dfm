object rpExpenseDayXL: TrpExpenseDayXL
  Left = 865
  Top = 262
  Width = 244
  Height = 253
  Caption = 'rpExpenseDayXL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ExcelOLEObject1: TExcelOLEObject
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 32
    Top = 24
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 40
    Top = 96
  end
  object ExcelWorkbook1: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 120
    Top = 24
  end
end
