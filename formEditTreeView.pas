unit formEditTreeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmEditTreeView;

type
  TFEditTreeView = class(TForm)
    frameEditTreeView: TFrameEditTreeView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEditTreeView: TFEditTreeView;

implementation

{$R *.DFM}


procedure TFEditTreeView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if frameEditTreeView <> nil then frameEditTreeView.fRAYON.ClearRayon;
end;

procedure TFEditTreeView.FormActivate(Sender: TObject);
begin
  if frameEditTreeView.REGIN = -1 then begin
    frameEditTreeView.fREGIN.ComboBox.SetFocus;
    Exit;
  end else begin
    if frameEditTreeView.RAYON = -1 then begin
      frameEditTreeView.fRAYON.ComboBox.SetFocus;
      Exit;
    end else begin
      if frameEditTreeView.TOWNS = -1 then Begin
        frameEditTreeView.fTOWNS.ComboBox.SetFocus;
        Exit;
      end else begin
        if frameEditTreeView.TPODS = -1 then begin
          frameEditTreeView.fTPODS.ComboBox.SetFocus;
          Exit;
        end else begin
          if frameEditTreeView.STRET = -1 then begin
            frameEditTreeView.fSTRET.ComboBox.SetFocus;
            Exit;
          end else begin
            if frameEditTreeView.ABONT = -1 then begin
              frameEditTreeView.fABONT.ComboBox.SetFocus;
              Exit;
            end else begin
              frameEditTreeView.fABONT.ComboBox.SetFocus;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

end.
