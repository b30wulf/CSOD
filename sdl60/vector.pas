unit vector;

(******************************************************************)
(*                                                                *)
(*                         V E C T O R                            *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                   April 1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-25, 2001                                  *)
(*                                                                *)
(******************************************************************)


{release history:

1.0

1.5   [May-28, 1997]
      bug fix: destroy was not declared as "override" --> resulted in memory allocation problems with "Free"
      VECTOR now available for D1, D2, D3, C++Builder 1.0

1.6   [Apr-09, 1998]
      VECTOR is now available for C++Builder 3.0
      class TIntVector implemented
      ESDLVectorError implemented (formerly ELocompError of DCOMMON)
      DCommon no longer needed
      OnChange event implemented
      new method Changed implemented
      method Quartiles implemented
      create now initializes vector to zero elements
      method sum implemented
      bug fixed which caused strange behavior for zero or negative
        vector dimensions on create

1.7   [Aug-17, 1998]
      VECTOR is now available for Delphi 4.0
      bug in help file concerning Quartiles documentation fixed
      method Histogram implemented (TVector)

1.8   [Mar-24, 1999]
      VECTOR now available for C++Builder 4.0
      method Clone implemented
      method Resize now does not execute if the new dimensions are
               equal to the old ones
      method SortElems implemented
      property Elem is now default property

5.0   [Oct-09, 1999]
      VECTOR now available for Delphi 5.0

5.5   [May-01, 2000]
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      new method SkewKurtSample of class TVector and TIntVector implemented
      new method GeometricMean implemented
      new method HarmonicMean implemented
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


{------------------------------------------------------------------------------}
interface
{------------------------------------------------------------------------------}

uses
  classes, Sysutils, math1 {$IFDEF SHAREWARE}, dialogs {$ENDIF};

type
  ESDLVectorError = class(Exception);     { exception type to indicate errors }
  TIntVector = class;
  TVector = class (TObject)
              private
                FNElem         : longint;                  { number of elements }
                FVec           : pointer;          { pointer to vector elements }
                FOnChange      : TNotifyEvent;
                FOnSortExchange: TSortExchgEvent;
                function    GetVal (Elem: longint): double;
                procedure   SetVal (Elem: longint; Value: double);
                function    CalcVecLeng: double;
                procedure   SetVecLeng (Value: double);
                procedure   SkewKurtIntern (LowElem, HighElem: word;
                                 var Skewness, Kurtosis: double; var NumData: longint);
              protected
                procedure   SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
              public
                constructor Create (Size: longint);
                destructor  Destroy; override;
                procedure   Add (OtherVec: TVector);
                procedure   Clear;
                procedure   Changed;
                procedure   Clone (VecSource: TVector);
                procedure   CopyFrom (VecSource: TVector;
                               SourceElemLo, SourceElemHi,
                               DestElem: integer);
                function    DotProduct (OtherVec: TVector): double;
                procedure   Fill (value: double);
                function    GeometricMean (LowElem, HighElem: word): double;
                function    HarmonicMean (LowElem, HighElem: word): double;
                function    Histogram (FirstElem, LastElem: longint;
                               FirstBin, LastBin, BinWidth: double;
                               Histo: TIntVector; var Underflow,
                               Overflow, MaxCnt: longint): boolean;
                property    Leng: double read CalcVecLeng write SetVecLeng;
                procedure   MeanVar (LowElem, HighElem: word;
                               var Mean, Variance: double);
                procedure   MinMax (LowElem, HighElem: word;
                               var Minimum, Maximum: double);
                function    Quartiles (LowElem, HighElem: integer;
                               var Q1, Q2, Q3: double): boolean;
                function    Resize (NE: longint): boolean;
                procedure   SkewKurt (LowElem, HighElem: word;
                               var Skewness, Kurtosis: double);
                procedure   SkewKurtSample (LowElem, HighElem: word;
                               var Skewness, Kurtosis: double);
                procedure   SMult (scalar: double);
                procedure   SortElems (Ascending: boolean; RangeFirst, RangeLast: integer);
                procedure   Subtract (OtherVec: TVector);
                function    Sum (LowElem, HighElem: integer): double;
                property    Elem[ix: longint]: double read GetVal write SetVal; default;
                property    NrOfElem: longint read FNElem;
                property    OnChange: TNotifyEvent read FOnChange write FOnChange;
                property    OnSortExchange: TSortExchgEvent read FOnSortExchange write FOnSortExchange;
            end;
  TIntVector = class (TObject)
                 private
                   FNElem         : longint;              { number of elements }
                   FVec           : pointer;      { pointer to vector elements }
                   FOnChange      : TNotifyEvent;
                   FOnSortExchange: TSortExchgEvent;
                   function    GetVal (Elem: longint): integer;
                   procedure   SetVal (Elem: longint; Value: integer);
                   function    CalcVecLeng: double;
                   procedure   SkewKurtIntern (LowElem, HighElem: word;
                                  var Skewness, Kurtosis: double; var NumData: longint);
                 protected
                   procedure   SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
                 public
                   constructor Create (Size: longint);
                   destructor  Destroy; override;
                   procedure   Add (OtherVec: TIntVector);
                   procedure   Changed;
                   procedure   Clear;
                   procedure   Clone (VecSource: TIntVector);
                   procedure   CopyFrom (VecSource: TIntVector;
                                  SourceElemLo, SourceElemHi,
                                  DestElem: integer);
                   function    DotProduct (OtherVec: TIntVector): integer;
                   procedure   Fill (value: integer);
                   function    GeometricMean (LowElem, HighElem: word): double;
                   function    HarmonicMean (LowElem, HighElem: word): double;
                   property    Leng: double read CalcVecLeng;  { %% read only - in contrast to TVector !! }
                   procedure   MeanVar (LowElem, HighElem: word;
                                  var Mean, Variance: double);
                   procedure   MinMax (LowElem, HighElem: word;
                                  var Minimum, Maximum: integer);
                   function    Quartiles (LowElem, HighElem: integer;
                                  var Q1, Q2, Q3: double): boolean;
                   function    Resize (NE: longint): boolean;
                   procedure   SkewKurt (LowElem, HighElem: word;
                                  var Skewness, Kurtosis: double);
                   procedure   SkewKurtSample (LowElem, HighElem: word;
                                  var Skewness, Kurtosis: double);
                   procedure   SMult (scalar: integer);
                   procedure   Subtract (OtherVec: TIntVector);
                   function    Sum (LowElem, HighElem: integer): longint;
                   property    Elem[ix: longint]: integer read GetVal write SetVal; default;
                   property    NrOfElem: longint read FNElem;
                   property    OnChange: TNotifyEvent read FOnChange write FOnChange;
                   property    OnSortExchange: TSortExchgEvent read FOnSortExchange write FOnSortExchange;
               end;



{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

uses
  WinProcs, WinTypes;

type
  Array1D = array[1..1] of double;
  Array1I = array[1..1] of integer;


{--------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                       }
{--------------------------------------------------------------------}

{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\vector_ct.inc}
{$ENDIF}


(*********************************************************)
constructor TVector.Create (Size: longint);
(*********************************************************)

var
  i : integer;

begin
inherited Create;
if (size <= 0) then
  raise ESDLVectorError.Create ('vector dimension zero or negative');
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  FVec := nil;
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
FNElem := Size;
{$IFDEF VER80}      { restrict only in 16-Bit version }
if longint(FNElem)*SizeOf(double) > 65500
  then raise ESDLVectorError.Create ('too many vector elements')
  else begin
       GetMem (FVec, FNElem*SizeOf(double));
       if (FVec = NIL) then
         raise ESDLVectorError.Create ('not enough memory on heap');
       end;
{$ELSE}
GetMem (FVec, FNElem*SizeOf(double));
if (FVec = NIL) then
  raise ESDLVectorError.Create ('not enough memory on heap');
{$ENDIF}
for i:=1 to FNElem do   { initialize to zero values }
  Array1D(FVec^)[i] := 0.0;
end;


(*********************************************************)
destructor TVector.Destroy;
(*********************************************************)

begin
if FVec <> NIL then
  FreeMem (FVec, FNElem*SizeOf(double));
FVec := NIL;
inherited Destroy;
end;

(***********************************************************************)
procedure TVector.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;


(***********************************************************************)
procedure TVector.SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
(***********************************************************************
  ExchgWhat ..... 1 = columns, 2 = rows
  index1, index2 .... columns/rows to be exchanged
  first, last ....... range affected by sorting
 ***********************************************************************)

begin
if Assigned(FOnSortExchange) then
  FOnSortExchange (self, ExchgWhat, index1, index2, first, last);
end;


(**************************************************************************)
procedure ExChange (var x,y; size: word);
(**************************************************************************
  ENTRY:  x,y ..... any two equal sized variables
          size .... size of these variables
  EXIT:   x and y are exchanged
  REMARK: a public copy of this routine is available in unit MATH1. This
          local copy has been included here to gain independence of MATH1.
 **************************************************************************)

type
  ByteArray = array[1..MaxInt] of byte;

var
  i   : integer;
  b   : byte;

begin
for i:=1 to size do
  begin
  b := byteArray(x)[i];
  ByteArray(x)[i] := ByteArray(y)[i];
  byteArray(y)[i] := b;
  end;
end;


(*********************************************************)
function TVector.Resize (NE: longint): boolean;
(*********************************************************
  ENTRY:  NE ..... new number of elements

  EXIT:   function returns TRUE if resizing has been completed
          successfully.  Data are not destroyed, if possible;
          new cells are filled with zero values.
 *********************************************************)

var
  reslt   : boolean;
  OldElem : integer;
  MinElem : integer;
  AuxVec  : pointer;
  i       : integer;

begin
reslt := true;
if (NE <> FNElem) then
  begin
  reslt := FALSE;
  if {$IFDEF VER80} (longint(nE)*SizeOf(double) <= 65500) and {$ENDIF} (nE > 0) then
    begin
    OldElem := FNElem;
    GetMem (AuxVec, OldElem*SizeOf(double));
    if (AuxVec <> NIL) then
      begin
      for i:=1 to OldElem do    (* copy existing data into auxiliary vector *)
        Array1D(AuxVec^)[i] := Array1D(FVec^)[i];
      FreeMem (FVec, OldElem*SizeOf(double));  (* dispose and setup new vector *)
      GetMem (FVec, NE*SizeOf(double));
      if FVec = NIL
        then begin                             (* restore original vector *)
             GetMem (FVec, Oldelem*SizeOf(double));
             for i:=1 to OldElem do
               Array1D(FVec^)[i] := Array1D(AuxVec^)[i];
             end
        else begin
             FNElem := NE;                 (* take new vector and restore data *)
             for i:=1 to NE do
               Array1D(FVec^)[i] := 0;
             MinElem := FNElem;
             if OldElem < MinElem then
               MinElem := OldElem;
             for i:=1 to MinElem do
               Array1D(FVec^)[i] := Array1D(AuxVec^)[i];
             reslt := TRUE;
             Changed;
             end;
      FreeMem (AuxVec, OldElem*SizeOf(double));
      end;
    end;
  end;
Resize := reslt;
end;


(*********************************************************)
function TVector.GetVal (Elem: longint): double;
(*********************************************************)

begin
if (FVec <> NIL) and
   (Elem >= 1) and (Elem <= FNElem)
  then GetVal := Array1D(FVec^)[Elem]
  else GetVal := 0;
end;

(*********************************************************)
procedure TVector.SetVal (Elem: longint; Value: double);
(*********************************************************)

begin
if (FVec <> NIL) and
   (Elem >= 1) and (Elem <= FNElem) then
  begin
  Array1D(FVec^)[Elem] := value;
  Changed;
  end;
end;


(*********************************************************)
function TVector.CalcVecLeng: double;
(*********************************************************
  ENTRY: self ......... vector
  EXIT:  function returns length of vector
 *********************************************************)

var
  i     : word;
  d     : double;

begin
d := 0;
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    d := d + sqr(Array1D(FVec^)[i]);
  d := sqrt(d);
  end;
result := d;
end;

(*********************************************************)
procedure TVector.SetVecLeng (Value: double);
(*********************************************************
  ENTRY: Value .......... vector length to be set
  EXIT:  procedure sets vectors elements in a way that
         the length of the vector becomes 'value'
 *********************************************************)

var
  i     : word;
  d     : double;

begin
d := 0;
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    d := d + sqr(Array1D(FVec^)[i]);
  d := sqrt(d);
  if d = 0
    then raise ESDLVectorError.Create ('vector has zero length')
    else begin
         d := Value/d;
         for i:=1 to FNElem do
           Array1D(FVec^)[i] := d*Array1D(FVec^)[i];
         end;
  Changed;
  end;
end;


(*********************************************************)
function TVector.DotProduct (OtherVec: TVector): double;
(*********************************************************
  ENTRY: self ......... vector
         OtherVec ..... 2nd vector
  EXIT:  function returns dot product of the two vectors
         ( self * OtherVec )
         if the two vectors are of different dimensions an
         exception is generated
 *********************************************************)

var
  i     : longint;
  d     : double;

begin
d := 0;
if (FVec <> NIL) and (OtherVec <> NIL) then
  begin
  if OtherVec.NrOfElem <> FNElem then
    raise ESDLVectorError.Create ('vectors have different dimensions');
  for i:=1 to FnElem do
    d := d + Array1D(FVec^)[i] * OtherVec.Elem[i];
  end;
DotProduct := d;
end;




(*********************************************************)
procedure TVector.Add (OtherVec: TVector);
(*********************************************************
  ENTRY: self ......... vector
         OtherVec ..... 2nd vector
  EXIT:  self = self + OtherVector
         if the two vectors are of different dimensions an
         exception is generated
 *********************************************************)

var
  i     : longint;

begin
if (FVec <> NIL) and (OtherVec <> NIL) then
  begin
  if OtherVec.NrOfElem <> FNElem then
    raise ESDLVectorError.Create ('vectors have different dimensions');
  for i:=1 to FnElem do
    Array1D(FVec^)[i] := Array1D(FVec^)[i] + OtherVec.Elem[i];
  Changed;
  end;
end;


(*********************************************************)
procedure TVector.Subtract (OtherVec: TVector);
(*********************************************************
  ENTRY: self ......... vector
         OtherVec ..... 2nd vector
  EXIT:  self = self - OtherVector
         if the two vectors are of different dimensions an
         exception is generated
 *********************************************************)

var
  i     : longint;

begin
if (FVec <> NIL) and (OtherVec <> NIL) then
  begin
  if OtherVec.NrOfElem <> FNElem then
    raise ESDLVectorError.Create ('vectors have different dimensions');
  for i:=1 to FnElem do
    Array1D(FVec^)[i] := Array1D(FVec^)[i] - OtherVec.Elem[i];
  Changed;
  end;
end;


(*********************************************************)
procedure TVector.SMult (scalar: double);
(*********************************************************
  ENTRY: self ......... vector
         scalar ....... multiplier
  EXIT:  self = self * scalar
 *********************************************************)

var
  i     : longint;

begin
if (FVec <> NIL) then
  begin
  for i:=1 to FnElem do
    Array1D(FVec^)[i] := Array1D(FVec^)[i] * scalar;
  Changed;
  end;
end;



(*********************************************************)
procedure TVector.MinMax (LowElem, HighElem: word;
                         var Minimum, Maximum: double);
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  Minimum, Maximum .. minimum and maximum value in
                             searched area
 *********************************************************)

var
  i     : word;
  value : double;

begin
Minimum := 1.7e308;
Maximum := -1.7e308;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNELem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  for i:=LowElem to HighElem do
    begin
    value := Array1D(FVec^)[i];
    if value < Minimum then
      Minimum := value;
    if value > Maximum then
      Maximum := value;
    end;
  end;
end;

(*********************************************************)
procedure TVector.SortElems (Ascending: boolean; RangeFirst, RangeLast: integer);
(*********************************************************
  ENTRY: RangeFirst ........ lower border of sorting range
         RangeLast ......... upper border of sorting range
         Ascending ......... type of sorting (FALSE = descending,
                             TRUE ascending)

  EXIT:  vector elements sorted

  REMARK: algorithm used for sorting: modified bubble sort
 *********************************************************)

const
  ShrinkFac = 1.3;

var
  JumpWidth : word;
  ix        : integer;
  exchngd   : boolean;
  rdummy    : real;

begin
if RangeFirst > RangeLast then
  Exchange (RangeFirst, RangeLast, sizeof (RangeFirst));
if RangeFirst < 1 then
  RangeFirst := 1;
if RangeFirst > FNElem then
  RangeFirst := FNElem;
if RangeLast < 1 then
  RangeLast := 1;
if RangeLast > FNElem then
  RangeLast := FNElem;
JumpWidth := RangeLast-RangeFirst;
if JumpWidth > 0 then
  begin
  if Ascending
    then begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := RangeFirst;
           exchngd := False;
           repeat
             if Array1D(FVec^)[Ix] > Array1D(FVec^)[Ix+JumpWidth] then
               begin
               rdummy := Array1D(FVec^)[ix];
               Array1D(FVec^)[ix] := Array1D(FVec^)[ix+JumpWidth];
               Array1D(FVec^)[ix+JumpWidth] := rdummy;
               exchngd := True;
               SortExchange (0, ix, ix+jumpWidth, 0, 0);
               end;
             inc (ix);
           until (ix+JumpWidth > RangeLast);
         until ((JumpWidth = 1) and not exchngd);
         end
    else begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := RangeFirst;
           exchngd := False;
           repeat
             if Array1D(FVec^)[Ix] < Array1D(FVec^)[Ix+JumpWidth] then
               begin
               rdummy := Array1D(FVec^)[ix];
               Array1D(FVec^)[ix] := Array1D(FVec^)[ix+JumpWidth];
               Array1D(FVec^)[ix+JumpWidth] := rdummy;
               exchngd := True;
               SortExchange (0, ix, ix+jumpWidth, 0, 0);
               end;
             inc (ix);
           until (ix+JumpWidth > RangeLast);
         until ((JumpWidth = 1) and not exchngd);
         end;
  Changed;
  end;
end;

(*********************************************************)
function TVector.Quartiles (LowElem, HighElem: integer;
                            var Q1, Q2, Q3: double): boolean;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  Q1, Q2, Q3 ... quartiles of distribution
 *********************************************************)

