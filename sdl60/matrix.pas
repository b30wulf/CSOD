unit matrix;

(******************************************************************)
(*                                                                *)
(*                         M A T R I X                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                   April 1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-18, 2001                                  *)
(*                                                                *)
(******************************************************************)

{
Version   Changes
--------------------------------------------------------------------
1.0   first version to be released

1.1   released: Feb-17,1997
      TIntMatrix implemented
      destroy was not "Override" --> resulted in memory allocation problems with "Free"
      methods "Add", "Subtract", and "SMult" implemented

1.5   released: May-28,1997
      bug in "Resize" fixed, which restricted 32-bit matrices to 64k
      new method "Transpose" implemented
      D1,D2,D3, C++Builder versions available now

1.6   released: Apr-14,1998
      C++Builder 3.0 version available now
      new method "Quartiles"
      bug fix: TMatrix and TIntMatrix are now classes of TObject !!
      new event: OnChange (both TMatrix and TIntMatrix)
      new method Change implemented
      ESDLMatrixError replaces ELocompError
      TMat3D implemented
      CopyRowToVec, CopyColToVec implemented
      StandardizeColumns, and StandardizeRows implemented
      bug in resize fixed: access violation for large matrices
      create now initializes all elements to zero values
      method Sum implemented
      bug fixed which caused strange behavior for zero or negative
            array dimensions on create

1.7   [Aug-12, 1998]
      MATRIX is now available for Delphi 4.0
      Mat3D has now Resize method
      bug fix: resize methods of TMatrix and TIntMatrix now function
                   properly also in 16-bit mode
      CalcDistMat (TMatrix) implemented
      method Histogram implemented

1.8   [Mar-28, 1999]
      TMatrix & TIntMatrix have now OnSortExchange events
      method Clone implemented
      method Resize now does not execute if the new dimensions are
                   equal to the old ones
      method Trace implemented
      property Elem is now default property
      LU decomposition implemented
      function Determinant implemented

5.0   [Oct-09, 1999]
      MATRIX is now available for Delphi 5.0
      LoadFromFile of TMatrix and TIntMatrix extended

5.5   [May-01, 2000]
      LoadFromStream and SaveToStream for TMatrix and TIntMatrix implemented
      Sparse Matrix implemented
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fix: SkewKurt now calculates the skewness correctly
      new method SkewKurtSample of TMatrix and TIntMatrix implemented
      unit Matrix now uses unit Streams
      method GeometricMean implemented
      method HarmonicMean implemented
--------------------------------------------------------------------

}

{$O+}
{$F+}
{$R-}

{--------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
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

(*-------------------------------------------------------*)
interface
(*-------------------------------------------------------*)

uses
  math1, vector, classes, sysutils;

type
  ESDLMatrixError = class(Exception);     { exception type to indicate errors }
  TDistMode = (dmJaccard, dmManhattan, dmEuclid, dmEuclidSqr);
  TMatrix = class (TObject)
            private
              FNCol           : longint;                   { number of columns }
              FNRow           : longint;                      { number of rows }
              Mat             : pointer;
              FPrecis         : array[1..2] of integer; { format used in StoreOnFile }
              FOnChange       : TNotifyEvent;
              FOnSortExchange : TSortExchgEvent;
              function    GetVal (Nc,Nr: longint): double;
              procedure   SetVal (Nc,Nr: longint; Value: double);
              function    GetFPrecis (ix: integer): integer;
              procedure   SetFPrecis (ix: integer; value: integer);
              procedure   SkewKurtIntern (LowCol, LowRow, HighCol, HighRow: integer;
                                          var Skewness, Kurtosis: double; var NumData: longint);
            protected
              procedure   SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
            public
              constructor Create (Nc, Nr: longint);
              destructor  Destroy; override;
              property    Elem[ix,iy: longint]: double read GetVal write SetVal; default;
              function    Add (MatB: TMatrix): boolean;
              function    CalcDistMat (Mode: TDistMode; DMat: TMatrix): integer;
              procedure   Changed;
              procedure   CopyColToVec (DestVec: TVector;
                             Col, FirstRow, LastRow: integer);
              procedure   CopyFrom (MatSource: TMatrix;
                             SourceColLo, SourceRowLo,
                             SourceColHi, SourceRowHi,
                             DestCol, DestRow: integer);
              procedure   Clone (MatSource: TMatrix);
              procedure   CopyFromVec (VecSource: TVector;
                             Source1stElem, SourceLastElem,
                             DestCol, DestRow: integer);
              procedure   CopyRowToVec (DestVec: TVector;
                             Row, FirstCol, LastCol: integer);
              function    Determinant: double;
              procedure   Fill (value: double);
              procedure   Free;
              function    GeometricMean (LowCol, LowRow, HighCol, HighRow: integer): double;
              function    HarmonicMean (LowCol, LowRow, HighCol, HighRow: integer): double;
              function    Histogram (LoX, LoY, HiX, HiY: longint;
                             FirstBin, LastBin, BinWidth: double;
                             Histo: TIntVector; var Underflow, Overflow, MaxCnt: longint): boolean;
              function    Invert: boolean;
              function    LoadFromFile (FileName: string; AdjustMatrixSize: boolean): boolean;
              function    LoadFromStream (InStream: TMemoryStream; AdjustMatrixSize: boolean): boolean;
              function    LUdecomposition (var MatL, MatU: TMatrix): boolean;
              property    NrOfColumns: longint read FNCol;
              property    NrOfRows: longint read FNRow;
              property    Precision [Index: integer]: integer read GetFPrecis write SetFPrecis;
              procedure   MeanVar (LowCol, LowRow, HighCol,
                             HighRow: integer; var Mean,
                             Variance: double);
              procedure   MinMax (LowCol, LowRow, HighCol,
                             HighRow: integer; var Minimum,
                             Maximum: double);
              function    Multiply (MatB, MatRes: TMatrix): boolean;
              function    Quartiles (LowCol, LowRow, HighCol,
                             HighRow: integer; var Q1, Q2, Q3: double): boolean;
              function    Resize (Nc, Nr: longint): boolean;
              procedure   SaveToStream (var OutStream: TMemoryStream; LoC,LoR,HiC,HiR: integer);
              procedure   SkewKurt (LowCol, LowRow, HighCol,
                             HighRow: integer; var Skewness, Kurtosis: double);
              procedure   SkewKurtSample (LowCol, LowRow, HighCol,
                             HighRow: integer; var Skewness, Kurtosis: double);
              procedure   SMult (Scalar: double);
              procedure   SortCols (SortRowIx: integer; Ascending: boolean;
                             LowCol, LowRow, HighCol, HighRow: integer);
              procedure   SortRows (SortColIx: integer; Ascending: boolean;
                             LowCol, LowRow, HighCol,
                             HighRow: integer);
              procedure   StandardizeColumns (Means, StdDevs: TVector);
              procedure   StandardizeRows (Means, StdDevs: TVector);
              function    StoreOnFile
                             (LoC,LoR,HiC,HiR: integer;
                             FileName:string): boolean;
              function    Subtract (MatB: TMatrix): boolean;
              function    Sum (LoC,LoR,HiC,HiR: integer): double;
              function    Transpose: boolean;
              function    Trace: double;
              property    OnChange: TNotifyEvent read FOnChange write FOnChange;
              property    OnSortExchange: TSortExchgEvent read FOnSortExchange write FOnSortExchange;
            end;

  TIntMatrix = class (TObject)
            private
              FNCol           : longint;                   { number of columns }
              FNRow           : longint;                      { number of rows }
              FIsSparse       : boolean;                 { TRUE: sparse matrix }
              FNumAllocated   : longint; { number of allocated sparse elements }
              FAllocBy        : longint;  { increment of allocation for sparse matrix }
              FSparseNumElem  : longint; { number of elements in sparse matrix }
              FSparseLowCol   : longint;{ index of lowest column in sparse mat }
              FSparseHighCol  : longint;{index of highest column in sparse mat }
              FSparseLowRow   : longint;   { index of lowest row in sparse mat }
              FSparseHighRow  : longint;  { index of highest row in sparse mat }
              SpMat           : pointer;  { pointer to sparse matrix container }
              Mat             : pointer;              { pointer to matrix data }
              FOnChange       : TNotifyEvent;
              FOnSortExchange : TSortExchgEvent;
              function    GetVal (Nc,Nr: longint): integer;
              procedure   SetVal (Nc,Nr: longint; Value: integer);
              procedure SkewKurtIntern (LowCol, LowRow, HighCol, HighRow: integer;
                              var Skewness, Kurtosis: double; var NumData: longint);
            protected
              procedure   SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
            public
              constructor Create (Nc, Nr: longint);
              constructor CreateSparse (AllocBy: longint);
              destructor  Destroy; override;
              property    Elem[ix,iy: longint]: integer read GetVal write SetVal; default;
              function    Add (MatB: TIntMatrix): boolean;
              procedure   ArrayToSparse (AllocBy: longint);
              procedure   Changed;
              procedure   Clone (MatSource: TIntMatrix);
              procedure   CopyColToVec (DestVec: TIntVector;
                             Col, FirstRow, LastRow: integer);
              procedure   CopyFrom (MatSource: TIntMatrix;
                             SourceColLo, SourceRowLo,
                             SourceColHi, SourceRowHi,
                             DestCol, DestRow: integer);
              procedure   CopyRowToVec (DestVec: TIntVector;
                             Row, FirstCol, LastCol: integer);
              procedure   Fill (value: integer);
              function    GeometricMean (LowCol, LowRow, HighCol, HighRow: integer): double;
              function    HarmonicMean (LowCol, LowRow, HighCol, HighRow: integer): double;
              function    LoadFromFile (FileName: string; AdjustMatrixSize: boolean): boolean;
              function    LoadFromStream (InStream: TMemoryStream; AdjustMatrixSize: boolean): boolean;
              function    LoadSparseMat (FileName:string): boolean;
              property    NrOfColumns: longint read FNCol;
              property    NrOfRows: longint read FNRow;
              procedure   MeanVar (LowCol, LowRow, HighCol,
                             HighRow: integer; var Mean,
                             Variance: double);
              procedure   MinMax (LowCol, LowRow, HighCol,
                             HighRow: integer; var Minimum,
                             Maximum: integer);
              function    Multiply (MatB, MatRes: TIntMatrix)
                             : boolean;
              function    Quartiles (LowCol, LowRow, HighCol,
                             HighRow: integer; var Q1, Q2, Q3: double): boolean;
              function    Resize (Nc, Nr: longint): boolean;
              procedure   SaveToStream (var OutStream: TMemoryStream;
                             LoC,LoR,HiC,HiR: integer);
              procedure   SkewKurt (LowCol, LowRow, HighCol,
                             HighRow: integer; var Skewness, Kurtosis: double);
              procedure   SkewKurtSample (LowCol, LowRow, HighCol, HighRow: integer;
                             var Skewness, Kurtosis: double);
              procedure   SMult (Scalar: integer);
              procedure   SortCols (SortRowIx: integer; Ascending: boolean;
                             LowCol, LowRow, HighCol, HighRow: integer);
              procedure   SortRows (SortColIx: integer; Ascending: boolean;
                             LowCol, LowRow, HighCol,
                             HighRow: integer);
              procedure   SparseToArray;
              function    StoreOnFile
                             (LoC,LoR,HiC,HiR: integer;
                             FileName:string): boolean;
              function    StoreSparseMat (FileName:string): boolean;
              function    Subtract (MatB: TIntMatrix): boolean;
              function    Sum (LoC,LoR,HiC,HiR: integer): longint;
              function    Trace: longint;
              function    Transpose: boolean;
              property    OnChange: TNotifyEvent read FOnChange write FOnChange;
              property    OnSortExchange: TSortExchgEvent read FOnSortExchange write FOnSortExchange;
            end;

   TMat3D = class (TObject)
            private
              FNumX     : longint;     { number of columns }
              FNumY     : longint;        { number of rows }
              FNumZ     : longint;      { number of layers }
              Mat       : pointer;
              FOnChange : TNotifyEvent;
              function    GetVal (Nx,Ny,Nz: longint): double;
              procedure   SetVal (Nx,Ny,Nz: longint; Value: double);
            public
              constructor Create (Nc, Nr, Nl: longint);
              destructor  Destroy; override;
              procedure   Changed;
              property    Elem[ix,iy,iz: longint]: double read GetVal write SetVal; default;
              procedure   Fill (value: double);
              property    NrOfColumns: longint read FNumX;
              property    NrOfRows: longint read FNumY;
              property    NrOfLayers: longint read FNumZ;
              property    OnChange: TNotifyEvent read FOnChange write FOnChange;
              function    Resize (Nc, Nr, Nl: longint): boolean;
            end;

(*-------------------------------------------------------*)
implementation
(*-------------------------------------------------------*)

uses
  WinTypes, WinProcs, Streams {$IFDEF SHAREWARE}, dialogs {$ENDIF};


{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\matrix_ct.inc}
{$ENDIF}


type
  Array1D  = array[1..1] of double;
  Array1DI = array[1..1] of integer;
  TSpMatElemInt = record
                    colidx  : longint;
                    rowidx  : longint;
                    value   : longint;
                  end;
  ArraySpI = array[1..1] of TSpMatElemInt;


(*********************************************************)
constructor TMatrix.Create (Nc, Nr: longint);
(*********************************************************)

var
  i,j : integer;

begin
inherited Create;
if (nc <= 0) or (nr <= 0) then
  raise ESDLMatrixError.Create ('array dimensions zero or negative');
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}

FNCol := Nc;
FNRow := Nr;
FPrecis[1] := 15;
FPrecis[2] := -1;
{$IFDEF VER80}      { restrict only in 16-Bit version }
if longint(FNCol)*longint(FNRow)*SizeOf(double) > 65500
  then raise ESDLMatrixError.Create ('matrix too large')
  else begin
       GetMem (Mat, FNCol*FNRow*SizeOf(double));
       if (Mat = NIL) then
         raise ESDLMatrixError.Create ('not enough memory on heap');
       end;
{$ELSE}
GetMem (Mat, FNCol*FNRow*SizeOf(double));
if (Mat = NIL) then
  raise ESDLMatrixError.Create ('not enough memory on heap');
{$ENDIF}
for i:=1 to FNCol do
  for j:=1 to FNRow do
    Array1D(Mat^)[(j-1)*FNCol+i] := 0;
end;


(*********************************************************)
destructor TMatrix.Destroy;
(*********************************************************)

begin
if Mat <> NIL then
  FreeMem (Mat, FNCol*FNRow*SizeOf(double));
Mat := NIL;
inherited Destroy;
end;


(*********************************************************)
procedure TMatrix.Free;
(*********************************************************)

begin
inherited Free;
end;

(***********************************************************************)
procedure TMatrix.SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
(***********************************************************************
  ExchgWhat ..... 1 = columns, 2 = rows
  index1, index2 .... columns/rows to be exchanged
  first, last ....... range affected by sorting
 ***********************************************************************)

begin
if Assigned(FOnSortExchange) then
  FOnSortExchange (self, ExchgWhat, index1, index2, first, last);
end;

(***********************************************************************)
procedure TMatrix.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;


(*********************************************************)
function TMatrix.Resize (Nc, Nr: longint): boolean;
(*********************************************************
  ENTRY:  Nc, Nr .... number of columns and rows

  EXIT:   function returns TRUE if resizing has been completed
          successfully.  Data are not destroyed, if possible;
          new cells are filled with zero values.
 *********************************************************)

var
  reslt   : boolean;
  OldCol  : longint;
  OldRow  : longint;
  MinCol  : integer;
  MinRow  : integer;
  AuxMat  : pointer;
  i,j     : integer;

