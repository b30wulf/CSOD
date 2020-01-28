unit knsl2CE301BYMeter;
{$DEFINE L2_CE301BY_DEBUG}

interface

uses
  Windows, Classes, SysUtils,
  utltypes, utlbox, utlconst, knsl2meter, knsl5config, utlmtimer,
  utlTimeDate,utldatabase,knsl3EventBox;


type
  CCE301BYMeter = class(CMeter)
  private
    //IsUpdate       : BYTE;
    nReq           : CQueryPrimitive;
    mCurrState     : integer;
    dt_TLD         : TDateTime;
    nOldYear       : Word;
    bl_SaveCrEv    : boolean;
    blSetTime      : boolean;
    m_strVer       : String;
    m_Address      : String;
    m_Pass         : String;
  public
    // base
    constructor Create();
    destructor  Destroy; override;
    procedure   InitMeter(var pL2:SL2TAG); override;
    procedure   RunMeter; override;

    // events routing
    function    SelfHandler(var pMsg:CMessage) : Boolean; override;
    function    LoHandler(var pMsg0:CMessage) : Boolean; override;
    function    HiHandler(var pMsg:CMessage) : Boolean; override;

    procedure   OnEnterAction();
    procedure   OnFinalAction();
    procedure   OnConnectComplette(var pMsg:CMessage); override;
    procedure   OnDisconnectComplette(var pMsg:CMessage); override;

    procedure   HandQryRoutine(pMsg:CMessage);
    procedure   HandCtrlRoutine(pMsg:CMessage);
    procedure   OnFinHandQryRoutine(var pMsg:CMessage);

  private
    procedure   AddSresEnGraphQry(dt_Date1, dt_Date2 : TDateTime);
    procedure   AddEnDayGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
    procedure   AddEnMonGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
    procedure   FillMessageHead(var pMsg : CHMessage; length : word);
    function    FindFloatValue(var str : string; pos : integer; len : integer) : string;
    function    GetValueFromBuf(var buf : array of byte; var sm : integer; len : integer; _str : string) : double;
    function    ReadAnswerFromCE301(var pMsg:CMessage):boolean;

    function    IsValidMessage(var pMsg : CMessage) : Byte;
    function    CE301BY_CRCProv(_Packet: array of BYTE; _DataLen:Integer) : byte;

    function    ReadAutorAns(var pMsg:CMessage):boolean;
    function    ReadIndetifAns(var pMsg:CMessage):boolean;
    function    ReadCheckPasswAns(var pMsg:CMessage):boolean;
    function    ReadSumEnAns(var pMsg:CMessage):boolean;
    function    ReadEnDayAns(var pMsg:CMessage):boolean;
    function    ReadEnMonAns(var pMsg:CMessage):boolean;
    function    ReadSresEnAns(var pMsg:CMessage):boolean;
    function    ReadNakEnDayAns(var pMsg:CMessage):boolean;
    function    ReadNakEnMonAns(var pMsg:CMessage):boolean;
    function    ReadDateTime(var pMsg:CMessage):boolean;
    function    KorrTime(LastDate : TDateTime):boolean;
    procedure   RES1D_SetDateTime(var pMsg:CMessage);
    procedure   GetDateTime(var pMsg:CMessage;var _yy,_mm,_dd,_hh,_mn,_ss:Word);
    function    GetVersion(var pMsg:CMessage):String;
    function    ReadAktPowAns(var pMsg:CMessage):boolean;
    function    ReadReaPowAns(var pMsg:CMessage):boolean;
    function    ReadCosFAns(var pMsg:CMessage):boolean;
    function    ReadUAns(var pMsg:CMessage):boolean;
    function    ReadIAns(var pMsg:CMessage):boolean;
    function    ReadFreqAns(var pMsg:CMessage):boolean;
    function    ReadCloseSession(var pMsg:CMessage):boolean;
    procedure   SendMessageToMeter;
    procedure   CreateAutorReq;
    procedure   FillAutorReq;
    procedure   CreateIndetifReq;
    procedure   CreateCheckPasswReq;
    procedure   CreateSumEnReq;
    procedure   CreateDayEnReq;
    procedure   CreateMonEnReq;
    procedure   CreateSresEnReq;
    procedure   CreateNakEnDayReq;
    procedure   CreateNakEnMonReq;
    procedure   CreateDateTime;
    procedure   CreateAktPowReq;
    procedure   CreateReaPowReq;
    procedure   CreateCosFReq;
    procedure   CreateUReq;
    procedure   CreateIReq;
    procedure   CreateFreqReq;
    procedure   CreateDiscReq;
    function    GetDayDateFromSm(sm:integer):TDateTime;
    function    GetMonthDateFromSm(sm:integer):TDateTime;
    procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
    function    GetStringFromFile(FileName : string; nStr : integer) : string;
    procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
    function    IsTrueValue(var dbVal:Double):Boolean;
    procedure   TestMSG(var pMsg:CMessage);
    function    CE301BY_CRC(var str : string) : byte;
    procedure   CalcParity(var buf : array of byte; var nCount : Word);
    procedure   ClearParity(var buf : array of byte; var nCount : Word);
    function    IsEven(byData:Byte):Boolean;
    function    CRC(var buf : array of byte; cnt : byte):boolean;
    End;
const   ST_CE301_AUTORIZATION   = 0;
        ST_CE301_INDETIFICATION = 1;
        ST_CE301_CHECK_PASSWORD = 2;
        ST_CE301_SEND_QUERY     = 3;

implementation

