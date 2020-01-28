unit knsl3selftestmodule;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,utlverinfo,AdvProgressBar,
    utldatabase,forms,utlmtimer,knsl5tracer,utlTimeDate,knsl1module,knsl2module,knsl3RPSelfTest,knsl2statistic,TypInfo,
    GradientLabel, utlThread;
type
    CL3SelfTestModule = class(CThread)
    private
     m_nMsg : CMessage;
     FState : Byte;
     m_pTbl : PSGENSETTTAG;
     m_nWaitGsmOK : CTimer;
     FDB    : PCDBDynamicConn;
     m_pTst : STESTTAG;
     pVer   : TrpVersionInfo;
     FProgress : TAdvProgressBar;
     FProgresslb : TGradientLabel;
     m_nTestIndex : Integer;
    public
     procedure DoHalfTime(Sender:TObject);
     procedure Init(pTbl:PSGENSETTTAG);
     destructor Destroy; override;
     procedure OnStart;
     procedure OnStop;
    private
     procedure Execute; override;
     function  EventHandler(var pMsg:CMessage):Boolean;
     function  SelfHandler(var pMsg:CMessage):Boolean;
     function  LoHandler(var pMsg:CMessage):Boolean;
     function  HiHandler(var pMsg:CMessage):Boolean;
     function  IsTest(byTest:Byte):Boolean;
     procedure PrepareMeters;
     procedure FillReport;
     procedure SetState(byState:Byte);
     procedure NextTest(nTestCode:Dword);
     procedure IncProgress;
     procedure SetProgressLabel(nTest:Integer);
     procedure OnHandler;
     procedure UpdateProgress(var pMsg:CMessage);
     procedure ClearProgress;
     //Test Procedure
     procedure SelfTest_0_VerNo;
     procedure SelfTest_1_AmPhChannel;
     procedure SelfTest_2_StPhChannel;
     procedure SelfTest_3_AmModem;
     procedure SelfTest_4_StModem;
     procedure CheckGsm_4_Connect;
     procedure SelfTest_5_AmMeters;
     procedure SelfTest_6_StMeters;
     procedure CheckMtr_6_Connect;
     procedure SelfTest_7_AmArm;
     procedure SelfTest_8_StArm;
     procedure SelfTest_9_TimeRout;
     procedure SelfTest_10_TransError;
     procedure SelfTest_11_FatalError;
    public
     property  PProgress   : TAdvProgressBar read FProgress   write FProgress;
     property  PProgresslb : TGradientLabel  read FProgresslb write FProgresslb;
    End;
var
   mL3STModule : CL3SelfTestModule = nil;
implementation
procedure CL3SelfTestModule.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CL3SelfTestModule.Execute;
Begin
     FDEFINE(BOX_L3_HF,BOX_L3_HF_SZ,True);
     while not Terminated do
     Begin
      FGET(BOX_L3_HF,@m_nMsg);
      Synchronize(OnHandler);
     End;
End;

destructor CL3SelfTestModule.Destroy;
begin
  Suspend;
  if m_nWaitGsmOK <> nil then FreeAndNil(m_nWaitGsmOK);
  inherited;
end;

procedure CL3SelfTestModule.Init(pTbl:PSGENSETTTAG);
Begin
     FState        := ST_SLFT_STAT_NULL;
     m_pTbl        := pTbl;
     m_blIsTest    := False;
     m_nFatalError := 0;
     m_nTestIndex  := 0;
     pVer          := TrpVersionInfo.Create(Application);
     Priority      := tpNormal;
     //FDB           := m_pDB.DynConnect(10);
     FDB           := m_pDB.CreateConnect;
     Resume;
     m_nWaitGsmOK := CTimer.Create;
     m_nWaitGsmOK.SetTimer(DIR_L3TOL3,SL_WTGSM_TMR_REQ,0,0,BOX_L3_HF);
