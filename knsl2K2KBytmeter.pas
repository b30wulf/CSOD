unit knsl2K2KBytmeter;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,knsl3observemodule,utlTimeDate,utldatabase,knsl5config,knsl3EventBox;
type
    CK2KBytMeter = class(CMeter)
    Private
     DepthEvEnd  : Integer;
     nReq        : CQueryPrimitive;
     //Ke          : word;
     Ke          : double;
     dt_TLD      : TDateTime;
     nOldYear    : Word;
     bl_SaveCrEv : boolean;
     LastMask    : word;
     mTimeDir    : Integer;
     procedure   SetCurrQry;
     procedure   SetGraphQry;
     procedure   RunMeter;override;
     procedure   InitMeter(var pL2:SL2TAG);override;
     function    SelfHandler(var pMsg:CMessage):Boolean;override;
     function    LoHandler(var pMsg0:CMessage):Boolean;override;
     function    HiHandler(var pMsg:CMessage):Boolean;override;
     constructor Create;
     procedure   HandQryRoutine(var pMsg:CMessage);
     function    GetValue(var pMsg:CMessage;i:integer):Double;
     function    GetValueOnState(var pMsg:CMessage;i:integer;var state:boolean):Double;
     function    GetValueDT(var pMsg:CMessage;i:integer):Double;
     function    GetDateTm(var pMsg:CMessage;i:integer):TDateTime;
     function    SendToL3(nType,SLID,nTar:Integer;dbValue:Double;dtTime:TDateTime) : boolean;
     procedure   AddNakEnDayGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddNakEnMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddNakEnMonthTplGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   AddNakEnDayTplGrpahQry(dt_Date1, dt_Date2 : TDateTime);
     procedure   WriteDate(var pMsg : CMessage; param : word);
     procedure   OnFinHandQryRoutine(var pMsg:CMessage);
     procedure   OnEnterAction;
     procedure   OnFinalAction;
     procedure   OnConnectComplette(var pMsg:CMessage);override;
     procedure   OnDisconnectComplette(var pMsg:CMessage);override;
     procedure   CreateMsgHead;
     Procedure   CRC16b(b: Byte; var CRC:word);
     function    CRC(pack:array of byte; count:integer):word;
     procedure   AddCRC(var pMsg:CHMessage);
     function    PutBCDToInt(BCDbuf:PByteArray; cnt:integer):int64;
     function    Byte2BCD(b:byte):byte;
     function    BCD2Byte(b:byte):byte;
     function    GetDateWIntex(nIndex:Integer):TDateTime;
     function    GetDateWIntexDay(nIndex:Integer):TDateTime;     
    private
     //Запросы
     function AUTORIZATION_REQ(pReq:CQueryPrimitive):Boolean;
     function ENERGY_SUM_REQ(pReq:CQueryPrimitive):Boolean;
     function ENERGY_DAY_REQ(pReq:CQueryPrimitive):Boolean;
     function ENERGY_MON_REQ(pReq:CQueryPrimitive):Boolean;
     function SRES_ENR_REQ(pReq:CQueryPrimitive):Boolean;
     function NAK_EN_DAY_REQ(pReq:CQueryPrimitive):Boolean;
     function NAK_EN_MONTH_REQ(pReq:CQueryPrimitive):Boolean;
     function DATA_TIME_REQ(pReq:CQueryPrimitive):Boolean;
     function DATA_TIME_CORR_REQ(pReq:CQueryPrimitive):Boolean;
     function POD_TRYB_HEAT(pReq:CQueryPrimitive):Boolean;
     function NAK_MON_TPL_REQ(pReq:CQueryPrimitive):Boolean;


     function CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean;
     function ReadDateTimeAns(var pMsg: CMessage):Boolean;        // Ответ для выбора запроса чтения или кор времени

     //Ответы
     function ENERGY_SUM_RES(var pMsg:CMessage):Boolean;
     function ENERGY_SUM_RES_DT(var pMsg:CMessage):Boolean;
     function NAK_EN_MONTH_RES(var pMsg:CMessage):Boolean;
     function NAK_EN_DAY_RES(var pMsg:CMessage):Boolean;	  
     function CURR_TPL_RES(var pMsg:CMessage):Boolean;
     function DATA_TIME_RES(var pMsg:CMessage):Boolean;
     function DATA_TIME_SET_RES(var pMsg:CMessage):Boolean;
     function NAK_MON_TPL_RES(var pMsg:CMessage):Boolean;
     function IsTrueValue(var dbVal:Double):Boolean;
    End;
implementation
const
  ST_164_READ_TIME             = 0;
  ST_164_CORR_TIME             = 1;
constructor CK2KBytMeter.Create;
Begin
End;

procedure CK2KBytMeter.InitMeter(var pL2:SL2TAG);
Begin
    mTimeDir   := ST_164_READ_TIME; //параметр чтнения времени  ST_164_READ_TIME
    IsUpdate   := 0;
    SetHandScenario;
    SetHandScenarioGraph;
    CreateMsgHead;
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CCK2KB  Meter Created:'+
//    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
//    ' Rep:'+IntToStr(m_byRep)+
//    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;
procedure CK2KBytMeter.CreateMsgHead;
begin
    //m_nTxMsg.m_swLen    := Size;          //pMsg.m_sbyInfo[] :=
    m_nTxMsg.m_swObjID  := m_nP.m_swMID;  //Сетевой адрес счётчика
    m_nTxMsg.m_sbyFrom  := DIR_L2TOL1;
    m_nTxMsg.m_sbyFor   := DIR_L2TOL1;    //DIR_L2toL1
    m_nTxMsg.m_sbyType  := PH_DATARD_REQ; //PH_DATARD_REC
    m_nTxMsg.m_sbyIntID := m_nP.m_sbyPortID;
    m_nTxMsg.m_sbyDirID := m_nP.m_sbyPortID;
