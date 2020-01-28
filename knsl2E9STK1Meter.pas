{*******************************************************************************
 *  Модуль протокола счетчика Энергия-9 СТК1-10.BU1t
 *  Ukrop
 *  19.12.2011
 ******************************************************************************}

unit knsl2E9STK1Meter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, knsl5tracer, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    CE9STK1Meter = class(CMeter)
    private
        m_QFNC          : BYTE;
        m_QTimestamp    : TDateTime;

        m_ParamID       : BYTE;
        m_Index         : WORD;

        m_LaEnd : WORD; //

        m_IsAuthorized  : Boolean;
        //IsUpdate        : BYTE;

        m_CODER : array[0..3] of BYTE;
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
        function    CMD2ID(_CMDID : BYTE) : BYTE;

        function    CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        procedure   EncodePacket(var _Buffer : array of BYTE);
        procedure   DecompressPacket(var _Buffer : array of BYTE);
        // protocol REQUESTS
        procedure   REQ03_OpenSession(var nReq: CQueryPrimitive);   // Открыть доступ к счетчику
        procedure   RES04_OpenSession_OK(var pMsg:CMessage);        // Связь установлена
        procedure   RES05_OpenSession_Fail(var pMsg:CMessage);      // Доступ закрыт

        procedure   REQ05_CloseSession(var nReq: CQueryPrimitive);  // Закрыть доступ (с подтверждением)
        procedure   RES05_SessionClosed(var pMsg:CMessage);         // Доступ закрыт

        procedure   REQ06_GetDataByID(var nReq: CQueryPrimitive);   // Чтение данных по идентификатору
        procedure   RES06_GetDataByID(var pMsg:CMessage);           // Ответ на запрос
        procedure   RES01_GetDataByID_Fail(var pMsg : CMessage);    // ПРОВАЛ

        procedure   REQ07_GetDateTime(var nReq: CQueryPrimitive);   // Чтение даты/времени
        procedure   RES07_GetDateTime(var pMsg : CMessage);         // ОТвет даты/времени

        procedure   REQ08_SetDateTime(var nReq: CQueryPrimitive);   // Установить дату/время
        procedure   RES00_SetDateTime_OK(var pMsg : CMessage);      // Ответ успешная установка даты/времени        

        procedure   REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);

        procedure   REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);
        procedure   RES0F_GetCurrentPower(var pMsg:CMessage);

        procedure   RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
        procedure   RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);

        // protocol REQUESTS
        procedure   ADD_Energy_Sum_GraphQry(_ParamID : WORD);
        procedure   ADD_RelayState_CTRLQry(_StateID : WORD);
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        procedure   ADD_SresEnergyDay_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
    End;

    // Количество списанных ватт по тарифам
    _poket = packed record
      total : DWORD;        // Всего по тарифу
	    curr_month : DWORD;   // За месяц текущий
	    last_month : DWORD;		// За месяц прошедший
    	CRC : WORD;
    End;

    // График нагрузки за последние MAXLAST
    _last = packed record
      DTSMALL : WORD;   // Дата и время ( укороченный вариант )
	    value   : WORD;   // Мощность (за 15, 30, 45, 60 минут) кратно 1 Wh
    	CRC : WORD;
    End;

const
  E9CTK1_CRCT: array [0..255] of byte = (
        0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
        157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
        35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
        190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
        70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
        219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
        101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
        248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
        140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
        17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
        175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
        50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
        202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
        87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
        233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
        116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
    );
  c_RelayState: array[0..2] of BYTE = ($30, $31, $46);
  c_IntTime: array[0..3] of BYTE = (0, 15, 30, 45);

implementation


{*******************************************************************************
 *
 ******************************************************************************}
constructor CE9STK1Meter.Create;
Begin
  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> E9CTK1 Meter Created');
  m_LaEnd := 0;
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CE9STK1Meter.Destroy;
Begin
    inherited;
End;

procedure CE9STK1Meter.RunMeter; Begin end;

function CE9STK1Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9STK1Meter.InitMeter(var pL2:SL2TAG);
Begin
  IsUpdate := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;

  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>E9CTK    Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;





{*******************************************************************************
 * Обработчик событий нижнего уровня
 ******************************************************************************}
