unit knsl2ss101meter;
//{$DEFINE SS101_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule,utlTimeDate;
type
    CSS101Meter = class(CMeter)
    Private
     m_nCounter  : Integer;
     m_nCounter1 : Integer;
     IsUpdate    : boolean;
     nReq        : CQueryPrimitive;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     function    GetCommand(byCommand:Byte):Integer;
     procedure   TestMessage(var pMsg:CMessage);
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     function    CRC(var buf : array of byte; cnt : byte):boolean;
     function    ProcessingData(var pMsg:CMessage;var i:integer) : boolean;
     function    GetValue(var pMsg:CMessage;i:integer):Single;
     procedure   WriteValue(var pMsg:CMessage;i:integer);
     procedure   WriteI(var pMsg:CMessage;i:integer);
     procedure   WriteU(var pMsg:CMessage;i:integer);
     procedure   WriteP(var pMsg:CMessage;i:integer);
     procedure   WriteE(var pMsg:CMessage;i:integer);
     function    SendToL3(var pMsg:CMessage) : boolean;
     procedure   GetTimeValue(var nReq: CQueryPrimitive);
     procedure   Autoriztion;
     procedure   KorrTime();
     procedure   SetTime();
     procedure   AddEnergyDayGraphQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddEnergyMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddNakEnDayGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddNakEnMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddMaxPower(dt_Date1, dt_Date2  : TDateTime);
     procedure   AddKorrGraphQry(dt_Date1 : TDateTime; srezN, srezK : byte);
     procedure   WriteDate(var pMsg : CMessage; param : word);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     //procedure   SetGraphParam(dt_Date1, dt_Date2:TDateTime; param : word);override;
    End;
implementation
constructor CSS101Meter.Create;
Begin
End;



procedure CSS101Meter.InitMeter(var pL2:SL2TAG);
Begin
    m_nCounter := 0;
    m_nCounter1:= 0;
    IsUpdate   := false;
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
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CSS101  Meter Created:'+
//    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
//    ' Rep:'+IntToStr(m_byRep)+
//    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CSS101Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_SS101;     //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CSS101Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     AddCurrParam(QRY_ENERGY_SUM_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,4,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,1,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_MON_EP,0,4,0,1);
     AddCurrParam(QRY_E3MIN_POW_EP,0,0,0,1);
     AddCurrParam(QRY_E30MIN_POW_EP,0,0,0,1);
     AddCurrParam(QRY_MGAKT_POW_S,0,0,0,1);
     AddCurrParam(QRY_MGREA_POW_S,0,0,0,1);
     AddCurrParam(QRY_U_PARAM_A,0,0,0,1);
     AddCurrParam(QRY_I_PARAM_A,0,0,0,1);
     AddCurrParam(QRY_KOEF_POW_A,0,0,0,1);
     AddCurrParam(QRY_FREQ_NET,0,0,0,1);
     AddCurrParam(QRY_KPRTEL_Kpr,0,0,0,1);
     AddCurrParam(QRY_DATA_TIME,0,0,0,1);
     AddCurrParam(QRY_SRES_ENR_EP,0,0,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,4,0,1);
    End;
End;

procedure CSS101Meter.AddEnergyDayGraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;

begin
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin  //В цикле считаю количество дней от текущего
       cDateTimeR.DecDate(TempDate);
       Dec(i);
       if i < -30 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i + 1, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i + 1, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i + 1, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i + 1, 4, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

procedure CSS101Meter.AddEnergyMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i + 1, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i + 1, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i + 1, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i + 1, 4, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CSS101Meter.AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i, Srez     : integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    DeepSrez    : word;
begin
   DecodeTime(Now, h, m, s, ms);
   DeepSrez := 0;
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     DecodeDate(dt_Date2, y, mn, d);
     if cDateTimeR.CompareDay(dt_Date2, Now) = 0 then
     Begin
      for Srez := (h*60 + m) div 30 - 1 downto 0 do m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, mn, d, Srez, 1);
       //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final Day Sres
     End else
     Begin
      for Srez := 47 downto 0 do m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, mn, d, Srez, 1);
       //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final Day Sres
     End;
     cDateTimeR.DecDate(dt_Date2);
     Inc(DeepSrez);
     if (DeepSrez > 365) then
       exit;
   end;
end;

procedure CSS101Meter.AddNakEnDayGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;

