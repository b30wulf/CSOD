unit knsl1module;
//{$DEFINE CLL1_DEBUG}
interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl1cport,knsl1comport,
    knsl1tcp,{utldatabase}extctrls,utlmtimer,knsl5tracer;
type
    CL1Module = class(TThread)
    private
     //m_csOut     : TCriticalSection;
     m_nLID      : Byte;
     m_sbyAmPort : Byte;
     m_pPort     : array[0..MAX_PORT] of CPort;
     m_nMsg      : CMessage;
     m_sIniTbl   : SL1INITITAG;
     FTimer      : TTimer;
    public
     procedure Init;
     procedure DelNodeLv(nIndex:Integer);
     procedure AddNodeLv(pTbl:SL1TAG);
     procedure EditNodeLv(pTbl:SL1TAG);
     procedure CreateQrySender;
     procedure DoHalfTime(Sender:TObject);
    private
     procedure OnHandler;
     procedure GetL1Table;
     //procedure DoHalfTime(Sender:TObject);dynamic;
     procedure Execute; override;
     function EventHandler(var pMsg : CMessage):Boolean;
    End;
var
    mL1Module : CL1Module;
implementation
procedure CL1Module.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CL1Module.Execute;
Begin
    FDEFINE(BOX_L1,BOX_L1_SZ,True);
    while true do
    Begin
     FGET(BOX_L1,@m_nMsg);
     OnHandler;
     //Synchronize(OnHandler);
     //EventHandler(m_nMsg);
    End;
End;
procedure CL1Module.Init;
Var
    i,nIndex : Integer;
Begin
    mL1Module := self;               //GetSystemTime
    GetL1Table;
    Begin
    m_nLID  := m_sIniTbl.m_sbyLayerID;
    m_sbyAmPort := m_sIniTbl.Count;
    try
    for i:=0 to m_sbyAmPort-1 do
    Begin
     nIndex := m_sIniTbl.Items[i].m_sbyPortID;
     case m_sIniTbl.Items[i].m_sbyType of
       DEV_COM_LOC,DEV_COM_GSM:
        Begin
         if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := TComPort.Create;
         m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
         {
         if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
         Begin
          if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
          mBtiModule.Init(m_sIniTbl.Items[i]);
         End;
         }
        End;
       DEV_TCP_SRV, DEV_UDP_SRV:
        Begin
         if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := CTcpPort.Create;
         m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
         if m_sIniTbl.Items[i].m_sbyControl=1 then
          m_nMasterPort0 := nIndex;
         {
         if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
         Begin
          if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
          mBtiModule.Init(m_sIniTbl.Items[i]);
         End;
         }
         //m_nMasterPort0 := nIndex;
        End;
       DEV_TCP_CLI, DEV_UDP_CLI:
        Begin
         if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := CTcpPort.Create;
         m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
         if m_sIniTbl.Items[i].m_sbyControl=1 then
          m_nMasterPort0 := nIndex;
        End;
     End;
    End;
    except
     TraceL(m_nLID,i,'(__)CL1MD::>Error Create L1.');
    end;
    Priority       := tpNormal;
    Resume;
    End;
    //CreateQrySender;
End;
{
 //Типы портов
  DEV_COM_LOC  = 0;
  DEV_COM_GSM  = 1;
  DEV_TCP_SRV  = 2;
  DEV_TCP_CLI  = 3;
  DEV_UDP_SRV  = 4;
  DEV_UDP_CLI  = 5;

  //Типы протоколов
  DEV_NUL      = 0;
  DEV_MASTER   = 1;
  DEV_SLAVE    = 2;
  DEV_BTI_CLI  = 3;
  DEV_BTI_SRV  = 4;
  DEV_SQL      = 5;
  DEV_UDP_CC301= 6;
}
procedure CL1Module.GetL1Table;
Begin
    //if m_pDB.GetL1Table(m_sIniTbl)=True then
    m_sIniTbl.m_sbyLayerID := 1;
    m_sIniTbl.Count        := 2;
    m_sbyAmPort            := m_sIniTbl.Count;
    SetLength(m_sIniTbl.Items,2);
    with m_sIniTbl.Items[0] do
    Begin
     m_sbyID       := 0;
     m_sbyPortID   := 0;
     m_schName     := 'LCTRL';
     m_sbyPortNum  := 0;
     m_sbyType     := DEV_TCP_SRV;
     m_sbyProtID   := DEV_NUL;
     m_sbyControl  := 0;
     m_sbySpeed    := 0;
     m_sbyParity   := 0;
     m_sbyData     := 0;
     m_sbyStop     := 0;
     m_swDelayTime := 1000;
     m_swAddres    := 0;
     m_sblReaddres := 0;
     m_schPhone    := 'phone';
     m_swIPPort    := '20010';
     m_schIPAddr   := '0.0.0.0';
    End;
    with m_sIniTbl.Items[1] do
    Begin
     m_sbyID       := 0;
     m_sbyPortID   := 1;
     m_schName     := 'RCTRL';
     m_sbyPortNum  := 0;
     m_sbyType     := DEV_TCP_SRV;
     m_sbyProtID   := DEV_NUL;
     m_sbyControl  := 0;
     m_sbySpeed    := 0;
     m_sbyParity   := 0;
     m_sbyData     := 0;
     m_sbyStop     := 0;
     m_swDelayTime := 1000;
     m_swAddres    := 0;
     m_sblReaddres := 0;
     m_schPhone    := 'phone';
     m_swIPPort    := '20011';
     m_schIPAddr   := '0.0.0.0';
    End;
