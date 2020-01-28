unit kns3SaveTrServer;

interface

uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
    utldatabase,extctrls,utlmtimer,knsl5tracer,knsl3EventBox,knsl4ConfMeterModule,knsl3savesystem,knsl3savebase;
type
     CSaveTrServer = class(TThread)
     private
      m_nMsg : CMessage;
      FCalcThread : TThread;
      m_blClFree : Boolean;
     public
      m_nSS  : CSaveSystem;
      m_nSDB : CSaveBase;
      procedure Init;
      procedure DoHalfTime(Sender:TObject);
     private
      procedure OnHandler;
      procedure Execute; override;
      procedure CalcProcWait(var pMsg:CMessage);
      function EventHandler(var pMsg:CMessage):Boolean;
     public
     property PCalcThread : TThread read FCalcThread   write FCalcThread;
    end;
//var
 //    mSServer : CSaveTrServer;
implementation
procedure CSaveTrServer.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CSaveTrServer.Execute;
Begin
     FDEFINE(BOX_SSRV,BOX_SSRV_SZ,True);
     while true do
     Begin
      FGET(BOX_SSRV,@m_nMsg);
      OnHandler;
      //Synchronize(OnHandler);
     End;
End;
procedure CSaveTrServer.Init;
Begin
     m_nSS  := CSaveSystem.Create;
     m_nSDB := CSaveBase.Create;
     m_nSS.PSaveDB := @m_nSDB;
     //m_nSS.SendPackDBS;
     m_blClFree := True;
     Priority := tpHigher;
     Resume;
     //m_nSS.SendPackDBS;
End;
function CSaveTrServer.EventHandler(var pMsg:CMessage):Boolean;
Begin
     try
     case pMsg.m_sbyFor of
          DIR_SSTOSB : m_nSDB.EventHandler(pMsg);
          DIR_SSTOSS :
          Begin
            if pMsg.m_sbyType=SVS_SVBS_TMR then
            Synchronize(m_nSS.SendPackDBS) else
            m_nSS.EventHandler(pMsg);
          End;
          DIR_CSTOSS : m_nSS.EventHandler(pMsg);//CalcProcWait(pMsg);
     End;
     except
      TraceL(3,0,'(__)CSSMD::>Error In CSaveTrServer.EventHandler!!!');
     End
end;
procedure CSaveTrServer.CalcProcWait(var pMsg:CMessage);
Var
     szAbsSize : Integer;
Begin
     szAbsSize := FNABSSIZE(BOX_SSRV);
     if (szAbsSize>=80) then
     Begin
      if m_blClFree=True then
      Begin
       m_blClFree := False;
       FCalcThread.Suspend;
      End;
     End else
     Begin
      if (m_blClFree=False)and(szAbsSize<=70) then
      Begin
      m_blClFree := True;
      FCalcThread.Resume;
      End;
     End;
     m_nSS.EventHandler(pMsg);
End;
procedure CSaveTrServer.DoHalfTime(Sender:TObject);
Begin
     try
      if m_nSS<>Nil  then m_nSS.Run;
      if m_nSDB<>Nil then m_nSDB.Run;
     except
      TraceL(3,0,'(__)CSSMD::>Error Timer Routing!!!');
     End
End;
end.
