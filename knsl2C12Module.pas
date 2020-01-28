{*******************************************************************************
 *  Модуль протокола УСПД Гран-Электро С12
 *  Ukrop
 *  25.09.2011
 *  10.10.2011
 *	 25.10.2011
 *  01.11.2011
 ******************************************************************************}

//{$define C12_DEBUG}
              
unit knsl2C12Module;

interface

uses
    Windows, Classes, SysUtils, SyncObjs, stdctrls, comctrls,
    knsl5config, knsl2meter, knsl5tracer,
    utltypes, utlbox, utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    CC12Meter = class(CMeter)
    private
        m_USPDAddress   : BYTE;
        m_TransitAddress: BYTE;
        m_MeterAddress  : BYTE;
        m_QFNC          : BYTE;
        m_QTimestamp    : TDateTime;

        m_PacketID      : Integer;


        tmp_Chid : Integer;
        {
            Параметры последнего отосланного запроса
            @var m_QReq : CQueryPrimitive;
                ParamID     - ID запрашиваемого параметра
                m_swChannel - Если <=0, то производиться прямой запрос к счетчику,
                                Если >0, то это "номер расчетного имерения" С12
                Spec0   - Смещение дня, 0 - текущий, 1 - предыдущий и т.д.
                Spec1   - Окончание периода
                Spec2   - Тариф | Номер среза
        }
        m_QReq          : CQueryPrimitive;

        m_CurrEventID   : DWORD;
        m_QKE           : Single;

        m_IsAuthorized  : Boolean;
        //IsUpdate        : BYTE;
        m_QSliceCounter : BYTE;
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
        procedure   OnConnectComplette(var pMsg:CMessage);
        procedure   OnDisconnectComplette(var pMsg:CMessage);
        
        procedure   HandQryRoutine(var pMsg:CMessage);
        procedure   CreateNormalRequest(_Param : WORD; DTS, DTE : TDateTime);
        procedure   CreateTransitRequest(_Param : WORD; DTS, DTE : TDateTime);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        function    ParamID2SSCMD(_ParamID : Byte) : Byte;
        function    SSCMD2ParamID(_SSCMD : Byte) : Byte;


        function    CRC16(var _Buff : array of BYTE; _Count : WORD; _SetCRC16 : Boolean) : Boolean;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   FillMessageInfo(var _Buffer : array of byte; _Length : word; _FNC : BYTE);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
        function    RI2ParamID(_RI : WORD): WORD;
        function    ParamID2RI(_ParamID : WORD): WORD;

        // protocol REQUESTS
        procedure   REQ2_Transit(var nReq: CQueryPrimitive);
        procedure   REQ84_CloseSession(var nReq: CQueryPrimitive);
        procedure   REQ85_OpenSession(var nReq: CQueryPrimitive);
        procedure   REQ86_Get30MValues(var nReq: CQueryPrimitive);
        procedure   REQ88_SetTime(var nReq: CQueryPrimitive);
        procedure   REQ89_GetTime(var nReq: CQueryPrimitive);
        procedure   REQ90_GetRIValue(var nReq: CQueryPrimitive);
        procedure   REQ92_GetCurrentEventID(var nReq: CQueryPrimitive);
        procedure   REQ93_GetEventByID(var nReq: CQueryPrimitive);
        procedure   REQ94_StartChannelByID(var nReq: CQueryPrimitive);
        procedure   REQ95_StopChannelByID(var nReq: CQueryPrimitive);
        procedure   REQ96_StartRemConnectChannelByID(var nReq: CQueryPrimitive);
        procedure   REQ97_GetSumENByTZTD(var nReq: CQueryPrimitive);
        procedure   REQ98_GetSumENByTZTD_OnPeriod(var nReq: CQueryPrimitive);
        procedure   REQ99_GetRIName(var nReq: CQueryPrimitive);
        procedure   REQ100_GetMaxPByTZTD(var nReq: CQueryPrimitive);
        procedure   REQ101_GetMaxPByTZTD_OnPeriod(var nReq: CQueryPrimitive);
        
        // protocol RESPONSES
        procedure   RES2_Transit(var pMsg:CMessage);
        procedure   RES84_CloseSession(var pMsg:CMessage);
        procedure   RES85_OpenSession(var pMsg:CMessage);
        procedure   RES86_Get30MValues(var pMsg:CMessage);
        procedure   RES88_SetTime(var pMsg:CMessage);
        procedure   RES89_GetTime(var pMsg:CMessage);
        procedure   RES90_GetRIValue(var pMsg:CMessage);
        procedure   RES92_GetCurrentEventID(var pMsg:CMessage);
        procedure   RES93_GetEventByID(var pMsg:CMessage);
        procedure   RES94_StartChannelByID(var pMsg:CMessage);
        procedure   RES95_StopChannelByID(var pMsg:CMessage);
        procedure   RES96_StartRemConnectChannelByID(var pMsg:CMessage);
        procedure   RES97_GetSumENByTZTD(var pMsg:CMessage);
        procedure   RES98_GetSumENByTZTD_OnPeriod(var pMsg:CMessage);
        procedure   RES99_GetRIName(var pMsg:CMessage);
        procedure   RES100_GetMaxPByTZTD(var pMsg:CMessage);
        procedure   RES101_GetMaxPByTZTD_OnPeriod(var pMsg:CMessage);
        procedure   StopComplette(var pMsg:CMessage);

        // protocol REQUESTS
        procedure   ADD_SresEnergyDay_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        procedure   ADD_EnergyDay_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_ChannelsDescro_GraphQry(); // перечень каналов                    
        procedure   ADD_I_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        procedure   ADD_U_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        procedure   ADD_KOEF_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        procedure   ADD_FREQ_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
        
        procedure   ADD_NakEnergyDay_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   Add_NakEnergyMonth_GraphQry(_ParamID :Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_EnergyMonth_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_MaxPowerMonth_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_Events_GraphQry(var pMsg : CMessage);

        procedure   ADD_EnergyDay_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_EnergyMonth_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_SresEnergy_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   ADD_NakEnergyDay_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   Add_NakEnergyMonth_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
        procedure   Add_MaxPower_QryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
//        procedure   ADD_Events_GraphQryT(var pMsg : CMessage);

    End;

const
    srCRCHi:array[0..255] of byte = (
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41,
        $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40);

    srCRCLo:array[0..255] of byte = (
        $00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05, $C5, $C4, $04,
        $CC, $0C, $0D, $CD, $0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09, $08, $C8,
        $D8, $18, $19, $D9, $1B, $DB, $DA, $1A, $1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC,
        $14, $D4, $D5, $15, $D7, $17, $16, $D6, $D2, $12, $13, $D3, $11, $D1, $D0, $10,
        $F0, $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35, $34, $F4,
        $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B, $FB, $39, $F9, $F8, $38,
        $28, $E8, $E9, $29, $EB, $2B, $2A, $EA, $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C,
        $E4, $24, $25, $E5, $27, $E7, $E6, $26, $22, $E2, $E3, $23, $E1, $21, $20, $E0,
        $A0, $60, $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67, $A5, $65, $64, $A4,
        $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB, $69, $A9, $A8, $68,
        $78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C,
        $B4, $74, $75, $B5, $77, $B7, $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0,
        $50, $90, $91, $51, $93, $53, $52, $92, $96, $56, $57, $97, $55, $95, $94, $54,
        $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B, $99, $59, $58, $98,
        $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C,
        $44, $84, $85, $45, $87, $47, $46, $86, $82, $42, $43, $83, $41, $81, $80, $40);


implementation


{*******************************************************************************
 *
 ******************************************************************************}
constructor CC12Meter.Create;
Begin
  tmp_Chid := 0;
  TraceL(2,m_nP.m_swMID,'(__)CL2MD::> C12 Meter Created');
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CC12Meter.Destroy;
Begin
    inherited;
End;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.InitMeter(var pL2:SL2TAG);
var
   l_A : Integer;
Begin
    IsUpdate := 0;
    l_A    := StrToint(m_nP.m_sddPHAddres);
    m_USPDAddress    := l_A div 100000;
    m_TransitAddress := (l_A mod 100000) div 1000;
    m_MeterAddress   := (l_A mod 100000) mod 1000;
    if pL2.m_sbyPortID=29 then
     IsUpdate := 0;
     SetHandScenario;
    SetHandScenarioGraph;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>Null    Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.RunMeter;
Begin

end;


{*******************************************************************************
 *
 ******************************************************************************}
function CC12Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    Result := res;
End;


{*******************************************************************************
 *
 ******************************************************************************}
function CC12Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    l_Result : Boolean;
    l_FNC : Byte;
Begin
    l_Result := true;

    case pMsg.m_sbyType of
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
      PH_DATA_IND:
      Begin
        l_FNC := pMsg.m_sbyInfo[1];
        TraceM(2,pMsg.m_swObjID,'(__)CC12M::>Inp DRQ:',@pMsg);
        if not IsValidMessage(pMsg) then
        begin
           TraceM(2,pMsg.m_swObjID,'(__)C12M::>Error ControlField:',@pMsg);
           //m_nRepTimer.OffTimer();
           //FinalAction;
           Result := false;
           exit;
        end;
        case l_FNC of
           2 : RES2_Transit(pMsg);
          84 : RES84_CloseSession(pMsg);
          85 : RES85_OpenSession(pMsg);
          86 : RES86_Get30MValues(pMsg);
          88 : RES88_SetTime(pMsg);
          89 : RES89_GetTime(pMsg);
          90 : RES90_GetRIValue(pMsg);
          92 : RES92_GetCurrentEventID(pMsg);
          93 : RES93_GetEventByID(pMsg);
          94 : RES94_StartChannelByID(pMsg);
          95 : RES95_StopChannelByID(pMsg);
          96 : RES96_StartRemConnectChannelByID(pMsg);
          97 : RES97_GetSumENByTZTD(pMsg);
          98 : RES98_GetSumENByTZTD_OnPeriod(pMsg);
          99 : RES99_GetRIName(pMsg);
          100: RES100_GetMaxPByTZTD(pMsg);
          101: RES101_GetMaxPByTZTD_OnPeriod(pMsg);
          $FA: Begin StopComplette(pMsg);exit;End;
        end;
        //if l_Result then
          //m_nRepTimer.OffTimer();
      End;
    End;
    Result := l_Result;
End;


{*******************************************************************************
 *
 ******************************************************************************}
function CC12Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    nReq : CQueryPrimitive;
    l_RI : Integer;
begin
    Result := False;
    //Обработчик для L3
    m_nRxMsg.m_sbyServerID := 0;
    case pMsg.m_sbyType of
        QL_DATARD_REQ:
        Begin
            //Сформировать запрос,переслать в L1 и запустить таймер ожидания подтверждения
            Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
            if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
            if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;

            l_RI := ParamID2RI(nReq.m_swParamID);
            if (l_RI <> 0) OR (nReq.m_swParamID = QRY_AUTORIZATION) then
            begin
                case nReq.m_swParamID of
                QRY_ENERGY_DAY_EP,
                QRY_ENERGY_DAY_EM,
                QRY_ENERGY_DAY_RP,
                QRY_ENERGY_DAY_RM :
                  REQ90_GetRIValue(nReq); // REQ97_GetSumENByTZTD(nReq);

                QRY_ENERGY_MON_EP,
                QRY_ENERGY_MON_EM,
                QRY_ENERGY_MON_RP,
                QRY_ENERGY_MON_RM :
                    REQ90_GetRIValue(nReq); // REQ98_GetSumENByTZTD_OnPeriod(nReq);

                QRY_SRES_ENR_EP,
                QRY_SRES_ENR_EM,
                QRY_SRES_ENR_RP,
                QRY_SRES_ENR_RM,{ :
                  REQ90_GetRIValue(nReq);}

                QRY_SRES_ENR_DAY_EP,
                QRY_SRES_ENR_DAY_EM,
                QRY_SRES_ENR_DAY_RP,
                QRY_SRES_ENR_DAY_RM :
                    REQ86_Get30MValues(nReq);

                QRY_NAK_EN_DAY_EP,
                QRY_NAK_EN_DAY_EM,
                QRY_NAK_EN_DAY_RP,
                QRY_NAK_EN_DAY_RM :
                  REQ90_GetRIValue(nReq);

                QRY_NAK_EN_MONTH_EP,
                QRY_NAK_EN_MONTH_EM,
                QRY_NAK_EN_MONTH_RP,
                QRY_NAK_EN_MONTH_RM :
                  REQ90_GetRIValue(nReq);

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
                   REQ86_Get30MValues(nReq);
                  {REQ90_GetRIValue(nReq);}

                QRY_DATA_TIME :
                    REQ89_GetTime(nReq);

                QRY_KPRTEL_KPR :
                    REQ92_GetCurrentEventID(nReq);

                QRY_JRNL_T2 :
                    {REQ99_GetRIName(nReq);//}
		   REQ93_GetEventByID(nReq);

                QRY_MAX_POWER_EP,
                QRY_MAX_POWER_EM,
                QRY_MAX_POWER_RP,
                QRY_MAX_POWER_RM :
                    REQ101_GetMaxPByTZTD_OnPeriod(nReq);

                QRY_END:
                    FinalAction;
                QRY_AUTORIZATION :
                    REQ85_OpenSession(nReq);
                end;
            TraceM(2,pMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@pMsg);
            m_nRepTimer.OnTimer(m_nP.m_swRepTime);
            end
            else
                REQ2_Transit(nReq);
        End;
        QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
        QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
        QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry(pMsg);
    End;
End;


{*******************************************************************************
 *  Подсчет контрольной суммы
 *      @param var _Buff : array of BYTE
 *      @param _Count : WORD Полная длина сообщения (с контрольной суммой)
 *      @param _SetCRC16 : Boolean
 *      @return Boolean
 ******************************************************************************}
function  CC12Meter.CRC16(var _Buff : array of BYTE; _Count : WORD; _SetCRC16 : Boolean) : Boolean;
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


{*******************************************************************************
 *  Проверка целостности сообщения
 *      @param var pMsg : CMessage Сообщение
 *      @return Boolean
 ******************************************************************************}
function CC12Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    res : boolean;
    l_DataLen : WORD;
    l_EStr    : String;
begin
    res := true;
    l_DataLen := pMsg.m_swLen - 11;

    // контрольная сумма
    if not CRC16(pMsg.m_sbyInfo[0], l_DataLen, false) then
    begin
        Result := false;
        TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M CRC Error! Exit!');
        exit; // если корявая CRC то уходим
    end;
    
{$ifndef C12_DEBUG}
    // адрес ответившего успд
    if (pMsg.m_sbyInfo[0] <> 0) then
    begin                      
        //res := false;
        //TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M Address Error! Response from other USPD!');
    end;

    if (pMsg.m_sbyInfo[1] = $FA) then
    begin
      Result := true;
      exit;
    end;
    // номер функции
    if (pMsg.m_sbyInfo[1] <> m_QFNC) then
    begin
        res := false;
        TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M Address Error! Response to other FUNC!');
        Result := false;exit;
    end;
{$endif}

    // код ответа (без транзита)
    if ((pMsg.m_sbyInfo[1] <> $2) AND (pMsg.m_sbyInfo[1] <> $82)) AND (pMsg.m_sbyInfo[2] <> 0) then
    begin
        res := false;
        case pMsg.m_sbyInfo[2] of
            1 : l_EStr := 'Недостачно прав для осуществления операции';
            3 : l_EStr := 'В запросе указано неверное значение параметра';
            4 : l_EStr := 'Пароль неверный';
            5 : l_EStr := 'В УСПД не хранится информация за запрошенную дату';
            6 : l_EStr := 'Ошибка записи значения в архив на сервере';
        end;
        case pMsg.m_sbyInfo[2] of 1,2,3,4,5,6:
             Begin
              TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M CODE ' + IntToStr(pMsg.m_sbyInfo[2]) + ' ' + l_EStr);
              Result := false;exit;
             End;
        End;
    end;

    // код ответа транзита
    if (((pMsg.m_sbyInfo[1] and $7F) = $2)) then
    begin
        if ((pMsg.m_sbyInfo[1] and $80) <> 0) then
        begin
           case pMsg.m_sbyInfo[2] of
            1 : l_EStr := 'Неизвестная функция';
            2 : l_EStr := 'Неизвестный параметр';
            3 : l_EStr := 'Ошибочный аргумент';
            4 : l_EStr := 'Несанкционированный доступ';
            5 : l_EStr := 'Блок поврежден';
            6 : l_EStr := 'Ошибка памяти';
            7 : l_EStr := 'Счетчик занят';
           end;
           TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M Error CODE ' + IntToStr(pMsg.m_sbyInfo[2]) + ' ' + l_EStr);
           Result := false;
           exit;
        end;

        move(pMsg.m_sbyInfo[2], l_DataLen, 2);
        if (l_DataLen < 11) OR (l_DataLen > (pMsg.m_swLen - 11)) then
        begin
           TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M To Short Answer');
           res := false;
           exit;
        end;

        if (pMsg.m_sbyInfo[7] <> 0) then
        begin
           TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M EXIT: Result Answer BAD: '+ IntToStr(pMsg.m_sbyInfo[7]));
           Result := false;
           case pMsg.m_sbyInfo[7] of
            1 : l_EStr := 'Недостачно прав для осуществления операции';
            3 : l_EStr := 'В запросе указано неверное значение параметра';
            4 : l_EStr := 'Пароль неверный';
            5 : l_EStr := 'В УСПД не хранится информация за запрошенную дату';
            6 : l_EStr := 'Ошибка записи значения в архив на сервере';
           end;
           TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M CODE ' + IntToStr(pMsg.m_sbyInfo[2]) + ' ' + l_EStr);
           Result := false;
           exit;
        end;

        case pMsg.m_sbyInfo[11] of
            1 : l_EStr := 'Неизвестная функция';
            2 : l_EStr := 'Неизвестный параметр';
            3 : l_EStr := 'Ошибочный аргумент';
            4 : l_EStr := 'Несанкционированный доступ';
            5 : l_EStr := 'Блок поврежден';
            6 : l_EStr := 'Ошибка памяти';
            7 : l_EStr := 'Счетчик занят';               
        end;
        case pMsg.m_sbyInfo[11] of 1,2,3,4,5,6,7:
             Begin TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CC12M CODE ' + IntToStr(pMsg.m_sbyInfo[2]) + ' ' + l_EStr);Result := false;exit;End;
        End;
    end;

   Result := res;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_C12TOL1;
   pMsg.m_sbyFor        := DIR_C12TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := HIP_C12;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
   pMsg.m_sbyServerID   := 0;
end;


{*******************************************************************************
 *  Формирование запроса
 *      @param var _Buffer : array of byte
 *      @param _Length : word Полная длина запроса
 *      @param _FNC : word Функция
 ******************************************************************************}
procedure CC12Meter.FillMessageInfo(var _Buffer : array of byte; _Length : word; _FNC : BYTE);
begin
    _Buffer[0]          := m_USPDAddress;
    _Buffer[1]          := _FNC;

    if (_FNC = 2) then
        _Buffer[0]          := m_TransitAddress;

   CRC16(_Buffer, _Length, true);
end;


{*******************************************************************************
 *  Формирование сообщения сохранения данных
 *      @param _Value : double Значение параметра
 *      @param _EType : byte Вид энергии
 *      @param _Tariff : byte Тарифф
 *      @param _WriteDate : Boolean Записывать метку времени
 ******************************************************************************}
procedure CC12Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
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


    case m_QReq.m_swParamID of
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
function CC12Meter.ParamID2SSCMD(_ParamID : Byte) : Byte;
Begin
    case _ParamID of
        QRY_NULL_COMM      :   Result := 0;// = 0

        QRY_ENERGY_SUM_EP,
        QRY_ENERGY_SUM_EM,
        QRY_ENERGY_SUM_RP,
        QRY_ENERGY_SUM_RM  :   Result := 1;//= 4;

        QRY_ENERGY_DAY_EP,
        QRY_ENERGY_DAY_EM,
        QRY_ENERGY_DAY_RP,
        QRY_ENERGY_DAY_RM  :   Result := 2;//= 8;

        QRY_ENERGY_MON_EP,
        QRY_ENERGY_MON_EM,
        QRY_ENERGY_MON_RP,
        QRY_ENERGY_MON_RM  :   Result := 3;//= 12;

        QRY_E3MIN_POW_EP,
        QRY_E3MIN_POW_EM,
        QRY_E3MIN_POW_RP,
        QRY_E3MIN_POW_RM   :   Result := 5;//= 32;

        QRY_E30MIN_POW_EP,
        QRY_E30MIN_POW_EM,
        QRY_E30MIN_POW_RP,
        QRY_E30MIN_POW_RM  :   Result := 6;//= 36;

        QRY_MAX_POWER_EP,
        QRY_MAX_POWER_EM,
        QRY_MAX_POWER_RP,
        QRY_MAX_POWER_RM   :   Result := 7;

        QRY_MGAKT_POW_S,
        QRY_MGAKT_POW_A,
        QRY_MGAKT_POW_B,
        QRY_MGAKT_POW_C    :   Result := 8;//= 40;

        QRY_MGREA_POW_S,
        QRY_MGREA_POW_A,
        QRY_MGREA_POW_B,
        QRY_MGREA_POW_C    :   Result := 9;//= 44;

        QRY_U_PARAM_A,
        QRY_U_PARAM_B,
        QRY_U_PARAM_C      :   Result := 10;//= 47;

        QRY_I_PARAM_A,
        QRY_I_PARAM_B,
        QRY_I_PARAM_C      :   Result := 11;//= 50;

        QRY_KOEF_POW_A,
        QRY_KOEF_POW_B,
        QRY_KOEF_POW_C     :   Result := 12;//= 53;

        QRY_FREQ_NET       :   Result := 13;//= 54;//13

        QRY_JRNL_T1        :   Result := 14;

        QRY_JRNL_T2        :   Result := 15;
        
        QRY_JRNL_T3        :   Result := 16;

        QRY_KPRTEL_KPR     :   Result := 24;//= 55;//24
        QRY_KPRTEL_KE      :   Result := 24;//= 55;//24

        QRY_DATA_TIME      :   Result := 32;//= 57;//

        QRY_SRES_ENR_EP,
        QRY_SRES_ENR_EM,
        QRY_SRES_ENR_RP,
        QRY_SRES_ENR_RM    :   Result := 36;

        QRY_NAK_EN_DAY_EP,
        QRY_NAK_EN_DAY_EM,
        QRY_NAK_EN_DAY_RP,
        QRY_NAK_EN_DAY_RM  :   Result := 42;//= 20;

        QRY_NAK_EN_MONTH_EP,
        QRY_NAK_EN_MONTH_EM,
        QRY_NAK_EN_MONTH_RP,
        QRY_NAK_EN_MONTH_RM:   Result := 43;//= 24;
    else
        Result := Byte(-1);
    end;
End;


{******************************************************************************
 *  Получение ID параметра по номеру параметра в протоколе СС301 
 *      @param  _SSCMD : Byte
 *      @return Integer
 ******************************************************************************}
function CC12Meter.SSCMD2ParamID(_SSCMD : Byte) : Byte;
Begin
    case _SSCMD of
        1     : Result := QRY_ENERGY_SUM_EP;
        2     : Result := QRY_ENERGY_DAY_EP;
        3     : Result := QRY_ENERGY_MON_EP;
//      4     : Result := QRY_ENERGY_YEAR_EP;
        5     : Result := QRY_E3MIN_POW_EP;
        6     : Result := QRY_E30MIN_POW_EP;
        7     : Result := QRY_MAX_POWER_EP;
        8     : Result := QRY_MGAKT_POW_S;
        9     : Result := QRY_MGREA_POW_S;
        10    : Result := QRY_U_PARAM_A;
        11    : Result := QRY_I_PARAM_A;
        12    : Result := QRY_KOEF_POW_A;
        13    : Result := QRY_FREQ_NET;
        14    : Result := QRY_JRNL_T1;
        15    : Result := QRY_JRNL_T2;
        16    : Result := QRY_JRNL_T3;
        24    : Result := QRY_KPRTEL_KE;
        32    : Result := QRY_DATA_TIME;
        36, 40: Result := QRY_SRES_ENR_EP;
        42    : Result := QRY_NAK_EN_DAY_EP;
        43    : Result := QRY_NAK_EN_MONTH_EP;
    else
        Result := Byte(-1);
    end;
End;


procedure CC12Meter.HandQryRoutine(var pMsg:CMessage);
Var
    DTS, DTE : TDateTime;
    param        : word;
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

    param := pDS.m_swData1;
    if (ParamID2RI(param) > 0) then
        CreateNormalRequest(param, DTS, DTE)
    else
        CreateTransitRequest(param, DTS, DTE);
end;


{*******************************************************************************
 *  Запросы к УСПД
 *      @param ...Ы)
 ******************************************************************************}
procedure CC12Meter.CreateNormalRequest(_Param : WORD; DTS, DTE : TDateTime);
begin
    case _Param of
        QRY_ENERGY_DAY_EP, // приращение за день
        QRY_ENERGY_DAY_EM,
        QRY_ENERGY_DAY_RP,
        QRY_ENERGY_DAY_RM :
            ADD_EnergyDay_GraphQry(_Param, DTS, DTE);

        QRY_ENERGY_MON_EP, // приращение за месяц
        QRY_ENERGY_MON_EM,
        QRY_ENERGY_MON_RP,
        QRY_ENERGY_MON_RM :
            ADD_EnergyMonth_GraphQry(_Param, DTS, DTE);

        QRY_SRES_ENR_EP, // срезы энергии
        QRY_SRES_ENR_EM,
        QRY_SRES_ENR_RP,
        QRY_SRES_ENR_RM,
        QRY_SRES_ENR_DAY_EP,
        QRY_SRES_ENR_DAY_EM,
        QRY_SRES_ENR_DAY_RP,
        QRY_SRES_ENR_DAY_RM :
            ADD_SresEnergyDay_GraphQry(_Param, DTS, DTE);

        QRY_NAK_EN_DAY_EP, // накопленная на начало дня
        QRY_NAK_EN_DAY_EM,
        QRY_NAK_EN_DAY_RP,
        QRY_NAK_EN_DAY_RM :
            ADD_NakEnergyDay_GraphQry(_Param, DTS, DTE);
        QRY_NAK_EN_MONTH_EP,
        QRY_NAK_EN_MONTH_EM,
        QRY_NAK_EN_MONTH_RP,
        QRY_NAK_EN_MONTH_RM :
            Add_NakEnergyMonth_GraphQry(_Param, DTS, DTE);

        QRY_MAX_POWER_EP, // максимальная мощность в месяце
        QRY_MAX_POWER_EM,
        QRY_MAX_POWER_RP,
        QRY_MAX_POWER_RM :
            ADD_MaxPowerMonth_GraphQry(_Param, DTS, DTE);


        QRY_U_PARAM_S,
        QRY_U_PARAM_A,
        QRY_U_PARAM_B,
        QRY_U_PARAM_C :
            ADD_U_GraphQry(_Param, DTS, DTE);

        QRY_I_PARAM_S,
        QRY_I_PARAM_A,
        QRY_I_PARAM_B,
        QRY_I_PARAM_C :
            ADD_I_GraphQry(_Param, DTS, DTE);
{
        QRY_Phi_PARAM_S,
        QRY_Phi_PARAM_A,
        QRY_Phi_PARAM_B,
        QRY_Phi_PARAM_C :
            ADD_Phi_GraphQry(_Param, _DTS, _DTE);    }

        QRY_KOEF_POW_A,
        QRY_KOEF_POW_B,
        QRY_KOEF_POW_C :
            ADD_KOEF_GraphQry(_Param, DTS, DTE);

        QRY_FREQ_NET :
            ADD_FREQ_GraphQry(_Param, DTS, DTE);

        QRY_JRNL_T2:
         ADD_ChannelsDescro_GraphQry();
         
        QRY_LOAD_ALL_PARAMS :
        begin
            ADD_EnergyDay_GraphQry(QRY_ENERGY_DAY_EP, DTS, DTE);
            ADD_EnergyDay_GraphQry(QRY_ENERGY_DAY_EM, DTS, DTE);
            ADD_EnergyDay_GraphQry(QRY_ENERGY_DAY_RP, DTS, DTE);
            ADD_EnergyDay_GraphQry(QRY_ENERGY_DAY_RM, DTS, DTE);

            ADD_NakEnergyDay_GraphQry(QRY_NAK_EN_DAY_EP, DTS, DTE);
            ADD_NakEnergyDay_GraphQry(QRY_NAK_EN_DAY_EM, DTS, DTE);
            ADD_NakEnergyDay_GraphQry(QRY_NAK_EN_DAY_RP, DTS, DTE);
            ADD_NakEnergyDay_GraphQry(QRY_NAK_EN_DAY_RM, DTS, DTE);

            ADD_SresEnergyDay_GraphQry(QRY_SRES_ENR_EP, DTS, DTE);
            ADD_SresEnergyDay_GraphQry(QRY_SRES_ENR_EM, DTS, DTE);
            ADD_SresEnergyDay_GraphQry(QRY_SRES_ENR_RP, DTS, DTE);
            ADD_SresEnergyDay_GraphQry(QRY_SRES_ENR_RM, DTS, DTE);
        end;
    end;
end;

{*******************************************************************************
 *  Запросы к счетчику
 *      @param ... Ы)
 ******************************************************************************}
