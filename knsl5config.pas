unit knsl5config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,FileCtrl,
  ShlObj, ActiveX, StdCtrls, AdvToolBar, AdvToolBarStylers,
  AdvAppStyler, AdvPanel, AdvOfficePager, AdvOfficePagerStylers, Menus,
  ImgList, AdvProgressBar, GradientLabel, AdvOfficeButtons, Grids,
  BaseGrid, AdvGrid, RbDrawCore, RbButton, Spin, ComCtrls, ExtCtrls,
  ToolWin, jpeg,
  utltypes,utldatabase, utlbox,
  knsl5tracer,utlconst,knsl3qryschedlr,knsl5setcolor,knsl3setenergo,
  Gauges,knsl3updatemanager,utlTimeDate,ShellAPI, asgcombo, ColorCombo,
  AdvCombo, ColCombo,AdvStyleIF,
  knsl3transtime,
  knsl3setenergomoz,inifiles,
  knsl3ExportMySQLModule, knsl3ExportDBFModule,knsl3ExportMogModule,knsl3ExportDBMaket,
  knsl3archive, Db, DBTables, knsl3UserControl, AdvGlowButton, AdvMenus,
  AdvMenuStylers, WinSvc, Registry, paramchklist, knsl3ExportVTModule;

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
    TabSheet3: TAdvOfficePage;
    GroupBox12: TGroupBox;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label46: TLabel;
    Label42: TLabel;
    edm_nUpdatePath: TEdit;
    RbButton3: TRbButton;
    cbm_nIsRemLink: TComboBox;
    edm_nIsRemLink: TEdit;
    edm_nLoadUpdate: TEdit;
    edm_nUnpackUpdate: TEdit;
    edm_nCopyUpdate: TEdit;
    edm_nRemLinkState: TEdit;
    edm_nDestPath: TEdit;
    edm_nStartProgramm: TEdit;
    AdvPanel7: TAdvPanel;
    AdvToolBar1: TAdvToolBar;
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
    tsDiagnose: TAdvOfficePage;
    GradientLabel1: TGradientLabel;
    pbm_sTestProgress: TAdvProgressBar;
    lbm_sTestProgress: TGradientLabel;
    GradientLabel7: TGradientLabel;
    Label61: TLabel;
    Label63: TLabel;
    chm_sStPhChannel: TAdvOfficeCheckBox;
    AdvPanel1: TAdvPanel;
    AdvToolBar6: TAdvToolBar;
    chm_sStModem: TAdvOfficeCheckBox;
    chm_sStMeters: TAdvOfficeCheckBox;
    chm_sTimeRout: TAdvOfficeCheckBox;
    chm_sTransError: TAdvOfficeCheckBox;
    chm_sStArm: TAdvOfficeCheckBox;
    chm_sAmPhChannel: TAdvOfficeCheckBox;
    chm_sAmModem: TAdvOfficeCheckBox;
    chm_sAmMeters: TAdvOfficeCheckBox;
    chm_sAmArm: TAdvOfficeCheckBox;
    chm_sFatalError: TAdvOfficeCheckBox;
    chm_sVerNo: TAdvOfficeCheckBox;
    GroupBox14: TGroupBox;
    cbm_nPriDay: TAdvOfficeCheckBox;
    cbm_nPriMonth: TAdvOfficeCheckBox;
    cbm_nPri30: TAdvOfficeCheckBox;
    cbm_nNakDay: TAdvOfficeCheckBox;
    cbm_nNakMonth: TAdvOfficeCheckBox;
    dtETime: TDateTimePicker;
    dtFTime: TDateTimePicker;
    aop_ExportMy: TAdvOfficePage;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label45: TLabel;
    mMySQLECmpl: TLabel;
    mMySQLENext: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label51: TLabel;
    Label56: TLabel;
    GradientLabel3: TGradientLabel;
    GradientLabel4: TGradientLabel;
    Label25: TLabel;
    Label50: TLabel;
    AdvPanel9: TAdvPanel;
    AdvToolBar8: TAdvToolBar;
    mysqlSERVER: TEdit;
    mysqlDATABASE: TEdit;
    mysqlUSER: TEdit;
    mysqlPASSW: TEdit;
    mMySQLStat: TMemo;
    mysqlPORT: TEdit;
    edm_sArchPath: TEdit;
    cbm_byEnableArchiv: TComboBox;
    cbm_tmArchPeriod: TComboBox;
    GroupBox15: TGroupBox;
    edm_sSrcPath: TEdit;
    RbButton5: TRbButton;
    RbButton4: TRbButton;
    tmm_dtEnterArchTime: TDateTimePicker;
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
    aop_ExportDBF: TAdvOfficePage;
    Label65: TLabel;
    AdvPanel8: TAdvPanel;
    AdvToolBar7: TAdvToolBar;
    em_strPath: TEdit;
    cbm_byRecalc: TAdvOfficeCheckBox;
    AdvOfficePage1: TAdvOfficePage;
    Label66: TLabel;
    edm_swGate: TEdit;
    cbOpenSessionTime: TComboBox;
    Label67: TLabel;
    lbSExpired: TLabel;
    AdvPanel10: TAdvPanel;
    AdvToolBar9: TAdvToolBar;
    edm_sMAKLOCATION: TEdit;
    Label68: TLabel;
    Label69: TLabel;
    dtLoTime: TDateTimePicker;
    Label70: TLabel;
    Label71: TLabel;
    dtHiTime: TDateTimePicker;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    lbExportNexTime: TLabel;
    lbExportTimeNext: TLabel;
    Label76: TLabel;
    lbExportTime: TLabel;
    dtm_dtEStart: TDateTimePicker;
    cbm_nEInt: TComboBox;
    Label75: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    edm_sPASSMAK: TEdit;
    cbPASSMAK: TCheckBox;
    edm_sHOSTMAK: TEdit;
    edm_sEMAILMAK: TEdit;
    edm_sNAMEMAILMAK: TEdit;
    Label79: TLabel;
    cbm_blMdmExp: TCheckBox;
    cbM_BLFMAKDELFILE: TCheckBox;
    cbm_blExportLast: TCheckBox;
    //Label76: TLabel;
    lbExportStatus: TLabel;
    pmMainData: TAdvPopupMenu;
    pmMainTime: TAdvPopupMenu;
    ppMainSystem: TAdvPopupMenu;
    few1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    IP1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    AdvGlowMenuButton3: TAdvGlowMenuButton;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    AdvGlowMenuButton2: TAdvGlowMenuButton;
    pmTimeData: TAdvPopupMenu;
    pmTimeEdit: TAdvPopupMenu;
    pmTimeManag: TAdvPopupMenu;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    AdvGlowMenuButton4: TAdvGlowMenuButton;
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
    pmUpdateData: TAdvPopupMenu;
    pmUpdateConn: TAdvPopupMenu;
    pmUpdateContr: TAdvPopupMenu;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    AdvGlowMenuButton13: TAdvGlowMenuButton;
    AdvGlowMenuButton14: TAdvGlowMenuButton;
    AdvGlowMenuButton15: TAdvGlowMenuButton;
    pmDiagnData: TAdvPopupMenu;
    pmDiagnCtrl: TAdvPopupMenu;
    pmDiagnRep: TAdvPopupMenu;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    AdvGlowMenuButton16: TAdvGlowMenuButton;
    AdvGlowMenuButton17: TAdvGlowMenuButton;
    AdvGlowMenuButton18: TAdvGlowMenuButton;
    pmExportData: TAdvPopupMenu;
    pmExportArch: TAdvPopupMenu;
    pmExportControl: TAdvPopupMenu;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    AdvGlowMenuButton19: TAdvGlowMenuButton;
    AdvGlowMenuButton20: TAdvGlowMenuButton;
    AdvGlowMenuButton21: TAdvGlowMenuButton;
    pmExportDBFData: TAdvPopupMenu;
    pmExportDBFExp: TAdvPopupMenu;
    pmExportDBFCntrl: TAdvPopupMenu;
    miDBFSave: TMenuItem;
    miDBFLoad: TMenuItem;
    miHandExport: TMenuItem;
    miDBFEnable: TMenuItem;
    miDBFDisable: TMenuItem;
    pmMaketData: TAdvPopupMenu;
    pmMaketCtrl: TAdvPopupMenu;
    pmMaketExp: TAdvPopupMenu;
    advOnSaveDBF: TAdvGlowMenuButton;
    advOnHandExport: TAdvGlowMenuButton;
    advOnSetDBF: TAdvGlowMenuButton;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    AdvGlowMenuButton25: TAdvGlowMenuButton;
    AdvGlowMenuButton26: TAdvGlowMenuButton;
    AdvGlowMenuButton27: TAdvGlowMenuButton;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    N75: TMenuItem;
    clm_strAbons: TParamCheckList;
    Label80: TLabel;
    chm_swDayMask: TCheckBox;
    chm_sdwMonthMask: TCheckBox;
    clm_swDayMask: TParamCheckList;
    clm_sdwMonthMask: TParamCheckList;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    dtm_sdtBegin: TDateTimePicker;
    dtm_sdtEnd: TDateTimePicker;
    dtm_sdtPeriod: TDateTimePicker;
    chm_sbyEnable: TCheckBox;
    lbDeepFind: TLabel;
    cbm_snDeepFind: TComboBox;
    advDBFAbonClear: TAdvGlowButton;
    N5: TMenuItem;
    miOnSetDBF: TMenuItem;
    AdvGlowButton1: TAdvGlowButton;
    em_strPath1: TEdit;
    Label18: TLabel;
    AdvGlowButton2: TAdvGlowButton;
    cbm_nUnlPower: TCheckBox;
    cbm_nMaxUtro: TCheckBox;
    cbm_nMaxVech: TCheckBox;
    cbm_nMaxDay: TCheckBox;
    cbm_nMaxNoch: TCheckBox;
    cbm_nMaxTar: TCheckBox;
    cbm_nExpTret: TCheckBox;
    N63: TMenuItem;
    miStartGprs: TMenuItem;
    miStopGprs: TMenuItem;
    Label62: TLabel;
    cbM_NSESSIONTIME: TComboBox;
    Label64: TLabel;
    cbm_sCalendOn: TComboBox;
    Label84: TLabel;
    Label85: TLabel;
    Label49: TLabel;
    Label58: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    chm_swDayMaskMy: TCheckBox;
    cbm_snDeepFindMy: TComboBox;
    dtm_sdtBeginMy: TDateTimePicker;
    dtm_sdtEndMy: TDateTimePicker;
    dtm_sdtPeriodMy: TDateTimePicker;
    clm_swDayMaskMy: TParamCheckList;
    clm_sdwMonthMaskMy: TParamCheckList;
    chm_sbyEnableMy: TCheckBox;
    GradientLabel5: TGradientLabel;
    chm_sdwMonthMaskMy: TCheckBox;
    chm_sbyFindDataMy: TCheckBox;
    mysqlSDate: TDateTimePicker;
    mysqlEDate: TDateTimePicker;
    Label43: TLabel;
    Label44: TLabel;
    cbEnPassw: TCheckBox;
    GPRS1: TMenuItem;
    b_ExportDataByt: TMenuItem;
    clm_strMyAbons: TParamCheckList;
    AdvOfficePage3: TAdvOfficePage;
    Label88: TLabel;
    em_strPathMg: TEdit;
    Label89: TLabel;
    em_strPathMg1: TEdit;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    cbm_snDeepFindMg: TComboBox;
    dtm_sdtBeginMg: TDateTimePicker;
    dtm_sdtEndMg: TDateTimePicker;
    dtm_sdtPeriodMg: TDateTimePicker;
    chm_swDayMaskMg: TCheckBox;
    chm_sdwMonthMaskMg: TCheckBox;
    Label94: TLabel;
    AdvGlowButton5: TAdvGlowButton;
    clm_swDayMaskMg: TParamCheckList;
    clm_sdwMonthMaskMg: TParamCheckList;
    clm_strAbonsMg: TParamCheckList;
    chm_sbyEnableMg: TCheckBox;
    AdvToolBar10: TAdvToolBar;
    AdvGlowMenuButton22: TAdvGlowMenuButton;
    AdvGlowMenuButton23: TAdvGlowMenuButton;
    AdvGlowMenuButton24: TAdvGlowMenuButton;
    pmExportDBFDataMg: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    pmExportDBFExpMg: TAdvPopupMenu;
    MenuItem3: TMenuItem;
    pmExportDBFCntrlMg: TAdvPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    mgsqlEDate: TDateTimePicker;
    Label96: TLabel;
    mgsqlSDate: TDateTimePicker;
    Label95: TLabel;
    Label97: TLabel;
    N64: TMenuItem;
    aop_ExportVitebsk: TAdvOfficePage;
    pmExportDBFDataVT: TAdvPopupMenu;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    pmExportDBFExpVT: TAdvPopupMenu;
    MenuItem10: TMenuItem;
    pmExportDBFCntrlVT: TAdvPopupMenu;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    Label98: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    AdvPanel11: TAdvPanel;
    AdvToolBar11: TAdvToolBar;
    advVTOnSaveDBF: TAdvGlowMenuButton;
    advVTOnHandExport: TAdvGlowMenuButton;
    advVTOnSetDBF: TAdvGlowMenuButton;
    em_strVTPath: TEdit;
    dtm_sdtVTBegin: TDateTimePicker;
    dtm_sdtVTEnd: TDateTimePicker;
    dtm_sdtVTPeriod: TDateTimePicker;
    cbm_snVTDeepFind: TComboBox;
    AdvGlowButton7: TAdvGlowButton;
    em_strVTPath1: TEdit;
    AdvGlowButton8: TAdvGlowButton;
    cbm_nVTUnlPower: TCheckBox;
    cbm_nVTMaxUtro: TCheckBox;
    cbm_nVTMaxVech: TCheckBox;
    cbm_nVTMaxDay: TCheckBox;
    cbm_nVTMaxNoch: TCheckBox;
    cbm_nVTMaxTar: TCheckBox;
    cbm_nVTExpTret: TCheckBox;
    Label99: TLabel;
    clm_strVTAbons: TParamCheckList;
    chm_swVTDayMask: TCheckBox;
    chm_sdwVTMonthMask: TCheckBox;
    clm_swVTDayMask: TParamCheckList;
    clm_sdwVTMonthMask: TParamCheckList;
    advDBFVTAbonClear: TAdvGlowButton;
    chm_sbyVTEnable: TCheckBox;



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
    procedure OnStartReload(Sender: TObject);
    procedure OnChandgeConn(Sender: TObject);
    procedure OnOpenUpdateFile(Sender: TObject);
    procedure OnStartCopy(Sender: TObject);
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
    procedure OnStart(Sender: TObject);
    procedure OnPause(Sender: TObject);
    procedure OSdlInit(Sender: TObject);
    procedure SchedInit;
    procedure SetSettIntValue(strValue:String;nValue:Integer);
    procedure OnSetEditTTime(Sender: TObject);
    procedure OnCloseConf(Sender: TObject; var Action: TCloseAction);
    procedure b_ExportConnClick(Sender: TObject);
    procedure b_ExportPingClick(Sender: TObject);
    procedure b_ExportSysClick(Sender: TObject);
    procedure b_ExportDisconnClick(Sender: TObject);
    procedure b_ExportEdClick(Sender: TObject);
    procedure b_ExportDataClick(Sender: TObject);
    procedure b_ExportWClick(Sender: TObject);
