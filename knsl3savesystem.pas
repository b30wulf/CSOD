unit knsl3savesystem;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,knsl5tracer,knsl3EventBox,utlTimeDate,knsl3savebase,IBDataBase,IBQuery;
type
     CSaveSystem = class
     private
      m_pD   : PCDBDynamicConn;
      pDG    : L3GRAPHDATA;
      pDC    : L3CURRENTDATA;
      m_nTMR : CTimer;
      m_nTMArch : CTimer;
      m_nSvBase : CTimer;
      m_blTrans : Boolean;
      FSaveDB   : PCSaveBase;
      //procedure SendPackDBS;
      procedure ChandgeGraph;
      procedure FlushCurr;
      procedure FlushArch;
      procedure SendSaveLabel;
      procedure StopTranz;
      procedure OpenTranz;
     public
      constructor Create;
      destructor Destroy;override;
      procedure Run;
      procedure SendPackDBS;
      function EventHandler(var pMsg:CMessage):Boolean;
     public
      property PSaveDB : PCSaveBase read FSaveDB   write FSaveDB;
     End;
implementation
//CSaveSystem
constructor CSaveSystem.Create;
Begin
     m_pD := m_pDB.CreateConnect;
     FDEFINE(BOX_SVBF,BOX_SVBF_SZ,False);
     m_nTMR := CTimer.Create;
     m_nTMR.SetTimer(DIR_SSTOSS,SVS_FLS_TMR,0,0,BOX_SSRV);
     m_nTMArch := CTimer.Create;
     m_nTMArch.SetTimer(DIR_SSTOSS,SVS_ARC_TMR,0,0,BOX_SSRV);
     m_nSvBase := CTimer.Create;
     m_nSvBase.SetTimer(DIR_SSTOSS,SVS_SVBS_TMR,0,0,BOX_SSRV);
     m_blTrans := True;
     //DataBaseRun;
     //SendPackDBS;
End;
destructor CSaveSystem.Destroy;
Begin
End;
function CSaveSystem.EventHandler(var pMsg:CMessage):Boolean;
Begin
     case pMsg.m_sbyType of
          //SVS_SVBS_TMR : SendPackDBS;
          SVS_FLS_TMR  : FlushCurr;
          SVS_ARC_TMR  : FlushArch;
          SVS_CUR_PREP : m_pD.CurrentPrepare;
          SVS_CUR_EXEC : m_pD.CurrentExecute;
          SVS_CUR_FLSH : m_pD.CurrentFlush(pMsg.m_swObjID);
          SVS_SET_CUR  :
          Begin
           StopTranz;
           Move(pMsg.m_sbyInfo[0],pDC,sizeof(L3CURRENTDATA));
           m_pD.SetCurrentParamNoBlock(pDC);
           m_nTMR.OnTimer(7);
           //EventBox.FixEvents(ET_NORMAL,'Сох.Тек. Объект:'+IntToStr(pDC.m_swVMID)+' Время: '+DateTimeToStr(pDC.m_sTime)+' Параметр:'+GetCMD(pDC.m_swCMDID));
          End;
          SVS_SET_ARC  :
          Begin
           StopTranz;
           Move(pMsg.m_sbyInfo[0],pDC,sizeof(L3CURRENTDATA));
           m_pD.AddArchDataNoBlock(pDC);
           //EventBox.FixEvents(ET_NORMAL,'Сох.Арх. Объект:'+IntToStr(pDC.m_swVMID)+' Время: '+DateTimeToStr(pDC.m_sTime)+' Параметр:'+GetCMD(pDC.m_swCMDID));
           m_nTMArch.OnTimer(7);
          End;
          SVS_UPD_F48  :
          Begin
           StopTranz;
           Move(pMsg.m_sbyInfo[0],pDC,sizeof(L3CURRENTDATA));
           m_pD.UpdatePDTFilds_48(pDC);
           m_nTMArch.OnTimer(7);
          End;
          SVS_ADD_F48  :
          Begin
           StopTranz;
           Move(pMsg.m_sbyInfo[0],pDG,sizeof(L3GRAPHDATA));
           m_pD.AddPDTData_48(pDG);
           m_nTMArch.OnTimer(7);
          End;
          SVS_UPD_D48  :
          Begin
           StopTranz;
           Move(pMsg.m_sbyInfo[0],pDC,sizeof(L3CURRENTDATA));
           m_pD.UpdateGD48(pDC);
           m_nTMArch.OnTimer(7);
           //EventBox.FixEvents(ET_NORMAL,'Обн.E30. Объект:'+IntToStr(pDC.m_swVMID)+' Время: '+DateTimeToStr(pDC.m_sTime)+' Параметр:'+GetCMD(pDC.m_swCMDID));
          End;
          SVS_ADD_D48  :
          Begin
           StopTranz;
           Move(pMsg.m_sbyInfo[0],pDG,sizeof(L3GRAPHDATA));
           m_pD.AddGraphData(pDG);
           m_nTMArch.OnTimer(7);
           //EventBox.FixEvents(ET_NORMAL,'Сох.E30. Объект:'+IntToStr(pDG.m_swVMID)+' Время: '+DateTimeToStr(pDG.m_sdtDate)+' Параметр:'+GetCMD(pDG.m_swCMDID));
          End;
     End;
