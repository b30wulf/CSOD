unit knsl3module;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,knsl3recalcmodule,
    utldatabase,knsl3vmeter,knsl3viewgraph,knsl3viewcdata,forms,utlmtimer,Parser10,knsl3datamatrix,
    knsl3jointable,
    knsl3calcmodule,knsl5config,AdvOfficePager,
    //knsl3chandge,
    knsl3EventBox,knsl3discret,knsl3Monitor,knsl3SchemLoader,knsl5protectmdl,
    utlThread;

type
     CL3Module = class(CThread)
     private
      FForm          : TForm;
      FPage          : TAdvOfficePager;
      m_nLID         : Byte;
      m_byLayerState : Byte;
      m_nMsg         : CMessage;
//      FTimer         : TTimer;
      m_nVM          : CVMeters;
      m_nRCL         : CRclModule;
      m_lDS          : CGDataSource;
      m_nUpdateTimer : CTimer;
      m_nResTimer    : CTimer;
      m_nTurnTimer   : CTimer;
      FParser        : TMParser;
      FlbLocal       : PTLabel;
      m_blQRestart   : Boolean;
      m_blFirstCover : Boolean;
      //m_nQMDL        : array[0..MAX_VMETER] of CQweryClusters;
      FsgPGrid       : PTAdvStringGrid;
      FsgEGrid       : PTAdvStringGrid;
      FsgCGrid       : PTAdvStringGrid;
      FsgVGrid       : PTAdvStringGrid;
      m_nCL          : CCalcModule;
      m_dtOldTime    : TDateTime;
      m_blChGraph    : Boolean;
      FDMX           : PCDataMatrix;
      m_nJoin        : CJoinTable;
     public
      //m_nQS          : CQwerySystemServer;
      m_nP           : SL3GROUPTAG;
      m_nCDataView   : CCDataView;
      m_nGraphView   : CGraphView;
      procedure Init;
      procedure OnLoadViewManager;
      procedure OnLoadVMeters;
      procedure OnLoadAbonVMeters(nAID:Integer);
      procedure OnLoadAllLimits;
      procedure OnLoadVMeter(vMID:integer);
      procedure OnLoadAbon(vAID:integer);
      procedure SetDataSource(m_plDS : PCGDataSource);
      procedure DoHalfTime(Sender:TObject);
      procedure FindJoin(nVMID,nState:Integer);
      function getCurrentGraphView:TForm;
      function getCurrentDataView:TForm;
      destructor Destroy; override;
      procedure SetDataSourceID(m_plDS : CGDataSource);      
     private
      procedure SetMeterJoin(pVM:PCVMeter); 
      function  SendAllVMeter(var pMsg:CMessage):Boolean;
      //procedure DoHalfTime(Sender:TObject);dynamic;
      procedure Execute; override;
     // procedure StopLayer;
     // procedure StartLayer;
      function  EventHandler(var pMsg : CMessage):Boolean;
      function  SelfHandler(var pMsg:CMessage):Boolean;
      function  LoHandler(var pMsg:CMessage):Boolean;
      function  HiHandler(var pMsg:CMessage):Boolean;
      procedure OnReloadVMeter(nVMid,nCmdID:Integer);
      procedure OnHandler;
      procedure OnReCalc(var pMsg:CMessage);
      procedure FindRclJoin(FABOID,FVMID:Integer;FIndex:Word;FRCL:DWORD;dtTime1,dtTime2:TDateTime);
      procedure OnPinInputHandler(var pMsg : CMessage);
      procedure OnPinOutputHandler(var pMsg : CMessage);
     public
      property PForm    : TForm                    read FForm        write FForm;
      property PPage    : TAdvOfficePager             read FPage        write FPage;
      property PsgPGrid : PTAdvStringGrid          read FsgPGrid     write FsgPGrid;
      property PsgEGrid : PTAdvStringGrid          read FsgEGrid     write FsgEGrid;
      property PsgCGrid : PTAdvStringGrid          read FsgCGrid     write FsgCGrid;
      property PsgVGrid : PTAdvStringGrid          read FsgVGrid     write FsgVGrid;
      property PGView   : CGraphView               read m_nGraphView write m_nGraphView;
      property PDView   : CCDataView               read m_nCDataView write m_nCDataView;
      property PParser  : TMParser                 read FParser      write FParser;
      property PlbLocal : PTLabel                  read FlbLocal     write FlbLocal;
      property PChild   : CCalcModule              read m_nCL        write m_nCL;
      property PDMX     : PCDataMatrix             read FDMX         write FDMX;
    End;
