unit knsl3vparam;
//{$DEFINE SS301_DEBUG}
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
knsl3observemodule,utldatabase,controls,knsl5tracer,knsl3EventBox,knsl3abon,knsl4Unloader;
type
    CVparam = class
   protected
     m_byRep        : Byte;
     m_nTxMsg       : CHMessage;
     m_dtSavePeriod : TDateTime;
     //m_nTParam      : array[1..4] of CVparam;
     m_pvGraph      : PL3GRAPHDATA;
     //m_pDV          : array of L3CURRENTDATAS;
     IsUpdate       : boolean;
     m_nAmTarifs    : Integer;
     m_nSlCounter   : Integer;
     m_nSlCounter1  : Integer;
     function SelfHandler(var pMsg:CMessage):Boolean;
     function LoHandler(var pMsg:CMessage):Boolean;
     function HiHandler(var pMsg:CMessage):Boolean;
     procedure SendMSG(byBox,byFor,byType:Byte);
     //Data Routing
     function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):integer;
     function  GetCurrentTar(Srez : integer): integer;
     procedure CreateLimitRemEv(Ev, ABOID : integer; str : string);
     procedure LimitGraphH(pDV:PL3CURRENTDATA);
     procedure LimitArchH(pDV:PL3CURRENTDATA);
     procedure LimitHandler(pDV:PL3CURRENTDATA);
     function  ExecSave(pDV:PL3CURRENTDATA):Boolean;
     function  ExecFindMax(pDV:PL3CURRENTDATA):Boolean;
     function  ExecFindMin(pDV:PL3CURRENTDATA):Boolean;
     procedure SaveCurrentAction(pData:PL3CURRENTDATA);
     procedure SaveArchiveAction(pData:PL3CURRENTDATA);
     procedure SaveGraphicsAction(pData:PL3CURRENTDATA);
     procedure SavePeriodicAction_48(pData:PL3CURRENTDATA);
     procedure SaveData(var pMsg:CMessage);
     function  GetSavePeriod:TDateTime;
     function  GetMax(nSID:Integer):Double;
     function  GetSumm(nSID:Integer):Double;
     function  GetAvg(nSID:Integer):Double;
     procedure SaveTarifData;
     function  ReturnCRC(m_sfValue:array of double):integer;

      //Brestenergo
     {
     procedure SaveGraphicsEnergoAction(pData:PL3CURRENTDATA);
     procedure SaveArchiveEnergoAction(pData:PL3CURRENTDATA);
     }

    public
     m_swTID        : integer;
     m_nP           : SL3PARAMS;
     m_pDV          : array of L3CURRENTDATAS;
     m_pDT          : array of TDateTime;
     LimitData      : SL3LIMITVALUES;
     m_byPLID       : Byte;
     constructor Create(var pTbl:SL3PARAMS);
     destructor  Destroy;override;
     procedure   OnFree;
     function    GetData(nSID:Integer):Double;
     function    GetDataTSL1(var pDT:CVToken):Boolean;
     procedure   GetCurrentSID(var nSID:Word;var dtDate:TDateTime);
     function    GetDataTSL2(var pDT:CVToken):Boolean;
     function    GetInfo(var pDT:CVToken):Boolean;
     procedure   RunData(fValue:Double);
     procedure   SetDataL1(pDT:CVToken);
     procedure   SetDataL2(pDT:CVToken);
     function    EventHandler(var pMsg:CMessage):Boolean;
     procedure   Init(var pTbl:SL3PARAMS);

     End;
    PCVparam =^ CVparam;
Var
    m_nWrite : Integer;
implementation
constructor CVparam.Create(var pTbl:SL3PARAMS);
Begin
    TraceL(3,pTbl.m_swVMID,'(__)CL3MD::>CVPRM Create : '+m_nCommandList.Strings[pTbl.m_swParamID]);
    LimitData.Count := 0;
End;
destructor CVparam.Destroy;
Begin
    inherited;
End;
{
  SV_CURR_ST = 0;
  SV_ARCH_ST = 1;
  SV_GRPH_ST = 2;
  SV_PDPH_ST = 3;
}
procedure CVparam.Init(var pTbl:SL3PARAMS);
Var
    pData : L3CURRENTDATA;
    pCTbl : SL3PARAMS;
    i     : Integer;
    dtTime : TDateTime;
Begin
    Move(pTbl,m_nP,sizeof(SL3PARAMS));
    Move(pTbl,pCTbl,sizeof(SL3PARAMS));
    //m_nP.m_dtLastTime := Now;
    pData.m_swVMID    := m_nP.m_swVMID;
    pData.m_swCMDID   := m_nP.m_swParamID;
    pData.m_sTime     := Now;
    pData.m_swTID     := 0;
    pData.m_sfValue   := 0.0;
    pData.m_byInState := DT_OLD;
    pData.m_byOutState:= LM_MIN;
    m_nP.m_dtLastTime := Date;
    m_nSlCounter      := 0;
    m_swTID           := pTbl.m_sblTarif;
    if pData.m_swVMID =4 then
      pData.m_swVMID := 4;
    if (m_nP.m_sblSaved=SV_ARCH_ST)or((pData.m_swCMDID>=QRY_ENERGY_SUM_EP)and(pData.m_swCMDID<=QRY_ENERGY_SUM_RM))
    or ((pData.m_swCMDID>=QRY_ENERGY_SUM_R1)and(pData.m_swCMDID<=QRY_ENERGY_SUM_R4))
    or (pData.m_swCMDID=QRY_SUM_RASH_V)or(pData.m_swCMDID=QRY_RASH_AVE_V) then
    Begin
     SetLength(m_pDV,5);
     SetLength(m_pDT,5);
     for i:=0 to 4 do m_pDV[i].Count := 0;
     for i:=0 to 4 do
      Begin
       pData.m_swTID := i;
       if m_blHandInit then m_pDB.AddCurrentParam(pData);
       SetLength(m_pDV[pData.m_swTID].Items,1);
       m_pDT[i] := m_nP.m_dtLastTime;
      End;
    End else
    if (m_nP.m_sblSaved=SV_GRPH_ST)or(m_nP.m_sblSaved=SV_PDPH_ST) then
    Begin
     SetLength(m_pDV,1);
     SetLength(m_pDT,1);
     m_pDV[pData.m_swTID].Count := 0;
     SetLength(m_pDV[pData.m_swTID].Items,48);
     if m_pvGraph<>Nil then Dispose(m_pvGraph);
     New(m_pvGraph);
     m_pvGraph.m_sMaskRead := 0;                    //Инициализация структуры срезов
     m_pvGraph.m_sMaskReRead := 0;                    //Инициализация структуры срезов
     //SetLength(m_pvGraph.v,48);
     for i := 0 to 47 do m_pvGraph.v[i] := 0.0;
     if m_blHandInit then m_pDB.AddCurrentParam(pData);
     m_pDT[pData.m_swTID] := m_nP.m_dtLastTime;
    End else
    if ((m_nP.m_sblSaved=SV_CURR_ST){or(m_nP.m_sblSaved=SV_PDPH_ST)})and
    not((pData.m_swCMDID>=QRY_ENERGY_SUM_EP)and(pData.m_swCMDID<=QRY_ENERGY_SUM_RM)) then
    Begin
     SetLength(m_pDV,1);
     SetLength(m_pDT,1);
     m_pDV[pData.m_swTID].Count := 0;
     SetLength(m_pDV[pData.m_swTID].Items,1);
     if m_blHandInit then m_pDB.AddCurrentParam(pData);
     m_pDT[pData.m_swTID] := m_nP.m_dtLastTime;
    End;
    m_nAmTarifs     := pData.m_swTID + 1;
    m_dtSavePeriod  := GetSavePeriod;
    //LimitData.Count := 0;
