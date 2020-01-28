unit knsl2E9STKVer51Meter;
//{$DEFINE ST51_DEBUG}
interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, knsl5tracer, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox,utlcbox,Math;

type
    // Разные указатели
    _pointers = packed record
      LASTnum    : Word;            	// Указатель на ячейку LAST
      LASTuk     : Word;		// Число записей в LAST
      DEFLDAnum  : Byte;		// Число записей в области DEF,LDA
      DEFLDAuk   : Byte;		// Указатель на следующую запись DEF,LDA
      CRC        : Word;
    End;
    // Количество списанных ватт по тарифам
    _poket = packed record
      total      : DWORD;
      curr_month : DWORD;
      last_month : DWORD;
      CRC        : WORD;
    End;
    _poketf = packed record
      total      : single;
      curr_month : single;
      last_month : single;
      CRC        : WORD;
    End;
    // Количество ватт по тарифам за расчётный период
    _energy_period = packed record
      energy  : DWORD;
      debet   : DWORD;
      debetOst: Word;
      Month   : Byte;
      YEARL   : Byte;
      CRC     : WORD;
    End;
    // График нагрузки за последние MAXLAST
    {
    uint	DTSMALL;		// Дата и время ( укороченный вариант )
	uchar	value[3];			// Мощность (за 15, 30, 45, 60 минут) кратно 1 Wh
	uint	CRC;

    }
    _last = packed record
      DTSMALL : WORD;           // Дата и время ( укороченный вариант )
      value   : array[0..2] of Byte;           // Мощность (за 15, 30, 45, 60 минут) кратно 1 Wh
      CRC     : WORD;
    End;


    CE9STKVer51Meter = class(CMeter)
    private
        m_QFNC          : BYTE;
        m_QTimestamp    : TDateTime;
        //m_MonthBuf      : array [0..25] of CE9STKMonthStruct;
        //m_SliceBuf      : CE9STKPowerBuf;

        m_progr30Slice  : boolean;
        m_SliceReadSt   : integer;

        pMonthRead      : integer;
        mCurrSlice      : integer;
        mEndSlice       : integer;

        m_ParamID       : BYTE;
        m_Index         : WORD;

        m_LaEnd         : WORD; //

        m_IsAuthorized  : Boolean;
        //IsUpdate        : BYTE;

        m_CODER          : array[0..3] of BYTE;

        //_pokets          : array[0..3,0..2] of _poket;
        //_energy_periods  : array[0..1,0..3,0..2] of _energy_periods;

        nReq            : CQueryPrimitive;
        m_nIndex        : Integer;
        m_pPoint        : _pointers;
        m_bData         : CBox;
        m_bDataMon      : CBox;
        dt_TLD          : TDateTime;
        nOldYear        : Word;
        bl_SaveCrEv     : boolean;
        m_dbNakEn       : array[0..8] of Extended;
        m_dbEnMon       : array[0..8] of Extended;
        m_dbEnMonTek    : array[0..8] of Extended;
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
        procedure   Set30Buffer(wShift:Word);

        function    CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _Date : TDateTime); overload;
        procedure   SaveData_FA(strPS:String;_Value : double; _ParamID : byte; _Tariff : byte; _Date : TDateTime;blFinal:Boolean);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean); overload;

        procedure   EncodePacket(var _Buffer : array of BYTE);
        function    DecompressPacket(data:PByteArray):Boolean;
        // protocol REQUESTS
        procedure   REQ03_OpenSession(var nReq: CQueryPrimitive);   // Открыть доступ к счетчику
        procedure   RES04_OpenSession_OK(var pMsg:CMessage);        // Связь установлена
        procedure   RES05_OpenSession_Fail(var pMsg:CMessage);      // Доступ закрыт

        procedure   REQ05_CloseSession(isTimer: boolean);           // Закрыть доступ (с подтверждением)
        procedure   RES05_SessionClosed(var pMsg:CMessage);         // Доступ закрыт

        procedure   FillSTKReq(ID, Index: Integer);
        procedure   CreateSpisSumEnReq(var nReq: CQueryPrimitive);
        procedure   CreateSpisnnNakEnDayReq(var nReq: CQueryPrimitive);
        procedure   CreateSpisnnNakEnMonReq(var nReq: CQueryPrimitive);
        procedure   CreateSumEnergyReq(var nReq: CQueryPrimitive);
        procedure   CreateSumEnReq(var nReq: CQueryPrimitive);
        procedure   ReadMonthEnAns(var pMsg: CMessage);
        procedure   CreateNakDayEnAns(var nReq: CQueryPrimitive);
        procedure   CreateDayEnAns(var nReq: CQueryPrimitive);
        procedure   ProcessMonthReq(var nReq: CQueryPrimitive);
        function    IsDateTimeEqual(dt1, dt2 : TDateTime): boolean;
        function    GetULongDate(time: Cardinal): TDateTime;
        function    GetUIntDate(time: word): TDateTime;
        function    GetDTFromSM(sm: integer): TDateTime;
        function    GetNextPointer(nIndex : integer): integer;
        procedure   ProcessSliceReq(var nReq: CQueryPrimitive);
        procedure   CreateSliceReq(var nReq: CQueryPrimitive);

        function    SwapDW(var swVal:Dword):Dword;
        procedure   REQ06_GetDataByID(var nReq: CQueryPrimitive);   // Чтение данных по идентификатору
        procedure   ReadSpisEnerAns(var pMsg: CMessage);
        procedure   ReadCurrentParam(var pMsg: CMessage);
        procedure   ReadNakEnMon(var pMsg: CMessage);
        procedure   ReadSlicePeriodAns(var pMsg: CMessage);
        procedure   ReadPointSliceAns(var pMsg: CMessage);
        procedure   ReadSliceAns(var pMsg: CMessage);
        procedure   SendSliceToL3(dValue:Double;wType:Word;dtDate:TDateTime);
        procedure   SendSliceToByIndexL3(dValue:Double;wType:Word;nIndex:Integer;dtDate:TDateTime);
        procedure   SetUnknownSlice(wType:Word);
        procedure   SetUnknownSliceByIndex(wType:Word;nIndex:Integer);
        procedure   ReadSlicesPackAns(var pMsg: CMessage);
        procedure   ReadJrnlAns(var pMsg: CMessage);
        procedure   GetDataAnswer(var pMsg: CMessage);
        procedure   RES01_GetDataByID_Fail(var pMsg : CMessage);    // ПРОВАЛ

        procedure   REQ07_GetDateTime(var nReq: CQueryPrimitive);   // Чтение даты/времени
        procedure   RES07_GetDateTime(var pMsg : CMessage);         // ОТвет даты/времени
        procedure   KorrTime(LastDate : TDateTime);

        procedure   RES00_SetDateTime_OK(var pMsg : CMessage);      // Ответ успешная установка даты/времени

        procedure   CreateJrnlEvReq(var nReq: CQueryPrimitive);

        procedure   REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);

        procedure   REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);

        procedure   RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
        procedure   RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);

        // protocol REQUESTS
        procedure   ADD_RelayState_CTRLQry(_StateID : WORD);
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        procedure   ADD_Energy_Day_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_Energy_NAckDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_Energy_Mon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_Energy_NMon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
        function    GetYear(month, day: integer): integer;
        function    IsTrueValue(var dbVal:Double):Boolean;
        function    BCDToInt(_BCD : array of BYTE; _Count : Integer) : Integer;
        function    BCDToByte(hexNumb:byte):byte;
        function    ArrayBCDToDouble(var mas:array of byte; size : byte):Double;
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
  STSL_STKV116_READ_PERIOD = 0;
  STSL_STKV116_READ_POINT = 1;
  STSL_STKV116_READ_SLICE = 2;

implementation


