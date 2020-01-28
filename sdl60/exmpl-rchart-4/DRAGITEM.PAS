unit DragItem;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, RChart, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    RChart1: TRChart;
    BBtDone: TBitBtn;
    SbMark: TSpeedButton;
    SBDrag: TSpeedButton;
    SBClearMarks: TSpeedButton;
    PnlStat: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure BBtDoneClick(Sender: TObject);
    procedure RChart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SbMarkClick(Sender: TObject);
    procedure SBDragClick(Sender: TObject);
    procedure SBClearMarksClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MarkedMove : boolean;
  FirstMove  : boolean;
  LastPosX,
  LastPosY   : integer;

implementation

{$R *.DFM}

(*******************************************************************)
procedure TForm1.FormActivate(Sender: TObject);
(*******************************************************************)

const
  Numval = 200;

var
  i : integer;

begin
RChart1.RangeHiX := NumVal;
RChart1.RangeLoX := 0;
RChart1.RangeHiY := 10;
RChart1.RangeLoY := -10;
RChart1.DataColor := clRed;
for i:=1 to NumVal do
  RChart1.MarkAt (i,i/20*sin(i*0.15)*cos(i*0.062),4);
RChart1.MoveTo (0,0); { dummy token for FindNext-example }
end;


(*******************************************************************)
procedure TForm1.BBtDoneClick(Sender: TObject);
(*******************************************************************)

begin
close;
end;


(*******************************************************************)
procedure TForm1.SbMarkClick(Sender: TObject);
(*******************************************************************)

var
  xLo, YLo, XHi, YHi : double;

begin
PnlStat.Caption := 'Select the data to move';
MarkedMove := SbDrag.Down;
if RChart1.MouseBox (xLo, YLo, XHi, YHi) then
  begin
  RChart1.MarkItemsInWindow (xLo, YLo, XHi, YHi, tkMarkAt, 99);
  RChart1.NewColorOfClassItems (clBlue, 99);
  RChart1.ShowGraf;
  end;
SbMark.Down := False;
SbDrag.Down := True;
MarkedMove := SbDrag.Down;
PnlStat.Caption := 'Drag the data by clicking the chart and draging the mouse';
end;

(*******************************************************************)
procedure TForm1.SBDragClick(Sender: TObject);
(*******************************************************************)

begin
MarkedMove := SbDrag.Down;
if MarkedMove
  then PnlStat.Caption := 'Drag the data by clicking the chart and draging the mouse'
  else PnlStat.Caption := '';
end;

(*******************************************************************)
procedure TForm1.RChart1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
(*******************************************************************)

var
  rx, ry   : double;
  rx2, ry2 : double;

begin
if (ssLeft in Shift) and MarkedMove
  then begin
       if FirstMove
         then begin
              FirstMove := false;
              LastPosX := X;
              LastPosY := Y;
              end
         else begin
              RChart1.M2R (x,y,rx,ry);
              RChart1.M2R (LastPosX,LastPosY,rx2,ry2);
              RChart1.ScaleSelectedItems (1,rx-rx2,1,ry-ry2,99);
              RChart1.ShowGraf;
              LastPosX := X;
              LastPosY := Y;
              end;
       end
  else FirstMove := True;
end;


(*******************************************************************)
procedure TForm1.SBClearMarksClick(Sender: TObject);
(*******************************************************************)

begin
SbDrag.Down := False;
RChart1.MarkAllItems (tkEverything, 0);
RChart1.NewColorOfClassItems (clRed, 0);
RChart1.ShowGraf;
end;

(*******************************************************************)
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
(*******************************************************************)

begin
Screen.Cursor := crDefault;
end;

initialization
MarkedMove := false;
FirstMove := true;
end.
