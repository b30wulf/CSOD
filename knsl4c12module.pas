unit knsl4c12module;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,knsl4automodule,
utldatabase,utlTimeDate,knsl5config,knsl3lme,knsl2module,knsl1module,knsl3module,knsl3savetime,knsl3EventBox;
type
    CC12Module = class(CHIAutomat)
    private
     m_nTxMsg            : CMessage;
     m_pDDB              : PCDBDynamicConn;
     mPassword           : string;
     mIsOpenSession      : boolean;
     TonnelPort          : integer;
     mTranzBuf           : array [0..7] of byte;
     m_sTblL1            : SL1INITITAG;
     PhAddrAndComPrt     : SPHADRANDCOMPRTS;
     InnerPDS            : CMessageData;
     InnerFunctionPr     : Integer;
     procedure FNCCloseSession(var pMsg : CMessage);
     procedure FNCOpenSession(var pMsg : CMessage);
     procedure FNCGet30MinSlice(var pMsg : CMessage);
     procedure FNCGet3MinSlice(var pMsg : CMessage);
     procedure FNCSetTime(var pMsg : CMessage);
     procedure FNCGetTime(var pMsg : CMessage);
     procedure FNCGetCalcValueFrDB(var pMsg : CMessage);
     procedure FNCSetCalcValueToDB(var pMsg : CMessage);
     procedure FNCGetCurrEvent(var pMsg : CMessage);
     procedure FNCGetEventsList(var pMsg : CMessage);
     procedure FNCGoGoGo(var pMsg : CMessage);
     procedure FNCStop(var pMsg : CMessage);
     procedure FNCInterLink(var pMsg : CMessage);
     procedure FNCGetSumEnDay(var pMsg : CMessage);
     procedure FNCGetSumEnPeriod(var pMsg : CMessage);
     procedure FNCGetParamName(var pMsg : CMessage);
     procedure FNCGetMaxPowerDay(var pMsg : CMessage);
     procedure FNCGetMaxPowerPeriod(var pMsg : CMessage);
     procedure FNCSendTransaction(var pMsg : CMessage);
     procedure FNCSendTranzAns(var pMsg : CMessage);
     procedure FNCReadOutFnc(var pMsg : CMessage);
     procedure FNCStartPool(var pMsg : CMessage);
     procedure FNCStopPool(var pMsg : CMessage);
     procedure FNCReadGraphFromMeters(var pMsg : CMessage);
     procedure FNCReBoot(var pMsg : CMessage);
     procedure FNCReadEvents(var pMsg : CMessage);
     procedure FNCStartFH(var pMsg : CMessage);
     procedure FNCSetL2TM(var pMsg : CMessage);
     procedure FNCSetSynchro(var pMsg : CMessage);
     procedure FNCDeepBuffer(var pMsg : CMessage);
     procedure FNCBaseSize(var pMsg : CMessage);
     procedure FNCDeepData(var pMsg : CMessage);
     procedure FNCClearData(var pMsg : CMessage);
     procedure FNCExecSQL(var pMsg : CMessage);
     procedure FNCInit(var pMsg : CMessage);
     procedure FNCDelArch(var pMsg : CMessage);
     procedure StartTranz;
     procedure FinishTranz;
     procedure SendMsgToMeter(var pMsg : CMessage); //Отправка сообщения напрямую в счетчик
     function  CRC16(var _Buff : array of BYTE; _Count : WORD; _SetCRC16 : Boolean) : Boolean;
     function  CRC_CC301(var buf : array of byte; cnt : byte):boolean;
     function  FindPortToOpenTonnel(portID : integer) : integer; //return PortID
     function  FindPortID(wVMID : word) : word;
     procedure CreateOutMSG(var pMsg : CMessage; Len, Code : integer);
     procedure GetCanalType(Kanal : integer; var VMID, CMDID: integer);
     function  Is30Slices(CMDID: integer): boolean;
     function  Is30Periodic(CMDID: integer): boolean;
     function  IsArchParam(CMDID: integer): boolean;
     function  IsMonthParam(CMDID: integer): boolean;
     function  PrepareMonthDate(tDate: TDateTime; CMDID: integer): TDateTime;
     function  Read30Slices(Date: TDateTime; VMID, CMDID: integer): integer;
     function  Read30Periodic(Date: TDateTime; VMID, CMDID: integer): integer;
     procedure Set30NoData;
    public
     procedure InitAuto(var pTable : SL1TAG);override;
     function LoHandler(var pMsg : CMessage):Boolean;override;
     function HiHandler(var pMsg : CMessage):Boolean;override;
     procedure RunAuto;override;
     function  SelfHandler(var pMsg: CMessage):Boolean; override;
    End;
const PARAM_NAMES : array [0..43] of string = ('Резерв',
                                               'Cрез 30 мин Wp+',
                                               'Cрез 30 мин Wp-',
                                               'Cрез 30 мин Wq+',
                                               'Cрез 30 мин Wq-',
                                               'Cрез 30 мин P+',
                                               'Cрез 30 мин P-',
                                               'Cрез 30 мин Q+',
                                               'Cрез 30 мин Q-',
                                               'Приращение Wp+ сутки',
                                               'Приращение Wp- сутки',
                                               'Приращение Wq+ сутки',
                                               'Приращение Wq- сутки',
                                               'Приращение Wp+ месяц',
                                               'Приращение Wp- месяц',
                                               'Приращение Wq+ месяц',
                                               'Приращение Wq- месяц',
                                               'Wp+ сутки накопленная',
                                               'Wp- сутки накопленная',
                                               'Wq+ сутки накопленная',
                                               'Wq- сутки накопленная',
                                               'Wp+ месяц накопленная',
                                               'Wp- месяц накопленная',
                                               'Wq+ месяц накопленная',
                                               'Wq- месяц накопленная',
                                               'Wp+ общая накопленная',
                                               'Wp- общая накопленная',
                                               'Wq+ общая накопленная',
                                               'Wq- общая накопленная',
                                               'Ток фаза А',
                                               'Ток фаза B',
                                               'Ток фаза C',
                                               'Напряжение фаза A',
                                               'Напряжение фаза B',
                                               'Напряжение фаза C',
                                               'Мощность акт сумма',
                                               'Мощность акт фаза A',
                                               'Мощность акт фаза B',
                                               'Мощность акт фаза C',
                                               'Мощность реа сумма',
                                               'Мощность реа фаза A',
                                               'Мощность реа фаза B',
                                               'Мощность реа фаза C',
                                               'Частота');
