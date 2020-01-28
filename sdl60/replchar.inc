(******************************************************************)
function NumberedPos (SubStr, MainStr: string; StartIx, Count: integer;
                      IgnoreCase: boolean): integer;
(******************************************************************
  ENTRY:  Substr ...... sub string to be searched for
          MainStr ..... string to be searched in
          StartIx ..... index of MainStr where to start search
          Count ....... count of occurence when to stop search
          IgnoreCase .. TRUE: ignore case of search

  EXIT:   function returns 0 if Substr is not contained Count times
          (when searching from StartIx)
 ******************************************************************)

var
  ix     : integer;

begin
if IgnoreCase then
  begin
  Substr := lowercase(SubStr);
  Mainstr := lowercase(MainStr);
  end;
if StartIx < 1 then
  StartIx := 1;
if count > 0
  then result := StartIx-length(Substr)
  else result := 0;
if StartIx > 1 then
  delete (MainStr, 1, StartIx-1);
ix := 1;
while (Count > 0) and (ix > 0) do
  begin
  ix := pos (SubStr, MainStr);
  dec (Count);
  result := result + ix + length(Substr)-1;
  delete (MainStr, 1, ix+length(SubStr)-1);
  end;
if ix = 0 then
  result := 0;
end;


(******************************************************************)
function ReplaceCharInString (Instring: string; OldChar, NewChar: char): string;
(******************************************************************
  ENTRY:   Instring ... string to be processed
           OldChar .... character to be replaced
           NewChar .... new character
  EXIT:    string has all characters 'OldChar' replaced by 'NewChar'
 ******************************************************************)

var
  i     : integer;

begin
for i:=1 to length(Instring) do
  if Instring[i] = OldChar then
    Instring[i] := NewChar;
ReplaceCharInString := Instring;
end;

(******************************************************************)
function ReplaceStringInString (Instring: string; OldStr,
                                NewStr: string; IgnoreCase : boolean): string;
(******************************************************************
  ENTRY:   Instring .... string to be processed
           OldStr ...... substring to be replaced
           NewStr ...... new substring
           IgnoreCase .. case of search string is ignored
  EXIT:    string has all substrings 'OldStr' replaced by 'NewStr'
 ******************************************************************)

var
  ix      : integer;
  StartIx : integer;

begin
StartIx := 1;
repeat
  ix := NumberedPos (OldStr, Instring, StartIx, 1, IgnoreCase);
  if ix > 0 then
    begin
    delete (Instring, ix, length(OldStr));
    insert (NewStr, Instring, ix);
    StartIx := ix + length(NewStr);
    end;
until ix=0;
ReplaceStringInString := Instring;
end;


