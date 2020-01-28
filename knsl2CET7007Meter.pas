{*******************************************************************************
 *  Модуль протокола счетчика МИРТ1
 *  Ukrop
 *  11.07.2013
 ******************************************************************************}

unit knsl2CET7007Meter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, knsl5tracer, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    SRTRADDR= packed record
      Items : array[0..8] of WORD;
      Count : Word;
    End;
    CCET7007Meter = class(CMeter)
    private
        m_DotPosition : Integer; // положение точки
        m_sAddress    : SRTRADDR;
        m_Password    : DWORD; // пароль счетчика
        m_nRtr        : Byte; //Количество ретрансляторов
        nRSH          : Byte; //Сдвиг
        m_QFNC        : BYTE;
        m_QTimestamp  : TDateTime;

        m_IsAuthorized: Boolean;
        m_SresID      : Byte;
        m_dbDecSeparator : Extended;
        nReq          : CQueryPrimitive;
        dt_TLD        : TDateTime;
        nOldYear      : Word;
        bl_SaveCrEv   : boolean;
    public
        // base
        constructor Create;
        destructor  Destroy; override;
        procedure   InitMeter(var pL2:SL2TAG); override;
        procedure   RunMeter; override;

        // events routing
        function    SelfHandler(var pMsg:CMessage) : Boolean; override;
        function    LoHandler(var pMsg:CMessage) : Boolean; override;
        function    HiHandler(var pMsg:CMessage) : Boolean; override;

        procedure   OnEnterAction();
        procedure   OnFinalAction();
        procedure   OnConnectComplette(var pMsg:CMessage); override;
        procedure   OnDisconnectComplette(var pMsg:CMessage); override;


        procedure   HandQryRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        function    Param2CMD(_ParamID : BYTE) : BYTE;

        function    CRC16(msgs: array of BYTE; len:Integer) : Word;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
        function    FillMessageBody(var _Msg : CHMessage; _FNC,IDp : BYTE;_Len : BYTE):Word;
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        // protocol REQUESTS
        //procedure   REQ01_OpenSession(var nReq: CQueryPrimitive);   // Открыть доступ к счетчику
        //procedure   RES01_OpenSession(var pMsg:CMessage);           // Ответ

        procedure   REQ05_GetEnergySum(var nReq: CQueryPrimitive);
        procedure   RES05_GetEnergySum(var pMsg:CMessage);

        procedure   REQ1C_GetDateTime(var nReq: CQueryPrimitive);   // Чтение даты/времени
        procedure   RES1C_GetDateTime(var pMsg : CMessage);         // Оnвет
        procedure   KorrTime(LastDate : TDateTime);

        //procedure   REQ1D_SetDateTime(var nReq: CQueryPrimitive);
        procedure   RES1D_SetDateTime(var pMsg : CMessage);

        procedure   REQ26_ReadEnergyOn30min(var nReq: CQueryPrimitive);
        procedure   RES26_ReadEnergyOn30min(var pMsg : CMessage);

        procedure   GetEnergy(var pMsg : CMessage;byType:Byte);
        function    GetDateFromID(byType:Byte):TDateTime;

        procedure   REQ24_GetEnergyMonth(var nReq: CQueryPrimitive);
        procedure   RES24_GetEnergyMonth(var pMsg : CMessage);

        procedure   REQ25_GetEnergyDay(var nReq: CQueryPrimitive);
        procedure   RES25_GetEnergyDay(var pMsg : CMessage);

        procedure   REQ_GetNetParam(var nReq: CQueryPrimitive);
        procedure   RES_GetNetParam(var pMsg:CMessage);

        procedure   REQ2D_GetCurrentPower(var nReq: CQueryPrimitive);
        procedure   RES2D_GetCurrentPower(var pMsg:CMessage);

        procedure   REQ2A_GetEvents(var nReq: CQueryPrimitive);
        procedure   RES2A_GetEvents(var pMsg:CMessage);

    /////////////////////////////

        procedure   ADD_Energy_Sum_GraphQry();
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        procedure   ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyMonth_Qry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyDay_Qry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);

    End;


implementation


{*******************************************************************************
 *
 ******************************************************************************}
constructor CCET7007Meter.Create;
Begin
  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> CET7007 Meter Created');
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CCET7007Meter.Destroy;
Begin
    inherited;
