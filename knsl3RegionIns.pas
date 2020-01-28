unit knsl3RegionIns;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvToolBar, AdvToolBarStylers, ImgList, AdvAppStyler, StdCtrls, ExtCtrls,
  AdvPanel, GradientLabel, jpeg, RbDrawCore, RbButton, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers,utlconst,utlbox,utltypes,utldatabase,knsl5config,
  AdvProgressBar, AdvOfficeButtons, AdvOfficePager, Grids, BaseGrid, AdvGrid, AdvOfficePagerStylers,
  AdvSmoothButton, Spin, AdvGroupBox, ComCtrls, AdvGlowButton,utldynconnect, Menus,
  rtflabel,knsl3AddrUnit;

type
  TRegion_ES = class(TForm)
    aop_AbonPages: TAdvOfficePager;
    aop_AbonAttributes: TAdvOfficePage;
    AdvPanel3: TAdvPanel;
    AdvProgressBar1: TAdvProgressBar;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    cmbPullAbon: TComboBox;
    Label1: TLabel;
    RTFLabel1: TRTFLabel;
    AdvRegionES: TAdvStringGrid;
    Label2: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    GradientLabel1: TGradientLabel;
    lbm_sKodSysBalance: TLabel;
    Bevel1: TBevel;
    cbm_nRegion: TComboBox;
    RbButton1: TRbButton;
    RbButton2: TRbButton;
    cbm_nDepart: TComboBox;
    btn_nDepartAdd: TRbButton;
    btn_nDepartDel: TRbButton;
    cbm_nTown: TComboBox;
    btn_nTownAdd: TRbButton;
    btn_nTownDel: TRbButton;
    cbm_nStreet: TComboBox;
    btn_nStreetAdd: TRbButton;
    btn_nStreetDel: TRbButton;
    edm_sKodSys: TEdit;
    Label3: TLabel;
    cbm_nTP: TComboBox;
    btn_nTPAdd: TRbButton;
    btn_nTPDel: TRbButton;
    procedure FormActivate(Sender: TObject);
    procedure RbButton1Click(Sender: TObject);
    procedure btn_nDepartAddClick(Sender: TObject);
    procedure btn_nTownAddClick(Sender: TObject);
    procedure btn_nStreetAddClick(Sender: TObject);
    procedure btn_nStreetDelClick(Sender: TObject);
    procedure btn_nTownDelClick(Sender: TObject);
    procedure btn_nDepartDelClick(Sender: TObject);
    procedure RbButton2Click(Sender: TObject);

    procedure setTreeIndex(index:CTreeIndex);
    procedure setTreeData(value:TTreeView);
    procedure OnAddAbon;

    procedure OnCreateAbonSettings(Sender: TObject);
    procedure cbm_nRegionChange(Sender: TObject);
    procedure cbm_nDepartChange(Sender: TObject);
    procedure cbm_nTownChange(Sender: TObject);
    procedure cbm_nStreetChange(Sender: TObject);

    procedure RefreshTable;
    procedure btn_nTPAddClick(Sender: TObject);
    procedure cbm_nTPChange(Sender: TObject);
    procedure btn_nTPDelClick(Sender: TObject);
    procedure InitTreeRef;
  private
    { Private declarations }
     m_treeID        : CTreeIndex;
     FTreeModuleData : TTreeView;

  public
    { Public declarations }

  procedure ClearTable;
  end;

var
  Region_ES: TRegion_ES;

implementation

uses knsl3abon;

{$R *.DFM}

procedure TRegion_ES.setTreeIndex(index:CTreeIndex);
Begin
     m_treeID := index;
End;


procedure TRegion_ES.setTreeData(value:TTreeView);
Begin
     FTreeModuleData := value;
End;


///Заполнение таблицы существующими регионами из БД/////////
procedure TRegion_ES.FormActivate(Sender: TObject);
{var
pTable:SL3REGIONS;
i:Integer;
begin
 m_pDB.GetRegionsTable(pTable);
 ClearTable;
   AdvRegionES.RowCount:= pTable.Count+1;
   for i := 0 to pTable.Count-1 do
    begin
      if pTable.Items[i].m_nRegionID=500 then continue; //не отображать 500 регион (он стандартный)
      AdvRegionES.Cells[0,i+1]:=IntToStr(i+1);
      AdvRegionES.Cells[1,i+1]:= pTable.Items[i].m_nRegNM;
    end;
end;}

