unit knsl2EPQSMeter;

//{$DEFINE L2_EPQS_DEBUG}

interface

uses
  Windows, Classes, SysUtils, math,
  utltypes, utlbox, utlconst, knsl2meter, knsl5config, utlmtimer, knsl5tracer,
  utlTimeDate, DESUnit;


type
  CEPQSMeter = class(CMeter)
  private
    //IsUpdate       : BYTE;
    nReq           : CQueryPrimitive;
    mReaEnReadSt   : integer;                   //Состояние чтения рективной энергии
    mTimeReadSt    : integer;                   //Состояние чтения времени
    mSliceReadSt   : integer;                   //Состояние чтения срезов
    mTempValue     : array [0..7] of double;    //Переменные для хранения промежуточного значений реактивной энергии по тарифам
    mTSlValue      : array [0..47] of double;   //Временное хранилище срезов электроэнергии
    mHiRMetN       : integer;                   //Старшая часть случайного числа счетчика
    mLoRMetN       : integer;                   //Младшая часть случайного числа счетчика
    hiRNumb        : integer;
    loRNumb        : integer;
    mCorrVal       : shortint;                  //Значение коррекции
  public
    constructor Create();
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

    procedure   HandQryRoutine(pMsg:CMessage);
    procedure   HandCtrlRoutine(pMsg:CMessage);
    procedure   OnFinHandQryRoutine(var pMsg:CMessage);

  private
    procedure   SetNextReaReadState;
    function    IsEndReadReaEn: boolean;
    function    GetDateFromSM(sm: integer): TDateTime;
    function    GetEPQSDateTime(var buf: array of byte): TDateTime;
    procedure   GetMultFromMSG(var buf: array of byte; var mVal :int64; var mSm, mMult: Double);
    procedure   SaveArchReaQuadr(pID, tCnt: integer; var buf: array of double; tDate: TDateTime);
    procedure   SaveGrReqQuadr(pID: integer; var bufMetVal: array of word; var bufRascVal: array of double; tDate: TDateTime);
    procedure   ReadSumEnAns(var pMsg: CMessage);
    procedure   ReadDayEnAns(var pMsg: CMessage);
    procedure   ReadMonEnAns(var pMsg: CMessage);
    procedure   ReadNakEnAns(var pMsg: CMessage);
    procedure   ReadSresEnAns(var pMsg: CMessage);
    procedure   ReadFreq(var pMsg: CMessage);
    procedure   ReadVolt(var pMsg: CMessage);
    procedure   ReadCurr(var pMsg: CMessage);
    procedure   ReadActPower(var pMsg: CMessage);
    procedure   ReadReaPower(var pMsg: CMessage);
    procedure   ReadKoefPower(var pMsg: CMessage);
    procedure   ReadMomentValAns(var pMsg: CMessage);
    procedure   ReadCorrTimeP1Ans(var pMsg: CMessage);
    procedure   ReadDateTimeAns(var pMsg: CMessage);
    function    CheckControlFields(var pMsg: CMessage): boolean;
    procedure   ReadEPQSAnswer(var pMsg: CMessage);
    procedure   CreateSumEnReq;
    procedure   CreateDayEnReq;
    procedure   CreateMonEnReq;
    procedure   CreateNakEnMonReq;
    procedure   CreatePerTimeReq;
    procedure   CreateNormReq;
    procedure   CreateSresEnReq;
    procedure   CreateMomentParReq;
    procedure   CreateJrnlReq;
    procedure   CreateCorrTimeP1Req;
    procedure   CreateCorrTimeP2Req;
    procedure   CreateDateTimeReq;
    procedure   CreateDataReq;
    function    IsCurrent0Sl: boolean;
    procedure   SetNullStates;
    procedure   FillMessageHead(var pMsg : CHMessage; length : word);
    procedure   CreateEPQSMsg(tab, idx0, idx1: integer);
    procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
    function    GetStringFromFile(FileName : string; nStr : integer) : string;
    procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
    procedure   TestMSG(var pMsg:CMessage);
    function    CRC16(var Buffer : Array of Byte; Count : Integer) : word;
    function    StrToHex(str : string):int64;
    procedure   GetRandNumbers(var hiN, loN: integer);
    procedure   AddEnergyDayGrQry(Date1, Date2: TDateTime);
    procedure   AddEnergyMonGrQry(Date1, Date2: TDateTime);
    procedure   AddNakEnMonGrQry(Date1, Date2: TDateTime);
    procedure   AddSresEnGrQry(Date1, Date2: TDateTime);
  End;
                              
const
  ST_REA_EN_READ_Q1 = 0;        //Чтение квадранта 1 реактивной энергии
  ST_REA_EN_READ_Q2 = 1;        //Чтение квадранта 2 реактивной энергии
  ST_REA_EN_READ_Q3 = 2;        //Чтение квадранта 3 реактивной энергии
  ST_REA_EN_READ_Q4 = 3;        //Чтение квадранта 4 реактивной энергии

  ST_READ_DATE_TIME = 0;        //Состояние чтения времени
  ST_CORR_TIME_P1 = 1;          //Состояние коррекции времени отсылка пакета на коррекцию
  ST_CORR_TIME_P2 = 2;          //Потдтвреждение коррекции


  _2_32 = 4294967296;

implementation

//Добавляет к списку опроса приращение за день
procedure CEPQSMeter.AddEnergyDayGrQry(Date1, Date2: TDateTime);
var i: integer;
begin
   for i := trunc(Date1) to trunc(Date2) do
   begin
     if trunc(i) > trunc(Now) then
       break;
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EM, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_RM, trunc(Now) - i, 0, 0, 1);
   end;
end;

//Добавляет к списку опроса приращение за месяц
procedure CEPQSMeter.AddEnergyMonGrQry(Date1, Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   if (cDateTimeR.CompareMonth(Date2, Now) = 1 ) then
     Date2 := Now;
   while cDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(Date2);
   end;
end;

//Добавляет к списку опроса накопленную энергию на начало месяца
procedure CEPQSMeter.AddNakEnMonGrQry(Date1, Date2: TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   if (cDateTimeR.CompareMonth(Date2, Now) = 1 ) then
     Date2 := Now;
   while cDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EM, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RP, abs(i + 1), 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_RM, abs(i + 1), 0, 0, 1);
     cDateTimeR.DecMonth(Date2);
   end;
end;

//Добавляет к списку опроса срезы электроэнергии
procedure CEPQSMeter.AddSresEnGrQry(Date1, Date2: TDateTime);
var i : integer;
begin
   for i := trunc(Date1) to trunc(Date2) do
   begin
     if trunc(i) > trunc(Now) then
       break;
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EM, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_RP, trunc(Now) - i, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_SRES_ENR_RM, trunc(Now) - i, 0, 0, 1);
   end;
