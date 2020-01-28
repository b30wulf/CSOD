unit knsl2KaskadMeter;
//{$DEFINE SS301_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate, utlSpeedTimer;
type
    CKaskadMeter = class(CMeter)
    public
     procedure CreateCheckAdrReq;
    Private
     MeterReqState  : integer;
     MeterAddReqSt  : integer;
     //IsUpdate       : boolean;
     LastTimeS      : TDateTime;
     TimeReq        : TDateTime;
     m_nCounter     : Integer;
     m_nCounter1    : Integer;
     nReq           : CQueryPrimitive;
     Ke             : double;
     GraphBegin     : Integer;
     tempfValue     : double;
     SliceAdr       : Integer;
     SliceTime      : TDateTime;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     procedure   CreateCloseSessionReq;
     procedure   CreateCheckPassReq;
     procedure   CreateCurrParamReq;
     procedure   CreateGetAdrSresReq;
     procedure   CreateGetLastSresTimeReq;
     procedure   CreateGetSresReq;
     procedure   CreateSresEnReq;
     procedure   Create30300Req;
     procedure   CreateCorrTimeReq;
     procedure   CreateReloadReq;
     procedure   CreateWriteCentReq;
     procedure   CreateDateTimeReq;
     procedure   CreateReadParReq;
     procedure   ReadSimpleParamAns(var pMsg:CMessage);
     procedure   ReadAdrSresAns(var pMsg:CMessage);
     procedure   ReadGetLastSresTimeAns(var pMsg:CMessage);
     procedure   ReadGetFirstSresAns(var pMsg:CMessage);
     procedure   ReadSresEnAns(var pMsg:CMessage);
     procedure   ReadDateTimeAns(var pMsg:CMessage);
     procedure   ReadNullAnswer(var pMsg:CMessage);
     procedure   ReadCheckAdrAnswer(var pMsg:CMessage);
     procedure   ReadCheckPasswordAnswer(var pMsg:CMessage);
     procedure   ReadParameterAnswer(var pMsg:CMessage);
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;        //Обработка ответа от счетчика
     function    HiHandler(var pMsg:CMessage):Boolean;override;        //Формирование ответа от счетчика
     function    GetCommand(byCommand:Byte):Integer;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     function    GetAdrParameter(PID : integer) : integer;
     procedure   ByteToCharArray(var buf : array of byte; byte_par : byte);
     function    GetDoubleParamFromMSG(var pMsg:CMessage):double;
     function    GetIntParamFromMSG(var pMsg:CMessage):integer;
     function    GetDateTimeFromMSG(var pMsg:CMessage):TDateTime;
     function    GetSliceAdr(var SliceDate : TDateTime):integer;
     procedure   CheckNReqForSlice;
     function    ReadSliceAnswer(var pMsg :CMessage; slN : integer):integer;
     function    ByteToBCD(val : byte):byte;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     function    Calculate_CRC(var buf : array of byte; start_b, end_b : word):byte;
     procedure   AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   GetTimeValue(var nReq: CQueryPrimitive);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     //procedure   SetGraphParam(dt_Date1, dt_Date2:TDateTime; param : word);override;
    End;
const
  cInt       = sizeof(Integer);
  cDataSize  = sizeof(Double);
  cST        = $2F;
  cCLRF      = #$0D#$0A;
  cStx1      = $3F;
  cEtx1      = $21;
  cStx       = $02;
  cEtx       = $03;
  cAsk       = $06;
  cNak       = $15;
  cSoh       = $01;
  csetcc     = '(),/!*';
  cComId     : array[0..4] of byte = ($50, $57, $52, $45, $42);
  cType      : array[0..4] of byte = ($31, $31, $31, $32, $30);
  cKanConst  = 2730;
  cKanCount  = 4;
  cKanLen    = 6;
  ST_NULL_STATE         = 0;   //Закрытие сессии
  ST_KASKAD_CHECK_ADR   = 1;   //Проверка адреса
  ST_KASKAD_CHECK_PASS  = 2;   //Проверка пароля
  ST_KASKAD_READ_PAR    = 3;   //Параметр, читаемай в один запрос
  ST_KASKAD_READ_PAR_2  = 4;   //Параметр, читаемый в вдва запроса
  ST_KASKAD_FIN         = 5;   //Параметр считан
  ST_KASKAD_REQ_ONE     = 0;   //Первый запрос
  ST_KASKAD_REQ_TWO     = 1;   //Второй запрос на чтение данных и т. д.
  ST_KASKAD_REQ_THREE   = 2;
  ST_KASKAD_REQ_FOUR    = 3;   //Пиздец...