End;
function  CL3SelfTestModule.EventHandler(var pMsg : CMessage):Boolean;
begin
     try
     case pMsg.m_sbyFor of
      DIR_L3TOL3    : SelfHandler(pMsg);
      DIR_L1TOSL    : LoHandler(pMsg);
      DIR_L4TOL3    : HiHandler(pMsg);
     End;
     except
      TraceER('(__)CSLMD::>Error In CL3SelfTestModule.EventHandler!!!');
     End;
end;
function  CL3SelfTestModule.SelfHandler(var pMsg:CMessage):Boolean;
begin
     case pMsg.m_sbyType of
      SL_WTGSM_TMR_REQ : if FState=ST_SLFT_OPEN_MODM then CheckGsm_4_Connect;
     End;
end;
function  CL3SelfTestModule.LoHandler(var pMsg:CMessage):Boolean;
begin
     case pMsg.m_sbyType of
      SL_UPD_REM_REQ : UpdateProgress(pMsg);
     End;
end;
function  CL3SelfTestModule.HiHandler(var pMsg:CMessage):Boolean;
begin
     case pMsg.m_sbyType of
      SL_START_TST_REQ : OnStart;
      SL_STOP_TST_REQ  : OnStop;
      SL_SET_REPRT_REQ : FillReport;
      SL_RES_REM_REQ   : ClearProgress;
      SL_FIN_POLL_REQ  : if FState=ST_SLFT_CONN_METR then CheckMtr_6_Connect;
     End;
end;
function  CL3SelfTestModule.IsTest(byTest:Byte):Boolean;
Begin
     Result := (m_pTbl.m_swSelfTest and (1 shl byTest))>0;
End;
procedure CL3SelfTestModule.SetState(byState:Byte);
begin
     TraceL(3,0,'(__)CSLMD::>ST:'+chSLTState[FState]+'->ST:'+chSLTState[byState]);
     FState := byState;
end;
procedure CL3SelfTestModule.FillReport;
Begin
     TRpSelfTest.Destroy;
     TRpSelfTest     := TTRpSelfTest.Create(Application);
     TRpSelfTest.PDB := FDB;
     TRpSelfTest.ShowReport;
end;
procedure CL3SelfTestModule.NextTest(nTestCode:Dword);
Var
     i   : Integer;
     pDS : CMessageData;
Begin
     for i:=nTestCode to TST_END-1 do
     Begin
      if IsTest(i)=True then
      Begin
       SetProgressLabel(i);
       case i of
        TST_VER_NO        : SelfTest_0_VerNo;
        TST_AM_PH_CHANNEL : SelfTest_1_AmPhChannel;
        TST_ST_PH_CHANNEL : SelfTest_2_StPhChannel;
        TST_AM_MODEM      : SelfTest_3_AmModem;
        TST_ST_MODEM      : SelfTest_4_StModem;
        TST_AM_METERS     : SelfTest_5_AmMeters;
        TST_ST_METERS     : SelfTest_6_StMeters;
        TST_AM_ARM        : SelfTest_7_AmArm;
        TST_ST_ARM        : SelfTest_8_StArm;
        TST_TIME_ROUT     : SelfTest_9_TimeRout;
        TST_TRANS_ERROR   : SelfTest_10_TransError;
        TST_FATAL_ERROR   : SelfTest_11_FatalError;
       End;
       exit;
      End;
     End;
     FProgress.Position := 100;
     FProgresslb.Caption := 'Тестирование завершено.';
//     m_pDB.FixUspdEvent(0,3,EVS_STSTOP);
    // m_pDB.FixUspdEvent(0,0,EVH_STEST_PS);
     if m_blIsSlave=True then
     Begin
      pDS.m_swData0 := 32;
      SendRSMsg(CreateMSGD(BOX_L3_HF,0,DIR_L1TOSL,SL_UPD_REM_REQ,pDS));
     End;
End;
procedure CL3SelfTestModule.OnStart;
Var
     nPos,i : Integer;