{*******************************************************************************
 *
 ******************************************************************************}
constructor CE9STKVer51Meter.Create;
Begin
  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> E9STKVer51 Meter Created');
  m_LaEnd := 0;
  //m_bData := CBox.Create(48*30*sizeof(CStk43Srez));
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CE9STKVer51Meter.Destroy;
Begin
    inherited;
    m_bData.Destroy;
End;

procedure CE9STKVer51Meter.RunMeter;
Begin
    m_nAutoTMR.RunTimer;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9STKVer51Meter.InitMeter(var pL2:SL2TAG);
  Var
  Year, Month, Day : Word;  
Begin
  IsUpdate := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;
  m_progr30Slice := false;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
  {$IFNDEF ST51_DEBUG}
  m_SliceReadSt := STSL_STKV116_READ_POINT;
  {$ELSE}
  m_SliceReadSt := STSL_STKV116_READ_SLICE;
  {$ENDIF}
  m_SliceReadSt := STSL_STKV116_READ_POINT;
  if m_bData=Nil then m_bData := CBox.Create(48*60*sizeof(CStk43Srez));

  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>E9CTK    Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;


function CE9STKVer51Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
    if pMsg.m_sbyType=DL_AUTORIZED_TM_REQ then
    Begin
     REQ05_CloseSession(False);
     m_nIndex := 0;
     m_IsAuthorized := false;
    End;
end;


{*******************************************************************************
 * Обработчик событий нижнего уровня
 ******************************************************************************}
function CE9STKVer51Meter.LoHandler(var pMsg:CMessage):Boolean;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      TraceM(2,pMsg.m_swObjID,'(__)CE9STKVer51::>Inp DRQ:',@pMsg);

      if not IsValidMessage(pMsg) then
      begin
        TraceM(2,pMsg.m_swObjID,'(__)CE9STKVer51::>Error ControlField:',@pMsg);
        Result := false;
        exit;
      end;
      EncodePacket(pMsg.m_sbyInfo);
{
      Алгоритм распаковки данных.
1.	Если бит 7 байта №2 входного пакета равен 0 - данные не надо распаковывать;
2.	Обнулить бит 7 байта №2 входного пакета;
3.	Прочитать байт повтора (3-й байт водного пакета);
4.	Если байт равен байту повтора прочитать число повторений, байт для повторения и повторить его требуемое число раз;
5.	Установить 1-й байт входного пакета=размеру распакованных данных;
}
      { TODO 5 -oUkrop -cFIXME : Функция декомпрессии пакета DecompressPacket(pMsg.m_sbyInfo);}
      DecompressPacket(@pMsg.m_sbyInfo[0]);
      if pMsg.m_sbyInfo[2]=1 then RES01_GetDataByID_Fail(pMsg) else
      case ( (m_QFNC shl 8) OR pMsg.m_sbyInfo[2]) of // FUNCTION
        $0304 : RES04_OpenSession_OK(pMsg);
        $0305 : RES05_OpenSession_Fail(pMsg);
        $0505 : RES05_SessionClosed(pMsg);
        $0606 : GetDataAnswer(pMsg);
        $0f0f : GetDataAnswer(pMsg);
        $0601 : RES01_GetDataByID_Fail(pMsg);
        $0707 : RES07_GetDateTime(pMsg);       // DONE 3 -oUkrop -cCHECK : Чтение даты/времени
        $0800 : RES00_SetDateTime_OK(pMsg);    // DONE 3 -oUkrop -cCHECK : Установка даты/времени
        $0E00 : RES00_CTRL_SetRelayState_OK(pMsg);
        $0E01 : RES01_CTRL_SetRelayState_Fail(pMsg);
        else FinalAction();
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
function CE9STKVer51Meter.HiHandler(var pMsg:CMessage):Boolean;
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

        QRY_ENERGY_SUM_EP :
          CreateSpisSumEnReq(nReq);

        QRY_ENERGY_DAY_EP :
          CreateDayEnAns(nReq);

        QRY_ENERGY_MON_EP :
          ProcessMonthReq(nReq);

        QRY_SRES_ENR_EP :
          ProcessSliceReq(nReq);

        QRY_NAK_EN_DAY_EP   :
          CreateNakDayEnAns(nReq);

        QRY_NAK_EN_MONTH_EP :
          CreateSpisnnNakEnMonReq(nReq);

        QRY_DATA_TIME :
          REQ07_GetDateTime(nReq);

        QRY_JRNL_T1,
        QRY_JRNL_T2,
        QRY_JRNL_T3,
        QRY_JRNL_T4 :
          CreateJrnlEvReq(nReq);

        QRY_MGAKT_POW_A :
          REQ0F_GetCurrentPower(nReq);

        QRY_AUTORIZATION :
        begin
         {$IFNDEF ST51_DEBUG}
          if (m_IsAuthorized=False) then
          Begin
           REQ03_OpenSession(nReq);
           m_IsAuthorized := True;
           m_nAutoTMR.OnTimer(10);
          End
          else
          Begin
           m_nAutoTMR.OnTimer(10);
           FinalAction();
          End;
          {$ELSE}
          m_IsAuthorized := True;
          FinalAction();
          {$ENDIF}
        end;

        QRY_EXIT_COM :
        begin
            {$IFNDEF ST51_DEBUG}
          if (m_IsAuthorized) then
          Begin
            REQ05_CloseSession(True);
            m_nAutoTMR.OffTimer;
          End
          else
            FinalAction();
          {$ELSE}
          m_IsAuthorized := False;
          FinalAction();
          {$ENDIF}
        end;

        QRY_RELAY_CTRL :
          REQ0E_CTRL_SetRelayState(nReq);

        else
          FinalAction();
      end;

      TraceM(2,pMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@pMsg);
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
function  CE9STKVer51Meter.CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
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
function CE9STKVer51Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
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
        TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer51 Ошибка CRC! Выход!');
        exit;
    end;

  Result := true;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9STKVer51Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_STKVER16;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;
procedure CE9STKVer51Meter.SaveData_FA(strPS:String;_Value : double; _ParamID : byte; _Tariff : byte; _Date : TDateTime;blFinal:Boolean);
Begin
   FillSaveDataMessage(_Value,_ParamID,_Tariff,_Date);
   FPUT(BOX_L3_BY,@m_nRxMsg);
   if blFinal=True then FinalAction;
   if strPS<>'' then
   TraceL(2, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')CE9STKVer51::>VNMON:'+
    ' DT :'+ DateTimeToStr(_Date)+
    ' Tar:'+ IntToStr(nReq.m_swSpecc1)+
    ' '+strPS+' :'+ FloatTostrF(_Value,ffFixed,6,4));
End;
procedure CE9STKVer51Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _Date : TDateTime);
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
   DecodeDate(_Date, l_Year, l_Month, l_Day);
   DecodeTime(_Date, l_Hour, l_Min, l_Second, l_MS);

   m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := l_Month;
   m_nRxMsg.m_sbyInfo[4] := l_Day;
   m_nRxMsg.m_sbyInfo[5] := l_Hour;
   m_nRxMsg.m_sbyInfo[6] := l_Min;
   m_nRxMsg.m_sbyInfo[7] := l_Second;

end;

{*******************************************************************************
 *  Формирование сообщения сохранения данных
 *      @param _Value : double Значение параметра
 *      @param _EType : byte Вид энергии
 *      @param _Tariff : byte Тарифф
 *      @param _WriteDate : Boolean Записывать метку времени
 ******************************************************************************}
procedure CE9STKVer51Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
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
function CE9STKVer51Meter.CMD2ID(_CMDID : BYTE) : BYTE;
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