var
     mL3Module : CL3Module = nil;
implementation
{$o-}
procedure CL3Module.OnHandler;
Begin
     EventHandler(m_nMsg);
End;
procedure CL3Module.Execute;
Begin
     mL3Module := self;
     FDEFINE(BOX_L3,BOX_L3_SZ,True);
     while not Terminated do
     Begin
      FGET(BOX_L3,@m_nMsg);
      if m_nSynchronize =1 then Synchronize(OnHandler) else
      if m_nSynchronize<>1 then
      Begin
//       if (m_nMsg.m_sbyType=AL_DATA_CALC_REQ)and(TMeterChandge.m_blHandQry=False) then
//        EventHandler(m_nMsg)
//       else
       Synchronize(OnHandler);
      End;
     End;
End;

destructor CL3Module.Destroy;
begin
  Suspend;

  if m_nCDataView <> nil then FreeAndNil(m_nCDataView);
  if m_nGraphView <> nil then FreeAndNil(m_nGraphView);

  if m_nRCL <> nil then FreeAndNil(m_nRCL);
  if m_nCL <> nil then FreeAndNil(m_nCL);

  if m_nUpdateTimer <> nil then FreeAndNil(m_nUpdateTimer);
  if m_nResTimer <> nil then FreeAndNil(m_nResTimer);
  if m_nTurnTimer <> nil then FreeAndNil(m_nTurnTimer);

  if m_nJoin <> nil then FreeAndNil(m_nJoin);

  inherited;
end;

procedure CL3Module.Init;
Begin
     m_nJoin     := CJoinTable.Create(@m_nP,False,False);
     m_blIsalc   := 0;
     m_blHandInit:= False;
     m_nLID      := 3;
     mL3Module   := self;
     m_blQRestart:= False;
     m_blFirstCover := False;
     InitPins;
     m_dtOldTime := Now;
     m_blChGraph := True;
     MONINIT;

     m_nUpdateTimer := CTimer.Create;
     m_nUpdateTimer.SetTimer(DIR_L3TOL3,DL_REPMSG_TMR,0,0,BOX_L3);
     m_nUpdateTimer.OnTimer(5);

     m_nResTimer := CTimer.Create;
     m_nResTimer.SetTimer(DIR_L3TOL3,DL_RESTARTTMR_START,0,0,BOX_L3);
     m_nTurnTimer := CTimer.Create;
     m_nTurnTimer.SetTimer(DIR_L3TOL3,DL_TURNOFFTMR_START,0,0,BOX_L3);

     OnLoadViewManager;
     if m_nCF.QueryType<>QWR_QWERY_SRV then
     OnLoadVMeters;
     m_nCL := CCalcModule.Create;
     m_nCL.Init(@m_nP,@m_nVM);
     m_nRCL:= CRclModule.Create;
     m_nRCL.Init(@m_nP);

     Priority    := tpHigher;
     Resume;
End;
procedure CL3Module.OnLoadViewManager;
Begin
     m_nGraphView          := CGraphView.Create(FForm);
     m_nGraphView.PPage    := FPage;
     m_nGraphView.PsgPGrid := FsgPGrid;
     m_nGraphView.PsgEGrid := FsgEGrid;
     m_nGraphView.Init;

     m_nCDataView          := CCDataView.Create(FForm);
     m_nCDataView.PPage    := FPage;
     m_nCDataView.PsgCGrid := FsgCGrid;
     m_nCDataView.PsgVGrid := FsgVGrid;
     m_nCDataView.Init;
End;

procedure CL3Module.OnLoadAllLimits;
var pLMT                : SL3LIMITTAGS;
    TempCMDID, TempVMID : integer;
    i, j, Count         : integer;