implementation
{
 Каналы идут последовательно относительно VMID
  1 - срез A+ энергия
  2 - срез A- энергия
  3 - срез R+ энергия
  4 - срез R- энергия

  5 - срез A+ мощность
  6 - срез A- мощность
  7 - срез R+ мощность
  8 - срез R- мощность

  9 - приращение A+ сутки
  10 - приращение A- сутки
  11 - приращение R+ сутки
  12 - приращение R- сутки

  13 - приращение A+ месяц
  14 - приращение A- месяц
  15 - приращение R+ месяц
  16 - приращение R- месяц

  17 - A+ сутки накопленная
  18 - A- сутки накопленная
  19 - R+ сутки накопленная
  20 - R- сутки накопленная

  21 - A+ месяц накопленная
  22 - A- месяц накопленная
  23 - R+ месяц накопленная
  24 - R- месяц накопленная

  25 - A+ накопленная
  26 - A- накопленная
  27 - R+ накопленная
  28 - R- накопленная

  29 - ток фаза А
  30 - ток фаза B
  31 - ток фаза C

  32 - напряжение A
  33 - напряжение B
  34 - напряжение C

  35 - мощность акт сумма
  36 - мощность акт A
  37 - мощность акт B
  38 - мощность акт C

  39 - мощность реа сумма
  40 - мощность реа A
  41 - мощность реа B
  42 - мощность реа C

  43 - частота

  44 - 50 - резерв
}

procedure CC12Module.GetCanalType(Kanal : integer; var VMID, CMDID: integer);
var _mod: integer;
begin
   _mod := (Kanal - 1) mod 50 + 1;
   VMID  := (Kanal - 1) div 50;
   CMDID := QRY_AUTORIZATION;
   case _mod of
     1  : CMDID := QRY_SRES_ENR_EP;     //- срез A+ энергия
     2  : CMDID := QRY_SRES_ENR_EM;     //- срез A- энергия
     3  : CMDID := QRY_SRES_ENR_RP;     //- срез R+ энергия
     4  : CMDID := QRY_SRES_ENR_RM;     //- срез R- энергия

     5  : CMDID := QRY_E30MIN_POW_EP;   //- срез A+ мощность
     6  : CMDID := QRY_E30MIN_POW_EM;   //- срез A- мощность
     7  : CMDID := QRY_E30MIN_POW_RP;   //- срез R+ мощность
     8  : CMDID := QRY_E30MIN_POW_RM;   //- срез R- мощность

     9  : CMDID := QRY_ENERGY_DAY_EP;   //- приращение A+ сутки
     10 : CMDID := QRY_ENERGY_DAY_EM;   //- приращение A- сутки
     11 : CMDID := QRY_ENERGY_DAY_RP;   //- приращение R+ сутки
     12 : CMDID := QRY_ENERGY_DAY_RM;   //- приращение R- сутки

     13 : CMDID := QRY_ENERGY_MON_EP;   //- приращение A+ месяц
     14 : CMDID := QRY_ENERGY_MON_EM;   //- приращение A- месяц
     15 : CMDID := QRY_ENERGY_MON_RP;   //- приращение R+ месяц
     16 : CMDID := QRY_ENERGY_MON_RM;   //- приращение R- месяц

     17 : CMDID := QRY_NAK_EN_DAY_EP;   //- A+ сутки накопленная
     18 : CMDID := QRY_NAK_EN_DAY_EM;   //- A- сутки накопленная
     19 : CMDID := QRY_NAK_EN_DAY_RP;   //- R+ сутки накопленная
     20 : CMDID := QRY_NAK_EN_DAY_RM;   //- R- сутки накопленная

     21 : CMDID := QRY_NAK_EN_MONTH_EP; //- A+ месяц накопленная
     22 : CMDID := QRY_NAK_EN_MONTH_EM; //- A- месяц накопленная
     23 : CMDID := QRY_NAK_EN_MONTH_RP; //- R+ месяц накопленная
     24 : CMDID := QRY_NAK_EN_MONTH_RM; //- R- месяц накопленная

     25 : CMDID := QRY_ENERGY_SUM_EP;   //- A+ накопленная
     26 : CMDID := QRY_ENERGY_SUM_EM;   //- A- накопленная
     27 : CMDID := QRY_ENERGY_SUM_RP;   //- R+ накопленная
     28 : CMDID := QRY_ENERGY_SUM_RM;   //- R- накопленная

     29 : CMDID := QRY_I_PARAM_A;       //- ток фаза А
     30 : CMDID := QRY_I_PARAM_B;       //- ток фаза B
     31 : CMDID := QRY_I_PARAM_C;       //- ток фаза C

     32 : CMDID := QRY_U_PARAM_A;       //- напряжение A
     33 : CMDID := QRY_U_PARAM_B;       //- напряжение B
     34 : CMDID := QRY_U_PARAM_C;       //- напряжение C

     35 : CMDID := QRY_MGAKT_POW_S;     //- мощность акт сумма
     36 : CMDID := QRY_MGAKT_POW_A;     //- мощность акт A
     37 : CMDID := QRY_MGAKT_POW_B;     //- мощность акт B
     38 : CMDID := QRY_MGAKT_POW_C;     //- мощность акт C

     39 : CMDID := QRY_MGREA_POW_S;     //- мощность реа сумма
     40 : CMDID := QRY_MGREA_POW_A;     //- мощность реа A
     41 : CMDID := QRY_MGREA_POW_B;     //- мощность реа B
     42 : CMDID := QRY_MGREA_POW_C;     //- мощность реа C

     43 : CMDID := QRY_FREQ_NET;        //- частота
   end;
end;

procedure CC12Module.CreateOutMSG(var pMsg : CMessage; Len, Code : integer);
begin
   m_nTxMsg.m_sbyInfo[0]   := pMsg.m_sbyInfo[0];
   m_nTxMsg.m_sbyInfo[1]   := pMsg.m_sbyInfo[1];
   m_nTxMsg.m_sbyInfo[2]   := Code;
   m_nTxMsg.m_swLen        := Len + 11;
   m_nTxMsg.m_swObjID      := m_swAddres;
   m_nTxMsg.m_sbyFrom      := DIR_BTITOL1;
   m_nTxMsg.m_sbyFor       := DIR_BTITOL1;
   m_nTxMsg.m_sbyType      := PH_DATARD_REQ;
   m_nTxMsg.m_sbyTypeIntID := m_sbyPortID;
   m_nTxMsg.m_sbyIntID     := m_sbyPortID;
   CRC16(m_nTxMsg.m_sbyInfo, Len, false);
