unit knsl3AddrUnit;

interface

uses StdCtrls, Windows, Forms, Classes, SysUtils, utldatabase, utlbox, utltypes,
     utlconst,AdvPanel;

type

  CAbonAddressClass = class
  private
    mRIDAbon        : Integer;
    mDIDAbon        : Integer;
    mTIDAbon        : Integer;
    mTPIDAbon       : Integer;
    mSIDAbon        : Integer;
    
    mRIDTree        : Integer;
    mDIDTree        : Integer;
    mTIDTree        : Integer;
    mTPIDTree        : Integer;
    mSIDTree        : Integer;

    mTtlRegInfo     : SL3REGIONS;
    mTtlDepInfo     : SL3DEPARTAMENTS;
    mTtlTwnInfo     : SL3TOWNS;
    mTtlTPInfo      : SL3TPS;
    mTtlStrInfo     : SL3STREETS;

    mTreeRegInfo    : SL3REGIONS;
    mTreeDepInfo    : SL3DEPARTAMENTS;
    mTreeTwnInfo    : SL3TOWNS;
    mTreeTPInfo     : SL3TPS;
    mTreeStrInfo    : SL3STREETS;

    mIsPanelDraw    : boolean;

    procedure LoadAbonReg;
    procedure LoadAbonDep;
    procedure LoadAbonTown;
    procedure LoadAbonTP;
    procedure LoadAbonStreet;

    procedure LoadTreeReg;
    procedure LoadTreeDep;
    procedure LoadTreeTown;
    procedure LoadTreeTP;
    procedure LoadTreeStreet;

    procedure GetAbonIndexes(ABOID : integer);

    function  GetNewUniqRID: integer;
    function  GetNewUniqDID: integer;
    function  GetNewUniqTID: integer;
    function  GetNewUniqTPID: integer;    
    function  GetNewUniqSID: integer;
    function  FindRIDItem(ID: integer; var pTable: SL3REGIONS): integer;
    function  FindDIDItem(ID: integer; var pTable: SL3DEPARTAMENTS): integer;
    function  FindTIDItem(ID: integer; var pTable: SL3TOWNS): integer;
    function  FindTPIDItem(ID: integer; var pTable: SL3TPS): integer;
    function  FindSIDItem(ID: integer; var pTable: SL3STREETS): integer;
    procedure ResizePanel;
    function GetMinFilterVal: int64;
    function GetMaxFilterVal: int64;
    procedure InitUknownRegion;
  public
    mAbonRIDCB : ^TComboBox;
    mAbonDIDCB : ^TComboBox;
    mAbonTIDCB : ^TComboBox;
    mAbonTPIDCB : ^TComboBox;
    mAbonSIDCB : ^TComboBox;
    mTreeRIDCB : ^TComboBox;
    mTreeDIDCB : ^TComboBox;
    mTreeTIDCB : ^TComboBox;
    mTreeTPIDCB : ^TComboBox;
    mTreeSIDCB : ^TComboBox;
    mTreeAddr  : ^TAdvPanel;
    KodSys     : ^TEdit;

    mItemRIDAbon    : Integer;
    mItemDIDAbon    : Integer;
    mItemTIDAbon    : Integer;
    mItemTPIDAbon   : Integer;
    mItemSIDAbon    : Integer;

    procedure Init;
    procedure InitComboBox;
    procedure InitTreeCB;

    procedure LoadAbonCB(ABOID: integer); overload;
    procedure LoadAbonFromID(pID:CTreeIndex);
    procedure LoadAbonCB; overload;

    function  GetABONAdrID : int64;

    function  GetAbonAddr : CTreeIndex;

    procedure AddNewRegion;
    procedure AddNewDepartament;
    procedure AddNewTown;
    procedure AddNewTP;
    procedure AddNewStreet;


    procedure DelRegion;
    procedure DelDepartament;
    procedure DelTown;
    procedure DelTP;
    procedure DelStreet;
    procedure DelStreet_N;


    procedure DelRegionAbon;
    procedure DelDepartamentAbon;
    procedure DelTownAbon;
    procedure DelTPAbon;
    procedure DelStreetAbon;

    procedure ChangeARegion;
    procedure ChangeADepartament;
    procedure ChangeATown;
    procedure ChangeATP;
    procedure ChangeAStreet;

    procedure ChangeTRegion;
    procedure ChangeTDepartament;
    procedure ChangeTTown;
    procedure ChangeTStreet;

    procedure SetPanelUnvisible;
    procedure SetPanelVisible;

    function GetRegTable(var pTable:SL3REGIONS): boolean;
    function GetRegionID: integer;
    function GetRegItemInd: integer;

    procedure PlaceAbonToUnknowReg(RID, DID, TID, SID: integer);
    procedure DeleteAbons(RID, DID, TID, SID: integer);
    procedure DeleteAbons_N(RID, DID, TID, SID: integer);
    procedure DeleteAbons_TP_N(RID, DID, TID, TPID, SID: integer);
  public
  end;
var AbonAddress : CAbonAddressClass = nil;



implementation

procedure CAbonAddressClass.Init;
begin
   mRIDAbon := 0;
   mDIDAbon := 0;
   mTIDAbon := 0;
   mTPIDAbon := 0;
   mSIDAbon := 0;
end;

procedure CAbonAddressClass.InitComboBox;
begin
   mRIDAbon  := 0;
   mDIDAbon  := 0;
   mTIDAbon  := 0;
   mTPIDAbon := 0;
   mSIDAbon  := 0;
   LoadAbonCB;
end;

procedure CAbonAddressClass.InitTreeCB;
begin
   InitUknownRegion;
   mRIDTree  := -1;
   mDIDTree  := -1;
   mTIDTree  := -1;
   mTPIDTree := -1;
   mSIDTree  := -1;
   LoadTreeReg;
   LoadTreeDep;
   LoadTreeTown;
   LoadTreeTP;
   LoadTreeStreet;
   ResizePanel;
