unit knsl2EntasNetMeter;
//{$DEFINE L2_ENTAS_DEBUG}

interface

uses
  Windows, Classes, SysUtils,
  utltypes, utlbox, utlconst, knsl2meter, knsl5config, utlmtimer, knsl5tracer,
  utlTimeDate;


type
  CEntasNetMeter = class(CMeter)
  private
    m_QReq         : CQueryPrimitive;
    mCMDID         : Integer;
    mSliceN        : Integer;
    mAdrReDirect   : Integer;
    //IsUpdate       : BYTE;
  public
    // base
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
    function    CRCMOD(_Buff : array of BYTE; _Count : WORD) : BYTE;
    function    IsValidMessage(var pMsg : CMessage) : boolean;
    procedure   FillMessageHead(var pMsg : CHMessage; length : word);
    procedure   FillReDirMSG(var pMsg: CMessage; length,ObjID,SlNumb:integer;IsUpd:boolean);
    procedure   CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime; IsUpd : boolean);
    function    GetChanInfo(PID : integer): integer;
    function    GetNumPoint(DtTm : TDateTime) : Word;
    procedure   Create30MinPowerReq(var nReq:CQueryPrimitive);
    procedure   Create3MinPowerReq(var nReq:CQueryPrimitive);
    procedure   CreateUIReq(var nReq:CQueryPrimitive);
    procedure   SendReDirMsg(var pMsg:CMessage);
    procedure   CreateKorrTimeReq(var nReq:CQueryPrimitive);
    procedure   CreateReadLinghtTimeReq(var nReq:CQueryPrimitive);
    procedure   ReadSlicesAns(var pMsg: CMessage);
    procedure   ReadUIAns(var pMsg: CMessage);
    procedure   Read3PowerAns(var pMsg: CMessage);
    procedure   ReadLightAns(var pMsg: CMessage);
    procedure   AddEnergyDayGraphQry(param : integer; Date1, Date2 : TDateTime);
    procedure   AddOneGraphQry(Date1, Date2 : TDateTime);
    function    GetStringFromFile(FileName : string; nStr : integer) : string;
    procedure   EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
    procedure   TestMSG(var pMsg:CMessage);
    function    SwapBytes(tv:Word):Word;
    procedure   ReadStatesOfLight(var pMsg: CMessage);
    Function    BCDToByte(DIn : Byte):Byte;
  End;

implementation

procedure CEntasNetMeter.AddEnergyDayGraphQry(param : integer; Date1, Date2 : TDateTime);
var i, slB, slE : integer;
begin

   //if trunc(Date2) = trunc(Now) then
   //begin
   // Date1 := trunc(Now);
   //  Date2 := Now;
   //end;
   //if trunc(Date2) = trunc(Now) - 1 then
   //begin
   //  Date1 := trunc(Date2) + EncodeTime(0, 30, 0, 0)*47;
   //  Date2 := trunc(Date2) + EncodeTime(0, 30, 0, 0)*47;
   //end else if trunc(Date2) < trunc(Now) - 1 then exit;
   //slB := trunc((Date1 - trunc(Now)) / EncodeTime(0, 30, 0, 0));
   //slE := trunc((Date2 - trunc(Now)) / EncodeTime(0, 30, 0, 0));
   //for i := slE downto slB do
   if trunc(Date1) = trunc(Now) then
   begin
     slB := 0;
     slE := trunc(frac(Now) / EncodeTime(0, 30, 0, 0));
     if SlE <> 0 then
       SlE := SlE - 1
     else
       exit;
   end else exit;
   {else if trunc(Date1) = trunc(Now) - 1 then
   begin
     slB := trunc(frac(Now) / EncodeTime(0, 30, 0, 0)) + 2;
     slE := 47;
   end else exit;
   }
   for i := slE downto slB do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, i, 0, 0, 1);
end;

procedure CEntasNetMeter.AddOneGraphQry(Date1, Date2 : TDateTime);
var i, slB, slE : integer;
begin
   if trunc(Date1) = trunc(Now) then
   begin
     slE := trunc(frac(Now) / EncodeTime(0, 30, 0, 0));
     if SlE <> 0 then
       SlE := SlE - 1
     else
       exit;
     slB := slE;
   end
   else if trunc(Date1) = trunc(Now) - 1 then
   begin
     slB := 47;
     slE := 47;
   end else exit;
   for i := slB to slE do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, i, 0, 0, 1);
   IsUpdate := 0;
