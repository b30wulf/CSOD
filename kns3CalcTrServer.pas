unit kns3CalcTrServer;

interface

uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
    utldatabase,extctrls,knsl2qwerybytserver,utlmtimer,knsl5tracer,knsl3EventBox,knsl4ConfMeterModule,knsl3calcsystem,knsl3datamatrix,knsl3eventsystem;
type
     CCalcTrServer = class(TThread)
     private
      m_nMsg : CMessage;
      m_nTMR : CTimer;
      m_nPMX : SL3GROUPTAG;
      m_blClFree : Boolean;
      FCalcThread : TThread;
     public
      m_nCS  : CCalcSystem;
      m_nEV  : CEventSystem;
      procedure Init(pMX:PCDataMatrix);
      procedure DoHalfTime(Sender:TObject);
     private
      function SendMatrix(var pMsg:CMessage):Boolean;
      procedure QweryProcWait(var pMsg:CMessage);
      procedure OnHandler;
      procedure Execute; override;
      function EventHandler(var pMsg:CMessage):Boolean;
     public
     property PCalcThread : TThread read FCalcThread   write FCalcThread;
    end;
//var
    // mCServer : CCalcTrServer;
implementation
procedure CCalcTrServer.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CCalcTrServer.Execute;
Begin
     FDEFINE(BOX_CSRV,BOX_CSRV_SZ,True);
     while true do
     Begin
      FGET(BOX_CSRV,@m_nMsg);
      OnHandler;
      //Synchronize(OnHandler);
      //EventHandler(m_nMsg);
     End;
End;
procedure CCalcTrServer.Init(pMX:PCDataMatrix);
Begin
     //m_pDB.GetAbonVMetersTable(-1,-1,m_nPMX);
     //m_pDB.GetVmidJoin(-1,m_nPMX);
     m_nCS := CCalcSystem.Create(pMX);
     m_nEV := CEventSystem.Create(pMX);
     m_blClFree := True;
     Priority := tpHighest;
     Resume;
     m_nTMR := CTimer.Create;
     m_nTMR.SetTimer(DIR_QSTOQS,DL_REPMSG_TMR,0,0,BOX_CSRV);
     m_nTMR.OnTimer(5);
End;
function CCalcTrServer.EventHandler(var pMsg:CMessage):Boolean;
Var
     pDS     : CMessageData;
     sQC     : SQWERYCMDID;
     nHandle : int64;
Begin
     case pMsg.m_sbyFor of
          DIR_CSTOCS :
          case pMsg.m_sbyType of
               DL_REPMSG_TMR :
               Begin
                m_nCS.Run;
                m_nTMR.OnTimer(5);
               End;
          End;
          DIR_L3TOCS: if pMsg.m_sbyType=CSRV_INIT_JMTX then m_pDB.GetVmidJoin(-1,m_nPMX);
          DIR_L2TOL3:
          case pMsg.m_sbyType of
               //PH_EVENTS_INT:SendMatrix(pMsg);
               //DL_DATARD_IND:m_nCS.ExtractData(pMsg);
               DL_DATARD_IND:exit;
               //DL_DATARD_IND:SendMatrix(pMsg);//QweryProcWait(pMsg);
               //Begin
                //TraceM(4,pMsg.m_swObjID,'(__)CCSMD::>CSINP:',@pMsg);
                //SendMatrix(pMsg);
               //End;
          End;
          DIR_QSTOCS:
               case pMsg.m_sbyType of
               CSRV_START_CALC,
               CSRV_CLEAR_DMTX:
               Begin
                 //TraceL(3,0,'(__)CCQMD::>Start Calc AID:'+IntToStr(m_snABOID)+' GID:'+IntToStr(m_snGID)+' VID:'+IntToStr(m_snVMID)+' SRV:'+IntToStr(m_snCLSID)+' PRM:'+IntToStr(m_snCMDID)+' CMD:'+IntToStr(m_snCmdID));
                 m_nCS.EventHandler(pMsg);
               End
          End;
     End;
end;
function CCalcTrServer.SendMatrix(var pMsg:CMessage):Boolean;
Var
     res    : Boolean;
     i,nMID : Integer;
Begin
     res := False;
     try
     nMID := pMsg.m_swObjID;
     for i:=0 to m_nPMX.m_swAmVMeter-1 do
     Begin
      with m_nPMX.Item.Items[i] do
      Begin
       if (m_swMID=nMID)and(not((m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM))) then
       Begin
        pMsg.m_swObjID := m_swVMID;
        case pMsg.m_sbyType of
             PH_EVENTS_INT : res := m_nEV.ExtractData(pMsg);
             DL_DATARD_IND : res := m_nCS.ExtractData(pMsg);
        End;
       End;
      End;
     End;
     Result := res;
     except
      TraceER('(__)CCSMD::>Error In CCalcTrServer.SendMatrix!!!');
     end;
End;

procedure CCalcTrServer.QweryProcWait(var pMsg:CMessage);
Var
     szAbsSize : Integer;
Begin
     szAbsSize := FNABSSIZE(BOX_CSRV);
     if (szAbsSize>=70) then
     Begin
      if m_blClFree=True then
      Begin
       m_blClFree := False;
       FCalcThread.Suspend;
      End;
     End else
     Begin
      if (m_blClFree=False)and(szAbsSize<=60) then
      Begin
      m_blClFree := True;
      FCalcThread.Resume;
      End;
     End;
     //SendMatrix(pMsg);
End;
procedure CCalcTrServer.DoHalfTime(Sender:TObject);
Begin
     try
      if m_nTMR<>Nil then m_nTMR.RunTimer;
     except
      TraceL(3,0,'(__)CCSMD::>Error Timer Routing.');
     End
End;
end.
