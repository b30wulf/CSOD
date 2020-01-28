unit knsl3abon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvToolBar, AdvToolBarStylers, ImgList, AdvAppStyler, StdCtrls, ExtCtrls,
  AdvPanel, GradientLabel, jpeg, RbDrawCore, RbButton, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers,utlconst,utlbox,utltypes,utldatabase,knsl5config,
  AdvProgressBar, AdvOfficeButtons, AdvOfficePager, Grids,
  BaseGrid, AdvGrid, knsl3AddrUnit, AdvOfficePagerStylers,knsl3EventBox, AdvSmoothButton,
  knsl3housegen,AdvGroupBox,ComCtrls, AdvGlowButton,utldynconnect, Menus, Spin;
type
  TTAbonManager = class(TForm)
    AbonStyler: TAdvFormStyler;
    ImageList1: TImageList;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvPanelStyler2: TAdvPanelStyler;
    AdvPanelStyler3: TAdvPanelStyler;
    aop_AbonPages: TAdvOfficePager;
    aop_AbonAttributes: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    AdvPanel3: TAdvPanel;
    Label18: TLabel;
    Label25: TLabel;
    Label6: TLabel;
    lbTelToToRing: TLabel;
    pbm_sBTIProgress: TAdvProgressBar;
    Label8: TLabel;
    sbAbon: TAdvOfficeStatusBar;
    edm_swABOID: TEdit;
    edm_sName: TEdit;
    edm_sAddress: TEdit;
    cbm_sbyEnable: TComboBox;
    edm_sdtRegDate: TEdit;
    edm_TelToRing: TEdit;
    cbm_sbyVisible: TComboBox;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    v_ReportList: TAdvStringGrid;
    AdvPanel4: TAdvPanel;
    lbGenSettings: TLabel;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    advSettAllRep: TAdvToolBarButton;
    AdvOfficeStatusBar1: TAdvOfficeStatusBar;
    ImageList: TImageList;
    pgExportData: TAdvOfficePage;
    pgImportData: TAdvOfficePage;
    OpenDialog1: TOpenDialog;
    pgAbonTreeSett: TAdvOfficePage;
    cbArchv: TAdvOfficeCheckBox;
    cbGraph: TAdvOfficeCheckBox;
    cbLimit: TAdvOfficeCheckBox;
    cbPeriod: TAdvOfficeCheckBox;
    cbCurrt: TAdvOfficeCheckBox;
    cbVecDg: TAdvOfficeCheckBox;
    cbChndg: TAdvOfficeCheckBox;
    cbEvents: TAdvOfficeCheckBox;
    cbRprts: TAdvOfficeCheckBox;
    lbm_sHouseNumber: TLabel;
    lbm_sKorpusNumber: TLabel;
    edm_sHouseNumber: TEdit;
    edm_sKorpusNumber: TEdit;
    AdvToolBarSeparator5: TAdvToolBarSeparator;
    Label9: TLabel;
    Label27: TLabel;
    lbHouseGenLabel: TGradientLabel;
    CheckBox1: TCheckBox;
    GradientLabel3: TGradientLabel;
    GradientLabel4: TGradientLabel;
    lbm_sVmName: TLabel;
    edm_sVmName: TEdit;
    AdvToolBarSeparator4: TAdvToolBarSeparator;
    GradientLabel5: TGradientLabel;
    importHouse: TAdvSmoothButton;
    exportHouse: TAdvSmoothButton;
    SaveDialogHouse: TSaveDialog;
    cmbPull: TComboBox;
    Label11: TLabel;
    edm_swTPID: TEdit;
    AdvToolBarButton8: TAdvToolBarButton;
    TpName: TLabel;
    TPnasp: TEdit;
    Label31: TLabel;
    edm_Gors: TEdit;
    MainMenu1: TMainMenu;
    ComboBox1: TComboBox;
    AdvProgressBar1: TAdvProgressBar;
    sbAbonImport: TAdvOfficeStatusBar;
    pbm_sBTIProgressImport: TAdvProgressBar;
    AdvToolBarButton10: TAdvToolBarButton;
    Label4: TLabel;
    GradientLabel2: TGradientLabel;
    lbm_snFirstKvartNumber: TLabel;
    lbm_snEndKvartNumber: TLabel;
    sem_snFirstKvartNumber: TSpinEdit;
    sem_snEndKvartNumber: TSpinEdit;
    lbm_snAmBal1: TLabel;
    lbm_snAmBal2: TLabel;
    lbm_snAmBal3: TLabel;
    lbm_nKvarUchType: TLabel;
    sem_snAmBal1: TSpinEdit;
    sem_snAmBal2: TSpinEdit;
    sem_snAmBal3: TSpinEdit;
    cbm_nKvarUchType: TComboBox;
    GradientLabel6: TGradientLabel;
    GradientLabel7: TGradientLabel;
    GradientLabel8: TGradientLabel;
    procedure OnSaveAbonSett(Sender: TObject);
    procedure OnGetAbonInfo(Sender: TObject);
    procedure OnCreateAbonSettings(Sender: TObject);
    procedure OnCreateAbonSettingsNewTree(Sender: TObject);
    procedure OnDelAbonSettings(Sender: TObject);
    procedure OnCreate(Sender: TObject);
    procedure OnDropPhChann(Sender, Source: TObject; X, Y: Integer);
    procedure OnActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure v_ReportListGetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure v_ReportListGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure v_ReportListCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure advSettAllRepClick(Sender: TObject);
    procedure cbHouseGenClick(Sender: TObject);
    procedure importHouseClick(Sender: TObject);
    procedure Replacement(Sender: TObject);

    procedure ReplacementHouse;
    procedure exportHouseClick(Sender: TObject);
    procedure OnDelTp(Sender: TObject);
    procedure importHouseTaskManager;
  private
    { Private declarations }
    m_nKSP          : TStringList;
    m_strCurrentDir : String;
    m_nCurrentUser  : Integer;
    m_pTable        : SL3ABONS;
    m_pL1Table      : SL1INITITAG;
    m_blHandStart   : Boolean;
    m_blOpenSession : Boolean;
    m_nTypeList     : TStringList;
    m_treeID        : CTreeIndex;
    FTreeModuleData : TTreeView;
    currPull        : Integer;
    procedure InitGenHouseType;
    procedure SetDefaultSett;
    procedure OnSaveAbonSettings;
    procedure OnGetAbonSettings;
    procedure SetAbonParam(Var pTable : SL3ABON;var state:Integer);
    procedure GetAbonParam(Var pTable : SL3ABON);
    function  GetReportVS() : Int64;
    function  GetTreeSettings : Int64;
    procedure OnGetRegion(Sender: TObject);
    procedure InitReportViews(pTbl : SL3ABON);
    procedure SetTreeSettings(_ts : Int64);
    function  GetNumbersFromStr(str: string):TStringList;
    procedure setCmbPull;
    procedure OnCreateAbonSettingsAddAbon;
  public
    destructor Destroy; override;
    function LoadAbonTP(TPID:integer):string;
    function PrepareAbon(nAbon : Integer;nPage:Integer):Boolean;
    procedure OnAddAbon;
    procedure OnAddAbonTree;
    function  GetAbonRevNumbers(ABOID : integer) : TStringList;
    procedure setTreeIndex(index:CTreeIndex);
    procedure importHouseTaskManagerL5;
    procedure setTreeData(value:TTreeView);
    { Public declarations }
    property PIndex      :Integer          read m_nCurrentUser       write m_nCurrentUser;
  end;

