{**
 * Project:     Konus-2000E
 * File:        knsl2E9CTK310Q2H4MMeter.pas
 * Description: ������ ��������� �������� �������-9 ���3-10Q2H4M
 *
 * Delphi version 5
 *
 * Category    Meters
 * Package     Protocols
 * Subpackage  L2Meter
 * Author      Petrushevitch Roman <ukrop.gs@gmail.com>
 * Copyright   2008-2012 Automation-2000, LLC
 *
 * License     Private Licence
 * Version:    2.3.33.763 SVN: $Id$
 * Link        Meters/L2E9CTK310Q2H4MMeter
 *}

unit knsl2E9CTK310Q2H4MMeter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, knsl5tracer, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    CE9CTK310Q2H4MMeter = class(CMeter)
    private
        m_QFNC          : BYTE;
        m_QTimestamp    : TDateTime;

        m_ParamID       : BYTE;
        m_Index         : WORD;

        m_LaEnd : WORD; //

        m_IsAuthorized  : Boolean;
        //IsUpdate        : BYTE;

        m_CODER : array[0..3] of BYTE;
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

        procedure   HandQryRoutine(var pMsg:CMessage);
        procedure   ControlRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        function    CMD2ID(_CMDID : BYTE) : BYTE;
        function    BCDToInt(_BCD : array of BYTE; _Count : Integer) : Integer;

        function    CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);

        procedure   EncodePacket(var _Buffer : array of BYTE);
        procedure   DecompressPacket(var _Buffer : array of BYTE);

        // protocol REQUESTS
        procedure   REQ03_OpenSession(var nReq: CQueryPrimitive);   // ������� ������ � ��������
        procedure   RES04_OpenSession_OK(var pMsg:CMessage);        // ����� �����������
        {?} procedure   RES05_OpenSession_Fail(var pMsg:CMessage);      // ������ ������

        procedure   REQ03_GetZN(var nReq: CQueryPrimitive);   // ������� ������ � ��������
        procedure   RES04_GetZN_OK(var pMsg:CMessage);        // ����� �����������

        procedure   REQ05_CloseSession(var nReq: CQueryPrimitive);  // ������� ������ (� ��������������)
        procedure   RES05_SessionClosed(var pMsg:CMessage);         // ������ ������

        procedure   REQ06_GetDataByID(var nReq: CQueryPrimitive);   // ������ ������ �� ��������������
        procedure   RES06_GetDataByID(var pMsg:CMessage);           // ����� �� ������
        procedure   RES01_GetDataByID_Fail(var pMsg : CMessage);    // ������

        procedure   REQ07_GetDateTime(var nReq: CQueryPrimitive);   // ������ ����/�������
        procedure   RES07_GetDateTime(var pMsg : CMessage);         // ����� ����/�������

        procedure   REQ08_SetDateTime(var nReq: CQueryPrimitive);   // ���������� ����/�����
        procedure   RES00_SetDateTime_OK(var pMsg : CMessage);      // ����� �������� ��������� ����/�������

        procedure   REQ0A_GetSysErrors(var nReq: CQueryPrimitive);   // ������ ������ �������
        {?} procedure   RES0A_GetSysErrors(var pMsg : CMessage);      // ����� �� ������ "������ ������ �������"

        procedure   REQ0D_GetCurrentPUI(var nReq: CQueryPrimitive);   // ������ ������� �������� ��������, ���������� � ����
        procedure   RES0D_GetCurrentPUI(var pMsg : CMessage);      // ����� �� ������ "������ ������� �������� ��������, ���������� � ����"

        procedure   REQ0F_GetCurrentPower(var nReq: CQueryPrimitive); // ������� "�������� ��������"
        procedure   RES0F_GetCurrentPower(var pMsg:CMessage);         // ����� �� ������ "�������� ��������"

        procedure   REQ10_GetCurrentU(var nReq: CQueryPrimitive); // ������� "�������� ����������"
        procedure   RES10_GetCurrentU(var pMsg:CMessage);         // ����� �� ������ "�������� ����������"

        procedure   REQ11_GetCurrentI(var nReq: CQueryPrimitive); // ������� "�������� ���"
        procedure   RES11_GetCurrentI(var pMsg:CMessage);         // ����� �� ������ "�������� ���"

        procedure   REQ12_GetCurrentE(var nReq: CQueryPrimitive); // ������� "�������� ��� �������"
        procedure   RES12_GetCurrentE(var pMsg:CMessage);         // ����� �� ������ "�������� ��� �������"

        {?} procedure   REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);
        {?} procedure   RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
        {?} procedure   RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);

        // protocol maps
        procedure   ADD_Energy_Sum_GraphQry(_ParamID : WORD);
        procedure   ADD_RelayState_CTRLQry(_StateID : WORD);
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        procedure   ADD_SresEnergyDay_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
    End;

    // ���������� ��������� ���� �� �������
    _poket = packed record
      total : DWORD;        // ����� �� ������
	    curr_month : DWORD;   // �� ����� �������
	    last_month : DWORD;		// �� ����� ���������
    	CRC : WORD;
    End;

    // ������ �������� �� ��������� MAXLAST
    _last = packed record
      DTSMALL : WORD;   // ���� � ����� ( ����������� ������� )
	    value   : WORD;   // �������� (�� 15, 30, 45, 60 �����) ������ 1 Wh
    	CRC     : WORD;
    End;

    // ���� �������
    _events = packed record
      DATE : DWORD;				// ���� � ����� �������
      CNT  : DWORD;				// ����� �������
      CRC  : WORD;
    end;

  
    // ������������ �������� ��� ������� ������
    _pwmax = packed record
      value : DWORD;
      CRC   : WORD;
    end;


const
  E9CTK1_CRCT: array [0..255] of byte = (
        0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
        157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
        35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
        190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
        70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
        219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
        101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
        248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
        140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
        17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
        175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
        50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
        202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
        87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
        233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
        116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
    );
  c_RelayState: array[0..2] of BYTE = ($30, $31, $46);
  c_IntTime: array[0..3] of BYTE = (0, 15, 30, 45);
  c_DIV: array[0..2] of WORD = (1, 32, 1024);

implementation


{*******************************************************************************
 *
 ******************************************************************************}
constructor CE9CTK310Q2H4MMeter.Create;
Begin
  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> E9CTK1 Meter Created');
  m_LaEnd := 0;
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CE9CTK310Q2H4MMeter.Destroy;
Begin
    inherited;
End;

procedure CE9CTK310Q2H4MMeter.RunMeter; Begin end;

function CE9CTK310Q2H4MMeter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9CTK310Q2H4MMeter.InitMeter(var pL2:SL2TAG);
Begin
  IsUpdate := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;

  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>E9CTK    Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;





{*******************************************************************************
 * ���������� ������� ������� ������
 ******************************************************************************}