End;

procedure CCET7007Meter.RunMeter; Begin end;

function CCET7007Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CCET7007Meter.InitMeter(var pL2:SL2TAG);
Var
  Year, Month, Day : Word;
  str : String;
begin
  //m_nP.m_sddPHAddres := pL2.m_sddPHAddres;
  //m_Password := pL2.m_schPassword;
  IsUpdate := 0;
  m_nRtr   := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CET7007 Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;


{*******************************************************************************
 * Обработчик событий нижнего уровня
 ******************************************************************************}

function CCET7007Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
  nLen : Word;
  nRet : Byte;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      TraceM(2,pMsg.m_swObjID,'(__)CCET7007::>Inp DRQ:',@pMsg);
      if not IsValidMessage(pMsg) then
      begin
        TraceM(2,pMsg.m_swObjID,'(__)CCET7007::>Error BAD Packet:',@pMsg);
        Result := false;
        exit;
      end;
      nRet := pMsg.m_sbyInfo[3];
      case nReq.m_swParamID of
        QRY_ENERGY_SUM_EP   : RES05_GetEnergySum(pMsg);
        QRY_DATA_TIME       :
        Begin
         if nRet=$01 then RES1C_GetDateTime(pMsg);
         if nRet=$31 then RES1D_SetDateTime(pMsg);
        End;
        QRY_NAK_EN_MONTH_EP : RES24_GetEnergyMonth(pMsg);
        QRY_NAK_EN_DAY_EP   : RES25_GetEnergyDay(pMsg);
        QRY_SRES_ENR_EP     : RES26_ReadEnergyOn30min(pMsg);
        QRY_U_PARAM_S       : RES_GetNetParam(pMsg);
        QRY_MGAKT_POW_S     : RES2D_GetCurrentPower(pMsg);
        else  FinalAction();
      end;
    end;
  end;
end;

{*******************************************************************************
 * Обработчик событий верхнего уровня
 ******************************************************************************}
function CCET7007Meter.HiHandler(var pMsg:CMessage):Boolean;
//Var
    //nReq : CQueryPrimitive;
begin
  Result := False;

  m_nRxMsg.m_sbyServerID := 0;
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    Begin
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
      if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
      if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;

      case nReq.m_swParamID of
        //QRY_AUTORIZATION   : REQ01_OpenSession(nReq);
        QRY_ENERGY_SUM_EP  : REQ05_GetEnergySum(nReq);
        QRY_SRES_ENR_EP    : REQ26_ReadEnergyOn30min(nReq);
        QRY_NAK_EN_MONTH_EP: REQ24_GetEnergyMonth(nReq);
        QRY_NAK_EN_DAY_EP  : REQ25_GetEnergyDay(nReq);
        QRY_U_PARAM_S      : REQ_GetNetParam(nReq);
        QRY_DATA_TIME      : REQ1C_GetDateTime(nReq);
        //QRY_JRNL_T3        : REQ2A_GetEvents(nReq);
        QRY_MGAKT_POW_S    : REQ2D_GetCurrentPower(nReq);
      else
          FinalAction();
      end;

      TraceM(2,pMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@pMsg);
//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);

    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


{*******************************************************************************
 *  Подсчет контрольной суммы
 ******************************************************************************}

function CCET7007Meter.CRC16(msgs: array of BYTE; len:Integer) : Word;
var
  CRC:Word;
  bute,cflag,i,j:Byte;
begin
  Result:=0;
  CRC := $0;
  for j:=0 to len-1 do
  begin
   bute:=msgs[j];
    for i:=0 to 7 do
    begin
     cflag:=((bute xor CRC) and $01);
     CRC:=CRC shr 1;
     bute:=bute shr 1;
     if (cflag<>0) then CRC:=CRC xor $A001;
    end;
   end;
  Result:=CRC;
end;


{*******************************************************************************
 *  Проверка целостности сообщения
 *      @param var pMsg : CMessage Сообщение
 *      @return Boolean
 ******************************************************************************}

