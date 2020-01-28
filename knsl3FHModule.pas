unit knsl3FHModule;
//Find Holes Module

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,extctrls,knsl3recalcmodule,
    utldatabase,knsl3vmeter,knsl3viewgraph,knsl3viewcdata,forms,utlmtimer,knsl5tracer,
    Parser10,knsl3calcmodule,knsl5config, utlTimeDate, knsl2module;
type
  SQWMEM=packed record
   m_nOldParamID  : Integer;
   m_nOldDate     : TDateTime;
  End;
  SQWMEMS=packed record
   Count : Integer;
   Items : array[0..5000] of SQWMEM;
  End;

  CL3FindHolesModule = class
    private
      qParamToLoad   : array [0..QRY_END] of boolean;
      PortID         : integer;
      ABOID          : integer;
      FVMID          : integer;
      FSVMID         : integer;
      m_nMask        : int64;
      dt_DateBegin   : TDateTime;
      dt_DateEnd     : TDateTime;
      qm_ParamsDescr : QM_PARAMS;
      m_pVMTable     : SL3GROUPTAG;
      m_sTblL1       : SL1INITITAG;
      m_nMEM         : SQWMEMS;
      //procedure StartQryFH(dtFirst,n:TDateTime;);
      procedure FreeFindIndex;
      procedure AddFindIndex(PID:Integer;DATE:TDateTime);
      function  FindIndex(PID:Integer;DATE:TDateTime):Boolean;


      function  IsMeterEnable(MID : integer) : boolean;
      procedure SendMSGToLoad_Old(VMID, MID, PID : integer; Date : TDateTime);
      function  IsParamEnable(MID, PID : integer) : boolean;
      procedure SendMSGToLoad(VMID, MID, PID : integer; Date : TDateTime;blMon:Boolean);
      procedure SendMSGToLoad_New(VMID, MID, PID : integer; Date : TDateTime;blMon:Boolean);
      procedure SendCurrMSGToLoad(VMID, MID,  PRID, PID : integer);
      procedure SendEventMSGToLoad(VMID,MID,PRID:integer;wLoMask:int64);
      procedure SendRecalcToLoad(VMID,PID:integer;dwMask:DWord);
      procedure SendRecalcToLoadTime(VMID,PID:integer;dwMask:DWord; Date : TDateTime);
      function  FindStartDate(Delta : integer; dt_Date : TDateTime) : TDateTime;
      procedure IncDateTime(Delta : integer; var dt_Date : TDateTime);
      function  FindDateInArch(Date : TDateTime; var pTable : CCDatas) : integer;
      function  FindDateInGraph(Date : integer; var pTable : L3GRAPHDATAS) : integer;
      function  FindDateInPeriod(Date : TDateTime; var pTable : CCDatas) : integer;
      procedure FindHolesInArch(VMID, MID, PID : integer);
      procedure FindHolesInGraph(VMID, MID, PID : integer);
      procedure FindHolesInPeriod(VMID, MID, PID : integer);
      procedure FindHolesInMonitor(VMID, MID, PID : integer);
      procedure FindHoles(var ParamID : integer);
      function  GetRealPort(nPort:Integer):Integer;
      procedure SetQryMask(dwLoMask:int64);
    public
      m_pDDB         : PCDBDynamicConn;
      procedure Init;
      procedure DoHalfTime(Sender:TObject);
      function  EventHandler(var pMsg : CMessage):Boolean;
      function  SelfHandler(var pMsg:CMessage):Boolean;
      function  LoHandler(var pMsg:CMessage):Boolean;                                                
      function  HiHandler(var pMsg:CMessage):Boolean;
      procedure AddParamToLoad(PID : integer);
      procedure SetPeriod(dtFTime,dtETime:TDateTime);
      procedure SetDefDate;
      procedure SetParamToLoad(PID : integer);
      procedure SetDefaultParams;
      procedure ResetParamsToLoad;
      procedure OnHandler;
      procedure RunFHModule;
      procedure SetDefSett;
      procedure StartModule(nABOID,nVMID:Integer;dtFTime,dtETime:TDateTime;dwLoMask,dwMdMask,dwHiMask:int64);
      function  FindAbonHoles(nABOID,nVMID:Integer;dtFTime,dtETime:TDateTime;dwLoMask:int64):Integer;
      function  AddFindAbonHoles(nABOID,nVMID:Integer;dtFTime,dtETime:TDateTime;dwLoMask:int64):Integer;
      function  FindProc:Integer;
      function  LoadCurrent(blFree:Boolean;wLoMask:int64):Integer;
      function  LoadMonNetParam(blFree:Boolean;wLoMask:int64):Integer;
      function  LoadNetParam(blFree:Boolean;wLoMask:int64):Integer;
      function  LoadCorrTime(blFree:Boolean):Integer;
      function  LoadEvents(blFree:Boolean;wLoMask:int64):Integer;
      function  LoadRecalc(blFree:Boolean;wLoMask:int64):Integer;
      procedure SendFinalQuery;
      procedure Go;
    end;
var
   mL3FHModule : CL3FindHolesModule;
const
   DeltaFH     : array [0..10] of integer = (1, 1,2,3,5, 7, 14, 31, 62, 182, 365);
   MAX_FINDMEM = 5000;
implementation
procedure CL3FindHolesModule.SetPeriod(dtFTime,dtETime:TDateTime);
Begin
   dt_DateBegin := dtFTime;
   dt_DateEnd   := dtETime;
end;
procedure CL3FindHolesModule.SetDefDate;
Begin
   dt_DateBegin := Now - DeltaFH[m_nCF.cbm_DeltaFH.ItemIndex];
   dt_DateEnd   := Now;
end;
procedure CL3FindHolesModule.StartModule(nABOID,nVMID:Integer;dtFTime,dtETime:TDateTime;dwLoMask,dwMdMask,dwHiMask:int64);
Var
   i : Integer;
