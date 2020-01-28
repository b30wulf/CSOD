unit knsl2uspd16401bmeter;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, stdctrls, comctrls, utltypes, utlbox,
  utlconst, knsl2meter, utlmtimer, knsl3observemodule, utlTimeDate, utldatabase,
  knsl3EventBox{$IFDEF JCL1}, uJCL {$ENDIF};

type
  CUSPD16401BMeter = class(CMeter)
  private
    m_nCounter: Integer;
    m_nCounter1: Integer;
     //IsUpdate     : boolean;
    nReq: CQueryPrimitive;
    PnReq: PCQueryPrimitive;
    mCurrState: Integer;
    mCntrlInd: Byte;
    mTimeDir: Integer;
    advInfo: SL2TAGADVSTRUCT;
    GetVer: Byte; //Для уточнения версии УСПД

    procedure SetCurrQry;
    procedure SetGraphQry;
    procedure RunMeter; override;
    procedure InitMeter(var pL2: SL2TAG); override;
    function SelfHandler(var pMsg: CMessage): Boolean; override;
    procedure CreateOutMSG(param: double; sm: byte; tar: byte; Date: TDateTime);
    function LoHandler(var pMsg: CMessage): Boolean; override;
    function HiHandler(var pMsg: CMessage): Boolean; override;
    procedure AddNakEnergyDayGraphQry(dt_Date1, dt_Date2: TDateTime);
    procedure AddNakEnergyMonthGraphQry(dt_Date1, dt_Date2: TDateTime);
    procedure AddEnergySresGraphQry(dt_Date1, dt_Date2: TDateTime);
    function ReadAutorAns(var pMsg: CMessage): boolean;
    function ReadUnknownNakAns(var pMsg: CMessage): boolean;
    function ReadSumEnAns(var pMsg: CMessage): boolean;
    function ReadNakEnDayAns(var pMsg: CMessage): boolean;
    function ReadNakEnMonAns(var pMsg: CMessage): boolean;
    function ReadSresEnAns(var pMsg: CMessage): boolean;
    function ReadTimeAns(var pMsg: CMessage): boolean;
    function RES0120_CorTimeRes(var pMsg: CMessage): Boolean;    // Ответ коректировки времени от параметра

    function ReadDateTimeAns(var pMsg: CMessage): boolean;
    function ReadConveer(var pMsg: CMessage): boolean;
    function ReadAnswer(var pMsg: CMessage): boolean;
    function ReadCloseAutorAns(var pMsg: CMessage): boolean;
    function ReadPreAutor0Req(var pMsg: CMessage): boolean;
    function ReadPreAutor1Req(var pMsg: CMessage): boolean;
    function ReadPreAutor2Req(var pMsg: CMessage): boolean;
    function ReadPreAutor3Req(var pMsg: CMessage): boolean;
    function ReadDataAns(var pMsg: CMessage): boolean;
     ///function    ReadAnswer(var pMsg: CMessage): boolean;

    procedure CreateCloseAutorReq;
    procedure CreatePreAutor0Req;
    procedure CreatePreAutor1Req;
    procedure CreatePreAutor2Req;
    procedure CreatePreAutor3Req;
    procedure CreateVersionInfo;                             //Запрос версии УСПД
    function ReadVersionInfo(var pMsg: CMessage; var _GetVer: Byte): Boolean; //Ответ  версии УСПД
    procedure CreateAutorReq;                                //Запрос авторизации
    function ReadAutoReq_2_4(var pMsg: CMessage): Boolean;    //Ответ авторизации на версию УСПД  2.3, 3.3, 4.2, 4.3, 4.4
    function ReadAutoReq_5(var pMsg: CMessage): Boolean;      //Ответ авторизации на версию УСПД  5.2, 5.3
    procedure CreateUnknowNakReq;
    procedure CreateDataReq(adrToRead: integer; DateBeg, DateEnd: TDateTime; is25Hour: boolean); overload;
    function CRCEx(var buf: array of byte; cnt: byte): boolean;
    procedure CreateSumEnReq;
    procedure CreateNakEnDayReq;
    procedure CreateNakEnMonReq;
    procedure CreateSresEnReq;
    procedure CreateReadTimeReq;
    procedure CreateCorrTimeReq;
    procedure CreateDateTimeReq;
    procedure CreateDataReq; overload;
    procedure SendMessageToMeter;
    procedure HandQryRoutine(var pMsg: CMessage);
    procedure MsgHead(var pMsg: CHMessage; Size: byte);
    procedure OnFinHandQryRoutine(var pMsg: CMessage);
    procedure OnEnterAction;
    procedure OnFinalAction;
    procedure OnConnectComplette(var pMsg: CMessage); override;
    procedure OnDisconnectComplette(var pMsg: CMessage); override;
    function GetCommand(byCommand: Byte): Integer;
    function CRC(var buf: array of byte; cnt: integer): boolean;
    procedure EncodeStrToBufArr(var str: string; var buf: array of byte; var nCount: integer);
    function GetStringFromFile(FileName: string; nStr: integer): string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

const
  ST_164_CLOSE_AUTOR = 0;
  ST_164_PRE_AUTOR_0 = 1;
  ST_164_PRE_AUTOR_1 = 2;
  ST_164_PRE_AUTOR_2 = 3;
  ST_164_PRE_AUTOR_3 = 4;
  ST_164_AUTORIZATION = 5;
  ST_164_UNKNOWN_NAK_REQ = 6;
  ST_164_REQUEST = 7;
  ST_164_READ_TIME = 0;
  ST_164_CORR_TIME = 1;
  ST_CURR_USER = 'ADMIN';
  ST_CURR_PASS = '333333';

const
  CRCHI164: array[0..255] of byte = ($00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $22, $00, $C1, $81,
    $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01,
    $C0, $80, $41, $00, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40, $00, $C1, $81, $40, $01, $C0, $80, $41, $00, $C1, $81, $40, $01, $C0, $80, $41, $01, $C0, $80, $41, $00, $C1, $81, $40);

const
  CRCLO164: array[0..255] of byte = ($00, $C0, $C1, $01, $C3, $03, $02, $C2, $C6, $06, $07, $C7, $05, $C5, $C4, $04, $CC, $0C, $0D, $CD, $0F, $CF, $CE, $0E, $0A, $CA, $CB, $0B, $C9, $09, $08, $C8, $D8, $18, $19, $D9, $1B, $DB, $DA, $1A, $1E, $DE, $DF, $1F, $DD, $1D, $1C, $DC, $14, $D4, $D5, $15, $D7, $17, $16, $D6, $D2, $12, $13, $D3, $11, $D1, $D0, $10, $F0, $30, $31, $F1, $33, $F3, $F2, $32, $36, $F6, $F7, $37, $F5, $35, $34, $F4, $3C, $FC, $FD, $3D, $FF, $3F, $3E, $FE, $FA, $3A, $3B, $FB, $39, $F9, $F8,
    $38, $28, $E8, $E9, $29, $EB, $2B, $2A, $EA, $EE, $2E, $2F, $EF, $2D, $ED, $EC, $2C, $E4, $24, $25, $E5, $27, $E7, $E6, $26, $22, $E2, $E3, $23, $E1, $21, $20, $E0, $A0, $60, $61, $A1, $63, $A3, $A2, $62, $66, $A6, $A7, $67, $A5, $65, $64, $A4, $6C, $AC, $AD, $6D, $AF, $6F, $6E, $AE, $AA, $6A, $6B, $AB, $69, $A9, $A8, $68, $78, $B8, $B9, $79, $BB, $7B, $7A, $BA, $BE, $7E, $7F, $BF, $7D, $BD, $BC, $7C, $B4, $74, $75, $B5, $77, $B7, $B6, $76, $72, $B2, $B3, $73, $B1, $71, $70, $B0, $50, $90, $91, $51, $93,
    $53, $52, $92, $96, $56, $57, $97, $55, $95, $94, $54, $9C, $5C, $5D, $9D, $5F, $9F, $9E, $5E, $5A, $9A, $9B, $5B, $99, $59, $58, $98, $88, $48, $49, $89, $4B, $8B, $8A, $4A, $4E, $8E, $8F, $4F, $8D, $4D, $4C, $8C, $44, $84, $85, $45, $87, $47, $46, $86, $82, $42, $43, $83, $41, $81, $80, $40);

