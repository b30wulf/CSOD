unit knsl2ce6822meter;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl2meter,utlmtimer,Math,utlTimeDate,knsl3EventBox;
type
    CCE6822Meter = class(CMeter)
    Private
     ReadParamID  : byte;
     LastTarif    : byte;
     PointPos     : integer;
     IsUpdate     : boolean;
     mMonth       : Word;
     advInfo      : SL2TAGADVSTRUCT;
     sumTarif     : Double;    // Суммирующий тариф
     procedure SetCurrQry;
     procedure SetGraphQry;
     procedure RunMeter;override;
     procedure InitMeter(var pL2:SL2TAG);override;
     procedure CreateSymEnergReqMSG(var nReq: CQueryPrimitive);
     procedure CreateDateTimeReqMSG;
     procedure CreateMonthEnergReqMSG(var nReq: CQueryPrimitive);
     procedure CreatePointPosReqMSG;
     function  SelfHandler(var pMsg:CMessage):Boolean;override;
     function  LoHandler(var pMsg:CMessage):Boolean;override;
     function  HiHandler(var pMsg:CMessage):Boolean;override;
     function  CalculateCRC(var mas : array of byte; size : byte): byte;
     procedure PreapareMsg(var pMsg:CMessage);
     procedure PrepareOutMsg;
     function  ReadSymEnerg(var pMsg:CMessage):boolean;
     function  ReadDateTime(var pMsg:CMessage):boolean;
     function  ReadMonthEnerg(var pMsg:CMessage):boolean;
     function  ReadPointPos(var pMsg:CMessage):boolean;
     function  BCDToByte(hexNumb:byte):byte;
     procedure MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
     procedure MSGHead(var pMsg:CHMessage; Size:byte);
     procedure CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
     procedure HandQryRoutine(var pMsg:CMessage);
     procedure AddEnergyMonthGrpahQry(Date1, Date2 : TDateTime);
     procedure WriteDate(var pMsg : CMessage);
     procedure TestMessage(var pMsg:CMessage);
     procedure OnEnterAction;
     procedure OnFinalAction;
     procedure OnFinHandQryRoutine(var pMsg:CMessage);
     procedure TimeCorrection;

     constructor Create;
    End;
const crc8tab: array[0..255] of Byte = (
		$00,$b5,$df,$6a,$0b,$be,$d4,$61,$16,$a3,$c9,$7c,$1d,$a8,
		$c2,$77,$2c,$99,$f3,$46,$27,$92,$f8,$4d,$3a,$8f,$e5,$50,
		$31,$84,$ee,$5b,$58,$ed,$87,$32,$53,$e6,$8c,$39,$4e,$fb,
		$91,$24,$45,$f0,$9a,$2f,$74,$c1,$ab,$1e,$7f,$ca,$a0,$15,
		$62,$d7,$bd,$08,$69,$dc,$b6,$03,$b0,$05,$6f,$da,$bb,$0e,
		$64,$d1,$a6,$13,$79,$cc,$ad,$18,$72,$c7,$9c,$29,$43,$f6,
		$97,$22,$48,$fd,$8a,$3f,$55,$e0,$81,$34,$5e,$eb,$e8,$5d,
		$37,$82,$e3,$56,$3c,$89,$fe,$4b,$21,$94,$f5,$40,$2a,$9f,
		$c4,$71,$1b,$ae,$cf,$7a,$10,$a5,$d2,$67,$0d,$b8,$d9,$6c,
		$06,$b3,$d5,$60,$0a,$bf,$de,$6b,$01,$b4,$c3,$76,$1c,$a9,
		$c8,$7d,$17,$a2,$f9,$4c,$26,$93,$f2,$47,$2d,$98,$ef,$5a,
		$30,$85,$e4,$51,$3b,$8e,$8d,$38,$52,$e7,$86,$33,$59,$ec,
		$9b,$2e,$44,$f1,$90,$25,$4f,$fa,$a1,$14,$7e,$cb,$aa,$1f,
		$75,$c0,$b7,$02,$68,$dd,$bc,$09,$63,$d6,$65,$d0,$ba,$0f,
		$6e,$db,$b1,$04,$73,$c6,$ac,$19,$78,$cd,$a7,$12,$49,$fc,
		$96,$23,$42,$f7,$9d,$28,$5f,$ea,$80,$35,$54,$e1,$8b,$3e,
		$3d,$88,$e2,$57,$36,$83,$e9,$5c,$2b,$9e,$f4,$41,$20,$95,
		$ff,$4a,$11,$a4,$ce,$7b,$1a,$af,$c5,$70,$07,$b2,$d8,$6d,
		$0c,$b9,$d3,$66 );