function CCET7007Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    CRC : Word;
begin
    Result := false;
    move(pMsg.m_sbyInfo[pMsg.m_swLen-13-2],CRC,2);
    if (self.CRC16(pMsg.m_sbyInfo, pMsg.m_swLen-13-2) <> CRC) then
    begin
     TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CCET7007 Ошибка CRC! Выход!');
     exit;
    end;
    Result := true;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CCET7007Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CET7007;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CCET7007Meter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := 13 + 9 + 3;
    pMsg.m_swObjID     := m_nP.m_swMID;
    pMsg.m_sbyFrom     := DIR_L2TOL3;
    pMsg.m_sbyFor      := DIR_L2TOL3;
    pMsg.m_sbyType     := PH_EVENTS_INT;
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_CET7007;
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;

end;



function CCET7007Meter.FillMessageBody(var _Msg : CHMessage; _FNC,IDp : BYTE;_Len : BYTE):Word;
Var
  nLen,wAddr,CRC : Word;
  i: Integer;
begin
  wAddr := StrToInt(m_nP.m_sddPHAddres);
  m_nTxMsg.m_sbyInfo[0] := _Len;    // Признак начала пакета 2by
  m_nTxMsg.m_sbyInfo[1] := LoByte(wAddr);
  m_nTxMsg.m_sbyInfo[2] := HiByte(wAddr);
  m_nTxMsg.m_sbyInfo[3] := _FNC;
  m_nTxMsg.m_sbyInfo[4] := IDp;
  CRC := CRC16(m_nTxMsg.m_sbyInfo,_Len-2);
  m_nTxMsg.m_sbyInfo[_Len-2] := LoByte(CRC);
  m_nTxMsg.m_sbyInfo[_Len-1] := HiByte(CRC);
  Result := _Len;
end;


{*******************************************************************************
 *  Формирование сообщения сохранения данных
 *      @param _Value : double Значение параметра
 *      @param _EType : byte Вид энергии
 *      @param _Tariff : byte Тарифф
 *      @param _WriteDate : Boolean Записывать метку времени
 ******************************************************************************}
procedure CCET7007Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
var
    l_Year, l_Month, l_Day,
    l_Hour, l_Min, l_Second, l_MS : word;
begin
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[1] := _ParamID;
   m_nRxMsg.m_sbyInfo[8] := _Tariff;
   move(_Value, m_nRxMsg.m_sbyInfo[9], sizeof(double));
   m_nRxMsg.m_sbyDirID   := IsUpdate;
   m_nRxMsg.m_sbyServerID:= 0;


   if _WriteDate=false then
        exit;


    case _ParamID of
        QRY_NAK_EN_MONTH_EP,
        QRY_NAK_EN_MONTH_EM,
        QRY_NAK_EN_MONTH_RP,
        QRY_NAK_EN_MONTH_RM :
        begin
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := 1;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
          end;

        QRY_ENERGY_MON_EP,
        QRY_ENERGY_MON_EM,
        QRY_ENERGY_MON_RP,
        QRY_ENERGY_MON_RM :
        begin
            //cDateTimeR.IncMonth(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := 1;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
          end;

        QRY_NAK_EN_DAY_EP,
        QRY_NAK_EN_DAY_EM,
        QRY_NAK_EN_DAY_RP,
        QRY_NAK_EN_DAY_RM,
        QRY_ENERGY_DAY_EP,
        QRY_ENERGY_DAY_EM,
        QRY_ENERGY_DAY_RP,
        QRY_ENERGY_DAY_RM :
        begin
            //cDateTimeR.IncDate(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := l_Day;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
        end;{
       QRY_U_PARAM_S,
       QRY_U_PARAM_A,
       QRY_U_PARAM_B,
       QRY_U_PARAM_C,
       QRY_I_PARAM_S,
       QRY_I_PARAM_A,
       QRY_I_PARAM_B,
       QRY_I_PARAM_C,
       QRY_KOEF_POW_A,
       QRY_KOEF_POW_B,
       QRY_KOEF_POW_C,
       QRY_FREQ_NET :
       begin
        DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
        DecodeTime(m_QTimestamp, l_Hour, l_Min, l_Second, l_MS);
        m_nRxMsg.m_sbyServerID := l_Hour * 2 + (l_Min div 30);
        m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := l_Month;
        m_nRxMsg.m_sbyInfo[4] := l_Day;
        m_nRxMsg.m_sbyInfo[5] := l_Hour;
        m_nRxMsg.m_sbyInfo[6] := l_Min;
        m_nRxMsg.m_sbyInfo[7] := l_Second;
      end;}
    else
        DecodeDate(Now(), l_Year, l_Month, l_Day);
        DecodeTime(Now(), l_Hour, l_Min, l_Second, l_MS);
        m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := l_Month;
        m_nRxMsg.m_sbyInfo[4] := l_Day;
        m_nRxMsg.m_sbyInfo[5] := l_Hour;
        m_nRxMsg.m_sbyInfo[6] := l_Min;
        m_nRxMsg.m_sbyInfo[7] := l_Second;
    end;