End;
function  CVparam.EventHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := False;
    case pMsg.m_sbyFor of
     DIR_L2TOL3: res := LoHandler(pMsg);
     DIR_L3TOL3: res := SelfHandler(pMsg);
     DIR_L4TOL3: res := HiHandler(pMsg);
    End;
    Result := res;;
End;
function CVparam.SelfHandler(var pMsg:CMessage):Boolean;
Var
    res : Boolean;
Begin
    res := True;

    Result := res;
End;
function CVparam.LoHandler(var pMsg:CMessage):Boolean;
Var
    nObj : Integer;
Begin
    if pMsg.m_sbyType=DL_DATARD_IND then
    Begin
     //nObj := pMsg.m_sbyInfo[8];
     //if (m_nP.m_sblTarif=2) and (nObj<>0) and (nObj<=4)then
     {if ((m_nP.m_swStatus=CL_SUMM_TR)or
         (m_nP.m_swStatus=CL_MAXM_TR)or
         (m_nP.m_swStatus=CL_AVRG_TR)) and (nObj<>0) and (nObj<=4)then
     m_nTParam[nObj].LoHandler(pMsg) else
     }
     SaveData(pMsg);
    End;
    Result := True;
End;
{
L3CURRENTDATA = packed record
     m_swID    : Word;
     m_swVMID  : Word;
     m_swTID   : Word;
     m_swCMDID : Word;
     m_swSID   : Word;
     m_sTime   : TDateTime;
     m_sfValue : Double;
    end;
}
procedure CVparam.SaveData(var pMsg:CMessage);
Var
    res  : Boolean;
    dDT  : CDTTime;
    nTID : Integer;
    nSID : Integer;
    nErSID: Byte;
Begin
    res  := True;
    //if pMsg.m_sbyInfo[1]=QRY_E3MIN_POW_EP then
    //dDT.Month := 0;
    nTID  := pMsg.m_sbyInfo[8];
    nErSID:= pMsg.m_sbyServerID;
    nSID  := nErSID and $3f;
    if nSID>47 then exit;
    if m_nSlCounter>47 then m_nSlCounter:=0;
    if nSID>MAX_PARAM then exit;
    if nTID<=(m_nAmTarifs-1) then
    Begin
     if pMsg.m_sbyDirID=1 then IsUpdate := True else IsUpdate := False;
     if m_nAmTarifs>1 then
     Begin
      m_pDV[0].Count                   := m_nSlCounter + 1;
      m_pDV[0].Items[nSID].m_swVMID    := pMsg.m_swObjID;
      m_pDV[0].Items[nSID].m_swSID     := m_nSlCounter;
      m_pDV[0].Items[nSID].m_swCMDID   := pMsg.m_sbyInfo[1];
      m_pDV[0].Items[nSID].m_byInState := DT_NEW;
     End;
     with m_pDV[nTID].Items[nSID] do
     Begin
      //if m_nP.m_swParamID=13 then
      //m_swVMID    := pMsg.m_swObjID;
      m_swVMID    := pMsg.m_swObjID;
      m_swTID     := nTID;
      m_swCMDID   := pMsg.m_sbyInfo[1];
      m_swSID     := nSID;
      m_byInState := DT_NEW;
      Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
      if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
      m_sTime := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
      Move(pMsg.m_sbyInfo[9],m_sfSvValue,sizeof(Double));
      if (m_byPLID=1)and(nTID>2) then m_sfSvValue:=0;
      //m_pDV[nTID].Items[nSID].m_sbyPrecision  := 1;
      //if (nErSID and $80)<>0 then
      m_pDV[nTID].Items[nSID].m_sbyPrecision := nErSID and $c0;

      TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SVE:'+DateTimeToStr(m_sTime)+
      ' TID:'+IntToStr(m_swTID)+
      ' SID:'+IntToStr(m_swSID)+
      ' SWD:'+IntToStr(nErSID)+
      ' CMD:'+m_nCommandList.Strings[m_swCMDID]+
      ' VAL:'+FloatToStr(m_sfSvValue));

     End;
     m_pDV[nTID].Count := m_nSlCounter+1;
     if IsUpdate=True then
     Begin
      if (m_nP.m_sblSaved=SV_GRPH_ST)or(m_nP.m_sblSaved=SV_PDPH_ST) then
      Begin
       //m_pDV[nTID].Items[nSID].m_swSID := nSID;
       m_pDV[nTID].Items[0].m_swVMID  := m_nP.m_swVMID;
       m_pDV[nTID].Items[0].m_swCMDID := m_nP.m_swParamID;
       m_pDV[nTID].Items[0].m_swSID := nSID;
       //m_pDV[nTID].Items[0].m_sTime := m_pDV[nTID].Items[nSID].m_sTime;
       Inc(m_nSlCounter);
      End else //if (m_nSlCounter1>0)and((m_nSlCounter1 mod 16)=0) then Inc(m_nSlCounter);
      if (nTID=4) then  Inc(m_nSlCounter);
      Inc(m_nSlCounter1);
     End else
     Begin
      if (m_nP.m_sblSaved=SV_GRPH_ST)or(m_nP.m_sblSaved=SV_PDPH_ST) then
      Begin
       m_pDV[nTID].Items[0].m_swVMID    := m_nP.m_swVMID;
       m_pDV[nTID].Items[0].m_swCMDID   := m_nP.m_swParamID;
       m_pDV[nTID].Items[0].m_swSID     := nSID;
       m_pDV[nTID].Items[0].m_sTime     := m_pDV[nTID].Items[nSID].m_sTime;
       m_pDV[nTID].Items[0].m_sfSvValue := m_pDV[nTID].Items[nSID].m_sfSvValue;
       m_pDV[nTID].Items[0].m_swCMDID   := m_pDV[nTID].Items[nSID].m_swCMDID;
       if m_nP.m_sblSaved=SV_PDPH_ST then
       Begin
        m_pDV[nTID].Items[0].m_sbyPrecision := $00;
        GetCurrentSID(m_pDV[nTID].Items[0].m_swSID,m_pDV[nTID].Items[0].m_sTime);
       End;
      End;
      m_nSlCounter  :=0;
      m_nSlCounter1 :=0;
     End;
    End;
