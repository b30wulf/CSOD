unit knsl2fqwerymdl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AdvCombo, ComCtrls, paramchklist, AdvOfficeButtons, treelist,
  AdvEdit, AdvOfficePager, AdvOfficePagerStylers, AdvAppStyler, AdvPanel,
  ExtCtrls, Menus, AdvMenus, editlist, AdvGlowButton, AdvToolBar, utltypes,
  utldatabase,knsl5config, AdvMenuStylers, AdvToolBarStylers,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers,knsl2treehandler, ImgList,utlconst,utlbox,knsl3jointable,
  AdvSplitter, GradientLabel, AdvSmoothCalendar;

type
  CL3QweryTreeLoader = class(CTreeHandler)
   private
    function  CreateCTI:PCTI;override;
    function  IsTrueNode(nCTI:CTreeIndex):Boolean;override;
   public
    constructor Create(pTree : PTTreeView);
    destructor  Destroy;override;
    procedure   LoadTree(blAdd:Boolean;nCTI:CTreeIndex;var pQS:SQWERYMDLCOMMS);
    procedure   SetClusters(nTI:CTI;var pQS:SQWERYMDLCOMM;rtChild:TTreeNode);
    function    CheckState(byCheck:Byte;pQS:SQWERYMDLS):Byte;
    procedure   SetParams(nTI:CTI;var pTbl:SQWERYMDLCOMM;rtChild:TTreeNode);
  End;
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
    miCreateCluster: TMenuItem;
    miDeleteCluster: TMenuItem;
    N9: TMenuItem;
    ImageList1: TImageList;
    N12: TMenuItem;
    miStartCluster: TMenuItem;
    miQweryCluster: TMenuItem;
    miFindData: TMenuItem;
    N15: TMenuItem;
    miStopCluster: TMenuItem;
    AdvMainMenu1: TAdvMainMenu;
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
    mnuVMeter: TAdvPopupMenu;
    miStartClusters: TMenuItem;
    miStopClusters: TMenuItem;
    MenuItem3: TMenuItem;
    miQweryCounter: TMenuItem;
    MenuItem6: TMenuItem;
    miCreateClusters: TMenuItem;
    MenuItem8: TMenuItem;
    miDeleteClusters: TMenuItem;
    miStopQwery: TMenuItem;
    miStopQweryCluster: TMenuItem;
    N4: TMenuItem;
    miSaveSetClust: TMenuItem;
    N3: TMenuItem;
    miExecSetClust: TMenuItem;
    miCreateAllCluster: TMenuItem;
    miDeleteAllCluster: TMenuItem;
    miExecSetAllClust: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    miCloneSetClust: TMenuItem;
    miUpdateCluster: TMenuItem;
    miQweryGroup: TMenuItem;
    miQweryClusterGR: TMenuItem;
    miQweryParamGR: TMenuItem;
    miUpdateParam: TMenuItem;
    AdvPanel2: TAdvPanel;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvPanel5: TAdvPanel;
    Label10: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    GradientLabel2: TGradientLabel;
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
    edm_snVMID: TAdvEdit;
    edm_snMID: TAdvEdit;
    stSrvState: TStaticText;
    stMeterType: TStaticText;
    btm_sdtBegin: TAdvGlowButton;
    chm_sbyFindData: TCheckBox;
    cbm_snDeepFind: TComboBox;
    btm_sdtEnd: TAdvGlowButton;
    btm_sdtPeriod: TAdvGlowButton;
    btm_swDayMask: TAdvGlowButton;
    btm_sdwMonthMask: TAdvGlowButton;
    edm_snAID: TAdvEdit;
    edm_snGID: TAdvEdit;
    edm_sGroupExpress: TRichEdit;
    AdvOfficePage1: TAdvOfficePage;
    Label17: TLabel;
    Label12: TLabel;
    AdvPanel3: TAdvPanel;
    AdvPanel4: TAdvPanel;
    advTreePanell: TAdvPanel;
    advTreeTool: TAdvToolBar;
    advButTree: TAdvGlowMenuButton;
    advButOper: TAdvGlowMenuButton;
    FTreeQweryData: TTreeView;
    AdvSplitter2: TAdvSplitter;
    AdvSplitter1: TAdvSplitter;
    dttm_sdtBegin: TAdvSmoothCalendar;
    dttm_sdtEnd: TAdvSmoothCalendar;
    cbm_strCMDCluster: TParamCheckList;
    cbm_nAddCommand: TComboBox;
    btm_sbyFindData: TAdvGlowButton;
    btm_nSvClustGr: TAdvGlowButton;
    btm_nSubParam: TAdvGlowButton;
    btm_nTopParam: TAdvGlowButton;
    btm_nAddParam: TAdvGlowButton;
    btm_sbyEnable: TAdvGlowButton;
    btm_sExecForGroup: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    Label18: TLabel;
    Label16: TLabel;
    GradientLabel1: TGradientLabel;
    procedure FormCreate(Sender: TObject);
    procedure mnuFilterClick(Sender: TObject);
    procedure OnClickTree(Sender: TObject);
    procedure OnSaveServer(Sender: TObject);
    procedure OnLoadQwery(Sender: TObject);
    procedure OnClickWDay(Sender: TObject);
    procedure chm_sdwMonthMaskClick(Sender: TObject);
    procedure OnCreateSRV(Sender: TObject);
    procedure OnCreateAllSRV(Sender: TObject);
    procedure OnDeleteSRV(Sender: TObject);
    procedure OnDeleteAllSRV(Sender: TObject);
    procedure miStartClusterClick(Sender: TObject);
    procedure OnStopQwery(Sender: TObject);
    procedure OnSaveButt(Sender: TObject);
    procedure OnResizePannel(Sender: TObject);
    procedure miQweryClusterClick(Sender: TObject);
    procedure miStopQweryClusterClick(Sender: TObject);
    procedure miFindDataClick(Sender: TObject);
    procedure OnClickFind(Sender: TObject);
    procedure miSaveSetClustClick(Sender: TObject);
    procedure miExecSetClustClick(Sender: TObject);
    procedure miCreateAllClusterClick(Sender: TObject);
    procedure btm_sdtBeginClick(Sender: TObject);
    procedure btm_sdtEndClick(Sender: TObject);
    procedure btm_sdtPeriodClick(Sender: TObject);
    procedure btm_swDayMaskClick(Sender: TObject);
    procedure btm_sdwMonthMaskClick(Sender: TObject);
    procedure btm_sbyFindDataClick(Sender: TObject);
    procedure btm_sbyEnableClick(Sender: TObject);
    procedure btm_sExecForGroupClick(Sender: TObject);
    procedure miDeleteAllClusterClick(Sender: TObject);
    procedure miExecSetAllClustClick(Sender: TObject);
    procedure miCloneSetClustClick(Sender: TObject);
    procedure miQweryCounterClick(Sender: TObject);
    procedure miStopQweryClick(Sender: TObject);
    procedure miStartClustersClick(Sender: TObject);
    procedure miStopClustersClick(Sender: TObject);
    procedure miDeleteClustersClick(Sender: TObject);
    procedure miUpdateClusterClick(Sender: TObject);
    procedure dttm_sdtBeginChange(Sender: TObject);
    procedure miQweryGroupClick(Sender: TObject);
    procedure miUpdateParamClick(Sender: TObject);
    procedure miQweryClusterGRClick(Sender: TObject);
    procedure miQweryParamGRClick(Sender: TObject);
    procedure btm_nTopParamClick(Sender: TObject);
    procedure btm_nBottParamClick(Sender: TObject);
    procedure btm_nSubParamClick(Sender: TObject);
    procedure btm_nSvClustGrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure AdvSplitter2Moved(Sender: TObject);
  private
    { Private declarations }
    QweryStruct : SQWERYMDLCOMMS;
    ParmsList   : QM_PARAMS;
    m_nTree     : CL3QweryTreeLoader;
    m_nCTI      : CTreeIndex;
    m_sFilter   : String;
    m_pRPDS     : CGDataSource;
    m_nJOIN     : CJoinTable;
    m_sQC       : SQWERYCMDID;
    procedure LoadCommanList(snMID:Integer);
    procedure LoadEdits;
    procedure LoadDayChBox(dwDayWMask:Dword);
    procedure LoadMonthChBox(dwDayMask:Dword);
    procedure LoadEdit(nCTI:CTreeIndex);
    procedure LoadCluster(strCluster:String);
    procedure SetDefaultCluster;
    procedure SetDefaultQwery(nCTI:CTreeIndex);
    function  GetWDayMask:Word;
    function  GetMDayMask:DWord;
    function  GetCluster:String;
    function  GetQweryPTBL(var pTbl:SQWERYMDL):Boolean;
    function  FindStructID:Integer;
    function  FindMnlID(sID:Integer):Integer;
    function  GetExpression(nCTI:CTreeIndex):String;
    procedure GetEdits(var pTbl:SQWERYMDL);
    procedure SaveCurrEdit(byState:Integer);
    procedure SendQSComm(nCommand:Integer);
    procedure SendQSData(nCommand,nCLSID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure SendDynComm(nRID,nAID,nGID,nVID,nCLID,nPrmID,nCommand:Integer);
    procedure SendDynData(nRID,nAID,nGID,nVID,nCLID,nPrmID:Integer;sdtBegin,sdtEnd:TDateTime;nCommand:Integer);
    procedure CheckFind(blMenu:Boolean);
    procedure MenuPrepareCL(nLevel:Integer);
    procedure MenuPrepareVM;
    procedure PrepareCommand(sID,nID:Integer);
    function  InsertStr(var str:String;strPattern,strNew:String):Boolean;
  public
    { Public declarations }
    procedure InitFrame(nCTI:PCTreeIndex);
  end;

var
  TQweryModule: TTQweryModule;
const
  DeltaFHF     : array [0..10] of integer = (1,1,2,3,5, 7, 14, 31, 62, 182, 365);
implementation

{$R *.DFM}
//CL3QweryTreeLoader
constructor CL3QweryTreeLoader.Create(pTree : PTTreeView);
Begin
     inherited Create(pTree);
End;
destructor  CL3QweryTreeLoader.Destroy;
Begin

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
procedure   CL3QweryTreeLoader.LoadTree(blAdd:Boolean;nCTI:CTreeIndex;var pQS:SQWERYMDLCOMMS);
Var
     nI   : CTI;
     i    : Integer;
Begin
     if blAdd=False then
     Begin
      FTree.FullCollapse;
      FreeTree;
      FTree.ReadOnly := True;
     End;
     for i:=0 to pQS.Count-1 do
     Begin
      with nCTI,pQS.Items[i] do
      Begin
       nI := CTI.Create(2,SD_VMETR,PNID,PRID,PAID,m_swGID,m_swVMID,m_swMID,m_swPID,PSTT);
       SetClusters(nI,pQS.Items[i],SetInNode(nI,Nil,m_sName));
       nI.Destroy;
      End;
     End;
End;
{
Не сохранять
Мгновенный
3 мин
15 мин
30 мин
1 час
3 часа
6 часов
Сутки
Месяц
Год
События
Время
}
procedure   CL3QweryTreeLoader.SetClusters(nTI:CTI;var pQS:SQWERYMDLCOMM;rtChild:TTreeNode);
Var
     nI   : CTI;
     byState : Byte;
Begin
     //if pQS.QweryMDLS.Count=0 then
     with nTI.m_nCTI do
     Begin
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,1,pQS.m_swTMID,$ffff,0,CheckState(1,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[1]));
      nI.Destroy;
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,2,pQS.m_swTMID,$ffff,0,CheckState(2,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[2]));
      nI.Destroy;
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,4,pQS.m_swTMID,$ffff,0,CheckState(4,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[4]));
      nI.Destroy;
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,8,pQS.m_swTMID,$ffff,0,CheckState(8,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[8]));
      nI.Destroy;
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,9,pQS.m_swTMID,$ffff,0,CheckState(9,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[9]));
      nI.Destroy;
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,11,pQS.m_swTMID,$ffff,0,CheckState(11,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[11]));
      nI.Destroy;
      nI := CTI.Create(5,SD_CLUST,PD_CLUST,PRID,PAID,pQS.m_swGID,PVID,PMID,PPID,12,pQS.m_swTMID,$ffff,0,CheckState(12,pQS.QweryMDLS));
       SetParams(nI,pQS,SetInNode(nI,rtChild,m_nSvPeriodList.Strings[12]));
      nI.Destroy;
     End;
