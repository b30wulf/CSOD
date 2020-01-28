
(**************************************************************************)
function ScanFPNum (Instring: string; AllowExp: boolean; DecPChar: integer;
                    var Idx: integer): double;
(**************************************************************************
  ENTRY:  Instring ..... string to be converted
          AllowExp ..... if TRUE exponent is allowed (exponential notation)
          Idx .......... index of string to start conversion
          DecPChar ..... dec. point character: 1 = dot, 2 = colon, 3 = both

  EXIT:   Idx .......... index of first invalid character
          function returns value of floating point string

  state diagram:

  phase   digit   dot     +/-     blank	  'E'     EOS     any other
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

begin
reslt := 0;
Phase := 1;
NextPhase := -1;
astr := '';
expo := '';
while (phase > 0) and (phase <> 9) do
  begin
  if Idx > length(Instring)
    then cc := 'Z'   { trick to handle end of string }
    else cc := upcase (Instring[idx]);
  inc (idx);
  case Phase of
    1 : begin
        if ((DecPChar = 1) and (cc = '.')) or
           ((DecPChar = 2) and (cc = ',')) or
           ((DecPChar = 3) and ((cc = ',') or (cc = '.')))
             then NextPhase := 4
             else case cc of
                    '0'..'9' : NextPhase := 3;
                    '+', '-' : NextPhase := 2;
                         ' ' : NextPhase := 1;
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
                         ' ' : NextPhase := -1;
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
                         ' ' : NextPhase := 9;
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
                         ' ' : NextPhase := 9;
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
                         ' ' : NextPhase := 9;
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
                         ' ' : NextPhase := -1;
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
                         ' ' : NextPhase := -1;
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
                         ' ' : NextPhase := 9;
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
dec (idx);
if reslt > MaxDouble then      { limit range to max. double }
  reslt := MaxDouble;
if reslt < -MaxDouble then
  reslt := -MaxDouble;
ScanFPNum := reslt;
end;