End;
procedure CVparam.GetCurrentSID(var nSID:Word;var dtDate:TDateTime);
Var
    m_SresID : Integer;
    m_QTimestamp : TDateTime;
Begin
    m_QTimestamp := Now;
    m_SresID := trunc(frac(m_QTimestamp)/GetSavePeriod);
    m_SresID := m_SresID - 1;
    if m_SresID<0 then
    Begin
     m_SresID := 47;
     m_QTimestamp := m_QTimestamp - 1;
    End;
    nSID   := m_SresID;
    dtDate := m_QTimestamp;
End;
function CVparam.GetDataTSL1(var pDT:CVToken):Boolean;
Var
    nTID,nSID : Integer;
Begin
    Result := True;
    nTID   := pDT.nTID;
    nSID   := pDT.nSID;
    pDT.fValue := 0;
    if nTID<5 then
    Begin
      if nSID<=(m_pDV[nTID].Count-1) then
     Begin
      pDT.fValue      := m_pDV[nTID].Items[nSID].m_sfSvValue;
      pDT.sTime       := m_pDV[nTID].Items[nSID].m_sTime;
      pDT.sbyOutState := m_pDV[nTID].Items[nSID].m_byOutState;
      pDT.sbyInState  := m_pDV[nTID].Items[nSID].m_byInState;
      pDT.nGSID       := m_pDV[nTID].Items[nSID].m_swSID;
      pDT.m_sbyPrecision:= m_pDV[nTID].Items[nSID].m_sbyPrecision;
      Result := True;
     End;
    End;
End;
function CVparam.GetDataTSL2(var pDT:CVToken):Boolean;
Var
    nTID,nSID : Integer;
    IsFind : Boolean;
Begin
    Result := True;
    pDT.fValue := 0;
    nTID   := pDT.nTID;
    nSID   := pDT.nSID;
    if nTID<5 then
    Begin
     //if (m_nP.m_sblSaved=SV_GRPH_ST) and (m_nP.m_swVMID=21) then
     //  nTID:=0;
     if m_nP.m_swParamID=QRY_MGAKT_POW_S then nTID:=0;
     if (nSID<=(m_pDV[nTID].Count-1)){ or (m_nP.m_swParamID=QRY_MGAKT_POW_S)} then
     Begin
      {IsFind:=False;
      for nTID:=m_pDV[nTID].Count-1 downto 0 do Begin
      if m_pDV[nTID].Items[nSID].m_swSID=pDT.nSID then Begin IsFind:=True;break;End;End;
      if IsFind=False then exit;}
      pDT.fValue      := m_pDV[nTID].Items[nSID].m_sfValue;
      pDT.sTime       := m_pDV[nTID].Items[nSID].m_sTime;
      pDT.sbyOutState := m_pDV[nTID].Items[nSID].m_byOutState;
      pDT.sbyInState  := m_pDV[nTID].Items[nSID].m_byInState;
      pDT.m_sbyPrecision:= m_pDV[nTID].Items[nSID].m_sbyPrecision;
      //pDT.nGSID       := m_pDV[nTID].Items[nSID].m_swSID;
      {
      if m_nP.m_swVMID=27 then
      TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: RUNL2:'+DateTimeToStr(pDT.sTime)+
      ' INCMD:'+m_nCommandList.Strings[m_nP.m_swParamID]);
      }
      pDT.blIsUpdate  := IsUpdate;
      Result := True;
     End;
    End;
End;
function CVparam.GetInfo(var pDT:CVToken):Boolean;
Begin
    if (m_pDV[0].Count=0)or(m_pDV[0].Count>MAX_PARAM) then
    Begin
     pDT.nSID        := 0;
     Result          := False;
    End else
    Begin
     pDT.nSID        := m_pDV[0].Count;
     pDT.nGSID       := m_pDV[0].Items[0].m_swSID;
     pDT.sTime       := m_pDV[0].Items[0].m_sTime;
     pDT.sbyOutState := m_pDV[0].Items[0].m_byOutState;
     pDT.sbyInState  := m_pDV[0].Items[0].m_byInState;
     Result          := True;
    End;
End;
procedure CVparam.SetDataL1(pDT:CVToken);
Var
    nTID,nSID,nmTID : Integer;
