unit PrintDiallogEx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, printers;

type
  TPrintDialogEx = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    ComboBox1: TComboBox;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    Label3: TLabel;
    RadioButton2: TRadioButton;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label4: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDialogEx: TPrintDialogEx;
  Printr       : TPrinter;

implementation

{$R *.DFM}

procedure TPrintDialogEx.FormCreate(Sender: TObject);
begin
   Printr               := Printer;
   ComboBox1.Items      := Printr.Printers;
   RadioButton1.Checked := true;
   Image1.Canvas.FloodFill(0, 0, clWhite, fsSurface);
end;

end.
