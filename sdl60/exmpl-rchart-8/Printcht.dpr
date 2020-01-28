program Printcht;

uses
  Forms,
  Frmprint in 'FRMPRINT.PAS' {Form1},
  rcproped in '..\rcproped.pas' {rcBakBMPEditor};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
