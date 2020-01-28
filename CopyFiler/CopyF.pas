unit CopyF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,extctrls,
  StdCtrls,inifiles;

const
  WM_MOUSE_CLICK_KNS = WM_USER + 1;
  WM_GOTOFOREGROUND  = WM_USER + 2;
  WM_SENDTOMONITOR   = WM_USER + 3;
  WM_GOTOFOREGROUNDMN= WM_USER + 4;
  WM_SENDTOMONITORSTOP= WM_USER + 5;
  WM_SENDTOMNUPDATE    = WM_USER + 6;
  WM_SENDTOMNRELOAD    = WM_USER + 7;
  WM_SENDTOKNSTOP      = WM_USER + 8;
  WM_SENDTOMONITORACTIVE = WM_USER + 9;
type
   THandles = packed record
     m_sProcHandle   : THandle;
     m_sTHreadHandle : THandle;
    End;

  TTKnsMonitor = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    edWMKonus: TEdit;
    edWMReload: TEdit;
    edWMElapsed: TEdit;
    btnReStart: TButton;
    edUpdateState: TEdit;
    lbElTime: TEdit;
    btStop: TButton;
    RestartProg: TEdit;
    writelog: TCheckBox;
    StartOpros: TCheckBox;
    User: TCheckBox;
    UserName: TEdit;
    Passw: TEdit;
    Pass: TLabel;
    procedure OnCreate(Sender: TObject);
    procedure OnStart(Sender: TObject);
    procedure OnCloseProc(Sender: TObject);
    procedure btnReStartClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
  private
    { Private declarations }
    FTimer : TTimer;
    FSysTimer : TTimer;
    m_nProgHandle  : THandles;
    dwCount   : Integer;//DWord;
    dwCountKN : DWord;
    dwCountReload  : DWord;
    m_nMNScanTime    : Integer;
    m_nMNQweryUpdate : Integer;
    m_nMNWaitTime    : Integer;
    m_nMNStartPath   : String;
    m_nMNSrvStopAndStart : Integer;
    m_nMNISUpdate    : Integer;
    m_nWDTTime       : Integer;
    m_nMNUpdateSrcPath : String;
    m_blState : Byte;
    m_edWMElapsedColor : TColor;
    m_edWMElStateColor : TColor;
    m_edWMUpdateColor  : TColor;
    m_blQweryUpdate    : Boolean;
    ResError           : Boolean;
    procedure DoHalfTime(Sender:TObject);dynamic;
    procedure DoHalfSysTime(Sender:TObject);dynamic;
    procedure LoadProc;
    procedure TermProc;
    procedure WMFromChildProc(var Msg:TMessage);message WM_SENDTOMONITOR;
    function  StartProcess(strPath:String;blWait,blClose:Boolean):THandles;
    procedure WMGotoForeground(var Msg:TMessage);message WM_GOTOFOREGROUNDMN;
    procedure WMSelfStop(var Msg:TMessage);message WM_SENDTOMONITORSTOP;
    procedure WMSelfActive(var Msg:TMessage);message WM_SENDTOMONITORACTIVE;

    procedure WMSelfReload(var Msg:TMessage);message WM_SENDTOMNRELOAD;
    procedure PulceTmElapsed;
    procedure PulceUpdate;
    procedure FindUpdate;

  public
    { Public declarations }

  end;

var
  TKnsMonitor: TTKnsMonitor;

implementation

{$R *.DFM}

procedure TTKnsMonitor.OnCreate(Sender: TObject);
Var
    Fl : TINIFile;
begin
   {$I-}
    m_nProgHandle.m_sProcHandle := 0;
    m_blState          := 1;
    m_edWMElapsedColor := clLime;
    m_edWMElStateColor := clWindow;
    m_edWMUpdateColor  := clWindow;
    m_blQweryUpdate    := False;

      Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'Settings\USPD_Config.ini');
       m_nMNScanTime        := Fl.ReadInteger('DBCONFIG','m_nMNScanTime',900);
       m_nMNQweryUpdate     := Fl.ReadInteger('DBCONFIG','m_nMNQweryUpdate',0);
       m_nMNWaitTime        := Fl.ReadInteger('DBCONFIG','m_nMNWaitTime',30);
       m_nMNStartPath       := Fl.ReadString('DBCONFIG','m_nMNStartPath','c:\a2000\ascue\knsmodule.exe');
       m_nMNSrvStopAndStart := Fl.ReadInteger('DBCONFIG','m_nMNSrvStopAndStart',0);
       m_nMNISUpdate        := Fl.ReadInteger('DBCONFIG','m_nMNISUpdate',0);
       m_nMNUpdateSrcPath   := Fl.ReadString('DBCONFIG','m_nMNUpdateSrcPath','c:\a2000\ascue\Update\Update.exe');
       m_nWDTTime           := Fl.ReadInteger('DBCONFIG','m_nWDTTime', -1);
      Fl.Destroy;
    FindUpdate;

    RestartProg.Text:='Программа не была запущена!';
    lbElTime.Text := IntToStr(m_nMNScanTime)+'сек.';

    FTimer         := TTimer.Create(Nil);
    FTimer.Enabled := True;
    FTimer.Interval:= 10000;
    FTimer.OnTimer := DoHalfTime;

    FSysTimer         := TTimer.Create(Nil);
    FSysTimer.Enabled := True;
    FSysTimer.Interval:= 1000;
    FSysTimer.OnTimer := DoHalfSysTime;

    dwCount   := m_nMNScanTime-m_nMNWaitTime;
    dwCountKN := 0;
    dwCountReload := 0;
