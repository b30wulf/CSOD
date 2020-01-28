program Rchdrag;

uses
  Forms,
  Dragitem in 'DRAGITEM.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'Dragging of Parts of the Data';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
