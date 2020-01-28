unit knsl2qwerybitserver;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3HolesFinder,knsl2qweryportpull,knsl2qweryarchmdl,
 knsl2module,knsl2meter,knsl3EventBox,knsl2querybytunloader,utlcbox,utldynconnect,knsl5config,
 knsl2IRunnable,knsl2CThreadPull,knsl2Factory,OnlyOne,utlQueryQualityDyn,utlSendRecive;
type
     CGroupTask = class(IRunnable)
    private
      dtBegin      : TDateTime;
      dtEnd        : TDateTime;
      cmd          : Integer;
      gid          : QGPARAM;
      abonPull     : CThreadPull;
      tpPull       : CThreadPull;
      portPull     : TThreadList;
      taskUndex    : Integer;
      m_sQC        : SQWERYCMDID; //для передачи сообщения
      SenderClass  : TSenderClass;
      ResError     : Boolean; //Параметр проверки после ошибки программы
    private
     procedure SendQSTreeData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
     procedure SendQSTreeDataL5module(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
     public
     constructor Create(vDtBegin,vDtEnd:TDateTime;
                              vGid : QGPARAM;
                              vPortPull:TThreadList;
                              var vAbonPull:CThreadPull;
                              var vTpPull:CThreadPull;
                              var vParent : IRunnable;
                              Error       : Boolean);

      destructor Destroy;override;
      function   run:Integer;override;
      function   getGroupID:integer;
      function   getParamID:integer;
      function   GetRunnableStatics(_fabric: Factory; data: qgabons; var dateEnd:TDateTime; pDb:CDBDynamicConn):IRunnable;
      procedure  ResetProgress(var dateEnd:TDateTime;vList: TList;count:integer;pDb:CDBDynamicConn);
      procedure  ResetProgress8086(var dateEnd:TDateTime;_data:qgabons;{vList: TList;count:integer;}pDb:CDBDynamicConn);
      procedure  StateMessage(dateEnd:TDateTime;vList: TList;first,count:integer;pDb:CDBDynamicConn);
      procedure  Task;
      procedure  ErrorTask;
    End;

implementation

uses fLogTypeCommand, fLogFile, knsl5module, knsl2treehandler;

constructor CGroupTask.Create(vDtBegin,vDtEnd:TDateTime;
                              vGid : QGPARAM;
                              vPortPull:TThreadList;
                              var vAbonPull:CThreadPull;
                              var vTpPull:CThreadPull;
                              var vParent : IRunnable;
                              Error       : Boolean);
Begin
      if SenderClass<>Nil then SenderClass := TSenderClass.Create;
      dtBegin      := vDtBegin;
      dtEnd        := vDtEnd;
      cmd          := vGid.PARAM;
      gid          := vGid;
      portPull     := vPortPull;
      abonPull     := vAbonPull;
      tpPull       := vTpPull;
      id           := vGid.QGID;
      state        := TASK_STATE_RUN;
      parent       := vParent;
      ResError     := Error;
End;

destructor CGroupTask.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;

function CGroupTask.getGroupID:integer;
Begin
    Result := gid.QGID;
End;

function CGroupTask.getParamID:integer;
Begin
    Result := cmd;
End;

function CGroupTask.run:Integer;
Var
    unloader : CBytUnloader;
Begin
    Result := 0;
    if (ResError=true) then
    begin
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(Error= True. Перезапуск группы после ошибки)');
    end
    else
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(Error= False. Ошибок не было.)');
     
    try
     SendQSTreeDataL5module(0,1,1,Now,Now);

     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(gid.QGID)+')CGroupTask Begin...');
     SendQSTreeData(QS_UPDT_SR,gid.QGID,1,Now,Now);//для смены параметра для анализа состояния группы опроса

     if ResError=True then
        ErrorTask
     else
        Task;

     if gid.UNENABLE=1 then
     Begin
      with lcCEPollWasSuccessful do     // BO 21.11.18
        LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
        unloader := CBytUnloader.Create(gid);
      // определяем значение gid.QGID
      // теперь его нужно найти в treeview
      // если это текущее значение, то вопросов нет - TreeView1.Items[i].Selected
      // если нет - искать перебором
      try
        unloader.onExport;
      finally
        FreeAndNil(unloader);
      end;
     End;
    finally
      Result:=0;
    end;
