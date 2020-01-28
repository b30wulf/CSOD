unit knsl2_HouseTask_USPD1500;
interface
uses
 Windows, Classes, SysUtils,SyncObjs,stdctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3HolesFinder,knsl2qweryportpull,knsl2qweryarchmdl,
 knsl2meter,knsl3EventBox,knsl2IRunnable,utldynconnect,knsl2CThreadPull,
 knsl2_USPD1500,utlQueryQualityDyn,utlSendRecive;
 type

    CMeterTaskUSPD1500 = class(IRunnable)
     private
      meter      : CMeter;
      outMsg     : CMessage;
      inMsg      : CMessage;
      connection : IConnection;
      m_sQC        : SQWERYCMDID; //��� �������� ���������
      SenderClass  : TSenderClass;      
      MeterHanldM5 : HWND;
      MeterHandler : THandle;            
     protected
      procedure getInputBuffer(var V :PCMessageBuffer);
      procedure getIntBuffer(var V :PCIntBuffer);

     public
      constructor Create(var value:CMeter;var vParent:IRunnable;var vConnection:IConnection;MetHanldM5:HWND;MetHandler:THandle);
      destructor Destroy;override;
      function run(gid:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;

      function getOutMsg:Integer;
      procedure getIntBufferADR(var V :PCIntBuffer);
      procedure SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
    End;


    CHouseTaskUSPD1500 = class(IRunnable)
     private
      dtBegin      : TDateTime;
      dtEnd        : TDateTime;
      cmd          : Integer;
      gid          : Integer;
      aid          : Integer;
      mid          : Integer;
      isFind       : Integer;
      ErrorPercent : double;
      ErrorPercent2 : double;
      TimeToStop   : TDateTime;       
      meterPull    : CThreadPull;
      portPull     : TThreadList;
      taskUndex    : Integer;
      inMessageBuffer : CMessageBuffer;
      intBuffer    : CIntBuffer;
      inBufferADR  : CIntBuffer;
      m_sQC        : SQWERYCMDID; //��� �������� ���������
      SenderClass  : TSenderClass;
      HanldM5      : HWND;      
     private
      function getPortPull(plid:Integer):CPortPull;
      function isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
      function cmdToCls(cmd:Integer):Integer;
      function getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
     public
      function getAboID:integer;
      function getParamID:integer;
      procedure QueryStateAbon(_pDb: CDBDynamicConn);
      procedure SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
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
      function run:Integer;override;
    End;

implementation
{$R+}
constructor CMeterTaskUSPD1500.Create(var value:CMeter;{vPortPull:TThreadList;}var vParent:IRunnable;var vConnection:IConnection;MetHanldM5:HWND;MetHandler:THandle);
Begin
    if SenderClass<>Nil then SenderClass := TSenderClass.Create;
    MeterHanldM5 :=  MetHanldM5;
    MeterHandler :=  MetHandler;
    meter    := value;
    id       := meter.m_nP.m_swMID;
    state    := TASK_STATE_RUN;
    parent   := vParent;
    connection := vConnection;
End;

destructor CMeterTaskUSPD1500.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited Destroy;
End;

procedure CMeterTaskUSPD1500.getInputBuffer(var V :PCMessageBuffer);
begin
  if parent is CHouseTaskUSPD1500 then
    V := @(CHouseTaskUSPD1500(parent).inMessageBuffer)
  else V := nil;
end;
procedure CMeterTaskUSPD1500.getIntBuffer(var V :PCIntBuffer);
begin
  if parent is CHouseTaskUSPD1500 then
    V := @(CHouseTaskUSPD1500(parent).intBuffer)
  else V := nil;
end;

procedure CMeterTaskUSPD1500.getIntBufferADR(var V :PCIntBuffer);
begin
  if parent is CHouseTaskUSPD1500 then
    V := @(CHouseTaskUSPD1500(parent).inBufferADR)
  else V := nil;
end;

function CMeterTaskUSPD1500.run(gid:Integer;var kol_Y:Integer;var kol_N:Integer;CPORT:Integer;dateBegin:TDateTime):Integer;
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
      if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask TASK KILLED!!!');
      exit;
     End;
     if(outMsg.m_swLen<>0) then
     Begin
      connection.put(outMsg);
      if EventBox<>Nil then EventBox.FixMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask MSG PUT Complette... MSG:>',outMsg);
      res := true;
      i   := 0;
      getResult := -1;
      while getResult<>0 do
      Begin
        getResult := connection.get(inMsg);
        if getResult=0 then
        Begin
         if EventBox<>Nil then EventBox.FixMessage(ET_NORMAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask MSG GET Complette... MSG:>',inMsg);
         if meter.EventHandler(inMsg) then
         Begin
           if (meter.m_nT.B1 = True)then
            begin
             with meter.m_nP do
               if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)then
                 begin
                  pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_OK);
                  inc(kol_Y);
                  SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
                 end;
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask MSG GET Complette. Len:'+IntToStr(inMsg.m_swLen));
             break;
            end
           else
            begin
             with meter.m_nP do
              if (meter.m_nT.CMD=QRY_NAK_EN_DAY_EP)or(meter.m_nT.CMD=QRY_NAK_EN_MONTH_EP)or(meter.m_nT.CMD=QRY_LOAD_ALL_PARAMS)then
                begin
                 pDb.setQueryState(M_SWABOID,m_swMID,QUERY_STATE_ER);
                 inc(kol_N);
                 SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,QUERY_STATE_ER,CPORT,dateBegin,now);
                end;
             if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask MSG GET Complette. Len:'+IntToStr(inMsg.m_swLen));
             break;
            end
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
            inc(kol_N);
            SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,QUERY_STATE_ER,CPORT,dateBegin,now);
            pDb.addErrorArch(M_SWABOID,m_swMID);
           end;
          end;
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask MSG Skip. Error In Channel!!! ');
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
             inc(kol_N);
             SendQSStatisticAbon(M_SWABOID,gid,kol_Y,kol_N,QUERY_STATE_ER,CPORT,dateBegin,now);
             pDb.addErrorArch(M_SWABOID,m_swMID);
           end;
         end;
         getResult := -1;
         break;
        End;        //Repeat message if not get
        connection.put(outMsg);
        if EventBox<>Nil then EventBox.FixMessage(ET_CRITICAL,'('+IntToStr(meter.m_nP.M_SWABOID)+'/'+meter.m_nP.m_sddPHAddres+')CMeterTask.Run Repeat '+IntToStr(i)+' of '+IntToStr(meter.m_nP.m_sbyRepMsg)+'    MSG:>',outMsg);
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