End;
function CL3QweryTreeLoader.CheckState(byCheck:Byte;pQS:SQWERYMDLS):Byte;
Var
     i : Integer;
Begin
     Result := SA_LOCK;
     for i:=0 to pQS.Count-1 do
     Begin
      if byCheck=pQS.Items[i].m_snSRVID then
      Begin
       if pQS.Items[i].m_sbyEnable=1 then Result:=SA_UNLK else
       if pQS.Items[i].m_sbyEnable=0 then Result:=SA_REDY;
       exit;
      End;
     End;
End;
procedure CL3QweryTreeLoader.SetParams(nTI:CTI;var pTbl:SQWERYMDLCOMM;rtChild:TTreeNode);
Var
     i       : Integer;
     strName : String;
     nI      : CTI;
Begin
     for i:=0 to pTbl.Commands.m_swAmCommand-1 do
     Begin
      with nTI.m_nCTI,pTbl.Commands.m_sCommand[i] do
      Begin
       if m_sbyDirect=PCID then
       Begin
        nI       := CTI.Create(0,SD_VPARM,PD_CLUST,PRID,PAID,PGID,PVID,PMID,PPID,PCID,pTbl.m_swTMID,m_swCmdID,0);
        strName  := m_nCommandList.Strings[m_swCmdID];
        SetInNode(nI,rtChild,strName);
        nI.Destroy;
       end;
      End;
     End;
