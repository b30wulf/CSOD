 unit knsl2MES3meter;
//{$DEFINE USPDKUB1}
interface

uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule, utlTimeDate, utldatabase, StrUtils, knsl3EventBox;

type
    MES3Meter = class(CMeter)
    Private
     ReadParamID  : byte;
//     m_nCounter   : Integer;
//     m_nCounter1  : Integer;
     expectedLen  : Integer;
     nReq         : CQueryPrimitive;
     mCurrState   : Integer;
     mCntrlInd    : Byte;
     mTimeDir     : Integer;
     advInfo      : SL2TAGADVSTRUCT;
     logAddrKub1  : Byte;
     logAddrKub2  : Byte;
     countTariff  : Byte;
     logicNumber  : Integer;
     m_Address    : String;
     dateRazn     : TDateTime;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);

     function    LoHandler(var pMsg:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;

     procedure   AddNakEnergyMonthGraphQry(dt_Date1, dt_Date2: TDateTime);
     procedure   AddNakEnergyDayGraphQry(dt_Date1, dt_Date2: TDateTime);
     constructor Create;
     function    ControlCRC(var pMsg: CMessage): boolean;
     function    ReadSumEnAns(var pMsg: CMessage): boolean;
     function    ReadNakEnDayAns(var pMsg: CMessage): boolean;
     function    ReadNakEnMonAns(var pMsg: CMessage): boolean;
     function    ReadDateTimeAns(var pMsg: CMessage):boolean;
     function    ReadTimeAns(var pMsg: CMessage): boolean;
     function    ReadCorTimeAns(var pMsg: CMessage): boolean;
     procedure   CreateSumEnergReq;
     procedure   CreateNakEnDayReq;
     procedure   CreateNakEnMonReq;
     procedure   CreateDateTimeReq;
     procedure   CreateReadTimeReq;
     procedure   CreateCorrTimeReq;

     procedure   HandQryRoutine(var pMsg:CMessage);
     procedure   MsgHead(var pMsg:CHMessage; Size:byte);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     function    CRC(var buf : array of byte; begin_byte, cnt : integer; var crcRasch:byte):boolean;
    End;

implementation
  
constructor MES3Meter.Create;
Begin

End;

function MES3Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;

//CreateOutMSG(param : double;          -значение параметра
//                sm : byte;            -тип параметра
//                tar : byte;           -тариф
//                Date : TDateTime      -дата ответа
procedure MES3Meter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
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

procedure MES3Meter.SetGraphQry;
begin

end;

procedure MES3Meter.MsgHead(var pMsg:CHMessage; Size:byte);
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

procedure MES3Meter.AddNakEnergyDayGraphQry (dt_Date1, dt_Date2: TDateTime);
var TempDate         : TDateTime;
    year, month, day : word;
    i                : integer;
begin
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   for i := trunc(dt_Date1) to trunc(dt_Date2) do
   begin
     DecodeDate(i, year, month, day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
   end;
end;

procedure MES3Meter.AddNakEnergyMonthGraphQry(dt_Date1, dt_Date2: TDateTime);
var TempDate         : TDateTime;
    year, month, day : word;
    i                : integer;
begin
     while (dt_Date1 <= dt_Date2) and (dt_Date1 <= Now) do
     begin
       DecodeDate(dt_Date1, year, month, day);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       cDateTimeR.IncMonth(dt_Date1);
     end
end;

function MES3Meter.ControlCRC(var pMsg:CMessage):boolean; // Метод считывания текущих значений
var
    crcRSCH       : byte;
    tempChar      : char;
    testString    : string;
    k             : integer;
begin
    Result := True;
   if not CRC(pMsg.m_sbyInfo[0], 1, pMsg.m_swLen - 14,crcRSCH) then // в расчете CRC участвуют все байты кроме байта CRC<BCC> и стартового <SOH>
   begin
        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Ошибка контрольной суммы в полученном ответе)');
        Result:=false; 
        exit;
   end;

   if (pMsg.m_swLen-13=10)then
     begin
       tempChar := Chr(pMsg.m_sbyInfo[6]);
       Insert(tempChar, testString, Length(testString)+1);
       tempChar := Chr(pMsg.m_sbyInfo[7]);
       Insert(tempChar, testString, Length(testString)+1);
       case StrToInt(testString) of
            1: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR01= Операция не поддерживается)'); Result:=false; end;
            2: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR02= Ошибка контрольной суммы)');   Result:=false; end;
            3: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR03= Неверный пароль)');            Result:=false; end;
            4: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR04= Неправильный формат данных)'); Result:=false; end;
            5: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR05= Доступ запрещен)');            Result:=false; end;
            6: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR06= Неизвестная команда)');        Result:=false; end;
            7: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR07= Превышен архивный индекс)');   Result:=false; end;
            8: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR08= Нет архивных данных)');        Result:=false; end;
            9: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR09= Запись запрещена)');           Result:=false; end;
            10: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR10= Чтение запрещено)');          Result:=false; end;
            11: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR11= Неправильный формат даты(времени))'); Result:=false; end;
            12: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR12= Ошибка часов счетчика)');             Result:=false; end;
            13: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR13= Ошибка EEPROM)');                     Result:=false; end;
            14: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR14= Неправильные параметры)');            Result:=false; end;
            15: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR15= Превышен лимит коррекции времени)');  Result:=false; end;
            16: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR16= Превышен лимит ввода неправильного пароля)'); Result:=false; end;
            17: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR17= Запрошенный интервал отсутствует)');          Result:=false; end;
            18: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR18= Ошибка при расчете значений)');               Result:=false; end;
            19: begin if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(ERROR19= Операция запрещена)');                        Result:=false; end;
       end;
     end;

