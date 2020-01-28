unit knsl2SSDUBytmeter;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule,
utlTimeDate, utldatabase, StrUtils, Math;
type
    SSDUBytMeters = class(CMeter)
    Private
     DepthEvEnd  : Integer;
     nReq        : CQueryPrimitive;

     IndCommand  : Byte;
     channel     : integer;
     IdMas       : integer; //Параметр для задания промежутка чтения показаний

     inFABNUM    : array [0..255] of String; // массив вычтенных заводских номеров
     indDataFSum : array [0..255] of Double; //массив вычтенных данных Сумма
     indDataF1   : array [0..255] of Double; //массив вычтенных данных Т1
     indDataF2   : array [0..255] of Double; //массив вычтенных данных Т2
     indDataF3   : array [0..255] of Double; //массив вычтенных данных Т3
     indDataF4   : array [0..255] of Double; //массив вычтенных данных Т4

     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg0:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     function    GetValue(var pMsg:CMessage;i:integer;var state:boolean):Double;
     function    GetValueCONVEER(var pMsg:CMessage;i,sm_next:integer;var check_state:boolean):Double;
     procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     procedure   AddNakEnDayGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddNakEnMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     procedure   CreateMsgHead;
     function    AddCRC(var buf : array of byte; cnt : integer):boolean;
     function    PutBCDToInt(BCDbuf:PByteArray; cnt:integer):int64;
     function    GetDateWIntex(nIndex,pos:Integer):TDateTime;
     function    GetIntexDate(nData:TDateTime; nIndex:Integer ):Integer;
    private
     //Запросы
     function Read_One_Channel(pReq:CQueryPrimitive):Boolean;//Чтение конфигурации одного узла
     function AUTORIZATION_REQ(pReq:CQueryPrimitive):Boolean;
     function ENERGY_SUM_REQ(pReq:CQueryPrimitive):Boolean;
     function ENERGY_DAY_REQ(pReq:CQueryPrimitive):Boolean;
     function ENERGY_MON_REQ(pReq:CQueryPrimitive):Boolean;
     function SRES_ENR_REQ(pReq:CQueryPrimitive):Boolean;
     function NAK_EN_DAY_REQ(pReq:CQueryPrimitive):Boolean;
     function NAK_EN_MONTH_REQ(pReq:CQueryPrimitive):Boolean;
     function DATA_TIME_REQ(pReq:CQueryPrimitive):Boolean;
     function DATA_TIME_CORR_REQ(pReq:CQueryPrimitive):Boolean;
     //Ответы
     function Get_One_Channel(var pMsg:CMessage):Boolean;   //Ответ на чтение конфигурации одного узла
     function ENERGY_SUM_RES(var pMsg:CMessage):Boolean;
     function NAK_EN_DAY_RES(var pMsg:CMessage):Boolean;
     function NAK_EN_MONTH_RES(var pMsg:CMessage):Boolean;
     function DATA_TIME_RES(var pMsg:CMessage):Boolean;
     function DATA_TIME_SET_RES(var pMsg:CMessage):Boolean;
     function IsTrueValue(var dbVal:Double):Boolean;
     function HexToSingle(hex:string):single;
     function BufPositionValue(var pMsg:CMessage;CMD,Bbeg:integer):Boolean;
    End;
implementation
constructor SSDUBytMeters.Create;
Begin
End;

procedure SSDUBytMeters.InitMeter(var pL2:SL2TAG);
Var
   i:Integer;
Begin
    IsUpdate   := 0;
    IndCommand := 0;
    for i := Low(inFABNUM) to High(inFABNUM) do
    inFABNUM[i]:='-1';                            //Массив адресов счетчиков
    for i := Low(indDataFSum) to High(indDataFSum) do
    begin
      indDataFSum[i] :=-1;                             // Массив данных  счетчиков
      indDataF1[i]   :=-1;                             // Массив данных  счетчиков
      indDataF2[i]   :=-1;                             // Массив данных  счетчиков
      indDataF3[i]   :=-1;                             // Массив данных  счетчиков
      indDataF4[i]   :=-1;                             // Массив данных  счетчиков
    end;
    IdMas:=-1;
    SetHandScenario;
    SetHandScenarioGraph;
    CreateMsgHead;
    channel  := StrToInt(m_nP.m_sddPHAddres);
End;