function CE9STK1Meter.LoHandler(var pMsg:CMessage):Boolean;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      TraceM(2,pMsg.m_swObjID,'(__)CE9STK1::>Inp DRQ:',@pMsg);

      if not IsValidMessage(pMsg) then
      begin
        TraceM(2,pMsg.m_swObjID,'(__)CE9STK1::>Error ControlField:',@pMsg);
        Result := false;
        exit;
      end;
      EncodePacket(pMsg.m_sbyInfo);
      { TODO 5 -oUkrop -cFIXME : Функция декомпрессии пакета DecompressPacket(pMsg.m_sbyInfo);}

      case ( (m_QFNC shl 8) OR pMsg.m_sbyInfo[2]) of // FUNCTION
        $0304 : RES04_OpenSession_OK(pMsg);
        $0305 : RES05_OpenSession_Fail(pMsg);
        $0505 : RES05_SessionClosed(pMsg);
        $0606 : RES06_GetDataByID(pMsg);
        $0601 : RES01_GetDataByID_Fail(pMsg);
        $0707 : RES07_GetDateTime(pMsg);       { DONE 3 -oUkrop -cCHECK : Чтение даты/времени }
        $0800 : RES00_SetDateTime_OK(pMsg);    { DONE 3 -oUkrop -cCHECK : Установка даты/времени }
        $0F0F : RES0F_GetCurrentPower(pMsg);
        $0E00 : RES00_CTRL_SetRelayState_OK(pMsg);
        $0E01 : RES01_CTRL_SetRelayState_Fail(pMsg);
        else  FinalAction();
      end;
      if (m_nP.m_sbyStBlock and ST_L2_AUTO_BLOCK) <> 0 then
      begin
        m_nP.m_sbyStBlock := (m_nP.m_sbyStBlock xor ST_L2_AUTO_BLOCK) or ST_L2_NO_AUTO_BLOCK;
        m_pDB.UpdateBlStateMeter(m_nP.m_swMID, m_nP.m_sbyStBlock);
        CreateNoAutoBlockEv();
      end;
    end;
  end;
end;

{*******************************************************************************
 * Обработчик событий верхнего уровня
 ******************************************************************************}
function CE9STK1Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    nReq : CQueryPrimitive;
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
        QRY_ENERGY_SUM_EP,
        QRY_ENERGY_MON_EP :
          REQ06_GetDataByID(nReq);

        QRY_SRES_ENR_EP :
          REQ06_GetDataByID(nReq);

        QRY_DATA_TIME :
          REQ07_GetDateTime(nReq);

        QRY_JRNL_T3 :
          REQ06_GetDataByID(nReq);

        QRY_MGAKT_POW_S :
          REQ0F_GetCurrentPower(nReq);

        QRY_AUTORIZATION :
        begin
          if (not m_IsAuthorized) then
            REQ03_OpenSession(nReq)
          else
            FinalAction();
        end;

        QRY_NULL_COMM :
        begin
          if (m_IsAuthorized) then
            REQ05_CloseSession(nReq)
          else
            FinalAction();
        end;

        QRY_RELAY_CTRL :
          REQ0E_CTRL_SetRelayState(nReq);

        else
          FinalAction();
      end;

      TraceM(2,pMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@pMsg);
//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);

    QL_DATA_CTRL_REQ     : ControlRoutine(pMsg);

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
function  CE9STK1Meter.CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
var
    i, l_Count : integer;
begin
  Result  := 0;
  l_Count := _Buff[1] + 2;

  for i := 1 to l_Count do
    Result := E9CTK1_CRCT[Result XOR _Buff[i]];
end;


{*******************************************************************************
 *  Проверка целостности сообщения
 *      @param var pMsg : CMessage Сообщение
 *      @return Boolean 
 ******************************************************************************}
function CE9STK1Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    l_DataLen : WORD;
begin
    Result := false;
    l_DataLen :=  pMsg.m_sbyInfo[1];
{
    if (pMsg.m_sbyInfo[2] = $06) then
      exit;//l_DataLen := l_DataLen + 2;
}
      
    // контрольная сумма
    if (self.CRC8(pMsg.m_sbyInfo, true) <> pMsg.m_sbyInfo[3 + l_DataLen]) then
    begin
        TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STK1 Ошибка CRC! Выход!');
        exit;
    end;

  Result := true;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9STK1Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_E9CTK1;
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
procedure CE9STK1Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
var
    l_Year, l_Month, l_Day,
    l_Hour, l_Min, l_Second, l_MS : word;
