program Rchmouse;

uses
  Forms,
  Timser in 'TIMSER.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'Mouse Labels / Printout';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