end;


function MES3Meter.ReadSumEnAns(var pMsg:CMessage):boolean; // Метод считывания текущих значений
var  i, k,j, res  : integer;
     tempChar   : char;
     testString : string;
     val        : double;
     date       : TDateTime;
     crcRSCH    : byte;
begin
   Result := false;
   if not CRC(pMsg.m_sbyInfo[0], 1, pMsg.m_swLen - 14,crcRSCH) then // в расчете CRC участвуют все байты кроме байта CRC<BCC> и стартового <SOH>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[0] <> $02) then // Проверка является ли стартовый байт символом <STX>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[pMsg.m_swLen - 15] <> $03) then // Проверка является ли стоповый байт перед CRC верным
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[8] <> $38) then   // Проверка на команду 8(чтение суточных значений)
   begin
        exit;
   end;

   //k := 10; // байт первой открывающейся скобки, после него пойдут данные "("

   j:=0;
   while pMsg.m_sbyInfo[j] <> $28 do // до первой открывающейся скобки "(" , один блок данных
        begin
            inc(j);
        end;
   k:=j;

   for i :=0 to 4 do
   begin
        // Алгоритм обработки такой: байт запихивается в переменную типа CHAR, он преобразуется по ASCII,
        // затем этот символ добавляется к конец строки, которая потом конвертируется в INT
        k := k + 1; // первый байт данных
        while pMsg.m_sbyInfo[k] <> $29 do // до закрывающейся скобки ")" , один блок данных
        begin
                tempChar := Chr(pMsg.m_sbyInfo[k]);
                Insert(tempChar, testString, Length(testString)+1);
                k := k + 1;
        end;
        res := StrToInt(testString);
        val := res/1000; // счетчик возвращает в Вт*ч,  перевод в КВт*ч

          CreateOutMSG(val, QRY_ENERGY_SUM_EP, i, Now);
          saveToDB(m_nRxMsg);

        testString := '';
        k:=k+1;
   end;
   k := k + 1;
   while pMsg.m_sbyInfo[k] <> $29 do
   begin
        tempChar := Chr(pMsg.m_sbyInfo[k]);
        Insert(tempChar, testString, Length(testString)+1);
        k := k + 1;
   end;
   Result := true;
end;

