unit knsl3ImportAbonInfo;

interface

uses Windows, utldynconnect, utldatabase, utltypes, utlconst, classes, Sysutils, Forms,
knsl3housegen, utlbox,knsl5config;

type
  TImportAbonInfo = class
  private
    FABOID       : integer;
    FPortID      : integer;
    pAbons       : SL3ABONS;
    pGroups      : SL3INITTAG;
    pVMIDs       : SL3VMETERTAGS;
    pL2Tag       : SL2INITITAG;
    mAbonSize    : integer;
    mGroupsSize  : integer;
    mVMIDsSize   : integer;
    mL2TagSize   : integer;
    mTotalSize   : integer;
    Stream       : TMemoryStream;
    FPHONE       : String;
    FTYPE        : Byte;
    FABONM       : String;
    Fdtm_sdtBegin  : TDateTime;
    Fdtm_sdtEnd    : TDateTime;
    Fdtm_sdtPeriod : TDateTime;
    function  ReadStructSizes: boolean;
    procedure ImportAbonStruct;
    procedure ImportGroupsStruct;
    procedure ImportVMIDsStruct;
    procedure ImportL2TagStruct;
    procedure ClearAllAbonInfo;
    procedure LinkL2L3Gr;
    procedure LinkL2L3GrSrv;
    procedure SaveL2TagStruct;
    procedure SaveGroupStruct;
    procedure SaveVMIDsStruct;
    procedure AddQweryServer;
    function  SetIndexVM(nIndex : Integer):Integer;
    function  GenIndexVM:Integer;
    procedure FreeAllIndexVM;
    function  SetIndexGr(nIndex : Integer):Integer;
    function  GenIndexGr:Integer;
    procedure FreeAllIndexGr;
    function  SetIndexMID(nIndex : Integer):Integer;
    function  GenIndexMID:Integer;
    function  GenIndexSvMID:Integer;
    procedure FreeAllIndexMID;
    procedure FreeIndexMID(nIndex : Integer);
  public
    procedure LoadFromFile(FilePath : string);
    procedure LoadFromFileSrv(FilePath : string);
  public
    property PABOID : integer read FABOID write FABOID;
    property PABONM : String  read FABONM write FABONM;
    property PPHONE : String  read FPHONE write FPHONE;
    property PTYPE  : Byte    read FTYPE  write FTYPE;
    property Pdtm_sdtBegin  : TDateTime read Fdtm_sdtBegin  write Fdtm_sdtBegin;
    property Pdtm_sdtEnd    : TDateTime read Fdtm_sdtEnd    write Fdtm_sdtEnd;
    property Pdtm_sdtPeriod : TDateTime read Fdtm_sdtPeriod write Fdtm_sdtPeriod;
  end;

implementation

procedure TImportAbonInfo.LoadFromFile(FilePath : string);

begin

   Stream := TMemoryStream.Create;
   Stream.LoadFromFile(FilePath);
   Stream.Position := 0;
   if ReadStructSizes then
   begin
     ImportAbonStruct;
     ImportGroupsStruct;
     ImportVMIDsStruct;
     ImportL2TagStruct;
     ClearAllAbonInfo;
     LinkL2L3Gr;
     SaveL2TagStruct;
     SaveGroupStruct;
     SaveVMIDsStruct;
     if m_nCF.QueryType=QWR_QWERY_SRV then
     Begin
      AddQweryServer;
      if pL2Tag.m_swAmMeter>0 then
      Begin
       if pAbons.Count>0 then
       Begin
        if pAbons.Items[0].M_NABONTYPE=1 then m_pDB.SetMeterType(PABOID,pL2Tag.m_sMeter[0].m_sbyPortID,MET_SS301F3) else
        if pAbons.Items[0].M_NABONTYPE=0 then m_pDB.SetMeterType(PABOID,pL2Tag.m_sMeter[0].m_sbyPortID,MET_MIRT1);
       End;
      End
     End;
   end;
   Stream.Free;
