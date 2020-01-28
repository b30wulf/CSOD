unit knsl2ee8005meter;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,utlTimeDate,knsl3EventBox;
type
    CEE8005Meter = class(CMeter)
    Private
     nReq        : CQueryPrimitive;
     LastCommand : byte;
     tarif       : byte;
     //IsUpdate    : boolean;
     MyNakCykaMonth : integer;
     NakDate     : TDateTime;
     advInfo     : SL2TAGADVSTRUCT;
     SumEnergy   : single;
     ChekVer     : Byte;
     mTimeDir    : Integer;
     procedure SetCurrQry;
     procedure SetGraphQry;
     //procedure SetHandScenarioCurr;
     //procedure SetHandScenarioGraph;     
     procedure RunMeter;override;
     procedure InitMeter(var pL2:SL2TAG);override;
     function  SelfHandler(var pMsg:CMessage):Boolean;override;
     function  LoHandler(var pMsg:CMessage):Boolean;override;
     function  HiHandler(var pMsg:CMessage):Boolean;override;
     function  CalculateCS(var mas : array of byte; len : byte) : byte;
     function  ByteToBCD(intNumb : byte):byte;
     function  BCDToByte(hexNumb:byte):byte;
     function  ReadSymEnerg(var pMsg:CMessage):boolean;
     function  ReadMonthEnerg(var pMsg:CMessage):boolean;
     function  Read30MinPower(var pMsg:CMessage):boolean;

     function  ReadNakEnergMon(var pMsg:CMessage):boolean;
     function  ReadSresEnAns(var pMsg:CMessage):boolean;
     function  ArrayBCDToFloat(var mas:array of byte; size : byte):single;
     function  CheckCS(var mas : array of byte; len : byte) : boolean;
     function  GetCommand(byCommand:Byte):Integer;
     procedure EncodeStrToBCD(var mas:array of byte; str:string);
     procedure MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
     procedure CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure CreateMSG(AdrHi:byte; AdrLo:byte; size:byte);
     procedure CreateSymEnergReqMSG(var nReq:CQueryPrimitive);
     procedure CreateMonthEnergReqMSG(var nReq:CQueryPrimitive);
     procedure Create30MinPowerReqMSG(var nReq:CQueryPrimitive);

     function  ReadDateTimeAns(var pMsg: CMessage):Boolean;        // Ответ для выбора запроса чтения или кор времени
     function  ReadDateTime(var pMsg:CMessage):boolean;            // Оnвет
     function  ReadCorTimeRes(var pMsg : CMessage):Boolean;    // Ответ коректировки времени от параметра

     function  CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean; // Запрос для выбора чтения или кор времени
     procedure CreateDateTimeReqMSG(var nReq:CQueryPrimitive);     // Запрос чтение даты/времени
     procedure SetDateTimeToMeter(var nReq: CQueryPrimitive);     // Запрос корректировка даты/времени

     procedure CreateNakEnergMonReqMsg(var nReq:CQueryPrimitive);
     procedure Create30MinSresReq(var nReq:CQueryPrimitive);
     procedure CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
     procedure WriteDateForMonth(var pMsg : CMessage);
     procedure WriteDateForMonthNak(var pMsg : CMessage);
     procedure AddEnergyMonthGrpahQry(Date1, Date2:TDateTime);
     procedure AddNakEnMonthGrpahQry(Date1, Date2:TDateTime);
     procedure AddSresEnDayGraphQry(Date1, Date2: TDateTime);

     procedure OnFinHandQryRoutine(var pMsg:CMessage);
     procedure HandQryRoutine(var pMsg:CMessage);
     procedure OnEnterAction;
     procedure OnFinalAction;
     function  ArrayBCDToDouble(var mas:array of byte; size : byte):Double;
     constructor Create;
    End;
implementation
  const
      ST_164_READ_TIME             = 0;
      ST_164_CORR_TIME             = 1;

procedure CEE8005Meter.AddEnergyMonthGrpahQry(Date1, Date2:TDateTime);
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;
begin
   while (Date1 <= Date2) and (Date1 <= Now) do
   begin
     DecodeDate(Date1, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 4, 0, 1);
     cDateTimeR.IncMonth(Date1);
   end;
end;
{var Year, Month, Day : word;
+    i                : integer;
    TempDate         : TDateTime;
begin
   if (CDateTimeR.CompareMonth(Date2, Now) = 1) then
     Date2 := Now;
   if (CDateTimeR.CompareMonth(Date2, Now) = 0) then
     CDateTimeR.DecMonth(Date2);
   while CDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while CDateTimeR.CompareMonth(Date2, TempDate) <> 1 do
     begin
       CDateTimeR.DecMonth(TempDate);
       Inc(i);
       if i > 12 then
         exit;
     end;
     DecodeDate(Date1, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, Month, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, Month, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, Month, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, Month, 4, 0, 1);
     CDateTimeR.DecMonth(Date2);
   end;   }

procedure CEE8005Meter.AddNakEnMonthGrpahQry(Date1, Date2:TDateTime);
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;
begin

   while (Date1 <= Date2) and (Date1 <= Now) do
   begin
     DecodeDate(Date1, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 4, 0, 1);
     cDateTimeR.IncMonth(Date1);
   end;
end;
{var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;
begin
   if (CDateTimeR.CompareMonth(Date2, Now) = 1) then
     Date2 := Now;
   if (CDateTimeR.CompareMonth(Date2, Now) = 0) then
     CDateTimeR.DecMonth(Date2);
   while CDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while CDateTimeR.CompareMonth(Date2, TempDate) <> 1 do
     begin
       CDateTimeR.DecMonth(TempDate);
       Inc(i);
       if i > 12 then
         exit;
     end;
     DecodeDate(Now, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, 4, 0, 1);
     CDateTimeR.DecMonth(Date2);
   end;  }

