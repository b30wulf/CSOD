unit utlTimeDate;

interface

uses Sysutils, Windows;

type CDTRouting = class
public
     function  IsLeapYear(_Year : WORD) : Boolean;
     function  CompareMonth(dt_Date1, dt_Date2 : TDateTime) : byte;
     function  CompareDay(dt_Date1, dt_Date2  : TDateTime) : byte;
     function  CompareDayF(dt_Date1, dt_Date2 : TDateTime) : byte;
     procedure EncodeDateTimeBTI(dt_Date : TDateTime; var DateInfo : array of Byte);
     function  EndDateDay(dt_Date : TDateTime) : TDateTime;
     procedure IncYear(var dt_Date : TDateTime);
     procedure DecMonth(var dt_Date : TDateTime);
     function  DecMonthOnly(dt_Date : TDateTime) : TDateTime;
     procedure IncMonth(var dt_Date : TDateTime);
     function  DayPerMonth(Month, Year : word) : byte;
     function  DecDate(var Date : TDateTime) : TDateTime;
     function  IncDate(var Date : TDateTime) : TDateTime;
     function  GetNameMonth(month : byte):string;
     function  GetNameMonth0(month : byte):string;
     function  DifDays(Date1, Date2 : TDateTime):integer;
     function  EndMonth(dt_Date : TDateTime) : TDateTime;
     function  GetBeginMonth(var dt_Date : TDateTime) : TDateTime;
     function  FormDateForBTIPrir(dt_Date : TDateTime) : TDateTime;
     //function  BeginMonth(dt_Date : TDateTime) : TDateTime;
     function  EndDayMonth(var Date : TDateTime) : TDateTime;
     function  NowFirstDayMonth : TDateTime;
     function  MinuteSpan(const ANow, AThen: TDateTime): Double;
     function  SpanOfNowAndThen(const ANow, AThen: TDateTime): TDateTime;
     function  SetTimeToPC(dt_Date : TDateTime):boolean;
     function  GetSeason(dt_Date : TDateTime): integer;
     function  DateNowOutMSec : TDateTime;
     function  DateTimeToSec(dt_Date : TDateTime)  : integer;
     function  SecToDateTime(sec : integer) : TDateTime;
end;
const
 HoursPerDay = 24;
 MinsPerHour = 60;
 //*SecsPerMin * *= 60;
 //*MSecsPerSec * = 1000;
 MinsPerDay = HoursPerDay * MinsPerHour;
 // *SecsPerDay * *= MinsPerDay * SecsPerMin;
 // *MSecsPerDay * = SecsPerDay * MSecsPerSec;
var cDateTimeR : CDTRouting;

const
   c_DaysPerMonth : array [1..12] of WORD = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);


implementation

//‘ункци€ сравнени€ мес€цев, если равны то        возвращаетс€ 0
//                                Month1 > Month2 возвращаетс€ 1
//                                Month1 < Month2 возвращаетс€ 2

function  CDTRouting.IsLeapYear(_Year : WORD) : Boolean;
begin
    Result := ( ((_Year mod 4) = 0) AND ((_Year mod 100) > 0)) OR ((_Year mod 400) = 0);
end;

function CDTRouting.MinuteSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := MinsPerDay * SpanOfNowAndThen(ANow, AThen);
end;

function CDTRouting.SpanOfNowAndThen(const ANow, AThen: TDateTime): TDateTime;
begin
  if ANow < AThen then
    Result := AThen - ANow
  else
    Result := ANow - AThen;
end;

function CDTRouting.CompareMonth(dt_Date1, dt_Date2 : TDateTime) : byte;
var
   Year1, Month1, Day1 : word;
    Year2, Month2, Day2 : word;
begin
   Result := $FF;
   DecodeDate(dt_Date1, Year1, Month1, Day1);
   DecodeDate(dt_Date2, Year2, Month2, Day2);
   if (Year1 = Year2) and (Month1 = Month2) then
     Result := 0;
   if ((Year1 = Year2) and (Month1 > Month2)) or (Year1 > Year2) then
     Result := 1;
   if ((Year1 = Year2) and (Month1 < Month2)) or (Year1 < Year2) then
     Result := 2;
end;


function  CDTRouting.CompareDay(dt_Date1, dt_Date2  : TDateTime) : byte;
var Year1, Month1, Day1 : word;
    Year2, Month2, Day2 : word;
    res                 : byte;
begin
   DecodeDate(dt_Date1, Year1, Month1, Day1);
   DecodeDate(dt_Date2, Year2, Month2, Day2);
   if (Year1 = Year2) and (Month1 = Month2) and (Day1 = Day2) then
     res := 0
     else
       if (Year1 > Year2) or ((Year1 = Year2) and (Month1 > Month2)) or
          ((Year1 = Year2) and (Month1 = Month2) and (Day1 > Day2)) then
         res := 1
           else
             res := 2;
   Result := res;