End;


procedure CGroupTask.Task;
Var
     runnable : IRunnable;
     pTbl,pTblTp : TThreadList;
     vList, vlist2  : TList;
     data     : qgabons;
     i,j        : Integer;
     pDb,pDb2 : CDBDynamicConn;
     dateEnd  : TDateTime;
     fabric   : Factory;
begin
   try
    try
     pTbl   := TThreadList.Create;
     vList  := nil; vList2 := nil;  fabric := nil;
     fabric := Factory.Create;
     pDb    := CDBDynamicConn.Create();
     pDb.Create(pDb.InitStrFileName);
     
     if pDb.GetQueryAbons(gid,0,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
        Begin
          if state=TASK_STATE_KIL then
          exit;
          data := vList[i];
            runnable:=GetRunnableStatics(fabric,data,dateEnd,pDb);
           if (runnable<>nil)then begin
             abonPull.exequte(runnable,true);
           end else begin
             if EventBox<>Nil then
               EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask ERROR RUNNABLE NILL!!!');
               with lcCESurveyWasPerformedWithErrorERROR_RUNNABLE_NILL do     // BO 21.11.18
                 LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
           end;
        end;
         if state=TASK_STATE_KIL then
         Begin
          if EventBox<>Nil then
          begin
            EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask TASK KILLED!!!');
            StateMessage(dateEnd,vList,i,vList.Count,pDb);
            with lcCEPollIsForcedToStop do     // BO 21.11.18
              LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
          end;
          exit;
         End;
         SendQSTreeDataL5module(1,i+1,vList.Count,Now,Now);
     End;
     abonPull.getAll;
     abonPull.ClearTask;   //чистим таски

     {***************************** **********************************
     * Author   : ООО "АВТОМАТИЗАЦИЯ 2000"
     * Чтение взэпа после программирования с таймаутом в 15 сек
     * Чекбокс должен быть активный
     ***************************************************************}
     pTblTp := TThreadList.Create;

     pDb2  := CDBDynamicConn.Create(); //m_pDB.getConnection;
     pDb2.Create(pDb2.InitStrFileName);
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(gid.QGID)+')CGroupTask Begin...');

     if pDb2.GetQueryAbons8086(gid,0,1,pTblTp)=True then
     Begin
      sleep(180*500); //таймаут для ВЗЭПА (дать время опросить счетчики)
      vList2 := pTblTp.LockList;
      ResetProgress(dateEnd,vList2,vList2.Count,pDb2);
      for i:=0 to vList2.Count-1 do
      Begin
       data := vList2[i];
       runnable:=fabric.getRunnable8086(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb2,data,IRunnable(self)); //IRunnable(self));

       if (runnable<>nil)then
        tppull.exequte(runnable)
       else  begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask ERROR RUNNABLE NILL!!!');
         with lcCESurveyWasPerformedWithErrorERROR_RUNNABLE_NILL do     // BO 21.11.18
           LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
       end;
       if state=TASK_STATE_KIL then
       Begin
        if EventBox<>Nil then
        begin EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask TASK KILLED!!!');
          StateMessage(dateEnd,vList2,i,vList2.Count,pDb2);
        end;
        with lcCEPollIsForcedToStop do     // BO 21.11.18
          LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
        exit;
       End;
      End;
     End;
     tpPull.getAll;
     tpPull.ClearTask;//чистим таски
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(Ошибка в модуле-> CGroupTask.Task.)');
    end;
   finally
