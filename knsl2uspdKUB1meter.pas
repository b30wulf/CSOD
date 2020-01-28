unit knsl2uspdKUB1meter;
//{$DEFINE USPDKUB1}
interface

uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule,utlTimeDate, utldatabase, knsl3EventBox;

type
    CUSPDKUB1Meter = class(CMeter)
    Private
     m_nCounter   : Integer;
     m_nCounter1  : Integer;
     expectedLen  : Integer;
     //IsUpdate     : boolean;
     nReq         : CQueryPrimitive;
     mCurrState   : Integer;
     mCntrlInd    : Byte;
     mTimeDir     : Integer;
     advInfo      : SL2TAGADVSTRUCT;
     logAddrKub1  : Byte;
     logAddrKub2  : Byte;
     countTariff  : Byte;
     logicNumber  : Integer;
     inData       : array [0..15] of Byte;

     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;

     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure   TestMSG(var pMSG:CMessage);
     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     procedure   AddSumEnGrpahQry(dt_Date1, dt_Date2:TDateTime);
     procedure   AddEnergySresGraphQry(dt_Date1, dt_Date2:TDateTime);
     procedure   AddNakEnergyMonthGraphQry(dt_Date1, dt_Date2: TDateTime);
     procedure   AddNakEnergyDayGraphQry(dt_Date1, dt_Date2: TDateTime);
     procedure   AddTransitQry();
     procedure   AddCloseTransitQry();
     constructor Create;

     // Ответы
     function    ReadSumEnAns(var pMsg: CMessage): boolean;
     function    ReadNakEnDayAns(var pMsg: CMessage): boolean;
     function    ReadNakEnMonAns(var pMsg: CMessage): boolean;
     function    ReadDataAns(var pMsg: CMessage): boolean;
     function    ReadAutorAns(var pMsg: CMessage):boolean;
     //function    ReadSresEnAns(var pMsg: CMessage): boolean;
     function    ReadAnswer(var pMsg: CMessage):boolean;
     function    ReadDateTimeAns(var pMsg: CMessage):boolean;  // Ответ для выбора запроса чтения или кор времени

     function    ReadTimeAns(var pMsg: CMessage): boolean;     // Оnвет чтения времени
     function    ReadTimeAnsCor(var pMsg: CMessage): boolean;  // Ответ коректировки времени от параметра
     function    ReadTransitAns(var pMsg:CMessage):boolean;

     // Запросы
     procedure   CreateReqToKUB1Settings;
     procedure   CreateSumEnReq;
     procedure   CreateNakEnDayReq;
     procedure   CreateNakEnMonReq;
     procedure   CreateDateTimeReq;  // Запрос для выбора чтения или кор времени
     procedure   CreateReadTimeReq;  // Запрос чтение даты/времени
     procedure   CreateCorrTimeReq;  // Запрос корректировка даты/времени
     procedure   CreateTransitReq;
     procedure   CloseTransitReq;
     procedure   CreateDataReq(numUSPDl, numUSPDh, param1, hour, day, month: byte;year: integer );overload;
     procedure   CreateDataReq;overload;
     procedure   SendMessageToMeter;

     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     function    GetCommand(byCommand:Byte):Integer;
     function    CRC(var buf : array of byte; cnt : integer):boolean;
     procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
     function    GetStringFromFile(FileName : string; nStr : integer) : string;
     function    convertToFloat(b1,b2,b3,b4 :byte): single;
     procedure   CheckCountTariff(var pMsg:CMessage);
    End;
const
   ST_164_AUTORIZATION          = 1;
   ST_164_REQUEST               = 2;
   ST_164_READ_TIME             = 3; //Параметр чтения времени
   ST_164_CORR_TIME             = 4; //Параметр корректировки времени
   ST_164_TRANSIT               = 5;

implementation

constructor CUSPDKUB1Meter.Create;
Begin

End;

function CUSPDKUB1Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

procedure CUSPDKUB1Meter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin                         //sm - вид энергии; tar - тарифф
   DecodeDate(Date, Year, Month, Day);
   DecodeTime(Date, Hour, Min, Sec, ms);
   m_nRxMsg.m_sbyServerID:= 0;
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
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

procedure CUSPDKUB1Meter.SetCurrQry;
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


procedure CUSPDKUB1Meter.SetGraphQry;
begin

end;

procedure CUSPDKUB1Meter.MsgHead(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := Size;             //pMsg.m_sbyInfo[] :=
    pMsg.m_swObjID     := m_nP.m_swMID;     //Сетевой адрес счетчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;       //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ;    //PH_DATARD_REC
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_EA8086;       //Указать тип счетчика
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

procedure CUSPDKUB1Meter.AddSumEnGrpahQry(dt_Date1, dt_Date2: TDateTime);
var
    year, month, day : word;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, year, month, day, 1);  // заносим в Observer авторизацию, перед чтобы считать логический номер контроллера и кол-во тарифов,
                                                                     // от кол-ва тарифов зависит длина ответной посылки на запрос данных
   DecodeDate(Now, year, month, day);
   m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, year, month, day, 1);
