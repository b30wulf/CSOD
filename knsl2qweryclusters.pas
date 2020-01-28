unit knsl2qweryclusters;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utlmtimer,
 utldatabase,knsl2statistic,knsl3EventBox,utlSpeedTimer,utlTimeDate,knsl2qwerymdl;
type
    SQWMDLS = packed record
     Count : Integer;
     Items : array[0..MAX_CLUSTER] of CQweryMDL;
    End;
    CQweryClusters = class
    protected
     m_snVMID : Integer;
     m_nQMD   : SQWMDLS;
    protected
     destructor Destroy;override;
    public
     constructor Create(snVMID:Integer);
     procedure HandQwery(snSRVID:Integer);
     procedure HandQweryAll;
     procedure Add(snSRVID:Integer);
     procedure Init(snSRVID:Integer);
     procedure InitAll;
     procedure Delete(snSRVID:Integer);
     procedure DeleteAll;
     procedure Run;
    End;
Var
    m_nQMDL : array[0..MAX_VMETER] of CQweryClusters;
implementation
constructor CQweryClusters.Create(snVMID:Integer);
Begin
     m_snVMID := snVMID;
End;
destructor CQweryClusters.Destroy;
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].Destroy;
End;
//≈сли модули опроса еще не созданы
procedure CQweryClusters.Add(snSRVID:Integer);
Var
     pTbl : SQWERYMDLS;
Begin
     if m_pDB.GetQweryMDLTable(m_snVMID,snSRVID,pTbl)=True then
     Begin
      if m_nQMD.Count<MAX_CLUSTER then
      Begin
       m_nQMD.Items[snSRVID] := CQweryMDL.Create(pTbl.Items[0]);
       m_nQMD.Count := m_nQMD.Count + 1;
      End;
     End;
End;
// огда модули опроса уже созданы созданы
procedure CQweryClusters.Init(snSRVID:Integer);
Var
     pTbl : SQWERYMDLS;
Begin
     if m_pDB.GetQweryMDLTable(m_snVMID,snSRVID,pTbl)=True then
     Begin
      if Assigned(m_nQMD.Items[snSRVID]) then
      m_nQMD.Items[snSRVID].Init(pTbl.Items[0]);
     End;
End;
procedure CQweryClusters.InitAll;
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do Init(i);
End;
procedure CQweryClusters.Delete(snSRVID:Integer);
Begin
     if Assigned(m_nQMD.Items[snSRVID]) then
     Begin
      m_nQMD.Items[snSRVID].Destroy;
      m_nQMD.Items[snSRVID] := Nil;
      if m_nQMD.Count>=1 then m_nQMD.Count := m_nQMD.Count - 1;
     End;
End;
procedure CQweryClusters.DeleteAll;
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then Delete(i);
End;
procedure CQweryClusters.Run;
Var
     i : Integer;
Begin
     try
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].Run;
     except

     end;
End;
procedure CQweryClusters.HandQwery(snSRVID:Integer);
Begin
     if Assigned(m_nQMD.Items[snSRVID]) then m_nQMD.Items[snSRVID].HandQwery;
End;
procedure CQweryClusters.HandQweryAll;
Var
     i : Integer;
Begin
     for i:=0 to MAX_CLUSTER do
     if Assigned(m_nQMD.Items[i]) then m_nQMD.Items[i].HandQwery;
End;
end.