end;

procedure CAbonAddressClass.LoadAbonFromID(pID:CTreeIndex);
Begin
    mItemRIDAbon := -1;
    mItemDIDAbon := -1;
    mItemTIDAbon := -1;
    mItemSIDAbon := -1;
    mSIDAbon := pID.PSTR;
    mTPIDAbon:= pID.PTPS;
    mTIDAbon := pID.PTWN;
    mDIDAbon := pID.PRYD;
    mRIDAbon := pID.PRID;
    LoadAbonReg;
    LoadAbonDep;
    LoadAbonTown;
    LoadAbonTP;
    LoadAbonStreet;
End;

procedure CAbonAddressClass.LoadAbonCB(ABOID: integer);
begin
   mItemRIDAbon := -1;
   mItemDIDAbon := -1;
   mItemTIDAbon := -1;
   mItemTPIDAbon:= -1;
   mItemSIDAbon := -1;
   GetAbonIndexes(ABOID);
   LoadAbonReg;
   LoadAbonDep;
   LoadAbonTown;
   LoadAbonTP;
   LoadAbonStreet;
end;
{
procedure CAbonAddressClass.GetAbonIndexes(ABOID : integer);
var mAddrSet : int64;
begin
   mAddrSet := m_pDB.GetAddressSett(ABOID);
   mSIDAbon := (mAddrSet mod TID_MULT) div SID_MULT;
   mTIDAbon := (mAddrSet mod DID_MULT) div TID_MULT;
   mDIDAbon := (mAddrSet mod RID_MULT) div DID_MULT;
   mRIDAbon := mAddrSet div RID_MULT;
end;
}
procedure CAbonAddressClass.LoadAbonCB;
begin
   mItemRIDAbon := -1;
   mItemDIDAbon := -1;
   mItemTIDAbon := -1;
   mItemTPIDAbon := -1;
   mItemSIDAbon := -1;
   LoadAbonReg;
   LoadAbonDep;
   LoadAbonTown;
   LoadAbonTP;
   LoadAbonStreet;
end;

procedure CAbonAddressClass.LoadAbonReg;
var i, fi  : integer;
begin
   mAbonRIDCB.Clear;
   m_pDB.GetRegionsTableUN(mTtlRegInfo);
   if (mTtlRegInfo.Count = 0) then
   begin
     mAbonRIDCB.Text := 'Нет данных о регионах';
     mRIDAbon := -1;
    // mAbonRIDCB.Items.Add('Новый регион');
     mAbonRIDCB.Items.Add('Новый регион');
     exit;
   end;

   for i := 0 to mTtlRegInfo.Count - 1 do
     mAbonRIDCB.Items.Add(mTtlRegInfo.Items[i].m_nRegNM);

   fi := FindRIDItem(mRIDAbon, mTtlRegInfo);
   if (fi <> -1) and (fi < mAbonRIDCB.Items.Count) then
   begin
     mAbonRIDCB.ItemIndex := fi;
     mItemRIDAbon := fi;
   end
   else 
   begin
     mRIDAbon := -1;
     mAbonRIDCB.ItemIndex := 0;
   end;
   //mAbonRIDCB.Items.Add('Новый регион');
   mAbonRIDCB.Items.Add('Новый регион');
end;

procedure CAbonAddressClass.LoadAbonDep;
var i, fi  : integer;
begin
   mAbonDIDCB.Clear;
   m_pDB.GetDepartamentsTable(mRIDAbon, mTtlDepInfo);
   if (mTtlDepInfo.Count = 0) then
   begin
     mAbonDIDCB.Text := 'Нет данных о районе';
     mDIDAbon := -1;
     mAbonDIDCB.Items.Add('Новый район');
     exit;
   end;

   for i := 0 to mTtlDepInfo.Count - 1 do
     mAbonDIDCB.Items.Add(mTtlDepInfo.Items[i].m_sName);

   fi := FindDIDItem(mDIDAbon, mTtlDepInfo);
   if (fi <> -1) and (fi < mAbonDIDCB.Items.Count) then
   begin
     mAbonDIDCB.ItemIndex := fi;
     mItemDIDAbon := fi;

   end
   else
   begin
     mDIDAbon := -1;
     mAbonDIDCB.ItemIndex := 0;
   end;
   mAbonDIDCB.Items.Add('Новый район');
end;

procedure CAbonAddressClass.LoadAbonTown;
var i, fi  : integer;
begin
   mAbonTIDCB.Clear;
   m_pDB.GetTownsTable(mDIDAbon, mTtlTwnInfo);
   if (mTtlTwnInfo.Count = 0) then
   begin
     mAbonTIDCB.Text := 'Нет данных о городах';
     mTIDAbon := -1;
     mAbonTIDCB.Items.Add('Новый город');
     exit;
   end;

   for i := 0 to mTtlTwnInfo.Count - 1 do
     mAbonTIDCB.Items.Add(mTtlTwnInfo.Items[i].m_sName);

   fi := FindTIDItem(mTIDAbon, mTtlTwnInfo);
   if (fi <> -1) and (fi <  mAbonTIDCB.Items.Count) then
   begin
     mAbonTIDCB.ItemIndex := fi;
     mItemTIDAbon := fi;
   end
   else
   begin
     mTIDAbon := -1;
     mAbonTIDCB.ItemIndex := 0;
   end;
   mAbonTIDCB.Items.Add('Новый город');
end;