procedure CE9STKVer51Meter.HandQryRoutine(var pMsg:CMessage);
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
        QRY_ENERGY_DAY_EP :
          ADD_Energy_Day_GraphQry(DTS, DTE);

        QRY_NAK_EN_DAY_EP :
          ADD_Energy_NackDay_GraphQry(DTS, DTE);

        QRY_ENERGY_MON_EP :
          ADD_Energy_Mon_GraphQry(DTS, DTE);

        QRY_NAK_EN_MONTH_EP :
          ADD_Energy_NMon_GraphQry(DTS, DTE);

        QRY_SRES_ENR_EP :
          AddSresEnergGrpahQry( DTS, DTE);

        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;


procedure CE9STKVer51Meter.ControlRoutine(var pMsg:CMessage);
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


procedure CE9STKVer51Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    //REQ05_CloseSession(false);
    pMonthRead := 255;
    {$IFNDEF ST51_DEBUG}
     m_SliceReadSt := STSL_STKV116_READ_POINT;
    {$ELSE}
     m_SliceReadSt := STSL_STKV116_READ_SLICE;
    {$ENDIF}
    //m_IsAuthorized := false;
    OnFinalAction();
    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CE9STKVer51 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CE9STKVer51Meter.OnEnterAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer51 OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CE9STKVer51Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer51 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CE9STKVer51Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer51 OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CE9STKVer51Meter.OnFinalAction;
begin

    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer51 OnFinalAction');
    FinalAction;
end;

procedure   CE9STKVer51Meter.EncodePacket(var _Buffer : array of BYTE);
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
//{
// Процедура распаковки пакета ответа от счетчика
// Параметры:
//     result - указатель на буфер, в который будет помещен распакованный пакет
//     data   - указатель на буфер, содержащий упакованный пакет;
//              должен указывать на байт со смещением 2 в пакете счетчика (код команды)
//     size   - размер блока данных упакованного пакета; 
//              в нем же возвращается размер распакованного пакета

//bool DeCompress (char * result, char * data, int &size)
//{
//    if(!(*data & 0x80))
//    {
//        memcpy(result, data, size);
//        return true;
//    }
//
//    char *src = data;
//    char *dst = result;
//    *dst++ = *src++ & 0x7F;
//    int cnt = size - 1;
//    int sz = 1;
//    char sgn = *src++;
//    --cnt;
//
//    while(cnt)
//    {
//        if(*src != sgn)
//        {
//            *dst++ = *src++;
//            --cnt;
//            ++sz;
//        }
//       else
//      {
//          ++src;
//          int num = (unsigned char)*src++;
//          char val = *src++;
//          memset(dst, val, num);
//          cnt -= 3;
//          dst += num;
//          sz += num;
//      }
//  }
//  size = sz;
//  return true;
//
//
function CE9STKVer51Meter.DecompressPacket(data:PByteArray):Boolean;
var
    cnt,sz,size,i,j,num : Integer;
    src : PByteArray;
    sgn,val : Byte;
    dst : array[0..255] of Byte;
begin
    i:=0;j:=0;
    if(data[2] and $80)=0 then
    Begin
     //move(data,pOut,size);
     result := true;
     exit;
    End;
    size:= data[1];
    src := @data[2];         //char *src = data;
    dst[i] := src[j] and $7f;Inc(i);Inc(j); //    *dst++ = *src++ & 0x7F;
    cnt := size - 1;     //int cnt = size - 1;
    sz  := 1;            //int sz = 1;
    sgn := src[j];Inc(j);//char sgn = *src++;
    Dec(cnt);            //--cnt;
    while(cnt>0) do
    Begin
      if i>255 then
      Begin
        result := False;
        exit;
      End;
     if(src[j] <> sgn) then
     Begin
      dst[i] := src[j];Inc(i);Inc(j);// *dst++ = *src++;
      Dec(cnt);//--cnt;
      Inc(sz);//++sz;
     End else
     Begin
      Inc(j);                 //++src;
      num := src[j];Inc(j);   //int num = (unsigned char)*src++;
      val := src[j];Inc(j);   //char val = *src++;
      FillChar(dst[i], val, num);//memset(dst, val, num);
      cnt    := cnt - 3;         //cnt -= 3;
      //dst[i] := dst[i] + num;       //dst += num;
      i := i + num;
      sz     := sz  + num;       //sz += num;
     End;
   End;
   size := sz;
   data[1] := sz;
   data[2] := dst[0];
   if sz>255 then
   Begin
    result := False;exit;
   end;
   for i:=0 to sz-1 do
   data[i+3] := dst[i+1];
   result := true;
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
procedure CE9STKVer51Meter.REQ03_OpenSession(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer51Meter.RES04_OpenSession_OK(var pMsg:CMessage);
begin
  m_IsAuthorized := true;

  m_CODER[0] := pMsg.m_sbyInfo[4];
  m_CODER[1] := pMsg.m_sbyInfo[5];
  m_CODER[2] := pMsg.m_sbyInfo[6];
  m_CODER[3] := pMsg.m_sbyInfo[7];

  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::> Сессия открыта. Ошибки системы: ' + IntToStr(pMsg.m_sbyInfo[8]) );
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
procedure CE9STKVer51Meter.RES05_OpenSession_Fail(var pMsg:CMessage);
begin
  m_IsAuthorized := false;
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::> Ошибка: Доступ закрыт!');
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
procedure CE9STKVer51Meter.REQ05_CloseSession(isTimer: boolean);
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
  if isTimer=True then
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer51Meter.RES05_SessionClosed(var pMsg:CMessage);
begin
  m_IsAuthorized := false;

  ZeroMemory(@m_CODER, 4);
  TraceL (3, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::> Доступ закрыт!');
  FinalAction();
end;

procedure CE9STKVer51Meter.FillSTKReq(ID, Index: Integer);
begin
   m_QFNC       := $06;
   m_nTxMsg.m_sbyInfo[0] := $7E;
   m_nTxMsg.m_sbyInfo[1] := $03;
   m_nTxMsg.m_sbyInfo[2] := $06;
   m_nTxMsg.m_sbyInfo[3] := ID;
   m_nTxMsg.m_sbyInfo[4] := (Index shr 8) AND $00FF;
   m_nTxMsg.m_sbyInfo[5] := Index AND $00FF;
   EncodePacket(m_nTxMsg.m_sbyInfo);
   m_nTxMsg.m_sbyInfo[6] := CRC8(m_nTxMsg.m_sbyInfo, true);

   FillMessageHead(m_nTxMsg, 7);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out CMD:',@m_nTxMsg);
end;

procedure CE9STKVer51Meter.CreateSpisSumEnReq(var nReq: CQueryPrimitive);
begin
   {
   if nReq.m_swSpecc1 = 0 then
   begin
     FinalAction;
     exit;
   end;
   m_ParamID := QRY_ENERGY_SUM_EP;
   FillSTKReq(4, nReq.m_swSpecc1 - 1);
   }
   m_nIndex := 0;
   m_ParamID := QRY_ENERGY_SUM_EP;
   FillSTKReq(4, nReq.m_swSpecc1);
end;

{
procedure CE9STKVer18Meter.CreateNakDayEnAns(var nReq: CQueryPrimitive);
var
    pData : CStk43Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,j,nINdex :Integer;
    dbSum,dbSum30,dbEnergyPok: Double;
    Year,Month,Day:Word;
begin
    m_ParamID := QRY_NAK_EN_DAY_EP;
    dbSum:=0;
    FillChar(m_dbNakEn,8,0);
    for i:=1 to 4 do
    Begin
    // {$IFDEF ST18_DEBUG}
    //  m_dbNakEn[i]:=10000*i;
     //{$ENDIF}
   {  dbSum:=dbSum+m_dbNakEn[i];
    End;

   dbSum30 := 0;
   for i:=0 to nReq.m_swSpecc0 do
   Begin
    dtDate01 := trunc(Now)-i;
    if m_bData.FGetSum(dtDate01,pData)=true then
    dbSum30 := dbSum30 + pData.dbEnergy;
   End;
   dbEnergyPok := dbSum-dbSum30;
   TraceL(3, m_nTxMsg.m_swObjID,' DT :'+ DateTimeToStr(dtDate01)+' Sum: '+FloatToStr(dbEnergyPok));
   FillSaveDataMessage(dbEnergyPok{*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff}{, QRY_NAK_EN_DAY_EP, 1, dtDate01);
   FPUT(BOX_L3, @m_nRxMsg);
   OnFinalAction();
End;  }

procedure CE9STKVer51Meter.CreateSpisnnNakEnMonReq(var nReq: CQueryPrimitive);
begin
    nReq.m_swParamID := QRY_NAK_EN_MONTH_EP;
    m_ParamID := QRY_NAK_EN_MONTH_EP;
    FillSTKReq(27,nReq.m_swSpecc1);
    TraceL(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Чтение нач мес по адресу: ' + IntToStr(nReq.m_swSpecc1));
end;

procedure CE9STKVer51Meter.CreateSpisnnNakEnDayReq(var nReq: CQueryPrimitive);
begin
   if nReq.m_swSpecc1 = 0 then
   begin
     FinalAction;
     exit;
   end;
   m_ParamID := QRY_NAK_EN_DAY_EP;
   FillSTKReq(4, nReq.m_swSpecc1 - 1);
end;



procedure CE9STKVer51Meter.CreateSumEnergyReq(var nReq: CQueryPrimitive);
begin
   FillSTKReq(12, 0);
end;

procedure CE9STKVer51Meter.CreateSumEnReq(var nReq: CQueryPrimitive);
begin
   m_nTxMsg.m_sbyInfo[0] := $7E;
   m_nTxMsg.m_sbyInfo[1] := $00;
   m_nTxMsg.m_sbyInfo[2] := $12;
   m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);
   FillMessageHead(m_nTxMsg, 7);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;


{
    _energy_period = packed record
      ENERGY : array[0..3] of DWORD;
      Month  : Byte;
      YEARL  : Byte;
      CRC    : WORD;
    End;
}
procedure CE9STKVer51Meter.ReadMonthEnAns(var pMsg: CMessage);
var
    tempDate : TDateTime;
    i     : integer;
    value : double;
    pVal  : _energy_period;
    Year1,Month1,Day1 : Word;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_energy_period));
   //IsTrueValue(pVal.ENERGY[i]);
   DecodeDate(Now,Year1,Month1,Day1);
   tempDate := EncodeDate(Year1,Month1,1);
   cDateTimeR.DecMonthEx(nReq.m_swSpecc0,tempDate);
   for i:=0 to 3 do
   Begin
    if i=0 then
    Begin
     FillSaveDataMessage(0, QRY_ENERGY_MON_EP, 0, tempDate);
     FPUT(BOX_L3, @m_nRxMsg);
    End;
    FillSaveDataMessage(pVal.ENERGY*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, QRY_ENERGY_MON_EP, i+1, tempDate); FPUT(BOX_L3, @m_nRxMsg);
    TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer51::>VMON:'+
     ' DT :'+ DateTimeToStr(tempDate)+
     ' Tar:'+ IntToStr(i)+
     ' E+ :'+ FloatTostrF(pVal.ENERGY*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4));
   end;
   FinalAction;
end;
{
TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer51::>VMON:'+
    ' DT :'+ DateTimeToStr(tempDate)+
    ' Tar:'+ IntToStr(i)+
    ' E+ :'+ FloatTostrF(m_dbNakEn[i+1]-m_dbEnMon[i+1],ffFixed,6,4));
}