Begin
   FFREE(BOX_LOAD);
   ABOID  := nABOID;
   FVMID  := nVMID;
   FSVMID := dwMdMask;
   m_nMask:= dwLoMask;
   FreeFindIndex;
   m_pDDB.GetVMetersAbonTable(nABOID,nVMID,m_pVMTable);
   SetPeriod(dtFTime,dtETime);
   ResetParamsToLoad;
   if (dwLoMask and (QFH_ARCH_EN or QFH_POD_TRYB_HEAT))<>0 then Begin SetQryMask(dwLoMask);RunFHModule;End;
   if ((dwLoMask and QFH_ANET_EN)<>0)and((dwLoMask and QFH_AMNET_EN)<>0) then LoadMonNetParam(False,dwLoMask);
   if (dwLoMask and QFH_ANET_EN)<>0      then LoadNetParam(False,dwLoMask);
   if (dwLoMask and QFH_CURR)<>0         then LoadCurrent(False,dwLoMask);
   if (dwLoMask and QFH_CORR_TIME)<>0    then LoadCorrTime(False);
   if (dwLoMask and QFH_JUR_EN)<>0       then LoadEvents(False,dwLoMask);
   SendFinalQuery;
   //if (dwLoMask and QFH_RECALC_ABOID)<>0 then LoadRecalc(False,dwLoMask);
   Go;
End;
function CL3FindHolesModule.FindAbonHoles(nABOID,nVMID:Integer;dtFTime,dtETime:TDateTime;dwLoMask:int64):Integer;
Var
   i : Integer;
Begin
   FFREE(BOX_LOAD);
   SetPeriod(dtFTime,dtETime);
   ABOID  := nABOID;
   FVMID  := nVMID;
   m_nMask:= dwLoMask;
   m_pDDB.GetVMetersAbonTable(nABOID,nVMID,m_pVMTable);
   ResetParamsToLoad;
   if (dwLoMask and (QFH_ARCH_EN or QFH_POD_TRYB_HEAT))<>0 then Begin SetQryMask(dwLoMask);FindProc;End;
   if ((dwLoMask and QFH_ANET_EN)<>0)and((dwLoMask and QFH_AMNET_EN)<>0) then LoadMonNetParam(False,dwLoMask);
   if (dwLoMask and QFH_ANET_EN)<>0      then LoadNetParam(False,dwLoMask);
   if (dwLoMask and QFH_CURR)<>0         then LoadCurrent(False,dwLoMask);
   if (dwLoMask and QFH_CORR_TIME)<>0    then LoadCorrTime(False);
   if (dwLoMask and QFH_JUR_EN)<>0       then LoadEvents(False,dwLoMask);
   //if (dwLoMask and QFH_RECALC_ABOID)<>0 then LoadRecalc(False,dwLoMask);
   SendFinalQuery;
   Result := FCHECK(BOX_LOAD);
End;
function CL3FindHolesModule.AddFindAbonHoles(nABOID,nVMID:Integer;dtFTime,dtETime:TDateTime;dwLoMask:int64):Integer;
Var
   i : Integer;
Begin
   //FFREE(BOX_LOAD);
   SetPeriod(dtFTime,dtETime);
   m_nMask:= dwLoMask;
   m_pDDB.GetVMetersAbonTable(nABOID,nVMID,m_pVMTable);
   ResetParamsToLoad;
   if (dwLoMask and (QFH_ARCH_EN or QFH_POD_TRYB_HEAT))<>0 then Begin SetQryMask(dwLoMask);FindProc;End;
   if ((dwLoMask and QFH_ANET_EN)<>0)and((dwLoMask and QFH_AMNET_EN)<>0) then LoadMonNetParam(False,dwLoMask);
   if (dwLoMask and QFH_ANET_EN)<>0   then LoadNetParam(False,dwLoMask);
   if (dwLoMask and QFH_CURR)<>0      then LoadCurrent(False,dwLoMask);
   if (dwLoMask and QFH_CORR_TIME)<>0 then LoadCorrTime(False);
   Result := FCHECK(BOX_LOAD);
End;
procedure CL3FindHolesModule.SetDefSett;
Begin
   SetDefDate;
   SetDefaultParams;
   m_pDDB.GetVMetersTable(-1,-1,m_pVMTable);
