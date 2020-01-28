unit knsl2SEM2Meter;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate, utldatabase;
type
    CSEM2Meter = class(CMeter)
    Private
     m_nCounter   : Integer;
     m_nCounter1  : Integer;
     //IsUpdate     : boolean;
     nReq         : CQueryPrimitive;
     Ke           : double;
     State        : integer;              
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     procedure   ReadSumEnAns(var pMsg:CMessage);
     procedure   ReadEnDayAns(var pMsg:CMessage);
     procedure   ReadEnMonthAns(var pMsg:CMessage);
     procedure   ReadSresEnAns(var pMsg:CMessage);
     procedure   ReadNakEnMonthAns(var pMsg:CMessage);
     procedure   ReadDateTimeAns(var pMsg:CMessage);
     procedure   ReadMaxPowerAns(var pMsg:CMessage);
     procedure   CreateReq(fnc, Length : integer);
     procedure   CreateSumEnReq;
     procedure   CreateEnDayReq;
     procedure   CreateEnMonthReq;
     procedure   CreateSresEnReq;
     procedure   CreateNakEnMonthReq;
     procedure   CreateDateTimeReq;
     procedure   CreateMaxPowerReq;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     procedure   EncodeFormatSEMFloat(const buf1 : PBYTEARRAY; buf2 : PBYTEARRAY);
     function    GetChanInfo(PID : integer): integer;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     procedure   AddEnergyDayGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     procedure   AddEnergySresGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     procedure   AddNakEnergyMonthGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     procedure   AddEnergyMonthGrpahQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     function    CRC(var buf: array of byte; count: integer): boolean;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
    End;
const SIGNATURE : array [0..7] of byte = ($CA, $E0, $EB, $FE, $EC, $ED, $FB, $20);
implementation

constructor CSEM2Meter.Create;
Begin

End;

procedure CSEM2Meter.AddEnergyDayGraphQry(PID: integer;  dt_Date1, dt_Date2: TDateTime);
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
       if i < -13 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

procedure CSEM2Meter.AddEnergySresGraphQry(PID: integer;  dt_Date1, dt_Date2: TDateTime);
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
       if i < -60 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

procedure CSEM2Meter.AddNakEnergyMonthGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
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
       if i < -6 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CSEM2Meter.AddEnergyMonthGrpahQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
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
       if i < -6 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CSEM2Meter.InitMeter(var pL2:SL2TAG);
Begin
    m_nCounter := 0;
    m_nCounter1:= 0;
    IsUpdate   := 0;
    SetHandScenario;
    SetHandScenarioGraph;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SEM2  Meter Created:'+
                          ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
                          ' Rep:'+IntToStr(m_byRep)+
                          ' Group:'+IntToStr(m_nP.m_sbyGroupID));
    State := ST_SM2_NULL_ST;
End;
procedure CSEM2Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;             //pMsg.m_sbyInfo[] :=
    pMsg.m_swObjID     := m_nP.m_swMID;     //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;       //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ;    //PH_DATARD_REC
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_SEM2;         //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CSEM2Meter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
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

procedure CSEM2Meter.SetCurrQry;
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

procedure CSEM2Meter.SetGraphQry;
begin

end;

procedure CSEM2Meter.EncodeFormatSEMFloat(const buf1 : PBYTEARRAY; buf2 : PBYTEARRAY);
begin
   buf2[3] := buf1[0];
   buf2[2] := buf1[1];
   buf2[1] := buf1[2];
   buf2[0] := buf1[3];
end;

function  CSEM2Meter.GetChanInfo(PID : integer): integer;
var i : integer;
begin
   Result := 0;
   with m_nObserver.pm_sInil2CmdTbl.LockList do
   try
   for i := 0 to count - 1 do
     if CComm(Items[i]).m_swCmdID = PID then
     begin
       Result := StrToInt(CComm(Items[i]).m_swChannel);
       exit;
     end;
   finally
    m_nObserver.pm_sInil2CmdTbl.UnLockList;
   end;
end;

procedure CSEM2Meter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin                         //sm - вид энергии; tar - тарифф
   DecodeDate(Date, Year, Month, Day);
   DecodeTime(Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);
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
   m_nRxMsg.m_sbyDirID   := Byte(IsUpdate);
end;

procedure CSEM2Meter.ReadSumEnAns(var pMsg:CMessage);
var par : single;
begin
   if pMsg.m_swLen <> 11 + 21 then
     exit;
   m_nRxMsg.m_sbyServerID := 0;
   EncodeFormatSEMFloat(@(pMsg.m_sbyInfo[15]), @par);     //!!!!!!
   CreateOutMsg(par, nReq.m_swParamID, 1, Now);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CSEM2Meter.ReadEnDayAns(var pMsg:CMessage);
var par   : single;
    tar   : integer;
    tDate : TDateTime;
