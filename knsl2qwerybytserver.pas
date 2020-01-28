unit knsl2qwerybytserver;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
 knsl3EventBox,knsl2qweryportpull,knsl2qwerybitserver,
 utldatabase,utldynconnect,knsl3datamatrix,knsl3jointable,knsl3HolesFinder,knsl2qwerybytgroup,
 knsl2_HouseTask_Global,knsl2IRunnable,knsl2CThreadPull,
 knsl2Factory, inifiles;
type
    CQweryBytServers = class
    protected
     portPull      : TThreadList;
     threadPullCfg : TThreadList;
     groupList     : TThreadList;
     abonPull      : CThreadPull;
     tpPull        : CThreadPull;
     abonHandPull  : CThreadPull;
     groupPull     : CThreadPull;
     function  Find(groupID:Integer):Integer;
     procedure Delete(groupID:Integer);
     procedure InitGroupParam(groupID,snPrmID:Integer);
     procedure InitGroups(groupID,snPrmID:Integer);
     procedure loadAbonMeter(vDtBegin,vDtEnd:TDateTime;snABOID,snMID,snPrmID:Integer);
     procedure openTransit(vDtBegin,vDtEnd:TDateTime;snABOID,snMID,snPrmID:Integer);
     procedure CommandDataSrv(groupID:Integer;snPrmID:Integer);
     procedure UpdateDataSrv(groupID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     procedure UpdateErrorDataSrv(groupID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);  //перезапуск после ошибки программы
     procedure UnloadDataSrv(groupID:Integer;snPrmID:Integer);
     procedure FindDataSrv(groupID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     procedure StopQwerySrv(groupID:Integer);
    public
     NumberOfConcurrentReqest : Integer;
     constructor Create;
     destructor Destroy;override;
     procedure Init(vPortPull:TThreadList);
     procedure initGroup;
     function  EventHandler(var pMsg:CMessage):Boolean;
     procedure Run;
    End;
implementation

uses knsl5module,forms;
//CQweryServers
{$IFDEF HOMEL}
constructor CQweryBytServers.Create;
Begin
  groupPull := CThreadPull.Create(1,10000,'group Pull');
  abonPull  := CThreadPull.Create(2,10000,'abon Pull');
  tpPull    := CThreadPull.Create(2,10000,'tp Pull');
  abonHandPull := CThreadPull.Create(1,10000,'abon Hand Pull');
End;
  {$ELSE}
constructor CQweryBytServers.Create;
var  iniF : TINIFile;
Begin
  iniF    := TINIFile.Create(ExtractFilePath(Application.ExeName)+'Settings\UnLoad_Config.ini');
  NumberOfConcurrentReqest := iniF.ReadInteger('REQEST', 'NumberOfConcurrentReqest', 10);
  TKnsForm.editNumberOfConcurrentReqest.Value := NumberOfConcurrentReqest;
  groupPull := CThreadPull.Create(1,10000,'group Pull');
  abonPull  := CThreadPull.Create(NumberOfConcurrentReqest,10000,'abon Pull');//10
  tpPull    := CThreadPull.Create(NumberOfConcurrentReqest,10000,'tp Pull');  //10
  abonHandPull := CThreadPull.Create(1,10000,'abon Hand Pull');
  freeAndNil(iniF);
End;
{$ENDIF}
destructor CQweryBytServers.Destroy;
Begin
  // Раньше глючило при закрытии программы ! ! !

  if abonHandPull <> nil then FreeAndNil(abonHandPull);
  if tpPull <> nil then FreeAndNil(tpPull);
  if abonPull <> nil then FreeAndNil(abonPull);
  if groupPull <> nil then FreeAndNil(groupPull);

 // ClearListAndFree(portPull);       //
  ClearListAndFree(groupList);
  ClearListAndFree(threadPullCfg);
  inherited;
End;

var
  hRunOnlyOneMutex :Cardinal = 0;

procedure CreateRunOnlyOneMutex;
var
  sRunOnlyOneMutex :String;
begin
  if hRunOnlyOneMutex <> 0 then Exit;
  SetLength(sRunOnlyOneMutex, MAX_PATH);
  GetShortPathNameA(PChar(ParamStr(0)), PChar(sRunOnlyOneMutex), MAX_PATH);
  sRunOnlyOneMutex := StringReplace(PChar(sRunOnlyOneMutex), ':\', '-', [rfReplaceAll]);
  sRunOnlyOneMutex := 'Global\RunOpros-' + StringReplace(sRunOnlyOneMutex, '\', '-', [rfReplaceAll]);
  hRunOnlyOneMutex := CreateMutex(nil, True, PChar(sRunOnlyOneMutex));
end;

function IsRunOnlyOne() :Boolean;
begin
  Result := WaitForSingleObject(hRunOnlyOneMutex, 100) = WAIT_OBJECT_0;
end;
function CQweryBytServers.EventHandler(var pMsg:CMessage):Boolean;
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
  CreateRunOnlyOneMutex;
  if not IsRunOnlyOne() then begin
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'(Opros Block in arm)');
    Result:=False;
    Exit;
  end;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     Move(pDS.m_sbyInfo[0] ,sQC,sizeof(SQWERYCMDID));
     with sQC do
     case m_snCmdID of
          QS_INIT_SR : InitGroupParam(m_snSRVID,m_snPrmID);
          QS_INIT_GS : InitGroups(m_snSRVID,m_snPrmID);
          QS_HQWR_SR : CommandDataSrv(m_snSRVID,m_snPrmID);
          QS_UPDT_SR : UpdateDataSrv(m_snSRVID,m_sdtBegin,m_sdtEnd,m_snPrmID);
          QS_FIND_SR : FindDataSrv(m_snSRVID,m_sdtBegin,m_sdtEnd,m_snPrmID);
          QS_RESTART_ERROR : UpdateErrorDataSrv(m_snSRVID,m_sdtBegin,m_sdtEnd,m_snPrmID); //перезапуск опроса после ошибки программы
          QS_STOP_SR : StopQwerySrv(m_snSRVID);
          QS_UNLD_SR : UnloadDataSrv(m_snSRVID,m_snPrmID);
          QS_LOAD_ON : loadAbonMeter(m_sdtBegin,m_sdtEnd,m_snABOID,m_snMID,m_snPrmID);
          QS_TRAN_ON : openTransit(m_sdtBegin,m_sdtEnd,m_snABOID,m_snMID,m_snPrmID);
     End;
   Result:=true;  
End;

procedure CQweryBytServers.Init(vPortPull:TThreadList);
Begin
    portPull  := vPortPull;
    initGroup;
End;

procedure CQweryBytServers.initGroup;
Var
    vList : TList;
    i     : Integer;
    pData : CQweryBytGroup;
    qG    : QUERYGROUP;
    pDb   : CDBDynamicConn;
Begin
   try
    ClearListAndFree(groupList);
    groupList := TThreadList.Create;

    ClearListAndFree(threadPullCfg);
    threadPullCfg := TThreadList.Create;
    
//    pDb  := //m_pDB.getConnection;
    pDb  := CDBDynamicConn.Create; //m_pDB.getConnection;
    pDb.Create(pDb.InitStrFileName);

    if pDb.getQueryGroup(threadPullCfg) then
    Begin
     vList  := threadPullCfg.LockList;
     for i:=0 to vList.Count-1 do
     Begin
      pData := CQweryBytGroup.Create;
      qG    := vList[i];
      pData.init(qG,portPull,groupPull,abonPull,tpPull);
      groupList.LockList.Add(pData);
      groupList.UnLockList;
     End;
     threadPullCfg.UnLockList;
    End;
  except
   if pDb<>Nil then
     begin
      pDb.Disconnect; //m_pDB.DiscDynConnect(pDb);
      FreeAndNil(pDb);
     end;
  end;
End;

procedure CQweryBytServers.InitGroupParam(groupID,snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
  try
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.InitGroupParam G['+IntToStr(groupID)+'] P['+IntToStr(snPrmID)+']...');
    if groupID=-1 then
   Begin
     initGroup;
     exit;
   End;
    vList := groupList.LockList;
    index := Find(groupID);
    pData := vList[index];
    pData.InitGroupParam(snPrmID);
  finally
    groupList.UnLockList;
  end;
End;

procedure CQweryBytServers.loadAbonMeter(vDtBegin,vDtEnd:TDateTime;snABOID,snMID,snPrmID:Integer);
Var
    runnable : PIRunnable;
Begin
 try
   if ((snPrmID>=QRY_U_PARAM_A)and(snPrmID<=QRY_U_PARAM_C))or ((snPrmID>=QRY_I_PARAM_A)and (snPrmID<=QRY_I_PARAM_C))then
    begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.loadAbonMeter Load Meter DTFROM['+DateTimeToStr(vDtBegin)+'] DTTO['+DateTimeToStr(vDtEnd)+'] AID['+IntToStr(snABOID)+'] P['+IntToStr(snPrmID)+']...');
     new(runnable);

     runnable^ := CHouseTaskGlobal.Create(vDtBegin,vDtEnd,snPrmID,-1,snABOID,snMID,0,100,100,EncodeTime(0,1,0,0),portpull,0,abonPull,IRunnable(self));

    // groupPull.submitAndFree(runnable);
     abonPull.submit(runnable);

{    //    runnable^ := CHouseTaskGlobal.Create(vDtBegin,vDtEnd,snPrmID,-1,snABOID,snMID,0,100,portpull,0,abonPull,IRunnable(self));
    runnable^ := fabric.getRunnable(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb,data,IRunnable(self)); //IRunnable(self));

    runnable.getParent.setTaskState(TASK_STATE_RUN);
    //abonPull.exequte(runnable);
    abonHandPull.submit(runnable);}
    end;
 //except
 //  if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'( ERORR!!! '+IntToStr(0)+')CQweryBytServers.loadAbonMeter Load Meter DTFROM['+DateTimeToStr(vDtBegin)+'] DTTO['+DateTimeToStr(vDtEnd)+'] AID['+IntToStr(snABOID)+'] P['+IntToStr(snPrmID)+']...');
 except
  if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'( ERORR!!! '+IntToStr(0)+')CQweryBytServers.loadAbonMeter Load Meter DTFROM['+DateTimeToStr(vDtBegin)+'] DTTO['+DateTimeToStr(vDtEnd)+'] AID['+IntToStr(snABOID)+'] P['+IntToStr(snPrmID)+']...');
 end;
End;
procedure CQweryBytServers.openTransit(vDtBegin,vDtEnd:TDateTime;snABOID,snMID,snPrmID:Integer);
//Var
//    runnable : PIRunnable;
Begin
{    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(snMID)+')CQweryBytServers.openTransit Load Meter DTFROM['+DateTimeToStr(vDtBegin)+'] DTTO['+DateTimeToStr(vDtEnd)+'] AID['+IntToStr(snABOID)+'] P['+IntToStr(snPrmID)+']...');
    new(runnable);
    runnable^ := CHouseTask.Create(vDtBegin,vDtEnd,snPrmID,-1,snABOID,snMID,0,100,portpull,0,abonPull,IRunnable(self));
    runnable.getParent.setTaskState(TASK_STATE_RUN);
    abonHandPull.submit(runnable);}
End;

procedure CQweryBytServers.InitGroups(groupID,snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
 try
    vList := groupList.LockList;
    if (groupID=-1) then
    Begin
     for index:=0 to vList.Count-1 do
     Begin
      pData := vList[index];
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.InitGroupParam G['+pData.config.NAME+'] P['+IntToStr(snPrmID)+']...');
      pData.InitGroupParam(snPrmID);
     End;
    End else
    Begin
     index := Find(groupID);
     pData := vList[index];
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.InitGroupParam G['+pData.config.NAME+'] P['+IntToStr(snPrmID)+']...');
     pData.InitGroupParam(snPrmID);
    End;
  finally
    groupList.UnLockList;
  end;   
End;

procedure CQweryBytServers.CommandDataSrv(groupID:Integer;snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
   try
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.CommandDataSrv G['+IntToStr(groupID)+'] P['+IntToStr(snPrmID)+']...');
    vList := groupList.LockList;
    index := Find(groupID);
    pData := vList[index];
    pData.CommandDataSrv(snPrmID);
  finally
    groupList.UnLockList;
  end;  
End;

procedure CQweryBytServers.UnloadDataSrv(groupID:Integer;snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
  try
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.UnloadDataSrv G['+IntToStr(groupID)+'] P['+IntToStr(snPrmID)+']...');
    vList := groupList.LockList;
    index := Find(groupID);
    pData := vList[index];
    pData.UnloadDataSrv(snPrmID);
  finally
    groupList.UnLockList;
  end;  
End;

procedure CQweryBytServers.UpdateDataSrv(groupID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
  try
    vList := groupList.LockList;
    if (groupID=-1) then
    Begin
     for index:=0 to vList.Count-1 do
     Begin
      pData := vList[index];
      if pData.config.ENABLE=1 then
      Begin
       if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.UpdateDataSrv G['+pData.config.NAME+'] P['+IntToStr(snPrmID)+'] Enable['+IntTostr(pData.config.ENABLE)+']...');
       pData.UpdateDataSrv(sdtBegin,sdtEnd,snPrmID);
      End;
     End;
    End else
    Begin
     index := Find(groupID);
     pData := vList[index];
     if pData.config.ENABLE=1 then
     Begin
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.UpdateDataSrv G['+pData.config.NAME+'] P['+IntToStr(snPrmID)+'] Enable['+IntTostr(pData.config.ENABLE)+']...');
      pData.UpdateDataSrv(sdtBegin,sdtEnd,snPrmID);
     End;
    End;
  finally
    groupList.UnLockList;
  end;  
End;

procedure CQweryBytServers.UpdateErrorDataSrv(groupID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
   try
    vList := groupList.LockList;
    if (groupID=-1) then
    Begin
     for index:=0 to vList.Count-1 do
     Begin
      pData := vList[index];
      if pData.config.ENABLE=1 then
      Begin
       if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.UpdateDataSrv G['+pData.config.NAME+'] P['+IntToStr(snPrmID)+'] Enable['+IntTostr(pData.config.ENABLE)+']...');
       pData.UpdateErrorDataSrv(sdtBegin,sdtEnd,snPrmID);
      End;
     End;
    End else
    Begin
     index := Find(groupID);
     pData := vList[index];
     if pData.config.ENABLE=1 then
     Begin
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.UpdateDataSrv G['+pData.config.NAME+'] P['+IntToStr(snPrmID)+'] Enable['+IntTostr(pData.config.ENABLE)+']...');
      pData.UpdateErrorDataSrv(sdtBegin,sdtEnd,snPrmID);
     End;
    End;
   finally
    groupList.UnLockList;
   end;
End;

procedure CQweryBytServers.FindDataSrv(groupID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
    if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.FindDataSrv G['+IntToStr(groupID)+'] P['+IntToStr(snPrmID)+']...');
    vList := groupList.LockList;
    index := Find(groupID);
    pData := vList[index];
    pData.FindDataSrv(sdtBegin,sdtEnd,snPrmID);
    groupList.UnLockList;
End;

procedure CQweryBytServers.StopQwerySrv(groupID:Integer);
Var
    index : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
  try
    vList := groupList.LockList;
    if (groupID=-1) then
    Begin
     groupPull.freeBox;
     for index:=0 to vList.Count-1 do
     Begin
      pData := vList[index];
      if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.StopQwerySrv G['+pData.config.NAME+'] P[X]...');
      pData.StopQwerySrv;
     End;
    End else
    Begin
     index := Find(groupID);
     pData := vList[index];
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.StopQwerySrv G['+pData.config.NAME+'] P[X]...');
     pData.StopQwerySrv;
    End;
  finally
    groupList.UnLockList;
  end;
End;

function CQweryBytServers.Find(groupID:Integer):Integer;
Var
    i     : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
    Result := 0;
    try
     vList  := groupList.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       pData := vList[i];
       if(pData.getID=groupID) then
       Begin
        Result := i;
        exit;
       End;
      End;
    finally
     groupList.UnLockList;
    End;
End;

procedure CQweryBytServers.Delete(groupID:Integer);
{Var
    i : Integer;}
Begin

End;
procedure CQweryBytServers.Run;
Var
    i     : Integer;
    vList : TList;
    pData : CQweryBytGroup;
Begin
    //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(0)+')CQweryBytServers.Run');
    if groupList=nil then exit;
    vList := groupList.LockList;
    try
    for i:=0 to vList.Count-1 do
    Begin
     pData := vList[i];
     if pData.config.enable=1 then
     pData.Run;
    End;
    finally
     groupList.UnLockList;
    End;
End;


initialization

finalization
  if hRunOnlyOneMutex <> 0 then
    ReleaseMutex(hRunOnlyOneMutex);

end.