procedure CCE301BYMeter.AddSresEnGraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 2, 0, 0, 1);

   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin  //В цикле считаю количество дней от текущего
       cDateTimeR.DecDate(TempDate);
       Dec(i);
       if i < -31 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, i + 1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CCE301BYMeter.AddEnDayGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 2, 0, 0, 1);

   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin  //В цикле считаю количество дней от текущего
       cDateTimeR.DecDate(TempDate);
       Dec(i);
       if i < -30 then
         exit;
     end;
     m_nObserver.AddGraphParam(l_paramID, i + 1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CCE301BYMeter.AddEnMonGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
m_nObserver.AddGraphParam(QRY_AUTORIZATION, 2, 0, 0, 1);

   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
         exit;
     end;
     m_nObserver.AddGraphParam(l_paramID, i + 1, 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CCE301BYMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CE301BY;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;


procedure CCE301BYMeter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
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
   m_nRxMsg.m_sbyDirID   := IsUpdate;
   m_nRxMsg.m_sbyServerID := 0;
end;


function CCE301BYMeter.GetDayDateFromSm(sm:integer):TDateTime;
var i : integer;
begin
   Result := Now;
   for i := 0 to abs(sm) - 1 do
     Result := Result - 1;
end;

function CCE301BYMeter.GetMonthDateFromSm(sm:integer):TDateTime;
var i       : integer;
    t_date  : TDateTime;
begin
   t_date := Now;
   for i := 0 to abs(sm) - 1 do
     cDateTimeR.DecMonth(t_date);
   Result := t_date;
end;

function CCE301BYMeter.FindFloatValue(var str : string; pos : integer; len : integer) : string;
var i, sO, sZ    : integer;
    chB          : boolean;
    dotNumb      : integer;
    tstr         : string;
begin
   Result := '';
   sO := 0;
   sZ := 0;
   dotNumb := 0;
   chB := true;
   tstr := '';
   for i := 1 to len - 1 do
   case str[i] of
     '(' : sO := i;
     ')' : begin sZ := i; if sO <> 0 then break; end;
   end;
   for i := sO + 1 to sZ - 1 do
   begin
     if (str[i] = '.') then
       dotNumb := dotNumb + 1;
     if ((str[i] < '0') and (str[i] > '9')) and (str[i] <> '.') then
       chB := false;
   end;
   if (chB) and (dotNumb >= 1) then
   begin
     SetLength(tstr, sZ - sO - 1);
     move(str[sO + 1], tstr[1], sZ - sO - 1);
   end;
   Result := tstr;
end;

function CCE301BYMeter.GetValueFromBuf(var buf : array of byte; var sm : integer; len : integer;_str : string) : double;
var i              : integer;
    tstr, tfloat   : string;
    fPos           : integer;
begin
   Result := 0;
   SetLength(tstr, len - sm);
   move(buf[sm], tstr[1], len - sm);
   fPos := pos(_str, tstr);
   sm := sm + fPos + length(_str);
   if fPos > 0 then
   begin
     tfloat := FindFloatValue(tstr, fPos + length(_str), len);
     if length(tfloat) > 0 then
       try
         Result := StrToFloat(tfloat);
       except
         Result := 0;
       end;
   end
   else
     sm := len;
end;

function CCE301BYMeter.ReadAnswerFromCE301(var pMsg:CMessage):boolean;
begin
   Result := false;
   if pMsg.m_swLen <= 13 then
   begin
     Result := false;
     exit;
   end;

   if (IsValidMessage(pMsg)=1)then
   begin
     Result := false;
     exit;
   end;;

  case nReq.m_swParamID of
      QRY_AUTORIZATION   : begin
                            if (nReq.m_swSpecc0=0) then Result :=ReadAutorAns(pMsg);
                            if (nReq.m_swSpecc0=1) then Result :=ReadIndetifAns(pMsg);
                            if (nReq.m_swSpecc0=2) then Result :=ReadCheckPasswAns(pMsg);
                           end;
     QRY_ENERGY_SUM_EP : Result :=ReadSumEnAns(pMsg);       ////ПРОТЕСТИРОВАНО
     QRY_ENERGY_DAY_EP : Result :=ReadEnDayAns(pMsg);       ////ПРОТЕСТИРОВАНО
     QRY_ENERGY_MON_EP : Result :=ReadEnMonAns(pMsg);       ////ПРОТЕСТИРОВАНО
     QRY_SRES_ENR_EP   : Result :=ReadSresEnAns(pMsg);      ////ПРОТЕСТИРОВАНО (Добавить признаки достоверности на каждый получас)
     QRY_NAK_EN_DAY_EP : Result :=ReadNakEnDayAns(pMsg);    ////ПРОТЕСТИРОВАНО
     QRY_NAK_EN_MONTH_EP : Result :=ReadNakEnMonAns(pMsg);  ////ПРОТЕСТИРОВАНО
     QRY_DATA_TIME       : Result :=ReadDateTime(pMsg);
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A, QRY_MGAKT_POW_B, QRY_MGAKT_POW_C : Result :=ReadAktPowAns(pMsg);
     QRY_MGREA_POW_S, QRY_MGREA_POW_A, QRY_MGREA_POW_B, QRY_MGREA_POW_C : Result :=ReadReaPowAns(pMsg);
     QRY_KOEF_POW_A  : Result :=ReadCosFAns(pMsg);
     QRY_U_PARAM_S, QRY_U_PARAM_A, QRY_U_PARAM_B, QRY_U_PARAM_C : Result :=ReadUAns(pMsg);
     QRY_I_PARAM_S, QRY_I_PARAM_A, QRY_I_PARAM_B, QRY_I_PARAM_C : Result :=ReadIAns(pMsg);
     QRY_FREQ_NET : Result :=ReadFreqAns(pMsg);
     QRY_EXIT_COM : Result :=ReadCloseSession(pMsg);
   end;

end;

{*******************************************************************************
 *  Проверка целостности сообщения
 *      @param var pMsg : CMessage Сообщение
 *      @return Boolean 
 ******************************************************************************}
function CCE301BYMeter.IsValidMessage(var pMsg : CMessage) : Byte;
var
    l_DataLen : WORD;
    l_ErrStr : String;
begin
    Result := 0;

    l_DataLen := 13 + (pMsg.m_sbyInfo[6] AND $0F);
    // контрольная сумма

   if (nReq.m_swParamID=QRY_AUTORIZATION)then exit
   else
     if (pMsg.m_sbyInfo[pMsg.m_swLen - 13-2]=$03)then
        Result:=0    // Значит Пакет верен
     else
        Result:=1    // Значит ошибка пакета
end;

function CCE301BYMeter.CE301BY_CRCProv(_Packet: array of BYTE; _DataLen:Integer) : byte;
var
l_CRC : BYTE;
i : integer;
begin
   l_CRC:=0;
   Result := 0;
  { for i := 2 to length(str) do
   Result := (Result + Byte(str[i])) mod $80;}
end;

{
var
  l_CRC : BYTE;
  i     : integer;
begin
  l_CRC := 0;
  for i:=1 to _DataLen-3 do
    l_CRC := CE102BY_crc8tab[l_CRC xor _Packet[i]];

  Result := l_CRC;
end;
}

function CCE301BYMeter.ReadAutorAns(var pMsg:CMessage):boolean;
begin
   if (pMsg.m_sbyInfo[0] = $15) then
   Begin
     Result := true;
   End
   else
   begin
     m_strVer := GetVersion(pMsg);
     if pos('GRAPE',m_strVer)<>0 then m_strVer:='10';
     mCurrState := ST_CE301_INDETIFICATION;
     Result := true;  //надо true
   end;
end;

function CCE301BYMeter.ReadIndetifAns(var pMsg:CMessage):boolean;
begin
   if (pMsg.m_sbyInfo[0] = $15) then
   Begin
     Result := true;
   End
   else
   begin
     mCurrState := ST_CE301_CHECK_PASSWORD;
    // mCurrState := ST_CE301_SEND_QUERY;
     Result := true; //true ЕСЛИ ОК
   end;
end;

function CCE301BYMeter.ReadCheckPasswAns(var pMsg:CMessage):boolean;
begin
   if (pMsg.m_sbyInfo[0] = $15) then
   Begin
     Result := true;
   End
   else
   begin
     mCurrState := ST_CE301_SEND_QUERY;
     Result := true;  //true ЕСЛИ ОК
   end;
end;


function CCE301BYMeter.ReadSumEnAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    tar   : integer;
begin
   sm  := 1;
   tar := 0;
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'ET0PE')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     CreateOutMSG(fVal, QRY_ENERGY_SUM_EP, tar, Now);
     if tar <= 4 then
       saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     tar := tar + 1;
     Result:=true;
   end;
end;

function CCE301BYMeter.ReadEnDayAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    tar   : integer;
begin
   sm  := 1;
   tar := 0;
   if (pMsg.m_sbyInfo[0]=$02)and (pMsg.m_sbyInfo[1]=$03) and (pMsg.m_sbyInfo[2]=$03) then
    begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.M_SWABOID)+'/'+m_nP.m_sddPHAddres+') Отсутствуют данные за сутки!!!');
      Result:=true;
    end
    else
   while sm < pMsg.m_swLen - 1 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 1, 'EADPE')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     CreateOutMSG(fVal, QRY_ENERGY_DAY_EP, tar, trunc(GetDayDateFromSm(nReq.m_swSpecc0)));
     if tar <= 4 then
      saveToDB(m_nRxMsg);
     tar := tar + 1;
     Result:=true;
   end;
