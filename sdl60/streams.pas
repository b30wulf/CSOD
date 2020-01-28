unit streams;

(******************************************************************)
(*                                                                *)
(*                         S T R E A M S                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger              July 2000         *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: May-24, 2001                                  *)
(*                                                                *)
(******************************************************************)

{
revision history:

Version
1.0   [Jul-04, 2000]
      first release to the public
      ExtractFromStream has been moved from unit StringL; Instream may now be
         of any stream type
      ExtractFromStream does no longer automatically reset the position of the input
         stream; this makes multiple calls with the same set-up possible.

1.1   [Nov-03, 2000]
      procedure WriteStringStream implemented
      function SearchAndReplace implemented

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      marks (SETMARK) of ExtractFromStream are now persistent
      bug fix: ScanStreamForXMLTag parameter "error" is now set correctly
      ReadStreamUntil implemented
      ReadStreamUntilTagList implemented
      ReadNextTagInStream implemented
      ExtractFromStream now supports non-printable characters
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
  classes, WinTypes, WinProcs;


  procedure ExtractFromStream
           (InStream : TStream;                         { stream to be scanned }
       var OutStream : TMemoryStream;                       { resulting stream }
            Commands : TStringList);                        { list of commands }
  function  FindInStream
           (Instream : TStream;                                 { input stream }
               AByte : byte)                                { byte to be found }
                     : boolean;                    { TRUE: byte has been found }
  function  ReadExtendedFromStream
           (InStream : TStream;                                 { input stream }
             var eos : boolean)            { TRUE if end of stream encountered }
                     : extended;                             { extended number }
  function ReadLongintFromStream
           (InStream : TStream;                                 { input stream }
             var eos : boolean)            { TRUE if end of stream encountered }
                     : longint;                               { longint number }
  function ReadLnStream
           (Instream : TStream;                                 { input stream }
             var eos : boolean;            { TRUE if end of stream encountered }
             EOLMode : integer)                 { end of line recognition mode }
                     : string;                       { string read from stream }
  function ReadNextTagInTextFile
          (var AFile : TextFile;                      { text file to read from }
             TagList : array of string;                   { list of valid tags }
          var Attrib,                                              { found tag }
            Contents : string)                               { contents of tag }
                     : integer;                           { index of found tag }
  function ReadNextTagInStream
            (AStream : TStream;                    { stream to reads tags from }
             TagList : array of string;                   { list of valid tags }
          var Attrib,                                   { found tag attributes }
            Contents : string)                            { found tag contents }
                     : integer;                           { index of found tag }
  function ReadStreamUntil
           (InStream : TStream;                                 { input stream }
           SubString : string;                  { substring to be searched for }
           var Error : integer)                                 { error number }
                     : string;                       { string read from stream }
  function ReadStreamUntilTagList
           (InStream : TStream;                                 { input stream }
       const TagList : array of string;       { array of tags to be tested for }
           var TagNr : integer)                          { number of found tag }
                     : string;                            { string read so far }
  function ScanStreamDecimal
           (InStream : TStream)                                 { input stream }
                     : longint;                               { decimal number }
  function ScanStreamForXMLTag
           (InStream : TStream;                                 { input stream }
              XMLTag : string;
           var Error : integer)
                     : string;
  function ScanStreamFPNum
           (Instream : TStream;                                 { input stream }
            AllowExp : boolean;
            DecPChar : integer)
                     : double;
  function SearchAndReplace
       (var InStream,                            { input stream to be searched }
           OutStream : TMemoryStream;                       { processed stream }
           SearchExp,                 { search expression (regular expression) }
          ReplaceExp : string;                            { replacement string }
          IgnoreCase : boolean;              { TRUE if cases should be ignored }
           CondToken : integer;    { token of grep search used for a condition }
         Combination : integer;                  { type of logical combination }
            CondText : string)                            { text for condition }
                     : boolean;                  { TRUE if any changes occured }
  procedure WriteExtendedToStream
          (OutStream : TStream;                                { output stream }
               value : extended);
  procedure WriteLongintToStream
          (OutStream : TStream;                                { output stream }
               value : longint);
  procedure WriteLnStream
          (OutStream : TStream;                                { output stream }
                Line : string);
  procedure WriteStringStream
          (OutStream : TStream;                                { output stream }
             AString : string);


{--------------------------------------------------------------------------}
implementation
{--------------------------------------------------------------------------}

uses
  sysutils, math1, stringl {$IFDEF SHAREWARE}, dialogs {$ENDIF};

const
  MaxMarks = 9;

var
  Marks  : array[0..MaxMarks] of longint;   // marks for ExtractFromStream

{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\streams_ct.inc}
{$ENDIF}

{$I stripblk.inc}
{$I SCANDEC.INC}
{$I scanhex.INC}

(****************************************************************)
function FindInStream (Instream: TStream; AByte: byte): boolean;
(****************************************************************
  ENTRY: Instream .... input stream

  EXIT:  position of stream points to first byte "AByte" after
         current position;
         function returns true if AByte has been found
         else a false value is returned and the position pointer
         is set to the end of the stream
 ****************************************************************)

var
  buf   : byte;
  fc    : integer;

begin
repeat
  fc := Instream.read (buf, 1);
until (fc = 0) or (buf = AByte);
FindInStream := (fc <> 0);
end;


(******************************************************************************)
function ScanStreamForXMLTag (InStream: TStream; XMLTag: string; var Error: integer): string;
(******************************************************************************
  ENTRY: InStream...... stream to be scanned
         XMLTag ....... XML tag to be scanned for (has to include '<' and '>')
                        scanning starts at current stream position

  EXIT:  Error  ....... error flag: 0 ... no error
                                    -1 ... tag not found
                                    -2 ... closing tag not found
         function returns all characters between XMLTag and closing tag as a string
         position of stream is after closing tag
 ******************************************************************************)

var
  eos      : boolean;
  cmdstr   : string;
  fc       : integer;
  cc       : char;
  ix       : integer;
  reslt    : string;
  EndTag   : string;

begin
eos := false;
EndTag := XMLTag;
insert ('/', EndTag, 2);
Error := -1;
while not eos do
  begin
  eos := not FindInStream (InStream, ord('<'));
  if not eos then
    begin
    cmdstr := '<';
    repeat
      fc := InStream.read (cc, 1);
      if fc > 0 then
        cmdStr := cmdStr + cc;
    until (cc = '>') or (fc = 0);
    if lowercase (XMLTag) = lowercase(cmdstr) then
      begin
      error := 0;
      eos := true;
      reslt := '';
      repeat
        fc := InStream.read (cc, 1);
        if fc > 0 then
          reslt := reslt + cc;
      until (fc = 0) or (pos (EndTag, lowercase(reslt)) > 0);
      end;
    end;
  end;
ix := pos (EndTag, lowercase(reslt));
if ix > 0
  then delete (reslt, ix, length(EndTag))
  else Error := -2;
ScanStreamForXMLTag := reslt;
end;


(******************************************************************************)
function ReadStreamUntil (InStream: TStream; SubString: string; var Error: integer): string;
(******************************************************************************
  ENTRY: InStream...... stream to be scanned
         SubString .... substring to be scanned for
                        scanning starts at current stream position

  EXIT:  Error  ....... error flag: 0 ... no error
                                    -1 ... substring not found
         function returns all characters between current position and substring,
         including the substring
         position of stream is after substring
 ******************************************************************************)

var
  fc       : integer;
  cc       : char;
  ix       : integer;
  reslt    : string;

begin
Error := -1;
SubString := lowercase(SubString);
reslt := '';
repeat
  fc := InStream.read (cc, 1);
  if fc > 0 then
    reslt := reslt + cc;
until (fc = 0) or (pos (SubString, lowercase(reslt)) > 0);
ix := pos (SubString, lowercase(reslt));
if ix > 0 then
  Error := 0;
ReadStreamUntil := reslt;
end;


(******************************************************************************)
function ReadStreamUntilTagList (InStream: TStream; const TagList: array of string;
                                 var TagNr: integer): string;
(******************************************************************************
  ENTRY: InStream...... stream to be scanned
         TagList ...... array of tags to be scanned for
                        scanning starts at current stream position

  EXIT:  TagNr ........ array index of the tag matching the stream
                        -1 ... no such tag found
         function returns all characters between current position and the matched
         tag, including the tag; search performed case insensitive
         position of stream is after substring
 ******************************************************************************)

var
  fc       : integer;
  cc       : char;
  ix       : integer;
  reslt    : string;
  found    : boolean;

begin
reslt := '';
repeat
  fc := InStream.read (cc, 1);
  if fc > 0 then
    reslt := reslt + cc;
  found := false;
  ix := low(TagList)-1;
  while not found and (ix < high(TagList)) do
    begin
    inc (ix);
    if (pos (lowercase(TagList[ix]), lowercase(reslt)) > 0) then
      found := true;
    end;
until (fc = 0) or found;
if found
  then TagNr := ix
  else TagNr := -1;
ReadStreamUntilTagList := reslt;
end;




(****************************************************************)
function ReadLnStream (Instream: TStream; var eos: boolean;
                       EOLMode: integer): string;
(****************************************************************
  ENTRY: Instream ..... input stream
         EOLMode ...... end of line recognition mode

  EXIT:  eos .......... set TRUE if end of stream is met
         function returns line from current position to line feed
 ****************************************************************)

var
  fc    : integer;
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
  fc := Instream.read (buf, 1);
  if fc > 0
    then begin
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
ReadLnStream := astr;
end;



(****************************************************************)
procedure WriteLnStream (OutStream: TStream; Line: string);
(****************************************************************
  ENTRY: OutStream ..... output stream
         Line .......... line to be written
         Line must not be longer than 4096 characters

  EXIT:  Line is written to OutStream; if Stream pointer is at end of
         stream Line is appended
 ****************************************************************)

const
  MaxBufLeng = 4;

var
  buf   : array[1..MaxBufLeng] of char;

begin
WriteStringStream (OutStream, Line);
buf[1] := #13;
buf[2] := #10;
OutStream.WriteBuffer (buf, 2);
end;


(****************************************************************)
procedure WriteStringStream (OutStream: TStream; AString: string);
(****************************************************************
  ENTRY: OutStream ..... output stream
         AString ....... string to be appended

  EXIT:  AString is written to OutStream; if Stream pointer is at end of
         stream Line is appended
 ****************************************************************)

const
  MaxBufLeng = 4096;

var
  buf   : array[1..MaxBufLeng] of char;
  i     : integer;
  cnt   : integer;

begin
cnt := 0;
for i:=1 to length(AString) do
  begin
  inc(cnt);
  buf[cnt] := AString[i];
  if cnt = MaxBufLeng then
    begin
    OutStream.WriteBuffer (buf, cnt);
    cnt :=0;
    end;
  end;
OutStream.WriteBuffer (buf, cnt);
end;



(**************************************************************************)
function ScanStreamDecimal (InStream: TStream): longint;
(**************************************************************************
  ENTRY:  InStream ..... stream to be converted

  EXIT:   function returns integer value of decimal string in stream
          scanning starts at current position of stream
          on return, position points to first char after decimal number
 **************************************************************************)

var
  reslt  : longint;
  i      : integer;
  DecEnd : boolean;
  cc     : char;
  fc     : integer;
  NegSgn : boolean;

begin
reslt := 0;
DecEnd := false;
fc := 1;
cc := ' ';
while (fc <> 0) and (cc = ' ') do
  fc := Instream.read (cc, 1);
NegSgn := false;
if cc = '-'
  then begin
       fc := Instream.read (cc, 1);
       NegSgn := true;
       end
  else begin
       if cc = '+' then
         fc := Instream.read (cc, 1);
       end;
while (fc <> 0) and not DecEnd do
  begin
  cc := upcase(cc);
  i := ord(cc)-ord('0');
  if (i <= 9) and (i >= 0)
    then begin
         reslt := 10*reslt + i;
         fc := Instream.read (cc, 1);
         end
    else begin
         DecEnd := true;
         end;
  end;
if NegSgn then
  reslt := -reslt;
ScanStreamDecimal := reslt;
end;


(******************************************************************************)
procedure ExtractFromStream (InStream: TStream; var OutStream: TMemoryStream; Commands: TStringList);
(******************************************************************************
  ENTRY: Instream ..... stream to be scanned
         Commands ..... list of search and extract commands

  EXIT:  OutStream .... extracted Stream parts
 ******************************************************************************)

const
  MaxBuf = 1024;
  MaxLabels = 9;
  MaxExCommands = 22;
  ExCommands: array[1..MaxExCommands] of string =
                 ('incpos','resetpos','find', 'insert', 'dellast',
                  'copyrel', 'endpos', 'setmark', 'moveto', 'makeupper',
                  'makelower', 'noconversion', 'loadconvtab', 'copyabs', 'label',
                  'loop', '#', 'iffound', 'ifnotfound', 'findwithin',
                  'insertbyte', 'convertbyte');

type
                      // TExCommands must have the same order as ExCommands !!
  TExCommands = (exincpos, exresetpos, exfind, exinsert, exdellast,
                 exCopyrel, exEndpos, exSetMark, exmoveto, exMakeUp,
                 exMakeLw, exNoconv, exLoadCvT, exCopyAbs, exlabel,
                 exloop, excomment, exiffound, exifnotfound, exfindwithin,
                 exInsertByte, exconvertbyte);

var
  i, j, k         : integer;
  cmdlin          : integer;
  astr, bstr      : string;
  arg             : string;
  ix              : integer;
  found           : boolean;
  eos             : boolean;
  cmd             : TExCommands;
  ipar            : longint;
  ipar2           : longint;
  buf             : array[1..MaxBuf] of char;
  numRead         : integer;
  ConvTab         : array[0..255] of byte;
  TFile           : TextFile;
  Labels          : array[0..MaxLabels] of longint;
  Loopcnt         : array[0..MaxLabels] of longint;
  CurPoi          : longint;
  LastFindSuccess : boolean;      { TRUE if last Find operation was successful }
  LevelCnt        : integer;
  abool           : boolean;
  CurrentCommand  : string;

begin
for i:=0 to MaxLabels do
  begin
  Labels [i] := -1;
  Loopcnt[i] := 0;
  end;
for i:=0 to 255 do
  ConvTab[i] := i;
LastFindSuccess := false;
cmdlin:=0;
cmd := excomment;
while (cmdlin < Commands.Count) do
  begin
  inc (cmdlin);
  CurrentCommand := StripLTBlanks (Commands[cmdlin-1]);
  repeat
    ix := pos ('$', CurrentCommand);  // replace single hex chars
    if ix > 0 then
      begin
      bstr := copy (CurrentCommand, ix+1, 2);
      j := 1;
      i := scanhex (bstr, j);
      delete (CurrentCommand, ix, 3);
      insert (chr(i), CurrentCommand, ix);
      end;
  until ix = 0;

  astr := lowercase(CurrentCommand);
  ix := pos (' ', astr);
  if ix > 0 then
    delete (astr, ix, 255);
  ix := 0;
  found := false;
  while not found and (ix < MaxExCommands) do
    begin
    inc (ix);
    if (astr = ExCommands[ix]) then
      begin
      found := true;
      cmd := TExCommands(ix-1);
      end;
    end;
  if found then
    begin
    case cmd of
        excomment : begin  // comment - do nothing
                    end;
         exincpos : begin
                    ix := 8;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    InStream.Position := Instream.Position + ipar;
                    if Instream.Position < 0 then
                      Instream.Position := 0;
                    if Instream.Position > Instream.Size-1 then
                      Instream.Position := Instream.Size-1;
                    end;
        exloadcvt : begin
                    arg := lowercase (copy (CurrentCommand, 13, 255));
                    assignfile (TFile, arg);
                    {$I-} reset (TFile); {$I+}
                    if IOResult = 0 then
                      begin
                      j := 0;
                      while not eof(TFile) do
                        begin
                        readln (TFile, astr);
                        ix := 1;
                        for k:=0 to 15 do
                          begin
                          ipar := ScanHex (astr, ix);
                          ConvTab[j] := ipar;
                          inc (j);
                          end;
                        end;
                      closefile (TFile);
                      end;
                    end;
         exMakeUp : begin
                    for j:=0 to 255 do
                      ConvTab[j] := j;
                    for j:=ord('a') to ord('z') do
                      ConvTab[j] := j-32;
                    end;
         exMakeLw : begin
                    for j:=0 to 255 do
                      ConvTab[j] := j;
                    for j:=ord('A') to ord('Z') do
                      ConvTab[j] := j+32;
                    end;
         exNoConv : begin
                    for j:=0 to 255 do
                      ConvTab[j] := j;
                    end;
        exsetmark : begin
                    ix := 9;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= MaxMarks) then
                      Marks[ipar] := Instream.Position;
                    end;
          exlabel : begin
                    ix := 7;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= MaxLabels) then
                      Labels[ipar] := cmdlin-1;
                    end;
         exmoveto : begin
                    ix := 8;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= MaxMarks) then
                      Instream.Position := Marks[ipar];
                    end;
        excopyrel : begin
                    ix := 9;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    if Instream.Size-InStream.Position-1 < ipar then
                      ipar := Instream.Size-InStream.Position-1;
                    while (ipar > 0) do
                      begin
                      numread := ipar;
                      if numread > MaxBuf then
                        numread := MaxBuf;
                      ipar := ipar - MaxBuf;
                      InStream.Read (Buf, numread);
                      for j:=1 to numread do
                        buf[j] := char(convtab[ord(buf[j])]);
                      OutStream.Write (Buf, numread);
                      end;
                    end;
           exloop : begin
                    ix := 6;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    ipar2 := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= MaxLabels) then
                       begin
                       inc (LoopCnt[ipar]);
                       if ((LoopCnt[ipar] < ipar2) or (ipar2 = 0))
                           and (Instream.Position+1 < Instream.Size) then
                         cmdlin := Labels[ipar]+1;
                       end;
                    end;
        exiffound,
     exifnotfound : begin
                    abool := LastFindSuccess;
                    if cmd = exiffound then
                      abool := not abool;
                    if abool then  // move on to next command after endif
                      begin
                      found := false;
                      LevelCnt := 1;
                      while (cmdlin < Commands.Count) and not found do
                        begin
                        inc (cmdlin);
                        astr := lowercase(StripLTBlanks (Commands[cmdlin-1]));
                        if pos ('endif', astr) > 0 then
                          begin
                          dec (LevelCnt);
                          if LevelCnt = 0 then
                            found := true;
                          end;
                        if (pos ('iffound', astr) > 0) or (pos ('ifnotfound', astr) > 0) then
                          inc (LevelCnt);
                        end;
                      end;
                    end;
        excopyabs : begin
                    ix := 9;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    ipar2 := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= MaxMarks) and
                       (ipar2 >= 0) and (ipar2 <= MaxMarks) then
                      begin
                      InStream.Position := Marks[ipar];
                      ipar := Marks[ipar2] - Marks[ipar] + 1;
                      while (ipar > 0) do
                        begin
                        numread := ipar;
                        if numread > MaxBuf then
                          numread := MaxBuf;
                        ipar := ipar - MaxBuf;
                        InStream.Read (Buf, numread);
                        for j:=1 to numread do
                          buf[j] := char(convtab[ord(buf[j])]);
                        OutStream.Write (Buf, numread);
                        end;
                      InStream.Position := Marks[ipar2];
                      end;
                    end;
    exconvertbyte : begin
                    ix := 13;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    ipar2 := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= 255) and
                       (ipar2 >= 0) and (ipar2 <= 255) then
                      ConvTab[ipar] := ipar2;
                    end;
       exresetpos : Instream.Position := 0;
         exendpos : Instream.Position := Instream.size-1;
           exfind : begin
                    CurPoi := Instream.Position;
                    arg := lowercase (copy (CurrentCommand, 6, 255));
                    found := false;
                    eos := false;
                    ix := 1;
                    while not found and not eos do
                      begin
                      numRead := InStream.Read (Buf, 1);
                      if numRead <> 1 then
                        eos := true;
                      if lowercase(buf[1]) = arg[ix]
                        then begin
                             inc (ix);
                             if ix > length(arg) then
                               found := true;
                             end
                        else ix := 1;
                      end;
                    if not found then
                      Instream.Position := CurPoi;
                    LastFindSuccess := found;
                    end;
     exfindwithin : begin
                    CurPoi := Instream.Position;
                    ix := 12;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    arg := StripLTBlanks(lowercase (copy (CurrentCommand, ix, 255)));
                    found := false;
                    eos := false;
                    ix := 1;
                    while not found and not eos and (Instream.Position < CurPoi+ipar) do
                      begin
                      numRead := InStream.Read (Buf, 1);
                      if numRead <> 1 then
                        eos := true;
                      if lowercase(buf[1]) = arg[ix]
                        then begin
                             inc (ix);
                             if ix > length(arg) then
                               found := true;
                             end
                        else ix := 1;
                      end;
                    if not found then
                      Instream.Position := CurPoi;
                    LastFindSuccess := found;
                    end;
         exinsert : begin
                    for j:=8 to length(CurrentCommand) do
                      Buf[j-7] := CurrentCommand[j];
                    OutStream.Write (Buf, length(CurrentCommand)-7);
                    end;
     exinsertbyte : begin
                    ix := 12;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    if (ipar >= 0) and (ipar <= 255) then
                      begin
                      Buf[1] := char(ipar);
                      OutStream.Write (Buf, 1);
                      end;
                    end;
        exdellast : begin
                    ix := 9;
                    ipar := ScanDecimal (CurrentCommand, ix);
                    OutStream.SetSize (OutStream.Position-ipar);
                    end;
    end;
    end;
  end;