end;
procedure CK2KBytMeter.SetCurrQry;
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
     AddCurrParam(QRY_SRES_ENR_EP,0,0,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_DAY_EP,0,4,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,1,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,4,0,1);
     AddCurrParam(QRY_DATA_TIME,0,0,0,1);
    End;
End;
procedure CK2KBytMeter.AddNakEnDayGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;

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
       //Dec(i);
       Inc(i);
       if i > 6 then
         exit;
     end;
    // m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i , 0, 0, 1);    
    // m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 1, 0, 1);
    // m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 2, 0, 1);
    // m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 3, 0, 1);
    // m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i + 1, 4, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;
procedure CK2KBytMeter.AddNakEnDayTplGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,oldYear,Month,Day : Word;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
    TempDate := Now;
    while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
    begin
     cDateTimeR.DecMonth(TempDate);
     Decodedate(TempDate,Year,Month,Day);
     //if Year<oldYear  then  exit;
     oldYear := Year;
    end;
    if ((Month+1)=13)then Begin Month:= 0;Year:=Year+1;End;
    m_nObserver.AddGraphParam(QRY_POD_TRYB_HEAT, Month+1, Year, 0, 1);
    cDateTimeR.DecMonth(dt_Date2);
   end;
end;
procedure CK2KBytMeter.AddNakEnMonthTplGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,oldYear,Month,Day : Word;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
    TempDate := Now;
    while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
    begin
     cDateTimeR.DecMonth(TempDate);
     Decodedate(TempDate,Year,Month,Day);
     //if Year<oldYear  then  exit;
     oldYear := Year;
    end;
    if ((Month+1)=13)then Begin Month:= 0;Year:=Year+1;End;
    m_nObserver.AddGraphParam(QRY_NACKM_POD_TRYB_HEAT, Month+1, Year, 0, 1);
    cDateTimeR.DecMonth(dt_Date2);
   end;
end;
procedure CK2KBytMeter.AddNakEnMonthGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,oldYear,Month,Day : Word;
begin
   while (dt_Date1 <= dt_Date2) and (dt_Date1 <= Now) do
   begin
     DecodeDate(dt_Date1, Year, Month, Day);
     if ((Month+1)=13)then Begin Month:= 0;Year:=Year+1;End;
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Month='+IntToStr(Month));
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month, Year, 0, 1);
     cDateTimeR.IncMonth(dt_Date1);
   end;
//   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then dt_Date2 := Now;
//   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
//   begin
//    TempDate := Now;
//    i        := 0;
//    while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
//    begin
//     cDateTimeR.DecMonth(TempDate);
//     Decodedate(TempDate,Year,Month,Day);
//     Inc(i);
//      if i > 12 then
//         exit;
//     //if Year<oldYear  then  exit;
//     oldYear := Year;
//    end;
//    if ((Month+1)=13)then Begin Month:= 0;Year:=Year+1;End;
//    m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month+1, Year, 0, 1);
//    cDateTimeR.DecMonth(dt_Date2);
//   end;
end;
procedure CK2KBytMeter.SetGraphQry;
begin
end;
function CK2KBytMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;
procedure CK2KBytMeter.WriteDate(var pMsg : CMessage; param : word);
var i, temp          : shortint;
    Year, Month, Day : word;
    TempDate         : TDateTime;
    sm               : shortint;
begin
    move(m_nTxMsg.m_sbyInfo[3], temp, 1);
    TempDate := Now;
    case param of
      QRY_NAK_EN_MONTH_EP, QRY_ENERGY_MON_EP:
      begin
        if param = QRY_ENERGY_MON_EP then
          cDateTimeR.IncMonth(TempDate);
        for i := temp to -1 do
          cDateTimeR.DecMonth(TempDate);
        DecodeDate(TempDate, Year, Month, Day);
        m_nRxMsg.m_sbyInfo[2] := Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := Month;
        m_nRxMsg.m_sbyInfo[4] := 1;
        m_nRxMsg.m_sbyInfo[5] := 00;
        m_nRxMsg.m_sbyInfo[6] := 00;
        m_nRxMsg.m_sbyInfo[7] := 00;
      end;
      QRY_ENERGY_DAY_EP, QRY_NAK_EN_DAY_EP:
      begin
        if param = QRY_ENERGY_DAY_EP then
          cDateTimeR.IncDate(TempDate);
        for i := temp to -1 do
          cDateTimeR.DecDate(TempDate);
        DecodeDate(TempDate, Year, Month, Day);
        m_nRxMsg.m_sbyInfo[2] := Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := Month;
        m_nRxMsg.m_sbyInfo[4] := Day;
        m_nRxMsg.m_sbyInfo[5] := 00;
        m_nRxMsg.m_sbyInfo[6] := 00;
        m_nRxMsg.m_sbyInfo[7] := 00;
      end;
    end;
end;

function CK2KBytMeter.GetValue(var pMsg:CMessage;i:integer):Double;
Begin
    try
     Result := 0;
     if (pMsg.m_sbyInfo[12+i+0]=$ff)and(pMsg.m_sbyInfo[12+i+1]=$ff)and(pMsg.m_sbyInfo[12+i+2]=$ff)and
        (pMsg.m_sbyInfo[12+i+3]=$ff)and(pMsg.m_sbyInfo[12+i+4]=$ff)and(pMsg.m_sbyInfo[12+i+5]=$ff)then exit;

     Result := (m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff)*PutBCDToInt(@pMsg.m_sbyInfo[12+6*i],6)/100;
     if Result<=0.0000001 then   Result := 0;
    except
     Result := 0;
    end;
End;

