object LogView: TLogView
  Left = 312
  Top = 144
  Width = 746
  Height = 375
  Caption = 'LogView'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 738
    Height = 41
    Align = alTop
    Caption = 'Список действий'
    TabOrder = 0
    object BeginTimeLabel: TLabel
      Left = 513
      Top = 13
      Width = 7
      Height = 13
      Anchors = [akRight]
      Caption = 'С'
    end
    object EndTimeLabel: TLabel
      Left = 617
      Top = 13
      Width = 14
      Height = 13
      Anchors = [akRight]
      Caption = 'По'
    end
    object BeginTime: TDateTimePicker
      Left = 528
      Top = 8
      Width = 81
      Height = 21
      Anchors = [akRight]
      CalAlignment = dtaLeft
      Date = 43444.3945615509
      Time = 43444.3945615509
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
      OnChange = BeginTimeChange
    end
    object EndTime: TDateTimePicker
      Left = 640
      Top = 8
      Width = 81
      Height = 21
      Anchors = [akRight]
      CalAlignment = dtaLeft
      Date = 43444.3948035185
      Time = 43444.3948035185
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
      OnChange = EndTimeChange
    end
  end
  object LOGRich: TRichEdit
    Left = 0
    Top = 41
    Width = 738
    Height = 300
    Align = alClient
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
