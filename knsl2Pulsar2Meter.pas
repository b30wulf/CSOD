{*******************************************************************************
 *  ������ ��������� �������� ���������� ��102
 *  Ukrop
 *  11.07.2013
 ******************************************************************************}

unit knsl2Pulsar2Meter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, knsl5tracer, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    CPulsarMeter = class(CMeter)
    private
        m_DotPosition : Integer; // ��������� �����
        m_Address     : WORD;
        m_Password    : DWORD; // ������ ��������

        m_QFNC        : WORD;
        //m_QFNC        : WORD;
        m_Req         : CQueryPrimitive;
        m_IsCurrCry   : Boolean;
        m_QTimestamp  : TDateTime;

        m_IsAuthorized: Boolean;
//        m_SresID      : Byte;
        dt_TLD          : TDateTime;
        nOldYear        : Word;
        bl_SaveCrEv     : boolean;
        nReq            : CQueryPrimitive;
    public
        // base
        constructor Create;
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

        procedure   HandQryRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        function    CRC8(_Packet: array of BYTE; _DataLen:Integer) : Byte;
        function    Crc16M(var Data:Array Of byte;size:byte):word;
        function    IsValidMessage(var pMsg : CMessage) : Byte;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
        function    FillMessageBody(var _Msg : CHMessage; _FNC : WORD; _DataBytes : BYTE) : WORD;
        function    FillMessageBodyTm(var _Msg : CHMessage; _FNC : WORD):WORD;
        function    FillMessageBodyData(var _Msg : CHMessage;_FNC,nPNUM:WORD;byData:array of Byte):WORD;
        function    FillMessageBodyArch(var _Msg:CHMessage;_FNC:WORD;Arch:Word;dtDateB,dtDateE:TDateTime):WORD;
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        function    BCDToInt(_BCD : BYTE) : BYTE;
        function    IntToBCD(_Int : BYTE) : BYTE;
        function    GetDATA4(_Buff : array of BYTE) : DWORD;
        function    GetDATA3(_Buff : array of BYTE) : DWORD;
        function    SwapDW(var swVal:Dword):Dword;

        procedure   getDateFromDs(nDisp:Integer;var dtB,dtE:TDateTime);

        Procedure Check;


        procedure   REQ_AUTORIZATION(var nReq: CQueryPrimitive);   // ����
        procedure   RES_AUTORIZATION(var pMsg:CMessage);           // �����

        procedure   REQ_SUM_RASH_V(var nReq: CQueryPrimitive);   // ����
        procedure   RES_SUM_RASH_V(var pMsg:CMessage);           // �����

        procedure   REQ_RASH_HOR_V(var nReq: CQueryPrimitive);   // ����
        procedure   RES_RASH_HOR_V(var pMsg:CMessage);           // �����

        procedure   REQ_RASH_DAY_V(var nReq: CQueryPrimitive);   // ����
        procedure   RES_RASH_DAY_V(var pMsg:CMessage);           // �����

        procedure   REQ_RASH_MON_V(var nReq: CQueryPrimitive);   // ����
        procedure   RES_RASH_MON_V(var pMsg:CMessage);           // �����

        procedure   REQ_RASH_AVE_V(var nReq: CQueryPrimitive);   // ����
        procedure   RES_RASH_AVE_V(var pMsg:CMessage);           // �����

        procedure   REQ_ReadDateTime(var nReq: CQueryPrimitive);   // ������ ����/�������
        procedure   RES_ReadDateTime(var pMsg : CMessage);         // �n���

        procedure   KorrTime(LastDate : TDateTime);
        procedure   RES_WriteDateTime(var pMsg : CMessage);


        procedure   REQ0138_GetEvents(var nReq: CQueryPrimitive);
        procedure   RES0138_GetEvents(var pMsg:CMessage);

    /////////////////////////////

        procedure   ADD_Energy_Sum_GraphQry();
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        //procedure   ADD_SresEnergyDay_GraphQry(_DTS, _DTE : TDateTime);
        procedure   ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyMonth_Qry(_DTS, _DTE : TDateTime);
        procedure   ADD_NakEnergyDay_Qry(_DTS, _DTE : TDateTime);
        procedure   ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);

    End;


implementation

const
CULCRBY_crc8tab : array[0..255] of byte = (
   $00, $b5, $df, $6a, $0b, $be, $d4, $61, $16, $a3, $c9, $7c, $1d, $a8,
   $c2, $77, $2c, $99, $f3, $46, $27, $92, $f8, $4d, $3a, $8f, $e5, $50,
   $31, $84, $ee, $5b, $58, $ed, $87, $32, $53, $e6, $8c, $39, $4e, $fb,
   $91, $24, $45, $f0, $9a, $2f, $74, $c1, $ab, $1e, $7f, $ca, $a0, $15,
   $62, $d7, $bd, $08, $69, $dc, $b6, $03, $b0, $05, $6f, $da, $bb, $0e,
   $64, $d1, $a6, $13, $79, $cc, $ad, $18, $72, $c7, $9c, $29, $43, $f6,
   $97, $22, $48, $fd, $8a, $3f, $55, $e0, $81, $34, $5e, $eb, $e8, $5d,
   $37, $82, $e3, $56, $3c, $89, $fe, $4b, $21, $94, $f5, $40, $2a, $9f,
   $c4, $71, $1b, $ae, $cf, $7a, $10, $a5, $d2, $67, $0d, $b8, $d9, $6c,
   $06, $b3, $d5, $60, $0a, $bf, $de, $6b, $01, $b4, $c3, $76, $1c, $a9,
   $c8, $7d, $17, $a2, $f9, $4c, $26, $93, $f2, $47, $2d, $98, $ef, $5a,
   $30, $85, $e4, $51, $3b, $8e, $8d, $38, $52, $e7, $86, $33, $59, $ec,
   $9b, $2e, $44, $f1, $90, $25, $4f, $fa, $a1, $14, $7e, $cb, $aa, $1f,
   $75, $c0, $b7, $02, $68, $dd, $bc, $09, $63, $d6, $65, $d0, $ba, $0f,
   $6e, $db, $b1, $04, $73, $c6, $ac, $19, $78, $cd, $a7, $12, $49, $fc,
   $96, $23, $42, $f7, $9d, $28, $5f, $ea, $80, $35, $54, $e1, $8b, $3e,
   $3d, $88, $e2, $57, $36, $83, $e9, $5c, $2b, $9e, $f4, $41, $20, $95,
   $ff, $4a, $11, $a4, $ce, $7b, $1a, $af, $c5, $70, $07, $b2, $d8, $6d,
   $0c, $b9, $d3, $66
);
CULCRBY_DotPosition : array[0..3] of integer = (1, 10, 100, 1000); 

{*******************************************************************************
 *
 ******************************************************************************}
constructor CPulsarMeter.Create;
Begin
  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> CULCR Meter Created');
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CPulsarMeter.Destroy;
Begin
    inherited;