function CE9CTK310Q2H4MMeter.LoHandler(var pMsg:CMessage):Boolean;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      TraceM(2,pMsg.m_swObjID,'(__)CE9CTK3::>Inp DRQ:',@pMsg);

      if not IsValidMessage(pMsg) then
      begin
        TraceM(2,pMsg.m_swObjID,'(__)CE9CTK3::>Error ControlField:',@pMsg);
        Result := false;
        exit;
      end;
      EncodePacket(pMsg.m_sbyInfo);
      { TODO 5 -oUkrop -cFIXME : ������� ������������ ������ DecompressPacket(pMsg.m_sbyInfo);}

      case ( (m_QFNC shl 8) OR pMsg.m_sbyInfo[2]) of // FUNCTION
        $0304 : RES04_OpenSession_OK(pMsg);
        $0305 : RES05_OpenSession_Fail(pMsg);
        $0505 : RES05_SessionClosed(pMsg);
        $0606 : RES06_GetDataByID(pMsg);
        $0601 : RES01_GetDataByID_Fail(pMsg);
        $0707 : RES07_GetDateTime(pMsg);
        $0800 : RES00_SetDateTime_OK(pMsg);
        $0F0F : RES0F_GetCurrentPower(pMsg);
        $0E00 : RES00_CTRL_SetRelayState_OK(pMsg);
        $0E01 : RES01_CTRL_SetRelayState_Fail(pMsg);
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
function CE9CTK310Q2H4MMeter.HiHandler(var pMsg:CMessage):Boolean;
Var
    nReq : CQueryPrimitive;
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
        QRY_ENERGY_SUM_EP,
        QRY_ENERGY_MON_EP :
          REQ06_GetDataByID(nReq);

        QRY_SRES_ENR_EP :
          REQ06_GetDataByID(nReq);

        QRY_DATA_TIME :
          REQ07_GetDateTime(nReq);

        QRY_JRNL_T3 :
          REQ06_GetDataByID(nReq);

        QRY_MGAKT_POW_S :
          REQ0F_GetCurrentPower(nReq);

        QRY_AUTORIZATION :
        begin
          if (not m_IsAuthorized) then
            REQ03_OpenSession(nReq)
          else
            FinalAction();
        end;

        QRY_NULL_COMM :
        begin
          if (m_IsAuthorized) then
            REQ05_CloseSession(nReq)
          else
            FinalAction();
        end;

        QRY_RELAY_CTRL :
          REQ0E_CTRL_SetRelayState(nReq);

        else
          FinalAction();
      end;

      TraceM(2,pMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@pMsg);
//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);

//    QL_DATA_CTRL_REQ     : ControlRoutine(pMsg);

    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


{*******************************************************************************
 *  ������� ����������� �����
 *      @param var _Buff : array of BYTE
 *      @param _Count : WORD ������ ����� ��������� (� ����������� ������)
 *      @param _SetCRC16 : Boolean
 *      @return Boolean 
 ********************************+**********************************************}
function  CE9CTK310Q2H4MMeter.CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
var
    i, l_Count : integer;
begin
  Result  := 0;
  l_Count := _Buff[1] + 2;

  for i := 1 to l_Count do
    Result := E9CTK1_CRCT[Result XOR _Buff[i]];
end;


{*******************************************************************************
 *  �������� ����������� ���������
 *      @param var pMsg : CMessage ���������
 *      @return Boolean 
 ******************************************************************************}
function CE9CTK310Q2H4MMeter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    l_DataLen : WORD;
begin
    Result := false;
    l_DataLen :=  pMsg.m_sbyInfo[1];
{
    if (pMsg.m_sbyInfo[2] = $06) then
      exit;//l_DataLen := l_DataLen + 2;
}
      
    // ����������� �����
    if (self.CRC8(pMsg.m_sbyInfo, true) <> pMsg.m_sbyInfo[3 + l_DataLen]) then
    begin
        TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9CTK3 ������ CRC! �����!');
        exit;
    end;

  Result := true;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9CTK310Q2H4MMeter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_E9CTK310Q2H4M;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;


{*******************************************************************************
 *  ������������ ��������� ���������� ������
 *      @param _Value : double �������� ���������
 *      @param _EType : byte ��� �������
 *      @param _Tariff : byte ������
 *      @param _WriteDate : Boolean ���������� ����� �������
 ******************************************************************************}
procedure CE9CTK310Q2H4MMeter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
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
        QRY_NAK_EN_MONTH_EP,
        QRY_NAK_EN_MONTH_EM,
        QRY_NAK_EN_MONTH_RP,
        QRY_NAK_EN_MONTH_RM :
        begin
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := 1;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
          end;

        QRY_ENERGY_MON_EP,
        QRY_ENERGY_MON_EM,
        QRY_ENERGY_MON_RP,
        QRY_ENERGY_MON_RM :
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

        QRY_NAK_EN_DAY_EP,
        QRY_NAK_EN_DAY_EM,
        QRY_NAK_EN_DAY_RP,
        QRY_NAK_EN_DAY_RM,
        QRY_ENERGY_DAY_EP,
        QRY_ENERGY_DAY_EM,
        QRY_ENERGY_DAY_RP,
        QRY_ENERGY_DAY_RM :
        begin
            cDateTimeR.IncDate(m_QTimestamp);
            DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
            m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
            m_nRxMsg.m_sbyInfo[3] := l_Month;
            m_nRxMsg.m_sbyInfo[4] := l_Day;
            m_nRxMsg.m_sbyInfo[5] := 00;
            m_nRxMsg.m_sbyInfo[6] := 00;
            m_nRxMsg.m_sbyInfo[7] := 00;
        end;{
       QRY_U_PARAM_S,
       QRY_U_PARAM_A,
       QRY_U_PARAM_B,
       QRY_U_PARAM_C,
       QRY_I_PARAM_S,
       QRY_I_PARAM_A,
       QRY_I_PARAM_B,
       QRY_I_PARAM_C,
       QRY_KOEF_POW_A,
       QRY_KOEF_POW_B,
       QRY_KOEF_POW_C,
       QRY_FREQ_NET :
       begin
        DecodeDate(m_QTimestamp, l_Year, l_Month, l_Day);
        DecodeTime(m_QTimestamp, l_Hour, l_Min, l_Second, l_MS);
        m_nRxMsg.m_sbyServerID := l_Hour * 2 + (l_Min div 30);
        m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
        m_nRxMsg.m_sbyInfo[3] := l_Month;
        m_nRxMsg.m_sbyInfo[4] := l_Day;
        m_nRxMsg.m_sbyInfo[5] := l_Hour;
        m_nRxMsg.m_sbyInfo[6] := l_Min;
        m_nRxMsg.m_sbyInfo[7] := l_Second;
      end;}
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