begin
reslt := true;
if (nc <> FNCol) or (nr <> FNRow) then
  begin
  reslt := FALSE;
  {$IFDEF VER80}                  { restrict only in 16-Bit version }
  if longint(nc)*longint(nc)*SizeOf(double) > 65500
    then raise ESDLMatrixError.Create ('matrix too large')
    else
  {$ENDIF}
         begin
         if (nc > 0) and (nr > 0) then
           begin
           OldCol := FNCol;
           OldRow := FNRow;
           GetMem (AuxMat, OldCol*Oldrow*SizeOf(double));
           if (AuxMat <> NIL) then
             begin
             for i:=1 to OldCol do    (* copy existing data into auxiliary matrix *)
               for j:=1 to OldRow do
                 Array1D(AuxMat^)[(j-1)*OldCol+i] := Array1D(Mat^)[(j-1)*OldCol+i];
             FreeMem (Mat, OldCol*OldRow*SizeOf(double));  (* dispose and setup new matrix *)
             GetMem (Mat, Nc*Nr*SizeOf(double));
             if Mat = NIL
               then begin                             (* restore original matrix *)
                    GetMem (Mat, OldCol*Oldrow*SizeOf(double));
                    for i:=1 to OldCol do
                      for j:=1 to OldRow do
                        Array1D(Mat^)[(j-1)*OldCol+i] := Array1D(AuxMat^)[(j-1)*OldCol+i];
                    end
               else begin
                    FNCol := Nc;                 (* take new matrix and restore data *)
                    FNRow := Nr;
                    for i:=1 to Nc do
                      for j:=1 to Nr do
                        Array1D(Mat^)[(j-1)*FNCol+i] := 0;
                    MinCol := FNCol;
                    if OldCol < MinCol then
                      MinCol := OldCol;
                    MinRow := FNRow;
                    if OldRow < MinRow then
                      MinRow := OldRow;
                    for i:=1 to MinCol do
                      for j:=1 to MinRow do
                        Array1D(Mat^)[(j-1)*FNCol+i] := Array1D(AuxMat^)[(j-1)*OldCol+i];
                    reslt := TRUE;
                    end;
             FreeMem (AuxMat, OldCol*OldRow*SizeOf(double));
             end;
           Changed;
           end;
         end;
  end;
Resize := reslt;
end;

(*********************************************************)
function TMatrix.Histogram (LoX, LoY, HiX, HiY: longint;
            FirstBin, LastBin, BinWidth: double; Histo: TIntVector;
            var Underflow, Overflow, MaxCnt: longint): boolean;
(*********************************************************
  ENTRY: data matrix .... contains data
         LoX, LoY, HiX, HiY .... coords of upper left and lower right corner
         FirstBin .............. value of first bin
         LastBin ............... value of last bin
         BinWidth .............. width of bins

  EXIT:  histo ................. resulting histogram
         Underflow ............. underflow count
         overflow .............. overflow count
         MaxCnt ................ maximum count
         function returns TRUE if Histo contains valid data
 *********************************************************)

const
  MaxBins = 500;

var
  NBins : integer;
  ix    : integer;
  reslt : boolean;
  i, j  : integer;

begin
reslt := false;
NBins := round(abs(LastBin-FirstBin)/BinWidth);
if NBins <= MaxBins then
  begin
  reslt := true;
  if Histo.NrOfElem <> NBins then
    Histo.Resize (NBins);
  Histo.Clear;
  UnderFlow := 0;
  OverFlow := 0;
  MaxCnt := 0;
  for i:=LoX to HiX do
    for j:=LoY to HiY do
      begin
      if Elem[i,j] < FirstBin
        then inc (UnderFlow)
        else begin
             if Elem[i,j] >= LastBin+BinWidth
               then inc (OverFlow)
               else begin
                    ix := 1+trunc((Elem[i,j]-FirstBin)/BinWidth);
                    Histo.Elem[ix] := Histo.Elem[ix] + 1;
                    if Histo.Elem[ix] > MaxCnt then
                      MaxCnt := Histo.Elem[ix];
                    end;
             end;
      end;
  end;
HistoGram := reslt;
end;


(*********************************************************)
procedure TMatrix.StandardizeColumns (means, stddevs: TVector);
(*********************************************************
  ENTRY:  data matrix

  EXIT:   columns of data matrix are standardized (mean = 0, stddev = 1)
          if means and/or stddevs <> NIL then the mean values
          and/or standard deviations of the original data are
          returned in these two vectors. The size of 'means'
          and 'stddevs' must correspond to the number of columns
          of the data matrix.
 *********************************************************)

var
  i, j     : integer;
  Mean     : double;
  Variance : double;

begin
for i:=1 to FNCol do
  begin
  MeanVar (i, 1, i, FNRow, Mean, Variance);
  if Variance > 0.0 then
    for j:=1 to FNRow do
      Array1D(Mat^)[(j-1)*FNCol+i] := (Array1D(Mat^)[(j-1)*FNCol+i]-Mean)/sqrt(Variance);
  if Means <> NIL then
    Means.Elem[i] := Mean;
  if StdDevs <> NIL then
    StdDevs.Elem[i] := sqrt(Variance);
  end;
Changed;
end;

(*********************************************************)
procedure TMatrix.StandardizeRows (Means, StdDevs: TVector);
(*********************************************************
  ENTRY:  data matrix

  EXIT:   rows of data matrix are standardized (mean = 0, stddev = 1)
          if means and/or stddevs <> NIL then the mean values
          and/or standard deviations of the original data are
          returned in these two vectors. The size of 'means'
          and 'stddevs' must correspond to the number of rows
          of the data matrix.
 *********************************************************)

var
  i, j     : integer;
  Mean     : double;
  Variance : double;

begin
for i:=1 to FNRow do
  begin
  MeanVar (1, i, FNCol, i, Mean, Variance);
  if Variance > 0.0 then
    for j:=1 to FNCol do
      Array1D(Mat^)[(i-1)*FNCol+j] := (Array1D(Mat^)[(i-1)*FNCol+j]-Mean)/sqrt(Variance);
  if Means <> NIL then
    Means.Elem[i] := Mean;
  if StdDevs <> NIL then
    StdDevs.Elem[i] := sqrt(Variance);
  end;
Changed;
end;


(*********************************************************)
function TMatrix.Transpose: boolean;
(*********************************************************
  ENTRY:  Matrix with c columns and r rows

  EXIT:   transposed matrix with r columns and c rows
 *********************************************************)

var
  reslt   : boolean;
  AuxMat  : pointer;
  i,j     : integer;
  ldummy  : longint;

begin
reslt := FALSE;
GetMem (AuxMat, FNCol*FNRow*SizeOf(double));
if (AuxMat <> NIL) then
  begin
  for i:=1 to FNCol do    { copy existing data into auxiliary matrix }
    for j:=1 to FNRow do
      Array1D(AuxMat^)[(j-1)*FNCol+i] := Array1D(Mat^)[(j-1)*FNCol+i];
  for i:=1 to FNCol do               { copy back in transposed order }
    for j:=1 to FNRow do
      Array1D(Mat^)[(i-1)*FNRow+j] := Array1D(AuxMat^)[(j-1)*FNCol+i];
  ldummy := FNCol;
  FnCol := FnRow;
  FNRow := ldummy;
  reslt := TRUE;
  FreeMem (AuxMat, FNCol*FNRow*SizeOf(double));
  Changed;
  end;
Transpose := reslt;
end;


(*********************************************************)
function TMatrix.GetFPrecis (ix: integer): integer;
(*********************************************************)

begin
if ix <= 1
  then GetFPrecis := FPrecis[1]
  else GetFPrecis := FPrecis[2];
end;


(*********************************************************)
procedure TMatrix.SetFPrecis (ix: integer; value: integer);
(*********************************************************)

begin
if value < -1 then
  value := -1;
if value > 25 then
  value := 25;
if ix <= 1
  then FPrecis[1] := value
  else FPrecis[2] := value;
end;


(*********************************************************)
function TMatrix.GetVal (Nc,Nr: longint): double;
(*********************************************************)

begin
if (Mat <> NIL) and
   (Nc >= 1) and (Nc <= FNCol) and
   (Nr >= 1) and (Nr <= FNRow)
  then GetVal := Array1D(Mat^)[(Nr-1)*FNCol+Nc]
  else GetVal := 0;
end;


(*********************************************************)
procedure TMatrix.SetVal (Nc,Nr: longint; Value: double);
(*********************************************************)

begin
if (Mat <> NIL) and
   (Nc >= 1) and (Nc <= FNCol) and
   (Nr >= 1) and (Nr <= FNRow) then
  begin
  Array1D(Mat^)[(Nr-1)*FNCol+Nc] := value;
  Changed;
  end;
end;


(*********************************************************)
procedure TMatrix.SortRows (SortColIx: integer; Ascending: boolean;
                      LowCol, LowRow, HighCol, HighRow: integer);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
         SortColIx ......... index of column to be taken as
                             sorting criterion
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)

  EXIT:  array sorted according to column 'SortColIx' within
         range (LowCol..HighRow). Column 'SortColIx' is sorted
         too, regardless whether 'SortRowIx' lies within range
         (LowCol..HighCol) or not.

  REMARK: algorithm used for sorting: modified bubble sort
 *********************************************************)


const
  ShrinkFac = 1.3;

var
  JumpWidth : word;
  ix        : integer;
  exchngd   : boolean;
  rdummy    : real;
  i         : integer;


begin
if HighRow < LowRow then
  Exchange (HighRow, LowRow, sizeof (Highrow));
if HighCol < LowCol then
  Exchange (HighCol, LowCol, sizeof (HighCol));
if LowRow < 1 then
  LowRow := 1;
if LowRow > FNRow then
  LowRow := FNRow;
if HighRow < 1 then
  HighRow := 1;
if HighRow > FNRow then
  HighRow := FNRow;
JumpWidth := HighRow-LowRow;
if JumpWidth > 0 then
  begin
  if Ascending
    then begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowRow;
           exchngd := False;
           repeat
             if Array1D(Mat^)[(ix-1)*FNCol+SortColIx] > Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] then
               begin
               for i:=LowCol to HighCol do
                 begin
                 rdummy := Array1D(Mat^)[(ix-1)*FNCol+i];
                 Array1D(Mat^)[(ix-1)*FNCol+i] := Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+i];
                 Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+i] := rdummy;
                 exchngd := True;
                 end;
               if (SortColIx < LowCol) or (SortColIx > HighCol) then
                 begin
                 rdummy := Array1D(Mat^)[(ix-1)*FNCol+SortColIx];
                 Array1D(Mat^)[(ix-1)*FNCol+SortColIx] := Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx];
                 Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] := rdummy;
                 end;
               SortExchange (2, ix, ix+jumpWidth, LowCol, HighCol);
               end;
             inc (ix);
           until (ix+JumpWidth > HighRow);
         until ((JumpWidth = 1) and not exchngd);
         end
    else begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowRow;
           exchngd := False;
           repeat
             if Array1D(Mat^)[(ix-1)*FNCol+SortColIx] < Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] then
               begin
               for i:=LowCol to HighCol do
                 begin
                 rdummy := Array1D(Mat^)[(ix-1)*FNCol+i];
                 Array1D(Mat^)[(ix-1)*FNCol+i] := Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+i];
                 Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+i] := rdummy;
                 exchngd := True;
                 end;
               if (SortColIx < LowCol) or (SortColIx > HighCol) then
                 begin
                 rdummy := Array1D(Mat^)[(ix-1)*FNCol+SortColIx];
                 Array1D(Mat^)[(ix-1)*FNCol+SortColIx] := Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx];
                 Array1D(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] := rdummy;
                 end;
               SortExchange (2, ix, ix+jumpWidth, LowCol, HighCol);
               end;
             inc (ix);
           until (ix+JumpWidth > HighRow);
         until ((JumpWidth = 1) and not exchngd);
         end;
  Changed;
  end;
end;


(*********************************************************)
procedure TMatrix.SortCols (SortRowIx: integer; Ascending: boolean;
                      LowCol, LowRow, HighCol, HighRow: integer);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
         SortRowIx ......... index of row to be taken as
                             sorting criterion
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)

  EXIT:  array sorted according to row 'SortRowIx' within
         range (LowCol..HighRow). Row 'SortRowIx' is sorted
         too, regardless whether 'SortRowIx' lies within range
         (LowRow..HighRow) or not.

  REMARK: algorithm used for sorting: modified bubble sort
 *********************************************************)


const
  ShrinkFac = 1.3;

var
  JumpWidth : word;
  ix        : integer;
  exchngd   : boolean;
  rdummy    : real;
  i         : integer;


begin
if HighRow < LowRow then
  Exchange (HighRow, LowRow, sizeof (Highrow));
if HighCol < LowCol then
  Exchange (HighCol, LowCol, sizeof (HighCol));
if LowRow < 1 then
  LowRow := 1;
if LowRow > FNRow then
  LowRow := FNRow;
if HighRow < 1 then
  HighRow := 1;
if HighRow > FNRow then
  HighRow := FNRow;
JumpWidth := HighCol-LowCol;
if JumpWidth > 0 then
  begin
  if Ascending
    then begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowCol;
           exchngd := False;
           repeat
             if Array1D(Mat^)[(SortRowix-1)*FNCol+Ix] > Array1D(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] then
               begin
               for i:=LowRow to HighRow do
                 begin
                 rdummy := Array1D(Mat^)[(i-1)*FNCol+ix];
                 Array1D(Mat^)[(i-1)*FNCol+ix] := Array1D(Mat^)[(i-1)*FNCol+ix+JumpWidth];
                 Array1D(Mat^)[(i-1)*FNCol+ix+JumpWidth] := rdummy;
                 exchngd := True;
                 end;
               if (SortRowIx < LowRow) or (SortRowIx > HighRow) then
                 begin
                 rdummy := Array1D(Mat^)[(SortRowix-1)*FNCol+Ix];
                 Array1D(Mat^)[(SortRowix-1)*FNCol+Ix] := Array1D(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth];
                 Array1D(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] := rdummy;
                 end;
               SortExchange (1, ix, ix+jumpWidth, LowRow, HighRow);
               end;
             inc (ix);
           until (ix+JumpWidth > HighCol);
         until ((JumpWidth = 1) and not exchngd);
         end
    else begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowCol;
           exchngd := False;
           repeat
             if Array1D(Mat^)[(SortRowix-1)*FNCol+Ix] < Array1D(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] then
               begin
               for i:=LowRow to HighRow do
                 begin
                 rdummy := Array1D(Mat^)[(i-1)*FNCol+ix];
                 Array1D(Mat^)[(i-1)*FNCol+ix] := Array1D(Mat^)[(i-1)*FNCol+ix+JumpWidth];
                 Array1D(Mat^)[(i-1)*FNCol+ix+JumpWidth] := rdummy;
                 exchngd := True;
                 end;
               if (SortRowIx < LowRow) or (SortRowIx > HighRow) then
                 begin
                 rdummy := Array1D(Mat^)[(SortRowix-1)*FNCol+Ix];
                 Array1D(Mat^)[(SortRowix-1)*FNCol+Ix] := Array1D(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth];
                 Array1D(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] := rdummy;
                 end;
               SortExchange (1, ix, ix+jumpWidth, LowRow, HighRow);
               end;
             inc (ix);
           until (ix+JumpWidth > HighCol);
         until ((JumpWidth = 1) and not exchngd);
         end;
  Changed;
  end;
end;


(*********************************************************)
function TMatrix.Determinant: double;
(*********************************************************
  ENTRY: self ..... quadratic matrix

  EXIT:  function returns determinant of self

  REMARK: determinant is calculated by LU decomposition
 *********************************************************)

var
  MatL, MatU : TMatrix;
  prod       : double;
  i          : integer;

begin
MatL := TMatrix.Create (2,2);
MatU := TMatrix.Create (2,2);
prod := 0;
if self.LUdecomposition (MatL, MatU) then
  begin
  prod := 1.0;
  for i:=1 to FNCol do
    prod := prod * MatU[i,i];
  end;
MatL.Free;
MatU.Free;
Determinant := prod;
end;


(*********************************************************)
function TMatrix.LUdecomposition (var MatL, MatU: TMatrix): boolean;
(*********************************************************
  ENTRY: self ..... matrix to be decomposed

  EXIT:  MatL ..... lower matrix
         MatU ..... upper matrix

  REMARK: LU decomposition according to Crout
 *********************************************************)


var
  i,j,k : integer;
  sum   : double;
  reslt : boolean;

begin
reslt := false;
if FNCol = FNRow then
  begin
  if (MatL <> NIL) and (MatU <> NIL) then
    begin
    if self[1,1] <> 0 then
      begin
      reslt := true;
      MatL.Resize (FNCol, FNCol);
      MatL.Fill (0);
      MatU.Clone (self);
      for j:=2 to FNCol do
        MatU[1,j] := MatU[1,j]/MatU[1,1];
      for j:=2 to FNCol-1 do
        begin
        for i:=j to FNCol do
          begin
          sum := 0;
          for k:=1 to j-1 do
            sum := sum + MatU[i,k]*MatU[k,j];
          MatU[i,j] := MatU[i,j] - sum;
          end;
        for k := j+1 to FNCol do
          begin
          sum := 0;
          for i:=1 to j-1 do
            sum := sum + MatU[j,i]*MatU[i,k];
          if MatU[j,j] = 0
            then reslt := false
            else MatU[j,k] := (MatU[j,k]-sum)/MatU[j,j];
          end;
        end;
      sum := 0;
      for k:=1 to FNCol-1 do
        sum := sum + MatU[FNCol,k]*MatU[k,FNCol];
      MatU[FNCol,FNCol] := MatU[FNCol,FNCol] - sum;
      end;
    if reslt then
      begin
      for i:=1 to FNCol-1 do  { now split into two tridiagonal matrices }
        begin
        MatL[i,i] := 1;
        for j:=i+1 to FNCol do
          begin
          MatL[i,j] := MatU[i,j];
          MatU[i,j] := 0;
          end;
        end;
      MatL[FNCol,FNCol] := 1;
      end;
    end;
  end;
