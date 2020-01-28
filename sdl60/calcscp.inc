(******************************************************************)
procedure CalcScalePars (Ntick: integer;
                         LowVal, HighVal: double;
                         var LowTick, Distance: double;
                         var Divi: word);
(******************************************************************
ENTRY: ntick ..... number of ticks on scale
       LowVal .... beginning of scaling
       HighVal ... end point of scaling

EXIT:  LowTick ... first Tick on scale
       Distance .. distance of scale ticks
       Divi ...... number of divisions between scaling labels
*******************************************************************)

const
  ln10        : extended = 2.302585092994045684018;
  lg2         : extended = 0.301029995663981195214;
  lg5         : extended = 0.698970004336018804803;


var
  a, b : double;
  Sign : integer;

begin
if HighVal = LowVal
  then begin
       LowTick := LowVal;
       Distance := 0.0;
       Divi := 1;
       end
  else begin
       if HighVal > LowVal
         then Sign := 1
         else Sign := -1;
       a := ln(abs(HighVal-LowVal)/NTick)/ln10;
       b := a-int(a);
       if ((a < 0) and (b <> 0)) then a := a-1;
       if (b < 0) then b := b+1;
       if b < lg2 then
         begin
         a := int(a);
         divi := 5;
         end;
       if ((b < lg5) and (b >= lg2)) then
         begin
         a := int(a) + lg2;
         divi := 4;
         end;
       if (b >= lg5) then
         begin
         a := int(a) + lg5;
         divi := 5;
         end;
       Distance := Sign*exp(a*ln10);
       LowTick := Distance*(int(LowVal/Distance)-1);
       while (Sign*(LowVal-LowTick) > 0.001*abs(Distance))  do
         LowTick := LowTick + Distance;
       end;
end;