const
  GENERAL_BYTES: array[0..12] of Byte = ($00, $00, $00, $00, $00, $C0, $28, $00, $01, $FF, $FF, $FF, $FF);
  DATE_TIME_PARAMS: array[0..2] of Byte = ($86, $00, $20);
  POINT_POS: array[0..2] of Byte = ($81, $00, $0B);
  SET_TIME  : array [0..2] of Byte = ($96, $00, $20);//($93, $00, $20);
  ENERG1_PARAMS: array[0..2] of Byte = ($84, $00, $40);
  BEG_MONTH_EN: array[0..2] of Byte = ($A4, $03, $20);
implementation

procedure CCE6822Meter.TimeCorrection;
var difTime : byte;
    hour, min, sec, ms : word;
    year, month, day : word;
    DenWeek: integer;
begin
   ReadParamID            := QRY_DATA_TIME;
   move(GENERAL_BYTES, m_nTxMsg.m_sbyInfo[0], 13);
   move(SET_TIME, m_nTxMsg.m_sbyInfo[13], 3);
   DecodeTime(Now, hour, min, sec, ms);
   DecodeDate(Now, year, month, day);
   DenWeek:= DayOfWeek(Now);
   DenWeek:=DenWeek-1;
   if (DenWeek=7)then DenWeek:=0;

   m_nTxMsg.m_sbyInfo[7]      := StrToInt(advInfo.m_sAdrToRead);//StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[8]      := $FD;

   m_nTxMsg.m_sbyInfo[16] := sec;
   m_nTxMsg.m_sbyInfo[17] := min mod 30;
   m_nTxMsg.m_sbyInfo[18] := hour*2 + min div 30;

   m_nTxMsg.m_sbyInfo[19] := day;
   m_nTxMsg.m_sbyInfo[20] := (DenWeek shl 5)+month;
   m_nTxMsg.m_sbyInfo[21] := year-2000;

   m_nTxMsg.m_sbyInfo[22] := CalculateCRC(m_nTxMsg.m_sbyInfo[6], 16);
   m_nTxMsg.m_sbyInfo[23] := $C0;
   MSGHeadAndPUT(m_nTxMsg, 24);
end;

procedure CCE6822Meter.AddEnergyMonthGrpahQry(Date1, Date2 : TDateTime);
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;
begin
   if (CDateTimeR.CompareMonth(Date2, Now) = 1) then
     Date2 := Now;
   //if (CDateTimeR.CompareMonth(Date2, Now) = 0) then
   //  CDateTimeR.DecMonth(Date2);
   while CDateTimeR.CompareMonth(Date1, Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while CDateTimeR.CompareMonth(Date2, TempDate) <> 1 do
     begin
       CDateTimeR.DecMonth(TempDate);
       Inc(i);
       if i >= 12 then
         exit;
     end;
     DecodeDate(TempDate, Year, Month, Day);
     m_nObserver.AddGraphParam(QRY_POINT_POS, 0 , 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month , 1, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month , 2, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month , 3, 0, 1);
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, Month , 4, 0, 1);
     CDateTimeR.DecMonth(Date2);
   end;
end;

