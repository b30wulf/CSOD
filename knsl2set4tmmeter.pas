unit knsl2set4tmmeter;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer
,knsl5tracer;
type
    CSET4TMMeter = class(CMeter)
    Private
     LastCommand  : byte;
     m_sfKA       : single;
     procedure     SetCurrQry;
     procedure     SetGraphQry;
     //procedure     SetHandScenarioCurr;
     //procedure     SetHandScenarioGraph;
     procedure     RunMeter;override;
     procedure     InitMeter(var pL2:SL2TAG);override;
     function      SelfHandler(var pMsg:CMessage):Boolean;override;
     function      LoHandler(var pMsg:CMessage):Boolean;override;
     function      HiHandler(var pMsg:CMessage):Boolean;override;
     function      CRC(var buf : array of byte; cnt : byte):boolean;
     procedure     MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
     procedure     CreateSymEnergReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateDayEnergReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateMonthEnergReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateInstantPowerReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateVoltageReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateCurrReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateFreqReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateDateTimeReqMSG(var nReq:CQueryPrimitive);
     procedure     CreateKanal(var nReq:CQueryPrimitive);
     function      ReadKanal(var pMsg : CMessage):boolean;
     function      ReadSymEnerg(var pMsg : CMessage):boolean;
     function      ReadDayEnerg(var pMsg : CMessage):boolean;
     function      ReadMonthEnerg(var pMsg : CMessage):boolean;
     function      ReadInstantPower(var pMsg : CMessage):boolean;
     function      ReadVoltage(var pMsg : CMessage):boolean;
     function      ReadCurr(var pMsg : CMessage):boolean;
     function      ReadFreq(var pMsg : CMessage):boolean;
     function      ReadDateTime(var pMsg : CMessage):boolean;
     function      ArrayBCDToFloat(var mas:array of byte; size : byte):single;
     procedure     CreateOutputMSG(paramNo : integer; Param : single; tarif : byte);
     procedure     SetDateTimeToMeter(Season : byte);
     function      ByteToBCD(intNumb:byte):byte;
     function      BCDToByte(hexNumb:byte):byte;
     constructor   Create;
    End;
implementation

constructor CSET4TMMeter.Create;
Begin

End;

function  CSET4TMMeter.ByteToBCD(intNumb:byte):byte;
begin
    Result := ((intNumb div 10) shl 4) + (intNumb mod 10);
end;

function  CSET4TMMeter.BCDToByte(hexNumb:byte):byte;
begin
    Result := (hexNumb shr 4)*10 + (hexNumb and $0F);
end;

procedure CSET4TMMeter.SetDateTimeToMeter(Season : byte);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    LastCommand            :=99;
    //m_nRepTimer.OffTimer;
    TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::> SET4TM:  Korrection Time');
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nTxMsg.m_sbyInfo[1]  := $03;
    m_nTxMsg.m_sbyInfo[2]  := $0C;
    m_nTxMsg.m_sbyInfo[3]  := ByteToBCD(Sec);
    m_nTxMsg.m_sbyInfo[4]  := ByteToBCD(Min);
    m_nTxMsg.m_sbyInfo[5]  := ByteToBCD(Hour);
    Hour := DayOfWeek(Now); //Hour теперь день недели
    Hour := Hour - 1;
    if (Hour = 0) then
      Hour := 7;
    m_nTxMsg.m_sbyInfo[6]  := (Hour);
    m_nTxMsg.m_sbyInfo[7]  := ByteToBCD(Day);
    m_nTxMsg.m_sbyInfo[8]  := ByteToBCD(Month);
    m_nTxMsg.m_sbyInfo[9]  := ByteToBCD(Year);
    m_nTxMsg.m_sbyInfo[10] := Season;
    MsgHeadAndPUT(m_nTxMsg, 11);
    Sleep(300);
    LastCommand := 100;
end;

procedure CSET4TMMeter.CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
var
    Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nRxMsg.m_swLen      := 13+11;
    m_nRxMsg.m_sbyInfo[0] := 13;
    m_nRxMsg.m_sbyInfo[1] := paramNo;
    m_nRxMsg.m_sbyInfo[2] := Year;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;
    m_nRxMsg.m_sbyInfo[8] := tarif;
    Move(Param, m_nRxMsg.m_sbyInfo[9], 4);
    m_nRxMsg.m_swLen      := 11 + m_nRxMsg.m_sbyInfo[0];
