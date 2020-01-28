unit Frmmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, RChart, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    ExportChart: TRChart;
    BButDone: TBitBtn;
    BButAuto: TBitBtn;
    BButStop: TBitBtn;
    SBarHeight: TScrollBar;
    SBarDepth: TScrollBar;
    SBarAngle: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RB3Don: TRadioButton;
    RBRect: TRadioButton;
    procedure BButDoneClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BButAutoClick(Sender: TObject);
    procedure BButStopClick(Sender: TObject);
    procedure SBarHeightChange(Sender: TObject);
    procedure SBarDepthChange(Sender: TObject);
    procedure SBarAngleChange(Sender: TObject);
    procedure RBRectClick(Sender: TObject);
    procedure RB3DonClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    procedure DisplayChart (Hgt: double; Depth, Ang: integer);
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.DFM}

const
  FirstYear = 1970;
  LastYear = 1980;
  Exprts : array[FirstYear..LastYear] of real = (10,20,50,75,100,16,-27,-28,3,10,42);
  Colors : array[FirstYear..LastYear] of TColor = (clwhite, clblue, cllime,
                                                   clyellow, clteal, clwhite,
                                                   clblue, cllime, clyellow, clteal, clred);

var
  Stopped : boolean;
  Bar3DOn : boolean;

(****************************************************************)
procedure TForm1.DisplayChart (Hgt: double; Depth, Ang: integer);
(****************************************************************)


var
  i : integer;

begin
with ExportChart do
  begin
  ClearGraf;
  DataColor := clBlack;
  if Bar3DOn
    then begin
         if Ang > 90               { adjust the order of display according to angle }
           then begin
                for i := LastYear downto FirstYear do
                  begin
                  FillColor := Colors[i];
                  Bar3D (i-0.4, 0, i+0.4, Hgt*Exprts[i], Depth, Ang);
                  end;
                end
           else begin
                for i := FirstYear to LastYear do
                  begin
                  FillColor := Colors[i];
                  Bar3D (i-0.4, 0, i+0.4, Hgt*Exprts[i], Depth, Ang);
                  end;
                end;
         end
    else begin
         for i := FirstYear to LastYear do
           begin
           FillColor := Colors[i];
           Rectangle (i-0.4, 0, i+0.4, Hgt*Exprts[i]);
           end;
         end;
  ShowGraf;
  end;
end;

(****************************************************************)
procedure TForm1.BButDoneClick(Sender: TObject);
(****************************************************************)

begin
close;
end;

(****************************************************************)
procedure TForm1.FormActivate(Sender: TObject);
(****************************************************************)

begin
Stopped := false;
Bar3DOn := true;
DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
end;

(****************************************************************)
procedure TForm1.BButAutoClick(Sender: TObject);
(****************************************************************)

var
  Step  : integer;

begin
Stopped := false;
BButStop.Enabled := true;
BButDone.Enabled := false;
BButAuto.Enabled := false;
ExportChart.ScaleColor := clBlack;
ExportChart.DataColor := clSilver;
Step := 1;
repeat
  Application.ProcessMessages;
  if SBarHeight.Position <= 0 then
    step := +1;
  if SBarHeight.Position >= 100 then
    step := -1;
  SBarHeight.Position := SbarHeight.Position + Step;
  DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
until Stopped;
end;


(****************************************************************)
procedure TForm1.BButStopClick(Sender: TObject);
(****************************************************************)

begin
Stopped := true;
BButAuto.Enabled := true;
BButStop.Enabled := false;
BButDone.Enabled := true;
end;

(****************************************************************)
procedure TForm1.SBarHeightChange(Sender: TObject);
(****************************************************************)

begin
DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
end;

(****************************************************************)
procedure TForm1.SBarDepthChange(Sender: TObject);
(****************************************************************)

begin
DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
end;

(****************************************************************)
procedure TForm1.SBarAngleChange(Sender: TObject);
(****************************************************************)

begin
DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
end;

(****************************************************************)
procedure TForm1.RBRectClick(Sender: TObject);
(****************************************************************)

begin
Bar3DOn := false;
DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
end;

(****************************************************************)
procedure TForm1.RB3DonClick(Sender: TObject);
(****************************************************************)

begin
Bar3DOn := true;
DisplayChart (0.02*(50-SBarHeight.Position), 100-SBarDepth.Position, SBarAngle.Position);
end;

(****************************************************************)
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState;
                               X,Y: Integer);
(****************************************************************)

begin
Screen.Cursor := crDefault;
end;

end.
