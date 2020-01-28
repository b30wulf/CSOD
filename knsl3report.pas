unit knsl3report;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RbDrawCore, RbButton, ComCtrls, ImgList, ToolWin, StdCtrls, jpeg,AdvGlowButton,
  ExtCtrls, Grids, BaseGrid, AdvGrid,  Db, ADODB,utlexparcer,
  DBCtrls, IniFiles,
  Dates,
  utlconst,
  utltypes,
  utldatabase,
  utlTimeDate,
  knsl5config,
  utlbox, AdvOfficePager, AdvOfficePagerStylers, AdvToolBar,
  AdvToolBarStylers, AdvPanel, AdvAppStyler, AdvProgr,
  AdvOfficeButtons,
  Menus, AdvMenus, AdvSplitter, Mask, AdvEdit, AdvGroupBox, AdvMenuStylers,
  rtflabel,
  knslRPHomeBalance,
  knslRPErrorMeterRegion,
  knslRPErrorMeterRegionHouse,
  knslRPPokMetersXL,
  knslRPAnalisBalansObj;
type
  tyRepDate  = String;
  TTRepPower = class(TForm)
    imgDataView: TImageList;
    ColorDialog1: TColorDialog;
    ImageListRep1: TImageList;
    pcReport: TAdvOfficePager;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    ReportPanelStyler: TAdvPanelStyler;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    tbShowReport: TAdvToolBarButton;
    tbSave: TAdvToolBarButton;
    tbInExcel: TAdvToolBarButton;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    tshCurrVals: TAdvOfficePage;
    FsgStatistics: TAdvStringGrid;
    tshOptions: TAdvOfficePage;
    Label1: TLabel;
    Edit1: TEdit;
    Label9: TLabel;
    Edit4: TEdit;
    Label13: TLabel;
    Edit8: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label12: TLabel;
    Edit7: TEdit;
    Label11: TLabel;
    Edit6: TEdit;
    Label10: TLabel;
    Edit5: TEdit;
    Label14: TLabel;
    Edit9: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    cbIsReadZeroTar1: TCheckBox;
    cbTarifRp: TComboBox;
    cbKindRP: TComboBox;
    cbGroup: TComboBox;
    cbYear: TComboBox;
    dtEnd: TDateTimePicker;
    cbKindEnerg: TComboBox;
    cbMonth: TComboBox;
    dtBegin: TDateTimePicker;
    ReportFormStyler1: TAdvFormStyler;
    Label4: TLabel;
    Edit10: TEdit;
    Label6: TLabel;
    Edit11: TEdit;
    Shape1: TShape;
    Label5: TLabel;
    Shape2: TShape;
    Label8: TLabel;
    cb_AP: TAdvOfficeCheckBox;
    cb_AM: TAdvOfficeCheckBox;
    cb_RP: TAdvOfficeCheckBox;
    v_lblCaption: TLabel;
    Label7: TLabel;
    edm_strObjCode: TEdit;
    cb_Precision: TComboBox;
    cbVectorTime: TComboBox;
    cb_WithKT: TCheckBox;
    pmTechYchetMTZ: TAdvPopupMenu;
    miCheckPins: TMenuItem;
    miUncheckPins: TMenuItem;
    pmMaxPowerSaveData: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N1: TMenuItem;
    cb_RM: TAdvOfficeCheckBox;
    ProgressBar1: TAdvProgress;
    edFilter: TEdit;
    lb_L2KoncPassw: TLabel;
    tshHomeBalanse: TAdvOfficePage;
    tshAnalisBalansObj: TAdvOfficePage;
    AdvOfficeRadioGroup1: TAdvOfficeRadioGroup;
    tshErrorMeterRegion: TAdvOfficePage;
    tshErrorReportDay: TAdvOfficePage;
    DateTimePicker_Err: TDateTimePicker;
    RTFLabel1: TRTFLabel;
    AdvProgress1: TAdvProgress;
    RTFLabel2: TRTFLabel;
    RTFLabel4: TRTFLabel;
    AdvProgress3: TAdvProgress;
    sgHomeBalanse: TAdvStringGrid;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    tbShowReport2: TAdvToolBarButton;
    AdvOfficePage1: TAdvOfficePage;
    BalanceCheckBox: TCheckBox;
    BalanseDateTimePicker1: TDateTimePicker;
    BalanseDateTimePicker2: TDateTimePicker;
    BalanceLabel1: TLabel;
    BalanceLabel2: TLabel;

    procedure OnCloseRep(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FsgVMetersGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure cbMonthChange(Sender: TObject);
    procedure cbYearChange(Sender: TObject);
    procedure pcReportChange(Sender: TObject);
    procedure tbShowReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FsgMaxControlGetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure FsgMaxControlDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FSGRasxEnergMonthDrawCell(Sender : TObject; ACol,
      ARow: Integer; Rect : TRect; State: TGridDrawState);
       procedure FSGExpenseDayDrawCell(Sender : TObject; ACol,
  ARow: Integer; Rect : TRect; State: TGridDrawState);
    procedure FsgUsingGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure FindItemRasxEnerg(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FindItemCalcMoney(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure OnFormResize1(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbGroupChange(Sender: TObject);
    procedure cbKindRPChange(Sender: TObject);

    procedure cbKindEnergChange(Sender: TObject);
    procedure FindItemSizeEnergy(Sender: TObject; ACol, ARow: Integer;
                                 Rect: TRect; State: TGridDrawState);
    procedure FindItemMozTeplo(Sender: TObject; ACol, ARow: Integer;
                                          Rect: TRect; State: TGridDrawState);
    procedure ToolButtonXlReport(Sender: TObject);
    procedure dtEndChange(Sender: TObject);
    procedure dtBeginChange(Sender: TObject);
    procedure FsgGraphDayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure OnClickVedom(Sender: TObject; ARow, ACol: Integer);
    procedure cb_APClick(Sender: TObject);
    procedure cb_AMClick(Sender: TObject);
    procedure cb_RPClick(Sender: TObject);
    procedure cb_RMClick(Sender: TObject);
    procedure sgMaxPowerGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure sgSummVedomGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure edFilterChange(Sender: TObject);
    procedure tbShowReport2Click(Sender: TObject);
    procedure BalanceCheckBoxClick(Sender: TObject);

    
  private
    GroupsIndexes : array [0..MAX_GROUP] of integer;
    ReportSettings: REPORT_F1;
    m_pDDB        : PCDBDynamicConn;
    m_nEVL        : CEvaluator;
    FABOID        : integer;
    FCURREP       : integer;
    m_nRow        : Integer;
    m_nCol        : Integer;
    bEnergMask    : Byte;
    RPABO : RPAnalisBalansObj;
    m_RPMaxDay2_Created : Boolean;
    RPEMR : RPErrorMeterRegion;
    RPEMH : RPErrorMeterRegionHouse;
    procedure LoadSettings;
    procedure LoadGroups;
    procedure LoadPokGroups;
    procedure LoadTarif;
    procedure ShowPickers;
    procedure HidePickers;
    procedure ShowEnergyCombo;
    procedure HideEnergyCombo;
    procedure LoadParamsToRPok;
    procedure LoadParamsToRPokXL;
    procedure LoadParamsOptions;
    procedure LoadParamsToHomeBalanse;
    procedure LoadParamsToAnalisBalansObj;
    procedure LoadParamsToErrorMeterRegion;
    procedure LoadParamsToErrorReportDay;

     /////Excel
    procedure LoadReportSettings();
    procedure DefaultSettings;
    procedure SetAbon;
    procedure SetActiveFilter(var sg: TAdvStringGrid; filter : string);
    procedure DeleteFilter(var sg: TAdvStringGrid);
    procedure VisibleOfficePager(page : Integer; value : Boolean);  // -1 Все закладки
    procedure SetActivePageAndTabs;
    procedure VisibleTBButton(Btn : TAdvToolBarButton; value : Boolean);    // -1 Все значения
  public
    Year             : Integer;
    Month            : Integer;
    Day              : Integer;
    RCNFG            : RepCONFIG;
    ItemIndMaxCtrl   : Integer;
    ItemIndRasxEnerg : Integer;
    ItemIndCalcMoney : Integer;
    ItemIndRasxMonth : Integer;
    ItemIndExpenseDay: Integer;
    ItemIndSizeEnergy: Integer;
    ItemIndGraphDay  : Integer;
    ItemIndMozTeplo  : Integer;
    RepType          : Integer;
    strRepDate       : tyRepDate;
    IDRegion         : Integer;
    IDDepartament    : Integer;
    NameRegion       : string;
    NameDepartament  : string;
    PIID             : Integer;     
    //m_nCurrReport
    procedure Init;
    procedure PrepareForm;
    function  getRCNFG  : RepCONFIG;
    procedure RefreshHigthGrid(nHigth:Integer);
    procedure SetActivePage;
    procedure CreateRPError(RegId:integer; RegName : string);
   public
    property PABOID : integer          read FABOID       write FABOID;
    property PCURREP: integer          read FCURREP      write FCURREP;
  end;
var
  TRepPower       : TTRepPower;
  blConnect       : Boolean;  //False - соединение разорвано
  tblVMeter       : SL3VMETERTAG;
  blCreateReport  : Boolean;
implementation

uses knslRPPokMeters;

{$R *.DFM}
procedure TTRepPower.FormCreate(Sender: TObject);
begin
    m_nEVL := CEvaluator.Create;
    ReportFormCrete := True;
    LoadSettings;
end;

procedure TTRepPower.SetActivePage;
Begin
  SetActivePageAndTabs;
  VisibleTBButton(nil, false);
    if m_nCurrReport<pcReport.AdvPageCount then
    if PIID = 88 then begin
      if pcReport.ActivePageIndex=6 then pcReportChange(self)
      else pcReport.ActivePageIndex := 6;
    end else begin
     if pcReport.ActivePageIndex=FCURREP then pcReportChange(self)
     else pcReport.ActivePageIndex := FCURREP;
    end;
End;
procedure TTRepPower.Init;
begin
    m_nCol := -1;
    m_nRow := -1;
    DefaultSettings;
    dtBegin.DateTime := Now;
    dtEnd.DateTime   := Now;
    SetAbon;
    SetActivePageAndTabs;
    strRepDate := RCNFG.GetText;
    Edit1.Text := ReportSettings.m_sWorkName;
    Edit2.Text := ReportSettings.m_sFirstSign;
    Edit3.Text := ReportSettings.m_sSecondSign;
    Edit4.Text := ReportSettings.m_sTelephon;
    Edit5.Text := ReportSettings.m_sEMail;
    Edit6.Text := ReportSettings.m_sNDogovor;
    Edit7.Text := ReportSettings.m_sThirdSign;
    Edit8.Text := ReportSettings.m_sNameObject;
    Edit9.Text := ReportSettings.m_sAdress;
    Edit10.Text := ReportSettings.KSP;
    Edit11.Text := IntToStr(ReportSettings.ABO);
    edm_strObjCode.Text := ReportSettings.m_strObjCode;

    Shape1.Brush.Color := ReportSettings.m_swColorRow;
    Shape2.Brush.Color := ReportSettings.m_swColorCol;
    if ReportSettings.m_sbyIsReadZerT = 1 then
     cbIsReadZeroTar1.Checked := true
    else
     cbIsReadZeroTar1.Checked := false;

   BalanseDateTimePicker1.DateTime:=Now;
   BalanseDateTimePicker2.DateTime:=Now;
   BalanceCheckBox.Visible := false;
   BalanseDateTimePicker1.Visible := False;
   BalanseDateTimePicker2.Visible := False;
end;
procedure TTRepPower.SetAbon;
Begin
    m_pDDB := m_pDB.DynConnect(0);
    if rpPokMeters<>Nil      then Begin rpPokMeters.PDB      := m_pDDB; rpPokMeters.PABOID    := PABOID; End;
    if rpHomeBalanse<>nil    then begin rpHomeBalanse.DatabaseLink := m_pDDB; rpHomeBalanse.AbonenID     := PABOID; end;
End;

procedure TTRepPower.OnCloseRep(Sender: TObject; var Action: TCloseAction);
begin
     if RPABO<>Nil then FreeAndNil(RPABO);
     if RPEMR<>Nil then FreeAndNil(RPEMR);
     FreeAndNil(m_nEVL);
     FreeAndNil(RCNFG);
     ReportFormCrete := False;
     Action := caFree;
end;

procedure TTRepPower.LoadSettings;
var
     mCL: SCOLORSETTTAG;
begin
     m_nCF.m_nSetColor.PSgStatistics       := @FSgStatistics;
     m_nCF.m_nSetColor.PPageRp             := @pcReport;
     m_nCF.m_nSetColor.psgHomeBalanse      := @sgHomeBalanse;
     m_nCF.m_nSetColor.PReportStyler       := @ReportFormStyler1;
     mCL.m_swCtrlID := CL_TREE_CONF;
     m_pDB.GetColorTable(mCL);
     nSizeFont := mCL.m_swFontSize;
     m_nCF.m_nSetColor.SetFontSize(nSizeFont);
     m_nCF.m_nSetColor.SetReportHigthGrid(nSizeFont+17);
     m_nCF.m_nSetColor.SetReportColorFont(mCL.m_swColor);
     m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex);
end;
procedure TTRepPower.RefreshHigthGrid(nHigth:Integer);
Begin
   m_nCF.m_nSetColor.SetReportHigthGrid(nSizeFont+17);
End;

procedure TTRepPower.LoadGroups;
var i      : integer;
    Groups : SL3INITTAG;
begin
   cbGroup.Clear;
   //if m_pDDB.GetGroupsTable(Groups) then
   if m_pDDB.GetAbonGroupsTable(FABOID,Groups) then
   begin
     cbGroup.Items.Add('Все группы');
     GroupsIndexes[0] := - 1;
     for i := 0 to Groups.Count - 1 do
     begin
       cbGroup.Items.Add('Группа: ' +  Groups.Items[i].m_sGroupName);
       GroupsIndexes[i + 1] := Groups.Items[i].m_sbyGroupID;
     end;
   end;
   cbGroup.ItemIndex := 0;
end;
procedure TTRepPower.LoadPokGroups;
var i      : integer;
    Groups : SL3INITTAG;
begin
   cbGroup.Clear;
   //if m_pDDB.GetGroupsTable(Groups) then
   if m_pDDB.GetAbonGroupsLVTable(FABOID,0,Groups) then
   begin
     cbGroup.Items.Add('Все группы');
     GroupsIndexes[0] := - 1;
     for i := 0 to Groups.Count - 1 do
     begin
       cbGroup.Items.Add('Группа: ' +  Groups.Items[i].m_sGroupName);
       GroupsIndexes[i + 1] := Groups.Items[i].m_sbyGroupID;
     end;
   end;
   cbGroup.ItemIndex := 0;
end;

procedure TTRepPower.LoadTarif;
var
  i                 : integer;
  m_pTariffs        : TM_TARIFFSS;
      
begin
   cbTarifRp.Clear;
   if m_pDB.GetTMTarifsTable(0,0,0,m_pTariffs) then
   begin
     cbTarifRp.Items.Add('Выберите тариф');
     GroupsIndexes[0] := - 1;
    for i := 0 to m_pTariffs.Count-1  do
    cbTarifRp.Items.Add(m_pTariffs.Items[i].m_sName);
   end;
 cbTarifRp.ItemIndex := 0;
end;

procedure TTRepPower.FsgUsingGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTRepPower.FsgMaxControlGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTRepPower.FsgVMetersGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTRepPower.LoadReportSettings();
Var
   pTable:SL3ABONS;
begin
   if m_pDB.LoadReportParams(FABOID,ReportSettings)=False then
   Begin
    if m_pDB.GetAbonTable(FABOID,pTable)=True then
    Begin
     ReportSettings.m_sbyIsReadZerT := 0;
     ReportSettings.m_swABOID     := FABOID;
     ReportSettings.m_sWorkName   := pTable.Items[0].m_sName;
     ReportSettings.m_sFirstSign  := Edit2.Text;
     ReportSettings.m_sSecondSign := Edit3.Text;
     ReportSettings.m_sTelephon   := pTable.Items[0].m_sPhone;
     ReportSettings.m_sEMail      := pTable.Items[0].m_sEAddress;
     ReportSettings.m_sNDogovor   := pTable.Items[0].m_sDogNum;
     ReportSettings.m_sThirdSign  := Edit7.Text;
     ReportSettings.m_swColorRow  := Shape1.Brush.Color;
     ReportSettings.m_swColorCol  := Shape2.Brush.Color;
     ReportSettings.m_sNameObject := pTable.Items[0].m_sObject;
     ReportSettings.m_sAdress     := pTable.Items[0].m_sAddress;
     ReportSettings.KSP           := pTable.Items[0].m_sKSP;
     ReportSettings.m_strObjCode  := 'A0000001';
     //if Edit11.Text <> '' then
     ReportSettings.ABO           := pTable.Items[0].m_swABOID;
    End;
   End;
end;

procedure TTRepPower.ShowPickers;
begin
   dtBegin.Visible := true;
   dtEnd.Visible   := true;
end;

procedure TTRepPower.HidePickers;
begin
   dtBegin.Visible := false;
   dtEnd.Visible   := false;
end;

procedure TTRepPower.ShowEnergyCombo;
begin
   cb_AP.Visible := true;
   cb_AM.Visible := true;
   cb_RP.Visible := true;
   cb_RM.Visible := true;
end;

procedure TTRepPower.HideEnergyCombo;
begin
   cb_AP.Visible := false;
   cb_AM.Visible := false;
   cb_RP.Visible := false;
   cb_RM.Visible := false;
end;

procedure TTRepPower.LoadParamsToRPok;
begin
   rpPokMeters.WorksName  := Edit1.Text;
   rpPokMeters.FirstSign  := Edit2.Text;
   rpPokMeters.SecondSign := Edit3.Text;
   rpPokMeters.Telephon   := Edit4.Text;
   rpPokMeters.EMail      := Edit5.Text;
   rpPokMeters.ThirdSign  := Edit7.Text;
   rpPokMeters.NameObject := Edit8.Text;
   rpPokMeters.Adress     := Edit9.Text;
   rpPokMeters.m_strObjCode := edm_strObjCode.Text;
   cbMonth.Visible        := true;
   cbYear.Visible         := true;
   cbGroup.Visible        := true;
   cbKindRP.Visible       := false;
   cbTarifRp.Visible      := false;
   cbKindEnerg.Visible    := true;
   VisibleTBButton(tbShowReport, true);
   VisibleTBButton(tbSave, true);
   VisibleTBButton(tbInExcel, true);
   HidePickers;
   HideEnergyCombo;
end;

procedure TTRepPower.LoadParamsToRPokXL;
begin
   rpPokMetersXL.WorksName  := Edit1.Text;
   rpPokMetersXL.FirstSign  := Edit2.Text;
   rpPokMetersXL.SecondSign := Edit3.Text;
   rpPokMetersXL.Telephon   := Edit4.Text;
   rpPokMetersXL.EMail      := Edit5.Text;
   rpPokMetersXL.ThirdSign  := Edit7.Text;
   rpPokMetersXL.NameObject := Edit8.Text;
   rpPokMetersXL.Adress     := Edit9.Text;
   rpPokMetersXL.KodObj     := Edit11.Text;
   rpPokMetersXL.prGroupID  := GroupsIndexes[cbGroup.ItemIndex];
end;

procedure TTRepPower.LoadParamsOptions;
Begin
   cbMonth.Visible       := false;
   cbYear.Visible        := false;
   cbGroup.Visible       := false;
   cbKindRP.Visible      := false;
   cbTarifRp.Visible     := false;
   cbKindEnerg.Visible   := false;
   VisibleTBButton(tbShowReport, true);
   HidePickers;
   HideEnergyCombo;
End;

procedure TTRepPower.LoadParamsToHomeBalanse();
begin
   rpHomeBalanse.AbonentName    := Edit1.Text;
   rpHomeBalanse.Contract       := Edit6.Text;
   rpHomeBalanse.ObjectName     := Edit8.Text;
   rpHomeBalanse.AbonentAddress := Edit9.Text;
   rpHomeBalanse.ObjectNumber   := edm_strObjCode.Text;
   rpHomeBalanse.ObjectAddress  := Edit9.Text;
   rpHomeBalanse.UseZeroTariff  := cbIsReadZeroTar1.Checked;
   rpHomeBalanse.prGroupID     := GroupsIndexes[cbGroup.ItemIndex];

   cbKindEnerg.Visible    := false;
   cbMonth.Visible        := true;
   cbYear.Visible         := true;
   cbGroup.Visible        := true;
   cbKindRP.Visible       := false;
   cbTarifRp.Visible      := false;
   BalanceCheckBox.Visible := True;
   BalanceCheckBox.Checked := False;
   BalanseDateTimePicker1.Visible := False;
   BalanseDateTimePicker2.Visible := False;
   rpHomeBalanse.DaylyBalance := False;

   VisibleTBButton(tbShowReport, true);
   VisibleTBButton(tbSave, true);
   VisibleTBButton(tbInExcel, true);
   HidePickers;
   ShowEnergyCombo;
end;
//----------------------------------------------------------------
procedure TTRepPower.LoadParamsToAnalisBalansObj();
begin
   cbKindEnerg.Visible    := true;
   cbMonth.Visible        := true;
   cbYear.Visible         := true;
   cbGroup.Visible        := false;
   cbKindRP.Visible       := false;
   cbTarifRp.Visible      := false;
   HidePickers;
   HideEnergyCombo;
   VisibleTBButton(tbShowReport, true);
   lb_L2KoncPassw.Visible := false;
   edFilter.Visible := false;
end;
//----------------------------------------------------------------
procedure TTRepPower.LoadParamsToErrorMeterRegion();
begin
   cbKindEnerg.Visible    := true;
   cbMonth.Visible        := true;
   cbYear.Visible         := true;
   cbGroup.Visible        := false;
   cbKindRP.Visible       := false;
   cbTarifRp.Visible      := false;
   HidePickers;
   HideEnergyCombo;
   //BorderIcons := BorderIcons - [biMaximize];
   //tbShowReport.Visible := false;

   VisibleTBButton(tbShowReport, true);
   VisibleTBButton(tbShowReport2, true);
   lb_L2KoncPassw.Visible := false;
   edFilter.Visible := false;
   AdvProgress3.Min := 0;
   AdvProgress3.Max := 10000;
   AdvProgress3.Position := 0;
end;
//----------------------------------------------------------------
procedure TTRepPower.LoadParamsToErrorReportDay();
begin
   cbKindEnerg.Visible    := false;
   cbMonth.Visible        := false;
   cbYear.Visible         := false;
   cbGroup.Visible        := false;
   cbKindRP.Visible       := false;
   cbTarifRp.Visible      := false;
   HidePickers;
   DateTimePicker_Err.DateTime := Now;
   HideEnergyCombo;

   //BorderIcons := BorderIcons - [biMaximize];
   //tbShowReport.Visible := false;

   VisibleTBButton(tbShowReport, true);

   lb_L2KoncPassw.Visible := false;
   edFilter.Visible := false;
   AdvProgress1.Min := 0;
   AdvProgress1.Max := 10000;
   AdvProgress1.Position := 0;
end;
//----------------------------------------------------------------

procedure TTRepPower.cbMonthChange(Sender: TObject);
begin
   Month := cbMonth.ItemIndex+1;
   RCNFG.Month := Month;
end;

procedure TTRepPower.cbYearChange(Sender: TObject);
begin
   Year := StrToInt(cbYear.Text);
   RCNFG.Year := Year;
end;

procedure TTRepPower.DefaultSettings;
begin
  cbMonth.ItemIndex := 0;
  cbYear.ItemIndex  := 0;
  RCNFG := RepCONFIG.Init(1,cbMonth.ItemIndex+1,StrToInt(cbYear.text));
  LoadReportSettings;
end;

procedure TTRepPower.pcReportChange(Sender: TObject);
var y, m, d : word;
begin
   SetAbon;
   //LoadGroups;
   tbShowReport.Hint   := 'Создать отчет';
   if pcReport.ActivePage = tshCurrVals then  // текущие показания
   Begin
    LoadParamsToRPok;
    DecodeDate(Now, y, m, d);
    //cbMonth.ItemIndex := m - 1;
    rpPokMeters.prGroupID  := GroupsIndexes[cbGroup.ItemIndex];
    rpPokMeters.PsgGrid    := @FsgStatistics;
    rpPokMeters.PrepareTable;
    m_nCF.m_nSetColor.SetReportHigthGrid(nSizeFont+17);
   End;
   if pcReport.ActivePage = tshOptions then    // настройки
   Begin
     LoadParamsOptions;
     tbShowReport.Hint := 'Сохранить данные';
   End;
   //---------------------------------------------------
    if pcReport.ActivePage = tshErrorMeterRegion then   // отчет о неопрошенных счетчиках на конец месяца
   Begin
     LoadParamsToErrorMeterRegion;
     if (RPEMR<>Nil)then FreeAndNil(RPEMR);
     RPEMR :=  RPErrorMeterRegion.Create();
     RPEMR.setAbonData(PABOID,m_pDDB);
     tbShowReport.Hint  := 'Отчет по региону (' + NameRegion + ')';
     tbShowReport2.Hint := 'Отчет по департаменту (' + NameDepartament + ')';
   End;
   //---------------------------------------------------
  if pcReport.ActivePage = tshErrorReportDay then  // отчет о неопрошенных счетчиках за день
   Begin
     LoadParamsToErrorMeterRegion;
     if (RPEMR<>Nil)then FreeAndNil(RPEMR);
     RPEMR :=  RPErrorMeterRegion.Create();
     RPEMR.setAbonData(PABOID,m_pDDB);
    // LoadParamsToErrorReportDay;
    // RPEMH :=  RPErrorMeterRegionHouse.Create();
    // RPEMH.setAbonData(PABOID,m_pDDB);
   End
  else
   if pcReport.ActivePage = tshHomeBalanse then    // Балланс по дому
   begin
    LoadParamsToHomeBalanse();
    cb_AP.Checked := True;
    cb_AM.Checked := False;
    cb_RP.Checked := False;
    cb_RM.Checked := False;
    bEnergMask    := $01;
    // LoadPokGroups;
    rpHomeBalanse.Grid      := @sgHomeBalanse;
    rpHomeBalanse.prGroupID := GroupsIndexes[cbGroup.ItemIndex];
    DecodeDate(Now, y, m, d);
    // cbMonth.ItemIndex := m - 1;
    rpHomeBalanse.PrepareTable();
    m_nCF.m_nSetColor.SetReportHigthGrid(nSizeFont + 17);
   end
  else
  if pcReport.ActivePage = tshAnalisBalansObj then
   Begin
     if (RPABO<>Nil)then FreeAndNil(RPABO);
     LoadParamsToAnalisBalansObj;
     RPABO :=  RPAnalisBalansObj.Create();
     RPABO.setAbonData(PABOID,m_pDDB);
   End;
end;

function TTRepPower.getRCNFG : RepCONFIG;
begin
   Result := RCNFG;
end;
//ToolButtonXlReport
procedure TTRepPower.tbShowReportClick(Sender: TObject);
var Year, Month, Day,nowYear, nowMonth, nowDay, selectMonth : word;
    TempDate         : TDateTime;
    CountTable       : integer;
    KindEnerg, IsTariffs,MonthEx,YearEx: Integer;
begin
  try
  if m_blIsBackUp=True then
  Begin
    MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
    exit;
  End;

  Year     := StrToInt(cbYear.Items[cbYear.ItemIndex]);
  Month    := cbMonth.ItemIndex + 1;
  Day      := cDateTimeR.DayPerMonth(Month, Year);
  TempDate := EncodeDate(Year, Month, Day);
   //----------------------------------------------------------------------
  if pcReport.ActivePage = tshErrorMeterRegion then
   Begin
     KindEnerg := cbKindEnerg.ItemIndex+21;    //21,22,23,24
     MonthEx   := cbMonth.ItemIndex+1;
     YearEx    := StrToInt(cbYear.Text);
     DecodeDate(Now, nowYear, nowMonth, nowDay);
      if (MonthEx >= nowMonth) and (YearEx=nowYear) then
      begin
       MessageDLG('Указанный месяц не окончен', mterror, [mbOK], 0);
       exit;
      end;
     if RPEMR=nil then RPEMR :=  RPErrorMeterRegion.Create(); 
     RPEMR.IDRegion := IDRegion;
     RPEMR.IDDepartament := IDDepartament;
     RPEMR.NameRegion := NameRegion;
     RPEMR.NameDepartament := NameDepartament;
     RPEMR.TypeDR := 0;
     AdvProgress3.Position := 0;
     RPEMR.createErrorReport(MonthEx,YearEx,KindEnerg,'',AdvProgress3,true);
     if (RPEMR<>Nil)then FreeAndNil(RPEMR);
   End;

   if pcReport.ActivePage = tshCurrVals then
   begin
     if rpPokMeters <> nil then  FreeAndNil(rpPokMeters); //rpPokMeters.Destroy;
     rpPokMeters            := TrpPokMeters.Create(Application);
     rpPokMeters.PABOID     := PABOID;
     rpPokMeters.PDB        := m_pDDB;
     rpPokMeters.PsgGrid    := @FsgStatistics;
     rpPokMeters.KindEnergy := cbKindEnerg.ItemIndex;
     LoadParamsToRPok;
     rpPokMeters.PrintPreview({FsgUsing,} TempDate);
   end;
   //---------------------------------------------------------------------
   if pcReport.ActivePage = tshErrorReportDay then
   Begin
   {
   if  DateTimePicker_Err.DateTime>Now then
   begin
   MessageDLG('Некоректная дата', mterror, [mbOK], 0);
   exit;
   end;
  // DecodeDate(Now, nowYear, nowMonth, nowDay);
   DecodeDate(DateTimePicker_Err.DateTime, nowYear, selectMonth, nowDay);
   KindEnerg := cbKindEnerg.ItemIndex+QRY_NAK_EN_DAY_EP;
   AdvProgress1.Position := 0;
   RPEMH.createErrorReport(PABOID,selectMonth,nowYear,KindEnerg,DateToStr(DateTimePicker_Err.DateTime),AdvProgress1,false);
   }
  

   KindEnerg := cbKindEnerg.ItemIndex+17;    //17,18,19,20
   DecodeDate(Now, nowYear, nowMonth, nowDay);
   if  DateTimePicker_Err.DateTime > Now then begin
     MessageDLG('Некоректная дата', mterror, [mbOK], 0);
     exit;
   end;
   RPEMR.IDRegion := IDRegion;
   RPEMR.IDDepartament := IDDepartament;
   RPEMR.NameRegion := NameRegion;
   RPEMR.NameDepartament := NameDepartament;
   RPEMR.TypeDR := 0;
   AdvProgress3.Position := 0;
   RPEMR.createErrorReport(MonthEx,YearEx,KindEnerg,DateToStr(DateTimePicker_Err.DateTime),AdvProgress3,true);
   if (RPEMR<>Nil)then FreeAndNil(RPEMR);
   End;
   //---------------------------------------------------------------------

  if pcReport.ActivePage = tshHomeBalanse then
   begin
     if rpHomeBalanse <> nil then  FreeAndNil(rpHomeBalanse);//rpHomeBalanse.Destroy;
     rpHomeBalanse              := TRPHomeBalanse.Create(Application);
     rpHomeBalanse.AbonenID     := PABOID;
     rpHomeBalanse.DatabaseLink := m_pDDB;
     rpHomeBalanse.Grid         := @sgHomeBalanse;
     rpHomeBalanse.Evaluator    := m_nEVL;
     rpHomeBalanse.bEnergMask   := bEnergMask;
     LoadParamsToHomeBalanse;
     rpHomeBalanse.Grid         := @sgHomeBalanse;
     rpHomeBalanse.prGroupID    := GroupsIndexes[cbGroup.ItemIndex];
     rpHomeBalanse.PrepareTable();
     m_nCF.m_nSetColor.SetReportHigthGrid(nSizeFont + 17);
     rpHomeBalanse.PrintPreview(TempDate);
   end;
  if pcReport.ActivePage = tshAnalisBalansObj then
   Begin
     if (RPABO<>Nil)then begin
      FreeAndNil(RPABO);
      LoadParamsToAnalisBalansObj;
      RPABO :=  RPAnalisBalansObj.Create();
      RPABO.setAbonData(PABOID,m_pDDB);
     end
     else
       begin
        LoadParamsToAnalisBalansObj;
        RPABO :=  RPAnalisBalansObj.Create();
        RPABO.setAbonData(PABOID,m_pDDB);
       end;
     IsTariffs :=AdvOfficeRadioGroup1.ItemIndex;
     KindEnerg := cbKindEnerg.ItemIndex+21;    //21,22,23,24
     MonthEx   := cbMonth.ItemIndex+1;
     YearEx    := StrToInt(cbYear.Text);

     RPABO.createBalansReport(MonthEx,YearEx,KindEnerg,IsTariffs);
     if (RPABO<>Nil)then FreeAndNil(RPABO);
   End;
   except
    
   end;
end;

procedure TTRepPower.FormShow(Sender: TObject);
//var Year, Month, Day, i : word;
begin
   bEnergMask := $0F;
end;

procedure TTRepPower.PrepareForm;
var
    Year, Month, Day, i : word;
Begin
    OnFormResize1(self);
    LoadGroups;
    cb_Precision.Visible := false;
    cb_Precision.ItemIndex := 3;
    cb_WithKT.Visible    := false;
    cb_WithKT.Checked    := true;
    cbVectorTime.Visible := false;
    m_RPMaxDay2_Created := false;

    case FCURREP of
         1,4,8,9,12,13,17,19:LoadPokGroups;
    End;
    
    if FCURREP<=pcReport.AdvPageCount-1 then
    begin
      pcReport.AdvPages[FCURREP].TabEnabled := True;
      pcReport.AdvPages[FCURREP].TabVisible := True;
      Self.Caption         := Self.Caption + ':' + pcReport.AdvPages[FCURREP].Caption;
      //v_lblCaption.Caption := pcReport.AdvPages[FCURREP].Caption;
    end;
    LoadTarif;
    DecodeDate(Now, Year, Month, Day);
    i    := Month - 1;
    if i = 0 then
      cbMonth.ItemIndex := 1;
    if i = $FFFF then
    begin
      cbMonth.ItemIndex := 12;
      Dec(Year);
    end;
    cbYear.Items[2]   := IntToStr(Year);
    cbYear.Items[1]   := IntToStr(Year - 1);
    cbYear.Items[0]   := IntToStr(Year - 2);
    cbYear.ItemIndex  := 2;
    cbMonth.ItemIndex := i;
    cbKindEnerg.ItemIndex := 0;
    cbGroup.ItemIndex     := 0;
    cbKindRP.ItemIndex    := 0;
    //pcReportChange(self);
    LoadSettings;
End;

procedure TTRepPower.FsgMaxControlDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndMaxCtrl := ARow;
end;
procedure TTRepPower.FSGExpenseDayDrawCell(Sender : TObject; ACol,
  ARow: Integer; Rect : TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndExpenseDay := ARow;
end;
procedure TTRepPower.FSGRasxEnergMonthDrawCell(Sender : TObject; ACol,
  ARow: Integer; Rect : TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndRasxMonth := ARow;
end;

procedure TTRepPower.FsgGraphDayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndGraphDay := ARow;
end;


procedure TTRepPower.FindItemRasxEnerg(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndRasxEnerg := ARow;
end;

procedure TTRepPower.FindItemCalcMoney(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndCalcMoney := ARow;
end;
procedure TTRepPower.FindItemSizeEnergy(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndSizeEnergy := ARow;
end;

procedure TTRepPower.FindItemMozTeplo(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if gdSelected in State then
     ItemIndMozTeplo  := ARow;
end;

procedure TTRepPower.OnFormResize1(Sender: TObject);
begin
    cbKindEnerg.Left := pcReport.Width - 10  - cbKindEnerg.Width;
    cbYear.Left      := cbKindEnerg.Left - cbYear.WIdth  - 5;
    cbMonth.Left     := cbYear.Left      - cbMonth.WIdth - 5;
    cbGroup.Left     := cbMonth.Left     - cbGroup.Width - 5;
    cbTarifRp.Left   := cbGroup.Left     - cbTarifRp.Width - 45;
    cbKindRP.Left    := cbMonth.Left     - cbKindRP.Width - 5;
    dtBegin.Left     := cbMonth.Left;
    dtEnd.Left       := cbYear.Left;

    BalanseDateTimePicker2.Left := pcReport.Width - 380;
    BalanceLabel2.Left := BalanseDateTimePicker2.Left - 20;
    BalanseDateTimePicker1.Left := BalanceLabel2.Left - 110;
    BalanceLabel1.Left := BalanseDateTimePicker1.Left - 60;


end;

procedure TTRepPower.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if ColorDialog1.Execute then
     Shape1.Brush.Color := ColorDialog1.Color;
end;

procedure TTRepPower.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if ColorDialog1.Execute then
     Shape2.Brush.Color := ColorDialog1.Color;
end;

procedure TTRepPower.cbGroupChange(Sender: TObject);
begin
   pcReportChange(Owner);
end;

procedure TTRepPower.cbKindRPChange(Sender: TObject);
begin
   pcReportChange(Owner);
end;

procedure TTRepPower.cbKindEnergChange(Sender: TObject);
begin
   //pcReportChange(Owner);
end;

procedure TTRepPower.ToolButtonXlReport(Sender: TObject);
var Year, Month, Day : word;
    TempDate         : TDateTime;
    CountTable       : integer;
    //buttonSelected   : Integer;
begin
    if m_blIsBackUp=True then
    Begin
     MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
   Year     := StrToInt(cbYear.Items[cbYear.ItemIndex]);
   Month    := cbMonth.ItemIndex + 1;
   Day      := cDateTimeR.DayPerMonth(Month, Year);
   TempDate := EncodeDate(Year, Month, Day);

   if pcReport.ActivePage = tshHomeBalanse then   //Баланс по дому
   begin
      rpHomeBalanse.bEnergMask:= bEnergMask;
      rpHomeBalanse.DaylyDate1 := BalanseDateTimePicker1.Date;
      rpHomeBalanse.DaylyDate2 := BalanseDateTimePicker2.Date;
      rpHomeBalanse.CreateExcelReport(TempDate);
    end;
   if pcReport.ActivePage = tshCurrVals then
   begin
     if rpPokMetersXl <> nil then  FreeAndNil(rpPokMetersXl); //rpPokMeters.Destroy;
     rpPokMetersXl            := TrpPokMetersXl.Create();           // jkljkl
     rpPokMetersXl.PABOID     := PABOID;
     rpPokMetersXl.PProgress  := @ProgressBar1;
     rpPokMetersXl.KindEnergy := cbKindEnerg.ItemIndex;
     tshOptions.visible := True;
     LoadParamsToRPokXL;
     rpPokMetersXl.CreatReport(TempDate);
     if rpPokMetersXl <> nil then  FreeAndNil(rpPokMetersXl); //rpPokMeters.Destroy;     
   end;
end;

procedure TTRepPower.dtEndChange(Sender: TObject);
begin
    if dtEnd.DateTime < dtBegin.DateTime then
       dtBegin.DateTime := dtEnd.DateTime;
end;

procedure TTRepPower.dtBeginChange(Sender: TObject);
begin
  if dtBegin.DateTime > dtEnd.DateTime    then
       dtEnd.DateTime := dtBegin.DateTime;
end;

procedure TTRepPower.OnClickVedom(Sender: TObject; ARow, ACol: Integer);
begin
    m_nCol := -1;
    m_nRow := -1;
    if (ARow<>0)and(ACol<>0) then
    Begin
     m_nCol := ACol;
     m_nRow := ARow;
    End;
end;

procedure TTRepPower.cb_APClick(Sender: TObject);
begin
   if cb_AP.Checked then
     bEnergMask := bEnergMask or $01
   else if (bEnergMask and $0E) <> 0 then
     bEnergMask := bEnergMask and $0E
   else
     cb_AP.Checked := true;
end;

procedure TTRepPower.cb_AMClick(Sender: TObject);
begin
   if cb_AM.Checked then
     bEnergMask := bEnergMask or $02
   else if (bEnergMask and $0D) <> 0 then
     bEnergMask := bEnergMask and $0D
   else
     cb_AM.Checked := true;
end;


procedure TTRepPower.cb_RPClick(Sender: TObject);
begin
   if cb_RP.Checked then
     bEnergMask := bEnergMask or $04
   else if (bEnergMask and $0B) <> 0 then
     bEnergMask := bEnergMask and $0B
   else
     cb_RP.Checked := true;
end;

procedure TTRepPower.cb_RMClick(Sender: TObject);
begin
   if cb_RM.Checked then
     bEnergMask := bEnergMask or $08
   else if (bEnergMask and $07) <> 0 then
     bEnergMask := bEnergMask and $07
   else
     cb_RM.Checked := true;
end;


procedure TTRepPower.sgMaxPowerGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
   case ACol of
     0,1,4 :
     begin
       AEditor := edNone;
     end;
     2 :
     begin
       AEditor := edCheckBox;
     end;
   end;
end;

procedure TTRepPower.sgSummVedomGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
   case ACol of
     0, 1 :
     begin
       AEditor := edNone;
     end;
     2 :
     begin
       AEditor := edCheckBox;
     end;
   end;
end;


procedure TTRepPower.edFilterChange(Sender: TObject);
begin
   if Length(edFilter.Text) <= 0 then
   begin
     if pcReport.ActivePage = tshCurrVals then
       DeleteFilter(FsgStatistics)
     else if pcReport.ActivePage = tshHomeBalanse then
       DeleteFilter(sgHomeBalanse);
   end
   else
   begin
     if pcReport.ActivePage = tshCurrVals then
       SetActiveFilter(FsgStatistics, edFilter.Text) else
     if (pcReport.ActivePage = tshHomeBalanse) then
       SetActiveFilter(sgHomeBalanse, edFilter.Text);
   end;
end;

procedure TTRepPower.SetActiveFilter(var sg: TAdvStringGrid; filter : string);
begin
   try 
   sg.FilterActive := false;
   if sg.Filter = nil then
     sg.Filter := TFilter.Create(sg);
   sg.Filter.Clear;
   sg.Filter.Add;
   sg.Filter.Items[0].CaseSensitive := false;
   sg.Filter.Items[0].Column := 1;
   sg.Filter.Items[0].Condition := '*' + edFilter.Text + '*';
   sg.FilterActive := true;
   except
   end
end;

procedure TTRepPower.DeleteFilter(var sg: TAdvStringGrid);
begin
   if sg.RowCount=1 then exit;
   try
   sg.FilterActive := false;
   if sg.Filter = nil then
     sg.Filter := TFilter.Create(sg);
   sg.Filter.Clear;
   sg.Filter.Add;
   sg.Filter.Items[0].Column := 1;
   sg.Filter.Items[0].Condition := '*';
   sg.FilterActive := true;
   except
   end
end;

procedure TTRepPower.CreateRPError(RegId:integer; RegName : string);
var
Year, Month, Day: word;
KindEnerg: Integer;
begin
{     m_pDDB := m_pDB.DynConnect(0);
     RPEMH :=  RPErrorMeterRegionHouse.Create();
     RPEMH.setRegionData(RegId,m_pDDB);

     DecodeDate(Now, Year, Month, Day);
     KindEnerg := QRY_NAK_EN_DAY_EP;
     AdvProgress1.Position := 0;
     RPEMH.createErrorReport(0,Month,Year,KindEnerg,DateToStr(Now - 1),AdvProgress1,true);          }
    m_pDDB := m_pDB.DynConnect(0);
    KindEnerg := QRY_NAK_EN_DAY_EP;
    DecodeDate(Now, Year, Month, Day);
    if RPEMR = nil then RPEMR := RPErrorMeterRegion.Create;
    RPEMR.IDRegion := RegId;
    RPEMR.NameRegion := RegName;
    RPEMR.TypeDR := 0;
    AdvProgress3.Position := 0;
    RPEMR.createErrorReport(Month,Year,KindEnerg,DateToStr(Now - 1),AdvProgress1, false);
    if RPEMR<>Nil then FreeAndNil(RPEMR);
end;


procedure TTRepPower.tbShowReport2Click(Sender: TObject);
var Year, Month, Day,nowYear, nowMonth, nowDay, selectMonth : word;
    TempDate         : TDateTime;
    CountTable       : integer;
    KindEnerg, IsTariffs,MonthEx,YearEx: Integer;
begin
   if pcReport.ActivePage = tshErrorMeterRegion then
   Begin
     KindEnerg := cbKindEnerg.ItemIndex+21;    //21,22,23,24
     MonthEx   := cbMonth.ItemIndex+1;
     YearEx    := StrToInt(cbYear.Text);
     DecodeDate(Now, nowYear, nowMonth, nowDay);
      if (MonthEx >= nowMonth) and (YearEx=nowYear) then
      begin
       MessageDLG('Указанный месяц не окончен', mterror, [mbOK], 0);
       exit;
      end;
     if RPEMR=nil then RPEMR :=  RPErrorMeterRegion.Create();      
     RPEMR.IDRegion := IDRegion;
     RPEMR.IDDepartament := IDDepartament;
     RPEMR.NameRegion := NameRegion;
     RPEMR.NameDepartament := NameDepartament;
     RPEMR.TypeDR := 1;
     AdvProgress3.Position := 0;
     RPEMR.createErrorReport(MonthEx,YearEx,KindEnerg,'',AdvProgress3,true);
   End;
end;

procedure TTRepPower.VisibleOfficePager(page: Integer; value: Boolean);
var i : Integer;
begin
  if page < 0 then begin
    for i := 0 to pcReport.AdvPageCount-1 do begin
      pcReport.AdvPages[i].Visible := value;
      pcReport.AdvPages[i].TabVisible := value;
    end;
  end else begin
    pcReport.AdvPages[page].Visible := value;
    pcReport.AdvPages[page].TabVisible := value;
  end;
end;

procedure TTRepPower.SetActivePageAndTabs;
begin
  VisibleOfficePager(-1, false);
  VisibleOfficePager(FCURREP, true);
  pcReport.ActivePageIndex := FCURREP;
  case FCURREP of
    1 : begin  // текущие показания
      VisibleOfficePager(2, true);
    end;
  end;

end;

procedure TTRepPower.VisibleTBButton(Btn : TAdvToolBarButton; value: Boolean);
begin
  if (Btn = nil) then begin
    tbShowReport.Visible:= value;
    tbShowReport2.Visible:=value;
    tbSave.Visible:=False;
    tbInExcel.Visible:=False;
  end else Btn.Visible:=value;
end;

procedure TTRepPower.BalanceCheckBoxClick(Sender: TObject);
begin
  rpHomeBalanse.DaylyBalance := not rpHomeBalanse.DaylyBalance;
  if rpHomeBalanse.DaylyBalance then begin
    BalanseDateTimePicker1.Visible := true;
    BalanseDateTimePicker2.Visible := true;
    BalanceLabel1.Visible := True;
    BalanceLabel2.Visible := True;
    cbMonth.Visible := False;
    cbYear.Visible := False;
    cbGroup.Visible := False;
  end else begin
    BalanseDateTimePicker1.Visible := false;
    BalanseDateTimePicker2.Visible := false;
    BalanceLabel1.Visible := false;
    BalanceLabel2.Visible := false;
    cbMonth.Visible := true;
    cbYear.Visible := true;
    cbGroup.Visible := true;
  end;
end;

end.
