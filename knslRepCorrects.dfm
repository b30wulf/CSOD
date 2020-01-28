object knslRepCorrect: TknslRepCorrect
  Left = 680
  Top = 271
  Width = 632
  Height = 276
  Caption = 'knslRepCorrect'
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
  inline fRepCorrect1: TfRepCorrect
    Width = 624
    Height = 242
    Align = alClient
    inherited rgTarif: TRadioGroup
      Left = 494
      Width = 130
      Height = 225
    end
    inherited Panel1: TPanel
      Width = 494
      Height = 225
      inherited grp2: TGroupBox
        Width = 397
        Height = 86
        inherited btnRun: TBitBtn
          Width = 162
        end
      end
      inherited grp1: TGroupBox
        Width = 492
      end
      inherited rgEnergy: TRadioGroup
        Left = 398
        Height = 86
      end
    end
    inherited ProgressBar1: TProgressBar
      Top = 225
      Width = 624
    end
  end
end