function MES3Meter.ReadNakEnDayAns(var pMsg:CMessage):boolean; // Метод считывания суточных значений
var  i, k, j, res  : integer;
     tempChar   : char;
     testString : string;
     val        : double;
     date       : TDateTime;
     crcRSCH    : byte;
begin
   Result := false;
   if not CRC(pMsg.m_sbyInfo[0], 1, pMsg.m_swLen - 14,crcRSCH) then // в расчете CRC участвуют все байты кроме байта CRC<BCC> и стартового <SOH>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[0] <> $02) then // Проверка является ли стартовый байт символом <STX>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[pMsg.m_swLen - 15] <> $03) then // Проверка является ли стоповый байт перед CRC верным
   begin
        exit;
   end;
   if ((pMsg.m_sbyInfo[8] <> $31) Or (pMsg.m_sbyInfo[7] <> $32) Or (pMsg.m_sbyInfo[10] <> $38)) then   // Проверка на команду 128(чтение суточных значений)
   begin
        exit;
   end;

   j:=0;
   while pMsg.m_sbyInfo[j] <> $28 do // до первой открывающейся скобки "(" , один блок данных
        begin
            inc(j);
        end;
       k:=j;
 //  k := 14; // байт первой открывающейся скобки, после него пойдут данные "("

   for i :=0 to 4 do
   begin
        // Алгоритм обработки такой: байт запихивается в переменную типа CHAR, он преобразуется по ASCII,
        // затем этот символ добавляется к конец строки, которая потом конвертируется в INT
        k := k + 1; // первый байт данных
        while pMsg.m_sbyInfo[k] <> $29 do // до закрывающейся скобки ")" , один блок данных
        begin
                tempChar := Chr(pMsg.m_sbyInfo[k]);
                Insert(tempChar, testString, Length(testString)+1);
                k := k + 1;
        end;
        res := StrToInt(testString);
        val := res/1000; // счетчик возвращает в Вт*ч,  перевод в КВт*ч

         date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
         CreateOutMSG(val, QRY_NAK_EN_DAY_EP, i, date);
         saveToDB(m_nRxMsg);

        testString := '';
        k:=k+1;
   end;
   k := k + 1;
   while pMsg.m_sbyInfo[k] <> $29 do
   begin
        tempChar := Chr(pMsg.m_sbyInfo[k]);
        Insert(tempChar, testString, Length(testString)+1);
        k := k + 1;
   end;
   Result := true;
end;

function MES3Meter.ReadNakEnMonAns(var pMsg:CMessage):boolean;
var  i, k, j, res  : integer;
     tempChar   : char;
     testString : string;
     val        : double;
     date       : TDateTime;
     crcRSCH    : byte;
begin
   Result := false;
   if not CRC(pMsg.m_sbyInfo[0], 1, pMsg.m_swLen - 14, crcRSCH) then // в расчете CRC участвуют все байты кроме байта CRC<BCC> и стартового <SOH>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[0] <> $02) then // Проверка является ли стартовый байт символом <STX>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[pMsg.m_swLen - 15] <> $03) then // Проверка является ли стоповый байт перед CRC верным
   begin
        exit;
   end;
    if ((pMsg.m_sbyInfo[8] <> $31) Or (pMsg.m_sbyInfo[9] <> $32) Or (pMsg.m_sbyInfo[10] <> $39)) then    // Проверка на команду 129(чтение месячных значений)
   begin
        exit;
   end;

   j:=0;
   while pMsg.m_sbyInfo[j] <> $28 do // до первой открывающейся скобки "(" , один блок данных
        begin
            inc(j);
        end;
   k:=j;

  // k := 14; // байт первой открывающейся скобки, после него пойдут данные "("
   for i :=0 to 4 do
   begin
        // Алгоритм обработки такой: байт запихивается в переменную типа CHAR, он преобразуется по ASCII,
        // затем этот символ добавляется к конец строки, которая потом конвертируется в INT
        k := k + 1; // первый байт данных
        while pMsg.m_sbyInfo[k] <> $29 do // до закрывающейся скобки ")" , один блок данных
        begin
                tempChar := Chr(pMsg.m_sbyInfo[k]);
                Insert(tempChar, testString, Length(testString)+1);
                k := k + 1;
        end;
        res := StrToInt(testString);
        val := res/1000; // счетчик возвращает в Вт*ч,  перевод в КВт*ч
        val := val*m_nP.m_sfKI * m_nP.m_sfKU;
        date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
        CreateOutMSG(val, QRY_NAK_EN_MONTH_EP, i, date);
        saveToDB(m_nRxMsg);

        testString := '';
        k:=k+1;
   end;
   k := k + 1;
   while pMsg.m_sbyInfo[k] <> $29 do
   begin
        tempChar := Chr(pMsg.m_sbyInfo[k]);
        Insert(tempChar, testString, Length(testString)+1);
        k := k + 1;
   end;
   Result := true;
