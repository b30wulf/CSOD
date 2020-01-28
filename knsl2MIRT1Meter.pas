{*******************************************************************************
 *  Модуль протокола счетчика МИРТ1
 *  Ukrop
 *  11.07.2013
 ******************************************************************************}

unit knsl2MIRT1Meter;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox;

type
    SRTRADDR= packed record
      Items : array[0..8] of WORD;
      Count : Word;
    End;
    CMIRT1Meter = class(CMeter)
    private
        m_DotPosition : Integer; // положение точки
        m_sAddress    : SRTRADDR;
        m_Password    : DWORD; // пароль счетчика
        m_nRtr        : Byte; //Количество ретрансляторов
        nRSH          : Byte; //Сдвиг
        m_QFNC        : BYTE;
        m_QTimestamp  : TDateTime;

        m_IsAuthorized: Boolean;
        m_SresID      : Byte;
        m_dbDecSeparator  : Extended;
        nReq : CQueryPrimitive;
        dt_TLD          : TDateTime;
        nOldYear        : Word;
        bl_SaveCrEv     : boolean;
        advInfo         : SL2TAGADVSTRUCT;
        l_ProtoVer      : WORD;
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
        function    SetCommand(swParamID:Word;swSpecc0,swSpecc1,swSpecc2:Smallint;byEnable:Byte):Boolean;override;

        procedure   HandQryRoutine(var pMsg:CMessage);
        procedure   OnFinHandQryRoutine(var pMsg:CMessage);

    private
        function    Param2CMD(_ParamID : BYTE) : BYTE;
        function    FindFrame(var pMsg:CMessage;var nRet:Byte):Boolean;
        function    GetFrame(var byInMsg:array of byte;var byOutMsg:array of byte):Integer;

        function    CRC8(_Packet: array of BYTE; _DataLen:Integer) : Byte;
        function    IsValidMessage(var pMsg : CMessage) : boolean;
        procedure   FillMessageHead(var pMsg : CHMessage; length : word);
        procedure   MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
        function    FillMessageBody(var _Msg : CHMessage; _FNC : BYTE;_Len : BYTE):Word;
        function    FillMessageBodyV3(var _Msg : CHMessage; _FNC : BYTE;_Len : BYTE):Word;        
        procedure   FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
        function    GetAddres(var strInAddr:String;var sAddress:SRTRADDR):Boolean;
        function    ByteStuff(var _Buffer : array of BYTE; _Len : Byte) : Byte;
        function    ByteUnStuff(var _Buffer : array of BYTE; _Len : Byte): Byte;

        // protocol REQUESTS
        procedure   REQ01_OpenSession(var nReq: CQueryPrimitive);   // Открыть доступ к счетчику
        procedure   RES01_OpenSession(var pMsg:CMessage);           // Ответ

        procedure   REQ05_GetEnergySum(var nReq: CQueryPrimitive);
        procedure   RES05_GetEnergySum(var pMsg:CMessage);

        procedure   REQ05_GetEnergySum_V2(var nReq: CQueryPrimitive);
        procedure   RES05_GetEnergySum_V2(var pMsg:CMessage);

        procedure   REQ05_GetEnergySum_V3(var nReq: CQueryPrimitive);
        procedure   RES05_GetEnergySum_V3(var pMsg:CMessage);


        procedure   REQ1C_GetDateTime(var nReq: CQueryPrimitive);   // Чтение даты/времени
        procedure   RES1C_GetDateTime(var pMsg : CMessage);         // Оnвет
        procedure   KorrTime(LastDate : TDateTime);

        //procedure   REQ1D_SetDateTime(var nReq: CQueryPrimitive);
        procedure   RES1D_SetDateTime(var pMsg : CMessage);


        procedure   REQ24_Get_Ver;//Проверка версии
        procedure   REQ24_GetRead_Ver(var pMsg : CMessage);//Чтение по данных от версии

        procedure   REQ24_GetEnergyMonth(var nReq: CQueryPrimitive);
        procedure   RES24_GetEnergyMonth(var pMsg : CMessage);

        procedure   REQ24_GetEnergyMonth_V2(var nReq: CQueryPrimitive);
        procedure   RES24_GetEnergyMonth_V2(var pMsg : CMessage);

        procedure   REQ24_GetEnergyMonth_V3(var nReq: CQueryPrimitive);
        procedure   RES24_GetEnergyMonth_V3(var pMsg : CMessage);


        procedure   REQ25_GetEnergyDay(var nReq: CQueryPrimitive);
        procedure   RES25_GetEnergyDay(var pMsg : CMessage);

        procedure   REQ25_GetEnergyDay_V2(var nReq: CQueryPrimitive);
        procedure   RES25_GetEnergyDay_V2(var pMsg : CMessage);

        procedure   REQ25_GetEnergyDay_V3(var nReq: CQueryPrimitive);
        procedure   RES25_GetEnergyDay_V3(var pMsg : CMessage);

        procedure   REQ10_ReadConfig(var nReq: CQueryPrimitive);
        procedure   RES10_ReadConfig(var pMsg:CMessage);

    /////////////////////////////

        procedure   ADD_Energy_Sum_GraphQry();
        procedure   ADD_DateTime_Qry();
        procedure   ADD_Events_GraphQry();

        procedure   ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyMonth_Qry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_NakEnergyDay_Qry(dt_Date1, dt_Date2 : TDateTime);
        procedure   ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);

    End;

implementation

{*******************************************************************************
 *
 ******************************************************************************}
constructor CMIRT1Meter.Create;
Begin
//  TraceL(2, m_nP.m_swMID,'(__)CL2MD::> MIRT1 Meter Created');
End;


{*******************************************************************************
 *
 ******************************************************************************}
destructor CMIRT1Meter.Destroy;
Begin
    inherited;
End;

procedure CMIRT1Meter.RunMeter; Begin end;

function CMIRT1Meter.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := False;
end;

{*******************************************************************************
 *
 ******************************************************************************}
procedure CMIRT1Meter.InitMeter(var pL2:SL2TAG);
Var
  Year, Month, Day : Word;
  str : String;
  slv : TStringList;
begin
  //m_Address := StrToInt(pL2.m_sddPHAddres);

  IsUpdate := 0;
  m_nRtr   := 0;
  m_IsAuthorized := false;
  SetHandScenario;
  SetHandScenarioGraph;
  DecodeDate(Now, Year, Month, Day);
  nOldYear := Year;