end;
procedure TImportAbonInfo.LoadFromFileSrv(FilePath : string);
begin
   Stream := TMemoryStream.Create;
   Stream.LoadFromFile(FilePath);
   Stream.Position := 0;
   if ReadStructSizes then
   begin
     ImportAbonStruct;
     ImportGroupsStruct;
     ImportVMIDsStruct;
     ImportL2TagStruct;
     ClearAllAbonInfo;
     LinkL2L3GrSrv;
     SaveL2TagStruct;
     SaveGroupStruct;
     SaveVMIDsStruct;
     AddQweryServer;
     if pL2Tag.m_swAmMeter>0 then
     m_pDB.SetMeterType(PABOID,pL2Tag.m_sMeter[0].m_sbyPortID,MET_SS301F3);
   end;
   Stream.Free;
end;
{
CLS_MGN      = 1;
     CLS_GRAPH48  = 4;
     CLS_DAY      = 8;
     CLS_MONT     = 9;
     CLS_EVNT     = 11;
     CLS_TIME     = 12;
     CLS_PNET     = 13;
}
procedure TImportAbonInfo.AddQweryServer;
Var
   pHG : CHouseGen;
   mHG : SHOUSEGEN;
Begin
   pHG := CHouseGen.Create;
    mHG.m_swABOID   := FABOID;
    mHG.m_sAbonName := FABONM;
    mHG.m_sdtBegin  := Fdtm_sdtBegin;
    mHG.m_sdtEnd    := Fdtm_sdtEnd;
    mHG.m_sdtPeriod := Fdtm_sdtPeriod;
    mHG.m_strClsEnable := ','+IntToStr(CLS_MGN)+','+IntToStr(CLS_DAY)+','+IntToStr(CLS_MONT)+','+IntToStr(CLS_GRAPH48)+',';
    pHG.GenQwerySrv(mHG);
    pHG.InitL3(mHG);
    pHG.InitTree(mHG);
   pHG.Destroy;
End;

function TImportAbonInfo.ReadStructSizes: boolean;
begin
   Stream.Read(mAbonSize, sizeof(integer));
   Stream.Read(mGroupsSize, sizeof(integer));
   Stream.Read(mVMIDsSize, sizeof(integer));
   Stream.Read(mL2TagSize, sizeof(integer));

   mTotalSize := 4 * sizeof(integer) + mAbonSize + mGroupsSize + mVMIDsSize + mL2TagSize;
   Result := true;

   if mTotalSize <= Stream.Size then
     Result := true
   else
     Result := false;
   
end;

procedure TImportAbonInfo.ImportAbonStruct;
var i : integer;
begin
   pAbons.Count := mAbonSize div sizeof(SL3ABON);
   SetLength(pAbons.Items, pAbons.Count);
   for i := 0 to pAbons.Count - 1 do
     Stream.Read(pAbons.Items[i], sizeof(SL3ABON));
end;

procedure TImportAbonInfo.ImportGroupsStruct;
var i : integer;
begin
   pGroups.Count := mGroupsSize div sizeof(SL3GROUPTAG);
   SetLength(pGroups.Items, pGroups.Count);
   for i := 0 to pGroups.Count - 1 do
     Stream.Read(pGroups.Items[i], sizeof(SL3GROUPTAG));
end;

procedure TImportAbonInfo.ImportVMIDsStruct;
var i : integer;
begin
   pVMIDs.Count := mVMIDsSize div sizeof(SL3VMETERTAG);
   SetLength(pVMIDs.Items, pVMIDs.Count);
   for i := 0 to pVMIDs.Count - 1 do
     Stream.Read(pVMIDs.Items[i], sizeof(SL3VMETERTAG));
end;

procedure TImportAbonInfo.ImportL2TagStruct;
var i : integer;
begin
   pL2Tag.m_swAmMeter := mL2TagSize div sizeof(SL2TAG);
   SetLength(pL2Tag.m_sMeter, pL2Tag.m_swAmMeter);
   for i := 0 to pL2Tag.m_swAmMeter do
     Stream.Read(pL2Tag.m_sMeter[i], sizeof(SL2TAG));