end;

procedure CEntasNetMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_ENTASNET;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CEntasNetMeter.FillReDirMSG(var pMsg: CMessage; length,ObjID,SlNumb:integer;IsUpd:boolean);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := ObjID;
   pMsg.m_sbyFrom       := Byte(IsUpd);
   pMsg.m_sbyFor        := DIR_L1TOL2;
   pMsg.m_sbyType       := QL_REDIRECT_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_ENTASNET;
   pMsg.m_sbyDirID      := SlNumb;
end;

procedure CEntasNetMeter.CreateOutMSG(param : double; sm : byte; tar : byte; Date : TDateTime; IsUpd : boolean);
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
   m_nRxMsg.m_sbyDirID   := Byte(IsUpd);
end;

function CEntasNetMeter.SwapBytes(tv:Word):Word;
begin
   Result := Hi(tv) + Lo(tv)*$100;
end;

function CEntasNetMeter.GetNumPoint(DtTm : TDateTime) : Word;
Var MSec,Sec,Min,Hour : Word;
    Week : Integer;
begin
  DecodeTime(DtTm,Hour,Min,Sec,Sec);
  Result := Hour Shl 1;
  If Min > 29 Then Inc(Result);
//  If Result = 0 then Result := 47 Else Dec(Result);
end;


function  CEntasNetMeter.GetChanInfo(PID : integer): integer;
var i : integer;
begin
   Result := 0;
   with m_nObserver.pm_sInil2CmdTbl.LockList do
   try
   for i := 0 to count - 1 do
     if CComm(Items[i]).m_swCmdID = PID then
     begin
       Result := 0;//StrToInt(CComm(Items[i]).m_swChannel);
       m_QReq.m_swCmdID  := PID;
       m_QReq.m_swSpecc0 := CComm(Items[i]).m_swSpecc0;
       m_QReq.m_swSpecc1 := CComm(Items[i]).m_swSpecc1;
       m_QReq.m_swSpecc2 := CComm(Items[i]).m_swSpecc2;
       exit;
     end;
   finally
     m_nObserver.pm_sInil2CmdTbl.UnLockList;
   end;
end;