//    procedure cbm_ChooseEnergoChange(Sender: TObject);
    procedure b_ExportRClick(Sender: TObject);
    procedure mMySQLStatDblClick(Sender: TObject);
    procedure b_ExportOffClick(Sender: TObject);
    procedure b_ExportOnClick(Sender: TObject);
    procedure b_ExportInitClick(Sender: TObject);
    procedure OnHandArchive(Sender: TObject);
    procedure OnOpenArchSource(Sender: TObject);
    procedure OnDestArchPath(Sender: TObject);
    procedure AdvToolBarButton40Click(Sender: TObject);
    procedure OnStartFh(Sender: TObject);
    procedure OnChFTime(Sender: TObject);
    procedure OnChEtime(Sender: TObject);
    procedure OnChandgeQueryMode(Sender: TObject);
    procedure OnClickCurr(Sender: TObject);
    procedure OnClickAEN(Sender: TObject);
    procedure OnClickEvent(Sender: TObject);
    procedure OnClickANetEN(Sender: TObject);
    procedure OnClickQweryTree(Sender: TObject);
    procedure ab_DBFExportClick(Sender: TObject);

    procedure ab_VTExportClick(Sender: TObject);

    procedure ab_DBFStartClick(Sender: TObject);
    procedure ab_DBFStopClick(Sender: TObject);
    procedure OnDbfOpenPath(Sender: TObject);
    procedure ab_DBFConfSaveClick(Sender: TObject);

    procedure VTOnDbfOpenPath(Sender: TObject);
    procedure VTOnDbfOpenPath1(Sender: TObject);
    procedure ab_VTConfSaveClick(Sender: TObject);

    procedure ab_DBFEModeClick(Sender: TObject);
    procedure OnGetEv3(Sender: TObject);
    procedure OnChandgeIPClick(Sender: TObject);
    procedure OnDropSunChan1(Sender: TObject);
    procedure OnCloseUspd(Sender: TObject);
    procedure btnOpenSessionClick(Sender: TObject);
    procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    procedure OnChSesion(Sender: TObject);
    procedure OnSmartFinder(Sender: TObject);
    procedure OffSmartFinder(Sender: TObject);
    procedure SetInitRemCrcQry;
    procedure OnSqlQwery(Sender: TObject);
    procedure OnExportFMAK(Sender: TObject);
    procedure OnStartFMAK(Sender: TObject);
    procedure OnStopFMAK(Sender: TObject);
    procedure OnEditFMAK(Sender: TObject);
    procedure cbPASSMAKClick(Sender: TObject);
    procedure OnUpdateArm(Sender: TObject);
    procedure OnSendReload(Sender: TObject);
    procedure miHandExportClick(Sender: TObject);
    procedure miDBFLoadClick(Sender: TObject);
    procedure miDBFEnableClick(Sender: TObject);
    procedure miDBFDisableClick(Sender: TObject);
    procedure advDBFAbonClearClick(Sender: TObject);

    procedure miHandVTExportClick(Sender: TObject);
    procedure miVTLoadClick(Sender: TObject);
    procedure miVTEnableClick(Sender: TObject);
    procedure miVTDisableClick(Sender: TObject);
    procedure advVTAbonClearClick(Sender: TObject);
    procedure chm_sdwVTMonthMaskClick(Sender: TObject);
    procedure chm_swVTDayMaskClick(Sender: TObject);

    procedure chm_sdwMonthMaskClick(Sender: TObject);
    procedure chm_swDayMaskClick(Sender: TObject);
    procedure miOnSetDBFClick(Sender: TObject);
    procedure advOnSaveDBFClick(Sender: TObject);
    procedure advOnSetDBFClick(Sender: TObject);
    procedure advOnHandExportClick(Sender: TObject);

    procedure miVTOnSetDBFClick(Sender: TObject);
    procedure advVTOnSaveDBFClick(Sender: TObject);
    procedure advVTOnSetDBFClick(Sender: TObject);
    procedure advVTOnHandExportClick(Sender: TObject);
    procedure OnVTOpenPath1(Sender: TObject);
    procedure cbm_nVTUnlPowerClick(Sender: TObject);

    procedure OnDbfOpenPath1(Sender: TObject);
    procedure cbm_nUnlPowerClick(Sender: TObject);
    procedure miStartGprsClick(Sender: TObject);
    procedure miStopGprsClick(Sender: TObject);
    procedure chm_swDayMaskMyClick(Sender: TObject);
    procedure chm_sdwMonthMaskMyClick(Sender: TObject);
    procedure chm_sbyFindDataMyClick(Sender: TObject);
    procedure mysqlEDateChange(Sender: TObject);
    procedure cbEnPasswClick(Sender: TObject);
    procedure GPRS1Click(Sender: TObject);
    procedure b_ExportDataBytClick(Sender: TObject);
    procedure ab_DBFConfSaveClickMg(Sender: TObject);
    procedure miDBFLoadClickMg(Sender: TObject);
    procedure miHandExportClickMg(Sender: TObject);
    procedure miDBFEnableClickMg(Sender: TObject);
    procedure miDBFDisableClickMg(Sender: TObject);
    procedure miOnSetDBFClickMg(Sender: TObject);
    procedure OnDbfOpenPathMg(Sender: TObject);
    procedure OnDbfOpenPathMg1(Sender: TObject);
    procedure advDBFAbonClearClickMg(Sender: TObject);
    procedure chm_swDayMaskClickMg(Sender: TObject);
    procedure chm_sdwMonthMaskClickMg(Sender: TObject);
    procedure mgsqlEDateChange(Sender: TObject);
    procedure miHandExportPeriodMg(Sender: TObject);
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
    FlbOnTransTime  : PTStaticText;
    FlbOnTransState : PTStaticText;
    FlbSExpired     : PTStaticText;
    Description     : extended;
    FConfifTbl      : PSGENSETTTAG;
    procedure InitComboChannel;
    procedure GetGridRecord(var pTbl:SEVENTSETTTAG);
    procedure ExecSetEventGrid;
    procedure AddRecordToEventGrid(nIndex:Integer;var pTbl:SEVENTSETTTAG{;var pTable:SEVENTTAG});
    procedure SetSelfTestConfig(var pTbl:SGENSETTTAG);
    procedure GetSelfTestConfig(var pTbl:SGENSETTTAG);
    procedure SetQueryMask(var pTbl:SGENSETTTAG);
    procedure GetQueryMask(var pTbl:SGENSETTTAG);
    procedure SendRemCrcReBoot(pDS:CMessageData);
    procedure SendRemCrcFind(pDS:CMessageData);
    procedure OnQweryReboot;
    function  ServiceStart(aMachine, aServiceName: string ): boolean;
    function  ServiceStop(aMachine,aServiceName: string ): boolean;
    function  ServiceGetStatus(sMachine, sService: string ): DWord;
    function  StartProcess(strPath:String;blWait:Boolean):Boolean;
    function  GetSessionTime(nIndex:Integer):Dword;

  public
    m_nSDL          : CQryScheduler;
    m_nUMN          : CUpdateManager;
    m_nTT           : CTransTime;
    m_nSetColor     : CSetColor;
    //m_nTTracer      : TTracer;
    m_Export2My     : CL3Export2MySQLModule;    { MYSQL Exporter}
    m_Export2DBF    : CL3Export2DBFModule;      { DBF Exporter}
    m_ExportMog     : CL3ExportMogModule;      { DOS Exporter}
    m_ExportVT      : CL3ExportVTModule;      { DBF Exporter}
    m_Export2FMAK   : CL3Export2DBMaket;
    m_nBA           : CArchiveBase;
    m_nUsrCtrl      : CUserControlClass;
    m_blFirstChandge: Boolean;
    m_nFirstcount   : Integer;


  public

    { Public declarations }
    {
     m_swID         : Integer;
     m_sbyMode      : Byte;
     m_sbyAutoPack  : Byte;
     m_swAddres     : Integer;
     m_sStorePeriod : Integer;
     m_sStoreClrTime: Integer;
     m_sStoreProto  : Integer;
     m_sPoolPeriod  : Integer;
     }
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
    procedure InitGomelEnergo;
    procedure ExportON;
    procedure ExportOF;
    procedure ExportIN;
    procedure OnChandgeIP0;
    procedure SelfStop;
    procedure SelfUpdate;
    procedure SelfReload;
    procedure RunSharedAccess;
    procedure StopSharedAccess;
    procedure EnableRD;
    procedure DisableRD;
    procedure StartAmmy;
    procedure StopAmmy;
    procedure ModemPrepare;
    procedure UpdateARM;
    function  IsTransTime:Boolean;
    function  IsCalendOn:Boolean;

   public
      property PlbScheduler     :PTStaticText    read FlbScheduler      write FlbScheduler;
      property PlbSchedTime     :PTStaticText    read FlbSchedTime      write FlbSchedTime;
      property PlbSdlQrylb      :PTStaticText    read FlbSdlQrylb       write FlbSdlQrylb;
      property PlbOnTransTime   :PTStaticText    read FlbOnTransTime    write FlbOnTransTime;
      property PlbOnTransState  :PTStaticText    read FlbOnTransState   write FlbOnTransState;
      property PConfifTbl       :PSGENSETTTAG    read FConfifTbl        write FConfifTbl;
      property PProgress        :TAdvProgressBar read pbm_sTestProgress write pbm_sTestProgress;
      property PProgresslb      :TGradientLabel  read lbm_sTestProgress write lbm_sTestProgress;
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
  WM_SENDTOMONITORACTIVE=WM_USER + 9;
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
   {
   if (m_pDB.EventFlagCorrector = EVH_COR_TIME_KYEBD) and (KorrInMs < 5) then
     exit;
   if (KorrInMs < 5) then
     exit;
   }
   if (m_pDB.EventFlagCorrector = EVH_COR_TIME_KYEBD) and (KorrInMS < 500) then
     exit;
   if m_pDB.EventFlagCorrector = EVH_COR_TIME_KYEBD  then
   begin
     m_pDB.FixUspdEventCorrectorEx(STime,EVH_COR_TIME_KYEBD,0); //EVENT
     m_pDB.FixUspdEventCorrector(EVH_FINISH_CORR, KorrInMS);
