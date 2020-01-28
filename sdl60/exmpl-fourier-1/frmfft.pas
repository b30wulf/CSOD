Unit frmfft;

Interface

Uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, RChart, Fourier, Buttons, ExtCtrls, AdvCardList;

Type
  TForm1 = Class(TForm)
    RChart1 : TRChart;
    RChart2 : TRChart;
    ScrollBar1 : TScrollBar;
    SBFreq1 : TScrollBar;
    Label1 : TLabel;
    FFT1 : TFastFourier;
    BButExit : TBitBtn;
    Label2 : TLabel;
    CBoxWind : TComboBox;
    Label3 : TLabel;
    RGSpecType : TRadioGroup;
    CBLogY : TCheckBox;
    Procedure ScrollBar1Change(Sender : TObject);
    Procedure SBFreq1Change(Sender : TObject);
    Procedure BButExitClick(Sender : TObject);
    Procedure FormActivate(Sender : TObject);
    Procedure CBoxWindChange(Sender : TObject);
    Procedure RGSpecTypeClick(Sender : TObject);
    Procedure CBLogYClick(Sender : TObject);
  private
    Procedure StartFFT;
  public
    { Public declarations }
  End;

Var
  Form1             : TForm1;

Implementation

{$R *.DFM}


(**************************************************************)

Procedure TForm1.StartFFT;
(**************************************************************)

Const
  ChartYRanges      : Array[0..6, 1..2] Of double =
    ((0, 10),                           { Magnitude }
    (0, 50000),                         { PowerSpec }
    (-2, 2),                            { Phase }
    (-10, 10),                          { FourSerCosCoeff }
    (-10, 10),                          { FourSerSinCoeff }
    (-2000, 2000),                      { RealSpec }
    (-2000, 2000));                     { ImagSpec }

Var
  i                 : integer;
  y                 : double;

Begin
  RChart1.ClearGraf;
  RChart1.DataColor := clBlue;
  RChart1.MoveTo(0, 0);
  FFT1.ClearImag;
  For i := 1 To FFT1.SpectrumSize Do Begin
//    y := 10 * (sin(0.01 * i * (100 - SbFreq1.Position)) + sin(0.075 * i) + cos(0.5 * i) +
//      0.06 * (random(100 - ScrollBar1.Position) - 0.5 * (100 - ScrollBar1.Position)));
    y := 10 * (sin(0.01 * i * (100 - SbFreq1.Position)));
    FFT1.RealSpec[i] := y;              { real value }
    RChart1.DrawTo(i, y);
  End;

  RChart1.ShowGraf;

  FFT1.Transform;

  RChart2.ClearGraf;

  RChart2.RangeLoY := ChartYRanges[RGSpecType.ItemIndex, 1];
  RChart2.RangeHiY := ChartYRanges[RGSpecType.ItemIndex, 2];

  If Not CBLogY.Enabled Then RChart2.LogScaleY := false

  Else If CBLogY.Checked Then Begin
    If RGSpecType.ItemIndex = 0 Then
      RChart2.RangeLoY := 1E-4
    Else
      RChart2.RangeLoY := 1E-6;
    RChart2.LogScaleY := true;
  End Else
    RChart2.LogScaleY := false;

  Case RGSpecType.ItemIndex Of
    0 : RChart2.Caption := 'Magnitude Spectrum';
    1 : rchart2.Caption := 'Power Spectrum';
    2 : rchart2.Caption := 'Phase Angle';
    3 : rchart2.Caption := 'Cosine Terms';
    4 : RChart2.Caption := 'Sine Terms';
    5 : RChart2.Caption := 'Real Part of Complex Spectrum';
    6 : RChart2.Caption := 'Imaginary Part of Complex Spectrum';
  End;

  RChart2.DataColor := clRed;

  RChart2.MoveTo(FFT1.FreqOfLine(1, 0.001), 0);

  y := 0;
  For i := 1 To (FFT1.SpectrumSize Div 2) Do Begin
    Case RGSpecType.ItemIndex Of
      0 : y := FFT1.Magnitude[i];
      1 : y := FFT1.PowerSpec[i];
      2 : y := FFT1.Phase[i];
      3 : y := FFT1.FourSerCosCoeff[i];
      4 : y := FFT1.FourSerSinCoeff[i];
      5 : y := FFT1.RealSpec[i + 1];
      6 : y := FFT1.ImagSpec[i + 1];
    End;
    RChart2.DrawTo(FFT1.FreqOfLine(i, 0.001), y);
  End;

  RChart2.ShowGraf;

End;

(**************************************************************)

Procedure TForm1.ScrollBar1Change(Sender : TObject);
(**************************************************************)

Begin
  STartFFT;
End;

(**************************************************************)

Procedure TForm1.SBFreq1Change(Sender : TObject);
(**************************************************************)

Begin
  StartFFT;
End;

(**************************************************************)

Procedure TForm1.BButExitClick(Sender : TObject);
(**************************************************************)

Begin
  close;
End;

(**************************************************************)

Procedure TForm1.FormActivate(Sender : TObject);
(**************************************************************)

Begin
  CBoxWind.Text := 'None';
  StartFFT;
End;


(**************************************************************)

Procedure TForm1.CBoxWindChange(Sender : TObject);
(**************************************************************)

Begin
  If CBoxWind.Text = 'Rectangle' Then
    FFT1.WeightingWindow := fwRectangle;
  If CBoxWind.Text = 'Triangle' Then
    FFT1.WeightingWindow := fwTriangle;
  If CBoxWind.Text = 'Gaussian' Then
    FFT1.WeightingWindow := fwGauss;
  If CBoxWind.Text = 'Hamming' Then
    FFT1.WeightingWindow := fwHamming;
  If CBoxWind.Text = 'Blackman' Then
    FFT1.WeightingWindow := fwBlackman;
  If CBoxWind.Text = 'cos2' Then
    FFT1.WeightingWindow := fwCos2;
  StartFFT;
End;

(**************************************************************)

Procedure TForm1.RGSpecTypeClick(Sender : TObject);
(**************************************************************)

Begin
  Case RGSpecType.ItemIndex Of
    0, 1 : CBLogY.Enabled := true;
    2, 3, 4, 5, 6 : CBLogY.Enabled := false;
  End;
  StartFFT;
End;



(**************************************************************)

Procedure TForm1.CBLogYClick(Sender : TObject);
(**************************************************************)

Begin
  StartFFT;
End;

End.