End;

procedure CPulsarMeter.RunMeter; Begin end;

function CPulsarMeter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CPulsarMeter.InitMeter(var pL2:SL2TAG);
Var
  Year, Month, Day : Word;
begin
  m_Address := StrToInt(pL2.m_sddPHAddres);
  m_Password := StrToInt(pL2.m_schPassword);
  m_DotPosition := 100;
  IsUpdate := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CULCR Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;





{*******************************************************************************
 * ���������� ������� ������� ������
 ******************************************************************************}
function CPulsarMeter.LoHandler(var pMsg:CMessage):Boolean;
Var
    byErr : Byte;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      TraceM(2,pMsg.m_swObjID,'(__)CPULC::>Inp DRQ:',@pMsg);

      //ByteUnStuff(pMsg.m_sbyInfo, pMsg.m_swLen - 11);
      byErr := IsValidMessage(pMsg);
      if byErr=1 then
      Begin
       TraceM(2,pMsg.m_swObjID,'(__)CPULC::>Command Error :',@pMsg);
       Result := false;
       exit;
      End else
      if byErr=2 then
      begin
        TraceM(2,pMsg.m_swObjID,'(__)CPULC::>Crc Error :',@pMsg);
        Result := false;
        exit;
      end;
      case m_QFNC of // FUNCTION
        $0001 : RES_SUM_RASH_V(pMsg);
        $0106 : RES_RASH_HOR_V(pMsg);
        $0004 : RES_ReadDateTime(pMsg);
        $0005 : RES_WriteDateTime(pMsg);
        $0206 : RES_RASH_DAY_V(pMsg);
        $0306 : RES_RASH_MON_V(pMsg);
        $3e   : RES_RASH_AVE_V(pMsg);
        $000b : RES_AUTORIZATION(pMsg);
        //$0138 : RES0138_GetEvents(pMsg);
        else  FinalAction();
      end;
      if (m_nP.m_sbyStBlock and ST_L2_AUTO_BLOCK) <> 0 then
      begin
        m_nP.m_sbyStBlock := (m_nP.m_sbyStBlock xor ST_L2_AUTO_BLOCK) or ST_L2_NO_AUTO_BLOCK;
        m_pDB.UpdateBlStateMeter(m_nP.m_swMID, m_nP.m_sbyStBlock);
        CreateNoAutoBlockEv();
      end;
    end;
  end;
end;

{*******************************************************************************
 * ���������� ������� �������� ������
 ******************************************************************************}
function CPulsarMeter.HiHandler(var pMsg:CMessage):Boolean;
//Var
    //nReq : CQueryPrimitive;
begin
  Result := False;
                                 
  m_nRxMsg.m_sbyServerID := 0;
  case pMsg.m_sbyType of
    QL_DATARD_REQ:
    Begin
      Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
      if nReq.m_swParamID=QM_ENT_MTR_IND then Begin OnEnterAction;exit;End;
      if nReq.m_swParamID=QM_FIN_MTR_IND then Begin OnFinalAction;exit;End;

      case nReq.m_swParamID of
        QRY_AUTORIZATION : REQ_AUTORIZATION(nReq);
        QRY_SUM_RASH_V   : REQ_SUM_RASH_V(nReq);
        QRY_RASH_HOR_V   : REQ_RASH_HOR_V(nReq);
        QRY_RASH_DAY_V   : REQ_RASH_DAY_V(nReq);
        QRY_RASH_MON_V   : REQ_RASH_MON_V(nReq);
        QRY_RASH_AVE_V   : REQ_RASH_AVE_V(nReq);
        QRY_DATA_TIME    : REQ_ReadDateTime(nReq);
      else
          OnFinalAction;
      end;

      TraceM(2,pMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@pMsg);
//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);

    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


{*******************************************************************************
 * ������� ����������� �����
 * ������������ ����������� ���'��� ��������
 * BYTE CULCRBY_CRC(BYTE *buf, int len)
 * @param BYTE *buf ��������� �� ������ ������ ��� ��������
 * @param int len ���������� ��������� ��� �������� bcc
 * @return BYTE ����������� ����� BCC
 ******************************************************************************}
function CPulsarMeter.CRC8(_Packet: array of BYTE; _DataLen:Integer) : Byte;
var
  l_CRC : BYTE;
  i     : integer;
begin
  l_CRC := 0;
  for i:=1 to _DataLen-3 do
    l_CRC := CULCRBY_crc8tab[l_CRC xor _Packet[i]];

  Result := l_CRC;
end;
function CPulsarMeter.Crc16M(var Data:Array Of byte;size:byte):word;
Var
  w                 : word;
  shift_cnt, f      : byte;
  byte_cnt          : Word;
  res               : word;
Begin
  byte_cnt := size;
  w := $FFFF;
  While byte_cnt > 0 Do
  Begin
    w := w Xor Word(Data[size - byte_cnt]);
    For shift_cnt := 0 To 7 Do
    Begin
      f := Byte(w And 1);
      w := w Shr 1;
      If f = 1 Then
        w := w Xor $A001;
    End;
    dec(byte_cnt);
  End;
  result := w; 
  if size<>0 then
  result := w;
End;



{*******************************************************************************
 *  �������� ����������� ���������
 *      @param var pMsg : CMessage ���������
 *      @return Boolean 
 ******************************************************************************}
function CPulsarMeter.IsValidMessage(var pMsg : CMessage) : Byte;
var
    l_DataLen : WORD;
    l_ErrStr : String;
    wCrc,wCrcM: Word;
begin
    {
     m_nTxMsg.m_sbyInfo[byLen-1-1] := Lo(wCrc);
     m_nTxMsg.m_sbyInfo[byLen-1]   := Hi(wCrc);
    }
    wCrc  := 0;
    wCrc  := Crc16M(pMsg.m_sbyInfo[0],pMsg.m_swLen-11-2);
    wCrcM := Word(pMsg.m_sbyInfo[pMsg.m_swLen-11-1-1]) or
             (Word(pMsg.m_sbyInfo[pMsg.m_swLen-11-1]) shl 8);
    //TraceL(3{2},m_nP.m_swMID,'(__)CL2MD::>CRC:'+IntToHex(wCrc,2)+' CRCM:'+IntToHex(wCrcM,2));
    if wCrc<>wCrcM then
    begin
        TraceL(3{2},m_nP.m_swMID,'(__)CL2MD::>CPULC ������ CRC! �����!');
        Result := 2;
        exit;
    end;
  Result := 0;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CPulsarMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_PULCR;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CPulsarMeter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := 11 + 9 + 3;
    pMsg.m_swObjID     := m_nP.m_swMID;
    pMsg.m_sbyFrom     := DIR_L2TOL3;
    pMsg.m_sbyFor      := DIR_L2TOL3;
    pMsg.m_sbyType     := PH_EVENTS_INT;
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_PULCR;
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;