end;

//Формирование заголовка сообщения, перед посылкой на 1 уровень
procedure CEPQSMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_EPQS;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

//Формирование запроса на чтение данных по tab, idx0, idx1
procedure CEPQSMeter.CreateEPQSMsg(tab, idx0, idx1: integer);
var Adr  : int64;
    CRC  : word;
begin
   m_nTxMsg.m_sbyInfo[0] := $0E;                //Количество байт в запросе
   Adr := StrToHex(m_nP.m_sddPHAddres);
   Move(Adr, m_nTxMsg.m_sbyInfo[1], 6);         //Адрес 6 байт в формате BCD
   m_nTxMsg.m_sbyInfo[7] := $01;                //Адрес компа
   m_nTxMsg.m_sbyInfo[8] := $01;                //Тип запрса REQ=1
   m_nTxMsg.m_sbyInfo[9] := tab;
   m_nTxMsg.m_sbyInfo[10]:= idx0;
   m_nTxMsg.m_sbyInfo[11]:= idx1;
   CRC := CRC16(m_nTxMsg.m_sbyInfo[0], 12);
   m_nTxMsg.m_sbyInfo[12] := lo(CRC);
   m_nTxMsg.m_sbyInfo[13] := hi(CRC);
   FillMessageHead(m_nTxMsg, 14);
end;

//Формирование заголовка сообщения, перед посылкой на 3 уровень
procedure CEPQSMeter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
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
   m_nRxMsg.m_sbyDirID   := IsUpdate;
   m_nRxMsg.m_sbyServerID := 0;
end;

//Переход на чтение следующего квадранта реактивной электроэнергии
procedure CEPQSMeter.SetNextReaReadState;
begin
   case nReq.m_swParamID of
        QRY_ENERGY_SUM_RP, QRY_ENERGY_DAY_RP,
        QRY_ENERGY_MON_RP, QRY_NAK_EN_MONTH_RP,
        QRY_SRES_ENR_RP                          : mReaEnReadSt := ST_REA_EN_READ_Q2;
        QRY_ENERGY_SUM_RM, QRY_ENERGY_DAY_RM,
        QRY_ENERGY_MON_RM, QRY_NAK_EN_MONTH_RM,
        QRY_SRES_ENR_RM                          : mReaEnReadSt := ST_REA_EN_READ_Q4;
   end;
end;

//Проверяет в каком сотоянии находится чтение реактивной электроэнергии
function CEPQSMeter.IsEndReadReaEn: boolean;
begin
   if (mReaEnReadSt = ST_REA_EN_READ_Q2) or (mReaEnReadSt = ST_REA_EN_READ_Q4) then
     Result := true
   else
     Result := false;
end;

//Функция в зависимости от параметра sm возвращает дату этого параметра
function CEPQSMeter.GetDateFromSM(sm: integer): TDateTime;
var tmpDate : TDateTime;
begin
   tmpDate := trunc(now);
   case nReq.m_swParamID of
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : Result := tmpDate + 1 - sm;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : Result := tmpDate - sm;
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
     QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM,
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  :

       begin
         tmpDate := cDateTimeR.GetBeginMonth(tmpDate);
         if sm = 0 then
           cDateTimeR.IncMonth(tmpDate)
         else
           cDateTimeR.DecMonthEx(sm - 1, tmpDate);
         Result := tmpDate;
       end;
     else Result := Now;
   end;
end;


//Извлечение времени в формате EPQS
function CEPQSMeter.GetEPQSDateTime(var buf: array of byte): TDateTime;
var yy, mm, dd, hh, nn, ss, ms : word;
    tmp                        : integer;
begin
   try
     move(buf[0], tmp, 4);
     ms := 0;
     ss := (tmp and $1F) * 2;
     nn := (tmp and $7E0) shr 5;
     hh := (tmp and $F800) shr 11;
     dd := (tmp and $1F0000) shr 16;
     mm := (tmp and $1E00000) shr 21;
     yy := ((tmp and $FE000000) shr 25) + 2000;
     Result := EncodeDate(yy, mm, dd) + EncodeTime(hh, nn, ss, ms);
   except
     Result := Now;
   end;
end;

//Чтение множителей
//mVal - множитель значения
//mSm - количество цифр после запятой
//mMult - множитель дименсии
procedure CEPQSMeter.GetMultFromMSG(var buf: array of byte; var mVal :int64; var mSm, mMult: Double);
begin
   mVal := 0;
   move(buf[0], mVal, 6);
   mSm := Power(10, buf[6] * -1);
   case buf[7] of
     $20 : mMult := 0.001;
     $6B : mMult := 1.0;
     $4D : mMult := 1000.0;
     $47 : mMult := 1000000.0;
     else mMult := 1.0;
   end;
end;

//Сохранение архивных пезультатов в требуемых квадрантах
procedure CEPQSMeter.SaveArchReaQuadr(pID, tCnt: integer; var buf: array of double; tDate: TDateTime);
var curPID, i : integer;
begin
   case pID of
     QRY_ENERGY_SUM_RP :
       if mReaEnReadSt = ST_REA_EN_READ_Q1 then
         curPID := QRY_ENERGY_SUM_R1
       else
         curPID := QRY_ENERGY_SUM_R2;
     QRY_ENERGY_SUM_RM :
       if mReaEnReadSt = ST_REA_EN_READ_Q3 then
         curPID := QRY_ENERGY_SUM_R3
       else
         curPID := QRY_ENERGY_SUM_R4;
     QRY_ENERGY_DAY_RP :
       if mReaEnReadSt = ST_REA_EN_READ_Q1 then
         curPID := QRY_ENERGY_DAY_R1
       else
         curPID := QRY_ENERGY_DAY_R2;
     QRY_ENERGY_DAY_RM :
       if mReaEnReadSt = ST_REA_EN_READ_Q3 then
         curPID := QRY_ENERGY_DAY_R3
       else
         curPID := QRY_ENERGY_DAY_R4;
     QRY_ENERGY_MON_RP :
       if mReaEnReadSt = ST_REA_EN_READ_Q1 then
         curPID := QRY_ENERGY_MON_R1
       else
         curPID := QRY_ENERGY_MON_R2;
     QRY_ENERGY_MON_RM :
       if mReaEnReadSt = ST_REA_EN_READ_Q3 then
         curPID := QRY_ENERGY_MON_R3
       else
         curPID := QRY_ENERGY_MON_R4;
     QRY_NAK_EN_MONTH_RP :
       if mReaEnReadSt = ST_REA_EN_READ_Q1 then
         curPID := QRY_NAK_EN_MONTH_R1
       else
         curPID := QRY_NAK_EN_MONTH_R2;
     QRY_NAK_EN_MONTH_RM :
       if mReaEnReadSt = ST_REA_EN_READ_Q3 then
         curPID := QRY_NAK_EN_MONTH_R3
       else
         curPID := QRY_NAK_EN_MONTH_R4;
     else
       exit;
   end;
   for i := 0 to tCnt - 1 do
   begin
     CreateOutMSG(buf[i], curPID, i + 1, tDate);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;

