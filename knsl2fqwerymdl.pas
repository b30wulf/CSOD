unit knsl2fqwerymdl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AdvCombo, ComCtrls, paramchklist, AdvOfficeButtons, treelist,
  AdvEdit, AdvOfficePager, AdvOfficePagerStylers, AdvAppStyler, AdvPanel,
  ExtCtrls, Menus, AdvMenus, editlist, AdvGlowButton, AdvToolBar, utltypes,
  utldatabase,knsl5config, AdvMenuStylers, AdvToolBarStylers,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers,{knsl2treehandler,} ImgList,utlconst,utlbox,knsl3jointable,
  AdvSplitter, GradientLabel, AdvGroupBox, Grids, BaseGrid, AdvGrid,knsl2cmplgrid,
  Spin,SyncObjs,utldynconnect, Mask, AdvSpin,AdvProgressBar, AdvEdBtn,
  EditBtn,knsl2QweryTrServer, Buttons, RxCtrls, utlStringGrid,CheckLst,
  frmQueryModule,knsl3EventBox, utlSendRecive;
type
{  CL3QweryTreeLoader = class(CTreeHandler)
   private
    treeid : CTreeIndex;
    function  CreateCTI:PCTI;override;
    function  IsTrueNode(nCTI:CTreeIndex):Boolean;override;
   public
    constructor Create(pTree:PTTreeView);
    destructor  Destroy;override;
    procedure   LoadTree;overload;
    procedure   setTreeIndex(vTreeid:CTreeIndex);
    procedure   OnLoadInParamDrop(src,dest:CTI;rtChild:TTreeNode);
    procedure   OnLoadInAbonDrop(src,dest:CTI;rtChild:TTreeNode);
    procedure   OnLoadInParam(nTI:CTI;rtChild:TTreeNode);

    procedure   createParam(qgID,cmdID:Integer);
    procedure   createGroupAbons(qgID:Integer;pTbl:SL3ABON);

    procedure   OnLoadVM(nTI:CTI;rtChild:TTreeNode);
    procedure   SetClusters(nTI:CTI;var pVM:SQWERYVM;rtChild:TTreeNode);
    function    CheckState(pQS:SQWERYMDL):Byte;
    procedure   SetParams(nTI:CTI;strCMD:String;rtChild:TTreeNode);
    procedure   LoadTreeID(nID:Integer);
  End; }
  TTQweryModule = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    QweryMdlstyler: TAdvFormStyler;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    sbQwery: TAdvOfficeStatusBar;
    ImageListQwery: TImageList;
    mnuCluster: TAdvPopupMenu;
    ImageList1: TImageList;
    //AdvMainMenu1: TAdvMainMenu;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N1: TMenuItem;
    miExecSetClust: TMenuItem;
    FTreeQweryData: TTreeView;
    advTreePanell: TAdvPanel;
    advTreeTool: TAdvToolBar;
    advButTree: TAdvGlowMenuButton;
    AdvPanel2: TAdvPanel;
    AdvSplitter1: TAdvSplitter;
    advSrvPager: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    AdvPanel5: TAdvPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    GradientLabel1: TGradientLabel;
    Label11: TLabel;
    chm_swDayMask: TCheckBox;
    clm_swDayMask: TParamCheckList;
    chm_sbyEnable: TCheckBox;
    clm_sdwMonthMask: TParamCheckList;
    chm_sdwMonthMask: TCheckBox;
    dtm_sdtPeriod: TDateTimePicker;
    dtm_sdtEnd: TDateTimePicker;
    dtm_sdtBegin: TDateTimePicker;
    edm_snSRVID: TAdvEdit;
    edm_snPID: TAdvEdit;
    edm_snCLID: TAdvEdit;
    btm_sdtBegin: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    cbm_snDeepFind: TComboBox;
    btm_sdtEnd: TAdvGlowButton;
    btm_sdtPeriod: TAdvGlowButton;
    btm_swDayMask: TAdvGlowButton;
    btm_sdwMonthMask: TAdvGlowButton;
    btm_sbyFindData: TAdvGlowButton;
    btm_sbyEnable: TAdvGlowButton;
    btm_sExecForGroup: TAdvGlowButton;
    edm_snAID: TAdvEdit;
    edm_snSRVIDc: TAdvEdit;
    cbm_strCMDCluster: TParamCheckList;
    dttm_sdtBegin: TDateTimePicker;
    dttm_sdtEnd: TDateTimePicker;
    cbm_nAddCommand: TComboBox;
    btm_nAddParam: TAdvGlowButton;
    btm_nSubParam: TAdvGlowButton;
    btm_nTopParam: TAdvGlowButton;
    btm_nSvClustGr: TAdvGlowButton;
    Label12: TLabel;
    edm_snSRVIDsrv: TAdvEdit;
    Label18: TLabel;
    edm_snAIDsrv: TAdvEdit;
    Label19: TLabel;
    edm_sName: TAdvEdit;
    chm_sbyEnableSrv: TCheckBox;
    advSaveSrv: TAdvGlowButton;
    advLoadSrv: TAdvGlowButton;
    advCreateSrv: TAdvGlowButton;
    Label1: TLabel;
    chm_sbyPause: TCheckBox;
    btm_sbyPause: TAdvGlowButton;
    lbDeepFind: TLabel;
    chm_sbyFindData: TAdvOfficeRadioGroup;
    btm_sdtBeginSAll: TAdvGlowButton;
    btm_sdtEndSAll: TAdvGlowButton;
    btm_sdtPeriodSAll: TAdvGlowButton;
    btm_swDayMaskSAll: TAdvGlowButton;
    btm_sdwMonthMaskSAll: TAdvGlowButton;
    btm_sExecForGroupSAll: TAdvGlowButton;
    btm_sbyEnableSAll: TAdvGlowButton;
    btm_sbyPauseSAll: TAdvGlowButton;
    btm_sbyFindDataSAll: TAdvGlowButton;
    mnuCtrl: TAdvPopupMenu;
    miStopSAll: TMenuItem;
    AdvMainMenu2: TAdvMainMenu;
    N14: TMenuItem;
    N16: TMenuItem;
    AdvGlowButton1: TAdvGlowButton;
    sgComplette: TAdvStringGrid;
    Label2: TLabel;
    btm_sAddClsTAll: TAdvGlowButton;
    miDelAllCls: TMenuItem;
    miDelCls: TMenuItem;
    N30: TMenuItem;
    Label3: TLabel;
    sem_nSrvWarning: TSpinEdit;
    AdvOfficePage1: TAdvOfficePage;
    edQGName: TAdvEdit;
    Label8: TLabel;
    cbQGEnable: TCheckBox;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvOfficePage2: TAdvOfficePage;
    sgQGroup: TAdvStringGrid;
    AdvOfficePage3: TAdvOfficePage;
    Label9: TLabel;
    Label10: TLabel;
    Label20: TLabel;
    dtBegin: TDateTimePicker;
    dtEnd: TDateTimePicker;
    dtPeriod: TDateTimePicker;
    cbDayMask: TCheckBox;
    cbMonthMask: TCheckBox;
    clmDayMask: TParamCheckList;
    clmMonthMask: TParamCheckList;
    Label21: TLabel;
    Label22: TLabel;
    mdtEnd: TDateTimePicker;
    mdtBegin: TDateTimePicker;
    Label23: TLabel;
    cbDeepFind: TComboBox;
    cbEnable: TCheckBox;
    cbPause: TCheckBox;
    cbFindUpdate: TCheckBox;
    saveParams: TAdvGlowButton;
    GradientLabel2: TGradientLabel;
    GradientLabel3: TGradientLabel;
    queryStart: TAdvGlowButton;
    qgMenu: TAdvPopupMenu;
    MenuItem14: TMenuItem;
    stopButton: TAdvGlowButton;
    AdvPanel4: TAdvPanel;
    AdvToolBar2: TAdvToolBar;
    statButt: TAdvGlowMenuButton;
    pmMnuStat: TAdvPopupMenu;
    itAllGroup: TMenuItem;
    itElement: TMenuItem;
    Label24: TLabel;
    lbParam: TLabel;
    em_strVTPath: TEdit;
    GradientLabel4: TGradientLabel;
    Label98: TLabel;
    autoUnload: TAdvGlowButton;
    Label103: TLabel;
    cbm_snVTDeepFind: TComboBox;
    chm_sbyVTEnable: TCheckBox;
    btUnloadStart: TAdvGlowButton;
    nClearAbons: TMenuItem;
    nSetAbons: TMenuItem;
    N31: TMenuItem;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    advSort: TAdvPopupMenu;
    nameItem: TMenuItem;
    beginItem: TMenuItem;
    endItem: TMenuItem;
    allItem: TMenuItem;
    isokItem: TMenuItem;
    iserItem: TMenuItem;
    stateItem: TMenuItem;
    TypeItem: TMenuItem;
    cbRunStatus: TCheckBox;
    clmRunStatus: TParamCheckList;
    spinError: TAdvSpinEdit;
    Label25: TLabel;
    N32: TMenuItem;
    setNullState: TMenuItem;
    AdvGlowButton7: TAdvGlowButton;
    AdvGlowButton8: TAdvGlowButton;
    AdvGlowButton9: TAdvGlowButton;
    AdvGlowButton10: TAdvGlowButton;
    AdvGlowButton11: TAdvGlowButton;
    AdvGlowButton12: TAdvGlowButton;
    AdvGlowButton13: TAdvGlowButton;
    AdvGlowButton14: TAdvGlowButton;
    AdvGlowButton15: TAdvGlowButton;
    AdvGlowButton16: TAdvGlowButton;
    AdvGlowButton17: TAdvGlowButton;
    AdvGlowButton18: TAdvGlowButton;
    AdvGlowButton19: TAdvGlowButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    FindBtn: TAdvGlowButton;
    FindEdit: TAdvEdit;
    enable: TMenuItem;
    cbPacket_KUB: TCheckBox;
    Init_PACKET_KUB1: TAdvGlowButton;
    N33: TMenuItem;
//    PrBar : TPrgBar;
    spinError2: TAdvSpinEdit;
    AdvGlowButton20: TAdvGlowButton;
    Label26: TLabel;
    Label27: TLabel;
    AdvGlowButton21: TAdvGlowButton;
    TimeToStop: TDateTimePicker;
    ExtractListBox: TCheckListBox;
    ExtractBitBtn: TBitBtn;
    N34: TMenuItem;
    setNullStateQuality: TMenuItem;
    frameQM: TFrameQueryModule;
    btnRefresh: TAdvGlowButton;
    procedure OnClickTree(Sender: TObject);
    procedure OnLoadQwery(Sender: TObject);
    procedure OnClickWDay(Sender: TObject);
    procedure chm_sdwMonthMaskClick(Sender: TObject);

    procedure OnSaveButt(Sender: TObject);
    procedure OnResizePannel(Sender: TObject);
    procedure miFindDataClick(Sender: TObject);
    procedure OnClickFind(Sender: TObject);
    procedure miExecSetClustClick(Sender: TObject);
    procedure btm_sdtBeginClick(Sender: TObject);
    procedure btm_sdtEndClick(Sender: TObject);
    procedure btm_sdtPeriodClick(Sender: TObject);
    procedure btm_swDayMaskClick(Sender: TObject);
    procedure btm_sdwMonthMaskClick(Sender: TObject);
    procedure btm_sbyFindDataClick(Sender: TObject);
    procedure btm_sbyEnableClick(Sender: TObject);
    procedure btm_sExecForGroupClick(Sender: TObject);
    procedure miExecSetAllClustClick(Sender: TObject);
    procedure dttm_sdtBeginChange(Sender: TObject);
    procedure btm_nTopParamClick(Sender: TObject);
    procedure btm_nBottParamClick(Sender: TObject);
    procedure btm_nSubParamClick(Sender: TObject);
    procedure btm_nSvClustGrClick(Sender: TObject);
    procedure advSaveSrvClick(Sender: TObject);
    procedure advCreateSrvClick(Sender: TObject);
    procedure OnDragVmOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OnDragVmDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btm_sbyPauseClick(Sender: TObject);
    procedure FTreeQweryDataExpanded(Sender: TObject; Node: TTreeNode);
    procedure OnStopAll(Sender: TObject);
    procedure btm_sdtBeginSAllClick(Sender: TObject);
    procedure btm_sdtEndSAllClick(Sender: TObject);
    procedure btm_sdtPeriodSAllClick(Sender: TObject);
    procedure btm_swDayMaskSAllClick(Sender: TObject);
    procedure btm_sdwMonthMaskSAllClick(Sender: TObject);
    procedure btm_sbyFindDataSAllClick(Sender: TObject);
    procedure btm_sbyEnableSAllClick(Sender: TObject);
    procedure btm_sbyPauseSAllClick(Sender: TObject);
    procedure btm_sExecForGroupSAllClick(Sender: TObject);
    procedure miStopSAllClick(Sender: TObject);
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
    procedure OnGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure btm_sAddClsTAllClick(Sender: TObject);
    procedure miDelAllClsClick(Sender: TObject);
    procedure miDelClsClick(Sender: TObject);
    procedure OnOpenForm(Sender: TObject);
    procedure OnSaveQGName(Sender: TObject);
    procedure OnDelQgroup(Sender: TObject);
    procedure OnAddNewGroup(Sender: TObject);
    procedure cbDayMaskClick(Sender: TObject);
    procedure cbMonthMaskClick(Sender: TObject);
    procedure saveParamsClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sgQGroupGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure sgQGroupCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure OnDelIAbonItem(Sender: TObject);
    procedure sgQGroupClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure queryStartClick(Sender: TObject);
    procedure findButtonClick(Sender: TObject);
    procedure stopButtonClick(Sender: TObject);
    procedure mdtBeginChange(Sender: TObject);
    procedure itAllGroupClick(Sender: TObject);
    procedure pmMnuStatPopup(Sender: TObject);
    procedure itElementClick(Sender: TObject);
    procedure statButtClick(Sender: TObject);
    procedure autoUnloadClick(Sender: TObject);
    procedure btUnloadStartClick(Sender: TObject);
    procedure nClearAbonsClick(Sender: TObject);
    procedure nSetAbonsClick(Sender: TObject);
    procedure nameItemClick(Sender: TObject);
    procedure cbRunStatusClick(Sender: TObject);
    procedure setNullStateClick(Sender: TObject);
    procedure setGroupParam(Sender: TObject);
    procedure FindBtnClick(Sender: TObject);
    procedure FindEditChange(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure sgQGroupButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure sgQGroupMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgQGroupMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgQGroupBtnClic;
    procedure miAddAllClsClick(Sender: TObject);
    procedure FTreeQweryDataMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ExtractBitBtnClick(Sender: TObject);
    procedure setNullStateQualityClick(Sender: TObject);
    function  ReplaseSt(s, substr: string):string;
    procedure btnRefreshClick(Sender: TObject);
  private
//    _PQGD       : Integer;
    TSGsgQGroup : TSG;
//    DragFromNewTL : boolean;
    OwnerForm   : TComponent;
    old_sorting : integer;
    old_decs    : boolean;
    SortingCol  : Integer;
    RowClick    : Integer;
    m_nSRV       : SQWERYSRVS;
    ParmsList   : QM_PARAMS;
//    m_nTree     : CL3QweryTreeLoader;            // BO 8/10/19
//    m_nCTI      : CTreeIndex;
    m_sFilter   : String;
    m_pRPDS     : CGDataSource;
    m_nJOIN     : CJoinTable;
    m_sQC       : SQWERYCMDID;
    m_sTblL1    : SL1INITITAG;
    m_nCGrid    : CCmplGrid;
//    csFrame     : TCriticalSection;
//    qgID        : Integer;
    qgIDName    : String;
//    qgParamID   : Integer;
//    qgParamName : String;
    m_nTehnoLen : Integer;
    qgAbon      : Integer;
    timer       : TTimer;
    queryState  : TStringList;
    nodeText    : String;
    pDb         : CDBDynamicConn;
    sortString  : String;
    CurrentFindRow : integer;
    mouseXY     : TPoint;
    function GetStateMask:String;
    function createSortString():String;
    function getHint(item:TMenuItem;sort:String):String;
//    procedure OnTimeElapsed(Sender:TObject);dynamic;
    function  GetToScreen:QGPARAM;
    procedure SetToScreen(pTbl:QGPARAM);
    procedure LoadSateMask(strStatus:String);
    procedure setRunCheck(name:String);
    procedure getStrings(s1:String;var value:TStringList);
    procedure LoadDayChBoxEx(dwDayWMask:Dword);
    procedure LoadMonthChBoxEx(dwDayMask:Dword);
    function  GetWDayMaskEx:Word;
    function  GetMDayMaskEx:DWord;
//    procedure loadInQueryPannel(index:CTreeIndex);                         // BO 8/10/19 2   +
//    procedure loadInQueryParams(index:CTreeIndex);                         // BO 8/10/19 2   +
    procedure AddRecordToGrid(nIndex:Integer;pTbl:qgabons);
//    procedure loadInQueryAbons(index:CTreeIndex);                          // BO 8/10/19 2   +
    procedure LoadCommanList(snMID:Integer);
    procedure LoadDayChBox(dwDayWMask:Dword);
    procedure LoadMonthChBox(dwDayMask:Dword);
//    procedure LoadEdit(nCTI:CTreeIndex);                                   // BO 8/10/19 2
//    procedure LoadSrvEdit(nCTI:CTreeIndex);                                  // BO 8/10/19 2
//    procedure LoadCompletteGrid(nCTI:CTreeIndex);                            // BO 8/10/19 2
    procedure LoadCluster(strCluster:String);
    procedure SetDefaultCluster(var pT:SQWERYVM);
    function  GetWDayMask:Word;
    function  GetMDayMask:DWord;
    function  GetCluster:String;
//    function  GetExpression(nCTI:CTreeIndex):String;                       // BO 8/10/19 2
    procedure GetEdits(var pTbl:SQWERYMDL);
    procedure SendQSCommEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
    procedure SendPMsg(byBox:Integer;byIndex:Integer;byFor,byType:Byte;var pDS:CMessageData);
    procedure CheckFind(blMenu:Boolean);
    procedure MenuPrepareVM;
    procedure MenuPrepareSRV;
    function GenIndex:Integer;
    function GenIndexSv:Integer;
    function SetIndex(nIndex:Integer):Integer;
    Procedure FreeIndex(nIndex:Integer);
    Procedure FreeAllIndex;

    procedure PrepareIndex;
    procedure PrepareIndexQC(snSRVID:Integer);
    procedure RefreshTree;
    procedure LoadTreeView;
    procedure VisableGroupB(vis : boolean);
    procedure VisableGroupC(vis : boolean);
    procedure VisableGroupD(vis : boolean);
//    procedure VisableAny(tz : integer);
  protected
    RecivedClass        : TRecivedClass;
    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;
  public
    { Public declarations }
    DragFromNewTL : boolean;
    _PQGD       : Integer;
    qgID        : Integer;
    qgParamName : String;
    qgParamID   : Integer;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
//    procedure InitFrame(nCTI:PCTreeIndex;nPIndex:Integer);              // BO 8/10/19 2
    procedure InitFrameID(nID:integer;nPIndex:Integer);
//    procedure PrepareFrame(nCTI:PCTreeIndex;nPIndex:Integer);           // BO 8/10/19 2
//    procedure InitFrameADD(nCTI:PCTreeIndex;nPIndex:Integer);           // BO 8/10/19 2
    procedure InitFrameADDID(nID : integer; nPIndex : Integer);
    procedure PrepareQueryAbon(sQC : SQWERYCMDID);   
//    procedure ClearUnloadButton;
    procedure loadInQueryPannelID(ID : integer; NAME : string; ENABLE : integer);
    procedure loadInQueryAbonsID(ID:Integer);
    procedure loadInQueryParamsID(ID, param: integer);
    procedure VisableAny(tz : integer);
    procedure SendQSComm(nCommand,snSRVID,snPrmID:Integer);overload;
    procedure SendQSComm(snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);overload;
    procedure SendQSData(nCommand,snSRVID,snCLID,nCLSID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);overload;
    procedure SendQSData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);overload;
    procedure SendQSTreeData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure OnTimeElapsed(Sender:TObject);dynamic;
    procedure AutoStartOnError;            
  end;