procedure CCE6822Meter.WriteDate(var pMsg : CMessage);
var Year, Month, Day, MonthMet : word;
begin
   DecodeDate(Now, Year, Month, Day);
   MonthMet := Trunc(pMsg.m_sbyInfo[6] / $10) + 1;
   if mMonth >= Month then
     Dec(Year);
   Inc(mMonth);
   if mMonth>12 then
   Begin
    Inc(Year);
    mMonth := 1;
   End;
   m_nRxMsg.m_sbyInfo[2] := Year-2000;
   m_nRxMsg.m_sbyInfo[3] := mMonth;
   m_nRxMsg.m_sbyInfo[4] := 1;//CDateTimeR.DayPerMonth(MonthMet, Year);
   m_nRxMsg.m_sbyInfo[5] := 00;
   m_nRxMsg.m_sbyInfo[6] := 00;
   m_nRxMsg.m_sbyInfo[7] := 00;
end;

function  CCE6822Meter.BCDToByte(hexNumb:byte):byte;
begin
    Result := (hexNumb shr 4)*10 + (hexNumb and $0F);
end;

procedure CCE6822Meter.CreateOutputMSG(paramNo : integer; Param:single; tarif : byte);
var
    Hour, Min, Sec, mSec   : word;
    Year, Month, Day       : word;
    fParam : Double;
begin
    m_nRxMsg.m_sbyType    := DL_DATARD_IND;
    m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
    m_nRxMsg.m_swObjID    := m_nP.m_swMID;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[1] := paramNo;
    m_nRxMsg.m_sbyInfo[2] := Year;
    m_nRxMsg.m_sbyInfo[3] := Month;
    m_nRxMsg.m_sbyInfo[4] := Day;
    m_nRxMsg.m_sbyInfo[5] := Hour;
    m_nRxMsg.m_sbyInfo[6] := Min;
    m_nRxMsg.m_sbyInfo[7] := Sec;
    m_nRxMsg.m_sbyInfo[8] := tarif;
    fParam                := param;
    move(fParam, m_nRxMsg.m_sbyInfo[9], sizeof(fParam));
    //m_nRxMsg.m_swLen      := 11 + m_nRxMsg.m_sbyInfo[0];
    if IsUpdate then
      m_nRxMsg.m_sbyDirID   := 1
    else
      m_nRxMsg.m_sbyDirID   := 0;
    m_nRxMsg.m_sbyServerID:= 0;
end;

procedure CCE6822Meter.MSGHeadAndPUT(var pMsg:CHMessage; Size:byte);
var Adr      : word;
    password : integer;
    crc      : byte;
begin
    pMsg.m_swLen       := Size + 13;
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_CE6822;     //Указать тип счетчика
    if IsUpdate then
      pMsg.m_sbyDirID    := 1
    else
      pMsg.m_sbyDirID    := 0;
//    SendOutStat(pMsg.m_swLen);
//    PrepareOutMsg;
    SendToL1(BOX_L1, @pMsg);
end;

procedure CCE6822Meter.MSGHead(var pMsg:CHMessage; Size:byte);
var Adr      : word;
    password : integer;
    crc      : byte;
begin
    pMsg.m_swLen       := Size + 13;
    pMsg.m_swObjID     := m_nP.m_swMID;       //Сетевой адрес счётчика
    pMsg.m_sbyFrom     := DIR_L2TOL1;
    pMsg.m_sbyFor      := DIR_L2TOL1;    //DIR_L2toL1
    pMsg.m_sbyType     := PH_DATARD_REQ; //PH_DATARD_REC
    //pMsg.m_sbyTypeIntID:= DEV_COM;       //DEF_COM
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_CE6822;     //Указать тип счетчика
    if IsUpdate then
      pMsg.m_sbyDirID    := 1
    else
      pMsg.m_sbyDirID    := 0;
end;

function  CCE6822Meter.CalculateCRC(var mas : array of byte; size : byte):byte;
var i:byte;
begin
    Result := 0;
    for i:=0 to size-1 do
      Result := crc8tab[Result xor mas[i]];
end;

