unit knsl2_HouseTask_SSDU;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3HolesFinder,knsl2qweryportpull,knsl2qweryarchmdl,
 knsl2meter,knsl2IRunnable,utldynconnect,knsl2CThreadPull,
 knsl2SSDUBytmeter,utlSendRecive;
 type

    CMeterTaskSSDU = class(IRunnable)
     private
      meter      : CMeter;
      outMsg     : CMessage;
      inMsg      : CMessage;
      connection : IConnection;
      m_sQC      : SQWERYCMDID; //для передачи сообщения
      SenderClass  : TSenderClass;
     protected
      procedure getInputBuffer(var V :PCMessageBuffer);
      procedure getIntBuffer(var V :PCIntBuffer);
      procedure SendEventBox(_Type : Byte; _Message : String);
      procedure SendEventBoxMessage(_Type : Integer; _Message : String; msg : CMessage);
     public
      constructor Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
      destructor  Destroy;override;
      function    run:Integer;override;
      function    runAsyncSSDU:Integer;
      function    noputAsync:Integer;
      function    getOutMsg:Integer;
    End;

    type
      CTaskObjects = record
        runnble  : CMeterTaskSSDU;
        pHF      : CHolesFinder;
        pump     : CDataPump;
        meter    : CMeter;
        pD       : CJoinL2;
        pDM      : CDBDynamicConn;
        res      : Integer;
      end;

    CHouseTaskSSDU = class(IRunnable)
     private
      dtBegin      : TDateTime;
      dtEnd        : TDateTime;
      cmd          : Integer;
      gid          : Integer;
      aid          : Integer;
      mid          : Integer;
      isFind       : Integer;
      ErrorPercent : double;
      TimeToStop   : TDateTime;      
      meterPull    : CThreadPull;
      portPull     : TThreadList;
      inMessageBuffer : CMessageBuffer;
      intBuffer    : CIntBuffer;
      inBufferADR  : CIntBuffer;
      m_sQC        : SQWERYCMDID; //для передачи сообщения
      SenderClass  : TSenderClass;
     private
      function  getPortPull(plid:Integer):CPortPull;
      function  isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
      function  cmdToCls(cmd:Integer):Integer;
      function  getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
      procedure SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
      procedure SendEventBox(_Type : Byte; _Message : String);
     public
      function  getAboID:integer;
      function  getParamID:integer;

      constructor Create(vDtBegin,vDtEnd:TDateTime;
                              vCmd:Integer;
                              vGid :Integer;
                              vAid :Integer;
                              vMid :Integer;
                              vIsFind : Integer;
                              vErrorPercent : double;
                              vTimeToStop   : TDateTime;                              
                              vPortPull:TThreadList;
                              vTaskIndex:Integer;
                              var vMeterPull:CThreadPull;
                              var vParent : IRunnable);

      destructor Destroy;override;
      function   run:Integer;override;
    End;

implementation
{$R+}
constructor CMeterTaskSSDU.Create(var value:CMeter;{vPortPull:TThreadList;}var vParent:IRunnable;var vConnection:IConnection);
Begin
    if SenderClass<>Nil then SenderClass := TSenderClass.Create;
    meter    := value;
    id       := meter.m_nP.m_swMID;
    //portpull := vPortPull;
    state    := TASK_STATE_RUN;
    parent   := vParent;
    connection := vConnection;
End;

destructor CMeterTaskSSDU.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;

procedure CMeterTaskSSDU.getInputBuffer(var V :PCMessageBuffer);
begin
  if parent is CHouseTaskSSDU then
    V := @(CHouseTaskSSDU(parent).inMessageBuffer)
  else V := nil;
end;
procedure CMeterTaskSSDU.getIntBuffer(var V :PCIntBuffer);
begin
  if parent is CHouseTaskSSDU then
    V := @(CHouseTaskSSDU(parent).intBuffer)
  else V := nil;
end;