end;



{******************************************************************************
 *  Получение номера параметра в протоколе СС301 по ID параметра
 *      @param  _ParamID : Byte
 *      @return Integer
 ******************************************************************************}
function CCET7007Meter.Param2CMD(_ParamID : BYTE) : BYTE;
Begin
  case _ParamID of
    QRY_AUTORIZATION  : Result := $01;
    QRY_DATA_TIME     : Result := $1C;
    QRY_NAK_EN_MONTH_EP : Result := $24;
    QRY_NAK_EN_DAY_EP : Result := $25;
    QRY_SRES_ENR_EP   : Result := $26;
    QRY_JRNL_T3       : Result := $2A;
    QRY_MGAKT_POW_S   : Result := $2D;
    QRY_ENERGY_SUM_EP : Result := $05;
    else
        Result := 1;
    end;
End;


procedure CCET7007Meter.HandQryRoutine(var pMsg:CMessage);
Var
    DTS, DTE : TDateTime;
    l_Param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));

    Move(pDS.m_sbyInfo[0],DTE,szDT);
    Move(pDS.m_sbyInfo[szDT],DTS,szDT);

    l_Param := pDS.m_swData1;
    case l_Param of
      QRY_SRES_ENR_EP :
        ADD_SresEnergyDay_GraphQry(DTS, DTE);

      QRY_NAK_EN_DAY_EP:
        ADD_NakEnergyDay_Qry(DTS, DTE);

      QRY_NAK_EN_MONTH_EP:
        ADD_NakEnergyMonth_Qry(DTS, DTE);

      //  QRY_JRNL_T3 :
      //    ADD_Events_GraphQry();

      //  QRY_DATA_TIME :
      //    ADD_DateTime_Qry();
    end;
end;



procedure CCET7007Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
    OnFinalAction();
    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CCET7007 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CCET7007Meter.OnEnterAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CCET7007 OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CCET7007Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CCET7007 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CCET7007Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CCET7007 OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CCET7007Meter.OnFinalAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CCET7007 OnFinalAction');
    FinalAction;
end;
procedure CCET7007Meter.REQ05_GetEnergySum(var nReq: CQueryPrimitive);
Begin
  m_QTimestamp := Now();
  m_QFNC := $08; // Открыть доступ к счетчику
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,1, 7));
  FPUT(BOX_L1, @m_nTxMsg);
 // m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;
procedure CCET7007Meter.RES05_GetEnergySum(var pMsg:CMessage);
Begin
  GetEnergy(pMsg,QRY_ENERGY_SUM_EP);
  FinalAction();
end;
procedure CCET7007Meter.REQ1C_GetDateTime(var nReq: CQueryPrimitive);
begin
  m_QFNC := $0;
  m_QTimestamp := Now();
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,5, 7));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ "Чтение времени и даты"
 *******************************************************************************)
(*******************************************************************************
 * Ответ "Чтение времени и даты"
 *******************************************************************************)