function CMeterTaskUSPD1500.getOutMsg:Integer;
begin
  Result := -1;
  FillChar(outMsg, SizeOf(outMsg), 0);
  if not meter.send(outMsg) then Exit;
  Result := 0;
end;

procedure CMeterTaskUSPD1500.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     s   : string;     
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snABOID  := m_snABOID;  //ID HOUSE
     sQC.m_snSRVID  := snSRVID;    //id ������
     sQC.m_snCLID   := m_snCLID;   //Kol-vo ����������
     sQC.m_snCLSID  := m_snCLSID;   //Kol-vo �� ����������
     sQC.m_snCmdID  := nCommand;   //�������  � ���������
     sQC.m_snVMID   := m_snVMID;   //����� �����
     sQC.m_sdtBegin := sdtBegin;   //������ ������� ������
     sQC.m_sdtEnd   := sdtEnd;     //����� ������� ������

     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
//     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYSTATISTICABON_REQ,pDS);
     s := SenderClass.ToString(sQC);
     SenderClass.Send(QL_QWERYSTATISTICABON_REQ,MeterHanldM5,MeterHandler,s);
End;

constructor CHouseTaskUSPD1500.Create(vDtBegin,vDtEnd:TDateTime;
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
destructor CHouseTaskUSPD1500.Destroy;
Begin
    if SenderClass<>Nil then FreeAndNil(SenderClass);
    inherited;
End;
function CHouseTaskUSPD1500.getAboID:integer;
Begin
    Result := aid;
End;
function CHouseTaskUSPD1500.getParamID:integer;
Begin
    Result := cmd;
End;
function CHouseTaskUSPD1500.run:Integer;
Var
    i        : Integer;
    pump     : CDataPump;
    pTbl     : SQWERYMDL;
    meter    : CMeter;
    mettask  : CMeterTaskUSPD1500;
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
    ResDoz        : Integer;
    TimeInterval  : Double;
    TimeCounter   : TDateTime;
    TimeStartProc : TDateTime;
    IDCHANNELGSM  : Integer;
    CPORT         : Integer;
    kol_N,kol_Y   : Integer;
Begin
    try
    TimeInterval := TimeToStop - trunc(TimeToStop);//StrToTime('00:15:00');    
    Result:= 0;
    ResDoz:= 0;
    res   := 0;
    i     := 0;
    CPORT := 0;
    kol_N := 0;
    kol_Y := 0;
    dateBegin:=now;
    findData := False;
    vList    := nil;
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask Begin...');
    data := TThreadList.Create;
    pDb  := m_pDB.getConnection;
    pDb.GetAbonL2Join(gid,aid,data);

    if (cmd=QRY_DATA_TIME) then
     begin
       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask_164MiK Correction Time Begin...');
       data.LockList.Count:=1;
     end;

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
     pDb.SetChannelGSM(aid,IDCHANNELGSM,CPORT);//�������� �� ������ ����� ����� ����� �����
     SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_WAIT,CPORT,now,dateEnd);
     connection.clearHistory;
    End;
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask Device Received.');

    while i<vList.count do
     Begin
      try
      if (state=TASK_STATE_KIL) or (parent.getTaskState=TASK_STATE_KIL) then 
      Begin
       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTask TASK KILLED!!!');
       pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
       res:= 4;
       ResDoz:= 2;
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
      meter.m_nT.CMD:=cmd;//�������� ������� ��� ����������� � Meter.run � ��
        if cmdToCls(cmd)=CLS_MGN then
          meter.PObserver.LoadParamQS(cmd)
        else
          Begin
           pHF  := CHolesFinder.Create(pDb);
           pump := CDataPump.Create(nil,pHF,meter,@pTbl,cmd);
           if isFind=1 then findData := pump.PrepareFind(dtBegin,dtEnd,pTbl.m_snVMID,cmdToCls(cmd));
           pump.SetPump(dtBegin,dtEnd,pTbl.m_snMID,cmdToCls(cmd),0);
           pump.Start;
           while(pump.Next) do;
          End;
       if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTask QUERY meter �:'+IntToStr(meter.m_nP.m_swMID)+' kv �:'+meter.m_nP.m_sddPHAddres);
       if ((isFind=1) and (findData=false)) then
          with meter.m_nP do
           if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS) then
           begin
           pDb.setQueryState(aid,m_swMID,QUERY_STATE_OK);
           inc(kol_Y);
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_WAIT,CPORT,dateBegin,now);
           end;
       if (isFind=0) or ((isFind=1) and (findData=true)) then
         Begin
           if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
            if isManyErrors(pDb,aid,ErrorPercent) then
            Begin
             if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask SKIP Query Connection=ERR:>Many Errors In House!!!');
             res:=3;
             exit;
            End;
              if (i=0) then
              begin
               pDb.setDtBeginEndInQueryQroup(aid,now,now,CALL_STATE);//��������� ������
               SendQSStatisticAbon(aid,gid,kol_Y,kol_N,CALL_STATE,CPORT,now,now);
              end;

            connection.iconnect(meter.m_nP.m_sPhone);
            if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_CONN) then
               TimeStartProc := Now
            else
             if ((i=0)or(isFind=1)) and (connection.getConnectionState=PULL_STATE_ERR) then
              Begin
               if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+'/'+meter.m_nP.m_sddPHAddres+')CHouseTask SKIP Query Connection=ERR:>');
               m_pDB.DiscDynconnect(pDM);
               res:=2;
               ResDoz:=1;
               exit;
              End;

            TimeCounter := Now;
            if TimeStartProc + TimeInterval < TimeCounter then
            exit;