procedure SSDUBytMeters.CreateMsgHead;
begin
    //m_nTxMsg.m_swLen    := Size;          //pMsg.m_sbyInfo[] :=
    m_nTxMsg.m_swObjID  := m_nP.m_swMID;  //Сетевой адрес счётчика
    m_nTxMsg.m_sbyFrom  := DIR_L2TOL1;
    m_nTxMsg.m_sbyFor   := DIR_L2TOL1;    //DIR_L2toL1
    m_nTxMsg.m_sbyType  := PH_DATARD_REQ; //PH_DATARD_REC
    m_nTxMsg.m_sbyIntID := m_nP.m_sbyPortID;
    m_nTxMsg.m_sbyDirID := m_nP.m_sbyPortID;
end;

procedure SSDUBytMeters.AddNakEnDayGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var //TempDate         : TDateTime;
    year, month, day : word;
    i                : integer;
begin
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   for i := trunc(dt_Date1) to trunc(dt_Date2) do                     // от кол-ва тарифов зависит длина ответной посылки на запрос данных
   begin
     DecodeDate(i, year, month, day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
   end;
end;

procedure SSDUBytMeters.AddNakEnMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var
    year, month, day : word;
begin
     while (dt_Date1 <= dt_Date2) and (dt_Date1 <= Now) do
     begin
       DecodeDate(dt_Date1, year, month, day);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
       cDateTimeR.IncMonth(dt_Date1);
     end
end;
procedure SSDUBytMeters.SetGraphQry;
begin
end;
function SSDUBytMeters.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    Result := res;
End;

function SSDUBytMeters.GetValue(var pMsg:CMessage;i:integer;var state:boolean):Double;
var IEEE754  : string;
    position : shortint;
    ki,ku    : integer;
Begin
    try
     state:=true;
     Result := 0;
     //if(pMsg.m_sbyInfo[8+(4*i)+2]=$00)and(pMsg.m_sbyInfo[8+(4*i)+3]=$00)then exit;
     for position := 0 to 3 do
         IEEE754 :=IntToHex(pMsg.m_sbyInfo[8+(4*i)+position],2)+ IEEE754;
      Result := HexToSingle(IEEE754);
     if Result<=0.0000001 then
     begin
      state:=false;
      Result := 0;
     end;
    except
     state:=false;
     Result := 0;
    end;
End;

function SSDUBytMeters.GetValueCONVEER(var pMsg:CMessage;i,sm_next:integer;var check_state:boolean):Double;
var IEEE754  : string;
position : shortint;
Begin
    try
     check_state:=true;
     Result := 0;
     if(pMsg.m_sbyInfo[8+(4*i+sm_next)]=$00) and (pMsg.m_sbyInfo[8+(4*i+sm_next)+1]=$80) and (pMsg.m_sbyInfo[8+(4*i+sm_next)+2]=$bf)and (pMsg.m_sbyInfo[8+(4*i+sm_next)+3]=$00) then
       begin
        check_state:=false;
        Result := 0;
        exit;
       end;
     for position := 0 to 3 do IEEE754 :=IntToHex(pMsg.m_sbyInfo[8+(4*i+sm_next)+position],2)+ IEEE754; {InttoStr}
     Result := HexToSingle(IEEE754);
     if Result<=0.0000001 then
     begin
      check_state:=false;
      Result := 0;
     end;
    except
     Result := 0;
    end;
End;

procedure SSDUBytMeters.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
var Year, Month, Day,
    Hour, Min, Sec, ms : word;
begin                         //sm - вид энергии; tar - тарифф
   DecodeDate(Date, Year, Month, Day);
   DecodeTime(Date, Hour, Min, Sec, ms);
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

procedure SSDUBytMeters.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    //m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    case param of
     QRY_NAK_EN_DAY_EP   : AddNakEnDayGrpahQry(Date1, Date2);
     QRY_NAK_EN_MONTH_EP : AddNakEnMonthGrpahQry(Date1, Date2);
     QRY_ENERGY_MON_EP   : AddNakEnMonthGrpahQry(Date1, Date2);
    end;
end;

function SSDUBytMeters.Read_One_Channel(pReq:CQueryPrimitive):Boolean;
Var
   Year,Month,Day:Word;
Begin
    if pReq.m_swSpecc0=-1 then
    Begin
     DecodeDate(Now,Year,Month,Day);
     pReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Year;
    End;
    IndCommand := pReq.m_swSpecc0;
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
/////////////HDR/////////////////
    m_nTxMsg.m_sbyInfo[0] := $00;  //адрес
    m_nTxMsg.m_sbyInfo[1] := $02;  //всегда 2
    m_nTxMsg.m_sbyInfo[2] := $10;  //размер         2 байта
    m_nTxMsg.m_sbyInfo[3] := $00;  //       пакета
    m_nTxMsg.m_sbyInfo[4] := pReq.m_swSpecc0; //byte(channel); // номер пакета
    m_nTxMsg.m_sbyInfo[5] := $00;           // флаг (саммый младший бит в 0 при запросе; 1 - при ответе. 7 старших бита всегда 0)
    m_nTxMsg.m_sbyInfo[6] := $06;           // параметр (6 - чтение конфигурации узлов)
    m_nTxMsg.m_sbyInfo[7] := $00;           // операция (0 - чтение; 1 - запись)
/////////////HDR/////////////////
    m_nTxMsg.m_sbyInfo[8] := $01;           // множество (1 - упорядоченное по возрастанию)
    m_nTxMsg.m_sbyInfo[9] := pReq.m_swSpecc1;//Byte(channel);//byte(test_massiv^ [0]+1); // адрес узла с 1
    m_nTxMsg.m_sbyInfo[10]:= pReq.m_swSpecc2;//Byte(channel);//byte(test_massiv^ [1]);   // адрес узла по 1
    m_nTxMsg.m_sbyInfo[11]:= $06;
    m_nTxMsg.m_sbyInfo[12]:= $11;//GetIntexDate(EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2),1); // смещение по месяцу
    m_nTxMsg.m_sbyInfo[13]:= $01;
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[2];
    AddCRC(m_nTxMsg.m_sbyInfo ,m_nTxMsg.m_sbyInfo[2]);
    Result := True;
End;

function SSDUBytMeters.Get_One_Channel(var pMsg:CMessage):Boolean;
Var
    tempChar    : char;
    i,k         : integer;
    Fabb_Number : string;
Begin
    if (pMsg.m_sbyInfo[4]= IndCommand)then
      begin
        if (IndCommand=3)then
          dynconnect.setQueryState(m_nP.M_SWABOID,-1,QUERY_STATE_ER); //опмечаем как все не опрошенные
      for k:=0 to 64 do
       begin
        if (byte(pMsg.m_sbyInfo[8+(k*13)])=0)then //проверка на пустой узел (если пусто, то не пишем адрес узла и не читаем данные)
        begin
         continue;
        end
        else
        begin
          Fabb_Number:='';
          for i:=0 to 9 do
          begin
            tempChar:= Chr(pMsg.m_sbyInfo[(11+(k*13))+i]); //извлекаем строковое обозначение заводского номера устройства
            Insert(tempChar, Fabb_Number, Length(Fabb_Number)+1);
          end;
          inFABNUM[nReq.m_swSpecc1-1+k]:=Trim(Fabb_Number);
          Result:=True;
        end;
       end;
      end
    else
    Result := False;
End;

function SSDUBytMeters.AUTORIZATION_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;

function SSDUBytMeters.ENERGY_SUM_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $00;
    m_nTxMsg.m_sbyInfo[1] := $02;
    m_nTxMsg.m_sbyInfo[2] := $10;
    m_nTxMsg.m_sbyInfo[3] := $00;
    if (IdMas=-1)then
      begin
        m_nTxMsg.m_sbyInfo[4] := $04; // индентификатор пакета
        m_nTxMsg.m_sbyInfo[9] := $01; // адрес с какого по какой канал считывать
        m_nTxMsg.m_sbyInfo[10]:= $32; // адрес с какого по какой канал считывать
        IdMas:=0;
      end
    else
    begin
     case (IdMas) of
     0:      begin
              m_nTxMsg.m_sbyInfo[4] := $05; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $33; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $64; // адрес с какого по какой канал считывать
              IdMas:=1;
             end;
     1:      begin
              m_nTxMsg.m_sbyInfo[4] := $06; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $65; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $96; // адрес с какого по какой канал считывать
              IdMas:=2;
             end;
     2:      begin
              m_nTxMsg.m_sbyInfo[4] := $07; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $97; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $C8; // адрес с какого по какой канал считывать
              IdMas:=3;
             end;
     3:      begin
              m_nTxMsg.m_sbyInfo[4] := $08; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $C9; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $FA; // адрес с какого по какой канал считывать
              IdMas:=4;
             end;
     4:      begin
              m_nTxMsg.m_sbyInfo[4] := $09; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $FB; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $FF; // адрес с какого по какой канал считывать
              IdMas:=5;
             end;
     end;
    end;
    m_nTxMsg.m_sbyInfo[5] := $00;
    m_nTxMsg.m_sbyInfo[6] := $0D;
    m_nTxMsg.m_sbyInfo[7] := $00;
    m_nTxMsg.m_sbyInfo[8] := $01;

    m_nTxMsg.m_sbyInfo[11]:= $01;
    m_nTxMsg.m_sbyInfo[12]:= $00; // считывать сумму тарифов
    m_nTxMsg.m_sbyInfo[13]:= $04; // колличество таррифов
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[2];
    AddCRC(m_nTxMsg.m_sbyInfo ,m_nTxMsg.m_sbyInfo[2]);
    Result := True;
End;

function SSDUBytMeters.ENERGY_DAY_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
function SSDUBytMeters.ENERGY_MON_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
function SSDUBytMeters.SRES_ENR_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
function SSDUBytMeters.NAK_EN_DAY_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $00;
    m_nTxMsg.m_sbyInfo[1] := $02;
    m_nTxMsg.m_sbyInfo[2] := $12;
    m_nTxMsg.m_sbyInfo[3] := $00;
    if (IdMas=-1)then
      begin
        m_nTxMsg.m_sbyInfo[4] := $04; // индентификатор пакета
        m_nTxMsg.m_sbyInfo[9] := $01; // адрес с какого по какой канал считывать
        m_nTxMsg.m_sbyInfo[10]:= $32; // адрес с какого по какой канал считывать
        IdMas:=0;
      end
    else
    begin
     case (IdMas) of
     0:      begin
              m_nTxMsg.m_sbyInfo[4] := $05; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $33; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $64; // адрес с какого по какой канал считывать
              IdMas:=1;
             end;
     1:      begin
              m_nTxMsg.m_sbyInfo[4] := $06; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $65; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $96; // адрес с какого по какой канал считывать
              IdMas:=2;
             end;
     2:      begin
              m_nTxMsg.m_sbyInfo[4] := $07; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $97; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $C8; // адрес с какого по какой канал считывать
              IdMas:=3;
             end;
     3:      begin
              m_nTxMsg.m_sbyInfo[4] := $08; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $C9; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $FA; // адрес с какого по какой канал считывать
              IdMas:=4;
             end;
     4:      begin
              m_nTxMsg.m_sbyInfo[4] := $09; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $FB; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $FF; // адрес с какого по какой канал считывать
              IdMas:=5;
             end;
     end;
    end;
    m_nTxMsg.m_sbyInfo[5] := $00;
    m_nTxMsg.m_sbyInfo[6] := $11;
    m_nTxMsg.m_sbyInfo[7] := $00;
    m_nTxMsg.m_sbyInfo[8] := $01;

    m_nTxMsg.m_sbyInfo[11]:= $00;
    m_nTxMsg.m_sbyInfo[12]:= GetIntexDate(EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2),0); // смещение по дню
    m_nTxMsg.m_sbyInfo[13]:= $01;
    m_nTxMsg.m_sbyInfo[14]:= $00; // считывать сумму тарифов
    m_nTxMsg.m_sbyInfo[15]:= $04; // колличество таррифов
   //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[2];
    AddCRC(m_nTxMsg.m_sbyInfo ,m_nTxMsg.m_sbyInfo[2]);
    Result := True;
