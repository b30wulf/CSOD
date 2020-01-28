unit frmTreeDataModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AdvPanel, ComCtrls, treelist, utlDB, ImgList, utlconst, utlbox,
  Menus, AdvMenus, XLSFile, XLSFormat, XLSWorkbook, StdCtrls, utltypes,
  AdvCombo, AdvGlassButton, AdvMenuStylers, AdvToolBar, AdvGlowButton,
  ToolWin, utlAddTreeView, Buttons, formEditTreeView;

type
  TREPV = class
    TreeSettings   : int64;
    ReportVS       : int64;
  end;

  TNodeData = class
    ID    : integer;  // собственно ID объекта
    OW    : TTreeNode;  // владелец
    Code  : byte;     // код узла SD_XXXXX см. ниже
    REPV  : TREPV;
  end;

  TArrByte = class
    SWPARAMID    : byte;
    SBLSAVED     : byte;
    SBLCALCULATE : byte;
  end;

{  SD_ABONT                     = 0;   Абонент
  SD_PRIMT                     = 1;
  SD_GROUP                     = 2;    Группа ?
  SD_VMETR                     = 3;
  SD_VPARM                     = 4;
  SD_REPRT                     = 5;    Отчеты
  SD_EVENS                     = 6;
  SD_REGIN                     = 8;    Регион
  SD_CLUST                     = 9;
  SD_RAYON                     = 10;   Район
  SD_TOWNS                     = 11;   Город
  SD_STRET                     = 12;   Улица
  SD_QGRUP                     = 13;   Группа опроса
  SD_QGSRV                     = 14;
  SD_QGSOS                     = 15;
  SD_QGPAR                     = 16;
  SD_QGCOM                     = 17;
  SD_TPODS                     = 18;   ТП
  SD_APART                     = 19;   квартиры
  SD_APNUM                     = 20;   //Собственно сами квартиры по номерам
  SD_RRP01                     = 21;   //Отчеты (Мощность)
  SD_RRP02                     = 22;   //Отчеты (Энергия)
  SD_RRP03                     = 23;   //Отчеты (Показания)
  SD_RRP04                     = 24;   //Отчеты (Диагностические)
  SD_RRP05                     = 25;   //Отчеты (Учет тепла)
  SD_RRP06                     = 26;   //Отчеты (Стоимость)
  SD_RRP07                     = 27;   //Отчеты (Настройки)
  SD_RRP08                     = 28;   //Отчеты (резерв)
  SD_RRP09                     = 29;   //Отчеты (резерв)
  SD_EVNTA                     = 30    //События по дому
  SD_ARCHV                     = 32;   //Архивы
  SD_GRAPH                     = 33;   //Графики
  SD_LIMIT                     = 7;    //Лимиты
  SD_PERIO                     = 35;   //Периодические
  SD_CURRT                     = 36;   //Текущие
  SD_VECDG                     = 37;   //Векторная диаграмма
  SD_CHNDG                     = 38;   //Замены
  SD_EVNTH                     = 39;   //События по квартире
    }

  TRefreshType = (rtNone, rtOnlyRefresh, rtDelete, rtAddNew);

  TframeTreeDataModule = class(TFrame)
    BtnPanel: TAdvPanel;
    AdvPanelStyler: TAdvPanelStyler;
    mnuTreeData: TAdvPopupMenu;
    mnuInclInQuery: TMenuItem;
    mnuExclFromQuery: TMenuItem;
    mnuDisableAll: TMenuItem;
    N117: TMenuItem;
    mnuSearchData: TMenuItem;
    N120: TMenuItem;
    mnuPollAll: TMenuItem;
    mnuPollObjectByPattern: TMenuItem;
    N81: TMenuItem;
    mnuReportEdit: TMenuItem;
    mnuAbonEdit: TMenuItem;
    N127: TMenuItem;
    mnuControlConnect: TMenuItem;
    mnuControlDisconnect: TMenuItem;
    N91: TMenuItem;
    mnuObjectTreeManagement: TMenuItem;
    mnuAddObject: TMenuItem;
    mnuDeleteMeter: TMenuItem;
    N77: TMenuItem;
    mnuOpenTransit: TMenuItem;
    mnuCloseTransit: TMenuItem;
    N84: TMenuItem;
    mnuAddQryServer: TMenuItem;
    mnuAddGueryGroup: TMenuItem;
    mnuExportNodeToExcel: TMenuItem;
    ImgListTree: TImageList;
    AdvGlassButton1: TAdvGlassButton;
    TreeList: TTreeView;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    ImageList: TImageList;
    SearchListBox: TListBox;
    SearchButton: TSpeedButton;
    SearchBox: TEdit;
    btnRefresh: TAdvGlowButton;
    ReportCorrect: TMenuItem;
    procedure TreeListExpanded(Sender: TObject; Node: TTreeNode);
    procedure FrameResize(Sender: TObject);
    procedure TreeListClick(Sender: TObject);
    procedure TreeListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuExportNodeToExcelClick(Sender: TObject);
    procedure mnuAddGueryGroupClick(Sender: TObject);
    procedure mnuAbonEditClick(Sender: TObject);
    procedure SearchBoxChange(Sender: TObject);
    procedure mnuObjectTreeManagementClick(Sender: TObject);
    procedure mnuAddObjectClick(Sender: TObject);
    procedure SearchListBoxClick(Sender: TObject);
    procedure SearchListBoxExit(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure TreeListCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure TreeListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
    procedure TreeListAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure ReportCorrectClick(Sender: TObject);
  private
    NodeData       : TNodeData;
    Old_Region     : integer;
    Old_Depart     : integer;
    Old_Town       : integer;
    Old_TP         : integer;
    Old_Street     : integer;
    Node_Region    : TTreeNode;
    Node_Depart    : TTreeNode;
    Node_Town      : TTreeNode;
    Node_TP        : TTreeNode;
    Node_Street    : TTreeNode;
    CurrentFindRow : integer;
    REPV           : TREPV;
    MM, EM, PM, DM : int64;
    UM, SM, NM, OM : int64;
    ListAB         : TList;
    AutoExpand     : Boolean;
    PressCtrl      : Boolean;
    _name1         : string;
    _name2         : string;
    _name3         : string;
    function CreateNodeData(ID: integer; nNode: TTreeNode;
             code: byte; REPV : TREPV): TNodeData;
    function CreateREPV(TS,RV : int64) : TREPV;
    procedure CreateNodeReport(ID : integer; Node : TTreeNode;
              SDR : integer; index : integer; REPV : TREPV);
    procedure CreateNodeParam(ID : integer; Node : TTreeNode;
              code : byte;  Name : string; index : integer);
    procedure ListABClear;
    procedure GetApartByHouse(ID : integer; Node: TTreeNode);
    procedure GetReportsByType(ID : integer; Node: TTreeNode);
    procedure GetQueryGroup(ID : integer; Node: TTreeNode);
    function IfIsChildNodeItem(Node : TTreeNode; s : string): TTreeNode;
    procedure MnuAllVisible(val : boolean);
    function GetNodeToExcel(Id, level:Integer; var WB:TSheet; var sNode : string):Boolean;
    function GetOneParamFromID(ID, code: integer): integer;
    function SetCGDataSourceNill:CGDataSource;
    function SetTreeIndex(CDS : CGDataSource; PTIM, PTSD, PNID, PRID, PRYD, PTWN, PTPS, PSTR,
          PAID, PGID, PQGD, PQPR, PVID, PCID, PPID, PMID, PTID, PSID, PDID, PKey, FKey, PIID, PSTT : Integer) : CGDataSource;
    procedure SettingReportData(ID : integer; var CodeID, PosID : integer);
    procedure ExpandChilds(node: TTreeNode);
    procedure CollapseChilds(node: TTreeNode);
    procedure FirstNill;
  public
    procedure init;
    procedure final;
    procedure GetTreeView;
    procedure Clear;
    procedure ClearNode(node: TTreeNode);
    procedure DragNDrop(IDDest : integer);
    procedure preRefresh;
    procedure Refresh(rt : TRefreshType; value : string);
    procedure RefreshByID;
    procedure RefreshGroupByID;
    function FindNode(code : byte; ID : integer):TTreeNode;    
  end;

//var frameTreeDataModule : TframeTreeDataModule;
var GroupListBox : TStringList;

implementation

{$R *.DFM}

 {$DEFINE TESTMODE1} 

uses ShellAPI,
{$IFDEF TESTMODE}
  TreeDataModuleForm, utldatabase, knsl5module, frmEditTreeView,
  formEditTreeView;
{$ELSE}
  knsl5module, utldatabase, knsl2fqwerymdl, knsl2treehandler,
  knsl3LimitEditor, knsl3abon, knsl4secman, knsl3chandge, AdvStyleIF,
  knsl5events,knslRepCorrects;
{$ENDIF}


var  TreeListBox : TStringList;

function TframeTreeDataModule.SetCGDataSourceNill:CGDataSource;
var CDS : CGDataSource;
begin
  CDS.trPTND:=nil;
  CDS.trTRI.PTIM:=-1;  CDS.trTRI.PTSD:=-1;  CDS.trTRI.PNID:=-1;  CDS.trTRI.PRID:=-1;
  CDS.trTRI.PRYD:=-1;  CDS.trTRI.PTWN:=-1;  CDS.trTRI.PTPS:=-1;  CDS.trTRI.PSTR:=-1;
  CDS.trTRI.PAID:=-1;  CDS.trTRI.PGID:=-1;  CDS.trTRI.PQGD:=-1;  CDS.trTRI.PQPR:=-1;
  CDS.trTRI.PVID:=-1;  CDS.trTRI.PCID:=-1;  CDS.trTRI.PPID:=-1;  CDS.trTRI.PMID:=-1;
  CDS.trTRI.PTID:=-1;  CDS.trTRI.PSID:=-1;  CDS.trTRI.PDID:=-1;  CDS.trTRI.PKey:=-1;
  CDS.trTRI.FKey:=-1;  CDS.trTRI.PIID:=-1;  CDS.trTRI.PSTT:=0;   CDS.trTRI.PTND:=nil;
  CDS.strCaption:='';  CDS.strClassName:='';
  CDS.dtTime0:=Now;
  CDS.dtTime1:=0;  CDS.nViewID:=0;  CDS.nHeight:=0; CDS.nWidth:=0;
  CDS.pOwner:=nil;
  Result:=CDS;
end;

function TframeTreeDataModule.SetTreeIndex(CDS : CGDataSource; PTIM, PTSD, PNID, PRID, PRYD, PTWN, PTPS, PSTR,
          PAID, PGID, PQGD, PQPR, PVID, PCID, PPID, PMID, PTID, PSID, PDID, PKey, FKey, PIID, PSTT : Integer) : CGDataSource;
begin
  CDS.trTRI.PTIM:=PTIM;  CDS.trTRI.PTSD:=PTSD;  CDS.trTRI.PNID:=PNID;  CDS.trTRI.PRID:=PRID;
  CDS.trTRI.PRYD:=PRYD;  CDS.trTRI.PTWN:=PTWN;  CDS.trTRI.PTPS:=PTPS;  CDS.trTRI.PSTR:=PSTR;
  CDS.trTRI.PAID:=PAID;  CDS.trTRI.PGID:=PGID;  CDS.trTRI.PQGD:=PQGD;  CDS.trTRI.PQPR:=PQPR;
  CDS.trTRI.PVID:=PVID;  CDS.trTRI.PCID:=PCID;  CDS.trTRI.PPID:=PPID;  CDS.trTRI.PMID:=PMID;
  CDS.trTRI.PTID:=PTID;  CDS.trTRI.PSID:=PSID;  CDS.trTRI.PDID:=PDID;  CDS.trTRI.PKey:=PKey;
  CDS.trTRI.FKey:=FKey;  CDS.trTRI.PIID:=PIID;  CDS.trTRI.PSTT:=PSTT;
  Result:=CDS;
end;

// ***********************************
// Инициализация, финализация
// ***********************************

procedure TframeTreeDataModule.init;
var i : integer;
    m_strCurrentDir : string;
begin
{$IFDEF TESTMODE}
  UserPermission:=TUserPermission.Create;
  UserPermission.GetUserData(5);
{$ENDIF}

  FirstNill;
{  for i:= 0 to c_ReportsCount-1 do begin
    if c_ReportsTitles[i].G='Мощность'       then MM := MM or (OM shl i);
    if c_ReportsTitles[i].G='Энергия'        then EM := EM or (OM shl i);
    if c_ReportsTitles[i].G='Показания'      then PM := PM or (OM shl i);
    if c_ReportsTitles[i].G='Диагностические'then DM := DM or (OM shl i);
    if c_ReportsTitles[i].G='Учет тепла'     then UM := UM or (OM shl i);
    if c_ReportsTitles[i].G='Стоимость'      then SM := SM or (OM shl i);
    if c_ReportsTitles[i].G='Настройки'      then NM := NM or (OM shl i);
  end;  }
  if m_nCommandList = nil then m_nCommandList := TStringList.Create;

  if m_nCommandList.Count <= 0 then begin
    m_nCommandList.Clear;
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    m_nCommandList.LoadFromFile(m_strCurrentDir+'CommandType.dat');
  end;
  SearchListBox.Top := 28;
  SearchListBox.Left := 8;
  SearchListBox.Height := 100;
  SearchListBox.Width := 150;
end;

procedure TframeTreeDataModule.FirstNill;
var i : integer;
begin
  Old_Region := -1;
  Old_Depart := -1;
  Old_Town := -1;
  Old_TP := -1;
  Old_Street := -1;
  Node_Region := nil;
  Node_Depart := nil;
  Node_Town := nil;
  Node_TP := nil;
  Node_Street := nil;
  TreeListBox.Sorted:=true;
  TreeListBox.Duplicates := dupAccept;	  
  CurrentFindRow := 0;
  OM := 1; MM := 0; EM := 0; PM := 0; DM := 0; UM := 0; SM := 0; NM := 0;

  MnuAllVisible(false);

  AutoExpand := False;
  PressCtrl := False;

  for i:= 0 to c_ReportsCount-1 do begin
    if c_ReportsTitles[i].G='Мощность'       then MM := MM or (OM shl i);
    if c_ReportsTitles[i].G='Энергия'        then EM := EM or (OM shl i);
    if c_ReportsTitles[i].G='Показания'      then PM := PM or (OM shl i);
    if c_ReportsTitles[i].G='Диагностические'then DM := DM or (OM shl i);
    if c_ReportsTitles[i].G='Учет тепла'     then UM := UM or (OM shl i);
    if c_ReportsTitles[i].G='Стоимость'      then SM := SM or (OM shl i);
    if c_ReportsTitles[i].G='Настройки'      then NM := NM or (OM shl i);
  end;
end;

procedure TframeTreeDataModule.final;
begin
  Clear;
  FirstNill;
end;

// ***********************************
// Построение объекта, заполнение
// ***********************************

function ItIsNumber(s : string):boolean;
var  i : integer;
begin
  Result := true;
  for i := 1 to length(s) do begin
    if not (s[i] in ['0' .. '9']) then
      Result := false;
  end;
end;

function TframeTreeDataModule.CreateNodeData(ID: integer; nNode: TTreeNode;
  code: byte; REPV : TREPV): TNodeData;
var NodeData : TNodeData;
begin
  NodeData := TNodeData.Create;
  NodeData.ID := ID;
  NodeData.OW := nNode;
  NodeData.Code := code;
  NodeData.REPV := REPV;
  Result:=NodeData;
end;

function TframeTreeDataModule.CreateREPV(TS, RV: int64): TREPV;
begin
  REPV := TREPV.Create;
  REPV.TreeSettings := TS;
  REPV.ReportVS := RV;
  Result := REPV;
end;


procedure TframeTreeDataModule.GetTreeView;
var strSQL     : string;
    nCount, i  : integer;
    s          : string;
    ID         : integer;
    OWNER      : TTreeNode;
    node       : TTreeNode;
    changes    : boolean;
begin
  strSQL:='SELECT * FROM GET_TREE_ABON ';

  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin

    for i := 0 to nCount-1 do begin
      changes:=false;
      if UserPermission.AccessAllowed(utlDB.DBase.IBQuery.FieldByName('IDREGION').AsInteger, -1) or
           (not UserPermission.AccessByRegion) then begin
        if (utlDB.DBase.IBQuery.FieldByName('IDREGION').AsInteger <> Old_Region) or changes then begin
          Old_Region:=utlDB.DBase.IBQuery.FieldByName('IDREGION').AsInteger;
          s := utlDB.DBase.IBQuery.FieldByName('REGION').AsString;
          NodeData:=CreateNodeData(utlDB.DBase.IBQuery.FieldByName('IDREGION').AsInteger, nil, SD_REGIN, nil);
          Node_Region:=TreeList.Items.AddObject(nil,s,NodeData);
          Node_Region.ImageIndex:=1;  Node_Region.SelectedIndex:=1;
          TreeListBox.AddObject(s,Node_Region);
          changes := true;
        end else begin
        end;
        if UserPermission.AccessAllowed(utlDB.DBase.IBQuery.FieldByName('IDREGION').AsInteger,
              utlDB.DBase.IBQuery.FieldByName('IDDEPART').AsInteger) or
             (not UserPermission.AccessByRegion) then begin
          if (utlDB.DBase.IBQuery.FieldByName('IDDEPART').AsInteger <> Old_Depart) or changes then begin
            s := utlDB.DBase.IBQuery.FieldByName('DEPART').AsString;
            if s <> '' then begin
              Old_Depart:=utlDB.DBase.IBQuery.FieldByName('IDDEPART').AsInteger;
              NodeData:=CreateNodeData(utlDB.DBase.IBQuery.FieldByName('IDDEPART').AsInteger, Node_Region, SD_RAYON, nil);
              Node_Depart:=TreeList.Items.AddChildObject(Node_Region,s,NodeData);
              Node_Depart.ImageIndex:=1;   Node_Depart.SelectedIndex:=1;
              TreeListBox.AddObject(s,Node_Depart);
              changes := true;
            end else Old_Depart := -1; //Обнуление узла департамента  и так для других
          end else begin
          end;
          if (utlDB.DBase.IBQuery.FieldByName('IDTOWN').AsInteger <> Old_Town) or changes then begin
            s := utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
            if s <> '' then begin
              Old_Town:=utlDB.DBase.IBQuery.FieldByName('IDTOWN').AsInteger;
              NodeData:=CreateNodeData(utlDB.DBase.IBQuery.FieldByName('IDTOWN').AsInteger, Node_Depart, SD_TOWNS, nil);
              Node_Town:=TreeList.Items.AddChildObject(Node_Depart,s,NodeData);
              Node_Town.ImageIndex:=1;   Node_Town.SelectedIndex:=1;
              TreeListBox.AddObject(s,Node_Town);
              changes := true;
            end else Old_Town := -1; // -/-
          end else begin
          end;
          if (utlDB.DBase.IBQuery.FieldByName('IDTP').AsInteger <> Old_TP) or changes then begin
            s := utlDB.DBase.IBQuery.FieldByName('TP').AsString;
            if s <> '' then begin
              Old_TP:=utlDB.DBase.IBQuery.FieldByName('IDTP').AsInteger;
              NodeData:=CreateNodeData(utlDB.DBase.IBQuery.FieldByName('IDTP').AsInteger, Node_Town, SD_TPODS, nil);
              Node_TP:=TreeList.Items.AddChildObject(Node_Town,s,NodeData);
              Node_TP.ImageIndex:=1;    Node_TP.SelectedIndex:=1;
              TreeListBox.AddObject(s,Node_TP);
              changes := true;
            end else Old_TP := -1; // -/-
          end else begin
          end;
          if (utlDB.DBase.IBQuery.FieldByName('IDSTREET').AsInteger <> Old_Street) or changes then begin
            s := utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
            if s <> '' then begin
              Old_Street:=utlDB.DBase.IBQuery.FieldByName('IDSTREET').AsInteger;
              NodeData:=CreateNodeData(utlDB.DBase.IBQuery.FieldByName('IDSTREET').AsInteger, Node_TP, SD_STRET, nil);
              Node_Street:=TreeList.Items.AddChildObject(Node_TP,s,NodeData);
              Node_Street.ImageIndex:=1;   Node_Street.SelectedIndex:=1;
              TreeListBox.AddObject(s,Node_Street);
            end else Old_Street := -1;  // -/-
          end else begin
          end;
          s := utlDB.DBase.IBQuery.FieldByName('ABONT').AsString;
          if s <> '' then begin
            s := utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
            if trim(utlDB.DBase.IBQuery.FieldByName('HKORP').AsString) = '' then begin   // корпуса нет
              if trim(utlDB.DBase.IBQuery.FieldByName('HNUMB').AsString) = '' then
              else begin
                s := s + ', ' + trim(utlDB.DBase.IBQuery.FieldByName('HNUMB').AsString);
              end
            end else begin  // корпус есть, предполагается что и номер дома тоже
              s := s + ', ' + trim(utlDB.DBase.IBQuery.FieldByName('HNUMB').AsString);
              if ItIsNumber(trim(utlDB.DBase.IBQuery.FieldByName('HKORP').AsString)) then
                s := s + '/' + trim(utlDB.DBase.IBQuery.FieldByName('HKORP').AsString)
              else s := s + trim(utlDB.DBase.IBQuery.FieldByName('HKORP').AsString)
            end;
            REPV := CreateREPV(StrToInt64Def(utlDB.DBase.IBQuery.FieldByName('SSET').AsString, 0),
                               StrToInt64Def(utlDB.DBase.IBQuery.FieldByName('REPVS').AsString, 0));
            ID:=utlDB.DBase.IBQuery.FieldByName('IDABONT').AsInteger;
            NodeData:=CreateNodeData(ID, Node_Street, SD_ABONT, REPV);
            node:=TreeList.Items.AddChildObject(Node_Street,s,NodeData);
            node.ImageIndex:=10; node.SelectedIndex:=10;
            //TreeListBox.AddObject(s,node);
            OWNER := node;

            // группа для картир по номерамм
            REPV := CreateREPV(StrToInt64Def(utlDB.DBase.IBQuery.FieldByName('SSET').AsString, 0),
                               StrToInt64Def(utlDB.DBase.IBQuery.FieldByName('REPVS').AsString, 0));
            NodeData:=CreateNodeData(ID, OWNER, SD_APART, REPV);
            node:=TreeList.Items.AddChildObject(OWNER,utlDB.DBase.IBQuery.FieldByName('GROUPNAME').AsString,NodeData);
            node.ImageIndex:=13; node.SelectedIndex:=13;
            // группа для отчетов
            REPV := CreateREPV(StrToInt64Def(utlDB.DBase.IBQuery.FieldByName('SSET').AsString, 0),
                               StrToInt64Def(utlDB.DBase.IBQuery.FieldByName('REPVS').AsString, 0));
            NodeData := CreateNodeData(ID, OWNER, SD_REPRT, REPV);
            node:=TreeList.Items.AddChildObject(OWNER,'Отчеты',NodeData);
            node.ImageIndex:=5; node.SelectedIndex:=5;
            // события
            NodeData := CreateNodeData(ID, OWNER, SD_EVNTA, nil);
            node:=TreeList.Items.AddChildObject(OWNER,'События',NodeData);
            node.ImageIndex:=6; node.SelectedIndex:=6;
          end;
        end;
      end;
      utlDB.DBase.IBQuery.Next;
    end;
    if UserPermission.PermissQueryGroup then begin
      NodeData := CreateNodeData(0, nil, SD_QGSOS, nil);         // (0, nil, SD_QGRUP, nil);
      Node:=TreeList.Items.AddObject(nil,'Группы опроса',NodeData);
      Node.ImageIndex:=35; node.SelectedIndex:=35;
      if not Node.HasChildren then TreeList.Items.AddChildObject(Node,'',nil);        // aa
    end;
    NodeData := CreateNodeData(0, nil, SD_EVENS, nil);
    Node:=TreeList.Items.AddObject(nil,'События системмы',NodeData);
    Node.ImageIndex:=6; node.SelectedIndex:=6;
  end;
end;


procedure TframeTreeDataModule.Clear;
var i    : integer;
    P, K : TObject;
    Node : TTreeNode;
    REPV : TREPV;
begin
  TreeListBox.Clear;
  for i := TreeList.Items.Count-1 downto 0 do begin
    Node := TreeList.Items[i];
    NodeData := Node.Data;
    if NodeData <> nil then begin
      REPV := NodeData.REPV;
      if REPV <> nil then begin
        K := REPV;
        REPV := nil;
        K.Free;
      end;
      P := NodeData;
      NodeData:=nil;
      P.Free;
    end;
  end;
  GroupListBox.Clear;
  TreeList.Items.Clear;
end;

procedure TframeTreeDataModule.ClearNode(node: TTreeNode);
var nNode : TTreeNode;

begin
  // добавить очистку определенного узла
  while node <> nil do begin
    if node.HasChildren then
       ClearNode(node.GetLastChild);   // GetFirstChild
    if node <> nil then begin
      NodeData:= Node.Data;
      if NodeData <> nil then begin
        if (NodeData.Code = SD_RAYON) or (NodeData.Code = SD_TOWNS) or
           (NodeData.Code = SD_STRET) or (NodeData.Code = SD_TPODS) or
           (NodeData.Code = SD_ABONT) or (NodeData.Code = SD_APART) or
           (NodeData.Code = SD_RRP01) or (NodeData.Code = SD_EVNTA) or
           (NodeData.Code = SD_RRP02) or (NodeData.Code = SD_RRP03) or
           (NodeData.Code = SD_RRP04) or (NodeData.Code = SD_RRP05) or
           (NodeData.Code = SD_RRP06) or (NodeData.Code = SD_RRP07) or
           (NodeData.Code = SD_RRP08) or (NodeData.Code = SD_RRP09) or
           (NodeData.Code = SD_REPRT) then begin
          nNode := nil;
          if node.Text = '' then        
            node.Collapse(True);
          node.Collapse(True);
        end else begin
          if node.Text = '' then
            node.Collapse(True);
          REPV := NodeData.REPV;
          if REPV <> nil then FreeAndNil(REPV);
          FreeAndNil(NodeData);
          nNode := node.getPrevSibling;
          node.Collapse(True);
          node.Delete;
          node := nil;
        end;
      end else if node.Text = '' then begin
        nNode := node.getPrevSibling;
        node.Collapse(True);
        node.Delete;
        node := nil;
      end;
    end;
    if nNode <> nil then node := nNode
    else if node <> nil then
      node := node.getPrevSibling
    else node := nNode;
  end;
end;

procedure TframeTreeDataModule.ExpandChilds(node: TTreeNode);
begin
  while node <> nil do begin
    if node.HasChildren then
       ExpandChilds(node.GetFirstChild);
    NodeData:= Node.Data;
    if (NodeData.Code = SD_RAYON) or (NodeData.Code = SD_TOWNS) or
       (NodeData.Code = SD_STRET) or (NodeData.Code = SD_TPODS) or
       (NodeData.Code = SD_ABONT)then begin
      TreeList.Selected := Node;
    end;
    node := node.GetNextSibling;
  end;
end;

procedure TframeTreeDataModule.CollapseChilds(node: TTreeNode);
begin
  ClearNode(node);
end;

procedure TframeTreeDataModule.TreeListExpanded(Sender: TObject;
  Node: TTreeNode);
var nNode: TTreeNode;
    NodeData : TNodeData;
begin
  TreeList.Items.BeginUpdate;

  NodeData:= Node.Data;
  case NodeData.Code of
    SD_ABONT : begin
      nNode:=FindNode(SD_APART, NodeData.ID);
      if not nNode.HasChildren then TreeList.Items.AddChildObject(nNode,'',nil);
      if nNode.IsVisible then nNode.Collapse(True);
      nNode:=FindNode(SD_REPRT, NodeData.ID);
      if nNode <> nil then begin
      if not nNode.HasChildren then TreeList.Items.AddChildObject(nNode,'',nil);
      if nNode.IsVisible then nNode.Collapse(True);
    end;
    end;
    SD_REPRT : begin    //Отчеты
      if Node.item[0].Text = '' then Node.item[0].Delete;
      GetReportsByType(NodeData.ID, Node);
    end;
    SD_APART : begin    //квартиры
      if Node.item[0].Text = '' then Node.item[0].Delete;
      GetApartByHouse(NodeData.ID, Node);
    end;
    SD_QGSOS : begin    // Группы опроса    SD_QGRUP
      if Node.item[0].Text = '' then Node.item[0].Delete;
      GetQueryGroup(NodeData.ID, Node);
    end;
    SD_RAYON, SD_TOWNS, SD_STRET, SD_TPODS : begin
      if AutoExpand or PressCtrl then begin
        ExpandChilds(Node.GetFirstChild);
        PressCtrl := False;
      end;
    end;
  end;
  TreeList.Items.EndUpdate;
 // TreeList.Visible:=true;
end;

procedure TframeTreeDataModule.TreeListCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
var nNode: TTreeNode;
    NodeData : TNodeData;
begin
  TreeList.Items.BeginUpdate;
 // TreeList.Visible:=false;

  NodeData:= Node.Data;
  case NodeData.Code of
    SD_ABONT : begin
      ClearNode(Node.GetLastChild);     // Node.GetFirstChild
      if not node.HasChildren then TreeList.Items.AddChildObject(Node,'',nil);
    end;
    SD_REPRT : begin    //Отчеты
      ClearNode(Node.GetLastChild);         // Node.GetFirstChild
      if not node.HasChildren then TreeList.Items.AddChildObject(Node,'',nil);
    end;
    SD_APART : begin    //квартиры
      ClearNode(Node.GetLastChild);        // Node.GetFirstChild
      if not node.HasChildren then TreeList.Items.AddChildObject(Node,'',nil);
    end;
    SD_RAYON, SD_TOWNS, SD_STRET, SD_TPODS : begin
      if AutoExpand or PressCtrl then begin
        CollapseChilds(Node.GetLastChild);     // Node.GetFirstChild
        PressCtrl := False;
      end;
    end;
  end;
  TreeList.Items.EndUpdate;
  AllowCollapse := True;
end;

function TframeTreeDataModule.FindNode(code : byte; ID : integer):TTreeNode;
var i    : integer;
    Node : TTreeNode;
    NodeData : TNodeData;
begin
  Result := nil;
  for i := 0 to TreeList.Items.Count-1 do begin
    Node := TreeList.Items[i];
    NodeData:=nil;
    if Node.Data <> nil then NodeData := Node.Data;
    if NodeData <> nil then
      if (NodeData.Code = code) and (NodeData.ID = ID) then begin
        Result:=Node;
        Exit;
      end
  end;
end;

procedure TframeTreeDataModule.GetApartByHouse(ID : integer; Node: TTreeNode);
const VRMeter    : byte = 255;   // признак виртуального счетчика в программе всегда приходит значение 256
var strSQL     : string;
    nCount, i  : integer;
    Index      : integer;
    IDn        : integer;
    s          : string;
    nNode      : TTreeNode;
    NodeData   : TNodeData;
    REPV       : TREPV;
    ArrByte    : TArrByte;
    _SWMID         : Integer;
    _SDDHADR_HOUSE : String;
    _SMETERNAME    : String;
    _QUERYSTATE    : Integer;
begin
  ListAB := TList.Create;
  strSQL:='SELECT L2T.M_SWMID, L2T.M_SDDHADR_HOUSE, SVM.M_SMETERNAME, L2T.QUERYSTATE, ' +
          '       L3PR.M_SWPARAMID, L3PR.M_SBLSAVED, L3PR.M_SBLCALCULATE ' +
          'FROM L2TAG L2T, SL3ABON L3A, SL3VMETERTAG SVM, SL3PARAMS L3PR ' +
          'WHERE L3A.M_SWABOID = L2T.M_SWABOID ' +
          '  AND L3A.M_SWABOID = ' + IntToStr(ID) +
          '  AND SVM.M_SWMID = L2T.M_SWMID ' +
          '  AND SVM.M_SWVMID = L3PR.M_SWVMID ';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    _SWMID         :=utlDB.DBase.IBQuery.FieldByName('M_SWMID').AsInteger;
    _SDDHADR_HOUSE :=utlDB.DBase.IBQuery.FieldByName('M_SDDHADR_HOUSE').AsString;
    _SMETERNAME    :=utlDB.DBase.IBQuery.FieldByName('M_SMETERNAME').AsString;
    _QUERYSTATE    :=utlDB.DBase.IBQuery.FieldByName('QUERYSTATE').AsInteger;
    ListABClear;
    for i := 0 to nCount {-1} do begin
      if (_SWMID <> utlDB.DBase.IBQuery.FieldByName('M_SWMID').AsInteger) then begin
        // для того чтобы активировать последнюю квартиру
        if i = nCount then
          dec(_SWMID);
        NodeData := Node.Data;
        REPV := NodeData.REPV;
        IDn:=_SWMID;
        NodeData:=CreateNodeData(IDn, Node, SD_APNUM, nil);
        if _SDDHADR_HOUSE <> trim('') then
          s := _SDDHADR_HOUSE + ', ' + _SMETERNAME
        else s:= _SMETERNAME;
        nNode:=TreeList.Items.AddChildObject(Node,s,NodeData);
        index:=0;
        case _QUERYSTATE of
          0 : Index:=10;
          1 : Index:=11;
          2 : Index:=12;
        end;
        nNode.ImageIndex:=Index; nNode.SelectedIndex:=Index;

        if (REPV.TreeSettings and (1 shl PD_ARCHV)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_ARCHV+100, 'Архивы', 2);
        if (REPV.TreeSettings and (1 shl PD_GRAPH)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_GRAPH+100, 'Графики', 4);
        if (REPV.TreeSettings and (1 shl PD_LIMIT)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_LIMIT+100, 'Лимиты', 7);
        if (REPV.TreeSettings and (1 shl PD_PERIO)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_PERIO+100, 'Периодические', 3);
        if (REPV.TreeSettings and (1 shl PD_CURRT)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_CURRT+100, 'Текущие', 1);
        if (REPV.TreeSettings and (1 shl PD_VECDG)) <> 0 then
          if VRMeter = 0 then
            CreateNodeParam(IDn, nNode, PD_VECDG+100, 'Векторная диаграмма', 21);
        if (REPV.TreeSettings and (1 shl PD_CHNDG)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_CHNDG+100, 'Замены', 15);
        if (REPV.TreeSettings and (1 shl PD_EVENS)) <> 0 then
          CreateNodeParam(IDn, nNode, PD_EVENS+100, 'События', 6);

        _SWMID         :=utlDB.DBase.IBQuery.FieldByName('M_SWMID').AsInteger;
        _SDDHADR_HOUSE :=utlDB.DBase.IBQuery.FieldByName('M_SDDHADR_HOUSE').AsString;
        _SMETERNAME    :=utlDB.DBase.IBQuery.FieldByName('M_SMETERNAME').AsString;
        _QUERYSTATE    :=utlDB.DBase.IBQuery.FieldByName('QUERYSTATE').AsInteger;
        ListABClear;
        ArrByte := TArrByte.Create;
        ArrByte.SWPARAMID:=utlDB.DBase.IBQuery.FieldByName('M_SWPARAMID').AsInteger;
        ArrByte.SBLSAVED:=utlDB.DBase.IBQuery.FieldByName('M_SBLSAVED').AsInteger;
        ArrByte.SBLCALCULATE:=utlDB.DBase.IBQuery.FieldByName('M_SBLCALCULATE').AsInteger;
        ListAB.Add(ArrByte);
      end else begin
//        дополняем масив
        ArrByte := TArrByte.Create;
        ArrByte.SWPARAMID:=utlDB.DBase.IBQuery.FieldByName('M_SWPARAMID').AsInteger;
        ArrByte.SBLSAVED:=utlDB.DBase.IBQuery.FieldByName('M_SBLSAVED').AsInteger;
        ArrByte.SBLCALCULATE:=utlDB.DBase.IBQuery.FieldByName('M_SBLCALCULATE').AsInteger;
        ListAB.Add(ArrByte);
      end;
      // для того чтобы активировать последнюю квартиру
      if i <> nCount then utlDB.DBase.IBQuery.Next;
      if i = nCount-1 then
        inc(_SWMID);
    end;

  end;
  ListABClear;
  ListAB.Destroy;
end;

procedure TframeTreeDataModule.CreateNodeParam(ID : integer; Node : TTreeNode;
          code : byte;  Name : string; index : integer);
var NodeData   : TNodeData;
    nNode      : TTreeNode;
    iNode      : TTreeNode;
    i          : integer;
    ArrByte    : TArrByte;
begin
  NodeData:=CreateNodeData(ID, Node, code, nil);
  code := code - 100;
  nNode:=TreeList.Items.AddChildObject(Node, Name, NodeData);
  nNode.ImageIndex:=index; nNode.SelectedIndex:=index;
  for i := 0 to ListAB.Count-1 do begin
    ArrByte := TArrByte(ListAB[i]);
    if ((code = PD_ARCHV) or (code = PD_LIMIT)) and (ArrByte.SBLCALCULATE = 1) then begin
      if (code = PD_ARCHV) and (ArrByte.SBLSAVED = (code - PD_ARCHV + 1)) then begin
        NodeData:=CreateNodeData(ID, nNode, PD_ARCHV+100+20+ArrByte.SWPARAMID, nil);
        Name := m_nCommandList.Strings[ArrByte.SWPARAMID];
        iNode:=TreeList.Items.AddChildObject(nNode, Name, NodeData);
        iNode.ImageIndex:=index; iNode.SelectedIndex:=index;
      end else if (code = PD_LIMIT) then begin
        NodeData:=CreateNodeData(ID, nNode, PD_LIMIT+100+50+ArrByte.SWPARAMID, nil);
        Name := m_nCommandList.Strings[ArrByte.SWPARAMID];
        iNode:=TreeList.Items.AddChildObject(nNode, Name, NodeData);
        iNode.ImageIndex:=index; iNode.SelectedIndex:=index;
      end;
    end;
  end;
end;

function TframeTreeDataModule.IfIsChildNodeItem(Node : TTreeNode; s : string): TTreeNode;
var i     : integer;
    nNode : TTreeNode;
begin
  Result := nil;  // Node.co
  for i := 0 to Node.Count-1  do begin
    nNode := Node.Item[i];
    if nNode.Text = s then begin
      Result:=nNode;
      Exit;
    end;
  end;
end;

procedure TframeTreeDataModule.GetReportsByType(ID: integer;
  Node: TTreeNode);
var NodeData : TNodeData;
    REPV     : TREPV;
    nNode    : TTreeNode;
begin
  nNode:=Node.GetLastChild;
  ClearNode(nNode);
  NodeData := Node.Data;
  REPV := NodeData.REPV;
 if REPV <> nil then
  if (REPV.TreeSettings and (1 shl PD_RPRTS)) <> 0 then begin
    if (Node.Count > 0) and (Node.item[0].Text = '') then Node.item[0].Delete;
    if (REPV.ReportVS and MM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);                  ///////    SD_REPRT
      nNode:=TreeList.Items.AddChildObject(Node, 'Мощность', NodeData);
      nNode.ImageIndex:=23;  nNode.SelectedIndex:=23;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP01, 23, REPV); //    MM
    end;
    if (REPV.ReportVS and EM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);
      nNode:=TreeList.Items.AddChildObject(Node, 'Энергия', NodeData);
      nNode.ImageIndex:=24;  nNode.SelectedIndex:=24;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP02, 24, REPV); //    EM
    end;
    if (REPV.ReportVS and PM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);
      nNode:=TreeList.Items.AddChildObject(Node, 'Показания', NodeData);
      nNode.ImageIndex:=25;  nNode.SelectedIndex:=25;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP03, 25, REPV); //    PM
    end;
    if (REPV.ReportVS and DM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);                        // SD_RRP04
      nNode:=TreeList.Items.AddChildObject(Node, 'Диагностические', NodeData);
      nNode.ImageIndex:=26;  nNode.SelectedIndex:=26;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP04, 26, REPV); //    DM
    end;
    if (REPV.ReportVS and UM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);
      nNode:=TreeList.Items.AddChildObject(Node, 'Учет тепла', NodeData);
      nNode.ImageIndex:=27;  nNode.SelectedIndex:=27;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP05, 27, REPV); //    UM
    end;
    if (REPV.ReportVS and SM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);
      nNode:=TreeList.Items.AddChildObject(Node, 'Стоимость', NodeData);
      nNode.ImageIndex:=28;  nNode.SelectedIndex:=28;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP06, 28, REPV); //    SM
    end;
    if (REPV.ReportVS and NM)<>0 then begin
      NodeData:=CreateNodeData(ID, Node, SD_REPRT, nil);
      nNode:=TreeList.Items.AddChildObject(Node, 'Настройки', NodeData);
      nNode.ImageIndex:=29;  nNode.SelectedIndex:=29;
      CreateNodeReport(NodeData.ID, nNode, SD_RRP07, 29, REPV); //    NM
    end;
  end;
