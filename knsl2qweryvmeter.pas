unit knsl2qweryvmeter;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl3EventBox,utlSpeedTimer,utlTimeDate,knsl2qwerymdl,knsl2qweryarchmdl,knsl3HolesFinder;
type
    SQWMDLS = packed record
     Count : Integer;
     Items : array[0..MAX_CLUSTER] of CQweryMDL;
    End;
    TFindRespond = function(snCLSID,snPrmID:Integer):Boolean of object;
    CQweryVMeter = class
    protected
     m_nQMD   : SQWMDLS;
     m_PFindResp:TFindRespond;
    protected
     destructor Destroy;override;
    public
     m_pDDB   : Pointer;
     m_snCLID : Integer;
     m_snVMID : Integer;
     m_snPID  : Integer;
     constructor Create(PFindResp:TFindRespond;pDDB:Pointer;snCLID,snVMID,snPID:Integer);
     procedure HandQweryCluster(snCLSID,snPrmID:Integer);
     procedure HandQweryAllCluster(snPrmID:Integer);
     procedure OnEndQwery(snCLSID,snPrmID:Integer);
     function  IsComplette(snCLSID,snPrmID:Integer):Boolean;
     function  IsFind(snCLSID,snPrmID:Integer):Boolean;
     function  IsExists(snCLSID,snPrmID:Integer):Boolean;
     procedure SetCmdState(snCLSID,snPrmID:Integer);
     procedure FreeCmdState(snCLSID,snPrmID:Integer);
     function  GetFindBuffer(snCLSID,snPrmID:Integer;var nDT:SHALLSDATES):Boolean;
     procedure FindCluster(snCLSID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer;nCause:DWord);
     procedure UpdateCluster(snCLSID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     procedure FindAllCluster(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer;nCause:DWord);
     procedure UpdateAllCluster(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     procedure StartFindPrg(snCLSID,snPrmID:Integer;var nDT:SHALLSDATES);
     procedure SetAllFindPrg(snPrmID:Integer;var nDT:SHALLSDATES);
     procedure StopCluster(snCLSID:Integer;byCause:Byte);
     procedure StopAllCluster(byCause:Byte);
     function  SendErrorL2(snCLSID,snPrmID:Integer):Boolean;
     procedure Add(snSRVID:Integer);
     procedure UpdateIsExists(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
     //procedure Init(snSRVID:Integer);
     procedure Init(var pTbl:SQWERYMDLS);
     //function  InitQweryMDL(snSRVID:Integer;var pTbl:SQWERYMDL):Boolean;
     procedure CreateQweryMDL(var pTbl:SQWERYMDL);
     procedure Delete(snCLSID:Integer);
     procedure DeleteAll;
     procedure Run;
    End;
    PCQweryVMeter =^ CQweryVMeter;
implementation
constructor CQweryVMeter.Create(PFindResp:TFindRespond;pDDB:Pointer;snCLID,snVMID,snPID:Integer);
Begin
     m_pDDB   := pDDB;
     m_snCLID := snCLID;
     m_snVMID := snVMID;
     m_snPID  := snPID;
     m_PFindResp := PFindResp;
End;
destructor CQweryVMeter.Destroy;
//Var
//     i : Integer;
Begin
     DeleteAll;
     {
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then
     Begin
      m_nQMD.Items[i].Destroy;
      m_nQMD.Items[i] := Nil;
     End;
     }
End;
procedure CQweryVMeter.Add(snSRVID:Integer);
Var
     pTbl : SQWERYMDLS;
Begin
     {
     if m_pDB.GetQweryMDLTable(m_snVMID,snSRVID,pTbl)=True then
     Begin
      if m_nQMD.Count<MAX_CLUSTER then
      Begin
       m_nQMD.Items[snSRVID] := CQweryMDL.Create(pTbl.Items[0]);
       m_nQMD.Count := m_nQMD.Count + 1;
      End;
     End;
     }
End;
procedure CQweryVMeter.Init(var pTbl:SQWERYMDLS);
Var
     i : Integer;
Begin
     DeleteAll;
     for i:=0 to pTbl.Count-1 do
     Begin
      if m_nQMD.Count<MAX_CLUSTER then
      CreateQweryMDL(pTbl.Items[i]);
     End;
End;
{
     CLS_MGN      = 1;
     CLS_GRAPH48  = 4;
     CLS_DAY      = 8;
     CLS_MONT     = 9;
     CLS_EVNT     = 11;
     CLS_TIME     = 12;
     CLS_PNET     = 13;
}
procedure CQweryVMeter.CreateQweryMDL(var pTbl:SQWERYMDL);
Begin
     case pTbl.m_snCLSID of
          CLS_DAY,
          CLS_MONT,
          CLS_GRAPH48,
          CLS_PNET,CLS_EVNT: m_nQMD.Items[pTbl.m_snCLSID] := CQweryArchMDL.Create(m_PFindResp,m_pDDB,pTbl);
          CLS_MGN,CLS_TIME : m_nQMD.Items[pTbl.m_snCLSID] := CQweryMDL.Create(pTbl);
     End;
End;
procedure CQweryVMeter.Delete(snCLSID:Integer);
Begin
     if snCLSID=-1  then DeleteAll else
     if snCLSID<>-1 then
     Begin
      if Assigned(m_nQMD.Items[snCLSID]) then
      Begin
       m_nQMD.Items[snCLSID].Destroy;
       m_nQMD.Items[snCLSID] := Nil;
       if m_nQMD.Count>=1 then m_nQMD.Count := m_nQMD.Count - 1;
      End;
     End;
End;
procedure CQweryVMeter.DeleteAll;
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then Delete(i);
End;
procedure CQweryVMeter.Run;
Var
     i : Integer;
Begin
     try
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].Run;
     except

     end;
End;
procedure CQweryVMeter.HandQweryCluster(snCLSID,snPrmID:Integer);
Begin
     if snCLSID=-1  then HandQweryAllCluster(snPrmID) else
     if snCLSID<>-1 then if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].HandQwery(snPrmID);
End;
procedure CQweryVMeter.HandQweryAllCluster(snPrmID:Integer);
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].HandQwery(snPrmID);
End;
procedure CQweryVMeter.StartFindPrg(snCLSID,snPrmID:Integer;var nDT:SHALLSDATES);
Begin
     if snCLSID=-1  then SetAllFindPrg(snPrmID,nDT) else
     if snCLSID<>-1 then if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].StartFindPrg(snPrmID,nDT);
