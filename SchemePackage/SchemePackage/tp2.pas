unit tp2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tftp2 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftp2: Tftp2;

implementation

{$R *.DFM}

procedure Tftp2.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     ftp2:= Nil;
end;

end.