end;

procedure TframeTreeDataModule.CreateNodeReport(ID : integer; Node : TTreeNode;
          SDR : integer; index : integer; REPV : TREPV);
var nNode    : TTreeNode;
    NodeData : TNodeData;
    sh       : int64;
    i        : Integer;
begin
  sh:=1;
  for i:=0 to c_ReportsCount-1 do begin
    if (REPV.ReportVS and (sh shl i))>0 then begin
      if Node.Text=c_ReportsTitles[i].G then begin
        NodeData:=CreateNodeData(c_ReportsTitles[i].I, Node, SDR, nil);
        nNode:=TreeList.Items.AddChildObject(Node, c_ReportsTitles[i].N, NodeData);
        nNode.ImageIndex:=index; nNode.SelectedIndex:=index;
      end;
    end;
  end;
end;

procedure TframeTreeDataModule.GetQueryGroup(ID : integer; Node: TTreeNode);
var strSQL     : string;
    nCount, i  : integer;
    nNode      : TTreeNode;
    index      : integer;
    j, k, h    : Integer;
    s, s1      : string;
    DateQuery  : TDate;
    pTblParam  : TThreadList;
    vListParam : TList;
    dataParam  : QGPARAM;
    arrayParam : array[0..3] of byte;
    SL         : TStringList;
    IDREGION   : Integer;
    IDDEPART   : Integer;
    Accesed    : Boolean;