End;
{
  //Типы портов
  DEV_COM_L2   = 0;
  DEV_COM_USPD = 1;
  DEV_TCP_SRV  = 3;
  DEV_TCP_CLI  = 4;
  //Типы протоколов
  DEV_NUL      = 0;
  DEV_BTI_CLI  = 1;
  DEV_BTI_SRV  = 2;
}
procedure CL1Module.CreateQrySender;
Var
     i,nIndex : Integer;
     nPoolTime : Integer;
Begin
     {
     for i:=0 to MAX_PORT do
     Begin
      if m_blPortIndex[i]=False then
      Begin
       if (m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV) or
          (m_sIniTbl.Items[i].m_sbyProtID=DEV_MASTER) then
       Begin
        if m_nQrySender[i]<>Nil then
        Begin
         m_nQrySender[i].Destroy;
         m_nQrySender[i]:=Nil;
        End;
        m_nQrySender[i] := CQuerySender.Create(True);
        m_nQrySender[i].Init(m_sIniTbl.Items[i]);
        m_nQrySender[i].Priority := tpNormal;
        m_nQrySender[i].Resume;
       End;
      End;
     End;
     }
End;
function CL1Module.EventHandler(var pMsg : CMessage):Boolean;
Var
    sPT : SL1SHTAG;
    pDS : CMessageData;
