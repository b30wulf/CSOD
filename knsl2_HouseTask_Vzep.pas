unit knsl2_HouseTask_Vzep;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3HolesFinder,knsl2qweryportpull,knsl2qweryarchmdl,
 knsl2meter,knsl3EventBox,knsl2IRunnable,utldynconnect,knsl2CThreadPull,
 knsl2EA8086Meter,utlQueryQualityDyn,utlSendRecive;
 type

    CMeterTaskVzep = class(IRunnable)
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
      procedure SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
     public
      constructor Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
      destructor Destroy;override;
      function run(gid,cmd_:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;//override;

      function getOutMsg:Integer;
      procedure getIntBufferADR(var V :PCIntBuffer);
    End;

    CHouseTaskVzep = class(IRunnable)
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
      inMessageBuffer : CMessageBuffer;
      intBuffer    : CIntBuffer;
      inBufferADR  : CIntBuffer;
      m_sQC        : SQWERYCMDID; //для передачи сообщения
      SenderClass  : TSenderClass;
     private
      function getPortPull(plid:Integer):CPortPull;
      function isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
      function cmdToCls(cmd:Integer):Integer;
      function getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
      procedure SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);      
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
constructor CMeterTaskVzep.Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
Begin
    if SenderClass<>Nil then SenderClass := TSenderClass.Create;
    meter    := value;
    id       := meter.m_nP.m_swMID;
    state    := TASK_STATE_RUN;
    parent   := vParent;
    connection := vConnection;
End;

destructor CMeterTaskVzep.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;

procedure CMeterTaskVzep.getInputBuffer(var V :PCMessageBuffer);
begin
  if parent is CHouseTaskVzep then
    V := @(CHouseTaskVzep(parent).inMessageBuffer)
  else V := nil;
end;
procedure CMeterTaskVzep.getIntBuffer(var V :PCIntBuffer);
begin
  if parent is CHouseTaskVzep then
    V := @(CHouseTaskVzep(parent).intBuffer)
  else V := nil;
end;

procedure CMeterTaskVzep.getIntBufferADR(var V :PCIntBuffer);
begin
  if parent is CHouseTaskVzep then
    V := @(CHouseTaskVzep(parent).inBufferADR)
  else V := nil;
end;

procedure CMeterTaskVzep.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
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

function CMeterTaskVzep.run(gid,cmd_:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;
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
    getIntBuffer(meter.test_massiv);

    while meter.send(outMsg) do
    Begin
     if state=TASK_STATE_KIL then
     Begin
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP TASK KILLED!!!');
      exit;
     End;
     if(outMsg.m_swLen<>0) then
     Begin
      connection.put(outMsg);
      if EventBox<>Nil then EventBox.FixMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP MSG PUT Complette... MSG:>',outMsg);
      res := true;
      i   := 0;
      getResult := -1;
      while getResult<>0 do
      Begin
        getResult := connection.get(inMsg);
           if (meter is CEA8086Meter) and(getResult=0) and(inMsg.m_swLen=16) and (inMsg.m_sbyInfo[0]=$2b) and (inMsg.m_sbyInfo[1]=$2b) and (inMsg.m_sbyInfo[2]=$2b) then    //если пришел пакет обрыва соединения помечаем что обрыв
                   begin                                                                                                           // и перепрограммируем
                    getResult := 2;
                    result:=getResult;
                    exit;
                   end;
        //Normal get
        if getResult=0 then
        Begin
         if EventBox<>Nil then EventBox.FixMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTaskVzep MSG GET Complette... MSG:>',inMsg);

         meter.m_nT.B2 := True; // Вторичный признак успешности опроса
         if meter.EventHandler(inMsg) then
         Begin
             if meter is CEA8086Meter then
              begin
               with meter.m_nP do
                 if (meter.State_8086=1) then
                  begin
                  pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
                  meter.State_8086:=0;
                  inc(kol_N);
                   if (cmd_=QRY_LOAD_ALL_PARAMS)then
                    SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
                   else
                   SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
                  end
                 else if (meter.State_8086=2)then
                   begin
                     getResult:=3;
                     exit;
                   end
                 else
                 begin
                  pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_OK);
                  inc(kol_Y);
                   if (cmd_=QRY_LOAD_ALL_PARAMS)then
                    SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
                   else
                   SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
                 end;
               if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP MSG GET Complette. Len:'+IntToStr(inMsg.m_swLen));
               break;
              end
             else
              begin
               if meter.m_nT.B2 then begin
               with meter.m_nP do begin
                pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_OK);
                inc(kol_Y);
                if (cmd_=QRY_LOAD_ALL_PARAMS)then
                 SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
                else
                SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
               end;
               if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP MSG GET Complette. Len:'+IntToStr(inMsg.m_swLen));
               end
               else begin
                 with meter.m_nP do begin
                  pDb.setQueryState(M_SWABOID, m_swMID, QUERY_STATE_ER);
                  inc(kol_N);
                  if (cmd_=QRY_LOAD_ALL_PARAMS)then
                   SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
                  else
                  SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
                 end;
               end;
               break;
              end;
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
           if (cmd_=QRY_LOAD_ALL_PARAMS)then
            SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
           else
           SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
          end;
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP MSG Skip. Error In Channel!!! ');
         break;
        End;
        inc(i);
        if i>meter.m_nP.m_sbyRepMsg then
        Begin
         with meter.m_nP do
         begin
          pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
          pDb.addErrorArch(M_SWABOID,m_swMID);
          if (cmd_=QRY_LOAD_ALL_PARAMS)then
           SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
          else
          SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
         end;
         getResult := -1;
         break;
        End;        //Repeat message if not get
        connection.put(outMsg);
        if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_VZEP.Run Repeat '+IntToStr(i)+' of '+IntToStr(meter.m_nP.m_sbyRepMsg)+'    MSG:>',outMsg);
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

