unit knsl2CThreadPull;
interface
uses
Windows, Classes, SysUtils,SyncObjs,utlcbox,knsl2IRunnable,utlconst,knsl3EventBox,utlThread,utlTypes{$IFDEF JCL1}, uJCL {$ENDIF};
type
    CPullMessage = packed record
     m_swLen    : Word;
     ptr        : Pointer;
     isFreeNeed : Boolean;
    end;

    CTaskExequtor = class(CThread)
     private
      FBusy     : boolean;
      csBusy    : TCriticalSection;
      event     : THandle;
      FTask     : IRunnable;
      semaphore : THandle;
      FisFreeNeed :Boolean;
     protected
       procedure Execute;override;
     public
      procedure setBusy(const Value :Boolean);
      function IsBusy():boolean;
      procedure submit(value:IRunnable);
      constructor Create(const sem: THandle);
      destructor Destroy;override;
      function getTask:IRunnable;
      procedure setTask(const value :IRunnable);
    End;
    PCTaskExequtor = ^CTaskExequtor;


 CThreadPull = class(CThread)
     private
      name       : String;
      semaphore  : THandle;
      maxThreads : Integer;
      pull       : TThreadList;
      taskList   : TThreadList;
      box        : CBox;
      outmsg     : CPullMessage;
      inmsg      : CPullMessage;
      function isOnlyBusy:boolean;
     protected
      procedure Execute; override;
     public
      function  setState(threadID,state:Integer):boolean;
      procedure submit(value:PIRunnable);
      procedure submitAndFree(value:PIRunnable);
      function  exequte(value:IRunnable; const aIsFreeNeed :Boolean = False):Boolean;
      procedure  getAll;
      function  ClearTask:boolean;
      procedure freeBox;
      constructor Create(vmaxThreads,vmaxJobs:Integer;vName:String);
      destructor Destroy;override;
    End;
    PCThreadPull = ^CThreadPull;


implementation

constructor CThreadPull.Create(vmaxThreads,vmaxJobs: Integer;vName:String);
Var
    i : Integer;
    taskExequtor : CTaskExequtor;
begin
    inherited Create(True);
    name       := vName;
    Priority   := tpTimeCritical;
    maxThreads := vmaxThreads;
    pull       := TThreadList.Create;
    taskList   := TThreadList.Create;
    box        := CBox.Create(vmaxJobs*sizeof(CPullMessage),true);
    semaphore  := CreateSemaphore(nil,maxThreads,maxThreads,nil);
    for i:=0 to maxThreads-1 do
    Begin
     taskExequtor := CTaskExequtor.Create(semaphore);
     pull.LockList.add(taskExequtor);
     pull.UnLockList;
    End;
    Resume;
end;
destructor CThreadPull.Destroy;
Begin
  Suspend;
  ClearListAndFree(pull);
  ClearListAndFree(taskList);      ///////
  if box <> nil then FreeAndNil(box);
 // if taskList <> nil then FreeAndNil(taskList);
  if semaphore <> 0 then CloseHandle(semaphore);
  inherited;
End;
procedure CThreadPull.freeBox;
Begin
    box.FFREE;
End;
procedure CThreadPull.Execute;
Var
    runnable : IRunnable;
   // index    : Integer;
   // vList    : TList;
Begin
    while not Terminated do
    Begin
     box.FGET(@inmsg);
     runnable := IRunnable(inmsg.ptr^);
     //vList    :=  taskList.LockList;
     //runnable :=  vList[0];
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(runnable.getId)+')CThreadPull SUBMIT GET NAME: '+name+' SIZE: '+IntToStr(box.FCHECK));
     exequte(runnable, inmsg.isFreeNeed);
     //vList.Delete(0);
     //taskList.UnLockList;
     Dispose(inmsg.ptr);
    End;

End;

procedure CThreadPull.submitAndFree(value:PIRunnable);
begin
    outmsg.m_swLen    := SizeOf(CPullMessage);
    outmsg.ptr        := value;
    outmsg.isFreeNeed := True;
    box.FPUT(@outmsg);
end;

procedure CThreadPull.submit(value:PIRunnable);
Begin
    outmsg.m_swLen    := SizeOf(CPullMessage);
    outmsg.ptr        := value;
    outmsg.isFreeNeed := False;
    box.FPUT(@outmsg);
End;

procedure CThreadPull.getAll;
Begin
    while isOnlyBusy do
    Begin
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+name+')CThreadPull WaitAll...');
     sleep(1000);
    End;
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+name+')CThreadPull WaitAll Complette.');
End;

function CThreadPull.ClearTask:boolean;
Var
    executor : CTaskExequtor;
    vList    : TList;
    i        : Integer;
    task     : IRunnable;
Begin
   vList := pull.LockList;
   try
    try
     for i :=0 to vList.Count-1 do
     begin
      executor := vList[i];
      task     := executor.getTask;
      if (task<>nil)then
      begin
        FreeAndNil(task);
        executor.setTask(nil);
      end;
     end;
    except
      executor.setTask(nil);
    end;
   finally
     pull.UnLockList;
     Result:=true;
   end;
End;

