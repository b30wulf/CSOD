Unit Fourier;

(******************************************************************)
(*                                                                *)
(*                         F O U R I E R                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1997..2001 H. Lohninger                    June 1997   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Sep-28, 1999                                  *)
(*                                                                *)
(******************************************************************)

{revision history:

1.0   [July-15, 1997]
      first release to the public

1.1   [Aug-12, 1997]
      Scaling of Inverse FFT included
      DCOMMON no longer needed for FOURIER
      Direct access to internal data buffer included

1.2.  [Apr-08, 1998]
      FOURIER now available for C++Builder 3.0

1.3.  [Aug-17, 1998]
      FOURIER is now available for Delphi 4.0
      new properties Magnitude and MagniMax
      new property Phase
      new function FreqOfLine
      new function RMS
      new properties FourSerSinCoeff and FourSerCosCoeff
      bug fix in PowerSpec: PowerSpec delivered wrong values

1.4.  [Mar-19, 1999]
      Delphi 1.0 no longer supported
      bug fix: scaling of Fourier spectrum was wrong
      bug fix: accessing PowerSpec after a resize of the spectrum size no longer
          creates an floating point error
      bug fix: MaxPower delivered wrong results if the signal contained an imaginary
          zero frequency maximum (rather formal)
      indexing scheme of PowerSpec, Magnitude, RMS, and Phase properties changed
          (index 0 is now constant term, index 1 is first harmonic, etc)
      data array may now be up to 2^24 bits long

5.0   [Oct-09, 1999]
      FOURIER is now available as part of SDL Comp. Suite 5.0
      available for Delphi 5.0
      bug fix: MagniMax and PowerMax deliver now correct values

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
}

{$O+}
{$F+}

{--------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                       }
{--------------------------------------------------------------------}

{$IFNDEF SDLBATCH}
{$IFDEF VER110}
{$OBJEXPORTALL On}                      { this switch is necessary for C++Builder 3.0 }
{$ENDIF}
{$IFDEF VER125}
{$OBJEXPORTALL On}                      { this switch is necessary for C++Builder 4.0 }
{$ENDIF}
{$IFDEF VER135}
{$OBJEXPORTALL On}                      { this switch is necessary for C++Builder 5.0 }
{$ENDIF}
{$ENDIF}

{--------------------------------------------------------------------}
Interface
{--------------------------------------------------------------------}

Uses
  classes;

Type
  TFastFourierWgtWin = (fwRectangle, fwTriangle, fwCos2, fwGauss,
    fwHamming, fwBlackman);
  TFastFourier = Class(TComponent)
  private
    FNumData : longint;                 { size of data array, must be 2^n }
    FData : pointer;
    FWgtWin : TFastFourierWgtWin;
    MaxValuesValid : boolean;
    FMaxReal : double;
    FMaxImag : double;
    FMinReal : double;
    FMinImag : double;
    FMaxPower : double;
    FMaxMagni : double;
    Function GetRealVal(ix : integer) : double;
    Procedure SetRealVal(ix : integer; v : double);
    Function GetImagVal(ix : integer) : double;
    Procedure SetImagVal(ix : integer; v : double);
    Procedure SetNumData(ndata : longint);
    Procedure SetWgtWin(ww : TFastFourierWgtWin);
    Function GetPowerSpec(ix : integer) : double;
    Function GetMagnitude(ix : integer) : double;
    Function GetFSerSin(n : integer) : double;
    Function GetFSerCos(n : integer) : double;
    Function GetPhase(ix : integer) : double;
    Function GetMaxPower : double;
    Function GetMaxMagni : double;
    Function GetMaxReal : double;
    Function GetMaxImag : double;
    Function GetMinReal : double;
    Function GetMinImag : double;
    Procedure DoFFT(isign : integer);
    Procedure CalcMaxValues;
  public
    Constructor Create(AOwner : TComponent); override;
    Destructor Destroy; override;
    Property RealSpec[ix : integer] : double read GetRealVal write SetRealVal;
    Property ImagSpec[ix : integer] : double read GetImagVal write SetImagVal;
    Procedure Clear;
    Procedure ClearImag;
    Procedure ClearReal;
    Procedure Transform;
    Function FreqOfLine(ix : integer; SampleTime : double) : double;
    Procedure InverseTransform;
    Property PowerSpec[ix : integer] : double read GetPowerSpec;
    Function RMS(FirstIx, LastIx : integer) : double;
    Property Magnitude[ix : integer] : double read GetMagnitude;
    Property FourSerSinCoeff[n : integer] : double read GetFSerSin;
    Property FourSerCosCoeff[n : integer] : double read GetFSerCos;
    Property Phase[ix : integer] : double read GetPhase;
    Property PowerMax : double read GetMaxPower;
    Property MagniMax : double read GetMaxMagni;
    Property RealMax : double read GetMaxReal;
    Property ImagMax : double read GetMaxImag;
    Property RealMin : double read GetMinReal;
    Property ImagMin : double read GetMinImag;
    Property DataBuffer : pointer read FData;
  published
    Property SpectrumSize : longint read FNumData write SetNumData;
    Property WeightingWindow : TFastFourierWgtWin read FWgtWin write SetWgtWin;
  End;

