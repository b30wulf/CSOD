unit knsl5config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,//FileCtrl,
  ShlObj, ActiveX, StdCtrls, AdvToolBar, AdvToolBarStylers,
  AdvAppStyler, AdvPanel, AdvOfficePager, AdvOfficePagerStylers, Menus,
  utltypes,utldatabase, utlbox,
  knsl5tracer,utlconst,knsl3qryschedlr,knsl5setcolor,knsl3setenergo, utlTimeDate,
  knsl3transtime,inifiles,
  knsl3UserControl, AdvGlowButton, AdvMenus,
  AdvMenuStylers, ComCtrls, Spin, GradientLabel, ImgList, AdvOfficeButtons,
  Grids, BaseGrid, AdvGrid, RbDrawCore, RbButton, ExtCtrls;
type
  TTL5Config = class(TForm)
    ImageListSet1: TImageList;
    Label2: TLabel;
    ImageListSet2: TImageList;
    ImageListEvent1: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    N2: TMenuItem;
    odm_OpenDialog: TOpenDialog;
    AdvPanel2: TAdvPanel;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    CofigStyler: TAdvFormStyler;
    AdvPanel3: TAdvPanel;
    lbBottInfo: TLabel;
    lbEnter: TLabel;
    dtQryPicker: TDateTimePicker;
    lbPeriod: TLabel;
    cbQryPeriod: TComboBox;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    lbGenSettings: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    pgGenSettings: TAdvOfficePager;
    tbGenSetiings: TAdvOfficePage;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label17: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label1: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label57: TLabel;
    Label59: TLabel;
    cbm_sbyMode: TComboBox;
    cbm_sbyAutoPack: TComboBox;
    cbm_sStorePeriod: TComboBox;
    cbm_sStoreProto: TComboBox;
    cbm_sPoolPeriod: TComboBox;
    cbm_sStoreClrTime: TComboBox;
    cbm_sbyLocation: TComboBox;
    edm_sProjectName: TEdit;
    edm_sPowerLimit: TEdit;
    sem_sPowerLimit: TSpinEdit;
    cbm_sPrePoolGraph: TComboBox;
    cbm_sQryScheduler: TComboBox;
    cbm_sAutoTray: TComboBox;
    sem_sPrecise: TSpinEdit;
    sem_sPreciseExpense: TSpinEdit;
    cbm_sBaseLocation: TComboBox;
    cbm_sCorrDir: TComboBox;
    edm_sKorrDelay: TEdit;
    cbm_sSetForETelecom: TComboBox;
    sem_sExport: TSpinEdit;
    rbm_sButtExport: TRbButton;
    cbm_sInterSet: TComboBox;
    edm_sMdmJoinName: TEdit;
    cbm_sUseModem: TComboBox;
    edm_sInterDelay: TEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    cbm_sChannSyn: TComboBox;
    cbAllowInDConn: TCheckBox;
    cbm_sTransTime: TComboBox;
    cbm_ChooseEnergo: TComboBox;
    cbm_blOnStartCvery: TComboBox;
    sem_swAddres: TEdit;
    edm_swMask: TEdit;
    cbm_DeltaFH: TComboBox;
    AdvPanel4: TAdvPanel;
    AdvToolBar2: TAdvToolBar;
    AdvOfficePage2: TAdvOfficePage;
    AdvPanel37: TAdvPanel;
    AdvToolBar18: TAdvToolBar;
    sgTransTime: TAdvStringGrid;
    TabSheet5: TAdvOfficePage;
    AdvPanel5: TAdvPanel;
    AdvToolBar3: TAdvToolBar;
    TabSheet1: TAdvOfficePage;
    AdvPanel6: TAdvPanel;
    AdvToolBar4: TAdvToolBar;
    FsgGrid: TAdvStringGrid;
    TabSheet2: TAdvOfficePage;
    Label22: TLabel;
    Label23: TLabel;
    Label6: TLabel;
    GradientLabel2: TGradientLabel;
    StyleForm: TComboBox;
    Edit2: TEdit;
    Edit1: TEdit;
    RbButton1: TRbButton;
    RbButton2: TRbButton;
    GroupBox2: TGroupBox;
    Label60: TLabel;
    AdvToolBar5: TAdvToolBar;
    AdvToolBarButton24: TAdvToolBarButton;
    AdvToolBarButton25: TAdvToolBarButton;
    AdvToolBarButton29: TAdvToolBarButton;
    AdvToolBarButton30: TAdvToolBarButton;
    AdvToolBarButton31: TAdvToolBarButton;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    sgQryTable: TAdvStringGrid;
    cbm_nArchEN: TAdvOfficeCheckBox;
    cbm_nPriDayF: TAdvOfficeCheckBox;
    cbm_nPriMonthF: TAdvOfficeCheckBox;
    cbm_nPri30F: TAdvOfficeCheckBox;
    cbm_nNakDayF: TAdvOfficeCheckBox;
    cbm_nNakMonthF: TAdvOfficeCheckBox;
    cbm_byCurrent: TAdvOfficeCheckBox;
    cbm_bySumEn: TAdvOfficeCheckBox;
    cbm_byMAP: TAdvOfficeCheckBox;
    cbm_byMRAP: TAdvOfficeCheckBox;
    cbm_byU: TAdvOfficeCheckBox;
    cbm_byI: TAdvOfficeCheckBox;
    cbm_byFreq: TAdvOfficeCheckBox;
    cbm_nPar6: TAdvOfficeCheckBox;
    cbm_byJEn: TAdvOfficeCheckBox;
    cbm_byJ0: TAdvOfficeCheckBox;
    cbm_byJ1: TAdvOfficeCheckBox;
    cbm_byJ2: TAdvOfficeCheckBox;
    cbm_byJ3: TAdvOfficeCheckBox;
    cbm_byPNetEn: TAdvOfficeCheckBox;
    cbm_byPNetU: TAdvOfficeCheckBox;
    cbm_byPNetI: TAdvOfficeCheckBox;
    cbm_byPNetFi: TAdvOfficeCheckBox;
    cbm_byPNetCosFi: TAdvOfficeCheckBox;
    cbm_byPNetF: TAdvOfficeCheckBox;
    cbm_byPNetP: TAdvOfficeCheckBox;
    cbm_byPNetQ: TAdvOfficeCheckBox;
    cbm_byCorrTM: TAdvOfficeCheckBox;
    FTreeModuleData: TTreeView;
    cbm_nWekEN: TAdvOfficeCheckBox;
    cbm_nPon: TAdvOfficeCheckBox;
    cbm_nWto: TAdvOfficeCheckBox;
    cbm_nSrd: TAdvOfficeCheckBox;
    cbm_nCht: TAdvOfficeCheckBox;
    cbm_nPtn: TAdvOfficeCheckBox;
    cbm_nSub: TAdvOfficeCheckBox;
    cbm_nVos: TAdvOfficeCheckBox;
    cbm_nMonthEN: TAdvOfficeCheckBox;
    cbm_nDay1: TAdvOfficeCheckBox;
    cbm_nDay2: TAdvOfficeCheckBox;
    cbm_nDay3: TAdvOfficeCheckBox;
    cbm_nDay4: TAdvOfficeCheckBox;
    cbm_nDay5: TAdvOfficeCheckBox;
    cbm_nDay6: TAdvOfficeCheckBox;
    cbm_nDay7: TAdvOfficeCheckBox;
    cbm_nDay8: TAdvOfficeCheckBox;
    cbm_nDay9: TAdvOfficeCheckBox;
    cbm_nDay10: TAdvOfficeCheckBox;
    cbm_nDay11: TAdvOfficeCheckBox;
    cbm_nDay12: TAdvOfficeCheckBox;
    cbm_nDay13: TAdvOfficeCheckBox;
    cbm_nDay14: TAdvOfficeCheckBox;
    cbm_nDay15: TAdvOfficeCheckBox;
    cbm_nDay16: TAdvOfficeCheckBox;
    cbm_nDay17: TAdvOfficeCheckBox;
    cbm_nDay18: TAdvOfficeCheckBox;
    cbm_nDay19: TAdvOfficeCheckBox;
    cbm_nDay20: TAdvOfficeCheckBox;
    cbm_nDay21: TAdvOfficeCheckBox;
    cbm_nDay22: TAdvOfficeCheckBox;
    cbm_nDay23: TAdvOfficeCheckBox;
    cbm_nDay24: TAdvOfficeCheckBox;
    cbm_nDay25: TAdvOfficeCheckBox;
    cbm_nDay26: TAdvOfficeCheckBox;
    cbm_nDay27: TAdvOfficeCheckBox;
    cbm_nDay28: TAdvOfficeCheckBox;
    cbm_nDay29: TAdvOfficeCheckBox;
    cbm_nDay30: TAdvOfficeCheckBox;
    cbm_nDay31: TAdvOfficeCheckBox;
    dtPicShed: TDateTimePicker;
    cbm_byRecalc: TAdvOfficeCheckBox;
    Label66: TLabel;
    edm_swGate: TEdit;
    cbOpenSessionTime: TComboBox;
    Label67: TLabel;
    lbSExpired: TLabel;
    pmMainData: TAdvPopupMenu;
    pmMainTime: TAdvPopupMenu;
    ppMainSystem: TAdvPopupMenu;
    few1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N15: TMenuItem;
    AdvGlowMenuButton3: TAdvGlowMenuButton;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    AdvGlowMenuButton2: TAdvGlowMenuButton;
    pmTimeData: TAdvPopupMenu;
    pmTimeEdit: TAdvPopupMenu;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    AdvGlowMenuButton5: TAdvGlowMenuButton;
    AdvGlowMenuButton6: TAdvGlowMenuButton;
    pmQuerGrData: TAdvPopupMenu;
    pmQuerGrEdit: TAdvPopupMenu;
    pmQuerGrContr: TAdvPopupMenu;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    AdvGlowMenuButton7: TAdvGlowMenuButton;
    AdvGlowMenuButton8: TAdvGlowMenuButton;
    AdvGlowMenuButton9: TAdvGlowMenuButton;
    pmEventData: TAdvPopupMenu;
    pmEventEdit: TAdvPopupMenu;
    pmEventTJrnl: TAdvPopupMenu;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N110: TMenuItem;
    N210: TMenuItem;
    N37: TMenuItem;
    N41: TMenuItem;
    AdvGlowMenuButton10: TAdvGlowMenuButton;
    AdvGlowMenuButton11: TAdvGlowMenuButton;
    AdvGlowMenuButton12: TAdvGlowMenuButton;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    N75: TMenuItem;
    N63: TMenuItem;
    Label62: TLabel;
    cbM_NSESSIONTIME: TComboBox;
    Label64: TLabel;
    cbm_sCalendOn: TComboBox;
    procedure OnChandgeSett(Sender: TObject);
    procedure OnCreateForm(Sender: TObject);
    procedure OnSaveGenData(Sender: TObject);
    procedure OnGetGenData(Sender: TObject);
    procedure OnFormResize1(Sender: TObject);
    procedure OnGetEditTypeEvent(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnGetCellColorEvent(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnGetAllEvents(Sender: TObject);
    procedure OnSetEvents(Sender: TObject);
    procedure OnGetEv0(Sender: TObject);
    procedure OnGetEv1(Sender: TObject);
    procedure OnGetEv2(Sender: TObject);
    procedure OnLoadFromF(Sender: TObject);
    procedure OnDelAllEvent(Sender: TObject);
    procedure OnSetSettings(Sender: TObject);
    procedure OnSetRemSettings(Sender: TObject);
    procedure OnSetSdl(Sender: TObject);
    procedure OnGetSdl(Sender: TObject);
    procedure OnGenSdl(Sender: TObject);
    procedure OnDelSdl(Sender: TObject);
    procedure OnGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnGetCellType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnSetMode(Sender: TObject);
    procedure OnResetAllState(Sender: TObject);
    procedure OnSetFontClick(Sender: TObject);
    procedure OnSetColor_PanelClick(Sender: TObject);
    procedure OnChandgeRemMode(Sender: TObject);
    procedure OnSaveEnergoData(Sender: TObject);
    procedure OnChandgeExport(Sender: TObject);
    procedure OnComboChandge(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure OnSettTime(Sender: TObject);
    procedure OnRepplMdm(Sender: TObject);
    procedure OnSetAll(Sender: TObject);
    procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnChModem(Sender: TObject);
    procedure OnDropSunChan(Sender, Source: TObject; X, Y: Integer);
    procedure OnChsynchro(Sender: TObject);
    procedure OnStartCall(Sender: TObject);
    procedure OnStopCall(Sender: TObject);
    procedure OnReBoot(Sender: TObject);
    procedure StyleFormChange(Sender: TObject);
    procedure OnStartTest(Sender: TObject);
    procedure OnStopTest(Sender: TObject);
    procedure OnFillDiagRep(Sender: TObject);
    procedure OnSetDiagnos(Sender: TObject);
    procedure OnGetDiaSet(Sender: TObject);
    procedure OnSaveGridTTime(Sender: TObject);
    procedure OnSetGridTTime(Sender: TObject);
    procedure OnAddTTime(Sender: TObject);
    procedure OnCloneTTime(Sender: TObject);
    procedure OnDellRowTTime(Sender: TObject);
    procedure OnDelAllRowTTime(Sender: TObject);
    procedure OnClickTTimeGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnChannelGetCellTTIimeType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure OnMDownTTime(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnLoadModule(Sender: TObject);
    procedure OSdlInit(Sender: TObject);
    procedure SchedInit;
    procedure SetSettIntValue(strValue:String;nValue:Integer);
    procedure OnSetEditTTime(Sender: TObject);
    procedure OnCloseConf(Sender: TObject; var Action: TCloseAction);
    procedure OnStartFh(Sender: TObject);
    procedure OnChandgeQueryMode(Sender: TObject);
    procedure OnClickCurr(Sender: TObject);
    procedure OnClickAEN(Sender: TObject);
    procedure OnClickEvent(Sender: TObject);
    procedure OnClickANetEN(Sender: TObject);
    procedure OnClickQweryTree(Sender: TObject);

    procedure ab_DBFStartClick(Sender: TObject);
    procedure ab_DBFStopClick(Sender: TObject);
    procedure OnDbfOpenPath(Sender: TObject);

    procedure OnGetEv3(Sender: TObject);
    procedure OnDropSunChan1(Sender: TObject);
    procedure btnOpenSessionClick(Sender: TObject);
    procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    procedure OnChSesion(Sender: TObject);
    procedure SetInitRemCrcQry;
    procedure OnSendReload(Sender: TObject);
  private
    { Private declarations }
    m_strCurrentDir : String;
    m_bySchedState  : Integer;
    m_nIDIndex      : Integer;
    m_nCurrGroup    : Integer;
    m_nEventList    : TStringList;

    b_ExportEd      : boolean;
    btEditFmak      : boolean;

    FlbScheduler    : PTStaticText;
    FlbSchedTime    : PTStaticText;
    FlbSdlQrylb     : PTStaticText;
    FlbSetTmState   : PTStaticText;
    FlbOnTransTime  : PTStaticText;
    FlbOnTransState : PTStaticText;
    FlbSExpired     : PTStaticText;

    Description     : extended;
    FConfifTbl      : PSGENSETTTAG;
    procedure InitComboChannel;
    procedure GetGridRecord(var pTbl:SEVENTSETTTAG);
    procedure ExecSetEventGrid;
    procedure AddRecordToEventGrid(nIndex:Integer;var pTbl:SEVENTSETTTAG{;var pTable:SEVENTTAG});
    procedure SetQueryMask(var pTbl:SGENSETTTAG);
    procedure GetQueryMask(var pTbl:SGENSETTTAG);
    procedure SendRemCrcReBoot(pDS:CMessageData);
    procedure SendRemCrcFind(pDS:CMessageData);
    procedure OnQweryReboot;
//    function  ServiceStart(aMachine, aServiceName: string ): boolean;
//    function  ServiceStop(aMachine,aServiceName: string ): boolean;
//    function  ServiceGetStatus(sMachine, sService: string ): DWord;
//    function  StartProcess(strPath:String;blWait:Boolean):Boolean;
    function  GetSessionTime(nIndex:Integer):Dword;

  public
    m_nSDL          : CQryScheduler;
    //m_nUMN          : CUpdateManager;
    m_nTT           : CTransTime;
    m_nSetColor     : CSetColor;
//    m_nBA           : CArchiveBase;
    m_nUsrCtrl      : CUserControlClass;
    m_blFirstChandge: Boolean;
    m_nFirstcount   : Integer;
  public
    m_pGenTable : SGENSETTTAG;
    procedure Init;
    procedure InitColor;
    procedure Run;
    procedure OnReadSettings;
    function GenMode:Byte;
    function GenLocation:Byte;
    function GenAddress:String;
    function GenStorePeriod:Integer;
    function GenClearPeriod:Integer;
    function CorrectClearPeriod:Integer;
    function GenProtoPeriod:Integer;
    function GenPoolPeriod:Integer;
    procedure SetGenSettings;
    procedure SchedOn;
    procedure SchedOff;
    procedure SchedPause;
    procedure SchedGo;
    procedure SchedSetAction;
    function IsLocal:Boolean;
    function IsSlave:Boolean;
    function IsPreGraph:Boolean;
    function IsScheduler:Boolean;
    function QueryType:Integer;
    function IsFinder:Boolean;
    function IsAutoTray:Boolean;
    function IsRamDrive:Boolean;
    function IsETelecom:Boolean;
    function IsStartCvr:Boolean;
    function IsExport:Boolean;
    function GetProjectName:String;
    function GetSessTime:Dword;
    function GetPowLim:Single;
    function GetPowPrc:Single;
    procedure SaveEvent(NewTime,STime: TDateTime);
    procedure ReBootPrg;
    procedure OnChandgeIP0;
    procedure SelfStop;
//    procedure SelfUpdate;
    procedure SelfReload;
//    procedure RunSharedAccess;
//    procedure StopSharedAccess;
//    procedure EnableRD;
//    procedure DisableRD;
//    procedure StartAmmy;
//    procedure StopAmmy;
    procedure ModemPrepare;
//    procedure UpdateARM;
    function  IsTransTime:Boolean;
    function  IsCalendOn:Boolean;
   public
      property PlbScheduler     :PTStaticText    read FlbScheduler      write FlbScheduler;
      property PlbSchedTime     :PTStaticText    read FlbSchedTime      write FlbSchedTime;
      property PlbSdlQrylb      :PTStaticText    read FlbSdlQrylb       write FlbSdlQrylb;
      property PlbSetTmState    :PTStaticText    read FlbSetTmState     write FlbSetTmState;
      property PlbOnTransTime   :PTStaticText    read FlbOnTransTime    write FlbOnTransTime;
      property PlbOnTransState  :PTStaticText    read FlbOnTransState   write FlbOnTransState;
      property PConfifTbl       :PSGENSETTTAG    read FConfifTbl        write FConfifTbl;
      property PsgGridTransTime :TAdvStringGrid  read sgTransTime       write sgTransTime;
      property PlbSExpired      :PTStaticText    read FlbSExpired       write FlbSExpired;
      destructor Destroy; override;
  end;
    procedure OnGlGetCellColor(Sender: TObject; ARow,ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);

var
  m_nCF: TTL5Config = nil;

const
  SELDIRHELP = 1000;
  WM_SENDTOMONITORSTOP = WM_USER + 5;
  WM_SENDTOMNUPDATE    = WM_USER + 6;
  WM_SENDTOMNRELOAD    = WM_USER + 7;
function SelectDirPlus(hWnd: HWND; const Caption: string; const Root: WideString): String;

implementation

uses knslProgressLoad;

{$R *.DFM}
procedure TTL5Config.SaveEvent(NewTime,STime: TDateTime);
var
  KorrInMS : integer;
begin
   if m_blFirstChandge=False then
   Begin
   m_blFirstChandge := True;
   m_nFirstcount    := 0;
   KorrInMS := trunc(abs(STime - NewTime) / EncodeTime(0, 0, 0, 1));

   if (m_pDB.EventFlagCorrector = EVH_COR_TIME_KYEBD) and (KorrInMS < 500) then
     exit;
   if m_pDB.EventFlagCorrector = EVH_COR_TIME_KYEBD  then
   begin
     m_pDB.FixUspdEventCorrectorEx(STime,EVH_COR_TIME_KYEBD,0); //EVENT
     m_pDB.FixUspdEventCorrector(EVH_FINISH_CORR, KorrInMS);
   end;
   if m_pDB.EventFlagCorrector = EVH_COR_TIME_DEVICE then
   begin
     m_pDB.FixUspdEventCorrectorEx(STime,EVH_COR_TIME_DEVICE,0); //EVENT
     m_pDB.FixUspdEventCorrector(EVH_FINISH_CORR, KorrInMS);
   end;
   if m_pDB.EventFlagCorrector = EVH_COR_TIME_AUTO   then
   begin
     m_pDB.FixUspdEventCorrectorEx(STime,EVH_COR_TIME_AUTO,0); //EVENT
     m_pDB.FixUspdEventCorrector(EVH_FINISH_CORR, KorrInMS);
   end;
   m_pDB.EventFlagCorrector := EVH_COR_TIME_KYEBD;
   End;
end;

procedure TTL5Config.OnChandgeSett(Sender: TObject);
begin
    dtQryPicker.Visible := False;
    cbQryPeriod.Visible := False;
    lbEnter.Visible     := False;
    lbPeriod.Visible    := False;
    cbQryPeriod.Visible := False;
    lbBottInfo.Visible  := False;
    if pgGenSettings.ActivePageIndex=0 then lbGenSettings.Caption := '�������� ���������';
    if pgGenSettings.ActivePageIndex=1 then lbGenSettings.Caption := '��������� �������� �������';
    if pgGenSettings.ActivePageIndex=2 then
    Begin
     lbGenSettings.Caption := '������ ������';
     dtQryPicker.Visible := True;
     cbQryPeriod.Visible := True;
     lbEnter.Visible     := True;
     lbPeriod.Visible    := True;
     cbQryPeriod.Visible := True;
    End;
    if pgGenSettings.ActivePageIndex=3 then
    Begin
     lbGenSettings.Caption := '�������';
     lbBottInfo.Visible  := True;
     OnGetEv0(self);
    End;
    if pgGenSettings.ActivePageIndex=4 then lbGenSettings.Caption := '����������';
    if pgGenSettings.ActivePageIndex=5 then lbGenSettings.Caption := '����';
    if pgGenSettings.ActivePageIndex=6 then lbGenSettings.Caption := '����������� �������';
end;

procedure TTL5Config.OnCreateForm(Sender: TObject);
var  mCL : SCOLORSETTTAG;
begin
    m_nCF := self;
    m_bySchedState := 1;
    m_blFirstChandge := False;
    m_nFirstcount    := 0;
    lbGenSettings.Caption := '�������� ���������';
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    cbm_sbyMode.items.loadfromfile(m_strCurrentDir+'SettGenMode.dat');
    cbm_sbyLocation.items.loadfromfile(m_strCurrentDir+'MeterLocation.dat');
    cbm_sbyAutoPack.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_sStorePeriod.items.loadfromfile(m_strCurrentDir+'SettStorePeriod.dat');
    cbm_sStoreClrTime.items.loadfromfile(m_strCurrentDir+'SettStoreClrTime.dat');
    cbm_sStoreProto.items.loadfromfile(m_strCurrentDir+'SettStoreProto.dat');
    cbm_sPoolPeriod.items.loadfromfile(m_strCurrentDir+'SettPoolPeriod.dat');
    cbm_sPrePoolGraph.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbQryPeriod.items.loadfromfile(m_strCurrentDir+'ShedPeriod.dat');
    cbm_sQryScheduler.items.loadfromfile(m_strCurrentDir+'QueryMode.dat');
    cbm_sAutoTray.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_sBaseLocation.items.loadfromfile(m_strCurrentDir+'SettBaseLocation.dat');
    cbm_sCorrDir.Items.LoadFromFile(m_strCurrentDir+'CorrDir.dat');
    cbm_sSetForETelecom.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_sInterSet.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_sUseModem.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_sTransTime.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_ChooseEnergo.Items.loadfromfile(m_strCurrentDir+'Export.dat');
    cbm_blOnStartCvery.items.loadfromfile(m_strCurrentDir+'Active.dat');
//    cbm_byEnableArchiv.items.loadfromfile(m_strCurrentDir+'Active.dat');
//    cbm_tmArchPeriod.items.loadfromfile(m_strCurrentDir+'ArchPeriod.dat');
    m_nEventList    := TStringList.Create;
    dtQryPicker.Visible := False;
    cbQryPeriod.Visible := False;
    lbEnter.Visible     := False;
    lbPeriod.Visible    := False;
    lbBottInfo.Visible  := False;
    cbQryPeriod.Visible := False;
    m_blIsRemCrc := False;
    m_blIsRemEco := False;
    m_blIsRemC12 := False;
    m_nIDIndex   := 1;
    m_nCurrGroup := 0;
    FsgGrid.ColCount    := 5;
    FsgGrid.RowCount    := 70;
    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := '������';
    FsgGrid.Cells[2,0]  := '��� ';
    FsgGrid.Cells[3,0]  := '��������';
    FsgGrid.Cells[4,0]  := '����������';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 40;
    FsgGrid.ColWidths[2]:= 50;
    FsgGrid.ColWidths[3]:= 400;
    m_nSetColor := CSetColor.Create;
end;

procedure TTL5Config.Init;
var
    ddd : TDateTime;
Begin
    FConfifTbl := @m_pGenTable;
    InitComboChannel;
    if m_nSDL=Nil then m_nSDL := CQryScheduler.Create;
    if m_nUsrCtrl=Nil then m_nUsrCtrl := CUserControlClass.Create;
    m_nUsrCtrl.Init;

    m_nSDL.PsgGrid  := @sgQryTable;
    m_nSDL.PdtPick  := @dtQryPicker;
    m_nSDL.PcbCombo := @cbQryPeriod;
    m_nSDL.PlbScheduler := FlbScheduler;
    m_nSDL.PlbSchedTime := FlbSchedTime;
    m_nSDL.PlbSetTmState := FlbSetTmState;
    m_nSDL.PlbSExpired   := FlbSExpired;

    m_nSDL.PsgGrid         := @sgQryTable;
    m_nSDL.PTreeModuleData := @FTreeModuleData;
    m_nSDL.Pcbm_nWekEN := @cbm_nWekEN;
    m_nSDL.Pcbm_nPon   := @cbm_nPon;
    m_nSDL.Pcbm_nWto   := @cbm_nWto;
    m_nSDL.Pcbm_nSrd   := @cbm_nSrd;
    m_nSDL.Pcbm_nCht   := @cbm_nCht;
    m_nSDL.Pcbm_nPtn   := @cbm_nPtn;
    m_nSDL.Pcbm_nSub   := @cbm_nSub;
    m_nSDL.Pcbm_nVos   := @cbm_nVos;
    m_nSDL.Pcbm_nMonthEN := @cbm_nMonthEN;
    m_nSDL.Pcbm_nDay1  := @cbm_nDay1;
    m_nSDL.Pcbm_nDay2  := @cbm_nDay2;
    m_nSDL.Pcbm_nDay3  := @cbm_nDay3;
    m_nSDL.Pcbm_nDay4  := @cbm_nDay4;
    m_nSDL.Pcbm_nDay5  := @cbm_nDay5;
    m_nSDL.Pcbm_nDay6  := @cbm_nDay6;
    m_nSDL.Pcbm_nDay7  := @cbm_nDay7;
    m_nSDL.Pcbm_nDay8  := @cbm_nDay8;
    m_nSDL.Pcbm_nDay9  := @cbm_nDay9;
    m_nSDL.Pcbm_nDay10 := @cbm_nDay10;
    m_nSDL.Pcbm_nDay11 := @cbm_nDay11;
    m_nSDL.Pcbm_nDay12 := @cbm_nDay12;
    m_nSDL.Pcbm_nDay13 := @cbm_nDay13;
    m_nSDL.Pcbm_nDay14 := @cbm_nDay14;
    m_nSDL.Pcbm_nDay15 := @cbm_nDay15;
    m_nSDL.Pcbm_nDay16 := @cbm_nDay16;
    m_nSDL.Pcbm_nDay17 := @cbm_nDay17;
    m_nSDL.Pcbm_nDay18 := @cbm_nDay18;
    m_nSDL.Pcbm_nDay19 := @cbm_nDay19;
    m_nSDL.Pcbm_nDay20 := @cbm_nDay20;
    m_nSDL.Pcbm_nDay21 := @cbm_nDay21;
    m_nSDL.Pcbm_nDay22 := @cbm_nDay22;
    m_nSDL.Pcbm_nDay23 := @cbm_nDay23;
    m_nSDL.Pcbm_nDay24 := @cbm_nDay24;
    m_nSDL.Pcbm_nDay25 := @cbm_nDay25;
    m_nSDL.Pcbm_nDay26 := @cbm_nDay26;
    m_nSDL.Pcbm_nDay27 := @cbm_nDay27;
    m_nSDL.Pcbm_nDay28 := @cbm_nDay28;
    m_nSDL.Pcbm_nDay29 := @cbm_nDay29;
    m_nSDL.Pcbm_nDay30 := @cbm_nDay30;
    m_nSDL.Pcbm_nDay31 := @cbm_nDay31;
    m_nSDL.PdtPicShed  := @dtPicShed;

    m_nSDL.Pcbm_nArchEN    := @cbm_nArchEN;
    m_nSDL.Pcbm_nPriDayF   := @cbm_nPriDayF;
    m_nSDL.Pcbm_nPriMonthF := @cbm_nPriMonthF;
    m_nSDL.Pcbm_nPri30F    := @cbm_nPri30F;
    m_nSDL.Pcbm_nNakDayF   := @cbm_nNakDayF;
    m_nSDL.Pcbm_nNakMonthF := @cbm_nNakMonthF;
    m_nSDL.Pcbm_byCurrent  := @cbm_byCurrent;
    m_nSDL.Pcbm_bySumEn    := @cbm_bySumEn;
    m_nSDL.Pcbm_byMAP      := @cbm_byMAP;
    m_nSDL.Pcbm_byMRAP     := @cbm_byMRAP;
    m_nSDL.Pcbm_byU        := @cbm_byU;
    m_nSDL.Pcbm_byI        := @cbm_byI;
    m_nSDL.Pcbm_byFreq     := @cbm_byFreq;
    m_nSDL.Pcbm_nPar6      := @cbm_nPar6;
    m_nSDL.Pcbm_byJEn      := @cbm_byJEn;
    m_nSDL.Pcbm_byJ0       := @cbm_byJ0;
    m_nSDL.Pcbm_byJ1       := @cbm_byJ1;
    m_nSDL.Pcbm_byJ2       := @cbm_byJ2;
    m_nSDL.Pcbm_byJ3       := @cbm_byJ3;
    m_nSDL.Pcbm_byPNetEn   := @cbm_byPNetEn;
    m_nSDL.Pcbm_byPNetU    := @cbm_byPNetU;
    m_nSDL.Pcbm_byPNetI    := @cbm_byPNetI;
    m_nSDL.Pcbm_byPNetFi   := @cbm_byPNetFi;
    m_nSDL.Pcbm_byPNetCosFi := @cbm_byPNetCosFi;
    m_nSDL.Pcbm_byPNetF    := @cbm_byPNetF;
    m_nSDL.Pcbm_byPNetP    := @cbm_byPNetP;
    m_nSDL.Pcbm_byPNetQ    := @cbm_byPNetQ;
    m_nSDL.Pcbm_byCorrTM   := @cbm_byCorrTM;

    m_nTT                 := CTransTime.Create;
    m_nTT.PlbOnTransTime  := FlbOnTransTime;
    m_nTT.PlbOnTransState := FlbOnTransState;
    m_nTT.PsgGrid         := @sgTransTime;

    OnGetEv0(self);
    OnReadSettings;

    m_nTT.Init(@m_pGenTable);
    m_nSDL.Init(@m_pGenTable);

//    if m_nUMN=Nil then m_nUMN  := CUpdateManager.Create;
//    m_nUMN.Pcbm_nIsRemLink   := @cbm_nIsRemLink;
//    m_nUMN.Pedm_nIsRemLink   := @edm_nIsRemLink;
//    m_nUMN.Pedm_nUpdatePath  := @edm_nUpdatePath;

//    m_nUMN.Pedm_nLoadUpdate  := @edm_nLoadUpdate;
//    m_nUMN.Pedm_nUnpackUpdate:= @edm_nUnpackUpdate;
//    m_nUMN.Pedm_nCopyUpdate  := @edm_nCopyUpdate;
//    m_nUMN.Pedm_nRemLinkState:= @edm_nRemLinkState;
//    m_nUMN.Pedm_nStartProgramm:= @edm_nStartProgramm;
//    m_nUMN.Pedm_nDestPath    := @edm_nDestPath;
//    m_nUMN.Init(@m_pGenTable);

//    if m_nBA=Nil  then m_nBA := CArchiveBase.Create(ExtractFilePath(Application.ExeName),@m_pGenTable);
//    m_nBA.PForm := self;
    cbOpenSessionTime.ItemIndex := 2;
    b_ExportEd := false;
    btEditFmak := false;
End;
procedure TTL5Config.InitColor;
var mcl : SCOLORSETTTAG;
i,nstyle:integer;
Begin

    mCL.m_swCtrlID := CL_TREE_CONF;
    m_pDB.GetColorTable(mCL);
    StyleForm.Clear;
    for i := 0 to 8 do
    StyleForm.Items.Add(StrStyle[i]);
    StyleForm.ItemIndex := mcl.m_swStyle;

    FontDialog1.font.Name := mcl.m_sstrFontName;
    Edit1.Text       := mcl.m_sstrFontName;
    Edit1.Color      := mcl.m_swColor;
    Edit2.Color      := mcl.m_swColorPanel;
    nSizeFont        := mcl.m_swFontSize;

    m_nSetColor.PSgQryTable  := @SgQryTable;
    m_nSetColor.PCofigStyler := @CofigStyler;
    m_nSetColor.PsgGrid      := @FsgGrid;
    m_nSetColor.SetColorPanel(mCL);
    m_blGridDataFontColor    := mcl.m_swColor;
    m_blGridDataFontSize     := nSizeFont;
    m_blGridDataFontName     := mcl.m_sstrFontName;
    m_nSetColor.SetColorSettings(mcl);
    m_nSetColor.SetAllStyle(mcl.m_swStyle);
end;

procedure TTL5Config.OnFormResize1(Sender: TObject);
Var
    i : Integer;
Begin
    for i:=4 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(40+50+400)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-4));
    m_nSDL.OnFormResize;
    m_nTT.OnFormResize;
End;

procedure TTL5Config.OnReadSettings;
Begin
    OnGetGenData(self);
    OnSetSettings(self);
End;


procedure TTL5Config.OnSaveGenData(Sender: TObject);
Var
    pTable : SGENSETTTAG;
begin
    with pTable do
    Begin
     pTable.m_dtLast:= m_pGenTable.m_dtLast;
     m_swAddres     := sem_swAddres.Text;
     m_swMask       := edm_swMask.Text;
     m_swGate       := edm_swGate.Text;
     m_sbyMode      := cbm_sbyMode.ItemIndex;
     m_sbyLocation  := cbm_sbyLocation.ItemIndex;
     m_sbyAutoPack  := cbm_sbyAutoPack.ItemIndex;
     m_sStorePeriod := cbm_sStorePeriod.ItemIndex;
     m_sStoreClrTime:= cbm_sStoreClrTime.ItemIndex;
     m_sStoreProto  := cbm_sStoreProto.ItemIndex;
     m_sPoolPeriod  := cbm_sPoolPeriod.ItemIndex;
     m_sProjectName := edm_sProjectName.Text;
     m_sPrePoolGraph:= cbm_sPrePoolGraph.ItemIndex;
     m_sPowerLimit  := StrToFloat(edm_sPowerLimit.Text);
     m_sPowerPrc    := sem_sPowerLimit.Value;
     m_sQryScheduler:= cbm_sQryScheduler.ItemIndex;
     if m_sQryScheduler=2 then m_sPrePoolGraph:=0;
     m_sAutoTray    := cbm_sAutoTray.ItemIndex;
     m_sPrecise     := sem_sPrecise.Value;
     m_sPreciseExpense :=  sem_sPreciseExpense.Value;
     m_sCorrDir     := cbm_sCorrDir.ItemIndex;
     m_sBaseLocation:= cbm_sBaseLocation.ItemIndex;
     m_sKorrDelay   := StrToFloat(edm_sKorrDelay.Text);
     m_sSetForETelecom := cbm_sSetForETelecom.ItemIndex;
     m_sInterSet    := cbm_sInterSet.ItemIndex;
     m_sChooseExport:= cbm_ChooseEnergo.ItemIndex;
     m_sMdmJoinName := edm_sMdmJoinName.Text;
     m_sUseModem    := cbm_sUseModem.ItemIndex;
     m_sInterDelay  := StrToFloat(edm_sInterDelay.Text);
     m_sChannSyn    := cbm_sChannSyn.ItemIndex;
     m_sTransTime   := cbm_sTransTime.ItemIndex;
     m_sCalendOn    := cbm_sCalendOn.ItemIndex;
     m_blOnStartCvery  := cbm_blOnStartCvery.ItemIndex;
     m_sbyDeltaFH      := cbm_DeltaFH.ItemIndex;
     if cbAllowInDConn.Checked then m_sbyAllowInDConn := 1 else m_sbyAllowInDConn := 0;
     M_NSESSIONTIME    := cbM_NSESSIONTIME.ItemIndex;
    End;
    SetQueryMask(pTable);
    m_pDB.AddGenSettTable(pTable);
end;

procedure TTL5Config.OnGetGenData(Sender: TObject);
Var
    Fl : TINIFile;
begin
    Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\Settings\USPD_Config.ini');
     m_nIsTimeSV          := Fl.ReadInteger('DBCONFIG','m_nIsTimeSV',0);
     m_nTimeDlt           := Fl.ReadInteger('DBCONFIG','m_nTimeDlt',7200);
     m_nMaxKorrTime       := Fl.ReadInteger('DBCONFIG','m_nMaxKorrTime',60);
     m_nIsOneSynchro      := Fl.ReadInteger('DBCONFIG','m_nIsOneSynchro',1);
     m_nMaxDayNetParam    := Fl.ReadInteger('DBCONFIG','m_nMaxDayNetParam',30);
     m_nSmartFinder       := Fl.ReadInteger('DBCONFIG','m_nSmartFinder',0);
     m_nUpdateFunction    := Fl.ReadInteger('DBCONFIG','m_nUpdateFunction',1);
     m_nCountOfEvents     := Fl.ReadInteger('DBCONFIG', 'm_nCountOfEvents', 5000);
     m_byCoverState       := Fl.ReadInteger('DBCONFIG', 'm_byCoverState', 1);
    Fl.Destroy;
    if m_pDB.GetGenSettTable(m_pGenTable) then
    Begin
     with m_pGenTable do
     Begin
      sem_sPrecise.Value          := m_sPrecise;
      sem_sPreciseExpense.Value   := m_sPreciseExpense;
      sem_swAddres.Text           := m_swAddres;
      edm_swMask.Text             := m_swMask;
      edm_swGate.Text             := m_swGate;
      cbm_sbyMode.ItemIndex       := m_sbyMode;
      cbm_sbyLocation.ItemIndex   := m_sbyLocation;
      cbm_sbyAutoPack.ItemIndex   := m_sbyAutoPack;
      cbm_sStorePeriod.ItemIndex  := m_sStorePeriod;
      cbm_sStoreClrTime.ItemIndex := m_sStoreClrTime;
      cbm_sStoreProto.ItemIndex   := m_sStoreProto;
      cbm_sPoolPeriod.ItemIndex   := m_sPoolPeriod;
      if m_sProjectName='' then edm_sProjectName.Text := 'Project X' else
      edm_sProjectName.Text       := m_sProjectName;
      cbm_sPrePoolGraph.ItemIndex := m_sPrePoolGraph;
      edm_sPowerLimit.Text        := FloatToStr(m_sPowerLimit);
      sem_sPowerLimit.Value       := m_sPowerPrc;
      cbm_sQryScheduler.ItemIndex := m_sQryScheduler;
      cbm_sAutoTray.ItemIndex     := m_sAutoTray;
      cbm_sBaseLocation.ItemIndex := m_sBaseLocation;
      cbm_sCorrDir.ItemIndex      := m_sCorrDir;
      edm_sKorrDelay.Text         := FloatToStrF(m_sKorrDelay, ffFixed, 10, 1);
      cbm_sSetForETelecom.ItemIndex := m_sSetForETelecom;
      cbm_ChooseEnergo.ItemIndex  := m_sChooseExport;
      m_blIsEEnergo               := Boolean(m_sSetForETelecom);
      cbm_sInterSet.ItemIndex     := m_sInterSet;
      edm_sMdmJoinName.Text       := m_sMdmJoinName;
      cbm_sUseModem.ItemIndex     := m_sUseModem;
      edm_sInterDelay.Text        := FloatToStrF(m_sInterDelay, ffFixed, 10, 1);
      cbm_sChannSyn.ItemIndex     := m_sChannSyn;
      cbm_sTransTime.ItemIndex    := m_sTransTime;
      cbm_sCalendOn.ItemIndex     := m_sCalendOn;
      cbm_blOnStartCvery.ItemIndex:= m_blOnStartCvery;
      cbm_DeltaFH.ItemIndex       := m_sbyDeltaFH;
      m_nTT.OnEnable              := Boolean(m_sTransTime);

      if m_sbyAllowInDConn = 1 then cbAllowInDConn.Checked := true else cbAllowInDConn.Checked := false;
      if m_sQryScheduler=1 then
      Begin
       FlbSchedTime.Visible := True;
       FlbSdlQrylb.Visible  := True;
       m_bySchedState       := 1;
      End else
      if m_sQryScheduler=0 then
      Begin
       FlbSchedTime.Visible := False;
       FlbSdlQrylb.Visible  := False;
      End;
      m_nPrecise        := m_sPrecise;
      m_nPreciseExpense := m_sPreciseExpense;
      cbM_NSESSIONTIME.ItemIndex := M_NSESSIONTIME;
      m_nUsrCtrl.InitTimer(GetSessTime);
     End;

     GetQueryMask(m_pGenTable);
     OnClickCurr(self);
     OnChandgeExport(self);
     OnChsynchro(self);
     if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=1) then
    End;
end;

procedure TTL5Config.SetQueryMask(var pTbl:SGENSETTTAG);
Begin
    pTbl.M_SQUERYMASK := 0;
    if cbm_nArchEN.Checked=True     then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ARCH_EN;
     if cbm_nPriDayF.Checked=True   then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ENERGY_DAY_EP;
     if cbm_nPriMonthF.Checked=True then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ENERGY_MON_EP;
     if cbm_nPri30F.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_SRES_ENR_EP;
     if cbm_nNakDayF.Checked=True   then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_NAK_EN_DAY_EP;
     if cbm_nNakMonthF.Checked=True then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_NAK_EN_MONTH_EP;

    if cbm_byCurrent.Checked=True   then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR;
     if cbm_bySumEn.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR_SUMM;
     if cbm_byMAP.Checked=True      then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR_MAP;
     if cbm_byMRAP.Checked=True     then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR_MRP;
     if cbm_byU.Checked=True        then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR_U;
     if cbm_byI.Checked=True        then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR_I;
     if cbm_byFreq.Checked=True     then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CURR_F;
     if cbm_byCorrTM.Checked=True   then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_CORR_TIME;

    if cbm_nPar6.Checked=True       then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_POD_TRYB_HEAT;

    if cbm_byJEn.Checked=True       then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_JUR_EN;
     if cbm_byJ0.Checked=True       then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_JUR_0;
     if cbm_byJ1.Checked=True       then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_JUR_1;
     if cbm_byJ2.Checked=True       then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_JUR_2;
     if cbm_byJ3.Checked=True       then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_JUR_3;

    if cbm_byPNetEn.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_EN;
     if cbm_byPNetU.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_U;
     if cbm_byPNetI.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_I;
     if cbm_byPNetFi.Checked=True   then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_FI;
     if cbm_byPNetCosFi.Checked=True then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_CFI;
     if cbm_byPNetF.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_F;
     if cbm_byPNetP.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_P;
     if cbm_byPNetQ.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_ANET_Q;

    if cbm_byRecalc.Checked=True    then pTbl.M_SQUERYMASK := pTbl.M_SQUERYMASK or QFH_RECALC_ABOID;
End;

procedure TTL5Config.GetQueryMask(var pTbl:SGENSETTTAG);
Begin

    cbm_nArchEN.Checked    := (pTbl.M_SQUERYMASK and QFH_ARCH_EN)>0;
    cbm_nPriDayF.Checked   := (pTbl.M_SQUERYMASK and QFH_ENERGY_DAY_EP)>0;
    cbm_nPriMonthF.Checked := (pTbl.M_SQUERYMASK and QFH_ENERGY_MON_EP)>0;
    cbm_nPri30F.Checked    := (pTbl.M_SQUERYMASK and QFH_SRES_ENR_EP)>0;
    cbm_nNakDayF.Checked   := (pTbl.M_SQUERYMASK and QFH_NAK_EN_DAY_EP)>0;
    cbm_nNakMonthF.Checked := (pTbl.M_SQUERYMASK and QFH_NAK_EN_MONTH_EP)>0;

    cbm_byCurrent.Checked  := (pTbl.M_SQUERYMASK and QFH_CURR)>0;
    cbm_bySumEn.Checked    := (pTbl.M_SQUERYMASK and QFH_CURR_SUMM)>0;
    cbm_byMAP.Checked      := (pTbl.M_SQUERYMASK and QFH_CURR_MAP)>0;
    cbm_byMRAP.Checked     := (pTbl.M_SQUERYMASK and QFH_CURR_MRP)>0;
    cbm_byU.Checked        := (pTbl.M_SQUERYMASK and QFH_CURR_U)>0;
    cbm_byI.Checked        := (pTbl.M_SQUERYMASK and QFH_CURR_I)>0;
    cbm_byFreq.Checked     := (pTbl.M_SQUERYMASK and QFH_CURR_F)>0;
    cbm_byCorrTM.Checked   := (pTbl.M_SQUERYMASK and QFH_CORR_TIME)>0;

    cbm_nPar6.Checked      := (pTbl.M_SQUERYMASK and QFH_POD_TRYB_HEAT)>0;

    cbm_byJEn.Checked      := (pTbl.M_SQUERYMASK and QFH_JUR_EN)>0;
    cbm_byJ0.Checked       := (pTbl.M_SQUERYMASK and QFH_JUR_0)>0;
    cbm_byJ1.Checked       := (pTbl.M_SQUERYMASK and QFH_JUR_1)>0;
    cbm_byJ2.Checked       := (pTbl.M_SQUERYMASK and QFH_JUR_2)>0;
    cbm_byJ3.Checked       := (pTbl.M_SQUERYMASK and QFH_JUR_3)>0;

    cbm_byPNetEn.Checked   := (pTbl.M_SQUERYMASK and QFH_ANET_EN)>0;
    cbm_byPNetU.Checked    := (pTbl.M_SQUERYMASK and QFH_ANET_U)>0;
    cbm_byPNetI.Checked    := (pTbl.M_SQUERYMASK and QFH_ANET_I)>0;
    cbm_byPNetFi.Checked   := (pTbl.M_SQUERYMASK and QFH_ANET_FI)>0;
    cbm_byPNetCosFi.Checked:= (pTbl.M_SQUERYMASK and QFH_ANET_CFI)>0;
    cbm_byPNetF.Checked    := (pTbl.M_SQUERYMASK and QFH_ANET_F)>0;
    cbm_byPNetP.Checked    := (pTbl.M_SQUERYMASK and QFH_ANET_P)>0;
    cbm_byPNetQ.Checked    := (pTbl.M_SQUERYMASK and QFH_ANET_Q)>0;

    cbm_byRecalc.Checked   := (pTbl.M_SQUERYMASK and QFH_RECALC_ABOID)>0;

    OnClickCurr(self);
    OnClickEvent(self);
    OnClickAEN(self);
    OnClickANetEN(self);
End;
function  TTL5Config.IsTransTime:Boolean;
Begin
    Result := (m_pGenTable.m_sTransTime=1);
End;
function  TTL5Config.IsCalendOn:Boolean;
Begin
    Result := (m_pGenTable.m_sCalendOn=1);
End;
function TTL5Config.GetSessTime:Dword;
Begin
    Result := GetSessionTime(m_pGenTable.M_NSESSIONTIME);
End;
function TTL5Config.GenMode:Byte;
Begin
    Result := m_pGenTable.m_sbyMode;
End;
function TTL5Config.GenLocation:Byte;
Begin
    Result := m_pGenTable.m_sbyLocation;
End;

function TTL5Config.IsStartCvr:Boolean;
Begin
    Result:=True;
    if m_pGenTable.m_blOnStartCvery=1 then Result:=True;
    if m_pGenTable.m_blOnStartCvery=0 then Result:=False;
End;

function TTL5Config.IsLocal:Boolean;
Begin
    Result:=True;
    if m_pGenTable.m_sbyLocation=0 then Result:=True;
    if m_pGenTable.m_sbyLocation=1 then Result:=False;
End;

function TTL5Config.IsSlave:Boolean;
Begin
    if m_pGenTable.m_sbyMode=0 then Result:=True;
    if m_pGenTable.m_sbyMode=1 then Result:=False;
End;

function TTL5Config.IsPreGraph:Boolean;
Begin
    if m_nDataFinder=True then Begin Result:=False;exit;End;
    if m_pGenTable.m_sPrePoolGraph=1 then Result:=True;
    if m_pGenTable.m_sPrePoolGraph=0 then Result:=False;
End;
function TTL5Config.IsScheduler:Boolean;
Begin
    if (m_pGenTable.m_sQryScheduler=1)or(m_pGenTable.m_sQryScheduler=2)or(m_pGenTable.m_sQryScheduler=QWR_QWERY_SRV) then Result:=True;
    if m_pGenTable.m_sQryScheduler=0 then Result:=False;
End;

function TTL5Config.QueryType:Integer;
Begin
    Result:= m_pGenTable.m_sQryScheduler;
End;


function TTL5Config.IsFinder:Boolean;
Begin
    if (m_pGenTable.m_sQryScheduler=2) then Result:=True else Result:=False;
End;
function TTL5Config.IsAutoTray:Boolean;
Begin
    if m_pGenTable.m_sAutoTray=1 then Result:=True;
    if m_pGenTable.m_sAutoTray=0 then Result:=False;
End;
function TTL5Config.IsRamDrive:Boolean;
Begin
    if m_pGenTable.m_sBaseLocation=1 then Result:=True;
    if m_pGenTable.m_sBaseLocation=0 then Result:=False;
End;
function TTL5Config.IsETelecom:Boolean;
Begin
    m_blIsEEnergo := Boolean(m_pGenTable.m_sSetForETelecom);
    if m_pGenTable.m_sSetForETelecom=1 then Result:=True;
    if m_pGenTable.m_sSetForETelecom=0 then Result:=False;
End;
function TTL5Config.GenAddress:String;
Begin
    Result := m_pGenTable.m_swAddres;
End;
function TTL5Config.GenStorePeriod:Integer;
Begin
    case m_pGenTable.m_sStorePeriod of
       0:  Result := 30*60;
       1:  Result := 1*60*60;
       2:  Result := 2*60*60;
       3:  Result := 3*60*60;
       4:  Result := 4*60*60;
       5:  Result := 5*60*60;
       6:  Result := 6*60*60;
       7:  Result := 7*60*60;
       8:  Result := 8*60*60;
       9:  Result := 9*60*60;
       10: Result := 10*60*60;
       11: Result := 11*60*60;
       12: Result := 12*60*60;
       13: Result := 23*60*60;
       else
           Result := 1*60*60;
    End;
End;
{
1 �����
2 ������
3 ������
4 ������
5 �������
6 �������
7 �������
8 �������
9 �������
10 �������
11 �������
12 �������
1.5 ���
2 ����
3 ����
����������
}
function TTL5Config.GenClearPeriod:Integer;
Begin
    case m_pGenTable.m_sStoreClrTime of
         0,1,2,3,4,5,6,7,8,9,10,11: Result := 1+m_pGenTable.m_sStoreClrTime;
         12:                        Result := 6+12;
         13:                        Result := 2*12;
         14:                        Result := 3*12;
         15:                        Result := 10*12;
         else
             Result := 1;
    End;
End;

function TTL5Config.CorrectClearPeriod:Integer;
Begin
    if m_pGenTable.m_sStoreClrTime>0 then m_pGenTable.m_sStoreClrTime:=m_pGenTable.m_sStoreClrTime-1;
    Result := m_pGenTable.m_sStoreClrTime + 1;
End;

function TTL5Config.GenProtoPeriod:Integer;
Begin
    case m_pGenTable.m_sStoreProto of
       0:  Result := 5*60;
       1:  Result := 15*60;
       2:  Result := 45*60;
       3:  Result := 60*60;
       else
           Result := 15*60;
    End;
End;
{
���������
15 ���.
30 ���.
1 ���.
3 ���.
5 ���.
10 ���.
15 ���.
30 ���.
1 ���
2 ���a
3 ���a
4 �����
5 �����
6 �����
7 �����
8 �����
9 �����
11 �����
12 �����

}
function TTL5Config.GenPoolPeriod:Integer;
Begin
    case m_pGenTable.m_sPoolPeriod of
       0:  Result := 0;
       1:  Result := 15;
       2:  Result := 30;
       3:  Result := 1*60;
       4:  Result := 3*60;
       5:  Result := 5*60;
       6:  Result := 10*60;
       7:  Result := 15*60;
       8:  Result := 30*60;
       9:  Result := 1*60*60;
       10:  Result := 2*60*60;
       11:  Result := 3*60*60;
       12:  Result := 4*60*60;
       13:  Result := 5*60*60;
       14:  Result := 6*60*60;
       15:  Result := 7*60*60;
       16:  Result := 8*60*60;
       17:  Result := 9*60*60;
       18:  Result := 10*60*60;
       19:  Result := 11*60*60;
       20:  Result := 12*60*60;
       else
           Result := 10;
    End;
End;
function TTL5Config.GetProjectName:String;
Begin
    Result := m_pGenTable.m_sProjectName;
End;
function TTL5Config.GetPowLim:Single;
Begin
    Result := m_pGenTable.m_sPowerLimit;
End;
function TTL5Config.GetPowPrc:Single;
Begin
    Result := m_pGenTable.m_sPowerPrc;
End;
procedure TTL5Config.OnGetEditTypeEvent(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid do
    case ACol of
     4:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
procedure TTL5Config.OnGetCellColorEvent(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin

    with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and (not(gdSelected in AState) or (gdFocused in AState)) then
     begin

     end;
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 9;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
     if (ARow<>0) and (ACol<>0)then
      Begin
        AFont.Color :=  m_blGridDataFontColor;//clAqua;
        AFont.Size  :=  m_blGridDataFontSize;
        AFont.Name  :=  m_blGridDataFontName;
        case ACol of
         1,2,4      : AFont.Color := clBlack;{clAqua;}
         3          : AFont.Color := clBlack;{clLime;}
        End;
      End;
    End;
end;

procedure TTL5Config.OnSetEvents(Sender: TObject);
Var
    i : Integer;
    pTbl:SEVENTSETTTAG;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[m_nIDIndex,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddEventTable(pTbl);
    End;
    //ExecInitLayer;
    ExecSetEventGrid;
End;
procedure TTL5Config.GetGridRecord(var pTbl:SEVENTSETTTAG);
Var
    i : Integer;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '0';
     if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := '0';
     if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := 'Event '+IntToStr(i);
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := '��';
     m_swGroupID    := StrToInt(FsgGrid.Cells[1,i]);
     m_swEventID    := StrToInt(FsgGrid.Cells[2,i]);
     m_schEventName := FsgGrid.Cells[3,i];
     m_sbyEnable    := m_nEsNoList.IndexOf(FsgGrid.Cells[4,i]);
    End;
End;
procedure TTL5Config.ExecSetEventGrid;
Var
    pTbl   :  SEVENTSETTTAGS;
  //  pTable :  SEVENTTAGS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetEventsTable(m_nCurrGroup,pTbl)=True then
    Begin
      FsgGrid.RowCount := pTbl.Count+1;
      for i:=0 to pTbl.Count-1 do
      AddRecordToEventGrid(i,pTbl.Items[i]{,pTable.Items[i]});
    End;
End;
procedure TTL5Config.AddRecordToEventGrid(nIndex:Integer;var pTbl:SEVENTSETTTAG{;var pTable:SEVENTTAG});
Var
    nY : Integer;
    nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    with pTbl do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := IntToStr(m_swGroupID);
     FsgGrid.Cells[2,nY] := IntToStr(m_swEventID);
     FsgGrid.Cells[3,nY] := m_schEventName;
     FsgGrid.Cells[4,nY] := m_nEsNoList.Strings[m_sbyEnable];
    End;
End;
procedure TTL5Config.OnGetAllEvents(Sender: TObject);
begin
    m_nCurrGroup := -1;
    lbBottInfo.Caption := '��� �������';
    ExecSetEventGrid;
end;
procedure TTL5Config.OnGetEv0(Sender: TObject);
begin
    lbBottInfo.Caption := '������ �1';
    m_nCurrGroup := 0;
    ExecSetEventGrid;
end;
procedure TTL5Config.OnGetEv1(Sender: TObject);
begin
    lbBottInfo.Caption := '������ �2';
    m_nCurrGroup := 1;
    ExecSetEventGrid;
end;
procedure TTL5Config.OnGetEv2(Sender: TObject);
begin
    lbBottInfo.Caption := '������ �3';
    m_nCurrGroup := 2;
    ExecSetEventGrid;
end;

procedure TTL5Config.OnGetEv3(Sender: TObject);
begin
    lbBottInfo.Caption := '������ �4';
    m_nCurrGroup := 3;
    ExecSetEventGrid;
end;

procedure TTL5Config.OnLoadFromF(Sender: TObject);
Var
    i : Integer;
Begin
    m_nEventList.Clear;
    if m_nCurrGroup=-1 then exit;
    if m_nCurrGroup=0 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent0.dat');
    if m_nCurrGroup=1 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent1.dat');
    if m_nCurrGroup=2 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent2.dat');
    if m_nCurrGroup=3 then m_nEventList.LoadFromFile(m_strCurrentDir+'SettEvent3.dat');

    for i:=0 to m_nEventList.Count-1 do
    Begin
     FsgGrid.RowCount := m_nEventList.Count+1;
     FsgGrid.Cells[1,i+1] := IntToStr(m_nCurrGroup);
     FsgGrid.Cells[2,i+1] := IntToStr(i);
     FsgGrid.Cells[3,i+1] := m_nEventList.Strings[i];
     FsgGrid.Cells[4,i+1] := '��';
    End;
End;

procedure TTL5Config.OnDelAllEvent(Sender: TObject);
begin
    if m_nCurrGroup=-1 then
    Begin
     if MessageDlg('������� ��� �������?',mtWarning,[mbOk,mbCancel],0)=mrOk then m_pDB.DelEventsTable(m_nCurrGroup);
    End
     else
    if MessageDlg('������� ������� ������?'+IntToStr(m_nCurrGroup),mtWarning,[mbOk,mbCancel],0)=mrOk then m_pDB.DelEventsTable(m_nCurrGroup);
    ExecSetEventGrid;
end;
procedure TTL5Config.SetGenSettings;
Var
    strLoc,strNet : String;
Begin
    OnGetGenData(self);
    OnGetSdl(self);
    if m_pGenTable.m_sbyMode=0     then
    Begin
     m_blIsSlave    := True;
     m_blProtoState := False;
     strNet := 'Slave';
     //SetTexSB(4,'Slave');
    End;
    if m_pGenTable.m_sbyMode=1     then
    Begin
     m_blIsSlave   := False;
     m_blProtoState:= True;
     strNet := 'Master';
     //SetTexSB(4,'Master');
    End;
    if m_pGenTable.m_sbyLocation=0 then
    Begin
     m_blIsLocal   := True;
     strLoc := 'Local';
     //SetTexSB(3,'Local');
    End;
    if m_pGenTable.m_sbyLocation=1 then
    Begin
     m_blIsLocal   := False;
     strLoc := 'Remote';
     //SetTexSB(3,'Remote');
    End;
    m_blIsRemCrc := False;
    m_blIsRemEco := False;
    m_blIsRemC12 := False;
    SetTexSB(4,strNet+':'+strLoc);
End;
procedure TTL5Config.OnSetSettings(Sender: TObject);
Var
    strLoc,strNet : String;
begin
    if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SetInitRemCrcQry;exit; End;
    OnSaveGenData(self);
    OnGetGenData(self);
    if m_pGenTable.m_sbyMode=0     then
    Begin
     m_blIsSlave    := True;
     m_blProtoState := False;
     strNet := 'Slave';
     //SetTexSB(4,'Slave');
    End;
    if m_pGenTable.m_sbyMode=1     then
    Begin
     m_blIsSlave   := False;
     //m_blProtoState:= True;
     strNet := 'Master';
     //SetTexSB(4,'Master');
    End;
    if m_pGenTable.m_sbyLocation=0 then
    Begin
     m_blIsLocal   := True;
     strLoc := 'Local';
     //SetTexSB(3,'Local');
    End;
    if m_pGenTable.m_sbyLocation=1 then
    Begin
     m_blIsLocal   := False;
     strLoc := 'Remote';
     //SetTexSB(3,'Remote');
    End;
    m_blIsRemCrc := False;
    m_blIsRemEco := False;
    m_blIsRemC12 := False;
    SetTexSB(4,strNet+':'+strLoc);
end;
procedure TTL5Config.OnSetRemSettings(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('���������� ��������� ���������?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SETGENSETT_REQ,pDS);
    End;
end;

procedure TTL5Config.OnSetSdl(Sender: TObject);
begin
    SetQueryMask(m_pGenTable);
    m_pDB.AddGenSettTable(m_pGenTable);
    m_nSDL.OnSetSdl(Sender);
end;

procedure TTL5Config.OnGetSdl(Sender: TObject);
begin
    m_nSDL.OnGetSdl(Sender);
end;

procedure TTL5Config.OnGenSdl(Sender: TObject);
begin
    m_nSDL.OnGenSdl;
end;

procedure TTL5Config.OnDelSdl(Sender: TObject);
begin
    m_nSDL.OnDelSdl;
end;

procedure TTL5Config.OnGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nSDL.OnGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTL5Config.OnGetCellType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nSDL.OnGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTL5Config.OnSetMode(Sender: TObject);
begin
    m_nSDL.OnSetMode;
end;
procedure TTL5Config.SchedOn;
Begin

End;
procedure TTL5Config.SchedOff;
Begin

End;
procedure TTL5Config.SchedPause;
Begin
     m_bySchedState := 0;
     if IsScheduler=True then
     //FlbScheduler.Caption := '�����';
End;
procedure TTL5Config.SchedGo;
Begin
     m_bySchedState := 1;
     if IsScheduler=True then
     //FlbScheduler.Caption := '�������';
     //m_nPauseCM := False;
End;
procedure TTL5Config.SchedInit;
Begin
     m_pDB.GetGenSettTable(m_pGenTable);
     m_nSDL.SchedInit;
End;
procedure TTL5Config.SetSettIntValue(strValue:String;nValue:Integer);
Var
    Fl  : TINIFile;
Begin
    try
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\Settings\USPD_Config.ini');
     Fl.WriteInteger('DBCONFIG',strValue,nValue);
     Fl.Destroy;
    except

    end;
End;
procedure TTL5Config.SchedSetAction;
Begin
     m_nSDL.SetAction;
End;
function TTL5Config.IsExport:Boolean;
Begin
     Result := False;
     if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=1) then Result := True;
End;
procedure TTL5Config.Run;
Begin
    {if m_bySchedState=1 then
    if IsScheduler=True then m_nSDL.RunScheduler;
    if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=1) then m_Export2My.RunExport();
    if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=2) then m_Export2DBF.RunExport();
    if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=3) then m_Export2FMAK.RunExport();
    if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=4) then m_ExportMog.RunExport();
    if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=5) then m_ExportVT.RunExport();


    if m_nSDL.m_nGST<>Nil then m_nSDL.m_nGST.Run;
    if m_pGenTable.m_byEnableArchiv=1 then m_nBA.Run;
    if m_blFirstChandge=True then
    Begin
     m_nFirstcount := m_nFirstcount + 1;
     if (m_nFirstcount mod 5)=0 then  m_blFirstChandge:=False;
    End; }