procedure CEE8005Meter.AddSresEnDayGraphQry(Date1, Date2: TDateTime);
var i : integer;
begin
   for i := trunc(Date1) to trunc(Date2) do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, abs(trunc(Now) - i), 0, 0, 1);
end;

procedure CEE8005Meter.WriteDateForMonth(var pMsg : CMessage);
var Year, Month, Day : word;
begin
   DecodeDate(Now, Year, Month, Day);
   //if Month = 1 then
   //  Month := 12
   //else
   //  Dec(Month);

   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := 1;
   m_nRxMsg.m_sbyInfo[5] := 00;
   m_nRxMsg.m_sbyInfo[6] := 00;
   m_nRxMsg.m_sbyInfo[7] := 00;
end;

procedure CEE8005Meter.WriteDateForMonthNak(var pMsg : CMessage);
var Year, Month, Day, MonthMet : word;
tempAdrLo                      : byte;
TempDate                       : TDateTime;
begin
   DecodeDate(NakDate, Year, Month, Day);
  { tempAdrLo := pMsg.m_sbyInfo[14];
   case tarif of
     1: tempAdrLo := tempAdrLo - $00;
     2: tempAdrLo := tempAdrLo - $41;
     3: tempAdrLo := tempAdrLo - $82;
     4: tempAdrLo := tempAdrLo - $C3;
   end;
   MonthMet := tempAdrLo div 5 + 1;
   if MonthMet >= Month then
     Dec(Year);
   TempDate := EncodeDate(Year, MonthMet, Day);
   cDateTimeR.IncMonth(TempDate);
   DecodeDate(TempDate, Year, MonthMet, Day);  }
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := 1;
   m_nRxMsg.m_sbyInfo[5] := 00;
   m_nRxMsg.m_sbyInfo[6] := 00;
   m_nRxMsg.m_sbyInfo[7] := 00;
end;

procedure CEE8005Meter.SetDateTimeToMeter(var nReq: CQueryPrimitive);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
//    TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::> CEE8005:  Korrection Time');
    //LastCommand            :=99;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;

    {m_nTxMsg.m_sbyInfo[0] := $99;
    MSGHeadAndPUT(m_nTxMsg, 1);
    SlepEx(10);

    CreateMSG($0F, $00, 7);  }
    m_nTxMsg.m_sbyInfo[13] := $55;
    m_nTxMsg.m_sbyInfo[17] := CalculateCS(m_nTxMsg.m_sbyInfo[0], 17);
    m_nTxMsg.m_sbyInfo[18] := ByteToBCD(Sec);
    m_nTxMsg.m_sbyInfo[19] := ByteToBCD(Min);
    m_nTxMsg.m_sbyInfo[20] := ByteToBCD(Hour);
    Hour := DayOfWeek(Now); //Hour теперь день недели
    Hour := Hour - 1;
    if (Hour = 0) then
      Hour := 7;
    m_nTxMsg.m_sbyInfo[21] := ByteToBCD(Hour);
    m_nTxMsg.m_sbyInfo[22] := ByteToBCD(Day);
    m_nTxMsg.m_sbyInfo[23] := ByteToBCD(Month);
    m_nTxMsg.m_sbyInfo[24] := ByteToBCD(Year);
    m_nTxMsg.m_sbyInfo[25] := CalculateCS(m_nTxMsg.m_sbyInfo[0], 25);
    MSGHeadAndPUT(m_nTxMsg, 26);
    //LastCommand            := 100;
   // SlepEx(200);
end;

procedure CEE8005Meter.CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
var
    Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
    fValue                 : double;
begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nRxMsg.m_sbyInfo[0] := 13+4;
    m_nRxMsg.m_sbyInfo[1] := paramNo;
    m_nRxMsg.m_sbyInfo[2] := Year;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;
    m_nRxMsg.m_sbyInfo[8] := tarif;
    fValue := Param;
    Move(fValue,m_nRxMsg.m_sbyInfo[9],sizeof(fValue));
    m_nRxMsg.m_swLen      := 13 + m_nRxMsg.m_sbyInfo[0];
    if IsUpdate=1 then
      m_nRxMsg.m_sbyDirID   := 1
    else
      m_nRxMsg.m_sbyDirID   := 0;
    m_nRxMsg.m_sbyType    := DL_DATARD_IND;
    m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
    m_nRxMsg.m_swObjID    := m_nP.m_swMID;
    m_nRxMsg.m_sbyServerID:= 0;
end;

function CEE8005Meter.CheckCS(var mas:array of byte; len : byte) : boolean;
var i, res : byte;
begin  //Проверяет контрольную сумму
     res := 0;
     for i := 0 to len-1 do
       res := res + mas[i];
     if (mas[len] <> res) then
       Result := false
     else
       Result := true;
end;

function CEE8005Meter.ArrayBCDToFloat(var mas:array of byte; size : byte):single;
var i:byte;
begin  //Преобразование из BCD в single
   Result := 0;
   for i:=size-1 downto 0 do
   begin
     Result := Result*100;
     Result := Result + BCDToByte(mas[i]);
   end;
   Result := Result / 100;
end;