end;

procedure TTKnsMonitor.DoHalfTime(Sender:TObject);
Begin
    //Minimize;
    FTimer.Enabled := False;
    //WindowState := wsMinimize;
    ShowWindow(Application.Handle,SW_MINIMIZE);
End;
procedure TTKnsMonitor.DoHalfSysTime(Sender:TObject);
Begin
    if (dwCount>m_nMNScanTime) then
    Begin
     RestartProg.Text:='Программа была перезапущена!';
     ResError:=True; //параметр для перезапуска с поиском для дозапроса остановленных групп
     TermProc;
     Sleep(1000);
     LoadProc;
     m_edWMElapsedColor := clLime;
     dwCountKN := 0;
     edWMKonus.Text := IntToStr(dwCountKN);
     dwCount := 0;
     dwCountReload:=0;
     dwCountReload := dwCountReload + 1;
     edWMReload.Text := IntToStr(dwCountReload);
    End;
    edWMElapsed.Text := IntToStr(dwCount);
    if m_blState=1 then dwCount := dwCount + 1;
    PulceTmElapsed;
    PulceUpdate;
End;

procedure TTKnsMonitor.PulceTmElapsed;
Begin
    if edWMElapsed.Tag=0 then
    Begin
     edWMElapsed.Color := m_edWMElStateColor;
     edWMElapsed.Tag   := 1;
    end
    else
    if edWMElapsed.Tag=1 then
    Begin
     edWMElapsed.Color := m_edWMElapsedColor;
     edWMElapsed.Tag   := 0;
    End;
    if dwCount>25 then m_edWMElStateColor := clRed else m_edWMElStateColor := clWindow;
End;
procedure TTKnsMonitor.PulceUpdate;
Begin
    if m_blQweryUpdate=True then
    Begin
     if edUpdateState.Tag=0 then
     Begin
      edUpdateState.Color := m_edWMUpdateColor;
      edUpdateState.Tag   := 1;
     end
     else
     if edUpdateState.Tag=1 then
     Begin
      edUpdateState.Color := clWindow;
      edUpdateState.Tag   := 0;
     End;
    End;
End;
procedure TTKnsMonitor.LoadProc;
Begin
  m_nProgHandle := StartProcess(m_nMNStartPath,False,False);
End;

procedure TTKnsMonitor.TermProc;
Begin
    try
     if m_nProgHandle.m_sProcHandle<>0 then
     Begin
      TerminateProcess(m_nProgHandle.m_sProcHandle,1);
      CloseHandle(m_nProgHandle.m_sProcHandle);
      CloseHandle(m_nProgHandle.m_sTHreadHandle);
      m_nProgHandle.m_sProcHandle := 0;
      m_nProgHandle.m_sTHreadHandle := 0;
     End;
    except
       ShowMessage('Ошибка в TermProc!')
    end
End;

function TTKnsMonitor.StartProcess(strPath:String;blWait,blClose:Boolean):THandles;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
//     dwRes: LongWord;
     pp : THandles;
     param: String;
begin

    //appCmd := Format('cmd.exe %s', [AParams]);

     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     FillChar(pp,sizeof(pp),0);
     si.cb := sizeof(si);
     if writelog.Checked=true then
     param:='-writelog ';
     if StartOpros.Checked=true then
     param:=param+'-startopros ';
     if ResError=True then
     param:=param+'-reserror ';
     if User.Checked=True then
     begin
      param:=param + '-username '+UserName.Text+' -pass '+ passw.Text;
     end;

     strPath:=Format(strPath + ' %s', [param]);


     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, HIGH_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      result := pp;
     end;