end;



function MES3Meter.ReadDateTimeAns(var pMsg: CMessage): boolean;
begin
   Result := true;
   case nReq.m_swSpecc0 of
     0 : Result := ReadTimeAns(pMsg);
     1 : Result := ReadCorTimeAns(pMsg);
   end;
end;


function MES3Meter.ReadTimeAns(var pMsg: CMessage): boolean;
var
dateRead         : TDateTime;
crcRSCH          : byte;
tempChar         : char;
testString       : string;
year, month, day : word;
h, m, s          : word;
h1,m1,s1         : word;
begin
   Result := false;

  if not CRC(pMsg.m_sbyInfo[0], 1, pMsg.m_swLen - 14, crcRSCH) then // в расчете CRC участвуют все байты кроме байта CRC<BCC> и стартового <SOH>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[0] <> $02) then // Проверка является ли стартовый байт символом <STX>
   begin
        exit;
   end;
   if (pMsg.m_sbyInfo[pMsg.m_swLen - 15] <> $03) then // Проверка является ли стоповый байт перед CRC верным
   begin
        exit;
   end;

   if (pMsg.m_sbyInfo[7] <> $39) then    // Проверка на команду 129(чтение месячных значений)
   begin
        exit;
   end;
   try
   tempChar := Chr(pMsg.m_sbyInfo[11]);
   Insert(tempChar, testString, Length(testString)+1);
   tempChar := Chr(pMsg.m_sbyInfo[12]);
   Insert(tempChar, testString, Length(testString)+1);
   year:= 2000+StrToInt(testString);
   testString := '';

   tempChar := Chr(pMsg.m_sbyInfo[14]);
   Insert(tempChar, testString, Length(testString)+1);
   tempChar := Chr(pMsg.m_sbyInfo[15]);
   Insert(tempChar, testString, Length(testString)+1);
   month:= StrToInt(testString);
   testString := '';

   tempChar := Chr(pMsg.m_sbyInfo[17]);
   Insert(tempChar, testString, Length(testString)+1);
   tempChar := Chr(pMsg.m_sbyInfo[18]);
   Insert(tempChar, testString, Length(testString)+1);
   day:= StrToInt(testString);
   testString := '';

   tempChar := Chr(pMsg.m_sbyInfo[20]);
   Insert(tempChar, testString, Length(testString)+1);
   tempChar := Chr(pMsg.m_sbyInfo[21]);
   Insert(tempChar, testString, Length(testString)+1);
   h:= StrToInt(testString);
   testString := '';

   tempChar := Chr(pMsg.m_sbyInfo[23]);
   Insert(tempChar, testString, Length(testString)+1);
   tempChar := Chr(pMsg.m_sbyInfo[24]);
   Insert(tempChar, testString, Length(testString)+1);
   m:= StrToInt(testString);
   testString := '';

   tempChar := Chr(pMsg.m_sbyInfo[26]);
   Insert(tempChar, testString, Length(testString)+1);
   tempChar := Chr(pMsg.m_sbyInfo[27]);
   Insert(tempChar, testString, Length(testString)+1);
   s:= StrToInt(testString);
   testString := '';

   if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Время счетчика = '+ IntToStr(day)+':'+ IntToStr(month)+':'+ IntToStr(year)+'г. ' + IntToStr(h)+':'+ IntToStr(m)+':'+ IntToStr(s));
    dateRead := EncodeDate(year, month, day) +  EncodeTime(h, m, s, 0);
   except
     dateRead := Now;
   end;
   dateRazn:= dateRead - Now;
