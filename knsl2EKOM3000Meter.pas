unit knsl2EKOM3000Meter;
//{$DEFINE SS301_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate, utldatabase,knsl3EventBox;
type
    CEKOM3000Meter = class(CMeter)
    Private
     m_nCounter   : Integer;
     m_nCounter1  : Integer;
     //IsUpdate     : boolean;
     nReq         : CQueryPrimitive;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     procedure   MovePascalString(str : string; var buf : array of byte);
     function    GetChanInfo(PID : integer): string;
     procedure   MoveChanInfo(var buf : array of byte; PID : integer);
     procedure   MoveTime3(dt_DateTime : TDateTime; var mas : array of byte);
     function    EncodeFormatT3(var buf : array of byte) : TDateTime;
     procedure   MoveTimeFromDepth(var buf : array of byte; Depth, PID : integer);
     procedure   ReadAutorAns(var pMsg : CMessage);
     procedure   ReadEnSumAns(var pMsg : CMessage);
     procedure   ReadNakEnDayAns(var pMsg : CMessage);
     procedure   ReadNakEnMonAns(var pMsg : CMessage);
     procedure   ReadEnDayAns(var pMsg : CMessage);
     procedure   ReadEnMonAns(var pMsg : CMessage);
     procedure   ReadSresEnAns(var pMsg : CMessage);
     procedure   ReadJrnlAns(var pMsg : CMessage);
     procedure   ReadDateTimeAns(var pMsg : CMessage);
     function    GetCurrValueForEKOM(fValue:double; CMDID : integer):double;
     procedure   ReadCurrParReq(var pMsg: CMessage);
     procedure   CreateAutorReq(var nReq:CQueryPrimitive);
     procedure   CreateEnSumReq(var nReq:CQueryPrimitive);
     procedure   CreateSetDayDateReq(var nReq:CQueryPrimitive);
     procedure   CreateSetMonDateReq(var nReq:CQueryPrimitive);
     procedure   CreateNakEnDayMonReq;
     procedure   CreateEnDayReq(var nReq: CQueryPrimitive);
     procedure   CreateEnMonReq(var nReq: CQueryPrimitive);
     procedure   CreateSresEnReq(var nReq: CQueryPrimitive);
     procedure   CreateJrnlReq(var nReq: CQueryPrimitive);
     procedure   CreateCorrTimeReq;
     procedure   CreateDateTimeReq(var nReq: CQueryPrimitive);
     procedure   CreateCurrParReq(var nReq: CQueryPrimitive);
     procedure   StopComplette(var pMsg:CMessage);
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     Function    CRC(var buf : Array Of byte; count : integer) : word;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
     procedure   AddEnergyDayGrpahQry(Date1, Date2:TDateTime);
     procedure   AddEnergyMonthGrpahQry(Date1, Date2:TDateTime);
     procedure   AddNakEnergyDayGraphQry(Date1, Date2:TDateTime);
     procedure   AddNakEnergyMonthGraphQry(Date1, Date2:TDateTime);
     procedure   AddSresGrpahQry(Date1, Date2:TDateTime);
     procedure   AddEventsGraphQry(var pMsg : CMessage);
     //procedure   SetGraphParam(dt_Date1, dt_Date2:TDateTime; param : word);override;
    End;
implementation

constructor CEKOM3000Meter.Create;
Begin

End;

procedure CEKOM3000Meter.AddEnergyDayGrpahQry(Date1, Date2:TDateTime);
var i : integer;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if Date2 > Now then
     Date2 := Now;
   for i := trunc(Date1) to trunc(Date2) do
   begin
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EM, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RM, trunc(Now) - i, 0, 0, 1);
   end;
end;

procedure CEKOM3000Meter.AddEnergyMonthGrpahQry(Date1, Date2:TDateTime);
var i        : integer;
    TempDate : TDateTime;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if Date2 > Now then
     Date2 := Now;
   while cDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(Date2);
   end;
end;

procedure CEKOM3000Meter.AddNakEnergyDayGraphQry(Date1, Date2:TDateTime);
var i : integer;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if Date2 > Now then
     Date2 := Now;
   for i := trunc(Date1) to trunc(Date2) do
   begin
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EM, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_RP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_RM, trunc(Now) - i, 0, 0, 1);
   end;
end;

procedure CEKOM3000Meter.AddNakEnergyMonthGraphQry(Date1, Date2:TDateTime);
var i        : integer;
    TempDate : TDateTime;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if Date2 > Now then
     Date2 := Now;
   while cDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(Date2);
   end;
end;

procedure CEKOM3000Meter.AddSresGrpahQry(Date1, Date2:TDateTime);
var i : integer;
begin
   if Date2 > Now then
     Date2 := Now;
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   for i := trunc(Date1) to trunc(Date2) do
   begin
     if i < trunc(Now) then
     begin
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, (trunc(Now) - i)*48 + trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 48, 0, 1);
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EM, (trunc(Now) - i)*48 + trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 48, 0, 1);
       m_nObserver.AddGraphParam(QRY_SRES_ENR_RP, (trunc(Now) - i)*48 + trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 48, 0, 1);
       m_nObserver.AddGraphParam(QRY_SRES_ENR_RM, (trunc(Now) - i)*48 + trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 48, 0, 1);
     end
     else
     begin
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 0, 1);
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EM, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 0, 1);
       m_nObserver.AddGraphParam(QRY_SRES_ENR_RP, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 0, 1);
       m_nObserver.AddGraphParam(QRY_SRES_ENR_RM, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, trunc(Now/EncodeTime(0, 30, 0, 0)) mod 48, 0, 1);
     end;
   end;                         
end;

procedure CEKOM3000Meter.AddEventsGraphQry(var pMsg : CMessage);
Var
    Date1, Date2     : TDateTime;
    szDT,JID         : integer;
    Year, Month, Day : word;
    pDS              : CMessageData;
    nJIM             : int64;