//            connection.iconnect(meter.m_nP.m_sPhone);
            if (i=0) and (connection.getConnectionState=PULL_STATE_CONN) then
               begin
               dateBegin:=now;
               pDb.setDtBeginEndInQueryQroup(aid,dateBegin,0,TASK_QUERY);//������ ������
               SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,0);
               end
            else
             begin
               pDb.setDtBeginEndInQueryQroup(aid,dateBegin,now,TASK_QUERY);//������ ������
               SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY,CPORT,dateBegin,now);
             end;
               mettask := CMeterTaskUSPD1500.Create(meter,IRunnable(self),connection,HanldM5,meterPull.Handle);
               res := mettask.run(gid,kol_Y,kol_N,CPORT,dateBegin);
            inc(i);
         End
       else inc(i);
      except
       if (cmd=QRY_NAK_EN_DAY_EP)or(cmd=QRY_NAK_EN_MONTH_EP)or(cmd=QRY_LOAD_ALL_PARAMS)then
        begin
         pDb.setQueryState(aid,meter.m_nP.m_swMID,QUERY_STATE_ER);
         SendQSStatisticAbon(aid,gid,kol_Y,kol_N+1,TASK_QUERY,CPORT,dateBegin,now);
         pDb.addErrorArch(aid,meter.m_nP.m_swMID);
        end;
       if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'('+IntToStr(aid)+')CHouseTaskUSPD1500 Error in meter �:'+IntToStr(meter.m_nP.m_swMID)+' kv �:'+meter.m_nP.m_sddPHAddres);

       m_pDB.DiscDynconnect(pDM);
       if mettask<>nil then FreeAndNil(mettask);//mettask.Destroy;
       if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
       if pump<>nil then FreeAndNil(pump);//pump.Destroy;
       if meter<>nil then FreeAndNil(meter);//meter.Destroy;
       //FreeAndNil(pD);//pD.Destroy;
       //vList.Delete(i);
       inc(i);
      end;
       m_pDB.DiscDynconnect(pDM);
       if mettask<>nil then FreeAndNil(mettask); //mettask.Destroy;
       if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
       if pump<>nil then FreeAndNil(pump);//pump.Destroy;
       if meter<>nil then FreeAndNil(meter);//meter.Destroy;
      // FreeAndNil(pD);//pD.Destroy;
     End;

    finally
     m_pDB.DiscDynconnect(pDM);
     if mettask<>nil then FreeAndNil(mettask); //mettask.Destroy;
     if pHF<>nil then FreeAndNil(pHF);//pHF.Destroy;
     if pump<>nil then FreeAndNil(pump);//pump.Destroy;
     if meter<>nil then FreeAndNil(meter);//meter.Destroy;
     //if pD<>nil then FreeAndNil(pD);
       //vList.Delete(i-1);
     if ((res=0) or (res=-1)) and (res<>2) then
     begin
       if (cmd=QRY_DATA_TIME)then
       begin
          pDb.setDtEndInQueryQroup(aid,now,TASK_DATE_TIME_COR); //������������� ������� ������� ���������
          SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_DATE_TIME_COR,CPORT,dateBegin,now);
       end
       else
         begin
           pDb.setDtEndInQueryQroup(aid,now,TASK_QUERY_COMPL);    //����� ������
           SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_QUERY_COMPL,CPORT,dateBegin,now);
         end;
     end
     else if (res=2)then
      begin
       pDb.setDtEndInQueryQroup(aid,now,TASK_CONN_ERR); //������ ����������
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_CONN_ERR,CPORT,dateBegin,now);
      end
     else if (res=3)then
      begin
       pDb.setDtEndInQueryQroup(aid,now,TASK_MANY_ERR); //�������� ������ ������
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_MANY_ERR,CPORT,dateBegin,now);
      end
     else if (res=4)then
      begin
       pDb.setDtEndInQueryQroup(aid,now,TASK_HAND_STOP);//������������� ����������
       SendQSStatisticAbon(aid,gid,kol_Y,kol_N,TASK_HAND_STOP,CPORT,dateBegin,now);
      end;
     QueryStateAbon(pDb);
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'('+IntToStr(aid)+')CHouseTaskUSPD1500 End.');
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

     pDb.SetResetChannelGSM(aid,-1);//�������� �� ������ ����� ����� ����� �����     
     m_pDB.DiscDynConnect(pDb);
     if (connection<>nil) then  connection.iclose;
     Result:=ResDoz;
    end;
