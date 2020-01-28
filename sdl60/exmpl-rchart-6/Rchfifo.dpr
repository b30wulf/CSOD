program Rchfifo;

uses
  Forms,
  Fifomain in 'FIFOMAIN.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
