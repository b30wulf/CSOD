unit knsl2VzljotMeter;
//{$DEFINE VZLJOT_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule
,knsl5tracer, utlTimeDate;
type
    CVzljotMeter = class(CMeter)
    Private
     m_nCounter     : Integer;
     m_nCounter1    : Integer;
     //IsUpdate       : boolean;
     TempNReq       : CQueryPrimitive;
     nReq           : CQueryPrimitive;
     DataBuf        : array [0..256] of byte;
     IsPackRecieved : boolean;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     procedure   AddGraphParams(DateBeg, DateEnd : TDateTime; parType : integer);
     function    DateTimeForAns(Depth : integer) : TDateTime;
     procedure   RotFloat(const buf1 : PBYTEARRAY; buf2 : PBYTEARRAY);
     function    RotInteger(mas : PBYTEARRAY) : DWORD;
     function    GetDateFromTxMSG : TDateTime;
     procedure   SetFr2To4Tar(par : integer; Date : TDateTime);
     procedure   ReadAutorAns();
     procedure   ReadAllParams();
     procedure   ReadPodTrybHeatAns();
     procedure   ReadPodTrybRasxAns();
     procedure   ReadPodTrybTempAns();
     procedure   ReadPodTrybVAns();
     procedure   ReadObrTrybHeatAns();
     procedure   ReadObrTrybRasxAns();
     procedure   ReadObrTrybTempAns();
     procedure   ReadObrTrybVAns();
     procedure   ReadTempColdWatDayAns();
     procedure   ReadPodTrybRunTimeAns();
     procedure   ReadWorkTimeErrAns();
     procedure   ReadDateTimeAns();
     procedure   CreateAutoReq(var nReq : CQueryPrimitive);
     procedure   CreatePodTrybHeatReq(var nReq : CQueryPrimitive);
     procedure   CreatePodTrybRasxReq(var nReq : CQueryPrimitive);
     procedure   CreatePodTrybTempReq(var nReq : CQueryPrimitive);
     procedure   CreatePodTrybVReq(var nReq : CQueryPrimitive);
     procedure   CreateObrTrybHeatReq(var nReq : CQueryPrimitive);
     procedure   CreateObrTrybRasxReq(var nReq : CQueryPrimitive);
     procedure   CreateObrTrybTempReq(var nReq : CQueryPrimitive);
     procedure   CreateObrTrybVReq(var nReq : CQueryPrimitive);
     procedure   CreateTempColdWatDayReq(var nReq : CQueryPrimitive);
     procedure   CreatePodTrybRunTimeReq(var nReq : CQueryPrimitive);
     procedure   CreateWorkTimeErrReq(var nReq : CQueryPrimitive);
     procedure   CreateDateTimeReq(var nReq : CQueryPrimitive);
     procedure   TestMSG(var pMsg:CMessage);
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   CreateOutMsgHead(len : byte; parType : integer; dt_Date : TDateTime);
     function    CRC(var buf : array of byte; cnt : byte):boolean;
     procedure   KorrTime();
     procedure   SetTime();
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     //procedure   SetGraphParam(dt_Date1, dt_Date2:TDateTime; param : word);override;
    End;
implementation

constructor CVzljotMeter.Create;
Begin
End;

procedure CVzljotMeter.InitMeter(var pL2:SL2TAG);
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
procedure CVzljotMeter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;                 //pMsg.m_sbyInfo
    pMsg.m_swObjID     := m_nP.m_swMID;         //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;           //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ;        //PH_DATARD_REC
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_VZLJOT;           //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CVzljotMeter.CreateOutMsgHead(len : byte; parType : integer; dt_Date : TDateTime);
var year, month, day,
    hour, min, sec, ms : word;
