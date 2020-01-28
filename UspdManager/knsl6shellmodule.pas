unit knsl6shellmodule;

interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,knsl5tracer;
type
    CShellAutomat = class
    protected
     m_sbyID        : Byte;
     m_nRepTimer    : CTimer;
     m_nProgHandle  : THandles;
    private
     procedure LoadProc(var pMsg:CMessage);
     procedure TermProc(var pMsg:CMessage);
     procedure ResmProc(var pMsg:CMessage);
     procedure SuspProc(var pMsg:CMessage);
     procedure UpakpProc(var pMsg:CMessage);
     procedure UpakbProc(var pMsg:CMessage);
     procedure UpaksProc(var pMsg:CMessage);
     function  StartProcess(strPath:String;blWait,blClose:Boolean):THandles;
    public
     procedure Init(var pTable:SL1TAG);
     function EventHandler(var pMsg:CMessage):Boolean;
     function SelfBaseHandler(var pMsg:CMessage):Boolean;
     function LoBaseHandler(var pMsg:CMessage):Boolean;
     function HiBaseHandler(var pMsg:CMessage):Boolean;
     procedure Run;
     //procedure RunAuto;virtual; abstract;
    End;
    PCShellAutomat =^ CShellAutomat;
implementation
procedure CShellAutomat.Init(var pTable:SL1TAG);
Begin

End;
function CShellAutomat.EventHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    case pMsg.m_sbyFor of
     DIR_L1TOL6,DIR_ULTOL6  : res := LoBaseHandler(pMsg);
     DIR_L6TOL6             : res := SelfBaseHandler(pMsg);
     //DIR_L4TOAR, DIR_LMETOL4: res := HiBaseHandler(pMsg);
    End;
    Result := res;;
End;
function CShellAutomat.SelfBaseHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;

    Result := res;
End;
{
  SC_LOAD_USPD_REQ    = 30+0;
  SC_TERM_USPD_REQ    = 30+1;
  SC_RESM_USPD_REQ    = 30+2;
  SC_SUSP_USPD_REQ    = 30+3;
  SC_UPAK_USPD_REQ    = 30+4;
  SC_UPAK_BASE_REQ    = 30+5;
  SC_UPAK_SETT_REQ    = 30+6;
}
function CShellAutomat.LoBaseHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    case pMsg.m_sbyType of
      SC_LOAD_USPD_REQ : LoadProc(pMsg);
      SC_TERM_USPD_REQ : TermProc(pMsg);
      SC_RESM_USPD_REQ : ResmProc(pMsg);
      SC_SUSP_USPD_REQ : SuspProc(pMsg);
      SC_UPAK_USPD_REQ : UpakpProc(pMsg);
      SC_UPAK_BASE_REQ : UpakbProc(pMsg);
      SC_UPAK_SETT_REQ : UpaksProc(pMsg);
    End;
    Result := res;
End;
function CShellAutomat.HiBaseHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;

    Result := res;
End;
procedure CShellAutomat.LoadProc(var pMsg:CMessage);
Begin
    TraceM(6,0,'(__)CSHEL::>LoadProc: ',@pMsg);
    StartProcess(m_strPrepare,True,True);
    m_nProgHandle := StartProcess(m_strProgrammPlacement+m_strProgName+'.exe',False,False);
End;
procedure CShellAutomat.TermProc(var pMsg:CMessage);
Begin
    TraceM(6,0,'(__)CSHEL::>TermProc: ',@pMsg);
    try
     if m_nProgHandle.m_sProcHandle<>0 then
     Begin
      TerminateProcess(m_nProgHandle.m_sProcHandle,1);
      CloseHandle(m_nProgHandle.m_sProcHandle);
      CloseHandle(m_nProgHandle.m_sTHreadHandle);
     End;
    except
     TraceL(6,0,'(__)CERROR::>Error In CShellAutomat.TermProc!!!');
    end
End;
procedure CShellAutomat.ResmProc(var pMsg:CMessage);
Begin
    TraceM(6,0,'(__)CSHEL::>TermProc: ',@pMsg);
    try
     if m_nProgHandle.m_sTHreadHandle<>0 then
     Begin
      ResumeThread(m_nProgHandle.m_sTHreadHandle);
     End;
    except
     TraceL(6,0,'(__)CERROR::>Error In CShellAutomat.ResmProc!!!');
    end
