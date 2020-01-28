unit knsl1gprsrouter;
//{$DEFINE GPRS_DEBUG}
interface
uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,ComCtrls,utltypes,utlconst,
    utldatabase,extctrls,utlmtimer,inifiles,knsl5tracer,knsl3EventBox,RASUnit,WinSvc,utlbox,knsl2qwerytmr,
    IdIcmpClient,knsl3discret,syncobjs;
type
     TMyDialParam = packed Record
      AMsg:Integer;
      AState:TRasConnState;
      AError:Integer;
     End;
     CGprsRouter = class(CTimeMDL)
     private
      m_blOpenSession : Boolean;
      m_blIsConnected : Boolean;
      m_blQweryReconnect : Boolean;
      m_nSSTime       : Integer;
      m_nPingCt       : Integer;
      m_nWConnTimer   : CTimer;
      m_nWOpenTimer   : CTimer;
      m_nWDiscTimer   : CTimer;
      m_nWDisc2Timer  : CTimer;
      m_nWCheckTimer  : CTimer;
      m_nPreDiscTimer : CTimer;
      m_nPingTimer    : CTimer;
      m_nPingRepTimer : CTimer;
      m_nRstTimer     : CTimer;
      m_nMdmRestart   : CTimer;
      m_nWDiscMdmTimer: CTimer;
      m_nWClosePort   : CTimer;
      m_nPing         : TIdIcmpClient;

      m_strIPAddr      : String;
      m_nPingPeriod    : Integer;
      m_nPingPeriodMsec: Integer;
      m_nPingRepPeriod : Integer;
      m_nRstPeriod     : Integer;
      m_nIsRestart     : Integer;
      m_nIsMdmResPulce : Integer;
      m_nGDIO          : CDiscret;
      m_nGPIOPin       : Integer;
      m_nResCMD        : String;
      hRas            : ThRASConn;
      procedure OnExpired; override;
      function Connect(strJoinName:String):Boolean;
      procedure SendCommand(strComm:String);
      function Disconnect:Boolean;
      function Disconnect2:Boolean;
      function Disconnect3:Boolean;
      function MdmSoftRestart:Boolean;
      function MdmClosePort:Boolean;
      function PreDisconnect:Boolean;
      function IsConnect:Boolean;
      function SelfHandler(var pMsg:CMessage):Boolean;
      procedure OpenSession(nTimeSec:Integer);
      procedure PostClose;
      procedure CheckConnection;
      procedure OnPingRes(ASender:TComponent;const AReplyStatus:TReplyStatus);
      function  LoadSettings:SQWERYMDL;
      procedure Ping;
      procedure GoPingProc;
      procedure Restart;
      procedure MdmHardRestart;
      procedure InitGpio;
     public
      constructor Create;
      destructor Destroy;override;
      function EventHandler(var pMsg:CMessage):Boolean;
      procedure QweryOpenSession(nTimeSec:Integer);
      procedure ChandgeSessionTime(nTimeSec:Integer);
      procedure Init(pTbl:PSL1TAG);
      procedure OnConnect;
      procedure OnClose;
      procedure OnRouterInit;
      procedure Run;
      function Start:Boolean;
      function Stop:Boolean;
      procedure StopEx;
    Public
      m_pTbl          : PSL1TAG;
     End;
Var
      MyDialParam  : array[0..MAX_GPRS] of TMyDialParam;
      m_nGPRS      : array[0..MAX_GPRS] of CGprsRouter;
implementation
constructor CGprsRouter.Create;
Begin
End;
destructor CGprsRouter.Destroy;
Begin
      StopEx;
      if (m_nIsRestart<>0) then MdmHardRestart;
      m_nWConnTimer.Destroy;
      m_nWOpenTimer.Destroy;
      m_nWDiscTimer.Destroy;
      m_nWDisc2Timer.Destroy;
      m_nWCheckTimer.Destroy;
      m_nPreDiscTimer.Destroy;
      m_nPingTimer.Destroy;
      m_nRstTimer.Destroy;
      m_nPingRepTimer.Destroy;
      m_nMdmRestart.Destroy;
      m_nWDiscMdmTimer.Destroy;
      m_nWClosePort.Destroy;
      m_nGDIO.Destroy;
      if sDSCS <> nil then FreeAndNil(sDSCS);