begin
  if not Node.HasChildren then begin
    GroupListBox.Clear;  
    SL := TStringList.Create;
    strSQL:='SELECT QG.ID, QG.NAME, QG.ENABLE, QG.STATPARAM, QG.DATEQUERY, QG.ERRORQUERY ' +
            'FROM QUERYGROUP QG ORDER BY NAME';

    if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
      for i := 0 to nCount-1 do begin
        Accesed := False;
        if m_pDB.GetDepartGroupID(utlDB.DBase.IBQuery.FieldByName('ID').AsInteger, SL) then;
        for h := 0 to SL.Count-1 do begin
          s := SL.Strings[h];
          s1 := Copy(s, 1, Pos(' ', s));
          s1 := Trim(s1);
          IDREGION := StrToInt(s1);
          Delete(s, 1, Pos(' ', s));
          s := Trim(s);
          IDDEPART := StrToInt(s);
          if UserPermission.AccessAllowed(IDREGION, IDDEPART) or
             (not UserPermission.AccessByRegion) then Accesed := True;
        end;

       if Accesed then begin
  

        for k:=0 to 3 do arrayParam[k]:=0;

        pTblParam  := TThreadList.Create;
        if m_pDB.getQueryGroupsParam(utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,-1, pTblParam)then
        begin
          vListParam:=pTblParam.LockList;
          for j:=0 to vListParam.Count-1 do
          begin
            dataParam:=vListParam[j];
            if (dataParam.PARAM=1)and(dataParam.ENABLE=1) then
             arrayParam[0]:=1
            else if (dataParam.PARAM=17)and(dataParam.ENABLE=1) then
             arrayParam[1]:=1
            else if (dataParam.PARAM=21)and(dataParam.ENABLE=1) then
             arrayParam[2]:=1;
          end;
          pTblParam.UnlockList;
          ClearListAndFree(pTblParam);
        end;


        NodeData:=CreateNodeData(utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,
                  Node, SD_QGRUP, nil);
        s := utlDB.DBase.IBQuery.FieldByName('NAME').AsString;
          DateQuery := utlDB.DBase.IBQuery.FieldByName('DATEQUERY').AsDateTime;

       if utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger = 1 then begin  // Запрос остановлен        // BO 12/12/18
         if trunc(DateQuery) <> date then
           begin   // Запрос просрочен
             Index:= 31;
             if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
              s:= 'Вкл.(авт)/ ' +s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос просрочен'
             else s:=s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос просрочен';
           end
         else
          begin                          // Все хорошо
            Index:= 16;
             s:=s+' / Опрос'
          end;
       end
       else if utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger = 2 then    // Запрос опроса(руч.)'
         begin
           if trunc(DateQuery) <> date then
             begin   // Запрос просрочен
               Index:= 31;
               if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
                s:= 'Вкл.(авт)/ ' + s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос просрочен'
               else s:=s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос просрочен';
             end
           else
             begin                          // Все хорошо
            Index:= 21;
               s:=s+' / Ожидание опроса(руч.)'
          end;
         end
       else if utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger = 3 then    // Запрос опроса(авт.)'
         begin
           if trunc(DateQuery) <> date then
             begin   // Запрос просрочен
               Index:= 31;
               if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
                s:= 'Вкл.(авт)/ ' + s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос просрочен'
                else s:=s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос просрочен';
             end
           else
             begin                          // Все хорошо
            Index:= 21;
               s:=s+' / Ожидание опроса(авт.)'
          end;
         end
         else if utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger = 4 then    // Опрос прерван'
         begin
               Index:= 31;
               if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
                s:= 'Вкл.(авт)/ ' + s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос прерван'
               else s:=s+ ' / ' +DateTimeToStr(DateQuery) +' / Опрос прерван'
         end
       else if utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger = 0 then  // Запрос завершен
         begin
          Index:= 30;
             if (arrayParam[0]=1) or (arrayParam[1]=1) or (arrayParam[2]=1) then
               s:= 'Вкл.(авт)/ ' + s+ ' / ' +DateTimeToStr(DateQuery)+' / Опрос завершен'
             else s:=s+ ' / ' +DateTimeToStr(DateQuery)+' / Опрос завершен';

         end;




     {   if utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger <> 0 then begin    // Запрос остановлен
          index := 31;
          s:= s + ' / Опрос остановлен';
        end else begin
          DateQuery := utlDB.DBase.IBQuery.FieldByName('DATEQUERY').AsDateTime;
          if DateQuery <> date then begin  // Запрос просрочен
            index := 30;
            s:= s + ' / ' +DateToStr(DateQuery) +' / Опрос просрочен';
          end else begin                                                              // Все хорошо
            index := 16;
            s:= s + ' / ' +DateToStr(DateQuery) +' / Опрос завершен';
          end;
        end;         }


        nNode:=TreeList.Items.AddChildObject(Node, s, NodeData);
        nNode.ImageIndex:=index; nNode.SelectedIndex:=index;
        s := IntToStr(utlDB.DBase.IBQuery.FieldByName('ID').AsInteger);
        GroupListBox.AddObject(s,nNode);
        utlDB.DBase.IBQuery.Next;
      end else utlDB.DBase.IBQuery.Next;
    end;
    end;
  if SL<>Nil then FreeAndNil(SL);
  end;
