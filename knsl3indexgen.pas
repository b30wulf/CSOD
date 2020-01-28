unit knsl3indexgen;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
utldatabase,knsl5tracer;
type
    CIndexGen = class
    private
     m_pIndexBuff : PBooleanArray;
     m_nMaxIndex  : Integer;
     function SetIndex(nIndex : Integer):Integer;
     Procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
    public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     destructor  Destroy;override;
     Procedure Refresh;virtual;
     function GenIndex:Integer;
     function GenIndexSv:Integer;
    End;
    CGenL1Index = class(CIndexGen)
     public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     Procedure Refresh;override;
    End;
    CGenL2Index = class(CIndexGen)
     public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     Procedure Refresh;override;
    End;
    CGenL3Index = class(CIndexGen)
     public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     Procedure Refresh;override;
    End;
    CGenGroupIndex = class(CIndexGen)
     public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     Procedure Refresh;override;
    End;
    CGenQSIndex = class(CIndexGen)
     public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     Procedure Refresh;override;
    End;
    CGenQCIndex = class(CIndexGen)
     public
     constructor Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
     Procedure Refresh;override;
    End;


implementation
constructor CIndexGen.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
    m_pIndexBuff := pIndexBuff;
    m_nMaxIndex  := nMaxIndex;
End;
destructor  CIndexGen.Destroy;
Begin
    Inherited;
End;
Procedure CIndexGen.Refresh;
Begin
End;
//Index Generator
function  CIndexGen.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to m_nMaxIndex do
    if m_pIndexBuff[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function CIndexGen.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CIndexGen.SetIndex(nIndex : Integer):Integer;
Begin
    m_pIndexBuff[nIndex] := False;
    Result := nIndex;
End;
Procedure CIndexGen.FreeIndex(nIndex : Integer);
Begin
    m_pIndexBuff[nIndex] := True;
End;
Procedure CIndexGen.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to m_nMaxIndex do FreeIndex(i);
End;
//Генератор L1
constructor CGenL1Index.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
     inherited Create(pIndexBuff,nMaxIndex);
end;
Procedure CGenL1Index.Refresh;
Var
    pTbl : SL1INITITAG;
    i    : Integer;
Begin
    FreeAllIndex;
    if m_pDB.GetL1Table(pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_sbyPortID);
End;
//Генератор L2
constructor CGenL2Index.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
     inherited Create(pIndexBuff,nMaxIndex);
end;
Procedure CGenL2Index.Refresh;
Var
    pTbl : SL2INITITAG;
    i    : Integer;
Begin
    FreeAllIndex;
    if m_pDB.GetMetersAll(pTbl)=True then for i:=0 to pTbl.m_swAmMeter-1 do SetIndex(pTbl.m_sMeter[i].m_swMID);
end;
//Генератор L3
constructor CGenL3Index.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
     inherited Create(pIndexBuff,nMaxIndex);
end;
Procedure CGenL3Index.Refresh;
Var
    m_sTbl : SL3GROUPTAG;
    i      : Integer;
Begin
    FreeAllIndex;
    if m_pDB.GetVMetersTable(-1,m_sTbl)=True then for i:=0 to m_sTbl.m_swAmVMeter-1 do SetIndex(m_sTbl.Item.Items[i].m_swVMID);
End;      //CGenQSIndex
//Генератор Group
constructor CGenGroupIndex.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
    inherited Create(pIndexBuff,nMaxIndex);
end;
Procedure CGenGroupIndex.Refresh;
Var
    pTbl : SL3INITTAG;
    i    : Integer;
Begin
    FreeAllIndex;
    if m_pDB.GetGroupsTable(pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_sbyGroupID);
End;
//Генератор Сервера опроса
constructor CGenQSIndex.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
    inherited Create(pIndexBuff,nMaxIndex);
end;
Procedure CGenQSIndex.Refresh;
Var
    pTbl : SQWERYSRVS;
    i    : Integer;
Begin
    FreeAllIndex;
    if m_pDB.GetQwerySRVTable(-1,-1,pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_snSRVID);
End;
//Генератор Сервера опроса(ячейки)
constructor CGenQCIndex.Create(pIndexBuff:PBooleanArray;nMaxIndex:Integer);
Begin
    inherited Create(pIndexBuff,nMaxIndex);
end;
Procedure CGenQCIndex.Refresh;
Var
    pTbl:SQWERYVMS;
    i    : Integer;
Begin
    FreeAllIndex;
    //function CDBase.GetQweryVMTable(snSRVID,snCLID:Integer;var pTable:SQWERYVMS):Boolean;
    if m_pDB.GetQweryVMTable(-1,-1,pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_snCLID);
End;
end.
