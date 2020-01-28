unit knsl2IRunnable;
interface
uses
Windows, Classes, SysUtils,SyncObjs;
type
    IRunnable = class
     protected
      id : Integer;
      state : Integer;
      stateHouseTask:integer;
      parent : IRunnable;
     public
      destructor Destroy;override;
      procedure setTaskState(vState:Integer);
      procedure setTaskStateHouse(vState:Integer);
      function getTaskState:Integer;
      function getTaskStateHouse:Integer;
      function getParent:IRunnable;
      procedure setParent(vparent:IRunnable);
      function getId:Integer;
      function run:Integer;virtual;abstract;
      //function runAsync:Integer;virtual;abstract;
      //function putAsync:Integer;virtual;abstract;
      //function findAsync:Integer;virtual;abstract;
    End;
    PIRunnable = ^IRunnable;


implementation
destructor IRunnable.Destroy;
Begin
    inherited Destroy;
End;
function IRunnable.getTaskState:Integer;
Begin
    Result := state;
End;

function IRunnable.getTaskStateHouse:Integer;
Begin
    Result := stateHouseTask;
End;

function IRunnable.getParent:IRunnable;
Begin
    Result := parent;
End;

procedure IRunnable.setParent(vparent:IRunnable);
Begin
    parent := vparent;
End;

procedure IRunnable.setTaskState(vState:Integer);
Begin
    state := vState;
End;

procedure IRunnable.setTaskStateHouse(vState:Integer);
Begin
    stateHouseTask := vState;
End;

function IRunnable.getId():Integer;
Begin
    Result := id;
End;
end.