procedure CAbonAddressClass.LoadAbonTP;
var i, fi  : integer;
begin
   mAbonTPIDCB.Clear;
   m_pDB.GetPodsTable(mTIDAbon, mTtlTPInfo);
   if (mTtlTPInfo.Count = 0) then
   begin
     mAbonTPIDCB.Text := 'Нет данных о ТП';
     mTPIDAbon := -1;
     mAbonTPIDCB.Items.Add('Новое ТП');
     exit;
   end;

   for i := 0 to mTtlTPInfo.Count - 1 do
     mAbonTPIDCB.Items.Add(mTtlTPInfo.Items[i].NAME);

   fi := FindTPIDItem(mTPIDAbon, mTtlTPInfo);
   if (fi <> -1) and (fi <  mAbonTPIDCB.Items.Count) then
   begin
     mAbonTPIDCB.ItemIndex := fi;
     mItemTPIDAbon := fi;
   end
   else
   begin
     mTPIDAbon := -1;
     mAbonTPIDCB.ItemIndex := 0;
   end;
   mAbonTPIDCB.Items.Add('Новое ТП');
end;


procedure CAbonAddressClass.LoadAbonStreet;
var i, fi  : integer;
begin
   mAbonSIDCB.Clear;
   m_pDB.GetStreetsTable(mTIDAbon, mTtlStrInfo);
   if (mTtlStrInfo.Count = 0) then
   begin
     mAbonSIDCB.Text := 'Нет данных о улицах';
     mSIDAbon := -1;
     mAbonSIDCB.Items.Add('Новая улица');
     exit;
   end;

   for i := 0 to mTtlStrInfo.Count - 1 do
     mAbonSIDCB.Items.Add(mTtlStrInfo.Items[i].m_sName);

   fi := FindSIDItem(mSIDAbon, mTtlStrInfo);
   if (fi <> -1) and (fi < mAbonSIDCB.Items.Count) then
   begin
     mAbonSIDCB.ItemIndex := fi;
     mItemSIDAbon := fi;
   end
   else
   begin
     mSIDAbon := -1;
     mAbonSIDCB.ItemIndex := 0;
   end;
   mAbonSIDCB.Items.Add('Новая улица');
end;

procedure CAbonAddressClass.LoadTreeReg;
var i, fi    : integer;

begin
  if mTreeRIDCB<>nil then
  begin
   mTreeRIDCB.Clear;
   mTreeRIDCB.Items.Add('Все');
  end;
   m_pDB.GetRegionsTableUN(mTreeRegInfo);
   if (mTreeRegInfo.Count = 0) then
   begin
     if mTreeRIDCB<>nil then mTreeRIDCB.ItemIndex := 0;
     mRIDTree := -1;
     exit;
   end;

   for i := 0 to mTreeRegInfo.Count - 1 do
    if mTreeRIDCB<>nil then mTreeRIDCB.Items.Add(mTreeRegInfo.Items[i].m_nRegNM);

   fi := FindRIDItem(mRIDTree, mTreeRegInfo);
   if (fi <> -1) and (fi < mAbonRIDCB.Items.Count) then
    if mTreeRIDCB<>nil then mTreeRIDCB.ItemIndex := fi + 1
   else
   begin
     mRIDTree := -1;
    if mTreeRIDCB<>nil then mTreeRIDCB.ItemIndex := 0;
   end;
end;

procedure CAbonAddressClass.LoadTreeDep;
var i, fi  : integer;
begin
   if mTreeDIDCB<>nil then
   begin
    mTreeDIDCB.Clear;
    mTreeDIDCB.Items.Add('Все');
   end;
   m_pDB.GetDepartamentsTable(mRIDTree, mTreeDepInfo);
   if (mTreeDepInfo.Count = 0) then
   begin
     if mTreeDIDCB<>nil then mTreeDIDCB.ItemIndex := 0;
     mDIDAbon := -1;
     exit;
   end;

   for i := 0 to mTreeDepInfo.Count - 1 do
    if mTreeDIDCB<>nil then mTreeDIDCB.Items.Add(mTreeDepInfo.Items[i].m_sName);

   fi := FindDIDItem(mDIDTree, mTreeDepInfo);
   if mTreeDIDCB<>nil then begin
     if (fi <> -1) and (fi < mTreeDIDCB.Items.Count) then
       mTreeDIDCB.ItemIndex := fi + 1
     else
     begin
       mDIDAbon := -1;
       mTreeDIDCB.ItemIndex := 0;
     end;
   end;
end;

procedure CAbonAddressClass.LoadTreeTown;
var i, fi  : integer;
begin
   mTreeTIDCB.Clear;
   mTreeTIDCB.Items.Add('Все');
   m_pDB.GetTownsTable(mDIDTree, mTreeTwnInfo);
   if (mTreeTwnInfo.Count = 0) then
   begin
     mTreeTIDCB.ItemIndex := 0;
     mTIDAbon := -1;
     exit;
   end;

   for i := 0 to mTreeTwnInfo.Count - 1 do
     mTreeTIDCB.Items.Add(mTreeTwnInfo.Items[i].m_sName);

   fi := FindTIDItem(mTIDTree, mTreeTwnInfo);
   if (fi <> -1) and (fi < mTreeTIDCB.Items.Count) then
     mTreeTIDCB.ItemIndex := fi + 1
   else
   begin
     mTIDAbon := -1;
     mTreeTIDCB.ItemIndex := 0;
   end;
end;

