unit knsl2module;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,knsl5config,
    utldynconnect,
    knsl2Nullmeter,
    knsl2ss101meter,
    knsl2ss301f3meter,
    knsl2ce6850meter,
    knsl2ce6822meter,
    knsl2ee8005meter,
    knsl2meter,
    utldatabase,
    knsl3querysender,
    knsl2BTIInit,
    knsl2BTIModule,
    knsl2a2000meter,
    knsl2C12Module,
    knsl2EA8086Meter,
    knsl2CE06005Meter,
    knsl2CE301BYMeter,
    knsl2uspd16401bmeter,
    knsl2fmtime,
    knsl2K2KBytmeter,
    knsl2MIRT1Meter,
    knsl2CET7007Meter,
    knsl2CE16401MMeter,
    knsl2MIRT1W2Meter,
    knsl2CE102Meter,
    knsl3EventBox,
    utlThread;
type
    MetersType = array [0..MAX_METER] of CMeter;
    PMeters =^ MetersType;
    CL2Module = class;
    PCMeter = ^CMeter;
    CL2Module = class(CThread)
    private
     m_nLID    : Byte;
     m_swAmMeter : Word;
     m_nMsg    : CMessage;
     m_sIniTbl : SL2INITITAG;
     //FTimer    : TTimer;
     m_sPIniTbl: PSL2INITITAG;
     m_pPMeter : PMeters;
     //csBusy    : TCriticalSection;
     //m_nQrySender   : array[0..MAX_PORT] of CQuerySender;
    public
     m_pMeter  : MetersType;
     procedure Init;
     procedure InitMeters(nPortID:Integer);
     function  InitPortAbon(nPort:Integer):Boolean;
     procedure InitMeter(nMID:Integer);
     procedure InitAbon(nAID:Integer);
     procedure InitScenario(nIndex:Integer);
     procedure DelNodeLv(nIndex:Integer);
     procedure AddNodeLv(pTbl:SL2TAG);
     procedure EditNodeLv(pTbl:SL2TAG);
     procedure LoadMeter(var pMsg:CMessage);
     procedure LoadOneMeter(var pMsg:CMessage);

     procedure LoadOneMeterCTRL(var pMsg:CMessage); // Ukrop

     procedure ResetMeter(var pMsg:CMessage);
     procedure LoadObserver(nPortID:Integer);
     procedure LoadMeterParam(var pDS:CMessageData);
     procedure LoadObserverGraph(var pMsg:CMessage);
     procedure LoadObserverCtrl(var pMsg:CMessage); // Ukrop
     procedure LoadObserverAllGraph(nPortID:Integer);
     procedure LoadEvMeter(var pMsg:CMessage);
     procedure LoadEvOneMeter(var pMsg:CMessage);
     procedure StopChnlObserve(nPortID:Integer);
     procedure PrepareSynchro;
     procedure StartChnlObserve(nPortID:Integer);
     procedure GoChnlObserve(nPortID:Integer);
     procedure DoHalfTime(Sender:TObject);
     procedure DoHalfSpeedTime(Sender:TObject);
     function  GetL2Object(nMID:Integer):PCMeter;
     function getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):PCMeter;

    private
     procedure OpenPortGate(nPortID:Integer);
     procedure ClosePortGate(nPortID:Integer);
     procedure OnHandler;
     procedure Execute; override;
     function  EventHandler(var pMsg : CMessage):Boolean;
     function  HexToInt(ch : int64):int64;
    public
     property PMeterTable : SL2INITITAG  read m_sIniTbl write m_sIniTbl;
     property PMeters     : MetersType   read m_pMeter;
     property PPMeterTable: PSL2INITITAG read m_sPIniTbl;
     property PPMeters    : PMeters      read m_pPMeter;
    End;

var
    mL2Module : CL2Module = nil;
implementation
function  CL2Module.HexToInt(ch : int64):int64;
var i : int64;
begin
    Result   := 0;
    i:=1;
    while ch <> 0 do
    begin
      Result := Result + (ch mod $10)*i;
      ch     := ch div $10;
      i      := i*10;
    end;