End;
procedure TTL5Config.OnResetAllState(Sender: TObject);
begin
    m_nSDL.OnResetAllState;
end;
procedure OnGlGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);

begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
      begin

      end;

    if ARow=0 then AFont.Style := [fsBold];
    if (ARow<>0) and (ACol<>0)then
     Begin
      if ACol<>0 then
      Begin
         AFont.Color :=  m_blGridDataFontColor;//clAqua;
      End;
     End;
    End;
end;
procedure TTL5Config.OnSetFontClick(Sender: TObject);
Var
    mCL : SCOLORSETTTAG;
begin

    mCL.m_swCtrlID := CL_TREE_CONF;
    m_pDB.GetColorTable(mCL);

    FontDialog1.Font.Name       := mCL.m_sstrFontName;
    FontDialog1.Font.Color      := mCL.m_swColor;
    nSizeFont                   := mCL.m_swFontSize;
    FontDialog1.Font.Size       := mCL.m_swFontSize;
    FontDialog1.Execute;
    Edit1.Text                  := FontDialog1.Font.Name;
    Edit1.Color                 := FontDialog1.Font.Color;
    nSizeFont                   := FontDialog1.Font.Size;
    m_blGridDataFontColor       := FontDialog1.Font.Color;
    m_blGridDataFontSize        := FontDialog1.Font.Size;
    m_blGridDataFontName        := FontDialog1.Font.Name;


    mCL.m_sstrFontName          := FontDialog1.Font.Name;
    mCL.m_swFontSize            := FontDialog1.Font.Size;
    mCL.m_swColor               := FontDialog1.Font.Color;
    m_pDB.AddColorTable(mCL);
    m_nSetColor.SetColorSettings(mCL);