function CMeterTaskVzep.getOutMsg:Integer;
begin
  Result := -1;
  FillChar(outMsg, SizeOf(outMsg), 0);
  if not meter.send(outMsg) then Exit;
  Result := 0;
end;


constructor CHouseTaskVzep.Create(vDtBegin,vDtEnd:TDateTime;
                              vCmd:Integer;
                              vGid :Integer;
                              vAid :Integer;
                              vMid :Integer;
                              vIsFind : Integer;
                              vErrorPercent : double;
                              vErrorPercent2: double;
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
destructor CHouseTaskVzep.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;
function CHouseTaskVzep.getAboID:integer;
Begin
    Result := aid;
End;
function CHouseTaskVzep.getParamID:integer;
Begin
    Result := cmd;
End;
function CHouseTaskVzep.run:Integer;
Var
    i        : Integer;
    pump     : CDataPump;
    pTbl     : SQWERYMDL;
    meter    : CMeter;
    mettask  : CMeterTaskVzep;
    pDb      : CDBDynamicConn;
    pDM      : CDBDynamicConn;
    pHF      : CHolesFinder;
    data     : TThreadList;
    vList    : TList;
    pD       : CJoinL2;
    pull     : CPortPull;
    res,reg      : Integer;
    connection : IConnection;
    //findData : Boolean;
    dateEnd,dateBegin  : TDateTime;
    ResDoz   : Integer;
    TimeInterval  : Double;
    TimeCounter   : TDateTime;
    TimeStartProc : TDateTime;
    IDCHANNELGSM  : Integer;
    CPORT         : Integer;
    kol_N,kol_Y   : Integer;

Begin
    try
    TimeInterval  := TimeToStop - trunc(TimeToStop);//StrToTime('00:15:00');
    TimeStartProc := EncodeDate(2000, 01, 01)+ EncodeTime(00, 00, 00, 000);//EncodeDateTime(2000, 01, 01, 00, 00, 00, 000);
    reg:=0;
    Result:=0;
    ResDoz:=0;        
    res  := 0;
    i    := 0;
    CPORT :=0;
    kol_N := 0;
    kol_Y := 0;
    vList    := nil;
    dateBegin:=now;     
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_VZEP Begin...');
    data := TThreadList.Create;
    pDb  := m_pDB.getConnection;
    pDb.GetAbonL2Join(gid,aid,data);
      if (cmd=QRY_LOAD_ALL_PARAMS) then
      begin
       if EventBox<>Nil then
         EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_VZEP Программирование.');
//      data.LockList.Count:=1;
      end;
    if (cmd=QRY_NAK_EN_MONTH_EP)then  pDb.DelArchData(dtEnd,dtBegin,aid,cmd);

    pDb.setQueryState(aid,mid,QUERY_STATE_NO);
    vList := data.LockList;

    dateEnd:=now;
    if (cmd=QRY_LOAD_ALL_PARAMS) then
      pDb.setDtBeginEndInQueryQroup(aid,now,dateEnd,TASK_QUERY_WAIT_PROG)
    else
      begin
      pDb.setDtBeginEndInQueryQroup(aid,now,dateEnd,TASK_QUERY_WAIT);
    end;

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
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_VZEP Device Received.');

    while i<vList.count do
     Begin
      try
      if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL)   then
      Begin
       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_VZEP TASK KILLED!!!');
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);       
       res:=4;
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
      pDM := m_pDB.getConnection;
      meter := getL2Instance(pDM,pTbl.m_snMID);
       if cmdToCls(cmd)=CLS_MGN then
        meter.PObserver.LoadParamQS(cmd)
       else
        Begin
         pHF  := CHolesFinder.Create(pDb);
         pump := CDataPump.Create(nil,pHF,meter,@pTbl,cmd);
         //if isFind=1 then findData := pump.PrepareFind(dtBegin,dtEnd,pTbl.m_snVMID,cmdToCls(cmd));
         pump.SetPump(dtBegin,dtEnd,pTbl.m_snMID,cmdToCls(cmd),0);
         pump.Start;
         while(pump.Next) do;
        End;
       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_VZEP QUERY meter №:'+IntToStr(meter.m_nP.m_swMID)+' kv №:'+meter.m_nP.m_sddPHAddres);


        if isManyErrors(pDb,aid,ErrorPercent) then
        Begin
         if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask SKIP Query Connection=ERR:>Many Errors In House!!!');
         res:=3;
         exit;
        End;
          if (i=0) then
          begin
           pDb.setDtBeginEndInQueryQroup(aid,now,now,CALL_STATE);//Состояние вызова
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,CALL_STATE,CPORT,now,now);           
          end;

        connection.iconnect(meter.m_nP.m_sPhone);
        if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_CONN) then
           begin
           if (TimeStartProc = (EncodeDate(2000, 01, 01)+ EncodeTime(00, 00, 00, 000)))then
            TimeStartProc := Now;
           end
        else           
        if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_ERR) then
          Begin
           res:=2;
           if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask_VZEP SKIP Query Connection=ERR:>');
             if (cmd=QRY_LOAD_ALL_PARAMS)then
             begin
               res:=5;
             end;
           m_pDB.DiscDynconnect(pDM);
           ResDoz:=1;
           exit;
          End;

        TimeCounter := Now;
        if TimeStartProc + TimeInterval < TimeCounter then
        exit;