end;

procedure CUSPDKUB1Meter.AddNakEnergyDayGraphQry(dt_Date1, dt_Date2: TDateTime);
var
    year, month, day : word;
    i                : integer;
begin
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   for i := trunc(dt_Date1) to trunc(dt_Date2) do                     // от кол-ва тарифов зависит длина ответной посылки на запрос данных
   begin
     DecodeDate(i, year, month, day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
   end;
end;


procedure CUSPDKUB1Meter.AddTransitQry();
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);  // заносим в Observer авторизацию, перед чтобы считать логический номер контроллера и кол-во тарифов
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);  // заносим в Observer транзит, перед чтобы считать логический номер контроллера и кол-во тарифов,
end;

procedure CUSPDKUB1Meter.AddCloseTransitQry();
begin
   m_nObserver.AddGraphParam(QRY_CLOSE_TRANSIT, 0, 0, 0, 1);  // заносим в Observer транзит, перед чтобы считать логический номер контроллера и кол-во тарифов,
end;

procedure CUSPDKUB1Meter.AddNakEnergyMonthGraphQry(dt_Date1, dt_Date2: TDateTime);
var
    year, month, day : word;
begin
     while (dt_Date1 <= dt_Date2) and (dt_Date1 <= Now) do
     begin
       DecodeDate(dt_Date1, year, month, day);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       cDateTimeR.IncMonth(dt_Date1);
     end
end;

procedure CUSPDKUB1Meter.AddEnergySresGraphQry(dt_Date1, dt_Date2: TDateTime);
var 
    i, j, maxSl          : integer;
    year, month, day     : word;
begin
   for i := trunc(dt_Date1) to trunc(dt_Date2) do
   begin
     DecodeDate(i, year, month, day);
     if i = trunc(Now) then
       maxSl := trunc(frac(Now)/EncodeTime(0, 30, 0, 0) - 1)
     else
       maxSl := 47;
     for j := 0 to maxSl do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, year, month, (day shl 8) + j, 1);
   end;
end;

function CUSPDKUB1Meter.ReadAnswer(var pMsg: CMessage): boolean;
begin
   Result:=False;
   if not CRC(pMsg.m_sbyInfo[0],(pMsg.m_swLen-14 - 1)) then   //13 системных байт и 2 байта CRC
   begin
        exit;
   end;
   if (nReq.m_swParamID = 1) then
   begin
      Result := ReadSumEnAns(pMsg);
   end
   else
   begin
   case mCurrState of
     ST_164_AUTORIZATION    : Result := ReadAutorAns(pMsg);
     ST_164_REQUEST         : Result := ReadDataAns(pMsg);
   end;
   end;
end;

function CUSPDKUB1Meter.ReadDataAns(var pMsg:CMessage):boolean;
begin
  if nReq.m_swParamID in [QRY_ENERGY_SUM_EP, QRY_NAK_EN_DAY_EP, QRY_NAK_EN_MONTH_EP] then begin
    FillChar(inData, sizeOf(inData), 0);
    move(pMsg.m_sbyInfo[12 + 16 * m_nP.m_swAddrOffset], inData, 16);
  end;
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP   : Result := ReadSumEnAns(pMsg);
     QRY_NAK_EN_DAY_EP   : Result := ReadNakEnDayAns(pMsg);
     QRY_NAK_EN_MONTH_EP : Result := ReadNakEnMonAns(pMsg);
     QRY_DATA_TIME       : Result := ReadDateTimeAns(pMsg);
     QRY_TRANSIT         : Result := ReadTransitAns(pMsg);
   else begin Result := true; end;
   end;
end;

function CUSPDKUB1Meter.ReadTransitAns(var pMsg:CMessage):boolean;   //установление трансита ответ
begin
   Result := false;
   if ((pMsg.m_sbyInfo[2] ) <> $AC) then // Проверка на правильность функции
   begin
     exit;
   end;
   Result := true;
   mCurrState := ST_164_REQUEST;
end;

function CUSPDKUB1Meter.ReadAutorAns(var pMsg:CMessage):boolean;  // Метод считывания конфигурации УСПД КУБ-1
begin
   Result := false;
   if (((pMsg.m_swLen - 13) <> $215) Or ((pMsg.m_swLen - 13) = $06)) then // Проверка на длину посылки
   begin
     exit;
   end;
   if ((pMsg.m_sbyInfo[2] ) <> $C8) then // Проверка на правильность функции
   begin
     exit;
   end;
    // Запись логического адреса КУБа
    logAddrKub1 := pMsg.m_sbyInfo[259];
    logAddrKub2 := pMsg.m_sbyInfo[260];
    logicNumber := (logAddrKub1 shl 8) + logAddrKub2;

    // Запись кол-ва тарифов
    if (pMsg.m_sbyInfo[263] = 0) then
    begin
        countTariff := 1;
    end else
    begin
        countTariff := pMsg.m_sbyInfo[263];
    end;
    Result := true;
    mCurrState := ST_164_REQUEST;
