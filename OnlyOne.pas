unit OnlyOne;

interface

uses Windows, SysUtils;

function IsOneInstance() :Boolean;

implementation

var
  hOnlyOneMutex :Cardinal = 0;
  sOnlyOneMutex :String;

function IsOneInstance() :Boolean;
begin
  Result := WaitForSingleObject(hOnlyOneMutex, 100) = WAIT_OBJECT_0;
end;

initialization
  SetLength(sOnlyOneMutex, MAX_PATH);
  GetShortPathNameA(PChar(ParamStr(0)), PChar(sOnlyOneMutex), MAX_PATH);
  sOnlyOneMutex := StringReplace(PChar(sOnlyOneMutex), ':\', '-', [rfReplaceAll]);
  sOnlyOneMutex := 'RunOpros-' + StringReplace(sOnlyOneMutex, '\', '-', [rfReplaceAll]);
  hOnlyOneMutex := CreateMutex(nil, True, PChar(sOnlyOneMutex));

finalization
  ReleaseMutex(hOnlyOneMutex);
  SetLength(sOnlyOneMutex, 0);

end.