begin
   m_nObserver.ClearGraphQry;
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   szDT := sizeof(TDateTime);
   Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
   Move(pDS.m_sbyInfo[0],Date1,szDT);
   Move(pDS.m_sbyInfo[szDT],Date2,szDT);
   Move(pDS.m_sbyInfo[2*szDT],nJIM,sizeof(int64));
   JID := 0;
   if (nJIM and QFH_JUR_0)<>0 then JID:=0;
   if (nJIM and QFH_JUR_1)<>0 then JID:=1;
   if (nJIM and QFH_JUR_2)<>0 then JID:=2;
   if (nJIM and QFH_JUR_3)<>0 then JID:=3;
   DecodeDate(Date1, Year, Month, Day);
   m_nObserver.AddGraphParam(QRY_JRNL_T1, Year, Month, Day, 1);
end;

procedure CEKOM3000Meter.InitMeter(var pL2:SL2TAG);
Begin
    m_nCounter := 0;
    m_nCounter1:= 0;
    IsUpdate   := 0;
    SetHandScenario;
    SetHandScenarioGraph;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CSS301  Meter Created:'+
                          ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
                          ' Rep:'+IntToStr(m_byRep)+
                          ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CEKOM3000Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;             //pMsg.m_sbyInfo[] :=
    pMsg.m_swObjID     := m_nP.m_swMID;     //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;       //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ;    //PH_DATARD_REC
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_EKOM3000;     //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CEKOM3000Meter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL3;
    pMsg.m_sbyFor      := DIR_L2TOL3;         //DIR_L2toL1
    pMsg.m_sbyType     := PH_EVENTS_INT;      //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;          //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_SS301F3;        //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CEKOM3000Meter.CreateOutMSG(param : double; sm : byte; tar : byte);
begin                         //sm - вид энергии; tar - тарифф
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[1] := sm;
   m_nRxMsg.m_sbyInfo[8] := tar;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(double));
   m_nRxMsg.m_sbyDirID   := Byte(IsUpdate);
end;

procedure CEKOM3000Meter.SetCurrQry;
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
     AddCurrParam(QRY_KPRTEL_KPR,0,0,0,1);
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

procedure CEKOM3000Meter.SetGraphQry;
begin

end;

function CEKOM3000Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

procedure CEKOM3000Meter.MovePascalString(str : string; var buf : array of byte);
begin
   buf[0] := Length(str);
   move(str[1], buf[1], Length(str)); 
end;

function CEKOM3000Meter.GetChanInfo(PID : integer): string;
var i : integer;
begin
   Result := '';
   with m_nObserver.pm_sInil2CmdTbl.LockList do
   try
   for i := 0 to count - 1 do
     if CComm(Items[i]).m_swCmdID = PID then
     begin
       Result := CComm(Items[i]).m_swChannel;
       exit;
     end;
    finally
     m_nObserver.pm_sInil2CmdTbl.UnLockList;
    End;
end;

procedure CEKOM3000Meter.MoveChanInfo(var buf : array of byte; PID : integer);
var KanType      : Char;
    KanNumb, i   : Integer;
    ChanInfo     : string;
    k, t         : Integer;
begin
   ChanInfo := GetChanInfo(PID);
   KanType  := ChanInfo[1];
   KanNumb  := 0;
   for i := 2 to length(ChanInfo) do
   begin
     KanNumb := KanNumb*10;
     KanNumb := KanNumb + StrToInt(ChanInfo[i]);
   end;
   t := (KanNumb - 1) div 255;
   k := (KanNumb - 1) mod 255;
   if t < 6 then
     KanNumb := Byte(KanType) + t*32
   else
     KanNumb := Byte(KanType) + (t - 8)*32;
   buf[0] := KanNumb;
   buf[1] := k + 1;
end;

procedure CEKOM3000Meter.MoveTime3(dt_DateTime : TDateTime; var mas : array of byte);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin
   DecodeDate(dt_DateTime, Year, Month, Day);
   DecodeTime(dt_DateTime, Hour, Min, Sec, ms);
   mas[0] := ms mod $100;
   mas[1] := (ms div $100) and $03;
   mas[2] := Sec;
   mas[3] := Min;
   mas[4] := Hour;
   mas[5] := Day;
   mas[6] := Month;
   mas[7] := Year mod $100;
   mas[8] := (Year div $100) and $0F;
   mas[9] := (cDateTimeR.GetSeason(dt_DateTime) and $01);
end;

function  CEKOM3000Meter.EncodeFormatT3(var buf : array of byte) : TDateTime;
var year, month, day,
    hour, min, sec, ms     : word;
begin
   Result := 0;
   ms     := buf[0] + (buf[1] and $03)*$100;
   sec    := buf[2];
   min    := buf[3];
   hour   := buf[4];
   day    := buf[5];
   month  := buf[6];
   year   := buf[7] + (buf[8] and $0F)*$100;
   try
     Result := EncodeDate(year, month, day) + EncodeTime(hour, min, sec, ms);
   except
     Result := 0;
   end;
end;

procedure CEKOM3000Meter.MoveTimeFromDepth(var buf : array of byte; Depth, PID : integer);
var i                  : integer;
    TempDate           : TDateTime;
    DecDate            : TDateTime;
begin
   TempDate := Now;
   case PID of
     QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
     QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM,
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM       :
       TempDate := trunc(TempDate) - Depth;
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM,
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
     QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM       :
     begin
       TempDate := cDateTimeR.GetBeginMonth(TempDate);
       for i := 0 to abs(Depth) - 1 do
         cDateTimeR.DecMonth(TempDate);
     end;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM           :
     begin
       DecDate := EncodeTime(0, 30, 0, 0);
       TempDate := trunc((TempDate / DecDate))*DecDate - Depth*DecDate;  //Вычисление даты для 30 мин срезов
     end;
   end;
   MoveTime3(TempDate, buf);
