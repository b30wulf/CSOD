unit knsl2E9STKVer49Meter;
//{$DEFINE ST49_DEBUG}
interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, knsl5tracer, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox,utlcbox,Math;

type
    // ���������� ����� ��������� ������� �� �������
    // CVToken = packed record
    // ������� ���������� �� ������
    // ���������� ��������� ���� �� �������
    _cntE = packed record
      val : array[0..3] of Double;
				// 1 �� ����� �������
				// 2 �� ����� ���������
				// 3 �� ���� �������
				// 4 �� ���� ���������
    End;
    _poket = packed record
      DATETIME : Cardinal;	// ���� � �����
      CNT : array[0..5] of _cntE;
      CRC : Word;
    End;
    _pointers = packed record
      UKTABONOFF  : Byte;		// ��������� �� ������ � TABONOFF
      CNTTABONOFF : Byte;		// ����� ������� � TABONOFF
      UKLAST      : Word;            	// ��������� �� ������ LAST
      CNTLAST     : Word;		// ����� ������� � LAST
      TARIFNUM    : Byte;		// ����� �������� ������
      UKKTRTAB    : Byte;		// ��������� �� ������ � KTRTAB
      CNTKTRTAB   : Byte;		// ����� ������� � KTRTAB
      UKOPTOTAB   : Byte;		// ��������� �� ������ � OPTOTAB
      CNTOPTOTAB  : Byte;		// ����� ������� � OPTOTAB
      CRC : Word;
    End;
    _pokettot = packed record
      DATETIME : Cardinal;	// ���� � �����
      CNT      : array[0..5] of Double;
      CRC      : WORD;
    End;
    //Current
    _current = packed record
      m_dActA :  Double;
      m_dActB :  Double;
      m_dActC :  Double;
      m_dReaA :  Double;
      m_dReaB :  Double;
      m_dReaC :  Double;
      m_dUa   :  Double;
      m_dUb   :  Double;
      m_dUc   :  Double;
      m_dIa   :  Double;
      m_dIb   :  Double;
      m_dIc   :  Double;
      m_nFrA  :  Word;
      m_nFrB  :  Word;
      m_nFrC  :  Word;
      m_nFiA  :  Word;
      m_nFiB  :  Word;
      m_nFiC  :  Word;
    End;
    // ������ �������� �� ��������� MAXLAST
// PHASE[3] - ����� �� ���� �����
    PHASE = packed record
      PWR : array[0..5] of Single;
    End;
    _lastload = packed record
      DATETIME : Cardinal;
      PHS : array[0..3] of PHASE;
      CRC : WORD;
    End;

    _srez = packed record
      DATETIME : Cardinal;
      Energy : array[0..5] of Double;   // ������� �� 6-�� ����������
      Power : array[0..5] of Double;    // ������������ ������� �������� �� ����� ����������
      CRC : Word;
    End;


    CE9STKVer49Meter = class(CMeter)
    private
        m_QFNC          : BYTE;
        m_QTimestamp    : TDateTime;
        //m_MonthBuf      : array [0..25] of CE9STKMonthStruct;
        //m_SliceBuf      : CE9STKPowerBuf;

        m_progr30Slice  : boolean;
        m_SliceReadSt   : integer;

        pMonthRead      : integer;
        mCurrSlice      : integer;
        mEndSlice       : integer;

        m_ParamID       : BYTE;
        m_Index         : WORD;

        m_LaEnd         : WORD; //

        m_IsAuthorized  : Boolean;
        //IsUpdate        : BYTE;

        m_CODER          : array[0..3] of BYTE;

        nReq            : CQueryPrimitive;
        m_nIndex        : Integer;
        m_pPoint        : _pointers;
        m_bData         : CBox;
        dt_TLD          : TDateTime;
        nOldYear        : Word;
        bl_SaveCrEv     : boolean;
        m_nEnSumm       : array[0..3] of Extended;
        m_dbEnMon       : array[0..3] of Extended;
        m_dbEnMonTek    : array[0..3] of Extended;
        m_dbEnDay       : array[0..3] of Extended;
        m_dbEnDayTek    : array[0..3] of Extended;

         m_dbNakEn       : array[0..8] of Extended;

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
        procedure   ControlRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        function    CMD2ID(_CMDID : BYTE) : BYTE;

        function    CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _Date : TDateTime); overload;
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean); overload;

        procedure   EncodePacket(var _Buffer : array of BYTE);
        function    DecompressPacket(data:PByteArray):Boolean;
        // protocol REQUESTS
        procedure   REQ03_OpenSession(var nReq: CQueryPrimitive);   // ������� ������ � ��������
        procedure   RES04_OpenSession_OK(var pMsg:CMessage);        // ����� �����������
        procedure   RES05_OpenSession_Fail(var pMsg:CMessage);      // ������ ������

        procedure   REQ05_CloseSession(isTimer: boolean);           // ������� ������ (� ��������������)
        procedure   RES05_SessionClosed(var pMsg:CMessage);         // ������ ������

        procedure   FillSTKReq(ID, Index: Integer);
        procedure   CreateSpisSumEnReq(var nReq: CQueryPrimitive);
        procedure   CreateSpisnnNakEnDayReq(var nReq: CQueryPrimitive);
        procedure   CreateSpisnnNakEnMonReq(var nReq: CQueryPrimitive);
        procedure   CreateSumEnergyReq(var nReq: CQueryPrimitive);
        procedure   CreateSumEnReq(var nReq: CQueryPrimitive);
        procedure   ReadMonthEnAns(var pMsg: CMessage);
        procedure   ProcessMonthReq(var nReq: CQueryPrimitive);
        procedure   ProcessDayReq(var nReq: CQueryPrimitive);

        procedure   CreateDayEnAns(var nReq: CQueryPrimitive);
        procedure   CreateNakDayEnAns(var nReq: CQueryPrimitive);
        procedure   Set30Buffer(wShift:Word);

        procedure   CreateMonthEnReq(var nReq: CQueryPrimitive);
        function    IsDateTimeEqual(dt1, dt2 : TDateTime): boolean;
        function    GetULongDate(time: Cardinal): TDateTime;
        function    GetUIntDate(time: word): TDateTime;
        function    GetDTFromSM(sm: integer): TDateTime;
        function    GetNextPointer(nIndex : integer): integer;
        procedure   ProcessSliceReq(var nReq: CQueryPrimitive);
        procedure   CreateSliceReq(var nReq: CQueryPrimitive);

        procedure   REQ06_GetDataByID(var nReq: CQueryPrimitive);   // ������ ������ �� ��������������
        procedure   ReadSpisEnerAns(var pMsg: CMessage);
        procedure   ReadCurrentParam(var pMsg: CMessage);
        procedure   ReadEnDay(var pMsg: CMessage);
        procedure   ReadNakEnDay(var pMsg: CMessage);
        procedure   ReadNakEnMon(var pMsg: CMessage);
        procedure   ReadSumEnergyAns(var pMsg: CMessage);
        procedure   ReadSlicePeriodAns(var pMsg: CMessage);
        procedure   ReadPointSliceAns(var pMsg: CMessage);
        procedure   ReadSliceAns(var pMsg: CMessage);
        procedure   SendSliceToL3(dValue:Double;wType:Word;dtDate:TDateTime);
        procedure   SendSliceToByIndexL3(dValue:Double;wType:Word;nIndex:Integer;dtDate:TDateTime);
        procedure   SetUnknownSlice(wType:Word);
        procedure   SetUnknownSliceByIndex(wType:Word;nIndex:Integer);
        procedure   ReadSlicesPackAns(var pMsg: CMessage);
        procedure   ReadJrnlAns(var pMsg: CMessage);
        procedure   GetDataAnswer(var pMsg: CMessage);
        procedure   RES01_GetDataByID_Fail(var pMsg : CMessage);    // ������

        procedure   REQ07_GetDateTime(var nReq: CQueryPrimitive);   // ������ ����/�������
        procedure   RES07_GetDateTime(var pMsg : CMessage);         // ����� ����/�������
        procedure   KorrTime(LastDate : TDateTime);

        procedure   RES00_SetDateTime_OK(var pMsg : CMessage);      // ����� �������� ��������� ����/�������

        procedure   CreateJrnlEvReq(var nReq: CQueryPrimitive);

        procedure   REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);

        procedure   REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);

        procedure   RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
        procedure   RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);

        // protocol REQUESTS
        procedure   ADD_RelayState_CTRLQry(_StateID : WORD);
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();


        procedure   ADD_Energy_Mon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_Energy_Day_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_Energy_NMon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_Energy_NDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
        function    GetYear(month, day: integer): integer;
        function    IsTrueValue(var dbVal:Double):Boolean;
    End;



    // ������ �������� �� ��������� MAXLAST
    _last = packed record
        DTSMALL : WORD;           // ���� � ����� ( ����������� ������� )
        value   : WORD;           // �������� (�� 15, 30, 45, 60 �����) ������ 1 Wh
        CRC : WORD;
    End;

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
  STSL_STKV116_READ_PERIOD = 0;
  STSL_STKV116_READ_POINT = 1;
  STSL_STKV116_READ_SLICE = 2;

implementation


{*******************************************************************************
 *
 ******************************************************************************}
constructor CE9STKVer49Meter.Create;
Begin
  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> E9STKVer16 Meter Created');
  m_LaEnd := 0;
  //m_bData := CBox.Create(48*30*sizeof(CStk49Srez));
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CE9STKVer49Meter.Destroy;
Begin
    inherited;
    m_bData.Destroy;
End;

procedure CE9STKVer49Meter.RunMeter;
Begin
    m_nAutoTMR.RunTimer;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9STKVer49Meter.InitMeter(var pL2:SL2TAG);
  Var
  Year, Month, Day : Word;  
