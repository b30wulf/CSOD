unit knsl3lme;
//{$define DEBUG_LME}
interface
uses
    Windows,forms,Messages,Controls, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,
    utldatabase,knsl3vmeter,utlmtimer,ShellApi,Graphics,
    knsl1module,
    knsl2module,
    knsl3module,
    knsl3querysender,
    utlTimeDate,
    knsl5tracer,
    knsl5config,
    knsl3setenergo,
    knsl3transtime,
    knsl3FHModule,
    knsl3treeloader,
    knsl3EventBox,
    knsl3datafinder,
    inifiles,
    knsl3setenergomoz,
    knsl4Loader,
    knsl2QweryTrServer,
    knsl3savetime,
    utlThread,
    AdvOfficeStatusBar,
    frmTreeDataModule;
type
     CAutoLoader = class
     private
      pDS             : CMessageData;
      m_nTM           : CDTRouting;
      m_snArchType    : Integer;
      m_snCmpType     : Integer;
      m_sdtArchTime0  : TDateTime;
      m_sdtArchTime1  : TDateTime;
      m_sdtArchTmpTime: TDateTime;
     public
      m_sblEnable     : Boolean;
     public
      procedure LoadPDSFromFHModule;
      procedure Init;
      procedure CompareDate;
      function  GetCompareType(nType:Byte):Byte;
      function  SetDateInfo(var pMsg:CMessage):Boolean;
      function  SetCTRLInfo(var pMsg:CMessage):Boolean;
      function  SetShortDateInfo(var pMsg:CMessage):Boolean;
      function  EventHandler(var pMsg:CMessage):Boolean;
      procedure CreateQuery;
      function Next:Boolean;
      procedure Reset;
      destructor Destroy; override;
     End;
     CL3LmeModule = class(CThread)
     private
      m_nLmeCounter  : Integer;
      m_byLayerState : Byte;
      FState         : Byte;
      FSvState       : Byte;
      m_nPoolCount   : Byte;
      m_nPoolIndex   : Byte;
      m_nMsg         : CMessage;
      m_nPackTimer   : CTimer;
      m_nSaveTimer   : CTimer;
      m_nProtoSvTmr  : CTimer;
      m_nStartTimer  : CTimer;
      m_nPoolTmr     : CTimer;
      m_nConnTmr     : CTimer;
      m_nWPoolTmr    : CTimer;
      m_nChBaseTmr   : CTimer;
      //FTimer         : TTimer;
      FForm          : TForm;
      m_blQrySave    : Boolean;
      FlbRemote      : TStaticText;
      FlbLocal       : TStaticText;
      FlbRemTime     : TStaticText;
      m_nCalcType    : Integer;
      m_nParamID     : Integer;
      FL3TreeLoader  : PCL3TreeLoader;
      m_blEndMyMsg   : Boolean;
      nL2CS          : TCriticalSection;
      m_nLoader      : CLoader;
      m_blNextJob    : Boolean;
      m_blMDMConn    : Byte;
      m_blGprsConn   : Byte;
      m_sblLastDTNight: Boolean;
      m_dtOldtime    : TDateTime;
      //m_sALD         : CAutoLoader;
     public
      m_sALD         : CAutoLoader;
      destructor Destroy; override;
      procedure Init;
      procedure DoHalfTime(Sender:TObject);
     private
      procedure OnUpdateAllMeter;
      function  IsNewDay:Boolean;
      procedure OnUpdateVMeter(var pMsg:CMessage);
      procedure OnUpdateAbon(var pMsg:CMessage);
      procedure StartTransTime(var pMsg:CMessage);
      procedure StopTransTime(var pMsg:CMessage);
      procedure InitL1(var pMsg:CMessage);
      procedure InitL2(var pMsg:CMessage);
      procedure InitPortL2(var pMsg:CMessage);
      procedure InitL3(var pMsg:CMessage);
      procedure SendRecalc(var pMsg:CMessage);
      procedure InitGenSett(var pMsg:CMessage);
      procedure StartDialSynchro(var pMsg:CMessage);
      procedure StopDialSynchro(var pMsg:CMessage);
      procedure StartGPRS(var pMsg:CMessage);
      procedure StopGPRS(var pMsg:CMessage);
      procedure InitGPRS(var pMsg:CMessage);
      procedure SelfStop(var pMsg:CMessage);
      procedure SelfUpdate(var pMsg:CMessage);
      procedure SelfReload(var pMsg:CMessage);
      function  ChechState(var pMsg:CMessage):Boolean;
      procedure SetState(byState:Byte);
      procedure GoPolling(var pMsg:CMessage);
      procedure GoGraphPolling(var pMsg:CMessage);
      procedure GoCtrlPolling(var pMsg:CMessage);
      procedure GoAllGraphPolling(var pMsg:CMessage);
      procedure StopPolling(var pMsg:CMessage);
      procedure DiscPolling(var pMsg:CMessage);
      procedure OnNullStAction(var pMsg:CMessage);
      procedure OnPoolStAction(var pMsg:CMessage);
      procedure OnGPllStAction(var pMsg:CMessage);
      procedure OnGPllAllStAction(var pMsg:CMessage);
      procedure OnCalcStAction(var pMsg:CMessage);
      procedure OnReCalcStAction(var pMsg:CMessage);
      procedure OnViewStAction(var pMsg:CMessage);
      procedure OnChandgeIP(var pMsg:CMessage);
      procedure OnPackStAction(var pMsg:CMessage);
      procedure OnCalculation(var pMsg:CMessage);
      procedure LoadMeterParam(var pMsg:CMessage);
      procedure FreeL2(var pMsg:CMessage);
      procedure StartFinder(var pMsg:CMessage);
      function  CheckSpaceDB(nSize:Integer):Boolean;

      procedure Execute; override;
      procedure StopLayer;
      procedure StartLayer;
      function  EventHandler(var pMsg : CMessage):Boolean;
      function  SelfHandler(var pMsg:CMessage):Boolean;
      function  LoHandler(var pMsg:CMessage):Boolean;
      function  HiHandler(var pMsg:CMessage):Boolean;
      //function  StartProcess(strPath:String;blWait:Boolean):Boolean;
      procedure LoadGraphScenario(var pMsg:CMessage);

      procedure LoadCTRLScenario(var pMsg:CMessage); // Ukrop

      procedure LoadAllGraphScenario(var pMsg:CMessage);
      procedure LoadAllEventsScenario(var pMsg:CMessage);
      procedure LoadEventsScenario(var pMsg:CMessage);
      procedure SetSettings(var pMsg:CMessage);
      procedure SetLockSettings(var pMsg:CMessage);
      procedure OnUpdateView(var pMsg:CMessage);
      procedure CheckPostQry;
      procedure OnHandler;
      procedure OnSaveAction;
      procedure AutoKorrEvent;
      procedure NotifyConnect;
      procedure NotifyDisconnect;
      procedure NotifyRemmConnect(var pMsg:CMessage);
      procedure StartDiagnostic(var pMsg:CMessage);
      procedure StopDiagnostic(var pMsg:CMessage);
      function  OnRemoteFunction(var pMsg:CMessage):Boolean;
      procedure AutoLoadNext;
      procedure CheckBaseCon;
      procedure StartFH(var pMsg:CMessage);
      procedure CreateQSRVMSG(var pMsg:CMessage);
      procedure RepPrepare(var pMsg:CMessage);
      procedure CreateQEVTMSG(var pMsg:CMessage);
      procedure CreateHQWRMSG(var pMsg:CMessage);
      procedure StopQSRVMSG(byCause:Byte;var pMsg:CMessage);
     public
      function  PackData:Boolean;
      function  PackBase:Boolean;
      procedure StartPackProc;
      procedure ReBoot(dwReborFunction:DWord);
      function  StartProcess(strPath:String;blWait:Boolean):Boolean;
      procedure ReBootPrg(var pMsg:CMessage);
      procedure TurnOffPrg(var pMsg:CMessage);
      procedure ShedulerGo(var pMsg:CMessage);
      procedure ShedulerStop(var pMsg:CMessage);
      procedure ShedulerInit(var pMsg:CMessage);
      procedure InitTransTime(var pMsg:CMessage);
      procedure ConnectMeter(var pMsg:CMessage);
      procedure ConnectAbon(var pMsg:CMessage);
      procedure OpenCloseRemStat(var pMsg:CMessage);
      procedure ResetCounterStat(var pMsg:CMessage);
      procedure OpenRemState(var pMsg:CMessage);
      procedure OpenCloseMeter(nMID,nVMID,nSET:Integer);
      procedure OpenCloseAbon(nAID,nSET:Integer);
      procedure ExportOF(var pMsg:CMessage);
      procedure ExportON(var pMsg:CMessage);
      procedure ExportIN(var pMsg:CMessage);
      procedure InitVMeter(var pMsg:CMessage);
      procedure QweryRouter(var pMsg:CMessage);
      procedure QwerySaveDB(var pMsg:CMessage);
      procedure InitTree(var pMsg:CMessage);
      procedure MessageTree(var pMsg:CMessage);
      procedure MessageStatBar(var pMsg:CMessage);
      procedure StatisticAbon(var pMsg:CMessage);
      procedure OnQwerySaveDB;
      procedure DoSaveTimer;
     public
      property PForm       : TForm        read FForm       write FForm;
      property PlbRemote   : TStaticText  read FlbRemote   write FlbRemote;
      property PlbLocal    : TStaticText  read FlbLocal    write FlbLocal;
      property PlbRemTime  : TStaticText  read FlbRemTime  write FlbRemTime;
      property PL3TreeLoader:PCL3TreeLoader read FL3TreeLoader write FL3TreeLoader;
     End;
var
     mL3LmeMoule : CL3LmeModule = nil;
const
  WM_SENDTOMONITOR   = WM_USER + 3;
implementation

uses knsl5module;

destructor CAutoLoader.Destroy;
begin
  if m_nTM <> nil then FreeAndNil(m_nTM);
  inherited;
end;

procedure CAutoLoader.Init;
Begin
     m_nTM := CDTRouting.Create;
     m_snCmpType := 0;
     Reset;
End;
function CAutoLoader.GetCompareType(nType:Byte):Byte;
Begin
     case nType of
      QRY_ENERGY_DAY_EP,
      QRY_NAK_EN_DAY_EP,
      QRY_SRES_ENR_EP,
      QRY_SRES_ENR_EM,
      QRY_SRES_ENR_RP,
      QRY_SRES_ENR_RM,
      QRY_POD_TRYB_HEAT,
      QRY_POD_TRYB_RASX,
      QRY_POD_TRYB_TEMP,
      QRY_POD_TRYB_V,
      QRY_OBR_TRYB_HEAT,
      QRY_OBR_TRYB_RASX,
      QRY_OBR_TRYB_TEMP,
      QRY_OBR_TRYB_V,
      QRY_POD_TRYB_RUN_TIME,
      QRY_RASH_HOR_V,
      QRY_RASH_DAY_V,
      QRY_WORK_TIME_ERR   : Result := 1;
      QRY_NACKM_POD_TRYB_HEAT,
      QRY_NACKM_POD_TRYB_RASX,
      QRY_NACKM_POD_TRYB_TEMP,
      QRY_NACKM_POD_TRYB_V,
      QRY_NACKM_OBR_TRYB_HEAT,
      QRY_NACKM_OBR_TRYB_RASX,
      QRY_NACKM_OBR_TRYB_TEMP,
      QRY_NACKM_OBR_TRYB_V,
      QRY_NACKM_POD_TRYB_RUN_TIME,
      QRY_MAX_POWER_EP,
      QRY_NAK_EN_MONTH_EP ,
      QRY_RASH_MON_V,
      QRY_ENERGY_MON_EP   : Result := 2;
      else
       Result := 0;
     End;
End;
function CAutoLoader.SetDateInfo(var pMsg:CMessage):Boolean;
Var
     szDT : Integer;
Begin
     if m_nCF.IsLocal=True then
     if m_sblEnable=True then
     Begin
      szDT := sizeof(TDateTime);
      Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
      m_sblEnable  := False;
      m_snArchType := pDS.m_swData1;   
      m_snCmpType  := GetCompareType(m_snArchType);
      Move(pDS.m_sbyInfo[0],m_sdtArchTime1,szDT);
      Move(pDS.m_sbyInfo[szDT],m_sdtArchTime0,szDT);
      m_sdtArchTmpTime := m_sdtArchTime0;
      //CompareDate;
      Move(m_sdtArchTmpTime,pDS.m_sbyInfo[0],szDT);
      Move(pDS,pMsg.m_sbyInfo[0],sizeof(pDS));
     End;
     Result := True;