OutStream.Position := 0;
end;

(****************************************************************)
procedure WriteLongintToStream (OutStream: TStream; value: longint);
(****************************************************************
  ENTRY: OutStream ..... output stream
         value ......... value to be written to stream

  EXIT:  value is written to OutStream; if Stream pointer is at end of
         stream the value is appended
 ****************************************************************)


var
  buf   : array[1..sizeof(longint)] of byte absolute value;

begin
OutStream.WriteBuffer (buf, sizeof(longint));
end;


(****************************************************************)
function ReadLongintFromStream (InStream: TStream; var eos: boolean): longint;
(****************************************************************
  ENTRY: InStream ..... stream to be read from

  EXIT:  eos .......... set to TRUE if end of stream was encountered
         function returns longint number read from the current position
 ****************************************************************)


var
  intdummy : longint;
  buf      : array[1..sizeof(longint)] of byte absolute intdummy;

begin
intdummy := 0;
try
  InStream.ReadBuffer (buf, sizeof(longint));
  eos := false;
except
  eos := true;
end;
ReadLongintFromStream := intdummy;
end;


(****************************************************************)
procedure WriteExtendedToStream (OutStream: TStream; value: extended);
(****************************************************************
  ENTRY: OutStream ..... output stream
         value ......... value to be written to stream

  EXIT:  value is written to OutStream; if Stream pointer is at end of
         stream the value is appended
 ****************************************************************)