procedure CE9STKVer51Meter.CreateNakDayEnAns(var nReq: CQueryPrimitive);
var
    pData : CStk43Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,j,nINdex :Integer;
    dbSum,dbSum30,dbEnergyPok: Double;
    Year,Month,Day:Word;
begin
    m_ParamID := QRY_NAK_EN_DAY_EP;
    dbSum:=0;
    FillChar(m_dbNakEn,8,0);
    for i:=1 to 4 do
    Begin
     {$IFDEF ST51_DEBUG}
     m_dbNakEn[i]:=10000*i;
     {$ENDIF}
     dbSum:=dbSum+m_dbNakEn[i];
    End;

   dbSum30 := 0;
   for i:=0 to nReq.m_swSpecc0 do
   Begin
    dtDate01 := trunc(Now)-i;
    if m_bData.FGetSum(dtDate01,pData)=true then
    dbSum30 := dbSum30 + pData.dbEnergy;
   End;
   dbEnergyPok := dbSum-dbSum30*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   TraceL(3, m_nTxMsg.m_swObjID,' DT :'+ DateTimeToStr(dtDate01)+' Sum: '+FloatToStr(dbEnergyPok));
   FillSaveDataMessage(dbEnergyPok{*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff}, QRY_NAK_EN_DAY_EP, 1, dtDate01);
   FPUT(BOX_L3, @m_nRxMsg);
   OnFinalAction();
End;
procedure CE9STKVer51Meter.CreateDayEnAns(var nReq: CQueryPrimitive);
var
    pData : CStk43Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,nINdex :Integer;
    Year,Month,Day:Word;
begin
   m_ParamID := QRY_ENERGY_DAY_EP;
   nReq.m_swSpecc0 := nReq.m_swSpecc0 + 1;
   dtDate01 := trunc(Now)-nReq.m_swSpecc0;
   if m_bData.FGetSum(dtDate01,pData)=true then
    Begin
    pData.dbEnergy := pData.dbEnergy*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
    TraceL(3, m_nTxMsg.m_swObjID,' DT :'+ DateTimeToStr(dtDate01+1)+' Sum: '+FloatToStr(pData.dbEnergy));
    FillSaveDataMessage(pData.dbEnergy{*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff}, QRY_ENERGY_DAY_EP, 1, dtDate01+1);
    FPUT(BOX_L3, @m_nRxMsg);
    End;
    OnFinalAction();
End;
procedure CE9STKVer51Meter.Set30Buffer(wShift:Word);
Var
    pData : CStk43Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,j,nINdex :Integer;
Begin
   //m_bData.FFREE();
   j := wShift;
   //for j:=0 to wShift do
  // Begin
   if (j=0) then
    begin
    nINdex   := trunc(frac(Now)/EncodeTime(0,30,0,0));
    dtDate00 := trunc(Now);
    pData.szSize   := Sizeof(CStk43Srez);
     for i:=0 to nINdex do
       Begin
       pData.DATETIME := dtDate00;
       pData.dbEnergy := 5;
       //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(i)+')CE9STKVer18::>VDAY:'+' DT :'+ DateTimeToStr(pData.DATETIME)+' Val: '+FloatToStr(pData.dbEnergy));
       m_bData.FPUTStk43(pData);
       dtDate00 := dtDate00 + EncodeTime(0,30,0,0);
       End;
    End
   Else
    begin
    dtDate00 := trunc(Now)-j;
    pData.szSize   := Sizeof(CStk43Srez);
     for i:=0 to 47 do
       Begin
       pData.DATETIME := dtDate00;
       pData.dbEnergy := j*5;
       //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(i)+')CE9STKVer18::>VDAY:'+' DT :'+ DateTimeToStr(pData.DATETIME)+' Val: '+FloatToStr(pData.dbEnergy));
       m_bData.FPUTStk43(pData);
       dtDate00 := dtDate00 + EncodeTime(0,30,0,0);
       End;
   End;
  //End;
End;

procedure CE9STKVer51Meter.ProcessMonthReq(var nReq: CQueryPrimitive);
var tempDate : TDateTime;
    item, i  : integer;
    value    : double;