End;
procedure CGprsRouter.Init(pTbl:PSL1TAG);
Begin
     m_pTbl := pTbl;
     if m_nWConnTimer=Nil then m_nWConnTimer := CTimer.Create;
     m_nWConnTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_SET_TMR,0,m_pTbl.m_swAddres,BOX_L1);
     if m_nWOpenTimer=Nil then m_nWOpenTimer := CTimer.Create;
     m_nWOpenTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_WOPEN_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nWDiscTimer=Nil then m_nWDiscTimer := CTimer.Create;
     m_nWDiscTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_DSC_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nWDisc2Timer=Nil then m_nWDisc2Timer := CTimer.Create;
     m_nWDisc2Timer.SetTimer(DIR_L1TOGPRS,DL_GSM_DSC2_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nWCheckTimer=Nil then m_nWCheckTimer := CTimer.Create;
     m_nWCheckTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_DEL_SRV_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nPreDiscTimer=Nil then m_nPreDiscTimer := CTimer.Create;
     m_nPreDiscTimer.SetTimer(DIR_L1TOGPRS,DL_GPRS_PRE_DSTM_REQ,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nPingTimer=Nil then m_nPingTimer := CTimer.Create;
     m_nPingTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_PING_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nRstTimer=Nil then m_nRstTimer := CTimer.Create;
     m_nRstTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_REST_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nPingRepTimer=Nil then m_nPingRepTimer := CTimer.Create;
     m_nPingRepTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_PREP_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nMdmRestart=Nil then m_nMdmRestart := CTimer.Create;
     m_nMdmRestart.SetTimer(DIR_L1TOGPRS,DL_GSM_DSC3_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nWDiscMdmTimer=Nil then m_nWDiscMdmTimer := CTimer.Create;
     m_nWDiscMdmTimer.SetTimer(DIR_L1TOGPRS,DL_GSM_MATH_TMR,0,m_pTbl.m_swAddres,BOX_L1);

     if m_nWClosePort=Nil then m_nWClosePort := CTimer.Create;
     m_nWClosePort.SetTimer(DIR_L1TOGPRS,DL_GSM_CLPR_TMR,0,m_pTbl.m_swAddres,BOX_L1);


     m_nWCheckTimer.OnTimer(60);
     m_blOpenSession := False;
     m_blIsConnected := False;
     m_blQweryReconnect := False;
     OnRouterInit;
     if m_nPing=Nil then m_nPing := TIdIcmpClient.Create(nil);
     m_nPing.Host    := m_strIPAddr;
     m_nPing.OnReply := OnPingRes;
     m_nPingTimer.OnTimer(60);
     InitGpio;
     Start;
End;
procedure CGprsRouter.InitGpio;
Begin
     if sDSCS=Nil then sDSCS := TCriticalSection.Create;
     if m_nGDIO=Nil then m_nGDIO := CDiscret.Create(5,5,10,m_nGPIOPin,PH_DIRECT_PIN,PIN_OUTPT);
     m_nGDIO.SetEvent(BOX_L1,DIR_L1TOGPRS,AL_CHANDGEPIN_IND); //m_nDIO.Items[16].Enabled(True);
     {$IFDEF GPRS_DEBUG}
     m_nGDIO.Enabled(True);
     m_nGDIO.SetAddrVal($378,0);
     {$ENDIF}
     if (m_nIsRestart<>0) then m_nGDIO.RemPin;
End;
procedure CGprsRouter.OnRouterInit;
Var
    pTbl : SQWERYMDL;
Begin
    pTbl := LoadSettings;
    inherited Init(pTbl);
    //if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'GPRS:: OnRouterInit.m_sdtBegin:'+TimeToStr(pTbl.m_sdtBegin));//AAV
End;
function CGprsRouter.LoadSettings:SQWERYMDL;
Var
    strPath : String;
    Fl      : TINIFile;
    pTbl    : SQWERYMDL;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    //if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'GPRS:: OnRouterInit Path:'+strPath);//AAV
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     m_sdtBegin     := StrToTime(Fl.ReadString(m_pTbl.m_schPhone,'m_sdtBegin',TimeToStr(Now)));
     m_sdtEnd       := StrToTime(Fl.ReadString(m_pTbl.m_schPhone,'m_sdtEnd',TimeToStr(Now)));
     m_sdtPeriod    := StrToTime(Fl.ReadString(m_pTbl.m_schPhone,'m_sdtPeriod',TimeToStr(Now)));
     m_swDayMask    := Fl.ReadInteger(m_pTbl.m_schPhone,'m_swDayMask',0);
     m_sdwMonthMask := Fl.ReadInteger(m_pTbl.m_schPhone,'m_sdwMonthMask',0);
     m_sbyEnable    := Fl.ReadInteger(m_pTbl.m_schPhone,'m_sbyEnable',0);
     m_sbyPause     := 0;

     m_strIPAddr      := Fl.ReadString(m_pTbl.m_schPhone, 'm_strIPAddr','0.0.0.0');
     m_nPingPeriod    := Fl.ReadInteger(m_pTbl.m_schPhone,'m_nPingPeriod',45*60);
     m_nPingPeriodMsec:= Fl.ReadInteger(m_pTbl.m_schPhone,'m_nPingPeriodMsec',2000);
     m_nPingRepPeriod := Fl.ReadInteger(m_pTbl.m_schPhone,'m_nPingRepPeriod',5);
     m_nRstPeriod     := Fl.ReadInteger(m_pTbl.m_schPhone,'m_nRstPeriod',10*3600);
     m_nIsRestart     := Fl.ReadInteger(m_pTbl.m_schPhone,'m_nIsRestart',0);
     m_nIsMdmResPulce := Fl.ReadInteger(m_pTbl.m_schPhone,'m_nIsMdmResPulce',2000);
     m_nGPIOPin       := Fl.ReadInteger(m_pTbl.m_schPhone,'m_nGPIOPin',16);
     m_nResCMD        := Fl.ReadString(m_pTbl.m_schPhone, 'm_nResCMD','AT+CFUN=1,1');

     {
     if m_nPingPeriod<60      then m_nPingPeriod     := 60;
     if m_nPingPeriodMsec<200 then m_nPingPeriodMsec := 200;
     if m_nPingRepPeriod<3    then m_nPingRepPeriod  := 3;
     if m_nRstPeriod<3600     then m_nRstPeriod      := 3600;
     }
    end;
    Fl.Destroy;
    except
    end;
    Result := pTbl;
End;
function CGprsRouter.EventHandler(var pMsg:CMessage):Boolean;
Begin
     try
     case pMsg.m_sbyFor of
      DIR_L1TOGPRS  : SelfHandler(pMsg);
     End;
     except
      TraceER('(__)CERMD::>Error In CL3Module.EventHandler!!!');
     End;
End;
function CGprsRouter.SelfHandler(var pMsg:CMessage):Boolean;
Begin
     case pMsg.m_sbyType of
      DL_START_ROUT_REQ    : Start;
      DL_STOP_ROUT_REQ     : Stop;
      DL_GSM_SET_TMR       : PreDisconnect;
      DL_GSM_WOPEN_TMR     : OpenSession(m_nSSTime);
      DL_GSM_DSC_TMR       : PostClose;
      DL_GSM_DEL_SRV_TMR   : CheckConnection;
      DL_INIT_ROUT_REQ     : OnRouterInit;
      DL_GPRS_PRE_DSTM_REQ : Disconnect;
      DL_GSM_DSC2_TMR      : Disconnect2;
      DL_GSM_DSC3_TMR      : Disconnect3;
      DL_GSM_MATH_TMR      : MdmSoftRestart;
      DL_GSM_CLPR_TMR      : MdmClosePort;
      DL_GSM_PING_TMR      : Begin m_nPingCt:=0;Ping;End;
      DL_GSM_REST_TMR      : Restart;
      DL_GSM_PREP_TMR      : Begin if m_nPingCt<2 then Ping; Inc(m_nPingCt);End;
     End;
End;
//TReplyStatusTypes = (rsEcho, rsError, rsTimeOut, rsErrorUnreachable, rsErrorTTLExceeded);
procedure CGprsRouter.OnPingRes(ASender:TComponent;const AReplyStatus:TReplyStatus);
Begin
     if AReplyStatus.ReplyStatusType=rsEcho then
     Begin
      EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: Ping on IP:'+AReplyStatus.FromIpAddress+' OK!');
      m_nRstTimer.OffTimer;
      m_nPingRepTimer.OffTimer;
     End;
     if AReplyStatus.ReplyStatusType=rsTimeOut then
      EventBox.FixEvents(ET_CRITICAL,'('+m_pTbl.m_schPhone+')GPRS:: Ping on IPs:'+m_strIPAddr+' IPr:'+AReplyStatus.FromIpAddress+' Error TimeOut!');
End;
procedure CGprsRouter.GoPingProc;
Begin
     m_nRstTimer.OnTimer(m_nRstPeriod);
     m_nPingTimer.OnTimer(m_nPingPeriod);
End;
procedure CGprsRouter.Ping;
Begin
     try
      if m_strIPAddr<>'0.0.0.0' then
      Begin
       m_nPing.ReceiveTimeout := m_nPingPeriodMsec;
       m_nPing.Host := m_strIPAddr;
       m_nRstTimer.OnTimerEx(m_nRstPeriod);
       m_nPingTimer.OnTimer(m_nPingPeriod);
       m_nPingRepTimer.OnTimer(m_nPingRepPeriod);
       m_nPing.Ping('32');
      End;
     except
      EventBox.FixEvents(ET_CRITICAL,'('+m_pTbl.m_schPhone+')GPRS:: Ping on IP:'+m_pTbl.m_schIPAddr+' Host Error!');
     end;
End;
procedure CGprsRouter.Restart;
Var
    pDS : CMessageData;
Begin
    if (m_nIsRestart=0) then EventBox.FixEvents(ET_CRITICAL,'('+m_pTbl.m_schPhone+')GPRS:: Ping Error - No Operation!');
    if (m_nIsRestart=1) then
    Begin
     EventBox.FixEvents(ET_CRITICAL,'('+m_pTbl.m_schPhone+')GPRS:: Ping Error - Modem Restart!');
     MdmHardRestart;
    End;
    if (m_nIsRestart=2) then
    Begin
     EventBox.FixEvents(ET_CRITICAL,'('+m_pTbl.m_schPhone+')GPRS:: Ping Error - Board Restart!');
     MdmHardRestart;
     SlepEx(m_nIsMdmResPulce);
     pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CLOSE_USPD_REQ,pDS);
     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
    End;
End;
procedure CGprsRouter.MdmHardRestart;
Begin
    m_nGDIO.SetPin;
    SlepEx(m_nIsMdmResPulce);
    m_nGDIO.RemPin;
End;
function CGprsRouter.Start:Boolean;
Begin
     QweryOpenSession(-1);
End;
function CGprsRouter.Stop:Boolean;
Begin
     PreDisconnect;
End;
procedure CGprsRouter.PostClose;
Begin
     OnClose;
     if m_blQweryReconnect=True then
     Begin
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+m_pTbl.m_schPhone+')GPRS:: PostClose: m_blQweryReconnect=True.');//AAV
      OpenSession(m_nSSTime);
     End;
End;
procedure CGprsRouter.OnClose;
Begin
     m_blOpenSession := False;
     m_blIsConnected := False;
     SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_GPRS_OF_IND);
     //if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_GPRS_OF_REQ));
