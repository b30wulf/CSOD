unit knsl4Loader;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl3querysender,
knsl5tracer,knsl2module,knsl2BTIModule;
type
    CLoader = class
    public
     procedure Init;
     procedure LoadMeterParam(var pDS:CMessageData);
     procedure LoadObserver(nPortID:Integer);
     procedure LoadObserverGraph(var pMsg:CMessage);
     procedure LoadObserverCtrl(var pMsg:CMessage);
     procedure LoadObserverAllGraph(nPortID:Integer);
     procedure LoadEvMeter(var pMsg:CMessage);
     procedure LoadEvOneMeter(var pMsg:CMessage);
     procedure LoadMeter(var pMsg:CMessage);
     procedure ResetMeter(var pMsg:CMessage);
     procedure LoadOneMeter(var pMsg:CMessage);
     procedure LoadOneMeterCTRL(var pMsg:CMessage);
     procedure PrepareSynchro;
    protected
     m_sIniTbl : PSL2INITITAG;
     m_pMeter  : PMeters;
     constructor Create;
     destructor Destroy;override;
    public
     property PMeterTable: PSL2INITITAG read m_sIniTbl write m_sIniTbl;
     property PMeters    : PMeters      read m_pMeter  write m_pMeter;
    End;
implementation
constructor CLoader.Create;
Begin

End;
destructor CLoader.Destroy;
Begin

End;
procedure CLoader.Init;
Begin

End;
procedure CLoader.LoadMeterParam(var pDS:CMessageData);
Var
    i,nPortID,nVMID,nMID,nCmdID : Integer;
Begin
    try
    nVMID  := pDS.m_swData0;
    nCmdID := pDS.m_swData1;
    nMID   := pDS.m_swData2;
    nPortID  := pDS.m_swData3;
    FCLRSYN(BOX_L3_QS+nPortID);
    TraceL(3,nVMID,'(__)CL3LD::>CLPAR::'+IntToStr(nVMID)+' '+IntToStr(nCmdID)+' '+IntToStr(nMID)+' '+IntToStr(nPortID));
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
    if (m_blMeterIndex[nMID]=False) then
    Begin
     if m_pMeter[nMID].m_nP.m_sbyEnable=1 then
     Begin
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_ENT_MTR_IND);
      m_pMeter[nMID].PObserver.LoadParam(nCmdID);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_MTR_IND);
      m_nQrySender[nPortID].SetFinalEvent(nMID,QM_FIN_COM_IND);
     End;
    End;
    m_nQrySender[nPortID].SetFinalEventEx(nVMID,nPortID,nCmdID,QM_FIN_CHN_IND);
    FSETSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].Go;
    except
     TraceER('(__)CL3LD::>Error In CL2Module.LoadMeterParam!!!');
    end;
End;
procedure CLoader.LoadObserver(nPortID:Integer);
Var
    i,nVMID,nMID,nCMDID : Integer;
Begin
    try
    FCLRSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
    nVMID :=-1;
    nCMDID:=-1;
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
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
     TraceER('(__)CL3LD::>Error In CLoader.LoadObserver!!!');
    end;
End;
procedure CLoader.LoadObserverGraph(var pMsg:CMessage);
Var
    nPortID,nVMID,nMID,nCmdID : Integer;
    pDS : CMessageData;
Begin
    try
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    nVMID   := pDS.m_swData0;
    nCmdID  := pDS.m_swData1;
    nMID    := pDS.m_swData2;
    nPortID := pDS.m_swData3;
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
     TraceER('(__)CL3LD::>Error In CLoader.LoadObserverGraph!!!');
    end;
End;
{*******************************************************************************
 *  Выполнение управления устройством
 *  Ukrop
 ******************************************************************************}
procedure CLoader.LoadObserverCtrl(var pMsg:CMessage);
Var
    nPortID,nVMID,nMID,nCmdID : Integer;
    pDS : CMessageData;
Begin
    try
    Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
    nVMID   := pDS.m_swData0;
    nCmdID  := pDS.m_swData1;
    nMID    := pDS.m_swData2;
    nPortID := pDS.m_swData3;
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
     TraceER('(__)CL3LD::>Error In CLoader.LoadObserverGraph!!!');
    end;
End;
procedure CLoader.LoadObserverAllGraph(nPortID:Integer);
Var
    i,nVMID,nMID,nCMDID : Integer;
Begin
    try
    FCLRSYN(BOX_L3_QS+nPortID);
    m_nQrySender[nPortID].SetFinalEvent(nPortID,QM_ENT_CHN_IND);
    nVMID := -1;
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
    Begin
     if nPortID=m_sIniTbl.m_sMeter[i].m_sbyPortID then
     if m_sIniTbl.m_sMeter[i].m_sbyEnable=1 then
     Begin
      nMID := m_sIniTbl.m_sMeter[i].m_swMID;
      if not Assigned(m_pMeter[nMID]) then break;
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
     TraceER('(__)CL3LD::>Error In CLoader.LoadObserverAllGraph!!!');
    end;
End;
procedure CLoader.LoadEvMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
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
procedure CLoader.LoadEvOneMeter(var pMsg:CMessage);
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
        pMsg.m_sbyType := QL_LOAD_EVENTS_REQ;
        m_pMeter[nMID].EventHandler(pMsg);
        //if(m_pMeter[i] is CBTIMeter) then
        break;
       End;
      End;
    End;
    SendMsg(BOX_L3_LME,0,DIR_LHTOLAL,LME_LOAD_ONEEV_COMPL_IND);
End;
procedure CLoader.LoadMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
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
procedure CLoader.ResetMeter(var pMsg:CMessage);
Var
    i,nMID : Integer;
Begin
    for i:=0 to m_sIniTbl.m_swAmMeter-1 do
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
procedure CLoader.LoadOneMeter(var pMsg:CMessage);
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
procedure CLoader.LoadOneMeterCTRL(var pMsg:CMessage);
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
procedure CLoader.PrepareSynchro;
Var
    i,nMID : Integer;
Begin
    TraceL(3,0,'(__)CL2MD::>Prepare Synchro...');
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
end.
 