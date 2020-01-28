unit gppb2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfgppb2 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fgppb2: Tfgppb2;

implementation

{$R *.DFM}

procedure Tfgppb2.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     fgppb2:= Nil;
end;

end.