Procedure Register;

{--------------------------------------------------------------------}
Implementation
{--------------------------------------------------------------------}

Uses
  wintypes, winprocs, sysutils{$IFDEF SHAREWARE}, dialogs{$ENDIF};

{$R-}

{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\fourier_ct.inc}
{$ENDIF}

Const
  defFFTSize        = 256;
  MaxDouble         : extended = 1.7E308;

Type
  Array1D = Array[1..1] Of double;
  ELoCompError = Class(Exception);      { exception type to indicate errors }


(*********************************************************)

Constructor TFastFourier.Create(AOwner : TComponent);
(*********************************************************)

Var
  sz, i             : integer;
  cntBit            : integer;

Begin
  Inherited Create(AOwner);
{$IFDEF SHAREWARE}
  If Not DelphiIsRunning Then Begin
    FData := Nil;
    ShowMessagePos(GetVisMsgStr, 100, 100);
    Exit;
  End;
{$ENDIF}
  MaxValuesValid := False;
  sz := DefFFTsize;
  cntbit := 0;                          { check that size equals 2^n }
  For i := 1 To 16 Do Begin
    If (sz And $0001) = $0001 Then
      inc(cntBit);
    sz := sz Shr 1;
  End;
  If cntbit <> 1 Then
    Raise ELocompError.Create('FFT data length must be power of 2');
  FNumData := defFFTSize;
  GetMem(FData, 2 * FNumData * SizeOf(double));
  If (FData = Nil) Then
    Raise ELocompError.Create('not enough memory on heap');
  fillchar(FData^, 2 * FNumData * SizeOf(double), 0);
  FWgtWin := fwRectangle;
End;


(*********************************************************)

Destructor TFastFourier.Destroy;
(*********************************************************)

Begin
  If FData <> Nil Then
    FreeMem(FData, 2 * FNumData * SizeOf(double));
  FData := Nil;
  Inherited Destroy;
End;

(*********************************************************)

Function TFastFourier.GetRealVal(ix : integer) : double;
(*********************************************************)

Begin
  If (FData <> Nil) And
    (ix >= 1) And (ix <= FNumData) Then GetRealVal := Array1D(FData^)[2 * ix - 1]
  Else GetRealVal := 0;
End;

(*********************************************************)

Function TFastFourier.GetImagVal(ix : integer) : double;
(*********************************************************)

Begin
  If (FData <> Nil) And
    (ix >= 1) And (ix <= FNumData) Then GetImagVal := Array1D(FData^)[2 * ix]
  Else GetImagVal := 0;
End;

(*********************************************************)

Procedure TFastFourier.SetRealVal(ix : integer; v : double);
(*********************************************************)

Begin
  If (FData <> Nil) And
    (ix >= 1) And (ix <= FNumData) Then Begin
    Array1D(FData^)[2 * ix - 1] := v;
    MaxValuesValid := False;
  End;
End;

(*********************************************************)

Procedure TFastFourier.SetImagVal(ix : integer; v : double);
(*********************************************************)

Begin
  If (FData <> Nil) And
    (ix >= 1) And (ix <= FNumData) Then Begin
    Array1D(FData^)[2 * ix] := v;
    MaxValuesValid := False;
  End;
End;

(*********************************************************)

Procedure TFastFourier.SetWgtWin(ww : TFastFourierWgtWin);
(*********************************************************)

Begin
  If (FData <> Nil) Then
    FWgtWin := ww;
End;

(*********************************************************)

Procedure TFastFourier.SetNumData(ndata : longint);
(*********************************************************)

Var
  sz, i, cntbit     : integer;