End;
{
  QFH_ENERGY_DAY_EP            = $0000000000000001;
  QFH_ENERGY_MON_EP            = $0000000000000002;
  QFH_SRES_ENR_EP              = $0000000000000004;
  QFH_NAK_EN_DAY_EP            = $0000000000000008;
  QFH_NAK_EN_MONTH_EP          = $0000000000000010;
  QFH_POD_TRYB_HEAT            = $0000000000000020;
  QFH_POD_TRYB_RASX            = $0000000000000040;
  QFH_POD_TRYB_TEMP            = $0000000000000080;
  QFH_POD_TRYB_V               = $0000000000000100;
  QFH_OBR_TRYB_HEAT            = $0000000000000200;
  QFH_OBR_TRYB_RASX            = $0000000000000400;
  QFH_OBR_TRYB_TEMP            = $0000000000000800;
  QFH_OBR_TRYB_V               = $0000000000001000;
  QFH_TEMP_COLD_WAT_DAY        = $0000000000002000;
  QFH_POD_TRYB_RUN_TIME        = $0000000000004000;
  QFH_WORK_TIME_ERR            = $0000000000008000;

  QFH_ANET_EN                  = $0000000000080000;
  QFH_ANET_U                   = $0000000000100000;
  QFH_ANET_I                   = $0000000000200000;
  QFH_ANET_FI                  = $0000000000400000;
  QFH_ANET_CFI                 = $0000000000800000;
  QFH_ANET_F                   = $0000000001000000;

}
procedure CL3FindHolesModule.SetQryMask(dwLoMask:int64);
Begin
   if (dwLoMask and QFH_ENERGY_DAY_EP)<>0     then AddParamToLoad(QRY_ENERGY_DAY_EP);
   if (dwLoMask and QFH_ENERGY_MON_EP)<>0     then AddParamToLoad(QRY_ENERGY_MON_EP);
   if (dwLoMask and QFH_SRES_ENR_EP)<>0       then AddParamToLoad(QRY_SRES_ENR_EP);
   if (dwLoMask and QFH_NAK_EN_DAY_EP)<>0     then AddParamToLoad(QRY_NAK_EN_DAY_EP);
   if (dwLoMask and QFH_NAK_EN_MONTH_EP)<>0   then AddParamToLoad(QRY_NAK_EN_MONTH_EP);
   if (dwLoMask and QFH_POD_TRYB_HEAT)<>0     then AddParamToLoad(QRY_POD_TRYB_HEAT);
   {
   if (dwLoMask and QFH_POD_TRYB_RASX)<>0     then AddParamToLoad(QRY_POD_TRYB_RASX);
   if (dwLoMask and QFH_POD_TRYB_TEMP)<>0     then AddParamToLoad(QRY_POD_TRYB_TEMP);
   if (dwLoMask and QFH_POD_TRYB_V)<>0        then AddParamToLoad(QRY_POD_TRYB_V);
   if (dwLoMask and QFH_OBR_TRYB_HEAT)<>0     then AddParamToLoad(QRY_OBR_TRYB_HEAT);
   if (dwLoMask and QFH_OBR_TRYB_RASX)<>0     then AddParamToLoad(QRY_OBR_TRYB_RASX);
   if (dwLoMask and QFH_OBR_TRYB_TEMP)<>0     then AddParamToLoad(QRY_OBR_TRYB_TEMP);
   if (dwLoMask and QFH_OBR_TRYB_V)<>0        then AddParamToLoad(QRY_OBR_TRYB_V);
   if (dwLoMask and QFH_TEMP_COLD_WAT_DAY)<>0 then AddParamToLoad(QRY_TEMP_COLD_WAT_DAY);
   if (dwLoMask and QFH_POD_TRYB_RUN_TIME)<>0 then AddParamToLoad(QRY_POD_TRYB_RUN_TIME);
   if (dwLoMask and QFH_WORK_TIME_ERR)<>0     then AddParamToLoad(QRY_WORK_TIME_ERR);
   }
End;
procedure CL3FindHolesModule.ResetParamsToLoad;
var i : integer;
begin
   for i := 0 to QRY_END do
     qParamToLoad[i] := false;
end;

procedure CL3FindHolesModule.AddParamToLoad(PID : integer);
begin
   qParamToLoad[PID] := true;
end;

procedure CL3FindHolesModule.SetParamToLoad(PID : integer);
begin
   ResetParamsToLoad;
   qParamToLoad[PID] := true;
end;

procedure CL3FindHolesModule.SetDefaultParams;
begin
   qParamToLoad[QRY_ENERGY_DAY_EP]     := true;
   qParamToLoad[QRY_ENERGY_MON_EP]     := true;
   qParamToLoad[QRY_SRES_ENR_EP]       := true;
   qParamToLoad[QRY_NAK_EN_DAY_EP]     := true;
   qParamToLoad[QRY_NAK_EN_MONTH_EP]   := true;
   {
   QRY_POD_TRYB_HEAT     = 74;   //Расход тепла в подающем трубопроводе (Гкал)
  QRY_POD_TRYB_RASX     = 75;   //Расход воды в подающем трубопроводе  (т)
  QRY_POD_TRYB_TEMP     = 76;   //Температура воды в подающем трубопроводе  (°C)
  QRY_POD_TRYB_V        = 77;   //Расход воды (объем) в подающем водопроводе (м3)
  QRY_OBR_TRYB_HEAT     = 78;   //Расход тепла в обратном трубопроводе (Гкал)
  QRY_OBR_TRYB_RASX     = 79;   //Расход воды в обратном трубопроводе (т)
  QRY_OBR_TRYB_TEMP     = 80;   //Температура воды в обратном трубопроводе (°C)
  QRY_OBR_TRYB_V        = 81;   //Расход воды (объем) в обратном трубопроводе (м3)
  QRY_TEMP_COLD_WAT_DAY = 82;   //Температура холодной воды  (°C)
  QRY_POD_TRYB_RUN_TIME = 83;   //Время наработки в подающем трубопроводе (ч)
  QRY_WORK_TIME_ERR     = 84;   //Время работы c каждой ошибкой (ч)
   }
   //qParamToLoad[QRY_POD_TRYB_HEAT]     := true;
   //qParamToLoad[QRY_POD_TRYB_RASX]     := true;
   //qParamToLoad[QRY_POD_TRYB_TEMP]     := true;
   //qParamToLoad[QRY_POD_TRYB_V]        := true;
   //qParamToLoad[QRY_OBR_TRYB_HEAT]     := true;
   //qParamToLoad[QRY_OBR_TRYB_RASX]     := true;
   //qParamToLoad[QRY_OBR_TRYB_TEMP]     := true;
   //qParamToLoad[QRY_OBR_TRYB_V]        := true;
   //qParamToLoad[QRY_TEMP_COLD_WAT_DAY] := true;
   //qParamToLoad[QRY_POD_TRYB_RUN_TIME] := true;
   //qParamToLoad[QRY_WORK_TIME_ERR]     := true;
end;

procedure CL3FindHolesModule.Init;
begin
   m_pDDB         := m_pDB.CreateConnect;
   dt_DateBegin   := Now - DeltaFH[m_nCF.cbm_DeltaFH.ItemIndex];
   dt_DateEnd     := Now;
   m_pDDB.GetParamsTypeTable(qm_ParamsDescr);
   m_pDDB.GetVMetersTable(-1,-1,m_pVMTable);
   m_pDDB.GetL1Table(m_sTblL1);
end;

function CL3FindHolesModule.IsMeterEnable(MID : integer) : boolean;
begin
   Result := Boolean(mL2Module.PMeters[MID].m_nP.m_sbyEnable);
end;