end;
{
   ”скоренна€ верси€
   TDateTime - Double
   секунды - дробна€ часть
   дни     - цела€ часть
}
function CDTRouting.CompareDayF(dt_Date1, dt_Date2 : TDateTime) : byte;
var
   l_Delta : Double;
begin
   Result := $FF;

   dt_Date1 := Trunc(dt_Date1);
   dt_Date2 := Trunc(dt_Date2);

   l_Delta := dt_Date1 - dt_Date2;   

   Result := Trunc(l_Delta);

   if (l_Delta > 0) then
      Result := 1
   else if (l_Delta < 0) then
      Result := 2;
end;

function  CDTRouting.DifDays(Date1, Date2 : TDateTime):integer;
var count : integer;
begin
   count := 0;
   while CompareDay(Date1, Date2) <> 1 do
   begin
     IncDate(Date1);
     Inc(count);
   end;
   Result := count;
end;

procedure CDTRouting.EncodeDateTimeBTI(dt_Date : TDateTime; var DateInfo : array of Byte);
var Year, Month, Day   : word;
    Sec, Min, Hour, ms : word;
begin
   if dt_Date = 0 then
   begin
     FillChar(DateInfo[0], 6, 0);
     exit;
   end;
   DecodeDate(dt_Date, Year, Month, Day);
   DecodeTime(dt_Date, Hour, Min, Sec, ms);
   DateInfo[0] := Year mod 100;
   DateInfo[1] := Month;
   DateInfo[2] := Day;
   DateInfo[3] := Hour;
   DateInfo[4] := Min;
   DateInfo[5] := Sec;
end;

function CDTRouting.EndDateDay(dt_Date : TDateTime) : TDateTime;
begin
   Result := dt_Date;
   ReplaceTime(Result, EncodeTime(23, 59, 59, 999));
end;

procedure CDTRouting.IncYear(var dt_Date : TDateTime);
var Year, Month, Day : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   Year := Year + 1;
   dt_Date := EncodeDate(Year, 1, 1);
end;

procedure CDTRouting.DecMonth(var dt_Date : TDateTime);
var Year, Month, Day : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   if Month = 1 then
   begin
     Dec(Year);
     Month := 12;
   end
   else
     Dec(Month);
   if (Year = 0) and (Month = 0) then
   begin
     dt_Date := 0;
   end;
   try
     dt_Date := EncodeDate(Year, Month, 1);
   except

   end;
end;

function CDTRouting.DecMonthOnly(dt_Date : TDateTime) : TDateTime;
var
   Year, Month, Day : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   if Month = 1 then
   begin
     Dec(Year);
     Month := 12;
   end
   else
     Dec(Month);
{
   if (Year = 0) and (Month = 0) then
   begin
     Result := 0;
   end;
}
   try
     if Day > DayPerMonth(Month, Year) then
       Day := DayPerMonth(Month, Year);
     Result := EncodeDate(Year, Month, Day);
   except
     Result := Now;
   end;
end;

procedure CDTRouting.IncMonth(var dt_Date : TDateTime);
var Year, Month, Day : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   if Month = 12 then
   begin
     Month := 1;
     Inc(Year);
   end
   else
     Inc(Month);
   if (Year = 0) and (Month = 0) then
   begin
     dt_Date := 0;
   end;
   try
     dt_Date := EncodeDate(Year, Month, 1);
   except

   end;
end;

function CDTRouting.EndMonth(dt_Date : TDateTime) : TDateTime;
var
   Year, Month, Day : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   Day    := DayPerMonth(Month, Year);
   Result := EncodeDate(Year, Month, Day);
end;

function  CDTRouting.GetBeginMonth(var dt_Date : TDateTime) : TDateTime;
var
   Year, Month, Day  : word;
begin
   Result := 0;
   DecodeDate(dt_Date, Year, Month, Day);
   Day    := 1;
   Result := EncodeDate(Year, Month, Day);
end;

function  CDTRouting.FormDateForBTIPrir(dt_Date : TDateTime) : TDateTime;
var
   Year, Month, Day    : word;
begin
   Result := 0;
   if (dt_Date > Now) then
   begin
     dt_Date := Now;
     exit;
   end
   else
     DecMonth(dt_Date);
   DecodeDate(dt_Date, Year, Month, Day);
   Result := EncodeDate(Year, Month, Day) + EncodeTime(23, 59, 59, 0);
end;