type
  darrtype = array [1..1] of double;

var
  srtarray  : pointer;
  i         : integer;
  LengArray : longint;
  reslt     : boolean;
  dx        : double;
  ix        : integer;

begin
reslt := false;
Q1 := 0;
Q2 := 0;
Q3 := 0;
if (FVec <> NIL) then
  begin
  reslt := true;
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  LengArray := HighElem-LowElem+1;
  Getmem (srtarray, LengArray*sizeof(double));
  if srtArray = NIL
    then reslt := false
    else begin
         for i:=LowElem to HighElem do
           darrType(SrtArray^)[1+i-LowElem] := Array1D(FVec^)[i];
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
function TVector.Histogram (FirstElem, LastElem: longint;
            FirstBin, LastBin, BinWidth: double; Histo: TIntVector;
            var Underflow, Overflow, MaxCnt: longint): boolean;
(*********************************************************
  ENTRY: data vector ........... contains data
         FirstElem, LastElem ... coords of first and last cell
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
  i     : integer;

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
  for i:=FirstElem to LastElem do
    begin
    if Elem[i] < FirstBin
      then inc (UnderFlow)
      else begin
           if Elem[i] >= LastBin+BinWidth
             then inc (OverFlow)
             else begin
                  ix := 1+trunc((Elem[i]-FirstBin)/BinWidth);
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
procedure TVector.MeanVar (LowElem, HighElem: word;
                         var Mean, Variance: double);
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  Mean, Variance .... mean and variance in
                             searched area
 *********************************************************)