begin
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin  //В цикле считаю количество дней от текущего
       cDateTimeR.DecDate(TempDate);
       Dec(i);
       if i < -30 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 4, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

procedure CSS101Meter.AddNakEnMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -12 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i + 1, 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i + 1, 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i + 1, 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i + 1, 4, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CSS101Meter.AddMaxPower(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i, j        : integer;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     for j := 1 to 4 do
       m_nObserver.AddGraphParam(QRY_MAX_POWER_EP, i + 1, 1, j, 1);
     for j := 1 to 4 do
       m_nObserver.AddGraphParam(QRY_MAX_POWER_EP, i + 1, 2, j, 1);
     for j := 1 to 4 do
       m_nObserver.AddGraphParam(QRY_MAX_POWER_EP, i + 1, 3, j, 1);
     for j := 1 to 4 do
       m_nObserver.AddGraphParam(QRY_MAX_POWER_EP, i + 1, 4, j, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CSS101Meter.AddKorrGraphQry(dt_Date1 : TDateTime; srezN, srezK : byte);
var d, mn, y : word;
    i        : byte;
begin
   DecodeDate(dt_Date1, y, mn, d);
   for i := srezK downto srezN do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, mn, d, i, 1);
end;

procedure CSS101Meter.SetGraphQry;
begin

end;


{
procedure CSS101Meter.SetHandScenario;
Var
    pQry   : PCQueryPrimitive;
Begin
    m_nObserver.ClearCurrQry;
    while(m_nObserver.GetCommand(pQry)=True) do
    Begin
     with m_nObserver do Begin
     if pQry.m_swParamID<15 then TraceL(2,pQry.m_swMtrID,'(__)CL2MD::>CSS101 CMD INIT:'+IntToStr(pQry.m_swParamID)+':'+chQryType[pQry.m_swParamID]);
     case pQry.m_swParamID of
      EN_QRY_SUM:        //Енергия: суммарная накопленная
      Begin
       AddCurrParam(1,0,1,0,1);
       AddCurrParam(1,0,2,0,1);
       AddCurrParam(1,0,3,0,1);
       AddCurrParam(1,0,4,0,1);
      End;
      EN_QRY_INC_DAY:    //Енергия: Приращение за день
      Begin
       AddCurrParam(2,0,1,0,1);
       AddCurrParam(2,0,2,0,1);
       AddCurrParam(2,0,3,0,1);
       AddCurrParam(2,0,4,0,1);
      End;
      EN_QRY_INC_MON:    //Енергия: Приращение за месяц
      Begin
       AddCurrParam(3,0,1,0,1);
       AddCurrParam(3,0,2,0,1);
       AddCurrParam(3,0,3,0,1);
       AddCurrParam(3,0,4,0,1);
      End;
      EN_QRY_SRS_30M:    //Енергия: Cрез 30 мин
      Begin
       AddCurrParam(36,0,0,0,1);
      End;
      EN_QRY_ALL_DAY:    //Енергия: Начало суток
      Begin
       AddCurrParam(42,0,1,0,1);
       AddCurrParam(42,0,2,0,1);
       AddCurrParam(42,0,3,0,1);
       AddCurrParam(42,0,4,0,1);
      End;
      EN_QRY_ALL_MON:    //Енергия: Начало месяца
      Begin
       AddCurrParam(43,0,1,0,1);
       AddCurrParam(43,0,2,0,1);
       AddCurrParam(43,0,3,0,1);
       AddCurrParam(43,0,4,0,1);
      End;
      PW_QRY_SRS_3M:     //Мощность:Срез 3 мин
      Begin
       AddCurrParam(5,0,0,0,1);
      End;
      PW_QRY_SRS_30M:    //Мощность:Срез 30 мин
      Begin
       AddCurrParam(6,0,0,0,1);
      End;
      PW_QRY_MGACT:      //Мощность:Мгновенная активная
      Begin
       AddCurrParam(8,0,0,0,1);
      End;
      PW_QRY_MGRCT:      //Мощность:Мгновенная реактивная
      Begin
       AddCurrParam(9,0,0,0,1);
      End;
      U_QRY:             //Напряжение
      Begin
       AddCurrParam(10,0,0,0,1);
      End;
      I_QRY:             //Ток
      Begin
       AddCurrParam(11,0,0,0,1);
      End;
      F_QRY:             //Частота
      Begin
       AddCurrParam(13,0,0,0,1);
      End;
      KM_QRY:            //Коэффициент можности
      Begin
       AddCurrParam(12,0,0,0,1);
      End;
      DATE_QRY:          //Дата-время
      Begin
       AddCurrParam(32, 0, 0, 0, 1);
      End;
     End;
     End;//With
    End;
End;
}

function CSS101Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

procedure CSS101Meter.Autoriztion;
begin
   m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
//   TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>CC101   Autoritization');
   m_nTxMsg.m_sbyInfo[1]  := 31;
   m_nTxMsg.m_sbyInfo[2]  := $00;
   m_nTxMsg.m_sbyInfo[3]  := $00;
   move(m_nP.m_schPassword[1], m_nTxMsg.m_sbyInfo[4], 8);
   CRC(m_nTxMsg.m_sbyInfo, 12);
   MsgHead(m_nTxMsg, 11 + 12 + 2);
   FPUT(BOX_L1 ,@m_nTxMsg);
end;

procedure CSS101Meter.SetTime();
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    //m_nRepTimer.OffTimer;
    m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
//    TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>CC101   Korrektion Time');
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;

    m_nTxMsg.m_sbyInfo[1]  := 16;
    m_nTxMsg.m_sbyInfo[2]  := 32;
    m_nTxMsg.m_sbyInfo[3]  := 2;
    m_nTxMsg.m_sbyInfo[4]  := Sec;
    m_nTxMsg.m_sbyInfo[5]  := Min;
    m_nTxMsg.m_sbyInfo[6]  := Hour;
    m_nTxMsg.m_sbyInfo[7]  := Day;
    m_nTxMsg.m_sbyInfo[8]  := Month;
    m_nTxMsg.m_sbyInfo[9]  := Year;
    CRC(m_nTxMsg.m_sbyInfo, 10);
    MsgHead(m_nTxMsg, 11 + 10 + 2);
    FPUT(BOX_L1, @m_nTxMsg);
    //Sleep(500);

    {m_nTxMsg.m_sbyInfo[1]  := 32;
    m_nTxMsg.m_sbyInfo[2]  := 0;
    m_nTxMsg.m_sbyInfo[3]  := 0;
    CRC(m_nTxMsg.m_sbyInfo, 4);
    MsgHead(m_nTxMsg, 11 + 4 + 2);
    FPUT(BOX_L1, @m_nTxMsg);
    Sleep(350);}
//    m_nRepTimer.S
end;

procedure CSS101Meter.KorrTime();
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    //m_nRepTimer.OffTimer;
//    TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>   Korrection Time');
    {m_nTxMsg.m_sbyInfo[1]  := 31;
    m_nTxMsg.m_sbyInfo[2]  := $00;
    m_nTxMsg.m_sbyInfo[3]  := $00;
    move(m_nP.m_schPassword[1], m_nTxMsg.m_sbyInfo[4], 8);
    CRC(m_nTxMsg.m_sbyInfo, 12);
    MsgHead(m_nTxMsg, 11 + 12 + 2);
    FPUT(BOX_L1 ,@m_nTxMsg);
    Sleep(500);   }
    m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;

    m_nTxMsg.m_sbyInfo[1]  := 16;
    m_nTxMsg.m_sbyInfo[2]  := 32;
    m_nTxMsg.m_sbyInfo[3]  := 0;
    m_nTxMsg.m_sbyInfo[4]  := Sec;
    m_nTxMsg.m_sbyInfo[5]  := Min;
    m_nTxMsg.m_sbyInfo[6]  := Hour;
    m_nTxMsg.m_sbyInfo[7]  := Day;
    m_nTxMsg.m_sbyInfo[8]  := Month;
    m_nTxMsg.m_sbyInfo[9]  := Year;
    CRC(m_nTxMsg.m_sbyInfo, 10);
    MsgHead(m_nTxMsg, 11 + 10 + 2);
    FPUT(BOX_L1, @m_nTxMsg);
    //Sleep(500);

    {m_nTxMsg.m_sbyInfo[1]  := 32;
    m_nTxMsg.m_sbyInfo[2]  := 0;
    m_nTxMsg.m_sbyInfo[3]  := 0;
    CRC(m_nTxMsg.m_sbyInfo, 4);
    MsgHead(m_nTxMsg, 11 + 4 + 2);
    FPUT(BOX_L1, @m_nTxMsg);
    Sleep(350);  }
end;

procedure CSS101Meter.WriteDate(var pMsg : CMessage; param : word);
var i, temp      : shortint;
Year, Month, Day : word;
TempDate         : TDateTime;
begin
    move(m_nTxMsg.m_sbyInfo[3], temp, 1);
    TempDate := Now;
    case param of
      QRY_NAK_EN_MONTH_EP, QRY_ENERGY_MON_EP:
      begin
        //if param=QRY_NAK_EN_MONTH_EP then temp := temp - 1;
        for i := temp to -1 do
          cDateTimeR.DecMonth(TempDate);
        DecodeDate(TempDate, Year, Month, Day);
        m_nRxMsg.m_sbyInfo[2] := Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := Month;
        m_nRxMsg.m_sbyInfo[4] := cDateTimeR.DayPerMonth(Month, Year);
        m_nRxMsg.m_sbyInfo[5] := 23;
        m_nRxMsg.m_sbyInfo[6] := 59;
        m_nRxMsg.m_sbyInfo[7] := 59;
      end;
      QRY_ENERGY_DAY_EP, QRY_NAK_EN_DAY_EP:
      begin
        //if param=QRY_NAK_EN_DAY_EP then temp := temp - 1;
        for i := temp to -1 do
          cDateTimeR.DecDate(TempDate);
        DecodeDate(TempDate, Year, Month, Day);
        m_nRxMsg.m_sbyInfo[2] := Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := Month;
        m_nRxMsg.m_sbyInfo[4] := Day;
        m_nRxMsg.m_sbyInfo[5] := 23;
        m_nRxMsg.m_sbyInfo[6] := 59;
        m_nRxMsg.m_sbyInfo[7] := 59;
      end;
    end;
end;
function CSS101Meter.GetValue(var pMsg:CMessage;i:integer):Single;
Var
    byBuff : array[0..3] of Byte;
    fValue,nIV : Single;
Begin
    byBuff[0] := pMsg.m_sbyInfo[4 + i*4];
    byBuff[1] := pMsg.m_sbyInfo[5 + i*4];
    byBuff[2] := pMsg.m_sbyInfo[6 + i*4];
    byBuff[3] := pMsg.m_sbyInfo[7 + i*4];
    Move(byBuff[0],Result,sizeof(Single));

    {
    case m_nPrecise of
     1 : nIV := 10;
     2 : nIV := 100;
     3 : nIV := 1000;
     4 : nIV := 10000;
     5 : nIV := 100000;
     6 : nIV := 1000000;
     7 : nIV := 10000000;
     else
         nIV := 1000;
    End;
    Result := trunc(fValue*nIV)/nIV;
    }
End;
procedure CSS101Meter.WriteValue(var pMsg:CMessage;i:integer);
Var
    fValue : Double;
begin
    fValue := RV(GetValue(pMsg,i));
    //Null Operation
    Move(fValue,m_nRxMsg.m_sbyInfo[9],sizeof(fValue));
end;
procedure CSS101Meter.WriteI(var pMsg:CMessage;i:integer);
Var
    fValue : Double;
begin
    fValue := RV(GetValue(pMsg,i));
    fValue := fValue*m_nP.m_sfKI;
    Move(fValue,m_nRxMsg.m_sbyInfo[9],sizeof(fValue));
end;
procedure CSS101Meter.WriteU(var pMsg:CMessage;i:integer);
Var
    fValue : Double;
begin
    fValue := RV(GetValue(pMsg,i));
    fValue := fValue*m_nP.m_sfKU;
    Move(fValue,m_nRxMsg.m_sbyInfo[9],sizeof(fValue));
end;
procedure CSS101Meter.WriteP(var pMsg:CMessage;i:integer);
Var
    fValue : Double;
begin
    //Operation
    fValue := RVK(GetValue(pMsg,i));
    fValue := fValue*m_nP.m_sfKI*m_nP.m_sfKU{*m_nP.m_sfMeterKoeff};
    Move(fValue,m_nRxMsg.m_sbyInfo[9],sizeof(fValue));
end;
procedure CSS101Meter.WriteE(var pMsg:CMessage;i:integer);
Var
    fValue : Double;
begin
    //Operation
    try
    fValue := RVK(GetValue(pMsg,i));


    if m_nP.m_swMID=11 then
    begin end;
    //    TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>SS101 DOPROC : '+
//    m_nCommandList.Strings[m_nRxMsg.m_sbyInfo[1]]+'::'+
//    FloatToStr(GetValue(pMsg,i)));

    if fValue<=0.0000001 then
     fValue := 0;
    fValue := fValue*m_nP.m_sfKI*m_nP.m_sfKU{*m_nP.m_sfMeterKoeff};
    Move(fValue,m_nRxMsg.m_sbyInfo[9],sizeof(fValue));
    except

    end;
end;
function  CSS101Meter.ProcessingData(var pMsg:CMessage; var i:integer) : boolean;
var Year, Month, Day       : word;
YearNow, MonthNow, DayNow  : word;
Hour, Min, Sec, mSec       : word;
param                      : single;
fParam                     : Double;
LastDate                   : TDateTime;
begin
    Result := true;
    {$IFNDEF SS101_DEBUG}
    if (pMsg.m_sbyInfo[3] <> 0) then
      Result := false;
    {$endif}
    case (pMsg.m_sbyInfo[2]) of
      1:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_ENERGY_SUM_EP + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4];
        //Move(pMsg.m_sbyInfo[9],fValue,sizeof(Single));
        WriteE(pMsg,i);
      End;
      2:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_ENERGY_DAY_EP + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4];
        WriteE(pMsg,i);
        WriteDate(pMsg, QRY_ENERGY_DAY_EP);
      End;
      3:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_ENERGY_MON_EP + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4];
        WriteE(pMsg,i);
        WriteDate(pMsg, QRY_ENERGY_MON_EP);
      End;
      5:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_E3MIN_POW_EP  + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteP(pMsg,i);
      End;
      6:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_E30MIN_POW_EP + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteP(pMsg,i);
      End;
      7:
      begin
        m_nRxMsg.m_sbyInfo[1] := QRY_MAX_POWER_EP  + (m_nTxMsg.m_sbyInfo[5]-1);
        {$IFNDEF SS101_DEBUG}
        m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[9];//Year
        m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[8];//Month
        m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[7];//Day
        m_nRxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[6];//Hour
        m_nRxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[5];//Min
        m_nRxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[4];//Sec
        //m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4]; //tariff
        {$ELSE}
        m_nRxMsg.m_sbyInfo[2] := 10;//Year
        m_nRxMsg.m_sbyInfo[3] := 07;//Month
        m_nRxMsg.m_sbyInfo[4] := 13;//Day
        m_nRxMsg.m_sbyInfo[5] := 0;//Hour
        m_nRxMsg.m_sbyInfo[6] := 0;//Min
        m_nRxMsg.m_sbyInfo[7] := 0;//Sec
        if m_nTxMsg.m_sbyInfo[4]=1 then param := 23.65478/1000;
        if m_nTxMsg.m_sbyInfo[4]=2 then param := 33.65478/1000;
        if m_nTxMsg.m_sbyInfo[4]=3 then param := 43.65478/1000;
        if m_nTxMsg.m_sbyInfo[4]=4 then param := 53.65478/1000;
        move(param,pMsg.m_sbyInfo[10],4);
        {$ENDIF}
        m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4]; //tariff
        move(pMsg.m_sbyInfo[10], param, 4);
        fParam := param;
        fParam := RV(fParam)*m_nP.m_sfKI*m_nP.m_sfKU;
        move(fParam, m_nRxMsg.m_sbyInfo[9], sizeof(fParam));
        i := 14;
      end;
      8:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_MGAKT_POW_S   + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteP(pMsg,i);
      End;
      9:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_MGREA_POW_S   + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteP(pMsg,i);
      End;
      10:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_U_PARAM_A     + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteU(pMsg,i);
      End;
      11:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_I_PARAM_A    + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteI(pMsg,i);
      End;
      12:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_KOEF_POW_A    + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteValue(pMsg,i);
      End;
      13:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_FREQ_NET      + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteValue(pMsg,i);
      End;
      24:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_KPRTEL_KPR      + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := 0;
        WriteValue(pMsg,i);
      End;
      32:
      Begin
        m_nRxMsg.m_sbyInfo[0] := 8;
        m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
        m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[9];//Year
        m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[8];//Month
        m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[7];//Day
        m_nRxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[6];//Hour
        m_nRxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[5];//Min
        m_nRxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[4];//Sec
        i:=i+3;
        DecodeDate(Now, Year, Month, Day);
        DecodeTime(Now, Hour, Min, Sec, mSec);
        Year := Year - 2000;
        if (Year <> pMsg.m_sbyInfo[9]) or (Month <> pMsg.m_sbyInfo[8]) or (Day <> pMsg.m_sbyInfo[7])
           or (Hour <> pMsg.m_sbyInfo[6]) or (Min <> pMsg.m_sbyInfo[5]) or (abs(pMsg.m_sbyInfo[4] - Sec) >= 2) then
        begin
          //KorrTime();
          Autoriztion;      
          //Sleep(500);
          //SetTime;
        end;
      End;
      36:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_SRES_ENR_EP    + i{ + m_nTxMsg.m_sbyInfo[5]};
        m_nRxMsg.m_sbyInfo[8] := 0;
        m_nRxMsg.m_sbyServerID := m_nTxMsg.m_sbyInfo[5];
        move(pMsg.m_sbyInfo[4+i*4], param, 4);
        fParam := param;
        if fParam<0.000001 then fParam := 0;
        fParam := RVK(fParam)*m_nP.m_sfKI*m_nP.m_sfKU;
        move(fParam, m_nRxMsg.m_sbyInfo[9], sizeof(fParam));
        DecodeDate(Now, YearNow, MonthNow, DayNow);
        Month := m_nTxMsg.m_sbyInfo[3];
        Day   := m_nTxMsg.m_sbyInfo[4];
        Hour  := trunc(m_nTxMsg.m_sbyInfo[5] / 2);
        Min   := m_nTxMsg.m_sbyInfo[5] mod 2 * 30;
        Sec   := 0;
        if (Month > MonthNow) or ((MonthNow = Month) and (Day > DayNow)) then
          Year := YearNow - 1
        else
          Year := YearNow;
        m_nRxMsg.m_sbyInfo[0] := 13+4;
        m_nRxMsg.m_sbyInfo[2] := Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := Month;
        m_nRxMsg.m_sbyInfo[4] := Day;
        m_nRxMsg.m_sbyInfo[5] := Hour;
        m_nRxMsg.m_sbyInfo[6] := Min;
        m_nRxMsg.m_sbyInfo[7] := Sec;
      End;
      42:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_NAK_EN_DAY_EP    + i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4];
        WriteE(pMsg,i);
        WriteDate(pMsg, QRY_NAK_EN_DAY_EP);

      End;
      43:
      Begin
        m_nRxMsg.m_sbyInfo[1] := QRY_NAK_EN_MONTH_EP+ i + m_nTxMsg.m_sbyInfo[5];
        m_nRxMsg.m_sbyInfo[8] := m_nTxMsg.m_sbyInfo[4];
        WriteE(pMsg,i);
        WriteDate(pMsg, QRY_NAK_EN_MONTH_EP);
      End;
    End;