LUdecomposition := reslt;
end;


(*********************************************************)
procedure TMatrix.MinMax
                  (LowCol, LowRow, HighCol, HighRow: integer;
                  var Minimum, Maximum: double);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  Minimum, Maximum .. minimum and maximum value in
                             searched area
 *********************************************************)

var
  i,j   : integer;
  value : double;

begin
Minimum := MaxReal;
Maximum := -MaxReal;
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1D(Mat^)[(j-1)*FNCol+i];
      if value < Minimum then
        Minimum := value;
      if value > Maximum then
        Maximum := value;
      end;
  end;
end;

(*********************************************************)
function TMatrix.Sum (LoC,LoR,HiC,HiR: integer): double;
(*********************************************************
  ENTRY: LoC, LoR ....... indices of element in matrix
                          where to start search
         HiC, HiR ....... indices of element in matrix
                          where to stop search
  EXIT:  function returns sum of elements in specified range
 *********************************************************)

var
  i,j     : integer;
  total   : double;

begin
total := 0;
if (Mat <> NIL) then
  begin
  if LoC < 1 then
    LoC := 1;
  if LoC > FNCol then
    LoC := FNCol;
  if LoR < 1 then
    LoR := 1;
  if LoR > FNRow then
    LoR := FNRow ;
  if HiC < 1 then
    HiC := 1;
  if HiC > FNCol then
    HiC := FNCol;
  if HiR < 1 then
    HiR := 1;
  if HiR > FNRow then
    HiR := FNRow;
  if LoR > HiR then
    ExChange (LoR, HiR, sizeof(LoR));
  if LoC > HiC then
    ExChange (LoC, HiC, sizeof(LoC));
  for i:=LoC to HiC do
    for j:=LoR to HiR do
      total := total + Array1D(Mat^)[(j-1)*FNCol+i];
  end;
sum := total;
end;

(*********************************************************)
function TMatrix.Trace: double;
(*********************************************************
  ENTRY: quadratic matrix

  EXIT:  function returns trace of elements in specified range
         if matrix not quadratic, a value of zero is returned
 *********************************************************)

var
  i       : integer;
  total   : double;

begin
total := 0;
if (FNCol = FNRow ) then
  begin
  for i:=1 to FNCol do
    total := total + Array1D(Mat^)[(i-1)*FNCol+i];
  end;
trace := total;
end;




(*********************************************************)
procedure TMatrix.MeanVar
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Mean, Variance: double);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  Mean, Variance .... mean and variance of indicated
                             region
 *********************************************************)

var
  i,j     : integer;
  value   : double;
  NumData : integer;
  sum     : double;
  Sumq    : double;

begin
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  NumData := 0;
  sum := 0.0;
  sumq := 0.0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1D(Mat^)[(j-1)*FNCol+i];
      sum := sum + value;
      sumq := sumq + sqr(value);
      inc (NumData);
      end;
  Mean := sum / NumData;
  Variance := 1.0;
  if NumData >= 3 then
    Variance := (sumq-sqr(sum)/NumData)/(NumData-1);
  end;
end;



(*********************************************************)
function TMatrix.GeometricMean (LowCol, LowRow, HighCol,
             HighRow: integer): double;
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  function returns geometric mean
         if any argument is negative, an exception is raised
 *********************************************************)

var
  i,j       : integer;
  value     : double;
  sum       : double;
  ZeroFound : boolean;

begin
result := 0;
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  sum := 0.0;
  ZeroFound := false;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1D(Mat^)[(j-1)*FNCol+i];
      if value < 0
        then raise ESDLMatrixError.Create ('negative argument passed to GeometricMean')
        else begin
             if value = 0
               then ZeroFound := true
               else sum := sum + ln(value);
             end
      end;
  if ZeroFound
    then result := 0
    else result := exp(sum/(HighRow-LowRow+1)/(HighCol-LowCol+1));
  end;
end;



(*********************************************************)
function TMatrix.HarmonicMean (LowCol, LowRow, HighCol,
             HighRow: integer): double;
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  function returns harmonic mean
         if any argument is negative or zero, an exception is raised
 *********************************************************)

var
  i,j       : integer;
  value     : double;
  sum       : double;

begin
result := 0;
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  sum := 0.0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1D(Mat^)[(j-1)*FNCol+i];
      if value <= 0
        then raise ESDLMatrixError.Create ('negative or zero argument passed to HarmonicMean')
        else begin
             sum := sum + 1/value;
             end
      end;
  result := 1.0*(HighRow-LowRow+1)*(HighCol-LowCol+1)/sum;
  end;
end;


(*********************************************************)
procedure TMatrix.SkewKurtIntern
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Skewness, Kurtosis: double; var NumData: longint);
(*********************************************************
  ENTRY: LowCol, LowRow ...... indices of element in matrix
                               where to start search
         HighCol, HighRow .... indices of element in matrix
                               where to stop search
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
         NumData ............. number of data involved
 *********************************************************)

var
  i,j     : integer;
  value   : double;
  sum     : double;
  sumq    : double;
  Mean    : double;
  pot     : double;
  stddev  : double;

begin
SkewNess := 0;
Kurtosis := 0;
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  NumData := 0;
  sum := 0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1D(Mat^)[(j-1)*FNCol+i];
      sum := sum + value;
      inc (NumData);
      end;
  Mean := sum / NumData;
  sumq := 0;
  sum := 0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := (Array1D(Mat^)[(j-1)*FNCol+i]-mean);
      sum := sum + value;
      pot := sqr(value);
      sumq := sumq + pot;
      pot := pot*value;
      SkewNess := SkewNess+pot;
      pot := pot*value;
      Kurtosis := Kurtosis+pot;
      end;
  if (NumData > 1) then
    begin
    stddev := sqrt((sumq-sqr(sum)/NumData)/(NumData-1));
    if stddev <> 0 then
      begin
      SkewNess := Skewness/NumData/stddev/stddev/stddev;
      Kurtosis := Kurtosis/NumData/sqr(sqr(stddev))-3;
      end;
    end;
  end;
end;


(*********************************************************)
procedure TMatrix.SkewKurt
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowCol, LowRow ...... indices of element in matrix
                               where to start search
         HighCol, HighRow .... indices of element in matrix
                               where to stop search
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  nd : longint;

begin
SkewKurtIntern (LowCol, LowRow, HighCol, HighRow, Skewness, Kurtosis, nd);
end;


(*********************************************************)
procedure TMatrix.SkewKurtSample
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowCol, LowRow ...... indices of element in matrix
                               where to start search
         HighCol, HighRow .... indices of element in matrix
                               where to stop search
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  NumData : integer;

begin
SkewKurtIntern (LowCol, LowRow, HighCol, HighRow, Skewness, Kurtosis, NumData);
if NumData > 3
  then begin
       Kurtosis := (Kurtosis+3)*NumData*NumData*(NumData+1)/(NumData-1)/(NumData-2)/(NumData-3)
             -3*sqr(NumData-1)/(NumData-2)/(NumData-3);
       Skewness := Skewness*NumData*NumData/(NumData-1)/(NumData-2);
       end
  else begin
       Kurtosis := 0;
       Skewness := 0;
       end;
end;


(*********************************************************)
function TMatrix.Quartiles (LowCol, LowRow, HighCol, HighRow: integer;
                            var Q1, Q2, Q3: double): boolean;
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start calculation
         HighCol, HighRow .. indices of element in matrix
                             where to stop calculation
  EXIT:  Q1, Q2, Q3 ........ quartiles of distribution
 *********************************************************)

type
  darrtype = array [1..1] of double;

var
  srtarray  : pointer;
  i,j       : integer;
  LengArray : longint;
  ix        : integer;
  dx        : double;
  reslt     : boolean;

begin
reslt := false;
Q1 := 0;
Q2 := 0;
Q3 := 0;
if (Mat <> NIL) then
  begin
  reslt := true;
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  LengArray := (HighRow-LowRow+1)*(HighCol-LowCol+1);
  Getmem (srtarray, LengArray*sizeof(double));
  if srtArray = NIL
    then reslt := false
    else begin
         for i:=LowCol to HighCol do
           begin
           for j:=LowRow to HighRow do
             darrType(SrtArray^)[1+i-LowCol+(j-LowRow)*(HighCol-LowCol+1)] := Array1D(Mat^)[(j-1)*FNCol+i];
           end;
         SortArray (SrtArray, LengArray, dnum, true);
         if LengArray > 1
           then begin
                ix := 1 + (LengArray-1) div 4;
                dx := (darrType(SrtArray^)[1+ix]-(darrType(SrtArray^)[ix]))/4;
                Q1 := (darrType(SrtArray^)[ix])+((LengArray-1) mod 4)*dx;
                ix := 1 + 2*(LengArray-1) div 4;
                dx := (darrType(SrtArray^)[1+ix]-(darrType(SrtArray^)[ix]))/4;
                Q2 := (darrType(SrtArray^)[ix])+(2*(LengArray-1) mod 4)*dx;
                ix := 1 + 3*(LengArray-1) div 4;
                dx := (darrType(SrtArray^)[1+ix]-(darrType(SrtArray^)[ix]))/4;
                Q3 := (darrType(SrtArray^)[ix])+(3*(LengArray-1) mod 4)*dx;
                end
           else begin
                Q1 := darrType(SrtArray^)[1];
                Q2 := darrType(SrtArray^)[1];
                Q3 := darrType(SrtArray^)[1];
                end;
         Freemem (srtarray, LengArray*sizeof(double));
         end;
  end;
Quartiles := reslt;
end;


(*********************************************************)
procedure TMatrix.Fill (value: double);
(*********************************************************
  ENTRY: value ...... value to fill matrix with
  EXIT:  matrix is filled with 'value'
 *********************************************************)

var
  i,j   : integer;

begin
if (Mat <> NIL) then
  begin
  for i:=1 to FNCol do
    for j:=1 to FNRow do
      Array1D(Mat^)[(j-1)*FNCol+i] := value;
  Changed;
  end;
end;


(*********************************************************)
procedure TMatrix.CopyRowToVec (DestVec: TVector;
                       Row, FirstCol, LastCol: integer);
(*********************************************************
  ENTRY: DestVec ..... destination vector
         Row ......... row to be copied to vector
         FirstCol .... column of matrix row to become the first element
                       of DestVec
         LastCol ..... column of matrix row to become the last element
                       of DestVec
  EXIT:  DestVec contains data of specified matrix area. if the
         range does not fit into DestVec either some values of
         DestVec are set to zero, or some values of the matrix
         row are not copied to the vector
 *********************************************************)

var
  i : integer;

begin
if DestVec <> NIL then
  begin
  if FirstCol < 1 then
    FirstCol := 1;
  if LastCol < 1 then
    LastCol := 1;
  if FirstCol > FNCol then
    FirstCol := FNCol;
  if LastCol > FNCol then
    LastCol := FNCol;
  if Row < 1 then
    Row := 1;
  if Row > FNRow then
    Row := FNRow;
  if FirstCol > LastCol then
    ExChange (FirstCol,LastCol,sizeof(FirstCol));
  if LastCol-FirstCol+1 > DestVec.NrOfElem then
    LastCol := FirstCol+DestVec.NrOfElem-1;
  DestVec.Fill(0);
  for i:=FirstCol to LastCol do
    DestVec.Elem[i-FirstCol+1] := Array1D(Mat^)[(row-1)*FNCol+i]
  end;
end;


(*********************************************************)
procedure TMatrix.CopyColToVec (DestVec: TVector;
                       Col, FirstRow, LastRow: integer);
(*********************************************************
  ENTRY: DestVec ..... destination vector
         Col ......... column to be copied to vector
         FirstRow .... row of matrix column to become the first element
                       of DestVec
         LastRow ..... row of matrix column to become the last element
                       of DestVec
  EXIT:  DestVec contains data of specified matrix area. if the
         range does not fit into DestVec either some values of
         DestVec are set to zero, or some values of the matrix
         column are not copied to the vector
 *********************************************************)

var
  i : integer;

begin
if DestVec <> NIL then
  begin
  if FirstRow < 1 then
    FirstRow := 1;
  if LastRow < 1 then
    LastRow := 1;
  if FirstRow > FNRow then
    FirstRow := FNRow;
  if LastRow > FNRow then
    LastRow := FNRow;
  if Col < 1 then
    Col := 1;
  if Col > FNCol then
    Col := FNCol;
  if FirstRow > LastRow then
    ExChange (FirstRow,LastRow,sizeof(FirstRow));
  if LastRow-FirstRow+1 > DestVec.NrOfElem then
    LastRow := FirstRow+DestVec.NrOfElem-1;
  DestVec.Fill(0);
  for i:=FirstRow to LastRow do
    DestVec.Elem[i-FirstRow+1] := Array1D(Mat^)[(i-1)*FNCol+col];
  end;
end;


(*********************************************************)
procedure TMatrix.Clone (MatSource: TMatrix);
(*********************************************************
  ENTRY: MatSource ... source matrix to be copied
  EXIT:  matrix self is clone of MatSource
 *********************************************************)

var
  i,j : integer;

begin
if MatSource <> NIL then
  begin
  self.Resize (MatSource.NrOfColumns, MatSource.NrOfRows);
  for i:=1 to MatSource.NrOfColumns do
    for j:=1 to MatSource.NrOfRows do
      self.setval (i, j, MatSource.Getval (i,j));
  Changed;
  end;
end;



(*********************************************************)
procedure TMatrix.CopyFrom (MatSource: TMatrix; SourceColLo,
                    SourceRowLo, SourceColHi, SourceRowHi,
                    DestCol, DestRow: integer);
(*********************************************************
  ENTRY: MatSource ... source matrix to be copied
         SourceColLo, SourceColHi ... range of columns in source matrix
         SourceRowLo, SourceRowHi ... range of rows in source matrix
  EXIT:  matrix Mat1 is copied to Mat2;
 *********************************************************)

var
  i,j : integer;

begin
if MatSource <> NIL then
  begin
  if SourceColLo < 1 then
    SourceColLo := 1;
  if SourceRowLo < 1 then
    SourceRowLo := 1;
  if SourceColLo > MatSource.NrOfColumns then
    SourceColLo := MatSource.NrOfColumns;
  if SourceRowLo > MatSource.NrOfRows then
    SourceRowLo := MatSource.NrOfRows;
  if SourceColHi < 1 then
    SourceColHi := 1;
  if SourceRowHi < 1 then
    SourceRowHi := 1;
  if SourceColHi > MatSource.NrOfColumns then
    SourceColHi := MatSource.NrOfColumns;
  if SourceRowHi > MatSource.NrOfRows then
    SourceRowHi := MatSource.NrOfRows;
  if SourceRowLo > SourceRowHi then
    ExChange (SourceRowLo,SourceRowHi,sizeof(SourceRowLo));
  if SourceColLo > SourceColHi then
    ExChange (SourceColLo,SourceColHi,sizeof(SourceColLo));
  for i:=SourceColLo to SourceColHi do
    for j:=SourceRowLo to SourceRowHi do
      self.setval (i-SourceColLo+DestCol,j-SourceRowLo+DestRow,
                   MatSource.Getval (i,j));
  Changed;
  end;
end;



(*********************************************************)
procedure TMatrix.CopyFromVec (VecSource: TVector;
              Source1stElem, SourceLastElem,
              DestCol, DestRow: integer);
(*********************************************************
  ENTRY: VecSource ... source vector to be copied
         Source1stElem,
         SourceLastElem ... range of elements in source vector
         DestCol, DestRow ... position to copy to

  EXIT:  parts of vector VecSource are copied to Matrix
 *********************************************************)

var
  i : integer;

begin
if VecSource <> NIL then
  begin
  if Source1stElem < 1 then
    Source1stElem := 1;
  if Source1stElem > VecSource.NrOfElem then
    Source1stElem := VecSource.NrOfElem;
  if SourceLastElem < 1 then
    SourceLastElem := 1;
  if SourceLastElem > VecSource.NrOfElem then
    SourceLastElem := VecSource.NrOfElem;
  if Source1stElem > SourceLastElem then
    ExChange (Source1stElem,SourceLastElem,sizeof(Source1stElem));
  for i:=Source1stElem to SourceLastElem do
    self.setval (DestCol,i-Source1stElem+DestRow,VecSource.Elem[i]);
  Changed;
  end;