End;
procedure TTL5Config.OnSetColor_PanelClick(Sender: TObject);
Var
    mCL : SCOLORSETTTAG;
begin
    ColorDialog1.Color          := Edit2.Color;
    ColorDialog1.Execute;
    Edit2.Color                 := ColorDialog1.Color;
    // conf
    mCL.m_swCtrlID              := CL_TREE_CONF;
    mCL.m_swColorPanel          := ColorDialog1.Color;
    m_nSetColor.SetColorPPanel(mCL);
    m_nSetColor.SetColorPanel(mCL);
end;
procedure TTL5Config.OnChandgeRemMode(Sender: TObject);
begin
    m_blIsRemCrc := False;
    m_blIsRemEco := False;
    m_blIsRemC12 := False;
    if cbm_sbyLocation.ItemIndex=0 then
    Begin
     m_pGenTable.m_sbyLocation := 0;
     m_blIsLocal := True;
    End else
    if cbm_sbyLocation.ItemIndex=1 then
    Begin
     m_pGenTable.m_sbyLocation := 1;
     m_blIsLocal := False;
    End;
    if cbm_sbyLocation.ItemIndex=2 then
    Begin
     m_pGenTable.m_sbyLocation := 0;
     m_blIsLocal  := True;
     m_blIsRemCrc := True;
    End;
    if cbm_sbyLocation.ItemIndex=3 then
    Begin
     m_pGenTable.m_sbyLocation := 0;
     m_blIsLocal  := True;
     m_blIsRemEco := True;
    End;
    if cbm_sbyLocation.ItemIndex=4 then
    Begin
     m_pGenTable.m_sbyLocation := 0;
     m_blIsLocal  := True;
     m_blIsRemC12 := True;
    End;