procedure CEE8005Meter.CreateMSG(AdrHi:byte; AdrLo:byte; size:byte);
var adr : int64;
begin  //Создание сообщения и отправка на L1
{     m_nTxMsg.m_sbyInfo[0] := $99;
     MSGHeadAndPUT(m_nTxMsg, 1);
     SlepEx(30);}

     {m_nTxMsg.m_sbyInfo[0] := $99;
     m_nTxMsg.m_swLen        := 1 + 11;
      m_nTxMsg.m_swObjID      := m_nP.m_swMID;       //Сетевой адрес счётчика
      m_nTxMsg.m_sbyFrom      := DIR_L2TOL1;
      m_nTxMsg.m_sbyFor       := DIR_L2TOL1;    //DIR_L2toL1
      m_nTxMsg.m_sbyType      := PH_DATARD_REQ; //PH_DATARD_REC
     //pMsg.m_sbyTypeIntID := DEV_COM;       //DEF_COM
      m_nTxMsg.m_sbyIntID     := m_nP.m_sbyPortID;
      m_nTxMsg.m_sbyServerID  := MET_EE8005;     //Указать тип счетчика
      m_nTxMsg.m_sbyDirID     := m_nP.m_sbyPortID;
     SendToL1(BOX_L1, @m_nTxMsg);
     SlepEx(20);}

    // m_nTxMsg.m_sbyInfo[0] := $33;//$99;

    if (ChekVer=1) then
    begin
     if (advInfo.m_sAdrToRead<>'')and (advInfo.m_sKoncPassw<>'')then begin
     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1-1],advInfo.m_sAdrToRead);//     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1], m_nP.m_sddPHAddres);
     m_nTxMsg.m_sbyInfo[3 + 1-1]  := CalculateCS(m_nTxMsg.m_sbyInfo[0 + 1-1], 3);
     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1-1],advInfo.m_sKoncPassw); //     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1], m_nP.m_schPassword);
     m_nTxMsg.m_sbyInfo[7 + 1-1]  := CalculateCS(m_nTxMsg.m_sbyInfo[4 + 1-1], 3);
     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1-1],advInfo.m_sKoncPassw);     //EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1], m_nP.m_schPassword);
     m_nTxMsg.m_sbyInfo[11 + 1-1] := CalculateCS(m_nTxMsg.m_sbyInfo[8 + 1-1], 3);
     end
     else
     begin
     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1-1],m_nP.m_sddFabNum);//     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1], m_nP.m_sddPHAddres);
     m_nTxMsg.m_sbyInfo[3 + 1-1]  := CalculateCS(m_nTxMsg.m_sbyInfo[0 + 1-1], 3);
     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1-1],m_nP.m_schPassword); //     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1], m_nP.m_schPassword);
     m_nTxMsg.m_sbyInfo[7 + 1-1]  := CalculateCS(m_nTxMsg.m_sbyInfo[4 + 1-1], 3);
     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1-1],m_nP.m_schPassword);     //EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1], m_nP.m_schPassword);
     m_nTxMsg.m_sbyInfo[11 + 1-1] := CalculateCS(m_nTxMsg.m_sbyInfo[8 + 1-1], 3);
     end;

     m_nTxMsg.m_sbyInfo[12 + 1-1] := 0;
     m_nTxMsg.m_sbyInfo[13 + 1-1] := $AA;
     m_nTxMsg.m_sbyInfo[14 + 1-1] := AdrLo;
     m_nTxMsg.m_sbyInfo[15 + 1-1] := AdrHi;
     m_nTxMsg.m_sbyInfo[16 + 1-1] := size;
     m_nTxMsg.m_sbyInfo[17 + 1-1] := CalculateCS(m_nTxMsg.m_sbyInfo[0 + 1-1], 17);
     MSGHeadAndPUT(m_nTxMsg, 18 + 1-1);
    end
    else
     begin
     m_nTxMsg.m_sbyInfo[0] := $99;
     if (advInfo.m_sAdrToRead<>'')and (advInfo.m_sKoncPassw<>'')then 
       begin
       EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1],advInfo.m_sAdrToRead);//     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1], m_nP.m_sddPHAddres);
       m_nTxMsg.m_sbyInfo[3 + 1]  := CalculateCS(m_nTxMsg.m_sbyInfo[0 + 1], 3);
       EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1],advInfo.m_sKoncPassw); //     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1], m_nP.m_schPassword);
       m_nTxMsg.m_sbyInfo[7 + 1]  := CalculateCS(m_nTxMsg.m_sbyInfo[4 + 1], 3);
       EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1],advInfo.m_sKoncPassw);     //EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1], m_nP.m_schPassword);
       m_nTxMsg.m_sbyInfo[11 + 1] := CalculateCS(m_nTxMsg.m_sbyInfo[8 + 1], 3);
       end
     else
       begin
       EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1],m_nP.m_sddFabNum);//     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[0 + 1], m_nP.m_sddPHAddres);
       m_nTxMsg.m_sbyInfo[3 + 1]  := CalculateCS(m_nTxMsg.m_sbyInfo[0 + 1], 3);
       EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1],m_nP.m_schPassword); //     EncodeStrToBCD(m_nTxMsg.m_sbyInfo[4 + 1], m_nP.m_schPassword);
       m_nTxMsg.m_sbyInfo[7 + 1]  := CalculateCS(m_nTxMsg.m_sbyInfo[4 + 1], 3);
       EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1],m_nP.m_schPassword);     //EncodeStrToBCD(m_nTxMsg.m_sbyInfo[8 + 1], m_nP.m_schPassword);
       m_nTxMsg.m_sbyInfo[11 + 1] := CalculateCS(m_nTxMsg.m_sbyInfo[8 + 1], 3);
       end;
     m_nTxMsg.m_sbyInfo[12 + 1] := 0;
     m_nTxMsg.m_sbyInfo[13 + 1] := $AA;
     m_nTxMsg.m_sbyInfo[14 + 1] := AdrLo;
     m_nTxMsg.m_sbyInfo[15 + 1] := AdrHi;
     m_nTxMsg.m_sbyInfo[16 + 1] := size;
     m_nTxMsg.m_sbyInfo[17 + 1] := CalculateCS(m_nTxMsg.m_sbyInfo[0 + 1], 17);
     MSGHeadAndPUT(m_nTxMsg, 18 + 1);
     end;
    // TraceM(2,m_nTxMsg.m_swObjID,'(__)EE8005::>Out DRQ:',@m_nTxMsg);
