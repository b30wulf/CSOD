unit knsl1module;
{$DEFINE CLL1_DEBUG}
interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,knsl1cport,knsl1comport,knsl1gprsrouter,
    knsl1tcp,knsl3abon,utldatabase,extctrls,knsl3querysender,utlmtimer,knsl2BTIInit,knsl3EventBox,knsl4ConfMeterModule,knsl4Unloader,knsl4ECOMcrqsrv,
    utlThread;
type
    CL1Module = class(CThread)
    private
     //m_csOut     : TCriticalSection;
     m_nLID      : Byte;
     m_sbyAmPort : Integer;
     m_nMsg      : CMessage;
     procedure OnHandler;
     function EventHandler(var pMsg : CMessage):Boolean;
    protected
     procedure Execute; override;
    public
     m_sIniTbl   : SL1INITITAG;
     m_pPort     : array[0..MAX_PORT] of CPort;
     procedure Init;
     procedure InitMpPort;
     procedure InitIndex(Index:Integer);

     procedure DelNodeLv(nIndex:Integer);
     procedure AddNodeLv(pTbl:SL1TAG);
     procedure EditNodeLv(pTbl:SL1TAG);
     procedure CreateQrySender;
     procedure StartPort;
     procedure StopPort;
     procedure StopIsGprsPort;
     procedure DoHalfTime(Sender:TObject);
     procedure DoHalfSpeedTime(Sender:TObject);
     function GetPortState(nIndex:Byte):Boolean;
     function GetConnectState(nIndex:Byte):Boolean;
     property PPortTable:SL1INITITAG read m_sIniTbl write m_sIniTbl;
     destructor Destroy; override;
    End;
var
    mL1Module : CL1Module = nil;
implementation

procedure CL1Module.OnHandler;
Begin
     EventHandler(m_nMsg);
End;

procedure CL1Module.Execute;
Begin
    FDEFINE(BOX_L1,BOX_L1_SZ,True);
    while not Terminated do
    Begin
     FGET(BOX_L1,@m_nMsg);
     OnHandler;
     //Synchronize(OnHandler);
     //EventHandler(m_nMsg);
    End;
End;

procedure CL1Module.Init;
Var
    i,nIndex,pIndex,nADR : Integer;
Begin
    i := -1;
    mL1Module := self;               //GetSystemTime
    if m_pDB.GetL1Table(m_sIniTbl)=True then
    Begin
     m_nLID      := 1;
     m_sbyAmPort := m_sIniTbl.Count;
     pIndex      := 0;
    try
    for i:=0 to m_sbyAmPort-1 do
    Begin
     nIndex := m_sIniTbl.Items[i].m_sbyPortID;
     case m_sIniTbl.Items[i].m_sbyType of
       DEV_TCP_GPRS:
       Begin
        nADR := m_sIniTbl.Items[i].m_swAddres;
        if nADR>MAX_GPRS then break;
        if m_nGPRS[nADR]=Nil then m_nGPRS[nADR] := CGprsRouter.Create;
        m_nGPRS[nADR].Init(@m_sIniTbl.Items[i]);
        if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := TComPort.Create;
        m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
       End;
       DEV_COM_LOC,DEV_COM_GSM:
       Begin
           if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := TComPort.Create;
           m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
           if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
           Begin
            if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
            mBtiModule.Init(m_sIniTbl.Items[i]);
           End;
           if m_sIniTbl.Items[i].m_sbyType=DEV_COM_GSM then
           Begin
            if m_sIniTbl.Items[i].m_schPhone='Контроль' then
            m_nUNL.Init(m_sIniTbl.Items[i].m_sbyPortID);
           End;
       End;
       DEV_TCP_SRV, DEV_UDP_SRV:
       Begin
           if m_sIniTbl.Items[i].m_sbyProtID<>DEV_ECOM_SRV_CRQ then
           Begin
            if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := CTcpPort.Create;
            m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
            if m_sIniTbl.Items[i].m_sbyControl=1 then
            Begin
             m_nMasterPort0   := nIndex;
             m_nCtrPort.Count := pIndex + 1;
             m_nCtrPort.Items[pIndex] := nIndex;
             m_nCtrPort.SType[pIndex] := m_sIniTbl.Items[i].m_sbyKTRout;
             Inc(pIndex);
            End;
            if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
            Begin
             if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
             mBtiModule.Init(m_sIniTbl.Items[i]);
            End;
            End;
           {End else
           if m_sIniTbl.Items[i].m_sbyProtID=DEV_ECOM_SRV_CRQ then
           Begin
            if not Assigned(m_nCRQ) then m_nCRQ := CEcomCrqSrv.Create;
            m_nCRQ.Init(m_sIniTbl.Items[i]);
            m_nCRQ.Run;
           End;}
       End;
       DEV_TCP_CLI, DEV_UDP_CLI:
       Begin
           if m_sIniTbl.Items[i].m_sbyProtID<>DEV_ECOM_SRV_CRQ then
           Begin
            if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := CTcpPort.Create;
            m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
            if m_sIniTbl.Items[i].m_sbyControl=1 then
            Begin
             m_nMasterPort0   := nIndex;
             m_nCtrPort.Count := pIndex + 1;
             m_nCtrPort.Items[pIndex] := nIndex;
             m_nCtrPort.SType[pIndex] := m_sIniTbl.Items[i].m_sbyKTRout;
             Inc(pIndex);
            End;
            if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
            Begin
             if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
             mBtiModule.Init(m_sIniTbl.Items[i]);
            End;
           //End else
           //if m_sIniTbl.Items[i].m_sbyProtID=DEV_ECOM_SRV_CRQ then
           //Begin
           // if not Assigned(m_nCRQ) then m_nCRQ := CEcomCrqSrv.Create;
           // m_nCRQ.Init(m_sIniTbl.Items[i]);
           // m_nCRQ.Run;
           //End;
           End;
       End;
     End;
    End;
    except
