unit uJCL;

interface

uses SysUtils, Classes, JclDebug;

function JclAddStackList(const aErrMsg :String) :String;

implementation

function JclAddStackList(const aErrMsg :String) :String;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    JclLastExceptStackListToStrings(SL, True, True, True, True);
    if aErrMsg <> '' then begin
      SL.Insert(0, aErrMsg);
      SL.Insert(1, '');
    end;
    Result := SL.Text;
  finally
    FreeAndNil(SL);
  end;
end;

initialization
  JclStartExceptionTracking;

finalization
  JclStopExceptionTracking;

end.