implementation

constructor CUSPD16401BMeter.Create;
begin
  New(PnReq);
end;

destructor CUSPD16401BMeter.Destroy;
begin

//    Finalize(nReq);
//    FillChar(nReq, SizeOf(CQueryPrimitive), 0);
//
//    Finalize(advInfo);
//    FillChar(advInfo, SizeOf(SL2TAGADVSTRUCT), 0);
//  Dispose(PnReq);
  inherited;
end;

procedure CUSPD16401BMeter.AddNakEnergyDayGraphQry(dt_Date1, dt_Date2: TDateTime);
var
  TempDate: TDateTime;
  year, month, day: word;
  i: integer;
begin
  if (cDateTimeR.CompareDay(dt_Date2, Now) = 1) then
    dt_Date2 := Now;

  for i := trunc(dt_Date1) to trunc(dt_Date2) do
  begin
    DecodeDate(i, year, month, day);
    m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, year, month, day, 1);
  end;
end;

procedure CUSPD16401BMeter.AddNakEnergyMonthGraphQry(dt_Date1, dt_Date2: TDateTime);
var
  TempDate: TDateTime;
  year, month, day: word;
  i: integer;
begin
     //while dt_Date1 < dt_Date2 do
  while (dt_Date1 <= dt_Date2) and (dt_Date1 <= Now) do
  begin
    DecodeDate(dt_Date1, year, month, day);
    m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, year, month, day, 1);
    cDateTimeR.IncMonth(dt_Date1);
  end
end;

procedure CUSPD16401BMeter.AddEnergySresGraphQry(dt_Date1, dt_Date2: TDateTime);
var
  TempDate: TDateTime;
  i, j, maxSl: integer;
  year, month, day: word;
begin
  for i := trunc(dt_Date1) to trunc(dt_Date2) do
  begin
    DecodeDate(i, year, month, day);
    if i = trunc(Now) then
      maxSl := trunc(frac(Now) / EncodeTime(0, 30, 0, 0) - 1)
    else
      maxSl := 47;
    for j := 0 to maxSl do
      m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, year, month, (day shl 8) + j, 1);
  end;
end;

procedure CUSPD16401BMeter.InitMeter(var pL2: SL2TAG);
var
  slv: TStringList;
begin
  m_nCounter := 0;
  m_nCounter1 := 0;
  IsUpdate := 0;
  GetVer := 0;
   //mCntrlInd  := 0;
  SetHandScenario;
  SetHandScenarioGraph;
   //mCurrState := ST_164_PRE_AUTOR_0;
   //mCurrState := ST_164_AUTORIZATION;
  mCurrState := ST_164_REQUEST;
  mTimeDir := ST_164_READ_TIME;

  slv := TStringList.Create;
  getStrings(m_nP.m_sAdvDiscL2Tag, slv);
  if slv[0] = '' then
    slv[0] := '0';
  if slv[2] = '' then
    slv[2] := '0';
  advInfo.m_sKoncFubNum := slv[0];
  advInfo.m_sKoncPassw := slv[1];
  advInfo.m_sAdrToRead := slv[2];
  mCntrlInd := LO(StrToInt(m_nP.m_sddPHAddres)); //(StrToInt(advInfo.m_sAdrToRead) and $03)+1;
  slv.Clear;
  FreeAndNil(slv); //slv.Destroy;
end;

procedure CUSPD16401BMeter.MsgHead(var pMsg: CHMessage; Size: byte);
begin
  pMsg.m_swLen := Size;             //pMsg.m_sbyInfo[] :=
  pMsg.m_swObjID := m_nP.m_swMID;     //Сетевой адрес счётчика
  pMsg.m_sbyFrom := DIR_L2TOL1;
  pMsg.m_sbyFor := DIR_L2TOL1;       //DIR_L2toL1
  pMsg.m_sbyType := PH_DATARD_REQ;    //PH_DATARD_REC
  pMsg.m_sbyIntID := m_nP.m_sbyPortID;
  pMsg.m_sbyServerID := MET_USPD16401B;         //Указать тип счетчика
  pMsg.m_sbyDirID := m_nP.m_sbyPortID;
end;

procedure CUSPD16401BMeter.SetCurrQry;
begin
  with m_nObserver do
  begin
    ClearCurrQry;
    AddCurrParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
    AddCurrParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
    AddCurrParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
    AddCurrParam(QRY_ENERGY_SUM_EP, 0, 4, 0, 1);
    AddCurrParam(QRY_ENERGY_DAY_EP, 0, 1, 0, 1);
    AddCurrParam(QRY_ENERGY_DAY_EP, 0, 2, 0, 1);
    AddCurrParam(QRY_ENERGY_DAY_EP, 0, 3, 0, 1);
    AddCurrParam(QRY_ENERGY_DAY_EP, 0, 4, 0, 1);
    AddCurrParam(QRY_ENERGY_MON_EP, 0, 1, 0, 1);
    AddCurrParam(QRY_ENERGY_MON_EP, 0, 2, 0, 1);
    AddCurrParam(QRY_ENERGY_MON_EP, 0, 3, 0, 1);
    AddCurrParam(QRY_ENERGY_MON_EP, 0, 4, 0, 1);
    AddCurrParam(QRY_E3MIN_POW_EP, 0, 0, 0, 1);
    AddCurrParam(QRY_E30MIN_POW_EP, 0, 0, 0, 1);
    AddCurrParam(QRY_MGAKT_POW_S, 0, 0, 0, 1);
    AddCurrParam(QRY_MGREA_POW_S, 0, 0, 0, 1);
    AddCurrParam(QRY_U_PARAM_A, 0, 0, 0, 1);
    AddCurrParam(QRY_I_PARAM_A, 0, 0, 0, 1);
    AddCurrParam(QRY_KOEF_POW_A, 0, 0, 0, 1);
    AddCurrParam(QRY_FREQ_NET, 0, 0, 0, 1);
    AddCurrParam(QRY_KPRTEL_KPR, 0, 0, 0, 1);
    AddCurrParam(QRY_DATA_TIME, 0, 0, 0, 1);
    AddCurrParam(QRY_SRES_ENR_EP, 0, 0, 0, 1);
    AddCurrParam(QRY_NAK_EN_DAY_EP, 0, 1, 0, 1);
    AddCurrParam(QRY_NAK_EN_DAY_EP, 0, 2, 0, 1);
    AddCurrParam(QRY_NAK_EN_DAY_EP, 0, 3, 0, 1);
    AddCurrParam(QRY_NAK_EN_DAY_EP, 0, 4, 0, 1);
    AddCurrParam(QRY_NAK_EN_MONTH_EP, 0, 1, 0, 1);
    AddCurrParam(QRY_NAK_EN_MONTH_EP, 0, 2, 0, 1);
    AddCurrParam(QRY_NAK_EN_MONTH_EP, 0, 3, 0, 1);
    AddCurrParam(QRY_NAK_EN_MONTH_EP, 0, 4, 0, 1);
  end;
end;

procedure CUSPD16401BMeter.SetGraphQry;
begin

end;
//CreateOutMSG(param : double;          -значение параметра
//                sm : byte;            -тип параметра
//                tar : byte;           -тариф
//                Date : TDateTime      -дата ответа

procedure CUSPD16401BMeter.CreateOutMSG(param: double; sm: byte; tar: byte; Date: TDateTime);
var
  Year, Month, Day, Hour, Min, Sec, ms: word;
begin                         //sm - вид энергии; tar - тарифф
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Date, Hour, Min, Sec, ms);
  m_nRxMsg.m_sbyServerID := 0;
  m_nRxMsg.m_sbyType := DL_DATARD_IND;
  m_nRxMsg.m_sbyFor := DIR_L2TOL3;
  m_nRxMsg.m_swObjID := m_nP.m_swMID;
  m_nRxMsg.m_swLen := 13 + 9 + sizeof(double);
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
  m_nRxMsg.m_sbyDirID := Byte(IsUpdate);
end;

function CUSPD16401BMeter.ReadCloseAutorAns(var pMsg: CMessage): boolean;
begin
  Result := false;
  mCurrState := ST_164_AUTORIZATION;
