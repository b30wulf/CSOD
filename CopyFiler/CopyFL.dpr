program CopyFL;

uses
  Forms,
  Windows,
  Sysutils,
  CopyF in 'CopyF.pas' {TKnsMonitor};

{$R *.RES}
var
    wnd         : HWND;
    LE          : DWORD;      //Загрузка только одного приложение knslmodule
    m_nOOOA     : integer;
begin
  m_nOOOA := 1;
  CreateMutex(nil, false, PChar('{92CEEB41-1CCD-477B-8A34-AA0158992A59}'));
  if (m_nOOOA >= 1) then
  begin
    LE := GetLastError();
    if (LE = ERROR_ALREADY_EXISTS) or (LE = ERROR_ACCESS_DENIED) then
    begin
      wnd := FindWindow(LPCTSTR('TTKnsMonitor'), nil);
      if wnd <> 0 then
        SendMessage(wnd,WM_GOTOFOREGROUNDMN, 0, 0);
      Application.Terminate;
      Exit;
    end;
  end;
  Application.Initialize;
  Application.CreateForm(TTKnsMonitor, TKnsMonitor);
  Application.Run;
end.