end;

procedure TTL5Config.OnSaveEnergoData(Sender: TObject);
Var
    dtDate0,dtDate1 : TDateTime;
begin
    lbGenSettings.Caption := '���-� ������ ��� ��������.��������';
    if MessageDlg('��������� ������ ��������� �����.���������?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     dtDate1 := Now;
     dtDate0 := dtDate1-sem_sExport.Value;

     lbGenSettings.Caption := '������ ��� �������� ������';
    End else lbGenSettings.Caption := '����������� ������ ��������';
end;

procedure TTL5Config.OnChandgeExport(Sender: TObject);
begin
    if cbm_sSetForETelecom.ItemIndex=0 then
    Begin
     sem_sExport.Enabled := False;
     rbm_sButtExport.Enabled := False;
     cbm_ChooseEnergo.Enabled    := False;
    End else
    if cbm_sSetForETelecom.ItemIndex=1 then
    Begin
     sem_sExport.Enabled := True;
     rbm_sButtExport.Enabled := True;
     cbm_ChooseEnergo.Enabled     := True;
    End;
end;

procedure TTL5Config.OnComboChandge(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    m_nSDL.OnComboChandge(Sender,ACol,ARow,AItemIndex,ASelection);
end;

procedure TTL5Config.OnSettTime(Sender: TObject);
Var
    pDS : CMessageData;

begin
    if MessageDlg('���������� �����?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_SYN_REQ,pDS);
     m_pDB.EventFlagCorrector := EVH_COR_TIME_AUTO;
    End;
end;
procedure TTL5Config.OnRepplMdm(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('��������� ����������?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_STOP_SYN_REQ,pDS);
    End;
end;
procedure TTL5Config.OnSetAll(Sender: TObject);
begin
    m_nSDL.OnSetAll;
end;

procedure TTL5Config.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
begin
    m_nSDL.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTL5Config.OnChModem(Sender: TObject);
begin
    if cbm_sUseModem.ItemIndex=0 then
    Begin
     edm_sMdmJoinName.Enabled := False;
     cbm_sChannSyn.Enabled    := False;
    End else
    if cbm_sUseModem.ItemIndex=1 then
    Begin
     edm_sMdmJoinName.Enabled := True;
     cbm_sChannSyn.Enabled    := True;
    End;
end;
procedure TTL5Config.InitComboChannel;
Var
    pTable : SL1INITITAG;
    i      : Integer;
Begin
    cbm_sChannSyn.Items.Clear;
    if m_pDB.GetL1Table(pTable) then
    Begin
     for i:=0 to pTable.Count-1 do
     cbm_sChannSyn.Items.Add(IntToStr(pTable.Items[i].m_sbyPortID)+':'+pTable.Items[i].m_schName);
     cbm_sChannSyn.ItemIndex := 0;
    End;
End;

procedure TTL5Config.OnDropSunChan(Sender, Source: TObject; X, Y: Integer);
begin
    InitComboChannel;
end;

procedure TTL5Config.OnChsynchro(Sender: TObject);
begin
    if cbm_sInterSet.ItemIndex=0 then
    Begin
     cbm_sUseModem.Enabled    := False;
     edm_sMdmJoinName.Enabled := False;
     cbm_sChannSyn.Enabled    := False;
    End else
    if cbm_sInterSet.ItemIndex=1 then
    Begin
     cbm_sUseModem.Enabled    := True;
     OnChModem(self);
    End;
end;

procedure TTL5Config.OnStartCall(Sender: TObject);
begin
    //m_nUMN.OnStartCall;
    m_nSDL.m_nGST.OnConnect;
end;
procedure TTL5Config.OnStopCall(Sender: TObject);
begin
    //m_nUMN.OnStopCall;
    m_nSDL.m_nGST.OnDisconnect;
end;
procedure TTL5Config.OnReBoot(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    FillChar(pDS,sizeof(pDS),0);
   // m_nSDL.m_nGST.OpenSession(30,7);
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='��������� ������������ ����������. ��������?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='��������� ������������ ���������� ����������. ��������?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcReBoot(pDS);exit; End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RBOOT_DATA_REQ,pDS);
    End;
end;

procedure TTL5Config.ReBootPrg;
var
    hproc, htoken: THandle;
    ht      : cardinal;
    luid    : int64;
    luidattr: LUID_AND_ATTRIBUTES;
    priv    : Token_Privileges;
    r   : DWORD;
    res : BOOL;
    dal : LongBool;
    buf : PChar;
begin
    hProc:=GetCurrentProcess;
    hToken:=0;
    OpenProcessToken(hProc, TOKEN_ADJUST_PRIVILEGES, hToken);
    LookupPrivilegeValue(nil, 'SeShutDownPrivilege', luid);
    luidattr.Luid       := luid;
    luidattr.Attributes := SE_PRIVILEGE_ENABLED;
    priv.PrivilegeCount := 1;
    priv.Privileges[0]  := luidattr;
    r:=0;
    res:=AdjustTokenPrivileges(hToken, false, priv, 0, nil, r);
    ExitWindowsEx(EWX_REBOOT+EWX_FORCE,0);
    //ExitWindowsEx(EWX_REBOOT,0);
end;

procedure TTL5Config.SendRemCrcReBoot(pDS:CMessageData);
Var
    m_nTxMsg  : CHMessage;
    FPRID,fnc,wCRC : Word;
Begin
    FPRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6],  4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10], 4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14], 4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18], 4);
    move(pDS.m_swData4,m_nTxMsg.m_sbyInfo[22], 4);
    //CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+1)+4, $FF03);
    //CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+1)+4);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+1)+4, $FF03);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 203;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26);
     m_nTxMsg.m_sbyInfo[26] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+2));
    End;
    if (m_blIsRemC12=True) then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 203;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+2);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+2));
    End;
    FPUT(BOX_L1, @m_nTxMsg);
    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:'+IntToStr(fnc)+':',@m_nTxMsg);
    }