function CMeterTaskSSDU.run:Integer;
Var
    index      : Integer;
    i          : Integer;
    getResult  : Integer;
    pDb        : CDBDynamicConn;
Begin
    index := 0;
    getResult := -1;
    try
      pDb  := meter.getDbConnect;
      while meter.send(outMsg) do
      Begin
       if state=TASK_STATE_KIL then
       Begin
        SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU TASK KILLED!!!');
        exit;
       End;
       if(outMsg.m_swLen<>0) then
       Begin
        connection.put(outMsg);
        SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG PUT Complette... MSG:>',outMsg);
  //      res := true;
        i   := 0;
        getResult := -1;
        while getResult<>0 do
        Begin
          getResult := connection.get(inMsg);
          //Normal get
          if getResult=0 then
          Begin
           SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG GET Complette... MSG:>',inMsg);
           if meter.EventHandler(inMsg) then
           Begin
            with meter.m_nP do pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_OK);
            SendEventBox(ET_RELEASE,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG GET Complette. Len:'+IntToStr(inMsg.m_swLen));
            break;
           End else
           Begin
            getResult := -1;
           End;
          End;
          //Connect Error
          if getResult=2 then
          Begin
            with meter.m_nP do
            begin
            pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
            pDb.addErrorArch(M_SWABOID,m_swMID);
            end;
           SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG Skip. Error In Channel!!! ');
           break;
          End;
          inc(i);
          if i>meter.m_nP.m_sbyRepMsg then
          Begin
           with meter.m_nP do
           begin
           pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
           pDb.addErrorArch(M_SWABOID,m_swMID);
           end;
           getResult := -1;
           break;
          End;        //Repeat message if not get
          connection.put(outMsg);
          SendEventBoxMessage(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU.Run Repeat '+IntToStr(i)+' of '+IntToStr(meter.m_nP.m_sbyRepMsg)+'    MSG:>',outMsg);
        End;
       End else
       Begin
        index := index + 1;
       End;
      End;
    finally
     Result := getResult;
    end;
End;

function CMeterTaskSSDU.runAsyncSSDU: Integer;
Var
    index      : Integer;
    i          : Integer;
    pDb        : CDBDynamicConn;
    inBuff     : PCMessageBuffer;
Begin
    index := 0;
    Result := -1;
    getInputBuffer(inBuff);
    if inBuff = nil then Exit;

    if outMsg.m_swLen = 0 then begin
      if not meter.send(outMsg) then Exit;
    end;
    if outMsg.m_swLen = 0 then Exit;
    pDb  := meter.getDbConnect;
    if state=TASK_STATE_KIL then
     Begin
      SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU TASK KILLED!!!');
      exit;
     End;
     if(outMsg.m_swLen<>0) then
     Begin
      connection.put(outMsg);
      SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG PUT ASYNC Complette... MSG:>',outMsg);
//      res := true;
      i   := 0;
      Result := -1;

      while Result<>0 do Begin
        Result := connection.get(inMsg);
        //Normal get
        if Result=0 then
        Begin
         meter.m_nT.B2 := True; // Вторичный признак успешности опроса
         if meter.EventHandler(inMsg) then
         begin
           if meter.m_nT.B2 then
            begin
             Result:=-1; //задаем статически не 0 чтоб в дальнейщем распарсить все значения
             SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG GET ASYNC Complette... MSG:>',inMsg);
             SendEventBox(ET_RELEASE,'('+'CMeterTask_SSDU MSG GET ASYNC Complette. Len:'+IntToStr(inMsg.m_swLen));
              ////////////Складываем все ответы в буфер не заходя в протокол///////////
             SetLength(inBuff^, Length(inBuff^) + 1);
             inBuff^[High(inBuff^)] := inMsg;
             ////////////////////////////////////////////////////////////////////////
             break;
            end;
         end
         else begin
           Result := -1;
         end;
        End;
        //Connect Error
        if Result=2 then
        Begin
          with meter.m_nP do
          begin
          pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
          pDb.addErrorArch(M_SWABOID,m_swMID);
          end;
         SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG Skip. Error In Channel!!! ');
         break;
        End;
        inc(i);
        if i>meter.m_nP.m_sbyRepMsg then
        Begin
         with meter.m_nP do
         begin
          pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
          pDb.addErrorArch(M_SWABOID,m_swMID);
         end;
         Result := -1;
         break;
        End;        //Repeat message if not get
        connection.put(outMsg);
        SendEventBoxMessage(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU.RunAsync Repeat '+IntToStr(i)+' of '+IntToStr(meter.m_nP.m_sbyRepMsg)+'    MSG:>',outMsg);
      End;
     End else
     Begin
      index := index + 1;
     End;
End;

function CMeterTaskSSDU.noputAsync: Integer;
begin
  Result := -1;
  if outMsg.m_swLen = 0 then begin
    if not meter.send(outMsg) then Exit;
  end;
  if outMsg.m_swLen = 0 then Exit;
  if state=TASK_STATE_KIL then Begin
    SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU TASK ASYNC KILLED!!!');
    exit;
  End;
  SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU MSG noPUT ASYNC Complette... MSG:>',outMsg);
end;

function CMeterTaskSSDU.getOutMsg:Integer;
begin
  Result := -1;
  FillChar(outMsg, SizeOf(outMsg), 0);
  if not meter.send(outMsg) then Exit;
  Result := 0;
end;

procedure CMeterTaskSSDU.SendEventBox(_Type : Byte; _Message : String);
Var
  s   : string;
  ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(_Type,_Message);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
End;

procedure CMeterTaskSSDU.SendEventBoxMessage(_Type : Integer; _Message : String; msg : CMessage);
Var s  : string;
    ID : Integer;
//    byBuff : PByteArray;
//    str    : String;
//    i      : Integer;
Begin
  try
   ID := 0;
   s := SenderClass.ToStringBoxMsg(_Type,_Message, msg);

//   str:='';
//   byBuff := @msg;
//    for i:=0 to msg.m_swLen-1 do str := str + IntToHex(byBuff[i], 2) + ' ';
//   s := SenderClass.ToStringBox(_Type,_Message + ' '+ str);
   ID := GetCurrentThreadID;
   SenderClass.Send(QL_QWERYBOXEVENTMSG,EventBoxHandle,ID,s);
  except
    s:='';
    s := SenderClass.ToStringBox(_Type,'Error CMeterTaskGlobal.SendEventBoxMessage!'); 
    ID := GetCurrentThreadID;
    SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
  end;
End;

constructor CHouseTaskSSDU.Create(vDtBegin,vDtEnd:TDateTime;
                              vCmd:Integer;
                              vGid :Integer;
                              vAid :Integer;
                              vMid :Integer;
                              vIsFind : Integer;
                              vErrorPercent : double;
                              vTimeToStop    : TDateTime;
                              vPortPull:TThreadList;
                              vTaskIndex:Integer;
                              var vMeterPull:CThreadPull;
                              var vParent : IRunnable);
Begin
      if SenderClass<>Nil then SenderClass := TSenderClass.Create;
      dtBegin      := vDtBegin;
      dtEnd        := vDtEnd;
      cmd          := vCmd;
      gid          := vGid;
      aid          := vAid;
      mid          := vMid;
      isFind       := vIsFind;
      portPull     := vPortPull;
      meterPull    := vMeterPull;
      id           := aid;
      state        := TASK_STATE_RUN;
      parent       := vParent;
      ErrorPercent := vErrorPercent;
      TimeToStop   := vTimeToStop;      
End;

destructor CHouseTaskSSDU.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;

function CHouseTaskSSDU.getAboID:integer;
Begin
    Result := aid;
End;

function CHouseTaskSSDU.getParamID:integer;
Begin
    Result := cmd;
End;

function CHouseTaskSSDU.run:Integer;
Var
    objs     : array of CTaskObjects;
    i,j      : Integer;
    pTbl     : SQWERYMDL;
    pDb      : CDBDynamicConn;
    data     : TThreadList;
    vList    : TList;
    pull     : CPortPull;
    res      : Integer;
    connection : IConnection;
    findData,isclose : Boolean;
    dateEnd,dateEndSSDU  : TDateTime;
    ResDoz   : Integer;
    TimeInterval : Double;
    TimeCounter  : TDateTime;
    TimeStartProc : TDateTime;
    IDCHANNELGSM  : Integer;
    CPORT         : Integer;
Begin
  try
    try
      TimeInterval := TimeToStop - trunc(TimeToStop);//StrToTime('00:15:00');
      isclose  := False;
      findData := False;
      res    := 0;
      Result := 0;
      ResDoz := 0;
      i      := 0;
      CPORT  := 0;
      vList    := nil;
      SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU Begin...');
      data := TThreadList.Create;
      pDb  := m_pDB.getConnection;
      pDb.GetAbonL2Join(gid,aid,data);
      if (cmd=QRY_NAK_EN_MONTH_EP)then
       if ((isFind=0)and(mid=-1)) then pDb.DelArchData(dtEnd,dtBegin,aid,cmd);

      pDb.setQueryState(aid,mid,QUERY_STATE_NO);
      vList := data.LockList;
      SetLength(objs, vList.count);
      dateEnd:=now;
      if (cmd=QRY_LOAD_ALL_PARAMS) then pDb.setDtBeginEndInQueryQroup(aid,now,dateEnd,TASK_QUERY_PROG)else
      pDb.setDtBeginEndInQueryQroup(aid,now,dateEnd,TASK_QUERY_WAIT);
      
      if (vList.count>0) then
      Begin
       objs[0].pD := vList[0];
       pull := getPortPull(objs[0].pD.m_swPullID);
       if pull=nil then exit;
       IDCHANNELGSM := 0;
       connection := pull.getConnection(IDCHANNELGSM);
       pDb.SetChannelGSM(aid,IDCHANNELGSM,CPORT);//записать по номеру порта связи номер порта     
       connection.clearHistory;
      End;
      SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU Device Received.');
    except
     SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_SSDU TASK ERROR!!!');
     exit;
    end;
      //for i:=0 to vList.count-1 do
      while i<vList.count do
       Begin
        try
        if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL)   then
          Begin
           SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_SSDU TASK KILLED!!!');
           //pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);
           res:=4;
           ResDoz:=2;       
           exit;
          End;
          objs[i].pD := vList[i];
          pTbl.m_snAID  := aid;
          pTbl.m_snVMID := objs[i].pD.m_swVMID;
          pTbl.m_snMID  := objs[i].pD.m_swMID;
          if(mid<>-1) then
          Begin
           if (mid<>objs[i].pD.m_swMID) then continue;
          End;
          if (i=0)then begin objs[i].pDM  := CDBDynamicConn.Create(); objs[i].pDM.Create(objs[i].pDM.InitStrFileName); end //objs[i].pDM := m_pDB.getConnection
          else objs[i].pDM := objs[0].pDM;
          objs[i].meter := getL2Instance(objs[0].pDM,pTbl.m_snMID);
          if cmdToCls(cmd)=CLS_MGN then
          objs[i].meter.PObserver.LoadParamQS(cmd) else
          Begin
           objs[i].pHF  := CHolesFinder.Create(pDb);
           objs[i].pump := CDataPump.Create(nil,objs[i].pHF,objs[i].meter,@pTbl,cmd);
           if isFind=1 then findData := objs[i].pump.PrepareFind(dtBegin,dtEnd,pTbl.m_snVMID,cmdToCls(cmd));
           objs[i].pump.SetPump(dtBegin,dtEnd,pTbl.m_snMID,cmdToCls(cmd),0);
           objs[i].pump.Start;
           while(objs[i].pump.Next) do;
          End;
           SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU QUERY meter №:'+IntToStr(objs[i].meter.m_nP.m_swMID)+' kv №:'+objs[i].meter.m_nP.m_sddPHAddres);
           if ((isFind=1) and (findData=false)) then with objs[i].meter.m_nP do pDb.setQueryState(aid,m_swMID,QUERY_STATE_OK);
           if (isFind=0) or ((isFind=1) and (findData=true)) then
           Begin

            if isManyErrors(pDb,aid,ErrorPercent) then
            Begin
             pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR);
             SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+objs[i].meter.m_nP.m_sddPHAddres+')CHouseTask_SSDU SKIP Query Connection=ERR:>Many Errors In House!!!');
             res:=3;
             exit;
            End;
              if (i>5)then    //если мы опрашиваем ССДУ то после 5 полученных ответов не надо занаво устанавливать коннект
             begin
               SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+objs[i].meter.m_nP.m_sddPHAddres+')CHouseTask_SSDU RUN Parce!!!');
             end
             else
             begin
             if (i=0) then
               pDb.setDtBeginEndInQueryQroup(aid,now,now,CALL_STATE);//Состояние вызова
               connection.iconnect(objs[i].meter.m_nP.m_sPhone);
             end;

            connection.iconnect(objs[i].meter.m_nP.m_sPhone);
            if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_CONN) then
               TimeStartProc := Now
            else
              if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_ERR) then
                Begin
                 SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+objs[i].meter.m_nP.m_sddPHAddres+')CHouseTask_SSDU SKIP Query Connection=ERR:>');
                 if objs[0].pDM<>Nil then begin objs[0].pDM.Disconnect; FreeAndNil(objs[0].pDM); end;
                 res:=2;
                 ResDoz:=1;
                 exit;
                End;

            TimeCounter := Now;
            if TimeStartProc + TimeInterval < TimeCounter then
            exit;

            if (i=0) and (connection.getConnectionState=PULL_STATE_CONN) then
               pDb.setDtBeginEndInQueryQroup(aid,now,0,TASK_QUERY);//НАЧАЛО ОПРОСА

               objs[i].runnble := CMeterTaskSSDU.Create(objs[i].meter,IRunnable(self),connection);

              if (vList.Count - 1>=6)then
               begin
               if ((i mod 1) = 0)or (i = vList.Count - 1)  then
                begin
                 // Запрос с ожиданием ответа (на несколько предыдущих)
                 objs[i].runnble.getIntBuffer(objs[i].meter.test_massiv);
                 SetLength(objs[i].meter.test_massiv^,3);
                 if (i=5) then
                   begin
                    objs[i].meter.test_massiv^[1]:=254;  // берем последние номер канала
                    objs[i].res := objs[i].runnble.runAsyncSSDU();  //складываем все ответы не заходя в протокол счетчика
                    if (objs[i].res=2) then  continue;
                   end
                 else
                   if (i>5) then //после 5 запроса разбераем полученные ответы
                    begin
                       objs[i].meter.m_nT.B2 := False; // Вторичный признак успешности опроса
                       if (i=6) then
                          begin
                            isclose:=True;
                            if (connection<>nil) then connection.iclose;
                            dateEndSSDU:=now;
                            pDb.setDtEndInQueryQroup(aid,dateEndSSDU,DATA_PROCESSING); //КОНЕЦ ОПРОСА И ОБРАБОТКА ДАННЫХ
                            for j := 0 to 5 do
                              if (objs[j].res<>0) then
                                begin
                                 objs[j].meter.m_nT.B2 := False;
                                 SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU BUFFER meter №:'+IntToStr(objs[j].meter.m_nP.m_swMID)+' kv №:'+objs[j].meter.m_nP.m_sddPHAddres);
                                 // Попытка найти нужные ответы из последнего буфера ответов
                                // objs[j].res := objs[j].runnble.findAsyncSSDU();  // ищем нужные ответы из буфера ответов
                                end;
                          end;
                          objs[i].res:=objs[i].runnble.noputAsync(); // Формирование запроса без отправки в канал
                          SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU BUFFER meter №:'+IntToStr(objs[j].meter.m_nP.m_swMID)+' kv №:'+objs[j].meter.m_nP.m_sddPHAddres);
                          // Попытка найти нужные ответы из последнего буфера ответов
                          //objs[i].res := objs[i].runnble.findAsyncSSDU();  // ищем нужные ответы из буфера ответов
                    end
                   else if (i<5) then
                    begin
                      objs[i].meter.test_massiv^[1]:=objs[i].meter.test_massiv^[1]+50; //Каналы начинаются с 1 (1 указали в протоколе), а здесь от i добавляем +2
                      objs[i].res := objs[i].runnble.runAsyncSSDU(); //складываем все ответы не заходя в протокол счетчика
                      if (objs[i].res=2) then  continue;
                      objs[i].meter.test_massiv^[0]:=objs[i].meter.test_massiv^[1];
                    end
                end;
               end
              else    //если счетчиков на ссду меньше чем 6
             begin
              objs[i].meter.m_nT.B1 := true;          //Параметр определяюший опрос по одному каналу если счетчиков заведено меньше чем 6
              objs[i].res := objs[i].runnble.run();
             end;
            //res := res;
            inc(i);
           End
           else inc(i);
        except
         pDb.setQueryState(aid,objs[i].meter.m_nP.m_swMID,QUERY_STATE_ER);
         pDb.addErrorArch(aid,objs[i].meter.m_nP.m_swMID);
         SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_SSDU Error in meter №:'+IntToStr(objs[i].meter.m_nP.m_swMID)+' kv №:'+objs[i].meter.m_nP.m_sddPHAddres);
         inc(i);
        end;
       End;
  finally
     if (res=0) or (res=-1) then
      pDb.setDtEndInQueryQroup(aid,now,TASK_QUERY_COMPL)    //КОНЕЦ ОПРОСА
     else
     if (res=2)then pDb.setDtEndInQueryQroup(aid,now,TASK_CONN_ERR)
     else
     if (res=3)then pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR)
     else
      if (res=4)then pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);

     for i := Low(objs) to High(objs) do begin
       if i=0 then  if objs[0].pDM<>Nil then begin objs[0].pDM.Disconnect; FreeAndNil(objs[0].pDM); end;
       if objs[i].runnble<>nil then FreeAndNil(objs[i].runnble);//objs[i].runnble.Destroy;
       if objs[i].pHF<>nil then FreeAndNil(objs[i].pHF);//objs[i].pHF.Destroy;
       if objs[i].pump<>nil then FreeAndNil(objs[i].pump);//objs[i].pump.Destroy;
       if objs[i].meter<>nil then FreeAndNil(objs[i].meter);//objs[i].meter.Destroy;
      // if objs[i].pD<>nil then  FreeAndNil(objs[i].pD);//objs[i].pD.Destroy;
     end;

     SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU End.');
     if (vList<>nil)then
     begin
      data.UnLockList;
      i:=0;
      while i < vList.Count do
        begin
         objs[i].pD := vList[i];
         if objs[i].pD<>Nil then FreeAndNil(objs[i].pD);
         vList.Delete(i);
        end;
      FreeAndNil(data);
     end;

     pDb.SetResetChannelGSM(aid,-1);//записать по номеру порта связи номер порта
     if pDb<>Nil then begin pDb.Disconnect; FreeAndNil(pDb); end;
     if (isclose=false)then if (connection<>nil) then connection.iclose;
  end;
  Result:=ResDoz;