end;

function CCE301BYMeter.ReadEnMonAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    tar   : integer;
    dt_Date : TDateTime;
    Year, Month, Day : word;
begin
   sm  := 1;
   tar := 0;
   if (pMsg.m_sbyInfo[0]=$02)and (pMsg.m_sbyInfo[1]=$03) and (pMsg.m_sbyInfo[2]=$03) then
    begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.M_SWABOID)+'/'+m_nP.m_sddPHAddres+') Отсутствуют данные за месяц!!!');
      Result:=true;
    end
    else
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'EAMPE')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     dt_Date:= GetMonthDateFromSm(nReq.m_swSpecc0);
     DecodeDate(dt_Date,Year, Month, Day);
     dt_Date := EncodeDate(Year, Month, 1);
     CreateOutMSG(fVal, QRY_ENERGY_MON_EP, tar, trunc(dt_Date));
     if tar <= 4 then
       saveToDB(m_nRxMsg);
     tar := tar + 1;
     Result:=true;
   end;
end;

function CCE301BYMeter.ReadSresEnAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    sID   : integer;
begin
   sm  := 1;
   sID := 0;
   if (pMsg.m_sbyInfo[0]=$02)and (pMsg.m_sbyInfo[1]=$03) and (pMsg.m_sbyInfo[2]=$03) then
    begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.M_SWABOID)+'/'+m_nP.m_sddPHAddres+') Отсутствуют данные 30 минутные срезы!!!');
      Result:=true;
    end
    else
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := (GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'GRAPE') / 2)*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     CreateOutMSG(fVal, QRY_SRES_ENR_EP, 0, trunc(GetDayDateFromSm(nReq.m_swSpecc0)) + sID*EncodeTime(0, 30, 0, 0));
     m_nRxMsg.m_sbyDirID    := 1;
     m_nRxMsg.m_sbyServerID := sID;
     if (Now > trunc(GetDayDateFromSm(nReq.m_swSpecc0)) + (sID+1)*EncodeTime(0, 30, 0, 0)) then

     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     sID := sID + 1;
     Result:=true;
   end;
  // FinalAction;