var
pTable:SL3DEPARTAMENTS;
i:Integer;
res:boolean;
begin
  res:=m_pDB.GetDepartamentsTableAll(pTable);
  ClearTable;
  if (pTable.Count=0) then
  begin
  AdvRegionES.RowCount:= pTable.Count+2;
  exit;
  end;
  AdvRegionES.RowCount:= pTable.Count+1;  //+1
   for i := 0 to pTable.Count-1 do
    begin
      AdvRegionES.Cells[0,i+1]:= IntToStr(i+1);
      AdvRegionES.Cells[1,i+1]:= pTable.Items[i].m_sName;
      AdvRegionES.Cells[2,i+1]:= pTable.Items[i].code;
    end;
      AbonAddress.mAbonRIDCB := @Region_ES.cbm_nRegion;
      AbonAddress.mAbonDIDCB := @Region_ES.cbm_nDepart;
      AbonAddress.mAbonTIDCB := @Region_ES.cbm_nTown;
      AbonAddress.mAbonTPIDCB:= @Region_ES.cbm_nTP;
      AbonAddress.mAbonSIDCB := @Region_ES.cbm_nStreet;
      AbonAddress.KodSys     := @Region_ES.edm_sKodSys;
      AbonAddress.InitComboBox;
end;

///////////////////////////////////////////////////////////////


procedure TRegion_ES.RefreshTable;
var
pTable:SL3DEPARTAMENTS;
i:Integer;
res:boolean;
begin
  res:=m_pDB.GetDepartamentsTableAll(pTable);
  ClearTable;
  if (pTable.Count=0) then
  begin
  AdvRegionES.RowCount:= pTable.Count+2;
  exit;
  end;
  AdvRegionES.RowCount:= pTable.Count+1;  //+1
   for i := 0 to pTable.Count-1 do
    begin
      AdvRegionES.Cells[0,i+1]:= IntToStr(i+1);
      AdvRegionES.Cells[1,i+1]:= pTable.Items[i].m_sName;
      AdvRegionES.Cells[2,i+1]:= pTable.Items[i].code;
    end;
end;    

procedure TRegion_ES.OnAddAbon;
Begin
     OnCreateAbonSettings(self);
End;



procedure TRegion_ES.OnCreateAbonSettings(Sender: TObject);
begin
      AbonAddress.LoadAbonFromID(m_treeID);
end;



////////Очистка таблицы////////////////////////////////////////
procedure TRegion_ES.ClearTable;
var i, j: Integer;
begin
with AdvRegionES do
  for i:=FixedCols to ColCount-1 do
  for j:=FixedRows to RowCount-1 do
    Cells[i, j]:='';
end;
///////////////////////////////////////////////////////////////


procedure TRegion_ES.RbButton1Click(Sender: TObject);
begin
AbonAddress.AddNewRegion;
InitTreeRef;
end;

procedure TRegion_ES.btn_nDepartAddClick(Sender: TObject);
begin
   if (edm_sKodSys.Text='')then MessageDlg('Введите код района!', mtInformation, [mbOk], 0)
   else
   begin
 if (cbm_nDepart.ItemIndex= cbm_nDepart.Items.Count-1)or (cbm_nDepart.ItemIndex=-1) then
   if (m_pDB.IsDepartamentTableCode(edm_sKodSys.Text)=true)then
     begin
     if MessageDlg('Код района уже существует! Заменить?',mtWarning,[mbOk,mbCancel],0)=mrOk then
       begin
        AbonAddress.AddNewDepartament;
        RefreshTable;
        InitTreeRef;
       end
     else
      Exit;
     end
     else
     begin
        AbonAddress.AddNewDepartament;
        RefreshTable;
        InitTreeRef;
     end;  
   end;

end;

procedure TRegion_ES.btn_nTownAddClick(Sender: TObject);
begin
   AbonAddress.AddNewTown;
   InitTreeRef;
end;

procedure TRegion_ES.btn_nStreetAddClick(Sender: TObject);
begin
   AbonAddress.AddNewStreet;
   InitTreeRef;
end;

procedure TRegion_ES.btn_nStreetDelClick(Sender: TObject);
begin
     if m_nCF.m_nUsrCtrl.IsUserHavePrmt(SA_USER_PERMIT_PRE) then
       if MessageDlg('Удалить улицу вместе с абонентами?',mtWarning,[mbOk,mbCancel],0)=mrOk then
       begin
         AbonAddress.DelStreetAbon;
         InitTreeRef;
        //OnCreate(Self);
       end;