end;

function CUSPD16401BMeter.ReadPreAutor0Req(var pMsg: CMessage): boolean;
begin
  Result := false;
  mCurrState := ST_164_PRE_AUTOR_1;
end;

function CUSPD16401BMeter.ReadPreAutor1Req(var pMsg: CMessage): boolean;
begin
  Result := false;
  mCurrState := ST_164_PRE_AUTOR_2;
end;

function CUSPD16401BMeter.ReadPreAutor2Req(var pMsg: CMessage): boolean;
begin
  Result := false;
  mCurrState := ST_164_PRE_AUTOR_3;
end;

function CUSPD16401BMeter.ReadPreAutor3Req(var pMsg: CMessage): boolean;
begin
  Result := false;
  mCurrState := ST_164_AUTORIZATION;
end;

function CUSPD16401BMeter.ReadAutorAns(var pMsg: CMessage): boolean;
begin
  Result := false;
  if (nReq.m_swParamID = QRY_ENERGY_SUM_EP) then
    mCurrState := ST_164_UNKNOWN_NAK_REQ
  else
    mCurrState := ST_164_REQUEST;
end;

function CUSPD16401BMeter.ReadUnknownNakAns(var pMsg: CMessage): boolean;
begin
  mCurrState := ST_164_REQUEST;
  Result := false;
end;

function CUSPD16401BMeter.ReadSumEnAns(var pMsg: CMessage): boolean;
var
  i, dost: integer;
  val: double;
  val_i: int64;
begin
  Result := False;
  if (pMsg.m_sbyInfo[2] <> $1D) then
  begin
    if pMsg.m_sbyInfo[2] = $01 then
    begin
      m_nT.B2 := False;
      Result := True;
    end;
    exit;
  end;
  // dost := 0;
  // move(pMsg.m_sbyInfo[29], dost, 3);
  dost := pMsg.m_sbyInfo[29] and $0F;
  if not (dost in [0, 3, 6]) then
  begin
    m_nT.B2 := False;
    Result := True;
    Exit;
  end;

  for i := 0 to 4 do
  begin
    val_i := 0;
    move(pMsg.m_sbyInfo[4 + i * 5], val_i, 5);
    val := val_i / 10000;
     //if (dost and ($F shl i)) = 0 then
     //begin
    CreateOutMSG(val, QRY_ENERGY_SUM_EP, i, Now);
    saveToDB(m_nRxMsg);
     //end;
  end;
  Result := true;
end;

function CUSPD16401BMeter.ReadNakEnDayAns(var pMsg: CMessage): boolean;
var
  i, dost: integer;
  val: double;
  val_i: int64;
  date: TDateTime;
begin
  Result := false;
  if (pMsg.m_sbyInfo[2] <> $1D) then
  begin
     //FinalAction;
    if pMsg.m_sbyInfo[2] = $01 then
    begin
      m_nT.B2 := False;
      Result := True;
    end;
    exit;
  end;
  // dost := 0;
  // move(pMsg.m_sbyInfo[29], dost, 3);

  dost := pMsg.m_sbyInfo[29] and $0F;
  if not (dost in [0, 3, 6]) then
  begin
    m_nT.B2 := False;
    Result := True;
    Exit;
  end;

  for i := 0 to 4 do
  begin
    val_i := 0;
    move(pMsg.m_sbyInfo[4 + i * 5], val_i, 5);
    if val_i = $FFFFFFFFFF then
      continue;
    val := val_i / 10000;
     //if (dost and ($F shl i)) = 0 then
     //begin
    date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
    CreateOutMSG(val, QRY_NAK_EN_DAY_EP, i, date);
    saveToDB(m_nRxMsg);
    Result := true;
     //end;
  end;
end;

function CUSPD16401BMeter.ReadNakEnMonAns(var pMsg: CMessage): boolean;
var
  i: integer;
  val: double;
  val_i: int64;
  date: TDateTime;
  dost: byte;
begin
  Result := false;
  if (pMsg.m_sbyInfo[2] <> $1D) then
  begin
    if pMsg.m_sbyInfo[2] = $01 then
    begin
      m_nT.B2 := False;
      Result := True;
    end;
    exit;
  end;

  dost := pMsg.m_sbyInfo[29] and $0F;
  if not (dost in [0, 3, 6]) then
  begin
    m_nT.B2 := False;
    Result := True;
    Exit;
  end;

  for i := 0 to 4 do
  begin
    val_i := 0;
    move(pMsg.m_sbyInfo[4 + i * 5], val_i, 5);
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nP.M_SWABOID)+') Val_i='+FloatToStr(val_i)+ 'FF ='+FloatToStr($FFFFFFFFFF));
    if val_i = $FFFFFFFFFF then
    begin
      Result := True;
      Continue;
    end;
//     begin
//       m_nT.B2 := False;
//       Result := True;
//       Exit;
//     end;

    date := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
    val := val_i / 10000;
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nP.M_SWABOID)+') AutoLoad DTBEGIN:'+DateTimeToStr(date)+' tarif='+IntToStr(i)+ ' ReadNakEnMonAns Val_i='+FloatToStr(val_i) +' Val=Val_i/10000: '+FloatToStr(val));
    CreateOutMSG(val, QRY_NAK_EN_MONTH_EP, i, date);
    saveToDB(m_nRxMsg);
    Result := true;
  end;

  m_nT.B2 := Result;
end;

function CUSPD16401BMeter.ReadSresEnAns(var pMsg: CMessage): boolean;
var
  val: double;
  val_i, slN: int64;
  dateToRead: TDateTime;
begin
  if (pMsg.m_sbyInfo[2] <> $06) then
  begin
    Result := False;
    exit;
  end;

  val_i := 0;
  move(pMsg.m_sbyInfo[4], val_i, 4);
  val := val_i / 10000;

  slN := nReq.m_swSpecc2 and $FF;
  dateToRead := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, (nReq.m_swSpecc2 and $FFFFFF00) shr 8) + EncodeTime(slN div 2, (slN mod 2) * 30, 0, 0);
  CreateOutMSG(val, QRY_NAK_EN_MONTH_EP, 0, dateToRead);
  if (pMsg.m_sbyInfo[8] >= 1) and (pMsg.m_sbyInfo[8] <= 15) then
    m_nRxMsg.m_sbyServerID := slN or $80
  else
    m_nRxMsg.m_sbyServerID := slN;
  saveToDB(m_nRxMsg);
  Result := true;
end;

function CUSPD16401BMeter.ReadTimeAns(var pMsg: CMessage): boolean;
var
  dateRead: TDateTime;
  Hour, Min, Sek, Msek: word;
  _yy, _mn, _dd, _hh, _mm, _ss: word;
begin
  Result := true;
  if (pMsg.m_sbyInfo[2] <> $08) then
  begin
    exit;
  end;
  try
    dateRead := EncodeDate(pMsg.m_sbyInfo[9] + pMsg.m_sbyInfo[10] * $100, pMsg.m_sbyInfo[8], pMsg.m_sbyInfo[7]) + EncodeTime(pMsg.m_sbyInfo[6], pMsg.m_sbyInfo[5], pMsg.m_sbyInfo[4], 0);
    _yy := pMsg.m_sbyInfo[9] + pMsg.m_sbyInfo[10] * $100;
    _mn := (pMsg.m_sbyInfo[8]);
    _dd := (pMsg.m_sbyInfo[7]);
    _hh := (pMsg.m_sbyInfo[6]);
    _mm := (pMsg.m_sbyInfo[5]);
    _ss := (pMsg.m_sbyInfo[4]);
    DecodeTime(Now, Hour, Min, Sek, Msek);
  except
    dateRead := Now;
  end;
  if EventBox <> Nil then
    EventBox.FixEvents(ET_CRITICAL, 'Разница по времени состовляет -> ' + TimeToStr(abs(EncodeTime(_hh, _mm, _ss, 0) - EncodeTime(Hour, Min, Sek, 0))));
     //if abs(dateRead - Now) > EncodeTime(0, 0, 15, 0) then
  if (abs(EncodeTime(_hh, _mm, _ss, 0) - EncodeTime(Hour, Min, Sek, 0)) > EncodeTime(0, 0, 15, 0)) then
  begin
    mTimeDir := ST_164_CORR_TIME;
    m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);  //заносим в спеки параметры для определения типа запроса(на разъем или на счетчики)
    Result := true;
  end
  else
  begin
    mTimeDir := ST_164_READ_TIME; //потом убрать
    m_nObserver.ClearGraphQry; //Очищаем буфер команд
    Result := true;
  end;
