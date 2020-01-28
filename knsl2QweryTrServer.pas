unit knsl2QweryTrServer;

interface

uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
    utldatabase,knsl2qweryportpull,
    extctrls,knsl2qwerybytserver,utlmtimer,knsl5tracer,knsl3EventBox,knsl4ConfMeterModule,
    knsl2qweryserver,knsl3datamatrix, utlThread;
type
     CQweryTRSRV = class(CThread)
     private
      FPull  : TThreadList;
      m_nMsg : CMessage;
      m_nTMR : CTimer;
      m_pMX  : PCDataMatrix;
      function getPull(pMDB:PCDBDynamicConn):TThreadList;
      procedure OnHandler;
      function EventHandler(var pMsg:CMessage):Boolean;
     protected
      procedure Execute; override;
     public
      m_nQS  : CQweryServers;
      m_nQSB : CQweryBytServers;
      procedure Init(pMX:PCDataMatrix;pMDB:PCDBDynamicConn);
      procedure InitPUL(pMDB:PCDBDynamicConn);
      procedure DoHalfTime(Sender:TObject);
      destructor Destroy; override;
    end;
var
     mQServer : CQweryTRSRV = nil;
implementation
procedure CQweryTRSRV.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CQweryTRSRV.Execute;
Begin
     FDEFINE(BOX_QSRV,BOX_QSRV_SZ,True);
     while not Terminated do
     Begin
      FGET(BOX_QSRV,@m_nMsg);
      OnHandler;
      //Synchronize(OnHandler);
      //EventHandler(m_nMsg);
     End;
End;
procedure CQweryTRSRV.Init(pMX:PCDataMatrix;pMDB:PCDBDynamicConn);
Var
     portPull    : TThreadList;
Begin
     portPull := getPull(pMDB);
     m_nQSB   := CQweryBytServers.Create;
     m_nQSB.init(portPull);
     m_nQS  := CQweryServers.Create(pMX,pMDB);
     m_pMX  := pMX;
     Priority  := tpHighest;
     Resume;
     m_nTMR := CTimer.Create;
     m_nTMR.SetTimer(DIR_QSTOQS,DL_REPMSG_TMR,0,0,BOX_QSRV);
     m_nTMR.OnTimer(5);
End;

procedure CQweryTRSRV.InitPUL(pMDB:PCDBDynamicConn);
Var
     portPull    : TThreadList;
Begin
     portPull := getPull(pMDB);
     m_nQSB.init(portPull);
    { if portPull<>nil then
        FreeAndNil(portPull);  }
End;

function CQweryTRSRV.getPull(pMDB:PCDBDynamicConn):TThreadList;
Var
     i          : Integer;
     vList      : TList;
     pl         : CL2Pulls;
     pullConfig : TThreadList;
Begin
  ClearListAndFree(FPull);
  FPull       := TThreadList.Create;

  pullConfig := TThreadList.Create;
  pMDB.getPulls(pullConfig);
  vList := pullConfig.LockList;
     for i:=0 to vList.count-1 do
     Begin
      pl := vList[i];
      FPull.add(CPortPull.Create(pl));
     End;
  pullConfig.UnLockList;
  FreeAndNil(pullConfig);
  Result := FPull;
End;


{
      m_swSpecc0 := nCMDID and (not CMD_ENABLED);
      m_swSpecc0 := m_swSpecc0 or (Word(m_snCLSID) shl 8);
      m_swSpecc1 := Word(m_snCLID);
      m_swSpecc2 := Word(m_snSRVID);
      m_swSpecc2 := m_swSpecc2 or (Word(m_snAID) shl 8);
}
function CQweryTRSRV.EventHandler(var pMsg:CMessage):Boolean;
Var
     pDS : CMessageData;
     pQR : CQueryPrimitive;
     sQC : SQWERYCMDID;
Begin
     case pMsg.m_sbyFor of
          DIR_QSTOQS :
          case pMsg.m_sbyType of
               DL_REPMSG_TMR :
               Begin
                //m_nQS.Run;
                m_nQSB.Run;
                m_nTMR.OnTimer(3);
               End;
          End;
          DIR_L2TOQS:
          case pMsg.m_sbyType of
               QSRV_LOAD_COMPL_REQ :
               Begin
                 Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
                 Move(pDS.m_sbyInfo[0],pQR,sizeof(CQueryPrimitive));
                 with sQC do
                 Begin
                  m_snABOID := HiByte(pQR.m_swSpecc2);
                  m_snSRVID := LoByte(pQR.m_swSpecc2);
                  m_snCLID  := pQR.m_swSpecc1;
                  m_snCLSID := HiByte(pQR.m_swSpecc0);
                  m_snPrmID := LoByte(pQR.m_swSpecc0);
                  m_snCmdID := CS_CRT_JOB;
                  TraceL(3,0,'(__)CSQMD::>Load Complete AID:'+IntToStr(m_snABOID)+' SRVID:'+IntToStr(m_snSRVID)+' CLID:'+IntToStr(m_snCLID)+' CLS:'+IntToStr(m_snCLSID)+' CMD:'+IntToStr(m_snCmdID)+' PRM:'+IntToStr(m_snPrmID));
                  m_nQS.SetCmdState(m_snSRVID,m_snCLID,m_snCLSID,m_snPrmID);
                 End;
               End;
               QSRV_FIND_COMPL_REQ:
               Begin
                 Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
                 Move(pDS.m_sbyInfo[0] ,sQC,sizeof(SQWERYCMDID));
                 with sQC do m_nQS.CheckFindState(m_snSRVID,m_snCLID,m_snCLSID,m_snPrmID);
               End;
          End;
          DIR_CSTOQS:
          case pMsg.m_sbyType of
               QSRV_CALC_COMPL_REQ:
               Begin
                 Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
                 m_nQS.OnEndQwery(pDS.m_swData0,-1,pDS.m_swData1,pDS.m_swData2);
                 TraceL(3,0,'(__)CSQMD::>Calc Complete SRVID:'+IntToStr(pDS.m_swData0)+' CLS:'+IntToStr(pDS.m_swData1)+' PRM:'+IntToStr(pDS.m_swData2));
               End;
               QSRV_ERR_L2_REQ: m_nQS.EventHandler(pMsg);
          End;
     End;
end;
procedure CQweryTRSRV.DoHalfTime(Sender:TObject);
Begin
     try
      if m_nTMR<>Nil then m_nTMR.RunTimer;
     except
      TraceL(3,0,'(__)CSQMD::>Error Timer Routing.');
     End
End;
destructor CQweryTRSRV.Destroy;
begin
  Suspend;

  if m_nTMR <> nil then FreeAndNil(m_nTMR);
  if m_nQSB <> nil then FreeAndNil(m_nQSB);
  if m_nQS <> nil then FreeAndNil(m_nQS);

  ClearListAndFree(FPull);
  inherited;
end;

end.