procedure CC12Meter.CreateTransitRequest(_Param : WORD; DTS, DTE : TDateTime);
begin
  case _Param of
    QRY_ENERGY_DAY_EP, // приращение за день
    QRY_ENERGY_DAY_EM,
    QRY_ENERGY_DAY_RP,
    QRY_ENERGY_DAY_RM :
      ADD_EnergyDay_GraphQryT(_Param, DTS, DTE);

    QRY_ENERGY_MON_EP, // приращение за месяц
    QRY_ENERGY_MON_EM,
    QRY_ENERGY_MON_RP,
    QRY_ENERGY_MON_RM :
      ADD_EnergyMonth_GraphQryT(_Param, DTS, DTE);

    QRY_SRES_ENR_EP, // срезы энергии
    QRY_SRES_ENR_EM,
    QRY_SRES_ENR_RP,
    QRY_SRES_ENR_RM,
    QRY_SRES_ENR_DAY_EP,
    QRY_SRES_ENR_DAY_EM,
    QRY_SRES_ENR_DAY_RP,
    QRY_SRES_ENR_DAY_RM :
      ADD_SresEnergy_GraphQryT(_Param, DTS, DTE);

    QRY_NAK_EN_DAY_EP, // накопленная на начало дня
    QRY_NAK_EN_DAY_EM,
    QRY_NAK_EN_DAY_RP,
    QRY_NAK_EN_DAY_RM :
      ADD_NakEnergyDay_GraphQryT(_Param, DTS, DTE);


    QRY_NAK_EN_MONTH_EP,
    QRY_NAK_EN_MONTH_EM,
    QRY_NAK_EN_MONTH_RP,
    QRY_NAK_EN_MONTH_RM :
      Add_NakEnergyMonth_GraphQryT(_Param, DTS, DTE);

    QRY_MAX_POWER_EP, // максимальная мощность в месяце
    QRY_MAX_POWER_EM,
    QRY_MAX_POWER_RP,
    QRY_MAX_POWER_RM :
      Add_MaxPower_QryT(_Param, DTS, DTE);
  end;