//    DecodeTime(dateRazn, h1,m1,s1);


   if abs(dateRead - Now) > EncodeTime(0, 0, 15, 0) then
     begin
       if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Cчетчик нуждается в коррекции времени');
       m_nObserver.AddGraphParam(QRY_DATA_TIME, 1,0,0,1);  //заносим в Spec0=1 параметр для корекции дата/время счетчика
       Result := true;
     end
   else
     begin
        Result := true;
        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Cчетчик не нуждается в коррекции времени');
     end;
end;

function MES3Meter.ReadCorTimeAns(var pMsg: CMessage): boolean;
var dateRead : TDateTime;
begin
   Result := false;

   if (((pMsg.m_swLen - 13) <> $0C) Or ((pMsg.m_swLen - 13) = $06)) then
   begin
     exit;
   end;
   if ((pMsg.m_sbyInfo[2] ) <> $96) then
   begin
     exit;
   end;

   try
        dateRead := EncodeDate(pMsg.m_sbyInfo[5] + $7D0, pMsg.m_sbyInfo[4], pMsg.m_sbyInfo[3]) +
        EncodeTime(pMsg.m_sbyInfo[7], pMsg.m_sbyInfo[8], pMsg.m_sbyInfo[9], 0);
   except
     dateRead := Now;
   end;

   if abs(dateRead - Now) > EncodeTime(0, 0, 15, 0) then
   begin
     Result := true;
   end
end;


procedure MES3Meter.InitMeter(var pL2:SL2TAG);
var
  slv : TStringList;
Begin
//    m_nCounter := 0;
//    m_nCounter1:= 0;
    IsUpdate   := 0;
    SetHandScenario;
    SetHandScenarioGraph;

   slv := TStringList.Create;
   getStrings(m_nP.m_sAdvDiscL2Tag,slv);
   if slv[0]='' then slv[0] := '0';
   if slv[2]='' then slv[2] := '0';
   m_Address   := slv[2];
   slv.Clear;
   slv.Destroy;
End;

procedure MES3Meter.RunMeter;
Begin

End;

function MES3Meter.CRC(var buf : array of byte; begin_byte, cnt : integer; var crcRasch:byte):boolean;   // Метод расчета CRC
var
    cmp, i               : integer;
    CRC_byte, idx     : byte;
begin
    Result   := true;
    CRC_byte := $00;
    cmp      := cnt-1;
    if cnt >= 600 then
    begin
       Result := false;
       exit;
    end;
    for i:=begin_byte to cmp do
    begin
     CRC_byte       := (CRC_byte Xor buf[i]);
    end;
    idx := CRC_byte shr 7;
    if (idx = $01)    then    // определение маскирован ли нулем старший бит CRC
    begin
        CRC_byte := CRC_byte Xor $80;  // если да, то Xor с числом 1000 0000 b, обнуление старшего бита
    end;

    if (CRC_byte <> buf[cnt]) then
      Result := false;
    //buf[cnt + 1]  := CRC_byte;
    crcRasch:= CRC_byte; 
end;

function MES3Meter.HiHandler(var pMsg:CMessage):Boolean;
var
   res          : Boolean;
   tempP        : ShortInt;
   FNCNum       : Integer;
   crc          : word;