end;

(*******************************************************************************
 * Ответ "Записи времени и даты"
 *******************************************************************************)
function CUSPD16401BMeter.RES0120_CorTimeRes(var pMsg: CMessage): Boolean;
var
  _yy, _mn, _dd, _hh, _mm, _ss: word;
  ReadDate: TDateTime;
begin
  _yy := (pMsg.m_sbyInfo[15]) + (pMsg.m_sbyInfo[16] * $100);
  _mn := (pMsg.m_sbyInfo[14]);
  _dd := (pMsg.m_sbyInfo[13]);
  _hh := (pMsg.m_sbyInfo[12]);
  _mm := (pMsg.m_sbyInfo[11]);
  _ss := (pMsg.m_sbyInfo[10]);
  ReadDate := EncodeDate(_yy, _mn, _dd) + EncodeTime(_hh, _mm, _ss, 0);
  if EventBox <> Nil then
    EventBox.FixEvents(ET_CRITICAL, 'Разница по времени после корректировки состовляет -> ' + TimeToStr(abs(ReadDate - Now)));
  Result := True;
end;

function CUSPD16401BMeter.ReadDateTimeAns(var pMsg: CMessage): boolean;
begin
  Result := true;
  case mTimeDir of
    ST_164_READ_TIME:
      Result := ReadTimeAns(pMsg);
    ST_164_CORR_TIME:
      begin
        Result := RES0120_CorTimeRes(pMsg);
        mTimeDir := ST_164_READ_TIME;
      end;
  else
    begin
      mTimeDir := ST_164_READ_TIME;
    end;
  end;
end;

function CUSPD16401BMeter.ReadConveer(var pMsg: CMessage): boolean;
type
  TMsgState = (msNone, msBegin, msLength, msData, msCRC1, msCRC2);
var
  i, vLen: Integer;
  idxBegin, idxEnd: Integer;
  currByte: Byte;
  msgState: TMsgState;
  isOurMsg: boolean;
  vMsg: array[0..63] of byte;
begin
  Result := False;
  msgState := msNone;
  idxBegin := 0;
  idxEnd := 0;
  isOurMsg := False;

  vLen := pMsg.m_swLen - 13;
  if vLen > SizeOf(pMsg.m_sbyInfo) then
    Exit;

  i := 0;
  while i < vLen do
  begin
    currByte := pMsg.m_sbyInfo[i];
    case msgState of
      msNone:
        begin
          if currByte = $14 then
          begin
            msgState := msBegin;
            isOurMsg := False;
            idxBegin := i - 1;
          end;
        end;
      msBegin:
        begin
          msgState := msLength;
          idxEnd := i + currByte;
        end;
      msLength:
        begin
          if i < idxEnd then
            msgState := msData
          else
            msgState := msCRC1;
          if mCntrlInd = currByte then
          begin
            isOurMsg := True;
          end;
        end;
      msData:
        begin
          if i < idxEnd then

          else
            msgState := msCRC1;
        end;
      msCRC1:
        begin
          msgState := msCRC2;
        end;
      msCRC2:
        begin
          msgState := msNone;
          if isOurMsg then
            break;
        end;
    end;
    Inc(i);
  end;

  if not isOurMsg then
    Exit;

  vLen := idxEnd - idxBegin + 3;
  if vLen > sizeOf(vMsg) then
    Exit;
  if idxBegin > Pred(sizeOf(pMsg.m_sbyInfo)) then
    Exit;

  move(pMsg.m_sbyInfo[idxBegin], vMsg, vLen);
  fillchar(pMsg.m_sbyInfo, sizeOf(pMsg.m_sbyInfo), 0);
  move(vMsg, pMsg.m_sbyInfo, vLen);
  pMsg.m_swLen := 13 + vLen;

  Result := True;
end;

function CUSPD16401BMeter.ReadDataAns(var pMsg: CMessage): boolean;
begin
  case nReq.m_swParamID of
    QRY_AUTORIZATION:
      begin
        if nReq.m_swSpecc0 = 1 then
          Result := ReadVersionInfo(pMsg, GetVer)      //Ответ авторизации
        else if GetVer = 1 then
          Result := ReadAutoReq_2_4(pMsg)   //Ответ авторизации на версию УСПД  2.3, 3.3, 4.2, 4.3, 4.4
        else if GetVer = 2 then
          Result := ReadAutoReq_5(pMsg)    //Ответ авторизации на версию УСПД  5.2, 5.3
        else if GetVer = 0 then
        begin
//                                     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка! Не поддерживаемая версия или ошибка в ответе на запрос');
          m_nObserver.ClearGraphQry; //Очищаем буфер команд
          Result := True;
        end;
      end;
    QRY_ENERGY_SUM_EP:
      Result := ReadSumEnAns(pMsg);    //Ответ текущих показаний
    QRY_NAK_EN_DAY_EP:
      Result := ReadNakEnDayAns(pMsg); //Ответ показаний на начало суток
    QRY_NAK_EN_MONTH_EP:
      Result := ReadNakEnMonAns(pMsg); //Ответ показаний на начало месяца
    QRY_SRES_ENR_EP:
      Result := ReadSresEnAns(pMsg);   //Ответ 30 мин
    QRY_DATA_TIME:
      Result := ReadDateTimeAns(pMsg); //Ответ чтения и коррекции времени
  else
    begin
      Result := true;
    end;
  end;
end;

function CUSPD16401BMeter.ReadAnswer(var pMsg: CMessage): boolean;
var
  cannel: word;
  cannelP: word;
  k: integer;
begin
  Result := False;

  if mCurrState = ST_164_REQUEST then
    if (nReq.m_swParamID = QRY_AUTORIZATION) then
    begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Команда авторизации');
    end
    else if not ReadConveer(pMsg) then
    begin
      Exit;
    end;

  if not CRC(pMsg.m_sbyInfo[0], pMsg.m_sbyInfo[2] + 3) then
  begin
    exit;
  end;

  case mCurrState of
    ST_164_CLOSE_AUTOR:
      Result := ReadCloseAutorAns(pMsg);
    ST_164_PRE_AUTOR_0:
      Result := ReadPreAutor0Req(pMsg);
    ST_164_PRE_AUTOR_1:
      Result := ReadPreAutor1Req(pMsg);
    ST_164_PRE_AUTOR_2:
      Result := ReadPreAutor2Req(pMsg);
    ST_164_PRE_AUTOR_3:
      Result := ReadPreAutor3Req(pMsg);
    ST_164_AUTORIZATION:
      Result := ReadAutorAns(pMsg);
    ST_164_UNKNOWN_NAK_REQ:
      Result := ReadUnknownNakAns(pMsg);
    ST_164_REQUEST:
      Result := ReadDataAns(pMsg);
  end;
end;