End;

procedure TTL5Config.StyleFormChange(Sender: TObject);
Var
    nIndex : Integer;
begin
    nIndex := StyleForm.ItemIndex;
    if nIndex=-1 then nIndex:=0;
    m_nSetColor.SetAllStyle(nIndex);
    m_nSetColor.SaveStyle(nIndex);
end;

procedure TTL5Config.OnStartTest(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('����������� ������ ��������� �����.���������?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_TST_REQ,pDS);
     if m_blIsLocal=False then SendMSG(BOX_L3_HF,0,DIR_L4TOL3,SL_RES_REM_REQ);
    End;
end;
procedure TTL5Config.OnStopTest(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('���������� �����������?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_STOP_TST_REQ,pDS);
    End;
end;
procedure TTL5Config.OnFillDiagRep(Sender: TObject);
begin
    SendMSG(BOX_L3_HF,0,DIR_L4TOL3,SL_SET_REPRT_REQ);
end;

procedure TTL5Config.OnSetDiagnos(Sender: TObject);
Var
    pGenTable : SGENSETTTAG;
begin
    if m_blIsLocal=False then
    Begin
     m_pDB.GetGenSettTable(pGenTable);
     m_pDB.AddGenSettTable(pGenTable);
     OnSetRemSettings(Sender);
    End else
    if m_blIsLocal=True  then OnSetSettings(Sender);
end;
procedure TTL5Config.OnGetDiaSet(Sender: TObject);
Var
    pGenTable : SGENSETTTAG;
begin
    if m_blIsLocal=False then
    Begin
     m_pDB.GetGenSettTable(pGenTable);
    End else
    if m_blIsLocal=True  then
    Begin
     m_pDB.GetGenSettTable(m_pGenTable);
    End;
end;

procedure TTL5Config.OnSaveGridTTime(Sender: TObject);
begin
    m_nTT.OnSaveGrid;
end;

procedure TTL5Config.OnSetGridTTime(Sender: TObject);
begin
    m_nTT.OnSetGrid;
end;

procedure TTL5Config.OnAddTTime(Sender: TObject);
begin
    m_nTT.OnAddRow;
end;

procedure TTL5Config.OnCloneTTime(Sender: TObject);
begin
    m_nTT.OnCloneRow;
end;

procedure TTL5Config.OnDellRowTTime(Sender: TObject);
begin
    m_nTT.OnDelRow;
end;

procedure TTL5Config.OnDelAllRowTTime(Sender: TObject);
begin
    m_nTT.OnDelAllRow;
end;

procedure TTL5Config.OnClickTTimeGrid(Sender: TObject; ARow,
  ACol: Integer);
begin
    m_nTT.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTL5Config.OnChannelGetCellTTIimeType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nTT.OnTTimeGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTL5Config.OnMDownTTime(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    m_nTT.OnMDown(Sender,Button,Shift,X,Y);
end;

procedure TTL5Config.OnLoadModule(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='������� ���������?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='������� ��������� ��������?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_TMSST_INIT_REQ,pDS);

    //if m_blCL3TariffEditor=True  then m_pDB.FixUspdEvent(0,3,EVU_TZONE_ED_ON) else
    //if m_blCL3TariffEditor=False then m_pDB.FixUspdEvent(0,3,EVU_TZONE_ED_OF);
end;

procedure TTL5Config.OSdlInit(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='������� ���������?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='������� ��������� ��������?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SHLST_INIT_REQ,pDS);
end;

procedure TTL5Config.OnSetEditTTime(Sender: TObject);
begin
    m_nTT.OnSetMode;
end;

procedure TTL5Config.OnCloseConf(Sender: TObject;
  var Action: TCloseAction);
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_CLOS_INIT,0);
end;

procedure TTL5Config.OnStartFh(Sender: TObject);
Var
   dwLoMask : int64;
   dwOne    : int64;
   ldtFTime,ldtETime : TDateTime;
   pDS      : CMessageData;
   szDT     : Integer;
   str      : String;
begin
   dwLoMask := 0;
   dwOne    := 1;
   szDT     := sizeof(TDateTime);
   if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='��������� ����� ������?';End;
   if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='��������� ����� ������ ��������?';End;
   if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin

    pDS.m_swData0 := -1;
    pDS.m_swData1 := -1;

    move(ldtFTime,pDS.m_sbyInfo[0], szDT);
    move(ldtETime,pDS.m_sbyInfo[szDT], szDT);
    move(dwLoMask,pDS.m_sbyInfo[2*szDT], sizeof(int64));
    if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcFind(pDS);exit; End;
    SendMsgData(BOX_L3_LME, 0, DIR_LHTOLM3, QL_START_FH_REQ, pDS);
   End;
end;
procedure TTL5Config.SendRemCrcFind(pDS:CMessageData);
Var
    m_nTxMsg  : CHMessage;
    FPRID,fnc : Word;
    szDT      : Integer;
Begin
    FPRID := 0;
    szDT  := sizeof(TDateTime);
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[6],szDT);
    move(pDS.m_sbyInfo[szDT],m_nTxMsg.m_sbyInfo[6+szDT],szDT);
    move(pDS.m_sbyInfo[2*szDT],m_nTxMsg.m_sbyInfo[6+2*szDT],sizeof(int64));
    CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (30+1)+4, $FF06);
    CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (30+1)+4);
    FPUT(BOX_L1, @m_nTxMsg);
    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:'+IntToStr(fnc)+':',@m_nTxMsg);
    }