var
  buf   : array[1..sizeof(extended)] of byte absolute value;

begin
OutStream.WriteBuffer (buf, sizeof(extended));
end;

(****************************************************************)
function ReadExtendedFromStream (InStream: TStream; var eos: boolean): extended;
(****************************************************************
  ENTRY: InStream ..... stream to be read from

  EXIT:  eos .......... set to TRUE if end of stream was encountered
         function returns extended number read from the current position
 ****************************************************************)


var
  extdummy : extended;
  buf      : array[1..sizeof(extended)] of byte absolute extdummy;

begin
extdummy := 0;
try
  InStream.ReadBuffer (buf, sizeof(extended));
  eos := false;
except
  eos := true;
end;
ReadExtendedFromStream := extdummy;
end;

(**************************************************************************)
function ScanStreamFPNum (Instream: TStream; AllowExp: boolean; DecPChar: integer): double;
(**************************************************************************
  ENTRY:  Instring ..... string to be converted
          AllowExp ..... if TRUE exponent is allowed (exponential notation)
          DecPChar ..... dec. point character: 1 = dot, 2 = colon, 3 = both

  EXIT:   function returns value of floating point string

  state diagram:

  phase   digit   dot     +/-     #32,#9  'E'     EOS     any other
                                  #10,#13
  -----------------------------------------------------------------
  P1      P3      P4      P2      P1      ERR     ERR     ERR
  P2      P3      P4      ERR     ERR     ERR     ERR     ERR
  P3      P3      P4      P9      P9      P6/9    P9      P9
  P4      P5      ERR     P9      P9      P6/9    P9      P9
  P5      P5      ERR     P9      P9      P6/9    P9      P9
  P6      P8      ERR     P7      ERR     ERR     ERR     ERR
  P7      P8      ERR     ERR     ERR     ERR     ERR     ERR
  P8      P8      P9      P9      P9      P9      P9      P9
  P9-->end
  -----------------------------------------------------------------

  P1 ... starting phase
  P2 ... sign
  P3 ... pre dec point
  P4 ... dec point (colon or dot)
  P5 ... post dec point
  P6 ... exponent E
  P7 ... exp sign
  P8 ... exp digits (max. 3 digits)
  P9 ... FP found

  P = -1  ----> error
 **************************************************************************)

