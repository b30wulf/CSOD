
(**************************************************************************)
function ScanOctal (Instring: string; var Idx: integer): longint;
(**************************************************************************
  ENTRY:  Instring ..... string to be converted
          Idx .......... index of string to start conversion

  EXIT:   Idx .......... index of first invalid character
          function returns integer value of octal string
 **************************************************************************)

var
  reslt  : longint;
  i      : integer;
  OctEnd : boolean;
  cc     : char;

begin
reslt := 0;
OctEnd := false;
while (Idx < length(Instring)) and (Instring[idx] = ' ') do
  inc (idx);
while (Idx <= length(Instring)) and not OctEnd do
  begin
  cc := upcase(Instring[idx]);
  inc(idx);
  i := ord(cc)-ord('0');
  if (i <= 7) and (i >= 0)
    then reslt := (reslt shl 3) + i
    else begin
         OctEnd := true;
         dec(idx);
         end;
  end;
ScanOctal := reslt;
end;

