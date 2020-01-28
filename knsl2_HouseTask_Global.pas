unit knsl2_HouseTask_Global;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3HolesFinder,knsl2qweryportpull,knsl2qweryarchmdl,
 knsl2meter,knsl2IRunnable,utldynconnect,knsl2CThreadPull,
 knsl2ss101meter,    //Грансистема СС101: ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ СС301
 knsl2ss301f3meter,  //Грансистема СС301: ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ СС301
 knsl2ce6850meter,
 knsl2ce6822meter,
 knsl2ee8005meter, //ВЗЭП ЭЭ8003,ЭЭ8005,ЭЭ8007  : ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ
 knsl2BTIModule,   //КонусЕ
 knsl2a2000meter,  //КонусБыт
 knsl2MIRT1Meter,   //МИРТЕК вер.1
 knsl2MIRT1W2Meter, //МИРТЕК вер.2
 knsl2CE301BYMeter, //ЭНЕРГОМЕРА СЕ301
 knsl2CE102Meter,   //ЭНЕРГОМЕРА СЕ102
 knsl2CE208BYMeter, //ЭНЕРГОМЕРА СЕ208
 knsl2MES3meter,
 knsl2CE06005Meter,
 utlQueryQualityDyn,
 utlSendRecive;
 type

    CMeterTaskGlobal = class(IRunnable)
     private
      meter      : CMeter;
      outMsg     : CMessage;
      inMsg      : CMessage;
      connection : IConnection;
      m_sQC      : SQWERYCMDID; //для передачи сообщения
      SenderClass  : TSenderClass;
     protected
      procedure SendEventBox(_Type : Byte; _Message : String);
      procedure SendEventBoxMessage(_Type : Integer; _Message : String; msg : CMessage);      
     public
      constructor Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
      destructor  Destroy;override;
      function    run(gid:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;//override;
      function    getOutMsg:Integer;
    End;

    CHouseTaskGlobal = class(IRunnable)
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
      function  getAboID:integer;
      function  getParamID:integer;
      procedure QueryStateAbon(_pDb: CDBDynamicConn);
      constructor Create(vDtBegin,vDtEnd:TDateTime;
                              vCmd:Integer;
                              vGid :Integer;
                              vAid :Integer;
                              vMid :Integer;
                              vIsFind : Integer;
                              vErrorPercent  : double;
                              vErrorPercent2 : double;
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
constructor CMeterTaskGlobal.Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection);
Begin
    if SenderClass<>Nil then SenderClass := TSenderClass.Create;
    meter    := value;
    id       := meter.m_nP.m_swMID;
    //portpull := vPortPull;
    state    := TASK_STATE_RUN;
    parent   := vParent;
    connection := vConnection;
End;

destructor CMeterTaskGlobal.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited Destroy;
End;

function CMeterTaskGlobal.run(gid:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;
Var
    index      : Integer;
    i          : Integer;
    res        : boolean;
    getResult  : Integer;
    pDb        : CDBDynamicConn;
    getHandler,getLonadler : Boolean;
Begin
    index := 0;
    getResult := -1;
    getHandler:= False;
    getLonadler:= False;
    try
      pDb  := meter.getDbConnect;
      while meter.send(outMsg) do
      Begin
       if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL)then
       Begin
        SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global TASK KILLED!!!');
        exit;
       End;
       if(outMsg.m_swLen<>0) then
       Begin
        connection.put(outMsg);
        SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global MSG PUT Complette... MSG:>',outMsg);
        res := true;
        i   := 0;
        getResult := -1;
       //ДЛЯ СЕ301 ПАРАМЕТР ДЛЯ ЗАКРЫТИЯ СОЕДИНЕНИЯ БЕЗ ОЖИДАНИЯ ОТВЕТА/////
        if(outMsg.m_sbyTypeIntID= 3)then
          begin
           getResult:=0;
          end
       //////////////////////////////////////////////////////////////////////
        else
        while getResult<>0 do
        Begin
          getResult := connection.get(inMsg);
          if getResult=0 then
          Begin
           SendEventBoxMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global MSG GET Complette... MSG:>',inMsg);
           if meter.EventHandler(inMsg) then
           Begin
               with meter.m_nP do
                begin
                 if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)or(meter.m_nT.CMD=QRY_U_PARAM_A)or(meter.m_nT.CMD=QRY_I_PARAM_A)then
                  begin
                   pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_OK);
                   if (getHandler=false) then
                   begin
                     getHandler:=True;
                     inc(kol_Y);
                   end;
                  end;
                 SendEventBox(ET_RELEASE,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global MSG GET Complette. Len:'+IntToStr(inMsg.m_swLen));
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
             if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)then
              begin
                pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
                pDb.addErrorArch(M_SWABOID,m_swMID);
                if (getLonadler=False)then
                inc(kol_N);
              end;  
            end;
           SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global MSG Skip. Error In Channel!!! ');
           break;
          End;
          inc(i);

          if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL)then
           Begin
            SendEventBox(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global TASK KILLED!!!');
            exit;
           End;
          if i>meter.m_nP.m_sbyRepMsg then
          Begin
           with meter.m_nP do
           begin
             if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)then
              begin
               pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
               pDb.addErrorArch(M_SWABOID,m_swMID);
               if (i=1)then
               inc(kol_N);
              end; 
           end;
           getResult := -1;
           break;
          End;        //Repeat message if not get
          connection.put(outMsg);
          SendEventBoxMessage(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask_Global.Run Repeat '+IntToStr(i)+' of '+IntToStr(meter.m_nP.m_sbyRepMsg)+'    MSG:>',outMsg);
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

procedure CMeterTaskGlobal.SendEventBox(_Type : Byte; _Message : String);
Var
  s   : string;
  ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(_Type,_Message);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
End;

procedure CMeterTaskGlobal.SendEventBoxMessage(_Type : Integer; _Message : String; msg : CMessage);
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

function CMeterTaskGlobal.getOutMsg:Integer;
begin
  Result := -1;
  FillChar(outMsg, SizeOf(outMsg), 0);
  if not meter.send(outMsg) then Exit;
  Result := 0;
end;

constructor CHouseTaskGlobal.Create(vDtBegin,vDtEnd:TDateTime;
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
destructor CHouseTaskGlobal.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;
function CHouseTaskGlobal.getAboID:integer;
Begin
    Result := aid;
End;
function CHouseTaskGlobal.getParamID:integer;
Begin
    Result := cmd;
End;
function CHouseTaskGlobal.run:Integer;
Var
    i        : Integer;
    pump     : CDataPump;
    pTbl     : SQWERYMDL;
    meter    : CMeter;
    index    : Integer;
    mettask  : CMeterTaskGlobal;
    pDb      : CDBDynamicConn;
    pDM      : CDBDynamicConn;
    pHF      : CHolesFinder;
    data     : TThreadList;
    vList    : TList;
    pD       : CJoinL2;
    pull     : CPortPull;
    res      : Integer;
    connection : IConnection;
    findData : Boolean;
    dateEnd,dateBegin  : TDateTime;
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
      findData := False;
      res      := 0;
      CPORT    := 0;
      kol_N    := 0;
      kol_Y    := 0;    
      vList    := nil;
      SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_Global Begin...');
      data := TThreadList.Create;
      pDb  := m_pDB.getConnection;
      pDb.GetAbonL2Join(gid,aid,data);
      if (cmd=QRY_NAK_EN_MONTH_EP)then
       if ((isFind=0)and(mid=-1)) then pDb.DelArchData(dtEnd,dtBegin,aid,cmd);

      if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
        if isFind=0 then
         pDb.setQueryState(aid,mid,QUERY_STATE_NO);
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
      SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_Global Device Received.');
    except
      SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_Global TASK ERROR!!!');
      exit;
    end;
      while i<vList.count do
       Begin
        try
          if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL) then
          Begin
           SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_Global TASK KILLED!!!');
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
           res := 4;
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
          meter.m_nT.CMD:=cmd;//Присваем команду для отображения в Meter.run и др
      
         if cmdToCls(cmd)=CLS_MGN then       //ДОбавить авторизацию для СE301
          begin
            if meter is CSS301F3Meter then       //Для СС301 параметры
              begin
              if (cmd=QRY_ENERGY_SUM_EP) then
              begin
                meter.PObserver.AddGraphParam(QRY_KPRTEL_KE, 0, 0, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 0, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 4, 0, 1);
              end
              else
              meter.PObserver.LoadParamQS(cmd);
              end
            else
            if meter is CCE102Meter then       //Для СЕ102 параметры
              begin
               if (cmd=QRY_ENERGY_SUM_EP) then
               begin
                meter.PObserver.LoadParamQS(cmd);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
                meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
               end; 
              end
            else
            if meter is CCE6822Meter then       //Для СЕ102 параметры
              begin
                if (cmd=QRY_ENERGY_SUM_EP) then
                begin
                  meter.PObserver.AddGraphParam(QRY_POINT_POS, 0, 0, 0, 1);
                  meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 1, 0, 1);
                  meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 2, 0, 1);
                  meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 3, 0, 1);
                  meter.PObserver.AddGraphParam(QRY_ENERGY_SUM_EP, 0, 4, 0, 1);
                end
                else
                meter.PObserver.LoadParamQS(cmd);
              end
            else
            if meter is CCE301BYMeter then       //Для СЕ301 параметры
              begin
                meter.PObserver.AddGraphParam(QRY_AUTORIZATION, 0, 0, 0, 1);
                meter.PObserver.AddGraphParam(QRY_AUTORIZATION, 1, 0, 0, 1);
                meter.PObserver.AddGraphParam(QRY_AUTORIZATION, 2, 0, 0, 1);
                meter.PObserver.LoadParamQS(cmd);
                meter.PObserver.AddGraphParam(QRY_EXIT_COM, 0, 0, 0, 1);
              end
            else
            if meter is CMIRT1Meter then       //Для СЕ301 параметры
              begin
                meter.PObserver.AddGraphParam(QRY_AUTORIZATION,0,0,0,1);
                meter.PObserver.LoadParamQS(cmd);
              end
            else
             begin
             meter.PObserver.LoadParamQS(cmd);
             end;
          end
         else
          Begin
           pHF  := CHolesFinder.Create(pDb);
           pump := CDataPump.Create(nil,pHF,meter,@pTbl,cmd);
           if isFind=1 then findData := pump.PrepareFind(dtBegin,dtEnd,pTbl.m_snVMID,cmdToCls(cmd));
           pump.SetPump(dtBegin,dtEnd,pTbl.m_snMID,cmdToCls(cmd),0);
           pump.Start;
           while(pump.Next) do;
          End;
         SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_Global QUERY meter №:'+IntToStr(meter.m_nP.m_swMID)+' kv №:'+meter.m_nP.m_sddPHAddres);
         if ((isFind=1) and (findData=false)) then
           with meter.m_nP do
            if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
             begin
              pDb.setQueryState(aid,m_swMID,QUERY_STATE_OK);
              inc(kol_Y);
              SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_WAIT,CPORT,dateBegin,now);
             end;

         if (isFind=0) or ((isFind=1) and (findData=true)) then
         Begin
          if isManyErrors(pDb,aid,ErrorPercent) then
          Begin
           pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR);
           SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask_Global SKIP Query Connection=ERR:>Many Errors In House!!!');
           res := 3;
           exit;
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
               SendEventBox(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask SKIP Query Connection=ERR:>');
               if pDM<>Nil then begin pDM.Disconnect; FreeAndNil(pDM); end;
               res:=2;
               //ResDoz:=1;
               exit;
            End;

          TimeCounter := Now;
          if TimeStartProc + TimeInterval < TimeCounter then
          exit;

  //        connection.iconnect(meter.m_nP.m_sPhone);
          if (i=0) and (connection.getConnectionState=PULL_STATE_CONN) then
            begin
             dateBegin:=now;
             pDb.setDtBeginEndInQueryQroup(aid,dateBegin,0,TASK_QUERY);//НАЧАЛО ОПРОСА
             SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,0);
            end
          else
           begin
            pDb.setDtBeginEndInQueryQroup(aid,dateBegin,now,TASK_QUERY);//НАЧАЛО ОПРОСА
            SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
           end;
             mettask := CMeterTaskGlobal.Create(meter,IRunnable(self),connection);
             res := mettask.run(gid,kol_Y,kol_N,CPORT,dateBegin);
             SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
          inc(i);
         End
         else inc(i);
        except
         if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
          begin
             pDb.setQueryState(aid,meter.m_nP.m_swMID,QUERY_STATE_ER);
             pDb.addErrorArch(aid,meter.m_nP.m_swMID);
             SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);//+1           
          end;
         SendEventBox(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask_Global Error in meter №:'+IntToStr(meter.m_nP.m_swMID)+' kv №:'+meter.m_nP.m_sddPHAddres);

         inc(i);
         if pDM<>nil then m_pDB.DiscDynconnect(pDM);
         if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
         if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
         if pump<>nil then FreeAndNil(pump);//pump.Destroy;
         if meter<>nil then FreeAndNil(meter);//meter.Destroy;
         if meter<>nil then FreeAndNil(pD);//pD.Destroy;
        end;
         if pDM<>nil then m_pDB.DiscDynconnect(pDM);
         if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
         if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
         if pump<>nil then FreeAndNil(pump);//pump.Destroy;
         if meter<>nil then FreeAndNil(meter);//meter.Destroy;
         if meter<>nil then FreeAndNil(pD);//pD.Destroy;
       End;
   finally
       if pDM<>nil then m_pDB.DiscDynconnect(pDM);
       if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
       if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
       if pump<>nil then FreeAndNil(pump);//pump.Destroy;
       if meter<>nil then FreeAndNil(meter);//meter.Destroy;
       if meter<>nil then FreeAndNil(pD);//pD.Destroy;
  
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
        pDb.setDtEndInQueryQroup(aid,now,TASK_CONN_ERR);
        SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_CONN_ERR,CPORT,dateBegin,now);        
       end
     else if (res=3)then
       begin
        pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR);
        SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_MANY_ERR,CPORT,dateBegin,now);
       end
     else if (res=4)then
     begin
      pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);
      SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
     end;
     QueryStateAbon(pDb);

     SendEventBox(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_Global End.');
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
    end;
End;

procedure CHouseTaskGlobal.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
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

procedure CHouseTaskGlobal.SendEventBox(_Type : Byte; _Message : String);
Var
  s   : string;
  ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(_Type,_Message);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT,EventBoxHandle,ID,s);
