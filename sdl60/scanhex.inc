(**************************************************************************)
function ScanHex (Instring: string; var Idx: integer): longint;
(**************************************************************************
  ENTRY:  Instring ..... string to be converted
          Idx .......... index of string to start conversion

  EXIT:   Idx .......... index of first invalid character
          function returns integer value of hexadecimal string
 **************************************************************************)

const
  MaxHexTab = 15;
  HexTab : array [0..MaxHexTab] of char =
                           ('0','1','2','3','4','5','6','7',
                            '8','9','A','B','C','D','E','F');

var
  reslt  : longint;
  i      : integer;
  HexEnd : boolean;
  cc     : char;

begin
reslt := 0;
HexEnd := false;
while (Idx < length(Instring)) and (Instring[idx] = ' ') do
  inc (idx);
while (Idx <= length(Instring)) and not HexEnd do
  begin
  cc := upcase(Instring[idx]);
  inc(idx);
  i := -1;
  repeat
    inc (i);
  until ((cc=HexTab[i]) or (i=MaxHexTab));
  if cc=HexTab[i]
    then reslt := (reslt shl 4) + i
    else begin
         HexEnd := true;
         dec(idx);
         end;
  end;
ScanHex := reslt;
end;