end;

procedure CEE8005Meter.MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
begin  //Создание шапки сообщения и отправка на L1
    pMsg.m_swLen        := Size + 13;
    pMsg.m_swObjID      := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom      := DIR_L2TOL1;
    pMsg.m_sbyFor       := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType      := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID := DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID     := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID  := MET_EE8005;     //Указать тип счетчика
    pMsg.m_sbyDirID     := m_nP.m_sbyPortID;
    SendToL1(BOX_L1, @pMsg);
end;

procedure CEE8005Meter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin                         //sm - вид энергии; tar - тарифф
   DecodeDate(Date, Year, Month, Day);
   DecodeTime(Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   //m_nRxMsg.m_sbyServerID := 0;
   m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[1] := sm;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := tar;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(double));
   m_nRxMsg.m_sbyDirID   := IsUpdate;
end;
     {
procedure CEE8005Meter.EncodeStrToBCD(var mas:array of byte; str:string);
var rez : int64;
      i : byte;
begin //Преобразование строки в BCD
    rez   := 0;
    for i := 1 to 6 do
    begin
      rez := rez * $10;
      if Length(str) >= i then
        rez := rez + StrToInt(str[i]);
    end;
    move(rez, mas, 3);
end;   }

procedure CEE8005Meter.EncodeStrToBCD(var mas:array of byte; str:string);
var rez : int64;
      i : byte;
begin //Преобразование строки в BCD
    rez   := 0;
    for i := 1 to 6 do
    begin
      if (i > Length(str)) then
        break;
      rez := rez * $10;
      rez := rez + StrToInt(str[i]);
    end;
    move(rez, mas, 3);
end;




function  CEE8005Meter.ByteToBCD(intNumb:byte):byte;
begin //Преобразование байта в BCD формат
    Result := ((intNumb div 10) shl 4) + (intNumb mod 10);
end;

function  CEE8005Meter.BCDToByte(hexNumb:byte):byte;
begin //Преобразование BCD в байт
    Result := (hexNumb shr 4)*10 + (hexNumb and $0F);
end;

function  CEE8005Meter.CalculateCS(var mas : array of byte; len : byte):byte;
var i : byte;
res   : longword;
begin //Выщитывание контрольной суммы
    Result := 0;
    res    := 0;
     for i := 0 to len-1 do
       res := res + mas[i];
     Result := res;
end;

function  CEE8005Meter.ReadSymEnerg(var pMsg:CMessage):boolean;
var param : single;
begin
     if not CheckCS(pMsg.m_sbyInfo[18], 4)  then
     begin
      // if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'CRC ERROR');
       Result := false;
       exit;
     end;

     param := ArrayBCDToFloat(pMsg.m_sbyInfo[18], 4);
      if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'param='+floatToStr(param)+'tarif='+floatToStr(tarif));
     SumEnergy:=SumEnergy+param;
     CreateOutputMSG(QRY_ENERGY_SUM_EP, param, tarif);
     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
//     SendSyncEvent;
// if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'SAVETODB OK');
     if (tarif=4)then
     begin
     CreateOutputMSG(QRY_ENERGY_SUM_EP, SumEnergy, 0);
     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     Result := true;
end;

function  CEE8005Meter.ReadMonthEnerg(var pMsg:CMessage):boolean;
var i                    : integer;
    tempVal              : double;
    YearN, MonthN, DayN  : word;

    tempDate             : TDateTime;
    tempSpecc0           : integer;
begin
   Result:=true;
   if not CheckCS(pMsg.m_sbyInfo[18], 4)  then
   begin
     Result := false;
     exit;
   end;
   if (nReq.m_swParamID = QRY_NAK_EN_MONTH_EP) and ((nReq.m_swSpecc0 <= 0)) then
   begin
     TempDate := Now;
     DecodeDate(TempDate, YearN, MonthN, DayN);
     nReq.m_swSpecc0 := MonthN;
   end;
   if nReq.m_swSpecc1 = 0 then
     Exit;
   tempSpecc0 := MyNakCykaMonth;
   tempSpecc0 := tempSpecc0 - 1;
   if (tempSpecc0 < 1) then
     tempSpecc0 := 12;
   DecodeDate(Now, YearN, MonthN, DayN);
   if MonthN < nReq.m_swSpecc0 then
     YearN := YearN - 1;
   tempVal := ArrayBCDToDouble(pMsg.m_sbyInfo[18], 4);
   tempVal := tempVal * m_nP.m_sfKI * m_nP.m_sfKU;
   SumEnergy:=SumEnergy+tempVal;
   tempDate := EncodeDate(YearN, MyNakCykaMonth, 1);
   CreateOutMSG(tempVal, QRY_NAK_EN_MONTH_EP, nReq.m_swSpecc1, tempDate);
   saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   m_nRxMsg.m_sbyServerID := 0;
   if (tarif=4)then
    begin
     CreateOutMSG(SumEnergy,QRY_NAK_EN_MONTH_EP, 0, tempDate);
     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
    end;

  //FinalAction;
end;
{
var param : single;
begin
     if not CheckCS(pMsg.m_sbyInfo[0], 3) then
     begin
       Result := false;
       exit;
     end;
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[18], 4);
     if tarif = 0 then
     begin
       FinalAction;
       exit;
     end;
     CreateOutputMSG(QRY_NAK_EN_DAY_EP, param, tarif);
     WriteDateForMonthNak(pMsg);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     FinalAction;
     Result := true;
end;   }

function  CEE8005Meter.Read30MinPower(var pMsg:CMessage):boolean;
var i        : integer;
    tempVal  : double;
    TempDate : TDateTime;
