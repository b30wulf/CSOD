unit knsl3setgsmtime;

interface
uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,ComCtrls,utltypes
    ,knsl5tracer, Dates,utlbox, utlTimeDate,math,utldatabase,RASUnit,utlmtimer,utlconst,WinSvc;
type
    THandles = packed record
     m_sProcHandle   : THandle;
     m_sTHreadHandle : THandle;
    End;

    CSetGsmTime = class
    private
     FlbSExpired        : PTStaticText;
     m_pPortTBL         : SL1TAG;
     m_pTable           : PSGENSETTTAG;
     m_strCurrentDir    : String;
     m_nWDellServManager: CTimer;
     m_nWConnTimer      : CTimer;
     m_nWFreeTimer      : CTimer;
     m_nWDiscTimer      : CTimer;
     m_nWOpenTimer      : CTimer;
     m_nChSpeedTimer      : CTimer;
     LastTime           : TDateTime;
     dtLastTime         : TDateTime;
     m_blOpenSession    : Boolean;
     m_nSSTime          : Integer;
     m_nSSSpeed         : Integer;
     m_nProgHandle      : THandles;
     function StartProcess(strPath:String;blWait:Boolean):Boolean;
     function StartProcessEx(strPath:String;blWait,blClose:Boolean):THandles;
     function Connect(strJoinName:String):Boolean;
     function Disconnect:Boolean;
     function ServiceStart(aMachine, aServiceName: string ): boolean;
     function ServiceStop(aMachine,aServiceName: string ): boolean;
     function ServiceGetStatus(sMachine, sService: string ): DWord;
     procedure TermProc;
     procedure OnPreparePortSett;
     procedure OnDefaultPortSett;
     procedure PostPrepare;

    public
     m_blIsConnected : Boolean;
     m_blIsNoSynchro : Boolean;
     procedure SendCommand(strComm:String);
     procedure Init(pTable:PSGENSETTTAG);
     destructor Destroy; override;
     procedure SettTime;
     procedure OpenSession(nTimeSec,nSpeed:Integer);
     procedure QweryOpenSession(nTimeSec,nSpeed:Integer);
     procedure Run;
     function  EventHandler(var pMsg : CMessage):Boolean;
     function  SelfHandler(var pMsg:CMessage):Boolean;
     procedure OnStartSynchro;
     procedure OnDisconnect;
     procedure OnConnect;
     procedure ChandgeSessionTime(nTimeSec:Integer);
    Public
     property PlbSExpired     :PTStaticText read FlbSExpired     write FlbSExpired;
    End;
    TMyDialParam = Record
     AMsg:Integer;
     AState:TRasConnState;
     AError:Integer;
    End;
Var
    hRas         : ThRASConn;
    MyDialParam  : TMyDialParam;
    m_nGLST      : CSetGsmTime;
   
const
    WAIT_SYNCHRONIZE = 83;
    //WAIT_SYNCHRONIZE = 40;
implementation

Function GetStatusString(State: TRasConnState; Error: Integer): String;
Var
     C      : Array[0..100] of Char;
     S      : String;