end;

procedure TframeTreeDataModule.FrameResize(Sender: TObject);
begin
//  Application.ProcessMessages;
end;

procedure TframeTreeDataModule.ListABClear;
var i       : integer;
    ArrByte : TArrByte;
    P       : TObject;
begin
  for i := 0 to ListAB.Count -1 do begin
    ArrByte := TArrByte(ListAB.items[i]);
    if ArrByte <> nil then begin
      P := ArrByte;
      ArrByte:=nil;
      P.Free;
    end;
  end;
  ListAB.Clear;
end;


// ***********************************
// Обработка событий мыши
// ***********************************

procedure TframeTreeDataModule.TreeListClick(Sender: TObject);
var Node, NodeOW: TTreeNode;
    NodeData    : TNodeData;
    NodeDataOW  : TNodeData;
    sR          : string;
    vID         : integer;
    m_pDS       : CGDataSource;
    VirtID      : integer;
    GroupID     : integer;
    PIID        : Integer;
    CodeRepID   : Integer;
    PosRepID    : Integer;
    Action      : TCloseAction;
//    pIND        : PCTI;    
begin
  if m_blIsBackUp=True then begin
    MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
    exit;
  end;
  MnuAllVisible(false);

  Node := TreeList.Selected;
  if Node <> nil then begin
    NodeData := Node.Data;
    mnuObjectTreeManagement.Visible:=true;
    mnuAddObject.Visible:=true;
    mnuAddGueryGroup.Visible:=true;
    //*******************************
    m_blMinimized := False;
{$IFNDEF TESTMODE}
    m_pDS:=SetCGDataSourceNill;
    m_pDS.nWidth  := TKnsForm.Width -20;//TKnsForm.advsplitter2.Left-20;
    m_pDS.nHeight := TKnsForm.Height-(TKnsForm.Height-TKnsForm.splHorSplitt.top)-TKnsForm.advToolPannel.Height-10;
    m_pDS.pOwner  := TKnsForm.Owner;
{$ENDIF}
    if (NodeData.Code = SD_REGIN) or (NodeData.Code = SD_RAYON) or (NodeData.Code = SD_TOWNS) or
       (NodeData.Code = SD_TPODS) or (NodeData.Code = SD_STRET) or (NodeData.Code = SD_QGSOS) then begin     // SD_QGRUP
      mnuExportNodeToExcel.Visible:=true;
      ReportCorrect.Visible:=true;
      if TKnsForm.MDIChildren[vID] <> nil then begin  // ошибка Invalid class typecast если открыто окно event
        if TKnsForm.MDIChildren[vID] is TTL5Events then (TKnsForm.MDIChildren[vID] as TTL5Events).Close;
      {  if TKnsForm.MDIChildren[vID] is TTQweryModule then (TKnsForm.MDIChildren[vID] as TTQweryModule).Close;  }
      end
    end else begin

    end;
    //
    case NodeData.Code of
      SD_REGIN : begin

      end;
      SD_ABONT : begin
        mnuAbonEdit.Visible:=true;
        mnuControlConnect.Visible    := false;
        mnuControlDisconnect.Visible := false;
{$IFNDEF TESTMODE}
        if TKnsForm.AdvPanel33.Visible then begin
          if TKnsForm.pcGEditor.ActivePage.Caption='Редактор каналов' then begin
            TKnsForm.m_nL2Editor.PMasterIndex := NodeData.ID;
            TKnsForm.m_nL2Editor.ExecSetGrid;
            m_pDB.GetPathNameByID(NodeData.ID, sR);
            sR:=Trim(sR);
            if (sR[Length(sR)]='/')then delete(sR,length(sR),1);
            sR:= 'Редактируемый объект: ' + sR;
            TKnsForm.HomeAddressLabel.Caption:=sR;
          end;
          if TKnsForm.pcGEditor.ActivePage.Caption='Редактор групп' then begin
                TKnsForm.m_nEDAB.ExecSetGridMI(NodeData.ID);
          end;
        end else TKnsForm.HomeAddressLabel.Caption:='';
{$ENDIF}
      end;
      SD_QGRUP : begin           // SD_QGRUP
{$IFNDEF TESTMODE}
        mnuExportNodeToExcel.Visible:=true;
        vID := TKnsForm.FindQsView;
        if vID=-1 then begin
          TKnsForm.m_nQsFrame := TTQweryModule.Create(Owner);
          TKnsForm.m_nQsFrame.WindowState:= wsMaximized;
          TKnsForm.m_nQsFrame.InitFrameID(NodeData.ID,0);
        end else if vID<>-1 then begin
          (TKnsForm.MDIChildren[vID] as TTQweryModule).Caption:= 'Группы опроса';
          (TKnsForm.MDIChildren[vID] as TTQweryModule).InitFrameID(NodeData.ID,0);
          TKnsForm.MDIChildren[vID].WindowState:= wsMaximized;
          TKnsForm.MDIChildren[vID].Show;
          (TKnsForm.MDIChildren[vID] as TTQweryModule).OnTimeElapsed(self);
        end;
{$ENDIF}
      end;
      SD_APNUM : begin
        mnuDeleteMeter.Visible:=true;
        mnuOpenTransit.Visible:=true;
        mnuCloseTransit.Visible:=true;
      end;
      SD_RRP01, SD_RRP02, SD_RRP03, SD_RRP04,
      SD_RRP05, SD_RRP06, SD_RRP07 : begin           // Отчеты
{$IFNDEF TESTMODE}
        // if PTSD=SD_REPRT then
        m_pDS.strClassName := 'TTRepPower';
        m_pDS.strCaption   := 'Отчеты:'+Node.Parent.Parent.Parent.Text;
        NodeOW:=NodeData.OW; NodeDataOW:=NodeOW.Data;
        SettingReportData(NodeData.ID, CodeRepID, PosRepID);
        m_pDS:=SetTreeIndex(m_pDS, CodeRepID, 5, 4, 0, -1, -1, -1, -1, NodeDataOW.ID, NodeData.ID, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, PosRepID, 1);
        TKnsForm.ExecuteReport(@m_pDS, TreeList);
        // End else if PTSD=SD_PRIMT then mnReportEdit.Visible := False;
{$ENDIF}
      end;
    end;

    case NodeData.Code of
      PD_VMETR+100 : begin    // Виртуальные счетчики - это квартиры
        mnuOpenTransit.Visible := True;
        mnuCloseTransit.Visible:= True;
        mnuDeleteMeter.Visible:= True;
      end;
      PD_ARCHV+100+21..PD_ARCHV+100+24,   // M_SWPARAMID = 1, 2, 3, 4
      PD_ARCHV+100+37..PD_ARCHV+100+44,   // M_SWPARAMID = 17..20, 21..24
      PD_PERIO+100,
      PD_GRAPH+100 : begin    // Архивы
{$IFNDEF TESTMODE}
        // if PTSD=SD_VPARM then
         if m_dwTree=0 then m_pDS.strCaption := Node.Parent.Text+':'+Node.Text;
         if m_dwTree=1 then m_pDS.strCaption := Node.Parent.Parent.Text+':'+Node.Text;
         VirtID:=GetOneParamFromID(NodeData.ID, 0);
         NodeDataOW:=Node.Parent.Parent.Parent.Data;
         GroupID:=GetOneParamFromID(NodeDataOW.ID, 1);
         PIID:=0;
         case NodeData.Code of
           138 : PIID := 76;
           142 : PIID := 77;
         end;
         m_pDS:=SetTreeIndex(m_pDS, 2, 4, 1, 0, -1, -1, -1, -1, NodeDataOW.ID, GroupID, -1, -1, VirtID, NodeData.Code-120-PD_ARCHV, 0, NodeData.ID, 2, 1, 0, -1, -1, PIID, -1);
         TKnsForm.pL3Module.SetDataSource(@m_pDS);
         SendMsg(BOX_L3,VirtID,DIR_L4TOL3,AL_VIEWGRAPH_REQ);
{$ENDIF}
      end;
      PD_LIMIT+100+21+50..PD_LIMIT+100+24+50,
      PD_LIMIT+100+37+50..PD_LIMIT+100+44+50 : begin    // Лимиты
{$IFNDEF TESTMODE}
        // if PTSD=SD_VPARM then
        VirtID:=GetOneParamFromID(NodeData.ID, 0);
        NodeDataOW:=Node.Parent.Parent.Parent.Data;
        GroupID:=GetOneParamFromID(NodeDataOW.ID, 1);
        fr3LimitEditor := Tfr3LimitEditor.Create(Self);
        fr3LimitEditor.pABOID := NodeDataOW.ID;
        fr3LimitEditor.pGRID  := GroupID;
        fr3LimitEditor.pVMID  := VirtID;
        fr3LimitEditor.pCMDID := 1;    // А что сюда?????
        fr3LimitEditor.ShowModal;
        fr3LimitEditor.Destroy;
{$ENDIF}
      end;
      PD_CURRT+100 : begin   // Текущие
{$IFNDEF TESTMODE}
        // if (PTSD=SD_VMETR) or (PTSD=SD_PRIMT) then
        // Так как пока не актуально, толком не разбирался ошибки возможны и скорее всего имеются
        m_pDS.strClassName := 'TDataFrame';
        m_pDS.strCaption   := Node.Parent.Text+':'+Node.Text;
        VirtID:=GetOneParamFromID(NodeData.ID, 0);
        NodeDataOW:=Node.Parent.Parent.Parent.Data;
        GroupID:=GetOneParamFromID(NodeDataOW.ID, 1);
        m_pDS:=SetTreeIndex(m_pDS, 1, 1, 0, 9, -1, -1, -1, -1, NodeDataOW.ID, GroupID, -1, -1, VirtID, -1, 0, NodeData.ID, -1, -1, -1, -1, -1, 84, 1);
        TKnsForm.pL3Module.SetDataSourceID(m_pDS);
        SendMsg(BOX_L3,VirtID,DIR_L4TOL3,AL_VIEWDATA_REQ);
{$ENDIF}
      end;
      PD_MONIT+100 : begin      // не сработало ни на чем, не знаю откуда ноги растут. Не делал
        // if (PTSD=SD_VMETR) or (PTSD=SD_PRIMT) then
        { m_pDS.strClassName := 'TTFrmMonitor';
          m_pDS.strCaption   := nNode.Parent.Text+':'+m_strL3SelNode;
          //m_pDS.strCaption := nNode.Parent.Parent.Text+':'+m_strL3SelNode;
          pL3Module.SetDataSource(@m_pDS);
          SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWDATA_REQ); }
      end;
      PD_VECDG+100 : begin    // Векторная диаграмма

      end;
      PD_CHNDG+100 : begin    // Замены
{$IFNDEF TESTMODE}
        // if (PTSD=SD_PRIMT) then