begin
   m_pDB.GetAllLimitDatas(pLMT);              //Загрузка всех лимтов с БД
   for i := 0 to pLMT.Count - 1 do
     pLMT.Items[i].IsLoad := false;
   for i := 0 to pLMT.Count - 1 do
   begin
     if pLMT.Items[i].IsLoad then
       continue;
     TempVMID  := pLMT.Items[i].m_swVMID;
     TempCMDID := pLMT.Items[i].m_swCMDID;
     Count     := 0;
     for j := 0 to pLMT.Count - 1 do          //Подсчет количества лимитов для загрузки в 3vparams
       if (pLMT.Items[j].m_swVMID = TempVMID) and (pLMT.Items[j].m_swCMDID = TempCMDID) then
         Inc(Count);
     with m_nVM.Items[pLMT.Items[i].m_swVMID].m_nVParam[pLMT.Items[i].m_swCMDID] do
     begin
       SetLength(LimitData.Items, Count);
       LimitData.Count          := Count;
       LimitData.IsMaxValNormal := true;
       LimitData.IsMinValNormal := true;
       Count                    := 0;
       for j := 0 to pLMT.Count - 1 do        //Загрузка лимитов
         if (pLMT.Items[j].m_swVMID = TempVMID) and (pLMT.Items[j].m_swCMDID = TempCMDID) then
         begin
           pLMT.Items[j].IsLoad := true;
           LimitData.ABOID                := pLMT.Items[j].m_swABOID;
           LimitData.Items[Count].Tarr    := pLMT.Items[j].m_swTID;
           LimitData.Items[Count].minVal  := pLMT.Items[j].m_swMinValue;
           LimitData.Items[Count].maxVal  := pLMT.Items[j].m_swMaxValue;
           LimitData.Items[Count].DateBeg := pLMT.Items[j].m_sDateBeg;
           LimitData.Items[Count].DateEnd := pLMT.Items[j].m_sDateEnd;
           Inc(Count);
         end;
     end;
   end;
end;
procedure CL3Module.OnLoadVMeters;
Var
     i    : Integer;
     pVM  : PCVMeter;
     pVMT : PSL3VMETERTAG;
Begin
     //m_pDB.GetMetNameTable(m_sMTName);
     m_pDB.GetVMNameTable(m_sVMName);
     if m_pDB.GetVMetersFullTable(-1,m_nP)=True then
     Begin
      m_nVM.Count := m_nP.m_swAmVMeter;
      for i:=0 to m_nVM.Count-1 do
      Begin
       pVMT  := @m_nP.Item.Items[i];
       pVM   := @m_nVM.Items[pVMT.m_swVMID];
       if pVM^= Nil then pVM^ := CVMeter.Create(pVMT) else
       if pVM^<>Nil then pVM.Init(pVMT);
       SetMeterJoin(pVM);
      End;
      m_pDB.GetTMTarifsTableEx(0,0,0,TarTable);
      OnLoadAllLimits;
     End;
End;
procedure CL3Module.OnLoadAbonVMeters(nAID:Integer);
Var
     i    : Integer;
     pVM  : PCVMeter;
     pVMT : PSL3VMETERTAG;
Begin
     if m_nCF.QueryType=QWR_QWERY_SRV then
     Begin
      if(PDMX<>nil) then
      Begin
       PDMX.OnInitDMX(nAID,-1);
      // SendMsg(BOX_CSRV,0,DIR_L3TOCS,CSRV_INIT_JMTX);
      End;
     End;
     if m_pDB.GetAbonVMetersFullTable(nAID,m_nP)=True then
     Begin
      m_nVM.Count := m_nP.m_swAmVMeter;
      for i:=0 to m_nVM.Count-1 do
      Begin
       pVMT  := @m_nP.Item.Items[i];
       pVM   := @m_nVM.Items[pVMT.m_swVMID];
       if pVM^= Nil then pVM^ := CVMeter.Create(pVMT) else
       if pVM^<>Nil then pVM.Init(pVMT);
       SetMeterJoin(pVM);
       if m_nCF.QueryType=QWR_QWERY_SRV then
       Begin
        pVM.Destroy;
        m_nP.m_swAmVMeter := 0;
        m_nP.Item.Count   := 0;
        pVM^ := Nil;
       End;
      End;
      m_pDB.GetTMTarifsTableEx(0,0,0,TarTable);
      OnLoadAllLimits;
     End;
End;
procedure CL3Module.SetMeterJoin(pVM:PCVMeter);
Var
     j,nVMID : Integer;
     str  : String;