End;
function SSDUBytMeters.NAK_EN_MONTH_REQ(pReq:CQueryPrimitive):Boolean;
Var
    Year,Month,Day:Word;
Begin
    if pReq.m_swSpecc0=-1 then
    Begin
     DecodeDate(Now,Year,Month,Day);
     pReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Year;
    End;
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $00;
    m_nTxMsg.m_sbyInfo[1] := $02;
    m_nTxMsg.m_sbyInfo[2] := $12;
    m_nTxMsg.m_sbyInfo[3] := $00;
    if (IdMas=-1)then
      begin
        m_nTxMsg.m_sbyInfo[4] := $04; // индентификатор пакета
        m_nTxMsg.m_sbyInfo[9] := $01; // адрес с какого по какой канал считывать
        m_nTxMsg.m_sbyInfo[10]:= $32; // адрес с какого по какой канал считывать
        IdMas:=0;
      end
    else
    begin
     case (IdMas) of
     0:      begin
              m_nTxMsg.m_sbyInfo[4] := $05; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $33; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $64; // адрес с какого по какой канал считывать
              IdMas:=1;
             end;
     1:      begin
              m_nTxMsg.m_sbyInfo[4] := $06; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $65; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $96; // адрес с какого по какой канал считывать
              IdMas:=2;
             end;
     2:      begin
              m_nTxMsg.m_sbyInfo[4] := $07; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $97; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $C8; // адрес с какого по какой канал считывать
              IdMas:=3;
             end;
     3:      begin
              m_nTxMsg.m_sbyInfo[4] := $08; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $C9; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $FA; // адрес с какого по какой канал считывать
              IdMas:=4;
             end;
     4:      begin
              m_nTxMsg.m_sbyInfo[4] := $09; // индентификатор пакета
              m_nTxMsg.m_sbyInfo[9] := $FB; // адрес с какого по какой канал считывать
              m_nTxMsg.m_sbyInfo[10]:= $FF; // адрес с какого по какой канал считывать
              IdMas:=5;
             end;
     end;
    end;
    m_nTxMsg.m_sbyInfo[5] := $00;
    m_nTxMsg.m_sbyInfo[6] := $0e;
    m_nTxMsg.m_sbyInfo[7] := $00;
    m_nTxMsg.m_sbyInfo[8] := $01;

    m_nTxMsg.m_sbyInfo[11]:= $00;
    m_nTxMsg.m_sbyInfo[12]:= GetIntexDate(EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2),1); // смещение по месяцу
    m_nTxMsg.m_sbyInfo[13]:= $01;
    m_nTxMsg.m_sbyInfo[14]:= $00; // считывать сумму тарифов
    m_nTxMsg.m_sbyInfo[15]:= $04; // колличество таррифов
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[2];
    AddCRC(m_nTxMsg.m_sbyInfo ,m_nTxMsg.m_sbyInfo[2]);
    Result := True;