Begin
     If Error<>0 then
     Begin
      RasGetErrorString(Error, C, 100);
      if Length(C)<30 then Result:=C else Result:='Error!';
     End Else
     Begin
      S:='';
       Case State Of
        RASCS_OpenPort:
         S:='Opening port';
        RASCS_PortOpened:
         S:='Port opened';
        RASCS_ConnectDevice:
         S:='Connecting device';
        RASCS_DeviceConnected:
         S:='Device connected';
        RASCS_AllDevicesConnected:
         S:='All devices connected';
        RASCS_Authenticate:
         S:='Start authenticating';
        RASCS_AuthNotify:
         S:='Authentication: notify';
        RASCS_AuthRetry:
         S:='Authentication: retry';
        RASCS_AuthCallback:
         S:='Authentication: callback';
        RASCS_AuthChangePassword:
         S:='Authentication: change password';
        RASCS_AuthProject:
         S:='Authentication: projecting';
        RASCS_AuthLinkSpeed:
         S:='Authentication: link speed';
        RASCS_AuthAck:
         S:='Authentication: acknowledge';
        RASCS_ReAuthenticate:
         S:='Authentication: reauthenticate';
        RASCS_Authenticated:
         S:='Authenticated';
        RASCS_PrepareForCallback:
         S:='Preparing for callback';
        RASCS_WaitForModemReset:
         S:='Waiting for modem reset';
        RASCS_WaitForCallback:
         S:='Waiting for callback';
        RASCS_Projected:
         S:='Projected';
        RASCS_StartAuthentication:
         S:='Start authentication';
        RASCS_CallbackComplete:
         S:='Callback complete';
        RASCS_LogonNetwork:
         S:='Logging on network';
        RASCS_Interactive:
         S:='Interactive';
        RASCS_RetryAuthentication:
         S:='Retry Authentication';
        RASCS_CallbackSetByCaller:
         S:='Callback set by caller';
        RASCS_PasswordExpired:
         S:='Password expired';
        RASCS_Connected:
         S:='Connected';
        RASCS_Disconnected:
        begin
         S:='Disconnected';
        end;
         else
         S:='No Complette...';
      End;
     Result:=S;
     End;
End;
Procedure RasCallback(msg: Integer; state: TRasConnState;error: Integer); stdcall;
Begin
     MyDialParam.AMsg:=msg;
     MyDialParam.AState:=state;
     MyDialParam.AError:=error;
     //m_nGLST.PlbSetTmState.Caption:=GetStatusString(MyDialParam.AState,MyDialParam.AError);
     if MyDialParam.AState=RASCS_Connected then
     Begin
      SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
      SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_CONN_IND);
      m_nGLST.OnStartSynchro;
      m_nGLST.m_blIsConnected := True;
     End;
//     m_nGLST.PlbSetTmState.Update;
End;

destructor CSetGsmTime.Destroy;
begin
  if m_nChSpeedTimer <> nil then FreeAndNil(m_nChSpeedTimer);
  if m_nWOpenTimer <> nil then FreeAndNil(m_nWOpenTimer);
  if m_nWDiscTimer <> nil then FreeAndNil(m_nWDiscTimer);
  if m_nWFreeTimer <> nil then FreeAndNil(m_nWFreeTimer);
  if m_nWConnTimer <> nil then FreeAndNil(m_nWConnTimer);
  if m_nWDellServManager <> nil then FreeAndNil(m_nWDellServManager);

  inherited;
end;

procedure CSetGsmTime.Init(pTable:PSGENSETTTAG);
Begin
     m_nGLST               := self;
     m_pTable              := pTable;
     FillChar(MyDialParam,SizeOf(MyDialParam),0);
     m_strCurrentDir       := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     //bSetTmState.Caption := m_pTable.m_sMdmJoinName;
     m_nWConnTimer := CTimer.Create;
     m_nWConnTimer.SetTimer(DIR_L3TOL3,DL_GSM_SET_TMR,0,0,BOX_L3);
     m_nWFreeTimer := CTimer.Create;
     m_nWFreeTimer.SetTimer(DIR_L3TOL3,DL_GSM_FRE_TMR,0,0,BOX_L3);
     m_nWDiscTimer := CTimer.Create;
     m_nWDiscTimer.SetTimer(DIR_L3TOL3,DL_GSM_DSC_TMR,0,0,BOX_L3);
     m_nWDellServManager := CTimer.Create;
     m_nWDellServManager.SetTimer(DIR_L3TOL3,DL_GSM_DEL_SRV_TMR,0,0,BOX_L3);
     m_nChSpeedTimer := CTimer.Create;
     m_nChSpeedTimer.SetTimer(DIR_L3TOL3,DL_GSM_CHSP_TMR,0,0,BOX_L3);
     m_nWOpenTimer := CTimer.Create;
     m_nWOpenTimer.SetTimer(DIR_L3TOL3,DL_GSM_WOPEN_TMR,0,0,BOX_L3);
     m_pPortTBL.m_sbyPortID := m_pTable.m_sChannSyn;
     m_pDB.GetPortTable(m_pPortTBL);
     //m_nWConnTimer.OnTimer(30);
