unit Math1;

(******************************************************************)
(*                                                                *)
(*                          M A T H 1                             *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                February 1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Feb-02, 2001                                  *)
(*                                                                *)
(******************************************************************)


{ revision history:

1.0   released June 1996

1.1   Dec-25, 1996
      configurable random generator implemented
      VarType extended to include snum and dnum

1.5   May-28, 1997
      logarithmus dualis implemented
      CalcScalePars now available (via dcommon)
      Decimal now provides for negative numbers
      ScanHex implemented
      ScanOctal implemented
      ScanBin implemented
      ScanDecimal implemented
      ScanFPNum implemented

1.6   Apr-08,1998
      MATH1 now available for C++Builder 3.0
      ScanHex, ScanOctal, and ScanBin improved to avoid arithmetic
          overflow if bit 31 is set.
      SortArray, SortIntoArray, InsertIntoArray: length of array is now
          longint instead of word to allow more than 65536 elements to be sorted
      bug in SortArray fixed which caused wrong result for arrays of length one
      Exchange is now part of MATH1 (formerly in DCOMMON)
      math constants are now part of MATH1 (formerly in DCOMMON)
      dcommon no longer needed
      definition of call back routine has been moved from MATH2 to MATH1
      call back routine for SortArray implemented
      TRandGen.WeibullDistri implemented

1.7   Aug-17, 1998
      MATH1 is now available for Delphi 4.0
      sqrt2pi implemented
      sqrt2pitom1 implemented
      ScanFPNum now accepts colons and/or dots as decimal points
      ScanFPNum can accept now either floating point numbers only or
          exponentional notation (parameter AllowExp)
      new constants: minReal, MinSingle, MinDouble, MinExtended
      bug fix in ScanBin: function returned wrong result

1.8   Mar-23, 1999
      MATH1 now available for C++Builder 4.0
      bug fixed in TRandgen.Normalize (crashed when reference points were all equal)
      TSortExchgEvent implemented

5.0   Sep-14, 1999
      bug fix in ScanFPNum: '-23.' no longer produces wrong results (caused
           by bug in Delphi (2.0))
      bug fix in ScanFPNum: function no longer crashes if value are above MaxDouble
      or below -MaxDouble
      EncodeLong and DecodeLong implemented

5.5   [May-10, 2000]
      function BitReversal implemented
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fix: SortIntoArray, InsertIntoArray, SortArray now work correctly with "single" floating point numbers
      AbortMathProc implemented
      StrToIntDefault implemented
      ScanDecimal now works correctly with empty strings
 }

{$O+}
{$F+}
{$N+}

