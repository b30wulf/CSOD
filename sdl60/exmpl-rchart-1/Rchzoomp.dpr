program RCHzoomp;

uses
  Forms,
  Zoomit in 'ZOOMIT.PAS' {Form1},
  LogWarn in 'LOGWARN.PAS' {LogWarnForm};

{$R *.RES}

begin
  Application.Title := 'Example of Zooming and Panning';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TLogWarnForm, LogWarnForm);
  Application.Run;
end.
