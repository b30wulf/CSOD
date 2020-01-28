{*******************************************************************************
 *  Модуль протокола счетчика Энергомера СЕ102
 *  Ded_Moro3
 *  01.08.2018
 ******************************************************************************}

unit knsl2CE102Meter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    CCE102Meter = class(CMeter)
    private
        m_DotPosition : Integer; // положение точки
        m_Address     : WORD;
        m_Password    : DWORD; // пароль счетчика

        m_QFNC        : WORD;
        m_Req         : CQueryPrimitive;
        m_IsCurrCry   : Boolean;
        m_QTimestamp  : TDateTime;
        m_QTimestamp_OLD: TDateTime;
        
        m_IsAuthorized: Boolean;
//        m_SresID      : Byte;
        dt_TLD          : TDateTime;
        nOldYear        : Word;
        bl_SaveCrEv     : boolean;
        nReq            : CQueryPrimitive;
        LastDate        : TDateTime; //Для корректировки времени
        sumTarif        : Double;    // Суммирующий тариф
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
        function    CRC8(_Packet: array of BYTE; _DataLen:Integer) : Byte;
        function    IsValidMessage(var pMsg : CMessage) : Byte;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
        function    FillMessageBody(var _Msg : CHMessage; _FNC : WORD; _DataBytes : BYTE) : WORD;
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        function    ByteStuff(var _Buffer : array of BYTE; _Len : Byte) : Byte;
        function    ByteUnStuff(var _Buffer : array of BYTE; _Len : Byte): Byte;
        function    BCDToInt(_BCD : BYTE) : BYTE;
        function    IntToBCD(_Int : BYTE) : BYTE;
        function    GetDATA4(_Buff : array of BYTE) : DWORD;
        function    GetDATA3(_Buff : array of BYTE) : DWORD;


        // protocol REQUESTS
        procedure   REQ0001_OpenSession(var nReq: CQueryPrimitive);   // Пинг
        procedure   RES0001_OpenSession(var pMsg:CMessage);           // Ответ

        procedure   REQ0101_ReadConfig(var nReq: CQueryPrimitive);   // Конфигурация
        procedure   RES0101_ReadConfig(var pMsg:CMessage);           // Ответ

        procedure   REQ0120_ReadDateTime(var nReq: CQueryPrimitive);   // Чтение даты/времени
        procedure   RES0120_ReadDateTime(var pMsg : CMessage);         // Оnвет

        //procedure   REQ0121_WriteDateTime(var nReq: CQueryPrimitive);
//        procedure   KorrTime(LastDate : TDateTime);
        procedure   KorrTime;
        procedure   RES0121_WriteDateTime(var pMsg : CMessage);

//        procedure   REQ0130_ReadTariffValueSUM(var nReq: CQueryPrimitive);
//        procedure   RES0130_ReadTariffValueSUM(var pMsg : CMessage);

        procedure   REQ0130_ReadTariffValue(var nReq: CQueryPrimitive);
        procedure   RES0130_ReadTariffValue(var pMsg : CMessage);

        procedure   REQ0132_GetCurrentPower(var nReq: CQueryPrimitive);
        procedure   RES0132_GetCurrentPower(var pMsg:CMessage);

        procedure   REQ0133_GetEnergyDay(var nReq: CQueryPrimitive);
        procedure   RES0133_GetEnergyDay(var pMsg : CMessage);

        procedure   REQ0134_GetSresEnergy(var nReq: CQueryPrimitive);
        procedure   RES0134_GetSresEnergy(var pMsg : CMessage);

        procedure   REQ0138_GetEvents(var nReq: CQueryPrimitive);
        procedure   RES0138_GetEvents(var pMsg:CMessage);

    /////////////////////////////

        procedure   ADD_Energy_Sum_GraphQry();
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        //procedure   ADD_SresEnergyDay_GraphQry(_DTS, _DTE : TDateTime);
        procedure   ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyMonth_Qry(_DTS, _DTE : TDateTime);
        procedure   ADD_NakEnergyDay_Qry(_DTS, _DTE : TDateTime);
        procedure   ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);

    End;