Begin
  IsUpdate := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;
  m_progr30Slice := false;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
  m_SliceReadSt := STSL_STKV116_READ_POINT;
  if m_bData=Nil then m_bData := CBox.Create(48*30*sizeof(CStk49Srez));

  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>E9CTK    Meter Created:'+
    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
    ' Rep:'+IntToStr(m_byRep)+
    ' Group:'+IntToStr(m_nP.m_sbyGroupID));
End;


function CE9STKVer49Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
    if pMsg.m_sbyType=DL_AUTORIZED_TM_REQ then
    Begin
     REQ05_CloseSession(False);
     m_nIndex := 0;
     m_IsAuthorized := false;
    End;
end;


{*******************************************************************************
 * ���������� ������� ������� ������
 ******************************************************************************}
function CE9STKVer49Meter.LoHandler(var pMsg:CMessage):Boolean;
begin
  Result := true;
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      TraceM(2,pMsg.m_swObjID,'(__)CE9STKVer49::>Inp DRQ:',@pMsg);

      if not IsValidMessage(pMsg) then
      begin
        TraceM(2,pMsg.m_swObjID,'(__)CE9STKVer49::>Error ControlField:',@pMsg);
        Result := false;
        exit;
      end;
      EncodePacket(pMsg.m_sbyInfo);
{
      �������� ���������� ������.
1.	���� ��� 7 ����� �2 �������� ������ ����� 0 - ������ �� ���� �������������;
2.	�������� ��� 7 ����� �2 �������� ������;
3.	��������� ���� ������� (3-� ���� ������� ������);
4.	���� ���� ����� ����� ������� ��������� ����� ����������, ���� ��� ���������� � ��������� ��� ��������� ����� ���;
5.	���������� 1-� ���� �������� ������=������� ������������� ������;
}
      { TODO 5 -oUkrop -cFIXME : ������� ������������ ������ DecompressPacket(pMsg.m_sbyInfo);}
      DecompressPacket(@pMsg.m_sbyInfo[0]);
      if pMsg.m_sbyInfo[2]=1 then RES01_GetDataByID_Fail(pMsg) else
      case ( (m_QFNC shl 8) OR pMsg.m_sbyInfo[2]) of // FUNCTION
        $0304 : RES04_OpenSession_OK(pMsg);
        $0305 : RES05_OpenSession_Fail(pMsg);
        $0505 : RES05_SessionClosed(pMsg);
        $0606 : GetDataAnswer(pMsg);
        $0d0d : GetDataAnswer(pMsg);
        $0601 : RES01_GetDataByID_Fail(pMsg);
        $0707 : RES07_GetDateTime(pMsg);       // DONE 3 -oUkrop -cCHECK : ������ ����/�������
        $0800 : RES00_SetDateTime_OK(pMsg);    // DONE 3 -oUkrop -cCHECK : ��������� ����/�������
        $0E00 : RES00_CTRL_SetRelayState_OK(pMsg);
        $0E01 : RES01_CTRL_SetRelayState_Fail(pMsg);
        else FinalAction();
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
function CE9STKVer49Meter.HiHandler(var pMsg:CMessage):Boolean;
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

        QRY_ENERGY_SUM_EP :
          CreateSpisSumEnReq(nReq);

        QRY_NAK_EN_DAY_EP :
          CreateNakDayEnAns(nReq);   // CreateSpisnnNakEnDayReq(nReq); //

        QRY_NAK_EN_MONTH_EP :
          CreateSpisnnNakEnMonReq(nReq);

        QRY_ENERGY_DAY_EP :
          CreateDayEnAns(nReq);     // ProcessDayReq(nReq); //

        QRY_ENERGY_MON_EP :
          ProcessMonthReq(nReq);

        QRY_SRES_ENR_EP :
          ProcessSliceReq(nReq);

        QRY_DATA_TIME :
          REQ07_GetDateTime(nReq);

        QRY_JRNL_T1,
        QRY_JRNL_T2,
        QRY_JRNL_T3,
        QRY_JRNL_T4 :
          CreateJrnlEvReq(nReq);

        QRY_MGAKT_POW_S :
          REQ0F_GetCurrentPower(nReq);

        QRY_AUTORIZATION :
        begin
          if (m_IsAuthorized=False) then
          Begin
           REQ03_OpenSession(nReq);
           m_IsAuthorized := True;
           m_nAutoTMR.OnTimer(10);
          End
          else
          Begin
           m_nAutoTMR.OnTimer(10);
           FinalAction();
          End;
        end;

        QRY_EXIT_COM :
        begin
          if (m_IsAuthorized) then
          Begin
            REQ05_CloseSession(True);
            m_nAutoTMR.OffTimer;
          End
          else
            FinalAction();
        end;

        QRY_RELAY_CTRL :
          REQ0E_CTRL_SetRelayState(nReq);

        else
          FinalAction();
      end;

      TraceM(2,pMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@pMsg);
//      m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);

    QL_DATA_CTRL_REQ     : ControlRoutine(pMsg);

    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


{*******************************************************************************
 *  ������� ����������� �����
 *      @param var _Buff : array of BYTE
 *      @param _Count : WORD ������ ����� ��������� (� ����������� ������)
 *      @param _SetCRC16 : Boolean
 *      @return Boolean 
 ******************************************************************************}
function  CE9STKVer49Meter.CRC8(var _Buff : array of BYTE; _SetCRC : Boolean) : BYTE;
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
function CE9STKVer49Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
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
        TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer49 ������ CRC! �����!');
        exit;
    end;

  Result := true;
end;


{*******************************************************************************
 *
 ******************************************************************************}
procedure CE9STKVer49Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 11;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_STKVER16;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CE9STKVer49Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _Date : TDateTime);
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
   DecodeDate(_Date, l_Year, l_Month, l_Day);
   DecodeTime(_Date, l_Hour, l_Min, l_Second, l_MS);

   m_nRxMsg.m_sbyInfo[2] := l_Year - 2000;
   m_nRxMsg.m_sbyInfo[3] := l_Month;
   m_nRxMsg.m_sbyInfo[4] := l_Day;
   m_nRxMsg.m_sbyInfo[5] := l_Hour;
   m_nRxMsg.m_sbyInfo[6] := l_Min;
   m_nRxMsg.m_sbyInfo[7] := l_Second;

end;

{*******************************************************************************
 *  ������������ ��������� ���������� ������
 *      @param _Value : double �������� ���������
 *      @param _EType : byte ��� �������
 *      @param _Tariff : byte ������
 *      @param _WriteDate : Boolean ���������� ����� �������
 ******************************************************************************}
procedure CE9STKVer49Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
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
function CE9STKVer49Meter.CMD2ID(_CMDID : BYTE) : BYTE;
Begin
  case _CMDID of
    QRY_ENERGY_SUM_EP : Result := 4;  // Ronly	4	POKET	0�7	����������� ������� �� �������	_poket
    QRY_ENERGY_MON_EP : Result := 4;
    QRY_SRES_ENR_EP   : Result := 11; // Ronly	11	LAST	0�719	������ ��������	_last
    QRY_JRNL_T3       : Result := 16; // Ronly	16	EVENTS	0�4	�������	_events
    QRY_MAX_POWER_EP  : Result := 19; // RW	19	PWMAX	0�7	������������ �������� ��� ������� ������	_pwmax
    QRY_DATA_TIME     : Result := 21; // RW	21	DOPPAR	0	��������� �������	_doppar
//    QRY_MAX_POWER_EM  : Result := 22; // RW	22	PWTMAX	0�8	����� ���������� ������������ ��������	_pwtmax
    else
        Result := 1;
    end;
End;


procedure CE9STKVer49Meter.HandQryRoutine(var pMsg:CMessage);
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

        QRY_NAK_EN_DAY_EP :
          ADD_Energy_NDay_GraphQry(DTS, DTE);

        QRY_NAK_EN_MONTH_EP :
          ADD_Energy_NMon_GraphQry(DTS, DTE);

        QRY_SRES_ENR_EP :
          AddSresEnergGrpahQry( DTS, DTE);

        QRY_ENERGY_DAY_EP :
          ADD_Energy_Day_GraphQry(DTS, DTE);

        QRY_ENERGY_MON_EP :
          ADD_Energy_Mon_GraphQry(DTS, DTE);


        QRY_JRNL_T3 :
          ADD_Events_GraphQry();

        QRY_DATA_TIME :
          ADD_DateTime_Qry();
    end;
end;


procedure CE9STKVer49Meter.ControlRoutine(var pMsg:CMessage);
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


procedure CE9STKVer49Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    //REQ05_CloseSession(false);
    pMonthRead := 255;
    m_SliceReadSt := STSL_STKV116_READ_POINT;
    //m_IsAuthorized := false;
    OnFinalAction();
    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CE9STKVer49 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CE9STKVer49Meter.OnEnterAction;
begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer49 OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CE9STKVer49Meter.OnConnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer49 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CE9STKVer49Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer49 OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CE9STKVer49Meter.OnFinalAction;
begin

    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CE9STKVer49 OnFinalAction');
    FinalAction;
end;

procedure   CE9STKVer49Meter.EncodePacket(var _Buffer : array of BYTE);
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
//{
// ��������� ���������� ������ ������ �� ��������
// ���������:
//     result - ��������� �� �����, � ������� ����� ������� ������������� �����
//     data   - ��������� �� �����, ���������� ����������� �����;
//              ������ ��������� �� ���� �� ��������� 2 � ������ �������� (��� �������)
//     size   - ������ ����� ������ ������������ ������; 
//              � ��� �� ������������ ������ �������������� ������

