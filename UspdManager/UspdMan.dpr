program UspdMan;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  classes,
  Windows,
  inifiles,
  utlbox in 'utlbox.pas',
  utlconst in 'utlconst.pas',
  utltypes in 'utltypes.pas',
  utlmtimer in 'utlmtimer.pas',
  knsl5tracer in 'knsl5tracer.pas',
  knsl1module in 'knsl1module.pas',
  knsl1cport in 'knsl1cport.pas',
  knsl1comport in 'knsl1comport.pas',
  knsl1tcp in 'knsl1tcp.pas',
  knsl6module in 'knsl6module.pas',
  knsl6shellmodule in 'knsl6shellmodule.pas',
  knsl2timers in 'knsl2timers.pas';

Var
  strCommand             : String;
  m_nTmModule            : CTimerThread;
  m_nL1Module            : CL1Module;
  m_nL6Module            : CL6Module;
{
  SC_LOAD_USPD_REQ    = 30+0;
  SC_TERM_USPD_REQ    = 30+1;
  SC_RESM_USPD_REQ    = 30+2;
  SC_SUSP_USPD_REQ    = 30+3;
  SC_UPAK_USPD_REQ    = 30+4;
  SC_UPAK_BASE_REQ    = 30+5;
  SC_UPAK_SETT_REQ    = 30+6;

}
function HandCommand(strCommand:String):Boolean;
Begin
    if strCommand='load'   then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_LOAD_USPD_REQ) else
    if strCommand='term'   then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_TERM_USPD_REQ) else
    if strCommand='resm'   then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_RESM_USPD_REQ) else
    if strCommand='susp'   then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_SUSP_USPD_REQ) else
    if strCommand='upak_p' then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_UPAK_USPD_REQ) else
    if strCommand='upak_b' then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_UPAK_BASE_REQ) else
    if strCommand='upak_s' then SendMSG(BOX_L4,0,DIR_ULTOL6,SC_UPAK_SETT_REQ) else
    if strCommand='help'   then
    Begin
     TraceL(0,0,'(__)CHELP::> load   : Load Uspd Programm...');
     TraceL(0,0,'(__)CHELP::> term   : Terminate Uspd Programm...');
     TraceL(0,0,'(__)CHELP::> resm   : Ressume Uspd Programm...');
     TraceL(0,0,'(__)CHELP::> susp   : Suspend Uspd Programm...');
     TraceL(0,0,'(__)CHELP::> upak_p : Unpack Uspd Programm...');
     TraceL(0,0,'(__)CHELP::> upak_b : Unpack Uspd DataBase...');
     TraceL(0,0,'(__)CHELP::> upak_s : Unpack Uspd Settings...');
    End;
    Result := True;
End;
function Init(strFileName:String):Boolean;
var
    Fl   : TINIFile;
Begin
    Fl := TINIFile.Create(strFileName);
     m_strPrepare           := Fl.ReadString('DBCONFIG', 'm_strPrepare', '');
     m_strProgrammPlacement := Fl.ReadString('DBCONFIG', 'm_strProgrammPlacement', '');
     m_strProgName := Fl.ReadString('DBCONFIG', 'm_strProgName', '');
     m_strBaseName := Fl.ReadString('DBCONFIG', 'm_strBaseName', '');
     m_strSettName := Fl.ReadString('DBCONFIG', 'm_strSettName', '');
     //m_nOnAutorization      := Fl.ReadInteger('DBCONFIG','m_nOnAutorization', 0);
    Fl.Destroy;
    Result := FileExists(m_strProgrammPlacement);
End;
begin
  FINIT;
  TraceInit;
  TraceL(0,0,'(__)CMAIN::>Uspd Manager.');
  m_blProtoState := True;
  TraceL(0,0,'(__)CMAIN::>Init Text...');
  m_strExeDir      := GetCurrentDir;
  m_strCurrentDir  := GetCurrentDir + '\\Settings\\';
   m_nTypeProt     := TStringList.Create;
   m_nSpeedList    := TStringList.Create;
   m_nPortTypeList := TStringList.Create;
   m_nParityList   := TStringList.Create;
   m_nDataList     := TStringList.Create;
   m_nStopList     := TStringList.Create;

   m_nTypeProt.LoadFromFile(m_strCurrentDir+'TypeProt.dat');
   m_nSpeedList.loadfromfile(m_strCurrentDir+'potrspeed.dat');
   m_nPortTypeList.loadfromfile(m_strCurrentDir+'PortType.dat');
   m_nParityList.loadfromfile(m_strCurrentDir+'portparity.dat');
   m_nDataList.loadfromfile(m_strCurrentDir+'portdbit.dat');
   m_nStopList.loadfromfile(m_strCurrentDir+'portsbit.dat');
   Init(GetCurrentDir + '\\Settings\\USPD_Config.ini');
  TraceL(0,0,'(__)CMAIN::>Init Timers ...');
   m_nTmModule := CTimerThread.Create(True);
   m_nTmModule.Priority := tpNormal;
   m_nTmModule.Resume;
  TraceL(0,0,'(__)CMAIN::>Init Layer L1...');
   m_nL1Module := CL1Module.Create(True);
   m_nL1Module.Init;
  TraceL(0,0,'(__)CMAIN::>Init Layer L6...');
   m_nL6Module := CL6Module.Create(True);
   m_nL6Module.Init;
  TraceL(0,0,'(__)CMAIN::>Start Command Shell...');
  while(strCommand<>'stop') do
  Begin
   write('UCommand ::>');
   Readln(strCommand);

   HandCommand(strCommand);
   Sleep(1000);
  End;

end.