End;
procedure CShellAutomat.SuspProc(var pMsg:CMessage);
Begin
    TraceM(6,0,'(__)CSHEL::>SuspProc: ',@pMsg);
    try
     if m_nProgHandle.m_sTHreadHandle<>0 then
     Begin
      SuspendThread(m_nProgHandle.m_sTHreadHandle);
     End;
    except
     TraceL(6,0,'(__)CERROR::>Error In CShellAutomat.SuspProc!!!');
    end
End;
{
function TDBuffer.PackData:Boolean;
Var
  strPackPath:String;
begin
  m_strArcPathFile    := m_strArcPathFolder+'\\'+m_strName+'_'+IntToStr(m_dwArcFileID)+'.rar';
  strPackPath := '"'+m_strCurrentDir+'\\rar.exe" a -ep1 '+'"'+m_strArcPathFile+'" "'+m_strSavePathFile+'"';
  //SendDebug(strPackPath);
  Inc(m_dwArcFileID);
  //rar.exe e -ep1 knsmodule.rar knsmodule.exe
  result := StartProcess(strPackPath,TRUE);
end;

}
procedure CShellAutomat.UpakpProc(var pMsg:CMessage);
Var
    m_strPackPath    : String;
    m_strArcPathFile : String;
    m_strSavePathFile: String;
Begin
    TraceM(6,0,'(__)CSHEL::>UpakpProc: ',@pMsg);
    m_strArcPathFile  := m_strProgrammPlacement+'Input\'+m_strProgName+'.rar';
    m_strSavePathFile := m_strProgrammPlacement+'Input\';
    m_strPackPath := '"'+m_strExeDir+'\rar.exe" e -o+ '+'"'+m_strArcPathFile+'" "'+m_strSavePathFile+'"';
    StartProcess(m_strPackPath,True,True);
    {
    m_strSavePathFile := m_strProgrammPlacement;
    m_strPackPath := '"'+m_strExeDir+'\rar.exe" e -o+ '+'"'+m_strArcPathFile+'" "'+m_strSavePathFile+'"';
    StartProcess(m_strPackPath,True,True);
    }
End;
procedure CShellAutomat.UpakbProc(var pMsg:CMessage);
Var
    m_strPackPath    : String;
    m_strArcPathFile : String;
    m_strSavePathFile: String;
Begin
    TraceM(6,0,'(__)CSHEL::>UpakbProc: ',@pMsg);
    m_strArcPathFile  := m_strProgrammPlacement+'Input\'+m_strBaseName+'.rar';
    m_strSavePathFile := m_strProgrammPlacement;
    m_strPackPath := '"'+m_strExeDir+'\rar.exe" e -o+ '+'"'+m_strArcPathFile+'" "'+m_strSavePathFile+'"';
    StartProcess(m_strPackPath,True,True);
End;
procedure CShellAutomat.UpaksProc(var pMsg:CMessage);
Var
    m_strPackPath    : String;
    m_strArcPathFile : String;
    m_strSavePathFile: String;
Begin
    TraceM(6,0,'(__)CSHEL::>UpaksProc: ',@pMsg);
    m_strArcPathFile  := m_strProgrammPlacement+'Input\'+m_strSettName+'.rar';
    m_strSavePathFile := m_strProgrammPlacement+'Settings\';
    m_strPackPath := '"'+m_strExeDir+'\rar.exe" e -o+ '+'"'+m_strArcPathFile+'" "'+m_strSavePathFile+'"';
    StartProcess(m_strPackPath,True,True);
End;
function CShellAutomat.StartProcess(strPath:String;blWait,blClose:Boolean):THandles;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
     pp : THandles;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     FillChar(pp,sizeof(pp),0);
     si.cb := sizeof(si);
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, NORMAL_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      TraceL(4,0,':Process is not created');
      result := pp;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,60*1000);
      if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     if blClose=True then
     Begin
      CloseHandle( pi.hProcess );
      CloseHandle( pi.hThread );
     End;
     pp.m_sProcHandle   := pi.hProcess;
     pp.m_sTHreadHandle := pi.hThread;
     result := pp;
end;
procedure CShellAutomat.Run;
Begin
    if m_nRepTimer <> nil then
      m_nRepTimer.RunTimer;
End;
end.
