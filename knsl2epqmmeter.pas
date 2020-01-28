unit knsl2EPQMMeter;
//{$DEFINE EPQM_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate, utldatabase;
type
    CEPQMMeter = class(CMeter)
    Private
     PrirMonthNow : array[0..3,1..4,0..3] of double;
     NakEnNow     : array[0..3,1..4] of double;
     m_nCounter   : Integer;
     m_nCounter1  : Integer;
     //IsUpdate     : boolean;
     nReq         : CQueryPrimitive;
     KUI, ES      : double;
     smToRead     : integer;
     OldCounter   : boolean;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     procedure   ReadSumEnergyAns(var pMsg: CMessage);
     procedure   ReadEnergyDayAns(var pMsg: CMessage);
     procedure   ReadNakEnMonthAns(var pMsg: CMessage);
     procedure   SaveBeginMonthPok;
     procedure   ReadPrirEnMonthAns(var pMsg: CMessage);
     procedure   ReadSresEnrDayAns(var pMsg: CMessage);
     procedure   ReadCurrParamsAns(var pMsg: CMessage);
     procedure   ReadSysInfoAns(var pMsg: CMessage);
     procedure    CreateCorrTimeReq(Time : TDateTime);
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    StrToHex(str : string):int64;
     procedure   MoveAdrToBuf(Adr: int64; var buf: array of byte);
     function    BcDToDate(mas:array of byte):TDateTime;
     function    BcDToTime(mas:array of byte):TDateTime;
     function    HexToReal(var buf: array of byte; num: byte; count: byte): double;
     function    BCDToDouble(var buf:array of byte; num:byte; Count:byte; koeff:real): Double;
     function    GetPIDFromPos(i : integer): integer;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure   TestMSG(var pMsg:CMessage);
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     procedure   AddEnergyDayGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     procedure   AddEnergySresGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     procedure   AddNakEnergyMonthGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
     procedure   AddPrirEnergyMonthGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
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
     function    GetCommand(byCommand:Byte):Integer;
     procedure   CRC16b(b: Byte; var CRC: word);
     function    CRC16(var buf: array of byte; count: integer): word;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
    End;
const SIGNATURE : array [0..7] of byte   = ($CA, $E0, $EB, $FE, $EC, $ED, $FB, $20);

implementation

constructor CEPQMMeter.Create;
Begin

End;