procedure CUSPD16401BMeter.CreateCloseAutorReq;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := $15;
  m_nTxMsg.m_sbyInfo[2] := $0B;
  m_nTxMsg.m_sbyInfo[3] := mCntrlInd;
  m_nTxMsg.m_sbyInfo[4] := $00;
  m_nTxMsg.m_sbyInfo[5] := $00;
  m_nTxMsg.m_sbyInfo[6] := $03;
  m_nTxMsg.m_sbyInfo[7] := $EE;
  m_nTxMsg.m_sbyInfo[8] := $00;
  m_nTxMsg.m_sbyInfo[9] := $04;
  m_nTxMsg.m_sbyInfo[10] := $65;
  m_nTxMsg.m_sbyInfo[11] := $25;
  m_nTxMsg.m_sbyInfo[12] := $60;
  m_nTxMsg.m_sbyInfo[13] := $1D;
  CRC(m_nTxMsg.m_sbyInfo[0], 14);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreatePreAutor0Req;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := 20;
  m_nTxMsg.m_sbyInfo[2] := 7;
  m_nTxMsg.m_sbyInfo[3] := 1;
  m_nTxMsg.m_sbyInfo[4] := 0;
  m_nTxMsg.m_sbyInfo[5] := 0;
  m_nTxMsg.m_sbyInfo[6] := 0;
  m_nTxMsg.m_sbyInfo[7] := 14;
  m_nTxMsg.m_sbyInfo[8] := 0;
  m_nTxMsg.m_sbyInfo[9] := 1;
  m_nTxMsg.m_sbyInfo[10] := 231;
  m_nTxMsg.m_sbyInfo[11] := 47;
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreatePreAutor1Req;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := 20;
  m_nTxMsg.m_sbyInfo[2] := 7;
  m_nTxMsg.m_sbyInfo[3] := 2;
  m_nTxMsg.m_sbyInfo[4] := 0;
  m_nTxMsg.m_sbyInfo[5] := 0;
  m_nTxMsg.m_sbyInfo[6] := 0;
  m_nTxMsg.m_sbyInfo[7] := 15;
  m_nTxMsg.m_sbyInfo[8] := 0;
  m_nTxMsg.m_sbyInfo[9] := 5;
  m_nTxMsg.m_sbyInfo[10] := 228;
  m_nTxMsg.m_sbyInfo[11] := 76;
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreatePreAutor2Req;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := 20;
  m_nTxMsg.m_sbyInfo[2] := 7;
  m_nTxMsg.m_sbyInfo[3] := 3;
  m_nTxMsg.m_sbyInfo[4] := 0;
  m_nTxMsg.m_sbyInfo[5] := 0;
  m_nTxMsg.m_sbyInfo[6] := 0;
  m_nTxMsg.m_sbyInfo[7] := 194;
  m_nTxMsg.m_sbyInfo[8] := 0;
  m_nTxMsg.m_sbyInfo[9] := 6;
  m_nTxMsg.m_sbyInfo[10] := 218;
  m_nTxMsg.m_sbyInfo[11] := 141;
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreatePreAutor3Req;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := 20;
  m_nTxMsg.m_sbyInfo[2] := 7;
  m_nTxMsg.m_sbyInfo[3] := 4;
  m_nTxMsg.m_sbyInfo[4] := 0;
  m_nTxMsg.m_sbyInfo[5] := 0;
  m_nTxMsg.m_sbyInfo[6] := 0;
  m_nTxMsg.m_sbyInfo[7] := 4;
  m_nTxMsg.m_sbyInfo[8] := 0;
  m_nTxMsg.m_sbyInfo[9] := 10;
  m_nTxMsg.m_sbyInfo[10] := 34;
  m_nTxMsg.m_sbyInfo[11] := 27;
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;
{****************************
  Запрос команды авторизации
*****************************}

procedure CUSPD16401BMeter.CreateAutorReq;
begin
  if (GetVer = 1) then
  begin
    m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
    m_nTxMsg.m_sbyInfo[1] := $15;  //Код команды записи
    m_nTxMsg.m_sbyInfo[2] := $35;  //Длина данных в команде
    m_nTxMsg.m_sbyInfo[3] := mCntrlInd;  //Контрольный индекс
    m_nTxMsg.m_sbyInfo[4] := $00;  //{ в сумме 2 байта Константа. Первым – старший байт.
    m_nTxMsg.m_sbyInfo[5] := $00;  //  Константа. Первым – старший байт. }
    m_nTxMsg.m_sbyInfo[6] := $03;  //{ в сумме 2 байта Константа. Первым – старший байт.
    m_nTxMsg.m_sbyInfo[7] := $C0;  //Константа. Первым – старший байт.}
    m_nTxMsg.m_sbyInfo[8] := $00;  //{ в сумме 2 байта Константа. Первым – старший байт.
    m_nTxMsg.m_sbyInfo[9] := $2E;  //Константа. Первым – старший байт.}
    FillChar(m_nTxMsg.m_sbyInfo[10], 21, 0);
    move(ST_CURR_USER[1], m_nTxMsg.m_sbyInfo[10], Length(ST_CURR_USER));  //Имя пользователя – строка, завершающаяся нулевым байтом. Первым передается первый байт строки.
    FillChar(m_nTxMsg.m_sbyInfo[31], 21, 0);
    move(ST_CURR_PASS[1], m_nTxMsg.m_sbyInfo[31], Length(ST_CURR_PASS)); //Пароль - строка, завершающаяся нулевым байтом. Первым передается первый байт строки.
    m_nTxMsg.m_sbyInfo[52] := $0f; //Таймаут неактивности канала доступа в
    m_nTxMsg.m_sbyInfo[53] := $27; //секундах. Не рекомендуется держать открытым
    m_nTxMsg.m_sbyInfo[54] := $00; //канал без необходимости продолжительное
    m_nTxMsg.m_sbyInfo[55] := $00; //время. Первым передается младший байт.
    CRC(m_nTxMsg.m_sbyInfo[0], 56);
    MsgHead(m_nTxMsg, 13 + 58);
    SendToL1(BOX_L1, @m_nTxMsg);
  end
  else if GetVer = 2 then
    if EventBox <> Nil then
      EventBox.FixEvents(ET_CRITICAL, 'Данна команда авторизации не реализована!!!');
end;

{****************************
  Ответ команды авторизации
*****************************}
function CUSPD16401BMeter.ReadAutoReq_2_4(var pMsg: CMessage): Boolean; //Ответ авторизации
  {
Смещение Размер,  Допустимые   Назначение
          байт    значения
  0        1       1-253       Адрес УСПД
  1        1       0x15        Код команды записи
  2        1        2          Длина данных в ответе
  3        1      1-255        Контрольный индекс
  4        1      0x00– 0x03   Код подтверждения открытия доступа: 0 – нет  доступа, 1 – пользователь, 2 – оператор, 3 -  администратор
  5        2  Контрольный код. Первым передается младший  байт.
  }

var
  CodeAccess: Byte; //Проверка код доступа
begin
  try
    CodeAccess := 0; //по умолчанию нет доступа
    CodeAccess := (pMsg.m_sbyInfo[4]);
    if EventBox <> Nil then
      EventBox.FixEvents(ET_CRITICAL, 'Код доступа -> ' + IntToStr(CodeAccess));
    if (CodeAccess = 0) then
    begin
      if EventBox <> Nil then
        EventBox.FixEvents(ET_CRITICAL, 'Ошибка при авторизации');
      m_nObserver.ClearGraphQry; //Очищаем буфер команд
    end;
  except
    if EventBox <> Nil then
      EventBox.FixEvents(ET_CRITICAL, 'Ошибка при авторизации');
    m_nObserver.ClearGraphQry; //Очищаем буфер команд
    Result := True;
  end;
  Result := True;
end;

function CUSPD16401BMeter.ReadAutoReq_5(var pMsg: CMessage): Boolean; //Ответ авторизации
  {
Смещение Размер,  Допустимые   Назначение
          байт    значения
  0        1       1-253       Адрес УСПД
  1        1       0x15        Код команды записи
  2        1        2          Длина данных в ответе
  3        1      1-255        Контрольный индекс
  4        1      0x00– 0x03   Код подтверждения открытия доступа: 0 – нет  доступа, 1 – пользователь, 2 – оператор, 3 -  администратор
  5        2  Контрольный код. Первым передается младший  байт.
  }

var
  CodeAccess: Byte; //Проверка код доступа
begin
  try
    CodeAccess := 0; //по умолчанию нет доступа
    CodeAccess := (pMsg.m_sbyInfo[4]);
    if EventBox <> Nil then
      EventBox.FixEvents(ET_CRITICAL, 'Код доступа -> ' + IntToStr(CodeAccess));
    if (CodeAccess = 0) then
    begin
      if EventBox <> Nil then
        EventBox.FixEvents(ET_CRITICAL, 'Ошибка при авторизации');
      m_nObserver.ClearGraphQry; //Очищаем буфер команд
    end;
  except
    if EventBox <> Nil then
      EventBox.FixEvents(ET_CRITICAL, 'Ошибка при авторизации');
    m_nObserver.ClearGraphQry; //Очищаем буфер команд
    Result := True;
  end;
  Result := True;
end;