begin
   nReq.m_swParamID := QRY_ENERGY_MON_EP;
   m_ParamID := QRY_ENERGY_MON_EP;
   FillSTKReq(27,nReq.m_swSpecc0);
   TraceL(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Чтение месячных архивов по адресу: ' + IntToStr(nReq.m_swSpecc0));
end;


function CE9STKVer51Meter.IsDateTimeEqual(dt1, dt2 : TDateTime): boolean;
var y1, m1, d1, h1, n1, s1, ms1,
    y2, m2, d2, h2, n2, s2, ms2 : word;
begin
   DecodeDate(dt1, y1, m1, d1);
   DecodeTime(dt1, h1, n1, s1, ms1);
   DecodeDate(dt2, y2, m2, d2);
   DecodeTime(dt2, h2, n2, s2, ms2);
   if (y1 = y2) and (m1 = m2) and (d1 = d2) and
        (h1 = h2) and (n1 = n2) and (ms1 = ms2) then
     Result := true
   else
     Result := false;
end;

function CE9STKVer51Meter.GetULongDate(time: Cardinal): TDateTime;
var yy, mm, dd, hh, nn, ss : word;
begin
   ss := (time and $13) * 2;
   nn := (time and $7E0) shr 5;
   hh := (time and $F800) shr 11;
   dd := (time and $1F0000) shr 16;
   mm := (time and $1E00000) shr 21;
   yy := (time and $FE000000) shr 25;

   try
     if (yy=0)or(mm=0)or(mm>12)or(dd=0)or(dd>31)or
        (hh>23)or(nn>59)or(ss>59) then
     //if (yy=0)or(mm=0)or(dd=0) then
       Result := 0
     else
       Result := EncodeDate(2000 + yy, mm, dd) +
            EncodeTime(hh, nn, ss, 0);
   except
     Result := 0;
   end;
end;

{
Дата и время  day,mon,year,hour,min представлена в виде uint (укороченный вариант)
MMMM  DDDD  DHHH  HHMM,  где 
MMMM-месяц,
DDDDD-день,
HHHHH-час,
MM=00 для MIN=0    минут
MM=01 для MIN= 15 минут									
MM=10 для MIN= 30 минут									
MM=11 для MIN= 45 минут

}
function CE9STKVer51Meter.GetUIntDate(time: word): TDateTime;
var yy, mm, dd, hh, nn, ss : word;
begin
   ss := 00;
   nn := (time and $03) * 15;
   hh := (time and $7C) shr 2;
   dd := (time and $F80) shr 7;
   mm := (time and $F000) shr 12;
    if (mm = 0) or (dd = 0) then
    Begin
     Result := 0;
     exit;
    End;
   yy := GetYear(mm, dd);
   try
     if (yy = 0) or (mm = 0) or (dd = 0) or (hh>23) or (nn>59) or (ss>59) then
       Result := 0
     else
       Result := EncodeDate(yy, mm, dd) +
            EncodeTime(hh, nn, ss, 0);
   except
     Result := 0;
   end;
end;

function CE9STKVer51Meter.GetDTFromSM(sm: integer): TDateTime;
var tempDate,tmDate, _30Min: TDateTime;
    yy,mm,dd,hh,mi,ss,ms:Word;
begin
   DecodeDate(Now,yy,mm,dd);
   DecodeTime(Now,hh,mi,ss,ms);
   if mi<30  then mi:=0 else
   if mi>=30 then mi:=30;
   ss := 0; ms := 0;
   tempDate := EncodeDate(yy,mm,dd)+EncodeTime(hh,mi,ss,ms);
   Result   := tempDate - (sm - 1)*EncodeTime(0,30,0,0);
end;


procedure CE9STKVer51Meter.ProcessSliceReq(var nReq: CQueryPrimitive);
begin
   CreateSliceReq(nReq);
end;
{
 LASTnum    : Word;            	// Указатель на ячейку LAST
      LASTuk     : Word;
}
function  CE9STKVer51Meter.GetNextPointer(nIndex : integer): integer;
Begin
   if (m_pPoint.LASTuk-nIndex)>=0 then Result := m_pPoint.LASTuk-nIndex;
   if (m_pPoint.LASTuk-nIndex)<0  then Result := 2999+(m_pPoint.LASTuk-nIndex);
End;

procedure CE9STKVer51Meter.CreateSliceReq(var nReq: CQueryPrimitive);
Var
   pData : CStk43Srez;
   dtDate,dtDate0 : TDateTime;
   Year,Month,Day:Word;
begin
   m_ParamID := QRY_SRES_ENR_EP;
   case m_SliceReadSt of
     STSL_STKV116_READ_POINT  : FillSTKReq(10, 0);
     STSL_STKV116_READ_SLICE  : begin
                                 //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')FindL3');
                                 //if nReq.m_swSpecc0=1 then
                                 //dtDate := GetDTFromSM(nReq.m_swSpecc0);
                                 dtDate := GetDTFromSM(nReq.m_swSpecc0);
                                 TraceL(4, m_nTxMsg.m_swObjID, 'DT->SM('+IntToStr(nReq.m_swSpecc0)+')='+DateTimeToStr(dtDate));

                                 {$IFDEF ST51_DEBUG}
                                 DecodeDate(Now,Year,Month,Day);
                                 if (nReq.m_swSpecc1=0) then nReq.m_swSpecc1 := Day or (Month shl 8) else
                                 //if (HiByte(nReq.m_swSpecc1)=0) then nReq.m_swSpecc1 := nReq.m_swSpecc1 or (Month shl 8);
                                 dtDate0 := EncodeDate(Year,HiByte(nReq.m_swSpecc1),LoByte(nReq.m_swSpecc1));
                                 Set30Buffer(trunc(Now-dtDate0));
                                 {$ENDIF}
                                 if m_bData.FINDStk43(dtDate,pData)=True then
                                 Begin
                                  TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Find: DATE L3:'+DateTimeToStr(dtDate)+' VAL:'+FloatToStr(pData.dbEnergy));
                                  SendSliceToByIndexL3(pData.dbEnergy,QRY_SRES_ENR_EP,nReq.m_swSpecc2,pData.DATETIME);
                                  FinalAction;
                                  exit;
                                 End;
                                 FillSTKReq(11, GetNextPointer(nReq.m_swSpecc0));
                                end;
   end;
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
procedure CE9STKVer51Meter.REQ06_GetDataByID(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
end;

{
_poket = packed record
      total      : DWORD;
      curr_month : DWORD;
      last_month : DWORD;
      CRC        : WORD;
    End;
}
function CE9STKVer51Meter.SwapDW(var swVal:Dword):Dword;
var
    b0 : array[0..3] of Byte;
    pB : PbyteArray;
Begin
    pB := @swVal;
    move(swVal,b0,4);
    pB[3] := b0[0];
    pB[2] := b0[1];
    pB[1] := b0[2];
    pB[0] := b0[3];
    Result := swVal;
End;
procedure CE9STKVer51Meter.ReadSpisEnerAns(var pMsg: CMessage);
var
    pVal : _poket;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_poket));
   SwapDW(pVal.total);
   SwapDW(pVal.curr_month);
   SwapDW(pVal.last_month);

   if (nReq.m_swSpecc1=0) then
   Begin
    //for i:=0 to 7 do m_dbNakEn[i] := 0;
    m_dbNakEn[0]    := 0;
    m_dbEnMonTek[0] := 0;
   SaveData_FA('Es',0, QRY_ENERGY_SUM_EP, nReq.m_swSpecc1, Now,False);
   End;
   SaveData_FA('Es',pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, QRY_ENERGY_SUM_EP, nReq.m_swSpecc1+1, Now,True);
      TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer51::>VSpis:'+
    ' DT :' + DateTimeToStr(Now)+
    ' Tar:' + IntToStr(nReq.m_swSpecc1)+
    ' Ett+ :' + FloatTostrF(pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4)+
    ' Etm+ :' + FloatTostrF(pVal.curr_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4)+
    ' Elm+ :' + FloatTostrF(pVal.last_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4));
   if (nReq.m_swSpecc1>=0)and(nReq.m_swSpecc1<=7) then
   Begin
    m_dbNakEn[nReq.m_swSpecc1+1]    := pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
    m_dbEnMonTek[nReq.m_swSpecc1+1] := pVal.curr_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   End;
   {
    if (nReq.m_swSpecc1=0) then SaveData_FA('Es',0, QRY_ENERGY_SUM_EP, nReq.m_swSpecc1, Now,False);
   SaveData_FA('Es',pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, QRY_ENERGY_SUM_EP, nReq.m_swSpecc1+1, Now,True);
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer51::>VSpis:'+
    ' DT :' + DateTimeToStr(Now)+
    ' Tar:' + IntToStr(nReq.m_swSpecc1)+
    ' Ett+ :' + FloatTostrF(pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4)+
    ' Etm+ :' + FloatTostrF(pVal.curr_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4)+
    ' Elm+ :' + FloatTostrF(pVal.last_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4));
   }

   
