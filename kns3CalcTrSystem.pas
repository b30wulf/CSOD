unit knsl3CalcTrSystem;

interface

uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
    utldatabase,extctrls,utlmtimer,knsl5tracer,knsl3EventBox,knsl4ConfMeterModule,knsl3calcsystem;
type
     CCalcTrSystem = class(TThread)
     private
      m_nMsg : CMessage;
      m_nTMR : CTimer;
      m_nPMX : SL3GROUPTAG;
      m_nCS  : CCalcSystem;
     public
      procedure Init;
      procedure DoHalfTime(Sender:TObject);
     private
      function SendMatrix(var pMsg:CMessage):Boolean;
      procedure OnHandler;
      procedure Execute; override;
      function EventHandler(var pMsg:CMessage):Boolean;
    end;
var
     mCSystem : CCalcTrSystem;
implementation
procedure CCalcTrSystem.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CCalcTrSystem.Execute;
Begin
     FDEFINE(BOX_CSRV,BOX_CSRV_SZ,True);
     while true do
     Begin
      FGET(BOX_CSRV,@m_nMsg);
      Synchronize(OnHandler);
      //EventHandler(m_nMsg);
     End;
End;
procedure CCalcTrSystem.Init;
Begin
     m_pDB.GetVmidJoin(-1,m_nPMX);
     m_nCS := CCalcSystem.Create;
     //m_nQS.Destroy;
     //m_nQS.InitAllAbon(-1);
     //for i:=0 to 100 do
     //Begin
     //m_nQS := CQwerySystemServer.Create;
     //m_nQS.Destroy;
     //End;
     Priority  := tpHighest;
     Resume;
     m_nTMR := CTimer.Create;
     m_nTMR.SetTimer(DIR_QSTOQS,DL_REPMSG_TMR,0,0,BOX_CSRV);
     m_nTMR.OnTimer(5);
End;
function CCalcTrSystem.EventHandler(var pMsg:CMessage):Boolean;
Var
     snCMDID,snSRVID : Byte;
     snVMID : Word;
     pDS    : CMessageData;
     pQR    : CQueryPrimitive;
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
          DIR_L2TOCS:
          case pMsg.m_sbyType of
               DL_MONINFO_IND:
               Begin
                TraceM(4,pMsg.m_swObjID,'(__)CCSMD::>CSINP:',@pMsg);
                SendMatrix(pMsg);
               End;
               QSRV_LOAD_COMPL_REQ :
               Begin
                Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
                Move(pDS.m_sbyInfo[0],pQR,sizeof(CQueryPrimitive));
                snCMDID := LoByte(pQR.m_swSpecc0);
                snSRVID := HiByte(pQR.m_swSpecc0);
                snVMID  := pQR.m_swSpecc1;
                TraceL(3,0,'(__)CCSMD::>Load Complete VMID:'+IntToStr(snVMID)+' SRV:'+IntToStr(snSRVID)+' CMD:'+IntToStr(snCMDID));
                //if Assigned(m_nQMDL[snVMID]) then m_nQMDL[snVMID].OnEndQwery(snSRVID,snCMDID);
               End
               //m_nQS.EventHandler(pMsg);
          End;
     End;
end;
function CCalcTrSystem.SendMatrix(var pMsg:CMessage):Boolean;
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
        res := m_nCST.ExtractData(pMsg);
       End;
      End;
     End;
     Result := res;
     except
      TraceER('(__)CCSMD::>Error In CCalcTrSystem.SendMatrix!!!');
     end;
End;
procedure CCalcTrSystem.DoHalfTime(Sender:TObject);
Begin
     try
      if m_nTMR<>Nil then m_nTMR.RunTimer;
     except
      TraceL(3,0,'(__)CCSMD::>Error Timer Routing.');
     End
End;
end.