//     if(blWait) then
//     begin
//      dwRes := WaitForSingleObject(pi.hProcess,60*1000);
//     end;
     if blClose=True then
     Begin
      CloseHandle( pi.hProcess );
      CloseHandle( pi.hThread );
     End;
     pp.m_sProcHandle   := pi.hProcess;
     pp.m_sTHreadHandle := pi.hThread;
     result := pp;
end;
procedure TTKnsMonitor.WMFromChildProc(var Msg:TMessage);
begin
   dwCount        := 0;
   edWMKonus.Text := IntToStr(dwCountKN);
   dwCountKN      := dwCountKN + 1;
   inherited;
end;
procedure TTKnsMonitor.WMGotoForeground(var Msg:TMessage);
begin
   ShowWindow(Handle,SW_SHOW);             // Восстанавливаем окно программы
   inherited;
end;
procedure TTKnsMonitor.WMSelfStop(var Msg:TMessage);
begin
   dwCount := 0;
   TermProc;
   inherited;
end;

procedure TTKnsMonitor.WMSelfActive(var Msg:TMessage);
begin
   dwCount := 0;
   edWMElapsed.Color:=clLime;   // m_edWMElStateColor;
   if dwCountReload=4294967295 then  //проверка на макс
   dwCountReload:=0;
   dwCountReload := dwCountReload + 1;
   edWMReload.Text := IntToStr(dwCountReload);
   inherited;
end;

procedure TTKnsMonitor.WMSelfReload(var Msg:TMessage);
Var
   Fl : TINIFile;
begin
   Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'Settings\USPD_Config.ini');
       m_nMNScanTime        := Fl.ReadInteger('DBCONFIG','m_nMNScanTime',900);
       m_nMNQweryUpdate     := Fl.ReadInteger('DBCONFIG','m_nMNQweryUpdate',0);
       m_nMNWaitTime        := Fl.ReadInteger('DBCONFIG','m_nMNWaitTime',30);
       m_nMNStartPath       := Fl.ReadString('DBCONFIG','m_nMNStartPath','c:\a2000\ascue\knsmodule.exe');
       m_nMNSrvStopAndStart := Fl.ReadInteger('DBCONFIG','m_nMNSrvStopAndStart',0);
       m_nMNISUpdate        := Fl.ReadInteger('DBCONFIG','m_nMNISUpdate',0);
       m_nMNUpdateSrcPath   := Fl.ReadString('DBCONFIG','m_nMNUpdateSrcPath','c:\a2000\ascue\Update\Update.exe');
   Fl.Destroy;
   dwCount := 0;
   TermProc;
   Sleep(1000);
   LoadProc;
   m_edWMElapsedColor := clLime;
   dwCount := 0;
   dwCountReload := dwCountReload + 1;
   edWMReload.Text := IntToStr(dwCountReload);
   inherited;
end;
procedure TTKnsMonitor.OnStart(Sender: TObject);
begin
     btnReStartClick(Sender);
     RestartProg.Text:='Программа была запущена!';     
end;

procedure TTKnsMonitor.OnCloseProc(Sender: TObject);
Begin
     m_blState := 1;
     TermProc;
     m_edWMElapsedColor := clYellow;
     ResError:=False;
end;

procedure TTKnsMonitor.btnReStartClick(Sender: TObject);
begin
    dwCountKN := 0;
    edWMKonus.Text := IntToStr(dwCountKN);
    m_blState := 1;
    TermProc;
    Sleep(1000);
    LoadProc;
    dwCount := 0;
    dwCountReload := dwCountReload + 1;
    edWMReload.Text := IntToStr(dwCountReload);
    m_edWMElapsedColor := clLime;
end;
procedure TTKnsMonitor.FindUpdate;
Var
    Fl : TINIFile;
Begin
    if (FileExists(m_nMNUpdateSrcPath)=True) then
    Begin
     m_blQweryUpdate    := True;
     m_edWMUpdateColor  := clRed;
     edUpdateState.Color:= m_edWMUpdateColor;
     edUpdateState.Text := 'Qwery Update!!!';
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'Settings\USPD_Config.ini');
     Fl.WriteInteger('DBCONFIG','m_nMNQweryUpdate',1);
     Fl.Destroy;
    End else
    Begin
     edUpdateState.Color:= clLime;
     edUpdateState.Text := 'Update Ok!';
    End;
End;

procedure TTKnsMonitor.btStopClick(Sender: TObject);
Var
    wnd    : HWND;
begin
    wnd := FindWindow(LPCTSTR('TTKnsForm'), nil);
    if wnd <> 0 then SendMessage(wnd,WM_SENDTOKNSTOP, 0, 0);
    ResError:=False;    
end;

end.