//Сохранение графиков в требуемых квадрантах
procedure CEPQSMeter.SaveGrReqQuadr(pID: integer; var bufMetVal: array of word; var bufRascVal: array of double; tDate: TDateTime);
var i, curPID : integer;
    _30Min    : TDateTime;
begin
   _30Min := EncodeTime(0, 30, 0, 0);
   case pID of
     QRY_SRES_ENR_RP :
       if mReaEnReadSt = ST_REA_EN_READ_Q1 then
         curPID := QRY_SRES_ENR_R1
       else
         curPID := QRY_SRES_ENR_R2;
     QRY_SRES_ENR_RM :
       if mReaEnReadSt = ST_REA_EN_READ_Q3 then
         curPID := QRY_SRES_ENR_R3
       else
         curPID := QRY_SRES_ENR_R4;
     else
       exit;
   end;
   for i := 0 to 47 do
   begin
     CreateOutMSG(bufRascVal[i], curPID, 0, tDate + _30Min*i);
     m_nRxMsg.m_sbyServerID := i;
     if bufMetVal[i] = $FFFF then
       continue;//m_nRxMsg.m_sbyServerID := m_nRxMsg.m_sbyServerID or $80;
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;


//Чтение ответа на суммарную энергию
procedure CEPQSMeter.ReadSumEnAns(var pMsg: CMessage);
var tarCount, i            : integer;
    tmp                    : cardinal;
    mVal                   : int64;
    mMult, mSM             : Double;
    Values                 : array [0..7] of double;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[16], mVal, mSM, mMult);
   tarCount := pMsg.m_sbyInfo[13];

   for i := 0 to tarCount - 1 do
   begin
     move(pMsg.m_sbyInfo[24 + tarCount*4 + i*4], tmp, 4);
     Values[i] := tmp * mVal * mSM * mMult /_2_32 * m_nP.m_sfKI * m_nP.m_sfKU;
   end;

   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM :
     begin
       for i := 0 to tarCount - 1 do
       begin
         CreateOutMSG(Values[i], nReq.m_swParamID, i + 1, Now);
         FPUT(BOX_L3_BY, @m_nRxMsg);
       end;
       FinalAction;
     end;
     else
       if IsEndReadReaEn then
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, Now);
         for i := 0 to tarCount - 1 do
         begin
           CreateOutMSG(Values[i] + mTempValue[i], nReq.m_swParamID, i + 1, Now);
           FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
       end else
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, Now);
         SetNextReaReadState;
         move(Values, mTempValue, sizeof(Double) * Length(mTempValue));
         CreateDataReq;
       end;
   end;
end;

//Чтение ответа на приращение энергии за день
procedure CEPQSMeter.ReadDayEnAns(var pMsg: CMessage);
var tarCount, i            : integer;
    tmp                    : cardinal;
    mVal                   : int64;
    mMult, mSM             : Double;
    Values                 : array [0..7] of double;
    dtRead                 : TDateTime;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[16], mVal, mSM, mMult);
   tarCount := pMsg.m_sbyInfo[13];
   dtRead := GetDateFromSM(nReq.m_swSpecc0);

   for i := 0 to tarCount - 1 do
   begin
     move(pMsg.m_sbyInfo[24 + i*4], tmp, 4);
     Values[i] := tmp * mVal * mSM * mMult /_2_32 * m_nP.m_sfKI * m_nP.m_sfKU;
   end;

   case nReq.m_swParamID of
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM :
     begin
       for i := 0 to tarCount - 1 do
       begin
         CreateOutMSG(Values[i], nReq.m_swParamID, i + 1, dtRead);
         FPUT(BOX_L3_BY, @m_nRxMsg);
       end;
       FinalAction;
     end;
     else
       if IsEndReadReaEn then
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, dtRead);
         for i := 0 to tarCount - 1 do
         begin
           CreateOutMSG(Values[i] + mTempValue[i], nReq.m_swParamID, i + 1, dtRead);
           FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
       end else
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, dtRead);
         SetNextReaReadState;
         move(Values, mTempValue, sizeof(Double) * Length(mTempValue));
         CreateDataReq;
       end;
   end;
end;

//Чтение ответа на приращения энергии за месяц
procedure CEPQSMeter.ReadMonEnAns(var pMsg: CMessage);
var tarCount, i            : integer;
    tmp                    : cardinal;
    mVal                   : int64;
    mMult, mSM             : Double;
    Values                 : array [0..7] of double;
    dtRead                 : TDateTime;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[16], mVal, mSM, mMult);
   tarCount := pMsg.m_sbyInfo[13];
   dtRead := GetDateFromSM(nReq.m_swSpecc0);

   for i := 0 to tarCount - 1 do
   begin
     move(pMsg.m_sbyInfo[24 + i*4], tmp, 4);
     Values[i] := tmp * mVal * mSM * mMult /_2_32 * m_nP.m_sfKI * m_nP.m_sfKU;
   end;

   case nReq.m_swParamID of
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM :
     begin
       for i := 0 to tarCount - 1 do
       begin
         CreateOutMSG(Values[i], nReq.m_swParamID, i + 1, dtRead);
         FPUT(BOX_L3_BY, @m_nRxMsg);
       end;
       FinalAction;
     end;
     else
       if IsEndReadReaEn then
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, dtRead);
         for i := 0 to tarCount - 1 do
         begin
           CreateOutMSG(Values[i] + mTempValue[i], nReq.m_swParamID, i + 1, dtRead);
           FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
       end else
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, dtRead);
         SetNextReaReadState;
         move(Values, mTempValue, sizeof(Double) * Length(mTempValue));
         CreateDataReq;
       end;
   end;
