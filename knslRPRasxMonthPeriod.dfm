object RasxMonthPeriod: TRasxMonthPeriod
  Left = 488
  Top = 103
  Width = 632
  Height = 326
  Caption = 'RasxMonthPeriod'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 275
    Align = alLeft
    TabOrder = 0
    object gbDailyReport: TGroupBox
      Left = 1
      Top = 1
      Width = 279
      Height = 176
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 27
        Width = 81
        Height = 13
        Caption = 'Начальная дата'
      end
      object Label4: TLabel
        Left = 8
        Top = 60
        Width = 74
        Height = 13
        Caption = 'Конечная дата'
      end
      object dtpBeginDaily: TDateTimePicker
        Left = 112
        Top = 24
        Width = 161
        Height = 21
        CalAlignment = dtaLeft
        Date = 43682.4713348148
        Time = 43682.4713348148
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object dtpEndDaily: TDateTimePicker
        Left = 112
        Top = 56
        Width = 162
        Height = 21
        CalAlignment = dtaLeft
        Date = 43682.722259294
        Time = 43682.722259294
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
    end
    object gbPeriodReport: TGroupBox
      Left = 1
      Top = 177
      Width = 279
      Height = 97
      Align = alClient
      Caption = 'gbPeriodReport'
      Enabled = False
      TabOrder = 1
      object Label2: TLabel
        Left = 8
        Top = 27
        Width = 33
        Height = 13
        Caption = 'Месяц'
      end
      object Label3: TLabel
        Left = 8
        Top = 59
        Width = 18
        Height = 13
        Caption = 'Год'
      end
      object cbbMonth: TComboBox
        Left = 112
        Top = 24
        Width = 161
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'Январь'
          'Февраль'
          'Март'
          'Апрель'
          'Май'
          'Июнь'
          'Июль'
          'Август'
          'Сентябрь'
          'Октябрь'
          'Ноябрь'
          'Декабрь')
      end
      object cbbYear: TComboBox
        Left = 112
        Top = 56
        Width = 161
        Height = 21
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object rbDailyReport: TRadioButton
    Left = 8
    Top = 0
    Width = 113
    Height = 17
    Caption = 'Отчет за сутки'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = rbReportClick
  end
  object rbPeriodReport: TRadioButton
    Left = 8
    Top = 176
    Width = 113
    Height = 17
    Caption = 'Отчет за период'
    TabOrder = 2
    OnClick = rbReportClick
  end
  object gbTarif: TGroupBox
    Left = 281
    Top = 0
    Width = 343
    Height = 275
    Align = alClient
    Caption = 'Показывать в отчете'
    TabOrder = 3
    object chkTarif1: TCheckBox
      Left = 8
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Тариф Т1'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkTarif2: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Тариф Т2'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkTarif3: TCheckBox
      Left = 8
      Top = 72
      Width = 97
      Height = 17
      Caption = 'Тариф Т3'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkTarif4: TCheckBox
      Left = 8
      Top = 96
      Width = 97
      Height = 17
      Caption = 'Тариф Т4'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chkTarifS: TCheckBox
      Left = 8
      Top = 120
      Width = 129
      Height = 17
      Caption = 'Тариф Тs (Сумма)'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object btnCreateReport: TBitBtn
      Left = 138
      Top = 239
      Width = 195
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Создать отчет'
      TabOrder = 5
      OnClick = btnCreateReportClick
    end
    object chkActPlus: TCheckBox
      Left = 208
      Top = 24
      Width = 97
      Height = 17
      Caption = 'A+ (кВт·ч)'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chkActMinus: TCheckBox
      Left = 208
      Top = 48
      Width = 97
      Height = 17
      Caption = 'A- (кВт·ч)'
      TabOrder = 7
    end
    object chkReactPlus: TCheckBox
      Left = 208
      Top = 72
      Width = 97
      Height = 17
      Caption = 'R+ (кВа·ч)'
      TabOrder = 8
    end
    object chkReactMinus: TCheckBox
      Left = 208
      Top = 96
      Width = 97
      Height = 17
      Caption = 'R- (кВа·ч)'
      TabOrder = 9
    end
  end
  object PgBar: TProgressBar
    Left = 0
    Top = 275
    Width = 624
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 4
  end
end
