object FrmUsEd: TFrmUsEd
  Left = 18
  Top = 505
  BorderStyle = bsToolWindow
  Caption = 'Редактирование параметров пользователя'
  ClientHeight = 74
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 280
    Top = 16
    Width = 105
    Height = 22
    Caption = 'Применить'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 280
    Top = 46
    Width = 105
    Height = 22
    Caption = 'Отмена'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 9
    Top = 3
    Width = 246
    Height = 13
    Caption = 'Пользователь                  пароль            повторно'
  end
  object CheckBox1: TCheckBox
    Left = 103
    Top = 17
    Width = 17
    Height = 17
    TabOrder = 7
    OnClick = CheckBox1Click
  end
  object EdUName: TEdit
    Left = 8
    Top = 16
    Width = 89
    Height = 21
    TabOrder = 0
    Text = '000000000000'
  end
  object EdUPass: TEdit
    Left = 117
    Top = 16
    Width = 73
    Height = 21
    Enabled = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 39
    Width = 73
    Height = 17
    Caption = 'Оператор'
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Tag = 1
    Left = 162
    Top = 39
    Width = 106
    Height = 17
    Caption = 'Пользователь'
    TabOrder = 3
    OnClick = RadioButton1Click
  end
  object RadioButton3: TRadioButton
    Tag = 3
    Left = 8
    Top = 56
    Width = 145
    Height = 17
    Caption = 'Опытный пользователь'
    TabOrder = 4
    OnClick = RadioButton1Click
  end
  object RadioButton4: TRadioButton
    Tag = 7
    Left = 162
    Top = 56
    Width = 106
    Height = 17
    Caption = 'Администратор'
    TabOrder = 5
    OnClick = RadioButton1Click
  end
  object EdUpass2: TEdit
    Left = 193
    Top = 16
    Width = 73
    Height = 21
    Enabled = False
    PasswordChar = '*'
    TabOrder = 6
  end
end