end;

//Чтение ответа на накопленную энергию на начало месяца
procedure CEPQSMeter.ReadNakEnAns(var pMsg: CMessage);
var tarCount, i            : integer;
    tmp                    : cardinal;
    mVal                   : int64;
    mMult, mSM             : Double;
    Values                 : array [0..7] of double;
    dtRead                 : TDateTime;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[16], mVal, mSM, mMult);
   tarCount := pMsg.m_sbyInfo[13];
   dtRead := GetDateFromSM(nReq.m_swSpecc0);

   for i := 0 to tarCount - 1 do
   begin
     move(pMsg.m_sbyInfo[24 + i*4], tmp, 4);
     Values[i] := tmp * mVal * mSM * mMult /_2_32 * m_nP.m_sfKI * m_nP.m_sfKU;
   end;

   case nReq.m_swParamID of
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM :
     begin
       for i := 0 to tarCount - 1 do
       begin
         CreateOutMSG(Values[i], nReq.m_swParamID, i + 1, dtRead);
         FPUT(BOX_L3_BY, @m_nRxMsg);
       end;
       FinalAction;
     end;
     else
       if IsEndReadReaEn then
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, dtRead);
         for i := 0 to tarCount - 1 do
         begin
           CreateOutMSG(Values[i] + mTempValue[i], nReq.m_swParamID, i + 1, dtRead);
           FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
       end else
       begin
         SaveArchReaQuadr(nReq.m_swParamID, tarCount, Values, dtRead);
         SetNextReaReadState;
         move(Values, mTempValue, sizeof(Double) * Length(mTempValue));
         CreateDataReq;
       end;
   end;
end;

//Чтение ответа на срез электроэнергии
procedure CEPQSMeter.ReadSresEnAns(var pMsg: CMessage);
var mVal               : int64;
    i                  : integer;
    mMult, mSM, Value  : Double;
    tmp                : array [0..47] of word;
    tmp_val            : array [0..47] of double;
    dtRead, _30Min     : TDateTime;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[19], mVal, mSM, mMult);
   dtRead := GetDateFromSM(nReq.m_swSpecc0);
   _30Min := EncodeTime(0, 30, 0, 0);
   {$IFDEF L2_EPQS_DEBUG}
    for i := 0 to 47 do
     Begin
      tmp[0] := $FFFF;
      move(tmp[0],pMsg.m_sbyInfo[27 + i*2], 2);
     End;
    if (dtRead = trunc(Now)) then
    Begin
     for i := 0 to trunc(frac(Now)/_30Min) do
     Begin
      tmp[0] := 1000+i*8;
      move(tmp[0],pMsg.m_sbyInfo[27 + i*2], 2);
     End;
    End else
    if (dtRead<>trunc(Now)) then
    Begin
     for i := 0 to 47 do
     Begin
      tmp[0] := 1000+i*8;
      move(tmp[0],pMsg.m_sbyInfo[27 + i*2], 2);
     End;
    End;
   {$ENDIF}
   for i := 0 to 47 do
   begin
     move(pMsg.m_sbyInfo[27 + i*2], tmp[i], 2);
     if tmp[i] <> $FFFF then
       tmp_val[i] := tmp[i] * mVal * mSM * mMult  /_2_32 * m_nP.m_sfKI * m_nP.m_sfKU
     else
       tmp_val[i] := 0.0;
     if (dtRead = trunc(Now)) and (i = trunc(frac(Now) / _30Min)) then
       tmp[i] := $FFFF;
   end;
   case nReq.m_swParamID of
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM :
     begin
       for i := 0 to 47 do
       begin
         CreateOutMSG(tmp_val[i], nReq.m_swParamID, 0, dtRead + _30Min*i);
         m_nRxMsg.m_sbyServerID := i;
         if tmp[i] = $FFFF then
           continue;//m_nRxMsg.m_sbyServerID := m_nRxMsg.m_sbyServerID or $80;
         FPUT(BOX_L3_BY, @m_nRxMsg);
       end;
       FinalAction;
     end;
     else
     begin
       if IsEndReadReaEn then
       begin
         SaveGrReqQuadr(nReq.m_swParamID, tmp, tmp_val, dtRead);
         for i := 0 to 47 do
         begin
           CreateOutMSG(tmp_val[i] + mTSlValue[i], nReq.m_swParamID, 0, dtRead + _30Min*i);
           m_nRxMsg.m_sbyServerID := i;
           if tmp[i] = $FFFF then
             continue;//m_nRxMsg.m_sbyServerID := m_nRxMsg.m_sbyServerID or $80;
           FPUT(BOX_L3_BY, @m_nRxMsg);
         end;
         FinalAction;
       end else
       begin
         SaveGrReqQuadr(nReq.m_swParamID, tmp, tmp_val, dtRead);
         SetNextReaReadState;
         move(tmp_val, mTSlValue, sizeof(Double) * Length(mTSlValue));
         CreateDataReq;
       end;
     end;
   end;
end;

//Чтение частоты
procedure CEPQSMeter.ReadFreq(var pMsg: CMessage);
var mVal                   : int64;
    mMult, mSM, Value      : Double;
    tmp                    : integer;
begin
    GetMultFromMSG(pMsg.m_sbyInfo[13], mVal, mSM, mMult);
    mMult := mMult * 1000;
    tmp := 0;
    move(pMsg.m_sbyInfo[61], tmp, 2);
    Value := tmp * mVal * mSM * mMult / _2_32;
    CreateOutMSG(Value, QRY_FREQ_NET, 0, Now);
    FPUT(BOX_L3_BY, @m_nRxMsg);
end;

//Чтение напряжения
procedure CEPQSMeter.ReadVolt(var pMsg: CMessage);
var mVal                   : int64;
    mMult, mSM, Value      : Double;
    tmp, i                 : integer;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[21], mVal, mSM, mMult);
   mMult := mMult * 1000;
   for i := 0 to 2 do
   begin
     tmp := 0;
     move(pMsg.m_sbyInfo[63 + i*2], tmp, 2);
     Value := tmp * mVal * mSM * mMult / _2_32 * m_nP.m_sfKU;
     CreateOutMSG(Value, QRY_U_PARAM_A + i, 0, Now);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;

