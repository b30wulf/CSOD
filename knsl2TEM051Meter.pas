unit knsl2TEM051Meter;
{$DEFINE TEM051_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate, utldatabase;
type
    PRTempCurrBuff = packed record
      IsCurrRead : boolean;
      DateAnswer : TDateTime;
      buf        : array [0..343] of byte;
    end;
    CTEM051Meter = class(CMeter)
    Private
     m_nCounter   : Integer;
     m_nCounter1  : Integer;
     //IsUpdate     : boolean;
     nReq         : CQueryPrimitive;
     OldCounter   : boolean;
     TempCurrBuff : PRTempCurrBuff;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    GetPointPosForPodTryb : byte;
     function    GetPointPosForObrTryb : byte;
     function    GetByteFromBCD(BCDByte : byte) : byte;
     procedure   ReadNakWorkTime;
     procedure   ReadPodTrybRasx;
     procedure   ReadPodTrbPower;
     procedure   ReadPodTrybNakHeat;
     procedure   ReadPodTrybNakV;
     procedure   ReadPodTrybNakRasx;
     procedure   ReadPodTrybTemp;
     procedure   ReadObrTrybRasx;
     procedure   ReadObrTrybPower;
     procedure   ReadObrTrybNakHeat;
     procedure   ReadObrTrybNakV;
     procedure   ReadObrTrybNakRasx;
     procedure   ReadObrTrybTemp;
     procedure   ReadColdWater;
     procedure   CreateNullRequest;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure   TestMSG(var pMsg:CMessage);
     procedure   ProcCaseAndRead;
     procedure   GetCurrInfo(var pMsg:CMessage);
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     function    GetCommand(byCommand:Byte):Integer;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
    End;
const SIGNATURE : array [0..7] of byte   = ($CA, $E0, $EB, $FE, $EC, $ED, $FB, $20);
const
     fncColZnFromDiamRasx :  //Зависимость количества знаков после запятой от диаметра трубы для расход
                  array [0..23] of double = (0.00001, 0.00001, 0.0001,
                                             0.0001, 0.0001, 0.0001,
                                             0.0001, 0.0001, 0.001,
                                             0.001, 0.001, 0.001,
                                             0.001, 0.001, 0.01,
                                             0.01, 0.01, 0.01,
                                             0.01, 0.01, 0.01,
                                             0.0001, 0.001, 0.001);
     fncColZnFromDiamPower : //Зависимость количества знаков после запятой от диаметра трубы для мощности
                  array [0..23] of double = (0.001, 0.001, 0.01,
                                             0.01, 0.01, 0.01,
                                             0.01, 0.01, 0.1,
                                             0.1, 0.1, 0.1,
                                             0.1, 0.1, 1,
                                             0.1, 1, 1,
                                             1, 1, 1,
                                             0.01, 0.1, 0.1);
     fncColZnFromDiamHeat : // Зависимость количества знаков после запятой от диаметра трубы для энегии
                  array [0..23] of double = (0.0001, 0.0001, 0.001,
                                             0.001, 0.001, 0.001,
                                             0.001, 0.001, 0.01,
                                             0.01, 0.01, 0.01,
                                             0.01, 0.01, 0.1,
                                             0.01, 0.1, 0.1,
                                             0.1, 0.1, 0.1,
                                             0.001, 0.01, 0.01);
     fncColZnFromDiamV :    //Зависимость количества знаков после запятой от диаметра трубы для объема
                  array [0..23] of double = (0.001, 0.001, 0.01,
                                             0.01, 0.01, 0.01,
                                             0.01, 0.01, 0.1,
                                             0.1, 0.1, 0.1,
                                             0.1, 0.1, 1,
                                             0.1, 1, 1,
                                             1, 1, 1,
                                             0.01, 0.1, 0.1);

     fncColZnFromDiamMass : //Зависимость количества знаков после запятой от диаметра трубы для массы
                  array [0..23] of double = (0.001, 0.001, 0.01,
                                             0.01, 0.01, 0.01,
                                             0.01, 0.01, 0.1,
                                             0.1, 0.1, 0.1,
                                             0.1, 0.1, 1,
                                             0.1, 1, 1,
                                             1, 1, 1,
                                             0.01, 0.1, 0.1);



implementation

constructor CTEM051Meter.Create;
Begin

End;

procedure CTEM051Meter.InitMeter(var pL2:SL2TAG);
Begin
   m_nCounter := 0;
   m_nCounter1:= 0;
   IsUpdate   := 0;
   SetHandScenario;
   SetHandScenarioGraph;
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>TEM051  Meter Created:'+
                         ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
                         ' Rep:'+IntToStr(m_byRep)+
                         ' Group:'+IntToStr(m_nP.m_sbyGroupID));
   TempCurrBuff.IsCurrRead := false;