end;
function  CL2Module.GetL2Object(nMID:Integer):PCMeter;
Begin
    Result := Nil;
    if Assigned(m_pPMeter[nMID]) then
    Result := @m_pPMeter[nMID];
End;

procedure CL2Module.OnHandler;
Begin
     EventHandler(m_nMsg);
End;

procedure CL2Module.Execute;
Begin
    FDEFINE(BOX_L2,BOX_L2_SZ,True);
    while not Terminated do
    Begin
     FGET(BOX_L2,@m_nMsg);
//     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(m_nL2Synchronize :: '+IntToStr(m_nL2Synchronize));
     if m_nL2Synchronize=1  then Synchronize(OnHandler) else
     if m_nL2Synchronize<>1 then EventHandler(m_nMsg);
     // OnHandler;
     //Synchronize(OnHandler);
     //TraceM(m_nLID,m_nMsg.m_swObjID,'(__)CL2MD::>MSG:',@m_nMsg);
     //EventHandler(m_nMsg);
    End;
End;
procedure CL2Module.Init;
Begin
//    csBusy    := TCriticalSection.Create;
    mL2Module := self;
    m_pDB.setL2Init(-1,0);
    //InitMeters(-1);
    Priority := tpHigher;
    Resume;
end;
procedure CL2Module.InitMeters(nPortID:Integer);
Var
    i,nPort,nMID : Integer;
    pM : PCMeter;
    m_sl1Tbl : SL1TAG;
Begin
    m_sPIniTbl := @m_sIniTbl;
    m_pPMeter  := @m_pMeter;
    if m_pDB.GetMetersTable(nPortID,m_sIniTbl)=True then
    Begin
    if mBtiModule<>Nil then mBtiModule.SetStateBti(ST_READY_BTI);
    m_nLID := m_sIniTbl.m_sbyLayerID;
    m_swAmMeter := m_sIniTbl.m_swAmMeter;
    try
    for i:=0 to m_swAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     pM   := @m_pMeter[nMID];
     if (pM^<>Nil) and (pM.GetType<>m_sIniTbl.m_sMeter[i].m_sbyType) then DelNodeLv(nMID);
     m_blMeterIndex[m_sIniTbl.m_sMeter[i].m_swMID] := False;
     m_sl1Tbl.m_sbyPortID   := m_sIniTbl.m_sMeter[i].m_sbyPortID;
     m_sl1Tbl.m_sbyProtID   := m_sIniTbl.m_sMeter[i].m_sbyID;
     m_sl1Tbl.m_swAddres    := m_sIniTbl.m_sMeter[i].m_sbyGroupID;
     m_sl1Tbl.m_sblReaddres := m_sIniTbl.m_sMeter[i].m_swVMID;
     m_sl1Tbl.m_sbyKTRout   := m_sIniTbl.m_sMeter[i].m_sbyKTRout;
     //m_pDB.GetPortTable(m_sl1Tbl);
     {Ukrop 03.10.11}
     if (m_sl1Tbl.m_sbyProtID = DEV_BTI_SRV)   then pM^ := CBTIMeter.Create      else
     if (m_sl1Tbl.m_sbyProtID = DEV_K2000B_CLI)then pM^ := CK2KBytMeter.Create else
     Begin
      case m_sIniTbl.m_sMeter[i].m_sbyType of
       MET_NULL          : if pM^=Nil then pM^ := CNullMeter.Create;
       MET_SS101         : if pM^=Nil then pM^ := CSS101Meter.Create;
       MET_SS301F3       : if pM^=Nil then pM^ := CSS301F3Meter.Create;
       MET_CE6850        : if pM^=Nil then pM^ := CCE6850Meter.Create;
       MET_CE6822        : if pM^=Nil then pM^ := CCE6822Meter.Create;
       MET_EE8005        : if pM^=Nil then pM^ := CEE8005Meter.Create;
       MET_SUMM          : if pM^=Nil then pM^ := CNullMeter.Create;
       MET_GSUMM         : if pM^=Nil then pM^ := CNullMeter.Create;
       MET_RDKORR        : if pM^=Nil then pM^ := CFMTime.Create;
       MET_A2000         : if pM^=Nil then pM^ := CA2000Meter.Create;
       MET_C12           : if pM^=Nil then pM^ := CC12Meter.Create;
       MET_C12_SM        : if pM^=Nil then pM^ := CC12Meter.Create;
       MET_EA8086        : if pM^=Nil then pM^ := CEA8086Meter.Create;
       MET_CEO6005       : if pM^=Nil then pM^ := CCE06005Meter.Create;
       MET_CE301BY       : if pM^=nil then pM^ := CCE301BYMeter.Create;
       MET_USPD16401B    : if pM^=Nil then pM^ := CUSPD16401BMeter.Create;
       MET_MIRT1         : if pM^=nil then pM^ := CMIRT1Meter.Create;
       MET_CE102         : if pM^=nil then pM^ := CCE102Meter.Create;
       MET_CET7007       : if pM^=nil then pM^ := CCET7007Meter.Create;
       MET_CE16401M      : if pM^=Nil then pM^ := CCE16401MMeter.Create;
       MET_MIRTW2        : if pM^=nil then pM^ := CMIRT1W2Meter.Create;
       //MET_K2000B        : if pM^=Nil then pM^ := CK2KBytMeter.Create;
      End;
     End;
      pM^.m_nPortAddr := m_sIniTbl.m_sMeter[i].m_sbyPortID;
      pM^.blIsKTRout  := m_sl1Tbl.m_sbyKTRout;
      if m_sl1Tbl.m_sblReaddres=1 then
      m_sIniTbl.m_sMeter[i].m_sbyPortID := m_sl1Tbl.m_swAddres;
      pM^.Init(m_sIniTbl.m_sMeter[i]);
      if m_nCF.QueryType<>QWR_QWERY_SRV then pM.BOX_L3_BY := BOX_L3 else
      //if m_nCF.QueryType= QWR_QWERY_SRV then pM.BOX_L3_BY := BOX_CSRV;
    End;
    except
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'CL2MD::>Error Create L2.');
    end;
    End;