//Чтение тока
procedure CEPQSMeter.ReadCurr(var pMsg: CMessage);
var mVal                   : int64;
    mMult, mSM, Value      : Double;
    tmp, i                 : integer;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[29], mVal, mSM, mMult);
   mMult := mMult * 1000;
   for i := 0 to 2 do
   begin
     tmp := 0;
     move(pMsg.m_sbyInfo[69 + i*2], tmp, 2);
     Value := tmp * mVal * mSM * mMult / _2_32 * m_nP.m_sfKI;
     CreateOutMSG(Value, QRY_I_PARAM_A + i, 0, Now);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;

//Чтение активной мощности
procedure CEPQSMeter.ReadActPower(var pMsg: CMessage);
var mVal                   : int64;
    mMult, mSM, Value, Sum : Double;
    tmp, i                 : integer;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[37], mVal, mSM, mMult);
   Sum := 0;
   for i := 0 to 2 do
   begin
     tmp := 0;
     move(pMsg.m_sbyInfo[75 + i*2], tmp, 2);
     Value := tmp * mVal * mSM * mMult / _2_32 * m_nP.m_sfKI * m_nP.m_sfKU;
     Sum := Sum + Value;
     CreateOutMSG(Value, QRY_MGAKT_POW_A + i, 0, Now);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   CreateOutMSG(Sum, QRY_MGAKT_POW_A, 0, Now);
   FPUT(BOX_L3_BY, @m_nRxMsg);
end;

//Чтение реактивной мощности
procedure CEPQSMeter.ReadReaPower(var pMsg: CMessage);
var mVal                   : int64;
    mMult, mSM, Value, Sum : Double;
    i                      : integer;
    tmp                    : smallint;	
begin
   Sum := 0;
   GetMultFromMSG(pMsg.m_sbyInfo[37], mVal, mSM, mMult);
   for i := 0 to 2 do
   begin
     tmp := 0;
     move(pMsg.m_sbyInfo[81 + i*2], tmp, 2);
     Value := tmp * mVal * mSM * mMult / _2_32 * m_nP.m_sfKI * m_nP.m_sfKU;
     Sum := Sum + Value;
     CreateOutMSG(Value, QRY_MGREA_POW_A + i, 0, Now);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
   CreateOutMSG(Sum, QRY_MGREA_POW_S, 0, Now);
   FPUT(BOX_L3_BY, @m_nRxMsg);
end;

//Чтение коэффициента мощности
procedure CEPQSMeter.ReadKoefPower(var pMsg: CMessage);
var mVal                   : int64;
    mMult, mSM, Value      : Double;
    tmp, i                 : integer;
begin
   GetMultFromMSG(pMsg.m_sbyInfo[45], mVal, mSM, mMult);
   mMult := mMult * 1000;
   for i := 0 to 2 do
   begin
     tmp := 0;
     move(pMsg.m_sbyInfo[93 + i*2], tmp, 2);
     Value := tmp * mVal * mSM * mMult / _2_32;
     CreateOutMSG(Value, QRY_KOEF_POW_A + i, 0, Now);
     FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
end;

//Чтение моментых величин
procedure CEPQSMeter.ReadMomentValAns(var pMsg: CMessage);
begin
   ReadFreq(pMsg);
   ReadVolt(pMsg);
   ReadCurr(pMsg);
   ReadActPower(pMsg);
   ReadReaPower(pMsg);
   ReadKoefPower(pMsg);
   FinalAction;
end;

//Чтение случайного числа при коррекции времени
procedure CEPQSMeter.ReadCorrTimeP1Ans(var pMsg: CMessage);
var buf, pass, res : array [0..7] of byte;
    res1, res2     : integer;
begin
   mTimeReadSt := ST_CORR_TIME_P2;
   move(loRNumb, buf[0], 4);
   move(hiRNumb, buf[4], 4);
   move(m_nP.m_schPassword[1], pass[0], 8);
   DES(buf, res, pass, false);
   move(buf[0], res1, 4);
   move(buf[4], res2, 4);
   {if (res1 <> loRNumb) and (res2 <> hiRNumb) then
   begin
     TraceL(3, m_nP.m_swMID,'(__)CL2MD::> Неверный пароль');
     FinalAction;
     exit;
   end;  }
   if pMsg.m_sbyInfo[0] = $1E then
   begin
     move(pMsg.m_sbyInfo[17], mLoRMetN, 4);
     move(pMsg.m_sbyInfo[21], mHiRMetN, 4);
     CreateDataReq;
   end
   else
   begin
     FinalAction;
   end;
end;

//Чтение ответа на чтение/коррекции времени
procedure CEPQSMeter.ReadDateTimeAns(var pMsg: CMessage);
var tmpDate    : TDateTime;
    tmpCorrVal : double;
begin
   case mTimeReadSt of
     ST_READ_DATE_TIME  : tmpDate := GetEPQSDateTime(pMsg.m_sbyInfo[9]);
     ST_CORR_TIME_P1    : ReadCorrTimeP1Ans(pMsg);
     ST_CORR_TIME_P2    :
       begin
        if pMsg.m_sbyInfo[8] = $06 then
          TraceL(2, m_nP.m_swMID,'(__)CL2MD::> CEPQS Время скоректировано')
        else
          TraceL(2, m_nP.m_swMID,'(__)CL2MD::> CEPQS Время не скоректировано!!!');
          FinalAction;
       end;
   end;
   if (abs(tmpDate - Now) > EncodeTime(0, 0, 5, 0)) and (mTimeReadSt = ST_READ_DATE_TIME) then
   begin
     mTimeReadSt := ST_CORR_TIME_P1;
     tmpCorrVal := (Now - tmpDate) / EncodeTime(0, 0, 1, 0);
     if abs(tmpCorrVal) < 50 then
       mCorrVal := trunc(tmpCorrVal)
     else if (tmpCorrVal < 0) then
       mCorrVal := -50
     else
       mCorrVal := 50;
     TraceL(2, m_nP.m_swMID,'(__)CL2MD::> CEPQS Коррекция на ' + IntToStr(mCorrVal) + ' секунд' );
     CreateDataReq;
   end else if (mTimeReadSt = ST_READ_DATE_TIME) then
     FinalAction;