End;
procedure TTQweryModule.InitFrame(nCTI:PCTreeIndex);
Var
     nCode,nCode1 : Integer;
     str:String;strPattern,strNew:String;
begin
     m_sFilter := '1,4,8,9,11,12';
     Move(nCTI^,m_nCTI,sizeof(CTreeIndex));
     m_nCF.m_nSetColor.PQweryMdlstyler := @QweryMdlstyler;
     if m_nTree=Nil then m_nTree := CL3QweryTreeLoader.Create(@FTreeQweryData);
     if m_pDB.GetQweryStruct(IntToStr(m_nCTI.PVID),m_sFilter, QweryStruct)=True then
     Begin
      if (QweryStruct.Items[0].m_swTMID=MET_SUMM)or(QweryStruct.Items[0].m_swTMID=MET_GSUMM) then
      Begin
       m_nCTI.PTID := QweryStruct.Items[0].m_swTMID;
       m_nJOIN := CJoinTable.Create(m_nCTI.PAID,m_nCTI.PGID);
       m_pDB.GetQweryStruct(m_nJOIN.GetString,m_sFilter, QweryStruct);
      End;
      m_nTree.LoadTree(False,m_nCTI,QweryStruct);
     End;
     if m_nTree.FTree.Items.Count<>0 then m_nTree.FTree.Items[1].Selected := True;
     dttm_sdtBegin.SelectedDate := Now;
     dttm_sdtEnd.SelectedDate   := Now;
     {
     str        := '123,333,555,777';
     strPattern := '333';
     strNew     := 'aaa';
     InsertStr(str,strPattern,strNew);
     strNew := strNew + str;

     str        := '111,222,333,444';
     strPattern := '111';
     strNew     := 'aaa';
     InsertStr(str,strPattern,strNew);
     strNew := strNew + str;

     str        := '111,222,333,444';
     strPattern := '444';
     strNew     := 'aaa';
     InsertStr(str,strPattern,strNew);
     strNew := strNew + str;
     }
     //OnResizePannel(advTreePanell);
end;
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
     {
     if (edm_snSRVID.Text<>'') then
     Begin
      nCMD := m_nCommandList.IndexOf(edm_snSRVID.Text);
      sID  := FindStructID;
      if sID<>-1 then
      Begin
       for i:=0 to QweryStruct.Items[sID].Commands.m_swAmCommand-1 do
       Begin
        if m_pRPDS.trTRI.PCID=QweryStruct.Items[sID].Commands.m_sCommand[i].m_sbyDirect then
        Begin
         strCluster := strCluster + IntToStr(QweryStruct.Items[sID].Commands.m_sCommand[i].m_swCmdID)+',';
        End;
       End;
      End;
     End;
     }
     Result := strCluster;
End;
function TTQweryModule.GetQweryPTBL(var pTbl:SQWERYMDL):Boolean;
Var
     sID,i : Integer;
Begin
     sID  := FindStructID;
     Result := False;
     if sID<>-1 then
     Begin
      with QweryStruct.Items[sID].QweryMDLS,m_pRPDS.trTRI do
      if QweryStruct.Items[sID].QweryMDLS.Count<>0 then
      Begin
       for i:=0 to Count-1 do
       if (PVID=Items[i].m_snVMID)and(PCID=Items[i].m_snSRVID) then
       Begin
        Move(Items[i],pTbl,sizeof(SQWERYMDL));
        Result := True;
        exit;
       End;
      End;
     End;
End;
function TTQweryModule.FindStructID:Integer;
Var
     i : Integer;
Begin
     Result := -1;
     for i:=0 to QweryStruct.Count-1 do
     Begin
      if QweryStruct.Items[i].m_swVMID=m_pRPDS.trTRI.PVID then
      Begin
       Result := i;
       exit;
      End;
     End;
End;
function TTQweryModule.FindMnlID(sID:Integer):Integer;
Var
     i : Integer;
Begin
     Result := -1;
     with QweryStruct.Items[sID].QweryMDLS do
     for i:=0 to Count-1 do
     if Items[i].m_snSRVID=m_pRPDS.trTRI.PCID then
     Begin
      Result := i;
      exit;
     End;
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
procedure TTQweryModule.SetDefaultCluster;
Var
     str: String;
     i,sID : Integer;
Begin
     i := 0;
     str := '';
     sID := FindStructID;  if sID=-1 then exit;
     for i:=0 to QweryStruct.Items[sID].Commands.m_swAmCommand-1 do
     Begin
      if QweryStruct.Items[sID].Commands.m_sCommand[i].m_sbyDirect=m_pRPDS.trTRI.PCID then
      str := str + IntToStr(QweryStruct.Items[sID].Commands.m_sCommand[i].m_swCmdID or $8000)+',';
     End;
     LoadCluster(str);
End;
procedure TTQweryModule.LoadEdits;
var
     i,ItemInd : integer;
begin
   //ItemInd           := edCommandList.ItemIndex;
   {
   edVMID.Text       := IntToStr(QweryStruct.m_swVMID);
   edMID.Text        := IntToStr(QweryStruct.m_swMID);
   edPID.Text        := IntToStr(QweryStruct.m_swPID);
   dtQryBPicker.Time := frac(QweryStruct.QweryMDLS.Items[ItemInd].m_sdtBegin);
   dtQryEPicker.Time := frac(QweryStruct.QweryMDLS.Items[ItemInd].m_sdtEnd);
   dtQryPPicker.Time := frac(QweryStruct.QweryMDLS.Items[ItemInd].m_sdtPeriod);
   //edCMDName.Text    := edCommandList.Items.Strings[ItemInd];
   LoadDayChBox(ItemInd);
   LoadMonthChBox(ItemInd);
   }

end;
procedure TTQweryModule.FormCreate(Sender: TObject);
begin
    FormResize(Sender);
     //m_pDB.GetParamsTypeTable(ParmsList);
     //OnResizePannel(advTreePanell);
end;
procedure TTQweryModule.mnuFilterClick(Sender: TObject);
begin
     {
     if (Sender as TMenuItem).tag=0 then m_sFilter := '1,4,8,9' else
     m_sFilter := IntToStr((Sender as TMenuItem).tag);
     m_pDB.GetQweryStruct(IntToStr(m_nCTI.PVID),m_sFilter, QweryStruct);
     m_nTree.LoadTree(m_nCTI,QweryStruct);
     if m_nTree.FTree.Items.Count<>0 then m_nTree.FTree.Items[1].Selected := True;
     (Sender as TMenuItem).Checked := True;
     }
end;
procedure TTQweryModule.LoadEdit(nCTI:CTreeIndex);
Var
     pTbl:SQWERYMDL;