End;
procedure CGprsRouter.OnConnect;
Begin
     m_blIsConnected          := True;
     m_blQweryReconnect       := False;
     SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_GPRS_ON_IND);
     //if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_GPRS_ON_REQ));
End;
procedure CGprsRouter.OpenSession(nTimeSec:Integer);
Begin
     if (m_blOpenSession=False) then
     Begin
      m_nSSTime       := nTimeSec;
      m_blOpenSession := True;
      if nTimeSec<>-1 then
      m_nWConnTimer.OnTimer(nTimeSec);
      m_nWCheckTimer.OnTimer(60);
      Connect(m_pTbl.m_schPhone);
     End;
End;
procedure CGprsRouter.QweryOpenSession(nTimeSec:Integer);
Begin
     m_nSSTime := nTimeSec;
     m_nWOpenTimer.OnTimer(25);
End;
procedure CGprsRouter.ChandgeSessionTime(nTimeSec:Integer);
Begin
     m_nWConnTimer.OnTimer(nTimeSec);
End;
procedure CGprsRouter.Run;
Begin
     m_nWConnTimer.RunTimer;
     m_nWOpenTimer.RunTimer;
     m_nWDiscTimer.RunTimer;
     m_nWDisc2Timer.RunTimer;
     m_nWCheckTimer.RunTimer;
     m_nPreDiscTimer.RunTimer;
     m_nPingTimer.RunTimer;
     m_nRstTimer.RunTimer;
     m_nPingRepTimer.RunTimer;
     m_nMdmRestart.RunTimer;
     m_nWDiscMdmTimer.RunTimer;
     m_nWClosePort.RunTimer;
     inherited Run;