end;

function  CSET4TMMeter.ArrayBCDToFloat(var mas:array of byte; size : byte):single;
var i:byte;
begin
   Result := 0;
   for i:=0 to size-1 do
   begin
     Result := Result*$100;
     Result := Result + mas[i];
   end;
end;

function  CSET4TMMeter.ReadSymEnerg(var pMsg : CMessage):boolean;
var param : single;
    i     : byte;
begin
     if (pMsg.m_swLen - 11) <> 19 then
     begin
        Result := false;
        exit;
     end;
     for i := 0 to 3 do
     begin
       param := ArrayBCDToFloat(pMsg.m_sbyInfo[1 + i*4], 4);
       param := param/(2*m_sfKA);
       CreateOutputMsg(QRY_ENERGY_SUM_EP + i, param, m_nTxMsg.m_sbyInfo[3]);
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadDayEnerg(var pMsg : CMessage):boolean;
var param : single;
    i     : byte;
begin
     if (pMsg.m_swLen - 11) <> 19 then
     begin
        Result := false;
        exit;
     end;
     for i := 0 to 3 do
     begin
       param := ArrayBCDToFloat(pMsg.m_sbyInfo[1 + i*4], 4);
       param := param/(2*m_sfKA);
       CreateOutputMsg(QRY_NAK_EN_DAY_EP + i, param, m_nTxMsg.m_sbyInfo[3]);
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadMonthEnerg(var pMsg : CMessage):boolean;
var param : single;
    i     : byte;
begin
     if (pMsg.m_swLen - 11) <> 19 then
     begin
        Result := false;
        exit;
     end;
     for i := 0 to 3 do
     begin
       param := ArrayBCDToFloat(pMsg.m_sbyInfo[1 + i*4], 4);
       param := param/(2*m_sfKA);
       CreateOutputMsg(QRY_NAK_EN_MONTH_EP + i, param, m_nTxMsg.m_sbyInfo[3]);
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadInstantPower(var pMsg : CMessage):boolean;
var param : single;
parametr  : byte;
begin
     if (pMsg.m_swLen - 11) <> 9 then
     begin
       Result := false;
       exit;
     end;
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[1], 3);
     param := (param*16*0.484181)/(2*m_sfKA);
     CreateOutputMsg(QRY_MGAKT_POW_S, param, 0);
     FPUT(BOX_L3_BY,@m_nRxMsg);
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[1], 3);
     param := (param*16*0.759662)/(2*m_sfKA);
     CreateOutputMsg(QRY_MGREA_POW_S, param, 0);
     FPUT(BOX_L3_BY,@m_nRxMsg);
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadVoltage(var pMsg : CMessage):boolean;
var param : single;
begin
     if (pMsg.m_swLen - 11) <> 6 then
     begin
       Result := false;
       exit;
     end;
     pMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[1] and $3F;
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[1], 3);
     param := param/100;
     CreateOutputMSG(QRY_U_PARAM_A + (m_nTxMsg.m_sbyInfo[3] and $03) - 1, param, 0);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadCurr(var pMsg : CMessage):boolean;
var param : single;
begin
     if (pMsg.m_swLen - 11) <> 6 then
     begin
       Result := false;
       exit;
     end;
     pMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[1] and $3F;
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[1], 3);
     param := param/10;
     CreateOutputMSG(QRY_I_PARAM_A + (m_nTxMsg.m_sbyInfo[3] and $03) - 1, param, 0);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadFreq(var pMsg : CMessage):boolean;
var param : single;
begin
     if (pMsg.m_swLen - 11) <> 6 then
     begin
       Result := false;
       exit;
     end;
     pMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[1] and $3F;
     param := ArrayBCDToFloat(pMsg.m_sbyInfo[1], 3);
     param := param/100;
     CreateOutputMSG(QRY_FREQ_NET , param, 0);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     SendSyncEvent;
     Result := true;
end;

function  CSET4TMMeter.ReadDateTime(var pMsg : CMessage):boolean;
var Year, Month, Day       : word;
    Hour, Min, Sec, mSec   : word;