end;

procedure CC12Module.FNCCloseSession(var pMsg : CMessage);
begin
   mIsOpenSession := false;
   CreateOutMSG(pMsg, 5, 0);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCOpenSession(var pMsg : CMessage);
var getPass : string;
begin
   SetLength(getPass, 8);
   move(pMsg.m_sbyInfo[2], getPass[1], 8);
   if getPass <> mPassword then
   begin
     mIsOpenSession := false;
     CreateOutMSG(pMsg, 5, 4);
   end
   else
   begin
     mIsOpenSession := true;
     CreateOutMSG(pMsg, 5, 0);
   end;
   FPUT(BOX_L1, @m_nTxMsg);
end;

function  CC12Module.Is30Slices(CMDID: integer): boolean;
begin
   if ((CMDID >= QRY_SRES_ENR_EP) and (CMDID <= QRY_SRES_ENR_RM))
      or ((CMDID >= QRY_E30MIN_POW_EP) and (CMDID <= QRY_E30MIN_POW_RM)) then
     Result := true
   else
     Result := false;
end;

function  CC12Module.Is30Periodic(CMDID: integer): boolean;
begin
   if ((CMDID >= QRY_I_PARAM_A) and (CMDID <= QRY_I_PARAM_C))
      or ((CMDID >= QRY_U_PARAM_A) and (CMDID <= QRY_U_PARAM_C))
      or ((CMDID >= QRY_MGAKT_POW_S) and (CMDID <= QRY_MGAKT_POW_C))
      or ((CMDID >= QRY_MGREA_POW_S) and (CMDID <= QRY_MGREA_POW_C))
      or (CMDID = QRY_FREQ_NET) then
     Result := true
   else
     Result := false;
end;

function CC12Module.IsMonthParam(CMDID: integer): boolean;
begin
   if ((CMDID >= QRY_ENERGY_MON_EP) and (CMDID <= QRY_ENERGY_MON_RM)) or
   ((CMDID >= QRY_NAK_EN_MONTH_EP) and (CMDID <= QRY_NAK_EN_MONTH_RM)) then
     Result := true
   else
     Result := false;



end;

function CC12Module.IsArchParam(CMDID: integer): boolean;
begin
   if ((CMDID >= QRY_ENERGY_DAY_EP) and (CMDID <= QRY_ENERGY_DAY_RM))
      or ((CMDID >= QRY_ENERGY_MON_EP) and (CMDID <= QRY_ENERGY_MON_RM))
      or ((CMDID >= QRY_NAK_EN_DAY_EP) and (CMDID <= QRY_NAK_EN_DAY_RM))
      or ((CMDID >= QRY_NAK_EN_MONTH_EP) and (CMDID <= QRY_NAK_EN_MONTH_RM)) then
     Result := true
   else
     Result := false;
end;

function CC12Module.PrepareMonthDate(tDate: TDateTime; CMDID: integer): TDateTime;
begin
   if (CMDID >= QRY_NAK_EN_MONTH_EP) and (CMDID <= QRY_NAK_EN_MONTH_RM) then
   begin
     Result := cDateTimeR.GetBeginMonth(tDate);
   end else if (CMDID >= QRY_ENERGY_MON_EP) and (CMDID <= QRY_ENERGY_MON_RM) then
   begin
     Result := cDateTimeR.GetBeginMonth(tDate);
     Result := cDateTimeR.fIncMonth(Result);
   end 
   else
     Result := tDate;
end;

function CC12Module.Read30Slices(Date: TDateTime; VMID, CMDID: integer): integer;
var pTable      : L3GRAPHDATAS;
    i, mult     : integer;
    fParam     : single;
begin
   if (CMDID >= QRY_E30MIN_POW_EP) and (CMDID <= QRY_E30MIN_POW_RM) then
   begin
     mult   := 1;
     CMDID  := QRY_SRES_ENR_EP + CMDID - QRY_E30MIN_POW_EP;
   end
   else
     mult := 1;

   m_pDDB.GetGraphDatas(Date, Date, VMID, CMDID, pTable);
   if pTable.Count > 0 then
   begin
     Result := 0;
     for i := 0 to 47 do
     begin
       fParam := pTable.Items[0].v[i] * mult;
       move(fParam, m_nTxMsg.m_sbyInfo[8 + i*5], 4);
       if IsBitInMask(pTable.Items[0].m_sMaskReRead, i) then
         m_nTxMsg.m_sbyInfo[8 + i*5 + 4] := 0
       else
         m_nTxMsg.m_sbyInfo[8 + i*5 + 4] := Byte('^');
     end;
   end else
   begin
     Result := 5;
     Set30NoData;
   end;
end;

function CC12Module.Read30Periodic(Date: TDateTime; VMID, CMDID: integer): integer;
var pTable : CCDatas;
    i      : integer;
    fParam : single;
begin
   m_pDDB.GetGDPData_48(Date, Date, VMID, CMDID, CMDID, pTable);
   if pTable.Count >= 48 then
   begin
     Result := 0;
     for i := 0 to 47 do
     begin
       fParam := pTable.Items[i].m_sfValue;
       move(fParam, m_nTxMsg.m_sbyInfo[8 + i*5], 4);
       if IsBitInMask(pTable.Items[i].m_sbyMaskRead, i) then
         m_nTxMsg.m_sbyInfo[8 + i*5 + 4] := 0
       else
         m_nTxMsg.m_sbyInfo[8 + i*5 + 4] := Byte('^');
     end;
   end else
   begin
     Result := 5;
     Set30NoData;
   end;
end;

procedure CC12Module.Set30NoData;
var i : integer;
begin
   for i := 0 to 47 do
   begin
     FillChar(m_nTxMsg.m_sbyInfo[8 + i*5], 4, 0);
     m_nTxMsg.m_sbyInfo[8 + i*5 + 4] := Byte('^');
   end;
end;

procedure CC12Module.FNCGet30MinSlice(var pMsg : CMessage);
var CMDID, VMID, Kan    : integer;
    tDate               : TDateTime;
    erCode              : integer;