function CK2KBytMeter.GetValueOnState(var pMsg:CMessage;i:integer;var state:boolean):Double;
Begin
    try
     state:=true;
     Result := 0;
     if (pMsg.m_sbyInfo[12+i+0]=$ff)and(pMsg.m_sbyInfo[12+i+1]=$ff)and(pMsg.m_sbyInfo[12+i+2]=$ff)and
        (pMsg.m_sbyInfo[12+i+3]=$ff)and(pMsg.m_sbyInfo[12+i+4]=$ff)and(pMsg.m_sbyInfo[12+i+5]=$ff)then exit;

     Result := (m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff)*PutBCDToInt(@pMsg.m_sbyInfo[12+6*i],6)/100;
     if (i>1) and (Result<=0.0000001) then
     begin
     state:=true;
     Result := 0;
     exit;
     end;
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

function CK2KBytMeter.GetValueDT(var pMsg:CMessage;i:integer):Double;
Var
    dbVal : Double;
Begin
    try
     Result := 0;
     move(pMsg.m_sbyInfo[12+8*i],dbVal,sizeof(double));
     Result := (m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff)*dbVal;
    except
     Result := 0;
    end;
End;
function CK2KBytMeter.GetDateTm(var pMsg:CMessage;i:integer):TDateTime;
Var
    dbVal : Double;
    Year,Month,Day,Hour,Min,Sec:Word;
    dtDate : TDateTime;
Begin
    try
     Result := Now;
     move(pMsg.m_sbyInfo[12+8*5],Year,sizeof(Word));
     Month := pMsg.m_sbyInfo[12+8*5+2];
     Day   := pMsg.m_sbyInfo[12+8*5+3];
     Hour  := pMsg.m_sbyInfo[12+8*5+4];
     Min   := pMsg.m_sbyInfo[12+8*5+5];
     Sec   := pMsg.m_sbyInfo[12+8*5+6];
     if (Year=0)or(Month=0)or(Day=0)or
        (Month>12)or(Day>31)or(Hour>23)or(Min>59)or(Sec>59) then
     dtDate := Now else
     dtDate := EncodeDate(Year,Month,Day)+EncodeTime(Hour,Min,Sec,0);
     if (dtDate>Now)and(abs(dtDate-Now)>5) then
      dtDate:=Now;
     Result := dtDate;
    except
     Result := Now;
    end;