begin
   DecodeDate(dt_Date, Year, Month, Day);
   DecodeTime(dt_Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_swLen      := len;
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_sbyIntID   := 0;
   m_nRxMsg.m_sbyDirID   := Byte(IsUpdate);
   m_nRxMsg.m_sbyInfo[0] := len - 11;
   m_nRxMsg.m_sbyInfo[1] := parType;
   m_nRxMsg.m_sbyInfo[2] := Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := Month;
   m_nRxMsg.m_sbyInfo[4] := Day;
   m_nRxMsg.m_sbyInfo[5] := Hour;
   m_nRxMsg.m_sbyInfo[6] := Min;
   m_nRxMsg.m_sbyInfo[7] := Sec;
   m_nRxMsg.m_sbyInfo[8] := 1;
end;

procedure CVzljotMeter.SetCurrQry;
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

procedure CVzljotMeter.SetGraphQry;
begin
end;

procedure CVzljotMeter.AddGraphParams(DateBeg, DateEnd : TDateTime; parType : integer);
var i, sm        : integer;
    spec1, spec2 : integer;
    TempDate     : TDateTime;
begin
   sm := 0;
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   with m_nObserver.pm_sInil2CmdTbl.LockList do
   try
   for i := 0 to count - 1 do
     if CComm(Items[i]).m_swCmdID = parType then
     begin
       spec1 := CComm(Items[i]).m_swSpecc1;
       spec2 := CComm(Items[i]).m_swSpecc2;
     end;
   TempDate := DateEnd;
   while trunc(Now) <> trunc(TempDate)  do
   begin
     Inc(sm);
     cDateTimeR.IncDate(TempDate);
   end;
   TempDate := DateEnd;
   while trunc(TempDate) >= trunc(DateBeg) do
   begin
     m_nObserver.AddGraphParam(QRY_LOAD_ALL_PARAMS, sm, spec1, spec2, 1);
     Inc(sm);
     cDateTimeR.DecDate(TempDate);
   end;
   finally
    m_nObserver.pm_sInil2CmdTbl.UnLockList;
   End;
end;

function  CVzljotMeter.DateTimeForAns(Depth : integer) : TDateTime;
var i : integer;
begin
   Result := Now;
   for i := 0 to Depth - 1 do
   begin
     cDateTimeR.DecDate(Result);
   end;
end;

procedure CVzljotMeter.RotFloat(const buf1 : PBYTEARRAY; buf2 : PBYTEARRAY);
begin
   buf2[3] := buf1[0];
   buf2[2] := buf1[1];
   buf2[1] := buf1[2];
   buf2[0] := buf1[3];
end;

function  CVzljotMeter.RotInteger(mas : PBYTEARRAY) : DWORD;
var res      : PBYTEARRAY;
    param    : DWORD;
begin
   {res[0] := mas[3];
   res[1] := mas[2];
   res[2] := mas[1];
   res[3] := mas[0];
   move(res, param, 4);
   Result := param;    }
end;

function  CVzljotMeter.GetDateFromTxMSG : TDateTime;
begin
    Result := 0;
    Result := EncodeDate(m_nTxMsg.m_sbyInfo[12] + 2000,  m_nTxMsg.m_sbyInfo[11], m_nTxMsg.m_sbyInfo[10]) +
              EncodeTime(m_nTxMsg.m_sbyInfo[9], m_nTxMsg.m_sbyInfo[8], m_nTxMsg.m_sbyInfo[7], 0);
    Result := Result + 1;
end;

//Spec1 - канал, теплосистема, Spec2 - уточнение
//CreateOutMsgHead(len : byte; parType : integer; dt_Date : TDateTime);  len = 17

procedure CVzljotMeter.ReadAutorAns();
begin
   TraceL(2, m_nP.m_swMID, '(__)CL2MD::> Autorization Complite!');
   FinalAction;
end;

procedure CVzljotMeter.SetFr2To4Tar(par : integer; Date : TDateTime);
var param : Double;
    i     : integer;
begin
   for i := 2 to 4 do
   begin
     param := 0;
     move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
     CreateOutMsgHead(13+4+11, par, Date);
     m_nRxMsg.m_sbyInfo[8] := i;
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;

procedure CVzljotMeter.ReadAllParams();
begin
   ReadPodTrybHeatAns();
   ReadPodTrybRasxAns();
   ReadPodTrybTempAns();
   ReadPodTrybVAns();
   ReadObrTrybHeatAns();
   ReadObrTrybRasxAns();
   ReadObrTrybTempAns();
   ReadObrTrybVAns();
   ReadTempColdWatDayAns();
   ReadPodTrybRunTimeAns();
   ReadWorkTimeErrAns();
end;

procedure CVzljotMeter.ReadPodTrybHeatAns();
var fTemp    : single;
    param    : Double;
    dt_Date  : TDateTime;
begin
   RotFloat(@DataBuf[3 + 4], @fTemp);
   param    := RVLEx(fTemp * 0.2388459, 3);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_POD_TRYB_HEAT, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_POD_TRYB_HEAT, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadPodTrybRasxAns();
var fTemp    : single;
    param    : Double;
    dt_Date  : TDateTime;
begin
   RotFloat(@DataBuf[3 + 150], @fTemp);
   param    := RVLEx(fTemp, 1);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_POD_TRYB_RASX, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_POD_TRYB_RASX, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadPodTrybTempAns();
var param   : Double;
    dt_Date : TDateTime;
begin
   param    := (DataBuf[3 + 154]*$100 + DataBuf[3 + 155])/100;
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_POD_TRYB_TEMP, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_POD_TRYB_TEMP, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadPodTrybVAns();
var li      : DWORD;
    param   : Double;
    dt_Date : TDateTime;
begin
   RotFloat(@DataBuf[3 + 158], @li);
   param    := RVLEx(li / 1000, 1);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_POD_TRYB_V, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_POD_TRYB_V, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadObrTrybHeatAns();
var fTemp    : single;
    param    : Double;
    dt_Date  : TDateTime;
begin
   RotFloat(@DataBuf[3 + 8], @fTemp);
   param    := RVLEx(fTemp*0.2388459, 3);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_OBR_TRYB_HEAT, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_OBR_TRYB_HEAT, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadObrTrybRasxAns();
var fTemp    : single;
    param    : Double;
    dt_Date  : TDateTime;
begin
   RotFloat(@DataBuf[3 + 164], @fTemp);
   param    := RVLEx(fTemp, 1);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_OBR_TRYB_RASX, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_OBR_TRYB_RASX, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadObrTrybTempAns();
var param   : Double;
    dt_Date : TDateTime;
begin
   param    := (DataBuf[3 + 168]*$100 + DataBuf[3 + 169])/100;
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_OBR_TRYB_TEMP, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_OBR_TRYB_TEMP, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadObrTrybVAns();
var li      : DWORD;
    param   : Double;
    dt_Date : TDateTime;
begin
   RotFloat(@DataBuf[3 + 172], @li);
   param    := RVLEx(li / 1000, 1);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_OBR_TRYB_V, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_OBR_TRYB_V, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadTempColdWatDayAns();
var param   : Double;
    dt_Date : TDateTime;
begin
   param    := 4.8;
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_TEMP_COLD_WAT_DAY, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_TEMP_COLD_WAT_DAY, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadPodTrybRunTimeAns();
var ti      : DWORD;
    param   : Double;
    dt_Date : TDateTime;
begin
   RotFloat(@DataBuf[3 + 16], @ti);
   param    := RVLEx(ti / 3600, 2);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_POD_TRYB_RUN_TIME, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_POD_TRYB_RUN_TIME, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadWorkTimeErrAns();
var ti      : DWORD;
    param   : Double;
    dt_Date : TDateTime;
begin
   RotFloat(@DataBuf[3 + 20], @ti);
   param    := RVLEx(ti / 3600, 2);
   dt_Date  := GetDateFromTxMSG;
   move(param, m_nRxMsg.m_sbyInfo[9], sizeof(param));
   CreateOutMsgHead(13+4+11, QRY_WORK_TIME_ERR, dt_Date);
   FPUT(BOX_L3_BY, @m_nRxMsg);
   //SetFr2To4Tar(QRY_WORK_TIME_ERR, dt_Date);
   FinalAction;
end;

procedure CVzljotMeter.ReadDateTimeAns();
begin
   IsPackRecieved := false;
end;

procedure CVzljotMeter.CreateAutoReq(var nReq : CQueryPrimitive);
begin
   TraceL(2, m_nP.m_swMID, '(__)CL2MD::>Vzljot Autoriztion...');
   m_nTxMsg.m_sbyInfo[0]  := $01;
   m_nTxMsg.m_sbyInfo[1]  := $11;
   CRC(m_nTxMsg.m_sbyInfo[0], 2);
   MsgHead(m_nTxMsg, 11 + 4);
end;

procedure CVzljotMeter.CreatePodTrybHeatReq(var nReq : CQueryPrimitive);
var day, month, year   : word;
    TempDate           : TDateTime;
begin
   TempDate               := DateTimeForAns(nReq.m_swSpecc0);
   DecodeDate(TempDate - 1, year, month, day);
   m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[1]  := $41;
   m_nTxMsg.m_sbyInfo[2]  := $00;
   m_nTxMsg.m_sbyInfo[3]  := $02;                //Индекс массива
   m_nTxMsg.m_sbyInfo[4]  := $00;
   m_nTxMsg.m_sbyInfo[5]  := $01;                //Количество запрашиваемых записей
   m_nTxMsg.m_sbyInfo[6]  := $01;                //Тип запроса
   m_nTxMsg.m_sbyInfo[7]  := $00;                //sec
   m_nTxMsg.m_sbyInfo[8]  := $00;                //min
   m_nTxMsg.m_sbyInfo[9]  := $00;                //hour
   m_nTxMsg.m_sbyInfo[10] := day;                //days
   m_nTxMsg.m_sbyInfo[11] := month;              //month
   m_nTxMsg.m_sbyInfo[12] := year - 2000;        //year
   CRC(m_nTxMsg.m_sbyInfo[0], 13);
   MsgHead(m_nTxMsg, 15 + 11);
end;

procedure CVzljotMeter.CreatePodTrybRasxReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreatePodTrybTempReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreatePodTrybVReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateObrTrybHeatReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateObrTrybRasxReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateObrTrybTempReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateObrTrybVReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateTempColdWatDayReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreatePodTrybRunTimeReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateWorkTimeErrReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

procedure CVzljotMeter.CreateDateTimeReq(var nReq : CQueryPrimitive);
begin
   CreatePodTrybHeatReq(nReq);
end;

function CVzljotMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

procedure CVzljotMeter.SetTime();
begin

end;

procedure CVzljotMeter.KorrTime();
begin

end;

procedure CVzljotMeter.TestMSG(var pMsg:CMessage);
var tempStr : string;
    cnt     : integer;
begin
   case nReq.m_swParamID of
     QRY_AUTORIZATION :
       begin
         tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\ForTest.txt', 1);
         EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
         pMsg.m_swLen := cnt + 11;
       end;
     else
       begin
         tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\ForTest.txt', 3);
         EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
         pMsg.m_swLen := cnt + 11;
       end;
   end;
end;

function CVzljotMeter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
Begin
    res := False;
    //Обработчик для L1
    {$ifdef VZLJOT_DEBUG}
       TestMSG(pMsg);
    {$endif}
    if not CRC(pMsg.m_sbyInfo[0], pMsg.m_swLen - 11 - 2) then
    begin
      TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>Vzljot CRC ERROR:');
    end;
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        IsPackRecieved := true;
        move(pMsg.m_sbyInfo[0], DataBuf[0], pMsg.m_swLen - 11);
        TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Vzljot  DIN:',@pMsg);
        case nReq.m_swParamID of
          QRY_AUTORIZATION      : begin ReadAutorAns(); IsPackRecieved := false; end;
          QRY_LOAD_ALL_PARAMS   : ReadAllParams();
          QRY_POD_TRYB_HEAT     : ReadPodTrybHeatAns();         //Расход тепла в подающем трубопроводе
          QRY_POD_TRYB_RASX     : ReadPodTrybRasxAns();         //Расход воды в подающем трубопроводе
          QRY_POD_TRYB_TEMP     : ReadPodTrybTempAns();         //Температура воды в подающем трубопроводе
          QRY_POD_TRYB_V        : ReadPodTrybVAns();
          QRY_OBR_TRYB_HEAT     : ReadObrTrybHeatAns();         //Расход тепла в обратном трубопроводе
          QRY_OBR_TRYB_RASX     : ReadObrTrybRasxAns();         //Расход воды в обратном трубопроводе
          QRY_OBR_TRYB_TEMP     : ReadObrTrybTempAns();         //Температура воды в обратном трубопроводе
          QRY_OBR_TRYB_V        : ReadObrTrybVAns();
          QRY_TEMP_COLD_WAT_DAY : ReadTempColdWatDayAns();      //Температура холодной воды
          QRY_POD_TRYB_RUN_TIME : ReadPodTrybRunTimeAns();      //Время наработки в подающем трубопроводе
          QRY_WORK_TIME_ERR     : ReadWorkTimeErrAns();         //Время работы  каждой ошибкой
          QRY_DATA_TIME         : ReadDateTimeAns();            //Дата-время
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
End;

procedure CVzljotMeter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    wPrecize     : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate       := 1;
    IsPackRecieved := false;
    m_nCounter     := 0;
    m_nCounter1    := 0;
    //FinalAction;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    wPrecize := pDS.m_swData2;
    AddGraphParams(Date1, Date2, param);
end;

function CVzljotMeter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    //nReq         : CQueryPrimitive;
    tempP        : ShortInt;
Begin
    res := False;
    //Обработчик для L3
    m_nRxMsg.m_sbyServerID := 0;
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Vzljot  DRQ:',@pMsg);
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));         //Specc0 - номер канала (теплосистемы)
       if (nReq.m_swSpecc0 <> TempNReq.m_swSpecc0) then
         IsPackRecieved := false;
       if not IsPackRecieved then  //Пакет данных не принят
         case nReq.m_swParamID of
           QM_ENT_MTR_IND        : begin OnEnterAction; exit; end;
           QM_FIN_MTR_IND        : begin OnFinalAction; exit; end;
           QRY_AUTORIZATION      : begin IsPackRecieved := false; CreateAutoReq(nReq); end;
           QRY_LOAD_ALL_PARAMS   : CreatePodTrybHeatReq(nReq);
           QRY_POD_TRYB_HEAT     : CreatePodTrybHeatReq(nReq);         //Расход тепла в подающем трубопроводе
           QRY_POD_TRYB_RASX     : CreatePodTrybRasxReq(nReq);         //Расход воды в подающем трубопроводе
           QRY_POD_TRYB_TEMP     : CreatePodTrybTempReq(nReq);         //Температура воды в подающем трубопроводе
           QRY_POD_TRYB_V        : CreatePodTrybVReq(nReq);
           QRY_OBR_TRYB_HEAT     : CreateObrTrybHeatReq(nReq);         //Расход тепла в обратном трубопроводе
           QRY_OBR_TRYB_RASX     : CreateObrTrybRasxReq(nReq);         //Расход воды в обратном трубопроводе
           QRY_OBR_TRYB_TEMP     : CreateObrTrybTempReq(nReq);         //Температура воды в обратном трубопроводе
           QRY_OBR_TRYB_V        : CreateObrTrybVReq(nReq);
           QRY_TEMP_COLD_WAT_DAY : CreateTempColdWatDayReq(nReq);      //Температура холодной воды
           QRY_POD_TRYB_RUN_TIME : CreatePodTrybRunTimeReq(nReq);      //Время наработки в подающем трубопроводе
           QRY_WORK_TIME_ERR     : CreateWorkTimeErrReq(nReq);         //Время работы  каждой ошибкой
           QRY_DATA_TIME         : CreateDateTimeReq(nReq);            //Дата-время
           else                    begin FinalAction; exit; end;
         end
       else  //Пакет данных уже был принят
         case nReq.m_swParamID of
            QRY_LOAD_ALL_PARAMS   : CreatePodTrybHeatReq(nReq);
            QRY_POD_TRYB_HEAT     : begin ReadPodTrybHeatAns(); exit; end;
            QRY_POD_TRYB_RASX     : begin ReadPodTrybRasxAns(); exit; end;
            QRY_POD_TRYB_TEMP     : begin ReadPodTrybTempAns(); exit; end;
            QRY_POD_TRYB_V        : begin ReadPodTrybVAns(); exit; end;
            QRY_OBR_TRYB_HEAT     : begin ReadObrTrybHeatAns(); exit; end;
            QRY_OBR_TRYB_RASX     : begin ReadObrTrybRasxAns(); exit; end;
            QRY_OBR_TRYB_TEMP     : begin ReadObrTrybTempAns(); exit; end;
            QRY_OBR_TRYB_V        : begin ReadObrTrybVAns(); exit; end;
            QRY_TEMP_COLD_WAT_DAY : begin ReadTempColdWatDayAns(); exit; end;
            QRY_POD_TRYB_RUN_TIME : begin ReadPodTrybRunTimeAns(); exit; end;
            QRY_WORK_TIME_ERR     : begin ReadWorkTimeErrAns(); exit; end;
            QRY_DATA_TIME         : CreateDateTimeReq(nReq);
            else                    begin FinalAction; exit; end;
          end;
       SendOutStat(m_nTxMsg.m_swLen);
       FPUT(BOX_L1 ,@m_nTxMsg);
       m_nRepTimer.OnTimer(m_nP.m_swRepTime);
      End;
      QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;
procedure CVzljotMeter.OnEnterAction;
Begin
    IsPackRecieved := false;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Vzljot OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;
procedure CVzljotMeter.OnFinalAction;
Begin
    IsPackRecieved := false;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Vzljot OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;
procedure CVzljotMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Vzljot OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;
procedure CVzljotMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Vzljot OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;
procedure CVzljotMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>Vzljot OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
    End;
end;

function CVzljotMeter.CRC(var buf : array of byte; cnt : byte):boolean;
var ind          : byte;
    CRCHi, CRCLo : byte;
    i            : integer;
begin
   CRCHi   := $FF;
   CRCLo   := $FF;
   Result  := true;
   for i := 0 to cnt - 1 do
   begin
     ind  := CRCHi xor buf[i];
     CRCHi:= CRCLo xor srCRCHi[ind];
     CRCLo:= srCRCLo[ind];
   end;
   if (buf[cnt] <> CRCHi) or (buf[cnt + 1] <> CRCLo) then
     Result := false;
   buf[cnt]     := CRCHi;
   buf[cnt + 1] := CRCLo;
end;

procedure CVzljotMeter.RunMeter;
Begin

End;

function CVzljotMeter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CVzljotMeter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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