Begin
  If (FData <> Nil) Then Begin
    sz := ndata;
    cntbit := 0;                        { check that size equals 2^n }
    For i := 1 To 24 Do Begin
      If (sz And $0001) = $0001 Then
        inc(cntBit);
      sz := sz Shr 1;
    End;
    If cntbit <> 1 Then
      Raise ELocompError.Create('FFT data length must be power of 2');
    FreeMem(FData, 2 * FNumData * SizeOf(double));
    FNumData := ndata;
    GetMem(FData, 2 * FNumData * SizeOf(double));
    If (FData = Nil) Then
      Raise ELocompError.Create('not enough memory on heap');
    fillchar(FData^, 2 * FNumData * SizeOf(double), 0);
    MaxValuesValid := False;
  End;
End;

(*********************************************************)

Function TFastFourier.FreqOfLine(ix : integer; SampleTime : double) : double;
(*********************************************************)

Begin
  If (ix < 1) Or (ix > (FNumData Div 2)) Then FreqOfLine := 0
  Else FreqOfLine := ix / SampleTime / FNumData;
End;

(*********************************************************)

Function TFastFourier.GetPowerSpec(ix : integer) : double;
(*********************************************************)

Var
  reslt             : double;

Begin
  reslt := 0;
  If (FData <> Nil) And
    (ix >= 0) And (ix <= (FNumData Div 2)) Then Begin
    If ix = 0 Then reslt := (sqr(Array1D(FData^)[2 * ix + 1]) +
        sqr(Array1D(FData^)[2 * ix + 2]))
    Else reslt := (sqr(Array1D(FData^)[2 * ix + 1]) +
        sqr(Array1D(FData^)[2 * ix + 2]) +
        sqr(Array1D(FData^)[2 * (FNumData - ix + 1) - 1]) +
        sqr(Array1D(FData^)[2 * (FNumData - ix + 1)]));
  End;
  GetPowerSpec := reslt / FNumData;
End;

(*********************************************************)

Function TFastFourier.GetMaxPower : double;
(*********************************************************)

Begin
  If Not MaxValuesValid Then Begin
    CalcMaxValues;
    MaxValuesValid := true;
  End;
  GetMaxPower := FMaxPower
End;

(*********************************************************)

Function TFastFourier.RMS(FirstIx, LastIx : integer) : double;
(*********************************************************)

Var
  sum               : double;
  idummy            : integer;
  i                 : integer;

Begin
  If FirstIx < 0 Then
    FirstIx := 0;
  If FirstIx > (FNumData Div 2) Then
    FirstIx := FNumData Div 2;
  If LastIx < 0 Then
    LastIx := 0;
  If LastIx > (FNumData Div 2) Then
    LastIx := FNumData Div 2;
  If LastIx < FirstIx Then Begin
    idummy := LastIx;
    LastIx := FirstIx;
    FirstIx := idummy;
  End;
  sum := 0;
  For i := FirstIx To LastIx Do Begin
    If i = 0 Then sum := sum + sqr(Array1D(FData^)[2 * i + 1]) + sqr(Array1D(FData^)[2 * i + 2])
    Else sum := sum + sqr(Array1D(FData^)[2 * i + 1]) +
      sqr(Array1D(FData^)[2 * i + 2]) +
        sqr(Array1D(FData^)[2 * (FNumData - i + 1) - 1]) +
      sqr(Array1D(FData^)[2 * (FNumData - i + 1)]);
  End;
  RMS := sqrt(sum) / FNumData;
End;

(*********************************************************)

Function TFastFourier.GetMaxMagni : double;
(*********************************************************)

Begin
  If Not MaxValuesValid Then Begin
    CalcMaxValues;
    MaxValuesValid := true;
  End;
  GetMaxMagni := FMaxMagni;
End;



(*********************************************************)

Function TFastFourier.GetMagnitude(ix : integer) : double;
(*********************************************************)

Var
  reslt             : double;

Begin
  reslt := 0;
  If (FData <> Nil) Then Begin
    If ix = 0 Then reslt := sqrt(sqr(Array1D(FData^)[1]) + sqr(Array1D(FData^)[ix + 2])) { mag[0] = a0 }
    Else Begin
      If (ix >= 1) And (ix <= (FNumData Div 2)) Then
        reslt := sqrt(sqr(Array1D(FData^)[2 * ix + 1] + Array1D(FData^)[2 * (FNumData - ix + 1) - 1]) +
          sqr(Array1D(FData^)[2 * ix + 2] - Array1D(FData^)[2 * (FNumData - ix + 1)]));
    End;
  End;
  GetMagnitude := reslt / FNumData;