procedure CAbonAddressClass.LoadTreeTP;
var i, fi  : integer;
begin
   mTreeTPIDCB.Clear;
   mTreeTPIDCB.Items.Add('Все');
   //m_pDB.GetTownsTable(mDIDTree, mTreeTwnInfo);
   m_pDB.GetPodsTable(mTPIDAbon, mTtlTPInfo);
   if (mTreeTPInfo.Count = 0) then
   begin
     mTreeTPIDCB.ItemIndex := 0;
     mTPIDAbon := -1;
     exit;
   end;

   for i := 0 to mTreeTPInfo.Count - 1 do
     mTreeTPIDCB.Items.Add(mTreeTPInfo.Items[i].NAME);

   fi := FindTPIDItem(mTPIDTree, mTreeTPInfo);
   if (fi <> -1) and (fi < mTreeTPIDCB.Items.Count) then
     mTreeTPIDCB.ItemIndex := fi + 1
   else
   begin
     mTPIDAbon := -1;
     mTreeTPIDCB.ItemIndex := 0;
   end;
end;

procedure CAbonAddressClass.LoadTreeStreet;
var i, fi  : integer;
begin
   mTreeSIDCB.Clear;
   mTreeSIDCB.Items.Add('Все');
   m_pDB.GetStreetsTable(mTIDTree, mTreeStrInfo);
   if (mTreeStrInfo.Count = 0) then
   begin
     mTreeSIDCB.ItemIndex := 0;
     mSIDTree := -1;
     exit;
   end;

   for i := 0 to mTreeStrInfo.Count - 1 do
     mTreeSIDCB.Items.Add(mTreeStrInfo.Items[i].m_sName);

   fi := FindSIDItem(mSIDTree, mTreeStrInfo);
   if (fi <> -1) and (fi < mTreeSIDCB.Items.Count) then
     mTreeSIDCB.ItemIndex := fi + 1
   else
   begin
     mSIDTree := -1;
     mTreeSIDCB.ItemIndex := 0;
   end;
end;

procedure CAbonAddressClass.AddNewRegion;
var pTable : SL3REGION;
begin
   if (mAbonRIDCB.Text = '') or (mItemRIDAbon = -1) then exit;
   mDIDAbon := 0;
   mTIDAbon := 0;
   mSIDAbon := 0;
   if mItemRIDAbon = mAbonRIDCB.Items.Count - 1 then
   begin
     mRIDAbon           := GetNewUniqRID;
     pTable.m_nRegionID := mRIDAbon;
     pTable.m_sbyEnable := 1;
     pTable.m_sKSP      := '';
   end
   else if (mItemRIDAbon < mTtlRegInfo.Count) then
   begin
     pTable := mTtlRegInfo.Items[mItemRIDAbon];
   end else
     exit;
   pTable.m_nRegNM    := mAbonRIDCB.Text;
   m_pDB.AddRegionTable(pTable);
   LoadAbonCB;
end;

procedure CAbonAddressClass.AddNewDepartament;
var pTable : SL3DEPARTAMENT;
begin
   if (mAbonDIDCB.Text = '') or (mItemDIDAbon = -1) then exit;
   if (FindRIDItem(mRIDAbon, mTtlRegInfo) = -1) then exit;
   mTIDAbon := 0;
   mSIDAbon := 0;
   if mItemDIDAbon = mAbonDIDCB.Items.Count - 1 then
   begin
     mDIDAbon := GetNewUniqDID;
     pTable.m_swRegion := mRIDAbon;
     pTable.m_swDepID := mDIDAbon;
   end
   else if (mItemDIDAbon < mTtlDepInfo.Count) then
   begin
     pTable := mTtlDepInfo.Items[mItemDIDAbon];
   end else
     exit;
   pTable.m_sName := mAbonDIDCB.Text;
   pTable.code    := KodSys.Text; //Код района
   m_pDB.AddDepartamentTable(pTable);
   LoadAbonCB;
end;

procedure CAbonAddressClass.AddNewTown;
var pTable : SL3TOWN;
begin
   if (mAbonTIDCB.Text = '') or (mItemTIDAbon = -1) then exit;
   if (FindDIDItem(mDIDAbon, mTtlDepInfo) = -1) then exit;
   mSIDAbon := 0;
   if mItemTIDAbon = mAbonTIDCB.Items.Count - 1 then
   begin
     mTIDAbon := GetNewUniqTID;
     pTable.m_swDepID := mDIDAbon;
     pTable.m_swTownID := mTIDAbon;
   end
   else if (mItemTIDAbon < mTtlTwnInfo.Count) then
   begin
     pTable := mTtlTwnInfo.Items[mItemTIDAbon];
   end else
     exit;
   pTable.m_sName := mAbonTIDCB.Text;
   m_pDB.AddTownTable(pTable);
   LoadAbonCB;
end;

procedure CAbonAddressClass.AddNewTP;
var pTable : SL3TP;
begin
   if (mAbonTPIDCB.Text = '') or (mItemTPIDAbon = -1) then exit;
   if (FindTIDItem(mTIDAbon, mTtlTwnInfo) = -1) then exit;
   mSIDAbon := 0;
   if mItemTPIDAbon = mAbonTPIDCB.Items.Count - 1 then
   begin
     mTPIDAbon := GetNewUniqTPID;
     pTable.M_SWTOWNID := mTIDAbon;
     pTable.ID := mTPIDAbon;
   end
   else if (mItemTPIDAbon < mTtlTPInfo.Count) then
   begin
     pTable := mTtlTPInfo.Items[mItemTPIDAbon];
   end else
     exit;
   pTable.Name := mAbonTPIDCB.Text;
   m_pDB.AddTPTable(pTable);
   LoadAbonCB;
end;


procedure CAbonAddressClass.AddNewStreet;
var pTable : SL3STREET;
begin
   if (mAbonSIDCB.Text = '') or (mItemSIDAbon = -1) then exit;
   if (FindTIDItem(mTIDAbon, mTtlTwnInfo) = -1) then exit;
   if mItemSIDAbon = mAbonSIDCB.Items.Count - 1 then
   begin
     mSIDAbon := GetNewUniqSID;
     pTable.m_swTownID := mTIDAbon;
     pTable.m_swStreetID := mSIDAbon;
   end
   else if (mItemSIDAbon < mTtlStrInfo.Count) then
   begin
     pTable := mTtlStrInfo.Items[mItemSIDAbon];
   end else
     exit;
   pTable.m_sName := mAbonSIDCB.Text;
   m_pDB.AddStreetTable(pTable);
   LoadAbonCB;