Begin
    try
    //TraceM(1,0,'(__)CL1MD::>MSG:',@pMsg);
    case pMsg.m_sbyFor of
      DIR_LMETOL1,DIR_L5TOL1,DIR_BTITOL1:
       case pMsg.m_sbyType of
        PH_DATARD_REQ:
         if pMsg.m_sbyIntID<m_sIniTbl.Count then
         Begin
          Inc(m_dwOUT);
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].Send(@pMsg,pMsg.m_swLen);
         end;
       End;
      DIR_L2TOL1:
      Begin
       case pMsg.m_sbyType of
        PH_DATARD_REQ:
         if pMsg.m_sbyIntID<m_sIniTbl.Count then
         begin
          Inc(m_dwOUT);
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          {$IFNDEF CLL1_DEBUG}
           m_pPort[pMsg.m_sbyIntID].Send(@pMsg,pMsg.m_swLen);
          {$ELSE}
           pMsg.m_sbyFor  := DIR_L1TOL2;
           pMsg.m_sbyType := PH_DATA_IND;
           FPUT(BOX_L2,@pMsg);
          {$ENDIF}
          //TraceM(1, pMsg.m_sbyIntID, '(__)CL1MD::>MSG:',@pMsg);
         end;
        PH_SETPORT_IND:
         Begin
          Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
          Move(pDS.m_sbyInfo[0],sPT,sizeof(SL1SHTAG));
          m_pPort[pMsg.m_sbyIntID].SetDynamic(sPT);
         End;
        PH_SETDEFSET_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].SetDefaultSett;
         End;
        PH_CONN_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].Connect(pMsg);
         End;
        PH_RECONN_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].ReConnect(pMsg);
         End;
        PH_DISC_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].Disconnect(pMsg);
         End;
         PH_FREE_PORT_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].FreePort(pMsg);
         End;
         PH_SETT_PORT_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].SettPort(pMsg);
         End;
       End;
      End;
      DIR_L1TOL1:
      case pMsg.m_sbyType of
       PH_CONNTMR_IND: m_pPort[pMsg.m_swObjID].QueryConnect(pMsg);
       PH_MCREG_IND  : TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>CREG');
       PH_MCONN_IND  :
       Begin
        TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>CONNECT');
        SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_CONN_IND);
        pMsg.m_sbyFor  := DIR_L1TOL2;
        pMsg.m_sbyType := QL_CONNCOMPL_REQ;
        case pMsg.m_sbyTypeIntID of
         DEV_MASTER : FPUT(BOX_L2,@pMsg);
         DEV_BTI_CLI:
                 Begin
                  pMsg.m_sbyFor := DIR_ARTOL4;
                  FPUT(BOX_L4,@pMsg);
                 End;
         DEV_BTI_SRV:
                 Begin
                  pMsg.m_sbyFor := DIR_L1TOBTI;
                  FPUT(BOX_L2,@pMsg);
                 End;
        End;
       End;
       PH_MDISC_IND  :
       Begin
        TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>DISC');
        //m_nQrySender[pMsg.m_sbyDirID].OnModemFinalAction(pMsg.m_swObjID);
        SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_DISC_IND);
        pMsg.m_sbyFor  := DIR_L1TOL2;
        pMsg.m_sbyType := QL_DISCCOMPL_REQ;
        case pMsg.m_sbyTypeIntID of
         DEV_MASTER : FPUT(BOX_L2,@pMsg);
         DEV_BTI_CLI:
                 Begin
                  pMsg.m_sbyFor := DIR_ARTOL4;
                  FPUT(BOX_L4,@pMsg);
                 End;
         DEV_BTI_SRV:
                 Begin
                  pMsg.m_sbyFor := DIR_L1TOBTI;
                  FPUT(BOX_L2,@pMsg);
                 End;
        End;
        //OnDisconnectAction;
       End;
       PH_MDISCSCMPL_IND:
       Begin
        TraceL(1,pMsg.m_swObjID,'(__)CL1MD::>DISCONNECT COMPLETTE.');
        {
        if m_nQrySender[pMsg.m_sbyDirID]<>Nil then
        m_nQrySender[pMsg.m_sbyDirID].OnModemFinalAction(pMsg.m_swObjID);
        }
       End;
       PH_MRING_IND  : TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>RING');
       PH_MNOCA_IND  :
       Begin
        TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>NO CARRIER');
        //pMsg.m_sbyFor  := DIR_L1TOL2;
        //pMsg.m_sbyType := QL_DISCCOMPL_REQ;
        //FPUT(BOX_L2,@pMsg);
        //OnDisconnectAction;
       End;
       PH_MBUSY_IND  : TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>BUSY');
       PH_MNDLT_IND  : TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>NO DIAL TONE');
       PH_MNANS_IND  :
       Begin
        TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>NO ANSWER');
        //pMsg.m_sbyFor  := DIR_L1TOL2;
        //pMsg.m_sbyType := QL_DISCCOMPL_REQ;
        //FPUT(BOX_L2,@pMsg);
        //OnDisconnectAction;
       End;
       PH_STATIONON_REQ : TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>STANTION ON');
       PH_STATIONOF_REQ : TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>STANTION OF');
       else
        m_pPort[pMsg.m_swObjID].EventHandler(pMsg);
      End;
    End;
    except
     TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>Error Send.')
    End;
End;
procedure CL1Module.DoHalfTime(Sender:TObject);
Var
    i : Integer;
Begin
    try
     for i:=0 to m_sbyAmPort-1 do
     if Assigned(m_pPort[i]) then
     m_pPort[i].RunTmr;
    except
     TraceL(1,0,'(__)CL1MD::>Error Timer Routing.');
    End;
    //m_csOut.Leave;
End;
procedure CL1Module.DelNodeLv(nIndex:Integer);
Begin
    TraceL(1,0,'(__)CL1MD::>DelNodeLv.');
    if Assigned(m_pPort[nIndex]) then
    Begin
     m_pPort[nIndex].Close;
     m_pPort[nIndex].Destroy;
     m_pPort[nIndex] := Nil;
    End;
End;
procedure CL1Module.AddNodeLv(pTbl:SL1TAG);
Begin
    TraceL(1,0,'(__)CL1MD::>AddNodeLv.');
End;
procedure CL1Module.EditNodeLv(pTbl:SL1TAG);
Begin
    TraceL(1,0,'(__)CL1MD::>EditNodeLv.');
End;
end.
