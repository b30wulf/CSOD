unit knsl3jointable;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,utldatabase,knsl3datamatrix;
type

    SQWCLSS = packed record
     Count : Integer;
     Items : array of Integer;
    End;
    PSQWCLSS =^ SQWCLSS;
    SQWGRPS = packed record
     Count : Integer;
     Items : array of Integer;
    End;
    PSQWGRPS =^ SQWGRPS;
    SQWABNS = packed record
     Count : Integer;
     Items : array of Integer;
    End;
    //PSQWABNS = ^SQWABNS;

    //PSQINVMX =^ SQINVMX;
    //SQINVMX = packed record
    // Count : Integer;
    // Items : array[0..MAX_ABON] of Integer;
    //End;

    CJoinTable = class
    protected
     m_snABOID : Integer;
     m_snGID   : Integer;
     m_snVID   : Integer;
     m_pTbl    : SL3INITTAG1;
     m_pDMX    : PCDataMatrix;
     m_pGTbl   : PSL3GROUPTAG;
     procedure FindJoins(snGID:Integer;pTbl:SL3INITTAG1;var strExpr:String);
     procedure AddJoins(pTbl:SL3INITTAG1);
     procedure AddGroup(nLEV:Integer;pTbl:SL3INITTAG1);
     procedure AddGroupBuffer(nGID:Integer);
     function  FindTokenGR(var str:String;var nVMID:Integer):Boolean;
     function  FindJoin(var pTbl:SL3INITTAG1;var nGID:Integer;var strExpr:String;nVMID:Integer):Boolean;
     function  GetIDFromGID(var pTbl:SL3INITTAG1;nGID:Integer):Integer;
     function  GetGidFromVMID(var pTbl:SL3INITTAG1;nVMID:Integer):Integer;
     function  GetVmidFromGID(var pTbl:SL3INITTAG1;nGID,nVMID:Integer):Integer;
     function  IsTrueType(var pTbl:SL3INITTAG1;nVMID:Integer):Boolean;
     function  AddBuffer(nVMID:Integer):Boolean;
     function  AddFBuffer(nVMID:Integer):Boolean;
     function  AddBufferEx(nVMID:Integer):Boolean;
     procedure GetJoins;
     procedure InitGrJoin(nABOID,nLev,nParam:Integer);
     function  GetGroup(nVMID:Integer;var lGID:Integer):Boolean;
     function  FindGrJoin(nVMID:Integer):Boolean;
     function  GetLMX(nVMID,nCMDID:Integer):Boolean;
     function  GetGVmid(nVMID,nCMDID:Integer):Integer;

    public
     m_pQSMD   : SQWCLSS;
     m_pQGSMD  : SQWGRPS;
     m_pQABMD  : SQWABNS;
     m_snGLVID : Integer;
     constructor Create(pGTbl:PSL3GROUPTAG;p0,p1:Boolean);overload;
     constructor Create;overload;
     constructor Create(pDMX:PCDataMatrix);overload;
     constructor Create(nABOID,nGID:Integer);overload;
     constructor Create(nABOID,nLev,nParam:Integer);overload;
     function   GetGroupJoin(nVMID:Integer):Boolean;
     function   GetVMID(nGID:Integer):Integer;
     function   GetString:String;
     function   GetTopRMatrix(nVMID,nCMDID:Integer;blCheck:Boolean):Boolean;
     function   GetTopLMatrix(nVMID,nCMDID:Integer):Boolean;
     procedure  FreeLMX;
     function   AddTopLMatrix(nVMID,nCMDID:Integer):Boolean;
     function   GetHiJoin(nVMID:Integer):Boolean;
     procedure  FreeHiJoin;
     function   GetLoJoin(nVMID:Integer):Boolean;
     destructor Destroy;override;
    End;
    PCJoinTable =^ CJoinTable;
implementation
constructor CJoinTable.Create;
Var
    pTable : SL3ABONS;
    i : Integer;