End;
function CSetGsmTime.EventHandler(var pMsg : CMessage):Boolean;
Begin
     try
     Result:=False;
     case pMsg.m_sbyFor of
      DIR_L3TOL3    : SelfHandler(pMsg);
      //DIR_L2TOL3    : LoHandler(pMsg);
      //DIR_L4TOL3    : HiHandler(pMsg);
     End;
     except
      Result:=True;
      //TraceER('(__)CERMD::>Error In CL3Module.EventHandler!!!');
     End;
End;
function CSetGsmTime.SelfHandler(var pMsg:CMessage):Boolean;
var status : DWORD;
Begin
  try
    Result:=False;
     case pMsg.m_sbyType of
      DL_GSM_SET_TMR:
      Begin
       //TraceL(3,pMsg.m_swObjID,'(__)CSGTM::>DL_GSM_SET_TMR:');
       //m_pDB.UpdateKorrMonth(abs(Now - dtLastTime) - EncodeTime(0, 0, 1, 0)*WAIT_SYNCHRONIZE);
       //m_pDB.FixUspdEvent(0,0,EVH_FINISH_CORR);

       Disconnect;
      End;
      DL_GSM_FRE_TMR:
      Begin
       //TraceL(3,pMsg.m_swObjID,'(__)CSGTM::>DL_GSM_FRE_TMR:');
       if m_pTable.m_sbyAllowInDConn = 0 then
       Begin
         //if m_blOpenSession=True then OnPreparePortSett;
         Connect(m_pTable.m_sMdmJoinName);
       End
       else
       begin
         ServiceStop('', 'RemoteAccess');
         m_nWDellServManager.OnTimer(7);
       end;
      End;
      DL_GSM_DSC_TMR:
      Begin
       //TraceL(3,pMs   g.m_swObjID,'(__)CSGTM::>DL_GSM_FRE_TMR:');
//       if (m_blIsConnected=False)and(m_blIsLocal<>False) then PlbSetTmState.Caption := 'Error! Fail Connection...';
       m_blIsConnected := False;
       SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_DISC_IND);
       if m_pTable.m_sbyAllowInDConn = 1 then
         ServiceStart('', 'RemoteAccess')
       else
       begin
          OnDefaultPortSett;
         //if m_blOpenSession=True then OnDefaultPortSett;
         //SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETT_PORT_IND);
         //SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETT_PORT_IND);
       end;
       if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_FINALCORR_REQ));
      End;
      DL_GSM_DEL_SRV_TMR:
      Begin          //Жду окончания остановки службы
        status := ServiceGetStatus('','RemoteAccess');
        if status = SERVICE_STOPPED then
        begin
          Connect(m_pTable.m_sMdmJoinName);
         // m_nWDiscTimer.OffTimer;
        end;
      End;
      DL_GSM_CHSP_TMR: PostPrepare;
      DL_GSM_WOPEN_TMR: OpenSession(m_nSSTime,m_nSSSpeed);

     End;
  except
     Result:=True;
  end;
End;