{--------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
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


{--------------------------------------------------------------------------}
interface
{--------------------------------------------------------------------------}

const
  e           : extended = 2.718281828459045235360;
  etom1       : extended = 0.367879441171442321596;
  lg2         : extended = 0.301029995663981195214;
  lg5         : extended = 0.698970004336018804803;
  lge         : extended = 0.434294481903251827651;
  lgPi        : extended = 0.497149872694133854351;
  ln10        : extended = 2.302585092994045684018;
  ln2         : extended = 0.693147180559945309417;
  lnPi        : extended = 1.144729885849400174143;
  PiH         : extended = 1.570796326794896619231;
  PiSqr       : extended = 9.869604401089358618834;
  Pitom1      : extended = 0.318309886183790671538;
  sqrt2       : extended = 1.414213562373095048801;
  sqrt2pi     : extended = 2.506628274631000502416;
  sqrt2pitom1 : extended = 0.3989422804014326779399;
  GoldenR     : extended = 1.618033988749894848204;

{$I ntminmax.inc}


type
  FeedBackProcType = procedure (StateCnt: longint);  { general procedure type for callback routines }
  TSortExchgEvent = procedure (Sender: TObject; ExchgWhat: byte;
                               index1, index2, first, last: longint) of object;
                           { event when exchange of rows/columns occurs }
  VarType = (rnum,dnum,snum,inum,lnum,Bool,strg);
  TRandGen = class (TObject)
            private
               FLowBorder         : double;
               FHighBorder        : double;
               FResolution        : integer;
               FDistVec           : pointer;
               procedure SetResolution (res: integer);
               function  GetProbability (Idx: integer): double;
               function  GetRandNum: double;
               function  GetLambda (ix: integer): double;
               procedure SetProbability (Idx: integer; Value: double);
             public
               constructor Create;
               destructor Destroy; override;
               property  HighBorder: double read FHighBorder write FHighBorder;
               property  Lambda[ix: integer]: double read GetLambda;
               property  LowBorder: double read FLowBorder write FLowBorder;
               procedure Normalize;
               procedure NormalDistri (m, s: double);
               property  Probability[ix: integer]: double read GetProbability write SetProbability;
               property  Random: double read GetRandNum;
               function  IndexOfLambda (Lambda: double): integer;
               property  Resolution: integer read FResolution write SetResolution;
               procedure UniformDistri;
               procedure WeibullDistri (alpha, beta: double);
             end;


{procedures and functions}
  function  Bin
               (innum : longint;      { number to convert to binary string }
               places : byte)                           { number of places }
                      : string;                            { binary number }
  function  BitReversal
              (InByte : byte)                                 { input byte }
                      : byte;                          { bit-reversed byte }
  function  BRandom
                   (p : double)                              { probability }
                      : boolean;                 { TRUE with probability p }
  procedure CalcScalePars
               (Ntick : integer;                { number of ticks on scale }
               LowVal,                              { beginning of scaling }
              HighVal : double;                     { end point of scaling }
          var LowTick,                               { first tick on scale }
             Distance : double;                  { distance of scale ticks }
             var Divi : word);   { nr. of divisions between scaling labels }
  function  cosh
                   (x : double)                         { angle in radians }
                      : double;                        { hyperbolic cosine }
  function  cot
                   (x : double)                         { angle in radians }
                      : double;                                { cotangens }
  function  CountBits
             (InByte : byte)                       { byte to count bits in }
                     : integer;                           { number of bits }
  function  Decimal
               (innum : longint;     { number to convert to decimal string }
               places : byte)                           { number of places }
                      : string;           { decimal string with leading 0s }
  function  DecodeBit
                 (ix : integer)                     { number of bit (0..7) }
                     : byte;                    { byte holding decoded bit }
  function  DecodeLong
                 (ix : integer)                    { number of bit (0..31) }
                     : longint;              { longint holding decoded bit }
  function  EncodeLong
              (value : longint)              { longint holding decoded bit }
                     : integer;                    { number of bit (0..31) }
  procedure ExChange
             (var x,y;                        { pair of variables, untyped }
                 size : word);                        { length of variable }
  function  GRandom
                      : double;                           { Gaussian noise }
  function  GrayCode
               (InNum : word)                          { number to convert }
                      : word;                       { Gray code of 'InNum' }
  function  Hex
               (innum : longint;         { number to convert to hex string }
               places : byte)                           { number of places }
                      : string;                     { hexadecimal notation }
  procedure InsertIntoArray
            (ArrayAdr : pointer;                        { pointer to array }
            LengArray : longint;                         { length of array }
             TypArray : VarType;                           { type of field }
                value : pointer;                 { value to put into array }
                index : longint);                                  { index }
  function  IntPos
               (InNum : double)                        { number to process }
                      : longint;     { next integer greater/equal to InNum }
  function  IntNeg
               (InNum : double)                        { number to process }
                      : longint;     { next integer smaller/equal to InNum }
  function  lg
                   (x : double)                                 { argument }
                      : double;                         { common logarithm }
  function  ld
                   (x : double)                                 { argument }
                      : double;                       { logarithmus dualis }
  function  LongRand
                (seed : longint)                       { if <> 0 then init }
                      : double;                   { random value [0.0,1.0] }
  function  MakeEFormat
                   (x : double;                        { number to convert }
                  w,d : integer)                   { width, decimal places }
                      : string;                 { string in FORTRAN format }
  function  Max
                 (a,b : double)                          { input variables }
                      : double;                       { maximum of a and b }
  function  Min
                 (a,b : double)                          { input variables }
                      : double;                       { minimum of a and b }
  function  Octal
               (innum : longint;          { nr. to convert to octal string }
               places : byte)                           { number of places }
                      : string;                           { octal notation }
  function  ScanBin
            (Instring : string;          { string containing binary number }
              var Idx : integer)    { starting position of binary decoding }
                      : longint;                                  { result }
  function  ScanDecimal
            (Instring : string;         { string containing decimal number }
              var Idx : integer)   { starting position of decimal decoding }
                      : longint;                                  { result }
  function  ScanFPNum
            (Instring : string;        { string with floating point number }
             AllowExp : boolean;        { TRUE: allow exponential notation }
             DecPChar : integer;                    { dec. point character }
              var Idx : integer)   { starting position of decimal decoding }
                      : double;                                   { result }
  function  ScanHex
            (Instring : string;     { string containing hexadecimal number }
              var Idx : integer)       { starting position of hex decoding }
                      : longint;                                  { result }
  function  ScanOctal
            (Instring : string;           { string containing octal number }
              var Idx : integer)     { starting position of octal decoding }
                      : longint;                                  { result }
  function  Sign
                   (a : double)                           { input variable }
                      : integer;                               { signum(a) }
  function  sinh
                   (x : double)                         { angle in radians }
                      : double;                       { sinus hyperbolicus }
  procedure SortArray
            (ArrayAdr : pointer;                        { pointer to array }
            LengArray : longint;                         { length of array }
             TypArray : VarType;                           { type of array }
            Ascending : boolean);                       { TRUE = ascending }
  function  SortIntoArray
            (ArrayAdr : pointer;                        { pointer to array }
            LengArray : longint;                         { length of array }
             TypArray : VarType;                           { type of array }
                value : pointer;                      { value to sort into }
            Ascending : boolean;                        { TRUE = ascending }
           Dublicates : boolean)               { TRUE = dublicates allowed }
                      : longint;                          { index of value }
  function  strf
                   (r : double;                        { number to convert }
           FieldWidth : integer;                   { width of output field }
                 DecP : integer)                   { number of dec. places }
                      : string;                         { formatted string }
  function  StrToIntDefault
               (InStr : string;             { input string to be converted }
                  Def : integer)       { default value if conversion fails }
                      : integer;                         { converted value }
  function  tg
                   (x : double)                         { angle in radians }
                      : double;                                  { tangens }
  function  tgh
                   (x : double)                         { angle in radians }
                      : double;                     { tangens hyperbolicus }
  function  WithinBounds
               (Inval : double;                         { value to compare }
            Boundary1 : double;                   { boundary 1 of interval }
            Boundary2 : double)                   { boundary 2 of interval }
                      : boolean;             { TRUE if Inval within bounds }

  var
    AbortMathProc    : boolean;
    ProcStat         : longint;                   { state of process }
    MathFeedBackProc : FeedBackProcType;  { global math feedback procedure }
                  { this callback procedure should be declared in the
                    application program which uses the time-consuming
                    math routines. It has to be of type 'FeedBackProcType'
                    and gets the value of variable 'ProcStat' passed.
                    In its body this routine uses to value of 'cnt' to
                    display the status of a math routine. The feedback
                    routine can be switched off by assigning a NIL pointer
                    to it }


{$IFDEF DEVELOPVERS}                    { this is the interface section of }
{$I math1dvi.inc}                             { the untested part of MATH1 }
{$ENDIF}

{--------------------------------------------------------------------------}
implementation
{--------------------------------------------------------------------------}

uses
  sysutils, wintypes, winprocs {$IFDEF SHAREWARE}, dialogs {$ENDIF};



type
  ESDLMath1Error = class(Exception);     { exception type to indicate errors }
  Array1D  = array[1..1] of double;

var
  GaussRndFlag : boolean;             { flag for Gaussian random generator }
  GaussRNum    : double;                          { Gaussian random number }
  RandA,               { random number generator with cycle length of 7e12 }
  RandB,
  RandC        : longint;


{$IFDEF SHAREWARE}
{$I sharwinc\delfrun.inc}
{$I sharwinc\math1_ct.inc}
{$ENDIF}

{$IFDEF DEVELOPVERS}               { this is the implementation section of }
{$I math1dv.inc}                              { the untested part of MATH1 }
{$ENDIF}

{$I calcscp.inc}
{$I weibull.inc}
{$I SCANBIN.INC}
{$I SCANHEX.INC}
{$I SCANOCT.INC}
{$I SCANDEC.INC}
{$I SCANFPN.INC}
{$I hxoctbin.inc}

(**************************************************************************)
function BitReversal (InByte: byte): byte;
(**************************************************************************)

const
  BitReverseCode : array[0..255] of byte =
         ($00, $80, $40, $C0, $20, $A0, $60, $E0, $10, $90, $50, $D0, $30, $B0, $70, $F0,
          $08, $88, $48, $C8, $28, $A8, $68, $E8, $18, $98, $58, $D8, $38, $B8, $78, $F8,
          $04, $84, $44, $C4, $24, $A4, $64, $E4, $14, $94, $54, $D4, $34, $B4, $74, $F4,
          $0C, $8C, $4C, $CC, $2C, $AC, $6C, $EC, $1C, $9C, $5C, $DC, $3C, $BC, $7C, $FC,
          $02, $82, $42, $C2, $22, $A2, $62, $E2, $12, $92, $52, $D2, $32, $B2, $72, $F2,
          $0A, $8A, $4A, $CA, $2A, $AA, $6A, $EA, $1A, $9A, $5A, $DA, $3A, $BA, $7A, $FA,
          $06, $86, $46, $C6, $26, $A6, $66, $E6, $16, $96, $56, $D6, $36, $B6, $76, $F6,
          $0E, $8E, $4E, $CE, $2E, $AE, $6E, $EE, $1E, $9E, $5E, $DE, $3E, $BE, $7E, $FE,
          $01, $81, $41, $C1, $21, $A1, $61, $E1, $11, $91, $51, $D1, $31, $B1, $71, $F1,
          $09, $89, $49, $C9, $29, $A9, $69, $E9, $19, $99, $59, $D9, $39, $B9, $79, $F9,
          $05, $85, $45, $C5, $25, $A5, $65, $E5, $15, $95, $55, $D5, $35, $B5, $75, $F5,
          $0D, $8D, $4D, $CD, $2D, $AD, $6D, $ED, $1D, $9D, $5D, $DD, $3D, $BD, $7D, $FD,
          $03, $83, $43, $C3, $23, $A3, $63, $E3, $13, $93, $53, $D3, $33, $B3, $73, $F3,
          $0B, $8B, $4B, $CB, $2B, $AB, $6B, $EB, $1B, $9B, $5B, $DB, $3B, $BB, $7B, $FB,
          $07, $87, $47, $C7, $27, $A7, $67, $E7, $17, $97, $57, $D7, $37, $B7, $77, $F7,
          $0F, $8F, $4F, $CF, $2F, $AF, $6F, $EF, $1F, $9F, $5F, $DF, $3F, $BF, $7F, $FF);

begin
BitReversal := BitReverseCode[InByte];
end;



(**************************************************************************)
function strf (r: double; FieldWidth, DecP: integer): string;
(**************************************************************************
 ENTRY: r ............ number to convert to string
        FieldWidth ... width of output field
        DecP ......... number of decimal places,
                       if DecP = -1 then standard exponential notation
                       if DecP = -2 then exponent is shortened to 2 digits

 EXIT:  function returns a string of number 'r'
 **************************************************************************)

var
  hstr : string;
  i    : integer;

begin
if DecP = -2
  then begin
       str (r:FieldWidth+2:DecP,hstr);
       i := 2+pos ('E',hstr);
       if (length(hstr)-i = 3) then
         if (hstr[i]='0') and (hstr[i+1]='0')
           then delete (hstr,i,2)
           else begin
                delete (hstr,i,2);
                for i:=1 to length(hstr) do
                  hstr[i] := '*';
                end;
       end
  else str (r:FieldWidth:DecP,hstr);
strf := hstr;
end;

(**************************************************************************)
procedure ExChange (var x,y; size: word);
(**************************************************************************
  ENTRY:  x,y ..... any two equal sized variables
          size .... size of these variables
  EXIT:   x and y are exchanged
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




(******************************************************************)
function DecodeBit (ix: integer): byte;
(******************************************************************)

var
  Mask : byte;

begin
Mask := 0;
if ((ix >= 0) and (ix <= 7)) then
  begin
  Mask := 1;
  Mask := Mask shl ix;
  end;
DecodeBit := Mask;
end;


(******************************************************************)
function DecodeLong (ix: integer): longint;
(******************************************************************)

var
  Mask : longint;

begin
Mask := 0;
if ((ix >= 0) and (ix <= 31)) then
  begin
  Mask := 1;
  Mask := Mask shl ix;
  end;
DecodeLong := Mask;
end;

(******************************************************************)
function EncodeLong (value: longint): integer;
(******************************************************************)

var
  cnt: integer;

begin
cnt:= 0;
while ((value and $00000001) = 0) and (cnt < 31) do
  begin
  inc (cnt);
  value := value shr 1;
  end;
EncodeLong := cnt;
end;



(******************************************************************)
function CountBits (InByte: byte): integer;
(******************************************************************)

var
  Cnt   : integer;
  i     : integer;

begin
cnt := 0;
for i:=1 to 8 do
  begin
  if InByte and $01 = 1
    then inc (cnt);
  InByte := InByte shr 1;
  end;
CountBits := Cnt;
end;


(**************************************************************************)
function lg;                                 (* base 10 logarithm *)
(**************************************************************************)

begin
if x > 0.0
  then lg := ln(x)/ln10
  else begin
       lg := 0;
       EMathError.Create ('logarithm: invalid argument');
       end;
end;

(**************************************************************************)
function ld (x : double) : double;             (* base 2 logarithm *)
(**************************************************************************)

begin
if x > 0.0
  then ld := ln(x)/ln2
  else begin
       ld := 0;
       EMathError.Create ('logarithm: invalid argument');
       end;
end;


(**************************************************************************)
function sinh;                                         (* hyperbolic sine *)
(**************************************************************************)

begin
x := exp(x);
sinh := 0.5 * (x - 1/x);
end;


(**************************************************************************)
function cosh;                                       (* hyperbolic cosine *)
(**************************************************************************)

begin
x := exp(x);
cosh := 0.5 * (x + 1/x);
end;

(**************************************************************************)
function tgh;                                       (* hyperbolic tangens *)
(**************************************************************************)

begin
tgh := 1 - 2/(1+exp(2*x));
end;


(**************************************************************************)
function tg;                                                   (* tangens *)
(**************************************************************************)

var
  xcos : double;

begin
xcos := cos (x);
if xcos <> 0
  then tg := sin(x)/xcos
  else begin
       tg := 0;
       EMathError.Create ('tangens overflow');
       end;
end;

(**************************************************************************)
function cot;                                                (* cotangens *)
(**************************************************************************)

var
  xsin : double;

begin
xsin := sin (x);
if xsin <> 0
  then cot := cos(x)/xsin
  else begin
       cot := 0;
       EMathError.Create ('cotangens overflow');
       end;
end;


(**************************************************************************)
function MakeEFormat (x:double; W,D:integer): string;
(**************************************************************************
  ENTRY:    x .... real number to be formatted
            W .... width of output field (8..40)
            D .... number of decimal places (2..15)

  EXIT:     formatted numeric string
 **************************************************************************)

const
  {$IFOPT N+}
    NO = 0;
  {$ELSE}
    NO = 2;
  {$ENDIF}

var
  ex, i : integer;
  hstr1, hstr2 : string;

begin
if D < 2 then D:=2;
if D > 15 then D:=15;
if W < 8 then W := 8;
if W > 40 then W := 40;
str (x:D+8-NO,hstr1);
hstr2 := '';
hstr2 := hstr1[1]+'0.'+hstr1[2]+copy(hstr1,4,D);
ex := 10*(ord(hstr1[D+7-NO])-48)+ord(hstr1[D+8-NO])-48;
if hstr1[D+4] = '-' then ex := -ex;
if x <> 0 then
  inc (ex);
if (ex < 0)
  then hstr2 := hstr2 + '-'
  else hstr2 := hstr2 + '+';
str (abs(ex):2,hstr1);
if hstr1[1] = ' '
  then hstr2 := hstr2 + '0'
  else hstr2 := hstr2 + hstr1[1];
hstr2 := hstr2 + hstr1[2];
if W > length(Hstr2)
  then begin
       hstr1 := '';
       for i:=1 to W-length(hstr2) do
         hstr1 := hstr1 + ' ';
       hstr1 := hstr1 + hstr2;
       end
  else hstr1 := hstr2;
MakeEFormat := hstr1;
end;



(**************************************************************************)
function Decimal (InNum:longint; Places: byte): string;
(**************************************************************************
ENTRY: innum ..... integer number to be converted to decimal number
                   with leading zeros
       places .... number of digits to create

EXIT:  A string containing a decimal representation of innum with
       leading zeros is returned. The string is of length 'places'.
       If the decimal number has more digits than specified by
       'places' then the resulting string is truncated (only the
       'places' least significant digits are created
***************************************************************************)

var
  i      : word;
  NegSgn : boolean;
{$IFDEF VER80}
  astr   : string;
{$ELSE}
  astr   : ShortString;
{$ENDIF}


begin
NegSgn := false;
if innum < 0 then
  begin
  NegSgn := true;
  innum := -InNum;
  end;
if places < 1 then places := 1;
{$IFDEF VER80}
  astr[0] := chr(places);
{$ELSE}
  length (astr) := places;
{$ENDIF}
for i:=places downto 1 do
  begin
  astr[i] := chr(48+innum mod 10);
  innum := innum div 10;
  end;
if NegSgn then
  astr := '-'+astr;
Decimal := astr;
end;


(**************************************************************************)
function SortIntoArray (ArrayAdr: pointer; LengArray: longint;
                        TypArray: VarType;
                        value: pointer; Ascending: boolean;
                        Dublicates: boolean): longint;
(**************************************************************************
  ENTRY: ArrayAdr .... pointer to first element of array to be sorted
         LengArray ... number of elements to be considered
         TypArray .... type of array to be sorted
         value ....... address of element to be sorted in
         Ascending ... type of sorting (FALSE = descending, TRUE ascending)
         Dublicates .. TRUE if dublicates should be sorted into
         StrgLeng .... length of single string
  EXIT:  function return ... 0, if data not entered
                         ... >0 index of new element entered
 **************************************************************************)

{$R-}

type
  iarray = array[1..1] of integer;
  larray = array[1..1] of longint;
  rarray = array[1..1] of real;
  darray = array[1..1] of double;
  sarray = array[1..1] of single;

var
  i,j    : longint;
  reslt  : longint;


begin
reslt := 0;
if Ascending
  then begin
       case TypArray of
         inum : begin
                i := 0;
                repeat
                  inc (i);
                until ((iarray(ArrayAdr^)[i] >= integer(value^)) or
                       (i >= LengArray));
                if (iarray(ArrayAdr^)[i] <> integer(value^)) or dublicates then
                  if iarray(ArrayAdr^)[i] >= integer(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      iarray(ArrayAdr^)[j] := iarray(ArrayAdr^)[j-1];
                    iarray(ArrayAdr^)[i] := integer(value^);
                    reslt := i;
                    end;
                end;
         lnum : begin
                i := 0;
                repeat
                  inc (i);
                until ((larray(ArrayAdr^)[i] >= longint(value^)) or
                       (i >= LengArray));
                if (larray(ArrayAdr^)[i] <> longint(value^)) or dublicates then
                  if larray(ArrayAdr^)[i] >= longint(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      larray(ArrayAdr^)[j] := larray(ArrayAdr^)[j-1];
                    larray(ArrayAdr^)[i] := longint(value^);
                    reslt := i;
                    end;
                end;
         rnum : begin
                i := 0;
                repeat
                  inc (i);
                until ((rarray(ArrayAdr^)[i] >= real(value^)) or
                       (i >= LengArray));
                if (rarray(ArrayAdr^)[i] <> real(value^)) or dublicates then
                  if rarray(ArrayAdr^)[i] >= real(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      rarray(ArrayAdr^)[j] := rarray(ArrayAdr^)[j-1];
                    rarray(ArrayAdr^)[i] := real(value^);
                    reslt := i;
                    end;
                end;
         dnum : begin
                i := 0;
                repeat
                  inc (i);
                until ((darray(ArrayAdr^)[i] >= double(value^)) or
                       (i >= LengArray));
                if (darray(ArrayAdr^)[i] <> double(value^)) or dublicates then
                  if darray(ArrayAdr^)[i] >= double(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      darray(ArrayAdr^)[j] := darray(ArrayAdr^)[j-1];
                    darray(ArrayAdr^)[i] := double(value^);
                    reslt := i;
                    end;
                end;
         snum : begin
                i := 0;
                repeat
                  inc (i);
                until ((sarray(ArrayAdr^)[i] >= single(value^)) or
                       (i >= LengArray));
                if (sarray(ArrayAdr^)[i] <> single(value^)) or dublicates then
                  if sarray(ArrayAdr^)[i] >= single(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      sarray(ArrayAdr^)[j] := sarray(ArrayAdr^)[j-1];
                    sarray(ArrayAdr^)[i] := single(value^);
                    reslt := i;
                    end;
                end;
       end;
       end
  else begin
       case TypArray of
         inum : begin
                i := 0;
                repeat
                  inc (i);
                until ((iarray(ArrayAdr^)[i] <= integer(value^)) or
                       (i >= LengArray));
                if (iarray(ArrayAdr^)[i] <> integer(value^)) or dublicates then
                  if iarray(ArrayAdr^)[i] <= integer(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      iarray(ArrayAdr^)[j] := iarray(ArrayAdr^)[j-1];
                    iarray(ArrayAdr^)[i] := integer(value^);
                    reslt := i;
                    end;
                end;
         lnum : begin
                i := 0;
                repeat
                  inc (i);
                until ((larray(ArrayAdr^)[i] <= longint(value^)) or
                       (i >= LengArray));
                if (larray(ArrayAdr^)[i] <> longint(value^)) or dublicates then
                  if larray(ArrayAdr^)[i] <= longint(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      larray(ArrayAdr^)[j] := larray(ArrayAdr^)[j-1];
                    larray(ArrayAdr^)[i] := longint(value^);
                    reslt := i;
                    end;
                end;
         rnum : begin
                i := 0;
                repeat
                  inc (i);
                until ((rarray(ArrayAdr^)[i] <= real(value^)) or
                       (i >= LengArray));
                if (rarray(ArrayAdr^)[i] <> real(value^)) or dublicates then
                  if rarray(ArrayAdr^)[i] <= real(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      rarray(ArrayAdr^)[j] := rarray(ArrayAdr^)[j-1];
                    rarray(ArrayAdr^)[i] := real(value^);
                    reslt := i;
                    end;
                end;
         dnum : begin
                i := 0;
                repeat
                  inc (i);
                until ((darray(ArrayAdr^)[i] <= double(value^)) or
                       (i >= LengArray));
                if (darray(ArrayAdr^)[i] <> double(value^)) or dublicates then
                  if darray(ArrayAdr^)[i] <= double(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      darray(ArrayAdr^)[j] := darray(ArrayAdr^)[j-1];
                    darray(ArrayAdr^)[i] := double(value^);
                    reslt := i;
                    end;
                end;
         snum : begin
                i := 0;
                repeat
                  inc (i);
                until ((sarray(ArrayAdr^)[i] <= single(value^)) or
                       (i >= LengArray));
                if (sarray(ArrayAdr^)[i] <> single(value^)) or dublicates then
                  if sarray(ArrayAdr^)[i] <= single(value^) then
                    begin
                    for j := LengArray downto i+1 do
                      sarray(ArrayAdr^)[j] := sarray(ArrayAdr^)[j-1];
                    sarray(ArrayAdr^)[i] := single(value^);
                    reslt := i;
                    end;
                end;
       end;
       end;
SortIntoArray := reslt;
end;


(**************************************************************************)
procedure InsertIntoArray (ArrayAdr: pointer; LengArray: longint;
                TypArray: VarType; value: pointer; index: longint);
(**************************************************************************
  ENTRY: ArrayAdr .... pointer to first element of array to be sorted
         LengArray ... number of elements to be considered
         TypArray .... type of array to be sorted
         value ....... address of element to be sorted in
  EXIT:  'value' is inserted into array
 **************************************************************************)

{$R-}

type
  iarray = array[1..1] of integer;
  larray = array[1..1] of longint;
  rarray = array[1..1] of real;
  darray = array[1..1] of double;
  sarray = array[1..1] of single;

var
  j      : longint;

begin
if index <= LengArray then
  case TypArray of
         inum : begin
                for j := LengArray downto index+1 do
                  iarray(ArrayAdr^)[j] := iarray(ArrayAdr^)[j-1];
                iarray(ArrayAdr^)[index] := integer(value^);
                end;
         lnum : begin
                for j := LengArray downto index+1 do
                  larray(ArrayAdr^)[j] := larray(ArrayAdr^)[j-1];
                larray(ArrayAdr^)[index] := longint(value^);
                end;
         rnum : begin
                for j := LengArray downto index+1 do
                  rarray(ArrayAdr^)[j] := rarray(ArrayAdr^)[j-1];
                rarray(ArrayAdr^)[index] := real(value^);
                end;
         dnum : begin
                for j := LengArray downto index+1 do
                  darray(ArrayAdr^)[j] := darray(ArrayAdr^)[j-1];
                darray(ArrayAdr^)[index] := double(value^);
                end;
         snum : begin
                for j := LengArray downto index+1 do
                  sarray(ArrayAdr^)[j] := sarray(ArrayAdr^)[j-1];
                sarray(ArrayAdr^)[index] := single(value^);
                end;
  end;
end;


(**************************************************************************)
procedure SortArray (ArrayAdr: pointer; LengArray: longint;
                     TypArray: VarType; Ascending: boolean);
(**************************************************************************
  ENTRY: ArrayAdr .... pointer to first element of array to be sorted
         LengArray ... number of elements to be considered
         TypArray .... type of array to be sorted
         Ascending ... type of sorting (FALSE = descending, TRUE ascending)

  EXIT:  sorted array

  REMARK: algorithm used for sorting: modified bubble sort
 **************************************************************************)

{$R-}

const
  ShrinkFac = 1.3;

type
  iarray = array[1..1] of integer;
  larray = array[1..1] of longint;
  rarray = array[1..1] of real;
  darray = array[1..1] of double;
  sarray = array[1..1] of single;

var
  JumpWidth : longint;
  ix        : longint;
  Changed   : boolean;
  idummy    : integer;
  ldummy    : longint;
  rdummy    : real;
  ddummy    : double;
  sdummy    : single;

begin
if LengArray > 1 then
  begin
  JumpWidth := LengArray;
  if Ascending
    then begin
         case TypArray of
           inum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if iarray(ArrayAdr^)[ix] > iarray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        idummy := iarray(ArrayAdr^)[ix];
                        iarray(ArrayAdr^)[ix] := iarray(ArrayAdr^)[ix+JumpWidth];
                        iarray(ArrayAdr^)[ix+JumpWidth] := idummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           lnum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if larray(ArrayAdr^)[ix] > larray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        ldummy := larray(ArrayAdr^)[ix];
                        larray(ArrayAdr^)[ix] := larray(ArrayAdr^)[ix+JumpWidth];
                        larray(ArrayAdr^)[ix+JumpWidth] := ldummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           rnum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if rarray(ArrayAdr^)[ix] > rarray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        rdummy := rarray(ArrayAdr^)[ix];
                        rarray(ArrayAdr^)[ix] := rarray(ArrayAdr^)[ix+JumpWidth];
                        rarray(ArrayAdr^)[ix+JumpWidth] := rdummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           dnum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if darray(ArrayAdr^)[ix] > darray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        ddummy := darray(ArrayAdr^)[ix];
                        darray(ArrayAdr^)[ix] := darray(ArrayAdr^)[ix+JumpWidth];
                        darray(ArrayAdr^)[ix+JumpWidth] := ddummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           snum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if sarray(ArrayAdr^)[ix] > sarray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        sdummy := sarray(ArrayAdr^)[ix];
                        sarray(ArrayAdr^)[ix] := sarray(ArrayAdr^)[ix+JumpWidth];
                        sarray(ArrayAdr^)[ix+JumpWidth] := sdummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
         end;
         end
    else begin
         case TypArray of
           inum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if iarray(ArrayAdr^)[ix] < iarray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        idummy := iarray(ArrayAdr^)[ix];
                        iarray(ArrayAdr^)[ix] := iarray(ArrayAdr^)[ix+JumpWidth];
                        iarray(ArrayAdr^)[ix+JumpWidth] := idummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           lnum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if larray(ArrayAdr^)[ix] < larray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        ldummy := larray(ArrayAdr^)[ix];
                        larray(ArrayAdr^)[ix] := larray(ArrayAdr^)[ix+JumpWidth];
                        larray(ArrayAdr^)[ix+JumpWidth] := ldummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           rnum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if rarray(ArrayAdr^)[ix] < rarray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        rdummy := rarray(ArrayAdr^)[ix];
                        rarray(ArrayAdr^)[ix] := rarray(ArrayAdr^)[ix+JumpWidth];
                        rarray(ArrayAdr^)[ix+JumpWidth] := rdummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           dnum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if darray(ArrayAdr^)[ix] < darray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        ddummy := darray(ArrayAdr^)[ix];
                        darray(ArrayAdr^)[ix] := darray(ArrayAdr^)[ix+JumpWidth];
                        darray(ArrayAdr^)[ix+JumpWidth] := ddummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
           snum : begin
                  repeat
                    JumpWidth := trunc(JumpWidth/ShrinkFac);
                    if JumpWidth = 0 then
                      JumpWidth := 1;
                    ix := 1;
                    Changed := False;
                    repeat
                      if sarray(ArrayAdr^)[ix] < sarray(ArrayAdr^)[ix+JumpWidth] then
                        begin
                        sdummy := sarray(ArrayAdr^)[ix];
                        sarray(ArrayAdr^)[ix] := sarray(ArrayAdr^)[ix+JumpWidth];
                        sarray(ArrayAdr^)[ix+JumpWidth] := sdummy;
                        Changed := True;
                        end;
                      inc (ix);
                    until (ix+JumpWidth > LengArray);
                  inc (ProcStat);
                  if addr(MathFeedBackProc) <> NIL then
                    MathFeedBackProc (ProcStat);
                  until ((JumpWidth = 1) and not Changed);
                  end;
         end;
         end;
  end;
end;


(**************************************************************************)
function Min (a,b: double): double;
(**************************************************************************)

begin
if a <= b
  then Min := a
  else Min := b;
end;


(**************************************************************************)
function Max (a,b: double): double;
(**************************************************************************)

begin
if a >= b
  then Max := a
  else Max := b;
end;



(**************************************************************************)
function Sign (a: double): integer;
(**************************************************************************)

begin
if a < 0
  then Sign := -1
  else Sign := 1;
end;


(**************************************************************************)
function  BRandom (p: double): boolean;{ TRUE with probability p }
(**************************************************************************)

var
  reslt  : boolean;

begin
reslt := FALSE;
if p >= 1.0
  then reslt := TRUE
  else if random < p then
         reslt := TRUE;
BRandom := reslt;
end;

(**************************************************************************)
function  GRandom: double;
(**************************************************************************)

var
  a,R,f1,f2  : double;

begin
if GaussRndFlag
  then begin
       GaussRndFlag := False;
       GRandom := GaussRNum;
       end
  else begin
       GaussRndFlag := True;
       repeat
         f1 := 2.0*random-1.0;
         f2 := 2.0*random-1.0;
         R := sqr(f1)+sqr(f2);
       until (R < 1);
       a := sqrt(-2*ln(r)/r);
       GRandom := f2 * a;
       GaussRNum := f1 * a;
       end;
end;


(**************************************************************************)
function LongRand (seed: longint): double;
(**************************************************************************
 ENTRY: seed ......... if 'seed' is not equal zero the random generator
                       is initialised using the value of 'seed'

 EXIT:  function returns a random number in the interval [0.0,1.0]

 REMARK: this random generator is based on three LCGs (linear congruential
         generators). The basic primes are selected such that the
         resulting periods of the pseudo random sequences have only
         2 as a common factor. Thus it is assured that the lenght of
         the period of the combined pseudo random sequence is about
         3.47E17.
 **************************************************************************)


var
  rdummy   : double;

begin
if seed <> 0 then
  begin
  seed := seed mod 990923;
  RandA := abs (seed);
  RandB := abs ((seed shl 8) xor seed) mod 990923;
  RandC := abs ((seed shl 16) xor seed) mod 990923;
  end;
RandA := (1187 * RandA) mod 1001003;
RandB := (983 * RandB) mod 990923;
RandC := (1283 * RandC) mod 1400423;

rdummy := RandA/1001003.0 + RandB/990923.0 + RandC/1400423.0;
LongRand := rdummy - trunc(rdummy);
end;


(**************************************************************************)
function WithinBounds (Inval, Boundary1, Boundary2: double): boolean;
(**************************************************************************
  ENTRY:  Inval ....... value to be compared
          Boundary1 ... lower boundary of interval
          Boundary2 ... upper boundary of interval

  EXIT:   function returns TRUE if Boundary1 >= Inval >= Boundary2

  REMARK: boundaries may be shuffled without any effect on result
 **************************************************************************)

begin
if Boundary1 > Boundary2
  then Exchange (Boundary1,Boundary2,sizeof(Boundary1));
if (Inval >= Boundary1) and (InVal <= Boundary2)
  then WithinBounds := TRUE
  else WithinBounds := FALSE;
end;



(******************************************************************)
function IntPos (InNum: double): longint;
(******************************************************************
  ENTRY:  InNum ...... number to process

  EXIT:   function returns next integer value which is greater or
          equal to 'InNum'
*******************************************************************)

var
  aux : longint;

begin
aux := round(InNum);
if aux < InNum then
  inc (aux);
IntPos := aux;
end;


(******************************************************************)
function IntNeg (InNum: double): longint;
(******************************************************************
  ENTRY:  InNum ...... number to process

  EXIT:   function returns next integer value which is smaller or
          equal to 'InNum'
*******************************************************************)

var
  aux : longint;

begin
aux := round(InNum);
if aux > InNum then
  dec (aux);
IntNeg := aux;
end;


(******************************************************************)
function GrayCode (InNum: word): word;
(******************************************************************
  ENTRY:  InNum .... number to be converted

  EXIT:   function return 16-Bit Gray code of 'InNum'
 ******************************************************************)

var
  GrayC   : word;
  BitMask : word;
  i       : integer;
  LastBit : word;
  NextBit : word;

begin
BitMask := $8000;
LastBit := InNum and Bitmask;
GrayC := LastBit;
for i:=1 to 15 do
  begin
  BitMask := BitMask shr 1;
  NextBit := InNum and Bitmask;
  if ((LastBit shr 1) xor NextBit) <> 0 then
    GrayC := GrayC or BitMask;
  LastBit := NextBit;
  end;
GrayCode := GrayC;
end;


(*********************************************************)
constructor TRandGen.Create;
(*********************************************************)

var
  i : integer;

begin
inherited Create;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
FResolution := 500;
GetMem (FDistVec, FResolution*SizeOf(double));
if (FDistVec = NIL)
  then raise ESDLMath1Error.Create ('not enough memory on heap')
  else begin
       for i:=1 to FResolution do
         Array1D(FDistVec^)[i] := 1.0;
       end;
end;



(*********************************************************)
destructor TRandGen.Destroy;
(*********************************************************)

begin
if FDistVec <> NIL then
  FreeMem (FDistVec, FResolution*SizeOf(double));
FDistVec := NIL;
inherited Destroy;
end;


(*********************************************************)
procedure TRandGen.SetResolution (res: integer);
(*********************************************************
  ENTRY: res .......... number of classes in histogram
  EXIT:  procedure sets size of histogram. 'res' may take any
         values between 10 and 4000.
 *********************************************************)


var
  i : integer;

begin
if res < 10 then
  res := 10;
if res > 4000 then
  res := 4000;
FreeMem (FDistVec, FResolution*SizeOf(double));  (* dispose and setup new vector *)
GetMem (FDistVec, res*SizeOf(double));
if FDistVec = NIL
  then raise ESDLMath1Error.Create ('not enough memory')
  else begin
       FResolution := res;
       for i:=1 to res do
         Array1D(FDistVec^)[i] := 1.0;
       end;
end;


(*********************************************************)
function TRandGen.GetProbability (Idx: integer): double;
(*********************************************************)

begin
if (FDistVec <> NIL) and
   (Idx >= 1) and (Idx <= FResolution)
  then GetProbability := Array1D(FDistVec^)[Idx]
  else GetProbability := 0;
end;

(*********************************************************)
procedure TRandGen.SetProbability (Idx: integer; value: double);
(*********************************************************)

begin
if value < 0 then
  value := 0;
if value > 1.0 then
  value := 1.0;
if (FDistVec <> NIL) and
   (Idx >= 1) and (Idx <= FResolution)
  then Array1D(FDistVec^)[Idx] := value;
end;

(*********************************************************)
function TRandGen.GetLambda (ix: integer): double;
(*********************************************************)

begin
if (ix < 1)
  then GetLambda := FLowBorder
  else if (ix > FResolution)
         then GetLambda := FHighBorder
         else GetLambda := LowBorder + (ix-1)*(FHighBorder-FLowBorder)/FResolution;
end;

(*********************************************************)
function TRandGen.IndexOfLambda (Lambda: double): integer;
(*********************************************************)

begin
if Lambda < FLowBorder
  then IndexOfLambda := 0
  else if Lambda > FHighBorder
         then IndexOfLambda := FResolution+1
         else IndexOfLambda := 1+IntNeg((Lambda-FLowBorder)*FResolution/(FHighBorder-FLowBorder));
end;


(*********************************************************)
function TRandGen.GetRandNum: double;
(*********************************************************)

var
  dx, p : double;
  ix    : integer;
  found : boolean;

begin
found := false;
repeat
  ix := 1+System.random (FResolution);
  dx := System.random;
  if ix = FResolution
    then p := Array1D(FDistVec^)[ix]*(1-dx)
    else p := Array1D(FDistVec^)[ix] + dx*(Array1D(FDistVec^)[ix+1]-Array1D(FDistVec^)[ix]);
  if p >= 1.0
    then found := TRUE
    else if System.random < p then
           found := TRUE;
until found;
GetRandNum := FLowBorder + (ix+dx-1)*(FHighBorder-FLowBorder)/Resolution;
end;

(*********************************************************)
procedure TRandGen.Normalize;
(*********************************************************)

var
  i    : integer;
  maxi : double;
  mini : double;

begin
maxi := -MaxReal;
mini := MaxReal;
for i:=1 to FResolution do
  begin
  if Array1D(FDistVec^)[i] > Maxi then
    Maxi := Array1D(FDistVec^)[i];
  if Array1D(FDistVec^)[i] < Mini then
    Mini := Array1D(FDistVec^)[i];
  end;
if (maxi <> mini) then
  begin
  for i:=1 to FResolution do
    Array1D(FDistVec^)[i] := (Array1D(FDistVec^)[i]-Mini)/(maxi-mini);
  end;
end;


(*********************************************************)
procedure TRandGen.NormalDistri (m, s: double);
(*********************************************************)

var
  i    : integer;
  x    : double;

begin
for i:=1 to FResolution do
  begin
  x := LowBorder + (i-1)*(FHighBorder-FLowBorder)/FResolution;
  Array1D(FDistVec^)[i] := exp(-sqr(x-m)/2/sqr(s));
  end;
end;

(*********************************************************)
procedure TRandGen.WeibullDistri (alpha, beta: double);
(*********************************************************)

var
  i    : integer;
  x    : double;

begin
for i:=1 to FResolution do
  begin
  x := LowBorder + (i-1)*(FHighBorder-FLowBorder)/FResolution;
  Array1D(FDistVec^)[i] := WeibullDensity (x, alpha, beta);
  end;
end;


(*********************************************************)
procedure TRandGen.UniformDistri;
(*********************************************************)

var
  i    : integer;

begin
for i:=1 to FResolution do
  Array1D(FDistVec^)[i] := 1.0;
end;

(******************************************************************************)
function StrToIntDefault (InStr: string; Def: integer): integer;
(******************************************************************************)

begin
if InStr = ''       // this is to make debugging less cumbersome (avoid exceptions)
  then result := Def
  else begin
       try
         result := StrToInt (InStr);
       except
         result := Def;
       end;
       end;
end;


(**************************************************************************)
(*                              INIT                                      *)
(**************************************************************************)

begin
AbortMathProc := false;
GaussRndFlag := False;
RandA := round(990000*random);
RandB := round(990000*random);
RandC := round(990000*random);
MathFeedBackProc := NIL;
ProcStat := 0;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Halt;
  end;
{$ENDIF}
end.