end;

//Проверка контрольных полей
function CEPQSMeter.CheckControlFields(var pMsg: CMessage): boolean;
var crcMsg, crcCalc: integer;
begin
   Result := false;
   //{$IFNDEF L2_EPQS_DEBUG}
   if (pMsg.m_sbyInfo[0] < $90) and (pMsg.m_sbyInfo[0] > 2) then
   begin
     crcCalc := CRC16(pMsg.m_sbyInfo[0], pMsg.m_sbyInfo[0] - 2);
     crcMsg := (pMsg.m_sbyInfo[pMsg.m_sbyInfo[0] - 1] shl 8) + pMsg.m_sbyInfo[pMsg.m_sbyInfo[0] - 2];
     if (crcMsg = crcCalc) then
       Result := true;
   end;
   //{$ELSE}
   //Result := true;
   //{$ENDIF}
end;

//Чтение принятого пакета от счетчика
procedure CEPQSMeter.ReadEPQSAnswer(var pMsg: CMessage);
begin
   if CheckControlFields(pMsg) then
   begin
      case nReq.m_swParamID of
        QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
        QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM      : ReadSumEnAns(pMsg);
        QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
        QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : ReadDayEnAns(pMsg);
        QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
        QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : ReadMonEnAns(pMsg);
        QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
        QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : ReadNakEnAns(pMsg);
        QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
        QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : ReadSresEnAns(pMsg);
        QRY_MGAKT_POW_S, QRY_MGAKT_POW_A,
        QRY_MGAKT_POW_B, QRY_MGAKT_POW_C,
        QRY_MGREA_POW_S, QRY_MGREA_POW_A,
        QRY_MGREA_POW_B, QRY_MGREA_POW_C,
        QRY_U_PARAM_S, QRY_U_PARAM_A,
        QRY_U_PARAM_B, QRY_U_PARAM_C,
        QRY_I_PARAM_S, QRY_I_PARAM_A,
        QRY_I_PARAM_B, QRY_I_PARAM_C,
        QRY_FREQ_NET, QRY_KOEF_POW_A,
        QRY_KOEF_POW_B, QRY_KOEF_POW_C            : ReadMomentValAns(pMsg);
        QRY_DATA_TIME                             : ReadDateTimeAns(pMsg);
      end;
   end;
end;

//Формирование запроса на чтение суммарной энергии
procedure CEPQSMeter.CreateSumEnReq;
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP :  CreateEPQSMsg($20, $00, $08 + $00);
     QRY_ENERGY_SUM_EM :  CreateEPQSMsg($20, $00, $08 + $01);
     else case mReaEnReadSt of
       ST_REA_EN_READ_Q1 : CreateEPQSMsg($20, $00, $08 + $02);
       ST_REA_EN_READ_Q2 : CreateEPQSMsg($20, $00, $08 + $03);
       ST_REA_EN_READ_Q3 : CreateEPQSMsg($20, $00, $08 + $04);
       ST_REA_EN_READ_Q4 : CreateEPQSMsg($20, $00, $08 + $05);
     end;
   end;
end;

//Формирование запроса на чтение приращения за день и дневных архивов
procedure CEPQSMeter.CreateDayEnReq;
var ind: integer;
begin
   ind := nReq.m_swSpecc0 shl 3;
   case nReq.m_swParamID of
     QRY_ENERGY_DAY_EP : ind := ind + 0;
     QRY_ENERGY_DAY_EM : ind := ind + 1;
     else case mReaEnReadSt of
       ST_REA_EN_READ_Q1 : ind := ind + 2;
       ST_REA_EN_READ_Q2 : ind := ind + 3;
       ST_REA_EN_READ_Q3 : ind := ind + 4;
       ST_REA_EN_READ_Q4 : ind := ind + 5;
     end;
   end;
   CreateEPQSMsg($31, hi(ind), lo(ind));
end;

//Формирование запроса на чтение приращения за месяц и месячных архивов
procedure CEPQSMeter.CreateMonEnReq;
var ind : integer;
begin
   ind := nReq.m_swSpecc0 shl 3;
   case nReq.m_swParamID of
     QRY_ENERGY_MON_EP :  ind := ind + 0;
     QRY_ENERGY_MON_EM :  ind := ind + 1;
     else case mReaEnReadSt of
       ST_REA_EN_READ_Q1 : ind := ind + 2;
       ST_REA_EN_READ_Q2 : ind := ind + 3;
       ST_REA_EN_READ_Q3 : ind := ind + 4;
       ST_REA_EN_READ_Q4 : ind := ind + 5;
     end;
   end;
   CreateEPQSMsg($21, hi(ind), lo(ind));
end;

//Формирование запроса на чтение накопленной энергии на начало месяца
procedure CEPQSMeter.CreateNakEnMonReq;
var ind : integer;
begin
   ind := nReq.m_swSpecc0 shl 3;
   case nReq.m_swParamID of
     QRY_NAK_EN_MONTH_EP :  ind := ind + 0;
     QRY_NAK_EN_MONTH_EM :  ind := ind + 1;
     else case mReaEnReadSt of
       ST_REA_EN_READ_Q1 : ind := ind + 2;
       ST_REA_EN_READ_Q2 : ind := ind + 3;
       ST_REA_EN_READ_Q3 : ind := ind + 4;
       ST_REA_EN_READ_Q4 : ind := ind + 5;
     end;
   end;
   CreateEPQSMsg($20, hi(ind), lo(ind));
end;

//Формирование запроса на чтение перевода летнего/зимнего времени
procedure CEPQSMeter.CreatePerTimeReq;
begin
   CreateEPQSMsg($80, $12, $00);
end;

//Формирование запроса на чтение профиля нагрузки AnormPr - признак чтения перекрытия срезов
procedure CEPQSMeter.CreateNormReq;
begin
   case nReq.m_swParamID of
     QRY_SRES_ENR_EP : CreateEPQSMsg($18, nReq.m_swSpecc0 div 2, (nReq.m_swSpecc0 mod 2) shl 7);
     QRY_SRES_ENR_EM : CreateEPQSMsg($19, nReq.m_swSpecc0 div 2, (nReq.m_swSpecc0 mod 2) shl 7);
     else case mReaEnReadSt of
       ST_REA_EN_READ_Q1 : CreateEPQSMsg($1A, nReq.m_swSpecc0 div 2, (nReq.m_swSpecc0 mod 2) shl 7);
       ST_REA_EN_READ_Q2 : CreateEPQSMsg($1B, nReq.m_swSpecc0 div 2, (nReq.m_swSpecc0 mod 2) shl 7);
       ST_REA_EN_READ_Q3 : CreateEPQSMsg($1C, nReq.m_swSpecc0 div 2, (nReq.m_swSpecc0 mod 2) shl 7);
       ST_REA_EN_READ_Q4 : CreateEPQSMsg($1D, nReq.m_swSpecc0 div 2, (nReq.m_swSpecc0 mod 2) shl 7);
     end;
   end;