begin
   tDate := trunc(Now) - nReq.m_swSpecc0;
   if pMsg.m_swLen <> 11 + 33 then
     exit;
   m_nRxMsg.m_sbyServerID := 0;
   for tar := 1 to 3 do
   begin
     EncodeFormatSEMFloat(@(pMsg.m_sbyInfo[15 + (tar-1)*4]), @par);
     CreateOutMsg(par, nReq.m_swParamID, tar, tDate);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   FinalAction;
end;

procedure CSEM2Meter.ReadEnMonthAns(var pMsg:CMessage);
var par   : single;
    tar   : integer;
    tDate : TDateTime;
begin
   tDate := cDateTimeR.NowFirstDayMonth;
   cDateTimeR.IncMonth(tDate);
   for tar := 0 to nReq.m_swSpecc0 - 1 do
     cDateTimeR.DecMonth(tDate);
   if pMsg.m_swLen <> 11 + 33 then
     exit;
   m_nRxMsg.m_sbyServerID := 0;
   for tar := 1 to 3 do
   begin
     EncodeFormatSEMFloat(@(pMsg.m_sbyInfo[15 + (tar-1)*4]), @par);
     CreateOutMsg(par, nReq.m_swParamID, tar, tDate);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   FinalAction;
end;

procedure CSEM2Meter.ReadSresEnAns(var pMsg:CMessage);
var par            : single;
    slN, maxSl     : integer;
    tDate          : TDateTime;
begin
   tDate := trunc(Now) - nReq.m_swSpecc0;
   if pMsg.m_swLen <> 11 + 209 then
     exit;
   if tDate = trunc(Now) then
     maxSl := trunc(frac(Now)/EncodeTime(0, 30, 0, 0))
   else
     maxSl := 47;
   for slN := 0 to maxSl do
   begin
     EncodeFormatSEMFloat(@(pMsg.m_sbyInfo[15 + slN*4]), @par);
     m_nRxMsg.m_sbyServerID := slN;
     CreateOutMsg(par/2, nReq.m_swParamID, 0, tDate);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   FinalAction;
end;

procedure CSEM2Meter.ReadNakEnMonthAns(var pMsg:CMessage);
var par   : single;
    tDate : TDateTime;
    i     : integer;
begin
   tDate := cDateTimeR.NowFirstDayMonth;
   for i := 0 to nReq.m_swSpecc0 - 1 do
     cDateTimeR.DecMonth(tDate);
   if pMsg.m_swLen <> 11 + 21 then
     exit;
   m_nRxMsg.m_sbyServerID := 0;
   EncodeFormatSEMFloat(@(pMsg.m_sbyInfo[15]), @par);     //!!!!!!
   CreateOutMsg(par, nReq.m_swParamID, 1, tDate);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CSEM2Meter.ReadDateTimeAns(var pMsg:CMessage);
begin
   FinalAction;
end;

procedure CSEM2Meter.ReadMaxPowerAns(var pMsg:CMessage);
begin
   FinalAction;
end;

procedure CSEM2Meter.CreateReq(fnc, Length : integer);
begin
   move(SIGNATURE[0], m_nTxMsg.m_sbyInfo[0], 8);
   m_nTxMsg.m_sbyInfo[8]  := $00;
   m_nTxMsg.m_sbyInfo[9]  := $00;               //Логический адрес
   m_nTxMsg.m_sbyInfo[10] := Length mod $100;
   m_nTxMsg.m_sbyInfo[11] := Length div $100;   //Номер функции
   m_nTxMsg.m_sbyInfo[12] := lo(fnc);
   CRC(m_nTxMsg.m_sbyInfo[8], Length - 2);
   MsgHead(m_nTxMsg, 11 + 8 + Length);
end;

procedure CSEM2Meter.CreateSumEnReq;
begin
   m_nTxMsg.m_sbyInfo[13] := GetChanInfo(nReq.m_swParamID);
   CreateReq(108, 8);
end;