End;
function CK2KBytMeter.SendToL3(nType,SLID,nTar:Integer;dbValue:Double;dtTime:TDateTime) : boolean;
Var Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
begin
    Result := false;
    DecodeDate(dtTime, Year, Month, Day);
    DecodeTime(dtTime, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nRxMsg.m_sbyType    := DL_DATARD_IND;
    m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
    m_nRxMsg.m_sbyDirID   := IsUpdate;
    m_nRxMsg.m_sbyServerID:= SLID;
    m_nRxMsg.m_swObjID    := m_nP.m_swMID;
    m_nRxMsg.m_sbyInfo[0] := 9+8;
    m_nRxMsg.m_sbyInfo[1] := nType;
    m_nRxMsg.m_sbyInfo[2] := Year;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;
    m_nRxMsg.m_sbyInfo[8] := nTar;
    Move(dbValue,m_nRxMsg.m_sbyInfo[9],sizeof(dbValue));
    m_nRxMsg.m_swLen      := 13+m_nRxMsg.m_sbyInfo[0];
    saveToDB(m_nRxMsg);
//Test    saveToDBByt(m_nRxMsg);
end;
{
>$0E $00 $00 $00 $00 $00 $FF $01 $01 $0C $F0 $01 $84 $27 
 *** Данные на начало месяца 0 ***
Квартира №1
   Тарифная зона 1: 1.6666667E10
   Тарифная зона 2: 1.6666667E10
   Тарифная зона 3: 1.6666667E10
   Тарифная зона 4: 1.6666667E10
$26 $31 $00 $00 $00 $00 $00 $01 $02 $0C $F0 $01 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $3C $26
if(CRC16(InBuf,InBufCount)<>0) then begin
         //ComPort.GetByte;
         exit;
     end;
$0C: begin
        if InBuf[8] = 02
          then begin
            StatusBar1.Panels[0].Text := 'Данные за месяц:: успешно';
            Memo1.Lines.Add(#13#10' *** Данные на начало месяца ' + IntToStr($0F and InBuf[10]) + ' ***'#13#10);

            b := 12;
            for i := 0 to InBuf[11] - 1 do begin
              Memo1.Lines.Add('Квартира №' + IntToStr(InBuf[7] + i));
              if $F0 and InBuf[10] = 0
                then begin
                  Memo1.Lines.Add('   Суммарная энергия: ' + FloatToStrF(PutBCDToInt(@InBuf[b], 6)/100, ffFixed, 8, 2));
                  b := b + 6;
                  end
                else for j := 0 to 3 do
                  if InBuf[10] and (1 shl (4 + j)) > 0 then begin
                    Memo1.Lines.Add('   Тарифная зона ' + IntToStr(1 + j) + ': ' + FloatToStrF(PutBCDToInt(@InBuf[b], 6)/100, ffFixed, 8, 2));
                    b := b + 6;
                    end;
              end;
            end
          else StatusBar1.Panels[0].Text := 'Данные за месяц:: ошибка';


        end;
m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $0c;
    m_nTxMsg.m_sbyInfo[10]:= $f0;          //по 4 тарифам
}
procedure CK2KBytMeter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    wPrecize     : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param    := pDS.m_swData1;
    wPrecize := pDS.m_swData2;
    case param of
     QRY_POD_TRYB_HEAT : AddNakEnDayTplGrpahQry(Date1, Date2);
     QRY_NACKM_POD_TRYB_HEAT : AddNakEnMonthTplGrpahQry(Date1, Date2);
     QRY_NAK_EN_DAY_EP   : AddNakEnDayGrpahQry(Date1, Date2);
     QRY_NAK_EN_MONTH_EP : AddNakEnMonthGrpahQry(Date1, Date2);
     QRY_ENERGY_MON_EP   : AddNakEnMonthGrpahQry(Date1, Date2);
    end;
end;
//
function CK2KBytMeter.AUTORIZATION_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
{
procedure TForm1.btnMonthArchesClick(Sender: TObject);
var
  i: Integer;
begin
  OutBuff[0] := $0E;                        // Full length
  OutBuff[6] := $FF;
  OutBuff[7] := EdFlatNum.Value;
  OutBuff[8] := $01;                        // COM                   
  OutBuff[9] := $0C;                        // TAB
  OutBuff[10] :=  cbMonth.ItemIndex;

  if rgDataType.ItemIndex = 1 then
    for i := 0 to 3 do
      OutBuff[10] := OutBuff[10] + Ord(clbTariffs.State[i] = cbChecked) shl (i + 4);
  OutBuff[11] := seCountFlats.Value;
  SendBuffer;
  LastCMD.TAB := $0C;
  StatusBar1.Panels[0].Text := 'Данные за месяц: запрос отправлен...';
end;
//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $77 $01 $2F $2B  //Энергия по 3 тарифам за июль по одной квартире
//$20 $31 $00 $00 $00 $00 $00 $04 $02 $0C $77 $01 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $57 $27

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $F7 $03 $CF $2A //Энергия по 4 тарифам за июль по 3 квартирам
//$56 $31 $00 $00 $00 $00 $00 $04 $02 $0C $F7 $03 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $BB $27

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $00 $01 $08 $DB  Текущие показания по 4 кв
//$14 $31 $00 $00 $00 $00 $00 $04 $02 $0C $00 $01 $FF $FF $FF $FF $FF $FF $F0 $DE

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $00 $02 $48 $DA Текущие показания по 4 кв две
//$1A $31 $00 $00 $00 $00 $00 $04 $02 $0C $00 $02 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $94 $FA

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $F0 $01 $4C $DB Текущие показания энергия по тарифам по 4 квартире
//$26 $31 $00 $00 $00 $00 $00 $04 $02 $0C $F0 $01 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FC $20

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $F0 $02 $0C $DA Текущие показания энергия по тарифам по 4 квартире две
//$3E $31 $00 $00 $00 $00 $00 $04 $02 $0C $F0 $02 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $53 $45

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $00 $01 $08 $DB суммарная энергия текущие показания по 4 кв
//$14 $31 $00 $00 $00 $00 $00 $04 $02 $0C $00 $01 $FF $FF $FF $FF $FF $FF $F0 $DE

//>$0E $01 $00 $00 $00 $00 $FF $04 $01 $0C $00 $02 $48 $DA суммарная энергия текущие показания по 4 кв две
//$1A $31 $00 $00 $00 $00 $00 $04 $02 $0C $00 $02 $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $FF $94 $FA

procedure TForm1.SendBuffer;
var
  CS: word;
  s: string;
  i: Integer;
begin
  CS := CRC16(OutBuff, OutBuff[0] - 2);
  OutBuff[OutBuff[0] - 2] := lo(CS);
  OutBuff[OutBuff[0] - 1] := hi(CS);

  s := '';
  for i := 0 to OutBuff[0] - 1 do
    s := s + '$' + IntToHex(OutBuff[i], 2) + ' ';
  Memo1.Lines.Add('>' + s);
  InBufCount := 0;
  ComPort.SendArray(OutBuff, OutBuff[0]);
end;
}
function CK2KBytMeter.ENERGY_SUM_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    //>$0E $00 $00 $00 $00 $00 $FF $01 $01 $0C $F0 $01 $84 $27
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $0e;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := StrToInt(m_nP.m_sddPHAddres); //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $0c;
    if pReq.m_swSpecc2=1 then m_nTxMsg.m_sbyInfo[9] := $0e;
    m_nTxMsg.m_sbyInfo[10]:= $f0;          //по 4 тарифам
    m_nTxMsg.m_sbyInfo[11]:= $01;          //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);    
    Result := True;
End;
function CK2KBytMeter.POD_TRYB_HEAT(pReq:CQueryPrimitive):Boolean;
Begin
    //>$0E $00 $00 $00 $00 $00 $FF $01 $01 $0C $F0 $01 $84 $27
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $0e;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := StrToInt(m_nP.m_sddPHAddres); //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $0d;
    m_nTxMsg.m_sbyInfo[10]:= $f0;          //по 4 тарифам
    m_nTxMsg.m_sbyInfo[11]:= $01;          //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);
    Result := True;
End;
function CK2KBytMeter.NAK_MON_TPL_REQ(pReq:CQueryPrimitive):Boolean;
Var
    dtDate : TDateTime;
    Year,Month,Day:Word;
Begin
    if pReq.m_swSpecc0=-1 then
    Begin
     //dtDate := Now;
     //cDateTimeR.DecMonth(dtDate);
     DecodeDate(Now,Year,Month,Day);
     pReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Year;
    End;
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $0e;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := StrToInt(m_nP.m_sddPHAddres); //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $0d;
    m_nTxMsg.m_sbyInfo[10]:= $f0+pReq.m_swSpecc0;          //по 4 тарифам
    m_nTxMsg.m_sbyInfo[11]:= $01;          //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);    
    Result := True;
End;
function CK2KBytMeter.ENERGY_DAY_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
function CK2KBytMeter.ENERGY_MON_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
function CK2KBytMeter.SRES_ENR_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    Result := False;
End;
function CK2KBytMeter.NAK_EN_DAY_REQ(pReq:CQueryPrimitive):Boolean;
//Var
//    dtDate : TDateTime;
//    Year,Month,Day:Word;
Begin
    {if pReq.m_swSpecc0=-1 then
    Begin
     //dtDate := Now;
     //cDateTimeR.DecMonth(dtDate);
     DecodeDate(Now,Year,Month,Day);
     pReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Year;
    End;  }
    //dtDate:= Trunc(now) - Trunc(mdtBegin.DateTime);

    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $0e;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := StrToInt(m_nP.m_sddPHAddres); //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $0B; //начало lyz
    m_nTxMsg.m_sbyInfo[10]:= $f0+pReq.m_swSpecc0;          //по 4 тарифам   + смещение дня
    m_nTxMsg.m_sbyInfo[11]:= $01;          //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);
    Result := True;
End;
function CK2KBytMeter.NAK_EN_MONTH_REQ(pReq:CQueryPrimitive):Boolean;
Var
    dtDate : TDateTime;
    Year,Month,Day:Word;
Begin
    if pReq.m_swSpecc0=-1 then
    Begin
     //dtDate := Now;
     //cDateTimeR.DecMonth(dtDate);
     DecodeDate(Now,Year,Month,Day);
     pReq.m_swSpecc0 := Month;
     nReq.m_swSpecc1 := Year;
    End;
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $0e;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := StrToInt(m_nP.m_sddPHAddres); //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $0c; //начало месяца
    m_nTxMsg.m_sbyInfo[10]:= $f0+pReq.m_swSpecc0;          //по 4 тарифам
    m_nTxMsg.m_sbyInfo[11]:= $01;          //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);
    Result := True;
End;

function CK2KBytMeter.DATA_TIME_REQ(pReq:CQueryPrimitive):Boolean;
Begin
    FillChar(m_nTxMsg.m_sbyInfo,50,0);
    m_nTxMsg.m_sbyInfo[0] := $0e;
    m_nTxMsg.m_sbyInfo[6] := $ff;
    m_nTxMsg.m_sbyInfo[7] := 0; //номер квартиры
    m_nTxMsg.m_sbyInfo[8] := $01;
    m_nTxMsg.m_sbyInfo[9] := $ff;//Запросить время
    m_nTxMsg.m_sbyInfo[10]:= 0;          //по 4 тарифам
    m_nTxMsg.m_sbyInfo[11]:= 0;          //к-во квартир одна
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);
    Result := True;
End;
{
memcpy(&d.year, &MasterBuf[10], 2);
                            d.month  = MasterBuf[12];
                            d.day    = MasterBuf[13];
                            t.hour   = MasterBuf[14];
                            t.minute = MasterBuf[15];
                            t.second = MasterBuf[16];
}
function CK2KBytMeter.DATA_TIME_CORR_REQ(pReq:CQueryPrimitive):Boolean;
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
    m_nTxMsg.m_swLen      := 13 + m_nTxMsg.m_sbyInfo[0];
    AddCRC(m_nTxMsg);
    SendToL1(BOX_L1 ,@m_nTxMsg);    //SendL1;
    Result := True;
End;
function CK2KBytMeter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res          : Boolean;
    tempP        : ShortInt;
Begin
    res := False;
    try
    m_nRxMsg.m_sbyServerID := 0;
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       //IsUpdate := false;
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
       if nReq.m_swParamID=QM_ENT_MTR_IND   then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND   then Begin OnFinalAction;exit;End;
       case nReq.m_swParamID of
            QRY_AUTORIZATION    : res := AUTORIZATION_REQ(nReq);
            QRY_ENERGY_SUM_EP   : res := ENERGY_SUM_REQ(nReq);
            QRY_ENERGY_DAY_EP   : res := ENERGY_DAY_REQ(nReq);
            QRY_ENERGY_MON_EP   : res := ENERGY_MON_REQ(nReq);
            QRY_SRES_ENR_EP     : res := SRES_ENR_REQ(nReq);
            QRY_NAK_EN_DAY_EP   : res := NAK_EN_DAY_REQ(nReq);
            QRY_NAK_EN_MONTH_EP : res := NAK_EN_MONTH_REQ(nReq);
            QRY_DATA_TIME       : res := CreateDateTimeReq(nReq);//DATA_TIME_REQ(nReq);
            QRY_POD_TRYB_HEAT   : res := POD_TRYB_HEAT(nReq);
            QRY_NACKM_POD_TRYB_HEAT : res := NAK_MON_TPL_REQ(nReq);
       else
            exit;
       End;
      End;
      QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
    except
    
    end
End;
{
  if InBuf[10] and (1 shl (4 + j)) > 0 then
  begin
   Memo1.Lines.Add('   Тарифная зона ' + IntToStr(1 + j) + ': ' + FloatToStrF(PutBCDToInt(@InBuf[b], 6)/100, ffFixed, 8, 2));                    b := b + 6;
  end;
}
function CK2KBytMeter.ENERGY_SUM_RES(var pMsg:CMessage):Boolean;
Var
    i : Integer;
    dbValue,dbSumValue : double;
Begin                                                                           
    //TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  ENERGY_DAY_RES:',@pMsg);
    //Сумма тарифов
    dbSumValue := 0;
   if (pMsg.m_sbyInfo[12]=$FF) and (pMsg.m_sbyInfo[13]=$FF) and (pMsg.m_sbyInfo[14]=$FF) and(pMsg.m_sbyInfo[15]=$FF) then
    begin
    Result := True;
    m_nT.B1 :=false;
    exit;
    end
    else
     begin
      m_nT.B1 :=true;
      for i:=0 to 3 do dbSumValue := dbSumValue + GetValue(pMsg,i);
      SendToL3(QRY_ENERGY_SUM_EP,0,0,dbSumValue,Now);
     //Тарифы
      for i:=0 to 3 do SendToL3(QRY_ENERGY_SUM_EP,0,i+1,GetValue(pMsg,i),Now); //AAV 26062012
      Result := True;
     end;

End;
function CK2KBytMeter.ENERGY_SUM_RES_DT(var pMsg:CMessage):Boolean;
Var
    i : Integer;
    dbValue,dbSumValue : double;
    dtDate : TDateTime;
Begin
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  ENERGY_DAY_RES_DT:',@pMsg);
    //Сумма тарифов
    dbSumValue := 0;
    dtDate := GetDateTm(pMsg,0);
    for i:=1 to 4 do dbSumValue := dbSumValue + GetValueDT(pMsg,i);
    SendToL3(QRY_ENERGY_SUM_EP,0,0,dbSumValue,dtDate);
    //Тарифы
    for i:=1 to 4 do SendToL3(QRY_ENERGY_SUM_EP,0,i+0,GetValueDT(pMsg,i),dtDate); //AAV 26062012
    Result := True;
End;
{
c += PutIntToBCD((DWORD) (d.year), &MasterBuf[9 + c], 2);
c += PutIntToBCD((DWORD) (d.month), &MasterBuf[9 + c], 1);
c += PutIntToBCD((DWORD) (d.day), &MasterBuf[9 + c], 1);
c += PutIntToBCD((DWORD) (t.hour), &MasterBuf[9 + c], 1);
c += PutIntToBCD((DWORD) (t.minute), &MasterBuf[9 + c], 1);
c += PutIntToBCD((DWORD) (t.second), &MasterBuf[9 + c], 1);
}
function CK2KBytMeter.DATA_TIME_RES(var pMsg:CMessage):Boolean;
Var
    Year,Month,Day,Hour,Min,Sec,ms:Word;
    Year0,Month0,Day0,Hour0,Min0,Sec0:Word;
    ReadDate : TDateTime;
Begin
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, ms);
    Year0  := PutBCDToInt(@pMsg.m_sbyInfo[9],2);
    Month0 := PutBCDToInt(@pMsg.m_sbyInfo[11],1);
    Day0   := PutBCDToInt(@pMsg.m_sbyInfo[12],1);
    Hour0  := PutBCDToInt(@pMsg.m_sbyInfo[13],1);
    Min0   := PutBCDToInt(@pMsg.m_sbyInfo[14],1);
    Sec0   := PutBCDToInt(@pMsg.m_sbyInfo[15],1);
    ReadDate:=EncodeDate(Year0,Month0,Day0) + EncodeTime(Hour0,Min0,Sec0,0);

    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Разница по времени состовляет -> '+TimeToStr(abs(EncodeTime(Hour0,Min0,Sec0,0)-EncodeTime(Hour,Min,Sec,0))));
    if ((Year0 <> Year) or (Month0 <> Month) or(Day0 <> Day) or (Hour0 <> Hour) or (Min0 <> Min) or ((abs(Sec0 - Sec) > 5))) then
    Begin
       mTimeDir := ST_164_CORR_TIME;
       m_nObserver.AddGraphParam(QRY_DATA_TIME, 0,0,0,1);  //заносим в спеки параметры для определения типа запроса(на разъем или на счетчики)
       Result := true;
    end
    else
      begin
         mTimeDir := ST_164_READ_TIME; //потом убрать
         m_nObserver.ClearGraphQry;//Очищаем буфер команд
         Result := true;
       end;
    // if (m_nCF.cbm_sCorrDir.ItemIndex = 1) then DATA_TIME_CORR_REQ(nReq)
     // else
     //if (m_nCF.cbm_sCorrDir.ItemIndex = 0) then FNCCorTime(pMsg);