const
  MaxDouble   : extended = 1.7e308;

var
  reslt     : extended;
  cc        : char;
  Phase     : integer;
  NextPhase : integer;
  status    : integer;
  astr      : string;
  expo      : string;
  ldummy    : longint;
  buf       : byte;
  fc        : integer;


begin
reslt := 0;
Phase := 1;
NextPhase := -1;
astr := '';
expo := '';
while (phase > 0) and (phase <> 9) do
  begin
  fc := Instream.read (buf, 1);
  if fc = 0
    then cc := 'Z'   { trick to handle end of string }
    else cc := upcase (char(buf));
  case Phase of
    1 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := 4
             else case cc of
                    '0'..'9' : NextPhase := 3;
                    '+', '-' : NextPhase := 2;
           #9, #10, #13, ' ' : NextPhase := 1;
                         'E' : NextPhase := -1;
                  else NextPhase := -1;
                  end;
        end;
    2 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := 4
             else case cc of
                    '0'..'9' : NextPhase := 3;
                    '+', '-' : NextPhase := -1;
           #9, #10, #13, ' ' : NextPhase := -1;
                         'E' : NextPhase := -1;
                  else NextPhase := -1;
                  end;
        end;
    3 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := 4
             else case cc of
                    '0'..'9' : NextPhase := 3;
                    '+', '-' : NextPhase := 9;
           #9, #10, #13, ' ' : NextPhase := 9;
                         'E' : if AllowExp
                                 then NextPhase := 6
                                 else NextPhase := 9;
                  else NextPhase := 9;
                  end;
        end;
    4 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := -1
             else case cc of
                    '0'..'9' : NextPhase := 5;
                    '+', '-' : NextPhase := 9;
           #9, #10, #13, ' ' : NextPhase := 9;
                         'E' : if AllowExp
                                 then NextPhase := 6
                                 else NextPhase := 9;
                  else NextPhase := 9;
                  end;
        end;
    5 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := -1
             else case cc of
                    '0'..'9' : NextPhase := 5;
                    '+', '-' : NextPhase := 9;
           #9, #10, #13, ' ' : NextPhase := 9;
                         'E' : if AllowExp
                                 then NextPhase := 6
                                 else NextPhase := 9;
                  else NextPhase := 9;
                  end;
        end;
    6 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := -1
             else case cc of
                    '0'..'9' : begin
                               NextPhase := 8;
                               expo := cc;
                               end;
                    '+', '-' : NextPhase := 7;
           #9, #10, #13, ' ' : NextPhase := -1;
                         'E' : NextPhase := -1;
                  else NextPhase := -1;
                  end;
        end;
    7 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := -1
             else case cc of
                    '0'..'9' : begin
                               NextPhase := 8;
                               expo := cc;
                               end;
                    '+', '-' : NextPhase := -1;
           #9, #10, #13, ' ' : NextPhase := -1;
                         'E' : NextPhase := -1;
                  else NextPhase := -1;
                  end;
        end;
    8 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := 9
             else case cc of
                    '0'..'9' : begin
                               NextPhase := 8;
                               expo := expo + cc;
                               end;
                    '+', '-' : NextPhase := 9;
           #9, #10, #13, ' ' : NextPhase := 9;
                         'E' : NextPhase := 9;
                  else NextPhase := 9;
                  end;
        end;
  end;
  phase := NextPhase;
  if (Phase > 0) and (Phase <> 9) then
    begin
    if cc = ',' then
      cc := '.';
    val (expo, ldummy, status);  { restrict exponent }
    if cc > ' ' then
      if abs(ldummy) <= 4200 then
        astr := astr + cc;
    end;
  end;
