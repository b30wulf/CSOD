unit knsl2qwerybytgroup;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
 knsl3EventBox,knsl2qweryportpull,knsl2qwerybitserver,
 utldatabase,knsl3HolesFinder,knsl2qwerybytcomm,{utldynconnect,}knsl2CThreadPull,ExeParams,
 utlDBForOneQuery;
type
    CQweryBytGroup = class
    private
     commList  : TThreadList;
     paramList : TThreadList;
     portPull  : TThreadList;
     groupPull : CThreadPull;
     abonPull  : CThreadPull;
     tpPull    : CThreadPull;
     function getQueryGroupsParam(pDb : TDBaseForOneQuery; groupID, paramID : Integer; var pTable:TThreadList):Boolean;
    public
     config    : QUERYGROUP;
     constructor Create;
     destructor Destroy;override;
     
     function getID:Integer;
     procedure initComands;
     procedure Init(
      var vConfig:QUERYGROUP;
      var vPortPull:TThreadList;
      var vGroupPull:CThreadPull;
      var vAbonPull:CThreadPull;
      var vTpPull:CThreadPull);
     function  EventHandler(var pMsg:CMessage):Boolean;
     procedure InitGroupParam(snPrmID:Integer);
     procedure CommandDataSrv(snPrmID:Integer);
     procedure UpdateDataSrv(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     procedure UpdateErrorDataSrv(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer); //перезапуск после ошибки программы
     procedure UnloadDataSrv(snPrmID:Integer);
     procedure FindDataSrv(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     procedure StopQwerySrv;
     function Find(paramID:Integer):Integer;

     procedure Run;
    End;
    PCQweryBytGroup = ^CQweryBytGroup;
implementation

//CQweryServers
constructor CQweryBytGroup.Create();
Begin
End;
destructor CQweryBytGroup.Destroy;
Begin
  ClearListAndFree(commList);
  ClearListAndFree(paramList);
//  ClearListAndFree(portPull);
//  ClearListAndFree(groupPull);
//  ClearListAndFree(abonPull);
//  ClearListAndFree(tpPull);
  inherited;
End;

procedure CQweryBytGroup.Init(
      var vConfig:QUERYGROUP;
      var vPortPull:TThreadList;
      var vGroupPull:CThreadPull;
      var vAbonPull:CThreadPull;
      var vTpPull:CThreadPull);
Begin
     config    := vConfig;
     portPull  := vPortPull;
     groupPull := vGroupPull;
     abonPull  := vAbonPull;
     tpPull    := vTpPull;
     initComands;
End;


procedure CQweryBytGroup.initComands;
Var
    vList : TList;
    i     : Integer;
    pData : QGPARAM;
    pD    : CSheduleCommand;
//    pDb   : CDBDynamicConn;
    pDb   : TDBaseForOneQuery;
Begin
  try
    ClearListAndFree(commList);
    commList := TThreadList.Create;
    
    ClearListAndFree(paramList);
    paramList := TThreadList.Create;

    pDb := GetConnectForOneQuery;
   // pDb  := m_pDB.getConnection;
//    pDb  := CDBDynamicConn.Create();
//    pDb.Create(pDb.InitStrFileName);

//   if m_pDB.getQueryGroupsParam(getID,-1,paramList)=True then
    if getQueryGroupsParam(pDb, getID, -1, paramList)=True then
    Begin
     vList     := paramList.LockList;
     for i:=0 to vList.Count-1 do
     Begin
      pData := vList[i];
      pD    := CSheduleCommand.Create(portPull,groupPull,abonPull,tpPull,pData);
      commList.LockList.Add(pD);
      commList.UnLockList;
     End;
     paramList.UnLockList;
    End;
    //m_pDB.DiscDynConnect(pDb);
  finally
   if pDb<>Nil then FreeAndNil(pDb);
//    if pDb<>Nil then
//       begin
//        pDb.Disconnect; //m_pDB.DiscDynConnect(pDb);
//        FreeAndNil(pDb);
//       end;
  end;
End;

function CQweryBytGroup.getID:Integer;
Begin
    Result := config.ID;
End;

function CQweryBytGroup.EventHandler(var pMsg:CMessage):Boolean;
Begin
End;

procedure CQweryBytGroup.InitGroupParam(snPrmID:Integer);
Var
     pTbl  : TThreadList;
     //pDb   : CDBDynamicConn;
     pDb   : TDBaseForOneQuery;
     pData : QGPARAM;
     index : Integer;
     pD    : CSheduleCommand;
     vList : TList;
     i     : Integer;
Begin
  try
     //pDb:=nil;
     pDb := GetConnectForOneQuery;
     if snPrmID=-1 then
     Begin
       initComands;
       exit;
     End;
     //pDb  := m_pDB.getConnection;

     //pDb := GetConnectForOneQuery;
     pTbl := TThreadList.Create;
     //if m_pDB.getQueryGroupsParam(getID,snPrmID,pTbl)=True then
     if getQueryGroupsParam(pDb,getID,snPrmID,pTbl)=True then
     Begin
      pData := pTbl.LockList.items[0];
      index := Find(snPrmID);
      vList := commList.LockList;
      ClearListAndFreeIndex(commList,index);
      vList.Delete(index);
      pD   := CSheduleCommand.Create(portPull,groupPull,abonPull,tpPull,pData);
      vList.Add(pD);
      commList.UnLockList;
      pTbl.UnLockList;
     End;
  finally
    if pData<>nil then FreeAndNil(pData);
    if pTbl<>Nil then  FreeAndNil(pTbl);
    if pDb<>Nil then FreeAndNil(pDb);
  end;
   //  m_pDB.DiscDynConnect(pDb);
End;

procedure CQweryBytGroup.CommandDataSrv(snPrmID:Integer);
Var
     index : Integer;
     vList : TList;
     pData : CSheduleCommand;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.CommandDataSrv P['+IntToStr(snPrmID)+']');
     vList := commList.LockList;
     index := Find(snPrmID);
     pData := vList[index];
     pData.CommandDataSrv;
     commList.UnLockList;
End;

procedure CQweryBytGroup.UnloadDataSrv(snPrmID:Integer);
Var
     index : Integer;
     vList : TList;
     pData : CSheduleCommand;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.UnloadDataSrv P['+IntToStr(snPrmID)+']');
     vList := commList.LockList;
     index := Find(snPrmID);
     pData := vList[index];
     pData.UnloadDataSrv();
     commList.UnLockList;
End;

procedure CQweryBytGroup.UpdateDataSrv(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
     index : Integer;
     vList : TList;
     pData : CSheduleCommand;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.UpdateDataSrv P['+IntToStr(snPrmID)+']');
     vList := commList.LockList;
     index := Find(snPrmID);
     pData := vList[index];
     pData.UpdateDataSrv(sdtBegin,sdtEnd);
     commList.UnLockList;
End;

procedure CQweryBytGroup.UpdateErrorDataSrv(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
     index : Integer;
     vList : TList;
     pData : CSheduleCommand;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.UpdateDataSrv P['+IntToStr(snPrmID)+']');
     vList := commList.LockList;
     index := Find(snPrmID);
     pData := vList[index];
     pData.UpdateErrorDataSrv(sdtBegin,sdtEnd);
     commList.UnLockList;
End;

procedure CQweryBytGroup.FindDataSrv(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
     index : Integer;
     vList : TList;
     pData : CSheduleCommand;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.FindDataSrv P['+IntToStr(snPrmID)+']');
     vList := commList.LockList;
     index := Find(snPrmID);
     pData := vList[index];
     pData.FindDataSrv(sdtBegin,sdtEnd);
     commList.UnLockList;
End;
procedure CQweryBytGroup.StopQwerySrv;
Var
     index : Integer;
     vList : TList;
     pData : CSheduleCommand;
Begin
     if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.StopQwerySrv');
     vList := commList.LockList;
     for index:=0 to vList.Count-1 do
     Begin
      pData := vList[index];
      pData.StopQwerySrv;
     End;
     commList.UnLockList;
End;

function CQweryBytGroup.Find(paramID:Integer):Integer;
Var
    i     : Integer;
    vList : TList;
    pData : CSheduleCommand;
Begin
    Result := 0;
    vList  := commList.LockList;
    try
    for i:=0 to vList.Count-1 do
    Begin
     pData := vList[i];
     if(pData.getID=paramID) then
     Begin
      Result := i;
      exit;
     End;
    End;
    finally
     commList.UnLockList;
    End;
End;

procedure CQweryBytGroup.Run;
Var
    i     : Integer;
    vList : TList;
    pData : CSheduleCommand;
Begin
    //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CQweryBytGroup.Run');
if(startParams.isStartOpros=True)then
  begin
    if commList=nil then exit;
    vList := commList.LockList;
    for i:=0 to vList.Count-1 do
    Begin
     pData := vList[i];
     pData.Run;
    End;
    commList.UnLockList;
  end;
End;

function CQweryBytGroup.getQueryGroupsParam(pDb : TDBaseForOneQuery; groupID, paramID : Integer; var pTable:TThreadList):Boolean;
Var strSQL : String;
    strParam : String;
    res    : Boolean;
    nCount : Integer;
    data   : QGPARAM;
Begin
  res := false;
  if(paramID<>-1) then strParam := ' and PARAM='+IntToStr(paramID);
  strSQL := 'SELECT QGPARAM.*,QM_PARAMS.M_SNAME FROM QGPARAM,QM_PARAMS'+
  ' where QGID='+IntToStr(groupID)+
  ' and PARAM=M_SWTYPE'+
  strParam+
  ' ORDER BY param';
  if pDb.OpenQry(strSQL,nCount)=True then Begin
   while not pDb.IBQuery.Eof do Begin
    data             := QGPARAM.Create;
    data.id          := pDb.IBQuery.FieldByName('id').AsInteger;
    data.QGID        := pDb.IBQuery.FieldByName('QGID').AsInteger;
    data.PARAM       := pDb.IBQuery.FieldByName('PARAM').AsInteger;
    data.PARAMNM     := pDb.IBQuery.FieldByName('M_SNAME').AsString;
    data.DTBEGIN     := pDb.IBQuery.FieldByName('DTBEGIN').AsDateTime;
    data.DTEND       := pDb.IBQuery.FieldByName('DTEND').AsDateTime;
    data.DTPERIOD    := pDb.IBQuery.FieldByName('DTPERIOD').AsDateTime;
    data.DAYMASK     := pDb.IBQuery.FieldByName('DAYMASK').AsInteger;
    data.MONTHMASK   := pDb.IBQuery.FieldByName('MONTHMASK').AsInteger;
    data.ENABLE      := pDb.IBQuery.FieldByName('ENABLE').AsInteger;
    data.DEEPFIND    := pDb.IBQuery.FieldByName('DEEPFIND').AsInteger;
    data.PAUSE       := pDb.IBQuery.FieldByName('PAUSE').AsInteger;
    data.FINDDATA    := pDb.IBQuery.FieldByName('FINDDATA').AsInteger;
    data.UNDEEPFIND  := pDb.IBQuery.FieldByName('UNDEEPFIND').AsInteger;
    data.UNPATH      := pDb.IBQuery.FieldByName('UNPATH').AsString;
    data.UNENABLE    := pDb.IBQuery.FieldByName('UNENABLE').AsInteger;
    data.ISRUNSTATUS := pDb.IBQuery.FieldByName('ISRUNSTATUS').AsInteger;
    data.RUNSTATUS   := pDb.IBQuery.FieldByName('RUNSTATUS').AsString;
    data.ERRORPERCENT:= pDb.IBQuery.FieldByName('ERRORPERCENT').AsFloat;
    data.TIMETOSTOP  := pDb.IBQuery.FieldByName('TIMETOSTOP').AsDateTime;
    data.PACKETK     := pDb.IBQuery.FieldByName('PACK_KUB').AsInteger;
    data.ERRORPERCENT2:= pDb.IBQuery.FieldByName('ERRORPERCENT2').AsFloat;
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