End;
function CAutoLoader.SetCTRLInfo(var pMsg:CMessage):Boolean;
Begin
     if m_nCF.IsLocal=True then
     if m_sblEnable=True then
     Begin
      Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
      m_sblEnable  := False;
      m_snArchType := pDS.m_swData1;
      m_snCmpType  := GetCompareType(m_snArchType);
      Move(pDS,pMsg.m_sbyInfo[0],sizeof(pDS));
     End;
     Result := True;
End;
function CAutoLoader.SetShortDateInfo(var pMsg:CMessage):Boolean;
//Var
 //    szDT : Integer;
Begin
     if m_nCF.IsLocal=True then
     if m_sblEnable=True then
     Begin
      Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
      m_sblEnable      := False;
      m_snCmpType      := 1;
      m_sdtArchTime1   := Now;
      m_sdtArchTime0   := Now;
      m_sdtArchTmpTime := m_sdtArchTime0;
     End;
     Result := True;
End;
procedure CAutoLoader.CompareDate;
Begin
     if m_snCmpType=1 then
     Begin
      if (TDate(m_sdtArchTime1)=TDate(m_sdtArchTmpTime)) or (((m_sdtArchTmpTime-m_sdtArchTime1))<=1) then
      m_sdtArchTmpTime := m_sdtArchTime1;
     End
End;
function CAutoLoader.Next:Boolean;
begin
     Result := True;
     if m_snCmpType=1 then
     Begin
      if m_nTM.CompareDay(m_sdtArchTime1,m_sdtArchTmpTime)=0 then
       Begin
        Reset;
        Result := True;
        exit
       End else
       Begin
        Result := False;
        m_nTM.DecDate(m_sdtArchTmpTime);
        CreateQuery;
       End;
     End else
     if m_snCmpType=2 then
     Begin
      if m_nTM.CompareMonth(m_sdtArchTime1,m_sdtArchTmpTime)=0 then
       Begin
        Reset;
        Result := True;
        exit
       End else
       Begin
        Result := False;
        m_nTM.DecMonth(m_sdtArchTmpTime);
        CreateQuery;
       End;
     End;
end;
function  CAutoLoader.EventHandler(var pMsg:CMessage):Boolean;
Begin
      case pMsg.m_sbyType of
           LME_LOAD_COMPL_IND:
            if m_sblEnable=False then
            SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_ALLGRAPH_POLL_REQ,pDS);
           LME_LOAD_ONE_COMPL_IND:
            if m_sblEnable=False then
            SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_GRAPH_POLL_REQ,pDS);
           LME_LOAD_ONEEV_COMPL_IND:
            if m_sblEnable=False then
            SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_GRAPH_POLL_REQ,pDS);

           LME_LOAD_ONECTRL_COMPL_IND: // Ukrop control
            if m_sblEnable=False then
            SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_CTRL_POLL_REQ,pDS);
      End;
     Result := True;
End;
procedure CAutoLoader.CreateQuery;
Var
     szDT : Integer;
Begin
     szDT := sizeof(TDateTime);
     Move(m_sdtArchTmpTime,pDS.m_sbyInfo[0]   ,szDT);
     Move(m_sdtArchTmpTime,pDS.m_sbyInfo[szDT],szDT);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
     //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_ALLGRAPH_POLL_REQ,pDS);
End;
procedure CAutoLoader.Reset;
Begin
     m_sblEnable := True;
     m_sdtArchTime0 := Now;
     m_sdtArchTime1 := Now;
     m_sdtArchTmpTime := Now;
     m_snCmpType := 0;
End;

procedure CAutoLoader.LoadPDSFromFHModule;
//var dt_DateResp : TDateTime;
begin
end;

procedure CL3LmeModule.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CL3LmeModule.Execute;
Begin
     FDEFINE(BOX_L3_LME,BOX_L3_LME_SZ,True);
     while not Terminated do
     Begin
      FGET(BOX_L3_LME,@m_nMsg);
      Synchronize(OnHandler);
      //EventHandler(m_nMsg);
     End;
End;

destructor CL3LmeModule.Destroy;
begin
  Suspend;

  if m_sALD <> nil then FreeAndNil(m_sALD);

  if m_nPackTimer <> nil then FreeAndNil(m_nPackTimer);
  if m_nSaveTimer <> nil then FreeAndNil(m_nSaveTimer);
  if m_nProtoSvTmr <> nil then FreeAndNil(m_nProtoSvTmr);
  if m_nStartTimer <> nil then FreeAndNil(m_nStartTimer);
  if m_nPoolTmr <> nil then FreeAndNil(m_nPoolTmr);
  if m_nConnTmr <> nil then FreeAndNil(m_nConnTmr);
  if m_nWPoolTmr <> nil then FreeAndNil(m_nWPoolTmr);
  if m_nChBaseTmr <> nil then FreeAndNil(m_nChBaseTmr);

  if nL2CS <> nil then FreeAndNil(nL2CS);

  if m_nLoader <> nil then FreeAndNil(m_nLoader);

  inherited;
end;

procedure CL3LmeModule.Init;
Begin
     mL3LmeMoule   := self;
     m_nPoolCount  := 0;
     m_nPoolIndex  := 0;
     m_blNextJob   := False;
     m_blEndMyMsg  := False;
     m_blConnectST := False;
     m_blMDMConn   := 0;
     m_blGprsConn  := 0; 
     m_sblLastDTNight := False;
     m_dtOldtime   := Now;
     //if m_blIsSlave=True  then m_byCoverState := 0 else
     //if m_blIsSlave=False then m_byCoverState := 1;
     nL2CS         := TCriticalSection.Create;
     FState        := LME_NULL_STATE;
     FDEFINE(BOX_LOAD,BOX_LOAD_SZ,False);
     SetState(LME_NULL_STATE);

     m_nLoader             := CLoader.Create;
     {m_nLoader.PMeterTable := mL2Module.PPMeterTable;
     m_nLoader.PMeters     := mL2Module.PPMeters;}

     m_blQrySave   := False;
     m_sALD        := CAutoLoader.Create;
     m_sALD.Init;
     m_nPackTimer := CTimer.Create;
     m_nPackTimer.SetTimer(DIR_LM3TOLM3,QL_UPDATE_TMR,0,0,BOX_L3_LME);

     m_nSaveTimer := CTimer.Create;
     m_nSaveTimer.SetTimer(DIR_LM3TOLM3,QL_SAVE_TMR,0,0,BOX_L3_LME);
     m_nSaveTimer.OnTimer(m_nCF.GenStorePeriod);
     //m_nSaveTimer.OnTimer(60*2);

     m_nStartTimer := CTimer.Create;
     m_nStartTimer.SetTimer(DIR_LM3TOLM3,QL_START_TMR,0,0,BOX_L3_LME);
     if m_nCF.IsStartCvr=True  then m_nStartTimer.OnTimer(10);

     m_nProtoSvTmr := CTimer.Create;
     m_nProtoSvTmr.SetTimer(DIR_LM3TOLM3,QL_PROTOSV_TMR,0,0,BOX_L3_LME);
     m_nProtoSvTmr.OnTimer(m_nCF.GenProtoPeriod);

     m_nPoolTmr := CTimer.Create;
     m_nPoolTmr.SetTimer(DIR_LM3TOLM3,QL_POOL_TMR,0,0,BOX_L3_LME);

     m_nConnTmr := CTimer.Create;
     m_nConnTmr.SetTimer(DIR_LM3TOLM3,QL_CONNOFF_TMR,0,0,BOX_L3_LME);

     m_nWPoolTmr := CTimer.Create;
     m_nWPoolTmr.SetTimer(DIR_LM3TOLM3,QL_POOL_ERR_TMR,0,0,BOX_L3_LME);

     m_nChBaseTmr := CTimer.Create;
     m_nChBaseTmr.SetTimer(DIR_LM3TOLM3, QL_CHECK_BASE_CON_REQ,0,0,BOX_L3_LME);
     m_nChBaseTmr.OnTimer(60);

     Priority    := tpNormal;
     Resume;
End;
function CL3LmeModule.EventHandler(var pMsg : CMessage):Boolean;
Begin
  Result:=True;
     try
     case pMsg.m_sbyFor of
      DIR_L3TOLME  : SetLockSettings(pMsg);
      DIR_LM3TOLM3 : SelfHandler(pMsg);
      DIR_LLTOLM3  : LoHandler(pMsg);
      DIR_LHTOLM3  : HiHandler(pMsg);
      DIR_LHTOLAL  : m_sALD.EventHandler(pMsg);
     End;
     except
      //TraceL(4,pMsg.m_swObjID,'(__)CL3LM::>Error Routing L3.')
      Result:=True;
     End;
End;
function CL3LmeModule.SelfHandler(var pMsg:CMessage):Boolean;
Var
     pDS : CMessageData;
     i   : Integer;
Begin
Result:=True;
  try
     case pMsg.m_sbyType of
      QL_POOL_ERR_TMR :
      Begin
          pDS.m_swData4 := MTR_LOCAL;
          SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
          SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
          m_nCF.SchedGo;

      End;
      QL_UPDATE_TMR:
      Begin
          OnPackStAction(pMsg);
      End;
      QL_SAVE_TMR:
      Begin
          OnSaveAction;
          m_nSaveTimer.OnTimer(m_nCF.GenStorePeriod);
          //m_nSaveTimer.OnTimer(60*2);
      End;
      QL_START_TMR:
      Begin
          //if m_nCF.QueryType=QWR_QWERY_SRV then SendQSDataGEx(QS_FIND_SR,-1,-1,-1,-1,-1,Now,Now) else
          if m_nPoolCount=0 then
          Begin
           if m_nSmartFinder=1 then m_nCF.m_nSDL.OnStartFind(-1,-1) else
           case m_nCF.QueryType of
            QWR_EQL_TIME,QWR_QWERY_SHED : OnUpdateAllMeter;
            QWR_FIND_SHED               : m_nCF.m_nSDL.OnStartFind(-1,-1);
           End;
           Inc(m_nPoolCount);
          End else
          if m_nPoolCount=1 then
          Begin
           if m_nCF.IsSlave=True  then  Begin pDS.m_swData4 := MTR_LOCAL; FForm.WindowState:=wsMinimized;End;
           pDS.m_swData4 := MTR_LOCAL;
           pDS.m_swData0 := -1;
           SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
           SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_USPDCONN_REQ));
          End;
      End;
      QL_PROTOSV_TMR:
      Begin
          if m_nCF.IsSlave=False then TOnSaveTrace('',False);
          m_nProtoSvTmr.OnTimer(m_nCF.GenProtoPeriod);
      End;
      QL_POOL_TMR:
      Begin
          m_blNextJob := False;
          if m_nCF.IsPreGraph=True then
          Begin
           //if m_nPoolIndex=0 then {mL3FHModule.FHModuleStart(0, 0)}//OnUpdateAllMeter else
           if m_nPoolIndex=0 then Begin if m_nSmartFinder=1 then m_nCF.m_nSDL.OnStartFind(-1,-1) else OnUpdateAllMeter;End else
           if m_nPoolIndex=1 then
           Begin
            SetState(LME_NULL_STATE);
            pDS.m_swData4 := MTR_LOCAL;
            pDS.m_swData0 := -1;
            SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
            SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTPOLL_REQ));
           End;
          End else
          if m_nCF.IsPreGraph=False then
          Begin
            SetState(LME_NULL_STATE);
            pDS.m_swData4 := MTR_LOCAL;
            pDS.m_swData0 := -1;
            SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
            SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTPOLL_REQ));
          End;
      End;
      QL_CONNOFF_TMR      : NotifyDisconnect;
      QL_START_UNLOAD_REQ : AutoLoadNext;
      QL_CHECK_BASE_CON_REQ : CheckBaseCon;
     End;
  except
    Result:=True;
  end;
End;
function CL3LmeModule.IsNewDay:Boolean;
Begin
     Result := False;
     if trunc(m_dtOldtime)<>trunc(Now) then
     Begin
      //OnUpdateAllMeter;
      Result := True;
     End;
     m_dtOldtime := Now;
end;
procedure CL3LmeModule.OnUpdateAllMeter;
Var
     tmTime0,tmTime1 : TDateTime;
     szDT : Integer;
     pDS  : CMessageData;
begin
     FillChar(pDS,sizeof(CMessageData),0);
     szDT := sizeof(TDateTime);
     pDS.m_swData0 := 0;
     pDS.m_swData1 := QRY_SRES_ENR_EP;
     pDS.m_swData2 := 1;
     pDS.m_swData3 := 0;
     pDS.m_swData4 := MTR_LOCAL;
     tmTime1       := Now;
     tmTime0       := m_pDB.GetLastTime;
     if (tmTime0=0)or(abs(trunc(tmTime1)-trunc(tmTime0))>31) then tmTime0 := Now - 31;
     if (tmTime0>tmTime1) then tmTime0 := Now;
     Move(tmTime0,pDS.m_sbyInfo[0]   ,szDT);
     Move(tmTime1,pDS.m_sbyInfo[szDT],szDT);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