implementation
const
CE102BY_crc8tab : array[0..255] of byte = (
   $00, $b5, $df, $6a, $0b, $be, $d4, $61, $16, $a3, $c9, $7c, $1d, $a8,
   $c2, $77, $2c, $99, $f3, $46, $27, $92, $f8, $4d, $3a, $8f, $e5, $50,
   $31, $84, $ee, $5b, $58, $ed, $87, $32, $53, $e6, $8c, $39, $4e, $fb,
   $91, $24, $45, $f0, $9a, $2f, $74, $c1, $ab, $1e, $7f, $ca, $a0, $15,
   $62, $d7, $bd, $08, $69, $dc, $b6, $03, $b0, $05, $6f, $da, $bb, $0e,
   $64, $d1, $a6, $13, $79, $cc, $ad, $18, $72, $c7, $9c, $29, $43, $f6,
   $97, $22, $48, $fd, $8a, $3f, $55, $e0, $81, $34, $5e, $eb, $e8, $5d,
   $37, $82, $e3, $56, $3c, $89, $fe, $4b, $21, $94, $f5, $40, $2a, $9f,
   $c4, $71, $1b, $ae, $cf, $7a, $10, $a5, $d2, $67, $0d, $b8, $d9, $6c,
   $06, $b3, $d5, $60, $0a, $bf, $de, $6b, $01, $b4, $c3, $76, $1c, $a9,
   $c8, $7d, $17, $a2, $f9, $4c, $26, $93, $f2, $47, $2d, $98, $ef, $5a,
   $30, $85, $e4, $51, $3b, $8e, $8d, $38, $52, $e7, $86, $33, $59, $ec,
   $9b, $2e, $44, $f1, $90, $25, $4f, $fa, $a1, $14, $7e, $cb, $aa, $1f,
   $75, $c0, $b7, $02, $68, $dd, $bc, $09, $63, $d6, $65, $d0, $ba, $0f,
   $6e, $db, $b1, $04, $73, $c6, $ac, $19, $78, $cd, $a7, $12, $49, $fc,
   $96, $23, $42, $f7, $9d, $28, $5f, $ea, $80, $35, $54, $e1, $8b, $3e,
   $3d, $88, $e2, $57, $36, $83, $e9, $5c, $2b, $9e, $f4, $41, $20, $95,
   $ff, $4a, $11, $a4, $ce, $7b, $1a, $af, $c5, $70, $07, $b2, $d8, $6d,
   $0c, $b9, $d3, $66
);
CE102BY_DotPosition : array[0..3] of integer = (1, 10, 100, 1000); 

{*******************************************************************************
 *
 ******************************************************************************}
constructor CCE102Meter.Create;
Begin

End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CCE102Meter.Destroy;
Begin
    inherited;
End;

procedure CCE102Meter.RunMeter; Begin end;

function CCE102Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CCE102Meter.InitMeter(var pL2:SL2TAG);
Var
  slv : TStringList;
  Year, Month, Day : Word;
begin
  //m_Address := StrToInt(pL2.m_sddPHAddres);
  sumTarif   := 0;
  m_QTimestamp_OLD:=0;
  m_Password := StrToInt(pL2.m_schPassword);
  m_DotPosition := 100;
  IsUpdate := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
   slv := TStringList.Create;
   getStrings(m_nP.m_sAdvDiscL2Tag,slv);
   if slv[0]='' then slv[0] := '0';
   if slv[2]='' then slv[2] := '0';
   m_Address   := StrToInt(slv[2]);
   slv.Clear;
   slv.Destroy;
End;

{*******************************************************************************
 * Обработчик событий нижнего уровня
 ******************************************************************************}
function CCE102Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    byErr : Byte;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      ByteUnStuff(pMsg.m_sbyInfo, pMsg.m_swLen - 13);//
      byErr := IsValidMessage(pMsg);
      if byErr=1 then
      Begin
       Result := false;
       exit;
      End else
      if byErr=2 then
      begin
        Result := false;
        exit;
      end;
      case m_QFNC of // FUNCTION
        $0001 : RES0001_OpenSession(pMsg);
        $0101 : RES0101_ReadConfig(pMsg);
        $0120 : RES0120_ReadDateTime(pMsg);
        $0121 : RES0121_WriteDateTime(pMsg);
        $0130 : RES0130_ReadTariffValue(pMsg);
        $0132 : RES0132_GetCurrentPower(pMsg);
        $0133 : RES0133_GetEnergyDay(pMsg);
        $0134 : RES0134_GetSresEnergy(pMsg);
        $0138 : RES0138_GetEvents(pMsg);
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
function CCE102Meter.HiHandler(var pMsg:CMessage):Boolean;
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
        QRY_AUTORIZATION   : REQ0001_OpenSession(nReq);
        QRY_ENERGY_SUM_EP  : REQ0130_ReadTariffValue(nReq);//REQ0130_ReadTariffValueSUM(nReq);    //
        QRY_NAK_EN_MONTH_EP: REQ0130_ReadTariffValue(nReq);
        QRY_NAK_EN_DAY_EP  : REQ0133_GetEnergyDay(nReq);
        QRY_SRES_ENR_EP    : REQ0134_GetSresEnergy(nReq);
        QRY_DATA_TIME      : REQ0120_ReadDateTime(nReq);
        QRY_JRNL_T3        : REQ0138_GetEvents(nReq);
        QRY_MGAKT_POW_S    : REQ0132_GetCurrentPower(nReq);
        QRY_KPRTEL_KE      : REQ0101_ReadConfig(nReq);
      end;
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