var
  TAbonManager: TTAbonManager;

implementation

{$R *.DFM}
procedure TTAbonManager.OnCreate(Sender: TObject);
begin
      m_nCurrentUser  := 0;
      currPull        := 0;
      m_nKSP          := TStringList.Create;
      m_nTypeList     := TStringList.Create;
      m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
      cbm_sbyEnable.items.loadfromfile(m_strCurrentDir+'Active.dat');
      cbm_sbyVisible.items.loadfromfile(m_strCurrentDir+'Active.dat');
      m_nCF.m_nSetColor.PAbonStyler := @AbonStyler;
      m_blHandStart   := False;
      m_blOpenSession := False;
      m_pDB.GetL1Table(m_pL1Table);
      InitGenHouseType;
end;

destructor TTAbonManager.Destroy;
begin
  FreeAndNil(m_nKSP);
  FreeAndNil(m_nTypeList);
  inherited;
end;

procedure TTAbonManager.setTreeIndex(index:CTreeIndex);
Begin
     m_treeID := index;
End;
procedure TTAbonManager.setTreeData(value:TTreeView);
Begin
     FTreeModuleData := value;
End;

procedure TTAbonManager.OnSaveAbonSett(Sender: TObject);
Begin
      OnSaveAbonSettings;
End;

procedure TTAbonManager.OnSaveAbonSettings;
Var
      pTable : SL3ABON;
      state:Integer;
