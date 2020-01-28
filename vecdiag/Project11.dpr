program Project11;

uses
  Forms,
  Unit1 in '..\..\..\Projects\PC\asd\Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
