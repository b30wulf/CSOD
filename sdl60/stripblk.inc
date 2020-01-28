
(******************************************************************)
function StripLTBlanks (Instring: string): string;
(******************************************************************
ENTRY: Instring ... string to be processed

EXIT:  Function returns the string 'Instring' which has stripped the
       leading and trailing blanks off.
*******************************************************************)

var
  hstr : string;
  i,k  : integer;

begin
hstr := '';
if length(Instring) > 0 then
  begin
  i := 1;
  while (i < length(Instring)) and (Instring[i] = ' ') do
    inc (i);
  k := length(Instring);
  while (k > 1) and (Instring[k] = ' ') do
    dec (k);
  if k < i
    then hstr := ''
    else begin
         if (k=i) and (Instring[i] = ' ')
           then hstr := ''
           else hstr := copy (Instring,i,k-i+1);
         end;
  end;
StripLTBlanks := hstr;
end;