end;

procedure CAbonAddressClass.DelRegion;
begin
   if (mRIDAbon = REG_UNKNOWN) then
     exit;
   PlaceAbonToUnknowReg(mRIDAbon, -1, -1, -1);
   if mRIDAbon <> -1 then m_pDB.DelRegionTable(mRIDAbon);
   mRIDAbon := 0;
   mDIDAbon := 0;
   mTIDAbon := 0;
   mSIDAbon := 0;
   LoadAbonCB;
end;

procedure CAbonAddressClass.DelDepartament;
begin
   PlaceAbonToUnknowReg(mRIDAbon, mDIDAbon, -1, -1);
   if mDIDAbon <> -1 then m_pDB.DelDepartamentTable(mDIDAbon);
   mDIDAbon := 0;
   mTIDAbon := 0;
   mSIDAbon := 0;
   LoadAbonCB;
end;

procedure CAbonAddressClass.DelTown;
begin
   PlaceAbonToUnknowReg(mRIDAbon, mDIDAbon, mTIDAbon, -1);
   if (mTIDAbon <> -1) then m_pDB.DelTownTable(mTIDAbon);
   mTIDAbon := 0;
   mSIDAbon := 0;
   LoadAbonCB;
end;


procedure CAbonAddressClass.DelTP;
begin
  // PlaceAbonToUnknowReg(mRIDAbon, mDIDAbon, mTIDAbon, -1);
   if (mTPIDAbon <> -1) then m_pDB.DelSL3TPTable(mTPIDAbon);
   mTIDAbon := 0;
   mTPIDAbon := 0;
   mSIDAbon := 0;
   LoadAbonCB;
end;

procedure CAbonAddressClass.DelStreet;
begin
   PlaceAbonToUnknowReg(mRIDAbon, mDIDAbon, mTIDAbon, mSIDAbon);
   if (mSIDAbon <> -1) then m_pDB.DelStreetTable(mSIDAbon);
   mSIDAbon := 0;
   LoadAbonCB;
end;

procedure CAbonAddressClass.DelStreet_N;
begin
   LoadAbonCB;
end;

procedure CAbonAddressClass.DelRegionAbon;
begin
   DeleteAbons(mRIDAbon, -1, -1, -1);
   DelRegion;
end;

procedure CAbonAddressClass.DelDepartamentAbon;
begin
   DeleteAbons(mRIDAbon, mDIDAbon, -1, -1);
   DelDepartament;
end;

procedure CAbonAddressClass.DelTownAbon;
begin
   DeleteAbons(mRIDAbon, mDIDAbon, mTIDAbon, -1);
   DelTown;
end;

procedure CAbonAddressClass.DelTPAbon;
begin
   DeleteAbons_TP_N(mRIDAbon, mDIDAbon, mTIDAbon,mTPIDAbon, -1);
  // DeleteAbons(mRIDAbon, mDIDAbon, mTIDAbon, -1);
   DelTP;
end;

procedure CAbonAddressClass.DelStreetAbon;
begin
  //DeleteAbons(mRIDAbon, mDIDAbon, mTIDAbon, mSIDAbon);
  DeleteAbons_N(mRIDAbon, mDIDAbon, mTIDAbon, mSIDAbon);
  DelStreet;
end;

procedure CAbonAddressClass.ChangeARegion;
begin
   if (mAbonRIDCB.ItemIndex < mTtlRegInfo.Count) and (mAbonRIDCB.ItemIndex >= 0) then
     mRIDAbon := mTtlRegInfo.Items[mAbonRIDCB.ItemIndex].m_nRegionID;
   mDIDAbon := 0;
   mTIDAbon := 0;
   mSIDAbon := 0;
   LoadAbonReg;
   LoadAbonDep;
   LoadAbonTown;
   LoadAbonStreet;
end;

procedure CAbonAddressClass.ChangeADepartament;
begin
   if (mAbonDIDCB.ItemIndex < mTtlDepInfo.Count) and (mAbonDIDCB.ItemIndex >= 0) then
     mDIDAbon := mTtlDepInfo.Items[mAbonDIDCB.ItemIndex].m_swDepID;
   mTIDAbon := 0;
   mSIDAbon := 0;
   LoadAbonDep;
   LoadAbonTown;
   LoadAbonStreet;
end;

procedure CAbonAddressClass.ChangeATown;
begin
   if (mAbonTIDCB.ItemIndex < mTtlTwnInfo.Count) and (mAbonTIDCB.ItemIndex >= 0) then
     mTIDAbon := mTtlTwnInfo.Items[mAbonTIDCB.ItemIndex].m_swTownID;
   mSIDAbon := 0;
   LoadAbonTown;
   LoadAbonTP;
   LoadAbonStreet;
end;

procedure CAbonAddressClass.ChangeATP;
begin
   if (mAbonTPIDCB.ItemIndex < mTtlTPInfo.Count) and (mAbonTPIDCB.ItemIndex >= 0) then
     mTPIDAbon := mTtlTPInfo.Items[mAbonTPIDCB.ItemIndex].ID; //.m_swStreetID;
   LoadAbonTown;
   LoadAbonTP;
end;


procedure CAbonAddressClass.ChangeAStreet;
begin
   if (mAbonSIDCB.ItemIndex < mTtlStrInfo.Count) and (mAbonSIDCB.ItemIndex >= 0) then
     mSIDAbon := mTtlStrInfo.Items[mAbonSIDCB.ItemIndex].m_swStreetID;
   LoadAbonStreet;