end;
procedure CL3LmeModule.OnUpdateVMeter(var pMsg:CMessage);
Var
     tmTime0,tmTime1 : TDateTime;
     szDT            : Integer;
     pDS,lDS         : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],lDS,sizeof(CMessageData));
     FillChar(pDS,sizeof(CMessageData),0);
     szDT := sizeof(TDateTime);
     pDS.m_swData0 := lDS.m_swData0;//PVID
     pDS.m_swData1 := QRY_SRES_ENR_EP;
     pDS.m_swData2 := lDS.m_swData1;//PMID;
     pDS.m_swData3 := lDS.m_swData2;//PPID;
     pDS.m_swData4 := MTR_LOCAL;
     tmTime1       := Now;
     tmTime0       := m_pDB.GetLastTime;
     if tmTime0 = 0 then tmTime0 := Now - 31;
     Move(tmTime0,pDS.m_sbyInfo[0]   ,szDT);
     Move(tmTime1,pDS.m_sbyInfo[szDT],szDT);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_VMTGRAPH_REQ,pDS);
End;
procedure CL3LmeModule.OnUpdateAbon(var pMsg:CMessage);
Var
     tmTime0,tmTime1 : TDateTime;
     szDT            : Integer;
     pDS,lDS         : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],lDS,sizeof(CMessageData));
     FillChar(pDS,sizeof(CMessageData),0);
     szDT := sizeof(TDateTime);
     pDS.m_swData0 := lDS.m_swData0;//PAID
     pDS.m_swData1 := QRY_SRES_ENR_EP;
     pDS.m_swData2 := lDS.m_swData1;//PPID;
     pDS.m_swData3 := 0;
     pDS.m_swData4 := MTR_LOCAL;
     tmTime1       := Now;
     tmTime0       := m_pDB.GetLastTime;
     if tmTime0 = 0 then tmTime0 := Now - 31;
     Move(tmTime0,pDS.m_sbyInfo[0]   ,szDT);
     Move(tmTime1,pDS.m_sbyInfo[szDT],szDT);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ABOGRAPH_REQ,pDS);
End;

function CL3LmeModule.LoHandler(var pMsg:CMessage):Boolean;
Var
     pDS     : CMessageData;
     m_nVMsg : CMessage;