//bool DeCompress (char * result, char * data, int &size)
//{
//    if(!(*data & 0x80))
//    {
//        memcpy(result, data, size);
//        return true;
//    }
//
//    char *src = data;
//    char *dst = result;
//    *dst++ = *src++ & 0x7F;
//    int cnt = size - 1;
//    int sz = 1;
//    char sgn = *src++;
//    --cnt;
//
//    while(cnt)
//    {
//        if(*src != sgn)
//        {
//            *dst++ = *src++;
//            --cnt;
//            ++sz;
//        }
//       else
//      {
//          ++src;
//          int num = (unsigned char)*src++;
//          char val = *src++;
//          memset(dst, val, num);
//          cnt -= 3;
//          dst += num;
//          sz += num;
//      }
//  }
//  size = sz;
//  return true;
//
//
function CE9STKVer49Meter.DecompressPacket(data:PByteArray):Boolean;
var
    cnt,sz,size,i,j,num : Integer;
    src : PByteArray;
    sgn,val : Byte;
    dst : array[0..255] of Byte;
begin
    i:=0;j:=0;
    if(data[2] and $80)=0 then
    Begin
     //move(data,pOut,size);
     result := true;
     exit;
    End;
    size:= data[1];
    src := @data[2];         //char *src = data;
    dst[i] := src[j] and $7f;Inc(i);Inc(j); //    *dst++ = *src++ & 0x7F;
    cnt := size - 1;     //int cnt = size - 1;
    sz  := 1;            //int sz = 1;
    sgn := src[j];Inc(j);//char sgn = *src++;
    Dec(cnt);            //--cnt;
    while(cnt>0) do
    Begin
      if i>255 then
      Begin
        result := False;
        exit;
      End;
     if(src[j] <> sgn) then
     Begin
      dst[i] := src[j];Inc(i);Inc(j);// *dst++ = *src++;
      Dec(cnt);//--cnt;
      Inc(sz);//++sz;
     End else
     Begin
      Inc(j);                 //++src;
      num := src[j];Inc(j);   //int num = (unsigned char)*src++;
      val := src[j];Inc(j);   //char val = *src++;
      FillChar(dst[i], val, num);//memset(dst, val, num);
      cnt    := cnt - 3;         //cnt -= 3;
      //dst[i] := dst[i] + num;       //dst += num;
      i := i + num;
      sz     := sz  + num;       //sz += num;
     End;
   End;
   size := sz;
   data[1] := sz;
   data[2] := dst[0];
   if sz>255 then
   Begin
    result := False;exit;
   end;
   for i:=0 to sz-1 do
   data[i+3] := dst[i+1];
   result := true;
end;

(*******************************************************************************
 * ������� "������� ������ � ��������"
 *   0	  UCHAR	0x7E	������� ������ ������
 *   1	  UCHAR	0x08	������ �������� ������
 *   2	  UCHAR	0x03	������� "������� ������ � ��������"
 *   3	  ULONG	ZNUMBER	��������� ����� �������� (������� ���� �� �������� ������)
 *   7	  ULONG	IDENT	������������� �������� (������� ���� �� �������� ������)
 *   11	UCHAR	CRC8	����������� ����� ������ ������
 *
 *   @param var nReq: CQueryPrimitive �������� �������
 ******************************************************************************)
procedure CE9STKVer49Meter.REQ03_OpenSession(var nReq: CQueryPrimitive);
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

  l_Ident := StrToInt(m_nP.m_sddPHAddres); // ������������� �������� (������� ���� �� �������� ������)
  m_nTxMsg.m_sbyInfo[7] := (l_Ident AND $FF000000) shr 24;
  m_nTxMsg.m_sbyInfo[8] := (l_Ident AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[9] := (l_Ident AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[10]:= (l_Ident AND $000000FF);

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);
  FillMessageHead(m_nTxMsg, 12);

  FPUT(BOX_L1, @m_nTxMsg);
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "������� ������ � ��������" (������� ������ �� 4-� ������)
 * ����� ������ ������ � ������ ���������� ���������� ������ � ��������������
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x05	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x04	����� "����� �����������"
 *   3	UCHAR	0x01	������ ��������
 *   4	UCHAR	RND0	�������� ��� ������������� CODER[0]
 *   5	UCHAR	RND1	�������� ��� ������������� CODER[1]
 *   6	UCHAR	RND2	�������� ��� ������������� CODER[2]
 *   7	UCHAR	RND3	�������� ��� ������������� CODER[3]
 *   8	UCHAR	SysError	������ �������
 *   9	UCHAR	Tarifnum	����� �������� ������
 *   10	UCHAR	FLAGS	����� *
 *   11	UCHAR	CRC8	����������� ����� ������ ������
 * � ��������� ������ ���� FLAGS ����� �������������
 *
 *   ��� ����� 3 �������� ������� ������ � �������� ���������������, �������
 * ����������� �� ����� ��� �� 2-�� ����� � ������ ��������� - ������ ������ -
 * � ������������� �� �������� �������������� ��� ������� �������
 *
 *      @param var pMsg:CMessage
 ******************************************************************************)
procedure CE9STKVer49Meter.RES04_OpenSession_OK(var pMsg:CMessage);
begin
  m_IsAuthorized := true;

  m_CODER[0] := pMsg.m_sbyInfo[4];
  m_CODER[1] := pMsg.m_sbyInfo[5];
  m_CODER[2] := pMsg.m_sbyInfo[6];
  m_CODER[3] := pMsg.m_sbyInfo[7];

  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::> ������ �������. ������ �������: ' + IntToStr(pMsg.m_sbyInfo[8]) );
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
procedure CE9STKVer49Meter.RES05_OpenSession_Fail(var pMsg:CMessage);
begin
  m_IsAuthorized := false;
  TraceL (2, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::> ������: ������ ������!');
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
procedure CE9STKVer49Meter.REQ05_CloseSession(isTimer: boolean);
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
  if isTimer=True then
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer49Meter.RES05_SessionClosed(var pMsg:CMessage);
begin
  m_IsAuthorized := false;

  ZeroMemory(@m_CODER, 4);
  TraceL (3, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::> ������ ������!');
  FinalAction();
end;

procedure CE9STKVer49Meter.FillSTKReq(ID, Index: Integer);
begin
   m_QFNC       := $06;
   m_nTxMsg.m_sbyInfo[0] := $7E;
   m_nTxMsg.m_sbyInfo[1] := $03;
   m_nTxMsg.m_sbyInfo[2] := $06;
   m_nTxMsg.m_sbyInfo[3] := ID;
   m_nTxMsg.m_sbyInfo[4] := (Index shr 8) AND $00FF;
   m_nTxMsg.m_sbyInfo[5] := Index AND $00FF;
   EncodePacket(m_nTxMsg.m_sbyInfo);
   m_nTxMsg.m_sbyInfo[6] := CRC8(m_nTxMsg.m_sbyInfo, true);

   FillMessageHead(m_nTxMsg, 7);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
   TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out CMD:',@m_nTxMsg);
end;

procedure CE9STKVer49Meter.CreateSpisSumEnReq(var nReq: CQueryPrimitive);
begin
   m_nIndex := 0;
   m_ParamID := QRY_ENERGY_SUM_EP;
   FillSTKReq(5, 0);
end;

procedure CE9STKVer49Meter.CreateSpisnnNakEnDayReq(var nReq: CQueryPrimitive);
begin
   m_ParamID := QRY_NAK_EN_DAY_EP;
   FillSTKReq(4, 0);
end;

procedure CE9STKVer49Meter.CreateSpisnnNakEnMonReq(var nReq: CQueryPrimitive);
begin
    nReq.m_swParamID := QRY_NAK_EN_MONTH_EP;
    m_ParamID := QRY_NAK_EN_MONTH_EP;
    FillSTKReq(4,0);
    //FillSTKReq(4,nReq.m_swSpecc0);
    TraceL(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>������ ��� ��� �� ������: ' + IntToStr(nReq.m_swSpecc0));
end;

procedure CE9STKVer49Meter.CreateSumEnergyReq(var nReq: CQueryPrimitive);
begin
   FillSTKReq(12, 0);
end;

procedure CE9STKVer49Meter.CreateSumEnReq(var nReq: CQueryPrimitive);
begin
   m_nTxMsg.m_sbyInfo[0] := $7E;
   m_nTxMsg.m_sbyInfo[1] := $00;
   m_nTxMsg.m_sbyInfo[2] := $12;
   m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);
   FillMessageHead(m_nTxMsg, 7);
   FPUT(BOX_L1, @m_nTxMsg);
   m_nRepTimer.OnTimer(m_nP.m_swRepTime);
end;


{
poket = packed record
      DATETIME : Cardinal;	// ���� � �����
      CNT : array[0..5] of _cntE;
      CRC : Word;
    End;
}
procedure CE9STKVer49Meter.ReadMonthEnAns(var pMsg: CMessage);
var tempDate   : TDateTime;
    item, i,j  : integer;
    value      : double;
    pVal       : _poket;
    Year1,Month1,Day1 : Word;
    nValue,nlValue    : Extended;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_poket));
   for i:=0 to 5 do
   for j:=0 to 3 do
   IsTrueValue(pVal.CNT[i].val[j]);
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisMON:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[1],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[1],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[1],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4));
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisDAY:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[3],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[3],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[3],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[3],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4));
   }
   m_dbEnMonTek[0] := pVal.CNT[0].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMonTek[1] := pVal.CNT[1].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMonTek[2] := pVal.CNT[3].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMonTek[3] := pVal.CNT[5].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[0] := pVal.CNT[0].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[1] := pVal.CNT[1].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[2] := pVal.CNT[3].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[3] := pVal.CNT[5].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   DecodeDate(Now,Year1,Month1,Day1);
   tempDate := EncodeDate(Year1,Month1,1);
   cDateTimeR.DecMonthEx(nReq.m_swSpecc0,tempDate);
   for j:=0 to 4 do
   for i:=0 to 3 do
   Begin
    nValue := m_dbEnMonTek[i];
    nlValue:= m_dbEnMon[i];
    if j<>1 then Begin nValue := 0;nlValue := 0;End;
    if nReq.m_swSpecc0=0 then
     FillSaveDataMessage(nlValue , QRY_ENERGY_MON_EP+i, j, tempDate);
    //if nReq.m_swSpecc0=1 then FillSaveDataMessage(nlValue, QRY_ENERGY_MON_EP+i, j, tempDate);
    FPUT(BOX_L3, @m_nRxMsg);
   End;
   FinalAction;