end;


procedure CC12Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
        OnFinalAction;
        TraceM(4,pMsg.m_swObjID,'(__)CL2MD::>C12OnFinHandQryRoutine  DRQ:',@pMsg);
        IsUpdate := 0;
    End;
end;

procedure CC12Meter.OnEnterAction;
begin
    m_PacketID := 0;
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>CC12M OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
//    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
//    m_nObserver.AddCurrParam(QRY_AUTORIZATION, 0, 0, 0, 1);
end;

procedure CC12Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    m_PacketID := 0;
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>CC12M OnConnectComplette');
    m_nModemState := 1;
    if m_blIsRemCrc=False then
        FinalAction;
End;

procedure CC12Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_PacketID := 0;
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>CC12M OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CC12Meter.OnFinalAction;
begin
    TraceL(4,m_nP.m_swMID,'(__)CL2MD::>CC12M OnFinalAction');
    FinalAction;
end;


{*******************************************************************************
 *  Функция закрытия сеанса обмена (84)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ84_CloseSession(var nReq: CQueryPrimitive);
begin
    m_QTimestamp       := Now();
    m_QReq := nReq;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 84);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция открытия сеанса обмена (85)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ85_OpenSession(var nReq: CQueryPrimitive);
var
  l_PassLen : Integer;
begin
    m_QTimestamp       := Now();
    m_QFNC             := 85;
    m_QReq := nReq;
    l_PassLen := Length(m_nP.m_schPassword);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
    move(m_nP.m_schPassword[1], m_nTxMsg.m_sbyInfo[2], l_PassLen);
    ZeroMemory(@m_nTxMsg.m_sbyInfo[2+l_PassLen], 8 - l_PassLen);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 85);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция пакетного запроса получасовых значений из РИ за сутки (86)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 *                   Specc0 - месяц
 *                   Specc1 - день
 *                   Specc2 - номер среза
 ******************************************************************************}
