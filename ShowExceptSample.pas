unit ShowExceptSample;
 
interface
 
uses
  SysUtils,
  Classes,
  Windows;
 
implementation
 
type
  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = packed record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;
 
var
  // ��������� �� ������� ������ ����������
  CurrentRaiseList: Pointer = nil;
 
// ������� ���������� ������� ���������� �� �����
function GetNextException: Pointer;
begin
  if CurrentRaiseList = nil then CurrentRaiseList := RaiseList;
  if CurrentRaiseList <> nil then
  begin
    Result := PRaiseFrame(CurrentRaiseList)^.ExceptObject;
    PRaiseFrame(CurrentRaiseList)^.ExceptObject := nil;
    CurrentRaiseList := PRaiseFrame(CurrentRaiseList)^.NextRaise;
  end
  else
    Result := nil;
end;
 
var
  ExceptionStack: TList;
  E: Exception;  
 
initialization
 
finalization
 
  // �������, ���� �� ������ ����������?
  E := GetNextException;
 
  if E <> nil then
  begin
    ExceptionStack := TList.Create;
    try
 
      // ���� ����, �������� � ��� ����������
      while E <> nil do
      begin
        ExceptionStack.Add(E);
        E := GetNextException;
      end;
 
      // � ���������� �� � ��� �������, � ������� ��� ���������
      while ExceptionStack.Count > 0 do
      begin
        E := ExceptionStack[ExceptionStack.Count - 1];
        ExceptionStack.Delete(ExceptionStack.Count - 1);
        ShowException(E, ExceptAddr);
        E.Free;
      end;
    finally
      ExceptionStack.Free;
    end;
 
    // ������������ ��� ��� ��������
    Halt(1);
  end;
end.