//        if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then begin
//          vID := TKnsForm.FindChView;
//          VirtID:=GetOneParamFromID(NodeData.ID, 0);
//          NodeDataOW:=Node.Parent.Parent.Parent.Data;
// //         NodeDataOW:=NodeOW.Data;
//          GroupID:=GetOneParamFromID(NodeDataOW.ID, 1);
//          m_pDS:=SetTreeIndex(m_pDS, 15, 1, 8, 9, -1, -1, -1, -1, NodeDataOW.ID, GroupID, -1, -1, VirtID, -1, 0, NodeData.ID, -1, -1, -1, -1, -1, 132, 1);
//          if vID=-1 then begin
//            TKnsForm.m_nChFrame := TTMeterChandge.Create(Owner);
//            TKnsForm.m_nChFrame.Caption:= 'Замены:'+Node.Parent.Text+':'+Node.Text;
//            TKnsForm.m_nChFrame.ChandgeStyler.Style := tsOffice2007Obsidian;
//            TKnsForm.m_nChFrame.OnOpen(m_pDS.trTRI);
//          end else
//          if vID<>-1 then begin
//            (TKnsForm.MDIChildren[vID] as TTMeterChandge).Caption:= 'Замены:'+Node.Parent.Text+':'+Node.Text;
//            (TKnsForm.MDIChildren[vID] as TTMeterChandge).OnOpen(m_pDS.trTRI);
//            TKnsForm.MDIChildren[vID].Show;
//          end;
//        end;
{$ENDIF}
      end;
      SD_EVENS,
      SD_EVNTA,
      PD_EVENS+100 : begin    // События
{$IFNDEF TESTMODE}
        m_pDS.strClassName := 'TTL5Events';
        if Node.Parent<> nil then begin
          m_pDS:=SetTreeIndex(m_pDS, 6, 1, 5, 10, -1, -1, -1, -1, NodeData.ID, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 120, 1);
          m_pDS.strCaption := 'События:'+Node.Parent.Text+':'+Node.Text
        end else begin
          m_pDS:=SetTreeIndex(m_pDS, 6, 1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, 65535, -1, -1, -1, -1, -1, -1, -1, -1, 8, 1);
          m_pDS.strCaption := 'События системмы';
        end;
        TKnsForm.pL3Module.SetDataSource(@m_pDS);
        SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWDATA_REQ);
{$ENDIF}
      end;
    end;
  end;