//  TraceL(2,m_nP.m_swMID,'(__)CL2MD::>MIRT1 Meter Created:'+
//    ' PortID:'+IntToStr(m_nP.m_sbyPortID)+
//    ' Rep:'+IntToStr(m_byRep)+
//    ' Group:'+IntToStr(m_nP.m_sbyGroupID));


  slv := TStringList.Create;
   getStrings(m_nP.m_sAdvDiscL2Tag,slv);
   if slv[0]='' then slv[0] := '0';
   if slv[2]='' then slv[2] := '0';
   advInfo.m_sKoncFubNum  := slv[0];
   advInfo.m_sKoncPassw   := slv[1];
   advInfo.m_sAdrToRead   := slv[2];

   str := advInfo.m_sAdrToRead;//pL2.m_sddPHAddres;

   GetAddres(str,m_sAddress);
   m_nP.m_sddPHAddres := IntToStr(m_sAddress.Items[0]);
   m_Password := StrToInt(pL2.m_schPassword);
   slv.Clear;
   slv.Destroy;
End;
function CMIRT1Meter.GetAddres(var strInAddr:String;var sAddress:SRTRADDR):Boolean;
Var
    str,strF : String;
    i,nPos:Integer;
    wAddr : array[0..7] of Word;
Begin
    try
    Result := False;
    str    := strInAddr+';';
    nPos   := Pos(';',str);
    sAddress.Count := 0;
    for i:=0 to 8 do sAddress.Items[i] := 0;
    i := 0;
    while (nPos<>0) do
    Begin
     strF := Copy(str,0,nPos-1);
     //sAddress.Items[i] := StrToInt(strF);
     wAddr[i] := StrToInt(strF);
     Delete(str,1,nPos+0);
     nPos := Pos(';',str);
     Inc(i);
     Result := True;
     if (nPos=1) then break;
    End;
    sAddress.Count := i;
    for i:=0 to sAddress.Count-1 do
    Begin
      if (i=(sAddress.Count-1)) then
      sAddress.Items[i] := wAddr[0]
       else
      sAddress.Items[i] := wAddr[i+1];
    End;
    except
     Result   := False;
    end;
End;
function  CMIRT1Meter.SetCommand(swParamID:Word;swSpecc0,swSpecc1,swSpecc2:Smallint;byEnable:Byte):Boolean;
Var
  i : Integer;
Begin
  case swParamID of
       QRY_SRES_ENR_EP :
       Begin
        for i:=6 downto 1 do
        m_nObserver.AddCurrParam(swParamID,swSpecc0,swSpecc1,swSpecc2 or (i shl 8),byEnable);
       End;
       else
       m_nObserver.AddCurrParam(swParamID,swSpecc0,swSpecc1,swSpecc2,byEnable);
  End;
  Result := False;
End;
{*******************************************************************************
 * Обработчик событий нижнего уровня
 ******************************************************************************}
function CMIRT1Meter.FindFrame(var pMsg:CMessage;var nRet:Byte):Boolean;
Var
   i,j,nLen:Integer;
   byBuff : array[0..100] of Byte;
Begin
   Result := False;
   for i:=0 to pMsg.m_swLen-1-13 do
   Begin
    if (pMsg.m_sbyInfo[i+0]=$73)and(pMsg.m_sbyInfo[i+1]=$55) then
    Begin
     if ((pMsg.m_sbyInfo[3+i] and $0f)=0)and
        ((pMsg.m_sbyInfo[2+i] and $20)=0)and
        (pMsg.m_sbyInfo[4+i]=255)and
        (pMsg.m_sbyInfo[5+i]=255)then
     Begin
      nRet := pMsg.m_sbyInfo[3+i] shl 4;
      nLen := GetFrame(pMsg.m_sbyInfo[i],byBuff);
      if(nLen<>0) then
      Begin
       move(byBuff,pMsg.m_sbyInfo[0], nLen);
       pMsg.m_swLen := 13+nLen;
       Result := True;
       break;
      End;
     End;
    End;
   End;
End;
function CMIRT1Meter.GetFrame(var byInMsg:array of byte;var byOutMsg:array of byte):Integer;
Var
   i : Integer;
Begin
   Result := 0;
   FillChar(byOutMsg,100,0);
   byOutMsg[0] := $73;
   byOutMsg[1] := $55;
   i:=2;
   while (byInMsg[i]<>$55) do
   Begin
    byOutMsg[i] := byInMsg[i];
    if (i>95) then
    Begin
     Result := 0;
     //break;
     exit
    End;
    Inc(i);
   End;
   byOutMsg[i] := byInMsg[i];
   Result := i+1+1;
End;
function CMIRT1Meter.LoHandler(var pMsg:CMessage):Boolean;
Var
  nLen : Word;
  nRet : Byte;
begin
  Result := true;
  if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CMIRT1Meter/LoHandler ON');
  try
  case pMsg.m_sbyType of
    QL_CONNCOMPL_REQ: OnConnectComplette(pMsg);
    QL_DISCCOMPL_REQ: OnDisconnectComplette(pMsg);
    PH_DATA_IND:
    Begin
      if FindFrame(pMsg,nRet)=False then
      Begin
        Result := false;
        exit;
      End;
      nLen := ByteUnStuff(pMsg.m_sbyInfo, pMsg.m_swLen-13);
      pMsg.m_swLen := 13+nLen;
      if not IsValidMessage(pMsg) then
      begin
        //TraceM(2,pMsg.m_swObjID,'(__)CMIRT1::>Error BAD Packet:',@pMsg);
        Result := false;
        exit;
      end;
      case m_QFNC of // FUNCTION
        $30 : RES01_OpenSession(pMsg);
        $05 : REQ24_GetRead_Ver(pMsg);//RES05_GetEnergySum(pMsg);
        $1C : RES1C_GetDateTime(pMsg);
        $1D : RES1D_SetDateTime(pMsg);
        $24 : REQ24_GetRead_Ver(pMsg);//RES24_GetEnergyMonth(pMsg);
        $25 : RES25_GetEnergyDay(pMsg);
        //$26 : RES26_ReadEnergyOn30min(pMsg);
