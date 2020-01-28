unit knsl2qwerybytcomm;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,knsl2qwerybyttmr,knsl2qwerybitserver{,utldatabase}, utlDBForOneQuery,
utldynconnect, knsl3EventBox,knsl2querybytunloader,knsl3HolesFinder,utlTimeDate,knsl2IRunnable,knsl2CThreadPull;
type
{
     portPull  : TThreadList;
     taskPull  : CThreadPull;
     queryPull : CThreadPull;
}
    CSheduleCommand = class(CTimeSheduler)
    private
     portPull  : TThreadList;
     groupPull : CThreadPull;
     abonPull  : CThreadPull;
     tpPull    : CThreadPull;
     taskIndex : Integer;
     m_sQC     : SQWERYCMDID;
     //taskList  : TThreadList;
    protected
     destructor Destroy();override;
    private
     pDb      : TDBaseForOneQuery;
     GroupIdName : string;
     procedure AutoLoad;
     function  GetEndTime:TDateTime;
     procedure SendQSTreeData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime); //передача сообщения для обновления дерева
     function GroupIdToName(pDb : TDBaseForOneQuery; groupID:Integer):string;
     function GetQueryAbons(pDb : TDBaseForOneQuery; gid:QGPARAM;tptype:Integer; var pTable:TThreadList):Boolean;
    public
     constructor Create(var vPortPull  : TThreadList;
                        var vGroupPull : CThreadPull;
                        var vAbonPull  : CThreadPull;
                        var vTpPull    : CThreadPull;
                        var pTbl:QGPARAM);

     procedure OnExpired; override;
     procedure OnInit; override;
     procedure CommandDataSrv;
     procedure UpdateDataSrv(sdtBegin,sdtEnd:TDateTime);
     procedure UpdateErrorDataSrv(sdtBegin,sdtEnd:TDateTime); //перезапуск после ошибки программы  
     procedure UnloadDataSrv;
     procedure FindDataSrv(sdtBegin,sdtEnd:TDateTime);
     procedure StopQwerySrv;
     procedure Run;
    End;
implementation

destructor CSheduleCommand.Destroy();
Begin
  FreeAndNil(pDb);
  inherited;
End;

constructor CSheduleCommand.Create(
                        var vPortPull  : TThreadList;
                        var vGroupPull : CThreadPull;
                        var vAbonPull  : CThreadPull;
                        var vTpPull    : CThreadPull;
                        var pTbl:QGPARAM);
Begin
     inherited Create(pTbl);
     portPull  := vPortPull;
     groupPull := vGroupPull;
     abonPull  := vAbonPull;
     tpPull    := vTpPull;
     
     pDb := GetConnectForOneQuery;
     GroupIdName := GroupIdToName(pDb, m_nTbl.QGID);
     //taskList  := TThreadList.Create;
End;
procedure CSheduleCommand.OnInit;
Begin

End;
procedure CSheduleCommand.OnExpired;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.OnExpired P['+IntToStr(getID)+']...');
     //m_pDB.SetGroupRefresh(m_nTbl.QGID,3,Now); //создать запрос на обновление параметра для анализа состояния группы опроса
     SendQSTreeData(QS_UPDT_SR,m_nTbl.QGID,3,Now,Now);//для смены параметра для анализа состояния группы опроса
     AutoLoad;
End;

procedure CSheduleCommand.AutoLoad;
Var
     dtBegin,dtEnd  : TDateTime;
Begin
     dtBegin:= Now;
     //dtEnd  := GetEndTime;
     dtEnd:= Now;
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.AutoLoad DTBEGIN:'+DateToStr(dtBegin)+' DTEND:'+DateToStr(dtEnd)+' P['+IntToStr(getID)+']...');
     sleep(100);
     UpdateDataSrv(dtBegin,dtEnd);
End;

procedure CSheduleCommand.CommandDataSrv;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.CommandDataSrv P['+IntToStr(getID)+']...');
End;