End;

function CL2Module.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):PCMeter;
Var
    meter  : PCMeter;
    pTable : SL2TAG;
Begin
    //csBusy.Enter;
    if (dynConnect.GetMMeterTableEx(mid,pTable)) then
    Begin
    New(meter);
    if (pTable.m_sbyProtID = DEV_BTI_SRV)   then meter^ := CBTIMeter.Create else
    if (pTable.m_sbyProtID = DEV_K2000B_CLI)then meter^ := CK2KBytMeter.Create else
    case pTable.m_sbyType of
       MET_NULL          : meter^ := CNullMeter.Create;
       MET_SS101         : meter^ := CSS101Meter.Create;
       MET_SS301F3       : meter^ := CSS301F3Meter.Create;
       MET_CE6850        : meter^ := CCE6850Meter.Create;
       MET_CE6822        : meter^ := CCE6822Meter.Create;
       MET_EE8005        : meter^ := CEE8005Meter.Create;
       MET_SUMM          : meter^ := CNullMeter.Create;
       MET_GSUMM         : meter^ := CNullMeter.Create;
       MET_RDKORR        : meter^ := CFMTime.Create;
       MET_A2000         : meter^ := CA2000Meter.Create;
       MET_C12           : meter^ := CC12Meter.Create;
       MET_C12_SM        : meter^ := CC12Meter.Create;
       MET_EA8086        : meter^ := CEA8086Meter.Create;
       MET_CEO6005       : meter^ := CCE06005Meter.Create;
       MET_CE301BY       : meter^ := CCE301BYMeter.Create;
       MET_USPD16401B    : meter^ := CUSPD16401BMeter.Create;
       MET_MIRT1         : meter^ := CMIRT1Meter.Create;
       MET_CE102         : meter^ := CCE102Meter.Create;
       MET_CET7007       : meter^ := CCET7007Meter.Create;
       MET_CE16401M      : meter^ := CCE16401MMeter.Create;
       MET_MIRTW2        : meter^ := CMIRT1W2Meter.Create;
      End;
      End;
      if meter<>nil then
      Begin
       meter^.setDbConnect(dynConnect);
       meter^.Init(pTable);
      End;

      Result := meter;
      //csBusy.Leave;