Begin
  Result:=True;
  try
     case pMsg.m_sbyType of
      PH_DATA_IND:
      Begin
       Move(pMsg.m_sbyInfo,m_nVMsg,pMsg.m_swLen-11);
       case m_nVMsg.m_sbyFor of
        DIR_LHTOLM3:
        Begin
         Move(m_nVMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
         pDS.m_swData4 := MTR_LOCAL;
         Move(pDS,m_nVMsg.m_sbyInfo[0],sizeof(CMessageData));
         EventHandler(m_nVMsg);
        End;
        DIR_LHTOLMT: TextProc(m_nVMsg);
        DIR_LHTOLMC: SetSettings(m_nVMsg);
        DIR_L4TOL3 : if m_nCF.IsLocal=False then FPUT(BOX_L3,@m_nVMsg);
        DIR_L1TOSL : if m_nCF.IsLocal=False then FPUT(BOX_L3_HF,@m_nVMsg);
       End;
      // TraceM(4,pMsg.m_swObjID,'(__)CLMMD::>MSG DIN:',@m_nVMsg);
      End;
      PH_CONN_IND: NotifyConnect;
      PH_DISC_IND: NotifyDisconnect;
      PH_RCONN_IND: NotifyRemmConnect(pMsg);
     End;
  except
    Result:=True;
  end;
End;

procedure CL3LmeModule.NotifyConnect;
Begin
    if m_blConnectST=False then
    Begin
     m_blConnectST := True;
    // SetTexSB(5,'Connection Pass');
    End;
    //m_nConnTmr.OnTimer(60);
End;
procedure CL3LmeModule.NotifyDisconnect;
Begin
    if m_blConnectST=True then
    Begin
     m_blConnectST := False;
    // SetTexSB(5,'Connection Fail');
     if m_blEndMyMsg=True then
     TDataFinder.OnStopFind;
    End;
End;
procedure CL3LmeModule.NotifyRemmConnect(var pMsg:CMessage);
Var
    str : String;
Begin
    if m_blConnectST=False then
    Begin
     m_blConnectST := True;
     str := '��������� ����� �������� ' + m_sL4ConTag.Items[pMsg.m_swObjID].m_schName+ ' ���. '+m_sL4ConTag.Items[pMsg.m_swObjID].m_schPhone;
     PlbRemote.Caption := str;
     SetTexSB(0,str);
     SetTexSB(5,'Remote Connection Wait');
    End;
End;
procedure CL3LmeModule.SetLockSettings(var pMsg:CMessage);
Var
     pDS : CMessageData;
     dtTime :TDateTime;
Begin
     case pMsg.m_sbyType of
      NL_STARTSRV_REQ   :
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbLocal.Caption := '���� �����: '+DateTimeToStr(dtTime);
       End;
      NL_STARTCLEX_REQ:
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbLocal.Caption := '������ ����: '+DateTimeToStr(dtTime);
       End;
      NL_SAVEUPD_REQ:
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbLocal.Caption := '������ ������: '+DateTimeToStr(dtTime);
       End;
     End;
End;
procedure CL3LmeModule.SetSettings(var pMsg:CMessage);
Var
     pDS : CMessageData;
     dtTime :TDateTime;
Begin
     case pMsg.m_sbyType of
//      NL_SETOPENL1_REQ  : FcbOutL1.Checked := True;
//      NL_SETOPENL2_REQ  : FcbOutL2.Checked := True;
//      NL_SETOPENL3_REQ  : FcbOutL3.Checked := True;
//      NL_SETOPENL4_REQ  : FcbOutL4.Checked := True;
//      NL_SETOPENL5_REQ  : FcbOutL5.Checked := True;
//      NL_SETREMML1_REQ  : FcbOutL1.Checked := False;
//      NL_SETREMML2_REQ  : FcbOutL2.Checked := False;
//      NL_SETREMML3_REQ  : FcbOutL3.Checked := False;
//      NL_SETREMML4_REQ  : FcbOutL4.Checked := False;
//      NL_SETREMML5_REQ  : FcbOutL5.Checked := False;
      NL_SETOPENALL_REQ : m_blProtoState  := True;
      NL_SETREMMALL_REQ : m_blProtoState  := False;
      NL_SETOPENRALL_REQ: m_blRemProtoState  := True;
      NL_SETREMMRALL_REQ: m_blRemProtoState  := False;
      NL_FULLDISC_REQ   : if m_nCF.IsLocal=False then m_pDB.FullDisconnect;
      NL_CONNECTDB_REQ  : if m_nCF.IsLocal=False then m_pDB.Connect;
      NL_USPDCONN_REQ   : FlbRemote.Caption := '���������� �������������';
      NL_SAVEDBOK_REQ   : FlbRemote.Caption := '���� �����';
      NL_PACKSTART_REQ  : FlbRemote.Caption := '������ ������ ����';
      NL_SAVEDB_REQ     : StartPackProc;
      NL_STARTCALC_REQ  : FlbRemote.Caption := '������';
      NL_WAITPOLL_REQ   : FlbRemote.Caption := '�������� ������';
      NL_STARTPOLL_REQ  : FlbRemote.Caption := '����� ���������';
      NL_UPDGRAPH_REQ   : FlbRemote.Caption := '���������� ��������';
      NL_STARTCORR_REQ  : FlbRemote.Caption := '������ ��������� �������';
      NL_FINALCORR_REQ  : FlbRemote.Caption := '��������� ������� ���������';
      NL_STARTRCLC_REQ  : FlbRemote.Caption := '������ �����������';
      NL_STOPRCLC_REQ   : FlbRemote.Caption := '���������� ��������';
      NL_DATAINFO_REQ   :
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         SetTexSB(3,'rtx:'+IntToStr(pDS.m_swData0)+' rrx:'+IntToStr(pDS.m_swData1));
         FlbRemTime.Caption := DateTimeToStr(dtTime) + ' ����: ' + FloatToStrF(abs(dtTime-Now)/EncodeTime(0, 0, 0, 1)/1000, ffFixed, 10, 1) + ' ���';
         NotifyConnect;
         m_byCoverState := pDS.m_swData3;
         m_blMDMConn    := (pDS.m_swData2 and $01);
         m_blGprsConn   := (pDS.m_swData2 shr 1);
       End;
      NL_STARTSRV_REQ   :
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbRemote.Caption := '���� �����: '+DateTimeToStr(dtTime);
       End;
      NL_STARTCLEX_REQ:
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbRemote.Caption := '������ ����: '+DateTimeToStr(dtTime);
       End;
      NL_SAVEUPD_REQ:
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbRemote.Caption := '������ ������: '+DateTimeToStr(dtTime);
       End;
      NL_STARTSRVGR_REQ   :
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbRemote.Caption := '������ ������ �������� ����: '+DateTimeToStr(dtTime);
       End;
      NL_STOPSRV_REQ    :
       Begin
         Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
         Move(pDS.m_sbyInfo[0],dtTime,sizeof(dtTime));
         FlbRemote.Caption := '������� ������: '+DateTimeToStr(dtTime);
       End;
      NL_L1INITOK_REQ: FlbRemote.Caption := '������ �������...';
      NL_L2INITOK_REQ: FlbRemote.Caption := '�������� �������...';
      NL_L3INITOK_REQ: FlbRemote.Caption := '����� ����� �������...';
      NL_L3SDLGO_REQ : FlbRemote.Caption := '����������� �������...';
      NL_L3SDLST_REQ : FlbRemote.Caption := '����������� ����������...';
      NL_L3TTMON_REQ : FlbRemote.Caption := '������ �������� �������...';
      NL_L3TTMOF_REQ : FlbRemote.Caption := '������� �������� �������...';
      NL_L3CTRON_REQ : FlbRemote.Caption := '������� ���������...';
      NL_L3CTROF_REQ : FlbRemote.Caption := '������� ��������...';
      NL_L3RSCOF_REQ : FlbRemote.Caption := '���������� ���������...';
      NL_L3RSCON_REQ : FlbRemote.Caption := '���������� ��������...';
      NL_L3RSSON_REQ : FlbRemote.Caption := '���������� �������...';
      NL_L3RMSOF_REQ : FlbRemote.Caption := '���.���������� ���������...';
      NL_L3RMSON_REQ : FlbRemote.Caption := '���.���������� ��������...';
      NL_START_TST_REQ : FlbRemote.Caption := '����������� ����������...';
      NL_STOP_TST_REQ  : FlbRemote.Caption := '����������� �����������...';
      NL_REM_INIT_REQ  : FlbRemote.Caption := '��������� ������������...';
      NL_L3ABOON_REQ : FlbRemote.Caption := '������� ���������...';
      NL_L3ABOOF_REQ : FlbRemote.Caption := '������� ��������...';
      NL_ABOCVRY_REQ : FlbRemote.Caption := '����� ��������...';
      NL_VMTCVRY_REQ : FlbRemote.Caption := '����� ��������...';
      NL_EXPRTOF_REQ : FlbRemote.Caption := '������� ����������...';
      NL_EXPRTON_REQ : FlbRemote.Caption := '������� �������...';
      NL_INITVMET_REQ: FlbRemote.Caption := '������������� ���������...';
      NL_QMETPARM_REQ: FlbRemote.Caption := '�������� �������...';
      NL_STRTFIND_REQ: FlbRemote.Caption := '����� ��������...';
      //NL_EXPRTIN_REQ : FlbRemote.Caption := '������� ����������...';
      //NL_L3RSCOF_REQ : m_blRemoteStic
     End;
End;
function CL3LmeModule.HiHandler(var pMsg:CMessage):Boolean;
Begin
 Result:=True;
  try
    if OnRemoteFunction(pMsg)=False then exit;
    case FState of
     LME_NULL_STATE    : Begin SetTexSB(1,'STNULL');OnNullStAction(pMsg);End;
     LME_POLL_STATE    : Begin SetTexSB(1,'STPOLL');OnPoolStAction(pMsg);End;
     LME_CALC_STATE    : Begin SetTexSB(1,'STCALC');OnCalcStAction(pMsg);End;
     LME_VIEW_STATE    : Begin SetTexSB(1,'STVIEW');OnViewStAction(pMsg);End;
     LME_GPLL_STATE    : Begin SetTexSB(1,'STPLLG');OnGPllStAction(pMsg);End;
     LME_GPLLALL_STATE : Begin SetTexSB(1,'STPLAG');OnGPllAllStAction(pMsg);End;
     //LME_PACK_STATE : OnPackStAction(pMsg);
    End;
  except
   Result:=True;
  end;
End;
{
  LME_GO_POLL_REQ       = 0;
  LME_STOP_POLL_REQ     = 1;
  LME_FIN_MTR_POLL_REQ  = 2;
  LME_FIN_CHN_POLL_REQ  = 3;
  mL1Module.DoHalfTime(Nil);
  mL2Module.DoHalfTime(Nil);
  mL3Module.DoHalfTime(Nil);
}
function CL3LmeModule.OnRemoteFunction(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    case pMsg.m_sbyType of
     LME_STOP_POLL_REQ:
     Begin
         case m_nCF.QueryType of
              QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
              Begin
               m_nPoolIndex := 0;
               StopPolling(pMsg);
               SetState(LME_NULL_STATE);
               m_blIsBackUp  := False;
              End;
              QWR_QWERY_SRV: StopQSRVMSG(1,pMsg);
          End;
          res := False;
     End;
     LME_STOP_POLL1_REQ:
     Begin
         case m_nCF.QueryType of
              QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
              Begin
               m_sALD.Reset;
               m_nPoolIndex := 1;
               StopPolling(pMsg);
               SetState(LME_NULL_STATE);
              End;
              QWR_QWERY_SRV: StopQSRVMSG(1,pMsg);
          End;
          res := False;
     End;
     QL_SETGENSETT_REQ:
     Begin
         InitGenSett(pMsg);
         res := False;
     End;
     QL_START_SYN_REQ:
     Begin
         StartDialSynchro(pMsg);
         res := False;
     End;
     QL_STOP_SYN_REQ:
     Begin
         StopDialSynchro(pMsg);
         res := False;
     End;
     QL_START_GPRS_REQ:
     Begin
         StartGPRS(pMsg);
         res := False;
     End;
     QL_STOP_GPRS_REQ:
     Begin
         StopGPRS(pMsg);
         res := False;
     End;
     QL_INIT_GPRS_REQ:
     Begin
         InitGPRS(pMsg);
         res := False;
     End;
     LME_DISC_POLL_REQ:
     Begin
         case m_nCF.QueryType of
              QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
              Begin
               DiscPolling(pMsg);
               SetState(LME_NULL_STATE);
               res := False;
              End;
              QWR_QWERY_SRV: StopQSRVMSG(0,pMsg);
          End;
          res := False;
     End;
     QL_OPCLS_RMST_REQ: Begin OpenCloseRemStat(pMsg);         res := False;End;
     QL_RESCT_RMST_REQ: Begin ResetCounterStat(pMsg);         res := False;End;
     QL_STPRS_RMST_REQ: Begin OpenRemState(pMsg);             res := False;End;
//     QL_STATS_RECC_REQ: Begin TL2Statistic.GetStatistic(pMsg);res := False;End;
     QL_START_TST_REQ : Begin StartDiagnostic(pMsg);          res := False;End;
     QL_STOP_TST_REQ  : Begin StopDiagnostic(pMsg);           res := False;End;
     QL_START_TSTM_REQ: Begin StartTransTime(pMsg);           res := False;End;
     QL_STOP_TSTM_REQ : Begin StopTransTime(pMsg);            res := False;End;
     QL_CONNM_METR_REQ: Begin ConnectMeter(pMsg);             res := False;End;
     QL_CONNM_ABON_REQ: Begin ConnectAbon(pMsg);              res := False;End;
     QL_SHLGO_DATA_REQ: Begin ShedulerGo(pMsg);               res := False;End;
     QL_SHLST_DATA_REQ: Begin ShedulerStop(pMsg);             res := False;End;
     QL_SHLST_INIT_REQ: Begin ShedulerInit(pMsg);             res := False;End;
     QL_TMSST_INIT_REQ: Begin InitTransTime(pMsg);            res := False;End;
     QL_EXPORT_DT_OF_REQ: Begin ExportOf(pMsg);               res := False;End;
     QL_EXPORT_DT_ON_REQ: Begin ExportON(pMsg);               res := False;End;
     QL_EXPORT_DTINI_REQ: Begin ExportIN(pMsg);               res := False;End;
     QL_INIT_VMET_REQ   : Begin InitVMeter(pMsg);             res := False;End;
     QL_START_FH_REQ    : Begin StartFH(pMsg);                res := False;End;
     QL_RCALC_DATA_REQ  : Begin SendRecalc(pMsg);             res := False;End;
     QL_RCALC_CPLT_REQ  : Begin OnReCalcStAction(pMsg);       res := False;End;
     QL_CHANDGE_IP_REQ  : Begin OnChandgeIP(pMsg);            res := False;End;
     QL_SAVE_DB_REQ     : Begin StartPackProc;                res := False;End;
     QL_CLOSE_USPD_REQ  : Begin SelfStop(pMsg);               res := False;End;
     QL_UPDAT_ARM_REQ   : Begin SelfUpdate(pMsg);             res := False;End;
     QL_RELOAD_USPRO_REQ: Begin SelfReload(pMsg);             res := False;End;
     QL_TURNOFF_REQ     : begin TurnOffPrg(pMsg);             res := False;end;
     QL_QWERYROUT_REQ   : begin QweryRouter(pMsg);            res := False;end;
     QL_QWERYSAVEDB_REQ : begin QwerySaveDB(pMsg);            res := False;end;
     QL_INIT_TREE_REQ   : begin InitTree(pMsg);               res := False;end;
     QL_RBOOT_DATA_REQ  : begin ReBootPrg(pMsg);              res := False;end;
     QL_QWERYTREE_REQ   : begin MessageTree(pMsg);            res := False;end;
     QL_QWERYSTATUSBAR_REQ: begin MessageStatBar(pMsg);       res := False;end;
     QL_QWERYSTATISTICABON_REQ : begin StatisticAbon(pMsg);   res := False;end;
    End;
    Result := res;
End;
procedure CL3LmeModule.OnNullStAction(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     TraceL(4,0,'(__)CL3LM::>OnPoolStAction');
     case pMsg.m_sbyType of
      LME_GO_POLL_REQ :
      Begin
        case m_nCF.QueryType of
             QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
             Begin
              SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
              //if m_nCF.IsFinder=True then Begin m_nCF.m_nSDL.OnStartFind;End else
              if m_nCF.IsFinder=True then
               StartFinder(pMsg)
              else
              Begin
              if m_blIsLocal=False then Begin GoPolling(pMsg);SetState(LME_POLL_STATE);exit;End;
               m_nCalcType := -1;
               if m_nCF.IsPreGraph=True then
               Begin
                //if m_nPoolIndex=0 then OnUpdateAllMeter else
                if m_nPoolIndex=0 then Begin if m_nSmartFinder=1 then m_nCF.m_nSDL.OnStartFind(-1,-1) else OnUpdateAllMeter;End;
                if m_nPoolIndex=1 then Begin GoPolling(pMsg);SetState(LME_POLL_STATE);End;
               End else
               if m_nCF.IsPreGraph=False then
               Begin
                if IsNewDay=True then
                Begin if m_nSmartFinder=1 then m_nCF.m_nSDL.OnStartFind(-1,-1) else OnUpdateAllMeter;End
                else  GoPolling(pMsg);SetState(LME_POLL_STATE);
               End;
              End;
             End;
             QWR_QWERY_SRV: CreateQSRVMSG(pMsg);//CreateHQWRMSG(pMsg);
          End;
      End;
      LME_GO_GRAPH_POLL_REQ:
      Begin
          //SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
          GoGraphPolling(pMsg);
          SetState(LME_GPLL_STATE);
      End;

      LME_GO_CTRL_POLL_REQ :
      Begin
          GoCtrlPolling(pMsg);
          SetState(LME_GPLL_STATE);
      End;
      LME_GO_ALLGRAPH_POLL_REQ:
      Begin
          //SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
          GoAllGraphPolling(pMsg);
          SetState(LME_GPLLALL_STATE);
      End;
      QL_DATA_GRAPH_REQ:
      Begin
          m_sALD.SetDateInfo(pMsg);
          LoadGraphScenario(pMsg);
      End;

      QL_DATA_CTRL_REQ: // ������ ����������  { ukrop ctrl step 2}
      Begin
        m_sALD.SetCTRLInfo(pMsg);
        LoadCTRLScenario(pMsg);
      End;
      QL_DATA_ALLGRAPH_REQ:
      Begin
        case m_nCF.QueryType of
             QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
             Begin
              SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
              m_sALD.SetDateInfo(pMsg);
              LoadAllGraphScenario(pMsg);
             End;
             QWR_QWERY_SRV: CreateQSRVMSG(pMsg);
          End;
      End;
      QL_LOAD_EVENTS_REQ:
      Begin
          case m_nCF.QueryType of
               QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
               Begin
                m_sALD.SetDateInfo(pMsg);
                LoadAllEventsScenario(pMsg);
               End;
               QWR_QWERY_SRV: CreateQEVTMSG(pMsg);
          End;
      End;
      QL_LOAD_EVENT_ONE_REQ:
      Begin
          m_sALD.SetShortDateInfo(pMsg);
          LoadEventsScenario(pMsg);
      End;
      QL_QRY_PARAM_REQ : Begin LoadMeterParam(pMsg);SetState(LME_POLL_STATE);End;
      QL_RBOOT_DATA_REQ: begin ReBootPrg(pMsg); end;
      QL_INITL1_REQ    : InitL1(pMsg);
      QL_INITL2_REQ    : InitL2(pMsg);
      QL_INITL3_REQ    : InitL3(pMsg);
      QL_INIT_PORT_L2_REQ : InitPortL2(pMsg);
     End;
End;
procedure CL3LmeModule.OnPoolStAction(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     case pMsg.m_sbyType of
      LME_FIN_MTR_POLL_REQ :
      Begin
       TraceL(4,pMsg.m_sbyIntID,'(__)CL3LM::>OnPoolFinMtrAction:'+IntToStr(pMsg.m_swObjID));
       SetTexSB(0,'������������ ���������� �'+IntToStr(pMsg.m_swObjID));
       if mL2Module.m_pMeter[pMsg.m_swObjID]<>Nil then
       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������� ����:'+mL2Module.m_pMeter[pMsg.m_swObjID].m_nP.m_schName);
       //pDS.m_swData0 := pMsg.m_swObjID;
       //SendMsgData(BOX_L3,pDS.m_swData0,DIR_L4TOL3,AL_UPDATEDATA_REQ,pDS);
      End;
      LME_FIN_CHN_POLL_REQ :
      Begin
       TraceL(4,pMsg.m_sbyIntID,'(__)CL3LM::>OnPoolFinChnAction:');
       SetTexSB(0,'���������� �� ������ �'+IntToStr(pMsg.m_swObjID)+' ��������');
       if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'��� ���������� ������ ��������.');
       OnCalculation(pMsg);
      End;
     End;
End;
procedure CL3LmeModule.OnCalculation(var pMsg:CMessage);
Var
     pDS  : CMessageData;
Begin
     case m_nCF.QueryType of
          QWR_EQL_TIME,QWR_QWERY_SHED:
          Begin
           //if (ChechState(pMsg)=True)or(m_nDataFinder=True) then
           if (ChechState(pMsg)=True) then
           Begin
            if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTCALC_REQ));
            FlbLocal.Caption := '������';SetTexSB(0,'����������!');SetTexSB(1,'STCALC');
            if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ����������.');
            SetState(LME_CALC_STATE);
            pDS.m_swData1 := m_nCalcType;
            pDS.m_swData2 := m_nParamID;
            SendMsgData(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_DATA_CALC_REQ,pDS);
            m_nWPoolTmr.OffTimer;
           End;
          End;
          QWR_FIND_SHED:
          Begin
           if m_blIsSlave=True then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTCALC_REQ));
           FlbLocal.Caption := '������';SetTexSB(0,'����������!');SetTexSB(1,'STCALC');
           if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ����������.');
           SetState(LME_CALC_STATE);
           pMsg.m_sbyFor := DIR_L4TOL3;
           pMsg.m_sbyType:= AL_DATA_CALC_REQ;
           FPUT(BOX_L3,@pMsg);
           m_nWPoolTmr.OffTimer;
          End;
     End;