implementation

constructor CKaskadMeter.Create;
Begin

End;

procedure CKaskadMeter.InitMeter(var pL2:SL2TAG);
Begin
    m_nCounter    := 0;
    m_nCounter1   := 0;
    MeterReqState := ST_NULL_STATE;
    MeterAddReqSt := ST_KASKAD_REQ_ONE;
    tempfValue    := 0;
    IsUpdate   := 0;
    //if m_nP.m_sbyHandScenr=0 then
    //Begin
    // SetCurrQry;
    // SetGraphQry;
    //end;
    //if m_nP.m_sbyHandScenr=1 then
    //Begin
     SetHandScenario;
     SetHandScenarioGraph;

    if m_nRepSpTimer = nil then
      m_nRepSpTimer := CSpeedTimer.Create;
    m_nRepSpTimer.CallBackFNC := CreateCheckAdrReq;
    //end;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CKASK  Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;

procedure CKaskadMeter.AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var
    i, Srez,DeepSrez : integer;
    y0, d0, mn0      : word;
begin
    for i := trunc(dt_Date1) to trunc(dt_Date2) do
    begin
      DecodeDate(i, y0, mn0, d0);
      if i = trunc(Now) then
        DeepSrez := trunc(frac(Now) / EncodeTime(0, 30, 0, 0))
      else
        DeepSrez := 48;
      for Srez := 0 to DeepSrez - 1 do
        m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, mn0, d0, Srez, 1);
    end;
end;

function CKaskadMeter.GetAdrParameter(PID : integer) : integer;
begin
   case PID of
     QRY_ENERGY_SUM_EP : begin Result := $29; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_ENERGY_SUM_EM : begin Result := $2C; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_ENERGY_SUM_RP : begin
                           if MeterAddReqSt = ST_KASKAD_REQ_ONE then
                             Result := $2A
                           else
                             Result := $2D;
                           MeterReqState := ST_KASKAD_READ_PAR_2;
                         end;
     QRY_ENERGY_SUM_RM : begin
                           if MeterAddReqSt = ST_KASKAD_REQ_ONE then
                             Result := $2E
                           else
                             Result := $3B;
                           MeterReqState := ST_KASKAD_READ_PAR_2;
                         end;
     QRY_MGAKT_POW_S   : begin Result := $09; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGAKT_POW_A   : begin Result := $06; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGAKT_POW_B   : begin Result := $07; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGAKT_POW_C   : begin Result := $08; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGREA_POW_S   : begin Result := $0D; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGREA_POW_A   : begin Result := $0A; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGREA_POW_B   : begin Result := $0B; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_MGREA_POW_C   : begin Result := $0C; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_U_PARAM_A     : begin Result := $03; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_U_PARAM_B     : begin Result := $04; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_U_PARAM_C     : begin Result := $05; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_I_PARAM_A     : begin Result := $00; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_I_PARAM_B     : begin Result := $01; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_I_PARAM_C     : begin Result := $02; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_FREQ_NET      : begin Result := $16; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_KOEF_POW_A    : begin Result := $12; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_KOEF_POW_B    : begin Result := $13; MeterReqState := ST_KASKAD_READ_PAR; end;
     QRY_KOEF_POW_C    : begin Result := $14; MeterReqState := ST_KASKAD_READ_PAR; end;
   end;
end;

procedure CKaskadMeter.ByteToCharArray(var buf : array of byte; byte_par : byte);
var temp : byte;
begin
   temp := (byte_par and $F0) shr 4;
   if (temp >= $0A) then
     buf[0] := $41 + temp - $0A
   else
     buf[0] := $30 + temp;
   temp := byte_par and $0F;
   if (temp >= $0A) then
     buf[1] := $41 + temp - $0A
   else
     buf[1] := $30 + temp;