End;

function CL2Module.InitPortAbon(nPort:Integer):Boolean;
Begin
    if (m_pDB.isL2Init(nPort)=False) then
    Begin
      InitMeters(nPort);
      m_pDB.setL2Init(nPort,1);
    End;
End;

procedure CL2Module.InitAbon(nAID:Integer);
Var
    pTable:SL3GROUPTAG;
    i : Integer;
Begin
    if m_pDB.GetAbonMetersTable(nAID,pTable)=True then
    Begin
     for i:=0 to pTable.Item.Count-1 do
     InitMeter(pTable.Item.Items[i].m_swMID);
    End;
end;
procedure CL2Module.InitMeter(nMID:Integer);
Var
    pL2Table : SL2TAG;
    pL1Table : SL1TAG;
    i        : Integer;
    pM       : PCMeter;
Begin
    if m_pDB.GetMMeterTable(nMID,pL2Table) then
    Begin
     pL1Table.m_sbyPortID := pL2Table.m_sbyPortID;

     for i:=0 to m_swAmMeter-1 do
     Begin
      if nMID=m_sIniTbl.m_sMeter[i].m_swMID then
      Begin
       Move(pL2Table,m_sIniTbl.m_sMeter[i],sizeof(SL2TAG));
       break;
      End;
     End;

     if m_pDB.GetPortTable(pL1Table)=True then
     Begin
      //for i:=0 to m_swAmMeter-1 do
      Begin
       if Assigned(m_pMeter[nMID]) then
       Begin
        pM := @m_pMeter[nMID];
        if pM<>Nil then
        if (pM.m_nP.m_swMID=nMID)and(not((pM.m_nP.m_sbyType=8)or(pM.m_nP.m_sbyType=9))) then
        Begin
         pM.m_nPortAddr := pL2Table.m_sbyPortID;
         pM.blIsKTRout  := pL1Table.m_sbyKTRout;
         if pL1Table.m_sblReaddres=1 then pL2Table.m_sbyPortID := pL1Table.m_swAddres;
         pM.Init(pL2Table);
         exit;
        End;
       End;
      End;
     End;
    End;
End;
procedure CL2Module.InitScenario(nIndex:Integer);
Begin
    //if nIndex<m_swAmMeter then
    if m_pMeter[nIndex]<>Nil then m_pMeter[nIndex].InitScenario;
End;

