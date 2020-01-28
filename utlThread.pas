unit utlThread;

interface

uses
  Windows, Classes;

type
  CThread = class(TThread)
  public
    destructor Destroy; override;
  end;

implementation

{ TreahTest }

destructor CThread.Destroy;
begin
  if Suspended then begin
    TerminateThread(Self.Handle, 0);
  end;
  inherited;
end;

end.