//     TraceL(m_nLID,i,'(__)CL1MD::>Error Create L1.');
    end;
    Priority       := tpHighest;
    Resume;
    End;
    //CreateQrySender;
End;

procedure CL1Module.InitMpPort;
Var
    i,nIndex,pIndex,nADR : Integer;
Begin
  try
   mL1Module := self;
    for i:=0 to MAX_PORT-1 do
       m_pPort[i]:=nil;
  except
//     TraceL(m_nLID,i,'(__)CL1MD::>Error Create L1.');
  end;
  Priority       := tpHighest;
  Resume;
End;

procedure CL1Module.InitIndex(Index:Integer);
Var
    i,nIndex,pIndex,nADR : Integer;
Begin
    i := -1;
//    mL1Module := self;               //GetSystemTime
    if m_pDB.GetL1TableIndex(m_sIniTbl,Index)=True then
    Begin
     m_nLID      := 1;
     m_sbyAmPort := m_sIniTbl.Count;
     pIndex      := 0;
    try
    for i:=0 to m_sbyAmPort-1 do
    Begin
     nIndex := m_sIniTbl.Items[i].m_sbyPortID;
     case m_sIniTbl.Items[i].m_sbyType of
       DEV_TCP_GPRS:
       Begin
        nADR := m_sIniTbl.Items[i].m_swAddres;
        if nADR>MAX_GPRS then break;
        if m_nGPRS[nADR]=Nil then m_nGPRS[nADR] := CGprsRouter.Create;
        m_nGPRS[nADR].Init(@m_sIniTbl.Items[i]);
        if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := TComPort.Create;
        m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
       End;
       DEV_COM_LOC,DEV_COM_GSM:
       Begin
           if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := TComPort.Create;
           m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
           if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
           Begin
            if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
            mBtiModule.Init(m_sIniTbl.Items[i]);
           End;
           //if m_sIniTbl.Items[i].m_sbyType=DEV_COM_GSM then
           //Begin
           // if m_sIniTbl.Items[i].m_schPhone='Контроль' then
           // m_nUNL.Init(m_sIniTbl.Items[i].m_sbyPortID);
           //End;
       End;
       DEV_TCP_SRV, DEV_UDP_SRV:
       Begin
           if m_sIniTbl.Items[i].m_sbyProtID<>DEV_ECOM_SRV_CRQ then
           Begin
            if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := CTcpPort.Create;
            m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
            if m_sIniTbl.Items[i].m_sbyControl=1 then
            Begin
             m_nMasterPort0   := nIndex;
             m_nCtrPort.Count := pIndex + 1;
             m_nCtrPort.Items[pIndex] := nIndex;
             m_nCtrPort.SType[pIndex] := m_sIniTbl.Items[i].m_sbyKTRout;
             Inc(pIndex);
            End;
            if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
            Begin
             if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
             mBtiModule.Init(m_sIniTbl.Items[i]);
            End;
            End;
           {End else
           if m_sIniTbl.Items[i].m_sbyProtID=DEV_ECOM_SRV_CRQ then
           Begin
            if not Assigned(m_nCRQ) then m_nCRQ := CEcomCrqSrv.Create;
            m_nCRQ.Init(m_sIniTbl.Items[i]);
            m_nCRQ.Run;
           End;}
       End;
       DEV_TCP_CLI, DEV_UDP_CLI:
       Begin
           if m_sIniTbl.Items[i].m_sbyProtID<>DEV_ECOM_SRV_CRQ then
           Begin
            if not Assigned(m_pPort[nIndex]) then m_pPort[nIndex] := CTcpPort.Create;
            m_pPort[nIndex].Init(m_sIniTbl.Items[i]);
            if m_sIniTbl.Items[i].m_sbyControl=1 then
            Begin
             m_nMasterPort0   := nIndex;
             m_nCtrPort.Count := pIndex + 1;
             m_nCtrPort.Items[pIndex] := nIndex;
             m_nCtrPort.SType[pIndex] := m_sIniTbl.Items[i].m_sbyKTRout;
             Inc(pIndex);
            End;
            if m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV then
            Begin
             if not Assigned(mBtiModule)      then mBtiModule     := CBTIInit.Create;
             mBtiModule.Init(m_sIniTbl.Items[i]);
            End;
           //End else
           //if m_sIniTbl.Items[i].m_sbyProtID=DEV_ECOM_SRV_CRQ then
           //Begin
           // if not Assigned(m_nCRQ) then m_nCRQ := CEcomCrqSrv.Create;
           // m_nCRQ.Init(m_sIniTbl.Items[i]);
           // m_nCRQ.Run;
           //End;
           End;
       End;
     End;
    End;
    except