function CL2Module.EventHandler(var pMsg : CMessage):Boolean;
Begin
    try
    case pMsg.m_sbyFor of
      DIR_BTITOBTI, DIR_L1TOBTI :
      begin
        if mBTIModule.GetState = ST_READY_BTI then
        begin
          if m_pMeter[pMsg.m_swObjID]<>Nil then
           m_pMeter[pMsg.m_swObjID].LoBaseHandler(pMsg);
        end
        else
          mBtiModule.EventHandler(pMsg);
      end;
      DIR_L1TOL2:
      Begin
       if (pMsg.m_sbyType=PH_DATA_IND)or(pMsg.m_sbyType=QL_CONNCOMPL_REQ)or(pMsg.m_sbyType=QL_DISCCOMPL_REQ)or
          (pMsg.m_sbyType=QL_REDIRECT_REQ) then
       Begin
        Inc(m_dwIN);
        //if m_pMeter[pMsg.m_swObjID]<>Nil then
        //m_pMeter[pMsg.m_swObjID].EventHandler(pMsg);
       End;
      End;
      DIR_LMTOL2:
      Begin
       case pMsg.m_sbyType of
        DL_LOADOBSERVER_IND      : LoadObserver(pMsg.m_sbyIntID);
        DL_LOADOBSERVER_GR_IND   : LoadObserverGraph(pMsg);
        DL_LOADOBSERVER_CTRL_IND : LoadObserverCtrl(pMsg); // Ukrop
        DL_LOADOBSERVER_ALLGR_IND: LoadObserverAllGraph(pMsg.m_sbyIntID);
        DL_LOAD_EV_METER_IND     : LoadEvMeter(pMsg);
        DL_LOADMETER_IND         : LoadMeter(pMsg);
        //DL_STOPL2OBS_IND         : StopObserve;
        //DL_STARTL2OBS_IND        : StartObserve;
        //DL_GOL2OBS_IND           : GoObserve;
        DL_LOAD_ONE_METER_IND    : LoadOneMeter(pMsg);
        DL_LOAD_ONE_METER_CTRL_IND : LoadOneMeterCTRL(pMsg); { ukrop ctrl step 3}
        DL_SYSCHPREPARE_IND      : PrepareSynchro;
        //DL_STARTCHLOBS_IND       : StartChnlObserve(pMsg.m_sbyIntID);
        //DL_GOCHLOBS_IND          : GoChnlObserve(pMsg.m_sbyIntID);
       End;
      End;
      DIR_QMTOL2:
      Begin
       case pMsg.m_sbyType of
        //DL_SYNC_EVENT_IND: m_nQrySender[pMsg.m_sbyIntID].Go;
        DL_ERRTMR1_IND   : m_nQrySender[pMsg.m_sbyIntID].FreeMID1(pMsg.m_swObjID);
        DL_ERRTMR_IND    : m_nQrySender[pMsg.m_sbyIntID].FreeMID(pMsg.m_swObjID);
        DL_PAUSESNDR_IND : m_nQrySender[pMsg.m_sbyIntID].Suspend;
        DL_GOSNDR_IND    : m_nQrySender[pMsg.m_sbyIntID].Resume;
        DL_STOPSNDR_IND  : m_nQrySender[pMsg.m_sbyIntID].Stop;
        DL_STARTSNDR_IND : m_nQrySender[pMsg.m_sbyIntID].Go;
        DL_FREESNDR_IND  : m_nQrySender[pMsg.m_sbyIntID].Free;
       End;
      End;
      DIR_L3TOL2,DIR_L2TOL2:
      Begin
       //if pMsg.m_swObjID<m_swAmMeter then
       if m_pMeter[pMsg.m_swObjID]<>Nil then
       m_pMeter[pMsg.m_swObjID].EventHandler(pMsg);
      End;
    End;
    except
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>Error Routing L2.');
    End;
End;
procedure CL2Module.OpenPortGate(nPortID:Integer);
Begin
    FCLRSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
end;
procedure CL2Module.ClosePortGate(nPortID:Integer);
Begin
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_FIN_CHN_IND);
    FSETSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].Go;
end;
procedure CL2Module.LoadMeterParam(var pDS:CMessageData);
Var
    i,nPortID,nVMID,nMID,nCmdID : Integer;
Begin
    try
    nVMID  := pDS.m_swData0;
    nCmdID := pDS.m_swData1;
    nMID   := pDS.m_swData2;
    nPortID  := pDS.m_swData3;
    //if nMID=14 then
    // nPortID  := pDS.m_swData3;
    FCLRSYN(BOX_L3_QS+nPortID);
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>Error LoadMeterParam');
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
    //for i:=0 to m_sIniTbl.m_swAmMeter-1 do
    //if not Assigned(m_pMeter[nMID]) then exit;
    if (m_blMeterIndex[nMID]=False) then
    Begin
     if m_pMeter[nMID].m_nP.m_sbyEnable=1 then
     Begin
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_ENT_MTR_IND);
      m_pMeter[nMID].PObserver.LoadParam(nCmdID);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_MTR_IND);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_COM_IND);
      //break;
     End;
    End;
    m_nQrySender[nPortID].SetFinalEventEx(nVMID,nPortID,nCmdID,QM_FIN_CHN_IND);
    FSETSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].Go;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CL2Module.LoadMeterParam!!!');
    end;