End;
function GetStatusString(State: TRasConnState; Error: Integer): String;
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
Procedure RasCallback(msg: Integer; state: TRasConnState;error: Integer);stdcall;
Begin
     MyDialParam[0].AMsg:=msg;
     MyDialParam[0].AState:=state;
     MyDialParam[0].AError:=error;
     if MyDialParam[0].AState=RASCS_Connected then
     Begin
      m_nGPRS[0].OnConnect;
     End;
End;
Procedure RasCallback1(msg: Integer; state: TRasConnState;error: Integer);stdcall;
Begin
     MyDialParam[1].AMsg:=msg;
     MyDialParam[1].AState:=state;
     MyDialParam[1].AError:=error;
     if MyDialParam[1].AState=RASCS_Connected then
     Begin
      m_nGPRS[1].OnConnect;
     End;
End;
Procedure RasCallback2(msg: Integer; state: TRasConnState;error: Integer);stdcall;
Begin
     MyDialParam[2].AMsg:=msg;
     MyDialParam[2].AState:=state;
     MyDialParam[2].AError:=error;
     if MyDialParam[2].AState=RASCS_Connected then
     Begin
      m_nGPRS[2].OnConnect;
     End;
End;
Procedure RasCallback3(msg: Integer; state: TRasConnState;error: Integer);stdcall;
Begin
     MyDialParam[3].AMsg:=msg;
     MyDialParam[3].AState:=state;
     MyDialParam[3].AError:=error;
     if MyDialParam[3].AState=RASCS_Connected then
     Begin
      m_nGPRS[3].OnConnect;
     End;