End;


function CK2KBytMeter.CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean;
begin
   case mTimeDir of
     ST_164_READ_TIME : DATA_TIME_REQ(nReq);
     ST_164_CORR_TIME : DATA_TIME_CORR_REQ(nReq);
   end;
end;

function CK2KBytMeter.ReadDateTimeAns(var pMsg: CMessage): Boolean;
begin
   Result := true;
   case mTimeDir of
     ST_164_READ_TIME : Result:=DATA_TIME_RES(pMsg);
     ST_164_CORR_TIME :
       begin
         Result:=DATA_TIME_SET_RES(pMsg);
         mTimeDir := ST_164_READ_TIME;
       end;
   else  mTimeDir := ST_164_READ_TIME;
   end;
end;


function CK2KBytMeter.DATA_TIME_SET_RES(var pMsg:CMessage):Boolean;
Var
    Year,Month,Day,Hour,Min,Sec:Word;
    ReadDate : TDateTime;
Begin
    //Year  := PutBCDToInt(@pMsg.m_sbyInfo[9],2);
    move(pMsg.m_sbyInfo[10],Year,2);
    Month := pMsg.m_sbyInfo[12];
    Day   := pMsg.m_sbyInfo[13];
    Hour  := pMsg.m_sbyInfo[14];
    Min   := pMsg.m_sbyInfo[15];
    Sec   := pMsg.m_sbyInfo[16];
    ReadDate:=EncodeDate(Year,Month,Day) + EncodeTime(Hour,Min,Sec,0);
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Разница по времени после корректировки состовляет -> '+TimeToStr(abs(ReadDate - Now)));
    Result:=True;
