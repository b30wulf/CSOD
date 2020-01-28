(******************************************************************)
function FormatData (data: double; NumWidth: integer; NDecP: integer): string;
(******************************************************************)

var
  astr : string;

begin
case NDecP of
  0  : if (abs(Data) > 999999999.0) or
          (abs(Data) < 1.0) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:0,astr);
  1  : if (abs(Data) > 9999999.9) or
          (abs(Data) < 0.1) and (data <> 0)
         then astr := strff (Data,NumWidth+6,-2)
         else str (Data:NumWidth:1,astr);
  2  : if (abs(Data) > 999999.99) or
          (abs(Data) < 0.01) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:2,astr);
  3  : if (abs(Data) > 99999.999) or
          (abs(Data) < 0.001) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:3,astr);
  4  : if (abs(Data) > 9999.9999) or
          (abs(Data) < 0.0001) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:4,astr);
  5  : if (abs(Data) > 999.99999) or
          (abs(Data) < 0.00001) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:5,astr);
  6  : if (abs(Data) > 99.999999) or
          (abs(Data) < 0.000001) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:6,astr);
  7  : if (abs(Data) > 9.9999999) or
          (abs(Data) < 0.0000001) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:7,astr);
  8  : if (abs(Data) > 0.99999999) or
          (abs(Data) < 0.00000001) and (data <> 0)
         then astr := strff(Data,NumWidth+6,-2)
         else str (Data:NumWidth:8,astr);
  else astr := strff(Data,NumWidth+6,-2)
end;
FormatData := astr;
end;
