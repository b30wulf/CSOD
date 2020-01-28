(**************************************************************************)
function ScanBin (Instring: string; var Idx: integer): longint;
(**************************************************************************
  ENTRY:  Instring ..... string to be converted
          Idx .......... index of string to start conversion

  EXIT:   Idx .......... index of first invalid character
          function returns integer value of binary string
 **************************************************************************)

var
  reslt  : longint;
  i      : integer;
  BinEnd : boolean;
  cc     : char;

begin
reslt := 0;
BinEnd := false;
while (Idx < length(Instring)) and (Instring[idx] = ' ') do
  inc (idx);
while (Idx <= length(Instring)) and not BinEnd do
  begin
  cc := upcase(Instring[idx]);
  inc(idx);
  i := ord(cc)-ord('0');
  if (i <= 1) and (i >= 0)
    then reslt := (reslt shl 1) + i
    else begin
         BinEnd := true;
         Dec(idx);
         end;
  end;
ScanBin := reslt;
end;