End;
procedure CQweryVMeter.SetAllFindPrg(snPrmID:Integer;var nDT:SHALLSDATES);
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].StartFindPrg(snPrmID,nDT);
End;
procedure CQweryVMeter.FindCluster(snCLSID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer;nCause:DWord);
Begin
     if snCLSID=-1  then FindAllCluster(sdtBegin,sdtEnd,snPrmID,nCause) else
     if snCLSID<>-1 then if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].Find(sdtBegin,sdtEnd,snPrmID,nCause);
End;
procedure CQweryVMeter.FindAllCluster(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer;nCause:DWord);
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then
     Begin
      if m_nQMD.Items[i].IsExists(snPrmID)or(snPrmID=-1) then
      m_nQMD.Items[i].Find(sdtBegin,sdtEnd,snPrmID,nCause);
     End;
End;
procedure CQweryVMeter.UpdateCluster(snCLSID:Integer;sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Begin
     if snCLSID=-1  then UpdateAllCluster(sdtBegin,sdtEnd,snPrmID) else
     if snCLSID<>-1 then if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].Update(sdtBegin,sdtEnd,snPrmID);
End;
procedure CQweryVMeter.UpdateAllCluster(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].Update(sdtBegin,sdtEnd,snPrmID);
End;
procedure CQweryVMeter.OnEndQwery(snCLSID,snPrmID:Integer);
Begin
     if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].OnEndQweryMdl(snPrmID);
End;
procedure CQweryVMeter.SetCmdState(snCLSID,snPrmID:Integer);
Begin
     if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].SetCmdState(snPrmID);
End;
function CQweryVMeter.GetFindBuffer(snCLSID,snPrmID:Integer;var nDT:SHALLSDATES):Boolean;
Begin
     Result := False;
     if Assigned(m_nQMD.Items[snCLSID]) then Result := m_nQMD.Items[snCLSID].GetFindBuffer(snPrmID,nDT);
End;
procedure CQweryVMeter.FreeCmdState(snCLSID,snPrmID:Integer);
Begin
     if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].FreeCmdState(snPrmID);
End;
function CQweryVMeter.IsComplette(snCLSID,snPrmID:Integer):Boolean;
Begin
     Result := False;
     if Assigned(m_nQMD.Items[snCLSID]) then Result := m_nQMD.Items[snCLSID].IsComplette(snPrmID);
End;
function CQweryVMeter.IsFind(snCLSID,snPrmID:Integer):Boolean;
Begin
     Result := False;
     if Assigned(m_nQMD.Items[snCLSID]) then Result := m_nQMD.Items[snCLSID].IsFind(snPrmID);
End;
function CQweryVMeter.IsExists(snCLSID,snPrmID:Integer):Boolean;
Begin
     Result := False;
     if Assigned(m_nQMD.Items[snCLSID]) then Result := m_nQMD.Items[snCLSID].IsExists(snPrmID);
End;
procedure CQweryVMeter.StopCluster(snCLSID:Integer;byCause:Byte);
Begin
     if snCLSID=-1  then StopAllCluster(byCause) else
     if snCLSID<>-1 then if Assigned(m_nQMD.Items[snCLSID]) then m_nQMD.Items[snCLSID].StopQwery(byCause);
End;
procedure CQweryVMeter.StopAllCluster(byCause:Byte);
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].StopQwery(byCause);
End;
procedure CQweryVMeter.UpdateIsExists(sdtBegin,sdtEnd:TDateTime;snPrmID:Integer);
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     Begin
      if IsExists(i,snPrmID)=True then
      if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].Update(sdtBegin,sdtEnd,snPrmID);
     End;
End;
function CQweryVMeter.SendErrorL2(snCLSID,snPrmID:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;

     if snCLSID=-1 then
     Begin
      for i:=0 to MAX_CLUSTER do
      if Assigned(m_nQMD.Items[i]) then Result := m_nQMD.Items[i].SendErrorL2(snPrmID);
     End else
     if Assigned(m_nQMD.Items[snCLSID]) then Result := m_nQMD.Items[snCLSID].SendErrorL2(snPrmID);
End;
end.