end;

function CUSPDKUB1Meter.ReadSumEnAns(var pMsg:CMessage):boolean; // Метод cчитывания суммарных значений,
var  i     : integer;
     val   : double;
     val_i : int64;
     date  : TDateTime;
     Year,Month,Day,Hour,Min,Sec,Msec: Word;

begin
   DecodeDate(Now,Year,Month,Day);
   DecodeTime(Now,Hour,Min,Sec,Msec);
   if Hour <> 0 then
   begin
        Hour := Hour - 1;
   end;
   Result := false;
   CheckCountTariff(pMsg);
   if ((pMsg.m_sbyInfo[2] ) <> $CD) then // Проверка на правильность функции
   begin
     exit;
   end;
   expectedLen := 5 + 9 + 1*4*countTariff; // предполагаемая длина ответной посылки, см. описание протокола КУБ-1
   if ((pMsg.m_swLen - 13) = $06)  then
   begin
//        case pMsg.m_sbyInfo[3] of
//                $01 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 No data at this time, request and answer is correct!');
//                $02 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 Invalid record title in memory!');
//                $03 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 Internal memory page read error!');
//                $04 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 The number of channels in the request is exceeded or the amount of data requested exceeds 1kByte!');
//                $10 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 There is an entry in the requested page!');
//        end;
        Result := true;
        exit;
   end;
   if ((pMsg.m_swLen - 13) <> expectedLen) then
   begin
     exit;
   end;

   for i := 0 to 3  do
   begin
      val_i := 0;
      move(inData[i*4], val_i, 4);
      if ((val_i = $FEFEFEFE) Or (val_i = $FDFDFDFD)) then      // Если 4 байта данных по тарифу FE, то это значит, что нет связи со счетчиком, если FD - данных нет и невозможно их восстановить
      begin
            Result := true;
            continue;
      end;
      val := convertToFloat(inData[i*4], inData[i*4 + 1], inData[i*4 + 2], inData[i*4 + 3]);
      date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
      date := EncodeDate(Year,Month,Day)+EncodeTime(Hour,0,0,0);
      CreateOutMSG(val, QRY_ENERGY_SUM_EP, i+1,  date);
      saveToDB(m_nRxMsg);
      Result := true;
   end;
end;

function CUSPDKUB1Meter.ReadNakEnDayAns(var pMsg:CMessage):boolean; // Метод считывания суточных значений
var  i     : integer;
     val   : double;
     val_i : int64;
     date  : TDateTime;
begin
   Result := false;
   CheckCountTariff(pMsg);
   if ((pMsg.m_sbyInfo[2] ) <> $CD) then // Проверка на правильность функции
   begin
     exit;
   end;
   expectedLen := 5 + 9 + 1*4*countTariff; // предполагаемая длина ответной посылки, см. описание протокола КУБ-1
   if ((pMsg.m_swLen - 13) = $06)  then
   begin
//        case pMsg.m_sbyInfo[3] of
//                $01 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 No data at this time, request and answer is correct!');
//                $02 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 Invalid record title in memory!');
//                $03 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 Internal memory page read error!');
//                $04 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 The number of channels in the request is exceeded or the amount of data requested exceeds 1kByte!');
//                $10 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 There is an entry in the requested page!');
//        end;
        Result := true;
        exit;
   end;
   if ((pMsg.m_swLen - 13) <> expectedLen) then
   begin
     exit;
   end;

   for i := 0 to 3  do
   begin
      val_i := 0;
      move(inData[i*4], val_i, 4);
      if ((val_i = $FEFEFEFE) Or (val_i = $FDFDFDFD)) then      // Если 4 байта данных по тарифу FE, то это значит, что нет связи со счетчиком, если FD - данных нет и невозможно их восстановить
      begin
            Result := true;
            continue;
      end;
      val := convertToFloat(inData[i*4], inData[i*4 + 1], inData[i*4 + 2], inData[i*4 + 3]);
      date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
      CreateOutMSG(val, QRY_NAK_EN_DAY_EP, i+1, date);
      saveToDB(m_nRxMsg);
      Result := true;
   end;
end;

function CUSPDKUB1Meter.ReadNakEnMonAns(var pMsg:CMessage):boolean;
var  i     : integer;
     val, val_result   : double;
     val_i : int64;
     date  : TDateTime;
