object fRepCorrect: TfRepCorrect
  Left = 0
  Top = 0
  Width = 698
  Height = 218
  TabOrder = 0
  object rgTarif: TRadioGroup
    Left = 513
    Top = 0
    Width = 185
    Height = 201
    Align = alRight
    Caption = '������'
    Items.Strings = (
      '���������'
      '����� 1'
      '����� 2'
      '����� 3'
      '����� 4')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 513
    Height = 201
    Align = alClient
    TabOrder = 1
    object grp2: TGroupBox
      Left = 1
      Top = 138
      Width = 416
      Height = 62
      Align = alClient
      Caption = '������� �����'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 33
        Height = 13
        Caption = '�����'
      end
      object Label2: TLabel
        Left = 8
        Top = 44
        Width = 18
        Height = 13
        Caption = '���'
      end
      object cbbMonth: TComboBox
        Left = 48
        Top = 20
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'cbbMonth'
        Items.Strings = (
          '������'
          '�������'
          '����'
          '������'
          '���'
          '����'
          '����'
          '������'
          '��������'
          '�������'
          '������'
          '�������')
      end
      object cbbYear: TComboBox
        Left = 48
        Top = 40
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'cbbYear'
      end
      object btnRun: TBitBtn
        Left = 206
        Top = 21
        Width = 203
        Height = 25
        Caption = '���������� ������'
        TabOrder = 2
        OnClick = btnRunClick
      end
    end
    object grp1: TGroupBox
      Left = 1
      Top = 1
      Width = 511
      Height = 137
      Align = alTop
      Caption = '������������ ���������'
      TabOrder = 1
      object chk0: TCheckBox
        Left = 8
        Top = 16
        Width = 417
        Height = 17
        Caption = '������� �������� (����� 0.00)'
        TabOrder = 0
      end
      object chkMinus: TCheckBox
        Left = 8
        Top = 32
        Width = 457
        Height = 17
        Caption = '�������� ������� �� ������� ����� ��������� �� ����������'
        TabOrder = 1
      end
      object chkEqually: TCheckBox
        Left = 8
        Top = 48
        Width = 481
        Height = 17
        Caption = 
          '�������� ������� �� ������� ����� ����� �� ���������� (������� �' +
          '� ��������������)'
        TabOrder = 2
      end
      object chkMax: TCheckBox
        Left = 8
        Top = 64
        Width = 489
        Height = 17
        Caption = '�������� ������� ������� �� ������� ����� ���������'
        TabOrder = 3
      end
      object edtMax: TEdit
        Left = 327
        Top = 62
        Width = 73
        Height = 21
        TabOrder = 4
        Text = 'edtMax'
      end
      object chkNULL: TCheckBox
        Left = 8
        Top = 80
        Width = 489
        Height = 17
        Caption = '�������� � ������� ������� �� ������� ����� �� ������� � ��'
        TabOrder = 5
      end
    end
    object rgEnergy: TRadioGroup
      Left = 417
      Top = 138
      Width = 95
      Height = 62
      Align = alRight
      Caption = '�������'
      Items.Strings = (
        'A+'
        'A-'
        'R+'
        'R-')
      TabOrder = 2
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 201
    Width = 698
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 2
  end
end