End;


(*********************************************************)

Function TFastFourier.GetFSerSin(n : integer) : double;
(*********************************************************)


Var
  reslt             : double;

Begin
  reslt := 0;
  If (FData <> Nil) Then Begin
    inc(n);
    If (n >= 2) And (n <= (FNumData Div 2) + 1) Then
      reslt := (Array1D(FData^)[2 * n] - Array1D(FData^)[2 * (FNumData - n + 2)]);
  End;
  GetFSerSin := reslt / FNumData;
End;


(*********************************************************)

Function TFastFourier.GetFSerCos(n : integer) : double;
(*********************************************************)

Var
  reslt             : double;

Begin
  reslt := 0;
  If (FData <> Nil) Then Begin
    inc(n);
    If n = 1 Then reslt := Array1D(FData^)[1]
    Else Begin
      If (n >= 2) And (n <= (FNumData Div 2) + 1) Then
        reslt := Array1D(FData^)[2 * n - 1] + Array1D(FData^)[2 * (FNumData - n + 2) - 1];
    End;
  End;
  GetFSerCos := reslt / FNumData;
End;



(*********************************************************)

Function TFastFourier.GetPhase(ix : integer) : double;
(*********************************************************)

Const
  PiH               = 1.570796326794896619231;

Var
  reslt             : double;

Begin
  reslt := 0;
  If (FData <> Nil) And (ix >= 1) And (ix <= (FNumData Div 2)) Then Begin
    If (Array1D(FData^)[2 * ix + 1] <> 0) { phase = arctan(im/real) } Then reslt := arctan((Array1D(FData^)[2 * ix + 2]) / (Array1D(FData^)[2 * ix + 1]))
    Else If (Array1D(FData^)[2 * ix + 2] > 0) Then reslt := PiH
    Else reslt := -PiH;
  End;
  GetPhase := reslt;
End;



(*********************************************************)

Function TFastFourier.GetMaxReal : double;
(*********************************************************)

Begin
  If Not MaxValuesValid Then Begin
    CalcMaxValues;
    MaxValuesValid := true;
  End;
  GetMaxReal := FMaxReal;
End;

(*********************************************************)

Function TFastFourier.GetMaxImag : double;
(*********************************************************)

Begin
  If Not MaxValuesValid Then Begin
    CalcMaxValues;
    MaxValuesValid := true;
  End;
  GetMaxImag := FMaxImag;
End;


(*********************************************************)

Function TFastFourier.GetMinReal : double;
(*********************************************************)

Begin
  If Not MaxValuesValid Then Begin
    CalcMaxValues;
    MaxValuesValid := true;
  End;
  GetMinReal := FMinReal;
End;

(*********************************************************)

Function TFastFourier.GetMinImag : double;
(*********************************************************)

Begin
  If Not MaxValuesValid Then Begin
    CalcMaxValues;
    MaxValuesValid := true;
  End;
  GetMinImag := FMinImag;
End;




(*********************************************************)

Procedure TFastFourier.DoFFT(isign : integer);
(*********************************************************
 the core of this routine is based on a work of Danielson
 and Lanczos, dated back to 1942 (FFT with decimation in
 time)
 *********************************************************)

Var
  ii, jj, mmax, m, j, i : integer;
  step              : integer;
  wr, wpr, wpi, wi  : double;
  phi               : double;
  auxr, auxi        : double;