(*    m_nRxMsg.m_sbyInfo[0] := 9 + 3;
    m_nRxMsg.m_sbyInfo[8] := m_Address;
        move(pMsg.m_sbyInfo[10], m_nRxMsg.m_sbyInfo[9], 3);
        i := i + 4;

        if ((nReq.m_swSpecc0 = DepthEvEnd)) and (nReq.m_swParamID = QRY_JRNL_T1)  then
          m_nRxMsg.m_sbyInfo[11] := 1
        else
          m_nRxMsg.m_sbyInfo[11] := 0;
        if (DepthEvEnd = nReq.m_swSpecc0) and (nReq.m_swParamID <> QRY_JRNL_T1) then
          Result := true;
        if (nReq.m_swSpecc0 = -1) and (nReq.m_swParamID = QRY_JRNL_T1) then
          Result := true;
        if not Result then
          CreateJrnlReq(nReq);

        case m_nRxMsg.m_sbyInfo[1] of
             QRY_JRNL_T1 : ReadPhaseJrnl(m_nRxMsg);
             QRY_JRNL_T2 : ReadStateJrnl(m_nRxMsg);
             QRY_JRNL_T3 : ReadKorrJrnl(m_nRxMsg);
        End;

*)
end;


function CPulsarMeter.FillMessageBody(var _Msg : CHMessage; _FNC : WORD; _DataBytes : BYTE) : WORD;
Var
  dwAddr  : Dword;
  pAddr   : PByteArray;
  i       : Integer;
  dwChann : Dword;
  wRand   : Word;
  wCrc    : Word;
  byLen   : Byte;
  bL,bH   : Byte;
  wL      : Byte;
  j : Integer;
begin
  dwAddr := 0;
  byLen  := 12+2;
  dwAddr := StrToInt(m_nP.m_sddFabNum);
  pAddr  := @dwAddr;
  j:=0;
  for i:=Length(m_nP.m_sddFabNum) downto 1 do
  Begin
    if (j and 1)=0  then Begin bH:=0;bL := Byte(m_nP.m_sddFabNum[i]) and $0f;End else
    if (j and 1)<>0 then bH := Byte(m_nP.m_sddFabNum[i]) and $0f;
    if ((j and 1)<>0)or(i=1) then
    pAddr[trunc(j/2)] := (bL or (bH shl 4));
    j:=j+1;
  End;
  SwapDW(dwAddr);
  move(dwAddr,_Msg.m_sbyInfo[0],4);
  _Msg.m_sbyInfo[4] := Byte(_FNC);
  _Msg.m_sbyInfo[5] := byLen;
  dwChann := 1 shl StrToInt(m_nP.m_sddPHAddres);
  move(dwChann,_Msg.m_sbyInfo[6],4);
  //wRand := random(64000);
  wRand := 1;
  move(wRand,_Msg.m_sbyInfo[10],2);
  wCrc := Crc16M(_Msg.m_sbyInfo, byLen-2);
  _Msg.m_sbyInfo[byLen-1-1] := Lo(wCrc);
  _Msg.m_sbyInfo[byLen-1]   := Hi(wCrc);
  Result := byLen;
end;

function CPulsarMeter.FillMessageBodyTm(var _Msg : CHMessage; _FNC : WORD) : WORD;
Var
  dwAddr  : Dword;
  pAddr   : PByteArray;
  i       : Integer;
  dwChann : Dword;
  wRand   : Word;
  wCrc    : Word;
  byLen   : Byte;
  bL,bH   : Byte;
  wL      : Byte;
  j : Integer;
begin
  dwAddr := 0;
  byLen  := 8+2;
  dwAddr := StrToInt(m_nP.m_sddFabNum);
  pAddr  := @dwAddr;
  j:=0;
  for i:=Length(m_nP.m_sddFabNum) downto 1 do
  Begin
    if (j and 1)=0  then Begin bH:=0;bL := Byte(m_nP.m_sddFabNum[i]) and $0f;End else
    if (j and 1)<>0 then bH := Byte(m_nP.m_sddFabNum[i]) and $0f;
    if ((j and 1)<>0)or(i=1) then
    pAddr[trunc(j/2)] := (bL or (bH shl 4));
    j:=j+1;
  End;
  SwapDW(dwAddr);
  move(dwAddr,_Msg.m_sbyInfo[0],4);
  _Msg.m_sbyInfo[4] := Byte(_FNC);
  _Msg.m_sbyInfo[5] := byLen;
  //dwChann := 1 shl StrToInt(m_nP.m_sddPHAddres);
  //move(dwChann,_Msg.m_sbyInfo[6],4);
  //wRand := random(64000);
  wRand := 1;
  move(wRand,_Msg.m_sbyInfo[6],2);
  wCrc := Crc16M(_Msg.m_sbyInfo, byLen-2);
  _Msg.m_sbyInfo[byLen-1-1] := Lo(wCrc);
  _Msg.m_sbyInfo[byLen-1]   := Hi(wCrc);
  Result := byLen;
end;
function CPulsarMeter.FillMessageBodyData(var _Msg : CHMessage;_FNC,nPNUM:WORD;byData:array of Byte):WORD;
Var
  dwAddr  : Dword;
  pAddr   : PByteArray;
  i       : Integer;
  dwChann : Dword;
  wRand   : Word;
  wCrc    : Word;
  byLen   : Byte;
  bL,bH   : Byte;
  wL      : Byte;
  j : Integer;
begin
  dwAddr := 0;
  byLen  := 18+2;
  dwAddr := StrToInt(m_nP.m_sddFabNum);
  pAddr  := @dwAddr;
  j:=0;
  for i:=Length(m_nP.m_sddFabNum) downto 1 do
  Begin
    if (j and 1)=0  then Begin bH:=0;bL := Byte(m_nP.m_sddFabNum[i]) and $0f;End else
    if (j and 1)<>0 then bH := Byte(m_nP.m_sddFabNum[i]) and $0f;
    if ((j and 1)<>0)or(i=1) then
    pAddr[trunc(j/2)] := (bL or (bH shl 4));
    j:=j+1;
  End;
  SwapDW(dwAddr);
  move(dwAddr,_Msg.m_sbyInfo[0],4);
  _Msg.m_sbyInfo[4] := Byte(_FNC);
  _Msg.m_sbyInfo[5] := byLen;
  move(nPNUM,_Msg.m_sbyInfo[6],2);
  move(byData,_Msg.m_sbyInfo[8],8);
  wRand := 1;
  move(wRand,_Msg.m_sbyInfo[16],2);
  wCrc := Crc16M(_Msg.m_sbyInfo, byLen-2);
  _Msg.m_sbyInfo[byLen-1-1] := Lo(wCrc);
  _Msg.m_sbyInfo[byLen-1]   := Hi(wCrc);
  Result := byLen;
end;