end;



procedure CE9STKVer49Meter.ProcessMonthReq(var nReq: CQueryPrimitive);
var tempDate : TDateTime;
    item, i  : integer;
    value    : double;
begin
   nReq.m_swParamID := QRY_ENERGY_MON_EP;
   m_ParamID := QRY_ENERGY_MON_EP;
   FillSTKReq(4,0);
   TraceL(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>������ �������� ������� �� ������: ' + IntToStr(nReq.m_swSpecc0));
end;
procedure CE9STKVer49Meter.ProcessDayReq(var nReq: CQueryPrimitive);
var tempDate : TDateTime;
    item, i  : integer;
    value    : double;
begin
   nReq.m_swParamID := QRY_ENERGY_DAY_EP;
   m_ParamID := QRY_ENERGY_DAY_EP;
   FillSTKReq(4,0);
   TraceL(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>������ ������� ������� �� ������: ' + IntToStr(nReq.m_swSpecc0));
end;


procedure CE9STKVer49Meter.CreateNakDayEnAns(var nReq: CQueryPrimitive);
var
    pData : CStk49Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,j,nINdex :Integer;
    dbSum,dbSum30,dbEnergyPok: array[0..3] of Double;

    Year,Month,Day:Word;
begin
    m_ParamID := QRY_NAK_EN_DAY_EP;
    //for i:=0 to 3 do dbSum[i]:=0;
    //FillChar(m_dbNakEn,8,0);
    //for i:=0 to 3 do
    //Begin
    // {$IFDEF ST49_DEBUG}
    // m_dbNakEn[i]:=10000*i;
    // {$ENDIF}
    // dbSum[i]:=m_dbNakEn[i];
    //End;

   for i:=0 to 3 do dbSum30[i] := 0;

   for i:=0 to nReq.m_swSpecc0 do
   Begin
    dtDate01 := trunc(Now)-i;
    if m_bData.FGetSum49(dtDate01,pData)=true then
    Begin
     for j:=0 to 3 do
     dbSum30[j] := dbSum30[j] + pData.dbEnergy[j];
    End;
   End;

   for i:=0 to 3 do
   Begin
    dbEnergyPok[i] := m_dbNakEn[i]-dbSum30[i]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
    TraceL(3, m_nTxMsg.m_swObjID,'Type En:'+IntToStr(i)+' DT :'+ DateTimeToStr(dtDate01)+' Sum: '+FloatToStr(dbEnergyPok[i]));
    FillSaveDataMessage(0             , QRY_NAK_EN_DAY_EP+i, 0, dtDate01);FPUT(BOX_L3, @m_nRxMsg);
    FillSaveDataMessage(dbEnergyPok[i], QRY_NAK_EN_DAY_EP+i, 1, dtDate01);FPUT(BOX_L3, @m_nRxMsg);
    FillSaveDataMessage(0             , QRY_NAK_EN_DAY_EP+i, 2, dtDate01);FPUT(BOX_L3, @m_nRxMsg);
    FillSaveDataMessage(0             , QRY_NAK_EN_DAY_EP+i, 3, dtDate01);FPUT(BOX_L3, @m_nRxMsg);
   End;
   OnFinalAction();
End;


procedure CE9STKVer49Meter.CreateDayEnAns(var nReq: CQueryPrimitive);
var
    pData : CStk49Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,nINdex :Integer;
    Year,Month,Day:Word;
begin
   m_ParamID := QRY_ENERGY_DAY_EP;
   nReq.m_swSpecc0 := nReq.m_swSpecc0 + 1;
   dtDate01 := trunc(Now)-nReq.m_swSpecc0;
   if m_bData.FGetSum49(dtDate01,pData)=true then
   Begin
    for i:=0 to 3 do
    Begin
     pData.dbEnergy[i] := pData.dbEnergy[i]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
     TraceL(3, m_nTxMsg.m_swObjID,'Type En:'+IntToStr(i)+' DT :'+ DateTimeToStr(dtDate01+1)+' Sum: '+FloatToStr(pData.dbEnergy[i]));
     FillSaveDataMessage(0                , QRY_ENERGY_DAY_EP+i, 0, dtDate01+1);  FPUT(BOX_L3, @m_nRxMsg);
     FillSaveDataMessage(pData.dbEnergy[i], QRY_ENERGY_DAY_EP+i, 1, dtDate01+1);  FPUT(BOX_L3, @m_nRxMsg);
     FillSaveDataMessage(0                , QRY_ENERGY_DAY_EP+i, 2, dtDate01+1);  FPUT(BOX_L3, @m_nRxMsg);
     FillSaveDataMessage(0                , QRY_ENERGY_DAY_EP+i, 3, dtDate01+1);  FPUT(BOX_L3, @m_nRxMsg);
    End;
   End;
   OnFinalAction();
End;


procedure CE9STKVer49Meter.Set30Buffer(wShift:Word);
Var
    pData : CStk43Srez;
    dtDate,dtDate00,dtDate01 : TDateTime;
    i,j,nINdex :Integer;
Begin
   //m_bData.FFREE();
   j := wShift;
   //for j:=0 to wShift do
  // Begin
   if (j=0) then
    begin
    nINdex   := trunc(frac(Now)/EncodeTime(0,30,0,0));
    dtDate00 := trunc(Now);
    pData.szSize   := Sizeof(CStk43Srez);
     for i:=0 to nINdex+1 do
       Begin
       pData.DATETIME := dtDate00;
       pData.dbEnergy := 5;
       TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(i)+')CE9STKVer18::>VDAY:'+' DT :'+ DateTimeToStr(pData.DATETIME)+' Val: '+FloatToStr(pData.dbEnergy));
       m_bData.FPUTStk43(pData);
       dtDate00 := dtDate00 + EncodeTime(0,30,0,0);
       End;
    End
   Else
    begin
    dtDate00 := trunc(Now)-j;
    pData.szSize   := Sizeof(CStk43Srez);
     for i:=0 to 47 do
       Begin
       pData.DATETIME := dtDate00;
       pData.dbEnergy := j*5;
       //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(i)+')CE9STKVer18::>VDAY:'+' DT :'+ DateTimeToStr(pData.DATETIME)+' Val: '+FloatToStr(pData.dbEnergy));
       m_bData.FPUTStk43(pData);
       dtDate00 := dtDate00 + EncodeTime(0,30,0,0);
       End;
   End;
  //End;
End;

procedure CE9STKVer49Meter.CreateMonthEnReq(var nReq: CQueryPrimitive);
begin
  nReq.m_swParamID := QRY_ENERGY_MON_EP;
  m_ParamID := QRY_ENERGY_MON_EP;
  FillSTKReq(24, lo(pMonthRead));
  TraceL(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>������ �������� ������� �� ������: ' + IntToStr(nReq.m_swSpecc0));
end;


{
-1 ������ (x1 < x2)
0  �����  (x1 = x2)
1  ������ (x1 > x2)
}

function CE9STKVer49Meter.IsDateTimeEqual(dt1, dt2 : TDateTime): boolean;
var y1, m1, d1, h1, n1, s1, ms1,
    y2, m2, d2, h2, n2, s2, ms2 : word;
begin
   DecodeDate(dt1, y1, m1, d1);
   DecodeTime(dt1, h1, n1, s1, ms1);
   DecodeDate(dt2, y2, m2, d2);
   DecodeTime(dt2, h2, n2, s2, ms2);
   if (y1 = y2) and (m1 = m2) and (d1 = d2) and
        (h1 = h2) and (n1 = n2) and (ms1 = ms2) then
     Result := true
   else
     Result := false;
end;

function CE9STKVer49Meter.GetULongDate(time: Cardinal): TDateTime;
var yy, mm, dd, hh, nn, ss : word;
begin
   ss := (time and $13) * 2;
   nn := (time and $7E0) shr 5;
   hh := (time and $F800) shr 11;
   dd := (time and $1F0000) shr 16;
   mm := (time and $1E00000) shr 21;
   yy := (time and $FE000000) shr 25;

   try
     if (yy=0)or(mm=0)or(mm>12)or(dd=0)or(dd>31)or
        (hh>23)or(nn>59)or(ss>59) then
     //if (yy=0)or(mm=0)or(dd=0) then
       Result := 0
     else
       Result := EncodeDate(2000 + yy, mm, dd) +
            EncodeTime(hh, nn, ss, 0);
   except
     Result := 0;
   end;
end;

function CE9STKVer49Meter.GetUIntDate(time: word): TDateTime;
var yy, mm, dd, hh, nn, ss : word;
begin
   ss := 00;
   nn := (time and $03) * 15;
   hh := (time and $7C) shr 2;
   dd := (time and $F80) shr 7;
   mm := (time and $F000) shr 12;
   yy := GetYear(mm, dd);
   try
      if (yy = 0) or (mm = 0) or (dd = 0) or (hh>23) or (nn>59) or (ss>59) then
       Result := 0
     else
       Result := EncodeDate(yy, mm, dd) +
            EncodeTime(hh, nn, ss, 0);
   except
     Result := 0;
   end;
end;

function CE9STKVer49Meter.GetDTFromSM(sm: integer): TDateTime;
var tempDate,tmDate, _30Min: TDateTime;
    yy,mm,dd,hh,mi,ss,ms:Word;
begin
   DecodeDate(Now,yy,mm,dd);
   DecodeTime(Now,hh,mi,ss,ms);
   if mi<30  then mi:=0 else
   if mi>=30 then mi:=30;
   ss := 0; ms := 0;
   tempDate := EncodeDate(yy,mm,dd)+EncodeTime(hh,mi,ss,ms);
   Result   := tempDate - (sm - 1)*EncodeTime(0,30,0,0);
end;


procedure CE9STKVer49Meter.ProcessSliceReq(var nReq: CQueryPrimitive);
begin
   CreateSliceReq(nReq);
end;
function  CE9STKVer49Meter.GetNextPointer(nIndex : integer): integer;
Begin
   if (m_pPoint.UKLAST-nIndex)>=0 then Result := m_pPoint.UKLAST-nIndex;
   if (m_pPoint.UKLAST-nIndex)<0  then Result := 17519+(m_pPoint.UKLAST-nIndex);
End;

procedure CE9STKVer49Meter.CreateSliceReq(var nReq: CQueryPrimitive);
Var
   pData : CStk49Srez;
   dtDate : TDateTime;
begin
   m_ParamID := QRY_SRES_ENR_EP;
   case m_SliceReadSt of
     STSL_STKV116_READ_POINT  : FillSTKReq(11, 0);
     STSL_STKV116_READ_SLICE  : begin
                                 //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')FindL3');
                                 //if nReq.m_swSpecc0=1 then
                                 //dtDate := GetDTFromSM(nReq.m_swSpecc0);
                                 dtDate := GetDTFromSM(nReq.m_swSpecc0);
                                 if m_bData.FINDStk49(dtDate,pData)=True then
                                 Begin
                                  //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Find: DATE L3:'+DateTimeToStr(dtDate)+' VAL:'+FloatToStr(pData.dbEnergy[0]));
                                  SendSliceToByIndexL3(pData.dbEnergy[0],QRY_SRES_ENR_EP,nReq.m_swSpecc2,pData.DATETIME);
                                  SendSliceToByIndexL3(pData.dbEnergy[1],QRY_SRES_ENR_EM,nReq.m_swSpecc2,pData.DATETIME);
                                  SendSliceToByIndexL3(pData.dbEnergy[2],QRY_SRES_ENR_RP,nReq.m_swSpecc2,pData.DATETIME);
                                  SendSliceToByIndexL3(pData.dbEnergy[3],QRY_SRES_ENR_RM,nReq.m_swSpecc2,pData.DATETIME);
                                  FinalAction;
                                  exit;
                                 End;
                                 FillSTKReq(14, GetNextPointer(nReq.m_swSpecc0));
                                end;
   end;
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
procedure CE9STKVer49Meter.REQ06_GetDataByID(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
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
                            { DONE 5 -oUkrop -cERROR : ����������� ������ }

procedure CE9STKVer49Meter.ReadSumEnergyAns(var pMsg: CMessage);
var val_ul : Cardinal;
    val_ui : WORD;
begin
   move(pMsg.m_sbyInfo[3], val_ul, 4);
   move(pMsg.m_sbyInfo[7], val_ui, 2);
   FillSaveDataMessage(val_ul + val_ui * m_nP.m_sfMeterKoeff, QRY_ENERGY_SUM_EP, 0, Now);
   FPUT(BOX_L3, @m_nRxMsg);
   FinalAction;
end;

{
 _pokettot = packed record
      DATETIME : Cardinal;	// ���� � �����
      CNT      : array[0..5] of Double;
      CRC      : WORD;
    End;
}
procedure CE9STKVer49Meter.ReadSpisEnerAns(var pMsg: CMessage);
var val_ul,val_tek : Cardinal;
    pVal : _pokettot;
    i,j:integer;
    nValue : Extended;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_pokettot));
   for i:=0 to 5 do
   IsTrueValue(pVal.CNT[i]);
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpis:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5],ffFixed,6,4));
   }
   m_nEnSumm[0] := pVal.CNT[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_nEnSumm[1] := pVal.CNT[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_nEnSumm[2] := pVal.CNT[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_nEnSumm[3] := pVal.CNT[5]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;

   for i:=0 to 8 do m_dbNakEn[i] := 0;
   for i:=0 to 3 do
   m_dbNakEn[i] := m_nEnSumm[i];

   for j:=0 to 4 do
   for i:=0 to 3 do
   Begin
    nValue := m_nEnSumm[i];
    if j<>1 then nValue:=0;
    FillSaveDataMessage(nValue, QRY_ENERGY_SUM_EP+i, j, Now);
    FPUT(BOX_L3, @m_nRxMsg);
   End;
   FinalAction;
end;
{
    _current = packed record
      m_dActA :  Double;
      m_dActB :  Double;
      m_dActC :  Double;
      m_dReaA :  Double;
      m_dReaB :  Double;
      m_dReaC :  Double;
      m_dUa   :  Double;
      m_dUb   :  Double;
      m_dUc   :  Double;
      m_dIa   :  Double;
      m_dIb   :  Double;
      m_dIc   :  Double;
      m_nFrA  :  Word;
      m_nFrB  :  Word;
      m_nFrC  :  Word;
      m_nFiA  :  Word;
      m_nFiB  :  Word;
      m_nFiC  :  Word;
    End;

}
procedure CE9STKVer49Meter.ReadCurrentParam(var pMsg: CMessage);
var
    pVal : _current;
begin

   move(pMsg.m_sbyInfo[3], pVal, sizeof(_current));
   IsTrueValue(pVal.m_dActA);
   IsTrueValue(pVal.m_dActB);
   IsTrueValue(pVal.m_dActC);

   IsTrueValue(pVal.m_dReaA);
   IsTrueValue(pVal.m_dReaB);
   IsTrueValue(pVal.m_dReaC);

   IsTrueValue(pVal.m_dUa);
   IsTrueValue(pVal.m_dUb);
   IsTrueValue(pVal.m_dUc);

   IsTrueValue(pVal.m_dIa);
   IsTrueValue(pVal.m_dIb);
   IsTrueValue(pVal.m_dIc);

   pVal.m_dActA := pVal.m_dActA*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   pVal.m_dActB := pVal.m_dActB*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   pVal.m_dActC := pVal.m_dActC*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   pVal.m_dReaA := pVal.m_dReaA*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   pVal.m_dReaB := pVal.m_dReaB*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   pVal.m_dReaC := pVal.m_dReaC*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;

   pVal.m_dUa   := pVal.m_dUa*m_nP.m_sfKU;
   pVal.m_dUb   := pVal.m_dUb*m_nP.m_sfKU;
   pVal.m_dUc   := pVal.m_dUc*m_nP.m_sfKU;

   pVal.m_dIa   := pVal.m_dIa*m_nP.m_sfKI;
   pVal.m_dIb   := pVal.m_dIb*m_nP.m_sfKI;
   pVal.m_dIc   := pVal.m_dIc*m_nP.m_sfKI;

   FillSaveDataMessage(pVal.m_dActA, QRY_MGAKT_POW_A, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dActB, QRY_MGAKT_POW_B, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dActC, QRY_MGAKT_POW_C, 0, Now);FPUT(BOX_L3, @m_nRxMsg);

   FillSaveDataMessage(pVal.m_dReaA, QRY_MGREA_POW_A, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dReaB, QRY_MGREA_POW_B, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dReaC, QRY_MGREA_POW_C, 0, Now);FPUT(BOX_L3, @m_nRxMsg);

   FillSaveDataMessage(pVal.m_dUa, QRY_U_PARAM_A, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dUb, QRY_U_PARAM_B, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dUc, QRY_U_PARAM_C, 0, Now);FPUT(BOX_L3, @m_nRxMsg);

   FillSaveDataMessage(pVal.m_dIa, QRY_I_PARAM_A, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dIb, QRY_I_PARAM_B, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.m_dIc, QRY_I_PARAM_C, 0, Now);FPUT(BOX_L3, @m_nRxMsg);

   FillSaveDataMessage(pVal.m_nFrA/100, QRY_FREQ_NET, 0, Now);FPUT(BOX_L3, @m_nRxMsg);

   FillSaveDataMessage(cos(pVal.m_nFiA*3.14159265358/180), QRY_KOEF_POW_A, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(cos(pVal.m_nFiB*3.14159265358/180), QRY_KOEF_POW_B, 0, Now);FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(cos(pVal.m_nFiC*3.14159265358/180), QRY_KOEF_POW_C, 0, Now);FPUT(BOX_L3, @m_nRxMsg);

   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VCurrPR:'+
   ' PA:' + FloatTostrF(pVal.m_dActA,ffFixed,6,3)+
   ' PB:' + FloatTostrF(pVal.m_dActB,ffFixed,6,3)+
   ' PC:' + FloatTostrF(pVal.m_dActC,ffFixed,6,3)+
   ' RA:' + FloatTostrF(pVal.m_dReaA,ffFixed,6,3)+
   ' RB:' + FloatTostrF(pVal.m_dReaB,ffFixed,6,3)+
   ' RC:' + FloatTostrF(pVal.m_dReaC,ffFixed,6,3));
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VCurrUIF:'+
   ' Ua:' + FloatTostrF(pVal.m_dUa,ffFixed,6,3)+
   ' Ub:' + FloatTostrF(pVal.m_dUb,ffFixed,6,3)+
   ' Uc:' + FloatTostrF(pVal.m_dUc,ffFixed,6,3)+
   ' Ia:' + FloatTostrF(pVal.m_dIa,ffFixed,6,3)+
   ' Ib:' + FloatTostrF(pVal.m_dIb,ffFixed,6,3)+
   ' Ic:' + FloatTostrF(pVal.m_dIc,ffFixed,6,3)+
   ' Fa:' + FloatTostrF(pVal.m_nFrA/100,ffFixed,6,3)+
   ' Fb:' + FloatTostrF(pVal.m_nFrB/100,ffFixed,6,3)+
   ' Fc:' + FloatTostrF(pVal.m_nFrC/100,ffFixed,6,3)+
   ' Fia:' + IntToStr(pVal.m_nFiA)+
   ' Fib:' + IntToStr(pVal.m_nFiB)+
   ' Fic:' + IntToStr(pVal.m_nFiC));
   }
   {
   FillSaveDataMessage(pVal.CNT[0]*m_nP.m_sfKI*m_nP.m_sfKU / 1000, QRY_ENERGY_SUM_EP, 0, GetULongDate(pVal.DATETIME));
   FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.CNT[1]*m_nP.m_sfKI*m_nP.m_sfKU / 1000, QRY_ENERGY_SUM_EM, 0, GetULongDate(pVal.DATETIME));
   FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.CNT[3]*m_nP.m_sfKI*m_nP.m_sfKU / 1000, QRY_ENERGY_SUM_RP, 0, GetULongDate(pVal.DATETIME));
   FPUT(BOX_L3, @m_nRxMsg);
   FillSaveDataMessage(pVal.CNT[5]*m_nP.m_sfKI*m_nP.m_sfKU / 1000, QRY_ENERGY_SUM_RM, 0, GetULongDate(pVal.DATETIME));
   FPUT(BOX_L3, @m_nRxMsg);
   }
   FinalAction;