begin
    Result := false;
    val_result := -1;
    CheckCountTariff(pMsg);
   if ((pMsg.m_sbyInfo[2] ) <> $CD) then // Проверка на правильность функции
   begin
     exit;
   end;
   expectedLen := 5 + 9 + 1*4*countTariff; // предполагаемая длина ответной посылки, см. описание протокола КУБ-1
   if ((pMsg.m_swLen - 13) = $06) then    // формат короткого ответа, байт с индексом 3 показыавет тип ошибки
   begin
//        case pMsg.m_sbyInfo[3] of
//                $01 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 No data at this time, request and answer is correct!');
//                $02 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 Invalid record title in memory!');
//                $03 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 Internal memory page read error!');
//                $04 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 The number of channels in the request is exceeded or the amount of data requested exceeds 1kByte!');
//                $10 : TraceL(2,m_nTxMsg.m_swObjID,'CL2MD::>KUB1 There is an entry in the requested page!');
//        end;
        m_nT.B2:=false; //Нет данных по тарифу и соответственно не опрошен для поментки в статистику группы опроса
        Result := true;
        exit;
   end;
   if ((pMsg.m_swLen - 13) <> expectedLen) then  // проверка на длину ответа, длина определяется согласно протоколу
   begin
     exit;
   end;

   for i := 0 to 3  do
   begin
      val_i := 0;
      move(inData[i*4], val_i, 4);
      if ((val_i = $FEFEFEFE) Or (val_i = $FDFDFDFD)) then      // Если 4 байта данных по тарифу FE, то это значит, что нет связи со счетчиком, если FD - данных нет и невозможно их восстановить
      begin
            Result := true;
            m_nT.B2:=false; //Нет данных по тарифу и соответственно не опрошен для поментки в статистику группы опроса
            continue;
      end;
      val := convertToFloat(inData[i*4], inData[i*4 + 1], inData[i*4 + 2], inData[i*4 + 3]);
      val_result := val_result + val;
      date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
      CreateOutMSG(val, QRY_NAK_EN_MONTH_EP, i+1, date);
      saveToDB(m_nRxMsg);
      Result := true;

   end;
   if (val_result <> -1) then
   begin
      date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
      CreateOutMSG(val_result + 1, QRY_NAK_EN_MONTH_EP, 0, date);
      saveToDB(m_nRxMsg);
   end;
end;

function CUSPDKUB1Meter.ReadDateTimeAns(var pMsg: CMessage): boolean;
begin
   Result := true;
   case mTimeDir of
     ST_164_READ_TIME : Result := ReadTimeAns(pMsg); // Оnвет чтения времени
     ST_164_CORR_TIME :
       begin
         Result := ReadTimeAnsCor(pMsg);  // Ответ коректировки времени от параметра
         mTimeDir := ST_164_READ_TIME;    // Параметр чтения времени
       end;
   else
    begin
           mTimeDir := ST_164_READ_TIME;  //Параметр чтения времени
    end;
   end;
end;

function CUSPDKUB1Meter.ReadTimeAns(var pMsg: CMessage): boolean;
var dateRead : TDateTime;
    _yy,_dd,_mn,dayWeek,_hh,_mm,_ss:integer;
    Hour,Min,Sek,Msek : word;
begin
   Result := false;

   if (((pMsg.m_swLen - 13) <> $0C) Or ((pMsg.m_swLen - 13) = $06) or ((pMsg.m_sbyInfo[2]) <> $96)) then
   begin
     exit;
   end;
 {  if ((pMsg.m_sbyInfo[2] ) <> $96) then
   begin
     exit;
   end;   }

   try
        _yy      := StrToInt(Format('%x', [pMsg.m_sbyInfo[5]])) + 2000;
        _mn      := StrToInt(Format('%x', [pMsg.m_sbyInfo[4]]));
        _dd      := StrToInt(Format('%x', [pMsg.m_sbyInfo[3]]));
        dayWeek  := StrToInt(Format('%x', [pMsg.m_sbyInfo[6]]));
        _hh      := StrToInt(Format('%x', [pMsg.m_sbyInfo[7]]));
        _mm      := StrToInt(Format('%x', [pMsg.m_sbyInfo[8]]));
        _ss      := StrToInt(Format('%x', [pMsg.m_sbyInfo[9]]));
        dateRead := EncodeDate(_yy, _mn, _dd) + EncodeTime(_hh, _mm, _ss, 0);
        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+DateTimeToStr(dateRead)+')');
        DecodeTime(Now,Hour,Min,Sek,Msek);
        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Разница по времени состовляет -> '+TimeToStr(abs(EncodeTime(_hh,_mm,_ss,0)-EncodeTime(Hour,Min,Sek,0))));
   except
     dateRead := Now;
   end;
     if (abs(EncodeTime(_hh,_mm,_ss,0)-EncodeTime(Hour,Min,Sek,0))>EncodeTime(0,0,15,0)) then
       begin
         mTimeDir := ST_164_CORR_TIME; //Параметр корректировки времени
         m_nObserver.AddGraphParam(QRY_DATA_TIME, 0,0,0,1);  //заносим в спеки параметры для определения типа запроса(на разъем или на счетчики)
         Result := true;
       end
     else
       begin
         mTimeDir := ST_164_READ_TIME; //Параметр чтения времени
         m_nObserver.ClearGraphQry;    //Очищаем буфер команд
         Result := true;
       end;