Begin
    //if pMsg.m_sbyInfo[1]=QRY_SRES_ENR_EP then
    nTID   := pDT.nTID;
    nSID   := pDT.nSID;
    nmTID  := nTID;
    //if (m_nP.m_swStatus<>CL_READ_PR) then nmTID  := 1;
    //nmTID  := 1;
    with m_pDV[nTID].Items[nSID] do
    Begin
     if (m_nAmTarifs>1)and(nTID=0) then
     Begin
      if (m_nP.m_swStatus=CL_SUMM_TR) then nmTID  := 1;
      m_sTime := m_pDV[nmTID].Items[nSID].m_sTime;
      m_byInState  := m_pDV[nmTID].Items[nSID].m_byInState;
      m_byOutState := m_pDV[nmTID].Items[nSID].m_byOutState;
      m_sfValue    := GetData(nSID);
     End else
     Begin
      m_sfValue      := pDT.fValue;
      m_sbyPrecision := pDT.m_sbyPrecision;
      if IsUpdate=True  then Begin m_swSID := pDT.nGSID;m_swID := nSID;End;// else
      //if IsUpdate=False then Begin m_swID := m_pDV[nTID].Items[0].;End;
     End;
    End;
    {
    if m_nP.m_swVMID=1 then
      TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SRUNL1:'+DateTimeToStr(m_pDV[nTID].Items[nSID].m_sTime)+
      ' INCMD:'+m_nCommandList.Strings[m_nP.m_swParamID]);
    }
    {
    with m_pDV[nTID].Items[nSID] do
    Begin
     TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SET:'+DateTimeToStr(m_sTime)+
      ' TID:'+IntToStr(m_swTID)+
      ' SID:'+IntToStr(m_swSID)+
      ' CMD:'+m_nCommandList.Strings[m_swCMDID]+
      ' VAL:'+FloatToStr(m_sfValue));
    End;
    }
    ExecFindMin(@m_pDV[nTID].Items[nSID]);
    ExecFindMax(@m_pDV[nTID].Items[nSID]);
    ExecSave(@m_pDV[nTID].Items[nSID]);
End;
procedure CVparam.SetDataL2(pDT:CVToken);
Var
    nTID,nSID : Integer;
Begin
    //if (m_nP.m_swParamID=QRY_SRES_ENR_EP)and(m_nP.m_swVMID=11) then
    //m_pDV[pDT.nTID].Count := pDT.nTID + 1;
    //if m_nP.m_swVMID=17 then
    nTID   := pDT.nTID;
    nSID   := pDT.nSID;
    m_pDV[nTID].Count := nSID + 1;
    with m_pDV[nTID].Items[nSID] do
    Begin
     m_swVMID      := m_nP.m_swVMID;
     m_swCMDID     := m_nP.m_swParamID;
     m_swTID       := pDT.nTID;
     m_sTime       := pDT.sTime;
     if (m_nAmTarifs>1)and(nTID=0) then
     Begin
      //m_sTime      := pDT.sTime;{m_pDV[1].Items[nSID].m_sTime};
      m_byInState  := m_pDV[1].Items[nSID].m_byInState;
      m_byOutState := m_pDV[1].Items[nSID].m_byOutState;
      if (m_nP.m_swStatus=CL_READ_PR)  then m_sfValue := pDT.fValue else
      if (m_nP.m_swStatus<>CL_READ_PR) then m_sfValue := GetData(nSID);
     End else
     Begin
      m_sbyPrecision := pDT.m_sbyPrecision;
      IsUpdate       := pDT.blIsUpdate;
      //m_sTime      := pDT.sTime;
      m_swSID := pDT.nGSID;
      if IsUpdate=True  then Begin m_swID := nSID;End;
      //m_swSID      := pDT.nGSID;
      //m_swID       := nSID;
      m_byInState  := pDT.sbyInState;
      m_byOutState := pDT.sbyOutState;
      m_sfValue    := pDT.fValue;
     End;
     {
     if m_nP.m_swVMID=17 then
      TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SRUNL2:'+DateTimeToStr(pDT.sTime)+
      ' INCMD:'+m_nCommandList.Strings[m_nP.m_swParamID]);
     }
    End;
    {
    with m_pDV[nTID].Items[nSID] do
    Begin
     TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SET:'+DateTimeToStr(m_sTime)+
      ' TID:'+IntToStr(m_swTID)+
      ' SID:'+IntToStr(m_swSID)+
      ' CMD:'+m_nCommandList.Strings[m_swCMDID]+
      ' VAL:'+FloatToStr(m_sfValue));
    End;
    }
    ExecFindMin(@m_pDV[nTID].Items[nSID]);
    ExecFindMax(@m_pDV[nTID].Items[nSID]);
    ExecSave(@m_pDV[nTID].Items[nSID]);
End;
procedure CVparam.OnFree;
Var
     i : Integer;
Begin
     if m_pDV[0].Count<48 then
     for i:=0 to m_pDV[0].Count-1 do
     m_pDV[0].Items[i].m_byInState := DT_OLD;
     if (m_nP.m_sblSaved=SV_ARCH_ST)or((m_nP.m_swParamID>=QRY_ENERGY_SUM_EP)and(m_nP.m_swParamID<=QRY_ENERGY_SUM_RM)) then for i:=0 to 4 do m_pDV[i].Count := 0;
     m_pDV[0].Count := 0;
     m_nSlCounter   := 0;
     m_nSlCounter1  := 0;
     //if m_nP.m_sblSaved=SV_CURR_ST then m_pDV[0].Count := 1;
End;
function  CVparam.GetData(nSID:Integer):Double;
Var
    i     : Integer;
    fSumm : Double;
Begin
    if (m_nP.m_swStatus=CL_SUMM_TR) then Result := GetSumm(nSID);
    if (m_nP.m_swStatus=CL_MAXM_TR) then Result := GetMax(nSID);
    if (m_nP.m_swStatus=CL_AVRG_TR) then Result := GetAvg(nSID);
    //if (m_nP.m_swStatus=CL_NOTG_TR) then Result := m_pDV[0].Items[nSID].m_sfValue;
    if (m_nP.m_swStatus=CL_READ_PR) then Result := m_pDV[0].Items[nSID].m_sfSvValue;
End;
function  CVparam.GetSumm(nSID:Integer):Double;
Var
     fVal : Double;
     i,nMaxT : Integer;
Begin
     fVal := 0;
     nMaxT := 4;
     if m_byPLID=1 then nMaxT := 2;
     for i:=1 to nMaxT do fVal := fVal + m_pDV[i].Items[nSID].m_sfValue;
     Result := fVal;
End;
function  CVparam.GetMax(nSID:Integer):Double;
Var
     fVal : Double;
     i    : Integer;
Begin
     fVal := 0;
     for i:=1 to 3 do
     Begin
      with m_pDV[i].Items[nSID] do
      Begin
       if m_sfValue>=fVal then fVal := m_sfValue;
      End;
     End;
     Result := fVal;
End;
function  CVparam.GetAvg(nSID:Integer):Double;
Var
     fVal : Double;
     i    : Integer;