end;

procedure  CE9STKVer49Meter.ReadNakEnDay(var pMsg: CMessage);
var tempDate   : TDateTime;
    item, i,j  : integer;
    value      : double;
    pVal       : _poket;
    Year1,Month1,Day1 : Word;
    nValue,nlValue    : Extended;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_poket));
   for i:=0 to 5 do
   for j:=0 to 3 do
   IsTrueValue(pVal.CNT[i].val[j]);
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisMON:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[1],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[1],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[1],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4));
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisDAY:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[3],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[3],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[3],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[3],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4));
   }
   m_dbEnDayTek[0] := pVal.CNT[0].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDayTek[1] := pVal.CNT[1].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDayTek[2] := pVal.CNT[3].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDayTek[3] := pVal.CNT[5].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[0] := pVal.CNT[0].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[1] := pVal.CNT[1].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[2] := pVal.CNT[3].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[3] := pVal.CNT[5].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   tempDate := trunc(Now);
   tempDate := tempDate - nReq.m_swSpecc0;
   for j:=0 to 4 do
   for i:=0 to 3 do
   Begin
    nValue := m_nEnSumm[i]-m_dbEnDayTek[i];
    nlValue:= m_nEnSumm[i]-m_dbEnDay[i]-m_dbEnDayTek[i];
    if j<>1 then Begin nValue := 0;nlValue := 0;End;
    if nReq.m_swSpecc0=0 then FillSaveDataMessage(nValue , QRY_NAK_EN_DAY_EP+i, j, tempDate);
    if nReq.m_swSpecc0=1 then FillSaveDataMessage(nlValue, QRY_NAK_EN_DAY_EP+i, j, tempDate);
    FPUT(BOX_L3, @m_nRxMsg);
   End;
   FinalAction;