end;


(*********************************************************)
procedure TMatrix.SMult (Scalar: double);
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         Scalar ........ scalar number
  EXIT:  self .......... = Matrix A * Scalar
 *********************************************************)

var
  i,j     : integer;

begin
for i:=1 to FNRow do
  for j:=1 to FNCol do
    begin
    Array1D(Mat^)[(i-1)*FNCol+j] := Array1D(Mat^)[(i-1)*FNCol+j] * Scalar;
    end;
Changed;
end;



(*********************************************************)
function TMatrix.Multiply (MatB, MatRes: TMatrix): boolean;
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         MatB .......... Matrix B (Dimension M x P)
  EXIT:  MatRes ........ resulting matrix (Dimension N x P)
         function returns TRUE if result is ok
 *********************************************************)

var
  i,j,k   : integer;
  reslt   : boolean;
  sum     : double;

begin
reslt := false;
if ((MatB <> NIL) and (MatRes <> NIL)) then
  if (FNCol = MatB.NrOfRows) and
     (MatRes.NrOfColumns = MatB.NrOfColumns) and
     (MatRes.NrOfRows = FNRow) then
    begin
    reslt := true;
    for i:=1 to FNRow do
      for j:=1 to MatB.NrOfColumns do
        begin
        sum := 0;
        for k:=1 to FNCol do
          sum := sum + Array1D(Mat^)[(i-1)*FNCol+k]*
                       Array1D(MatB.Mat^)[(k-1)*MatB.FNCol+j];
        MatRes.SetVal (j,i,sum);
        end;
    Changed;
    end;
Multiply := reslt;
end;

(*********************************************************)
function TMatrix.Add (MatB: TMatrix): boolean;
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         MatB .......... Matrix B (Dimension N x M)
  EXIT:  self .......... has added matrix B
         function returns TRUE if result is ok
 *********************************************************)

var
  i,j     : integer;
  reslt   : boolean;

begin
reslt := false;
if (MatB <> NIL) then
  if (FNCol = MatB.NrOfColumns) and (FNRow = MatB.NrOfRows) then
    begin
    reslt := true;
    for i:=1 to FNRow do
      for j:=1 to FNCol do
        begin
        Array1D(Mat^)[(i-1)*FNCol+j] := Array1D(Mat^)[(i-1)*FNCol+j] +
                                        Array1D(MatB.Mat^)[(i-1)*MatB.FNCol+j];
        end;
    Changed;
    end;
Add := reslt;
end;

(*********************************************************)
function TMatrix.Subtract (MatB: TMatrix): boolean;
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         MatB .......... Matrix B (Dimension N x M)
  EXIT:  self .......... = Matrix A - Matrix B
         function returns TRUE if result is ok
 *********************************************************)

var
  i,j     : integer;
  reslt   : boolean;

begin
reslt := false;
if (MatB <> NIL) then
  if (FNCol = MatB.NrOfColumns) and (FNRow = MatB.NrOfRows) then
    begin
    reslt := true;
    for i:=1 to FNRow do
      for j:=1 to FNCol do
        begin
        Array1D(Mat^)[(i-1)*FNCol+j] := Array1D(Mat^)[(i-1)*FNCol+j] -
                                        Array1D(MatB.Mat^)[(i-1)*MatB.FNCol+j];
        end;
    Changed;
    end;
Subtract := reslt;
end;



(******************************************************************)
function TMatrix.Invert: boolean;
(******************************************************************
  ENTRY:    InMat ..... pointer to symmetric data matrix.
            Size ...... size of that matrix

  EXIT:     InMat ..... holds the inverse of the entry matrix
            Function result is TRUE if matrix inversion has been
            completed successfully.
 ******************************************************************)


const
  AlmostZero = 1e-10;  (* this value must be adjusted for
                    single precision floating point routines *)

//type
//  Array1DI = array[1..1] of integer;

var
  RowScal       : ^Array1D;   (* implicit scaling of rows *)
  PermIX        : ^Array1DI;  (* permutation index for LU-decomposition *)
  Bias          : ^Array1D;   (* bias for inversion *)
  DummyMat      : ^Array1D;   (* auxiliary matrix *)


function InvertbyLUDecomp: boolean;
(*-------------------------------*)

{ ENTRY:    symmetric data matrix
  EXIT:     Function returns TRUE if inversion of matrix has been done
            without any errors, else (singular matix, out of memory)
            FALSE is returned. The matrix 'InMat' is destroyed during
            calculation and is replaced by the inverse of the input
            matrix. The routine is based on Crout's algorithm  }

var
  reslt       : boolean;
  i,j         : integer;
  i1          : integer;
  PivotIdx    : integer;
  PivotVal    : double;
  sum         : double;
  rdummy      : double;
  cix         : integer;   (* column index *)

{$IFNDEF VER80}
  {$WARNINGS OFF}
{$ENDIF}

begin
reslt := TRUE;
for i:= 1 to FNCol do
  begin
  PermIX^[i] := i;                  (* initialize permutation index *)
  rdummy := 0;
  for cix:= 1 to FNCol do                (* get scaling info of rows *)
    if (abs(Array1D(Mat^)[(i-1)*FNCol+cix]) > rdummy) then
      rdummy := abs(Array1D(Mat^)[(i-1)*FNCol+cix]);
  if rdummy = 0
    then reslt := FALSE                (* all elements are zero ! *)
    else RowScal^[i] := 1/rdummy;
  end;
if reslt then
  begin
  for cix:=1 to FNCol do   (* process all columns, starting with the first *)
    begin
    for i:=1 to cix-1 do
      begin
      sum := Array1D(Mat^)[(i-1)*FNCol+cix];
      for j:=1 to i-1 do
        sum := sum-Array1D(Mat^)[(i-1)*FNCol+j]*Array1D(Mat^)[(j-1)*FNCol+cix];
      Array1D(Mat^)[(i-1)*FNCol+cix] := sum;
      end;
    PivotVal := 0;
    for i:=cix to FNCol do
      begin
      sum := Array1D(Mat^)[(i-1)*FNCol+cix];
      for j:=1 to cix-1 do
        sum := sum-Array1D(Mat^)[(i-1)*FNCol+j]*
                   Array1D(Mat^)[(j-1)*FNCol+cix];
      Array1D(Mat^)[(i-1)*FNCol+cix] := sum;
      if RowScal^[i]*abs(sum) >= PivotVal then
        begin
        PivotVal := RowScal^[i]*abs(sum);
        PivotIdx := i;
        end;
      end;
    if (cix <> PivotIdx) then
      begin
      for j:=1 to FNCol do
        begin
        rdummy := Array1D(Mat^)[(PivotIdx-1)*FNCol+j];
        Array1D(Mat^)[(PivotIdx-1)*FNCol+j] := Array1D(Mat^)[(cix-1)*FNCol+j];
        Array1D(Mat^)[(cix-1)*FNCol+j] := rdummy;
        end;
      RowScal^[PivotIdx] := RowScal^[cix];
      end;
    PermIX^[cix] := PivotIdx;
    if abs(Array1D(Mat^)[(cix-1)*FNCol+cix]) < AlmostZero then
      begin
      reslt := false;
      Array1D(Mat^)[(cix-1)*FNCol+cix] := AlmostZero;
      end;
    if cix <> FNCol then
      begin
      rdummy := Array1D(Mat^)[(cix-1)*FNCol+cix];
      for i := cix+1 to FNCol do
        Array1D(Mat^)[(i-1)*FNCol+cix] := Array1D(Mat^)[(i-1)*FNCol+cix]/rdummy;
      end;
    end;
  end;
if reslt then                         (* do substitution *)
  begin
  for cix:=1 to FNCol do
    begin
    for i:=1 to FNCol do
      Bias^[i] := 0;
    Bias^[cix] := 1;
    i1 := 0;
    for i:=1 to FNCol do                (* forward substitution *)
      begin
      sum := Array1D(bias^)[PermIX^[i]];
      Array1D(bias^)[PermIX^[i]] := Array1D(bias^)[i];
      if (i1 <> 0)
        then for j:= i1 to i-1 do
               sum := sum - Array1D(Mat^)[(i-1)*FNCol+j]*Array1D(bias^)[j]
        else if (sum <> 0)
               then i1 := i;
      Array1D(bias^)[i] := sum;
      end;
    for i:=FNCol downto 1 do            (* back substitution *)
      begin
      sum := Array1D(bias^)[i];
      if (i < FNCol) then
        for j:= i+1 to FNCol do
          sum := sum - Array1D(Mat^)[(i-1)*FNCol+j]*Array1D(bias^)[j];
      Array1D(bias^)[i] := sum/Array1D(Mat^)[(i-1)*FNCol+i];
      end;
    for i:=1 to FNCol do
      DummyMat^[(i-1)*FNCol+cix] := Bias^[i];
    end;
  for i:=1 to FNCol do
    for cix:=1 to FNCol do
      Array1D(Mat^)[(i-1)*FNCol+cix] :=
              Array1D(DummyMat^)[(i-1)*FNCol+cix];
  end;
InvertbyLUdecomp := Reslt;
end;

{$IFNDEF VER80}
  {$WARNINGS ON}
{$ENDIF}

var
  reslt : boolean;

begin                                       (* invert matrix *)
reslt := False;
if FNCol = FNRow then       (* only valid for quadratic matrix *)
  begin
  GetMem (RowScal, FNRow*SizeOf(double));
  if (RowScal = NIL)
    then reslt := FALSE
    else begin
         GetMem (PermIx, FNCol*SizeOf(integer));
         if (PermIx = NIL)
           then begin
                FreeMem (RowScal, FNRow*SizeOf(double));
                reslt := FALSE;
                end
           else begin
                GetMem (Bias, FNRow*SizeOf(double));
                if (Bias = NIL)
                  then begin
                       FreeMem (RowScal, FNRow*SizeOf(double));
                       FreeMem (PermIx, FNCol*SizeOf(integer));
                       reslt := FALSE;
                       end
                  else begin
                       GetMem (DummyMat, FNCol*FNCol*SizeOf(double));
                       if (DummyMat = NIL)
                         then begin
                              FreeMem (RowScal, FNRow*SizeOf(double));
                              FreeMem (PermIx, FNCol*SizeOf(integer));
                              FreeMem (Bias, FNCol*SizeOf(double));
                              reslt := False;
                              end
                         else begin
                              reslt := InvertByLUdecomp;     (* inversion of matrix *)
                              FreeMem (RowScal, FNRow*SizeOf(double));
                              FreeMem (PermIx, FNCol*SizeOf(integer));
                              FreeMem (Bias, FNCol*SizeOf(double));
                              FreeMem (DummyMat, FNCol*FNCol*SizeOf(double));
                              Changed;
                              end;
                       end;
                end;
         end;
  end;
Invert := reslt;
end;

(******************************************************************)
function TMatrix.StoreOnFile (LoC,LoR,HiC,HiR: integer;
                          FileName:string): boolean;
(******************************************************************
  ENTRY:    LoR, LoC, HiR, HiC .... indices of table area to store
            FileName .............. name of data file

  EXIT:     function return ....... TRUE if storage successfull
            values are store in an ASCII file according to the
            following format:
                1. line:  NrRows, first Row, last Row
                2. line:  NrColumns, first Column, last Column
                from 3. line: each line holds on row of table, values
                              are separated by blanks
 ******************************************************************)

var
  TFile  : text;
  i,j    : integer;
  reslt  : boolean;

begin
reslt := false;
if LoC < 1 then
  LoC := 1;
if HiC > NrOfColumns then
  HiC := NrOfColumns;
if HiC < LoC then
  ExChange (HiC,LoC,sizeof(HiC));
if LoR < 1 then
  LoR := 1;
if HiR > NrOfRows then
  HiR := NrOfRows;
if HiR < LoR then
  ExChange (HiR,LoR,sizeof(HiR));
assign (TFile, FIlename);
{$I-} rewrite (TFile); {$I+}
if IoResult = 0 then
  begin
  reslt := True;
  writeln (TFile,LoR,' ',HiR);
  writeln (TFile,LoC,' ',HiC);
  for i:=LoR to HiR do
    begin
    for j:=LoC to HiC do
      write (TFile, GetVal (j,i):FPrecis[1]:FPrecis[2],' ');
    writeln (TFile);
    end;
  close (TFile);
  end;
StoreOnFile := reslt;
end;


(******************************************************************)
procedure TMatrix.SaveToStream (var OutStream: TMemoryStream;
                       LoC,LoR,HiC,HiR: integer);
(******************************************************************
  ENTRY:    OutStream ............. stream where matrix is stored
                                    if OutStream = nil, a new stream object is created
            LoR, LoC, HiR, HiC .... indices of table area to store
            FileName .............. name of data file

  EXIT:     selected matrix elements are stored in OutStream
            values are saved in binary format (extended):
                1. first Row
                2. last Row
                3. first Column
                4. last Column
                from 5th item : matrix elements row-wise
 ******************************************************************)

var
  i,j    : integer;

begin
if LoC < 1 then
  LoC := 1;
if HiC > NrOfColumns then
  HiC := NrOfColumns;
if HiC < LoC then
  ExChange (HiC,LoC,sizeof(HiC));
if LoR < 1 then
  LoR := 1;
if HiR > NrOfRows then
  HiR := NrOfRows;
if HiR < LoR then
  ExChange (HiR,LoR,sizeof(HiR));
if OutStream = nil then
  OutStream := TMemoryStream.Create;
WriteExtendedToStream (OutStream, LoR);
WriteExtendedToStream (OutStream, HiR);
WriteExtendedToStream (OutStream, LoC);
WriteExtendedToStream (OutStream, HiC);
for i:=LoR to HiR do
  begin
  for j:=LoC to HiC do
    WriteExtendedToStream (OutStream, GetVal (j,i));
  end;
end;


(******************************************************************)
function TMatrix.LoadFromFile (FileName: string; AdjustMatrixSize: boolean): boolean;
(******************************************************************
  ENTRY:    FileName ............ name of data file
            AdjustMatrixSize .... TRUE matrix is resized to fit the new data

  EXIT:     function return ..... TRUE if data loaded successfully
 ******************************************************************)

var
  TFile      : text;
  i,j        : integer;
  reslt      : boolean;
  LoC, HiC   : integer;
  LoR, HiR   : integer;
  rdummy     : double;

begin
reslt := False;
assign (TFile, Filename);
{$I-} reset (TFile); {$I+}
if IoResult = 0 then
  begin
  read (TFile,LoR,HiR);
  read (TFile,LoC,HiC);
  if AdjustMatrixSize then
    Resize (HiC, HiR);
  if ((HiR <= NrOfRows) and (HiC <= NrOfColumns)) then
    begin
    reslt := True;
    for i:=LoR to HiR do
      for j:=LoC to HiC do
        begin
        {$I-} read (TFile, rdummy); {$I+}
        if IOResult = 0 then
          SetVal (j,i,rdummy);
        end;
    end;
  close (TFile);
  Changed;
  end;
LoadFromFile := reslt;
end;


(******************************************************************)
function TMatrix.LoadFromStream (InStream: TMemoryStream; AdjustMatrixSize: boolean): boolean;
(******************************************************************
  ENTRY:    InStream ............ stream holding the data to be read in binary format
            AdjustMatrixSize .... TRUE matrix is resized to fit the new data

  EXIT:     matrix is set accordingly
            function returns TRUE is matrix elements are read successfully
 ******************************************************************)

var
  i,j        : integer;
  LoC, HiC   : integer;
  LoR, HiR   : integer;
  extdummy   : extended;
  reslt      : boolean;
  eos        : boolean;

begin
reslt := false;
if InStream <> nil then
  begin
  HiC := 0;
  LoC := 0;
  HiR := 0;
  LoR := round(ReadExtendedFromStream (InStream, eos));
  if not eos then
    HiR := round(ReadExtendedFromStream (InStream, eos));
  if not eos then
    LoC := round(ReadExtendedFromStream (InStream, eos));
  if not eos then
    HiC := round(ReadExtendedFromStream (InStream, eos));
  if not eos then
    begin
    if AdjustMatrixSize then
      Resize (HiC, HiR);
    if ((HiR <= NrOfRows) and (HiC <= NrOfColumns)) then
      begin
      reslt := True;
      for i:=LoR to HiR do
        for j:=LoC to HiC do
          begin
          extdummy := ReadExtendedFromStream (Instream, eos);
          if not eos
            then SetVal (j,i, extdummy)
            else reslt := false;
          end;
      end;
    Changed;
    end;
  end;
LoadFromStream := reslt;
end;




(*********************************************************)
function TMatrix.CalcDistMat (Mode: TDistMode; DMat: TMatrix): integer;
(*********************************************************
  ENTRY:  Mode ....... mode of distance calculation
          DMat ....... quadratic (empty) distance matrix

  EXIT:   DMat is filled with distances according to mode

  REMARK: DMat must be quadratic, and its size must correspond
          to the number of rows of the data matrix 'self'.
          If DMat does not meet these requirements an error
          code is returned:
               0 .... no error
              -1 .... DMat not quadratic
              -2 .... size does not fit number of row of data matrix
 *********************************************************)


var
  i,j,k      : integer;
  error      : integer;
  xsqr, ysqr : double;
  xy         : double;
  d          : double;

begin
error := 0;
if DMat.NrOfRows <> DMat.NrofColumns then
  error := -1;
if FNRow <> DMat.NrOfColumns then
  error := -2;
if error = 0 then
  begin
  for i:=1 to FNRow-1 do              { calculate the distance matrix }
    begin
    DMat.Elem [i,i] := 0;
    for j:=i+1 to FNRow do
      begin
      d := 0;
      case Mode of
         dmJaccard : begin
                     xsqr := 0;
                     ysqr := 0;
                     xy := 0;
                     for k:=1 to FNCol do
                       begin
                       xy := xy + self.Elem[k,i]*self.Elem[k,j];
                       xsqr := xsqr + self.Elem[k,i]*self.Elem[k,i];
                       ysqr := ysqr + self.Elem[k,j]*self.Elem[k,j];
                       end;
                     d := xy/(xsqr+ysqr-xy);
                     end;
          dmEuclid : begin
                     for k:=1 to FNCol do
                       d := d + sqr(self.Elem[k,i]-self.Elem[k,j]);
                     d := sqrt(d);
                     end;
       dmEuclidSqr : begin
                     for k:=1 to FNCol do
                       d := d + sqr(self.Elem[k,i]-self.Elem[k,j]);
                     end;
       dmManhattan : begin
                     for k:=1 to FNCol do
                       d := d + abs(self.Elem[k,i]-self.Elem[k,j]);
                     end;
      end;
      DMat.Elem [i,j] := d;
      DMat.Elem [j,i] := d;
      end;
    end;
  DMat.Elem [FNRow,FNRow] := 0;
  end;
CalcDistMat := error;
end;


(*********************************************************)
function TIntMatrix.GetVal (Nc,Nr: longint): integer;
(*********************************************************)

var
  SearchLow      : integer;
  SearchHigh     : integer;
  SearchMid      : integer;

begin
if not FIsSparse
  then begin
       if (Mat <> NIL) and
          (Nc >= 1) and (Nc <= FNCol) and
          (Nr >= 1) and (Nr <= FNRow)
         then GetVal := Array1DI(Mat^)[(Nr-1)*FNCol+Nc]
         else GetVal := 0;
       end
  else begin
       if (SpMat <> NIL) and
          (Nc >= FSparseLowCol) and (Nc <= FSparseHighCol) and
          (Nr >= FSparseLowRow) and (Nr <= FSparseHighRow)
         then begin  // binary search in sparse matrix
              {$I spmatbinsrc.inc}
              if (ArraySpI(SpMat^)[SearchLow].colidx = Nc) and
                 (ArraySpI(SpMat^)[SearchLow].rowidx = Nr)
                then GetVal := ArraySpI(SpMat^)[SearchLow].Value
                else GetVal := 0;
              end
         else GetVal := 0;
       end;
end;


(*********************************************************)
procedure TIntMatrix.SetVal (Nc,Nr: longint; Value: integer);
(*********************************************************)

var
  SearchLow      : integer;
  SearchHigh     : integer;
  SearchMid      : integer;
  AuxMat         : pointer;
  i              : integer;
  NumAllocatedOld: longint;

begin
if not FIsSparse
  then begin
       if (Mat <> NIL) and
          (Nc >= 1) and (Nc <= FNCol) and
          (Nr >= 1) and (Nr <= FNRow) then
         begin
         Array1DI(Mat^)[(Nr-1)*FNCol+Nc] := value;
         Changed;
         end;
       end
  else begin
       if (SpMat <> NIL) then
         begin
         {$I spmatbinsrc.inc}
         if (FSparseNumElem > 0) and
            (ArraySpI(SpMat^)[SearchLow].colidx = Nc) and
            (ArraySpI(SpMat^)[SearchLow].rowidx = Nr)
           then ArraySpI(SpMat^)[SearchLow].value := value
           else begin
                if FSparseNumElem+1 > FNumAllocated then
                  begin           // extend memory pool
                  NumAllocatedOld := FNumAllocated;
                  FNumAllocated := FNumAllocated + FAllocBy;
                  GetMem (AuxMat, FNumAllocated*SizeOf(TSpMatElemInt));
                  if AuxMat <> nil then
                    begin
                    for i:=1 to FSparseNumElem do  // copy existing matrix elements
                      ArraySpI(AuxMat^)[i] := ArraySpI(SpMat^)[i];
                    FreeMem (SpMat, NumAllocatedOld*SizeOf(TSpMatElemInt));
                    SpMat := AuxMat;  // aux. mat is now maxtrix container
                    end;
                  end;
                if FSparseNumElem > 0 then
                  if (ArraySpI(SpMat^)[SearchLow].colidx < Nc)
                    then inc (SearchLow)
                    else if (ArraySpI(SpMat^)[SearchLow].colidx = Nc) and
                            (ArraySpI(SpMat^)[SearchLow].Rowidx < Nr) then
                           inc (SearchLow);
                inc (FSparseNumElem);     // insert new data
                for i:=FSparseNumElem downto SearchLow+1 do
                  ArraySpI(SpMat^)[i] := ArraySpI(SpMat^)[i-1];
                ArraySpI(SpMat^)[SearchLow].colidx := Nc;
                ArraySpI(SpMat^)[SearchLow].Rowidx := Nr;
                ArraySpI(SpMat^)[SearchLow].value := value;
                if Nc < FSparseLowCol then
                  FSparseLowCol := Nc;
                if Nr < FSparseLowRow then
                  FSparseLowRow := Nr;
                if Nc > FSparseHighCol then
                  FSparseHighCol := Nc;
                if Nr > FSparseHighRow then
                  FSparseHighRow := Nr;
                FNCol := FSparseHighCol;
                FNRow := FSparseHighRow;
                end;
         Changed;
         end;
       end;
end;


(*********************************************************)
constructor TIntMatrix.CreateSparse (AllocBy: longint);
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

FIsSparse := True;
FAllocBy := AllocBy;
if FAllocBy < 1 then
  FAllocBy := 1;
GetMem (SpMat, FAllocBy*SizeOf(TSpMatElemInt));
FNumAllocated := FAllocBy;
if (SpMat = NIL) then
  raise ESDLMatrixError.Create ('not enough memory on heap');
FSparseNumElem := 0;
FSparseLowCol := MaxLongInt;
FSparseHighCol := 1;
FSparseLowRow := MaxLongInt;
FSparseHighRow := 1;
FNCol := 0;
FNRow := 0;
end;


(*********************************************************)
constructor TIntMatrix.Create (Nc, Nr: longint);
(*********************************************************)

var
  i,j : integer;

begin
inherited Create;
if (nc <= 0) or (nr <= 0) then
  raise ESDLMatrixError.Create ('array dimensions zero or negative');
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}