End;
procedure CSaveSystem.FlushArch;
Begin
     //m_pD.CurrentExecute;
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
     SendSaveLabel;
     OpenTranz;
     //SendMsg(BOX_SSRV,0,DIR_SSTOSB,SVS_CHSZ_TMR);
     m_nSvBase.OnTimer(60);
     ChandgeGraph;
End;
procedure CSaveSystem.FlushCurr;
Begin
     //m_pD.CurrentExecute;
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLDATA_REQ);
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATESHEM_IND);
     SendRSMsgM(CreateMSG(BOX_L3,0,DIR_L4TOL3,AL_UPDATESHEM_IND));
     OpenTranz;
     SendSaveLabel;
     //SendMsg(BOX_SSRV,0,DIR_SSTOSB,SVS_CHSZ_TMR);
     m_nSvBase.OnTimer(60);
     ChandgeGraph;
End;
procedure CSaveSystem.SendPackDBS;
Begin
     //SendMsg(BOX_SSRV,0,DIR_SSTOSB,SVS_CHSZ_TMR);
     if Assigned(FSaveDB) then FSaveDB.QwerySave1;
End;
procedure CSaveSystem.StopTranz;
Begin
     if m_blTrans=True then
     Begin
      SendMSG(BOX_L4,0,DIR_L1TOL4,QL_STOP_TRANS_REQ);
      m_blTrans := False;
     End;
End;
procedure CSaveSystem.OpenTranz;
Begin
     if m_blTrans=False then
     Begin
      SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
      m_blTrans := True;
     End;
End;
procedure CSaveSystem.SendSaveLabel;
Var
    pDS  : CMessageData;
    dtTM : TDateTime;
Begin
    dtTM := Now;
    Move(dtTM,pDS.m_sbyInfo[0],sizeof(dtTM));
    SendRSMsgM(CreateMSGD(BOX_L3,0,DIR_LHTOLMC,NL_SAVEUPD_REQ,pDS));
    SendMsgData(BOX_L3_LME,0,DIR_L3TOLME,NL_SAVEUPD_REQ,pDS);
End;
procedure CSaveSystem.ChandgeGraph;
Var
     Hour,Min,Sec,mSec:Word;
Begin
     DecodeTime(Now,Hour,Min,Sec,mSec);
     if Hour=0 then
     Begin
      m_dtTime1 := Now;
      m_dtTime2 := Now;
     End;
End;
procedure CSaveSystem.Run;
Begin
     m_nTMR.RunTimer;
     m_nTMArch.RunTimer;
     m_nSvBase.RunTimer;
End;

{
procedure CSaveSystem.DataBaseRun;
Var
     IBDB : TIBDataBase;
     IBTr : TIBTransaction;
     Q : TIBQuery;
     name : string;
Begin
  IBDB := TIBDataBase.Create(nil);
  IBTr := TIBTransaction.Create(nil);
  with IBDB do begin
    DatabaseName := 'D:\Kon2\SYSINFOAUTO.FDB';
    Params.Add('user_name=sysdba');
    Params.Add('password=masterkey');
    Params.Add('lc_ctype=WIN1251');
    LoginPrompt := False;
    DefaultTransaction := IBTr;
  end;
  try

    IBDB.Connected := True;
    Q:=TIBQuery.Create(nil);
    Q.Transaction:=IBTr;
    Q.Database:=IBDB;
    Q.Transaction.StartTransaction;
    Q.SQL.Clear;
    Q.SQL.Add('SELECT * FROM L2TAG');
    //Q.Active:=true;
    Q.Open;

    while not Q.EOF do
    begin
     name :=  Q.FieldByName('M_SCHNAME').AsString;
     TraceL(0,0,'(__)CSaveSystem::>name :'+name);
     Q.Next;
    end;
    Q.Transaction.Commit;
    IBDB.Connected := False;
  except
    TraceL(0,0,'(__)CSaveSystem::>Error CSaveSystem.DataBaseRun');
  end;
End; }

end.
