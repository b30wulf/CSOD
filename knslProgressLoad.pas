unit knslProgressLoad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,StdCtrls, {rtflabel,}ExtCtrls,knsl5config, GradientLabel,
  AdvGlowButton, AdvPanel;

type
  TProgressLoad = class(TForm)
    AdvPanel1: TAdvPanel;
    ProgressBar1: TProgressBar;
    AdvGlowButton1: TAdvGlowButton;
    GradientLabel1: TGradientLabel;
    procedure FormCreate(Sender: TObject);
    procedure BreakProcess(Sender: TObject);
  private
     { Private declarations }
  public
    OnBreak:boolean;
    { Public declarations }
  end;

var
  ProgressLoad: TProgressLoad;

implementation

{$R *.DFM}

procedure TProgressLoad.BreakProcess(Sender: TObject);
begin
    OnBreak := true;
end;

procedure TProgressLoad.FormCreate(Sender: TObject);
begin
  OnBreak := false;
end;

end.
