program Project1;

uses
  Forms,
  kp_9 in 'kp_9.pas' {Form1},
  main in 'main.pas' {fmain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