begin
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);
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
            cDateTimeR.IncMonth(m_QTimestamp);
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
            cDateTimeR.IncDate(m_QTimestamp);
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
function CE9STK1Meter.CMD2ID(_CMDID : BYTE) : BYTE;
Begin
  case _CMDID of
    QRY_ENERGY_SUM_EP : Result := 4;  // Ronly	4	POKET	0…7	потреблённая энергия по тарифам	_poket
    QRY_ENERGY_MON_EP : Result := 4;
    QRY_SRES_ENR_EP   : Result := 11; // Ronly	11	LAST	0…719	график нагрузки	_last
    QRY_JRNL_T3       : Result := 16; // Ronly	16	EVENTS	0…4	события	_events
    QRY_MAX_POWER_EP  : Result := 19; // RW	19	PWMAX	0…7	максимальная мощность для каждого тарифа	_pwmax
    QRY_DATA_TIME     : Result := 21; // RW	21	DOPPAR	0	коррекция времени	_doppar
//    QRY_MAX_POWER_EM  : Result := 22; // RW	22	PWTMAX	0…8	время превышения максимальной мощности	_pwtmax
    else
        Result := 1;
    end;
End;


procedure CE9STK1Meter.HandQryRoutine(var pMsg:CMessage);
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
    // !!!!!!!!!!!!!!!!!!!!!!!!!! окончание периода в нуле
    Move(pDS.m_sbyInfo[0],DTE,szDT);
    Move(pDS.m_sbyInfo[szDT],DTS,szDT);

    l_Param := pDS.m_swData1;
    case l_Param of
        QRY_ENERGY_SUM_EP,
        QRY_ENERGY_MON_EP :
          ADD_Energy_Sum_GraphQry(l_Param);

        QRY_SRES_ENR_EP :
          ADD_SresEnergyDay_GraphQry(l_Param, DTS, DTE);

        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;


procedure CE9STK1Meter.ControlRoutine(var pMsg:CMessage);
Var
    l_Param   : WORD;
    l_StateID : DWORD;
    pDS       : CMessageData;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry();
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));


    Move(pDS.m_sbyInfo[0], l_StateID, 4);
    l_Param := pDS.m_swData1;

    case l_Param of
        QRY_RELAY_CTRL :
          ADD_RelayState_CTRLQry(l_StateID);
    end;
end;


procedure CE9STK1Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
    OnFinalAction();
    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CE9STK1 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CE9STK1Meter.OnEnterAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STK1 OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CE9STK1Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STK1 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CE9STK1Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STK1 OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CE9STK1Meter.OnFinalAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STK1 OnFinalAction');
    FinalAction;
end;








procedure   CE9STK1Meter.EncodePacket(var _Buffer : array of BYTE);
var
  l_i : Integer;
begin
  for l_i := 0 to _Buffer[1] do
    _Buffer[l_i + 3] := _Buffer[l_i + 3] XOR m_CODER[l_i AND 3];
end;

{
1.	Если бит 7 байта №2 входного пакета равен 0 - данные не надо распаковывать;
2.	Обнулить бит 7 байта №2 входного пакета;
3.	Прочитать байт повтора (3-й байт водного пакета);
4.	Если байт равен байту повтора прочитать число повторений, байт для повторения и повторить его требуемое число раз;
5.	Установить 1-й байт входного пакета=размеру распакованных данных;
}
procedure   CE9STK1Meter.DecompressPacket(var _Buffer : array of BYTE);
var
  i, j,l : Integer;
  l_rByte : BYTE;
  l_tBuffer : array[0..128] of BYTE;
begin
  exit;
  
  if (_Buffer[2] AND $80)=$80 then
  begin
    l_rByte := _Buffer[3];

    for i := 4 to _Buffer[1] do
    begin
      if (_Buffer[i] = l_rByte) then
      begin
        for l := 0 to _Buffer[i + 1] do
        begin
          l_tBuffer[j] := _Buffer[i+l];
          Inc(j);
        end;
      end else
          l_tBuffer[j] := _Buffer[i];
    end;
  end;
end;