procedure CC12Meter.REQ86_Get30MValues(var nReq: CQueryPrimitive);
var
   l_RI,
   l_Day, l_Month, l_Year : WORD;
begin
    m_QTimestamp := Now();
    m_QFNC       := 86;
    m_QReq       := nReq;

    ReplaceTime(m_QTimestamp, 0);

    l_RI := ParamID2RI(nReq.m_swParamID);
    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
    if (nReq.m_swSpecc0 = 0) OR (nReq.m_swSpecc1 = 0) then
    begin
      nReq.m_swSpecc0 := l_Month;
      nReq.m_swSpecc1 := l_Day;
    end;

    if (nReq.m_swSpecc0 > l_Month) OR ((nReq.m_swSpecc0 = l_Month) AND (nReq.m_swSpecc1 > l_Day)) then
      Dec(l_Year);

    l_Month := nReq.m_swSpecc0;
    l_Day   := nReq.m_swSpecc1;

    m_QTimestamp := EncodeDate(l_Year, l_Month, l_Day);
    ReplaceTime(m_QTimestamp, 0);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_Day;
    m_nTxMsg.m_sbyInfo[5] := l_Month;
    m_nTxMsg.m_sbyInfo[6] := l_Year - 2000;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, m_QFNC);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция установки времени (88)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ88_SetTime(var nReq: CQueryPrimitive);
var
   l_Day, l_Month, l_Year,
   l_Hour, l_Min, l_Sec, l_MSec: WORD;
   l_nYear : DWORD;
begin
    m_QTimestamp := Now();
    m_QFNC       := 88;
    m_QReq       := nReq;

    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
    DecodeTime(m_QTimestamp, l_Hour, l_Min, l_Sec, l_MSec);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    m_nTxMsg.m_sbyInfo[2] := l_Sec;
    m_nTxMsg.m_sbyInfo[3] := l_Min;
    m_nTxMsg.m_sbyInfo[4] := l_Hour;
    m_nTxMsg.m_sbyInfo[5] := l_Day;
    m_nTxMsg.m_sbyInfo[6] := l_Month;
    l_nYear := l_Year;
    move(l_nYear, m_nTxMsg.m_sbyInfo[7], 4);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 88);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получение времени (89)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ89_GetTime(var nReq: CQueryPrimitive);
begin
    m_QTimestamp := Now();
    m_QFNC       := 89;
    m_QReq       := nReq;
     
    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 89);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получения значения из расчетного измерения базы данных ССПД С12 (90)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ90_GetRIValue(var nReq: CQueryPrimitive);
var
   l_RI,
   l_Day, l_Month, l_Year,
   l_H, l_M, l_S, l_MS : WORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 90;

    ReplaceTime(m_QTimestamp, 0);
    l_RI := ParamID2RI(nReq.m_swParamID);

    while (nReq.m_swSpecc0 < 0) do
    begin
        Inc(nReq.m_swSpecc0);
        if ((nReq.m_swParamID - QRY_ENERGY_MON_EP) < 4) AND ((nReq.m_swParamID - QRY_ENERGY_MON_EP) >= 0)
          or ((nReq.m_swParamID - QRY_NAK_EN_MONTH_EP) < 4) AND ((nReq.m_swParamID - QRY_NAK_EN_MONTH_EP) >= 0) then
        begin
          cDateTimeR.DecMonth(m_QTimestamp);
          m_QTimestamp := cDateTimeR.GetBeginMonth(m_QTimestamp);
        end
        else
          cDateTimeR.DecDate(m_QTimestamp);
    end;
    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
    l_H := 0;
    l_M := 0;

    if ((nReq.m_swParamID - QRY_ENERGY_MON_EP) < 4) AND ((nReq.m_swParamID - QRY_ENERGY_MON_EP) >= 0) then
      l_Day := cDateTimeR.DayPerMonth(l_Month, l_Year);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    {
    case nReq.m_swParamID of
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
         if (l_Month=0) OR (l_Day=0) then
         begin
            DecodeDate(Now(), l_Year, l_Month, l_Day);
            DecodeTime(Now(), l_H, l_M, l_S, l_MS);
            l_H := nReq.m_swSpecc2 div 2;
            l_M := (l_M div 30) * 30;
         end
         else
         begin
            l_Month := nReq.m_swSpecc0;
            l_Day := nReq.m_swSpecc1;
            l_H := nReq.m_swSpecc2 div 2;
            l_M := (nReq.m_swSpecc2 mod 2) * 30;
         end;
      end;
    end;
    }
    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_Day;
    m_nTxMsg.m_sbyInfo[5] := l_Month;
    m_nTxMsg.m_sbyInfo[6] := l_Year - 2000;
    m_nTxMsg.m_sbyInfo[7] := l_H;
    m_nTxMsg.m_sbyInfo[8] := l_M;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, m_QFNC);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;

{
procedure CC12Meter.REQ90_GetRIValue(var nReq: CQueryPrimitive);
var
   l_RI,
   l_Day, l_Month, l_Year,
   l_Hour, l_Min          : WORD;

begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 90;

    l_RI := ParamID2RI(nReq.m_swParamID);
    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
    if (nReq.m_swSpecc0 > l_Month) OR ((nReq.m_swSpecc0 = l_Month) AND (nReq.m_swSpecc1 > l_Day)) then
      Dec(l_Year);



    ReplaceTime(m_QTimestamp, 0);
    l_RI := ParamID2RI(nReq.m_swParamID);

    while (nReq.m_swSpecc0 < 0) do
    begin
        Inc(nReq.m_swSpecc0);
        cDateTimeR.DecDate(m_QTimestamp);
    end;
    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
    
    l_Month := nReq.m_swSpecc0;
    l_Day   := nReq.m_swSpecc1;
    l_Hour  := nReq.m_swSpecc2 div 2;
    l_Min   := (nReq.m_swSpecc2 mod 2)*30;

    m_QTimestamp := EncodeDate(l_Year, l_Month, l_Day);
    ReplaceTime(m_QTimestamp, EncodeTime(l_Hour, l_Min, 0, 0));
        
    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
    
    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_Day;
    m_nTxMsg.m_sbyInfo[5] := l_Month;
    m_nTxMsg.m_sbyInfo[6] := l_Year - 2000;
    m_nTxMsg.m_sbyInfo[7] := l_Hour;
    m_nTxMsg.m_sbyInfo[8] := l_Min;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, m_QFNC);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;
}

{*******************************************************************************
 *  Функция получения номера текущего события из журнала событий ССПД С12 (92)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ92_GetCurrentEventID(var nReq: CQueryPrimitive);
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 92;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 92);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;



{*******************************************************************************
 *  Функция получения события из журнала событий ССПД С12 (93)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ93_GetEventByID(var nReq: CQueryPrimitive);
var
    l_EvID : Integer;
begin
    m_QTimestamp := Now();
    m_QFNC       := 93;
    m_QReq       := nReq;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    l_EvID := m_CurrEventID + nReq.m_swSpecc0; // m_CurrEventID;
    if (l_EvID < 0) then
      l_EvID := 30000 + l_EvID;
    move(l_EvID, m_nTxMsg.m_sbyInfo[2], 4);              

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 93);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция запуска канала(объекта) ССПД С12 (94)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ94_StartChannelByID(var nReq: CQueryPrimitive);
var
    l_ChannelID : DWORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 94;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    l_ChannelID := nReq.m_swSpecc2;
    move(l_ChannelID, m_nTxMsg.m_sbyInfo[2], 4);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 94);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция остановки канала(объекта) ССПД С12 (95)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ95_StopChannelByID(var nReq: CQueryPrimitive);
var
    l_ChannelID : DWORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 95;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    l_ChannelID := nReq.m_swSpecc2;
    move(l_ChannelID, m_nTxMsg.m_sbyInfo[2], 4);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 95);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция запуска команды отработки внешнего соединения канала(объекта) ССПД С12 (96)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ96_StartRemConnectChannelByID(var nReq: CQueryPrimitive);
var
    l_ChannelID : DWORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 96;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    l_ChannelID := nReq.m_swSpecc2;
    move(l_ChannelID, m_nTxMsg.m_sbyInfo[2], 4);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 96);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получения суммарного значения энергии за сутки по типу зоны и типу дня (97)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ97_GetSumENByTZTD(var nReq: CQueryPrimitive);
var
    l_RI,
    l_Day, l_Month, l_Year : WORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 97;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);


    ReplaceTime(m_QTimestamp, 0);
    l_RI := ParamID2RI(nReq.m_swParamID);

    while (nReq.m_swSpecc0 < 0) do
    begin
        Inc(nReq.m_swSpecc0);
        cDateTimeR.DecDate(m_QTimestamp);
    end;
    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);

    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_Day;
    m_nTxMsg.m_sbyInfo[5] := l_Month;
    m_nTxMsg.m_sbyInfo[6] := l_Year - 2000;
    m_nTxMsg.m_sbyInfo[7] := m_QReq.m_swSpecc1;
    m_nTxMsg.m_sbyInfo[8] := 0;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 97);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получения суммарного значения энергии за период по типу зоны и типу дня (98)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ98_GetSumENByTZTD_OnPeriod(var nReq: CQueryPrimitive);
var
    l_RI,
    l_DayFrom, l_MonthFrom, l_YearFrom : WORD;
    l_DayTo, l_MonthTo, l_YearTo : WORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 98;
    l_RI         := ParamID2RI(nReq.m_swParamID);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    while (nReq.m_swSpecc0 < 0) do
    begin
        Inc(nReq.m_swSpecc0);
        cDateTimeR.DecDate(m_QTimestamp);
    end;
    DecodeDate(m_QTimestamp, l_YearFrom, l_MonthFrom, l_DayFrom);
    
    cDateTimeR.IncMonth(m_QTimestamp);
    DecodeDate(m_QTimestamp, l_YearTo, l_MonthTo, l_DayTo);

    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_DayFrom;
    m_nTxMsg.m_sbyInfo[5] := l_MonthFrom;
    m_nTxMsg.m_sbyInfo[6] := l_YearFrom - 2000;
    m_nTxMsg.m_sbyInfo[7] := l_DayTo;
    m_nTxMsg.m_sbyInfo[8] := l_MonthTo;
    m_nTxMsg.m_sbyInfo[9] := l_YearTo - 2000;
    m_nTxMsg.m_sbyInfo[10]:= nReq.m_swSpecc1;
    m_nTxMsg.m_sbyInfo[11]:= 0;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 98);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получения названия расчетного измерения ССПД С12 (99)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ99_GetRIName(var nReq: CQueryPrimitive);