//     m_pDB.UpdateKorrMonth(abs(STime - NewTime));
   end;
   if m_pDB.EventFlagCorrector = EVH_COR_TIME_DEVICE then
   begin
     m_pDB.FixUspdEventCorrectorEx(STime,EVH_COR_TIME_DEVICE,0); //EVENT
     m_pDB.FixUspdEventCorrector(EVH_FINISH_CORR, KorrInMS);
//     m_pDB.UpdateKorrMonth(abs(STime - NewTime));
   end;
   if m_pDB.EventFlagCorrector = EVH_COR_TIME_AUTO   then
   begin
     m_pDB.FixUspdEventCorrectorEx(STime,EVH_COR_TIME_AUTO,0); //EVENT
     m_pDB.FixUspdEventCorrector(EVH_FINISH_CORR, KorrInMS);
//     m_pDB.UpdateKorrMonth(abs(STime - NewTime));
   end;
   m_pDB.EventFlagCorrector := EVH_COR_TIME_KYEBD;
   End;// else m_blFirstChandge := False;
end;

procedure TTL5Config.OnChandgeSett(Sender: TObject);
begin
    //if pgGenSettings.ActivePageIndex=0 then Begin SetGenSettings;lbGenSettings.Caption := 'Основные параметры';End;
    dtQryPicker.Visible := False;
    cbQryPeriod.Visible := False;
    lbEnter.Visible     := False;
    lbPeriod.Visible    := False;
    cbQryPeriod.Visible := False;
    lbBottInfo.Visible  := False;
    if pgGenSettings.ActivePageIndex=0 then lbGenSettings.Caption := 'Основные настройки';
    if pgGenSettings.ActivePageIndex=1 then lbGenSettings.Caption := 'Настройка перевода времени';
    if pgGenSettings.ActivePageIndex=2 then
    Begin
     lbGenSettings.Caption := 'График опроса';
     dtQryPicker.Visible := True;
     cbQryPeriod.Visible := True;
     lbEnter.Visible     := True;
     lbPeriod.Visible    := True;
     cbQryPeriod.Visible := True;
    End;
    if pgGenSettings.ActivePageIndex=3 then
    Begin
     lbGenSettings.Caption := 'События';
     lbBottInfo.Visible  := True;
     OnGetEv0(self);
    End;
    if pgGenSettings.ActivePageIndex=4 then lbGenSettings.Caption := 'Соединения';
    if pgGenSettings.ActivePageIndex=5 then lbGenSettings.Caption := 'Темы';
    if pgGenSettings.ActivePageIndex=6 then lbGenSettings.Caption := 'Диагностика систкмы';

    if pgGenSettings.ActivePageIndex=8 then
    Begin
     m_Export2DBF.Prepare;
     lbGenSettings.Caption := 'Выгрузка DBF.';
    End;

    if pgGenSettings.ActivePageIndex=11 then
    Begin
     m_ExportVT.Prepare;
     lbGenSettings.Caption := 'Выгрузка Витебск Быт.';
    End;


end;

procedure TTL5Config.OnCreateForm(Sender: TObject);
var  mCL : SCOLORSETTTAG;
begin
    m_nCF := self;
    m_bySchedState := 1;
    m_blFirstChandge := False;
    m_nFirstcount    := 0;
    //m_blTransTimeEditor   : Boolean;
    //m_blShedlEditor       : Boolean;
    lbGenSettings.Caption := 'Основные параметры';
    //GenSett Loading
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
    cbm_byEnableArchiv.items.loadfromfile(m_strCurrentDir+'Active.dat');
    cbm_tmArchPeriod.items.loadfromfile(m_strCurrentDir+'ArchPeriod.dat');


    m_nEventList    := TStringList.Create;

    {
    edm_sProjectName.Color  := KNS_COLOR;
    sem_swAddres.Color      := KNS_COLOR;
    cbm_sbyMode.Color       := KNS_COLOR;
    cbm_sbyLocation.Color   := KNS_COLOR;
    cbm_sbyAutoPack.Color   := KNS_COLOR;
    cbm_sStorePeriod.Color  := KNS_COLOR;
    cbm_sStoreClrTime.Color := KNS_COLOR;
    cbm_sStoreProto.Color   := KNS_COLOR;
    cbm_sPoolPeriod.Color   := KNS_COLOR;
    edm_sPowerLimit.Color   := KNS_COLOR;
    sem_sPowerLimit.Color   := KNS_COLOR;
    cbm_sPrePoolGraph.Color := KNS_COLOR;
    cbm_sQryScheduler.Color := KNS_COLOR;
    dtQryPicker.Color       := KNS_COLOR;
    cbQryPeriod.Color       := KNS_COLOR;
    cbm_sAutoTray.Color     := KNS_COLOR;
    sem_sPrecise.Color      := KNS_COLOR;
    sem_sPreciseExpense.Color := KNS_COLOR;
    cbm_sBaseLocation.Color := KNS_COLOR;
    cbm_sCorrDir.Color      := KNS_COLOR;
    edm_sKorrDelay.Color    := KNS_COLOR;
    cbm_sSetForETelecom.Color := KNS_COLOR;
    sem_sExport.Color       := KNS_COLOR;
    cbm_sInterSet.Color     := KNS_COLOR;
    edm_sMdmJoinName.Color  := KNS_COLOR;
    cbm_sUseModem.Color     := KNS_COLOR;
    edm_sInterDelay.Color   := KNS_COLOR;
    cbm_sChannSyn.Color     := KNS_COLOR;
    edm_nUpdatePath.Color   := KNS_COLOR;
    cbm_nIsRemLink.Color    := KNS_COLOR;
    edm_nIsRemLink.Color    := KNS_COLOR;
    edm_nDestPath.Color     := KNS_COLOR;
    }

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
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Группа';
    FsgGrid.Cells[2,0]  := 'Код ';
    FsgGrid.Cells[3,0]  := 'Название';
    FsgGrid.Cells[4,0]  := 'Активность';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 40;
    FsgGrid.ColWidths[2]:= 50;
    FsgGrid.ColWidths[3]:= 400;
    dtFTime.DateTime := Now;
    dtETime.DateTime := Now;
    //initcolor
    m_nSetColor := CSetColor.Create;
  {  mCL.m_swCtrlID   := CL_TREE_CONF;
    FontDialog1.font.Name := m_nSetColor.FindFontName(CL_TREE_CONF);
    Edit1.Text       := m_nSetColor.FindFontName(CL_TREE_CONF);
    Edit1.Color      := m_nSetColor.GetColor(CL_TREE_CONF);
    Edit2.Color      := m_nSetColor.GetColorPanel(CL_TREE_CONF);   }
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

    if m_nUMN=Nil then m_nUMN  := CUpdateManager.Create;
    m_nUMN.Pcbm_nIsRemLink   := @cbm_nIsRemLink;
    m_nUMN.Pedm_nIsRemLink   := @edm_nIsRemLink;
    m_nUMN.Pedm_nUpdatePath  := @edm_nUpdatePath;
    {
    m_nUMN.Ppbm_nUnpackUpdate:= @pbm_nUnpackUpdate;
    m_nUMN.Ppbm_nCopyUpdate  := @pbm_nCopyUpdate;
    m_nUMN.Ppbm_nLoadUpdate  := @pbm_nLoadUpdate;
    }
    m_nUMN.Pedm_nLoadUpdate  := @edm_nLoadUpdate;
    m_nUMN.Pedm_nUnpackUpdate:= @edm_nUnpackUpdate;
    m_nUMN.Pedm_nCopyUpdate  := @edm_nCopyUpdate;
    m_nUMN.Pedm_nRemLinkState:= @edm_nRemLinkState;
    m_nUMN.Pedm_nStartProgramm:= @edm_nStartProgramm;
    m_nUMN.Pedm_nDestPath    := @edm_nDestPath;
    m_nUMN.Init(@m_pGenTable);

    {MYSQL}
    ddd := Now();
    mysqlEDate.DateTime := ddd;
    mysqlSDate.DateTime := ddd;

    //mysqlSDate.DateTime := cDateTimeR.DecDate(ddd);

    if m_Export2My=Nil then m_Export2My := CL3Export2MySQLModule.Create(@mMySQLStat, @mMySQLECmpl, @mMySQLENext);

    if m_Export2DBF=Nil then m_Export2DBF := CL3Export2DBFModule.Create(@m_pGenTable);

    if m_ExportVT=Nil then m_ExportVT := CL3ExportVTModule.Create(@m_pGenTable);

    if m_ExportMog=Nil  then m_ExportMog  := CL3ExportMogModule.Create(@m_pGenTable);

    m_Export2DBF.PForm := self;
    m_Export2DBF.Pcbm_nUnlPower    := cbm_nUnlPower;
    m_Export2DBF.Pcbm_nMaxUtro     := cbm_nMaxUtro;
    m_Export2DBF.Pcbm_nMaxVech     := cbm_nMaxVech;
    m_Export2DBF.Pcbm_nMaxDay      := cbm_nMaxDay;
    m_Export2DBF.Pcbm_nMaxNoch     := cbm_nMaxNoch;
    m_Export2DBF.Pcbm_nMaxTar      := cbm_nMaxTar;
    m_Export2DBF.Pcbm_nExpTret     := cbm_nExpTret;
    m_Export2DBF.Pclm_strAbons     := clm_strAbons;
    m_Export2DBF.Pem_strPath       := em_strPath;
    m_Export2DBF.Pem_strPath1      := em_strPath1;
    m_Export2DBF.Pclm_swDayMask    := clm_swDayMask;
    m_Export2DBF.Pclm_sdwMonthMask := clm_sdwMonthMask;
    m_Export2DBF.Pchm_swDayMask    := chm_swDayMask;
    m_Export2DBF.Pchm_sdwMonthMask := chm_sdwMonthMask;
    m_Export2DBF.Pchm_sbyEnable    := chm_sbyEnable;
    m_Export2DBF.Pdtm_sdtBegin     := dtm_sdtBegin;
    m_Export2DBF.Pdtm_sdtEnd       := dtm_sdtEnd;
    m_Export2DBF.Pdtm_sdtPeriod    := dtm_sdtPeriod;
    m_Export2DBF.Pcbm_snDeepFind   := cbm_snDeepFind;
    m_Export2DBF.Init(@m_pGenTable);



    m_ExportVT.PForm := self;
    m_ExportVT.Pcbm_nVTUnlPower    := cbm_nVTUnlPower;
    m_ExportVT.Pcbm_nVTMaxUtro     := cbm_nVTMaxUtro;
    m_ExportVT.Pcbm_nVTMaxVech     := cbm_nVTMaxVech;
    m_ExportVT.Pcbm_nVTMaxDay      := cbm_nVTMaxDay;
    m_ExportVT.Pcbm_nVTMaxNoch     := cbm_nVTMaxNoch;
    m_ExportVT.Pcbm_nVTMaxTar      := cbm_nVTMaxTar;
    m_ExportVT.Pcbm_nVTExpTret     := cbm_nVTExpTret;
    m_ExportVT.Pclm_strVTAbons     := clm_strVTAbons;
    m_ExportVT.Pem_strVTPath       := em_strVTPath;
    m_ExportVT.Pem_strVTPath1      := em_strVTPath1;
    m_ExportVT.Pclm_swVTDayMask    := clm_swDayMask;
    m_ExportVT.Pclm_sdwVTMonthMask := clm_sdwVTMonthMask;
    m_ExportVT.Pchm_swVTDayMask    := chm_swVTDayMask;
    m_ExportVT.Pchm_sdwVTMonthMask := chm_sdwVTMonthMask;
    m_ExportVT.Pchm_sbyVTEnable    := chm_sbyVTEnable;
    m_ExportVT.Pdtm_sdtVTBegin     := dtm_sdtVTBegin;
    m_ExportVT.Pdtm_sdtVTEnd       := dtm_sdtVTEnd;
    m_ExportVT.Pdtm_sdtVTPeriod    := dtm_sdtVTPeriod;
    m_ExportVT.Pcbm_snVTDeepFind   := cbm_snVTDeepFind;
    m_ExportVT.Init(@m_pGenTable);


    mgsqlEDate.DateTime           := Now;
    mgsqlSDate.DateTime           := Now;
    m_ExportMog.PForm := self;
    m_ExportMog.Pclm_strAbons     := clm_strAbonsMg;
    m_ExportMog.Pem_strPath       := em_strPathMg;
    m_ExportMog.Pem_strPath1      := em_strPathMg1;
    m_ExportMog.Pclm_swDayMask    := clm_swDayMaskMg;
    m_ExportMog.Pclm_sdwMonthMask := clm_sdwMonthMaskMg;
    m_ExportMog.Pchm_swDayMask    := chm_swDayMaskMg;
    m_ExportMog.Pchm_sdwMonthMask := chm_sdwMonthMaskMg;
    m_ExportMog.Pchm_sbyEnable    := chm_sbyEnableMg;
    m_ExportMog.Pdtm_sdtBegin     := dtm_sdtBeginMg;
    m_ExportMog.Pdtm_sdtEnd       := dtm_sdtEndMg;
    m_ExportMog.Pdtm_sdtPeriod    := dtm_sdtPeriodMg;
    m_ExportMog.Pcbm_snDeepFind   := cbm_snDeepFindMg;
    m_ExportMog.Init(@m_pGenTable);

    if m_Export2FMAK=Nil then m_Export2FMAK := CL3Export2DBMaket.Create();

    mysqlPORT.Text := IntToStr(m_pGenTable.m_SDBPORT);
    mysqlSERVER.Text := m_pGenTable.m_SDBSERVER;
    mysqlDATABASE.Text := m_pGenTable.m_sDBNAME;
    mysqlUSER.Text := m_pGenTable.m_sDBUSR;
    mysqlPASSW.Text := m_pGenTable.m_sDBPASSW;
    //dtMysqlES.Time := m_pGenTable.m_dtEStart;
    //dtMysqlINT.Time := m_pGenTable.m_dtEInt;
    mMySQLStat.Lines.Clear;

    m_Export2My.Pclm_swDayMask    := clm_swDayMaskMy;
    m_Export2My.Pclm_sdwMonthMask := clm_sdwMonthMaskMy;
    m_Export2My.Pchm_swDayMask    := chm_swDayMaskMy;
    m_Export2My.Pchm_sdwMonthMask := chm_sdwMonthMaskMy;
    m_Export2My.Pchm_sbyEnable    := chm_sbyEnableMy;
    m_Export2My.Pclm_strMyAbons   := clm_strMyAbons;
    m_Export2My.Pdtm_sdtBegin     := dtm_sdtBeginMy;
    m_Export2My.Pdtm_sdtEnd       := dtm_sdtEndMy;
    m_Export2My.Pdtm_sdtPeriod    := dtm_sdtPeriodMy;
    m_Export2My.Pcbm_snDeepFind   := cbm_snDeepFindMy;
    m_Export2My.Pchm_sbyFindData  := chm_sbyFindDataMy;
    m_Export2My.PmMySQLECmpl      := mMySQLECmpl;
    m_Export2My.PmMySQLENext      := mMySQLENext;
    m_Export2My.Init(@m_pGenTable);
    m_Export2DBF.Init(@m_pGenTable);

    dtLoTime.DateTime := Now;
    dtHiTime.DateTime := Now;
    m_Export2FMAK.PlbExportTime     := @lbExportTime;
    m_Export2FMAK.PlbExportTimeNext := @lbExportTimeNext;
    m_Export2FMAK.Pcbm_blExportLast := @cbm_blExportLast;
    m_Export2FMAK.Init(@m_pGenTable);

    if m_nBA=Nil  then m_nBA := CArchiveBase.Create(ExtractFilePath(Application.ExeName),@m_pGenTable);
    m_nBA.PForm := self;
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

    //if mcl.m_swStyle <> 0 then StyleForm.ItemIndex := mcl.m_swStyle;
    //if StyleForm.ItemIndex = -1 then  StyleForm.ItemIndex :=0;
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
    //if mcl.m_swStyle = 0 then  m_nSetColor.SetAutoTheme else   m_nSetColor.SetAllStyle(StyleForm.ItemIndex);
    m_nSetColor.SetAllStyle(mcl.m_swStyle);
    // реинициализация