End;

procedure CHouseTaskGlobal.QueryStateAbon(_pDb: CDBDynamicConn);
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
      SendEventBox(ET_CRITICAL,'ERROR CHouseTaskGlobal.QueryStateAbon!!!');
    end;
  finally
    FreeAndNil(QQ);
  end;
end;

function CHouseTaskGlobal.isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
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

function CHouseTaskGlobal.getPortPull(plid:Integer):CPortPull;
Var
    vList : TList;
    i     : Integer;
    pD    : CPortPull;
begin
    Result := nil;
    vList := portpull.LockList;    //вот здесь
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

function CHouseTaskGlobal.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
Var
    meter  : CMeter;
    pTable : SL2TAG;
Begin
    if (dynConnect.GetMMeterTableEx(mid,pTable)) then
    Begin
     case pTable.m_sbyType of
       MET_SS101         : meter := CSS301F3Meter.Create;  //Грансистема СС101: ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ СС301
       MET_SS301F3       : meter := CSS301F3Meter.Create;  //Грансистема СС301: ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ СС301

       MET_CE6850        : meter := CCE6850Meter.Create;
       MET_CE6822        : meter := CCE6822Meter.Create;  //ЦЭ6822,27М,27М1 : ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ

       MET_EE8003        : meter := CEE8005Meter.Create;  //ВЗЭП ЭЭ8003  : ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ
       MET_EE8005        : meter := CEE8005Meter.Create;  //ВЗЭП ЭЭ8005  : ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ
       MET_EE8007        : meter := CEE8005Meter.Create;  //ВЗЭП ЭЭ8007  : ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ
       MET_EE8003_4      : meter := CEE8005Meter.Create;  //ВЗЭП ЭЭ8003  2004 года выпуска : ИСПОЛЬЗУЕТСЯ ОДИН ПРОТОКОЛ


       MET_CE102         : meter := CCE102Meter.Create;    //ЭНЕРГОМЕРА СЕ102
       MET_CE301BY       : meter := CCE301BYMeter.Create;  //ЭНЕРГОМЕРА СЕ301
       MET_CE303         : meter := CCE301BYMeter.Create; //ЭНЕРГОМЕРА СЕ303
       MET_CE208BY       : meter := CCE208BYMeter.Create; //ЭНЕРГОМЕРА СЕ303

       MET_MIRT1         : meter := CMIRT1Meter.Create;     //МИРТЕК вер.1

       MET_CRCRB         : meter := CBTIMeter.Create;      //КонусЕ
       MET_A2000         : meter := CA2000Meter.Create;    //КонусБыт

       MET_MES1          : meter := MES3Meter.Create;      //Ровалент МЕС1
       MET_MES3          : meter := MES3Meter.Create;      //Ровалент МЕС3

       MET_CEO6005       : meter := CCE06005Meter.Create;      //Ровалент МЕС3


     End;
    End;
    if meter<>nil then
     Begin
      meter.setDbConnect(dynConnect);
      meter.Init(pTable);
     End;
     Result := meter;
End;

function CHouseTaskGlobal.cmdToCls(cmd:Integer):Integer;
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
