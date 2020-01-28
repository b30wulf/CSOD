unit Dates;

interface

uses
  SysUtils, Classes;
 //DOBAVLENO SLOVO PIPISKA
type
  RepCONFIG = class
  private

    FMonth,
    FDay,
    FYear,
    FMonth2,
    FDay2,
    FYear2,
    FDetail   : Integer;

    FNeedAllData,
    FDecodeSummary,
    FActiveEnergyPlus,
    FActiveEnergyMinus,
    FReactEnergyPlus,
    FReactEnergyMinus   : Boolean;

    FOnChange: TNotifyEvent;
  protected
    procedure SetMonth (Value: Integer);
    procedure SetYear (Value: Integer);
    procedure SetDay (Value: Integer);
    procedure DoChange; virtual;

    function DaysInMonth: Integer;
  public
    constructor Init (d, m, y: Integer);

    procedure SetValue (d, m, y: Integer);
    procedure Increase;
    procedure Decrease;
    procedure Add (NumberOfDays: Integer);
    procedure Subtract (NumberOfDays: Integer);

    function LeapYear    : Boolean;
    function GetText     : string;
    function getCurYear  : Integer;
    function getCurMonth : Integer;
    function getCurDay   : Integer;
    // Return Day.Month.Year of Report Date (format '%d.%d.%d')
    property Text: string read GetText;

    // Report Date
    property Day: Integer    read FDay    write SetDay;
    property Month: Integer  read FMonth  write SetMonth;
    property Year: Integer   read FYear   write SetYear;

    //property NewDay: Integer    read FDay    write SetNewDay;
    property Month2: Integer  read FMonth2     write SetMonth;
    property Year2: Integer   read FYear2      write SetMonth;

    // Reports Configurations
    // 1.Energy Type
    property ActiveEnergyPlus  : Boolean  read FActiveEnergyPlus   write FActiveEnergyPlus;
    property ActiveEnergyMinus : Boolean  read FActiveEnergyMinus  write FActiveEnergyMinus;
    property ReactEnergyPlus   : Boolean  read FReactEnergyPlus    write FReactEnergyPlus;
    property ReactEnergyMinus  : Boolean  read FReactEnergyMinus   write FReactEnergyMinus;

    // 2.
    property NeedAllData: Boolean read FNeedAllData write FNeedAllData;

    // 3. Type of detalization
    property Detail : Integer read FDetail write FDetail;

    // 4.
    property DecodeSummary : Boolean read FDecodeSummary write FDecodeSummary;

    property OnChange: TNotifyEvent
      read FonChange write FOnChange;
  end;


type
  EDateOutOfRange = class (Exception);

implementation

constructor RepCONFIG.Init (d, m, y: Integer);
begin
  SetValue (d, m, y);
end;

procedure RepCONFIG.DoChange;
begin
  if Assigned (FOnChange) then
    FOnChange (self);
end;

procedure RepCONFIG.SetValue (d, m, y: Integer);
var
  OldY, OldM: Integer;
begin
  // store the old value
  OldY := FYear;
  OldM := FMonth;
  // assing the new value
  try
    FYear := y;
    // check the ranges
    SetMonth (m);
    SetDay (d);
    DoChange;
  except
    on EDateOutOfRange do
    begin
      // reset the values
      FYear := OldY;
      FMonth := OldM;
      // let the error show up
      raise;
    end;
  end;
end;

procedure RepCONFIG.SetMonth (Value: Integer);
begin
  if (Value >= 1) and (Value < 12) then
  begin
    FMonth  := Value;
    FMonth2 := Value + 1;
    FYear2  := FYear;
    DoChange;
  end
  else if Value = 12 then begin
    FMonth2 := 1;
    FYear2  := FYear+1;
  end
  else
    raise EDateOutOfRange.Create ('Month out of range');
end;

procedure RepCONFIG.SetYear (Value: Integer);
begin
  FYear := Value;
  DoChange;
end;

procedure RepCONFIG.SetDay (Value: Integer);
begin
  if (Value >= 1) and (Value <= DaysInMonth) then
  begin
    FDay := Value;
    DoChange;
  end
  else
    raise EDateOutOfRange.Create ('Day out of range');
end;

function RepCONFIG.LeapYear: Boolean;
begin
  // compute leap years, considering "exceptions"
  if (FYear mod 4 <> 0) then
    LeapYear := False
  else if (FYear mod 100 <> 0) then
    LeapYear := True
  else if (FYear mod 400 <> 0) then
    LeapYear := False
  else
    LeapYear := True;
end;

function RepCONFIG.DaysInMonth: Integer;
begin
  case FMonth of
    1, 3, 5, 7, 8, 10, 12:
      DaysInMonth := 31;
    4, 6, 9, 11:
      DaysInMonth := 30;
    2:
      if (LeapYear) then
        DaysInMonth := 29
      else
        DaysInMonth := 28;
    else
      // if the month is not correct
      DaysInMonth := 0;
  end;
end;

procedure RepCONFIG.Increase;
begin
  // if this day is not the last of the month
  if FDay < DaysInMonth then
    Inc (FDay) // increase the value by 1
  else
  // if it is not in December
    if FMonth < 12 then
    begin
      // Day 1 of next month
      Inc (FMonth);
      FDay := 1;
    end
    else
    begin
      // else it is next year New Year's Day
      Inc (FYear);
      FMonth := 1;
      FDay := 1;
    end;
  DoChange;
end;

// exactly the reverse of the Increase method
procedure RepCONFIG.Decrease;
begin
  if FDay > 1 then
    Dec (FDay) // decrease the value by 1
  else
    // it is the first of a month
    if FMonth > 1 then
    begin
      // assign last day of previous month
      Dec (FMonth);
      FDay := DaysInMOnth;
    end
    else
    // it is the first of January
    begin
      // assign last day of previous year
      Dec (FYear);
      FMonth := 12;
      FDay := DaysInMOnth;
    end;
  DoChange;
end;

function RepCONFIG.GetText: string;
begin
  GetText :=  Format ('%d.%d.%d', [Day, Month, Year]);
end;

procedure RepCONFIG.Add (NumberOfDays: Integer);
var
  N: Integer;
begin
  // increase the day n times
  for N := 1 to NumberOfDays do
    Increase;
end;

procedure RepCONFIG.Subtract (NumberOfDays: Integer);
var
  N: Integer;
begin
  // decrease the day n times
  for N := 1 to NumberOfDays do
    Decrease;
end;

function RepCONFIG.getCurYear : Integer;
var
  Y, M, D: Word;
begin
  DecodeDate(Now, Y, M, D);
  Result := Y;
end;

function RepCONFIG.getCurMonth : Integer;
var
  Y, M, D: Word;
begin
  DecodeDate(Now, Y, M, D);
  Result := M;
end;

function RepCONFIG.getCurDay : Integer;
var
  Y, M, D: Word;
begin
  DecodeDate(Now, Y, M, D);
  Result := D;
end;


end.