function CPulsarMeter.FillMessageBodyArch(var _Msg:CHMessage;_FNC:WORD;Arch:Word;dtDateB,dtDateE:TDateTime):WORD;
Var
  dwAddr  : Dword;
  pAddr   : PByteArray;
  i       : Integer;
  dwChann : Dword;
  wRand   : Word;
  wCrc    : Word;
  byLen   : Byte;
  bL,bH   : Byte;
  wL      : Byte;
  j       : Integer;
  Year,Month,Day,Hour,Min,Sec,mSec : Word;
begin
  dwAddr := 0;
  byLen  := 26+2;
  dwAddr := StrToInt(m_nP.m_sddFabNum);
  pAddr  := @dwAddr;
  j:=0;
  for i:=Length(m_nP.m_sddFabNum) downto 1 do
  Begin
    if (j and 1)=0  then Begin bH:=0;bL := Byte(m_nP.m_sddFabNum[i]) and $0f;End else
    if (j and 1)<>0 then bH := Byte(m_nP.m_sddFabNum[i]) and $0f;
    if ((j and 1)<>0)or(i=1) then
    pAddr[trunc(j/2)] := (bL or (bH shl 4));
    j:=j+1;
  End;
  SwapDW(dwAddr);
  move(dwAddr,_Msg.m_sbyInfo[0],4);

  _Msg.m_sbyInfo[4] := Byte(_FNC);
  _Msg.m_sbyInfo[5] := byLen;

  dwChann := 1 shl StrToInt(m_nP.m_sddPHAddres);
  move(dwChann,_Msg.m_sbyInfo[6],4);

  move(Arch,_Msg.m_sbyInfo[10],2);

  DecodeDate(dtDateB,Year,Month,Day);
  DecodeTime(dtDateB,Hour,Min,Sec,mSec);
  _Msg.m_sbyInfo[12] := Byte(Year-2000);
  _Msg.m_sbyInfo[13] := Byte(Month);
  _Msg.m_sbyInfo[14] := Byte(Day);
  _Msg.m_sbyInfo[15] := Byte(Hour);
  _Msg.m_sbyInfo[16] := Byte(Min);
  _Msg.m_sbyInfo[17] := Byte(Sec);

  DecodeDate(dtDateE,Year,Month,Day);
  DecodeTime(dtDateE,Hour,Min,Sec,mSec);
  _Msg.m_sbyInfo[18] := Byte(Year-2000);
  _Msg.m_sbyInfo[19] := Byte(Month);
  _Msg.m_sbyInfo[20] := Byte(Day);
  _Msg.m_sbyInfo[21] := Byte(Hour);
  _Msg.m_sbyInfo[22] := Byte(Min);
  _Msg.m_sbyInfo[23] := Byte(Sec);

  //wRand := random(64000);
  wRand := 1;
  move(wRand,_Msg.m_sbyInfo[24],2);
  wCrc := Crc16M(_Msg.m_sbyInfo, byLen-2);
  _Msg.m_sbyInfo[byLen-1-1] := Lo(wCrc);
  _Msg.m_sbyInfo[byLen-1]   := Hi(wCrc);
  Result := byLen;
end;
Procedure CPulsarMeter.Check;
Var
  A                 : Array[0..99] Of byte;
  W, L              : Word;
  Addres            : Dword;
  AddrB             : Array[0..3] Of byte absolute Addres;
Begin
  Addres := $00035224;

  A[0] := AddrB[3];
  A[1] := AddrB[2];
  A[2] := AddrB[1];
  A[3] := AddrB[0];

//  A[4] := $0A;
//  A[5] := $0C;
//
//  A[6] := $06;
//  A[7] := $00;

//  A[8] := $DE;
//  A[9] := $2F;

//  L := 10;

//  A[4] := $04;
//  A[5] := $0A;
//
//  A[6] := $78;
//  A[7] := $8A;
//
//  L := 8;


  A[4] := $01;
  A[5] := $0E;

  A[6] := $03;
  A[7] := $00;
  A[8] := $00;
  A[9] := $00;

  A[10] := $5E;
  A[11] := $A4;
  L := 12;



  //W := Crc16M(A, L);
  A[L + 0] := Lo(W);
  A[L + 1] := Hi(W);

  //Comm1.OpenPort;
  //Comm1.Write(A, L + 2);
  //Sleep(100);
End;



{*******************************************************************************
 *  ������������ ��������� ���������� ������
 *      @param _Value : double �������� ���������
 *      @param _EType : byte ��� �������
 *      @param _Tariff : byte ������
 *      @param _WriteDate : Boolean ���������� ����� �������
 ******************************************************************************}
procedure CPulsarMeter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
var
    l_Year, l_Month, l_Day,
    l_Hour, l_Min, l_Second, l_MS : word;
begin
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
   m_nRxMsg.m_sbyInfo[1] := _ParamID; 
   m_nRxMsg.m_sbyInfo[8] := _Tariff;
   move(_Value, m_nRxMsg.m_sbyInfo[9], sizeof(double));
   m_nRxMsg.m_sbyDirID   := IsUpdate;
   m_nRxMsg.m_sbyServerID:= 0;


   if _WriteDate=false then
        exit;


    case _ParamID of
        QRY_NAK_EN_MONTH_EP :
        begin
            cDateTimeR.IncMonth(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := 1;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
          end;

        QRY_RASH_DAY_V,QRY_RASH_MON_V :
        begin
            //cDateTimeR.IncDate(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := l_Day;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
        end;
    else
        DecodeDate(Now(), l_Year, l_Month, l_Day);
        DecodeTime(Now(), l_Hour, l_Min, l_Second, l_MS);
        m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := l_Month;
        m_nRxMsg.m_sbyInfo[4] := l_Day;
        m_nRxMsg.m_sbyInfo[5] := l_Hour;
        m_nRxMsg.m_sbyInfo[6] := l_Min;
        m_nRxMsg.m_sbyInfo[7] := l_Second;
    end;
end;


procedure CPulsarMeter.HandQryRoutine(var pMsg:CMessage);
Var
    DTS, DTE : TDateTime;
    l_Param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));

    Move(pDS.m_sbyInfo[0],DTE,szDT);
    Move(pDS.m_sbyInfo[szDT],DTS,szDT);

    l_Param := pDS.m_swData1;
    case l_Param of
      QRY_SRES_ENR_EP,
      QRY_RASH_HOR_V :
        ADD_SresEnergyDay_GraphQry(DTS, DTE);

      QRY_RASH_DAY_V:
        ADD_NakEnergyDay_Qry(DTS, DTE);

      QRY_RASH_MON_V:
        ADD_NakEnergyMonth_Qry(DTS, DTE);

      QRY_ENERGY_SUM_EP:
          ADD_Energy_Sum_GraphQry();

        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;



procedure CPulsarMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
    OnFinalAction();
    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CPULC OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CPulsarMeter.OnEnterAction;