End;

function SSDUBytMeters.DATA_TIME_REQ(pReq:CQueryPrimitive):Boolean;
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
Begin
    DecodeTime(Now, Hour, Min, Sec, mSec);
    DecodeDate(Now, Year, Month, Day);

    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $00;
    m_nTxMsg.m_sbyInfo[1] := $02;
    m_nTxMsg.m_sbyInfo[2] := $18; //размер
    m_nTxMsg.m_sbyInfo[3] := $00; //размер
    m_nTxMsg.m_sbyInfo[4] := $04; //№ пакета  //pReq.m_swSpecc0;
    m_nTxMsg.m_sbyInfo[5] := $00; //флаг 0-запрос; 1 -ответ
    m_nTxMsg.m_sbyInfo[6] := $08; //параметр
    m_nTxMsg.m_sbyInfo[7] := $01; //1 Упорядоченное множество по возрастанию (первый, последний)
    m_nTxMsg.m_sbyInfo[8] := $30; //пароль
    m_nTxMsg.m_sbyInfo[9] := $30; //пароль
    m_nTxMsg.m_sbyInfo[10]:= $30; //пароль
    m_nTxMsg.m_sbyInfo[11]:= $30; //пароль
    m_nTxMsg.m_sbyInfo[12]:= $30; //пароль
    m_nTxMsg.m_sbyInfo[13]:= $30; //пароль
    m_nTxMsg.m_sbyInfo[14]:= $30; //пароль
    m_nTxMsg.m_sbyInfo[15]:= $30; //пароль
    m_nTxMsg.m_sbyInfo[16]:= Sec; //секунды
    m_nTxMsg.m_sbyInfo[17]:= Min; //минуты
    m_nTxMsg.m_sbyInfo[18]:= Hour;//часы
    m_nTxMsg.m_sbyInfo[19]:= Day; //день
    m_nTxMsg.m_sbyInfo[20]:= Month;//месяц
    m_nTxMsg.m_sbyInfo[21]:= Year-2000;  //год
    
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[2];
    AddCRC(m_nTxMsg.m_sbyInfo ,m_nTxMsg.m_sbyInfo[2]);
    Result := True;