{****************************
  Запрос версии УСПД
*****************************}
procedure CUSPD16401BMeter.CreateVersionInfo;
{
Смещение Размер, Допустимые  Назначение
          байт    значения
   0       1       1-253     Адрес УСПД
   1       1       0x14      Код команды чтения
   2       1        7        Длина данных в команде
   3       1      1-255      Контрольный индекс команды
   4       2      0x0000     Константа. Первым – старший байт.
   6       2      0x000F     Константа. Первым – старший байт.
   8       2      0x0005     Константа. Первым – старший байт.
   10      2     Контрольный Первым передается младший байт.
                  код.
}
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := $14;  //Код команды записи
  m_nTxMsg.m_sbyInfo[2] := $07;  //Длина данных в команде
  m_nTxMsg.m_sbyInfo[3] := mCntrlInd;  //Контрольный индекс
  m_nTxMsg.m_sbyInfo[4] := $00;  //{ в сумме 2 байта Константа. Первым – старший байт.
  m_nTxMsg.m_sbyInfo[5] := $00;  //  Константа. Первым – старший байт. }
  m_nTxMsg.m_sbyInfo[6] := $00;  //{ в сумме 2 байта Константа. Первым – старший байт.
  m_nTxMsg.m_sbyInfo[7] := $0F;  //Константа. Первым – старший байт.}
  m_nTxMsg.m_sbyInfo[8] := $00;  //{ в сумме 2 байта Константа. Первым – старший байт.
  m_nTxMsg.m_sbyInfo[9] := $05;  //Константа. Первым – старший байт.}
  CRC(m_nTxMsg.m_sbyInfo[0], 10);
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

{****************************
  Ответ версии УСПД
*****************************}
function CUSPD16401BMeter.ReadVersionInfo(var pMsg: CMessage; var _GetVer: Byte): Boolean; //Ответ авторизации
  {
Смещение Размер,  Допустимые   Назначение
          байт    значения
  0        1       1-253       Адрес УСПД
  1        1       0x14        Код команды записи
  2        1        6          Длина данных в ответе
  3        5        5          Аппаратная версия УСПД. Строка вида ХХ.ХХ без завершающего 0
  5        2  Контрольный код. Первым передается младший  байт.
}
var
  a: Byte;
  tempChar: char;
  testString: string;
  testVer: string;
begin
  tempChar := Chr(pMsg.m_sbyInfo[4]);
  Insert(tempChar, testString, Length(testString) + 1);
  Insert(tempChar, testVer, Length(testVer) + 1);
  tempChar := Chr(pMsg.m_sbyInfo[5]);
  Insert(tempChar, testString, Length(testString) + 1);
  Insert(tempChar, testVer, Length(testVer) + 1);
  tempChar := Chr(pMsg.m_sbyInfo[6]);
  Insert(tempChar, testString, Length(testString) + 1);
  tempChar := Chr(pMsg.m_sbyInfo[7]);
  Insert(tempChar, testString, Length(testString) + 1);
  tempChar := Chr(pMsg.m_sbyInfo[8]);
  Insert(tempChar, testString, Length(testString) + 1);
  if EventBox <> Nil then
    EventBox.FixEvents(ET_RELEASE, 'Версия УСПД -> ' + testString);
  case StrToInt(testVer) of
    2:
      begin
        if EventBox <> Nil then
          EventBox.FixEvents(ET_RELEASE, '(Используется версия авторизации для версий 2.3, 3.3, 4.2, 4.3, 4.4)');
        _GetVer := 1;
        Result := True;
      end;
    3:
      begin
        if EventBox <> Nil then
          EventBox.FixEvents(ET_RELEASE, '(Используется версия авторизации для версий 2.3, 3.3, 4.2, 4.3, 4.4)');
        _GetVer := 1;
        Result := True;
      end;
    4:
      begin
        if EventBox <> Nil then
          EventBox.FixEvents(ET_RELEASE, '(Используется версия авторизации для версий 2.3, 3.3, 4.2, 4.3, 4.4)');
        _GetVer := 1;
        Result := True;
      end;
    5:
      begin
        if EventBox <> Nil then
          EventBox.FixEvents(ET_RELEASE, '(Используется версия авторизации для версий 5.2, 5.3)');
        _GetVer := 2;
        Result := True;
      end;
  else
    begin
      if EventBox <> Nil then
        EventBox.FixEvents(ET_RELEASE, '(Ошибка в чтении версии УСПД 16401Б. Команда будет завершена)');
      m_nObserver.ClearGraphQry; //Очищаем буфер команд
      _GetVer := 0;
      Result := True;
    end;
  end;
  Result := True;
end;

procedure CUSPD16401BMeter.CreateUnknowNakReq;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := $14;
  m_nTxMsg.m_sbyInfo[2] := $07;
  m_nTxMsg.m_sbyInfo[3] := $01;
  m_nTxMsg.m_sbyInfo[4] := $00;
  m_nTxMsg.m_sbyInfo[5] := $00;
  m_nTxMsg.m_sbyInfo[6] := $01;
  m_nTxMsg.m_sbyInfo[7] := $54;
  m_nTxMsg.m_sbyInfo[8] := $00;
  m_nTxMsg.m_sbyInfo[9] := $01;
  m_nTxMsg.m_sbyInfo[10] := $08;
  m_nTxMsg.m_sbyInfo[11] := $0E;
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreateDataReq(adrToRead: integer; DateBeg, DateEnd: TDateTime; is25Hour: boolean);
var
  date2000, _1Sec: TDateTime;
  dateSec: Cardinal;
  cannel: Word;
begin
  cannel := StrToInt(advInfo.m_sAdrToRead);
  date2000 := EncodeDate(2000, 1, 1);
  _1Sec := EncodeTime(0, 0, 1, 0);
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := $14;
  m_nTxMsg.m_sbyInfo[2] := $11;
  m_nTxMsg.m_sbyInfo[3] := mCntrlInd;
  m_nTxMsg.m_sbyInfo[4] := adrToRead div $100;
  m_nTxMsg.m_sbyInfo[5] := adrToRead mod $100;
  m_nTxMsg.m_sbyInfo[6] := $00;
  m_nTxMsg.m_sbyInfo[7] := $00;
  m_nTxMsg.m_sbyInfo[8] := $00;
  m_nTxMsg.m_sbyInfo[9] := $00;
  m_nTxMsg.m_sbyInfo[10] := (cannel - 1) mod $100;
  if is25Hour then
    m_nTxMsg.m_sbyInfo[11] := (cannel - 1) div $100 + $80
  else
    m_nTxMsg.m_sbyInfo[11] := (cannel - 1) div $100;
  dateSec := Round((DateBeg - 25569) * 86400); //trunc((DateBeg - date2000) / _1Sec);
  move(dateSec, m_nTxMsg.m_sbyInfo[12], 4);
  dateSec := Round((DateEnd - 25569) * 86400); //trunc((DateEnd - date2000) / _1Sec);
  move(dateSec, m_nTxMsg.m_sbyInfo[16], 4);
  CRC(m_nTxMsg.m_sbyInfo[0], 20);
  MsgHead(m_nTxMsg, 13 + 22);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

function CUSPD16401BMeter.CRCEx(var buf: array of byte; cnt: byte): boolean;
var
  CRChiEl: byte;
  CRCloEl: byte;
  i: byte;
  cmp: byte;
  idx: byte;
begin
  Result := true;
  CRChiEl := $FF;
  CRCloEl := $FF;
  cmp := cnt - 1;
  {  if cnt >= 300 then
    begin
       Result := false;
       exit;
    end;   }
  for i := 0 to cmp do
  begin
    idx := (CRChiEl xor buf[i]) and $FF;
    CRChiEl := (CRCloEl xor CRCHI[idx]);
    CRCloEl := CRCLO[idx];
  end;
  if (CRCloEl <> buf[cnt]) and (CRChiEl <> buf[cnt + 1]) then
    Result := false;
  buf[cnt] := CRCloEl;
  buf[cnt + 1] := CRChiEl;
end;

procedure CUSPD16401BMeter.CreateSumEnReq;
var
  dateBeg, dateEnd: TDateTime;
  _30Min: TDateTime;