end;

procedure TframeTreeDataModule.TreeListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p    : TPoint;
    Node : TTreeNode;
begin
  // проверить нажатие клавиши Ctrl, если есть активировать режим Ctrl + [+]
  // для открытия всего узла, на который [+] мышью и нажимается
  // на каком ужле нажимается нужно проверять в  TreeListExpanded
{  if Shift = [ssCtrl, ssLeft] then begin
    PressCtrl := True;
  end; }

  Node := TreeList.GetNodeAt(X, Y);
  if Node<>Nil then  Node.Selected := true;

  if Button <> mbRight then exit;
  p.x:=X; p.y:=Y;
  p:=TreeList.ClientToScreen(p);
  TreeListClick(Sender);
  mnuTreeData.Popup(p.x, p.y);

end;

procedure TframeTreeDataModule.TreeListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [ssCtrl] then PressCtrl := True;
end;

procedure TframeTreeDataModule.TreeListKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if (Shift = [ssCtrl]) or (Key = 17) then PressCtrl := False;
end;

// ***********************************
// Редактирование объекта
// ***********************************
procedure TframeTreeDataModule.mnuAbonEditClick(Sender: TObject);
var mpDS       : CGDataSource;
    Node       : TTreeNode;
    NodeData   : TNodeData;
    NodeDataOW : TNodeData;
    Street, TP, Town : integer;
    Depart, Region, i: integer;
    s, sch     : string;
    _name1     : string;
    _name2     : string;
    _name3     : string;
    nNode      : TTreeNode;
begin
  Node := TreeList.Selected;
  if Node <> nil then begin
    _name1:=Node.Text;
    _name2:=Node.Parent.Text;
    _name3:=Node.Parent.Parent.Text;
    NodeData := Node.Data;
    case NodeData.Code of
      SD_ABONT : begin
        NodeDataOW:=Node.Parent.Data; Street:=NodeDataOW.ID;
        NodeDataOW:=Node.Parent.Parent.Data; TP:=NodeDataOW.ID;
        NodeDataOW:=Node.Parent.Parent.Parent.Data; Town:=NodeDataOW.ID;
        NodeDataOW:=Node.Parent.Parent.Parent.Parent.Data; Depart:=NodeDataOW.ID;
        NodeDataOW:=Node.Parent.Parent.Parent.Parent.Parent.Data; Region:=NodeDataOW.ID;
{$IFNDEF TESTMODE}
        mpDS:=SetTreeIndex(mpDS, 10, 0, 65535, Region, Depart, Town, TP, Street, NodeData.ID, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 55, 1);
        TAbonManager.setTreeIndex(mpDS.trTRI);
        if TAbonManager.PrepareAbon(mpDS.trTRI.PAID,0)=True then
        TAbonManager.ShowModal;
{$ENDIF}
      end;
    end;
    Final;
    GetTreeView;
    sch:=AnsiUpperCase(_name1);
    for i := 0 to TreeList.Items.Count-1 do begin
      Node:=TreeList.Items[i];
      s:=AnsiUpperCase(Node.Text);
      if s = sch then begin
        TreeList.Selected:=Node;
        Exit
      end;
    end;
    sch:=AnsiUpperCase(_name2);
    for i := 0 to TreeList.Items.Count-1 do begin
      Node:=TreeList.Items[i];
      s:=AnsiUpperCase(Node.Text);
      if s = sch then begin
        TreeList.Selected:=Node;
        Exit
      end;
    end;
    sch:=AnsiUpperCase(_name3);
    for i := 0 to TreeList.Items.Count-1 do begin
      Node:=TreeList.Items[i];
      s:=AnsiUpperCase(Node.Text);
      if s = sch then begin
        TreeList.Selected:=Node;
        Exit
      end;
    end;
  end;
end;


// ***********************************
// Выпадающее меню
// ***********************************


procedure TframeTreeDataModule.MnuAllVisible(val: boolean);
begin

  mnuInclInQuery.Visible           := val;  // Включить в опрос
  mnuExclFromQuery.Visible         := val;  // Исключить из опроса
  mnuDisableAll.Visible            := val;  // Отключить всех
  mnuExportNodeToExcel.Visible     := val;  // Экспортировать узел в Excel
  mnuSearchData.Visible            := val;  // Поиск данных
  mnuPollAll.Visible               := val;  // Опросить все
  mnuPollObjectByPattern.Visible   := val;  // Опросить объект по шаблону
  mnuReportEdit.Visible            := val;  // Выбор отчетов
  mnuAbonEdit.Visible              := val;  // Редактирование объекта
  mnuControlConnect.Visible        := val;  // Установить сеанс управления
  mnuControlDisconnect.Visible     := val;  // Завершить сеанс управления
  mnuObjectTreeManagement.Visible  := val;  // Управление деревом объектов
  mnuAddObject.Visible             := val;  // Добавить объект
  mnuDeleteMeter.Visible           := val;  // Удалить счетчик
  mnuOpenTransit.Visible           := val;  // Открыть транзитный доступ
  mnuCloseTransit.Visible          := val;  // Закрыть транзитный доступ
  mnuAddQryServer.Visible          := val;  // Добавить сервер опроса
  mnuAddGueryGroup.Visible         := val;  // Добавить группу опроса
end;

// ***********************************
// Экспорт Node в Excel
// ***********************************

procedure TframeTreeDataModule.mnuExportNodeToExcelClick(Sender: TObject);
var  Node  : TTreeNode;
     ID    : integer;
     WB    : TSheet;
     xf    : TXLSFile;
     FDir  : String;
     sNode : String;
begin
 try
  FDir := ExtractFilePath(Application.ExeName) + 'ExportData\' + 'Экспорт узла ';
  Node := TreeList.Selected;
  if Node <> nil then begin
    NodeData := Node.Data;
    xf:= TXLSFile.Create;
    WB:= XF.Workbook.Sheets[0];
    ID:=NodeData.ID;
    case NodeData.Code of
      SD_REGIN: GetNodeToExcel(ID, 1,  WB, sNode);
      SD_RAYON: GetNodeToExcel(ID, 2,  WB, sNode);
      SD_TOWNS: GetNodeToExcel(ID, 3,  WB, sNode);
      SD_TPODS: GetNodeToExcel(ID, 4,  WB, sNode);
      SD_STRET: GetNodeToExcel(ID, 5,  WB, sNode);
      SD_QGRUP: GetNodeToExcel(ID, 10, WB, sNode);
    end;
    FDir:=FDir + sNode + '.xls';
    xf.SaveAs(FDir);
    ShellExecute(0, 'open', PChar(FDir), nil, nil, SW_SHOW);
  end;
 finally
   if xf<>Nil then FreeAndNil(xf);
 end;
end;


function TframeTreeDataModule.GetNodeToExcel(Id, level:Integer; var WB:TSheet; var sNode : string):Boolean;
Var
    i, nCount  : Integer;
    strSQL, s  : String;
    RG, DP, TN : Shortint;
    TP, ST, QG : Shortint;
    HM, US, AD : Shortint;
begin
  case level of
    1  : s := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, L3D.M_SNAME DEPART, L3R.M_NREGNM REGION, ';
    2  : s := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, L3D.M_SNAME DEPART, ';
    3  : s := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, ';
    4  : s := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, ';
    5  : s := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, ';
    10 : s := 'SELECT L3A.M_SNAME HOUSE, L3S.M_SNAME STREET, L3TP.NAME TP, L3T.M_SNAME TOWN, L3D.M_SNAME DEPART, QG.NAME QGNAME, ';
  end;
  s := s + '  (SELECT FIRST 1 QM.M_SCOMMENT FROM L2TAG L2T, QM_METERS QM WHERE L2T.M_SWABOID = L3A.M_SWABOID AND QM.M_SWTYPE = L2T.M_SBYTYPE) USPD, ';
  s := s + '  (SELECT FIRST 1 L2T.M_SADVDISCL2TAG FROM L2TAG L2T WHERE L2T.M_SWABOID = L3A.M_SWABOID) ADVDISCL ';
  case level of
    1  : s := s + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, SL3REGION L3R ';
    2  : s := s + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D ';
    3  : s := s + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T ';
    4  : s := s + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP ';
    5  : s := s + 'FROM SL3ABON L3A, SL3STREET L3S ';
    10 : s := s + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, QUERYGROUP QG, QGABONS QA ';
  end;
  s := s + 'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ';
  if ((level >= 1) and (level <= 4)) or (level = 10) then s := s + '  AND L3A.TPID = L3TP.ID ';
  if ((level >= 1) and (level <= 3)) or (level = 10) then s := s + '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ';
  if ((level >= 1) and (level <= 2)) or (level = 10) then s := s + '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ';
  if (level = 1) then s := s + '  AND L3A.M_NREGIONID = L3R.M_NREGIONID ';
  if (level = 10) then s := s + '  AND L3A.M_SWABOID = QA.ABOID   AND QG.ID = QA.QGID ';
  case level of
    1  : s := s + '  AND L3R.M_NREGIONID = ' + IntToStr(Id) + ' ';
    2  : s := s + '  AND L3D.M_SWDEPID = ' + IntToStr(Id) + ' ';
    3  : s := s + '  AND L3T.M_SWTOWNID = ' + IntToStr(Id) + ' ';
    4  : s := s + '  AND L3TP.ID = ' + IntToStr(Id) + ' ';
    5  : s := s + '  AND L3S.M_SWSTREETID = ' + IntToStr(Id)+ ' ';
    10 : s := s + '  AND QG.ID =  '+ IntToStr(Id)+ ' ';
  end;
  case level of
    1  : s := s + 'ORDER BY REGION, DEPART, TOWN, TP, STREET, HOUSE';
    2  : s := s + 'ORDER BY DEPART, TOWN, TP, STREET, HOUSE';
    3  : s := s + 'ORDER BY TOWN, TP, STREET, HOUSE';
    4  : s := s + 'ORDER BY TP, STREET, HOUSE';
    5  : s := s + 'ORDER BY STREET, HOUSE';
    10 : s := s + 'ORDER BY DEPART, TOWN, TP, STREET, HOUSE';
  end;
  strSQL := s;

  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    i := 1;
    case level of
      1  : WB.Cells[0,0].Value:='Экспорт узла: Регион: ' + utlDB.DBase.IBQuery.FieldByName('REGION').AsString;
      2  : WB.Cells[0,0].Value:='Экспорт узла: Департамент: ' + utlDB.DBase.IBQuery.FieldByName('DEPART').AsString;
      3  : WB.Cells[0,0].Value:='Экспорт узла: Город: ' + utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
      4  : WB.Cells[0,0].Value:='Экспорт узла: ТП: ' + utlDB.DBase.IBQuery.FieldByName('TP').AsString;
      5  : WB.Cells[0,0].Value:='Экспорт узла: Улица: ' + utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
      10 : WB.Cells[0,0].Value:='Экспорт узла: Группа опроса: ' + utlDB.DBase.IBQuery.FieldByName('QGNAME').AsString;
    end;
    case level of
      1  : sNode := utlDB.DBase.IBQuery.FieldByName('REGION').AsString;
      2  : sNode := utlDB.DBase.IBQuery.FieldByName('DEPART').AsString;
      3  : sNode := utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
      4  : sNode := utlDB.DBase.IBQuery.FieldByName('TP').AsString;
      5  : sNode := utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
      10 : sNode := 'Группа опроса ' + utlDB.DBase.IBQuery.FieldByName('QGNAME').AsString;
    end;
    RG:=0;  DP:=0;  TN:=0;  TP:=0;  ST:=0;  QG:=0; HM:=0;  US:=0;  AD:=0;
    case level of
      1 : begin RG:=0;  DP:=1;  TN:=2;  TP:=3;  ST:=4;  QG:=-1; HM:=5;  US:=6; AD:=7; end;
      2 : begin RG:=-1; DP:=0;  TN:=1;  TP:=2;  ST:=3;  QG:=-1; HM:=4;  US:=5; AD:=6; end;
      3 : begin RG:=-1; DP:=-1; TN:=0;  TP:=1;  ST:=2;  QG:=-1; HM:=3;  US:=4; AD:=5; end;
      4 : begin RG:=-1; DP:=-1; TN:=-1; TP:=0;  ST:=1;  QG:=-1; HM:=2;  US:=3; AD:=4; end;
      5 : begin RG:=-1; DP:=-1; TN:=-1; TP:=-1; ST:=0;  QG:=-1; HM:=1;  US:=2; AD:=3; end;
     10 : begin RG:=-1; DP:=-1; TN:=1;  TP:=2;  ST:=3;  QG:=0;  HM:=4;  US:=5; AD:=6; end;
    end;

    if RG > 0 then WB.Cells[i,RG].Value:='Регион';
    if DP > 0 then WB.Cells[i,DP].Value:='Департамент';
    if TN > 0 then WB.Cells[i,TN].Value:='Город';
    if TP > 0 then WB.Cells[i,TP].Value:='ТП';
    if ST > 0 then WB.Cells[i,ST].Value:='Улица';
    if QG > 0 then WB.Cells[i,QG].Value:='Группа опроса';
    if HM > 0 then WB.Cells[i,HM].Value:='Дом';
    if US > 0 then WB.Cells[i,US].Value:='УСПД';
    if AD > 0 then WB.Cells[i,AD].Value:='Тип связи USPD -> ';
    inc(i);
    while not utlDB.DBase.IBQuery.Eof do Begin
      if RG > 0 then WB.Cells[i,RG].Value:=utlDB.DBase.IBQuery.FieldByName('REGION').AsString;
      if DP > 0 then WB.Cells[i,DP].Value:=utlDB.DBase.IBQuery.FieldByName('DEPART').AsString;
      if TN > 0 then WB.Cells[i,TN].Value:=utlDB.DBase.IBQuery.FieldByName('TOWN').AsString;
      if TP > 0 then WB.Cells[i,TP].Value:=utlDB.DBase.IBQuery.FieldByName('TP').AsString;
      if ST > 0 then WB.Cells[i,ST].Value:=utlDB.DBase.IBQuery.FieldByName('STREET').AsString;
      if QG > 0 then WB.Cells[i,QG].Value:=utlDB.DBase.IBQuery.FieldByName('QGNAME').AsString;
      if HM > 0 then WB.Cells[i,HM].Value:=utlDB.DBase.IBQuery.FieldByName('HOUSE').AsString;
      if US > 0 then WB.Cells[i,US].Value:=utlDB.DBase.IBQuery.FieldByName('USPD').AsString;
      if AD > 0 then WB.Cells[i,AD].Value:=ParseADVDISCL(utlDB.DBase.IBQuery.FieldByName('ADVDISCL').AsString, 7);
      utlDB.DBase.IBQuery.Next;
      Inc(i);
    End;
  end;
  utlDB.DBase.CloseQry;
  Result := true;