procedure CCE6822Meter.PreapareMsg(var pMsg:CMessage);
var i, j : integer;
begin
   for i := 1 to pMsg.m_swLen - 13 do
   begin
     if (pMsg.m_sbyInfo[i] = $DB) and (pMsg.m_sbyInfo[i + 1] = $DC) then
     begin
       pMsg.m_sbyInfo[i] := $C0;
       for j := i + 1 to pMsg.m_swLen - 13 do
         pMsg.m_sbyInfo[j] := pMsg.m_sbyInfo[j + 1];
     end;
     if (pMsg.m_sbyInfo[i] = $DB) and (pMsg.m_sbyInfo[i + 1] = $DD) then
     begin
       pMsg.m_sbyInfo[i] := $DB;
       for j := i + 1 to pMsg.m_swLen - 13 do
         pMsg.m_sbyInfo[j] := pMsg.m_sbyInfo[j + 1];
     end;
   end;
end;

procedure CCE6822Meter.PrepareOutMsg;
begin

end;

function  CCE6822Meter.ReadSymEnerg(var pMsg:CMessage):boolean;
var crc : byte;
param   : single;
poi     : double;
begin
    crc    := CalculateCRC(pMsg.m_sbyInfo[1], 10);
    PreapareMsg(pMsg);
    if (crc <> pMsg.m_sbyInfo[11]) then
    begin
      Result := false;
      exit;
    end;
   // PreapareMsg(pMsg);
    if pMsg.m_swLen <= 23 then
      param := 0
    else
    begin
      param := pMsg.m_sbyInfo[7] + pMsg.m_sbyInfo[8]*100 + pMsg.m_sbyInfo[9]*10000 + pMsg.m_sbyInfo[10]*1000000;
      //poi:=Power(10, PointPos);;
      param := param / PointPos;//Power(10, PointPos);
      sumTarif:=sumTarif + param;
    end;

    if(LastTarif=4)then
    begin
    CreateOutputMSG(QRY_ENERGY_SUM_EP, sumTarif, 0);
    saveToDB(m_nRxMsg); // Сохранение данныех
    end;
    CreateOutputMSG(QRY_ENERGY_SUM_EP, param, LastTarif);
    saveToDB(m_nRxMsg); // Сохранение данныех
    //FPUT(BOX_L3_BY, @m_nRxMsg);
    Result := true;
end;

function  CCE6822Meter.ReadMonthEnerg(var pMsg:CMessage):boolean;
var crc : byte;
param   : single;
begin
    crc    := CalculateCRC(pMsg.m_sbyInfo[1], 10);
    PreapareMsg(pMsg);
    if (crc <> pMsg.m_sbyInfo[11]) then
    begin
      Result := false;
      exit;
    end;
    if pMsg.m_swLen <= 23 then
      param := 0
    else
    begin
      param := pMsg.m_sbyInfo[7] + pMsg.m_sbyInfo[8]*100 + pMsg.m_sbyInfo[9]*10000 + pMsg.m_sbyInfo[10]*1000000;
      //param := param / Power(10, PointPos);
     param := param / PointPos;//Power(10, PointPos);
      sumTarif:=sumTarif + param;
    end;
    if(LastTarif=4)then
    begin
    CreateOutputMSG(QRY_NAK_EN_MONTH_EP, sumTarif, 0);
    WriteDate(pMsg);
    saveToDB(m_nRxMsg); // Сохранение данныех
    end;
    CreateOutputMSG(QRY_NAK_EN_MONTH_EP, param, LastTarif);
    WriteDate(pMsg);
    saveToDB(m_nRxMsg); // Сохранение данных
//    FPUT(BOX_L3_BY, @m_nRxMsg);
    Result := true;
end;

function  CCE6822Meter.ReadDateTime(var pMsg:CMessage):boolean;
var crc : byte;
begin
    crc := CalculateCRC(pMsg.m_sbyInfo[1], 6);
    if (crc <> pMsg.m_sbyInfo[7]) then
    begin
      result :=false;
      exit;
    end;
    Result := true;