End;
procedure CL2Module.LoadObserver(nPortID:Integer);
Var
    i,nVMID,nMID,nCMDID : Integer;
Begin
    try
    FCLRSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
    nVMID :=-1;
    nCMDID:=-1;
    for i:=0 to m_swAmMeter-1 do
    //if nPortID=m_pMeter[i].GetPRID then
    if nPortID=m_sIniTbl.m_sMeter[i].m_sbyPortID then
    Begin
     if m_sIniTbl.m_sMeter[i].m_sbyEnable=1 then Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if not Assigned(m_pMeter[nMID]) then break;
     m_nQrySender[nPortID].SetFinalEvent(nMID,QM_ENT_MTR_IND);
     if m_blIsTest=False then m_pMeter[nMID].PObserver.LoadCurrQry else
     if m_blIsTest=True  then m_pMeter[nMID].PObserver.LoadCurrFirstQry;
     m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_MTR_IND);
     m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_COM_IND);End;
    End;
    m_nQrySender[nPortID].SetFinalEventEx(nVMID,nPortID,nCMDID,QM_FIN_CHN_IND);
    FSETSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].Go;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CL2Module.LoadObserver!!!');
    end;
End;
procedure CL2Module.LoadObserverGraph(var pMsg:CMessage);
Var
    {i,}nPortID,nVMID,nMID,nCmdID : Integer;
    pDS : CMessageData;
Begin
    try
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    nVMID   := pDS.m_swData0;
    nCmdID  := pDS.m_swData1;
    nMID    := pDS.m_swData2;
    nPortID := pDS.m_swData3;
    //for i:=0 to m_swAmMeter-1 do
    //if nMID=m_sIniTbl.m_sMeter[i].m_swMID then
    if Assigned(m_pMeter[nMID]) then
    Begin
     FCLRSYN(BOX_L3_QS+nPortID);
     m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
     m_nQrySender[nPortID].SetFinalEvent(nMID,QM_ENT_MTR_IND);
      m_pMeter[nMID].PObserver.LoadGraphQry;
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_MTR_IND);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_COM_IND);
      m_nQrySender[nPortID].SetFinalEventEx(nVMID,nPortID,nCmdID,QM_FIN_CHN_IND);
     FSETSYN(BOX_L3_QS+nPortID);
     m_nQrySender[nPortID].Go;
     exit;
    End;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CL2Module.LoadObserverGraph!!!');
    end;
End;


{*******************************************************************************
 *  Выполнение управления устройством
 *  Ukrop
 ******************************************************************************}
procedure CL2Module.LoadObserverCtrl(var pMsg:CMessage);
Var
    {i,}nPortID,nVMID,nMID,nCmdID : Integer;
    pDS : CMessageData;
Begin
    try
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    nVMID   := pDS.m_swData0;
    nCmdID  := pDS.m_swData1;
    nMID    := pDS.m_swData2;
    nPortID := pDS.m_swData3;
    //for i:=0 to m_swAmMeter-1 do
    //if nMID=m_sIniTbl.m_sMeter[i].m_swMID then
    if Assigned(m_pMeter[nMID]) then
    Begin
     FCLRSYN(BOX_L3_QS+nPortID);
     m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
     m_nQrySender[nPortID].SetFinalEvent(nMID,QM_ENT_MTR_IND);
      m_pMeter[nMID].PObserver.LoadCtrlQry();
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_MTR_IND);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_COM_IND);
      m_nQrySender[nPortID].SetFinalEventEx(nVMID,nPortID,nCmdID,QM_FIN_CHN_IND);
     FSETSYN(BOX_L3_QS+nPortID);
     m_nQrySender[nPortID].Go;
     exit;
    End;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CL2Module.LoadObserverGraph!!!');
    end;
End;
procedure CL2Module.LoadObserverAllGraph(nPortID:Integer);
Var
    i,nVMID,nMID,nCMDID : Integer;
