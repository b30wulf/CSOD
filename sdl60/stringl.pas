unit stringl;

(******************************************************************)
(*                                                                *)
(*                          S T R I N G L                         *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1998..2001 H. Lohninger                 Jan.  1997     *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-12, 2001                                  *)
(*                                                                *)
(******************************************************************)

{
Revision history
================

1.0   [Feb-13, 1998]
      first release to the public

1.1   [Apr-07, 1998]
      version for C++Builder 3.0
      ReplaceStringInString implemented
      EnsureTrailingBkSlash implemented

1.2   [Aug-15, 1998]
      Stringl now available for Delphi 4.0
      scramble routines implemented
      UUEncode/UUDecode implemented
      TGrep: properties MatchEndPos and MatchStartPos implemented
      FormatData implemented

1.3   [Mar-23, 1999]
      new function BoolToStr implemented
      help file improved (EnsureTrailingChar was missing)

5.0   [Oct-09, 1999]
      STRINGL is now part of the SDL component suite 5.0
      STRINGL available for Delphi 5.0
      ExtractFromStream implemented
      bug fix in StripLTBlanks: string filled entirely with spaces is now
          correctly reduced to empty string
      bug fix in TGrep: "." (any character) is now handled correctly

5.5   [May-01, 2000]
      bug fix in ExtractFromStream: loop did not finish when cursor met endpos
      ExtractFromStream: "insertbyte" and "convertbyte" implemented
      CountCharInString implemented
      RemoveControlChars implemented
      available for C++Builder 5.0

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      ExtractFromStream has been moved to new unit "Streams"
      TGrep supports now search starting position (property SearchStartPos)
      posLast implemented
      ReadLnString implemented
      TGrep now treats '.*' as special case and returns always true, even if string is empty
      NumberedPos and ReplaceStringInString now allow to ignore cases
      ReduceStringToAZ09 implemented
      StringIx implemented
      strff extended: leading blanks are filled by zeroes if parameter FieldWidth is negative
      StripLieadingBlanks and StripTrailingBlanks implemented
      regular expression in TGrep may now contain any character - even non-printable ones (command '\#xx')
}


{$O+}
{$F+}

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
  classes;

const
  MaxGrepTokens = 64;

type
  TCharArr256 = array[0..255] of char;
  {$IFDEF VER80}
    ShortStr = string;
  {$ELSE}
    ShortStr = ShortString;
  {$ENDIF}
  TGrepTokenAct = (taNormal,    {  normal character to be matched }
                   taAnyByte,   {  '.'   - skip this character    }
                   taEol,       {  '$'   - end of line            }
                   taBol,       {  '^'   - beginning of line      }
                   taSet,       {  '[]'  - set of characters      }
                   taMult0,     {  '*' - multiplier, including 0: any number of this character allowed }
                   taMult1,     {  '+' - multiplier, excluding 0: at least 1 occurrence of this character required }
                   taOpti);     {  '?' - this character can occur optionally }
  TGrepToken = record
                 Action   : TGrepTokenAct;
                 NumChars : integer;
                 Params   : TCharArr256;
                 ValidFrom: integer;
               end;
     {
     List of actions and their parameters:

     Action    NumChars   Params
     ----------------------------------------------------
     taNormal   #chars    list of NumChars characters
     taAnybyte    --       --
     taEol        --       --
     taBol        --       --
     taSet        --      set of characters (boolean array: TRUE for members of set)
     taMult0    #chars    #chars > 0: list of NumChars to be matched
                          #chars = 0: anychar to be matched
                          #chars < 0: set to be matched
     taMult1    #chars    #chars > 0: list of NumChars to be matched
                          #chars = 0: anychar to be matched
                          #chars < 0: set to be matched
     taOpti     #chars    #chars > 0: list of NumChars to be matched
                          #chars = 0: anychar to be matched
                          #chars < 0: set to be matched
     }

  TRegExp = array[1..MaxGrepTokens] of TGrepToken;
  TGrep = class (TObject)
          private
            FLengRegExp   : integer;        { no. of tokens in reg. expr. }
            FStopOnError  : boolean;     { TRUE: raise exception on error }
            FregExp       : TRegExp;          { regular expression tokens }
            FRegExpStr    : string;            { original reg.exp. string }
            FIgnoreCase   : boolean;    { TRUE: ignore case during search }
            FError        : integer;       { error number - see SetRegExp }
            FMatchEndPos  : integer; { last matched position in search string }
            FMatchStartPos: integer; { first matched position in search string }
            FSrcStartPos  : integer; { starting position where to start matching }
            function  CompileRegExp (regexp: string): integer;
            procedure SetRegExp (regexp: string);
            procedure SetIgnoreCase (ic: boolean);
            function  GetRegExpToken (regix: integer): TGrepToken;
          public
            constructor Create;
            destructor  Destroy; override;
            procedure PrintRegExp (FName: string);
            property  RegExp: string read FRegExpStr write SetRegExp;
            property  IgnoreCase: boolean read FIgnoreCase write SetIgnoreCase;
            function  MatchString (Instring: string; var MatchPos: integer): boolean;
            property  RegExpToken [regix: integer]: TGrepToken read GetRegExpToken;
            property  MatchEndPos: integer read FMatchEndPos;
            property  MatchStartPos: integer read FMatchStartPos;
            property  NrOfRegExpTokens: integer read FLengRegExp;
            property  SearchStartPos: integer read FSrcStartPos write FSrcStartPos;
            property  StopOnError: boolean read FStopOnError write FStopOnError;
            property  LastError: integer read FError;
          end;


{procedures and functions}
  function  AbbrevString
           (Instring : string;                  { string to be abbreviated }
               width : integer)                            { maximum width }
                     : string;                        { abbreviated string }
  function  BoolToStr
              (ABool : boolean;                           { input variable }
              Format : integer)                         { format of output }
                     : string;                          { formatted string }
  function  CountCharInString
                 (cc : char;                     { character to be counted }
            Instring : string;                     { string to be analyzed }
       CaseSensitive : boolean)           { TRUE: search is case sensitive }
                     : integer;                  { count of cc in InString }
  function  CenterString
           (Instring : string;                          { string to center }
               Width : byte)                             { width of result }
                     : string;                           { centered string }
  function  DeScramble
           (Instring : string)                    { string to be scrambled }
                     : string;
  function  EnsureTrailingBkSlash
           (instring : string)                    { string to be processed }
                     : string;
  function  EnsureTrailingChar
                 (cc : char;                      { character to be forced }
            instring : string)                    { string to be processed }
                     : string;
  function  ExpandDiphtongs
               (line : string)                                { any string }
                     : string;                      { diphtongs --> vowels }
  function  FormatData
               (data : double;                      { data to be formatted }
            NumWidth : integer;                { width of resulting string }
               NDecP : integer)                 { number of decimal places }
                     : string;                          { resulting string }
  procedure InitScramble
                (Key : longint);                      { key for scrambling }
  function  LeftString
           (Instring : string;                              { input string }
               Width : byte)                             { witdh of result }
                     : string;                      { left adjusted string }
  function  MultiChar
                 (cc : char;                                   { character }
              RepCnt : integer)                    { number of repetitions }
                     : string;                  { string with RepCnt chars }
  function  NumberedPos
             (SubStr,                      { sub string to be searched for }
             MainStr : string;                  { string to be searched in }
             StartIx,             { index of MainStr where to start search }
               Count : integer;   { count of occurence when to stop search }
          IgnoreCase : boolean)  { TRUE: ignore case of SubStr and MainStr }
                     : integer;
  function  OEMString
           (Instring : ShortStr)    { input string with ANSI character set }
                     : ShortStr;    { output string with IBM character set }
  function  PosLast
             (SubStr : string;              { substring to be searched for }
            Instring : string)                  { string to be searched in }
                     : integer;             { index where substring starts }
  function ReadLnString
           (Instring : string;                         { string to be read }
        var StartPos : integer;                 { starting/ending position }
             var eos : boolean;          { TRUE: end of string encountered }
             EOLMode : integer)          { mode of end-of-line recognition }
                     : string;         { partial string read from Instring }
  function ReduceStringToAZ09
           (InString : string)                    { string to be processed }
                     : string;      { string containing only a..z and 0..9 }
  function RemoveCharInString
           (Instring : string;                    { string to be processed }
        CharToRemove : char)         { character to be removed from string }
                     : string;                          { resulting string }
  function  ReplaceCharInString
           (Instring : string;                    { string to be processed }
             OldChar : char;                               { old character }
             NewChar : char)                               { new character }
                     : string;                          { resulting string }
  function  ReplaceStringInString
           (Instring : string;                    { string to be processed }
              OldStr : string;                  { substring to be replaced }
              NewStr : string;                             { new substring }
          IgnoreCase : boolean)            { ignore case in search if TRUE }
                     : string;                          { resulting string }
  function  RightString
           (Instring : string;                              { input string }
               Width : byte)                             { width of result }
                     : string;                      { right aligned string }
  function  Scramble
           (Instring : string)                    { string to be scrambled }
                     : string;                          { scrambled string }
  function StringIx
           (InString : string;                         { string to matched }
              SArray : array of string)   { string array of valid keywords }
                     : integer;                 { index of matched keyword }
  function  StripLeadingBlanks
           (Instring : string)                              { input string }
                     : string;             { string without leading blanks }
  function  StripLTBlanks
           (Instring : string)                              { input string }
                     : string;    { string without leading/trailing blanks }
  function  StripTrailingBlanks
           (Instring : string)                              { input string }
                     : string;            { string without trailing blanks }
  function  RemoveControlChars
           (Instring : string)                              { input string }
                     : string;                     { no control characters }
  function  strff
                   (r : extended;                      { number to convert }
           FieldWidth : integer;                   { width of output field }
                 DecP : integer)                   { number of dec. places }
                      : string;                         { formatted string }
  function  TestAllChar
              (Instr : string;                       { string to be tested }
                  cc : char)                    { character to be searched }
                     : boolean;                   { TRUE, if string=all cc }
  function  TimeString
               (Time : double;                               { time in sec }
                 Fmt : byte)                        { format specification }
                     : string;                               { time string }
  function  UUEncodeStr
           (Instring : string)                   { string to be UU encoded }
                     : string;                         { UU encoded string }
  function  UUDecodeStr
           (Instring : string)                   { string to be UU decoded }
                     : string;                         { UU encoded string }
  function  WinAnsiString
           (Instring : ShortStr)     { input string with IBM character set }
                     : ShortStr;   { output string with ANSI character set }