End;


procedure TTL5Config.OnChandgeQueryMode(Sender: TObject);
begin
   if cbm_sQryScheduler.ItemIndex=2 then
   cbm_sPrePoolGraph.ItemIndex := 0;
end;

procedure TTL5Config.OnClickCurr(Sender: TObject);
begin
    if cbm_byCurrent.Checked=True then
    Begin
     cbm_bySumEn.Enabled:= True;
     cbm_byMAP.Enabled  := True;
     cbm_byMRAP.Enabled := True;
     cbm_byU.Enabled    := True;
     cbm_byI.Enabled    := True;
     cbm_byFreq.Enabled := True;
    End else
    if cbm_byCurrent.Checked=False then
    Begin
     cbm_bySumEn.Enabled:= False;
     cbm_byMAP.Enabled  := False;
     cbm_byMRAP.Enabled := False;
     cbm_byU.Enabled    := False;
     cbm_byI.Enabled    := False;
     cbm_byFreq.Enabled := False;
    End;
end;

procedure TTL5Config.OnClickAEN(Sender: TObject);
begin
    if cbm_nArchEN.Checked=True then
    Begin
     cbm_nPriDayF.Enabled   := True;
     cbm_nPriMonthF.Enabled := True;
     cbm_nPri30F.Enabled    := True;
     cbm_nNakDayF.Enabled   := True;
     cbm_nNakMonthF.Enabled := True;
    End else
    if cbm_nArchEN.Checked=False then
    Begin
     cbm_nPriDayF.Enabled   := False;
     cbm_nPriMonthF.Enabled := False;
     cbm_nPri30F.Enabled    := False;
     cbm_nNakDayF.Enabled   := False;
     cbm_nNakMonthF.Enabled := False;
    End;