Begin
     nVMID := pVM.m_nP.m_swVMID;
     m_nJoin.FreeHiJoin;
     m_nJoin.GetHiJoin(nVMID);
     pVM.SetHiBalance(@m_nJoin);
     str := '';for j:=0 to m_nJoin.m_pQSMD.Count-1 do str := str + IntToStr(m_nJoin.m_pQSMD.Items[j])+',';
//     TraceL(3,nVMID,'(__)CL3MD::>HI VMID('+IntToStr(nVMID)+')='+str);
     m_nJoin.FreeHiJoin;
     m_nJoin.GetLoJoin(nVMID);
     pVM.SetLoBalance(@m_nJoin);
     str := '';for j:=0 to m_nJoin.m_pQSMD.Count-1 do str := str + IntToStr(m_nJoin.m_pQSMD.Items[j])+',';
//     TraceL(3,nVMID,'(__)CL3MD::>LO VMID('+IntToStr(nVMID)+')='+str);
End;
procedure CL3Module.OnLoadVMeter(vMID:integer);
Var
     i    : Integer;
     pVM  : PCVMeter;
     pVMT : PSL3VMETERTAG;
Begin
     for i:=0 to m_nP.Item.Count-1 do
     if m_nP.Item.Items[i].m_swVMID=vMID then
     Begin
      pVMT := @m_nP.Item.Items[i];
      if m_pDB.GetVMeterTable(pVMT^)=True then
      Begin
       pVM := @m_nVM.Items[pVMT.m_swVMID];
       //pVM := @m_nVM.Items[i];
       pVM.Init(pVMT);
      End;
      exit;
     End;
End;
procedure CL3Module.OnLoadAbon(vAID:integer);
Var
     i      : Integer;
     pTable : SL3GROUPTAG;
Begin
     if m_pDB.GetAbonVMIDTable(vAID,pTable)=True then
     Begin
      for i:=0 to pTable.Item.Count-1 do
      OnLoadVMeter(pTable.Item.Items[i].m_swVMID);
     End;
End;
procedure CL3Module.OnReloadVMeter(nVMid,nCmdID:Integer);
Var
     pTable:SL3VMETERTAG;
     i : Integer;
Begin
     if m_nCF.QueryType=QWR_QWERY_SRV then exit;
     if m_pDB.GetVParamsTable(nVMid,pTable)then
     Begin
      try
      for i:=0 to pTable.m_swAmParams-1 do
      Begin
       if pTable.Item.Items[i].m_swParamID=m_nP.Item.Items[nVMid].Item.Items[i].m_swParamID then
       Move(pTable.Item.Items[i],m_nP.Item.Items[nVMid].Item.Items[i],sizeof(SL3PARAMS));
      End;
       m_nVM.Items[nVMid].OnLoadVParams;
      except
       //TraceER('(__)CERMD::>Error In CL3Module.OnReloadVMeter!!!');
      End;
     End;
End;
function CL3Module.EventHandler(var pMsg : CMessage):Boolean;
Begin
  Result:=True;
     try
     case pMsg.m_sbyFor of
      DIR_L3TOL3    : SelfHandler(pMsg);
      DIR_L2TOL3    : LoHandler(pMsg);
      DIR_L4TOL3    : HiHandler(pMsg);
     End;
     except
     // TraceER('(__)CERMD::>Error In CL3Module.EventHandler!!!');
       Result:=True;
     End;
End;
function CL3Module.SelfHandler(var pMsg:CMessage):Boolean;
Var
     pDS : CMessageData;
Begin
  Result:=True;
  try
     case pMsg.m_sbyType of
      DL_REPMSG_TMR:
      Begin
       //m_nUpdateTimer.OnTimer(1);
      End;
      DL_KEYS_TMR: m_nPMD.KeysHandler;
      DL_CMPR_TMR: m_nPMD.CmprHandler;
      DL_LOCK_TMR: m_nPMD.LockHandler;
      DL_UNLK_TMR: m_nPMD.UnlkHandler;
      DL_DAYS_LOCK_TMR : m_nPMD.CheckLicenseDay;
      DL_GSM_SET_TMR,
      DL_GSM_FRE_TMR,
      DL_GSM_DSC_TMR,
      DL_GSM_CHSP_TMR,
      DL_GSM_DEL_SRV_TMR,
      DL_GSM_WOPEN_TMR:
      Begin
       //TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>DL_GSM_SET_TMR:');
       m_nCF.m_nSDL.m_nGST.EventHandler(pMsg);
      End;
      //DL_LDONE_MTR_TMOF_IND : TMeterChandge.EventHandler(pMsg);
      DL_RESTARTTMR_START   : Begin
                               m_blQRestart := True;
                              End;
      DL_TURNOFFTMR_START   : Begin
                               pDS.m_swData0 := 0;
                               pDS.m_swData1 := 0;
                               SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_TURNOFF_REQ,pDS);
                               m_blQRestart  := False;
                              End;
      DL_USR_CNTRL_TMR,
      DL_HRD_KEY_CTRL_TMR   : m_nCF.m_nUsrCtrl.EventHandler(pMsg);
     End;
  except
       Result:=True;
  End;