begin
  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CPULC OnEnterAction');
  if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
    OpenPhone
  else if m_nP.m_sbyModem=0 then
    FinalAction;
end;

procedure CPulsarMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CPULC OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CPulsarMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CPULC OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CPulsarMeter.OnFinalAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CPULC OnFinalAction');
    m_IsCurrCry := false;
    FinalAction;
end;




function CPulsarMeter.BCDToInt(_BCD : BYTE) : BYTE;
begin
  Result := ((_BCD AND $F0) shr 4)*10 + (_BCD AND $0F);
end;

function CPulsarMeter.IntToBCD(_Int : BYTE) : BYTE;
begin
  Result := (_Int mod 10) or ((_Int div 10) shl 4);
end;

function CPulsarMeter.GetDATA4(_Buff : array of BYTE) : DWORD;
var
  l_pDW : array[0..3] of BYTE absolute Result;
begin
  Result := 0;

  l_pDW[0] := _Buff[0];
  l_pDW[1] := _Buff[1];
  l_pDW[2] := _Buff[2];
  l_pDW[3] := _Buff[3];
end;

function CPulsarMeter.GetDATA3(_Buff : array of BYTE) : DWORD;
var
  l_pDW : array[0..3] of BYTE absolute Result;
begin
  Result := 0;

  l_pDW[0] := _Buff[0];
  l_pDW[1] := _Buff[1];
  l_pDW[2] := _Buff[2];
  l_pDW[3] := 0;
end;
function CPulsarMeter.SwapDW(var swVal:Dword):Dword;
var
    b0 : array[0..3] of Byte;
    pB : PbyteArray;
Begin
    pB := @swVal;
    move(swVal,b0,4);
    pB[3] := b0[0];
    pB[2] := b0[1];
    pB[1] := b0[2];
    pB[0] := b0[3];
    Result := swVal;
End;

(*******************************************************************************
 * ������� "AUTORIZATION"
 ******************************************************************************)
procedure CPulsarMeter.REQ_AUTORIZATION(var nReq: CQueryPrimitive);
Var
  byData : array[0..7] of Byte;
  psNew,psOld : DWord;
begin
  psNew := 0;
  psOld := StrToInt(m_nP.m_schPassword);
  //psOld := 0;
  SwapDW(psNew);
  SwapDW(psOld);
  move(psNew,byData[0],4);
  move(psOld,byData[4],4);
  m_QTimestamp := Now();
  m_QFNC := $000b; // ������� ������ � ��������
  m_Req := nReq;
  //FillMessageHead(m_nTxMsg, FillMessageBodyData(m_nTxMsg,m_QFNC,$01,byData));
  FillMessageHead(m_nTxMsg, FillMessageBodyData(m_nTxMsg,m_QFNC,$99,byData));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;
(*******************************************************************************
 * ������� "Ping"
 *   2 ����� - ����� ����������.
 ******************************************************************************)
procedure CPulsarMeter.RES_AUTORIZATION(var pMsg:CMessage);
var
  l_V : word;
begin
  move(pMsg.m_sbyInfo[6], l_V, 2);
  if l_V=0 then
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CPULC::> �������� �����������: ') else
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CPULC::> ������ �����������');
  FinalAction();
end;


(*******************************************************************************
 * ������� "Ping"
 ******************************************************************************)
procedure CPulsarMeter.REQ_SUM_RASH_V(var nReq: CQueryPrimitive);
begin

  m_QTimestamp := Now();
  m_QFNC := $0001; // ������� ������ � ��������
  m_Req := nReq;

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);


end;
(*******************************************************************************
 * ������� "Ping"
 *   2 ����� - ����� ����������.
 ******************************************************************************)
procedure CPulsarMeter.RES_SUM_RASH_V(var pMsg:CMessage);
var
  l_V : double;
begin
  move(pMsg.m_sbyInfo[6], l_V, sizeof(double));
  l_V := l_V*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CPULC::> ����� ������: ' + FloatToStr(l_V));
  FillSaveDataMessage(l_V, m_Req.m_swParamID, 0, true);FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(l_V, m_Req.m_swParamID, 1, true);FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(0, m_Req.m_swParamID, 2, true);FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(0, m_Req.m_swParamID, 3, true);FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(0, m_Req.m_swParamID, 4, true);FPUT(BOX_L3, @m_nRxMsg);
  FinalAction();
end;

(*******************************************************************************
 * ReadDateTime	0x1C	������ ������� � ����
 ******************************************************************************)
procedure CPulsarMeter.REQ_ReadDateTime(var nReq: CQueryPrimitive);
begin
  m_QTimestamp := Now();
  m_QFNC := $04;
  m_Req := nReq;
  FillMessageHead(m_nTxMsg, FillMessageBodyTm(m_nTxMsg, m_QFNC));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� "������ ������� � ����"
 *******************************************************************************)