implementation
 //uses  knsl2QweryTrServer;

{$R *.DFM}

uses fLogFile, fLogTypeCommand, frmTreeDataModule, knsl5module, knsl4secman,utlDB;


Constructor TTQweryModule.Create(AOwner: TComponent);
begin
  OwnerForm := AOwner;
  inherited Create(AOwner);
  
  TQweryModuleHandle  := Handle;
  TQweryModuleThead   := GetCurrentThread;
  TQweryModuleTheadID := GetCurrentThreadID;

  if RecivedClass=Nil then RecivedClass := TRecivedClass.Create;
  TSGsgQGroup:=TSG.Create;
  TSGsgQGroup.Activate(sgQGroup);
  SortingCol:=0;
  TSGsgQGroup.SetColCount(18);   // BO 03.04.2019
  sgQGroup.ColWidths[1]:=0;
  sgQGroup.ColWidths[2]:=0;
  sgQGroup.ColWidths[11]:=0;
end;

Destructor TTQweryModule.Destroy;
begin
  FrameQM.DeActivate;
  if queryState <> nil then FreeAndNil(queryState);
  if m_nCGrid <> nil then FreeAndNil(m_nCGrid);
//  if m_nTree <> nil then FreeAndNil(m_nTree);                     // BO 8/10/19
  if pDb <> nil then
   begin
    pDb.Disconnect;
    FreeAndNil(pDb);
   end;   //m_pDB.DiscDynConnect(pDb);
  TSGsgQGroup.DeActivate;
  FreeAndNil(TSGsgQGroup);
  if RecivedClass<>Nil then FreeAndNil(RecivedClass);
  inherited;
  TKnsForm.m_nQsFrame := nil;
end;