Begin
      SetAbonParam(pTable,state);
      if state=1 then begin
      //m_pDB.addAbonId(pTable);
      //GetAbonParam(pTable);
      OnGetAbonInfo(self);
      end;
End;


procedure TTAbonManager.OnGetAbonSettings;
Begin
       //edm_swABOID.Text        := '-1';
       edm_swTPID.Text         := IntToStr(m_treeID.PTPS);
       //edm_sCount.Text         := '0';
       //cbm_swPortID.ItemIndex  := 0;
       edm_sdtRegDate.Text     := '';
       edm_sName.Text          := '';
       edm_sAddress.Text       := '';
       edM_SHOUSENUMBER.Text   := '1';
       edM_SKORPUSNUMBER.Text  := '1';
       cbm_sbyEnable.ItemIndex := 1;
       cbm_sbyVisible.ItemIndex := 1;
       //AbonAddress.InitComboBox;
End;

procedure TTAbonManager.SetAbonParam(Var pTable : SL3ABON;var state:Integer);
Var
    pAID  : Integer;
    m_nHouseGen : CHouseGen;
    pD  : CLoadEntity;
Begin
  state:=0;
  pD  := CLoadEntity.Create;
  if (TPnasp.Text='')then MessageDlg('Введите название ТП!', mtInformation, [mbOk], 0)
  else
   begin
      m_nHouseGen:= CHouseGen.Create;
      SetDefaultSett;
     with pTable do
      Begin
         m_swABOID      := StrToInt(edm_swABOID.Text);
         m_swPortID     := 0;
         m_sdtRegDate   := StrToDateTime(edm_sdtRegDate.Text);
         m_sName        := edm_sName.Text;
         m_sAddrSettings:= AbonAddress.GetABONAdrID;
         pD.tp     := TPnasp.Text;       //Передаем название ТП
         m_sAddress     := edm_sAddress.Text;
         m_sTelRing     := edm_TelToRing.Text;
         m_sbyEnable    := cbm_sbyEnable.ItemIndex;
         m_sbyVisible   := cbm_sbyVisible.ItemIndex;
         m_sReportVS    := GetReportVS();
         m_sTreeSettings:= GetTreeSettings;
         M_SHOUSENUMBER  := edM_SHOUSENUMBER.Text;
         M_SKORPUSNUMBER := edM_SKORPUSNUMBER.Text;
         state:=1;
         m_nHouseGen.Destroy;
         pAID        := m_pDB.addAbonId_SaveL3Abon(pTable); // Создает дом в группе и записывает в бд
         m_swABOID   := pAID;
         pD.Destroy;
      End;
   End;
End;
procedure TTAbonManager.GetAbonParam(Var pTable : SL3ABON);
Begin
      with pTable do
      Begin
       edm_swABOID.Text        := IntToStr(m_swABOID);
       edm_swTPID.Text         := IntToStr(TPID);
       TPnasp.Text:= LoadAbonTP(TPID);
       edm_sdtRegDate.Text     := DateTimeToStr(m_sdtRegDate);
       edm_sName.Text          := m_sName;
       edm_sAddress.Text       := m_sAddress;
       edm_TelToRing.Text      := m_sTelRing;
       cbm_sbyEnable.ItemIndex := m_sbyEnable;
       cbm_sbyVisible.ItemIndex:= m_sbyVisible;
       sbAbon.Panels.Items[0].Text := 'Текущий абонент : '+m_sName+'.';
       InitReportViews(pTable);
       edM_SHOUSENUMBER.Text   := M_SHOUSENUMBER;
       edM_SKORPUSNUMBER.Text  := M_SKORPUSNUMBER;
       edm_Gors.Text           := GORS;
       SetTreeSettings(m_sTreeSettings);
       //GetPhotoParam(pTable);
      End;