End;
function CL3Module.getCurrentGraphView:TForm;
Begin
     Result := m_nGraphView.getView(@m_lDS);
End;
function CL3Module.getCurrentDataView:TForm;
Begin
     Result := m_nCDataView.getView(@m_lDS);
End;
function CL3Module.LoHandler(var pMsg:CMessage):Boolean;
Begin
  Result:=True;
  try
     case pMsg.m_sbyType of
      DL_DATARD_IND, PH_EVENTS_INT, PH_MON_ANS_IND:
      Begin
       //TraceM(4,pMsg.m_swObjID,'(__)CL3MD::>MSG    DIN:',@pMsg);
       SendAllVMeter(pMsg);
      End;
      DL_MONINFO_IND:
      Begin
//       TraceM(4,pMsg.m_swObjID,'(__)CL3MD::>MSG QSOUT:',@pMsg);
       //SendMatrix(pMsg);
      End;
      AL_SETPULSE_IND:
      Begin
        if pMsg.m_swObjID<m_nDIO.Count then
        m_nDIO.Items[pMsg.m_swObjID].SetPulce;
       End;
       AL_SETPIN_IND:
       Begin
        if pMsg.m_swObjID<m_nDIO.Count then
        m_nDIO.Items[pMsg.m_swObjID].SetPinState(pMsg.m_sbyDirID);
       End;
       AL_CHANDGEPIN_IND:
       Begin
        case pMsg.m_sbyTypeIntID of
          PIN_INPUT:
          Begin
            OnPinInputHandler(pMsg);
          End;
          PIN_OUTPT:
          Begin
            OnPinOutputHandler(pMsg);
          End;
        End
       End;
     End;
 except
       Result:=True;
 End;
End;
function CL3Module.HiHandler(var pMsg:CMessage):Boolean;
Var
      pDS : CMessageData;
Begin
  Result:=True;
  try
      case pMsg.m_sbyType of
       AL_DATA_CALC_REQ:
       Begin
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        case m_nCF.QueryType of
           QWR_EQL_TIME,QWR_QWERY_SHED :
           Begin
             if (pDS.m_swData1=QRY_SRES_ENR_EP) then
             m_nCL.OnCalc(QRY_SUM_RASH_V,pDS.m_swData2,false);
             m_nCL.OnCalc(pDS.m_swData1,pDS.m_swData2,true);
           End;
           QWR_FIND_SHED               : m_nCL.OnCalculate(pDS.m_swData0,pDS.m_swData1,pDS.m_swData2);
        End;
        //SendMSG(BOX_L4,0,DIR_L1TOL4,QL_START_TRANS_REQ);
        pDS.m_swData4 := MTR_LOCAL;
        SendMsgData(BOX_L3_LME,pMsg.m_swObjID,DIR_LHTOLM3,AL_DATA_FIN_CALC_IND,pDS);
        SendMSG(BOX_L3_HF,0,DIR_L4TOL3,SL_FIN_POLL_REQ);
        pMsg.m_sbyType := DL_LDONE_MTR_CALC_IND;
//        TMeterChandge.EventHandler(pMsg);
       End;
       AL_RESETPARAMS_REQ : m_nCL.OnFree;
       AL_LOADVMET_IND    : OnLoadVMeter(pMsg.m_swObjID);
       AL_VIEWDATA_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_VIEWDATA_REQ:');
        m_nCDataView.CreateView(@m_lDS);
       End;
       AL_UPDATEDATA_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATEDATA_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nCDataView.Update(pDS.m_swData0);
       End;
       AL_REFRESHDATA_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_REFRESHDATA_REQ:');
        m_nCDataView.RefreshAll;
       End;
       AL_UPDATEALLDATA_REQ:
       Begin
        if m_blMinimized=False then
        Begin