function CSetGsmTime.ServiceStart(aMachine, aServiceName: string ): boolean;
// aMachine это UNC путь, либо локальный компьютер если пусто
var
  h_manager,h_svc: SC_Handle;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWord;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName),
    SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc,0,temp)) then
        if (QueryServiceStatus(h_svc,svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            //Sleep(svc_status.dwWaitHint);
            if (not QueryServiceStatus(h_svc,svc_status)) then
              break;
            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              // QueryServiceStatus не увеличивает dwCheckPoint
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;

function CSetGsmTime.ServiceStop(aMachine,aServiceName: string ): boolean;
// aMachine это UNC путь, либо локальный компьютер если пусто
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  dwCheckPoint: DWord;
begin
  h_manager:=OpenSCManager(PChar(aMachine),nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(aServiceName),
    SERVICE_STOP or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP, svc_status))then
      begin
        if(QueryServiceStatus(h_svc,svc_status))then
        begin
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            //Sleep(svc_status.dwWaitHint);
            if(not QueryServiceStatus(h_svc,svc_status))then
            begin
              // couldn't check status
              break;
            end;
            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;
          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
//  m_nGLST.PlbSetTmState.Caption := 'Остановка службы...';
end;

//Чтобы узнать состояние сервиса, используйте следующую функцию: 
function CSetGsmTime.ServiceGetStatus(sMachine, sService: string ): DWord;
var
  h_manager, h_svc: SC_Handle;
  service_status: TServiceStatus;
  hStat: DWord;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine) ,nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(sService), SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(QueryServiceStatus(h_svc, service_status)) then
        hStat := service_status.dwCurrentState;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := hStat;
end;
function CSetGsmTime.Connect(strJoinName:String):Boolean;
Var
     res        : Boolean;
     Fp         : LongBool;
     R          : Integer;
     C          : Array[0..100] of Char;
     DialParams : TRasDialParams;
Begin
     res := False;
     try
      hRas :=0;
      if m_blOpenSession=False then
      Begin
       if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTCORR_REQ));
       if m_blIsNoSynchro=False then
       begin
        m_nWConnTimer.OnTimer(WAIT_SYNCHRONIZE);
        dtLastTime := Now;
       // m_pDB.FixUspdEvent(0,0,EVH_START_CORR);
        m_pDB.EventFlagCorrector := EVH_COR_TIME_AUTO;
       end;
      End;
      RasHangUp(hRas);
      FillChar(DialParams, SizeOf(TRasDialParams), 0);
      With DialParams Do
       Begin
       dwSize:=Sizeof(TRasDialParams);
       StrPCopy(szEntryName, strJoinName);
      End;
      R:=RasGetEntryDialParams(Nil, DialParams, Fp);
       If R=0 Then
       Begin
        Application.ProcessMessages;
        R:=RasDial(Nil, Nil, DialParams, 0, @RasCallback, hRAS);
        If R<>0 Then
        Begin
         RasGetErrorString(R,C,100);
//         if m_blIsConnected=True  then PlbSetTmState.Caption := 'Error! '+C else
//         if m_blIsConnected=False then PlbSetTmState.Caption := 'Error! Fail Connection';
        End;
       End;
     except
       TraceER('(__)CSGTM::>Error In CSetGsmTime.Connect!!!');
     end;
     Result := Res;
End;
function CSetGsmTime.Disconnect:Boolean;
Var
     res : Boolean;
Begin
     res := True;
     if m_pTable.m_sUseModem=1 then
     Begin
      //m_blIsConnected := False;
      if RasHangUp(hRas)=0 Then
      Begin
//       PlbSetTmState.Caption:='Disconnected...';
       hRas :=0;
      End;
      m_nWDiscTimer.OnTimer(4);
     End else
//     if m_pTable.m_sUseModem=0 then
//     PlbSetTmState.Caption:='Synchronize Complette...';
     if m_blOpenSession=False then SendMsg(BOX_L2,0,DIR_LMTOL2,DL_SYSCHPREPARE_IND);
    // m_pDB.FixUspdEventCorrector(COR_TIME_AUTO,Description); //EVENT

     Result := Res;
End;


procedure CSetGsmTime.SettTime;
Begin
     m_blIsNoSynchro := False;
     if m_pTable.m_sInterSet=1 then
     Begin
      //m_blIsConnected := False;
      if (m_pTable.m_sUseModem=1)and(m_blIsConnected=False) then
      Begin
       m_blOpenSession := False;
       m_nSSSpeed := m_nInterSpeed;
       OnPreparePortSett;
       SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_FREE_PORT_IND);
       m_nWFreeTimer.OnTimer(3);
      End else
      if m_pTable.m_sUseModem=0 then
      Begin
       m_nWConnTimer.OnTimer(trunc(WAIT_SYNCHRONIZE/2));OnStartSynchro;
      End;

      m_nMSynchKorr.m_blEnable := True;
     End;