function CL3FindHolesModule.IsParamEnable(MID, PID : integer) : boolean;
var i : integer;
begin
   Result := false;
   with mL2Module.PMeters[MID].PObserver.pm_sInil2CmdTbl.LockList do
   try
   for i := 0 to count - 1 do
     if PID = CComm(Items[i]).m_swCmdID then
     begin
       Result := Boolean(CComm(Items[i]).m_sbyEnable);
       break;
     end;
   finally
    mL2Module.PMeters[MID].PObserver.pm_sInil2CmdTbl.UnLockList;
   end;
end;
procedure CL3FindHolesModule.SendMSGToLoad_Old(VMID, MID, PID : integer; Date : TDateTime);
var pDS    : CMessageData;
    szDT   : Integer;
begin
   szDT := sizeof(TDateTime);
   pDS.m_swData0 := VMID;
   pDS.m_swData1 := PID;
   pDS.m_swData2 := 0;
   pDS.m_swData3 := 0;
   pDS.m_swData4 := MTR_LOCAL;
   Move(Date,pDS.m_sbyInfo[0]   ,szDT);
   Move(Date,pDS.m_sbyInfo[szDT],szDT);
   SendMsgData(BOX_LOAD,MID,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
end;
{
      szDT := sizeof(TDateTime);
      pDS.m_swData0 := FMasterIndex;
      pDS.m_swData1 := FIndex;
      pDS.m_swData2 := 0;
      pDS.m_swData3 := 0;
      if (m_blIsLocal=True)and(m_blIsSlave=True) then FLocation := MTR_LOCAL;
      if (m_blIsLocal=False)then FLocation := MTR_REMOTE else FLocation := MTR_LOCAL;
      pDS.m_swData4 := FLocation;
      Move(dtPic2.DateTime,pDS.m_sbyInfo[0]   ,szDT);
      Move(dtPic1.DateTime,pDS.m_sbyInfo[szDT],szDT);
      if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(FPRID,pDS);exit; End;
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
      SendMsgData(BOX_L3_LME,FMasterIndex,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
      SendMsgData(BOX_L3_LME,FMID,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
}
procedure CL3FindHolesModule.SendMSGToLoad(VMID, MID, PID : integer; Date : TDateTime;blMon:Boolean);
begin
    case m_nCF.QueryType of
         QWR_EQL_TIME,QWR_QWERY_SHED:
           if FindIndex(PID,Date)=False then
           Begin
            SendMSGToLoad_Old(VMID, MID, PID, Date);
            AddFindIndex(PID,Date);
           End;
          QWR_FIND_SHED : SendMSGToLoad_New(VMID, MID, PID, Date, blMon);
    End;
end;
procedure CL3FindHolesModule.FreeFindIndex;
Var
    i : Integer;
Begin
    m_nMEM.Count := 0;
    for i:=0 to MAX_FINDMEM-1 do
    Begin
     m_nMEM.Items[i].m_nOldParamID := -1;
     m_nMEM.Items[i].m_nOldDate    := EncodeDate(2000,11,2);
    End;
End;
procedure CL3FindHolesModule.AddFindIndex(PID:Integer;DATE:TDateTime);
Var
    i : Integer;
Begin
    if m_nMEM.Count<MAX_FINDMEM-10 then
    Begin
     for i:=0 to MAX_FINDMEM-1 do
     Begin
      if m_nMEM.Items[i].m_nOldParamID=-1 then
      Begin
       m_nMEM.Items[i].m_nOldParamID := PID;
       m_nMEM.Items[i].m_nOldDate    := DATE;
       m_nMEM.Count := m_nMEM.Count + 1;
       break;
      End;
     End;
    End;
End;
function CL3FindHolesModule.FindIndex(PID:Integer;DATE:TDateTime):Boolean;
Var
    i : Integer;
Begin
    Result := False;
    for i:=0 to m_nMEM.Count-1 do
    Begin
     if (m_nMEM.Items[i].m_nOldParamID=PID)and(m_nMEM.Items[i].m_nOldDate=DATE)then
     Begin
      Result := True;
      exit;
     End;
    End;
End;
procedure CL3FindHolesModule.SendMSGToLoad_New(VMID, MID, PID : integer; Date : TDateTime;blMon:Boolean);
var pDS    : CMessageData;
    szDT   : Integer;
begin
    szDT          := sizeof(TDateTime);
    pDS.m_swData0 := VMID;
    pDS.m_swData1 := PID;
    pDS.m_swData2 := MID;
    pDS.m_swData3 := GetRealPort(PortID);
    pDS.m_swData4 := MTR_LOCAL;
    move(Date, pDS.m_sbyInfo[0], szDT);
    move(Date, pDS.m_sbyInfo[szDT], szDT);
    pDS.m_sbyInfo[2*szDT] := 0;
    if blMon=True then pDS.m_sbyInfo[2*szDT] := 1;
    SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_DATA_GRAPH_REQ, pDS);
    if (m_nMask and QFH_RECALC_ABOID)<>0 then
    Begin
     if ((PID>=QRY_ENERGY_MON_EP)and(PID<=QRY_ENERGY_MON_RM)) then Date := Date + 1;
     SendRecalcToLoadTime(VMID,PID,RCL_CALCL2 or RCL_CALCL3,Date);
    End;
end;
procedure CL3FindHolesModule.SendCurrMSGToLoad(VMID, MID,  PRID, PID : integer);
var
    pDS    : CMessageData;
    szDT   : Integer;
    Date   : TDateTime;
begin
    Date          := Now;
    szDT          := sizeof(TDateTime);
    pDS.m_swData0 := VMID;
    pDS.m_swData1 := PID;
    pDS.m_swData2 := MID;
    pDS.m_swData3 := GetRealPort(PRID);
    pDS.m_swData4 := MTR_LOCAL;
    move(Date, pDS.m_sbyInfo[0], szDT);
    move(Date, pDS.m_sbyInfo[szDT], szDT);
    SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_QRY_PARAM_REQ, pDS);
end;
procedure CL3FindHolesModule.SendEventMSGToLoad(VMID,MID,PRID:integer;wLoMask:int64);
var
    pDS    : CMessageData;
    szDT   : Integer;
    Date   : TDateTime;
begin
    Date          := Now;
    szDT          := sizeof(TDateTime);
    pDS.m_swData0 := ABOID;
    pDS.m_swData1 := VMID;
    pDS.m_swData2 := MID;
    pDS.m_swData3 := GetRealPort(PRID);
    pDS.m_swData4 := MTR_LOCAL;
    move(dt_DateBegin, pDS.m_sbyInfo[0], szDT);
    move(dt_DateEnd, pDS.m_sbyInfo[szDT], szDT);
    move(wLoMask, pDS.m_sbyInfo[2*szDT], sizeof(int64));
    SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_LOAD_EVENT_ONE_REQ, pDS);