{******************************************************************************
 *  ��������� ������ ��������� � ��������� ��301 �� ID ���������
 *      @param  _ParamID : Byte
 *      @return Integer
 ******************************************************************************}
function CE9CTK310Q2H4MMeter.CMD2ID(_CMDID : BYTE) : BYTE;
Begin
  case _CMDID of
    QRY_ENERGY_SUM_EP : Result := 4;  // Ronly	4	POKET	0�7	����������� ������� �� �������	_poket
    QRY_ENERGY_MON_EP : Result := 4;
    QRY_SRES_ENR_EP   : Result := 11; // Ronly	11	LAST	0�609	������ ��������	_last
    QRY_JRNL_T3       : Result := 16; // Ronly	16	EVENTS	0�4	�������	_events
    QRY_MAX_POWER_EP  : Result := 19; // RW	19	PWMAX	0�7	������������ �������� ��� ������� ������	_pwmax
    else
        Result := $FF;
    end;
End;

function CE9CTK310Q2H4MMeter.BCDToInt(_BCD : array of BYTE; _Count : Integer) : Integer;
var
  i : Integer;
  l_Mult : Integer;
begin
  Result := 0;
  l_Mult := 1;
  
  for i := 1 to _Count do
  begin
    Result := Result + (_BCD[i-1] and $0F)*l_Mult;
    l_Mult := l_Mult * 10;
    Result := Result + ((_BCD[i-1] and $F0) shr 4)*l_Mult;
    l_Mult := l_Mult * 10;
  end;
end;

procedure CE9CTK310Q2H4MMeter.HandQryRoutine(var pMsg:CMessage);
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
    // !!!!!!!!!!!!!!!!!!!!!!!!!! ��������� ������� � ����
    Move(pDS.m_sbyInfo[0],DTE,szDT);
    Move(pDS.m_sbyInfo[szDT],DTS,szDT);

    l_Param := pDS.m_swData1;
    case l_Param of
        QRY_ENERGY_SUM_EP,
        QRY_ENERGY_MON_EP :
          ADD_Energy_Sum_GraphQry(l_Param);

        QRY_SRES_ENR_EP :
          ADD_SresEnergyDay_GraphQry(l_Param, DTS, DTE);

        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;


procedure CE9CTK310Q2H4MMeter.ControlRoutine(var pMsg:CMessage);
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
        QRY_RELAY_CTRL :
          ADD_RelayState_CTRLQry(l_StateID);
    end;
end;


procedure CE9CTK310Q2H4MMeter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
    OnFinalAction();
    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CE9CTK3 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CE9CTK310Q2H4MMeter.OnEnterAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9CTK3 OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CE9CTK310Q2H4MMeter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9CTK3 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CE9CTK310Q2H4MMeter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9CTK3 OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CE9CTK310Q2H4MMeter.OnFinalAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9CTK3 OnFinalAction');
    FinalAction;
end;








procedure   CE9CTK310Q2H4MMeter.EncodePacket(var _Buffer : array of BYTE);
var
  l_i : Integer;
begin
  for l_i := 0 to _Buffer[1] do
    _Buffer[l_i + 3] := _Buffer[l_i + 3] XOR m_CODER[l_i AND 3];
end;

{
1.	���� ��� 7 ����� �2 �������� ������ ����� 0 - ������ �� ���� �������������;
2.	�������� ��� 7 ����� �2 �������� ������;
3.	��������� ���� ������� (3-� ���� ������� ������);
4.	���� ���� ����� ����� ������� ��������� ����� ����������, ���� ��� ���������� � ��������� ��� ��������� ����� ���;
5.	���������� 1-� ���� �������� ������=������� ������������� ������;
}
procedure   CE9CTK310Q2H4MMeter.DecompressPacket(var _Buffer : array of BYTE);
var
  i, j,l : Integer;
  l_rByte : BYTE;
  l_tBuffer : array[0..128] of BYTE;
begin
  exit;
  
  if (_Buffer[2] AND $80)=$80 then
  begin
    l_rByte := _Buffer[3];

    for i := 4 to _Buffer[1] do
    begin
      if (_Buffer[i] = l_rByte) then
      begin
        for l := 0 to _Buffer[i + 1] do
        begin
          l_tBuffer[j] := _Buffer[i+l];
          Inc(j);
        end;
      end else
          l_tBuffer[j] := _Buffer[i];
    end;
  end;
end;























