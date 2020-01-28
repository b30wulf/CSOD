
(**************************************************************************)
function ScanDecimal (Instring: string; var Idx: integer): longint;
(**************************************************************************
  ENTRY:  Instring ..... string to be converted
          Idx .......... index of string to start conversion

  EXIT:   Idx .......... index of first invalid character
          function returns integer value of decimal string
 **************************************************************************)

var
  reslt  : longint;
  i      : integer;
  DecEnd : boolean;
  cc     : char;
  NegSgn : boolean;

begin
reslt := 0;
if length(InString) > 0 then
  begin
  DecEnd := false;
  while (Idx < length(Instring)) and (Instring[idx] = ' ') do
    inc (idx);
  NegSgn := false;
  if Instring[idx] = '-'
    then begin
         inc (Idx);
         NegSgn := true;
         end
    else if Instring[idx] = '+' then
           inc (Idx);
  while (Idx <= length(Instring)) and not DecEnd do
    begin
    cc := upcase(Instring[idx]);
    inc(idx);
    i := ord(cc)-ord('0');
    if (i <= 9) and (i >= 0)
      then reslt := 10*reslt + i
      else begin
           DecEnd := true;
           dec(idx);
           end;
    end;
  if NegSgn then
    reslt := -reslt;
  end;
ScanDecimal := reslt;
end;

