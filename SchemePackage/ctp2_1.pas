unit ctp2_1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfctp2_1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fctp2_1: Tfctp2_1;

implementation

{$R *.DFM}

procedure Tfctp2_1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     fctp2_1:= Nil;
end;

end.
