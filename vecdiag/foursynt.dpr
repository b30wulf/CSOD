Program foursynt;

uses
  Forms,
  umainfrm in 'umainfrm.pas' {Form1},
  spline3 in 'spline3.pas',
  Ap in 'ap.pas',
  rchart in 'C:\Delphi5\C4\sdl60\rchart.pas',
  IEEE754 in 'IEEE754.pas';

{$R *.RES}

Begin
{$IFNDEF VER80}
  Application.Initialize;
{$ENDIF}
  Application.CreateForm(TForm1, Form1);
  Application.Run;
End.