end;

function CSS101Meter.SendToL3(var pMsg:CMessage) : boolean;
Var Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
    i                      : integer;
    fV : array[0..3] of Single;
begin
    i := 0;
    Result := false;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nRxMsg.m_sbyInfo[0] := 13+4;
    m_nRxMsg.m_sbyInfo[2] := Year;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;

    if IsUpdate then
    Begin
     m_nRxMsg.m_sbyDirID    := 1;
     if not((nReq.m_swParamID>=QRY_SRES_ENR_EP)and(nReq.m_swParamID<=QRY_SRES_ENR_RM)) then
     Begin
      //if (m_nCounter>0)and((m_nCounter mod 4)=0) then Inc(m_nCounter1);
      //m_nRxMsg.m_sbyServerID := m_nCounter1;
     End;
     Inc(m_nCounter);
     //m_nCounter := m_nCounter + 1;
    End else
    Begin
     m_nRxMsg.m_sbyDirID    := 0;
     m_nRxMsg.m_sbyServerID := 0;
    End;

    while ((7 + i*4) < (pMsg.m_swLen - 11 - 2)) and ((7 + i*4 ) < (300)) do
    begin
      //TraceL(3,m_nRxMsg.m_swObjID,'(__)CL2MD::>SS101  DO PROC:');
      {$IFDEF SS101_DEBUG}
      Randomize;

        if i=0 then Begin fV[i]:=10+m_nCounter;Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        if i=1 then Begin fV[i]:=20+m_nCounter;Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        if i=2 then Begin fV[i]:=30+m_nCounter;Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        if i=3 then Begin fV[i]:=40+m_nCounter;Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;

        {
        if i=0 then Begin fV[i]:=1000/(10+Random(1000));Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        if i=1 then Begin fV[i]:=1000/(200+Random(200));Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        if i=2 then Begin fV[i]:=1000/(300+Random(300));Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        if i=3 then Begin fV[i]:=1000/(400+Random(400));Move(fV[i],pMsg.m_sbyInfo[4 + i*4],sizeof(Single));End;
        }
     {$ENDIF}
      if (ProcessingData(pMsg, i)) then
      begin
        Result := true;
        m_nRxMsg.m_swLen    := 11 + m_nRxMsg.m_sbyInfo[0];
        //TraceL(3,m_nRxMsg.m_swObjID,'(__)CL2MD::>SS101  POST PROC:');
        //TraceM(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>SS101  SNDL3:',@m_nRxMsg);
        saveToDB(m_nRxMsg);//FPUT(BOX_L3,@m_nRxMsg);
        i := i+1;
        if m_nRxMsg.m_sbyInfo[1] = QRY_DATA_TIME then
          break;
      end
      else
      begin
        Result := false;
        exit;
      end;
    end;