//    m_Export2My.InitTree();                        
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
//GenSett Routine
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
     m_nEInt           := cbm_nEInt.ItemIndex;
     //m_sDBFLOCATION    := e_DBFLoc.Text;
     m_sMAKLOCATION    := edm_sMAKLOCATION.Text;
     M_SHOSTMAK        := edm_sHOSTMAK.Text;
     M_SEMAILMAK       := edm_sEMAILMAK.Text;
     M_SPASSMAK        := edm_sPASSMAK.Text;
     m_sNAMEMAILMAK    := edm_sNAMEMAILMAK.Text;
     M_BLFMAKDELFILE   := Byte(cbM_BLFMAKDELFILE.Checked);
     m_blMdmExp        := Byte(cbm_blMdmExp.Checked);
     if cbm_ChooseEnergo.ItemIndex=3 then m_dtEStart     := dtm_dtEStart.DateTime;
     if cbAllowInDConn.Checked then m_sbyAllowInDConn := 1 else m_sbyAllowInDConn := 0;
     M_NSESSIONTIME    := cbM_NSESSIONTIME.ItemIndex;
    End;
    SetSelfTestConfig(pTable);
    SetQueryMask(pTable);
    m_pDB.AddGenSettTable(pTable);
end;

procedure TTL5Config.InitGomelEnergo;
begin
if IsETelecom=True then   if m_nCF.cbm_ChooseEnergo.ItemIndex = 1 then     m_nMZ.InitTableA_T;
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
      //e_DBFLoc.Text               := m_sDBFLOCATION;
      edm_sMAKLOCATION.Text       := m_sMAKLOCATION;
      edm_sHOSTMAK.Text           := m_sHOSTMAK;
      edm_sEMAILMAK.Text          := m_sEMAILMAK;
      edm_sPASSMAK.Text           := m_sPASSMAK;
      edm_sNAMEMAILMAK.Text       := m_sNAMEMAILMAK;
      //cbM_NSESSIONTIME.ItemIndex  := M_NSESSIONTIME    := GetSessionTime(cbM_NSESSIONTIME.ItemIndex);
      if M_BLFMAKDELFILE=1 then cbM_BLFMAKDELFILE.Checked:=True else cbM_BLFMAKDELFILE.Checked:=False;
      if m_blMdmExp=1      then cbm_blMdmExp.Checked:=True      else cbm_blMdmExp.Checked:=False;
      m_nTT.OnEnable              := Boolean(m_sTransTime);
      cbm_nEInt.ItemIndex         := m_nEInt;
      if m_sChooseExport=3 then dtm_dtEStart.DateTime := m_dtEStart;
      if m_sbyAllowInDConn = 1 then cbAllowInDConn.Checked := true else cbAllowInDConn.Checked := false;
      if m_sQryScheduler=1 then
      Begin
       //FlbScheduler.Caption := 'Включен';
       FlbSchedTime.Visible := True;
       FlbSdlQrylb.Visible  := True;
       m_bySchedState       := 1;
      End else
      if m_sQryScheduler=0 then
      Begin
       //FlbScheduler.Caption := 'Выключен';
       FlbSchedTime.Visible := False;
       FlbSdlQrylb.Visible  := False;
      End;
      m_nPrecise        := m_sPrecise;
      m_nPreciseExpense := m_sPreciseExpense;
      cbM_NSESSIONTIME.ItemIndex := M_NSESSIONTIME;
      m_nUsrCtrl.InitTimer(GetSessTime);
     End;
     b_ExportRClick(self);
     GetSelfTestConfig(m_pGenTable);
     GetQueryMask(m_pGenTable);
     OnClickCurr(self);
     OnChandgeExport(self);
     //OnChModem(self);
     OnChsynchro(self);
     if (m_pGenTable.m_sSetForETelecom=1) AND (m_pGenTable.m_sChooseExport=1) then
     if m_Export2My<>Nil then m_Export2My.LoadUnloadSett;
    End;
end;
procedure TTL5Config.SetSelfTestConfig(var pTbl:SGENSETTTAG);
Begin
    pTbl.m_swSelfTest := (Dword(chm_sVerNo.Checked)       shl 0) or
                         (Dword(chm_sAmPhChannel.Checked) shl 1) or
                         (Dword(chm_sStPhChannel.Checked) shl 2) or
                         (Dword(chm_sAmModem.Checked)     shl 3) or
                         (Dword(chm_sStModem.Checked)     shl 4) or
                         (Dword(chm_sAmMeters.Checked)    shl 5) or
                         (Dword(chm_sStMeters.Checked)    shl 6) or
                         (Dword(chm_sAmArm.Checked)       shl 7) or
                         (Dword(chm_sStArm.Checked)       shl 8) or
                         (Dword(chm_sTimeRout.Checked)    shl 9) or
                         (Dword(chm_sTransError.Checked)  shl 10) or
                         (Dword(chm_sFatalError.Checked)  shl 11);

End;
procedure TTL5Config.GetSelfTestConfig(var pTbl:SGENSETTTAG);
Begin
    chm_sVerNo.Checked       := (pTbl.m_swSelfTest and $00000001)>0;
    chm_sAmPhChannel.Checked := (pTbl.m_swSelfTest and $00000002)>0;
    chm_sStPhChannel.Checked := (pTbl.m_swSelfTest and $00000004)>0;
    chm_sAmModem.Checked     := (pTbl.m_swSelfTest and $00000008)>0;
    chm_sStModem.Checked     := (pTbl.m_swSelfTest and $00000010)>0;
    chm_sAmMeters.Checked    := (pTbl.m_swSelfTest and $00000020)>0;
    chm_sStMeters.Checked    := (pTbl.m_swSelfTest and $00000040)>0;
    chm_sAmArm.Checked       := (pTbl.m_swSelfTest and $00000080)>0;
    chm_sStArm.Checked       := (pTbl.m_swSelfTest and $00000100)>0;
    chm_sTimeRout.Checked    := (pTbl.m_swSelfTest and $00000200)>0;
    chm_sTransError.Checked  := (pTbl.m_swSelfTest and $00000400)>0;
    chm_sFatalError.Checked  := (pTbl.m_swSelfTest and $00000800)>0;