procedure CPulsarMeter.RES_ReadDateTime(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;
  LastDate:TDateTime;
begin
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    _yy := (pMsg.m_sbyInfo[6]);
    _mn := (pMsg.m_sbyInfo[7]);
    _dd := (pMsg.m_sbyInfo[8]);
    _hh := (pMsg.m_sbyInfo[9]);
    _mm := (pMsg.m_sbyInfo[10]);
    _ss := (pMsg.m_sbyInfo[11]);
    if (_mn>12)or(_mn=0)or(_dd>31)or(_dd=0)or(_hh>59)or(_mm>59)or(_ss>59) then
    Begin
     FinalAction;
     exit;
    End;
    TraceL(2,m_nRxMsg.m_swObjID,'(__)CPULS::>Read Time: '+IntToStr(_yy)+':'+IntToStr(_mn)+':'+IntToStr(_dd)+'  '+
                                                          IntToStr(_hh)+':'+IntToStr(_mm)+':'+IntToStr(_ss));
    //i:=i+3;
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
        //�������� �������� �������� ���������� ��� �������� ����
        if nOldYear<>Year then
        Begin
         m_nP.m_sdtSumKor :=cDateTimeR.SecToDateTime(0);
         m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
        End;
        nOldYear := Year;
        LastDate := EncodeDate(_yy + 2000, _mn, _dd) + EncodeTime(_hh, _mm, _ss, 0);
        Year := Year - 2000;
        //���������� ����� ������� �� ����������������� ��������
        if (m_nP.m_bySynchro=1) then
        Begin
         if m_nMSynchKorr.m_blEnable=False then
         Begin
          m_nMSynchKorr.m_tmTime := LastDate;
          cDateTimeR.KorrTimeToPC(m_nMSynchKorr.m_tmTime,m_nMaxKorrTime);
          FinalAction;
          exit;
         End else m_nMSynchKorr.m_blEnable := False;
        End;
        //��������� �������
        nKorrTime :=5;
        if ((m_nIsOneSynchro=1)and(m_nP.m_blOneSynchro=True)) then nKorrTime :=1;
        if (Year <> _yy) or (Month <> _mn) or (Day <> _dd)
        or (Hour <> _hh) or (Min <> _mm) or (abs(_ss - Sec) >= nKorrTime) then
        begin
         //����� �������� ��������������� ������ ���� ���� ��� ����� ��������� ������� �������
         if (m_nIsOneSynchro=0)or((m_nIsOneSynchro=1)and(m_nP.m_blOneSynchro=True)) then
          Begin
          if m_nIsOneSynchro=1 then m_nP.m_blOneSynchro := False;
          {$IFNDEF SS301_DEBUG}
           KorrTime(LastDate);
           {$ELSE}
           FinalAction;
          {$ENDIF}
          End else FinalAction;
         end else FinalAction;
end;
procedure CPulsarMeter.KorrTime(LastDate : TDateTime);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
  dwAddr  : Dword;
  pAddr   : PByteArray;
  i,j     : Integer;
  dwChann : Dword;
  wRand   : Word;
  wCrc    : Word;
  byLen   : Byte;
  bL,bH   : Byte;
  wL      : Byte;
begin
    TraceL(2,m_nRxMsg.m_swObjID,'(__)CL2MD::>   Korrection Time');
    if abs(LastDate - Now) < EncodeTime(0, 0, 1, 0) then
      bl_SaveCrEv := false
    else
      bl_SaveCrEv := true;
    m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, mSec);
    Year := Year - 2000;
    if m_nP.m_sdtSumKor < m_nP.m_sdtLimKor then
    begin
      dt_TLD := LastDate;
      { }
    end;
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then
    begin
      m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
      m_nRxMsg.m_sbyInfo[0] := 11 + 8;
      m_nRxMsg.m_sbyInfo[1] := QRY_LIM_TIME_KORR;
      m_nRxMsg.m_sbyInfo[2] := Year;
      m_nRxMsg.m_sbyInfo[3] := Month;
      m_nRxMsg.m_sbyInfo[4] := Day;
      m_nRxMsg.m_sbyInfo[5] := Hour;
      m_nRxMsg.m_sbyInfo[6] := Min;
      m_nRxMsg.m_sbyInfo[7] := Sec;
      FPUT(BOX_L3_BY, @m_nRxMsg);
      FinalAction;
      exit;
    end;
{
// BCD
  m_nTxMsg.m_sbyInfo[13] := IntToBCD(l_ss);
  m_nTxMsg.m_sbyInfo[14] := IntToBCD(l_mm);
  m_nTxMsg.m_sbyInfo[15] := IntToBCD(l_hh);
  m_nTxMsg.m_sbyInfo[16] := DayOfWeek(Now()) - 1;

  m_nTxMsg.m_sbyInfo[17] := IntToBCD(l_D);
  m_nTxMsg.m_sbyInfo[18] := IntToBCD(l_M);
  m_nTxMsg.m_sbyInfo[19] := IntToBCD(l_Y - 2000);
}

    m_QTimestamp := Now();
    m_QFNC       := $0005;
    m_Req := nReq;

    DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
    DecodeDate(m_QTimestamp, Year, Month, Day);

    // BCD
    FillMessageHead(m_nTxMsg,16);
    dwAddr := 0;
    byLen  := 14+2;
    dwAddr := StrToInt(m_nP.m_sddFabNum);
    pAddr  := @dwAddr;
    j:=0;
    for i:=Length(m_nP.m_sddFabNum) downto 1 do
    Begin
      if (j and 1)=0  then Begin bH:=0;bL := Byte(m_nP.m_sddFabNum[i]) and $0f;End else
      if (j and 1)<>0 then bH := Byte(m_nP.m_sddFabNum[i]) and $0f;
      if ((j and 1)<>0)or(i=1) then
      pAddr[trunc(j/2)] := (bL or (bH shl 4));
      j:=j+1;
    End;
    SwapDW(dwAddr);
    move(dwAddr,m_nTxMsg.m_sbyInfo[0],4);
    m_nTxMsg.m_sbyInfo[4] := 5;
    m_nTxMsg.m_sbyInfo[5] := byLen;

    m_nTxMsg.m_sbyInfo[6] := Byte(Year - 2000);
    m_nTxMsg.m_sbyInfo[7] := Byte(Month);
    m_nTxMsg.m_sbyInfo[8] := Byte(Day);

    m_nTxMsg.m_sbyInfo[9] := Byte(Hour);
    m_nTxMsg.m_sbyInfo[10]:= Byte(Min);
    m_nTxMsg.m_sbyInfo[11]:= Byte(Sec);

    wRand := 1;
    move(wRand,m_nTxMsg.m_sbyInfo[12],2);
    wCrc := Crc16M(m_nTxMsg.m_sbyInfo, byLen-2);
    m_nTxMsg.m_sbyInfo[byLen-1-1] := Lo(wCrc);
    m_nTxMsg.m_sbyInfo[byLen-1]   := Hi(wCrc);

    SendToL1(BOX_L1, @m_nTxMsg);
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
    if bl_SaveCrEv then
      StartCorrEv(LastDate);