begin
   if not mIsOpenSession then exit;
   erCode := 0;
   Kan := pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100;
   GetCanalType(Kan, VMID, CMDID);

   try
     tDate := EncodeDate(pMsg.m_sbyInfo[6] + 2000, pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[4]);
   except
     tDate := 0;
   end;

   if (Is30Slices(CMDID)) and (tDate <> 0) then
     erCode := Read30Slices(tDate, VMID, CMDID)
   else if (Is30Periodic(CMDID)) and (tDate <> 0) then
     erCode := Read30Periodic(tDate, VMID, CMDID)
   else if tDate = 0 then
   begin
     Set30NoData;
     erCode := 3;
   end;
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 5);
   CreateOutMsg(pMsg, 250, erCode);
   FPUT(BOX_L1, @m_nTxMsg)
end;

procedure CC12Module.FNCGet3MinSlice(var pMsg : CMessage);
var i : integer;
begin                                                 
   if not mIsOpenSession then exit;

   for i := 0 to 479 do
   begin
     FillChar(m_nTxMsg.m_sbyInfo[8 + i*5], 4, 0);
     m_nTxMsg.m_sbyInfo[8 + i*5 + 4] := Byte('^');
   end;
   
   CreateOutMSG(pMsg, 2410, 5);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCSetTime(var pMsg : CMessage);
var Year, Month, Day,
    Hour, Min, Sec   : integer;
    TempDate         : TDateTime;
begin
   if not mIsOpenSession then exit;
   Sec   := pMsg.m_sbyInfo[2];
   Min   := pMsg.m_sbyInfo[3];
   Hour  := pMsg.m_sbyInfo[4];
   Day   := pMsg.m_sbyInfo[5];
   Month := pMsg.m_sbyInfo[6];
   move(pMsg.m_sbyInfo[7], Year, 4);
   try
     TempDate := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, 0);
     cDateTimeR.SetTimeToPC(TempDate);
     m_nMSynchKorr.m_blEnable := True;
     CreateOutMSG(pMsg, 5, 0);
   except
     CreateOutMSG(pMsg, 5, 3);
   end;
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetTime(var pMsg : CMessage);
var Year, Month, Day,
    Hour, Min, Sec, ms     : word;
begin
   if not mIsOpenSession then exit;
   DecodeDate(Now, Year, Month, Day);
   DecodeTime(Now, Hour, Min, Sec, ms);
   m_nTxMsg.m_sbyInfo[3] := Sec;
   m_nTxMsg.m_sbyInfo[4] := Min;
   m_nTxMsg.m_sbyInfo[5] := Hour;
   m_nTxMsg.m_sbyInfo[6] := Day;
   m_nTxMsg.m_sbyInfo[7] := Month;
   m_nTxMsg.m_sbyInfo[8] := Year mod $100;
   m_nTxMsg.m_sbyInfo[9] := Year div $100;
   m_nTxMsg.m_sbyInfo[10]:= 0;
   m_nTxMsg.m_sbyInfo[11]:= 0;
   CreateOutMsg(pMsg, 14, 0);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetCalcValueFrDB(var pMsg : CMessage);
var Kan, VMID, CMDID : integer;
    tDate            : TDateTime;
    fValue           : single;
    erCode           : integer;
    pTable           : CCDatas;
begin
   if not mIsOpenSession then exit;
   fValue := 0;
   erCode := 0;
   Kan := pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100;
   GetCanalType(Kan, VMID, CMDID);
   if not IsArchParam(CMDID) then
     erCode := 3;
   try
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 7);
   if IsMonthParam(CMDID) then
   begin
     pMsg.m_sbyInfo[7] := 0;
     pMsg.m_sbyInfo[8] := 0;
   end;
     if (pMsg.m_sbyInfo[7] = 24) then
       tDate := EncodeDate(pMsg.m_sbyInfo[6] + 2000, pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[4]) +
                EncodeTime(0, pMsg.m_sbyInfo[8], 0, 0) + 1
     else
       tDate := EncodeDate(pMsg.m_sbyInfo[6] + 2000, pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[4]) +
                EncodeTime(pMsg.m_sbyInfo[7], pMsg.m_sbyInfo[8], 0, 0);
   except
     erCode := 3;
     tDate  := 0;
   end;
   tDate := PrepareMonthDate(tDate, CMDID);
   m_pDDB.GetGData(tDate, tDate, VMID, CMDID, -1, pTable);
   if (pTable.Count > 0) then
     fValue := pTable.Items[0].m_sfValue
   else
     erCode := 5;
   if erCode = 0 then
     m_nTxMsg.m_sbyInfo[14] := 0
   else
     m_nTxMsg.m_sbyInfo[14] :=Byte('^');
   move(fValue, m_nTxMsg.m_sbyInfo[10], 4);

   CreateOutMSG(pMsg, 17, erCode);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCSetCalcValueToDB(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 7);
   CreateOutMSG(pMsg, 12, 1);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetCurrEvent(var pMsg : CMessage);
var cur_evv : integer;
begin
   if not mIsOpenSession then exit;
//   cur_evv := m_pDDB.GetEventsCount - 1;
   move(cur_evv, m_nTxMsg.m_sbyInfo[3], 4);
   CreateOutMSG(pMsg, 9, 0);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetEventsList(var pMsg : CMessage);
var pTable          : SEVENTTAGS;
    ev_n            : integer;
    ev_str, ev_name : string;
begin
   if not mIsOpenSession then exit;
