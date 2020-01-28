unit knsl2CE208BYMeter;

interface

uses
  Windows, Classes, SysUtils,
  utltypes, utlbox, utlconst, knsl2meter, knsl5config, utlmtimer, {knsl5tracer,}
  utlTimeDate,utldatabase;//,knsl3EventBox;
type
  CCE208BYMeter = class(CMeter)
  private
    nReq           : CQueryPrimitive;
    mCurrState     : integer;
    mCurr          : integer; // CE208 only -- switch текущий, месяц, день
    mDeltaDataD    : integer;
    mDeltaDataM    : integer;
    dateToRead     : TDateTime; // CE208 only -- текущая дата на сессии
    mm_address     : String;    
  public
    // base
    constructor Create();
    destructor  Destroy; override;
    procedure   InitMeter(var pL2:SL2TAG); override;
    procedure   RunMeter; override;

    // events routing
    function    SelfHandler(var pMsg:CMessage) : Boolean; override;
    function    LoHandler(var pMsg0:CMessage):Boolean;override;
    function    HiHandler(var pMsg:CMessage) : Boolean; override;

    procedure   OnEnterAction();
    procedure   OnFinalAction();
    procedure   OnConnectComplette(var pMsg:CMessage); override;
    procedure   OnDisconnectComplette(var pMsg:CMessage); override;

    procedure   HandQryRoutine(pMsg:CMessage);
    procedure   HandCtrlRoutine(pMsg:CMessage);
    procedure   OnFinHandQryRoutine(var pMsg:CMessage);

  private
    procedure   AddEnDayGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
    procedure   AddEnMonGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
    procedure   FillMessageHead(var pMsg : CHMessage; length : word);
    function    ReadAnswerFromCE208(var pMsg:CMessage):boolean;

    function    ReadAutorAns(var pMsg:CMessage):boolean;  //CE208 only
    function    ReadAutorAns_1(var pMsg:CMessage):boolean;//CE208 only
    function    ReadEnergoAns(var pMsg:CMessage):boolean; //CE208 only
    function    ReadEnergoMAns(var pMsg:CMessage):boolean; //CE208 only
    function    ReadEnergoDAns(var pMsg:CMessage):boolean; //CE208 only
    function    ReadEnergoDNAns(var pMsg:CMessage):boolean; //CE208 only
    function    ReadEndSesionAns(var pMsg:CMessage):boolean; //CE208 only
    procedure   dslep(var buf: array of byte); // декодировать протокол SLIP
    function    gv(indB : Integer; var indE : Integer; var buf: array of byte) : Cardinal;

    procedure   SendMessageToMeter;
    procedure   CreateAutorReq;    //CE208 only
    procedure   CreateAutorReq_1;  //CE208 only
    procedure   CreateAutorReq_W;  //CE208 only
    procedure   CreateEnergoReq;   //CE208 only
    procedure   CreateEnergoReq_W; //CE208 only
    procedure   CreateEnergoMReq;   //CE208 only
    procedure   CreateEnergoMReq_W; //CE208 only
    procedure   CreateEnergoDReq;   //CE208 only
    procedure   CreateEnergoDReq_W; //CE208 only
    procedure   CreateEnergoDNReq;   //CE208 only
    procedure   CreateEnergoDNReq_W; //CE208 only
    procedure   CreateEndSesionReq;   //CE208 only
    procedure   CreateEndSesionReq_W; //CE208 only

    procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);

    procedure   CalcParity(var buf : array of byte; var nCount : Word);
    procedure   ClearParity(var buf : array of byte; var nCount : Word);
    function    IsEven(byData:Byte):Boolean;
    function    DecodeInt(buf : Cardinal) : Cardinal;
    function    getCRC16( indB : Integer; indE : Integer;var buf : array of Byte):Word;
    function    hash(buff: string; size,random: integer):integer;
  End;

  const   ST_CE208_AUTORIZATION      = 0;    //CE208 only
          ST_CE208_INDETIFICATION    = 1;
          ST_CE208_CHECK_PASSWORD    = 2;
          ST_CE208_SEND_QUERY        = 3;
          ST_CE208_AUTORIZATION_1    = 4;    //CE208 only
          ST_CE208_AUTORIZATION_W    = 5;    //CE208 only
          ST_CE208_AUTORIZATION_W1   = 6;    //CE208 only

          ST_CE208_CREATEENERGO      = 7;    //CE208 only
          ST_CE208_CREATEENERGO_W    = 8;    //CE208 only
          ST_CE208_CREATEENERGOM     = 9;    //CE208 only
          ST_CE208_CREATEENERGOM_W   = 10;   //CE208 only
          ST_CE208_CREATEENERGOMN    = 11;   //CE208 only
          ST_CE208_CREATEENERGOMNM   = 12;   //CE208 only
          ST_CE208_CREATEENERGOMNR   = 13;   //CE208 only
          ST_CE208_CREATEENERGOMNRM  = 14;   //CE208 only

          ST_CE208_CREATEENERGOD     = 15;   //CE208 only
          ST_CE208_CREATEENERGOD_W   = 16;   //CE208 only
          ST_CE208_CREATEENERGODN    = 17;   //CE208 only
          ST_CE208_CREATEENERGODNM   = 18;   //CE208 only
          ST_CE208_CREATEENERGODNR   = 19;   //CE208 only
          ST_CE208_CREATEENERGODNRM  = 20;   //CE208 only
          ST_CE208_CREATEENERGODN_W  = 21;   //CE208 only
          ST_CE208_CREATEENDSESION   = 22;   //CE208 only
          ST_CE208_CREATEENDSESION_W = 23;   //CE208 only

// полином $82608EDB
crc32_tab:array[0..255] of integer = (
$00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f,
$e963a535, $9e6495a3, $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,
$09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91, $1db71064, $6ab020f2,
$f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
$136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9,
$fa0f3d63, $8d080df5, $3b6e20c8, $4c69105e, $d56041e4, $a2677172,
$3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b, $35b5a8fa, $42b2986c,
$dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
$26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423,
$cfba9599, $b8bda50f, $2802b89e, $5f058808, $c60cd9b2, $b10be924,
$2f6f7c87, $58684c11, $c1611dab, $b6662d3d, $76dc4190, $01db7106,
$98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
$7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d,
$91646c97, $e6635c01, $6b6b51f4, $1c6c6162, $856530d8, $f262004e,
$6c0695ed, $1b01a57b, $8208f4c1, $f50fc457, $65b0d9c6, $12b7e950,
$8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
$4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7,
$a4d1c46d, $d3d6f4fb, $4369e96a, $346ed9fc, $ad678846, $da60b8d0,
$44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9, $5005713c, $270241aa,
$be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
$5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81,
$b7bd5c3b, $c0ba6cad, $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,
$ead54739, $9dd277af, $04db2615, $73dc1683, $e3630b12, $94643b84,
$0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
$f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb,
$196c3671, $6e6b06e7, $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,
$f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5, $d6d6a3e8, $a1d1937e,
$38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
$d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55,
$316e8eef, $4669be79, $cb61b38c, $bc66831a, $256fd2a0, $5268e236,
$cc0c7795, $bb0b4703, $220216b9, $5505262f, $c5ba3bbe, $b2bd0b28,
$2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
$9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f,
$72076785, $05005713, $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,
$92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21, $86d3d2d4, $f1d4e242,
$68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
$88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69,
$616bffd3, $166ccf45, $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,
$a7672661, $d06016f7, $4969474d, $3e6e77db, $aed16a4a, $d9d65adc,
$40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
$bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693,
$54de5729, $23d967bf, $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,
$b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d);


implementation

constructor CCE208BYMeter.Create;
Begin
 // if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK constructor CCE208BYMeter.Create');
End;


destructor CCE208BYMeter.Destroy;
Begin
 // if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK destructor CCE208BYMeter.Destroy');
    inherited;
End;