function  CDTRouting.DayPerMonth(Month, Year : word) : byte;
begin
   Result := c_DaysPerMonth[Month];
   if IsLeapYear(Year) then
      Inc(Result);

{   if not ((0 < Month) AND (Month < 13)) then
      raise Exception.Create('CDTRouting.DayPerMonth :> Month out of range');
   if (Month = 1) or (Month = 3) or (Month = 5) or
       (Month = 7) or (Month = 8) or (Month = 10) or (Month = 12) then
     Result := 31;
   if (Month = 4) or (Month = 6) or (Month = 9) or (Month = 11) then
     Result := 30;
   if (Month = 2) then
     Result := 28;
   if (Month = 2) and (Year mod 4 = 0) then
     Result := 29;
}

end;

function CDTRouting.EndDayMonth(var Date : TDateTime) : TDateTime;
var Year, Month, Day : word;
begin
   DecodeDate(Date, Year, Month, Day);
   Day := DayPerMonth(Month, Year);
   Date := EncodeDate(Year, Month, Day);
   Result := Date;
end;

function CDTRouting.DecDate(var Date : TDateTime) : TDateTime;
var
   Month, Year, Day : WORD;
DecMonth             : boolean;
begin
   DecodeDate(Date, Year, Month, Day);
   DecMonth := false;
   if Day = 1 then
   begin
//   (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
     if (Month = 2) or (Month = 4) or (Month = 6) or
        (Month = 8) or (Month = 9) or (Month = 11) or (Month = 1) then
     begin
       Day := 31;
       DecMonth := true;
     end;
     if (Month = 5) or (Month = 7) or (Month = 10) or (Month = 12) then
     begin
       Day := 30;
       DecMonth := true;
     end;
     if Month = 3 then
     begin
       Day := 28;
       DecMonth := true;
     end;
     if (Month = 4) and (Year mod 4 = 0) then
     begin
       Day := 29;
       DecMonth := true;
     end;
   end
   else
     Day := Day - 1;
   if DecMonth then
   begin
     if Month = 1 then
     begin
       Month := 12;
       Year := Year - 1;
     end
     else
       Month := Month - 1;
   end;
   Date := EncodeDate(Year, Month, Day);
   Result := Date;
end;

function CDTRouting.IncDate(var Date : TDateTime) : TDateTime;
var Month, Year, Day : word;
IncMonth             : boolean;
begin
   DecodeDate(Date, Year, Month, Day);
   IncMonth := false;
   if (Day = 28) and (Month = 2) and (Year mod 4 <> 0) then
   begin
     Day := 1;
     IncMonth := true;
   end;
   if (Day = 29) and (Month = 2) and (Year mod 4 = 0) then
   begin
     Day := 1;
     IncMonth := true;
   end;
   if (Day = 31) and ((Month = 1) or (Month = 3) or (Month = 5)
       or (Month = 7) or (Month = 8) or (Month = 10) or (Month = 12)) then
   begin
     Day := 1;
     IncMonth := true;
   end;
   if (Day = 30) and ((Month = 4) or (Month = 6) or (Month = 9) or (Month = 11)) then
   begin
     Day := 1;
     IncMonth := true;
   end;
   if not IncMonth then
     Inc(Day)
   else
   begin
     Inc(Month);
     if Month = 13 then
     begin
       Inc(Year);
       Month := 1;
     end;
   end;
   Date := EncodeDate(Year, Month, Day);
   Result := Date;
end;

function  CDTRouting.GetNameMonth(month : byte):string;
begin
   case month of
     1  : Result := '€нваре';
     2  : Result := 'феврале';
     3  : Result := 'марте';
     4  : Result := 'апреле';
     5  : Result := 'мае';
     6  : Result := 'июне';
     7  : Result := 'июле';
     8  : Result := 'августе';
     9  : Result := 'сент€бре';
     10 : Result := 'окт€бре';
     11 : Result := 'но€бре';
     12 : Result := 'декабре';
   end;
end;
function  CDTRouting.GetNameMonth0(month : byte):string;
begin
   case month of
     1  : Result := '€нварь';
     2  : Result := 'февраль';
     3  : Result := 'март';
     4  : Result := 'апрель';
     5  : Result := 'май';
     6  : Result := 'июнь';
     7  : Result := 'июль';
     8  : Result := 'август';
     9  : Result := 'сент€брь';
     10 : Result := 'окт€брь';
     11 : Result := 'но€брь';
     12 : Result := 'декабрь';
   end;
end;

function  CDTRouting.NowFirstDayMonth : TDateTime;
var Year, Month, Day : word;
begin
   DecodeDate(Now, Year, Month, Day);
   Day := 1;
   Result := EncodeDate(Year, Month, Day);