End;
{
 QFH_ARCH_EN                  = $0000000000000001;
  QFH_ENERGY_DAY_EP            = $0000000000000002;
  QFH_ENERGY_MON_EP            = $0000000000000004;
  QFH_SRES_ENR_EP              = $0000000000000008;
  QFH_NAK_EN_DAY_EP            = $0000000000000010;
  QFH_NAK_EN_MONTH_EP          = $0000000000000020;

  QFH_CURR                     = $0000000000000040;
  QFH_CURR_SUMM                = $0000000000000080;
  QFH_CURR_MAP                 = $0000000000000100;
  QFH_CURR_MRP                 = $0000000000000200;
  QFH_CURR_U                   = $0000000000000400;
  QFH_CURR_I                   = $0000000000000800;
  QFH_CURR_F                   = $0000000000001000;
  QFH_CORR_TIME                = $0000000000002000;

  QFH_POD_TRYB_HEAT            = $0000000000004000;

  QFH_JUR_EN                   = $0000000000008000;
  QFH_JUR_0                    = $0000000000010000;
  QFH_JUR_1                    = $0000000000020000;
  QFH_JUR_2                    = $0000000000040000;
  QFH_JUR_3                    = $0000000000080000;

  QFH_ANET_EN                  = $0000000000100000;
  QFH_ANET_U                   = $0000000000200000;
  QFH_ANET_I                   = $0000000000400000;
  QFH_ANET_FI                  = $0000000000800000;
  QFH_ANET_CFI                 = $0000000001000000;
  QFH_ANET_F                   = $0000000002000000;
  QFH_ANET_P                   = $0000000004000000;
  QFH_ANET_Q                   = $0000000008000000;

   if cbm_nArchEN.Checked=True   then dwLoMask := dwLoMask or (QFH_ARCH_EN);
    if cbm_nPriDay.Checked=True   then dwLoMask := dwLoMask or (QFH_ENERGY_DAY_EP);
    if cbm_nPriMonth.Checked=True then dwLoMask := dwLoMask or (QFH_ENERGY_MON_EP);
    if cbm_nPri30.Checked=True    then dwLoMask := dwLoMask or (QFH_SRES_ENR_EP);
    if cbm_nNakDay.Checked=True   then dwLoMask := dwLoMask or (QFH_NAK_EN_DAY_EP);
    if cbm_nNakMonth.Checked=True then dwLoMask := dwLoMask or (QFH_NAK_EN_MONTH_EP);

    if cbm_byCurrent.Checked=True then dwLoMask := dwLoMask or (QFH_CURR);
    if cbm_bySumEn.Checked=True   then dwLoMask := dwLoMask or (QFH_CURR_SUMM);
    if cbm_byMAP.Checked=True     then dwLoMask := dwLoMask or (QFH_CURR_MAP);
    if cbm_byMRAP.Checked=True    then dwLoMask := dwLoMask or (QFH_CURR_MRP);
    if cbm_byU.Checked=True       then dwLoMask := dwLoMask or (QFH_CURR_U);
    if cbm_byI.Checked=True       then dwLoMask := dwLoMask or (QFH_CURR_I);
    if cbm_byFreq.Checked=True    then dwLoMask := dwLoMask or (QFH_CURR_F);
    if cbm_byCorrTM.Checked=True  then dwLoMask := dwLoMask or (QFH_CORR_TIME);

    if cbm_nPar6.Checked=True     then dwLoMask := dwLoMask or (QFH_POD_TRYB_HEAT);

    if cbm_byJEn.Checked=True     then dwLoMask := dwLoMask or (QFH_JUR_EN);
    if cbm_byJ0.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_0);
    if cbm_byJ1.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_1);
    if cbm_byJ2.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_2);
    if cbm_byJ3.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_3);

    if cbm_byPNetEn.Checked=True    then dwLoMask := dwLoMask or (QFH_ANET_EN);
    if cbm_byPNetU.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_U);
    if cbm_byPNetI.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_I);
    if cbm_byPNetFi.Checked=True    then dwLoMask := dwLoMask or (QFH_ANET_FI);
    if cbm_byPNetCosFi.Checked=True then dwLoMask := dwLoMask or (QFH_ANET_CFI);
    if cbm_byPNetF.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_F);
    if cbm_byPNetP.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_P);
    if cbm_byPNetQ.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_Q);

}
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
    //OnSetSettings(self);
End;
function TTL5Config.IsLocal:Boolean;
Begin
    Result:=True;
    if m_pGenTable.m_sbyLocation=0 then Result:=True;
    if m_pGenTable.m_sbyLocation=1 then Result:=False;
    //OnSetSettings(self);
End;
function TTL5Config.IsSlave:Boolean;
Begin
    if m_pGenTable.m_sbyMode=0 then Result:=True;
    if m_pGenTable.m_sbyMode=1 then Result:=False;
    //OnSetSettings(self);
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
       //0:  Result := 1*60;
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
1 месяц
2 месяца
3 месяца
4 месяца
5 месяцев
6 месяцев
7 месяцев
8 месяцев
9 месяцев
10 месяцев
11 месяцев
12 месяцев
1.5 год
2 года
3 года
безконечно
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
    //Result := m_pGenTable.m_sStoreClrTime + 1;
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
Постоянно
15 сек.
30 сек.
1 мин.
3 мин.
5 мин.
10 мин.
15 мин.
30 мин.
1 час
2 часa
3 часa
4 часов
5 часов
6 часов
7 часов
8 часов
9 часов
11 часов
12 часов

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
   //   if (ACol<>0)and(ARow<>0) then ABrush.Color := clTeal;
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
        //AFont.Style := [fsItalic];
        case ACol of
         1,2,4      : AFont.Color := clBlack;{clAqua;}
         3          : AFont.Color := clBlack;{clLime;}
         {
          4      : AFont.Color := clRed;
          2,5,10 : AFont.Color := clLime;
          6,7    : AFont.Color := clAqua;
          8      : AFont.Color := clWhite;
         }
        End;
      End;
    End;
end;
{
SEVENTSETTTAG = packed record
     m_swID         : Integer;
     m_swEventID    : Word;
     m_sdtEventTime : TDateTIme;
     m_schEventName : String[50];
     m_sbyEnable    : Byte;
    end;
}
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
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := 'Да';
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
     // if m_pDB.GetUspdEventALL(m_nCurrGroup,pTable)=True then
     // begin
      for i:=0 to pTbl.Count-1 do
      AddRecordToEventGrid(i,pTbl.Items[i]{,pTable.Items[i]});
   //   end;
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
    lbBottInfo.Caption := 'Все события';
    ExecSetEventGrid;
end;
procedure TTL5Config.OnGetEv0(Sender: TObject);
begin
    lbBottInfo.Caption := 'Журнал №1';
    m_nCurrGroup := 0;
    ExecSetEventGrid;
end;
procedure TTL5Config.OnGetEv1(Sender: TObject);
begin
    lbBottInfo.Caption := 'Журнал №2';
    m_nCurrGroup := 1;
    ExecSetEventGrid;
end;
procedure TTL5Config.OnGetEv2(Sender: TObject);
begin
    lbBottInfo.Caption := 'Журнал №3';
    m_nCurrGroup := 2;
    ExecSetEventGrid;
end;

procedure TTL5Config.OnGetEv3(Sender: TObject);
begin
    lbBottInfo.Caption := 'Журнал №4';
    m_nCurrGroup := 3;
    ExecSetEventGrid;
end;

{
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Код ';
    FsgGrid.Cells[2,0]  := 'Группа';
    FsgGrid.Cells[3,0]  := 'Название';
    FsgGrid.Cells[4,0]  := 'Активность';
}
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
     FsgGrid.Cells[4,i+1] := 'Да';
    End;
End;

procedure TTL5Config.OnDelAllEvent(Sender: TObject);
begin
    if m_nCurrGroup=-1 then
    Begin
     if MessageDlg('Удалить все события?',mtWarning,[mbOk,mbCancel],0)=mrOk then m_pDB.DelEventsTable(m_nCurrGroup);
    End
     else
    if MessageDlg('Удалить события группы?'+IntToStr(m_nCurrGroup),mtWarning,[mbOk,mbCancel],0)=mrOk then m_pDB.DelEventsTable(m_nCurrGroup);
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
    if MessageDlg('Установить удаленные настройки?',mtWarning,[mbOk,mbCancel],0)=mrOk then
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
    //m_pDB.GetGenSettTable(m_pGenTable);
    //GetQueryMask(m_pGenTable);
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
     //FlbScheduler.Caption := 'Пауза';
End;
procedure TTL5Config.SchedGo;
Begin
     m_bySchedState := 1;
     if IsScheduler=True then
     //FlbScheduler.Caption := 'Включен';
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

    {if (ACol<>0)and(ARow<>0) then
     ABrush.Color := clTeal; }

    end;
    if ARow=0 then AFont.Style := [fsBold];
    if (ARow<>0) and (ACol<>0)then
     Begin
      if ACol<>0 then
      Begin
         AFont.Color :=  m_blGridDataFontColor;//clAqua;
      // AFont.Color :=  m_blGridDataFontColor;
       //AFont.Size  :=  m_blGridDataFontSize;
       //AFont.Name  :=  m_blGridDataFontName;
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
    lbGenSettings.Caption := 'Коп-е данных для экспорта.Ожидайте';
    if MessageDlg('Процедура займет несколько минут.Выполнить?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     dtDate1 := Now;
     dtDate0 := dtDate1-sem_sExport.Value;
     //if  cbm_ChooseEnergo.ItemIndex = 0 then
     //m_nEN.CopyEnergoInfoUser(dtDate0,dtDate1);
     if  cbm_ChooseEnergo.ItemIndex = 1 then
     m_nMZ.CopyEnergoInfoUser(dtDate0,dtDate1);
     lbGenSettings.Caption := 'Данные для экспорта готовы';
    End else lbGenSettings.Caption := 'Копирование данных отменено';
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
    if MessageDlg('Установить время?',mtWarning,[mbOk,mbCancel],0)=mrOk then
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
    if MessageDlg('Разорвать соединение?',mtWarning,[mbOk,mbCancel],0)=mrOk then
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

procedure TTL5Config.OnStartReload(Sender: TObject);
begin
    m_nUMN.OnStartReload;
end;

procedure TTL5Config.OnChandgeConn(Sender: TObject);
begin
    m_nUMN.OnChandgeConn;
end;

procedure TTL5Config.OnOpenUpdateFile(Sender: TObject);
begin
    odm_OpenDialog.InitialDir := GetCurrentDir;
    if odm_OpenDialog.Execute then
    begin
     edm_nUpdatePath.Text := odm_OpenDialog.FileName;
     m_nUMN.OnChandgeConn;
    end;
end;

procedure TTL5Config.OnStartCopy(Sender: TObject);
begin
    m_nUMN.OnStartCopy;
end;

procedure TTL5Config.OnReBoot(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    FillChar(pDS,sizeof(pDS),0);
   // m_nSDL.m_nGST.OpenSession(30,7);


    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Выполнить перезагрузку приложения. Уверенны?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Выполнить перезагрузку удаленного приложения. Уверенны?';End;
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
    if MessageDlg('Диагностика займет некоторое время.Выполнить?',mtWarning,[mbOk,mbCancel],0)=mrOk then
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
    if MessageDlg('Остановить диагностику?',mtWarning,[mbOk,mbCancel],0)=mrOk then
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
     SetSelfTestConfig(pGenTable);
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
     GetSelfTestConfig(pGenTable);
    End else
    if m_blIsLocal=True  then
    Begin
     m_pDB.GetGenSettTable(m_pGenTable);
     GetSelfTestConfig(m_pGenTable);
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
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Принять изменения?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Принять изменения удаленно?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_TMSST_INIT_REQ,pDS);

    //if m_blCL3TariffEditor=True  then m_pDB.FixUspdEvent(0,3,EVU_TZONE_ED_ON) else
    //if m_blCL3TariffEditor=False then m_pDB.FixUspdEvent(0,3,EVU_TZONE_ED_OF);
end;
procedure TTL5Config.OnStart(Sender: TObject);
    Var
    pDS : CMessageData;
    str : String;
begin
     Begin
//      m_pDB.FixUspdDescEvent(0,3,EVS_STRT_TRTM,0);
      str:='Запуск модуля перевода времени...';
      if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;End;
      if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;End;
      if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_TSTM_REQ,pDS);
     End;