End;

procedure CHouseTaskUSPD1500.QueryStateAbon(_pDb: CDBDynamicConn);
var
    QQ  : TQueryQualityDyn;
    MDQ : TQQData;  // ��� ������
    year, month, day :word;
    DateNow :TDateTime;
begin
     QQ := TQueryQualityDyn.Create;
     DecodeDate(Now, year, month, day);
      if (cmd=QRY_NAK_EN_MONTH_EP)then
         begin
         MDQ := QQ.GetQQMonths(_pDb,aid);  // �������� ������ �����
         DateNow := EncodeDate(year,month,1);
         end
      else if (cmd=QRY_NAK_EN_DAY_EP)then
        begin
        DateNow := EncodeDate(year,month,day);
        MDQ := QQ.GetQQDays(_pDb,aid);  // �������� ������ �����
        end
      else
        begin
        DateNow := EncodeDate(year,month,day);
        MDQ := QQ.GetQQCurrs(_pDb,aid);  // �������� ������ �����
        end;
       if (DateNow=dtBegin) then
         begin
          if (MDQ.Perc < ERRORPERCENT2) or (MDQ.Perc=255) then
           begin
             MDQ.Dats := dtBegin;             // ���� ������
             MDQ.Stat := 0;                  // �� �����
             MDQ.Perc := trunc(QQ.GetPercent(_pDb,aid)); //������� ���������� �� �������
             if(cmd=QRY_NAK_EN_MONTH_EP)then
             QQ.SetQQMonths(_pDb,aid, MDQ)   // ��������� ������ ����� (��������� �������� ��������� �����������)
             else if (cmd=QRY_NAK_EN_DAY_EP)then
             QQ.SetQQDays(_pDb,aid, MDQ)     // ��������� ������ ����  (��������� �������� ��������� �����������)
             else if (cmd=QRY_ENERGY_SUM_EP)then
             QQ.SetQQCurrs(_pDb,aid, MDQ);    // ��������� ������ �������  (��������� �������� ��������� �����������)
           end;
         end
       else
         begin
           if (dtBegin=MDQ.Dats)then
            begin
             if (MDQ.Perc < ERRORPERCENT2) or (MDQ.Perc=255) then
               begin
                MDQ.Dats := dtBegin;             // ���� ������
                MDQ.Stat := 0;                  // �� �����
                MDQ.Perc := trunc(QQ.GetPercent(_pDb,aid)); //������� ���������� �� �������
                if(cmd=QRY_NAK_EN_MONTH_EP)then
                QQ.SetQQMonths(_pDb,aid, MDQ)   // ��������� ������ ����� (��������� �������� ��������� �����������)
                else if (cmd=QRY_NAK_EN_DAY_EP)then
                QQ.SetQQDays(_pDb,aid, MDQ)     // ��������� ������ ����  (��������� �������� ��������� �����������)
                else if (cmd=QRY_ENERGY_SUM_EP)then
                QQ.SetQQCurrs(_pDb,aid, MDQ);    // ��������� ������ �������  (��������� �������� ��������� �����������)
               end;
            end;
            if (dtBegin>MDQ.Dats)then
             begin
                MDQ.Dats := dtBegin;             // ���� ������
                MDQ.Stat := 0;                  // �� �����
                MDQ.Perc := trunc(QQ.GetPercent(_pDb,aid)); //������� ���������� �� �������
                if(cmd=QRY_NAK_EN_MONTH_EP)then
                QQ.SetQQMonths(_pDb,aid, MDQ)   // ��������� ������ ����� (��������� �������� ��������� �����������)
                else if (cmd=QRY_NAK_EN_DAY_EP)then
                QQ.SetQQDays(_pDb,aid, MDQ)     // ��������� ������ ����  (��������� �������� ��������� �����������)
                else if (cmd=QRY_ENERGY_SUM_EP)then
                QQ.SetQQCurrs(_pDb,aid, MDQ);    // ��������� ������ �������  (��������� �������� ��������� �����������)
             end;
            if (dtBegin<MDQ.Dats)then
             begin
               if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'������ �������� �������� �� ���� ����������� ��-�� dtBegin<MDQ.Dats');
             end;
         end;
   FreeAndNil(QQ);