//   m_pDDB.GetAllEventsTable(pTable);

   move(pMsg.m_sbyInfo[2], ev_n, 4);

   if (ev_n >= 0) and (ev_n < pTable.Count) then
   begin
     ev_str := FormatDateTime('dd.mm.yy.hh.nn.ss', pTable.Items[ev_n].m_sdtEventTime);
     ev_name := m_pDDB.GetEventName(pTable.Items[ev_n].m_swGroupID, pTable.Items[ev_n].m_swEventID);
     if (pTable.Items[ev_n].m_swGroupID <> 1) and (pTable.Items[ev_n].m_swGroupID <> 2) then
       ev_str := ev_str + ev_name
     else
       ev_str := ev_str + '(' + m_pDDB.GetFabNumber(pTable.Items[ev_n].m_swVMID) + ')' + ev_name;
   end
   else
     ev_str := '';

   FillChar(m_nTxMsg.m_sbyInfo[7], 80, 0);
   m_nTxMsg.m_sbyInfo[2] := $00;
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 4);
   if (Length(ev_str) <= 80) then
     move(ev_str[1], m_nTxMsg.m_sbyInfo[7], Length(ev_str))
   else
     move(ev_str[1], m_nTxMsg.m_sbyInfo[7], 80);

   CreateOutMsg(pMsg, 89, 0);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGoGoGo(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   CreateOutMSG(pMSg, 4, 1);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCStop(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   CreateOutMsg(pMsg, 4, 1);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCInterLink(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   CreateOutMSG(pMsg, 4, 1);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetSumEnDay(var pMsg : CMessage);
var Kan, VMID, CMDID : integer;
    tDate            : TDateTime;
    fValue           : single;
    erCode           : integer;
    pTable           : CCDatas;
begin
   if not mIsOpenSession then exit;
   fValue := 0;
   erCode := 0;
   Kan := pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100;
   GetCanalType(Kan, VMID, CMDID);
   if (CMDID >= QRY_ENERGY_DAY_EP) and (CMDID <= QRY_ENERGY_DAY_RM) then
     erCode := 3;
   try
     tDate := EncodeDate(pMsg.m_sbyInfo[6] + 2000, pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[4]);
   except
     erCode := 3;
     tDate  := 0;
   end;
   if pMsg.m_sbyInfo[7]=0  then m_pDDB.GetGData(tDate, tDate, VMID, CMDID, -1, pTable) else
   if pMsg.m_sbyInfo[7]<>0 then m_pDDB.GetGData(tDate, tDate, VMID, CMDID, pMsg.m_sbyInfo[7], pTable);
   if (pTable.Count > 0) then
     fValue := pTable.Items[0].m_sfValue
   else
     erCode := 5;
   if erCode = 0 then
     m_nTxMsg.m_sbyInfo[14] := 0
   else
     m_nTxMsg.m_sbyInfo[14] :=Byte('^');
   move(fValue, m_nTxMsg.m_sbyInfo[10], 4);
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 7);
   CreateOutMSG(pMsg, 17, erCode);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetSumEnPeriod(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 10);
   FillChar(m_nTxMsg.m_sbyInfo[13], 4, 0);
   m_nTxMsg.m_sbyInfo[17] := Byte('^');
   CreateOutMSG(pMsg, 20, 3);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetParamName(var pMsg : CMessage);
var Kan, VMID, CMDID : integer;
    KanName          : string;
begin
   if not mIsOpenSession then exit;
   Kan := pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100;
   GetCanalType(Kan, VMID, CMDID);
   KanName := PARAM_NAMES[CMDID];

   FillChar(m_nTxMsg.m_sbyInfo[4], 40, 0);
   move(KanName[1], m_nTxMsg.m_sbyInfo[4], Length(KanName));

   CreateOutMSG(pMsg, 47, 0);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetMaxPowerDay(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 7);
   FillChar(m_nTxMsg.m_sbyInfo[10], 4, 0);
   m_nTxMsg.m_sbyInfo[11] := Byte('^');
   m_nTxMsg.m_sbyInfo[12] := 0;
   CreateOutMSG(pMsg, 15, 3);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCGetMaxPowerPeriod(var pMsg : CMessage);
begin
   if not mIsOpenSession then exit;
   move(pMsg.m_sbyInfo[2], m_nTxMsg.m_sbyInfo[3], 10);
   FillChar(m_nTxMsg.m_sbyInfo[13], 4, 0);
   m_nTxMsg.m_sbyInfo[17] := Byte('^');
   m_nTxMsg.m_sbyInfo[18] := 0;
   m_nTxMsg.m_sbyInfo[19] := 1;
   m_nTxMsg.m_sbyInfo[20] := 1;
   m_nTxMsg.m_sbyInfo[21] := 0;
   CreateOutMSG(pMsg, 22, 3);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCSendTransaction(var pMsg : CMessage);
var i   : integer;
    len : integer;
begin
   len := pMsg.m_sbyInfo[2] + pMsg.m_sbyInfo[3]*$100 - 10;
   move(pMsg.m_sbyInfo[0], mTranzBuf[0], 8);
   if (len > 100) or (len < 0) then exit;
   for i := 0 to len - 1 do
     pMsg.m_sbyInfo[i] := pMsg.m_sbyInfo[i + 8];
   CRC_CC301(pMsg.m_sbyInfo, len);
   pMsg.m_swLen := len + 11 + 2;
   TonnelPort := FindPortToOpenTonnel(FindPortID(pMsg.m_sbyInfo[0]));
   SendMsgToMeter(pMsg);
end;

procedure CC12Module.FNCSendTranzAns(var pMsg : CMessage);
var out_len : integer;
begin
   move(mTranzBuf[0], m_nTxMsg.m_sbyInfo[0], 8);

   out_len := pMsg.m_swLen - 11 - 2 + 10;
   m_nTxMsg.m_sbyInfo[2] := (out_len) mod $100;
   m_nTxMsg.m_sbyInfo[3] := (out_len) div $100;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[8], pMsg.m_swLen - 11 - 2);

   move(mTranzBuf[0], pMsg.m_sbyInfo[0], 8);
   pMsg.m_sbyInfo[2] := (out_len) mod $100;
   pMsg.m_sbyInfo[3] := (out_len) div $100;
   
   CreateOutMSG(pMsg, out_len, m_nTxMsg.m_sbyInfo[2]);
   FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CC12Module.FNCReadOutFnc(var pMsg : CMessage);
begin
   case pMsg.m_sbyInfo[2] of
     200           : FNCStartPool(pMsg);                            //Запустить сервер
     201           : FNCStopPool(pMsg);                             //Остановить сервер
     202           : FNCReadGraphFromMeters(pMsg);                  //Прочитать графики/архивы из устройств
     203           : FNCReBoot(pMsg);                               //Перезагрузка
     204           : FNCReadEvents(pMsg);                           //Запрс событий
     205           : FNCStartFH(pMsg);                              //Запуск поиска
     206           : FNCSetL2TM(pMsg);                              //Установка ограничения коррекции
     207           : FNCSetSynchro(pMsg);                           //Установка источника синхронизации
     208           : FNCDeepBuffer(pMsg);                           //Установка глубины буфера параметров сети
     209           : FNCBaseSize(pMsg);                             //Установка максимального размера базы
     210           : FNCDeepData(pMsg);                             //Установка глубины хранения данных
     211           : FNCClearData(pMsg);                            //Удаление  данных
     212           : FNCExecSQL(pMsg);                              //Выполнение запроса
     213           : FNCInit(pMsg);                                 //Инициализация
     214           : FNCDelArch(pMsg);
   end;

   FillChar(m_nTxMsg,30,0);
   CreateOutMSG(pMsg, 8+2,0);
   m_nTxMsg.m_sbyInfo[0] := 0;
   m_nTxMsg.m_sbyInfo[1] := $FA;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CRC16(m_nTxMsg.m_sbyInfo, 8+2, false);
   FPUT(BOX_L1,@m_nTxMsg);
end;

procedure CC12Module.FNCStartPool(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   m_nCF.SchedGo;
   mL3LmeMoule.m_sALD.Reset;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 200;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $FF00, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CC12Module.FNCStopPool(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   m_nCF.SchedPause;
   mL3LmeMoule.m_sALD.Reset;
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 201;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //FillChar(m_nTxMsg,30,0);
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff01, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CC12Module.FNCReadGraphFromMeters(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   move(pMsg.m_sbyInfo[6], pDS.m_swData0, 4);
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4);
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4);
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   move(pMsg.m_sbyInfo[26], pDS.m_sbyInfo[0], sizeof(TDateTime)*2);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 202;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //FillChar(m_nTxMsg,30,0);
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff02, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
end;
procedure CC12Module.FNCReBoot(var pMsg : CMessage);
Var
   pDS  : CMessageData;
Begin
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 203;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //FillChar(m_nTxMsg,30,0);
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff03, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CC12Module.FNCReadEvents(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   move(pMsg.m_sbyInfo[6], pDS.m_swData0, 4);
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4);
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4);
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   move(pMsg.m_sbyInfo[26], pDS.m_sbyInfo[0], sizeof(TDateTime)*2);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_LOAD_EVENTS_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 204;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   //m_nTxMsg.m_sbyInfo[6] := 0;
   //m_nTxMsg.m_sbyInfo[7] := 0;
   //CreateMSG(pMsg, $ff04, 16+2, True, Now);
   //CreateMSGHead(m_nTxMsg, 16+2);
   //FPUT(BOX_L1, @m_nTxMsg);
End;
procedure CC12Module.FNCStartFH(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   szDT  := sizeof(TDateTime);
   m_nDataFinder  := True;
   move(pMsg.m_sbyInfo[6],pDS.m_sbyInfo[0],szDT);
   move(pMsg.m_sbyInfo[6+szDT],pDS.m_sbyInfo[szDT],szDT);
   move(pMsg.m_sbyInfo[6+2*szDT],pDS.m_sbyInfo[2*szDT],sizeof(int64));
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   SendMsgData(BOX_L3_LME, 0, DIR_LHTOLM3, QL_START_FH_REQ, pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 205;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   {
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   CreateMSG(pMsg, $ff06, 16+2, True, Now);
   CreateMSGHead(m_nTxMsg, 16+2);
   FPUT(BOX_L1, @m_nTxMsg);
   }
End;
procedure CC12Module.FNCSetL2TM(var pMsg : CMessage);
Var
   szDT,szI,i : Integer;
   pDS        : CMessageData;
   nVMID,nMID : Integer;
   m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor:TDateTime;
   VMeters    : SL3GROUPTAG;
begin
   try
   szDT  := sizeof(TDateTime);
   szI   := sizeof(Integer);
   move(pMsg.m_sbyInfo[6],nVMID,szI);
   move(pMsg.m_sbyInfo[6+szI],m_sdtSumKor,szDT);
   move(pMsg.m_sbyInfo[6+szI+szDT],m_sdtLimKor,szDT);
   move(pMsg.m_sbyInfo[6+szI+2*szDT],m_sdtPhLimKor,szDT);

   nMID := 0;
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   Begin
    for i := 0 to VMeters.m_swAmVMeter - 1 do
    if nVMID=VMeters.Item.Items[i].m_swVMID then
    Begin
     nMID := VMeters.Item.Items[i].m_swMID;
     m_pDB.SetTimeLimit(nMID,m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor);
     mL2Module.InitMeter(nMID);
     break;
    End;
   End;
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 206;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CC12Module.FNCSetSynchro(var pMsg : CMessage);
Var
   szDT,szI,i : Integer;
   pDS        : CMessageData;
   nVMID,nMID : Integer;
   m_nSynchro : Byte;
   VMeters    : SL3GROUPTAG;
begin
   try
   szDT  := sizeof(TDateTime);
   szI   := sizeof(Integer);
   move(pMsg.m_sbyInfo[6],nVMID,szI);
   m_nSynchro := pMsg.m_sbyInfo[6+szI];
   //move(pMsg.m_sbyInfo[6+szI],m_sdtSumKor,szDT);
   //move(pMsg.m_sbyInfo[6+szI+szDT],m_sdtLimKor,szDT);
   //move(pMsg.m_sbyInfo[6+szI+2*szDT],m_sdtPhLimKor,szDT);

   nMID := 0;
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   Begin
    for i := 0 to VMeters.m_swAmVMeter - 1 do
    if nVMID=VMeters.Item.Items[i].m_swVMID then
    Begin
     nMID := VMeters.Item.Items[i].m_swMID;
     m_pDB.SetSynchroChnl(nMID,m_nSynchro);
     mL2Module.InitMeter(nMID);
     break;
    End;
   End;

   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 207;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CC12Module.FNCDeepBuffer(var pMsg : CMessage);
begin
   try
   m_nMaxDayNetParam := pMsg.m_sbyInfo[6];
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 208;
   m_nTxMsg.m_sbyInfo[6] := m_nMaxDayNetParam;;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CC12Module.FNCBaseSize(var pMsg : CMessage);
Var
   nSizeDB : Integer;
begin
   try
   if pMsg.m_sbyInfo[7]=1 then m_nMaxSpaceDB := pMsg.m_sbyInfo[6];
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 209;
   m_nTxMsg.m_sbyInfo[6] := m_nMaxSpaceDB;
   nSizeDB               := m_pDB.GetSizeDB;
   Move(nSizeDB,m_nTxMsg.m_sbyInfo[7],4);
   except

   end;
End;
procedure CC12Module.FNCDeepData(var pMsg : CMessage);
begin
   try
   m_nCF.m_pGenTable.m_sStoreClrTime := pMsg.m_sbyInfo[6]+1;
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 210;
   m_nTxMsg.m_sbyInfo[6] := m_nCF.m_pGenTable.m_sStoreClrTime;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CC12Module.FNCClearData(var pMsg : CMessage);
Var
   nClearMonth : Integer;
begin
   try
   nClearMonth := pMsg.m_sbyInfo[6];
   m_pDB.FreeBase(nClearMonth);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 211;
   m_nTxMsg.m_sbyInfo[6] := nClearMonth;
   m_nTxMsg.m_sbyInfo[7] := 0;
   except

   end;
End;
procedure CC12Module.FNCExecSQL(var pMsg : CMessage);
Var
    str,strF : String;
    i,nLen,nPos:Integer;
Begin
    try
    {
    str := 'UPDATE SL3ABON SET m_sbyEnable=0 WHERE m_swABOID=0:::'+
           'UPDATE L2TAG SET M_SFKU=25.45,M_SFKI=22.12 WHERE M_SWMID=2:::'+
           'UPDATE L2TAG SET M_SFKU=11.11,M_SFKI=33.33 WHERE M_SWMID=3:::';
    nLen := Length(str);
    Move(nLen,pMsg.m_sbyInfo[6],2);
    for i:=0 to nLen do pMsg.m_sbyInfo[8+i] := Byte(str[i+1]);
    }
    str  := '';
    nLen := 0;
    Move(pMsg.m_sbyInfo[6],nLen,2);
    if nLen>5000 then exit;
    SetLength(str,nLen);
    for i:=0 to nLen-1 do str[i+1] := Char(pMsg.m_sbyInfo[8+i]);
    nPos := Pos(':::',str);
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     m_pDB.ExecQry(strF);
    End;

    FillChar(m_nTxMsg,30,0);
    m_nTxMsg.m_swLen      := 13+8+2;
    m_nTxMsg.m_sbyInfo[0] := 1;
    m_nTxMsg.m_sbyInfo[1] := 212;
    m_nTxMsg.m_sbyInfo[6] := 0;
    m_nTxMsg.m_sbyInfo[7] := 0;
    except
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CBTIModule.FNCExecSQL!!!');
    End;
End;
procedure CC12Module.FNCInit(var pMsg : CMessage);
Var
    pDS : CMessageData;
begin
   try
   pDS.m_swData4 := MTR_LOCAL;
   case pMsg.m_sbyInfo[6] of
        0 : mL1Module.Init;         //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL1_REQ,pDS);
        1 : mL2Module.Init;         //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL2_REQ,pDS);
        2 : mL3Module.OnLoadVMeters;//SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL3_REQ,pDS);
        3 : m_nCF.SetGenSettings;
        4 : SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SAVE_DB_REQ,pDS);
        5 : m_nCF.SchedInit;
        6 : m_nCF.SchedGo;
        7 : m_nCF.SchedPause;
        8 : Begin Move(pMsg.m_sbyInfo[7],pDS.m_swData1,4); m_nST.SetDTime(pDS.m_swData1);End;
        9 : m_nST.SetState(pMsg.m_sbyInfo[7]);
        10 : Begin
              m_nSmartFinder := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nSmartFinder',pMsg.m_sbyInfo[7]);
             End;
        11 : Begin
              m_nIsOneSynchro := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nIsOneSynchro',pMsg.m_sbyInfo[7]);
             End;
        12 : m_nQweryReboot := 1; //Запрос перезагрузки
        13 : m_nCF.SelfStop;
        14 : Begin
              Move(pMsg.m_sbyInfo[10],InnerPDS.m_swData1,4);//Time
              Move(pMsg.m_sbyInfo[14],InnerPDS.m_swData2,4);//Speed
              InnerFunctionPr := 14;
              m_nRepTimer.OnTimer(45);
             End;
        15 : Begin
              m_nUpdateFunction := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nUpdateFunction',pMsg.m_sbyInfo[7]);
             End;
        16:  Begin
              if pMsg.m_sbyInfo[7]=0 then pDS.m_swData4 := MTR_LOCAL else
              if pMsg.m_sbyInfo[7]=1 then pDS.m_swData4 := MTR_REMOTE;
              SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RELOAD_USPRO_REQ,pDS);
             End;
        17 : Begin
              move(pMsg.m_sbyInfo[7], m_nCountOfEvents, 4);
              m_nCF.SetSettIntValue('m_nCountOfEvents',m_nCountOfEvents);
             End;
        20 : Begin
              m_nLockMeter := pMsg.m_sbyInfo[7];
              m_nCF.SetSettIntValue('m_nLockMeter',pMsg.m_sbyInfo[7]);
             End;
   End;
    FillChar(m_nTxMsg,30,0);
    m_nTxMsg.m_swLen      := 13+8+2;
    m_nTxMsg.m_sbyInfo[0] := 1;
    m_nTxMsg.m_sbyInfo[1] := 213;
    m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[6];
    m_nTxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[7];
   except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CEKOMModule.FNCInit!!!');
   end;
End;
procedure CC12Module.FNCDelArch(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
   dtDate2,dtDate1 : TDateTime;
   DataGraph   : L3GRAPHDATA;
   DataCurrent : L3CURRENTDATA;
begin
   try
   move(pMsg.m_sbyInfo[6],  pDS.m_swData0, 4); //FCID
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4); //VMID
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4); //CMDID
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   move(pMsg.m_sbyInfo[26], dtDate2, sizeof(TDateTime));
   move(pMsg.m_sbyInfo[26+sizeof(TDateTime)], dtDate1, sizeof(TDateTime));
   DataGraph.m_swVMID    := pDS.m_swData1;
   DataGraph.m_swCMDID   := pDS.m_swData2;
   DataCurrent.m_swVMID  := pDS.m_swData1;
   DataCurrent.m_swCMDID := pDS.m_swData2;
   case pDS.m_swData0 of
        SV_GRPH_ST : m_pDB.DelGraphData(dtDate2, dtDate1, DataGraph);
        SV_ARCH_ST : m_pDB.DelArchData(dtDate2, dtDate1, DataCurrent);
        SV_PDPH_ST : m_pDB.DelPdtData(dtDate2, dtDate1, DataCurrent);
   end;
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
   FillChar(m_nTxMsg,30,0);
   m_nTxMsg.m_swLen      := 13+8+2;
   m_nTxMsg.m_sbyInfo[0] := 1;
   m_nTxMsg.m_sbyInfo[1] := 214;
   m_nTxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[6];
   m_nTxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[7];
   except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CEKOMModule.FNCDelArch!!!');
   end;