procedure CCET7007Meter.RES1C_GetDateTime(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;
  LastDate:TDateTime;
begin
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    {
Сек — секунды (0-59)
Мин — минуты (0-59)
Час — часы (0-23)
день недели (1—воскресенье, 2—понедельник ....7-суббота )
Дата — (1-31)
Месяц — (1-12)
Год — (0-254)
    }
    _yy := (pMsg.m_sbyInfo[5+6]);
    _mn := (pMsg.m_sbyInfo[5+5]);
    _dd := (pMsg.m_sbyInfo[5+4]);
    _hh := (pMsg.m_sbyInfo[5+2]);
    _mm := (pMsg.m_sbyInfo[5+1]);
    _ss := (pMsg.m_sbyInfo[5+0]);
    if (_mn>12)or(_mn=0)or(_dd>31)or(_dd=0)or(_hh>59)or(_mm>59)or(_ss>59) then
    Begin
     FinalAction;
     exit;
    End;
    //i:=i+3;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
        //Диапазон корекции счетчика обнуляется при переходе года
        if nOldYear<>Year then
        Begin
         m_nP.m_sdtSumKor :=cDateTimeR.SecToDateTime(0);
         m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
        End;
        nOldYear := Year;
        LastDate := EncodeDate(_yy + 2000, _mn, _dd) + EncodeTime(_hh, _mm, _ss, 0);
        Year := Year - 2000;
        //Установить время системы от синхронизирующего счетчика
        if (m_nP.m_bySynchro=1) then
        Begin
         if m_nMSynchKorr.m_blEnable=False then
         Begin
          m_nMSynchKorr.m_tmTime := LastDate;
          cDateTimeR.KorrTimeToPC(m_nMSynchKorr.m_tmTime,m_nMaxKorrTime);
          FinalAction;
          exit;
         End else m_nMSynchKorr.m_blEnable := False;
        End;
        //Коррекция времени
        nKorrTime :=5;
        if ((m_nIsOneSynchro=1)and(m_nP.m_blOneSynchro=True)) then nKorrTime :=1;
        if (Year <> _yy) or (Month <> _mn) or (Day <> _dd)
        or (Hour <> _hh) or (Min <> _mm) or (abs(_ss - Sec) >= nKorrTime) then
        begin
         //Время счетчика устанавливается всегда либо один раз после коррекции времени системы
         if (m_nIsOneSynchro=0)or((m_nIsOneSynchro=1)and(m_nP.m_blOneSynchro=True)) then
          Begin
          if m_nIsOneSynchro=1 then m_nP.m_blOneSynchro := False;
          {$IFNDEF SS301_DEBUG}
           KorrTime(LastDate);
           {$ELSE}
           FinalAction;
          {$ENDIF}
          End else FinalAction;
         end else FinalAction;
end;
procedure CCET7007Meter.KorrTime(LastDate : TDateTime);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    TraceL(2,m_nRxMsg.m_swObjID,'(__)CCET7007::>   Korrection Time');
    if abs(LastDate - Now) < EncodeTime(0, 0, 1, 0) then
      bl_SaveCrEv := false
    else
      bl_SaveCrEv := true;
    m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    if m_nP.m_sdtSumKor < m_nP.m_sdtLimKor then
    begin
      dt_TLD := LastDate;
      { }
    end;
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then
    begin
      m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
      m_nRxMsg.m_sbyInfo[0] := 1 + 8;
      m_nRxMsg.m_sbyInfo[1] := QRY_LIM_TIME_KORR;
      m_nRxMsg.m_sbyInfo[2] := Year;
      m_nRxMsg.m_sbyInfo[3] := Month;
      m_nRxMsg.m_sbyInfo[4] := Day;
      m_nRxMsg.m_sbyInfo[5] := Hour;
      m_nRxMsg.m_sbyInfo[6] := Min;
      m_nRxMsg.m_sbyInfo[7] := Sec;
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
      FinalAction;
      exit;
    end;
    m_QTimestamp := Now();
    m_QFNC       := $30;

    DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
    DecodeDate(m_QTimestamp, Year, Month, Day);

    // BCD
    m_nTxMsg.m_sbyInfo[5+0] := (Sec);
    m_nTxMsg.m_sbyInfo[5+1] := (Min);
    m_nTxMsg.m_sbyInfo[5+2] := (Hour);
    m_nTxMsg.m_sbyInfo[5+3] := 0;

    m_nTxMsg.m_sbyInfo[5+4] := (Day);
    m_nTxMsg.m_sbyInfo[5+5] := (Month);
    m_nTxMsg.m_sbyInfo[5+6] := (Year - 2000);

    FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,0, 7+7));
    SendToL1(BOX_L1, @m_nTxMsg);
//    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
    if bl_SaveCrEv then
      StartCorrEv(LastDate);
end;
procedure CCET7007Meter.RES1D_SetDateTime(var pMsg:CMessage);
Var
    byStatus : Byte;
begin
    TraceL(3, m_nTxMsg.m_swObjID, '(__)CCET7007::> Время счетчика установлено: ' + DateTimeToStr(Now()));
    m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
    m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
    if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
    FinalAction();
    m_QFNC:=0;
end;