end;
{
       nRCL := 0;
       if not((FMTID=MET_SUMM)or(FMTID=MET_GSUMM)) then nRCL := RCL_CALCL1;
       if (FMTID=MET_SUMM)  then nRCL := RCL_CALCL2;
       if (FMTID=MET_GSUMM) then nRCL := RCL_CALCL3;
       IsParam4(FIndex,nOutCmd);
       pDS.m_swData0 := nOutCmd;
       pDS.m_swData1 := nRCL;
       pDS.m_swData2 := FMasterIndex;
       pDS.m_swData3 := FABOID;
}
procedure CL3FindHolesModule.SendRecalcToLoad(VMID,PID:integer;dwMask:DWord);
var
    pDS    : CMessageData;
    szDT   : Integer;
    Date   : TDateTime;
begin
    Date          := Now;
    szDT          := sizeof(TDateTime);
    pDS.m_swData0 := PID;
    pDS.m_swData1 := dwMask;
    pDS.m_swData2 := VMID;
    pDS.m_swData3 := ABOID;
    pDS.m_swData4 := MTR_LOCAL;
    move(dt_DateEnd, pDS.m_sbyInfo[0], szDT);
    move(dt_DateBegin, pDS.m_sbyInfo[szDT], szDT);
    SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_RCALC_DATA_REQ, pDS);
end;
procedure CL3FindHolesModule.SendRecalcToLoadTime(VMID,PID:integer;dwMask:DWord; Date : TDateTime);
var
    pDS    : CMessageData;
    szDT   : Integer;
    //Date   : TDateTime;
begin
    //Date          := Now;
    szDT          := sizeof(TDateTime);
    pDS.m_swData0 := PID;
    pDS.m_swData1 := dwMask;
    pDS.m_swData2 := VMID;
    pDS.m_swData3 := ABOID;
    pDS.m_swData4 := MTR_LOCAL;
    move(Date, pDS.m_sbyInfo[0], szDT);
    move(Date, pDS.m_sbyInfo[szDT], szDT);
    SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_RCALC_DATA_REQ, pDS);
end;
procedure CL3FindHolesModule.SendFinalQuery;
var
    pDS    : CMessageData;