begin
   if not CheckCS(pMsg.m_sbyInfo[18], 2) then
   begin
     Result := false;
     exit;
   end;
   TempDate := trunc(Now) - nReq.m_swSpecc0;
   for i := 0 to 47 do
   begin
     tempVal := ArrayBCDToDouble(pMsg.m_sbyInfo[18 + i*2], 2);
     tempVal := tempVal * m_nP.m_sfKI * m_nP.m_sfKU / 2;
     if TempDate + EncodeTime(0, 30, 0, 0)*i >= Now then
     begin
       m_nRxMsg.m_sbyServerID := i or $80;
       tempVal := 0;
     end
     else
       m_nRxMsg.m_sbyServerID := i;
     CreateOutMSG(tempVal, QRY_SRES_ENR_EP, 0, TempDate + EncodeTime(0, 30, 0, 0)*i);
     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;

function  CEE8005Meter.ReadDateTime(var pMsg:CMessage):boolean;
var param : single;
Year, Month, Day       : word;
    Hour, Min, Sec, mSec   : word;
begin
     if (pMsg.m_sbyInfo[25] <> $80) then
     begin
       Result := false;
       exit;
     end;
     m_nRxMsg.m_sbyInfo[0] := 8;
     m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
     m_nRxMsg.m_sbyInfo[2] := BCDToByte(pMsg.m_sbyInfo[24]); //y
     m_nRxMsg.m_sbyInfo[3] := BCDToByte(pMsg.m_sbyInfo[23]); //m
     m_nRxMsg.m_sbyInfo[4] := BCDToByte(pMsg.m_sbyInfo[22]); //d
     m_nRxMsg.m_sbyInfo[5] := BCDToByte(pMsg.m_sbyInfo[20]); //h
     m_nRxMsg.m_sbyInfo[6] := BCDToByte(pMsg.m_sbyInfo[19]); //m
     m_nRxMsg.m_sbyInfo[7] := BCDToByte(pMsg.m_sbyInfo[18]); //s
//     FPUT(BOX_L3_BY, @m_nRxMsg);
     DecodeDate(Now, Year, Month, Day);
     DecodeTime(Now, Hour, Min, Sec, mSec);
     Year := Year - 2000;
     if (Year <> m_nRxMsg.m_sbyInfo[2]) or (Month <> m_nRxMsg.m_sbyInfo[3]) or (Day <> m_nRxMsg.m_sbyInfo[4])
        or (Hour <> m_nRxMsg.m_sbyInfo[5]) or (Min <> m_nRxMsg.m_sbyInfo[6]) or (abs(m_nRxMsg.m_sbyInfo[7] - Sec) >= 5) then
       begin
         mTimeDir := ST_164_CORR_TIME;
         m_nObserver.AddGraphParam(QRY_DATA_TIME, 0,0,0,1);  //заносим в спеки параметры для определения типа запроса(на разъем или на счетчики)
         Result := true;
       end
     else
       begin
         mTimeDir := ST_164_READ_TIME; //потом убрать
         m_nObserver.ClearGraphQry;//Очищаем буфер команд
         Result := true;
       end;
end;

(*******************************************************************************
 * Ответ "Чтение времени и даты"
 *******************************************************************************)
function CEE8005Meter.ReadCorTimeRes(var pMsg:CMessage):Boolean;
//var
//  _yy,_mn,_dd,_hh,_mm,_ss : word;
//  ReadDate : TDateTime;
begin
//    _yy := (pMsg.m_sbyInfo[5]);
//    _mn := (pMsg.m_sbyInfo[6]);
//    _dd := (pMsg.m_sbyInfo[7]);
//    _hh := (pMsg.m_sbyInfo[8])+3;
//    _mm := (pMsg.m_sbyInfo[9]);
//    _ss := (pMsg.m_sbyInfo[10]);
//    ReadDate:=EncodeDate(_yy,_mn,_dd) + EncodeTime(_hh,_mm,_ss,0);
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Разница по времени после корректировки нужно доработать -> ');//+DateTimeToStr(ReadDate - Now));
    Result:=True;
end;



function  CEE8005Meter.ReadNakEnergMon(var pMsg:CMessage):boolean;
var i                    : integer;
    tempVal              : double;
    YearN, MonthN, DayN  : word;
    tempDate             : TDateTime;
    tempSpecc0           : integer;
begin
   if nReq.m_swSpecc1 = 0 then
     Exit;
   tempSpecc0 := nReq.m_swSpecc0;
   tempSpecc0 := tempSpecc0 - 1;
   if (tempSpecc0 < 1) then
     tempSpecc0 := 12;
   DecodeDate(Now, YearN, MonthN, DayN);
   if MonthN < nReq.m_swSpecc0 then
     YearN := YearN - 1;
   tempVal := ArrayBCDToDouble(pMsg.m_sbyInfo[18 + (tempSpecc0 - 1)*5], 4);
   tempVal := tempVal * m_nP.m_sfKI * m_nP.m_sfKU;
   tempDate := EncodeDate(YearN, nReq.m_swSpecc0, 1);
   CreateOutMSG(tempVal, QRY_NAK_EN_MONTH_EP, nReq.m_swSpecc1, tempDate);
   saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   m_nRxMsg.m_sbyServerID := 0;
{var param : single;
begin
     if not CheckCS(pMsg.m_sbyInfo[18], 4) then
     begin
       Result := false;
       exit;
     end;
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[18], 4);
     CreateOutputMSG(QRY_NAK_EN_MONTH_EP, param, tarif);
     WriteDateForMonth(pMsg);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     Result := true;
     FinalAction;     }
end;

function  CEE8005Meter.ReadSresEnAns(var pMsg:CMessage):boolean;
var i        : integer;
    tempVal  : double;
    TempDate : TDateTime;