procedure CEPQMMeter.AddEnergyDayGraphQry(PID: integer;  dt_Date1, dt_Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;
procedure CEPQMMeter.AddEnergySresGraphQry(PID: integer;  dt_Date1, dt_Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
       if i < -62 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

{
procedure CEPQMMeter.AddEnergySresGraphQry(PID: integer;  dt_Date1, dt_Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   for i := trunc(dt_Date1) to trunc(dt_Date2) do
   begin
     m_nObserver.AddGraphParam(QRY_SRES_ENR_DAY_EP, abs(trunc(Now) - i), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_DAY_EM, abs(trunc(Now) - i), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_DAY_RP, abs(trunc(Now) - i), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_DAY_RM, abs(trunc(Now) - i), 0, 0, 1);
   end;
end;
}
procedure CEPQMMeter.AddNakEnergyMonthGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   //m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
//     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CEPQMMeter.AddPrirEnergyMonthGraphQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   //m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CEPQMMeter.AddEnergyMonthGrpahQry(PID: integer; dt_Date1, dt_Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CEPQMMeter.InitMeter(var pL2:SL2TAG);
Begin
   m_nCounter := 0;
   m_nCounter1:= 0;
   IsUpdate   := 0;
   KUI        := 1;
   ES         := 0;
   SetHandScenario;
   SetHandScenarioGraph;
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EPQM  Meter Created:'+
                         ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
                         ' Rep:'+IntToStr(m_byRep)+
                         ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CEPQMMeter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
   pMsg.m_swLen       := Size;             //pMsg.m_sbyInfo[] :=
   pMsg.m_swObjID     := m_nP.m_swMID;     //Сетевой адрес счётчика
   pMsg.m_sbyFrom     := DIR_L2TOL1;
   pMsg.m_sbyFor      := DIR_L2TOL1;       //DIR_L2toL1
   pMsg.m_sbyType     := PH_DATARD_REQ;    //PH_DATARD_REC
   pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID := MET_EPQM;         //Указать тип счетчика
   pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CEPQMMeter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
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

procedure CEPQMMeter.SetCurrQry;
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

procedure CEPQMMeter.SetGraphQry;
begin

end;

function  CEPQMMeter.StrToHex(str : string):int64;
var i    : byte;
    razr : byte;
begin
   Result := $00;
   i:=1;
   while i<=Length(str) do
   begin
     razr   := StrToInt(str[i]);
     Result := Result * $10 + razr;
     i:=i+1;
   end;
end;

procedure CEPQMMeter.MoveAdrToBuf(Adr: int64; var buf: array of byte);
begin
   move(adr, buf[0], 6);
end;

function CEPQMMeter.BcDToDate(mas:array of byte):TDateTime;
var Day, Month, Year : word;
begin
   Day   := (mas[2] and $1F);
   Month := (mas[2] shr 5) + (mas[3] and $01)*8;
   Year  := (mas[3] shr 1);
   result:=EncodeDate(Year + 2000,Month,Day);
end;

function CEPQMMeter.BcDToTime(mas:array of byte):TDateTime;
var Sec, Min, Hour : word;
begin
   Sec   := (mas[0] and $1F)*2;
   Min   := (mas[0] shr 5) + (mas[1] and $07)*8;
   Hour  := (mas[1] shr 3);
   result:=EncodeTime(Hour,Min,Sec,0);
end;

function CEPQMMeter.HexToReal(var buf: array of byte; num: byte; count: byte): double;
var
   res : double;
begin
   res := 0;
   case count of
   2: begin
     res := (buf[num + 1] and $0F)*$100 + buf[num];
     res := res*exp((buf[num + 1] shr 4)*ln(2));
   end; {2}
   4: begin
     res := (buf[num +2 ] shl 16) or (buf[num + 1] shl 8) or (buf[num]);
     res := res*exp((buf[num + 3] - 150)*ln(2));
   end {4}
   else
     exit;
   end; {Case}
   result:=res;
end;

function CEPQMMeter.BCDToDouble(var buf:array of byte; num:byte; Count:byte; koeff:real): Double;
var res  : double;
    i    : byte; 
begin
   res := 0;
   for i := count - 1 downto 0 do
     res := res*100 + ((buf[num + i] div 16)*10 + (buf[num + i] mod 16));
   Result := res*koeff;
end;

function CEPQMMeter.GetPIDFromPos(i : integer): integer;
begin
   case i of
     0, 1, 2   : Result := QRY_MGAKT_POW_A + i;
     3, 4, 5   : Result := QRY_MGREA_POW_A + (i - 3);
     6, 7, 8   : Result := QRY_U_PARAM_A + (i - 6);
     9, 10, 11 : Result := QRY_I_PARAM_A + (i - 9);
     12        : Result := QRY_FREQ_NET;
     else
       Result := 0;
   end;
end;

procedure CEPQMMeter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
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

procedure CEPQMMeter.ReadSumEnergyAns(var pMsg: CMessage);
var ESum        : double;
    i, j        : integer;
    fTempPar    : double;
begin
   if pMsg.m_sbyInfo[0 + smToRead] <> $6C then
     exit;
   ESum := exp(ln(10)*pMsg.m_sbyInfo[9 + smToRead]);
   for i := 0 to 3 do                 //KindEn
     for j := 0 to 3 do               //Tariff
     begin
       fTempPar := BCDToDouble(pMsg.m_sbyInfo[0 + smToRead], 10 + i*24 + j*6, 6, ESum)/1000*m_nP.m_sfKI*m_nP.m_sfKU;
       NakEnNow[i, j+1] := fTempPar;
       CreateOutMSG(fTempPar, QRY_ENERGY_SUM_EP + i, j + 1, Now);
       m_nRxMsg.m_sbyServerID := 0;
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
   FinalAction;
end;

procedure CEPQMMeter.ReadEnergyDayAns(var pMsg: CMessage);
begin
end;

procedure CEPQMMeter.ReadNakEnMonthAns(var pMsg: CMessage);
var ESum        : double;
    i, j        : integer;
    fTempPar    : double;
    TempDate    : TDateTime;
begin
{   if pMsg.m_sbyInfo[0 + smToRead] <> $4C then
     exit;

   ESum := exp(ln(10)*pMsg.m_sbyInfo[9 + smToRead]);

   TempDate := cDateTimeR.NowFirstDayMonth;
   for i := 0 to abs(nReq.m_swSpecc0) - 1 do
     cDateTimeR.DecMonth(TempDate);

   for i := 0 to 3 do
     for j := 0 to 3 do
     begin
       fTempPar := BCDToDouble(pMsg.m_sbyInfo[0 + smToRead], 10 + i*16 + j*4, 4, ESum)/1000*m_nP.m_sfKI*m_nP.m_sfKU;
       CreateOutMSG(fTempPar, QRY_NAK_EN_MONTH_EP + i, j + 1, TempDate);
       FPUT(BOX_L3_BY, @m_nRxMsg);
       m_nRxMsg.m_sbyServerID := 0;
     end;
   FinalAction;}
end;

procedure CEPQMMeter.SaveBeginMonthPok;
var KindEn, Tar : integer;
    TempDate   : TDateTime;
    fTempPar   : double;
    Sum        : double;
    Month      : integer;
begin
   TempDate := cDateTimeR.NowFirstDayMonth;
   for Month := 0 to 3 do
   begin
     for KindEn := 0 to 3 do
     begin
       Sum := -1;
       for Tar := 1 to 4 do
         if (PrirMonthNow[KindEn,Tar,Month] <> -1) and (NakEnNow[KindEn,Tar] <> -1) then
         begin
           fTempPar := NakEnNow[KindEn,Tar] - PrirMonthNow[KindEn,Tar,Month];
//           CreateOutMSG(fTempPar, QRY_NAK_EN_MONTH_EP + KindEn, Tar, TempDate);
//           m_nRxMsg.m_sbyDirID := 1;
//           FPUT(BOX_L3_BY, @m_nRxMsg);
           if Tar <> 4 then
             Sum := Sum + fTempPar;
           m_pDB.SaveNakEnMonth(m_nP.m_swMID,QRY_NAK_EN_MONTH_EP+KindEn,Tar,TempDate,fTempPar);
       end;
       if Sum <> -1 then
       begin
         Sum := Sum - 1;
         m_pDB.SaveNakEnMonth(m_nP.m_swMID,QRY_NAK_EN_MONTH_EP+KindEn,0,TempDate,Sum);
       end;
     end;
     cDateTimeR.DecMonth(TempDate);
   end;
   FinalAction;
end;

procedure CEPQMMeter.ReadPrirEnMonthAns(var pMsg: CMessage);
var ESum        : double;
    i, j        : integer;
    fTempPar    : double;
    TempDate    : TDateTime;
begin
   if pMsg.m_sbyInfo[0 + smToRead] <> $4C then
     exit;

   ESum := exp(ln(10)*pMsg.m_sbyInfo[9 + smToRead]);
   TempDate := Now;
   cDateTimeR.IncMonth(TempDate);
   TempDate := cDateTimeR.GetBeginMonth(TempDate);
   for i := 0 to abs(nReq.m_swSpecc0) - 1 do
     cDateTimeR.DecMonth(TempDate);

   for i := 0 to 3 do
     for j := 0 to 3 do
     begin
       fTempPar := BCDToDouble(pMsg.m_sbyInfo[0 + smToRead], 10 + i*16 + j*4, 4, ESum)/1000*m_nP.m_sfKI*m_nP.m_sfKU;
       if nReq.m_swSpecc0 = 0 then
         PrirMonthNow[i, j+1,0] := fTempPar;
       if (nReq.m_swSpecc0 > 0) and (nReq.m_swSpecc0 <=3) and (PrirMonthNow[i, j+1,nReq.m_swSpecc0 - 1] <> -1) then
         PrirMonthNow[i, j+1,nReq.m_swSpecc0] :=fTempPar + PrirMonthNow[i, j+1,nReq.m_swSpecc0 - 1];
       CreateOutMSG(fTempPar, QRY_ENERGY_MON_EP + i, j + 1, TempDate);
       m_nRxMsg.m_sbyServerID := 0;
       if nReq.m_swSpecc0 = 1 then
         FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
   FinalAction;
end;
//Real(buf: array of byte; num: byte; count: byte): real;    QRY_ENERGY_MON_EP
procedure CEPQMMeter.ReadSresEnrDayAns(var pMsg: CMessage);
var Mas                : double;
    i, PID             : integer;
    fTempPar           : double;
    Year, Month, Day,
    Hour, Min, Sec, ms : word;
    TempDate           : TDateTime;

begin
   if pMsg.m_sbyInfo[0 + smToRead] <> $6C then
     exit;
   if not OldCounter then
     Mas := pMsg.m_sbyInfo[9 + smToRead]*KUI*exp(ES*ln(10))/10
   else
     Mas := exp(pMsg.m_sbyInfo[9 + smToRead]*ln(10));
   TempDate := trunc(Now) - nReq.m_swSpecc0;
   if (nReq.m_swParamID >= QRY_SRES_ENR_DAY_EP) and (nReq.m_swParamID <= QRY_SRES_ENR_DAY_RM) then
     PID := QRY_SRES_ENR_EP + (nReq.m_swParamID - QRY_SRES_ENR_DAY_EP)
   else
     PID := nReq.m_swParamID;
   for i := 0 to 47 do
   begin
     if not OldCounter then
       fTempPar := pMsg.m_sbyInfo[0 + smToRead + 9 + (i+1)*2]*256 + pMsg.m_sbyInfo[0 + smToRead + 9 + (i+1)*2-1]
     else
       fTempPar := HexToReal(pMsg.m_sbyInfo[0 + smToRead], 10 + i*2, 2);
     fTempPar := fTempPar*Mas*m_nP.m_sfKI*m_nP.m_sfKU/1000;
//     fTempPar := HexToReal(
//     fTempPar := ((pMsg.m_sbyInfo[10 + i*2] + pMsg.m_sbyInfo[11 + i*2]*$100)*Mas*KUI*ES)/100;
     if (nReq.m_swSpecc0 <> 0) then
       m_nRxMsg.m_sbyServerID := i
     else
       if (Frac(Now) > (i-1)*EncodeTime(0, 30, 0, 0)) then
         m_nRxMsg.m_sbyServerID := i
       else
         m_nRxMsg.m_sbyServerID := i or $80;
     DecodeDate(TempDate + i*(EncodeTime(0, 30, 0, 0)), Year, Month, Day);
     DecodeTime(TempDate + i*(EncodeTime(0, 30, 0, 0)), Hour, Min, Sec, ms);
     CreateOutMSG(fTempPar, PID, 0, TempDate);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;       
   FinalAction;
end;

procedure CEPQMMeter.ReadCurrParamsAns(var pMsg: CMessage);
var fTempPar   : double;
    tPID, i    : integer;
    KI, KU     : double;
begin
   if pMsg.m_sbyInfo[0 + smToRead] <> $41 then
     exit;
   KU := exp(ln(10)*pMsg.m_sbyInfo[9 + smToRead]);
   KI := exp(ln(10)*pMsg.m_sbyInfo[10 + smToRead]);
   for i := 0 to 12 do
   begin
     tPID := GetPIDFromPos(i);
     case tPID of
       QRY_MGAKT_POW_A, QRY_MGAKT_POW_B, QRY_MGAKT_POW_C :
         fTempPar := HexToReal(pMsg.m_sbyInfo[0 + smToRead], 11 + (tPID - QRY_MGAKT_POW_A)*4, 4)*KU*KI*m_nP.m_sfKI*m_nP.m_sfKU;
       QRY_MGREA_POW_A, QRY_MGREA_POW_B, QRY_MGREA_POW_C :
         fTempPar := HexToReal(pMsg.m_sbyInfo[0 + smToRead], 23 + (tPID - QRY_MGREA_POW_A)*4, 4)*KU*KI*m_nP.m_sfKI*m_nP.m_sfKU;
       QRY_U_PARAM_A, QRY_U_PARAM_B, QRY_U_PARAM_C :
         fTempPar := HexToReal(pMsg.m_sbyInfo[0 + smToRead], 35 + (tPID - QRY_U_PARAM_A)*4, 4)*KU*m_nP.m_sfKU;
       QRY_I_PARAM_A, QRY_I_PARAM_B, QRY_I_PARAM_C :
         fTempPar := HexToReal(pMsg.m_sbyInfo[0 + smToRead], 47 + (tPID - QRY_I_PARAM_A)*4, 4)*KI*m_nP.m_sfKI;
       QRY_FREQ_NET :
         fTempPar := (pMsg.m_sbyInfo[60 + smToRead]*$100 + pMsg.m_sbyInfo[59 + smToRead] - 2) / 100;
         //fTempPar := (HexToReal(pMsg.m_sbyInfo[0], 59, 2) + 2) / 10;
       else
         fTempPar := 0;
     end;
     CreateOutMsg(fTempPar, tPID, 0, Now);
     m_nRxMsg.m_sbyServerID := 0;
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   FinalAction;
end;

// exp(ln(x)*n)  Возведение числа х в степень n
procedure CEPQMMeter.ReadSysInfoAns(var pMsg: CMessage);
var TempDate           : TDateTime;
    Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin
   if (pMsg.m_sbyInfo[0 + smToRead] <> $19) and (pMsg.m_sbyInfo[0 + smToRead] <> $14) then
     exit;
   TempDate := BcDToDate(pMsg.m_sbyInfo[9 + smToRead]) + BcDToTime(pMsg.m_sbyInfo[9 + smToRead]);
   {if abs(TempDate - Now)/EncodeTime(0, 0, 1, 0) > 5 then
     CreateCorrTimeReq(TempDate);}
   if  (pMsg.m_sbyInfo[0 + smToRead] = $19) then
   begin
     OldCounter := false;
     KUI := (pMsg.m_sbyInfo[18 + smToRead]*$100 + pMsg.m_sbyInfo[19 + smToRead])*(pMsg.m_sbyInfo[20 + smToRead]*$100 + pMsg.m_sbyInfo[21 + smToRead]);
     ES  := pMsg.m_sbyInfo[22 + smToRead];
   end
   else
   begin
     OldCounter := true;
     KUI := 1;
     ES  := 1;
   end;

   CreateOutMSG(0, QRY_DATA_TIME, 0, TempDate);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction;
end;

procedure CEPQMMeter.CreateCorrTimeReq(Time : TDateTime);
var Delta   : integer;
    TimeKor : shortint;
    crc     : word;
begin
   m_nTxMsg.m_sbyInfo[0]  := 14;
   MoveAdrToBuf (StrToHex(m_nP.m_sddFabNum), m_nTxMsg.m_sbyInfo[1]);
   m_nTxMsg.m_sbyInfo[7]  := 1;
   m_nTxMsg.m_sbyInfo[8]  := 3;
   m_nTxMsg.m_sbyInfo[9]  := $21;

   delta := trunc((Time - Now) / EncodeTime(0, 0, 1, 0));
   if abs(delta) > 128 then
     Delta := 127 * (delta div delta);
   TimeKor := Delta;
   m_nTxMsg.m_sbyInfo[10] := TimeKor;
   crc := CRC16(m_nTxMsg.m_sbyInfo[0], 11);
   m_nTxMsg.m_sbyInfo[12] := Lo(crc);
   m_nTxMsg.m_sbyInfo[13] := Hi(crc);
   MsgHead(m_nTxMsg, 14 + 11);
   FPUT(BOX_L1, @m_nTxMsg);
end;

function  CEPQMMeter.SelfHandler(var pMsg:CMessage):Boolean;
var
   res : Boolean;
begin
   res    := false;

   result := res;
end;

procedure CEPQMMeter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
     QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : strNum := 9;
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : strNum := 5;
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : strNum := 7;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM,
     QRY_SRES_ENR_DAY_EP, QRY_SRES_ENR_DAY_EM,
     QRY_SRES_ENR_DAY_RP, QRY_SRES_ENR_DAY_RM : strNum := 3;
     QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
     QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
     QRY_MGREA_POW_B, QRY_MGREA_POW_C,
     QRY_U_PARAM_A, QRY_U_PARAM_B,
     QRY_U_PARAM_C, QRY_I_PARAM_A,
     QRY_I_PARAM_B, QRY_I_PARAM_C,
     QRY_FREQ_NET                             : strNum := 11;
     QRY_DATA_TIME, QRY_KPRTEL_KE,
     QRY_AUTORIZATION                         : strNum := 1;
     else strNum := 1;
   end;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestEPQM.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   pMsg.m_swLen := cnt + 11;
end;

function CEPQMMeter.LoHandler(var pMsg:CMessage):Boolean;
var
    res    : Boolean;
    crc    : word;
begin
    res := False;
    //Обработчик для L1
     case pMsg.m_sbyType of
      PH_DATA_IND:
      begin
        {$IFDEF EPQM_DEBUG}
        TestMSG(pMsg);
        {$ENDIF}
        crc := CRC16(pMsg.m_sbyInfo[0 + smToRead], pMsg.m_sbyInfo[0 + smToRead] - 2);
        if (pMsg.m_sbyInfo[0 + smToRead] < 2) or (crc <> pMsg.m_sbyInfo[pMsg.m_sbyInfo[0 + smToRead] + smToRead - 2] + pMsg.m_sbyInfo[pMsg.m_sbyInfo[0 + smToRead] + smToRead - 1]*$100) then
        begin
          TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>EPQM  CRC Error!!!');
          exit;
        end;
        case nReq.m_swParamID of
            QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
            QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : ReadSumEnergyAns(pMsg);
            QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
            QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : ReadEnergyDayAns(pMsg);
            QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
            QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : ReadNakEnMonthAns(pMsg);
            QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
            QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM     : ReadPrirEnMonthAns(pMsg);
            QRY_SRES_ENR_EP,
            QRY_SRES_ENR_EM,
            QRY_SRES_ENR_RP,
            QRY_SRES_ENR_RM,
            QRY_SRES_ENR_DAY_EP,
            QRY_SRES_ENR_DAY_EM,
            QRY_SRES_ENR_DAY_RP,
            QRY_SRES_ENR_DAY_RM                      : ReadSresEnrDayAns(pMsg);
            QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
            QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
            QRY_MGREA_POW_B, QRY_MGREA_POW_C,
            QRY_U_PARAM_A, QRY_U_PARAM_B,
            QRY_U_PARAM_C, QRY_I_PARAM_A,
            QRY_I_PARAM_B, QRY_I_PARAM_C,
            QRY_FREQ_NET                              : ReadCurrParamsAns(pMsg);
            QRY_DATA_TIME, QRY_KPRTEL_KE,
            QRY_AUTORIZATION                          : ReadSysInfoAns(pMsg);
          else begin FinalAction; exit; end;
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    end;
    Result := res;
end;

procedure CEPQMMeter.HandQryRoutine(var pMsg:CMessage);
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
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : AddNakEnergyMonthGraphQry(param, Date1, Date2);
      QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
      QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : AddPrirEnergyMonthGraphQry(param, Date1, Date2);
      QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
      QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : AddEnergySresGraphQry(param, Date1, Date2);
      QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
      QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
      QRY_MGREA_POW_B, QRY_MGREA_POW_C,
      QRY_U_PARAM_A, QRY_U_PARAM_B,
      QRY_U_PARAM_C, QRY_I_PARAM_A,
      QRY_I_PARAM_B, QRY_I_PARAM_C,
      QRY_FREQ_NET                              : m_nObserver.AddGraphParam(param, 0, 0, 0, 1);
    end;
end;

function CEPQMMeter.HiHandler(var pMsg:CMessage):Boolean;
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
       FNCNum := GetCommand(nReq.m_swParamID);
       if FNCNum = -1 then
         exit;
       if FNCNum = 10 then
         SaveBeginMonthPok;
       m_nTxMsg.m_sbyInfo[0]  := 13;
       MoveAdrToBuf(StrToHex(m_nP.m_sddFabNum), m_nTxMsg.m_sbyInfo[1]);
       m_nTxMsg.m_sbyInfo[7]  := 1;
       m_nTxMsg.m_sbyInfo[8]  := 1;
       if FNCNum<>0 then
       begin
         m_nTxMsg.m_sbyInfo[9]  := FNCNum;
         m_nTxMsg.m_sbyInfo[10] := nReq.m_swSpecc0;
         crc := CRC16(m_nTxMsg.m_sbyInfo[0], 11);
         m_nTxMsg.m_sbyInfo[11] := Lo(crc);
         m_nTxMsg.m_sbyInfo[12] := Hi(crc);
         MsgHead(m_nTxMsg, 13 + 11);
       end
       else
       begin
         m_nTxMsg.m_sbyInfo[0]  := 12;
         m_nTxMsg.m_sbyInfo[9]  := FNCNum;
         crc := CRC16(m_nTxMsg.m_sbyInfo[0], 10);
         m_nTxMsg.m_sbyInfo[10] := Lo(crc);
         m_nTxMsg.m_sbyInfo[11] := Hi(crc);
         MsgHead(m_nTxMsg, 12 + 11);
       end;
       //smToRead := m_nTxMsg.m_sbyInfo[0];
       smToRead := 0;
       FPUT(BOX_L1, @m_nTxMsg);
       m_nRepTimer.OnTimer(m_nP.m_swRepTime);
       TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>EPQM DRQ:',@pMsg);
       SendOutStat(m_nTxMsg.m_swLen);
     end;
     QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
     QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
   end;
   Result := res;
end;

procedure CEPQMMeter.OnEnterAction;
var i, j : integer;
begin
   for i:=0 to 3 do
     for j:=1 to 4 do
     begin
       PrirMonthNow[i, j, 0] := -1;
       PrirMonthNow[i, j, 1] := -1;
       PrirMonthNow[i, j, 2] := -1;
       PrirMonthNow[i, j, 3] := -1;
       NakEnNow[i, j] := -1;
     end;
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EPQM OnEnterAction');
   if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
   OpenPhone else
   if (m_nP.m_sbyModem=0) then FinalAction;
   //FinalAction;
end;

procedure CEPQMMeter.OnFinalAction;
begin
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EPQM OnFinalAction');
   //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
   //if m_nP.m_sbyModem=0 then FinalAction;
   //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
   FinalAction;
end;

procedure CEPQMMeter.OnConnectComplette(var pMsg:CMessage);
begin
   TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EPQM OnConnectComplette');
   m_nModemState := 1;
   FinalAction;
end;

procedure CEPQMMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>EPQM OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CEPQMMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>EPQM OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
   end;
end;

procedure CEPQMMeter.RunMeter;
Begin

End;

function CEPQMMeter.GetCommand(byCommand:Byte):Integer;
var
    res : Integer;
begin
    case byCommand of
      QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
      QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : res := 8;
      QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
      QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : res := 6;
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : res := 10;
      QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
      QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM     : res := 7;
      QRY_SRES_ENR_EP                          : res := 2;
      QRY_SRES_ENR_EM                          : res := 3;
      QRY_SRES_ENR_RP                          : res := 4;
      QRY_SRES_ENR_RM                          : res := 5;
      QRY_SRES_ENR_DAY_EP                      : res := 2;
      QRY_SRES_ENR_DAY_EM                      : res := 3;
      QRY_SRES_ENR_DAY_RP                      : res := 4;
      QRY_SRES_ENR_DAY_RM                      : res := 5;
      QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
      QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
      QRY_MGREA_POW_B, QRY_MGREA_POW_C,
      QRY_U_PARAM_A, QRY_U_PARAM_B,
      QRY_U_PARAM_C, QRY_I_PARAM_A,
      QRY_I_PARAM_B, QRY_I_PARAM_C,
      QRY_FREQ_NET                             : res := 9;
      QRY_DATA_TIME, QRY_KPRTEL_KE,
      QRY_AUTORIZATION                         : res := 0;
      else                                       res := -1;
    end;
    Result := res;
end;

procedure CEPQMMeter.CRC16b(b: Byte; var CRC: word);
var i : Byte;
    F : Boolean;
begin
   for i := 1 to 8 do
   begin
     F := Odd(b xor CRC);
     CRC := CRC shr 1;
     b := b shr 1;
     if F then
       CRC := CRC xor $A001;
   end;
end;                 

function CEPQMMeter.CRC16(var buf:array of byte; count:integer):word;
var i:integer;
    res:word;
begin
    res:=0;
    for i:= 0 to count-1 do CRC16b(buf[i],res);
    result:=res;
end;

function CEPQMMeter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CEPQMMeter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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