begin
    FillChar(pDS,sizeof(pDS),0);
    pDS.m_swData4 := MTR_LOCAL;
    pDS.m_swData3 := 1;
    SendMsgData(BOX_LOAD,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
    //SendMsgData(BOX_LOAD,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
end;
function  CL3FindHolesModule.FindStartDate(Delta : integer; dt_Date : TDateTime) : TDateTime;
begin
   case Delta of
     8  : Result := trunc(dt_Date);
     9  : Result := cDateTimeR.GetBeginMonth(dt_Date);
     else Result := trunc(dt_Date);
   end;
end;

procedure CL3FindHolesModule.IncDateTime(Delta : integer; var dt_Date : TDateTime);
begin
   case Delta of
     0  : dt_Date := dt_Date + 500;
     1  : dt_Date := dt_Date + 500;
     2  : dt_Date := dt_Date + EncodeTime(0, 3, 0, 0);
     3  : dt_Date := dt_Date + EncodeTime(0, 15, 0, 0);
     4  : dt_Date := dt_Date + EncodeTime(0, 30, 0, 0);
     5  : dt_Date := dt_Date + EncodeTime(1, 0, 0, 0);
     6  : dt_Date := dt_Date + EncodeTime(3, 0, 0, 0);
     7  : dt_Date := dt_Date + EncodeTime(6, 0, 0, 0);
     8  : dt_Date := trunc(dt_Date) + 1;
     9  : cDateTimeR.IncMonth(dt_Date);
     10 : cDateTimeR.IncYear(dt_Date);
     else dt_Date := dt_Date + 500;
   end;
end;

function CL3FindHolesModule.FindDateInArch(Date : TDateTime; var pTable : CCDatas) : integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if trunc(Date) = trunc(pTable.Items[i].m_sTime) then
     begin
       Result := i;
       break;
     end;
end;

function CL3FindHolesModule.FindDateInGraph(Date : integer; var pTable : L3GRAPHDATAS) : integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if Date = trunc(pTable.Items[i].m_sdtDate) then
     begin
       Result := i;
       break;
     end;
end;

function CL3FindHolesModule.FindDateInPeriod(Date : TDateTime; var pTable : CCDatas) : integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if Date = pTable.Items[i].m_sTime then
     begin
       Result := i;
       break;
     end;
end;

procedure CL3FindHolesModule.FindHolesInArch(VMID, MID, PID : integer);
var ArchData : CCDatas;
    TempDate,dt_Now : TDateTime;
    Item     : integer;
begin
   dt_Now := Now;
   TempDate := FindStartDate(qm_ParamsDescr.Items[PID].m_sbyDeltaPer, dt_DateBegin);
   m_pDDB.GetGData(dt_DateEnd, TempDate, VMID, PID, 0, ArchData);
   while TempDate <= dt_DateEnd do
   begin
     Item := FindDateInArch(TempDate, ArchData);
     if Item = -1 then
     Begin
      if ((PID>=QRY_ENERGY_DAY_EP)and(PID<=QRY_ENERGY_MON_RM)) then
      SendMSGToLoad(VMID, MID, PID, TempDate - 1,False)
      else SendMSGToLoad(VMID, MID, PID, TempDate,False);
     End else
     Begin
      //if ((PID>=QRY_ENERGY_DAY_EP)and(PID<=QRY_ENERGY_DAY_RM)) then
      // if trunc(dt_Now)=trunc(TempDate) then SendMSGToLoad(VMID, MID, PID, TempDate - 1,False);
      if ((PID>=QRY_ENERGY_MON_EP)and(PID<=QRY_ENERGY_MON_RM)) then
       if trunc(cDateTimeR.GetBeginMonth(dt_Now))=trunc(cDateTimeR.GetBeginMonth(TempDate)) then SendMSGToLoad(VMID, MID, PID, TempDate - 1,False)
     End;
     IncDateTime(qm_ParamsDescr.Items[PID].m_sbyDeltaPer, TempDate);
   end;
end;

procedure CL3FindHolesModule.FindHolesInGraph(VMID, MID, PID : integer);
var GraphData       : L3GRAPHDATAS;
    i, Item         : integer;
    TempDate        : TDateTime;
begin
   m_pDDB.GetGraphDatas(dt_DateEnd, trunc(dt_DateBegin), VMID, PID, GraphData);
   for i := trunc(dt_DateBegin) to trunc(dt_DateEnd) do
   begin
     Item := FindDateInGraph(i, GraphData);
     if Item = -1 then
     begin
       SendMSGToLoad(VMID, MID, PID, i,False);
       continue;
     end;
     if (GraphData.Items[Item].m_sMaskRead <> $FFFFFFFFFFFF)or(trunc(Now)=trunc(i)) then
     begin
       SendMSGToLoad(VMID, MID, PID, i,False);
       continue;
     end;
   end;
end;

procedure CL3FindHolesModule.FindHolesInPeriod(VMID, MID, PID : integer);
var PeriodData : CCDatas;
    TempDate   : TDateTime;
    Item,i     : integer;
begin
   m_pDDB.GetGDPData_48(dt_DateEnd, trunc(dt_DateBegin), VMID, PID, PID, PeriodData);
   for i := trunc(dt_DateBegin) to trunc(dt_DateEnd) do
   begin
     Item := FindDateInArch(i, PeriodData);
     if Item = -1 then
     begin
       SendMSGToLoad(VMID, MID, PID, i,False);
       continue;
     end;
     if (PeriodData.Items[Item].m_sbyMaskRead <> $FFFFFFFFFFFF) or (trunc(Now)=trunc(dt_DateBegin)) then
     begin
       SendMSGToLoad(VMID, MID, PID, i,False);
       continue;
     end;
   end;
end;
procedure CL3FindHolesModule.FindHolesInMonitor(VMID, MID, PID : integer);
var
    TempDate : TDateTime;
    Item,i   : integer;
    pTable   : SMONITORDATA;
    res      : Boolean;
begin
   for i := trunc(dt_DateBegin) to trunc(dt_DateEnd) do
   begin
    pTable.m_swVMID := VMID;
    pTable.CmdID    := PID;
    pTable.m_dtDate := dt_DateBegin;
    if m_pDDB.IsMonitorTag(pTable)=False then
    begin
     SendMSGToLoad(VMID, MID, PID, i,True);
     continue;
    end;
   end;
end;

procedure CL3FindHolesModule.FindHoles(var ParamID : integer);
var i : integer;
begin
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   begin
     if (m_pVMTable.Item.Items[i].m_sbyType=MET_SUMM)or(m_pVMTable.Item.Items[i].m_sbyType=MET_GSUMM)or
     (m_pVMTable.Item.Items[i].m_sbyExport=0) then continue;
     if IsMeterEnable(m_pVMTable.Item.Items[i].m_swMID) and IsParamEnable(m_pVMTable.Item.Items[i].m_swMID, ParamID) and
        (m_pVMTable.Item.Items[i].m_sbyEnable=1) and (ParamID <= qm_ParamsDescr.Count) then
     begin
       PortID := m_pVMTable.Item.Items[i].m_sbyPortID;
       case qm_ParamsDescr.Items[ParamID].m_swIsGraph of
         SV_CURR_ST : break;
         SV_ARCH_ST : FindHolesInArch(m_pVMTable.Item.Items[i].m_swVMID, m_pVMTable.Item.Items[i].m_swMID, ParamID);
         SV_GRPH_ST : FindHolesInGraph(m_pVMTable.Item.Items[i].m_swVMID, m_pVMTable.Item.Items[i].m_swMID, ParamID);
         SV_PDPH_ST : FindHolesInPeriod(m_pVMTable.Item.Items[i].m_swVMID, m_pVMTable.Item.Items[i].m_swMID, ParamID);
         else break;
       end;
     end;
   end;
end;

procedure CL3FindHolesModule.RunFHModule;
var i : integer;
begin
   for i := 0 to QRY_END do
     if qParamToLoad[i] then
       FindHoles(i);
   //if FCHECK(BOX_LOAD)<>0 then
   //  SendMsg(BOX_L3_LME, DIR_LM3TOLM3, DIR_LM3TOLM3,QL_START_UNLOAD_REQ);
end;
function CL3FindHolesModule.FindProc:Integer;
var
   i : integer;
begin
   FFREE(BOX_LOAD);
   for i := 0 to QRY_END do
     if qParamToLoad[i] then
       FindHoles(i);
   Result := FCHECK(BOX_LOAD);
end;
{
  QFH_CURR_SUMM                = $0000000000000040;
  QFH_CURR_MAP                 = $0000000000000080;
  QFH_CURR_MRP                 = $0000000000000100;
  QFH_CURR_U                   = $0000000000000200;
  QFH_CURR_I                   = $0000000000000400;
  QFH_CURR_F                   = $0000000000000800;
}
function CL3FindHolesModule.LoadCurrent(blFree:Boolean;wLoMask:int64):Integer;
var
   i,ParamID : integer;
   pDS    : CMessageData;
begin
   if blFree=True then FFREE(BOX_LOAD);
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   begin
    with m_pVMTable.Item.Items[i] do
    Begin
     if m_sbyEnable=1 then
     Begin
      PortID := m_sbyPortID;
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then continue;
      if(wLoMask and QFH_CURR_SUMM)<>0 then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_ENERGY_SUM_EP);
      if(wLoMask and QFH_CURR_MAP)<>0  then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_MGAKT_POW_S);
      if(wLoMask and QFH_CURR_MRP)<>0  then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_MGREA_POW_S);
      if(wLoMask and QFH_CURR_U)<>0    then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_U_PARAM_A);
      if(wLoMask and QFH_CURR_I)<>0    then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_I_PARAM_A);
      if(wLoMask and QFH_CURR_F)<>0    then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_FREQ_NET);
      if(wLoMask and QFH_CURR_CFI)<>0  then SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_KOEF_POW_A);
     End;
    End;
   end;
   Result := FCHECK(BOX_LOAD);