End;

function SSDUBytMeters.DATA_TIME_CORR_REQ(pReq:CQueryPrimitive):Boolean;
Var
    Year, Month, Day,Hour, Min, Sec, ms:Word;
Begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, ms);
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $1E;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := 0; //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $fe;//Запросить время
    move(Year,m_nTxMsg.m_sbyInfo[10],2);
    m_nTxMsg.m_sbyInfo[12] := Month;
    m_nTxMsg.m_sbyInfo[13] := Day;
    m_nTxMsg.m_sbyInfo[14] := Hour;
    m_nTxMsg.m_sbyInfo[15] := Min;
    m_nTxMsg.m_sbyInfo[16] := Sec;
    m_nTxMsg.m_swLen      := 11 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg.m_sbyInfo ,m_nTxMsg.m_sbyInfo[2]); //AddCRC(m_nTxMsg);
    SendL1;
    Result := True;
End;
function SSDUBytMeters.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
Begin
    res := False;
    try
      m_nRxMsg.m_sbyServerID := 0;
      case pMsg.m_sbyType of
        QL_DATARD_REQ:
        Begin
         Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
         case nReq.m_swParamID of
              QRY_ENERGY_SUM_EP   : res := ENERGY_SUM_REQ(nReq);
              QRY_ENERGY_DAY_EP   : res := ENERGY_DAY_REQ(nReq);
              QRY_ENERGY_MON_EP   : res := ENERGY_MON_REQ(nReq);
              QRY_SRES_ENR_EP     : res := SRES_ENR_REQ(nReq);
              QRY_NAK_EN_DAY_EP   : res := NAK_EN_DAY_REQ(nReq);
              QRY_NAK_EN_MONTH_EP : res := NAK_EN_MONTH_REQ(nReq); //Для чтения данных на начало месяца
              QRY_DATA_TIME       : res := DATA_TIME_REQ(nReq);
              QRY_LOAD_ALL_PARAMS : res := Read_One_Channel(nReq); //Для чтения конфигурации узлов
         else
              exit;
         End;
         if res=True then SendL1 else
         if res=False then OnFinalAction;
        End;
        QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
        QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
      End;
      Result := res;
    except
     Result := res;
    end;