//         TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATEALLDATA_REQ:');
         m_nCDataView.UpdateAll;
        End;
       End;
       AL_UPDMETADATA_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDMETADATA_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nCDataView.UpdateMeta(pDS.m_swData0);
       End;
       AL_UPDATETTARIF_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATETTARIF_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nCDataView.UpdateTarifData(pDS.m_swData0);
       End;
       AL_VIEWGRAPH_REQ:
       Begin
 //       TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_VIEWGRAPH_REQ:');
        m_nGraphView.CreateView(@m_lDS);                                     // breakpoint
       End;
       AL_UPDATEGRAPH_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATEGRAPH_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nGraphView.Update(pDS.m_swData0,pDS.m_swData1);
       End;
       AL_UPDATEALLGRAPH_REQ:
       Begin
        if m_blMinimized=False then
        Begin
//         TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATEALLGRAPH_REQ:');
         m_nCDataView.UpdateAll;
         m_nGraphView.UpdateAll;
         {
         if (m_blChGraph=True)and(trunc(Now)<>trunc(m_dtOldTime)) then
         Begin
          m_dtTime1 := Now;
          m_dtTime2 := Now;
          m_blChGraph := False;
         End;
         }
        End;
       End;
       AL_UPDATESHEM_IND:
       Begin
        if m_blMinimized=False then
        Begin
//         TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATESHEM_IND:');
         //TShemLoader.RefreshForms;
        End;
       End;
       AL_UPDATETSLICE_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATETSLICE_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nGraphView.UpdateSlice(pDS.m_swData0,pDS.m_swData1);
       End;
       AL_UPDATETARCH_REQ:
       Begin
//       TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_UPDATETARCH_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nGraphView.UpdateArchive(pDS.m_swData0,pDS.m_swData1);
       End;
       AL_VIEWREPLACED_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_VIEWREPLACED_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        m_nCDataView.ReplacedView(pDS.m_swData0,pDS.m_swData1);
       End;
       AL_RELOADVMET_REQ:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_RELOADVMET_REQ:');
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        OnReloadVMeter(pDS.m_swData0,pDS.m_swData1);
        //m_nCDataView.ReplacedView(pDS.m_swData0,pDS.m_swData1);
       End;
       AL_RECALC_IND:
       Begin
//        TraceL(4,pMsg.m_swObjID,'(__)CL3MD::>AL_RECALC_IND:');
        OnReCalc(pMsg);
        //Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        //OnReloadVMeter(pDS.m_swData0,pDS.m_swData1);
        //m_nCDataView.ReplacedView(pDS.m_swData0,pDS.m_swData1);
       End;
       AL_FINDJOIN_IND:
       Begin
        Move(pMsg.m_sbyInfo[0],pDS,sizeof(pDS));
        FindJoin(pMsg.m_swObjID,pDS.m_swData0);
       End;
      End;
 except
       Result:=True;
 End;
End;
procedure CL3Module.SetDataSource(m_plDS : PCGDataSource);
Begin
      Move(m_plDS^,m_lDS,sizeof(CTreeIndex));

      m_lDS.strCaption :=m_plDS.strCaption;
      m_lDS.dtTime0    :=m_plDS.dtTime0;
      m_lDS.dtTime1    :=m_plDS.dtTime1;
      m_lDS.strClassName:=m_plDS.strClassName;

      m_lDS.nHeight    :=m_plDS.nHeight;
      m_lDS.nWidth     :=m_plDS.nWidth;
      m_lDS.pOwner     :=m_plDS.pOwner;
End;
procedure CL3Module.SetDataSourceID(m_plDS : CGDataSource);
Begin
      Move(m_plDS,m_lDS,sizeof(CTreeIndex));
      {
      m_lDS.PKey       :=m_plDS.PKey;
      m_lDS.FKey       :=m_plDS.FKey;
      m_lDS.FParam     :=m_plDS.FParam;
      m_lDS.FParam1    :=m_plDS.FParam1;
      m_lDS.FParam2    :=m_plDS.FParam2;
      m_lDS.FParam3    :=m_plDS.FParam3;
      m_lDS.FParam4    :=m_plDS.FParam4;
      }
      m_lDS.strCaption :=m_plDS.strCaption;
      m_lDS.dtTime0    :=m_plDS.dtTime0;
      m_lDS.dtTime1    :=m_plDS.dtTime1;
      m_lDS.strClassName:=m_plDS.strClassName;
      //m_lDS.pData      :=m_plDS.;
      //m_lDS.nViewID    :=m_plDS.nViewID;
      m_lDS.nHeight    :=m_plDS.nHeight;
      m_lDS.nWidth     :=m_plDS.nWidth;
      m_lDS.pOwner     :=m_plDS.pOwner;