var
  i       : word;
  value   : double;
  NumData : integer;
  sum     : double;
  Sumq    : double;


begin
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  NumData := 0;
  sum := 0.0;
  sumq := 0.0;
  for i:=LowElem to HighElem do
    begin
    value := Array1D(FVec^)[i];
    sum := sum + value;
    sumq := sumq + sqr(value);
    inc (NumData);
    end;
  Variance := 1.0;
  Mean := sum / NumData;
  if NumData >= 3 then
    Variance := (sumq-sqr(sum)/NumData)/(NumData-1);
  end;
end;


(*********************************************************)
function TVector.GeometricMean (LowElem, HighElem: word): double;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  function returns geometric mean
         if any argument is negative, an exception is raised
 *********************************************************)

var
  i         : word;
  value     : double;
  sum       : double;
  ZeroFound : boolean;


begin
result := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  sum := 0.0;
  ZeroFound := false;
  for i:=LowElem to HighElem do
    begin
    value := Array1D(FVec^)[i];
    if value < 0
      then raise ESDLVectorError.Create ('negative argument passed to GeometricMean')
      else begin
           if value = 0
             then ZeroFound := true
             else sum := sum + ln(value);
           end;
    end;
  if ZeroFound
    then result := 0
    else result := exp (sum/(HighElem-LowElem+1));
  end;