Begin
  j := 1;
  For ii := 1 To FNumData Do { shuffle data according to bit reversal }  Begin
    i := 2 * ii - 1;
    If (j > i) Then Begin
      auxr := Array1D(FData^)[j];
      Array1D(FData^)[j] := Array1D(FData^)[i];
      Array1D(FData^)[i] := auxr;
      auxr := Array1D(FData^)[j + 1];
      Array1D(FData^)[j + 1] := Array1D(FData^)[i + 1];
      Array1D(FData^)[i + 1] := auxr;
    End;
    m := FNumData;
    While ((m >= 2) And (j > m)) Do Begin
      j := j - m;
      m := m Div 2;
    End;
    j := j + m;
  End;

  mmax := 2;                            { now take the 1-point transforms and }
  While 2 * FNumData > mmax Do { successively combine them to length FNumData }  Begin
    step := 2 * mmax;
    phi := 2 * Pi * isign / mmax;
    wpr := -2.0 * sqr(sin(0.5 * phi));
    wpi := sin(phi);
    wr := 1.0;
    wi := 0.0;
    For ii := 1 To (mmax Div 2) Do Begin
      m := 2 * ii - 1;
      For jj := 0 To ((2 * FNumData - m) Div step) Do Begin
        i := m + jj * step;
        j := i + mmax;
        auxr := wr * Array1D(FData^)[j] - wi * Array1D(FData^)[j + 1];
        auxi := wr * Array1D(FData^)[j + 1] + wi * Array1D(FData^)[j];
        Array1D(FData^)[j] := Array1D(FData^)[i] - auxr;
        Array1D(FData^)[j + 1] := Array1D(FData^)[i + 1] - auxi;
        Array1D(FData^)[i] := Array1D(FData^)[i] + auxr;
        Array1D(FData^)[i + 1] := Array1D(FData^)[i + 1] + auxi;
      End;
      auxr := wr;
      wr := wr * wpr - wi * wpi + wr;
      wi := wi * wpr + auxr * wpi + wi;
    End;
    mmax := step;
  End;
  If isign < 0 Then
    For i := 1 To FNumData Do { scale the result for inverse FFT }  Begin
      Array1D(FData^)[2 * i - 1] := Array1D(FData^)[2 * i - 1] / FNumData;
      Array1D(FData^)[2 * i] := Array1D(FData^)[2 * i] / FNumData;
    End;
  MaxValuesValid := False;
End;


(*********************************************************)

Procedure TFastFourier.Clear;
(*********************************************************)

Var
  i                 : integer;

Begin
  For i := 1 To FNumData Do Begin
    Array1D(FData^)[2 * i - 1] := 0;
    Array1D(FData^)[2 * i] := 0;
  End;
  MaxValuesValid := False;
End;


(*********************************************************)

Procedure TFastFourier.CalcMaxValues;
(*********************************************************)

Var
  i                 : integer;
  pw                : double;
  mag               : double;

Begin
  FMaxPower := 0;
  FMaxMagni := 0;
  FMaxReal := -MaxDouble;
  FMaxImag := -MaxDouble;
  FMinReal := MaxDouble;
  FMinImag := MaxDouble;
  For i := 1 To FNumData Do Begin
    If Array1D(FData^)[2 * i] > FMaxImag Then
      FMaxImag := Array1D(FData^)[2 * i];
    If Array1D(FData^)[2 * i - 1] > FMaxReal Then
      FMaxReal := Array1D(FData^)[2 * i - 1];
    If Array1D(FData^)[2 * i] < FMinImag Then
      FMinImag := Array1D(FData^)[2 * i];
    If Array1D(FData^)[2 * i - 1] < FMinReal Then
      FMinReal := Array1D(FData^)[2 * i - 1];
  End;

  FMaxPower := 0;
  For i := 2 To (FNumData Div 2) Do Begin
    pw := sqr(Array1D(FData^)[2 * i - 1]) +
      sqr(Array1D(FData^)[2 * i]) +
      sqr(Array1D(FData^)[2 * (FNumData - i + 2) - 1]) +
    sqr(Array1D(FData^)[2 * (FNumData - i + 2)]);
    If pw > FMaxPower Then
      FMaxPower := pw;
  End;
  FMaxPower := FMaxPower / FNumData;

  FMaxMagni := 0;
  For i := 2 To (FNumData Div 2) + 1 Do Begin
    mag := sqrt(sqr(Array1D(FData^)[2 * i - 1] + Array1D(FData^)[2 * (FNumData - i + 2) - 1]) +
      sqr(Array1D(FData^)[2 * i] - Array1D(FData^)[2 * (FNumData - i + 2)]));
    If mag > FMaxMagni Then
      FMaxMagni := mag;
  End;
  FMaxMagni := FMaxMagni / FNumData;
End;



(*********************************************************)

Procedure TFastFourier.ClearReal;
(*********************************************************)

Var
  i                 : integer;

Begin
  For i := 1 To FNumData Do
    Array1D(FData^)[2 * i - 1] := 0;
  MaxValuesValid := False;
End;



(*********************************************************)

Procedure TFastFourier.ClearImag;
(*********************************************************)