End;
function CGprsRouter.Connect(strJoinName:String):Boolean;
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
      {
      if m_blOpenSession=False then
      Begin
       //if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTCORR_REQ));
       if m_blIsNoSynchro=False then
       begin
        m_nWConnTimer.OnTimer(WAIT_SYNCHRONIZE);
        dtLastTime := Now;
       end;
      End;
      }
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
        if m_pTbl.m_swAddres=0 then R:=RasDial(Nil, Nil, DialParams, 0, @RasCallback, hRAS);
        if m_pTbl.m_swAddres=1 then R:=RasDial(Nil, Nil, DialParams, 0, @RasCallback1, hRAS);
        if m_pTbl.m_swAddres=2 then R:=RasDial(Nil, Nil, DialParams, 0, @RasCallback2, hRAS);
        if m_pTbl.m_swAddres=3 then R:=RasDial(Nil, Nil, DialParams, 0, @RasCallback3, hRAS);
        If R<>0 Then
        Begin
         RasGetErrorString(R,C,100);
        End;
       End;
     except
       TraceER('(__)CSGTM::>Error In CSetGsmTime.Connect!!!');
     end;
     Result := Res;
End;
function CGprsRouter.IsConnect:Boolean;
Var
     lpRasSt : TRASCONNSTATUS;
     res0 : DWord;
     res  : Boolean;
Begin
     lpRasSt.dwSize := sizeof(TRASCONNSTATUS);
     res0 := RasGetConnectStatus(hRas,lpRasSt);
     res  := False;
     if res0=0 then
     Begin
      if lpRasSt.rasconnstate=RASCS_Connected    then res := True else
      if lpRasSt.rasconnstate=RASCS_Disconnected then res := False;
     End;
     m_blOpenSession := res;
     Result := res;