(*******************************************************************************
 * ������� "������� ������ � ��������"
 *  0	 UCHAR	0x7E    ������� ������ ������
 *  1	 UCHAR	0x08	  ������ �������� ������
 *  2	 UCHAR	0x03	  ������� "������� ������ � ��������"
 *  3	 ULONG	ZNUMBER	��������� ����� ��������
 *  7	 ULONG	IDENT	  ������������� ��������
 *  11 UCHAR	CRC8	  ����������� ����� ������ ������
 *
 *  @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ03_OpenSession(var nReq: CQueryPrimitive);
var
  l_FabNum   : DWORD;
  l_Ident    : DWORD;
begin
  m_QFNC       := $03;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
  ZeroMemory(@m_CODER, 4);
  
  // ������� ������ � ��������
  m_nTxMsg.m_sbyInfo[0] := $7E; // ������� ������ ������
  m_nTxMsg.m_sbyInfo[1] := $08; // ������ �������� ������
  m_nTxMsg.m_sbyInfo[2] := $03; // ������� "������� ������ � ��������"

  l_FabNum := StrToInt(m_nP.m_sddFabNum); // ��������� ����� �������� (������� ���� �� �������� ������)
  m_nTxMsg.m_sbyInfo[3] := (l_FabNum AND $FF000000) shr 24;
  m_nTxMsg.m_sbyInfo[4] := (l_FabNum AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[5] := (l_FabNum AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[6] := (l_FabNum AND $000000FF);

  l_Ident := StrToInt(m_nP.m_schPassword); // ������������� �������� (������� ���� �� �������� ������)
  m_nTxMsg.m_sbyInfo[7] := (l_Ident AND $FF000000) shr 24;
  m_nTxMsg.m_sbyInfo[8] := (l_Ident AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[9] := (l_Ident AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[10]:= (l_Ident AND $000000FF);

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 12);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "������� ������ � ��������" (������� ������ �� 4-� ������)
 *    ����� ������ ������ � ������ ���������� ���������� ������ � �������������� � ����� ���:
 *  0	UCHAR	0x7E	������� ������ ������
 *  1	UCHAR	0x05	������ ������ ����� ������������� � ������������
 *  2	UCHAR	0x04	����� "����� �����������"
 *  3	UCHAR	0x01	������ ��������
 *  4	UCHAR	RND0	�������� ��� ������������� CODER[0]
 *  5	UCHAR	RND1	�������� ��� ������������� CODER[1]
 *  6	UCHAR	RND2	�������� ��� ������������� CODER[2]
 *  7	UCHAR	RND3	�������� ��� ������������� CODER[3]
 *  8	UCHAR	CRC8	����������� ����� ������ ������
 *
 *    ������ ������� ��� ��� ���������� ������� ������������.
 *
 *    ��� ����� 3 �������� ������� ������ � �������� ���������������, �������
 * ����������� �� ����� ��� �� 2-�� ����� � ������ ��������� - ������ ������ -
 * � ������������� �� �������� �������������� ��� ������� �������
 *
 *    @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES04_OpenSession_OK(var pMsg:CMessage);
begin
  m_IsAuthorized := true;

  m_CODER[0] := pMsg.m_sbyInfo[4];
  m_CODER[1] := pMsg.m_sbyInfo[5];
  m_CODER[2] := pMsg.m_sbyInfo[6];
  m_CODER[3] := pMsg.m_sbyInfo[7];

  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ������ �������. ������ ��������: ' + IntToStr(pMsg.m_sbyInfo[3]) );
  FinalAction();
end;


(*******************************************************************************
 * ������� "������� ������ � ��������"
 *  0	 UCHAR	0x7E    ������� ������ ������
 *  1	 UCHAR	0x08	  ������ �������� ������
 *  2	 UCHAR	0x03	  ������� "������� ������ � ��������"
 *  3	 ULONG	ZNUMBER	��������� ����� ��������
 *  7	 ULONG	IDENT	  ������������� ��������
 *  11 UCHAR	CRC8	  ����������� ����� ������ ������
 *
 *  @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ03_GetZN(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0B;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
  ZeroMemory(@m_CODER, 4);
  
  // ������� ������ � ��������
  m_nTxMsg.m_sbyInfo[0] := $7E; // ������� ������ ������
  m_nTxMsg.m_sbyInfo[1] := $00; // ������ �������� ������
  m_nTxMsg.m_sbyInfo[2] := $0b; // ������� "������� ������ � ��������"

  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES04_GetZN_OK(var pMsg:CMessage);
var
  l_ : DWORD;
begin
  Move(pMsg.m_sbyInfo[3], l_, 4);
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> �������: ' + IntToStr(l_) );
  FinalAction();
end;



(*******************************************************************************
 * ����� �� ������� "������� ������ � ��������" (��� ��������������� �������)
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x05	����� "������ ������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 *
 *   @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES05_OpenSession_Fail(var pMsg:CMessage);
begin
  m_IsAuthorized := false;
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ������: ������ ������!');
  FinalAction();
end;


(*******************************************************************************
 *   ������� "������� ������ � �������� � ��������������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ �������� ������
 *   2	UCHAR	0x05	������� "������� ������ � ��������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 *
 *   @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ05_CloseSession(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $05;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $05;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "������� ������ � �������� � ��������������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x05	����� "������ ������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 * ������ ������� ��� �������� ������� ������������.
 *
 * @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES05_SessionClosed(var pMsg:CMessage);
begin
  m_IsAuthorized := false;

  ZeroMemory(@m_CODER, 4);
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ������ ������ �� �������!');
  FinalAction();
end;


(*******************************************************************************
 * ������� "������ ������ �� ��������������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x03	������ �������� ������
 *   2	UCHAR	0x06	������� "������ ������ �� ��������������"
 *   3	UCHAR	ID	  ������������� �������������� ���� ������ (������� ���� �� �������� ������)
 *   4	UINT	Index	������ ���� ������(������� ���� �� �������� ������)
 *   6	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ06_GetDataByID(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $06;
  m_QTimestamp := Now();
  m_ParamID := CMD2ID(nReq.m_swParamID);
  m_Index := nReq.m_swSpecc1;

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $03;
  m_nTxMsg.m_sbyInfo[2] := $06;
  m_nTxMsg.m_sbyInfo[3] := m_ParamID;

  m_nTxMsg.m_sbyInfo[4] := (nReq.m_swSpecc1 shr 8) AND $00FF;
  m_nTxMsg.m_sbyInfo[5] := nReq.m_swSpecc1 AND $00FF;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[6] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 7);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "������ ������ �� ��������������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	SIZE	������ ������ ����� ������������� � ������������ (������������ ID ����������� ������)
 *   2	UCHAR	0x06	����� "������ �������"
 *   3	VOID[SIZE]	Data	������
 *   3+SIZE	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var pMsg : CMessage
 *******************************************************************************)
                            { TODO 5 -oUkrop -cERROR : ����������� ������ }
procedure CE9CTK310Q2H4MMeter.RES06_GetDataByID(var pMsg : CMessage);
var
  s4 : _poket;
  s11: _last;

  l_Yn, l_Mn, l_Dn,
  l_Y, l_M, l_D,
  l_hh, l_mm : WORD;
begin
  case (m_ParamID) of
    4:  // Ronly	4	POKET	0�7	����������� ������� �� �������	_poket
    begin
      m_QTimestamp := Now();
      Move(pMsg.m_sbyInfo[3], s4, sizeof(s4));

      s4.total := EndianSwap(s4.total);
      s4.curr_month := EndianSwap(s4.curr_month);
      s4.last_month := EndianSwap(s4.last_month);

      FillSaveDataMessage(s4.total * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0, QRY_ENERGY_SUM_EP, m_Index+1, true);
      FPUT(BOX_L3, @m_nRxMsg);

      FillSaveDataMessage(s4.curr_month * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0, QRY_ENERGY_MON_EP, m_Index+1, true);
//      FPUT(BOX_L3, @m_nRxMsg);

      m_QTimestamp := Now();
      FillSaveDataMessage((s4.total - s4.curr_month) * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0, QRY_NAK_EN_MONTH_EP, m_Index+1, true);
      FPUT(BOX_L3, @m_nRxMsg);

      cDateTimeR.DecMonthEx(1, m_QTimestamp);
      FillSaveDataMessage(s4.last_month * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0, QRY_ENERGY_MON_EP, m_Index+1, true);
      FPUT(BOX_L3, @m_nRxMsg);

      cDateTimeR.DecMonthEx(1, m_QTimestamp);
      FillSaveDataMessage((s4.total - s4.curr_month - s4.last_month) * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0, QRY_NAK_EN_MONTH_EP, m_Index+1, true);
//      FPUT(BOX_L3, @m_nRxMsg);

      FinalAction();
    end;
    11: // Ronly	11	LAST	0�719	������ ��������	_last
    begin
      m_QTimestamp := Now();
      Move(pMsg.m_sbyInfo[3], s11, sizeof(s11));

      s11.DTSMALL := swap(s11.DTSMALL);
      s11.value := swap(s11.value);
      
      FillSaveDataMessage(s11.value * m_nP.m_sfKI * m_nP.m_sfKU, QRY_SRES_ENR_EP,0, true);

      if (s11.DTSMALL=0) then
        FinalAction();
        
      l_M := (s11.DTSMALL shr 12) AND $0F;
      l_D := (s11.DTSMALL shr 7) AND $1F;
      l_hh := (s11.DTSMALL shr 2) AND $1F;
      l_mm := c_IntTime[s11.DTSMALL AND $03];

      try

      m_nRxMsg.m_sbyServerID := l_hh*2 + (l_mm div 30);

      DecodeDate(m_QTimestamp, l_Yn, l_Mn, l_Dn);
      l_Y := l_Yn;
      if (l_M > l_Mn) or ((l_Mn = l_M) and (l_D > l_Dn)) then
        Dec(l_Y);

      Eventbox.FixEvents(ET_NORMAL, '(__)CL2MD::> E9CTK1 ����:' + DateTimeToStr(EncodeDate(l_Y, l_M, l_D) + EncodeTime(l_hh, l_mm, 0, 0))
      + '��������: '+ FloatToStr(s11.value * m_nP.m_sfKI * m_nP.m_sfKU));


      m_nRxMsg.m_sbyInfo[0] := 13+4;
      m_nRxMsg.m_sbyInfo[2] := l_Y - 2000;
      m_nRxMsg.m_sbyInfo[3] := l_M;
      m_nRxMsg.m_sbyInfo[4] := l_D;
      m_nRxMsg.m_sbyInfo[5] := l_hh;
      m_nRxMsg.m_sbyInfo[6] := l_mm;
      m_nRxMsg.m_sbyInfo[7] := 0;
      except
        FinalAction();
      end;
      FinalAction();
    end;
    16: // Ronly	16	EVENTS	0�4	�������	_events
    begin
      //
    end;
    19: // RW	19	PWMAX	0�7	������������ �������� ��� ������� ������	_pwmax
    begin
    end;
    21: // RW	21	DOPPAR	0	��������� �������	_doppar
    begin
    end;
  end;
//  FinalAction();
end;

(*******************************************************************************
 * ������������� �����
 * �� ������� "������ ������ �� ��������������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x01	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x01	����� "������ �������"
 *   3	UCHAR
            	0x01	����� "������������ ����� ID"
              0x02	����� "������������ ����� �������"
              0x04	����� "������ CRC ����� ������ � ��������"
 *   4	UCHAR	CRC8	����������� ����� ������ ������
 * ������ ������� ��� �������� ������� ������������.
 *
 * @param var pMsg : CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES01_GetDataByID_Fail(var pMsg : CMessage);
var
  l_EStr : String;
begin
  if (pMsg.m_sbyInfo[3] = $01) then
    l_EStr := '������ �������: ������������ ����� ID!'
  else if (pMsg.m_sbyInfo[3] = $02) then
    l_EStr := '������ �������: ������������ ����� �������!'
  else if (pMsg.m_sbyInfo[3] = $04) then
    l_EStr := '������ �������: ������ CRC ����� ������ � ��������!';

  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::>' + l_EStr);
  FinalAction();
end;


(*******************************************************************************
 * ������� "������ ������� � ���� �� ��������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ �������� ������
 *   2	UCHAR	0x07	������� "������ ������� � ���� �� ��������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ07_GetDateTime(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $07;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $07;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


{����� �� ������� "������ ������� � ���� �� ��������" (������� ������ �� 4-� ������)
�	���	��������	��������

������ ������� ��� �������� ������� ������������.}
(*******************************************************************************
 * ����� �� ������� "������ ������� � ���� �� ��������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x08	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x07	����� "������ ������� � ���� �� ��������"
 *   3	UCHAR	Week	���� ������ (0�6, 0-�����������)
 *   4	UCHAR	Day	�����
 *   5	UCHAR	Month	�����
 *   6	UINT	Year	���
 *   8	UCHAR	Hour	����
 *   9	UCHAR	Min	������
 *   10	UCHAR	Sec	�������
 *   11	UCHAR	CRC8	����������� ����� ������ ������
 *   ������ ������� ��� �������� ������� ������������.
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES07_GetDateTime(var pMsg:CMessage);
var
  l_DT : TDateTime;
  l_ss, l_mm, l_hh,
  l_D, l_M, l_Y : WORD;

  nReq : CQueryPrimitive;
  Time : _SYSTEMTIME;
begin
  l_D  := pMsg.m_sbyInfo[4];
  l_M  := pMsg.m_sbyInfo[5];
  l_Y  := (pMsg.m_sbyInfo[7] * 100) + pMsg.m_sbyInfo[6];

  l_hh := pMsg.m_sbyInfo[8];
  l_mm := pMsg.m_sbyInfo[9];
  l_ss := pMsg.m_sbyInfo[10];

  FillSaveDataMessage(0, 0, 0, false);
  m_nRxMsg.m_sbyInfo[0] := 8;
  m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
  m_nRxMsg.m_sbyInfo[2] := l_Y - 2000; // year
  m_nRxMsg.m_sbyInfo[3] := l_M;        // month
  m_nRxMsg.m_sbyInfo[4] := l_D;        // day
  m_nRxMsg.m_sbyInfo[5] := l_hh;       // hour
  m_nRxMsg.m_sbyInfo[6] := l_mm;       // min
  m_nRxMsg.m_sbyInfo[7] := l_ss;       // sec
  FPUT(BOX_L3, @m_nRxMsg);
    
  l_DT := EncodeDate(l_Y, l_M, l_D) + EncodeTime(l_hh, l_mm, l_ss, 0);
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ����� ��������: ' + DateTimeToStr(l_DT));

  if (abs(now() - l_DT) > EncodeTime(0, 0, 2, 0)) then
  Begin
    if (m_nCF.cbm_sCorrDir.ItemIndex = 1)(* AND (nReq.m_swSpecc0 = 1*) then
    begin
      TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ��������� ������� � ��������: ' + DateTimeToStr(Now()));
      REQ08_SetDateTime(nReq);
    end
    else if (m_nCF.cbm_sCorrDir.ItemIndex = 0) then
    begin
      TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ��������� ������� � ���: ' + DateTimeToStr(Date));
      Time.wMilliseconds := 0;
      Time.wSecond    := m_nRxMsg.m_sbyInfo[7];
      Time.wMinute    := m_nRxMsg.m_sbyInfo[6];
      Time.wHour      := m_nRxMsg.m_sbyInfo[5];
      Time.wDay       := m_nRxMsg.m_sbyInfo[4];
      Time.wMonth     := m_nRxMsg.m_sbyInfo[3];
      Time.wYear      := 2000 + m_nRxMsg.m_sbyInfo[2];
      l_DT            := EncodeDate(Time.wYear, Time.wMonth, Time.wDay);
      Time.wDayOfWeek := DayOfWeek(l_DT);
      SetLocalTime(Time);
    end
    else
      FinalAction();
  End
  else
    FinalAction();
end;


(*******************************************************************************
 * ������� "������ ������� � ���� � �������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x08	������ �������� ������
 *   2	UCHAR	0x08	������� "������ ������� � ���� � �������"
 *   3	UCHAR	Week	���� ������ (0�6, 0-�����������)
 *   4	UCHAR	Day	�����
 *   5	UCHAR	Month	�����
 *   6	UINT	Year	���
 *   8	UCHAR	Hour	����
 *   9	UCHAR	Min	������
 *   10	UCHAR	Sec	�������
 *   11	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ08_SetDateTime(var nReq: CQueryPrimitive);
var
  l_DT : TDateTime;
  l_ms, l_ss, l_mm, l_hh,
  l_D, l_M, l_Y : WORD;
begin
  m_QFNC       := $08;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
  
  l_DT := Now();
  DecodeTime(l_DT, l_hh, l_mm, l_ss, l_ms);
  DecodeDate(l_DT, l_Y, l_M, l_D);  

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $08;
  m_nTxMsg.m_sbyInfo[2] := $08;

  m_nTxMsg.m_sbyInfo[3] := DayOfWeek(Now());
  m_nTxMsg.m_sbyInfo[4] := l_D;
  m_nTxMsg.m_sbyInfo[5] := l_M;
  m_nTxMsg.m_sbyInfo[6] := l_Y mod 100;
  m_nTxMsg.m_sbyInfo[7] := l_Y div 100;

  m_nTxMsg.m_sbyInfo[8] := l_hh;
  m_nTxMsg.m_sbyInfo[9] := l_mm;
  m_nTxMsg.m_sbyInfo[10]:= l_ss;;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 12);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
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
procedure CE9CTK310Q2H4MMeter.RES00_SetDateTime_OK(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> ����� �������� �����������: ' + DateTimeToStr(m_QTimestamp));
  FinalAction();
end;

(*******************************************************************************
 *  ������� "������ ������ �������"
 *  0	UCHAR	0x7E	������� ������ ������
 *  1	UCHAR	0x00	������ �������� ������
 *  2	UCHAR	0x0A	������� "������ ������ �������"
 *  3	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ0A_GetSysErrors(var nReq: CQueryPrimitive);   // ������ ������ �������
begin
  m_QFNC       := $0A;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $0A;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;

(*******************************************************************************
 *  ����� �� ������� "������ ������ �������" (������� ������ �� 4-� ������)
 *  0	UCHAR	0x7E	  ������� ������ ������
 *  1	UCHAR	0x06	  ������ ������ ����� ������������� � ������������
 *  2	UCHAR	0x0A	  ����� "������ ������ �������"
 *  3	UINT	Errors	������ �������
 *  5	ULONG	NumErr	����� ������ ��� ����� � ���������� ������
 *  9	UCHAR	CRC8	  ����������� ����� ������ ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES0A_GetSysErrors(var pMsg : CMessage);
begin
  TraceL(3, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> RES0A_GetSysErrors UNREALIZED');
  FinalAction();
end;


(*******************************************************************************
 *  ������� "������ ������� �������� ��������, ���������� � ����"
 *  0	UCHAR	0x7E	������� ������ ������
 *  1	UCHAR	0x00	������ �������� ������
 *  2	UCHAR	0x0D	������� "������ ��������, ���������� � ����"
 *  3	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ0D_GetCurrentPUI(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0D;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $0D;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;

(*******************************************************************************
 *  ����� �� ������� "������ ������� �������� ��������, ���������� � ����"
 *    ("�������-9", 3-����������)
 *  0	    0x7E 	 ���� ������ ������
 *  1	    37     ����� ����� ������ ������
 *  2	    0x0E 	 ��� ������ - PUIF
 *  3..6  AP low..AP high �������� �������� �� ������ (long)
 *   PowerA=AP/14400.0
 *  7..10 RP low..RP high ���������� �������� �� ������ (long)
 *   PowerR=2*RP/(14400.0*sqrt(3))
 *  11..14  U1 low..U1 high ���������� 1 (ulong)
 *   U1=sqrt(U1)/170
 *  15..18  I1 low..I1 high ��� 1 (long)
 *   I1= sqrt(I1)*1.004/(340*DIV)
 *  19..22  U2 low..U2 high ���������� 1 (ulong)
 *   U1=sqrt(U2)/170
 *  23..26  I2 low..I2 high ��� 2 (long)
 *   I2= sqrt(I2)*1.004/(340*DIV)
 *  27..30  U3 low..U3 high ���������� 3 (ulong)
 *   U3=sqrt(U3)/170
 *  31..34  I3 low..I3 high ��� 3 (long)
 *   I3=sqrt(I3)*1.004/(340*DIV)
 *  35	KMNOG;	�������� ��� ����:
 *   DIV=1 ��� KMNOG=0,
 *   DIV=32 ��� KMNOG=1,
 *   DIV=1024 ��� KMNOG=2,
 *  36..37	FREQ	������� ����
 *   Frequency=FREQ/10
 *  38..39	PHI	���� ������ ���
 *   Phi=PHI/10
 *  40	CRC;	����������� ����� ������ ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES0D_GetCurrentPUI(var pMsg : CMessage);
var
  l_dwValue : DWORD;
  l_lValue  : Integer;
  l_wValue  : Word;
  l_SaveValue : Double;
  l_KMNOG   : BYTE;
begin
  l_KMNOG := pMsg.m_sbyInfo[35];

  // 3..6  AP low..AP high �������� �������� �� ������ (long) PowerA=AP/14400.0
  move(pMsg.m_sbyInfo[3], l_lValue, 4);
  l_SaveValue := l_lValue / 14400;
  FillSaveDataMessage(l_SaveValue, QRY_MGAKT_POW_S, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);
    
  // 7..10 RP low..RP high ���������� �������� �� ������ (long) PowerR=2*RP/(14400.0*sqrt(3))
  move(pMsg.m_sbyInfo[7], l_lValue, 4);
  l_SaveValue := 2*l_lValue/(14400*sqrt(3));
  FillSaveDataMessage(l_SaveValue, QRY_MGREA_POW_S, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);
  
  // 11..14  U1 low..U1 high ���������� 1 (ulong) U1=sqrt(U1)/170
  move(pMsg.m_sbyInfo[11], l_dwValue, 4);
  l_SaveValue := sqrt(l_dwValue)/170;
  FillSaveDataMessage(l_SaveValue, QRY_U_PARAM_A, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 15..18  I1 low..I1 high ��� 1 (long) I1= sqrt(I1)*1.004/(340*DIV)
  move(pMsg.m_sbyInfo[15], l_lValue, 4);
  l_SaveValue := sqrt(l_lValue)*1.004/(340*c_DIV[l_KMNOG]);
  FillSaveDataMessage(l_SaveValue, QRY_I_PARAM_A, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 19..22  U2 low..U2 high ���������� 2 (ulong) U2=sqrt(U2)/170
  move(pMsg.m_sbyInfo[19], l_dwValue, 4);
  l_SaveValue := sqrt(l_dwValue)/170;
  FillSaveDataMessage(l_SaveValue, QRY_U_PARAM_B, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 23..26  I2 low..I2 high ��� 2 (long) I2= sqrt(I2)*1.004/(340*DIV)
  move(pMsg.m_sbyInfo[23], l_lValue, 4);
  l_SaveValue := sqrt(l_lValue)*1.004/(340*c_DIV[l_KMNOG]);
  FillSaveDataMessage(l_SaveValue, QRY_I_PARAM_B, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 27..30  U3 low..U3 high ���������� 3 (ulong) U3=sqrt(U3)/170
  move(pMsg.m_sbyInfo[27], l_dwValue, 4);
  l_SaveValue := sqrt(l_dwValue)/170;
  FillSaveDataMessage(l_SaveValue, QRY_U_PARAM_C, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 31..34  I3 low..I3 high ��� 3 (long) I3=sqrt(I3)*1.004/(340*DIV)
  move(pMsg.m_sbyInfo[31], l_lValue, 4);
  l_SaveValue := sqrt(l_lValue)*1.004/(340*c_DIV[l_KMNOG]);
  FillSaveDataMessage(l_SaveValue, QRY_I_PARAM_C, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 36..37	FREQ	������� ���� Frequency=FREQ/10
  move(pMsg.m_sbyInfo[36], l_wValue, 2);
  l_SaveValue := l_wValue/10;
  FillSaveDataMessage(l_SaveValue, QRY_FREQ_NET, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  // 38..39	PHI	���� ������ ��� Phi=PHI/10
  move(pMsg.m_sbyInfo[36], l_wValue, 2);
  l_SaveValue := l_wValue/10;
  FillSaveDataMessage(l_SaveValue, QRY_KOEF_POW_A{S}, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  FinalAction();
end;



(*******************************************************************************
 * ������� "�������� ������� ��������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ �������� ������
 *   2	UCHAR	0x0F	������� "�������� ������� ��������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0F;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $0F;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "�������� ������� ��������"
 *  0	0�7�	���� ������ ������
 *  1	8	����� ����� ������
 *  2	0�0F	������� "�������� ��������"
 *  3..6	APWR (Low)..APWR (High)	�������� �������� (long int) ActivePower = APWR/14400
 *  7..10	RPWR (Low)..RPWR (High)	���������� �������� (long int) ReactivePower = 2*RPWR/(14400*sqrt(3))
 *  11	CRC	����������� ����� ������
 * ������ ������� ��� �������� ������� ������������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES0F_GetCurrentPower(var pMsg:CMessage);
var
    l_Value    : Double;
    l_tValue   : DWORD;
begin
  move(pMsg.m_sbyInfo[3], l_tValue, 4); // ������� DWORD
  l_Value := EndianSwap(l_tValue) * m_nP.m_sfKI * m_nP.m_sfKU / 14400/1000.0; // �������� DWORD -> DOUBLE
  FillSaveDataMessage(l_Value, QRY_MGAKT_POW_S, 0, true);

  move(pMsg.m_sbyInfo[7], l_tValue, 4); // ������� DWORD
  l_Value := 2*EndianSwap(l_tValue)/(14400*sqrt(3)) * m_nP.m_sfKI * m_nP.m_sfKU / 1000.0; // �������� DWORD -> DOUBLE
  FillSaveDataMessage(l_Value, QRY_MGREA_POW_S, 0, true);

  FPUT(BOX_L3, @m_nRxMsg);
  FinalAction();
end;



(*******************************************************************************
 * ������� "�������� ����������"
 *  0	0�7�	���� ������ ������
 *  1	0	    ����� ����� ������
 *  2	0�10	������� "�������� ����������"
 *  3	CRC	  ����������� ����� ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ10_GetCurrentU(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $10;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $10;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "�������� ����������"
 *  0	0�7�	���� ������ ������
 *  1	12	  ����� ����� ������
 *  2	0�10	������� "�������� ����������"
 *  3..6	 U1 (Low..High)	���������� �� ���� � (long int) Voltage1 = 2*Sqrt(U1)/170
 *  7..10	 U2 (Low..High)	���������� �� ���� B (long int) Voltage2 = 2*Sqrt(U2)/170
 *  11..14 U3 (Low..High)	���������� �� ���� C (long int) Voltage3 = 2*Sqrt(U3)/170
 *  15	CRC	����������� ����� ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES10_GetCurrentU(var pMsg:CMessage);
var
    l_Value    : Double;
    l_tValue   : Integer;
begin
  move(pMsg.m_sbyInfo[3], l_tValue, 4);
  l_Value := 2*sqrt(EndianSwap(l_tValue))/170 * m_nP.m_sfKU /1000.0;
  FillSaveDataMessage(l_Value, QRY_U_PARAM_A, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  move(pMsg.m_sbyInfo[7], l_tValue, 4);
  l_Value := 2*sqrt(EndianSwap(l_tValue))/170 * m_nP.m_sfKU /1000.0;
  FillSaveDataMessage(l_Value, QRY_U_PARAM_B, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  move(pMsg.m_sbyInfo[11], l_tValue, 4);
  l_Value := 2*sqrt(EndianSwap(l_tValue))/170 * m_nP.m_sfKU /1000.0;
  FillSaveDataMessage(l_Value, QRY_U_PARAM_C, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  FinalAction();
end;


(*******************************************************************************
 * ������� "�������� ���"
 *  0	0�7�	���� ������ ������
 *  1	0	    ����� ����� ������
 *  2	0�11	������� "�������� ���"
 *  3	CRC	  ����������� ����� ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ11_GetCurrentI(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $11;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $11;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "�������� ���"
 *  0	0�7�	���� ������ ������
 *  1	12	  ����� ����� ������
 *  2	0�11	������� "�������� ���"
 *  3..6	 U1 (Low..High)	��� �� ���� � (long int) Current1 = 2*Sqrt(I1)*1,004/(340*Divider)
 *  7..10	 U2 (Low..High)	��� �� ���� B (long int) Current2 = 2*Sqrt(I2)*1,004/(340*Divider)
 *  11..14 U3 (Low..High)	��� �� ���� C (long int) Current3 = 2*Sqrt(I3)*1,004/(340*Divider)
 *  15	Div	�������� ��� ����
      ���� Div = 0 - �� Divider = 1
      ���� Div = 1 - �� Divider = 32
      ���� Div = 2 - �� Divider = 1024
 *  16	CRC	����������� ����� ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES11_GetCurrentI(var pMsg:CMessage);
var
    l_Value    : Double;
    l_tValue   : Integer;
    l_KMNOG    : BYTE;
begin
  l_KMNOG := pMsg.m_sbyInfo[15];

  move(pMsg.m_sbyInfo[3], l_tValue, 4);
  l_Value := 2*Sqrt(EndianSwap(l_tValue))*1.004/(340*c_Div[l_KMNOG]) * m_nP.m_sfKI /1000.0;
  FillSaveDataMessage(l_Value, QRY_I_PARAM_A, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  move(pMsg.m_sbyInfo[7], l_tValue, 4);
  l_Value := 2*Sqrt(EndianSwap(l_tValue))*1.004/(340*c_Div[l_KMNOG]) * m_nP.m_sfKI /1000.0;
  FillSaveDataMessage(l_Value, QRY_I_PARAM_B, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  move(pMsg.m_sbyInfo[11], l_tValue, 4);
  l_Value := 2*Sqrt(EndianSwap(l_tValue))*1.004/(340*c_Div[l_KMNOG]) * m_nP.m_sfKI /1000.0;
  FillSaveDataMessage(l_Value, QRY_I_PARAM_C, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  FinalAction();
end;


(*******************************************************************************
 * ������� "�������� ��� �������"
 *  0	0�7�	���� ������ ������
 *  1	0	    ����� ����� ������
 *  2	0�12	������� "�������� ��� �������"
 *  3	CRC	  ����������� ����� ������
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ12_GetCurrentE(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $12;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $12;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "�������� ��� �������"
 *  0	0�7�	���� ������ ������
 *  1	28	  ����� ����� ������
 *  2	0�12	������� "�������� ��� �������"
 *  3..9		BCD double �������� "+" ������� � ����-�����
 *  10..16  BCD double �������� "-" ������� � ����-�����
 *  17..23	BCD double ���������� "+" ������� � ����-�����
 *  24..30	BCD double ���������� "-" ������� � ����-�����
 *  16	CRC	����������� ����� ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES12_GetCurrentE(var pMsg:CMessage);
var
    l_Value    : Double;
    l_tValue   : Integer;
begin  
  l_tValue := BCDToInt(pMsg.m_sbyInfo[3], 6);
  l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU / 1000;
  FillSaveDataMessage(l_Value, QRY_ENERGY_SUM_EP, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  l_tValue := BCDToInt(pMsg.m_sbyInfo[10], 6);
  l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU / 1000;
  FillSaveDataMessage(l_Value, QRY_ENERGY_SUM_EM, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  l_tValue := BCDToInt(pMsg.m_sbyInfo[17], 6);
  l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU / 1000;
  FillSaveDataMessage(l_Value, QRY_ENERGY_SUM_RP, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);

  l_tValue := BCDToInt(pMsg.m_sbyInfo[24], 6);
  l_Value := l_tValue * m_nP.m_sfKI * m_nP.m_sfKU / 1000;
  FillSaveDataMessage(l_Value, QRY_ENERGY_SUM_RM, 0, true);
  FPUT(BOX_L3, @m_nRxMsg);
  
  FinalAction();
end;








(*******************************************************************************
 * ��������� \ ���������� \ ������������ ���������� :
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x01	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x0E	������� "��������� \ ���������� \ ������������ ����������"
 *   3	UCHAR		������� ���������� ( �������� ���� �������):
 *              '0'- �������������� ��������� ����������
 *              '1'- �������������� ���������� ����������
 *              'F'- ������������ ����������
 *   4	UCHAR	CRC8	����������� ����� ������ ������
 *   ������ ������� ��� �������� ������� ������������.
 *
 * @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0E;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $01;
  m_nTxMsg.m_sbyInfo[2] := $0E;
  m_nTxMsg.m_sbyInfo[3] := c_RelayState[nReq.m_swSpecc2 AND $03];

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[4] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 5);
  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9CTK3::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "��������� \ ���������� \ ������������ ����������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x00	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x00	����� "�������� ��������� �������"
 *   3	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> �������� � ����������� ��������� �������');
  FinalAction();
end;

(*******************************************************************************
 * ������������� ����� ��� ������ ���������
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x01	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x01	����� "������ �������"
 *   3	UCHAR	0x03	����� "������ ���������"
 *   4	UCHAR	CRC8	����������� ����� ������ ������
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
procedure CE9CTK310Q2H4MMeter.RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9CTK3::> �������� � ����������� �� ���������!');
  FinalAction();
end;


(*******************************************************************************
 * ������������ ������� �� ���������� ��������� ������������ �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.ADD_Energy_Sum_GraphQry(_ParamID : WORD);
begin
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 1, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 2, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 3, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, 0, 4, 0, 1);

  m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;

   
(*******************************************************************************
 * ������������ ������� �� ���������� ��������� ������������ �������
 ******************************************************************************)
procedure CE9CTK310Q2H4MMeter.ADD_RelayState_CTRLQry(_StateID : WORD);
begin
  m_nObserver.ClearCtrlQry();

  m_nObserver.AddCtrlParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddCtrlParam(QRY_RELAY_CTRL, 0, 0, _StateID, 1);
  m_nObserver.AddCtrlParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CE9CTK310Q2H4MMeter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 1, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 2, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 3, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 4, 0, 0, 1);
  
  m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CE9CTK310Q2H4MMeter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
    
  m_nObserver.AddGraphParam(QRY_NULL_COMM, 0, 0, 0, 1);
end;

{*******************************************************************************
 * ������������ ������� �� ���������� ����������� ������
    @param DTS  TDateTime ������ �������
    @param DTE  TDateTime ��������� �������
 ******************************************************************************}
procedure CE9CTK310Q2H4MMeter.ADD_SresEnergyDay_GraphQry(_ParamID : Integer;  _DTS, _DTE : TDateTime);
var
    i, Srez     : Integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    l_Now       : TDateTime;
begin
  m_nObserver.ClearGraphQry();
  l_Now := Now();

  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  DecodeTime(l_Now, h, m, s, ms);
  if (cDateTimeR.CompareDay(_DTE, l_Now) = 1 ) then
    _DTE := l_Now;

       for i := m_LaEnd to m_LaEnd+47 do
       begin
         m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, m_LaEnd + i, 0, 1);
       end;
      m_LaEnd := m_LaEnd +47;
      m_LaEnd := m_LaEnd mod 719;
       exit;
  i := 0;
  
  while cDateTimeR.CompareDay(_DTS, _DTE) <> 1 do
  begin
    DecodeDate(_DTE, y, mn, d);
    if cDateTimeR.CompareDay(_DTE, l_Now) = 0 then
    Begin
       for Srez := (h*60 + m) div 30 - 1 downto 0 do
       begin
         m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, i, 0, 1);
         Inc(i);
       end;
    End else
    Begin
      Srez := 0;
      while Srez <= 47 do
      begin
        m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, 0, i, 0, 1);
        Inc(i);
        Inc(Srez);
      end;
    end;
    cDateTimeR.DecDate(_DTE);
  End;
end;

End.