End;
procedure CTEM051Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
   pMsg.m_swLen       := Size;             //pMsg.m_sbyInfo[] :=
   pMsg.m_swObjID     := m_nP.m_swMID;     //Сетевой адрес счётчика
   pMsg.m_sbyFrom     := DIR_L2TOL1;
   pMsg.m_sbyFor      := DIR_L2TOL1;       //DIR_L2toL1
   pMsg.m_sbyType     := PH_DATARD_REQ;    //PH_DATARD_REC
   pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID := MET_TEM501;         //Указать тип счетчика
   pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CTEM051Meter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
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

procedure CTEM051Meter.SetCurrQry;
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

procedure CTEM051Meter.SetGraphQry;
begin

end;

procedure CTEM051Meter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
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

function  CTEM051Meter.GetPointPosForPodTryb : byte;
begin
   Result := TempCurrBuff.buf[$012];
   if (Result > 10) then
     Result := 0;
end;

function  CTEM051Meter.GetPointPosForObrTryb : byte;
begin
   Result := TempCurrBuff.buf[$013];
   if (Result > 10) then
     Result := 0;
end;

function CTEM051Meter.GetByteFromBCD(BCDByte : byte) : byte;
begin
   Result := (BCDByte and $0F) + ((BCDByte and $F0) shr 4)*10;
end;

//Чтение время работы прибора
procedure CTEM051Meter.ReadNakWorkTime;
var TotalHour : double;
begin
   TotalHour := TempCurrBuff.buf[$018]/60 + TempCurrBuff.buf[$019] + TempCurrBuff.buf[$01A]*$100;
   //CreateOutMSG(TotalHour, QRY_NAK_WORK_TIME, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

//Чтение расхода в подающей трубе (м3/ч)
procedure CTEM051Meter.ReadPodTrybRasx;
var RasxNowInt : integer;
    RasxNowPnt : double;
    PointPos   : byte;