end;
{
    _current = packed record
      m_dActA :  Double;
      m_dActB :  Double;
      m_dActC :  Double;
      m_dReaA :  Double;
      m_dReaB :  Double;
      m_dReaC :  Double;
      m_dUa   :  Double;
      m_dUb   :  Double;
      m_dUc   :  Double;
      m_dIa   :  Double;
      m_dIb   :  Double;
      m_dIc   :  Double;
      m_nFrA  :  Word;
      m_nFrB  :  Word;
      m_nFrC  :  Word;
      m_nFiA  :  Word;
      m_nFiB  :  Word;
      m_nFiC  :  Word;
    End;

}
procedure CE9STKVer51Meter.ReadCurrentParam(var pMsg: CMessage);
var
   pVal : DWORD;
   dbValue : Double;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(DWORD));
   SwapDW(pVal);
   dbValue := pVal*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   SaveData_FA('PA',dbValue, QRY_MGAKT_POW_A, 0, Now,True);
end;
{
nReq.m_swSpecc0
var
    pVal : _poket;
    i : Integer;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_poket));
   if (nReq.m_swSpecc1=0) then FillSaveDataMessage(0, QRY_ENERGY_SUM_EP, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, QRY_ENERGY_SUM_EP, nReq.m_swSpecc1+1, Now);FPUT(BOX_L3, @m_nRxMsg);
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer51::>VSpis:'+
    ' DT :' + DateTimeToStr(Now)+
    ' Tar:' + IntToStr(nReq.m_swSpecc1)+
    ' Ett+ :' + FloatTostrF(pVal.total*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4)+
    ' Etm+ :' + FloatTostrF(pVal.curr_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4)+
    ' Elm+ :' + FloatTostrF(pVal.last_month*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff,ffFixed,6,4));
   FinalAction;
end;
}
procedure CE9STKVer51Meter.ReadNakEnMon(var pMsg: CMessage);
var
    tempDate : TDateTime;
    i     : integer;
    value : double;
    pVal  : _energy_period;
    Year,Month,Day,Year1,Month1,Day1,tar : Word;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_energy_period));
   SwapDW(pVal.energy);
   DecodeDate(Now,Year1,Month1,Day1);
   tempDate := EncodeDate(Year1,Month1,1);
   cDateTimeR.DecMonthEx(nReq.m_swSpecc0,tempDate);
   tar := (nReq.m_swSpecc1 mod (13*3));
   if tar=0 then
   SaveData_FA('Em+',0, QRY_NAK_EN_MONTH_EP, tar, tempDate,False);
   SaveData_FA('Em+',pVal.energy*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, QRY_NAK_EN_MONTH_EP, tar+1, tempDate,True);
end;

procedure CE9STKVer51Meter.ReadSlicePeriodAns(var pMsg: CMessage);
var perMask : integer;
begin
   perMask := (pMsg.m_sbyInfo[3] and $30) shr 4;
   if perMask = 1 then
   begin
     m_progr30Slice := true;
     m_SliceReadSt := STSL_STKV116_READ_POINT;
     CreateSliceReq(nReq);
   end
   else
     FinalAction;
end;

procedure CE9STKVer51Meter.ReadPointSliceAns(var pMsg: CMessage);
var item, res : integer;
begin
   move(pMsg.m_sbyInfo[3], m_pPoint, sizeof(_pointers));
   m_pPoint.LASTnum := Swap(m_pPoint.LASTnum);
   m_pPoint.LASTuk  := Swap(m_pPoint.LASTuk);
   m_SliceReadSt := STSL_STKV116_READ_SLICE;
   CreateSliceReq(nReq);
   {
   mCurrSlice := 0;
   m_SliceBuf.LASTnum := 0;
   move(pMsg.m_sbyInfo[3], m_SliceBuf.LASTnum, 2);
   m_SliceBuf.LASTuk := 0;
   move(pMsg.m_sbyInfo[5], m_SliceBuf.LASTuk, 2);
   res := FindSmInSliceBuf(item);
   if (res = 1) then begin ReadSliceInBuf(item); FinalAction; exit; end;
   //!!!!!!!!!!
   SetStartEndReadPoint;
   //!!!!!!!!!!
   if mCurrSlice > 0 then
   begin
     m_SliceReadSt := STSL_STKV116_READ_SLICE;
     CreateSliceReq(nReq);
   end else
     FinalAction;
   }
end;