procedure CCE208BYMeter.InitMeter(var pL2:SL2TAG);
Var
  slv : TStringList;
begin
  IsUpdate := 0;
  SetHandScenario;
  SetHandScenarioGraph;
  SetHandScenario();
  SetHandScenarioGraph();
  mCurrState:= ST_CE208_AUTORIZATION;
  //  if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK CCE208BYMeter.InitMeter(var pL2:SL2TAG)');
  slv := TStringList.Create;
  getStrings(m_nP.m_sAdvDiscL2Tag,slv);
  if slv[0]='' then slv[0] := '0';
  if slv[2]='' then slv[2] := '0';
  mm_address   := slv[2];
  //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(CCE208BYMeter.InitMeter(mm_address: '+mm_address+' )');
  FreeAndNil(slv);//slv.Clear;
//  if slv<>Nil then FreeAndNil(slv);//slv.Destroy;
End;

procedure CCE208BYMeter.RunMeter;
Begin
  //  if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK CCE208BYMeter.RunMeter(var pL2:SL2TAG)');
End;

function CCE208BYMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    if pMsg.m_sbyType = DL_REPMSG_TMR then
    begin
      if (mCurrState = ST_CE208_AUTORIZATION)or
         (mCurrState = ST_CE208_INDETIFICATION)or
         (mCurrState = ST_CE208_CHECK_PASSWORD) then
      begin
        mCurrState := ST_CE208_AUTORIZATION;
        CreateAutorReq;
      end;
    end;
    Result := res;
End;

procedure CCE208BYMeter.OnEnterAction;
Begin
    mCurrState := ST_CE208_AUTORIZATION;
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    begin
//    OpenPhone
    end else
    if (m_nP.m_sbyModem=0) then
     begin
     end;
End;


procedure CCE208BYMeter.OnFinalAction;
Begin

End;

procedure CCE208BYMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 1;
End;

procedure CCE208BYMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 0;
End;

procedure CCE208BYMeter.HandQryRoutine(pMsg:CMessage);
var
  Date1, Date2 : TDateTime;
  l_ParamID    : word;
  l_wPrecize     : word;
  szDT         : word;
  pDS          : CMessageData;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry();
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0],Date1,szDT);
    Move(pDS.m_sbyInfo[szDT],Date2,szDT);
    l_ParamID    := pDS.m_swData1; // параметр определяет запрос из ручного выбора
                                   // главный определяющий параметр для записи
                                   // в базу и необходимо его использовать в
                                   // вызывающих процедурах для
                                   // QRY_ENERGY_DAY_EP, QRY_NAK_EN_DAY_EP,
                                   // QRY_ENERGY_MON_EP, QRY_NAK_EN_MONTH_EP
    l_wPrecize := pDS.m_swData2;
    case l_ParamID of
      QRY_NAK_EN_DAY_EP,
      QRY_NAK_EN_DAY_EM,
      QRY_NAK_EN_DAY_RP,
      QRY_NAK_EN_DAY_RM,
      QRY_ENERGY_DAY_EP  : AddEnDayGraphQry(l_paramID, Date1, Date2);
      QRY_NAK_EN_MONTH_EP,
      QRY_NAK_EN_MONTH_EM,
      QRY_NAK_EN_MONTH_RP,
      QRY_NAK_EN_MONTH_RM,
      QRY_ENERGY_MON_EP  : AddEnMonGraphQry(l_paramID, Date1, Date2);
    else exit;
    end;
end;

procedure CCE208BYMeter.HandCtrlRoutine(pMsg:CMessage);
Var
    l_Param   : WORD;
    l_StateID : DWORD;
    pDS       : CMessageData;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry();
end;

procedure CCE208BYMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     IsUpdate := 0;
    End;
end;

function CCE208BYMeter.LoHandler(var pMsg0:CMessage):Boolean;
var
    res  : boolean;
    pMsg : CMessage;
begin
  res := true;
  move(pMsg0,pMsg,sizeof(CMessage));
  case pMsg.m_sbyType of
    PH_DATA_IND:
      begin
        if (m_nP.m_sbyTSlice=1) then ClearParity(pMsg.m_sbyInfo,pMsg.m_swLen);
        res := ReadAnswerFromCE208(pMsg);
      End;
  End;
    Result := res;
End;

function CCE208BYMeter.HiHandler(var pMsg:CMessage):Boolean;
begin
  Result := False;
  m_nRxMsg.m_sbyServerID := 0;
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    begin
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
      if nReq.m_swParamID=QRY_ENERGY_SUM_EP then mCurr := ST_CE208_CREATEENERGO;
      SendMessageToMeter;
    end;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_CTRL_REQ     : HandCtrlRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
  End;
End;