end;

procedure CAbonAddressClass.ChangeTRegion;
begin
   if (mTreeRIDCB.ItemIndex - 1 < mTreeRegInfo.Count) and (mTreeRIDCB.ItemIndex > 0) then
     mRIDTree := mTreeRegInfo.Items[mTreeRIDCB.ItemIndex - 1].m_nRegionID
   else
     mRIDTree := -1;
   mDIDTree := -1;
   mTIDTree := -1;
   mSIDTree := -1;
   LoadTreeReg;
   LoadTreeDep;
   LoadTreeTown;
   LoadTreeTP;
   LoadTreeStreet;
   ResizePanel;
end;

procedure CAbonAddressClass.ChangeTDepartament;
begin
   if (mTreeDIDCB.ItemIndex - 1 < mTreeDepInfo.Count) and (mTreeDIDCB.ItemIndex > 0) then
     mDIDTree := mTreeDepInfo.Items[mTreeDIDCB.ItemIndex - 1].m_swDepID
   else
     mDIDTree := -1;
   mTIDTree := -1;
   mSIDTree := -1;
   LoadTreeDep;
   LoadTreeTown;
   LoadTreeTP;
   LoadTreeStreet;
   ResizePanel;
end;

procedure CAbonAddressClass.ChangeTTown;
begin
   if (mTreeTIDCB.ItemIndex - 1 < mTreeTwnInfo.Count) and (mTreeTIDCB.ItemIndex > 0) then
     mTIDTree := mTreeTwnInfo.Items[mTreeTIDCB.ItemIndex - 1].m_swTownID
   else
     mTIDTree := -1;
   mSIDTree := -1;
   LoadTreeTown;
   LoadTreeTP;
   LoadTreeStreet;
   ResizePanel;
end;

procedure CAbonAddressClass.ChangeTStreet;
begin
   if (mTreeSIDCB.ItemIndex - 1 < mTreeStrInfo.Count) and (mTreeSIDCB.ItemIndex > 0) then
     mSIDTree := mTreeStrInfo.Items[mTreeSIDCB.ItemIndex - 1].m_swStreetID
   else
     mSIDTree := -1;
   LoadTreeStreet;
   ResizePanel;
end;

procedure CAbonAddressClass.GetAbonIndexes(ABOID : integer);
var mAddrSet : int64;
    pTbl     : SL3ABONS;
begin
   if  m_pDB.GetAbonTable(ABOID,pTbl) then
   Begin
    mSIDAbon  := pTbl.Items[0].M_SWSTREETID;
    mTPIDAbon := pTbl.Items[0].TPID;
    mTIDAbon  := pTbl.Items[0].M_SWTOWNID;
    mDIDAbon  := pTbl.Items[0].M_SWDEPID;
    mRIDAbon  := pTbl.Items[0].m_nRegionID;
   End;

   {mAddrSet := m_pDB.GetAddressSett(ABOID);
   mSIDAbon := (mAddrSet mod TID_MULT) div SID_MULT;
   mTIDAbon := (mAddrSet mod DID_MULT) div TID_MULT;
   mDIDAbon := (mAddrSet mod RID_MULT) div DID_MULT;
   mRIDAbon := mAddrSet div RID_MULT;}
end;

function CAbonAddressClass.GetAbonAddr : CTreeIndex;
Var
   pID : CTreeIndex;
Begin
   pID.PRID := mRIDAbon;
   pID.PRYD := mDIDAbon;
   pID.PTWN := mTIDAbon;
   pID.PSTR := mSIDAbon;
   Result   := pID;
End;

function CAbonAddressClass.GetABONAdrID : int64;
begin
   Result := 0;
   if (mRIDAbon >= 0) then
     Result := Result + mRIDAbon * RID_MULT;
   if (mRIDAbon = -1) and (mTtlRegInfo.Count > 0) then
     Result := Result + mTtlRegInfo.Items[0].m_nRegionID * RID_MULT;

   if (mDIDAbon >= 0) then
     Result := Result + mDIDAbon * DID_MULT;
   if (mDIDAbon = -1) and (mTtlDepInfo.Count > 0) then
     Result := Result + mTtlDepInfo.Items[0].m_swDepID * DID_MULT;

   if (mTIDAbon >= 0) then
     Result := Result + mTIDAbon * TID_MULT;
   if (mTIDAbon = -1) and (mTtlTwnInfo.Count > 0) then
     Result := Result + mTtlTwnInfo.Items[0].m_swTownID * TID_MULT;

   if (mSIDAbon >= 0) then
     Result := Result + mSIDAbon * SID_MULT;
   if (mSIDAbon = -1) and (mTtlStrInfo.Count > 0) then
     Result := Result + mTtlStrInfo.Items[0].m_swStreetID * SID_MULT;
end;

function CAbonAddressClass.GetNewUniqRID: integer;
var i, Uniq : integer;
    pTable  : SL3REGIONS;
begin
   Uniq := -1;
   m_pDB.GetRegionsTableUN(pTable);

   for i := 0 to pTable.Count - 2 do
     if pTable.Items[i].m_nRegionID + 1 <> pTable.Items[i + 1].m_nRegionID then
       Uniq := pTable.Items[i].m_nRegionID + 1;

   if pTable.Count = 0 then
     Uniq := 0;
   if (pTable.Count > 0) and (Uniq = -1) then
     Uniq := pTable.Items[pTable.Count - 1].m_nRegionID + 1;

   Result := Uniq;
end;

function CAbonAddressClass.GetNewUniqDID: integer;
var i, Uniq : integer;
    pTable  : SL3DEPARTAMENTS;