Begin
    SetLength(m_pQABMD.Items,MAX_ABON);
    m_pQABMD.Count := 0;
    for i:=0 to MAX_ABON do m_pQABMD.Items[i] := -1;
    if m_pDB.GetAbonsTableNS(pTable)=True then
    Begin
     m_pQABMD.Count := pTable.Count;
     for i:=0 to pTable.Count-1 do m_pQABMD.Items[i]:=pTable.Items[i].m_swABOID;
    End;
End;
constructor CJoinTable.Create(pGTbl:PSL3GROUPTAG;p0,p1:Boolean);
Var
    i : Integer;
Begin
    m_pGTbl := pGTbl;
    SetLength(m_pQSMD.Items,MAX_VMETER);
    FreeHiJoin;
End;
constructor CJoinTable.Create(pDMX:PCDataMatrix);
Begin
    SetLength(m_pQSMD.Items,MAX_VMCLUST);
    m_pDMX := pDMX;
End;
constructor CJoinTable.Create(nABOID,nGID:Integer);
Begin
     SetLength(m_pQSMD.Items,MAX_VMCLUST);
     m_snABOID := nABOID;
     m_snGID   := nGID;
     GetJoins;
End;
constructor CJoinTable.Create(nABOID,nLev,nParam:Integer);
Var
     pTbl  : SL3INITTAG1;
     i,nID : Integer;
Begin
     SetLength(m_pQGSMD.Items,MAX_GROUP);
     if nParam=-1 then
     Begin
      m_pQGSMD.Count := 0;
      m_snABOID := nABOID;
      for i:=0 to MAX_GROUP-1 do m_pQGSMD.Items[i] := -1;
      if m_pDB.GetGroupsAbonTable(m_snABOID,pTbl)=True then AddGroup(nLev,pTbl);
     End else
     if nParam<>-1 then InitGrJoin(nABOID,nLev,nParam);
End;
destructor CJoinTable.Destroy;
Begin
     SetLength(m_pQGSMD.Items,0);
     SetLength(m_pQABMD.Items,0);
     SetLength(m_pQSMD.Items,0);
End;
procedure CJoinTable.FreeHiJoin;
Var
     i : Integer;
Begin
     m_pQSMD.Count := 0;
     for i:=0 to MAX_VMETER-1 do m_pQSMD.Items[i] := -1;
End;
procedure CJoinTable.FreeLMX;
Var
     i : Integer;
Begin
     SetLength(m_pQSMD.Items,MAX_VMETER);
     m_pQSMD.Count := 0;
     for i:=0 to MAX_VMETER-1 do m_pQSMD.Items[i] := -1;
End;
function CJoinTable.AddTopLMatrix(nVMID,nCMDID:Integer):Boolean;
Begin
      AddFBuffer(nVMID);
      Result := GetLMX(nVMID,nCMDID);
End;
function CJoinTable.GetTopLMatrix(nVMID,nCMDID:Integer):Boolean;
Var
     i : Integer;
Begin
     m_pQSMD.Count := 0;
     for i:=0 to MAX_VMCLUST-1 do m_pQSMD.Items[i] := -1;
     Result := GetLMX(nVMID,nCMDID);
End;
function CJoinTable.GetLMX(nVMID,nCMDID:Integer):Boolean;
Var
     i : Integer;
     strF : String;
Begin
     Result := False;
     if not Assigned(m_pDMX) then exit;
     strF := 'v'+IntToStr(nVMID)+'_';
     for i:=0 to MAX_VMETER-1 do
     Begin
      if (Assigned(m_pDMX.m_nDMX[i,nCMDID]))and(nVMID<>i) then
      Begin
       if pos(strF,m_pDMX.m_nDMX[i,nCMDID].Express)<>0 then
       Begin
        AddFBuffer(i);
        Result := True;
        GetLMX(i,nCMDID);
       End;
      End;
     End;
End;
function  CJoinTable.GetTopRMatrix(nVMID,nCMDID:Integer;blCheck:Boolean):Boolean;
Var
     i,lVMID : Integer;
     str : String;