//     TraceL(m_nLID,i,'(__)CL1MD::>Error Create L1.');
    end;
//    Priority       := tpHighest;
//    Resume;
    End;
    //CreateQrySender;
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
     i,nPID : Integer;
Begin
     for i:=0 to m_sIniTbl.Count-1 do
     Begin
      nPID := m_sIniTbl.Items[i].m_sbyPortID;
      if m_blPortIndex[nPID]=False then
      Begin
       if (m_sIniTbl.Items[i].m_sbyProtID=DEV_C12_SRV)or
       (m_sIniTbl.Items[i].m_sbyProtID=DEV_ECOM_CLI)or
       (m_sIniTbl.Items[i].m_sbyProtID=DEV_BTI_SRV)or
       (m_sIniTbl.Items[i].m_sbyProtID=DEV_MASTER)or
       (m_sIniTbl.Items[i].m_sbyProtID=DEV_K2000B_CLI)or
       (m_sIniTbl.Items[i].m_sbyProtID=DEV_TRANSIT) then
       Begin
        if m_nQrySender[nPID]<>Nil then
        Begin
         m_nQrySender[nPID].Destroy;
         m_nQrySender[nPID]:=Nil;
        End;
        m_nQrySender[nPID] := CQuerySender.Create(True);
        m_nQrySender[nPID].Init(m_sIniTbl.Items[i]);
        m_nQrySender[nPID].FreeOnTerminate := False;
        m_nQrySender[nPID].Priority := tpHigher;
        m_nQrySender[nPID].PPort := @m_pPort[nPID];
        m_nQrySender[nPID].Resume;
       End;
      End;
     End;
End;
function CL1Module.EventHandler(var pMsg : CMessage):Boolean;
Var
    sPT : SL1SHTAG;
    pDS : CMessageData;
    i : Integer;