end;
procedure  CE9STKVer49Meter.ReadEnDay(var pMsg: CMessage);
var tempDate   : TDateTime;
    item, i,j  : integer;
    value      : double;
    pVal       : _poket;
    Year1,Month1,Day1 : Word;
    nValue,nlValue    : Extended;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_poket));
   for i:=0 to 5 do
   for j:=0 to 3 do
   IsTrueValue(pVal.CNT[i].val[j]);
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisMON:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[1],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[1],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[1],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4));
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisDAY:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[3],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[3],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[3],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[3],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4));
   }
   m_dbEnDayTek[0] := pVal.CNT[0].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDayTek[1] := pVal.CNT[1].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDayTek[2] := pVal.CNT[3].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDayTek[3] := pVal.CNT[5].val[2]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[0] := pVal.CNT[0].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[1] := pVal.CNT[1].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[2] := pVal.CNT[3].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnDay[3] := pVal.CNT[5].val[3]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   tempDate := trunc(Now);
   tempDate := tempDate - nReq.m_swSpecc0;
   for j:=0 to 4 do
   for i:=0 to 3 do
   Begin
    nValue := m_dbEnDayTek[i];
    nlValue:= m_dbEnDay[i];
    if j<>1 then Begin nValue := 0;nlValue := 0;End;
    if nReq.m_swSpecc0=0 then FillSaveDataMessage(nlValue , QRY_ENERGY_DAY_EP+i, j, tempDate);
    //if nReq.m_swSpecc0=1 then FillSaveDataMessage(nlValue, QRY_ENERGY_DAY_EP+i, j, tempDate);
    FPUT(BOX_L3, @m_nRxMsg);
   End;
   FinalAction;
end;
procedure CE9STKVer49Meter.ReadNakEnMon(var pMsg: CMessage);
var tempDate   : TDateTime;
    item, i,j  : integer;
    value      : double;
    pVal       : _poket;
    Year1,Month1,Day1 : Word;
    nValue,nlValue    : Extended;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_poket));
   for i:=0 to 5 do
   for j:=0 to 3 do
   IsTrueValue(pVal.CNT[i].val[j]);
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisMON:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[1],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[1],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[1],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[1],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[1],ffFixed,6,4));
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>VSpisDAY:'+
   ' DT:' + DateTimeToStr(GetULongDate(pVal.DATETIME))+
   ' E+:' + FloatTostrF(pVal.CNT[0].val[3],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.CNT[1].val[3],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.CNT[2].val[3],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.CNT[3].val[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.CNT[4].val[3],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.CNT[5].val[3],ffFixed,6,4));
   }
   m_dbEnMonTek[0] := pVal.CNT[0].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMonTek[1] := pVal.CNT[1].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMonTek[2] := pVal.CNT[3].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMonTek[3] := pVal.CNT[5].val[0]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[0] := pVal.CNT[0].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[1] := pVal.CNT[1].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[2] := pVal.CNT[3].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   m_dbEnMon[3] := pVal.CNT[5].val[1]*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff;
   DecodeDate(Now,Year1,Month1,Day1);
   tempDate := EncodeDate(Year1,Month1,1);
   cDateTimeR.DecMonthEx(nReq.m_swSpecc0,tempDate);
   for j:=0 to 4 do
   for i:=0 to 3 do
   Begin
    nValue := m_nEnSumm[i]-m_dbEnMonTek[i];
    nlValue:= m_nEnSumm[i]-m_dbEnMon[i]-m_dbEnMonTek[i];
    if j<>1 then Begin nValue := 0;nlValue := 0;End;
    if nReq.m_swSpecc0=0 then FillSaveDataMessage(nValue , QRY_NAK_EN_MONTH_EP+i, j, tempDate);
    if nReq.m_swSpecc0=1 then FillSaveDataMessage(nlValue, QRY_NAK_EN_MONTH_EP+i, j, tempDate);
    FPUT(BOX_L3, @m_nRxMsg);
   End;
   FinalAction;
end;

procedure CE9STKVer49Meter.ReadSlicePeriodAns(var pMsg: CMessage);
var perMask : integer;
begin
   perMask := (pMsg.m_sbyInfo[3] and $30) shr 4;
   if perMask = 1 then
   begin
     m_progr30Slice := true;
     m_SliceReadSt := STSL_STKV116_READ_POINT;
     CreateSliceReq(nReq);
   end
   else
     FinalAction;
end;

procedure CE9STKVer49Meter.ReadPointSliceAns(var pMsg: CMessage);
var item, res : integer;
begin
   move(pMsg.m_sbyInfo[3], m_pPoint, sizeof(_pointers));
   m_SliceReadSt := STSL_STKV116_READ_SLICE;
   CreateSliceReq(nReq);
   {
   mCurrSlice := 0;
   m_SliceBuf.LASTnum := 0;
   move(pMsg.m_sbyInfo[3], m_SliceBuf.LASTnum, 2);
   m_SliceBuf.LASTuk := 0;
   move(pMsg.m_sbyInfo[5], m_SliceBuf.LASTuk, 2);
   res := FindSmInSliceBuf(item);
   if (res = 1) then begin ReadSliceInBuf(item); FinalAction; exit; end;
   //!!!!!!!!!!
   SetStartEndReadPoint;
   //!!!!!!!!!!
   if mCurrSlice > 0 then
   begin
     m_SliceReadSt := STSL_STKV116_READ_SLICE;
     CreateSliceReq(nReq);
   end else
     FinalAction;
   }
end;

{
_srez = packed record;
      DATETIME : Cardinal;
      Energy : array[0..5] of Double;   // ������� �� 6-�� ����������
      Power : array[0..5] of Double;    // ������������ ������� �������� �� ����� ����������
      CRC : Word;
    End;
// PHASE[3] - ����� �� ���� �����
    PHASE = packed record
      PWR : array[0..5] of Single;
    End;
    _lastload = packed record
      DATETIME : Cardinal;
      PWR : array[0..3] of PHASE;
      CRC : WORD;
    End;
}
procedure CE9STKVer49Meter.ReadSliceAns(var pMsg: CMessage);
var
    i,j,res,nPoint,nPoint0 : integer;
    //pVal  : _srez;
    pVal  : _lastload;
    pData : CStk49Srez;
    dtDate,tmpDate: TDateTime;
    dbVal : Double;