End;

function SSDUBytMeters.ENERGY_SUM_RES(var pMsg:CMessage):Boolean;
Var
  cmd:Integer;
Begin
  cmd:= QRY_ENERGY_SUM_EP;
     if ((pMsg.m_sbyInfo[4]-4)= idMas)then
       begin
       case idMas of
         0:Result := BufPositionValue(pMsg,cmd,0);
         1:Result := BufPositionValue(pMsg,cmd,50);
         2:Result := BufPositionValue(pMsg,cmd,100);
         3:Result := BufPositionValue(pMsg,cmd,150);
         4:Result := BufPositionValue(pMsg,cmd,200);
         5:Result := BufPositionValue(pMsg,cmd,250);
       end;
       end
     else
        Result := False;
End;

function SSDUBytMeters.NAK_EN_DAY_RES(var pMsg:CMessage):Boolean;
var
  cmd :integer;
Begin
    //Тарифы
    cmd:=QRY_NAK_EN_DAY_EP;
     if ((pMsg.m_sbyInfo[4]-4)= idMas)then
       begin
       case idMas of
         0:Result := BufPositionValue(pMsg,cmd,0);
         1:Result := BufPositionValue(pMsg,cmd,50);
         2:Result := BufPositionValue(pMsg,cmd,100);
         3:Result := BufPositionValue(pMsg,cmd,150);
         4:Result := BufPositionValue(pMsg,cmd,200);
         5:Result := BufPositionValue(pMsg,cmd,250);
       end;
       end
     else
        Result := False;
End;

function SSDUBytMeters.NAK_EN_MONTH_RES(var pMsg:CMessage):Boolean;
var
  cmd :integer;
Begin
    //Тарифы
    cmd:=QRY_NAK_EN_MONTH_EP;
     if ((pMsg.m_sbyInfo[4]-4)= idMas)then
       begin
       case idMas of
         0:Result := BufPositionValue(pMsg,cmd,0);
         1:Result := BufPositionValue(pMsg,cmd,50);
         2:Result := BufPositionValue(pMsg,cmd,100);
         3:Result := BufPositionValue(pMsg,cmd,150);
         4:Result := BufPositionValue(pMsg,cmd,200);
         5:Result := BufPositionValue(pMsg,cmd,250);
       end;
       end
     else
        Result := False;
End;

function SSDUBytMeters.DATA_TIME_RES(var pMsg:CMessage):Boolean;
Var
  res:Boolean;
Begin
   if (pMsg.m_sbyInfo[7]=0) then
    res:=True
   else
    res:=False;
  Result:=res;  
End;
function SSDUBytMeters.DATA_TIME_SET_RES(var pMsg:CMessage):Boolean;
Var
    Year,Month,Day,Hour,Min,Sec:Word;
Begin
    //Year  := PutBCDToInt(@pMsg.m_sbyInfo[9],2);
    move(pMsg.m_sbyInfo[10],Year,2);
    Month := pMsg.m_sbyInfo[12];
    Day   := pMsg.m_sbyInfo[13];
    Hour  := pMsg.m_sbyInfo[14];
    Min   := pMsg.m_sbyInfo[15];
    Sec   := pMsg.m_sbyInfo[16];
End;

function SSDUBytMeters.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;

function SSDUBytMeters.GetDateWIntex(nIndex,pos:Integer):TDateTime;
Var
    nYear,Year,Month,oldMonth,Day,nDay : Word;
