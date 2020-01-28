unit uCopyIB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFrmCopyIB = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    src1: TRadioButton;
    src2: TRadioButton;
    dest1: TRadioButton;
    dest2: TRadioButton;
    Button3: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCopyIB: TFrmCopyIB;

implementation

{$R *.DFM}

end.
