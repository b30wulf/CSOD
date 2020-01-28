unit ctp2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfctp2 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fctp2: Tfctp2;

implementation

{$R *.DFM}


procedure Tfctp2.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     fctp2  := Nil;
end;

end.