end;

procedure CC12Module.StartTranz;
Var
    pDS : CMessageData;
begin
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   m_nCF.SchedPause;
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
end;

procedure CC12Module.FinishTranz;
begin
   m_nRepTimer.OffTimer;
   m_sIsTranzOpen.m_sbIsTrasnBeg := false;
   m_nCF.SchedGo;
end;

procedure CC12Module.SendMsgToMeter(var pMsg : CMessage); //Отправка сообщения напрямую в счетчик
begin
   StartTranz;
   m_sIsTranzOpen.m_sbIsTrasnBeg := true;
   m_sIsTranzOpen.m_swObjID      := m_sbyID;
   move(pMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[0], pMsg.m_swLen - 11);
   m_nTxMsg.m_swLen       := pMsg.m_swLen;
   m_nTxMsg.m_swObjID     := m_sbyID;             //Сетевой адрес счётчика
   m_nTxMsg.m_sbyFrom     := DIR_L2TOL1;
   m_nTxMsg.m_sbyFor      := DIR_L2TOL1;         //DIR_L2toL1
   m_nTxMsg.m_sbyType     := PH_DATARD_REQ;      //PH_DATARD_REC
   m_nTxMsg.m_sbyIntID    := TonnelPort;
   m_nTxMsg.m_sbyServerID := MET_SS301F3;          //Указать тип счетчика
   m_nTxMsg.m_sbyDirID    := TonnelPort;
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_sbyRepTime);
end;

