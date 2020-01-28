unit tp1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tctp1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ctp1: Tctp1;

implementation

{$R *.DFM}

procedure Tctp1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     ctp1:= Nil;
end;

end.