End;


procedure CL3Module.OnReCalc(var pMsg:CMessage);
Var
     pDS       : CMessageData;
     FABOID    : Integer;
     FVMID     : Integer;
     FRCL      : DWord;
     FIndex    : Word;
     dtTime1,dtTime2 : TDateTime;
     szDT      : Integer;
begin
     if m_nCF.QueryType=QWR_QWERY_SRV then exit;
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     FABOID          := pDS.m_swData3;
     FVMID           := pDS.m_swData2;
     FRCL            := pDS.m_swData1;
     FIndex          := pDS.m_swData0;
     szDT            := sizeof(TDateTime);
     Move(pDS.m_sbyInfo[0],dtTime1,szDT);
     Move(pDS.m_sbyInfo[szDT],dtTime2,szDT);
     FlbLocal.Caption := 'Запуск дорасчета c '+DateToStr(dtTime2)+' по '+DateToStr(dtTime1);
     if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,FlbLocal.Caption);
     FlbLocal.Refresh;
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STARTRCLC_REQ));

     m_ngRCL.OnSetReCalc(FABOID,FVMID,FIndex,FRCL,dtTime1, dtTime2);
     FindRclJoin(FABOID,FVMID,FIndex,FRCL,dtTime1,dtTime2);

     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RCALC_CPLT_REQ,pDS);
     if m_blIsSlave=False then FlbLocal.Caption := 'Дорасчет выполнен';
     if m_blIsSlave=True  then SendRSMsgM(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_STOPRCLC_REQ));
end;

procedure CL3Module.FindRclJoin(FABOID,FVMID:Integer;FIndex:Word;FRCL:DWORD;dtTime1,dtTime2:TDateTime);
Var
     i    : Integer;
     pVM  : PCVMeter;
     pVMT : PSL3VMETERTAG;
Begin
     for i:=0 to m_nP.m_swAmVMeter-1 do
     Begin
      pVMT := @m_nP.Item.Items[i];
      pVM  := @m_nVM.Items[pVMT.m_swVMID];
      if ((pVM.m_nP.m_sbyType=MET_SUMM)or(pVM.m_nP.m_sbyType=MET_GSUMM))and(pVMT.m_swVMID<>FVMID) then
      if pVM.FindJoinEx(FVMID,FIndex)=True then
      Begin
       m_ngRCL.OnSetReCalc(FABOID,pVMT.m_swVMID,FIndex,FRCL,dtTime1, dtTime2);
       FindRclJoin(FABOID,pVMT.m_swVMID,FIndex,FRCL,dtTime1,dtTime2);
      End;
     End;
End;

procedure CL3Module.FindJoin(nVMID,nState:Integer);
Var
     i,j    : Integer;
     pVM  : PCVMeter;
     pVMT : PSL3VMETERTAG;
Begin
     for i:=0 to m_nP.m_swAmVMeter-1 do
     Begin
      pVMT := @m_nP.Item.Items[i];
      pVM  := @m_nVM.Items[pVMT.m_swVMID];
      if (pVMT.m_swVMID=nVMID) then
      Begin
       //if ((pVM.m_nP.m_sbyType=MET_SUMM)or(pVM.m_nP.m_sbyType=MET_GSUMM)) then exit;
       for j:=0 to pVM.m_nHiJoin.Count-1 do
       Begin
        if nState=PR_FAIL then m_nVM.Items[pVM.m_nHiJoin.Items[j]].SetLockState;
        if nState=PR_TRUE then m_nVM.Items[pVM.m_nHiJoin.Items[j]].ReSetLockState;
       End;
      End;
     End;
End;
function CL3Module.SendAllVMeter(var pMsg:CMessage):Boolean;
Var
     res    : Boolean;
     i,nMID : Integer;
     pVM    : PCVMeter;
     pVMT   : PSL3VMETERTAG;