end;

procedure CEKOM3000Meter.ReadAutorAns(var pMsg : CMessage);
begin
   FinalAction;
end;

procedure CEKOM3000Meter.ReadEnSumAns(var pMsg : CMessage);
var fValue           : real48;
    Year, Month, Day : word;
    Date             : TDateTime;
begin
   if pMsg.m_swLen >= 11 + 23 then
   begin
     move(pMsg.m_sbyInfo[16], fValue, 6);
     Date  := EncodeFormatT3(pMsg.m_sbyInfo[6]);
     CreateOutMSG(fValue, nReq.m_swParamID, 0);
     m_nRxMsg.m_sbyServerID:= 0;
     DecodeDate(Date, Year, Month, Day);
     m_nRxMsg.m_sbyInfo[2] := Year - 2000;
     m_nRxMsg.m_sbyInfo[3] := Month;
     m_nRxMsg.m_sbyInfo[4] := Day;
     m_nRxMsg.m_sbyInfo[5] := 0;
     m_nRxMsg.m_sbyInfo[6] := 0;
     m_nRxMsg.m_sbyInfo[7] := 0;
     FPUT(BOX_L3_BY, @m_nRxMsg);
     FinalAction;
   end;
end;

procedure CEKOM3000Meter.ReadNakEnDayAns(var pMsg : CMessage);
var fValue           : real48;
    Year, Month, Day : word;
    Date             : TDateTime;
begin
   if pMsg.m_swLen >= 11 + 23 then
   begin
     move(pMsg.m_sbyInfo[16], fValue, 6);
     Date  := EncodeFormatT3(pMsg.m_sbyInfo[6]);
     CreateOutMSG(fValue, nReq.m_swParamID, 0);
     m_nRxMsg.m_sbyServerID:= 0;
     DecodeDate(Date, Year, Month, Day);
     m_nRxMsg.m_sbyInfo[2] := Year - 2000;
     m_nRxMsg.m_sbyInfo[3] := Month;
     m_nRxMsg.m_sbyInfo[4] := Day;
     m_nRxMsg.m_sbyInfo[5] := 0;
     m_nRxMsg.m_sbyInfo[6] := 0;
     m_nRxMsg.m_sbyInfo[7] := 0;
     FPUT(BOX_L3_BY, @m_nRxMsg);
     FinalAction;
   end;
end;

procedure CEKOM3000Meter.ReadNakEnMonAns(var pMsg : CMessage);
var fValue           : real48;
    Year, Month, Day : word;
    Date             : TDateTime;
begin
   if pMsg.m_swLen >= 11 + 23 then
   begin
     move(pMsg.m_sbyInfo[16], fValue, 6);
     Date  := EncodeFormatT3(pMsg.m_sbyInfo[6]);
     CreateOutMSG(fValue, nReq.m_swParamID, 0);
     m_nRxMsg.m_sbyServerID:= 0;
     DecodeDate(Date, Year, Month, Day);
     m_nRxMsg.m_sbyInfo[2] := Year - 2000;
     m_nRxMsg.m_sbyInfo[3] := Month;
     m_nRxMsg.m_sbyInfo[4] := Day;
     m_nRxMsg.m_sbyInfo[5] := 0;
     m_nRxMsg.m_sbyInfo[6] := 0;
     m_nRxMsg.m_sbyInfo[7] := 0;
     FPUT(BOX_L3_BY, @m_nRxMsg);
     FinalAction;
   end;
end;

procedure CEKOM3000Meter.ReadEnDayAns(var pMsg : CMessage);
var i                    : integer;
    param                : real48;
    status               : word;
    tmp                  : double;
    Date                 : TDateTime;
    Year, Month, Day     : word;
begin
   i := 0;
   while i*8 < pMsg.m_swLen - 11 - 21 do
   begin
     move(pMsg.m_sbyInfo[19], status, 2);
     if status = 0 then
     begin
       move(pMsg.m_sbyInfo[21], param, 6);
       tmp   := param;
       Date  := EncodeFormatT3(pMsg.m_sbyInfo[5]);
       CreateOutMSG(tmp, nReq.m_swParamID, 0);
       m_nRxMsg.m_sbyServerID:= 0;
       DecodeDate(Date, Year, Month, Day);
       m_nRxMsg.m_sbyInfo[2] := Year - 2000;
       m_nRxMsg.m_sbyInfo[3] := Month;
       m_nRxMsg.m_sbyInfo[4] := Day;
       m_nRxMsg.m_sbyInfo[5] := 0;
       m_nRxMsg.m_sbyInfo[6] := 0;
       m_nRxMsg.m_sbyInfo[7] := 0;
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     Inc(i);
   end;
   FinalAction;
end;

procedure CEKOM3000Meter.ReadEnMonAns(var pMsg : CMessage);
var i                    : integer;
    param                : real48;
    status               : word;
    tmp                  : double;
    Date                 : TDateTime;
    Year, Month, Day     : word;
begin
   i := 0;
   while i*8 < pMsg.m_swLen - 11 - 21 do
   begin
     move(pMsg.m_sbyInfo[19], status, 2);
     if status = 0 then
     begin
       move(pMsg.m_sbyInfo[21], param, 6);
       tmp   := param;
       Date  := EncodeFormatT3(pMsg.m_sbyInfo[5]);
       CreateOutMSG(tmp, nReq.m_swParamID, 0);
       m_nRxMsg.m_sbyServerID:= 0;
       DecodeDate(Date, Year, Month, Day);
       m_nRxMsg.m_sbyInfo[2] := Year - 2000;
       m_nRxMsg.m_sbyInfo[3] := Month;
       m_nRxMsg.m_sbyInfo[4] := Day;
       m_nRxMsg.m_sbyInfo[5] := 0;
       m_nRxMsg.m_sbyInfo[6] := 0;
       m_nRxMsg.m_sbyInfo[7] := 0;
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     Inc(i);
   end;
   FinalAction;