End;
procedure CSetGsmTime.OpenSession(nTimeSec,nSpeed:Integer);
Begin
     if (m_blIsConnected=False) then
     Begin
      m_nSSTime       := nTimeSec;
      m_nSSSpeed      := nSpeed;
      OnPreparePortSett;
      m_blIsConnected := False;
      m_blOpenSession := True;
      m_nWConnTimer.OnTimer(nTimeSec);
      SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_FREE_PORT_IND);
      m_nWFreeTimer.OnTimer(3);
     End;
End;
procedure CSetGsmTime.QweryOpenSession(nTimeSec,nSpeed:Integer);
Begin
     m_nSSTime       := nTimeSec;
     m_nSSSpeed      := nSpeed;
     m_nWOpenTimer.OnTimer(10);
End;

procedure CSetGsmTime.ChandgeSessionTime(nTimeSec:Integer);
Begin
     m_nWConnTimer.OnTimer(nTimeSec);
End;

procedure CSetGsmTime.OnConnect;
Begin
     m_blIsNoSynchro := True;
     m_blIsConnected := False;
     m_blOpenSession := False;
     //m_nSSSpeed      := m_nInternetSpeed;
     SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_FREE_PORT_IND);
     m_nWFreeTimer.OnTimer(3);
End;

procedure CSetGsmTime.OnStartSynchro;
Begin
     if m_blOpenSession=False then
     Begin
      if m_blIsNoSynchro=False then
      Begin
       LastTime:=Now;
       StartProcess(m_strCurrentDir+'corrtm.bat',False);
      End;
     End else
     if m_blOpenSession=True then
     Begin
      //m_nProgHandle := StartProcessEx(m_strCurrentDir+'AA_v3.exe',False,False);
     End;
End;
procedure CSetGsmTime.OnDisconnect;
Begin
     m_blIsNoSynchro := False;
     m_nWConnTimer.OffTimer;
     FlbSExpired.Caption := '0';
     m_blIsConnected := False;
     Disconnect;
End;

procedure CSetGsmTime.OnPreparePortSett;
Begin
     {
     if m_nSSSpeed<>m_pPortTBL.m_sbySpeed then
     Begin
      SendCommand('AT+IPR='+m_nSpeedList.Strings[m_nSSSpeed]);
     End;
     }
End;
procedure CSetGsmTime.OnDefaultPortSett;
//Var
   //  pDS : CMessageData;
   //  sPT : SL1SHTAG;
   //  pTable:SL1TAG;
Begin
     //SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_RESET_PORT_IND);
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
     SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETT_PORT_IND);
     //Открыть порт на новой скорости
     //sPT.m_sbySpeed := m_nSSSpeed;
     //Move(sPT,pDS.m_sbyInfo[0],sizeof(SL1SHTAG));
     //SendMsgIData(BOX_L1,0,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_OPEN_PORT_IND,pDS);
     ////SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_RESET_PORT_IND);
     //AT&FE0V1X1&D2&C1S0=0
     {
     if m_nSSSpeed<>m_pPortTBL.m_sbySpeed then
     Begin
      sPT.m_sbySpeed    := m_nSSSpeed;
      sPT.m_sbyParity   := m_pPortTBL.m_sbyParity;
      sPT.m_sbyData     := m_pPortTBL.m_sbyData;
      sPT.m_sbyStop     := m_pPortTBL.m_sbyStop;
      sPT.m_swDelayTime := m_pPortTBL.m_swDelayTime;
      Move(sPT,pDS.m_sbyInfo[0],sizeof(SL1SHTAG));
      SendMsgIData(BOX_L1,0,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETPORT_IND,pDS);
      SendCommand('atz');
      SendCommand('ats0=2');
      SendCommand('at&c0');
      SendCommand('at&d0');
      SendCommand('atq0');
      SendCommand('at+ipr='+m_nSpeedList.Strings[m_pPortTBL.m_sbySpeed]);
     End;
     }
     m_nChSpeedTimer.OnTimer(4);
     {
     SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETDEFSET_IND);
     SendCommand('ATZ');
     SendCommand('ATS0=2');
     SendCommand('AT&C0');
     SendCommand('AT&D0');
     SendCommand('ATQ0');
     SendCommand('ATH');
     }