procedure CCE208BYMeter.AddEnDayGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   dateToRead := dt_Date2;
   if l_paramID = QRY_ENERGY_DAY_EP then
     mCurr := ST_CE208_CREATEENERGOD // CE208BY only - необходимо заслать
                                    // в зависимости от l_paramID
                                    // по этой переменной будет вызываться
                                    // накопленная энергия на начало суток
                                    // или энергия за сутки
                                    // QRY_ENERGY_DAY_EP, QRY_NAK_EN_DAY_EP
   else
     begin
        case l_paramID of
          QRY_NAK_EN_DAY_EP :  mCurr := ST_CE208_CREATEENERGODN;
          QRY_NAK_EN_DAY_EM :  mCurr := ST_CE208_CREATEENERGODNM;
          QRY_NAK_EN_DAY_RP :  mCurr := ST_CE208_CREATEENERGODNR;
          QRY_NAK_EN_DAY_RM :  mCurr := ST_CE208_CREATEENERGODNRM;
        else mCurr := ST_CE208_CREATEENERGODN;
        end;
     end;
   i := 0;
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
   begin
     dt_Date2 := Now;
     mDeltaDataD := 0;
   end;

   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin  //В цикле считаю количество дней от текущего
       cDateTimeR.DecDate(TempDate);
       Dec(i);
       if i < -30 then
       begin
         mDeltaDataD := abs(i+1);
         exit;
       end;
     end;
     m_nObserver.AddGraphParam(l_paramID, i + 1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
     mDeltaDataD := abs(i+1);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CCE208BYMeter.AddEnMonGraphQry(l_paramID : integer; dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   dateToRead := dt_Date2;
   if l_paramID = QRY_ENERGY_MON_EP then
     mCurr := ST_CE208_CREATEENERGOM  // CE208BY only - необходимо заслать
                                    // в зависимости от l_paramID
                                    // по этой переменной будет вызываться
                                    // накопленная энергия на начало месяца
                                    // или энергия за месяц
                                    // QRY_ENERGY_MON_EP, QRY_NAK_EN_MONTH_EP
   else
     begin
        case l_paramID of
          QRY_NAK_EN_MONTH_EP : mCurr := ST_CE208_CREATEENERGOMN;
          QRY_NAK_EN_MONTH_EM : mCurr := ST_CE208_CREATEENERGOMNM;
          QRY_NAK_EN_MONTH_RP : mCurr := ST_CE208_CREATEENERGOMNR;
          QRY_NAK_EN_MONTH_RM : mCurr := ST_CE208_CREATEENERGOMNRM;
        else mCurr := ST_CE208_CREATEENERGOMN;
        end;
     end;
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
  i := 0;
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
   begin
     dt_Date2 := Now;
     mDeltaDataM := 0;
   end;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Dec(i);
       if i < -24 then
       begin
         mDeltaDataM := abs(i + 1);
         exit;
       end;
     end;
     m_nObserver.AddGraphParam(l_paramID, i + 1, 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
     mDeltaDataM := abs(i + 1);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CCE208BYMeter.SendMessageToMeter;    // CE208 only
begin
   case mCurrState of
     ST_CE208_AUTORIZATION   : CreateAutorReq;
     ST_CE208_AUTORIZATION_1 : CreateAutorReq_1;  ///новую функцтяю
     ST_CE208_AUTORIZATION_W : CreateAutorReq_W;  ///новую функц
     ST_CE208_AUTORIZATION_W1 : CreateAutorReq_W;  ///новую функц
     ST_CE208_CREATEENERGO   : CreateEnergoReq;  ///новую функцтяю
     ST_CE208_CREATEENERGO_W : CreateEnergoReq_W;  ///новую функц
     ST_CE208_CREATEENERGOM   : CreateEnergoMReq;  ///новую функцтяю
     ST_CE208_CREATEENERGOM_W : CreateEnergoMReq_W;  ///новую функц
     ST_CE208_CREATEENERGOD   : CreateEnergoDReq;  ///новую функцтяю
     ST_CE208_CREATEENERGOD_W : CreateEnergoDReq_W;  ///новую функц
     ST_CE208_CREATEENERGODN   : CreateEnergoDNReq;  ///новую функцтяю
     ST_CE208_CREATEENERGODN_W : CreateEnergoDNReq_W;  ///новую функц
     ST_CE208_CREATEENDSESION   : CreateEndSesionReq;  ///новую функцтяю
     ST_CE208_CREATEENDSESION_W : CreateEndSesionReq_W;  ///новую функц
   end;
end;

procedure CCE208BYMeter.CreateAutorReq;
var tmpStr : string;
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
begin
   m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$11;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;
   m_nTxMsg.m_sbyInfo[13]:=$06;
   m_nTxMsg.m_sbyInfo[14]:=$00;
   m_nTxMsg.m_sbyInfo[15]:=$03;
   m_nTxMsg.m_sbyInfo[16]:=$00;
   m_nTxMsg.m_sbyInfo[17]:=$00;
   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],17);
   CRC_208:=getCRC16(1, 17,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[16]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[17]:=CRC_208 and $ff;
   m_nTxMsg.m_sbyInfo[18]:=$c0;
   FillMessageHead(m_nTxMsg, 19);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateAutorReq_W;
var tmpStr : string;
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
   m_Address := StrToInt(mm_address);//StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$12;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;
   m_nTxMsg.m_sbyInfo[13]:=$00;
   m_nTxMsg.m_sbyInfo[14]:=$c0;
   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],13);
   CRC_208:=getCRC16(1, 13,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[12]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[13]:=CRC_208 and $ff;
   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 13 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[14 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 15 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoReq;
var tmpStr : string;
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
   m_Address := StrToInt(mm_address);//StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$11;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;
   m_nTxMsg.m_sbyInfo[13]:=$01;
   m_nTxMsg.m_sbyInfo[14]:=$00;
   m_nTxMsg.m_sbyInfo[15]:=$01;
   m_nTxMsg.m_sbyInfo[16]:=$1f; //  суммарный и 1-4 тарифы
   m_nTxMsg.m_sbyInfo[17]:=$00;
   m_nTxMsg.m_sbyInfo[18]:=$00;
   m_nTxMsg.m_sbyInfo[19]:=$c0;
   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],18);
   CRC_208:=getCRC16(1, 18,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[17]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[18]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 18 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[19 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 20 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoReq_W;
var tmpStr : string;
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
   m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$12;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;
   m_nTxMsg.m_sbyInfo[13]:=$00;
   m_nTxMsg.m_sbyInfo[14]:=$c0;
   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],13);

   CRC_208:=getCRC16(1, 13,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[12]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[13]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 13 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[14 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 15 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoMReq;
var 
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
  m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
  m_nTxMsg.m_sbyInfo[0]:=$c0;
  m_nTxMsg.m_sbyInfo[1]:=$02;
  m_nTxMsg.m_sbyInfo[2]:=$00;
  m_nTxMsg.m_sbyInfo[3]:=$00;
  m_nTxMsg.m_sbyInfo[4]:=$00;
  m_nTxMsg.m_sbyInfo[5]:=$00;
  m_nTxMsg.m_sbyInfo[6]:=$00;
  m_nTxMsg.m_sbyInfo[7]:=$11;
  move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
  m_nTxMsg.m_sbyInfo[12]:=$00; // резерв - всегда 0
  m_nTxMsg.m_sbyInfo[13]:=$02; // GET_DATA_MULTIPLE получить данные по профилю
  m_nTxMsg.m_sbyInfo[14]:=$00;
  case mCurr of
            ST_CE208_CREATEENERGOM    : m_nTxMsg.m_sbyInfo[15]:=$0d; // профиль отчетный период - месяц
            ST_CE208_CREATEENERGOMN   : m_nTxMsg.m_sbyInfo[15]:=$09; // профиль накопление на начало период - месяц A+
            ST_CE208_CREATEENERGOMNM  : m_nTxMsg.m_sbyInfo[15]:=$0a; // профиль накопление на начало период - месяц A-
            ST_CE208_CREATEENERGOMNR  : m_nTxMsg.m_sbyInfo[15]:=$0b; // профиль накопление на начало период - месяц R+
            ST_CE208_CREATEENERGOMNRM : m_nTxMsg.m_sbyInfo[15]:=$0c; // профиль накопление на начало период - месяц R-
  else  m_nTxMsg.m_sbyInfo[15]:=$09; // профиль накопление на начало период - месяц
  end;
  m_nTxMsg.m_sbyInfo[16]:=$1f; //  суммарный и 1-4 тарифы  //$00;
  if (mCurr = ST_CE208_CREATEENERGOMNR) or (mCurr = ST_CE208_CREATEENERGOMNRM) then
      m_nTxMsg.m_sbyInfo[16]:=$00; //  суммарный без тарифов;
  m_nTxMsg.m_sbyInfo[17]:=Byte(mDeltaDataM); //$01;
  m_nTxMsg.m_sbyInfo[18]:=Byte(mDeltaDataM); //$01;
  m_nTxMsg.m_sbyInfo[19]:=$00; // CRC Hi byte
  m_nTxMsg.m_sbyInfo[20]:=$00; // CRC Lo byte
  m_nTxMsg.m_sbyInfo[21]:=$c0;

  move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],20);
  CRC_208:=getCRC16(1, 20,m_nTxMsg.m_sbyInfo[0]);
  m_nTxMsg.m_sbyInfo[19]:=(CRC_208 shr 8)and $ff;
  m_nTxMsg.m_sbyInfo[20]:=CRC_208 and $ff;
  c     := 0;
  delta := 0;
  move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 20 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end;
   end; 
   m_nTxMsg.m_sbyInfo[21 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 22 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoMReq_W;
var
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
  m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
  m_nTxMsg.m_sbyInfo[0]:=$c0;
  m_nTxMsg.m_sbyInfo[1]:=$02;
  m_nTxMsg.m_sbyInfo[2]:=$00;
  m_nTxMsg.m_sbyInfo[3]:=$00;
  m_nTxMsg.m_sbyInfo[4]:=$00;
  m_nTxMsg.m_sbyInfo[5]:=$00;
  m_nTxMsg.m_sbyInfo[6]:=$00;
  m_nTxMsg.m_sbyInfo[7]:=$12;
  move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
  m_nTxMsg.m_sbyInfo[12]:=$00;
  m_nTxMsg.m_sbyInfo[13]:=$00;
  m_nTxMsg.m_sbyInfo[14]:=$c0;

  move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],13);

  CRC_208:=getCRC16(1, 13,m_nTxMsg.m_sbyInfo[0]);
  m_nTxMsg.m_sbyInfo[12]:=(CRC_208 shr 8)and $ff;
  m_nTxMsg.m_sbyInfo[13]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 13 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[14 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 15 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoDReq; // за день
var 
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  i, c, delta      : Integer;
begin
   for i := 0 to 31 do crcbuf[i] := 0;
   m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;  //c0#, -- начало пакета
   m_nTxMsg.m_sbyInfo[1]:=$02;  //02#, -- идентификатор протокола, для взаимодействия с 3172 всегда =2
   m_nTxMsg.m_sbyInfo[2]:=$00;  //16#00#, 16#00#, 16#00#, 16#00#, -- шировещательный адрес 3172
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;  // 16#00#, -- флаги пакета и команды
   m_nTxMsg.m_sbyInfo[7]:=$11;  // 16#11#, -- код команды
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00; // резерв - всегда 0
   m_nTxMsg.m_sbyInfo[13]:=$02;
   m_nTxMsg.m_sbyInfo[14]:=$00;
   m_nTxMsg.m_sbyInfo[15]:=$05; // код профиля - за сутки  // код профиля - накопление энергии на начало суток
   m_nTxMsg.m_sbyInfo[16]:=$1f; // по тарифам // $00; // общий
   m_nTxMsg.m_sbyInfo[17]:= Byte(mDeltaDataD); //$01;
   m_nTxMsg.m_sbyInfo[18]:= Byte(mDeltaDataD); //$01;
   m_nTxMsg.m_sbyInfo[19]:=$00; // CRC Hi
   m_nTxMsg.m_sbyInfo[20]:=$00; // CRC Lo
   m_nTxMsg.m_sbyInfo[21]:=$c0;

   m_nTxMsg.m_sbyInfo[19]:=$00; // CRC Hi
   m_nTxMsg.m_sbyInfo[20]:=$00; // CRC Lo
   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],20);

   CRC_208:=getCRC16(0, 19,crcbuf[0]);
   m_nTxMsg.m_sbyInfo[19]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[20]:=CRC_208 and $ff;
   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 20 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[21 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 22 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoDReq_W;  // за день
var 
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
  m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
  m_nTxMsg.m_sbyInfo[0]:=$c0;   //c0#, -- начало пакета
  m_nTxMsg.m_sbyInfo[1]:=$02;   //02#, -- идентификатор протокола, для взаимодействия с 3172 всегда =2
  m_nTxMsg.m_sbyInfo[2]:=$00;   //16#00#, 16#00#, 16#00#, 16#00#, -- шировещательный адрес 3172
  m_nTxMsg.m_sbyInfo[3]:=$00;   // -/-
  m_nTxMsg.m_sbyInfo[4]:=$00;   // -/-
  m_nTxMsg.m_sbyInfo[5]:=$00;   // -/-
  m_nTxMsg.m_sbyInfo[6]:=$00;   // 16#00#, -- флаги пакета и команды
  m_nTxMsg.m_sbyInfo[7]:=$12;   // 16#12#, -- код команды
  move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);//16#76#, 16#dc#, 16#1c#, 16#04#, -- адрес счетчика
  m_nTxMsg.m_sbyInfo[12]:=$00;  // 16#53#, 16#4f#, -- CRC
  m_nTxMsg.m_sbyInfo[13]:=$00;  // 16#53#, 16#4f#, -- CRC
  m_nTxMsg.m_sbyInfo[14]:=$c0;  // 16#c0#  -- признак конца пакета

  move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],13);

  CRC_208:=getCRC16(1, 13,m_nTxMsg.m_sbyInfo[0]);
  m_nTxMsg.m_sbyInfo[12]:=(CRC_208 shr 8)and $ff;
  m_nTxMsg.m_sbyInfo[13]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 13 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[14 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 15 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoDNReq; // за день
var
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  i, c, delta      : Integer;
begin
  for i := 0 to 31 do crcbuf[i] := 0;
  m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
  m_nTxMsg.m_sbyInfo[0]:=$c0;
  m_nTxMsg.m_sbyInfo[1]:=$02;
  m_nTxMsg.m_sbyInfo[2]:=$00;
  m_nTxMsg.m_sbyInfo[3]:=$00;
  m_nTxMsg.m_sbyInfo[4]:=$00;
  m_nTxMsg.m_sbyInfo[5]:=$00;
  m_nTxMsg.m_sbyInfo[6]:=$00;
  m_nTxMsg.m_sbyInfo[7]:=$11;
  move(m_Address, m_nTxMsg.m_sbyInfo[8], 4); //addres
  m_nTxMsg.m_sbyInfo[12]:=$00; // резерв - всегда 0
  m_nTxMsg.m_sbyInfo[13]:=$02;
  m_nTxMsg.m_sbyInfo[14]:=$00;

  case mCurr of
            ST_CE208_CREATEENERGOD    : m_nTxMsg.m_sbyInfo[15]:=$05; // профиль отчетный период - один день
            ST_CE208_CREATEENERGODN   : m_nTxMsg.m_sbyInfo[15]:=$01; // профиль накопление на начало период - день A+
            ST_CE208_CREATEENERGODNM  : m_nTxMsg.m_sbyInfo[15]:=$02; // профиль накопление на начало период - день A-
            ST_CE208_CREATEENERGODNR  : m_nTxMsg.m_sbyInfo[15]:=$03; // профиль накопление на начало период - день R+
            ST_CE208_CREATEENERGODNRM : m_nTxMsg.m_sbyInfo[15]:=$04; // профиль накопление на начало период - день R-
  else  m_nTxMsg.m_sbyInfo[15]:=$01; // профиль накопление на начало период - день
  end;  // case
  m_nTxMsg.m_sbyInfo[16]:=$1f; // по тарифам
  if (mCurr = ST_CE208_CREATEENERGODNR) or (mCurr = ST_CE208_CREATEENERGODNRM) then
     m_nTxMsg.m_sbyInfo[16]:= $00; // общий
  m_nTxMsg.m_sbyInfo[17]:= Byte(mDeltaDataD); //$01;
  m_nTxMsg.m_sbyInfo[18]:= Byte(mDeltaDataD); //$01;
  m_nTxMsg.m_sbyInfo[19]:=$00; // CRC Hi
  m_nTxMsg.m_sbyInfo[20]:=$00; // CRC Lo
  m_nTxMsg.m_sbyInfo[21]:=$c0;

  m_nTxMsg.m_sbyInfo[19]:=$00; // CRC Hi
  m_nTxMsg.m_sbyInfo[20]:=$00; // CRC Lo
  move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],20);

  CRC_208:=getCRC16(0, 19,crcbuf[0]);

  m_nTxMsg.m_sbyInfo[19]:=(CRC_208 shr 8)and $ff;
  m_nTxMsg.m_sbyInfo[20]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 20 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[21 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 22 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEnergoDNReq_W;  // за день
var 
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
   m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$12;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;
   m_nTxMsg.m_sbyInfo[13]:=$00;
   m_nTxMsg.m_sbyInfo[14]:=$c0;

   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],13);

   CRC_208:=getCRC16(1, 13,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[12]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[13]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 13 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[14 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 15 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEndSesionReq;
var tmpStr : string;
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
   m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$11;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;   // 16#00#, 16#07#, 16#00#, 16#27#, -- DATA
   m_nTxMsg.m_sbyInfo[13]:=$07;
   m_nTxMsg.m_sbyInfo[14]:=$00;
   m_nTxMsg.m_sbyInfo[15]:=$27;
   m_nTxMsg.m_sbyInfo[16]:=$00;
   m_nTxMsg.m_sbyInfo[17]:=$00;
   m_nTxMsg.m_sbyInfo[18]:=$c0;

   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],17);

   CRC_208:=getCRC16(1, 17,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[16]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[17]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 17 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[18 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 19 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.CreateEndSesionReq_W;
var 
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..16] of byte;
  c, delta : Integer;
begin
  m_Address := StrToInt(mm_address); //StrToInt(m_nP.m_sddPHAddres);
  m_nTxMsg.m_sbyInfo[0]:=$c0;
  m_nTxMsg.m_sbyInfo[1]:=$02;
  m_nTxMsg.m_sbyInfo[2]:=$00;
  m_nTxMsg.m_sbyInfo[3]:=$00;
  m_nTxMsg.m_sbyInfo[4]:=$00;
  m_nTxMsg.m_sbyInfo[5]:=$00;
  m_nTxMsg.m_sbyInfo[6]:=$00;
  m_nTxMsg.m_sbyInfo[7]:=$12;
  m_nTxMsg.m_sbyInfo[8]:=$76;
  m_nTxMsg.m_sbyInfo[9]:=$DC;
  m_nTxMsg.m_sbyInfo[10]:=$1C;
  m_nTxMsg.m_sbyInfo[11]:=$04;
  m_nTxMsg.m_sbyInfo[12]:=$00;
  m_nTxMsg.m_sbyInfo[13]:=$00;
  m_nTxMsg.m_sbyInfo[14]:=$c0;
  move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
  move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],13);

  CRC_208:=getCRC16(1, 13,m_nTxMsg.m_sbyInfo[0]);
  m_nTxMsg.m_sbyInfo[12]:=(CRC_208 shr 8)and $ff;
  m_nTxMsg.m_sbyInfo[13]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 13 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[14 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 15 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;


procedure CCE208BYMeter.CreateAutorReq_1;
var
  m_Address: DWORD;
  CRC_208: WORD;
  crcbuf :array[0..31] of byte;
  c, delta : Integer;
begin
   m_Address := StrToInt(mm_address); 
   m_nTxMsg.m_sbyInfo[0]:=$c0;
   m_nTxMsg.m_sbyInfo[1]:=$02;
   m_nTxMsg.m_sbyInfo[2]:=$00;
   m_nTxMsg.m_sbyInfo[3]:=$00;
   m_nTxMsg.m_sbyInfo[4]:=$00;
   m_nTxMsg.m_sbyInfo[5]:=$00;
   m_nTxMsg.m_sbyInfo[6]:=$00;
   m_nTxMsg.m_sbyInfo[7]:=$11;
   move(m_Address, m_nTxMsg.m_sbyInfo[8], 4);
   m_nTxMsg.m_sbyInfo[12]:=$00;
   m_nTxMsg.m_sbyInfo[13]:=$06;
   m_nTxMsg.m_sbyInfo[14]:=$00;
   m_nTxMsg.m_sbyInfo[15]:=$03;
   m_nTxMsg.m_sbyInfo[16]:=$04;
   m_nTxMsg.m_sbyInfo[17]:=$00;
   m_nTxMsg.m_sbyInfo[18]:=$00;
   m_nTxMsg.m_sbyInfo[19]:=$c0;

   move(m_nTxMsg.m_sbyInfo[1],crcbuf[0],18);

   CRC_208:=getCRC16(1, 18,m_nTxMsg.m_sbyInfo[0]);
   m_nTxMsg.m_sbyInfo[17]:=(CRC_208 shr 8)and $ff;
   m_nTxMsg.m_sbyInfo[18]:=CRC_208 and $ff;

   c     := 0;
   delta := 0;
   move(m_nTxMsg.m_sbyInfo[0],crcbuf[0],22);
   for c := 1 to 18 do
   begin
    case crcbuf[c] of
    $c0 :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dc;
          end;
    $db :
          begin
             m_nTxMsg.m_sbyInfo[c + delta] := $db;
             delta := delta + 1;
             m_nTxMsg.m_sbyInfo[c + delta] := $dd;
          end;
    else
      m_nTxMsg.m_sbyInfo[c + delta] := crcbuf[c];
    end; // case
   end; // for
   m_nTxMsg.m_sbyInfo[19 + delta] := $c0;
   FillMessageHead(m_nTxMsg, 20 + delta);
   SendToL1(BOX_L1 ,@m_nTxMsg);
end;

procedure CCE208BYMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CE208BY;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CCE208BYMeter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
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

function CCE208BYMeter.ReadAnswerFromCE208(var pMsg:CMessage):boolean; // CE208 only
begin
   Result := true;
   if pMsg.m_swLen <= 13 then
   begin
     Result := true;
     exit;
   end;

   case mCurrState of
     ST_CE208_AUTORIZATION   : Result := ReadAutorAns(pMsg); // CE208 only
     ST_CE208_AUTORIZATION_W  : Result := ReadAutorAns(pMsg); // CE208 only
     ST_CE208_AUTORIZATION_1  : Result := ReadAutorAns_1(pMsg); // CE208 only
     ST_CE208_AUTORIZATION_W1  : Result := ReadAutorAns_1(pMsg); // CE208 only

     ST_CE208_CREATEENERGO   : Result := ReadEnergoAns(pMsg); // CE208 only
     ST_CE208_CREATEENERGO_W  : Result := ReadEnergoAns(pMsg); // CE208 only

     ST_CE208_CREATEENERGOM, ST_CE208_CREATEENERGOMN  : Result := ReadEnergoMAns(pMsg); // CE208 only
     ST_CE208_CREATEENERGOM_W : Result := ReadEnergoMAns(pMsg); // CE208 only

     ST_CE208_CREATEENERGOD   : Result := ReadEnergoDAns(pMsg); // CE208 only
     ST_CE208_CREATEENERGOD_W  : Result := ReadEnergoDAns(pMsg); // CE208 only
     ST_CE208_CREATEENERGODN   : Result := ReadEnergoDNAns(pMsg); // CE208 only
     ST_CE208_CREATEENERGODN_W  : Result := ReadEnergoDNAns(pMsg); // CE208 only
     ST_CE208_CREATEENDSESION   : Result := ReadEndSesionAns(pMsg); // CE208 only
     ST_CE208_CREATEENDSESION_W  : Result := ReadEndSesionAns(pMsg);// CE208 only
   end;
end;

function CCE208BYMeter.ReadAutorAns(var pMsg:CMessage):boolean;
begin
    if (pMsg.m_sbyInfo[7] = $12) then
    begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK Autorization! CRC =' +  InttoStr(getCRC16(1,23,pMsg.m_sbyInfo)));
      m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
      mCurrState:=ST_CE208_AUTORIZATION_1;
    end
    else
    if(pMsg.m_sbyInfo[7] = $1f) then
     begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Eror Autorization!');
      m_nObserver.ClearGraphQry();
     end
    else
    begin
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     mCurrState:=ST_CE208_AUTORIZATION_W;
    end;
end;

function CCE208BYMeter.ReadAutorAns_1(var pMsg:CMessage):boolean;
begin
    if (pMsg.m_sbyInfo[7] = $12) then
    begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK Autorization_1! ');
      m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
       case mCurr of
         ST_CE208_CREATEENERGO   : mCurrState:=ST_CE208_CREATEENERGO;    // mCurrState:=ST_CE208_CREATEENERGOM
         ST_CE208_CREATEENERGOMNM,
         ST_CE208_CREATEENERGOMNR,
         ST_CE208_CREATEENERGOMNRM,
         ST_CE208_CREATEENERGOM, ST_CE208_CREATEENERGOMN  : mCurrState:=ST_CE208_CREATEENERGOM;
         ST_CE208_CREATEENERGOD  : mCurrState:=ST_CE208_CREATEENERGOD;
         ST_CE208_CREATEENERGODNM,
         ST_CE208_CREATEENERGODNR,
         ST_CE208_CREATEENERGODNRM,
         ST_CE208_CREATEENERGODN : mCurrState:=ST_CE208_CREATEENERGODN;
//       else
//         if EventBox<>Nil then
//        begin
//          EventBox.FixEvents(ET_CRITICAL,'(Eror Autorization! ReadAutorAns_1 with mCurr-> !!Error value');
//         end;
       end;
    end
    else
    if(pMsg.m_sbyInfo[7] = $1f) then
     begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Eror Autorization!');
      m_nObserver.ClearGraphQry();
     end
    else
     begin
      m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
      mCurrState:=ST_CE208_AUTORIZATION_W1;
     end;
end;

function CCE208BYMeter.ReadEnergoAns(var pMsg:CMessage):boolean;
var
   EnergoVal : Cardinal;
   EnergoVal_01 : Cardinal;
   EnergoVal_02 : Cardinal;
   EnergoVal_03 : Cardinal;
   EnergoVal_04 : Cardinal;
   indslise  : Integer;
   bufCRC    : Word;
   tmpCRC    : Word;

Begin
    EnergoVal    := 0;
    EnergoVal_01 := 0;
    EnergoVal_02 := 0;
    EnergoVal_03 := 0;
    EnergoVal_04 := 0;
    dslep(pMsg.m_sbyInfo);
    if (pMsg.m_sbyInfo[7] = $12) then
    begin
      EnergoVal := gv( 15, indslise, pMsg.m_sbyInfo);
      EnergoVal_01 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      EnergoVal_02 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      EnergoVal_03 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      EnergoVal_04 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      bufCRC := (Word(pMsg.m_sbyInfo[indslise + 1]) shl 8) or (Word(pMsg.m_sbyInfo[indslise + 2]));
      pMsg.m_sbyInfo[indslise + 1] := 0;
      pMsg.m_sbyInfo[indslise + 2] := 0;
      tmpCRC := getCRC16(1,indslise+2,pMsg.m_sbyInfo);
      if bufCRC <> tmpCRC then
      begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Error=CRC Energo_1_ALL!');
        m_nObserver.ClearGraphQry();
        m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
        Result := False;
        Exit;
      end;
     CreateOutMSG(DecodeInt(EnergoVal)/10000, QRY_ENERGY_SUM_EP, 0, Now);
     SaveToDB(m_nRxMsg);
     CreateOutMSG(DecodeInt(EnergoVal_01)/10000, QRY_ENERGY_SUM_EP, 1, Now);
     SaveToDB(m_nRxMsg);
     CreateOutMSG(DecodeInt(EnergoVal_02)/10000, QRY_ENERGY_SUM_EP, 2, Now);
     SaveToDB(m_nRxMsg);
     CreateOutMSG(DecodeInt(EnergoVal_03)/10000, QRY_ENERGY_SUM_EP, 3, Now);
     SaveToDB(m_nRxMsg);
     CreateOutMSG(DecodeInt(EnergoVal_04)/10000, QRY_ENERGY_SUM_EP, 4, Now);
     SaveToDB(m_nRxMsg);
//     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK Energo_1! All= '
//      + InttoSTR(EnergoVal)
//      + ' Sum=> ' + InttoStr(DecodeInt(EnergoVal))
//      + ' Tarif_01=> ' + InttoStr(DecodeInt(EnergoVal_01))
//      + ' Tarif_02=> ' + InttoStr(DecodeInt(EnergoVal_02))
//      + ' Tarif_03=> ' + InttoStr(DecodeInt(EnergoVal_03))
//      + ' Tarif_04=> ' + InttoStr(DecodeInt(EnergoVal_04)));
//     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     mCurrState:=ST_CE208_CREATEENDSESION;
    end else
    if(pMsg.m_sbyInfo[7] = $1f) then
     begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Error Energo_1!');
      m_nObserver.ClearGraphQry();
     end
    else
     begin
      m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
      mCurrState:=ST_CE208_CREATEENERGO_W;
     end;
end;

function CCE208BYMeter.ReadEnergoMAns(var pMsg:CMessage):boolean;
var
   EnergoVal : Cardinal;
   EnergoVal_01 : Cardinal;
   EnergoVal_02 : Cardinal;
   EnergoVal_03 : Cardinal;
   EnergoVal_04 : Cardinal;
   indslise  : Integer;
   bufCRC    : Word;
   tmpCRC    : Word;
   sm        : Integer;
Begin
    EnergoVal    := 0;
    EnergoVal_01 := 0;
    EnergoVal_02 := 0;
    EnergoVal_03 := 0;
    EnergoVal_04 := 0;
    dslep(pMsg.m_sbyInfo);
    if (pMsg.m_sbyInfo[7] = $12) then
    begin
      EnergoVal := gv( 15, indslise, pMsg.m_sbyInfo);
      if (mCurr = ST_CE208_CREATEENERGOM) or
         (mCurr = ST_CE208_CREATEENERGOMN) or
         (mCurr = ST_CE208_CREATEENERGOMNM)
      then // если реактивная мощность то по тарифам не читаем
        begin
         EnergoVal_01 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
         EnergoVal_02 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
         EnergoVal_03 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
         EnergoVal_04 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
        end;
      bufCRC := (Word(pMsg.m_sbyInfo[indslise + 1]) shl 8) or (Word(pMsg.m_sbyInfo[indslise + 2]));
      pMsg.m_sbyInfo[indslise + 1] := 0;
      pMsg.m_sbyInfo[indslise + 2] := 0;
      tmpCRC := getCRC16(1,indslise+2,pMsg.m_sbyInfo);
      if bufCRC <> tmpCRC then
      begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Error=CRC Energo_1_NAK!');
        m_nObserver.ClearGraphQry();
        m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
        Result := False;
        Exit;
      end;
      if (Trunc(dateToRead) > Trunc(Now)) then
      begin
        EnergoVal    := 0;
        EnergoVal_01 := 0;
        EnergoVal_02 := 0;
        EnergoVal_03 := 0;
        EnergoVal_04 := 0;
      end;
      if mCurr = ST_CE208_CREATEENERGOM then
       begin
         CreateOutMSG((DecodeInt(EnergoVal) shr 3)/10000 ,    QRY_ENERGY_MON_EP, 0, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
         SaveToDB(m_nRxMsg);
         CreateOutMSG((DecodeInt(EnergoVal_01) shr 3)/10000 , QRY_ENERGY_MON_EP, 1, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
         SaveToDB(m_nRxMsg);
         CreateOutMSG((DecodeInt(EnergoVal_02) shr 3)/10000 , QRY_ENERGY_MON_EP, 2, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
         SaveToDB(m_nRxMsg);
         CreateOutMSG((DecodeInt(EnergoVal_03) shr 3)/10000 , QRY_ENERGY_MON_EP, 3, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
         SaveToDB(m_nRxMsg);
         CreateOutMSG((DecodeInt(EnergoVal_04) shr 3)/10000 , QRY_ENERGY_MON_EP, 4, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
         SaveToDB(m_nRxMsg);
       end
      else
       begin
         case mCurr of
            ST_CE208_CREATEENERGOMN   : sm := QRY_NAK_EN_MONTH_EP;
            ST_CE208_CREATEENERGOMNM  : sm := QRY_NAK_EN_MONTH_EM;
            ST_CE208_CREATEENERGOMNR  : sm := QRY_NAK_EN_MONTH_RP;
            ST_CE208_CREATEENERGOMNRM : sm := QRY_NAK_EN_MONTH_RM;
         else  sm := QRY_NAK_EN_MONTH_EM;
         end;  // case
         CreateOutMSG((DecodeInt(EnergoVal) shr 3)/10000    , sm, 0, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
         SaveToDB(m_nRxMsg);
         if (sm = QRY_NAK_EN_MONTH_EP ) or (sm = QRY_NAK_EN_MONTH_EM ) then // сохранить по тарифно
         begin
            CreateOutMSG((DecodeInt(EnergoVal_01) shr 3)/10000 , sm, 1, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
            SaveToDB(m_nRxMsg);
            CreateOutMSG((DecodeInt(EnergoVal_02) shr 3)/10000 , sm, 2, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
            SaveToDB(m_nRxMsg);
            CreateOutMSG((DecodeInt(EnergoVal_03) shr 3)/10000 , sm, 3, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
            SaveToDB(m_nRxMsg);
            CreateOutMSG((DecodeInt(EnergoVal_04) shr 3)/10000 , sm, 4, dateToRead); // Now);  //  CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
            SaveToDB(m_nRxMsg);
         end;
       end; //else
//      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK Energo_1_Month_NAK QRY-'+ InttoSTR(sm) + '! = '
//        + InttoSTR(EnergoVal)
//        + ' SUM => ' + InttoStr(DecodeInt(EnergoVal) shr 3)
//        + ' TARIF_01 => ' + InttoStr(DecodeInt(EnergoVal_01) shr 3)
//        + ' TARIF_02 => ' + InttoStr(DecodeInt(EnergoVal_02) shr 3)
//        + ' TARIF_03 => ' + InttoStr(DecodeInt(EnergoVal_03) shr 3)
//        + ' TARIF_04 => ' + InttoStr(DecodeInt(EnergoVal_04) shr 3)
//        );
      m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
      mCurrState:=ST_CE208_CREATEENDSESION;
    end
    else
     if(pMsg.m_sbyInfo[7] = $1f) then
       begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Error Energo_1_M!');
        m_nObserver.ClearGraphQry();
       end
     else
     begin
       m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
       mCurrState:=ST_CE208_CREATEENERGOM_W;
     end;
end;

function CCE208BYMeter.ReadEnergoDAns(var pMsg:CMessage):boolean;
var
   EnergoVal : Cardinal;
   EnergoVal_01 : Cardinal;
   EnergoVal_02 : Cardinal;
   EnergoVal_03 : Cardinal;
   EnergoVal_04 : Cardinal;
   indslise  : Integer;
   bufCRC    : Word;
   tmpCRC    : Word;
Begin
    EnergoVal    := 0;
    EnergoVal_01 := 0;
    EnergoVal_02 := 0;
    EnergoVal_03 := 0;
    EnergoVal_04 := 0;
    dslep(pMsg.m_sbyInfo);
    if (pMsg.m_sbyInfo[7] = $12) then
    begin
      EnergoVal := gv( 15, indslise, pMsg.m_sbyInfo);
      EnergoVal_01 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      EnergoVal_02 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      EnergoVal_03 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      EnergoVal_04 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      bufCRC := (Word(pMsg.m_sbyInfo[indslise + 1]) shl 8) or (Word(pMsg.m_sbyInfo[indslise + 2]));
      pMsg.m_sbyInfo[indslise + 1] := 0;
      pMsg.m_sbyInfo[indslise + 2] := 0;
      tmpCRC := getCRC16(1,indslise+2,pMsg.m_sbyInfo);
      if bufCRC <> tmpCRC then
      begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Error=CRC Energo_1!');
        m_nObserver.ClearGraphQry();
        m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
        Result := False;
        Exit;
      end;
      if (Trunc(dateToRead) > Trunc(Now)) then
      begin
        EnergoVal    := 0;
        EnergoVal_01 := 0;
        EnergoVal_02 := 0;
        EnergoVal_03 := 0;
        EnergoVal_04 := 0;
      end;
      // QRY_ENERGY_DAY_EP, QRY_NAK_EN_DAY_EP -- возможные значения
     CreateOutMSG((DecodeInt(EnergoVal) shr 3)/10000, QRY_ENERGY_DAY_EP, 0, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     // сдвиг на 3 разряда в вправо обязательно !!!
     SaveToDB(m_nRxMsg);
     CreateOutMSG((DecodeInt(EnergoVal_01) shr 3)/10000, QRY_ENERGY_DAY_EP, 1, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     // сдвиг на 3 разряда в вправо обязательно !!!
     SaveToDB(m_nRxMsg);
     CreateOutMSG((DecodeInt(EnergoVal_02) shr 3)/10000, QRY_ENERGY_DAY_EP, 2, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     // сдвиг на 3 разряда в вправо обязательно !!!
     SaveToDB(m_nRxMsg);
     CreateOutMSG((DecodeInt(EnergoVal_03) shr 3)/10000, QRY_ENERGY_DAY_EP, 3, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     // сдвиг на 3 разряда в вправо обязательно !!!
     SaveToDB(m_nRxMsg);
     CreateOutMSG((DecodeInt(EnergoVal_04) shr 3)/10000, QRY_ENERGY_DAY_EP, 4, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     // сдвиг на 3 разряда в вправо обязательно !!!
     SaveToDB(m_nRxMsg);
//      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK Energo_1_Day_ONLY! = '
//      + InttoSTR(EnergoVal)
//      + ' SUM=> ' + InttoStr(DecodeInt(EnergoVal) shr 3)
//      + ' TARIF_01=> ' + InttoStr(DecodeInt(EnergoVal_01) shr 3)
//      + ' TARIF_02=> ' + InttoStr(DecodeInt(EnergoVal_02) shr 3)
//      + ' TARIF_03=> ' + InttoStr(DecodeInt(EnergoVal_03) shr 3)
//      + ' TARIF_04=> ' + InttoStr(DecodeInt(EnergoVal_04) shr 3)
//      );
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     mCurrState:=ST_CE208_CREATEENDSESION;
    end
    else
    if(pMsg.m_sbyInfo[7] = $1f) then
     begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Eror Energo_1!');
      m_nObserver.ClearGraphQry();
     end
    else
     begin
      m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
      mCurrState:=ST_CE208_CREATEENERGOD_W;
     end;
end;

function CCE208BYMeter.ReadEnergoDNAns(var pMsg:CMessage):boolean;
var
   EnergoVal : Cardinal;
   EnergoVal_01 : Cardinal;
   EnergoVal_02 : Cardinal;
   EnergoVal_03 : Cardinal;
   EnergoVal_04 : Cardinal;
   indslise  : Integer;
   bufCRC    : Word;
   tmpCRC    : Word;
   sm : Integer;
Begin
    EnergoVal    := 0;
    EnergoVal_01 := 0;
    EnergoVal_02 := 0;
    EnergoVal_03 := 0;
    EnergoVal_04 := 0;
    dslep(pMsg.m_sbyInfo);
    if (pMsg.m_sbyInfo[7] = $12) then
    begin
      EnergoVal := gv( 15, indslise, pMsg.m_sbyInfo);
      if (mCurr = ST_CE208_CREATEENERGODN) or (mCurr = ST_CE208_CREATEENERGODNM) then
      begin
         EnergoVal_01 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
         EnergoVal_02 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
         EnergoVal_03 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
         EnergoVal_04 := gv( indslise+1, indslise, pMsg.m_sbyInfo);
      end;
      bufCRC := (Word(pMsg.m_sbyInfo[indslise + 1]) shl 8) or (Word(pMsg.m_sbyInfo[indslise + 2]));
      pMsg.m_sbyInfo[indslise + 1] := 0;
      pMsg.m_sbyInfo[indslise + 2] := 0;
      tmpCRC := getCRC16(1,indslise+2,pMsg.m_sbyInfo);
      if bufCRC <> tmpCRC then
      begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Error=CRC Energo_1!');
        m_nObserver.ClearGraphQry();
        m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
        Result := False;
        Exit;
      end;
      if (Trunc(dateToRead) > Trunc(Now)) then
      begin
        EnergoVal    := 0;
        EnergoVal_01 := 0;
        EnergoVal_02 := 0;
        EnergoVal_03 := 0;
        EnergoVal_04 := 0;
      end;
     case mCurr of
       ST_CE208_CREATEENERGODN    : sm := QRY_NAK_EN_DAY_EP;
       ST_CE208_CREATEENERGODNM   : sm := QRY_NAK_EN_DAY_EM;
       ST_CE208_CREATEENERGODNR   : sm := QRY_NAK_EN_DAY_RP;
       ST_CE208_CREATEENERGODNRM  : sm := QRY_NAK_EN_DAY_RM;
     else sm := QRY_NAK_EN_DAY_EP;
     end;

     CreateOutMSG((DecodeInt(EnergoVal) shr 3)/10000, sm, 0, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
     // сдвиг на 3 разряда в вправо обязательно !!!
     SaveToDB(m_nRxMsg);
     if (sm = QRY_NAK_EN_DAY_EP) or (sm = QRY_NAK_EN_DAY_EM) then
     begin
        CreateOutMSG((DecodeInt(EnergoVal_01) shr 3)/10000, sm, 1, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
        // сдвиг на 3 разряда в вправо обязательно !!!
        SaveToDB(m_nRxMsg);
        CreateOutMSG((DecodeInt(EnergoVal_02) shr 3)/10000, sm, 2, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
        // сдвиг на 3 разряда в вправо обязательно !!!
        SaveToDB(m_nRxMsg);
        CreateOutMSG((DecodeInt(EnergoVal_03) shr 3)/10000, sm, 3, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
        // сдвиг на 3 разряда в вправо обязательно !!!
        SaveToDB(m_nRxMsg);
        CreateOutMSG((DecodeInt(EnergoVal_04) shr 3)/10000, sm, 4, dateToRead); // Now); // CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime);
        // сдвиг на 3 разряда в вправо обязательно !!!
        SaveToDB(m_nRxMsg);
     end;
//     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK Energo_1_Day_NAK! QRY_NAK_EN_DAY='+ InttoSTR(sm) +'cod='
//      + InttoSTR(EnergoVal)
//      + ' SUM=> ' + InttoStr(DecodeInt(EnergoVal) shr 3)
//      + ' TARIF_01=> ' + InttoStr(DecodeInt(EnergoVal_01) shr 3)
//      + ' TARIF_02=> ' + InttoStr(DecodeInt(EnergoVal_02) shr 3)
//      + ' TARIF_03=> ' + InttoStr(DecodeInt(EnergoVal_03) shr 3)
//      + ' TARIF_04=> ' + InttoStr(DecodeInt(EnergoVal_04) shr 3)
//      );
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     mCurrState:=ST_CE208_CREATEENDSESION;
    end
    else
    if(pMsg.m_sbyInfo[7] = $1f) then
     begin
//      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Eror Energo_1!');
      m_nObserver.ClearGraphQry();
     end
    else
    begin
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     mCurrState:=ST_CE208_CREATEENERGODN_W;
    end;
end;

function CCE208BYMeter.ReadEndSesionAns(var pMsg:CMessage):boolean;
begin
    if (pMsg.m_sbyInfo[7] = $12) then
      begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(OK EndSesion!)');
        m_nObserver.ClearGraphQry();
      end
    else
    if(pMsg.m_sbyInfo[7] = $1f) then
      begin
//        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Eror EndSesion!)');
      end
    else
      begin
          m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
          mCurrState:=ST_CE208_CREATEENDSESION_W;
      end;
end;

procedure CCE208BYMeter.dslep(var buf: array of byte); // декодировать протокол SLIP
var
 tb : array [0 .. 31] of byte;
 j      : Integer;
 c      : Integer;
 i      : Integer;
 k      : Integer;
begin
 for k := 0 to 31 do
   tb[k] := 0;

 if buf[0] = $c0 then
 begin
   tb[0] := $c0;
   j:=1;
   for i := 1 to 31 do
   begin
     c := i;
     if buf[j] = $c0 then
     begin
       tb[i] := buf[j];
       break;
     end
     else
     begin
      if  buf[j] = $db then
      begin
        if buf[j+1] = $dc then
           begin
            tb[i] := $c0;
            j := j + 2;
           end
        else
          begin
            if buf[j+1] = $dd then
              begin
               tb[i] := $db;
               j := j + 2;
              end
          end
      end // if $db then
      else
      begin
       tb[i] := buf[j];
       j := j+1;
      end
     end; // else $c0
   end; // for
   for i := 0 to c do
     buf[i] := tb[i];
 end; // if
end;

function CCE208BYMeter.gv(indB : Integer; var indE : Integer; var buf: array of byte) : Cardinal;
   var
     tmp : Cardinal;
     tmpIndE : Integer;
begin
     tmp := 0;
     tmpIndE := indB;
      tmp := buf[tmpIndE];
      if (buf[tmpIndE] and $80) <> 0 then
      begin
         tmpIndE := tmpIndE + 1;
         tmp := tmp + (buf[tmpIndE]*256);
         if (buf[tmpIndE] and $80) <> 0 then
         begin
            tmpIndE := tmpIndE + 1;
            tmp := tmp + (buf[tmpIndE]*(256*256));
            if  (buf[tmpIndE] and $80) <> 0 then
            begin
               tmpIndE := tmpIndE + 1;
               tmp := tmp + ((buf[tmpIndE] and $7f)*(256*256*256));
            end;
         end;
      end;
    indE := tmpIndE;
    Result := tmp;
end; // gv

procedure CCE208BYMeter.CalcParity(var buf : array of byte; var nCount : Word);
Var
   i : Integer;
   byByte : Byte;
Begin
   for i := 0 to nCount-11-1 do
   Begin
    byByte := buf[i];
    if IsEven(byByte)=False then
    Begin
     byByte := byByte or $80;
     buf[i] := byByte;
    end;
   End;
End;

procedure CCE208BYMeter.ClearParity(var buf : array of byte; var nCount : Word);
Var
   i : Integer;
Begin
   for i := 0 to nCount-11-1 do
   buf[i] := buf[i] and $7f;
End;
function CCE208BYMeter.IsEven(byData:Byte):Boolean;
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

function  CCE208BYMeter.DecodeInt(buf : Cardinal):Cardinal;
var
//   res : Cardinal;
   num    : Integer;
   ch     : Cardinal;
Begin
   result := 0;
   num    := 0;
   ch     := buf;
   Result := (ch and $7f);  // первые 7 бит
   ch     := (ch shr 7);
   if (ch and $01) = 1 then
   begin
     ch     := buf;
     ch     := (ch shr 8);
     Result := Result or ((ch and $7f) shl 7); // вторые 7 бит
     ch     := buf;
     ch     := ch shr 15;
     if ((ch and $01) = 1) then
     Begin
        ch  := buf;
        ch  := (ch shr 16);
        Result := Result or ((ch and $7f) shl 14); // третьи 7 бит
        ch  := buf;
        ch  := ch shr 23;
        if ((ch and $01) = 1) then
        Begin
           ch := buf;
           ch := (ch shr 24);
           Result := Result or ((ch and $7f) shl 21); // четвертые 7 бит
        End; // если есть четвертые 7 бит
     End; // если есть третьи 7 бит
   End; // if если есть вторые 7 бит
End; // функции DecodeInt

function CCE208BYMeter.getCRC16( indB : Integer; indE : Integer; var buf : array of Byte):Word;
   const NNCL_wCRC_POLYNOM : Word = $8005;
   var
      wCRC : Word;
      i    : Integer;
      j    : Integer;
      a    : Byte;
begin
   wCRC := 0;
   for i := indB to indE do
   begin
     a := buf[i];
     for j:=0 to 7 do
     begin
       if (( wCRC and $8000) <> 0) then
       begin
         wCRC := wCRC shl 1;
         if ((a and $80) <> 0) then wCRC := wCRC or $01;
         wCRC := wCRC xor NNCL_wCRC_POLYNOM;
       end
       else
       begin
         wCRC := wCRC shl 1;
         if ((a and $80) <> 0) then wCRC := wCRC or $01;
       end; // if
       a := a shl 1;
     end; // for j
   end; // for i
   Result := wCRC;
end; // end function

{
buff - буфер строки пароля
size - количество символов в пароле
random - случайное число, выданное сервером при запросе авторизации
}
function CCE208BYMeter.hash(buff: string; size,random: integer):integer;
var
crc : cardinal;
i   : integer;
NumBuf:integer;
begin
crc := $ffffffff;
 for i:=1 to size do
  begin
    NumBuf := StrToInt(buff[i]);
    if (NumBuf = $00) then break;
     crc := crc32_tab[(crc or NumBuf) and $ff] or (crc shr 8);
  end;
 Result:= crc or random or $ffffffff;
end;


end. // модуля

