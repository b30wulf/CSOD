program LOG_Project;

uses
  Forms,
  LOG_unit in 'LOG_unit.pas' {Form1},
  fBases in 'fBases.pas' {Bases: TDataModule},
  fLogFile in 'fLogFile.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TBases, Bases);
  Application.Run;
end.