Begin
 try
  Result := False;
    try
    //TraceM(1,0,'(__)CL1MD::>MSG:',@pMsg);

    case pMsg.m_sbyFor of
      DIR_L1TOGPRS :
      Begin
     // if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: EventHandler-> DIR_L1TOGPRS!!!');
       case pMsg.m_sbyType of
         DL_START_ROUT_REQ,
         DL_STOP_ROUT_REQ,
         DL_INIT_ROUT_REQ:
         Begin
         // if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: EventHandler-> DL_START_ROUT_REQ,DL_STOP_ROUT_REQ,DL_INIT_ROUT_REQ!!!');
          for i:=0 to MAX_GPRS-1 do
          if Assigned(m_nGPRS[i]) then
          m_nGPRS[i].EventHandler(pMsg);
         End;
       else
         Begin
         // if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: EventHandler-> DIR_L1TOGPRS->ELSE!!!');
          if pMsg.m_swObjID<MAX_GPRS then
          if Assigned(m_nGPRS[pMsg.m_swObjID]) then m_nGPRS[pMsg.m_swObjID].EventHandler(pMsg);
         End;
       End;
      End;
      DIR_QSTOL1:
      Begin
      //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: EventHandler-> DIR_QSTOL1!!!');
      case pMsg.m_sbyType of
         DL_QSDISC_TMR:
         Begin
         // if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: EventHandler->DIR_QSTOL1-> DL_QSDISC_TMR!!!');
          if Assigned(m_nQrySender[pMsg.m_swObjID]) then
          m_nQrySender[pMsg.m_swObjID].EventHandler(pMsg);
         End;
      End;
      End;
      DIR_LMETOL1,DIR_L5TOL1,DIR_BTITOL1,DIR_EKOMTOL1,DIR_C12TOL1,DIR_TRANSITTOL1 :
      case pMsg.m_sbyType of
         PH_DATARD_REQ:
         //if pMsg.m_sbyIntID<m_sIniTbl.Count then
         //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: DIR_LMETOL1,DIR_L5TOL1,DIR_BTITOL1,DIR_EKOMTOL1,DIR_C12TOL1,DIR_TRANSITTOL1!!!');
         if m_pPort[pMsg.m_sbyIntID]<>Nil then
         Begin
          Inc(m_dwOUT);
          if (m_pPort[pMsg.m_sbyIntID]<>Nil)and(pMsg.m_sbyIntID>MAX_PORT) then exit;
          m_pPort[pMsg.m_sbyIntID].Send(@pMsg,pMsg.m_swLen);
         end;
      End;
      DIR_L2TOL1:
      Begin
      //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: DIR_L2TOL1!!!');
      case pMsg.m_sbyType of
         PH_DATARD_REQ:
         //if pMsg.m_sbyIntID<m_sIniTbl.Count then
         if m_pPort[pMsg.m_sbyIntID]<>Nil then
         begin
          //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Knsl1Module1 :: PH_DATARD_REQ!!!');
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
         PH_COMM_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].SendCommandEx(pMsg);
         End;
         PH_OPEN_PORT_IND:
         Begin
          Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
          Move(pDS.m_sbyInfo[0],sPT,sizeof(SL1SHTAG));
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].OpenPortEx(sPT);
         End;
         PH_RESET_PORT_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].ResetPort(pMsg);
         End;
         PH_RECONN_L1_IND:
         Begin
          if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
          m_pPort[pMsg.m_sbyIntID].ReconnectL1(pMsg);
         End;
         PH_STOP_IS_GPRS_IND: StopIsGprsPort;
       End;
      End;
      DIR_L1TOL1:
      case pMsg.m_sbyType of
         PH_CONNTMR_IND: m_pPort[pMsg.m_swObjID].QueryConnect(pMsg);
         PH_MCREG_IND  : begin end;//TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>CREG');
         PH_MCONN_IND  :
       Begin
//          TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>CONNECT');
          //if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Связь установлена');
        //  SendPMSG(BOX_UN_LOAD,0,DIR_ULTOUL,UNL_DIAL_CONN);
          //TAbonManager.OnGsmConnect;
          SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_CONN_IND);
          pMsg.m_sbyFor  := DIR_L1TOL2;
          pMsg.m_sbyType := QL_CONNCOMPL_REQ;
          if ConfMeterAuto<>Nil then ConfMeterAuto.LoHandler(pMsg);
          case pMsg.m_sbyTypeIntID of
            DEV_MASTER,DEV_K2000B_CLI : FPUT(BOX_L2,@pMsg);
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
            DEV_C12_SRV:
                   Begin
                    pMsg.m_sbyFor := DIR_L1TOL2;
                    FPUT(BOX_L4,@pMsg);
                   End;
            DEV_TRANSIT:
                   Begin
                    pMsg.m_sbyFor := DIR_L1TOL2;
                    FPUT(BOX_L4,@pMsg);
                   End;
          End;

       End;
       PH_MDISC_IND  :
       Begin