begin
    m_QTimestamp    := Now();
    m_QReq          := nReq;
    m_QFNC          := 99;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    m_nTxMsg.m_sbyInfo[2] := LO(nReq.m_swSpecc0);
    m_nTxMsg.m_sbyInfo[3] := HI(nReq.m_swSpecc0);

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 99);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получения максимального значения мощности за сутки по типу зоны и типу дня (100)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ100_GetMaxPByTZTD(var nReq: CQueryPrimitive);
var
    l_RI,
    l_Day, l_Month, l_Year : WORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 100;
    l_RI         := ParamID2RI(nReq.m_swParamID);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    ReplaceTime(m_QTimestamp, 0);
    while (nReq.m_swSpecc0 < 0) do
    begin
        Inc(nReq.m_swSpecc0);
        cDateTimeR.DecDate(m_QTimestamp);
    end;
    DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);

    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_Day;
    m_nTxMsg.m_sbyInfo[5] := l_Month;
    m_nTxMsg.m_sbyInfo[6] := l_Year - 2000;
    m_nTxMsg.m_sbyInfo[7] := nReq.m_swSpecc1;
    m_nTxMsg.m_sbyInfo[8] := 0;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 100);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{*******************************************************************************
 *  Функция получения максимального значения мощности за период по типу зоны и типу дня (101)
 *      @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************}
procedure CC12Meter.REQ101_GetMaxPByTZTD_OnPeriod(var nReq: CQueryPrimitive);
var
    l_RI,
    l_DayFrom, l_MonthFrom, l_YearFrom : WORD;
    l_DayTo, l_MonthTo, l_YearTo : WORD;
begin
    m_QTimestamp    := Now();
    m_QReq          := nReq;
    m_QFNC          := 101;
    l_RI         := ParamID2RI(nReq.m_swParamID);

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

    DecodeDate(m_QTimestamp, l_YearFrom, l_MonthFrom, l_DayFrom);
    DecodeDate(m_QTimestamp, l_YearTo, l_MonthTo, l_DayTo);

    m_nTxMsg.m_sbyInfo[2] := LO(l_RI);
    m_nTxMsg.m_sbyInfo[3] := HI(l_RI);
    m_nTxMsg.m_sbyInfo[4] := l_DayFrom;
    m_nTxMsg.m_sbyInfo[5] := l_MonthFrom;
    m_nTxMsg.m_sbyInfo[6] := l_YearFrom - 2000;
    m_nTxMsg.m_sbyInfo[7] := l_DayTo;
    m_nTxMsg.m_sbyInfo[8] := l_MonthTo;
    m_nTxMsg.m_sbyInfo[9] := l_YearTo - 2000;
    m_nTxMsg.m_sbyInfo[10] := nReq.m_swSpecc1;
    m_nTxMsg.m_sbyInfo[11] := 0;

    FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 101);
    FillMessageHead(m_nTxMsg, 16);
    FPUT(BOX_L1, @m_nTxMsg);
    TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
end;


{******************************************************************************
 *  Функция транзитного обмена со счетчиками СС301
 *      @param  var nReq: CQueryPrimitive
 *      @return Integer
 ******************************************************************************}
procedure CC12Meter.REQ2_Transit(var nReq: CQueryPrimitive);
var
    l_Param : WORD;
begin
    m_QTimestamp := Now();
    m_QReq       := nReq;
    m_QFNC       := 2;

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16); // забиваем нулями пакет

    l_Param := ParamID2SSCMD(nReq.m_swParamID);
    if (l_Param > 0) then
    begin
        // заголовок С12
        m_nTxMsg.m_sbyInfo[0] := m_TransitAddress; // адрес объекта С12
        m_nTxMsg.m_sbyInfo[1] := 2;         // идентификатор заголовка
        m_nTxMsg.m_sbyInfo[2] := LO(16);    // полная длина пакета
        m_nTxMsg.m_sbyInfo[3] := HI(16);    // -/-
        m_nTxMsg.m_sbyInfo[4] := m_PacketID;// идентификатор пакета
        m_nTxMsg.m_sbyInfo[5] := 0;         // флаги пакета 0 - запрос, 1 - ответ
        m_nTxMsg.m_sbyInfo[6] := 1;         //
        m_nTxMsg.m_sbyInfo[7] := 0;         //

        // заголовок СС-301
        m_nTxMsg.m_sbyInfo[8] := m_MeterAddress; // 0 адрес счетчика
        m_nTxMsg.m_sbyInfo[9] := 3;               // 1 команда
        m_nTxMsg.m_sbyInfo[10]:= l_Param;         // 2 параметр
        m_nTxMsg.m_sbyInfo[11]:= nReq.m_swSpecc0; // 3 смещение
        m_nTxMsg.m_sbyInfo[12]:= nReq.m_swSpecc1; // 4 тариф
        m_nTxMsg.m_sbyInfo[13]:= nReq.m_swSpecc2; // 5 уточнение

        TraceL(2, m_nP.m_swMID, '(__)CC12M :> C12 SS301 TransferQ ::' +
                                  ' CMD:' + IntToStr(l_Param) + ': ' + m_nCommandList.Strings[nReq.m_swParamID] +
                                  ' OFS:' + IntToStr(nReq.m_swSpecc0) +
                                  ' TAR:' + IntToStr(nReq.m_swSpecc1) +
                                  ' UTO:' + IntToStr(nReq.m_swSpecc2));
        FillMessageInfo(m_nTxMsg.m_sbyInfo[0], 16, 2);
        FillMessageHead(m_nTxMsg, 16);
        FPUT(BOX_L1, @m_nTxMsg);
        m_nRepTimer.OnTimer(m_nP.m_swRepTime);
        TraceM(2,m_nTxMsg.m_swObjID,'(__)CC12M::>Out DRQ:',@m_nTxMsg);
    end;
end;

{******************************************************************************
 *  Обработка транзитного ответа от Счетчик -> УСПД 
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure CC12Meter.RES2_Transit(var pMsg:CMessage);
var
    l_dwValue : DWORD;
    l_wValue  : WORD;
    l_fValue  : Single;
    l_Value   : Double;

    l_IsAccepted : Boolean;
    
    Year, Month, Day       : word;
    YearNow, MonthNow, DayNow : word;
    Hour, Min, Sec       : word;
    l_EIT : Byte;
    l_SMon : Shortint;
begin
    l_IsAccepted := false;
    if (pMsg.m_sbyInfo[8+3] <> 0) then
        exit;

    case (pMsg.m_sbyInfo[10]) of
      1, 2, 3:
      begin
         ////m_nRepTimer.OffTimer();

         for l_EIT := 0 to 3 do
         begin
            Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_dwValue, 4);
            l_Value := l_dwValue * (m_nP.m_sfKI * m_nP.m_sfKU * m_QKE);
            FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, m_QReq.m_swSpecc1, true);
            TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                    ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
            FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
         //FinalAction;
      end;
      5, 6:
      begin
         ////m_nRepTimer.OffTimer();

         for l_EIT := 0 to 3 do
         begin
            Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_fValue, 4);
            l_Value := l_fValue * (m_nP.m_sfKI * m_nP.m_sfKU / 1000.0);
            FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, m_QReq.m_swSpecc1, true);
            TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                    ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
            FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         //FinalAction;
         FinalAction;
      end;
      7:
      begin
        move(pMsg.m_sbyInfo[8+10], l_fValue, 4);
        l_Value := l_fValue * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0;
        FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + m_QReq.m_swSpecc2 - 1, m_QReq.m_swSpecc1, false);
        m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[8+9];//Year
        m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[8+8];//Month
        m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[8+7];//Day
        m_nRxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[8+6];//Hour
        m_nRxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[8+5];//Min
        m_nRxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[8+4];//Sec
        l_IsAccepted := true;
      end;

      8, 9:
      Begin
          //m_nRepTimer.OffTimer();

         for l_EIT := 0 to 3 do
         begin
            Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_fValue, 4);
            l_Value := l_fValue * (m_nP.m_sfKI * m_nP.m_sfKU / 1000.0);
            FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, 0, true);
            TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                    ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
            FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
      End;

      10:
      Begin
         //m_nRepTimer.OffTimer();

         for l_EIT := 0 to 2 do
         begin
            Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_fValue, 4);
            l_Value := l_fValue * m_nP.m_sfKU;
            FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, 0, true);
            TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                    ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
            FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
      end;
      11:
      Begin
         //m_nRepTimer.OffTimer();

         for l_EIT := 0 to 2 do
         begin
            Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_fValue, 4);
            l_Value := l_fValue * m_nP.m_sfKI;
            FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, 0, true);
            TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                    ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
            FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
      End;
      12:
      Begin
         //m_nRepTimer.OffTimer();

         for l_EIT := 0 to 2 do
         begin
            Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_fValue, 4);
            l_Value := l_fValue;
            FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, 0, true);
            TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                    ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                    ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
            FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
      end;
      13:
      Begin
         Move(pMsg.m_sbyInfo[8+4], l_fValue, 4);
         l_Value := l_fValue;
         FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]), m_QReq.m_swSpecc1, true);
         TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                 ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                 ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                 ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
         l_IsAccepted := true;
      End;
      14, 15, 16:
      Begin
        m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
        m_nRxMsg.m_sbyInfo[0] := 11 + 9 + 3;
        m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T1 + pMsg.m_sbyInfo[8+2] - 14;
        if StrToInt(m_nP.m_sddPHAddres) = 0 then
          m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T2;
        m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[8+9];
        m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[8+8];
        m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[8+7];
        m_nRxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[8+6];
        m_nRxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[8+5];
        m_nRxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[8+4];
        m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
        move(pMsg.m_sbyInfo[8+10], m_nRxMsg.m_sbyInfo[9], 3);
        l_IsAccepted := true;
      End;
      24:
      Begin
        m_QKE := (pMsg.m_sbyInfo[8+8] + pMsg.m_sbyInfo[8+9]*$100) / 1000000.0;
        TraceL(3,pMsg.m_swObjID,'(__)CL2MD::>Ke = :' + FloatToStrF(m_QKE, ffFixed, 10, 7));
        //m_nRepTimer.OffTimer();
        FinalAction;
      End;
      32:
      Begin
        FillSaveDataMessage(0, QRY_DATA_TIME, 0, true);
        m_nRxMsg.m_sbyInfo[0] := 8;
        m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
        m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[8+9];//Year
        m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[8+8];//Month
        m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[8+7];//Day
        m_nRxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[8+6];//Hour
        m_nRxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[8+5];//Min
        m_nRxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[8+4];//Sec
        l_IsAccepted := true;
      End;
      36:
      Begin
        Move(pMsg.m_sbyInfo[8+4+2*(m_QReq.m_swParamID - QRY_SRES_ENR_EP)], l_wValue, 2);
        l_Value := l_wValue * (m_nP.m_sfKI * m_nP.m_sfKU * m_QKE);
        FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]), 0, false);

        m_nRxMsg.m_sbyServerID := m_nTxMsg.m_sbyInfo[8+5];
        DecodeDate(Now, YearNow, MonthNow, DayNow);
        Month := m_nTxMsg.m_sbyInfo[8+3];
        Day   := m_nTxMsg.m_sbyInfo[8+4];
        Hour  := trunc(m_nTxMsg.m_sbyInfo[8+5] / 2);
        Min   := m_nTxMsg.m_sbyInfo[8+5] mod 2 * 30;
        Sec   := 0;
        if (Month > MonthNow) or ((MonthNow = Month) and (Day > DayNow)) then
          Year := YearNow - 1
        else
          Year := YearNow;
        m_nRxMsg.m_sbyInfo[0] := 13+4;
        m_nRxMsg.m_sbyInfo[2] := Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := Month;
        m_nRxMsg.m_sbyInfo[4] := Day;
        m_nRxMsg.m_sbyInfo[5] := Hour;
        m_nRxMsg.m_sbyInfo[6] := Min;
        m_nRxMsg.m_sbyInfo[7] := Sec;
        l_IsAccepted := true;
      End;
      42, 43:
      Begin
        //m_nRepTimer.OffTimer();

        for l_EIT := 0 to 3 do
        begin
          Move(pMsg.m_sbyInfo[8+4 + l_EIT*4], l_dwValue, 4);
          l_Value := l_dwValue * (m_nP.m_sfKI * m_nP.m_sfKU * m_QKE);
          FillSaveDataMessage(l_Value, SSCMD2ParamID(pMsg.m_sbyInfo[8+2]) + l_EIT, m_QReq.m_swSpecc1, true);