end;

function CCE301BYMeter.ReadNakEnDayAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    tar   : integer;
begin
   sm  := 1;
   tar := 0;
   if (pMsg.m_sbyInfo[0]=$02)and (pMsg.m_sbyInfo[1]=$03) and (pMsg.m_sbyInfo[2]=$03) then
    begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.M_SWABOID)+'/'+m_nP.m_sddPHAddres+') Отсутствуют данные на конец суток!!!');
      Result:=true;
    end
    else
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'ENDPE')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     CreateOutMSG(fVal, QRY_NAK_EN_DAY_EP, tar, trunc(GetDayDateFromSm(nReq.m_swSpecc0)));
     if tar <= 4 then
       saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     tar := tar + 1;
     Result:=true;
   end;
end;

function CCE301BYMeter.ReadNakEnMonAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    tar   : integer;
    dt_Date : TDateTime;
    Year, Month, Day : word;
begin
   sm  := 1;
   tar := 0;
   if (pMsg.m_sbyInfo[0]=$02)and (pMsg.m_sbyInfo[1]=$03) and (pMsg.m_sbyInfo[2]=$03) then
    begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.M_SWABOID)+'/'+m_nP.m_sddPHAddres+') Отсутствуют данные на конец месяца!!!');
      Result:=true;
    end
    else
   
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'ENMPE')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     dt_Date:= GetMonthDateFromSm(nReq.m_swSpecc0);
     DecodeDate(dt_Date,Year, Month, Day);
     dt_Date := EncodeDate(Year, Month, 1);
     CreateOutMSG(fVal, QRY_NAK_EN_MONTH_EP, tar, trunc(dt_Date));
     //CreateOutMSG(fVal, QRY_NAK_EN_MONTH_EP, tar, trunc(GetMonthDateFromSm(nReq.m_swSpecc0)));
     if tar <= 4 then
      saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);
     tar := tar + 1;
     Result:=true;
   end;
  // FinalAction;
end;
procedure CCE301BYMeter.GetDateTime(var pMsg:CMessage;var _yy,_mm,_dd,_hh,_mn,_ss:Word);
Var
   mSec : Word;
   str,strF : String;
   i,nPos : Integer;
Begin
   DecodeDate(Now,_yy,_mn,_dd);
   DecodeTime(Now,_hh,_mm,_ss,mSec);
   _yy := _yy - 2000;
   try
   if (pMsg.m_swLen-13)>1 then
   begin
    SetLength(str,pMsg.m_swLen-13-1);
    move(pMsg.m_sbyInfo[1],str[1],pMsg.m_swLen-13-1);
    str := StringReplace(str,'TIME_(','',[rfReplaceAll]);
    str := StringReplace(str,':',':::',[rfReplaceAll]);
    str := StringReplace(str,')',':::',[rfReplaceAll]);
    nPos := Pos(':::',str);
    i:=0;
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     if (i=0) then _hh  := StrToInt(strF);
     if (i=1) then _mm  := StrToInt(strF);
     if (i=2) then _ss  := StrToInt(strF);
     Inc(i);
    End;
   end;
   except
    DecodeDate(Now,_yy,_mn,_dd);
    DecodeTime(Now,_hh,_mm,_ss,mSec);
   end
End;
function CCE301BYMeter.GetVersion(var pMsg:CMessage):String;
Var
   str,strF : String;
   i,nPos : Integer;