{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

uses
  sysutils, WinProcs, Wintypes {$IFDEF SHAREWARE}, dialogs {$ENDIF};

type
  ESDLTGrepError = class(Exception);     { exception type to indicate errors }

var
  ScrambleBuf   : array[0..255] of byte;
  UnScrambleBuf : array[0..255] of byte;

{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\stringl_ct.inc}
{$ENDIF}

{$I strff.inc}
{$I replchar.inc}
{$I stripblk.inc}
{$I SCANDEC.INC}
{$I scanhex.INC}
{$I frmtdata.INC}


(******************************************************************)
function StripTrailingBlanks (Instring: string): string;
(******************************************************************
ENTRY: Instring ... string to be processed

EXIT:  Function returns the string 'Instring' which has stripped the
       trailing blanks off.
*******************************************************************)

var
  hstr : string;
  k    : integer;

begin
hstr := '';
if length(Instring) > 0 then
  begin
  k := length(Instring);
  while (k > 1) and (Instring[k] = ' ') do
    dec (k);
  hstr := copy (Instring,1,k);
  end;
StripTrailingBlanks := hstr;
end;

(******************************************************************)
function StripLeadingBlanks (Instring: string): string;
(******************************************************************
ENTRY: Instring ... string to be processed

EXIT:  Function returns the string 'Instring' which has stripped the
       leading blanks off.
*******************************************************************)

var
  hstr : string;
  i    : integer;

begin
hstr := '';
if length(Instring) > 0 then
  begin
  i := 1;
  while (i < length(Instring)) and (Instring[i] = ' ') do
    inc (i);
  hstr := copy (Instring,i,length(Instring)-i+1);
  end;
StripLeadingBlanks := hstr;
end;


(**************************************************************************)
function CountCharInString (cc: char; Instring: string; CaseSensitive: boolean): integer;
(**************************************************************************
  ENTRY: cc ............... character to be counted
         Instring ......... string to be analyzed
         CaseSensitive .... TRUE: search is case sensitive

  EXIT:  function return count of cc in InString
 **************************************************************************)

var
  i : integer;

begin
result := 0;
if not CaseSensitive then
  begin
  InString := uppercase(Instring);
  cc := upcase (cc);
  end;
for i:=1 to length(Instring) do
  if InString[i] = cc then
    inc (Result);
end;


(**************************************************************************)
function StringIx (InString: string; SArray: array of string): integer;
(**************************************************************************
  ENTRY:   InString ..... string to be matched
           SArray ....... array of possible strings

  EXIT:    function returns the index of the string of the array SArray
           matching the string InString (first element has index 1). A zero
           value is returned if Instring does not match any of the strings in
           SArray.
 **************************************************************************)

var
  ix    : integer;
  found : boolean;

begin
found := false;
ix := -1;
while not found and (ix < high(SArray)) do
  begin
  inc(ix);
  if (SArray[ix] = Instring) then
    found := true;
  end;
if found
  then result := ix+1
  else result := 0;
end;


(**************************************************************************)
function  RemoveControlChars (Instring: string): string;
(**************************************************************************
  ENTRY: Instring .... string to be processed

  EXIT:  returns the string Instring with any characters below ASCII 32 (control
         characters) removed
 **************************************************************************)

var
   i : integer;

begin
i := 1;
while i <= length(InString) do
  begin
  if ord(Instring[i]) < 32
    then delete (Instring, i, 1)
    else inc(i);
  end;
RemoveControlChars := Instring;
end;



(**************************************************************************)
function PosLast (SubStr, Instring: string): integer;
(******************************************************************
  ENTRY:  Substr ..... sub string to be searched for
          InString ... string to be searched in

  EXIT:   function returns 0 if Substr is not contained Instring
 ******************************************************************)

var
  ix     : integer;

begin
result := 0;
ix := 1;
while (ix > 0) do
  begin
  ix := pos (SubStr, InString);
  result := result + ix;
  delete (InString, 1, ix+length(SubStr)-1);
  end;
end;

(**************************************************************************)
function EnsureTrailingBkSlash (instring: string): string;
(**************************************************************************
 ENTRY:  instring .... any string
 EXIT:   function returns instring with at least one trailing backslash
 **************************************************************************)

 begin
if length(instring) > 0 then
  if instring[length(instring)] <> '\' then
    instring := instring + '\';
EnsureTrailingBkSlash := instring;
end;


(**************************************************************************)
function EnsureTrailingChar (cc: char; instring: string): string;
(**************************************************************************
 ENTRY:  instring .... any string
         cc .......... character to be at end of string
 EXIT:   function returns instring with at least one character cc
 **************************************************************************)

 begin
if length(instring) > 0 then
  if instring[length(instring)] <> cc then
    instring := instring + cc;
EnsureTrailingChar := instring;
end;


(******************************************************************)
function BoolToStr (ABool: boolean; Format: integer): string;
(******************************************************************)

var
  reslt : string;

begin
case Format of
  0 : if ABool
        then reslt := 'TRUE'
        else reslt := 'FALSE';
  1 : if ABool
        then reslt := 'T'
        else reslt := 'F';
  2 : if ABool
        then reslt := '.T.'
        else reslt := '.F.';
  3 : if ABool
        then reslt := '1'
        else reslt := '0';
  4 : if ABool
        then reslt := '-1'
        else reslt := '0';
  5 : if ABool
        then reslt := 'FF'
        else reslt := '00';
else if ABool
       then reslt := 'TRUE'
       else reslt := 'FALSE';
end;
BoolToStr := reslt;
end;


(******************************************************************)
function MakeTimeStr (hour,minute,second,sec100: word; fmt: byte): string;
(******************************************************************)

var
  hstr   : string;
  hstr1  : string;
  AMPM   : char;

begin
hstr := '';
case Fmt of
  0  : begin
       str (hour:2,hstr);
       if hstr[1] = ' ' then
         hstr[1] := '0';
       str (minute:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + ':'+hstr1;
       str (second:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + ':' + hstr1;
       str (sec100:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + '.'+hstr1;
       end;
  1  : begin
       str (hour:2,hstr);
       if hstr[1] = ' ' then
         hstr[1] := '0';
       str (minute:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + ':'+hstr1;
       str (second:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + ':' + hstr1;
       end;
  2  : begin
       str (hour:2,hstr);
       str (minute:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + 'h'+hstr1;
       end;
  3  : begin
       str (hour:2,hstr);
       str (minute:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + 'h'+hstr1+'''';
       str (second:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + hstr1 + '"';
       end;
  4  : begin
       str (hour:2,hstr);
       if hstr[1] = ' ' then
         hstr[1] := '0';
       str (minute:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + ':'+hstr1;
       end;
  5  : begin
       if hour < 12
         then AMPM := 'a'
         else AMPM := 'p';
       if hour = 0 then
         hour := 12;
       if hour > 12 then
         hour := hour-12;
       str (hour:2,hstr);
       str (minute:2,hstr1);
       if hstr1[1] = ' ' then
         hstr1[1] := '0';
       hstr := hstr + ':'+hstr1+AMPM;
       end;
end;
MakeTimeStr := hstr;
end;

(******************************************************************)
function MultiChar (cc: char; RepCnt: integer): string;
 (******************************************************************
 ENTRY: cc ........ character to be repeated
        RepCnt .... repetition count

 EXIT:  function returns string of 'RepCnt' characters 'cc'
 ******************************************************************)



var
  i    : integer;
  hstr : string;

begin
if RepCnt > 255 then
  RepCnt := 255;
if RepCnt < 1 then
  RepCnt := 1;
Hstr := '';
for i:=1 to RepCnt do
  hstr := hstr + cc;
MultiChar := hstr;
end;




(******************************************************************)
function CenterString (Instring: string; Width: byte): string;
(******************************************************************
  ENTRY:   Instring ... string to be centered
           Width ...... width of resulting string
  EXIT:    string is centered within 'Width'
 ******************************************************************)

var
  i,l,k : integer;
  hstr  : string;

begin
if length(Instring) >= width
  then CenterString := copy (Instring,1,width)
  else begin
       hstr := '';
       k := width-length(Instring);
       l := k div 2;
       for i:=1 to l do
         hstr := hstr + ' ';
       hstr := hstr + Instring;
       for i:=1 to k-l do
         hstr := hstr + ' ';
       CenterString := hstr;
       end;
end;

(******************************************************************)
function RightString (Instring: string; Width: byte): string;
(******************************************************************
  ENTRY:   Instring ... string to be right adjusted
           Width ...... width of resulting string
  EXIT:    string is right adjusted within 'Width'
 ******************************************************************)

var
  i,k   : integer;
  hstr  : string;

begin
if length(Instring) >= width
  then RightString := copy (Instring,1,width)
  else begin
       hstr := '';
       k := width-length(Instring);
       for i:=1 to k do
         hstr := hstr + ' ';
       RightString := hstr + Instring;
       end;
end;

(******************************************************************)
function LeftString (Instring: string; Width: byte): string;
(******************************************************************
  ENTRY:   Instring ... string to be left justified
           Width ...... width of resulting string
  EXIT:    string is left adjusted within 'Width'
 ******************************************************************)

var
  i,k   : integer;
  hstr  : string;

begin
if length(Instring) >= width
  then LeftString := copy (Instring,1,width)
  else begin
       hstr := Instring;
       k := width-length(Instring);
       for i:=1 to k do
         hstr := hstr + ' ';
       LeftString := hstr;
       end;
end;



(******************************************************************)
function RemoveCharInString (Instring: string; CharToRemove: char): string;
(******************************************************************
  ENTRY:   Instring ...... string to be processed
           CharToRemove .. character to be removed
  EXIT:    string has all characters 'CharToRemove' removed
 ******************************************************************)

var
  i     : integer;
  bstr  : string;

begin
bstr := '';
for i:=1 to length(Instring) do
  begin
  if Instring[i] <> CharToRemove then
    bstr := bstr + Instring[i];
  end;
RemoveCharInString := bstr;
end;



(**************************************************************************)
  function AbbrevString (Instring: string; width: integer): string;
(**************************************************************************
  ENTRY: Instring .... string to be abbreviated
         width ....... maximum width

  EXIT:  abbreviated string
 **************************************************************************)

begin
if length(Instring) > width
  then AbbrevString := copy(Instring,1,width-2)+'..'
  else AbbrevString := Instring;
end;

(******************************************************************)
function TimeString (Time: double; Fmt: byte): string;
(******************************************************************
ENTRY: time ...... floating point number holding seconds
       fmt ....... format of resulting time string

EXIT:  Time is returned as string in on of the following formats

               Fmt       Format         Example
               -------------------------------------
                0       HH:MM:SS.ss     16:04:12.44
                1         HH:MM:SS       16:04:12
                2         HHhMM            16h04
                3       HHhMM'SS"        16h04'12"
                4         HH:MM            16:04
*******************************************************************)

var
  hours    : word;
  minutes  : word;
  seconds  : word;
  sec100   : word;

begin
if time < 0 then
  time := 0;
hours   := trunc (time/3600);
minutes := trunc ((time-3600.0*hours)/60);
seconds := trunc (time-3600.0*hours-minutes*60);
sec100  := trunc (100*frac(time));
TimeString := MakeTimeStr (hours, minutes, seconds, sec100, fmt);
end;


(******************************************************************)
function  TestAllChar (Instr: string; cc: char): boolean;
(******************************************************************
  ENTRY:  Instr  .... string to be tested
          cc ........ character to be searched for

  EXIT:   function returns TRUE if all characters of the string 'Instr'
          equal 'cc'. Empty strings result in a FALSE value.
 ******************************************************************)

var
  reslt  : boolean;
  i      : integer;

begin
if length(Instr) = 0
  then reslt := false
  else begin
       reslt := true;
       i := 0;
       repeat
         inc (i);
       until ((Instr[i] <> cc) or (i=length(Instr)));
       if Instr[i] <> cc then
         reslt := false;
       end;
TestAllChar := reslt;
end;


(**************************************************************)
function ExpandDiphtongs (line: string): string;
(**************************************************************)

var
  i : integer;

begin
i := 1;
while (i <= length(line)) do
  begin
  case line[i] of
      'ä'  : begin
             line[i] := 'a';
             insert ('e',line,i+1);
             end;
      'ü'  : begin
             line[i] := 'u';
             insert ('e',line,i+1);
             end;
      'ö'  : begin
             line[i] := 'o';
             insert ('e',line,i+1);
             end;
      'Ä'  : begin
             line[i] := 'A';
             if i = length(line)
               then insert ('E',line,i+1)
               else if ((line[i+1] >= 'a') and (line[i+1] <= 'z'))
                      then insert ('e',line,i+1)
                      else insert ('E',line,i+1);
             end;
      'Ö'  : begin
             line[i] := 'O';
             if i = length(line)
               then insert ('E',line,i+1)
               else if ((line[i+1] >= 'a') and (line[i+1] <= 'z'))
                      then insert ('e',line,i+1)
                      else insert ('E',line,i+1);
             end;
      'Ü'  : begin
             line[i] := 'U';
             if i = length(line)
               then insert ('E',line,i+1)
               else if ((line[i+1] >= 'a') and (line[i+1] <= 'z'))
                      then insert ('e',line,i+1)
                      else insert ('E',line,i+1);
             end;
      'µ'  : line[i] := 'u';
      'ß'  : begin
             line[i] := 's';
             insert ('s',line,i+1);
             end;
  end;
  inc (i);
  end;
ExpandDiphtongs := line;
end;



(********************************************************************)
function WinAnsiString (Instring: ShortStr): ShortStr;
(********************************************************************
  This function converts the string InString from the IBM character
  set (MSDOS) to the ANSI character set (Windows).
 ********************************************************************)

type
  Carray = array[0..255] of Char;

var
  p : pchar;

begin
p := carray(Instring);
inc(p);
if length(Instring) > 0 then
  OemToAnsiBuff (p,p,length(Instring));
WinAnsiString := Instring;
end;



(********************************************************************)
function OEMString (Instring: ShortStr): ShortStr;
(********************************************************************
  This function converts the string InString from the ANSI character
  set (Windows) to the IBM character set (DOS).
 ********************************************************************)

type
  Carray = array[0..255] of Char;

var
  p : pchar;

begin
p := carray(Instring);
inc(p);
if length(Instring) > 0 then
  AnsiToOemBuff (p,p,length(Instring));
OEMString := Instring;
end;


(***************************************************************)
constructor TGrep.Create;
(***************************************************************)

begin
inherited Create;
FIgnoreCase := false;
FStopOnError := true;
FMatchEndPos  := 0;
FMatchStartPos:= 0;
FSrcStartPos := 1;

{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
end;

(***************************************************************)
destructor  TGrep.Destroy;
(***************************************************************)

begin
inherited Destroy;
end;

(***************************************************************)
procedure TGrep.SetRegExp (regexp: string);
(***************************************************************)

var
  err  : integer;
  astr : string;

begin
FRegExpStr := regexp;
err := CompileRegexp (FRegExpStr);
if FStopOnError then
  if err > 0 then
    begin
    case err of
       1 : astr := 'reg.exp. must not start with $, *, ?, or +';
       2 : astr := 'circumflex not allowed here';
       3 : astr := 'no character allowed after end of line';
       4 : astr := 'empty set';
       5 : astr := 'circumflex has to be quoted in set';
       6 : astr := 'mismatch of set brackets';
       7 : astr := 'minus not allowed here';
       8 : astr := 'mismatch of group brackets';
       9 : astr := '*, ?, + have to be applied to groups or sets only';
    end;
    astr := 'STRINGL: error in regular expression - '+astr;
    raise ESDLTGrepError.Create (astr);
    end;
end;

(***************************************************************)
function TGrep.CompileRegExp (regexp: string): integer;
(***************************************************************
ENTRY:   regexp .... regular expression
EXIT:    internal regresentation of reg.exp is compiled
         function returns error code:
           E0 ... no error
           E1 ... reg.exp. must not start with $, *, ?, or +
           E2 ... circumflex not allowed here
           E3 ... no character allowed after end of line
           E4 ... empty set
           E5 ... circumflex has to be quoted in set
           E6 ... mismatch of set brackets
           E7 ... minus not allowed here
           E8 ... mismatch of group brackets
           E9 ... *, ?, + have to be applied to groups or sets only

REMARKS: see below for state table of reg.exp. compiler

                 ^     .     $     [     ]     *     ?     +     (     )     \     -    other
----------------------------------------------------------------------------------------------
1 phStart       bol/2 any/2  E1    3     E6    E1    E1    E1    6     E8   qot/2  2      2
2 phNormal       E2   any/2 eol/8  3     E6   mu0/2 opt/2 mu1/2  6     E8   qot/2  2      2
3 phFirstSet    inv/4 add/4 add/4 add/4  E4   add/4 add/4 add/4 add/4 add/4 qot/4  E7   add/4
4 phSet          E5   add/4 add/4 add/4  5    add/4 add/4 add/4 add/4 add/4 qot/4 bis/4 add/4
5 phAfterSet     E2   any/2 eol/8  3     E6   mu0/2 opt/2 mu1/2  6     E8   qot/2  E7     2
6 phGroup        E2   agd/6 adg/6 adg/6 adg/6 adg/6 adg/6 adg/6 adg/6  7    qot/6 adg/6 adg/6
7 phAfterGrp     E2   any/2 eol/8  3     E6   mu0/2 opt/2 mu1/2  6     E8   qot/2  2      2
8 phEnd          E3    E3    E3    E3    E3    E3    E3    E3    E3    E3    E3    E3     E3
----------------------------------------------------------------------------------------------

actions:
bol .. taBol
eol .. taEol
any .. taAnyByte
mu0 .. taMult0
mu1 .. taMult1
inv .. invert set following
add .. add character to set
bis .. range of characters in set
adg .. add character to group
qot .. quote character following

}

 ***************************************************************)

type
  TPhase = (phStart, phNormal, phFirstSet, phSet,
            phAfterSet, phGroup, phAfterGrp, phEnd);

var
  cc         : char;
  Phase      : TPhase;
  NextPh     : TPhase;
  SetInvFlag : boolean;
  RegExPoi   : integer;
  i          : integer;
  ccVon      : char;
  ccBis      : char;
  ccDummy    : char;
  ix, iy     : integer;

begin   { analyse regexp and set internal representation }
if FIgnoreCase then
  regexp := lowercase (regexp);
ix := 1;
while ix > 0 do
  begin
  ix := pos ('\#', regexp);
  if ix > 0 then
    begin
    if not ((ix > 1) and (regexp[ix-1] = '\')) then
      begin
      iy := 1;
      cc := chr(ScanHex (copy (regexp, ix+2,2), iy));
      delete (regexp, ix, 4);
      insert (cc, Regexp, ix);
      end;
    end;
  end;
Phase := phStart;
NextPh := phStart;
RegexPoi := 1;
FLengRegexp := 0;
SetInvFlag := false;
FError := 0;
ccVon :='A';
for i:=1 to MaxGrepTokens do
  begin
  FRegExp[i].NumChars := 0;
  FRegExp[i].ValidFrom:= 0;
  end;
while (RegexPoi <= length(regexp)) and (FError = 0) and (Phase <> phEnd) do
  begin
  cc := Regexp[RegexPoi];
  case Phase of
       phStart : begin
                 case cc of
                   '^' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taBol;
                         end;
                   '.' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taAnyByte;
                         end;
                   '$' : begin
                         FError := 1;
                         end;
                   '[' : begin
                         NextPh := phFirstSet;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taSet;
                         FRegExp[FLengRegExp].NumChars := -1;
                         for i:=0 to 255 do
                           FRegExp[FLengRegExp].Params[i] := ' ';
                         end;
                   ']' : begin
                         FError := 6;
                         end;
                   '*', '?', '+' :
                         begin
                         FError := 1;
                         end;
                   '(' : begin
                         NextPh := phGroup;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 0;
                         end;
                   ')' : begin
                         FError := 8;
                         end;
                   '\' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 1;
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[1] := RegExp[RegExPoi];
                         end;
                   '-' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 1;
                         FRegExp[FLengRegExp].Params[1] := cc;
                         end;
                 else begin   { any other char }
                      NextPh := phNormal;
                      inc (FLengRegExp);
                      FRegExp[FLengRegExp].Action := taNormal;
                      FRegExp[FLengRegExp].NumChars := 1;
                      FRegExp[FLengRegExp].Params[1] := cc;
                      end;
                 end;
                 end;
      phNormal : begin
                 case cc of
                   '^' : begin
                         FError := 2;
                         end;
                   '.' : begin
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taAnyByte;
                         end;
                   '$' : begin
                         NextPh := phEnd;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taEol;
                         end;
                   '[' : begin
                         NextPh := phFirstSet;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].NumChars := -1;
                         FRegExp[FLengRegExp].Action := taSet;
                         for i:=0 to 255 do
                           FRegExp[FLengRegExp].Params[i] := ' ';
                         end;
                   ']' : begin
                         FError := 6;
                         end;
                   '*' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then begin
                                if FRegExp[FLengRegExp].NumChars = 1
                                  then FRegExp[FLengRegExp].Action := taMult0
                                  else begin
                                       dec(FRegExp[FLengRegExp].NumChars);
                                       inc (FLengRegExp);
                                       FRegExp[FLengRegExp].Action := taMult0;
                                       FRegExp[FLengRegExp].NumChars := 1;
                                       FRegExp[FLengRegExp].Params[1] :=
                                           FRegExp[FLengRegExp-1].Params[FRegExp[FLengRegExp-1].NumChars+1];
                                       end;
                                end
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                  then begin
                                       FRegExp[FLengRegExp].Action := taMult0;
                                       FRegExp[FLengRegExp].NumChars := -1;
                                       end
                                  else if (FRegExp[FLengRegExp].Action = taAnyByte)
                                         then begin
                                              FRegExp[FLengRegExp].Action := taMult0;
                                              FRegExp[FLengRegExp].NumChars := 0;
                                              end
                                         else FError := 9;
                         end;
                   '?' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then begin
                                if FRegExp[FLengRegExp].NumChars = 1
                                  then FRegExp[FLengRegExp].Action := taOpti
                                  else begin
                                       dec(FRegExp[FLengRegExp].NumChars);
                                       inc (FLengRegExp);
                                       FRegExp[FLengRegExp].Action := taOpti;
                                       FRegExp[FLengRegExp].NumChars := 1;
                                       FRegExp[FLengRegExp].Params[1] :=
                                           FRegExp[FLengRegExp-1].Params[FRegExp[FLengRegExp-1].NumChars+1];
                                       end;
                                end
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                  then begin
                                       FRegExp[FLengRegExp].Action := taOpti;
                                       FRegExp[FLengRegExp].NumChars := -1;
                                       end
                                  else if (FRegExp[FLengRegExp].Action = taAnyByte)
                                         then begin
                                              FRegExp[FLengRegExp].Action := taOpti;
                                              FRegExp[FLengRegExp].NumChars := 0;
                                              end
                                         else FError := 9;
                         end;
                   '+' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then begin
                                if FRegExp[FLengRegExp].NumChars = 1
                                  then FRegExp[FLengRegExp].Action := taMult1
                                  else begin
                                       dec(FRegExp[FLengRegExp].NumChars);
                                       inc (FLengRegExp);
                                       FRegExp[FLengRegExp].Action := taMult1;
                                       FRegExp[FLengRegExp].NumChars := 1;
                                       FRegExp[FLengRegExp].Params[1] :=
                                           FRegExp[FLengRegExp-1].Params[FRegExp[FLengRegExp-1].NumChars+1];
                                       end;
                                end
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                  then begin
                                       FRegExp[FLengRegExp].Action := taMult1;
                                       FRegExp[FLengRegExp].NumChars := -1;
                                       end
                                  else if (FRegExp[FLengRegExp].Action = taAnyByte)
                                         then begin
                                              FRegExp[FLengRegExp].Action := taMult1;
                                              FRegExp[FLengRegExp].NumChars := 0;
                                              end
                                         else FError := 9;
                         end;
                   '(' : begin
                         NextPh := phGroup;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].NumChars := 0;
                         FRegExp[FLengRegExp].Action := taNormal;
                         end;
                   ')' : begin
                         FError := 8;
                         end;
                   '\' : begin
                         if FRegExp[FLengRegExp].Action <> taNormal then
                           begin
                           inc (FLengRegExp);
                           FRegExp[FLengRegExp].NumChars := 0;
                           FRegExp[FLengRegExp].Action := taNormal;
                           end;
                         inc(FRegExp[FLengRegExp].NumChars);
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[FRegExp[FLengRegExp].NumChars] := RegExp[RegExPoi];
                         ccVon := RegExp[RegExPoi];
                         end;
                 else begin   { any other char }
                      if FRegExp[FLengRegExp].Action <> taNormal then
                        begin
                        inc (FLengRegExp);
                        FRegExp[FLengRegExp].NumChars := 0;
                        FRegExp[FLengRegExp].Action := taNormal;
                        end;
                      inc(FRegExp[FLengRegExp].NumChars);
                      FRegExp[FLengRegExp].Params[FRegExp[FLengRegExp].NumChars] := RegExp[RegExPoi];
                      end;
                 end;
                 end;
    phFirstSet : begin
                 NextPh := phSet;
                 case cc of
                   '^' : begin
                         SetInvFlag := true;
                         end;
                   '$', '[', '.', '*', '?', '+', '(', ')':
                         begin
                         FRegExp[FLengRegExp].Params[ord(cc)] := '*';
                         ccVon := cc;
                         end;
                   ']' : begin
                         FError := 4;
                         end;
                   '\' : begin
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[ord(RegExp[RegExPoi])] := '*';
                         ccVon := RegExp[RegExPoi];
                         end;
                   '-' : begin
                         FError := 7;
                         end;
                 else begin   { any other char }
                      FRegExp[FLengRegExp].Params[ord(cc)] := '*';
                      ccVon := cc;
                      end;
                 end;
                 end;
         phSet : begin
                 case cc of
                   '^' : begin
                         FError := 5;
                         end;
                   '.', '$', '[', '*', '?', '+', '(', ')':
                         begin
                         FRegExp[FLengRegExp].Params[ord(cc)] := '*';
                         ccVon := cc;
                         end;
                   ']' : begin
                         NextPh := phAfterSet;
                         if SetInvFlag then
                           for i:=0 to 255 do
                             if FRegExp[FLengRegExp].Params[i] <> '*'
                               then FRegExp[FLengRegExp].Params[i] := '*'
                               else FRegExp[FLengRegExp].Params[i] := ' ';
                         SetInvFlag := false;
                         end;
                   '\' : begin
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[ord(RegExp[RegExPoi])] := '*';
                         ccVon := RegExp[RegExPoi];
                         end;
                   '-' : begin
                         inc (RegexPoi);
                         ccBis := RegExp[RegExPoi];
                         if ccBis < ccVon then
                           begin
                           ccDummy := ccVon;
                           ccVon := ccBis;
                           ccBis := ccDummy;
                           end;
                         for i:=ord(ccVon) to ord(ccBis) do
                           FRegExp[FLengRegExp].Params[i] := '*';
                         end;
                 else begin   { any other char }
                      FRegExp[FLengRegExp].Params[ord(cc)] := '*';
                      ccVon := cc;
                      end;
                 end;
                 end;
    phAfterSet : begin
                 case cc of
                   '^' : begin
                         FError := 2;
                         end;
                   '.' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taAnyByte;
                         end;
                   '$' : begin
                         NextPh := phEnd;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taEol;
                         end;
                   '[' : begin
                         NextPh := phFirstSet;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taSet;
                         FRegExp[FLengRegExp].NumChars := -1;
                         for i:=0 to 255 do
                           FRegExp[FLengRegExp].Params[i] := ' ';
                         end;
                   ']' : begin
                         FError := 6;
                         end;
                   '*' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then FRegExp[FLengRegExp].Action := taMult0
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                   then begin
                                        FRegExp[FLengRegExp].Action := taMult0;
                                        FRegExp[FLengRegExp].NumChars := -1;
                                        end
                                   else FError := 9;
                         end;
                   '?' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then FRegExp[FLengRegExp].Action := taOpti
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                   then begin
                                        FRegExp[FLengRegExp].Action := taOpti;
                                        FRegExp[FLengRegExp].NumChars := -1;
                                        end
                                   else FError := 9;
                         end;
                   '+' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then FRegExp[FLengRegExp].Action := taMult1
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                   then begin
                                        FRegExp[FLengRegExp].Action := taMult1;
                                        FRegExp[FLengRegExp].NumChars := -1;
                                        end
                                   else FError := 9;
                         end;
                   '(' : begin
                         NextPh := phGroup;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 0;
                         end;
                   ')' : begin
                         FError := 8;
                         end;
                   '\' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 1;
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[1] := RegExp[RegExPoi];
                         ccVon := RegExp[RegExPoi];
                         end;
                   '-' : begin
                         FError := 7;
                         end;
                 else begin   { any other char }
                      NextPh := phNormal;
                      inc (FLengRegExp);
                      FRegExp[FLengRegExp].Action := taNormal;
                      FRegExp[FLengRegExp].NumChars := 1;
                      FRegExp[FLengRegExp].Params[1] := cc;
                      ccVon := cc;
                      end;
                 end;
                 end;
       phGroup : begin
                 case cc of
                   '^' : FError := 2;
                   '.', '$', '[', ']', '*', '?', '+', '(', '-':
                         begin
                         inc(FRegExp[FLengRegExp].NumChars);
                         FRegExp[FLengRegExp].Params[FRegExp[FLengRegExp].NumChars] := cc;
                         end;
                   ')' : begin
                         NextPh := phAfterGrp;
                         end;
                   '\' : begin
                         inc(FRegExp[FLengRegExp].NumChars);
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[FRegExp[FLengRegExp].NumChars] := RegExp[RegExPoi];
                         end;
                 else begin   { any other char }
                      inc(FRegExp[FLengRegExp].NumChars);
                      FRegExp[FLengRegExp].Params[FRegExp[FLengRegExp].NumChars] := cc;
                      end;
                 end;
                 end;
    phAfterGrp : begin
                 case cc of
                   '^' : begin
                         FError := 2;
                         end;
                   '.' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taAnyByte;
                         end;
                   '$' : begin
                         NextPh := phEnd;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taEol;
                         end;
                   '[' : begin
                         NextPh := phFirstSet;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taSet;
                         FRegExp[FLengRegExp].NumChars := -1;
                         for i:=0 to 255 do
                           FRegExp[FLengRegExp].Params[i] := ' ';
                         end;
                   ']' : begin
                         FError := 6;
                         end;
                   '*' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then FRegExp[FLengRegExp].Action := taMult0
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                   then begin
                                        FRegExp[FLengRegExp].Action := taMult0;
                                        FRegExp[FLengRegExp].NumChars := -1;
                                        end
                                   else FError := 9;
                         end;
                   '?' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then FRegExp[FLengRegExp].Action := taOpti
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                   then begin
                                        FRegExp[FLengRegExp].Action := taOpti;
                                        FRegExp[FLengRegExp].NumChars := -1;
                                        end
                                   else FError := 9;
                         end;
                   '+' : begin
                         if (FRegExp[FLengRegExp].Action = taNormal)
                           then FRegExp[FLengRegExp].Action := taMult1
                           else if (FRegExp[FLengRegExp].Action = taSet)
                                   then begin
                                        FRegExp[FLengRegExp].Action := taMult1;
                                        FRegExp[FLengRegExp].NumChars := -1;
                                        end
                                   else FError := 9;
                         end;
                   '(' : begin
                         NextPh := phGroup;
                         end;
                   ')' : begin
                         FError := 8;
                         end;
                   '\' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 1;
                         inc (RegexPoi);
                         FRegExp[FLengRegExp].Params[1] := RegExp[RegExPoi];
                         end;
                   '-' : begin
                         NextPh := phNormal;
                         inc (FLengRegExp);
                         FRegExp[FLengRegExp].Action := taNormal;
                         FRegExp[FLengRegExp].NumChars := 1;
                         FRegExp[FLengRegExp].Params[1] := cc;
                         end;
                 else begin   { any other char }
                      NextPh := phNormal;
                      inc (FLengRegExp);
                      FRegExp[FLengRegExp].Action := taNormal;
                      FRegExp[FLengRegExp].NumChars := 1;
                      FRegExp[FLengRegExp].Params[1] := cc;
                      end;
                 end;
                 end;
         phEnd : begin
                 FError := 3;
                 end;
  end;
  Phase := NextPh;
  inc (RegexPoi);
  end;
CompileRegExp := FError;
end;


(***************************************************************)
function TGrep.GetRegExpToken (regix: integer): TGrepToken;
(***************************************************************)

begin
if (regix > FLengRegExp) then
  regix := FLengRegExp;
if (regix < 1) then
  regix := 1;
GetRegExpToken := FRegExp[regix];
end;


(***************************************************************)
procedure TGrep.PrintRegExp (FName: string);
(***************************************************************)

var
  TFile   : TextFile;
  i,j     : integer;

begin
assignFile (TFile, FName);
rewrite (TFile);
for i:=1 to FLengRegexp do
  begin
  case FRegExp[i].Action of
     taNormal : begin
                write (TFile, ' taNormal: ');
                for j:=1 to FRegExp[i].NumChars do
                  write (TFile, FRegExp[i].Params[j]);
                writeln (TFile);
                end;
    taAnyByte : begin
                writeln (TFile, 'taAnyByte: ');
                end;
        taEol : begin
                writeln (TFile, '    taEol: ');
                end;
        taBol : begin
                writeln (TFile, '    taBol: ');
                end;
        taSet : begin
                write (TFile, '    taSet: ');
                for j:=0 to 255 do
                  if FRegExp[i].Params[j] = '*' then
                    write (TFile, chr(j));
                writeln (TFile);
                end;
      taMult0 : begin
                write (TFile, '  taMult0: ');
                if FRegExp[i].NumChars < 0
                  then begin
                       write (TFile,'(set) ');
                       for j:=0 to 255 do
                         if FRegExp[i].Params[j] = '*' then
                           write (TFile, chr(j));
                       end
                  else if FRegExp[i].NumChars = 0
                         then begin
                              write (TFile,'(anychar) ');
                              end
                         else begin
                              write (TFile,'(string) ');
                              for j:=1 to FRegExp[i].NumChars do
                                write (Tfile, FRegExp[i].Params[j]);
                              end;
                writeln (TFile);
                end;
      taMult1 : begin
                write (TFile, '  taMult1: ');
                if FRegExp[i].NumChars < 0
                  then begin
                       write (TFile,'(set) ');
                       for j:=0 to 255 do
                         if FRegExp[i].Params[j] = '*' then
                           write (TFile, chr(j));
                       end
                  else if FRegExp[i].NumChars = 0
                         then begin
                              write (TFile,'(anychar) ');
                              end
                         else begin
                              write (TFile,'(string) ');
                              for j:=1 to FRegExp[i].NumChars do
                                write (Tfile, FRegExp[i].Params[j]);
                              end;
                writeln (TFile);
                end;
       taOpti : begin
                write (TFile, '   taOpti: ');
                if FRegExp[i].NumChars < 0
                  then begin
                       write (TFile,'(set) ');
                       for j:=0 to 255 do
                         if FRegExp[i].Params[j] = '*' then
                           write (TFile, chr(j));
                       end
                  else if FRegExp[i].NumChars = 0
                         then begin
                              write (TFile,'(anychar) ');
                              end
                         else begin
                              write (TFile,'(string) ');
                              for j:=1 to FRegExp[i].NumChars do
                                write (Tfile, FRegExp[i].Params[j]);
                              end;
                writeln (TFile);
                end;
  end;
  end;
case FError of
   0 : writeln (TFile, 'no errors');
   1 : writeln (TFile, 'reg.exp. must not start with $, *, ?, or +');
   2 : writeln (TFile, 'circumflex not allowed here');
   3 : writeln (TFile, 'no character allowed after end of line');
   4 : writeln (TFile, 'empty set');
   5 : writeln (TFile, 'circumflex has to be quoted in set');
   6 : writeln (TFile, 'mismatch of set brackets');
   7 : writeln (TFile, 'minus not allowed here');
   8 : writeln (TFile, 'mismatch of group brackets');
   9 : writeln (TFile, '*, ?, + have to be applied to groups or sets only');
end;
closeFile (TFile);
end;



(***************************************************************)
function TGrep.MatchString (Instring: string; var MatchPos: integer): boolean;
(***************************************************************
 ENTRY: Instring ... string to be checked
 EXIT:  function returns TRUE if Instring matches reg. expr.
        MatchPos ... position of InString where matched expression starts
 ***************************************************************)


 function MatchAt (StartPos, RegPoi: integer): boolean;
(*--------------------------------------------------*)
{StartPos:  index of Instring to start search
 RegPoi:    index of reg. expr. token to be started with
 REMARK:    MatchAt is called recursively }

var
  matched : boolean;
  ix, iy  : integer;
  found   : boolean;

begin
matched := true;
case FRegExp[RegPoi].Action of { try to match current token [RegPoi] with Instring[StartPos..] }
  taAnyByte : begin                { any character valid: match is always true }
              end;
      taEol : begin
              if StartPos <= length(Instring)
                then matched := false
                else if RegPoi <> FLengRegExp then
                       matched := false;            { taEol must be last token }
              end;
      taBol : begin                      { match is false if StartPos is not 1 }
              if StartPos <> 1 then
                matched := false;
              end;
    taMult0 : begin            { zero or more occurences: match is true if Startpos not at end}
              if (StartPos > length(Instring)) then
                matched := false;
              end;
    taMult1 : begin                                   { at least one occurence }
              if length(Instring) = 0
                then matched := false
                else begin
                     if FRegExp[regpoi].NumChars = 0
                       then begin             { multiple anychar: match always true }
                            end
                       else
                     if FRegExp[regpoi].NumChars < 0
                       then begin             { multiple set }
                            if FRegExp[regpoi].Params[ord(Instring[StartPos])] <> '*' then
                              matched := false
                            end
                       else begin             { multiple group }
                            iy := 1;
                            ix := StartPos;
                            repeat                      { search one occurence }
                              if Instring[ix] <> FRegExp[regpoi].Params[iy] then
                                matched := false;
                              inc (iy);
                              inc (ix);
                            until ((iy > FRegExp[regpoi].NumChars) or
                                   (ix > length(Instring)) or
                                   not matched);
                            end;
                     end;
              end;
     taOpti : begin                  { optional occurence: match is alwas true }
              end;
   taNormal : begin
              if (StartPos+FRegExp[regpoi].NumChars-1) > length(Instring)
                then matched := false
                else begin
                     for ix:=1 to FRegExp[regpoi].NumChars do
                       if Instring[StartPos+ix-1] <> FRegExp[regpoi].Params[ix] then
                         matched := false;
                     end;
              end;
      taSet : begin
              if length(Instring) = 0
                then matched := false
                else if FRegExp[regpoi].Params[ord(Instring[StartPos])] <> '*' then
                       matched := false;
              end;
end;
if matched then
  begin   { match found, find new starting positions }
  FRegExp[RegPoi].ValidFrom := StartPos;
  inc (RegPoi);
  if RegPoi > FLengRegExp
    then begin             { find length of match if all tokens have been processed }
         case FRegExp[RegPoi-1].Action of { now try all possible starting positions }
           taAnyByte : begin           {  any character valid: match is always true }
                       FMatchEndPos := StartPos;
                       end;
               taEol : begin { do nothing since it has already been checked that taEol is last token }
                       FMatchEndPos := length(Instring);
                       end;
               taBol : begin         { rest of tokens must match with Startpos = 1 }
                       FMatchEndPos := 1;
                       end;
             taMult0 : begin                             { zero or more occurences }
                       if FRegExp[regpoi-1].NumChars = 0
                         then begin   { multiple anychar }
                              FMatchEndPos := length(Instring);
                              end
                         else
                       if FRegExp[regpoi-1].NumChars < 0
                         then begin   { multiple set }
                              dec (StartPos);
                              found := true;
                              repeat
                                inc(StartPos);
                                if FRegExp[regpoi-1].Params[ord(Instring[StartPos])] <> '*' then
                                  found := false;
                              until ((StartPos >= length(Instring)) or not found);
                              FMatchEndPos := StartPos-1;
                              end
                         else begin   { multiple group }
                              found := true;
                              repeat                  { search multiple occurences }
                                iy := 1;
                                ix := StartPos;
                                repeat                      { search one occurence }
                                  if Instring[ix] <> FRegExp[regpoi-1].Params[iy] then
                                    found := false;
                                  inc (iy);
                                  inc (ix);
                                until ((iy > FRegExp[regpoi-1].NumChars) or
                                       (ix > length(Instring)) or not found);
                                if found then
                                  StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                              until not found;
                              FMatchEndPos := StartPos-1;
                              end;
                       end;
             taMult1 : begin                              { at least one occurence }
                       if FRegExp[regpoi-1].NumChars = 0
                         then begin   { multiple anychar }
                              FMatchEndPos := length(Instring);
                              end
                         else
                       if FRegExp[regpoi-1].NumChars < 0
                         then begin   { multiple set }
                              found := true;
                              repeat
                                inc(StartPos);
                                if FRegExp[regpoi-1].Params[ord(Instring[StartPos])] <> '*'
                                  then found := false;
                              until ((StartPos >= length(Instring)) or not found);
                              FMatchEndPos := StartPos-1;
                              end
                         else begin   { multiple group }
                              StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                              found := true;
                              repeat                  { search multiple occurences }
                                iy := 1;
                                ix := StartPos;
                                repeat                      { search one occurence }
                                  if Instring[ix] <> FRegExp[regpoi-1].Params[iy] then
                                    found := false;
                                  inc (iy);
                                  inc (ix);
                                until ((iy > FRegExp[regpoi-1].NumChars) or
                                       (ix > length(Instring)) or not found);
                                if found then
                                  StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                              until not found;
                              FMatchEndPos := StartPos-1;
                              end;
                       end;
              taOpti : begin                                  { optional occurence }
                       if FRegExp[regpoi-1].NumChars = 0
                         then begin   { optional anychar }
                              if StartPos > length(Instring) then
                                StartPos := length(Instring);
                              FMatchEndPos := StartPos;
                              end
                         else
                       if FRegExp[regpoi-1].NumChars < 0
                         then begin   { optional set }
                              if (StartPos < length(Instring)) and
                                 (FRegExp[regpoi-1].Params[ord(Instring[StartPos])] = '*') then
                                begin
                                inc (StartPos);
                                end;
                              FMatchEndPos := StartPos-1;
                              end
                         else begin   { optional group }
                              if (StartPos < length(Instring)-FRegExp[regpoi-1].NumChars) then
                                begin
                                found := true;
                                iy := 1;
                                ix := StartPos;
                                repeat                      { search one occurence }
                                  if Instring[ix] <> FRegExp[regpoi-1].Params[iy] then
                                    found := false;
                                  inc (iy);
                                  inc (ix);
                                until ((iy > FRegExp[regpoi-1].NumChars) or
                                       (ix > length(Instring)) or not found);
                                if found then
                                  StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                                end;
                              FMatchEndPos := StartPos-1;
                              end;
                       end;
            taNormal : begin
                       FMatchEndPos := StartPos + FRegExp[regpoi-1].NumChars -1;
                       end;
               taSet : begin
                       FMatchEndPos := StartPos;
                       end;
         end;
         end
    else begin                            { find end of match of previous token }
         case FRegExp[RegPoi-1].Action of {now try all possible starting positions }
           taAnyByte : begin           { any character valid: match is always true }
                       inc (Startpos);
                       matched := MatchAt (startpos, regpoi);
                       end;
               taEol : begin { do nothing since it has already been checked that taEol is last token }
                       end;
               taBol : begin         { rest of tokens must match with Startpos = 1 }
                       matched (*result*) := MatchAt (1, RegPoi);
                       end;
             taMult0 : begin                             { zero or more occurences }
                       if FRegExp[regpoi-1].NumChars = 0
                         then begin   { multiple anychar }
                              dec (startPos);
                              repeat
                                inc (StartPos);
                                matched := MatchAt (startpos, regpoi);
                              until Matched or (StartPos >= length(Instring));
                              end
                         else
                       if FRegExp[regpoi-1].NumChars < 0
                         then begin   { multiple set }
                              dec (StartPos);
                              found := true;
                              repeat
                                inc(StartPos);
                                matched := MatchAt (StartPos, regpoi);
                                if FRegExp[regpoi-1].Params[ord(Instring[StartPos])] <> '*'
                                  then found := false;
                              until ((StartPos >= length(Instring)) or not found or matched);
                              end
                         else begin   { multiple group }
                              found := true;
                              repeat                  { search multiple occurences }
                                iy := 1;
                                ix := StartPos;
                                repeat                      { search one occurence }
                                  matched := MatchAt (StartPos, regpoi);
                                  if Instring[ix] <> FRegExp[regpoi-1].Params[iy] then
                                    found := false;
                                  inc (iy);
                                  inc (ix);
                                until ((iy > FRegExp[regpoi-1].NumChars) or
                                       (ix > length(Instring)) or
                                       not found or matched);
                                if found then
                                  StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                              until not found or matched;
                              end;
                       end;
             taMult1 : begin                              { at least one occurence }
                       if FRegExp[regpoi-1].NumChars = 0
                         then begin   { multiple anychar }
                              repeat
                                inc (StartPos);
                                matched := MatchAt (startpos, regpoi);
                              until Matched or (StartPos >= length(Instring));
                              end
                         else
                       if FRegExp[regpoi-1].NumChars < 0
                         then begin   { multiple set }
                              found := true;
                              repeat
                                inc(StartPos);
                                matched := MatchAt (StartPos, regpoi);
                                if FRegExp[regpoi-1].Params[ord(Instring[StartPos])] <> '*'
                                  then found := false;
                              until ((StartPos >= length(Instring)) or not found or matched);
                              end
                         else begin   { multiple group }
                              StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                              found := true;
                              repeat                  { search multiple occurences }
                                iy := 1;
                                ix := StartPos;
                                repeat                      { search one occurence }
                                  matched := MatchAt (StartPos, regpoi);
                                  if Instring[ix] <> FRegExp[regpoi-1].Params[iy] then
                                    found := false;
                                  inc (iy);
                                  inc (ix);
                                until ((iy > FRegExp[regpoi-1].NumChars) or
                                       (ix > length(Instring)) or
                                       not found or matched);
                                if found then
                                  StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                              until not found or matched;
                              end;
                       end;
              taOpti : begin                                  { optional occurence }
                       if FRegExp[regpoi-1].NumChars = 0
                         then begin   { optional anychar }
                              matched := MatchAt (startpos, regpoi);
                              if not matched and (StartPos < length(Instring)) then
                                begin
                                inc (StartPos);
                                matched := MatchAt (startpos, regpoi);
                                end;
                              end
                         else
                       if FRegExp[regpoi-1].NumChars < 0
                         then begin   { optional set }
                              matched := MatchAt (startpos, regpoi);
                              if not matched and (StartPos < length(Instring)) and
                                   (FRegExp[regpoi-1].Params[ord(Instring[StartPos])] = '*') then
                                begin
                                inc (StartPos);
                                matched := MatchAt (startpos, regpoi);
                                end;
                              end
                         else begin   { optional group }
                              matched := MatchAt (startpos, regpoi);
                              if not matched and (StartPos < length(Instring)-FRegExp[regpoi-1].NumChars) then
                                begin
                                found := true;
                                iy := 1;
                                ix := StartPos;
                                repeat                      { search one occurence }
                                  if Instring[ix] <> FRegExp[regpoi-1].Params[iy] then
                                    found := false;
                                  inc (iy);
                                  inc (ix);
                                until ((iy > FRegExp[regpoi-1].NumChars) or
                                       (ix > length(Instring)) or not found);
                                if found then
                                  begin
                                  StartPos := StartPos + FRegExp[regpoi-1].NumChars;
                                  matched := MatchAt (startpos, regpoi);
                                  end;
                                end;
                              end;
                       end;
            taNormal : begin
                       if (StartPos+FRegExp[regpoi-1].NumChars-1) > length(Instring)
                         then matched := false
                         else begin
                              matched := MatchAt (StartPos+FRegExp[regpoi-1].NumChars, RegPoi);
                              end;
                       end;
               taSet : begin
                       inc (StartPos);
                       matched := MatchAt (StartPos, RegPoi);
                       end;
         end;
         end;
  end;
MatchAt := matched;
end;



var
  matched  : boolean;
  StartPos : integer;

begin
if FRegExpStr = '.*'
  then begin
       Matched := true;    // always true, even if string is empty !!
       FMatchEndPos := length(Instring);
       FMatchStartPos := 1;
       MatchPos := 1;
       end
  else begin
       if FIgnoreCase then
         Instring := lowercase(Instring);
       StartPos := FSrcStartPos;
       matched := MatchAt (StartPos,1);
       if not matched and (FRegExp[1].Action <> taBol) then
         repeat
           inc (StartPos);
           matched := MatchAt (StartPos,1);
         until (matched or (StartPos >= length(Instring)));
       MatchPos := FRegExp[1].ValidFrom;
       FMatchStartPos := FRegExp[1].ValidFrom;
       end;
MatchString := matched;
end;




(***************************************************************)
procedure TGrep.SetIgnoreCase (ic: boolean);
(***************************************************************)

begin
FIgnoreCase := ic;
CompileRegExp (FRegExpStr);
end;


(************************************************************)
function UUEncodeStr (Instring: string): string;
(************************************************************
  ENTRY: Instring ... string to be UU encoded; must not be longer than 95 characters

  EXIT:  function returns UUencoded string

  REMARKS: if the input parameter Instring contains a string which
           is longer than 95 characters, UUEncode returns a blank line
 ************************************************************)

var
  l    : integer;
  astr : string;
  laux : longint;
  i    : integer;
  nbits: integer;
  cc   : char;

begin
l := length(Instring);
if l > 95
  then astr := ''
  else begin
       astr := chr(l+32);
       laux := 0;
       nbits := 0;
       for i:=1 to l do
         begin
         if nbits < 6 then
           begin
           laux := (laux shl 8) + ord(Instring[i]);
           nbits := nbits + 8;
           end;
         while nbits >= 6 do
           begin
           cc := chr(32 + ($3F and (laux shr (nbits-6))));
           if cc = ' ' then
             cc := #96;
           astr := astr + cc;
           nbits := nbits - 6;
           end;
         end;
       if nbits > 0 then
         begin
         cc := chr(32 + ($3F and (laux shl (6-nbits))));
         if cc = ' ' then
           cc := #96;
         astr := astr + cc;
         end;
       end;
UUEncodeStr := astr;
end;


(************************************************************)
function UUDecodeStr (Instring: string): string;
(************************************************************
  ENTRY:   Instring ... UU encoded string to be decoded

  EXIT:    function returns decoded string
 ************************************************************)

var
  astr : string;
  leng : integer;
  laux : longint;
  i    : integer;
  nbits: integer;
  cc   : char;

begin
astr := '';
laux := 0;
nbits := 0;
i:=2;
if length(Instring) > 1 then
  begin
  leng := ord(Instring[1])-32;
  while (i<=length(Instring)) and (length(astr) < leng) do
    begin
    cc := instring[i];
    if cc = #96 then
      cc := ' ';
    laux := (laux shl 6) + ord(cc) - 32;
    nbits := nbits + 6;
    if nbits >= 8 then
      begin
      cc := chr(laux shr (nbits-8));
      astr := astr + cc;
      nbits := nbits - 8;
      end;
    inc (i);
    end;
  end;
UUdecodeStr := astr;
end;


(************************************************************)
function Scramble (Instring: string): string;
(************************************************************)

var
  i    : integer;
  astr : string;

begin
astr := '';
for i:=1 to length(Instring) do
  astr := astr + chr(ScrambleBuf[ord(Instring[i])]);
Scramble := astr;
end;

(************************************************************)
function DeScramble (Instring: string): string;
(************************************************************)

var
  i    : integer;
  astr : string;

begin
astr := '';
for i:=1 to length(Instring) do
  astr := astr + chr(UnScrambleBuf[ord(Instring[i])]);
DeScramble := astr;
end;


(************************************************************)
procedure InitScramble (Key: longint);
(************************************************************)

var
  i    : integer;
  x    : integer;

begin
randseed := Key;
for i:=0 to 255 do
  begin
  ScrambleBuf [i] := 0;
  UnScrambleBuf [i] := 0;
  end;
for i:=1 to 255 do
  begin
  repeat
    x := 1 + random (255);
  until UnScrambleBuf[x] = 0;
  ScrambleBuf[i] := x;
  UnScrambleBuf[x] := i;
  end;
end;

(******************************************************************)
function RemoveAllChars (cc, InString: string): string;
(******************************************************************
  ENTRY: cc ......... character to be removed
         InString ... input string to be processed

  EXIT:  function returns string which is stripped from the character cc
 ******************************************************************)

var
  bstr : string;
  i    : integer;

begin
bstr := '';
for i:=1 to length(Instring) do
  begin
  if Instring[i] <> cc then
    bstr := bstr + Instring[i];
  end;
RemoveAllChars := bstr;
end;


(****************************************************************)
function ReadLnString (Instring: string; var StartPos: integer;
                       var eos: boolean; EOLMode: integer): string;
(****************************************************************
  ENTRY: Instring ..... input string
         StartPos ..... position of first character to be read from string
         EOLMode ...... end of line recognition mode

  EXIT:  eos .......... set TRUE if end of string is met
         StartPos ..... position of first character after read string
         function returns line from current position to line feed
 ****************************************************************)

var
  astr  : string;
  buf   : char;
  found : boolean;
  LastB : char;

begin
astr := '';
found := false;
eos := false;
buf := #0;
repeat
  LastB := buf;
  if StartPos <= length(InString)
    then begin
         buf := Instring[StartPos];
         inc(StartPos);
         if (buf >= ' ')
           then astr := astr + buf
           else begin
                case EOLMode of
                  0  : begin
                       if (buf = #10) then
                         found := true;
                       end;
                  1  : begin
                       if (buf = #13) then
                         found := true;
                       end;
                  2  : begin
                       if (buf = #13) or (buf = #10) then
                         found := true;
                       end;
                  3  : begin
                       if (buf = #13) and (LastB = #10) then
                         found := true;
                       end;
                  4  : begin
                       if (buf = #10) and (LastB = #13) then
                         found := true;
                       end;
                end;
                end;
         end
    else eos := true;
until found or eos;
ReadLnString := astr;
end;


(******************************************************************)
function ReduceStringToAZ09 (InString: string): string;
(******************************************************************
  ENTRY: InString ... input string to be processed

  EXIT:  function returns a string which contains only letters a..z
         and digits 0..9; all other characters are replaced by
         underscores '_'
 ******************************************************************)

var
  i : integer;

begin
result := InString;
for i:=1 to length(result) do
  if not (result[i] in ['a'..'z','A'..'Z','0'..'9']) then
    result[i] := '_';
end;



(***************************************************************)
(*                          INIT                               *)
(***************************************************************)

begin
InitScramble (1234);
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Halt;
  end;
{$ENDIF}
end.