if phase = 9 then
  begin
  if length(astr) > 0 then       { work-around for Delphi bug }
    if astr [length(astr)] = '.'
      then astr := astr + '0';
  val (astr, reslt, status);
  end;
InStream.Position := Instream.Position - 1;
if reslt > MaxDouble then      { limit range to max. double }
  reslt := MaxDouble;
if reslt < -MaxDouble then
  reslt := -MaxDouble;
ScanStreamFPNum := reslt;
end;



(******************************************************************************)
function SearchAndReplace (var InStream, OutStream: TMemoryStream;
                 SearchExp, ReplaceExp: string; IgnoreCase: boolean;
                 CondToken: integer; Combination: integer; CondText: string): boolean;
(******************************************************************************
  ENTRY: Instream ...... input stream to be searched
         SearchExp ..... regular expression
         ReplaceExp .... replacement string
         IgnoreCase .... TRUE if cases should be ignored
         CondToken ..... token of grep search used for a condition (0 = no condition evaluated)
         Combination ... type of logical combination:
                              0 ... CondToken is equal to CondText
                              1 ... is not equal to
                              2 ... contains
                              3 ... does not contain
         CondText ...... text for condition (case is ignored only if IgnoreCase is True)

  EXIT:  OutStream ..... processed stream
         function returns TRUE if any changes occured
 ******************************************************************************)