end;

// ***********************************
// Добавить группу опроса (не работает)
// ***********************************

procedure TframeTreeDataModule.mnuAddGueryGroupClick(Sender: TObject);
Var
    vID : Integer;
    Node : TTreeNode;
begin
//    nNode := FTreeModuleData.Selected;
    Node := TreeList.Selected;
    if Node = nil then exit;
    vID := TKnsForm.FindQsView;
    if vID=-1 then
    Begin
     TKnsForm.m_nQsFrame := TTQweryModule.Create(Owner);
     TKnsForm.m_nQsFrame.InitFrameID(-1,0);   // NodeData.ID;
    End else
    if vID<>-1 then
    Begin
     (TKnsForm.MDIChildren[vID] as TTQweryModule).Caption:= 'Группы опроса';
     (TKnsForm.MDIChildren[vID] as TTQweryModule).InitFrameID(-1,0);
     TKnsForm.MDIChildren[vID].Show;
  end;

end;

// ***********************************
// SQL для получения дополнительных данных (вероятно временно)
// ***********************************
function TframeTreeDataModule.GetOneParamFromID(ID, code: integer): integer;
var strSQL     : string;
    nCount     : integer;
begin
  Result := -1;
  case code of
    0 : strSQL:='SELECT M_SWVMID FROM SL3VMETERTAG WHERE M_SWMID = ' + intToStr(ID); // Виртуальный счетчик
    1 : strSQL:='SELECT M_SBYGROUPID FROM SL3GROUPTAG WHERE M_SWABOID = ' + intToStr(ID); // группа абонента
  end;
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    case code of
      0 : Result:=utlDB.DBase.IBQuery.FieldByName('M_SWVMID').AsInteger;
      1 : Result:=utlDB.DBase.IBQuery.FieldByName('M_SBYGROUPID').AsInteger;
    end;
  end;
end;

// ***********************************
// Сопоставление данных для получения отчетов старым методом
// ***********************************
procedure TframeTreeDataModule.SettingReportData(ID: integer; var CodeID, PosID: integer);
begin
  case ID of
{     0 : begin  CodeID := 1;  PosID := 79; end;   //  'Показания', ''Текущие показания электроэнергии'
     1 : begin  CodeID := 3;  PosID := 86; end;   //  'Показания', 'Баланс по дому'
     2 : begin  CodeID := 4;  PosID := 61; end;   //  'Показания', 'Анализ баланса потребления по объекту'
     3 : begin  CodeID := 5;  PosID := 74; end;   //  'Диагностические', 'Отчет о неопрошенных счетчиках на конец месяца'
     4 : begin  CodeID := 6;  PosID := 88; end;   //  'Диагностические', 'Отчет об ошибках опроса счетчиков за день'
     5 : begin  CodeID := 2;  PosID :=107; end;   //  'Настройки', 'Настройки отчетов'
     6 : begin  CodeID := 6;  PosID :=188; end;}
     1 : begin  CodeID := 1;  PosID := 79; end;   //  'Показания', ''Текущие показания электроэнергии'
     2 : begin  CodeID := 2;  PosID :=107; end;   //  'Настройки', 'Настройки отчетов'
     3 : begin  CodeID := 3;  PosID := 86; end;   //  'Показания', 'Баланс по дому'
     4 : begin  CodeID := 4;  PosID := 61; end;   //  'Показания', 'Анализ баланса потребления по объекту'
     5 : begin  CodeID := 5;  PosID := 74; end;   //  'Диагностические', 'Отчет о неопрошенных счетчиках на конец месяца'
     6 : begin  CodeID := 5;  PosID := 88; end;   //  'Диагностические', 'Отчет об ошибках опроса счетчиков за день'
  end;
end;

// ***********************************
// Поиск по TreeView
// ***********************************

procedure TframeTreeDataModule.SearchBoxChange(Sender: TObject);
var i       : Integer;
    s, sch  : string;
begin
  SearchListBox.Items.Clear;
  if Length(SearchBox.Text) > 2 then begin
    for i := 0 to TreeListBox.Count-1 do begin
      s:=AnsiUpperCase(TreeListBox.Strings[i]);
      sch:=AnsiUpperCase(SearchBox.Text);
      if Pos(sch, s) <> 0 then begin
        SearchListBox.Items.AddObject(TreeListBox.Strings[i], TreeListBox.Objects[i]);
      end;
    end;
    SearchListBox.Visible:=True;
  end else SearchListBox.Visible:=False;

//  SearchBox.SelStart:=Length(SearchBox.text);
end;

procedure TframeTreeDataModule.SearchListBoxClick(Sender: TObject);
var Node : TTreeNode;
begin
  if SearchListBox.ItemIndex <> -1 then begin
    Node:=TTreeNode(SearchListBox.Items.Objects[SearchListBox.ItemIndex]);
    TreeList.Selected := Node;
  end;
end;

procedure TframeTreeDataModule.SearchListBoxExit(Sender: TObject);
begin
  SearchListBox.Visible := False;
end;

procedure TframeTreeDataModule.SearchButtonClick(Sender: TObject);
begin
  SearchListBox.Visible:= not SearchListBox.Visible;
end;

// ***********************************
// Drag&Drop опция для вызова из knsl2fQweryMDL
// ***********************************
procedure TframeTreeDataModule.DragNDrop(IDDest: integer);
var i, code  : Integer;
    strSQL   : String;
    Id       : Integer;
    SL       : TStringList;
    Node     : TTreeNode;
    nCount   : integer;
begin
  Node := TreeList.Selected;
  if Node <> nil then begin
    NodeData := Node.Data;
    code:=NodeData.Code;
    Id := NodeData.ID;
    strSQL:='SELECT L3A.M_SWABOID ';
    case code of
      SD_REGIN : strSQL:=strSQL + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D, SL3REGION L3R ';
      SD_RAYON : strSQL:=strSQL + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T, SL3DEPARTAMENT L3D ';
      SD_TOWNS : strSQL:=strSQL + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP, SL3TOWN L3T ';
      SD_TPODS : strSQL:=strSQL + 'FROM SL3ABON L3A, SL3STREET L3S, SL3TP L3TP ';
      SD_STRET : strSQL:=strSQL + 'FROM SL3ABON L3A, SL3STREET L3S ';
      SD_ABONT : strSQL:=strSQL + 'FROM SL3ABON L3A ';
    end;
    if (code = SD_REGIN) or (code = SD_RAYON) or (code = SD_TOWNS) or (code = SD_TPODS) or
       (code = SD_STRET) then strSQL:=strSQL + 'WHERE L3A.M_SWSTREETID = L3S.M_SWSTREETID ';
    if (code = SD_REGIN) or (code = SD_RAYON) or (code = SD_TOWNS) or (code = SD_TPODS) then
        strSQL:=strSQL + '  AND L3A.TPID = L3TP.ID ';
    if (code = SD_REGIN) or (code = SD_RAYON) or (code = SD_TOWNS) then
        strSQL:=strSQL + '  AND L3A.M_SWTOWNID = L3T.M_SWTOWNID ';
    if (code = SD_REGIN) or (code = SD_RAYON) then strSQL:=strSQL + '  AND L3A.M_SWDEPID = L3D.M_SWDEPID ';
    if (code = SD_REGIN) then strSQL:=strSQL + '  AND L3A.M_NREGIONID = L3R.M_NREGIONID ';
    case Code of
      SD_REGIN : strSQL:=strSQL + '  AND L3R.M_NREGIONID = ' + IntToStr(Id) + ' ';
      SD_RAYON : strSQL:=strSQL + '  AND L3D.M_SWDEPID = ' + IntToStr(Id) + ' ';
      SD_TOWNS : strSQL:=strSQL + '  AND L3T.M_SWTOWNID = ' + IntToStr(Id) + ' ';
      SD_TPODS : strSQL:=strSQL + '  AND L3TP.ID = ' + IntToStr(Id) + ' ';
      SD_STRET : strSQL:=strSQL + '  AND L3S.M_SWSTREETID = ' + IntToStr(Id)+ ' ';
      SD_ABONT : strSQL:=strSQL + 'WHERE L3A.M_SWABOID = ' + IntToStr(Id)+ ' ';
    end;
    strSQL:=strSQL + 'ORDER BY L3A.M_SWABOID';
    if utlDB.DBase.OpenQry(strSQL,nCount) then begin
      // Реализация записи данных в виде блока одним запросом
      with utlDB.DBase do begin
        SL := TStringList.Create;
        SL.Add('EXECUTE BLOCK AS BEGIN ');
        for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do begin
          Id:=utlDB.DBase.IBQuery.FieldByName('M_SWABOID').AsInteger;
          SL.Add('UPDATE OR INSERT INTO QGABONS(QGID,ABOID,DTBEGINH,DTENDH,CURCOUNTER,DESCRIPTION,STATE,ENABLE) ');
          SL.Add('VALUES(' + IntToStr(IDDest) + ', ' + IntToStr(Id) + ', ' +
                         ''''+DateTimeToStr(now)+''''+ ','+''''+DateTimeToStr(now)+''''+ ','+
                         '0' +',' + ''' ''' + ',' + IntToStr(QUERY_STATE_NO) + ',' +'1) matching (QGID,ABOID);');

          if (i mod 50 = 0) and (i <> 0) then begin
            SL.Add('END ');
            ExecQrySL(SL);
            SL.Clear;
          end;
          utlDB.DBase.IBQuery.Next;
        end;
        SL.Add('END ');
        ExecQrySL(SL);
        if SL<>Nil then FreeAndNil(SL);//SL.Destroy;
      end;
    end;
  end;
  TKnsForm.m_nQsFrame.OnTimeElapsed(self);
  Application.ProcessMessages;
