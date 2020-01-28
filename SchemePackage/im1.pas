unit im1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfim1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fim1: Tfim1;

implementation

{$R *.DFM}

procedure Tfim1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     fim1:= Nil;
end;

end.