End;
procedure CL3LmeModule.OnGPllStAction(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sMsg : CHMessage;
     i    : Integer;
Begin
     case pMsg.m_sbyType of
      LME_FIN_MTR_POLL_REQ :
      Begin
       TraceL(4,pMsg.m_sbyIntID,'(__)CL3LM::>OnGPllFinMtrAction:'+IntToStr(pMsg.m_swObjID));
       SetTexSB(0,'������� �� ���������� �'+IntToStr(pMsg.m_swObjID)+' ��������');
       if mL2Module.m_pMeter[pMsg.m_swObjID]<>Nil then
       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������� ����:'+mL2Module.m_pMeter[pMsg.m_swObjID].m_nP.m_schName);
      End;
      LME_FIN_CHN_POLL_REQ :
      Begin
       TraceL(4,pMsg.m_sbyIntID,'(__)CL3LM::>OnGpllFinChnAction:');
       SetTexSB(0,'���������� �� ������ �'+IntToStr(pMsg.m_swObjID)+' ��������');
       //for i:=0 to MAX_METER do if m_blMeterIndex[i]=False then SendMsg(BOX_L2,i,DIR_L3TOL2,QL_DATA_FIN_GRAPH_REQ);
       //FreeL2(pMsg);
       OnCalculation(pMsg);
       {
       SetTexSB(1,'STNULL');
       SendMsg(BOX_L2,pMsg.m_swObjID,DIR_L3TOL2,QL_DATA_FIN_GRAPH_REQ);
       SendMsg(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
       SendRSMsgM(CreateMSG(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ));

       SetState(LME_NULL_STATE);
       }
       //if m_nPoolCount=1 then if m_nCF.IsSlave=True then m_nStartTimer.OnTimer(10);
      End;
     End;
End;
procedure CL3LmeModule.OnGPllAllStAction(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sMsg : CHMessage;
     i    : Integer;
Begin
     try
     case pMsg.m_sbyType of
      LME_FIN_MTR_POLL_REQ :
      Begin
       //TraceL(4,pMsg.m_sbyIntID,'(__)CL3LM::>OnGPllFinMtrAction:'+IntToStr(pMsg.m_swObjID));
       SetTexSB(0,'������� �� ���������� �'+IntToStr(pMsg.m_swObjID)+' ��������');
       if mL2Module.m_pMeter[pMsg.m_swObjID]<>Nil then
       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������� ����:'+mL2Module.m_pMeter[pMsg.m_swObjID].m_nP.m_schName);
      End;
      LME_FIN_CHN_POLL_REQ :
      Begin
       //TraceL(4,pMsg.m_sbyIntID,'(__)CL3LM::>OnGpllFinChnAction:');
       SetTexSB(0,'���������� �� ������ �'+IntToStr(pMsg.m_swObjID)+' ��������');
       if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'��� ����������� ���������� ������ ��������.');
       //SetTexSB(1,'STNULL');
       if ChechState(pMsg)=True then
       Begin
        //for i:=0 to MAX_METER do if m_blMeterIndex[i]=False then
        //SendMsg(BOX_L2,i,DIR_L3TOL2,QL_DATA_FIN_GRAPH_REQ);
        //FreeL2(pMsg);
       End;
       OnCalculation(pMsg);
       {
       SendMsg(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
       SendRSMsgM(CreateMSG(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ));
       SetState(LME_NULL_STATE);
       //if m_nPoolCount=1 then if m_nCF.IsSlave=True then m_nStartTimer.OnTimer(10);
       if m_nPoolCount=1 then m_nStartTimer.OnTimer(10);
       }
      End;
     End;
     except
      TraceER('(__)CLEMD::>Error In CL3LmeModule.OnGPllAllStAction!!!');
     end;
End;
procedure CL3LmeModule.FreeL2(var pMsg:CMessage);
Begin
     nL2CS.Enter;
      mL2Module.ResetMeter(pMsg);
     nL2CS.Leave;
End;
procedure CL3LmeModule.OnCalcStAction(var pMsg:CMessage);
Var
     sMsg : CHMessage;

Begin
     TraceL(4,0,'(__)CL3LM::>OnCalcStAction');
     SetTexSB(0,'���������� ���������');
     SetTexSB(1,'STWAIT');
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'���������� ���������. ��������.');
     case pMsg.m_sbyType of
     AL_DATA_FIN_CALC_IND:
      Begin
       FreeL2(pMsg);
       CheckSpaceDB(m_nMaxSpaceDB);  //�� �������� �� ���� ������������
       if m_blQrySave=True then
       Begin
        StartPackProc;
        m_blQrySave := False;
       End else OnUpdateView(pMsg);
      End;
     End;
End;
procedure CL3LmeModule.QwerySaveDB(var pMsg:CMessage);
Begin
     CheckSpaceDB(m_nMaxSpaceDB);
     if m_blQrySave=True then
     Begin
      StartPackProc;
      m_blQrySave := False;
     End;
End;
procedure CL3LmeModule.InitTree(var pMsg:CMessage);
Begin
    if m_pDB.IsConnectDB=True then
    Begin
     FL3TreeLoader.m_blEnable := False;
     m_dwTree := 1;
     FL3TreeLoader.SelectTreeType;
    End;
End;

procedure CL3LmeModule.MessageTree(var pMsg:CMessage);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     i   : Integer;
     Node : TTreeNode;
     Str1 : String;
Begin
  try
    if m_pDB.IsConnectDB=True then
    Begin
     Str1:='���.(���)';
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     Move(pDS.m_sbyInfo[0] ,sQC,sizeof(SQWERYCMDID));
     with sQC do
     case m_snPrmID of
          0 : FL3TreeLoader.MessageRefreshTree(m_snSRVID,m_snPrmID,m_sdtBegin);  //������� ������ (����� ��������)
          1 : FL3TreeLoader.MessageRefreshTree(m_snSRVID,m_snPrmID,m_sdtBegin);  //������� ������ (�����)
          2 : FL3TreeLoader.MessageRefreshTree(m_snSRVID,m_snPrmID,m_sdtBegin);  //������� ������ (�������� ������ ���.)
          3 : FL3TreeLoader.MessageRefreshTree(m_snSRVID,m_snPrmID,m_sdtBegin);  //������� ������ (�������� ������ ���.)
     End;
    end;
     for i:=0 to GroupListBox.Count-1 do
       begin
         if GroupListBox.strings[i]=IntToStr(sQC.m_snSRVID)then
          begin
           Node:=TTreeNode(GroupListBox.Objects[i]);
               case (sQC.m_snPrmID) of
                   0: begin
                       Node.ImageIndex := 30;
                       Node.SelectedIndex := 30;
                       if Pos(Str1, Node.Text) > 0 then
                        Node.Text :=Str1+'/ '+ m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / ����� ��������'
                       else
                        Node.Text := m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / ����� ��������';
                       break;
                      end;
                   1: begin
                       Node.ImageIndex := 16;
                       Node.SelectedIndex := 16;
                       if Pos(Str1, Node.Text) > 0 then
                         Node.Text :=Str1+'/ '+ m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / �����'
                       else
                         Node.Text := m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / �����';
                       break;                       
                      end;
                   2: begin
                       Node.ImageIndex := 21;
                       Node.SelectedIndex := 21;
                       if Pos(Str1, Node.Text) > 0 then
                         Node.Text := Str1+'/ '+ m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / �������� ������(���.)'
                       else
                         Node.Text := m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / �������� ������(���.)';
                       break;                       
                      end;
                   3: begin
                       Node.ImageIndex   := 21;
                       Node.SelectedIndex:= 21;
                       if Pos(Str1, Node.Text) > 0 then
                        Node.Text := Str1+'/ '+ m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / �������� ������(���.)'
                       else
                        Node.Text := m_pDB.GetGroupQueryName(sQC.m_snSRVID) + ' / ' + DateToStr(date)+' '+TimeToStr(Now)+ ' / �������� ������(���.)';
                       break;                       
                      end;
               end;
          end;
       end;
  except
        if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'LME_MessageTree_ERROR');
  end;
End;

procedure CL3LmeModule.StatisticAbon(var pMsg:CMessage);
var
  pDS : CMessageData;
  sQC : SQWERYCMDID;
begin
  if m_pDB.IsConnectDB=True then Begin
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    Move(pDS.m_sbyInfo[0] ,sQC,sizeof(SQWERYCMDID));
    //TKnsForm.m_nQsFrame.PrepareQueryAbon(sQC);
  End;
end;

procedure CL3LmeModule.MessageStatBar(var pMsg:CMessage);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
    if m_pDB.IsConnectDB=True then
    Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     Move(pDS.m_sbyInfo[0] ,sQC,sizeof(SQWERYCMDID));
     with sQC do
     case m_snCmdID of
          0 : SetTexSB(1,'�������� �����: '+ IntToStr(m_snSRVID)+' �� '+IntToStr(m_snPrmID));//) Fpbm_sBTIPanelsImportl5.Items[1].Text:= '�������� �����: '+ IntToStr(m_snSRVID)+' �� '+IntToStr(m_snPrmID);  //������� ������ (0 �� 0 ��� 1 �� 2 � ��)
          1 : SetTexSB(2,'�������� � �������� ���������: '+ IntToStr(m_snSRVID)+' �� '+IntToStr(m_snPrmID));//Fpbm_sBTIPanelsImportl5.Items[2].Text:= '�������� ��������: '+ IntToStr(m_snSRVID)+' �� '+IntToStr(m_snPrmID);  //������� house (0 �� 0 ��� 1 �� 2 � ��)
          2 : SetTexSB(3,'��������� ��������: '+ IntToStr(m_snSRVID)+' �� '+IntToStr(m_snPrmID));//Fpbm_sBTIPanelsImportl5.Items[3].Text:= '��������� ��������: '+ IntToStr(m_snSRVID)+' �� '+IntToStr(m_snPrmID);  //������� house (0 �� 0 ��� 1 �� 2 � ��)
          3 : SetTexSB(1,'����� ������ ��������!');
          4 : SetTexSB(2,'����� �������� ��������!');
     End;
    End;
End;

procedure CL3LmeModule.OnQwerySaveDB;
Begin
     CheckSpaceDB(m_nMaxSpaceDB);
     if m_blQrySave=True then
     Begin
      StartPackProc;
      m_blQrySave := False;
     End;
End;
procedure CL3LmeModule.OnReCalcStAction(var pMsg:CMessage);
Var
     sMsg : CHMessage;
Begin
     TraceL(4,0,'(__)CL3LM::>OnReCalcStAction');
     SetTexSB(0,'�������� ��������');
     SetTexSB(1,'STWAIT');
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'�������� ��������. ��������.');
     if m_blQrySave=True then
     Begin
      StartPackProc;
      m_blQrySave := False;
     End else OnUpdateView(pMsg);
End;
function  CL3LmeModule.CheckSpaceDB(nSize:Integer):Boolean;
Var
     szSize : Integer;
Begin
 Result:=True;
  try
     if m_nMaxSpaceDB=-1 then exit;
     szSize := m_pDB.GetSizeDB;
     if szSize>=nSize*(1024*1024) then
     Begin
      m_pDB.FreeBase(m_nCF.CorrectClearPeriod);
      m_blQrySave:=True;
     End;
Except
  Result:=True;
end;
end;
procedure CL3LmeModule.OnPackStAction(var pMsg:CMessage);
Begin
     case pMsg.m_sbyType of
     QL_UPDATE_TMR:
      Begin
       PackData;
       FState := FSvState;
       if FSvState=LME_CALC_STATE then OnUpdateView(pMsg);
      End;
     End;
End;

procedure CL3LmeModule.OnUpdateView(var pMsg:CMessage);
var
     pDS  : CMessageData;
Begin
     //if m_nCF.IsLocal=True then FlbRemote.Caption := '�������� '+IntToStr(m_nCF.GenPoolPeriod)+' ������';
     if m_nCF.IsScheduler=False then
     Begin
      FlbLocal.Caption := '�������� '+IntToStr(m_nCF.GenPoolPeriod)+' ������';
      SetTexSB(0,'�������� '+IntToStr(m_nCF.GenPoolPeriod)+' ������');
     End else
     if m_nCF.IsScheduler=True then
     Begin
      FlbLocal.Caption := '�������� ';
      SetTexSB(0,'�������� ');
     End;
     //
     if m_sALD.Next=True then
     Begin
       AutoLoadNext;
       m_nSaveTimer.GoTimer;
      if (m_sALD.m_sblEnable=True)and(FCHECK(BOX_LOAD)=0) then
        Begin
         SendMsg(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
         SendRSMsgM(CreateMSG(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ));
        if m_blIsSlave=True  then
        Begin
         SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_WAITPOLL_REQ));
         SendRSMsgM(CreateMSG(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ));
        End;
       End;
      if ((m_nCF.IsPreGraph=True)and(m_nPoolIndex=1))or
         ((m_nCF.IsPreGraph=False)and(m_nPoolIndex=0)) then
      Begin
       SendMsg(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATESHEM_IND);
       SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_WAITPOLL_REQ));
       SendRSMsgM(CreateMSG(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_UPDATESHEM_IND));
      End;
      CheckPostQry;
      End else m_nPoolIndex := 1;