end;

function  CCE6822Meter.ReadPointPos(var pMsg:CMessage):boolean;
var crc : byte;
begin
    crc    := CalculateCRC(pMsg.m_sbyInfo[1], 7);
    //PreapareMsg(pMsg);
    if (crc <> pMsg.m_sbyInfo[8]) then
    begin
      Result := false;
      exit;
    end;
   // PointPos := (pMsg.m_sbyInfo[7] and 3 shr 1)  + (pMsg.m_sbyInfo[7] and 1)*2;
    PointPos := (pMsg.m_sbyInfo[7] and 6 shr 1);
    //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(PointPos= '+IntToStr(PointPos)+')');
    case PointPos of
    0:PointPos:=1;
    1:PointPos:=1000;
    2:PointPos:=100;
    3:PointPos:=10;
    end;
    Result := true;
end;

procedure CCE6822Meter.CreateSymEnergReqMSG(var nReq: CQueryPrimitive);
begin
    if nReq.m_swSpecc1 = 0 then
    begin
      exit;
    end;
    ReadParamID            := QRY_ENERGY_SUM_EP;
    LastTarif              := nReq.m_swSpecc1;
    move(GENERAL_BYTES, m_nTxMsg.m_sbyInfo[0], 13);
    m_nTxMsg.m_sbyInfo[7]      := StrToInt(advInfo.m_sAdrToRead);//StrToInt(m_nP.m_sddPHAddres);
    move(ENERG1_PARAMS, m_nTxMsg.m_sbyInfo[13], 3);
    m_nTxMsg.m_sbyInfo[15] := $40 + ((nReq.m_swSpecc1 - 1) * 4);
    m_nTxMsg.m_sbyInfo[16] := CalculateCRC(m_nTxMsg.m_sbyInfo[6], 10);
    m_nTxMsg.m_sbyInfo[17] := $C0;
    MSGHeadAndPUT(m_nTxMsg, 18);
end;

procedure CCE6822Meter.CreateDateTimeReqMSG;
begin
    ReadParamID            := QRY_DATA_TIME;
    move(GENERAL_BYTES[0], m_nTxMsg.m_sbyInfo[0], 13);
    m_nTxMsg.m_sbyInfo[7]      :=StrToInt(advInfo.m_sAdrToRead); //StrToInt(m_nP.m_sddPHAddres);
    move(DATE_TIME_PARAMS[0], m_nTxMsg.m_sbyInfo[13], 3);
    m_nTxMsg.m_sbyInfo[16]     := CalculateCRC(m_nTxMsg.m_sbyInfo[6], 10);
    m_nTxMsg.m_sbyInfo[17]     := $C0;
    MSGHeadAndPUT(m_nTxMsg, 18);
end;

procedure CCE6822Meter.CreateMonthEnergReqMSG(var nReq: CQueryPrimitive);
var Year, Day : word;
begin
    if nReq.m_swSpecc1 = 0 then
    begin
      exit;
    end;
    DecodeDate(Now, Year, mMonth, Day);
    if nReq.m_swSpecc0 <> 0 then
      mMonth := nReq.m_swSpecc0
    else
      if mMonth = 1 then
        mMonth := 12
      else
        Dec(mMonth);
    ReadParamID            := QRY_NAK_EN_MONTH_EP;
    LastTarif              := nReq.m_swSpecc1;
    move(GENERAL_BYTES, m_nTxMsg.m_sbyInfo[0], 13);
    m_nTxMsg.m_sbyInfo[7]      := StrToInt(advInfo.m_sAdrToRead);//StrToInt(m_nP.m_sddPHAddres);
    move(BEG_MONTH_EN, m_nTxMsg.m_sbyInfo[13], 3);
    m_nTxMsg.m_sbyInfo[15] := ((mMonth - 1)*$10) + ((nReq.m_swSpecc1 - 1) * 4);
    m_nTxMsg.m_sbyInfo[16] := CalculateCRC(m_nTxMsg.m_sbyInfo[6], 10);
    m_nTxMsg.m_sbyInfo[17] := $C0;
    MSGHeadAndPUT(m_nTxMsg, 18);
