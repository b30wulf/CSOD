program Rch2win;

uses
  Forms,
  Twowind in 'TWOWIND.PAS' {TwoWinForm};

{$R *.RES}

begin
  Application.Title := 'RCH2WIN';
  Application.CreateForm(TTwoWinForm, TwoWinForm);
  Application.Run;
end.