end;
{
QFH_ANET_U                   = $0000000000100000;
  QFH_ANET_I                   = $0000000000200000;
  QFH_ANET_FI                  = $0000000000400000;
  QFH_ANET_CFI                 = $0000000000800000;
  QFH_ANET_F                   = $0000000001000000;
}
function CL3FindHolesModule.LoadNetParam(blFree:Boolean;wLoMask:int64):Integer;
var
   i,ParamID : integer;
   pDS    : CMessageData;
begin
   if blFree=True then FFREE(BOX_LOAD);
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   begin
    with m_pVMTable.Item.Items[i] do
    Begin
     if m_sbyEnable=1 then
     Begin
      PortID := m_sbyPortID;
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then continue;
      if(wLoMask and QFH_ANET_U)<>0   then FindHolesInPeriod(m_swVMID,m_swMID,QRY_U_PARAM_A);
      if(wLoMask and QFH_ANET_I)<>0   then FindHolesInPeriod(m_swVMID,m_swMID,QRY_I_PARAM_A);
      if(wLoMask and QFH_ANET_FI)<>0  then FindHolesInPeriod(m_swVMID,m_swMID,QRY_ANET_FI);
      if(wLoMask and QFH_ANET_CFI)<>0 then FindHolesInPeriod(m_swVMID,m_swMID,QRY_KOEF_POW_A);
      if(wLoMask and QFH_ANET_F)<>0   then FindHolesInPeriod(m_swVMID,m_swMID,QRY_FREQ_NET);
      if(wLoMask and QFH_ANET_P)<>0   then FindHolesInPeriod(m_swVMID,m_swMID,QRY_MGAKT_POW_S);
      if(wLoMask and QFH_ANET_Q)<>0   then FindHolesInPeriod(m_swVMID,m_swMID,QRY_MGREA_POW_S);
     End;
    End;
   end;
   Result := FCHECK(BOX_LOAD);
end;
function CL3FindHolesModule.LoadMonNetParam(blFree:Boolean;wLoMask:int64):Integer;
var
   i,ParamID : integer;
   pDS    : CMessageData;
begin
   if blFree=True then FFREE(BOX_LOAD);
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   begin
    with m_pVMTable.Item.Items[i] do
    Begin
     if m_sbyEnable=1 then
     Begin
      PortID := m_sbyPortID;
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then continue;
      if(wLoMask and QFH_ANET_U)<>0   then FindHolesInMonitor(m_swVMID,m_swMID,QRY_U_PARAM_A);
      if(wLoMask and QFH_ANET_I)<>0   then FindHolesInMonitor(m_swVMID,m_swMID,QRY_I_PARAM_A);
      if(wLoMask and QFH_ANET_FI)<>0  then FindHolesInMonitor(m_swVMID,m_swMID,QRY_ANET_FI);
      if(wLoMask and QFH_ANET_CFI)<>0 then FindHolesInMonitor(m_swVMID,m_swMID,QRY_KOEF_POW_A);
      if(wLoMask and QFH_ANET_F)<>0   then FindHolesInMonitor(m_swVMID,m_swMID,QRY_FREQ_NET);
      if(wLoMask and QFH_ANET_P)<>0   then FindHolesInMonitor(m_swVMID,m_swMID,QRY_MGAKT_POW_S);
      if(wLoMask and QFH_ANET_Q)<>0   then FindHolesInMonitor(m_swVMID,m_swMID,QRY_MGREA_POW_S);
     End;
    End;
   end;
   Result := FCHECK(BOX_LOAD);
end;
function CL3FindHolesModule.LoadCorrTime(blFree:Boolean):Integer;
var
   i,ParamID : integer;
   nOldVMID  : integer;
   pDS       : CMessageData;
begin
   if blFree=True then FFREE(BOX_LOAD);
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   begin
    with m_pVMTable.Item.Items[i] do
    Begin
     if m_sbyEnable=1 then
     Begin
      PortID := m_sbyPortID;
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then continue;
      SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_DATA_TIME);
      {SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_MGAKT_POW_S);
      SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_MGREA_POW_S);
      SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_U_PARAM_A);
      SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_I_PARAM_A);
      SendCurrMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,QRY_FREQ_NET);}
     End;
    End;
   end;
   Result := FCHECK(BOX_LOAD);
end;
{
 QFH_JUR_0                    = $0000000000010000;
  QFH_JUR_1                    = $0000000000020000;
  QFH_JUR_2                    = $0000000000040000;
  QFH_JUR_3
}
function CL3FindHolesModule.LoadEvents(blFree:Boolean;wLoMask:int64):Integer;
var
   i,ParamID : integer;
   nOldVMID  : integer;
   pDS       : CMessageData;
begin
   if blFree=True then FFREE(BOX_LOAD);
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   begin
    with m_pVMTable.Item.Items[i] do
    Begin
     if m_sbyEnable=1 then
     Begin
      PortID := m_pVMTable.Item.Items[i].m_sbyPortID;
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then continue;
      SendEventMSGToLoad(m_swVMID,m_swMID,m_sbyPortID,wLoMask);
     End;
    End;
   end;
   Result := FCHECK(BOX_LOAD);