//          m_nRxMsg.m_sbyServerID := m_nTxMsg.m_sbyInfo[8+5];
          m_QTimestamp := Now();
          move(m_nTxMsg.m_sbyInfo[8+3], l_SMon, 1);
          while (l_SMon < 0) do
          begin
            cDateTimeR.DecMonth(m_QTimestamp);
            Inc(l_SMon);
          end;
          DecodeDate(m_QTimestamp, Year, Month, Day);
          m_nRxMsg.m_sbyInfo[0] := 13+4;
          m_nRxMsg.m_sbyInfo[2] := Year - 2000;
          m_nRxMsg.m_sbyInfo[3] := Month;
          m_nRxMsg.m_sbyInfo[4] := 1;
          m_nRxMsg.m_sbyInfo[5] := 0;
          m_nRxMsg.m_sbyInfo[6] := 0;
          m_nRxMsg.m_sbyInfo[7] := 0;
          TraceL(3,pMsg.m_swObjID,'(__)CL2MD::> CMD=' + IntToStr(pMsg.m_sbyInfo[10]) +
                                  ' TYPE='+IntToStr(pMsg.m_sbyInfo[10]) +
                                  ' TAR='+IntToStr(m_QReq.m_swSpecc1) +
                                  ' VALUE=' + FloatToStrF(l_Value, ffFixed, 10, 7));
          FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
      End;
    End;

    if (l_IsAccepted) then
    begin
      FPUT(BOX_L3_BY, @m_nRxMsg);
      //m_nRepTimer.OffTimer();
      FinalAction;
      TraceL(2, m_nTxMsg.m_swObjID, '(__)CC12M::> IsCMD Accepted!');
    end;
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure CC12Meter.RES84_CloseSession(var pMsg:CMessage);
begin
    m_IsAuthorized := false;
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> Session END!');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure CC12Meter.RES85_OpenSession(var pMsg:CMessage);
begin
    m_IsAuthorized := true;
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> Session START!');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure CC12Meter.RES86_Get30MValues(var pMsg:CMessage);
var
    l_NRI      : WORD;
    l_Value    : Double;
    l_tValue   : Single;

    l_Day, l_Month, l_Year : Word;

    l_SID      : Byte;
    l_Mult     : Double;
begin
    move(pMsg.m_sbyInfo[3], l_NRI, 2);
    l_Day   := pMsg.m_sbyInfo[5];
    l_Month := pMsg.m_sbyInfo[6];
    l_Year  := pMsg.m_sbyInfo[7];

    case RI2ParamID(l_NRI) of
      QRY_SRES_ENR_EP, QRY_SRES_ENR_EM, QRY_SRES_ENR_RP, QRY_SRES_ENR_RM:
        l_Mult := m_nP.m_sfKI * m_nP.m_sfKU;
      QRY_I_PARAM_S, QRY_I_PARAM_A, QRY_I_PARAM_B, QRY_I_PARAM_C:
        l_Mult := m_nP.m_sfKI;
      QRY_U_PARAM_S, QRY_U_PARAM_A, QRY_U_PARAM_B, QRY_U_PARAM_C :
        l_Mult := m_nP.m_sfKU;
      QRY_KOEF_POW_A, QRY_KOEF_POW_B, QRY_KOEF_POW_C, QRY_FREQ_NET :
        l_Mult := 1;
      else
        l_Mult := 1;
    end;

    FillSaveDataMessage(0, 0, 0, false);
    for l_SID:=0 to 47 do
    begin
        move(pMsg.m_sbyInfo[8 + l_SID*5], l_tValue, 4); // достаем FLOAT
        l_Value := l_tValue * l_Mult; // приводим FLOAT -> DOUBLE

        m_nRxMsg.m_sbyDirID   := 1;
        m_nRxMsg.m_sbyServerID:= l_SID;
        if pMsg.m_sbyInfo[12+l_SID*5] = $5E then
        begin
            //l_Value := 0.0;
            //m_nRxMsg.m_sbyServerID:= m_nRxMsg.m_sbyServerID or $80;
        end;

        m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);

        m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
        m_nRxMsg.m_sbyInfo[1] := RI2ParamID(l_NRI);
        m_nRxMsg.m_sbyInfo[2] := l_Year;
        m_nRxMsg.m_sbyInfo[3] := l_Month;
        m_nRxMsg.m_sbyInfo[4] := l_Day;
        m_nRxMsg.m_sbyInfo[5] := 0; // H
        m_nRxMsg.m_sbyInfo[6] := 0; // M
        m_nRxMsg.m_sbyInfo[7] := 0; // S
        m_nRxMsg.m_sbyInfo[8] := 0; // HH

        case RI2ParamID(l_NRI) of
         QRY_U_PARAM_A,
         QRY_U_PARAM_B,
         QRY_U_PARAM_C,
         QRY_I_PARAM_A,
         QRY_I_PARAM_B,
         QRY_I_PARAM_C,
         QRY_KOEF_POW_A,
         QRY_KOEF_POW_B,
         QRY_KOEF_POW_C,
         QRY_FREQ_NET :
         begin
           m_nRxMsg.m_sbyInfo[5] := (l_SID div 2); // H
           m_nRxMsg.m_sbyInfo[6] := (l_SID mod 2) * 30; // M
         end;
        end;



        move(l_Value, m_nRxMsg.m_sbyInfo[9], sizeof(double));

        FPUT(BOX_L3_BY, @m_nRxMsg);
    end;
    //m_nRepTimer.OffTimer();
    FinalAction;
end;


procedure   CC12Meter.RES88_SetTime(var pMsg:CMessage);
begin
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> SET Time OK!');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES89_GetTime(var pMsg:CMessage);
var
    l_Year, l_Month, l_Day,
    l_Hour, l_Min, l_Sec, l_MSec : Word;
    nReq                         : CQueryPrimitive;
    Time                         : _SYSTEMTIME;
    Date                         : TDateTime;
    l_dwYear                     : DWORD;
begin
    DecodeTime(Now(), l_Hour, l_Min, l_Sec, l_MSec);
    DecodeDate(Now(), l_Year, l_Month, l_Day);

    FillSaveDataMessage(0, 0, 0, false);
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    move(pMsg.m_sbyInfo[8], l_dwYear, 4);

    m_nRxMsg.m_sbyInfo[2] := l_dwYear - 2000;   // year
    m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[7]; // month
    m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[6]; // day
    m_nRxMsg.m_sbyInfo[5] := pMsg.m_sbyInfo[5]; // hour
    m_nRxMsg.m_sbyInfo[6] := pMsg.m_sbyInfo[4]; // min
    m_nRxMsg.m_sbyInfo[7] := pMsg.m_sbyInfo[3]; // sec
    FPUT(BOX_L3_BY, @m_nRxMsg);

    Date := EncodeDate(m_nRxMsg.m_sbyInfo[2] + 2000, m_nRxMsg.m_sbyInfo[3], m_nRxMsg.m_sbyInfo[4]);
    ReplaceTime(Date, EncodeTime(m_nRxMsg.m_sbyInfo[5],m_nRxMsg.m_sbyInfo[6], m_nRxMsg.m_sbyInfo[7],0));
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> GET Time: ' + DateTimeToStr(Date));

    if ((m_nRxMsg.m_sbyInfo[2] <> (l_Year-2000))
            or (m_nRxMsg.m_sbyInfo[3] <> l_Month)
            or (m_nRxMsg.m_sbyInfo[4] <> l_Day)
            or (m_nRxMsg.m_sbyInfo[5] <> l_Hour)
            or (m_nRxMsg.m_sbyInfo[6] <> l_Min)
            or ((abs(m_nRxMsg.m_sbyInfo[7] - l_Sec) > 1))) then
    Begin
        if (m_nCF.cbm_sCorrDir.ItemIndex = 1) OR (m_QReq.m_swSpecc0 = 1) then
        begin
            TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> SET Time To USPD: ' + DateTimeToStr(Now()));
            REQ88_SetTime(nReq);
        end
        else if (m_nCF.cbm_sCorrDir.ItemIndex = 0) then
        begin
            TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> SET Time To ARM: ' + DateTimeToStr(Date));
            Time.wMilliseconds := 0;
            Time.wSecond    := m_nRxMsg.m_sbyInfo[7];
            Time.wMinute    := m_nRxMsg.m_sbyInfo[6];
            Time.wHour      := m_nRxMsg.m_sbyInfo[5];
            Time.wDay       := m_nRxMsg.m_sbyInfo[4];
            Time.wMonth     := m_nRxMsg.m_sbyInfo[3];
            Time.wYear      := 2000 + m_nRxMsg.m_sbyInfo[2];
            Date            := EncodeDate(Time.wYear, Time.wMonth, Time.wDay);
            Time.wDayOfWeek := DayOfWeek(Date);
            SetLocalTime(Time);
        end;
    End;

    //m_nRepTimer.OffTimer;
    FinalAction;
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES90_GetRIValue(var pMsg:CMessage);
var
    l_Value    : Double;
    l_tValue   : Single;

    l_Day, l_Month, l_Year,
    l_Hour, l_Min,
    l_NRI                   : Word;
begin
   move(pMsg.m_sbyInfo[3], l_NRI, 2);
   l_Year  := pMsg.m_sbyInfo[7];
   l_Month := pMsg.m_sbyInfo[6];
   l_Day   := pMsg.m_sbyInfo[5];
   l_Hour  := pMsg.m_sbyInfo[8];
   l_Min   := pMsg.m_sbyInfo[9];

   move(pMsg.m_sbyInfo[10], l_tValue, 4); // достаем FLOAT
   l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU; // приводим FLOAT -> DOUBLE

   if pMsg.m_sbyInfo[14] = $5E then
   begin
      //l_Value := 0.0;
      //m_nRxMsg.m_sbyServerID := m_nRxMsg.m_sbyServerID or $80;
   end;

   m_QTimestamp := EncodeDate(2000 + l_Year, l_Month, l_Day);
   ReplaceTime(m_QTimestamp, EncodeTime(l_Hour, l_Min, 0, 0));
   FillSaveDataMessage(l_Value, RI2ParamID(l_NRI), 0, true);

   FPUT(BOX_L3_BY, @m_nRxMsg);
   //m_nRepTimer.OffTimer();
   FinalAction;
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES92_GetCurrentEventID(var pMsg:CMessage);
begin
    m_QTimestamp := Now();
    Move(pMsg.m_sbyInfo[3], m_CurrEventID, 4);

    //m_nRepTimer.OffTimer;
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> Current Event ID: '+ IntToStr(m_CurrEventID));
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES93_GetEventByID(var pMsg:CMessage);
var
    l_Message : String;
    l_MessageDT : TDateTime;


    l_Day, l_Month, l_Year,
    l_Hour, l_Min, l_Sec, l_MSec : Word;