End;
procedure TTAbonManager.SetDefaultSett;
Begin
      if edm_swABOID.Text=''    then edm_swABOID.Text       := '-1';
      if edm_sdtRegDate.Text='' then edm_sdtRegDate.Text    := DateTimeToStr(Now);
      if edm_sName.Text=''      then edm_sName.Text         := 'Абонент:'+edm_swABOID.Text;
      if edm_sAddress.Text=''   then edm_sAddress.Text      := 'г.Минск ул.Буденого 11';
      if edm_TelToRing.Text=''  then edm_TelToRing.Text     := '80172302233';
      if cbm_sbyEnable.Text=''  then cbm_sbyEnable.ItemIndex:= 1;
      if cbm_sbyVisible.Text='' then cbm_sbyVisible.ItemIndex:= 1;
      if edM_SHOUSENUMBER.Text=''  then edM_SHOUSENUMBER.Text  := '1';
      if edM_SKORPUSNUMBER.Text='' then edM_SKORPUSNUMBER.Text := '1';
End;
procedure TTAbonManager.OnGetAbonInfo(Sender: TObject);
Var
    pTbl : SL3ABONS;
begin
    if m_treeID.PAID<>-1 then
    Begin
     if m_pDB.GetAbonTable(m_treeID.PAID,pTbl)=True then
     Begin
      GetAbonParam(pTbl.Items[0]);
      lbGenSettings.Caption := pTbl.Items[0].m_sName;
     End;
    End else
    Begin
      OnGetAbonSettings;
    End;
end;

function TTAbonManager.LoadAbonTP(TPID:integer):string;
begin
 Result:=m_pDB.AbonTpId(TPID);
end;

procedure TTAbonManager.OnCreateAbonSettings(Sender: TObject);
begin
      AbonAddress.LoadAbonFromID(m_treeID);
      edm_swABOID.Text        := '-1';
      edm_sdtRegDate.Text     := DateTimeToStr(Now);
      edm_sName.Text          := '';
      edm_sAddress.Text       := '';
      edm_TelToRing.Text      := '';
      TPnasp.Text             := '';
      cbm_sbyEnable.ItemIndex := 1;
      cbm_sbyVisible.ItemIndex := 1;
      edM_SHOUSENUMBER.Text   := '';
      edM_SKORPUSNUMBER.Text  := '';
      cbArchv.Checked := true;
      cbGraph.Checked := true;
      cbLimit.Checked := true;
      cbPeriod.Checked := true;
      cbCurrt.Checked := true;
      cbVecDg.Checked := true;
      cbChndg.Checked := true;
      cbEvents.Checked := true;
      cbRprts.Checked := true;
end;

procedure TTAbonManager.OnCreateAbonSettingsNewTree(Sender: TObject);
begin
      AbonAddress.LoadAbonFromID(m_treeID);
      edm_swABOID.Text        := '-1';
      edm_sdtRegDate.Text     := DateTimeToStr(Now);
      edm_sName.Text          := '';
      edm_sAddress.Text       := '';
      edm_TelToRing.Text      := '';
      TPnasp.Text             :=LoadAbonTP(m_treeID.PTPS);  // pID.PTPS;
      cbm_sbyEnable.ItemIndex := 1;
      cbm_sbyVisible.ItemIndex := 1;
      edM_SHOUSENUMBER.Text   := '';
      edM_SKORPUSNUMBER.Text  := '';
      cbArchv.Checked := true;
      cbGraph.Checked := true;
      cbLimit.Checked := true;
      cbPeriod.Checked := true;
      cbCurrt.Checked := true;
      cbVecDg.Checked := true;
      cbChndg.Checked := true;
      cbEvents.Checked := true;
      cbRprts.Checked := true;
end;

procedure TTAbonManager.OnAddAbonTree;
Begin
     OnCreateAbonSettingsNewTree(self);
End;

procedure TTAbonManager.OnAddAbon;
Begin
     OnCreateAbonSettings(self);
End;

