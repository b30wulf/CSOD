unit math2;

(******************************************************************)
(*                                                                *)
(*                           M A T H 2                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                    Feb. 1997   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Feb-10, 2001                                  *)
(*                                                                *)
(*     The method PolyFit has been originally provided by         *)
(*     Kerry L. Davison and has been adapted to the MATH2 unit    *)
(*     by permission of Kerry - thanks Kerry !                    *)
(*                                                                *)
(*                                                                *)
(******************************************************************)


{ revision history:

1.0   released November 1996

1.5   [May-28, 1997]
      C++ Version is now available

1.6   [Apr-08, 1998]
      MATH2 now available for C++Builder 3.0
      Kolmogorov-Smirnov one-sample test statistic
      GetEigenSize implemented
      DCommon no longer needed
      WeibullDensity implemented
      PolyFit implemented (basic code supplied by Kerry L. Davison - thanks Kerry !)
      LnGamma implemented
      LnBeta implemented
      LnBinomCoeff, and BinomCoeff implemented
      ESDLMath2Error implemented
      PolynomialSmooth implemented (alg. Savitzky/Golay)
      FirstDeriv implemented

1.7   [Jul-23, 1998]
      MATH2 now available for Delphi 4.0
      statistical function moved to STATIS
          (Kolmogorov-Smirnov, WeibullDensity, LnGamma, LnBeta, LnBinomCoeff, BinomCoeff,
           ndistri, tdistri)
      Agglomerative clustering implemented

1.8   [Mar-07, 1999]
      TCurveFit now additionally stores the data entered to it
      properties DataX and DataY implemented
      method RemoveStatValue implemented

5.0   [Sep-16, 1999]
      bug fixed in MeanDistanceKNN and FindNearestNeighbors which caused
      wrong results with Delphi 1 to 3 (but not Delphi 4) fixed
      cubic spline interpolation implemented (methods and properties CubicSpline,
              SplineNatural1, SplineNaturalN, SplineDerivY1, SplineDerivYN)
      multiple linear regression implemented (MultiLinreg)
      singular value decomposition implemented (SingValDecomp, SingValEquSolve)

5.5   [May-21, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      CalcEigVec now increments the ProcStat variable with better granularity
      CalcCovar and CalcEigVec can be aborted by setting AbortMathProc
      EstimateByKNN implemented
      FindNearestNeighbors improved: distance calculation can now be performed by a user
         defined function
}

{$O+}
{$F+}

{--------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                       }
{--------------------------------------------------------------------}

{--------------------------------------------------------------------}
{-$DEFINE DEBUG}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                       }
{--------------------------------------------------------------------}

{--------------------------------------------------------------------}
{-$DEFINE DEVELOPVERS}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                       }
{--------------------------------------------------------------------}

{$IFNDEF SDLBATCH}
  {$IFDEF VER110}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 3.0 }
  {$ENDIF}
  {$IFDEF VER125}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 4.0 }
  {$ENDIF}
  {$IFDEF VER135}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 5.0 }
  {$ENDIF}
{$ENDIF}

{------------------------------------------------------------------------------}
interface
{------------------------------------------------------------------------------}

uses
  sysutils, math1, matrix, vector;

const
  MaxPolyFitOrder = 8;  { maximum number of polynomial terms in CurveFit,
                        do not increase it - higher orders yield poor
                        results due to round-off errors }

type
  ESDLMath2Error = class(Exception);     { exception type to indicate errors }
  TCalcDistFunc = function (ix: integer): double;
  TClusterMethod = (cmSingleLink, cmCompleteLink, cmWard, cmAvgLink, cmFlexLink);
  TKnnWMode = (kwmGauss, kwmAverage, kwmMedian);
  TCurveFit =
    class (TObject)
    private
      sumx, sumy        : double;
      sumxq, sumyq      : double;
      sumDiff, SumDiffq : double;
      sumxy             : double;
      sumx2y, sumx3     : double;
      sumx4             : double;
      sum1byy           : double;
      sum1byyq          : double;
      sumxbyy           : double;
      sumybyx           : double;
      sum1byx           : double;
      sum1byxq          : double;
      sumlnx            : double;
      sumlnxq           : double;
      sumylnx           : double;
      sumlny            : double;
      sumlnyq           : double;
      sumxlny           : double;
      sumxqlny          : double;
      FNumData          : longint;
      FNatural1         : boolean;
      FNaturalN         : boolean;
      FY1Dash           : double;
      FYNDash           : double;
      SumXArray         : TVector;
      RHS               : TVector;
      Spl2Deriv         : TVector;
      SplSortedX        : TVector;
      SplSortedY        : TVector;
      FData             : TMatrix;
      FSplineValid      : boolean;
      function GetMeanX: double;
      function GetMeanY: double;
      function GetStdDevX: double;
      function GetStdDevY: double;
      function GetMeanDiff: double;
      function GetStdDevDiff: double;
      function GetRxy: double;
      function GetDataX(ix: integer): double;
      function GetDataY(ix: integer): double;
      procedure ExchangeDuringSort (Sender: TObject; ExchgWhat: byte;
                               index1, index2, first, last: longint);
      procedure PrepareSpline;
      procedure SetNatural1 (value: boolean);
      procedure SetNaturalN (value: boolean);
      procedure SetY1Dash (value: double);
      procedure SetYNDash (value: double);
    public
      constructor Create;
      destructor Destroy; override;
      procedure Init;
      procedure EnterStatValue (x,y: double);
      procedure RemoveStatValue (ix: integer);
      procedure CalcStatistics (var NumData: longint;
           var MeanX, MeanY, StdevX, StdevY, MeanDiff,
           StdevDiff, rxy: double);
      procedure CalcGaussFit (var k0, k1, k2, FitQual: double);
      procedure CalcLinFit (var k, d, FitQual: double);
      procedure CalcLogFit (var k0, k1, FitQual: double);
      procedure CalcParabolFit (var k0, k1, k2, FitQual: double);
      function  CalcPolyFit (const nOrder: byte; var kArray: array of double;
                            var FitQual: double): boolean;
      procedure CalcReciLinFit (var k0, k1, FitQual: double);
      procedure CalcHyperbolFit (var k0, k1, FitQual: double);
      function  CubicSpline (x: double): double;
      property  DataX[ix: integer]: double read GetDataX;
      property  DataY[ix: integer]: double read GetDataY;
      property  NumData: longint read FNumData;
      property  MeanX: double read GetMeanX;
      property  MeanY: double read GetMeanY;
      property  StdDevX: double read GetStdDevX;
      property  StdDevY: double read GetStdDevY;
      property  MeanDiff: double read GetMeanDiff;
      property  StdDevDiff: double read GetStdDevDiff;
      property  CorrCoeff: double read GetRxy;
      property  SplineDerivY1: double read FY1dash write SetY1Dash;
      property  SplineDerivYN: double read FYNdash write SetYNDash;
      property  SplineNatural1: boolean read FNatural1 write SetNatural1;
      property  SplineNaturalN: boolean read FNaturalN write SetNaturalN;
    end;


function  AgglomClustering
            (InMat : TMatrix;
   DistanceMeasure : TDistMode;
     ClusterMethod : TClusterMethod;
             alpha : double;
   var ClustResult : TIntMatrix;
     var ClustDist : TVector;
  var DendroCoords : TVector)
                   : integer;
function  CalcCovar
           (InData : TMatrix;                         { input data }
          CovarMat : TMatrix;                  { covariance matrix }
          LoC, HiC : integer;                   { range of columns }
          LoR, HiR : integer;                      { range of rows }
           Scaling : integer)   { 0=none, 1=mean cent., 2=autoscl. }
                   : boolean;                    { TRUE if success }
function  CalcEigVec
            (InMat : TMatrix)             { symmetric input matrix }
                   : boolean;                    { TRUE if success }
function  CalcFishQ
            (m1,m2,                     { mean values, class 1 & 2 }
             s1,s2 : double)                 { standard deviations }
                   : double;                        { Fisher ratio }
function  CalcGaussKernel
            (Probe : TVector;                     { probe position }
         RefCenter : TVector;                   { center of kernel }
             Width : double)                     { width of kernel }
                   : double;                              { result }
function  CalcGaussKernelMat
            (Probe : TVector;                     { probe position }
      RefCenterMat : TMatrix;           { matrix of kernel centers }
       RefCenterIx : integer;       { index into the kernel matrix }
             Width : double)                     { width of kernel }
                   : double;                              { result }
function  CalcPrincComp
           (InData : TMatrix;              { pointer to data array }
          LoC, HiC : integer;                   { range of columns }
          LoR, HiR : integer;                      { range of rows }
           Scaling : integer)  { 0=none, 1=mean cent., 2=autoscal. }
                   : boolean;                    { TRUE if success }
procedure EstimateByKNN
            (InMat : TMatrix;       { matrix containing known data }
         TargetVec : TVector;             { target training vector }
                kn : integer;        { number of nearest neighbors }
     WeightingMode : TKnnWMode;{weighting mode used for estimation }
        SmoothFact : double;                    { smoothing factor }
          EstInVar : TVector;             { values to be estimated }
     var EstTarget : double;              { estimated target value }
   var EstMeanDist : double);      { mean distance of kn neighbors }
procedure FindCenters
            (InMat : TMatrix;                        { data matrix }
      RowLo, RowHi : integer;                { first & last object }
           NumCent : integer;                  { number of centers }
       var Centers : TMatrix;                  { matrix of centers }
      var MeanDist : double);                      { mean distance }
procedure FindNearestNeighbors
                (k : integer;                { number of neighbors }
             InMat : TMatrix;              { matrix to be searched }
          FirstObj : integer;                       { first object }
           LastObj : integer;                        { last object }
            DatVec : TVector;              { vector to be searched }
           KNNList : TMatrix;                             { result }
          CalcDist : TCalcDistFunc);          { calculate distance }
procedure FirstDeriv
        (SourceVec : TVector;{ vector with the data to be smoothed }
         FirstElem,                   { start index into SourceVec }
          LastElem : integer;          { stop index into SourceVec }
           DestVec : TVector;                      { result vector }
        WindowSize : integer);              { length of polynomial }
function  GetEigenResult
        (EigVecNum : integer;              { number of eigenvector }
           VecElem : integer)                     { vector element }
                   : double;                      { matrix element }
function  GetEigenSize
                   : integer;               { size of eigenvectors }
