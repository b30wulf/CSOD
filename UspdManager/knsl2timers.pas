unit knsl2timers;
interface
uses
     Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,
     knsl1module,
     knsl6module;
type
     CTimerThread = class(TThread)
     private
     { Private declarations }
      w_mEvent1 : THandle;
      sCS1 : TCriticalSection;
     procedure OnHandler;
     protected
     procedure Execute; override;
     end;
implementation
procedure CTimerThread.OnHandler;
Begin
     //TraceL(2,0,'(__)CTMMD::>Timer Empty 1 sec');
     mL1Module.DoHalfTime(Nil);
     mL6Module.DoHalfTime(Nil);
End;
procedure CTimerThread.Execute;
Begin
     sCS1 := TCriticalSection.Create;
     w_mEvent1 := CreateEvent(nil, False, False, nil);
     while True do
     Begin
      WaitForSingleObject(w_mEvent1,1000);
      OnHandler;
     End;
End;
end.