Begin
     Result := False;
     if not Assigned(m_pDMX) then exit;
     if GetTopLMatrix(nVMID,nCMDID)=True then
     Begin
      with m_pQSMD do for i:=0 to m_pQSMD.Count-1 do
      Begin
       str := m_pDMX.m_nDMX[Items[i],nCMDID].Express;
       while FindTokenGR(str,lVMID) do
       if blCheck=False then AddBuffer(lVMID) else
       if (blCheck=True)and(lVMID<>nVMID) then AddBuffer(lVMID);
      End;
      Result := True;
     End;
End;
function CJoinTable.GetGVmid(nVMID,nCMDID:Integer):Integer;
Var
     i : Integer;
     strF : String;
Begin
     Result := -1;
     if not Assigned(m_pDMX) then exit;
     strF := 'v'+IntToStr(nVMID)+'_';
     for i:=0 to MAX_VMETER-1 do
     Begin
      if Assigned(m_pDMX.m_nDMX[i,nCMDID]) then
      Begin
       if (pos(strF,m_pDMX.m_nDMX[i,nCMDID].Express)<>0)and(i<>nVMID) then
       Begin
        Result := i;
        exit;
       End;
      End;
     End;
End;
function  CJoinTable.GetHiJoin(nVMID:Integer):Boolean;
Var
     i,j  : Integer;
     strF : String;
     pP   : PSL3PARAMS;
     pVM  : PSL3VMETERTAG;
Begin
     Result := False;
     strF := 'v'+IntToStr(nVMID)+'_';
     for i:=0 to m_pGTbl.Item.Count -1 do
     Begin
      pP  := @m_pGTbl.Item.Items[i].Item.Items[0];
      pVM := @m_pGTbl.Item.Items[i];
      if ((pVM.m_sbyType=MET_SUMM)or(pVM.m_sbyType=MET_GSUMM)) then
      if (pVM.m_swVMID<>nVMID) then
      if (pos(strF,pP.m_sParamExpress)<>0) then
      Begin
       AddBufferEx(pP.m_swVMID);
       Result := True;
       GetHiJoin(pP.m_swVMID);
      End;
     End;
End;
function  CJoinTable.GetLoJoin(nVMID:Integer):Boolean;
Var
     i,j,lVMID : Integer;
     strF : String;
     pP   : PSL3PARAMS;
     pVM  : PSL3VMETERTAG;
Begin
     Result := False;
     //strF := 'v'+IntToStr(nVMID)+'_';
     for i:=0 to m_pGTbl.Item.Count -1 do
     Begin
      pP  := @m_pGTbl.Item.Items[i].Item.Items[0];
      pVM := @m_pGTbl.Item.Items[i];
      if ((pVM.m_sbyType=MET_SUMM)or(pVM.m_sbyType=MET_GSUMM)) then
      if (pVM.m_swVMID=nVMID) then
      Begin
       strF := pP.m_sParamExpress;
       while FindTokenGR(strF,lVMID) do
       AddFBuffer(lVMID);
      End;
     End;
End;
procedure CJoinTable.InitGrJoin(nABOID,nLev,nParam:Integer);
Var
     i : Integer;
Begin
     m_pQGSMD.Count := 0;
     m_snABOID := nABOID;
     for i:=0 to MAX_GROUP-1 do m_pQGSMD.Items[i] := -1;
     m_pDB.GetGroupsAbonTable(m_snABOID,m_pTbl);