Begin
//     m_pDB.FixUspdEvent(0,3,EVS_STSTART);
     FProgress.Position := 0;
     nPos := 0;
     for i:=0 to TST_END-1 do if IsTest(i)=False then FDB.DelTestTable(i) else nPos := nPos + 1;
     if nPos=0 then exit;
     m_nTestIndex := trunc(100/nPos);
     NextTest(TST_VER_NO);
End;
procedure CL3SelfTestModule.ClearProgress;
Var
    pGenTable : SGENSETTTAG;
    nPos,i    : Integer;
Begin
    m_pDB.GetGenSettTable(pGenTable);
    FProgress.Position := 0;
    nPos := 0;
    for i:=0 to TST_END-1 do
    if (pGenTable.m_swSelfTest and (1 shl i))>0 then nPos := nPos + 1;
    m_nTestIndex := trunc(100/nPos);
End;
procedure CL3SelfTestModule.IncProgress;
Begin
     FProgress.Position := FProgress.Position + m_nTestIndex;
End;
procedure CL3SelfTestModule.SetProgressLabel(nTest:Integer);
Var
     pDS: CMessageData;
Begin
     IncProgress;
     FProgresslb.Caption := m_nTestName.Strings[nTest];
     FProgresslb.Refresh;
     if m_blIsSlave=True then
     Begin
      pDS.m_swData0 := nTest;
      SendRSMsg(CreateMSGD(BOX_L3_HF,0,DIR_L1TOSL,SL_UPD_REM_REQ,pDS));
     End;
End;
procedure CL3SelfTestModule.UpdateProgress(var pMsg:CMessage);
Var
     pDS  : CMessageData;
     nTest: Integer;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     nTest := pDS.m_swData0;
     if (nTest<32)and(nTest<m_nTestName.Count) then
     Begin
      IncProgress;
      FProgresslb.Caption := m_nTestName.Strings[nTest];
      FProgresslb.Refresh;
     end else
     if nTest=32 then
     Begin
      FProgress.Position  := 100;
      FProgresslb.Caption := 'Тестирование завершено.';
     End;
End;
procedure CL3SelfTestModule.OnStop;
Begin

End;
{
  TST_VER_NO        = 0;
  TST_AM_PH_CHANNEL = 1;
  TST_ST_PH_CHANNEL = 2;
  TST_AM_MODEM      = 3;
  TST_ST_MODEM      = 4;
  TST_AM_METERS     = 5;
  TST_ST_METERS     = 6;
  TST_AM_ARM        = 7;
  TST_ST_ARM        = 8;
  TST_TIME_ROUT     = 9;
  TST_TRANS_ERROR   = 10;
  TST_FATAL_ERROR   = 11;
  TST_END           = 12;
  //Состояния модуля самотестирования системы
  ST_SLFT_STAT_NULL            = 0;          //Нулевое состояние
  ST_SLFT_OPEN_CHAN            = 1;          //Открытие физ каналов
  ST_SLFT_OPEN_MODM            = 2;          //Соединение по модемам
  ST_SLFT_CONN_METR            = 3;          //Соединение со счетчиками
  ST_SLFT_CONN_USPD            = 4;          //Соединение с успд
  ST_SLFT_CONN_ARMT            = 5;          //Соединение с арм
  STESTTAG = packed record
     m_swID         : Integer;
     m_swTSTID      : Integer;
     m_swObjID      : Integer;
     m_sdtTestTime  : TDateTIme;
     m_strComment   : String[50];
     m_strDescription : String[20];
     m_strResult    : String[10];
    end;
}
procedure CL3SelfTestModule.SelfTest_0_VerNo;
Begin
    FDB.SaveTestRecord(TST_VER_NO,0,Now,'Производитель',pVer.CompanyName    ,'PASS');
    FDB.SaveTestRecord(TST_VER_NO,1,Now,'Назначение'   ,pVer.FileDescription,'PASS');
    FDB.SaveTestRecord(TST_VER_NO,2,Now,'Версия'       ,pVer.FileVersion    ,'PASS');
    FDB.SaveTestRecord(TST_VER_NO,3,Now,'Имя файла'    ,pVer.InternalName   ,'PASS');
    FDB.SaveTestRecord(TST_VER_NO,4,Now,'Дата создания',pVer.LegalCopyright ,'PASS');
    FDB.SaveTestRecord(TST_VER_NO,7,Now,'Использование',pVer.ProductName    ,'PASS');
    FDB.SaveTestRecord(TST_VER_NO,9,Now,'Комментарий'  ,pVer.Comments       ,'PASS');
    SetState(ST_SLFT_STAT_NULL);
    //IncProgress;
    NextTest(TST_VER_NO+1);