end;

function CUSPDKUB1Meter.ReadTimeAnsCor(var pMsg: CMessage): boolean;
begin
   Result := true;
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(pMsg.m_swLen - 13)+')');
end;


procedure CUSPDKUB1Meter.InitMeter(var pL2:SL2TAG);
Var
   slv : TStringList;
Begin
    mTimeDir    := 3; //параметр чтнения времени  ST_164_READ_TIME
    countTariff := 0;
    m_nCounter  := 0;
    m_nCounter1 := 0;
    IsUpdate    := 0;
    mCntrlInd   := 0;
    mCurrState  := ST_164_REQUEST;
    SetHandScenario;
    SetHandScenarioGraph;

   slv := TStringList.Create;
   getStrings(m_nP.m_sAdvDiscL2Tag,slv);
   if slv[0]='' then slv[0] := '0';
   if slv[2]='' then slv[2] := '0';
   advInfo.m_sKoncFubNum  := slv[0];
   advInfo.m_sKoncPassw   := slv[1];
   advInfo.m_sAdrToRead   := slv[2];
   slv.Clear;
   slv.Destroy;
End;

procedure CUSPDKUB1Meter.RunMeter;
Begin

End;

function CUSPDKUB1Meter.CRC(var buf : array of byte; cnt : integer):boolean;   // СЂР°СЃС‡РµС‚ РєРѕРЅС‚СЂРѕР»СЊРЅРѕР№ СЃСѓРјРјС‹
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : integer;
    cmp                 : integer;
    idx                 : byte;
begin
    Result  := true;
    CRChiEl := $FF;
    CRCloEl := $FF;
    cmp     := cnt-1;
    if cnt >= 600 then
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
    if (CRCloEl <> buf[cnt+1]) and (CRChiEl <> buf[cnt]) then
      Result := false;
    buf[cnt+1]    := CRCloEl;
    buf[cnt]  := CRChiEl;
end;




function CUSPDKUB1Meter.HiHandler(var pMsg:CMessage):Boolean;
var
   res   : Boolean;