End;
procedure CL3LmeModule.CheckPostQry;
Begin
      if m_nCF.IsPreGraph=False then
      Begin
       m_nCF.SchedGo;
       if m_nCF.IsScheduler=False then m_nPoolTmr.OnTimer(m_nCF.GenPoolPeriod);
       SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
      End else
      if m_nCF.IsPreGraph=True then
      Begin
       if m_nPoolIndex=0 then
       Begin
        //m_blNextJob := True;
        m_nPoolTmr.OnTimer(3);
        m_nPoolIndex := 1;
       End else
       if m_nPoolIndex=1 then
       Begin
        m_nCF.SchedGo;
        if m_nCF.IsScheduler=False then m_nPoolTmr.OnTimer(m_nCF.GenPoolPeriod);
        m_nPoolIndex := 0;
        SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
       End;
      End;
End;
procedure CL3LmeModule.AutoLoadNext;
Var
    pMs : CHMessage;
    Count : Integer;
Begin
    m_blEndMyMsg := False;
    //if m_nCF.IsExport=True then
    Begin
     Count := FCHECK(BOX_LOAD);
     if Count<>0 then
     Begin
      SendMsg(BOX_L3_LME,DIR_LHTOLM3,DIR_LHTOLM3,LME_STOP_POLL1_REQ);
      FGET(BOX_LOAD,@pMs);
      FPUT(BOX_L3_LME,@pMs);
      if FCHECK(BOX_LOAD)=0 then
      Begin
       m_blEndMyMsg  := True;
       m_nDataFinder := False;
       if m_nCF.IsPreGraph=True then Begin m_nPoolIndex:=0;m_blNextJob:=True;End;
       CheckPostQry;
      end;
     End;
    End;
End;
procedure CL3LmeModule.CheckBaseCon;
Var
   res : Byte;
begin
   try
   if m_nCF.IsLocal=False then
   Begin
   {
    if (m_blConnectST=True) then
    Begin
     res := m_pDB.IsCommandInQMTable(1);
     if (res=0) then
     begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'������ ���������� � ��.');
      m_pDB.FullDisconnect;
      m_pDB.Connect;
      if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'�������������� ���������� � ��.')
     end;
    End;
   }
   End;
   m_nChBaseTmr.OnTimer(60);
   except
   end;
end;
procedure CL3LmeModule.StartFH(var pMsg:CMessage);
Var
     pDS : CMessageData;
     dwLoMask,nVMID : int64;
     ldtFTime,ldtETime : TDateTime;
     szDT     : Integer;
Begin
     szDT := sizeof(TDateTime);
     m_nDataFinder  := True;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     move(pDS.m_sbyInfo[0],ldtFTime, szDT);
     move(pDS.m_sbyInfo[szDT],ldtETime, szDT);
     move(pDS.m_sbyInfo[2*szDT],dwLoMask, sizeof(int64));
     move(pDS.m_sbyInfo[2*szDT+sizeof(int64)],nVMID, sizeof(int64));
     if pDS.m_swData4=MTR_LOCAL  then mL3FHModule.StartModule(pDS.m_swData0,pDS.m_swData1,ldtETime,ldtFTime,dwLoMask,nVMID,0);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '����� ������...';
     //if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L1INITOK_REQ));
End;
procedure CL3LmeModule.StartFinder(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin m_nCF.m_nSDL.OnStartFind(pDS.m_swData0,pDS.m_swData1); End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '����� ������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STRTFIND_REQ));
End;
procedure CL3LmeModule.StartPackProc;
Begin
     SetTexSB(0,'�������� ����');
     FSvState := FState;
     SetState(LME_PACK_STATE);
     m_pDB.DelSlices(m_nCF.GenClearPeriod);
     m_nPackTimer.OnTimer(4);
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_PACKSTART_REQ));
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_FULLDISC_REQ));
     if m_nCF.IsSlave=True  then
     Begin
      m_pDB.FullDisconnect;
     End else m_pDB.FullDisconnect;

End;
procedure CL3LmeModule.OnViewStAction(var pMsg:CMessage);
Begin
     TraceL(4,0,'(__)CL3LM::>OnViewStAction');
End;
//Actions
function CL3LmeModule.ChechState(var pMsg:CMessage):Boolean;
Var
     i   : Integer;
     res : Boolean;
Begin
     res := True;
     for i:=0 to MAX_PORT do
     Begin
      if m_blPortIndex[i]=False then
      Begin
       if m_nQrySender[i]<>Nil then
       if m_nQrySender[i].PState=QM_POOL_STATE then
       Begin
        res := False;
        break;
       End;
      End;
     End;
     Result := res;
End;

procedure CL3LmeModule.InitL1(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin mL1Module.Init; End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '�������� �������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L1INITOK_REQ));
End;
procedure CL3LmeModule.InitL2(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin mL2Module.Init; End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '�������� ���������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L2INITOK_REQ));
End;
procedure CL3LmeModule.InitPortL2(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin mL2Module.InitMeters(pDS.m_swData1); End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '�������� ���������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L2INITOK_REQ));
End;
procedure CL3LmeModule.InitL3(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     //if pDS.m_swData4=MTR_LOCAL  then Begin m_blHandInit:=True;mL3Module.OnLoadVMeters; m_blHandInit:=False;End;
     if pDS.m_swData4=MTR_LOCAL  then Begin m_blHandInit:=True;mL3Module.OnLoadAbonVMeters(pDS.m_swData1); m_blHandInit:=False;End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '�������� ����� �����...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3INITOK_REQ));
End;
procedure CL3LmeModule.InitGenSett(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin m_nCF.SetGenSettings; End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_REM_INIT_REQ));
End;
procedure CL3LmeModule.StartDialSynchro(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin m_nCF.m_nSDL.m_nGST.SettTime;End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.StopDialSynchro(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin m_nCF.m_nSDL.m_nGST.OnDisconnect;End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.StartGPRS(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     SendMSG(BOX_L1,0,DIR_L1TOGPRS,DL_START_ROUT_REQ);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.StopGPRS(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then SendMSG(BOX_L1,0,DIR_L1TOGPRS,DL_STOP_ROUT_REQ);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.InitGPRS(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));

     if pDS.m_swData4=MTR_LOCAL  then SendMSG(BOX_L1,0,DIR_L1TOGPRS,DL_INIT_ROUT_REQ);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.SelfStop(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin m_nCF.SelfStop;End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.SelfUpdate(var pMsg:CMessage);

Begin

End;
procedure CL3LmeModule.SelfReload(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin m_nCF.SelfReload;End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.QweryRouter(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then Begin if  Assigned(mQServer) then  mQServer.m_nQSB.EventHandler(pMsg);End;
     if pDS.m_swData4=MTR_REMOTE then Begin RepPrepare(pMsg);SendRMsg(pMsg);End;
End;

procedure CL3LmeModule.RepPrepare(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sQC  : SQWERYCMDID;
     szDT : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     Move(pDS.m_sbyInfo[0],sQC,sizeof(SQWERYCMDID));
     case sQC.m_snCmdID of
          QS_HQWR_SR,
          QS_UPDT_SR,
          QS_FIND_SR : Begin
                        sQC.m_snSRVID := -1;
                        sQC.m_snCLID  := -1;
                       End;
          QS_INIT_SR : Begin
                        sQC.m_snABOID := -1; 
                        sQC.m_snSRVID := -1;
                        sQC.m_snCLID  := -1;
                       End;
     End;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     Move(pDS,pMsg.m_sbyInfo[0],sizeof(CMessageData));
End;
procedure CL3LmeModule.CreateQSRVMSG(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sQC  : SQWERYCMDID;
     szDT : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     szDT := sizeof(TDateTime);
     sQC.m_snABOID := -1;
     sQC.m_snSRVID := -1;
     sQC.m_snCLID  := -1;
     sQC.m_snCLSID := -1;
     sQC.m_snVMID  := -1;
     sQC.m_snMID   := -1;
     sQC.m_snPrmID := pDS.m_swData1;
     Move(pDS.m_sbyInfo[0]   ,sQC.m_sdtEnd ,szDT);
     Move(pDS.m_sbyInfo[szDT],sQC.m_sdtBegin   ,szDT);
     if pDS.m_swData4=MTR_LOCAL  then sQC.m_snVMID  := pDS.m_swData0;
     if pDS.m_swData4=MTR_REMOTE then m_pDB.GetPHAddrL2(pDS.m_swData0,sQC.m_snVMID);
     if pDS.m_swData2=0          then sQC.m_snCmdID := QS_UPDT_AL;
     if pDS.m_swData2=1          then sQC.m_snCmdID := QS_FIND_AL;
     //pDS.m_swData4 := MTR_LOCAL;//AAV
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure CL3LmeModule.CreateHQWRMSG(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sQC  : SQWERYCMDID;
     szDT : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     szDT := sizeof(TDateTime);
     sQC.m_snABOID := -1;
     sQC.m_snSRVID := -1;
     sQC.m_snCLID  := -1;
     sQC.m_snCLSID := -1;
     sQC.m_snVMID  := -1;
     sQC.m_snMID   := -1;
     sQC.m_snPrmID := -1;
     sQC.m_snCmdID := QS_HQWR_SR;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure CL3LmeModule.StopQSRVMSG(byCause:Byte;var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sQC  : SQWERYCMDID;
     szDT : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     szDT := sizeof(TDateTime);
     sQC.m_snABOID := -1;
     sQC.m_snSRVID := -1;
     sQC.m_snCLID  := -1;
     sQC.m_snCLSID := -1;
     sQC.m_snVMID  := -1;
     sQC.m_snMID   := -1;
     //if LoWord(pDS.m_swData2)=MTR_LOCAL  then sQC.m_snVMID  := pDS.m_swData0;
     //if LoWord(pDS.m_swData2)=MTR_REMOTE then m_pDB.GetPHAddrL2(pDS.m_swData0,sQC.m_snVMID);
     if byCause=0 then sQC.m_snCmdID := QS_STOP_SR;
     if byCause=1 then sQC.m_snCmdID := QS_FREE_AL;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure CL3LmeModule.CreateQEVTMSG(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     sQC  : SQWERYCMDID;
     szDT : Integer;
     nJIM : int64;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     szDT := sizeof(TDateTime);
     sQC.m_snABOID := -1;
     sQC.m_snSRVID := -1;
     sQC.m_snCLID  := -1;
     sQC.m_snCLSID := CLS_EVNT;
     sQC.m_snVMID  := -1;
     sQC.m_snMID   := -1;
     sQC.m_snCmdID := QS_UPDT_AL;
     Move(pDS.m_sbyInfo[0]   ,sQC.m_sdtEnd ,szDT);
     Move(pDS.m_sbyInfo[szDT],sQC.m_sdtBegin   ,szDT);
     Move(pDS.m_sbyInfo[2*szDT],nJIM,sizeof(int64));
     if (nJIM and QFH_JUR_0)<>0  then sQC.m_snPrmID := QRY_JRNL_T1;
     if (nJIM and QFH_JUR_1)<>0  then sQC.m_snPrmID := QRY_JRNL_T2;
     if (nJIM and QFH_JUR_2)<>0  then sQC.m_snPrmID := QRY_JRNL_T3;
     if (nJIM and QFH_JUR_3)<>0  then sQC.m_snPrmID := QRY_JRNL_T4;
     if pDS.m_swData2=MTR_LOCAL  then sQC.m_snVMID  := pDS.m_swData1;
     if pDS.m_swData2=MTR_REMOTE then m_pDB.GetPHAddrL2(pDS.m_swData1,sQC.m_snVMID);
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure CL3LmeModule.SendRecalc(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      pMsg.m_sbyFor  := DIR_L4TOL3;
      pMsg.m_sbyType := AL_RECALC_IND;
      FPUT(BOX_L3,@pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.ReBootPrg(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then begin {PackData;} m_nCF.ReBootPrg; end;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������������ ����...';
End;

procedure CL3LmeModule.TurnOffPrg(var pMsg:CMessage);
var pDS : CMessageData;
begin
   Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
   m_nST.ExecSaveTime;
   if pDS.m_swData0 = 1 then PackBase;
   if pDS.m_swData1 = 0 then ReBoot(EWX_SHUTDOWN+EWX_FORCE) else
   if pDS.m_swData1 = 1 then ReBoot(EWX_REBOOT+EWX_FORCE);
end;
procedure CL3LmeModule.ReBoot(dwReborFunction:DWord);
var 
    hproc, htoken: THandle;
    ht      : cardinal;
    luid    : int64;
    luidattr: LUID_AND_ATTRIBUTES;
    priv    : Token_Privileges;
    r   : DWORD;
    res : BOOL;
    dal : LongBool;
    buf : PChar;
begin
    hProc:=GetCurrentProcess;
    hToken:=0;
    OpenProcessToken(hProc, TOKEN_ADJUST_PRIVILEGES, hToken);
    LookupPrivilegeValue(nil, 'SeShutDownPrivilege', luid);
    luidattr.Luid       := luid;
    luidattr.Attributes := SE_PRIVILEGE_ENABLED;
    priv.PrivilegeCount := 1;
    priv.Privileges[0]  := luidattr;
    r:=0;
    res:=AdjustTokenPrivileges(hToken, false, priv, 0, nil, r);
    ExitWindowsEx(dwReborFunction,0);
end;
function CL3LmeModule.PackBase:Boolean;
Var
     strPackPath   : String;
     res : Boolean;
     pMsg : CMessage;
begin
     res := False;
     //Save
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'��������! ������ ����. ��������� ���������� ��������.');
     if m_nCF.IsRamDrive=False then
        strPackPath   := 'gbak -b -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+
        ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FDB ' +ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK' else
     if m_nCF.IsRamDrive=True then
        strPackPath   := 'gbak -b -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' r:\ascue\SYSINFOAUTO.FDB '+ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK';
     //Extract
     res := StartProcess(strPackPath,TRUE);
     Result := True;
end;


procedure CL3LmeModule.ShedulerGo(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.SchedGo;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ ������������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3SDLGO_REQ));
End;
procedure CL3LmeModule.ShedulerStop(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.SchedPause;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������� ������������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3SDLST_REQ));
End;
procedure CL3LmeModule.ShedulerInit(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.SchedInit;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ ���������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_REM_INIT_REQ));
End;
procedure CL3LmeModule.InitTransTime(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.m_nTT.OnLoadModule;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ ���������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_REM_INIT_REQ));
End;
procedure CL3LmeModule.StartTransTime(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.m_nTT.OnEnable:=True;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ �������� �������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3TTMON_REQ));
End;
procedure CL3LmeModule.StopTransTime(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.m_nTT.OnEnable:=False;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������� �������� �������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3TTMOF_REQ));
End;
procedure CL3LmeModule.OnChandgeIP(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then m_nCF.OnChandgeIP0;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '��������� IP ������...';
     //if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3TTMOF_REQ));
End;
procedure CL3LmeModule.ConnectMeter(var pMsg:CMessage);
Var
     pDS       : CMessageData;
     nMID,nVMID,nSET:Integer;
     byCommand : Byte;
     str       : String;
Begin
    byCommand:=0;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     nVMID := pDS.m_swData0;
     nMID  := pDS.m_swData1;
     nSET  := pDS.m_swData2;
     if pDS.m_swData4=MTR_LOCAL  then OpenCloseMeter(nMID,nVMID,nSET);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if nSET=0 then Begin byCommand:=NL_L3CTROF_REQ;str:='���������� ��������...'; End else
     if nSET=1 then Begin byCommand:=NL_L3CTRON_REQ;str:='����������� ��������...';End;
     if m_blIsSlave=False then FlbLocal.Caption := str;
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,byCommand));
End;
procedure CL3LmeModule.OpenCloseMeter(nMID,nVMID,nSET:Integer);
Begin
     if nSet=0 then begin
       m_pDB.Exclude_VMeter(nMID,nVMID);
//       m_pDB.FixUspdEvent(nVMID,0,EVH_EXCL_METER);
     end else
     if nSet=1 then begin
       m_pDB.Include_VMeter(nMID,nVMID);
//       m_pDB.FixUspdEvent(nVMID,0,EVH_INCL_METER);
     end;
     mL3Module.OnLoadVMeter(nVMID);
     mL2Module.InitMeter(nMID);
End;

procedure CL3LmeModule.ConnectAbon(var pMsg:CMessage);
Var
     pDS       : CMessageData;
     nAID,nSET : Integer;
     byCommand : Byte;
     str       : String;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     nAID := pDS.m_swData0;
     nSET := pDS.m_swData2;
     if pDS.m_swData4=MTR_LOCAL  then OpenCloseAbon(nAID,nSET);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if nSET=0 then Begin byCommand:=NL_L3ABOOF_REQ;str:='���������� ��������...'; End else
     if nSET=1 then Begin byCommand:=NL_L3ABOON_REQ;str:='����������� ��������...';End;
     if m_blIsSlave=False then FlbLocal.Caption := str;
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,byCommand));
End;
procedure CL3LmeModule.OpenCloseAbon(nAID,nSET:Integer);
Begin
     if nSet=0 then begin
       m_pDB.Exclude_Abon(nAID);
//       m_pDB.FixUspdDescEvent(0,3,EVS_EXCL_ABON,nAID);
     end else
     if nSet=1 then begin
       m_pDB.Include_Abon(nAID);
//       m_pDB.FixUspdDescEvent(0,3,EVS_INCL_ABON,nAID);
     end;
     mL3Module.OnLoadAbon(nAID);
     mL2Module.InitAbon(nAID);
End;

procedure CL3LmeModule.OpenCloseRemStat(var pMsg:CMessage);
Var
     pDS       : CMessageData;
     byCommand : Byte;
     str       : String;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
//     if pDS.m_swData4=MTR_LOCAL  then TL2Statistic.OnSetStat(pDS); {TL2Statistic.POnRemStat := pDS.m_swData0};
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if pDS.m_swData0=0 then Begin byCommand:=NL_L3RSCOF_REQ;str:='���������� ����������...'; End else
     if pDS.m_swData0=1 then Begin byCommand:=NL_L3RSCON_REQ;str:='����������� ����������...';End;
     if m_blIsSlave=False then FlbLocal.Caption := str;
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,byCommand));
end;
procedure CL3LmeModule.ResetCounterStat(var pMsg:CMessage);
Var
     pDS       : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
//     if pDS.m_swData4=MTR_LOCAL  then TL2Statistic.ResetCounter;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '��������� ����������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_L3RSSON_REQ));
end;
procedure CL3LmeModule.OpenRemState(var pMsg:CMessage);
Var
     pDS       : CMessageData;
     byCommand : Byte;
     str       : String;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
//     if pDS.m_swData4=MTR_LOCAL  then TL2Statistic.SetRemState(pDS);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if pDS.m_swData0=0 then Begin byCommand:=NL_L3RMSOF_REQ;str:='����.��������� ����������...';End else
     if pDS.m_swData0=1 then Begin byCommand:=NL_L3RMSON_REQ;str:='���. ��������� ����������...';End;
     if m_blIsSlave=False then FlbLocal.Caption := str;
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,byCommand));
end;
procedure CL3LmeModule.StartDiagnostic(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then SendMSG(BOX_L3_HF,0,DIR_L4TOL3,SL_START_TST_REQ);;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ �����������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_START_TST_REQ));
End;
procedure CL3LmeModule.StopDiagnostic(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then SendMSG(BOX_L3_HF,0,DIR_L4TOL3,SL_STOP_TST_REQ);;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := 'O������ �����������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STOP_TST_REQ));
End;
procedure CL3LmeModule.ExportOF(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������� ��������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_EXPRTOF_REQ));
End;
procedure CL3LmeModule.ExportON(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ ��������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_EXPRTON_REQ));
End;
procedure CL3LmeModule.ExportIN(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ ���������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_REM_INIT_REQ));
End;