begin
   move(pMsg.m_sbyInfo[3], pVal, sizeof(_lastload));     //dsf
   for i:=0 to 3 do
   for j:=0 to 5 do
   Begin
    dbVal := pVal.PHS[i].PWR[j];
    IsTrueValue(dbVal);
    pVal.PHS[i].PWR[j] := dbVal;
   End;
   tmpDate           := GetULongDate(pVal.DATETIME){-EncodeTime(0, 30, 0, 0)};
   pData.szSize      := sizeof(CStk49Srez);
   pData.DATETIME    := tmpDate;
   pData.dbEnergy[0] := pVal.PHS[3].PWR[0];
   pData.dbEnergy[1] := pVal.PHS[3].PWR[1];
   pData.dbEnergy[2] := pVal.PHS[3].PWR[3];
   pData.dbEnergy[3] := pVal.PHS[3].PWR[5];
   m_bData.FPUTStk49(pData);
   //if m_bData.FPUTStk49(pData)=0 then TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Error PUT: DATE:'+DateTimeToStr(pData.DATETIME)+' VAL:'+FloatToStr(pData.dbEnergy[0])) else
   //                                   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Ok    PUT: DATE:'+DateTimeToStr(pData.DATETIME)+' VAL:'+FloatToStr(pData.dbEnergy[0]));

   if nReq.m_swSpecc0<>0 then
   Begin
   //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Spec0:');
   dtDate := GetDTFromSM(nReq.m_swSpecc0);
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Find:'+'Date Meter:'+DateTimeToStr(pData.DATETIME)+' Date USPD:'+DateTimeToStr(dtDate));
   if m_bData.FINDStk49(dtDate,pData)=False then
   Begin
    TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')Error: DATE USPD:'+DateTimeToStr(dtDate)+' VAL:'+FloatToStr(pData.dbEnergy[0]));
    SetUnknownSliceByIndex(QRY_SRES_ENR_EP,nReq.m_swSpecc2);
    SetUnknownSliceByIndex(QRY_SRES_ENR_EM,nReq.m_swSpecc2);
    SetUnknownSliceByIndex(QRY_SRES_ENR_RP,nReq.m_swSpecc2);
    SetUnknownSliceByIndex(QRY_SRES_ENR_RM,nReq.m_swSpecc2);
   End else
   Begin
    TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(nReq.m_swSpecc0)+')New: DATE METER:'+DateTimeToStr(pData.DATETIME)+' VAL:'+FloatToStr(pData.dbEnergy[0]));
    SendSliceToByIndexL3(pData.dbEnergy[0],QRY_SRES_ENR_EP,nReq.m_swSpecc2,pData.DATETIME);
    SendSliceToByIndexL3(pData.dbEnergy[1],QRY_SRES_ENR_EM,nReq.m_swSpecc2,pData.DATETIME);
    SendSliceToByIndexL3(pData.dbEnergy[2],QRY_SRES_ENR_RP,nReq.m_swSpecc2,pData.DATETIME);
    SendSliceToByIndexL3(pData.dbEnergy[3],QRY_SRES_ENR_RM,nReq.m_swSpecc2,pData.DATETIME);
   End;
   End;
   FinalAction;
   {
   TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nIndex)+')CE9STKVer49::>Srez:'+
   ' DT:' + DateTimeToStr(tmpDate)+
   ' E+:' + FloatTostrF(pVal.PHS[3].PWR[0],ffFixed,6,4)+
   ' E-:' + FloatTostrF(pVal.PHS[3].PWR[1],ffFixed,6,4)+
   ' R+:' + FloatTostrF(pVal.PHS[3].PWR[3],ffFixed,6,4)+
   ' R-:' + FloatTostrF(pVal.PHS[3].PWR[5],ffFixed,6,4)+
   ' R1:' + FloatTostrF(pVal.PHS[3].PWR[2],ffFixed,6,4)+
   ' R2:' + FloatTostrF(pVal.PHS[3].PWR[3],ffFixed,6,4)+
   ' R3:' + FloatTostrF(pVal.PHS[3].PWR[4],ffFixed,6,4)+
   ' R4:' + FloatTostrF(pVal.PHS[3].PWR[5],ffFixed,6,4));
   }
end;


procedure CE9STKVer49Meter.SendSliceToL3(dValue:Double;wType:Word;dtDate:TDateTime);
begin
   FillSaveDataMessage(dValue, wType, 0, dtDate);
   m_nRxMsg.m_sbyServerID := round(frac(dtDate) / EncodeTime(0, 30, 0, 0));
   //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nRxMsg.m_sbyServerID)+')Srez/Date:'+DateTimeToStr(dtDate));
   FPUT(BOX_L3, @m_nRxMsg);
end;
procedure CE9STKVer49Meter.SendSliceToByIndexL3(dValue:Double;wType:Word;nIndex:Integer;dtDate:TDateTime);
begin
   FillSaveDataMessage(dValue/1*m_nP.m_sfKI*m_nP.m_sfKU*m_nP.m_sfMeterKoeff, wType, 0, dtDate);
   m_nRxMsg.m_sbyServerID := nIndex;
   //TraceL(3, m_nTxMsg.m_swObjID, '('+IntToStr(m_nRxMsg.m_sbyServerID)+')Srez/Date:'+DateTimeToStr(dtDate));
   FPUT(BOX_L3, @m_nRxMsg);
end;

procedure CE9STKVer49Meter.SetUnknownSlice(wType:Word);
var tempDate : TDateTime;
begin
   tempDate := GetDTFromSM(nReq.m_swSpecc0);
   FillSaveDataMessage(0, wType, 0, tempDate);
   m_nRxMsg.m_sbyServerID := round(frac(tempDate) / EncodeTime(0, 30, 0, 0)){ or $80};
   FPUT(BOX_L3, @m_nRxMsg);
end;
procedure CE9STKVer49Meter.SetUnknownSliceByIndex(wType:Word;nIndex:Integer);
var tempDate : TDateTime;
begin
   tempDate := GetDTFromSM(nReq.m_swSpecc0);
   FillSaveDataMessage(0, wType, 0, tempDate);
   m_nRxMsg.m_sbyServerID := nIndex;
   FPUT(BOX_L3, @m_nRxMsg);
end;
procedure CE9STKVer49Meter.ReadSlicesPackAns(var pMsg: CMessage);
begin

   case m_SliceReadSt of
     //STSL_STKV116_READ_PERIOD : ReadSlicePeriodAns(pMsg);
    STSL_STKV116_READ_POINT  : ReadPointSliceAns(pMsg);
    STSL_STKV116_READ_SLICE  : ReadSliceAns(pMsg);
   end;

   //ReadSliceAns(pMsg);
end;

procedure CE9STKVer49Meter.ReadJrnlAns(var pMsg: CMessage);
var i, uk : integer;
    tDate : TDateTime;
    time  : Cardinal;
begin
   uk := pMsg.m_sbyInfo[23];
   if (uk >= 0) and (uk < 5) then
   begin
      for i := 0 to uk - 1 do
      begin
        move(pMsg.m_sbyInfo[3 + i*4], time, 4);
        tDate := GetULongDate(time);
        if tDate <> 0 then
          SendL3Event(QRY_JRNL_T3,2, EVM_OFF_POWER, m_nP.m_swMID, 0, tDate);
      end;
      for i := uk to 4 do
      begin
        move(pMsg.m_sbyInfo[3 + i*4], time, 4);
        tDate := GetULongDate(time);
        if tDate <> 0 then
          SendL3Event(QRY_JRNL_T3,2, EVM_OFF_POWER, m_nP.m_swMID, 0, tDate);
      end;
   end;
   FinalAction;
end;

procedure CE9STKVer49Meter.GetDataAnswer(var pMsg: CMessage);
begin
   if m_nAutoTMR<>Nil then m_nAutoTMR.OnTimer(10);
   case m_ParamID of
   //  QRY_ENERGY_SUM_EP : ReadSumEnergyAns(pMsg);
     QRY_MGAKT_POW_S   : ReadCurrentParam(pMsg);
     QRY_ENERGY_SUM_EP : ReadSpisEnerAns(pMsg);
     QRY_NAK_EN_DAY_EP : ReadNakEnDay(pMsg);
     QRY_NAK_EN_MONTH_EP : ReadNakEnMon(pMsg);
     QRY_ENERGY_DAY_EP : ReadEnDay(pMsg);
     QRY_ENERGY_MON_EP : ReadMonthEnAns(pMsg);
     QRY_SRES_ENR_EP   : ReadSlicesPackAns(pMsg);
     QRY_JRNL_T1, QRY_JRNL_T2,
     QRY_JRNL_T3, QRY_JRNL_T4 : ReadJrnlAns(pMsg)
     else FinalAction;
   end;
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
procedure CE9STKVer49Meter.RES01_GetDataByID_Fail(var pMsg : CMessage);
var
  l_EStr : String;
