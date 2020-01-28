Unit Timser;


Interface

Uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, RChart, StdCtrls, printers, NumLab, ExtCtrls;

Type
  TForm1 = Class(TForm)
    RChart1 : TRChart;
    ButDone : TButton;
    CBMX : TCheckBox;
    CBMY : TCheckBox;
    NumLab1 : TNumLab;
    NumLab2 : TNumLab;
    Procedure FormActivate(Sender : TObject);
    Procedure ButDoneClick(Sender : TObject);
    Procedure CBMXClick(Sender : TObject);
    Procedure CBMYClick(Sender : TObject);
    Procedure RChart1MouseMoveInChart(Sender : TObject; InChart : Boolean;
      Shift : TShiftState; rMousePosX, rMousePosY : Double);
    Procedure FormMouseMove(Sender : TObject; Shift : TShiftState; X,
      Y : Integer);
    Procedure FormShow(Sender : TObject);
  private
    Procedure SetCrossHair;
  public
    { Public declarations }
  End;

Var
  Form1             : TForm1;

Implementation

{$R *.DFM}

(*******************************************************************)

Procedure TForm1.FormActivate(Sender : TObject);
(*******************************************************************)

Const
  Numval            = 800;

Var
  i                 : integer;

Begin
  RChart1.RangeHiX := NumVal;
  RChart1.RangeLoX := 0;
  RChart1.RangeHiY := 150;
  RChart1.RangeLoY := -30;
  RChart1.DataColor := clBlue;
  RCHart1.MoveTo(0, 0);
  For i := 1 To NumVal Do
    RChart1.DrawTo(i, i / 10 + i / 30 * sin(i * 0.04) + 20 * (random + random));
  RChart1.DataColor := clRed;
  RChart1.MoveTo(0, 40);
  For i := 1 To NumVal Do
    RChart1.DrawTo(i, 40 + i / 20 * sin(i * 0.05));
End;

(*******************************************************************)

Procedure TForm1.SetCrossHair;
(*******************************************************************)

Begin
  If CBMX.Checked Then Begin
    If CBMY.Checked Then RChart1.CrossHairSetup(1, clTeal, chBoth, psSolid, 1)
    Else RChart1.CrossHairSetup(1, clTeal, chVert, psSolid, 1);
  End
  Else Begin
    If CBMY.Checked Then RChart1.CrossHairSetup(1, clTeal, chHoriz, psSolid, 1)
    Else RChart1.CrossHairSetup(1, clTeal, chOff, psSolid, 1);
  End;

End;


(*******************************************************************)

Procedure TForm1.ButDoneClick(Sender : TObject);
(*******************************************************************)

Begin
  close;
End;

(*******************************************************************)

Procedure TForm1.CBMXClick(Sender : TObject);
(*******************************************************************)

Begin
  Numlab1.Visible := CBMX.Checked;
  SetCrossHair;
End;

(*******************************************************************)

Procedure TForm1.CBMYClick(Sender : TObject);
(*******************************************************************)

Begin
  NumLab2.Visible := CBMY.Checked;
  SetCrossHair;
End;


(*******************************************************************)

Procedure TForm1.RChart1MouseMoveInChart(Sender : TObject; InChart : Boolean;
  Shift : TShiftState; rMousePosX, rMousePosY : Double);
(*******************************************************************)

Begin
  NumLab1.Empty := Not Inchart;
  NumLab2.Empty := Not Inchart;
  NumLab1.Value := rMousePosX;
  NumLab2.Value := rMousePosY;
  RChart1.CrossHairSetPos(1, rMousePosX, rMousePosY);
End;


(*******************************************************************)

Procedure TForm1.FormMouseMove(Sender : TObject; Shift : TShiftState; X,
  Y : Integer);
(*******************************************************************)

Begin
  Screen.Cursor := crDefault;
End;

(*******************************************************************)

Procedure TForm1.FormShow(Sender : TObject);
(*******************************************************************)

Begin
  SetCrossHair;

End;

End.