end;


(*********************************************************)
function TVector.HarmonicMean (LowElem, HighElem: word): double;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  function returns the harmonic mean
         if any argument is <=0, an exception is raised
 *********************************************************)

var
  i         : word;
  value     : double;
  sum       : double;


begin
result := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  sum := 0.0;
  for i:=LowElem to HighElem do
    begin
    value := Array1D(FVec^)[i];
    if value <= 0
      then raise ESDLVectorError.Create ('negative or zero argument passed to HarmonicMean')
      else begin
           sum := sum + 1/value;
           end;
    end;
  result := (HighElem-LowElem+1)/sum;
  end;
end;



(*********************************************************)
function TVector.Sum (LowElem, HighElem: integer): double;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  function returns sum of specified range
 *********************************************************)

var
  i       : integer;
  total   : double;


begin
total := 0.0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  for i:=LowElem to HighElem do
    total := total + Array1D(FVec^)[i];
  end;
Sum := total;
end;



(*********************************************************)
procedure TVector.SkewKurtIntern (LowElem, HighElem: word;
                  var Skewness, Kurtosis: double; var NumData: longint);
(*********************************************************
  ENTRY: LowElem, HighElem ... range of elements to use
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
         NumData ............. number of values involved
 *********************************************************)

var
  i       : word;
  value   : extended;
  sum     : extended;
  sumq    : extended;
  Mean    : extended;
  stddev  : extended;
  pot     : extended;