end;

procedure TImportAbonInfo.ClearAllAbonInfo;
begin
   FPortID := m_pDB.GetAbonPortID(FABOID);
   m_pDB.DelAbonTbl(FABOID, FPortID);
end;

procedure TImportAbonInfo.LinkL2L3GrSrv;
var i, j : integer;
begin
   for i := 0 to pVMIDs.Count - 1 do       //l2 & l3
   begin
     for j := 0 to pL2Tag.m_swAmMeter - 1 do
       if StrToInt(pL2Tag.m_sMeter[j].m_sddPHAddres) = pVMIDs.Items[i].m_swVMID then
       begin
         pVMIDs.Items[i].m_swMID := j;
         break;
       end;
     if j = pL2Tag.m_swAmMeter then
     pVMIDs.Items[i].m_swMID := $FFFF;
   end;

   for i := 0 to pVMIDs.Count - 1 do
   begin
                                         //l3 & groups
     for j := 0 to pGroups.Count do
       if pGroups.Items[j].m_sbyGroupID = pVMIDs.Items[i].m_sbyGroupID then
       begin
         pVMIDs.Items[i].m_sbyGroupID := j;
         break;
       end;
     if j = pGroups.Count then pVMIDs.Items[i].m_sbyGroupID := $FF;
   end;
end;
procedure TImportAbonInfo.LinkL2L3Gr;
var i, j : integer;
begin
   for i := 0 to pVMIDs.Count - 1 do       //l2 & l3
   begin
     for j := 0 to pL2Tag.m_swAmMeter - 1 do
       if pL2Tag.m_sMeter[j].m_swMID = pVMIDs.Items[i].m_swMID then
       begin
         pVMIDs.Items[i].m_swMID := j;
         break;
       end;
     if j = pL2Tag.m_swAmMeter then pVMIDs.Items[i].m_swMID := $FFFF;
   end;

   for i := 0 to pVMIDs.Count - 1 do
   begin
                                         //l3 & groups
     for j := 0 to pGroups.Count do
       if pGroups.Items[j].m_sbyGroupID = pVMIDs.Items[i].m_sbyGroupID then
       begin
         pVMIDs.Items[i].m_sbyGroupID := j;
         break;
       end;
     if j = pGroups.Count then pVMIDs.Items[i].m_sbyGroupID := $FF;
   end;
end;

procedure TImportAbonInfo.SaveL2TagStruct;
var i        : integer;
    pTbl     : SL2INITITAG;
begin
   FreeAllIndexMID;
   if m_pDB.GetMetersAll(pTbl)=True then
   for i:=0 to pTbl.m_swAmMeter-1 do
     SetIndexMID(pTbl.m_sMeter[i].m_swMID);
   for i := 0 to pL2Tag.m_swAmMeter - 1 do
   begin
     pL2Tag.m_sMeter[i].m_sbyPortID := FPortID;
     pL2Tag.m_sMeter[i].m_swMID := GenIndexMID;
     if FTYPE=1 then pL2Tag.m_sMeter[i].m_sPhone := FPHONE;
     SetIndexMID(pL2Tag.m_sMeter[i].m_swMID);
     m_pDB.AddMeterTable(pL2Tag.m_sMeter[i]);
     m_pDB.LoadCommand(pL2Tag.m_sMeter[i].m_swMID,pL2Tag.m_sMeter[i].m_sbyType);
   end;
end;

procedure TImportAbonInfo.SaveGroupStruct;
var i         : integer;
    pTableGr  : SL3INITTAG;
begin
   FreeAllIndexGr;
   if m_pDB.GetGroupsTable(pTableGr)=True then
     for i:=0 to pTableGr.Count-1 do
       SetIndexGr(pTableGr.Items[i].m_sbyGroupID);

   for i := 0 to pGroups.Count - 1 do
   begin
     pGroups.Items[i].m_swABOID := FABOID;
     pGroups.Items[i].m_sbyGroupID := GenIndexGr;
     SetIndexGr(pGroups.Items[i].m_sbyGroupID);
     m_pDB.AddGroupTable(pGroups.Items[i]);
   end;