end;

function CKaskadMeter.GetDoubleParamFromMSG(var pMsg:CMessage):double;
var i, sO, sZ    : integer;
    tstr         : string;
    chB          : boolean;
begin
   sO := 0;
   sZ := 0;
   for i := 0 to pMsg.m_swLen - 11 do
   case pMsg.m_sbyInfo[i] of
     $28 : sO := i;
     $29 : sZ := i;
   end;
   chB := false;
   tstr := '';
   for i := sO + 1 to sZ - 1 do
   begin
     if ((pMsg.m_sbyInfo[i] >= $30) and (pMsg.m_sbyInfo[i] <= $39)) or (pMsg.m_sbyInfo[i] = $2E) then
       chB := true
     else if chB then
       break;
     if chB then
       tstr := tstr + Char(pMsg.m_sbyInfo[i]);
     end;
   try
     if Length(tstr) > 0 then
       Result := StrToFloat(tstr)
     else
       Result := 0;
   except
     Result := -1;
   end;
end;

function CKaskadMeter.GetIntParamFromMSG(var pMsg:CMessage):integer;
var i          : integer;
    posO, posZ : integer;
    tstr       : string;
begin
   Result := 0;
   tstr   := '';
   posO   := 0;
   posZ   := 0;
   for i := 0 to pMsg.m_swLen - 11 do
     case pMsg.m_sbyInfo[i] of
       $28 : posO := i;
       $29 : posZ := i;
     end;
   for i := posO + 1 to posZ - 1 do
      tstr := tstr + Char(pMsg.m_sbyInfo[i]);
   try
      Result := StrToInt(tstr);
   except
      Result := 0;
   end;
end;

function CKaskadMeter.GetDateTimeFromMSG(var pMsg:CMessage):TDateTime;
var Year, Month, Day,
    Hour, Min, Sec  : Word;
    tstr            : string;
begin
   with pMsg do
   begin
     tstr  := Char(m_sbyInfo[m_swLen - 11 - 5]) + Char(m_sbyInfo[m_swLen - 11 - 4]);
     Year  := StrToInt(tstr) + 2000;
     tstr  := Char(m_sbyInfo[m_swLen - 11 - 7]) + Char(m_sbyInfo[m_swLen - 11 - 6]);
     Month := StrToInt(tstr);
     tstr  := Char(m_sbyInfo[m_swLen - 11 - 9]) + Char(m_sbyInfo[m_swLen - 11 - 8]);
     Day   := StrToInt(tstr);
     tstr  := Char(m_sbyInfo[m_swLen - 11 - 13]) + Char(m_sbyInfo[m_swLen - 11 - 12]);
     Hour  := StrToInt(tstr);
     tstr  := Char(m_sbyInfo[m_swLen - 11 - 15]) + Char(m_sbyInfo[m_swLen - 11 - 14]);
     Min   := StrToInt(tstr);
     tstr  := Char(m_sbyInfo[m_swLen - 11 - 17]) + Char(m_sbyInfo[m_swLen - 11 - 16]);
     Sec   := StrToInt(tstr);
   end;
   try
     Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, 0);
   except
     Result := Now;
   end;
end;

function CKaskadMeter.GetSliceAdr(var SliceDate : TDateTime):integer;
var SlDelta : integer;
begin
   SlDelta := trunc((SliceTime - SliceDate) / EncodeTime(0, 30, 0, 0));
   SliceAdr := SliceAdr - SlDelta;

   if SliceAdr < 0 then
     SliceAdr := 8190 + SliceAdr;
   Result := SliceAdr;
end;

procedure CKaskadMeter.CheckNReqForSlice;
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
    Date               : TDateTime;
begin
   if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) then
   begin
     Date := SliceTime - EncodeTime(0, 30, 0, 0);
     DecodeDate(Date, Year, Month, Day);
     DecodeTime(Date, Hour, Min, Sec, ms);
     nReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Hour;
     nReq.m_swSpecc2 := Hour * 2 + Min div 30;
   end;
