(**************************************************************************)
function strff (r: extended; FieldWidth, DecP: integer): string;
(**************************************************************************
 ENTRY: r ................. number to convert to string
        abs(FieldWidth) ... width of output field
                            if FieldWidth < 0 then leading blanks are replaced
                            by zeroes
        DecP .............. number of decimal places,
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
       str (r:abs(FieldWidth)+2:DecP,hstr);
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
  else str (r:abs(FieldWidth):DecP,hstr);
if FieldWidth < 0 then
  begin
  i:=1;
  while hstr[i] = ' ' do
    begin
    hstr[i] := '0';
    inc (i);
    end;
  if i <= length(hstr) then
    if hstr[i] = '-' then
      begin
      hstr[i] := '0';
      hstr[1] := '-'
      end;
  end;
strff := hstr;
end;