procedure CL3LmeModule.InitVMeter(var pMsg:CMessage);
Var
     pDS : CMessageData;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then mL3Module.OnLoadVMeter(pDS.m_swData0);
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     if m_blIsSlave=False then FlbLocal.Caption := '������ ���������...';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_INITVMET_REQ));
End;
procedure CL3LmeModule.LoadMeterParam(var pMsg:CMessage);
Var
     pDS       : CMessageData;
     byCommand : Byte;
     str       : String;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      if IsCurrent(pDS.m_swData1)=true then
      Begin
       m_nCalcType := -2;
       m_nParamID  :=  pDS.m_swData1;
      End;
      nL2CS.Enter;
      mL2Module.LoadMeterParam(pDS);
      nL2CS.Leave;
     end;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     byCommand:=NL_QMETPARM_REQ;str:='������ ���������...';
     if m_blIsSlave=False then FlbLocal.Caption := str;
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,byCommand));
end;
procedure CL3LmeModule.LoadGraphScenario(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i   : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     m_nCalcType:=pDS.m_swData1;
     SetTexSB(0,'������������� ������� �� ����������');
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ������ ��������.');
     m_nPoolTmr.OffTimer;
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      pMsg.m_sbyType := DL_LOAD_ONE_METER_IND;
      pMsg.m_sbyFor  := DIR_LMTOL2;
      FPUT(BOX_L2,@pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;


procedure CL3LmeModule.LoadCTRLScenario(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i   : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     m_nCalcType:=pDS.m_swData1;
     SetTexSB(0,'����������� ���������� ����������');
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ���������� �����������.');
     m_nPoolTmr.OffTimer;
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      pMsg.m_sbyType := DL_LOAD_ONE_METER_CTRL_IND;
      pMsg.m_sbyFor  := DIR_LMTOL2;
      FPUT(BOX_L2,@pMsg);  { ukrop ctrl step 2->3}
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;

procedure CL3LmeModule.LoadAllGraphScenario(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i   : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     m_nCalcType:=pDS.m_swData1;
     SetTexSB(0,'������������� ������� �� ���� ���������');
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ������ ��������.');
     m_nPoolTmr.OffTimer;
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      pMsg.m_sbyType := DL_LOADMETER_IND;
      pMsg.m_sbyFor  := DIR_LMTOL2;
      FPUT(BOX_L2,@pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.LoadAllEventsScenario(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i   : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     m_nCalcType:=pDS.m_swData1;
     SetTexSB(0,'������������� ������� �� ���� ���������');
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'������ ������ �������.');
     m_nPoolTmr.OffTimer;
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      pMsg.m_sbyType := DL_LOAD_EV_METER_IND;
      pMsg.m_sbyFor  := DIR_LMTOL2;
      pMsg.m_sbyDirID := pDS.m_swData0;
      FPUT(BOX_L2,@pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.LoadEventsScenario(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i   : Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     m_nCalcType:=pDS.m_swData1;
     SetTexSB(0,'������������� ������� �� ���� ���������');
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'������ ������ �������.');
     m_nPoolTmr.OffTimer;
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      pMsg.m_sbyType  := DL_LOAD_EV_METER_IND;
      pMsg.m_sbyFor   := DIR_LMTOL2;
      pMsg.m_sbyDirID := pDS.m_swData0;
      pMsg.m_swObjID  := pDS.m_swData2;
      nL2CS.Enter;
      mL2Module.LoadEvOneMeter(pMsg);
      nL2CS.Leave;
      //FPUT(BOX_L2,@pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
End;
procedure CL3LmeModule.GoPolling(var pMsg:CMessage);
Var
     i   : Integer;
     pDS : CMessageData;
     dtTime : TDateTime;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     for i:=0 to MAX_PORT do
     Begin
      if m_blPortIndex[i]=False then
      Begin
       case pDS.m_swData4 of
        MTR_REMOTE: if mL1Module.m_sIniTbl.Items[i].m_sbyControl=1 then SendRMsg(pMsg);
        MTR_LOCAL : if m_nQrySender[i]<>Nil then m_nQrySender[i].GoSender;
       End;
      End;
     End;
     m_nSaveTimer.GoTimer;
     //if m_nCF.IsSlave=True then
     Begin
      dtTime := Now;
      Move(dtTime,pDS.m_sbyInfo[0],sizeof(dtTime));
      SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_STARTSRV_REQ,pDS));
     End;
     FlbLocal.Caption := '���� �����: '+DateTimeToStr(Now);
     m_nCF.SchedPause;
     m_nWPoolTmr.OnTimer(60*m_nWPollTime);
End;
procedure CL3LmeModule.GoGraphPolling(var pMsg:CMessage);
Var
     pDS    : CMessageData;
     dtTime : TDateTime;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     SetTexSB(0,'������������� ������� �� ���������� '+IntToStr(pDS.m_swData2));
     SetTexSB(1,'STPLLG');
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      if m_nQrySender[pDS.m_swData3]<>Nil then
      m_nQrySender[pDS.m_swData3].GoSenderGraph(pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);
     //if m_nCF.IsSlave=True then
     Begin
      dtTime := m_sALD.m_sdtArchTmpTime;
      Move(dtTime,pDS.m_sbyInfo[0],sizeof(dtTime));
      SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_STARTSRVGR_REQ,pDS));
     End;
     FlbLocal.Caption := '������ ������ ��������: '+DateTimeToStr(m_sALD.m_sdtArchTmpTime);
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,FlbLocal.Caption);
     m_nCF.SchedPause;
     m_nWPoolTmr.OnTimer(60*m_nWPollTime);
End;

{*******************************************************************************
 *  ���������� ���������� �����������
 *  Ukrop
 ******************************************************************************}
procedure CL3LmeModule.GoCtrlPolling(var pMsg:CMessage);
Var
     pDS    : CMessageData;
     dtTime : TDateTime;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     SetTexSB(0,'����������� ���������� ����������� '+IntToStr(pDS.m_swData2));
     SetTexSB(1,'STPLLG');
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      if m_nQrySender[pDS.m_swData3]<>Nil then
      m_nQrySender[pDS.m_swData3].GoSenderGraph(pMsg);
     End;
     if pDS.m_swData4=MTR_REMOTE then SendRMsg(pMsg);

     FlbLocal.Caption := '���������� ����������� ';
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,FlbLocal.Caption);
     m_nCF.SchedPause;
     m_nWPoolTmr.OnTimer(60*m_nWPollTime);