Begin
    try
    FCLRSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
    nVMID := -1;
    for i:=0 to m_swAmMeter-1 do
    Begin
    //if nPortID=m_pMeter[i].GetPRID then
     if nPortID=m_sIniTbl.m_sMeter[i].m_sbyPortID then
     if m_sIniTbl.m_sMeter[i].m_sbyEnable=1 then
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if not Assigned(m_pMeter[nMID]) then break;
      //if m_pMeter[i].m_nP.m_sbyEnable=1 then Begin
      //nMID := m_pMeter[i].m_nP.m_swMID;
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_ENT_MTR_IND);
      nCMDID:=m_pMeter[nMID].PObserver.LoadGraphQry;
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_MTR_IND);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_COM_IND);
     End;
    End;
    m_nQrySender[nPortID].SetFinalEventEx(nVMID,nPortID,nCMDID,QM_FIN_CHN_IND);
    FSETSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].Go;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL3MD::>Error In CL2Module.LoadObserverAllGraph!!!');
    end;
End;
procedure CL2Module.LoadEvMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_blMeterIndex[nMID]=False then
      Begin
       if not Assigned(m_pMeter[nMID]) then break;
       if m_pMeter[nMID].m_nP.m_sbyEnable=1 then
       Begin
        pMsg.m_sbyFor  := DIR_L3TOL2;
        pMsg.m_sbyType := QL_LOAD_EVENTS_REQ;
        pMsg.m_swObjID := m_pMeter[i].m_nP.m_swMID;
        m_pMeter[nMID].EventHandler(pMsg);
        if(m_pMeter[nMID] is CBTIMeter) then
        Begin
         SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_COMPL_IND);
         exit;
        End;
       End;
      End;
    End;
    SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_COMPL_IND);
End;
procedure CL2Module.LoadEvOneMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_blMeterIndex[nMID]=False then
      Begin
       if not Assigned(m_pMeter[nMID]) then break;
       if (pMsg.m_swObjID=m_sIniTbl.m_sMeter[i].m_swMID)and(m_sIniTbl.m_sMeter[i].m_sbyEnable=1) then
       Begin
        pMsg.m_sbyFor  := DIR_L3TOL2;
        pMsg.m_sbyType := QL_LOAD_EVENTS_REQ;
        m_pMeter[nMID].EventHandler(pMsg);
        //if(m_pMeter[i] is CBTIMeter) then
        break;
       End;
      End;
    End;
    SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_ONEEV_COMPL_IND);
End;
procedure CL2Module.LoadMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_blMeterIndex[nMID]=False then
      Begin
       if not Assigned(m_pMeter[nMID]) then break;
       if(m_sIniTbl.m_sMeter[i].m_sbyEnable=1) then
       Begin
        pMsg.m_sbyFor  := DIR_L3TOL2;
        pMsg.m_sbyType := QL_DATA_GRAPH_REQ;
        pMsg.m_swObjID := nMID;
        m_pMeter[nMID].EventHandler(pMsg)
       End;
      End;
    End;
    SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_COMPL_IND);
End;
procedure CL2Module.ResetMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_blMeterIndex[nMID]=False then
      Begin
       if not Assigned(m_pMeter[nMID]) then break;
       if(m_sIniTbl.m_sMeter[i].m_sbyEnable=1) then
       Begin
        pMsg.m_sbyFor  := DIR_L3TOL2;
        pMsg.m_sbyType := QL_DATA_FIN_GRAPH_REQ;
        pMsg.m_swObjID := nMID;
        m_pMeter[nMID].EventHandler(pMsg)
       End;
      End;
    End;
End;
procedure CL2Module.LoadOneMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_blMeterIndex[nMID]=False then
      Begin
       if not Assigned(m_pMeter[nMID]) then break;
       if (pMsg.m_swObjID=m_sIniTbl.m_sMeter[i].m_swMID)and(m_sIniTbl.m_sMeter[i].m_sbyEnable=1) then
       Begin
        pMsg.m_sbyFor  := DIR_L3TOL2;
        pMsg.m_sbyType := QL_DATA_GRAPH_REQ;
        pMsg.m_swObjID := nMID;
        m_pMeter[nMID].EventHandler(pMsg);
        SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_ONE_COMPL_IND);
        exit;
       End;
      End;
    End;