(*******************************************************************************
 * Команда "Открыть доступ к счетчику"
 *   0	  UCHAR	0x7E	Признак начала пакета
 *   1	  UCHAR	0x08	Размер исходных данных
 *   2	  UCHAR	0x03	Команда "Открыть доступ к счетчику"
 *   3	  ULONG	ZNUMBER	Заводской номер счетчика (старший байт по младшему адресу)
 *   7	  ULONG	IDENT	Идентификатор счетчика (старший байт по младшему адресу)
 *   11	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 *   @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CE9STK1Meter.REQ03_OpenSession(var nReq: CQueryPrimitive);
var
  l_FabNum   : DWORD;
  l_Ident    : DWORD;
begin
  m_QFNC       := $03;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
  ZeroMemory(@m_CODER, 4);
  
  // Открыть доступ к счетчику
  m_nTxMsg.m_sbyInfo[0] := $7E; // Признак начала пакета
  m_nTxMsg.m_sbyInfo[1] := $08; // Размер исходных данных
  m_nTxMsg.m_sbyInfo[2] := $03; // Команда "Открыть доступ к счетчику"

  l_FabNum := StrToInt(m_nP.m_sddFabNum); // Заводской номер счетчика (старший байт по младшему адресу)
  m_nTxMsg.m_sbyInfo[3] := (l_FabNum AND $FF000000) shr 24;
  m_nTxMsg.m_sbyInfo[4] := (l_FabNum AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[5] := (l_FabNum AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[6] := (l_FabNum AND $000000FF);

  l_Ident := StrToInt(m_nP.m_sddPHAddres); // Идентификатор счетчика (старший байт по младшему адресу)
  m_nTxMsg.m_sbyInfo[7] := (l_Ident AND $FF000000) shr 24;
  m_nTxMsg.m_sbyInfo[8] := (l_Ident AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[9] := (l_Ident AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[10]:= (l_Ident AND $000000FF);

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 12);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Открыть доступ к счетчику" (таймаут приема до 4-х секунд)
 * Ответ придет только в случае совпадения заводского номера и идентификатора
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x05	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x04	Ответ "Связь установлена"
 *   3	UCHAR	0x01	Версия счетчика
 *   4	UCHAR	RND0	Значение для инициализации CODER[0]
 *   5	UCHAR	RND1	Значение для инициализации CODER[1]
 *   6	UCHAR	RND2	Значение для инициализации CODER[2]
 *   7	UCHAR	RND3	Значение для инициализации CODER[3]
 *   8	UCHAR	SysError	Ошибки системы
 *   9	UCHAR	Tarifnum	Номер текущего тарифа
 *   10	UCHAR	FLAGS	Флаги *
 *   11	UCHAR	CRC8	Контрольная сумма пакета данных
 * В некоторых версия байт FLAGS может отсутствовать
 *
 *   При более 3 попытках открыть доступ с неверным идентификатором, счётчик
 * блокируется не менее чем на 2-ое суток и выдает сообщение - доступ закрыт -
 * в независимости от значения идентификатора при попытке доступа
 *
 *      @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9STK1Meter.RES04_OpenSession_OK(var pMsg:CMessage);
begin
  m_IsAuthorized := true;

  m_CODER[0] := pMsg.m_sbyInfo[4];
  m_CODER[1] := pMsg.m_sbyInfo[5];
  m_CODER[2] := pMsg.m_sbyInfo[6];
  m_CODER[3] := pMsg.m_sbyInfo[7];

  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Сессия открыта. Ошибки системы: ' + IntToStr(pMsg.m_sbyInfo[8]) );
  FinalAction();
end;


(*******************************************************************************
 * Ответ на команду "Открыть доступ к счетчику" (при заблокированном доступе)
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x05	Ответ "Доступ закрыт"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 *   @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9STK1Meter.RES05_OpenSession_Fail(var pMsg:CMessage);
begin
  m_IsAuthorized := false;
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Ошибка: Доступ закрыт!');
  FinalAction();
end;


(*******************************************************************************
 *   Команда "Закрыть доступ к счетчику с подтверждением"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер исходных данных
 *   2	UCHAR	0x05	Команда "Закрыть доступ к счетчику"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 *   @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CE9STK1Meter.REQ05_CloseSession(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $05;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $05;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Закрыть доступ к счетчику с подтверждением"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x05	Ответ "Доступ закрыт"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 * Данная команда при закрытом доступе игнорируется.
 *
 * @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9STK1Meter.RES05_SessionClosed(var pMsg:CMessage);
begin
  m_IsAuthorized := false;

  ZeroMemory(@m_CODER, 4);
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Доступ закрыт по команде!');
  FinalAction();
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
procedure CE9STK1Meter.REQ06_GetDataByID(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $06;
  m_QTimestamp := Now();
  m_ParamID := CMD2ID(nReq.m_swParamID);
  m_Index := nReq.m_swSpecc1;

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $03;
  m_nTxMsg.m_sbyInfo[2] := $06;
  m_nTxMsg.m_sbyInfo[3] := m_ParamID;

  m_nTxMsg.m_sbyInfo[4] := (nReq.m_swSpecc1 shr 8) AND $00FF;
  m_nTxMsg.m_sbyInfo[5] := nReq.m_swSpecc1 AND $00FF;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[6] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 7);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Чтение данных по идентификатору"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	SIZE	Размер ответа после декодирования и декомпрессии (определяется ID запрошенных данных)
 *   2	UCHAR	0x06	Ответ "Данные считаны"
 *   3	VOID[SIZE]	Data	Данные
 *   3+SIZE	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var pMsg : CMessage
 *******************************************************************************)
                            { DONE 5 -oUkrop -cERROR : Реализовать чтение }
procedure CE9STK1Meter.RES06_GetDataByID(var pMsg : CMessage);
var
  s4 : _poket;
  s11: _last;

  l_Yn, l_Mn, l_Dn,
  l_Y, l_M, l_D,
  l_hh, l_mm : WORD;
begin
  case (m_ParamID) of
    4:  // Ronly	4	POKET	0…7	потреблённая энергия по тарифам	_poket
    begin
      m_QTimestamp := Now();
      Move(pMsg.m_sbyInfo[3], s4, sizeof(s4));

      s4.total := EndianSwap(s4.total);
      s4.curr_month := EndianSwap(s4.curr_month);
      s4.last_month := EndianSwap(s4.last_month);
      
      FillSaveDataMessage(s4.total / 1000.0, QRY_ENERGY_SUM_EP, m_Index, true);
      FPUT(BOX_L3, @m_nRxMsg);

      FillSaveDataMessage(s4.curr_month / 1000.0, QRY_ENERGY_MON_EP, m_Index, true);
      FPUT(BOX_L3, @m_nRxMsg);

      cDateTimeR.DecMonth(m_QTimestamp);
      FillSaveDataMessage(s4.last_month / 1000.0, QRY_ENERGY_MON_EP, m_Index, true);
      FPUT(BOX_L3, @m_nRxMsg);
      FinalAction();
    end;
    11: // Ronly	11	LAST	0…719	график нагрузки	_last
    begin
      m_QTimestamp := Now();
      Move(pMsg.m_sbyInfo[3], s11, sizeof(s11));

      s11.DTSMALL := swap(s11.DTSMALL);
      s11.value := swap(s11.value);
      
      FillSaveDataMessage(s11.value * m_nP.m_sfKI * m_nP.m_sfKU, QRY_SRES_ENR_EP,0, true);

      if (s11.DTSMALL=0) then
        FinalAction();
        
      l_M := (s11.DTSMALL shr 12) AND $0F;
      l_D := (s11.DTSMALL shr 7) AND $1F;
      l_hh := (s11.DTSMALL shr 2) AND $1F;
      l_mm := c_IntTime[s11.DTSMALL AND $03];

      try

      m_nRxMsg.m_sbyServerID := l_hh*2 + (l_mm div 30);

      DecodeDate(m_QTimestamp, l_Yn, l_Mn, l_Dn);
      l_Y := l_Yn;
      if (l_M > l_Mn) or ((l_Mn = l_M) and (l_D > l_Dn)) then
        Dec(l_Y);

      Eventbox.FixEvents(ET_NORMAL, '(__)CL2MD::> E9CTK1 Срез:' + DateTimeToStr(EncodeDate(l_Y, l_M, l_D) + EncodeTime(l_hh, l_mm, 0, 0))
      + 'Значение: '+ FloatToStr(s11.value * m_nP.m_sfKI * m_nP.m_sfKU));


      m_nRxMsg.m_sbyInfo[0] := 13+4;
      m_nRxMsg.m_sbyInfo[2] := l_Y - 2000;
      m_nRxMsg.m_sbyInfo[3] := l_M;
      m_nRxMsg.m_sbyInfo[4] := l_D;
      m_nRxMsg.m_sbyInfo[5] := l_hh;
      m_nRxMsg.m_sbyInfo[6] := l_mm;
      m_nRxMsg.m_sbyInfo[7] := 0;
      except
        FinalAction();
      end;
      FinalAction();
    end;
    16: // Ronly	16	EVENTS	0…4	события	_events
    begin
      //
    end;
    19: // RW	19	PWMAX	0…7	максимальная мощность для каждого тарифа	_pwmax
    begin
    end;
    21: // RW	21	DOPPAR	0	коррекция времени	_doppar
    begin
    end;
  end;
//  FinalAction();
end;

(*******************************************************************************
 * Отрицательный ответ
 * на команду "Чтение данных по идентификатору"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x01	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x01	Пакет "Ошибка команды"
 *   3	UCHAR
            	0x01	Ответ "Недопустимый номер ID"
              0x02	Ответ "Недопустимый номер индекса"
              0x04	Ответ "Ошибка CRC блока данных в счетчике"
 *   4	UCHAR	CRC8	Контрольная сумма пакета данных
 * Данная команда при закрытом доступе игнорируется.
 *
 * @param var pMsg : CMessage
 *******************************************************************************)
procedure CE9STK1Meter.RES01_GetDataByID_Fail(var pMsg : CMessage);
var
  l_EStr : String;
begin
  if (pMsg.m_sbyInfo[3] = $01) then
    l_EStr := 'Ошибка команды: Недопустимый номер ID!'
  else if (pMsg.m_sbyInfo[3] = $02) then
    l_EStr := 'Ошибка команды: Недопустимый номер индекса!'
  else if (pMsg.m_sbyInfo[3] = $04) then
    l_EStr := 'Ошибка команды: Ошибка CRC блока данных в счетчике!';

  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::>' + l_EStr);
  FinalAction();
end;


(*******************************************************************************
 * Команда "Чтение времени и даты из счетчика"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер исходных данных
 *   2	UCHAR	0x07	Команда "Чтение времени и даты из счетчика"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CE9STK1Meter.REQ07_GetDateTime(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $07;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $07;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Чтение времени и даты из счетчика"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x08	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x07	Ответ "Чтение времени и даты из счетчика"
 *   3	UCHAR	Sec	Секунды
 *   4	UCHAR	Min	Минуты
 *   5	UCHAR	Hour 	Часы
 *   6	UINT	Week	День недели (0…6, 0-понедельник)
 *   7	UCHAR	Day	Число
 *   8	UCHAR	Month	Месяц
 *   9-10	UCHAR	Year	Год [YearL,YearH]
 *   11	UCHAR	CRC8	Контрольная сумма пакета данных
 *   Данная команда при закрытом доступе игнорируется.
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9STK1Meter.RES07_GetDateTime(var pMsg:CMessage);
var
  l_DT : TDateTime;
  l_ss, l_mm, l_hh,
  l_D, l_M, l_Y : WORD;

  nReq : CQueryPrimitive;
  Time : _SYSTEMTIME;
begin
  l_ss := pMsg.m_sbyInfo[3];
  l_mm := pMsg.m_sbyInfo[4];
  l_hh := pMsg.m_sbyInfo[5];

  l_D  := pMsg.m_sbyInfo[7];
  l_M  := pMsg.m_sbyInfo[8];
  l_Y  := (pMsg.m_sbyInfo[10] * 100) + pMsg.m_sbyInfo[9];

  FillSaveDataMessage(0, 0, 0, false);
  m_nRxMsg.m_sbyInfo[0] := 8;
  m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
  m_nRxMsg.m_sbyInfo[2] := l_Y - 2000; // year
  m_nRxMsg.m_sbyInfo[3] := l_M;        // month
  m_nRxMsg.m_sbyInfo[4] := l_D;        // day
  m_nRxMsg.m_sbyInfo[5] := l_hh;       // hour
  m_nRxMsg.m_sbyInfo[6] := l_mm;       // min
  m_nRxMsg.m_sbyInfo[7] := l_ss;       // sec
  FPUT(BOX_L3, @m_nRxMsg);
    
  l_DT := EncodeDate(l_Y, l_M, l_D) + EncodeTime(l_hh, l_mm, l_ss, 0);
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Время счетчика: ' + DateTimeToStr(l_DT));

  if (abs(now() - l_DT) > EncodeTime(0, 0, 2, 0)) then
  Begin
    if (m_nCF.cbm_sCorrDir.ItemIndex = 1)(* AND (nReq.m_swSpecc0 = 1*) then
    begin
      TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Установка времени в счетчике: ' + DateTimeToStr(Now()));
      REQ08_SetDateTime(nReq);
    end
    else if (m_nCF.cbm_sCorrDir.ItemIndex = 0) then
    begin
      TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Установка времени в АРМ: ' + DateTimeToStr(Date));
      Time.wMilliseconds := 0;
      Time.wSecond    := m_nRxMsg.m_sbyInfo[7];
      Time.wMinute    := m_nRxMsg.m_sbyInfo[6];
      Time.wHour      := m_nRxMsg.m_sbyInfo[5];
      Time.wDay       := m_nRxMsg.m_sbyInfo[4];
      Time.wMonth     := m_nRxMsg.m_sbyInfo[3];
      Time.wYear      := 2000 + m_nRxMsg.m_sbyInfo[2];
      l_DT            := EncodeDate(Time.wYear, Time.wMonth, Time.wDay);
      Time.wDayOfWeek := DayOfWeek(l_DT);
      SetLocalTime(Time);
    end
    else
      FinalAction();
  End
  else
    FinalAction();
end;


(*******************************************************************************
 * Команда "Запись времени и даты в счетчик"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x08	Размер исходных данных
 *   2	UCHAR	0x08	Команда "Запись времени и даты в счетчик"
 *   3	UCHAR	Sec	Секунды
 *   4	UCHAR	Min	Минуты
 *   5	UCHAR	Hour 	Часы
 *   6	UINT	Week	День недели (0…6, 0-понедельник)
 *   7	UCHAR	Day	Число
 *   8	UCHAR	Month	Месяц
 *   9-10	UCHAR	Year	Год [YearL,YearH]
 *   11	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CE9STK1Meter.REQ08_SetDateTime(var nReq: CQueryPrimitive);
var
  l_DT : TDateTime;
  l_ms, l_ss, l_mm, l_hh,
  l_D, l_M, l_Y : WORD;
begin
  m_QFNC       := $08;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
  
  l_DT := Now();
  DecodeTime(l_DT, l_hh, l_mm, l_ss, l_ms);
  DecodeDate(l_DT, l_Y, l_M, l_D);  

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $08;
  m_nTxMsg.m_sbyInfo[2] := $08;

  m_nTxMsg.m_sbyInfo[3] := l_ss;
  m_nTxMsg.m_sbyInfo[4] := l_mm;
  m_nTxMsg.m_sbyInfo[5] := l_hh;
  m_nTxMsg.m_sbyInfo[6] := DayOfWeek(Now());

  m_nTxMsg.m_sbyInfo[7] := l_D;
  m_nTxMsg.m_sbyInfo[8] := l_M;
  m_nTxMsg.m_sbyInfo[9] := l_Y mod 100;
  m_nTxMsg.m_sbyInfo[10]:= l_Y div 100;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 12);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Запись времени и даты в счетчик" (таймаут приема до 4-х секунд)
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x00	Ответ "Операция выполнена успешно"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 * Данная команда при закрытом доступе игнорируется.
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9STK1Meter.RES00_SetDateTime_OK(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Время счетчика установлено: ' + DateTimeToStr(Now()));
  FinalAction();
end;


(*******************************************************************************
 * Команда "Получить текущую мощность"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер исходных данных
 *   2	UCHAR	0x0F	Команда "Получить текущую мощность"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CE9STK1Meter.REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0F;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $0F;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Получить текущую мощность"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x04	Размер исходных данных
 *   2	UCHAR	0x0F	Команда "Получить текущую мощность"
 *   3	ULONG	Power	Текущая мощность
 *   7	UCHAR	CRC8	Контрольная сумма пакета данных
 * Данная команда при закрытом доступе игнорируется
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9STK1Meter.RES0F_GetCurrentPower(var pMsg:CMessage);
var
    l_Value    : Double;
    l_tValue   : DWORD;
begin
  move(pMsg.m_sbyInfo[3], l_tValue, 4); // достаем DWORD

  l_Value := EndianSwap(l_tValue) * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0; // приводим DWORD -> DOUBLE

  m_QTimestamp := Now();
  FillSaveDataMessage(l_Value, QRY_MGAKT_POW_S, 0, true);

  FPUT(BOX_L3, @m_nRxMsg);
  FinalAction();
end;



(*******************************************************************************
 * Включение \ Выключение \ Освобождение контактора :
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x01	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x0E	Команда "Включение \ Выключение \ Освобождение контактора"
 *   3	UCHAR		Команды управления ( значение кода символа):
 *              '0'- принудительное включение контактора
 *              '1'- принудительное отключение контактора
 *              'F'- освобождение контактора
 *   4	UCHAR	CRC8	Контрольная сумма пакета данных
 *   Данная команда при закрытом доступе игнорируется.
 *
 * @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CE9STK1Meter.REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0E;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $01;
  m_nTxMsg.m_sbyInfo[2] := $0E;
  m_nTxMsg.m_sbyInfo[3] := c_RelayState[nReq.m_swSpecc2 AND $03];

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[4] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 5);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STK1::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ на команду "Включение \ Выключение \ Освобождение контактора"
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x00	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x00	Ответ "Операция выполнена успешно"
 *   3	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9STK1Meter.RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Операция с контактором выполнена успешно');
  FinalAction();
end;

(*******************************************************************************
 * Отрицательный ответ при ошибке параметра
 *   0	UCHAR	0x7E	Признак начала пакета
 *   1	UCHAR	0x01	Размер ответа после декодирования и декомпрессии
 *   2	UCHAR	0x01	Пакет "Ошибка команды"
 *   3	UCHAR	0x03	Ответ "Ошибка параметра"
 *   4	UCHAR	CRC8	Контрольная сумма пакета данных
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9STK1Meter.RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STK1::> Операция с контактором НЕ ВЫПОЛНЕНА!');
  FinalAction();
end;


(*******************************************************************************
 * Формирование задания на считывание суммарной потребленной энергии
 ******************************************************************************)
procedure CE9STK1Meter.ADD_Energy_Sum_GraphQry(_ParamID : WORD);
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 1, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 2, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 3, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 4, 0, 1);

  m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;

   
(*******************************************************************************
 * Формирование задания на считывание суммарной потребленной энергии
 ******************************************************************************)
procedure CE9STK1Meter.ADD_RelayState_CTRLQry(_StateID : WORD);
begin
  m_nObserver.ClearCtrlQry();

  m_nObserver.AddCtrlParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddCtrlParam(QRY_RELAY_CTRL, 0, 0, _StateID, 1);
  m_nObserver.AddCtrlParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CE9STK1Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 1, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 2, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 3, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 4, 0, 0, 1);
  
  m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CE9STK1Meter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
    
  m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CE9STK1Meter.ADD_SresEnergyDay_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    i, Srez     : Integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    l_Now       : TDateTime;
begin
  m_nObserver.ClearGraphQry();
  l_Now := Now();

  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  DecodeTime(l_Now, h, m, s, ms);
  if (cDateTimeR.CompareDay(_DTE, l_Now) = 1 ) then
    _DTE := l_Now;

       for i := m_LaEnd to m_LaEnd+47 do
       begin
         m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, m_LaEnd + i, 0, 1);
       end;
      m_LaEnd := m_LaEnd +47;
      m_LaEnd := m_LaEnd mod 719;
       exit;
  i := 0;
  
  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    DecodeDate(_DTE, y, mn, d);
    if cDateTimeR.CompareDay(_DTE, l_Now) = 0 then
    Begin
       for Srez := (h*60 + m) div 30 - 1 downto 0 do
       begin
         m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, i, 0, 1);
         Inc(i);
       end;
    End else
    Begin
      Srez := 0;
      while Srez <= 47 do
      begin
        m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, i, 0, 1);
        Inc(i);
        Inc(Srez);
      end;
    end;
    cDateTimeR.DecDate(_DTE);
  End;
end;

End.