end;
function CSS101Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
Begin
  try
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
//        TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>SS101  DIN:',@pMsg);
        if (pMsg.m_sbyInfo[1] <> 3) and (pMsg.m_sbyInfo[1] <> 4) then
        Begin
          {$IFNDEF SS101_DEBUG}
          if pMsg.m_sbyInfo[1] = 31 then
            SetTime;
//          TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>SS101  CMD Error!!!');
          //SendSyncEvent;
          exit;
          {$ENDIF}
        End;
        if CRC(pMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 2) <> true then
        Begin
          {$IFNDEF SS101_DEBUG}
//          TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>SS101  CRC Error!!!');
          SendSyncEvent;
          exit;
          {$ENDIF}
        End;
        m_byRep        := m_nP.m_sbyRepMsg;
        if SendToL3(pMsg) then
        begin
         m_nRepTimer.OffTimer;
         SendSyncEvent;
        end;
      End;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;

 finally
    Result := res;
 end;   
End;

procedure CSS101Meter.TestMessage(var pMsg:CMessage);
Var
    Year, Month, Day, Hour, Min, Sec, mSec:Word;
    fValue : Single;
Begin
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>SS101  DIN:',@pMsg);
    pMsg.m_swLen   := 11+13;
    pMsg.m_sbyFor  := DIR_L2TOL3;
    pMsg.m_sbyType := DL_DATARD_IND;
    //m_nCounter     := m_nP.m_swMID;
    fValue := pMsg.m_sbyInfo[2]+3*pMsg.m_sbyInfo[4];
    Move(fValue,pMsg.m_sbyInfo[9],sizeof(Single));

    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    pMsg.m_sbyInfo[0] := 13;
    pMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[2];
    pMsg.m_sbyInfo[2] := Year;
    pMsg.m_sbyInfo[3] := Month;
    pMsg.m_sbyInfo[4] := Day;
    pMsg.m_sbyInfo[5] := Hour;
    pMsg.m_sbyInfo[6] := Min;
    pMsg.m_sbyInfo[7] := Sec;

    saveToDB(m_nRxMsg);//FPUT(BOX_L3,@pMsg);
    m_byRep := m_nP.m_sbyRepMsg;
    m_nRepTimer.OffTimer;
    SendSyncEvent;