Begin
   try
   Result := '6';
   if (pMsg.m_swLen-13)>1 then
   begin
    SetLength(str,pMsg.m_swLen-13-1);
    move(pMsg.m_sbyInfo[1],str[1],pMsg.m_swLen-13-1);
    str := StringReplace(str,#$D+#$A,':::',[rfReplaceAll]);
    str := StringReplace(str,'v',':::',[rfReplaceAll]);
    nPos := Pos(':::',str);
    strF := Copy(str,0,nPos-1);
    Delete(str,1,nPos+2);
    nPos := Pos(':::',str);
    i:=0;
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     Result := strF;
     nPos := Pos(':::',str);
     Inc(i);
    End;
   end;
   except

   end
End;
function CCE301BYMeter.ReadDateTime(var pMsg:CMessage):boolean;
var
    Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
    Hour,Min  ,Sec,mSec,nKorrTime: word;
    LastDate:TDateTime;
begin
  if nReq.m_swSpecc0=0 then
   begin
    GetDateTime(pMsg,_yy,_mm,_dd,_hh,_mn,_ss);

    if (_mn>12)or(_mn=0)or(_dd>31)or(_dd=0)or(_hh>59)or(_mm>59)or(_ss>59) then
    Begin
     exit;
    End;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    //Коррекция времени
    nKorrTime :=5;
    if (Year <> _yy) or (Month <> _mn) or (Day <> _dd) or (Hour <> _hh) or (Min <> _mm) or (abs(_ss - Sec) >= nKorrTime) then
     begin
       if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Cчетчик нуждается в коррекции времени');
       m_nObserver.AddGraphParam(QRY_DATA_TIME, 1,0,0,1);  //заносим в Spec0=1 параметр для корекции дата/время счетчика
       Result := true;
       // KorrTime(LastDate);
     End;
   End
  else if nReq.m_swSpecc0=1 then
        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Коррекции времени произведена');
end;

function CCE301BYMeter.KorrTime(LastDate : TDateTime):boolean;
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
    tmpStr : string;
begin
    Result:=true;
    m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;

    tmpStr := #$01 + 'W1' + #$02 + 'TIME_('+
    IntToStr(Hour)+':'+
    IntToStr(Min) +':'+
    IntToStr(Sec) +')'+ #$03;
    tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
    move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
    FillMessageHead(m_nTxMsg, Length(tmpStr));
    if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
    SendToL1(BOX_L1, @m_nTxMsg);
End;

(*******************************************************************************
 * Ответ на команду "Запись времени и даты в счетчик" (таймаут приема до 4-х секунд)
 0х00 - OK (все правильно)
0х01 - Попытка записи с неверным паролем
0х02 - Передан недопустимый параметр
0х03 - Попытка изменения заводского параметра
0х04 - Неверная длинна данных
0х05 - Интерфейс заблокирован
0х06 - Запрашиваемых данных нет
0х07- Попытка чтения с неверным паролем

 *******************************************************************************)
procedure CCE301BYMeter.RES1D_SetDateTime(var pMsg:CMessage);
begin
   m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
   if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
   m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
   if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
  // FinalAction();
end;

function CCE301BYMeter.ReadAktPowAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal,fValSum  : double;
    CPs   : integer;
    sID   : integer;
    Hour, Min, Sec, MSec: Word;
begin
   sm  := 1;
   CPs := 0;
   fValSum:=0;
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'POWPP')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     DecodeTime(Now,Hour, Min, Sec, MSec);
     sID:=Hour*2;
     if (Min>30)then sID:=sID+1;

      CreateOutMSG(fVal, QRY_MGAKT_POW_A + CPs, 0, Now);
     m_nRxMsg.m_sbyServerID := sID;
     if CPs <= 2 then  
     fValSum:=fValSum+fVal;
       saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     CPs := CPs + 1;
     Result:=true;
   end;
    CreateOutMSG(fValSum, QRY_MGAKT_POW_S, 0, Now);
    m_nRxMsg.m_sbyServerID := sID;
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  // FinalAction;
end;
function CCE301BYMeter.ReadReaPowAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    CPs   : integer;
    sID   : integer;
    Hour, Min, Sec, MSec: Word;    
begin
   sm  := 1;
   CPs := 0;
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'POWPQ')*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     DecodeTime(Now,Hour, Min, Sec, MSec);
     sID:=Hour*2;
     if (Min>30)then sID:=sID+1;

     CreateOutMSG(fVal, QRY_MGREA_POW_A + CPs, 0, Now);
     m_nRxMsg.m_sbyServerID := sID;
     if CPs <= 2 then
      saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);
     CPs := CPs + 1;
     Result:=true;
   end;
//   FinalAction;
end;
function CCE301BYMeter.ReadCosFAns(var pMsg:CMessage):boolean;
var
    fVal  : double;
    str,strF : String;
    i,nPos : Integer;
begin
   try
   if (pMsg.m_swLen-13)>1 then
   begin
    SetLength(str,pMsg.m_swLen-13-1);
    move(pMsg.m_sbyInfo[1],str[1],pMsg.m_swLen-13-1);
    str := StringReplace(str,'COS_f(','',[rfReplaceAll]);
    str := StringReplace(str,')'+#$0D+#$0A,':::',[rfReplaceAll]);
    //str := StringReplace(str,')',':::',[rfReplaceAll]);
    nPos := Pos(':::',str);
    i:=0;
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     fVal := StrToFloat(strF);
     if i>=1 then
     Begin
      CreateOutMSG(fVal, QRY_KOEF_POW_A+i-1 , 0, Now);
      saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     End;
     Inc(i);
    End;
   end;
//    FinalAction;
   except
//    FinalAction;
   end
end;
{
procedure CCE301BYMeter.GetDateTime(var pMsg:CMessage;var _yy,_mm,_dd,_hh,_mn,_ss:Word);
Var
   mSec : Word;
   str,strF : String;
   i,nPos : Integer;
Begin
   DecodeDate(Now,_yy,_mn,_dd);
   DecodeTime(Now,_hh,_mm,_ss,mSec);
   _yy := _yy - 2000;
   try
   if (pMsg.m_swLen-11)>1 then
   begin
    SetLength(str,pMsg.m_swLen-11-1);
    move(pMsg.m_sbyInfo[1],str[1],pMsg.m_swLen-11-1);
    str := StringReplace(str,'TIME_(','',[rfReplaceAll]);
    str := StringReplace(str,':',':::',[rfReplaceAll]);
    str := StringReplace(str,')',':::',[rfReplaceAll]);
    nPos := Pos(':::',str);
    i:=0;
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     if (i=0) then _hh  := StrToInt(strF);
     if (i=1) then _mm  := StrToInt(strF);
     if (i=2) then _ss  := StrToInt(strF);
     Inc(i);
    End;
   end;
   except
    DecodeDate(Now,_yy,_mn,_dd);
    DecodeTime(Now,_hh,_mm,_ss,mSec);
   end
End;
}

function CCE301BYMeter.ReadUAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    CPs   : integer;
    sID   : integer;
    Hour, Min, Sec, MSec: Word;
begin
   sm  := 1;
   CPs := 0;
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'VOLTA')*m_nP.m_sfKU;
     DecodeTime(Now,Hour, Min, Sec, MSec);
     sID:=Hour*2;
     if (Min>30)then sID:=sID+1;
          
     CreateOutMSG(fVal, QRY_U_PARAM_A + CPs, 0, Now);
     m_nRxMsg.m_sbyServerID := sID;     
     if CPs <= 2 then
       saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     CPs := CPs + 1;
     result:=true;
   end;