End;
function CK2KBytMeter.CURR_TPL_RES(var pMsg:CMessage):Boolean;
Var
    fD : FTMET;
    Year,Month,Day : Word;
    dt_Date : TDateTime;
    dP : Double;
Begin
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  CURR_TPL_RES:',@pMsg);
    move(pMsg.m_sbyInfo[12],fD,sizeof(fD));

    DecodeDate(Now,Year,Month,Day);
    dt_Date := EncodeDate(Year,Month,Day)+EncodeTime(0,0,0,0);
    dP := fD.Qp;IsTrueValue(dP);SendToL3(QRY_POD_TRYB_HEAT,0,0,dP,dt_Date);
    dP := fD.Qo;IsTrueValue(dP);SendToL3(QRY_OBR_TRYB_HEAT,0,0,dP,dt_Date);
    dP := fD.Mp;IsTrueValue(dP);SendToL3(QRY_POD_TRYB_RASX,0,0,dP,dt_Date);
    dP := fD.Mo;IsTrueValue(dP);SendToL3(QRY_OBR_TRYB_RASX,0,0,dP,dt_Date);
    dP := fD.Tp;IsTrueValue(dP);SendToL3(QRY_POD_TRYB_TEMP,0,0,dP,dt_Date);
    dP := fD.Tob;IsTrueValue(dP);SendToL3(QRY_OBR_TRYB_TEMP,0,0,dP,dt_Date);
    dP := fD.Vp;IsTrueValue(dP);SendToL3(QRY_POD_TRYB_V,0,0,dP,dt_Date);
    dP := fD.Vo;IsTrueValue(dP);SendToL3(QRY_OBR_TRYB_V,0,0,dP,dt_Date);
    dP := 0;    IsTrueValue(dP);SendToL3(QRY_TEMP_COLD_WAT_DAY,0,0,dP,dt_Date);
    dP := fD.Time;IsTrueValue(dP);SendToL3(QRY_POD_TRYB_RUN_TIME,0,0,dP,dt_Date);
    dP := fD.TimeErr;IsTrueValue(dP);SendToL3(QRY_WORK_TIME_ERR,0,0,dP,dt_Date);
    Result := True;
