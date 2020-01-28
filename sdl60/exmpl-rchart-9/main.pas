unit main;

(******************************************************************************
  This program shows how to use the events OnScaleTickDrawn and OnDataRendered
  to extend an RChart component be user defined graphics elements and text. See
  the help file for more details on how to use these events.

  Remark: you need at least version 6.0 of the SDL Component Suite to run this
          example.
*******************************************************************************)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  rchart, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    RChart1: TRChart;
    Panel1: TPanel;
    ButExit: TButton;
    CBoxHexYScale: TCheckBox;
    procedure RChart1ScaleTickDrawn(Sender: TObject; var Canvas: TCanvas;
      ScaleType: TScaleType; CurrentTickPos: Double; ChartX,
      ChartY: Integer);
    procedure FormShow(Sender: TObject);
    procedure ButExitClick(Sender: TObject);
    procedure CBoxHexYScaleClick(Sender: TObject);
    procedure RChart1DataRendered(Sender: TObject; var canvas: TCanvas;
      Top, Left: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  math1;

(******************************************************************************)
procedure TForm1.RChart1ScaleTickDrawn(Sender: TObject;
  var Canvas: TCanvas; ScaleType: TScaleType; CurrentTickPos: Double;
  ChartX, ChartY: Integer);
(******************************************************************************)

var
  astr  : string;
  tw, th: integer;

begin
if CBoxHexYScale.Checked then
  if ScaleType = sctYL then
    begin
    astr := '($'+hex(round(CurrentTickPos),4)+')';
    tw := canvas.TextWidth(astr);
    th := canvas.TextHeight(astr);
    Canvas.TextOut (ChartX-tw-8, ChartY+(th div 2), astr);
    end;
end;

(******************************************************************************)
procedure TForm1.RChart1DataRendered(Sender: TObject; var canvas: TCanvas;
  Top, Left: Integer);
(******************************************************************************)

var
  xout, yout : integer;

begin
Canvas.Font.Color := clBlue;
Canvas.TextOut (100,100, 'text position: absolute');
Canvas.pen.Color := clLime;
Canvas.pen.Width := 5;
Canvas.MoveTo (93,95);
Canvas.LineTo (260,95);
Canvas.LineTo (260,120);
Canvas.LineTo (93,120);
Canvas.LineTo (93,95);
Canvas.Font.Color := clRed;
RChart1.R2M (20.0, -1.3, xout,yout);
Canvas.TextOut (xout-Left, yout-Top, 'text position: relative to the data');
end;

(******************************************************************************)
procedure TForm1.FormShow(Sender: TObject);
(******************************************************************************)

var
  i : integer;

begin
RChart1.MoveTo (0,0);
for i:=1 to 100 do
  RChart1.DrawTo (i,sin(0.2*i));
end;

(******************************************************************************)
procedure TForm1.ButExitClick(Sender: TObject);
(******************************************************************************)

begin
close;
end;

(******************************************************************************)
procedure TForm1.CBoxHexYScaleClick(Sender: TObject);
(******************************************************************************)

begin
RChart1.Invalidate;
end;

end.