procedure MeanDistanceKNN
            (InMat : TMatrix;                        { data matrix }
                kn : integer;             { # of nearest neighbors }
          FirstRow : integer;            { first object to be used }
           LastRow : integer;             { last object to be used }
        var DistVec: TVector);               { result for each obj }
function MultiLinReg
           (InData : TMatrix;                { params of equations }
           OutData : TVector;                  { bias of equations }
             Coeff : TVector;                  { fitted parameters }
        DeltaCoeff : TVector)            { errors in fitted params }
                   : boolean;               { TRUE if result valid }
procedure PolynomialSmooth
        (SourceVec : TVector;{ vector with the data to be smoothed }
         FirstElem,                   { start index into SourceVec }
          LastElem : integer;          { stop index into SourceVec }
           DestVec : TVector;                      { result vector }
        WindowSize : integer);              { length of polynomial }
procedure RemoveEigenMatrix;
function SingValDecomp
            (MatAU : TMatrix;                   { input/output NxP }
              MatV : TMatrix;                  { output matrix PxP }
              VecW : TVector)            { diag. output matrix PxP }
                   : boolean;               { TRUE if result valid }
function SingValEquSolve
            (MatAU : TMatrix;              { decomposed matrix NxP }
              MatV : TMatrix;              { decomposed matrix PxP }
              VecW : TVector;                { singular values PxP }
              VecB : TVector;                { bias vector, size N }
              VecX : TVector;                   { solution, size P }
             VecdX : TVector)           { stddev. of solut, size P }
                   : boolean;               { TRUE if result valid }


{$IFDEF DEVELOPVERS}              { this is the interface section of }
{-$I math2dvi.inc}                      { the untested part of MATH2 }
{$ENDIF}

{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

{$R-}

uses
{$IFDEF DEBUG}
  stringl,
{$ENDIF}
  wintypes, winprocs {$IFDEF SHAREWARE}, dialogs {$ENDIF};

const
  SmallPosNum = 1e-30;
  ChunkSize = 1000;   { number of data cells allocated for TCurveFit }


type
  Array1D  = array[1..1] of double;
  Array1DI = array[1..1] of integer;

var
  EigVecPoi         : ^Array1D;
  EigValPoi         : ^Array1D;
  EigenDefined      : boolean;
  EigenSize         : integer;          { size of eigenvector matrix }


{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\math2_ct.inc}
{$ENDIF}


{$IFDEF DEVELOPVERS}         { this is the implementation section of }
{-$I math2dv.inc}                       { the untested part of MATH2 }
{$ENDIF}


(******************************************************************)
procedure PolynomialSmooth (SourceVec: TVector; FirstElem,
          LastElem: integer; DestVec: TVector; WindowSize: integer);
(******************************************************************
  ENTRY:   SourceVec ....... vector containing the data to be smoothed
           FirstElem ....... index into SourceVec where to start calculations
           LastElem ........ last element of SourceVec to be processed
           DestVec ......... vector which will hold the results
           WindowSize ...... number of data points to be included per step

  EXIT:    The vector DestVec contains the smoothed values

  REMARK:  The algorithm has been implemented acc. to the following paper:
           A. Savitzky, M.J.E. Golay: Anal.Chem. 36 (1964) 162
 ******************************************************************)

const
  GolayPoly : array[1..11,-1..12] of integer =
       {  Norm   0    1    2    3    4    5    6    7    8    9   10   11   12}
       {----------------------------------------------------------------------}
  {5}  ((  35,  17,  12,  -3,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0),
  {7}   (  21,   7,   6,   3,  -2,   0,   0,   0,   0,   0,   0,   0,   0,   0),
  {9}   ( 231,  59,  54,  39,  14, -21,   0,   0,   0,   0,   0,   0,   0,   0),
 {11}   ( 429,  89,  84,  69,  44,   9, -36,   0,   0,   0,   0,   0,   0,   0),
 {13}   ( 143,  25,  24,  21,  16,   9,   0, -11,   0,   0,   0,   0,   0,   0),
 {15}   (1105, 167, 162, 147, 122,  87,  42, -13, -78,   0,   0,   0,   0,   0),
 {17}   ( 323,  43,  42,  39,  34,  27,  18,   7,  -6, -21,   0,   0,   0,   0),
 {19}   (2261, 269, 264, 249, 224, 189, 144,  89,  24, -51,-136,   0,   0,   0),
 {21}   (3059, 329, 324, 309, 284, 249, 204, 149,  84,   9, -76,-171,   0,   0),
 {23}   ( 805,  79,  78,  75,  70,  63,  54,  43,  30,  15,  -2, -21, -42,   0),
 {25}   (5175, 467, 462, 447, 422, 387, 343, 287, 222, 147,  62, -33,-138,-253));

var
  ix   : integer;
  i, j : integer;
  half : integer;
  sum  : double;


begin
if (SourceVec = NIL ) or (DestVec = NIL) then
  raise ESDLMath2Error.Create ('PolynomialSmooth: either SourceVec or DestVec is undefined');
if FirstElem < 1 then
  FirstElem := 1;
if FirstElem > SourceVec.NrofElem then
  FirstElem := SourceVec.NrofElem;
if LastElem < 1 then
  LastElem := 1;
if LastElem > SourceVec.NrofElem then
  LastElem := SourceVec.NrofElem;
if FirstElem > LastElem then
  ExChange (FirstElem, LastElem, sizeof(FirstElem));
if (LastElem-FirstElem < WindowSize) then
  raise ESDLMath2Error.Create ('PolynomialSmooth: specified range for smoothing is smaller than the length of the polynomial');
if (WindowSize < 5) or (WindowSize > 25) then
  raise ESDLMath2Error.Create ('PolynomialSmooth: length of polynomial is out of range');
if (WindowSize mod 2) = 0 then
  raise ESDLMath2Error.Create ('PolynomialSmooth: length of polynomial must be odd');
ix := (WindowSize-3) div 2;
half := WindowSize div 2;
for i:=half+FirstElem to LastElem-half do
  begin
  sum := GolayPoly[ix,0]*SourceVec.Elem[i];
  for j:=1 to half do
    sum := sum + GolayPoly[ix,j]*(SourceVec.Elem[i+j]+SourceVec.Elem[i-j]);
  DestVec.Elem[i-FirstElem+1] := sum/GolayPoly[ix,-1];
  end;
for i:=1 to half do
  DestVec.Elem[i] := DestVec.Elem[half+1];
for i:=LastElem-FirstElem+1 downto LastElem-FirstElem-half+2 do
  DestVec.Elem[i] := DestVec.Elem[LastElem-FirstElem-half+1];
DestVec.Changed;
end;


(******************************************************************)
procedure FirstDeriv (SourceVec: TVector; FirstElem,
          LastElem: integer; DestVec: TVector; WindowSize: integer);
(******************************************************************
  ENTRY:   SourceVec ....... vector containing the data to be smoothed
           FirstElem ....... index into SourceVec where to start calculations
           LastElem ........ last element of SourceVec to be processed
           DestVec ......... vector which will hold the results
           WindowSize ...... number of data points to be included per step

  EXIT:    The vector DestVec contains the smoothed 1st derivative

  REMARK:  The algorithm has been implemented acc. to the following paper:
           A. Savitzky, M.J.E. Golay: Anal.Chem. 36 (1964) 1627
 ******************************************************************)

const
  MinDiff = 2;     (* 1st derivative: minimum = 5 points *)
  MaxDiff = 12;    (* 1st derivative: minimum = 25 points *)
  DiffNorm : array[MinDiff..MaxDiff] of integer =  { scaling coeff. for smoothed 1st derivative }
       (10,28,60,110,182,280,408,570,770,1012,1300);

var
  i, j : integer;
  half : integer;
  sum  : double;

begin
if (SourceVec = NIL ) or (DestVec = NIL) then
  raise ESDLMath2Error.Create ('FirstDeriv: either SourceVec or DestVec is undefined');
if FirstElem < 1 then
  FirstElem := 1;
if FirstElem > SourceVec.NrofElem then
  FirstElem := SourceVec.NrofElem;
if LastElem < 1 then
  LastElem := 1;
if LastElem > SourceVec.NrofElem then
  LastElem := SourceVec.NrofElem;
if FirstElem > LastElem then
  ExChange (FirstElem, LastElem, sizeof(FirstElem));
if (LastElem-FirstElem < WindowSize) then
  raise ESDLMath2Error.Create ('FirstDeriv: specified range for calculation is smaller than the length of the polynomial');
if (WindowSize < 5) or (WindowSize > 25) then
  raise ESDLMath2Error.Create ('FirstDeriv: length of polynomial is out of range');
if (WindowSize mod 2) = 0 then
  raise ESDLMath2Error.Create ('FirstDeriv: length of polynomial must be odd');
half := WindowSize div 2;
for i:=half+FirstElem to LastElem-half do
  begin
  sum := 0;
  for j:=-half to +half do
    sum := sum + j*SourceVec.Elem[i+j];
  DestVec.Elem[i-FirstElem+1] := sum/DiffNorm[half];
  end;
for i:=1 to half do
  DestVec.Elem[i] := DestVec.Elem[half+1];
for i:=LastElem-FirstElem+1 downto LastElem-FirstElem-half+2 do
  DestVec.Elem[i] := DestVec.Elem[LastElem-FirstElem-half+1];
DestVec.Changed;
end;


(******************************************************************)
function CalcCovar (InData: TMatrix;   CovarMat: TMatrix;
                    LoC, HiC, LoR, HiR: integer;
                    Scaling: integer): boolean;
(******************************************************************
  ENTRY:   InData ....... pointer to input data matrix
           CovarMat ..... covariance matrix
           LoC, HiC ..... column indices of 'Datamatrix' to be used for calc.
           LoR, HiR ..... row indices of 'Datamatrix' to be used for calc.
           Scaling ...... 0 = none, 1 = mean centering, 2 = autoscaling

  EXIT:    Scaling = 0: scatter matrix
           Scaling = 1: covariance matrix
           Scaling = 2: correlation matrix calculated
           function returns TRUE if matrix is valid
 ******************************************************************)

var
  reslt      : boolean;
  Means      : TVector;
  Vari       : TVector;
  CovarNCol  : integer;


function DoCovarCalculation: boolean;
(*---------------------------------*)

var
  IzRows  : integer;
  i,j,k   : integer;
  sum     : double;
  Varik   : double;

begin
IzRows := HiR-LoR+1;
if Scaling > 0 then
  begin
  Means.Fill(0);        (* calculate means and stddevs *)
  Vari.Fill(0);
  for i:=LoR to HiR do
    begin
    for j:=LoC to HiC do
      begin
      Means.Elem[j-LoC+1] := Means.Elem[j-LoC+1]+InData.Elem[j,i];
      Vari.Elem[j-LoC+1] := Vari.Elem[j-LoC+1]+sqr(InData.Elem[j,i]);
      end;
    inc (ProcStat);
    if addr(MathFeedBackProc) <> NIL then
      MathFeedBackProc (ProcStat);
    end;
  for i:=1 to CovarNCol do
    Vari.Elem[i] := (Vari.Elem[i]-sqr(Means.Elem[i])/IzRows)/(IzRows-1);
  for i:=1 to CovarNCol do
    Means.Elem[i] := Means.Elem[i]/IzRows;
  end;

i:=0;
while (i < CovarNCol) and not AbortMathProc do           (* calculate covariance matrix *)
  begin
  inc(i);
  inc (ProcStat);
  if addr(MathFeedBackProc) <> NIL then
    MathFeedBackProc (ProcStat);
  for k:=1 to i do
    begin
    sum := 0;
    case Scaling of
       0 : begin
           for j:=1 to IzRows do
             sum := sum + InData.Elem[LoC+i-1,LoR+j-1] * InData.Elem[LoC+k-1,LoR+j-1];
           end;
       1 : begin
           for j:=1 to IzRows do
             sum := sum + (InData.Elem[LoC+i-1,LoR+j-1] - Means.Elem[i])
                        * (InData.Elem[LoC+k-1,LoR+j-1] - Means.Elem[k]);
           end;
       2 : begin
           Varik := sqrt(Vari.Elem[i] * Vari.Elem[k]);
           if Varik = 0.0 then
             Varik := 1e-38;
            for j:=1 to IzRows do
              sum := sum + (InData.Elem[LoC+i-1,LoR+j-1] - Means.Elem[i])*
                           (InData.Elem[LoC+k-1,LoR+j-1] - Means.Elem[k])/varik;
           end;
    end;
    sum := sum/(IzRows-1);
    CovarMat.Elem[k,i] := sum;
    CovarMat.Elem[i,k] := CovarMat.Elem[k,i];
    if (k=i) and (Scaling = 2) then  { force to 1.0 for cross correlation }
      CovarMat.Elem[i,k] := 1.0;
    end;
  end;
DoCovarCalculation := not AbortMathProc;
end;


begin
AbortMathProc := false;
reslt := false;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  CalcCovar := reslt;
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
CovarNCol := HiC-LoC+1;
if ((CovarMat.NrOfColumns >= CovarNCol) and
    (CovarMat.NrOfRows >= CovarNCol)) then
  begin
  Means := TVector.Create (CovarNCol);
  if (Means <> NIL) then
    begin
    Vari := TVector.Create (CovarNCol);
    if (Vari <> NIL) then
      reslt := DoCovarCalculation;
    end;
  end;
Vari.Free;
Means.Free;
CalcCovar := reslt;
end;




(******************************************************************)
function CalcEigVec (InMat: TMatrix): boolean;
(******************************************************************
  ENTRY:    InMat .... quadratic, symmetric data matrix (normally
            the covariance or correlation matrix)

  EXIT:     Function returns TRUE if eigenvalues/eigenvectors are
            valid. The reslt  is stored on the heap an can be retrieved
            by using routine 'GetEigenResult '. The matrix 'InMat' is
            partly destroyed !
 ******************************************************************)

const
{$IFDEF VER80}      { restrict only in 16-Bit version }
  EigenSizeMax = 90;
{$ELSE}
  EigenSizeMax = 10000;
{$ENDIF}

var
  reslt    : boolean;
  Size     : integer;

function DoEigenCalc: boolean;
(*--------------------------*)

const
  MaxRot = 100;   (* maximum number of rotations *)

var
  s0            : double;
  tarc          : array [1..EigenSizeMax] of double;
  EigVBak       : array [1..EigenSizeMax] of double;
  EigRes        : boolean;
  EigenCalcDone : boolean;
  RotCnt        : integer;


procedure RotateOnce;
(*-----------------*)

var
  rix, cix      : integer;
  i             : integer;
  epsil         : double;
  tau, t        : double;
  aux2          : double;
  aux3, aux4    : double;

begin
if RotCnt < 4
  then epsil := 0.2*s0/sqr(Size)
  else epsil := 0;
rix := 0;
while ((rix < Size-1) and not AbortMathProc) do
  begin
  inc (rix);
  cix := rix;
  while ((cix < Size) and not AbortMathProc) do
    begin
    inc (cix);
(*
for rix := 1 to Size-1 do
  begin
  for cix := rix+1 to Size do
    begin
*)
    inc (ProcStat);
    if addr(MathFeedBackProc) <> NIL then
      MathFeedBackProc (ProcStat);
    aux2 := 200*abs(InMat.Elem[cix, rix]);
    if ((RotCnt > 4) and ((abs(EigValPoi^[rix])+aux2) = abs(EigValPoi^[rix]))
              and ((abs(EigValPoi^[cix])+aux2) = abs(EigValPoi^[cix])))
      then InMat.Elem [cix, rix] := 0
      else if (abs(InMat.Elem[cix, rix]) > epsil)
             then begin
                  aux3 := EigValPoi^[cix]-EigValPoi^[rix];
                  if ((abs(aux3)+aux2) = abs(aux3)) (* trick to prevent overflow *)
                    then t := InMat.Elem[cix, rix]/aux3
                    else begin
                         aux4 := aux3/InMat.Elem[cix, rix]/2;
                         t:=1/(sqrt(1+sqr(aux4))+abs(aux4));
                         if (aux4 < 0) then
                           t := -t;
                         end;
                  aux4:=t*1/sqrt(1+sqr(t));
                  tau := aux4/(1+1/sqrt(1+sqr(t)));
                  aux3:= t*InMat.Elem[cix, rix];
                  InMat.Elem[cix, rix] := 0;
                  EigValPoi^[rix] := EigValPoi^[rix]-aux3;
                  EigValPoi^[cix] := EigValPoi^[cix]+aux3;
                  tarc[rix] := tarc[rix]-aux3;
                  tarc[cix] := tarc[cix]+aux3;
                  for i:=1 to rix-1 do
                    begin
                    aux2 := InMat.Elem[rix,i];
                    aux3 := InMat.Elem[cix,i];
                    InMat.Elem[cix,i] := aux3+aux4*(aux2-aux3*tau);
                    InMat.Elem[rix,i] := aux2-aux4*(aux3+aux2*tau);
                    end;
                  for i:=rix+1 to cix-1 do
                    begin
                    aux2 := InMat.Elem[i,rix];
                    aux3 := InMat.Elem[cix,i];
                    InMat.Elem[cix,i] := aux3+aux4*(aux2-aux3*tau);
                    InMat.Elem[i,rix] := aux2-aux4*(aux3+aux2*tau);
                    end;
                  for i:=cix+1 to Size do
                    begin
                    aux2 := InMat.Elem[i,rix];
                    aux3 := InMat.Elem[i,cix];
                    InMat.Elem[i,cix] := aux3+aux4*(aux2-aux3*tau);
                    InMat.Elem[i,rix] := aux2-aux4*(aux3+aux2*tau);
                    end;
                  for i:=1 to Size do
                    begin
                    aux2 := EigVecPoi^[(i-1)*Size+rix];
                    aux3 := EigVecPoi^[(i-1)*Size+cix];
                    EigVecPoi^[(i-1)*Size+rix] := aux2-aux4*(aux3+aux2*tau);
                    EigVecPoi^[(i-1)*Size+cix] := aux3+aux4*(aux2-aux3*tau);
                    end;
                  end;
    end;
  end;
for cix:=1 to Size do
  begin
  EigVBak[cix] := EigVBak[cix]+tarc[cix];
  EigValPoi^[cix] := EigVBak[cix];
  tarc[cix] := 0;
  end;
end;


var
  cix, rix  : integer;

begin                        (* DoEigenCalc *)
AbortMathProc := false;
EigRes := true;
for rix:= 1 to Size do
  begin
  for cix:= 1 to Size do
    EigVecPoi^[(rix-1)*Size+cix] := 0;
  EigVecPoi^[(rix-1)*Size+rix] := 1;
  end;
for rix:=1 to Size do
  begin
  tarc[rix] := 0;
  EigVBak[rix] := InMat.Elem[rix,rix];
  EigValPoi^[rix] := InMat.Elem[rix,rix];
  end;
EigenCalcDone := False;
RotCnt := 1;
while not EigenCalcDone and not AbortMathproc do
  begin
  inc (ProcStat);
  if addr(MathFeedBackProc) <> NIL then
    MathFeedBackProc (ProcStat);
  s0 := 0;
  for rix:= 1 to Size-1 do
    for cix:= rix+1 to Size do
      s0 := s0+abs(InMat.Elem[cix,rix]);
  if s0 = 0
    then EigenCalcDone := True
    else RotateOnce;
  inc (RotCnt);
  if RotCnt > MaxRot then
    begin
    EigRes := False;
    EigenCalcDone := True;
    end;
  end;
if AbortMathProc then
  EigRes := false;
DoEigenCalc := EigRes;
end;



begin                             (* CalcEigenVec *)
reslt  := false;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  CalcEigVec := reslt;
  Exit;
  end;
{$ENDIF}
Size := InMat.NrOfColumns;
if SIze <= EigenSizeMax then
  begin
  if EigenDefined then
    begin
    FreeMem (EigVecPoi,EigenSize*EigenSize*SIzeOf(double));
    FreeMem (EigValPoi,EigenSize*SIzeOf(double));
    end;
  EigenSize := Size;
  GetMem (EigVecPoi, EigenSize*EigenSize*SizeOf(double));
  if (EigVecPoi = NIL)
    then EigenDefined := False
    else begin
         GetMem (EigValPoi, EigenSize*SizeOf(double));
         if (EigValPoi = NIL)
           then begin
                FreeMem (EigVecPoi, EigenSize*EigenSize*SizeOf(double));
                EigenDefined := False;
                end
           else begin
                EigenDefined := True;
                reslt  := DoEigenCalc;
                end;
         end;
  end;
CalcEigVec := reslt ;
end;


(******************************************************************)
function GetEigenResult  (EigVecNum, VecElem: integer): double;
(******************************************************************
  ENTRY:   EigVecNum .... index of Eigenvector
           VecElem ...... index of element of eigenvector
                          VecElem = 0 return eigenvalue

  EXIT:    value of eigenvector or eigenvalue
 ******************************************************************)


begin
if EigenDefined
  then if ((VecElem < 0) or (VecElem > EIgenSize) or
           (EigVecNum < 1) or (EigVecNum > EigenSize))
         then GetEigenResult  := 0
         else if VecElem = 0
                then GetEigenResult  := EigValPoi^[EigVecNum]
                else GetEigenResult  := EigVecPoi^[(VecElem-1)*EigenSize+EigVecNum]
  else GetEigenResult  := 0;
end;


(******************************************************************)
function GetEigenSize: integer;
(******************************************************************
  function returns size of eigenvectors
 ******************************************************************)

begin
GetEigenSize := EigenSize;
end;


(******************************************************************)
procedure RemoveEigenMatrix;
(******************************************************************
  ENTRY:   none
  EXIT:    eigenvalue/eigenvector matrix is removed from heap
 ******************************************************************)


begin
if EigenDefined then
  begin
  FreeMem (EigVecPoi, EigenSize*EigenSize*SizeOf(double));
  FreeMem (EigValPoi, EigenSize*SizeOf(double));
  EigenDefined := False;
  end;
end;


(******************************************************************)
function CalcPrincComp (InData: TMatrix;
                        LoC, HiC, LoR, HiR: integer;
                        Scaling: integer): boolean;
(******************************************************************
  ENTRY:   InData ....... pointer to input data matrix
           LoC, HiC ..... column indices of 'Datamatrix' to be used for calc.
           LoR, HiR ..... row indices of 'Datamatrix' to be used for calc.
           Scaling ...... 0 = none, 1 = mean centering, 2 = autoscaling

  EXIT:    principal components are calculated and stored as Eigenvectors
           function returns TRUE if matrix is valid
 ******************************************************************)

var
  reslt  : boolean;
  sum    : double;
  i,j    : integer;
  rdummy : double;
  Max    : double;
  MaxIdx : integer;
  CovarMat : TMatrix;

begin
CovarMat := TMatrix.Create (HiC-LoC+1,HiC-LoC+1);
reslt  := CalcCovar (InData, CovarMat, LoC, HiC, LoR, HiR, Scaling);
if reslt  then
  reslt  := CalcEigVec (CovarMat);
if CovarMat <> NIL then
  CovarMat.Free;
if reslt  then
  begin
  sum := 0;
  for i:=1 to EigenSize do
    sum := sum + abs(EigValPoi^[i]);
  if sum <> 0 then
    for i:=1 to EigenSize do
      EigValPoi^[i] := EigValPoi^[i]/sum;
  for i:=1 to EigenSize do
    begin
    Max := 0;
    MaxIdx := i;
    for j:=i to EigenSize do
      if EigValPoi^[j] > Max then
        begin
        MaxIdx := j;
        max := EigValPoi^[j];
        end;
    rdummy := EigValPoi^[MaxIdx];
    EigValPoi^[MaxIdx] := EigValPoi^[i];
    EigValPoi^[i] := rdummy;
    for j:=1 to EigenSize do
      begin
      rdummy := EigVecPoi^[(j-1)*EigenSize+MaxIdx];
      EigVecPoi^[(j-1)*EigenSize+MaxIdx] := EigVecPoi^[(j-1)*EigenSize+i];
      EigVecPoi^[(j-1)*EigenSize+i] := rdummy;
      end;
    end;
  end;
CalcPrincComp := reslt ;
end;



(******************************************************************)
function CalcFishQ (m1,m2,s1,s2: double): double;
(******************************************************************
  ENTRY:  m1, m2 ..... mean values of class 1 and class 2
          s1, s2 ..... standard deviations of class 1 & 2

  EXIT:   function returns Fisher ratio
 ******************************************************************)

var
  sum : double;

begin
sum := sqr(s1) + sqr(s2);
if sum < 1e-6 then
  sum := 1e-6;
CalcFishQ := sqr(m1-m2)/sum;
end;


(************************************************************************)
procedure MeanDistanceKNN (InMat: TMatrix;   kn: integer;
                           FirstRow, LastRow: integer;
                           var DistVec: TVector);
(************************************************************************
  This procedure determines the mean distance of the kn nearest neighbors
  for each object in 'InMat'. The result  is stored in 'DistVec'. The user
  has to take care for the proper size of 'DistVec'.

  ENTRY: InMat ....... matrix of data points (row = objects)
         kn .......... number of nearest neighbors (1 <= kn <= 50)
         FirstRow .... index of first object to be considered
         LastRow ..... index of last object to be considered

  EXIT:  DistVec ..... mean distance of objects 'FirstRow'..'LastRow'
                       to their 'kn' nearest neighbours
 ************************************************************************)

const
  MaxK = 50;

var
  i, k   : integer;
  obj    : integer;
  Dist   : array[1..MaxK] of double;
  DistIx : array[1..MaxK] of integer;
  d      : double;
  NCol   : integer;
  ix     : word;

begin
if FirstRow < 1 then
  FirstRow := 1;
if LastRow < 1 then
  LastRow := 1;
if FirstRow > InMat.NrOfRows then
  FirstRow := InMat.NrOfRows;
if LastRow > InMat.NrOfRows then
  LastRow := InMat.NrOfRows;
if FirstRow > LastRow then
  begin
  i := FirstRow;
  FirstRow := LastRow;
  LastRow := i;
  end;
NCol := InMat.NrOfColumns;
if kn < 1 then
  kn := 1;
if kn > MaxK then
  kn := MaxK;
if kn > InMat.NrOfRows then
  kn := InMat.NrOfRows;
for obj:=FirstRow to LastRow do   (* for each object *)
  begin
  for i:=1 to MaxK do              (* init. distances and indices *)
    begin
    Dist[i] := MaxReal;
    DistIx[i] := 0;
    end;
  for i:=FirstRow to LastRow do   (* find list of kn nearest neighbours *)
    begin
    d := 0;
    for k:=1 to NCol do
(*      d := d + sqr(Array1D(InMat.Mat^)[(obj-1)*NCol+k]-
                   Array1D(InMat.Mat^)[(i-1)*NCol+k]); *)
    d := d + sqr(InMat.Elem[k,obj]-InMat.Elem[k,i]);
    d := sqrt(d);
    ix := SortIntoArray (addr(Dist), kn, dnum, addr(d), TRUE, TRUE);
    if ix > 0 then
      InsertIntoArray (addr(DistIx), kn, inum, addr(i), ix);
    end;
  d := 0;
  for i:=1 to kn do      (* calc. mean and enter to DistVec *)
    d := d + Dist[i];
  DistVec.Elem[obj] := d/kn;
  end;
end;


(************************************************************************)
  procedure FindCenters
              (InMat : TMatrix;             { data matrix }
        RowLo, RowHi : integer;     { first & last object }
             NumCent : integer;       { number of centers }
         var Centers : TMatrix;       { matrix of centers }
        var MeanDist : double);            { mean distance }
(************************************************************************
  This routine find 'NumCent' centers in a data space, which
  is represented by 'InMat'. Therefore the columns of the
  data matrix are used as coordinates, the rows constitute
  the individual data points (objects).

  ENTRY: InMat ......... matrix of input data (rows are objects,
                         columns are coordinates or features)
         RowLo, RowHi .. range of objects which are considered
                         during the calculation
         NumCent ....... number of centers to be calculated

  EXIT:  Centers ....... matrix which holds the coordinates of the
                         calculated centers. 'Centers' must be at least
                         of dimensinality 'NumCent' x 'self.NrOfColumns'.
         MeanDist ...... mean of minimum distances between calculated
                         centers

  REMARK: Be aware that the calculation time of this routine increases
          roughly with the square of the number of objects. A reasonable
          amount of objects is not more than 200.

          'FindCenters' saves the original matrix on file 'MAT.$$$' and
          restores the original values after calculation.
 ***********************************************************************)


var
  i,j,k     : integer;
  Dist      : double;
  d         : double;
  LastDat   : integer;
  PairI     : integer;
  PairJ     : integer;
  ObjCount  : TVector;
  AFile     : file;
  NCol      : integer;

begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
if InMat.StoreOnFile (1,1,InMat.NrOfColumns,InMat.NrOfRows,'MAT.$$$') then
  begin
  ObjCount := TVector.Create (RowHi-RowLo+1);
  ObjCount.Fill (1);
  LastDat := RowHi;
  NCol := InMat.NrOfColumns;
  while LastDat-RowLo+1 > NumCent do
    begin
    inc (ProcStat);
    if addr(MathFeedBackProc) <> NIL then
      MathFeedBackProc (ProcStat);
    Dist := 1e10;
    PairI:=0;
    PairJ:=0;
    for i:=RowLo to LastDat-1 do
      for j:=i+1 to LastDat do
        begin
        d := 0;
        for k:=1 to NCol do
        d := d + sqr(InMat.Elem[k,i]-InMat.Elem[k,j]);
        if Dist > d then
          begin
          Dist := d;
          PairI := i;
          PairJ := j;
          end;
        end;
    for i:=1 to InMat.NrOfColumns do
      InMat.Elem[i,PairI] := (InMat.Elem[i,PairI]*ObjCount.Elem[PairI-RowLo+1] +
                              InMat.Elem[i,PairJ]*ObjCount.Elem[PairJ-RowLo+1]) /
                              (ObjCount.Elem[PairI-RowLo+1]+ObjCount.Elem[PairJ-RowLo+1]);
    ObjCount.Elem[PairI-RowLo+1] := ObjCount.Elem[PairI-RowLo+1] + ObjCount.Elem[PairJ-RowLo+1];
    for i:=1 to InMat.NrOfColumns do
      InMat.Elem[i,PairJ] := InMat.Elem[i,LastDat];
    ObjCount.Elem[PairJ-RowLo+1] := ObjCount.Elem[LastDat-RowLo+1];
    dec (LastDat);
    end;
  for i:=1 to NumCent do
    for j:=1 to Centers.NrOfColumns do
      Centers.Elem[j,i] := InMat.Elem[j,i+RowLo-1];
  MeanDist := 0;
  for i:=1 to NumCent do
    begin
    Dist := 1e10;
    for j:=1 to NumCent do
      if i <> j then
        begin
        d := 0;
        for k:=1 to Centers.NrOfColumns do
          d := d + sqr(Centers.Elem[k,i]-Centers.Elem[k,j]);
        if Dist > d then
          Dist := d;
        end;
    MeanDist := MeanDist + sqrt(dist);
    end;
  MeanDist := MeanDist/NumCent;
  if InMat.LoadFromFile ('MAT.$$$', false) then
    begin
    assign (Afile,'MAT.$$$');
    erase (Afile);
    end;
  ObjCount.Free;
  end;
end;



(******************************************************************)
procedure FindNearestNeighbors (k: integer; InMat: TMatrix;
              FirstObj, LastObj: integer;
              DatVec: TVector; KNNList: TMatrix; CalcDist: TCalcDistFunc);
(******************************************************************
  ENTRY: k ......... number of neighbors to be searched for
                     k must not exceed 'MaxK' (50)
         InMat ..... matrix to be used for the search
         FirstObj .. first object (row) of InMat to be used
         LastObj ... last object to be used
         DatVec .... data to be searched for (this is the data vector
                     which defines the center for the KNN search)

  EXIT:  KNNList ... list of k nearest neighbors (index and distance)

  This routine finds the k nearest neighbors of the vector 'DatVec' in the
  matrix 'InMat'. The user has to ensure that both the x-dimension of
  'InMat' and the length of 'DatVec' are equal. The result is returned
  in the matrix 'KNNList' (size 2 x k). The first column of 'KNNList'
  holds the indices, the second column the distances of these neighbors.
 ******************************************************************)

const
  MaxK = 50;

var
  NearNDist    : array[1..MaxK] of double;  (* distances of nearest neighbors *)
  NearNIx      : array[1..MaxK] of integer;  (* indices of n.n. *)
  j            : integer;
  dist         : double;
  ix           : integer;

function IntCalcDist (Dix: integer): double;
(*----------------------------------------*)

var
  sum   : double;
  i     : integer;

begin
sum := 0;
for i:=1 to DatVec.NrOfElem do
  sum := sum + sqr(InMat.Elem[i,Dix]-DatVec.Elem[i]);
IntCalcDist := sqrt(sum);
end;


begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
if k > MaxK then
  k := MaxK;
if k > InMat.NrOfRows then
  k := InMat.NrOfRows;
for j:=1 to Maxk do             (* init nearest neighbor list *)
  begin
  NearNDist[j] := MaxReal;
  NearNIx[j] := 0;
  end;
for j:=FirstObj to LastObj do  (* browse through data matrix *)
  begin
  if assigned(CalcDist)
    then dist := CalcDist (j)
    else dist := IntCalcDist (j);
  ix := SortintoArray (addr(NearNDist), MaxK, dnum, addr(dist), true, true);
  if ix > 0 then
    InsertIntoArray (addr(NearNIx),MaxK,inum,addr(j),ix);
  end;
for j:=1 to k do
  begin
  KNNList.Elem[1,j] := NearNIx[j];
  KNNList.Elem[2,j] := NearNDist[j];
  end;
end;


(******************************************************************************)
procedure EstimateByKNN (InMat: TMatrix; TargetVec: TVector;
                         kn: integer; WeightingMode: TKnnWMode; SmoothFact: double;
                         EstInVar: TVector; var EstTarget: double; var EstMeanDist: double);
(******************************************************************************
  ENTRY: InMat ............ matrix containing known input data (training data)
         TargetVec ........ vector containing target training values
         kn ............... number of nearest neighbors
         WeightingMode .... weighting mode used for estimation
         SmoothFact ....... smoothing factor
         EstInVar ......... values of input variables to be estimated

  EXIT:  EstTarget ........ estimated target value
         EstMeanDist ...... mean distance of kn neighbors used for estimation
 ******************************************************************************)


var
  KNNList : TMatrix;
  i       : integer;
  dbar    : double;
  w       : double;
  sumw    : double;
  q1, q3  : double;
  AuxVec  : Tvector;

begin
if kn > InMat.NrOfRows then
  kn := InMat.NrOfRows;
KNNList := TMatrix.Create (2,kn);
FindNearestNeighbors (kn, InMat, 1, InMat.NrOfRows, EstInVar, KNNList, nil);
dbar := 0;   // calc. mean distance
for i:=1 to kn do
  dbar := dbar + KNNList[2,i];
dbar := dbar / kn;
EstMeanDist := dbar;
if dbar = 0 then
  dbar := 0.001;
case WeightingMode of      // estimate unknown, by checking the kn nearest neighbors
       kwmGauss : begin
                  EstTarget := 0;
                  SumW := 0;
                  for i:=1 to kn do
                    begin
                    w := exp(-sqr(SmoothFact*KNNList[2,i]/dbar));
                    EstTarget := EstTarget + w*TargetVec.Elem[round(KNNList[1,i])];
                    sumW := sumW + w;
                    end;
                  EstTarget := EstTarget / SumW;
                  end;
     kwmAverage : begin
                  EstTarget := 0;
                  for i:=1 to kn do
                    EstTarget := EstTarget + TargetVec.Elem[round(KNNList[1,i])];
                  EstTarget := EstTarget / kn;
                  end;
      kwmMedian : begin
                  AuxVec := Tvector.Create (kn);
                  for i:=1 to kn do
                    AuxVec[i] := TargetVec.Elem[round(KNNList[1,i])];
                  AuxVec.Quartiles (1, kn, Q1, EstTarget, Q3);
                  AuxVec.Free;
                  end;
end;
KNNList.Free;
end;



(*****************************************************************)
function CalcGaussKernel (Probe, RefCenter: TVector; Width: double): double;
(*****************************************************************
  ENTRY:  Probe ...... position where to calculate the value of the
                       n-dim. Gaussian kernel
          RefCenter .. center position of Gaussian kernel
          Width ...... width of Gaussian kernel

  EXIT:   the function returns the value of the given Gaussian kernel
          at the position 'Probe'

  REMARK: The user has to ensure that the dimensionalities of the
          vectors 'Probe' and 'RefCenter' are equal.
 *****************************************************************)

var
  k    : integer;
  dist : double;

begin
dist := 0;
for k:=1 to RefCenter.NrOfElem do
  dist := dist + sqr(Probe.Elem[k]-RefCenter.Elem[k]);
dist := dist/sqr(Width);
if dist > 20 then
  dist := 20;
CalcGaussKernel := exp(-dist);
end;


(*****************************************************************)
function CalcGaussKernelMat (Probe: TVector; RefCenterMat: TMatrix;
                             RefCenterIx: integer; Width: double): double;
(*****************************************************************
  ENTRY:  Probe ......... position where to calculate the value of the
                          n-dim. Gaussian kernel
          RefCenterMat .. matrix of center positions of Gaussian kernel
          RefCenterIx ... row index into RefCenterMat
          Width ......... width of Gaussian kernel

  EXIT:   The function returns the value of the given Gaussian kernel
          at the position 'Probe'. The kernel position is defined by
          a single row (index 'RefCenterIx') of the matrix 'RefCenterMat'.

  REMARK: The user has to ensure that the dimensionality of the
          vector 'Probe' and the first dimension of teh matrix
          'RefCenterMat' are equal.
 *****************************************************************)

var
  k    : integer;
  dist : double;

begin
dist := 0;
for k:=1 to RefCenterMat.NrOfColumns do
  dist := dist + sqr(Probe.Elem[k]-RefCenterMat.Elem[k,RefCenterIx]);
dist := dist/sqr(Width);
if dist > 20 then
  dist := 20;
CalcGaussKernelMat := exp(-dist);
end;




(*********************************************************)
constructor TCurveFit.Create;
(*********************************************************)

begin
inherited Create;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
SumXArray := TVector.Create (2*(MaxPolyFitOrder+1));
RHS := TVector.Create (MaxPolyFitOrder+1);
FData := TMatrix.Create (2, ChunkSize);
FSplineValid := false;
FNatural1 := true;
FNaturalN := true;
FY1Dash := 0;
FYNDash := 0;
Init;
end;


(*********************************************************)
destructor TCurveFit.Destroy;
(*********************************************************)

begin
RHS.Free;
SumXArray.Free;
FData.Free;
inherited Destroy;
end;


(******************************************************************)
procedure TCurveFit.Init;
(******************************************************************
 EXIT:    all internal sums and the number of data are reset to zero
 ******************************************************************)


begin
sumx := 0;
sumy := 0;
sumxq := 0;
sumyq := 0;
sumxy := 0;
sumx2y := 0;
sumx3 := 0;
sumx4 := 0;
sumDiff := 0;
sumDiffq := 0;
sum1byy := 0;
sum1byyq := 0;
sumxbyy := 0;
sumybyx := 0;
sum1byx := 0;
sum1byxq := 0;
sumlnx := 0;
sumlnxq := 0;
sumylnx := 0;
sumlny := 0;
sumlnyq := 0;
sumxlny := 0;
sumxqlny := 0;
FNumData := 0;
SumXArray.Clear;
RHS.Clear;
FData.Fill(0);
end;


(******************************************************************)
procedure TCurveFit.EnterStatValue (x,y: double);
(******************************************************************
ENTRY:    x, y ..... values to be added to statistical calculation
EXIT:     values x and y are added to intermediary sums
 ******************************************************************)

var
  i      : byte;
  xProd  : double;

begin
sumx := sumx + x;
sumy := sumy + y;
sumxq := sumxq + sqr(x);
sumyq := sumyq + sqr(y);
sumDiff := sumDiff + x-y;
sumDiffq := sumDiffq + sqr(x-y);
sumxy := sumxy + x*y;
sumx2y := sumx2y + sqr(x)*y;
sumx3 := sumx3 + sqr(x)*x;
sumx4 := sumx4 + sqr(x)*sqr(x);
if abs(y) > SmallPosNum
  then begin
       sum1byy := sum1byy + 1.0/y;
       sum1byyq := sum1byyq + 1.0/sqr(y);
       sumxbyy := sumxbyy + x/y;
       end
  else begin
       sum1byy := sum1byy + Maxreal;
       sum1byyq := sum1byyq + sqr(MaxReal);
       sumxbyy := sumxbyy + x*MaxReal;
       end;
if abs(x) > SmallPosNum
  then begin
       sum1byx := sum1byx + 1.0/x;
       sum1byxq := sum1byxq + 1.0/sqr(x);
       sumybyx := sumybyx + y/x;
       end
  else begin
       sum1byx := sum1byx + MaxReal;
       sum1byxq := sum1byxq + sqr(MaxReal);
       sumybyx := sumybyx + y*Maxreal;
       end;
if x > 0 then
  begin
  sumlnx := sumlnx + ln(x);
  sumlnxq := sumlnxq + sqr(ln(x));
  sumylnx := sumylnx + y*ln(x);
  end;

if y > 0 then
  begin
  sumlny := sumlny + ln(y);
  sumlnyq := sumlnyq + sqr(ln(y));
  sumxlny := sumxlny + x*ln(y);
  sumxqlny := sumxqlny + sqr(x)*ln(y);
  end;

xProd:= 1;
for i:=1 to 2*(MaxPolyFitOrder+1) do
  begin
  SumXarray.Elem[i]:= SumXarray.Elem[i] + xProd;
  if i<=(MaxPolyFitOrder+1) then
    RHS.Elem[i]:= RHS.Elem[i] + xProd*y;
  xProd:= xProd*x;
  end;
inc (FNumData);
if FNumData > FData.NrOfRows then
  FData.Resize (2, FData.NrOfRows + ChunkSize);
FData.Elem[1,FNumData] := x;
FData.Elem[2,FNumData] := y;
FSplineValid := false;
end;


(******************************************************************)
procedure TCurveFit.RemoveStatValue (ix: integer);
(******************************************************************
  ENTRY:    ix .... index of data pair to be removed

  EXIT:     the specified data pair is removed from the list of data
            pairs. the auxiliary sums are adjusted accordingly
 ******************************************************************)

var
  i      : byte;
  xProd  : double;
  x,y    : double;

begin
if (ix >= 1) and (ix <= NumData) then
  begin
  x := FData.Elem[1,ix];
  y := FData.Elem[2,ix];
  sumx := sumx - x;
  sumy := sumy - y;
  sumxq := sumxq - sqr(x);
  sumyq := sumyq - sqr(y);
  sumDiff := sumDiff - (x-y);
  sumDiffq := sumDiffq - sqr(x-y);
  sumxy := sumxy - x*y;
  sumx2y := sumx2y - sqr(x)*y;
  sumx3 := sumx3 - sqr(x)*x;
  sumx4 := sumx4 - sqr(x)*sqr(x);
  if abs(y) > SmallPosNum
    then begin
         sum1byy := sum1byy - 1.0/y;
         sum1byyq := sum1byyq - 1.0/sqr(y);
         sumxbyy := sumxbyy - x/y;
         end
    else begin
         sum1byy := sum1byy - Maxreal;
         sum1byyq := sum1byyq - sqr(MaxReal);
         sumxbyy := sumxbyy - x*MaxReal;
         end;
  if abs(x) > SmallPosNum
    then begin
         sum1byx := sum1byx - 1.0/x;
         sum1byxq := sum1byxq - 1.0/sqr(x);
         sumybyx := sumybyx - y/x;
         end
    else begin
         sum1byx := sum1byx - MaxReal;
         sum1byxq := sum1byxq - sqr(MaxReal);
         sumybyx := sumybyx - y*Maxreal;
         end;
  if x > 0 then
    begin
    sumlnx := sumlnx - ln(x);
    sumlnxq := sumlnxq - sqr(ln(x));
    sumylnx := sumylnx - y*ln(x);
    end;

  if y > 0 then
    begin
    sumlny := sumlny - ln(y);
    sumlnyq := sumlnyq - sqr(ln(y));
    sumxlny := sumxlny - x*ln(y);
    sumxqlny := sumxqlny - sqr(x)*ln(y);
    end;

  xProd:= 1;
  for i:=1 to 2*(MaxPolyFitOrder+1) do
    begin
    SumXarray.Elem[i]:= SumXarray.Elem[i] - xProd;
    if i<=(MaxPolyFitOrder+1) then
      RHS.Elem[i]:= RHS.Elem[i] - xProd*y;
    xProd:= xProd*x;
    end;
  if ix < FNumData then
    begin
    for i:=ix+1 to FNumData do
      begin
      FData.Elem[1,i-1] := FData.Elem[1,i];
      FData.Elem[2,i-1] := FData.Elem[2,i];
      end;
    end;
  dec (FNumData);
  end;
FSplineValid := false;
end;



(******************************************************************)
function TCurveFit.GetDataX (ix: integer): double;
(******************************************************************)

begin
if (ix >= 1) and (ix <= FNumdata)
  then GetDataX := FData.Elem[1, ix]
  else getDataX := 0;
end;

(******************************************************************)
function TCurveFit.GetDataY (ix: integer): double;
(******************************************************************)

begin
if (ix >= 1) and (ix <= FNumdata)
  then GetDataY := FData.Elem[2, ix]
  else getDataY := 0;
end;


(******************************************************************)
procedure TCurveFit.SetNatural1 (value: boolean);
(******************************************************************)

begin
FNatural1 := value;
FSplineValid := false;
end;


(******************************************************************)
procedure TCurveFit.SetNaturalN (value: boolean);
(******************************************************************)

begin
FNaturalN := value;
FSplineValid := false;
end;


(******************************************************************)
procedure TCurveFit.SetY1Dash (value: double);
(******************************************************************)

begin
FY1Dash := value;
FSplineValid := false;
end;


(******************************************************************)
procedure TCurveFit.SetYNDash (value: double);
(******************************************************************)

begin
FYNDash := value;
FSplineValid := false;
end;


(******************************************************************)
function TCurveFit.CalcPolyFit (const nOrder: byte;
         var kArray: array of double; var FitQual: double): boolean;
(******************************************************************)

var
  TempMatrix,
  SumMatrix,
  ResMatrix     : TMatrix;
  i, j          : byte;
  denom, sumy   : double;
  reslt         : boolean;

begin
if nOrder >= FNumData   { number of data must be at least nOrder + 1 }
  then reslt := false
  else begin
       Reslt:= true;
       SumMatrix:= TMatrix.Create(nOrder+1,nOrder+1);
       ResMatrix:= TMatrix.Create(1,nOrder+1);
       TempMatrix:= TMatrix.Create(1,nOrder+1);
       try
         SumMatrix.Fill(0);
         for i:=1 to nOrder+1 do
           for j:=1 to nOrder+1 do
             SumMatrix.Elem[i,j]:= SumXArray.Elem[i+j-1];
         reslt := reslt and SumMatrix.Invert;
         for i:=1 to nOrder+1 do
           begin
           TempMatrix.Elem[1,i]:= RHS.Elem[i];
           FitQual:= FitQual + RHS.Elem[i];
           end;
         reslt := reslt and Summatrix.Multiply(TempMatrix,ResMatrix);

         FitQual:=0;
         for i:=1 to nOrder+1 do
           begin
           kArray[i-1]:=ResMatrix.Elem[1,i];
           FitQual:= FitQual + RHS.Elem[i]*ResMatrix.Elem[1,i];
           end;

         sumy:= RHS.Elem[1];
         denom := sumyq-sqr(sumy)/NumData;
         if denom<>0.0
           then FitQual:= (FitQual-sqr(sumy)/NumData)/denom
           else FitQual := 1.0;

       finally
         SumMatrix.Free;
         ResMatrix.Free;
         TempMatrix.Free;
       end;
       end;
CalcPolyFit := reslt;
end;


(******************************************************************)
procedure TCurveFit.CalcStatistics (var NumData: longint;
            var MeanX, MeanY, StdevX, StdevY, MeanDiff,
            StdevDiff, rxy: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     NumData .......... number of data
          MeanX, MeanY ..... means of x and y
          StdevX, StdevY ... standard deviation of x, y
          MeanDiff ......... mean of difference x-y
          StdevDiff ........ std.dev. of difference
          rxy .............. correlation coefficient
******************************************************************)

var
  z1, z2  : double;

begin
stdevx := 0;
stdevy := 0;
stdevDiff := 0;
rxy := 0;
meanx := 0;
meany := 0;
meanDiff := 0;
if FNumData > 0 then
  begin
  meanx := sumx / FNumData;
  meany := sumy / FNumData;
  meanDiff := sumDiff / FNumData;
  if FNumData >= 3 then
    begin
    stdevx := sqrt(abs((sumxq-sqr(sumx)/FNumData)/
                   (FNumData-1)));
    stdevy := sqrt(abs((sumyq-sqr(sumy)/FNumData)/
                   (FNumData-1)));
    stdevDiff := sqrt(abs((sumDiffq-sqr(sumDiff)/FNumData)/
                   (FNumData-1)));
    if ((sumxq > 0) and (sumyq > 0))
      then begin
           z1 := sumxq-sqr(sumx)/FNumData;
           z2 := sumyq-sqr(sumy)/FNumData;
           if (z1 <> 0) and (z2 <> 0)
             then rxy := (sumxy-sumx*sumy/FNumData)/
                         sqrt(abs(z1*z2))
             else rxy := 0.0;
           end
      else rxy := 0;
    end;
  end;
Numdata := FNumData;
end;



(******************************************************************)
procedure TCurveFit.CalcLinFit (var k, d, FitQual: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     k, d ....... best fit of straight line y = kx + d
          FitQual .... quality of fit (1.0 = optimum)
******************************************************************)

var
  denom  : double;

begin
k := 0;
d := 0;
FitQual := 0;
if FNumData >= 2 then
  begin
  k := (sumxy*FNumData-sumx*sumy)/
       (sumxq*FNumData-sqr(sumx));
  d := (sumxq*sumy - sumx*sumxy)/
       (sumxq*FNumData-sqr(sumx));
  denom := sumyq-sqr(sumy)/FNumData;
  if denom <> 0.0
    then FitQual := (d*sumy+k*sumxy-
                     sqr(sumy)/FNumData)/denom
    else FitQual := 1.0;
  end;
end;


(******************************************************************)
procedure TCurveFit.CalcParabolFit (var k0, k1, k2, FitQual: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     k0, k1, k2 .. best fit of parabola y = k0 + k1*x + k2*sqr(x)
          FitQual ..... quality of fit (1.0 = optimum)
******************************************************************)

var
  aux5, aux6, aux7,
  aux8, aux9 : double;
  denom      : double;


begin
k0 := 0;
k1 := 0;
k2 := 0;
FitQual := 0;
if FNumData >= 3 then
  begin
  aux5 := sumxq*FNumData-sqr(Sumx);
  aux6 := FNumData*sumx2y-sumxq*sumy;
  aux7 := FNumData*sumx3-sumx*sumxq;
  aux8 := sumxy*FNumData-sumx*sumy;
  aux9 := FNumData*sumx4-sqr(sumxq);
  if aux5*aux9 <> sqr(aux7)
    then k2 := (aux5*aux6-aux7*aux8)/(aux5*aux9-sqr(aux7))
    else k2 := 0;
  if aux5 <> 0.0
    then k1 := (aux8-aux7*k2)/aux5
    else k1 := 0;
  k0 := (sumy-k1*sumx-k2*sumxq)/FNumData;
  denom := sumyq-sqr(sumy)/FNumData;
  if denom <> 0.0
    then begin
         FitQual := (k0*sumy+k1*sumxy+k2*sumx2y-sqr(sumy)/
                     FNumData)/denom;
         end
    else begin
         FitQual := 1.0;
         end;
  end;
end;

(******************************************************************)
procedure TCurveFit.CalcGaussFit (var k0, k1, k2, FitQual: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     k0, k1, k2 .. y = k0 * exp(sqr(x-k1)/k2)
          FitQual ..... quality of fit (1.0 = optimum)
******************************************************************)

var
  aux5, aux6, aux7, aux8, aux9 : double;
  denom  : double;


begin
k0 := 0;
k1 := 0;
k2 := MaxReal;
FitQual := 0;
if FNumData >= 3 then
  begin
  aux5 := sumxq*FNumData-sqr(Sumx);
  aux6 := FNumData*sumxqlny-sumxq*sumlny;
  aux7 := FNumData*sumx3-sumx*sumxq;
  aux8 := sumxlny*FNumData-sumx*sumlny;
  aux9 := FNumData*sumx4-sqr(sumxq);
  if aux5*aux9 <> sqr(aux7)
    then k2 := (aux5*aux6-aux7*aux8)/(aux5*aux9-sqr(aux7))
    else k2 := MaxReal;
  if aux5 <> 0.0
    then k1 := (aux8-aux7*k2)/aux5
    else k1 := MaxReal;
  k0 := (sumlny-k1*sumx-k2*sumxq)/FNumData;

  denom := sumlnyq-sqr(sumlny)/FNumData;
  if denom <> 0
    then FitQual := (k0*sumlny+k1*sumxlny+k2*sumxqlny-sqr(sumlny)/
                     FNumData)/denom
    else FitQual := 1;

  if k2 <> 0.0
    then begin
         k0 := exp (k0-sqr(k1)/4/k2);
         k1 := -k1/2/k2;
         k2 := -1/k2;
         end
    else begin
         k2 := -MaxReal;
         k1 := 0;
         k0 := 0;
         end;
  end;
end;


(******************************************************************)
procedure TCurveFit.CalcReciLinFit (var k0, k1, FitQual: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     k0, k1 ..... best fit of reciprocal line y = 1/(k0+k1*x)
          FitQual .... quality of fit (1.0 = optimum)
******************************************************************)

var
  aux5, aux6 : double;

begin
k0 := 0;
k1 := 0;
FitQual := 0;
if FNumData >= 2 then
  begin
  aux5 := sumxq*FNumData - sqr(sumx);
  k0 := (sumxq*sum1byy - sumx*sumxbyy)/aux5;
  k1 := (FNumData*sumxbyy - sumx*sum1byy)/aux5;
  aux6 := sqr(sum1byy)/FNumData;
  if sum1byyq <> aux6
    then FitQual := (k0*sum1byy+k1*sumxbyy-aux6)/(sum1byyq-aux6)
    else FitQual := 1.0;
  end;
end;

(******************************************************************)
procedure TCurveFit.CalcHyperbolFit (var k0, k1, FitQual: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     k0, k1 ..... best fit of hyperbolic line y = k0+k1/x
          FitQual .... quality of fit (1.0 = optimum)
******************************************************************)

var
  aux5, aux6 : double;

begin
k0 := 0;
k1 := 0;
FitQual := 0;
if FNumData >= 2 then
  begin
  aux5 := sum1byxq*FNumData - sqr(sum1byx);
  k0 := (sumy*sum1byxq - sum1byx*sumybyx)/aux5;
  k1 := (FNumData*sumybyx - sumy*sum1byx)/aux5;
  aux6 := sqr(sumy)/FNumData;
  if sumyq <> aux6
    then FitQual := (k0*sumy+k1*sumybyx-aux6)/(sumyq-aux6)
    else FitQual := 1.0;
  end;
end;


(******************************************************************)
procedure TCurveFit.CalcLogFit (var k0, k1, FitQual: double);
(******************************************************************
ENTRY:    intermediary sums established by EnterStatValues
EXIT:     k0, k1 ..... best fit of hyperbolic line y = k0+k1*ln(x)
          FitQual .... quality of fit (1.0 = optimum)
******************************************************************)

var
  aux5, aux6 : double;

begin
k0 := 0;
k1 := 0;
FitQual := 0;
if FNumData >= 2 then
  begin
  aux5 := sumlnxq*FNumData - sqr(sumlnx);
  k0 := (sumy*sumlnxq - sumlnx*sumylnx)/aux5;
  k1 := (FNumData*sumylnx - sumy*sumlnx)/aux5;
  aux6 := sqr(sumy)/FNumData;
  if sumyq <> aux6
    then FitQual := (k0*sumy+k1*sumylnx-aux6)/(sumyq-aux6)
    else FitQual := 1.0;
  end;
end;



(***********************************************************************)
procedure TCurveFit.ExchangeDuringSort (Sender: TObject;
          ExchgWhat: byte; index1, index2, first, last: longint);
(***********************************************************************)

var
  ddummy : double;

begin
ddummy := SplSortedY[index1];
SplSortedY[index1] := SplSortedY[index2];
SplSortedY[index2] := ddummy;
end;


(******************************************************************)
procedure TCurveFit.PrepareSpline;
(******************************************************************
  ENTRY:   FY1Dash ..... first derivative at the first tabulated point
           FYNDash ..... first derivative at the last tabulated point
           FNatural1 ... if TRUE the first derivative is set automatically such
                         that the second derivative at the first point is zero
           FNaturalN ... if TRUE the first derivative is set automatically such
                         that the second derivative at the last point is zero

  EXIT:    The second derivatives are calculated and stored internally. The
           function CubicSpline uses these values to calculate the interpolation
 ******************************************************************)

var
  i          : integer;
  AuxVec     : TVector;
  p1, p2     : double;
  Spl2DerivN : double;
  AuxN       : double;

begin
SplSortedX.free;
SplSortedX := TVector.Create (FNumData);
SplSortedY.free;
SplSortedY := TVector.Create (FNumData);
Spl2Deriv.free;
Spl2Deriv := TVector.Create (FNumData);
AuxVec := TVector.Create (FNumData);

FData.CopyColToVec (SplSortedX, 1, 1, FNumData);        { copy from data field }
FData.CopyColToVec (SplSortedY, 2, 1, FNumData);
SplSortedX.OnSortExchange := ExchangeDuringSort;
SplSortedX.SortElems (true, 1, FNumData);             { sort the X and Y pairs }

if FNatural1                                    { set lower boundary condition }
  then begin
       Spl2Deriv[1] := 0;
       AuxVec[1] := 0;
       end
  else begin
       Spl2Deriv[1] := -0.50;
       AuxVec[1] := 3.0/(SplSortedX[2]-SplSortedX[1])*
          ((SplSortedY[2]-SplSortedY[1])/(SplSortedX[2]-SplSortedX[1])-FY1Dash);
       end;
for i:=2 to FNumData-1 do                           { tridiagoal decomposition }
  begin
  p1 := (SplSortedX[i]-SplSortedX[i-1])/(SplSortedX[i+1]-SplSortedX[i-1]);
  p2 := p1*Spl2Deriv[i-1]+2;
  Spl2Deriv[i] := (p1-1)/p2;
  try
  AuxVec[i] := (6.0*((SplSortedY[i+1]-SplSortedY[i])/(SplSortedX[i+1]-SplSortedX[i])-
                     (SplSortedY[i]-SplSortedY[i-1])/(SplSortedX[i]-SplSortedX[i-1]))/
                     (SplSortedX[i+1]-SplSortedX[i-1])-p1*AuxVec[i-1])/p2;
  except
  AuxVec[i] := MaxReal;
  end;
  end;
if FNaturalN { set upper boundary condition }
  then begin
       Spl2DerivN := 0;
       AuxN := 0;
       end
  else begin
       Spl2DerivN := 0.50;
       AuxN := 3.0/(SplSortedX[FNumData]-SplSortedX[FNumData-1])*
                 (FYNDash-(SplSortedY[FNumData]-SplSortedY[FNumData-1])/
                          (SplSortedX[FNumData]-SplSortedX[FNumData-1]));
       end;
                                                           { back substitution }
Spl2Deriv[fNumData] := (AuxN-Spl2DerivN*AuxVec[FNumData-1])/(Spl2DerivN*Spl2Deriv[FNumData-1]+1);
for i := FNumData-1 downto 1 do
  Spl2Deriv[i] := Spl2Deriv[i]*Spl2Deriv[i+1]+AuxVec[i];
FSplineValid := true;
AuxVec.Free;
end;



(******************************************************************)
function TCurveFit.CubicSpline (X: double): double;
(******************************************************************
  ENTRY:   X .......... argument for cubic spline function

  EXIT:    function returns interpolated value
 ******************************************************************)

const
  MinDist = 1e-100;

var
  ix         : integer;
  Loix, Hiix : integer;
  a,b        : double;
  dx         : double;

begin
if not FSplineValid then
  PrepareSpline;                   { calc. 2nd derivatives if not already done }

Loix := 1                                               { now calc spline value };
Hiix := FNumData;        { successive approximation to find bracketing x values }
while (Hiix-Loix) > 1 do
  begin
  ix := (Hiix+Loix) div 2;
  if SplSortedX[ix] > x
    then Hiix := ix
    else Loix := ix;
  end;
dx := SplSortedX[Hiix] - SplSortedX[Loix];
if dx < MinDist then
  raise ESDLMath2Error.Create ('CubicSpline: the tabulated values are not distinct');
a := (SplSortedX[Hiix]-x)/dx;
b := (x-SplSortedX[Loix])/dx;
CubicSpline := a*SplSortedY[Loix]+b*SplSortedY[Hiix] +
               (a*(sqr(a)-1)*Spl2Deriv[Loix]+b*(sqr(b)-1)*Spl2Deriv[Hiix])*sqr(dx)/6;
end;




(******************************************************************)
function TCurveFit.GetMeanX: double;
(******************************************************************)

begin
if FNumData > 0
  then GetMeanx := sumx / FNumData
  else GetMeanx := sumx / FNumData;
end;


(******************************************************************)
function TCurveFit.GetMeanY: double;
(******************************************************************)

begin
if FNumData > 0
  then GetMeany := sumy / FNumData
  else GetMeany := sumy / FNumData;
end;

(******************************************************************)
function TCurveFit.GetMeanDiff: double;
(******************************************************************)

begin
if FNumData > 0
  then GetMeanDiff := sumDiff / FNumData
  else GetMeanDiff := sumDiff / FNumData;
end;


(******************************************************************)
function TCurveFit.GetStdDevX: double;
(******************************************************************)

begin
if FNumData >= 3
  then GetStdDevX := sqrt(abs((sumxq-sqr(sumx)/FNumData)/(FNumData-1)))
  else GetStdDevX := 0;
end;


(******************************************************************)
function TCurveFit.GetStdDevY: double;
(******************************************************************)

begin
if FNumData >= 3
  then GetStdDevY := sqrt(abs((sumyq-sqr(sumy)/FNumData)/(FNumData-1)))
  else GetStdDevY := 0;
end;


(******************************************************************)
function TCurveFit.GetStdDevDiff: double;
(******************************************************************)

begin
if FNumData >= 3
  then GetStdDevDiff := sqrt(abs((sumDiffq-sqr(sumDiff)/FNumData)/(FNumData-1)))
  else GetStdDevDiff := 0;
end;


(******************************************************************)
function TCurveFit.GetRxy: double;
(******************************************************************)

var
  rxy, z1, z2  : double;

begin
rxy := 0;
if FNumData >= 3 then
  begin
  if ((sumxq > 0) and (sumyq > 0))
    then begin
         z1 := sumxq-sqr(sumx)/FNumData;
         z2 := sumyq-sqr(sumy)/FNumData;
         if (z1 <> 0) and (z2 <> 0)
           then rxy := (sumxy-sumx*sumy/FNumData)/
                       sqrt(abs(z1*z2))
           else rxy := 0.0;
         end
    else rxy := 0;
  end;
GetRxy := rxy;
end;

(******************************************************************)
function AgglomClustering (InMat: TMatrix; DistanceMeasure: TDistMode;
             ClusterMethod: TClusterMethod; alpha: double;
             var ClustResult: TIntMatrix; var ClustDist: TVector;
             var DendroCoords: TVector): integer;
(******************************************************************
  ENTRY: InMat holds data, rows of matrix are objects, columns are variables
         DistanceMeasure ... type of used distance metric
         ClusterMethod ..... type of clusterikng method to be used
         alpha  ............ parameter used for cmFlexLink

  EXIT:  ClustResult ....... integer matrix of dimension 3 by Nobj-1
         ClustDist   ....... distances between clusters (NObj-1 elements)
         DendroCoords ...... x-coordinates of dendrogram for all objects and
                             clusters (2*NObj-1 elements)
         function returns error number:
            0 ... no error
 ******************************************************************)

var
  ndata     : integer;
  DistMat   : TMatrix;
  i,j       : integer;
  errnum    : integer;
  Cnt       : integer;
  ClustNum  : TIntVector;
  ClustMembers : TIntVector;
  MinDist   : double;
  MinI      : integer;
  MinJ      : integer;
  changed   : boolean;

function NewDistance (p,q,i: integer): double;
(*------------------------------------------*)

var
  dnew : double;
  ni,np,nq : integer;

begin
dnew := 0;
case ClusterMethod of
    cmSingleLink : begin
                   dnew := DistMat.Elem[p,i];
                   if dnew > DistMat.Elem[q,i] then
                     dnew := DistMat.Elem[q,i];
                   end;
  cmCompleteLink : begin
                   dnew := DistMat.Elem[p,i];
                   if dnew < DistMat.Elem[q,i] then
                     dnew := DistMat.Elem[q,i];
                   end;
          cmWard : begin
                   np := ClustMembers.Elem[p];
                   nq := ClustMembers.Elem[q];
                   ni := ClustMembers.Elem[i];
                   dnew := ((ni+np)*DistMat.Elem[p,i] + (ni+nq)*DistMat.Elem[q,i] - ni*DistMat.Elem[p,q])/(ni+np+nq);
                   end;
       cmAvgLink : begin
                   dnew := 0.5*(DistMat.Elem[p,i] + DistMat.Elem[q,i]);
                   end;
      cmFlexLink : begin
                   dnew := alpha*(DistMat.Elem[p,i] + DistMat.Elem[q,i]) +
                           (1-2*alpha)*DistMat.Elem[p,q];
                   end;
end;
NewDistance := dnew;
end;

{$IFDEF DEBUG}
var
  TFile : TextFile;
{$ENDIF}

begin
{$IFDEF DEBUG}
AssignFile (TFile, 'clust.txt');
rewrite (TFile);
{$ENDIF}
if alpha < 0.5 then
  alpha := 0.5;
if alpha > 1.0 then
  alpha := 1.0;
ndata := InMat.NrOfRows;
DistMat := TMatrix.Create (ndata, ndata);
ClustNum := TIntVector.Create (NData);
ClustMembers := TIntVector.Create (NData);
errnum := InMat.CalcDistMat (DistanceMeasure,DistMat);
if errnum = 0 then
  begin
  if ClustDist.NrOfElem <> ndata-1 then
    ClustDist.Resize (ndata-1);
  if DendroCoords.NrOfElem <> 2*ndata-1 then
    DendroCoords.Resize (2*ndata-1);
  if (ClustResult.NrOfRows <> ndata-1) or (ClustResult.NrOfColumns <> 3) then
    ClustResult.Resize (3,ndata-1);
  for i:=1 to NData do
    begin
    ClustNum.Elem[i] := i;
    ClustMembers.Elem[i] := 1;
    end;
  for cnt := 1 to ndata-1 do
    begin
{$IFDEF DEBUG}
    writeln (TFile);
    writeln (TFile, 'CNT = ',cnt);
    write   (TFile, '     ');
    for j:=1 to ndata do
      write (TFile, strff(ClustNum.Elem[j],10,0));
    writeln (TFile);
    write   (TFile, '     ');
    for j:=1 to ndata do
      write (TFile, strff(ClustMembers.Elem[j],10,0));
    for i:=1 to ndata do
      begin
      writeln (TFile);
      write (TFile, 'i=', strff(i,3,0));
      for j:=1 to ndata do
        write (TFile, strff(DistMat.Elem[i,j],10,4));
      end;
{$ENDIF}
    inc (ProcStat);
    if addr(MathFeedBackProc) <> NIL then
      MathFeedBackProc (ProcStat);
    MinDist := MaxReal;
    MinI := 1;
    MinJ := 1;
    for i:=1 to ndata-1 do
      begin
      for j:=i+1 to ndata do
        begin
        if (ClustNum.Elem[i] > 0) and (ClustNum.Elem[j] > 0) then
          if (DistMat.Elem[i,j] < MinDist) then
            begin
            MinI := i;
            MinJ := j;
            MinDist := DistMat.Elem[i,j];
            end;
        end;
      end;
    for i:=1 to ndata do                   { calculate new distances with MinJ }
      begin
      DistMat.Elem[i,MinJ] := NewDistance(MinI,MinJ,i);
      DistMat.Elem[MinJ,i] := DistMat.Elem[i,MinJ]
      end;
    ClustResult.Elem[1,cnt] := ClustNum.Elem[MinI]; { output cluster to result structure }
    ClustResult.Elem[2,cnt] := ClustNum.Elem[MinJ];
    ClustResult.Elem[3,cnt] := cnt+NData;
    ClustDist.Elem[cnt] := MinDist;
    ClustNum.Elem[MinJ] := cnt+ndata;
    ClustMembers.Elem[MinJ] := ClustMembers.Elem[MinJ]+ClustMembers.Elem[MinI];
    ClustNum.Elem[MinI] := 0;      { eliminate MinJ from distance calculations }
    ClustMembers.Elem[MinI] := 0;
    end;
  ClustNum.Clear;                      { calculate x-coordinates of dendrogram }
  ClustNum.Elem[1] := ClustResult.Elem[1,ndata-1];
  ClustNum.Elem[2] := ClustResult.Elem[2,ndata-1];
  repeat
    changed := false;
    for i:=1 to ndata-1 do
      begin
      if ClustNum.Elem[i] > ndata then
        begin
        changed := true;
        for j:=ndata-1 downto i do                    { shift right and insert }
          ClustNum.Elem[j+1] := ClustNum.Elem[j];
        ClustNum.Elem[i+1] := ClustResult.Elem[1,ClustNum.Elem[i]-ndata];
        ClustNum.Elem[i] := ClustResult.Elem[2,ClustNum.Elem[i]-ndata];
        end;
      end;
  until not changed;
  for i:=1 to ndata do
    DendroCoords.Elem[ClustNum.Elem[i]] := i;
  for i:=1 to ndata-1 do
    DendroCoords.Elem[i+ndata] := (DendroCoords.Elem[ClustResult.ELem[1,i]] + DendroCoords.Elem[ClustResult.ELem[2,i]])/2;
{$IFDEF DEBUG}
  writeln (TFile, #13,'Dendrocoords');
  for i:=1 to 2*ndata-1 do
    writeln (TFile, ClustNum.Elem[i], '  ', DendroCoords.Elem[i]:1:2);
{$ENDIF}
  end;
DistMat.Free;
ClustNum.Free;
AgglomClustering := errnum;
{$IFDEF DEBUG}
closeFile (TFile);
{$ENDIF}
end;


(**********************************************************)
function SingValDecomp (MatAU, MatV: TMatrix;
                        VecW: TVector): boolean;
(**********************************************************
  'SingValDecomp' computes the singular value decomposition of
  any matrix A of size N x P (N >= P): A = U * W * V'

  ENTRY:  MatAU .... matrix A to decompose
  EXIT:   MatAU .... matrix U of solution
          MatV ..... matrix V of solution
          VecW ..... matrix W of solution in vector format
                     (diagonal matrix)
          function returns TRUE if calculation succeeded

  REMARK: This routine is based on the algorithm published in
          W.H. Press et al., 'Numerical Recipes', p.60,
          Cambridge University Press, New York 1986.
 **********************************************************)

var
  ANorm     : double;              { test for numeric range }
  Scale     : double;
  i,j,k,l   : integer;                   { working indices }
  nm,jj     : integer;
  g, c, s   : double;                { auxiliary parameters }
  x, y, z   : double;
  f, h      : double;
  its       : integer;                   { iteration count }

  RotV      : TVector;                   { rotation vector }
  reslt     : boolean; { TRUE: result of SVD routine valid }
  abortcond : integer;  { abort condition during splitting }
  itsabort  : boolean;            { TRUE: end of iteration }


function sign (a,b: double): double;
(*------------------------------*)

begin
if b >= 0
  then sign := abs(a)
  else sign := -abs(a);
end;

function max (a,b: double): double;
(*-----------------------------*)

begin
if a > b
  then max := a
  else max := b;
end;


begin
RotV := TVector.Create (MatAU.NrOfColumns);
reslt := true;
g:=0;
Scale:=0;
ANorm:=0.0;
l := 0;
for i:=1 to MatAU.NrOfColumns do
  begin
  inc (ProcStat);
  l:=i+1;
  RotV.Elem [i] := Scale*g;
  g := 0.0;
  s := 0.0;
  Scale := 0.0;
  if (i <= MatAU.NrOfRows) then
    begin
    for k:=i to MatAU.NrOfRows do
      Scale:=Scale+abs(MatAU.Elem[i,k]);
    if (Scale <> 0.0) then
      begin
      for k:=I to MatAU.NrOfRows do
        begin
        MatAU.Elem [i,k] := MatAU.Elem[i,k]/Scale;
        S:=S+MatAU.Elem[i,k]*MatAU.Elem[i,k];
        end;
      F:=MatAU.Elem[i,i];
      g := -sign(sqrt(s),f);
      H := F*g-S;
      MatAU.Elem[i,i] := F-g;
      if (i <> MatAU.NrOfColumns) then
        begin
        for j:=l to MatAU.NrOfColumns do
          begin
          S:=0.0;
          for k:=i to MatAU.NrOfRows do
            S:=S+MatAU.Elem[i,k]*MatAU.Elem[j,k];
          F:=S/H;
          for k:=i to MatAU.NrOfRows do
            MatAU.Elem[j,k] := MatAU.Elem[j,k]+F*MatAU.Elem[i,k];
          end;
        end;
      for k:=i to MatAU.NrOfRows do
        MatAU.Elem[i,k] := Scale*MatAU.Elem[i,k];
      end;
    end;

  VecW.Elem[I] := Scale*g;
  g:=0.0;
  S:=0.0;
  Scale:=0.0;
  if ((i <= MatAU.NrOfRows ) and (i <> MatAU.NrOfColumns)) then
    begin
    for k:=l to MatAU.NrOfColumns do
      Scale:=Scale+abs(MatAU.Elem[k,i]);
    if (Scale <> 0.0) then
      begin
      for k:=l to MatAU.NrOfColumns do
        begin
        MatAU.Elem[k,i] := MatAU.Elem[k,i]/Scale;
        S:=S+MatAU.Elem[k,i]*MatAU.Elem[k,i];
        end;
      F:=MatAU.Elem[l,i];
      g:=-SIGN(SQRT(S),F);
      H:=F*g-S;
      MatAU.Elem[l,i] := F-g;
      for k:=l to MatAU.NrOfColumns do
        RotV.Elem[K] := MatAU.Elem[k,i]/H;
      if (I <> MatAU.NrOfRows ) then
        begin
        for j:=l to MatAU.NrOfRows do
          begin
          S:=0.0;
          for k:=l to MatAU.NrOfColumns do
            S:=S+MatAU.Elem[k,j]*MatAU.Elem[k,i];
          for k:=l to MatAU.NrOfColumns do
            MatAU.Elem[k,j] := MatAU.Elem[k,j]+S*RotV.Elem[K];
          end;
        end;
      for k:=l to MatAU.NrOfColumns do
        MatAU.Elem[k,i] := Scale*MatAU.Elem[k,i];
      end;
    end;
  ANorm:=MAX(ANorm,(ABS(VecW.Elem[i])+ABS(RotV.Elem[I])))
  end;

for i:=MatAU.NrOfColumns downto 1 do
  begin
  inc (ProcStat);
  if (i < MatAU.NrOfColumns) then
    begin
    if (g <> 0.0) then
      begin
      for j:=l to MatAU.NrOfColumns do
        MatV.Elem[i,j] := (MatAU.Elem[j,i]/MatAU.Elem[l,i])/g;
      for j:=l to MatAU.NrOfColumns do
        begin
        S:=0.0;
        for k:=l to MatAU.NrOfColumns do
          S:=S+MatAU.Elem[k,i]*MatV.Elem[j,k];
        for k:=l to MatAU.NrOfColumns do
          MatV.Elem[j,k] := MatV.Elem[j,k]+S*MatV.Elem[i,k];
        end;
      end;
    for j:=l to MatAU.NrOfColumns do
      begin
      MatV.Elem[j,i] := 0.0;
      MatV.Elem[i,j] := 0.0;
      end;
    end;
  MatV.Elem[i,i] := 1.0;
  g:=RotV.Elem[I];
  l:=i;
  end;

for i:=MatAU.NrOfColumns downto 1 do
  begin
  inc (ProcStat);
  L:=I+1;
  g:=VecW.Elem[i];
  if (I < MatAU.NrOfColumns) then
    begin
    for j:=l to MatAU.NrOfColumns do
      MatAU.Elem[j,i] := 0.0;
    end;
  if (g <> 0.0)
    then begin
         g:=1.0/g;
         if (I <> MatAU.NrOfColumns) then
           begin
           for j:=l to MatAU.NrOfColumns do
             begin
             S:=0.0;
             for k:=l to MatAU.NrOfRows do
               S:=S+MatAU.Elem[i,k]*MatAU.Elem[j,k];
             F:=(S/MatAU.Elem[i,i])*g;
             for k:=i to MatAU.NrOfRows do
               MatAU.Elem[j,k] := MatAU.Elem[j,k]+F*MatAU.Elem[i,k];
             end;
           end;
         for j:=i to MatAU.NrOfRows do
         MatAU.Elem[i,j] := MatAU.Elem[i,j]*g;
         end
    else begin
         for j:=i to MatAU.NrOfRows do
           MatAU.Elem[i,j] := 0.0;
         end;
  MatAU.Elem[i,i] := MatAU.Elem[i,i]+1.0;
  end;

for k:=MatAU.NrOfColumns downto 1 do
  begin
  inc (ProcStat);
  its:=1;
  itsabort := False;
  while ((its < 30) and not itsabort) do
    begin
    l := k;
    AbortCond := 0;
    nm:=l-1;
    while ((l >= 1) and (AbortCond = 0)) do
      begin
      NM:=L-1;
      if ((abs(RotV.Elem[L])+ANorm) = ANorm)
        then AbortCond := 2
        else if ((abs(VecW.Elem[NM])+ANorm) = ANorm)
               then AbortCond := 1
               else dec (l);
      end;
    if abortcond <> 2 then
      begin
      S:=1.0;
      for i:=l to k do
        begin
        F:=S*RotV.Elem[I];
        if ((abs(F)+ANorm) <> ANorm) then
          begin
          g:=VecW.Elem[i];
          H:=SQRT(F*F+g*g);
          VecW.Elem[I] := H;
          H:=1.0/H;
          C:= g*H;
          S:=-F*H;
          for j:=1 to MatAU.NrOfRows do
            begin
            Y:=MatAU.Elem[nm,j];
            Z:=MatAU.Elem[i,j];
            MatAU.Elem[nm,j] := (Y*C)+(Z*S);
            MatAU.Elem[i,j] := -(Y*S)+(Z*C);
            end;
          end;
        end;
      end;
    Z:=VecW.Elem[K];
    if l=k
      then begin
           if (Z < 0.0) then
             begin
             VecW.Elem[K] := -Z;
             for j:=1 to MatAU.NrOfColumns do
               MatV.Elem[k,j] := -MatV.Elem[k,j];
             end;
           itsabort := True;
           end
      else begin
           if (its = 30) then
             reslt := false;
           X:=VecW.Elem[L];
           NM:=K-1;
           Y:=VecW.Elem[NM];
           g:=RotV.Elem[NM];
           H:=RotV.Elem[K];
           F:=((Y-Z)*(Y+Z)+(g-H)*(g+H))/(2.0*H*Y);
           g:=SQRT(F*F+1.0);
           F:=((X-Z)*(X+Z)+H*((Y/(F+SIGN(g,F)))-H))/X;
           C:=1.0;
           S:=1.0;
           for j:=l to nm do
             begin
             i:=j+1;
             g:=RotV.Elem[i];
             Y:=VecW.Elem[I];
             H:=S*g;
             g:=C*g;
             Z:=SQRT(F*F+H*H);
             RotV.Elem[J] := Z;
             C:=F/Z;
             S:=H/Z;
             F:= (X*C)+(g*S);
             g:=-(X*S)+(g*C);
             H:=Y*S;
             Y:=Y*C;
             for jj:=1 to MatAU.NrOfColumns do
               begin
               X:=MatV.Elem[j,jj];
               Z:=MatV.Elem[i,jj];
               MatV.Elem[j,jj] := (X*C)+(Z*S);
               MatV.Elem[i,jj] := -(X*S)+(Z*C);
               end;
             Z:=SQRT(F*F+H*H);
             VecW.Elem[J] := Z;
             if (Z <> 0.0) then
               begin
               Z:=1.0/Z;
               C:=F*Z;
               S:=H*Z;
               end;
             F:= (C*g)+(S*Y);
             X:=-(S*g)+(C*Y);
             for jj:=1 to MatAU.NrOfRows do
               begin
               Y:=MatAU.Elem[j,jj];
               Z:=MatAU.Elem[i,jj];
               MatAU.Elem[j,jj] := (Y*C)+(Z*S);
               MatAU.Elem[i,jj] := -(Y*S)+(Z*C);
               end;
             end;
           RotV.Elem[L] := 0.0;
           RotV.Elem[K] := F;
           VecW.Elem[K] := X;
           end;
    inc (its);
    end;
  end;
RotV.Free;
SingValDecomp := reslt;
end;


(**********************************************************)
function SingValEquSolve (MatAU, MatV: TMatrix;
                         VecW, VecB, VecX, VecdX: TVector): boolean;
(**********************************************************
  'SingValEquSolve' solves the system of equations A * X = B
  using the sigular value decomposed matrix A and the bias
  vector B.

  ENTRY:  MatAU .... SV decomposed matrix U
          MatV ..... SV decomposed matrix V
          VecW ..... SV decomposed matrix W (vector format)
          VecB ..... bias vector of equations
  EXIT:   VecX ..... solution of equations
          VecdX .... diagonal of inv(MatAU'*MatAU) which reflect
                     the uncertainties of the parameters. In order to
                     get the standard deviations of the parameters
                     VecdX should be multiplied by the standard
                     deviation of the residuals
          function returns TRUE if calculation succeeded
  REMARK: This routine is based on the algorithm published in
          W.H. Press et al., 'Numerical Recipes', p.57,
          Cambridge University Press, New York 1986.
 **********************************************************)

var
  jj,j,i : integer;
  k      : integer;
  s      : double;
  tmp    : TVector;
  reslt  : boolean;

begin
reslt := true;
tmp := TVector.Create (MatAU.NrOfColumns);
for j:=1 to MatAU.NrOfColumns do
  begin
  s := 0.0;
  if (VecW.Elem[j] <> 0.0) then
    begin
    for i:=1 to MatAU.NrOfRows do
      s := s + MatAU.Elem[j,i]*VecB.Elem[i];
    s := s/VecW.Elem[j];
    end;
  Tmp.Elem[j] := s;
  end;
for j:=1 to MatAU.NrOfColumns do
  begin
  s := 0.0;
  for jj:=1 to MatAU.NrOfColumns do
    s := s + MatV.Elem[jj,j]*Tmp.Elem[jj];
  VecX.Elem[j] := s;
  end;
if VecDX <> NIL then         (* calc. the uncertainties of the params *)
  begin
  for j:=1 to MatAU.NrOfColumns do
    begin
    Tmp.Elem[j] := 0;
    if VecW.Elem[j] <> 0.0 then
      Tmp.Elem[j] := 1/sqr(VecW.Elem[j]);
    end;
  for i:=1 to MatAU.NrOfColumns do
    begin
    s := 0;
    for k:=1 to MatAU.NrOfColumns do
      s := s + MatV.Elem[k,i]*MatV.Elem[k,i]*Tmp.Elem[k];
    VecdX.Elem[i] := sqrt(s);
    end;
  end;
tmp.Free;
SingValEquSolve := reslt;
end;



(*********************************************************)
function MultiLinReg (InData: TMatrix;   OutData,
            Coeff: TVector;   DeltaCoeff: TVector): boolean;
(*********************************************************
  'MultiLinReg' calculates the multiple linear regression.

  ENTRY:  InData ..... array of n measured data (f features)
                       size: f x n
          OutData .... vector of desired output values (size n)
  EXIT:   Coeff ...... vector of estimated linear regression
                       parameters (size f+1)
          DeltaCoeff.. vector of estimated linear regression
                       parameters errors(size f+1)
          function returns TRUE if the result is valid
          Indata is changed by the calculation

  REMARK: This routine uses singular value decomposition to
          get the result;
 *********************************************************)

const
  tol = 1e-8;  (* numerical tolerance for singular values
                  be sure to adjust according to floating
                  point precision *)

var
  MatV       : TMatrix;
  VecW       : TVector;
  j          : integer;
  wmin, wmax : double;
  reslt      : boolean;

begin                                    (* MultiLinReg *)
MatV := TMatrix.Create (InData.NrOfColumns,InData.NrOfColumns);
VecW := TVector.Create (InData.NrOfColumns);
reslt := SingValDecomp (InData, MatV, VecW);
if reslt then
  begin
  wmax := 0;
  for j:=1 to InData.NrOfColumns do
    if VecW.Elem[j] > wmax then
      wmax := VecW.Elem[j];
  wmin := wmax*tol;
  for j:=1 to InData.NrOfColumns do
    if VecW.Elem[j] < wmin then
      VecW.Elem[j] := 0;
  reslt := SingValEquSolve (InData, MatV, VecW, OutData, Coeff, DeltaCoeff);
  end;
MatV.Free;
VecW.Free;
MultiLinReg := reslt;
end;


(******************************************************************)
(*                              INIT                              *)
(******************************************************************)

begin
EigenDefined := False;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Halt;
  end;
{$ENDIF}
end.