End;

procedure CSS101Meter.GetTimeValue(var nReq: CQueryPrimitive);
var Year, Month, Day       : word;
Min, Hour, Sec, ms         : word;
DateLast                   : TDateTime;
begin
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   nReq.m_swSpecc0 := Month;
   {nReq.m_swSpecc1 := 14;
   nReq.m_swSpecc2 := 20;}
   nReq.m_swSpecc1 := Day;
   if (Hour*60 + Min) > 30 then
     nReq.m_swSpecc2 := trunc((Hour*60 + Min)/30)-1
   else
   begin
     DateLast := Now;
     cDateTimeR.DecDate(DateLast);
     DecodeDate(DateLast, Year, Month, Day);
     nReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Day;
     nReq.m_swSpecc2 := 47;
   end;
   nReq.m_swSpecc2 := nReq.m_swSpecc2;
end;

procedure CSS101Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := true;
    m_nCounter := 0;
    m_nCounter1:= 0;
    FinalAction;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param := pDS.m_swData1;
    //m_nObserver.AddGraphParam(QM_ENT_MTR_IND, 0, 0, 0, 1);//Enter
    case param of
     QRY_ENERGY_DAY_EP   : AddEnergyDayGraphQry(Date1, Date2);
     QRY_ENERGY_MON_EP   : AddEnergyMonthGrpahQry(Date1, Date2);
     QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP,QRY_SRES_ENR_RM
                         : AddSresEnergGrpahQry(Date1, Date2);
     QRY_NAK_EN_DAY_EP   : AddNakEnDayGrpahQry(Date1, Date2);
     QRY_NAK_EN_MONTH_EP : AddNakEnMonthGrpahQry(Date1, Date2);
     QRY_MAX_POWER_EP    : AddMaxPower(Date1, Date2);
    end;
    //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final