Begin
    DecodeDate(Now,Year,oldMonth,Day);
    case pos of
    0: Begin   //индекс на смещение месяца
       if (nIndex<1) or (nIndex>12) then Month := oldMonth;
        //Month  := nReq.m_swSpecc0;
        Month := nIndex;
        nYear  := nReq.m_swSpecc0;
        Result := EncodeDate(nYear ,Month,1);
       end;

    1: Begin  //индекс на смещение дня
    //if (nIndex<1) or (nIndex>12) then Month := oldMonth;
     if (nIndex<>0) then begin nIndex := 256 - nIndex; end
     else begin nIndex := 255 - nIndex; end;
        Month  := oldMonth;
       // while nIndex =0
        if (MonthDays[IsLeapYear(2000 + Year)][Month] < nIndex) and (nIndex<Day) then
         begin
             nDay := Day -  nIndex;
         end
        else begin nDay := nIndex - Day; end;
        nYear  := Year;
        Result := EncodeDate(nReq.m_swSpecc0 ,nReq.m_swSpecc1,nReq.m_swSpecc2);
       end;
    end;
End;

function SSDUBytMeters.GetIntexDate(nData:TDateTime; nIndex:Integer):Integer;
Var
    nYear,Year,Month,nMonth,oldMonth,Day,nDay : Word;
    index,temp,days,i,j,res: integer;
Begin
    DecodeDate(Now,Year,oldMonth,Day);
    DecodeDate(nData,nYear,nMonth,nDay);
    days := 0;
  if (nDay = Day) and(nMonth = oldMonth) and (nYear = Year) then Result := 0
  else
  begin
  index := ((((Year - nYear)*12)-nMonth)+ oldMonth);
    case nIndex of
        //индекс на смещение деня
      0: Begin
           temp := Day - nDay;
           if nMonth = oldMonth then     // Если в течение текущего месяца
             begin
                res := 256 - temp;
             end
           else
            begin
             if index < 5 then
             begin
                if Year - nYear <> 0 then
                begin
                for i:= 1 to (Year - nYear) do
                begin
                    for j := 1 to (12 - nMonth) do
                    begin
                        days := days + (MonthDays[IsLeapYear(2000 + nYear)][nMonth + j]);
                    end;
                    for j := 1 to (oldMonth - 12) do
                    begin
                        days := days + (MonthDays[IsLeapYear(2000 + Year)][oldMonth - j]);
                    end;
                    res := 256 - (days + Day + ((MonthDays[IsLeapYear(2000 + nYear - 1)][nMonth]) - nDay));
                end;
                end
                else
                    begin
                        for i := 1 to (oldMonth - nMonth - 1) do
                        begin
                            days := days + (MonthDays[IsLeapYear(2000 + nYear)][oldMonth - i]);
                        end;
                        res := 256 - (days + Day + ((MonthDays[IsLeapYear(2000 + nYear)][nMonth]) - nDay));
                    end;
             end;
            end;
         End;
        //индекс на смещение месяца
     1: Begin
         res := 256 - index;
        End;
    End;
   Result := res;
  End;
End;