FIsSparse := false;
FNCol := Nc;
FNRow := Nr;
{$IFDEF VER80}      { restrict only in 16-Bit version }
if longint(FNCol)*longint(FNRow)*SizeOf(integer) > 65500
  then raise ESDLMatrixError.Create ('matrix too large')
  else begin
       GetMem (Mat, FNCol*FNRow*SizeOf(integer));
       if (Mat = NIL) then
         raise ESDLMatrixError.Create ('not enough memory on heap');
       end;
{$ELSE}
GetMem (Mat, FNCol*FNRow*SizeOf(integer));
if (Mat = NIL) then
  raise ESDLMatrixError.Create ('not enough memory on heap');
{$ENDIF}
for i:=1 to FNCol do
  for j:=1 to FNRow do
    Array1DI(Mat^)[(j-1)*FNCol+i] := 0;
end;


(*********************************************************)
destructor TIntMatrix.Destroy;
(*********************************************************)

begin
if Mat <> NIL then
  FreeMem (Mat, FNCol*FNRow*SizeOf(integer));
Mat := NIL;
if SpMat <> NIL then
  FreeMem (SpMat, FNumAllocated*SizeOf(TSpMatElemInt));
SpMat := NIL;
inherited Destroy;
end;

(***********************************************************************)
procedure TIntMatrix.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;

(***********************************************************************)
procedure TIntMatrix.SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
(***********************************************************************
  ExchgWhat ..... 1 = columns, 2 = rows
  index1, index2 .... columns/rows to be exchanged
  first, last ....... range affected by sorting
 ***********************************************************************)

begin
if Assigned(FOnSortExchange) then
  FOnSortExchange (self, ExchgWhat, index1, index2, first, last);
end;


(*********************************************************)
function TIntMatrix.Resize (Nc, Nr: longint): boolean;
(*********************************************************
  ENTRY:  Nc, Nr .... number of columns and rows

  EXIT:   function returns TRUE if resizing has been completed
          successfully.  Data are not destroyed, if possible;
          new cells are filled with zero values.
 *********************************************************)

var
  reslt   : boolean;
  OldCol  : longint;
  OldRow  : longint;
  MinCol  : integer;
  MinRow  : integer;
  AuxMat  : pointer;
  i,j     : integer;

begin
reslt := false;
if FIsSparse
  then begin
       FNCol := Nc;
       FNRow := Nr;
       if FSparseHighCol > Nc then
         FSparseHighCol := Nc;
       if FSparseHighRow > Nr then
         FSparseHighRow := Nr;
       if FSparseLowCol > FSparseHighCol then
         FSparseLowCol := FSparseHighCol;
       if FSparseLowRow > FSparseHighRow then
         FSparseLowRow := FSparseHighRow;
       j := 0;
       for i:= 1 to FSparseNumElem do   // remove all entries which are outside [Nc, Nr]
         begin
         if (ArraySpI(SpMat^)[i].colidx <= Nc) and
            (ArraySpI(SpMat^)[i].Rowidx <= Nr) then
           begin
           inc(j);
           ArraySpI(SpMat^)[j] := ArraySpI(SpMat^)[i];
           end;
         end;
       FSparseNumElem := j;
       end
  else begin
       if (nc <> FNCol) or (nr <> FNRow) then
         begin
         {$IFDEF VER80}                  { restrict only in 16-Bit version }
         if longint(nc)*longint(nr)*SizeOf(integer) > 65500
           then raise ESDLMatrixError.Create ('matrix too large')
           else
         {$ENDIF}
                begin
                if (nc > 0) and (nr > 0) then
                  begin
                  OldCol := FNCol;
                  OldRow := FNRow;
                  GetMem (AuxMat, OldCol*Oldrow*SizeOf(integer));
                  if (AuxMat <> NIL) then
                    begin
                    for i:=1 to OldCol do    (* copy existing data into auxiliary matrix *)
                      for j:=1 to OldRow do
                        Array1DI(AuxMat^)[(j-1)*OldCol+i] := Array1DI(Mat^)[(j-1)*OldCol+i];
                    FreeMem (Mat, OldCol*OldRow*SizeOf(integer));  (* dispose and setup new matrix *)
                    GetMem (Mat, Nc*Nr*SizeOf(integer));
                    if Mat = NIL
                      then begin                             (* restore original matrix *)
                           GetMem (Mat, OldCol*Oldrow*SizeOf(integer));
                           for i:=1 to OldCol do
                             for j:=1 to OldRow do
                               Array1DI(Mat^)[(j-1)*OldCol+i] := Array1DI(AuxMat^)[(j-1)*OldCol+i];
                           end
                      else begin
                           FNCol := Nc;                 (* take new matrix and restore data *)
                           FNRow := Nr;
                           for i:=1 to Nc do
                             for j:=1 to Nr do
                               Array1DI(Mat^)[(j-1)*FNCol+i] := 0;
                           MinCol := FNCol;
                           if OldCol < MinCol then
                             MinCol := OldCol;
                           MinRow := FNRow;
                           if OldRow < MinRow then
                             MinRow := OldRow;
                           for i:=1 to MinCol do
                             for j:=1 to MinRow do
                               Array1DI(Mat^)[(j-1)*FNCol+i] := Array1DI(AuxMat^)[(j-1)*OldCol+i];
                           reslt := TRUE;
                           Changed;
                           end;
                    FreeMem (AuxMat, OldCol*OldRow*SizeOf(integer));
                    end;
                  end;
                end;
         end;
       end;
Resize := reslt;
end;


(*********************************************************)
function TIntMatrix.Transpose: boolean;
(*********************************************************
  ENTRY:  Matrix with c columns and r rows

  EXIT:   transposed matrix with r columns and c rows
 *********************************************************)

const
  ShrinkFac = 1.3;

var
  reslt   : boolean;
  AuxMat  : pointer;
  i,j     : integer;
  ldummy  : longint;
  JumpWidth : longint;
  ix        : longint;
  HasChanged: boolean;
  SpMElem   : TSpMatElemInt;

begin
if FIsSparse
  then begin
       reslt := true;
       for i:=1 to FSparseNumElem do  // exchange rows and columns
         begin
         ldummy := ArraySpI(SpMat^)[i].colidx;
         ArraySpI(SpMat^)[i].colidx := ArraySpI(SpMat^)[i].rowidx;
         ArraySpI(SpMat^)[i].rowidx := ldummy;
         end;
       ldummy := FSparseLowCol;
       FSparseLowCol := FSparseLowRow;
       FSparseLowRow := ldummy;
       ldummy := FSparseHighCol;
       FSparseHighCol := FSparseHighRow;
       FSparseHighRow := ldummy;
       if FSparseNumElem > 1 then                // sort it
         begin
         JumpWidth := FSparseNumElem;
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := 1;
           HasChanged := False;
           repeat
             if (ArraySpI(SpMat^)[ix].colidx > ArraySpI(SpMat^)[ix+JumpWidth].colidx) or
                ((ArraySpI(SpMat^)[ix].colidx = ArraySpI(SpMat^)[ix+JumpWidth].colidx) and
                 (ArraySpI(SpMat^)[ix].rowidx > ArraySpI(SpMat^)[ix+JumpWidth].rowidx)) then
               begin
               SPMElem := ArraySpI(SpMat^)[ix];
               ArraySpI(SpMat^)[ix] := ArraySpI(SpMat^)[ix+JumpWidth];
               ArraySpI(SpMat^)[ix+JumpWidth] := SPMElem;
               HasChanged := True;
               end;
             inc (ix);
           until (ix+JumpWidth > FSparseNumElem);
         until ((JumpWidth = 1) and not HasChanged);
         end;
       Changed;
       end
  else begin
       reslt := FALSE;
       GetMem (AuxMat, FNCol*FNRow*SizeOf(integer));
       if (AuxMat <> NIL) then
         begin
         for i:=1 to FNCol do    { copy existing data into auxiliary matrix }
           for j:=1 to FNRow do
             Array1DI(AuxMat^)[(j-1)*FNCol+i] := Array1DI(Mat^)[(j-1)*FNCol+i];
         for i:=1 to FNCol do               { copy back in transposed order }
           for j:=1 to FNRow do
             Array1DI(Mat^)[(i-1)*FNRow+j] := Array1DI(AuxMat^)[(j-1)*FNCol+i];
         ldummy := FNCol;
         FnCol := FnRow;
         FNRow := ldummy;
         reslt := TRUE;
         FreeMem (AuxMat, FNCol*FNRow*SizeOf(integer));
         Changed;
         end;
       end;
Transpose := reslt;
end;


(*********************************************************)
procedure TIntMatrix.CopyRowToVec (DestVec: TIntVector;
                       Row, FirstCol, LastCol: integer);
(*********************************************************
  ENTRY: DestVec ..... destination vector
         Row ......... row to be copied to vector
         FirstCol .... column of matrix row to become the first element
                       of DestVec
         LastCol ..... column of matrix row to become the last element
                       of DestVec
  EXIT:  DestVec contains data of specified matrix area. if the
         range does not fit into DestVec either some values of
         DestVec are set to zero, or some values of the matrix
         row are not copied to the vector
 *********************************************************)

var
  i : integer;