end;
procedure CL3SelfTestModule.SelfTest_1_AmPhChannel;
Begin
    FDB.SaveTestRecord(TST_AM_PH_CHANNEL,0,Now,'Количество физ. каналов',IntToStr(mL1Module.PPortTable.Count),'PASS');
    SetState(ST_SLFT_STAT_NULL);
    //IncProgress;
    NextTest(TST_AM_PH_CHANNEL+1);
End;
procedure CL3SelfTestModule.SelfTest_2_StPhChannel;
Var
     i       : Integer;
     byType  : Byte;
     strComment,strDesc,strRez : String;
Begin
     SetState(ST_SLFT_OPEN_CHAN);
     for i:=0 to mL1Module.PPortTable.Count-1 do
     Begin
      with mL1Module.PPortTable.Items[i] do
      Begin
       strComment :=m_nPortTypeList.Strings[m_sbyType];
       if (m_sbyType=DEV_COM_LOC)or(m_sbyType=DEV_COM_GSM) then strComment :=strComment+' №'+IntToStr(m_sbyPortNum);
       strDesc    :=m_nSpeedList.Strings[m_sbySpeed]+
                   ':'+m_nParityList.Strings[m_sbyParity]+
                   ':'+m_nDataList.Strings[m_sbyData]+
                   ':'+m_nStopList.Strings[m_sbyStop]+
                   ' d.t.:'+IntToStr(m_swDelayTime);
       if (m_sbyType=DEV_TCP_SRV)or(m_sbyType=DEV_TCP_CLI) then strDesc := m_schIPAddr+':'+m_swIPPort;
       if mL1Module.GetPortState(i)=True  then strRez := 'PASS' else
       if mL1Module.GetPortState(i)=False then strRez := 'FAIL';
       FDB.SaveTestRecord(TST_ST_PH_CHANNEL,i,Now,strComment,strDesc,strRez);
      End;
     End;
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_ST_PH_CHANNEL+1);
End;
procedure CL3SelfTestModule.SelfTest_3_AmModem;
Var
     i,nIndex : Integer;
Begin
     nIndex := 0;
     for i:=0 to mL1Module.PPortTable.Count-1 do if mL1Module.PPortTable.Items[i].m_sbyType=DEV_COM_GSM then nIndex := nIndex + 1;
     FDB.SaveTestRecord(TST_AM_MODEM,0,Now,'Количество модемов',IntToStr(nIndex),'PASS');
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_AM_MODEM+1);
End;
procedure CL3SelfTestModule.SelfTest_4_StModem;
Var
     i : Integer;
Begin
     SetState(ST_SLFT_OPEN_MODM);
     for i:=0 to mL1Module.PPortTable.Count-1 do
     Begin
      with mL1Module.PPortTable.Items[i] do
      Begin
       if (m_sbyType=DEV_COM_GSM)and(m_sblReaddres=0) then
       SendPMSG(BOX_L1,m_sbyPortID,DIR_L2TOL1,PH_DISC_IND);
      End;
     End;
    m_nWaitGsmOK.OnTimer(8);
End;
procedure CL3SelfTestModule.CheckGsm_4_Connect;
Var
     i : Integer;
     strComment,strDesc,strRez : String;