end;
function CSS101Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    //nReq         : CQueryPrimitive;
    tempP        : ShortInt;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //IsUpdate := false;
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
       //TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>SS101  DRQ:',@pMsg);
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));

       if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;

       m_nTxMsg.m_sbyInfo[0] := StrToInt(m_nP.m_sddPHAddres);  //adress
       if (GetCommand(nReq.m_swParamID) = 36) and (nReq.m_swSpecc0 = 0){ and (nReq.m_swSpecc1 = 0)} and (nReq.m_swSpecc2 = 0) then
       begin
        GetTimeValue(nReq);
       end;
       if nReq.m_swParamID = QRY_SRES_ENR_DAY_EP then
       begin
         SendSyncEvent;
         exit;
       end;
        m_nTxMsg.m_sbyInfo[1] := 4;               //fnc
        m_nTxMsg.m_sbyInfo[2] := GetCommand(nReq.m_swParamID);//parameter
        m_nTxMsg.m_sbyInfo[3] := nReq.m_swSpecc0; //smes
        m_nTxMsg.m_sbyInfo[4] := nReq.m_swSpecc1; //tar
        tempP                 := nReq.m_swSpecc2;
        move(tempP, m_nTxMsg.m_sbyInfo[5], 1);    //spec
        CRC(m_nTxMsg.m_sbyInfo, 6);

        {$IFNDEF SS101_DEBUG}
        MsgHead(m_nTxMsg, 11 + 6 + 2);
        {$ELSE}
        MsgHead(m_nTxMsg, 11 + 6 + 2+4*4);
        {$ENDIF}