//   FinalAction;
end;

function CCE301BYMeter.ReadIAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    CPs   : integer;
    sID   : integer;
    Hour, Min, Sec, MSec: Word;    
begin
   sm  := 1;
   CPs := 0;
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'CURRE')*m_nP.m_sfKI;
     DecodeTime(Now,Hour, Min, Sec, MSec);
     sID:=Hour*2;
     if (Min>30)then sID:=sID+1;
          
     CreateOutMSG(fVal, QRY_I_PARAM_A + CPs, 0, Now);
     m_nRxMsg.m_sbyServerID := sID;     
     if CPs <= 2 then
       saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
     CPs := CPs + 1;
     result:=true;
   end;
//   FinalAction;
end;

function CCE301BYMeter.ReadFreqAns(var pMsg:CMessage):boolean;
var sm    : integer;
    fVal  : double;
    sID   : integer;
    Hour, Min, Sec, MSec: Word;     
begin
   sm  := 1;
   while sm < pMsg.m_swLen - 13 do
   begin
     fVal := GetValueFromBuf(pMsg.m_sbyInfo[0], sm, pMsg.m_swLen - 13, 'FREQU');
     DecodeTime(Now,Hour, Min, Sec, MSec);
     sID:=Hour*2;
     if (Min>30)then sID:=sID+1;

     CreateOutMSG(fVal, QRY_FREQ_NET, 0, Now);
     m_nRxMsg.m_sbyServerID := sID;
     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
//     FinalAction;
     result:=true;
     exit;
   end;
   result:=false;
end;

function  CCE301BYMeter.ReadCloseSession(var pMsg:CMessage):boolean;
begin
//  Result:=true; //
end;

procedure CCE301BYMeter.SendMessageToMeter;
begin
  case nReq.m_swParamID of
      QRY_AUTORIZATION   : begin
                            if (nReq.m_swSpecc0=0) then CreateAutorReq;
                            if (nReq.m_swSpecc0=1) then CreateIndetifReq;
                            if (nReq.m_swSpecc0=2) then CreateCheckPasswReq;
                           end;
     QRY_ENERGY_SUM_EP    : CreateSumEnReq;     ////ПРОТЕСТИРОВАНО
     QRY_ENERGY_DAY_EP    : CreateDayEnReq;     ////ПРОТЕСТИРОВАНО
     QRY_ENERGY_MON_EP    : CreateMonEnReq;     ////ПРОТЕСТИРОВАНО
     QRY_SRES_ENR_EP      : CreateSresEnReq;    ////ПРОТЕСТИРОВАНО (Добавить признаки достоверности на каждый получас)
     QRY_NAK_EN_DAY_EP    : CreateNakEnDayReq;  ////ПРОТЕСТИРОВАНО
     QRY_NAK_EN_MONTH_EP  : CreateNakEnMonReq;  ////ПРОТЕСТИРОВАНО
     QRY_DATA_TIME        : CreateDateTime;
     QRY_MGAKT_POW_S, QRY_MGAKT_POW_A, QRY_MGAKT_POW_B, QRY_MGAKT_POW_C : CreateAktPowReq;
     QRY_MGREA_POW_S, QRY_MGREA_POW_A, QRY_MGREA_POW_B, QRY_MGREA_POW_C : CreateReaPowReq;
     QRY_KOEF_POW_A : CreateCosFReq;
     QRY_U_PARAM_S, QRY_U_PARAM_A, QRY_U_PARAM_B, QRY_U_PARAM_C : CreateUReq;
     QRY_I_PARAM_S, QRY_I_PARAM_A, QRY_I_PARAM_B, QRY_I_PARAM_C : CreateIReq;
     QRY_FREQ_NET : CreateFreqReq;
     QRY_EXIT_COM : CreateDiscReq;
   end;

end;

procedure CCE301BYMeter.CreateAutorReq;
var tmpStr : string;
begin
  // tmpStr := '/?' + m_nP.m_sddPHAddres + '!' + #$0D + #$0A;
   tmpStr := '/?' + m_Address + '!' + #$0D + #$0A;

   //tmpStr := '/?' + '!' + #$0D + #$0A;
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE301BYMeter.FillAutorReq;
var tmpStr : string;
begin
   //tmpStr := '/?' + m_nP.m_sddPHAddres + '!' + #$0D + #$0A;
   tmpStr := '/?' + m_Address + '!' + #$0D + #$0A;
   //tmpStr := '/?' + '!' + #$0D + #$0A;
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
end;