end;

procedure CEKOM3000Meter.ReadSresEnAns(var pMsg : CMessage);
var i                    : integer;
    param                : real48;
    status               : word;
    tmp                  : double;
    Date                 : TDateTime;
    Year, Month, Day,
    Hour, Min, Sec, ms   : word;
    //byMask               : Byte;
begin
   i := 0;
   while i*8 < pMsg.m_swLen - 11 - 21 do
   begin
     move(pMsg.m_sbyInfo[19 + i*8], status, 2);
     Date  := EncodeFormatT3(pMsg.m_sbyInfo[5]);
     m_nRxMsg.m_sbyServerID := trunc(Date/EncodeTime(0, 30, 0, 0) + i) mod 48;
     move(pMsg.m_sbyInfo[21 + i*8], param, 6);
     tmp   := param;
     //if param=0 then m_nRxMsg.m_sbyServerID:=m_nRxMsg.m_sbyServerID or $80;
     if status = 0 then
     begin
        //m_nRxMsg.m_sbyServerID := m_nRxMsg.m_sbyServerID or $40;
     end
     else
     begin
        //tmp                    := 0;
        m_nRxMsg.m_sbyServerID := m_nRxMsg.m_sbyServerID or $40;
     end;
     CreateOutMSG(tmp, nReq.m_swParamID, 0);
     DecodeDate(Date, Year, Month, Day);
     DecodeTime(Date, Hour, Min, Sec, ms);
     m_nRxMsg.m_sbyInfo[2] := Year - 2000;
     m_nRxMsg.m_sbyInfo[3] := Month;
     m_nRxMsg.m_sbyInfo[4] := Day;
     m_nRxMsg.m_sbyInfo[5] := 0;
     m_nRxMsg.m_sbyInfo[6] := 0;
     m_nRxMsg.m_sbyInfo[7] := 0;
     FPUT(BOX_L3_BY, @m_nRxMsg);
     Inc(i);
   end;
   FinalAction;
end;

