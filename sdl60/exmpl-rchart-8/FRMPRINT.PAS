Unit Frmprint;


Interface

Uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, RChart, StdCtrls, ExtCtrls, NumLab;

Type
  TForm1 = Class(TForm)
    RChart1 : TRChart;
    Button1 : TButton;
    Button2 : TButton;
    SBScalF : TScrollBar;
    NLbScaleF : TNumLab;
    Label1 : TLabel;
    Bevel1 : TBevel;
    RChart2 : TRChart;
    NLbPosX : TNumLab;
    NLbPosY : TNumLab;
    Bevel2 : TBevel;
    Label2 : TLabel;
    Label3 : TLabel;
    Bevel3 : TBevel;
    Label4 : TLabel;
    Label5 : TLabel;
    Label6 : TLabel;
    Label7 : TLabel;
    PrintDialog1 : TPrintDialog;
    CBColor : TCheckBox;
    Procedure FormActivate(Sender : TObject);
    Procedure Button1Click(Sender : TObject);
    Procedure Button2Click(Sender : TObject);
    Procedure RChart2MouseMoveInChart(Sender : TObject; InChart : Boolean;
      shift : TShiftState; rMousePosX, rMousePosY : Double);
    Procedure SBScalFChange(Sender : TObject);
    Procedure RChart2Click(Sender : TObject);
    Procedure FormMouseMove(Sender : TObject; Shift : TShiftState; X,
      Y : Integer);
  private
    Procedure ShowPageRect;
  public
    { Public declarations }
  End;

Var
  Form1             : TForm1;

Implementation

{$R *.DFM}

Uses
  printers;

Var
  PrintPosX         : integer;          { position of printout }
  PrintPosY         : integer;
  PrintScaleF       : double;           { scaling factor of printout }
  xpRes, ypRes      : integer;          { printer resolution }
  xpSize, ypSize    : integer;          { printer paper size }


(************************************************************)

Procedure TForm1.FormActivate(Sender : TObject);
Var
  i                 : integer;
Begin
  RChart1.ClearGraf;
  RChart1.MoveTo(0, 0);
  For i := 1 To 200 Do
    RChart1.DrawTo(i, (1 - exp(i * 0.008)) * sin(0.2 * i) * sin(0.33 * i));
  RChart1.ShowGraf;
  PrintPosX := 100;
  PrintPosY := 100;
  PrintScaleF := 1.0;
  NLbScaleF.Value := 1.0;
  SbScalF.Position := 0;
  xpRes := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  ypRes := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  xpSize := GetDeviceCaps(Printer.Handle, HORZSIZE);
  ypSize := GetDeviceCaps(Printer.Handle, VERTSIZE);
  RChart2.SetRange(0, ypSize / 25.4 * ypRes, xpSize / 25.4 * xpRes, 0);
  ShowPageRect;
End;

(************************************************************)

Procedure TForm1.ShowPageRect;
Begin
  RChart2.ClearGraf;
  RChart2.DataColor := clRed;
  RChart2.FillColor := clRed;
  RChart2.Rectangle(PrintPosX, PrintPosY,
    PrintPosX + PrintScaleF * xpRes / Screen.PixelsPerInch * RChart1.Width,
    PrintPosY + PrintScaleF * ypRes / Screen.PixelsPerInch * RChart1.Height);
  RChart2.DataCOlor := clWhite;
  RChart2.Text((2 * PrintPosX + PrintScaleF * xpRes / Screen.PixelsPerInch * RChart1.Width) / 2,
    (2 * PrintPosY + PrintScaleF * ypRes / Screen.PixelsPerInch * RChart1.Height) / 2,
    round(8 * PrintScaleF), 'Chart');
  RChart2.ShowGraf;
End;


(************************************************************)

Procedure TForm1.Button1Click(Sender : TObject);
Begin
  close;
End;

(************************************************************)

Procedure TForm1.Button2Click(Sender : TObject);
Var
  astr              : String;
  x1, y1            : integer;

Begin
  If PrintDialog1.Execute Then Begin
    Printer.BeginDoc;
    str(PrintScaleF : 1 : 2, astr);
    Printer.Canvas.TextOut(100, 40, 'Position of image: x=' +
      IntToStr(PrintPosX) + '  y=' + IntToStr(PrintPosY) +
      '    Scaling factor: ' + astr);
    x1 := PrintPosX;                    { copy position into dummy vars in order NOT to change PrintPosX/Y}
    y1 := PrintPosY;
    Rchart1.CopyToOpenPrinterHiRes(x1, y1, PrintScaleF, Not CBColor.Checked);
    Printer.Canvas.TextOut(300, y1 + 20, 'This line is just below the printed image');
    Printer.EndDoc;
  End;

End;

(************************************************************)

Procedure TForm1.RChart2MouseMoveInChart(Sender : TObject;
  InChart : Boolean; shift : TShiftState;
  rMousePosX, rMousePosY : Double);
Begin
  NLbPosX.Empty := Not Inchart;
  NLbPosY.Empty := Not Inchart;
  NLbPosX.Value := rMousePosX;
  NLbPosY.Value := rMousePosY;
  If ssLeft In Shift Then Begin
    PrintPosX := round(RChart2.MousePosX);
    PrintPosY := round(RChart2.MousePosY);
    SHowPageRect;
  End;
End;

(************************************************************)

Procedure TForm1.SBScalFChange(Sender : TObject);
Begin
  PrintScaleF := 1.0 + (SBScalF.Position / 100);
  NLbScaleF.Value := PrintScaleF;
  SHowPageRect;
End;

(************************************************************)

Procedure TForm1.RChart2Click(Sender : TObject);
Begin
  PrintPosX := round(RChart2.MousePosX);
  PrintPosY := round(RChart2.MousePosY);
  SHowPageRect;
End;

(************************************************************)

Procedure TForm1.FormMouseMove(Sender : TObject; Shift : TShiftState; X,
  Y : Integer);
Begin
  SCreen.Cursor := crdefault;
  NLbPosX.Empty := true;
  NLbPosY.Empty := true;
End;

End.