function CSheduleCommand.GetEndTime:TDateTime;
Var
     dtEnd : TDateTime;
     year,month,day : Word;
Begin
     dtEnd := Now;
     if m_nTbl.DEEPFIND=0 then
     Begin
      DecodeDate(dtEnd,year,month,day);
      dtEnd := EncodeDate(year,month,1);
      dtEnd := dtEnd - 1;
     End else
     if m_nTbl.DEEPFIND=12 then
     Begin
      m_nDT.DecMonth(dtEnd);
      DecodeDate(dtEnd,year,month,day);
      dtEnd := EncodeDate(year,month,1);
     End else
     if m_nTbl.DEEPFIND<>0 then dtEnd := dtEnd - DeltaFHF[m_nTbl.DEEPFIND];
     Result := dtEnd;
End;

procedure CSheduleCommand.UnloadDataSrv;
Var
     unloader : CBytUnloader;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.UnloadDataSrv P['+IntToStr(getID)+']...');
     unloader := CBytUnloader.Create(m_nTbl);
     unloader.onExport;
     if (unloader<>nil)then FreeAndNil(unloader);
End;

procedure CSheduleCommand.UpdateDataSrv(sdtBegin,sdtEnd:TDateTime);
Var
     runnable : PIRunnable;
     pDb      : CDBDynamicConn;
     pHF      : CHolesFinder;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.UpdateDataSrv P['+IntToStr(getID)+'] Group[' + GroupIdName {m_pDB.GroupIdToName(m_nTbl.QGID)}+']...');
     pHF      := CHolesFinder.Create(pDb);
     new(runnable);
     runnable^ := CGroupTask.Create(pHF.FindStartDate(m_nTbl.PARAM,sdtBegin),pHF.FindStartDate(m_nTbl.PARAM,sdtEnd),m_nTbl,portpull,abonPull,tpPull,runnable^,False);
     groupPull.submitAndFree(runnable);
     FreeAndNil(pHF);
End;

procedure CSheduleCommand.UpdateErrorDataSrv(sdtBegin,sdtEnd:TDateTime);
Var
     runnable : PIRunnable;
     pDb      : CDBDynamicConn;
     pHF      : CHolesFinder;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.UpdateDataSrv P['+IntToStr(getID)+'] Group['+GroupIdName {m_pDB.GroupIdToName(m_nTbl.QGID)}+']...');
     pHF      := CHolesFinder.Create(pDb);
     new(runnable); 
     runnable^ := CGroupTask.Create(pHF.FindStartDate(m_nTbl.PARAM,sdtBegin),pHF.FindStartDate(m_nTbl.PARAM,sdtEnd),m_nTbl,portpull,abonPull,tpPull,runnable^,True);
     groupPull.submitAndFree(runnable);
     FreeAndNil(pHF);
End;

procedure CSheduleCommand.FindDataSrv(sdtBegin,sdtEnd:TDateTime);
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.FindDataSrv P['+IntToStr(getID)+']...');
     UpdateDataSrv(sdtBegin,sdtEnd);
End;

procedure CSheduleCommand.StopQwerySrv;
Var
     runnable : IRunnable;
     pTbl     : TThreadList;
     vList    : TList;
     data     : qgabons;
     i        : Integer;
//     pDb      : CDBDynamicConn;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(m_nTbl.QGID)+')CSheduleCommand.StopQwerySrv P['+IntToStr(getID)+']...');
     pTbl   := TThreadList.Create;
     try
//       pDb  := m_pDB.getConnection;
       groupPull.setState(m_nTbl.QGID,TASK_STATE_KIL);
       m_nTbl.ISRUNSTATUS:=0;
       m_nTbl.RUNSTATUS:='';
       if GetQueryAbons(pDb, m_nTbl,-1,pTbl)=True then
       Begin
        vList := pTbl.LockList;
        for i:=0 to vList.Count-1 do
        Begin
         data := vList[i];
         abonPull.setState(data.ABOID,TASK_STATE_KIL);
         FreeAndNil(data);//.Destroy;
        End;
       End;
    finally
      pTbl.UnLockList;
