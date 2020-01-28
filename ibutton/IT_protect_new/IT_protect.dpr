program IT_protect;

uses
  Forms,
  complex_test in 'complex_test.pas' {FrmMain},
  u_Crypt in 'u_Crypt.pas',
  uEdUser in 'uEdUser.pas' {FrmUsEd},
  u_iButTMEX in 'u_iButTMEX.pas',
  uCopyIB in 'uCopyIB.pas' {FrmCopyIB};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