End;

procedure CHouseTaskSSDU.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     s   : string;     
     ID : Integer;     
Begin
     ID := 0;
     ID := GetCurrentThreadID;
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snABOID  := m_snABOID;  //ID HOUSE
     sQC.m_snSRVID  := snSRVID;    //id группы
     sQC.m_snCLID   := m_snCLID;   //Kol-vo опрошенных
     sQC.m_snCLSID  := m_snCLSID;   //Kol-vo не опрошенных
     sQC.m_snCmdID  := nCommand;   //команда  о состоянии
     sQC.m_snVMID   := m_snVMID;   //Номер порта
     sQC.m_sdtBegin := sdtBegin;   //начало времени группы
     sQC.m_sdtEnd   := sdtEnd;     //конец времени группы

     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
     s := SenderClass.ToString(sQC);
     SenderClass.Send(QL_QWERYSTATISTICABON_REQ,TQweryModuleHandle,ID,s);
End;

procedure CHouseTaskSSDU.SendEventBox(_Type : Byte; _Message : String);
Var
  s   : string;
  ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(_Type,_Message);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
End;

function CHouseTaskSSDU.isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
Var
    data : QGABONS;
    quality : double;
Begin
    data := QGABONS.Create;
    data.ALLCOUNTER := 1000;
    data.ISOK := 0;
    data.ISER := 0;
    pDb.GetQueryAbonsError(aid,data);
    quality := 100*data.ISER/data.ALLCOUNTER;
    if quality>vErrorPercent then
    Begin
     Result := true;
     FreeAndNil(data);//data.Destroy;
     exit;
    End;
    FreeAndNil(data);//data.Destroy;
    Result := false;