procedure CEKOM3000Meter.ReadJrnlAns(var pMsg : CMessage);
var i                  : integer;
    Date               : TDateTime;
    Code               : integer;
    Event, Group, CMDID: integer;
    Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin
   i := 0;
   m_nRxMsg.m_swLen       := 15 + 11;
   m_nRxMsg.m_sbyType     := PH_EVENTS_INT;
   m_nRxMsg.m_sbyFor      := DIR_L2TOL3;
   m_nRxMsg.m_swObjID     := m_nP.m_swMID;
   m_nRxMsg.m_sbyServerID := DEV_BTI_SRV;
   while i*11 < pMsg.m_swLen - 11 - 9 do
   begin
     Date := EncodeFormatT3(pMsg.m_sbyInfo[7 + i*11]);
     Code := pMsg.m_sbyInfo[17 + i*11];

     if (pMsg.m_sbyInfo[6] = 0) then // УСПД
     begin
        case Code of
         1: begin // включение
            Event := EVH_POW_ON;
            Group := 1;
         end;
         2: begin // аварийное выключение
            Event := EVH_POW_OF;
            Group := 1;
         end;
         3: begin // перезагрузка по команде
            Event := EVH_PROG_RESTART;
            Group := 1;
         end;
         5: begin // изменение конфигурации
            Event := EVS_CHNG_PARAM;
            Group := 4;
         end;
         6 : begin
            Event := EVH_COR_TIME_DEVICE;
            Group := 1;
         end;
         15: begin // коррекция времени/перед
            Event := EVH_CORR_BEG;
            Group := 1;
         end;
         16: begin //  коррекция времени/после
            Event := EVH_CORR_END;
            Group := 1;
         end;
         21: begin // открыта сессия
            Event := EVS_AUTORIZ;
            Group := 4;
         end;
         22: begin // закрыта сессия
            Event := EVS_END_AUTORIZ;
            Group := 4;
         end;
         32: begin // самодиагностика успешно
            Event := EVH_STEST_PS;
            Group := 1;
         end;
         33: begin // самодиагностика неуспешно
            Event := EVH_STEST_FL;
            Group := 1;
         end;
         129: begin // изм.тарифного расписания
            Event := EVS_TZONE_ED_OF;
            Group := 4;
         end;
         130: begin // сброс показаний
            Event := EVH_DEL_BASE;
            Group := 1;
         end;
         157: begin // сброс журнала
            Event := EVS_DEL_EVENT_JRNL;
            Group := 4;
         end;
         158, 159: begin // переход на з/л время
            Event := EVH_AUTO_GO_TIME;
            Group := 1;
         end;
         162: begin // переход на з/л время
            Event := EVS_STRT_USPD;
            Group := 4;
         end;
         163: begin // переход на з/л время
            Event := EVS_STOP_USPD;
            Group := 4;
         end;

         155: begin // возврат в предел мощности
            Event := EVS_STSTOP;
            Group := 4;
         end;
         156: begin // сброс
            Event := EVS_STSTART;
            Group := 4;
         end;
        else
        begin
          Inc(i);
          continue;
        end;
     end;
     end
   else // Счетчик
   begin
      case Code of
      5: begin // изменение конфигурации
         Event := EVM_CHG_CONST;
         Group := 3;
      end;
      6: begin // коррекция времени
         Event := EVM_CORR_INTER;
         Group := 3;
      end;
      15: begin
          Event := EVM_START_CORR;
          Group := 3;
      end;
      16 : begin
           Event := EVM_FINISH_CORR;
           Group := 3;
      end;
      128: begin // изм.расписания праздников
         Event := EVM_CHG_FREEDAY;
         Group := 3;
      end;
      129: begin // изм.тарифного расписания
         Event := EVM_CHG_TARIFF;
         Group := 3;
      end;
      130: begin // сброс показаний
         Event := EVM_RES_ENERG;
         Group := 3;
      end;
      131: begin // выкл. Фазы 1
         Event := EVM_EXCL_PH_A;
         Group := 3;
      end;
      132: begin // вкл. Фазы 1
         Event := EVM_INCL_PH_A;
         Group := 3;
      end;
      133: begin // выкл. Фазы 2
         Event := EVM_EXCL_PH_B;
         Group := 3;
      end;
      134: begin // вкл. Фазы 2
         Event := EVM_INCL_PH_B;
         Group := 3;
      end;
      135:  begin // выкл. Фазы 3
         Event := EVM_EXCL_PH_C;
         Group := 3;
      end;
      136: begin // вкл. Фазы 3
         Event := EVM_INCL_PH_C;
         Group := 3;
      end;
      137: begin // откр. крышки
         Event := EVM_OPN_COVER;
         Group := 3;
      end;
      138: begin // закр.крышки
         Event := EVM_CLS_COVER;
         Group := 3;
      end;
      139: begin // вых. по ниж.пред.частоты
         Event := EVM_LSTEP_DOWN;
         CMDID := QRY_FREQ_NET;
         Group := 3;
      end;
      140: begin // возврат по ниж.пред.частоты
         Event := EVM_L_NORMAL;
         CMDID := QRY_FREQ_NET;
         Group := 3;
      end;
      
      141: begin // вых. по верх.пред.частоты
         Event := EVM_LSTEP_UP;
         CMDID := QRY_FREQ_NET;
         Group := 3;
      end;
      142: begin // вых. по верх.пред.частоты
         Event := EVM_L_NORMAL;
         CMDID := QRY_FREQ_NET;
         Group := 3;
      end;
      
      143: begin // вых. по ниж.пред.напр. по фазе 1
         Event := EVM_LSTEP_DOWN;
         CMDID := QRY_U_PARAM_A;
         Group := 3;
      end;
      144, 146: begin // возврат по пред.напр. по фазе 1
         Event := EVM_L_NORMAL;
         CMDID := QRY_U_PARAM_A;
         Group := 3;
      end;
      145: begin // вых. по верх.пред.напр. по фазе 1
         Event := EVM_LSTEP_UP;
         CMDID := QRY_U_PARAM_A;
         Group := 3;
      end;

      147: begin // вых. по ниж.пред.напр. по фазе 2
         Event := EVM_LSTEP_DOWN;
         CMDID := QRY_U_PARAM_B;
         Group := 3;
      end;
      148, 150: begin // возврат по пред.напр. по фазе 2
         Event := EVM_L_NORMAL;
         CMDID := QRY_U_PARAM_B;
         Group := 3;
      end;
      149: begin // вых. по верх.пред.напр. по фазе 2
         Event := EVM_LSTEP_UP;
         CMDID := QRY_U_PARAM_B;
         Group := 3;
      end;

      151: begin // вых. по ниж.пред.напр. по фазе 3
         Event := EVM_LSTEP_DOWN;
         CMDID := QRY_U_PARAM_C;
         Group := 3;
      end;
      152, 154: begin // возврат по пред.напр. по фазе 3
         Event := EVM_L_NORMAL;
         CMDID := QRY_U_PARAM_C;
         Group := 3;
      end;
      153: begin // вых. по верх.пред.напр. по фазе 3
         Event := EVM_LSTEP_UP;
         CMDID := QRY_U_PARAM_C;
         Group := 3;
      end;


      174: begin // выход за предел мощности
         Event := EVM_LSTEP_DOWN;
         CMDID := QRY_MGAKT_POW_S;
         Group := 3;
      end;
      175: begin // возврат в предел мощности
         Event := EVM_L_NORMAL;
         CMDID := QRY_MGAKT_POW_S;
         Group := 3;
      end;
      190: begin // сброс
         Event := EVM_RES_ENERG;
         Group := 3;
      end;
        else begin Inc(i); continue; end;
     end;
     end;
     DecodeDate(Date, Year, Month, Day);
     DecodeTime(Date, Hour, Min, Sec, ms);
     m_nRxMsg.m_sbyInfo[0]  := 15;
     m_nRxMsg.m_sbyInfo[1]  := QRY_JRNL_T1 + Group - 1;
     m_nRxMsg.m_sbyInfo[2]  := Year - 2000;
     m_nRxMsg.m_sbyInfo[3]  := Month;
     m_nRxMsg.m_sbyInfo[4]  := Day;
     m_nRxMsg.m_sbyInfo[5]  := Hour;
     m_nRxMsg.m_sbyInfo[6]  := Min;
     m_nRxMsg.m_sbyInfo[7]  := Sec;
     m_nRxMsg.m_sbyInfo[8]  := Group;
     m_nRxMsg.m_sbyInfo[9]  := Event;
     FillChar(m_nTxMsg.m_sbyInfo[10], 4, 0);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     Inc(i);
   end;
   FinalAction;
end;

procedure CEKOM3000Meter.ReadDateTimeAns(var pMsg : CMessage);
var TempDate : TDateTime;
begin
   TempDate := EncodeFormatT3(pMsg.m_sbyInfo[2]);
   if abs(TempDate - Now) > EncodeTime(0, 0, 3, 0) then
     CreateCorrTimeReq
   else
     FinalAction;
end;

