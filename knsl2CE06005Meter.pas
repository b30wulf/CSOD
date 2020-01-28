{*******************************************************************************
 *  Модуль протокола счетчика БЕМЗ СЭО 6005
 *  Ukrop
 *  05.01.2012
 *
 *    Команды компьютера:
 *  ENQ - 01H - запрос данных.
 *  REC - 03H - принять `установочные данные с TDP.
 *  AUT - 05H - подтверждение аутентичности
 *    Команды счетчика:
 *  DAT: - 02H - положительный ответ на запрос данных.
 *  DRJ: - 0AH - отрицательный ответ на запрос данных:
 *    "	после команды ENQ, когда данные запрошенные компьютером неизвестны.
 *    "	после команды REC, когда установочные данные по каким либо причинам не принимаются.
 *  ECH: - 04H - ответ на команду REC
 *  EOS: - 06H - конечный положительный ответ после AUT команды во время установки,
 *  AEJ: - 0BH - конечный отрицательный ответ после AUT команды во время установки.
 *  
 ******************************************************************************}

unit knsl2CE06005Meter;

interface

uses
    Windows, Classes, SysUtils, SyncObjs, stdctrls, comctrls,
    knsl5config, knsl2meter,
    utldatabase, utltypes, utlbox, utlconst, utlmtimer, utlTimeDate;

type
    CCE06005Meter = class(CMeter)
    private
        m_Address       : Cardinal;
        m_QReq          : CQueryPrimitive;
        m_QTimestamp    : TDateTime;

        m_IsAuthorized  : Boolean;
        IsUpdate        : BYTE;
        dt_TLD          : TDateTime;
        nOldYear        : Word;
        bl_SaveCrEv     : boolean;
        m_QFNC          : Word;
        nReq            : CQueryPrimitive;
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
        procedure   ControlRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        procedure   LongToBCD(_Value : Cardinal;     var _Buff : array of byte; _Count : BYTE);
        procedure   BCDToLong(var _Buff : array of byte; var _Value : Cardinal;     _Count : BYTE);
        function    GetChanInfo(PID : integer): integer;
        function    CRC16B(var _Buff : array of BYTE; _Lenght : BYTE) : Boolean;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; _Length : BYTE);
        procedure   FillMessageHead_0(var pMsg : CHMessage; _Length : BYTE);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        // protocol REQUESTS
        function    GetDateFromID(byType:Byte):TDateTime;
        procedure   REQ_GetData_ENQ(var nReq: CQueryPrimitive);      // Чтение данных по идентификатору
        procedure   RES_GetMonthData(var pMsg:CMessage);             // Ответ данные месяца
        procedure   RES_GetDayData(var pMsg:CMessage);               // Ответ данные месяца
        procedure   RES_GetMeterState(var pMsg:CMessage);            // Ответ дата/время + текущие параметры
        procedure   RES_GetCurrentNetData(var pMsg:CMessage);        // Мгновенные параметры
        procedure   RES_GetJournal(var pMsg:CMessage);               // Журнал
        procedure   RES_GetCurrEnergy(var pMsg:CMessage);            // Ответ дата/время + текущие параметры




        procedure   KorrTime(LastDate : TDateTime);
        //procedure   REQ_SetDateTime();   // Установить дату/время
        procedure RES_SetDateTime(var pMsg:CMessage);

        // protocol REQUESTS
        procedure   ADD_NakEnMonth(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        procedure   ADD_NakEnDay(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        procedure   ADD_CurrentParam();
        procedure   ADD_CurrentNetParam();
        procedure   ADD_Events_GraphQry();
    End;

implementation

{*******************************************************************************
 *
 ******************************************************************************}
constructor CCE06005Meter.Create;
Begin
//  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> CEO6005 Meter Created');
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CCE06005Meter.Destroy;
Begin
    inherited;
End;

procedure CCE06005Meter.RunMeter; Begin end;

function CCE06005Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CCE06005Meter.InitMeter(var pL2:SL2TAG);
Var
    Year, Month, Day : Word;
Begin
    IsUpdate := 0;
    m_IsAuthorized := false;
    m_Address  := StrToIntDef(m_nP.m_sddPHAddres, 0);
    DecodeDate(Now, Year, Month, Day);
    nOldYear := Year;
    SetHandScenario;
    SetHandScenarioGraph;
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Null    Meter Created:'+
//    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
//    ' Rep:'+IntToStr(m_byRep)+
//    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;





{*******************************************************************************
 * Обработчик событий нижнего уровня
 ******************************************************************************}
function CCE06005Meter.LoHandler(var pMsg:CMessage):Boolean;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      //TraceM(2,pMsg.m_swObjID,'(__)CCEO::>Inp DRQ:',@pMsg);
      if not IsValidMessage(pMsg) then
      begin
        //TraceM(2,pMsg.m_swObjID,'(__)CCEO::>Error ControlField:',@pMsg);
        Result := false;
        exit;
      end;
      case (nReq.m_swParamID) of // FUNCTION
        // (DAT=$02) - положительный ответ на запрос данных
        QRY_ENERGY_SUM_EP  : RES_GetCurrEnergy(pMsg);
        QRY_NAK_EN_DAY_EP  : RES_GetDayData(pMsg);
        QRY_NAK_EN_MONTH_EP: RES_GetMonthData(pMsg);
        QRY_DATA_TIME      :
        Begin
         if m_QFNC=0 then RES_GetMeterState(pMsg); // Дата и время  + текущие параметры
         if m_QFNC=1 then RES_SetDateTime(pMsg); // Дата и время  + текущие параметры
        End;
        QRY_MGAKT_POW_A    : RES_GetCurrentNetData(pMsg); // Вольты, Амперы, Мощность(в тысячных Ватта),Герцы, cos Phi
       // else
       // FinalAction();
      end;
    end;
  end;
end;

{*******************************************************************************
 * Обработчик событий верхнего уровня
 ******************************************************************************}
function CCE06005Meter.HiHandler(var pMsg:CMessage):Boolean;
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
        QRY_ENERGY_MON_EP,
        QRY_NAK_EN_MONTH_EP,
        QRY_NAK_EN_DAY_EP,
        QRY_MAX_POWER_EP,
        QRY_ENERGY_SUM_EP,
        QRY_MGAKT_POW_A,
        QRY_JRNL_T3   : REQ_GetData_ENQ(nReq);
        QRY_DATA_TIME : Begin m_QFNC:=0;REQ_GetData_ENQ(nReq);End;
        else
        begin
          nReq.m_swParamID := nReq.m_swSpecc0;
      //    FinalAction();
        end;
      end;
      //TraceM(2,pMsg.m_swObjID,'(__)CCEO::>Out DRQ:',@pMsg);
//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


{*******************************************************************************
 *  Подсчет контрольной суммы
 *      @param var _Buff : array of BYTE
 *      @param _Count : WORD Полная длина сообщения (с контрольной суммой)
 *      @param _SetCRC16 : Boolean
 *      @return Boolean 
 ******************************************************************************}
function  CCE06005Meter.CRC16B(var _Buff : array of BYTE; _Lenght : BYTE) : Boolean;
var
  i, b, F : integer;
  l_CRC     : WORD;
  l_Byte : BYTE;
begin
  l_CRC := 0;
  Result := true;
  
  for i := 0 to _Lenght-1 do
  begin
    l_Byte := _Buff[i];

    for b := 0 to 7 do
    begin
      F := (l_Byte xor l_CRC) and 1;
      l_CRC := l_CRC shr 1;
      l_Byte := l_Byte shr 1;
      if (F > 0) then
        l_CRC := l_CRC xor $A001;
    end;
  end;

  if (l_CRC <> (_Buff[_Lenght] or (_Buff[_Lenght+1] shl 8))) then
    Result := false;

  _Buff[_Lenght]    := l_CRC and $FF;
  _Buff[_Lenght+1]  := (l_CRC shr 8) and $FF;
end;


{*******************************************************************************
 *  Проверка целостности сообщения
 *      @param var pMsg : CMessage Сообщение
 *      @return Boolean 
 ******************************************************************************}
function CCE06005Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    l_DataLen : BYTE;
    l_Addr    : Cardinal;   
begin
    Result := false;
    l_DataLen :=  pMsg.m_sbyInfo[0];

    if (pMsg.m_swLen <> (13 + l_DataLen)) then
    begin
     // TraceL(2, m_nP.m_swMID, '(__)CCEO :> Длина считанного пакета не соответствует переданной.');
      exit;
    end;

    BCDToLong(pMsg.m_sbyInfo[1], l_Addr, 6);
    if (l_Addr <> m_Address) then
    begin                                             
     // TraceL(2, m_nP.m_swMID, '(__)CCEO :> Адреса запроса и ответа различаются.');
      exit;
    end;
      
    // контрольная сумма
    if (not CRC16B(pMsg.m_sbyInfo, l_DataLen - 2)) then
    begin
      //  TraceL(2,m_nP.m_swMID,'(__)CCEO::>CCEO Ошибка CRC! Выход!');
        exit;
    end;

  Result := true;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CCE06005Meter.FillMessageHead(var pMsg : CHMessage; _Length : BYTE);
begin
   pMsg.m_swLen         := _Length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CEO6005;
   pMsg.m_sbyDirID      := IsUpdate;

   pMsg.m_sbyInfo[0]    := _Length;
   LongToBCD(m_Address, pMsg.m_sbyInfo[1], 6);
   LongToBCD(1, pMsg.m_sbyInfo[7], 1);
   SendOutStat(pMsg.m_swLen);
end;
procedure CCE06005Meter.FillMessageHead_0(var pMsg : CHMessage; _Length : BYTE);
begin
   pMsg.m_swLen         := _Length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CEO6005;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;



{*******************************************************************************
 *  Формирование сообщения сохранения данных
 *      @param _Value : double Значение параметра
 *      @param _EType : byte Вид энергии
 *      @param _Tariff : byte Тарифф
 *      @param _WriteDate : Boolean Записывать метку времени
 ******************************************************************************}
procedure CCE06005Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
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
        QRY_MAX_POWER_EP :
        begin
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := 1;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
          end;

        QRY_NAK_EN_DAY_EP :
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


procedure CCE06005Meter.HandQryRoutine(var pMsg:CMessage);
var
  pDS      : CMessageData;
  szDT     : WORD;
  l_Param  : WORD;
  DTS, DTE : TDateTime;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));

    // !!!!!!!!!!!!!!!!!!!!!!!!!! окончание периода в нуле

    Move(pDS.m_sbyInfo[0],DTE,szDT);
    Move(pDS.m_sbyInfo[szDT],DTS,szDT);

    l_Param := pDS.m_swData1;
    case l_Param of
        QRY_NAK_EN_MONTH_EP,
        QRY_MAX_POWER_EP :
          ADD_NakEnMonth(l_Param, DTS, DTE);

//        QRY_ENERGY_DAY_EP,
        QRY_NAK_EN_DAY_EP :
          ADD_NakEnDay(l_Param, DTS, DTE);

        QRY_ENERGY_SUM_EP,
        QRY_DATA_TIME :
        //QRY_SUM_KORR_MONTH
          ADD_CurrentParam();


        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_MGAKT_POW_S,
        QRY_U_PARAM_S,
        QRY_I_PARAM_S,
        QRY_FREQ_NET,
        QRY_ANET_CFI :
          ADD_CurrentNetParam();


        (*
        QRY_ENERGY_DAY_EP, // приращение за день
        QRY_ENERGY_DAY_EM,
        QRY_ENERGY_DAY_RP,
        QRY_ENERGY_DAY_RM :
            ADD_EnergyDay_GraphQry(l_Param, DTS, DTE);

        , // приращение за месяц
        QRY_ENERGY_MON_EM,
        QRY_ENERGY_MON_RP,
        QRY_ENERGY_MON_RM :
            ADD_EnergyMonth_GraphQry(l_Param, DTS, DTE);

        QRY_SRES_ENR_EP, // срезы энергии
        QRY_SRES_ENR_EM,
        QRY_SRES_ENR_RP,
        QRY_SRES_ENR_RM,
        QRY_SRES_ENR_DAY_EP,
        QRY_SRES_ENR_DAY_EM,
        QRY_SRES_ENR_DAY_RP,
        QRY_SRES_ENR_DAY_RM :
            ADD_NakEnMonth(l_Param, DTS, DTE);
        *)
    end;
end;


procedure CCE06005Meter.ControlRoutine(var pMsg:CMessage);
{
Var
    l_Param   : WORD;
    l_StateID : DWORD;
    pDS       : CMessageData;
}
begin
{
    IsUpdate := 1;
    m_nObserver.ClearGraphQry();
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));


    Move(pDS.m_sbyInfo[0], l_StateID, 4);
    l_Param := pDS.m_swData1;


    case l_Param of
        QRY_RELAY_CTRL :
          ADD_RelayState_CTRLQry(l_StateID);
    end;
}
end;


procedure CCE06005Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
    OnFinalAction();
   // TraceM(3,pMsg.m_swObjID,'(__)CL2MD::>C12OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CCE06005Meter.OnEnterAction;
begin
//    TraceL(3,m_nP.m_swMID,'(__)CL2MD::>CCEO OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CCE06005Meter.OnConnectComplette(var pMsg:CMessage);
Begin
   // TraceL(3,m_nP.m_swMID,'(__)CL2MD::>CCEO OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CCE06005Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
   // TraceL(3,m_nP.m_swMID,'(__)CL2MD::>CCEO OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CCE06005Meter.OnFinalAction;
begin
   // TraceL(3,m_nP.m_swMID,'(__)CL2MD::>CCEO OnFinalAction');
    FinalAction;
end;


(*******************************************************************************
 * Команда "Чтение данных по идентификатору"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x03	Размер исходных данных
 *   2	UCHAR	0x06	Команда "Чтение данных по идентификатору"
 *   3	UCHAR	ID	  Идентификатор запрашиваемого поля данных (старший байт по младшему адресу)
 *   4	UINT	Index	Индекс поля данных(старший байт по младшему адресу)
 *   6	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CCE06005Meter.REQ_GetData_ENQ(var nReq: CQueryPrimitive);
var
  Y, M, D : WORD;
  i : Integer;
begin
  m_QTimestamp := Now();
  m_QReq := nReq;
  if (nReq.m_swSpecc0 = 0) then
    GetChanInfo(nReq.m_swParamID);

  DecodeDate(m_QTimestamp, Y, M, D);

  case m_QReq.m_swSpecc1 of
    $08 :
    begin
      if (m_QReq.m_swSpecc2 > 1) then
      begin
        m_QTimestamp := Trunc(m_QTimestamp);
        for i:=1 to m_QReq.m_swSpecc2-1 do
          cDateTimeR.DecMonth(m_QTimestamp);
      end;
    end;
    $06 :
    begin
      if (m_QReq.m_swSpecc2 > 1) then
      begin
        m_QTimestamp := Trunc(m_QTimestamp);
        for i:=1 to m_QReq.m_swSpecc2-1 do
          cDateTimeR.DecDate(m_QTimestamp);
      end;
    end;
  end;

  FillMessageHead(m_nTxMsg, 13);

  m_nTxMsg.m_sbyInfo[8] := 1;
  m_nTxMsg.m_sbyInfo[9] := m_QReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[10] := m_QReq.m_swSpecc2;
  CRC16B(m_nTxMsg.m_sbyInfo, 11);

  SendToL1(BOX_L1, @m_nTxMsg);
 // m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  //TraceM(3, m_nTxMsg.m_swObjID,'(__)CCEO::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Чтение месячных данных"
 * @param var pMsg : CMessage
 *******************************************************************************)
procedure CCE06005Meter.RES_GetMonthData(var pMsg : CMessage);
var
  l_Y, l_M, l_D : WORD;

  i : Integer;
  l_DWValue : DWORD;
  l_WValue  : WORD;
  l_Value   : Double;
begin
  try
  l_Y := (pMsg.m_sbyInfo[42] shl 8) or (pMsg.m_sbyInfo[41]);
  l_M := pMsg.m_sbyInfo[43];
  l_D := pMsg.m_sbyInfo[44];
 // TraceL(2, m_nTxMsg.m_swObjID,'(__)CCEO6005::> Month Y:'+IntToStr(l_Y)+' M:'+IntToStr(l_M)+' D:'+IntToStr(l_D));
  //TraceL(2, m_nP.m_swMID, '(__)CCEO :> Показания на начало месяца на дату ' + Format('%d.%d.%d', [l_Y, l_M, l_D]));
  for i := 0 to 4 do
  begin
    if ((l_Y>3000)or(l_Y=0)or(l_M>12)or(l_M=0)or(l_D>31)or(l_D=0)) then
    m_QTimestamp := GetDateFromID(QRY_NAK_EN_MONTH_EP) else
    ReplaceDate(m_QTimestamp, EncodeDate(l_Y, l_M, 1));
    move(pMsg.m_sbyInfo[11 + 4*i], l_DWValue, 4);
    l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_Value, QRY_NAK_EN_MONTH_EP, (i+1) mod 5, true);
    saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);// запись данных по старой версии программы
  end;
  for i := 0 to 4 do
  begin
    if ((l_Y>3000)or(l_Y=0)or(l_M>12)or(l_M=0)or(l_D>31)or(l_D=0)) then
    m_QTimestamp := GetDateFromID(QRY_NAK_EN_MONTH_EP) else
    ReplaceDate(m_QTimestamp, EncodeDate(l_Y, l_M, l_D));
    move(pMsg.m_sbyInfo[31 + 2*i], l_WValue, 2);
    l_Value := l_WValue * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_Value, QRY_MAX_POWER_EP, (i+1) mod 5, true);
    saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg); запись данных по старой версии программы
  end;

 // FinalAction();
  except

  end
end;
function CCE06005Meter.GetDateFromID(byType:Byte):TDateTime;
Var
   dtDate : TDateTime;
Begin
   dtDate := Now;
   case byType of
        QRY_NAK_EN_DAY_EP   : Result := dtDate-(nReq.m_swSpecc2-1);
        QRY_NAK_EN_MONTH_EP : Result := cDateTimeR.DecMonthEx(nReq.m_swSpecc2-1,dtDate);
   End;
End;




(*******************************************************************************
 * Ответ на команду "Чтение месячных данных"
 * @param var pMsg : CMessage
 *******************************************************************************)
procedure CCE06005Meter.RES_GetDayData(var pMsg : CMessage);
var
  l_Y, l_M, l_D : WORD;
  i : Integer;
  l_DWValue : DWORD;
  l_Value   : Double;
begin
  l_Y := (pMsg.m_sbyInfo[42] shl 8) or (pMsg.m_sbyInfo[41]);
  l_M := pMsg.m_sbyInfo[43];
  l_D := pMsg.m_sbyInfo[44];
 // TraceL(2, m_nTxMsg.m_swObjID,'(__)CCEO6005::> Day Y:'+IntToStr(l_Y)+' M:'+IntToStr(l_M)+' D:'+IntToStr(l_D));
  for i := 0 to 4 do
  begin
  
    if ((l_Y>3000)or(l_Y=0)or(l_M>12)or(l_M=0)or(l_D>31)or(l_D=0)) then
    m_QTimestamp := GetDateFromID(QRY_NAK_EN_DAY_EP) else
    ReplaceDate(m_QTimestamp, EncodeDate(l_Y, l_M, l_D));

    move(pMsg.m_sbyInfo[11 + 4*i], l_DWValue, 4);
    l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_Value, QRY_NAK_EN_DAY_EP, (i+1) mod 5, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
 // FinalAction();
end;


(*******************************************************************************
 * Мгновенные параметры
 * @param var pMsg : CMessage
 *******************************************************************************)
procedure CCE06005Meter.RES_GetCurrentNetData(var pMsg : CMessage);
var
  i : Integer;
  l_DWValue : DWORD;
  l_WValue  : WORD;
  l_Value   : Double;
begin

  move(pMsg.m_sbyInfo[11], l_DWValue, 4);
  l_Value := l_DWValue * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  FillSaveDataMessage(l_Value, QRY_U_PARAM_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[15], l_DWValue, 4);
  l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfMeterKoeff/1000.0;
  FillSaveDataMessage(l_Value, QRY_I_PARAM_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[19], l_DWValue, 4);
  l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff/1000.0;
  FillSaveDataMessage(l_Value, QRY_MGAKT_POW_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[23], l_WValue, 2);
  l_Value := l_WValue / 1000.0;
  FillSaveDataMessage(l_Value, QRY_FREQ_NET, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[27], l_WValue, 2);
  l_Value := cos(l_WValue / 1000.0);
  FillSaveDataMessage(l_Value, QRY_KOEF_POW_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

 // FinalAction();
end;


(*******************************************************************************
 * Журнал
 * @param var pMsg : CMessage
 *******************************************************************************)
procedure CCE06005Meter.RES_GetJournal(var pMsg : CMessage);
var
  i : Integer;
  l_DWValue : DWORD;
  l_WValue  : WORD;
  l_Value   : Double;
begin

  move(pMsg.m_sbyInfo[11], l_DWValue, 4);
  l_Value := l_DWValue * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  FillSaveDataMessage(l_Value, QRY_U_PARAM_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[15], l_DWValue, 4);
  l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfMeterKoeff/1000.0;
  FillSaveDataMessage(l_Value, QRY_I_PARAM_A, 0, true);
  saveToDB(m_nRxMsg);  //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[19], l_DWValue, 4);
  l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff/1000.0;
  FillSaveDataMessage(l_Value, QRY_MGAKT_POW_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[23], l_WValue, 2);
  l_Value := l_WValue / 1000.0;
  FillSaveDataMessage(l_Value, QRY_FREQ_NET, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

  move(pMsg.m_sbyInfo[27], l_WValue, 2);
  l_Value := cos(l_WValue / 1000.0);
  FillSaveDataMessage(l_Value, QRY_KOEF_POW_A, 0, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);

 // FinalAction();
end;
procedure CCE06005Meter.RES_GetCurrEnergy(var pMsg:CMessage);
Var
  l_DWValue : DWORD;
  l_Value   : Double;
  i : Integer;
Begin
  for i := 0 to 4 do
  begin
    move(pMsg.m_sbyInfo[23 + 4*i], l_DWValue, 4);
    l_Value := l_DWValue * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
    FillSaveDataMessage(l_Value, QRY_ENERGY_SUM_EP, (i+1) mod 5, true);
    saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
 // FinalAction();

End;
///////////////////////////////////////////////////////////////////////////
procedure CCE06005Meter.RES_GetMeterState(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;
  LastDate:TDateTime;
begin
    m_QFNC := 0;
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    {
  l_Y  := (pMsg.m_sbyInfo[12] shl 8) or (pMsg.m_sbyInfo[11]);
  l_M  := pMsg.m_sbyInfo[13];
  l_D  := pMsg.m_sbyInfo[14];
  l_hh := pMsg.m_sbyInfo[15];
  l_mm := pMsg.m_sbyInfo[16];
  l_ss := pMsg.m_sbyInfo[17];
    }
    _yy := (pMsg.m_sbyInfo[12] shl 8) or (pMsg.m_sbyInfo[11])-2000;
    _mn := (pMsg.m_sbyInfo[13]);
    _dd := (pMsg.m_sbyInfo[14]);
    _hh := (pMsg.m_sbyInfo[15]);
    _mm := (pMsg.m_sbyInfo[16]);
    _ss := (pMsg.m_sbyInfo[17]);
    if (_mn>12)or(_mn=0)or(_dd>31)or(_dd=0)or(_hh>59)or(_mm>59)or(_ss>59) then
    Begin
  //   FinalAction;
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
        //  FinalAction;
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
procedure CCE06005Meter.KorrTime(LastDate : TDateTime);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec,i     : word;
    sPass : array[0..30] of Byte;
begin
   // TraceL(3,m_nRxMsg.m_swObjID,'(__)CCEO6005::>   Korrection Time');
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
      m_nRxMsg.m_sbyInfo[0] := 13 + 8;
      m_nRxMsg.m_sbyInfo[1] := QRY_LIM_TIME_KORR;
      m_nRxMsg.m_sbyInfo[2] := Year;
      m_nRxMsg.m_sbyInfo[3] := Month;
      m_nRxMsg.m_sbyInfo[4] := Day;
      m_nRxMsg.m_sbyInfo[5] := Hour;
      m_nRxMsg.m_sbyInfo[6] := Min;
      m_nRxMsg.m_sbyInfo[7] := Sec;
      saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);
      FinalAction;
      exit;
    end;
    m_QTimestamp := Now();
    //m_QFNC       := $30;

    DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
    DecodeDate(m_QTimestamp, Year, Month, Day);


    //move('\x23------\x01\x05--------!UPDATE!',m_nTxMsg.m_sbyInfo[0], 25);
    m_nTxMsg.m_sbyInfo[0] := 35;
    LongToBCD(m_Address, m_nTxMsg.m_sbyInfo[1], 6);
    m_nTxMsg.m_sbyInfo[7] := 0;
    m_nTxMsg.m_sbyInfo[8] := 5;
    for i:=0 to 7 do
    Begin
      m_nTxMsg.m_sbyInfo[17 + i] := random(255);
      m_nTxMsg.m_sbyInfo[9 + i] := m_nTxMsg.m_sbyInfo[17 + i];
      m_nTxMsg.m_sbyInfo[9 + i] := m_nTxMsg.m_sbyInfo[9 + i] xor 0;
      m_nTxMsg.m_sbyInfo[9 + i] := m_nTxMsg.m_sbyInfo[9 + i] xor m_nTxMsg.m_sbyInfo[i];
    End;
    m_nTxMsg.m_sbyInfo[25] := $31;
    move(Year,m_nTxMsg.m_sbyInfo[26], 2);
    m_nTxMsg.m_sbyInfo[28] := Month;
    m_nTxMsg.m_sbyInfo[29] := Day;
    m_nTxMsg.m_sbyInfo[30] := Hour;
    m_nTxMsg.m_sbyInfo[31] := Min;
    m_nTxMsg.m_sbyInfo[32] := Sec;

    CRC16B(m_nTxMsg.m_sbyInfo, 33);
    FillMessageHead_0(m_nTxMsg, 35);

    SendToL1(BOX_L1, @m_nTxMsg);
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   // TraceM(2, m_nTxMsg.m_swObjID,'(__)CCEO::>Out DRQ:',@m_nTxMsg);
    m_QFNC := 1;
    if bl_SaveCrEv then
      StartCorrEv(LastDate);
end;
procedure CCE06005Meter.RES_SetDateTime(var pMsg:CMessage);
Var
    byStatus : Byte;
begin
   // TraceL(3, m_nTxMsg.m_swObjID, '(__)CCEO6005::> Время счетчика установлено: ' + DateTimeToStr(Now()));
    m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
    m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
    if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
  //  FinalAction();
    m_QFNC:=0;
end;
///////////////////////////////////////////////////////////////////////////

procedure CCE06005Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 1, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 2, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 3, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 4, 0, 0, 1);
  
  m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CCE06005Meter.ADD_NakEnMonth(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
  Index      : Integer;
  nY, nM, nD : word;
  Y, D, M    : word;
  l_Now      : TDateTime;
begin
  m_nObserver.ClearGraphQry();
  l_Now := Now();

  DecodeDate(l_Now, nY, nM, nD);

  while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
  begin
    DecodeDate(_DTS, Y, M, D);
    {
     0 - текущие
     1 - на текущий месяц
     2 - на предыдущий месяц
    }
    Index := nM - M + 1;
    if (Index < 0) then
      Index := Index  + 12;
      
    m_nObserver.AddGraphParam(_ParamID, _ParamID, 8, Index, 1);
    cDateTimeR.IncMonth(_DTS);
  end;
end;


{*******************************************************************************
 * Формирование задания на считывание показаний на начало суток
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CCE06005Meter.ADD_NakEnDay(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
  Index      : Integer;
  nY, nM, nD : word;
  Y, D, M    : word;
  l_Now      : TDateTime;
begin
  m_nObserver.ClearGraphQry();
  l_Now := Now();

  DecodeDate(l_Now, nY, nM, nD);

  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    DecodeDate(_DTS, Y, M, D);
    {
     0 - текущие
     1 - на текущий месяц
     2 - на предыдущий месяц
    }
    Index := c_DaysOnMonthStart[nM-1] + nD - (c_DaysOnMonthStart[M-1] + D) + 1;
//    if (Index < 0) then
//      Index := Index  + 12;

      
    m_nObserver.AddGraphParam(_ParamID, _ParamID, 6, Index, 1);
    cDateTimeR.IncDate(_DTS);
  end;
end;


{*******************************************************************************
 * Формирование задания на считывание текущих показаний
 ******************************************************************************}
procedure CCE06005Meter.ADD_CurrentParam();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EP, 2, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание текущих показаний
 ******************************************************************************}
procedure CCE06005Meter.ADD_CurrentNetParam();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_MGAKT_POW_S, QRY_MGAKT_POW_S, 4, 0, 1);
end;


{*******************************************************************************
 * Преобразование BCD в длинное целое
 ******************************************************************************}
procedure CCE06005Meter.BCDToLong(var _Buff : array of byte; var _Value : Cardinal; _Count : BYTE);
var
  i : Integer;
  mul : DWORD;
begin
  mul := 1;

  for i := 0 to _Count-1 do
  begin
    _Value := _Value + ((((_Buff[i] shr 4) AND $0F) * mul * 10) + ((_Buff[i] AND $0F) * mul));
    mul := mul * 100;
  end;
end;

{*******************************************************************************
 * Преобразование длинного целого в BCD  
 ******************************************************************************}
procedure CCE06005Meter.LongToBCD(_Value : Cardinal; var _Buff : array of byte; _Count : BYTE);
var
  i : Integer;
begin
   for i := 0 to _Count-1 do
   begin
      _Buff[i] := (_Value mod 10) or (((_Value div 10) mod 10) shl 4);
      _Value := _Value div 100;
   end;

end;


function  CCE06005Meter.GetChanInfo(PID : integer): integer;
var i : integer;
begin
   Result := 0;
   with m_nObserver.pm_sInil2CmdTbl.LockList do
   try
   for i := 0 to count - 1 do
     if CComm(Items[i]).m_swCmdID = PID then
     begin
       Result := 0;//StrToInt(CComm(Items[i]).m_swChannel);
       m_QReq.m_swCmdID  := PID;
       m_QReq.m_swSpecc0 := 0;
       m_QReq.m_swSpecc1 := CComm(Items[i]).m_swSpecc1;
       m_QReq.m_swSpecc2 := CComm(Items[i]).m_swSpecc2;
       exit;
     end;
   finally
     m_nObserver.pm_sInil2CmdTbl.UnLockList;
   end;
end;

End.
