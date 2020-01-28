unit knsl2_HouseTask_SSDU_ONE_CHANEL;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3HolesFinder,knsl2qweryportpull,knsl2qweryarchmdl,
 knsl2meter,knsl2IRunnable,utldynconnect,knsl2CThreadPull,
 knsl2SSDUBytmeter,utlQueryQualityDyn,utlSendRecive;
 type

    CMeterTask_SSDU_ONE_Channel = class(IRunnable)
     private
      meter      : CMeter;
      outMsg     : CMessage;
      inMsg      : CMessage;
      connection : IConnection;
      m_sQC      : SQWERYCMDID; //для передачи сообщения
      SenderClass  : TSenderClass;
     public
      constructor Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
      destructor Destroy;override;
      function run(gid:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;//override;
      function getOutMsg:Integer;
      procedure SendEventBox(_Type : Integer; _Message : String);
      procedure SendEventBoxMessage(_Type : Integer; _Message : String; msg : CMessage);
    End;

    CHouseTask_SSDU_ONE_Channel = class(IRunnable)
     private
      dtBegin      : TDateTime;
      dtEnd        : TDateTime;
      cmd          : Integer;
      gid          : Integer;
      aid          : Integer;
      mid          : Integer;
      isFind       : Integer;
      ErrorPercent : double;
      ErrorPercent2: double;
      TimeToStop   : TDateTime;       
      meterPull    : CThreadPull;
      portPull     : TThreadList;
      taskUndex    : Integer;
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
      function getAboID:integer;
      function getParamID:integer;
      procedure QueryStateAbon(_pDb: CDBDynamicConn);
      constructor Create(vDtBegin,vDtEnd:TDateTime;
                              vCmd:Integer;
                              vGid :Integer;
                              vAid :Integer;
                              vMid :Integer;
                              vIsFind : Integer;
                              vErrorPercent : double;
                              vErrorPercent2: double;
                              vTimeToStop   : TDateTime;                                                      
                              vPortPull:TThreadList;
                              vTaskIndex:Integer;
                              var vMeterPull:CThreadPull;
                              var vParent : IRunnable);

      destructor Destroy;override;
      function run:Integer;override;
    End;

implementation
{$R+}
constructor CMeterTask_SSDU_ONE_Channel.Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
Begin
    if SenderClass<>Nil then SenderClass := TSenderClass.Create;
    meter    := value;
    id       := meter.m_nP.m_swMID;
    //portpull := vPortPull;
    state    := TASK_STATE_RUN;
    parent   := vParent;
    connection := vConnection;
End;

destructor CMeterTask_SSDU_ONE_Channel.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited Destroy;
    //if meter<>nil then meter.Destroy;
End;

function CMeterTask_SSDU_ONE_Channel.run(gid:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;
Var
    index      : Integer;
    i          : Integer;
    res        : boolean;
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
        SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU_ONE_Channel TASK KILLED!!!');
        exit;
       End;
       if(outMsg.m_swLen<>0) then
       Begin
        connection.put(outMsg);
        SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU_ONE_Channel MSG PUT Complette... MSG:>',outMsg);
        res := true;
        i   := 0;
        getResult := -1;
        while getResult<>0 do
        Begin
          getResult := connection.get(inMsg);
          if getResult=0 then
          Begin
           SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU_ONE_Channel MSG GET Complette... MSG:>',inMsg);
           if meter.EventHandler(inMsg) then
           Begin

               break;
           End else
           Begin
            //pDb.setDescQueryQroup(meter.m_nP.M_SWABOID,meter.m_nP.m_schName,'Кадр отброшен!',TASK_QUERY);

            getResult := -1;
           End;
          End;
          //Connect Error
          if getResult=2 then
          Begin
            with meter.m_nP do
            begin
              if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)then
               begin
                pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
                pDb.addErrorArch(M_SWABOID,m_swMID);
               end;
            end;
           SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU_ONE_Channel MSG Skip. Error In Channel!!! ');
           break;
          End;
          inc(i);
          if i>meter.m_nP.m_sbyRepMsg then
          Begin
           with meter.m_nP do
           begin
            if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)then
              begin
               pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
               pDb.addErrorArch(M_SWABOID,m_swMID);
              end; 
           end;
           getResult := -1;
           break;
          End;        //Repeat message if not get
          connection.put(outMsg);
          SendEventBoxMessage(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_SSDU_ONE_Channel.Run Repeat '+IntToStr(i)+' of '+IntToStr(meter.m_nP.m_sbyRepMsg)+'    MSG:>',outMsg);
        End;
       End else
       Begin
        index := index + 1;
       End;
      End; 
      //pDb.setDtEndInQueryQroup(meter.m_nP.M_SWABOID,Now,TASK_QUERY_COMPL);
      //connection.iclose;
      //pDb.Disconnect;
      //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(getId)+')CMeterTask STOP. '+IntToStr(index)+' msg. ');
      //except
    finally
     Result := getResult;
    end;
End;

function CMeterTask_SSDU_ONE_Channel.getOutMsg:Integer;
begin
  Result := -1;
  FillChar(outMsg, SizeOf(outMsg), 0);
  if not meter.send(outMsg) then Exit;
  Result := 0;
end;

procedure CMeterTask_SSDU_ONE_Channel.SendEventBox(_Type : Integer; _Message : String);
Var
  s   : string;
  ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(_Type,_Message);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
End;

procedure CMeterTask_SSDU_ONE_Channel.SendEventBoxMessage(_Type : Integer; _Message : String; msg : CMessage);
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

constructor CHouseTask_SSDU_ONE_Channel.Create(vDtBegin,vDtEnd:TDateTime;
                              vCmd:Integer;
                              vGid :Integer;
                              vAid :Integer;
                              vMid :Integer;
                              vIsFind : Integer;
                              vErrorPercent  : double;
                              vErrorPercent2 : double;                              
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
      ErrorPercent2:= vErrorPercent2;
      TimeToStop   := vTimeToStop;         
End;
destructor CHouseTask_SSDU_ONE_Channel.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;
function CHouseTask_SSDU_ONE_Channel.getAboID:integer;
Begin
    Result := aid;
End;
function CHouseTask_SSDU_ONE_Channel.getParamID:integer;
Begin
    Result := cmd;
End;
function CHouseTask_SSDU_ONE_Channel.run:Integer;
Var
    i,j      : Integer;
    pump     : CDataPump;
    pMT      : PCMeter;
    pTbl     : SQWERYMDL;
    meter    : CMeter;
    index    : Integer;
    runnble  : IRunnable;
    mettask  : CMeterTask_SSDU_ONE_Channel;
    pDb      : CDBDynamicConn;
    pDM      : CDBDynamicConn;
    pHF      : CHolesFinder;
    pTable   : SL2TAG;
    data     : TThreadList;
    vList    : TList;
    pD       : CJoinL2;
    pull     : CPortPull;
    res      : Integer;
    connection : IConnection;
    findData : Boolean;
    dateEnd,dateBegin  : TDateTime;
    ResDoz   : Integer;
    TimeInterval : Double;
    TimeCounter  : TDateTime;
    TimeStartProc : TDateTime;
    IDCHANNELGSM  : Integer;
    CPORT         : Integer;
    kol_N,kol_Y   : Integer;    
Begin
    try
     try
      TimeInterval := TimeToStop - trunc(TimeToStop);//StrToTime('00:15:00');
      Result:= 0;
      ResDoz:= 0;
      CPORT := 0;
      kol_N := 0;
      kol_Y := 0;       
      findData := False;
      res      := 0;
      runnble  := nil;
      vList    := nil;
      dateBegin:=now;    
      SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel Begin...');
      data := TThreadList.Create;
      pDb  := m_pDB.getConnection;
      pDb.GetAbonL2Join(gid,aid,data);

  //    if (cmd=QRY_DATA_TIME)then
  //      begin
  //       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel DATETIME NO REALIZE...');
  //       exit;
  //      end;

      if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)or (cmd=QRY_ENERGY_SUM_EP) then
        begin
          SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel Channel update begin data...');
          pDb.setQueryState(aid,mid,QUERY_STATE_NO);
        end;

      vList := data.LockList;
      dateEnd:=now;
      pDb.setDtBeginEndInQueryQroup(aid,now,dateEnd,TASK_QUERY_WAIT);

      if (vList.count>0) then
      Begin
       pD := vList[0];
       pull := getPortPull(pD.m_swPullID);
       if pull=nil then exit;
       IDCHANNELGSM := 0;
       connection := pull.getConnection(IDCHANNELGSM);
       pDb.SetChannelGSM(aid,IDCHANNELGSM,CPORT);//записать по номеру порта связи номер порта
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_WAIT,CPORT,now,dateEnd);
       connection.clearHistory;
      End;
      SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel Device Received.');
     except
      SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel TASK ERROR!!!');
      exit;
     end;
      while i<vList.count do
       Begin
        try
          if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL) then
          Begin
           SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel TASK KILLED!!!');
           pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
           res := 4;
           ResDoz:=2;
           exit;
          End;
          pD := vList[i];
          pTbl.m_snAID  := aid;
          pTbl.m_snVMID := pD.m_swVMID;
          pTbl.m_snMID  := pD.m_swMID;

          if(mid<>-1) then
          Begin
           if (mid<>pD.m_swMID) then continue;
          End;
          pDM  := CDBDynamicConn.Create();
          pDM.Create(pDM.InitStrFileName);

          meter := getL2Instance(pDM,pTbl.m_snMID);
          meter.m_nT.CMD:=cmd;//Присваем команду для отображения в Meter.run и др
          //Добавления параметра на чтения конфигурации узлов
          if (cmd<>QRY_DATA_TIME)then
           begin
            meter.PObserver.AddGraphParam(QRY_LOAD_ALL_PARAMS, 0, 1, 65, 1);
            meter.PObserver.AddGraphParam(QRY_LOAD_ALL_PARAMS, 1, 66, 130, 1);
            meter.PObserver.AddGraphParam(QRY_LOAD_ALL_PARAMS, 2, 131, 195, 1);
            meter.PObserver.AddGraphParam(QRY_LOAD_ALL_PARAMS, 3, 196, 255, 1);
           end;
          if cmdToCls(cmd)=CLS_MGN then
           begin
            if (cmd=QRY_ENERGY_SUM_EP)then
            begin
             meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
             meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
             meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
             meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
             meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
             meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
            end
            else
            meter.PObserver.LoadParamQS(cmd);
           end
          else
          Begin
           pHF  := CHolesFinder.Create(pDb);
           pump := CDataPump.Create(nil,pHF,meter,@pTbl,cmd);
           pump.SetPump(dtBegin,dtEnd,pTbl.m_snMID,cmdToCls(cmd),0);
           pump.Start;
           while(pump.Next) do;
          End;
          SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel QUERY meter №:'+IntToStr(meter.m_nP.m_swMID)+' kv №:'+meter.m_nP.m_sddPHAddres);
          if isManyErrors(pDb,aid,ErrorPercent) then
          Begin
             pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR);
             SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask_SSDU_ONE_Channel SKIP Query Connection=ERR:>Many Errors In House!!!');
             res := 3;         
             exit
          End;
          if (i=0) then
            begin
             pDb.setDtBeginEndInQueryQroup(aid,now,now,CALL_STATE);//Состояние вызова
             SendQSStatisticAbon(aid,gid,kol_Y,kol_N,CALL_STATE,CPORT,now,now);
            end;
          connection.iconnect(meter.m_nP.m_sPhone);
          if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_CONN) then
            TimeStartProc := Now
          else
          if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_ERR) then
           Begin
  //         pDb.setDtEndInQueryQroup(aid,now,TASK_CONN_ERR);
             SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask_SSDU_ONE_Channel SKIP Query Connection=ERR:>');
             res := 2;
             if pDM<>Nil then begin pDM.Disconnect; FreeAndNil(pDM); end;
             ResDoz:=1;
             exit;
           End;
          TimeCounter := Now;
          if TimeStartProc + TimeInterval < TimeCounter then  exit;
          if (i=0) and (connection.getConnectionState=PULL_STATE_CONN) then
           begin
            dateBegin:=now;
            pDb.setDtBeginEndInQueryQroup(aid,dateBegin,0,TASK_QUERY);//НАЧАЛО ОПРОСА
            SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,0);
           end
          else pDb.setDtBeginEndInQueryQroup(aid,dateBegin,now,TASK_QUERY);//НАЧАЛО ОПРОСА
          mettask := CMeterTask_SSDU_ONE_Channel.Create(meter,IRunnable(self),connection);
          res := mettask.run(gid,kol_Y,kol_N,CPORT,dateBegin);

          pDb.GetQueryAbonsIDDyn(gid,aid,kol_Y,kol_N);
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
          inc(i);
        except
         if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
         begin
          pDb.setQueryState(aid,meter.m_nP.m_swMID,QUERY_STATE_ER);
          pDb.addErrorArch(aid,meter.m_nP.m_swMID);
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);//+1
         end;
          SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel Error in meter №:'+IntToStr(meter.m_nP.m_swMID)+' kv №:'+meter.m_nP.m_sddPHAddres);
          if pDM<>nil then m_pDB.DiscDynconnect(pDM);
          if mettask<>nil then FreeAndNil(mettask); //mettask.Destroy;
          if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
          if pump<>nil then FreeAndNil(pump);//pump.Destroy;
          if meter<>nil then FreeAndNil(meter);//meter.Destroy;
         inc(i);
        end;
         if pDM<>nil then begin pDM.Disconnect; FreeAndNil(pDM); end;
         if mettask<>nil then FreeAndNil(mettask); //mettask.Destroy;
         if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
         if pump<>nil then FreeAndNil(pump);//pump.Destroy;
         if meter<>nil then FreeAndNil(meter);//meter.Destroy;
         i:= vList.Count;
       End;

    finally
     if pDM<>nil then begin pDM.Disconnect; FreeAndNil(pDM); end;
     if mettask<>nil then FreeAndNil(mettask); //mettask.Destroy;
     if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
     if pump<>nil then FreeAndNil(pump);//pump.Destroy;
     if meter<>nil then FreeAndNil(meter);//meter.Destroy;

     if (res=0) or (res=-1) then
        begin
         if (cmd=QRY_DATA_TIME)then
          begin
           pDb.setDtEndInQueryQroup(aid,now,TASK_DATE_TIME_COR); //Корректировка времени успешно завершена
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_DATE_TIME_COR,CPORT,dateBegin,now);
          end
         else
         begin
          pDb.setDtEndInQueryQroup(aid,now,TASK_QUERY_COMPL);    //КОНЕЦ ОПРОСА
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_COMPL,CPORT,dateBegin,now);          
         end;
        end
     else if (res=2)then
          begin
           pDb.setDtEndInQueryQroup(aid,now,TASK_CONN_ERR); //Ошибка соединения
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_CONN_ERR,CPORT,dateBegin,now);
          end
     else if (res=3)then
         begin
          pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR); //Превышен предел ошибок
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_MANY_ERR,CPORT,dateBegin,now);
         end
     else if (res=4)then
         begin
          pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);//Принудительно остановлен
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
         end;

     SendQSStatisticAbon(aid,gid,kol_Y,kol_N,DATA_PROCESSING,CPORT,dateBegin,now);
     QueryStateAbon(pDb);
     SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_SSDU_ONE_Channel End.');

     if (vList<>nil)then
       begin
        data.UnLockList;

        i:=0;
        while i < vList.Count do
          begin
           pD := vList[i];
           if pD<>Nil then FreeAndNil(pD);
           vList.Delete(i);
          end;
        FreeAndNil(data);
       end;

     pDb.SetResetChannelGSM(aid,-1);//записать по номеру порта связи номер порта     
     if pDb<>Nil then begin pDb.Disconnect; FreeAndNil(pDb); end;
     if (connection<>nil) then  connection.iclose;
     Result:=ResDoz;
    end;