Begin
     if GetQweryPTBL(pTbl)=True then
     Begin
      stSrvState.Font.Color := clLime;
      stSrvState.Caption    := 'Сервер создан.';
      edm_snAID.Text        := IntToStr(pTbl.m_snAID);
      edm_snGID.Text        := IntToStr(pTbl.m_snGID);
      edm_snVMID.Text       := IntToStr(pTbl.m_snVMID);
      edm_snMID.Text        := IntToStr(pTbl.m_snMID);
      edm_snPID.Text        := IntToStr(pTbl.m_snPID);
      dtm_sdtBegin.Time     := frac(pTbl.m_sdtBegin);
      dtm_sdtEnd.Time       := frac(pTbl.m_sdtEnd);
      dtm_sdtPeriod.Time    := frac(pTbl.m_sdtPeriod);
      edm_snSRVID.Text      := m_nSvPeriodList.Strings[pTbl.m_snSRVID];

      LoadCluster(pTbl.m_strCMDCluster);

      edm_sGroupExpress.Text:= GetExpression(m_nCTI);
      LoadDayChBox(pTbl.m_swDayMask);
      LoadMonthChBox(pTbl.m_sdwMonthMask);
      chm_sbyEnable.Checked    := Boolean(pTbl.m_sbyEnable);
      chm_sbyFindData.Checked  := Boolean(pTbl.m_sbyFindData);
      cbm_snDeepFind.ItemIndex := pTbl.m_snDeepFind;
      CheckFind(True);
     End else SetDefaultQwery(nCTI);
     OnClickWDay(self);
     chm_sdwMonthMaskClick(self);
     stMeterType.Caption := m_nMeterList.Strings[nCTI.PTID];