Begin
     for i:=0 to mL1Module.PPortTable.Count-1 do
     Begin
      with mL1Module.PPortTable.Items[i] do
      Begin
       if (m_sbyType=DEV_COM_GSM)and(m_sblReaddres=0) then
       Begin
        strComment := m_nPortTypeList.Strings[m_sbyType]+' №'+IntToStr(m_sbyPortNum);
        strDesc    := m_nSpeedList.Strings[m_sbySpeed]+
                   ':'+m_nParityList.Strings[m_sbyParity]+
                   ':'+m_nDataList.Strings[m_sbyData]+
                   ':'+m_nStopList.Strings[m_sbyStop]+
                   ' d.t.:'+IntToStr(m_swDelayTime);
        if mL1Module.GetConnectState(i)=True  then strRez:='PASS' else
        if mL1Module.GetConnectState(i)=False then strRez:='FAIL';
        FDB.SaveTestRecord(TST_ST_MODEM,m_sbyPortID,Now,strComment,strDesc,strRez);
       End;
      End;
     End;
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_ST_MODEM+1);
End;
procedure CL3SelfTestModule.SelfTest_5_AmMeters;
Var
     i,nIndex : Integer;
Begin
     nIndex := 0;
     with mL2Module.PMeterTable do
     for i:=0 to m_swAmMeter-1 do if not((m_sMeter[i].m_sbyType=MET_SUMM)or(m_sMeter[i].m_sbyType=MET_GSUMM)) and (m_sMeter[i].m_sbyEnable=1) then nIndex := nIndex + 1;
     FDB.SaveTestRecord(TST_AM_METERS,0,Now,'Количество активных устройств учета',IntToStr(nIndex),'PASS');
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_AM_METERS+1);
End;
procedure CL3SelfTestModule.SelfTest_6_StMeters;
Var
     pDS : CMessageData;
Begin
     SetState(ST_SLFT_CONN_METR);
     m_blIsTest := True;
     PrepareMeters;
     TL2Statistic.LoResetCounter;
     TL2Statistic.Pause;
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
End;
procedure CL3SelfTestModule.PrepareMeters;
Var
     pTbl : SL2TAG;
     i    : Integer;
Begin
     with mL2Module.PMeterTable do
     for i:=0 to m_swAmMeter-1 do
     Begin
      Move(m_sMeter[i],pTbl,sizeof(pTbl));
      pTbl.m_sbyRepMsg := 3;
      if pTbl.m_sbyModem=1 then pTbl.m_swRepTime := 5 else
      if pTbl.m_sbyModem=0 then pTbl.m_swRepTime := 2;
      mL2Module.EditNodeLv(pTbl);
     End;
End;
procedure CL3SelfTestModule.CheckMtr_6_Connect;
Var
     i,nType,nMid : Integer;
     pTable       : QM_METERS;
     strComment,strDesc,strRez,sddFabNum : String;
Begin
     m_pDB.GetMetersTypeTable(pTable);
     with mL2Module.PMeterTable do
     for i:=0 to m_swAmMeter-1 do
     Begin
      nType     := m_sMeter[i].m_sbyType;
      nMid      := m_sMeter[i].m_swMID;
      sddFabNum := m_sMeter[i].m_sddFabNum;
      if not((nType=MET_SUMM)or(nType=MET_GSUMM)) then
      Begin
       strComment := 'Счетчик '+pTable.m_sMeterType[nType].m_sName+',№'+sddFabNum;
       strDesc    := 'Адрес '+m_sMeter[i].m_sddPHAddres;
       strRez     := 'FAIL';
       if (m_sMeter[i].m_sbyEnable=1) then if TL2Statistic.GetIn(nMid)<>0 then strRez := 'PASS';
       if (m_sMeter[i].m_sbyEnable=0) then strRez := 'CLOSE';
       FDB.SaveTestRecord(TST_ST_METERS,nMid,Now,strComment,strDesc,strRez);
      End;
     End;
     TL2Statistic.Go;
     mL2Module.Init;
     m_blIsTest := False;
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_ST_METERS+1);
End;
procedure CL3SelfTestModule.SelfTest_7_AmArm;
Var
     i,nIndex : Integer;