procedure TTAbonManager.OnDelAbonSettings(Sender: TObject);
begin
      if MessageDlg('Удалить абонента '+edm_sName.Text+' ID:'+edm_swABOID.Text+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       //m_pDB.FixUspdDescEvent(0,3,EVU_DEL_ACCT,0);
       m_nCurrentUser := 0;
       if edm_swABOID.Text<>'-1' then
       m_pDB.DelAbonTable(StrToInt(edm_swABOID.Text));
       if m_pTable.Count<>0 then
       Begin
        OnGetAbonSettings;
       End else
       if m_pTable.Count=0 then OnGetAbonSettings;{OnCreateAbonSettings(self);}
      End;
end;

function TTAbonManager.GetReportVS() : Int64;
var
  i : Integer;
  l_State : Boolean;
  sh : int64;
begin
  Result := 0;
  sh := 1;
  for i:=0 to c_ReportsCount-1 do
  begin
    v_ReportList.GetCheckBoxState(2,i+1, l_State);
    if l_State then
      Result := Result OR (sh shl i);
  end;
end;

function TTAbonManager.GetTreeSettings : Int64;
var _1 : int64;
begin
   Result := 0;
   _1 := 1;
   if cbArchv.Checked then
     Result := Result + (_1 shl PD_ARCHV);
   if cbGraph.Checked then
     Result := Result + (_1 shl PD_GRAPH);
   if cbLimit.Checked then
     Result := Result + (_1 shl PD_LIMIT);
   if cbPeriod.Checked then
     Result := Result + (_1 shl PD_PERIO);
   if cbCurrt.Checked then
     Result := Result + (_1 shl PD_CURRT);
   if cbVecDg.Checked then
     Result := Result + (_1 shl PD_VECDG);
   if cbChndg.Checked then
     Result := Result + (_1 shl PD_CHNDG);
   if cbEvents.Checked then
     Result := Result + (_1 shl PD_EVENS);
   if cbRprts.Checked then
     Result := Result + (_1 shl PD_RPRTS);
end;

procedure TTAbonManager.OnDropPhChann(Sender, Source: TObject; X,
  Y: Integer);
begin
//     InitComboChannel;
end;

function TTAbonManager.PrepareAbon(nAbon : Integer;nPage:Integer):Boolean;
Var
    pTbl : SL3ABONS;
Begin
    try
    Result := False;
    if m_treeID.PAID<>-1 then
    Begin
     if m_pDB.GetAbonTable(m_treeID.PAID,pTbl)=True then
     Begin
      GetAbonParam(pTbl.Items[0]);
      lbGenSettings.Caption         := pTbl.Items[0].m_sName;
      aop_AbonPages.ActivePageIndex := nPage;
      Result := True;
     End;
    End else
    Begin
      OnGetAbonSettings;
      Result := True;
    End;
    except
      Result:=False;
    end;
end;
procedure TTAbonManager.OnActivate(Sender: TObject);
begin
    //TraceL(m_nLID,pMsg.m_swObjID,'(__)CL1MD::>NO CARRIER');
end;

procedure TTAbonManager.FormShow(Sender: TObject);
begin
   pbm_sBTIProgress.Position := 0;
//   setCmbPull;
end;

procedure TTAbonManager.OnGetRegion(Sender: TObject);
begin
end;

procedure TTAbonManager.InitReportViews(pTbl : SL3ABON);
var
  i : integer;
  sh : int64;
begin
  sh := 1;
  v_ReportList.RowCount := c_ReportsCount+1;
  v_ReportList.UnCheckAll(2);

  for i := 0 to c_ReportsCount - 1 do
  begin
    v_ReportList.Cells[0,i+1] := IntToStr(i+1);
    v_ReportList.Cells[1,i+1] := c_ReportsTitles[i].N;

    if (pTbl.m_sReportVS AND (sh shl i)) <> 0 then
    begin
      v_ReportList.Cells[2,i+1] := ' Виден';
      v_ReportList.AddCheckBox(2, i+1, True, false);
    end else
    begin
      v_ReportList.Cells[2,i+1] := ' Скрыт';
      v_ReportList.AddCheckBox(2, i+1, False, false);
    end;
  end;
end;

procedure TTAbonManager.SetTreeSettings(_ts : Int64);
var _1 : int64;
begin
   _1 := 1;
   if (_ts and (_1 shl PD_ARCHV)) <> 0 then
     cbArchv.Checked := true
   else
     cbArchv.Checked := false;
   if (_ts and (_1 shl PD_GRAPH)) <> 0 then
     cbGraph.Checked := true
   else
     cbGraph.Checked := false;
   if (_ts and (_1 shl PD_LIMIT)) <> 0 then
     cbLimit.Checked := true
   else
     cbLimit.Checked := false;
   if (_ts and (_1 shl PD_PERIO)) <> 0 then
     cbPeriod.Checked := true
   else
     cbPeriod.Checked := false;
   if (_ts and (_1 shl PD_CURRT)) <> 0 then
     cbCurrt.Checked := true
   else
     cbCurrt.Checked := false;
   if (_ts and (_1 shl PD_VECDG)) <> 0 then
     cbVecDg.Checked := true
   else
     cbVecDg.Checked := false;
   if (_ts and (_1 shl PD_CHNDG)) <> 0 then
     cbChndg.Checked := true
   else
     cbChndg.Checked := false;
   if (_ts and (_1 shl PD_EVENS)) <> 0 then
     cbEvents.Checked := true
   else
     cbEvents.Checked := false;
   if (_ts and (_1 shl PD_RPRTS)) <> 0 then
     cbRprts.Checked := true
   else
     cbRprts.Checked := false;
end;


function  TTAbonManager.GetNumbersFromStr(str: string):TStringList;
var i     : integer;
    ts    : string;
begin
   Result := TStringList.Create;
   Result.Clear;
   ts := '';
   for i := 1 to Length(str) do
   begin
     if str[i] = ',' then
     begin
       Result.Add(ts);
       ts := '';
       continue;
     end;       
     ts := ts + str[i];
   end;
   while Result.Count < 3 do
     Result.Add('-');
end;

function  TTAbonManager.GetAbonRevNumbers(ABOID : integer) : TStringList;
var i : integer;
begin
   Result := TStringList.Create;
   Result.Clear;
   for i := 0 to m_pTable.Count - 1 do
     if m_pTable.Items[i].m_swABOID = ABOID then
       Result := GetNumbersFromStr(m_pTable.Items[i].m_sRevPhone);
   while Result.Count < 3 do
     Result.Add('-');
end;

procedure TTAbonManager.v_ReportListGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 8;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
    if (ARow<>0) and (ACol<>0)then
     Begin
      if ACol<>0 then
      Begin
       //AFont.Color :=  m_blGridDataFontColor;//clAqua;
       AFont.Size  :=  m_blGridDataFontSize;
       AFont.Name  :=  m_blGridDataFontName;
       if (ACol=1) or (ACol=2) or (ACol=7) then AFont.Color := clBlack;
       if (ACol>=3) and (ACol<=6) then AFont.Color := clBlack;
      End;
     End;
    End;
end;

procedure TTAbonManager.v_ReportListGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
 case ACol of
    0,1 :
    Begin
      AEditor := edNone;
    End;
    2 :
    Begin
      AEditor := edCheckBox;
    End;
  end;
end;

procedure TTAbonManager.v_ReportListCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  if (ARow > 0) AND (ARow <= c_ReportsCount) then
  begin
    if State = true then
      v_ReportList.Cells[ACol,ARow] := ' Виден'
    else
      v_ReportList.Cells[ACol,ARow] := ' Скрыт';
  end;
end;
//      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdtBegin='+''''+DateTimeToStr(dtm_sdtBegin.DateTime)+'''');

procedure TTAbonManager.advSettAllRepClick(Sender: TObject);
begin
   m_pDB.SetAbonParam(-1,'m_sReportVS='+''''+IntToStr(GetReportVS)+'''');
end;


procedure TTAbonManager.cbHouseGenClick(Sender: TObject);
begin
    lbm_snFirstKvartNumber.Visible := (Sender as TCheckBox).Checked;
    lbm_snEndKvartNumber.Visible   := (Sender as TCheckBox).Checked;
    lbm_sHouseNumber.Visible       := (Sender as TCheckBox).Checked;
    lbm_sKorpusNumber.Visible      := (Sender as TCheckBox).Checked;
    lbm_snAmBal1.Visible           := (Sender as TCheckBox).Checked;
    lbm_snAmBal2.Visible           := (Sender as TCheckBox).Checked;
    lbm_snAmBal3.Visible           := (Sender as TCheckBox).Checked;
    lbm_sVmName.Visible            := (Sender as TCheckBox).Checked;
    lbm_nKvarUchType.Visible       := (Sender as TCheckBox).Checked;
    lbHouseGenLabel.Visible        := (Sender as TCheckBox).Checked;
    sem_snFirstKvartNumber.Visible := (Sender as TCheckBox).Checked;
    sem_snEndKvartNumber.Visible   := (Sender as TCheckBox).Checked;
    edm_sHouseNumber.Visible       := (Sender as TCheckBox).Checked;
    edm_sKorpusNumber.Visible      := (Sender as TCheckBox).Checked;
    edm_sVmName.Visible            := (Sender as TCheckBox).Checked;
    sem_snAmBal1.Visible           := (Sender as TCheckBox).Checked;
    sem_snAmBal2.Visible           := (Sender as TCheckBox).Checked;
    sem_snAmBal3.Visible           := (Sender as TCheckBox).Checked;
    cbm_nKvarUchType.Visible       := (Sender as TCheckBox).Checked;

    //Инициализация
    sem_snFirstKvartNumber.Value   := 1;
    sem_snEndKvartNumber.Value     := 1;
    sem_snAmBal1.Value             := 1;
    sem_snAmBal2.Value             := 0;
    sem_snAmBal3.Value             := 0;
    edm_sHouseNumber.Text          := '1';
    edm_sKorpusNumber.Text         := '1';
end;

procedure TTAbonManager.InitGenHouseType;
Var
    pTable : QM_METERS;
    i : Integer;
Begin
    if m_pDB.GetMetersTypeTable(pTable) then
    Begin
     cbm_nKvarUchType.Items.Clear;
     m_nTypeList.Clear;
     for i:=0 to pTable.m_swAmMeterType-1 do
     Begin
      cbm_nKvarUchType.Items.Add(pTable.m_sMeterType[i].m_sName);
      m_nTypeList.Add(pTable.m_sMeterType[i].m_sName);
     End;
     cbm_nKvarUchType.ItemIndex  := m_nTypeList.IndexOf('MET_STKVER16');
    End;
End;

procedure TTAbonManager.importHouseClick(Sender: TObject);
begin
  try
   importHouse.Enabled:=false;
   importHouseTaskManager;
  finally
   importHouse.Enabled:=true;
  end;
end;

procedure TTAbonManager.Replacement(Sender: TObject);
begin
  try
   ReplacementHouse;
  finally
   MessageDlg('Замена счетчика завершена.',mtWarning,[mbOk],0);
  end;
end;

procedure TTAbonManager.importHouseTaskManager;
Var
     m_nHouseGen : CHouseGen;
     res         : boolean;
begin
     OpenDialog1.Filter := 'Text files (*.csv)|*.csv;*.*';
     if OpenDialog1.Execute then
     if FileExists(OpenDialog1.FileName) then
     begin
      if (MAX_ABON<=m_pDB.GetAbonMax)then
        begin
         MessageDlg('Ошибка максимально доспустимое число объектов!',mtWarning,[mbOk],0);
         exit;
        end;
       m_nHouseGen := CHouseGen.Create;
       m_nHouseGen.PsbAbonImport           := sbAbonImport;
       m_nHouseGen.Ppbm_sBTIProgressImport := pbm_sBTIProgressImport;
       res:=m_nHouseGen.loadHouseFromFile(cmbPull.ItemIndex,m_treeID,OpenDialog1.FileName);
       if (res<>true)then
         MessageDlg('Ошибка при загрузке шаблона, проверьте файл шаблона!',mtWarning,[mbOk],0);
       m_nHouseGen.InitTreeRef; //Автообновление дерева
       m_nHouseGen.Destroy;//протестировать
     end;
end;

procedure TTAbonManager.importHouseTaskManagerL5;
Var
     m_nHouseGen : CHouseGen;
     res         : boolean;
begin
     OpenDialog1.Filter := 'Text files (*.csv)|*.csv;*.*';
     if OpenDialog1.Execute then
     if FileExists(OpenDialog1.FileName) then
     begin
      if (MAX_ABON<=m_pDB.GetAbonMax)then
        begin
         MessageDlg('Ошибка максимально доспустимое число объектов!',mtWarning,[mbOk],0);
         exit;
        end;
       m_nHouseGen := CHouseGen.Create;
       m_nHouseGen.PsbAbonImport           := sbAbonImport;
       m_nHouseGen.Ppbm_sBTIProgressImport := pbm_sBTIProgressImport;
       res:=m_nHouseGen.loadHouseFromFile(cmbPull.ItemIndex,m_treeID,OpenDialog1.FileName);
       if (res<>true)then
         MessageDlg('Ошибка при загрузке шаблона, проверьте файл шаблона!',mtWarning,[mbOk],0);
       m_nHouseGen.InitTreeRef; //Автообновление дерева
       m_nHouseGen.Destroy;//протестировать
     end;
end;

procedure TTAbonManager.ReplacementHouse;
Var
     m_nHouseGen : CHouseGen;
begin
     OpenDialog1.Filter := 'Text files (*.csv)|*.csv;*.*';
     if OpenDialog1.Execute then
     if FileExists(OpenDialog1.FileName) then
     begin
       m_nHouseGen := CHouseGen.Create;
       if cmbPull.ItemIndex<>-1 then
       begin
      // m_nHouseGen.PsbAbonImport           := sbAbonImport;
       m_nHouseGen.Ppbm_sBTIProgressImport := pbm_sBTIProgressImport;
       m_nHouseGen.loadReplacementHouse(cmbPull.ItemIndex,m_treeID,OpenDialog1.FileName);
       m_nHouseGen.InitTreeRef; //Автообновление дерева
       m_nHouseGen.Destroy;//протестировать
       end
       else
       MessageDlg('Необходимо указать пулл портов!',mtWarning,[mbOk,mbCancel],0);
     end;
end;


procedure TTAbonManager.exportHouseClick(Sender: TObject);
Var
     m_nHouseGen : CHouseGen;
begin
    m_nHouseGen := CHouseGen.Create;
    SaveDialogHouse.Filter := 'Text files (*.csv)|*.csv;*.*';
    SaveDialogHouse.DefaultExt := 'csv';
    SaveDialogHouse.Execute;    //TSaveDialog
    if SaveDialogHouse.FileName<>'' then
    m_nHouseGen.unLoadHouseFromDb(true,m_treeID.PAID, SaveDialogHouse.FileName);
    if (m_nHouseGen<>Nil)then FreeAndNil(m_nHouseGen);//m_nHouseGen.Destroy;//протестировать
end;

procedure TTAbonManager.setCmbPull;
Var
    pDb        : CDBDynamicConn;
    pullConfig : TThreadList;
    vList      : TList;
    pl         : CL2Pulls;
    i          : integer;
begin
    pDb  := m_pDB.getConnection;
    pullConfig := TThreadList.Create;
    pDb.getPulls(pullConfig);
    vList := pullConfig.LockList;
    cmbPull.Items.Clear;
    for i:=0 to vList.count-1 do
    Begin
     pl := vList[i];
     cmbPull.Items.Add('['+IntToStr(pl.id)+']'+pl.PULLTYPE+'/'+pl.DESCRIPTION);
    End;
    if cmbPull.Items.Count>0 then cmbPull.ItemIndex := 0;
    pullConfig.UnLockList;
    m_pDB.DiscDynConnect(pDb);
    ClearListAndFree(pullConfig);
end;

procedure TTAbonManager.OnDelTp(Sender: TObject);
begin
    //if MessageDlg('Удалить ТП ID:'+edm_swTPID.Text+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    if MessageDlg('Удалить ТП :'+TPnasp.text+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
      //m_pDB.FixUspdDescEvent(0,3,EVU_DEL_ACCT,0);
      m_nCurrentUser := 0;
      if edm_swTPID.Text<>'-1' then
      m_pDB.DelTpTable(StrToInt(edm_swTPID.Text));
      //if m_pTable.Count<>0 then
      //Begin
      // OnGetAbonSettings;
      //End else
      //if m_pTable.Count=0 then OnGetAbonSettings;{OnCreateAbonSettings(self);}
    End;
end;


procedure TTAbonManager.OnCreateAbonSettingsAddAbon;
begin
      AbonAddress.LoadAbonFromID(m_treeID);
      edm_swABOID.Text        := '-1';
      edm_sdtRegDate.Text     := DateTimeToStr(Now);
      edm_sName.Text          := '';
      edm_sAddress.Text       := '';
      edm_TelToRing.Text      := '';
      TPnasp.Text             := '';
      cbm_sbyEnable.ItemIndex := 1;
      cbm_sbyVisible.ItemIndex := 1;
      edM_SHOUSENUMBER.Text   := '';
      edM_SKORPUSNUMBER.Text  := '';
      cbArchv.Checked := true;
      cbGraph.Checked := true;
      cbLimit.Checked := true;
      cbPeriod.Checked := true;
      cbCurrt.Checked := true;
      cbVecDg.Checked := true;
      cbChndg.Checked := true;
      cbEvents.Checked := true;
      cbRprts.Checked := true;
end;

end.