var
  AStrStr  : TStringStream;
  ix       : integer;
  found    : boolean;
  MyGrep   : TGrep;
  astr     : string;
  bstr     : string;
  cstr     : string;
  i, j     : integer;
  cnt      : integer;
  DoReplace  : boolean;
  DoReduzeAZ : boolean;
  DoLowercase : boolean;
  DoUppercase : boolean;
  DoIncrement : boolean;
  DoDecrement : boolean;
  value       : longint;
  status      : integer;

begin
result := false;
if SearchExp <> '' then
  begin
  MyGrep := TGrep.Create;
  MyGrep.RegExp := SearchExp;
  MyGrep.Ignorecase := IgnoreCase;
  if IgnoreCase then
    CondText := lowercase(CondText);
  AStrStr := TStringStream.create ('');
  InStream.Position := 0;
  aStrStr.CopyFrom (InStream, InStream.Size);  // read input stream into string stream
  OutStream.Clear;
  MyGrep.SearchStartPos := 1;
  repeat
    found := MyGrep.MatchString (aStrStr.DataString, ix);
    if found then
      begin
      InStream.Position := MyGrep.SearchStartPos-1;
      if MyGrep.MatchStartPos <> MyGrep.SearchStartPos then
        OutStream.CopyFrom (InStream, MyGrep.MatchStartPos-MyGrep.SearchStartPos);

      DoReplace := true;   // check if condition is fulfilled
      if CondToken > 0 then
        begin
        cnt := 0;
        if CondToken < MyGrep.NrofRegExpTokens
          then cnt := MyGrep.regExpToken[CondToken+1].ValidFrom - MyGrep.regExpToken[CondToken].ValidFrom
          else if CondToken = MyGrep.NrofRegExpTokens
                 then cnt := MyGrep.MatchEndPos - MyGrep.regExpToken[CondToken].ValidFrom +1;
        astr := copy (aStrStr.DataString, MyGrep.regExpToken[CondToken].ValidFrom, cnt);
        if IgnoreCase
          then bstr := lowercase(astr)
          else bstr := astr;
        case Combination of
          0 : DoReplace := (bstr = CondText);
          1 : DoReplace := (bstr <> CondText);
          2 : DoReplace := (pos (CondText, bstr) > 0);
          3 : DoReplace := (pos (CondText, bstr) = 0);
        end;
        end;

      if DoReplace
        then begin
             DoReduzeAZ := false;
             DoLowercase := false;
             DoUppercase := false;
             DoIncrement := false;
             DoDecrement := false;
             astr := '';
             i:=0;
             while i < length(ReplaceExp) do
               begin
               inc (i);
               if ReplaceExp[i] = '@'
                 then begin
                      inc (i);
                      if i <= length(ReplaceExp) then
                        begin
                        if ReplaceExp[i] = '@'
                          then astr := astr + '@'
                          else begin
                               case ReplaceExp[i] of
                                 'z', 'Z' : DoReduzeAZ := true;
                                 'i', 'I' : DoIncrement := true;
                                 'd', 'D' : DoDecrement := true;
                                 'l', 'L' : DoLowercase := true;
                                 'u', 'U' : DoUppercase := true;
                               end;
                               if ReplaceExp[i] in ['0'..'9'] then
                                 begin
                                 cnt := 0;
                                 ix := ord(ReplaceExp[i])-ord('0');
                                 if ix < MyGrep.NrofRegExpTokens
                                   then cnt := MyGrep.regExpToken[ix+1].ValidFrom - MyGrep.regExpToken[ix].ValidFrom
                                   else if ix = MyGrep.NrofRegExpTokens
                                          then cnt := MyGrep.MatchEndPos - MyGrep.regExpToken[ix].ValidFrom +1;
                                 cstr := '';
                                 for j:=1 to cnt do
                                   cstr := cstr + aStrStr.DataString[MyGrep.regExpToken[ix].ValidFrom+j-1];
                                 if DoReduzeAZ then
                                   cstr := ReduceStringToAZ09 (cstr);
                                 if DoLowercase then
                                   cstr := lowercase (cstr);
                                 if DoUppercase then
                                   cstr := uppercase (cstr);
                                 if DoIncrement then
                                   begin
                                   val (cstr, value, status);
                                   if status = 0 then
                                     cstr := decimal(value+1,length(cstr))
                                   end;
                                 if DoDecrement then
                                   begin
                                   val (cstr, value, status);
                                   if status = 0 then
                                     cstr := decimal(value-1,length(cstr))
                                   end;
                                 astr := astr + cstr;
                                 DoReduzeAZ := false;
                                 DoLowercase := false;
                                 DoUppercase := false;
                                 DoIncrement := false;
                                 DoDecrement := false;
                                 end;
                               end;
                        end;
                      end
                 else astr := astr + ReplaceExp[i];
               end;
             end
        else begin
             astr := copy (aStrStr.DataString, MyGrep.MatchStartPos, MyGrep.MatchEndPos-MyGrep.MatchStartPos+1);
             end;
      WriteStringStream (OutStream, astr);
      result := true;
      MyGrep.SearchStartPos := MyGrep.MatchEndPos+1;
      end;
  until not found;
  if MyGrep.SearchStartPos < InStream.Size then
    begin
    InStream.Position := MyGrep.SearchStartPos-1;
    OutStream.CopyFrom (InStream, InStream.Size-MyGrep.SearchStartPos+1);
    end;
  AStrStr.Free;
  MyGrep.Free;
  end;