begin
   Uniq := -1;
   m_pDB.GetAllDepartamentsTable(pTable);

   for i := 0 to pTable.Count - 2 do
     if pTable.Items[i].m_swDepID + 1 <> pTable.Items[i + 1].m_swDepID then
       Uniq := pTable.Items[i].m_swDepID + 1;

   if pTable.Count = 0 then
     Uniq := 0;
   if (pTable.Count > 0) and (Uniq = -1) then
     Uniq := pTable.Items[pTable.Count - 1].m_swDepID + 1;

   Result := Uniq;
end;

function CAbonAddressClass.GetNewUniqTID: integer;
var i, Uniq : integer;
    pTable  : SL3TOWNS;
begin
   Uniq := -1;
   m_pDB.GetAllTownsTable(pTable);

   for i := 0 to pTable.Count - 2 do
     if pTable.Items[i].m_swTownID + 1 <> pTable.Items[i + 1].m_swTownID then
       Uniq := pTable.Items[i].m_swTownID + 1;

   if pTable.Count = 0 then
     Uniq := 0;
   if (pTable.Count > 0) and (Uniq = -1) then
     Uniq := pTable.Items[pTable.Count - 1].m_swTownID + 1;

   Result := Uniq;
end;


function CAbonAddressClass.GetNewUniqTPID: integer;
var i, Uniq : integer;
    pTable  : SL3TPS;
begin
   Uniq := -1;
   m_pDB.GetAllTPTable(pTable);

   for i := 0 to pTable.Count - 2 do
     if pTable.Items[i].ID + 1 <> pTable.Items[i + 1].ID then
       Uniq := pTable.Items[i].ID + 1;

   if pTable.Count = 0 then
     Uniq := 0;
   if (pTable.Count > 0) and (Uniq = -1) then
     Uniq := pTable.Items[pTable.Count - 1].ID + 1;

   Result := Uniq;
end;

function CAbonAddressClass.GetNewUniqSID: integer;
var i, Uniq : integer;
    pTable  : SL3STREETS;
begin
   Uniq := -1;
   m_pDB.GetAllStreetsTable(pTable);

   for i := 0 to pTable.Count - 2 do
     if pTable.Items[i].m_swStreetID + 1 <> pTable.Items[i + 1].m_swStreetID then
       Uniq := pTable.Items[i].m_swStreetID + 1;

   if pTable.Count = 0 then
     Uniq := 0;
   if (pTable.Count > 0) and (Uniq = -1) then
     Uniq := pTable.Items[pTable.Count - 1].m_swStreetID + 1;

   Result := Uniq;
end;

function CAbonAddressClass.FindRIDItem(ID: integer; var pTable: SL3REGIONS): integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if pTable.Items[i].m_nRegionID = ID then
     begin
       Result := i;
       exit;
     end;
end;

function CAbonAddressClass.FindDIDItem(ID: integer; var pTable: SL3DEPARTAMENTS): integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if pTable.Items[i].m_swDepID = ID then
     begin
       KodSys.Text:=pTable.Items[i].code;  //код района
       Result := i;
       exit;
     end;
end;

function CAbonAddressClass.FindTIDItem(ID: integer; var pTable: SL3TOWNS): integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if pTable.Items[i].m_swTownID = ID then
     begin
       Result := i;
       exit;
     end;
end;

function  CAbonAddressClass.FindTPIDItem(ID: integer; var pTable: SL3TPS): integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if pTable.Items[i].ID = ID then
     begin
       Result := i;
       exit;
     end;
end;

function CAbonAddressClass.FindSIDItem(ID: integer; var pTable: SL3STREETS): integer;
var i : integer;
begin
   Result := -1;
   for i := 0 to pTable.Count - 1 do
     if pTable.Items[i].m_swStreetID = ID then
     begin
       Result := i;
       exit;
     end;
end;

procedure CAbonAddressClass.ResizePanel;
var new_height : integer;
begin
   if not mIsPanelDraw then
     new_height := 4
   else
   begin
     new_height := 5 + 22;
     if mTreeRIDCB.ItemIndex > 0 then
       new_height := new_height + 22 + 2;
     if mTreeDIDCB.ItemIndex > 0 then
       new_height := new_height + 22 + 2;
     if mTreeTIDCB.ItemIndex > 0 then
       new_height := new_height + 22 + 2;
   end;
   mTreeAddr.Height := new_height;
end;

function CAbonAddressClass.GetRegTable(var pTable:SL3REGIONS): boolean;
var i, j                   : integer;
    minFilter, maxFilter   : int64;
begin
   Result := true;
   if mRIDTree = -1 then
     m_pDB.GetRegionsTable(pTable)
   else
     m_pDB.GetRegionsTable(mRIDTree, pTable);
   minFilter := GetMinFilterVal;
   maxFilter := GetMaxFilterVal;
   for i := 0 to pTable.Count - 1 do
   begin
     m_pDB.GetFiltAbonRegTable(pTable.Items[i].m_nRegionID, minFilter, maxFilter, pTable.Items[i].Item);
     for j:=0 to pTable.Items[i].Item.Count-1 do
       m_pDB.GetAbonTag(pTable.Items[i].Item.Items[j].m_swABOID,pTable.Items[i].Item.Items[j].Item);
   end;
end;

function CAbonAddressClass.GetMinFilterVal: int64;
begin
   Result := 0;
   if mRIDTree >= 0 then
     Result := Result + mRIDTree * RID_MULT;
   if mDIDTree >= 0 then
     Result := Result + mDIDTree * DID_MULT;
   if mTIDTree >= 0 then
     Result := Result + mTIDTree * TID_MULT;
   if mSIDTree >= 0 then
     Result := Result + mSIDTree * SID_MULT;
end;