end;
(*******************************************************************************
 * ����� �� ������� "������ ������� � ���� � �������" (������� ������ �� 4-� ������)
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x00	����� "�������� ��������� �������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 * ������ ������� ��� �������� ������� ������������.
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CPulsarMeter.RES_WriteDateTime(var pMsg:CMessage);
begin
    if pMsg.m_sbyInfo[6]=1 then
    Begin
     TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer43::> ����� �������� �����������: ' + DateTimeToStr(Now()));
     m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
      if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
     m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
     if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
     //End else
     //ErrorCorrEv;
     FinalAction();
     m_QFNC:=0;
    End else
    Begin
     TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer43::> ����� �������� �� �����������: ' + DateTimeToStr(Now()));
     ErrorCorrEv;
     FinalAction();
     m_QFNC:=0;
    End;
end;
(******************************************************************************
 * ������ � ����
 ******************************************************************************)
procedure CPulsarMeter.REQ_RASH_DAY_V(var nReq: CQueryPrimitive);
begin
  m_QTimestamp := Now();
  m_QFNC       := $0206;
  m_Req        := nReq;
  m_QTimestamp := m_QTimestamp - nReq.m_swSpecc0;
  m_QTimestamp := trunc(m_QTimestamp);
  FillMessageHead(m_nTxMsg, FillMessageBodyArch(m_nTxMsg,m_QFNC,2,m_QTimestamp,m_QTimestamp));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;
{
  _Msg.m_sbyInfo[12] := Byte(Year-2000);
  _Msg.m_sbyInfo[13] := Byte(Month);
  _Msg.m_sbyInfo[14] := Byte(Day);
  _Msg.m_sbyInfo[15] := Byte(Hour);
  _Msg.m_sbyInfo[16] := Byte(Min);
  _Msg.m_sbyInfo[17] := Byte(Sec);
}
procedure CPulsarMeter.RES_RASH_DAY_V(var pMsg:CMessage);
var
  l_V : double;
  fValue : Single;
  dwValue: Dword;
  //Year,Month,Day:Word;
  //dtDate : TDateTime;
begin
  try
   move(pMsg.m_sbyInfo[16],dwValue,4);
   if (dwValue=$fffffff1)or(dwValue=$fffffff0) then fValue := 0 else
   move(dwValue,fValue,4);
   //Year  := pMsg.m_sbyInfo[10];
   //Month := pMsg.m_sbyInfo[11];
   //Day   := pMsg.m_sbyInfo[12];
   //dtDate := EncodeDate(2000+Year,Month,Day);
   //if (dtDate<>m_QTimestamp) then
   //    m_QTimestamp := dtDate;

   l_V := fValue*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;

   FillSaveDataMessage(l_V, m_Req.m_swParamID, 0, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(l_V, m_Req.m_swParamID, 1, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(0, m_Req.m_swParamID, 2, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(0, m_Req.m_swParamID, 3, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(0, m_Req.m_swParamID, 4, true);FPUT(BOX_L3, @m_nRxMsg);
   FinalAction();
  except
   FinalAction();
  end;
end;
(******************************************************************************
 * ����������� �� ����� ������
 ******************************************************************************)
procedure CPulsarMeter.REQ_RASH_MON_V(var nReq: CQueryPrimitive);
Var
  l_Y, l_M, l_D : Word;
Begin
  m_QTimestamp := trunc(Now());
  m_QFNC       := $0306;
  m_Req        := nReq;

  cDateTimeR.DecMonthEx(nReq.m_swSpecc0,m_QTimestamp);
  DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
  m_QTimestamp := EncodeDate(l_Y, l_M, 1);

  FillMessageHead(m_nTxMsg, FillMessageBodyArch(m_nTxMsg,m_QFNC,3,m_QTimestamp,m_QTimestamp));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;
procedure CPulsarMeter.RES_RASH_MON_V(var pMsg:CMessage);
var
  l_V : double;
  fValue : Single;
  dwValue : Dword;
  //Year,Month,Day:Word;
  //dtDate : TDateTime;
begin
  try
   move(pMsg.m_sbyInfo[16],dwValue,4);
   if (dwValue=$fffffff1)or(dwValue=$fffffff0) then fValue := 0 else
   move(dwValue,fValue,4);
   
   l_V := fValue*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;

   FillSaveDataMessage(l_V, m_Req.m_swParamID, 0, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(l_V, m_Req.m_swParamID, 1, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(0, m_Req.m_swParamID, 2, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(0, m_Req.m_swParamID, 3, true);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(0, m_Req.m_swParamID, 4, true);FPUT(BOX_L3, @m_nRxMsg);
   FinalAction();
  except
   FinalAction();
  end;
end;


(*******************************************************************************
 * ReadPower
	  ������  ��������, ����������� �� �������� ���������
 ******************************************************************************)
procedure CPulsarMeter.REQ_RASH_AVE_V(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $3e;
  m_QTimestamp := Now();
  m_Req := nReq;
  
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * �����
 *******************************************************************************)
procedure CPulsarMeter.RES_RASH_AVE_V(var pMsg:CMessage);
var
  l_V : double;
begin
  move(pMsg.m_sbyInfo[6], l_V, sizeof(double));
  l_V := l_V*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CPULC::> ������� ������: ' + FloatToStr(l_V));
  FillSaveDataMessage(l_V, m_Req.m_swParamID, 0, true); FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(l_V, m_Req.m_swParamID, 1, true); FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(0, m_Req.m_swParamID, 2, true); FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(0, m_Req.m_swParamID, 3, true); FPUT(BOX_L3, @m_nRxMsg);
  FillSaveDataMessage(0, m_Req.m_swParamID, 4, true); FPUT(BOX_L3, @m_nRxMsg);
  FinalAction();
end;


(*******************************************************************************
 * ������ ����������� �������� ������� �� ���������  90 �����
 ******************************************************************************)
//m_nObserver.AddGraphParam(QRY_RASH_HOR_V, mn, d, Srez, 1)
procedure   CPulsarMeter.REQ_RASH_HOR_V(var nReq: CQueryPrimitive);
var
  l_D,l_M,l_Y : WORD;
  l_H,l_MN,l_S,l_MS : WORD;
  dtB,dtE : TDateTime;
begin
  m_QFNC := $0106;
  m_Req  := nReq;
  getDateFromDs(nReq.m_swSpecc0,dtB,dtE);
  DecodeDate(dtB,l_Y,l_M,l_D);
  m_QTimestamp := EncodeDate(l_Y,l_M,l_D);
  FillMessageHead(m_nTxMsg, FillMessageBodyArch(m_nTxMsg,m_QFNC,1,dtE,dtB));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;
procedure CPulsarMeter.getDateFromDs(nDisp:Integer;var dtB,dtE:TDateTime);
Var
  nH,nMn,nS,nmS : Word;
  tDate : TDateTime;
Begin
  tDate := Now-nDisp;
  nH    := 23;
  if nDisp=0 then
  DecodeTime(tDate,nH,nMn,nS,nmS);
  dtB := trunc(tDate) + EncodeTime(nH,0,0,0);
  dtE := trunc(tDate) - EncodeTime(1,0,0,0);

  {else
  begin
  dtB := trunc(tDate) + EncodeTime(nH,0,0,0);
  dtE := trunc(tDate) - EncodeTime(0,0,0,0);
  end;
  }
  End;
(*******************************************************************************
 * �����
 ******************************************************************************)
procedure   CPulsarMeter.RES_RASH_HOR_V(var pMsg : CMessage);
var
  fTV,l_V,Rpok,Rpoktek    : Double;
  fValue : Single;
  i,k,nLen,ll: integer;
  l_t,dwValue : DWORD;
  l_Y, l_M, l_D,
  l_hh, l_mm, l_ss, l_ms : WORD;
begin
  DecodeTime(Now(), l_hh, l_mm, l_ss, l_ms);
  DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
  nLen := trunc((pMsg.m_sbyInfo[5]-20)/4);
  k:=0;
  i:=0;
  if (m_Req.m_swSpecc0<>0)then
    nLen := nLen - 0 else
  if (m_Req.m_swSpecc0=0)then
    nLen := nLen - 0 - 1;
  //l_V := 5;
  for i:=0 to nLen-1 do
    begin
    IsUpdate := 1;
    FillSaveDataMessage(0, 0, 0, false);
    m_nRxMsg.m_sbyDirID   := IsUpdate;
    m_nRxMsg.m_sbyServerID:= i;
    m_nRxMsg.m_swLen      := 11 + 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[1] := QRY_RASH_HOR_V;
    m_nRxMsg.m_sbyInfo[2] := l_Y-2000;
    m_nRxMsg.m_sbyInfo[3] := l_M;
    m_nRxMsg.m_sbyInfo[4] := l_D;
    m_nRxMsg.m_sbyInfo[5] := 0; // H
    m_nRxMsg.m_sbyInfo[6] := 0; // M
    m_nRxMsg.m_sbyInfo[7] := 0; // S
    m_nRxMsg.m_sbyInfo[8] := 0; // HH
    move(pMsg.m_sbyInfo[16+4*i],dwValue,4);
    if (dwValue=$fffffff1)or(dwValue=$fffffff0) then
    fValue := 0 else
    move(dwValue,fValue,4);
    if (fValue>10000000) or (fValue<0) then
     fValue := 0;

    //if (i and 1)<>0 then l_V := l_V + 10 else
    //l_V := l_V + 5;
    l_V := fValue;
    if (i=0) then
    Begin
     Rpok:=l_V;
    End else
    if (i<>0) then
    Begin
     fTV  := l_V - Rpok;
     Rpok := l_V;
     fTV  := fTV / 2;
     fTV  := fTV*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     move(fTV, m_nRxMsg.m_sbyInfo[9], sizeof(double));
     m_nRxMsg.m_sbyServerID := k;
     FPUT(BOX_L3_BY, @m_nRxMsg);
      Inc(k);
      m_nRxMsg.m_sbyServerID := k;
      FPUT(BOX_L3_BY, @m_nRxMsg);
      Inc(k);
    End;
    {
    if (i=0) then
    begin
     Rpok:=l_V;
    end;
         if (i=2) then
         begin
         Rpok:=l_V-Rpok;
         Rpoktek:=l_V;
         l_V:=Rpok;
         move(l_V, m_nRxMsg.m_sbyInfo[9], sizeof(double));
         FPUT(BOX_L3_BY, @m_nRxMsg);
         m_nRxMsg.m_sbyServerID:= i-1;
         FPUT(BOX_L3_BY, @m_nRxMsg);
         end;

    if (i>2)then
    begin
    l_V:=l_V - Rpoktek;
    //Rpoktek:=l_V;
    //l_V:=Ras;
    move(l_V, m_nRxMsg.m_sbyInfo[9], sizeof(double));
    FPUT(BOX_L3_BY, @m_nRxMsg);
    m_nRxMsg.m_sbyServerID:= i-1;
    FPUT(BOX_L3_BY, @m_nRxMsg);
     end;
    }
  end;
  FinalAction();
end;

                          //781 696 932
                          //75yph6

(******************************************************************************
 * ������ ������ �� �������
 ******************************************************************************)
procedure CPulsarMeter.REQ0138_GetEvents(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0138;
  m_QTimestamp := Now();
  m_Req := nReq;

  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc0;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc1;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CPULC::>Out DRQ:',@m_nTxMsg);
end;


(******************************************************************************
 * �����
 ******************************************************************************)
procedure CPulsarMeter.RES0138_GetEvents(var pMsg:CMessage);
var
  l_EvCode,
  l_Y, l_M, l_D, l_hh, l_mm,l_ss : WORD;
  l_DT : TDateTime;
begin

  l_Y := BCDToInt(pMsg.m_sbyInfo[15]) + 2000;
  l_M := BCDToInt(pMsg.m_sbyInfo[14]);
  l_D := BCDToInt(pMsg.m_sbyInfo[13]);

  l_hh := BCDToInt(pMsg.m_sbyInfo[11]);
  l_mm := BCDToInt(pMsg.m_sbyInfo[10]);
  l_ss := BCDToInt(pMsg.m_sbyInfo[9]);

  l_DT := EncodeDate(l_Y, l_M, l_D) + EncodeTime(l_hh, l_mm, l_ss, 0);


    l_EvCode := pMsg.m_sbyInfo[16];

    TraceL(3, m_nTxMsg.m_swObjID, '(__)CPULC::> EVENT TY: ' + IntToStr(m_Req.m_swCmdID - QRY_JRNL_T1) + ' #' + IntToStr(l_EvCode) + ' : ' + DateTimeToStr(l_DT) );
    FinalAction();  
end;










(*******************************************************************************
 * ������������ ������� �� ���������� ��������� ������������ �������
 ******************************************************************************)
procedure CPulsarMeter.ADD_Energy_Sum_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CPulsarMeter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CPulsarMeter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
end;

{*******************************************************************************
 * ������������ ������� �� ���������� 
 ******************************************************************************}
procedure CPulsarMeter.ADD_NakEnergyMonth_Qry(_DTS, _DTE : TDateTime);
var
  l_MonthsLeft : WORD;
  i : integer;
  l_Now : TDateTime;
begin
  m_nObserver.ClearGraphQry();
  if (cDateTimeR.CompareMonth(_DTE, Now()) = 1) then
    _DTE := Now();

  l_MonthsLeft := 0;
  l_Now := Now();
  while (cDateTimeR.CompareMonth(_DTE, l_Now) = 2) do
  begin
    cDateTimeR.DecMonth(l_Now);
    Inc(l_MonthsLeft);
  end;
  
  while (cDateTimeR.CompareMonth(_DTS, _DTE) <> 1) do
  begin
    m_nObserver.AddGraphParam(QRY_RASH_MON_V, l_MonthsLeft, 0, 0, 1);
    cDateTimeR.DecMonth(_DTE);
    Inc(l_MonthsLeft);
  end;
end;

procedure CPulsarMeter.ADD_NakEnergyDay_Qry(_DTS, _DTE : TDateTime);
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_RASH_DAY_V, trunc(now-_DTS), 0, 0, 1);
end;

procedure CPulsarMeter.ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_MGAKT_POW_S, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� ����������� ������
    @param DTS  TDateTime ������ �������
    @param DTE  TDateTime ��������� �������
 ******************************************************************************}

procedure CPulsarMeter.ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
Begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_RASH_HOR_V, trunc(now-dt_Date2), 0, 0, 1);
End;
{
var TempDate    : TDateTime;
    i, Srez     : integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    DeepSrez    : word;
begin
   DecodeTime(Now, h, m, s, ms);
   DeepSrez := 0;
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     DecodeDate(dt_Date2, y, mn, d);
     if cDateTimeR.CompareDay(dt_Date2, Now) = 0 then
     Begin
        for Srez := (h*60 + m) div 30 - 1 downto 0 do m_nObserver.AddGraphParam(QRY_RASH_HOR_V, mn, d, Srez, 1)
     End else
     Begin
      Srez := 0;
      while Srez <= 47 do
      begin
        m_nObserver.AddGraphParam(QRY_RASH_HOR_V, mn, d, Srez, 1);
        Srez := Srez + 1
      end;
     End;
     cDateTimeR.DecDate(dt_Date2);
     Inc(DeepSrez);
     if (DeepSrez > 365) then
       exit;
   end;
end;
}

End.