end;

procedure TframeTreeDataModule.mnuObjectTreeManagementClick(
  Sender: TObject);
var Node, NodeOW : TTreeNode;
    NodeData     : TNodeData;
    NodeDataOW   : TNodeData;
begin
  // заполнение структуры текущего элемента


  Node := TreeList.Selected;
  if Node <> nil then
  begin
    NodeData := Node.Data;
  {$IFNDEF TESTMODE}
   { TKnsForm.advButConf.Click;
    TKnsForm.FrameEditTreeView.NotVisableTabs;
    TKnsForm.FrameEditTreeView.TSVmeter.Visible := True;
    TKnsForm.FrameEditTreeView.TSAddress.Visible := True;
    TKnsForm.FrameEditTreeView.TSVmeter.AdvPages[0].TabVisible := true;
    TKnsForm.pcGEditor.Visible:=True;
    TKnsForm.pcGEditor.ActivePageIndex:=7;
    TKnsForm.FrameEditTreeView.TSVmeter.ActivePageIndex:=0;  }

(*    TKnsForm.FrameEditTreeView.Align:=alClient;
    TKnsForm.FrameEditTreeView.REGIN:=-1;
    TKnsForm.FrameEditTreeView.RAYON:=-1;
    TKnsForm.FrameEditTreeView.TOWNS:=-1;
    TKnsForm.FrameEditTreeView.TPODS:=-1;
    TKnsForm.FrameEditTreeView.STRET:=-1;
    case NodeData.Code of
      SD_REGIN : begin
        TKnsForm.FrameEditTreeView.REGIN := NodeData.ID;
      end;
      SD_RAYON : begin
        TKnsForm.FrameEditTreeView.RAYON := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        TKnsForm.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_TOWNS : begin
        TKnsForm.FrameEditTreeView.TOWNS := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        TKnsForm.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_TPODS : begin
        TKnsForm.FrameEditTreeView.TPODS := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        TKnsForm.FrameEditTreeView.TOWNS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_STRET : begin
        TKnsForm.FrameEditTreeView.STRET := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        TKnsForm.FrameEditTreeView.TPODS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.TOWNS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_ABONT : begin
        TKnsForm.FrameEditTreeView.ABONT := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        TKnsForm.FrameEditTreeView.STRET := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.TPODS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.TOWNS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Parent.Parent.Data;
        TKnsForm.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
    end;
    TKnsForm.FrameEditTreeView.Init(ETV_ADDRESS);
  {$ENDIF}

  end;   *)

    FEditTreeView.FrameEditTreeView.Align:=alClient;
    FEditTreeView.FrameEditTreeView.REGIN:=-1;
    FEditTreeView.FrameEditTreeView.RAYON:=-1;
    FEditTreeView.FrameEditTreeView.TOWNS:=-1;
    FEditTreeView.FrameEditTreeView.TPODS:=-1;
    FEditTreeView.FrameEditTreeView.STRET:=-1;
    case NodeData.Code of
      SD_REGIN : begin
        FEditTreeView.FrameEditTreeView.REGIN := NodeData.ID;
      end;
      SD_RAYON : begin
        FEditTreeView.FrameEditTreeView.RAYON := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        FEditTreeView.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_TOWNS : begin
        FEditTreeView.FrameEditTreeView.TOWNS := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        FEditTreeView.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_TPODS : begin
        FEditTreeView.FrameEditTreeView.TPODS := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        FEditTreeView.FrameEditTreeView.TOWNS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_STRET : begin
        FEditTreeView.FrameEditTreeView.STRET := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        FEditTreeView.FrameEditTreeView.TPODS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.TOWNS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
      SD_ABONT : begin
        FEditTreeView.FrameEditTreeView.ABONT := NodeData.ID;
        NodeDataOW := Node.Parent.Data;
        FEditTreeView.FrameEditTreeView.STRET := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.TPODS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.TOWNS := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.RAYON := NodeDataOW.ID;
        NodeDataOW := Node.Parent.Parent.Parent.Parent.Parent.Data;
        FEditTreeView.FrameEditTreeView.REGIN := NodeDataOW.ID;
      end;
    end;
    FEditTreeView.FrameEditTreeView.Init(ETV_ADDRESS);
   {$ENDIF}
    FEditTreeView.ShowModal;
   RefreshByID;
  end;
end;

procedure TframeTreeDataModule.mnuAddObjectClick(Sender: TObject);
begin
  // добавление нового элемента
{$IFNDEF TESTMODE}
{  TKnsForm.advButConf.Click;
  TKnsForm.FrameEditTreeView.NotVisableTabs;
  TKnsForm.FrameEditTreeView.TSVmeter.Visible := True;
  TKnsForm.FrameEditTreeView.TSAddress.Visible := True;
  TKnsForm.FrameEditTreeView.TSVmeter.AdvPages[0].TabVisible := true;
  TKnsForm.pcGEditor.Visible:=True;
  TKnsForm.pcGEditor.ActivePageIndex:=7;
  TKnsForm.FrameEditTreeView.TSVmeter.ActivePageIndex:=0;   }
(*  TKnsForm.FrameEditTreeView.Align:=alClient;
  TKnsForm.FrameEditTreeView.REGIN:=-1;
  TKnsForm.FrameEditTreeView.RAYON:=-1;
  TKnsForm.FrameEditTreeView.TOWNS:=-1;
  TKnsForm.FrameEditTreeView.TPODS:=-1;
  TKnsForm.FrameEditTreeView.STRET:=-1;
  TKnsForm.FrameEditTreeView.Init(ETV_ADDRESS); *)
  FEditTreeView.FrameEditTreeView.Align:=alClient;
  FEditTreeView.FrameEditTreeView.REGIN:=-1;
  FEditTreeView.FrameEditTreeView.RAYON:=-1;
  FEditTreeView.FrameEditTreeView.TOWNS:=-1;
  FEditTreeView.FrameEditTreeView.TPODS:=-1;
  FEditTreeView.FrameEditTreeView.STRET:=-1;
  FEditTreeView.FrameEditTreeView.Init(ETV_ADDRESS);
{$ENDIF}
end;


procedure TframeTreeDataModule.preRefresh;
var  Node       : TTreeNode;
begin
  Node := TreeList.Selected;
  if Node <> nil then begin
    _name1:=Node.Text;
    if Node.Parent <> nil then
      _name2:=Node.Parent.Text;
    if Node.Parent.Parent <> nil then
    _name3:=Node.Parent.Parent.Text;
  end;
end;

procedure TframeTreeDataModule.Refresh(rt : TRefreshType; value : string);
var mpDS       : CGDataSource;
    Node       : TTreeNode;
    i          : Integer;
    s, sch     : string;
    nNode      : TTreeNode;
begin
  // пока считается что только для абонента, нужно доработать
 // пока без проверки состояния возврата
    if rt = rtAddNew then _name1 := value;

    final;
    GetTreeView;
    sch:=AnsiUpperCase(_name1);
    for i := 0 to TreeList.Items.Count-1 do begin
      Node:=TreeList.Items[i];
      s:=AnsiUpperCase(Node.Text);
      if s = sch then begin
        TreeList.Selected:=Node;
        Exit
      end;
    end;
    sch:=AnsiUpperCase(_name2);
    for i := 0 to TreeList.Items.Count-1 do begin
      Node:=TreeList.Items[i];
      s:=AnsiUpperCase(Node.Text);
      if s = sch then begin
        TreeList.Selected:=Node;
        Exit
      end;
    end;
    sch:=AnsiUpperCase(_name3);
    for i := 0 to TreeList.Items.Count-1 do begin
      Node:=TreeList.Items[i];
      s:=AnsiUpperCase(Node.Text);
      if s = sch then begin
        TreeList.Selected:=Node;
        Exit
      end;
    end;
end;

procedure TframeTreeDataModule.RefreshByID;
var mpDS       : CGDataSource;
    Node       : TTreeNode;
    NodeData   : TNodeData;
    i, ID, code: Integer;
begin
  Node := TreeList.Selected;
  if Node <> nil then begin
    NodeData := Node.Data;
    ID := NodeData.ID;
    code := NodeData.Code;
  end;

  final;
  GetTreeView;

  for i := 0 to TreeList.Items.Count-1 do begin
    Node:=TreeList.Items[i];
    if Node <> nil then begin
      NodeData := Node.Data;
      if NodeData <> nil then
        if NodeData.Code = code then begin
          if NodeData.ID = ID then begin
            TreeList.Selected:=Node;
            Exit;
          end;
        end;
    end;
  end;
end;

procedure TframeTreeDataModule.RefreshGroupByID;
var mpDS       : CGDataSource;
    Node       : TTreeNode;
    NodeData   : TNodeData;
    i, ID, code: Integer;
begin
  Node := TreeList.Selected;
  if Node <> nil then begin
    NodeData := Node.Data;
    ID := NodeData.ID;
    code := NodeData.Code;
   end;

  final;
  GetTreeView;

  for i := 0 to TreeList.Items.Count-1 do begin
    Node:=TreeList.Items[i];
    if Node <> nil then begin
      NodeData := Node.Data;
      if NodeData <> nil then
        if NodeData.Code = SD_QGSOS then begin
          TreeList.Selected:=Node;
          Node.Expand(True);
          Break;
        end;
    end;
  end;
//  Node.Expand;
  for i := 0 to TreeList.Items.Count-1 do begin
    Node:=TreeList.Items[i];
    if Node <> nil then begin
      NodeData := Node.Data;
      if NodeData <> nil then begin
       if NodeData.Code = code then
        if NodeData.ID = ID then begin
          TreeList.Selected:=Node;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TframeTreeDataModule.btnRefreshClick(Sender: TObject);
begin
  RefreshByID;
end;

procedure TframeTreeDataModule.TreeListAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var Str1, Str2,oneChar: String;
i:integer;
rect1: TRect;
begin
 Str1:='Вкл.(авт)';
 Str2:=Node.Text;
 if ( Stage = cdPostPaint )then
  if Pos(Str1, Str2) > 0 then
   begin
     rect1:=Node.DisplayRect(true);
     for i := 1 to Length(Str1) do
     begin
      oneChar:= Str1[i];
      Sender.Canvas.Font.Color :=clRed; // clGreen;
      Sender.Canvas.Refresh();
       Sender.Canvas.TextOut(rect1.Left + 2, rect1.Top + 2, oneChar);
       rect1.Left :=rect1.Left+ Sender.Canvas.TextWidth(oneChar);
     end;
      DefaultDraw := false;
   end;
end;

procedure TframeTreeDataModule.ReportCorrectClick(Sender: TObject);
begin
  if knslRepCorrect<> nil then
   knslRepCorrect.ShowModal;
end;

initialization
  TreeListBox := TStringList.Create;
  GroupListBox := TStringList.Create;

finalization
  if TreeListBox <> nil then FreeAndNil(TreeListBox);//TreeListBox.Destroy;
  if GroupListBox <> nil then FreeAndNil(GroupListBox); //GroupListBox.Destroy;

end.