(*                                                            // BO 8/10/19
//CL3QweryTreeLoader
constructor CL3QweryTreeLoader.Create(pTree : PTTreeView);
Begin
     inherited Create(pTree);
End;
destructor  CL3QweryTreeLoader.Destroy;
Begin
     inherited Destroy;
End;
procedure  CL3QweryTreeLoader.setTreeIndex(vTreeid:CTreeIndex);
Begin
     treeid := vTreeid;
End;
function CL3QweryTreeLoader.CreateCTI:PCTI;
Var
    pTI : PCTI;
Begin
    m_sNI.m_sbyLOCK := 5;
    m_sNI.m_sbyUNLK := 7;
    m_sNI.m_sbyALOK := 8;
    m_sNI.m_sbyCVRY := 6;
    m_sNI.m_sbyALRM := 8;
    m_sNI.m_sbyREDY := 9;
    New(pTI);
    pTI^ := CTI.Create(m_sNI);
    Result := pTI;
End;
function  CL3QweryTreeLoader.IsTrueNode(nCTI:CTreeIndex):Boolean;
Begin
    Result := (nCTI.PTSD=SD_CLUST);
End;

procedure CL3QweryTreeLoader.LoadTree;
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : querygroup;
     nI0,nI1,nI2 : CTI;
     node  : TTreeNode;
     i     : Integer;
Begin
     FreeTree;
     pTbl  := TThreadList.Create;
     if m_pDB.GetQueryGroups(treeid.PQGD,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       nI0  := CTI.Create(11,SD_QGRUP,PD_UNKNW,1);
       nI0.setQueryGroup(data.id);
       node := SetInNode(nI0,nil,data.name);
       FreeAndNil(nI0);

       nI2  := CTI.Create(13,SD_QGPAR,PD_UNKNW,1);
       nI2.setQueryGroup(data.id);
       SetInNode(nI2,SetInNode(nI2,node,'Задачи'),'A');
       FreeAndNil(nI2);

       nI1  := CTI.Create(12,SD_QGSOS,PD_UNKNW,1);
       nI1.setQueryGroup(data.id);
       SetInNode(nI1,node,'Объекты опроса');
       FreeAndNil(nI1);
      End;
      pTbl.UnlockList;
     End;
    ClearListAndFree(pTbl);
End;

procedure CL3QweryTreeLoader.LoadTreeID(nID:Integer);
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : querygroup;
     nI0,nI1,nI2 : CTI;
     node  : TTreeNode;
     i     : Integer;
Begin
     FreeTree;
     pTbl  := TThreadList.Create;
     if m_pDB.GetQueryGroups(nID,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       nI0  := CTI.Create(11,SD_QGRUP,PD_UNKNW,1);
       nI0.setQueryGroup(data.id);
       node := SetInNode(nI0,nil,data.name);
       FreeAndNil(nI0);

       nI2  := CTI.Create(13,SD_QGPAR,PD_UNKNW,1);
       nI2.setQueryGroup(data.id);
       SetInNode(nI2,SetInNode(nI2,node,'Задачи'),'A');
       FreeAndNil(nI2);

       nI1  := CTI.Create(12,SD_QGSOS,PD_UNKNW,1);
       nI1.setQueryGroup(data.id);
       SetInNode(nI1,node,'Объекты опроса');
       FreeAndNil(nI1);
      End;
      pTbl.UnlockList;
     End;
    // nI0.Destroy;   //вопрос при удалении группы
    // nI1.Destroy;   //вопрос при удалении группы
    // nI2.Destroy;
    ClearListAndFree(pTbl);
End;


procedure CL3QweryTreeLoader.OnLoadInParam(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : qgparam;
     nI0   : CTI;
     node  : TTreeNode;
     i     : Integer;
Begin
     pTbl  := TThreadList.Create;
     if m_pDB.getQueryGroupsParam(nTI.m_nCTI.PQGD,-1,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       nI0  := CTI.Create(3,SD_QGCOM,PD_UNKNW,data.enable);
       nI0.setQueryGroup(data.QGID);
       nI0.setQGroupParam(data.param);
       node := SetInNode(nI0,rtChild,data.PARAMNM);
       FreeAndNil(nI0);
      End;
      pTbl.UnlockList;
     End;
     ClearListAndFree(pTbl);
End;

procedure CL3QweryTreeLoader.OnLoadInParamDrop(src,dest:CTI;rtChild:TTreeNode);
Var
     pTbl  : CCOMMANDS;
     nI    : CTI;
     node  : TTreeNode;
     i     : Integer;
Begin
     if m_pDB.GetCommandsTable(src.m_nCTI.PMID ,pTbl) then
     Begin
      for i:=0 to pTbl.m_swAmCommand-1 do
      Begin
       if (pTbl.m_sCommand[i].m_swCmdID=QRY_AUTORIZATION) or (pTbl.m_sCommand[i].m_swCmdID=QRY_EXIT_COM) then continue;
       //nI := CTI.Create(2,SD_QGCOM,PD_UNKNW,1);
       //nI.setCommand(pTbl.m_sCommand[i].m_swCmdID);
       //SetInNode(nI,rtChild,pTbl.m_sCommand[i].m_swCommandNm);
       createParam(dest.m_nCTI.PQGD, pTbl.m_sCommand[i].m_swCmdID);
      End;
     End;
     OnLoadInParam(dest,rtChild);
End;


procedure CL3QweryTreeLoader.OnLoadInAbonDrop(src,dest:CTI;rtChild:TTreeNode);
Var
     pTbl : SL3ABONS;
     i, j  : Integer;
     List  : TList;
     ID    : integer;
Begin
   if src.m_nCTI.PAID<>-1 then begin
     if m_pDB.GetAbonTable(src.m_nCTI.PAID,pTbl)=True then begin
       createGroupAbons(dest.m_nCTI.PQGD, pTbl.Items[0]);
     end;
   end else begin
     List := TList.Create;
     if src.m_nCTI.PNID = PD_UNKNW then begin
       case src.m_nCTI.PTSD of
         SD_REGIN: begin  // Регион
           ID:=src.m_nCTI.PRID;
           m_pDB.GetNodeToQueryGrop(ID, 1, List);
         end;
         SD_RAYON: begin  // Департамент
           ID:=src.m_nCTI.PRYD;
           m_pDB.GetNodeToQueryGrop(ID, 2, List);
         end;
         SD_TOWNS: begin  // Город
           ID:=src.m_nCTI.PTWN;
           m_pDB.GetNodeToQueryGrop(ID, 3, List);
         end;
         SD_TPODS: begin  // ТП
           ID:=src.m_nCTI.PTPS;
           m_pDB.GetNodeToQueryGrop(ID, 4, List);
         end;
         SD_STRET: begin  // Улица
           ID:=src.m_nCTI.PSTR;
           m_pDB.GetNodeToQueryGrop(ID, 5, List);
         end;
       end;
     end;
     for j := 0 to List.Count - 1 do begin
       ID := Integer(List[j]);
       if m_pDB.GetAbonTable(ID,pTbl)=True then begin
         createGroupAbons(dest.m_nCTI.PQGD, pTbl.Items[0]);
       end;

     end;
     List.Destroy;
     End;
End;

procedure   CL3QweryTreeLoader.createGroupAbons(qgID:Integer;pTbl:SL3ABON);
Var
     data : QGABONS;
Begin
     data             := QGABONS.Create;
     data.id          := -1;
     data.QGID        := qgID;
     data.ABOID       := pTbl.m_swABOID;
     data.DTBEGINH    := now;
     data.ALLCOUNTER  := 0;
     data.CURCOUNTER  := '0';
     data.ISOK        := 0;
     data.ISNO        := 0;
     data.ISER        := 0;
     data.PERCENT     := 0;
     data.DESCRIPTION := '';
     data.STATE       := TASK_WAIT_RUN;
     data.ENABLE      := 1;
     m_pDB.addQueryGroupAbon(data);
     m_pDB.setQueryState(data.ABOID,-1,QUERY_STATE_NO);//очищает все прогресс бар
     if data<>nil then FreeAndNil(data);
End;

procedure   CL3QweryTreeLoader.createParam(qgID,cmdID:Integer);
Var
     data : QGPARAM;
Begin
     data := QGPARAM.Create;
     data.id        := -1;
     data.QGID      := qgID;
     data.PARAM     := cmdID;
     data.DTBEGIN   := Now;
     data.DTEND     := Now;
     data.DTPERIOD  := Now;
     data.MONTHMASK := 0;
     data.ENABLE    := 0;
     data.DEEPFIND  := 0;
     data.PAUSE     := 0;
     data.FINDDATA  := 0;
     m_pDB.addQueryGroupParam(data);
End;

procedure CL3QweryTreeLoader.OnLoadVM(nTI:CTI;rtChild:TTreeNode);
Var
     pTbl : SQWERYVM;
Begin
     if m_pDB.GetQweryVM(nTI.m_nCTI.PGID,nTI.m_nCTI.PCID,pTbl)=True then
     SetClusters(nTI,pTbl,rtChild);
End;
procedure   CL3QweryTreeLoader.SetClusters(nTI:CTI;var pVM:SQWERYVM;rtChild:TTreeNode);
Var
     nI : CTI;
     byState : Byte;
     i:Integer;
Begin
     with nTI.m_nCTI,pVM.Item do
     Begin   //PGID=m_snSRVID PCID=m_snCLID PTID=m_snCLSID
     for i:=0 to pVM.Item.Count-1 do
      Begin
       nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,PGID,PVID,PMID,PPID,PCID,Items[i].m_snCLSID,$ffff,$ffff,CheckState(Items[i]));
       SetParams(nI,Items[i].m_strCMDCluster ,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[Items[i].m_snCLSID]));
       nI.Destroy;
      End;
     End;
End;
procedure  CL3QweryTreeLoader.SetParams(nTI:CTI;strCMD:String;rtChild:TTreeNode);
Var
     i     : Integer;
     nI    : CTI;
     nCode : Integer;
     str   : String;
Begin
     str := strCMD;
     while GetCode(nCode,str)=True do
     Begin
      nCode := (nCode and $7fff);
      with nTI.m_nCTI do
      Begin
       nI       := CTI.Create(0,SD_VPARM,PD_CLUST,PRID,PAID,PGID,PVID,PMID,PPID,PCID,PTID,nCode,0);
       SetInNode(nI,rtChild,m_nCommandList.Strings[nCode]);
       nI.Destroy;
      End;
     End;
End;
function CL3QweryTreeLoader.CheckState(pQS:SQWERYMDL):Byte;
Begin
     Result := SA_LOCK;
     if pQS.m_sbyEnable=1 then Result:=SA_UNLK else
     if pQS.m_sbyEnable=0 then Result:=SA_REDY;
End;       *)








(*
procedure TTQweryModule.InitFrame(nCTI:PCTreeIndex;nPIndex:Integer);
Var
     strCurrentDir : String;
  i : integer;
  Bool : Boolean;
begin
   ExtractListBox.Visible := false;
   _PQGD := nCTI.PQGD;
   FrameQM.Align:= alClient;
   FrameQM.Activate(_PQGD);
   CurrentFindRow := 0;
   Bool :=m_nUM.CheckPermitt(SA_USER_PERMIT_QYG,true,m_blNoCheckPass);
   if not Bool then begin
     AdvGlowButton6.Enabled := False;
     stopButton.Enabled := False;
     queryStart.Enabled:= False;
     saveParams.Enabled := False;
   end;
     //csFrame.Enter;
     //m_pDB.GetL1Table(m_sTblL1);
     //Move(nCTI^,m_nCTI,sizeof(CTreeIndex));
     //m_sQC.m_snABOID := -1;
     //m_nCF.m_nSetColor.PQweryMdlstyler := @QweryMdlstyler;
     //qgID := -1;
//     if m_nTree=Nil  then m_nTree  := CL3QweryTreeLoader.Create(@FTreeQweryData);       // BO 8/10/19
     if m_nCGrid=Nil then m_nCGrid := CCmplGrid.Create(sgComplette);                      
//     m_nTree.setTreeIndex(nCTI^);                                                       // BO 8/10/19
//     m_nTree.LoadTree;                                                                  // BO 8/10/19

    { sgQGroup.ColCount    := 18;
      sgQGroup.RowCount    := 2;
      TSGsgQGroup.SetColCount(18);   // BO 03.04.2019
      sgQGroup.ColWidths[1]:=0;
      sgQGroup.ColWidths[2]:=0;
      sgQGroup.ColWidths[11]:=0; }

     old_sorting := 0;
     old_decs    := false;
     SortingCol  :=5;
     sgQGroupBtnClic;
     
     m_nTehnoLen          := 0+0+0+40+40+80+60+60+45+45+45+0+45+100+100+100+100;
     formResize(self);
     //advSrvPager.ActivePageIndex := 0;
     //RefreshTree;
     advSrvPager.AdvPages[0].TabVisible:=false;
     advSrvPager.AdvPages[1].TabVisible:=false;
     advSrvPager.AdvPages[2].TabVisible:=true;
     mdtBegin.DateTime := Now;
     mdtEnd.DateTime   := Now;
     LoadTreeView;
    // m_nTree
    // LoadSrvEdit(m_nCTI);
    // csFrame.Leave;
end;
*)

procedure TTQweryModule.InitFrameID(nID:integer;nPIndex:Integer);
Var
  strCurrentDir : String;
  i    : integer;
  Bool : Boolean;
begin
   FrameQM.Align:= alClient;
   FrameQM.Activate(nID);
   CurrentFindRow := 0;
   Bool :=m_nUM.CheckPermitt(SA_USER_PERMIT_QYG,false,m_blNoCheckPass);
   if not Bool then begin
     stopButton.Enabled     := False;
     queryStart.Enabled     := False;
     saveParams.Enabled     := False;
   end;
//     if m_nTree=Nil  then m_nTree  := CL3QweryTreeLoader.Create(@FTreeQweryData);                    // BO 8/10/19
     if m_nCGrid=Nil then m_nCGrid := CCmplGrid.Create(sgComplette);
//     m_nTree.LoadTreeID(nID);                                                                        // BO 8/10/19

  old_sorting := 0;
  old_decs    := false;
  SortingCol  :=5;
  sgQGroupBtnClic;

  m_nTehnoLen          := 0+0+0+40+40+80+60+60+45+45+45+0+45+100+100+100+100;
  formResize(self);
  advSrvPager.AdvPages[0].TabVisible:=false;
  advSrvPager.AdvPages[1].TabVisible:=false;
  advSrvPager.AdvPages[2].TabVisible:=true;
  mdtBegin.DateTime := Now;
  mdtEnd.DateTime   := Now;
  LoadTreeView;
end;

(*
////Для добавления группы опроса/////////
procedure TTQweryModule.InitFrameADD(nCTI:PCTreeIndex;nPIndex:Integer);
Var
     strCurrentDir : String;
     i:Integer;
  Bool : Boolean;     
begin
   ExtractListBox.Visible := false;
   _PQGD := nCTI.PQGD;
   FrameQM.Align:= alClient;
   FrameQM.Activate(_PQGD);
   CurrentFindRow := 0;
   Bool :=m_nUM.CheckPermitt(SA_USER_PERMIT_QYG,false,m_blNoCheckPass);
   if not Bool then begin
     AdvGlowButton6.Enabled := False;
     stopButton.Enabled     := False;
     queryStart.Enabled     := False;
     saveParams.Enabled     := False;
   end;
//     if m_nTree=Nil  then m_nTree  := CL3QweryTreeLoader.Create(@FTreeQweryData);             // BO 8/10/19
     if m_nCGrid=Nil then m_nCGrid := CCmplGrid.Create(sgComplette);
//     m_nTree.setTreeIndex(nCTI^);                                                             // BO 8/10/19

{  sgQGroup.ColCount    := 18;
  sgQGroup.RowCount    := 2;
  TSGsgQGroup.SetColCount(18);  // BO 03.04.2019
  sgQGroup.ColWidths[1]:=0;
  sgQGroup.ColWidths[2]:=0;
  sgQGroup.ColWidths[11]:=0; }

    old_sorting := 0;
    old_decs    := false;
    SortingCol  :=5;
    sgQGroupBtnClic;

    m_nTehnoLen          := 0+0+0+40+40+80+60+60+45+45+45+0+45+100+100+100+100;
    formResize(self);
    advSrvPager.ActivePageIndex := 0;

    edQGName.Text:='';
    cbQGEnable.Checked:=false;
    advSrvPager.AdvPages[0].TabVisible:=true;
    advSrvPager.AdvPages[1].TabVisible:=false;
    advSrvPager.AdvPages[2].TabVisible:=false;
    FTreeQweryData.Items.Clear;
    mdtBegin.DateTime := Now;
    mdtEnd.DateTime   := Now;
end;  *)

////Для добавления группы опроса/////////
procedure TTQweryModule.InitFrameADDID(nID : integer; nPIndex : Integer);
Var
     strCurrentDir : String;
     i:Integer;
  Bool : Boolean;     
begin
   ExtractListBox.Visible := false;
   _PQGD := nID;
   FrameQM.Align:= alClient;
   FrameQM.Activate(nID);
   CurrentFindRow := 0;
   Bool :=m_nUM.CheckPermitt(SA_USER_PERMIT_QYG,false,m_blNoCheckPass);
   if not Bool then begin
     stopButton.Enabled     := False;
     queryStart.Enabled     := False;
     saveParams.Enabled     := False;
   end;
//     if m_nTree=Nil  then m_nTree  := CL3QweryTreeLoader.Create(@FTreeQweryData);             // BO 8/10/19
     if m_nCGrid=Nil then m_nCGrid := CCmplGrid.Create(sgComplette);
//     m_nTree.setTreeIndex(nCTI^);                                                             // BO 8/10/19

{  sgQGroup.ColCount    := 18;
  sgQGroup.RowCount    := 2;
  TSGsgQGroup.SetColCount(18);  // BO 03.04.2019
  sgQGroup.ColWidths[1]:=0;
  sgQGroup.ColWidths[2]:=0;
  sgQGroup.ColWidths[11]:=0; }

    old_sorting := 0;
    old_decs    := false;
    SortingCol  :=5;
    sgQGroupBtnClic;

    m_nTehnoLen          := 0+0+0+40+40+80+60+60+45+45+45+0+45+100+100+100+100;
    formResize(self);
    advSrvPager.ActivePageIndex := 0;

    edQGName.Text:='';
    cbQGEnable.Checked:=false;
    advSrvPager.AdvPages[0].TabVisible:=true;
    advSrvPager.AdvPages[1].TabVisible:=false;
    advSrvPager.AdvPages[2].TabVisible:=false;
    FTreeQweryData.Items.Clear;
    mdtBegin.DateTime := Now;
    mdtEnd.DateTime   := Now;
end;

procedure TTQweryModule.OnTimeElapsed(Sender:TObject);
Begin
//    loadInQueryAbons(m_pRPDS.trTRI);
   if advSrvPager.ActivePageIndex = 2 then begin
    loadInQueryAbonsID(qgID);
    if assigned(timer) then timer.Interval := 8*1000;
   end;
    //sgQGroup.Refresh;
End;

procedure TTQweryModule.OnCloseForm(Sender: TObject;var Action: TCloseAction);
begin
     timer.Enabled := false;
     if pDb<>Nil then
       begin
        pDb.Disconnect; //m_pDB.DiscDynConnect(pDb);
        FreeAndNil(pDb);
       end;
     Action := caFree;
     //DoClose(Action);
     //m_nCF.m_nSetColor.PDataStyler := nil;
     //m_nTree.Destroy;
     //m_nCGrid.Destroy;
     //m_nTree := Nil;
     //m_nCGrid:= Nil;
end;
procedure TTQweryModule.RefreshTree;
Begin
     //m_pDB.GetQweryFullSRVTable(m_nCTI.PAID,-1,-1,m_nSRV);
     //if m_nCTI.PGID= $ffff then m_pDB.GetQweryFullSRVTable(m_nCTI.PAID,-1,-1,m_nSRV) else
     //if m_nCTI.PGID<>$ffff then m_pDB.GetQweryFullSRVTable(m_nCTI.PAID,m_nCTI.PGID,-1,m_nSRV);
     //if m_nTree=Nil then m_nTree := CL3QweryTreeLoader.Create(@FTreeQweryData);
     //m_nTree.LoadTree(m_nCTI,m_nSRV);
End;

(*
procedure TTQweryModule.PrepareFrame(nCTI:PCTreeIndex;nPIndex:Integer);
Begin
//     if m_nTree<>Nil then m_nTree.FreeTree;                                                   // BO 8/10/19
//     if m_nTree=Nil  then m_nTree  := CL3QweryTreeLoader.Create(@FTreeQweryData);             // BO 8/10/19
     if m_nCGrid=Nil then m_nCGrid := CCmplGrid.Create(sgComplette);
     //PrepareIndex;
//     m_nTree.setTreeIndex(nCTI^);                                                             // BO 8/10/19
     advSrvPager.ActivePageIndex := nPIndex;
//     Move(nCTI^,m_nCTI,sizeof(CTreeIndex));                                                   // BO 8/10/19
//     edm_snAIDsrv.Text   := IntToStr(m_nCTI.PAID);                                            // BO 8/10/19
     //edm_snSRVIDsrv.Text := IntToStr(GenIndex);
     //edm_sName.Text      := 'Опрос:'+edm_snSRVIDsrv.Text;
End;
*)

procedure TTQweryModule.PrepareIndex;
var
     pTbl : SQWERYSRVS;
     i : Integer;
Begin
     FreeAllIndex;
     //if m_pDB.GetQwerySRVTable(m_nCTI.PAID,-1,pTbl)=True then
     if m_pDB.GetQwerySRVTable(-1,-1,pTbl)=True then
     for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_snSRVID);
End;
procedure TTQweryModule.PrepareIndexQC(snSRVID:Integer);
var
     pTbl : SQWERYVMS;
     i : Integer;
Begin
     if m_pDB.GetQweryVMTable(-1,-1,pTbl)=True then
    // for i:=0 to pTbl.Count-1 do SetIndexQC(pTbl.Items[i].m_snCLID);
End;
procedure TTQweryModule.LoadCommanList(snMID:Integer);
Var
     i : integer;
     pTbl : CCOMMANDS;
begin
     try
     cbm_nAddCommand.Clear;
     if m_pDB.GetCommandsTable(snMID,pTbl)=True then
     Begin
      for i:=0 to pTbl.m_swAmCommand-1 do
      cbm_nAddCommand.Items.Add(m_nCommandList.Strings[pTbl.m_sCommand[i].m_swCmdID]);
      if cbm_nAddCommand.Items.Count<>0 then cbm_nAddCommand.ItemIndex := 0;
     End;
     except
     end;
end;
procedure TTQweryModule.LoadDayChBox(dwDayWMask:Dword);
var
     i : integer;
begin
     if (dwDayWMask and DYM_ENABLE)<>0 then
      chm_swDayMask.Checked := true
     else
      chm_swDayMask.Checked := false;
     for i := 0 to 6 do
     if (dwDayWMask and (1 shl (i+1)))<>0 then
      clm_swDayMask.Checked[i] := true
     else
      clm_swDayMask.Checked[i] := false;
end;
function TTQweryModule.GetWDayMask:Word;
var
     i     : integer;
     wMask : Word;
Begin
     wMask := Byte(chm_swDayMask.Checked=True);
     for i := 0 to 6 do
     wMask := wMask or ((Byte(clm_swDayMask.Checked[i]=True)) shl (i+1));
     Result := wMask;
End;
function TTQweryModule.GetMDayMask:DWord;
var
     i      : integer;
     dwMask : DWord;
Begin
     dwMask := Byte(chm_sdwMonthMask.Checked=True);
     for i := 0 to 30 do
     dwMask := dwMask or ((Byte(clm_sdwMonthMask.Checked[i]=True)) shl (i+1));
     Result := dwMask;
End;
function TTQweryModule.GetCluster:String;
Var
     i,nCMD,sID : Integer;
     strCluster : String;
Begin
     strCluster := '';
     for i:=0 to cbm_strCMDCluster.Items.Count-1 do
     Begin
      nCMD := m_nCommandList.IndexOf(cbm_strCMDCluster.Items[i]);
      if cbm_strCMDCluster.Checked[i]=True then nCMD := nCMD or $8000;
      strCluster := strCluster + IntToStr(nCMD) + ',';
     End;
     Result := strCluster;
End;
procedure TTQweryModule.LoadMonthChBox(dwDayMask:Dword);
var
     i : integer;
begin
     if (dwDayMask and MTM_ENABLE) <> 0 then
      chm_sdwMonthMask.Checked := true
     else
      chm_sdwMonthMask.Checked := false;
     for i := 0 to 30 do
     if (dwDayMask and (1 shl (i+1))) <> 0 then
      clm_sdwMonthMask.Checked[i] := true
     else
      clm_sdwMonthMask.Checked[i] := false;
end;
procedure TTQweryModule.LoadCluster(strCluster:String);
Var
     str,strComm : String;
     i,nCode : Integer;
Begin
     i := 0;
     str := strCluster;
     cbm_strCMDCluster.Clear;
     while GetCode(nCode,str)<>False do
     Begin
      cbm_strCMDCluster.Items.Add(m_nCommandList.Strings[nCode and $7fff]);
      if (nCode and $8000)<>0 then cbm_strCMDCluster.Checked[i] := True else
      if (nCode and $8000)=0  then cbm_strCMDCluster.Checked[i] := False;
      i := i + 1;
     End;
End;
procedure TTQweryModule.SetDefaultCluster(var pT:SQWERYVM);
Var
     str: String;
     i,sID : Integer;
Begin
     i := 0;
     str := '';
     for i:=0 to pT.Commands.m_swAmCommand-1 do
     Begin
      if pT.Commands.m_sCommand[i].m_sbyDirect=m_pRPDS.trTRI.PCID then
      str := str + IntToStr(pT.Commands.m_sCommand[i].m_swCmdID or $8000)+',';
     End;
     LoadCluster(str);
End;

procedure TTQweryModule.LoadTreeView; //раскрытие дерева и активация вкладки  Объекты опроса
var
i:integer;
Begin
  if(FTreeQweryData.Items.Count=0)then exit;
  FTreeQweryData.Items.Item[0].Selected:=true;
  FTreeQweryData.Selected.Expand(true);
    for i:=0 to FTreeQweryData.Items.Count-1 do
     begin
      if  FTreeQweryData.Items[i].Text = 'Объекты опроса' then
       begin
        FTreeQweryData.Items[i].Selected:=true;
        FTreeQweryData.Items[i].Focused :=true;
        break;
       end;
    end;
   OnClickTree(FTreeQweryData);
end;

procedure TTQweryModule.OnClickTree(Sender: TObject);
var
     nNode : TTreeNode;
//     pIND  : PCTI;                                                                  // BO 8/10/19
     m_pDS : CGDataSource;
Begin
//  ClearUnloadButton;                                                                // BO 8/10/19
(*     nNode := (Sender as TTreeView).Selected;
     if (nNode<>Nil) then
     Begin
      nodeText := nNode.Text;
      if nNode.Data<>Nil then
      Begin
       pIND := nNode.Data;
       Move(pIND.m_nCTI,m_pDS.trTRI,sizeof(CTreeIndex));
       Move(m_pDS ,m_pRPDS,sizeof(CGDataSource));
       qgID      := pIND.m_nCTI.PQGD;
       qgParamID := pIND.m_nCTI.PQPR;
       qgIDName  := m_pDB.GroupIdToName(qgID);  // по номеру группы извлечь имя группы
       m_sQC.m_snABOID := m_pRPDS.trTRI.PAID;
       m_sQC.m_snSRVID := m_pRPDS.trTRI.PGID;
       m_sQC.m_snCLID  := m_pRPDS.trTRI.PCID;
       m_sQC.m_snCLSID := m_pRPDS.trTRI.PTID;
       m_sQC.m_snPrmID := m_pRPDS.trTRI.PSID;
       m_sQC.m_snVMID  := m_pRPDS.trTRI.PVID;
       m_sQC.m_snMID   := m_pRPDS.trTRI.PMID;
       //SD_QGRUP
       with pIND.m_nCTI do Begin
       case PNID of
            PD_UNKNW:
            Begin
              if (PTSD=SD_QGRUP)then
              Begin
               advSrvPager.ActivePageIndex := 0;
               loadInQueryPannel(m_pRPDS.trTRI);
               advSrvPager.AdvPages[0].TabVisible:=true;
               advSrvPager.AdvPages[1].TabVisible:=false;
               advSrvPager.AdvPages[2].TabVisible:=false;
              End;
              if (PTSD=SD_QGCOM)then
              Begin
               // 1-е значение
               advSrvPager.AdvPages[0].TabVisible:=false;
               advSrvPager.AdvPages[1].TabVisible:=true;
               advSrvPager.AdvPages[2].TabVisible:=false;
               advSrvPager.ActivePageIndex := 1;
               chm_sbyVTEnable.Enabled := true;
               autoUnload.Enabled      := true;
               btUnloadStart.Enabled   := true;
               if m_pRPDS.trTRI.PQPR<>QRY_NAK_EN_MONTH_EP then
               Begin
                FTreeQweryData.Items.Item[FTreeQweryData.Selected.AbsoluteIndex].SelectedIndex:=2;
                chm_sbyVTEnable.Enabled := false;
                autoUnload.Enabled      := false;
                btUnloadStart.Enabled   := false;
               End;
               case m_pRPDS.trTRI.PQPR of
                 QRY_ENERGY_SUM_EP   : VisableAny(0);
                 QRY_NAK_EN_DAY_EP   : VisableAny(1);
                 QRY_NAK_EN_MONTH_EP : VisableAny(2);
                 QRY_DATA_TIME       : VisableAny(3);
                 else VisableAny(99);
               end;
               FTreeQweryData.Items.Item[FTreeQweryData.Selected.AbsoluteIndex].SelectedIndex:=2;
               loadInQueryParams(m_pRPDS.trTRI);
              End;
              if (PTSD=SD_QGSOS)then
              Begin
               advSrvPager.AdvPages[0].TabVisible:=false;
               advSrvPager.AdvPages[1].TabVisible:=false;
               advSrvPager.AdvPages[2].TabVisible:=true;
               advSrvPager.ActivePageIndex := 2;
               loadInQueryAbons(m_pRPDS.trTRI);
              End;

            End;
            PD_CLUST:
            Begin
             //(Sender as TTreeView).PopupMenu := mnuCluster;
             if (PTSD=SD_CLUST)then
             Begin
              advSrvPager.ActivePageIndex := 1;
              LoadEdit(m_pDS.trTRI);
             End else
             if (PTSD=SD_VPARM)then
             Begin
              advSrvPager.ActivePageIndex := 1;
              LoadEdit(m_pDS.trTRI);
              LoadCompletteGrid(m_pDS.trTRI);
             End;
            End;
            PD_QWERY:
            Begin
             //(Sender as TTreeView).PopupMenu := mnuVMeter;
             if (PTSD=SD_GROUP)then
             Begin
              advSrvPager.ActivePageIndex := 0;
              MenuPrepareSRV;
              LoadSrvEdit(m_pDS.trTRI);
             End else
             if (PTSD=SD_VMETR)then MenuPrepareVM;
            End;
       End;
       End;
      End;
     End;
     // VisableAny(tz)    *)
end;
procedure TTQweryModule.FTreeQweryDataExpanded(Sender: TObject; Node: TTreeNode);
{var
    nNode : TTreeNode;                                                             // BO 8/10/19
    pIND  : PCTI;    }
Begin
    //m_blTreeOpen  := False;                                                     // BO 8/10/19
{    nNode := Node;
    if (nNode<>Nil) then
    Begin
     if nNode.Data<>Nil then
     Begin
      pIND := nNode.Data;
      with pIND.m_nCTI do Begin
      case PNID of
           PD_QWERY: if PTSD=SD_VMETR then
           Begin
              if nNode.item[0].Text='A' then
              Begin
               nNode.item[0].Delete;
               m_nTree.OnLoadVM(pIND^,nNode);
              End;
           End;
           PD_UNKNW:
           Begin
            if PTSD=SD_QGPAR then
            Begin
              if nNode.item[0].Text='A' then
              Begin
               nNode.item[0].Delete;
               m_nTree.OnLoadInParam(pIND^,nNode);
              End;
            End
           End;
       End;
     End;
    End;
    End;     }
end;


(*
procedure TTQweryModule.LoadEdit(nCTI:CTreeIndex);
Var
     pTbl:SQWERYMDLS;
Begin
     if m_pDB.GetQweryMDLOneTable(nCTI.PCID,nCTI.PTID,pTbl)=True then
     Begin
      with pTbl.Items[0] do
      Begin
       LoadCommanList(nCTI.PMID);
       edm_snAID.Text           := IntToStr(m_snAID);
       edm_snSRVIDc.Text        := IntToStr(m_snSRVID);
       edm_snCLID.Text          := IntToStr(m_snCLID);
       edm_snPID.Text           := IntToStr(m_snPID);
       dtm_sdtBegin.Time        := frac(m_sdtBegin);
       dtm_sdtEnd.Time          := frac(m_sdtEnd);
       dtm_sdtPeriod.Time       := frac(m_sdtPeriod);
       edm_snSRVID.Text         := m_nSvPeriodList.Strings[m_snCLSID];
       LoadCluster(m_strCMDCluster);
       //edm_sGroupExpress.Text   := GetExpression(m_nCTI);
       LoadDayChBox(m_swDayMask);
       LoadMonthChBox(m_sdwMonthMask);
       chm_sbyEnable.Checked    := Boolean(m_sbyEnable);
       chm_sbyPause.Checked     := Boolean(m_sbyPause);
       chm_sbyFindData.ItemIndex:= m_sbyFindData;
       cbm_snDeepFind.ItemIndex := m_snDeepFind;
       CheckFind(True);
       //LoadCompletteGrid(m_pDS.trTRI);
      End;
     End;
     OnClickWDay(self);
     chm_sdwMonthMaskClick(self);
     //stMeterType.Caption := m_nMeterList.Strings[nCTI.PTID];
End;
*)

(*
procedure TTQweryModule.LoadCompletteGrid(nCTI:CTreeIndex);
Begin
     m_nCGrid.PaintGrid(nCTI.PTID,nCTI.PVID,nCTI.PSID,cbm_snDeepFind.ItemIndex);
End;
*)

(*
procedure TTQweryModule.LoadSrvEdit(nCTI:CTreeIndex);
Var
     pTbl:SQWERYSRVS;
Begin
     if m_pDB.GetQwerySRVTable(nCTI.PAID,nCTI.PGID,pTbl)=True then
     Begin
      with pTbl.Items[0] do
      Begin
       edm_snAIDsrv.Text        := IntToStr(m_snAID);
       edm_snSRVIDsrv.Text      := IntToStr(m_snSRVID);
       edm_sName.Text           := m_sName;
       chm_sbyEnableSrv.Checked := Boolean(m_sbyEnable);
       sem_nSrvWarning.Value    := m_nSrvWarning;
      End;
     End;
End;
*)

procedure TTQweryModule.GetEdits(var pTbl:SQWERYMDL);
Begin
     with pTbl do
     Begin
      m_snAID        := StrToInt(edm_snAID.Text);
      m_snSRVID      := StrToInt(edm_snSRVIDc.Text);
      m_snCLID       := StrToInt(edm_snCLID.Text);
      m_snVMID       := m_sQC.m_snVMID;
      m_snMID        := m_sQC.m_snMID;
      m_snPID        := StrToInt(edm_snPID.Text);
      m_snCLSID      := m_nSvPeriodList.IndexOf(edm_snSRVID.Text);
      m_sdtBegin     := dtm_sdtBegin.Time;
      m_sdtEnd       := dtm_sdtEnd.Time;
      m_sdtPeriod    := dtm_sdtPeriod.Time;
      m_swDayMask    := GetWDayMask;
      m_sdwMonthMask := GetMDayMask;
      m_strCMDCluster:= GetCluster;
      m_sbyEnable    := Byte(chm_sbyEnable.Checked);
      m_sbyPause     := Byte(chm_sbyPause.Checked);
      m_sbyFindData  := chm_sbyFindData.ItemIndex;
      m_snDeepFind   := cbm_snDeepFind.ItemIndex;
     End;
End;
{
0 Не сохранять
1 Мгновенный
2 3  мин
3 15 мин
4 30 мин
5 1 час
6 3 часа
7 6 часов
8 Сутки
9 Месяц
10 Год
11 События
12 Время
}
procedure TTQweryModule.CheckFind(blMenu:Boolean);
Begin
     if (m_sQC.m_snCLSID=CLS_GRAPH48)or(m_sQC.m_snCLSID=CLS_DAY)or(m_sQC.m_snCLSID=CLS_MONT)or(m_sQC.m_snCLSID=CLS_PNET)or(m_sQC.m_snCLSID=CLS_EVNT) then
     Begin
      dttm_sdtBegin.Enabled   := True;
      dttm_sdtEnd.Enabled     := True;
     End else
     Begin
      dttm_sdtBegin.Enabled   := False;
      dttm_sdtEnd.Enabled     := False;
     End;
     OnClickFind(self);
End;

(*
function TTQweryModule.GetExpression(nCTI:CTreeIndex):String;
Begin
     //if (nCTI.PTID=MET_SUMM)or(nCTI.PTID=MET_GSUMM) then
     //Result := m_pDB.GetGroupExpress(nCTI.PGID) else
     //Result := '';
     //if (nCTI.PTID=MET_SUMM)or(nCTI.PTID=MET_GSUMM) then
     //Result := m_pDB.GetGroupExpress(nCTI.PGID) else
     //Result := m_pDB.GetVMIDExpress(nCTI.PVID,nCTI.PCID);
End;
*)

procedure TTQweryModule.MenuPrepareVM;
Begin

End;
procedure TTQweryModule.MenuPrepareSRV;
Begin

End;
{
    m_sNI.m_sbyLOCK := 5;
    m_sNI.m_sbyUNLK := 7;
    m_sNI.m_sbyALOK := 8;
    m_sNI.m_sbyCVRY := 6;
    m_sNI.m_sbyALRM := 8;
    m_sNI.m_sbyREDY := 9;
}

procedure TTQweryModule.OnLoadQwery(Sender: TObject);
begin
 //    LoadEdit(m_pRPDS.trTRI);
end;

procedure TTQweryModule.OnClickWDay(Sender: TObject);
begin
     if chm_swDayMask.Checked=True then
     Begin
      chm_sdwMonthMask.Checked:=False; chm_sdwMonthMaskClick(self);
      clm_swDayMask.Enabled := True;
      //btm_swDayMask.Enabled := True;
     End else
     if chm_swDayMask.Checked=False then
     Begin
      clm_swDayMask.Enabled := False;
      //btm_swDayMask.Enabled := False;
     End;
end;

procedure TTQweryModule.chm_sdwMonthMaskClick(Sender: TObject);
begin
     if chm_sdwMonthMask.Checked=True then
     Begin
      chm_swDayMask.Checked    := False; OnClickWDay(self);
      clm_sdwMonthMask.Enabled := True;
      //btm_sdwMonthMask.Enabled := True;
     End else
     if chm_sdwMonthMask.Checked=False then
     Begin
      clm_sdwMonthMask.Enabled := False;
      //btm_sdwMonthMask.Enabled := False;
     End;
end;

procedure TTQweryModule.OnSaveButt(Sender: TObject);
Var
     pTbl : SQWERYMDL;
begin
     if MessageDlg('Сохранить настройки кластера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      m_pDB.SetQweryMDLTable(pTbl);
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
//     if chm_sbyEnable.Checked=True  then m_nTree.SetClusterState(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,SA_UNLK);   // BO 8/10/19
//     if chm_sbyEnable.Checked=False then m_nTree.SetClusterState(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,SA_REDY);   // BO 8/10/19
end;

procedure TTQweryModule.OnResizePannel(Sender: TObject);
Var
     nSize:Integer;
begin
     nSize := trunc(advTreePanell.Width/1)-7; //2
     advTreeTool.Width := advTreePanell.Width;
     advButTree.Width := nSize;
end;

procedure TTQweryModule.miFindDataClick(Sender: TObject);
begin
    //if MessageDlg('Выполнить поиск ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    //SendQSComm(QS_FIND_SR);
end;

procedure TTQweryModule.OnClickFind(Sender: TObject);
begin
    if (chm_sbyFindData.ItemIndex=0) then
    Begin
     if not((m_sQC.m_snCLSID=CLS_MGN)or(m_sQC.m_snCLSID=CLS_TIME)) then cbm_snDeepFind.Enabled := True;
     //cbm_snDeepFind.Enabled := True;
     //lbDeepFind.Enabled     := True;
     ////btm_sbyFindData.Enabled := True;
    End else
    if (chm_sbyFindData.ItemIndex=1) then
    Begin
      if (m_sQC.m_snCLSID=CLS_MGN)or(m_sQC.m_snCLSID=CLS_TIME) then cbm_snDeepFind.Enabled := False;
     //cbm_snDeepFind.Enabled := False;
     //lbDeepFind.Enabled     := False;
     //btm_sbyFindData.Enabled := False;
    End;
end;
procedure TTQweryModule.btm_sdtBeginClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Начало периода опроса" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdtBegin='+''''+DateTimeToStr(dtm_sdtBegin.DateTime)+'''');
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sdtBeginSAllClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Начало периода опроса" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sdtBegin='+''''+DateTimeToStr(dtm_sdtBegin.DateTime)+'''');
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sdtEndClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Окончание периода опроса" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdtEnd='+''''+DateTimeToStr(dtm_sdtEnd.DateTime)+'''');
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sdtEndSAllClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Окончание периода опроса" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sdtEnd='+''''+DateTimeToStr(dtm_sdtEnd.DateTime)+'''');
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;

procedure TTQweryModule.btm_sdtPeriodClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Периода опроса" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdtPeriod='+''''+DateTimeToStr(dtm_sdtPeriod.DateTime)+'''');
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sdtPeriodSAllClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Периода опроса" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sdtPeriod='+''''+DateTimeToStr(dtm_sdtPeriod.DateTime)+'''');
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;

procedure TTQweryModule.btm_swDayMaskClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Учитывать дни недели" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_swDayMask='+IntToStr(GetWDayMask));
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdwMonthMask='+IntToStr(GetMDayMask));
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_swDayMaskSAllClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Учитывать дни недели" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_swDayMask='+IntToStr(GetWDayMask));
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sdwMonthMask='+IntToStr(GetMDayMask));
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;

procedure TTQweryModule.btm_sdwMonthMaskClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Учитывать дни месяца" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sdwMonthMask='+IntToStr(GetMDayMask));
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_swDayMask='+IntToStr(GetWDayMask));
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sdwMonthMaskSAllClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Учитывать дни месяца" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sdwMonthMask='+IntToStr(GetMDayMask));
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_swDayMask='+IntToStr(GetWDayMask));
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;

procedure TTQweryModule.btm_sbyFindDataClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Выполнять поиск с глубиной" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sbyFindData='+IntToStr(chm_sbyFindData.ItemIndex));
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_snDeepFind='+IntToStr(cbm_snDeepFind.ItemIndex));
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sbyFindDataSAllClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Выполнять поиск с глубиной" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sbyFindData='+IntToStr(chm_sbyFindData.ItemIndex));
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_snDeepFind='+IntToStr(cbm_snDeepFind.ItemIndex));
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sbyEnableClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Разрешить опрос" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sbyEnable='+IntToStr(Byte(chm_sbyEnable.Checked)));
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
//      if chm_sbyEnable.Checked=True  then m_nTree.SetClusterState(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,SA_UNLK);      // BO 8/10/19
//      if chm_sbyEnable.Checked=False then m_nTree.SetClusterState(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,SA_REDY);      // BO 8/10/19
     End;
end;
procedure TTQweryModule.btm_sbyEnableSAllClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Разрешить опрос" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sbyEnable='+IntToStr(Byte(chm_sbyEnable.Checked)));
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
//      if chm_sbyEnable.Checked=True  then m_nTree.SetClusterState(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,SA_UNLK);        // BO 8/10/19
//      if chm_sbyEnable.Checked=False then m_nTree.SetClusterState(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,SA_REDY);        // BO 8/10/19
     End;
end;

procedure TTQweryModule.btm_sExecForGroupClick(Sender: TObject);
Var
     pTbl : SQWERYMDL;
     i : Integer;
Begin
     if MessageDlg('Распространить настройки кластера в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      //pTbl.m_snCLID := -1;
      m_pDB.SetQweryMDLTableEx(pTbl);
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sExecForGroupSAllClick(Sender: TObject);
Var
     pTbl : SQWERYMDL;
     i : Integer;
Begin
     if MessageDlg('Распространить настройки кластера в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      pTbl.m_snAID   := -1;
      pTbl.m_snSRVID := -1;
      //pTbl.m_snCLID  := -1;
      m_pDB.SetQweryMDLTableEx(pTbl);
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.btm_sAddClsTAllClick(Sender: TObject);
Var
     pTable:SQWERYMDLS;
     pTbl : SQWERYMDL;
     i : Integer;
begin
     if MessageDlg('Добавить кластер для всех точек?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      m_pDB.GetQweryMaskMDLTable(-1,IntToStr(pTbl.m_snSRVID),pTable);
      for i:=0 to pTable.Count-1 do
      Begin
       with pTable.Items[i] do
       Begin
        pTbl.m_snAID  := m_snAID;
        pTbl.m_snSRVID:= m_snSRVID;
        pTbl.m_snCLID := m_snCLID;
        pTbl.m_snVMID := m_snVMID;
        pTbl.m_snMID  := m_snMID;
        pTbl.m_snPID  := m_snPID;
       End;
       m_pDB.AddQweryMDLTable(pTbl);
      End;
      SendQSComm(m_sQC.m_snSRVID,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.miExecSetAllClustClick(Sender: TObject);
Begin
     btm_sExecForGroupClick(sender);
end;

procedure TTQweryModule.dttm_sdtBeginChange(Sender: TObject);
begin
     dttm_sdtEnd.DateTime := dttm_sdtBegin.DateTime;
end;

procedure TTQweryModule.btm_nTopParamClick(Sender: TObject);
Var
     strCls,str : String;
begin
     str := m_pDB.GetCluster(m_sQC.m_snCLID,m_sQC.m_snCLSID);
     strCls := IntToStr($8000 or m_nCommandList.IndexOf(cbm_nAddCommand.Text));
     strCls := strCls+','+str;
     LoadCluster(strCls);
end;
procedure TTQweryModule.btm_nBottParamClick(Sender: TObject);
Var
     strCls : String;
begin
     strCls := m_pDB.GetCluster(m_sQC.m_snCLID,m_sQC.m_snCLSID);
     strCls := strCls + IntToStr($8000 or m_nCommandList.IndexOf(cbm_nAddCommand.Text))+',';
     LoadCluster(strCls);
end;

procedure TTQweryModule.btm_nSubParamClick(Sender: TObject);
begin
     if cbm_strCMDCluster.Items.Count<>0 then
     Begin
      if cbm_strCMDCluster.ItemIndex<>-1 then
      cbm_strCMDCluster.Items.Delete(cbm_strCMDCluster.ItemIndex);
     End;
end;

procedure TTQweryModule.btm_nSvClustGrClick(Sender: TObject);
var
     pTable : CCOMMANDS;
begin
     if MessageDlg('Установить содержимое кластера в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      if m_sQC.m_snCLSID=4 then
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,' m_strCMDCluster='+''''+GetCluster+'''') else
      m_pDB.SetMdlParamEx(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,' m_strCMDCluster='+''''+GetCluster+'''');
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     End;
end;
procedure TTQweryModule.SendQSCommEx(snAID,snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snABOID := snAID;
     sQC.m_snSRVID := snSRVID;
     sQC.m_snCLID  := snCLID;
     sQC.m_snCLSID := snCLSID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure TTQweryModule.SendQSComm(snSRVID,snCLID,snCLSID,snPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));                         // BO 8/10/19
     if sQC.m_snABOID=-1 then sQC.m_snABOID := qgAbon; // m_nCTI.PAID;      // BO 8/10/19
     sQC.m_snSRVID := snSRVID;
     sQC.m_snCLID  := snCLID;
     sQC.m_snCLSID := snCLSID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;

procedure TTQweryModule.SendQSComm(nCommand,snSRVID,snPrmID:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snSRVID := snSRVID;
     sQC.m_snPrmID := snPrmID;
     sQC.m_snCmdID := nCommand;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
     SendPMsg(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure TTQweryModule.SendQSData(nCommand,snSRVID,snCLID,nCLSID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));                              // BO 8/10/19
     if sQC.m_snABOID=-1 then sQC.m_snABOID := qgAbon;  /// m_nCTI.PAID;      // BO 8/10/19
     sQC.m_snCmdID  := nCommand;
     sQC.m_sdtBegin := sdtBegin;
     sQC.m_sdtEnd   := sdtEnd;
     sQC.m_snSRVID  := snSRVID;
     sQC.m_snCLID   := snCLID;
     sQC.m_snCLSID  := nCLSID;
     sQC.m_snPrmID  := nCMDID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
     SendPMsg(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure TTQweryModule.SendQSData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
    // pMsg : CHMessage;
Begin
     Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snCmdID  := nCommand;
     sQC.m_sdtBegin := sdtBegin;
     sQC.m_sdtEnd   := sdtEnd;
     sQC.m_snSRVID  := snSRVID;
     sQC.m_snPrmID  := nCMDID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     //SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
     SendPMsg(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;


procedure TTQweryModule.SendQSTreeData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
    // pMsg : CHMessage;
Begin
  //SendQSTreeData(QS_UPDT_SR,qgID,2,mdtBegin.DateTime,mdtEnd.DateTime);//для смены параметра для анализа состояния группы опроса
  {
  QS_UPDT_SR - nCommand  //команда группы
  qgID       - snSRVID   //id группы
  2          - nCMDID    //команда группы (ожидание опроса руч.)
  mdtBegin   - sdtBegin  //начало времени группы
  mdtEnd     - sdtEnd    //конец времени группы
  }
//     if m_sQC<>nil then
      Move(m_sQC,sQC,sizeof(SQWERYCMDID));
     sQC.m_snCmdID  := nCommand;
     sQC.m_sdtBegin := sdtBegin;
     sQC.m_sdtEnd   := sdtEnd;
     sQC.m_snSRVID  := snSRVID;
     sQC.m_snPrmID  := nCMDID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYTREE_REQ,pDS);
End;

procedure TTQweryModule.SendPMsg(byBox:Integer;byIndex:Integer;byFor,byType:Byte;var pDS:CMessageData);
Var
    pMsg : CMessage;
Begin
    FillChar(pMsg.m_sbyInfo, SizeOf(pMsg.m_sbyInfo), 0);
    With pMsg do
    Begin
     m_swObjID     := byIndex;
     m_sbyFrom     := byFor;
     m_sbyFor      := byFor;
     m_sbyType     := byType;
     m_sbyTypeIntID:= 0;
     m_sbyIntID    := 0;
     m_sbyServerID := 0;
     m_sbyDirID    := 0;
     Move(pDS,m_sbyInfo[0],sizeof(pDS));
     m_swLen       := 13 + sizeof(pDS);
    end;
    if  Assigned(mQServer) then
          mQServer.m_nQSB.EventHandler(pMsg);
End;

//Index Generator
function  TTQweryModule.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_QSERVER do
    if m_blQServer[i]=False then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function TTQweryModule.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function TTQweryModule.SetIndex(nIndex:Integer):Integer;
Begin
    m_blQServer[nIndex] := True;
    Result := nIndex;
End;
Procedure TTQweryModule.FreeIndex(nIndex:Integer);
Begin
    m_blQServer[nIndex] := False;
End;
Procedure TTQweryModule.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_QSERVER do
    m_blQServer[i] := False;
End;

procedure TTQweryModule.advSaveSrvClick(Sender: TObject);
Var
     pTbl : SQWERYSRV;
begin
     pTbl.m_snAID   := qgAbon; // m_nCTI.PAID;                                                // BO 8/10/19
     pTbl.m_snSRVID := StrToInt(edm_snSRVIDsrv.Text);
     pTbl.m_sName   := edm_sName.Text;
     pTbl.m_sbyEnable := Byte(chm_sbyEnableSrv.Checked);
     pTbl.m_nSrvWarning := sem_nSrvWarning.Value;
     m_pDB.AddQwerySRVTable(pTbl);
     //m_pDB.SetMdlParam(m_nCTI.PAID,m_nCTI.PGID,-1,-1,'m_sbyPause='+IntToStr(Byte(chm_sbyEnableSrv.Checked)));
     SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
     RefreshTree;
end;
procedure TTQweryModule.advCreateSrvClick(Sender: TObject);
begin
     PrepareIndex;
     edm_snAIDsrv.Text   := IntToStr(qgAbon);    //  m_nCTI.PAID                   // BO 8/10/19
     edm_snSRVIDsrv.Text := IntToStr(GenIndex);
     edm_sName.Text      := 'Cервер опроса:'+edm_snSRVIDsrv.Text;
     sem_nSrvWarning.Value    := 2;
     chm_sbyEnableSrv.Checked := False;
end;
procedure TTQweryModule.OnDragVmOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
Var
    nNode : TTreeNode;
    Node  : TTreeNode;
    NodeData : TNodeData;
//    pIND  : PCTI;                                                               // BO 8/10/19
begin
    Accept := False;
    DragFromNewTL:=false;
{    nNode := (Source as TTreeView).Selected;                                     // BO 8/10/19
    if (nNode<>Nil) then
    Begin
     if nNode.Data<>Nil then
     Begin
      pIND := nNode.Data;
      Accept := ((pIND.m_nCTI.PTSD=SD_VMETR)and(pIND.m_nCTI.PNID=PD_VMETR))or
                //((pIND.m_nCTI.PTSD=SD_QGPAR)and(pIND.m_nCTI.PNID=PD_UNKNW))or
                ((pIND.m_nCTI.PTSD=SD_ABONT)and(pIND.m_nCTI.PNID=PD_UNKNW)) or
                ((pIND.m_nCTI.PTSD=SD_REGIN)and(pIND.m_nCTI.PNID=PD_UNKNW)) or    // BO 19.02.2019
                ((pIND.m_nCTI.PTSD=SD_RAYON)and(pIND.m_nCTI.PNID=PD_UNKNW)) or
                ((pIND.m_nCTI.PTSD=SD_TOWNS)and(pIND.m_nCTI.PNID=PD_UNKNW)) or
                ((pIND.m_nCTI.PTSD=SD_TPODS)and(pIND.m_nCTI.PNID=PD_UNKNW)) or
                ((pIND.m_nCTI.PTSD=SD_STRET)and(pIND.m_nCTI.PNID=PD_UNKNW));
     End;
    End; }
  Node:=TKnsForm.frameTreeDataModule.TreeList.Selected;
  if Node <> nil then begin
    NodeData:=Node.Data;
    if (NodeData.Code = SD_ABONT) or (NodeData.Code = SD_REGIN) or (NodeData.Code = SD_RAYON) or
       (NodeData.Code = SD_TOWNS) or (NodeData.Code = SD_TPODS) or (NodeData.Code = SD_STRET) then begin
      Accept := True;
      DragFromNewTL:=true;
    end;
  end;

end;
procedure TTQweryModule.OnDragVmDrop(Sender, Source: TObject; X,
  Y: Integer);
Var
     nDest,nSrc : TTreeNode;
//     pDest,pSrc : PCTI;                                                   // BO 8/10/19
     pTbl : SQWERYVM;
begin
//     nSrc  := (Source as TTreeView).Selected;                             // BO 8/10/19
//     pSrc  := nSrc.Data;                                                   // BO 8/10/19
//     nDest := FTreeQweryData.GetNodeAt(X, Y);                              // BO 8/10/19
{     if pDest=Nil then exit;                                               // BO 8/10/19
     pDest := nDest.Data;
     if (nDest.Count>0) and (nDest.item[0].Text='A') then
      nDest.item[0].Delete;   }

{     if ((pDest.m_nCTI.PTSD=SD_QGPAR)and(pDest.m_nCTI.PNID=PD_UNKNW)) then     // BO 8/10/19
          m_nTree.OnLoadInParamDrop(pSrc^,pDest^,nDest);


     if ((pDest.m_nCTI.PTSD=SD_QGSOS)and(pDest.m_nCTI.PNID=PD_UNKNW)) then
          m_nTree.OnLoadInAbonDrop(pSrc^,pDest^,nDest);    }


{  if DragFromNewTL then begin                                                  // BO 8/10/19
    if ((pDest.m_nCTI.PTSD=SD_QGSOS)and(pDest.m_nCTI.PNID=PD_UNKNW)) then
      TKnsForm.frameTreeDataModule.DragNDrop(pDest.m_nCTI.PQGD);
  end;    }

end;
{
//Тип хранения
  SV_CURR_ST = 0;
  SV_ARCH_ST = 1;
  SV_GRPH_ST = 2;
  SV_PDPH_ST = 3;
}

//Обработчик меню уровня сервера/ячейки

procedure TTQweryModule.miExecSetClustClick(Sender: TObject);
begin
     if MessageDlg('Применить настройки?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
end;



procedure TTQweryModule.btm_sbyPauseClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Пауза" в пределах сервера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(m_sQC.m_snABOID,m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID,'m_sbyPause='+IntToStr(Byte(chm_sbyPause.Checked)));
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
      RefreshTree;
     End;
end;
procedure TTQweryModule.btm_sbyPauseSAllClick(Sender: TObject);
begin
     if MessageDlg('Установить параметр "Пауза" в пределах всех серверов?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.SetMdlParam(-1,-1,-1,m_sQC.m_snCLSID,'m_sbyPause='+IntToStr(Byte(chm_sbyPause.Checked)));
      SendQSCommEx(-1,-1,-1,-1,-1,QS_INIT_SR);
      RefreshTree;
     End;
end;

procedure TTQweryModule.OnStopAll(Sender: TObject);
begin
     if MessageDlg('Остановить операции по всем группам ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      //SendQSData(QS_STOP_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
      with lcCEStopOperationsForAllGroups do                 // BO 20.11.18
        LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgParamName);
      SendQSData(QS_STOP_SR,-1,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
     End;
end;

{
procedure TTQweryModule.stopButtonClick(Sender: TObject);
begin
     if MessageDlg('Остановить операцию группа/параметр :'+IntToStr(qgID)+'/'+IntToStr(qgParamID)+' с '+DateToStr(mdtEnd.DateTime)+
     ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSData(QS_STOP_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
     End;
end;
}

procedure TTQweryModule.miStopSAllClick(Sender: TObject);
begin
     if MessageDlg('Остановить операции на всех серверах?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSCommEx(-1,-1,-1,-1,-1,QS_STOP_SR);
     End;
end;

procedure TTQweryModule.OnGetCellColor(Sender: TObject; ARow,ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     if m_nCGrid<>Nil then m_nCGrid.OnGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTQweryModule.miDelAllClsClick(Sender: TObject);
begin
     if MessageDlg('Удалить задачи из группы ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      //m_pDB.DelQweryMDLCMDIDTable(m_sQC.m_snSRVID,-1,m_sQC.m_snCLSID);
      //SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
      //RefreshTree;
       if(m_pRPDS.trTRI.PQGD<>-1) then
       Begin
        m_pDB.delQueryGroupParams(m_pRPDS.trTRI.PQGD);
//        m_nTree.LoadTree;                                                            // BO 8/10/19
        SendQSComm(QS_INIT_SR,qgID,-1);
       End;
     End;
end;

procedure TTQweryModule.miDelClsClick(Sender: TObject);
begin
     if MessageDlg('Удалить кластер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.DelQweryMDLCMDIDTable(m_sQC.m_snSRVID,m_sQC.m_snCLID,m_sQC.m_snCLSID);
      SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
      RefreshTree;
     End;
end;

procedure TTQweryModule.OnOpenForm(Sender: TObject);
Var
   strCurrentDir : String;
begin
//    csFrame := TCriticalSection.Create;
    if timer=nil then
    Begin
     timer          := TTimer.Create(Self);
     timer.Interval := 8*1000;
     timer.Enabled  := false;//true;
     timer.OnTimer  := OnTimeElapsed;
     strCurrentDir  := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     queryState     := TStringList.Create;
     queryState.loadfromfile(strCurrentDir+'queryState.dat');
     pDb  := CDBDynamicConn.Create; //m_pDB.getConnection;
     pDb.Create(pDb.InitStrFileName);
    End;

end;

procedure TTQweryModule.OnSaveQGName(Sender: TObject);
Var
     pTbl : QueryGroup;
begin
     pTbl        := QueryGroup.Create;
     pTbl.ID     := qgID;
     pTbl.name   := edQGName.Text;
     pTbl.enable := Integer(cbQGEnable.Checked);
     m_pDB.addQueryGroup(pTbl);
//     m_nTree.LoadTree;                                                 // BO 8/10/19
end;


(*procedure TTQweryModule.loadInQueryPannel(index:CTreeIndex);
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : querygroup;
     i     : Integer;
Begin
     pTbl  := TThreadList.Create;
     if m_pDB.GetQueryGroups(index.PQGD,pTbl)=True then
     Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       qgID := data.id;
       edQGName.Text := data.NAME;
       cbQGEnable.Checked := Boolean(data.ENABLE);
      End;
      pTbl.UnlockList;
     End;
End;
*)

procedure TTQweryModule.loadInQueryPannelID(ID : integer; NAME : string; ENABLE : integer);
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : querygroup;
     i     : Integer;
Begin
     pTbl  := TThreadList.Create;
     qgID := ID;
     edQGName.Text := NAME;
     cbQGEnable.Checked := Boolean(ENABLE);
End;

procedure TTQweryModule.OnDelQgroup(Sender: TObject);
begin
     if qgID<>-1 then
     Begin
      if MessageDlg('Удалить группу опроса '+edQGName.Text+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       m_pDB.delQueryGroup(qgID);
//       m_nTree.LoadTree;                                                      // BO 8/10/19
       SendQSComm(QS_INIT_SR,qgID,-1);
      End;
     End;
end;

procedure TTQweryModule.OnAddNewGroup(Sender: TObject);
begin
     qgID := -1;
     OnSaveQGName(Sender);
end;

procedure TTQweryModule.FormResize(Sender: TObject);
Var
    i : Integer;
Begin
   // for i:=1 to sgQGroup.ColCount-1  do sgQGroup.ColWidths[i]  := trunc((sgQGroup.Width-(m_nTehnoLen)-2*sgQGroup.ColWidths[0])/(sgQGroup.ColCount-1-15)); //14
 btnRefresh.Left:= AdvToolBar2.Width+10;
End;

(*
procedure TTQweryModule.loadInQueryAbons(index:CTreeIndex);
Var
     pTbl,pTblStBar   : TThreadList;
     vList,vListStBar : TList;
     data,dataStBar   : qgabons;
     i     : Integer;
     sortStr : String;
     //pDb   : CDBDynamicConn;
Begin
    qgID      := index.PQGD;
    if qgID=-1 then exit;
    if not Assigned(sgQGroup) then exit;
    sgQGroup.ClearNormalCells;
    try
    pTbl      := TThreadList.Create;
    pTblStBar := TThreadList.Create;
    //pDb  := m_pDB.getConnection;
    sortStr := createSortString();
    if pDb.GetQueryAbonsEx(index.PQGD,sortStr,pTbl)=True then
    Begin
      vList := pTbl.LockList;
      sgQGroup.RowCount := vList.Count + 1;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       AddRecordToGrid(i,data);
       FreeAndNil(data);//data.Destroy;
      End;
      pTbl.Clear;
      pTbl.UnlockList;
    End;
    if pDb.GetQueryAbonsGroup(index.PQGD,pTblStBar)=True then
     Begin
      vListStBar := pTblStBar.LockList;
      for i:=0 to vListStBar.Count-1 do
       Begin
        dataStBar := vListStBar[i];
        sbQwery.Panels.Items[1].Text := 'Прогресс - '+IntToStr(trunc(dataStBar.QUALITY))+'%';
        sbQwery.Panels.Items[2].Style:= psProgress;
        sbQwery.Panels.Items[2].Progress.Position:= trunc(dataStBar.QUALITY);
        dataStBar.Destroy;
       End;
      pTblStBar.Clear;
      pTblStBar.UnlockList;
     end;
    finally
     //pDb.Disconnect;
     FreeAndNil(pTblStBar);//pTblStBar.Destroy;
     FreeAndNil(pTbl);//pTbl.Destroy;
    end;
End;
*)

procedure TTQweryModule.loadInQueryAbonsID(ID:integer);
Var
     pTbl,pTblStBar   : TThreadList;
     vList,vListStBar : TList;
     data,dataStBar   : qgabons;
     i     : Integer;
     sortStr : String;
     //pDb   : CDBDynamicConn;
     Node : TTreeNode;
     NodeData : TNodeData;
Begin
  Node := TKnsForm.frameTreeDataModule.TreeList.Selected;
  if Node <> nil then begin
    NodeData := Node.Data;
    if (NodeData <> nil) and (NodeData.Code = SD_QGRUP) then begin
      qgID      := NodeData.ID;
      if qgID = -1 then exit;
      if not Assigned(sgQGroup) then exit;
      sgQGroup.ClearNormalCells;
      try
       pTbl      := TThreadList.Create;
       pTblStBar := TThreadList.Create;
       sortStr := createSortString();
        if pDb.GetQueryAbonsEx(qgID,sortStr,pTbl)=True then Begin
         vList := pTbl.LockList;
         sgQGroup.RowCount := vList.Count + 1;
          for i:=0 to vList.Count-1 do Begin
            data := vList[i];
            AddRecordToGrid(i,data);
            FreeAndNil(data);//data.Destroy;
          End;
         pTbl.Clear;
         pTbl.UnlockList;
        End;
//        if pDb.GetQueryAbonsGroup(qgID,pTblStBar)=True then Begin
//          vListStBar := pTblStBar.LockList;
//          for i:=0 to vListStBar.Count-1 do Begin
//            dataStBar := vListStBar[i];
//            sbQwery.Panels.Items[1].Text := 'Прогресс - '+IntToStr(trunc(dataStBar.QUALITY))+'%';
//            sbQwery.Panels.Items[2].Style:= psProgress;
//            sbQwery.Panels.Items[2].Progress.Position:= trunc(dataStBar.QUALITY);
//            dataStBar.Destroy;
//          End;
//          pTblStBar.Clear;
//          pTblStBar.UnlockList;
//        end;
      finally
       //FreeAndNil(pTblStBar);
       FreeAndNil(pTbl);//pTbl.Destroy;
      end;
    End;
  end;
End;

procedure TTQweryModule.AddRecordToGrid(nIndex:Integer;pTbl:qgabons);
Var
   nY : Integer;
   nVisible : Integer;
   currTime : TDateTIme;
   R: TRect;
   Txt: String;
Begin
    nY := nIndex+1;
    with pTbl do Begin
     sgQGroup.Cells[0,nY] := IntToStr(nY);
     sgQGroup.Cells[1,nY] := IntToStr(pTbl.QGID);
     sgQGroup.Cells[2,nY] := IntToStr(pTbl.ABOID);
     if pTbl.ENABLE=1 then
     sgQGroup.AddCheckBox(3,nY,true,false) else
     sgQGroup.AddCheckBox(3,nY,false,false);
     if pTbl.EA8086<>0 then
     begin
     if pTbl.ENABLE_PROG=1 then
     sgQGroup.AddCheckBox(4,nY,true,false) else
     sgQGroup.AddCheckBox(4,nY,false,false);
     end;
     sgQGroup.Cells[5,nY] := pTbl.ABONM;//4
     sgQGroup.Cells[6,nY] := DateTimeToStr(pTbl.DTBEGINH);//5
     currTime := pTbl.DTENDH;
     if pTbl.DTENDH=0 then
        Begin
          sgQGroup.Cells[7,nY] := '';
          currTime:=now;
        End
     else
         sgQGroup.Cells[7,nY] := DateTimeToStr(pTbl.DTENDH);//6

     if pTbl.STATE<>TASK_WAIT_RUN then sgQGroup.Cells[8,nY] := TimeToStr(currTime-pTbl.DTBEGINH) else sgQGroup.Cells[8,nY] := '';//7
     sgQGroup.Cells[9,nY] := IntToStr(pTbl.ALLCOUNTER);  //8
     sgQGroup.Cells[10,nY] := IntToStr(pTbl.ISOK);        //9
     sgQGroup.Cells[11,nY]:= IntToStr(pTbl.ISNO);  //0   //10
     sgQGroup.Cells[12,nY]:= IntToStr(pTbl.ISER);        //11

  //   sgQGroup.AddAdvProgress(12,nY,0,100);
     if (pTbl.ISER>0)and (pTbl.ISER<=10)then
     sgQGroup.AddProgress(13,nY,$00D7FF,clWindow) //желтый //12
     else if (pTbl.ISER>10)then
     sgQGroup.AddProgress(13,nY,$507FFF,clWindow) //красный //12
     else
     sgQGroup.AddProgress(13,nY,$90EE90,clWindow); //зеленый //12

     sgQGroup.Ints[13,nY] := trunc(pTbl.QUALITY);  //12

     //sgQGroup.AddAdvProgress(13,nY,0,100);
     sgQGroup.AddProgress(14,nY,$90EE90,clWindow);//зеленый  //13
     sgQGroup.Ints[14,nY] := trunc(pTbl.PERCENT);            //13
     if (pTbl.GSM=0) or (pTbl.GSM=-1) then
     sgQGroup.Cells[15,nY]:= pTbl.NUMABON //Связь отобразить Номер или IP
     else
     sgQGroup.Cells[15,nY]:= pTbl.NUMABON+': '+IntToStr(pTbl.GSM)+' порт'; //Связь отобразить Номер или IP

     sgQGroup.Cells[16,nY]:= TYPEUSPD; //14
     sgQGroup.Cells[17,nY]:= queryState.Strings[pTbl.STATE]; //14
    End;
End;

(*
procedure TTQweryModule.loadInQueryParams(index:CTreeIndex);
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : qgparam;
     i     : Integer;
Begin
    qgID      := index.PQGD;
    qgParamID := index.PQPR;
    pTbl      := TThreadList.Create;
    if m_pDB.getQueryGroupsParam(index.PQGD,index.PQPR,pTbl)=True then
    Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       SetToScreen(data);
      End;
      pTbl.UnlockList;
    End;
    ClearListAndFree(pTbl);
End;
*)

procedure TTQweryModule.loadInQueryParamsID(ID, param : integer);
Var
     pTbl  : TThreadList;
     vList : TList;
     data  : qgparam;
     i     : Integer;
Begin
    qgID      := ID;
    qgParamID := param;
    pTbl      := TThreadList.Create;
    if m_pDB.getQueryGroupsParam(ID,param,pTbl)=True then
    Begin
      vList := pTbl.LockList;
      for i:=0 to vList.Count-1 do
      Begin
       data := vList[i];
       SetToScreen(data);
      End;
      pTbl.UnlockList;
    End;
    ClearListAndFree(pTbl);
End;


function TTQweryModule.GetToScreen:QGPARAM;
Var
    pTbl : QGPARAM;
Begin
    pTbl            := QGPARAM.Create;
    pTbl.ID         := -1;
    pTbl.PARAM      := qgParamID;
    pTbl.QGID       := qgID;
    pTbl.DTBEGIN    := dtBegin.DateTime;
    pTbl.DTEND      := dtEnd.DateTime;
    pTbl.DTPERIOD   := dtPeriod.DateTime;
    pTbl.DAYMASK    := GetWDayMaskEx;
    pTbl.MONTHMASK  := GetMDayMaskEx;
    pTbl.DEEPFIND   := cbDeepFind.ItemIndex;
    pTbl.ENABLE     := Byte(cbEnable.Checked);
    pTbl.PAUSE      := Byte(cbPause.Checked);
    pTbl.FINDDATA   := Byte(cbFindUpdate.Checked);
    pTbl.UNDEEPFIND := cbm_snVTDeepFind.ItemIndex;
    pTbl.UNPATH     := em_strVTPath.Text;
    pTbl.UNENABLE   := Byte(chm_sbyVTEnable.Checked);
    pTbl.ISRUNSTATUS  := Byte(cbRunStatus.Checked);
    pTbl.RUNSTATUS    := GetStateMask();
    pTbl.ERRORPERCENT := spinError.Value;
    pTbl.ERRORPERCENT2:= spinError2.Value;
    pTbl.TIMETOSTOP   := TimeToStop.DateTime;
    Result          := pTbl;
End;

procedure TTQweryModule.SetToScreen(pTbl:QGPARAM);
Begin
    dtBegin.DateTime     := pTbl.DTBEGIN;
    dtEnd.DateTime       := pTbl.DTEND;
    dtPeriod.DateTime    := pTbl.DTPERIOD;
    LoadDayChBoxEx(pTbl.DAYMASK);
    LoadMonthChBoxEx(pTbl.MONTHMASK);
    cbDeepFind.ItemIndex := pTbl.DEEPFIND;
    cbEnable.Checked     := Boolean(pTbl.ENABLE);
    cbPause.Checked      := Boolean(pTbl.PAUSE);
    cbFindUpdate.Checked := Boolean(pTbl.FINDDATA);
    lbParam.Caption      := nodeText;
    qgParamName          := nodeText;
    cbm_snVTDeepFind.ItemIndex := pTbl.UNDEEPFIND;
    em_strVTPath.Text          := pTbl.UNPATH;
    chm_sbyVTEnable.Checked    := Boolean(pTbl.UNENABLE);
    cbRunStatus.Checked  := Boolean(pTbl.ISRUNSTATUS);
    LoadSateMask(pTbl.RUNSTATUS);
    spinError.Value      :=  trunc(pTbl.ERRORPERCENT);
    cbPacket_KUB.Checked :=  Boolean(pTbl.PACKETK);
    spinError2.Value     :=  trunc(pTbl.ERRORPERCENT2);
    TimeToStop.DateTime  := pTbl.TIMETOSTOP;
End;

procedure TTQweryModule.getStrings(s1:String;var value:TStringList);
Var
    i,j:Integer;
    s2,separator : string;
    index : Integer;
Begin
    separator := ',';
    while pos(separator, s1)<>0 do
    begin
     index := pos(separator, s1);
     s2 := copy(s1,1,index-1);
     j := j + 1;
     delete (s1, 1, pos(separator, S1));
     value.Add(s2);
    end;
    if pos (separator, s1)=0 then
    begin
     j := j + 1;
     value.Add(s1);
    end;
End;
procedure TTQweryModule.LoadSateMask(strStatus:String);
var
    i   : integer;
    slv : TStringList;
    str : String;
begin
    for i := 0 to clmRunStatus.Items.Count-1 do clmRunStatus.Checked[i] := false;
    slv := TStringList.Create;
    getStrings(strStatus,slv);
    for i := 0 to slv.Count-1 do
    Begin
     if slv[i]='' then continue;
     setRunCheck(queryState.Strings[StrToInt(slv[i])]);
    End;
    FreeAndNil(slv);
end;
procedure TTQweryModule.setRunCheck(name:String);
Var
    i : Integer;
Begin
    for i := 0 to clmRunStatus.Items.Count-1 do
    Begin
     if(clmRunStatus.Items[i]=name) then
      clmRunStatus.Checked[i] := true
    End;
End;
procedure TTQweryModule.LoadDayChBoxEx(dwDayWMask:Dword);
var
    i : integer;
begin
    if (dwDayWMask and DYM_ENABLE)<>0 then
     cbDayMask.Checked := true
    else
     cbDayMask.Checked := false;
    for i := 0 to 6 do
    if (dwDayWMask and (1 shl (i+1)))<>0 then
     clmDayMask.Checked[i] := true
    else
     clmDayMask.Checked[i] := false;
end;
procedure TTQweryModule.LoadMonthChBoxEx(dwDayMask:Dword);
var
    i : integer;
begin
    if (dwDayMask and MTM_ENABLE) <> 0 then
     cbMonthMask.Checked := true
    else
     cbMonthMask.Checked := false;
    for i := 0 to 30 do
    if (dwDayMask and (1 shl (i+1))) <> 0 then
     clmMonthMask.Checked[i] := true
    else
     clmMonthMask.Checked[i] := false;
end;
function TTQweryModule.GetWDayMaskEx:Word;
var
    i     : integer;
    wMask : Word;
Begin
    wMask := Byte(cbDayMask.Checked=True);
    for i := 0 to 6 do
    wMask := wMask or ((Byte(clmDayMask.Checked[i]=True)) shl (i+1));
    Result := wMask;
End;
function TTQweryModule.GetMDayMaskEx:DWord;
var
    i      : integer;
    dwMask : DWord;
Begin
    dwMask := Byte(cbMonthMask.Checked=True);
    for i := 0 to 30 do
    dwMask := dwMask or ((Byte(clmMonthMask.Checked[i]=True)) shl (i+1));
    Result := dwMask;
End;

function TTQweryModule.GetStateMask:String;
var
    i     : integer;
    strStatus : String;
Begin
    for i := 0 to clmRunStatus.Items.Count - 1 do
    begin
    if clmRunStatus.Checked[i]=True then
      strStatus := strStatus + IntToStr(queryState.IndexOf(clmRunStatus.Items[i]))+',';
    end;
    if strStatus='' then strStatus := IntToStr(TASK_QUERY)+','+IntToStr(TASK_WAIT_RUN)+',';
    delete(strStatus, length(strStatus), 1);
    Result := strStatus;
End;


procedure TTQweryModule.cbDayMaskClick(Sender: TObject);
begin
    if cbDayMask.Checked=True then
     Begin
      cbMonthMask.Checked:=False;
      cbMonthMaskClick(self);
      clmDayMask.Enabled := True;
      //btm_swDayMask.Enabled := True;
     End else
     if cbDayMask.Checked=False then
     Begin
      clm_swDayMask.Enabled := False;
      //btm_swDayMask.Enabled := False;
     End;
end;

procedure TTQweryModule.cbMonthMaskClick(Sender: TObject);
begin
     if cbMonthMask.Checked=True then
     Begin
      cbDayMask.Checked    := False;
      cbDayMaskClick(self);
      clmMonthMask.Enabled := True;
      //btm_sdwMonthMask.Enabled := True;
     End else
     if cbMonthMask.Checked=False then
     Begin
      clmMonthMask.Enabled := False;
      //btm_sdwMonthMask.Enabled := False;
     End;
end;

procedure TTQweryModule.saveParamsClick(Sender: TObject);
Var
     pTbl : QGPARAM;
begin
 try
  try
     pTbl := GetToScreen;
     m_pDB.addQueryGroupParam(pTbl);
//  if MessageDlg('Применить настройки :'+qgIDName+'/'+qgParamName+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then begin
   // if (qgID<>-1) then begin
   //   with lcCEApplySettingsForParameter do                 // BO 20.11.18
   //     LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName + ' / ' + qgParamName);
      SendQSComm(QS_INIT_SR,-1,-1);
   //  End;
  except
   if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(ERROR!!! TTQweryModule.saveParamsClick :: Настройки группы не сохранены!');
  end;
 finally
  if pTbl<>Nil then FreeAndNil(pTbl);
 end;
end;
procedure TTQweryModule.sgQGroupGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    with sgQGroup do
    case ACol of
     4:Begin
        AEditor := edCheckBox;
       End;
    end;
end;

procedure TTQweryModule.sgQGroupCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
Var
    aboid : Integer;
    NewCheckBox: TCheckBox;
    s:boolean;
begin
    try
       if ACol=3 then
       begin
        aboid := StrToInt(sgQGroup.Cells[2,ARow]);
        if State then
          begin
           if pDb<>nil then pDb.setQueryGroupAbonsState(qgID,aboid,1);
//           m_pDB.setQueryGroupAbonsState(qgID,aboid,1);
           s:= sgQGroup.ToggleCheckBox(4, ARow);
            if (s=true)then
             //m_pDB.setQueryGroupAbonsStateProg(qgID,aboid,1);
             pDb.setQueryGroupAbonsStateProg(qgID,aboid,1);
          end
        else
        Begin
          //m_pDB.setQueryState(aboid,-1,QUERY_STATE_NO);
          //m_pDB.setQueryGroupAbonsState(qgID,aboid,0);
          if pDb<>nil then pDb.setQueryGroupAbonsState(qgID,aboid,0);
          s:= sgQGroup.ToggleCheckBox(4, ARow);
            if (s=true)then
             //m_pDB.setQueryGroupAbonsStateProg(qgID,aboid,0);
             pDb.setQueryGroupAbonsStateProg(qgID,aboid,0);
        End;
       end;

       if ACol=4 then
       begin
        aboid := StrToInt(sgQGroup.Cells[2,ARow]);
        if State then
         // m_pDB.setQueryGroupAbonsStateProg(qgID,aboid,1)
         pDb.setQueryGroupAbonsStateProg(qgID,aboid,1)
        else
        Begin
          //m_pDB.setQueryState(aboid,-1,QUERY_STATE_NO);
         // m_pDB.setQueryGroupAbonsStateProg(qgID,aboid,0);
         pDb.setQueryGroupAbonsStateProg(qgID,aboid,0);
        End;
       end;
    except
    
    end;
end;

procedure TTQweryModule.OnDelIAbonItem(Sender: TObject);
var
   pTbl  : TThreadList;
   res  : boolean;
   vList : TList;
   data  : qgabons;
   i     : Integer;
Begin
  //  if MessageDlg('Удалить дом № '+IntToStr(qgAbon)+' из группы № '+IntToStr(qgID)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    // m_pDB.delQueryGroupAbons(qgID,qgAbon);
    try
     pTbl  := TThreadList.Create;
     vList :=nil;
     if pDb<>nil then
     begin
       res := pDb.GetEnable(qgID,pTbl); //извлекаем все объекты нажатой галочкой
       if (res=true)then
       begin
          vList := pTbl.LockList;
          if MessageDlg('Удалить '+IntToStr(vList.Count)+' объект(ов) из группы ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
            begin
             for i:=0 to vList.Count-1 do
               Begin
                 data := vList[i];
                 pDb.delQueryGroupAbons(qgID,data.ABOID); //удаляем из базы //m_pDB.delQueryGroupAbons(qgID,data.ABOID); //удаляем из базы
               End;
            if vList <> nil then pTbl.UnLockList;
            if data<>nil then FreeAndNil(data);
            End
          else
            begin
             if vList <> nil then pTbl.UnLockList;
             exit;
            end;
       end;
     end;
    finally
      FreeAndNil(pTbl);
    end;
  OnTimeElapsed(Sender);
//  Application.ProcessMessages;
End;

procedure TTQweryModule.sgQGroupClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
    if ARow>0 then
    Begin
     if sgQGroup.Cells[2,ARow]<>'' then
     Begin
      qgAbon := StrToInt(sgQGroup.Cells[2,ARow]);
     End else qgAbon := -1;
    End;
end;

procedure TTQweryModule.queryStartClick(Sender: TObject);
var
  dt:integer;
begin
{$IFDEF HOMEL}
  if qgParamID=QRY_NAK_EN_DAY_EP then
  begin
    dt:=Trunc(now) - Trunc(mdtBegin.DateTime);
    if Trunc(now) - Trunc(mdtBegin.DateTime) > 5  then
     begin
      ShowMessage('Чтение показаний к началу суток максимально 6 суток в глубину!!!');
      exit;
     end
    else
    begin
      if MessageDlg('Обновить данные :'+qgIDName+'/'+qgParamName+' с '+DateToStr(mdtEnd.DateTime)+
     ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then begin
       with lcCEInterview do                 // BO 20.11.18
        LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName + ' / ' + qgParamName + ' за период с '+DateToStr(mdtEnd.DateTime)+
          ' по '+DateToStr(mdtBegin.DateTime));
        SendQSTreeData(QS_UPDT_SR,qgID,2,mdtBegin.DateTime,mdtEnd.DateTime);//для смены параметра для анализа состояния группы опроса
        SendQSData(QS_UPDT_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
      End;
    end;
  end
  else
    begin
      if MessageDlg('Обновить данные :'+qgIDName+'/'+qgParamName+' с '+DateToStr(mdtEnd.DateTime)+
     ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then begin
       with lcCEInterview do                 // BO 20.11.18
        LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName + ' / ' + qgParamName + ' за период с '+DateToStr(mdtEnd.DateTime)+
          ' по '+DateToStr(mdtBegin.DateTime));
        SendQSTreeData(QS_UPDT_SR,qgID,2,mdtBegin.DateTime,mdtEnd.DateTime);//для смены параметра для анализа состояния группы опроса
        SendQSData(QS_UPDT_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
      End;
    end;

{$ELSE}
  if MessageDlg('Обновить данные :'+qgIDName+'/'+qgParamName+' с '+DateToStr(mdtEnd.DateTime)+
     ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then begin
    with lcCEInterview do                 // BO 20.11.18
      LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName + ' / ' + qgParamName + ' за период с '+DateToStr(mdtEnd.DateTime)+
          ' по '+DateToStr(mdtBegin.DateTime));
      SendQSTreeData(QS_UPDT_SR,qgID,2,mdtBegin.DateTime,mdtEnd.DateTime);//для смены параметра для анализа состояния группы опроса
      SendQSData(QS_UPDT_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
     End;
{$ENDIF}
end;

procedure TTQweryModule.findButtonClick(Sender: TObject);
begin
     if MessageDlg('Выполнить поиск :'+qgIDName+'/'+qgParamName+' с '+DateToStr(mdtEnd.DateTime)+
     ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSData(QS_FIND_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
     End;
end;

procedure TTQweryModule.stopButtonClick(Sender: TObject);
var s : string;
begin
     if MessageDlg('Остановить операцию :'+qgIDName+'/'+qgParamName+' с '+DateToStr(mdtEnd.DateTime)+
       ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then begin
      with lcCEStop do                 // BO 20.11.18
      LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now,qgIDName + ' / ' + qgParamName);
      SendQSData(QS_STOP_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
     End;
end;


procedure TTQweryModule.mdtBeginChange(Sender: TObject);
begin
     mdtEnd.DateTime := mdtBegin.DateTime;
end;

procedure TTQweryModule.itAllGroupClick(Sender: TObject);
Var
     pDb  : CDBDynamicConn;
     stat : Integer;
begin
     try
       pDb  := CDBDynamicConn.Create; //m_pDB.getConnection;
       pDb.Create(pDb.InitStrFileName);
        { DONE : ДОПИСАТЬ ОБНОВЛЕНИЯ }
       itAllGroup.Checked := true;
       itElement.Checked  := false;
       stat := Integer(itAllGroup.Checked);
       pDb.setQueryGroupStat(qgID,stat);
     finally
       if pDb<>Nil then
       begin
       pDb.Disconnect; //m_pDB.DiscDynConnect(pDb);
       FreeAndNil(pDb);
       end;
     End;
end;



procedure TTQweryModule.pmMnuStatPopup(Sender: TObject);
Var
    pTbl   : TThreadList;
    data   : querygroup;
    vList  : TList;
begin
    pTbl   := TThreadList.Create;
    if m_pDB.GetQueryGroups(qgID,pTbl)=True then
    Begin
     vList := pTbl.LockList;
     data  := vList[0];
     itAllGroup.checked := Boolean(data.statparam);
     itElement.checked  := not itAllGroup.checked;
     pTbl.UnlockList;
    End;
end;

procedure TTQweryModule.itElementClick(Sender: TObject);
Var
     pDb  : CDBDynamicConn;
     stat : Integer;
begin
     try
       pDb  := CDBDynamicConn.Create; //m_pDB.getConnection;
       pDb.Create(pDb.InitStrFileName);
       itAllGroup.Checked := false;
       itElement.Checked  := true;
       stat := Integer(itAllGroup.Checked);
       pDb.setQueryGroupStat(qgID,stat);
     finally
     if pDb<>Nil then
      begin
       pDb.Disconnect;//m_pDB.DiscDynConnect(pDb);
       FreeAndNil(pDb);
      end;
     End;
end;

procedure TTQweryModule.statButtClick(Sender: TObject);
begin
    if itAllGroup.Checked then
      itElementClick(sender) else
      itAllGroupClick(sender);
end;



procedure TTQweryModule.autoUnloadClick(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strVTPath.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;
{
procedure TTQweryModule.queryStartClick(Sender: TObject);
begin
     if MessageDlg('Обновить данные группа/параметр :'+IntToStr(qgID)+'/'+IntToStr(qgParamID)+' с '+DateToStr(mdtEnd.DateTime)+
     ' по '+DateToStr(mdtBegin.DateTime)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSData(QS_UPDT_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
     End;
end;
}
procedure TTQweryModule.btUnloadStartClick(Sender: TObject);
begin
     if MessageDlg('Выгрузить данные :'+qgIDName+'/'+qgParamName+' период '+
     cbm_snVTDeepFind.Text+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSData(QS_UNLD_SR,qgID,qgParamID,mdtBegin.DateTime,mdtEnd.DateTime);
      MessageDlg('Модуль выгрузки завершен!',mtWarning,[mbOk],0);
     End;
end;

procedure TTQweryModule.nClearAbonsClick(Sender: TObject);
begin
    m_pDB.setQueryGroupAbonsState(qgID,-1,0);
    OnTimeElapsed(Sender);
end;

procedure TTQweryModule.nSetAbonsClick(Sender: TObject);
begin
   m_pDB.setQueryGroupAbonsState(qgID,-1,1);
   OnTimeElapsed(Sender);   
end;
function TTQweryModule.createSortString():String;
Var
    strSort : String;
Begin
  {  strSort :=  getHint(stateItem,'')+
                   getHint(allItem,'desc')+
                   getHint(isokItem,'desc')+
                   getHint(iserItem,'desc')+
                   getHint(nameItem,'')+
                   getHint(beginItem,'')+
                   getHint(TypeItem,'')+
                   getHint(enable,'desc')+
                   getHint(endItem,'');
    if strSort='' then
     strSort := stateItem.Hint
    else
     delete(strSort, length(strSort), 1);}
     case old_sorting of
       3  : strSort := 'ENABLE';
       5  : if old_decs then strSort:= 'townNM DESC, TPNM DESC, streetNM DESC, aboNM'
            else strSort:= 'townNM, TPNM, streetNM, aboNM';
       6  : strSort := 'DTBEGINH';
       7  : strSort := 'DTENDH';
       9  : strSort := 'ALLCOUNTER';
       10 : strSort := 'ISOK';
       12 : strSort := 'ISER';
      { 13 : strSort := 'PERCEND';
       14 : strSort := 'QANTITY'; }
       16 : strSort := 'SBYTYPE';
       17 : strSort := getHint(StateItem,'');
     end;
     if old_decs then strSort:= strSort + ' DESC';
    Result := strSort;
End;
function TTQweryModule.getHint(item:TMenuItem;sort:String):String;
Begin
   // if item.Checked then
   //  begin
   //   if (item.Hint=stateItem.Hint) then
       Result:='(case when(STATE=14) then 0'+
               ' when (STATE=4) then 1'+
               ' when (STATE=15) then 2'+
               ' when (STATE=12) then 3'+
               ' when (STATE=16) then 4'+
               ' when (STATE=0) then 5'+
               ' when (STATE=1) then 6'+
               ' when (STATE=2) then 7'+
               ' when (STATE=3) then 8'+
               ' when (STATE=5) then 9'+
               ' when (STATE=6) then 10'+
               ' when (STATE=7) then 11'+
               ' when (STATE=8) then 12'+
               ' when (STATE=9) then 13'+
               ' when (STATE=10) then 14'+
               ' when (STATE=11) then 15'+
               ' when (STATE=13) then 16'+
               ' when (STATE=17) then 17'+
               ' when (STATE=18) then 18'+
               ' when (STATE=19) then 19'+
               ' when (STATE=20) then 20'+
               ' else 21 end)';//+' '+sort+','
//      else
  //       Result := item.Hint+' '+sort+',';
//     end
  //  else
//     Result := '';
End;

procedure TTQweryModule.nameItemClick(Sender: TObject);
begin
    (Sender as TMenuItem).Checked := not (Sender as TMenuItem).Checked;
end;

procedure TTQweryModule.cbRunStatusClick(Sender: TObject);
begin
    if cbRunStatus.Checked=True then
     Begin
      clmRunStatus.Enabled := True;
     End else
     if cbRunStatus.Checked=False then
     Begin
      clmRunStatus.Enabled := False;
     End;
end;

procedure TTQweryModule.setNullStateClick(Sender: TObject);
var
   pTbl  : TThreadList;
   res   : boolean;
   vList : TList;
   data  : qgabons;
   i     : integer;
begin
  try
     if MessageDlg('Перевести группу № '+qgIDName+' в исходное состояние ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      utlDB.DBase.ExecQry('UPDATE QUERYGROUP SET ERRORQUERY = 0 WHERE ID = ' + IntToStr(qgID));
      utlDB.DBase.IBQuery.Close;
      m_pDB.setQueryQroupState(qgID,TASK_WAIT_RUN);

       pTbl  := TThreadList.Create;
       vList :=nil;
       res :=m_pDB.GetAbonGroup(qgID,pTbl); //извлекаем все объекты из гурппы
        if (res=true)then
         begin
           vList := pTbl.LockList;

            for i:=0 to vList.Count-1 do
             Begin
               data := vList[i];
                m_pDB.SetQueryGroupAbonsNoGSM(data.ABOID);
                if data<>nil then FreeAndNil(data);
             End;
           if vList <> nil then pTbl.UnLockList;
         End
        else
          begin
           if vList <> nil then pTbl.UnLockList;
           exit;
          end;
     end;
  finally
      FreeAndNil(pTbl);
      TKnsForm.frameTreeDataModule.RefreshGroupByID;
      OnTimeElapsed(Sender);
  end;
end;

procedure TTQweryModule.setGroupParam(Sender: TObject);
Var
     saveType : Integer;
     groupID  : Integer;
     sql : String;
begin
     //groupID := -1;
     groupID := qgID; //применить к определенной группе
   //  if MessageDlg('Применить настройку параметр :'+IntToStr(groupID)+'/'+IntToStr(qgParamID)+' ко всем группам ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
//     if MessageDlg('Применить настройку параметр :'+IntToStr(qgParamID)+' к группе '+IntToStr(groupID)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
//     if MessageDlg('Применить настройку параметр :'+IntToStr(qgParamID)+' к группе '+qgIDName+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     if MessageDlg('Применить настройку параметра : '+qgParamName+' к группе '+qgIDName+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      saveType := (Sender as TAdvGlowButton).tag;
      case saveType of
        0 : begin
              with lcPCBeginningSurveyPeriod do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'DTBEGIN='+''''+DateTimeToStr(dtBegin.DateTime)+'''';
            end;
        1 : begin
              with lcPCEndingSurveyPeriod do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'DTEND='+''''+DateTimeToStr(dtEnd.DateTime)+'''';
            end;
        2 : begin
              with lcPCPollingPeriod do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'DTPERIOD='+''''+DateTimeToStr(dtPeriod.DateTime)+'''';
            end;
        3 : begin
              with lcPCAllowAutoUpload do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'UNENABLE='+IntToStr(Byte(chm_sbyVTEnable.Checked));
            end;
        4 : begin
              with lcPCTakeIntoAccountDaysOfTheWeek do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'DAYMASK='+IntToStr(GetWDayMaskEx);
            end;
        5 : begin
              with lcPCTakeIntoAccountDaysOfTheMonth do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'MONTHMASK='+IntToStr(GetMDayMaskEx);
            end;
        6 : begin
              with lcPCRunWithStatus do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'ISRUNSTATUS='+IntToStr(Byte(cbRunStatus.Checked))+', RUNSTATUS='+''''+GetStateMask+'''';
            end;
        7 : begin
              with lcPCCriticalErrorRate do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'ERRORPERCENT='+IntToStr(spinError.Value);
            end;
        8 : begin
              with lcPCSearchDepth do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'DEEPFIND='+IntToStr(cbDeepFind.ItemIndex);
            end;
        9 : begin
              with lcPCAllowAutoPoll do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
              sql := 'ENABLE='+IntToStr(Byte(cbEnable.Checked));
            end;
        10 : begin
              with lcPCPause do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
               sql := 'PAUSE='+IntToStr(Byte(cbPause.Checked));
             end;
        11 : begin
              with lcPCSearchUpdate do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
               sql := 'FINDDATA='+IntToStr(Byte(cbFindUpdate.Checked));
             end;
        12 : begin
              with lcPCUnloadingDepth do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
               sql := 'UNDEEPFIND='+IntToStr(cbm_snVTDeepFind.ItemIndex);
             end;
        13 : begin
              with lcPCUnloadingDepth do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
               sql := 'PACK_KUB='+IntToStr(Byte(cbPacket_KUB.Checked));
             end;
        14 : begin
              with lcPCUnloadingDepth do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
               sql := 'ERRORPERCENT2='+IntToStr(spinError2.Value);
             end;
        15 : begin
              with lcPCUnloadingDepth do                 // BO 21.11.18
                LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, qgIDName);
               sql := 'TIMETOSTOP='+''''+DateTimeToStr(TimeToStop.DateTime)+'''';
             end;
      End;
      m_pDB.updateGQParams(groupID,qgParamID,sql);
      //SendQSComm(QS_INIT_GS,groupID,qgParamID);
      SendQSComm(QS_INIT_SR,groupID,-1);
     End;
end;


procedure TTQweryModule.VisableGroupB(vis : boolean);
begin
  Label25.Visible:=vis;
  spinError.Visible:=vis;
  AdvGlowButton10.Visible:=vis;
  Label23.Visible:=vis;
  cbDeepFind.Visible:=vis;
  AdvGlowButton11.Visible:=vis;
end;

procedure TTQweryModule.VisableGroupC(vis : boolean);
begin
  GradientLabel2.Visible:=vis;
  Label21.Visible:=vis;
  Label22.Visible:=vis;
  mdtEnd.Visible:=vis;
  mdtBegin.Visible:=vis;
end;

procedure TTQweryModule.VisableGroupD(vis : boolean);
begin
  GradientLabel4.Visible:=vis;
  chm_sbyVTEnable.Visible:=vis;
  AdvGlowButton18.Visible:=vis;
  Label98.Visible:=vis;
  em_strVTPath.Visible:=vis;
  autoUnload.Visible:=vis;
  Label103.Visible:=vis;
  cbm_snVTDeepFind.Visible:=vis;
  AdvGlowButton19.Visible:=vis;
  btUnloadStart.Visible:=vis;
  cbRunStatus.Visible:=vis;
  AdvGlowButton14.Visible:=vis;
  clmRunStatus.Visible:=vis;
end;

procedure TTQweryModule.VisableAny(tz:integer);
begin
  case tz of
    0  : begin
           VisableGroupB(true);
           VisableGroupC(false);
           VisableGroupD(false);
           queryStart.Caption:='Опросить текущие';
         end;
    1  : begin
           VisableGroupB(true);
           VisableGroupC(true);
           VisableGroupD(false);
           queryStart.Caption:='Опр. на нач. суток';
         end;
    2  : begin
           VisableGroupB(true);
           VisableGroupC(true);
           VisableGroupD(true);
           queryStart.Caption:='Опр. на нач. месяца';
         end;
    3  : begin
           VisableGroupB(true); //false
           VisableGroupC(false);
           VisableGroupD(false);
           queryStart.Caption:='Скоректир. дата/время';
         end;
    else begin
           VisableGroupB(true);
           VisableGroupC(true);
           VisableGroupD(true);
           queryStart.Caption:='Опросить';
         end;
  end;
end;

procedure TTQweryModule.FindBtnClick(Sender: TObject);
var srow : integer;
    i   : integer;
    s1, s2 : string;
begin
  i:=CurrentFindRow;
  for i := CurrentFindRow+1 to sgQGroup.RowCount-1 do begin
    s1:=FindEdit.Text;
    s2:=sgQGroup.cells[5,i];
    s1:=AnsiUpperCase(s1);
    s2:=AnsiUpperCase(s2);
    srow:=pos(s1,s2);
    if srow <> 0 then begin
      CurrentFindRow:=i;
      FindBtn.Caption:='Повтор';
      break;
    end;
  end;
  if (srow = 0) and (sgQGroup.RowCount-1 <= i) then begin
    ShowMessage('Поиск не дал результата');
    FindBtn.Caption:='Поиск';
    CurrentFindRow:=0;
    exit;
  end;

  sgQGroup.Selection:=TGridRect(Rect(1, CurrentFindRow, sgQGroup.ColCount, CurrentFindRow));

  if sgQGroup.RowCount-1 > sgQGroup.VisibleRowCount then
    if sgQGroup.VisibleRowCount < CurrentFindRow then sgQGroup.TopRow:=CurrentFindRow;
//  OnTimeElapsed(self);                   // BO 28.06.19      // Рома, на 90% все решается добавлением refresh
  sgQGroup.Refresh;
end;

procedure TTQweryModule.FindEditChange(Sender: TObject);
begin
  FindBtn.Caption:='Поиск';
  CurrentFindRow:=0;
end;

procedure TTQweryModule.N33Click(Sender: TObject);
var
  gc: TGridCoord;
  i:integer;
  aboid : Integer;
begin
  for i := 0 to sgQGroup.RowCount -1 do begin
    if sgQGroup.RowSelect[i] then begin
      aboid := StrToInt(sgQGroup.Cells[2,i]);
      m_pDB.setQueryGroupAbonsState(qgID,aboid,1);
      if sgQGroup.HasCheckBox(4,i) then
         m_pDB.setQueryGroupAbonsStateProg(qgID,aboid,1);
    end;
  end;
  OnTimeElapsed(Sender);
(*for i := 1 to {sgQGroup.SelectedCellsCount} sgQGroup.RowSelectCount do
begin
gc := sgQGroup.SelectedCell[i - 1];
 //sgQGroup.RowSelectCount
DoNot4Check :=true;
sgQGroupCheckBoxClick(sgQGroup,3, gc.Y, true);
DoNot4Check :=false;
end; *)

end;

procedure TTQweryModule.sgQGroupButtonClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if ARow = 0 then SortingCol:=ACol;
  RowClick:=ARow;
end;

procedure TTQweryModule.sgQGroupMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i : Integer;
begin
  for i := 0 to sgQGroup.ColCount - 1 do
    TSGsgQGroup.GrWidth[i]:=sgQGroup.ColWidths[i];
end;

procedure TTQweryModule.sgQGroupMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i   : Integer;
    res : Boolean;
    GC  : TGridCoord;
begin
  GC := sgQGroup.MouseCoord(X,Y);
  if (GC.Y = 0) or (GC.Y = 1) then begin
    res:=False;
    for i := 0 to sgQGroup.ColCount-1 do
      if TSGsgQGroup.GrWidth[i] <> sgQGroup.ColWidths[i] then begin
        res:=True;
        TSGsgQGroup.GrWidth[i]:=sgQGroup.ColWidths[i];
      end;
    if res then begin // resize

    end else begin  // sorting
      if GC.Y = 0 then sgQGroupBtnClic;
    end;
  end;
end;

procedure TTQweryModule.sgQGroupBtnClic;
var i : integer;
begin
  if RowClick = 0 then begin
    if old_sorting = SortingCol then begin
    old_decs:=not old_decs;
    if old_decs then begin
        if sgQGroup.GetImageIdx(old_sorting,0,i) then
          sgQGroup.RemoveImageIdx(old_sorting,0);
        old_sorting:=SortingCol;
        sgQGroup.AddImageIdx(SortingCol,0,15,haBeforeText,vaCenter);
      end else begin
        if sgQGroup.GetImageIdx(old_sorting,0,i) then
          sgQGroup.RemoveImageIdx(old_sorting,0);
        old_sorting:=SortingCol;
        sgQGroup.AddImageIdx(SortingCol,0,14,haBeforeText,vaCenter);
      end;
    end else begin
      if SortingCol in [3, 5, 6, 7, 9, 10, 12, 16, 17] then begin
        if sgQGroup.GetImageIdx(old_sorting,0,i) then
          sgQGroup.RemoveImageIdx(old_sorting,0);
        old_sorting:=SortingCol;
        sgQGroup.AddImageIdx(SortingCol,0,14,haBeforeText,vaCenter);
    end;
  end;
  OnTimeElapsed(self);
//  sgQGroup.Refresh;
  //Application.ProcessMessages;
  end;
end;

procedure TTQweryModule.miAddAllClsClick(Sender: TObject);
begin
  ExtractListBox.Left := mouseXY.x;
  ExtractListBox.Top  := mouseXY.y;
  ExtractListBox.Height := 120;
  ExtractListBox.Width  := 300;
  ExtractListBox.Visible := True;

  ExtractBitBtn.Left := 0;
  ExtractBitBtn.Width := 300-2;
  ExtractBitBtn.Top  := ExtractListBox.Height -25 -2;

  m_pDB.GetExtParam(QGID, ExtractListBox);
end;

procedure TTQweryModule.FTreeQweryDataMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mouseXY.x := X;
  mouseXY.y := Y;
end;

procedure TTQweryModule.ExtractBitBtnClick(Sender: TObject);
begin
  ExtractListBox.Visible := false;
  m_pDB.SetExtParam(QGID, ExtractListBox);
  InitFrameID(_PQGD, 0);
end;

procedure TTQweryModule.PrepareQueryAbon(sQC : SQWERYCMDID);
var i : Integer;
    dbIsOk   : Double;
    dbIsNo   : Double;
    dbIsEr   : Double;
    dbAllCt  : Double;
    dbPERCENT: Double;
    dbQUALITY: Double;
    st1      : string;
begin
 try
  if advSrvPager.ActivePageIndex = 2 then begin
    if sQC.m_snSRVID = qgID then begin         //  sgQGroup.Cells[1,i]
      for i := 0 to sgQGroup.RowCount - 1 do begin
        if sgQGroup.Cells[2,i] = IntToStr(sQC.m_snABOID) then begin
          sgQGroup.Cells[6,i] := DateTimeToStr(sQC.m_sdtBegin);
          sgQGroup.Cells[7,i] := DateTimeToStr(sQC.m_sdtEnd);
          sgQGroup.Cells[8,i] := TimeToStr(sQC.m_sdtEnd - sQC.m_sdtBegin);
          sgQGroup.Cells[10,i] := IntToStr(sQC.m_snCLID);    // опрошено
          sgQGroup.Cells[12,i] := IntToStr(sQC.m_snCLSID);   // не опрошено

          dbAllCt := StrToFloat(sgQGroup.Cells[9,i]);
          if(dbAllCt = 0) then dbAllCt := 1;
          dbIsOk := sQC.m_snCLID;
          dbIsNo := dbAllCt - dbIsOk - sQC.m_snCLSID;
          if dbIsNo < 0 then dbIsNo := 0;
          dbPERCENT     := 100*(dbAllCt-dbIsNo)/dbAllCt;
          dbQUALITY     := 100*dbIsOk/dbAllCt;
          sgQGroup.RemoveProgress(13,i);
          if (sQC.m_snCLSID > 0)and (sQC.m_snCLSID <= 10)then                 // if (pTbl.ISER>0)and (pTbl.ISER<=10)then
            sgQGroup.AddProgress(13,i,$00D7FF,clWindow) //желтый //12
          else if (sQC.m_snCLSID > 10)then                              // if (pTbl.ISER>10)then
            sgQGroup.AddProgress(13,i,$507FFF,clWindow) //красный //12
          else
            sgQGroup.AddProgress(13,i,$90EE90,clWindow); //зеленый //12
          sgQGroup.Ints[13,i] := trunc(dbQUALITY);  //12

          sgQGroup.RemoveProgress(14,i);
          sgQGroup.AddProgress(14,i,$90EE90,clWindow);//зеленый  //13
          sgQGroup.Ints[14,i] := trunc(dbPERCENT);            //13

          st1 := sgQGroup.Cells[15,i];
          if sQC.m_snVMID <> 0 then begin
           if PosNeg(':', st1) <> 0 then begin
            Delete(st1, PosNeg(':', st1), Length(st1));
            st1 := st1 + ': ' + IntToStr(sQC.m_snVMID) + ' порт';
           end
           else st1 := st1 + ': ' + IntToStr(sQC.m_snVMID) + ' порт';
          end;
          sgQGroup.Cells[15,i]:= st1;
          if (sQC.m_snCmdID=TASK_QUERY_COMPL)or (sQC.m_snCmdID=TASK_CONN_ERR) or (sQC.m_snCmdID=TASK_MANY_ERR) or (sQC.m_snCmdID=TASK_HAND_STOP)
          or (sQC.m_snCmdID=ERROR_NO_PROG)or (sQC.m_snCmdID=ERROR_PROG)or (sQC.m_snCmdID=TASK_QUERY_PROG_COMPL) or (sQC.m_snCmdID=DATA_PROCESSING)then
           begin
             Delete(st1, PosNeg(':', st1), Length(st1));
             sgQGroup.Cells[15,i]:= st1;
           end;
         sgQGroup.Cells[17,i]:= queryState.Strings[sQC.m_snCmdID];

{         if (sQC.m_snCmdID=ERROR_NO_PROG)or (sQC.m_snCmdID=ERROR_PROG)
         or (sQC.m_snCmdID=TASK_QUERY_PROG_COMPL) or (sQC.m_snCmdID=DATA_PROCESSING)
         or (sQC.m_snCmdID=TASK_QUERY_COMPL)or (sQC.m_snCmdID=TASK_CONN_ERR)then
           OnTimeElapsed(self); }
         exit;  
        end;
      end;
    end;
  end;
 except
  if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'(Error_PrepareQueryAbon :: Прорисовка прогрессбар!!!');
 end;
end;

procedure TTQweryModule.setNullStateQualityClick(Sender: TObject);
var
   pTbl  : TThreadList;
   res   : boolean;
   vList : TList;
   data  : qgabons;
   i     : Integer;
   str   : string;
Begin
  //  if MessageDlg('Удалить дом № '+IntToStr(qgAbon)+' из группы № '+IntToStr(qgID)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    // m_pDB.delQueryGroupAbons(qgID,qgAbon);
    try
    pTbl  := TThreadList.Create;
    vList :=nil;
     res :=m_pDB.GetEnable(qgID,pTbl); //извлекаем все объекты нажатой галочкой
     if (res=true)then
     begin
        vList := pTbl.LockList;
        if MessageDlg('Вернуть исходное качество '+IntToStr(vList.Count)+' объект(ов) из группы ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
          begin
           for i:=0 to vList.Count-1 do
             Begin
               data := vList[i];
               if m_pDB.GetQueryGroupAbons(qgID,data.ABOID,str)then
               begin
                 m_pDB.setQueryGroupAbons(data.ABOID,ReplaseSt(str,'0'));
               end;
             End;
          if vList <> nil then pTbl.UnLockList;
          if data<>nil then FreeAndNil(data);
          End
        else
          begin
           if vList <> nil then pTbl.UnLockList;
           exit;
          end;
     end;
    finally
      FreeAndNil(pTbl);
    end;
end;

function TTQweryModule.ReplaseSt(s, substr: string):string;
var sR : string;
begin
  sR:= Copy(s,1,Pos(';',s));
  Result := sR;
  Delete(s,1,Pos(';',s));
  sR:= sR + Copy(s,1,Pos(';',s));
  Delete(s,1,Pos(';',s));
  Delete(s,1,1);
  Delete(s,1,Pos(';',s)-1);  
  sR := sR + substr + s;
  Result := sR;  
end;

procedure TTQweryModule.btnRefreshClick(Sender: TObject);
begin
  OnTimeElapsed(self);
end;

procedure TTQweryModule.AutoStartOnError;
var nCount : Integer;
    strSQL : string;
    err, i : Integer;
begin
  StrSQL := 'SELECT * FROM QUERYGROUP WHERE ERRORQUERY <> 0';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    for i := 0 to nCount-1 do begin
      err := utlDB.DBase.IBQuery.FieldByName('ERRORQUERY').AsInteger;
      case err of
        1 : begin
          SendQSTreeData(QS_UPDT_SR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,3,Now,Now);//для смены параметра для анализа состояния группы опроса
          SendQSData(QS_RESTART_ERROR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,21,Now,Now);
        end;
        2 : begin
          SendQSTreeData(QS_UPDT_SR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,3,Now,Now);//для смены параметра для анализа состояния группы опроса
          SendQSData(QS_RESTART_ERROR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,21,Now,Now);
        end;
        3 : begin
          SendQSTreeData(QS_UPDT_SR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,3,Now,Now);//для смены параметра для анализа состояния группы опроса
          SendQSData(QS_RESTART_ERROR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,21,Now,Now);
        end;
        4 : begin
          SendQSTreeData(QS_UPDT_SR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,3,Now,Now);//для смены параметра для анализа состояния группы опроса
          SendQSData(QS_RESTART_ERROR,utlDB.DBase.IBQuery.FieldByName('ID').AsInteger,21,Now,Now);    { TODO 1 -oKudin -cАвтоопрос : Поменять ессли будет использоваться в дальнейшем }
        end;
      end;
      utlDB.DBase.IBQuery.Next;
    end;
  end;
end;

procedure TTQweryModule.WMCopyData(var MessageData: TWMCopyData);
var
    SQMD: SQWERYCMDID;
    s : string;
    _Message:String;
    _Type:Byte;
begin
  try
    _Type:= 0;
    RecivedClass.WMCopyData(MessageData,s);
    if MessageData.CopyDataStruct.dwData = QL_QWERYSTATISTICABON_REQ then begin
       SQMD := RecivedClass.ExtractString(s);
       PrepareQueryAbon(SQMD);
    end;
  except
    if EventBox<>Nil then EventBox.FixEvents(ET_CRITICAL,'l5module_MessageTree_ERROR');
  end
end;

end.