//    abonPull.getAll;
//    abonPull.ClearTask;   //чистим таски
//    tpPull.getAll;
//    tpPull.ClearTask;//чистим таски

    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(gid.QGID)+')CGroupTask End.');
    if vList <> nil then
      pTbl.UnLockList;
    if vlist2<>nil then
      pTblTp.UnLockList;

    SendQSTreeDataL5module(3,0,0,Now,Now);        //для нижнего прогресс бара knsl5module
    SendQSTreeDataL5module(4,0,0,Now,Now);        //для нижнего прогресс бара knsl5module
    SendQSTreeData(QS_UPDT_SR,gid.QGID,0,Now,Now);//для смены параметра для анализа состояния группы опроса

    SendQSTreeData(QS_INIT_SR,gid.QGID,0,Now,Now);//для смены параметра для анализа состояния группы опроса

    if pDb<>Nil then begin pDb.Disconnect; FreeAndNil(pDb); end;
    if pDb2<>Nil then begin pDb2.Disconnect; FreeAndNil(pDb2); end;
    
    ClearListAndFree(pTbl);
    ClearListAndFree(pTblTp);
    FreeAndNil(pTblTp);
    FreeAndNil(fabric);
   end;
end;


procedure CGroupTask.ErrorTask;
Var
     runnable : IRunnable;
     pTbl,pTblTp : TThreadList;
     vList, vlist2  : TList;
     data     : qgabons;
     i        : Integer;
     pDb,pDb2 : CDBDynamicConn;
     dateEnd  : TDateTime;
     fabric   : Factory;
begin
  try
    try
     pTbl   := TThreadList.Create;
     vList  := nil; vList2 := nil;  fabric := nil;
     fabric := Factory.Create;
     pDb    := CDBDynamicConn.Create(); //m_pDB.getConnection;
     pDb.Create(pDb.InitStrFileName);

     if pDb.GetAbonFromGroupReload(gid,0,0,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
        Begin
         data := vList[i];
         runnable:=GetRunnableStatics(fabric,data,dateEnd,pDb);

         if (runnable<>nil)then begin
           abonPull.exequte(runnable);
         end else begin
           if EventBox<>Nil then
             EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask ERROR RUNNABLE NILL!!!');
             with lcCESurveyWasPerformedWithErrorERROR_RUNNABLE_NILL do     // BO 21.11.18
               LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
         end;

         if state=TASK_STATE_KIL then
         Begin
          if EventBox<>Nil then
          begin
            EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask TASK KILLED!!!');
            StateMessage(dateEnd,vList,i,vList.Count,pDb);
            with lcCEPollIsForcedToStop do     // BO 21.11.18
              LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
          end;
          exit;
         End;
         SendQSTreeDataL5module(1,i+1,vList.Count,Now,Now);
        End;
     End;
     abonPull.getAll;
     abonPull.ClearTask;   //чистим таски

     {***************************** **********************************
     * Author   : ООО "АВТОМАТИЗАЦИЯ 2000"
     * Чтение взэпа после программирования с таймаутом в 15 сек
     * Чекбокс должен быть активный
     ***************************************************************}
     pTblTp := TThreadList.Create;

     pDb2    := CDBDynamicConn.Create(); //m_pDB.getConnection;
     pDb2.Create(pDb2.InitStrFileName);

     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(gid.QGID)+')CGroupTask Begin...');

     if pDb2.GetAbonFromGroupReload(gid,0,1,pTblTp)=True then     { TODO 1 -oKudin -cАвтоопрос : ДЛЯ ВЗЭПА ПОМЕНЯТЬ ЗАПРОС }
     Begin
     sleep(180*500); //таймаут для ВЗЭПА (дать время опросить счетчики)
      vList2 := pTblTp.LockList;
       ResetProgress(dateEnd,vList2,vList2.Count,pDb2);
      for i:=0 to vList2.Count-1 do
      Begin
       data := vList2[i];
       runnable:=fabric.getRunnable8086(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb2,data,IRunnable(self)); //IRunnable(self));

       if (runnable<>nil)then
        tppull.exequte(runnable)
       else  begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask ERROR RUNNABLE NILL!!!');
         with lcCESurveyWasPerformedWithErrorERROR_RUNNABLE_NILL do     // BO 21.11.18
           LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
       end;
       if state=TASK_STATE_KIL then
       Begin
        if EventBox<>Nil then
        begin EventBox.FixEvents(ET_CRITICAL,'(GID/CID'+IntToStr(gid.QGID)+'/'+IntToStr(gid.PARAM)+')CGroupTask TASK KILLED!!!');
          StateMessage(dateEnd,vList2,i,vList2.Count,pDb2);
        end;
        with lcCEPollIsForcedToStop do     // BO 21.11.18
          LogFile.AddEventGroup(GRP,EVNT,IDCurrentUser,now);
        exit;
       End;
      End;
     End;
     tpPull.getAll;
     tpPull.ClearTask;//чистим таски
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'(Ошибка в модуле-> CGroupTask.ErrorTask.)');
    end;
  finally
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(gid.QGID)+')CGroupTask End.');
    if vList <> nil then
      pTbl.UnLockList;
    if vlist2<>nil then
      pTblTp.UnLockList;

    SendQSTreeDataL5module(3,0,0,Now,Now);        //для нижнего прогресс бара knsl5module
    SendQSTreeDataL5module(4,0,0,Now,Now);        //для нижнего прогресс бара knsl5module
    SendQSTreeData(QS_UPDT_SR,gid.QGID,0,Now,Now);//для смены параметра для анализа состояния группы опроса

    SendQSTreeData(QS_INIT_SR,gid.QGID,0,Now,Now);//для смены параметра для анализа состояния группы опроса

    //m_pDB.DiscDynConnect(pDb);
    //m_pDB.DiscDynConnect(pDb2);

    if pDb<>Nil then begin
      pDb.Disconnect; //m_pDB.DiscDynConnect(pDb);
      FreeAndNil(pDb);
    end;
    if pDb2<>Nil then begin
     pDb2.Disconnect; //m_pDB.DiscDynConnect(pDb);
     FreeAndNil(pDb2);
    end;
    
    ClearListAndFree(pTbl);
    ClearListAndFree(pTblTp);
    FreeAndNil(pTblTp);
    FreeAndNil(fabric);
  end;