function CEKOM3000Meter.GetCurrValueForEKOM(fValue:double; CMDID : integer):double;
begin
   case CMDID of
     QRY_MGAKT_POW_S,
     QRY_MGAKT_POW_A,
     QRY_MGAKT_POW_B,
     QRY_MGAKT_POW_C : Result := fValue/1000;
     QRY_MGREA_POW_S,
     QRY_MGREA_POW_A,
     QRY_MGREA_POW_B,
     QRY_MGREA_POW_C : Result := fValue/1000;
     QRY_U_PARAM_S,
     QRY_U_PARAM_A,
     QRY_U_PARAM_B,
     QRY_U_PARAM_C   : Result := fValue;
     QRY_I_PARAM_S,
     QRY_I_PARAM_A,
     QRY_I_PARAM_B,
     QRY_I_PARAM_C   : Result := fValue/1000;
     QRY_FREQ_NET    : Result := fValue;
     QRY_KOEF_POW_A,
     QRY_KOEF_POW_B,
     QRY_KOEF_POW_C  : Result := fValue;
     else Result := fValue;
   end;
end;

procedure CEKOM3000Meter.ReadCurrParReq(var pMsg: CMessage);
var i                    : integer;
    param                : real48;
    status               : word;
    tmp                  : double;
    Date                 : TDateTime;
    Year, Month, Day,
    Hour, Min, Sec, ms   : word;
begin
   i := 0;
   while i*8 < pMsg.m_swLen - 11 - 8 do
   begin
     param := 0;
     move(pMsg.m_sbyInfo[6], status, 2);
     if status = 0 then
     begin
       move(pMsg.m_sbyInfo[8], param, 6);
       tmp   := param;
       Date  := Now;
       tmp := GetCurrValueForEKOM(tmp, nReq.m_swParamID);
       CreateOutMSG(tmp, nReq.m_swParamID, 0);
       m_nRxMsg.m_sbyServerID:= 0;
       DecodeDate(Date, Year, Month, Day);
       DecodeTime(Date, Hour, Min, Sec, ms);
       m_nRxMsg.m_sbyInfo[2] := Year - 2000;
       m_nRxMsg.m_sbyInfo[3] := Month;
       m_nRxMsg.m_sbyInfo[4] := Day;
       m_nRxMsg.m_sbyInfo[5] := Hour;
       m_nRxMsg.m_sbyInfo[6] := Min;
       m_nRxMsg.m_sbyInfo[7] := Sec;
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
     Inc(i);
   end;
   FinalAction;
end;

procedure CEKOM3000Meter.CreateAutorReq(var nReq:CQueryPrimitive);
var wCRC  : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyinfo[1] := 78;
   m_nTxMsg.m_sbyInfo[2] := 60;
   m_nTxMsg.m_sbyInfo[3] := 0;
   MovePascalString(m_nP.m_schPassword, m_nTxMsg.m_sbyInfo[4]);
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 4 + 1 + Length(m_nP.m_schPassword));
   m_nTxMsg.m_sbyInfo[4 + 1 + Length(m_nP.m_schPassword)] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[4 + 1 + Length(m_nP.m_schPassword) + 1] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 4 + 1 +  Length(m_nP.m_schPassword) + 2);
end;

procedure CEKOM3000Meter.CreateEnSumReq(var nReq:CQueryPrimitive);
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 115;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4] := m_nTxMsg.m_sbyInfo[3];
   m_nTxMsg.m_sbyInfo[5] := 255;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 6);
   m_nTxMsg.m_sbyInfo[6] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[7] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 8);
end;

procedure CEKOM3000Meter.CreateSetDayDateReq(var nReq:CQueryPrimitive);
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 116;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4] := m_nTxMsg.m_sbyInfo[3];
   MoveTimeFromDepth(m_nTxMsg.m_sbyInfo[5], nReq.m_swSpecc0, nReq.m_swParamID);
   MovePascalString(m_nP.m_schPassword, m_nTxmsg.m_sbyInfo[15]);
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 15 + Length(m_nP.m_schPassword) + 1);
   m_nTxMsg.m_sbyInfo[15 + Length(m_nP.m_schPassword) + 1] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[15 + Length(m_nP.m_schPassword) + 2] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 15 + Length(m_nP.m_schPassword) + 3);
end;

procedure CEKOM3000Meter.CreateSetMonDateReq(var nReq:CQueryPrimitive);
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 116;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4] := m_nTxMsg.m_sbyInfo[3];
   MoveTimeFromDepth(m_nTxMsg.m_sbyInfo[5], nReq.m_swSpecc0, nReq.m_swParamID);
   MovePascalString(m_nP.m_schPassword, m_nTxmsg.m_sbyInfo[15]);
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 15 + Length(m_nP.m_schPassword) + 1);
   m_nTxMsg.m_sbyInfo[15 + Length(m_nP.m_schPassword) + 1] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[15 + Length(m_nP.m_schPassword) + 2] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 15 + Length(m_nP.m_schPassword) + 3);
end;

procedure CEKOM3000Meter.CreateNakEnDayMonReq;
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 115;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4] := m_nTxMsg.m_sbyInfo[3];
   case nReq.m_swParamID of
      QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
      QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM     : m_nTxMsg.m_sbyInfo[5] := 2;
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : m_nTxMsg.m_sbyInfo[5] := 3;
      else m_nTxMsg.m_sbyInfo[5] := 0;
   end;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 6);
   m_nTxMsg.m_sbyInfo[6] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[7] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 8);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CEKOM3000Meter.CreateEnDayReq(var nReq: CQueryPrimitive);
var wCRC  : word;
begin
   m_nTxMsg.m_sbyInfo[0]  := 1;
   m_nTxMsg.m_sbyInfo[1]  := 127;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4]  := m_nTxMsg.m_sbyInfo[3];
   MoveTimeFromDepth(m_nTxMsg.m_sbyInfo[5], nReq.m_swSpecc0, nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[15] := 2;
   if nReq.m_swSpecc1 = 0 then
     m_nTxMsg.m_sbyInfo[16] := 1
   else
     m_nTxMsg.m_sbyInfo[16] := nReq.m_swSpecc1;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 17);
   m_nTxMsg.m_sbyInfo[17] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[18] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 19);
end;