Begin
     fVal := 0;
     {for i:=1 to 3 do
     Begin
      if m_nTParam[i].GetData>=fVal  then
      Begin
       fVal := m_nTParam[i].GetData;
       m_pSV.m_sTime   := m_nTParam[i].m_pSV.m_sTime;
      End;
     End;
     }
     {
     fVal := m_nTParam[1].GetData;
     m_pSV.m_sTime   := m_nTParam[1].m_pSV.m_sTime;

     m_pSV.m_swVMID  := m_nP.m_swVMID;
     m_pSV.m_swTID   := 0;
     m_pSV.m_swCMDID := m_nP.m_swParamID;
     m_pSV.m_swSID   := 0;
     }
     Result := fVal;
End;
procedure CVparam.RunData(fValue:Double);
Var
    i : Integer;
Begin

    //try
    {
    m_nP.m_fValue   := fValue;
    m_pSV.m_sfValue := fValue;
    //if m_pSV.m_swCMDID=13 then
    //if m_nP.m_sblSaved<>SV_GRPH_ST then
    //if (m_nP.m_swVMID=11) and (m_nP.m_swParamID=QRY_NAK_EN_MONTH_EP) then
    if (m_nP.m_swStatus=CL_SUMM_TR)or
       (m_nP.m_swStatus=CL_MAXM_TR)or
       (m_nP.m_swStatus=CL_AVRG_TR) then
    Begin
     m_pSV.m_byInState := m_nTParam[1].m_pSV.m_byInState;
     //m_pSV.m_byInState := DT_NEW;
     for i:=1 to 4 do m_nTParam[i].SaveTarifData;
    End;

    //if m_pSV.m_swCMDID=QRY_ENERGY_DAY_EP then
    //if (m_nP.m_swVMID=1) and (m_nP.m_swParamID=QRY_NAK_EN_MONTH_EP) then
    Begin
     m_pSV.m_byOutState := LM_NRM;
     ExecFindMax(@m_pDV);
     ExecFindMin(@m_pDV);
     ExecSave(@m_pDV);
    End;

    //Sleep(5);
    }
    {
    TraceL(4,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SETT:'+DateTimeToStr(m_pSV.m_sTime)+
    ' S:'    +IntToStr(m_pSV.m_swSID)+
    ' INCMD:'+m_nCommandList.Strings[m_pSV.m_swCMDID]+
    ' := '   +FloatToStr(m_nP.m_fValue));
    }
    //except
    // TraceER('(__)CL3MD::>Error In CVparam.RunData!!!');
    //end
End;
procedure CVparam.SaveTarifData;
Var
    i : Integer;
Begin
    {
    m_pSV.m_sfValue := m_nP.m_fValueSv;
    if m_nP.m_sblSaved<>SV_GRPH_ST then
    Begin
     m_pSV.m_byOutState := LM_NRM;
     ExecFindMax(@m_pDV);
     ExecFindMin(@m_pDV);
    End;
    ExecSave(@m_pDV);
    }
    //Sleep(5);
End;
function CVparam.ExecFindMax(pDV:PL3CURRENTDATA):Boolean;
Var
    res   : Boolean;
Begin
    res := False;
    if pDV.m_sfValue>m_nP.m_fMax then
    pDV.m_byOutState := LM_MAX;
    Result := res;
End;
function CVparam.ExecFindMin(pDV:PL3CURRENTDATA):Boolean;
Var
    res   : Boolean;
Begin
    res := False;
    if pDV.m_sfValue<=m_nP.m_fMin then
    pDV.m_byOutState := LM_MIN;
    Result := res;
End;

function  CVParam.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):integer;
var SumS                         : word;
    Hour0, Min0, Sec0, ms0, Sum0 : word;
    Hour1, Min1, Sec1, ms1, Sum1 : word;
    i                            : byte;
begin
    Result := 0;
    SumS   := 30 * Srez;
    try
    for i := 1 to pTable.Count - 1 do
    begin
      DecodeTime(pTable.Items[i].m_dtTime0, Hour0, Min0, Sec0, ms0);
      DecodeTime(pTable.Items[i].m_dtTime1, Hour1, Min1, Sec1, ms1);
      Sum0 := Hour0*60 + Min0;
      Sum1 := Hour1*60 + Min1;
      if Hour0 < Hour1 then
      begin
        if ((SumS >= Sum0) and (SumS < Sum1)) then
          Result := pTable.Items[i].m_swPTID;
      end
      else
      begin
        if SumS >= Sum0 then
          Result := pTable.Items[i].m_swPTID;
        if SumS < Sum1 then
          Result := pTable.Items[i].m_swPTID;
      end;
    end;
    except
     TraceER('(__)CERMD::>Error In TGraphFrame.GetColorFromTariffs!!!');
    end;
end;

function CVParam.GetCurrentTar(Srez : integer): integer;
var i                    : integer;
begin
   Result := 0;
   for i := 0 to TarTable.Count - 1 do
   begin
     if TarTable.Items[i].m_swTTID <> m_swTID then
       continue;
     Result := GetColorFromTariffs(Srez, TarTable.Items[i]);
     break;
   end;
end;
{procedure TTAbonManager.OnUnloadTest(Sender: TObject);
Var
    pMsg : CMessage;
    i : Integer;
begin
    FillChar(pMsg,500,0);
    pMsg.m_swLen      := 11+5;
    pMsg.m_sbyFor     := DIR_L3TOL3;
    pMsg.m_sbyType    := DL_DATARD_REQ;
    pMsg.m_sbyInfo[0] := 1;
    pMsg.m_sbyInfo[1] := 2;
    pMsg.m_sbyInfo[2] := 3;
    pMsg.m_sbyInfo[3] := 4;
    pMsg.m_sbyInfo[4] := 5;
    m_nUNL.Clear;    }

    {
    m_nUNL.Add(pMsg);
    pMsg.m_sbyInfo[0] := 6;
    pMsg.m_sbyInfo[1] := 7;
    pMsg.m_sbyInfo[2] := 8;
    pMsg.m_sbyInfo[3] := 9;
    pMsg.m_sbyInfo[4] := 10;
    m_nUNL.Add(pMsg);

    pMsg.m_swLen      := 11+2;
    pMsg.m_sbyInfo[0] := 11;
    pMsg.m_sbyInfo[1] := 12;
    m_nUNL.Add(pMsg);
    }
  {  for i:=0 to 2500 do pMsg.m_sbyInfo[i] := i;
    for i:=0 to 40 do
    Begin
     pMsg.m_swLen  := 11+2000;
     m_nUNL.Add(pMsg);
    End;

    m_nUNL.StartSend('6885271');
end;}
procedure CVParam.CreateLimitRemEv(Ev, ABOID : integer; str : string);
var PhoneNumbers : TStrings;
    pMsg         : CMessage;