End;

procedure CHouseTask_SSDU_ONE_Channel.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
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

procedure CHouseTask_SSDU_ONE_Channel.SendEventBox(_Type : Byte; _Message : String);
Var
  s   : string;
  ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(_Type,_Message);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
End;

procedure CHouseTask_SSDU_ONE_Channel.QueryStateAbon(_pDb: CDBDynamicConn);
var
    QQ  : TQueryQualityDyn;
    MDQ : TQQData;  // для месяца
    year, month, day :word;
    DateNow :TDateTime;
begin
  try
    try
     QQ := TQueryQualityDyn.Create;
     DecodeDate(Now, year, month, day);
      if (cmd=QRY_NAK_EN_MONTH_EP)then
         begin
         MDQ := QQ.GetQQMonths(_pDb,aid);  // получить только месяц
         DateNow := EncodeDate(year,month,1);
         end
      else if (cmd=QRY_NAK_EN_DAY_EP)then
        begin
        DateNow := EncodeDate(year,month,day);
        MDQ := QQ.GetQQDays(_pDb,aid);  // получить только месяц
        end
      else
        begin
        DateNow := EncodeDate(year,month,day);
        MDQ := QQ.GetQQCurrs(_pDb,aid);  // получить только месяц
        end;
       if (DateNow=dtBegin) then
         begin
          if (MDQ.Perc < ERRORPERCENT2) or (MDQ.Perc=255) then
           begin
             MDQ.Dats := dtBegin;             // дата опроса
             MDQ.Stat := 0;                  // не нужен
             MDQ.Perc := trunc(QQ.GetPercent(_pDb,aid)); //процент опрошенных из запроса
             if(cmd=QRY_NAK_EN_MONTH_EP)then
             QQ.SetQQMonths(_pDb,aid, MDQ)   // сохранить только месяц (остальные значения останутся неизменными)
             else if (cmd=QRY_NAK_EN_DAY_EP)then
             QQ.SetQQDays(_pDb,aid, MDQ)     // сохранить только день  (остальные значения останутся неизменными)
             else if (cmd=QRY_ENERGY_SUM_EP)then
             QQ.SetQQCurrs(_pDb,aid, MDQ);    // сохранить только текущая  (остальные значения останутся неизменными)
           end;
         end
       else
         begin
           if (dtBegin=MDQ.Dats)then
            begin
             if (MDQ.Perc < ERRORPERCENT2) or (MDQ.Perc=255) then
               begin
                MDQ.Dats := dtBegin;             // дата опроса
                MDQ.Stat := 0;                  // не нужен
                MDQ.Perc := trunc(QQ.GetPercent(_pDb,aid)); //процент опрошенных из запроса
                if(cmd=QRY_NAK_EN_MONTH_EP)then
                QQ.SetQQMonths(_pDb,aid, MDQ)   // сохранить только месяц (остальные значения останутся неизменными)
                else if (cmd=QRY_NAK_EN_DAY_EP)then
                QQ.SetQQDays(_pDb,aid, MDQ)     // сохранить только день  (остальные значения останутся неизменными)
                else if (cmd=QRY_ENERGY_SUM_EP)then
                QQ.SetQQCurrs(_pDb,aid, MDQ);    // сохранить только текущая  (остальные значения останутся неизменными)
               end;
            end;
            if (dtBegin>MDQ.Dats)then
             begin
                MDQ.Dats := dtBegin;             // дата опроса
                MDQ.Stat := 0;                  // не нужен
                MDQ.Perc := trunc(QQ.GetPercent(_pDb,aid)); //процент опрошенных из запроса
                if(cmd=QRY_NAK_EN_MONTH_EP)then
                QQ.SetQQMonths(_pDb,aid, MDQ)   // сохранить только месяц (остальные значения останутся неизменными)
                else if (cmd=QRY_NAK_EN_DAY_EP)then
                QQ.SetQQDays(_pDb,aid, MDQ)     // сохранить только день  (остальные значения останутся неизменными)
                else if (cmd=QRY_ENERGY_SUM_EP)then
                QQ.SetQQCurrs(_pDb,aid, MDQ);    // сохранить только текущая  (остальные значения останутся неизменными)
             end;
            if (dtBegin<MDQ.Dats)then
             begin
               SendEventBox(ET_CRITICAL,'Запись качества процента не была произведена из-за dtBegin<MDQ.Dats');
             end;
         end;
   except
    SendEventBox(ET_CRITICAL,'ERROR CHouseTask_SSDU_ONE_Channel.QueryStateAbon!!!');
   end;
  finally
   FreeAndNil(QQ);
  end;
end;

function CHouseTask_SSDU_ONE_Channel.isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
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

function CHouseTask_SSDU_ONE_Channel.getPortPull(plid:Integer):CPortPull;
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

function CHouseTask_SSDU_ONE_Channel.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
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

function CHouseTask_SSDU_ONE_Channel.cmdToCls(cmd:Integer):Integer;
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