end;

function  CKaskadMeter.ReadSliceAnswer(var pMsg :CMessage; slN : integer):integer;
var i          : integer;
    posO, posZ : integer;
    tstr       : string;
begin
   posO := 0;
   posZ := 0;
   for i := 0 to pMsg.m_swLen - 11 do
     case pMsg.m_sbyInfo[i] of
       $28 : posO := i;
       $29 : posZ := i;
     end;
   tstr := '';
   for i := posO + 1 + slN * 6 to posO + 1 + (slN + 1)*6 do
     if i < posZ then
       tstr := tstr + Char(pMsg.m_sbyInfo[i]);
   try
     if Length(tstr) > 0 then
       Result := StrToInt(tstr)
     else
       Result := 0;
   except
     Result := 0;
   end;
end;

function CKaskadMeter.ByteToBCD(val : byte):byte;
var t1, t2 : byte;
begin
   t1     := val mod 10;
   t2     := val div 10;
   Result := t1 + (t2 shl 4);
end;

procedure CKaskadMeter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin                         //sm - вид энергии; tar - тарифф
   DecodeDate(Date, Year, Month, Day);
   DecodeTime(Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);
   m_nRxMsg.m_sbyServerID:= 0; 
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

procedure CKaskadMeter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;                 //pMsg.m_sbyInfo[] :=
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_KASKAD;     //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CKaskadMeter.SetCurrQry;
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

procedure CKaskadMeter.CreateCloseSessionReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $42;
   m_nTxMsg.m_sbyInfo[2] := $30;
   m_nTxMsg.m_sbyInfo[3] := $03;
   m_nTxMsg.m_sbyInfo[4] := $71;
   MsgHead(m_nTxMsg, 11 + 5);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   m_nRepSpTimer.CallBackFNC := CreateCheckAdrReq;
   m_nRepSpTimer.OnTimer(5);   //400 ms
   MeterReqState := ST_NULL_STATE;
   MeterAddReqSt := ST_KASKAD_REQ_ONE;
end;

procedure CKaskadMeter.CreateCheckAdrReq;
var AddrLen : integer;
begin
   m_nRepSpTimer.OffTimer;
   m_nTxMsg.m_sbyInfo[0] := cST;
   m_nTxMsg.m_sbyInfo[1] := cStx1;
   AddrLen := Length(m_nP.m_sddPHAddres);
   move(m_nP.m_sddPHAddres[1], m_nTxMsg.m_sbyInfo[2], AddrLen);
   m_nTxMsg.m_sbyInfo[2 + AddrLen] := cEtx1;
   move(cCLRF[1], m_nTxMsg.m_sbyInfo[3 + AddrLen], 2);
   MsgHead(m_nTxMsg, 11 + 5 + AddrLen);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   MeterReqState := ST_KASKAD_CHECK_ADR;
   MeterAddReqSt := ST_KASKAD_REQ_ONE;
end;

procedure CKaskadMeter.CreateCheckPassReq;
var PassLen : integer;
begin
   MeterReqState := ST_KASKAD_CHECK_PASS;
   PassLen := Length(m_nP.m_schPassword);
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $50;
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   m_nTxMsg.m_sbyInfo[4] := $28;
   move(m_nP.m_schPassword[1], m_nTxMsg.m_sbyInfo[5], PassLen);
   m_nTxMsg.m_sbyInfo[5 + PassLen] := $29;
   m_nTxMsg.m_sbyInfo[6 + PassLen] := $03;
   m_nTxMsg.m_sbyInfo[7 + PassLen] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 6 + PassLen);
   MsgHead(m_nTxMsg, 11 + 7 + PassLen);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   MeterReqState := ST_KASKAD_CHECK_PASS;
   MeterAddReqSt := ST_KASKAD_REQ_ONE;
end;