begin
    SetLength(l_Message, 80);
    Move(pMsg.m_sbyInfo[7], l_Message[1], 79);
    l_Message := Trim(l_Message);

    EventBox.FixEvents(ET_CRITICAL, l_Message);
    l_MessageDT := StrToDateTime(l_Message);

    m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
    m_nRxMsg.m_sbyInfo[0] := 11 + 9 + 3;
    m_nRxMsg.m_sbyInfo[1] := QRY_JRNL_T2;

    DecodeDate(l_MessageDT, l_Year, l_Month, l_Day);
    DecodeTime(l_MessageDT, l_Hour, l_Min, l_Sec, l_MSec);
    l_Year := l_Year - 2000;
    m_nRxMsg.m_sbyInfo[2] := l_Year;
    m_nRxMsg.m_sbyInfo[3] := l_Month;
    m_nRxMsg.m_sbyInfo[4] := l_Day;
    m_nRxMsg.m_sbyInfo[5] := l_Hour;
    m_nRxMsg.m_sbyInfo[6] := l_Min;
    m_nRxMsg.m_sbyInfo[7] := l_Sec;
    m_nRxMsg.m_sbyInfo[8] := StrToInt(m_nP.m_sddPHAddres);
    move(pMsg.m_sbyInfo[10], m_nRxMsg.m_sbyInfo[9], 3);


    //m_nRepTimer.OffTimer();
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ' + l_Message);
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES94_StartChannelByID(var pMsg:CMessage);
var
    unimplemented_ChannelID : DWORD;
begin
    //m_nRepTimer.OffTimer();
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES95_StopChannelByID(var pMsg:CMessage);
var
    unimplemented_ChannelID : DWORD;
begin
    //m_nRepTimer.OffTimer();
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES96_StartRemConnectChannelByID(var pMsg:CMessage);
var
    unimplemented_ChannelID : DWORD;
begin
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
 { TODO 5 -oUkrop -cTODO : Написать функцию, возвращающую номер тарифа по типу зоны и типу дня }
procedure   CC12Meter.RES97_GetSumENByTZTD(var pMsg:CMessage);
var
    l_NRI : WORD;
    l_TZ, l_TD : BYTE;

    l_Value : Double;
    l_tValue: Single;
    l_Mask  : Integer;
begin
    move(pMsg.m_sbyInfo[3], l_NRI, 2);
    l_TZ     := pMsg.m_sbyInfo[8];
    l_TD     := pMsg.m_sbyInfo[9];

    m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[7]; // year
    m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[6]; // month
    m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[5]; // day
    m_nRxMsg.m_sbyInfo[5] := 0; // hour
    m_nRxMsg.m_sbyInfo[6] := 0; // min
    m_nRxMsg.m_sbyInfo[7] := 0; // sec

    Move(pMsg.m_sbyInfo[10], l_tValue, sizeof(Single));
    l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU;
    l_Mask  := not(pMsg.m_sbyInfo[14] AND 1);
    Move(l_Value, m_nRxMsg.m_sbyInfo[8], sizeof(Double));

    FPUT(BOX_L3_BY, @m_nRxMsg);
    FinalAction;
    TraceL(2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES98_GetSumENByTZTD_OnPeriod(var pMsg:CMessage);
var
    l_NRI : WORD;
    l_TZ, l_TD : BYTE;

    l_Value : Double;
    l_tValue: Single;
    l_Mask  : Integer;
begin
    move(pMsg.m_sbyInfo[3], l_NRI, 2);
    l_TZ     := pMsg.m_sbyInfo[8];
    l_TD     := pMsg.m_sbyInfo[9];

    m_nRxMsg.m_sbyInfo[2] := pMsg.m_sbyInfo[7]; // year
    m_nRxMsg.m_sbyInfo[3] := pMsg.m_sbyInfo[6]; // month
    m_nRxMsg.m_sbyInfo[4] := pMsg.m_sbyInfo[5]; // day
    m_nRxMsg.m_sbyInfo[5] := 0; // hour
    m_nRxMsg.m_sbyInfo[6] := 0; // min
    m_nRxMsg.m_sbyInfo[7] := 0; // sec

    Move(pMsg.m_sbyInfo[10], l_tValue, sizeof(Single));
    l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU;
    l_Mask  := not(pMsg.m_sbyInfo[14] AND 1);
    Move(l_Value, m_nRxMsg.m_sbyInfo[8], sizeof(Double));

    FPUT(BOX_L3_BY, @m_nRxMsg);
    FinalAction;
    TraceL(2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES99_GetRIName(var pMsg:CMessage);
var
  l_RI : WORD;
  l_RIName : String;
begin
  Move(pMsg.m_sbyInfo[3], l_RI, 2);
  SetLength(l_RIName, 40);
  Move(pMsg.m_sbyInfo[5], l_RIName, 39);

  EventBox.FixEvents(ET_NORMAL, 'C12 Channel #' + IntToStr(l_RI) + ' :> ' + l_RIName);
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES100_GetMaxPByTZTD(var pMsg:CMessage);
begin
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


{*******************************************************************************
 *
 *      @param var pMsg:CMessage
 ******************************************************************************}
procedure   CC12Meter.RES101_GetMaxPByTZTD_OnPeriod(var pMsg:CMessage);
begin
    FinalAction;
    TraceL (2, m_nTxMsg.m_swObjID, '(__)CC12M::> ');
end;


procedure CC12Meter.StopComplette(var pMsg:CMessage);
Begin
    TraceM(2,pMsg.m_swObjID,'(__)CECOM::>STOP L2,3 CONF:',@pMsg);
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Удаленная команда выполнена.');
    //FinalAction;
End;

{
        Преобразование индекса параметра ("Автоматизация-2000")
    в "номер расчетного измерения" ("ГРАН-СИСТЕМА-С С12")
}
function CC12Meter.ParamID2RI(_ParamID : WORD): WORD;
var
    l_i       : Integer;
begin
    Result := 0;
    with m_nObserver.pm_sInil2CmdTbl.LockList do
    try
    for l_i := 0 to count - 1 do
        if (CComm(Items[l_i]).m_swCmdID = _ParamID) then
        begin
            //if (CComm(Items[l_i]).m_sbyEnable = 1) then
            Result := StrToInt(CComm(Items[l_i]).m_swChannel);
            exit;
        end;
    finally
     m_nObserver.pm_sInil2CmdTbl.UnLockList;
    End;
end;

{
        Преобразование "номера расчетного измерения" ("ГРАН-СИСТЕМА-С С12")
    в индекс параметра ("Автоматизация-2000")
}
function CC12Meter.RI2ParamID(_RI : WORD): WORD;
var
  l_i       : Integer;
begin
  Result := 0;

   with m_nObserver.pm_sInil2CmdTbl.LockList do
   try
  for l_i := 0 to count - 1 do
    if StrToInt(CComm(Items[l_i]).m_swChannel) = _RI then
    begin
      Result := CComm(Items[l_i]).m_swCmdID;
      exit;
    end;
    finally
     m_nObserver.pm_sInil2CmdTbl.UnLockList;
    End;
end;


{ protocol REQUESTS }

{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CC12Meter.ADD_SresEnergyDay_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    TempDate    : TDateTime;
    i           : integer;
    l_Year, l_Month, l_Day : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_SRES_ENR_EM, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_SRES_ENR_RP, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_SRES_ENR_RM, l_Month, l_Day, 0, 1);
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
{          DecodeDate(TempDate, l_Year, l_Month, l_Day);
          m_nObserver.AddGraphParam(_ParamID, l_Month, l_Day, 0, 1);}
        end;
    end;
end;

{*******************************************************************************
 * Формирование задания на считывание получасовых архивов тока
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CC12Meter.ADD_I_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    TempDate    : TDateTime;
    i           : integer;
    l_Year, l_Month, l_Day : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            m_nObserver.AddGraphParam(QRY_I_PARAM_A, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_I_PARAM_B, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_I_PARAM_C, l_Month, l_Day, 0, 1);
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
{var
    TempDate    : TDateTime;
    i,j           : integer;
    l_Year, l_Month, l_Day,
    l_H, l_M, l_S, l_MS : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            DecodeTime(TempDate, l_H, l_M, l_S, l_MS);

            for j := 47 downto 0 do  // (l_H*2 + (l_M div 30))
            begin
               m_nObserver.AddGraphParam(QRY_I_PARAM_A, l_Month, l_Day, j, 1);
               m_nObserver.AddGraphParam(QRY_I_PARAM_B, l_Month, l_Day, j, 1);
               m_nObserver.AddGraphParam(QRY_I_PARAM_C, l_Month, l_Day, j, 1);
            end;
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;}

{*******************************************************************************
 * Формирование задания на считывание получасовых архивов напряжения
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CC12Meter.ADD_U_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    TempDate    : TDateTime;
    i           : integer;
    l_Year, l_Month, l_Day : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            m_nObserver.AddGraphParam(QRY_U_PARAM_A, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_U_PARAM_B, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_U_PARAM_C, l_Month, l_Day, 0, 1);
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
{var
    TempDate    : TDateTime;
    i,j           : integer;
    l_Year, l_Month, l_Day,
    l_H, l_M, l_S, l_MS : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            DecodeTime(TempDate, l_H, l_M, l_S, l_MS);

            for j := 47 downto 0 do // (l_H*2 + (l_M div 30))
            begin
               m_nObserver.AddGraphParam(QRY_U_PARAM_A, l_Month, l_Day, j, 1);
               m_nObserver.AddGraphParam(QRY_U_PARAM_B, l_Month, l_Day, j, 1);
               m_nObserver.AddGraphParam(QRY_U_PARAM_C, l_Month, l_Day, j, 1);
            end;
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
}

{*******************************************************************************
 * Формирование задания на считывание получасовых архивов коэффициентов мощности
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CC12Meter.ADD_FREQ_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    TempDate    : TDateTime;
    i           : integer;
    l_Year, l_Month, l_Day : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            m_nObserver.AddGraphParam(QRY_FREQ_NET, l_Month, l_Day, 0, 1);
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
{var
    TempDate    : TDateTime;
    i,j           : integer;
    l_Year, l_Month, l_Day,
    l_H, l_M, l_S, l_MS : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            DecodeTime(TempDate, l_H, l_M, l_S, l_MS);

            for j := 47 downto 0 do  // (l_H*2 + (l_M div 30))
               m_nObserver.AddGraphParam(QRY_FREQ_NET, l_Month, l_Day, j, 1);
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
         end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
}


{*******************************************************************************
 * Формирование задания на считывание получасовых архивов коэффициентов мощности
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CC12Meter.ADD_KOEF_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    TempDate    : TDateTime;
    i           : integer;
    l_Year, l_Month, l_Day : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            m_nObserver.AddGraphParam(QRY_KOEF_POW_A, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_KOEF_POW_B, l_Month, l_Day, 0, 1);
            m_nObserver.AddGraphParam(QRY_KOEF_POW_C, l_Month, l_Day, 0, 1);
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
{
var
    TempDate    : TDateTime;
    i,j           : integer;
    l_Year, l_Month, l_Day,
    l_H, l_M, l_S, l_MS : Word;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now()) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now();
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin  //В цикле считаю количество дней от текущего
          if (cDateTimeR.CompareDay(_DTE, TempDate) = 0) then
          begin
            DecodeDate(TempDate, l_Year, l_Month, l_Day);
            DecodeTime(TempDate, l_H, l_M, l_S, l_MS);

            for j := 47 downto 0 do // (l_H*2 + (l_M div 30))
            begin
               m_nObserver.AddGraphParam(QRY_KOEF_POW_A, l_Month, l_Day, j, 1);
               m_nObserver.AddGraphParam(QRY_KOEF_POW_B, l_Month, l_Day, j, 1);
               m_nObserver.AddGraphParam(QRY_KOEF_POW_C, l_Month, l_Day, j, 1);
            end;
            //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
            exit;
          end;
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -365 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
    end;
end;
}

{*******************************************************************************
 * Формирование задания на считывание приращения энергии за день
 ******************************************************************************}
procedure CC12Meter.ADD_EnergyDay_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
var
    TempDate    : TDateTime;
    i           : integer;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
        _DTE := Now;
     
    while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now;
        while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
        begin
            cDateTimeR.DecDate(TempDate);
            Dec(i);
            if i < -90 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
        if ParamID2RI(QRY_ENERGY_DAY_EP)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i, 0, 0, 1);
        if ParamID2RI(QRY_ENERGY_DAY_EM)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EM, i, 0, 0, 1);
        if ParamID2RI(QRY_ENERGY_DAY_RP)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RP, i, 0, 0, 1);
        if ParamID2RI(QRY_ENERGY_DAY_RM)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RM, i, 0, 0, 1);
        cDateTimeR.DecDate(_DTE);
    end;
    //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание приращения энергии за месяц
 ******************************************************************************}
