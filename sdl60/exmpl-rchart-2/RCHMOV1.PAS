Unit Rchmov1;

{ This unit shows the application of the method RemoveLastToken
  two display moving graphics objects. Once a background is
  established (the dotted line) only the moving elements have to
  exhchanged on the linked list by first removing them and then
  redrawing them at another location }

{--------------------------------------------------------------}
Interface
{--------------------------------------------------------------}

Uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, RChart, ExtCtrls;

Type
  TForm1 = Class(TForm)
    RChart1 : TRChart;
    ButDone : TBitBtn;
    ButStart : TBitBtn;
    ButStop : TBitBtn;
    Bevel1 : TBevel;
    CBLogX : TCheckBox;
    CBLogY : TCheckBox;
    Procedure ButStartClick(Sender : TObject);
    Procedure ButDoneClick(Sender : TObject);
    Procedure ButStopClick(Sender : TObject);
    Procedure CBLogXClick(Sender : TObject);
    Procedure CBLogYClick(Sender : TObject);
    Procedure FormMouseMove(Sender : TObject; Shift : TShiftState; X,
      Y : Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  End;

Var
  Form1             : TForm1;

{--------------------------------------------------------------}
Implementation

Uses LogWarn;
{--------------------------------------------------------------}

{$R *.DFM}

Var
  RunMove           : boolean;

(***************************************************************)

Procedure TForm1.ButStartClick(Sender : TObject);
(***************************************************************)

Const
  NPnts             = 140;

Var
  i, j              : integer;

Begin
  ButStop.Enabled := true;
  ButStart.Enabled := false;
  ButDone.Enabled := false;
  RChart1.RangeLoX := 0;
  RChart1.RangeHiX := NPnts;
  RChart1.RangeLoY := 10;
  RChart1.RangeHiY := 600;
  RChart1.DataColor := clBlack;
  RChart1.ClearGraf;
  For i := 1 To NPnts Do
    RChart1.MarkAt(i, NPnts + i * sin(i * 0.1), 0);
  RChart1.ShowGraf;
  RunMove := True;
  RChart1.DataColor := clBlue;
  RChart1.MarkAt(0, 0, 12);
  RChart1.DataColor := clRed;
  RChart1.MarkAt(0, 0, 12);
  RChart1.ShowGraf;
  i := 0;
  j := 0;
  While RunMove Do Begin
    inc(j, 2);
    If j > NPnts Then
      j := 1;
    inc(i);
    If i > Npnts Then
      i := 1;
    RChart1.RemoveLastItem;
    RChart1.RemoveLastItem;
    RChart1.DataColor := clRed;
    RChart1.MarkAt(i, NPnts + i * sin(i * 0.1), 18);
    RChart1.DataColor := clBlue;
    RChart1.MarkAt(j, NPnts + j * sin(j * 0.1), 18);
    RChart1.ShowGraf;
    Application.ProcessMessages;
  End;
End;


(***************************************************************)

Procedure TForm1.ButDoneClick(Sender : TObject);
(***************************************************************)

Begin
  close;
End;


(***************************************************************)

Procedure TForm1.ButStopClick(Sender : TObject);
(***************************************************************)

Begin
  ButStop.Enabled := false;
  ButStart.Enabled := true;
  ButDone.Enabled := true;
  RunMove := False;
End;

(***************************************************************)

Procedure TForm1.CBLogXClick(Sender : TObject);
(***************************************************************)

Begin
  If Not CBLogX.Checked And (RChart1.RangeLoX <= 0) Then Begin
    LogWarnForm.ShowModal;
    CBLogX.Checked := false;
  End
  Else Begin
    RChart1.LogScaleX := CBLogX.Checked;
    CBLogX.Checked := RChart1.LogScaleX;
  End;
End;

(***************************************************************)

Procedure TForm1.CBLogYClick(Sender : TObject);
(***************************************************************)

Begin
  If Not CBLogY.Checked And (RChart1.RangeLoY <= 0) Then Begin
    LogWarnForm.ShowModal;
    CBLogY.Checked := false;
  End
  Else Begin
    RChart1.LogScaleY := CBLogY.Checked;
    CBLogY.Checked := RChart1.LogScaleY;
  End;
End;


(***************************************************************)

Procedure TForm1.FormMouseMove(Sender : TObject; Shift : TShiftState; X,
  Y : Integer);
(***************************************************************)

Begin
  Screen.Cursor := crDefault;
End;

End.