procedure CKaskadMeter.CreateCurrParamReq;
var InnerAddr : integer;
begin
   m_nTxMsg.m_sbyInfo[0] := $01; //STX
   m_nTxMsg.m_sbyInfo[1] := $52; //R
   m_nTxMsg.m_sbyInfo[2] := $31; //1
   m_nTxMsg.m_sbyInfo[3] := $02; //
   InnerAddr := GetAdrParameter(nReq.m_swParamID);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], 1);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], 1);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], InnerAddr);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], nReq.m_swSpecc1);
   m_nTxMsg.m_sbyInfo[12] := $28; // (
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], 1);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateGetAdrSresReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $52;
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $03);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], $72);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], $4B);
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], 2);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateGetLastSresTimeReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $52;
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $03);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], $72);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], $58);
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], $07);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateGetSresReq;
var Date               : TDateTime;
    Year, Month, Day,
    Hour, Min, Sec, ms : word;
    ptrRead            : word;
begin
   CheckNReqForSlice;
   DecodeDate(Now, Year, Month, Day);
   if Month < nReq.m_swSpecc0 then
     Year := Year - 1;
   Hour := nReq.m_swSpecc2 div 2;
   Min  := (nReq.m_swSpecc2 mod 2) * 30;
   Sec  := 0;
   Date := EncodeDate(Year, nReq.m_swSpecc0, nReq.m_swSpecc1) + EncodeTime(Hour, Min, Sec, 0);
   ptrRead := GetSliceAdr(Date);

   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $52;
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], ptrRead div 2730);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], Hi((ptrRead - (ptrRead div 2730)*2730)*12));
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], Lo((ptrRead - (ptrRead div 2730)*2730)*12));
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], $0C);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateSresEnReq;
begin
   case MeterAddReqSt of
     ST_KASKAD_REQ_ONE    : CreateGetAdrSresReq;        //Адрес последнего среза
     ST_KASKAD_REQ_TWO    : CreateGetLastSresTimeReq;   //Время последней записи
     ST_KASKAD_REQ_THREE  : CreateGetSresReq;           //Первый запрос срезов
     else
       MeterReqState := ST_KASKAD_FIN;
   end;
end;

procedure CKaskadMeter.Create30300Req;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := $52;
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $03);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], $03);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], $00);
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], $01);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateCorrTimeReq;
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
    DayOfW             : byte;
begin
   DecodeDate(Now, Year, Month, Day); Year := Year - 2000;
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := Byte('W');
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $04);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], $00);
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], ByteToBCD(Sec));
   ByteToCharArray(m_nTxMsg.m_sbyInfo[15], ByteToBCD(Min));
   ByteToCharArray(m_nTxMsg.m_sbyInfo[17], ByteToBCD(Hour));
   DayOfW := (DayOfWeek(Now) - 1);
   if DayOfW = 0 then DayOfW := 7;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[19], ByteToBCD(DayOfW));
   ByteToCharArray(m_nTxMsg.m_sbyInfo[21], ByteToBCD(Day));
   ByteToCharArray(m_nTxMsg.m_sbyInfo[23], ByteToBCD(Month));
   ByteToCharArray(m_nTxMsg.m_sbyInfo[25], ByteToBCD(Year));
   m_nTxMsg.m_sbyInfo[27] := $29;
   m_nTxMsg.m_sbyInfo[28] := $03;
   m_nTxMsg.m_sbyInfo[29] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 28);
   MsgHead(m_nTxMsg, 11 + 30);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateReloadReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := Byte('E');
   m_nTxMsg.m_sbyInfo[2] := Byte('2');
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $FF);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $00);
   m_nTxMsg.m_sbyInfo[8] := $28;
   m_nTxMsg.m_sbyInfo[9] := $29;
   m_nTxMsg.m_sbyInfo[10] := $03;
   m_nTxMsg.m_sbyInfo[11] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 10);
   MsgHead(m_nTxMsg, 11 + 12);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateWriteCentReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := Byte('W');
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $04);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], $08);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], $00);
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], $20);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateDateTimeReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $01;
   m_nTxMsg.m_sbyInfo[1] := Byte('R');
   m_nTxMsg.m_sbyInfo[2] := $31;
   m_nTxMsg.m_sbyInfo[3] := $02;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[4], $00);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[6], $04);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[8], $AA);
   ByteToCharArray(m_nTxMsg.m_sbyInfo[10], $00);
   m_nTxMsg.m_sbyInfo[12] := $28;
   ByteToCharArray(m_nTxMsg.m_sbyInfo[13], $07);
   m_nTxMsg.m_sbyInfo[15] := $29;
   m_nTxMsg.m_sbyInfo[16] := $03;
   m_nTxMsg.m_sbyInfo[17] := Calculate_CRC(m_nTxMsg.m_sbyInfo[0], 1, 16);
   MsgHead(m_nTxMsg, 11 + 18);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CKaskadMeter.CreateReadParReq;
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
     QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM,
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A,
     QRY_MGAKT_POW_B, QRY_MGAKT_POW_C,
     QRY_MGREA_POW_S, QRY_MGREA_POW_A,
     QRY_MGREA_POW_B, QRY_MGREA_POW_C,
     QRY_U_PARAM_A, QRY_U_PARAM_B,
     QRY_U_PARAM_C, QRY_I_PARAM_A,
     QRY_I_PARAM_B, QRY_I_PARAM_C,
     QRY_FREQ_NET, QRY_KOEF_POW_A,
     QRY_KOEF_POW_B, QRY_KOEF_POW_C   : CreateCurrParamReq;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM : CreateSresEnReq;
     QRY_DATA_TIME                    : if MeterAddReqSt = ST_KASKAD_REQ_ONE then Create30300Req;
     else
       FinalAction;
   end;
