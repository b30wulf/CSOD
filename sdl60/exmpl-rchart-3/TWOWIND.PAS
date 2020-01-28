unit TwoWind;

{-------------------------------------------------------------------}
interface
{-------------------------------------------------------------------}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ColorGrd, ExtCtrls, StdCtrls, RChart, Buttons;

type
  TTwoWinForm = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    RChart1: TRChart;
    RChart2: TRChart;
    Button2: TButton;
    Bevel1: TBevel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button4Click(Sender: TObject);
  private
    Abort : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TwoWinForm: TTwoWinForm;

{-------------------------------------------------------------------}
implementation
{-------------------------------------------------------------------}

{$R *.DFM}

(*******************************************************************)
procedure TTwoWinForm.Button1Click(Sender: TObject);
(*******************************************************************)

const
  MaxJ = 66;

var
  i,j   : integer;
  signi : integer;

begin
RChart2.RangeLoX := -3;
RChart2.RangeHiX := 3;
RChart2.RangeLoY := 0;
RChart2.RangeHiY := 110;
Button1.Enabled := false;
Button2.Enabled := true;
Button3.Enabled := false;
j:=1;
signi := 1;
abort := false;
while not abort do
  begin
  RChart1.ClearGraf;                              { window 1 }
  RCHart1.MarkAt (sin((j)/9),sin((j)/7),19);
  RCHart1.MoveTo (sin((j)/9),sin((j)/7));
  for i:=1 to 25 do
    begin
    RCHart1.DrawTo (sin((i+j)/9),sin((i+j)/7));
    RCHart1.MarkAt (sin((i+j)/9),sin((i+j)/7),19);
    end;
  RChart1.ShowGraf;

  RChart2.ClearGraf;                              { window 2 }
  RChart2.MoveTo (0,0);
  RChart2.DataColor := clblack;
  for i:=1 to 50 do
    RCHart2.DrawTo (exp(i/150)*sin(i*j/800),i);
  RChart2.DataColor := clWhite;
  for i:=51 to 100 do
    RCHart2.DrawTo (exp(i/150)*sin(i*j/800),i);
  RChart2.ShowGraf;

  j := j+signi;
  if j > MaxJ then
    Signi := -1;
  if j < -MaxJ then
    Signi := +1;
  Application.ProcessMessages;
  end;
Button2.Enabled := false;
Button1.Enabled := true;
Button3.Enabled := true;
end;

(*******************************************************************)
procedure TTwoWinForm.Button2Click(Sender: TObject);
(*******************************************************************)

begin
Button2.Enabled := false;
Button1.Enabled := true;
Button3.Enabled := true;
Abort := True;
end;

(*******************************************************************)
procedure TTwoWinForm.Button3Click(Sender: TObject);
(*******************************************************************)

begin
close;
end;

(*******************************************************************)
procedure TTwoWinForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
(*******************************************************************)

begin
Screen.Cursor := crDefault;
end;

(*******************************************************************)
procedure TTwoWinForm.Button4Click(Sender: TObject);
(*******************************************************************)

begin
RChart1.CopyToClipBoard (false);
end;

end.