End;
procedure TTQweryModule.SendQSComm(nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     m_sQC.m_snCmdID := nCommand;
     Move(m_sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure TTQweryModule.SendQSData(nCommand,nCLSID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     m_sQC.m_snCmdID  := nCommand;
     m_sQC.m_sdtBegin := sdtBegin;
     m_sQC.m_sdtEnd   := sdtEnd;
     m_sQC.m_snCLSID  := nCLSID;
     m_sQC.m_snPrmID  := nCMDID;
     Move(m_sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure TTQweryModule.SendDynData(nRID,nAID,nGID,nVID,nCLID,nPrmID:Integer;sdtBegin,sdtEnd:TDateTime;nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     m_sQC.m_snCmdID  := nCommand;
     m_sQC.m_snRID    := nRID;
     m_sQC.m_snABOID  := nAID;
     m_sQC.m_snGID    := nGID;
     m_sQC.m_snVMID   := nVID;
     m_sQC.m_snCLSID  := nCLID;
     m_sQC.m_snPrmID  := nPrmID;
     m_sQC.m_sdtBegin := sdtBegin;
     m_sQC.m_sdtEnd   := sdtEnd;
     Move(m_sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;
procedure TTQweryModule.SendDynComm(nRID,nAID,nGID,nVID,nCLID,nPrmID,nCommand:Integer);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     m_sQC.m_snCmdID := nCommand;
     m_sQC.m_snRID   := nRID;
     m_sQC.m_snABOID := nAID;
     m_sQC.m_snGID   := nGID;
     m_sQC.m_snVMID  := nVID;
     m_sQC.m_snCLSID := nCLID;
     m_sQC.m_snPrmID := nPrmID;
     Move(m_sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
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
procedure TTQweryModule.SetDefaultQwery(nCTI:CTreeIndex);
Begin
     stSrvState.Font.Color := clRed;
     stSrvState.Caption    := 'Сервер не создан!';
     edm_snAID.Text        := IntToStr(nCTI.PAID);
     edm_snGID.Text        := IntToStr(nCTI.PGID);
     edm_snVMID.Text       := IntToStr(nCTI.PVID);
     edm_snMID.Text        := IntToStr(nCTI.PMID);
     edm_snPID.Text        := IntToStr(nCTI.PPID);
     dtm_sdtBegin.Time     := StrToTime('00:00:01');
     dtm_sdtEnd.Time       := StrToTime('23:59:59');
     dtm_sdtPeriod.Time    := StrToTime('00:30:00');
     edm_snSRVID.Text      := m_nSvPeriodList.Strings[nCTI.PCID];
     SetDefaultCluster;
     edm_sGroupExpress.Text:= GetExpression(m_nCTI);
     LoadDayChBox(0);
     LoadMonthChBox(0);
     chm_sbyFindData.Checked  := True;
     cbm_snDeepFind.ItemIndex := 0;
     CheckFind(False);
     chm_sbyEnable.Checked    := True;
End;
procedure TTQweryModule.CheckFind(blMenu:Boolean);
Begin
     if (m_pRPDS.trTRI.PCID=4)or(m_pRPDS.trTRI.PCID=8)or(m_pRPDS.trTRI.PCID=9) then
     Begin
      chm_sbyFindData.Enabled:= True;
      cbm_snDeepFind.Enabled := chm_sbyFindData.Checked;
      if blMenu=True then miFindData.Enabled := True;
      dttm_sdtBegin.Enabled  := True;
      dttm_sdtEnd.Enabled    := True;
      miUpdateCluster.Enabled:= True;
      miQweryClusterGR.Enabled:= True;
      if m_pRPDS.trTRI.PSID<>$ffff then
      Begin
       miUpdateParam.Enabled  := True;
       miQweryParamGR.Enabled := True;
      End
     End else
     Begin
      chm_sbyFindData.Checked:= False;
      chm_sbyFindData.Enabled:= False;
      cbm_snDeepFind.Enabled := chm_sbyFindData.Checked;
      if blMenu=True then miFindData.Enabled := False;
      dttm_sdtBegin.Enabled  := False;
      dttm_sdtEnd.Enabled    := False;
      miUpdateCluster.Enabled:= False;
      miQweryClusterGR.Enabled:= False;
      miUpdateParam.Enabled  := False;
      miQweryParamGR.Enabled := False;
     End;
End;
procedure TTQweryModule.GetEdits(var pTbl:SQWERYMDL);
Begin
     with pTbl do
     Begin
      m_snAID        := StrToInt(edm_snAID.Text);
      m_snGID        := StrToInt(edm_snGID.Text);
      m_snVMID       := StrToInt(edm_snVMID.Text);
      m_snMID        := StrToInt(edm_snMID.Text);
      m_snPID        := StrToInt(edm_snPID.Text);
      m_snSRVID      := m_nSvPeriodList.IndexOf(edm_snSRVID.Text);
      m_sdtBegin     := dtm_sdtBegin.Time;
      m_sdtEnd       := dtm_sdtEnd.Time;
      m_sdtPeriod    := dtm_sdtPeriod.Time;
      m_swDayMask    := GetWDayMask;
      m_sdwMonthMask := GetMDayMask;
      m_strCMDCluster:= GetCluster;
      m_sbyEnable    := Byte(chm_sbyEnable.Checked);
      m_sbyFindData  := Byte(chm_sbyFindData.Checked);
      m_snDeepFind   := cbm_snDeepFind.ItemIndex;
     End;
End;
function TTQweryModule.GetExpression(nCTI:CTreeIndex):String;
Begin
     if (nCTI.PTID=MET_SUMM)or(nCTI.PTID=MET_GSUMM) then
     Result := m_pDB.GetGroupExpress(nCTI.PGID) else
     Result := '';
     //if (nCTI.PTID=MET_SUMM)or(nCTI.PTID=MET_GSUMM) then
     //Result := m_pDB.GetGroupExpress(nCTI.PGID) else
     //Result := m_pDB.GetVMIDExpress(nCTI.PVID,nCTI.PCID);
End;
procedure TTQweryModule.OnClickTree(Sender: TObject);
var
     nNode : TTreeNode;
     pIND  : PCTI;
     m_pDS : CGDataSource;
Begin
     nNode := (Sender as TTreeView).Selected;
     if (nNode<>Nil) then
     Begin
      //m_strL3SelNode := nNode.Text;
      if nNode.Data<>Nil then
      Begin
       pIND := nNode.Data;
       Move(pIND.m_nCTI,m_pDS.trTRI,sizeof(CTreeIndex));
       Move(m_pDS ,m_pRPDS,sizeof(CGDataSource));
       m_sQC.m_snRID   := m_pRPDS.trTRI.PRID;
       m_sQC.m_snABOID := m_pRPDS.trTRI.PAID;
       m_sQC.m_snGID   := m_pRPDS.trTRI.PGID;
       m_sQC.m_snVMID  := m_pRPDS.trTRI.PVID;
       m_sQC.m_snCLSID := m_pRPDS.trTRI.PCID;
       m_sQC.m_snPrmID := m_pRPDS.trTRI.PSID;

       with pIND.m_nCTI do Begin
       case PNID of
            PD_CLUST:
            Begin
             (Sender as TTreeView).PopupMenu := mnuCluster;
             MenuPrepareCL(PTSD);
             if (PTSD=SD_CLUST)then LoadCommanList(PMID);
             if (PTSD=SD_CLUST)or(PTSD=SD_VPARM) then LoadEdit(m_pDS.trTRI);
            End;
            PD_QWERY:
            Begin
             (Sender as TTreeView).PopupMenu := mnuVMeter;
             MenuPrepareVM;
            End;
       End;
       End;
      End;
     End;
end;
procedure TTQweryModule.MenuPrepareCL(nLevel:Integer);
Begin
     if m_pRPDS.trTRI.PSTT=SA_LOCK then
     Begin
       miQweryCluster.Enabled     := False;
       miUpdateCluster.Enabled    := False;
       miUpdateParam.Enabled      := False;
       miQweryClusterGR.Enabled   := False;
       miQweryParamGR.Enabled     := False;
       miStopQweryCluster.Enabled := False;
       
       miStartCluster.Enabled     := False;
       miStopCluster.Enabled      := False;
       miFindData.Enabled         := False;
       miCreateCluster.Enabled    := True;
       miCreateAllCluster.Enabled := True;
       miDeleteCluster.Enabled    := False;
       miDeleteAllCluster.Enabled := False;
       miSaveSetClust.Enabled     := False;
       miExecSetClust.Enabled     := False;
       miExecSetAllClust.Enabled  := False;
       miCloneSetClust.Enabled    := False;
     End else
     if m_pRPDS.trTRI.PSTT<>SA_LOCK then
     Begin
       miQweryCluster.Enabled     := True;
       miUpdateCluster.Enabled    := True;
       miStopQweryCluster.Enabled := True;
       miStartCluster.Enabled     := True;
       miStopCluster.Enabled      := True;
       miFindData.Enabled         := True;
       miCreateCluster.Enabled    := False;
       miCreateAllCluster.Enabled := False;
       miDeleteCluster.Enabled    := True;
       miDeleteAllCluster.Enabled := True;
       miSaveSetClust.Enabled     := True;
       miExecSetClust.Enabled     := True;
       miExecSetAllClust.Enabled  := True;
       miCloneSetClust.Enabled    := True;
       miUpdateParam.Enabled      := False;
       miQweryParamGR.Enabled     := False;
       if (nLevel=SD_VPARM) then
       Begin
        miUpdateParam.Enabled     := True;
        miQweryParamGR.Enabled    := True;
       End;
     End;
End;
procedure TTQweryModule.MenuPrepareVM;
Begin
     if m_pRPDS.trTRI.PSTT=SA_LOCK then
     Begin
       miQweryCounter.Enabled   := False;
       miStopQwery.Enabled      := False;
       miStartClusters.Enabled  := False;
       miStopClusters.Enabled   := False;
       miCreateClusters.Enabled := True;
       miDeleteClusters.Enabled := False;
     End else
     if m_pRPDS.trTRI.PSTT<>SA_LOCK then
     Begin
       miQweryCounter.Enabled   := True;
       miStopQwery.Enabled      := True;
       miStartClusters.Enabled  := True;
       miStopClusters.Enabled   := True;
       miCreateClusters.Enabled := False;
       miDeleteClusters.Enabled := True;
     End;
End;
{
    m_sNI.m_sbyLOCK := 5;
    m_sNI.m_sbyUNLK := 7;
    m_sNI.m_sbyALOK := 8;
    m_sNI.m_sbyCVRY := 6;
    m_sNI.m_sbyALRM := 8;
    m_sNI.m_sbyREDY := 9;
}
procedure TTQweryModule.OnSaveServer(Sender: TObject);
begin
     SaveCurrEdit(SA_REDY);
end;
procedure TTQweryModule.OnLoadQwery(Sender: TObject);
begin
     LoadEdit(m_pRPDS.trTRI);
end;
procedure TTQweryModule.SaveCurrEdit(byState:Integer);
Var
     pTbl    : SQWERYMDL;
     sID,nID : Integer;
begin
     GetEdits(pTbl);
     m_pDB.AddQweryMDLTable(pTbl);
     //sID := FindStructID;  if sID=-1 then exit;
     //nID := FindMnlID(sID);if nID=-1 then exit;
     //Move(pTbl,QweryStruct.Items[sID].QweryMDLS.Items[nID],sizeof(SQWERYMDL));
     //m_pDB.GetQweryStruct(m_nJOIN.GetString,m_sFilter, QweryStruct);
     sID := FindStructID;
     if sID<>-1 then m_pDB.GetQweryMaskMDLTable(m_pRPDS.trTRI.PVID,m_sFilter,QweryStruct.Items[sID].QweryMDLS);
     LoadEdit(m_pRPDS.trTRI);
     if byState<>-1 then
     Begin
      m_pRPDS.trTRI.PSTT := byState;
      m_nTree.SetClusterState(m_pRPDS);
     End;
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
procedure TTQweryModule.OnCreateAllSRV(Sender: TObject);
Begin
//
end;

procedure TTQweryModule.OnDeleteAllSRV(Sender: TObject);
begin
     m_pDB.DelQweryMDLCMDIDTable(m_pRPDS.trTRI.PVID,-1);
     m_pDB.GetQweryStruct(m_nJOIN.GetString,m_sFilter, QweryStruct);
     LoadEdit(m_pRPDS.trTRI);
     m_nTree.LoadTree(False,m_pRPDS.trTRI,QweryStruct);
     if m_nTree.FTree.Items.Count<>0 then m_nTree.FTree.Items[1].Selected := True;
end;


procedure TTQweryModule.OnSaveButt(Sender: TObject);
begin
      SaveCurrEdit(SA_REDY);
      if chm_sbyEnable.Checked=True  then m_pRPDS.trTRI.PSTT := SA_UNLK else
      if chm_sbyEnable.Checked=False then m_pRPDS.trTRI.PSTT := SA_REDY;
      m_nTree.SetClusterState(m_pRPDS);
end;

procedure TTQweryModule.OnResizePannel(Sender: TObject);
Var
     nSize:Integer;
begin
     nSize := trunc(advTreePanell.Width/2)-7;
     advTreeTool.Width := advTreePanell.Width;
     advButTree.Width := nSize;
     advButOper.Width := nSize;
end;
{
//Команды управления сервером опроса
  QS_HQWR_AA  = 0;
  QS_HQWR_AB  = 1;
  QS_HQWR_GR  = 2;
  QS_HQWR_VM  = 3;
  QS_STOP_QW  = 4;
  QS_ADD_VMCL = 5;
  QS_INIT_AA  = 6;
  QS_INIT_AB  = 7;
  QS_INIT_GR  = 8;
  QS_INIT_VM  = 9;
  QS_DEL_AA   = 10;
  QS_DEL_AB   = 11;
  QS_DEL_GR   = 12;
  QS_DEL_VM   = 13;
  QS_FIND_AA  = 14;
  QS_FIND_AB  = 15;
  QS_FIND_GR  = 16;
  QS_FIND_VM  = 17;
}
procedure TTQweryModule.miQweryClusterClick(Sender: TObject);
begin
    if MessageDlg('Опросить кластер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    with m_sQC do SendDynComm(m_snRID,m_snABOID,m_snGID,m_snVMID,m_snCLSID,-1,QS_HQWR_VM);
end;
procedure TTQweryModule.miStopQweryClusterClick(Sender: TObject);
begin
    if MessageDlg('Остановить опрос кластера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    with m_sQC do SendDynComm(m_snRID,m_snABOID,m_snGID,m_snVMID,m_snCLSID,-1,QS_STOP_VM);
end;
procedure TTQweryModule.miStartClusterClick(Sender: TObject);
begin
    if MessageDlg('Запустить кластер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     chm_sbyEnable.Checked := True;
     SaveCurrEdit(SA_UNLK);
     SendQSComm(QS_INIT_VM);
    End;
end;
procedure TTQweryModule.OnStopQwery(Sender: TObject);
begin
    if MessageDlg('Остановить кластер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     chm_sbyEnable.Checked := False;
     SaveCurrEdit(SA_REDY);
     SendQSComm(QS_INIT_VM);
    End;
end;

procedure TTQweryModule.miFindDataClick(Sender: TObject);
begin
    if MessageDlg('Выполнить поиск ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendQSComm(QS_FIND_VM);
end;

procedure TTQweryModule.OnClickFind(Sender: TObject);
begin
    //if chm_sbyFindData.Checked=True  then cbm_snDeepFind.Enabled := True else
    //if chm_sbyFindData.Checked=False then cbm_snDeepFind.Enabled := False;
    //btm_sbyFindData.Enabled := chm_sbyFindData.Checked;
    cbm_snDeepFind.Enabled := chm_sbyFindData.Checked;
end;

procedure TTQweryModule.OnCreateSRV(Sender: TObject);
Var
     pTbl : SQWERYMDL;
     sID  : Integer;
begin
     if MessageDlg('Создать кластер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      m_pDB.AddQweryMDLTable(pTbl);
      sID := FindStructID;
      if sID<>-1 then m_pDB.GetQweryMaskMDLTable(m_pRPDS.trTRI.PVID,m_sFilter,QweryStruct.Items[sID].QweryMDLS);
      if chm_sbyEnable.Checked=True  then m_pRPDS.trTRI.PSTT := SA_UNLK else
      if chm_sbyEnable.Checked=False then m_pRPDS.trTRI.PSTT := SA_REDY;
      m_nTree.SetClusterState(m_pRPDS);
     End;
end;
procedure TTQweryModule.OnDeleteSRV(Sender: TObject);
Var
     sID : Integer;
begin
     if MessageDlg('Удалить кластер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.DelQweryMDLCMDIDTable(m_pRPDS.trTRI.PVID,m_pRPDS.trTRI.PCID);
      SendQSComm(QS_DEL_VM);
      sID := FindStructID;
      if sID<>-1 then m_pDB.GetQweryMaskMDLTable(m_pRPDS.trTRI.PVID,m_sFilter,QweryStruct.Items[sID].QweryMDLS);
      m_pRPDS.trTRI.PSTT := SA_LOCK;
      m_nTree.SetClusterState(m_pRPDS);
     End;
end;

procedure TTQweryModule.miSaveSetClustClick(Sender: TObject);
begin
     if MessageDlg('Сохранить настройки кластера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SaveCurrEdit(SA_REDY);
      if chm_sbyEnable.Checked=True  then m_pRPDS.trTRI.PSTT := SA_UNLK else
      if chm_sbyEnable.Checked=False then m_pRPDS.trTRI.PSTT := SA_REDY;
      m_nTree.SetClusterState(m_pRPDS);
     End;
end;

procedure TTQweryModule.miExecSetClustClick(Sender: TObject);
begin
     if MessageDlg('Применить настройки к кластеру?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     SendQSComm(QS_INIT_VM);
end;
procedure TTQweryModule.PrepareCommand(sID,nID:Integer);
Begin
     with QweryStruct.Items[sID].QweryMDLS do m_pDB.AddQweryMDLTable(Items[nID]);
End;
procedure TTQweryModule.miCreateAllClusterClick(Sender: TObject);
Var
     pTbl : SQWERYMDL;
     i : Integer;
Begin
     if MessageDlg('Создать кластеры в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      for i:=0 to QweryStruct.Count-1 do
      Begin
       with QweryStruct.Items[i] do
       Begin
        pTbl.m_snVMID := m_swVMID;
        pTbl.m_snMID  := m_swMID;
        pTbl.m_snPID  := m_swPID;
        m_pDB.AddQweryMDLTable(pTbl);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
      InitFrame(@m_nCTI);
     End;
end;
procedure TTQweryModule.btm_sdtBeginClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Начало периода опроса" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_sdtBegin := dtm_sdtBegin.DateTime;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;
procedure TTQweryModule.btm_sdtEndClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Окончание периода опроса" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_sdtEnd := dtm_sdtEnd.DateTime;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;

procedure TTQweryModule.btm_sdtPeriodClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Периода опроса" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_sdtPeriod := dtm_sdtPeriod.DateTime;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;

procedure TTQweryModule.btm_swDayMaskClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID,dwMask : Integer;
begin
     if MessageDlg('Установить параметр "Учитывать дни недели" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      dwMask := GetWDayMask;
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_swDayMask := dwMask;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;

procedure TTQweryModule.btm_sdwMonthMaskClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID,dwMask : Integer;
begin
     if MessageDlg('Установить параметр "Учитывать дни месяца" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      dwMask := GetMDayMask;
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_sdwMonthMask := dwMask;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;

procedure TTQweryModule.btm_sbyFindDataClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Выполнять поиск с глубиной" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_sbyFindData := Byte(chm_sbyFindData.Checked);
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_snDeepFind  := cbm_snDeepFind.ItemIndex;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;

procedure TTQweryModule.btm_sbyEnableClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
begin
     if MessageDlg('Установить параметр "Разрешить опрос" в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_sbyEnable := Byte(chm_sbyEnable.Checked);
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
      InitFrame(@m_nCTI);
     End;
end;

procedure TTQweryModule.btm_sExecForGroupClick(Sender: TObject);
Var
     pTbl : SQWERYMDL;
     i : Integer;
Begin
     if MessageDlg('Распространить настройки кластера в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      GetEdits(pTbl);
      for i:=0 to QweryStruct.Count-1 do
      Begin
       with QweryStruct.Items[i] do
       Begin
        pTbl.m_snVMID := m_swVMID;
        pTbl.m_snMID  := m_swMID;
        pTbl.m_snPID  := m_swPID;
        m_pDB.SetMDLTable(pTbl);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
      InitFrame(@m_nCTI);
     End;
end;

procedure TTQweryModule.miDeleteAllClusterClick(Sender: TObject);
Var
     i : Integer;
Begin
     if MessageDlg('Удалить кластеры в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      for i:=0 to QweryStruct.Count-1 do
      with QweryStruct.Items[i] do m_pDB.DelQweryMDLCMDIDTable(m_swVMID,m_pRPDS.trTRI.PCID);
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_DEL_GR);
      InitFrame(@m_nCTI);
     End;
end;

procedure TTQweryModule.miExecSetAllClustClick(Sender: TObject);
Begin
     btm_sExecForGroupClick(sender);
end;

procedure TTQweryModule.miCloneSetClustClick(Sender: TObject);
begin
     miCreateAllClusterClick(Sender);
end;

{
     m_snRID   : Integer;
     m_snABOID : Integer;
     m_snGID   : Integer;
     m_snVMID  : Integer;
     m_snCLSID : Integer;
     m_snCmdID : Integer;
     m_sdtBegin: TDatetime;
     m_sdtEnd  : TDatetime;
     m_snPrmID : Integer;
     m_snResult: Integer;
}
procedure TTQweryModule.miQweryCounterClick(Sender: TObject);
begin
     if MessageDlg('Опросить счетчик?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     with m_sQC do SendDynComm(m_snRID,m_snABOID,m_snGID,m_snVMID,-1,-1,QS_HQWR_VM);
end;

procedure TTQweryModule.miStopQweryClick(Sender: TObject);
begin
     if MessageDlg('Остановить опрос счетчика?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     with m_sQC do SendDynComm(m_snRID,m_snABOID,m_snGID,m_snVMID,-1,-1,QS_STOP_VM);
end;

procedure TTQweryModule.miStartClustersClick(Sender: TObject);
Var
     sID,i : Integer;
     pRPDS : CGDataSource;
begin
      if MessageDlg('Запустить все кластеры счетчика?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       sID := FindStructID; if sID=-1 then exit;
       Move(m_pRPDS,pRPDS,sizeof(CGDataSource));
       with QweryStruct.Items[sID].QweryMDLS do
       for i:=0 to Count-1 do
       Begin
        Items[i].m_sbyEnable:=1;
        m_pDB.SetMDLTable(Items[i]);
        pRPDS.trTRI.PCID := Items[i].m_snSRVID;
        pRPDS.trTRI.PSTT := SA_UNLK;
        m_nTree.SetClusterState(pRPDS);
       End;
       m_sQC.m_snCLSID := -1;
       SendQSComm(QS_INIT_VM);
      End;
end;

procedure TTQweryModule.miStopClustersClick(Sender: TObject);
Var
      sID,i : Integer;
      pRPDS : CGDataSource;
begin
      if MessageDlg('Остановить все кластеры счетчика?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       sID := FindStructID; if sID=-1 then exit;
       Move(m_pRPDS,pRPDS,sizeof(CGDataSource));
       with QweryStruct.Items[sID].QweryMDLS do
       for i:=0 to Count-1 do
       Begin
        Items[i].m_sbyEnable:=0;
        m_pDB.SetMDLTable(Items[i]);
        pRPDS.trTRI.PCID := Items[i].m_snSRVID;
        pRPDS.trTRI.PSTT := SA_REDY;
        m_nTree.SetClusterState(pRPDS);
       End;
       m_sQC.m_snCLSID := -1;
       SendQSComm(QS_INIT_VM);
      End;
end;
procedure TTQweryModule.miDeleteClustersClick(Sender: TObject);
Var
      sID,i : Integer;
      pRPDS : CGDataSource;
begin
      if MessageDlg('Удалить все кластеры счетчика?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       sID := FindStructID; if sID=-1 then exit;
       Move(m_pRPDS,pRPDS,sizeof(CGDataSource));
       m_pDB.DelQweryMDLCMDIDTable(m_pRPDS.trTRI.PVID,-1);
       with QweryStruct.Items[sID].QweryMDLS do
       for i:=0 to Count-1 do
       Begin
        pRPDS.trTRI.PCID := Items[i].m_snSRVID;
        pRPDS.trTRI.PSTT := SA_LOCK;
        m_nTree.SetClusterState(pRPDS);
       End;
       if sID<>-1 then m_pDB.GetQweryMaskMDLTable(m_pRPDS.trTRI.PVID,m_sFilter,QweryStruct.Items[sID].QweryMDLS);
       m_sQC.m_snCLSID := -1;
       SendQSComm(QS_DEL_VM);
      End;
end;

procedure TTQweryModule.miUpdateClusterClick(Sender: TObject);
begin
     if MessageDlg('Обновить данные кластера "'+edm_snSRVID.Text+'" с '+DateToStr(dttm_sdtEnd.SelectedDate)+
     ' по '+DateToStr(dttm_sdtBegin.SelectedDate)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSData(QS_FIND_VM,m_sQC.m_snCLSID,-1,dttm_sdtBegin.SelectedDate,dttm_sdtEnd.SelectedDate);
     End;
end;

procedure TTQweryModule.dttm_sdtBeginChange(Sender: TObject);
begin
     dttm_sdtEnd.SelectedDate := dttm_sdtBegin.SelectedDate;
end;

procedure TTQweryModule.miQweryGroupClick(Sender: TObject);
begin
     if MessageDlg('Опросить группу счетчиков?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,-1,-1,QS_HQWR_GR);
end;

procedure TTQweryModule.miUpdateParamClick(Sender: TObject);
begin
     if MessageDlg('Обновить данные параметра "'+m_nCommandList.Strings[m_sQC.m_snPrmID]+'" с '+DateToStr(dttm_sdtEnd.SelectedDate)+
     ' по '+DateToStr(dttm_sdtBegin.SelectedDate)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      SendQSData(QS_FIND_VM,m_sQC.m_snCLSID,m_sQC.m_snPrmID,dttm_sdtBegin.SelectedDate,dttm_sdtEnd.SelectedDate);
     End;
end;

procedure TTQweryModule.miQweryClusterGRClick(Sender: TObject);
begin
     if MessageDlg('Обновить данные группы кластеров "'+edm_snSRVID.Text+'" с '+DateToStr(dttm_sdtEnd.SelectedDate)+
     ' по '+DateToStr(dttm_sdtBegin.SelectedDate)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      with m_nCTI do SendDynData(PRID,PAID,PGID,PVID,m_sQC.m_snCLSID,-1,dttm_sdtBegin.SelectedDate,dttm_sdtEnd.SelectedDate,QS_FIND_GR);
     End;
end;

procedure TTQweryModule.miQweryParamGRClick(Sender: TObject);
begin
     if MessageDlg('Обновить данные группы параметров "'+m_nCommandList.Strings[m_sQC.m_snPrmID]+'" с '+DateToStr(dttm_sdtEnd.SelectedDate)+
     ' по '+DateToStr(dttm_sdtBegin.SelectedDate)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      with m_nCTI do SendDynData(PRID,PAID,PGID,PVID,m_sQC.m_snCLSID,m_sQC.m_snPrmID,dttm_sdtBegin.SelectedDate,dttm_sdtEnd.SelectedDate,QS_FIND_GR);
      //SendQSData(QS_FIND_GR,m_sQC.m_snCLSID,m_sQC.m_snPrmID,dttm_sdtBegin.DateTime,dttm_sdtEnd.DateTime);
     End;
end;
{
function GetCode(var nCode:Integer;var str:String):Boolean;
Var
     nPos : Integer;
     strF : String;
Begin
     try
     nPos := Pos(',',str);
     if nPos<>0 then
     Begin
      strF := Copy(str,0,nPos-1);
      Delete(str,1,nPos);
      nCode := StrToInt(strF);
      Result := True;
     End else Result := False;
     except
     end;
End;
}
function TTQweryModule.InsertStr(var str:String;strPattern,strNew:String):Boolean;
Var
     nPos : Integer;
     strF : String;
Begin
     try
     nPos := Pos(strPattern,str);
     if nPos<>0 then
     Begin
      strF := Copy(str,nPos,Length(str));
      Delete(str,nPos,Length(str));
      str := str+strNew+','+strF;
      Result := True;
     End else Result := False;
     except
     end;
End;
procedure TTQweryModule.btm_nTopParamClick(Sender: TObject);
Var
     sID,nID : Integer;
     strCls : String;
begin
     sID := FindStructID;  if sID=-1 then exit;
     nID := FindMnlID(sID);if nID=-1 then exit;
     with QweryStruct.Items[sID].QweryMDLS.Items[nID] do
     Begin
      strCls := IntToStr($8000 or m_nCommandList.IndexOf(cbm_nAddCommand.Text));
      strCls := strCls+','+m_strCMDCluster;
      m_strCMDCluster := strCls;
      LoadCluster(m_strCMDCluster);
     End;
end;
procedure TTQweryModule.btm_nBottParamClick(Sender: TObject);
Var
     sID,nID : Integer;
     strCls : String;
begin
     sID := FindStructID;  if sID=-1 then exit;
     nID := FindMnlID(sID);if nID=-1 then exit;
     with QweryStruct.Items[sID].QweryMDLS.Items[nID] do
     Begin
      m_strCMDCluster := m_strCMDCluster + IntToStr($8000 or m_nCommandList.IndexOf(cbm_nAddCommand.Text))+',';
      LoadCluster(m_strCMDCluster);
     End;
end;

procedure TTQweryModule.btm_nSubParamClick(Sender: TObject);
Var
     sID,nID : Integer;
begin
     if cbm_strCMDCluster.Items.Count<>0 then
     Begin
      if cbm_strCMDCluster.ItemIndex<>-1 then
      Begin
       sID := FindStructID;  if sID=-1 then exit;
       nID := FindMnlID(sID);if nID=-1 then exit;
       cbm_strCMDCluster.Items.Delete(cbm_strCMDCluster.ItemIndex);
       //QweryStruct.Items[sID].QweryMDLS.Items[nID].m_strCMDCluster := GetCluster;
      End;
     End;
end;

procedure TTQweryModule.btm_nSvClustGrClick(Sender: TObject);
Var
     pTbl  : SQWERYMDL;
     i,nID : Integer;
     strCluster : String;
begin
     if MessageDlg('Установить содержимое кластера в пределах группы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      strCluster := GetCluster;
      for i:=0 to QweryStruct.Count-1 do
      Begin
       nID := FindMnlID(i);
       if nID<>-1 then
       Begin
        QweryStruct.Items[i].QweryMDLS.Items[nID].m_strCMDCluster := strCluster;
        PrepareCommand(i,nID);
       End;
      End;
      with m_nCTI do SendDynComm(PRID,PAID,PGID,PVID,m_pRPDS.trTRI.PCID,-1,QS_INIT_GR);
     End;
end;

procedure TTQweryModule.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TTQweryModule.FormResize(Sender: TObject);
begin
   dttm_sdtBegin.Left := 1;
   dttm_sdtBegin.Width := AdvPanel3.Width div 2;
   dttm_sdtEnd.Left := dttm_sdtBegin.Width + 1;
   dttm_sdtEnd.Width := dttm_sdtBegin.Width;
   Label18.Left := dttm_sdtBegin.Left;
   Label16.Left := dttm_sdtEnd.Left;
   cbm_strCMDCluster.Left := 0;
   cbm_strCMDCluster.Width := AdvPanel3.Width;
   GradientLabel1.Left := cbm_strCMDCluster.Left;
   GradientLabel1.Width := cbm_strCMDCluster.Width;
   cbm_nAddCommand.Left := cbm_strCMDCluster.Left;
   cbm_nAddCommand.Width := cbm_strCMDCluster.Width;

end;

procedure TTQweryModule.AdvSplitter2Moved(Sender: TObject);
begin
   FormResize(Sender);
end;

end.