{
 _last = packed record
      DTSMALL : WORD;           // Дата и время ( укороченный вариант )
      value   : WORD;           // Мощность (за 15, 30, 45, 60 минут) кратно 1 Wh
      CRC     : WORD;
    End;
}
procedure CE9STKVer51Meter.ReadSliceAns(var pMsg: CMessage);
var
    i,j,res,nPoint,nPoint0 : integer;
    //pVal  : _srez;
    pVal  : _last;
    pData : CStk43Srez;
    dtDate,tmpDate: TDateTime;
    dbVal : Double;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_last));     //dsf
   pVal.DTSMALL := swap(pVal.DTSMALL);
   //pVal.value := swap(pVal.value);
   //if m_bData.FPUTStk(CStkType(pData))=0 then TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Error PUT: DATE:'+DateTimeToStr(pData.DATETIME)+' VAL:'+FloatToStr(pData.dbEnergy[0])) else
   //                                   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Ok    PUT: DATE:'+DateTimeToStr(pData.DATETIME)+' VAL:'+FloatToStr(pData.dbEnergy[0]));
   if (nReq.m_swSpecc0<>0) then
   Begin
    tmpDate := GetUIntDate(pVal.DTSMALL){-EncodeTime(0, 30, 0, 0)};
    if tmpDate=0 then
    Begin
     SetUnknownSliceByIndex(QRY_SRES_ENR_EP,nReq.m_swSpecc2);
     FinalAction;
     exit;
    End;
    pData.szSize   := Sizeof(CStk43Srez);
    //pData.szSize   := sizeof(Word)+sizeof(TDateTime)+sizeof(Double);
    pData.DATETIME := tmpDate;
    pData.dbEnergy := pVal.value[1];
    m_bData.FPUTStk43(pData);
    //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Spec0:');
    dtDate := GetDTFromSM(nReq.m_swSpecc0);
    TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Find Date:'+DateTimeToStr(dtDate)+' TempDate:'+DateTimeToStr(tmpDate)+' VAL:'+FloatToStr(pData.dbEnergy));
    if m_bData.FINDStk43(dtDate,pData)=False then
    Begin
     TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Error: DATE:'+DateTimeToStr(dtDate)+' VAL:'+FloatToStr(pData.dbEnergy));
     SetUnknownSliceByIndex(QRY_SRES_ENR_EP,nReq.m_swSpecc2);
    End else
    Begin
     TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')New: DATE:'+DateTimeToStr(pData.DATETIME)+' VAL:'+FloatToStr(pData.dbEnergy));
     SendSliceToByIndexL3(pData.dbEnergy,QRY_SRES_ENR_EP,nReq.m_swSpecc2,pData.DATETIME);
    End;
   End;
   FinalAction;
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer51::>Srez:'+
   ' DT:' + DateTimeToStr(tmpDate)+
   ' E+:' + FloatTostrF(pVal.PHS[3].PWR[0],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.PHS[3].PWR[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.PHS[3].PWR[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.PHS[3].PWR[5],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.PHS[3].PWR[2],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.PHS[3].PWR[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.PHS[3].PWR[4],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.PHS[3].PWR[5],ffFixed,6,4));
   }
end;


procedure CE9STKVer51Meter.SendSliceToL3(dValue:Double;wType:Word;dtDate:TDateTime);
begin
   FillSaveDataMessage(dValue, wType, 0, dtDate);
   m_nRxMsg.m_sbyServerID := round(frac(dtDate) / EncodeTime(0, 30, 0, 0));
   //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nRxMsg.m_sbyServerID)+')Srez/Date:'+DateTimeToStr(dtDate));
   FPUT(BOX_L3, @m_nRxMsg);
end;
procedure CE9STKVer51Meter.SendSliceToByIndexL3(dValue:Double;wType:Word;nIndex:Integer;dtDate:TDateTime);
begin
   FillSaveDataMessage(dValue/1*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, wType, 0, dtDate);
   m_nRxMsg.m_sbyServerID := nIndex;
   //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nRxMsg.m_sbyServerID)+')Srez/Date:'+DateTimeToStr(dtDate));
   FPUT(BOX_L3, @m_nRxMsg);
end;

procedure CE9STKVer51Meter.SetUnknownSlice(wType:Word);
var tempDate : TDateTime;
begin
   tempDate := GetDTFromSM(nReq.m_swSpecc0);
   FillSaveDataMessage(0, wType, 0, tempDate);
   m_nRxMsg.m_sbyServerID := round(frac(tempDate) / EncodeTime(0, 30, 0, 0)){ or $80};
   FPUT(BOX_L3, @m_nRxMsg);
end;
procedure CE9STKVer51Meter.SetUnknownSliceByIndex(wType:Word;nIndex:Integer);
var tempDate : TDateTime;
begin
   tempDate := GetDTFromSM(nReq.m_swSpecc0);
   FillSaveDataMessage(0, wType, 0, tempDate);
   m_nRxMsg.m_sbyServerID := nIndex;
   FPUT(BOX_L3, @m_nRxMsg);
end;
procedure CE9STKVer51Meter.ReadSlicesPackAns(var pMsg: CMessage);
begin

   case m_SliceReadSt of
     //STSL_STKV116_READ_PERIOD : ReadSlicePeriodAns(pMsg);
    STSL_STKV116_READ_POINT  : ReadPointSliceAns(pMsg);
    STSL_STKV116_READ_SLICE  : ReadSliceAns(pMsg);
   end;

   //ReadSliceAns(pMsg);
end;

procedure CE9STKVer51Meter.ReadJrnlAns(var pMsg: CMessage);
var i, uk : integer;
    tDate : TDateTime;
    time  : Cardinal;
begin
   uk := pMsg.m_sbyInfo[23];
   if (uk >= 0) and (uk < 5) then
   begin
      for i := 0 to uk - 1 do
      begin
        move(pMsg.m_sbyInfo[3 + i*4], time, 4);
        tDate := GetULongDate(time);
        if tDate <> 0 then
          SendL3Event(QRY_JRNL_T3,2, EVM_OFF_POWER, m_nP.m_swMID, 0, tDate);
      end;
      for i := uk to 4 do
      begin
        move(pMsg.m_sbyInfo[3 + i*4], time, 4);
        tDate := GetULongDate(time);
        if tDate <> 0 then
          SendL3Event(QRY_JRNL_T3,2, EVM_OFF_POWER, m_nP.m_swMID, 0, tDate);
      end;
   end;
   FinalAction;
end;

procedure CE9STKVer51Meter.GetDataAnswer(var pMsg: CMessage);
begin
   if m_nAutoTMR<>Nil then m_nAutoTMR.OnTimer(10);
   case m_ParamID of
     QRY_ENERGY_SUM_EP   : ReadSpisEnerAns(pMsg);
     QRY_ENERGY_MON_EP   : ReadMonthEnAns(pMsg);
     QRY_SRES_ENR_EP     : ReadSlicesPackAns(pMsg);
     QRY_NAK_EN_MONTH_EP : ReadNakEnMon(pMsg);
     QRY_MGAKT_POW_A     : ReadCurrentParam(pMsg);
     QRY_JRNL_T1, QRY_JRNL_T2,
     QRY_JRNL_T3, QRY_JRNL_T4 : ReadJrnlAns(pMsg)
     else FinalAction;
   end;
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
procedure CE9STKVer51Meter.RES01_GetDataByID_Fail(var pMsg : CMessage);
var
  l_EStr : String;
begin
  if (pMsg.m_sbyInfo[2] = $01) then
    TraceL(3, m_nTxMsg.m_swObjID, 'Ошибка команды: Недопустимый номер ID!')
  else if (pMsg.m_sbyInfo[2] = $02) then
    TraceL(3, m_nTxMsg.m_swObjID, 'Ошибка команды: Недопустимый номер индекса!')
  else if (pMsg.m_sbyInfo[2] = $04) then
    TraceL(3, m_nTxMsg.m_swObjID, 'Ошибка команды: Ошибка CRC блока данных в счетчике!') else
  TraceL(3, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::>' + l_EStr);
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
procedure CE9STKVer51Meter.REQ07_GetDateTime(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
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
 {
 №	Тип	Значение	Описание
0	UCHAR	0x7E	Признак начала пакета
1	UCHAR	0x08	Размер ответа после декодирования и декомпрессии
2	UCHAR	0x07	Ответ "Чтение времени и даты из счетчика"
3	UCHAR	Sec	Секунды
4	UCHAR	Min	Минуты
5	UCHAR	Hour 	Часы
6	UCHAR	Week	День недели (1…7, 1-понедельник)
7	UCHAR	Day	Число
8	UCHAR	Month	Месяц
9-10	UCHAR	Year	Год [YearL,YearH]
11	UCHAR	CRC8	Контрольная сумма пакета данных
 }
procedure CE9STKVer51Meter.RES07_GetDateTime(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;
  LastDate:TDateTime;
begin
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    _yy := (100*Word(pMsg.m_sbyInfo[10]) + pMsg.m_sbyInfo[9])-2000;
    //_yy := 13;
    _mn := pMsg.m_sbyInfo[8];
    _dd := pMsg.m_sbyInfo[7];
    _hh := pMsg.m_sbyInfo[5];
    _mm := pMsg.m_sbyInfo[4];
    _ss := pMsg.m_sbyInfo[3];
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
procedure CE9STKVer51Meter.KorrTime(LastDate : TDateTime);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>   Korrection Time');
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
      m_nRxMsg.m_sbyInfo[0] := 11 + 8;
      m_nRxMsg.m_sbyInfo[1] := QRY_LIM_TIME_KORR;
      m_nRxMsg.m_sbyInfo[2] := Year;
      m_nRxMsg.m_sbyInfo[3] := Month;
      m_nRxMsg.m_sbyInfo[4] := Day;
      m_nRxMsg.m_sbyInfo[5] := Hour;
      m_nRxMsg.m_sbyInfo[6] := Min;
      m_nRxMsg.m_sbyInfo[7] := Sec;
      FPUT(BOX_L3_BY, @m_nRxMsg);
      FinalAction;
      exit;
    end;
    m_QFNC       := $08;
    //m_QTimestamp := Now();

{
Команда "Запись времени и даты в счетчик"
№	Тип	Значение	Описание
0	UCHAR	0x7E	Признак начала пакета
1	UCHAR	0x08	Размер исходных данных
2	UCHAR	0x08	Команда "Запись времени и даты в счетчик"
3	UCHAR	Sec	Секунды
4	UCHAR	Min	Минуты
5	UCHAR	Hour 	Часы
6	UCHAR	Week	День недели (1…7, 1-понедельник)
7	UCHAR	Day	Число
8	UCHAR	Month	Месяц
9-10	UCHAR	Year	Год [YearL,YearH]
11	UCHAR	CRC8	Контрольная сумма пакета данных
}

    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
    m_nTxMsg.m_sbyInfo[0] := $7E;
    m_nTxMsg.m_sbyInfo[1] := $08;
    m_nTxMsg.m_sbyInfo[2] := $08;

    Year := Year + 2000;
    m_nTxMsg.m_sbyInfo[3] := Sec;
    m_nTxMsg.m_sbyInfo[4] := Min;
    m_nTxMsg.m_sbyInfo[5] := Hour;
    m_nTxMsg.m_sbyInfo[6] := cDateTimeR.DayOfWeekEx1(Now);
    m_nTxMsg.m_sbyInfo[7] := Day;
    m_nTxMsg.m_sbyInfo[8] := Month;
    m_nTxMsg.m_sbyInfo[9] := (Year) mod 1000;
    m_nTxMsg.m_sbyInfo[10]:= (Year) div 100;

    EncodePacket(m_nTxMsg.m_sbyInfo);
    m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);
    FillMessageHead(m_nTxMsg, 12);
    SendToL1(BOX_L1, @m_nTxMsg);
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
    if bl_SaveCrEv then
      StartCorrEv(LastDate);
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
procedure CE9STKVer51Meter.RES00_SetDateTime_OK(var pMsg:CMessage);
begin
  if pMsg.m_sbyInfo[2]=0 then
  Begin
   TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::> Время счетчика установлено: ' + DateTimeToStr(Now()));
   m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
   if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
   m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
   if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
  End else
  ErrorCorrEv;
  FinalAction();
  m_QFNC:=0;
end;


procedure CE9STKVer51Meter.CreateJrnlEvReq(var nReq: CQueryPrimitive);
begin
   m_ParamID := QRY_JRNL_T3;
   FillSTKReq(33, 0);
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
procedure CE9STKVer51Meter.REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0f;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $0f;
  //m_nTxMsg.m_sbyInfo[2] := $0f;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_ParamID := QRY_MGAKT_POW_A;
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer51Meter.REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer51::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer51Meter.RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::> Операция с контактором выполнена успешно');
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
procedure CE9STKVer51Meter.RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer51::> Операция с контактором НЕ ВЫПОЛНЕНА!');
  FinalAction();
end;

(*******************************************************************************
 * Формирование задания на считывание суммарной потребленной энергии
 ******************************************************************************)
procedure CE9STKVer51Meter.ADD_RelayState_CTRLQry(_StateID : WORD);
begin
  m_nObserver.ClearCtrlQry();

  m_nObserver.AddCtrlParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddCtrlParam(QRY_RELAY_CTRL, 0, 0, _StateID, 1);
  m_nObserver.AddCtrlParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CE9STKVer51Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();

  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CE9STKVer51Meter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
    
  m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
procedure CE9STKVer51Meter.ADD_Energy_Mon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
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
       Inc(i);
       if i > 24 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i-1, 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
procedure CE9STKVer51Meter.ADD_Energy_NMon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
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
       Inc(i);
       if i > 24 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, (i-1), (i-1)*4*3+0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, (i-1), (i-1)*4*3+1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, (i-1), (i-1)*4*3+2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, (i-1), (i-1)*4*3+3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, (i-1), (i-1)*4*3+4, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CE9STKVer51Meter.AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i, Srez     : integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    DeepSrez    : word;
    sm          : word;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
      sm := 1;
      for Srez := (h*60 + m) div 30 - 1 downto 0 do
      Begin
      {$IFDEF ST51_DEBUG}
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, sm, (d or (mn shl 8)), Srez, 1);
       {$ELSE}
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, sm, d, Srez, 1);
       {$ENDIF}
       sm := sm + 1;
      end;
     End else
     Begin
      Srez := 0;
      sm := 48*(trunc(Now)-trunc(dt_Date1)-1)+ (h*60 + m) div 30 + 1 + 48;
      //sm := 48*(trunc(Now)-trunc(dt_Date1)-1)+ (h*60 + m) div 30 + 2 + 48;//так было
      //sm := 48*(trunc(Now)-trunc(dt_Date1)-1)+ (h*60 + m) div 30 + 2; //так было
      while Srez <= 47 do
      begin
       {$IFDEF ST51_DEBUG}
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, sm, (d or (mn shl 8)), Srez, 1);
       {$ELSE}
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, sm, d, Srez, 1);
       {$ENDIF}
       Srez := Srez + 1;
       sm := sm - 1;
      end;
     End;
     cDateTimeR.DecDate(dt_Date2);
     Inc(DeepSrez);
     if (DeepSrez > 32) then
     Begin
       m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
       exit;
     End
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CE9STKVer51Meter.ADD_Energy_Day_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
    //m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecDate(TempDate);
       Inc(i);
       if i > 60 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i-1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
   {
      m_swSpecc0   : Smallint;
     m_swSpecc1   : Smallint;
     m_swSpecc2   : Smallint;
     m_sbyEnable  : Byte;
   }