end;

procedure CGroupTask.ResetProgress(var dateEnd:TDateTime;vList: TList;count:integer;pDb:CDBDynamicConn);
var
data : qgabons;
i    : integer;
begin
  dateEnd:=now;
   for i:=0 to count-1 do
    begin
     if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
       begin
        data := vList[i];
        pDb.setQueryState(data.ABOID,-1,QUERY_STATE_NO);//очищает все прогресс бар
        pDb.setDtBeginEndInQueryQroup(data.ABOID,dateEnd,dateEnd,TASK_QUERY_WAIT);//очищает все прогресс бар и помещает состояние в ожидание опроса
       end;
    end;
end;

procedure CGroupTask.ResetProgress8086(var dateEnd:TDateTime;_data:qgabons;{vList: TList;count:integer;}pDb:CDBDynamicConn);
begin
  dateEnd:=now;
   if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
     begin
      pDb.setQueryState(_data.ABOID,-1,QUERY_STATE_NO);//очищает все прогресс бар
       if (_data.ENABLE_PROG=1)then
         pDb.setDtBeginEndInQueryQroup(_data.ABOID,dateEnd,dateEnd,TASK_QUERY_WAIT_PROG)//очищает все прогресс бар и помещает состояние в ожидание программирования
       else
         pDb.setDtBeginEndInQueryQroup(_data.ABOID,dateEnd,dateEnd,TASK_QUERY_WAIT);//очищает все прогресс бар и помещает состояние в ожидание опроса
     end;
end;

procedure CGroupTask.StateMessage(dateEnd:TDateTime;vList: TList;first,count:integer;pDb:CDBDynamicConn);
var
data : qgabons;
i    : integer;
begin
 for i:=first to count-1 do
   begin
    data := vList[i];
    pDb.setDtEndInQueryQroup(data.ABOID,dateEnd,TASK_HAND_STOP); //Помечает все прогресс бар в состояние в принудительно завершено
   end;
end;

{**************************************************
  Функция определния статистики при запуске объекта
****************************************************}
function CGroupTask.GetRunnableStatics(_fabric: Factory;data: qgabons; var dateEnd:TDateTime; pDb:CDBDynamicConn):IRunnable;
var
   QQ       : TQueryQualityDyn;
   MDQ      : TQQData;  // для месяца
   year, month, day :word;
   year_Begin, month_Begin, day_Begin :word;
   DateNow :TDateTime;
   DateBegin :TDateTime;