end;

procedure TTL5Config.OnClickEvent(Sender: TObject);
begin
    //cbm_byJEn
    if cbm_byJEn.Checked=True then
    Begin
     cbm_byJ0.Enabled := True;
     cbm_byJ1.Enabled := True;
     cbm_byJ2.Enabled := True;
     cbm_byJ3.Enabled := True;
    End else
    if cbm_byJEn.Checked=False then
    Begin
     cbm_byJ0.Enabled := False;
     cbm_byJ1.Enabled := False;
     cbm_byJ2.Enabled := False;
     cbm_byJ3.Enabled := False;
    End;
end;

procedure TTL5Config.OnClickANetEN(Sender: TObject);
begin
    if cbm_byPNetEn.Checked=True then
    Begin
     cbm_byPNetU.Enabled  := True;
     cbm_byPNetI.Enabled  := True;
     cbm_byPNetFi.Enabled := True;
     cbm_byPNetCosFi.Enabled := True;
     cbm_byPNetF.Enabled  := True;
     cbm_byPNetP.Enabled  := True;
     cbm_byPNetQ.Enabled  := True;
    End else
    if cbm_byPNetEn.Checked=False then
    Begin
     cbm_byPNetU.Enabled  := False;
     cbm_byPNetI.Enabled  := False;
     cbm_byPNetFi.Enabled := False;
     cbm_byPNetCosFi.Enabled := False;
     cbm_byPNetF.Enabled  := False;
     cbm_byPNetP.Enabled  := False;
     cbm_byPNetQ.Enabled  := False;
    End;