end;

procedure TRegion_ES.btn_nTownDelClick(Sender: TObject);
begin
     if m_nCF.m_nUsrCtrl.IsUserHavePrmt(SA_USER_PERMIT_PRE) then
       if MessageDlg('Удалить город вместе с абонентами?',mtWarning,[mbOk,mbCancel],0)=mrOk then
       begin
         AbonAddress.DelTownAbon;
        // OnCreate(Self);
        InitTreeRef;
       end;
end;

procedure TRegion_ES.btn_nDepartDelClick(Sender: TObject);
begin
     if m_nCF.m_nUsrCtrl.IsUserHavePrmt(SA_USER_PERMIT_PRE) then
       if MessageDlg('Удалить район вместе с абонентами?',mtWarning,[mbOk,mbCancel],0)=mrOk then
       begin
         AbonAddress.DelDepartamentAbon;
        // OnCreate(Self);
         RefreshTable;
         InitTreeRef;
       end;
end;

procedure TRegion_ES.RbButton2Click(Sender: TObject);
begin
     if m_nCF.m_nUsrCtrl.IsUserHavePrmt(SA_USER_PERMIT_PRE) then
       if MessageDlg('Удалить регион вместе с абонентами?',mtWarning,[mbOk,mbCancel],0)=mrOk then
       begin
         AbonAddress.DelRegionAbon;
         //OnCreate(Self);
       end;

end;

procedure TRegion_ES.cbm_nRegionChange(Sender: TObject);
var i : integer;
begin
   if cbm_nRegion.ItemIndex = -1 then
     exit;
   AbonAddress.mItemRIDAbon := cbm_nRegion.ItemIndex;
   if cbm_nRegion.ItemIndex < cbm_nRegion.Items.Count - 1 then
    begin
     AbonAddress.ChangeARegion;
     edm_sKodSys.Text:='';
    end;
end;

procedure TRegion_ES.cbm_nDepartChange(Sender: TObject);
begin
   if cbm_nDepart.ItemIndex = -1 then
     exit;
   AbonAddress.mItemDIDAbon := cbm_nDepart.ItemIndex;
   if cbm_nDepart.ItemIndex < cbm_nDepart.Items.Count - 1 then
     begin
     AbonAddress.ChangeADepartament;
     end
   else edm_sKodSys.Text:='';

end;

procedure TRegion_ES.cbm_nTownChange(Sender: TObject);
begin
   if cbm_nTown.ItemIndex = -1 then
     exit;
   AbonAddress.mItemTIDAbon := cbm_nTown.ItemIndex;
   if cbm_nTown.ItemIndex < cbm_nTown.Items.Count - 1 then
     begin
      AbonAddress.ChangeATown;
     end;
end;

procedure TRegion_ES.cbm_nStreetChange(Sender: TObject);
begin
   if cbm_nStreet.ItemIndex = -1 then
     exit;
   AbonAddress.mItemSIDAbon := cbm_nStreet.ItemIndex;
   if cbm_nStreet.ItemIndex < cbm_nStreet.Items.Count - 1 then
     AbonAddress.ChangeAStreet;
end;


procedure TRegion_ES.btn_nTPAddClick(Sender: TObject);
begin
      AbonAddress.AddNewTP;
      InitTreeRef;
end;


procedure TRegion_ES.cbm_nTPChange(Sender: TObject);
begin
   if cbm_nTP.ItemIndex = -1 then
     exit;
   AbonAddress.mItemTPIDAbon := cbm_nTP.ItemIndex;
   if cbm_nTP.ItemIndex < cbm_nTP.Items.Count - 1 then
     AbonAddress.ChangeATP;

end;

procedure TRegion_ES.btn_nTPDelClick(Sender: TObject);
begin
  if m_nCF.m_nUsrCtrl.IsUserHavePrmt(SA_USER_PERMIT_PRE) then
    if MessageDlg('Удалить ТП вместе с абонентами?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     begin
       AbonAddress.DelTPAbon;
       InitTreeRef;
      // OnCreate(Self);
      end;
end;


procedure TRegion_ES.InitTreeRef;
Var
    pDS : CMessageData;
Begin
    //if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    //if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    pDS.m_swData4 := MTR_LOCAL;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INIT_TREE_REQ,pDS);
End;


end.