end;

function CDTRouting.SetTimeToPC(dt_Date : TDateTime):boolean;
var Time               : _SYSTEMTIME;
    Year, Month, Day   : word;
    Hour, Min, Sec, ms : word;
    HourN, MinN, SecN  : word;
    TimeKorr           : integer;
begin
   Result := false;
   DecodeDate(dt_Date, Year, Month, Day);
   DecodeTime(dt_Date, Hour, Min, Sec, ms);
   DecodeTime(Now, HourN, MinN, SecN, ms);
   TimeKorr := abs((HourN - Hour)*3600 + (MinN- Min)*60 + (SecN - Sec));
   if TimeKorr > 900 then //≈сли разбежка более 15 мин то врем€ не корректируетс€
     exit;
   Time.wMilliseconds := 0;
   Time.wSecond    := Sec;
   Time.wMinute    := Min;
   Time.wHour      := Hour;
   Time.wDay       := Day;
   Time.wMonth     := Month;
   Time.wYear      := Year;
   Result := SetLocalTime(Time);
end;

{
   Ukrop
   —езон по умолчанию - 0 (зима)
}
function  CDTRouting.GetSeason(dt_Date : TDateTime): integer;
var
   year, month, day,
   hour, min, sec, ms : word;
begin
   Result := 0; // зима
   DecodeDate(dt_Date, year, month, day);
   DecodeTime(dt_Date, hour, min, sec, ms);

   if (month > 3) or (month < 10) then
     Result := 1;


   if (month = 3) and (Day + (8 - DayOfWeek(dt_Date)) > 31) then
     Result := 1;




   if (month = 10) and (Day + (8 - DayOfWeek(dt_Date)) < 31) then
     Result := 1;
   if (month = 3) and (Day + (8 - DayOfWeek(dt_Date)) > 31)
     and (DayOfWeek(dt_Date) = 1) and (Hour > 2) then
     Result := 1;






   if (month = 10) and (Day + (8 - DayOfWeek(dt_Date)) > 31)
     and (DayOfWeek(dt_Date) = 1) and (Hour < 3) then
     Result := 1;
     
   {
   if (month > 3) or (month < 10) then
     Result := 1;
   if (month < 3) or (month > 10) then
     Result := 0;
   if (month = 3) and (Day + (8 - DayOfWeek(dt_Date)) > 31) then
     Result := 1;
   if (month = 3) and (Day + (8 - DayOfWeek(dt_Date)) < 31) then
     Result := 0;
   if (month = 10) and (Day + (8 - DayOfWeek(dt_Date)) > 31) then
     Result := 0;
   if (month = 10) and (Day + (8 - DayOfWeek(dt_Date)) < 31) then
     Result := 1;
   if (month = 3) and (Day + (8 - DayOfWeek(dt_Date)) > 31)
     and (DayOfWeek(dt_Date) = 1) and (Hour > 2) then
     Result := 1;
   if (month = 3) and (Day + (8 - DayOfWeek(dt_Date)) > 31)
     and (DayOfWeek(dt_Date) = 1) and (Hour < 2) then
     Result := 0;
   if (month = 10) and (Day + (8 - DayOfWeek(dt_Date)) > 31)
     and (DayOfWeek(dt_Date) = 1) and (Hour > 3) then
     Result := 0;
   if (month = 10) and (Day + (8 - DayOfWeek(dt_Date)) > 31)
     and (DayOfWeek(dt_Date) = 1) and (Hour < 3) then
     Result := 1;
   }
end;

function  CDTRouting.DateNowOutMSec : TDateTime;
var
    hour, min, sec, ms : word;
begin
   Result := Now();
   DecodeTime(Now(), hour, min, sec, ms);
   ReplaceTime(Result, EncodeTime(min, sec, ms, 0));
end;

function  CDTRouting.DateTimeToSec(dt_Date : TDateTime)  : integer;
var SecSize : TDateTime;
begin
   dt_Date := dt_Date - EncodeDate(2000, 1, 1);
   SecSize := EncodeTime(0, 0, 1, 0);
   Result  := round(dt_Date/SecSize);
end;

function  CDTRouting.SecToDateTime(sec : integer) : TDateTime;
var
   {l_Day, }l_Hour, l_Min : word;
begin
   Sec   := Sec mod 86400;
   l_Min := Sec div 60;
   Sec   := Sec mod 60;

   l_Hour  := l_Min div 60;
   l_Min   := l_Min mod 60;
   {l_Day   := l_Hour div 24;}
   Result := EncodeTime(l_Hour, l_Min, Sec, 0) + EncodeDate(2000, 1, 1);
end;

end.