begin
     if (pMsg.m_swLen - 11) <>  11 then
     begin
       Result := false;
       exit;
     end;
     m_nRxMsg.m_sbyInfo[0] := 8;
     m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
     m_nRxMsg.m_sbyInfo[2] := BCDToByte(pMsg.m_sbyInfo[7]); //y
     m_nRxMsg.m_sbyInfo[3] := BCDToByte(pMsg.m_sbyInfo[6]); //m
     m_nRxMsg.m_sbyInfo[4] := BCDToByte(pMsg.m_sbyInfo[5]); //d
     m_nRxMsg.m_sbyInfo[5] := BCDToByte(pMsg.m_sbyInfo[3]); //h
     m_nRxMsg.m_sbyInfo[6] := BCDToByte(pMsg.m_sbyInfo[2]); //m
     m_nRxMsg.m_sbyInfo[7] := BCDToByte(pMsg.m_sbyInfo[1]); //s
     DecodeDate(Now, Year, Month, Day);
     DecodeTime(Now, Hour, Min, Sec, mSec);
     Year := Year - 2000;
     if (Year <> m_nRxMsg.m_sbyInfo[2]) or (Month <> m_nRxMsg.m_sbyInfo[3]) or (Day <> m_nRxMsg.m_sbyInfo[4])
        or (Hour <> m_nRxMsg.m_sbyInfo[5]) or (Min <> m_nRxMsg.m_sbyInfo[6]) or (abs(m_nRxMsg.m_sbyInfo[7] - Sec) >= 5) then
       SetDateTimeToMeter(pMsg.m_sbyInfo[8]);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     Result := true;
end;

