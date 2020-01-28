object FEditTreeView: TFEditTreeView
  Left = 542
  Top = 226
  Width = 985
  Height = 517
  Caption = 'FEditTreeView'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inline frameEditTreeView: TFrameEditTreeView
    Width = 977
    Height = 483
    Align = alClient
    inherited TSVmeter: TAdvOfficePager
      Width = 977
      Height = 483
      NextPictureChanged = False
      PrevPictureChanged = False
      inherited TSAddress: TAdvOfficePage
        Width = 975
        Height = 455
        inherited AdvPanel1: TAdvPanel
          Height = 451
          FullHeight = 0
          inherited fREGIN: TframeFETW
            inherited Panel: TAdvPanel
              FullHeight = 68
            end
          end
          inherited fRAYON: TframeFETW
            inherited Panel: TAdvPanel
              FullHeight = 68
            end
          end
          inherited fTOWNS: TframeFETW
            inherited Panel: TAdvPanel
              FullHeight = 68
            end
          end
          inherited fTPODS: TframeFETW
            inherited Panel: TAdvPanel
              FullHeight = 68
            end
          end
          inherited fSTRET: TframeFETW
            inherited Panel: TAdvPanel
              FullHeight = 68
            end
          end
          inherited fABONT: TframeFETW
            inherited Panel: TAdvPanel
              FullHeight = 68
            end
          end
        end
        inherited pnlAddressRight: TAdvPanel
          Width = 620
          Height = 451
          FullHeight = 0
          inherited pnlAddressTop: TAdvPanel
            Width = 620
            FullHeight = 0
            inherited lblAddress: TLabel
              Width = 620
            end
          end
          inherited lstAddress: TListBox
            Width = 620
            Height = 420
          end
        end
      end
      inherited TSAbon: TAdvOfficePage
        Width = 975
        Height = 455
      end
      inherited TSHome: TAdvOfficePage
        Width = 975
        Height = 455
      end
    end
  end
end
