unit teplo1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfteplo1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fteplo1: Tfteplo1;

implementation

{$R *.DFM}

procedure Tfteplo1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     fteplo1:= Nil;
end;

end.