procedure CCE301BYMeter.CreateIndetifReq;
var tmpStr : string;
begin
   tmpStr := #$06 + #$30 + #$35 + #$31 + #$0D + #$0A;
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateCheckPasswReq;
var tmpStr : string;
begin
   if(m_nP.m_schPassword='')then
     tmpStr := #$01 + #$52 + #$31 + #$02 + #$53 + #$4E + #$55 + #$4D + #$42 +  #$28 + #$29 + #$03  //ДЛЯ ТЕСТА
   else
     tmpStr := #$01 + #$50 + #$31 + #$02 + #$28 + m_Pass + #$29 + #$03;   //РАБОТАЛО
     //tmpStr := #$01 + #$50 + #$31 + #$02 + #$28 + m_nP.m_schPassword + #$29 + #$03;   //РАБОТАЛО
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));

   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateSumEnReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'ET0PE()' + #$03 + #$37;
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateDayEnReq;
var tmpStr  : string;
    Day, Month, Year : Word;
begin
   DecodeDate(GetDayDateFromSm(nReq.m_swSpecc0), Year, Month, Day);
   tmpStr := #$01 + 'R1' + #$02 + 'EADPE(' + IntToStr(Day-1) + '.' +  //(Day-1) для того что бы текущий день считать так как в счетчике параметр на конец предыдущего
             IntToStr(Month) + '.' + IntToStr(Year - 2000) + ')' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateMonEnReq;
var tmpStr : string;
    Day, Month, Year : Word;
begin
   DecodeDate(GetMonthDateFromSm(nReq.m_swSpecc0), Year, Month, Day);
   tmpStr := #$01 + 'R1' + #$02 + 'EAMPE(' + IntToStr(Month-1) + '.' +  //(Month-1) для того что бы текущий месяц считать так как в счетчике параметр на конец предыдущего
             IntToStr(Year - 2000) + ')' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateSresEnReq;
var tmpStr : string;
    Day, Month, Year : Word;
begin
   DecodeDate(GetDayDateFromSm(nReq.m_swSpecc0), Year, Month, Day);
   tmpStr := #$01 + 'R1' + #$02 + 'GRAPE(' + IntToStr(Day) + '.' +
             IntToStr(Month) + '.' + IntToStr(Year - 2000) + ')' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateNakEnDayReq;
var tmpStr : string;
    Day, Month, Year : Word;
begin
   DecodeDate(GetDayDateFromSm(nReq.m_swSpecc0), Year, Month, Day);
   tmpStr := #$01 + 'R1' + #$02 + 'ENDPE(' + IntToStr(Day-1) + '.' +      //(Day-1) для того что бы текущий день считать так как в счетчике параметр на конец предыдущего
             IntToStr(Month) + '.' + IntToStr(Year - 2000) + ')' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;
procedure CCE301BYMeter.CreateDateTime;
var tmpStr : string;
    Day, Month, Year : Word;
begin
   if nReq.m_swSpecc0=0 then
   begin
     //DecodeDate(GetMonthDateFromSm(nReq.m_swSpecc0), Year, Month, Day);
     tmpStr := #$01 + 'R1' + #$02 + 'TIME_()' + #$03;
     tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
     move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
     FillMessageHead(m_nTxMsg, Length(tmpStr));
     if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
     SendToL1(BOX_L1, @m_nTxMsg);
   end
   else if nReq.m_swSpecc0=1 then
    KorrTime(Now);
end;
procedure CCE301BYMeter.CreateNakEnMonReq;
var tmpStr : string;
    Day, Month, Year : Word;
begin
   DecodeDate(GetMonthDateFromSm(nReq.m_swSpecc0), Year, Month, Day);
   tmpStr := #$01 + 'R1' + #$02 + 'ENMPE(' +IntToStr(Month-1) + '.' +    //(Month-1) для того что бы текущий месяц считать так как в счетчике параметр на конец предыдущего
                     IntToStr(Year - 2000) + ')' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateAktPowReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'POWPP()' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;
procedure CCE301BYMeter.CreateReaPowReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'POWPQ()' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;
procedure CCE301BYMeter.CreateCosFReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'COS_f()' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateUReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'VOLTA()' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateIReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'CURRE()' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateFreqReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'R1' + #$02 + 'FREQU()' + #$03;
   tmpStr := tmpStr + Char(CE301BY_CRC(tmpStr));
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CCE301BYMeter.CreateDiscReq;
var tmpStr : string;
begin
   tmpStr := #$01 + 'B0' + #$03 + #$75;
   move(tmpStr[1], m_nTxMsg.m_sbyInfo[0], Length(tmpStr));
   FillMessageHead(m_nTxMsg, Length(tmpStr));
   if (m_nP.m_sbyTSlice=1) then CalcParity(m_nTxMsg.m_sbyInfo,m_nTxMsg.m_swLen);
   m_nTxMsg.m_sbyTypeIntID  := 3; //Выход без ожидания ответа
   SendToL1(BOX_L1, @m_nTxMsg);
end;

constructor CCE301BYMeter.Create;
Begin
End;


destructor CCE301BYMeter.Destroy;
Begin
    inherited;
End;

procedure CCE301BYMeter.InitMeter(var pL2:SL2TAG);
Var
  Year, Month, Day : Word;
  slv : TStringList;
begin
  IsUpdate := 0;
  SetHandScenario;
  SetHandScenarioGraph;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
  m_strVer := '6';
  slv := TStringList.Create;
  getStrings(m_nP.m_sAdvDiscL2Tag,slv);
  if slv[0]='' then slv[0] := '0';
  if slv[2]='' then slv[2] := '0';
  m_Address   := slv[2];
  m_Pass      := slv[1];
  slv.Clear;
  slv.Destroy;
  IsUpdate   := 0;
  SetHandScenario();
  SetHandScenarioGraph();
End;

procedure CCE301BYMeter.RunMeter;
Begin