end;

//Формирование запроса на чтение профиля нагрузки
procedure CEPQSMeter.CreateSresEnReq;
begin
   CreateNormReq;
end;

//Формирование запроса на чтение моментых величин
procedure CEPQSMeter.CreateMomentParReq;
begin
   CreateEPQSMsg($70, $02, $00);
end;

//Формирование запроса на чтение журнала событий
procedure CEPQSMeter.CreateJrnlReq;
begin
   CreateEPQSMsg($50, $00, $0B);
end;

//Формирование запросов на коррекцию времени
procedure CEPQSMeter.CreateCorrTimeP1Req;
var Adr              : int64;
    CRC              : word;
begin
   GetRandNumbers(hiRNumb, loRNumb);
   m_nTxMsg.m_sbyInfo[0] := $1E;
   Adr := StrToHex(m_nP.m_sddPHAddres);
   Move(Adr, m_nTxMsg.m_sbyInfo[1], 6);         //Адрес 6 байт в формате BCD
   m_nTxMsg.m_sbyInfo[7] := $01;                //Адрес компа
   m_nTxMsg.m_sbyInfo[8] := $03;
   move(hiRNumb, m_nTxMsg.m_sbyInfo[9], 4);
   move(loRNumb, m_nTxMsg.m_sbyInfo[13], 4);
   FillChar(m_nTxMsg.m_sbyInfo[17], 8, 0);
   m_nTxMsg.m_sbyInfo[25] := $A0;
   m_nTxMsg.m_sbyInfo[26] := $00;
   m_nTxMsg.m_sbyInfo[27] := mCorrVal;
   CRC := CRC16(m_nTxMsg.m_sbyInfo[0], 28);
   m_nTxMsg.m_sbyInfo[28] := lo(CRC);
   m_nTxMsg.m_sbyInfo[29] := hi(CRC);
   FillMessageHead(m_nTxMsg, 11 + 30);
end;

procedure CEPQSMeter.CreateCorrTimeP2Req;
var buf, pass, res   : array [0..7] of byte;
    Adr              : int64;
    CRC              : word;
begin
   m_nTxMsg.m_sbyInfo[0] := $1B;
   Adr := StrToHex(m_nP.m_sddPHAddres);
   Move(Adr, m_nTxMsg.m_sbyInfo[1], 6);         //Адрес 6 байт в формате BCD
   m_nTxMsg.m_sbyInfo[7] := $01;                //Адрес компа
   m_nTxMsg.m_sbyInfo[8] := $05;
   FillChar(m_nTxMsg.m_sbyInfo[9], 8, 0);
   try
     move(mLoRMetN, buf[0], 4);
     move(mHiRMetN, buf[4], 4);
     move(m_nP.m_schPassword[1], pass[0], 8);
     DES(buf, res, pass, true);                 //Шифрование случайного числа по DES алгоритму
   except

   end;
   move(res, m_nTxMsg.m_sbyInfo[17], 8);
   CRC := CRC16(m_nTxMsg.m_sbyInfo[0], 25);
   m_nTxMsg.m_sbyInfo[25] := lo(CRC);
   m_nTxMsg.m_sbyInfo[26] := hi(CRC);
   FillMessageHead(m_nTxMsg, 11 + 27);
end;

//Формирование запроса на чтение даты/времени или коррекции
procedure CEPQSMeter.CreateDateTimeReq;
begin
   case mTimeReadSt of
     ST_READ_DATE_TIME : CreateEPQSMsg($70, $00, $00);
     ST_CORR_TIME_P1   : CreateCorrTimeP1Req;
     ST_CORR_TIME_P2   : CreateCorrTimeP2Req;
   end;
end;

function CEPQSMeter.IsCurrent0Sl: boolean;
begin
   if (nReq.m_swSpecc0 = 0) and (frac(Now) <= EncodeTime(0, 30, 0, 0)) then
     Result := true
   else
     Result := false;
end;