Var
  i                 : integer;

Begin
  For i := 1 To FNumData Do
    Array1D(FData^)[2 * i] := 0;
  MaxValuesValid := False;
End;


(*********************************************************)

Procedure TFastFourier.Transform;
(*********************************************************
  see: R.J. Higgins, Digital Signal Processing in VLSI,
       Analog Devices, Norwood 1990, page 139
 *********************************************************)

Const
  GAlpha            = 3.0;              { width of Gaussian window }
  HAlpha            = 0.543478261;      { Hamming window parameter }
  BlkMA1            = 0.42659;          { Blackman coefficients }
  BlkMA2            = 0.49656;
  BlkMA3            = 0.076848;

Var
  i                 : integer;

Begin
  Case FWgtWin Of
    fwTriangle : Begin
        For i := 1 To (FNumData Div 2) Do { triangle window }  Begin
          Array1D(FData^)[2 * i - 1] := 2.0 * i / FNumData * Array1D(FData^)[2 * i - 1];
          Array1D(FData^)[2 * i] := 2.0 * i / FNumData * Array1D(FData^)[2 * i];
          Array1D(FData^)[2 * (1 + FNumData - i) - 1] := 2.0 * i / FNumData * Array1D(FData^)[2 * (1 + FNumData - i) - 1];
          Array1D(FData^)[2 * (1 + FNumData - i)] := 2.0 * i / FNumData * Array1D(FData^)[2 * (1 + FNumData - i)];
        End;
      End;
    fwGauss : Begin
        For i := 1 To FNumData Do { Gaussian window: exp(-0.5*sqr(GAlpha*(rix-NRow/2)/NRow*2)) }  Begin
          Array1D(FData^)[2 * i - 1] := Array1D(FData^)[2 * i - 1] *
            exp(-0.5 * sqr(3.0 * (i - FNumData / 2) / FNumData * 2));
          Array1D(FData^)[2 * i] := Array1D(FData^)[2 * i] *
            exp(-0.5 * sqr(3.0 * (i - FNumData / 2) / FNumData * 2));
        End;
      End;
    fwHamming : Begin
        For i := 1 To FNumData Do { Hamming window: HAlpha+(1-HAlpha)*cos(2*pi*(rix-nrow/2)/NRow) }  Begin
          Array1D(FData^)[2 * i - 1] := Array1D(FData^)[2 * i - 1] *
            (HAlpha + (1 - HAlpha) * cos(2 * pi * (i - FNumData / 2) / FNumData));
          Array1D(FData^)[2 * i] := Array1D(FData^)[2 * i] *
            (HAlpha + (1 - HAlpha) * cos(2 * pi * (i - FNumData / 2) / FNumData));
        End;
      End;
    fwcos2 : Begin
        For i := 1 To FNumData Do { cos2 window: sqr(cos(pi*(rix-NRow/2)/200)) }  Begin
          Array1D(FData^)[2 * i - 1] := Array1D(FData^)[2 * i - 1] *
            sqr(cos(pi * (i - FNumData / 2) / FNumData));
          Array1D(FData^)[2 * i] := Array1D(FData^)[2 * i] *
            sqr(cos(pi * (i - FNumData / 2) / FNumData));
        End;
      End;
    fwBlackman : Begin
        For i := 1 To FNumData Do { Blackman: 0.42+0.50*cos(2*pi*(rix-nrow/2)/NRow)+0.08*cos(4*pi*(rix-nrow/2)/NRow) }  Begin
          Array1D(FData^)[2 * i - 1] := Array1D(FData^)[2 * i - 1] *
            (BlkMA1 + BlkMA2 * cos(2 * pi * (i - FNumData / 2) / FNumData) + BlkMA3 * cos(4 * pi * (i - FNumData / 2) / FNumData));
          Array1D(FData^)[2 * i] := Array1D(FData^)[2 * i] *
            (BlkMA1 + BlkMA2 * cos(2 * pi * (i - FNumData / 2) / FNumData) + BlkMA3 * cos(4 * pi * (i - FNumData / 2) / FNumData));
        End;
      End;
  End;
  DoFFT(1);
End;

(*********************************************************)

Procedure TFastFourier.InverseTransform;
(*********************************************************)

Begin
  DoFFT(-1);
End;

(***********************************************************************)

Procedure Register;
(***********************************************************************)

Begin
  RegisterComponents('SDL', [TFastFourier]);
End;

End.