begin
Skewness := 0;
Kurtosis := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  NumData := HighElem-LowElem+1;
  if NumData > 3 then
    begin
    sum := 0;
    for i:=LowElem to HighElem do
      begin
      value := Array1D(FVec^)[i];
      sum := sum + value;
      end;
    Mean := sum / NumData;
    sumq := 0;
    sum := 0;
    for i:=LowElem to HighElem do
      begin
      value := Array1D(FVec^)[i]-mean;
      sum := sum + value;
      pot := sqr(value);
      sumq := sumq + pot;
      pot := pot*value;
      SkewNess := SkewNess+pot;
      pot := pot*value;
      Kurtosis := Kurtosis+pot;
      end;
    if NumData > 1 then
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
end;

(*********************************************************)
procedure TVector.SkewKurt (LowElem, HighElem: word;
                      var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowElem, HighElem ... range of elements to use
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  nd : longint;

begin
SkewKurtIntern (LowELem, HighElem, Skewness, Kurtosis, nd);
end;

(*********************************************************)
procedure TVector.SkewKurtSample (LowElem, HighElem: word;
                      var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowElem, HighElem ... range of elements to use
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  NumData : integer;

begin
SkewKurtIntern (LowElem, HighElem, Skewness, Kurtosis, NumData);
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
procedure TVector.Clone (VecSource: TVector);
(*********************************************************
  ENTRY: VecSource ... source vector to be copied
  EXIT:  vector self is a clone of MatVector
 *********************************************************)

var
  i : integer;

begin
if VecSource <> NIL then
  begin
  self.Resize (VecSource.NrOfElem);
  for i:=1 to VecSource.NrOfElem do
    self.setval (i, VecSource.Getval (i));
  Changed;
  end;
end;



(*********************************************************)
procedure TVector.CopyFrom (VecSource: TVector; SourceElemLo,
                          SourceElemHi, DestElem: integer);
(*********************************************************
  ENTRY: VecSource ... source Vector to be copied
         SourceElemLo, SourceElemHi ... range of elements in source Vector
         DestElem ....... position of copied values
  EXIT:  Vector Vec1 is copied to Vec2;
 *********************************************************)

var
  i : integer;

begin
if VecSource <> NIL then
  begin
  if SourceElemLo < 1 then
    SourceElemLo := 1;
  if SourceElemLo > VecSource.NrOfElem then
    SourceElemLo := VecSource.NrOfElem;
  if SourceElemHi < 1 then
    SourceElemHi := 1;
  if SourceElemHi > VecSource.NrOfElem then
    SourceElemHi := VecSource.NrOfElem;
  if SourceElemLo > SourceElemHi then
    ExChange (SourceElemLo,SourceElemHi,sizeof(SourceElemLo));
  for i:=SourceElemLo to SourceElemHi do
    self.setval (i-SourceElemLo+DestElem,VecSource.Getval (i));
  Changed;
  end;
end;


(*********************************************************)
procedure TVector.Fill (value: double);
(*********************************************************
  ENTRY: value ...... value to fill Vector with
  EXIT:  Vector is filled with 'value'
 *********************************************************)

var
  i    : word;

begin
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    Array1D(FVec^)[i] := value;
  Changed;
  end;
end;

(*********************************************************)
procedure TVector.Clear;
(*********************************************************
  ENTRY: -
  EXIT:  Vector is filled with 0.0 values
 *********************************************************)

var
  i    : word;

begin
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    Array1D(FVec^)[i] := 0.0;
  Changed;
  end;
end;


(*********************************************************)
constructor TIntVector.Create (Size: longint);
(*********************************************************)

var
  i : integer;

begin
inherited Create;
if (size <= 0) then
  raise ESDLVectorError.Create ('vector dimension zero or negative');
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  FVec := NIL;
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}

FNElem := Size;
{$IFDEF VER80}      { restrict only in 16-Bit version }
if longint(FNElem)*SizeOf(integer) > 65500
  then raise ESDLVectorError.Create ('too many vector elements')
  else begin
       GetMem (FVec, FNElem*SizeOf(integer));
       if (FVec = NIL) then
         raise ESDLVectorError.Create ('not enough memory on heap');
       end;
{$ELSE}
GetMem (FVec, FNElem*SizeOf(integer));
if (FVec = NIL) then
  raise ESDLVectorError.Create ('not enough memory on heap');
{$ENDIF}
for i:=1 to FNElem do   { initialize to zero values }
  Array1I(FVec^)[i] := 0;
end;


(*********************************************************)
destructor TIntVector.Destroy;
(*********************************************************)

begin
if FVec <> NIL then
  FreeMem (FVec, FNElem*SizeOf(integer));
FVec := NIL;
inherited Destroy;
end;


(***********************************************************************)
procedure TIntVector.SortExchange (ExchgWhat: byte; index1, index2, first, last: longint);
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
procedure TIntVector.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;


(*********************************************************)
function TIntVector.Resize (NE: longint): boolean;
(*********************************************************
  ENTRY:  NE ..... new number of elements

  EXIT:   function returns TRUE if resizing has been completed
          successfully.  Data are not destroyed, if possible;
          new cells are filled with zero values.
 *********************************************************)

var
  reslt   : boolean;
  OldElem : integer;
  MinElem : integer;
  AuxVec  : pointer;
  i       : integer;

begin
reslt := true;
if (NE <> FNElem) then
  begin
  reslt := FALSE;
  if {$IFDEF VER80} (longint(nE)*SizeOf(integer) <= 65500) and {$ENDIF} (nE > 0) then
    begin
    OldElem := FNElem;
    GetMem (AuxVec, OldElem*SizeOf(integer));
    if (AuxVec <> NIL) then
      begin
      for i:=1 to OldElem do    (* copy existing data into auxiliary vector *)
        Array1I(AuxVec^)[i] := Array1I(FVec^)[i];
      FreeMem (FVec, OldElem*SizeOf(integer));  (* dispose and setup new vector *)
      GetMem (FVec, NE*SizeOf(integer));
      if FVec = NIL
        then begin                             (* restore original vector *)
             GetMem (FVec, Oldelem*SizeOf(integer));
             for i:=1 to OldElem do
               Array1I(FVec^)[i] := Array1I(AuxVec^)[i];
             end
        else begin
             FNElem := NE;                 (* take new vector and restore data *)
             for i:=1 to NE do
               Array1I(FVec^)[i] := 0;
             MinElem := FNElem;
             if OldElem < MinElem then
               MinElem := OldElem;
             for i:=1 to MinElem do
               Array1I(FVec^)[i] := Array1I(AuxVec^)[i];
             reslt := TRUE;
             Changed;
             end;
      FreeMem (AuxVec, OldElem*SizeOf(integer));
      end;
    end;
  end;
Resize := reslt;
end;


(*********************************************************)
function TIntVector.GetVal (Elem: longint): integer;
(*********************************************************)

begin
if (FVec <> NIL) and
   (Elem >= 1) and (Elem <= FNElem)
  then GetVal := Array1I(FVec^)[Elem]
  else GetVal := 0;
end;

(*********************************************************)
procedure TIntVector.SetVal (Elem: longint; Value: integer);
(*********************************************************)

begin
if (FVec <> NIL) and
   (Elem >= 1) and (Elem <= FNElem) then
  begin
  Array1I(FVec^)[Elem] := value;
  Changed;
  end;
end;


(*********************************************************)
function TIntVector.CalcVecLeng: double;
(*********************************************************
  ENTRY: self ......... vector
  EXIT:  function returns length of vector
 *********************************************************)

var
  i     : word;
  d     : double;

begin
d := 0;
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    d := d + sqr(Array1I(FVec^)[i]);
  d := sqrt(d);
  end;
result := d;
end;


(*********************************************************)
function TIntVector.DotProduct (OtherVec: TIntVector): integer;
(*********************************************************
  ENTRY: self ......... vector
         OtherVec ..... 2nd vector
  EXIT:  function returns dot product of the two vectors
         ( self * OtherVec )
         if the two vectors are of different dimensions an
         exception is generated
 *********************************************************)

var
  i     : longint;
  d     : longint;

begin
d := 0;
if (FVec <> NIL) and (OtherVec <> NIL) then
  begin
  if OtherVec.NrOfElem <> FNElem then
    raise ESDLVectorError.Create ('vectors have different dimensions');
  for i:=1 to FnElem do
    d := d + Array1I(FVec^)[i] * OtherVec.Elem[i];
  end;
DotProduct := d;
end;




(*********************************************************)
procedure TIntVector.Add (OtherVec: TIntVector);
(*********************************************************
  ENTRY: self ......... vector
         OtherVec ..... 2nd vector
  EXIT:  self = self + OtherVector
         if the two vectors are of different dimensions an
         exception is generated
 *********************************************************)

var
  i     : longint;

begin
if (FVec <> NIL) and (OtherVec <> NIL) then
  begin
  if OtherVec.NrOfElem <> FNElem then
    raise ESDLVectorError.Create ('vectors have different dimensions');
  for i:=1 to FnElem do
    Array1I(FVec^)[i] := Array1I(FVec^)[i] + OtherVec.Elem[i];
  Changed;
  end;
end;


(*********************************************************)
procedure TIntVector.Subtract (OtherVec: TIntVector);
(*********************************************************
  ENTRY: self ......... vector
         OtherVec ..... 2nd vector
  EXIT:  self = self - OtherVector
         if the two vectors are of different dimensions an
         exception is generated
 *********************************************************)

var
  i     : longint;

begin
if (FVec <> NIL) and (OtherVec <> NIL) then
  begin
  if OtherVec.NrOfElem <> FNElem then
    raise ESDLVectorError.Create ('vectors have different dimensions');
  for i:=1 to FnElem do
    Array1I(FVec^)[i] := Array1I(FVec^)[i] - OtherVec.Elem[i];
  Changed;
  end;
end;


(*********************************************************)
procedure TIntVector.SMult (scalar: integer);
(*********************************************************
  ENTRY: self ......... vector
         scalar ....... multiplier
  EXIT:  self = self * scalar
 *********************************************************)

var
  i     : longint;

begin
if (FVec <> NIL) then
  begin
  for i:=1 to FnElem do
    Array1I(FVec^)[i] := Array1I(FVec^)[i] * scalar;
  Changed;
  end;
end;


(*********************************************************)
procedure TIntVector.MinMax (LowElem, HighElem: word;
                         var Minimum, Maximum: integer);
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  Minimum, Maximum .. minimum and maximum value in
                             searched area
 *********************************************************)