//        $2D : RES2D_GetCurrentPower(pMsg);
        $10 : RES10_ReadConfig(pMsg);
      end;
    end;
  end;
  except
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(CMIRT1Meter/LoHandler ERROR');
  end;
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(CMIRT1Meter/LoHandler EXIT');
end;

{*******************************************************************************
 * Обработчик событий верхнего уровня
 ******************************************************************************}
function CMIRT1Meter.HiHandler(var pMsg:CMessage):Boolean;
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
        QRY_AUTORIZATION   : REQ01_OpenSession(nReq);
        QRY_ENERGY_SUM_EP  : REQ24_Get_Ver;//REQ05_GetEnergySum(nReq);
       // QRY_SRES_ENR_EP    : REQ26_ReadEnergyOn30min(nReq);

        QRY_NAK_EN_MONTH_EP: REQ24_Get_Ver;            //REQ24_GetEnergyMonth(nReq);

        QRY_NAK_EN_DAY_EP  : REQ24_Get_Ver;//REQ25_GetEnergyDay(nReq);

        QRY_KPRTEL_KE      : REQ10_ReadConfig(nReq);
        QRY_DATA_TIME      : REQ1C_GetDateTime(nReq);
//        QRY_JRNL_T3        : REQ2A_GetEvents(nReq);
//        QRY_MGAKT_POW_S    : REQ2D_GetCurrentPower(nReq);
      end;
    End;
    QL_DATA_GRAPH_REQ    : HandQryRoutine(pMsg);
    QL_DATA_FIN_GRAPH_REQ: OnFinHandQryRoutine(pMsg);
    QL_LOAD_EVENTS_REQ   : ADD_Events_GraphQry();
  end;
end;


function CMIRT1Meter.CRC8(_Packet: array of BYTE; _DataLen:Integer) : Byte;
var
  CRC_Pointer:Integer;
  CRC_Byte,i:Byte;
begin
  Result:=0;
  for CRC_Pointer:=2 to _DataLen-1+2 do
  begin
    CRC_Byte:=_Packet[CRC_Pointer];

    for i:=1 to 8 do
    begin
      if ((CRC_Byte xor Result) and $80) =0 then
      begin
        Result:=Byte(Result shl 1);
      end else
      begin
        Result:=Byte((Result shl 1)xor $A9);
      end;

      CRC_Byte:=Byte(CRC_Byte shl 1);
    end;
  end;
end;

function CMIRT1Meter.IsValidMessage(var pMsg : CMessage) : Boolean;
var
    l_DataLen : WORD;
    bt : byte;
    nSH : Integer;
begin
    Result := false;
    // контрольная сумма
    nSH:=0;
    if m_nP.m_sbyTSlice=1 then nSH:=1; //
    l_DataLen := pMsg.m_swLen-13-2-nSH-1;    //Убрать -1 если стоит турбо срез 
    bt:=self.CRC8(pMsg.m_sbyInfo, pMsg.m_swLen-13-4-nSH-1);
    if (bt <> pMsg.m_sbyInfo[l_DataLen]) then
    begin
        //TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CMIRT1 Ошибка CRC! Выход!');
        exit;
    end;

  Result := true;
end;

procedure CMIRT1Meter.FillMessageHead(var pMsg : CHMessage; length : word);
begin
   pMsg.m_swLen         := length + 13;
   pMsg.m_swObjID       := m_nP.m_swMID;
   pMsg.m_sbyFrom       := DIR_L2TOL1;
   pMsg.m_sbyFor        := DIR_L2TOL1;
   pMsg.m_sbyType       := PH_DATARD_REQ;
   pMsg.m_sbyTypeIntID  := m_nP.m_sbyPortID;
   pMsg.m_sbyIntID      := m_nP.m_sbyPortID;
   pMsg.m_sbyServerID   := MET_MIRT1;
   pMsg.m_sbyDirID      := IsUpdate;
   SendOutStat(pMsg.m_swLen);
end;

procedure CMIRT1Meter.MsgHeadForEvents(var pMsg:CHMessage; Size:byte);
begin
    pMsg.m_swLen       := 13 + 9 + 3;
    pMsg.m_swObjID     := m_nP.m_swMID;
    pMsg.m_sbyFrom     := DIR_L2TOL3;
    pMsg.m_sbyFor      := DIR_L2TOL3;
    pMsg.m_sbyType     := PH_EVENTS_INT;
    pMsg.m_sbyIntID    := m_nP.m_sbyPortID;
    pMsg.m_sbyServerID := MET_MIRT1;
    pMsg.m_sbyDirID    := m_nP.m_sbyPortID;
end;

function CMIRT1Meter.FillMessageBody(var _Msg : CHMessage; _FNC : BYTE;_Len : BYTE):Word;
Var
  nLen,nSH : Word;
  i: Integer;
begin
  m_nTxMsg.m_sbyInfo[0] := $73; // Признак начала пакета 2by
  m_nTxMsg.m_sbyInfo[1] := $55;
  i   := 0;
  nSH := 0;
  for i:=0 to m_sAddress.Count-1 do  //oleg
  Begin                        // oleg
   nSH :=0;//2*i;
   m_nTxMsg.m_sbyInfo[4+nSH] := LO(m_sAddress.Items[i]);
   m_nTxMsg.m_sbyInfo[5+nSH] := HI(m_sAddress.Items[i]);
  End;
  Dec(i);
  m_nRtr := i;
  nRSH := 2*m_nRtr;
  m_nTxMsg.m_sbyInfo[2]     := $20 OR _Len;// Длина пакета
  m_nTxMsg.m_sbyInfo[3]     := $00;//m_nRtr or (m_nRtr shl 4);   // резерв   //oleg
  m_nTxMsg.m_sbyInfo[6+nSH] := $FF;              // Адрес УСПД для запроса $FFFF
  m_nTxMsg.m_sbyInfo[7+nSH] := $FF;
  m_nTxMsg.m_sbyInfo[8+nSH] := _FNC;             // Комманда таб 2
  
  // пароль для счетчика
  m_nTxMsg.m_sbyInfo[9+nSH] := (m_Password AND $000000FF);
  m_nTxMsg.m_sbyInfo[10+nSH]:= (m_Password AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[11+nSH]:= (m_Password AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[12+nSH]:= (m_Password AND $FF000000) shr 24;

  m_nTxMsg.m_sbyInfo[13+nSH + _Len] := CRC8(m_nTxMsg.m_sbyInfo,11+nSH+_Len);
  m_nTxMsg.m_sbyInfo[14+nSH + _Len] := $55;
  nLen := ByteStuff(m_nTxMsg.m_sbyInfo, 15+nSH+_Len); // Байт Штаффинг
  Result := nLen;
end;


function CMIRT1Meter.FillMessageBodyV3(var _Msg : CHMessage; _FNC : BYTE;_Len : BYTE):Word;
Var
  nLen,nSH : Word;
  i: Integer;
begin
  m_nTxMsg.m_sbyInfo[0] := $73; // Признак начала пакета 2by
  m_nTxMsg.m_sbyInfo[1] := $55;
  i   := 0;
  nSH := 0;
  for i:=0 to m_sAddress.Count-1 do  //oleg
  Begin                        // oleg
   nSH :=0;//2*i;
   m_nTxMsg.m_sbyInfo[4+nSH] := LO(m_sAddress.Items[i]);
   m_nTxMsg.m_sbyInfo[5+nSH] := HI(m_sAddress.Items[i]);
  End;
  Dec(i);
  m_nRtr := i;
  nRSH := 2*m_nRtr;
  m_nTxMsg.m_sbyInfo[2]     := $20 OR _Len;// Длина пакета
  m_nTxMsg.m_sbyInfo[3]     := $00;//m_nRtr or (m_nRtr shl 4);   // резерв   //oleg
  m_nTxMsg.m_sbyInfo[6+nSH] := $FF;              // Адрес УСПД для запроса $FFFF
  m_nTxMsg.m_sbyInfo[7+nSH] := $FF;
  m_nTxMsg.m_sbyInfo[8+nSH] := _FNC;             // Комманда таб 2
  
  // пароль для счетчика
  m_nTxMsg.m_sbyInfo[9+nSH] := (m_Password AND $000000FF);
  m_nTxMsg.m_sbyInfo[10+nSH]:= (m_Password AND $0000FF00) shr 8;
  m_nTxMsg.m_sbyInfo[11+nSH]:= (m_Password AND $00FF0000) shr 16;
  m_nTxMsg.m_sbyInfo[12+nSH]:= (m_Password AND $FF000000) shr 24;

  m_nTxMsg.m_sbyInfo[13+nSH + _Len] := CRC8(m_nTxMsg.m_sbyInfo,11+nSH+_Len);
  m_nTxMsg.m_sbyInfo[14+nSH + _Len] := $55;
  nLen := ByteStuff(m_nTxMsg.m_sbyInfo, 15+nSH+_Len); // Байт Штаффинг
  Result := nLen;
end;


procedure CMIRT1Meter.FillSaveDataMessage(_Value : double; _ParamID : byte; _Tariff : byte; _WriteDate : Boolean);
var
    l_Year, l_Month, l_Day,
    l_Hour, l_Min, l_Second, l_MS : word;
begin
   m_nRxMsg.m_sbyType    := DL_DATARD_IND;
   m_nRxMsg.m_sbyFor     := DIR_L2TOL3;
   m_nRxMsg.m_swObjID    := m_nP.m_swMID;
   m_nRxMsg.m_swLen      := 13 + 9 + sizeof(double);
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
            //cDateTimeR.IncMonth(m_QTimestamp);
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


{******************************************************************************
 *  Получение номера параметра в протоколе СС301 по ID параметра
 *      @param  _ParamID : Byte
 *      @return Integer
 ******************************************************************************}
function CMIRT1Meter.Param2CMD(_ParamID : BYTE) : BYTE;
Begin
  case _ParamID of
    QRY_AUTORIZATION  : Result := $01;
    QRY_DATA_TIME     : Result := $1C;
    QRY_NAK_EN_MONTH_EP : Result := $24;
    QRY_NAK_EN_DAY_EP : Result := $25;
    QRY_SRES_ENR_EP   : Result := $26;
    QRY_JRNL_T3       : Result := $2A;
    QRY_MGAKT_POW_S   : Result := $2D;
    QRY_ENERGY_SUM_EP : Result := $05;
    else
        Result := 1;
    end;
End;


procedure CMIRT1Meter.HandQryRoutine(var pMsg:CMessage);
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
      QRY_SRES_ENR_EP :
        ADD_SresEnergyDay_GraphQry(DTS, DTE);

      QRY_NAK_EN_DAY_EP:
        ADD_NakEnergyDay_Qry(DTS, DTE);

      QRY_NAK_EN_MONTH_EP:
        ADD_NakEnergyMonth_Qry(DTS, DTE);

      QRY_JRNL_T3 :
        ADD_Events_GraphQry();

      QRY_DATA_TIME :
        ADD_DateTime_Qry();
    end;
end;



procedure CMIRT1Meter.OnFinHandQryRoutine(var pMsg:CMessage);
begin
  if m_nP.m_sbyEnable=1 then
  begin
    m_IsAuthorized := false;
    OnFinalAction();
//    TraceM(2,pMsg.m_swObjID,'(__)CL2MD::>CMIRT1 OnFinHandQryRoutine  DRQ:',@pMsg);
    IsUpdate := 0;
  End;
end;

procedure CMIRT1Meter.OnEnterAction;
begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CMIRT1 OnEnterAction');
    if (m_nP.m_sbyEnable=1) and (m_nP.m_sbyModem=1) then
        OpenPhone
    else if m_nP.m_sbyModem=0 then
        FinalAction;
end;

procedure CMIRT1Meter.OnConnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CMIRT1 OnConnectComplette');
    m_nModemState := 1;
    if not((m_blIsRemCrc=True)or(m_blIsRemEco=True)) then
        FinalAction;
End;

procedure CMIRT1Meter.OnDisconnectComplette(var pMsg:CMessage);
Begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CMIRT1 OnDisconnectComplette');
    m_nModemState := 0;
End;

procedure CMIRT1Meter.OnFinalAction;
begin
//    TraceL(2,m_nP.m_swMID,'(__)CL2MD::>CMIRT1 OnFinalAction');
    FinalAction;
end;

{*******************************************************************************
 *  Пакет перед посылкой подлежит обработке механизмом байтстаффинга
 *  При байтстаффинге анализируется каждый байт, и:
 *	0х55 заменяется на 0х73 0х11,
 *	0х73 заменяется на 0х73 0х22.
 ******************************************************************************}
function CMIRT1Meter.ByteStuff(var _Buffer : array of BYTE; _Len : Byte) : Byte;
var
  i, l : integer;
  tArr : array[0..255] of BYTE;
begin
  l := 0;
  FillChar(tArr,254,0);
  for i:=0 to _Len-1 do
  Begin
   if (i=0) then
   Begin
      tArr[l]:=$73;Inc(l);
   End else
   if (i=1) then
   Begin
      tArr[l]:=$55;Inc(l);
   End else
   if (i>1)and(i<=(_Len-1-1)) then
   Begin
     if (_Buffer[i]=$55) then
     Begin
      tArr[l]:=$73;Inc(l);
      tArr[l]:=$11;Inc(l);
     end else
     if (_Buffer[i]=$73) then
     Begin
      tArr[l]:=$73;Inc(l);
      tArr[l]:=$22;Inc(l);
     end else
     Begin
      tArr[l] := _Buffer[i];
      Inc(l);
     End;
   End;
  End;
  Inc(l);
  tArr[l-1] := _Buffer[_Len-1];
  move(tarr,_Buffer,l);
  Result := l;
end;

{*******************************************************************************
 *  Пакет перед посылкой подлежит обработке механизмом байтстаффинга
 *  При байтстаффинге анализируется каждый байт, и:
 *	0х73 0х11 заменяется на 0х55,
 *	0х73 0х22 заменяется на 0х73.
*******************************************************************************}
function CMIRT1Meter.ByteUnStuff(var _Buffer : array of BYTE; _Len : Byte) : Byte;
var
  i, l : integer;
  tArr : array[0..255] of BYTE;
begin
  l := 0;
  i := 0;
  FillChar(tArr,255,0);
  while i<_Len do
  begin
    if (i=0) then
    Begin
     tArr[l] := $73;Inc(l);Inc(i);
    End else
    if (i=1) then
    Begin
     tArr[l] := $55;Inc(l);Inc(i);
    End else
   if (i>1)and(i<=(_Len-1-1)) then
    Begin
    if ((_Buffer[i] = $73) AND (_Buffer[i + 1] = $11)) then
    begin
      tArr[l] := $55;
      Inc(l);Inc(i);Inc(i);
    end else if ((_Buffer[i] = $73) AND (_Buffer[i + 1] = $22)) then
    begin
      tArr[l] := $73;
      Inc(l);Inc(i);Inc(i);
    end else
    Begin
      tArr[l] := _Buffer[i];
      Inc(l);
      Inc(i);
    End;
   End else
    Begin
      tArr[l] := _Buffer[i];
      Inc(l);
      Inc(i);
    End;
  end;
  //Inc(l);
  //tArr[l-2] := _Buffer[_Len-2];
  move(tarr, _Buffer, l);
  Result := l;
end;


(*******************************************************************************
 * Команда "Ping"
 *   Ping	0х01	Распознавание
 * 4 байта:
 *   1 байт - версия протокола;
 *   1 байт - версия прошивки;
 *   2 байта - адрес устройства.
 *
 *   @param var nReq: CQueryPrimitive Примитив запроса
 ******************************************************************************)
procedure CMIRT1Meter.REQ01_OpenSession(var nReq: CQueryPrimitive);
begin
  m_QFNC := $30; // GET_INFO
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CMIRT1Meter.RES01_OpenSession(var pMsg:CMessage);
{var
  l_ProtoVer,
  l_FWVer,
  l_Addr : WORD;}
begin
  l_ProtoVer := pMsg.m_sbyInfo[13];
  if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'l_ProtoVer= '+IntToStr(l_ProtoVer));
end;

procedure CMIRT1Meter.REQ05_GetEnergySum(var nReq: CQueryPrimitive);
Begin
  m_QTimestamp := Now();
  m_QFNC := $05; // Открыть доступ к счетчику

  //FillMessageBody(m_nTxMsg, m_QFNC, 0);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
end;


procedure CMIRT1Meter.REQ05_GetEnergySum_V2(var nReq: CQueryPrimitive);
Begin
  m_QTimestamp := Now();
  m_QFNC := $05; // Открыть доступ к счетчику

  //FillMessageBody(m_nTxMsg, m_QFNC, 0);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
end;


procedure CMIRT1Meter.REQ05_GetEnergySum_V3(var nReq: CQueryPrimitive);
Begin
  m_QTimestamp := Now();
  m_QFNC := $05; // Открыть доступ к счетчику

  //FillMessageBody(m_nTxMsg, m_QFNC, 0);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
end;


procedure CMIRT1Meter.RES05_GetEnergySum(var pMsg:CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := Now;
  //nSH := 2*m_nRtr;
  l_Config := pMsg.m_sbyInfo[17+nRSH];
  l_DivKoeff := pMsg.m_sbyInfo[18+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[13+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[23 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then
     l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_ENERGY_SUM_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
end;

procedure CMIRT1Meter.RES05_GetEnergySum_V2(var pMsg:CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := Now;
  //nSH := 2*m_nRtr;
  l_Config := pMsg.m_sbyInfo[17+nRSH];
  l_DivKoeff := pMsg.m_sbyInfo[18+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[13+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[23 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then
     l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_ENERGY_SUM_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
end;

procedure CMIRT1Meter.RES05_GetEnergySum_V3(var pMsg:CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := Now;
  //nSH := 2*m_nRtr;
  l_Config := pMsg.m_sbyInfo[17+nRSH];
  l_DivKoeff := pMsg.m_sbyInfo[18+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[13+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[23 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then
     l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_ENERGY_SUM_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
end;

procedure CMIRT1Meter.REQ1C_GetDateTime(var nReq: CQueryPrimitive);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
    m_QTimestamp := Now();
    m_QFNC       := $1D;
    DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
    DecodeDate(m_QTimestamp, Year, Month, Day);
    // BCD
    m_nTxMsg.m_sbyInfo[13+nRSH] := (Sec);
    m_nTxMsg.m_sbyInfo[14+nRSH] := (Min);
    m_nTxMsg.m_sbyInfo[15+nRSH] := (Hour);
    m_nTxMsg.m_sbyInfo[16+nRSH] := DayOfWeek(Now()) - 1;
    m_nTxMsg.m_sbyInfo[17+nRSH] := (Day);
    m_nTxMsg.m_sbyInfo[18+nRSH] := (Month);
    m_nTxMsg.m_sbyInfo[19+nRSH] := (Year - 2000);
    FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 7));
    SendToL1(BOX_L1, @m_nTxMsg);
end;

procedure CMIRT1Meter.RES1C_GetDateTime(var pMsg:CMessage);
var
  nReq : CQueryPrimitive;
  Year,Month,Day,_yy,_mn,_dd,_hh,_mm,_ss  : word;
  Hour,Min  ,Sec,mSec,nKorrTime: word;
  LastDate:TDateTime;
begin

end;

procedure CMIRT1Meter.KorrTime(LastDate : TDateTime);
var Year, Month, Day           : word;
    Hour, Min, Sec, mSec       : word;
begin
//    TraceL(2,m_nRxMsg.m_swObjID,'(__)CMIRT1::>   Korrection Time');
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
    end;
    if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then
    begin
      m_nRxMsg.m_sbyType    := PH_EVENTS_INT;
      m_nRxMsg.m_sbyInfo[0] := 13 + 8;
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

    m_QTimestamp := Now();
    m_QFNC       := $1D;

    DecodeTime(m_QTimestamp, Hour, Min, Sec, mSec);
    DecodeDate(m_QTimestamp, Year, Month, Day);

    // BCD
    m_nTxMsg.m_sbyInfo[13+nRSH] := (Sec);
    m_nTxMsg.m_sbyInfo[14+nRSH] := (Min);
    m_nTxMsg.m_sbyInfo[15+nRSH] := (Hour);
    m_nTxMsg.m_sbyInfo[16+nRSH] := DayOfWeek(Now()) - 1;

    m_nTxMsg.m_sbyInfo[17+nRSH] := (Day);
    m_nTxMsg.m_sbyInfo[18+nRSH] := (Month);
    m_nTxMsg.m_sbyInfo[19+nRSH] := (Year - 2000);

    FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 7));
    SendToL1(BOX_L1, @m_nTxMsg);
//    m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//    TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
    if bl_SaveCrEv then
      StartCorrEv(LastDate);
end;

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
procedure CMIRT1Meter.RES1D_SetDateTime(var pMsg:CMessage);
Var
    byStatus : Byte;
begin
    byStatus := pMsg.m_sbyInfo[12+nRSH];
    if byStatus=$00 then
    Begin
//     TraceL(3, m_nTxMsg.m_swObjID, '(__)CMIRT1::> Время счетчика установлено: ' + DateTimeToStr(Now()));
     m_nP.m_sdtSumKor       := m_nP.m_sdtSumKor + abs(Now - dt_TLD);
     if m_nP.m_sdtSumKor >= m_nP.m_sdtLimKor then m_nP.m_sdtSumKor := m_nP.m_sdtLimKor;
     m_pDB.UpdateTimeKorr(m_nP.m_swMID, m_nP.m_sdtSumKor);
     if bl_SaveCrEv then FinishCorrEv(Now - dt_TLD);
    End else
    Begin
     if byStatus=$01 then  begin end;//TraceL(3, m_nTxMsg.m_swObjID, '(__)CMIRT1::> Попытка записи времени с неверным паролем ') else
     if byStatus=$05 then  begin end;//TraceL(3, m_nTxMsg.m_swObjID, '(__)CMIRT1::> Интерфейс заблокирован ') else
//     TraceL(3, m_nTxMsg.m_swObjID, '(__)CMIRT1::> Ошибка:'+IntToStr(byStatus));
     ErrorCorrEv;
    End;
    m_QFNC:=0;
end;
(*******************************************************************************
 * ReadConfigure
 * 0x10
 * Чтение конфигурации
    Биты 1,0 - положение точки на ЖКИ
    (00-"00000000",  01-"0000000.0",
    10-"000000.00", 11-"00000.000")
 *******************************************************************************)

procedure  CMIRT1Meter.REQ10_ReadConfig(var nReq: CQueryPrimitive);
Begin
  m_QTimestamp := Now();
  m_QFNC := $10; // Конфигурация
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 0));
  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
End;
procedure  CMIRT1Meter.RES10_ReadConfig(var pMsg:CMessage);
Var
   byConfig0 : Byte;
Begin
   byConfig0 := pMsg.m_sbyInfo[13];
End;


procedure CMIRT1Meter.REQ24_Get_Ver;
begin

 if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Попал в REQ24_Get_Ver в процедуру');
 case l_ProtoVer of
     1,2,3,4,6,12,13,17,18,19,21,22,24,25,28,29,40,41,42,43,44,45,46:
           begin
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сработала версия 1');
                case nReq.m_swParamID of
                     QRY_ENERGY_SUM_EP  : REQ05_GetEnergySum(nReq);
                     QRY_NAK_EN_MONTH_EP: REQ24_GetEnergyMonth(nReq);
                     QRY_NAK_EN_DAY_EP  : REQ25_GetEnergyDay(nReq);
                     QRY_DATA_TIME      : REQ1C_GetDateTime(nReq);
                end;
           end;
     7,8,10,11,14,20,26:
           begin
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сработала версия 2');
                case nReq.m_swParamID of
                     QRY_ENERGY_SUM_EP  : REQ05_GetEnergySum(nReq);
                     QRY_NAK_EN_MONTH_EP: REQ24_GetEnergyMonth_V2(nReq);
                     QRY_NAK_EN_DAY_EP  : REQ25_GetEnergyDay_V2(nReq);
                     QRY_DATA_TIME      : REQ1C_GetDateTime(nReq);
                end;
           end;
     9,15,16,23,31,32,33,34,35:
           begin
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сработала версия 3');
                case nReq.m_swParamID of
                     QRY_ENERGY_SUM_EP  : REQ05_GetEnergySum(nReq);
                     QRY_NAK_EN_MONTH_EP: REQ24_GetEnergyMonth_V3(nReq);
                     QRY_NAK_EN_DAY_EP  : REQ25_GetEnergyDay_V3(nReq);
                     QRY_DATA_TIME      : REQ1C_GetDateTime(nReq);
                end;

           end;
 end;
end;

procedure CMIRT1Meter.REQ24_GetRead_Ver(var pMsg : CMessage);
begin
if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Попал в REQ24_Get_Ver в процедуру');
 case l_ProtoVer of
     1,2,3,4,6,12,13,17,18,19,21,22,24,25,28,29,40,41,42,43,44,45,46:
           begin
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сработала версия 1');
               case m_QFNC of // FUNCTION
                    $05 : RES05_GetEnergySum(pMsg);
                    $1C : RES1C_GetDateTime(pMsg);
                    $1D : RES1D_SetDateTime(pMsg);
                    $24 : RES24_GetEnergyMonth(pMsg);
                    $25 : RES25_GetEnergyDay(pMsg);
               end;
           end;
     7,8,10,11,14,20,26:
           begin
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сработала версия 2');
               case m_QFNC of // FUNCTION
                    $05 : RES05_GetEnergySum(pMsg);
                    $1C : RES1C_GetDateTime(pMsg);
                    $1D  : RES1D_SetDateTime(pMsg);
                    $24 : RES24_GetEnergyMonth_V2(pMsg);
                    $25 : RES25_GetEnergyDay(pMsg);
               end;
           end;
     9,15,16,23,31,32,33,34,35:
           begin
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сработала версия 3');
               case m_QFNC of // FUNCTION
                    $05 : RES05_GetEnergySum(pMsg);
                    $1C : RES1C_GetDateTime(pMsg);
                    $1D  : RES1D_SetDateTime(pMsg);
                    $24 : RES24_GetEnergyMonth_V3(pMsg);
                    $25 : RES25_GetEnergyDay(pMsg);
               end;
           end;
 end;
end;

(*******************************************************************************
 * ReadEnergyOnMonth
 * 0x24
 * Чтение значений энергии по тарифам и суммарно, сохраненных на начало текущего и 23 предыдущих месяцев
    2 байта:
      1й байт - месяц;
      2й байт - год.
 *******************************************************************************)
procedure CMIRT1Meter.REQ24_GetEnergyMonth(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $24;
  if (nReq.m_swSpecc2=0) then
  Begin
   dtTemp := Now;
   cDateTimeR.DecMonthEx(nReq.m_swSpecc1,dtTemp);
   DecodeDate(dtTemp,Year,Month,Day);
   nReq.m_swSpecc0 := Year-2000;
   nReq.m_swSpecc1 := Month;
   nReq.m_swSpecc2 := 1;
  End;
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0+2000, nReq.m_swSpecc1, 1);
  m_nTxMsg.m_sbyInfo[13+nRSH] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[14+nRSH] := nReq.m_swSpecc0;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CMIRT1Meter.REQ24_GetEnergyMonth_V2(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $24;
  if (nReq.m_swSpecc2=0) then
  Begin
   dtTemp := Now;
   cDateTimeR.DecMonthEx(nReq.m_swSpecc1,dtTemp);
   DecodeDate(dtTemp,Year,Month,Day);
   nReq.m_swSpecc0 := Year-2000;
   nReq.m_swSpecc1 := Month;
   nReq.m_swSpecc2 := 1;
  End;
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0+2000, nReq.m_swSpecc1, 1);
  m_nTxMsg.m_sbyInfo[14+nRSH] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[15+nRSH] := nReq.m_swSpecc0;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 2));
  FPUT(BOX_L1, @m_nTxMsg);
end;

procedure CMIRT1Meter.REQ24_GetEnergyMonth_V3(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $24;
  if (nReq.m_swSpecc2=0) then
  Begin
   dtTemp := Now;
   cDateTimeR.DecMonthEx(nReq.m_swSpecc1,dtTemp);
   DecodeDate(dtTemp,Year,Month,Day);
   nReq.m_swSpecc0 := Year-2000;
   nReq.m_swSpecc1 := Month;
   nReq.m_swSpecc2 := 1;
  End;
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0+2000, nReq.m_swSpecc1, 1);
  m_nTxMsg.m_sbyInfo[14] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[15] := nReq.m_swSpecc0;
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 3));
  FPUT(BOX_L1, @m_nTxMsg);
end;

(*******************************************************************************
 * 	24 байта:
 *   1 байт - месяц;
 *   1 байт - год;
 *   4 байта - сумма по всем тарифам;
 *   1 байт - конфигурационный байт;
 *   1 байт - коэффициент деления;
 *   16 байт - значения по четырем тарифам (4 байта на тариф начиная с 1го тарифа) на начало необходимого месяца.
 ******************************************************************************)
procedure CMIRT1Meter.RES24_GetEnergyMonth(var pMsg : CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,
  l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0+2000,nReq.m_swSpecc1, 1);
  if (pMsg.m_sbyInfo[12+nRSH]=$06) then
  Begin
   //FinalAction;
   exit;
  End;
  l_Config := pMsg.m_sbyInfo[19+nRSH];
 // l_DivKoeff := pMsg.m_sbyInfo[20+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[15+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[21 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_NAK_EN_MONTH_EP, i, true);
    saveToDB(m_nRxMsg);
  end;
end;


procedure CMIRT1Meter.RES24_GetEnergyMonth_V2(var pMsg : CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,
  l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0+2000,nReq.m_swSpecc1, 1);
  if (pMsg.m_sbyInfo[12+nRSH]=$06) then
  Begin
   exit;
  End;
  l_Config := pMsg.m_sbyInfo[17+nRSH];
 // l_DivKoeff := pMsg.m_sbyInfo[20+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[22+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[26 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_NAK_EN_MONTH_EP, i, true);
    saveToDB(m_nRxMsg);
  end;
end;


procedure CMIRT1Meter.RES24_GetEnergyMonth_V3(var pMsg : CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,
  l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0+2000,nReq.m_swSpecc1, 1);
  if (pMsg.m_sbyInfo[12+nRSH]=$06) then   //Проверка на наличия данных, если нету то заходим и возвращаем true
  Begin
   exit;
  End;
  l_Config := pMsg.m_sbyInfo[17+nRSH];
 // l_DivKoeff := pMsg.m_sbyInfo[20+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[22+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[26 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_NAK_EN_MONTH_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
end;

(*******************************************************************************
 * ReadEnergyOnDay
  0x25
  Чтение значений энергии по тарифам и суммарно, сохраненных на конец суток, за прошедшие  90 суток
  3 байта:
    1й байт - день;
    2й байт - месяц;
    3й байт - год.
 *******************************************************************************)
procedure CMIRT1Meter.REQ25_GetEnergyDay(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $25;
  if (nReq.m_swSpecc1=0) then
  Begin
   dtTemp := Now-nReq.m_swSpecc2;
   DecodeDate(dtTemp,Year,Month,Day);
   nReq.m_swSpecc0 := Year-2000;
   nReq.m_swSpecc1 := Month;
   nReq.m_swSpecc2 := Day;
  End;
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0 + 2000, nReq.m_swSpecc1, nReq.m_swSpecc2);
  m_nTxMsg.m_sbyInfo[13+nRSH] := nReq.m_swSpecc2;
  m_nTxMsg.m_sbyInfo[14+nRSH] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[15+nRSH] := nReq.m_swSpecc0;

  //FillMessageBody(m_nTxMsg, m_QFNC, 3);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 3));

  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
end;


procedure CMIRT1Meter.REQ25_GetEnergyDay_V2(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $25;
  if (nReq.m_swSpecc1=0) then
  Begin
   dtTemp := Now-nReq.m_swSpecc2;
   DecodeDate(dtTemp,Year,Month,Day);
   nReq.m_swSpecc0 := Year-2000;
   nReq.m_swSpecc1 := Month;
   nReq.m_swSpecc2 := Day;
  End;
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0 + 2000, nReq.m_swSpecc1, nReq.m_swSpecc2);
  m_nTxMsg.m_sbyInfo[13+nRSH] := nReq.m_swSpecc2;
  m_nTxMsg.m_sbyInfo[14+nRSH] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[15+nRSH] := nReq.m_swSpecc0;

  //FillMessageBody(m_nTxMsg, m_QFNC, 3);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 3));

  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
end;

procedure CMIRT1Meter.REQ25_GetEnergyDay_V3(var nReq: CQueryPrimitive);
Var
  Year,Month,Day : Word;
  dtTemp : TDateTime;
begin
  m_QFNC := $25;
  if (nReq.m_swSpecc1=0) then
  Begin
   dtTemp := Now-nReq.m_swSpecc2;
   DecodeDate(dtTemp,Year,Month,Day);
   nReq.m_swSpecc0 := Year-2000;
   nReq.m_swSpecc1 := Month;
   nReq.m_swSpecc2 := Day;
  End;
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0 + 2000, nReq.m_swSpecc1, nReq.m_swSpecc2);
  m_nTxMsg.m_sbyInfo[13+nRSH] := nReq.m_swSpecc2;
  m_nTxMsg.m_sbyInfo[14+nRSH] := nReq.m_swSpecc1;
  m_nTxMsg.m_sbyInfo[15+nRSH] := nReq.m_swSpecc0;

  //FillMessageBody(m_nTxMsg, m_QFNC, 3);
  FillMessageHead(m_nTxMsg, FillMessageBody(m_nTxMsg, m_QFNC, 3));

  FPUT(BOX_L1, @m_nTxMsg);
//  m_nRepTimer.OnTimer(m_nP.m_swRepTime);
//  TraceM(2, m_nTxMsg.m_swObjID,'(__)CMIRT1::>Out DRQ:',@m_nTxMsg);
end;


procedure CMIRT1Meter.RES25_GetEnergyDay(var pMsg : CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,
  l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0 + 2000, nReq.m_swSpecc1, nReq.m_swSpecc2);
  l_Config := pMsg.m_sbyInfo[20+nRSH];
  //l_DivKoeff := pMsg.m_sbyInfo[21+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[16+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[22 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_NAK_EN_DAY_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
//  FinalAction();
end;


procedure CMIRT1Meter.RES25_GetEnergyDay_V2(var pMsg : CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,
  l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0 + 2000, nReq.m_swSpecc1, nReq.m_swSpecc2);
  l_Config := pMsg.m_sbyInfo[20+nRSH];
  //l_DivKoeff := pMsg.m_sbyInfo[21+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[16+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[22 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_NAK_EN_DAY_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
//  FinalAction();
end;


procedure CMIRT1Meter.RES25_GetEnergyDay_V3(var pMsg : CMessage);
var
  l_Data : array[0..5] of Extended;
  dbDivKoeff : Extended;
  l_DWData : DWORD;
  l_DivKoeff,
  l_Config : Byte;
  i : Integer;
begin
  m_QTimestamp := EncodeDate(nReq.m_swSpecc0 + 2000, nReq.m_swSpecc1, nReq.m_swSpecc2);
  l_Config := pMsg.m_sbyInfo[20+nRSH];
  //l_DivKoeff := pMsg.m_sbyInfo[21+nRSH];
  dbDivKoeff:=1.0;
  if (l_Config and $30)=$00 then dbDivKoeff:=1.0 else
  if (l_Config and $30)=$10 then dbDivKoeff:=10.0 else
  if (l_Config and $30)=$20 then dbDivKoeff:=100.0 else
  if (l_Config and $30)=$30 then dbDivKoeff:=1000.0;

  move(pMsg.m_sbyInfo[16+nRSH], l_DWData, 4);
  l_Data[0] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;

  for i:=0 to 3 do
  begin
    move(pMsg.m_sbyInfo[22 + i*4+nRSH], l_DWData, 4);
    l_Data[1 + i] := l_DWData / dbDivKoeff * m_nP.m_sfKI * m_nP.m_sfKU * m_nP.m_sfMeterKoeff;
  end;

  for i:=0 to 4 do
  begin
    if (pMsg.m_sbyInfo[12+nRSH]=$06) then l_Data[i] := 0;
    FillSaveDataMessage(l_Data[i], QRY_NAK_EN_DAY_EP, i, true);
    saveToDB(m_nRxMsg);//FPUT(BOX_L3_BY, @m_nRxMsg);
  end;
//  FinalAction();
end;

procedure CMIRT1Meter.ADD_Energy_Sum_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CMIRT1Meter.ADD_Events_GraphQry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_JRNL_T3, 0, 0, 0, 1);
end;


{*******************************************************************************
 * Формирование задания на считывание события
 ******************************************************************************}
procedure CMIRT1Meter.ADD_DateTime_Qry();
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_DATA_TIME, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание
 ******************************************************************************}
procedure CMIRT1Meter.ADD_NakEnergyMonth_Qry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,Month,Day : Word;
begin
   m_nObserver.AddGraphParam(QRY_AUTORIZATION,0,0,0,1);
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
     cDateTimeR.IncMonth(TempDate);
     DecodeDate(TempDate,Year,Month,Day);
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Month ('+IntToStr(Month)+')...');
     m_nObserver.AddGraphParam(QRY_NAK_EN_MONTH_EP,Year-2000,Month,1,1);
     cDateTimeR.DecMonth(dt_Date2);
   end;
end;
procedure CMIRT1Meter.ADD_NakEnergyDay_Qry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i           : integer;
    Year,Month,Day : Word;
begin
m_nObserver.AddGraphParam(QRY_AUTORIZATION,0,0,0,1);
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
       if i < -40 then
         exit;
     end;
     cDateTimeR.IncDate(TempDate);
     DecodeDate(dt_Date1,Year,Month,Day);
     m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, Year-2000,Month,Day,  1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

procedure CMIRT1Meter.ADD_CurrPower_Qry(_DTS, _DTE : TDateTime);
begin
  m_nObserver.ClearGraphQry();
  m_nObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
  m_nObserver.AddGraphParam(QRY_NAK_EN_DAY_EP, 0, 0, 0, 1);
end;

{*******************************************************************************
 * Формирование задания на считывание получасовых срезов
    @param DTS  TDateTime Начало периода
    @param DTE  TDateTime Окончание периода
 ******************************************************************************}
procedure CMIRT1Meter.ADD_SresEnergyDay_GraphQry(dt_Date1, dt_Date2 : TDateTime);
var TempDate    : TDateTime;
    i,j         : integer;
    Year,Month,Day : Word;
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
       Dec(i);
       if i < -40 then
         exit;
     end;
     cDateTimeR.IncDate(TempDate);
     DecodeDate(dt_Date1,Year,Month,Day);
     for j:=6 downto 0 do
     m_nObserver.AddGraphParam(QRY_SRES_ENR_EP, Year-2000,Month,Day or (j shl 8) ,  1);
     cDateTimeR.DecDate(dt_Date2);
   end;
end;

End.