End;
function CK2KBytMeter.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;
function CK2KBytMeter.NAK_MON_TPL_RES(var pMsg:CMessage):Boolean;
Var
    fD : FTMET;
    dt_Date : TdateTime;
    dP : Double;
Begin
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  NAK_MON_TPL_RES:',@pMsg);
    //Сумма тарифов
    move(pMsg.m_sbyInfo[12],fD,sizeof(fD));
    dt_Date := GetDateWIntex(pMsg.m_sbyInfo[10] and $0f);
    dP := fD.Qp;IsTrueValue(dP);SendToL3(QRY_NACKM_POD_TRYB_HEAT,0,0,dP,dt_Date);
    dP := fD.Qo;IsTrueValue(dP);SendToL3(QRY_NACKM_OBR_TRYB_HEAT,0,0,dP,dt_Date);
    dP := fD.Mp;IsTrueValue(dP);SendToL3(QRY_NACKM_POD_TRYB_RASX,0,0,dP,dt_Date);
    dP := fD.Mo;IsTrueValue(dP);SendToL3(QRY_NACKM_OBR_TRYB_RASX,0,0,dP,dt_Date);
    dP := fD.Tp;IsTrueValue(dP);SendToL3(QRY_NACKM_POD_TRYB_TEMP,0,0,dP,dt_Date);
    dP := fD.Tob;IsTrueValue(dP);SendToL3(QRY_NACKM_OBR_TRYB_TEMP,0,0,dP,dt_Date);
    dP := fD.Vp;IsTrueValue(dP);SendToL3(QRY_NACKM_POD_TRYB_V,0,0,dP,dt_Date);
    dP := fD.Vo;IsTrueValue(dP);SendToL3(QRY_NACKM_OBR_TRYB_V,0,0,dP,dt_Date);
    dP := 0;    IsTrueValue(dP);SendToL3(QRY_NACKM_TEMP_COLD_WAT_DAY,0,0,dP,dt_Date);
    dP := fD.Time;IsTrueValue(dP);SendToL3(QRY_NACKM_POD_TRYB_RUN_TIME,0,0,dP,dt_Date);
    dP := fD.TimeErr;IsTrueValue(dP);SendToL3(QRY_NACKM_WORK_TIME_ERR,0,0,dP,dt_Date);
    Result := True;
End;

function CK2KBytMeter.GetDateWIntex(nIndex:Integer):TDateTime;
Var
    nYear,Year,Month,oldMonth,Day : Word;
Begin
    DecodeDate(Now,Year,oldMonth,Day);
    Month := nIndex;
    if (nIndex<1) or (nIndex>12) then Month := oldMonth;
    nYear  := nReq.m_swSpecc1;
    Result := EncodeDate(nYear ,Month,1);
End;

function CK2KBytMeter.GetDateWIntexDay(nIndex:Integer):TDateTime;
Var
    nYear,Year,Month,oldMonth,Day : Word;
Begin
    DecodeDate(Now,Year,Month,Day);
    if (nIndex>1) then
    Day := Day - nIndex + 1;
    Result := EncodeDate(Year ,Month,Day);
End;

function CK2KBytMeter.NAK_EN_DAY_RES(var pMsg:CMessage):Boolean;
Var
    i : Integer;
    dbValue,dbSumValue : double;
    dtDate : TdateTime;
    check_state  :boolean;
    dbValueTar  : double;
Begin
   // TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  NAK_EN_MONTH_RES:',@pMsg);
    //Сумма тарифов
    dbSumValue := 0;
    dtDate := GetDateWIntexDay(pMsg.m_sbyInfo[10] and $0f);
    if (pMsg.m_sbyInfo[12]=$FF) and (pMsg.m_sbyInfo[13]=$FF) and (pMsg.m_sbyInfo[14]=$FF) and(pMsg.m_sbyInfo[15]=$FF) then
    begin
    Result := True;
    m_nT.B1 :=false;
    exit;
    end
    else
     begin
      m_nT.B1 :=true;
      for i:=0 to 3 do dbSumValue := dbSumValue + GetValue(pMsg,i);
      SendToL3(QRY_NAK_EN_DAY_EP,0,0,dbSumValue,dtDate);
    //Тарифы

      for i:=0 to 3 do
       SendToL3(QRY_NAK_EN_DAY_EP,0,i+1,GetValue(pMsg,i),dtDate);
      Result := True;
     end;
End;

function CK2KBytMeter.NAK_EN_MONTH_RES(var pMsg:CMessage):Boolean;
Var
    i : Integer;
    dbValue,dbSumValue : double;
    dtDate : TdateTime;
    check_state  :boolean;
    dbValueTar  : double;