begin
   PhoneNumbers    := TAbonManager.GetAbonRevNumbers(ABOID);
   m_nUNL.Clear;
   pMsg.m_swLen    := 13+Length(str);
   pMsg.m_sbyFor   := DIR_L3TOL3;
   pMsg.m_sbyType  := DL_LIMIT_IND;
   move(str[1], pMsg.m_sbyInfo[0], Length(str));
   m_nUNL.Add(pMsg);
   m_nUNL.StartSend(PhoneNumbers[0]);
end;

procedure CVParam.LimitGraphH(pDV:PL3CURRENTDATA);
var i     : integer;
    EvStr : string;
begin
   for i := 0 to LimitData.Count - 1 do
   begin
     if not ((pDV.m_sTime >= LimitData.Items[i].DateBeg) or (pDV.m_sTime <= LimitData.Items[i].DateEnd)) then
       continue;
     if (LimitData.Items[i].Tarr = GetCurrentTar(pDV.m_swID)) and (pDV.m_sfValue >= LimitData.Items[i].maxVal)
        and (LimitData.IsMaxValNormal) then
     begin
       LimitData.IsMaxValNormal := false;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, LimitData.Items[i].Tarr, EVM_LSTEP_UP, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Выход за верхний предел лимита.';
       if not m_blIsSlave  then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_LSTEP_UP, LimitData.ABOID, EvStr);
       exit;
     end;
     if (LimitData.Items[i].Tarr = GetCurrentTar(pDV.m_swID)) and (pDV.m_sfValue <= LimitData.Items[i].minVal)
        and (LimitData.IsMinValNormal) then
     begin
       LimitData.IsMinValNormal := false;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, LimitData.Items[i].Tarr, EVM_LSTEP_DOWN, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Выход за нижний предел лимита.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_LSTEP_DOWN, LimitData.ABOID, EvStr);
       exit;
     end;
     if (LimitData.Items[i].Tarr = GetCurrentTar(pDV.m_swID)) and (pDV.m_sfValue < LimitData.Items[i].maxVal)
        and (not LimitData.IsMaxValNormal) then
     begin
       LimitData.IsMaxValNormal := true;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, LimitData.Items[i].Tarr, EVM_L_NORMAL, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Возврат в нормальное состояние.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_L_NORMAL, LimitData.ABOID, EvStr);
       exit;
     end;
     if (LimitData.Items[i].Tarr = GetCurrentTar(pDV.m_swID)) and (pDV.m_sfValue > LimitData.Items[i].minVal)
       and (not LimitData.IsMinValNormal) then
     begin
       LimitData.IsMinValNormal := true;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, LimitData.Items[i].Tarr, EVM_L_NORMAL, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Возврат в нормальное состояние.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_L_NORMAL, LimitData.ABOID, EvStr);
       exit;
     end;
   end;
end;

procedure CVParam.LimitArchH(pDV:PL3CURRENTDATA);
var i     : integer;
    EvStr : string;
begin
   for i := 0 to LimitData.Count - 1 do
   begin
     if not ((pDV.m_sTime >= LimitData.Items[i].DateBeg) or (pDV.m_sTime <= LimitData.Items[i].DateEnd)) then
       continue;
     if (pDV.m_swTID = LimitData.Items[i].Tarr) and (pDV.m_sfValue >= LimitData.Items[i].maxVal)
        and (LimitData.IsMaxValNormal) then
     begin
       LimitData.IsMaxValNormal := false;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, pDV.m_swTID, EVM_LSTEP_UP, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Выход за верхний предел лимита.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_LSTEP_UP, LimitData.ABOID, EvStr);
       exit;
     end;
     if (pDV.m_swTID = LimitData.Items[i].Tarr) and (pDV.m_sfValue <= LimitData.Items[i].minVal)
        and (LimitData.IsMinValNormal) then
     begin
       LimitData.IsMinValNormal := false;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, pDV.m_swTID, EVM_LSTEP_DOWN, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Выход за нижний предел лимита.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_LSTEP_DOWN, LimitData.ABOID, EvStr);
       exit;
     end;
     if (pDV.m_swTID = LimitData.Items[i].Tarr) and (pDV.m_sfValue < LimitData.Items[i].maxVal)
        and (not LimitData.IsMaxValNormal) then
     begin
       LimitData.IsMaxValNormal := true;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, pDV.m_swTID, EVM_L_NORMAL, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Возврат в нормальное состояние.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_L_NORMAL, LimitData.ABOID, EvStr);
       exit;
     end;
     if (pDV.m_swTID = LimitData.Items[i].Tarr) and (pDV.m_sfValue > LimitData.Items[i].minVal)
       and (not LimitData.IsMinValNormal) then
     begin
       LimitData.IsMinValNormal := true;
       m_pDB.FixLimitEvent(pDV.m_swVMID, pDV.m_swCMDID, pDV.m_swTID, EVM_L_NORMAL, pDV.m_sTime);
       EvStr := 'Параметр: ' + GetCMD(pDV.m_swCMDID) +
                '; Время ' + DateTimeToStr(pDV.m_sTime) + '; Возврат в нормальное состояние.';
       if not m_blIsSlave then
       begin
         if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL, EvStr);
         //SoundBox.Play;
       end
       else
         CreateLimitRemEv(EVM_L_NORMAL, LimitData.ABOID, EvStr);
       exit;
     end;
   end;
end;

procedure CVParam.LimitHandler(pDV : PL3CURRENTDATA);
begin
   if ((pDV.m_swCMDID >= QRY_SRES_ENR_EP) and (pDV.m_swCMDID <= QRY_SRES_ENR_RM)) or
      ((pDV.m_swCMDID >= QRY_E30MIN_POW_EP) and (pDV.m_swCMDID <= QRY_E30MIN_POW_RM)) then
     LimitGraphH(pDV)
   else
     LimitArchH(pDV);