end;

procedure TTL5Config.OnPause(Sender: TObject);
    Var
    pDS : CMessageData;
    str : String;
begin
     Begin
//      m_pDB.FixUspdDescEvent(0,3,EVS_STOP_TRTM,0);
      str:='Останов модуля перевода времени...';
      if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;End;
      if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;End;
      if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_STOP_TSTM_REQ,pDS);
     End;
end;

procedure TTL5Config.OSdlInit(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Принять изменения?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Принять изменения удаленно?';End;
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

procedure TTL5Config.b_ExportConnClick(Sender: TObject);
begin
    if m_pGenTable.m_sSetForETelecom=1 then
    Begin
     m_Export2My.Start;
     if (m_Export2My.m_boIsConnected) then
         mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Подключен.');
    End;
end;

procedure TTL5Config.b_ExportPingClick(Sender: TObject);
var
    dt : TDateTime;
begin
    if m_pGenTable.m_sSetForETelecom=1 then
    Begin
     {$IFNDEF MYSQL_UNLOAD_DEBUG}
     if (m_Export2My.m_boIsConnected AND m_pDB.MyPing(dt)) then
     {$ENDIF}
         mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> ' + DateTimeToStr(dt))
     else
     begin
         mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Нет ответа от сервера!');

     end;
    End;
end;

procedure TTL5Config.b_ExportSysClick(Sender: TObject);
begin
    if m_pGenTable.m_sSetForETelecom=1 then
    Begin
    m_Export2My.InitTree();
    if (not m_Export2My.m_boIsConnected) then
    begin
        mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Подключение не установлено!');
        exit;
    end;
    End;
end;

procedure TTL5Config.b_ExportDisconnClick(Sender: TObject);
begin
    if m_pGenTable.m_sSetForETelecom=1 then
    Begin
     mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Отключение.');
     {$IFNDEF MYSQL_UNLOAD_DEBUG}
     m_Export2My.Finish(true);
     {$ENDIF}
     if (not m_Export2My.m_boIsConnected) then
         mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Отключен.');
    End;
end;

procedure TTL5Config.b_ExportEdClick(Sender: TObject);
var
    bo : Boolean;
begin
    //if m_pGenTable.m_sSetForETelecom=1 then
    Begin
     bo := Boolean(b_ExportEd);

     mysqlSERVER.ReadOnly := bo;
     mysqlPORT.ReadOnly := bo;
     mysqlDATABASE.ReadOnly := bo;
     mysqlUSER.ReadOnly := bo;
     mysqlPASSW.ReadOnly := bo;

     dtm_sdtBeginMy.Enabled := not bo;
     dtm_sdtEndMy.Enabled := not bo;
     dtm_sdtPeriodMy.Enabled := not bo;
     cbm_snDeepFindMy.Enabled := not bo;
     chm_sbyFindDataMy.Enabled := not bo;
     chm_sbyEnableMy.Enabled := not bo;
     mysqlEDate.Enabled := not bo;
     mysqlSDate.Enabled := not bo;
     cbEnPassw.Enabled := not bo;


     b_ExportEd  := (not bo);
     //if (not bo) then
     //    b_ExportEd.Hint := 'Закончить'
     //else
     //    b_ExportEd.Hint := 'Редактировать параметры';

     cbm_byEnableArchiv.Enabled := not bo;
     edm_sArchPath.ReadOnly     := bo;
     edm_sSrcPath.ReadOnly      := bo;
     cbm_tmArchPeriod.Enabled   := not bo;
     tmm_dtEnterArchTime.Enabled   := not bo;

    End;
end;

procedure TTL5Config.b_ExportDataClick(Sender: TObject);
var
    ds, de : TDateTime;
begin
    if m_pGenTable.m_sSetForETelecom=1 then
    Begin
    if (not m_Export2My.m_boIsConnected) then
    begin
        mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Подключение не установлено!');
        exit;
    end;
    ds := mysqlSDate.DateTime;
    de := mysqlEDate.DateTime;
    //ds := dtm_sdtEndMy.DateTime;
    //de := dtm_sdtBeginMy.DateTime;
    m_Export2My.ExportValues(ds, de);
    m_Export2My.SetLastDate(de);
    End;
end;
procedure TTL5Config.b_ExportDataBytClick(Sender: TObject);
var
    ds, de : TDateTime;
begin
    if m_pGenTable.m_sSetForETelecom=1 then
    Begin
    if (not m_Export2My.m_boIsConnected) then
    begin
        mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Подключение не установлено!');
        exit;
    end;
    ds := mysqlSDate.DateTime;
    de := mysqlEDate.DateTime;
    m_Export2My.ExportBytValues(ds, de);
    m_Export2My.ExportBytTeploValues(ds, de);

    m_Export2My.SetLastDate(de);
    End;
end;
procedure TTL5Config.b_ExportWClick(Sender: TObject);
begin
    with m_pGenTable do
    Begin
     mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Сохранение параметров модуля экспорта');
     {MySQL}
     //m_dtEStart       := dtMysqlES.Time;
     //m_dtEInt         := dtMysqlINT.Time;
     m_SDBPORT        := StrToInt(mysqlPORT.Text);
     m_SDBSERVER      := mysqlSERVER.Text;
     m_sDBNAME        := mysqlDATABASE.Text;
     m_sDBUSR         := mysqlUSER.Text;
     m_sDBPASSW       := mysqlPASSW.Text;
     {Archive}
     m_byEnableArchiv := cbm_byEnableArchiv.ItemIndex;
     m_sArchPath      := edm_sArchPath.Text;
     m_sSrcPath       := edm_sSrcPath.Text;
     m_tmArchPeriod   := cbm_tmArchPeriod.ItemIndex;
     m_dtEnterArchTime:= tmm_dtEnterArchTime.DateTime;

     m_pDB.SetMyGenSettTable(m_pGenTable);
     m_Export2My.SaveUnloadSett;
     m_Export2My.ReInit();
    End;
end;
procedure TTL5Config.b_ExportRClick(Sender: TObject);
begin
    mMySQLStat.Lines.Add(TimeToStr(Now())+ ' ::> Чтение параметров модуля экспорта');
    with m_pGenTable do
    Begin
     {MySql}
     //dtMysqlES.Time               := m_dtEStart;
     //dtMysqlINT.Time              := m_dtEInt;
     mysqlSERVER.Text             := m_SDBSERVER;
     mysqlDATABASE.Text           := m_sDBNAME;
     mysqlUSER.Text               := m_sDBUSR;
     mysqlPASSW.Text              := m_sDBPASSW;
     {Archiv}
     cbm_byEnableArchiv.ItemIndex := m_byEnableArchiv;
     edm_sArchPath.Text           := m_sArchPath;
     edm_sSrcPath.Text            := m_sSrcPath;
     cbm_tmArchPeriod.ItemIndex   := m_tmArchPeriod;
     tmm_dtEnterArchTime.DateTime := m_dtEnterArchTime;
    End;
end;

procedure TTL5Config.mMySQLStatDblClick(Sender: TObject);
begin
 mMySQLStat.Lines.Clear;
end;

procedure TTL5Config.b_ExportOffClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_OF,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Останов экспорта...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Останов удаленного экспорта...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DT_OF_REQ,pDS);
end;

procedure TTL5Config.b_ExportOnClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_ON,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Запуск экспорта...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Запуск удаленного экспорта...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DT_ON_REQ,pDS);
end;

procedure TTL5Config.b_ExportInitClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_INIT,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Инициализация экспорта...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Инициализация удаленного экспорта...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DTINI_REQ,pDS);
end;
procedure TTL5Config.ExportON;
Begin
    m_Export2My.OnExportOn;
End;
procedure TTL5Config.ExportOF;
Begin
    m_Export2My.OnExportOff;
End;
procedure TTL5Config.ExportIN;
Begin
    m_pDB.GetGenSettTable(m_pGenTable);
    m_Export2My.OnExportInit;
End;
procedure TTL5Config.OnHandArchive(Sender: TObject);
begin
    m_nBA.OnHandArchivate;
end;

procedure TTL5Config.OnOpenArchSource(Sender: TObject);
begin
    OpenDialog1.DefaultExt := 'fbk';
    OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
    OpenDialog1.FileName   := 'sysinfoauto.fbk';
    OpenDialog1.Filter     := 'Файлы баз данных|*.fbk;*.fdb';
    try
     if OpenDialog1.Execute=True then
     edm_sSrcPath.Text := OpenDialog1.FileName;
    except
    end;
end;

procedure TTL5Config.OnDestArchPath(Sender: TObject);
begin
    SaveDialog1.DefaultExt := 'fbk';
    SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName)+'Archive';
    SaveDialog1.FileName   := '1.fbk';
    SaveDialog1.Filter     := 'Файлы баз данных|*.fbk;*.fdb';
    try
    if SaveDialog1.Execute=True then
    Begin
     if SaveDialog1.FileName<>'' then
     edm_sArchPath.Text := ExtractFilePath(SaveDialog1.FileName);
    End;
    except
     
    end;
end;

procedure TTL5Config.AdvToolBarButton40Click(Sender: TObject);
begin
 m_Export2My.OnExport();
end;

{
procedure CL3FindHolesModule.SendMSGToLoad(VMID, MID, PID : integer; Date : TDateTime);
var pDS    : CMessageData;
    szDT   : Integer;
begin
   szDT          := sizeof(TDateTime);
   pDS.m_swData0 := VMID;
   pDS.m_swData1 := PID;
   pDS.m_swData2 := MID;
   pDS.m_swData3 := GetRealPort(PortID);
   pDS.m_swData4 := MTR_LOCAL;
   move(Date, pDS.m_sbyInfo[0], szDT);
   move(Date, pDS.m_sbyInfo[szDT], szDT);
   SendMsgData(BOX_LOAD, pDS.m_swData2, DIR_LHTOLM3, QL_DATA_GRAPH_REQ, pDS);
end;
}
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
   if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Запустить поиск данных?';End;
   if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Запустить поиск данных удаленно?';End;
   if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin

    if cbm_nPriDay.Checked=True   then dwLoMask := dwLoMask or (dwOne shl 0);
    if cbm_nPriMonth.Checked=True then dwLoMask := dwLoMask or (dwOne shl 1);
    if cbm_nPri30.Checked=True    then dwLoMask := dwLoMask or (dwOne shl 2);
    if cbm_nNakDay.Checked=True   then dwLoMask := dwLoMask or (dwOne shl 3);
    if cbm_nNakMonth.Checked=True then dwLoMask := dwLoMask or (dwOne shl 4);
    pDS.m_swData0 := -1;
    pDS.m_swData1 := -1;
    ldtFTime := dtFTime.DateTime;
    ldtETime := dtETime.DateTime;
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

procedure TTL5Config.OnChFTime(Sender: TObject);
begin
   if dtFTime.DateTime>Now then dtFTime.DateTime := Now;
   dtETime.DateTime := dtFTime.DateTime;
   //if dtFTime.DateTime>Now then dtFTime.DateTime := Now;
   //if dtETime.DateTime>Now then dtETime.DateTime := Now;
   //if dtETime.DateTime>dtFTime.DateTime then dtETime.DateTime := dtFTime.DateTime;