Begin
   // TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  NAK_EN_MONTH_RES:',@pMsg);
    //Сумма тарифов
    dbSumValue := 0;
    dtDate := GetDateWIntex(pMsg.m_sbyInfo[10] and $0f);
    if (pMsg.m_sbyInfo[12]=$FF) and (pMsg.m_sbyInfo[13]=$FF) and (pMsg.m_sbyInfo[14]=$FF) and(pMsg.m_sbyInfo[15]=$FF) then
    begin
    Result := True;
    m_nT.B1 :=false;
    exit;
    end
    else
     begin
      m_nT.B1 :=true;
      for i:=0 to 3 do dbSumValue := dbSumValue + GetValue(pMsg,i);
      SendToL3(QRY_NAK_EN_MONTH_EP,0,0,dbSumValue,dtDate);
    //Тарифы

      for i:=0 to 3 do
       SendToL3(QRY_NAK_EN_MONTH_EP,0,i+1,GetValue(pMsg,i),dtDate);
      Result := True;
     end;
End;
function CK2KBytMeter.LoHandler(var pMsg0:CMessage):Boolean;
Var
    res    : Boolean;
    fValue : Single;
    pMsg   : CMessage;
Begin
    res := False;
    move(pMsg0,pMsg,sizeof(CMessage));
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
        //Контроль CRC
        if(CRC(pMsg.m_sbyInfo,pMsg.m_swLen-13)<>0) then
        Begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+'(__)CL2MD::>CK2KB  CRC ERR!!!)');//AAV
         exit;
        End;
        if (pMsg.m_sbyInfo[7]<>StrToInt(m_nP.m_sddPHAddres)) then
        Begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+'(__)CL2MD::>CK2KB  CRC ID!!!)');//AAV
         exit;
        End;
        if pMsg.m_sbyInfo[8]=2 then
        Begin
         //Обработка ответов
         case pMsg.m_sbyInfo[9] of
              $0c: Begin
                    if (pMsg.m_sbyInfo[10] and $0f)=0  then res:=ENERGY_SUM_RES(pMsg) else
                    if (pMsg.m_sbyInfo[10] and $0f)<>0 then res:=NAK_EN_MONTH_RES(pMsg);
                   End;
              $0d: Begin
                    if (pMsg.m_sbyInfo[10] and $0f)=0  then res:=CURR_TPL_RES(pMsg) else
                    if (pMsg.m_sbyInfo[10] and $0f)<>0 then res:=NAK_MON_TPL_RES(pMsg);
                   End;
              $0e: Begin
                    if (pMsg.m_sbyInfo[10] and $0f)=0  then res:=ENERGY_SUM_RES_DT(pMsg) else
                    if (pMsg.m_sbyInfo[10] and $0f)<>0 then res:=NAK_EN_MONTH_RES(pMsg);
                   End;
              $0b: Begin
                    if (pMsg.m_sbyInfo[10] and $0f)=0  then res:=ENERGY_SUM_RES_DT(pMsg) else
                    if (pMsg.m_sbyInfo[10] and $0f)<>0 then res:=NAK_EN_DAY_RES(pMsg);
                   End;				   
              //$fc: Begin res:=DATA_TIME_SET_RES(pMsg);exit;End;
         End;
         case nReq.m_swParamID of
              QRY_DATA_TIME: res:=ReadDateTimeAns(pMsg);//DATA_TIME_RES(pMsg);
         End;
         OnFinalAction;
        End;
        //OnFinalAction;
        //TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KB  L1IN:',@pMsg);
      end;
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    End;
    Result := res;
End;
procedure CK2KBytMeter.OnEnterAction;
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CK2KB OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;
procedure CK2KBytMeter.OnFinalAction;
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CK2KB OnFinalAction');
    FinalAction;
End;
procedure CK2KBytMeter.OnConnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CK2KB OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;
procedure CK2KBytMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CK2KB OnDisconnectComplette');
    m_nModemState := 0;
End;
procedure CK2KBytMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     OnFinalAction;
//     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CK2KBOnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
    End;
end;
procedure CK2KBytMeter.AddCRC(var pMsg:CHMessage);
var
    CS : word;
begin
    //CS := CRC16(OutBuff, OutBuff[0] - 2);
    //OutBuff[OutBuff[0] - 2] := lo(CS);
    //OutBuff[OutBuff[0] - 1] := hi(CS);
    CS := CRC(pMsg.m_sbyInfo,pMsg.m_sbyInfo[0] - 2);
    pMsg.m_sbyInfo[pMsg.m_sbyInfo[0] - 2] := lo(CS);
    pMsg.m_sbyInfo[pMsg.m_sbyInfo[0] - 1] := hi(CS);
end;
Procedure CK2KBytMeter.CRC16b(b: Byte; var CRC:word);
Var
    i : Byte;
    F : Boolean;
begin
    for i := 1 to 8 do Begin
        F := Odd(b xor CRC);
        CRC := CRC shr 1;
        b := b shr 1;
        If F then CRC := CRC xor $A001;
    end;
end;
function CK2KBytMeter.CRC(pack:array of byte; count:integer):word;
var
    i:integer;
    res:word;
begin
    res:=0;
    for i:= 0 to count-1 do CRC16b(pack[i],res);
    result:=res;
end;
function CK2KBytMeter.Byte2BCD(b:byte):byte;
begin
    if (b<100) then  result:= b mod 10+ b div 10 *16;
end;
function CK2KBytMeter.BCD2Byte(b:byte):byte;
var fd,sd:byte;
begin
    fd:= b and $0F;
    sd:= (b and $F0) shr 4;
    if (fd<10) and (sd<10) then  result:= sd *10+fd
    //else begin
    //     raise ERangeError.CreateFmt('0x%.2x is not within the valid range of 0x%.2x..0x%.2x',[b, 0, $99]);
    //end;
end;
function CK2KBytMeter.PutBCDToInt(BCDbuf:PByteArray; cnt:integer):int64;
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
procedure CK2KBytMeter.RunMeter;
Begin
End;
end.
 