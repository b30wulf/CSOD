unit gppb1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfgppb1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fgppb1: Tfgppb1;

implementation

{$R *.DFM}

procedure Tfgppb1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     fgppb1:= Nil;
end;

end.
