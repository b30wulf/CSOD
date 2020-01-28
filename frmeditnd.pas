unit frmeditnd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RbDrawCore, RbButton, ComCtrls, jpeg, ExtCtrls;

type
  TfrmEditNode = class(TForm)
    pcEditNode: TPageControl;
    Image1: TImage;
    Image2: TImage;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RbButton1: TRbButton;
    RbButton2: TRbButton;
    RbButton3: TRbButton;
    RbButton4: TRbButton;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    clbEditNode: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditNode: TfrmEditNode;

implementation

{$R *.DFM}

end.