procedure CSEM2Meter.CreateEnDayReq;
begin
   m_nTxMsg.m_sbyInfo[13] := GetChanInfo(nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0;
   CreateReq(117, 9);
end;

procedure CSEM2Meter.CreateEnMonthReq;
begin
   m_nTxMsg.m_sbyInfo[13] := GetChanInfo(nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0;
   CreateReq(120, 9);
end;

procedure CSEM2Meter.CreateSresEnReq;
var KanalNumb : integer;
begin
   m_nTxMsg.m_sbyInfo[13] := GetChanInfo(nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0;
   CreateReq(157, 9);
end;

procedure CSEM2Meter.CreateNakEnMonthReq;
begin
   m_nTxMsg.m_sbyInfo[13] := GetChanInfo(nReq.m_swParamID);
   m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0;
   CreateReq(140, 9);
end;

procedure CSEM2Meter.CreateDateTimeReq;
begin
   CreateReq(1, 7);
end;

procedure CSEM2Meter.CreateMaxPowerReq;
begin
   //НЕНАДА !!!
end;

function  CSEM2Meter.SelfHandler(var pMsg:CMessage):Boolean;
var
   res : Boolean;
begin
   res    := false;
   result := res;
end;

function CSEM2Meter.LoHandler(var pMsg:CMessage):Boolean;
var
    res    : Boolean;
    fValue : Single;
begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      begin
        if not CRC(pMsg.m_sbyInfo[0], pMsg.m_swLen - 2 - 11) then
        begin
          TraceM(2,pMsg.m_swObjID,'(__)CL4MD::>SEM CRC ERROR!!!:',@pMsg);
          exit;
        end;
        case nReq.m_swParamID of
          QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
          QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : ReadSumEnAns(pMsg);
          QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
          QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : ReadEnDayAns(pMsg);
          QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
          QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM     : ReadEnMonthAns(pMsg);
          QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
          QRY_SRES_ENR_RP, QRY_SRES_ENR_RM,
          QRY_SRES_ENR_DAY_EP, QRY_SRES_ENR_DAY_EM,
          QRY_SRES_ENR_DAY_RP, QRY_SRES_ENR_DAY_RM : ReadSresEnAns(pMsg);
          QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
          QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : ReadNakEnMonthAns(pMsg);
          QRY_DATA_TIME                            : ReadDateTimeAns(pMsg);
          QRY_MAX_POWER_EP, QRY_MAX_POWER_EM,
          QRY_MAX_POWER_RP, QRY_MAX_POWER_RM       : ReadMaxPowerAns(pMsg);
          else begin FinalAction; exit; end;
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    end;
    Result := res;
end;

procedure CSEM2Meter.HandQryRoutine(var pMsg:CMessage);
var
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
      QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : AddEnergyDayGraphQry(param, Date1, Date2);
      QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
      QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : AddEnergyMonthGrpahQry(param, Date1, Date2);
      QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
      QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : AddEnergySresGraphQry(param, Date1, Date2);
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : AddNakEnergyMonthGraphQry(param, Date1, Date2);
    end;
end;

function CSEM2Meter.HiHandler(var pMsg:CMessage):Boolean;
var
   res          : Boolean;
   tempP        : ShortInt;
begin
   res := false;
   //Обработчик для L3
   m_nRxMsg.m_sbyServerID := 0;
   case pMsg.m_sbyType of
     QL_DATARD_REQ:
     Begin
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
       if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;

       case nReq.m_swParamID of
         QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
         QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : CreateSumEnReq;
         QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
         QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : CreateEnDayReq;
         QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
         QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM     : CreateEnMonthReq;
         QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
         QRY_SRES_ENR_RP, QRY_SRES_ENR_RM,
         QRY_SRES_ENR_DAY_EP, QRY_SRES_ENR_DAY_EM,
         QRY_SRES_ENR_DAY_RP, QRY_SRES_ENR_DAY_RM : CreateSresEnReq;
         QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
         QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : CreateNakEnMonthReq;
         QRY_DATA_TIME                            : CreateDateTimeReq;
         QRY_MAX_POWER_EP, QRY_MAX_POWER_EM,
         QRY_MAX_POWER_RP, QRY_MAX_POWER_RM       : CreateMaxPowerReq;
         else begin FinalAction; exit; end;
       end;
       TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>SEM2 DRQ:',@pMsg);
       FPUT(BOX_L1, @m_nTxMsg);
       m_nRepTimer.OnTimer(m_nP.m_swRepTime);
     end;
     QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
     QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
   end;
   Result := res;
end;

procedure CSEM2Meter.OnEnterAction;
begin
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SEM2 OnEnterAction');
   if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
   OpenPhone else
   if (m_nP.m_sbyModem=0) then FinalAction;
   State := ST_SM2_NULL_ST;
   //FinalAction;
end;

procedure CSEM2Meter.OnFinalAction;
begin
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SEM2 OnFinalAction');
   //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
   //if m_nP.m_sbyModem=0 then FinalAction;
   //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
   FinalAction;
   State := ST_SM2_NULL_ST;
end;

procedure CSEM2Meter.OnConnectComplette(var pMsg:CMessage);
begin
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SEM2 OnConnectComplette');
   m_nModemState := 1;
   FinalAction;
end;

procedure CSEM2Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>SEM2 OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CSEM2Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>SEM2 OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
   end;
end;

procedure CSEM2Meter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

function CSEM2Meter.CRC(var buf: array of byte; count: integer): boolean;
var ind          : byte;
    CRCHi, CRCLo : byte;
    i            : integer;
begin
   CRCHi   := $FF;
   CRCLo   := $FF;
   Result  := true;
   for i := 0 to count - 1 do
   begin
     ind  := CRCHi xor buf[i];
     CRCHi:= CRCLo xor srCRCHi[ind];
     CRCLo:= srCRCLo[ind];
   end;
   if (buf[count] <> CRCHi) or (buf[count+1] <> CRCLo) then
     Result := false;
   buf[count]   := CRCHi;
   buf[count+1] := CRCLo;
end;

function CSEM2Meter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CSEM2Meter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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