end;

//   procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
procedure CKaskadMeter.ReadSimpleParamAns(var pMsg:CMessage);
var tValue : double;
begin
   tValue := GetDoubleParamFromMSG(pMsg);
   if MeterReqState = ST_KASKAD_READ_PAR then
   begin
     CreateOutMSG(tValue, nReq.m_swParamID, 0, Now);
     FPUT(BOX_L3_BY, @m_nRxMsg);
     MeterReqState := ST_KASKAD_FIN;
   end;
   if MeterReqState = ST_KASKAD_READ_PAR_2 then
   begin
     if MeterAddReqSt = ST_KASKAD_REQ_ONE then
     begin
       tempfValue := tValue;
       MeterAddReqSt := ST_KASKAD_REQ_TWO;
     end
     else
     begin
       CreateOutMsg(tValue + tempfValue, nReq.m_swParamID, nReq.m_swSpecc1, Now);
       FPUT(BOX_L3_BY, @m_nRxMsg);
       MeterReqState := ST_KASKAD_FIN;
       tempFValue := 0;
     end
   end;
end;

procedure CKaskadMeter.ReadAdrSresAns(var pMsg:CMessage);
begin
   SliceAdr := GetIntParamFromMSG(pMsg);
end;

procedure CKaskadMeter.ReadGetLastSresTimeAns(var pMsg:CMessage);
begin
   SliceTime := GetDateTimeFromMSG(pMsg);
end;

procedure CKaskadMeter.ReadGetFirstSresAns(var pMsg:CMessage);
var i                  : integer;
    tValue             : double;
    Date               : TDateTime;
    Year, Month, Day   : word;
begin
   tempfValue := 0;
   DecodeDate(Now, Year, Month, Day);
   if Month < nReq.m_swSpecc0 then
     Year := Year - 1;
   Date := EncodeDate(Year, nReq.m_swSpecc0, nReq.m_swSpecc1) +
           EncodeTime(nReq.m_swSpecc2 div 2, (nReq.m_swSpecc2 mod 2)*30, 0, 0);
   for i := 0 to 3 do
   begin
     tValue := ReadSliceAnswer(pMsg, i);
     tValue := tValue / m_nP.m_swKE;

     if i <> 2 then
     begin
       CreateOutMsg(tValue + tempfValue, QRY_SRES_ENR_EP + i, 0, Date);
       m_nRxMsg.m_sbyServerID := nReq.m_swSpecc2;
       FPUT(BOX_L3_BY, @m_nRxMsg);
     end else tempfValue := tValue;
   end;
   CreateOutMsg(0, QRY_SRES_ENR_RM, 0, Date);
   m_nRxMsg.m_sbyServerID := nReq.m_swSpecc2;
   FPUT(BOX_L3_BY, @m_nRxMsg);