procedure CCET7007Meter.REQ24_GetEnergyMonth(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $04;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,nReq.m_swSpecc2,7));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;
procedure CCET7007Meter.RES24_GetEnergyMonth(var pMsg : CMessage);
begin
   GetEnergy(pMsg,QRY_NAK_EN_MONTH_EP);
   FinalAction();
End;
procedure CCET7007Meter.GetEnergy(var pMsg : CMessage;byType:Byte);
var
   l_Y, l_M, l_D : WORD;
  l_Data   : array[0..5] of Extended;
  Wh : array[0..3] of Byte;
  l_DWData : Dword;
  i : Integer;
begin
  l_Y := pMsg.m_sbyInfo[35]+2000;
  l_M := pMsg.m_sbyInfo[34];
  l_D := pMsg.m_sbyInfo[33];
  TraceL(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Y:'+IntToStr(l_Y)+' M:'+IntToStr(l_M)+' D:'+IntToStr(l_D));

  if ((l_Y>3000)or(l_Y=0)or(l_M>12)or(l_M=0)or(l_D>31)or(l_D=0)) then
  m_QTimestamp := GetDateFromID(byType) else
  Begin
   if byType=QRY_NAK_EN_MONTH_EP then ReplaceDate(m_QTimestamp, EncodeDate(l_Y, l_M, 1)) else
   if byType=QRY_NAK_EN_DAY_EP then ReplaceDate(m_QTimestamp, EncodeDate(l_Y, l_M, l_D));
  End;


  l_Data[0] := 0;
  for i:=1 to 4 do
  begin
   move(pMsg.m_sbyInfo[5+4 + i*4], Wh, 4);
   l_DWData := ((Wh[0] shl 24)+(Wh[1] shl 16)+(Wh[2] shl 8)+Wh[3]);
   l_Data[i] := l_DWData * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
   l_Data[0] := l_Data[0] + l_Data[i];
  end;
  for i:=0 to 4 do
  begin
   FillSaveDataMessage(l_Data[i], byType, i, true);
   saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
End;
function CCET7007Meter.GetDateFromID(byType:Byte):TDateTime;
Var
   dtDate : TDateTime;
Begin
   dtDate := Now;
   case byType of
        QRY_NAK_EN_DAY_EP   : Result := dtDate-nReq.m_swSpecc2;
        QRY_NAK_EN_MONTH_EP : Result := cDateTimeR.DecMonthEx(nReq.m_swSpecc2,dtDate);
   End;
End;

(*******************************************************************************
 * ReadEnergyOnDay
  0x25
  Чтение значений энергии по тарифам и суммарно, сохраненных на конец суток, за прошедшие  90 суток
  3 байта:
    1й байт - день;
    2й байт - месяц;
    3й байт - год.
 *******************************************************************************)
procedure CCET7007Meter.REQ25_GetEnergyDay(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $02;
  //if (nReq.m_swSpecc2=0) then
  //Begin
  // FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,nReq.m_swSpecc2, 7));
  //End else
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,nReq.m_swSpecc2, 7));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;

(*******************************************************************************
 *	25 байт:
 *   1 байт - день;
 *   1 байт - месяц;
 *   1 байт - год;
 *   4 байта - сумма по всем тарифам;
 *   1 байт - конфигурационный байт;
 *   1 байт - коэффициент деления;
 *   16 байт - значения по четырем тарифам (4 байта на тариф начиная с 1го тарифа) на начало необходимого месяца.
 ******************************************************************************)
procedure CCET7007Meter.RES25_GetEnergyDay(var pMsg : CMessage);
Begin
   GetEnergy(pMsg,QRY_NAK_EN_DAY_EP);
   FinalAction();
end;


(*******************************************************************************
 * ReadEnergyOn30min
 * 0x26
 * Чтение получасовых значений энергии за прошедшие  90 суток
 *   4 байт:
 *   1й байт - день;
 *   2й байт - месяц;
 *   3й байт - год;
 *   4й байт - номер части (1-6).
 *   Всего 6 частей по 8 получасов, см. Таблицу 3.
 ******************************************************************************)
procedure   CCET7007Meter.REQ26_ReadEnergyOn30min(var nReq: CQueryPrimitive);
begin
  m_QFNC := $08; // Открыть доступ к счетчику
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,2, 7));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;