Begin
     nIndex := 0;
     for i:=0 to mL1Module.PPortTable.Count-1 do
     with mL1Module.PPortTable.Items[i] do
     if ((m_sbyType=DEV_TCP_SRV)or(m_sbyType=DEV_TCP_CLI))and(m_sbyControl=1) then nIndex := nIndex + 1;
     FDB.SaveTestRecord(TST_AM_ARM,0,Now,'Количество каналов управления АРМ',IntToStr(nIndex),'PASS');
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_AM_ARM+1);
End;
procedure CL3SelfTestModule.SelfTest_8_StArm;
Var
     i       : Integer;
     strComment,strDesc,strRez : String;
Begin
     SetState(ST_SLFT_OPEN_CHAN);
     for i:=0 to mL1Module.PPortTable.Count-1 do
     Begin
      with mL1Module.PPortTable.Items[i] do
      Begin
       if ((m_sbyType=DEV_TCP_SRV)or(m_sbyType=DEV_TCP_CLI))and(m_sbyControl=1) then
       Begin
        strComment := 'Функционирование канала.'+m_nPortTypeList.Strings[m_sbyType];
        strDesc := m_schIPAddr+':'+m_swIPPort;
        if mL1Module.GetPortState(i)=True  then strRez := 'PASS' else
        if mL1Module.GetPortState(i)=False then strRez := 'FAIL';
        FDB.SaveTestRecord(TST_ST_ARM,i,Now,strComment,strDesc,strRez);
       End;
      End;
     End;
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_ST_ARM+1);
End;
procedure CL3SelfTestModule.SelfTest_9_TimeRout;
Begin
     FDB.SaveTestRecord(TST_TIME_ROUT,0,Now,'Время непрерывной работы.',IntToStr(TL2Statistic.GetTimeRout(0))+' сек.','PASS');
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_TIME_ROUT+1);
End;
procedure CL3SelfTestModule.SelfTest_10_TransError;
Var
     i,nType,nMid : Integer;
     pTable       : QM_METERS;
     strComment,strDesc,strRez,sddFabNum : String;
Begin
     m_pDB.GetMetersTypeTable(pTable);
     with mL2Module.PMeterTable do
     for i:=0 to m_swAmMeter-1 do
     Begin
      nType     := m_sMeter[i].m_sbyType;
      nMid      := m_sMeter[i].m_swMID;
      sddFabNum := m_sMeter[i].m_sddFabNum;
      if not((nType=MET_SUMM)or(nType=MET_GSUMM)) then
      Begin
       strComment := 'Счетчик '+pTable.m_sMeterType[nType].m_sName+',№ '+sddFabNum+',Адр.:'+m_sMeter[i].m_sddPHAddres;
       strDesc    := 'tx:'+IntToStr(TL2Statistic.GetOutAll(nMid))+',rx:'+IntToStr(TL2Statistic.GetInAll(nMid))+',rj:'+IntToStr(TL2Statistic.GetRej(nMid));
       strRez     := 'FAIL';
       if (m_sMeter[i].m_sbyEnable=1) then {if TL2Statistic.GetIn(nMid)=1 then} strRez := 'PASS';
       if (m_sMeter[i].m_sbyEnable=0) then strRez := 'CLOSE';
       FDB.SaveTestRecord(TST_TRANS_ERROR,nMid,Now,strComment,strDesc,strRez);
      End;
     End;
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_TRANS_ERROR+1);
End;
procedure CL3SelfTestModule.SelfTest_11_FatalError;
Begin
     FDB.SaveTestRecord(TST_FATAL_ERROR,0,Now,'Количество ошибок исполнения.',IntToStr(m_nFatalError),'PASS');
     SetState(ST_SLFT_STAT_NULL);
     //IncProgress;
     NextTest(TST_FATAL_ERROR+1);
End;
procedure CL3SelfTestModule.DoHalfTime(Sender:TObject);
Begin
     if m_nWaitGsmOK<>Nil then
     m_nWaitGsmOK.RunTimer;
End;

end.