end;

function CVparam.ExecSave(pDV:PL3CURRENTDATA):Boolean;
Var
    res   : Boolean;
    pData : L3CURRENTDATA;
Begin
    res:=False;
    if abs(pDV.m_sfValue)<0.000001 then pDV.m_sfValue := 0;
    //SaveCurrentAction(pDV);
    //m_nWrite:=m_nWrite+1;
    LimitHandler(pDV);
    case m_nP.m_sblSaved of
     SV_CURR_ST: SaveCurrentAction(pDV);
     SV_ARCH_ST: SaveArchiveAction(pDV);
     SV_GRPH_ST: SaveGraphicsAction(pDV);
     SV_PDPH_ST: SavePeriodicAction_48(pDV);
    End;
    Result := res;
End;
function CVparam.HiHandler(var pMsg:CMessage):Boolean;
Var
    res   : Boolean;
Begin
    res := True;
    Result := res;
End;


function CVparam.ReturnCRC(m_sfValue:array of double):integer;
begin
 result := CalcCRCDB(@m_sfValue,length(m_sfValue)*sizeof(double));
end;


procedure CVparam.SaveCurrentAction(pData:PL3CURRENTDATA);
Begin
    pData.m_CRC           := ReturnCRC(pData.m_sfValue);
    pData.m_sbyMaskReRead := m_nP.m_sbyLockState;
    m_pDB.SetCurrentParam(pData^);
    //pData.m_byInState := DT_OLD;
End;
procedure CVparam.SaveArchiveAction(pData:PL3CURRENTDATA);
Var
     pDS       : CMessageData;
     SystemTime: TSystemTime;
Begin
    pData.m_sbyMaskReRead := m_nP.m_sbyLockState;
    if IsUpdate then
    begin
     pData.m_sbyMaskRead   := 1;
     pData.m_CRC := ReturnCRC(pData.m_sfValue);


     pData.m_byInState := DT_FLS;
     m_pDB.SetCurrentParam(pData^);
     //m_pDB.AddArchData(pData^);
    end
    else
    begin
     if pData.m_swTID<5 then
     if (m_nP.m_stSvPeriod=1)or(Now>=(m_pDT[pData.m_swTID]+m_dtSavePeriod))or(trunc(Now)-trunc(m_pDT[pData.m_swTID])<>0) then
     Begin
      //m_nP.m_dtLastTime   := Now;
      //m_pDT[pData.m_swTID]:= m_nP.m_dtLastTime;
      //m_pDB.UpateLastTime(m_nP.m_swVMID,m_nP.m_swParamID,m_nP.m_dtLastTime);
      DateTimeToSystemTime(Now,SystemTime);
      SystemTime.wSecond   :=0;SystemTime.wMilliseconds:=0;
      m_pDT[pData.m_swTID] :=  SystemTimeToDateTime(SystemTime);
      pData.m_CRC := ReturnCRC(pData.m_sfValue);
      pData.m_byInState := DT_FLS;
      m_pDB.SetCurrentParam(pData^);
      //m_pDB.AddArchData(pData^);
     End;
    end;
End;
{
procedure CVparam.SavePeriodicAction(pData:PL3CURRENTDATA);
Var
     pDS : CMessageData;
     SystemTime: TSystemTime;
Begin
    if IsUpdate then
    begin
     m_pDB.AddPdtData(pData^);
    end
    else
    begin
     m_pDB.SetCurrentParam(pData^);
     if pData.m_swTID<5 then
     if (Now>=(m_pDT[pData.m_swTID]+m_dtSavePeriod)) then
     Begin
      DateTimeToSystemTime(Now,SystemTime);
      SystemTime.wSecond   :=0;SystemTime.wMilliseconds:=0;
      m_pDT[pData.m_swTID] :=  SystemTimeToDateTime(SystemTime);
      pData.m_sTime        :=  m_pDT[pData.m_swTID];
      m_pDB.AddPdtData(pData^);
     End;
    End;
End;
}
procedure CVparam.SavePeriodicAction_48(pData:PL3CURRENTDATA);
Var
    i,j,CRC_Read : Integer;
Begin
    //SaveGraphicsEnergoAction(pData);
    if IsUpdate=True then
    Begin
     //if m_nP.m_swVMID=29 then
     m_pvGraph.m_swVMID  := m_nP.m_swVMID;
     m_pvGraph.m_swCMDID := m_nP.m_swParamID;
     m_pvGraph.m_sdtDate := trunc(pData.m_sTime);
     if pData.m_swSID>=0 then
     begin
      m_pvGraph.v[pData.m_swID] := pData.m_sfValue;
      if pData.m_sbyPrecision and $80 = 0  then SetByteMask(m_pvGraph.m_sMaskRead, pData.m_swID) else
      if pData.m_sbyPrecision and $80 <> 0 then RemByteMask(m_pvGraph.m_sMaskRead, pData.m_swID);
     end;
     if pData.m_swSID=0 then
     Begin
      if pData.m_sbyPrecision and $80 = 0  then SetByteMask(m_pvGraph.m_sMaskRead, pData.m_swID) else
      if pData.m_sbyPrecision and $80 <> 0 then RemByteMask(m_pvGraph.m_sMaskRead, pData.m_swID);
      m_pvGraph.m_sdtLastTime := pData.m_sTime;
      m_pvGraph.m_swSumm      := 0;
      if m_nP.m_sblEnable=1 then m_pDB.AddPDTData_48(m_pvGraph^);
      for i:=0 to 47 do m_pvGraph.v[i]:=0;
      m_pvGraph.m_sMaskRead := 0;
     End;
    End else
    Begin
     m_pDB.SetCurrentParam(pData^);
     if m_nP.m_sblEnable=1 then m_pDB.UpdatePDTFilds_48(pData^);
     pData.m_swTID := 0;
    End;
End;
procedure CVparam.SaveGraphicsAction(pData:PL3CURRENTDATA);
Var
    i,j,CRC_Read : Integer;