begin
  _30Min := EncodeTime(0, 30, 0, 0);
  dateBeg := trunc(((frac(Now) - _30Min) / _30Min)) * _30Min + trunc(Now) + EncodeTime(0, 0, 1, 0);
  dateEnd := trunc(frac(Now) / _30Min) * _30Min + trunc(Now) + EncodeTime(0, 29, 59, 0);
  CreateDataReq(9, dateBeg, dateEnd, false);
end;

procedure CUSPD16401BMeter.CreateNakEnDayReq;
var
  dateToRead: TDateTime;
  year, month, day: word;
begin
  if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
  begin
    DecodeDate(Now, year, month, day);
    nReq.m_swSpecc0 := year;
    nReq.m_swSpecc1 := month;
    nReq.m_swSpecc2 := day;
  end;
  dateToRead := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
  CreateDataReq(10, dateToRead, dateToRead + EncodeTime(23, 59, 59, 0), false);
end;

procedure CUSPD16401BMeter.CreateNakEnMonReq;
var
  dateToRead, dateToReadEnd: TDateTime;
  year, month, month_, day: word;
begin
  if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
  begin
    DecodeDate(cDateTimeR.GetBeginMonth(Now), year, month, day);
    nReq.m_swSpecc0 := year;
    nReq.m_swSpecc1 := month;
    nReq.m_swSpecc2 := day;
  end;
  dateToRead := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2);
  dateToReadEnd := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, nReq.m_swSpecc2) + EncodeTime(23, 59, 59, 0);
  // dateToReadEnd := IncMonth(dateToReadEnd, -1);

   //CreateDataReq(11, dateToReadEnd, dateToRead, false);
  CreateDataReq(11, dateToRead, dateToReadEnd, false);
   //CreateDataReq(11, dateToRead - EncodeTime(2, 59, 59, 0),dateToReadEnd, false); //dateToRead + 27, false);
end;

procedure CUSPD16401BMeter.CreateSresEnReq;
var
  dateToRead: TDateTime;
  slN: integer;
  year, month, day, hour, min, sec, ms: word;
begin
  if (nReq.m_swSpecc0 = 0) or (nReq.m_swSpecc1 = 0) or (nReq.m_swSpecc2 = 0) then
  begin
    DecodeDate(Now, year, month, day);
    DecodeTime(Now, hour, min, sec, ms);
    nReq.m_swSpecc0 := year;
    nReq.m_swSpecc1 := month;
    nReq.m_swSpecc2 := (day shl 8) or (hour * 2 + min div 30);
  end;
  slN := nReq.m_swSpecc2 and $FF;
  if (slN < 47) then
  begin
    slN := slN + 1;
    dateToRead := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, (nReq.m_swSpecc2 and $FFFFFF00) shr 8) + EncodeTime(slN div 2, (slN mod 2) * 30, 0, 0);
    CreateDataReq(12, dateToRead, dateToRead + EncodeTime(0, 29, 0, 0), false);
  end
  else
  begin
    slN := 0;
    dateToRead := EncodeDate(nReq.m_swSpecc0, nReq.m_swSpecc1, (nReq.m_swSpecc2 and $FFFFFF00) shr 8) + EncodeTime(slN div 2, (slN mod 2) * 30, 0, 0);
    CreateDataReq(12, dateToRead, dateToRead + EncodeTime(0, 29, 0, 0), true);
  end;
end;

procedure CUSPD16401BMeter.CreateReadTimeReq;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := $14;
  m_nTxMsg.m_sbyInfo[2] := $07;
  m_nTxMsg.m_sbyInfo[3] := mCntrlInd;
  m_nTxMsg.m_sbyInfo[4] := $00;
  m_nTxMsg.m_sbyInfo[5] := $00;
  m_nTxMsg.m_sbyInfo[6] := $03;
  m_nTxMsg.m_sbyInfo[7] := $27;
  m_nTxMsg.m_sbyInfo[8] := $00;
  m_nTxMsg.m_sbyInfo[9] := $07;
  CRC(m_nTxMsg.m_sbyInfo[0], 10);
  MsgHead(m_nTxMsg, 13 + 12);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreateCorrTimeReq;
var
  year, month, day, hour, min, sec, ms: word;
begin
  m_nTxMsg.m_sbyInfo[0] := StrToInt(advInfo.m_sKoncFubNum);
  m_nTxMsg.m_sbyInfo[1] := $15;
  m_nTxMsg.m_sbyInfo[2] := $0E;
  m_nTxMsg.m_sbyInfo[3] := mCntrlInd;
  m_nTxMsg.m_sbyInfo[4] := $00;
  m_nTxMsg.m_sbyInfo[5] := $00;
  m_nTxMsg.m_sbyInfo[6] := $03;
  m_nTxMsg.m_sbyInfo[7] := $27;
  m_nTxMsg.m_sbyInfo[8] := $00;
  m_nTxMsg.m_sbyInfo[9] := $07;
  DecodeDate(Now, year, month, day);
  DecodeTime(Now, hour, min, sec, ms);
  m_nTxMsg.m_sbyInfo[10] := sec;
  m_nTxMsg.m_sbyInfo[11] := min;
  m_nTxMsg.m_sbyInfo[12] := hour;
  m_nTxMsg.m_sbyInfo[13] := day;
  m_nTxMsg.m_sbyInfo[14] := month;
  m_nTxMsg.m_sbyInfo[15] := year mod $100;
  m_nTxMsg.m_sbyInfo[16] := year div $100;
  CRC(m_nTxMsg.m_sbyInfo[0], 17);
  MsgHead(m_nTxMsg, 13 + 19);
  SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CUSPD16401BMeter.CreateDateTimeReq;
begin
  case mTimeDir of
    ST_164_READ_TIME:
      CreateReadTimeReq;  //Запрос чтения времени
    ST_164_CORR_TIME:
      CreateCorrTimeReq;  //Запрос корекции времени
  end;
end;

procedure CUSPD16401BMeter.CreateDataReq;
begin
  case nReq.m_swParamID of
    QRY_AUTORIZATION:
      begin
        if nReq.m_swSpecc0 = 1 then
          CreateVersionInfo     //Запрос версии УСПД
        else
          CreateAutorReq;     //Запрос авторизации
      end;
    QRY_ENERGY_SUM_EP:
      CreateSumEnReq;     //Запрос текущих показаний
    QRY_NAK_EN_DAY_EP:
      CreateNakEnDayReq;  //Запрос показания на начало суток
    QRY_NAK_EN_MONTH_EP:
      CreateNakEnMonReq;  //Запрос показания на начало месяца
    QRY_SRES_ENR_EP:
      CreateSresEnReq;    //Запрос 30 мин
    QRY_DATA_TIME:
      CreateDateTimeReq;  //Запрос чтения и корекции времени
  end;
end;

procedure CUSPD16401BMeter.SendMessageToMeter;
begin
  case mCurrState of
    ST_164_CLOSE_AUTOR:
      CreateCloseAutorReq;
    ST_164_PRE_AUTOR_0:
      CreatePreAutor0Req;
    ST_164_PRE_AUTOR_1:
      CreatePreAutor1Req;
    ST_164_PRE_AUTOR_2:
      CreatePreAutor2Req;
    ST_164_PRE_AUTOR_3:
      CreatePreAutor3Req;
    ST_164_AUTORIZATION:
      CreateAutorReq;
    ST_164_UNKNOWN_NAK_REQ:
      CreateUnknowNakReq;
    ST_164_REQUEST:
      CreateDataReq;
  end;
end;

function CUSPD16401BMeter.SelfHandler(var pMsg: CMessage): Boolean;
var
  res: Boolean;
begin
  res := false;
  if (mCurrState = ST_164_CLOSE_AUTOR) then
  begin
    mCurrState := ST_164_AUTORIZATION;
    SendMessageToMeter;
  end;
  result := res;
end;

function CUSPD16401BMeter.LoHandler(var pMsg: CMessage): Boolean;
var
  res: Boolean;
  crc: word;
begin
  res := False;
