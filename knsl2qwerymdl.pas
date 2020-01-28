unit knsl2qwerymdl;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
controls,utldatabase,knsl3EventBox,knsl2qwerytmr,knsl2module,utlTimeDate,knsl3jointable,knsl3HolesFinder;
type
    CQweryMDL = class(CTimeMDL)
    protected
     m_pMT   : PCMeter;
     m_byUpdate : Byte;
    protected
     procedure Start;
     procedure EVT(nCMDID,wFinal:Integer);
     procedure GetHandle(var pQR:CQueryPrimitive;nCMDID:Integer);
     procedure LoadData(dtBegin,dtEnd:TDateTime;nCMDID:Integer;blOneSlice:Byte);virtual;
     procedure InitCMD(nCMDID:Integer;var IsFree:Boolean);
     procedure LoadQS(nCMDID:Integer);
     procedure LoadAll;
     procedure FreeCmd;
     procedure LoadCMD(nCMDID:Integer);
     procedure FinishCMD(nCMDID:Integer;IsFree:Boolean);
     procedure LoadQSV(nCMDID:Integer);
     procedure LoadCMDV(nCMDID:Integer);virtual;
     procedure OnEndQwery(nCMDID:Integer);virtual;
     procedure OnTimeExpired;virtual;
     procedure OnExpired;override;
    public
     constructor Create(var pTbl:SQWERYMDL);
     destructor Destroy();override;
     function  EventHandler(var pMsg:CMessage):Boolean;
     function  IsFind(nCMD:Integer):Boolean;virtual;
     //function  IsExists(nCMD:Integer):Boolean;virtual;
     function  GetFindBuffer(snPrmID:Integer;var nDT:SHALLSDATES):Boolean;virtual;
     procedure HandQwery(snPrmID:Integer);
     procedure StartFindPrg(snPrmID:Integer;var nDT:SHALLSDATES);virtual;
     procedure Find(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer;nCause:DWord);virtual;
     procedure Update(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);virtual;
     procedure StopQwery(byCause:Byte);virtual;
     procedure OnInit; override;
     procedure OnEndLoad;virtual;
     procedure OnEndQweryMdl(nCMDID:Integer);
     procedure OnErrQwery;virtual;
     function  SendErrorL2(snPrmID:Integer):Boolean;virtual;
     procedure SetLockState(snVMID,snPrmID:Integer;byState:Byte);
     //procedure SetAllLock(snVMID:Integer;byState:Byte);
     //procedure SetLock(snVMID,snPrmID:Integer;byState:Byte);
     //Hand Function
    End;
implementation
//CQweryMDL
destructor CQweryMDL.Destroy();
Begin
End;
constructor CQweryMDL.Create(var pTbl:SQWERYMDL);
Begin
     m_byUpdate := 0;
     m_pMT := mL2Module.GetL2Object(pTbl.m_snMID);
     inherited Create(pTbl);
End;
procedure CQweryMDL.OnInit;
Begin
End;
function CQweryMDL.EventHandler(var pMsg:CMessage):Boolean;
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(pMsg.m_sbyInfo[0],pDS,sizeof(CMessageData));
     Move(pDS.m_sbyInfo[0] ,sQC,sizeof(SQWERYCMDID));
     //with sQC do
     //case m_snCmdID of
          //QS_END_LD_VM : OnEndLoad;
          //QS_END_QW_VM : OnEndQweryMdl(sQC.m_snResult);
          //QS_ERR_QW_VM : OnErrQwery;
     //End;
End;
procedure CQweryMDL.OnEndLoad;
Begin
End;
procedure CQweryMDL.OnEndQweryMdl(nCMDID:Integer);
Begin
     FreeCmdState(nCMDID);
     OnEndQwery(nCMDID);
End;
procedure CQweryMDL.OnEndQwery(nCMDID:Integer);
Begin
End;
procedure CQweryMDL.OnErrQwery;
Begin
End;
procedure CQweryMDL.InitCMD(nCMDID:Integer;var IsFree:Boolean);
Begin
     IsFree := False;
     FCLRSYN(BOX_L3_QS+m_nTbl.m_snPID);
     if FCHECK(BOX_L3_QS+m_nTbl.m_snPID)=0 then IsFree := True;
     EVT(nCMDID,QM_ENT_MON_IND);
     EVT(nCMDID,QM_ENT_MTR_IND);
     //Sleep(50);//AAV
End;
procedure CQweryMDL.FinishCMD(nCMDID:Integer;IsFree:Boolean);
Begin
     EVT(nCMDID,QM_FIN_MTR_IND);
     EVT(nCMDID,QM_FIN_COM_IND);
     EVT(nCMDID,QM_FIN_MON_IND);
     FSETSYN(BOX_L3_QS+m_nTbl.m_snPID);
     //Sleep(50);//AAV
     //m_pMX.SetTrapsState(m_nTbl.m_snVMID,nCMDID,($80 or TRP_WAIT));
     if IsFree=True then
     SendMSG(BOX_L2,m_nTbl.m_snPID,DIR_QMTOL2,DL_STARTSNDR_IND);
     // else  EventBox.FixEvents(ET_CRITICAL,'CQweryMDL.FinishCMD SERVER START ERROR:'+IntToStr(m_nTbl.m_snPID));
End;
procedure CQweryMDL.LoadQS(nCMDID:Integer);
Var
     IsFree : Boolean;
