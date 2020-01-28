program fft;

uses
  Forms,
  frmfft in 'frmfft.pas' {Form1};

{$R *.RES}

begin
{$IFNDEF VER80}
  Application.Initialize;
{$ENDIF}
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
