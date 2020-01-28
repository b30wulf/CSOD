unit Zoomit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, printers, ExtCtrls, Buttons, RChart;

type
  TForm1 = class(TForm)
    But07: TButton;
    But14: TButton;
    GroupBox1: TGroupBox;
    RBPan: TRadioButton;
    RBZoom: TRadioButton;
    RBZoomPanOff: TRadioButton;
    RBZoomWind: TRadioButton;
    PnlHints: TPanel;
    Bevel1: TBevel;
    ButNorm: TButton;
    BBtDone: TBitBtn;
    CBLogX: TCheckBox;
    CBLogY: TCheckBox;
    RBZoomWindPos: TRadioButton;
    RChart1: TRChart;
    ComboBox1: TComboBox;
    CBConfine: TCheckBox;
    CBoxIsometric: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure But14Click(Sender: TObject);
    procedure But07Click(Sender: TObject);
    procedure RBZoomPanOffClick(Sender: TObject);
    procedure RBPanClick(Sender: TObject);
    procedure RBZoomClick(Sender: TObject);
    procedure RBZoomWindClick(Sender: TObject);
    procedure ButNormClick(Sender: TObject);
    procedure BBtDoneClick(Sender: TObject);
    procedure CBLogXClick(Sender: TObject);
    procedure CBLogYClick(Sender: TObject);
    procedure RBZoomWindPosClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure CBConfineClick(Sender: TObject);
    procedure CBoxIsometricClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses LogWarn;

{$R *.DFM}

const
  Numval = 300;

(*******************************************************************)
procedure TForm1.FormActivate(Sender: TObject);
(*******************************************************************)

var
  i : integer;

begin
RBZoomPanOff.Checked := true;
PnlHints.Caption := 'Select from Zoom Mode box to use interactive zooming and panning';
RChart1.SetRange (0,-60,NumVal,110);
RCHart1.MoveTo (0,0);
for i:=1 to NumVal do
  RChart1.DrawTo (i,i/10+i/30*sin(i*0.04)+20*(random+random));
RChart1.DataColor := clRed;
RChart1.MoveTo (0,5);
for i:=1 to NumVal do
    RChart1.DrawTo (i,5+i/10*sin(i*0.05)*cos(i*0.04));
RChart1.DataColor := clBlue;
for i:=1 to NumVal do
  if i mod 4 = 0 then
    RChart1.MarkAt (i,i/5*cos(i*0.05),4);
end;





(*******************************************************************)
procedure TForm1.But14Click(Sender: TObject);
(*******************************************************************)

var
  MidX, MidY, rx, ry : single;

begin
with RChart1 do
  begin
  MidX := (RangeHiX+RangeLoX)/2;
  MidY := (RangeHiY+RangeLoY)/2;
  rx := (RangeHiX-RangeLoX)/2.8;
  ry := (RangeHiY-RangeLoY)/2.8;
  SetRange (MidX-rx,MidY-ry,MidX+rx,MidY+ry);
  ShowGraf;
  end;
end;

(*******************************************************************)
procedure TForm1.But07Click(Sender: TObject);
(*******************************************************************)

var
  MidX, MidY, rx, ry : single;

begin
with RChart1 do
  begin
  MidX := (RangeHiX+RangeLoX)/2;
  MidY := (RangeHiY+RangeLoY)/2;
  rx := 1.4*(RangeHiX-RangeLoX)/2;
  ry := 1.4*(RangeHiY-RangeLoY)/2;
  SetRange (MidX-rx,MidY-ry,MidX+rx,MidY+ry);
  ShowGraf;
  end;
end;


(*******************************************************************)
procedure TForm1.RBZoomPanOffClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.MouseAction := maNone;
PnlHints.Caption := 'Select from Zoom Mode box to use interactive zooming and panning';
end;

(*******************************************************************)
procedure TForm1.RBPanClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.MouseAction := maPan;
PnlHints.Caption := 'maPan: Click and drag on graphics';
end;

(*******************************************************************)
procedure TForm1.RBZoomClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.MouseAction := maZoomDrag;
PnlHints.Caption := 'maZoomDrag: Click and drag on graphics';
end;

(*******************************************************************)
procedure TForm1.RBZoomWindClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.MouseAction := maZoomWind;
PnlHints.Caption := 'maZoomWind: Click on graphics area to define window corners';
end;

(*******************************************************************)
procedure TForm1.RBZoomWindPosClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.MouseAction := maZoomWindPos;
PnlHints.Caption := 'maZoomWindPos: Click on graphics area to define window corners';
end;


(*******************************************************************)
procedure TForm1.ButNormClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.LogScaleX := false;
RChart1.LogScaleY := false;
CbLogX.Checked := false;
CbLogY.Checked := false;
RChart1.SetRange (0,-60,NumVal,110);
end;


(*******************************************************************)
procedure TForm1.BBtDoneClick(Sender: TObject);
(*******************************************************************)

begin
close;
end;

(*******************************************************************)
procedure TForm1.CBLogXClick(Sender: TObject);
(*******************************************************************)

begin
if not CBLogX.Checked and (RChart1.RangeLoX <= 0)
  then begin
       LogWarnForm.ShowModal;
       CBLogX.Checked := false;
       end
  else begin
       RChart1.LogScaleX := CBLogX.Checked;
       CBLogX.Checked := RChart1.LogScaleX;
       end;
end;

(*******************************************************************)
procedure TForm1.CBLogYClick(Sender: TObject);
(*******************************************************************)

begin
if not CBLogY.Checked and (RChart1.RangeLoY <= 0)
  then begin
       LogWarnForm.ShowModal;
       CBLogY.Checked := false;
       end
  else begin
       RChart1.LogScaleY := CBLogY.Checked;
       CBLogY.Checked := RChart1.LogScaleY;
       end;
end;


(*******************************************************************)
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
(*******************************************************************)

begin
Screen.Cursor := crDefault;
end;

(*******************************************************************)
procedure TForm1.ComboBox1Change(Sender: TObject);
(*******************************************************************)

begin
RChart1.ZoomHistory (-ComboBox1.ItemIndex);
end;

(*******************************************************************)
procedure TForm1.CBConfineClick(Sender: TObject);
(*******************************************************************)

begin
if CBConfine.Checked
  then Rchart1.ConfineZoomRange (-NumVal/2,-100,1.5*NumVal,150)
  else Rchart1.ConfineZoomRange (0,0,0,0);
end;

(*******************************************************************)
procedure TForm1.CBoxIsometricClick(Sender: TObject);
(*******************************************************************)

begin
RChart1.Isometric := CBoxIsometric.Checked;
end;

end.