Begin
  Result:=True;
  try
     res := False;
     try
     nMID := pMsg.m_swObjID;
     for i:=0 to m_nP.m_swAmVMeter-1 do
     Begin
      pVMT := @m_nP.Item.Items[i];
      if Assigned(m_nVM.Items[pVMT.m_swVMID]) then
      Begin
      pVM  := @m_nVM.Items[pVMT.m_swVMID];
      if pVM.m_nP.m_swMID=nMID then
      Begin
       pMsg.m_swObjID := pVMT.m_swVMID;
       res := pVM.EventHandler(pMsg);
      End;
      End;
     End;
     Result := res;
     except
      //TraceER('(__)CL3MD::>Error In CL3Module.SendAllVMeter!!!');
     end;
  except
  Result:=True;
  end;
End;
procedure CL3Module.OnPinInputHandler(var pMsg : CMessage);
var pDS : CMessageData;

begin
   FillChar(pDS,sizeof(pDS),0);
   case pMsg.m_swObjID of
     0 : if pMsg.m_sbyDirID=PH_1_TO_0_EV then
         begin
//             TraceL(3,pMsg.m_swObjID,'(__)CL3MD::>EVH_RESET_PREPARE');
             m_nResTimer.OnTimer(3);
             m_nTurnTimer.OnTimer(8);
             m_blQRestart := False;
         end else
         if pMsg.m_sbyDirID=PH_0_TO_1_EV then
         begin
             if m_nResTimer.IsProceed=True then
             Begin
              m_nResTimer.OffTimer;
              m_nTurnTimer.OffTimer;
              m_blQRestart := False;
//              TraceL(3,pMsg.m_swObjID,'(__)CL3MD::>EVH_RESET_FAIL');
             End else
             Begin
              if m_blQRestart = True then
              Begin
               pDS.m_swData0 := 0;
               pDS.m_swData1 := 1;
               SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_TURNOFF_REQ,pDS);
               m_nTurnTimer.OffTimer;
              End;
             End;
         End;
     1 : if pMsg.m_sbyDirID=PH_0_TO_1_EV then
         Begin
//          TraceL(3,pMsg.m_swObjID,'(__)CL3MD::>EVH_OPN_COVER');
          if m_blFirstCover=False then Begin m_blFirstCover:=True; m_byCoverState := 1;exit;End;
         // m_pDB.FixUspdEvent(0, 0, EVH_OPN_COVER);
          m_byCoverState := 1;
         End else if pMsg.m_sbyDirID=PH_1_TO_0_EV then
         Begin
//         TraceL(3,pMsg.m_swObjID,'(__)CL3MD::>EVH_CLS_COVER');
          if m_blFirstCover=False then Begin m_blFirstCover:=True; m_byCoverState := 0;exit;End;
         // m_pDB.FixUspdEvent(0, 0, EVH_CLS_COVER);
          m_byCoverState := 0;
         End;
     2 : if pMsg.m_sbyDirID=PH_0_TO_1_EV then
         begin
           //pDS.m_swData0 := 0;
           //pDS.m_swData1 := 1;
           //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_TURNOFF_REQ,pDS);
         end;
   end;
end;

procedure CL3Module.OnPinOutputHandler(var pMsg : CMessage);
begin
//   if pMsg.m_sbyDirID=PH_0_TO_1_EV then TraceL(3,pMsg.m_swObjID,'(__)CL3MD::>AL_CHANDGEPIN_IND: OUTPT :PH_0_TO_1_EV');
//   if pMsg.m_sbyDirID=PH_1_TO_0_EV then TraceL(3,pMsg.m_swObjID,'(__)CL3MD::>AL_CHANDGEPIN_IND: OUTPT :PH_1_TO_0_EV');
end;

procedure CL3Module.DoHalfTime(Sender:TObject);
Begin
     try
   //   if m_nResTimer<>Nil then m_nResTimer.RunTimer;
   //   if m_nTurnTimer<>Nil then m_nTurnTimer.RunTimer;
   //   MONRUN;
      if m_nCF.m_nUsrCtrl<>Nil then m_nCF.m_nUsrCtrl.RunTimer;
     except
      //TraceL(3,0,'(__)CL3MD::>Error Timer Routing.');
     End
End;

end.