procedure CEKOM3000Meter.CreateEnMonReq(var nReq: CQueryPrimitive);
var wCRC  : word;
begin
   m_nTxMsg.m_sbyInfo[0]  := 1;
   m_nTxMsg.m_sbyInfo[1]  := 127;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4]  := m_nTxMsg.m_sbyInfo[3];
   MoveTimeFromDepth(m_nTxMsg.m_sbyInfo[5], nReq.m_swSpecc0, nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[15] := 3;
   if nReq.m_swSpecc1 = 0 then
     m_nTxMsg.m_sbyInfo[16] := 1
   else
     m_nTxMsg.m_sbyInfo[16] := nReq.m_swSpecc1;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 17);
   m_nTxMsg.m_sbyInfo[17] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[18] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 19);
end;

procedure CEKOM3000Meter.CreateSresEnReq(var nReq: CQueryPrimitive);
var wCRC  : word;
begin
   m_nTxMsg.m_sbyInfo[0]  := 1;
   m_nTxMsg.m_sbyInfo[1]  := 127;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4]  := m_nTxMsg.m_sbyInfo[3];
   MoveTimeFromDepth(m_nTxMsg.m_sbyInfo[5], nReq.m_swSpecc0, nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[15] := 1;
   if nReq.m_swSpecc1 = 0 then
     m_nTxMsg.m_sbyInfo[16] := 1
   else
     m_nTxMsg.m_sbyInfo[16] := nReq.m_swSpecc1;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 17);
   m_nTxMsg.m_sbyInfo[17] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[18] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 19);
end;

procedure CEKOM3000Meter.CreateJrnlReq(var nReq: CQueryPrimitive);
var TempDate : TDateTime;
    wCRC     : word;
begin
   TempDate := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 114;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   MoveTime3(TempDate, m_nTxMsg.m_sbyInfo[4]);
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 14);
   m_nTxMsg.m_sbyInfo[14] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[15] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 16);
end;

procedure CEKOM3000Meter.CreateCorrTimeReq;
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 111;
   MoveTime3(Now, m_nTxMsg.m_sbyInfo[2]);
   MovePascalString(m_nP.m_schPassword, m_nTxMsg.m_sbyInfo[12]);
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 12 + 1 + Length(m_nP.m_schPassword));
   m_nTxMsg.m_sbyInfo[12 + 1 + Length(m_nP.m_schPassword)] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[12 + 1 + Length(m_nP.m_schPassword) + 1] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 12 + 1 + Length(m_nP.m_schPassword) + 2);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CEKOM3000Meter.CreateDateTimeReq(var nReq: CQueryPrimitive);
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 110;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 2);
   m_nTxMsg.m_sbyInfo[2] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[3] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 4);
end;

procedure CEKOM3000Meter.CreateCurrParReq(var nReq: CQueryPrimitive);
var wCRC : word;
begin
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 118;
   MoveChanInfo(m_nTxMsg.m_sbyInfo[2], nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[4] := m_nTxMsg.m_sbyInfo[3];
   m_nTxMsg.m_sbyInfo[5] := 0;
   wCRC := CRC(m_nTxMsg.m_sbyInfo[0], 6);
   m_nTxMsg.m_sbyInfo[6] := Lo(wCRC);
   m_nTxMsg.m_sbyInfo[7] := Hi(wCRC);
   MsgHead(m_nTxMsg, 11 + 8);
end;
procedure CEKOM3000Meter.StopComplette(var pMsg:CMessage);
Begin
    TraceM(2,pMsg.m_swObjID,'(__)CECOM::>STOP L2,3 CONF:',@pMsg);
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Удаленная команда выполнена.');
    //FinalAction;
End;
function CEKOM3000Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
    wCRC   : word;
Begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        wCRC := CRC(pMsg.m_sbyInfo, pMsg.m_swLen - 13);
        If wCRC <> word(pMsg.m_sbyInfo[pMsg.m_swLen - 13]) Shl 8 + word(pMsg.m_sbyInfo[pMsg.m_swLen - 12]) Then Begin
          TraceM(2, pMsg.m_swObjID, '(__)CL2MD::>EKOM CRC ERROR!!!:', @pMsg);
          exit;
        End;
        if ((pMsg.m_sbyInfo[1] and $7F) = 111) then
        begin
          FinalAction;
          exit;
        end;
        if (pMsg.m_sbyInfo[1] and $80 <> 0) then
        begin
         case pMsg.m_sbyInfo[1] of
              200,201,202,203,204,205,
              206,207,208,209,210,211,
              212,213,214: Begin StopComplette(pMsg);exit;End;
         else
          Begin
           FinalAction;
           exit;
          End;
         End;


        end;
        if (pMsg.m_sbyInfo[1] = 116) then
        begin
          CreateNakEnDayMonReq;
          exit;
        end;
        case nReq.m_swParamID of
           QRY_AUTORIZATION                          : ReadAutorAns(pMsg);
           QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
           QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM      : ReadEnSumAns(pMsg);

           QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
           QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM      : ReadNakEnDayAns(pMsg);

           QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
           QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : ReadNakEnMonAns(pMsg);

           QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
           QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : ReadEnDayAns(pMsg);

           QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
           QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : ReadEnMonAns(pMsg);

           QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
           QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : ReadSresEnAns(pMsg);
           QRY_JRNL_T1, QRY_JRNL_T2, QRY_JRNL_T3     : ReadJrnlAns(pMsg);
           QRY_DATA_TIME                             : ReadDateTimeAns(pMsg);
           QRY_MGAKT_POW_S, QRY_MGREA_POW_S,
           QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
           QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
           QRY_MGREA_POW_B, QRY_MGREA_POW_C,
           QRY_U_PARAM_A, QRY_U_PARAM_B,
           QRY_U_PARAM_C, QRY_I_PARAM_A,
           QRY_I_PARAM_B, QRY_I_PARAM_C,
           QRY_FREQ_NET, QRY_KOEF_POW_A,
           QRY_KOEF_POW_B, QRY_KOEF_POW_C            : ReadCurrParReq(pMsg);
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
End;

procedure CEKOM3000Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    wPrecize     : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    m_nCounter := 0;
    m_nCounter1:= 0;
    //FinalAction;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    wPrecize := pDS.m_swData2;
    case param of
      QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
      QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : AddEnergyDayGrpahQry(Date1, Date2);
      QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
      QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : AddEnergyMonthGrpahQry(Date1, Date2);
      QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
      QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM      : AddNakEnergyDayGraphQry(Date1, Date2);
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : AddNakEnergyMonthGraphQry(Date1, Date2);
      QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
      QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : AddSresGrpahQry(Date1, Date2);
    end;
end;

function CEKOM3000Meter.HiHandler(var pMsg:CMessage):Boolean;
var
    res          : Boolean;
    wCRC         : word;
    tempP        : ShortInt;
begin
    res := false;
    //Обработчик для L3
    m_nRxMsg.m_sbyServerID := 0;
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      begin
        Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
        if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
        if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;
        case nReq.m_swParamID of
           QRY_AUTORIZATION                           : CreateAutorReq(nReq);
           QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
           QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM       : CreateEnSumReq(nReq);

           QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
           QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM       : CreateSetDayDateReq(nReq);

           QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
           QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM   : CreateSetMonDateReq(nReq);

           QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
           QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM       : CreateEnDayReq(nReq);
           QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
           QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM       : CreateEnMonReq(nReq);
           QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
           QRY_SRES_ENR_RP, QRY_SRES_ENR_RM           : CreateSresEnReq(nReq);
           QRY_JRNL_T1, QRY_JRNL_T2, QRY_JRNL_T3      : CreateJrnlReq(nReq);
           QRY_DATA_TIME                              : CreateDateTimeReq(nReq);
           QRY_MGAKT_POW_S, QRY_MGREA_POW_S,
           QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
           QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
           QRY_MGREA_POW_B, QRY_MGREA_POW_C,
           QRY_U_PARAM_A, QRY_U_PARAM_B,
           QRY_U_PARAM_C, QRY_I_PARAM_A,
           QRY_I_PARAM_B, QRY_I_PARAM_C,
           QRY_FREQ_NET, QRY_KOEF_POW_A,
           QRY_KOEF_POW_B, QRY_KOEF_POW_C             : CreateCurrParReq(nReq);
           else begin FinalAction; exit; end;                                      
        end;
        TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>EKOM3000 DRQ:',@pMsg);
        FPUT(BOX_L1, @m_nTxMsg);
        m_nRepTimer.OnTimer(m_nP.m_swRepTime);
      end;
      QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
      QL_LOAD_EVENTS_REQ    : AddEventsGraphQry(pMsg);
    end;
    Result := res;
End;
procedure CEKOM3000Meter.OnEnterAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EKOM3000 OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;
procedure CEKOM3000Meter.OnFinalAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EKOM3000 OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;
procedure CEKOM3000Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EKOM3000 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True))then FinalAction;
End;
procedure CEKOM3000Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EKOM3000 OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;
procedure CEKOM3000Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>EKOM3000 OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
    End;