begin
     //if not CheckCS(pMsg.m_sbyInfo[18], 4) then
     //begin
     //  Result := false;
     //  exit;
     //end;
   TempDate := trunc(Now) - nReq.m_swSpecc0;
   for i := 0 to 47 do
   begin
     tempVal := ArrayBCDToFloat(pMsg.m_sbyInfo[18 + i*2], 2);
     tempVal := tempVal * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff/4.0;
     if (TempDate + EncodeTime(0, 30, 0, 0)*i) >= Now then
     begin
       m_nRxMsg.m_sbyServerID := i or $80;
       tempVal := 0;
     end
     else
       m_nRxMsg.m_sbyServerID := i;
     CreateOutMSG(tempVal, QRY_SRES_ENR_EP, 0, TempDate + EncodeTime(0, 30, 0, 0)*i);
     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   //FinalAction;
end;

procedure CEE8005Meter.CreateSymEnergReqMSG(var nReq:CQueryPrimitive);
var AdrHi, AdrLo : byte;
begin
   // if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Command ENERGY_SUM YES');
    LastCommand := QRY_ENERGY_SUM_EP;
    tarif       := nReq.m_swSpecc1;
    AdrHi := $05;
    AdrLo := $A0 + 40;
    AdrLo := AdrLo + (nReq.m_swSpecc1-1)*5;
    if nReq.m_swSpecc1 =0 then
    begin
     // FinalAction;
     // if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Error nReq.m_swSpecc1=0');
      exit;
    end;
   // if (nReq. .m_sbyType)
    CreateMSG(AdrHi, AdrLo, 5);

end;

procedure CEE8005Meter.CreateMonthEnergReqMSG(var nReq:CQueryPrimitive);
var AdrHi, AdrLo               : byte;
Year, Month, Day               : word;
i                              : integer;
TempDate, Date1, Date2         : TDateTime;
begin
   Date1 := Now;
   Date2 := Now;
   while (Date1 <= Date2) and (Date1 <= Now) and (nReq.m_swSpecc0 <= 0) do
   begin
     DecodeDate(Date1, Year, Month, Day);
     nReq.m_swSpecc0 :=Month;
     
     cDateTimeR.IncMonth(Date1);
   end;
    {if ((nReq.m_swSpecc0 <= 0)) then
    begin
      TempDate := Now;
      for i := 0 to abs(nReq.m_swSpecc0) do
        cDateTimeR.DecMonth(TempDate);
      DecodeDate(TempDate, Year, Month, Day);
      nReq.m_swSpecc0 := Month;
    end;       }
    {DecodeDate(Now, Year, Month, Day);    }
    LastCommand := QRY_NAK_EN_MONTH_EP;
    tarif       := nReq.m_swSpecc1;
    if nReq.m_swSpecc1 = 0 then
    begin
     exit;
    end;
//    NakDate :=  EncodeDate(Year, Month, Day);
    if nReq.m_swSpecc0 <> 0 then
    begin
      Month := nReq.m_swSpecc0
    end
    else
      if Month = 1 then
        Month := 12
      else
      begin
        Dec(Month);
        Year := Year - 1;
      end;
   // DecodeDate(Now, Year, Month, Day);
    AdrHi := $06;
    AdrLo := (nReq.m_swSpecc1-1)*$41;
    AdrLo := AdrLo + (Month-2)*5; //- 2
    MyNakCykaMonth := nReq.m_swSpecc0;
    CreateMSG(AdrHi, AdrLo, 5);
end;

procedure CEE8005Meter.Create30MinPowerReqMSG(var nReq:CQueryPrimitive);
var AdrHi, AdrLo : byte;
begin
    LastCommand := QRY_E30MIN_POW_EP;
    tarif       := nReq.m_swSpecc1;
    AdrHi := $05;
    AdrLo := $F0;
    CreateMSG(AdrHi, AdrLo, 3);
end;

procedure CEE8005Meter.CreateDateTimeReqMSG(var nReq:CQueryPrimitive);
var AdrHi, AdrLo : byte;
begin
    LastCommand := QRY_DATA_TIME;
    tarif       := nReq.m_swSpecc1;
    AdrHi := $F0;
    AdrLo := $00;
    CreateMSG(AdrHi, AdrLo, 8);
end;


function CEE8005Meter.ReadDateTimeAns(var pMsg: CMessage): Boolean;
begin
   LastCommand := QRY_DATA_TIME;
   Result := true;
   case mTimeDir of
     ST_164_READ_TIME : Result:=ReadDateTime(pMsg);
     ST_164_CORR_TIME :
       begin
         Result:=ReadCorTimeRes(pMsg);
         mTimeDir := ST_164_READ_TIME;
       end;
   else  mTimeDir := ST_164_READ_TIME;
   end;
end;

procedure CEE8005Meter.CreateNakEnergMonReqMsg(var nReq:CQueryPrimitive);
var AdrHi, AdrLo : byte;
begin
    LastCommand := QRY_NAK_EN_MONTH_EP;
    tarif       := nReq.m_swSpecc1;
    AdrHi := $05;
    if nReq.m_swSpecc1 =0 then
    begin
     //finalaction;
     exit;
    end;
    AdrLo := $A0 + (nReq.m_swSpecc1 - 1)*5 ;
    CreateMSG(AdrHi, AdrLo, 5);
end;

procedure CEE8005Meter.Create30MinSresReq(var nReq:CQueryPrimitive);
var AdrHi, AdrLo : byte;
begin
    LastCommand := QRY_SRES_ENR_EP;
    tarif       := 0;
    AdrHi := $80;
    AdrLo := $00;
    CreateMSG(AdrHi, AdrLo, nReq.m_swSpecc0);
end;
constructor CEE8005Meter.Create;
Begin
   ChekVer:=0;
   if (m_nP.m_sbyType=MET_EE8003_4)then ChekVer:=1
   else
   ChekVer:=0;