End;
procedure CL2Module.LoadOneMeterCTRL(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if m_blMeterIndex[nMID]=False then
      Begin
       if not Assigned(m_pMeter[nMID]) then break;
       if (pMsg.m_swObjID=m_sIniTbl.m_sMeter[i].m_swMID)and(m_sIniTbl.m_sMeter[i].m_sbyEnable=1) then
       Begin
        pMsg.m_sbyFor  := DIR_L3TOL2;
        pMsg.m_sbyType := QL_DATA_CTRL_REQ;
        pMsg.m_swObjID := nMID;
        m_pMeter[nMID].EventHandler(pMsg);
        SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_ONECTRL_COMPL_IND); //  { ukrop ctrl step 3->4}
        exit;
       End;
      End;
    End;
End;
procedure CL2Module.PrepareSynchro;
Var
    i,nMID : Integer;
Begin
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>Prepare Synchro...');
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
    Begin
     nMID := m_sIniTbl.m_sMeter[i].m_swMID;
     if m_blMeterIndex[nMID]=False then
     Begin
      if not Assigned(m_pMeter[nMID]) then break;
      m_pMeter[nMID].m_nP.m_blOneSynchro := True;
     End;
    End;
End;

procedure CL2Module.StopChnlObserve(nPortID:Integer);
Var
    i : Integer;
Begin
    {
    for i:=0 to m_swAmMeter-1 do
    if nPortID=m_pMeter[i].GetPRID then
    m_pMeter[i].StopObserve;
    }
End;
procedure CL2Module.StartChnlObserve(nPortID:Integer);
Var
    i : Integer;
Begin
    {
    for i:=0 to m_swAmMeter-1 do
    if nPortID=m_pMeter[i].GetPRID then
    m_pMeter[i].StartObserve;
    }
End;
procedure CL2Module.GoChnlObserve(nPortID:Integer);
Var
    i : Integer;
Begin
    {
    for i:=0 to m_swAmMeter-1 do
    if nPortID=m_pMeter[i].GetPRID then
    m_pMeter[i].GoObserve;
    }
End;
procedure CL2Module.DoHalfTime(Sender:TObject);
Var
    i,nMID : Integer;
Begin
    try
     for i:=0 to m_sIniTbl.m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if Assigned(m_pMeter[nMID]) then m_pMeter[nMID].Run;
      SetTexSB(2,'ltx:'+IntToStr(m_dwIN)+' lrx:'+IntToStr(m_dwOUT));
     End;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>Error Timer Routing.');
    End
End;

procedure CL2Module.DoHalfSpeedTime(Sender:TObject);
Var
    i,nMID : Integer;
Begin
    try
     for i:=0 to m_sIniTbl.m_swAmMeter-1 do
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if Assigned(m_pMeter[nMID]) then m_pMeter[nMID].RunSpeed;
      //SetTexSB(2,'ltx:'+IntToStr(m_dwIN)+' lrx:'+IntToStr(m_dwOUT));
     End;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>Error SpeedTimer Routing.');
    End
End;

procedure CL2Module.DelNodeLv(nIndex:Integer);
Begin
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>DelNodeLv.');
    if m_pMeter[nIndex]<>Nil then
    Begin
     m_pMeter[nIndex].Destroy;
     m_pMeter[nIndex] := Nil;
    End;
End;
procedure CL2Module.AddNodeLv(pTbl:SL2TAG);
Begin
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(__)CL2MD::>AddNodeLv.');
End;
procedure CL2Module.EditNodeLv(pTbl:SL2TAG);
Begin
    //TraceL(2,0,'(__)CL2MD::>EditNodeLv.');
    if pTbl.m_swMID<m_swAmMeter then
    if m_pMeter[pTbl.m_swMID]<>Nil then
    m_pMeter[pTbl.m_swMID].Init(pTbl);
End;
end.
