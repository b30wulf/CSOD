{*******************************************************************************
 *  ������ ��������� �������� ���������� ��102
 *  Ukrop
 *  11.07.2013
 ******************************************************************************}

unit knsl2CE16401MMeter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, {knsl3EventBox,}utlmd5,Math;

type
    CCommand = packed record
     byLen : Byte;
     byCmd : Byte;
     byInfo: array[0..50] of Byte;
    End;
    CDBData = packed record
     wCHTar  : Word;
     dtDate  : Dword;
     byStatus: Byte;
     dbVal   : double;
    End;
    CDBData40 = packed record
     wCHTar  : Word;
     dtDate  : Dword;
     byStatus: Byte;
     dbVal   : array[0..4] of byte;
    End;
    CDBData22 = packed record
     wCHTar  : Word;
     byStatus: Byte;
     dtDate  : Dword;
     dbVal   : array[0..4] of byte;
    End;

    CCE16401MMeter = class(CMeter)
    private
        m_DotPosition : Integer; // ��������� �����
        m_Address     : WORD;
        m_Password    : DWORD; // ������ ��������

        DTS_V, DTE_V : TDateTime; //����� ��� ���������� ������� ������ ��� �����������
        m_QFNC        : WORD;
        m_Req         : CQueryPrimitive;
        m_IsCurrCry   : Boolean;
        m_QTimestamp  : TDateTime;
        mCntrlInd     : Byte;
        mTimeDir      : Integer;
        dt_TLD        : TDateTime;
        nOldYear      : Word;
        bl_SaveCrEv   : boolean;
        nReq          : CQueryPrimitive;
        //m_nState    : Byte;
        m_bySeed      : array[0..15] of Byte;
        m_byMD5       : array[0..15] of Byte;
        STIME         : Word;
        byMaxTar      : Byte;
        LastDate      : TDateTime;
        m_nState      : Byte;
        StateOn       : Boolean;
        vTar          : Boolean;//��� ���������� ������ � ���������� ��������
    public
        // base
        constructor Create;
        destructor  Destroy; override;
        procedure   InitMeter(var pL2:SL2TAG); override;
        procedure   RunMeter; override;

        // events routing
        function    SelfHandler(var pMsg:CMessage) : Boolean; override;
        function    LoHandler(var pMsg0:CMessage) : Boolean; override;
        function    HiHandler(var pMsg:CMessage) : Boolean; override;
        function    SetCommand(swParamID:Word;swSpecc0,swSpecc1,swSpecc2:Smallint;byEnable:Byte):Boolean; override;

        procedure   OnEnterAction();
        procedure   OnFinalAction();
        procedure   OnConnectComplette(var pMsg:CMessage); override;
        procedure   OnDisconnectComplette(var pMsg:CMessage); override;

        procedure   HandQryRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        //function    getChannelEx(pMsg:CMessage):word;
        function    IsTrueValue(var dbVal:Double):Boolean;
        function    CRC16(var cp: array of BYTE;len:Word):Word;
        function    IsValidMessage(var pMsg : CMessage) : Byte;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
        function    FillMessageBody(var _Msg : CHMessage; _FNC : WORD; _DataBytes : BYTE) : WORD;
        function    FillCommand(var _Msg:CHMessage;mCmd:CCommand):WORD;
        function    FillCmd(var byInfo:array of Byte;mCmd:CCommand):WORD;
        function    FillMsgF0(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsgF1(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsg30F0(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsg30F1(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsgDataBody_F0(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsgDataBody_F1(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsgDataBody_30F0(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        function    FillMsgDataBody_30F1(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
        procedure   GetHardDate(dtDate:TDateTime;var byInfo:array of Byte);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        function    ByteStuff(var _Buffer : array of BYTE; _Len : Word) : Word;
        function    ByteUnStuff(var _Buffer : array of BYTE;_Len : Word): Word;
        function    BCDToInt(_BCD : BYTE) : BYTE;
        function    IntToBCD(_Int : BYTE) : BYTE;
        function    GetDATA4(_Buff : array of BYTE) : DWORD;
        function    GetDATA3(_Buff : array of BYTE) : DWORD;

        procedure   REQ0001_OpenSession(var nReq: CQueryPrimitive);   // ����
        procedure   REQ0001_OpenProc(var nReq: CQueryPrimitive);   // ����
        function    RES0001_OpenSession(var pMsg:CMessage):boolean; // �����

        procedure   REQ0001_CloseSession(var nReq: CQueryPrimitive);   // ����
        procedure   REQ0001_CloseProc(var nReq: CQueryPrimitive);   // ����
        procedure   RES0001_CloseSession(var pMsg:CMessage);           // �����


        procedure   REQ0001_GetSeed(var nReq: CQueryPrimitive);
        procedure   REQ0001_Login(var nReq: CQueryPrimitive);
        procedure   RES0001_GetSeed(var pMsg:CMessage);
        procedure   CalculateMD5Hash(var Seed:array of Byte;szUserName:String;szPassword:String;var MD5Hash:array of Byte);
        procedure   RES0001_Login(var pMsg:CMessage);

        procedure   REQ0101_ReadConfig(var nReq: CQueryPrimitive);   // ������������
        procedure   RES0101_ReadConfig(var pMsg:CMessage);           // �����

        function    ReadDateTimeAns(var pMsg: CMessage):Boolean;        // ����� ��� ������ ������� ������ ��� ��� �������
        function    RES0120_ReadDateTime(var pMsg : CMessage):Boolean;  // �n���
        function    RES0120_CorTimeRes(var pMsg : CMessage):Boolean;    // ����� ������������ ������� �� ���������
        function    CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean;// ������ ��� ������ ������ ��� ��� �������
        procedure   REQ0120_ReadDateTime(var nReq: CQueryPrimitive);    // ������ ������ ����/�������
        procedure   REQ0120_CorrTimeReq(var nReq: CQueryPrimitive);     // ������ ������������� ����/�������


       // procedure   KorrTime(LastDate : TDateTime);
        procedure   RES0121_WriteDateTime(var pMsg : CMessage);

        procedure   REQ0130_ReadTariffValue(var nReq: CQueryPrimitive);
        procedure   RES0130_ReadTariffValue(var pMsg : CMessage);

        procedure   REQ0132_GetCurrentPower(var nReq: CQueryPrimitive);
        procedure   RES0132_GetCurrentPower(var pMsg:CMessage);

        procedure   REQ0133_GetEnergyDay(var nReq: CQueryPrimitive);
        function    RES0133_GetEnergyDay(var pMsg : CMessage):boolean;

        procedure   REQ0135_GetEnergyMonth(var nReq: CQueryPrimitive);
        function    RES0135_GetEnergyMonth(var pMsg : CMessage):boolean;

        procedure   REQ0134_GetSresEnergy(var nReq: CQueryPrimitive);
        procedure   RES0134_GetSresEnergy(var pMsg : CMessage);

        procedure   REQ0138_GetEvents(var nReq: CQueryPrimitive);
        procedure   RES0138_GetEvents(var pMsg:CMessage);

        function    getDbData(var byValue:array of byte):Double;
        function    getChann(_ParamID:WORD;var strP0:String;var nProfile:Integer;var nChannel:Word):boolean;
        procedure   ADD_Energy_Sum_GraphQry();
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        procedure   ADD_AUTORIS_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyMonth_Qry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyDay_Qry(_DTS, _DTE : TDateTime);
        procedure   ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);

        function    ReadByError(var pMsg:CMessage) :boolean;

        function    ReadConveer(var pMsg: CMessage) :Boolean;

    End;
Var
    m_IsAuthorized  : Boolean;
    m_IsOpenSession : Boolean;
    m_nAutoTMR_0    : CTimer;
    dtUspdDate      : TDateTime;

implementation
const
    Crc16Table: array[0..255] of WORD = (
    $0000, $1021, $2042, $3063, $4084, $50A5, $60C6, $70E7,
    $8108, $9129, $A14A, $B16B, $C18C, $D1AD, $E1CE, $F1EF,
    $1231, $0210, $3273, $2252, $52B5, $4294, $72F7, $62D6,
    $9339, $8318, $B37B, $A35A, $D3BD, $C39C, $F3FF, $E3DE,
    $2462, $3443, $0420, $1401, $64E6, $74C7, $44A4, $5485,
    $A56A, $B54B, $8528, $9509, $E5EE, $F5CF, $C5AC, $D58D,
    $3653, $2672, $1611, $0630, $76D7, $66F6, $5695, $46B4,
    $B75B, $A77A, $9719, $8738, $F7DF, $E7FE, $D79D, $C7BC,
    $48C4, $58E5, $6886, $78A7, $0840, $1861, $2802, $3823,
    $C9CC, $D9ED, $E98E, $F9AF, $8948, $9969, $A90A, $B92B,
    $5AF5, $4AD4, $7AB7, $6A96, $1A71, $0A50, $3A33, $2A12,
    $DBFD, $CBDC, $FBBF, $EB9E, $9B79, $8B58, $BB3B, $AB1A,
    $6CA6, $7C87, $4CE4, $5CC5, $2C22, $3C03, $0C60, $1C41,
    $EDAE, $FD8F, $CDEC, $DDCD, $AD2A, $BD0B, $8D68, $9D49,
    $7E97, $6EB6, $5ED5, $4EF4, $3E13, $2E32, $1E51, $0E70,
    $FF9F, $EFBE, $DFDD, $CFFC, $BF1B, $AF3A, $9F59, $8F78,
    $9188, $81A9, $B1CA, $A1EB, $D10C, $C12D, $F14E, $E16F,
    $1080, $00A1, $30C2, $20E3, $5004, $4025, $7046, $6067,
    $83B9, $9398, $A3FB, $B3DA, $C33D, $D31C, $E37F, $F35E,
    $02B1, $1290, $22F3, $32D2, $4235, $5214, $6277, $7256,
    $B5EA, $A5CB, $95A8, $8589, $F56E, $E54F, $D52C, $C50D,
    $34E2, $24C3, $14A0, $0481, $7466, $6447, $5424, $4405,
    $A7DB, $B7FA, $8799, $97B8, $E75F, $F77E, $C71D, $D73C,
    $26D3, $36F2, $0691, $16B0, $6657, $7676, $4615, $5634,
    $D94C, $C96D, $F90E, $E92F, $99C8, $89E9, $B98A, $A9AB,
    $5844, $4865, $7806, $6827, $18C0, $08E1, $3882, $28A3,
    $CB7D, $DB5C, $EB3F, $FB1E, $8BF9, $9BD8, $ABBB, $BB9A,
    $4A75, $5A54, $6A37, $7A16, $0AF1, $1AD0, $2AB3, $3A92,
    $FD2E, $ED0F, $DD6C, $CD4D, $BDAA, $AD8B, $9DE8, $8DC9,
    $7C26, $6C07, $5C64, $4C45, $3CA2, $2C83, $1CE0, $0CC1,
    $EF1F, $FF3E, $CF5D, $DF7C, $AF9B, $BFBA, $8FD9, $9FF8,
    $6E17, $7E36, $4E55, $5E74, $2E93, $3EB2, $0ED1, $1EF0);

  ST_164_READ_TIME             = 0;
  ST_164_CORR_TIME             = 1;

  CE16401MBY_DotPosition : array[0..3] of integer = (1, 10, 100, 1000);

{*******************************************************************************
 *
 ******************************************************************************}
constructor CCE16401MMeter.Create;
Begin
  FillChar(m_nT, SizeOf(m_nT), 0);
End;

destructor CCE16401MMeter.Destroy;
Begin
    inherited;
End;
function  CCE16401MMeter.SetCommand(swParamID:Word;swSpecc0,swSpecc1,swSpecc2:Smallint;byEnable:Byte):Boolean;
Var
  i : Integer;
Begin
  case swParamID of
       QRY_SRES_ENR_EP :
       Begin
        for i:=0 to 3 do
        m_nObserver.AddCurrParam(swParamID,0,i,swSpecc2 ,byEnable);
       End;
  else
       m_nObserver.AddCurrParam(swParamID,swSpecc0,swSpecc1,swSpecc2,byEnable);
  End;
  Result := False;
End;
procedure CCE16401MMeter.RunMeter;
Begin
    //m_nAutoTMR.RunTimer;
    if m_nAutoTMR_0.m_wSens=m_nP.m_swMID then m_nAutoTMR_0.RunTimer;
end;

function CCE16401MMeter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
    if pMsg.m_sbyType=DL_AUTORIZED_TM_REQ then
    Begin
     if m_nAutoTMR_0.IsProceed=false then
     Begin
      REQ0001_CloseSession(nReq);
      m_nRepTimer.OffTimer;
      m_IsAuthorized := false;
      m_nState := 0;
      exit;
     End;
     //m_byRep := m_nP.m_sbyRepMsg;
    End;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CCE16401MMeter.InitMeter(var pL2:SL2TAG);
Var
  Year, Month, Day : Word;
  dtDate : TDateTime;
  byInfo : array[0..3] of Byte;
  dwTime : Dword;
  i:integer;
begin
  m_Address := StrToInt(pL2.m_sddPHAddres);
  m_Password := StrToInt(pL2.m_schPassword);
  mTimeDir      := 0; //�������� ������� �������  ST_164_READ_TIME
  vTar          :=False;
  m_DotPosition := 100;
  IsUpdate      := 0;
  m_nState      := 0;
  STIME         := 20;
  byMaxTar      := 5;
  m_nT.B5       := false;//��� �������� ����� ������� �����������
  m_IsAuthorized := false;
  m_IsOpenSession :=false;
  SetHandScenario;
  SetHandScenarioGraph;
  mCntrlInd  :=(StrToInt(m_nP.m_sddPHAddres)-1);
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
  dtDate := EncodeDate(2014,8,26);
  GetHardDate(dtDate,byInfo);
  move(byInfo,dwTime,4);
End;

(*
function CCE16401MMeter.getChannelEx(pMsg:CMessage):word;
Var
 nChannel : word;
 i : integer;
 str : string;
begin

      Result := 0;
      if(nReq.m_swParamID=QRY_NAK_EN_DAY_EP)then
      Begin
        //nChannel :=  pMsg.m_sbyInfo[7] + pMsg.m_sbyInfo[8]*$100;
         str := Format('%x', [pMsg.m_sbyInfo[7]]);
         nChannel:=StrToInt('$' + str);
      End;

      Result := nChannel;
End;
*)

function CCE16401MMeter.ReadConveer(var pMsg:CMessage) :Boolean;
type
  TMsgState = (msNone, msCtrl, msEsc, msBegin, msData);
var
  i :Integer;
  idxBegin, idxOut, vLen, vMsgLen :Integer;
  currByte, vHeadLen :Byte;
  vCRC, W :Word;
  vHeader, H :Int64;
  msgState :TMsgState;
  vBuff :array [0..1023] of byte;
  nChannel : Word;
  strF  : String;
  nProfile : Integer;
const
  iHeadLenF0 = 5;
  iHeadLenF1 = 4;
begin
  Result := False;
  i := 0; msgState := msNone; w := 0;
  idxBegin := 0; idxOut := 0;
  vHeader := 0; H := 0;
  fillChar(vBuff, SizeOf(vBuff), 0);

  getChann(m_Req.m_swParamID, strF, nProfile, nChannel);
  if strF = 'F0' then vHeadLen := iHeadLenF0
  else if strF = 'F1' then vHeadLen := iHeadLenF1
  else if strF = '' then vHeadLen := 0
  else Exit;


  vBuff[idxOut] := $10; Inc(idxOut);
  vBuff[idxOut] := $02; Inc(idxOut);
  vMsgLen := pMsg.m_swLen - 13;
  if vMsgLen > SizeOf(pMsg.m_sbyInfo) then Exit;

  while (idxOut < vMsgLen) and (i < vMsgLen) do begin
    currByte := pMsg.m_sbyInfo[i];
    case msgState of
      msNone: if currByte = $10 then msgState := msCtrl;
      msCtrl: if currByte = $02 then msgState := msBegin;
      msBegin, msData: begin
        if currByte = $10 then msgState := msEsc
        else begin
          if msgState = msBegin then idxBegin := idxOut;
          vBuff[idxOut] := currByte; Inc(idxOut);
          msgState := msData;
        end;
      end;
      msEsc: begin
        if currByte = $10 then begin
          vBuff[idxOut] := currByte; Inc(idxOut);
          msgState := msData;
        end
        else if currByte = $03 then begin
          vLen := SizeOf(W);
          move(vBuff[idxOut - vLen], W, vLen); W := Swap(W);
          fillChar(vBuff[idxOut - vLen], vLen, 0); Dec(idxOut, vLen);
          vLen := idxOut - idxBegin;
          vCRC := CRC16(vBuff[idxBegin], vLen);
          if W <> vCRC then begin
            Exit;
          end;

          if vHeadLen > 0 then begin
            if vHeader = 0 then
              move(vBuff[idxBegin], vHeader, vHeadLen)
            else begin
              move(vBuff[idxBegin], H, vHeadLen);
              if vHeader = H then begin
                move(vBuff[idxBegin + vHeadLen], vBuff[idxBegin], vLen);
                Dec(idxOut, vHeadLen);
                fillChar(vBuff[idxOut], vHeadLen, 0);
              end;
            end;
          end;

          msgState := msNone;
        end;
      end;
    end;
    Inc(i);
  end;

  vLen := idxOut - 2;
  if vLen = 0 then Exit;
  vCRC := CRC16(vBuff[2], vLen); vCRC := Swap(vCRC);
  vLen := sizeOf(vCRC);
  move(vCRC, vBuff[idxOut], vLen); Inc(idxOut, vLen);

  vBuff[idxOut] := $10; Inc(idxOut);
  vBuff[idxOut] := $03; Inc(idxOut);

  fillChar(pMsg.m_sbyInfo, sizeOf(pMsg.m_sbyInfo), 0);
  move(vBuff, pMsg.m_sbyInfo, idxOut);
  pMsg.m_swLen := idxOut + 13;

  Result := True;
end;

{*******************************************************************************
 * ���������� ������� ������� ������
 ******************************************************************************}
function CCE16401MMeter.LoHandler(var pMsg0:CMessage):Boolean;
Var
    //byErr : Byte;
    nLen : Word;
    pMsg :CMessage;
    strP0:String;
    nProfile:Integer;
    nChannel:Word;
begin
  //SetLength(test_massiv^, 1);
  Result := false;
  move(pMsg0,pMsg,sizeof(CMessage));
  try
    case pMsg.m_sbyType of
      QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
      QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
      PH_DATA_IND:
      Begin
  //      if (m_QFNC = $0135) or (m_QFNC = $0133) then begin
          ReadConveer(pMsg);
  //      end
  //      else begin
  //        nLen := ByteUnStuff(pMsg.m_sbyInfo[2],pMsg.m_swLen-4-11);
  //        pMsg.m_swLen := pMsg.m_swLen-nLen;
  //      end;
        m_nT.B4:=true;
        case m_QFNC of // FUNCTION
          $0001 : Result:=RES0001_OpenSession(pMsg);
          $0002 : begin RES0001_CloseSession(pMsg); Result:=true; end;
          $0101 : RES0101_ReadConfig(pMsg);
          $0120 : Result:=ReadDateTimeAns(pMsg);       //��������������-> ��������
          $0121 : RES0121_WriteDateTime(pMsg);
          $0130 : RES0130_ReadTariffValue(pMsg);
          $0132 : RES0132_GetCurrentPower(pMsg);
          $0135 : Result:=RES0135_GetEnergyMonth(pMsg);//��������������-> ��������
          $0133 : Result:=RES0133_GetEnergyDay(pMsg);  //��������������-> ��������
          $0134 : RES0134_GetSresEnergy(pMsg);
          $0138 : RES0138_GetEvents(pMsg);
        end;
      end;
    end;
  except
    Result:=False;
  end;
end;

{*******************************************************************************
 * ���������� ������� �������� ������
 ******************************************************************************}
function CCE16401MMeter.HiHandler(var pMsg:CMessage):Boolean;
begin
  Result := False;
  m_nRxMsg.m_sbyServerID := 0;
  try
    case pMsg.m_sbyType of
      QL_DATARD_REQ:
      Begin
        Move(pMsg.m_sbyInfo[0],nReq,sizeof(CQueryPrimitive));
        if (nReq.m_swParamID=QRY_NAK_EN_MONTH_EP)or(nReq.m_swParamID=QRY_NAK_EN_DAY_EP) or (nReq.m_swParamID=QRY_ENERGY_SUM_EP)or (nReq.m_swParamID=QRY_DATA_TIME)
        then
         m_nT.B5:=true
        else
         m_nT.B5:=false;

        case nReq.m_swParamID of
          QRY_AUTORIZATION   : REQ0001_OpenProc(nReq);
          QRY_EXIT_COM       : REQ0001_CloseProc(nReq);
          QRY_ENERGY_SUM_EP  : REQ0130_ReadTariffValue(nReq);
          QRY_NAK_EN_MONTH_EP: REQ0135_GetEnergyMonth(nReq);
          QRY_NAK_EN_DAY_EP  : REQ0133_GetEnergyDay(nReq);
          QRY_SRES_ENR_EP    : REQ0134_GetSresEnergy(nReq);
          QRY_DATA_TIME      : CreateDateTimeReq(nReq);//REQ0120_ReadDateTime(nReq);   //����������� ��� ������  ������� ��� �������������
          QRY_JRNL_T3        : REQ0138_GetEvents(nReq);
          QRY_MGAKT_POW_S    : REQ0132_GetCurrentPower(nReq);
          QRY_KPRTEL_KE      : REQ0101_ReadConfig(nReq);
        end;
      End;
      QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
      QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
      QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
    end;
  except
    Result:=False;
//    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CCE16401MMeter/HiHandler ERROR');
  end;
end;


{*******************************************************************************
 * ������� ����������� �����
 * ������������ ����������� ���'��� ��������
 * BYTE CE16401MBY_CRC(BYTE *buf, int len)
 * @param BYTE *buf ��������� �� ������ ������ ��� ��������
 * @param int len ���������� ��������� ��� �������� bcc
 * @return BYTE ����������� ����� BCC
 ******************************************************************************}
function CCE16401MMeter.CRC16(var cp: array of BYTE;len:Word):Word;
var
 i: integer;
 crc: Word;
begin
  crc := $FFFF;
  for i:=0 to len-1 do
  begin
    crc:=  (crc shl 8) xor Crc16Table[(crc shr 8) xor cp[i]];
  end;
   Result := crc;
end;

{*******************************************************************************
 *  �������� ����������� ���������
 *      @param var pMsg : CMessage ���������
 *      @return Boolean
 ******************************************************************************}
function CCE16401MMeter.IsValidMessage(var pMsg : CMessage) : Byte;
var
    l_DataLen : WORD;
    l_Crc,l_msCrc,l_msSwCrc : WORD;
    l_ErrStr : String;
begin
    Result := 0;
    // ����������� �����
    l_DataLen := pMsg.m_swLen-13;
    if (l_DataLen > sizeOf(pMsg.m_sbyInfo)) or (l_DataLen < 6) then begin
      Result := 2;
      exit;
    end;
    move(pMsg.m_sbyInfo[l_DataLen-2-2],l_msCrc,2);
    l_msCrc := Swap(l_msCrc);
    l_Crc := self.CRC16(pMsg.m_sbyInfo[2],pMsg.m_swLen-13-2-2-2);
    if (l_Crc <> l_msCrc) then
    begin
     Result := 2;
    end;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CCE16401MMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 13;//11
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_CE16401M;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CCE16401MMeter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := 11 + 9 + 3;
    pMsg.m_swObjID     := m_nP.m_swMID;
    pMsg.m_sbyFrom     := DIR_L2TOL3;
    pMsg.m_sbyFor      := DIR_L2TOL3;
    pMsg.m_sbyType     := PH_EVENTS_INT;
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_CE16401M;
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;
//10 02 FE FD 0B C3 D0 E6 A7 19 17 01 00 D6 49 10 03          ..??.????....?I.
//������ ������ � ������� �2: � �/� ��� �������
//1 UINT8 ��� ������� (������ ���� 1).
//2 UINT8 ����� ������� (0 � ������� 1, �, 6 � ������� 7).
//3 UINT16 ���� 0-9 � ����� ������ ��.�� (0 � ��1, �, 999 � ��1000). ���� 10-14 � ����� (0 � ����� �� ���� �������, 1 � ����� 1, �, 8 � ����� 8). ���� 14-15 � ���������������.
//4 DT32 ����� �������� ������.
//�������� �3 � �4 �������� ���������, �� ������� ���������� ������,
//������� ����� ��������� ��������� ����� �������� (���������� ������������ ������������ �������� ������).
function CCE16401MMeter.FillMessageBody(var _Msg:CHMessage;_FNC:WORD;_DataBytes:BYTE):WORD;
begin
  _Msg.m_sbyInfo[0] := $10; // ������� ������ ������ 2by
  _Msg.m_sbyInfo[1] := $02;
end;

function CCE16401MMeter.FillCommand(var _Msg:CHMessage;mCmd:CCommand):WORD;
Var
  len,lenb,crc : Word;
begin
  _Msg.m_sbyInfo[0] := $10;
  _Msg.m_sbyInfo[1] := $02;
  len := FillCmd(_Msg.m_sbyInfo[2],mCmd);
  lenb := ByteStuff(_Msg.m_sbyInfo[2],len)+4;
  _Msg.m_sbyInfo[lenb-2] := $10;
  _Msg.m_sbyInfo[lenb-1] := $03;
  Result := lenb;
end;
function CCE16401MMeter.FillCmd(var byInfo:array of Byte;mCmd:CCommand):WORD;
Var
  len,crc,i : Word;
begin
  len := 2+2+1+mCmd.byLen;
  byInfo[0] := StrToInt(GetParceString(2,m_nP.m_sAdvDiscL2Tag));
  byInfo[1] := StrToInt(GetParceString(3,m_nP.m_sAdvDiscL2Tag));
  byInfo[2] := mCmd.byCmd;
  if mCmd.byLen<>0 then
  for i:=0 to mCmd.byLen-1 do byInfo[3+i] := mCmd.byInfo[i];
  crc := self.crc16(byInfo,len-2);
  byInfo[len-2] := HiByte(crc);
  byInfo[len-1] := LoByte(crc);
  result := len;
End;
function CCE16401MMeter.FillMsgF0(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  len,lenb : Word;
begin
  _Msg.m_sbyInfo[0] := $10;
  _Msg.m_sbyInfo[1] := $02;
  len  := FillMsgDataBody_F0(_Msg.m_sbyInfo[2],dtDate,byProf,byTar,nChannel);
  lenb := ByteStuff(_Msg.m_sbyInfo[2],len)+4; // ���� ��������
  _Msg.m_sbyInfo[lenb-2] := $10;
  _Msg.m_sbyInfo[lenb-1] := $03;
  Result := lenb;
end;
function CCE16401MMeter.FillMsgF1(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  len,lenb : Word;
begin
   lenb:=0;
   len:=0;
  _Msg.m_sbyInfo[0] := $10;
  _Msg.m_sbyInfo[1] := $02;
  len  := FillMsgDataBody_F1(_Msg.m_sbyInfo[2],dtDate,byProf,byTar,nChannel);
  lenb := ByteStuff(_Msg.m_sbyInfo[2],len)+4; // ���� ��������
  _Msg.m_sbyInfo[lenb-2] := $10;
  _Msg.m_sbyInfo[lenb-1] := $03;
  Result := lenb;
end;
function CCE16401MMeter.FillMsg30F0(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  len,lenb : Word;
begin
  _Msg.m_sbyInfo[0] := $10;
  _Msg.m_sbyInfo[1] := $02;
  len  := FillMsgDataBody_30F0(_Msg.m_sbyInfo[2],dtDate,byProf,byTar,nChannel);
  lenb := ByteStuff(_Msg.m_sbyInfo[2],len)+4; // ���� ��������
  _Msg.m_sbyInfo[lenb-2] := $10;
  _Msg.m_sbyInfo[lenb-1] := $03;
  Result := lenb;
end;
function CCE16401MMeter.FillMsg30F1(var _Msg:CHMessage;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  len,lenb : Word;
begin
  _Msg.m_sbyInfo[0] := $10;
  _Msg.m_sbyInfo[1] := $02;
  len  := FillMsgDataBody_30F1(_Msg.m_sbyInfo[2],dtDate,byProf,byTar,nChannel);
  lenb := ByteStuff(_Msg.m_sbyInfo[2],len)+4; // ���� ��������
  _Msg.m_sbyInfo[lenb-2] := $10;
  _Msg.m_sbyInfo[lenb-1] := $03;
  Result := lenb;
end;


procedure CCE16401MMeter.GetHardDate(dtDate:TDateTime;var byInfo:array of Byte);
Var
    cTime2 : Comp;
    dwTime : Dword;
    dDate  : TDateTime;
Begin
    try
    cTime2 := TimeStampToMSecs(DateTimeToTimeStamp(dtDate))-TimeStampToMSecs(DateTimeToTimeStamp(EncodeDate(2001,1,1)+EncodeTime(3,0,0,0)));
    dwTime := trunc(cTime2/1000);
    move(dwTime,byInfo,4);
    except

    end;
End;
function CCE16401MMeter.FillMsgDataBody_F0(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  i,wAddr,wT,crc,len : Word;
  PA :PByteDynArray;
  paOffset :Integer;
const
  begOffset = 5;
  tarLen = 6;
begin
  PA := m_nT.P1;
  if PA <> nil then begin
    if not m_nT.B1 then begin
      paOffset := Length(PA^);
      SetLength(PA^, Length(PA^) + byTar * tarLen);
    end;
  end;

  len := begOffset + byTar * tarLen;
  byInfo[0] := StrToInt(GetParceString(2,m_nP.m_sAdvDiscL2Tag));
  byInfo[1] := StrToInt(GetParceString(3,m_nP.m_sAdvDiscL2Tag));
  byInfo[2] := $0b;
  byInfo[3] := $01;
  byInfo[4] := byProf;
  wAddr     := nChannel;

  for i:=0 to byTar-1 do
  Begin
   wAddr := nChannel;
   wAddr := wAddr + (i shl 10);
   move(wAddr, byInfo[begOffset + i * tarLen], SizeOf(wAddr));
   GetHardDate(dtDate, byInfo[begOffset + 2 + i * tarLen]);
  End;

  if PA <> nil then begin
    if m_nT.B1 then begin
      m_nT.B1 := False;
      move(PA^[0], byInfo[len], Length(PA^));
      Inc(len, Length(PA^));
      SetLength(PA^,0);
    end
    else begin
      move(byInfo[begOffset], PA^[paOffset], byTar*tarLen);
    end;
  end;

  crc := self.crc16(byInfo,len);
  byInfo[len]  := HiByte(crc);
  byInfo[len+1]:= LoByte(crc);
  Result := len+2;
end;
{
10 02 FE FD 0B C3 50 22 CE 19 37 7B 00 15 D5 10 03
�����
10 02 FD FE 8B C3 50 22 CE 19 37 7B 04 00 00 00 00 00 69 FC 10 03
}
function CCE16401MMeter.FillMsgDataBody_F1(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  i,wAddr,wT,crc,len : Word;
  PA :PByteDynArray;
  paOffset :Integer;
const
  begOffset = 4;
  tarLen = 7;
begin
  PA := m_nT.P1;
  if PA <> nil then begin
    if not m_nT.B1 then begin
      paOffset := Length(PA^);
      SetLength(PA^, Length(PA^) + byTar * tarLen);
    end;
  end;

  len := begOffset + byTar * tarLen;
  byInfo[0] := StrToInt(GetParceString(2,m_nP.m_sAdvDiscL2Tag));
  byInfo[1] := StrToInt(GetParceString(3,m_nP.m_sAdvDiscL2Tag));
  byInfo[2] := $0b;
  byInfo[3] := $01;

  for i := 0 to byTar - 1 do
  Begin
   byInfo[begOffset + i * tarLen] := byProf or (i shl 4);
   wAddr     := nChannel;
   move(wAddr, byInfo[begOffset + 1 + i * tarLen], SizeOf(wAddr));
   GetHardDate(dtDate, byInfo[begOffset + 3 + i * tarLen]);
  End;

  if PA <> nil then begin
    if m_nT.B1 then begin
      m_nT.B1 := False;
      move(PA^[0], byInfo[len], Length(PA^));
      Inc(len, Length(PA^));
      SetLength(PA^,0);
    end
    else begin
      move(byInfo[begOffset], PA^[paOffset], byTar*tarLen);
    end;
  end;
  crc := self.crc16(byInfo,len);
  byInfo[len]  := HiByte(crc);
  byInfo[len+1]:= LoByte(crc);
  Result    := len+2;
end;

function CCE16401MMeter.FillMsgDataBody_30F0(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  wAddr,wT,crc,len,nCnt : Word;
  dtD : TDateTime;
  i : Integer;
begin
  byTar := 1;
  nCnt  := 12;
  len := 5 + nCnt*6;
  byInfo[0] := StrToInt(GetParceString(2,m_nP.m_sAdvDiscL2Tag));
  byInfo[1] := StrToInt(GetParceString(3,m_nP.m_sAdvDiscL2Tag));
  byInfo[2] := $0b;
  byInfo[3] := $01;
  byInfo[4] := byProf;
  wAddr     := nChannel;

  dtD       := dtDate;
  for i:=0 to (12*nReq.m_swSpecc1)-1 do
   dtD := dtD + EncodeTime(0,30,0,0);

  for i:=0 to nCnt-1 do
  Begin
   wAddr := nChannel;
   wAddr := wAddr + (byTar shl 10);
   move(wAddr,byInfo[5+i*6],2);
   GetHardDate(dtD,byInfo[7+i*6]);
   dtD := dtD + EncodeTime(0,30,0,0);
  End;
  crc := self.crc16(byInfo,len);
  byInfo[len]  := HiByte(crc);
  byInfo[len+1]:= LoByte(crc);
  Result := len+2;
end;
function CCE16401MMeter.FillMsgDataBody_30F1(var byInfo:array of Byte;dtDate:TDateTime;byProf,byTar:Byte;nChannel:Word):WORD;
Var
  i,wAddr,wT,crc,len : Word;
begin
  len := 11;
  len := 11-7+byTar*7;
  byInfo[0] := StrToInt(GetParceString(2,m_nP.m_sAdvDiscL2Tag));
  byInfo[1] := StrToInt(GetParceString(3,m_nP.m_sAdvDiscL2Tag));
  byInfo[2] := $0b;
  byInfo[3] := $01;
  for i:=0 to byTar-1 do
  Begin
   byInfo[4+i*7] := byProf or (i shl 4);
   wAddr     := nChannel;
   move(wAddr,byInfo[5+i*7],2);
   GetHardDate(dtDate,byInfo[7+i*7]);
  End;
  crc := self.crc16(byInfo,len);
  byInfo[len]  := HiByte(crc);
  byInfo[len+1]:= LoByte(crc);
  Result    := len+2;
end;
{*******************************************************************************
 *  ������������ ��������� ���������� ������
 *      @param _Value : double �������� ���������
 *      @param _EType : byte ��� �������
 *      @param _Tariff : byte ������
 *      @param _WriteDate : Boolean ���������� ����� �������
 ******************************************************************************}
procedure CCE16401MMeter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
var
    l_Year, l_Month, l_Day,
    l_Hour, l_Min, l_Second, l_MS : word;
begin
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double); //11
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
            //cDateTimeR.IncMonth(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := 1;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
          end;

        QRY_NAK_EN_DAY_EP :
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


procedure CCE16401MMeter.HandQryRoutine(var pMsg:CMessage);
Var
    DTS, DTE : TDateTime;
    l_Param        : word;
    szDT         : word;
    pDS          : CMessageData;
begin
    IsUpdate := 1;
    //m_nObserver.ClearGraphQry;
    szDT := sizeof(TDateTime);
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));

    Move(pDS.m_sbyInfo[0],DTE,szDT);
    Move(pDS.m_sbyInfo[szDT],DTS,szDT);
    DTS_V:=DTS;
    DTE_V:=DTE;
    l_Param := pDS.m_swData1;

    case l_Param of
      QRY_AUTORIZATION :
        ADD_AUTORIS_GraphQry(DTS, DTE);

      QRY_SRES_ENR_EP :
        ADD_SresEnergyDay_GraphQry(DTS, DTE);

      QRY_NAK_EN_DAY_EP:
        ADD_NakEnergyDay_Qry(DTS, DTE);

      QRY_NAK_EN_MONTH_EP:
        ADD_NakEnergyMonth_Qry(DTS, DTE);

      QRY_ENERGY_SUM_EP:
          ADD_Energy_Sum_GraphQry();

        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;


procedure CCE16401MMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_nState := 0;
    //m_IsAuthorized := false;
    //m_nAutoTMR.OffTimer;
    //m_IsAuthorized := False;
    OnFinalAction();
    IsUpdate := 0;
  End;
end;

procedure CCE16401MMeter.OnEnterAction;
begin
  if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
    OpenPhone
  else if m_nP.m_sbyModem=0 then begin end;
end;

procedure CCE16401MMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then begin end;
End;

procedure CCE16401MMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    m_nModemState := 0;
End;

procedure CCE16401MMeter.OnFinalAction;
begin
    m_IsCurrCry := false;
end;

{*******************************************************************************
 *  ����� ����� �������� �������� ��������� ���������� �������������
 *  ��� ������������� ������������� ������ ����, �:
 *	0�10 ���������� �� 0�10 0�10,
 ******************************************************************************}
function CCE16401MMeter.ByteStuff(var _Buffer : array of BYTE; _Len : Word) : Word;
var
  i, l : integer;
  tArr : array[0..1023] of BYTE;
begin
  l := 0;
  tArr[0] := _Buffer[0];
  FillChar(tArr,_Len,0);
  for i := 0 to _Len-1 do
  begin
    if (_Buffer[i] = $10) then
    begin
      tArr[l] := $10;Inc(l);
      tArr[l] := $10;Inc(l);
     end else
     Begin
      tArr[l] := _Buffer[i];
      Inc(l);
     End;
  end;
  move(tArr, _Buffer, l+0);
  Result := l+0;
end;

{*******************************************************************************
 *  ����� ����� �������� �������� ��������� ���������� �������������
 *  ��� ������������� ������������� ������ ����, �:
 *	0�10 0�10 ���������� �� 0�10,
*******************************************************************************}
function CCE16401MMeter.ByteUnStuff(var _Buffer : array of BYTE;_Len : Word) : Word;
var
  i, l : integer;
  tArr : array[0..1023] of BYTE;
begin
  l := 0;
  i := 0;
  FillChar(tArr,_Len,0);
  while (i<=_Len-2) do
  begin
    if ((_Buffer[i] = $10) AND (_Buffer[i + 1] = $10)) then
    begin
      tArr[l] := $10;
      Inc(l);
      i:=i+2;
    end else
    Begin
      tArr[l] := _Buffer[i];
      Inc(l);
      Inc(i);
    End;
  end;
  tArr[l] := _Buffer[i];
  tArr[l+1] := $10;
  tArr[l+2] := $03;
  move(tArr, _Buffer, l+1);
  Result := _Len-(l+1);
end;

function CCE16401MMeter.BCDToInt(_BCD : BYTE) : BYTE;
begin
  Result := ((_BCD AND $F0) shr 4)*10 + (_BCD AND $0F);
end;

function CCE16401MMeter.IntToBCD(_Int : BYTE) : BYTE;
begin
  Result := (_Int mod 10) or ((_Int div 10) shl 4);
end;

function CCE16401MMeter.GetDATA4(_Buff : array of BYTE) : DWORD;
var
  l_pDW : array[0..3] of BYTE absolute Result;
begin
  Result := 0;

  l_pDW[0] := _Buff[0];
  l_pDW[1] := _Buff[1];
  l_pDW[2] := _Buff[2];
  l_pDW[3] := _Buff[3];
end;

function CCE16401MMeter.GetDATA3(_Buff : array of BYTE) : DWORD;
var
  l_pDW : array[0..3] of BYTE absolute Result;
begin
  Result := 0;

  l_pDW[0] := _Buff[0];
  l_pDW[1] := _Buff[1];
  l_pDW[2] := _Buff[2];
  l_pDW[3] := 0;
end;

(*******************************************************************************
 * ������� "Ping"
 ******************************************************************************)

procedure CCE16401MMeter.REQ0001_OpenProc(var nReq: CQueryPrimitive);
Begin
  if (nReq.m_swParamID=QRY_AUTORIZATION) and (nReq.m_swSpecc0=1) then  REQ0001_OpenSession(nReq)
  else
  Begin
   REQ0001_OpenSession(nReq);
  End;
End;

procedure CCE16401MMeter.REQ0001_CloseProc(var nReq: CQueryPrimitive);
Begin
   REQ0001_CloseSession(nReq);
end;
procedure CCE16401MMeter.REQ0001_OpenSession(var nReq: CQueryPrimitive);
begin
  m_Req := nReq;
  case (m_nState) of
       0: REQ0001_GetSeed(nReq);
       1: REQ0001_Login(nReq);
       //2: Begin REQ0120_ReadDateTime(nReq); m_IsAuthorized := True;End;
  End;
end;
(*******************************************************************************
 * ������� "Ping"
 *   2 ����� - ����� ����������.
 ******************************************************************************)
function CCE16401MMeter.RES0001_OpenSession(var pMsg:CMessage):boolean;
var res:boolean;
begin
 res:=ReadByError(pMsg);
 if res then
  begin
   case m_nState of
        0 : RES0001_GetSeed(pMsg);
        1 : RES0001_Login(pMsg);
        //2 : Begin RES0120_ReadDateTime(pMsg);m_IsAuthorized := True;End;
   End;
  end;
 Result:=res;
end;
procedure CCE16401MMeter.REQ0001_GetSeed(var nReq: CQueryPrimitive);
Var
  mCmd : CCommand;
begin
  m_QTimestamp := Now();
  m_QFNC := $0001; // ������� ������ � ��������
  m_Req := nReq;

  mCmd.byLen     := 1;
  mCmd.byCmd     := $01;//GET_SEED
  mCmd.byInfo[0] := 2;

  FillMessageHead(m_nTxMsg, FillCommand(m_nTxMsg,mCmd));
  SendToL1(BOX_L1 ,@m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;
procedure CCE16401MMeter.REQ0001_CloseSession(var nReq: CQueryPrimitive);
Var
  mCmd : CCommand;
begin
  m_QTimestamp := Now();
  m_QFNC := $0002; // ������� ������ � ��������
  m_Req := nReq;
  mCmd.byLen     := 0;
  mCmd.byCmd     := $03;//CMD_LOGOUT
  FillMessageHead(m_nTxMsg, FillCommand(m_nTxMsg,mCmd));
  SendToL1(BOX_L1 ,@m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;
procedure CCE16401MMeter.RES0001_CloseSession(var pMsg:CMessage);
Begin
  m_nState := 0;
//  FinalAction();
End;
procedure CCE16401MMeter.REQ0001_Login(var nReq: CQueryPrimitive);
Var
  mCmd : CCommand;
begin
  m_QTimestamp := Now();
  m_QFNC := $0001; // ������� ������ � ��������
  m_Req := nReq;

  mCmd.byLen     := 17;
  mCmd.byCmd     := $02;//CMD_LOGIN
  mCmd.byInfo[0] := 5*4;
  move(m_byMD5,mCmd.byInfo[1],16);

  FillMessageHead(m_nTxMsg, FillCommand(m_nTxMsg,mCmd));
  SendToL1(BOX_L1 ,@m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;



procedure CCE16401MMeter.RES0001_GetSeed(var pMsg:CMessage);
Begin
  // m_IsOpenSession:=true;
   m_nState := 1;
   move(pMsg.m_sbyInfo[5],m_bySeed,16);
   CalculateMD5Hash(m_bySeed,GetParceString(0,m_nP.m_sAdvDiscL2Tag),GetParceString(1,m_nP.m_sAdvDiscL2Tag),m_byMD5);
End;

procedure CCE16401MMeter.CalculateMD5Hash(var Seed:array of Byte;szUserName:String;szPassword:String;var MD5Hash:array of Byte);
Var
   mdPassw : TMD5Digest;
   mdOut : TMD5Digest;
   ctx : TMD5Context;
Begin
   mdPassw := MD5String(szPassword);
   //�������� ������������ MD5-��� ������
   MD5Init(ctx);
   MD5Update(ctx, PByteArray(PChar(szPassword)), length(szPassword));
   MD5Final(mdPassw, ctx);
   //������������ MD5-��� ��� ������� CMD_LOGIN � ��������� �������:
   MD5Init(ctx);
   //1. seed
   MD5Update(ctx, @Seed, 16);
   //2. ��� ������������
   MD5Update(ctx, PByteArray(PChar(szUserName)), length(szUserName));
   //3. MD5-��� ������
   MD5Update(ctx, @mdPassw.v, 16);
   MD5Final(mdOut, ctx);
   move(mdOut.v,MD5Hash,16);
End;

procedure CCE16401MMeter.RES0001_Login(var pMsg:CMessage);
Begin
  m_nState := 2;
End;

(*******************************************************************************
 * ������� "ReadConfig"
 ******************************************************************************)
procedure CCE16401MMeter.REQ0101_ReadConfig(var nReq: CQueryPrimitive);
begin
  m_QTimestamp := Now();
  m_QFNC := $0101;
  m_Req := nReq;
end;


(*******************************************************************************
 * ������� "Ping"
 *   2 ����� - ����� ����������.
 ******************************************************************************)
procedure CCE16401MMeter.RES0101_ReadConfig(var pMsg:CMessage);
begin
  m_DotPosition := CE16401MBY_DotPosition[pMsg.m_sbyInfo[9] AND $03];
end;

function CCE16401MMeter.CreateDateTimeReq(var nReq: CQueryPrimitive):Boolean;
begin
   case mTimeDir of
     ST_164_READ_TIME : REQ0120_ReadDateTime(nReq);
     ST_164_CORR_TIME : REQ0120_CorrTimeReq(nReq);
   end;
end;

function CCE16401MMeter.ReadDateTimeAns(var pMsg: CMessage): Boolean;
begin
   Result := true;
   case mTimeDir of
     ST_164_READ_TIME : Result:=RES0120_ReadDateTime(pMsg);
     ST_164_CORR_TIME :
       begin
         Result:=RES0120_CorTimeRes(pMsg);
         mTimeDir := ST_164_READ_TIME;
       end;
   else  mTimeDir := ST_164_READ_TIME;
   end;
end;


(*******************************************************************************
 * ������ �� ������ ������� � ����
 ******************************************************************************)
procedure CCE16401MMeter.REQ0120_ReadDateTime(var nReq: CQueryPrimitive);
Var
  mCmd : CCommand;
begin
  m_QTimestamp := Now();
  m_QFNC := $0120;
  m_Req := nReq;
  mCmd.byLen     := 0;
  mCmd.byCmd     := $04;//CMD_R_TIME
  //mCmd.byInfo[0] := 5*4;
  //move(m_byMD5,mCmd.byInfo[1],16);
  FillMessageHead(m_nTxMsg, FillCommand(m_nTxMsg,mCmd));
  SendToL1(BOX_L1 ,@m_nTxMsg);
end;


(*******************************************************************************
 * ����� "������ ������� � ����"
 *******************************************************************************)
function CCE16401MMeter.RES0120_ReadDateTime(var pMsg:CMessage):Boolean;
var
  nReq : CQueryPrimitive;
  _yy,_mn,_dd,_hh,_mm,_ss : word;
  Hour,Min,Sek,Msek : word;
  dayWeek  : Byte;
  ReadDate : TDateTime;
begin
    _yy := (pMsg.m_sbyInfo[12]);
    _mn := (pMsg.m_sbyInfo[13]);
    _dd := (pMsg.m_sbyInfo[14]);
    dayWeek:= DayOfWeek(pMsg.m_sbyInfo[15]);
    _hh := (pMsg.m_sbyInfo[16]);
    _mm := (pMsg.m_sbyInfo[17]);
    _ss := (pMsg.m_sbyInfo[18]);
    ReadDate:=EncodeDate(_yy,_mn,_dd) + EncodeTime(_hh,_mm,_ss,0);
    DecodeTime(Now,Hour,Min,Sek,Msek);
//    if abs(ReadDate - Now) > EncodeTime(0, 0, 15, 0) then
//    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'������� �� ������� ���������� -> '+TimeToStr(abs(EncodeTime(_hh,_mm,_ss,0)-EncodeTime(Hour,Min,Sek,0))));
    //if (abs(ReadDate - Now)>15)then
    if (abs(EncodeTime(_hh,_mm,_ss,0)-EncodeTime(Hour,Min,Sek,0))>EncodeTime(0,0,15,0)) then
      begin
       mTimeDir := ST_164_CORR_TIME;
       m_nObserver.AddGraphParam(QRY_DATA_TIME, 0,0,0,1);  //������� � ����� ��������� ��� ����������� ���� �������(�� ������ ��� �� ��������)
       Result := true;
     end
    else
     begin
       mTimeDir := ST_164_READ_TIME; //����� ������
       m_nObserver.ClearGraphQry;//������� ����� ������
       Result := true;
     end;
end;

(*******************************************************************************
 * ������ "������������� ������� � ����"
 *******************************************************************************)
procedure CCE16401MMeter.REQ0120_CorrTimeReq(var nReq: CQueryPrimitive);
var Year, Month, Day,
    Hour, Min, Sec, Msec : word;
    mCmd : CCommand;
    LenPac:byte; //����� ������
begin
    //m_nTxMsg.m_sbyInfo[0]  := StrToInt(m_nP.m_sddPHAddres);
    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, Msec);   
    Hour:=Hour-3; //-3 ��� �������� � GMT � ��� +3, ����� -3

    m_QTimestamp := Now();
    m_QFNC       := $0120;
    m_Req        := nReq;
    mCmd.byLen   := 6;   //����� ������ ������ ��� �������
    mCmd.byCmd   := $05;  //������� ��������� �������
   // DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
   // DecodeDate(m_QTimestamp, Year, Month, Day);


    mCmd.byInfo[0] := Year - 2000;
    mCmd.byInfo[1] := Month;//IntToBCD(
    mCmd.byInfo[2] := Day;
    mCmd.byInfo[3] := Hour;
    mCmd.byInfo[4] := Min;
    mCmd.byInfo[5]:= Sec;
    mCmd.byInfo[6]:= 0;
    mCmd.byInfo[7]:= 0;
    LenPac:=FillCommand(m_nTxMsg,mCmd);

   // FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 7));
    FillMessageHead(m_nTxMsg,LenPac);
    SendToL1(BOX_L1, @m_nTxMsg);
end;


(*******************************************************************************
 * ����� "������ ������� � ����"
 *******************************************************************************)
function CCE16401MMeter.RES0120_CorTimeRes(var pMsg:CMessage):Boolean;
var
  _yy,_mn,_dd,_hh,_mm,_ss : word;
  ReadDate : TDateTime;
begin
    _yy := (pMsg.m_sbyInfo[5]);
    _mn := (pMsg.m_sbyInfo[6]);
    _dd := (pMsg.m_sbyInfo[7]);
    _hh := (pMsg.m_sbyInfo[8])+3;
    _mm := (pMsg.m_sbyInfo[9]);
    _ss := (pMsg.m_sbyInfo[10]);
    ReadDate:=EncodeDate(_yy,_mn,_dd) + EncodeTime(_hh,_mm,_ss,0);
//    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'������� �� ������� ����� ������������� ���������� -> '+DateTimeToStr(ReadDate - Now));
    Result:=True;
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
procedure CCE16401MMeter.RES0121_WriteDateTime(var pMsg:CMessage);
begin
    m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
    m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
    if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
    m_QFNC:=0;
end;

(******************************************************************************
 * ����������� �� ����� ������
 ******************************************************************************)
procedure CCE16401MMeter.REQ0130_ReadTariffValue(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
begin
  m_QTimestamp := Now();
  m_QFNC       := $0130;
  m_Req        := nReq;

  if (nReq.m_swSpecc0 >0) then
  begin
    cDateTimeR.DecMonthEx(nReq.m_swSpecc0, m_QTimestamp);
    DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
    m_QTimestamp := EncodeDate(l_Y, l_M, 1);
  end;
    //getChann(nReq.m_swParamID,strF,nProfile,nChannel);
 // if (strF='F0') then FillMessageHead(m_nTxMsg,FillMsgF0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel)) else
 // if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsgF1(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel))else
  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc0; // 0 - ��������� �����������, 1 - �� ����� ����������� ������(������ ��������)

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  SendToL1(BOX_L1, @m_nTxMsg);
end;


procedure CCE16401MMeter.RES0130_ReadTariffValue(var pMsg:CMessage);
var
  l_V : double;
  l_s : String;
begin
  l_V := GetDATA4(pMsg.m_sbyInfo[9]) / m_DotPosition * m_nP.m_sfKI * m_nP.m_sfKU;
  if m_Req.m_swSpecc1=0 then
  Begin
   FillSaveDataMessage(0, m_Req.m_swParamID, 0, true);
   saveToDB(m_nRxMsg);
   cDateTimeR.DecMonth(m_QTimestamp);
  end;
  FillSaveDataMessage(l_V, m_Req.m_swParamID, m_Req.m_swSpecc1+1, true);
  saveToDB(m_nRxMsg);
end;


(*******************************************************************************
 * ReadPower
	  ������  ��������, ����������� �� �������� ���������
 ******************************************************************************)
procedure CCE16401MMeter.REQ0132_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0132;
  m_QTimestamp := Now();
  m_Req := nReq;

  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  SendToL1(BOX_L1, @m_nTxMsg);
end;


(*******************************************************************************
 * �����
 *******************************************************************************)
procedure CCE16401MMeter.RES0132_GetCurrentPower(var pMsg:CMessage);
var
    l_V    : Double;
begin
  l_V := GetDATA3(pMsg.m_sbyInfo[9]) / m_DotPosition * m_nP.m_sfKI * m_nP.m_sfKU;
  FillSaveDataMessage(l_V, m_Req.m_swParamID, 0, true);
  saveToDB(m_nRxMsg);
end;

(*******************************************************************************
 * ReadEnergyOfDays
 *******************************************************************************)
procedure CCE16401MMeter.REQ0133_GetEnergyDay(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
  t : DWORD;
  dtDT : TDateTime;
  strF,strP : String;
  nProfile : Integer;
  nChannel : Word;
begin
  //m_QTimestamp := Now();
  m_QFNC       := $0133;
  m_Req        := nReq;
  dtDT := trunc(now-nReq.m_swSpecc0);
  m_QTimestamp := dtDT;
  getChann(nReq.m_swParamID,strF,nProfile,nChannel);
  if (strF='F0') then FillMessageHead(m_nTxMsg,FillMsgF0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel)) else
  if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsgF1(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel))else
  if (strF='F2') then FillMessageHead(m_nTxMsg,FillMsgF0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel));
  //if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsgF1(m_nTxMsg,dtDT,nProfile,nReq.m_swSpecc1));
  SendToL1(BOX_L1 ,@m_nTxMsg);
end;

(*******************************************************************************
 *	�����
 ******************************************************************************)
function CCE16401MMeter.RES0133_GetEnergyDay(var pMsg : CMessage):boolean;
var
  l_V   : Double;
  nData40 : CDBData40;
  nData22 : CDBData22;
  nTar  : Integer;
  nCount, nCntReal :Integer;
  i,nChannel : Word;
  strF  : String;
  nProfile : Integer;
  byInd   : Byte;
  ddValue : int64;
  byStat  : Byte;
  res     : Boolean;
const
  begOffsetF0 = 7;
  begOffsetF1 = 6;
  nTarifsMask = $1F;
begin
  Result:=false;
  getChann(m_Req.m_swParamID,strF,nProfile,nChannel);
  if strF='F0' then Begin
    res:=ReadByError(pMsg);

    if res then begin
      res := False;
      nCount := (SizeOf(pMsg.m_sbyInfo) - begOffsetF0) div SizeOf(CDBData40);

      for i := 0 to nCount - 1 do Begin
        FillChar(nData40, SizeOf(CDBData40), 0);

        move(pMsg.m_sbyInfo[begOffsetF0 + i * sizeof(CDBData40)], nData40, sizeof(CDBData40));

        if nData40.dtDate = 0 then Break;

        byInd := nData40.wCHTar and $3FF;

        if mCntrlind <> byInd then Continue;

        nTar := nData40.wCHTar shr 10;

        res := True;
        nCntReal := nCntReal or ($01 shl nTar);
      End;
      m_nT.B2 := (nCntReal and nTarifsMask) = nTarifsMask;


      if m_nT.B2 then
        for i := 0 to nCount - 1 do Begin
          FillChar(nData40, SizeOf(CDBData40), 0);

          move(pMsg.m_sbyInfo[begOffsetF0 + i * sizeof(CDBData40)], nData40, sizeof(CDBData40));

          if nData40.dtDate = 0 then Break;

          byInd := nData40.wCHTar and $3FF;

          if mCntrlind <> byInd then Continue;


          nTar := nData40.wCHTar shr 10;
          l_V := getDbData(nData40.dbVal);

          FillSaveDataMessage(l_V, m_Req.m_swParamID, nTar, true);
          saveToDB(m_nRxMsg);
        End;
    end;
  End
  else if strF='F1' then Begin
    res:=ReadByError(pMsg);

    if res then begin
      res := False;
      nCount := (SizeOf(pMsg.m_sbyInfo) - begOffsetF1) div SizeOf(CDBData22);

      for i := 0 to nCount - 1 do Begin
        FillChar(nData22, SizeOf(CDBData22), 0);

        move(pMsg.m_sbyInfo[begOffsetF1 + i * sizeof(CDBData22)], nData22, sizeof(CDBData22));

        if nData22.dtDate = 0 then Break;

        byInd := Hi(nData22.wCHTar);

        if mCntrlind <> byInd then Continue;

        nTar := Lo(nData22.wCHTar) shr 4;

        res := True;
        nCntReal := nCntReal or ($01 shl nTar);
      End;
      m_nT.B2 := (nCntReal and nTarifsMask) = nTarifsMask;

      if m_nT.B2 then
        for i := 0 to nCount - 1 do Begin
          FillChar(nData22, SizeOf(CDBData22), 0);

          move(pMsg.m_sbyInfo[begOffsetF1 + i * sizeof(CDBData22)], nData22, sizeof(CDBData22));

          if nData22.dtDate = 0 then Break;

          byInd := Hi(nData22.wCHTar);

          if mCntrlind <> byInd then Continue;

          m_nT.B2 := (nData22.byStatus and $98) = $00;
          if not m_nT.B2 then Break;

          nTar := Lo(nData22.wCHTar) shr 4;
          l_V := getDbData(nData22.dbVal);

          FillSaveDataMessage(l_V, m_Req.m_swParamID, nTar, true);
          saveToDB(m_nRxMsg);
        End;
    end;
  End
  else if (strF='F2') then
  Begin
   for i:=0 to byMaxTar-1 do
   Begin
    move(pMsg.m_sbyInfo[14+i*(sizeof(CDBData40)+3)],l_V,sizeof(CDBData40)-4);
    nTar := nData40.wCHTar shr 10;
  //  l_V := getDbData(nData.dbVal);
    FillSaveDataMessage(l_V, m_Req.m_swParamID, i, true);    saveToDB(m_nRxMsg); //FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
  End;
  Result:=res;
end;

(*******************************************************************************
 * ReadEnergyOfMonth
 *******************************************************************************)
procedure CCE16401MMeter.REQ0135_GetEnergyMonth(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
  t : DWORD;
  dtDT : TDateTime;
  strF,strP : String;
  nProfile : Integer;
  nChannel : Word;
begin
  //m_QTimestamp := Now();
  m_QFNC       := $0135;
  m_Req        := nReq;
  dtDT         := now;
  cDateTimeR.DecMonthEx(m_Req.m_swSpecc0,dtDT);
  DecodeDate(dtDT, l_Y, l_M, l_D);
  dtDT := EncodeDate(l_Y, l_M, 1);
  m_QTimestamp := dtDT;
  getChann(nReq.m_swParamID,strF,nProfile,nChannel);
  if (strF='F0') then FillMessageHead(m_nTxMsg,FillMsgF0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel)) else
  if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsgF1(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel))else
  if (strF='F2') then FillMessageHead(m_nTxMsg,FillMsgF0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel));
  //if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsgF1(m_nTxMsg,dtDT,nProfile,nReq.m_swSpecc1));
  //FPUT(BOX_L1, @m_nTxMsg);
  SendToL1(BOX_L1 ,@m_nTxMsg);
end;

(*******************************************************************************
 *	�����
 ******************************************************************************)
function CCE16401MMeter.RES0135_GetEnergyMonth(var pMsg : CMessage):boolean;
var
  l_V   : Double;
  nData40 : CDBData40;
  nData22 : CDBData22;
  nTar  : Integer;
  nCount, nCntReal :Integer;
  i,nChannel : Word;
  strF  : String;
  nProfile : Integer;
  ddValue : int64;
  byStat  : Byte;
  byInd   : Byte;
  res     : Boolean;
const
  begOffsetF0 = 7;
  begOffsetF1 = 6;
  nTarifsMask = $1F;
begin
  Result:=false;
  getChann(m_Req.m_swParamID,strF,nProfile,nChannel);

  if strF='F0' then Begin
    res:=ReadByError(pMsg);

    if res then begin
      res := False;
      nCount := (SizeOf(pMsg.m_sbyInfo) - begOffsetF0) div SizeOf(CDBData40);
      nCntReal := 0;

      for i := 0 to nCount - 1 do Begin
        FillChar(nData40, SizeOf(CDBData40), 0);

        move(pMsg.m_sbyInfo[begOffsetF0 + i * sizeof(CDBData40)], nData40, sizeof(CDBData40));

        if nData40.dtDate = 0 then Break;

        byInd := nData40.wCHTar and $3FF;

        if mCntrlind <> byInd then Continue;


        nTar := nData40.wCHTar shr 10;

        res := True;
        nCntReal := nCntReal or ($01 shl nTar);
      End;
      m_nT.B2 := (nCntReal and nTarifsMask) = nTarifsMask;

      if m_nT.B2 then
        for i := 0 to nCount - 1 do Begin
          FillChar(nData40, SizeOf(CDBData40), 0);

          move(pMsg.m_sbyInfo[begOffsetF0 + i * sizeof(CDBData40)], nData40, sizeof(CDBData40));

          if nData40.dtDate = 0 then Break;

          byInd := nData40.wCHTar and $3FF;

          if mCntrlind <> byInd then Continue;


          nTar := nData40.wCHTar shr 10;
          l_V := getDbData(nData40.dbVal);

//          TraceL(3, m_nTxMsg.m_swObjID,'(__)CCE16401M::>Data Month:Tar:'+IntTostr(nTar)+
//                                                      ' Sta:'+IntToHex(nData40.byStatus,2)+
//                                                      ' Val:'+FloatToStr(l_V));
          FillSaveDataMessage(l_V, m_Req.m_swParamID, nTar, true);
          saveToDB(m_nRxMsg);// FPUT(BOX_L3_BY, @m_nRxMsg);
        End;

    end;
  End
  else if strF='F1' then Begin
    res:=ReadByError(pMsg);

    if res then begin
      res := False;
      nCount := (SizeOf(pMsg.m_sbyInfo) - begOffsetF1) div SizeOf(CDBData22);
      nCntReal := 0;

      for i := 0 to nCount - 1 do Begin
        FillChar(nData22, SizeOf(CDBData22), 0);

        move(pMsg.m_sbyInfo[begOffsetF1 + i * sizeof(CDBData22)], nData22, sizeof(CDBData22));

        if nData22.dtDate = 0 then Break;

        byInd := Hi(nData22.wCHTar);

        if mCntrlind <> byInd then Continue;

        nTar := Lo(nData22.wCHTar) shr 4;

        res := True;
        nCntReal := nCntReal or ($01 shl nTar);
      End;
      m_nT.B2 := (nCntReal and nTarifsMask) = nTarifsMask;

      if m_nT.B2 then
        for i := 0 to nCount - 1 do Begin
          FillChar(nData22, SizeOf(CDBData22), 0);

          move(pMsg.m_sbyInfo[begOffsetF1 + i * sizeof(CDBData22)], nData22, sizeof(CDBData22));

          if nData22.dtDate = 0 then Break;

          byInd := Hi(nData22.wCHTar);

          if mCntrlind <> byInd then Continue;

          m_nT.B2 := (nData22.byStatus and $8C) = $00; //98
          if not m_nT.B2 then
          begin
          if vTar=True then
               m_nT.B2:=True;//��� ����� ������ ��������� ������, ����� ����� false ���� ��� ����� ������� �� � ������ ��������
          Break;
          end;

          nTar := Lo(nData22.wCHTar) shr 4;
           if (nTar=1)or(nTar=0) then
              vTar:=True;
          l_V := getDbData(nData22.dbVal);

//          TraceL(3, m_nTxMsg.m_swObjID,'(__)CCE16401K::>Data Month:Tar:'+IntTostr(nTar)+
//                                                      ' Sta:'+IntToHex(nData22.byStatus,2)+
//                                                      ' Val:'+FloatToStr(l_V));
          FillSaveDataMessage(l_V, m_Req.m_swParamID, nTar, true);
          saveToDB(m_nRxMsg);// FPUT(BOX_L3_BY, @m_nRxMsg);
        End;

    end;
  End
  else if (strF='F2') then
  Begin
   for i:=0 to byMaxTar-1 do
   Begin
    //move(pMsg.m_sbyInfo[7+i*sizeof(CDBData40)],nData,sizeof(CDBData40));
    move(pMsg.m_sbyInfo[14+i*(sizeof(CDBData40)+3)],l_V,(sizeof(CDBData40)-4));{sizeof(CDBData40)}
    nTar := nData40.wCHTar shr 10;
    //l_V := getDbData(nData.dbVal);

    //l_V:=l_V;
//    TraceL(3, m_nTxMsg.m_swObjID,'(__)CCE16401M::>Data Month:Tar:'+IntTostr(nTar)+
//                                                    ' Sta:'+IntToHex(nData40.byStatus,2)+
//                                                    ' Val:'+FloatToStr(l_V));
    FillSaveDataMessage(l_V, m_Req.m_swParamID, i, true);     saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
  End;
  Result:=res;
  //FinalAction();
end;

(*******************************************************************************
 * ������ ����������� �������� ������� �� ���������  90 �����
 ******************************************************************************)
function CCE16401MMeter.getDbData(var byValue:array of byte):Double;
Var
   dwMant : Dword;
   ddMant,dMS,dSM,dSE : int64;
   byExp  : Byte;
   ddHE : int64;
   dbValue : Double;
   nSign  : Integer;
   pV40   : array[0..8] of byte;

   m,e,n,b:Cardinal;
   x:Real;
Begin
   //pV40    := @dwMant;
  { ddMant  := 0;
   pV40[0] := byValue[0];
   pV40[1] := byValue[1];
   pV40[2] := byValue[2];
   pV40[3] := byValue[3];
   pV40[4] := byValue[4];
   move(pV40,ddMant,4);
         //30CB9D03C0000000
   dSM := $8000000000000000;
   dMS := 8+8+4;
   ddMant := ddMant shl dMS;
   if (pV40[4] and $80)<>0 then ddMant := ddMant or dSM;
   byExp := pV40[4] and $7f;
   ddHE  := (Word(byExp and $f0) shl 4)+Word(byExp and $0f);
   //if ((ddHE and $0008)<>0) and ((ddHE and $0100)<>0) then
   if ((byExp and $8)<>0) and ((byExp and $10)<>0)  then
     ddHE := ddHE or $f0;

   dSE   := 1+4+16+31;
   ddMant:= ddMant or (ddHE shl dSE);
   move(ddMant,dbValue,8);
   IsTrueValue(dbValue);
   //dwMant := dwMant and $7fffffff;
   //10 02 FD FE 8B C3 00 9E CF 19 07 7B 70 F5 28 D6 F5 4C 70 A8 10 03
   //byExp   := ((pV40[4] shl 1) and $fe)or (pV40[3] shr 7);
   //byExp   := pV40[4] and $7f;
   //if (pV40[4] and $80)<>0 then nSign := -1  else
   //if (pV40[4] and $80)=0  then nSign := 1;
   //if (byExp=0) then dwMant := (dwMant shl 1);
   //result := nSign*dwMant*power(2,byExp-127);
//   TraceL(2, m_nTxMsg.m_swObjID,'(__)CCE16401M::>HVL:'+IntTostr(ddMant)+' : '+IntToHex(ddMant,16)+
//                                               ' EXP:'+IntToStr(ddHE)+' : '+IntToHex(ddHE,4)+
//                                                 ' VAL:'+FloatToStr(dbValue));    }
   m:=0;
   e:=0;
   pV40[0] := byValue[0];
   pV40[1] := byValue[1];
   pV40[2] := byValue[2];
   pV40[3] := byValue[3];
   pV40[4] := byValue[4];
   move(pV40,m,4);
   move(pV40[4],e,1);
   n:=32;
   b:=7;
   x:=Power(2,e-power(2,b-1)+1)*(1+m/power(2,n));
   dbValue:=x;
   //if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+') dbValue = '+FloatToStr(dbValue));//AAV
   result := dbValue;
End;
procedure   CCE16401MMeter.REQ0134_GetSresEnergy(var nReq: CQueryPrimitive);
var
  l_Y, l_M, l_D : WORD;
  t : DWORD;
  dtDT : TDateTime;
  strF,strP : String;
  nProfile : Integer;
  nChannel : Word;
begin
  //m_QTimestamp := Now();
  m_QFNC       := $0134;
  m_Req        := nReq;
  dtDT := trunc(now-nReq.m_swSpecc0);
  m_QTimestamp := dtDT;
  getChann(nReq.m_swParamID,strF,nProfile,nChannel);
  if (strF='F0') then FillMessageHead(m_nTxMsg,FillMsg30F0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel)) else
  if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsg30F1(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel))else
  if (strF='F2') then FillMessageHead(m_nTxMsg,FillMsg30F0(m_nTxMsg,dtDT,nProfile,byMaxTar,nChannel));
  //if (strF='F1') then FillMessageHead(m_nTxMsg,FillMsgF1(m_nTxMsg,dtDT,nProfile,nReq.m_swSpecc1));
  SendToL1(BOX_L1 ,@m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;

(*******************************************************************************
 * �����
 ******************************************************************************)
procedure   CCE16401MMeter.RES0134_GetSresEnergy(var pMsg : CMessage);
var
  i : integer;
  l_Y, l_M, l_D:Word;
  nData : CDBData40;
  nTar : Byte;
  l_V : double;
  strF,strP : String;
  nProfile : Integer;
  nChannel : Word;
begin
  DecodeDate(m_QTimestamp, l_Y, l_M, l_D);
  getChann(nReq.m_swParamID,strF,nProfile,nChannel);
  if (strF='F2') then
  Begin
   for i:=0 to 11 do
   begin
    FillSaveDataMessage(0, 0, 0, false);
    m_nRxMsg.m_sbyDirID   := IsUpdate;
    m_nRxMsg.m_sbyServerID:= 12*nReq.m_swSpecc1+i;
    m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[1] := m_Req.m_swParamID;
    m_nRxMsg.m_sbyInfo[2] := l_Y-2000;
    m_nRxMsg.m_sbyInfo[3] := l_M;
    m_nRxMsg.m_sbyInfo[4] := l_D;
    m_nRxMsg.m_sbyInfo[5] := 0; // H
    m_nRxMsg.m_sbyInfo[6] := 0; // M
    m_nRxMsg.m_sbyInfo[7] := 0; // S
    m_nRxMsg.m_sbyInfo[8] := 0; // HH


     move(pMsg.m_sbyInfo[29+i*(sizeof(CDBData40)+3)],l_V,(sizeof(CDBData40)-4));{sizeof(CDBData40)}
   // move(pMsg.m_sbyInfo[7+i*sizeof(CDBData40)],nData,sizeof(CDBData40));

    nTar := nData.wCHTar shr 10;
    l_V := l_V * m_nP.m_sfKI * m_nP.m_sfKU;
    move(l_V, m_nRxMsg.m_sbyInfo[9], sizeof(double));
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   end;
  End
  else begin

   for i:=0 to 11 do
   begin
    FillSaveDataMessage(0, 0, 0, false);
    m_nRxMsg.m_sbyDirID   := IsUpdate;
    m_nRxMsg.m_sbyServerID:= 12*nReq.m_swSpecc1+i;
    m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[0] := 9 + sizeof(double);
    m_nRxMsg.m_sbyInfo[1] := m_Req.m_swParamID;
    m_nRxMsg.m_sbyInfo[2] := l_Y-2000;
    m_nRxMsg.m_sbyInfo[3] := l_M;
    m_nRxMsg.m_sbyInfo[4] := l_D;
    m_nRxMsg.m_sbyInfo[5] := 0; // H
    m_nRxMsg.m_sbyInfo[6] := 0; // M
    m_nRxMsg.m_sbyInfo[7] := 0; // S
    m_nRxMsg.m_sbyInfo[8] := 0; // HH


    move(pMsg.m_sbyInfo[7+i*sizeof(CDBData40)],nData,sizeof(CDBData40));
    nTar := nData.wCHTar shr 10;
    l_V := getDbData(nData.dbVal);
    l_V := l_V * m_nP.m_sfKI * m_nP.m_sfKU;
    move(l_V, m_nRxMsg.m_sbyInfo[9], sizeof(double));
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
   End;
  end;
  FinalAction();
end;

(******************************************************************************
 * ������ ������ �� �������
 ******************************************************************************)
procedure CCE16401MMeter.REQ0138_GetEvents(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0138;
  m_QTimestamp := Now();
  m_Req := nReq;

  m_nTxMsg.m_sbyInfo[13] := nReq.m_swSpecc0;
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc1;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CCE16401M::>Out DRQ:',@m_nTxMsg);
end;

(******************************************************************************
 * �����
 ******************************************************************************)
procedure CCE16401MMeter.RES0138_GetEvents(var pMsg:CMessage);
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
end;

(*******************************************************************************
 * ������������ ������� �� ���������� ��������� ������������ �������
 ******************************************************************************)
procedure CCE16401MMeter.ADD_Energy_Sum_GraphQry();
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
procedure CCE16401MMeter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CCE16401MMeter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
end;

{*******************************************************************************
 * ������������ ������� �� ����������
 ******************************************************************************}
procedure CCE16401MMeter.ADD_NakEnergyMonth_Qry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   if (cDateTimeR.CompareMonth(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareMonth(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareMonth(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecMonth(TempDate);
       Inc(i);
       if i > 12 then
         exit;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i - 1, 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;

procedure CCE16401MMeter.ADD_NakEnergyDay_Qry(_DTS, _DTE : TDateTime);
begin
  m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, trunc(now-_DTS), 0, 0, 1);
end;

procedure CCE16401MMeter.ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);
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
procedure   CCE16401MMeter.ADD_AUTORIS_GraphQry(dt_Date1, dt_Date2 : TDateTime);
begin
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
     m_nObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
end;

procedure CCE16401MMeter.ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
begin
    m_nObserver.ClearGraphQry();
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
    m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, trunc(now-dt_Date2), 0, 0, 1);
    m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, trunc(now-dt_Date2), 1, 0, 1);
    m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, trunc(now-dt_Date2), 2, 0, 1);
    m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, trunc(now-dt_Date2), 3, 0, 1);
end;
function CCE16401MMeter.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;
function CCE16401MMeter.getChann(_ParamID:WORD;var strP0:String;var nProfile:Integer;var nChannel:Word):boolean;
var
    l_i : Integer;
    str,strT : String;
begin
    Result := false;
    with m_nObserver.pm_sInil2CmdTbl.LockList do
    try
    for l_i := 0 to count - 1 do
        if (CComm(Items[l_i]).m_swCmdID = _ParamID) then
        begin
            str   := CComm(Items[l_i]).m_swChannel;
            strP0 := GetParceString(0,str);
            strT  := GetParceString(1,str);
            if (strT<>'') then nProfile := StrToInt(strT) else nProfile := 0;
            strT  := GetParceString(2,str);
            if (strT<>'') then nChannel := StrToInt(strT) else nChannel := 0;
            exit;
        end;
    finally
     m_nObserver.pm_sInil2CmdTbl.UnLockList;
    end;
end;

function CCE16401MMeter.ReadByError(var pMsg:CMessage) :boolean;
var
    byErr : Byte;
    nLen : Word;
    strP0:String;
    nProfile:Integer;
    nChannel:Word;
begin
    Result:=true;
      byErr := IsValidMessage(pMsg);

      (*
      if(((nReq.m_swParamID=QRY_NAK_EN_DAY_EP)or (nReq.m_swParamID=QRY_NAK_EN_DAY_EP))and(byErr=0)and(pMsg.m_sbyInfo[5]<>$21)) then
      Begin
         getChann(nReq.m_swParamID,strP0,nProfile,nChannel);
         if(nChannel<>getChannelEx(pMsg)) then
         Begin
           Result := false;
           exit;
         End;
      End;
      *)

      if byErr=1 then
      Begin
//       TraceM(2,pMsg.m_swObjID,'(__)CCE16401M::>Command Error :',@pMsg);
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+')CCE16401M::>Command Error');//AAV
       Result := false;
       exit;
      End else
      if byErr=2 then
      begin
//        TraceM(2,pMsg.m_swObjID,'(__)CCE16401M::>Crc Error :',@pMsg);
//        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+')CCE16401M::>Crc Error');//AAV
        Result := false;
        exit;
      end;
      if not((m_QFNC=$0002)or(pMsg.m_sbyInfo[5]=$21)) then
      Begin
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+')CCE16401M::>SESSION OPEN');//AAV
      End;
      if (pMsg.m_sbyInfo[5]=$21) then
      Begin
//       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(m_nP.m_swMID)+')Command Error Autorization!');//AAV
       // m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
       // m_nObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
       //  case m_QFNC of // FUNCTION
       // $0135 : ADD_NakEnergyMonth_Qry(DTS_V, DTE_V);
       // $0133 : ADD_NakEnergyDay_Qry(DTS_V, DTE_V);
       // end;
       exit;
      End;
end;

End.