var
  i     : word;
  value : integer;

begin
Minimum := MaxInt;
Maximum := -MaxInt;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNELem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  for i:=LowElem to HighElem do
    begin
    value := Array1I(FVec^)[i];
    if value < Minimum then
      Minimum := value;
    if value > Maximum then
      Maximum := value;
    end;
  end;
end;


(*********************************************************)
function TIntVector.Quartiles (LowElem, HighElem: integer;
                            var Q1, Q2, Q3: double): boolean;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  Q1, Q2, Q3 ... quartiles of distribution
 *********************************************************)

type
  iarrtype = array [1..1] of integer;

var
  srtarray  : pointer;
  i         : integer;
  LengArray : longint;
  reslt     : boolean;
  ix        : integer;
  dx        : double;

begin
reslt := false;
Q1 := 0;
Q2 := 0;
Q3 := 0;
if (FVec <> NIL) then
  begin
  reslt := true;
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  LengArray := HighElem-LowElem+1;
  Getmem (srtarray, LengArray*sizeof(integer));
  if srtArray = NIL
    then reslt := false
    else begin
         for i:=LowElem to HighElem do
           iarrType(SrtArray^)[1+i-LowElem] := Array1I(FVec^)[i];
         SortArray (SrtArray, LengArray, inum, true);
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
function TIntVector.Sum (LowElem, HighElem: integer): longint;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  function returns sum of specified range
 *********************************************************)