end;

procedure CHouseTaskUSPD1500.SendQSStatisticAbon(m_snABOID,snSRVID,m_snCLID,m_snCLSID,nCommand,m_snVMID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
     s   : string;     
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snABOID  := m_snABOID;  //ID HOUSE
     sQC.m_snSRVID  := snSRVID;    //id ������
     sQC.m_snCLID   := m_snCLID;   //Kol-vo ����������
     sQC.m_snCLSID  := m_snCLSID;   //Kol-vo �� ����������
     sQC.m_snCmdID  := nCommand;   //�������  � ���������
     sQC.m_snVMID   := m_snVMID;   //����� �����
     sQC.m_sdtBegin := sdtBegin;   //������ ������� ������
     sQC.m_sdtEnd   := sdtEnd;     //����� ������� ������

     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     pDS.m_swData4 := MTR_LOCAL;
//     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYSTATISTICABON_REQ,pDS);
     s := SenderClass.ToString(sQC);
     SenderClass.Send(QL_QWERYSTATISTICABON_REQ,HanldM5,meterPull.Handle,s);
End;

function CHouseTaskUSPD1500.isManyErrors(pDb:CDBDynamicConn;aid:Integer;vErrorPercent:double):boolean;
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

function CHouseTaskUSPD1500.getPortPull(plid:Integer):CPortPull;
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

function CHouseTaskUSPD1500.getL2Instance(dynConnect:CDBDynamicConn;mid:Integer):CMeter;
Var
    meter  : CMeter;
    pTable : SL2TAG;
Begin
    if (dynConnect.GetMMeterTableEx(mid,pTable)) then
    Begin
      case pTable.m_sbyType of
         MET_USPD1500        : meter := USPD1500.Create;
      End;
      End;
      if meter<>nil then
      Begin
       meter.setDbConnect(dynConnect);
       meter.Init(pTable);
      End;
      Result := meter;
End;

function CHouseTaskUSPD1500.cmdToCls(cmd:Integer):Integer;
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