procedure CEntasNetMeter.Create30MinPowerReq(var nReq:CQueryPrimitive);
var SlN, i, CRC   : Integer;
begin
   CRC := 0;
   GetChanInfo(QRY_SRES_ENR_EP);
  // if nReq.m_swSpecc2 <> 0 then
  //   SlN := GetNumPoint(Now - EncodeTime(0, 30, 0, 0))
  // else
  //   SlN := GetNumPoint(nReq.m_swSpecc0 * EncodeTime(0, 30, 0, 0));
  // mSliceN := SlN;
  if nReq.m_swSpecc2 <> 0 then
    Begin
    SlN := trunc(frac(Now) / EncodeTime(0, 30, 0, 0));
    if SlN <> 0 then
       SlN := SlN - 1;
    End
  else
    SlN := nReq.m_swSpecc0;
  // if SlN = 47 then SlN := 0;// else Inc(SlN);

  mSliceN := Sln;


   m_nTxMsg.m_sbyInfo[0] := $10;
   m_nTxMsg.m_sbyInfo[1] := m_QReq.m_swSpecc0;
   m_nTxMsg.m_sbyInfo[2] := 8;

   m_nTxMsg.m_sbyInfo[3] := 0;
   m_nTxMsg.m_sbyInfo[4] := 0;
   m_nTxMsg.m_sbyInfo[5] := m_QReq.m_swSpecc2;
   m_nTxMsg.m_sbyInfo[6] := (m_QReq.m_swSpecc1 + SlN*73) div $100;
   m_nTxMsg.m_sbyInfo[7] := (m_QReq.m_swSpecc1 + SlN*73) mod $100;


   m_nTxMsg.m_sbyInfo[8] := $10;
   m_nTxMsg.m_sbyInfo[9] := $03;
   for i := 0 to 7 do CRC := CRC + m_nTxMsg.m_sbyInfo[i];
   if CRC<>16 then
     m_nTxMsg.m_sbyInfo[10]:= CRC mod $100
   else
   begin
     m_nTxMsg.m_sbyInfo[10]:= 17;
     m_nTxMsg.m_sbyInfo[5] := m_nTxMsg.m_sbyInfo[5] + 1;
   end;
   FillMessageHead(m_nTxMsg, 11);
   SendToL1(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CEntasNetMeter.Create3MinPowerReq(var nReq:CQueryPrimitive);
var i, CRC   : Integer;
begin
   GetChanInfo(QRY_E3MIN_POW_EP);
   mSliceN := $FF;
   CRC := 0;
   m_nTxMsg.m_sbyInfo[0] := $10;
   m_nTxMsg.m_sbyInfo[1] := m_QReq.m_swSpecc0;
   m_nTxMsg.m_sbyInfo[2] := 8;
   m_nTxMsg.m_sbyInfo[3] := 0;
   m_nTxMsg.m_sbyInfo[4] := 0;
   m_nTxMsg.m_sbyInfo[5] := m_QReq.m_swSpecc2;
   m_nTxMsg.m_sbyInfo[6] := (m_QReq.m_swSpecc1) div $100;
   m_nTxMsg.m_sbyInfo[7] := (m_QReq.m_swSpecc1) mod $100;
   m_nTxMsg.m_sbyInfo[8] := $10;
   m_nTxMsg.m_sbyInfo[9] := $03;
   for i := 0 to 7 do CRC := CRC + m_nTxMsg.m_sbyInfo[i];
   if CRC<>16 then
     m_nTxMsg.m_sbyInfo[10]:= CRC mod $100
   else
   begin
     m_nTxMsg.m_sbyInfo[10]:= 17;
     m_nTxMsg.m_sbyInfo[5] := m_nTxMsg.m_sbyInfo[5] + 1;
   end;
   FillMessageHead(m_nTxMsg, 11);
   SendToL1(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CEntasNetMeter.CreateUIReq(var nReq:CQueryPrimitive);
var i, CRC : Integer;
begin
   GetChanInfo(QRY_I_PARAM_A);
   mSliceN  := $FE;
   CRC := 0;
   m_nTxMsg.m_sbyInfo[0] := $10;
   m_nTxMsg.m_sbyInfo[1] := m_QReq.m_swSpecc0;
   m_nTxMsg.m_sbyInfo[2] := 8;
   m_nTxMsg.m_sbyInfo[3] := 0;
   m_nTxMsg.m_sbyInfo[4] := 0;
   m_nTxMsg.m_sbyInfo[5] := 80;
   m_nTxMsg.m_sbyInfo[6] := (m_QReq.m_swSpecc1) div $100;
   m_nTxMsg.m_sbyInfo[7] := (m_QReq.m_swSpecc1) mod $100;
   m_nTxMsg.m_sbyInfo[8] := $10;
   m_nTxMsg.m_sbyInfo[9] := $03;
   for i := 0 to 7 do CRC := CRC + m_nTxMsg.m_sbyInfo[i];
   if CRC <> 16 then
     m_nTxMsg.m_sbyInfo[10] := CRC mod $100
   else
   begin
     m_nTxMsg.m_sbyInfo[10] := 17;
     m_nTxMsg.m_sbyInfo[5] := m_nTxMsg.m_sbyInfo[5] + 1;
   end;
   FillMessageHead(m_nTxMsg, 11);
   SendToL1(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

procedure CEntasNetMeter.SendReDirMsg(var pMsg:CMessage);
begin
   if mAdrReDirect = -1 then
   begin
     FinalAction;
   end else
   begin
     FillReDirMSG(pMsg, pMsg.m_swLen - 11, mAdrReDirect, mSliceN, Boolean(IsUpdate));
     FPUT(BOX_L2, @pMsg);
   end;
end;
{
if Data[3]=4 then begin
      Mass[0]:=$10;
      Mass[1]:=Data[1];
      Mass[2]:=9;
      tim:=DateTimeToStr(Now);
      Mass[3]:=StrToInt(Copy(tim,7,2));
      Mass[4]:=StrToInt(Copy(tim,4,2));
      Mass[5]:=StrToInt(Copy(tim,1,2));
      Mass[6]:=StrToInt(Copy(tim,10,2));
      Mass[7]:=StrToInt(Copy(tim,13,2));
      Mass[8]:=StrToInt(Copy(tim,16,2));
      Mass[9]:=$10;
      Mass[10]:=$03;
      For I:=0 to 10 do Inc(KS,Mass[I]);
      Mass[11]:=KS mod 256;
    end;

}
procedure CEntasNetMeter.CreateKorrTimeReq(var nReq:CQueryPrimitive);
var Year, Month, Day, i : word;
    Hour, Min, Sec, ms  : word;
    ChS                 : Integer;
begin
   DecodeDate( Now, Year, Month, Day );
   DecodeTime( Now, Hour, Min, Sec, ms );

   GetChanInfo(QRY_SRES_ENR_EP);
   m_nTxMsg.m_sbyInfo[0] := $10;
   m_nTxMsg.m_sbyInfo[1] := m_QReq.m_swSpecc0;
   m_nTxMsg.m_sbyInfo[2] := 9;

   m_nTxMsg.m_sbyInfo[3] := Year - 2000;
   m_nTxMsg.m_sbyInfo[4] := Month;
   m_nTxMsg.m_sbyInfo[5] := Day;
   m_nTxMsg.m_sbyInfo[6] := Hour;
   m_nTxMsg.m_sbyInfo[7] := Min;
   m_nTxMsg.m_sbyInfo[8] := Sec;
   m_nTxMsg.m_sbyInfo[9] := $10;
   m_nTxMsg.m_sbyInfo[10] := $03;

   ChS := 0;
   for i := 0 to 10 do
     ChS := ChS + m_nTxMsg.m_sbyInfo[i];
       m_nTxMsg.m_sbyInfo[11] := ChS mod 256;
  FillMessageHead(m_nTxMsg, 12);
  SendToL1(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  mSliceN := $FD;
  FinalAction;
  //FinalAction;
end;

procedure  CEntasNetMeter.CreateReadLinghtTimeReq(var nReq:CQueryPrimitive);
var CRC, i : Integer;
begin
   m_nTxMsg.m_sbyInfo[0] := $10;
   m_nTxMsg.m_sbyInfo[1] := 22;
   m_nTxMsg.m_sbyInfo[2] := 8;
   m_nTxMsg.m_sbyInfo[3] := 0;
   m_nTxMsg.m_sbyInfo[4] := 0;
   m_nTxMsg.m_sbyInfo[5] := 15;
   m_nTxMsg.m_sbyInfo[6] := 0;
   m_nTxMsg.m_sbyInfo[7] := 20;
   CRC := $10;
   for i := 1 to 7 do
    CRC := CRC + m_nTxMsg.m_sbyInfo[i];
   m_nTxMsg.m_sbyInfo[8] := $10;
   m_nTxMsg.m_sbyInfo[9] := 3;
   m_nTxMsg.m_sbyInfo[10] := CRC mod $100;
   if (m_nTxMsg.m_sbyInfo[10] = 16) then
   begin
     m_nTxMsg.m_sbyInfo[10] := 17;
     m_nTxMsg.m_sbyInfo[5] := m_nTxMsg.m_sbyInfo[5] + 1;
   end;
   FillMessageHead(m_nTxMsg, 11);
   SendToL1(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   mSliceN := $FC;
end;

procedure CEntasNetMeter.ReadSlicesAns(var pMsg: CMessage);
var dVal   : double;
    dtDate : TDateTime;
    tSl    : integer;
    PHAddress : Integer;
begin
   PHAddress := StrToInt(m_nP.m_sddPHAddres);
   tSl := mSliceN;
   dtDate := trunc(Now) + tSl * EncodeTime(0, 30, 0, 0);
   if (tSl * EncodeTime(0, 30, 0, 0) > frac(Now)) then
     dtDate := trunc(Now - 1) + tSl * EncodeTime(0, 30, 0, 0);

   if PHAddress <> -1 then
     dVal := pMsg.m_sbyInfo[4 + StrToInt(m_nP.m_sddPHAddres)] * m_nP.m_sfKU / 1000
   else
     dVal := 0;

   CreateOutMSG(dVal, QRY_SRES_ENR_EP, 0, dtDate, boolean(IsUpdate));
   m_nRxMsg.m_sbyServerID := tSl;
   FPUT(BOX_L3_BY, @m_nRxMsg);

   if PHAddress <> -1 then
     dVal := pMsg.m_sbyInfo[5 + StrToInt(m_nP.m_sddPHAddres)] * m_nP.m_sfKU / 1000
   else
     dVal := 0;

   CreateOutMSG(dVal, QRY_SRES_ENR_RP, 0, dtDate, boolean(IsUpdate));
   FPUT(BOX_L3_BY, @m_nRxMsg);

   SendReDirMsg(pMsg);
   m_nRepTimer.OffTimer;
end;

procedure CEntasNetMeter.ReadUIAns(var pMsg: CMessage);
var dVal : double;
    tVal : Word;
    PHAddress : Integer;
begin
   GetChanInfo(QRY_I_PARAM_A);
   PHAddress := m_QReq.m_swSpecc2;
   if (PHAddress <> -1) then
   begin
     move(pMsg.m_sbyInfo[3 + PHAddress * 2], tVal, 2);
     dVal := tVal;
   end else dVal := 0;

   CreateOutMSG(dVal, QRY_I_PARAM_A, 0, Now, boolean(IsUpdate));
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);

   GetChanInfo(QRY_U_PARAM_A);
   PHAddress := m_QReq.m_swSpecc2;
   if (PHAddress <> -1) then
   begin
     move(pMsg.m_sbyInfo[3 + PHAddress * 2], tVal, 2);
     dVal := tVal;
   end else dVal := 0;

   CreateOutMSG(dVal, QRY_U_PARAM_A, 0, Now, boolean(IsUpdate));
   FPUT(BOX_L3_BY, @m_nRxMsg);

   SendReDirMsg(pMsg);
   m_nRepTimer.OffTimer;

end;

procedure CEntasNetMeter.Read3PowerAns(var pMsg: CMessage);
var dVal : double;
    tVal : Word;
    PHAddress : Integer;
begin
   PHAddress := StrToInt(m_nP.m_sddPHAddres);
   if (PHAddress <> -1) then
   begin
     move(pMsg.m_sbyInfo[3 + PHAddress * 2], tVal, 2);
     tVal := SwapBytes(tVal);
     tVal := trunc(tVal * m_nP.m_sfKU / 1000 * 20);
     dVal := tVal;
   end else dVal := 0;

   CreateOutMSG(dVal, QRY_E3MIN_POW_EP, 0, Now, boolean(IsUpdate));
   m_nRxMsg.m_sbyServerID := 0;
   FPUT(BOX_L3_BY, @m_nRxMsg);

   if (PHAddress <> -1) then
   begin
     move(pMsg.m_sbyInfo[5 + PHAddress * 2], tVal, 2);
     tVal := SwapBytes(tVal);
     dVal := tVal * m_nP.m_sfKU / 1000 * 20;
   end else dVal := 0;

   CreateOutMSG(dVal, QRY_E3MIN_POW_RP, 0, Now, boolean(IsUpdate));
   FPUT(BOX_L3_BY, @m_nRxMsg);

   SendReDirMsg(pMsg);
   m_nRepTimer.OffTimer;
   //mSliceN := $a0;
end;

procedure CEntasNetMeter.ReadLightAns(var pMsg: CMessage);
begin
   m_nLightInfo.m_nHDOn := BCDToByte(pMsg.m_sbyInfo[3]);
   m_nLightInfo.m_nMDOn := BCDToByte(pMsg.m_sbyInfo[4]);
   m_nLightInfo.m_nHDOff := BCDToByte(pMsg.m_sbyInfo[5]);
   m_nLightInfo.m_nMDOff := BCDToByte(pMsg.m_sbyInfo[6]);
//   pMsg.m_sbyInfo[7]
   m_nLightInfo.m_nHR1On := BCDToByte(pMsg.m_sbyInfo[8]);
   m_nLightInfo.m_nMR1On := BCDToByte(pMsg.m_sbyInfo[9]);
   m_nLightInfo.m_nHR1Off:= BCDToByte(pMsg.m_sbyInfo[10]);
   m_nLightInfo.m_nMR1Off:= BCDToByte(pMsg.m_sbyInfo[11]);
//   pMsg.m_sbyInfo[12]
   m_nLightInfo.m_nHR2On := BCDToByte(pMsg.m_sbyInfo[13]);
   m_nLightInfo.m_nMR2On := BCDToByte(pMsg.m_sbyInfo[14]);
   m_nLightInfo.m_nHR2Off:= BCDToByte(pMsg.m_sbyInfo[15]);
   m_nLightInfo.m_nMR2Off:= BCDToByte(pMsg.m_sbyInfo[16]);
//   pMsg.m_sbyInfo[17]
   ReadStatesOfLight(pMsg);
   OnFinalAction;
end;

constructor CEntasNetMeter.Create;
Begin
  TraceL(3, m_nP.m_swMID,'(__)CL2MD::> EntasNet Meter Created');
End;


destructor CEntasNetMeter.Destroy;
Begin
    inherited;
End;

procedure CEntasNetMeter.InitMeter(var pL2:SL2TAG);
begin
  IsUpdate := 0;
  SetHandScenario;
  SetHandScenarioGraph;
  TraceL(3,m_nP.m_swMID,'(__)CL2MD::> EntasNet Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));

  IsUpdate   := 0;

  SetHandScenario();
  SetHandScenarioGraph();
  mAdrReDirect := GetL2AdrFromRead(m_nP.m_sAdvDiscL2Tag);
End;

procedure CEntasNetMeter.RunMeter;
Begin

End;

function CEntasNetMeter.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    //Обработчик для L2(Таймер идр)

    Result := res;
End;
{DIR_L1TOL2}
function CEntasNetMeter.LoHandler(var pMsg:CMessage):Boolean;
var
  l_FNC : Byte;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND, QL_REDIRECT_REQ:
      begin
        if pMsg.m_sbyType = QL_REDIRECT_REQ then
        begin
          mSliceN := pMsg.m_sbyDirID;
          IsUpdate := pMsg.m_sbyFrom;
        end
        else if pMsg.m_sbyType = PH_DATA_IND then
          pMsg.m_sbyFrom := Byte(IsUpdate);

        {$IFDEF L2_ENTAS_DEBUG}
         if pMsg.m_sbyType = PH_DATA_IND then
           TestMSG(pMsg);
        {$ENDIF}
        TraceM(2,pMsg.m_swObjID,'(__)CENTM::>Inp DRQ:',@pMsg);
        if (not IsValidMessage(pMsg)) or (mSliceN = $FD) then
        begin
          TraceL(2,pMsg.m_swObjID,'(__)CENTM::>Error. Invalid Message: ');
          Result := false;
          exit;
        end;
        case mSliceN of
          0..47 : ReadSlicesAns(pMsg);
          $FE   : ReadUIAns(pMsg);
          $FF   : Read3PowerAns(pMsg);
          $FC   : ReadLightAns(pMsg);
          else
          FinalAction;
        end;
      End;
    End;
End;


function CEntasNetMeter.HiHandler(var pMsg:CMessage):Boolean;
var
    nReq : CQueryPrimitive;
begin
  Result := False;

  m_nRxMsg.m_sbyServerID := 0;
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    begin
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
      if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
      if nReq.m_swParamID=QM_FIN_MTR_IND then Begin FinalAction;exit;End;
      case nReq.m_swParamID of
        QRY_SRES_ENR_EP, QRY_SRES_ENR_RP   : Create30MinPowerReq(nReq);
        QRY_E3MIN_POW_EP, QRY_E3MIN_POW_RP : Create3MinPowerReq(nReq);
        QRY_U_PARAM_A, QRY_I_PARAM_A       : CreateUIReq(nReq);
        QRY_AUTORIZATION                   : CreateReadLinghtTimeReq(nReq);//
        QRY_DATA_TIME                      : CreateKorrTimeReq(nReq);

        else
         FinalAction;
      end;
    end;

    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_CTRL_REQ     : HandCtrlRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
  End;
End;

procedure CEntasNetMeter.OnEnterAction;
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> EntasNet OnEnterAction');
    if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) then
    OpenPhone else
    if (m_nP.m_sbyModem=0) then FinalAction;
    //FinalAction;
End;


procedure CEntasNetMeter.OnFinalAction;
Begin
    mSliceN := $A0;
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> EntasNet OnFinalAction');
    //if m_nP.m_sbyModem=1 then SendPMSG(BOX_L1,m_nP.m_sbyPortID,DIR_L2TOL1,PH_CONN_IND) else
    //if m_nP.m_sbyModem=0 then FinalAction;
    //if (m_nP.m_sbyEnable=1)and(m_nP.m_sbyModem=1) OnLoadCounter;
    FinalAction;
End;

procedure CEntasNetMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> EntasNet OnConnectComplette');
    m_nModemState := 1;
    FinalAction;
End;

procedure CEntasNetMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::> EntasNet OnDisconnectComplette');
    m_nModemState := 0;
    //SendMSG(BOX_L2,DIR_QMTOL2,DL_ERRTMR1_IND);
    //FinalAction;
End;

procedure CEntasNetMeter.HandQryRoutine(pMsg:CMessage);
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
      QRY_SRES_ENR_EP, QRY_SRES_ENR_RP : if pDS.m_swData2 = 0 then AddEnergyDayGraphQry(l_ParamID, Date1, Date2)
                                         else AddOneGraphQry(Date1, Date2);
      else exit;
    end;
end;

procedure CEntasNetMeter.HandCtrlRoutine(pMsg:CMessage);
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

procedure CEntasNetMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
    if m_nP.m_sbyEnable=1 then
    Begin
     //if m_nModemState=1 then
     OnFinalAction;
     TraceM(2,pMsg.m_swObjID,'(__)CL2MD::> EntasNet OnFinHandQryRoutine  DRQ:',@pMsg);
     IsUpdate := 0;
    End;
end;

function CEntasNetMeter.CRCMOD(_Buff : array of BYTE; _Count : WORD) : BYTE;
var
    i : integer;
begin
  Result  := 0;

  for i := 0 to _Count-1 do
    Inc(Result, _Buff[i]);
end;


function CEntasNetMeter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    l_DataLen : WORD;
begin
   Result := false;
   if (pMsg.m_swLen - 11 < 10) or (mSliceN=$FD) then
     exit;
   //if (pMsg.m_sbyInfo[1] = 22) and (pMsg.m_sbyInfo[2] = 18) then
   //  exit; //Если сообщение на установку света, то пропуск
   l_DataLen :=  pMsg.m_sbyInfo[2];

  {$IFNDEF L2_ENTAS_DEBUG}
  // адрес контроллера
  {$ENDIF}

  // контрольная сумма
  if (CRCMOD(pMsg.m_sbyInfo, l_DataLen) <> pMsg.m_sbyInfo[l_DataLen+2]) then
  begin
    TraceL(3,m_nP.m_swMID,'(__)CL2MD::> EntasNet Ошибка CRC! Выход!');
    exit;
  end;

  Result := true;
end;

procedure CEntasNetMeter.TestMSG(var pMsg:CMessage);
var tempStr     : string;
    cnt, strNum : integer;
begin
   strNum  := 1;
   tempStr := GetStringFromFile('d:\Kon2\TraceForDebug\TestEntas.txt', strNum);
   EncodeStrToBufArr(tempStr, pMsg.m_sbyInfo[0], cnt);
   pMsg.m_swLen := cnt + 11;
end;

function CEntasNetMeter.GetStringFromFile(FileName : string; nStr : integer) : string;
var f :TStringList;
begin
   f := TStringList.Create();
   f.LoadFromFile(FileName);
   Result := f.Strings[nStr];
   f.Free;
end;

procedure CEntasNetMeter.EncodeStrToBufArr(var str : string; var buf : array of byte; var nCount : integer);
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

procedure CEntasNetMeter.ReadStatesOfLight(var pMsg: CMessage);
var Dez1, Dez2, Dz  : boolean;
    Osn1, Osn2, Os1 : boolean;
    Os2             : boolean;
begin
   Dez1 := Boolean(pMsg.m_sbyInfo[7] and $01);
   Dez2 := Boolean((pMsg.m_sbyInfo[7] and $02) shr 1);
   Dz   := Boolean((pMsg.m_sbyInfo[7] and $04) shr 2);

   Osn1 := Boolean(pMsg.m_sbyInfo[12] and $01);
   Osn2 := Boolean((pMsg.m_sbyInfo[12] and $02) shr 1);
   Os1  := Boolean((pMsg.m_sbyInfo[12] and $04) shr 2);

   if (pMsg.m_sbyInfo[17] < 4) then
     Os2 := false
   else
     Os2 := true;
   Os1 := Os1 or Os2;
   m_nLightInfo.m_nDAuto    := Dez1;
   if Dez1 then
   begin
     m_nLightInfo.m_nDChecked := Dz;
     m_nLightInfo.m_nDCHange  := false;
   end else
   begin
     m_nLightInfo.m_nDChecked := Dez2;
     m_nLightInfo.m_nDCHange  := True;
   end;
   m_nLightInfo.m_nR1Auto    := Osn1;
   if Osn1 then begin
    m_nLightInfo.m_nR1Checked := Os1;
    m_nLightInfo.m_nR1Change  := false;
  end else begin
    m_nLightInfo.m_nR1Checked := Osn2;
    m_nLightInfo.m_nR1Change  := true;
  end;
end;

Function CEntasNetMeter.BCDToByte(DIn : Byte):Byte;
Begin
  Result := ((DIn And $F0) Shr 4)*10 + (DIn And $0F);
End;

end.