end;

procedure CEKOM3000Meter.RunMeter;
Begin

End;


Function CEKOM3000Meter.CRC(var buf : Array Of byte; count : integer) : word;
Const
  srCRCHi           : Array[0..255] Of byte = (
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40,
    $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
    $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40);
  srCRCLo           : Array[0..255] Of byte = (
    $00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05, $C5, $C4, $04, $CC, $0C, $0D, $CD,
    $0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09, $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA, $1A,
    $1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC, $14, $D4, $D5, $15, $D7, $17, $16, $D6, $D2, $12, $13, $D3,
    $11, $D1, $D0, $10, $F0, $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35, $34, $F4,
    $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B, $FB, $39, $F9, $F8, $38, $28, $E8, $E9, $29,
    $EB, $2B, $2A, $EA, $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27, $E7, $E6, $26,
    $22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $60, $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67,
    $A5, $65, $64, $A4, $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB, $69, $A9, $A8, $68,
    $78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5,
    $77, $B7, $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91, $51, $93, $53, $52, $92,
    $96, $56, $57, $97, $55, $95, $94, $54, $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B,
    $99, $59, $58, $98, $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C,
    $44, $84, $85, $45, $87, $47, $46, $86, $82, $42, $43, $83, $41, $81, $80, $40);

  InitCRC           : word = $FFFF;
Function UpdCRC(C : byte; oldCRC : word) : word;
Var
  i               : byte;
  arrCRC          : Array[0..1] Of byte absolute oldCRC;
begin
   i := arrCRC[1] Xor C;
   arrCRC[1] := arrCRC[0] Xor srCRCHi[i];
   arrCRC[0] := srCRCLo[i];
   UpdCRC := oldCRC;
End;
Var
  I                 : integer;
  uCRC              : word;
Begin
  uCrc := InitCRC;
  if count>2900 then Begin result := uCRC;exit;End;
  For I := 0 To Count - 1 Do uCrc := UpdCRC(Buf[I], uCrc);
  result := uCRC;
End;

function CEKOM3000Meter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CEKOM3000Meter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
var i       : integer;
    ts      : string;
begin
   ts      := '';
   nCount  := 0;
   for i := 1 to Length(str) do
     if str[i] <> ' ' then
     begin
       if ts = '' then ts := '$';
       ts := ts + str[i];
     end
     else
     begin
       if ts <> '' then
       begin
         buf[nCount] := StrToInt(ts);
         Inc(nCount);
         ts := '';
       end;
       continue;
     end;
   if str <> '' then
   begin
     buf[nCount] := StrToInt(ts);
     Inc(nCount);
   end;
end;

end.