//        TraceM(2,m_nTxMsg.m_swObjID,'(__)CL2MD::>SS101  CMD:'+m_nCommandList.Strings[nReq.m_swParamID]+' Msg:',@m_nTxMsg);

        SendOutStat(m_nTxMsg.m_swLen);
        FPUT(BOX_L1 ,@m_nTxMsg);

        m_nRepTimer.OnTimer(m_nP.m_swRepTime);


      End;
      QL_DATA_GRAPH_REQ: HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;
procedure CSS101Meter.OnEnterAction;
Begin
//    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>SS101 OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if m_nP.m_sbyModem=0 then FinalAction;
End;
procedure CSS101Meter.OnFinalAction;
Begin
//    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>SS101 OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;
procedure CSS101Meter.OnConnectComplette(var pMsg:CMessage);
Begin
//    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>SS101 OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;
procedure CSS101Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
//    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>SS101 OnDisconnectComplette');
    m_nModemState := 0;
    SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR_IND);
    //FinalAction;
End;
procedure CSS101Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
//     TraceM(4,pMsg.m_swObjID,'(__)CL2MD::>SS101OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := false;
     m_nCounter := 0;
     m_nCounter1:= 0;
    End;
end;
function CSS101Meter.GetCommand(byCommand:Byte):Integer;
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
     QRY_KPRTEL_KE      :   res:=24;//= 55;//24
     QRY_KPRTEL_KPR     :   res:=24; 
     //QRY_KPRTEL_R          res:=0;//= 56;
     QRY_DATA_TIME      :   res:=32;//= 57;//
     QRY_MAX_POWER_EP   :   res:=7;
     else
     res:=-1;
    End;
    Result := res;
End;
function CSS101Meter.CRC(var buf : array of byte; cnt : byte):boolean;
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
    if cnt >= 300 then
    begin
       Result := false;
       exit;
    end;
    for i:=0 to cmp do
    begin
     idx       := (CRChiEl Xor buf[i]) And $FF;
     CRChiEl   := (CRCloEl Xor CRCHI[idx]);
     CRCloEl   := CRCLO[idx];
    end;
    if (CRCloEl <> buf[cnt]) and (CRChiEl <> buf[cnt+1]) then
      Result := false;
    buf[cnt]    := CRCloEl;
    buf[cnt+1]  := CRChiEl;
end;
procedure CSS101Meter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;
end.