end;
procedure CE9STKVer51Meter.ADD_Energy_NAckDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
    //m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecDate(TempDate);
       Inc(i);
       if i > 60 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i-1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
   {
      m_swSpecc0   : Smallint;
     m_swSpecc1   : Smallint;
     m_swSpecc2   : Smallint;
     m_sbyEnable  : Byte;
   }
end;

function CE9STKVer51Meter.GetYear(month, day: integer): integer;
var yN, mN, dN : word;
    tempDate   : TDateTime;
begin
   DecodeDate(Now, yN, mN, dN);
   tempDate := EncodeDate(yN, month, day);
   if tempDate > Now then
     Result := yN - 1
   else
     Result := yN;
end;
function CE9STKVer51Meter.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;
function CE9STKVer51Meter.BCDToInt(_BCD : array of BYTE; _Count : Integer) : Integer;
var
  i : Integer;
  l_Mult : Integer;
begin
  Result := 0;
  l_Mult := 1;
  
  for i := 1 to _Count do
  begin
    Result := Result + (_BCD[i-1] and $0F)*l_Mult;
    l_Mult := l_Mult * 10;
    Result := Result + ((_BCD[i-1] and $F0) shr 4)*l_Mult;
    l_Mult := l_Mult * 10;
  end;
end;
function CE9STKVer51Meter.ArrayBCDToDouble(var mas:array of byte; size : byte):Double;
var i:byte;
begin  //Преобразование из BCD в single
   Result := 0;
   for i:=size-1 downto 0 do
   begin
     Result := Result*100;
     Result := Result + BCDToByte(mas[i]);
   end;
   Result := Result / 100;
end;
function  CE9STKVer51Meter.BCDToByte(hexNumb:byte):byte;
begin //Преобразование BCD в байт
    Result := (hexNumb shr 4)*10 + (hexNumb and $0F);
end;


End.