end;

procedure CCE6822Meter.CreatePointPosReqMSG;
begin
    ReadParamID            := QRY_POINT_POS;
    move(GENERAL_BYTES[0], m_nTxMsg.m_sbyInfo[0], 13);
    m_nTxMsg.m_sbyInfo[7]      := StrToInt(advInfo.m_sAdrToRead);//StrToInt(m_nP.m_sddPHAddres);
    m_nTxMsg.m_sbyInfo[8]      := $FD;
    move(POINT_POS[0], m_nTxMsg.m_sbyInfo[13], 3);
    m_nTxMsg.m_sbyInfo[16]     := CalculateCRC(m_nTxMsg.m_sbyInfo[6], 10);
    m_nTxMsg.m_sbyInfo[17]     := $C0;
    MSGHeadAndPUT(m_nTxMsg, 18);
end;

constructor CCE6822Meter.Create;
Begin

End;

procedure CCE6822Meter.InitMeter(var pL2:SL2TAG);
var
    slv : TStringList;
Begin
    PointPos := 1;
    IsUpdate   := false;
     SetHandScenario;
     SetHandScenarioGraph;
    slv := TStringList.Create;
    getStrings(m_nP.m_sAdvDiscL2Tag,slv);
    if slv[0]='' then slv[0] := '0';
    if slv[2]='' then slv[2] := '0';
    advInfo.m_sKoncFubNum  := slv[0]; //
    advInfo.m_sKoncPassw   := slv[1]; //Пароль на счетчик
    advInfo.m_sAdrToRead   := slv[2]; // Адрес счетчика
    slv.Clear;
    slv.Destroy;
End;

procedure CCE6822Meter.SetCurrQry;
Begin
    with m_nObserver do
    Begin
     ClearCurrQry;
     //При чтении энергии  speq1 - номер тарифа
     //AddCurrParam(99,0,0,0,1); //Запрос на положение точки
     AddCurrParam(QRY_ENERGY_SUM_EP,0,1,0,1);  //Запрос на чтение общей накопленной энергии
     AddCurrParam(QRY_ENERGY_SUM_EP,0,2,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,3,0,1);
     AddCurrParam(QRY_ENERGY_SUM_EP,0,4,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,1,0,1); //Запрос на чтение энергии накопленной на начало месяца
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,2,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,3,0,1);
     AddCurrParam(QRY_NAK_EN_MONTH_EP,0,4,0,1);
     AddCurrParam(QRY_DATA_TIME,0,0,0,1); //Запрос на чтение времени и даты
    End;
End;              
procedure CCE6822Meter.SetGraphQry;
Begin
End;

function CCE6822Meter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)
    Result := res;
End;


procedure CCE6822Meter.HandQryRoutine(var pMsg:CMessage);
Var
    Date1, Date2 : TDateTime;
    param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    OnEnterAction;
    IsUpdate := true;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    param := pDS.m_swData1;
    case param of
     QRY_NAK_EN_MONTH_EP   :
     Begin
      //m_nObserver.AddGraphParam(QM_ENT_MTR_IND, 0, 0, 0, 1);//Enter
      AddEnergyMonthGrpahQry(Date1, Date2);
      //m_nObserver.AddGraphParam(QM_FIN_MTR_IND, 0, 0, 0, 1);//Final
     End;
    end;
end;

function CCE6822Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L1
    case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
      {$IFNDEF CE6822_DEBUG}
        case ReadParamID of
          QRY_ENERGY_SUM_EP    : res := ReadSymEnerg(pMsg);
          QRY_DATA_TIME        : res := ReadDateTime(pMsg);
          QRY_NAK_EN_MONTH_EP  : res := ReadMonthEnerg(pMsg);
          QRY_POINT_POS        : res := ReadPointPos(pMsg);
        end;
       {$ELSE}
         TestMessage(pMsg);
       {$ENDIF}
      End;
    End;
    Result := res;