var
  i       : integer;
  total   : longint;


begin
total := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  for i:=LowElem to HighElem do
    total := total + Array1I(FVec^)[i];
  end;
Sum := total;
end;



(*********************************************************)
procedure TIntVector.MeanVar (LowElem, HighElem: word;
                         var Mean, Variance: double);
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  Mean, Variance .... mean and variance in
                             searched area
 *********************************************************)

var
  i       : word;
  value   : integer;
  NumData : integer;
  sum     : double;
  Sumq    : double;


begin
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  NumData := 0;
  sum := 0.0;
  sumq := 0.0;
  for i:=LowElem to HighElem do
    begin
    value := Array1I(FVec^)[i];
    sum := sum + value;
    sumq := sumq + sqr(value);
    inc (NumData);
    end;
  Variance := 1.0;
  Mean := sum / NumData;
  if NumData >= 3 then
    Variance := (sumq-sqr(sum)/NumData)/(NumData-1);
  end;
end;


(*********************************************************)
function TIntVector.HarmonicMean (LowElem, HighElem: word): double;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  function returns the harmonic mean
         if any argument is <=0, an exception is raised
 *********************************************************)

var
  i         : word;
  value     : double;
  sum       : double;


begin
result := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  sum := 0.0;
  for i:=LowElem to HighElem do
    begin
    value := Array1I(FVec^)[i];
    if value <= 0
      then raise ESDLVectorError.Create ('negative or zero argument passed to HarmonicMean')
      else begin
           sum := sum + 1/value;
           end;
    end;
  result := (HighElem-LowElem+1)/sum;
  end;
end;


(*********************************************************)
function TIntVector.GeometricMean (LowElem, HighElem: word): double;
(*********************************************************
  ENTRY: LowElem ...... indices of first element of vector
         HighElem ..... indices of last element of vector
  EXIT:  function returns geometric mean
         if any argument is negative, an exception is raised
 *********************************************************)