begin
  DecodeDate(Now, year, month, day);
  DecodeDate(dtBegin, year_Begin, month_Begin, day_Begin);
  if (cmd = QRY_NAK_EN_MONTH_EP)then
    begin
     DateNow := EncodeDate(year,month,1);
     DateBegin := EncodeDate(year_Begin,month_Begin,1);
    end
  else if (cmd = QRY_NAK_EN_DAY_EP)then
    DateNow := EncodeDate(year,month,day)
  else
    DateNow := EncodeDate(year,month,day);

  QQ := TQueryQualityDyn.Create;
  if (cmd=QRY_NAK_EN_MONTH_EP)then
     MDQ := QQ.GetQQMonths(pDb,data.ABOID)  // получить только месяц
  else
  if (cmd=QRY_NAK_EN_DAY_EP)then
     MDQ := QQ.GetQQDays(pDb,data.ABOID)  // получить только день
  else
     MDQ := QQ.GetQQCurrs(pDb,data.ABOID);  // получить только текущ

  with lcCEPollingInProgress do                 // BO 21.11.18
       LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, data.ABONM);

  if (MDQ.Perc=255) then
    Result:=_fabric.getRunnable(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb,data,IRunnable(self)) //IRunnable(self));
  else
  if (DateNow = DateBegin) then //dtBegin
     begin
       if (MDQ.Perc < gid.ERRORPERCENT2) then
         begin
           Result:=_fabric.getRunnable(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb,data,IRunnable(self)); //IRunnable(self));
           ResetProgress8086(dateEnd,data,pDb);
         end
       else
         begin
            Result:=nil;
            pDb.setDtEndInQueryQroup(data.ABOID,now,TASK_ABON_QUALITY) //  Качество данных положительное для абонента
         end;
     end
  else
  begin
     if (dtBegin=MDQ.Dats)then
       begin
         if (MDQ.Perc < gid.ERRORPERCENT2) then
            begin
             Result:=_fabric.getRunnable(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb,data,IRunnable(self)); //IRunnable(self));
             ResetProgress8086(dateEnd,data,pDb);
            end
         else Result:=nil;
       end
     else
     begin
       Result:=_fabric.getRunnable(dtBegin,dtEnd,gid,portpull,abonPull,id,pDb,data,IRunnable(self)); //IRunnable(self));
       ResetProgress8086(dateEnd,data,pDb);
     end;
  end;
  FreeAndNil(QQ);
end;

procedure CGroupTask.SendQSTreeData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     s   : string;
     ID : Integer;
Begin
     ID := 0;
     ID := GetCurrentThreadID;
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snCmdID  := nCommand;    //команда группы
     sQC.m_sdtBegin := sdtBegin;    //начало времени группы
     sQC.m_sdtEnd   := sdtEnd;      //конец времени группы
     sQC.m_snSRVID  := snSRVID;     //id группы
     sQC.m_snPrmID  := nCMDID;      //команда группы (ожидание опроса руч.)
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
     s := SenderClass.ToString(sQC);
     if (nCommand=QS_UPDT_SR)then
      SenderClass.Send(QL_QWERYTREE_REQ,TKnsFormHandle,ID,s);
//     else
//      SenderClass.Send(QL_QWERYSTATISTICABON_REQ,HanldM5,HanldM5,s)
End;

procedure CGroupTask.SendQSTreeDataL5module(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     s   : string;
     ID : Integer;         
Begin
     ID := 0;
     ID := GetCurrentThreadID;
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snCmdID  := nCommand;   //команда группы
     sQC.m_sdtBegin := sdtBegin;   //начало времени группы
     sQC.m_sdtEnd   := sdtEnd;     //конец времени группы
     sQC.m_snSRVID  := snSRVID;    //id группы
     sQC.m_snPrmID  := nCMDID;     //команда группы (ожидание опроса руч.)
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
     s := SenderClass.ToString(sQC);
     SenderClass.Send(QL_QWERYSTATUSBAR_REQ,TKnsFormHandle,ID,s);
End;


end.