End;
procedure CCE6822Meter.TestMessage(var pMsg:CMessage);
Var
    Year, Month, Day, Hour, Min, Sec, mSec:Word;
    fValue : Single;
Begin
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CE6822  DIN:',@pMsg);
    pMsg.m_swLen   := 13+13;
    pMsg.m_sbyFor  := DIR_L2TOL3;
    pMsg.m_sbyType := DL_DATARD_IND;

    fValue := pMsg.m_sbyInfo[2]+2*pMsg.m_sbyInfo[4];
    Move(fValue,pMsg.m_sbyInfo[9],sizeof(Single));
    pMsg.m_sbyInfo[8] := pMsg.m_sbyInfo[4]; //tar
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    pMsg.m_sbyInfo[0] := 13;
    pMsg.m_sbyInfo[1] := pMsg.m_sbyInfo[2];
    pMsg.m_sbyInfo[2] := Year;
    pMsg.m_sbyInfo[3] := Month;
    pMsg.m_sbyInfo[4] := Day;
    pMsg.m_sbyInfo[5] := Hour;
    pMsg.m_sbyInfo[6] := Min;
    pMsg.m_sbyInfo[7] := Sec;
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY,@pMsg);
    m_byRep := m_nP.m_sbyRepMsg;
    m_nRepTimer.OffTimer;
    SendSyncEvent;
End;
function CCE6822Meter.HiHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
    nReq: CQueryPrimitive;
Begin
    res := False;
    //Обработчик для L3
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
       Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));

       if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
       if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;
       {$IFNDEF CE6822_DEBUG}
       case nReq.m_swParamID of
         QRY_ENERGY_SUM_EP   : CreateSymEnergReqMSG(nReq);
         QRY_DATA_TIME       : TimeCorrection;//CreateDateTimeReqMSG;
         QRY_NAK_EN_MONTH_EP : CreateMonthEnergReqMSG(nReq);
         QRY_POINT_POS       : CreatePointPosReqMSG;
       end;
       {$ELSE}
        MSGHead(m_nTxMsg,5);
        m_nTxMsg.m_sbyInfo[1] := 4;               //fnc
        m_nTxMsg.m_sbyInfo[2] := nReq.m_swParamID;//parameter
        m_nTxMsg.m_sbyInfo[3] := nReq.m_swSpecc0; //smes
        m_nTxMsg.m_sbyInfo[4] := nReq.m_swSpecc1; //tar
        SendToL1(BOX_L1 ,@m_nTxMsg);
       {$ENDIF}
      End;
      QL_DATA_GRAPH_REQ: HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    End;
    Result := res;
End;

procedure CCE6822Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
//    TraceM(4,pMsg.m_swObjID,'(__)CL2MD::>SS301OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := false;
    OnFinalAction;
end;

procedure CCE6822Meter.OnEnterAction;
Var
     pDS : CMessageData;
     sPT : SL1SHTAG;
Begin
    sPT.m_sbySpeed    := m_nSpeedList.IndexOf('2400');
    sPT.m_sbyParity   := m_nParityList.IndexOf('NO');
    sPT.m_sbyData     := m_nDataList.IndexOf('8');
    sPT.m_sbyStop     := m_nStopList.IndexOf('2');
    sPT.m_swDelayTime := 100;
    Move(sPT,pDS.m_sbyInfo[0],sizeof(SL1SHTAG));
    SendMsgIData(BOX_L1,m_nP.m_swMID,m_nP.m_sbyPortID,DIR_L2TOL1,PH_SETPORT_IND,pDS);
End;
procedure CCE6822Meter.OnFinalAction;
Var
     pDS : CMessageData;
Begin
    SendMsgIData(BOX_L1,m_nP.m_swMID,m_nP.m_sbyPortID,DIR_L2TOL1,PH_SETDEFSET_IND,pDS);
End;

procedure CCE6822Meter.RunMeter;
Begin
End;

end.