begin
   RasxNowInt := 0;
   move(TempCurrBuff.buf[$020], RasxNowInt, 3);
   PointPos  := GetPointPosForPodTryb;
   RasxNowPnt := RasxNowInt * fncColZnFromDiamRasx[PointPos];
   CreateOutMSG(RasxNowPnt, QRY_POD_TRYB_RASX, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

//Чтение мощности в подоющей трубе
//TODO проверить правильность перевода в Гкал
procedure CTEM051Meter.ReadPodTrbPower;
var PowerNowInt : integer;
    PowerNowPnt : double;
    PointPos    : byte;
begin
   PowerNowInt := 0;
   move(TempCurrBuff.buf[$023], PowerNowInt, 3);
   PointPos := GetPointPosForPodTryb;
   PowerNowPnt := PowerNowInt * fncColZnFromDiamPower[PointPos] * 1.163 / 1000;
   //CreateOutMSG(PowerNowPnt, QRY_POD_TRYB_POWER, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

//Чтение потребленного тепла с нарастающим итогом
//TODO проверить правильность перехода в Гкал
procedure CTEM051Meter.ReadPodTrybNakHeat;
var NakHeatInt : integer;
    NakHeatPnt : double;
    PointPos   : byte;
begin
   NakHeatInt := 0;
   move(TempCurrBuff.buf[$026], NakHeatInt, 3);
   PointPos := GetPointPosForPodTryb;
   NakHeatPnt := NakHeatInt * fncColZnFromDiamHeat[PointPos] * 1.16;
   //CreateOutMSG(NakHeatPnt, QRY_POD_TRYB_NAK_HEAT, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

//Чтение накопленного объема в подающей трубе
procedure CTEM051Meter.ReadPodTrybNakV;
var NakVInt  : integer;
    NakVPnt  : double;
    PointPos : byte;
begin
   NakVInt := 0;
   move(TempCurrBuff.buf[$029], NakVInt, 3);
   PointPos := GetPointPosForPodTryb;
   NakVPnt := NakVInt * fncColZnFromDiamV[PointPos];
   //CreateOutMSG(NakVPnt, QRY_POD_TRYB_NAK_V, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadPodTrybNakRasx;
var NakRasxInt  : integer;
    NakRasxPnt  : double;
    PointPos    : byte;
begin
   NakRasxInt := 0;
   move(TempCurrBuff.buf[$02C], NakRasxInt, 3);
   PointPos := GetPointPosForPodTryb;
   NakRasxPnt := NakRasxInt * fncColZnFromDiamMass[PointPos];
   //CreateOutMSG(NakRasxPnt, QRY_POD_TRYB_NAK_RASX, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadPodTrybTemp;
var TempNow    : double;
begin
   TempNow := TempCurrBuff.buf[$0CE] / 100 + TempCurrBuff.buf[$0CF];
   CreateOutMSG(TempNow, QRY_POD_TRYB_TEMP, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadObrTrybRasx;
var RasxNowInt : integer;
    RasxNowPnt : double;
    PointPos   : byte;
begin
   RasxNowInt := 0;
   move(TempCurrBuff.buf[$02F], RasxNowInt, 3);
   PointPos  := GetPointPosForObrTryb;
   RasxNowPnt := RasxNowInt * fncColZnFromDiamRasx[PointPos];
   CreateOutMSG(RasxNowPnt, QRY_OBR_TRYB_RASX, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadObrTrybPower;
var PowerNowInt : integer;
    PowerNowPnt : double;
    PointPos    : byte;
begin
   PowerNowInt := 0;
   move(TempCurrBuff.buf[$032], PowerNowInt, 3);
   PointPos := GetPointPosForObrTryb;
   PowerNowPnt := PowerNowInt * fncColZnFromDiamPower[PointPos] * 1.163 / 1000;
   //CreateOutMSG(PowerNowPnt, QRY_OBR_TRYB_POWER, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadObrTrybNakHeat;
var NakHeatInt : integer;
    NakHeatPnt : double;
    PointPos   : byte;
begin
   NakHeatInt := 0;
   move(TempCurrBuff.buf[$035], NakHeatInt, 3);
   PointPos := GetPointPosForObrTryb;
   NakHeatPnt := NakHeatInt * fncColZnFromDiamHeat[PointPos] * 1.16;
   //CreateOutMSG(NakHeatPnt, QRY_OBR_TRYB_NAK_HEAT, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;


procedure CTEM051Meter.ReadObrTrybNakV;
var NakVInt  : integer;
    NakVPnt  : double;
    PointPos : byte;
begin
   NakVInt := 0;
   move(TempCurrBuff.buf[$038], NakVInt, 3);
   PointPos := GetPointPosForObrTryb;
   NakVPnt := NakVInt * fncColZnFromDiamV[PointPos];
   //CreateOutMSG(NakVPnt, QRY_OBR_TRYB_NAK_V, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadObrTrybNakRasx;
var NakRasxInt  : integer;
    NakRasxPnt  : double;
    PointPos    : byte;
begin
   NakRasxInt := 0;
   move(TempCurrBuff.buf[$03B], NakRasxInt, 3);
   PointPos := GetPointPosForObrTryb;
   NakRasxPnt := NakRasxInt * fncColZnFromDiamMass[PointPos];
   //CreateOutMSG(NakRasxPnt, QRY_OBR_TRYB_NAK_RASX, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadObrTrybTemp;
var TempNow    : double;
begin
   TempNow := TempCurrBuff.buf[$0D0] / 100 + TempCurrBuff.buf[$0D1];
   CreateOutMSG(TempNow, QRY_OBR_TRYB_TEMP, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.ReadColdWater;
var TempNow    : double;
begin
   TempNow := TempCurrBuff.buf[$0D2] / 100 + TempCurrBuff.buf[$0D3];
   //CreateOutMSG(TempNow, QRY_TEMP_COLD_WATER, 0, TempCurrBuff.DateAnswer);
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CTEM051Meter.CreateNullRequest;
begin
   TempCurrBuff.IsCurrRead := false;
   m_nTxMsg.m_swLen := 11;
   MsgHead(m_nTxMsg, 11);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

function  CTEM051Meter.SelfHandler(var pMsg:CMessage):Boolean;
var
   res : Boolean;
begin
   res    := false;

   result := res;
end;

procedure CTEM051Meter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
begin
   strNum := 0;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestTEM501.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   pMsg.m_swLen := cnt + 11;
end;

procedure CTEM051Meter.ProcCaseAndRead;
begin
   {case nReq.m_swParamID of
     QRY_NAK_WORK_TIME     : if TempCurrBuff.IsCurrRead then ReadNakWorkTime;
     QRY_POD_TRYB_RASX     : if TempCurrBuff.IsCurrRead then ReadPodTrybRasx;
     QRY_POD_TRYB_POWER    : if TempCurrBuff.IsCurrRead then ReadPodTrbPower;
     QRY_POD_TRYB_NAK_HEAT : if TempCurrBuff.IsCurrRead then ReadPodTrybNakHeat;
     QRY_POD_TRYB_NAK_V    : if TempCurrBuff.IsCurrRead then ReadPodTrybNakV;
     QRY_POD_TRYB_NAK_RASX : if TempCurrBuff.IsCurrRead then ReadPodTrybNakRasx;
     QRY_POD_TRYB_TEMP     : if TempCurrBuff.IsCurrRead then ReadPodTrybTemp;
     QRY_OBR_TRYB_RASX     : if TempCurrBuff.IsCurrRead then ReadObrTrybRasx;
     QRY_OBR_TRYB_POWER    : if TempCurrBuff.IsCurrRead then ReadObrTrybPower;
     QRY_OBR_TRYB_NAK_HEAT : if TempCurrBuff.IsCurrRead then ReadObrTrybNakHeat;
     QRY_OBR_TRYB_NAK_V    : if TempCurrBuff.IsCurrRead then ReadObrTrybNakV;
     QRY_OBR_TRYB_NAK_RASX : if TempCurrBuff.IsCurrRead then ReadObrTrybNakRasx;
     QRY_OBR_TRYB_TEMP     : if TempCurrBuff.IsCurrRead then ReadObrTrybTemp;
     QRY_TEMP_COLD_WATER   : if TempCurrBuff.IsCurrRead then ReadColdWater;
     else begin FinalAction; exit; end;
   end;                         }
end;

procedure CTEM051Meter.GetCurrInfo(var pMsg:CMessage);
var Year, Month, Day,
    Hour, Min, Sec : word;
begin
   TempCurrBuff.IsCurrRead := true;
   move(pMsg.m_sbyInfo[0], TempCurrBuff.buf[0], 344);
   Year  := 2000 + GetByteFromBCD(TempCurrBuff.buf[$009]);
   Month := GetByteFromBCD(TempCurrBuff.buf[$008]);
   Day   := GetByteFromBCD(TempCurrBuff.buf[$007]);
   Hour  := GetByteFromBCD(TempCurrBuff.buf[$004]);
   Min   := GetByteFromBCD(TempCurrBuff.buf[$002]);
   Sec   := GetByteFromBCD(TempCurrBuff.buf[$000]);
   //TempCurrBuff.DateAnswer := EncodeDate(Year, Month, Day) +
   //             EncodeTime(Hour, Min, Sec, 0);
   TempCurrBuff.DateAnswer := Now;

end;

function CTEM051Meter.LoHandler(var pMsg:CMessage):Boolean;
var
    res        : Boolean;
    crc        : word;
    IsCurrReq  : boolean;
begin
    res       := False;
    IsCurrReq := false;
    //Обработчик для L1
     case pMsg.m_sbyType of
      PH_DATA_IND:
      begin
        {$IFDEF TEM051_DEBUG}
        TestMSG(pMsg);
        {$ENDIF}
        if (pMsg.m_swLen - 11 = 344) and (m_nRepTimer.IsProceed) then
          GetCurrInfo(pMsg)
        else
        begin
          TempCurrBuff.IsCurrRead := false;
          exit;
        end;
        ProcCaseAndRead;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    end;
    Result := res;
end;

procedure CTEM051Meter.HandQryRoutine(var pMsg:CMessage);
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
    {case param of

    end;      }
end;

function CTEM051Meter.HiHandler(var pMsg:CMessage):Boolean;
var
   res          : Boolean;
   tempP        : ShortInt;
   FNCNum       : Integer;
   crc          : word;
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
       {case nReq.m_swParamID of
         QRY_NAK_WORK_TIME, QRY_POD_TRYB_RASX,
         QRY_POD_TRYB_POWER, QRY_POD_TRYB_NAK_HEAT,
         QRY_POD_TRYB_NAK_V, QRY_POD_TRYB_NAK_RASX,
         QRY_POD_TRYB_TEMP, QRY_OBR_TRYB_RASX,
         QRY_OBR_TRYB_POWER, QRY_OBR_TRYB_NAK_HEAT,
         QRY_OBR_TRYB_NAK_V, QRY_OBR_TRYB_NAK_RASX,
         QRY_OBR_TRYB_TEMP, QRY_TEMP_COLD_WATER :
           if TempCurrBuff.IsCurrRead then
             ProcCaseAndRead
           else
             CreateNullRequest;
         else
           FinalAction;
       end;  }
     end;
     QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
     QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
   end;
   Result := res;
end;

procedure CTEM051Meter.OnEnterAction;
begin
   TempCurrBuff.IsCurrRead := false;
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>TEM051 OnEnterAction');
   if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
   OpenPhone else
   if (m_nP.m_sbyModem=0) then FinalAction;
   //FinalAction;
end;

procedure CTEM051Meter.OnFinalAction;
begin
   TempCurrBuff.IsCurrRead := false;
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>TEM051 OnFinalAction');
   //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
   //if m_nP.m_sbyModem=0 then FinalAction;
   //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
   FinalAction;
end;

procedure CTEM051Meter.OnConnectComplette(var pMsg:CMessage);
begin
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>TEM051 OnConnectComplette');
   m_nModemState := 1;
   FinalAction;
end;

procedure CTEM051Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>TEM051 OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CTEM051Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>TEM051 OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
   end;
end;

procedure CTEM051Meter.RunMeter;
Begin

End;

function CTEM051Meter.GetCommand(byCommand:Byte):Integer;
var
    res : Integer;
begin
    res := -1;
    Result := res;
end;

function CTEM051Meter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CTEM051Meter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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
