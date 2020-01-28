unit knslRepCorrects;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmRepCorrect, ComCtrls;

type
  TknslRepCorrect = class(TForm)
    fRepCorrect1: TfRepCorrect;
    procedure FormActivate(Sender: TObject);
    procedure fRepCorrect1btnRunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  knslRepCorrect: TknslRepCorrect;

implementation

{$R *.DFM}

procedure TknslRepCorrect.FormActivate(Sender: TObject);
begin
  fRepCorrect1.init;
  Caption := 'Отчет по ошибкам: ' + fRepCorrect1.NameRES;
end;

procedure TknslRepCorrect.fRepCorrect1btnRunClick(Sender: TObject);
begin
  fRepCorrect1.btnRunClick(Sender);
end;

end.