function CThreadPull.setState(threadID,state:Integer):boolean;
Var
    executor : CTaskExequtor;
    vList    : TList;
    i        : Integer;
    task     : IRunnable;
Begin
    vList := pull.LockList;
    try
     for i :=0 to vList.Count-1 do
     begin
      executor := vList[i];
      task     := executor.getTask;
      if (task<>nil) and (task.getId=threadID) then
      begin
       task.setTaskState(state);// := state; // task.state := state;
      end;
     end;
    finally
     pull.UnLockList;
    end;
End;
function CThreadPull.isOnlyBusy:boolean;
Var
    executor : CTaskExequtor;
    vList    : TList;
    i        : Integer;
Begin
    Result := False;
    vList := pull.LockList;
    try
     for i :=0 to vList.Count-1 do
     begin
      executor := vList[i];
      if  executor.IsBusy then
      begin
       Result := True;
       Exit;
      end;
     end;
    finally
     pull.UnLockList;
    end;
End;

function CThreadPull.exequte(value:IRunnable; const aIsFreeNeed :Boolean):Boolean;
var
    RC       : Integer;
    i        : Integer;
    executor : CTaskExequtor;
    vList    : TList;
begin
    Result := False;
    //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(value.getId)+')CThreadPull Ожидание выполнения задания PULL: '+name);
    RC := WaitForSingleObject(semaphore,INFINITE);
    //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(value.getId)+')CThreadPull Выполнение задания PULL: '+name);
    case RC of
    WAIT_OBJECT_0:
     begin
       vList := pull.LockList;
       try
        for i := 0 to Pred(vList.Count) do
        begin
         executor := CTaskExequtor(vList[i]);
         if not executor.IsBusy then
         begin
           executor.FisFreeNeed := aIsFreeNeed;
           executor.submit(value);
           Result := True;
           Exit;
         end;
        end;
       finally
         pull.UnLockList;
       end;
     end;
    end;
end;

constructor CTaskExequtor.create(const sem :THandle);
Begin
    inherited Create(True);
    FBusy      := false;
    semaphore := sem;
    csBusy    := TCriticalSection.Create;
    event     := CreateEvent(nil, False, False, nil);
    ResetEvent(event);
    Priority  := tpTimeCritical;
    Resume;
End;

destructor CTaskExequtor.Destroy;
Begin
  Suspend;
  if event <> 0 then CloseHandle(event);
  if csBusy <> nil then FreeAndNil(csBusy);
  inherited;
End;

procedure CTaskExequtor.setBusy(const Value :Boolean);
begin
  csBusy.Enter();
  FBusy := Value;
  csBusy.Leave();
end;

function CTaskExequtor.IsBusy():boolean;
begin
  csBusy.Enter();
  result := FBusy;
  csBusy.Leave();
end;
procedure CTaskExequtor.Execute;
Var
  rc   : DWORD;
  res  : Integer;
  task : IRunnable;
//  taskParent : IRunnable;
Begin
  while not Terminated do begin
    try
     try
      rc := WaitForSingleObject(event,INFINITE);
        if rc = WAIT_OBJECT_0 then begin
          setBusy(True);
          task := getTask();
          if task <> nil then begin
            res := task.run;
            task.setTaskStateHouse(res);
            if FisFreeNeed then
             begin
              //taskParent:= task.getParent;
//              FreeAndNil(taskParent);//.Destroy;
              //taskParent^:=nil;
              //Dispose(taskParent);
              FreeAndNil(task);
              setTask(nil);
             end;
          end
          else if EventBox <> Nil then EventBox.FixEvents(ET_CRITICAL,'(nil)CTaskExequtor ERROR task==nil!!!. ');
        end
        else Win32Check(rc <> WAIT_FAILED);
     except
      on E: Exception do begin
        {$IFDEF JCL1}
        E.Message := uJCL.JclAddStackList(E.Message);
        {$ENDIF}
        TEventBox.FixEvents(ET_CRITICAL,'('+IntToStr(task.getId)+')CTaskExequtor ERROR!!!. '#10+E.Message);

        task.setTaskStateHouse(res);
            if FisFreeNeed then
             begin
              TEventBox.FixEvents(ET_CRITICAL,'('+IntToStr(task.getId)+')Exception CTaskExequtor ERROR DELETE!!!. '#10);
              FreeAndNil(task);
              setTask(nil);
             end;
      end;
     end;
    finally
     if FisFreeNeed and (task <> nil) then begin
        FreeAndNil(task);
        setTask(nil);
        TEventBox.FixEvents(ET_CRITICAL,'('+IntToStr(task.getId)+')CTaskExequtor DELETE!!!. '#10);
     end;
      setBusy(False);
      ReleaseSemaphore(semaphore, 1, nil);
    end;
  end;
End;

procedure CTaskExequtor.submit(value:IRunnable);
Begin
  setTask(value);
  setBusy(True);
  SetEvent(event);
End;
function CTaskExequtor.getTask:IRunnable;
Begin
  csBusy.Enter();
  Result := FTask;
  csBusy.Leave();
End;

procedure CTaskExequtor.setTask(const value: IRunnable);
Begin
  csBusy.Enter();
  FTask := value;
  csBusy.Leave();
End;
end.
