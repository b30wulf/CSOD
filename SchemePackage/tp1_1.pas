unit tp1_1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tftp1_1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftp1_1: Tftp1_1;

implementation

{$R *.DFM}

procedure Tftp1_1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     ftp1_1:= Nil;
end;

end.