//        connection.iconnect(meter.m_nP.m_sPhone);
        if (connection.getConnectionState=PULL_STATE_CONN) and (cmd=QRY_LOAD_ALL_PARAMS) then
           begin
           dateBegin:=now;
           pDb.setDtBeginEndInQueryQroup(aid,dateBegin,0,TASK_QUERY_PROG);//НАЧАЛО ПРОГРАММИРОВАНИЯ
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,0);
           end
        else
        if (i=0) and (connection.getConnectionState=PULL_STATE_CONN) then
          begin
           dateBegin:=now;
           pDb.setDtBeginEndInQueryQroup(aid,dateBegin,0,TASK_QUERY);//НАЧАЛО ОПРОСА
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,0);           
          end
        else pDb.setDtBeginEndInQueryQroup(aid,dateBegin,now,TASK_QUERY);//НАЧАЛО ОПРОСА
           mettask := CMeterTaskVzep.Create(meter,IRunnable(self),connection);
          if (i=0) then
             begin
               mettask.getIntBufferADR(meter.test_massiv_ADR);
               pDb.setADR(aid,meter.test_massiv_ADR);
               res := mettask.run(gid,cmd,kol_Y,kol_N,CPORT,dateBegin);
                if (res=2) then
                    begin
                      if (cmd=QRY_LOAD_ALL_PARAMS) then
                        begin
                        if (reg<=2)then
                        begin
                          inc(reg);
                          mettask.meter.PObserver.ClearGraphQry;
                          pDb.setQueryState(aid,-1,QUERY_STATE_NO);//помечает как не опрашивался
                          pDb.setDtBeginEndInQueryQroup(aid,now,now,TASK_QUERY_PROG);
                          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now);//+1
                          continue;
                        end
                        else break;
                        end
                      else continue;
                    end
                else if(res=3)then
                  begin
                   res:=6;
                   Continue;
                  end;
             end
          else
             begin
               mettask.getIntBufferADR(meter.test_massiv_ADR);
               res := mettask.run(gid,cmd,kol_Y,kol_N,CPORT,dateBegin);
                 if (res=2) then
                 begin
                   if (reg<=2)then //кол-во передозвонов
                   begin
                     inc(reg);
                     mettask.meter.PObserver.ClearGraphQry; //чистим задачи на опрос
                   end
                   else
                   begin
                     reg:=0;
                     inc(i);
                     continue; // идем на след. счетчик
                   end;
                 end
                 else
                    if (res=3)then
                    begin
                        res:=6;
                        Continue;
                    end;
             end;
      except
         pDb.setQueryState(aid,meter.m_nP.m_swMID,QUERY_STATE_ER);
         pDb.addErrorArch(aid,meter.m_nP.m_swMID);
         if (cmd=QRY_LOAD_ALL_PARAMS)then
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_PROG,CPORT,dateBegin,now)//+1
         else
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);//+1
          
         if pDM<>nil then m_pDB.DiscDynconnect(pDM);
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_VZEP Error in meter №:'+IntToStr(meter.m_nP.m_swMID)+' kv №:'+meter.m_nP.m_sddPHAddres);

         if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
         if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
         if pump<>nil then FreeAndNil(pump);//pump.Destroy;
         if meter<>nil then FreeAndNil(meter);//meter.Destroy;
         inc(i);
      end;

      if pDM<>nil then m_pDB.DiscDynconnect(pDM);
      if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
      if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
      if pump<>nil then FreeAndNil(pump);//pump.Destroy;
      if meter<>nil then FreeAndNil(meter);//meter.Destroy;

      inc(i);
       if (cmd=QRY_LOAD_ALL_PARAMS)then
        i:= vList.Count;
     End;

    finally
     if (res=0) or (res=-1) then
       begin
        if (cmd=QRY_LOAD_ALL_PARAMS)then
        begin
         pDb.setDtEndInQueryQroup(aid,now,TASK_QUERY_PROG_COMPL);
         SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_PROG_COMPL,CPORT,dateBegin,now);
        end
        else
        begin
         pDb.setDtEndInQueryQroup(aid,now,TASK_QUERY_COMPL);    //КОНЕЦ ОПРОСА
         SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_COMPL,CPORT,dateBegin,now);         
        end;
       end
     else if (res=2)then begin
       pDb.setDtEndInQueryQroup(aid,now,TASK_CONN_ERR);
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_CONN_ERR,CPORT,dateBegin,now);
     end //Ошибка соединения
     else if (res=3)then begin
       pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR);
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_MANY_ERR,CPORT,dateBegin,now);
     end //Превышен предел ошибок
     else if (res=4)then begin
      pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);
      SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
     end//Принудительно остановлен
     else if (res=5)then begin
      pDb.setDtBeginEndInQueryQroup(aid,now,dateEnd,ERROR_PROG);
      SendQSStatisticAbon(aid,gid,kol_Y,kol_N,ERROR_PROG,CPORT,now,dateEnd);
     end//ошибка программирования
     else if (res=6)then begin
      pDb.setDtBeginEndInQueryQroup(aid,now,now,ERROR_NO_PROG);
      SendQSStatisticAbon(aid,gid,kol_Y,kol_N,ERROR_NO_PROG,CPORT,now,now);
     end;//Не программировался

     QueryStateAbon(pDb);
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_VZEP End.');

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
        vList:=nil;
       end;

     if pDM<>nil then m_pDB.DiscDynconnect(pDM);
     if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
     if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
     if pump<>nil then FreeAndNil(pump);//pump.Destroy;
     if meter<>nil then FreeAndNil(meter);//meter.Destroy;

     pDb.SetResetChannelGSM(aid,-1);//записать по номеру порта связи номер порта
     m_pDB.DiscDynConnect(pDb);
     if (connection<>nil) then  connection.iclose;
     Result:=ResDoz;
    end;
End;

procedure CHouseTaskVzep.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
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

procedure CHouseTaskVzep.QueryStateAbon(_pDb: CDBDynamicConn);
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
               if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Запись качества процента не была произведена из-за dtBegin<MDQ.Dats');
             end;
         end;
    except
     if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка! Запись качества процента не была произведена');
    end;
 finally
  if QQ<>Nil then FreeAndNil(QQ);
 end;
end;

function CHouseTaskVzep.isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
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
     data.Destroy;
     exit;
    End;
    data.Destroy;
    Result := false;
End;

function CHouseTaskVzep.getPortPull(plid:Integer):CPortPull;
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

function CHouseTaskVzep.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
Var
    meter  : CMeter;
    pTable : SL2TAG;
Begin
    if (dynConnect.GetMMeterTableEx(mid,pTable)) then
    Begin
      case pTable.m_sbyType of
         MET_EA8086        : meter := CEA8086Meter.Create;
      End;
    End;
     if meter<>nil then
      Begin
       meter.setDbConnect(dynConnect);
       meter.Init(pTable);
      End;
      Result := meter;
End;

function CHouseTaskVzep.cmdToCls(cmd:Integer):Integer;
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