begin
if DestVec <> NIL then
  begin
  if FirstCol < 1 then
    FirstCol := 1;
  if LastCol < 1 then
    LastCol := 1;
  if FirstCol > FNCol then
    FirstCol := FNCol;
  if LastCol > FNCol then
    LastCol := FNCol;
  if Row < 1 then
    Row := 1;
  if Row > FNRow then
    Row := FNRow;
  if FirstCol > LastCol then
    ExChange (FirstCol,LastCol,sizeof(FirstCol));
  if LastCol-FirstCol+1 > DestVec.NrOfElem then
    LastCol := FirstCol+DestVec.NrOfElem-1;
  DestVec.Fill(0);
  for i:=FirstCol to LastCol do
    DestVec.Elem[i-FirstCol+1] := GetVal (i, row);
  end;
end;


(*********************************************************)
procedure TIntMatrix.CopyColToVec (DestVec: TIntVector;
                       Col, FirstRow, LastRow: integer);
(*********************************************************
  ENTRY: DestVec ..... destination vector
         Col ......... column to be copied to vector
         FirstRow .... row of matrix column to become the first element
                       of DestVec
         LastRow ..... row of matrix column to become the last element
                       of DestVec
  EXIT:  DestVec contains data of specified matrix area. if the
         range does not fit into DestVec either some values of
         DestVec are set to zero, or some values of the matrix
         column are not copied to the vector
 *********************************************************)

var
  i : integer;

begin
if DestVec <> NIL then
  begin
  if FirstRow < 1 then
    FirstRow := 1;
  if LastRow < 1 then
    LastRow := 1;
  if FirstRow > FNRow then
    FirstRow := FNRow;
  if LastRow > FNRow then
    LastRow := FNRow;
  if Col < 1 then
    Col := 1;
  if Col > FNCol then
    Col := FNCol;
  if FirstRow > LastRow then
    ExChange (FirstRow,LastRow,sizeof(FirstRow));
  if LastRow-FirstRow+1 > DestVec.NrOfElem then
    LastRow := FirstRow+DestVec.NrOfElem-1;
  DestVec.Fill(0);
  for i:=FirstRow to LastRow do
    DestVec.Elem[i-FirstRow+1] := GetVal (col, i);
  end;
end;


(*********************************************************)
procedure TIntMatrix.Clone (MatSource: TIntMatrix);
(*********************************************************
  ENTRY: MatSource ... source matrix to be copied
  EXIT:  matrix self is clone of MatSource
 *********************************************************)

var
  i,j : integer;

begin
if MatSource <> NIL then
  begin
  if MatSource.FIsSparse = FIsSparse then  // cloning only works with same type
    begin
    if not FIsSparse
      then begin
           self.Resize (MatSource.NrOfColumns, MatSource.NrOfRows);
           for i:=1 to MatSource.NrOfColumns do
             for j:=1 to MatSource.NrOfRows do
               self.setval (i, j, MatSource.Getval (i,j));
           Changed;
           end
      else begin
           if SpMat <> NIL then
             FreeMem (SpMat, FNumAllocated*SizeOf(TSpMatElemInt));
           SpMat := NIL;
           FNumAllocated := MatSource.FNumAllocated;
           FAllocBy := MatSource.FAllocBy;
           GetMem (SpMat, FNumAllocated*SizeOf(TSpMatElemInt));
           FSparseNumElem  := MatSource.FSparseNumElem;
           FSparseLowCol   := MatSource.FSparseLowCol;
           FSparseHighCol  := MatSource.FSparseHighCol;
           FSparseLowRow   := MatSource.FSparseLowRow;
           FSparseHighRow  := MatSource.FSparseHighRow;
           for i:=1 to MatSource.FSparseNumElem do
             ArraySpI(SpMat^)[i] := ArraySpI(MatSource.SpMat^)[i];
           Changed;
           end;
    end;
  end;
end;


(*********************************************************)
procedure TIntMatrix.SparseToArray;
(*********************************************************)

var
  i,j     : integer;

begin
if FIsSparse then
  begin
  FIsSparse := false;
  FNCol := FSparseHighCol;
  FNRow := FSparseHighRow;
  GetMem (Mat, FNCol*FNRow*SizeOf(integer));
  if (Mat = NIL) then
    raise ESDLMatrixError.Create ('not enough memory on heap');
  for i:=1 to FNCol do
    for j:=1 to FNRow do
      Array1DI(Mat^)[(j-1)*FNCol+i] := 0;
  for i:=1 to FSparseNumElem do
    Array1DI(Mat^)[(ArraySpI(SpMat^)[i].rowidx-1)*FSparseHighCol+ArraySpI(SpMat^)[i].colidx] := ArraySpI(SpMat^)[i].value;
  FreeMem (SpMat, FNumAllocated*SizeOf(TSpMatElemInt));
  SpMat := NIL;
  FNumAllocated := 0;
  end;
end;


(*********************************************************)
procedure TIntMatrix.ArrayToSparse (AllocBy: longint);
(*********************************************************)

var
  i, j, k        : longint;
  NumAllocatedOld: longint;
  AuxMat         : pointer;


begin
if not FIsSparse then
  begin
  FIsSparse := True;
  FAllocBy := AllocBy;
  if FAllocBy < 1 then
    FAllocBy := 1;
  GetMem (SpMat, FAllocBy*SizeOf(TSpMatElemInt));
  FNumAllocated := FAllocBy;
  if (SpMat = NIL) then
    raise ESDLMatrixError.Create ('not enough memory on heap');
  FSparseNumElem := 0;
  FSparseLowCol := MaxLongInt;
  FSparseHighCol := 1;
  FSparseLowRow := MaxLongInt;
  FSparseHighRow := 1;
  for i:=1 to FNCol do
    for j:=1 to FNRow do
      begin
      if FSparseNumElem+1 > FNumAllocated then
        begin           // extend memory pool
        NumAllocatedOld := FNumAllocated;
        FNumAllocated := FNumAllocated + FAllocBy;
        GetMem (AuxMat, FNumAllocated*SizeOf(TSpMatElemInt));
        if AuxMat <> nil then
          begin
          for k:=1 to FSparseNumElem do  // copy existing matrix elements
            ArraySpI(AuxMat^)[k] := ArraySpI(SpMat^)[k];
          FreeMem (SpMat, NumAllocatedOld*SizeOf(TSpMatElemInt));
          SpMat := AuxMat;  // aux. mat is now maxtrix container
          end;
        end;
      if Array1DI(Mat^)[(j-1)*FNCol+i] <> 0 then
        begin
        inc (FSparseNumElem);     // add new data
        ArraySpI(SpMat^)[FSparseNumElem].colidx := i;
        ArraySpI(SpMat^)[FSparseNumElem].Rowidx := j;
        ArraySpI(SpMat^)[FSparseNumElem].value := Array1DI(Mat^)[(j-1)*FNCol+i];
        if i < FSparseLowCol then
          FSparseLowCol := i;
        if j < FSparseLowRow then
          FSparseLowRow := j;
        if i > FSparseHighCol then
          FSparseHighCol := i;
        if j > FSparseHighRow then
          FSparseHighRow := j;
        end;
      end;
  FreeMem (Mat, FNCol*FNRow*SizeOf(integer));
  Mat := NIL;
  end;
end;


(*********************************************************)
procedure TIntMatrix.CopyFrom (MatSource: TIntMatrix; SourceColLo,
                    SourceRowLo, SourceColHi, SourceRowHi,
                    DestCol, DestRow: integer);
(*********************************************************
  ENTRY: MatSource ... source matrix to be copied
         SourceColLo, SourceColHi ... range of columns in source matrix
         SourceRowLo, SourceRowHi ... range of rows in source matrix
  EXIT:  matrix Mat1 is copied to Mat2;
 *********************************************************)

var
  i,j : integer;

begin
if MatSource <> NIL then
  begin
  if SourceColLo < 1 then
    SourceColLo := 1;
  if SourceRowLo < 1 then
    SourceRowLo := 1;
  if SourceColLo > MatSource.NrOfColumns then
    SourceColLo := MatSource.NrOfColumns;
  if SourceRowLo > MatSource.NrOfRows then
    SourceRowLo := MatSource.NrOfRows;
  if SourceColHi < 1 then
    SourceColHi := 1;
  if SourceRowHi < 1 then
    SourceRowHi := 1;
  if SourceColHi > MatSource.NrOfColumns then
    SourceColHi := MatSource.NrOfColumns;
  if SourceRowHi > MatSource.NrOfRows then
    SourceRowHi := MatSource.NrOfRows;
  if SourceRowLo > SourceRowHi then
    ExChange (SourceRowLo,SourceRowHi,sizeof(SourceRowLo));
  if SourceColLo > SourceColHi then
    ExChange (SourceColLo,SourceColHi,sizeof(SourceColLo));
  for i:=SourceColLo to SourceColHi do
    for j:=SourceRowLo to SourceRowHi do
      self.setval (i-SourceColLo+DestCol,j-SourceRowLo+DestRow,
                   MatSource.Getval (i,j));
  Changed;
  end;
end;

(*********************************************************)
procedure TIntMatrix.Fill (value: integer);
(*********************************************************
  ENTRY: value ...... value to fill matrix with
  EXIT:  matrix is filled with 'value'
 *********************************************************)

var
  i,j   : integer;

begin
if FIsSparse
  then begin
       if (SpMat <> NIL) then
         begin
         if value = 0
           then begin
                FreeMem (SpMat, FNumAllocated*SizeOf(TSpMatElemInt));
                GetMem (SpMat, FAllocBy*SizeOf(TSpMatElemInt));
                FNumAllocated := FAllocBy;
                if (SpMat = NIL) then
                  raise ESDLMatrixError.Create ('not enough memory on heap');
                FSparseNumElem := 0;
                FSparseLowCol := MaxLongInt;
                FSparseHighCol := 1;
                FSparseLowRow := MaxLongInt;
                FSparseHighRow := 1;
                end
           else begin
                for i:=1 to FSparseNumElem do
                  ArraySpI(SpMat^)[i].Value := value;
                end;
         Changed;
         end;
       end
  else begin
       if (Mat <> NIL) then
         begin
         for i:=1 to FNCol do
           for j:=1 to FNRow do
             Array1DI(Mat^)[(j-1)*FNCol+i] := value;
         Changed;
         end;
       end;
end;

(******************************************************************)
function TIntMatrix.LoadFromFile (FileName: string; AdjustMatrixSize: boolean): boolean;
(******************************************************************
  ENTRY:    FileName ............ name of data file
            AdjustMatrixSize .... TRUE matrix is resized to fit the new data

  EXIT:     function return ..... TRUE if data loaded successfully
 ******************************************************************)

var
  TFile      : text;
  i,j        : integer;
  reslt      : boolean;
  LoC, HiC   : integer;
  LoR, HiR   : integer;
  idummy     : integer;

begin
reslt := False;
assign (TFile, Filename);
{$I-} reset (TFile); {$I+}
if IoResult = 0 then
  begin
  read (TFile,LoR,HiR);
  read (TFile,LoC,HiC);
  if AdjustMatrixSize then
    Resize (HiC, HiR);
  if ((HiR <= NrOfRows) and (HiC <= NrOfColumns)) then
    begin
    reslt := True;
    for i:=LoR to HiR do
      for j:=LoC to HiC do
        begin
        {$I-} read (TFile, idummy); {$I+}
        if IOResult = 0 then
          SetVal (j,i,idummy);
        end;
    end;
  close (TFile);
  Changed;
  end;
LoadFromFile := reslt;
end;


(******************************************************************)
(*SPARSE*)
function TIntMatrix.LoadFromStream (InStream: TMemoryStream; AdjustMatrixSize: boolean): boolean;
(******************************************************************
  ENTRY:    InStream ............ stream holding the data to be read in binary format
            AdjustMatrixSize .... TRUE matrix is resized to fit the new data

  EXIT:     matrix is set accordingly
            function returns TRUE is matrix elements are read successfully
 ******************************************************************)

var
  i,j        : integer;
  LoC, HiC   : integer;
  LoR, HiR   : integer;
  intdummy   : integer;
  reslt      : boolean;
  eos        : boolean;

begin
reslt := false;
if InStream <> nil then
  begin
  LoC := 0;
  HiC := 0;
  HiR := 0;
  LoR := round(ReadLongintFromStream (InStream, eos));
  if not eos then
    HiR := round(ReadLongintFromStream (InStream, eos));
  if not eos then
    LoC := round(ReadLongintFromStream (InStream, eos));
  if not eos then
    HiC := round(ReadLongintFromStream (InStream, eos));
  if not eos then
    begin
    if AdjustMatrixSize then
      Resize (HiC, HiR);
    if ((HiR <= NrOfRows) and (HiC <= NrOfColumns)) then
      begin
      reslt := True;
      for i:=LoR to HiR do
        for j:=LoC to HiC do
          begin
          intdummy := ReadLongintFromStream (Instream, eos);
          if not eos
            then SetVal (j,i, intdummy)
            else reslt := false;
          end;
      end;
    Changed;
    end;
  end;
LoadFromStream := reslt;
end;




(******************************************************************)
(*SPARSE*)
function TIntMatrix.StoreOnFile (LoC,LoR,HiC,HiR: integer;
                          FileName:string): boolean;
(******************************************************************
  ENTRY:    LoR, LoC, HiR, HiC .... indices of table area to store
            FileName .............. name of data file

  EXIT:     function return ....... TRUE if storage successfull
            values are store in an ASCII file according to the
            following format:
                1. line:  NrRows, first Row, last Row
                2. line:  NrColumns, first Column, last Column
                from 3. line: each line holds on row of table, values
                              are separated with blanks
 ******************************************************************)

var
  TFile  : text;
  i,j    : integer;
  reslt  : boolean;

begin
reslt := false;
if LoC < 1 then
  LoC := 1;
if HiC > NrOfColumns then
  HiC := NrOfColumns;
if HiC < LoC then
  ExChange (HiC,LoC,sizeof(HiC));
if LoR < 1 then
  LoR := 1;
if HiR > NrOfRows then
  HiR := NrOfRows;
if HiR < LoR then
  ExChange (HiR,LoR,sizeof(HiR));
assign (TFile, FIlename);
{$I-} rewrite (TFile); {$I+}
if IoResult = 0 then
  begin
  reslt := True;
  writeln (TFile,LoR,' ',HiR);
  writeln (TFile,LoC,' ',HiC);
  for i:=LoR to HiR do
    begin
    for j:=LoC to HiC do
      write (TFile, GetVal (j,i), ' ');
    writeln (TFile);
    end;
  close (TFile);
  end;
StoreOnFile := reslt;
end;


(******************************************************************)
function TIntMatrix.StoreSparseMat (FileName:string): boolean;
(******************************************************************
  ENTRY:    FileName .............. name of data file

  EXIT:     function return ....... TRUE if storage successfull
            values are stored in an ASCII file according to the
            following format:
 ******************************************************************)

var
  TFile  : text;
  i      : integer;
  reslt  : boolean;

begin
reslt := false;
assign (TFile, FIlename);
{$I-} rewrite (TFile); {$I+}
if IoResult = 0 then
  begin
  if not FIsSparse
    then writeln (TFile, 'this matrix is not a sparse matrix')
    else begin
         reslt := True;
         writeln (TFile, 'SDL_sparse_matrix');
         writeln (TFile,FSparseNumElem:6, '     // number of elements in sparse matrix');
         writeln (TFile,FSparseLowCol:6, ' ', FSparseHighCol:6, '   // lowest and highest column');
         writeln (TFile,FSparseLowRow:6, ' ', FSparseHighRow:6, '   // lowest and highest row');
         for i:=1 to FSparseNumElem do
           writeln (TFile, '[',ArraySpI(SpMat^)[i].colidx, ',', ArraySpI(SpMat^)[i].rowidx, ']=', ArraySpI(SpMat^)[i].Value);
         end;
  close (TFile);
  end;
StoreSparseMat := reslt;
end;


(******************************************************************)
function  TIntMatrix.LoadSparseMat (FileName:string): boolean;
(******************************************************************
  ENTRY:    FileName ..... Name of file to be read

  EXIT:     function returns TRUE if data have been read successfully
 ******************************************************************)

var
  TFile  : text;
  astr   : string;
  idx    : integer;
  numElem: longint;
  value  : longint;
  ix, iy : longint;
  error  : boolean;