End;

procedure CEE8005Meter.InitMeter(var pL2:SL2TAG);
var
   slv : TStringList;
Begin
    IsUpdate   := 0;
    SumEnergy  := 0;
    ChekVer    := 0;
    mTimeDir      := 0; //параметр чтнения времени  ST_164_READ_TIME
        
    if (m_nP.m_sbyType=MET_EE8003_4)then ChekVer:=1
    else
     ChekVer:=0;
    //if m_nP.m_sbyHandScenr=0 then
    //Begin
    // SetCurrQry;
    // SetGraphQry;
    //end;              e
    //if m_nP.m_sbyHandScenr=1 then
    //Begin
     SetHandScenario;
     SetHandScenarioGraph;
     
    //end;
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EE8005  Meter Created:'+
//    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
//    ' Rep:'+IntToStr(m_byRep)+
//    ' Group:'+IntToStr(m_nP.m_sbyGroupID));

     slv := TStringList.Create;
     getStrings(m_nP.m_sAdvDiscL2Tag,slv);
     //if slv[0]='' then slv[0] := '0';
     //if slv[2]='' then slv[2] := '0';
     advInfo.m_sKoncFubNum  := slv[0]; //
     advInfo.m_sKoncPassw   := slv[1]; //Пароль на счетчик
     advInfo.m_sAdrToRead   := slv[2]; // Адрес счетчика
     slv.Clear;
     slv.Destroy;
End;

procedure CEE8005Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(1,0,1,0,1);  //Запрос на суммарную накопленную энергию(speq1 - тариф)
     AddCurrParam(1,0,2,0,1);
     AddCurrParam(1,0,3,0,1);
     AddCurrParam(1,0,4,0,1);
     AddCurrParam(3,0,1,0,1);  //Помесячное потребление(speq1 - тариф)
     AddCurrParam(3,0,2,0,1);
     AddCurrParam(3,0,3,0,1);
     AddCurrParam(3,0,4,0,1);
     AddCurrParam(6,0,0,0,1);  //Значение 30 минутной мощности
     AddCurrParam(32,0,0,0,1); //Текущее значение времени в счетчике
     AddCurrParam(43,0,1,0,1); //Значение потребленной энергии на начало месяца
     AddCurrParam(43,0,2,0,1);
     AddCurrParam(43,0,3,0,1);
     AddCurrParam(43,0,4,0,1);
     AddCurrParam(44,0,1,0,1); //Потребленная энергия на начало года
     AddCurrParam(44,0,2,0,1);
     AddCurrParam(44,0,3,0,1);
     AddCurrParam(44,0,4,0,1);
    End;
End;

procedure CEE8005Meter.SetGraphQry;
Begin

End;

function CEE8005Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
{    pMsg.m_sbyInfo[0] := $99;
    pMsg.m_swLen        := 1 + 11;
    pMsg.m_swObjID      := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom      := DIR_L2TOL1;
    pMsg.m_sbyFor       := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType      := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID := DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID     := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID  := MET_EE8005;     //Указать тип счетчика
    pMsg.m_sbyDirID     := m_nP.m_sbyPortID;
    SendToL1(BOX_L1, @pMsg);
    SlepEx(30);
    Result := res;               }
End;
function CEE8005Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := false;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        try
          if (pMsg.m_swLen >13) then
          begin
            case (LastCommand) of
              QRY_ENERGY_SUM_EP    : res := ReadSymEnerg(pMsg);
              QRY_ENERGY_MON_EP    : res := ReadMonthEnerg(pMsg);
              QRY_E30MIN_POW_EP    : res := Read30MinPower(pMsg);
              QRY_DATA_TIME        : res := ReadDateTimeAns(pMsg);//ReadDateTime(pMsg);
              QRY_NAK_EN_MONTH_EP  : res := ReadMonthEnerg(pMsg);
              QRY_SRES_ENR_EP      : res := ReadSresEnAns(pMsg);
            end;
          end;
        except
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка не существующей команды! Будет очишен буфер команд для счетчика!');
         m_nObserver.ClearGraphQry;//Очищаем буфер команд
        end;
      End;
    End;
    Result := res;
End;

procedure CEE8005Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
   // m_nObserver.ClearGraphQry;      //Потом можно вернуть
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param := pDS.m_swData1;
    case param of
     QRY_ENERGY_MON_EP   : AddEnergyMonthGrpahQry(Date1, Date2);
     QRY_NAK_EN_MONTH_EP : AddNakEnMonthGrpahQry(Date1, Date2);
     QRY_SRES_ENR_EP     : AddSresEnDayGraphQry(Date1, Date2);
    end;
end;

function CEE8005Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    Date1, Date2 : TDateTime;
    szDT         : word;
Begin
    res := False;
    Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
    //Обработчик для L3
//    if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
//    if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
        case (nReq.m_swParamID) of
          QRY_ENERGY_SUM_EP   : CreateSymEnergReqMSG(nReq);
          QRY_NAK_EN_MONTH_EP : CreateMonthEnergReqMSG(nReq);
          QRY_E30MIN_POW_EP   : Create30MinPowerReqMSG(nReq);
          QRY_DATA_TIME       : CreateDateTimeReq(nReq);//CreateDateTimeReqMSG(nReq);
          //QRY_NAK_EN_MONTH_EP : CreateNakEnergMonReqMsg(nReq);
          QRY_KPRTEL_KE       : begin SendSyncEvent; exit; end;
          QRY_AUTORIZATION    : begin SendSyncEvent; exit; end;
          QRY_SRES_ENR_EP, QRY_SRES_ENR_DAY_EP: Create30MinSresReq(nReq);
        else    begin 
                 exit;
                end;
        end;
      End;
      QL_DATA_GRAPH_REQ:     HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;