Begin
    //SaveGraphicsEnergoAction(pData);
    if IsUpdate=True then
    Begin
     //if m_nP.m_swVMID=16 then
     //m_pvGraph.m_swVMID  := m_nP.m_swVMID;
     m_pvGraph.m_swVMID  := m_nP.m_swVMID;
     m_pvGraph.m_swCMDID := m_nP.m_swParamID;
     m_pvGraph.m_sdtDate := trunc(pData.m_sTime);
     //TraceL(3,m_nP.m_swVMID,'(__)CL3MD::>CVPRM: SVE0:'+DateTimeToStr(pData.m_sTime)+
     // ' PID:'+IntToStr(pData.m_swID)+
     // ' VAL:'+FloatToStr(pData.m_sfValue));
     if pData.m_swSID>=0 then
     begin
      m_pvGraph.v[pData.m_swID] := pData.m_sfValue;
      if (pData.m_sbyPrecision and $80)=0  then SetByteMask(m_pvGraph.m_sMaskRead, pData.m_swID) else
      if (pData.m_sbyPrecision and $80)<>0 then RemByteMask(m_pvGraph.m_sMaskRead, pData.m_swID);
      if (m_nP.m_sbyLockState=PR_TRUE)and((pData.m_sbyPrecision and $40)=0) then SetByteMask(m_pvGraph.m_sMaskReRead , pData.m_swID) else
      if (m_nP.m_sbyLockState=PR_FAIL)or ((pData.m_sbyPrecision and $40)<>0)then RemByteMask(m_pvGraph.m_sMaskReRead , pData.m_swID);
     end;
     if pData.m_swSID=0 then
     Begin
      //if m_nP.m_swVMID=24 then
      //   m_pvGraph.m_swVMID  := m_nP.m_swVMID;
      if (pData.m_sbyPrecision and $80)=0  then SetByteMask(m_pvGraph.m_sMaskRead, pData.m_swID) else
      if (pData.m_sbyPrecision and $80)<>0 then RemByteMask(m_pvGraph.m_sMaskRead, pData.m_swID);
      if (m_nP.m_sbyLockState=PR_TRUE)and((pData.m_sbyPrecision and $40)=0) then SetByteMask(m_pvGraph.m_sMaskReRead , pData.m_swID) else
      if (m_nP.m_sbyLockState=PR_FAIL)or ((pData.m_sbyPrecision and $40)<>0)then RemByteMask(m_pvGraph.m_sMaskReRead , pData.m_swID);
      m_pvGraph.m_sdtLastTime := pData.m_sTime;
      m_pvGraph.m_swSumm      := 0;
      if m_nUpdateFunction=0 then  m_pDB.AddIfExGraphData(m_pvGraph^) else
      if m_nUpdateFunction=1 then  m_pDB.AddGraphData(m_pvGraph^);
      for i:=0 to 47 do m_pvGraph.v[i]:=0;
      m_pvGraph.m_sMaskRead   := 0;
      m_pvGraph.m_sMaskReRead := 0;
     End;
    End else
    Begin
     pData.m_sbyMaskReRead := m_nP.m_sbyLockState;
     m_pDB.UpdateGraphFilds(pData^);
     pData.m_swTID := 0;
     //SaveCurrentAction(pData);
    End;
End;
//m_pDV[nTID].Items[0].m_swSID := trunc(frac(m_pDV[nTID].Items[0].m_sTime)/GetSavePeriod);
////////energotel/////////////////////////
{
procedure CVparam.SaveArchiveEnergoAction(pData:PL3CURRENTDATA);
Var
    m_pTable       : VAl;
    m_nobj: SL3VMETERTAG;
    i : Integer;
    str : string[255];
Begin
     if  (m_nP.m_swParamID >= 17) and (m_nP.m_swParamID <= 20) then
     begin
     m_pTable.n_obj      := m_nP.m_swVMID;
     m_pTable.n_ri       := 0;
     m_pTable.izm_type   := m_nP.m_swParamID - QRY_NAK_EN_DAY_EP + 5 ;
     m_pTable.data       := pData.m_sTime;
     m_pTable.n_zone     := pData.m_swTID;
     m_pTable.flag       := '';
     m_pTable.znach := pData.m_sfValue;
     m_pTable.inter_val  := 0;
     m_pDB.AddArchDataEnergo(m_pTable);
     end;
end;
procedure CVparam.SaveGraphicsEnergoAction(pData:PL3CURRENTDATA);
Var
    m_pTable       : VAl;
    m_nobj: SL3VMETERTAG;
    i : Integer;
    str : string[255];
Begin
     if  (m_nP.m_swParamID >=13) and (m_nP.m_swParamID <= 16) then
     begin
     m_pTable.n_obj      := m_nP.m_swVMID;
     m_pTable.n_ri       := 0;
     m_pTable.izm_type   := m_nP.m_swParamID - QRY_SRES_ENR_EP + 1;
     m_pTable.data       := pData.m_sTime;
     m_pTable.n_zone     :=0;
     m_pTable.flag       := '';
     i := pData.m_swSID;
      if pData.m_swSID>=0 then  begin
      m_pTable.znach := pData.m_sfValue;
      m_pTable.inter_val := i + 1;
      m_pDB.AddGraphDataEnergo(m_pTable);
     end;
      end;
End;
}
{
Не сохранять
0 мин
3 мин
15 мин
30 мин
1 час
3 часа
6 часов
Сутки
Месяц
Год
}
function CVparam.GetSavePeriod:TDateTime;
Var
     Year,Month,Day,Hour,Min,Sec,MSec:Word;
     mDT,mTM : TDateTIme;
Begin
     mDT:=EncodeTime(0,0,1,0);
     case m_nP.m_stSvPeriod of
       1: mDT := EncodeTime(0,30,0,0);
       2: mDT := EncodeTime(0,3,0,0);
       3: mDT := EncodeTime(0,15,0,0);
       4: mDT := EncodeTime(0,30,0,0);
       5: mDT := EncodeTime(1,0,0,0);
       6: mDT := EncodeTime(3,0,0,0);
       7: mDT := EncodeTime(6,0,0,0);
     End;
     Result := mDT;
     //if m_nP.m_stSvPeriod=2 then
     //Year  := 0;Month,Day
     //1900,1,1
     //DecodeDate(mDT,Year,Month,Day);
     //Hour := 0;Min  := 30;Sec  := 0; MSec := 0;
     //mTM := EncodeTime(Hour,Min,Sec,MSec);
     //mDT
End;
procedure CVparam.SendMSG(byBox,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
     m_swLen       := 11;
     m_swObjID     := 0;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     end;
    FPUT(byBox,@pMsg);
End;
end.