//   if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CUSPD16401BMeter/LoHandler ON');
  try
    case pMsg.m_sbyType of
      PH_DATA_IND:
        begin
        //  CreateOutMSG(m_nP.m_swMID, QRY_NAK_EN_MONTH_EP, 0, now);
       // saveToDB(m_nRxMsg);
       // res:=true;
          res := ReadAnswer(pMsg);
        end;
      QL_CONNCOMPL_REQ:
        OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ:
        OnDisconnectComplette(pMsg);
    end;
  except
    on E: Exception do
    begin
        {$IFDEF JCL1}
      E.Message := uJCL.JclAddStackList(E.Message);
        {$ENDIF}
        //(TEventBox.FixEvents(ET_CRITICAL, E.Message));
      raise Exception.Create(E.Message);
      if EventBox <> Nil then
        EventBox.FixEvents(ET_CRITICAL, '(CUSPD16401BMeter/LoHandler ERROR');
    end;
  end;
//    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CUSPD16401BMeter/LoHandler EXIT');
  Result := res;
end;

function CUSPD16401BMeter.HiHandler(var pMsg: CMessage): Boolean;
var
  res: Boolean;
  tempP: ShortInt;
  FNCNum: Integer;
  crc: word;
begin
  res := false;
//   if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CUSPD16401BMeter/HiHandler ON');
  try
    m_nRxMsg.m_sbyServerID := 0;
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
        begin
          Move(pMsg.m_sbyInfo[0], nReq, sizeof(CQueryPrimitive));
//       if (nReq.m_swParamID=QRY_ENTER_COM)  then Begin {TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>USPD16401B Open Transit...');}exit;End;
//       if (nReq.m_swParamID=QRY_EXIT_COM)   then Begin {TraceL(2,pMsg.m_swObjID,'(__)CL2MD::>USPD16401B Close Transit.');}exit;End;
          SendMessageToMeter;
        end;
      QL_DATA_GRAPH_REQ:
        HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ:
        OnFinHandQryRoutine(pMsg);
    end;
  except
    on E: Exception do
    begin
       {$IFDEF JCL1}
      E.Message := uJCL.JclAddStackList(E.Message);
       {$ENDIF}
       //TEventBox.FixEvents(ET_CRITICAL, E.Message);
      raise Exception.Create(E.Message);
      if EventBox <> Nil then
        EventBox.FixEvents(ET_NORMAL, '(CUSPD16401BMeter/HiHandler ERROR');
    end;
  end;
//   if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CUSPD16401BMeter/HiHandler EXIT');
  Result := res;
end;

procedure CUSPD16401BMeter.HandQryRoutine(var pMsg: CMessage);
var
  Date1, Date2: TDateTime;
  param: word;
  wPrecize: word;
  szDT: word;
  pDS: CMessageData;
begin
  IsUpdate := 1;
  m_nCounter := 0;
  m_nCounter1 := 0;
    //m_nObserver.ClearGraphQry;
  szDT := sizeof(TDateTime);
  Move(pMsg.m_sbyInfo[0], pDS, sizeof(CMessageData));
  Move(pDS.m_sbyInfo[0], Date1, szDT);
  Move(pDS.m_sbyInfo[szDT], Date2, szDT);
  param := pDS.m_swData1;
  wPrecize := pDS.m_swData2;
  case param of
    QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EM, QRY_NAK_EN_DAY_RP, QRY_NAK_EN_DAY_RM:
      AddNakEnergyDayGraphQry(Date1, Date2);
    QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM, QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM:
      AddNakEnergyMonthGraphQry(Date1, Date2);
    QRY_SRES_ENR_EP, QRY_SRES_ENR_EM, QRY_SRES_ENR_RP, QRY_SRES_ENR_RM:
      AddEnergySresGraphQry(Date1, Date2);
  end;
end;

procedure CUSPD16401BMeter.OnEnterAction;
begin
   //mCurrState := ST_164_PRE_AUTOR_0;
  mCurrState := ST_164_AUTORIZATION;
  mTimeDir := ST_164_READ_TIME;
  if (m_nP.m_sbyEnable = 1) and (m_nP.m_sbyModem = 1) then
    OpenPhone
  else if (m_nP.m_sbyModem = 0) then
    FinalAction;
end;

procedure CUSPD16401BMeter.OnFinalAction;
begin
   //CreateCloseAutorReq;
   //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
   //if m_nP.m_sbyModem=0 then FinalAction;
   //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
end;

procedure CUSPD16401BMeter.OnConnectComplette(var pMsg: CMessage);
begin
  m_nModemState := 1;
end;

procedure CUSPD16401BMeter.OnDisconnectComplette(var pMsg: CMessage);
begin
  m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
end;

procedure CUSPD16401BMeter.OnFinHandQryRoutine(var pMsg: CMessage);
begin
  if m_nP.m_sbyEnable = 1 then
  begin
     //if m_nModemState=1 then
    IsUpdate := 0;
    m_nCounter := 0;
    m_nCounter1 := 0;
  end;
end;

procedure CUSPD16401BMeter.RunMeter;
begin

end;

function CUSPD16401BMeter.crc(var buf: array of byte; cnt: integer): boolean;
var
  CRChiEl: byte;
  CRCloEl: byte;
  i: byte;
  cmp: byte;
  idx: byte;
begin
  Result := true;
  CRChiEl := $FF;
  CRCloEl := $FF;
  cmp := cnt - 1;
  if cnt >= 300 then
  begin
    Result := false;
    exit;
  end;
  for i := 0 to cmp do
  begin
    idx := (CRChiEl xor buf[i]) and $FF;
    CRChiEl := (CRCloEl xor CRCHI164[idx]);
    CRCloEl := CRCLO164[idx];
  end;
  if (CRCloEl <> buf[cnt]) and (CRChiEl <> buf[cnt + 1]) then
    Result := false;
  buf[cnt] := CRCloEl;
  buf[cnt + 1] := CRChiEl;
end;

function CUSPD16401BMeter.GetCommand(byCommand: Byte): Integer;
var
  res: Integer;
begin
  case byCommand of
    QRY_ENERGY_SUM_EP, QRY_ENERGY_SUM_EM, QRY_ENERGY_SUM_RP, QRY_ENERGY_SUM_RM:
      res := 8;
    QRY_ENERGY_DAY_EP, QRY_ENERGY_DAY_EM, QRY_ENERGY_DAY_RP, QRY_ENERGY_DAY_RM:
      res := 6;
    QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EM, QRY_NAK_EN_MONTH_RP, QRY_NAK_EN_MONTH_RM:
      res := 10;
    QRY_ENERGY_MON_EP, QRY_ENERGY_MON_EM, QRY_ENERGY_MON_RP, QRY_ENERGY_MON_RM:
      res := 7;
    QRY_SRES_ENR_EP:
      res := 2;
    QRY_SRES_ENR_EM:
      res := 3;
    QRY_SRES_ENR_RP:
      res := 4;
    QRY_SRES_ENR_RM:
      res := 5;
    QRY_SRES_ENR_DAY_EP:
      res := 2;
    QRY_SRES_ENR_DAY_EM:
      res := 3;
    QRY_SRES_ENR_DAY_RP:
      res := 4;
    QRY_SRES_ENR_DAY_RM:
      res := 5;
    QRY_MGAKT_POW_A, QRY_MGAKT_POW_B, QRY_MGAKT_POW_C, QRY_MGREA_POW_A, QRY_MGREA_POW_B, QRY_MGREA_POW_C, QRY_U_PARAM_A, QRY_U_PARAM_B, QRY_U_PARAM_C, QRY_I_PARAM_A, QRY_I_PARAM_B, QRY_I_PARAM_C, QRY_FREQ_NET:
      res := 9;
    QRY_DATA_TIME, QRY_KPRTEL_KE, QRY_AUTORIZATION:
      res := 0;
  else
    res := -1;
  end;
  Result := res;
end;

function CUSPD16401BMeter.GetStringFromFile(FileName: string; nStr: integer): string;
var
  f: TStringList;
begin
  f := TStringList.Create();
  f.LoadFromFile(FileName);
  Result := f.Strings[nStr];
  FreeAndNil(f); //f.Free;
end;

procedure CUSPD16401BMeter.EncodeStrToBufArr(var str: string; var buf: array of byte; var nCount: integer);
var
  i: integer;
  ts: string;
begin
  ts := '';
  nCount := 0;
  for i := 1 to Length(str) do
    if str[i] <> ' ' then
    begin
      if ts = '' then
        ts := '$';
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

end.