function SSDUBytMeters.LoHandler(var pMsg0:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
    pMsg   : CMessage;
    len    : integer;
    str    : string;
Begin
 res := False;
  try
    move(pMsg0,pMsg,sizeof(CMessage));
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        str := Format('%x', [pMsg.m_sbyInfo[3]]) + Format('%x', [pMsg.m_sbyInfo[2]]);
        len:=StrToInt('$' + str);
        if(AddCRC(pMsg.m_sbyInfo,len)<> true) then
        Begin
             Result := False;
             exit;
        End
        else
          Begin
            Result:=True;
          end;
        if (Result=True)then
        begin
            if pMsg.m_sbyInfo[5]=1 then
            Begin
             //Обработка ответов
             case pMsg.m_sbyInfo[6] of
                  $0E: Begin  res:=NAK_EN_MONTH_RES(pMsg);End;
                  $11: Begin  res:=NAK_EN_DAY_RES(pMsg);End;
                  $0D: Begin  res:=ENERGY_SUM_RES(pMsg);End;
                  $06: Begin  res:=Get_One_Channel(pMsg); End;
                  $fc: Begin  DATA_TIME_SET_RES(pMsg);exit;End;
             End;
             case nReq.m_swParamID of
                  QRY_DATA_TIME: res:=DATA_TIME_RES(pMsg);
             End;
            End;
        end
        else
         exit;
      End;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
  except
    Result := res;
  end;
End;

procedure SSDUBytMeters.OnEnterAction;
Begin

End;

procedure SSDUBytMeters.OnFinalAction;
Begin

End;

procedure SSDUBytMeters.OnConnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 1;
End;

procedure SSDUBytMeters.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 0;
End;

procedure SSDUBytMeters.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     IsUpdate := 0;
    End;
end;

function SSDUBytMeters.AddCRC(var buf : array of byte; cnt : integer):boolean;
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
    cmp     := cnt-3;
    if cnt >= 4000 then
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
    if (CRCloEl <> buf[cnt-2]) and (CRChiEl <> buf[cnt-1]) then
      Result := false;
    buf[cnt-2]  := CRCloEl;
    buf[cnt-1]  := CRChiEl;
end;

function SSDUBytMeters.PutBCDToInt(BCDbuf:PByteArray; cnt:integer):int64;
var
    i:integer;
    mul:int64;
begin
    result:=0;
    mul:=1;
    for i:=0 to cnt-1 do begin
    result:=result+ ((((BCDbuf^[i]shr 4)and $0F)*mul*10) + ((BCDbuf^[i] and $0f)*mul));
      mul := mul*100;
    end;
end;

function SSDUBytMeters.HexToSingle(hex:string):single;
var i:integer;
begin
 i:=StrToInt('$'+hex);
  result:=PSingle(@i)^;
end;

function SSDUBytMeters.BufPositionValue(var pMsg:CMessage;CMD,Bbeg:integer):Boolean;
Var
    i,k,eEnd : Integer;
    dbValue  : double;
    check_state :boolean;
    dtDate   : TDateTime;
    res      : Integer;
    Year,Month,Day,Hour,Min,Sec,Msec: Word;
    masTarif :array [0..4] of boolean;
Begin
    if CMD=QRY_ENERGY_SUM_EP then
     begin
      DecodeDate(Now,Year,Month,Day);
      DecodeTime(Now,Hour,Min,Sec,Msec);
      dtDate := EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,0);
     end
    else
    if CMD=QRY_NAK_EN_DAY_EP then
      dtDate := GetDateWIntex (nReq.m_swSpecc2,1)
    else
      dtDate := GetDateWIntex(nReq.m_swSpecc1,0);//GetDateWIntex((pMsg.m_sbyInfo[4] and $0f),0);
    if Bbeg=250
    then eEnd:=4
    else eEnd:=49;

    for k:=0 to eEnd do
     begin
       for i:=0 to 4 do
         begin
           dbValue:=GetValueCONVEER(pMsg,i,k*20,check_state);
           masTarif[i]:= check_state;
           if (check_state=true) and (inFABNUM[Bbeg+k]<>'-1')then
             begin
                if (i=0)then
                   begin
                    indDataFSum[Bbeg+k]:=dbValue;
                    CreateOutMSG(dbValue, CMD, i, dtDate);
                    saveToDB_8086(inFABNUM[Bbeg+k], m_nP.M_SWABOID,m_nRxMsg);
                   end
                else
                if (i=1)then
                   begin
                    indDataF1[Bbeg+k]:=dbValue;
                    CreateOutMSG(dbValue, CMD, i, dtDate);
                    saveToDB_8086(inFABNUM[Bbeg+k], m_nP.M_SWABOID,m_nRxMsg);
                   end
                else
                if (i=2)then
                   begin
                    indDataF2[Bbeg+k]:=dbValue;
                    CreateOutMSG(dbValue, CMD, i, dtDate);
                    saveToDB_8086(inFABNUM[Bbeg+k], m_nP.M_SWABOID,m_nRxMsg);
                   end
                else
                if (i=3)then
                   begin
                    indDataF3[Bbeg+k]:=dbValue;
                    CreateOutMSG(dbValue, CMD, i, dtDate);
                    saveToDB_8086(inFABNUM[Bbeg+k], m_nP.M_SWABOID,m_nRxMsg);
                   end
                else
                if (i=4)then
                  begin
                    indDataF4[Bbeg+k]:=dbValue;
                    CreateOutMSG(dbValue, CMD, i, dtDate);
                    saveToDB_8086(inFABNUM[Bbeg+k], m_nP.M_SWABOID,m_nRxMsg);
                  end;
                 res:= dynConnect.SetFabNum_SwVMID(m_nP.M_SWABOID,inFABNUM[Bbeg+k]);
                 if res<>-1 then
                  dynConnect.setQueryState(m_nP.M_SWABOID,res,QUERY_STATE_OK);
             end
           else
             begin
              if(masTarif[0]<>True)then
                begin
                 res:= dynConnect.SetFabNum_SwVMID(m_nP.M_SWABOID,inFABNUM[Bbeg+k]);
                 if res<>-1 then
                  dynConnect.setQueryState(m_nP.M_SWABOID,res,QUERY_STATE_ER);
                end;
             end;
         end;
     end;
     m_nT.B1 := True;
     Result  := True;
End;

procedure SSDUBytMeters.RunMeter;
Begin
End;
end.