End;
procedure CSetGsmTime.PostPrepare;
Begin
     {
     if m_nSSSpeed<>m_pPortTBL.m_sbySpeed then
     Begin
      SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETDEFSET_IND);
     End else
     }
     //SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
     SendPMSG(BOX_L1,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_SETT_PORT_IND);
     {
     SendCommand('ATZ');
     SendCommand('ATS0=2');
     SendCommand('AT&C0');
     SendCommand('AT&D0');
     SendCommand('ATQ0');
     SendCommand('ATH');
     }
End;
procedure CSetGsmTime.SendCommand(strComm:String);
Var
    pDS  : CMessageData;
    nLen : Integer;
    i : Integer;
Begin
    nLen := Length(strComm)+1;
    pDS.m_swData0 := nLen-1;
    if nLen<50 then
    Begin
     for i:=0 to nLen-1 do pDS.m_sbyInfo[i] := Byte(strComm[i+1]);
     pDS.m_sbyInfo[nLen] := Byte(#0);
     SendMsgIData(BOX_L1,0,m_pTable.m_sChannSyn,DIR_L2TOL1,PH_COMM_IND,pDS);
    End;
End;
function CSetGsmTime.StartProcess(strPath:String;blWait:Boolean):Boolean;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     si.cb := sizeof(si);
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, NORMAL_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      TraceL(4,0,':Process is not created');
      result := FALSE;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,10*60*1000);
      if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     CloseHandle( pi.hProcess );
     CloseHandle( pi.hThread );
     result := True;
end;
procedure CSetGsmTime.TermProc;
Begin
    //TraceM(6,0,'(__)CSHEL::>TermProc: ',@pMsg);
    try
     if m_nProgHandle.m_sProcHandle<>0 then
     Begin
      TerminateProcess(m_nProgHandle.m_sProcHandle,1);
      CloseHandle(m_nProgHandle.m_sProcHandle);
      CloseHandle(m_nProgHandle.m_sTHreadHandle);
      m_nProgHandle.m_sProcHandle := 0;
      m_nProgHandle.m_sTHreadHandle := 0;
     End;
    except
     //TraceL(6,0,'(__)CERROR::>Error In CShellAutomat.TermProc!!!');
    end
End;
function CSetGsmTime.StartProcessEx(strPath:String;blWait,blClose:Boolean):THandles;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
     pp : THandles;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     FillChar(pp,sizeof(pp),0);
     si.cb := sizeof(si);
     si.wShowWindow:=SW_HIDE;
     si.dwFlags:= STARTF_USESHOWWINDOW;
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, HIGH_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      //TraceL(4,0,':Process is not created');
      result := pp;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,60*1000);
      //if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     if blClose=True then
     Begin
      CloseHandle( pi.hProcess );
      CloseHandle( pi.hThread );
     End;
     pp.m_sProcHandle   := pi.hProcess;
     pp.m_sTHreadHandle := pi.hThread;
     result := pp;
end;
procedure CSetGsmTime.Run;
Begin
     m_nWConnTimer.RunTimer;
     m_nWFreeTimer.RunTimer;
     m_nWDiscTimer.RunTimer;
     m_nWDellServManager.RunTimer;
     m_nChSpeedTimer.RunTimer;
     m_nWOpenTimer.RunTimer;
     if FlbSExpired<>Nil then FlbSExpired.Caption := IntToStr(m_nWConnTimer.GetState);
End;
end.