end;
{
 QFH_ARCH_EN                  = $0000000000000001;
  QFH_ENERGY_DAY_EP            = $0000000000000002;
  QFH_ENERGY_MON_EP            = $0000000000000004;
  QFH_SRES_ENR_EP              = $0000000000000008;
  QFH_NAK_EN_DAY_EP            = $0000000000000010;
  QFH_NAK_EN_MONTH_EP          = $0000000000000020;

 QFH_ANET_EN                  = $0000000000100000;
  QFH_ANET_U                   = $0000000000200000;
  QFH_ANET_I                   = $0000000000400000;
  QFH_ANET_FI                  = $0000000000800000;
  QFH_ANET_CFI                 = $0000000001000000;
  QFH_ANET_F                   = $0000000002000000;
  QFH_ANET_P                   = $0000000004000000;
  QFH_ANET_Q                   = $0000000008000000;
}
function  CL3FindHolesModule.LoadRecalc(blFree:Boolean;wLoMask:int64):Integer;
Var
   i,nVMID : Integer;
   nRCL : DWord;
Begin
   if blFree=True then FFREE(BOX_LOAD);
   nRCL  := RCL_CALCL2 or RCL_CALCL3;
   nVMID := FVMID;
   for i := 0 to m_pVMTable.m_swAmVMeter - 1 do
   Begin
    with m_pVMTable.Item.Items[i] do
    if FSVMID=m_swVMID then
    Begin
     if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then Begin nVMID:=FSVMID;break;End;
    End;
   End;
   if (wLoMask and QFH_ARCH_EN)<>0 then
   Begin
    if (wLoMask and QFH_ENERGY_DAY_EP)<>0   then SendRecalcToLoad(nVMID,QRY_ENERGY_DAY_EP,nRCL);
    if (wLoMask and QFH_ENERGY_MON_EP)<>0   then SendRecalcToLoad(nVMID,QRY_ENERGY_MON_EP,nRCL);
    if (wLoMask and QFH_SRES_ENR_EP)<>0     then SendRecalcToLoad(nVMID,QRY_SRES_ENR_EP,nRCL);
    //if (wLoMask and QFH_NAK_EN_DAY_EP)<>0   then SendRecalcToLoad(FVMID,QRY_NAK_EN_DAY_EP,nRCL);
    //if (wLoMask and QFH_NAK_EN_MONTH_EP)<>0 then SendRecalcToLoad(FVMID,QRY_NAK_EN_MONTH_EP,nRCL);
   End;
End;
procedure CL3FindHolesModule.Go;
Begin
   if FCHECK(BOX_LOAD)<>0 then
     SendMsg(BOX_L3_LME, DIR_LM3TOLM3, DIR_LM3TOLM3,QL_START_UNLOAD_REQ);
End;
{
function TGraphFrame.IsParam4(nCMDID:Integer;var nOutCmd:Integer):Boolean;
Begin
     Result:=False;
     case nCMDID of
          QRY_ENERGY_DAY_EP,QRY_ENERGY_DAY_EM,QRY_ENERGY_DAY_RP,QRY_ENERGY_DAY_RM:Begin nOutCmd:=QRY_ENERGY_DAY_EP; Result:=True;End;
          QRY_ENERGY_MON_EP,QRY_ENERGY_MON_EM,QRY_ENERGY_MON_RP,QRY_ENERGY_MON_RM:Begin nOutCmd:=QRY_ENERGY_MON_EP; Result:=True;End;
          QRY_NAK_EN_DAY_EP,QRY_NAK_EN_DAY_EM,QRY_NAK_EN_DAY_RP,QRY_NAK_EN_DAY_RM:Begin nOutCmd:=QRY_NAK_EN_DAY_EP; Result:=True;End;
          QRY_NAK_EN_MONTH_EP,QRY_NAK_EN_MONTH_EM,QRY_NAK_EN_MONTH_RP,QRY_NAK_EN_MONTH_RM:Begin nOutCmd:=QRY_NAK_EN_MONTH_EP; Result:=True;End;
          QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,QRY_SRES_ENR_RP,QRY_SRES_ENR_RM        :Begin nOutCmd:=QRY_SRES_ENR_EP;   Result:=True;End;
          QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C        :Begin nOutCmd:=QRY_MGAKT_POW_S;   Result:=True;End;
          QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C        :Begin nOutCmd:=QRY_MGREA_POW_S;   Result:=True;End;
          QRY_U_PARAM_S,QRY_U_PARAM_A,QRY_U_PARAM_B,QRY_U_PARAM_C                :Begin nOutCmd:=QRY_U_PARAM_S;     Result:=True;End;
          QRY_I_PARAM_S,QRY_I_PARAM_A,QRY_I_PARAM_B,QRY_I_PARAM_C                :Begin nOutCmd:=QRY_I_PARAM_S;     Result:=True;End;
     End;
End;
}
procedure CL3FindHolesModule.OnHandler;
Begin

End;

function  CL3FindHolesModule.EventHandler(var pMsg : CMessage):Boolean;
begin

end;

function  CL3FindHolesModule.SelfHandler(var pMsg:CMessage):Boolean;
begin

end;

function  CL3FindHolesModule.LoHandler(var pMsg:CMessage):Boolean;
begin

end;

function  CL3FindHolesModule.HiHandler(var pMsg:CMessage):Boolean;
begin

end;

procedure CL3FindHolesModule.DoHalfTime(Sender:TObject);
begin

end;

function CL3FindHolesModule.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
    for i:=0 to m_sTblL1.Count-1 do
    Begin
     with m_sTblL1.Items[i] do
     Begin
      if m_sbyPortID=nPort then
      Begin
       Result := m_sbyPortID;
       if m_sblReaddres=1 then Result := m_swAddres;
       exit;
      End;
     End;
    End;
End;

end.
