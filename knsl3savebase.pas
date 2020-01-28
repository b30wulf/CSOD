unit knsl3savebase;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,knsl3EventBox,utlTimeDate,knsl5config,inifiles;
type
     CSaveBase = class
     private
      m_nPackTimer : CTimer;
      m_nSaveTimer : CTimer;
      m_blQrySave  : Boolean;
      FStatrPath   : String;
      procedure StartPackProc;
      function StartProcess(strPath:String;blWait:Boolean):Boolean;
      function PackData:Boolean;
      function  CheckSpaceDB(nSize:Integer):Boolean;
     public
      constructor Create;
      destructor Destroy;override;
      procedure QwerySave;
      procedure QwerySave1;
      procedure Run;
      function EventHandler(var pMsg:CMessage):Boolean;
     public
      property PStartPath : String read FStatrPath write FStatrPath;
     End;
     PCSaveBase = ^CSaveBase;
implementation
//CSaveBase
constructor CSaveBase.Create;
Begin
     m_blQrySave  := False;
     m_nPackTimer := CTimer.Create;
     m_nPackTimer.SetTimer(DIR_SSTOSB,SVS_PAC_TMR,0,0,BOX_SSRV);
     m_nSaveTimer := CTimer.Create;
     m_nSaveTimer.SetTimer(DIR_SSTOSB,SVS_SAVE_TMR,0,0,BOX_SSRV);
     m_nSaveTimer.OnTimer(m_nCF.GenStorePeriod);
End;
destructor CSaveBase.Destroy;
Begin
End;
function CSaveBase.EventHandler(var pMsg:CMessage):Boolean;
Begin
     case pMsg.m_sbyType of
          SVS_SAVE_TMR : Begin
                          m_blQrySave := True;
                          m_nSaveTimer.OnTimer(m_nCF.GenStorePeriod);
                         End;
          SVS_PAC_TMR  : PackData;
          SVS_CHSZ_TMR : QwerySave;
     End;
End;
procedure CSaveBase.QwerySave;
Begin
     CheckSpaceDB(m_nMaxSpaceDB);
     if m_blQrySave=True then
     Begin
      StartPackProc;
      m_blQrySave := False;
     End;
End;
procedure CSaveBase.QwerySave1;
Begin
     CheckSpaceDB(m_nMaxSpaceDB);
     if m_blQrySave=True then
     Begin
      m_pDB.DelSlices(m_nCF.GenClearPeriod);
      m_pDB.FullDisconnect;
      PackData;
      m_blQrySave := False;
     End;
End;
function  CSaveBase.CheckSpaceDB(nSize:Integer):Boolean;
Var
     szSize : Integer;
Begin
     if m_nMaxSpaceDB=-1 then exit;
     szSize := m_pDB.GetSizeDB;
     if szSize>=nSize*(1024*1024) then
     Begin
      m_pDB.FreeBase(m_nCF.CorrectClearPeriod);
      m_blQrySave:=True;
     End;
end;
procedure CSaveBase.StartPackProc;
Begin
     m_pDB.DelSlices(m_nCF.GenClearPeriod);
     m_nPackTimer.OnTimer(4);
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_PACKSTART_REQ));
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_FULLDISC_REQ));
     m_pDB.FullDisconnect;
End;
function CSaveBase.PackData:Boolean;
Var
     strPackGFPath   : String;
     strPackPath   : String;
     strExtrSvPath : String;
     strExtrPath   : String;
     res : Boolean;
     pMsg : CMessage;
     Fl : TINIFile;
begin
     res := False;
     saveSetBaseProp;
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
     if DBAddFieldEn=1 then
     Begin
      Fl  := TINIFile.Create(FStatrPath+'\\Settings\\USPD_Config.ini');
      Fl.WriteInteger('DBCONFIG','DBAddFieldEn', 0);
      Fl.Destroy;
     End;
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Внимание! Сжатие базы. Дождитесь выполнения операции.');
     if m_nCF.IsRamDrive=False then
        strPackPath   := 'gbak -b -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+
        FStatrPath+'SYSINFOAUTO.FDB ' +FStatrPath+'SYSINFOAUTO.FBK' else
     if m_nCF.IsRamDrive=True then
        strPackPath   := 'gbak -b -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' r:\ascue\SYSINFOAUTO.FDB '+FStatrPath+'SYSINFOAUTO.FBK';
     //Extract
     if m_nCF.IsRamDrive=False then
        strExtrPath   := 'gbak -rep -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+
        FStatrPath+'SYSINFOAUTO.FBK '+ FStatrPath+'SYSINFOAUTO.FDB' else
     if m_nCF.IsRamDrive=True then
        strExtrPath   := 'gbak -rep -user '+m_pDB.m_strDBUser+' -password '+m_pDB.m_strDBPassw+' '+FStatrPath+'SYSINFOAUTO.FBK '+'r:\ascue\SYSINFOAUTO.FDB';
     //res := StartProcess(strPackGFPath,TRUE);
     res := StartProcess(strPackPath,TRUE);
     res := StartProcess(strExtrPath,TRUE);
     saveRemBaseProp;
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Сжатие базы завершено');
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_CONNECTDB_REQ));
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SAVEDBOK_REQ));

     res :=m_pDB.Connect;

     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
     //SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATESHEM_IND);
     //SendRSMsgM(CreateMSG(BOX_L3,0,DIR_L4TOL3,AL_UPDATESHEM_IND));
     SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
     Result := True;
end;
function CSaveBase.StartProcess(strPath:String;blWait:Boolean):Boolean;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     si.cb := sizeof(si);
     si.wShowWindow:=SW_HIDE;
     si.dwFlags:= STARTF_USESHOWWINDOW;
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, NORMAL_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      //TraceL(4,0,':Process is not created');
      result := FALSE;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,14*60*1000);
      //if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     CloseHandle( pi.hProcess );
     CloseHandle( pi.hThread );
     result := True;
end;
procedure CSaveBase.Run;
Begin
     m_nPackTimer.RunTimer;
     m_nSaveTimer.RunTimer;
End;
end.