{*******************************************************************************
 * Подсчет контрольной суммы
 * ИСПОЛЬЗУЕТСЯ самопальный фак'ски АЛГОРИТМ
 * BYTE CE102BY_CRC(BYTE *buf, int len)
 * @param BYTE *buf Указатель на массив данных для подсчета
 * @param int len Количество элементов для подсчета bcc
 * @return BYTE Контрольная сумма BCC
 ******************************************************************************}
function CCE102Meter.CRC8(_Packet: array of BYTE; _DataLen:Integer) : Byte;
var
  l_CRC : BYTE;
  i     : integer;
begin
  l_CRC := 0;
  for i:=1 to _DataLen-3 do
    l_CRC := CE102BY_crc8tab[l_CRC xor _Packet[i]];

  Result := l_CRC;
end;


{*******************************************************************************
 *  Проверка целостности сообщения
 *      @param var pMsg : CMessage Сообщение
 *      @return Boolean 
 ******************************************************************************}
function CCE102Meter.IsValidMessage(var pMsg : CMessage) : Byte;
var
    l_DataLen : WORD;
    l_ErrStr : String;
begin

    l_DataLen := 11 + (pMsg.m_sbyInfo[6] AND $0F);

    if ((pMsg.m_sbyInfo[6] AND $70) shr 4)=$07 then
    begin

      case pMsg.m_sbyInfo[9] of
        $00 : l_ErrStr := 'Команда отсутствует';
        $01 : l_ErrStr := 'Неверный формат принятого пакета';
        $02 : l_ErrStr := 'Недостаточный уровень доступа для выполнения команды';
        $03 : l_ErrStr := 'Неверное количество параметров для выполнения команды';
        $04 : l_ErrStr := 'Текущая конфигурация не позволяет выполнить эту команду';
        $05 : l_ErrStr := 'Не нажата кнопка "Доступ" для выполнения команды через оптопорт';
        $10 : l_ErrStr := 'Неверные параметры для выполнения команды';
        $40 : l_ErrStr := 'Недопустимая тарифная программа';
      end;

      Result := 1;
      exit;
    end;

    // контрольная сумма
    if (self.CRC8(pMsg.m_sbyInfo, pMsg.m_swLen - 13) <> pMsg.m_sbyInfo[l_DataLen-2]) then
    begin
        Result := 2;
        exit;
    end;

  Result := 0;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CCE102Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CE102;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CCE102Meter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := 13 + 9 + 3;
    pMsg.m_swObjID     := m_nP.m_swMID;
    pMsg.m_sbyFrom     := DIR_L2TOL3;
    pMsg.m_sbyFor      := DIR_L2TOL3;
    pMsg.m_sbyType     := PH_EVENTS_INT;
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_CE102;
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;

(*    m_nRxMsg.m_sbyInfo[0] := 9 + 3;
    m_nRxMsg.m_sbyInfo[8] := m_Address;
        move(pMsg.m_sbyInfo[10], m_nRxMsg.m_sbyInfo[9], 3);
        i := i + 4;

        if ((nReq.m_swSpecc0 = DepthEvEnd)) and (nReq.m_swParamID = QRY_JRNL_T1)  then
          m_nRxMsg.m_sbyInfo[11] := 1
        else
          m_nRxMsg.m_sbyInfo[11] := 0;
        if (DepthEvEnd = nReq.m_swSpecc0) and (nReq.m_swParamID <> QRY_JRNL_T1) then
          Result := true;
        if (nReq.m_swSpecc0 = -1) and (nReq.m_swParamID = QRY_JRNL_T1) then
          Result := true;
        if not Result then
          CreateJrnlReq(nReq);

        case m_nRxMsg.m_sbyInfo[1] of
             QRY_JRNL_T1 : ReadPhaseJrnl(m_nRxMsg);
             QRY_JRNL_T2 : ReadStateJrnl(m_nRxMsg);
             QRY_JRNL_T3 : ReadKorrJrnl(m_nRxMsg);
        End;

*)
end;


