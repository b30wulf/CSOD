unit utlTimeDate;

interface

uses Sysutils;

type CDTRouting = class
public
     function  CompareMonth(dt_Date1, dt_Date2 : TDateTime) : byte;
     function  CompareDay(dt_Date1, dt_Date2  : TDateTime) : byte;
     procedure DecMonth(var dt_Date : TDateTime);
     procedure IncMonth(var dt_Date : TDateTime);
     function  DayPerMonth(Month, Year : word) : byte;
     function  DecDate(var Date : TDateTime) : TDateTime;
     function  IncDate(var Date : TDateTime) : TDateTime;
     function  GetNameMonth(month : byte):string;
     function  DifDays(Date1, Date2 : TDateTime):integer;
     function  EndMonth(dt_Date : TDateTime) : TDateTime;
     function  EndDayMonth(var Date : TDateTime) : TDateTime;
     function  NowFirstDayMonth : TDateTime;
end;

var cDateTimeR : CDTRouting;

implementation

//‘ункци€ сравнени€ мес€цев, если равны то        возвращаетс€ 0
//                                Month1 > Month2 возвращаетс€ 1
//                                Month1 < Month2 возвращаетс€ 2
function CDTRouting.CompareMonth(dt_Date1, dt_Date2 : TDateTime) : byte;
var Year1, Month1, Day1 : word;
    Year2, Month2, Day2 : word;
    res                 : byte;
begin
   DecodeDate(dt_Date1, Year1, Month1, Day1);
   DecodeDate(dt_Date2, Year2, Month2, Day2);
   if (Year1 = Year2) and (Month1 = Month2) then
     res := 0;
   if ((Year1 = Year2) and (Month1 > Month2)) or (Year1 > Year2) then
     res := 1;
   if ((Year1 = Year2) and (Month1 < Month2)) or (Year1 < Year2) then
     res := 2;
   Result := res;
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
var Year, Month, Day : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   Day := DayPerMonth(Month, Year);
   Result := EncodeDate(Year, Month, Day);
end;

function  CDTRouting.DayPerMonth(Month, Year : word) : byte;
begin
   if (Month = 1) or (Month = 3) or (Month = 5) or
       (Month = 7) or (Month = 8) or (Month = 10) or (Month = 12) then
     Result := 31;
   if (Month = 4) or (Month = 6) or (Month = 9) or (Month = 11) then
     Result := 30;
   if (Month = 2) then
     Result := 28;
   if (Month = 2) and (Year mod 4 = 0) then
     Result := 29;
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
var Month, Year, Day : word;
DecMonth             : boolean;
begin
   DecodeDate(Date, Year, Month, Day);
   DecMonth := false;
   if Day = 1 then
   begin
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

function  CDTRouting.NowFirstDayMonth : TDateTime;
var Year, Month, Day : word;
begin
   DecodeDate(Now, Year, Month, Day);
   Day := 1;
   Result := EncodeDate(Year, Month, Day);
end;

end.