end;


(******************************************************************************)
function ReadNextTagInStream (AStream: TStream; TagList: array of string;
                              var Attrib, Contents: string): integer;
(******************************************************************************
 ENTRY: AStream .......... stream to reads tags from
        TagList .......... list of valid tags

 EXIT:  attrib ........... found tag attributes
        contents ......... found tag contents
        function returns index of found tag
 ******************************************************************************)


function MatchTags (Instring: string): integer;
(*-------------------------------------------*)

var
  i  : integer;

begin
instring := lowercase(instring);
i := 0;
while (instring <> TagList[i]) and (i < high(TagList)) do
  inc (i);
MatchTags := i;
end;


var
  cc      : char;
  xmltag  : string;
  ix      : integer;
  fc      : integer;

begin
attrib := '';
contents := '';
fc := AStream.read (cc, 1);
while (fc > 0) and (cc <> '<') do  // read starting tag
  fc := AStream.read (cc, 1);
xmltag := '';
while (fc > 0) and (cc <> '>') do
  begin
  fc := AStream.Read (cc, 1);
  if fc > 0 then
    xmltag := xmltag  + cc;
  end;
if pos ('/>', xmltag) > 0
  then begin  // empty tag
       ix := pos (' ', xmltag);
       attrib := StripLTBlanks(copy (xmltag, ix+1, length(xmlTag)-ix-2));
       delete (xmltag, ix, length(xmlTag)-ix+1);
       result := MatchTags(xmlTag);
       end
  else begin  // get tag
       ix := pos (' ', xmltag);
       if ix > 0 then
         begin
         attrib := StripLTBlanks(copy (xmltag, ix+1, length(xmlTag)-ix-1));
         delete (xmltag, ix, length(xmlTag)-ix);
         end;
       delete (xmltag, length(xmlTag), 1);
       result := MatchTags(xmlTag);
       cc := ' ';
       while (fc > 0) and (cc <> '>') do
         begin
         fc := AStream.read (cc, 1);
         if fc > 0 then
           contents := contents + cc;
         end;
       ix := pos ('</', contents);
       if ix > 0 then
         begin
         delete (contents, ix, length(contents)-ix);
         end;
       delete (contents, length(contents), 1);
       end;