//          TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>DISC');
          //m_nQrySender[pMsg.m_sbyDirID].OnModemFinalAction(pMsg.m_swObjID);
          SendPMSG(BOX_UN_LOAD,pMsg.m_sbyDirID,DIR_ULTOUL,UNL_DIAL_DISC);
          SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_DISC_IND);
          pMsg.m_sbyFor  := DIR_L1TOL2;
          pMsg.m_sbyType := QL_DISCCOMPL_REQ;
          case pMsg.m_sbyTypeIntID of
            DEV_MASTER,DEV_K2000B_CLI : FPUT(BOX_L2,@pMsg);
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
            DEV_C12_SRV:
                   Begin
                    pMsg.m_sbyFor := DIR_L1TOC12;
                    FPUT(BOX_L4,@pMsg);
                   End;
            DEV_TRANSIT:
                   Begin
                    pMsg.m_sbyFor := DIR_ARTOL4;
                    FPUT(BOX_L4,@pMsg);
                   End;
          End;
        //OnDisconnectAction;
       End;
        PH_DIAL_ERR_IND:
        Begin
           //TraceL(1,pMsg.m_swObjID,'(__)CL1MD::>DIAL Error!!!');
           if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка установления связи по GSM каналу!!!');
           if m_nQrySender[pMsg.m_sbyDirID]<>Nil then
           m_nQrySender[pMsg.m_sbyDirID].OnDialError;
           Sleep(500);
        End;
        PH_MDISCSCMPL_IND:
        Begin
           //TraceL(1,pMsg.m_swObjID,'(__)CL1MD::>DISCONNECT COMPLETTE.');
           if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Соединение разорвано успешно.');
           //if m_nQrySender[pMsg.m_sbyDirID]<>Nil then
           //m_nQrySender[pMsg.m_sbyDirID].OnModemFinalAction(pMsg.m_swObjID);
           //TAbonManager.OnGsmError;
           //if ConfMeterAuto<>Nil then ConfMeterAuto.LoHandler(pMsg);
           //SendPMSG(BOX_UN_LOAD,pMsg.m_sbyDirID,DIR_ULTOUL,UNL_DIAL_DISC);
           if m_pPort[pMsg.m_sbyIntID]=Nil then exit;
           //if (m_pPort[pMsg.m_sbyIntID].m_nL1.m_nFreePort=1) then m_pPort[pMsg.m_sbyIntID].FreePort(pMsg);
           Sleep(200);
        End;
        PH_MRING_IND  :
        Begin
           // TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>RING');

        End;
        PH_MNOCA_IND  :
        Begin
           //TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>NO CARRIER');
           if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! Соединение разорвано по неизвестной причине.');
           //TAbonManager.OnGsmError;
           //if ConfMeterAuto<>Nil then ConfMeterAuto.LoHandler(pMsg);
           //SendPMSG(BOX_UN_LOAD,pMsg.m_sbyDirID,DIR_ULTOUL,UNL_DIAL_DISC);
        End;
        PH_MBUSY_IND  :
        Begin
           if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! Абонент уже занят.');
           //TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>BUSY');
           //SendPMSG(BOX_UN_LOAD,pMsg.m_sbyDirID,DIR_ULTOUL,UNL_DIAL_DISC);
        End;
        PH_MNDLT_IND  :
        Begin
           if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! Абонент отключен.');
          // TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>NO DIAL TONE');
           //SendPMSG(BOX_UN_LOAD,pMsg.m_sbyDirID,DIR_ULTOUL,UNL_DIAL_DISC);
        End;
        PH_MNANS_IND  :
        Begin
           if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! Соединение разорвано по неизвестной причине.');
           //TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>NO ANSWER');
           //TAbonManager.OnGsmError;
        //   if ConfMeterAuto<>Nil then ConfMeterAuto.LoHandler(pMsg);
         //  SendPMSG(BOX_UN_LOAD,pMsg.m_sbyDirID,DIR_ULTOUL,UNL_DIAL_DISC);
        //pMsg.m_sbyFor  := DIR_L1TOL2;
        //pMsg.m_sbyType := QL_DISCCOMPL_REQ;
        //FPUT(BOX_L2,@pMsg);
        //OnDisconnectAction;
        End;
        PH_STATIONON_REQ :
        Begin
         //if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! GSM Модем в сети.');
         SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_STATIONON_REQ);//TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>STANTION ON');
         if m_nQrySender[pMsg.m_sbyDirID]<>Nil then m_nQrySender[pMsg.m_sbyDirID].SetModemState(PH_STATIONON_REQ);
        End;
        PH_STATIONOF_REQ :
        Begin
         //if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! GSM Модем не сети.');
         SendMsg(BOX_L3_LME,0,DIR_LLTOLM3,PH_STATIONOF_REQ);//TraceL(m_nLID,pMsg.m_sbyDirID,'(__)CL1MD::>STANTION OF');
         if m_nQrySender[pMsg.m_sbyDirID]<>Nil then m_nQrySender[pMsg.m_sbyDirID].SetModemState(PH_STATIONOF_REQ);
        End;
        else
        if m_pPort[pMsg.m_swObjID]<>Nil then
        m_pPort[pMsg.m_swObjID].EventHandler(pMsg);
      End;
    End;
    except
     //TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>Error Send.')
    End;
 Except
   if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Error_Knsl1Module1 :: EventHandler!!!');
 end;