procedure CC12Module.InitAuto(var pTable : SL1TAG);
var i       : integer;
    VMeters : SL3GROUPTAG;
Begin
   m_pDDB := m_pDB.CreateConnect;
   mPassword := pTable.m_schPhone;
   TonnelPort := -1;
   m_pDDB.GetL1Table(m_sTblL1);
   if m_pDDB.GetVMetersTable(-1,-1, VMeters) then
   begin
     PhAddrAndComPrt.Count := VMeters.m_swAmVMeter;
     SetLength(PhAddrAndComPrt.Items, VMeters.m_swAmVMeter);
     for i := 0 to VMeters.m_swAmVMeter - 1 do
     begin
       PhAddrAndComPrt.Items[i].m_swPHAddres := StrToInt(VMeters.Item.Items[i].m_sddPHAddres) ;
       PhAddrAndComPrt.Items[i].m_swPortID   := VMeters.Item.Items[i].m_sbyPortID;
     end;
   end;
   mIsOpenSession := false;
End;

function CC12Module.LoHandler(var pMsg : CMessage):Boolean;
Var
  fnc : integer;
Begin
    Result := True;
    try
      if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>C12 LOH:',pMsg);
      if m_nRepTimer.IsProceed and (pMsg.m_sbyIntID = TonnelPort) then
      begin
        FNCSendTranzAns(pMsg);
        exit;
      end;
      if (pMsg.m_swLen <> 16 + 11) or not CRC16(pMsg.m_sbyInfo, pMsg.m_swLen - 11, false) then
      begin
        if pMsg.m_sbyInfo[1] <> $FA then
        begin
          if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL4MD::>C12 LOH: CRC Error!');
          exit;
        end;
      end;
      fnc := pMsg.m_sbyInfo[1];
      case fnc of
        84 : FNCCloseSession(pMsg);             //++
        85 : FNCOpenSession(pMsg);              //+
        86 : FNCGet30MinSlice(pMsg);            //++
        87 : FNCGet3MinSlice(pMsg);             //+
        88 : FNCSetTime(pMsg);                  //+
        89 : FNCGetTime(pMsg);                  //+
        90 : FNCGetCalcValueFrDB(pMsg);         //+
        91 : FNCSetCalcValueToDB(pMsg);         //+
        92 : FNCGetCurrEvent(pMsg);             //+
        93 : FNCGetEventsList(pMsg);            //+
        94 : FNCGoGoGo(pMsg);                   //+
        95 : FNCStop(pMsg);                     //+
        96 : FNCInterLink(pMsg);                //+
        97 : FNCGetSumEnDay(pMsg);              //+
        98 : FNCGetSumEnPeriod(pMsg);           //+
        99 : FNCGetParamName(pMsg);             //+
        100: FNCGetMaxPowerDay(pMsg);           //+
        101: FNCGetMaxPowerPeriod(pMsg);        //+
        2  : FNCSendTransaction(pMsg);          //+
        $FA: FNCReadOutFnc(pMsg);
      end;
    except
    end;