function CEE8005Meter.CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean;
begin
   case mTimeDir of
     ST_164_READ_TIME : CreateDateTimeReqMSG(nReq);
     ST_164_CORR_TIME : SetDateTimeToMeter(nReq);
   end;
end;


procedure CEE8005Meter.OnEnterAction;
Begin
//    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>EE8005 OnEnterAction');

//    FinalAction;
End;
procedure CEE8005Meter.OnFinalAction;
Begin
//    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>EE8005 OnFinalAction');
    
//    FinalAction;
End;
procedure CEE8005Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    //m_IsAuthorized := false;
   // OnFinalAction();
//    TraceM(4,pMsg.m_swObjID,'(__)CL2MD::>EE8005 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

function CEE8005Meter.GetCommand(byCommand:Byte):Integer;
Var
    res : Integer;
Begin
    case byCommand of
     QRY_NULL_COMM      :   res:=0;// = 0
     QRY_ENERGY_SUM_EP  :   res:=1;//= 1;//1
     QRY_ENERGY_SUM_EM  :   res:=1;//= 2;
     QRY_ENERGY_SUM_RP  :   res:=1;//= 3;
     QRY_ENERGY_SUM_RM  :   res:=1;//= 4;
     QRY_ENERGY_DAY_EP  :   res:=2;//= 5;//2
     QRY_ENERGY_DAY_EM  :   res:=2;//= 6;
     QRY_ENERGY_DAY_RP  :   res:=2;//= 7;
     QRY_ENERGY_DAY_RM  :   res:=2;//= 8;
     QRY_ENERGY_MON_EP  :   res:=3;//= 9;//3
     QRY_ENERGY_MON_EM  :   res:=3;//= 10;
     QRY_ENERGY_MON_RP  :   res:=3;//= 11;
     QRY_ENERGY_MON_RM  :   res:=3;//= 12;
     QRY_SRES_ENR_EP    :   res:=36;//= 13;//36
     QRY_SRES_ENR_EM    :   res:=36;//= 14;
     QRY_SRES_ENR_RP    :   res:=36;//= 15;
     QRY_SRES_ENR_RM    :   res:=36;//= 16;
     QRY_NAK_EN_DAY_EP  :   res:=42;//= 17;//42
     QRY_NAK_EN_DAY_EM  :   res:=42;//= 18;
     QRY_NAK_EN_DAY_RP  :   res:=42;//= 19;
     QRY_NAK_EN_DAY_RM  :   res:=42;//= 20;
     QRY_NAK_EN_MONTH_EP:   res:=43;//= 21;//43
     QRY_NAK_EN_MONTH_EM:   res:=43;//= 22;
     QRY_NAK_EN_MONTH_RP:   res:=43;//= 23;
     QRY_NAK_EN_MONTH_RM:   res:=43;//= 24;
     //QRY_NAK_EN_YEAR_EP    res:=0;//= 25;
     //QRY_NAK_EN_YEAR_EM    res:=0;//= 26;
     //QRY_NAK_EN_YEAR_RP    res:=0;//= 27;
     //QRY_NAK_EN_YEAR_RM    res:=0;//= 28;
     QRY_E3MIN_POW_EP   :   res:=5;//= 29;//5
     QRY_E3MIN_POW_EM   :   res:=5;//= 30;
     QRY_E3MIN_POW_RP   :   res:=5;//= 31;
     QRY_E3MIN_POW_RM   :   res:=5;//= 32;
     QRY_E30MIN_POW_EP  :   res:=6;//= 33;//6
     QRY_E30MIN_POW_EM  :   res:=6;//= 34;
     QRY_E30MIN_POW_RP  :   res:=6;//= 35;
     QRY_E30MIN_POW_RM  :   res:=6;//= 36;
     QRY_MGAKT_POW_S    :   res:=8;//= 37;//8
     QRY_MGAKT_POW_A    :   res:=8;//= 38;
     QRY_MGAKT_POW_B    :   res:=8;//= 39;
     QRY_MGAKT_POW_C    :   res:=8;//= 40;
     QRY_MGREA_POW_S    :   res:=9;//= 41;//9
     QRY_MGREA_POW_A    :   res:=9;//= 42;
     QRY_MGREA_POW_B    :   res:=9;//= 43;
     QRY_MGREA_POW_C    :   res:=9;//= 44;
     QRY_U_PARAM_A      :   res:=10;//= 45;//10
     QRY_U_PARAM_B      :   res:=10;//= 46;
     QRY_U_PARAM_C      :   res:=10;//= 47;
     QRY_I_PARAM_A      :   res:=11;//= 48;//11
     QRY_I_PARAM_B      :   res:=11;//= 49;
     QRY_I_PARAM_C      :   res:=11;//= 50;
     QRY_FREQ_NET       :   res:=13;//= 54;//13
     QRY_KOEF_POW_A     :   res:=12;//= 51;//12
     QRY_KOEF_POW_B     :   res:=12;//= 52;
     QRY_KOEF_POW_C     :   res:=12;//= 53;
     QRY_KPRTEL_KPR     :   res:=24;//= 55;//24
     QRY_KPRTEL_KE      :   res:=24;//= 55;//24
     //QRY_KPRTEL_R          res:=0;//= 56;
     QRY_DATA_TIME      :   res:=32;//= 57;//32
     else
     res:=-1;
    End;
    Result := res;
End;

procedure CEE8005Meter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

function CEE8005Meter.ArrayBCDToDouble(var mas:array of byte; size : byte):Double;
var i:byte;
begin  //Преобразование из BCD в single
   Result := 0;
   for i:=size-1 downto 0 do
   begin
     Result := Result*100;
     Result := Result + BCDToByte(mas[i]);
   end;
   Result := Result / 100;
end;


end.
