unit Fifomain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, RChart, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    RChart1: TRChart;
    BButStart: TBitBtn;
    BButStop: TBitBtn;
    BButExit: TBitBtn;
    CBFixedX: TCheckBox;
    procedure BButStartClick(Sender: TObject);
    procedure BButStopClick(Sender: TObject);
    procedure BButExitClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


var
  Abort   : boolean;

(******************************************************************)
procedure TForm1.BButStartClick(Sender: TObject);
(******************************************************************)

const
  Step = 1.0;

var
  DataCnt : double;
  XArg    : double;

begin
RChart1.ClearGraf;
RChart1.SetRange (0, RChart1.RangeLoY, 100, RChart1.RangeHiy);
DataCnt := 0;
XArg := 0;
BButExit.Enabled := false;
BButStart.Enabled := false;
BButStop.Enabled := true;
abort := false;
CBFixedX.Enabled := false;
if CBFixedX.Checked
  then begin        { non-scrolling x axis }
       while not abort do
         begin
         Application.Processmessages;
         RChart1.DataColor := clblue;
         RChart1.MarkAt (DataCnt, sin(0.19*XArg)*cos(0.02*XArg), 10);
         RChart1.DataColor := clred;
         RChart1.MoveTo (DataCnt-Step, cos(0.09*(XArg-Step)));
         RChart1.DrawTo (DataCnt, cos(0.09*XArg));
         if DataCnt > 80
           then begin
                RChart1.RemoveFirstItem;                  { remove MarkAt }
                RChart1.RemoveFirstItem;                  { remove MoveTo }
                RChart1.RemoveFirstItem;                  { remove DrawTo }
                RChart1.ScaleAllItems (1, -Step, 1, 0)
                end
           else dataCnt := dataCnt + step;
         RChart1.ShowGraf;
         XArg := XArg + step;
         end;
       end
  else begin        { scrolling x axis }
       while not abort do
         begin
         Application.Processmessages;
         RChart1.DataColor := clblue;
         RChart1.MarkAt (XArg, sin(0.19*XArg)*cos(0.02*XArg), 10);
         RChart1.DataColor := clred;
         RChart1.MoveTo (XArg-Step, cos(0.09*(XArg-Step)));
         RChart1.DrawTo (XArg, cos(0.09*XArg));
         if DataCnt > 80
           then begin
                RChart1.RemoveFirstItem;                  { remove MarkAt }
                RChart1.RemoveFirstItem;                  { remove MoveTo }
                RChart1.RemoveFirstItem;                  { remove DrawTo }
                RChart1.SetRange (RChart1.RangeLoX+Step, RChart1.RangeLoY,
                                  RChart1.RangeHiX+Step, RChart1.RangeHiy);
                end
           else dataCnt := dataCnt + Step;
         RChart1.ShowGraf;
         XArg := XArg + step;
         end;
       end;
end;

(******************************************************************)
procedure TForm1.BButStopClick(Sender: TObject);
(******************************************************************)

begin
Abort := true;
BButExit.Enabled := true;
BButStart.Enabled := true;
BButStop.Enabled := false;
CBFixedX.Enabled := true;
end;


(******************************************************************)
procedure TForm1.BButExitClick(Sender: TObject);
(******************************************************************)

begin
close;
end;

(******************************************************************)
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
(******************************************************************)

begin
Screen.cursor := crDefault;
end;

end.