var
  i         : word;
  value     : double;
  sum       : double;
  ZeroFound : boolean;


begin
result := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  sum := 0.0;
  ZeroFound := false;
  for i:=LowElem to HighElem do
    begin
    value := Array1I(FVec^)[i];
    if value < 0
      then raise ESDLVectorError.Create ('negative argument passed to GeometricMean')
      else begin
           if value = 0
             then ZeroFound := true
             else sum := sum + ln(value);
           end;
    end;
  if ZeroFound
    then result := 0
    else result := exp (sum/(HighElem-LowElem+1));
  end;
end;




(*********************************************************)
procedure TIntVector.SkewKurtIntern (LowElem, HighElem: word;
                  var Skewness, Kurtosis: double; var NumData: longint);
(*********************************************************
  ENTRY: LowElem, HighElem ... range of elements to use
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
         NumData ............. number of values involved
 *********************************************************)

var
  i       : word;
  value   : extended;
  sum     : extended;
  sumq    : extended;
  Mean    : extended;
  stddev  : extended;
  pot     : extended;

begin
Skewness := 0;
Kurtosis := 0;
if (FVec <> NIL) then
  begin
  if LowElem < 1 then
    LowElem := 1;
  if LowElem > FNElem then
    LowElem := FNElem;
  if HighElem < 1 then
    HighElem := 1;
  if HighElem > FNElem then
    HighElem := FNElem;
  if LowElem > HighElem then
    ExChange (LowElem, HighElem, sizeof(LowElem));
  NumData := HighElem-LowElem+1;
  if NumData > 3 then
    begin
    sum := 0;
    for i:=LowElem to HighElem do
      begin
      value := Array1I(FVec^)[i];
      sum := sum + value;
      end;
    Mean := sum / NumData;
    sumq := 0;
    sum := 0;
    for i:=LowElem to HighElem do
      begin
      value := Array1I(FVec^)[i]-mean;
      sum := sum + value;
      pot := sqr(value);
      sumq := sumq + pot;
      pot := pot*value;
      SkewNess := SkewNess+pot;
      pot := pot*value;
      Kurtosis := Kurtosis+pot;
      end;
    if NumData > 1 then
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
end;

(*********************************************************)
procedure TIntVector.SkewKurt (LowElem, HighElem: word;
                      var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowElem, HighElem ... range of elements to use
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  nd : longint;

begin
SkewKurtIntern (LowELem, HighElem, Skewness, Kurtosis, nd);
end;

(*********************************************************)
procedure TIntVector.SkewKurtSample (LowElem, HighElem: word;
                      var Skewness, Kurtosis: double);
(*********************************************************
  ENTRY: LowElem, HighElem ... range of elements to use
  EXIT:  Skewness, Kurtosis .. skewness and kurtosis of
                               indicated the region
 *********************************************************)

var
  NumData : integer;

begin
SkewKurtIntern (LowElem, HighElem, Skewness, Kurtosis, NumData);
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
procedure TIntVector.Clone (VecSource: TIntVector);
(*********************************************************
  ENTRY: VecSource ... source vector to be copied
  EXIT:  vector self is a clone of MatVector
 *********************************************************)

var
  i : integer;

begin
if VecSource <> NIL then
  begin
  self.Resize (VecSource.NrOfElem);
  for i:=1 to VecSource.NrOfElem do
    self.setval (i, VecSource.Getval (i));
  Changed;
  end;
end;



(*********************************************************)
procedure TIntVector.CopyFrom (VecSource: TIntVector; SourceElemLo,
                          SourceElemHi, DestElem: integer);
(*********************************************************
  ENTRY: VecSource ... source Vector to be copied
         SourceElemLo, SourceElemHi ... range of elements in source Vector
         DestElem ....... position of copied values
  EXIT:  Vector Vec1 is copied to Vec2;
 *********************************************************)

var
  i : integer;

begin
if VecSource <> NIL then
  begin
  if SourceElemLo < 1 then
    SourceElemLo := 1;
  if SourceElemLo > VecSource.NrOfElem then
    SourceElemLo := VecSource.NrOfElem;
  if SourceElemHi < 1 then
    SourceElemHi := 1;
  if SourceElemHi > VecSource.NrOfElem then
    SourceElemHi := VecSource.NrOfElem;
  if SourceElemLo > SourceElemHi then
    ExChange (SourceElemLo,SourceElemHi,sizeof(SourceElemLo));
  for i:=SourceElemLo to SourceElemHi do
    self.setval (i-SourceElemLo+DestElem,VecSource.Getval (i));
  Changed;
  end;
end;


(*********************************************************)
procedure TIntVector.Fill (value: integer);
(*********************************************************
  ENTRY: value ...... value to fill Vector with
  EXIT:  Vector is filled with 'value'
 *********************************************************)

var
  i    : word;

begin
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    Array1I(FVec^)[i] := value;
  Changed;
  end;
end;

(*********************************************************)
procedure TIntVector.Clear;
(*********************************************************
  ENTRY: -
  EXIT:  Vector is filled with 0.0 values
 *********************************************************)

var
  i    : word;

begin
if (FVec <> NIL) then
  begin
  for i:=1 to FNElem do
    Array1I(FVec^)[i] := 0;
  Changed;
  end;
end;



end.