end;

procedure TTL5Config.OnClickQweryTree(Sender: TObject);
begin
    m_nSDL.OnClickQweryTree;
end;

procedure TTL5Config.ab_DBFStartClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_OF,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='������ ��������...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='������ ���������� ��������...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DT_ON_REQ,pDS);
end;

procedure TTL5Config.ab_DBFStopClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_OF,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='������� ��������...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='������� ���������� ��������...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DT_OF_REQ,pDS);
end;

procedure TTL5Config.OnDbfOpenPath(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
end;

 
threadvar
  myDir: string;

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM): integer; stdcall;
begin 
  Result := 0; 
  if uMsg = BFFM_INITIALIZED then 
    SendMessage(hwnd, BFFM_SETSELECTION, 1, LongInt(PChar(myDir))); 
end;
 
function SelectDirPlus(hWnd: HWND; const Caption: string; const Root: WideString): String;
// ������ ������ ���������� � ������� "������� �����" 
var 
  WindowList: Pointer; 
  BrowseInfo : TBrowseInfo; 
  Buffer: PChar; 
  RootItemIDList, ItemIDList: PItemIDList; 
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord; 
  Cmd: Boolean; 
begin 
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0); 
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try 
      RootItemIDList := nil; 
      if Root <> '' then begin 
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(hWnd, nil,
        POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := hWnd;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpfn := @BrowseCallbackProc;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS or $0040 or BIF_EDITBOX or BIF_STATUSTEXT;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      Cmd :=  ItemIDList <> nil;
      if Cmd then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Result:= Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

procedure TTL5Config.OnChandgeIP0;
begin
    ModemPrepare;
end;
procedure TTL5Config.ModemPrepare;
Var
    Fl : TINIFile;
    str,strF : String;
    nPos:Integer;
Begin
    Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\Settings\USPD_Config.ini');
    str := m_strMDMPrep;
    nPos := Pos(':::',str);
    while nPos<>0 do
    Begin
     strF := Copy(str,0,nPos-1);
     Delete(str,1,nPos+2);
     nPos := Pos(':::',str);
     m_nCF.m_nSDL.m_nGST.SendCommand(strF);
     Sleep(500);
    End;
    Fl.Destroy;
End;

procedure TTL5Config.OnDropSunChan1(Sender: TObject);
begin
    InitComboChannel;
end;
procedure TTL5Config.SelfStop;
Var
    wnd : HWND;
Begin
    wnd := FindWindow(LPCTSTR('TTKnsMonitor'), nil);
    if wnd <> 0 then SendMessage(wnd,WM_SENDTOMONITORSTOP, 0, 0);
End;

procedure TTL5Config.OnQweryReboot;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //��������� ������� ������ ������
    if MessageDlg('������������� ��������� � ���� ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 12;
     m_nTxMsg.m_sbyInfo[7] := 1;
     if m_blIsRemCrc=True then
     Begin
      CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF18);
      CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+1)+4);
     End else
     if m_blIsRemEco=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := 213;
      wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
      m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
      m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
      CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
     End;
     if m_blIsRemC12=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := $FA;
      m_nTxMsg.m_sbyInfo[2] := 213;
      CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
      CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
     End;
     {
     if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
     begin
       //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
       exit;
     end;
     fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
     }
     TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
     FPUT(BOX_L1, @m_nTxMsg);
    End;
End;

procedure TTL5Config.btnOpenSessionClick(Sender: TObject);
var pDS         : CMessageData;
    sec, Speed  : integer;
begin
   if MessageDlg('���������� ��������� ����� �� ' +
                  cbOpenSessionTime.Items[cbOpenSessionTime.ItemIndex] + ' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
     case cbOpenSessionTime.ItemIndex of
       0 : sec := 60;
       1 : sec := 120;
       2 : sec := 300;
       3 : sec := 600;
       4 : sec := 1800;
       5 : sec := 3600;
       6 : sec := 7200;
       else
       sec := 180;
     end;
             Speed := m_nInterSpeed;
     pDS.m_swData0 := 14;
     pDS.m_swData1 := sec;
     pDS.m_swData2 := Speed;
     pDS.m_swData3 := 0;
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(0,pDS);exit; End;


     m_nCF.m_nSDL.m_nGST.OpenSession(pDS.m_swData1,pDS.m_swData2);
   End;
end;
procedure TTL5Config.SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    FPRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6], 4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10],4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14],4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18],4);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[26],sizeof(TDateTime)*2);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF18);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 213;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
     m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
    End;
    if m_blIsRemC12=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 213;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
    End;

    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    }
    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
    FPUT(BOX_L1, @m_nTxMsg);
End;

procedure TTL5Config.OnChSesion(Sender: TObject);
begin
     m_nCF.m_nSDL.m_nGST.ChandgeSessionTime(GetSessionTime(cbOpenSessionTime.ItemIndex));
end;
function TTL5Config.GetSessionTime(nIndex:Integer):Dword;
Var
     sec : Integer;
Begin
     case nIndex of
       0 : sec := 60;
       1 : sec := 120;
       2 : sec := 300;
       3 : sec := 600;
       4 : sec := 1800;
       5 : sec := 3600;
       6 : sec := 7200;
       7 : sec := 24*3600;
       else
       sec := 180;
     end;
     Result := sec;
end;

procedure TTL5Config.SetInitRemCrcQry;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //��������� ������� ������ ������
    if MessageDlg('���������������� ������������ ����? ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 3;
     m_nTxMsg.m_sbyInfo[7] := 0;
     if m_blIsRemCrc=True then
     Begin
      CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF18);
      CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+1)+4);
     End else
     if m_blIsRemEco=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := 213;
      wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
      m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
      m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
      CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
     End;
     if m_blIsRemC12=True then
     Begin
      m_nTxMsg.m_sbyInfo[0] := 1;
      m_nTxMsg.m_sbyInfo[1] := $FA;
      m_nTxMsg.m_sbyInfo[2] := 213;
      CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
      CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
     End;
     {
     if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
     begin
       //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
       exit;
     end;
     fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
     }
     TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
     FPUT(BOX_L1, @m_nTxMsg);
    End;
End;

procedure TTL5Config.OnSendReload(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    FillChar(pDS,sizeof(pDS),0);
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='������������� ���������� ����. ��������?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='������������� ��������� ���������� ����. ��������?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     //if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin OnQweryReboot;exit;End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RELOAD_USPRO_REQ,pDS);
    End;
End;
procedure TTL5Config.SelfReload;
Var
    wnd : HWND;
Begin
    wnd := FindWindow(LPCTSTR('TTKnsMonitor'), nil);
    if wnd <> 0 then SendMessage(wnd,WM_SENDTOMNRELOAD, 0, 0);
End;

destructor TTL5Config.Destroy;
begin
  if m_nSDL <> nil then FreeAndNil(m_nSDL);
//  if m_nUMN <> nil then FreeAndNil(m_nUMN);
  if m_nTT <> nil then FreeAndNil(m_nTT);
  if m_nSetColor <> nil then FreeAndNil(m_nSetColor);
  if m_nUsrCtrl <> nil then FreeAndNil(m_nUsrCtrl);
//  if m_nBA <> nil then FreeAndNil(m_nBA);
  if m_nEventList <> nil then FreeAndNil(m_nEventList);
  inherited;
end;

end.