end;

procedure CKaskadMeter.ReadSresEnAns(var pMsg:CMessage);
begin
   case MeterAddReqSt of
     ST_KASKAD_REQ_ONE    : begin
                              ReadAdrSresAns(pMsg);           //Адрес последнего среза
                              MeterAddReqSt := ST_KASKAD_REQ_TWO;
                            end;
     ST_KASKAD_REQ_TWO    : begin
                              ReadGetLastSresTimeAns(pMsg);   //Время последней записи
                              MeterAddReqSt := ST_KASKAD_REQ_THREE;
                            end;
     ST_KASKAD_REQ_THREE  : begin
                              ReadGetFirstSresAns(pMsg);      //Первый запрос срезов
                              MeterReqState := ST_KASKAD_FIN;
                              MeterAddReqSt := ST_KASKAD_REQ_ONE;
                            end;
   end;
end;

procedure CKaskadMeter.ReadDateTimeAns(var pMsg:CMessage);
begin
   case MeterAddReqSt of
     ST_KASKAD_REQ_ONE   : begin
                             MeterAddReqSt := ST_KASKAD_REQ_TWO;
                             m_nRepTimer.OffTimer;
                             m_nRepSpTimer.CallBackFNC := CreateCorrTimeReq;
                             m_nRepSpTimer.OnTimer(10);
                           end;
     ST_KASKAD_REQ_TWO   :
                           begin
                             MeterAddReqSt := ST_KASKAD_REQ_THREE;
                             m_nRepTimer.OffTimer;
                             m_nRepSpTimer.CallBackFNC := CreateWriteCentReq;
                             m_nRepSpTimer.OnTimer(10);
                           end;
     ST_KASKAD_REQ_THREE : begin
                             CreateReloadReq;
                             MeterReqState := ST_KASKAD_FIN;
                             MeterAddReqSt := ST_KASKAD_REQ_ONE;
                           end;
   end;
end;

procedure CKaskadMeter.ReadNullAnswer(var pMsg:CMessage);
begin
   MeterReqState := ST_KASKAD_CHECK_ADR;
   MeterAddReqSt := ST_KASKAD_REQ_ONE;
end;

procedure CKaskadMeter.ReadCheckAdrAnswer(var pMsg:CMessage);
begin
   MeterReqState := ST_KASKAD_CHECK_PASS;
end;

procedure CKaskadMeter.ReadCheckPasswordAnswer(var pMsg:CMessage);
begin
   if (pMsg.m_sbyInfo[0] = $06) and (pMsg.m_swLen = 11 + 1) then
     MeterReqState := ST_KASKAD_READ_PAR
   else
     FinalAction;
end;

procedure CKaskadMeter.ReadParameterAnswer(var pMsg:CMessage);
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
     QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM,
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A,
     QRY_MGAKT_POW_B, QRY_MGAKT_POW_C,
     QRY_MGREA_POW_S, QRY_MGREA_POW_A,
     QRY_MGREA_POW_B, QRY_MGREA_POW_C,
     QRY_U_PARAM_A, QRY_U_PARAM_B,
     QRY_U_PARAM_C, QRY_I_PARAM_A,
     QRY_I_PARAM_B, QRY_I_PARAM_C,
     QRY_FREQ_NET, QRY_KOEF_POW_A,
     QRY_KOEF_POW_B, QRY_KOEF_POW_C   : ReadSimpleParamAns(pMsg);

   //
   // QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM: ReadReactEnAns(pMsg);
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM : ReadSresEnAns(pMsg);

     QRY_DATA_TIME                    : ReadDateTimeAns(pMsg);
     else
       MeterReqState := ST_KASKAD_FIN;
     end;
end;

procedure CKaskadMeter.SetGraphQry;
begin

end;

function CKaskadMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)

    Result := res;
End;

function CKaskadMeter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
    crc    : Byte;
Begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
         TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Kaskad  DIn:',@pMsg);
         if (MeterReqState > ST_KASKAD_READ_PAR) and (pMsg.m_sbyInfo[pMsg.m_SwLen - 11 - 1] <> Calculate_CRC(pMsg.m_sbyInfo[0], 0, pMsg.m_SwLen - 11 - 2)) then
         begin
           TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>CRC Error!!!');
           exit;
         end;
         if (pMsg.m_sbyInfo[1] = Byte('B')) and (pMsg.m_sbyInfo[2] = Byte('1')) then
           MeterReqState := ST_NULL_STATE;
         case MeterReqState of  //Чтение
           ST_NULL_STATE         : ReadNullAnswer(pMsg);
           ST_KASKAD_CHECK_ADR   : ReadCheckAdrAnswer(pMsg);
           ST_KASKAD_CHECK_PASS  : ReadCheckPasswordAnswer(pMsg);
           ST_KASKAD_READ_PAR,
           ST_KASKAD_READ_PAR_2  : ReadParameterAnswer(pMsg);
         end;
         case MeterReqState of
           ST_NULL_STATE         : CreateCloseSessionReq;
           ST_KASKAD_CHECK_ADR   : CreateCheckAdrReq;
           ST_KASKAD_CHECK_PASS  : CreateCheckPassReq;
           ST_KASKAD_READ_PAR,
           ST_KASKAD_READ_PAR_2  : CreateReadParReq;

           else FinalAction;
         end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
End;

procedure CKaskadMeter.HandQryRoutine(var pMsg:CMessage);
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
    //m_nObserver.AddGraphParam(QM_ENT_MTR_IND, 0, 0, 0, 1);//Enter
    case param of
     QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP,QRY_SRES_ENR_RM
                         :  AddSresEnergGrpahQry(Date1, Date2);
    end;
    //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final
end;

function CKaskadMeter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    tempP        : ShortInt;
    crc          : word;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //IsUpdate := false;
       //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
       TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Kaskad  DRQ:',@pMsg);
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));

       if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;

       case MeterReqState of
         ST_NULL_STATE          : CreateCloseSessionReq;
         ST_KASKAD_CHECK_ADR    : CreateCheckAdrReq;
         ST_KASKAD_CHECK_PASS   : CreateCheckPassReq;
         ST_KASKAD_READ_PAR, ST_KASKAD_READ_PAR_2
                                : CreateReadParReq;
         ST_KASKAD_FIN          : CreateCloseSessionReq;
         else FinalAction;
       end;
      End;
      QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;

procedure CKaskadMeter.GetTimeValue(var nReq: CQueryPrimitive);
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

procedure CKaskadMeter.OnEnterAction;
Begin
    MeterReqState := ST_NULL_STATE;
    MeterAddReqSt := ST_KASKAD_REQ_ONE;
    tempfValue    := 0;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CKASK OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;

procedure CKaskadMeter.OnFinalAction;
Begin
    MeterReqState := ST_NULL_STATE;
    MeterAddReqSt := ST_KASKAD_REQ_ONE;
    tempfValue    := 0;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CKASK OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;

procedure CKaskadMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CKASK OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;

procedure CKaskadMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CKASK OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CKaskadMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CKASKOnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
    End;
end;

function CKaskadMeter.GetCommand(byCommand:Byte):Integer;
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
     QRY_DATA_TIME      :   res:=32;//= 57;//
     QRY_MAX_POWER_EP   :   res:=7;
     QRY_JRNL_T1        :   res:=14;
     QRY_JRNL_T2        :   res:=15;
     QRY_JRNL_T3        :   res:=16;
     QRY_SUM_KORR_MONTH :   res:=45;
     else
     res:=-1;
    End;
    Result := res;
End;

function CKaskadMeter.Calculate_CRC(var buf : array of byte; start_b, end_b : word):byte;
var
  i                 : integer;
  res               : byte;
begin
  case end_b - start_b of
    2 : res := 3;
  else
    res := 0;
  end;
  for i := start_b to end_b do
    res := res xor buf[i];
  result := res;
end;

procedure CKaskadMeter.RunMeter;
Begin
    //m_nRepTimer.RunTimer;
    //m_nObserver.Run;
End;

end.
