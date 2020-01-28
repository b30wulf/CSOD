unit knsl2timers;
interface
uses
     Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,
     knsl1module,
     knsl2module,
     knsl3module,
     knsl3lme,
     knsl3querysender,
     knsl4module,
     knsl5tracer,
     knsl3FHModule,
     knsl3transtime,
     //knsl3selftestmodule,
     knsl3chandge,
     knsl4Unloader,
     knsl3savetime,
     knsl3discret,
     knsl2QweryTrServer,
     kns3SaveTrServer,
     knsl5protectmdl,
     knsl5config,
     utlThread;

type
     CTimerThread = class(CThread)
     private
     { Private declarations }
      w_mEvent1 : THandle;
//      sCS1 : TCriticalSection;
      dwCount : Dword;
     procedure OnHandler;
     procedure OnSpeedHandler;
     protected
     procedure Execute; override;
     end;
implementation
procedure CTimerThread.OnHandler;
Begin
     //TraceL(2,0,'(__)CTMMD::>Timer Empty 1 sec');
mL1Module.DoHalfTime(Nil);
     //mL2Module.DoHalfTime(Nil);
//     mL3Module.DoHalfTime(Nil);
     //mL4Module.DoHalfTime(Nil);
mL3LmeMoule.DoHalfTime(Nil);
if mQServer<>Nil then mQServer.DoHalfTime(Nil);
     //if mSServer<>Nil then mSServer.DoHalfTime(Nil);
     //if mL3FHModule<>Nil then mL3FHModule.DoHalfTime(Nil);
     //if mL3STModule<>Nil then mL3STModule.DoHalfTime(Nil);
     //if TMeterChandge<>Nil then TMeterChandge.Run;
     //if TL2Statistic<>Nil then TL2Statistic.Run;
     //if m_nCF<>Nil then m_nCF.Run;
     //if m_nCF<>Nil then if m_nCF.m_nTT<>Nil then m_nCF.m_nTT.Run;
     //if m_nUNL<>Nil then m_nUNL.Run;
     //if m_nPMD<>Nil then m_nPMD.Run;
     //if m_nST<>Nil then m_nST.Run;

     //TKnsForm.DoHalfTime(Nil);
     //for i:=0 to MAX_PORT do if m_nQrySender[i]<>Nil then m_nQrySender[i].DoHalfTime(Nil);
End;
procedure CTimerThread.OnSpeedHandler;
Var
     i : Integer;
Begin
     for i:=0 to m_nDIO.Count-1 do m_nDIO.Items[i].Run;
     mL2Module.DoHalfSpeedTime(Nil);
     //mL1Module.DoHalfSpeedTime(Nil);
End;
procedure CTimerThread.Execute;
Begin
//     sCS1 := TCriticalSection.Create;
     w_mEvent1 := CreateEvent(nil, False, False, nil);
     while not Terminated do
     Begin
      WaitForSingleObject(w_mEvent1,200);
      if (dwCount mod 5)=0 then Synchronize(OnHandler);
      Synchronize(OnSpeedHandler);
      dwCount := dwCount + 1;
     End;
End;
end.