End;
procedure CGprsRouter.CheckConnection;
Begin
    if (m_blOpenSession=True) then
    Begin
     //if (m_blIsConnected=False)or(IsConnect=False) then
     if (IsConnect=False) then
     Begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+m_pTbl.m_schPhone+')GPRS:: CheckConnection: IsConnect=False.');//AAV
      m_blQweryReconnect := True;
      PreDisconnect;
     End else
           if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: CheckConnection: IsConnect=True.');//AAV

    End;
    m_nWCheckTimer.OnTimer(60);
    //m_nWCheckTimer.OnTimer(2*60);
End;
procedure CGprsRouter.OnExpired;
Begin
    //if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'GPRS:: OnExpired_0.');//AAV
    //if IsConnect=True then
    Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: OnExpired.');//AAV
     m_blQweryReconnect := True;
     PreDisconnect;
     //m_nWCheckTimer.OnTimer(100);
    End;
    m_nPingTimer.OnTimer(m_nPingPeriod);
    m_nWCheckTimer.OffTimer;
end;
//PH_STOP_IS_GPRS_IND
function CGprsRouter.PreDisconnect:Boolean;
Begin
    SendPMSG(BOX_L1,0,DIR_L2TOL1,PH_STOP_IS_GPRS_IND);
    m_nPreDiscTimer.OnTimer(5);
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: PreDisconnect.');//AAV
End;
//PH_STOP_IS_GPRS_IND
procedure CGprsRouter.StopEx;
Begin
    SendPMSG(BOX_L1,0,DIR_L2TOL1,PH_STOP_IS_GPRS_IND);
    Disconnect;
End;
function CGprsRouter.MdmClosePort:Boolean;
Begin
    EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: Disconnect ¹3 Complette.');
    SendPMSG(BOX_L1,m_pTbl.m_sbyPortID,DIR_L2TOL1,PH_FREE_PORT_IND);
    m_nWDiscTimer.OnTimer(10);
    m_nWCheckTimer.OnTimer(60);
End;
function CGprsRouter.MdmSoftRestart:Boolean;
Begin
    EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: Disconnect ¹3 Start. Send Soft Restart Modem.');
    //SendCommand('AT+CFUN=1');
    SendCommand(m_nResCMD);
    m_nWClosePort.OnTimer(20);
End;
function CGprsRouter.Disconnect3:Boolean;
Begin
    SendPMSG(BOX_L1,m_pTbl.m_sbyPortID,DIR_L2TOL1,PH_RESET_PORT_IND);
    SendPMSG(BOX_L1,m_pTbl.m_sbyPortID,DIR_L2TOL1,PH_DISC_IND);
    EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: Disconnect ¹2 Complette. Close Phone.');
    m_nWDiscMdmTimer.OnTimer(15);
End;
function CGprsRouter.Disconnect2:Boolean;
Var
     res : Boolean;
     m_strCurrentDir : String;
Begin
     res := True;
     if m_pTbl.m_swAddres=0 then
     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\stop.bat' else
     if m_pTbl.m_swAddres<>0 then
     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\stop'+IntToStr(m_pTbl.m_swAddres)+'.bat';
     StartProcessEx(m_strCurrentDir,False,False);
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+m_pTbl.m_schPhone+')GPRS:: Disconnect ¹2 Start.');//AAV
     m_nMdmRestart.OnTimer(40);
     Result := Res;
End;
function CGprsRouter.Disconnect:Boolean;
Var
     res : Boolean;
Begin
     res := True;
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+m_pTbl.m_schPhone+')GPRS:: Start Disconnect.');//AAV
     if RasHangUp(hRas)=0 Then
     Begin
      hRas := 0;
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+m_pTbl.m_schPhone+')GPRS:: Disconnect ¹1 Complete.');//AAV
     End else
     Begin
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+m_pTbl.m_schPhone+')GPRS:: Disconnect ¹1 No Complete.');//AAV
     End;
     m_nWDisc2Timer.OnTimer(40);
     Result := Res;
End;
procedure CGprsRouter.SendCommand(strComm:String);
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
     SendMsgIData(BOX_L1,0,m_pTbl.m_sbyPortID,DIR_L2TOL1,PH_COMM_IND,pDS);
    End;
End;
end.