end;

procedure TTL5Config.OnChEtime(Sender: TObject);
begin
   if dtETime.DateTime>Now then dtETime.DateTime := Now;
   if dtETime.DateTime>dtFTime.DateTime then dtFTime.DateTime := dtETime.DateTime;
end;



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

procedure TTL5Config.ab_DBFExportClick(Sender: TObject);
begin
   m_Export2DBF.InitTree();
   //m_Export2DBF.ExportData(dt_EDBFStart.DateTime, dt_EDBFEnd.DateTime);
   m_Export2DBF.InitTree();
end;

procedure TTL5Config.ab_VTExportClick(Sender: TObject);
begin
   m_ExportVT.InitTree();
   //m_Export2DBF.ExportData(dt_EDBFStart.DateTime, dt_EDBFEnd.DateTime);
   m_ExportVT.InitTree();
end;


procedure TTL5Config.ab_DBFStartClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_OF,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Запуск экспорта...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Запуск удаленного экспорта...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DT_ON_REQ,pDS);
end;

procedure TTL5Config.ab_DBFStopClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
//    m_pDB.FixUspdDescEvent(0,3,EVS_EXPRT_OF,0);

    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Останов экспорта...';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Останов удаленного экспорта...';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3, QL_EXPORT_DT_OF_REQ,pDS);
end;

procedure TTL5Config.OnDbfOpenPath(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strPath.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
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
// Диалог выбора директории с кнопкой "Создать папку" 
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

procedure TTL5Config.ab_DBFConfSaveClick(Sender: TObject);
begin
   m_Export2DBF.OnSaveParam;
end;

procedure TTL5Config.ab_VTConfSaveClick(Sender: TObject);
begin
   m_ExportVT.OnSaveParam;
end;


procedure TTL5Config.ab_DBFEModeClick(Sender: TObject);
begin
   {
   if (e_DBFLoc.Enabled) then
   begin
      e_DBFLoc.Enabled := true;
      dt_EDBFStart.Enabled := true;
      dt_EDBFEnd.Enabled := true;
   end
   else
   begin
      e_DBFLoc.Enabled := true;
      dt_EDBFStart.Enabled := true;
      dt_EDBFEnd.Enabled := true;
   end;
   }
end;

procedure TTL5Config.OnChandgeIPClick(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Выполнить строку инциализации?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Выполнить строку инциализации удаленно?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CHANDGE_IP_REQ,pDS);
    //if m_blCL3TariffEditor=True  then m_pDB.FixUspdEvent(0,3,EVU_TZONE_ED_ON) else
    //if m_blCL3TariffEditor=False then m_pDB.FixUspdEvent(0,3,EVU_TZONE_ED_OF);
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

procedure TTL5Config.OnCloseUspd(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    FillChar(pDS,sizeof(pDS),0);
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Остановить приложение УСПД. Уверенны?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Остановить удаленное приложение УСПД. Уверенны?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin OnQweryReboot;exit;End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CLOSE_USPD_REQ,pDS);
    End;
end;
procedure TTL5Config.OnQweryReboot;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Перезапустить программу в УСПД ',mtWarning,[mbOk,mbCancel],0)=mrOk then
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
   if MessageDlg('Установить удаленный сеанс на ' +
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
procedure TTL5Config.OnSmartFinder(Sender: TObject);
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Включить функцию поиска пустот ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 10; //10
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
procedure TTL5Config.SetInitRemCrcQry;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Инициализировать конфигурацию УСПД? ',mtWarning,[mbOk,mbCancel],0)=mrOk then
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

procedure TTL5Config.OffSmartFinder(Sender: TObject);
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Выключить функцию поиска пустот ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 10;
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

procedure TTL5Config.OnSqlQwery(Sender: TObject);
Var
    Fl       : TINIFile;
    strSQL   : String;
    m_nTxMsg : CMessage;
    fnc,wCRC : Word;
    FPRID,nLen,i : integer;
Begin
    try
     Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'\Settings\USPD_Config.ini');
      strSQL := Fl.ReadString('DBCONFIG','DBAddField',' ');
     Fl.Destroy;
     if MessageDlg('Выполнить SQL запрос: '+strSQL,mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      FPRID := 0;
      FillChar(m_nTxMsg.m_sbyInfo[0],500,0);
      nLen := Length(strSQL);
      Move(nLen,m_nTxMsg.m_sbyInfo[6],2);
      for i:=0 to nLen do m_nTxMsg.m_sbyInfo[8+i] := Byte(strSQL[i+1]);

      if m_blIsRemCrc=True then
      Begin
       CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (6+nLen+2)+4, $FF17);
       CreateLMSGHeadCrcRem(FPRID,m_nTxMsg, (6+nLen+2)+4);
      End else
      if m_blIsRemEco=True then
      Begin
       m_nTxMsg.m_sbyInfo[0] := 1;
       m_nTxMsg.m_sbyInfo[1] := 212;
       wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 6+nLen+2);
       m_nTxMsg.m_sbyInfo[6+nLen+2] := Lo(wCRC);
       m_nTxMsg.m_sbyInfo[6+nLen+2+1] := Hi(wCRC);
       CreateLMSGHeadCrcRem(FPRID,m_nTxMsg, (6+nLen+2+2));
      End;
      if m_blIsRemC12=True then
      Begin
       m_nTxMsg.m_sbyInfo[0] := 1;
       m_nTxMsg.m_sbyInfo[1] := $FA;
       m_nTxMsg.m_sbyInfo[2] := 212;
       CRC_C12(m_nTxMsg.m_sbyInfo[0], 6+nLen+2+2);
       CreateLMSGHeadCrcRem(FPRID,m_nTxMsg, (6+nLen+2+2));
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
      //FPUT(BOX_L1, @m_nTxMsg);
      if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then
      FPUT(BOX_L1, @m_nTxMsg);
      End;
    except
    end;
End;
procedure TTL5Config.OnExportFMAK(Sender: TObject);
begin
    if m_Export2FMAK.ExportDataEx(dtLoTime.DateTime-1,dtHiTime.DateTime-1)=True then
     lbExportTime.Caption:=FormatDateTime('dd.mm.yy hh:mm:ss', now);
end;
procedure TTL5Config.OnStartFMAK(Sender: TObject);
begin
    m_Export2FMAK.OnExportOn;
    cbm_sSetForETelecom.ItemIndex:=1;
    OnChandgeExport(self);
    lbExportStatus.Caption:='Запущен';
end;
procedure TTL5Config.OnStopFMAK(Sender: TObject);
begin
    m_Export2FMAK.OnExportOff;
    cbm_sSetForETelecom.ItemIndex:=0;
    OnChandgeExport(self);
    lbExportStatus.Caption:='Остановлен';
end;

procedure TTL5Config.OnEditFMAK(Sender: TObject);
Var
     bl:Boolean;
begin
     bl := Boolean(btEditFmak);
     btEditFmak := (not bl);
     dtLoTime.Enabled := bl;
     dtHiTime.Enabled := bl;
     dtm_dtEStart.Enabled := bl;
     cbm_nEInt.Enabled := bl;
     edm_sMAKLOCATION.Enabled := bl;
     edm_sHOSTMAK.Enabled := bl;
     edm_sEMAILMAK.Enabled := bl;
     edm_sPASSMAK.Enabled := bl;
     cbPASSMAK.Enabled := bl;
     edm_sNAMEMAILMAK.Enabled := bl;
     cbm_blMdmExp.Enabled := bl;
     cbM_BLFMAKDELFILE.Enabled := bl;
     cbm_blExportLast.Enabled := bl;
end;

procedure TTL5Config.cbPASSMAKClick(Sender: TObject);
begin
     if cbPASSMAK.Checked=True  then edm_sPASSMAK.PasswordChar := #0 else
     if cbPASSMAK.Checked=False then edm_sPASSMAK.PasswordChar := '*';
end;

procedure TTL5Config.OnUpdateArm(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    FillChar(pDS,sizeof(pDS),0);
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Обновить приложение АРМ. Уверенны?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Обновить удаленное приложение АРМ. Уверенны?';End;
    if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     //if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin OnQweryReboot;exit;End;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_UPDAT_ARM_REQ,pDS);
    End;
End;
procedure TTL5Config.UpdateARM;
Var
    pDS : CMessageData;
begin
    FillChar(pDS,sizeof(pDS),0);
    pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_UPDAT_ARM_REQ,pDS);
End;
procedure TTL5Config.SelfUpdate;
Var
    wnd : HWND;
Begin
    wnd := FindWindow(LPCTSTR('TTKnsMonitor'), nil);
    if wnd <> 0 then SendMessage(wnd,WM_SENDTOMNUPDATE, 0, 0);
End;

procedure TTL5Config.OnSendReload(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
    FillChar(pDS,sizeof(pDS),0);
    if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Перезагрузить приложение УСПД. Уверенны?';End;
    if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Перезагрузить удаленное приложение УСПД. Уверенны?';End;
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

procedure TTL5Config.RunSharedAccess;
begin
   ServiceStart('', 'SharedAccess');
end;

procedure TTL5Config.StopSharedAccess;
begin
   ServiceStop('', 'SharedAccess');
end;

procedure TTL5Config.EnableRD;
var Reg : TRegistry;
begin
   Reg := TRegistry.Create;
   try
     Reg.RootKey := HKEY_LOCAL_MACHINE;
     Reg.OpenKey('System\CurrentControlSet\Control\Terminal Server',true);
     Reg.WriteInteger('fDenyTSConnections', 0);
   finally
     Reg.Free;
   end;
end;

procedure TTL5Config.DisableRD;
var Reg : TRegistry;
begin
   Reg := TRegistry.Create;
   try
     Reg.RootKey := HKEY_LOCAL_MACHINE;
     Reg.OpenKey('System\CurrentControlSet\Control\Terminal Server',true);
     Reg.WriteInteger('fDenyTSConnections', 1);
   finally
     Reg.Free;
   end;
end;

procedure TTL5Config.StartAmmy;
begin
   StartProcess('C:\a2000\ascue\Restore\AA_v3.exe', false);
   //StartProcess('AA_v3.exe -install', false);
end;

procedure TTL5Config.StopAmmy;
begin
   //StartProcess('AA_v3.exe -remove', false);
end;

function TTL5Config.ServiceStart(aMachine, aServiceName: string ): boolean;
// aMachine это UNC путь, либо локальный компьютер если пусто
var
  h_manager,h_svc: SC_Handle;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWord;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName),
    SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc,0,temp)) then
        if (QueryServiceStatus(h_svc,svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            //Sleep(svc_status.dwWaitHint);
            if (not QueryServiceStatus(h_svc,svc_status)) then
              break;
            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              // QueryServiceStatus не увеличивает dwCheckPoint
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;

function TTL5Config.ServiceStop(aMachine,aServiceName: string ): boolean;
// aMachine это UNC путь, либо локальный компьютер если пусто
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  dwCheckPoint: DWord;
begin
  h_manager:=OpenSCManager(PChar(aMachine),nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(aServiceName),
    SERVICE_STOP or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP, svc_status))then
      begin
        if(QueryServiceStatus(h_svc,svc_status))then
        begin
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            //Sleep(svc_status.dwWaitHint);
            if(not QueryServiceStatus(h_svc,svc_status))then
            begin
              // couldn't check status
              break;
            end;
            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;
          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
end;

//Чтобы узнать состояние сервиса, используйте следующую функцию:
function TTL5Config.ServiceGetStatus(sMachine, sService: string ): DWord;
var
  h_manager, h_svc: SC_Handle;
  service_status: TServiceStatus;
  hStat: DWord;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine) ,nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(sService), SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(QueryServiceStatus(h_svc, service_status)) then
        hStat := service_status.dwCurrentState;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := hStat;