function CAbonAddressClass.GetMaxFilterVal: int64;
begin
   Result := GetMinFilterVal;
   if mRIDTree = -1 then
     Result := Result + RID_MULT * _MULT
   else if mDIDTree = -1 then
     Result := Result + DID_MULT * _MULT
   else if mTIDTree = -1 then
     Result := Result + TID_MULT * _MULT
   else if mSIDTree = -1 then
     Result := Result + SID_MULT * _MULT
   else
     Result := Result + 1;
end;

procedure CAbonAddressClass.SetPanelUnvisible;
begin
   mIsPanelDraw := false;
   ResizePanel;
end;

procedure CAbonAddressClass.SetPanelVisible;
begin
   mIsPanelDraw := true;
   ResizePanel;
end;

function CAbonAddressClass.GetRegionID: integer;
begin
   if mRIDAbon < 0 then
     Result := 0
   else
     Result := mRIDAbon;
end;

function CAbonAddressClass.GetRegItemInd: integer;
begin
   Result := mAbonRIDCB.ItemIndex;
end;

procedure CAbonAddressClass.InitUknownRegion;
var pTable : SL3REGION;
begin
   pTable.m_nRegionID := REG_UNKNOWN;
   if not m_pDB.IsRegTable(pTable) then
   begin
     pTable.m_sbyEnable := 0;
     pTable.m_sKSP      := '8500';
     pTable.m_nRegNM    := REG_UNKNOWN_NAME;
     m_pDB.AddRegionTable(pTable);
   end;
end;

procedure CAbonAddressClass.PlaceAbonToUnknowReg(RID, DID, TID, SID: integer);
var minFilter, maxFilter   : int64;
    pTable                 : SL3REGIONS;
    i, j                   : integer;
begin
   mRIDTree := RID;
   mDIDTree := DID;
   mTIDTree := TID;
   mSIDTree := SID;
   minFilter := GetMinFilterVal;
   maxFilter := GetMaxFilterVal;
   if mRIDTree = -1 then
     m_pDB.GetRegionsTable(pTable)
   else
     m_pDB.GetRegionsTable(mRIDTree, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
     m_pDB.GetFiltAbonRegTable(pTable.Items[i].m_nRegionID, minFilter, maxFilter, pTable.Items[i].Item);
     for j:=0 to pTable.Items[i].Item.Count-1 do
     begin
       pTable.Items[i].Item.Items[j].m_nRegionID := REG_UNKNOWN;
       pTable.Items[i].Item.Items[j].m_sAddrSettings := REG_UNKNOWN * RID_MULT;
       m_pDB.SetAbonTable(pTable.Items[i].Item.Items[j]);
     end;
   end;
end;

procedure CAbonAddressClass.DeleteAbons(RID, DID, TID, SID: integer);
var minFilter, maxFilter   : int64;
    pTable                 : SL3REGIONS;
    i, j                   : integer;
begin
   mRIDTree := RID;
   mDIDTree := DID;
   mTIDTree := TID;
   mSIDTree := SID;
   minFilter := GetMinFilterVal;
   maxFilter := GetMaxFilterVal;
   if mRIDTree = -1 then
     m_pDB.GetRegionsTable(pTable)
   else
     m_pDB.GetRegionsTable(mRIDTree, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
     m_pDB.GetFiltAbonRegTable(pTable.Items[i].m_nRegionID, minFilter, maxFilter, pTable.Items[i].Item);
     for j:=0 to pTable.Items[i].Item.Count-1 do
     begin
       m_pDB.DelAbonTable(pTable.Items[i].Item.Items[j].m_swABOID);
     end;
   end;
end;



procedure CAbonAddressClass.DeleteAbons_N(RID, DID, TID, SID: integer);
var minFilter, maxFilter   : int64;
    pTable                 : SL3REGIONS;
    i, j                   : integer;
begin
   mRIDTree := RID;
   mDIDTree := DID;
   mTIDTree := TID;
   mSIDTree := SID;
   if mRIDTree = -1 then
     m_pDB.GetRegionsTable(pTable)
   else
     m_pDB.GetRegionsTable(mRIDTree, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
//     m_pDB.GetFiltAbonRegTable(pTable.Items[i].m_nRegionID, minFilter, maxFilter, pTable.Items[i].Item);
    m_pDB.GetFiltAbonRegTable_N(pTable.Items[i].m_nRegionID, mDIDTree, mTIDTree,mSIDTree, pTable.Items[i].Item);
     for j:=0 to pTable.Items[i].Item.Count-1 do
     begin
       m_pDB.DelAbonTable(pTable.Items[i].Item.Items[j].m_swABOID);
     end;
   end;
end;

procedure CAbonAddressClass.DeleteAbons_TP_N(RID, DID, TID, TPID, SID: integer);
var minFilter, maxFilter   : int64;
    pTable                 : SL3REGIONS;
    i, j                   : integer;
begin
   mRIDTree := RID;
   mDIDTree := DID;
   mTIDTree := TID;
   mTPIDTree := TPID;
   mSIDTree := SID;
   if mRIDTree = -1 then
     m_pDB.GetRegionsTable(pTable)
   else
     m_pDB.GetRegionsTable(mRIDTree, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
//     m_pDB.GetFiltAbonRegTable(pTable.Items[i].m_nRegionID, minFilter, maxFilter, pTable.Items[i].Item);
    m_pDB.GetFiltAbonRegTable_N_TP(pTable.Items[i].m_nRegionID, mDIDTree, mTIDTree,mTPIDTree, pTable.Items[i].Item);
     for j:=0 to pTable.Items[i].Item.Count-1 do
     begin
       m_pDB.DelAbonTable(pTable.Items[i].Item.Items[j].m_swABOID);
     end;
   end;
end;

initialization

finalization
  if AbonAddress <> nil then FreeAndNil(AbonAddress);

end.