procedure   CCET7007Meter.RES26_ReadEnergyOn30min(var pMsg : CMessage);
var
  l_DWData : DWord;
  l_Data : Double;
  l_DivKoeff,
  l_Config : Byte;
  m_SresID,i : Integer;
  Year,Month,Day : Word;
  V : array[0..3] of Byte;
begin
  m_QTimestamp := Now;
  m_SresID := trunc(frac(Now)/EncodeTime(0,30,0,0));
  m_SresID := m_SresID - 1;
  if m_SresID<0 then
  Begin
   m_SresID := 47;
   m_QTimestamp := m_QTimestamp - 1;
  End;
  DecodeDate(m_QTimestamp,Year,Month,Day);

  move(pMsg.m_sbyInfo[5+12], V, 4);
  l_DWData := ((V[0] shl 24)+(V[1] shl 16)+(V[2] shl 8)+V[3]);
  l_Data := l_DWData * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff/2.0;

  //FillSaveDataMessage(0, 0, 0, false);
  m_nRxMsg.m_sbyDirID   := 0;
  m_nRxMsg.m_sbyType    := DL_DATARD_IND;
  m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
  m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
  m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
  m_nRxMsg.m_sbyInfo[1] := QRY_SRES_ENR_EP;
  m_nRxMsg.m_sbyInfo[2] := BYTE(Year-2000);
  m_nRxMsg.m_sbyInfo[3] := BYTE(Month);
  m_nRxMsg.m_sbyInfo[4] := BYTE(Day);
  m_nRxMsg.m_sbyInfo[5] := 0; // H
  m_nRxMsg.m_sbyInfo[6] := 0; // M
  m_nRxMsg.m_sbyInfo[7] := 0; // S
  m_nRxMsg.m_sbyInfo[8] := 0; // HH
  m_nRxMsg.m_sbyServerID := m_SresID;
  move(l_Data, m_nRxMsg.m_sbyInfo[9], sizeof(double));
  saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);

  FinalAction();
end;
(*******************************************************************************
 *
   Чтение  параметров сети
 ******************************************************************************)
procedure CCET7007Meter.REQ_GetNetParam(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $08;
  m_QTimestamp := Now();
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,4, 7));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;
procedure  CCET7007Meter.RES_GetNetParam(var pMsg:CMessage);
Var
   l_dData : Double;
   l_DWData : Dword;
   i : Integer;
   V : array[0..3] of Byte;
Begin
   for i:=0 to 2 do
   Begin
    move(pMsg.m_sbyInfo[5+0+4*i], V, 4);
    l_DWData := ((V[0] shl 24)+(V[1] shl 16)+(V[2] shl 8)+V[3]);
    l_dData := l_DWData * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_dData, QRY_U_PARAM_A+i, 0, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
   for i:=0 to 2 do
   Begin
    move(pMsg.m_sbyInfo[5+12+4*i], V, 4);
    l_DWData := ((V[0] shl 24)+(V[1] shl 16)+(V[2] shl 8)+V[3]);
    l_dData := l_DWData * m_nP.m_sfKI * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_dData, QRY_I_PARAM_A+i, 0, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
   for i:=0 to 2 do
   Begin
    move(pMsg.m_sbyInfo[5+24+4*i], V, 4);
    l_DWData := ((V[0] shl 24)+(V[1] shl 16)+(V[2] shl 8)+V[3]);
    l_dData := cos(l_DWData * m_nP.m_sfMeterKoeff);
    FillSaveDataMessage(l_dData, QRY_KOEF_POW_A+i, 0, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
   move(pMsg.m_sbyInfo[5+36], V, 4);
   l_DWData := ((V[0] shl 24)+(V[1] shl 16)+(V[2] shl 8)+V[3]);
   //l_dData := l_DWData * m_nP.m_sfMeterKoeff;
   l_dData := l_DWData * 0.1;
   FillSaveDataMessage(l_dData, QRY_FREQ_NET, 0, true);
   saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   FinalAction();
End;
(*******************************************************************************
 * ReadPower
	0x2D	Чтение  мощности, усредненной на минутном интервале
 ******************************************************************************)
procedure CCET7007Meter.REQ2D_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $08;
  m_QTimestamp := Now();
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC,7, 7));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ
 5 байт:
3 байта - значение мощности;
1 байт - конфигурационный байт;
1 байт - коэффициент деления.
 *******************************************************************************)
procedure CCET7007Meter.RES2D_GetCurrentPower(var pMsg:CMessage);
var
   l_dData : Double;
   V : array[0..3] of Byte;
   l_DWData : DWord;
   i : Integer;
begin
   for i:=0 to 3 do
   Begin
    move(pMsg.m_sbyInfo[5+0+4*i], V, 4);
    l_DWData := ((V[0] shl 24)+(V[1] shl 16)+(V[2] shl 8)+V[3]);
    l_dData := l_DWData * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_dData, QRY_MGAKT_POW_S+i, 0, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
   FinalAction();
End;


(******************************************************************************
 * Чтение записи из журнала
  2 байта:
    1й байт - тип журнала (см. Таблицу 6),
    число от 0 до 7;
    2й байт - номер части (всего 8 частей),
    число от 0 до 7.
 *)
procedure CCET7007Meter.REQ2A_GetEvents(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $2A;
  m_QTimestamp := Now();

  m_nTxMsg.m_sbyInfo[13+nRSH] := nReq.m_swSpecc0;
  m_nTxMsg.m_sbyInfo[14+nRSH] := nReq.m_swSpecc1;
  //FillMessageBody(m_nTxMsg, $2A, 2);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, $2A,0, 2));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCET7007::>Out DRQ:',@m_nTxMsg);

end;
(******************************************************************************
 * 31 байт:
  30 байт -6 записей журнала по 5 байт каждая.
    Структуру одной записи журнала см. в Таблице 5.
    Расшифровка кодов событий журналов представлена в Таблице 7.
  1 байт - содержит тип журнала и номер части в битовом формате:XAAAXBBB, где:
    AAA - тип журнала;
    BBB - номер части.
 *)
procedure CCET7007Meter.RES2A_GetEvents(var pMsg:CMessage);
var
  l_EvCode,
  l_Y, l_M, l_D, l_hh, l_mm,l_ss,

  lt : WORD;
  i : Integer;
begin
  for i:=0 to 5 do
  begin
    l_Y := (pMsg.m_sbyInfo[13+i*5+nRSH] AND $FE) shr 3;
    l_M := ((pMsg.m_sbyInfo[13+i*5+nRSH] AND $01) shl 3) OR ((pMsg.m_sbyInfo[14+i*5+nRSH] AND $E0) shr 5);
    l_D := pMsg.m_sbyInfo[14+i*5+nRSH] AND $1F;

    l_hh := (pMsg.m_sbyInfo[15+i*5+nRSH] AND $F8) shr 3;
    l_mm := ((pMsg.m_sbyInfo[15+i*5+nRSH] AND $07) shl 3) OR ((pMsg.m_sbyInfo[16+i*5+nRSH] AND $E0) shr 5);
    l_ss := ((pMsg.m_sbyInfo[16+i*5+nRSH] AND $1F) shl 1) OR ((pMsg.m_sbyInfo[17+i*5+nRSH] AND $80) shr 7);

    l_EvCode := pMsg.m_sbyInfo[17+i*5+nRSH] AND $7F;
  end;
end;

(*******************************************************************************
 * Формирование задания на считывание суммарной потребленной энергии
 ******************************************************************************)
procedure CCET7007Meter.ADD_Energy_Sum_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CCET7007Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CCET7007Meter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание
 ******************************************************************************}
procedure CCET7007Meter.ADD_NakEnergyMonth_Qry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,Month,Day : Word;
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
       Inc(i);
       if i > 23 then
         exit;
     end;
     Dec(i);
     cDateTimeR.IncMonth(TempDate);
     DecodeDate(TempDate,Year,Month,Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP,Year-2000,Month,i,1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;
procedure CCET7007Meter.ADD_NakEnergyDay_Qry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,Month,Day : Word;
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
       Inc(i);
       if i > 95 then
         exit;
     end;
     Dec(i);
     cDateTimeR.IncDate(TempDate);
     DecodeDate(dt_Date1,Year,Month,Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, Year-2000,Month,i,  1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

procedure CCET7007Meter.ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CCET7007Meter.ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);

begin
  if (trunc(Now)=trunc(dt_Date1)) then
  Begin
   m_nObserver.ClearGraphQry();
   m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, 0, 0, 1);
  End;
end;

End.