end;

function TTL5Config.StartProcess(strPath:String;blWait:Boolean):Boolean;
Var
     si : STARTUPINFO;
     pi : PROCESS_INFORMATION;
     iRes : Boolean;
     dwRes: LongWord;
begin
     FillChar(si,sizeof(si),0);
     FillChar(pi,sizeof(pi),0);
     si.cb := sizeof(si);
     si.wShowWindow:=SW_HIDE;
     si.dwFlags:= STARTF_USESHOWWINDOW;
     iRes := CreateProcess(Nil, PChar(strPath), Nil, Nil, FALSE, NORMAL_PRIORITY_CLASS, Nil, Nil, si, pi);
     if(iRes=False) then
     begin
      TraceL(4,0,':Process is not created');
      result := FALSE;
     end;
     if(blWait) then
     begin
      dwRes := WaitForSingleObject(pi.hProcess,14*60*1000);
      if(dwRes=WAIT_ABANDONED) then TraceL(4,0,':Process is abandoned!');
     end;
     CloseHandle( pi.hProcess );
     CloseHandle( pi.hThread );
     result := True;
end;

procedure TTL5Config.miHandExportClick(Sender: TObject);
begin
     m_Export2DBF.OnHandExport;
end;

procedure TTL5Config.miDBFLoadClick(Sender: TObject);
begin
    m_Export2DBF.OnLoadParam;
end;

procedure TTL5Config.miDBFEnableClick(Sender: TObject);
begin
    m_Export2DBF.OnExportOn;
end;

procedure TTL5Config.miDBFDisableClick(Sender: TObject);
begin
    m_Export2DBF.OnExportOff;
end;

procedure TTL5Config.advDBFAbonClearClick(Sender: TObject);
begin
    m_Export2DBF.OnAbonClear;
end;



procedure TTL5Config.miHandVTExportClick(Sender: TObject);
begin
     m_ExportVT.OnHandExport;
end;

procedure TTL5Config.miVTLoadClick(Sender: TObject);
begin
    m_ExportVT.OnLoadParam;
end;

procedure TTL5Config.miVTEnableClick(Sender: TObject);
begin
    m_ExportVT.OnExportOn;
end;

procedure TTL5Config.miVTDisableClick(Sender: TObject);
begin
    m_ExportVT.OnExportOff;
end;

procedure TTL5Config.advVTAbonClearClick(Sender: TObject);
begin
    m_ExportVT.OnAbonClear;
end;


procedure TTL5Config.chm_sdwMonthMaskClick(Sender: TObject);
begin
     if chm_sdwMonthMask.Checked=True then
     Begin
      chm_swDayMask.Checked    := False; chm_swDayMaskClick(self);
      clm_sdwMonthMask.Enabled := True;
     End else
     if chm_sdwMonthMask.Checked=False then
     Begin
      clm_sdwMonthMask.Enabled := False;
     End;
end;

procedure TTL5Config.chm_swDayMaskClick(Sender: TObject);
begin
     if chm_swDayMask.Checked=True then
     Begin
      chm_sdwMonthMask.Checked:=False; chm_sdwMonthMaskClick(self);
      clm_swDayMask.Enabled := True;
     End else
     if chm_swDayMask.Checked=False then
     Begin
      clm_swDayMask.Enabled := False;
     End;
end;

procedure TTL5Config.miOnSetDBFClick(Sender: TObject);
begin
     m_Export2DBF.OnExportInit;
end;

procedure TTL5Config.advOnSaveDBFClick(Sender: TObject);
begin
     m_Export2DBF.OnSaveParam;
end;

procedure TTL5Config.advOnSetDBFClick(Sender: TObject);
begin
     m_Export2DBF.OnExportInit;
end;

procedure TTL5Config.advOnHandExportClick(Sender: TObject);
begin
     m_Export2DBF.OnHandExport;
end;

procedure TTL5Config.OnDbfOpenPath1(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strPath1.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;

procedure TTL5Config.cbm_nUnlPowerClick(Sender: TObject);
begin
    m_Export2DBF.cbm_nUnlPowerClick(Sender);
end;


procedure TTL5Config.miVTOnSetDBFClick(Sender: TObject);
begin
     m_ExportVT.OnExportInit;
end;

procedure TTL5Config.chm_sdwVTMonthMaskClick(Sender: TObject);
begin
     if chm_sdwVTMonthMask.Checked=True then
     Begin
      chm_swVTDayMask.Checked    := False; chm_swVTDayMaskClick(self);
      clm_sdwVTMonthMask.Enabled := True;
     End else
     if chm_sdwVTMonthMask.Checked=False then
     Begin
      clm_sdwVTMonthMask.Enabled := False;
     End;
end;

procedure TTL5Config.chm_swVTDayMaskClick(Sender: TObject);
begin
     if chm_swVTDayMask.Checked=True then
     Begin
      chm_sdwVTMonthMask.Checked:=False; chm_sdwVTMonthMaskClick(self);
      clm_swVTDayMask.Enabled := True;
     End else
     if chm_swVTDayMask.Checked=False then
     Begin
      clm_swVTDayMask.Enabled := False;
     End;
end;

procedure TTL5Config.advVTOnSaveDBFClick(Sender: TObject);
begin
     m_ExportVT.OnSaveParam;
end;

procedure TTL5Config.advVTOnSetDBFClick(Sender: TObject);
begin
     m_ExportVT.OnExportInit;
end;

procedure TTL5Config.advVTOnHandExportClick(Sender: TObject);
begin
     m_ExportVT.OnHandExport;
end;

procedure TTL5Config.OnVTOpenPath1(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strVTPath1.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;

procedure TTL5Config.cbm_nVTUnlPowerClick(Sender: TObject);
begin
    m_ExportVT.cbm_nVTUnlPowerClick(Sender);
end;

procedure TTL5Config.miStartGprsClick(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Запустить GPRS роутер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_GPRS_REQ,pDS);
    End;
end;
procedure TTL5Config.miStopGprsClick(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Остановить GPRS роутер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_STOP_GPRS_REQ,pDS);
    End;
end;

procedure TTL5Config.chm_swDayMaskMyClick(Sender: TObject);
begin
     if chm_swDayMaskMy.Checked=True then
     Begin
      chm_sdwMonthMaskMy.Checked:=False; chm_sdwMonthMaskMyClick(self);
      clm_swDayMaskMy.Enabled := True;
     End else
     if chm_swDayMaskMy.Checked=False then
     Begin
      clm_swDayMaskMy.Enabled := False;
     End;
end;

procedure TTL5Config.chm_sdwMonthMaskMyClick(Sender: TObject);
begin
     if chm_sdwMonthMaskMy.Checked=True then
     Begin
      chm_swDayMaskMy.Checked    := False; chm_swDayMaskMyClick(self);
      clm_sdwMonthMaskMy.Enabled := True;
     End else
     if chm_sdwMonthMaskMy.Checked=False then
     Begin
      clm_sdwMonthMaskMy.Enabled := False;
     End;
end;

procedure TTL5Config.chm_sbyFindDataMyClick(Sender: TObject);
begin
     {
     if chm_sbyFindDataMy.Checked=True then
     Begin
      chm_sbyFindDataMy.Checked  := False;
     End else
     if chm_sbyFindDataMy.Checked=False then
     Begin
      chm_sbyFindDataMy.Checked := False;
     End;
     }
end;
procedure TTL5Config.mysqlEDateChange(Sender: TObject);
begin
     if mysqlEDate.DateTime<mysqlSDate.DateTime then
     mysqlSDate.DateTime := mysqlEDate.DateTime
end;

procedure TTL5Config.cbEnPasswClick(Sender: TObject);
begin
   if cbEnPassw.Checked=True  then mysqlPASSW.PasswordChar := #0 else
   if cbEnPassw.Checked=False then mysqlPASSW.PasswordChar := '*';
end;

procedure TTL5Config.GPRS1Click(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Инициализировать GPRS роутер?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INIT_GPRS_REQ,pDS);
    End;
end;



procedure TTL5Config.ab_DBFConfSaveClickMg(Sender: TObject);
begin
    m_ExportMog.OnSaveParam;
end;

procedure TTL5Config.miDBFLoadClickMg(Sender: TObject);
begin
    m_ExportMog.OnLoadParam;
end;

procedure TTL5Config.miHandExportClickMg(Sender: TObject);
begin
    m_ExportMog.OnHandExport;
end;

procedure TTL5Config.miDBFEnableClickMg(Sender: TObject);
begin
    m_ExportMog.OnExportOn;
end;

procedure TTL5Config.miDBFDisableClickMg(Sender: TObject);
begin
    m_ExportMog.OnExportOff;
end;

procedure TTL5Config.miOnSetDBFClickMg(Sender: TObject);
begin
    m_ExportMog.OnExportInit;
end;

procedure TTL5Config.OnDbfOpenPathMg(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strPathMg.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;

procedure TTL5Config.OnDbfOpenPathMg1(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strPathMg1.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;

procedure TTL5Config.advDBFAbonClearClickMg(Sender: TObject);
begin
    m_ExportMog.OnAbonClear;
end;

procedure TTL5Config.chm_swDayMaskClickMg(Sender: TObject);
begin
     if chm_swDayMaskMg.Checked=True then
     Begin
      chm_sdwMonthMaskMg.Checked:=False; chm_sdwMonthMaskClickMg(self);
      clm_swDayMaskMg.Enabled := True;
     End else
     if chm_swDayMaskMg.Checked=False then
     Begin
      clm_swDayMaskMg.Enabled := False;
     End;
end;

procedure TTL5Config.chm_sdwMonthMaskClickMg(Sender: TObject);
begin
     if chm_sdwMonthMaskMg.Checked=True then
     Begin
      chm_swDayMaskMg.Checked    := False; chm_swDayMaskClickMg(self);
      clm_sdwMonthMaskMg.Enabled := True;
     End else
     if chm_sdwMonthMaskMg.Checked=False then
     Begin
      clm_sdwMonthMaskMg.Enabled := False;
     End;
end;

procedure TTL5Config.mgsqlEDateChange(Sender: TObject);
begin
     if mgsqlEDate.DateTime<mgsqlSDate.DateTime then
     mgsqlSDate.DateTime := mgsqlEDate.DateTime
end;

procedure TTL5Config.miHandExportPeriodMg(Sender: TObject);
begin
     m_ExportMog.OnHandExportPerid(mgsqlEDate.DateTime,mgsqlSDate.DateTime);
end;

procedure TTL5Config.VTOnDbfOpenPath(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strVTPath.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;

procedure TTL5Config.VTOnDbfOpenPath1(Sender: TObject);
var
    Dir: string;
begin
   Dir := ExtractFilePath(Application.ExeName);
   em_strVTPath1.Text := SelectDirPlus(self.Handle, GetCurrentDir, '');
end;


destructor TTL5Config.Destroy;
begin
  if m_nSDL <> nil then FreeAndNil(m_nSDL);
  if m_nUMN <> nil then FreeAndNil(m_nUMN);
  if m_nTT <> nil then FreeAndNil(m_nTT);
  if m_nSetColor <> nil then FreeAndNil(m_nSetColor);
  if m_nUsrCtrl <> nil then FreeAndNil(m_nUsrCtrl);
  if m_nBA <> nil then FreeAndNil(m_nBA);
  if m_Export2FMAK <> nil then FreeAndNil(m_Export2FMAK);
  if m_Export2My <> nil then FreeAndNil(m_Export2My);
  if m_Export2DBF <> nil then FreeAndNil(m_Export2DBF);
  if m_ExportMog <> nil then FreeAndNil(m_ExportMog);
  if m_ExportVT <> nil then FreeAndNil(m_ExportVT);
  if m_Export2FMAK <> nil then FreeAndNil(m_Export2FMAK);
  if m_nEventList <> nil then FreeAndNil(m_nEventList);

  inherited;
end;

end.
