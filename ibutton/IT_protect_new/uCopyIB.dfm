object FrmCopyIB: TFrmCopyIB
  Left = 7
  Top = 178
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'FrmCopyIB'
  ClientHeight = 180
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 166
    Top = 144
    Width = 113
    Height = 25
    Caption = 'Копировать НСИ'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 352
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 450
    Height = 137
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 225
      Height = 135
      Align = alLeft
      Caption = 'Источник'
      TabOrder = 0
      object src1: TRadioButton
        Left = 12
        Top = 21
        Width = 193
        Height = 17
        Caption = 'src1'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object src2: TRadioButton
        Left = 12
        Top = 61
        Width = 193
        Height = 17
        Caption = 'src1'
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 224
      Top = 1
      Width = 225
      Height = 135
      Align = alRight
      Caption = 'Приемник'
      TabOrder = 1
      object dest1: TRadioButton
        Left = 12
        Top = 21
        Width = 193
        Height = 17
        Caption = 'src1'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object dest2: TRadioButton
        Left = 12
        Top = 61
        Width = 193
        Height = 17
        Caption = 'src1'
        TabOrder = 1
      end
    end
  end
  object Button3: TButton
    Left = 8
    Top = 144
    Width = 113
    Height = 25
    Caption = 'Переопрос iButton'
    ModalResult = -1
    TabOrder = 3
  end
end