procedure CSET4TMMeter.CreateKanal(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $01;
    move(m_nP.m_schPassword[1], m_nTxMsg.m_sbyInfo[2], 6);
    MSGHeadAndPUT(m_nTxMsg, 8);
end;

function CSET4TMMeter.ReadKanal(var pMsg : CMessage):boolean;
begin
    if (pMsg.m_sbyInfo[1] <> 0) then
      Result := false
    else
    begin
      Result := true;
      m_nRepTimer.OffTimer;
      SendSyncEvent;
    end;
end;

procedure CSET4TMMeter.MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size + 11 + 2;
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_SET4TM;     //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
    CRC(pMSg.m_sbyInfo, Size);
    FPUT(BOX_L1, @pMsg);
end;

procedure CSET4TMMeter.CreateSymEnergReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $05;
    m_nTxMsg.m_sbyInfo[2] := $00;
    m_nTxMsg.m_sbyInfo[3] := nReq.m_swSpecc1;
    MSGHeadAndPUT(m_nTxMsg, 4);
end;

procedure CSET4TMMeter.CreateDayEnergReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $05;
    m_nTxMsg.m_sbyInfo[2] := $04 shl 4;
    m_nTxMsg.m_sbyInfo[3] := nReq.m_swSpecc1;
    MSGHeadAndPUT(m_nTxMsg, 4);
end;

procedure CSET4TMMeter.CreateMonthEnergReqMSG(var nReq:CQueryPrimitive);
var Day, Month, Year : word;
begin
    LastCommand           := nReq.m_swParamID;
    DecodeDate(Now, Year, Month, Day);
    if (Month = 1) then
      Month := 13;  //Если текущий месяц январь, то перейдем на декабрь
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $05;
    m_nTxMsg.m_sbyInfo[2] := ($03 shl 4) + lo(Month-1);
    m_nTxMsg.m_sbyInfo[3] := nReq.m_swSpecc1;
    MSGHeadAndPUT(m_nTxMsg, 4);
end;

procedure CSET4TMMeter.CreateInstantPowerReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $08;
    m_nTxMsg.m_sbyInfo[2] := $10;
    MSGHeadAndPUT(m_nTxMsg, 3);
end;

procedure CSET4TMMeter.CreateVoltageReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $08;
    m_nTxMsg.m_sbyInfo[2] := $11;
    m_nTxMsg.m_sbyInfo[3] := ($01 shl 4) + nReq.m_swSpecc0;
    MSGHeadAndPUT(m_nTxMsg, 4);
end;

procedure  CSET4TMMeter.CreateCurrReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $08;
    m_nTxMsg.m_sbyInfo[2] := $11;
    m_nTxMsg.m_sbyInfo[3] := ($02 shl 4) + nReq.m_swSpecc0;
    MSGHeadAndPUT(m_nTxMsg, 4);
end;

procedure CSET4TMMeter.CreateFreqReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $08;
    m_nTxMsg.m_sbyInfo[2] := $11;
    m_nTxMsg.m_sbyInfo[3] := ($09 shl 4);
    MSGHeadAndPUT(m_nTxMsg, 4);
end;

procedure CSET4TMMeter.CreateDateTimeReqMSG(var nReq:CQueryPrimitive);
begin
    LastCommand           := nReq.m_swParamID;
    m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[1] := $04;
    m_nTxMsg.m_sbyInfo[2] := $00;
    MSGHeadAndPUT(m_nTxMsg, 3);
end;

procedure CSET4TMMeter.InitMeter(var pL2:SL2TAG);
Begin
    m_sfKA := 1250;
    //if m_nP.m_sbyHandScenr=0 then
    //Begin
    // SetCurrQry;
    // SetGraphQry;
    //end;
    //if m_nP.m_sbyHandScenr=1 then
    //Begin
     SetHandScenario;
     SetHandScenarioGraph;
    //end;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SET4TM  Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CSET4TMMeter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(0,0,0,0,1);  //Открытие канала связи
     AddCurrParam(1,0,0,0,1);  //+Запрос на суммарную накопленную энергию(speq1 - тариф)
     AddCurrParam(1,0,1,0,1);
     AddCurrParam(1,0,2,0,1);
     AddCurrParam(1,0,3,0,1);
     AddCurrParam(1,0,4,0,1);
     AddCurrParam(42,0,0,0,1);  //+Запрос на чтение энергии за день
     AddCurrParam(42,0,1,0,1);
     AddCurrParam(42,0,2,0,1);
     AddCurrParam(42,0,3,0,1);
     AddCurrParam(42,0,4,0,1);
     AddCurrParam(43,0,0,0,1);  //+Запрос на энергию за месяц
     AddCurrParam(43,0,1,0,1);
     AddCurrParam(43,0,2,0,1);
     AddCurrParam(43,0,3,0,1);
     AddCurrParam(43,0,4,0,1);
     AddCurrParam(8,0,0,0,1);  //+Мгновенная активная и реактивная мощность(speq0 - акт, реакт)
     AddCurrParam(10,1,0,0,1); //+Запрос на чтение напряжения (speq0 - фаза)
     AddCurrParam(10,2,0,0,1);
     AddCurrParam(10,3,0,0,1);
     AddCurrParam(11,1,0,0,1); //+Запрос на чтение тока (speq0 - фаза)
     AddCurrParam(11,2,0,0,1);
     AddCurrParam(11,3,0,0,1);
     AddCurrParam(13,0,0,0,1); //+Чтение частоты сети
     AddCurrParam(32,0,0,0,1); //+Текущее значение даты и времени
    End;
End;
procedure CSET4TMMeter.SetGraphQry;
Begin

End;
{
procedure CSET4TMMeter.SetHandScenarioCurr;
Var
    pQry   : PCQueryPrimitive;
Begin
    m_nObserver.ClearCurrQry;
    while(m_nObserver.GetCommand(pQry)=True) do
    Begin
     with m_nObserver do Begin
     if pQry.m_swParamID<15 then TraceL(2,pQry.m_swMtrID,'(__)CL2MD::>CSS301 CMD INIT:'+IntToStr(pQry.m_swParamID)+':'+chQryType[pQry.m_swParamID]);
     case pQry.m_swParamID of
      EN_QRY_SUM:        //Енергия: суммарная накопленная
      Begin
       AddCurrParam(0,0,0,0,1);  //Открытие канала связи
       AddCurrParam(1,0,0,0,1);  //+Запрос на суммарную накопленную энергию(speq1 - тариф)
       AddCurrParam(1,0,1,0,1);
       AddCurrParam(1,0,2,0,1);
       AddCurrParam(1,0,3,0,1);
       AddCurrParam(1,0,4,0,1);
      End;
      EN_QRY_INC_DAY:    //Енергия: Приращение за день
      Begin

      End;
      EN_QRY_INC_MON:    //Енергия: Приращение за месяц
      Begin

      End;
      EN_QRY_SRS_30M:    //Енергия: Cрез 30 мин
      Begin

      End;
      EN_QRY_ALL_DAY:    //Енергия: Начало суток
      Begin
       AddCurrParam(0,0,0,0,1);
       AddCurrParam(42,0,0,0,1);  //+Запрос на чтение энергии за день
       AddCurrParam(42,0,1,0,1);
       AddCurrParam(42,0,2,0,1);
       AddCurrParam(42,0,3,0,1);
       AddCurrParam(42,0,4,0,1);
      End;
      EN_QRY_ALL_MON:    //Енергия: Начало месяца
      Begin
       AddCurrParam(0,0,0,0,1);
       AddCurrParam(43,0,0,0,1);  //+Запрос на энергию за месяц
       AddCurrParam(43,0,1,0,1);
       AddCurrParam(43,0,2,0,1);
       AddCurrParam(43,0,3,0,1);
       AddCurrParam(43,0,4,0,1);
      End;
      PW_QRY_SRS_3M:     //Мощность:Срез 3 мин
      Begin

      End;
      PW_QRY_SRS_30M:    //Мощность:Срез 30 мин
      Begin

      End;
      PW_QRY_MGACT:      //Мощность:Мгновенная активная
      Begin
        AddCurrParam(0,0,0,0,1);
        AddCurrParam(8,0,0,0,1);
      End;
      PW_QRY_MGRCT:      //Мощность:Мгновенная реактивная
      Begin
       AddCurrParam(0,0,0,0,1);
       AddCurrParam(8,0,0,0,1);
      End;
      U_QRY:             //Напряжение
      Begin
       AddCurrParam(0,0,0,0,1);
       AddCurrParam(10,1,0,0,1); //+Запрос на чтение напряжения (speq0 - фаза)
       AddCurrParam(10,2,0,0,1);
       AddCurrParam(10,3,0,0,1);
      End;
      I_QRY:             //Ток
      Begin
        AddCurrParam(0,0,0,0,1);
        AddCurrParam(11,1,0,0,1); //+Запрос на чтение тока (speq0 - фаза)
        AddCurrParam(11,2,0,0,1);
        AddCurrParam(11,3,0,0,1);
      End;
      F_QRY:             //Частота
      Begin
        AddCurrParam(0,0,0,0,1);
        AddCurrParam(13,0,0,0,1);
      End;
      KM_QRY:            //Коэффициент можности
      Begin

      End;
      DATE_QRY:          //Дата-время
      Begin
        AddCurrParam(0,0,0,0,1);
        AddCurrParam(32,0,0,0,1);
      End;
     End;
     End;//With
    End;
End;
procedure CSET4TMMeter.SetHandScenarioGraph;
Begin
End;
}
function CSET4TMMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

function CSET4TMMeter.CRC(var buf : array of byte; cnt : byte):boolean;
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : byte;
    cmp                 : byte;
    idx                 : byte;
begin
    Result  := true;
    CRChiEl := $FF;
    CRCloEl := $FF;
    cmp     := cnt-1;
    for i:=0 to cmp do
    begin
     idx       := (CRChiEl Xor buf[i]) And $FF;
     CRChiEl   := (CRCloEl Xor CRCHI[idx]);
     CRCloEl   := CRCLO[idx];
    end;
    if (CRChiEl <> buf[cnt]) and (CRCloEl <> buf[cnt+1]) then
      Result := false;
    buf[cnt]    := CRChiEl;
    buf[cnt+1]  := CRCloEl;
end;

function CSET4TMMeter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        if CRC(pMsg.m_sbyInfo, pMsg.m_swLen - 11 - 2) <> true then
          exit;
        case (LastCommand) of
          QRY_NULL_COMM       : res := ReadKanal(pMsg);//Окрыли канал связи и идем на следующий запрос
          QRY_ENERGY_SUM_EP   : res := ReadSymEnerg(pMsg);
          QRY_NAK_EN_DAY_EP   : res := ReadDayEnerg(pMsg);
          QRY_NAK_EN_MONTH_EP : res := ReadMonthEnerg(pMsg);
          QRY_MGAKT_POW_S     : res := ReadInstantPower(pMsg);
          QRY_U_PARAM_A       : res := ReadVoltage(pMsg);
          QRY_I_PARAM_A       : res := ReadCurr(pMsg);
          QRY_FREQ_NET        : res := ReadFreq(pMsg);
          QRY_DATA_TIME       : res := ReadDateTime(pMsg);
          100 : SendSyncEvent; //(Синхронизация)
        end;
        //Переслать в L3 только значение и остановить таймер ожидания подтверждения
        if res then
          m_nRepTimer.OffTimer;
      End;
    End;
    Result := res;
End;
{
  QRY_NULL_COMM         = 0;//0
  QRY_ENERGY_SUM_EP     = 1;//1
  QRY_ENERGY_SUM_EM     = 2;
  QRY_ENERGY_SUM_RP     = 3;
  QRY_ENERGY_SUM_RM     = 4;
  QRY_ENERGY_DAY_EP     = 5;//2
  QRY_ENERGY_DAY_EM     = 6;
  QRY_ENERGY_DAY_RP     = 7;
  QRY_ENERGY_DAY_RM     = 8;
  QRY_ENERGY_MON_EP     = 9;//3
  QRY_ENERGY_MON_EM     = 10;
  QRY_ENERGY_MON_RP     = 11;
  QRY_ENERGY_MON_RM     = 12;
  QRY_SRES_ENR_EP       = 13;//36
  QRY_SRES_ENR_EM       = 14;
  QRY_SRES_ENR_RP       = 15;
  QRY_SRES_ENR_RM       = 16;
  QRY_NAK_EN_DAY_EP     = 17;//42
  QRY_NAK_EN_DAY_EM     = 18;
  QRY_NAK_EN_DAY_RP     = 19;
  QRY_NAK_EN_DAY_RM     = 20;
  QRY_NAK_EN_MONTH_EP   = 21;//43
  QRY_NAK_EN_MONTH_EM   = 22;
  QRY_NAK_EN_MONTH_RP   = 23;
  QRY_NAK_EN_MONTH_RM   = 24;
  QRY_NAK_EN_YEAR_EP    = 25;
  QRY_NAK_EN_YEAR_EM    = 26;
  QRY_NAK_EN_YEAR_RP    = 27;
  QRY_NAK_EN_YEAR_RM    = 28;
  QRY_E3MIN_POW_EP      = 29;//5
  QRY_E3MIN_POW_EM      = 30;
  QRY_E3MIN_POW_RP      = 31;
  QRY_E3MIN_POW_RM      = 32;
  QRY_E30MIN_POW_EP     = 33;//6
  QRY_E30MIN_POW_EM     = 34;
  QRY_E30MIN_POW_RP     = 35;
  QRY_E30MIN_POW_RM     = 36;
  QRY_MGAKT_POW_S       = 37;//8
  QRY_MGAKT_POW_A       = 38;
  QRY_MGAKT_POW_B       = 39;
  QRY_MGAKT_POW_C       = 40;
  QRY_MGREA_POW_S       = 41;//9
  QRY_MGREA_POW_A       = 42;
  QRY_MGREA_POW_B       = 43;
  QRY_MGREA_POW_C       = 44;
  QRY_U_PARAM_A         = 45;//10
  QRY_U_PARAM_B         = 46;
  QRY_U_PARAM_C         = 47;
  QRY_I_PARAM_A         = 48;//11
  QRY_I_PARAM_B         = 49;
  QRY_I_PARAM_C         = 50;
  QRY_KOEF_POW_A        = 51;//12
  QRY_KOEF_POW_B        = 52;
  QRY_KOEF_POW_C        = 53;
  QRY_FREQ_NET          = 54;//13
  QRY_KPRTEL_A          = 55;//24
  QRY_KPRTEL_R          = 56;
  QRY_DATA_TIME         = 57;//32
  QRY_POINT_POS         = 58;
}
function CSET4TMMeter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
    nReq: CQueryPrimitive;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
        Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
        if nReq.m_swParamID=QM_ENT_MTR_IND then Begin FinalAction;exit;End;
        if nReq.m_swParamID=QM_FIN_MTR_IND then Begin FinalAction;exit;End;
        case (nReq.m_swParamID) of
        QRY_NULL_COMM      : CreateKanal(nReq);
        QRY_ENERGY_SUM_EP  : CreateSymEnergReqMSG(nReq);
        QRY_NAK_EN_DAY_EP  : CreateDayEnergReqMSG(nReq);
        QRY_NAK_EN_MONTH_EP: CreateMonthEnergReqMSG(nReq);
        QRY_MGAKT_POW_S    : CreateInstantPowerReqMSG(nReq);
        QRY_U_PARAM_A      : CreateVoltageReqMSG(nReq);
        QRY_I_PARAM_A      : CreateCurrReqMSG(nReq);
        QRY_FREQ_NET       : CreateFreqReqMSG(nReq);
        QRY_DATA_TIME      : CreateDateTimeReqMSG(nReq);
        end;
        //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
        TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>SET4TM DRQ:',@pMsg);
        m_nRepTimer.OnTimer(m_nP.m_swRepTime);
      End;
    End;
    Result := res;
End;

procedure CSET4TMMeter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

end.