begin
   res := false;
   //Обработчик для L3
   try
   m_nRxMsg.m_sbyServerID := 0;
   case pMsg.m_sbyType of
     QL_DATARD_REQ:
     Begin
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
//       if nReq.m_swParamID=QM_ENT_MTR_IND   then
//        Begin OnEnterAction;exit;End;
//       if nReq.m_swParamID=QM_FIN_MTR_IND   then
//       Begin OnFinalAction;exit;End;
       case nReq.m_swParamID of
         QRY_ENERGY_SUM_EP   : CreateSumEnergReq;
         QRY_NAK_EN_DAY_EP   : CreateNakEnDayReq;
         QRY_NAK_EN_MONTH_EP : CreateNakEnMonReq;
         QRY_DATA_TIME       : CreateDateTimeReq;
       end;

     end;
     QL_DATA_GRAPH_REQ     : HandQryRoutine(pMsg);
     QL_DATA_FIN_GRAPH_REQ : OnFinHandQryRoutine(pMsg);
   end;
   except
   end;
   Result := res;
end;


function MES3Meter.LoHandler(var pMsg:CMessage):Boolean;
var
    res    : Boolean;
    crc    : word;
    BolCRC : Boolean;
begin
    res := False;
    try
     case pMsg.m_sbyType of
      PH_DATA_IND:
      begin
       BolCRC:=ControlCRC(pMsg);
         if not BolCRC then
           begin
             Result:=true;
             exit;
           end;
        case ReadParamID of
          QRY_ENERGY_SUM_EP   : res := ReadSumEnAns(pMsg);
          QRY_DATA_TIME       : res := ReadDateTimeAns(pMsg);
          QRY_NAK_EN_DAY_EP   : res := ReadNakEnDayAns(pMsg);
          QRY_NAK_EN_MONTH_EP : res := ReadNakEnMonAns(pMsg);
        else
            begin
            if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка не существующей команды! Будет очишен буфер команд для счетчика!');
            m_nObserver.ClearGraphQry;//Очищаем буфер команд
            res := True;
            end;
        end;
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    end;
    except
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка не существующей команды! Будет очишен буфер команд для счетчика!');
      m_nObserver.ClearGraphQry;//Очищаем буфер команд
      res := True;
    end;
    Result := res;
end;

procedure MES3Meter.HandQryRoutine(var pMsg:CMessage);
var
    Date1, Date2 : TDateTime;
    param        : word;
    wPrecize     : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate   := 1;
//    m_nCounter := 0;
//    m_nCounter1:= 0;
    //m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    wPrecize := pDS.m_swData2;
    case param of
      QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM,
      QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM      : AddNakEnergyDayGraphQry(Date1, Date2);
      QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM  : AddNakEnergyMonthGraphQry(Date1, Date2);
    end;
end;

procedure MES3Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    begin
     IsUpdate   := 0;
//     m_nCounter := 0;
//     m_nCounter1:= 0;
   end;
end;

procedure MES3Meter.OnEnterAction;
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>MES3Meter OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
End;

procedure MES3Meter.OnFinalAction;
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>MES3Meter OnFinalAction');
End;

procedure MES3Meter.OnConnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>MES3Meter OnConnectComplette');
    m_nModemState := 1;
End;

procedure MES3Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>MES3Meter OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure MES3Meter.CreateDateTimeReq;
begin
   case nReq.m_swSpecc0 of
      0: CreateReadTimeReq;  //Чтение времени для проверки расхождения текущего времения и времени счетчика
      1: CreateCorrTimeReq;  //Корректировка времени для проверки расхождения текущего времения и времени счетчика
    end;
end;

procedure MES3Meter.CreateReadTimeReq;
var
    tmpStr        : string;
    crcRSCH       : byte;