End;
function CJoinTable.GetGroupJoin(nVMID:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     m_pQGSMD.Count := 0;
     for i:=0 to MAX_GROUP-1 do m_pQGSMD.Items[i] := -1;
     Result := FindGrJoin(nVMID);
End;
function CJoinTable.FindGrJoin(nVMID:Integer):Boolean;
Var
     lGID : Integer;
Begin
     Result := False;
     if GetGroup(nVMID,lGID)=True then
     Begin
      AddGroupBuffer(lGID);
      Result := True;
     End;
End;
function CJoinTable.GetGroup(nVMID:Integer;var lGID:Integer):Boolean;
Var
     lVMID,nID : Integer;
     strExpr : String;
Begin
     Result  := False;
     lGID    := GetGidFromVMID(m_pTbl,nVMID); if lGID =-1 then exit;
     lVMID   := GetVmidFromGID(m_pTbl,lGID,nVMID);if lVMID=-1 then exit;
     FindGrJoin(lVMID);
     Result := True;
End;
procedure CJoinTable.GetJoins;
Var
     pTbl  : SL3INITTAG1;
     i,nID : Integer;
Begin
     m_pQSMD.Count := 0;
     for i:=0 to MAX_VMCLUST-1 do m_pQSMD.Items[i] := -1;
     if m_pDB.GetGroupsAbonTable(m_snABOID,pTbl)=True then
     Begin
      nID := GetIDFromGID(pTbl,m_snGID);
      m_snGLVID := pTbl.Items[nID].M_NGROUPLV;
      if m_snGLVID<>0 then FindJoins(m_snGID,pTbl,pTbl.Items[nID].m_sGroupExpress) else
      if m_snGLVID=0 then AddJoins(pTbl);
     End;
End;
procedure CJoinTable.FindJoins(snGID:Integer;pTbl:SL3INITTAG1;var strExpr:String);
Var
     nVMID,nType : Integer;
     strNew : String;
Begin
     while FindTokenGR(strExpr,nVMID) do
     Begin
      if IsTrueType(pTbl,nVMID)=True then AddBuffer(nVMID);
      if FindJoin(pTbl,snGID,strNew,nVMID)=True then
      Begin
       FindJoins(snGID,pTbl,strNew);
      End;
     End;
End;
function CJoinTable.FindJoin(var pTbl:SL3INITTAG1;var nGID:Integer;var strExpr:String;nVMID:Integer):Boolean;
Var
     i,nID : Integer;
Begin
     Result := False;
     with pTbl.Items[0].Item do
     for i := 0 to Count-1 do
     Begin
      if Items[i].m_swVMID=nVMID then
      Begin
       if nGID<>Items[i].m_sbyGroupID then
       Begin
        Result  := True;
        nGID    := Items[i].m_sbyGroupID;
        nID     := GetIDFromGID(pTbl,nGID);
        strExpr := pTbl.Items[nID].m_sGroupExpress;
        if pTbl.Items[nID].M_NGROUPLV=0 then Result := False;
        exit;
       End;
      End;
    End;
End;
procedure CJoinTable.AddJoins(pTbl:SL3INITTAG1);
Var
     i : Integer;
Begin
     with pTbl.Items[0].Item do
     for i:=0 to Count-1 do
     Begin
      if Items[i].m_sbyGroupID=m_snGID then
      AddBuffer(Items[i].m_swVMID);
     End;
End;
procedure CJoinTable.AddGroup(nLEV:Integer;pTbl:SL3INITTAG1);
Var
     i : Integer;
Begin
     for i:=0 to pTbl.Count-1 do
     Begin
      if nLEV=-1 then AddGroupBuffer(pTbl.Items[i].m_sbyGroupID) else
      if nLEV=pTbl.Items[i].M_NGROUPLV then AddGroupBuffer(pTbl.Items[i].m_sbyGroupID);
     End;
End;
function CJoinTable.IsTrueType(var pTbl:SL3INITTAG1;nVMID:Integer):Boolean;
Var
    i : Integer;
Begin
    Result := True;
    with pTbl.Items[0].Item do
    for i := 0 to Count-1 do
    Begin
     if Items[i].m_swVMID=nVMID then
     if ((Items[i].m_sbyType=MET_SUMM)or(Items[i].m_sbyType=MET_GSUMM)) then
     Begin
      Result := False;
      exit;
     End;
    End;
End;
function CJoinTable.GetIDFromGID(var pTbl:SL3INITTAG1;nGID:Integer):Integer;
Var
     i : Integer;
Begin
     Result := 0;
     for i:=0 to pTbl.Count-1 do
     Begin
      if pTbl.Items[i].m_sbyGroupID=nGID then
      Begin
       Result := i;
       exit;
      End;
     End;
End;
function CJoinTable.GetGidFromVMID(var pTbl:SL3INITTAG1;nVMID:Integer):Integer;
Var
    i : Integer;
    strF : String;
Begin
    Result := -1;
    for i := 0 to pTbl.Count-1 do
    Begin
     if pTbl.Items[i].M_NGROUPLV<>0 then
     Begin
      strF := 'v'+IntToStr(nVMID)+'_P';
      if pos(strF,pTbl.Items[i].m_sGroupExpress)<>0 then
      Begin
       Result := pTbl.Items[i].m_sbyGroupID;
       exit;
      End;
     End;
    End;
End;
function CJoinTable.GetVmidFromGID(var pTbl:SL3INITTAG1;nGID,nVMID:Integer):Integer;
Var
    i : Integer;
Begin
    Result := -1;
    with pTbl.Items[0].Item do
    for i := 0 to Count-1 do
    Begin
     if ((Items[i].m_sbyType=MET_SUMM)or(Items[i].m_sbyType=MET_GSUMM)) then
     Begin
      if (Items[i].m_sbyGroupID=nGID)and(Items[i].m_swVMID<>nVMID) then
      Begin
       Result := Items[i].m_swVMID;
       exit;
      End;
     End;
    End;
End;
function CJoinTable.GetVMID(nGID:Integer):Integer;
Begin
    Result := GetVmidFromGID(m_pTbl,nGID,-1);
End;
function CJoinTable.FindTokenGR(var str:String;var nVMID:Integer):Boolean;
Var
     res : Boolean;
     sV  : String;
     i,j : Integer;
Begin
     Result := False;
      //Find VMID
     i := Pos('v',str)+1;
     if i=1 then exit;
     if i>2 then Begin Delete(str,1,i-2);i:=Pos('v',str)+1;End;
     j := Pos('_',str);
     if j<=i then Begin {pTN.blError:=True;}exit;End;
     sV := Copy(str,i,j-i);
     Delete(str,1,(j+2)-i);
     nVMID := StrToInt(sV);
     Result := True;
End;
function  CJoinTable.GetString:String;
Var
     i : Integer;
Begin
     Result := '';
     if m_pQSMD.Count<>0 then
     Begin
      for i:=0 to m_pQSMD.Count-2 do
      Result := Result + IntToStr(m_pQSMD.Items[i])+',';
      Result := Result + IntToStr(m_pQSMD.Items[m_pQSMD.Count-1])
     End;
End;
function  CJoinTable.AddBuffer(nVMID:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     for i:=0 to MAX_VMCLUST do
     Begin
      if (m_pQSMD.Items[i]=nVMID) then exit;
      if (m_pQSMD.Items[i]=-1) then
      Begin
       m_pQSMD.Items[i]:=nVMID;
       m_pQSMD.Count := m_pQSMD.Count + 1;
       Result := True;
       exit;
      End;
     End;
End;
function  CJoinTable.AddFBuffer(nVMID:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     for i:=0 to MAX_VMETER do
     Begin
      if (m_pQSMD.Items[i]=nVMID) then exit;
      if (m_pQSMD.Items[i]=-1) then
      Begin
       m_pQSMD.Items[i]:=nVMID;
       m_pQSMD.Count := m_pQSMD.Count + 1;
       Result := True;
       exit;
      End;
     End;
End;
function  CJoinTable.AddBufferEx(nVMID:Integer):Boolean;
Var
     i : Integer;
Begin
     Result := False;
     for i:=0 to MAX_VMETER do
     Begin
      //if (m_pQSMD.Items[i]=nVMID) then exit;
      if (m_pQSMD.Items[i]=-1) then
      Begin
       m_pQSMD.Items[i]:=nVMID;
       m_pQSMD.Count := m_pQSMD.Count + 1;
       Result := True;
       exit;
      End;
     End;
End;
procedure CJoinTable.AddGroupBuffer(nGID:Integer);
Var
     i : Integer;
Begin
     for i:=0 to MAX_GROUP do
     Begin
      if (m_pQGSMD.Items[i]=nGID) then exit;
      if (m_pQGSMD.Items[i]=-1) then
      Begin
       m_pQGSMD.Items[i]:=nGID;
       m_pQGSMD.Count   := m_pQGSMD.Count + 1;
       exit;
      End;
     End;
End;

end.