End;
 {
  case mCurrState of
     ST_CE301_AUTORIZATION   : CreateAutorReq;
     ST_CE301_INDETIFICATION : CreateIndetifReq;
     ST_CE301_CHECK_PASSWORD : CreateCheckPasswReq;
 }
function CCE301BYMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    if pMsg.m_sbyType = DL_REPMSG_TMR then
    begin
      if (mCurrState = ST_CE301_AUTORIZATION)or
         (mCurrState = ST_CE301_INDETIFICATION)or
         (mCurrState = ST_CE301_CHECK_PASSWORD) then
      begin
        mCurrState := ST_CE301_AUTORIZATION;
        CreateDiscReq;
        CreateAutorReq;
      end;
    end;
    Result := res;
End;

{DIR_L1TOL2}
function CCE301BYMeter.LoHandler(var pMsg0:CMessage):Boolean;
var res : boolean;
    pMsg:CMessage;
    nLen : Word;
    nRet : Byte;
begin
  res := true;
  move(pMsg0,pMsg,sizeof(CMessage));
  case pMsg.m_sbyType of
    PH_DATA_IND, QL_REDIRECT_REQ:
      begin
        if (m_nP.m_sbyTSlice=1) then ClearParity(pMsg.m_sbyInfo,pMsg.m_swLen);
        res := ReadAnswerFromCE301(pMsg);
      End;
    End;
    Result := res;
End;

function CCE301BYMeter.CRC(var buf : array of byte; cnt : byte):boolean;
var
    CRChiEl             : byte;
    CRCloEl             : byte;
    i                   : byte;
    cmp                 : byte;
    idx                 : byte;
begin
    Result  := true;
    CRChiEl := $FF;
    CRCloEl := $FF;
    cmp     := cnt-1;
    if cnt >= 300 then
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
    if (CRCloEl <> buf[cnt]) and (CRChiEl <> buf[cnt+1]) then
      Result := false;
    buf[cnt]    := CRCloEl;
    buf[cnt+1]  := CRChiEl;
end;


function CCE301BYMeter.HiHandler(var pMsg:CMessage):Boolean;
begin
  Result := False;

  m_nRxMsg.m_sbyServerID := 0;
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    begin
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
      SendMessageToMeter;
    end;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_CTRL_REQ     : HandCtrlRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
  End;
End;

procedure CCE301BYMeter.OnEnterAction;
Begin
    //CreateDiscReq;
    mCurrState := ST_CE301_AUTORIZATION;
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then begin end;//FinalAction;
    //FinalAction;
End;


procedure CCE301BYMeter.OnFinalAction;
Begin
    //CreateDiscReq;
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
   // FinalAction;
End;

procedure CCE301BYMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    CreateDiscReq;
    m_nModemState := 1;
   // FinalAction;
End;

procedure CCE301BYMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CCE301BYMeter.HandQryRoutine(pMsg:CMessage);
var
  Date1, Date2 : TDateTime;
  l_ParamID    : word;
  l_wPrecize     : word;
  szDT         : word;
  pDS          : CMessageData;
begin
    IsUpdate := 1;
   // m_nObserver.ClearGraphQry(); ЕСЛИ БУДЕТ СТОЯТЬ ТО БУДЕТ ПОСТОЯННО ЧИТАТЬСЯ ОДИН МЕСЯЦ
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    l_ParamID    := pDS.m_swData1;
    l_wPrecize   := pDS.m_swData2;
    case l_ParamID of
      QRY_SRES_ENR_EP : AddSresEnGraphQry(Date1, Date2);
      QRY_ENERGY_DAY_EP, QRY_NAK_EN_DAY_EP   : AddEnDayGraphQry(l_paramID, Date1, Date2);
      QRY_ENERGY_MON_EP, QRY_NAK_EN_MONTH_EP : AddEnMonGraphQry(l_paramID, Date1, Date2);
      else exit;
    end;
end;

procedure CCE301BYMeter.HandCtrlRoutine(pMsg:CMessage);
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

procedure CCE301BYMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     //OnFinalAction;
//     FinalAction;
//     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::> CE301BY OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
    End;
end;

function CCE301BYMeter.CE301BY_CRC(var str : string) : byte;
var i : integer;
begin
   Result := 0;
   for i := 2 to length(str) do
     Result := (Result + Byte(str[i])) mod $80;
end;

procedure CCE301BYMeter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
begin
   strNum  := 1;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestEntas.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   pMsg.m_swLen := cnt + 13;
end;

function CCE301BYMeter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;
procedure CCE301BYMeter.CalcParity(var buf : array of byte; var nCount : Word);
Var
   i : Integer;
   byByte : Byte;
Begin
   for i := 0 to nCount-13-1 do
   Begin
    byByte := buf[i];
    if IsEven(byByte)=False then
    Begin
     byByte := byByte or $80;
     buf[i] := byByte;
    end;
   End;
End;
procedure CCE301BYMeter.ClearParity(var buf : array of byte; var nCount : Word);
Var
   i : Integer;
Begin
   for i := 0 to nCount-13-1 do
   buf[i] := buf[i] and $7f;
End;
function CCE301BYMeter.IsEven(byData:Byte):Boolean;
Var
   i : Integer;
   byEven : Integer;
Begin
   byEven := 0;
   for i:=0 to 6 do
   Begin
    if ((byData and ($01 shl i))<>0) then
    Inc(byEven);
   End;
   Result := not Odd(byEven);
End;
procedure CCE301BYMeter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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
function CCE301BYMeter.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;

end.