begin
result := false;
assign (TFile, Filename);
{$I-} reset (TFile); {$I+}
if IoResult = 0 then
  begin
  readln (TFile, astr);
  if pos('sdl_sparse_matrix', lowercase(astr)) > 0 then
    begin
    readln (TFile, astr);
    idx := 1;
    NumElem := ScanDecimal (astr, idx);
    error := false;
    if NumElem > 0 then
      begin
      readln (TFile, astr);  // dummy read for array index limits
      readln (TFile, astr);
      while not eof (TFile) do
        begin
        readln (TFile, astr);
        dec (NumElem);
        idx := pos ('=', astr);
        if idx > 0
          then begin
               inc(idx);
               value := ScanDecimal (astr, idx);
               idx := 2;
               ix := ScanDecimal (astr, idx);
               inc(idx);
               iy := ScanDecimal (astr, idx);
               SetVal (ix, iy, value);
               end
          else error := true;
        end;
      end;
    if (NumElem = 0) and not error then
      result := true;
    end;
  close (TFile);
  end;
LoadSparseMat := result;
end;



(******************************************************************)
(*SPARSE*)
procedure TIntMatrix.SaveToStream (var OutStream: TMemoryStream;
                       LoC,LoR,HiC,HiR: integer);
(******************************************************************
  ENTRY:    OutStream ............. stream where matrix is stored
                                    if OutStream = nil, a new stream object is created
            LoR, LoC, HiR, HiC .... indices of table area to store
            FileName .............. name of data file

  EXIT:     selected matrix elements are stored in OutStream
            values are saved in binary format (integer):
                1. first Row
                2. last Row
                3. first Column
                4. last Column
                from 5th item : matrix elements row-wise
 ******************************************************************)

var
  i,j    : integer;

begin
if LoC < 1 then
  LoC := 1;
if HiC > NrOfColumns then
  HiC := NrOfColumns;
if HiC < LoC then
  ExChange (HiC,LoC,sizeof(HiC));
if LoR < 1 then
  LoR := 1;
if HiR > NrOfRows then
  HiR := NrOfRows;
if HiR < LoR then
  ExChange (HiR,LoR,sizeof(HiR));
if OutStream = nil then
  OutStream := TMemoryStream.Create;
WriteLongintToStream (OutStream, LoR);
WriteLongintToStream (OutStream, HiR);
WriteLongintToStream (OutStream, LoC);
WriteLongintToStream (OutStream, HiC);
for i:=LoR to HiR do
  begin
  for j:=LoC to HiC do
    WriteLongintToStream (OutStream, GetVal (j,i));
  end;
end;



(*********************************************************)
function TIntMatrix.Sum (LoC,LoR,HiC,HiR: integer): longint;
(*********************************************************
  ENTRY: LoC, LoR ....... indices of element in matrix
                          where to start search
         HiC, HiR ....... indices of element in matrix
                          where to stop search
  EXIT:  function returns sum of elements in specified range
 *********************************************************)

var
  i,j     : integer;
  total   : longint;

begin
total := 0;
if FIsSparse
  then begin
       if LoR > HiR then
         ExChange (LoR, HiR, sizeof(LoR));
       if LoC > HiC then
         ExChange (LoC, HiC, sizeof(LoC));
       for i:=1 to FSparseNumElem do
         begin
         if (ArraySpI(SpMat^)[i].colidx >= LoC) and
            (ArraySpI(SpMat^)[i].colidx <= HiC) and
            (ArraySpI(SpMat^)[i].rowidx >= LoR) and
            (ArraySpI(SpMat^)[i].rowidx <= HiR) then
           total := total + ArraySpI(SpMat^)[i].Value;
         end;
       end
  else begin
       if (Mat <> NIL) then
         begin
         if LoC < 1 then
           LoC := 1;
         if LoC > FNCol then
           LoC := FNCol;
         if LoR < 1 then
           LoR := 1;
         if LoR > FNRow then
           LoR := FNRow ;
         if HiC < 1 then
           HiC := 1;
         if HiC > FNCol then
           HiC := FNCol;
         if HiR < 1 then
           HiR := 1;
         if HiR > FNRow then
           HiR := FNRow;
         if LoR > HiR then
           ExChange (LoR, HiR, sizeof(LoR));
         if LoC > HiC then
           ExChange (LoC, HiC, sizeof(LoC));
         for i:=LoC to HiC do
           for j:=LoR to HiR do
             total := total + Array1DI(Mat^)[(j-1)*FNCol+i];
         end;
       end;
sum := total;
end;


(*********************************************************)
function TIntMatrix.Trace: longint;
(*********************************************************
  ENTRY: quadratic matrix

  EXIT:  function returns trace of elements in specified range
         if matrix not quadratic, a value of zero is returned
 *********************************************************)

var
  i       : integer;
  total   : longint;

begin
total := 0;
if FIsSparse
  then begin
       if FSparseHighRow = FSparseHighCol then
         for i:=1 to FSparseNumElem do
           begin
           if (ArraySpI(SpMat^)[i].colidx = ArraySpI(SpMat^)[i].rowidx) then
             total := total + ArraySpI(SpMat^)[i].Value;
           end;
       end
  else begin
       if (FNCol = FNRow ) then
         begin
         for i:=1 to FNCol do
           total := total + Array1DI(Mat^)[(i-1)*FNCol+i];
         end;
       end;
trace := total;
end;



(*********************************************************)
procedure TIntMatrix.MeanVar
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Mean, Variance: double);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  Mean, Variance .... mean and variance of indicated
                             region
 *********************************************************)

var
  i,j     : integer;
  value   : double;
  NumData : integer;
  sum     : double;
  Sumq    : double;

begin
if (Mat <> NIL) or (SpMat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  NumData := 0;
  sum := 0.0;
  sumq := 0.0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      if FIsSparse
        then value := GetVal(i,j)
        else value := Array1DI(Mat^)[(j-1)*FNCol+i];
      sum := sum + value;
      sumq := sumq + sqr(value);
      inc (NumData);
      end;
  Mean := sum / NumData;
  Variance := 1.0;
  if NumData >= 3 then
    Variance := (sumq-sqr(sum)/NumData)/(NumData-1);
  end;
end;


(*********************************************************)
function TIntMatrix.GeometricMean (LowCol, LowRow, HighCol,
             HighRow: integer): double;
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  function returns geometric mean
         if any argument is negative, an exception is raised
 *********************************************************)

var
  i,j       : integer;
  value     : double;
  sum       : double;
  ZeroFound : boolean;

begin
result := 0;
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  sum := 0.0;
  ZeroFound := false;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1DI(Mat^)[(j-1)*FNCol+i];
      if value < 0
        then raise ESDLMatrixError.Create ('negative argument passed to GeometricMean')
        else begin
             if value = 0
               then ZeroFound := true
               else sum := sum + ln(value);
             end
      end;
  if ZeroFound
    then result := 0
    else result := exp(sum/(HighRow-LowRow+1)/(HighCol-LowCol+1));
  end;
end;


(*********************************************************)
function TIntMatrix.HarmonicMean (LowCol, LowRow, HighCol,
             HighRow: integer): double;
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  function returns harmonic mean
         if any argument is negative or zero, an exception is raised
 *********************************************************)

var
  i,j       : integer;
  value     : double;
  sum       : double;

begin
result := 0;
if (Mat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  sum := 0.0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      value := Array1DI(Mat^)[(j-1)*FNCol+i];
      if value <= 0
        then raise ESDLMatrixError.Create ('negative or zero argument passed to HarmonicMean')
        else begin
             sum := sum + 1/value;
             end
      end;
  result := 1.0*(HighRow-LowRow+1)*(HighCol-LowCol+1)/sum;
  end;
end;



(*********************************************************)
procedure TIntMatrix.SkewKurtIntern
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Skewness, Kurtosis: double; var NumData: longint);
(*********************************************************
  ENTRY: LowCol, LowRow ...... indices of element in matrix
                               where to start search
         HighCol, HighRow .... indices of element in matrix
                               where to stop search
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
         NumData ............. number of data involved
 *********************************************************)

var
  i,j     : integer;
  value   : double;
  sum     : double;
  sumq    : double;
  Mean    : double;
  pot     : double;
  stddev  : double;

begin
SkewNess := 0;
Kurtosis := 0;
if (Mat <> NIL) or (SpMat <> NIL) then
  begin
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  NumData := 0;
  sum := 0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      if FIsSparse
        then sum := sum + GetVal (i,j)
        else sum := sum + Array1DI(Mat^)[(j-1)*FNCol+i];
      inc (NumData);
      end;
  Mean := sum / NumData;
  sumq := 0;
  sum := 0;
  for i:=LowCol to HighCol do
    for j:=LowRow to HighRow do
      begin
      if FIsSparse
        then value := GetVal (i,j)-mean
        else value := Array1DI(Mat^)[(j-1)*FNCol+i]-mean;
      sum := sum + value;
      pot := sqr(value);
      sumq := sumq + pot;
      pot := pot*value;
      SkewNess := SkewNess+pot;
      pot := pot*value;
      Kurtosis := Kurtosis+pot;
      end;
  if (NumData > 1) then
    begin
    stddev := sqrt((sumq-sqr(sum)/NumData)/(NumData-1));
    if stddev <> 0 then
      begin
      SkewNess := Skewness/NumData/stddev/stddev/stddev;
      Kurtosis := Kurtosis/NumData/sqr(sqr(stddev))-3;
      end;
    end;
  end;
end;


(*********************************************************)
procedure TIntMatrix.SkewKurt
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowCol, LowRow ...... indices of element in matrix
                               where to start search
         HighCol, HighRow .... indices of element in matrix
                               where to stop search
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  nd : longint;

begin
SkewKurtIntern (LowCol, LowRow, HighCol, HighRow, Skewness, Kurtosis, nd);
end;


(*********************************************************)
procedure TIntMatrix.SkewKurtSample
              (LowCol, LowRow, HighCol, HighRow: integer;
               var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowCol, LowRow ...... indices of element in matrix
                               where to start search
         HighCol, HighRow .... indices of element in matrix
                               where to stop search
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  NumData : integer;

begin
SkewKurtIntern (LowCol, LowRow, HighCol, HighRow, Skewness, Kurtosis, NumData);
if NumData > 3
  then begin
       Kurtosis := (Kurtosis+3)*NumData*NumData*(NumData+1)/(NumData-1)/(NumData-2)/(NumData-3)
             -3*sqr(NumData-1)/(NumData-2)/(NumData-3);
       Skewness := Skewness*NumData*NumData/(NumData-1)/(NumData-2);
       end
  else begin
       Kurtosis := 0;
       Skewness := 0;
       end;
end;



(*********************************************************)
(*SPARSE*)
function TIntMatrix.Quartiles (LowCol, LowRow, HighCol, HighRow: integer;
                               var Q1, Q2, Q3: double): boolean;
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start calculation
         HighCol, HighRow .. indices of element in matrix
                             where to stop calculation
  EXIT:  Q1, Q2, Q3 ........ quartiles of distribution
 *********************************************************)

type
  iarrtype = array [1..1] of integer;

var
  srtarray  : pointer;
  i,j       : integer;
  LengArray : longint;
  ix        : integer;
  dx        : double;
  reslt     : boolean;

begin
Q1 := 0;
Q2 := 0;
Q3 := 0;
reslt := false;
if (Mat <> NIL) then
  begin
  reslt := true;
  if LowCol < 1 then
    LowCol := 1;
  if LowCol > FNCol then
    LowCol := FNCol;
  if LowRow < 1 then
    LowRow := 1;
  if LowRow > FNRow then
    LowRow := FNRow ;
  if HighCol < 1 then
    HighCol := 1;
  if HighCol > FNCol then
    HighCol := FNCol;
  if HighRow < 1 then
    HighRow := 1;
  if HighRow > FNRow then
    HighRow := FNRow;
  if LowRow > HighRow then
    ExChange (LowRow, HighRow, sizeof(LowRow));
  if LowCol > HighCol then
    ExChange (LowCol, HighCol, sizeof(LowCol));
  LengArray := (HighRow-LowRow+1)*(HighCol-LowCol+1);
  Getmem (srtarray, LengArray*sizeof(integer));
  if srtArray = NIL
    then reslt := false
    else begin
         for i:=LowCol to HighCol do
           begin
           for j:=LowRow to HighRow do
             iarrType(SrtArray^)[1+i-LowCol+(j-LowRow)*(HighCol-LowCol+1)] := Array1DI(Mat^)[(j-1)*FNCol+i];
           end;
         SortArray (SrtArray, LengArray, dnum, true);
         if LengArray > 1
           then begin
                ix := 1 + (LengArray-1) div 4;
                dx := (iarrType(SrtArray^)[1+ix]-(iarrType(SrtArray^)[ix]))/4;
                Q1 := (iarrType(SrtArray^)[ix])+((LengArray-1) mod 4)*dx;
                ix := 1 + 2*(LengArray-1) div 4;
                dx := (iarrType(SrtArray^)[1+ix]-(iarrType(SrtArray^)[ix]))/4;
                Q2 := (iarrType(SrtArray^)[ix])+(2*(LengArray-1) mod 4)*dx;
                ix := 1 + 3*(LengArray-1) div 4;
                dx := (iarrType(SrtArray^)[1+ix]-(iarrType(SrtArray^)[ix]))/4;
                Q3 := (iarrType(SrtArray^)[ix])+(3*(LengArray-1) mod 4)*dx;
                end
           else begin
                Q1 := iarrType(SrtArray^)[1];
                Q2 := iarrType(SrtArray^)[1];
                Q3 := iarrType(SrtArray^)[1];
                end;
         Freemem (srtarray, LengArray*sizeof(integer));
         end;
  end;
Quartiles := reslt;
end;



(*********************************************************)
procedure TIntMatrix.MinMax
                  (LowCol, LowRow, HighCol, HighRow: integer;
                  var Minimum, Maximum: longint);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
  EXIT:  Minimum, Maximum .. minimum and maximum value in
                             searched area
 *********************************************************)

var
  i,j   : integer;
  value : integer;

begin
Minimum := MaxLongInt;
Maximum := -MaxLongInt;
if FIsSparse
  then begin
       if LowRow > HighRow then
         ExChange (LowRow, HighRow, sizeof(LowRow));
       if LowCol > HighCol then
         ExChange (LowCol, HighCol, sizeof(LowCol));
       for i:=1 to FSparseNumElem do
         begin
         if (ArraySpI(SpMat^)[i].colidx >= LowCol) and
            (ArraySpI(SpMat^)[i].colidx <= HighCol) and
            (ArraySpI(SpMat^)[i].rowidx >= LowRow) and
            (ArraySpI(SpMat^)[i].rowidx <= HighRow) then
           begin
           value := ArraySpI(SpMat^)[i].Value;
           if value < Minimum then
             Minimum := value;
           if value > Maximum then
             Maximum := value;
           end;
         end;
       end
  else begin
       if (Mat <> NIL) then
         begin
         if LowCol < 1 then
           LowCol := 1;
         if LowCol > FNCol then
           LowCol := FNCol;
         if LowRow < 1 then
           LowRow := 1;
         if LowRow > FNRow then
           LowRow := FNRow ;
         if HighCol < 1 then
           HighCol := 1;
         if HighCol > FNCol then
           HighCol := FNCol;
         if HighRow < 1 then
           HighRow := 1;
         if HighRow > FNRow then
           HighRow := FNRow;
         if LowRow > HighRow then
           ExChange (LowRow, HighRow, sizeof(LowRow));
         if LowCol > HighCol then
           ExChange (LowCol, HighCol, sizeof(LowCol));
         for i:=LowCol to HighCol do
           for j:=LowRow to HighRow do
             begin
             value := Array1DI(Mat^)[(j-1)*FNCol+i];
             if value < Minimum then
               Minimum := value;
             if value > Maximum then
               Maximum := value;
             end;
         end;
       end;
end;


(*********************************************************)
(*SPARSE*)
function TIntMatrix.Add (MatB: TIntMatrix): boolean;
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         MatB .......... Matrix B (Dimension N x M)
  EXIT:  self .......... has added matrix B
         function returns TRUE if result is ok
 *********************************************************)

var
  i,j     : integer;
  reslt   : boolean;
  r,c     : longint;