end;

procedure TImportAbonInfo.SaveVMIDsStruct;
var i             : integer;
    m_sTbl        : SL3GROUPTAG;
begin
   FreeAllIndexVM;
   if m_pDB.GetVMetersTable(-1,m_sTbl)=True then
     for i := 0 to m_sTbl.m_swAmVMeter-1 do
       SetIndexVM(m_sTbl.Item.Items[i].m_swVMID);
   for i := 0 to pVMIDs.Count - 1 do
   begin
     if (pVMIDs.Items[i].m_swMID = $FFFF) or (pVMIDs.Items[i].m_sbyGroupID = $FF) then
       continue;
     if (pVMIDs.Items[i].m_swMID >= pL2Tag.m_swAmMeter) or (pVMIDs.Items[i].m_sbyGroupID >= pGroups.Count) then
       continue;
     pVMIDs.Items[i].m_swMID := pL2Tag.m_sMeter[pVMIDs.Items[i].m_swMID].m_swMID;
     pVMIDs.Items[i].m_sbyPortID := FPortID;
     pVMIDs.Items[i].m_sbyGroupID := pGroups.Items[pVMIDs.Items[i].m_sbyGroupID].m_sbyGroupID;
     pVMIDs.Items[i].m_swVMID := GenIndexVM;
     SetIndexVM(pVMIDs.Items[i].m_swVMID);
     m_pDB.AddVMeterTable(pVMIDs.Items[i]);
     m_pDB.InsertVParams(pVMIDs.Items[i].m_sbyType, pVMIDs.Items[i].m_swVMID);
   end;
end;

function  TImportAbonInfo.SetIndexVM(nIndex : Integer):Integer;
begin
   m_blVMeterIndex[nIndex] := False;
   Result := nIndex;
end;

function  TImportAbonInfo.GenIndexVM:Integer;
Var
   i : Integer;
Begin
   for i:=0 to MAX_VMETER do
     if m_blVMeterIndex[i]=True then
     Begin
       Result := i;
       exit;
     End;
   Result := -1;
end;

procedure TImportAbonInfo.FreeAllIndexVM;
Var
   i : Integer;
Begin
   for i:=0 to MAX_VMETER do
     m_blVMeterIndex[i] := True;
end;

function  TImportAbonInfo.SetIndexGr(nIndex : Integer):Integer;
begin
   m_blGroupIndex[nIndex] := False;
   Result := nIndex;
end;

function  TImportAbonInfo.GenIndexGr:Integer;
Var
   i : Integer;
Begin
   for i:=0 to MAX_GROUP do
     if m_blGroupIndex[i]=True then
     Begin
      Result := i;
      exit;
     End;
   Result := -1;
end;

procedure TImportAbonInfo.FreeAllIndexGr;
Var
   i : Integer;
Begin
   for i:=0 to MAX_GROUP do
      m_blGroupIndex[i] := True;
end;

function  TImportAbonInfo.SetIndexMID(nIndex : Integer):Integer;
begin
   m_blMeterIndex[nIndex] := False;
   Result := nIndex;
end;

function  TImportAbonInfo.GenIndexMID:Integer;
Var
   i : Integer;
Begin
   for i:=0 to MAX_METER do
     if m_blMeterIndex[i]=True then
     Begin
       Result := i;
       exit;
     End;
   Result := -1;
end;

function  TImportAbonInfo.GenIndexSvMID:Integer;
begin
   Result := SetIndexMID(GenIndexMID);
end;

procedure TImportAbonInfo.FreeAllIndexMID;
Var
   i : Integer;
Begin
   for i:=0 to MAX_METER do
     m_blMeterIndex[i] := True;
end;

procedure TImportAbonInfo.FreeIndexMID(nIndex : Integer);
begin
   m_blMeterIndex[nIndex] := True;
end;

end.
