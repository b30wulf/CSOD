program Rchmovel;

uses
  Forms,
  Rchmov1 in 'RCHMOV1.PAS' {Form1},
  LogWarn in 'LOGWARN.PAS' {LogWarnForm};

{$R *.RES}

begin
  Application.Title := 'Moving objects';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TLogWarnForm, LogWarnForm);
  Application.Run;
end.