//      m_pDB.DiscDynConnect(pDb);
      pTbl.Clear;
      FreeAndNil(pTbl);
    end;
End;

procedure CSheduleCommand.Run;
Begin
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CSheduleCommand.Run:FD'+IntToStr(m_nTbl.FINDDATA));
     inherited run;
End;

procedure CSheduleCommand.SendQSTreeData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snCmdID  := nCommand;  //команда группы
     sQC.m_sdtBegin := sdtBegin;  //начало времени группы
     sQC.m_sdtEnd   := sdtEnd;    //конец времени группы
     sQC.m_snSRVID  := snSRVID;   //id группы
     sQC.m_snPrmID  := nCMDID;    //команда группы (ожидание опроса руч.)
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYTREE_REQ,pDS);
End;

function CSheduleCommand.GroupIdToName(pDb : TDBaseForOneQuery; groupID:Integer):string;
Var
    strSQL : String;
    nCount   : Integer;
Begin
    Result:='';
    //if (groupID<>-1) then sqlAdd := ' and QGID='+IntToStr(groupID);
    strSQL := 'Select NAME From querygroup where id='+IntToStr(groupID);
    if pDb.OpenQry(strSQL,nCount)=True then
     with pDb.IBQuery do // FADOQuery do
     Begin
      Result   :=FieldByName('NAME').AsString;
     End;
    pDb.CloseQry;
End;

function CSheduleCommand.GetQueryAbons(pDb : TDBaseForOneQuery; gid:QGPARAM;tptype:Integer; var pTable:TThreadList):Boolean;
Var
    strSQL : String;
    sStatus: String;
    sTpType, sTpFrom: String;
    res    : Boolean;
    nCount : Integer;
    data   : QGABONS;
Begin
    res := false;
    sTpType := ''; sStatus := '';sTpFrom := '';
    if (tptype<>-1) then
    Begin
     sTpFrom:=',SL3TP as s2';
     sTpType := ' and s1.TPID=s2.ID and s2.tptype='+IntToStr(tptype);
    End;
    if (gid.ISRUNSTATUS=1) then sStatus := ' and s0.state in('+gid.RUNSTATUS+')';
    strSQL := 'SELECT s0.*, (QG.NAME || '', '' || s1.M_SADDRESS || '', '' || s1.M_SNAME) M_SNAME '+    // BO 21.11.18
    ' FROM QGABONS as s0, SL3ABON as s1'+sTpFrom+ ', QUERYGROUP as QG ' +
    ' where s0.QGID = QG.ID and s0.QGID='+IntToStr(gid.QGID)+
    ' and s0.ABOID=s1.M_SWABOID'+sTpType+
    ' and s0.ENABLE=1'+sStatus+
    ' ORDER BY s0.ABOID';
    if pDb.OpenQry(strSQL,nCount)=True then
    Begin
     while not pDb.IBQuery.Eof do begin // FADOQuery.Eof do Begin
      data        := QGABONS.Create;
      data.id     := pDb.IBQuery.FieldByName('id').AsInteger;     //   FADOQuery.
      data.QGID   := pDb.IBQuery.FieldByName('QGID').AsInteger;
      data.ABOID  := pDb.IBQuery.FieldByName('ABOID').AsInteger;
      data.ABONM  := pDb.IBQuery.FieldByName('M_SNAME').AsString;
      data.ENABLE  := pDb.IBQuery.FieldByName('ENABLE').AsInteger;
      data.ENABLE_PROG  := pDb.IBQuery.FieldByName('ENABLE_PROG').AsInteger;
      pDb.IBQuery.Next;
      pTable.LockList.Add(data);
      pTable.UnLockList;
     End;
    res := True;
    End;
    pDb.CloseQry;
    Result := res;
End;

end.