begin
  if (pMsg.m_sbyInfo[3] = $01) then
    l_EStr := '������ �������: ������������ ����� ID!'
  else if (pMsg.m_sbyInfo[3] = $02) then
    l_EStr := '������ �������: ������������ ����� �������!'
  else if (pMsg.m_sbyInfo[3] = $04) then
    l_EStr := '������ �������: ������ CRC ����� ������ � ��������!';

  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::>' + l_EStr);
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
procedure CE9STKVer49Meter.REQ07_GetDateTime(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
end;


(*******************************************************************************
 * ����� �� ������� "������ ������� � ���� �� ��������"
 *   0	UCHAR	0x7E	������� ������ ������
 *   1	UCHAR	0x08	������ ������ ����� ������������� � ������������
 *   2	UCHAR	0x07	����� "������ ������� � ���� �� ��������"
 *   3	UCHAR	Sec	�������
 *   4	UCHAR	Min	������
 *   5	UCHAR	Hour 	����
 *   6	UINT	Week	���� ������ (0�6, 0-�����������)
 *   7	UCHAR	Day	�����
 *   8	UCHAR	Month	�����
 *   9-10	UCHAR	Year	��� [YearL,YearH]
 *   11	UCHAR	CRC8	����������� ����� ������ ������
 *   ������ ������� ��� �������� ������� ������������.
 *
 * @param var pMsg:CMessage
 *******************************************************************************)
 {
 �	���	��������	��������
0	UCHAR	0x7E	������� ������ ������
1	UCHAR	0x08	������ ������ ����� ������������� � ������������
2	UCHAR	0x07	����� "������ ������� � ���� �� ��������"
3	UCHAR	Week	���� ������ (0�6, 0-�����������)
4	UCHAR	Day	�����
5	UCHAR	Month	�����
6	UINT	Year	���
8	UCHAR	Hour	����
9	UCHAR	Min	������
10	UCHAR	Sec	�������
11	UCHAR	CRC8	����������� ����� ������ ������

    m_nTxMsg.m_sbyInfo[4] := Day;
    m_nTxMsg.m_sbyInfo[5] := Month;
    m_nTxMsg.m_sbyInfo[6] := Year mod 100;
    m_nTxMsg.m_sbyInfo[7] := Year div 100;
    m_nTxMsg.m_sbyInfo[8] := Hour;
    m_nTxMsg.m_sbyInfo[9] := Min;
    m_nTxMsg.m_sbyInfo[10]:= Sec;
 }
procedure CE9STKVer49Meter.RES07_GetDateTime(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;
  LastDate:TDateTime;
begin
    m_nRxMsg.m_sbyInfo[0] := 8;
    m_nRxMsg.m_sbyInfo[1] := QRY_DATA_TIME;
    _yy := (Word(pMsg.m_sbyInfo[7]) shl 8 + pMsg.m_sbyInfo[6])-2000;
    //_yy := 13;
    _mn := pMsg.m_sbyInfo[5];
    _dd := pMsg.m_sbyInfo[4];
    _hh := pMsg.m_sbyInfo[8];
    _mm := pMsg.m_sbyInfo[9];
    _ss := pMsg.m_sbyInfo[10];
    if (_mn>12)or(_mn=0)or(_dd>31)or(_dd=0)or(_hh>59)or(_mm>59)or(_ss>59) then
    Begin
     FinalAction;
     exit;
    End;
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
procedure CE9STKVer49Meter.KorrTime(LastDate : TDateTime);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
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
    m_QFNC       := $08;
    //m_QTimestamp := Now();
    ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);
    m_nTxMsg.m_sbyInfo[0] := $7E;
    m_nTxMsg.m_sbyInfo[1] := $08;
    m_nTxMsg.m_sbyInfo[2] := $08;

    Year := Year + 2000; 
    m_nTxMsg.m_sbyInfo[3] := cDateTimeR.DayOfWeekEx1(Now);
    m_nTxMsg.m_sbyInfo[4] := Day;
    m_nTxMsg.m_sbyInfo[5] := Month;
    m_nTxMsg.m_sbyInfo[6] := LoByte(Year);
    m_nTxMsg.m_sbyInfo[7] := HiByte(Year);
    m_nTxMsg.m_sbyInfo[8] := Hour;
    m_nTxMsg.m_sbyInfo[9] := Min;
    m_nTxMsg.m_sbyInfo[10]:= Sec;

    EncodePacket(m_nTxMsg.m_sbyInfo);
    m_nTxMsg.m_sbyInfo[11] := CRC8(m_nTxMsg.m_sbyInfo, true);
    FillMessageHead(m_nTxMsg, 12);
    SendToL1(BOX_L1, @m_nTxMsg);
    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
    TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer49Meter.RES00_SetDateTime_OK(var pMsg:CMessage);
begin
  if pMsg.m_sbyInfo[2]=0 then
  Begin
   TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::> ����� �������� �����������: ' + DateTimeToStr(Now()));
   m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
   if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
   m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
   if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
  End else
  ErrorCorrEv;
  FinalAction();
  m_QFNC:=0;
end;


procedure CE9STKVer49Meter.CreateJrnlEvReq(var nReq: CQueryPrimitive);
begin
   m_ParamID := QRY_JRNL_T3;
   FillSTKReq(33, 0);
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
procedure CE9STKVer49Meter.REQ0F_GetCurrentPower(var nReq: CQueryPrimitive);
begin
  m_QFNC       := $0d;
  m_QTimestamp := Now();

  ZeroMemory(@m_nTxMsg.m_sbyInfo, 16);

  m_nTxMsg.m_sbyInfo[0] := $7E;
  m_nTxMsg.m_sbyInfo[1] := $00;
  m_nTxMsg.m_sbyInfo[2] := $0d;

  EncodePacket(m_nTxMsg.m_sbyInfo);
  m_nTxMsg.m_sbyInfo[3] := CRC8(m_nTxMsg.m_sbyInfo, true);

  FillMessageHead(m_nTxMsg, 4);
  FPUT(BOX_L1, @m_nTxMsg);
  m_ParamID := QRY_MGAKT_POW_S;
  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer49Meter.REQ0E_CTRL_SetRelayState(var nReq: CQueryPrimitive);
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
  TraceM(2, m_nTxMsg.m_swObjID,'(__)CE9STKVer49::>Out DRQ:',@m_nTxMsg);
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
procedure CE9STKVer49Meter.RES00_CTRL_SetRelayState_OK(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::> �������� � ����������� ��������� �������');
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
procedure CE9STKVer49Meter.RES01_CTRL_SetRelayState_Fail(var pMsg:CMessage);
begin
  TraceL(2, m_nTxMsg.m_swObjID, '(__)CE9STKVer49::> �������� � ����������� �� ���������!');
  FinalAction();
end;

(*******************************************************************************
 * ������������ ������� �� ���������� ��������� ������������ �������
 ******************************************************************************)
procedure CE9STKVer49Meter.ADD_RelayState_CTRLQry(_StateID : WORD);
begin
  m_nObserver.ClearCtrlQry();

  m_nObserver.AddCtrlParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddCtrlParam(QRY_RELAY_CTRL, 0, 0, _StateID, 1);
  m_nObserver.AddCtrlParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CE9STKVer49Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();

  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;


{*******************************************************************************
 * ������������ ������� �� ���������� �������
 ******************************************************************************}
procedure CE9STKVer49Meter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);

  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
    
  m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
procedure CE9STKVer49Meter.ADD_Energy_Mon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
       if i > 1 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_MON_EP, i-1, 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
procedure CE9STKVer49Meter.ADD_Energy_NMon_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
    m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
    m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
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
       if i > 2 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP, i-1, 0, 0, 1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
procedure CE9STKVer49Meter.ADD_Energy_NDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   // m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
//    m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecDate(TempDate);
       Inc(i);
       if i > 60 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i-1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

procedure CE9STKVer49Meter.ADD_Energy_Day_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
   // m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecDate(TempDate);
       Inc(i);
       if i > 60 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_ENERGY_DAY_EP, i-1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

{
procedure CE9STKVer18Meter.ADD_Energy_NAckDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
begin
    //m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
   if (cDateTimeR.CompareDay(dt_Date2, Now) = 1 ) then
     dt_Date2 := Now;
   while cDateTimeR.CompareDay(dt_Date1, dt_Date2) <> 1 do
   begin
     i        := 0;
     TempDate := Now;
     while (cDateTimeR.CompareDay(dt_Date2, TempDate) <> 1) do
     begin
       cDateTimeR.DecDate(TempDate);
       Inc(i);
       if i > 60 then
       Begin
         m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
         exit;
       End;
     end;
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, i-1, 0, 0, 1);
     cDateTimeR.DecDate(dt_Date2);
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;
}
{*******************************************************************************
 * ������������ ������� �� ���������� ����������� ������
    @param DTS  TDateTime ������ �������
    @param DTE  TDateTime ��������� �������
 ******************************************************************************}
procedure CE9STKVer49Meter.AddSresEnergGrpahQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i, Srez     : integer;
    h, m, s, ms : word;
    y, d, mn    : word;
    DeepSrez    : word;
    sm          : word;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
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
      sm := 1;
      for Srez := (h*60 + m) div 30 - 1 downto 0 do
      Begin
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, sm, d, Srez, 1);
       sm := sm + 1;
      end;
     End else
     Begin
      Srez := 0;
      //sm := 48*(trunc(Now)-trunc(dt_Date1)-1)+ (h*60 + m) div 30 + 2+48;
      sm := 48*(trunc(Now)-trunc(dt_Date1)-1)+ (h*60 + m) div 30 + 1+48;
      while Srez <= 47 do
      begin
       m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, sm, d, Srez, 1);
       Srez := Srez + 1;
       sm := sm - 1;
      end;
     End;
     cDateTimeR.DecDate(dt_Date2);
     Inc(DeepSrez);
     if (DeepSrez > 32) then
     Begin
       m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
       exit;
     End
   end;
   m_nObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
end;

function CE9STKVer49Meter.GetYear(month, day: integer): integer;
var yN, mN, dN : word;
    tempDate   : TDateTime;
begin
   DecodeDate(Now, yN, mN, dN);
   tempDate := EncodeDate(yN, month, day);
   if tempDate > Now then
     Result := yN - 1
   else
     Result := yN;
end;
function CE9STKVer49Meter.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;


End.