begin
   ReadParamID    := QRY_DATA_TIME;
   ///?Адрес!R1<STX>1-0:0.9.1<ETX><BCC>
   tmpStr := '/?' + m_Address + '!' + 'R1'+  #$02+ '1-0:0.9.1'+ #$03;

   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   CRC(m_nTxMsg.m_sbyInfo[0], 7, Length(tmpStr),crcRSCH);
   m_nTxMsg.m_sbyInfo[Length(tmpStr)]:= crcRSCH;
   MsgHead(m_nTxMsg, Length(tmpStr)+1 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure MES3Meter.CreateCorrTimeReq;
var
    tmpStr        : string;
    crcRSCH       : byte;
begin
   ReadParamID    := QRY_DATA_TIME;
   ///«/?Адрес!W1<STX>0-0:96.51.0(Смещение)<ETX><BCC>»

   tmpStr := '/?' + m_Address + '!' + 'W1'+  #$02+ '0-0:96.51.0'+IntToStr(0)+ #$03;

   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   CRC(m_nTxMsg.m_sbyInfo[0], 7, Length(tmpStr),crcRSCH);
   m_nTxMsg.m_sbyInfo[Length(tmpStr)]:= crcRSCH;
   MsgHead(m_nTxMsg, Length(tmpStr)+1 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;


procedure MES3Meter.CreateSumEnergReq;
var dateToRead, date : TDateTime;
    year, month, day : word;
    offset        : integer;
    tmpStr        : string;
    crcRSCH       : byte;
begin
   ReadParamID    := QRY_ENERGY_SUM_EP;

   DecodeDate(Now, year, month, day);
   if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
   begin
     nReq.m_swSpecc0 := year;
     nReq.m_swSpecc1 := month;
     nReq.m_swSpecc2 := day;
   end;

   tmpStr := '/?' + m_Address + '!' + 'R1<STX>' +#$02+ '1-1:1.8.0(5)'+ #$03; //1-активная, 2-реактивная, 15-по модулю

   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   CRC(m_nTxMsg.m_sbyInfo[0], 7, Length(tmpStr),crcRSCH);
   m_nTxMsg.m_sbyInfo[Length(tmpStr)]:= crcRSCH;
   MsgHead(m_nTxMsg, Length(tmpStr)+1 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure MES3Meter.CreateNakEnDayReq;
var dateToRead, date : TDateTime;
    year, month, day : word;
    offset        : integer;
    tmpStr        : string;
    crcRSCH       : byte;
begin
   ReadParamID    := QRY_NAK_EN_DAY_EP;

   DecodeDate(Now, year, month, day);
   if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
   begin
     nReq.m_swSpecc0 := year;
     nReq.m_swSpecc1 := month;
     nReq.m_swSpecc2 := day;
   end;

   date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
   offset := trunc(Now) - trunc(date);

   tmpStr := '/?' + m_Address + '!'+ 'R1'+  #$02+ '1-1:1.128.0*'+IntToStr(offset)+'(5)'+ #$03;    //1-активная, 2-реактивная, 15-по модулю
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   CRC(m_nTxMsg.m_sbyInfo[0], 7, Length(tmpStr),crcRSCH);
   m_nTxMsg.m_sbyInfo[Length(tmpStr)]:= crcRSCH;
   MsgHead(m_nTxMsg, Length(tmpStr)+1 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);

end;

procedure MES3Meter.CreateNakEnMonReq;
var dateToRead       : TDateTime;
    year, month, day : word;
    offset           : integer;
    tmpStr           : string;
    crcRSCH          : byte;
begin
   ReadParamID       := QRY_NAK_EN_MONTH_EP;
   DecodeDate(Now, year, month, day);
   if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
   begin
     nReq.m_swSpecc0 := year;
     nReq.m_swSpecc1 := month;
     nReq.m_swSpecc2 := day;
   end;
   if ((year - nReq.m_swSpecc0) < 0) then
   begin
        offset := 12*abs(year - nReq.m_swSpecc0 - 1) + month +(12 - nReq.m_swSpecc1) - 1;
   end
   else
   begin
        offset := month - nReq.m_swSpecc1;//-1
   end;

   tmpStr := '/?' + m_Address + '!'+ 'R1' + #$02+ '1-1:15.129.0*'+IntToStr(offset)+'(5)'+ #$03;   //1-активная, 2-реактивная, 15-по модулю
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));  //tmpStr[1]
   CRC(m_nTxMsg.m_sbyInfo[0], 7, Length(tmpStr),crcRSCH);
   m_nTxMsg.m_sbyInfo[Length(tmpStr)]:= crcRSCH;

   MsgHead(m_nTxMsg, Length(tmpStr)+1 + 13);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

end.