//Формирование и отсылка запроса на чтение данных
procedure CEPQSMeter.CreateDataReq;
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
     QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM      : CreateSumEnReq;
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : CreateDayEnReq;
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
     QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : CreateMonEnReq;
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : CreateNakEnMonReq;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          :
        if not IsCurrent0Sl then CreateSresEnReq
        else begin FinalAction; exit; end;
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A,
     QRY_MGAKT_POW_B, QRY_MGAKT_POW_C,
     QRY_MGREA_POW_S, QRY_MGREA_POW_A,
     QRY_MGREA_POW_B, QRY_MGREA_POW_C,
     QRY_U_PARAM_S, QRY_U_PARAM_A,
     QRY_U_PARAM_B, QRY_U_PARAM_C,
     QRY_I_PARAM_S, QRY_I_PARAM_A,
     QRY_I_PARAM_B, QRY_I_PARAM_C,
     QRY_FREQ_NET, QRY_KOEF_POW_A,
     QRY_KOEF_POW_B, QRY_KOEF_POW_C            : CreateMomentParReq;
     QRY_JRNL_T1, QRY_JRNL_T2,
     QRY_JRNL_T3, QRY_JRNL_T4                  : CreateJrnlReq;
     QRY_DATA_TIME                             : CreateDateTimeReq;
     else begin FinalAction; exit; end;
   end;
   SendToL1(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CEPQSMeter.SetNullStates;
begin
   mReaEnReadSt   := ST_REA_EN_READ_Q1;
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_RP, QRY_ENERGY_DAY_RP,
     QRY_ENERGY_MON_RP, QRY_NAK_EN_MONTH_RP,
     QRY_SRES_ENR_RP                          : mReaEnReadSt := ST_REA_EN_READ_Q1;
     QRY_ENERGY_SUM_RM, QRY_ENERGY_DAY_RM,
     QRY_ENERGY_MON_RM, QRY_NAK_EN_MONTH_RM,
     QRY_SRES_ENR_RM                          : mReaEnReadSt := ST_REA_EN_READ_Q3;
   end;
   mTimeReadSt    := ST_READ_DATE_TIME;
end;

constructor CEPQSMeter.Create;
Begin
   TraceL(3, m_nP.m_swMID,'(__)CL2MD::> CEPQS Meter Created');
End;


destructor CEPQSMeter.Destroy;
Begin
    inherited;
End;

procedure CEPQSMeter.InitMeter(var pL2:SL2TAG);
begin
   IsUpdate := 0;
   SetNullStates;
   SetHandScenario;
   SetHandScenarioGraph;
   TraceL(3,m_nP.m_swMID,'(__)CL2MD::> CEPQS Meter Created:'+
     ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
     ' Rep:'+IntToStr(m_byRep)+
     ' Group:'+IntToStr(m_nP.m_sbyGroupID));

   IsUpdate   := 0;

   SetHandScenario();
   SetHandScenarioGraph();
End;

procedure CEPQSMeter.RunMeter;
Begin

End;

function CEPQSMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    if pMsg.m_sbyType = DL_REPMSG_TMR then
    begin

    end;
    Result := res;
End;

function CEPQSMeter.LoHandler(var pMsg:CMessage):Boolean;
var res : boolean;
begin
  res := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND, QL_REDIRECT_REQ:
      begin
        {$IFDEF L2_EPQS_DEBUG}
        TestMSG(pMsg);
        {$ENDIF}
        TraceM(2,pMsg.m_swObjID,'(__)EPQS::>Inp DRQ:',@pMsg);
        ReadEPQSAnswer(pMsg);
      End;
    End;
    Result := res;
End;

function CEPQSMeter.HiHandler(var pMsg:CMessage):Boolean;
begin
  Result := False;

  m_nRxMsg.m_sbyServerID := 0;
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    begin
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
      if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
      if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;
      SetNullStates;
      CreateDataReq;
    end;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_CTRL_REQ     : HandCtrlRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
  End;
End;

procedure CEPQSMeter.OnEnterAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> CEPQS OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;


procedure CEPQSMeter.OnFinalAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> CEPQS OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;

procedure CEPQSMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> CEPQS OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;

procedure CEPQSMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> CEPQS OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CEPQSMeter.HandQryRoutine(pMsg:CMessage);
var
  Date1, Date2 : TDateTime;
  l_ParamID    : word;
  l_wPrecize     : word;
  szDT         : word;
  pDS          : CMessageData;
begin
    IsUpdate := 1;
    //FinalAction;
    m_nObserver.ClearGraphQry();
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    l_ParamID    := pDS.m_swData1;
    l_wPrecize := pDS.m_swData2;
    case l_ParamID of
      QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
      QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : AddEnergyDayGrQry(Date1, Date2);
      QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
      QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : AddEnergyMonGrQry(Date1, Date2);
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : AddNakEnMonGrQry(Date1, Date2);
      QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
      QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : AddSresEnGrQry(Date1, Date2);
    end;
end;

procedure CEPQSMeter.HandCtrlRoutine(pMsg:CMessage);
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
        QRY_RELAY_CTRL,
        $C0..$FF :
          ;//ADD_RelayState_CTRLQry(l_StateID);
    end;
end;

procedure CEPQSMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     //OnFinalAction;
     FinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::> CEPQS OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
    End;
end;

procedure CEPQSMeter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
    isCRC       : boolean;
    CRC         : word;
begin
   strNum := 1;
   isCRC := true;
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
     QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM      : begin strNum := 1; isCRC := false; end;
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM      : strNum := 3;
     QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
     QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM      : begin strNum := 2; isCRC := false; end;
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : begin strNum := 1; isCRC := false; end;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM          : strNum := 0;
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A,
     QRY_MGAKT_POW_B, QRY_MGAKT_POW_C,
     QRY_MGREA_POW_S, QRY_MGREA_POW_A,
     QRY_MGREA_POW_B, QRY_MGREA_POW_C,
     QRY_U_PARAM_S, QRY_U_PARAM_A,
     QRY_U_PARAM_B, QRY_U_PARAM_C,
     QRY_I_PARAM_S, QRY_I_PARAM_A,
     QRY_I_PARAM_B, QRY_I_PARAM_C,
     QRY_FREQ_NET, QRY_KOEF_POW_A,
     QRY_KOEF_POW_B, QRY_KOEF_POW_C            : strNum := 4;
     QRY_DATA_TIME                             :
       case mTimeReadSt of
         ST_READ_DATE_TIME   : strNum := 4;
         ST_CORR_TIME_P1     : begin strNum := 5; isCRC := false; end;
         ST_CORR_TIME_P2     : begin strNum := 6; isCRC := false; end;
       end;
   end;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestEPQS.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   if not isCRC then
   begin
     CRC := CRC16(pMsg.m_sbyInfo[0], cnt);
     pMsg.m_sbyInfo[cnt] := lo(CRC);
     pMsg.m_sbyInfo[cnt + 1] := hi(CRC);
     cnt := cnt + 2;
   end;
   pMsg.m_swLen := cnt + 11;
end;

function CEPQSMeter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CEPQSMeter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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

function CEPQSMeter.CRC16(var Buffer : Array of Byte; Count : Integer) : word;
var crc,lcb:word;
    i,j:byte;
begin
    crc:=$0000;
    for i:=0 to count-1 do
    begin
      crc:=(crc and $ff00) or (buffer[i] xor Lo(crc));
      for j:=0 to 7 do
      begin
        lcb:=crc and 1;
        crc:= crc shr 1;
        if lcb=1 then
          crc:=crc xor $a001;
      end;
    end;
    result:=crc;
end;

//Преобразвание строку в число в формате BCD
function  CEPQSMeter.StrToHex(str : string):int64;
var i    : byte;
    razr : byte;
begin
    Result := $00;
    i:=1;
    try
      while i<=Length(str) do
      begin
        razr   := StrToInt(str[i]);
        Result := Result * $10 + razr;
        i:=i+1;
      end;
    except
      Result := 0;
    end;
end;

procedure CEPQSMeter.GetRandNumbers(var hiN, loN: integer);
begin
   hiN := random(2000000000);
   loN := random(2000000000);
end;

end.