End;
function CC12Module.HiHandler(var pMsg : CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'(__)CL4MD::>C12 HIH:',pMsg);
    Result := res;
End;
procedure CC12Module.RunAuto;
Begin
    
End;

function CC12Module.SelfHandler(var pMsg: CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    if pMsg.m_sbyType=AL_REPMSG_TMR then
    begin
      case InnerFunctionPr of
        14 :
          begin
            m_nCF.m_nSDL.m_nGST.OpenSession(InnerPDS.m_swData1,InnerPDS.m_swData2);
            m_nRepTimer.OffTimer;
          end;
        else
        begin
          m_sIsTranzOpen.m_sbIsTrasnBeg := false;
          m_nCF.SchedGo;
        end;
      end;
    end;
    InnerFunctionPr := 0;
    Result := res;
end;

function CC12Module.CRC16(var _Buff : array of BYTE; _Count : WORD; _SetCRC16 : Boolean) : Boolean;
var
    i       : integer;
    CRCHi,
    CRCLo,
    ind     : byte;
begin
    Result  := true;
    CRCHi   := $FF;
    CRCLo   := $FF;

    for i := 0 to _Count - 3 do
    begin
        ind:= CRCHi xor _Buff[i];
        CRCHi:= CRCLo xor srCRCHi[ind];
        CRCLo:= srCRCLo[ind];
    end;

    if (_Buff[_Count - 2] <> CRCLo) and (_Buff[_Count - 1] <> CRCHi) then
        Result := false;

    _Buff[_Count - 2] := CRCLo;
    _Buff[_Count - 1] := CRCHi;
end;

function CC12Module.CRC_CC301(var buf : array of byte; cnt : byte):boolean;
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

function CC12Module.FindPortToOpenTonnel(portID : integer) : integer; //return PortID
var i : integer;
begin
   Result := -1;
   for i := 0 to m_sTblL1.Count - 1 do
     if m_sTblL1.Items[i].m_sbyPortID = portID then
     begin
       Result := m_sTblL1.Items[i].m_sbyPortID;
       break;
     end;
end;

function  CC12Module.FindPortID(wVMID : word) : word;
var i : integer;
begin
   Result := High(word);         
   for i := 0 to PhAddrAndComPrt.Count - 1 do
     if PhAddrAndComPrt.Items[i].m_swPHAddres = wVMID then
       Result := PhAddrAndComPrt.Items[i].m_swPortID;
end;

end.
