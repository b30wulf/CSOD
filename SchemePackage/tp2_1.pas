unit tp2_1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tftp2_1 = class(TForm)
    Image1: TImage;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftp2_1: Tftp2_1;

implementation

{$R *.DFM}

procedure Tftp2_1.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
      ftp2_1:= Nil;

end;

end.