End;

function CHouseTaskSSDU.getPortPull(plid:Integer):CPortPull;
Var
    vList : TList;
    i     : Integer;
    pD    : CPortPull;
begin
    Result := nil;
    vList := portpull.LockList;
    try
    for i:=0 to vList.Count-1 do
    Begin
     pD := vList[i];
     if pD.getPullID=plid then
     Begin
      Result := pD;
      exit;
     End;
    End;
    finally
     portPull.UnLockList;
    end;
end;

function CHouseTaskSSDU.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
Var
    meter  : CMeter;
    pTable : SL2TAG;
Begin
    if (dynConnect.GetMMeterTableEx(mid,pTable)) then
    Begin
     case pTable.m_sbyType of
        MET_USPDSSDU        : meter := SSDUBytMeters.Create;
     End;
    End;
    if meter<>nil then
    Begin
      meter.setDbConnect(dynConnect);
      meter.Init(pTable);
    End;
    Result := meter;
End;

function CHouseTaskSSDU.cmdToCls(cmd:Integer):Integer;
Begin
     if(((cmd>=QRY_ENERGY_SUM_EP) and (cmd<=QRY_ENERGY_SUM_EP)) or
        (cmd=QRY_DATA_TIME) or
        (cmd=QRY_LOAD_ALL_PARAMS) or
        ((cmd=QRY_ENTER_COM)or(cmd=QRY_EXIT_COM)) or
        ((cmd>=QRY_MGAKT_POW_S) and (cmd<=QRY_FREQ_NET))) then
     Begin
      Result := CLS_MGN;
      exit;
     End else
     if(((cmd>=QRY_ENERGY_DAY_EP) and (cmd<=QRY_ENERGY_DAY_RM)) or
        ((cmd>=QRY_NAK_EN_DAY_EP) and (cmd<=QRY_NAK_EN_DAY_RM))) then
     Begin
      Result := CLS_DAY;
      exit;
     End else
     if(((cmd>=QRY_ENERGY_MON_EP) and (cmd<=QRY_ENERGY_MON_RM)) or
        ((cmd>=QRY_NAK_EN_MONTH_EP) and (cmd<=QRY_NAK_EN_MONTH_RM))) then
     Begin
      Result := CLS_MONT;
      exit;
     End else
     if((cmd>=QRY_SRES_ENR_EP) and (cmd<=QRY_SRES_ENR_RM)) then
     Begin
      Result := CLS_GRAPH48;
      exit;
     End else
     if(cmd=QRY_DATA_TIME) then
     Begin
      Result := CLS_TIME;
      exit;
     End else
     if((cmd>=QRY_JRNL_T1) and (cmd<=QRY_JRNL_T4)) then
     Begin
      Result := CLS_EVNT;
      exit;
     End
End;

end.