end;


(******************************************************************************)
function ReadNextTagInTextFile (var AFile: TextFile; TagList: array of string;
                                var Attrib, Contents: string): integer;
(******************************************************************************
 ENTRY: AFile ............ file to reads tags from
        TagList .......... list of valid tags

 EXIT:  attrib ........... found tag attributes
        contents ......... found tag contents
        function returns index of found tag
 ******************************************************************************)


function MatchTags (Instring: string): integer;
(*-------------------------------------------*)

var
  i  : integer;

begin
instring := lowercase(instring);
i := 0;
while (instring <> TagList[i]) and (i < high(TagList)) do
  inc (i);
MatchTags := i;
end;


var
  cc      : char;
  xmltag  : string;
  ix      : integer;

begin
attrib := '';
contents := '';
read (AFile, cc);
while not eof(AFile) and (cc <> '<') do  // read starting tag
  read (AFile, cc);
xmltag := '';
while not eof(AfIle) and (cc <> '>') do
  begin
  read (AFile, cc);
  xmltag := xmltag  + cc;
  end;
if pos ('/>', xmltag) > 0
  then begin  // empty tag
       ix := pos (' ', xmltag);
       attrib := StripLTBlanks(copy (xmltag, ix+1, length(xmlTag)-ix-2));
       delete (xmltag, ix, length(xmlTag)-ix+1);
       result := MatchTags(xmlTag);
       end
  else begin  // get tag
       ix := pos (' ', xmltag);
       if ix > 0 then
         begin
         attrib := StripLTBlanks(copy (xmltag, ix+1, length(xmlTag)-ix-1));
         delete (xmltag, ix, length(xmlTag)-ix);
         end;
       delete (xmltag, length(xmlTag), 1);
       result := MatchTags(xmlTag);
       cc := ' ';
       while (not eof(AFile) and (cc <> '>')) do
         begin
         read (AFile, cc);
         contents := contents + cc;
         end;
       ix := pos ('</', contents);
       if ix > 0 then
         begin
         delete (contents, ix, length(contents)-ix);
         end;
       delete (contents, length(contents), 1);
       end;
end;



var
  iiii : integer;

(******************************************************************************)
initialization
(******************************************************************************)

begin
for iiii:=0 to MaxMarks do
  Marks[iiii] := 0;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  ShowMessagePos (GetVisMsgStr, 100,100);
  Halt;
  end;
{$ENDIF}
end;

end.