End;

procedure CL1Module.DoHalfSpeedTime(Sender:TObject);
Var
    i,nPID : Integer;
Begin
    try
     for i:=0 to m_sIniTbl.Count-1 do
     Begin
      nPID := m_sIniTbl.Items[i].m_sbyPortID;
      if Assigned(m_pPort[nPID]) then
      m_pPort[nPID].RunSpeedTmr;
     End;
    except
//      TraceL(1,0,'(__)CL1MD::>Error SpeedTimer Routing.');
    End
End;
procedure CL1Module.DoHalfTime(Sender:TObject);
Var
    i,nPID : Integer;
Begin
    try
     //if mBtiModule<>Nil then   mBtiModule.RunModule;
    // for i:=0 to MAX_GPRS-1 do
   //  if Assigned(m_nGPRS[i]) then m_nGPRS[i].Run;
     for i:=0 to m_sIniTbl.Count-1 do
     Begin
      nPID := m_sIniTbl.Items[i].m_sbyPortID;
      if Assigned(m_pPort[nPID]) then
      m_pPort[nPID].RunTmr;

      if m_blPortIndex[nPID]=False then
      if m_nQrySender[nPID]<>Nil then m_nQrySender[nPID].Run;
     End;
    except
//     TraceL(1,0,'(__)CL1MD::>Error Timer Routing.');
    End;
    //m_csOut.Leave;
End;
function CL1Module.GetPortState(nIndex:Byte):Boolean;
Begin
    Result := False;
    if Assigned(m_pPort[nIndex]) then
    Result := m_pPort[nIndex].GetPortState;
End;
function CL1Module.GetConnectState(nIndex:Byte):Boolean;
Begin
    Result := False;
    if Assigned(m_pPort[nIndex]) then
    Result := m_pPort[nIndex].GetConnectState;
End;
procedure CL1Module.StartPort;
Var
    i,nPID : Integer;
Begin
    for i:=0 to m_sbyAmPort-1 do
    Begin
     nPID := m_sIniTbl.Items[i].m_sbyPortID;
     if Assigned(m_pPort[nPID]) then
     m_pPort[i].StartPort;
    End;
End;
procedure CL1Module.StopPort;
Var
    i,nPID : Integer;
Begin
    for i:=0 to m_sbyAmPort-1 do
    Begin
     nPID := m_sIniTbl.Items[i].m_sbyPortID;
     if Assigned(m_pPort[nPID]) then
     m_pPort[nPID].StopPort;
    End;
End;
procedure CL1Module.StopIsGprsPort;
Var
    i,nPID : Integer;
Begin
    for i:=0 to m_sbyAmPort-1 do
    Begin
     nPID := m_sIniTbl.Items[i].m_sbyPortID;
     if Assigned(m_pPort[nPID]) then
     m_pPort[nPID].StopIsGPRS;
    End;
End;
procedure CL1Module.DelNodeLv(nIndex:Integer);
Begin
//    TraceL(1,0,'(__)CL1MD::>DelNodeLv.');
    if Assigned(m_pPort[nIndex]) then
    Begin
     m_pPort[nIndex].Close;
     m_pPort[nIndex].Destroy;
     m_pPort[nIndex] := Nil;
    End;
End;
procedure CL1Module.AddNodeLv(pTbl:SL1TAG);
Begin
//    TraceL(1,0,'(__)CL1MD::>AddNodeLv.');
End;
procedure CL1Module.EditNodeLv(pTbl:SL1TAG);
Begin
//    TraceL(1,0,'(__)CL1MD::>EditNodeLv.');
End;
destructor CL1Module.Destroy;
var
  I: Integer;
  P: CPort;
begin
  if mBtiModule <> nil then FreeAndNil(mBtiModule);

  for I := Low(m_pPort) to High(m_pPort) do begin
    P := m_pPort[I];
    if P <> nil then begin
      if P is CPort then
        FreeAndNil(m_pPort[I]);
    end;
  end;

  inherited;
end;

end.