begin
reslt := false;
if (MatB <> NIL) then
  if FIsSparse
    then begin
         if MatB.FIsSparse
           then begin
                end
           else begin
                end;
         end
    else begin
         if MatB.FIsSparse
           then begin
                if (FNCol >= MatB.FSparseHighCol) and (FNRow >= MatB.FSParseHighRow) then
                  begin
                  reslt := true;
                  for i:=1 to MatB.FSparseNumElem do
                    begin
                    r := ArraySpI(SpMat^)[i].rowidx;
                    c := ArraySpI(SpMat^)[i].colidx;
                    Array1DI(Mat^)[(r-1)*FNCol+c] := Array1DI(Mat^)[(r-1)*FNCol+c] + ArraySpI(SpMat^)[i].value;
                    end;
                  Changed;
                  end;
                end
           else begin
                if (FNCol = MatB.NrOfColumns) and (FNRow = MatB.NrOfRows) then
                  begin
                  reslt := true;
                  for i:=1 to FNRow do
                    for j:=1 to FNCol do
                      begin
                      Array1DI(Mat^)[(i-1)*FNCol+j] := Array1DI(Mat^)[(i-1)*FNCol+j] +
                                                       Array1DI(MatB.Mat^)[(i-1)*MatB.FNCol+j];
                      end;
                  Changed;
                  end;
                end;
         end;
Add := reslt;
end;

(*********************************************************)
(*SPARSE*)
function TIntMatrix.Subtract (MatB: TIntMatrix): boolean;
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         MatB .......... Matrix B (Dimension N x M)
  EXIT:  self .......... = Matrix A - Matrix B
         function returns TRUE if result is ok
 *********************************************************)

var
  i,j     : integer;
  reslt   : boolean;

begin
reslt := false;
if (MatB <> NIL) then
  if (FNCol = MatB.NrOfColumns) and (FNRow = MatB.NrOfRows) then
    begin
    reslt := true;
    for i:=1 to FNRow do
      for j:=1 to FNCol do
        begin
        Array1DI(Mat^)[(i-1)*FNCol+j] := Array1DI(Mat^)[(i-1)*FNCol+j] -
                                        Array1DI(MatB.Mat^)[(i-1)*MatB.FNCol+j];
        end;
    Changed;
    end;
Subtract := reslt;
end;


(*********************************************************)
(*SPARSE*)
procedure TIntMatrix.SMult (Scalar: integer);
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         Scalar ........ scalar number
  EXIT:  self .......... = Matrix A * Scalar
 *********************************************************)

var
  i,j     : integer;

begin
for i:=1 to FNRow do
  for j:=1 to FNCol do
    begin
    Array1DI(Mat^)[(i-1)*FNCol+j] := Array1DI(Mat^)[(i-1)*FNCol+j] * Scalar;
    end;
Changed;
end;




(*********************************************************)
(*SPARSE*)
function TIntMatrix.Multiply (MatB, MatRes: TIntMatrix): boolean;
(*********************************************************
  ENTRY: self .......... Matrix A (Dimension N x M)
         MatB .......... Matrix B (Dimension M x P)
  EXIT:  MatRes ........ resulting matrix (Dimension N x P)
         function returns TRUE if result is ok
 *********************************************************)

var
  i,j,k   : integer;
  reslt   : boolean;
  sum     : longint;

begin
reslt := false;
if ((MatB <> NIL) and (MatRes <> NIL)) then
  if (FNCol = MatB.NrOfRows) and
     (MatRes.NrOfColumns = MatB.NrOfColumns) and
     (MatRes.NrOfRows = FNRow) then
    begin
    reslt := true;
    for i:=1 to FNRow do
      begin
      for j:=1 to MatB.NrOfColumns do
        begin
        sum := 0;
        for k:=1 to FNCol do
          sum := sum + Array1DI(Mat^)[(i-1)*FNCol+k]*
                       Array1DI(MatB.Mat^)[(k-1)*MatB.FNCol+j];
        MatRes.SetVal (j,i,sum);
        end;
      end;
    Changed;
    end;
Multiply := reslt;
end;

(*********************************************************)
(*SPARSE*)
procedure TIntMatrix.SortRows (SortColIx: integer; Ascending: boolean;
                      LowCol, LowRow, HighCol, HighRow: integer);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
         SortColIx ......... index of column to be taken as
                             sorting criterion
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)

  EXIT:  array sorted according to column 'SortColIx' within
         range (LowCol..HighRow). Column 'SortColIx' is sorted
         too, regardless wheter 'SortRowIx' lies within range
         (LowCol..HighCol) or not.

  REMARK: algorithm used for sorting: modified bubble sort
 *********************************************************)


const
  ShrinkFac = 1.3;

var
  JumpWidth : word;
  ix        : integer;
  exchngd   : boolean;
  idummy    : integer;
  i         : integer;


begin
if HighRow < LowRow then
  Exchange (HighRow, LowRow, sizeof (Highrow));
if HighCol < LowCol then
  Exchange (HighCol, LowCol, sizeof (HighCol));
if LowRow < 1 then
  LowRow := 1;
if LowRow > FNRow then
  LowRow := FNRow;
if HighRow < 1 then
  HighRow := 1;
if HighRow > FNRow then
  HighRow := FNRow;
JumpWidth := HighRow-LowRow;
if JumpWidth > 0 then
  begin
  if Ascending
    then begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowRow;
           exchngd := False;
           repeat
             if Array1DI(Mat^)[(ix-1)*FNCol+SortColIx] > Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] then
               begin
               for i:=LowCol to HighCol do
                 begin
                 idummy := Array1DI(Mat^)[(ix-1)*FNCol+i];
                 Array1DI(Mat^)[(ix-1)*FNCol+i] := Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+i];
                 Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+i] := idummy;
                 exchngd := True;
                 end;
               if (SortColIx < LowCol) or (SortColIx > HighCol) then
                 begin
                 idummy := Array1DI(Mat^)[(ix-1)*FNCol+SortColIx];
                 Array1DI(Mat^)[(ix-1)*FNCol+SortColIx] := Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx];
                 Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] := idummy;
                 end;
               SortExchange (2, ix, ix+jumpWidth, LowCol, HighCol);
               end;
             inc (ix);
           until (ix+JumpWidth > HighRow);
         until ((JumpWidth = 1) and not exchngd);
         end
    else begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowRow;
           exchngd := False;
           repeat
             if Array1DI(Mat^)[(ix-1)*FNCol+SortColIx] < Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] then
               begin
               for i:=LowCol to HighCol do
                 begin
                 idummy := Array1DI(Mat^)[(ix-1)*FNCol+i];
                 Array1DI(Mat^)[(ix-1)*FNCol+i] := Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+i];
                 Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+i] := idummy;
                 exchngd := True;
                 end;
               if (SortColIx < LowCol) or (SortColIx > HighCol) then
                 begin
                 idummy := Array1DI(Mat^)[(ix-1)*FNCol+SortColIx];
                 Array1DI(Mat^)[(ix-1)*FNCol+SortColIx] := Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx];
                 Array1DI(Mat^)[(ix+JumpWidth-1)*FNCol+SortColIx] := idummy;
                 end;
               SortExchange (2, ix, ix+jumpWidth, LowCol, HighCol);
               end;
             inc (ix);
           until (ix+JumpWidth > HighRow);
         until ((JumpWidth = 1) and not exchngd);
         end;
  Changed;
  end;
end;


(*********************************************************)
(*SPARSE*)
procedure TIntMatrix.SortCols (SortRowIx: integer; Ascending: boolean;
                      LowCol, LowRow, HighCol, HighRow: integer);
(*********************************************************
  ENTRY: LowCol, LowRow .... indices of element in matrix
                             where to start search
         HighCol, HighRow .. indices of element in matrix
                             where to stop search
         SortRowIx ......... index of row to be taken as
                             sorting criterion
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)

  EXIT:  array sorted according to row 'SortRowIx' within
         range (LowCol..HighRow). Row 'SortRowIx' is sorted
         too, regardless wheter 'SortRowIx' lies within range
         (LowRow..HighRow) or not.

  REMARK: algorithm used for sorting: modified bubble sort
 *********************************************************)


const
  ShrinkFac = 1.3;

var
  JumpWidth : word;
  ix        : integer;
  exchngd   : boolean;
  idummy    : integer;
  i         : integer;


begin
if HighRow < LowRow then
  Exchange (HighRow, LowRow, sizeof (Highrow));
if HighCol < LowCol then
  Exchange (HighCol, LowCol, sizeof (HighCol));
if LowRow < 1 then
  LowRow := 1;
if LowRow > FNRow then
  LowRow := FNRow;
if HighRow < 1 then
  HighRow := 1;
if HighRow > FNRow then
  HighRow := FNRow;
JumpWidth := HighCol-LowCol;
if JumpWidth > 0 then
  begin
  if Ascending
    then begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowCol;
           exchngd := False;
           repeat
             if Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix] > Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] then
               begin
               for i:=LowRow to HighRow do
                 begin
                 idummy := Array1DI(Mat^)[(i-1)*FNCol+ix];
                 Array1DI(Mat^)[(i-1)*FNCol+ix] := Array1DI(Mat^)[(i-1)*FNCol+ix+JumpWidth];
                 Array1DI(Mat^)[(i-1)*FNCol+ix+JumpWidth] := idummy;
                 exchngd := True;
                 end;
               if (SortRowIx < LowRow) or (SortRowIx > HighRow) then
                 begin
                 idummy := Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix];
                 Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix] := Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth];
                 Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] := idummy;
                 end;
               SortExchange (1, ix, ix+jumpWidth, LowRow, HighRow);
               end;
             inc (ix);
           until (ix+JumpWidth > HighCol);
         until ((JumpWidth = 1) and not exchngd);
         end
    else begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := LowCol;
           exchngd := False;
           repeat
             if Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix] < Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] then
               begin
               for i:=LowRow to HighRow do
                 begin
                 idummy := Array1DI(Mat^)[(i-1)*FNCol+ix];
                 Array1DI(Mat^)[(i-1)*FNCol+ix] := Array1DI(Mat^)[(i-1)*FNCol+ix+JumpWidth];
                 Array1DI(Mat^)[(i-1)*FNCol+ix+JumpWidth] := idummy;
                 exchngd := True;
                 end;
               if (SortRowIx < LowRow) or (SortRowIx > HighRow) then
                 begin
                 idummy := Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix];
                 Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix] := Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth];
                 Array1DI(Mat^)[(SortRowix-1)*FNCol+Ix+JumpWidth] := idummy;
                 end;
               SortExchange (1, ix, ix+jumpWidth, LowRow, HighRow);
               end;
             inc (ix);
           until (ix+JumpWidth > HighCol);
         until ((JumpWidth = 1) and not exchngd);
         end;
  Changed;
  end;
end;



(*********************************************************)
constructor TMat3D.Create (Nc, Nr, Nl: longint);
(*********************************************************)

var
  i,j,k : integer;

begin
inherited Create;
if (nc <= 0) or (nr <= 0) or (nl <= 0) then
  raise ESDLMatrixError.Create ('array dimensions zero or negative');
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
FNumX := Nc;
FNumY := Nr;
FNumZ := Nl;
{$IFDEF VER80}      { restrict only in 16-Bit version }
if longint(Nc)*longint(Nr)*longint(Nl)*SizeOf(double) > 65500
  then raise ESDLMatrixError.Create ('matrix too large')
  else begin
       GetMem (Mat, FNumX*FNumY*FNumZ*SizeOf(double));
       if (Mat = NIL) then
         raise ESDLMatrixError.Create ('not enough memory on heap');
       end;
{$ELSE}
GetMem (Mat, FNumX*FNumY*FNumZ*SizeOf(double));
if (Mat = NIL) then
  raise ESDLMatrixError.Create ('not enough memory on heap');
{$ENDIF}
for i:=1 to FNumX do
  for j:=1 to FNumY do
    for k:=1 to FNumZ do
      Array1D(Mat^)[((j-1)*FNumX+i-1)*FNumZ+k] := 0;
end;


(*********************************************************)
destructor TMat3D.Destroy;
(*********************************************************)

begin
if Mat <> NIL then
  FreeMem (Mat, FNumX*FNumY*FNumZ*SizeOf(double));
Mat := NIL;
inherited Destroy;
end;

(***********************************************************************)
procedure TMat3D.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;



(*********************************************************)
function TMat3D.GetVal (Nx,Ny,Nz: longint): double;
(*********************************************************)

begin
if (Mat <> NIL) and
   (Nx >= 1) and (Nx <= FNumX) and
   (Ny >= 1) and (Ny <= FNumY) and
   (Nz >= 1) and (Nz <= FNumZ)
  then GetVal := Array1D(Mat^)[((Ny-1)*FNumX+Nx-1)*FNumZ+Nz]
  else GetVal := 0;
end;

(*********************************************************)
procedure TMat3D.SetVal (Nx,Ny,Nz: longint; Value: double);
(*********************************************************)

begin
if (Mat <> NIL) and
   (Nx >= 1) and (Nx <= FNumX) and
   (Ny >= 1) and (Ny <= FNumY) and
   (Nz >= 1) and (Nz <= FNumZ)
  then Array1D(Mat^)[((Ny-1)*FNumX+Nx-1)*FNumZ+Nz] := value
end;


(*********************************************************)
procedure TMat3D.Fill (value: double);
(*********************************************************
  ENTRY: value ...... value to fill matrix with
  EXIT:  matrix is filled with 'value'
 *********************************************************)

var
  i,j,k   : word;

begin
if (Mat <> NIL) then
  begin
  for i:=1 to FNumX do
    for j:=1 to FNumY do
      for k:=1 to FNumZ do
        Array1D(Mat^)[((j-1)*FNumX+i-1)*FNumZ+k] := value;
  end;
end;

(*********************************************************)
function TMat3D.Resize (Nc, Nr, Nl: longint): boolean;
(*********************************************************
  ENTRY:  Nc, Nr, Nl .... number of columns, rows, and layers

  EXIT:   function returns TRUE if resizing has been completed
          successfully.  Data are not destroyed, if possible;
          new cells are filled with zero values.
 *********************************************************)

var
  reslt   : boolean;
  OldCol  : longint;
  OldRow  : longint;
  OldLay  : longint;
  MinCol  : integer;
  MinRow  : integer;
  MinLay  : integer;
  AuxMat  : pointer;
  i,j,k   : integer;

begin
reslt := true;
if (nc <> FNumX) or (nr <> FNumY) or (nl <> FNumZ) then
  begin
  reslt := FALSE;
  {$IFDEF VER80}                  { restrict only in 16-Bit version }
  if longint(nc)*longint(nr)*longint(nl)*SizeOf(double) > 65500
    then raise ESDLMatrixError.Create ('matrix too large')
    else
  {$ENDIF}
         begin
         if (nc > 0) and (nr > 0) and (nl > 0) then
           begin
           OldCol := FNumX;
           OldRow := FNumY;
           OldLay := FNumZ;
           GetMem (AuxMat, OldCol*Oldrow*OldLay*SizeOf(double));
           if (AuxMat <> NIL) then
             begin
             for i:=1 to OldCol do    (* copy existing data into auxiliary matrix *)
               for j:=1 to OldRow do
                 for k:=1 to OldLay do
                   Array1D(AuxMat^)[((j-1)*FNumX+i-1)*FNumZ+k] := Array1D(Mat^)[((j-1)*FNumX+i-1)*FNumZ+k];
             FreeMem (Mat, OldCol*OldRow*OldLay*SizeOf(double));  (* dispose and setup new matrix *)
             GetMem (Mat, Nc*Nr*Nl*SizeOf(double));
             if Mat = NIL
               then begin                             (* restore original matrix *)
                    GetMem (Mat, OldCol*Oldrow*OldLay*SizeOf(double));
                    for i:=1 to OldCol do
                      for j:=1 to OldRow do
                        for k:=1 to OldLay do
                          Array1D(Mat^)[((j-1)*FNumX+i-1)*FNumZ+k] := Array1D(AuxMat^)[((j-1)*FNumX+i-1)*FNumZ+k]
                    end
               else begin
                    FNumX := Nc;                 (* take new matrix and restore data *)
                    FNumY := Nr;
                    FNumZ := Nl;
                    for i:=1 to Nc do
                      for j:=1 to Nr do
                        for k:=1 to Nl do
                          Array1D(Mat^)[((j-1)*FNumX+i-1)*FNumZ+k] := 0;
                    MinCol := nc;
                    if OldCol < MinCol then
                      MinCol := OldCol;
                    MinRow := nr;
                    if OldRow < MinRow then
                      MinRow := OldRow;
                    MinLay := nl;
                    if OldLay < MinLay then
                      MinLay := OldLay;
                    for i:=1 to MinCol do
                      for j:=1 to MinRow do
                        for k:=1 to MinLay do
                          Array1D(Mat^)[((j-1)*FNumX+i-1)*FNumZ+k] := Array1D(AuxMat^)[((j-1)*FNumX+i-1)*FNumZ+k];
                    reslt := TRUE;
                    end;
             FreeMem (AuxMat, OldCol*OldRow*OldLay*SizeOf(double));
             end;
           Changed;
           end;
         end;
  end;
Resize := reslt;
end;



begin  // initialisation
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
end.