function CCE102Meter.FillMessageBody(var _Msg : CHMessage; _FNC : WORD; _DataBytes : BYTE) : WORD;
begin
  m_nTxMsg.m_sbyInfo[0] := $C0; // Признак начала пакета 2by
  m_nTxMsg.m_sbyInfo[1] := $48;
  m_nTxMsg.m_sbyInfo[2] := LO(m_Address); // Адрес счетчика
  m_nTxMsg.m_sbyInfo[3] := HI(m_Address); // резерв

  m_nTxMsg.m_sbyInfo[4] := $FF;  // Адрес УСПД для запроса $FFFF
  m_nTxMsg.m_sbyInfo[5] := $FF;

  // пароль для счетчика
  m_nTxMsg.m_sbyInfo[6] := (m_Password AND $000000FF);
  m_nTxMsg.m_sbyInfo[7] := (m_Password AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[8] := (m_Password AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[9] := (m_Password AND $FF000000) shr 24;

  m_nTxMsg.m_sbyInfo[10] := $80 OR ($05 shl 4) OR (_DataBytes); // Serv

  m_nTxMsg.m_sbyInfo[11] := HI(_FNC);
  m_nTxMsg.m_sbyInfo[12] := LO(_FNC);

// [13]+   -  данные 
  m_nTxMsg.m_sbyInfo[13 + _DataBytes] := CRC8(m_nTxMsg.m_sbyInfo, 15 + _DataBytes);
  m_nTxMsg.m_sbyInfo[14 + _DataBytes] := $C0;

  Result := ByteStuff(m_nTxMsg.m_sbyInfo, 15 + _DataBytes); // Байт Штаффинг
end;


{*******************************************************************************
 *  Формирование сообщения сохранения данных
 *      @param _Value : double Значение параметра
 *      @param _EType : byte Вид энергии
 *      @param _Tariff : byte Тарифф
 *      @param _WriteDate : Boolean Записывать метку времени
 ******************************************************************************}
procedure CCE102Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
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
        QRY_NAK_EN_MONTH_EP :
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

        QRY_NAK_EN_DAY_EP :
        begin
            cDateTimeR.IncDate(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := l_Day;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
        end;
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


procedure CCE102Meter.HandQryRoutine(var pMsg:CMessage);
Var
    DTS, DTE : TDateTime;
    l_Param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    //m_nObserver.ClearGraphQry;
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

      QRY_ENERGY_SUM_EP:
          ADD_Energy_Sum_GraphQry();

        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;



procedure CCE102Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
   // OnFinalAction();
   // TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CCE102 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CCE102Meter.OnEnterAction;
begin
  if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
    OpenPhone
  else if m_nP.m_sbyModem=0 then begin end;
end;

procedure CCE102Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then begin end;
End;

procedure CCE102Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 0;
End;

procedure CCE102Meter.OnFinalAction;
begin
    m_IsCurrCry := false;
//    FinalAction;
end;







{*******************************************************************************
 *  Пакет перед посылкой подлежит обработке механизмом байтстаффинга
 *  При байтстаффинге анализируется каждый байт, и:
 *	0х55 заменяется на 0х73 0х11,
 *	0х73 заменяется на 0х73 0х22.
 ******************************************************************************}
function CCE102Meter.ByteStuff(var _Buffer : array of BYTE; _Len : Byte) : Byte;
var
  i, l : integer;
  tArr : array[0..92] of BYTE;
begin
  l := 1;
  tArr[0] := _Buffer[0];
  for i := 1 to _Len-2 do
  begin

    if (_Buffer[i] = $C0) then
    begin
      tArr[l] := $DB;
      Inc(l);
      tArr[l] := $DC;
    end else if (_Buffer[i] = $DB) then
    begin
      tArr[l] := $DB;
      Inc(l);
      tArr[l] := $DD;
    end else
      tArr[l] := _Buffer[i];
    Inc(l);
  end;
  Inc(l);
  tArr[l-1] := _Buffer[_Len-1];

  move(tarr, _Buffer, l);
  Result := l;
end;

{*******************************************************************************
 *  Пакет перед посылкой подлежит обработке механизмом байтстаффинга
 *  При байтстаффинге анализируется каждый байт, и:
 *	0х73 0х11 заменяется на 0х55,
 *	0х73 0х22 заменяется на 0х73.
*******************************************************************************}
function CCE102Meter.ByteUnStuff(var _Buffer : array of BYTE; _Len : Byte) : Byte;
var
  i, l : integer;
  tArr : array[0..92] of BYTE;
begin
  l := 1;
  i := 1;
  tArr[0] := _Buffer[0];

  while (i < _Len-1) do
  begin
    if ((_Buffer[i] = $DB) AND (_Buffer[i + 1] = $DC)) then
    begin
      tArr[l] := $C0;
      Inc(i);
    end else if ((_Buffer[i] = $DB) AND (_Buffer[i + 1] = $DD)) then
    begin
      tArr[l] := $DB;
      Inc(i);
    end else
      tArr[l] := _Buffer[i];
    Inc(l);
    Inc(i);
  end;
  Inc(l);
  tArr[l-1] := _Buffer[_Len-1];

  move(tarr, _Buffer, l);
  Result := l;
end;

function CCE102Meter.BCDToInt(_BCD : BYTE) : BYTE;
begin
  Result := ((_BCD AND $F0) shr 4)*10 + (_BCD AND $0F);
end;

function CCE102Meter.IntToBCD(_Int : BYTE) : BYTE;
begin
  Result := (_Int mod 10) or ((_Int div 10) shl 4);
end;

function CCE102Meter.GetDATA4(_Buff : array of BYTE) : DWORD;
var
  l_pDW : array[0..3] of BYTE absolute Result;
begin
  Result := 0;

  l_pDW[0] := _Buff[0];
  l_pDW[1] := _Buff[1];
  l_pDW[2] := _Buff[2];
  l_pDW[3] := _Buff[3];
end;

function CCE102Meter.GetDATA3(_Buff : array of BYTE) : DWORD;
var
  l_pDW : array[0..3] of BYTE absolute Result;
begin
  Result := 0;

  l_pDW[0] := _Buff[0];
  l_pDW[1] := _Buff[1];
  l_pDW[2] := _Buff[2];
  l_pDW[3] := 0;
end;


(*******************************************************************************
 * Команда "Ping"
 ******************************************************************************)
procedure CCE102Meter.REQ0001_OpenSession(var nReq: CQueryPrimitive);
begin
  m_QTimestamp := Now();
  m_QFNC := $0001; // Открыть доступ к счетчику
  m_Req := nReq;

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  SendToL1(BOX_L1, @m_nTxMsg);
  //FPUT(BOX_L1, @m_nTxMsg);
  //m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  //TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Команда "Ping"
 *   2 байта - адрес устройства.
 ******************************************************************************)
procedure CCE102Meter.RES0001_OpenSession(var pMsg:CMessage);
var
  l_Addr : WORD;
begin
  move(pMsg.m_sbyInfo[9], l_Addr, 2);
  if (l_Addr = m_Address) then
    m_IsAuthorized := true;
end;


(*******************************************************************************
 * Команда "ReadConfig"
 ******************************************************************************)
procedure CCE102Meter.REQ0101_ReadConfig(var nReq: CQueryPrimitive);
begin
  m_QTimestamp := Now();
  m_QFNC := $0101;
  m_Req := nReq;

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  //FPUT(BOX_L1, @m_nTxMsg);
   SendToL1(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
 // TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Команда "Ping"
 *   2 байта - адрес устройства.
 ******************************************************************************)
procedure CCE102Meter.RES0101_ReadConfig(var pMsg:CMessage);
begin
  m_DotPosition := CE102BY_DotPosition[pMsg.m_sbyInfo[9] AND $03];
end;


(*******************************************************************************
 * ReadDateTime	0x1C	Чтение времени и даты
 ******************************************************************************)
procedure CCE102Meter.REQ0120_ReadDateTime(var nReq: CQueryPrimitive);
begin

if(nReq.m_swSpecc0=0)then
begin
  m_QTimestamp := Now();
  m_QFNC := $0120;
  m_Req := nReq;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  SendToL1(BOX_L1, @m_nTxMsg);
end
else if(nReq.m_swSpecc0=1)then
begin
 //KorrTime(LastDate);
 KorrTime;
end;

end;


(*******************************************************************************
 * Ответ "Чтение времени и даты"
 *******************************************************************************)

procedure CCE102Meter.RES0120_ReadDateTime(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;

begin
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    _yy := BCDToInt(pMsg.m_sbyInfo[15]);
    _mn := BCDToInt(pMsg.m_sbyInfo[14]);
    _dd := BCDToInt(pMsg.m_sbyInfo[13]);
    _hh := BCDToInt(pMsg.m_sbyInfo[11]);
    _mm := BCDToInt(pMsg.m_sbyInfo[10]);
    _ss := BCDToInt(pMsg.m_sbyInfo[9]);
    if (_mn>12)or(_mn=0)or(_dd>31)or(_dd=0)or(_hh>59)or(_mm>59)or(_ss>59) then
    Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка даты времени -> ');
     exit;          //Ошибка даты
    End;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    //Задача для коррекция времени
    nKorrTime :=5;
     if (Year <> _yy) or (Month <> _mn) or (Day <> _dd) or (Hour <> _hh) or (Min <> _mm) or (abs(_ss - Sec) >= nKorrTime) then
        begin
           m_nObserver.AddGraphParam(QRY_DATA_TIME, 1, 0, 0, 1);
        End;
end;

procedure CCE102Meter.KorrTime;
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    m_QTimestamp := Now();
    m_QFNC       := $0121;
    m_Req := nReq;

    DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
    DecodeDate(m_QTimestamp, Year, Month, Day);

    // BCD
    m_nTxMsg.m_sbyInfo[13] := IntToBCD(Sec);
    m_nTxMsg.m_sbyInfo[14] := IntToBCD(Min);
    m_nTxMsg.m_sbyInfo[15] := IntToBCD(Hour);
    m_nTxMsg.m_sbyInfo[16] := DayOfWeek(Now()) - 1;

    m_nTxMsg.m_sbyInfo[17] := IntToBCD(Day);
    m_nTxMsg.m_sbyInfo[18] := IntToBCD(Month);
    m_nTxMsg.m_sbyInfo[19] := IntToBCD(Year - 2000);

    FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 7));
    SendToL1(BOX_L1, @m_nTxMsg);
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
procedure CCE102Meter.RES0121_WriteDateTime(var pMsg:CMessage);
begin
    m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
    m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
    if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
    m_QFNC:=0;
end;


(******************************************************************************
 * Накопленная на конец месяца
 ******************************************************************************)
{procedure CCE102Meter.REQ0130_ReadTariffValueSUM(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
begin
  m_QTimestamp := Now();
  m_QFNC       := $0130;
  m_Req        := nReq;

  if (nReq.m_swSpecc0 >0) then
  begin
    cDateTimeR.DecMonthEx(nReq.m_swSpecc0, m_QTimestamp);
    DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
    m_QTimestamp := EncodeDate(l_Y, l_M, 1);
  end;

  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0; // 0 - суммарная накопленная, 1 - на конец предыдущего месяца(начало текущего)

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
//  FPUT(BOX_L1, @m_nTxMsg);
  SendToL1(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
 // TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;
       }

(******************************************************************************
 * Накопленная на конец месяца
 ******************************************************************************)
procedure CCE102Meter.REQ0130_ReadTariffValue(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
begin
  m_QTimestamp := Now();
  m_QFNC       := $0130;
  m_Req        := nReq;

  if (nReq.m_swSpecc0 >0) then
  begin
    cDateTimeR.DecMonthEx(nReq.m_swSpecc0, m_QTimestamp);
    DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
    m_QTimestamp := EncodeDate(l_Y, l_M, 1);
  end;

  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0; // 0 - суммарная накопленная, 1 - на конец предыдущего месяца(начало текущего)
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE102Meter.RES0130_ReadTariffValue(var pMsg:CMessage);
var
  l_V : double;
  l_s : String;
  l_Y, l_M, l_D : WORD;
  _l_Y, _l_M, _l_D : WORD;

begin
  DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
  DecodeDate(m_QTimestamp_OLD, _l_Y, _l_M, _l_D);

  if ((l_Y<>_l_Y)or(l_M<>_l_M)or(l_D<>_l_D))then
    begin
       sumTarif:=0;
       m_QTimestamp_OLD:=m_QTimestamp;
    end;
  l_V := GetDATA4(pMsg.m_sbyInfo[9]) / m_DotPosition * m_nP.m_sfKI * m_nP.m_sfKU;
  sumTarif:=sumTarif + l_V;
  {if m_Req.m_swSpecc1=0 then
  Begin
   FillSaveDataMessage(0, m_Req.m_swParamID, 0, true);
//   FPUT(BOX_L3, @m_nRxMsg);
   SendToL1(BOX_L1, @m_nTxMsg);
   cDateTimeR.DecMonth(m_QTimestamp);
  end;}
  if (m_Req.m_swSpecc1=3) then
    begin
     //cDateTimeR.DecMonth(m_QTimestamp);
     FillSaveDataMessage(sumTarif, m_Req.m_swParamID, 0, true);
      saveToDB(m_nRxMsg); //FPUT(BOX_L3, @m_nRxMsg);
      exit;
    end;
  FillSaveDataMessage(l_V, m_Req.m_swParamID, m_Req.m_swSpecc1+1, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3, @m_nRxMsg);
end;


(*******************************************************************************
 * ReadPower
	  Чтение  мощности, усредненной на минутном интервале
 ******************************************************************************)
procedure CCE102Meter.REQ0132_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0132;
  m_QTimestamp := Now();
  m_Req := nReq;

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
//  FPUT(BOX_L1, @m_nTxMsg);
  SendToL1(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
 // TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * Ответ
 *******************************************************************************)
procedure CCE102Meter.RES0132_GetCurrentPower(var pMsg:CMessage);
var
    l_V    : Double;
begin
  l_V := GetDATA3(pMsg.m_sbyInfo[9]) / m_DotPosition * m_nP.m_sfKI * m_nP.m_sfKU;

  FillSaveDataMessage(l_V, m_Req.m_swParamID, 0, true);
  saveToDB(m_nRxMsg);//FPUT(BOX_L3, @m_nRxMsg);
 // FinalAction();
end;

(*******************************************************************************
 * ReadEnergyOfDays
 *******************************************************************************)
procedure CCE102Meter.REQ0133_GetEnergyDay(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
  t : DWORD;
begin
  m_QTimestamp := Now();
  m_QFNC       := $0133;
  m_Req        := nReq;

  t := trunc(m_QTimestamp);
  Dec(t, nReq.m_swSpecc0);
  m_QTimestamp := t;

  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0;

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
//  FPUT(BOX_L1, @m_nTxMsg);
  SendToL1(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;

(*******************************************************************************
 *	Ответ
 ******************************************************************************)
procedure CCE102Meter.RES0133_GetEnergyDay(var pMsg : CMessage);
var
  l_V    : Double;
begin
  l_V := GetDATA4(pMsg.m_sbyInfo[9]) / m_DotPosition * m_nP.m_sfKI * m_nP.m_sfKU;
  if m_Req.m_swSpecc1=0 then
  Begin
   FillSaveDataMessage(0, m_Req.m_swParamID, 0, true);
    SendToL1(BOX_L1, @m_nTxMsg);
   //FPUT(BOX_L3, @m_nRxMsg);
   cDateTimeR.DecDate(m_QTimestamp);
  End;
  FillSaveDataMessage(l_V, m_Req.m_swParamID, m_Req.m_swSpecc1+1, true);
  saveToDB(m_nRxMsg); //FPUT(BOX_L3, @m_nRxMsg);
 // FinalAction();
end;


(*******************************************************************************
 * Чтение получасовых значений энергии за прошедшие  90 суток
 ******************************************************************************)
procedure   CCE102Meter.REQ0134_GetSresEnergy(var nReq: CQueryPrimitive);
var
  l_D, l_M, l_Y : WORD;
begin
  m_QFNC := $0134;
  if (nReq.m_swSpecc0 = 0) then
  begin
    DecodeDate(Now(), l_Y, l_M, l_D);
    nReq.m_swSpecc0 := l_D;
    nReq.m_swSpecc1 := l_M;
    nReq.m_swSpecc2 := trunc(frac(Now)/EncodeTime(0,30,0,0));
    if nReq.m_swSpecc2<>0 then nReq.m_swSpecc2 := nReq.m_swSpecc2 - 1;
    m_IsCurrCry := true;
  end;
  m_Req := nReq;

  DecodeDate(Now(), l_Y, l_M, l_D);
  if (nReq.m_swSpecc1 > l_M) then
    Dec(l_Y);

  m_QTimestamp := EncodeDate(l_Y, nReq.m_swSpecc1, nReq.m_swSpecc0);

  m_nTxMsg.m_sbyInfo[13] := IntToBCD(nReq.m_swSpecc0);
  m_nTxMsg.m_sbyInfo[14] := IntToBCD(nReq.m_swSpecc1);
  m_nTxMsg.m_sbyInfo[15] := IntToBCD(l_Y - 2000);
  m_nTxMsg.m_sbyInfo[16] := nReq.m_swSpecc2;
  m_nTxMsg.m_sbyInfo[17] := IntToBCD(1); // кол-во

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 5));
  SendToL1(BOX_L1, @m_nTxMsg);
  //FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  //TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ответ
 ******************************************************************************)
procedure   CCE102Meter.RES0134_GetSresEnergy(var pMsg : CMessage);
var
  l_V    : Double;
  i : integer;
  l_t : DWORD;

  l_Y, l_M, l_D,
  l_hh, l_mm, l_ss, l_ms : WORD;
begin
  DecodeTime(Now(), l_hh, l_mm, l_ss, l_ms);
  DecodeDate(m_QTimestamp, l_Y, l_M, l_D);

(*  for i:=0 to 3 do
  begin*)
    FillSaveDataMessage(0, 0, 0, false);
    m_nRxMsg.m_sbyDirID   := IsUpdate;
    m_nRxMsg.m_sbyServerID:= (m_Req.m_swSpecc2);
    m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[1] := QRY_SRES_ENR_EP;
    m_nRxMsg.m_sbyInfo[2] := l_Y-2000;
    m_nRxMsg.m_sbyInfo[3] := l_M;
    m_nRxMsg.m_sbyInfo[4] := l_D;
    m_nRxMsg.m_sbyInfo[5] := 0; // H
    m_nRxMsg.m_sbyInfo[6] := 0; // M
    m_nRxMsg.m_sbyInfo[7] := 0; // S
    m_nRxMsg.m_sbyInfo[8] := 0; // HH

    l_t := GetDATA3(pMsg.m_sbyInfo[9]);
    l_V := 0;
    if (l_t <> $00FFFFFF) then
      l_V :=  l_t / m_DotPosition * m_nP.m_sfKI * m_nP.m_sfKU
    else
      l_V :=  0;
      //m_nRxMsg.m_sbyServerID:= m_nRxMsg.m_sbyServerID or $80;

    move(l_V, m_nRxMsg.m_sbyInfo[9], sizeof(double));
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
(*end;*)

  {
   if (m_IsCurrCry and ((l_hh*2 + l_mm div 30) > m_Req.m_swSpecc2)) then
   begin
     Inc(m_Req.m_swSpecc2);
     REQ0134_GetSresEnergy(m_Req);
   end else
  }
  //  FinalAction();
end;



(******************************************************************************
 * Чтение записи из журнала
 ******************************************************************************)
procedure CCE102Meter.REQ0138_GetEvents(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0138;
  m_QTimestamp := Now();
  m_Req := nReq;

  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc0;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc1;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  //FPUT(BOX_L1, @m_nTxMsg);
  SendToL1(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
 // TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE102::>Out DRQ:',@m_nTxMsg);
end;


(******************************************************************************
 * ответ
 ******************************************************************************)
procedure CCE102Meter.RES0138_GetEvents(var pMsg:CMessage);
var
  l_EvCode,
  l_Y, l_M, l_D, l_hh, l_mm,l_ss : WORD;
  l_DT : TDateTime;
begin

  l_Y := BCDToInt(pMsg.m_sbyInfo[15]) + 2000;
  l_M := BCDToInt(pMsg.m_sbyInfo[14]);
  l_D := BCDToInt(pMsg.m_sbyInfo[13]);

  l_hh := BCDToInt(pMsg.m_sbyInfo[11]);
  l_mm := BCDToInt(pMsg.m_sbyInfo[10]);
  l_ss := BCDToInt(pMsg.m_sbyInfo[9]);

  l_DT := EncodeDate(l_Y, l_M, l_D) + EncodeTime(l_hh, l_mm, l_ss, 0);

  l_EvCode := pMsg.m_sbyInfo[16];

end;

(*******************************************************************************
 * Формирование задания на считывание суммарной потребленной энергии
 ******************************************************************************)
procedure CCE102Meter.ADD_Energy_Sum_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CCE102Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CCE102Meter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание 
 ******************************************************************************}
procedure CCE102Meter.ADD_NakEnergyMonth_Qry(_DTS, _DTE : TDateTime);
var
  l_MonthsLeft : WORD;
  i : integer;
  l_Now : TDateTime;
begin
 // m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  
  if (cDateTimeR.CompareMonth(_DTE, Now()) = 1) then
    _DTE := Now();

  l_MonthsLeft := 1;
  l_Now := Now();
  while (cDateTimeR.CompareMonth(_DTE, l_Now) = 2) do
  begin
    cDateTimeR.DecMonth(l_Now);
    Inc(l_MonthsLeft);
  end;
  
  while (cDateTimeR.CompareMonth(_DTS, _DTE) <> 1) do
  begin
    for i:=0 to 3 do
    begin
      m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, l_MonthsLeft, i, 0, 1);
    end;
      //m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, 0, 1, 0, 1); // Суммарная накопленная

    cDateTimeR.DecMonth(_DTE);
    Inc(l_MonthsLeft);
  end;
end;

procedure CCE102Meter.ADD_NakEnergyDay_Qry(_DTS, _DTE : TDateTime);
var
  l_DaysLeft : WORD;
  i : integer;
begin
  //m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  if (cDateTimeR.CompareDay(_DTE, Now()) <> 2) then
    _DTE := Now();

  l_DaysLeft := trunc(now()) - trunc(_DTE) + 1;
  while (cDateTimeR.CompareDay(_DTS, _DTE) <> 1) do
  begin
    for i:=0 to 3 do
    begin
      m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, l_DaysLeft, i, 0, 1);
    end;
    _DTE := _DTE - 1;
    Inc(l_DaysLeft);
  end;
  
end;

procedure CCE102Meter.ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_MGAKT_POW_S, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}

procedure CCE102Meter.ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i, Srez     : integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    DeepSrez    : word;
begin
   if m_nOnAutorization = 1 then
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
   DecodeTime(Now, h, m, s, ms);
   DeepSrez := 0;
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     DecodeDate(dt_Date2, y, mn, d);
     if cDateTimeR.CompareDay(dt_Date2, Now) = 0 then
     Begin
       for Srez := (h*60 + m) div 30 - 1 downto 0 do m_nObserver.AddGraphParam(QRY_SRES_ENR_EP,d, mn, Srez, 1)
     End else
     Begin
      Srez := 0;
      while Srez <= 47 do
      begin
        m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, d,mn,  Srez, 1);
        Srez := Srez + 1
      end;
     End;
     cDateTimeR.DecDate(dt_Date2);
     Inc(DeepSrez);
     if (DeepSrez > 365) then
       exit;
   end;
end;

{
procedure CCE102Meter.ADD_SresEnergyDay_GraphQry(_DTS, _DTE : TDateTime);
var
    i, Srez     : Integer;
    hh, mm, ss, ms : word;
    Y, D, M     : word;
    l_Now       : TDateTime;
begin
  m_nObserver.ClearGraphQry();
  l_Now := Now();
  m_IsCurrCry := false;

  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);

  DecodeTime(l_Now, hh, mm, ss, ms);
  if (cDateTimeR.CompareDay(_DTE, l_Now) <> 2 ) then
    _DTE := l_Now;

  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    DecodeDate(_DTE, Y, M, D);
    // если дата окончания - сегодняшний день, то обходим до текущего получаса
    if cDateTimeR.CompareDay(_DTE, l_Now) = 0 then
    begin
      Srez := hh*2 + (mm div 30);
      i := 0;
      while i < Srez do
      begin
        m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, D, M, i, 1);
        Inc(i);
      end;
    end else
    begin
      i:=0;
      while i < 48 do
      begin
        m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, D, M, i, 1);
        Inc(i);
      end;
    end;
    cDateTimeR.DecDate(_DTE);
  End;
end;
}
End.