procedure CC12Meter.Add_EnergyMonth_GraphQry(_ParamID : integer; _DTS, _DTE : TDateTime);
var
  TempDate    : TDateTime;
  i           : integer;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now;
        while (cDateTimeR.CompareMonth(_DTE, TempDate) <> 1) do
        begin
            cDateTimeR.DecMonth(TempDate);
            Dec(i);
            if i < -24 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
        if ParamID2RI(QRY_ENERGY_MON_EP)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i, 0, 0, 1);
        if ParamID2RI(QRY_ENERGY_MON_EM)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_MON_EM, i, 0, 0, 1);
        if ParamID2RI(QRY_ENERGY_MON_RP)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_MON_RP, i, 0, 0, 1);
        if ParamID2RI(QRY_ENERGY_MON_RM)<>0 then m_nObserver.AddGraphParam(QRY_ENERGY_MON_RM, i, 0, 0, 1);
        cDateTimeR.DecMonth(_DTE);
    end;
    //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание максимумов мощности за месяц
 ******************************************************************************}
procedure CC12Meter.ADD_MaxPowerMonth_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now;
        while (cDateTimeR.CompareMonth(_DTE, TempDate) <> 1) do
        begin
            cDateTimeR.DecMonth(TempDate);
            Dec(i);
            if i < -24 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
        m_nObserver.AddGraphParam(QRY_MAX_POWER_EP, i + 1, 0, 0, 1); // сумма
        m_nObserver.AddGraphParam(QRY_MAX_POWER_EM, i + 1, 0, 0, 1); // Т1
        m_nObserver.AddGraphParam(QRY_MAX_POWER_RP, i + 1, 0, 0, 1); // Т2
        m_nObserver.AddGraphParam(QRY_MAX_POWER_RM, i + 1, 0, 0, 1); // Т3
        cDateTimeR.DecMonth(_DTE);
    end;
    //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
end;






procedure CC12Meter.ADD_Events_GraphQry(var pMsg : CMessage);
var
  l_i : Integer;
begin
  m_nObserver.ClearGraphQry;
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KPR, 0, 0, 0, 1);

  for l_i := 0 downto (-30) do
    m_nObserver.AddGraphParam(QRY_JRNL_T2, m_CurrEventID + l_i, 0, 0, 1);

end;






procedure CC12Meter.ADD_NakEnergyDay_GraphQry(_ParamID : Integer; _DTS, _DTE : TDateTime);
var
  TempDate    : TDateTime;
  i           : integer;
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
    _DTE := Now;

  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    i        := 0;
    TempDate := Now;
    while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
    begin
      cDateTimeR.DecDate(TempDate);
      Dec(i);
      if i < -60 then
      begin
        //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
        exit;
      end;
    end;
    if ParamID2RI(QRY_ENERGY_MON_EP)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i, 0, 0, 1);
    if ParamID2RI(QRY_NAK_EN_DAY_EM)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EM, i, 0, 0, 1);
    if ParamID2RI(QRY_NAK_EN_DAY_RP)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_RP, i, 0, 0, 1);
    if ParamID2RI(QRY_NAK_EN_DAY_RM)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_RM, i, 0, 0, 1);
    cDateTimeR.DecMonth(_DTE);
  end;
  //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
  cDateTimeR.DecDate(_DTE);
end;

procedure CC12Meter.Add_NakEnergyMonth_GraphQry(_ParamID :Integer; _DTS, _DTE : TDateTime);
var
  TempDate    : TDateTime;
  i           : integer;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

    if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
        _DTE := Now;

    while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
    begin
        i        := 0;
        TempDate := Now;
        while (cDateTimeR.CompareMonth(_DTE, TempDate) <> 1) do
        begin
            cDateTimeR.DecMonth(TempDate);
            Dec(i);
            if i < -24 then
            begin
                //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
                exit;
            end;
        end;
        if ParamID2RI(QRY_NAK_EN_MONTH_EP)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i, 0, 0, 1);
        if ParamID2RI(QRY_NAK_EN_MONTH_EM)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EM, i, 0, 0, 1);
        if ParamID2RI(QRY_NAK_EN_MONTH_RP)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RP, i, 0, 0, 1);
        if ParamID2RI(QRY_NAK_EN_MONTH_RM)<>0 then m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RM, i, 0, 0, 1);
        cDateTimeR.DecMonth(_DTE);
    end;
end;

procedure CC12Meter.ADD_ChannelsDescro_GraphQry();
var
  l_i : Integer;
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  if (tmp_Chid < 4000) then
    for l_i := tmp_Chid to tmp_Chid+20 do
      m_nObserver.AddGraphParam(QRY_JRNL_T2, l_i + 1, 0, 0, 1);

  //m_nObserver.AddGraphParam(QRY_END, 0, 0, 0, 1);
end;



{ss301 / un}

{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.ADD_EnergyDay_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);

  if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
    _DTE := Now;

  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    i        := 0;
    TempDate := Now;
    while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
    begin  //В цикле считаю количество дней от текущего
      cDateTimeR.DecDate(TempDate);
      Dec(i);
      if i < -30 then
        exit;
    end;
    m_nObserver.AddGraphParam(_ParamID, i + 1, 0, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 1, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 2, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 3, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 4, 0, 1);
    cDateTimeR.DecDate(_DTE);
   end;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.Add_EnergyMonth_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);

  if (cDateTimeR.CompareMonth(_DTE, Now) = 1 ) then
    _DTE := Now;

  while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
  begin
    i        := 0;
    TempDate := Now;
    while (cDateTimeR.CompareMonth(_DTE, TempDate) <> 1) do
    begin
      cDateTimeR.DecMonth(TempDate);
      Dec(i);
      if i < -24 then
        exit;
    end;

    m_nObserver.AddGraphParam(_ParamID, i + 1, 0, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 1, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 2, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 3, 0, 1);
    m_nObserver.AddGraphParam(_ParamID, i + 1, 4, 0, 1);
    cDateTimeR.DecMonth(_DTE);
  end;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.Add_SresEnergy_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
var
    i, Srez     : integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    DeepSrez    : word;
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);

  DecodeTime(Now, h, m, s, ms);
  DeepSrez := 0;
  if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
    _DTE := Now;
  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    i        := 0;
    DecodeDate(_DTE, y, mn, d);
    if cDateTimeR.CompareDay(_DTE, Now) = 0 then
    Begin
       for Srez := (h*60 + m) div 30 - 1 downto 0 do
         m_nObserver.AddGraphParam(_ParamID, mn, d, Srez, 1)
    End else
    Begin
     Srez := 0;
     while Srez <= 47 do
     begin
       m_nObserver.AddGraphParam(_ParamID, mn, d, Srez, 1);
        Srez := Srez + 1;
     end;
    End;
    cDateTimeR.DecDate(_DTE);
    Inc(DeepSrez);
    if (DeepSrez > 365) then
      exit;
  end;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.Add_NakEnergyDay_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
var
  TempDate    : TDateTime;
    i           : integer;

begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  if (cDateTimeR.CompareDay(_DTE, Now) = 1 ) then
     _DTE := Now;
   while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(_DTE, TempDate) <> 1) do
     begin  //В цикле считаю количество дней от текущего
       cDateTimeR.DecDate(TempDate);
       Dec(i);
       if i < -30 then
         exit;
     end;
     m_nObserver.AddGraphParam(_ParamID, i + 1, 0, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 1, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 2, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 3, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 4, 0, 1);
     cDateTimeR.DecDate(_DTE);
   end;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.Add_NakEnergyMonth_GraphQryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
   if (cDateTimeR.CompareMonth(_DTE, Now) = 1 ) then
     _DTE := Now;
   while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(_DTE, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -12 then
         exit;
     end;
     m_nObserver.AddGraphParam(_ParamID, i + 1, 0, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 1, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 2, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 3, 0, 1);
     m_nObserver.AddGraphParam(_ParamID, i + 1, 4, 0, 1);
     cDateTimeR.DecMonth(_DTE);
   end;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CC12Meter.Add_MaxPower_QryT(_ParamID : Integer; _DTS, _DTE : TDateTime);
var TempDate    : TDateTime;
    i, j        : integer;
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  
   if (cDateTimeR.CompareMonth(_DTE, Now) = 1 ) then
     _DTE := Now;
   while cDateTimeR.CompareMonth(_DTS, _DTE) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(_DTE, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;

     for j := 1 to 4 do
     begin
       m_nObserver.AddGraphParam(_ParamID, i + 1, 0, j, 1);
       m_nObserver.AddGraphParam(_ParamID, i + 1, 1, j, 1);
       m_nObserver.AddGraphParam(_ParamID, i + 1, 2, j, 1);
       m_nObserver.AddGraphParam(_ParamID, i + 1, 3, j, 1);
       m_nObserver.AddGraphParam(_ParamID, i + 1, 4, j, 1);
     end;
     cDateTimeR.DecMonth(_DTE);
   end;
end;


End.