End;

procedure CL3LmeModule.GoAllGraphPolling(var pMsg:CMessage);
Var
     pDS : CMessageData;
     i : Integer;
     dtTime : TDateTime;
Begin
     SetTexSB(0,'������������� ������� �� ���� ���������');
     SetTexSB(1,'STPLAG');
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'������ ������ ��������.');
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     if pDS.m_swData4=MTR_LOCAL  then
     Begin
      for i:=0 to MAX_PORT do
      if m_nQrySender[i]<>Nil then
      Begin
       if m_blPortIndex[i]=False then
       m_nQrySender[i].GoSenderAllGraph(pDS.m_swData2);
      End;
     End;
     if pDS.m_swData4=MTR_REMOTE then if mL1Module.m_sIniTbl.Items[i].m_sbyControl=1 then SendRMsg(pMsg);
     //if m_nCF.IsSlave=True then
     Begin
      dtTime := m_sALD.m_sdtArchTmpTime;
      Move(dtTime,pDS.m_sbyInfo[0],sizeof(dtTime));
      SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_STARTSRVGR_REQ,pDS));
     End;
     FlbLocal.Caption := '������ ������ ��������: '+DateTimeToStr(m_sALD.m_sdtArchTmpTime);
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,FlbLocal.Caption);
     m_nCF.SchedPause;
     m_nWPoolTmr.OnTimer(60*m_nWPollTime);
End;
procedure CL3LmeModule.StopPolling(var pMsg:CMessage);
Var
     i   : Integer;
     pDS : CMessageData;
     dtTime : TDateTime;
Begin
     SetTexSB(0,'������� �������');
     SetTexSB(1,'STNULL');
     //m_nPauseCM := False;
     m_nSaveTimer.OffTimer;
     m_nPoolTmr.OffTimer;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     for i:=0 to MAX_PORT do
     Begin
      if m_blPortIndex[i]=False then
      case pDS.m_swData4 of
       MTR_REMOTE: if mL1Module.m_sIniTbl.Items[i].m_sbyControl=1 then SendRMsg(pMsg);
       MTR_LOCAL : if m_nQrySender[i]<>Nil then m_nQrySender[i].StopSender;
      End;
     End;
     //for i:=0 to MAX_METER do if m_blMeterIndex[i]=False then SendMsg(BOX_L2,i,DIR_L3TOL2,QL_DATA_FIN_GRAPH_REQ);
     FreeL2(pMsg);
     SendMsg(BOX_L3,pMsg.m_swObjID,DIR_L4TOL3,AL_RESETPARAMS_REQ);
     //if m_nCF.IsSlave=True then
     Begin
      dtTime := Now;
      Move(dtTime,pDS.m_sbyInfo[0],sizeof(dtTime));
      SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_STOPSRV_REQ,pDS));
     End;
     FlbLocal.Caption := '������� ������: '+DateTimeToStr(Now);
     SendMSG(BOX_L4,0,DIR_LMETOL4,AL_STOPL2_IND);
     if m_blNextJob=True then m_nPoolTmr.OnTimer(3);
End;
procedure CL3LmeModule.DiscPolling(var pMsg:CMessage);
Var
     i   : Integer;
     pDS : CMessageData;
Begin
     SetTexSB(0,'������� �������');
     SetTexSB(1,'STNULL');
     m_nSaveTimer.OffTimer;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     for i:=0 to MAX_PORT do
     Begin
      if m_blPortIndex[i]=False then
      case pDS.m_swData4 of
       MTR_REMOTE: if mL1Module.m_sIniTbl.Items[i].m_sbyControl=1 then SendRMsg(pMsg);
       MTR_LOCAL : if m_nQrySender[i]<>Nil then
       case m_nCF.QueryType of
          QWR_EQL_TIME,QWR_QWERY_SHED : m_nQrySender[i].DiscSender;
          QWR_FIND_SHED               : if pDS.m_swData3=0 then m_nQrySender[i].DiscSender else m_nQrySender[i].DiscCauseSender;
       End;
      End;
     End;
     //AutoLoadNext;
End;

procedure CL3LmeModule.OnSaveAction;
Var
     pMsg : CMessage;
Begin
     TraceL(4,0,'(__)CL3LM::>OnSaveAction');
     //m_sblLastDTNight := Now;
     m_blQrySave := True;
     AutoKorrEvent;
End;

//m_nLastCorrTime
procedure CL3LmeModule.AutoKorrEvent;
var Fl      : TINIFile;
    NewTime : TDateTime;
begin
   if (m_nAutoKorrDay = 0) or (m_nLastCorrTime = 0) then
   begin
     m_nLastCorrTime := Now;
     exit;
   end;
   Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\\Settings\\USPD_Config.ini');
   blAutoKorr := true;
   NewTime := Now + (Now - m_nLastCorrTime) / EncodeTime(1, 0, 0, 0) * m_nAutoKorrDay / 24 * EncodeTime(0, 0, 1, 0);
//   (Now - m_nLastCorrTime) / EncodeTime(1, 0, 0, 0) - ����� � �����
//   m_nAutoKorrDay / 24  (����� � �������� �� � �� ���)
   cDateTimeR.SetTimeToPC(NewTime);
   m_nLastCorrTime := Now;
   Fl.WriteString('TIMECONFIG', 'm_nLastCorrTime', DateTimeToStr(Now));
   Fl.Destroy;
end;

procedure CL3LmeModule.SetState(byState:Byte);
Begin
    TraceL(4,0,'(__)CL3LM::>ST:'+chLmeState[FState]+'->ST:'+chLmeState[byState]);
    FState := byState;
End;
procedure CL3LmeModule.StopLayer;
Begin
     m_byLayerState := 0;
End;
procedure CL3LmeModule.StartLayer;
Begin
     m_byLayerState := 1;
End;

function CL3LmeModule.PackData:Boolean;
Var
     strPackGFPath   : String;
     strPackPath   : String;
     strExtrSvPath : String;
     strExtrPath   : String;
     res : Boolean;
     pMsg : CMessage;
     Fl : TINIFile;
begin
     res := False;
     //Save
     saveSetBaseProp;
     m_sblLastDTNight := False;
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
     if DBAddFieldEn=1 then
     Begin
      Fl  := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\\Settings\\USPD_Config.ini');
      Fl.WriteInteger('DBCONFIG','DBAddFieldEn', 0);
      Fl.Destroy;
     End;
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'��������! ������ ����. ��������� ���������� ��������.');
        //gfix -user sysdba -password masterkey -shut multi -force 0 C:\a2000\ascue\SYSINFOAUTO.FDB
        strPackGFPath   := 'gfix -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' -shut multi -force 0 '+
        ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FDB ';
     if m_nCF.IsRamDrive=False then
        strPackPath   := 'gbak -b -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+
        ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FDB ' +ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK' else
     if m_nCF.IsRamDrive=True then
        strPackPath   := 'gbak -b -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' r:\ascue\SYSINFOAUTO.FDB '+ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK';
     //Extract
     if m_nCF.IsRamDrive=False then
        strExtrPath   := 'gbak -rep -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+
        ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK '+ ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FDB' else
     if m_nCF.IsRamDrive=True then
        strExtrPath   := 'gbak -rep -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK '+'r:\ascue\SYSINFOAUTO.FDB';
     SetState(LME_POLL_STATE);
     //res := StartProcess(strPackGFPath,TRUE);
     res := StartProcess(strPackPath,TRUE);
     res := StartProcess(strExtrPath,TRUE);
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'������ ���� ���������');
     saveRemBaseProp;
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_CONNECTDB_REQ));
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SAVEDBOK_REQ));

     if m_nCF.IsSlave=True then
     Begin
      res :=m_pDB.Connect;
     End else res := m_pDB.Connect;
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
     //function CopyBase(strSrc,strDst:String):Boolean;
     //if res=True then m_nCF.m_nBA.CopyFile(ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK',ExtractFilePath(Application.ExeName)+'Restore\SYSINFOAUTO.FBK');

     Result := True;
end;
function CL3LmeModule.StartProcess(strPath:String;blWait:Boolean):Boolean;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     si.cb := sizeof(si);
     si.wShowWindow:=SW_HIDE;
     si.dwFlags:= STARTF_USESHOWWINDOW;
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, NORMAL_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      TraceL(4,0,':Process is not created');
      result := FALSE;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,14*60*1000);
      if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     CloseHandle( pi.hProcess );
     CloseHandle( pi.hThread );
     result := True;
end;

procedure CL3LmeModule.DoSaveTimer;
var hour, min, sec, ms : word;
begin
   if m_nCF.m_pGenTable.m_sStorePeriod<>13 then m_nSaveTimer.RunTimer else
   Begin
    DecodeTime(m_stTimeBSave, hour, min, sec, ms);
    if (frac(Now) >= EncodeTime(hour, min, 0, 0)) and (frac(Now) <= EncodeTime(hour, min, 30, 0))
    and (m_sblLastDTNight=False) then
    Begin
     m_sblLastDTNight := True;
     OnSaveAction;
    End;
   End;
end;

procedure CL3LmeModule.DoHalfTime(Sender:TObject);
Var
     i      : Integer;
     pDS    : CMessageData;
     dtTime : TDateTime;
     szQry,szCQry : Integer;
     szBuf,szCBuf : Dword;
     wnd    : HWND;
Begin
   {   if (m_nLmeCounter mod m_nUpdateTime)=0 then
      Begin
       pDS.m_swData0 := m_dwIN;
       pDS.m_swData1 := m_dwOut;
       pDS.m_swData2 := m_blMDMConn or (m_blGprsConn shl 1);
       pDS.m_swData3 := m_byCoverState;
       dtTime := Now;
       Move(dtTime,pDS.m_sbyInfo[0],sizeof(dtTime));
       //if m_nCF.IsSlave=True  then SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_DATAINFO_REQ,pDS)) else
       //if m_nCF.IsSlave=False then SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_DATAINFO_REQ,pDS));
       SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_DATAINFO_REQ,pDS));
       //SetTexSB(7,'��������:'+IntToStr(FCHECK(BOX_LOAD)));
     End;

     //if m_nCF.IsSlave=False then
     //Begin
     {
     case m_nCF.QueryType of
              QWR_EQL_TIME,QWR_QWERY_SHED,QWR_FIND_SHED :
              Begin
               m_sALD.Reset;
               m_nPoolIndex := 1;
               StopPolling(pMsg);
               SetState(LME_NULL_STATE);
              End;
              QWR_QWERY_SRV: StopQSRVMSG(1,pMsg);
     }
     // if (m_nLmeCounter mod 1)=0 then
    //  Begin
     //  szBuf := 0; szCQry:=0; szCBuf:=0;
       //if m_nCF.QueryType<>QWR_QWERY_SRV then
       //szQry := FCHECK(BOX_LOAD) else
      // if m_nCF.QueryType=QWR_QWERY_SRV then
     //  Begin
        //szQry  := FCHECK(BOX_SSRV);
      //  szBuf  := FNABSSIZE(BOX_SSRV);
      //  szCQry := FCHECK(BOX_CSRV);
     //   szCBuf := FNABSSIZE(BOX_CSRV);
      // End;
       //if szQry=0 then m_nDataFinder := False;
     //  SetTexSB(6,'��������:'+IntToStr(szQry)+':'+IntToStr(szBuf));
    //   if m_nCF.QueryType=QWR_QWERY_SRV then
    //   SetTexSB(3,'Type:'+IntToStr(szCQry)+':'+IntToStr(szCBuf));
   //   End;
{     //End;
     Inc(m_nLmeCounter);
      //if m_nCF.IsLocal=True then FlbRemTime.Caption := DateTimeToStr(Now);
      //NotifyConnect;

//     m_nPackTimer.RunTimer;
       m_nStartTimer.RunTimer;
//     m_nProtoSvTmr.RunTimer;
//     m_nPoolTmr.RunTimer;
//     m_nConnTmr.RunTimer;
 //    m_nWPoolTmr.RunTimer;
 //    m_nChBaseTmr.RunTimer;
     //m_nSaveTimer.RunTimer

//     DoSaveTimer;

     if ((m_nLmeCounter mod 20)=0)and(m_nQweryReboot=0) then
     Begin
      wnd := FindWindow(LPCTSTR('TTKnsMonitor'), nil);
      if wnd <> 0 then SendMessage(wnd,WM_SENDTOMONITOR, 0, 0);
     End;   }

End;

end.