begin
   res := false;
   //Обработчик для L3
   try
   m_nRxMsg.m_sbyServerID := 0;
   case pMsg.m_sbyType of
     QL_DATARD_REQ:
     Begin
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
       SendMessageToMeter;
     end;
     QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
     QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
   end;
   except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(CUSPDKUB1Meter/HiHandler ERROR');
   end;
   Result := res;
end;

function CUSPDKUB1Meter.LoHandler(var pMsg:CMessage):Boolean;
var
    res    : Boolean;
begin
    res := False;
    try
     case pMsg.m_sbyType of
      PH_DATA_IND:
      begin
        {$IFDEF USPDKUB1}
        TestMSG(pMsg);
        {$ENDIF}
        res := ReadAnswer(pMsg);
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
     end;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(CUSPDKUB1Meter/LoHandler ERROR');
    end;
    Result := res;
end;

procedure CUSPDKUB1Meter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
     QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : strNum := 9;
     QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
     QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : strNum := 5;
     QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
     QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : strNum := 7;
     QRY_SRES_ENR_EP, QRY_SRES_ENR_EM,
     QRY_SRES_ENR_RP, QRY_SRES_ENR_RM,
     QRY_SRES_ENR_DAY_EP, QRY_SRES_ENR_DAY_EM,
     QRY_SRES_ENR_DAY_RP, QRY_SRES_ENR_DAY_RM : strNum := 3;
     QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
     QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
     QRY_MGREA_POW_B, QRY_MGREA_POW_C,
     QRY_U_PARAM_A, QRY_U_PARAM_B,
     QRY_U_PARAM_C, QRY_I_PARAM_A,
     QRY_I_PARAM_B, QRY_I_PARAM_C,
     QRY_FREQ_NET                             : strNum := 11;
     QRY_DATA_TIME, QRY_KPRTEL_KE,
     QRY_AUTORIZATION                         : strNum := 1;
     else strNum := 1;
   end;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestUSPDKUB1.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   pMsg.m_swLen := cnt + 11;
end;

procedure CUSPDKUB1Meter.HandQryRoutine(var pMsg:CMessage);
var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    m_nCounter := 0;
    m_nCounter1:= 0;
    //FinalAction;
    //m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
//    wPrecize := pDS.m_swData2;
    case param of
        // Накопленная суммарная энергия
      QRY_ENERGY_MON_EP                         : AddSumEnGrpahQry(Date1, Date2);

        // Суточные значения
      QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
      QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM      : AddNakEnergyDayGraphQry(Date1, Date2);

        // Месячные значения
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : AddNakEnergyMonthGraphQry(Date1, Date2);
      QRY_TRANSIT                               : AddTransitQry();
      QRY_CLOSE_TRANSIT                         : AddCloseTransitQry();
    end;
end;

procedure CUSPDKUB1Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
   if m_nP.m_sbyEnable=1 then
   begin
     //if m_nModemState=1 then
     IsUpdate := 0;
     m_nCounter := 0;
     m_nCounter1:= 0;
   end;
end;

procedure CUSPDKUB1Meter.OnEnterAction;
Begin
    mCurrState := ST_164_AUTORIZATION;
    mTimeDir   := ST_164_READ_TIME;
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then begin end;
End;

procedure CUSPDKUB1Meter.OnFinalAction;
Begin
End;

procedure CUSPDKUB1Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 1;
End;

procedure CUSPDKUB1Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 0;
End;


procedure CUSPDKUB1Meter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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


function CUSPDKUB1Meter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

function CUSPDKUB1Meter.GetCommand(byCommand:Byte):Integer;        // убрать его
var
    res : Integer;
begin
    case byCommand of
      QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM,
      QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM     : res := 8;
      QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM,
      QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM     : res := 6;
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM : res := 10;
      QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM,
      QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM     : res := 7;
      QRY_SRES_ENR_EP                          : res := 2;
      QRY_SRES_ENR_EM                          : res := 3;
      QRY_SRES_ENR_RP                          : res := 4;
      QRY_SRES_ENR_RM                          : res := 5;
      QRY_SRES_ENR_DAY_EP                      : res := 2;
      QRY_SRES_ENR_DAY_EM                      : res := 3;
      QRY_SRES_ENR_DAY_RP                      : res := 4;
      QRY_SRES_ENR_DAY_RM                      : res := 5;
      QRY_MGAKT_POW_A, QRY_MGAKT_POW_B,
      QRY_MGAKT_POW_C, QRY_MGREA_POW_A,
      QRY_MGREA_POW_B, QRY_MGREA_POW_C,
      QRY_U_PARAM_A, QRY_U_PARAM_B,
      QRY_U_PARAM_C, QRY_I_PARAM_A,
      QRY_I_PARAM_B, QRY_I_PARAM_C,
      QRY_FREQ_NET                             : res := 9;
      QRY_DATA_TIME, QRY_KPRTEL_KE,
      QRY_AUTORIZATION                         : res := 0;
      else                                       res := -1;
    end;
    Result := res;
end;

procedure CUSPDKUB1Meter.SendMessageToMeter;
begin
   mCntrlInd := mCntrlInd + 1;

   if (nReq.m_swParamID = QRY_CLOSE_TRANSIT) then  // по умолчанию при первой посылке mCurrState=ST_164_AUTORIZATION
   begin
        mCurrState := ST_164_REQUEST;
   end;
   if (nReq.m_swParamID = 1) then
   begin
      CreateSumEnReq;
   end
   else
   begin
   case mCurrState of
     ST_164_AUTORIZATION : CreateReqToKUB1Settings;
     ST_164_REQUEST      : CreateDataReq;
   end;
   end;
end;


procedure CUSPDKUB1Meter.CreateDataReq;
begin
   case nReq.m_swParamID of
     QRY_ENERGY_SUM_EP   : CreateSumEnReq;
     QRY_NAK_EN_DAY_EP   : CreateNakEnDayReq;
     QRY_NAK_EN_MONTH_EP : CreateNakEnMonReq;
     QRY_TRANSIT         : CreateTransitReq;
     QRY_CLOSE_TRANSIT   : CloseTransitReq;
     QRY_DATA_TIME       : CreateDateTimeReq;
   end;
end;

procedure CUSPDKUB1Meter.CreateDateTimeReq; // Запрос для выбора чтения или кор времени
begin
   case mTimeDir of
     ST_164_READ_TIME : CreateReadTimeReq;  // Запрос чтение даты/времени
     ST_164_CORR_TIME : CreateCorrTimeReq;  // Запрос корректировка даты/времени
   end;
end;

procedure CUSPDKUB1Meter.CreateSumEnReq;
var
    year, month, day,
    Hour, Min, Sec, ms : word;
begin
     DecodeDate(Now, year, month, day);
     nReq.m_swSpecc0 := year;
     nReq.m_swSpecc1 := month;
     nReq.m_swSpecc2 := day;
     DecodeTime(Now, Hour, Min, Sec, ms);
     if Hour <> 0 then
     begin
        Hour := Hour - 1;
     end;
   // 1 - пар-р для чтения часовых значений  энергии
   CreateDataReq(logAddrKub1, logAddrKub2, 1, Hour, nReq.m_swSpecc2, nReq.m_swSpecc1, nReq.m_swSpecc0);
end;

procedure CUSPDKUB1Meter.CreateNakEnDayReq;
var //dateToRead       : TDateTime;
    year, month, day : word;
begin
    if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
   begin
     DecodeDate(Now, year, month, day);
     nReq.m_swSpecc0 := year;
     nReq.m_swSpecc1 := month;
     nReq.m_swSpecc2 := day;
   end;
   // 2 - пар-р для чтения суточных значений энергии
   CreateDataReq(logAddrKub1, logAddrKub2, 2, 0,nReq.m_swSpecc2, nReq.m_swSpecc1, nReq.m_swSpecc0);
end;

procedure CUSPDKUB1Meter.CreateNakEnMonReq;
var //dateToRead       : TDateTime;
    year, month, day : word;
begin
    if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
   begin
     DecodeDate(Now, year, month, day);
     nReq.m_swSpecc0 := year;
     nReq.m_swSpecc1 := month;
     nReq.m_swSpecc2 := day;
   end;
   // 3 - пар-р для чтения месячных значений энергии
   CreateDataReq(logAddrKub1, logAddrKub2, 3, 0,nReq.m_swSpecc2, nReq.m_swSpecc1, nReq.m_swSpecc0);
end;

procedure CUSPDKUB1Meter.CreateReqToKUB1Settings;
begin
   m_nTxMsg.m_sbyInfo[0] := $FF;    // Логический №КУБа 0xFFFF- широковещательный режим
   m_nTxMsg.m_sbyInfo[1] := $FF;    // -//-
   m_nTxMsg.m_sbyInfo[2] := $C8;    // функция чтения flash-памяти(см. протокол УСПД "КУБ-1" функция 150)
   m_nTxMsg.m_sbyInfo[3] := $FF;    // номер страницы с конфигурацией прибора
   m_nTxMsg.m_sbyInfo[4] := $FF;
   CRC(m_nTxMsg.m_sbyInfo[0], 5);
   MsgHead(m_nTxMsg, 7 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPDKUB1Meter.CreateReadTimeReq;
begin
   m_nTxMsg.m_sbyInfo[0] := $FF;   // Логический № КУБа 2 байта
   m_nTxMsg.m_sbyInfo[1] := $FF;   // -//-
   m_nTxMsg.m_sbyInfo[2] := $96;   // функция чтения времени (см. протокол УСПД "КУБ-1" функция 150)
   CRC(m_nTxMsg.m_sbyInfo[0], 3);
   MsgHead(m_nTxMsg, 5 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPDKUB1Meter.CreateCorrTimeReq;
var year, month, day,
    hour, min, sec, ms : word;
begin
   m_nTxMsg.m_sbyInfo[0] := $FF; // Логический № КУБа 0xFFFF- широковещательный режим
   m_nTxMsg.m_sbyInfo[1] := $FF; //
   m_nTxMsg.m_sbyInfo[2] := $64;        // функция коррекции времени (см. протокол УСПД "КУБ-1" функция 200)
   DecodeDate(Now, year, month, day);
   DecodeTime(Now, hour, min, sec, ms);
   m_nTxMsg.m_sbyInfo[3] := StrToInt('$'+IntToStr(day));
   m_nTxMsg.m_sbyInfo[4] := StrToInt('$'+IntToStr(month));
   m_nTxMsg.m_sbyInfo[5] := StrToInt('$'+IntToStr(year - 2000));//byte(year - 2000);
   m_nTxMsg.m_sbyInfo[6] := StrToInt('$'+IntToStr(DayOfWeek(Now)-1));// DayOfWeek(Now);
   m_nTxMsg.m_sbyInfo[7] := StrToInt('$'+IntToStr(hour));//hour;
   m_nTxMsg.m_sbyInfo[8] := StrToInt('$'+IntToStr(min));//min;
   m_nTxMsg.m_sbyInfo[9] := StrToInt('$'+IntToStr(sec));//sec;
   CRC(m_nTxMsg.m_sbyInfo[0], 10);
   MsgHead(m_nTxMsg, 12 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;



procedure CUSPDKUB1Meter.CreateDataReq(numUSPDl, numUSPDh, param1, hour, day, month: byte; year: integer);
begin
   m_nTxMsg.m_sbyInfo[0] := $FF; // Логический № КУБа 2 байта
   m_nTxMsg.m_sbyInfo[1] := $FF; // -//-
   m_nTxMsg.m_sbyInfo[2] := $CD;          // функция чтения показаний счетчиков (см. протокол УСПД "КУБ-1" функция 205)
   m_nTxMsg.m_sbyInfo[3] := param1; // 1 - часовые, 2 - суточные, 3 - месячные
   m_nTxMsg.m_sbyInfo[4] := StrToInt('$'+IntToStr(hour));; // 4 байта: час, день, месяц, год
   m_nTxMsg.m_sbyInfo[5] := StrToInt('$'+IntToStr(day));
   m_nTxMsg.m_sbyInfo[6] := StrToInt('$'+IntToStr(month));
   m_nTxMsg.m_sbyInfo[7] := StrToInt('$'+IntToStr(year - 2000));

   if m_np.m_sddPHaddres2 = '' then begin
   m_nTxMsg.m_sbyInfo[8] := Hi(StrToInt(advInfo.m_sAdrToRead));//Hi(StrToInt(m_np.m_sddPHaddres)); // считывает каналы с channel1 по channel2   m_np. m_sddPHAddres, по одному счетчику
   m_nTxMsg.m_sbyInfo[9] := Lo(StrToInt(advInfo.m_sAdrToRead));//Lo(StrToInt(m_np.m_sddPHaddres));
   m_nTxMsg.m_sbyInfo[10] := Hi(StrToInt(advInfo.m_sAdrToRead));//Hi(StrToInt(m_np.m_sddPHaddres));
   m_nTxMsg.m_sbyInfo[11] := Lo(StrToInt(advInfo.m_sAdrToRead));//Lo(StrToInt(m_np.m_sddPHaddres));
   end
   else begin
     m_nTxMsg.m_sbyInfo[8] := Hi(StrToInt(m_np.m_sddPHaddres2));//Hi(StrToInt(m_np.m_sddPHaddres2)); // считывает каналы с channel1 по channel2   m_np. m_sddPHAddres, по одному счетчику
     m_nTxMsg.m_sbyInfo[9] := Lo(StrToInt(m_np.m_sddPHaddres2));
     m_nTxMsg.m_sbyInfo[10] := Hi(StrToInt(advInfo.m_sAdrToRead));//Hi(StrToInt(m_np.m_sddPHaddres));
     m_nTxMsg.m_sbyInfo[11] := Lo(StrToInt(advInfo.m_sAdrToRead));//Lo(StrToInt(m_np.m_sddPHaddres));
   end;

   CRC(m_nTxMsg.m_sbyInfo[0], 12);
   MsgHead(m_nTxMsg, 14 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPDKUB1Meter.CreateTransitReq();  // формирование посылки для активации режима транзита
var i : integer;
begin
   m_nTxMsg.m_sbyInfo[0] := $FF; // Логический № КУБа 2 байта
   m_nTxMsg.m_sbyInfo[1] := $FF; // -//-
   m_nTxMsg.m_sbyInfo[2] := $AC;          // функция перевода КУБ-а в режим тразита = 172
   m_nTxMsg.m_sbyInfo[3] := $02; // тип транзита  = 2
   m_nTxMsg.m_sbyInfo[4] := $01; // линия CAN-интерфейса
   m_nTxMsg.m_sbyInfo[5] := $10; // линия активности тразита
   //22 байта нулей, настроечные параметры, см.протокол
   for i := 1 to 22  do
   begin
        m_nTxMsg.m_sbyInfo[i+5] := $00;
   end;
   CRC(m_nTxMsg.m_sbyInfo[0], 28);
   MsgHead(m_nTxMsg, 30 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPDKUB1Meter.CloseTransitReq();  // формирование посылки для деактивации режима транзита
begin
   m_nTxMsg.m_sbyInfo[0] := $2D;
   m_nTxMsg.m_sbyInfo[1] := $2D;
   m_nTxMsg.m_sbyInfo[2] := $2D;
   MsgHead(m_nTxMsg, 3 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPDKUB1Meter.CheckCountTariff(var pMsg:CMessage); // определение кол-ва тарифов по длине входящей посылки
begin
    countTariff := 0;
    expectedLen := pMsg.m_swLen - 13 - 5 - 9 - 4; // длина поля данных, 13 - системные, 5 - обертка покета, 4 - первый тариф,  9 - ???(не помню, но работает)
    while expectedLen >= 0 do
    begin
        countTariff := countTariff + 1;
        expectedLen := expectedLen - 4;
    end;
end;

function CUSPDKUB1Meter.convertToFloat(b1,b2,b3,b4 :byte): single;  // Метод преобразования из 4 байт в SINGLE, представление float
var
  arrNum : array[0..3] of Byte;
  num: ^Single;
begin
  arrNum[0] := b4;
  arrNum[1] := b3;
  arrNum[2] := b2;
  arrNum[3] := b1;
  num:=@arrNum;
  Result := num^;
end;

end.