Begin
     InitCMD(nCMDID,IsFree);
     LoadCMD(nCMDID);
     FinishCMD(nCMDID,IsFree);
     //ClearDMX(m_nTbl.m_snAID,m_nTbl.m_snVMID,nCMDID);//AAV
End;
procedure CQweryMDL.LoadQSV(nCMDID:Integer);
Var
     IsFree : Boolean;
Begin
     InitCMD(nCMDID,IsFree);
     LoadCMDV(nCMDID);
     FinishCMD(nCMDID,IsFree);
End;
procedure CQweryMDL.LoadCMD(nCMDID:Integer);
Begin
     if m_pMT=Nil then exit;
     m_pMT.PObserver.LoadParamQS(nCMDID);
End;
procedure CQweryMDL.LoadCMDV(nCMDID:Integer);
Begin
End;
{
//Примитив запроса
    CQueryPrimitive = packed record
     m_wLen       : Word;
     m_swVMtrID   : Integer;
     m_swMtrID    : Word;
     m_swCmdID    : Word;
     m_swParamID  : Word;
     m_swChannel  : string[8];
     m_swSpecc0   : Smallint;
     m_swSpecc1   : Smallint;
     m_swSpecc2   : Smallint;
     m_sbyEnable  : Byte;
    End;
}
procedure CQweryMDL.EVT(nCMDID,wFinal:Integer);
Var
     pQR : CQueryPrimitive;
Begin
     with pQR do
     Begin
      m_wLen      := sizeof(CQueryPrimitive);
      m_swVMtrID  := m_nTbl.m_snVMID;
      m_swMtrID   := m_nTbl.m_snMID;
      m_swParamID := wFinal;
      m_swCmdID   := m_byUpdate;
      GetHandle(pQR,nCMDID);
      m_sbyEnable := 1;
     End;
     FPUT(BOX_L3_QS+m_nTbl.m_snPID,@pQR);
End;
procedure CQweryMDL.LoadAll;
Var
     strCMD : String;
     nCMDID : Integer;
Begin
     Begin
      strCMD := m_nTbl.m_strCMDCluster;
      while GetCode(nCMDID,strCMD)<>False do
      Begin
       if (nCMDID and CMD_ENABLED)<>0 then
       LoadQS(nCMDID and (not CMD_ENABLED));
      End;
     End;
End;
procedure CQweryMDL.FreeCmd;
Var
     strCMD : String;
     nCMDID : Integer;
Begin
     Begin
      strCMD := m_nTbl.m_strCMDCluster;
      while GetCode(nCMDID,strCMD)<>False do
      Begin
       if (nCMDID and CMD_QWRCMPL)<>0 then
       FreeCmdState(nCMDID and (not CMD_QWRCMPL));
      End;
     End;
End;
procedure CQweryMDL.GetHandle(var pQR:CQueryPrimitive;nCMDID:Integer);
Begin
     with pQR,m_nTbl do
     Begin
      m_swSpecc0 := nCMDID and (not CMD_ENABLED);
      m_swSpecc0 := m_swSpecc0 or (Word(m_snCLSID) shl 8);
      m_swSpecc1 := Word(m_snCLID);
      m_swSpecc2 := Word(m_snSRVID);
      m_swSpecc2 := m_swSpecc2 or (Word(m_snAID) shl 8);
     End;
End;
procedure CQweryMDL.Start;
Begin

End;
procedure CQweryMDL.OnExpired;
Begin
     OnTimeExpired;
End;
procedure CQweryMDL.OnTimeExpired;
Begin
     HandQwery(-1);
End;
procedure CQweryMDL.LoadData(dtBegin,dtEnd:TDateTime;nCMDID:Integer;blOneSlice:Byte);
Begin
End;
procedure CQweryMDL.HandQwery(snPrmID:Integer);
Var
     byUpd : Byte;
Begin
     if not IsEnabled then exit;
     byUpd := m_byUpdate;
     m_byUpdate := 0;
      if snPrmID<>-1 then LoadQS(snPrmID) else
      if snPrmID=-1  then LoadAll;
     m_byUpdate := byUpd;
     //Begin m_byUpdate := 0;LoadData(trunc(Now),trunc(Now),-1,0);m_byUpdate := 1;End;
End;
procedure CQweryMDL.SetLockState(snVMID,snPrmID:Integer;byState:Byte);
Begin
     //if snPrmID<>-1 then SetLock(snVMID,snPrmID,byState) else
     //if snPrmID=-1  then SetAllLock(snVMID,byState);
End;
procedure CQweryMDL.StopQwery(byCause:Byte);
Begin
     if m_pMT=Nil then exit;
     if byCause=0 then m_pMT.OnFinal;
     if byCause=1 then m_pMT.OnFree;
     FreeCmd;
End;
function  CQweryMDL.GetFindBuffer(snPrmID:Integer;var nDT:SHALLSDATES):Boolean;
Begin
     Result := False;
End;
function  CQweryMDL.IsFind(nCMD:Integer):Boolean;
Begin
     Result := True;
End;
{
function CQweryMDL.IsExists(nCMD:Integer):Boolean;
Begin
     Result := True;
End;
}
procedure CQweryMDL.Find(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer;nCause:DWord);
Begin
End;
procedure CQweryMDL.Update(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Begin
End;
procedure CQweryMDL.StartFindPrg(snPrmID:Integer;var nDT:SHALLSDATES);
Begin
End;
function CQweryMDL.SendErrorL2(snPrmID:Integer):Boolean;
Begin
     //m_pMT.OnFinal;
End;

end.
