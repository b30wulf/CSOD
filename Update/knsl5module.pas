unit knsl5module;
{$DEFINE TRAY_MINIMIZE}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ComCtrls, ToolWin, jpeg, StdCtrls, Grids, BaseGrid,utlTimeDate,
  AdvGrid,utlbox, ImgList, RbDrawCore, RbButton,utlconst,utltypes,registry,mmsystem,
  ShellApi,inifiles,
  knsl3VectorFrame,
  knsl5tracer,
  knsl1editor,
  knsl2editor,
  knsl3EventBox,
  knsl4Unloader,
  knsl3FrmMonitor,
  //knsl2cmdeditor,
  knsl2parameditor,
  knsl2mtypeeditor,
  knsl3groupeditor,
  knsl3vmetereditor,
  knsl3vparameditor,
  knsl2editframe,
  knsl3tartypeeditor,
  knsl3tarplaneeditor,
  knsl3ConnEditor,
  knsl3szneditor,
  utldatabase,
  knsl1module,
  knsl2module,
  knsl3module,
  knsl4module,
  knsl3lme,
  knsl2treeloader,
  knsl3treeloader,
  knsl4connfrm,
  knsl3report,
  knsl2timers,
  knsl5config,
  knsl4secman,
  knsl2BTIInit,
  knsl5events,
  knsl5users,
  knsl3datafinder,
  TeEngine, Series, TeeProcs, Chart, Db,Parser10, ADODB, asgprev,utlexparcer,
  knsl2statistic,
  knslAbout,
  knsl3FHModule,
  knsl3transtime,
  knsl3selftestmodule,
  knsl3abon,
  knsl3aboneditor,
  knsl2treehandler,
  knsl3chandge,
  knsl3addregions,
  knsl3savetime,
  knsl2fqwerymdl,
  knsl3shem,
  SchemDriver,
  knsl2QweryTrServer,
  kns3CalcTrServer,
  kns3SaveTrServer,
  knslLoadMainForm, ScktComp, AdvOfficePager, AdvToolBar, WinXP, AdvPanel,
  AdvOfficePagerStylers, AdvToolBarStylers, AdvGroupBox, AdvSplitter,
  AdvMenus, AdvMenuStylers, AdvGlowButton, AdvAppStyler, AdvOfficeButtons,
  mswheel, AdvOfficeStatusBar, AdvOfficeStatusBarStylers,
  AdvOfficeSelectors, paramtreeview, AdvListV, AdvCardListStyler,
  AdvCardList, AdvSmoothEdit, AdvSmoothEditButton, AdvSmoothDatePicker,
  AdvNavBar, ToolPanels, knsl3LimitEditor, AdvShapeButton;


const
  WM_MOUSE_CLICK_KNS = WM_USER + 1;
  WM_GOTOFOREGROUND  = WM_USER + 2;
type
  TTKnsForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Label2: TLabel;
    Label3: TLabel;
    ImageListTree: TImageList;
    msbImgList: TImageList;
    ImageListTbPr: TImageList;
    Label8: TLabel;
    ppmForTree: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Label9: TLabel;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    inglLeftTool: TImageList;
    ppmForTreeData: TPopupMenu;
    N15: TMenuItem;
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
    N26: TMenuItem;
    N27: TMenuItem;
    imgEditPannel: TImageList;
    pmParamEditor: TPopupMenu;
    N28: TMenuItem;
    grPpMenu: TPopupMenu;
    N29: TMenuItem;
    qmPMenu: TPopupMenu;
    N30: TMenuItem;
    ppL2Editor: TPopupMenu;
    N31: TMenuItem;
    svSaveDProto: TSaveDialog;
    ImageListEdit1: TImageList;
    ImageListBotEdit1: TImageList;
    ImageListBotData1: TImageList;
    ImageListTreePC1: TImageList;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
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
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    ImageListMenu1: TImageList;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    AdvPreviewDialog1: TAdvPreviewDialog;
    ServerSocket1: TServerSocket;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    WinXP: TWinXP;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    advPannCurrState: TAdvPanel;
    advTreePanel: TAdvPanel;
    advToolPannel: TAdvPanel;
    advTopToolBar: TAdvToolBar;
    AdvPopupMenu1: TAdvPopupMenu;
    advDataPanel: TAdvPanel;
    splHorSplitt: TAdvSplitter;
    pcPEditor: TAdvOfficePager;
    AdvOfficePage8: TAdvOfficePage;
    AdvOfficePage7: TAdvOfficePage;
    AdvOfficePage9: TAdvOfficePage;
    AdvOfficePage10: TAdvOfficePage;
    AdvOfficePage11: TAdvOfficePage;
    AdvPanel25: TAdvPanel;
    AdvPanel26: TAdvPanel;
    AdvToolBar10: TAdvToolBar;
    AdvToolBarButton70: TAdvToolBarButton;
    AdvToolBarButton71: TAdvToolBarButton;
    AdvToolBarButton72: TAdvToolBarButton;
    AdvToolBarButton79: TAdvToolBarButton;
    AdvToolBarButton80: TAdvToolBarButton;
    AdvPanel27: TAdvPanel;
    AdvToolBar11: TAdvToolBar;
    AdvToolBarButton81: TAdvToolBarButton;
    AdvToolBarButton82: TAdvToolBarButton;
    AdvToolBarButton83: TAdvToolBarButton;
    AdvToolBarButton85: TAdvToolBarButton;
    AdvToolBarButton86: TAdvToolBarButton;
    AdvPanel28: TAdvPanel;
    AdvToolBar13: TAdvToolBar;
    AdvToolBarButton87: TAdvToolBarButton;
    AdvToolBarButton88: TAdvToolBarButton;
    AdvToolBarButton89: TAdvToolBarButton;
    AdvToolBarButton90: TAdvToolBarButton;
    AdvToolBarButton91: TAdvToolBarButton;
    AdvToolBarButton92: TAdvToolBarButton;
    AdvPanel29: TAdvPanel;
    AdvToolBar14: TAdvToolBar;
    AdvToolBarButton93: TAdvToolBarButton;
    AdvToolBarButton94: TAdvToolBarButton;
    AdvToolBarButton95: TAdvToolBarButton;
    AdvToolBarButton97: TAdvToolBarButton;
    AdvToolBarButton98: TAdvToolBarButton;
    pcView: TAdvOfficePager;
    AdvOfficePage12: TAdvOfficePage;
    AdvOfficePage13: TAdvOfficePage;
    AdvOfficePage14: TAdvOfficePage;
    AdvPanel30: TAdvPanel;
    AdvToolBar15: TAdvToolBar;
    AdvToolBarButton99: TAdvToolBarButton;
    AdvToolBarButton100: TAdvToolBarButton;
    AdvToolBarButton101: TAdvToolBarButton;
    AdvToolBarButton102: TAdvToolBarButton;
    AdvPanel31: TAdvPanel;
    AdvPanel32: TAdvPanel;
    sgQMCommand: TAdvStringGrid;
    sgVParam: TAdvStringGrid;
    sgTariff: TAdvStringGrid;
    sgCGrid: TAdvStringGrid;
    sgEGrid: TAdvStringGrid;
    sgPGrid: TAdvStringGrid;
    AdvToolBarButton78: TAdvToolBarButton;
    AdvToolBar17: TAdvToolBar;
    AdvToolBarButton105: TAdvToolBarButton;
    AdvToolBarButton106: TAdvToolBarButton;
    AdvToolBarButton107: TAdvToolBarButton;
    AdvToolBarButton108: TAdvToolBarButton;
    AdvToolBar16: TAdvToolBar;
    AdvToolBarButton84: TAdvToolBarButton;
    AdvToolBarButton96: TAdvToolBarButton;
    AdvToolBarButton104: TAdvToolBarButton;
    AdvPanel33: TAdvPanel;
    pcGEditor: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvGroupBox1: TAdvGroupBox;
    AdvOfficePager12: TAdvOfficePage;
    AdvPanel13: TAdvPanel;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarButton: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarButton5: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    AdvPanel11: TAdvPanel;
    sgParam: TAdvStringGrid;
    AdvOfficePager13: TAdvOfficePage;
    AdvPanel9: TAdvPanel;
    AdvPanel12: TAdvPanel;
    sgMeterType: TAdvStringGrid;
    AdvToolBar2: TAdvToolBar;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton7: TAdvToolBarButton;
    AdvToolBarButton8: TAdvToolBarButton;
    AdvToolBarButton9: TAdvToolBarButton;
    AdvToolBarButton10: TAdvToolBarButton;
    AdvToolBarButton11: TAdvToolBarButton;
    AdvOfficePage1: TAdvOfficePage;
    AdvSplitter5: TAdvSplitter;
    AdvSplitter9: TAdvSplitter;
    AdvPanel8: TAdvPanel;
    AdvPanel14: TAdvPanel;
    sgMeters: TAdvStringGrid;
    AdvPanel131: TAdvPanel;
    sgChannels: TAdvStringGrid;
    AdvOfficePage2: TAdvOfficePage;
    AdvSplitter1: TAdvSplitter;
    AdvOfficePage3: TAdvOfficePage;
    AdvSplitter2: TAdvSplitter;
    AdvOfficePage4: TAdvOfficePage;
    sgConnList: TAdvStringGrid;
    AdvPanel21: TAdvPanel;
    AdvToolBar9: TAdvToolBar;
    AdvToolBarButton61: TAdvToolBarButton;
    AdvToolBarButton62: TAdvToolBarButton;
    AdvToolBarButton63: TAdvToolBarButton;
    AdvToolBarButton64: TAdvToolBarButton;
    AdvToolBarButton65: TAdvToolBarButton;
    AdvToolBarButton66: TAdvToolBarButton;
    cbCmdCombo: TComboBox;
    ComboBox1: TComboBox;
    AdvMainMenu1: TAdvMainMenu;
    AdvFormStyler1: TAdvFormStyler;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    lbProName: TLabel;
    Label21: TLabel;
    sgCommands: TAdvStringGrid;
    AdvSplitter6: TAdvSplitter;
    cbOutL1: TAdvOfficeCheckBox;
    cbOutL2: TAdvOfficeCheckBox;
    cbOutL3: TAdvOfficeCheckBox;
    cbOutL4: TAdvOfficeCheckBox;
    cbOutL5: TAdvOfficeCheckBox;
    cbMaster: TAdvOfficeCheckBox;
    AdvOfficeCheckBox7: TAdvOfficeCheckBox;
    AdvOfficeCheckBox8: TAdvOfficeCheckBox;
    AdvOfficeCheckBox9: TAdvOfficeCheckBox;
    AdvOfficeCheckBox10: TAdvOfficeCheckBox;
    AdvOfficeCheckBox11: TAdvOfficeCheckBox;
    AdvOfficeCheckBox12: TAdvOfficeCheckBox;
    AdvOfficeCheckBox13: TAdvOfficeCheckBox;
    msbStatBar: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    mmExplProto: TAdvListView;
    AdvPanel35: TAdvPanel;
    AdvPanel1: TAdvPanel;
    sgSyazone: TAdvStringGrid;
    AdvPanel2: TAdvPanel;
    AdvToolBar7: TAdvToolBar;
    AdvToolBarButton25: TAdvToolBarButton;
    AdvToolBarButton39: TAdvToolBarButton;
    AdvToolBarButton47: TAdvToolBarButton;
    AdvToolBarButton48: TAdvToolBarButton;
    AdvToolBarButton49: TAdvToolBarButton;
    AdvToolBarButton50: TAdvToolBarButton;
    AdvToolBarButton51: TAdvToolBarButton;
    AdvPanel3: TAdvPanel;
    sgSznDay: TAdvStringGrid;
    AdvSplitter4: TAdvSplitter;
    AdvPanel36: TAdvPanel;
    AdvToolBar12: TAdvToolBar;
    AdvToolBarButton52: TAdvToolBarButton;
    AdvToolBarButton73: TAdvToolBarButton;
    AdvToolBarButton74: TAdvToolBarButton;
    AdvToolBarButton75: TAdvToolBarButton;
    AdvToolBarButton76: TAdvToolBarButton;
    AdvToolBarButton77: TAdvToolBarButton;
    AdvToolBarButton103: TAdvToolBarButton;
    AdvPanel38: TAdvPanel;
    AdvPanel20: TAdvPanel;
    sgTariffType: TAdvStringGrid;
    AdvPanel10: TAdvPanel;
    AdvToolBar6: TAdvToolBar;
    AdvToolBarButton40: TAdvToolBarButton;
    AdvToolBarButton41: TAdvToolBarButton;
    AdvToolBarButton42: TAdvToolBarButton;
    AdvToolBarButton43: TAdvToolBarButton;
    AdvToolBarButton44: TAdvToolBarButton;
    AdvToolBarButton45: TAdvToolBarButton;
    AdvPanel39: TAdvPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    AdvPanel18: TAdvPanel;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    AdvPanel41: TAdvPanel;
    Label19: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    chHolyDay: TCheckBox;
    Label34: TLabel;
    AdvPanel7: TAdvPanel;
    AdvToolBar4: TAdvToolBar;
    AdvToolBarButton18: TAdvToolBarButton;
    AdvToolBarButton19: TAdvToolBarButton;
    AdvToolBarButton20: TAdvToolBarButton;
    AdvToolBarButton21: TAdvToolBarButton;
    AdvToolBarButton22: TAdvToolBarButton;
    AdvToolBarButton23: TAdvToolBarButton;
    AdvToolBarButton24: TAdvToolBarButton;
    AdvToolBarButton33: TAdvToolBarButton;
    AdvPanel: TAdvPanel;
    AdvToolBar: TAdvToolBar;
    AdvToolBarButton121: TAdvToolBarButton;
    AdvToolBarButton131: TAdvToolBarButton;
    AdvToolBarButton141: TAdvToolBarButton;
    AdvToolBarButton151: TAdvToolBarButton;
    AdvToolBarButton161: TAdvToolBarButton;
    AdvToolBarButton171: TAdvToolBarButton;
    AdvToolBarButton251: TAdvToolBarButton;
    N111: TMenuItem;
    AdvPanel34: TAdvPanel;
    AdvPanel40: TAdvPanel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    AdvPanel37: TAdvPanel;
    AdvToolBar18: TAdvToolBar;
    AdvToolBarButton109: TAdvToolBarButton;
    AdvToolBarButton110: TAdvToolBarButton;
    AdvToolBarButton111: TAdvToolBarButton;
    AdvToolBarButton112: TAdvToolBarButton;
    AdvToolBarButton113: TAdvToolBarButton;
    AdvToolBarButton114: TAdvToolBarButton;
    sgTarPlane: TAdvStringGrid;
    AdvSplitter7: TAdvSplitter;
    sznEditButt: TAdvToolBarButton;
    sznTDayEditButt: TAdvToolBarButton;
    AdvPopupMenuTDay: TAdvPopupMenu;
    N113: TMenuItem;
    N114: TMenuItem;
    N115: TMenuItem;
    AdvPopupMenuTariff: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    plnEditButt: TAdvToolBarButton;
    trfEditButt: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarSeparator3: TAdvToolBarSeparator;
    AdvToolBarSeparator4: TAdvToolBarSeparator;
    AdvToolBarButton115: TAdvToolBarButton;
    AdvToolBarButton116: TAdvToolBarButton;
    AdvToolBarButton117: TAdvToolBarButton;
    N116: TMenuItem;
    Label7: TLabel;
    vprAdvButt: TAdvToolBarButton;
    cnlAdvButt: TAdvToolBarButton;
    mtrAdvButt: TAdvToolBarButton;
    sceAdvButt: TAdvToolBarButton;
    qmnAdvButt: TAdvToolBarButton;
    qmzAdvButt: TAdvToolBarButton;
    prmAdvButt: TAdvToolBarButton;
    tszAdvButt: TAdvToolBarButton;
    AdvToolBarButton118: TAdvToolBarButton;
    AdvToolBarSeparator5: TAdvToolBarSeparator;
    AdvToolBarSeparator6: TAdvToolBarSeparator;
    AdvToolBarSeparator7: TAdvToolBarSeparator;
    AdvToolBarButton119: TAdvToolBarButton;
    AdvToolBarSeparator8: TAdvToolBarSeparator;
    AdvToolBarSeparator9: TAdvToolBarSeparator;
    AdvToolBarButton120: TAdvToolBarButton;
    AdvToolBarSeparator10: TAdvToolBarSeparator;
    AdvToolBarSeparator11: TAdvToolBarSeparator;
    AdvToolBarButton122: TAdvToolBarButton;
    AdvToolBarSeparator12: TAdvToolBarSeparator;
    AdvToolBarSeparator13: TAdvToolBarSeparator;
    AdvToolBarButton123: TAdvToolBarButton;
    AdvToolBarSeparator14: TAdvToolBarSeparator;
    AdvToolBarSeparator15: TAdvToolBarSeparator;
    AdvToolBarButton124: TAdvToolBarButton;
    AdvToolBarSeparator16: TAdvToolBarSeparator;
    AdvToolBarSeparator17: TAdvToolBarSeparator;
    AdvToolBarButton125: TAdvToolBarButton;
    AdvToolBarSeparator18: TAdvToolBarSeparator;
    AdvToolBarSeparator19: TAdvToolBarSeparator;
    AdvToolBarButton126: TAdvToolBarButton;
    AdvToolBarSeparator20: TAdvToolBarSeparator;
    AdvToolBarSeparator25: TAdvToolBarSeparator;
    AdvToolBarButton129: TAdvToolBarButton;
    AdvToolBarSeparator26: TAdvToolBarSeparator;
    AdvToolBarSeparator27: TAdvToolBarSeparator;
    AdvToolBarSeparator28: TAdvToolBarSeparator;
    AdvToolBarButton132: TAdvToolBarButton;
    AdvToolBarSeparator29: TAdvToolBarSeparator;
    AdvToolBarSeparator30: TAdvToolBarSeparator;
    AdvToolBarButton133: TAdvToolBarButton;
    AdvToolBarSeparator31: TAdvToolBarSeparator;
    AdvToolBarButton130: TAdvToolBarButton;
    AdvPanel44: TAdvPanel;
    AdvPanel15: TAdvPanel;
    AdvPanel43: TAdvPanel;
    AdvPanel45: TAdvPanel;
    AdvPanel4: TAdvPanel;
    sgGroup: TAdvStringGrid;
    AdvPanel17: TAdvPanel;
    AdvToolBar5: TAdvToolBar;
    AdvToolBarButton34: TAdvToolBarButton;
    AdvToolBarButton35: TAdvToolBarButton;
    AdvToolBarButton36: TAdvToolBarButton;
    AdvToolBarButton37: TAdvToolBarButton;
    AdvToolBarButton38: TAdvToolBarButton;
    AdvToolBarButton53: TAdvToolBarButton;
    AdvToolBarButton46: TAdvToolBarButton;
    gruToolBtn: TAdvToolBarButton;
    AdvToolBarSeparator21: TAdvToolBarSeparator;
    AdvToolBarButton127: TAdvToolBarButton;
    AdvToolBarSeparator22: TAdvToolBarSeparator;
    AdvPanel46: TAdvPanel;
    sgAbon: TAdvStringGrid;
    AdvPanel47: TAdvPanel;
    AdvToolBar19: TAdvToolBar;
    AdvToolBarButton135: TAdvToolBarButton;
    AdvToolBarButton136: TAdvToolBarButton;
    AdvToolBarButton137: TAdvToolBarButton;
    AdvToolBarButton138: TAdvToolBarButton;
    AdvToolBarButton139: TAdvToolBarButton;
    AdvToolBarButton140: TAdvToolBarButton;
    AdvToolBarButton142: TAdvToolBarButton;
    aboToolBtn: TAdvToolBarButton;
    AdvToolBarSeparator32: TAdvToolBarSeparator;
    AdvToolBarButton144: TAdvToolBarButton;
    AdvToolBarSeparator33: TAdvToolBarSeparator;
    AdvSplitter8: TAdvSplitter;
    AdvPanel48: TAdvPanel;
    AdvToolBar3: TAdvToolBar;
    AdvToolBarButton26: TAdvToolBarButton;
    AdvToolBarButton27: TAdvToolBarButton;
    AdvToolBarButton28: TAdvToolBarButton;
    AdvToolBarButton29: TAdvToolBarButton;
    AdvToolBarButton30: TAdvToolBarButton;
    AdvToolBarButton31: TAdvToolBarButton;
    AdvToolBarButton32: TAdvToolBarButton;
    AdvToolBarButton60: TAdvToolBarButton;
    vmtAdvButt: TAdvToolBarButton;
    AdvToolBarSeparator23: TAdvToolBarSeparator;
    AdvToolBarButton128: TAdvToolBarButton;
    AdvToolBarSeparator24: TAdvToolBarSeparator;
    sgVMeter: TAdvStringGrid;
    AdvSplitter10: TAdvSplitter;
    AdvPanel5: TAdvPanel;
    cbChannel: TComboBox;
    sgCNMeters: TAdvStringGrid;
    AdvSplitter3: TAdvSplitter;
    AdvPopupMenu2: TAdvPopupMenu;
    N122: TMenuItem;
    grpMenu: TAdvPopupMenu;
    N123: TMenuItem;
    N124: TMenuItem;
    N125: TMenuItem;
    N126: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    advTreePanell: TAdvPanel;
    Label33: TLabel;
    advEventBox: TAdvPanel;
    AdvPanel49: TAdvPanel;
    AdvToolBar20: TAdvToolBar;
    bClearEv: TAdvToolBarButton;
    bSaveEv: TAdvToolBarButton;
    AdvToolBarSeparator39: TAdvToolBarSeparator;
    bEnablEv: TAdvToolBarButton;
    bDisablEv: TAdvToolBarButton;
    ImageList2: TImageList;
    m_reEventer: TRichEdit;
    AdvToolBarSeparator41: TAdvToolBarSeparator;
    AdvToolBarButton12: TAdvToolBarButton;
    N128: TMenuItem;
    aop_Vector: TAdvOfficePage;
    AdvPanel42: TAdvPanel;
    AdvToolBar21: TAdvToolBar;
    AdvToolBarButton146: TAdvToolBarButton;
    AdvToolBarButton147: TAdvToolBarButton;
    AdvToolBarButton148: TAdvToolBarButton;
    sgVGrid: TAdvStringGrid;
    AdvToolBarButton149: TAdvToolBarButton;
    LastTimeTimer: TTimer;
    advButConf: TAdvGlowMenuButton;
    advConfMenu: TAdvPopupMenu;
    N129: TMenuItem;
    N130: TMenuItem;
    N131: TMenuItem;
    N132: TMenuItem;
    N133: TMenuItem;
    advButData: TAdvGlowMenuButton;
    advDataMenu: TAdvPopupMenu;
    N134: TMenuItem;
    N135: TMenuItem;
    N136: TMenuItem;
    N137: TMenuItem;
    N138: TMenuItem;
    N139: TMenuItem;
    N140: TMenuItem;
    advButSett: TAdvGlowButton;
    advButUser: TAdvGlowButton;
    advButShem: TAdvGlowMenuButton;
    FTreeModuleData: TTreeView;
    advOperMenu: TAdvPopupMenu;
    N141: TMenuItem;
    N142: TMenuItem;
    N143: TMenuItem;
    N144: TMenuItem;
    N145: TMenuItem;
    N146: TMenuItem;
    N147: TMenuItem;
    N148: TMenuItem;
    advViewTree: TAdvPopupMenu;
    advReg: TMenuItem;
    advAbo: TMenuItem;
    advGru: TMenuItem;
    advTuc: TMenuItem;
    N153: TMenuItem;
    N154: TMenuItem;
    advTreeTool: TAdvToolBar;
    advButTree: TAdvGlowMenuButton;
    advButOper: TAdvGlowMenuButton;
    AdvPanel23: TAdvPanel;
    ImageList1: TImageList;
    advConnMenu: TAdvPopupMenu;
    N149: TMenuItem;
    N150: TMenuItem;
    N151: TMenuItem;
    N155: TMenuItem;
    N152: TMenuItem;
    N156: TMenuItem;
    advButConn: TAdvGlowMenuButton;
    Afq1: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    AdvToolBarButton13: TAdvToolBarButton;
    AdvToolBarSeparator34: TAdvToolBarSeparator;
    StaticText2: TStaticText;
    aniRemConn: TAnimate;
    aniAlarm: TAnimate;
    aniLimit: TAnimate;
    aniQuery: TAnimate;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    lbRemTime: TStaticText;
    lbLocal: TStaticText;
    lbRemote: TStaticText;
    StaticText6: TStaticText;
    lbSdlQrylb: TStaticText;
    StaticText9: TStaticText;
    lbCurrUser: TStaticText;
    lbScheduler: TStaticText;
    lbSchedTime: TStaticText;
    lbSetTmState: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    lbOnTransTime: TStaticText;
    lbOnTransState: TStaticText;
    FlbSExpired: TStaticText;
    lbUserInfo: TStaticText;
    lbModemInfo: TStaticText;
    StaticText5: TStaticText;
    N75: TMenuItem;
    N76: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    N80: TMenuItem;
    advEvGButt: TMenuItem;
    N82: TMenuItem;
    lbFreeInfo: TStaticText;
    mnReportEdit: TMenuItem;
    mnAbonEdit: TMenuItem;
    mnControlConnect: TMenuItem;
    mnControlDisconnect: TMenuItem;
    N81: TMenuItem;
    N77: TMenuItem;
    mnOpenTransit: TMenuItem;
    procedure OnFormCreate(Sender: TObject);
    procedure OnFormResize(Sender: TObject);
    procedure OnDrawInfoPanell(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure OnGoProto(Sender: TObject);
    procedure OnStopProto(Sender: TObject);
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
    procedure OnClickTree(Sender: TObject);
    procedure OnReloadLevel(Sender: TObject);
    procedure OnEditNode(Sender: TObject);
    procedure OnAddNode(Sender: TObject);
    procedure OnDeleteNode(Sender: TObject);
    procedure OnPageTreeCh(Sender: TObject);
    procedure OnChannelGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnInitL1(Sender: TObject);
    procedure OnExpandedL1Tree(Sender: TObject; Node: TTreeNode);
    procedure OnMeterGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnMeterGetCellType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnReloadLevelL2(Sender: TObject);
    procedure OnEditNodeL2(Sender: TObject);
    procedure OnAddNodeL2(Sender: TObject);
    procedure OnDeleteNodeL2(Sender: TObject);
    procedure OnRefreshL1Tree(Sender: TObject);
    procedure OnCommandGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnCommandGetCellType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnSetGridCmdL2(Sender: TObject);
    procedure OnSaveGridCmdL2(Sender: TObject);
    procedure OnClickCmdGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnDelGridCmdL2(Sender: TObject);
    procedure OnClearScenario(Sender: TObject);
    procedure OnStartQry(Sender: TObject);
    procedure OnStopQry(Sender: TObject);
    procedure OnEditGroupL3(Sender: TObject);
    procedure OnAddGroupL3(Sender: TObject);
    procedure OnDelGroupL3(Sender: TObject);
    procedure OnClickTreeData(Sender: TObject);
    procedure OnExpandedTreeData(Sender: TObject; Node: TTreeNode);
    procedure OnSaveGridGroupL3(Sender: TObject);
    procedure OnSetGridGroupL3(Sender: TObject);
    procedure OnMeterGetCellColorGL3(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnMeterGetCellTypeGL3(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnRefreshL3Tree(Sender: TObject);
    procedure OnEditVMeterL3(Sender: TObject);
    procedure OnAddVMeterL3(Sender: TObject);
    procedure OnDelVMeterL3(Sender: TObject);
    procedure OnMeterGetCellColorVL3(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnMeterGetCellTypeVL3(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnChandgeVL3(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure OnSaveGridVMeterL3(Sender: TObject);
    procedure OnSetGridVMeterL3(Sender: TObject);
    procedure OnPageL2Resize(Sender: TObject);
    procedure OnMeterGetCellColorVPL3(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnMeterGetCellTypeVPL3(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnGetColorMType(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnDelRowMType(Sender: TObject);
    procedure OnSetGridMType(Sender: TObject);
    procedure OnSaveGridMType(Sender: TObject);
    procedure OnDelAllRowMType(Sender: TObject);
    procedure OnClickGridMType(Sender: TObject; ARow, ACol: Integer);
    procedure OnSaveGridQmC(Sender: TObject);
    procedure OnSetGridQmC(Sender: TObject);
    procedure OnDelRowQMC(Sender: TObject);
    procedure OnDelAllRowQMC(Sender: TObject);
    procedure OnClickGridQMC(Sender: TObject; ARow, ACol: Integer);
    procedure OnAddMType(Sender: TObject);
    procedure OnCloneRowMType(Sender: TObject);
    procedure OnSaveGridChann(Sender: TObject);
    procedure OnSetGridChann(Sender: TObject);
    procedure OnClickGridChannel(Sender: TObject; ARow, ACol: Integer);
    procedure OnCloneRowChann(Sender: TObject);
    procedure OnDelRowChann(Sender: TObject);
    procedure OnDelAllRowChann(Sender: TObject);
    procedure OnSaveGridMeter(Sender: TObject);
    procedure OnSetGridMeter(Sender: TObject);
    procedure OnAddRowGridMeter(Sender: TObject);
    procedure OnCloneRowMeter(Sender: TObject);
    procedure OnDelRowMeter(Sender: TObject);
    procedure OnDelAllRowMeter(Sender: TObject);
    procedure OnInitMeter(Sender: TObject);
    procedure OnClickGridMeter(Sender: TObject; ARow, ACol: Integer);
    procedure OnGetTypeMType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnComboChQMC(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure OnDelRowCmd(Sender: TObject);
    procedure OnDelAllRowCmd(Sender: TObject);
    procedure OnInitCmp(Sender: TObject);
    procedure OnAddAutoCmd(Sender: TObject);
    procedure OnEditFrame(Sender: TObject);
    procedure OnCloneGroup(Sender: TObject);
    procedure OnClickGroupGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnPageL3Resize(Sender: TObject);
    procedure OnAddRowGroup(Sender: TObject);
    procedure OnDelRowGrid(Sender: TObject);
    procedure OnDelAllRowGroup(Sender: TObject);
    procedure OnCloneRowVMeter(Sender: TObject);
    procedure OnAddRowVMeter(Sender: TObject);
    procedure OnDelRowVMeter(Sender: TObject);
    procedure OnDelAllRowVMeter(Sender: TObject);
    procedure OnClickGridVMeter(Sender: TObject; ARow, ACol: Integer);
    procedure OnChandgeChann(Sender: TObject);
    procedure OnConnectVMeter(Sender: TObject);
    procedure OnClickGridVChannel(Sender: TObject; ARow, ACol: Integer);
    procedure OnDropVChannel(Sender: TObject);
    procedure OnAddRowChannel(Sender: TObject);
    procedure OnSaveGridVParam(Sender: TObject);
    procedure OnSetGridVParam(Sender: TObject);
    procedure OnAddAutoVParam(Sender: TObject);
    procedure OnDelRowVParam(Sender: TObject);
    procedure OnDelAllRowVParam(Sender: TObject);
    procedure OnClickGridVParam(Sender: TObject; ARow, ACol: Integer);
    procedure OnChannelGetCellTypeVP(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnChandgeME(Sender: TObject; ACol, ARow, AItemIndex: Integer;
      ASelection: String);
    procedure OnSaveTrace(Sender: TObject);
    procedure OnEditReq(Sender: TObject);
    procedure OnEditChannel(Sender: TObject);
    procedure OnEditGroup(Sender: TObject);
    procedure OnSetTrace(Sender: TObject);
    procedure OnChandgeGPage(Sender: TObject);
    procedure OnChandgePPage(Sender: TObject);
    procedure OnDataEditor(Sender: TObject);
    procedure OnSetWindow(Sender: TObject);
    procedure OnClickParamGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnGetColorParam(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnGetCellTypeParam(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnSaveGridParam(Sender: TObject);
    procedure OnSetGridParam(Sender: TObject);
    procedure OnAddParam(Sender: TObject);
    procedure OnCloneParam(Sender: TObject);
    procedure OnDelRowParam(Sender: TObject);
    procedure OnDelAllRowParam(Sender: TObject);
    procedure OnLoadFFile(Sender: TObject);
    procedure OnEditParam(Sender: TObject);
    procedure OnPCViewResize(Sender: TObject);
    procedure OnGetCellColorGV(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnInitL3(Sender: TObject);
    procedure OnClickTypeTarGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnChannelGetCellTTypeColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnChannelGetCellTTarType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure OnSaveGridTTar(Sender: TObject);
    procedure OnSetGridTTar(Sender: TObject);
    procedure OnAddTTar(Sender: TObject);
    procedure OnCloneTTar(Sender: TObject);
    procedure OnDellRowTTar(Sender: TObject);
    procedure OnDelAllRowTTar(Sender: TObject);
    procedure OnChandgeTar(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure OnGetCellColorTar(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnGetCellTar(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnSaveGridTar(Sender: TObject);
    procedure OnSetGridTar(Sender: TObject);
    procedure OnAddAutoTar(Sender: TObject);
    procedure OnDelRowTar(Sender: TObject);
    procedure OnDelAllRowTar(Sender: TObject);
    procedure OnEditTariffs(Sender: TObject);
    procedure OnClickTarGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnCalculate(Sender: TObject);
    procedure OnSetForAllParam(Sender: TObject);
    procedure OnLoadAllCmd(Sender: TObject);
    procedure OnSetForAllQmParam(Sender: TObject);
    procedure OnGetCellColorDV(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnPrintData1(Sender: TObject);
    procedure OnPrintVectorData(Sender: TObject);
    procedure OnPrintData4(Sender: TObject);
    procedure OnPrintDataTr(Sender: TObject);
    procedure OnGetCellColorGV4(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnConnectToUspd(Sender: TObject);
    procedure OnDiscUspd(Sender: TObject);
    procedure OnSetForAllL2Edit(Sender: TObject);
    procedure OnSaveGridConn(Sender: TObject);
    procedure OnSetGridConn(Sender: TObject);
    procedure OnAddAutoConn(Sender: TObject);
    procedure OnCloneConn(Sender: TObject);
    procedure OnDelRowConn(Sender: TObject);
    procedure OnDelAllRowConn(Sender: TObject);
    procedure OnClickConnGrid(Sender: TObject; ARow, ACol: Integer);
    procedure OnGetCellColorConn(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnGetCellConn(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnChandgeConn(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure OnExecuteReport(Sender: TObject);
    procedure OnChandgeOpenL1(Sender: TObject);
    procedure OnChandgeOpenL2(Sender: TObject);
    procedure OnChandgeOpenL3(Sender: TObject);
    procedure OnChandgeOpenL4(Sender: TObject);
    procedure OnChandgeOpenL5(Sender: TObject);
    procedure OnChandgeOpenAll(Sender: TObject);
    procedure OnChandgeOpenRAll(Sender: TObject);
    procedure OnSaveProto(Sender: TObject);
    procedure OnSaveBase(Sender: TObject);
    procedure OnActivate(Sender: TObject);
    procedure OnGetCellColorDVT(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnClickSettings(Sender: TObject);
    procedure OnPpResize(Sender: TObject);

    procedure OnEntCh(Sender: TObject);
    procedure OnStopLocalServer(Sender: TObject);
    procedure OnStartLocalServer(Sender: TObject);
    procedure OnCreateMeters(Sender: TObject);
    procedure OnDisconnect(Sender: TObject);
    procedure OnMDownPE(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N61Click(Sender: TObject);
    procedure OnEvents(Sender: TObject);
    procedure N62Click(Sender: TObject);
    procedure OnGoScheduler(Sender: TObject);
    procedure OnPauseScheduler(Sender: TObject);
    procedure OnSetUsers(Sender: TObject);
    procedure OnSaveEvent;
    procedure sgChannelsGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure sgTariffGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure OnClickAbout(Sender: TObject);
    procedure OnMDownGE(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnExclude_Inquiry(Sender: TObject);
    procedure OnInclude_Inquiry(Sender: TObject);
    procedure OnClickGridSzn(Sender: TObject; ARow, ACol: Integer);
    procedure OnChannelGetCellSznType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnSaveGridSzTar(Sender: TObject);
    procedure OnSetGridSZTar(Sender: TObject);
    procedure OnAddSZTar(Sender: TObject);
    procedure OnCloneSZTar(Sender: TObject);
    procedure OnDellRowSZTar(Sender: TObject);
    procedure OnDelAllRowSZTar(Sender: TObject);
    procedure OnSzResize(Sender: TObject);
    procedure OnMDownSZN(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnCreateSzn(Sender: TObject);
    procedure OnGetCellColorSznDay(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure msbStatBarDrawPanel(StatusBar: TAdvOfficeStatusBar;
      Panel: TAdvOfficeStatusPanel; const Rect: TRect);
    procedure OnSetForMeters(Sender: TObject);
    procedure AdvPanel3Resize(Sender: TObject);
    procedure AdvPanel5Resize(Sender: TObject);
    procedure AdvPanel6Resize(Sender: TObject);
    procedure OnResizeTarif(Sender: TObject);
    procedure sgMetersMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnStartTest(Sender: TObject);
    procedure OnSaveTPlane(Sender: TObject);
    procedure OnSetTPlane(Sender: TObject);
    procedure OnAddTPlane(Sender: TObject);
    procedure OnCloneTPlane(Sender: TObject);
    procedure OnDelRowTPlane(Sender: TObject);
    procedure OnDelAllRowTPlane(Sender: TObject);
    procedure OnClickTPlane(Sender: TObject; ARow, ACol: Integer);
    procedure OnGetEdTPlane(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnEditSyzone(Sender: TObject);
    procedure OnSelectSzTday(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure OnEditTdaySz(Sender: TObject);
    procedure OnGetEdTxtSzDay(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure OnDrawTdayCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure OnSetFreeDay(Sender: TObject);
    procedure OnClickCellTday(Sender: TObject; ARow, ACol: Integer);
    procedure OnSaveGridTDay(Sender: TObject);
    procedure OnDelTDay(Sender: TObject);
    procedure OnDelTDays(Sender: TObject);
    procedure OnSetAllTariff(Sender: TObject);
    procedure OnEditTPlane(Sender: TObject);
    procedure OnEditTatiff(Sender: TObject);
    procedure OnSetAllSyzon(Sender: TObject);
    procedure OnSetAllTDay(Sender: TObject);
    procedure OnSetEdition(Sender: TObject);
    procedure OnLoadTariffs(Sender: TObject);
    procedure OnComboChTType(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure OnSetEdGroup(Sender: TObject);
    procedure OnSetEdVmet(Sender: TObject);
    procedure OnSetEdVPar(Sender: TObject);
    procedure OnSetEdCnl(Sender: TObject);
    procedure OnSetEdMtr(Sender: TObject);
    procedure OnSetEdSce(Sender: TObject);
    procedure OnSetEdQm(Sender: TObject);
    procedure OnSetEdQmz(Sender: TObject);
    procedure OnSetEdPar(Sender: TObject);
    procedure OnSetEdZone(Sender: TObject);
    procedure OnSaveParamEx(Sender: TObject);
    procedure OnSaveEdQry1Ex(Sender: TObject);
    procedure OnSaveEdQry2Ex(Sender: TObject);
    procedure OnSaveChann1Ex(Sender: TObject);
    procedure OnSaveChann3Ex(Sender: TObject);
    procedure OnSaveChann2Ex(Sender: TObject);
    procedure OnSaveGroup1Ex(Sender: TObject);
    procedure OnSaveGroup2Ex(Sender: TObject);
    procedure OnSaveGroup3Ex(Sender: TObject);
    procedure OnSaveSzEx(Sender: TObject);
    procedure OnSaveTPlane1Ex(Sender: TObject);
    procedure OnSaveTPlane2Ex(Sender: TObject);
    procedure OnSaveTPlane3Ex(Sender: TObject);
    procedure OnSaveCurrEx(Sender: TObject);
    procedure OnSaveEnrg4Ex(Sender: TObject);
    procedure OnSaveEnrgEx(Sender: TObject);
    procedure OnSaveVectorEx(Sender: TObject);
    procedure OnEditAbons(Sender: TObject);
    procedure OnSaveGridAbonL3(Sender: TObject);
    procedure OnSetGridAbon(Sender: TObject);
    procedure OnAddRowAbon(Sender: TObject);
    procedure OnCloneRowAbon(Sender: TObject);
    procedure OnDelRowAbon(Sender: TObject);
    procedure OnDelAllRowAbon(Sender: TObject);
    procedure OnSetEdAbon(Sender: TObject);
    procedure OnAbonGetCellType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnClickCellAbon(Sender: TObject; ARow, ACol: Integer);
    procedure OnMDownAbon(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnAbonResize(Sender: TObject);
    procedure OnVmeterResize(Sender: TObject);
    procedure OnDbClickAbon(Sender: TObject; ARow, ACol: Integer);
    procedure OnCryOblect(Sender: TObject);
    procedure OnOpenTrace(Sender: TObject);
    procedure OnSetCmdForMeters(Sender: TObject);
    procedure OnSetCmdForPMeters(Sender: TObject);
    procedure OnSetAllGroup(Sender: TObject);
    procedure OnSetAllInAbon(Sender: TObject);
    procedure OnSetAllAbon(Sender: TObject);

    procedure FTreeModuleDataChange(Sender: TObject; Node: TTreeNode);
    procedure btnLimitClick(Sender: TObject);
    procedure OnArchivate(Sender: TObject);
    procedure OnChandgeDTreeType(Sender: TObject);
    procedure OnClickSort(Sender: TObject);
    procedure OnOpenL3Trace(Sender: TObject);
    procedure bClearEvClick(Sender: TObject);
    procedure bSaveEvClick(Sender: TObject);
    procedure bEnablEvClick(Sender: TObject);
    procedure bDisablEvClick(Sender: TObject);
    procedure OnExpand(Sender: TObject);
    procedure OnLoadAllData(Sender: TObject);
    procedure OnLoadAbonData(Sender: TObject);
    procedure sgChannelsDblClick(Sender: TObject);
    procedure sgMetersDblClick(Sender: TObject);
    procedure OnCreateTPlanPattern(Sender: TObject);
    procedure LastTimeTimerTimer(Sender: TObject);
    procedure OnToolBarResize(Sender: TObject);
    procedure OnResizeTrePannel(Sender: TObject);
    procedure OnResizePannCurrState(Sender: TObject);
    procedure OnAddReports(Sender: TObject);
    procedure OpenControlSession(Sender: TObject);
    procedure CloseControlSession(Sender: TObject);
    procedure CloseTransitSession(Sender: TObject);
    procedure OnChannelGen(Sender: TObject);
    procedure OnShadow(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvGlowButton1Click(Sender: TObject);

  private
    { Private declarations }

    //ReportSettings     : REPORT_F1;
    LastDate           : TDateTime;
    LastTickCount      : Longword;
    pGenTable          : SGENSETTTAG;
    m_blTimerClose     : Boolean;
    blMenuClose        : Boolean;
    m_nEVL             : CEvaluator;
    m_nFirstStart      : Byte;
    mMParser1          : TMParser;
    m_nL3RepFrame      : TTReppOWER;
    m_nL3SchFrame      : TTShemModule;
//    m_nL3VecFrame      : TVectorFrame;
    m_nL3TarTypeEditor : CL3TarTypeEditor;
    m_nTPLED           : CL3TarPlaneEditor;
    m_nL5Tracer        : TTracer;
    FL3TreeLoader      : CL3TreeLoader;
    FTreeLoader        : CTreeLoader;
    m_nL1Editor        : CL1Editor;
    m_nL2ParamEditor   : CL2ParamEditor;
    m_nL2MTypeEditor   : CL2MTypeEditor;
    //m_nEDAB.PChild   : CL3GroupEditor;
    //m_nL3VMeterEditor: CL3VMeterEditor;
    //m_nL3VParamEditor: CL3VParamEditor;
    m_nL3ConnEditor    : CL3ConnEditor;
    m_nSZED            : CL3SznEditor;
    m_nEDAB            : CL3AbonEditor;
    m_byTrState        : Byte;
    m_byTrEditMode     : Byte;
    FTimer             : TTimer;
    FOpenTimer         : TTimer;
    pL1Module          : CL1Module;
    pL2Module          : CL2Module;
    pL3Module          : CL3Module;
    pL4Module          : CL4Module;
    pL3LmeModule       : CL3LmeModule;
    pL2TmrModule       : CTimerThread;

    EventFlag_Speed    : Integer;
    EventFlag_Adress   : Integer;
    EventFlag          : Integer;
    strSettingsPath    : String;
    LastChangeTime     : Integer;
    STime: TDateTime;
    m_blTreeOpen       : Boolean;
    m_blEdit           : Boolean;
    m_blEditDT         : Boolean;
    m_pRPDS            : CGDataSource;
    m_nST              : CSaveTime;
    m_dwCount          : DWord;
    m_nSchDrv          : CSchemDriver;
    fQweryModule       : TTQweryModule;
    //m_blNoCheckPass : Boolean;
    //strSB : array[0..10] of String;
    procedure WMTIMECHANGE(var Message: TWMTIMECHANGE);
    message WM_TIMECHANGE;
    Procedure WindowMessage(Var Msg:TMessage); message WM_SYSCOMMAND;
    Procedure MouseClick(var Msg:TMessage); message WM_MOUSE_CLICK_KNS;
    procedure WMGotoForeground(var Msg:TMessage);message WM_GOTOFOREGROUND;
    procedure ActionIcon(n:Integer;Icon:TIcon);
    procedure CloseEditPage;
    procedure OpenEditPage;
    procedure SetActivePage;
    procedure SetActiveView(blState : Boolean);
    procedure DoHalfTime(Sender:TObject);dynamic;
    procedure DoHalfOpenTime(Sender:TObject);dynamic;
    procedure LoadSettings;
    procedure SetTree;
    procedure SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
    function  FindRepView(nIndex:Integer):Integer;
    function  FindVecView(nIndex:Integer):Integer;
    function  FindSchemView(nIndex:Integer):Integer;
    procedure ExecuteReport(pDS:PCGDataSource);
    procedure ExecuteSchem(pDS:PCGDataSource);
    procedure ExecuteVectorDG(pDS:PCGDataSource);
    procedure OnRemInitL2;
    procedure OnRemInitL1;
    procedure OpenEcomTranz(sE:SECOMTRANZ);
    
    //function  IsLevelL1(nLevel:Integer;str:String):Boolean;
    function  IsLevelL3(nLevel:Integer):Boolean;
    procedure SendRemCrcStop(pDS:CMessageData);
    procedure SendRemCrcStart(pDS:CMessageData);
    procedure CloseTimeSett;
    procedure CollapsedEvBox(Sender:TObject);
    procedure DBUpdate(strCurrPath:String);
    procedure ModemPrepare(strCurrPath:String);
    procedure OnPackDB;
  public
    { Public declarations }
  end;

var
  TKnsForm: TTKnsForm;

implementation

uses knsl4ConfMeterModule, knsl3HideCtrlFrame;

{$R *.DFM}

procedure TTKnsForm.WMTIMECHANGE(var Message: TWMTIMECHANGE);
var _1MS            : TDateTime;
    DeltaTimeInMS   : integer;
begin
   _1MS := EncodeTime(0, 0, 0, 1);
   DeltaTimeInMS := abs(GetTickCount - LastTickCount);
   if (DeltaTimeInMS > 1000000) then //Если прошло более 1000 сек то ничего не делаем
     exit;
   LastDate := LastDate + DeltaTimeInMS*_1MS;
   if not blAutoKorr then
     m_nCF.SaveEvent(Now, LastDate);
   LastDate := Now;
   LastTickCount := GetTickCount;
   blAutoKorr := false;
//m_nCF.SaveEvent(NewTime,STime);
end;
{
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
"Bias"=dword:ffffff4c
"StandardName"="Московское время (зима)"
"StandardBias"=dword:00000000
"StandardStart"=hex:00,00,0a,00,05,00,03,00,00,00,00,00,00,00,00,00
"DaylightName"="Московское время (зима)"
"DaylightBias"=dword:00000000
"DaylightStart"=hex:00,00,0a,00,05,00,03,00,00,00,00,00,00,00,00,00
"ActiveTimeBias"=dword:ffffff4c
"DisableAutoDaylightTimeSet"=dword:00000001


[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\Kiev Standard Time]
"MUI_Display"="@tzres.dll,-1620"
"TZI"=hex:4c,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
"Std"="Киевское время (зима)"
"MUI_Std"="@tzres.dll,-1621"
"Dlt"="Киевское время (лето)"
"MUI_Dlt"="@tzres.dll,-1622"
"Display"="(GMT +03:00) Киев"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\Kiev Standard Time\Dynamic DST]
"2010"=hex:88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,03,00,\
  00,00,00,00,00,00,00,00,03,00,00,00,05,00,02,00,00,00,00,00,00,00
"2011"=hex:4c,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
"FirstEntry"=dword:000007da
"LastEntry"=dword:000007db
}
procedure TTKnsForm.CloseTimeSett;
var
  Reg: TRegistry;
  Buffer : array[0..50] of Byte;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if Reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\Minsk_Moskau Standard Time', True) then
    Begin
     Reg.WriteString('MUI_Display','"' + '@tzres.dll,-1620' + '"');
     FillChar(Buffer,50,0);
     Buffer[0]:=$4c;Buffer[1]:=$ff;Buffer[2] :=$ff;Buffer[3] :=$ff;
     Buffer[8]:=$c4;Buffer[9]:=$ff;Buffer[10]:=$ff;Buffer[11]:=$ff;
     Reg.WriteBinaryData('TZI',Buffer,44);
     Reg.WriteString('Std','Московское время (зима)');
     Reg.WriteString('MUI_Std','"' + '@tzres.dll,-1621' + '"');
     Reg.WriteString('Dlt','Московское время (лето)');
     Reg.WriteString('MUI_Dlt','"' + '@tzres.dll,-1622' + '"');
     Reg.WriteString('Display','(GMT+03:00) Москва,Калининград');
    End;
    Reg.CloseKey;

    if Reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\Kiev Standard Time\Dynamic DST', True) then
    Begin
     Reg.WriteString('MUI_Display','"' + '@tzres.dll,-1620' + '"');
     FillChar(Buffer,50,0);
     Buffer[0]:=$88;Buffer[1]:=$ff;Buffer[2] :=$ff;Buffer[3] :=$ff;
     Buffer[8]:=$c4;Buffer[9]:=$ff;Buffer[10]:=$ff;Buffer[11]:=$ff;
     Reg.WriteBinaryData('2010',Buffer,44);
     FillChar(Buffer,50,0);
     Buffer[0]:=$4c;Buffer[1]:=$ff;Buffer[2] :=$ff;Buffer[3] :=$ff;
     Buffer[8]:=$c4;Buffer[9]:=$ff;Buffer[10]:=$ff;Buffer[11]:=$ff;
     Reg.WriteBinaryData('2011',Buffer,44);
     Reg.WriteInteger('FirstEntry',$000007da);
     Reg.WriteInteger('LastEntry',$000007db);
    End;
    Reg.CloseKey;

    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Control\TimeZoneInformation', True) then
    Begin
     Reg.WriteInteger('Bias',$ffffff4c);
     Reg.WriteString('StandardName','Московское время (зима)');
     Reg.WriteInteger('StandardBias',0);
     FillChar(Buffer,50,0);Buffer[2]:=$0a;Buffer[4]:=$05;Buffer[6]:=$03;
     Reg.WriteBinaryData('StandardStart',Buffer,16);
     Reg.WriteString('DaylightName','Московское время (зима)');
     Reg.WriteInteger('DaylightBias',0);
     FillChar(Buffer,50,0);Buffer[2]:=$0a;Buffer[4]:=$05;Buffer[6]:=$03;
     Reg.WriteBinaryData('DaylightStart',Buffer,16);
     Reg.WriteInteger('ActiveTimeBias',$ffffff4c);
     Reg.WriteString('DisableA','"'+'00000001'+'"');
     Reg.WriteInteger('DisableAutoDaylightTimeSet',1);
    End;
    Reg.CloseKey;

  finally
    //Reg.CloseKey;
    Reg.Free;
  inherited;
  end;
end;

procedure TTKnsForm.LoadSettings;
Var
    nWS,i : Integer;
    m_strCurrentDir,strExtrPath : String;
    sExpr : String;
    //fEX : Extended;
    dwParam : Dword;
    exVal,fKI,fKU,fKM,exValue : Double;
    fValue : Single;
    //m_nIsRam : Byte;
    Fl   : TINIFile;
    dtTime : TDateTime;
    label m1;
Begin
    CloseTimeSett;
    TAbout := TTAbout.Create(self);
    TAbout.CompareKey;
    m_nQweryReboot := 0;
    m_nSchDrv := CSchemDriver.Create;

    {
    sExpr := '+CMTI: "SM",8';
    i := Pos(',',sExpr);
    nWS := Length(sExpr);
    strExtrPath := Copy(sExpr,i+1,nWS-i);
    if strExtrPath<>'' then i:=0;
    }
    m_nMSynchKorr.m_blEnable := False;
    if sExpr<>'' then m_nStateLr := 1;;
    m_nStateLr := 1;
    m_nPauseCM := False;
    LoadMainForm := TLoadMainForm.Create(Application);

    Application.Title := 'Сервер АСКУЭ';

    self.Caption := 'Сервер АСКУЭ   Версия: ' + LoadMainForm.m_Version;
    LoadMainForm.show;
    m_blTreeOpen := True;
    m_pRPDS.trTRI.PAID := $ffff;
    ///////////////////////////Инициализация программы  1
    LoadMainForm.Label3.Caption := 'Инициализация программы';
    LoadMainForm.Refresh;
    LoadMainForm.ProgressBar1.Position := 1;

    TKnsForm := self;
    EventFlag_Speed   := -1;
    EventFlag_Adress  := -1;
    EventFlag         := -1;

     fValue   := 2.0125;
     exVal    := fValue;
     fKI      := 200;
     fKU      := 100;
     fKM      := 1;
     LastDate      := Now;
     LastTickCount := GetTickCount;
     //exValue  := fValue*fKM;
     exValue  := round(exVal*1000.0*1)/1000.0;
     exValue   := fKI*fKU*exValue;
     if exValue<>0 then
     Begin
      exValue := exValue*2000;
     End;

     
     dwParam := $ffffffff;
     //move(dwParam, sizeof(dwParam));
     exValue := dwParam;
     exValue := exValue+1;
     if exValue<>0 then
     Begin
      exValue := exValue*2000;
     End;

     {
     m_nEVL := CEvaluator.Create;
     m_nEVL.Init;
     sExpr := 'v17_Pmgas + v19_Pmgas';
     m_nEVL.Expression := sExpr;
     m_nEVL.Variable['v17_Pmgas'] := 61.550;
     m_nEVL.Variable['v19_Pmgas'] := 267.839;
     fEX := m_nEVL.Value;
     }
     //sExpr := '1-2;';
      {
      sExpr := '1 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + lim(6.1,5.34,5,20) + lim(6.1,5.34,5,20)'+
      ' + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2';
      m_nEVL := CEvaluator.Create;
      m_nEVL.Init;
      for i:=0 to 50*50 do
      fEX := m_nEVL.GetResult(sExpr);
     }
     m_nCurrReport   := 0;

     m_blCL2ParEditor      := False;
     m_blCL2QmCEditor      := False;
     m_blCL2QmEditor       := False;
     m_blCL2ChannEditor    := False;
     m_blCL2MetrEditor     := False;
     m_blCL2ScenEditor     := False;
     m_blCL3GroupEditor    := False;
     m_blCL3VMetEditor     := False;
     m_blCL3VParEditor     := False;
     m_blCL3SznEditor      := False;
     m_blCL3SznTDayEditor  := False;
     m_blCL3TarPlaneEditor := False;
     m_blCL3TarTypeEditor  := False;
     m_blCL3TariffEditor   := False;
     m_blCL3ChngEditor     := False;

     m_blTimerClose  := False;
     m_blMinimized   := False;
     blMenuClose     := False;
     m_blCreateEvents:= False;
     m_blNoCheckPass := False;
     blAutoKorr      := False;
     TL2Statistic    := TTL2Statistic.Create(self);


     m_blRemProtoState := False;
     FINIT;
     FcbOutL1 := cbOutL1;
     FcbOutL2 := cbOutL2;
     FcbOutL3 := cbOutL3;
     FcbOutL4 := cbOutL4;
     FcbOutL5 := cbOutL5;
     FcbMaster:= cbMaster;

     mmExplProto.ViewStyle := vsReport;
     nWS := mmExplProto.Width;
     //FTreeModuleData.Color := KNS_COLOR;
    // FTreeModuleData.Color := clBlack;
     //mmExplProto.Color := KNS_COLOR;
     //mmExplProto.Color := clBlack;
     mmExplProto.Columns.Add.Caption    := 'Дата';
     mmExplProto.Columns.Add.Caption    := 'Время';
     mmExplProto.Columns.Add.Caption    := 'Ур';
     mmExplProto.Columns.Add.Caption    := 'СИ';
     mmExplProto.Columns.Add.Caption    := 'Информация';
     mmExplProto.HideSelection := True;


     //Create Tracer
     TraceInit;
     {
     m_nL5Tracer          := TTracer.Create(True);
     m_nL5Tracer.Priority := tpLower;
     m_nL5Tracer.Resume;
     m_byTrState := 0;
     }

     //m_blConnectST := False;
     FTimer         := TTimer.Create(Nil);
     FTimer.Enabled := True;
     FTimer.Interval:= 1000;
     FTimer.OnTimer := DoHalfTime;


     FStatBar := msbStatBar;
     SetTexSB(0,'Information');
     SetTexSB(1,'State');
     SetTexSB(2,'Process');
     SetTexSB(3,'Type');
     SetTexSB(4,'Net');
     SetTexSB(5,'Connection Fail');
     SetTexSB(6,'Запросов:0');


     //SetTree;
     //FTreeModule.Color  := KNS_COLOR;
   //  FTreeModule.Color  :=clBlack;
     //FTreeEditor        := @FTreeModule;
     lbUserInfo.Caption := 'Активность отсутствует';
     //Инициализация поддержки базы данных
    //Инициализация базы данных
    LoadMainForm.Label3.Caption := 'Инициализация поддержки базы данных';
    LoadMainForm.Refresh;
    LoadMainForm.ProgressBar1.Position := 2;
     strSettingsPath := ExtractFilePath(Application.ExeName) + '\\Settings\\USPD_Config.ini';

     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     m_strExePath    := ExtractFilePath(Application.ExeName);

     {
     aniRemConn.FileName := ExtractFilePath(Application.ExeName) + '\\Settings\\Avi\\lmp_rd.avi';
     aniAlarm.FileName := ExtractFilePath(Application.ExeName) + '\\Settings\\Avi\\lmp_rd.avi';
     aniLimit.FileName := ExtractFilePath(Application.ExeName) + '\\Settings\\Avi\\lmp_rd.avi';
     aniQuery.FileName := ExtractFilePath(Application.ExeName) + '\\Settings\\Avi\\lmp_gr.avi';
     aniRemConn.Active := False;
     aniAlarm.Active   := False;
     aniLimit.Active   := False;
     aniQuery.Active   := False;

     aniRemConn.Active := True;
     aniAlarm.Active   := True;
     aniLimit.Active   := True;
     aniQuery.Active   := True;
     }

     m_nOutState     := TStringList.Create;
     m_nInState      := TStringList.Create;
     m_nTypeProt     := TStringList.Create;
     m_nDataGroup    := TStringList.Create;
     m_nNetMode      := TStringList.Create;
     m_nSaveList     := TStringList.Create;
     m_nActiveList   := TStringList.Create;
     m_nActiveExList := TStringList.Create;
     m_nMeterLocation:= TStringList.Create;
     m_nStatusList   := TStringList.Create;
     m_nCmdDirect    := TStringList.Create;
     m_nPTariffList  := TStringList.Create;
     m_nParamList    := TStringList.Create;
     m_nEsNoList     := TStringList.Create;
     m_nCommandList  := TStringList.Create;
     m_nMeterList    := TStringList.Create;
     m_nSpeedList    := TStringList.Create;
     m_nPortTypeList := TStringList.Create;
     m_nParityList   := TStringList.Create;
     m_nDataList     := TStringList.Create;
     m_nStopList     := TStringList.Create;
     m_nSvPeriodList := TStringList.Create;
     m_nJrnlN1       := TStringList.Create;
     m_nJrnlN2       := TStringList.Create;
     m_nJrnlN3       := TStringList.Create;
     m_nJrnlN4       := TStringList.Create;
     m_nUserLayer    := TStringList.Create;
     m_nStateProc    := TStringList.Create;
     m_nTestName     := TStringList.Create;
     m_nWorkDay      := TStringList.Create;
     m_nKTRout       := TStringList.Create;
     m_nDataType     := TStringList.Create;
     //m_nNameMeters   := TStringList.Create;

     m_nOutState.LoadFromFile(m_strCurrentDir+'OutState.dat');
     m_nInState.LoadFromFile(m_strCurrentDir+'InState.dat');
     m_nTypeProt.LoadFromFile(m_strCurrentDir+'TypeProt.dat');
     m_nDataGroup.LoadFromFile(m_strCurrentDir+'DataGroup.dat');
     m_nNetMode.LoadFromFile(m_strCurrentDir+'NetMode.dat');
     m_nSaveList.LoadFromFile(m_strCurrentDir+'StateSaveParam.dat');
     m_nActiveList.LoadFromFile(m_strCurrentDir+'Active.dat');
     m_nActiveExList.LoadFromFile(m_strCurrentDir+'ActiveEx.dat');
     m_nMeterLocation.LoadFromFile(m_strCurrentDir+'MeterLocation.dat');
     m_nStatusList.LoadFromFile(m_strCurrentDir+'StatParam.dat');
     m_nCmdDirect.loadfromfile(m_strCurrentDir+'CmdDirection.dat');
     m_nCommandList.loadfromfile(m_strCurrentDir+'CommandType.dat');
     m_nPTariffList.loadfromfile(m_strCurrentDir+'TariffType.dat');

     m_nParamList.loadfromfile(m_strCurrentDir+'ParamType.dat');
     m_nMeterList.loadfromfile(m_strCurrentDir+'MeterType.dat');
     m_nSpeedList.loadfromfile(m_strCurrentDir+'potrspeed.dat');
     m_nPortTypeList.loadfromfile(m_strCurrentDir+'PortType.dat');
     m_nParityList.loadfromfile(m_strCurrentDir+'portparity.dat');
     m_nDataList.loadfromfile(m_strCurrentDir+'portdbit.dat');
     m_nStopList.loadfromfile(m_strCurrentDir+'portsbit.dat');
     m_nSvPeriodList.loadfromfile(m_strCurrentDir+'SavePeriod.dat');
     m_nEsNoList.LoadFromFile(m_strCurrentDir+'Active.dat');
     m_nJrnlN1.LoadFromFile(m_strCurrentDir+'SettEvent0.dat');
     m_nJrnlN2.LoadFromFile(m_strCurrentDir+'SettEvent1.dat');
     m_nJrnlN3.LoadFromFile(m_strCurrentDir+'SettEvent2.dat');
     m_nJrnlN4.LoadFromFile(m_strCurrentDir+'SettEvent3.dat');
     m_nUserLayer.LoadFromFile(m_strCurrentDir+'SettUserLayer.dat');
     m_nStateProc.LoadFromFile(m_strCurrentDir+'stateproc.dat');
     m_nTestName.LoadFromFile(m_strCurrentDir+'TestName.dat');
     m_nWorkDay.LoadFromFile(m_strCurrentDir+'WorkDay.dat');
     m_nKTRout.LoadFromFile(m_strCurrentDir+'ktrouting.dat');
     m_nDataType.LoadFromFile(m_strCurrentDir+'DataType.dat');

     //Создание загрузчика дерева 2-го уровня
     //FTreeLoader     := CTreeLoader.Create(@FTreeModule);
     //Создание загрузчика дерева 3-го уровня
     FL3TreeLoader   := CL3TreeLoader.Create(@FTreeModuleData);

      //pL3LmeModule := CL3LmeModule.Create(True);
      //pL3LmeModule.PForm := self;
      //pL3LmeModule.Init;
      //pL3LmeModule.PackData;
      //Sleep(15000);
      Fl := TINIFile.Create(strSettingsPath);
      m_nIsRam             := Fl.ReadInteger('DBCONFIG','m_nIsRam', 0);

      m_nIsTimeSV          := Fl.ReadInteger('DBCONFIG','m_nIsTimeSV',0);
      m_nTimeDlt           := Fl.ReadInteger('DBCONFIG','m_nTimeDlt',60);
      m_nTimeCluster       := Fl.ReadString('DBCONFIG','m_nTimeCluster',ExtractFilePath(Application.ExeName)+'\TimeCluster\');
      m_nST                := CSaveTime.Create(m_nTimeDlt,9500,ExtractFilePath(Application.ExeName),m_nTimeCluster,self);
      Fl.Destroy;
      pL3LmeModule := CL3LmeModule.Create(True);

      if (FileExists(ExtractFilePath(Application.ExeName)+'prep.exe')=True) then
      Begin
       pL3LmeModule.StartProcess(ExtractFilePath(Application.ExeName)+'prep.exe',TRUE);
       Sleep(15000);
       DeleteFile(ExtractFilePath(Application.ExeName)+'prep.exe');
      End else Sleep(15);

      // Если база отсутствует то идет восстановление из ..\Restore
      if (FileExists(ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK')=False) or
         (FileExists('C:\WINDOWS\system32\gbak.exe')=False) then
      pL3LmeModule.StartProcess(ExtractFilePath(Application.ExeName)+'restore.bat',TRUE);
      if m_nIsRam=1 then
      strExtrPath   := 'gbak -rep -user sysdba -password masterkey '+ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK '+'r:\ascue\SYSINFOAUTO.FDB'
      else
      if m_nIsRam=0 then
      strExtrPath   := 'gbak -rep -user sysdba -password masterkey '+ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK '+ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FDB';
      pL3LmeModule.StartProcess(strExtrPath,TRUE);


     m_pDB := CDBase.Create;
     m_pDB.Init(strSettingsPath,ExtractFilePath(Application.ExeName));
     //

     advReg.Checked := (m_dwSort and $00000001)>0;
     advAbo.Checked := (m_dwSort and $00000002)>0;
     advGru.Checked := (m_dwSort and $00000004)>0;
     advTuc.Checked := (m_dwSort and $00000008)>0;

     m_nCtrlPortID  := 0;
     m_nCtrlObjID   := 0;
     //advRdTreeDataType.ItemIndex :=  1;
     m_dwTree := 1;

     if m_pDB.Connect=True then
     Begin

      //m_pDB.AddToBase;
      DBUpdate(strSettingsPath);
      //m_blIsLocal := m_pDB.IsLocalConn(m_nCurrentConnection);
      m_pDB.GetParamsTypeTable(m_nParams);
      //Инициализация модуля перевода времени
      //Инициализация модуля настроек
      m_nCF       := TTL5Config.Create(self);
      m_nCF.PlbScheduler := @lbScheduler;
      m_nCF.PlbSchedTime := @lbSchedTime;
      m_nCF.PlbSdlQrylb  := @lbSdlQrylb;
      m_nCF.PlbSetTmState:= @lbSetTmState;
      m_nCF.PlbOnTransTime  := @lbOnTransTime;
      m_nCF.PlbOnTransState := @lbOnTransState;
      m_nCF.PlbSExpired     := @FlbSExpired;
      m_nCF.m_nSetColor.PFormStyler         := @AdvFormStyler1;
      //m_nCF.m_nSetColor.PTreeModule         := @FTreeModule;
      m_nCF.m_nSetColor.PTreeModuleData     := @FTreeModuleData;
      m_nCF.m_nSetColor.PSgParam            := @SgParam;
      m_nCF.m_nSetColor.PSgMeterType        := @SgMeterType;
      m_nCF.m_nSetColor.PSgChannels         := @SgChannels;
      m_nCF.m_nSetColor.PSgMeters           := @SgMeters;
      m_nCF.m_nSetColor.PSgGroup            := @SgGroup ;
      m_nCF.m_nSetColor.PSgAbon             := @SgAbon ;
      m_nCF.m_nSetColor.PSgVMeters          := @SgVMeter;
      m_nCF.m_nSetColor.PSgCNMeters         := @SgCNMeters;
      m_nCF.m_nSetColor.PSgTariffType       := @sgTariffType;
      m_nCF.m_nSetColor.PSgConnList         := @SgConnList;
      m_nCF.m_nSetColor.PSgVParam           := @SgVParam;
      m_nCF.m_nSetColor.PSgTariff           := @SgTariff;
      m_nCF.m_nSetColor.PSgQMCommand        := @SgQMCommand;
      m_nCF.m_nSetColor.PSgCommands         := @SgCommands;
      m_nCF.m_nSetColor.PSgCGrid            := @SgCGrid;
      m_nCF.m_nSetColor.PSgVGrid            := @SgVGrid;
      m_nCF.m_nSetColor.PSgEGrid            := @SgEGrid;
      m_nCF.m_nSetColor.PSgPGrid            := @SgPGrid;
      m_nCF.m_nSetColor.Psgsyazone          := @SgSyazone;
      //m_nCF.m_nSetColor.PsgSznDay           := @SgSznDay;
      m_nCF.m_nSetColor.PsgTransTime        := @m_nCF.PsgGridTransTime;
      //m_nCF.m_nSetColor.PsgTransTime        := @m_nCF.PsgGridTransTime;

      //if EventBox=Nil then EventBox := TEventBox.Create(nil);
      //m_nCF.m_nSetColor.PEventBoxStyler :=  EventBox.PEventBoxStyler;

      m_nUNL := CUnloader.Create(True);
      
      m_nCF.Init;
      m_nCF.InitColor;

      m_nUM             := TTUserManager.Create(nil);
      m_nUM.PLabel      := lbUserInfo;
      m_nUM.PlbCurrUser := lbCurrUser;

      ConnForm    := TConnForm.Create(self);
      ConnForm.m_nConnManager.PL3TreeLoader := @FL3TreeLoader;
      ConnForm.m_nConnManager.PTreePanel    := @advTreePanel;
      ConnForm.m_nConnManager.PDataPanel    := @advDataPanel;

      //Инициализация графики konfigurator

      //m_pDB.LoadReportParams(ReportSettings);
      //m_pDB.LoadReportParams(ReportSettings);
      m_pDB.GetGenSettTable(pGenTable);
      LoadMainForm.Label2.Caption := pGenTable.m_sProjectName;
      LoadMainForm.Label3.Caption := 'Инициализация графики';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.Position := 3;
      ///////////////////////////
      //m_nCF.OnReadSettings;


      m_strL3SelNode := 'Архивы';
      FTreeLoader.LoadTree;
      //FL3TreeLoader.LoadTree;

      TL2Statistic.Init;

      m_nL3ConnEditor                       := CL3ConnEditor.Create;
      //m_nL3ConnEditor.PTreeModule           := @FTreeModule;
      m_nL3ConnEditor.PsgGrid               := @sgConnList;
      m_nL3ConnEditor.PTreeLoader           := @FTreeLoader;
      m_nL3ConnEditor.Init;

      m_nL2ParamEditor                      := CL2ParamEditor.Create;
      //m_nL2ParamEditor.PTreeModule          := @FTreeModule;
      m_nL2ParamEditor.PsgGrid              := @sgParam;
      m_nL2ParamEditor.PTreeLoader          := @FTreeLoader;
      m_nL2ParamEditor.Init;

      //Инициализация эдитора 1-го уровня
      m_nL1Editor                           := CL1Editor.Create;
      //m_nL1Editor.PTreeModule               := @FTreeModule;
      m_nL1Editor.PsgGrid                   := @sgChannels;
      m_nL1Editor.PTreeLoader               := @FTreeLoader;
      m_nL1Editor.Init;

      //m_nL1Editor.PChild.PTreeModule        := @FTreeModule;
      m_nL1Editor.PChild.PsgGrid            := @sgMeters;
      m_nL1Editor.PChild.PTreeLoader        := @FTreeLoader;
      m_nL1Editor.PChild.Init;

      //m_nL1Editor.PChild.PChild.PTreeModule := @FTreeModule;
      m_nL1Editor.PChild.PChild.PcbCmdCombo := @cbCmdCombo;
      m_nL1Editor.PChild.PChild.PsgGrid     := @sgCommands;
      m_nL1Editor.PChild.PChild.PTreeLoader := @FTreeLoader;
      m_nL1Editor.PChild.PChild.Init;

      m_nL1Editor.ExecSetGrid;
      if sgChannels.Cells[1,1]<>''then  m_nL1Editor.PChild.PMasterIndex := StrToInt(sgChannels.Cells[1,1]);
      m_nL1Editor.PChild.ExecSetGrid;
      if sgMeters.Cells[4,1]<>''then    m_nL1Editor.PChild.PChild.PMasterIndex:= StrToInt(sgMeters.Cells[4,1]);
      m_nL1Editor.PChild.PChild.ExecSetGrid;

      m_nL2MTypeEditor             := CL2MTypeEditor.Create;
      m_nL2MTypeEditor.PPageIndex  := 2;
      //m_nL2MTypeEditor.PTreeModule := @FTreeModule;
      m_nL2MTypeEditor.PsgGrid     := @sgMeterType;
      m_nL2MTypeEditor.PsgCGrid    := @sgQMCommand;
      m_nL2MTypeEditor.Init;

      //Инициализация редактора абонентов 3-го уровня
      m_nEDAB                      := CL3AbonEditor.Create;
      m_nEDAB.PPageIndex           := 2;
      //m_nEDAB.PTreeModule          := @FTreeModule;
      m_nEDAB.PsgGrid              := @sgAbon;
      m_nEDAB.PTreeLoader          := @FTreeLoader;
      m_nEDAB.Init;
      //Инициализация редактора групп 3-го уровня
      m_nEDAB.PChild.PPageIndex                := 2;
      //m_nEDAB.PChild.PTreeModule               := @FTreeModule;
      m_nEDAB.PChild.PsgGrid                   := @sgGroup;
      m_nEDAB.PChild.PTreeLoader               := @FTreeLoader;
      m_nEDAB.PChild.Init;
      //Инициализация редактора вычислителей 3-го уровня
      //m_nEDAB.PChild.PChild.PTreeModule        := @FTreeModule;
      m_nEDAB.PChild.PChild.PsgGrid            := @sgVMeter;
      m_nEDAB.PChild.PChild.PsgCGrid           := @sgCNMeters;
      m_nEDAB.PChild.PChild.PComboModule       := @cbChannel;
      m_nEDAB.PChild.PChild.PTreeLoader        := @FTreeLoader;
      m_nEDAB.PChild.PChild.Init;
      //Инициализация редактора вычислителей 3-го уровня
      //m_nEDAB.PChild.PChild.PChild.PTreeModule := @FTreeModule;
      m_nEDAB.PChild.PChild.PChild.PsgGrid     := @sgVParam;
      m_nEDAB.PChild.PChild.PChild.PTreeLoader := @FTreeLoader;
      m_nEDAB.PChild.PChild.PChild.Init;

      m_nEDAB.PChild.ExecSetGrid;
      m_nEDAB.PChild.PChild.ExecSetGrid;

      //Инициализация эдитора тарифных планов
      m_nTPLED             := CL3TarPlaneEditor.Create;
     //m_nTPLED.PTreeModule := @FTreeModule;
      m_nTPLED.PsgGrid     := @sgTarPlane;
      m_nTPLED.Init;
      //Инициализация эдитора описателей тарифов
      //m_nTPLED.PChild.PTreeModule := @FTreeModule;
      m_nTPLED.PChild.PsgGrid     := @sgTariffType;
      m_nTPLED.PChild.Init;
      //Инициализация эдитора тарифных зон
      m_nTPLED.PChild.PChild.PTreeLoader := @FTreeLoader;
      m_nTPLED.PChild.PChild.PsgGrid     := @sgTariff;
      m_nTPLED.PChild.PChild.Init;

      m_nSZED                 := CL3SznEditor.Create;
      m_nSZED.PsgGrid         := @sgSyazone;
      m_nSZED.PsgCGrid        := @sgSznDay;
      m_nSZED.PChild          := @m_nTPLED;
      m_nSZED.PchHolyDay      := @chHolyDay;
      m_nSZED.Init;


      //Инициализация уровней

      LoadMainForm.Label3.Caption := 'Открытие портов';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.position := 4;
      pL1Module := CL1Module.Create(True);
      pL1Module.Init;

      LoadMainForm.Label3.Caption := 'Инициализация счетчиков';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.position := 5;
      pL2Module := CL2Module.Create(True);
      pL2Module.Init;

      pL3LmeModule := CL3LmeModule.Create(True);
      pL3LmeModule.PForm := self;
      pL3LmeModule.PlbUserInfo := lbUserInfo;
      pL3LmeModule.PlbModemInfo:= lbModemInfo;
      pL3LmeModule.PlbLocal    := lbLocal;
      pL3LmeModule.PlbRemote   := lbRemote;
      pL3LmeModule.PlbRemTime  := lbRemTime;
      pL3LmeModule.PL3TreeLoader:= @FL3TreeLoader;

      LoadMainForm.Label3.Caption := 'Инициализация виртуальных счетчиков';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.position := 6;
      pL3LmeModule.Init;

      LoadMainForm.Label3.Caption := 'Инициализация расчетного модуля';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.position := 7;
      //pL4Module := CL4Module.Create(True);
      //pL4Module.Init;

      if mMParser1=Nil then
      mMParser1 := TMParser.Create(Nil);
      pL3Module := CL3Module.Create(True);
      pL3Module.PParser  := mMParser1;
      pL3Module.PForm    := self;
      pL3Module.PPage    := pcView;
      pL3Module.PsgPGrid := @sgPGrid;
      pL3Module.PsgEGrid := @sgEGrid;
      pL3Module.PsgCGrid := @sgCGrid;
      pL3Module.PsgVGrid := @sgVGrid;
      pL3Module.PlbLocal := @lbLocal;
      pL3Module.Init;

      mQServer := CQweryServer.Create(True);
      mQServer.Init;

      mCServer := CCalcTrServer.Create(True);
      mCServer.Init;

      mSServer := CSaveTrServer.Create(True);
      mSServer.Init;

      pL2TmrModule := CTimerThread.Create(True);
      pL2TmrModule.Priority := tpNormal;
      pL2TmrModule.Resume;

      m_blProtoState    := False;
      if m_blIsSlave=True then
      Begin
       //m_blProtoState    := False;
       m_blRemProtoState := False;
      End else
      Begin
       //m_blProtoState    := True;
       m_blRemProtoState := True;
      End;
      if mBtiModule<>Nil then mBtiModule.PlbUserInfo := lbUserInfo;

      pL4Module := CL4Module.Create(True);
      pL4Module.Init;

      mL3FHModule := CL3FindHolesModule.Create;
      mL3FHModule.Init;

      mL3STModule := CL3SelfTestModule.Create(True);
      mL3STModule.PProgress   := m_nCF.PProgress;
      mL3STModule.PProgresslb := m_nCF.PProgresslb;
      mL3STModule.Init(m_nCF.PConfifTbl);

      lbFreeInfo.Caption := m_nCF.GetProjectName;

      FOpenTimer         := TTimer.Create(Nil);
      FOpenTimer.Enabled := True;
      FOpenTimer.Interval:= 20000;
      FOpenTimer.OnTimer := DoHalfOpenTime;
      //WindowState        := wsMaximized;
      //OnActivate(self);
       ///////////////////////////
      LoadMainForm.Label3.Caption := 'Инициализация журнала событий';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.position := 8;

      m_pDB.GetEventsTable(0,m_nEV[0]);
      m_pDB.GetEventsTable(1,m_nEV[1]);
      m_pDB.GetEventsTable(2,m_nEV[2]);
      m_pDB.GetEventsTable(3,m_nEV[3]);
      //if m_blIsSlave=True then
      Begin
       m_pDB.FixMeterEvent(0, EVH_POW_OF, 0, 0, m_nST.GetDateTime);
       m_pDB.FixMeterEvent(0, EVH_FIRST_START, 0, 0, Now);
       m_pDB.FixMeterEvent(0, EVH_POW_ON, 0, 0, Now);
      End;
      //m_nL3RepFrame := TTRepPower.Create(Owner);
      //m_nL3RepFrame.WindowState:=wsNormal;

      //m_pDB.FixUspdEvent(m_nJrnlN1.IndexOf('Первичный запуск'));
      //m_pDB.FixUspdEvent(3);
      TAddRegions := TTAddRegions.Create(self);


     End;
     //lbProName.Left := ToolBar3.Width-Length(lbProName.Caption)*9;

      LoadMainForm.Label3.Caption := 'графическая инициализация';
      LoadMainForm.Refresh;
      LoadMainForm.ProgressBar1.position := 9;
     OnDataEditor(self);

     m_nCF.InitColor;
     LoadMainForm.Release;
     //SetActivePage;
     OnFormResize(self);
     EventBox := TEventBox.Create(self);
     EventBox.PREditL5  := m_reEventer;
     EventBox.PCollapse := CollapsedEvBox;
     if m_blIsSlave=True then EventBox.DisableBox;
     m_pDB.EventFlagCorrector := EVH_COR_TIME_KYEBD;
     ModemPrepare(strSettingsPath);

     //advTreePanel.Width  := 2;
     //advDataPanel.Top := advDataPanel.Top-100;
     advTreePanel.Visible := False;
     //advDataPanel.Visible := False;

     //if m_nIsServer=0 then trTreeData.Items[3].Enabled := False else
     //if m_nIsServer=1 then trTreeData.Items[3].Enabled := True;
     fQweryModule := nil;
     m1:
End;
procedure TTKnsForm.OnFormCreate(Sender: TObject);
begin
    FOutSrvMonitor := mmExplProto;
    LoadSettings;
end;
procedure TTKnsForm.OnFormResize(Sender: TObject);
Var
    nWS : Integer;
begin
    LastChangeTime    := 0;
    STime := now-GetTickCount/(1000*24*60*60);
    nWS := msbStatBar.Width;
    mmExplProto.Columns.Items[0].Width := 100;
    mmExplProto.Columns.Items[1].Width := 70;
    mmExplProto.Columns.Items[2].Width := 30;
    mmExplProto.Columns.Items[3].Width := 35;
    mmExplProto.Columns.Items[4].Width := trunc(nWS-300);

    msbStatBar.Panels[0].Width :=trunc(0.25*nWS);
    msbStatBar.Panels[1].Width :=trunc(0.10*nWS);
    msbStatBar.Panels[2].Width :=trunc(0.10*nWS);
    msbStatBar.Panels[3].Width :=trunc(0.10*nWS);
    msbStatBar.Panels[4].Width :=trunc(0.10*nWS);
    msbStatBar.Panels[5].Width :=trunc(0.12*nWS);
    msbStatBar.Panels[6].Width :=trunc(0.11*nWS);
    msbStatBar.Panels[7].Width :=trunc(0.12*nWS);

    if m_nL1Editor<>Nil       then m_nL1Editor.OnFormResize;
    if m_nEDAB<>Nil  then m_nEDAB.OnFormResize;
    if m_nL2MTypeEditor<>Nil  then m_nL2MTypeEditor.OnFormResize;
    //if m_nEDAB.PChild<>Nil  then m_nEDAB.PChild.OnFormResize;
    if m_nL2ParamEditor<>Nil  then m_nL2ParamEditor.OnFormResize;
    //if m_nTPLED.PChild<>Nil then m_nTPLED.PChild.OnFormResize;
    if m_nL3ConnEditor<>Nil    then m_nL3ConnEditor.OnFormResize;
    if m_nSZED<>Nil    then m_nSZED.OnFormResize;
    //lbUserInfo.Left := trunc(AdvPanel22.Width/2);
    //lbProName.Left := advToolPannel.Width-Length(lbProName.Caption)*8;
    OnSetWindow(self);
end;
procedure TTKnsForm.DBUpdate(strCurrPath:String);
Var
    Fl : TINIFile;
    str,strF : String;
    nPos:Integer;
Begin
    if DBAddFieldEn=1 then
    Begin
     Fl := TINIFile.Create(strCurrPath);
     str := Fl.ReadString('DBCONFIG','DBAddField','');
     nPos := Pos(':::',str);
     while nPos<>0 do
     Begin
      strF := Copy(str,0,nPos-1);
      Delete(str,1,nPos+2);
      nPos := Pos(':::',str);
      m_pDB.ExecQry(strF);
     End;
     Fl.Destroy;
    End;
End;
procedure TTKnsForm.ModemPrepare(strCurrPath:String);
Var
    Fl : TINIFile;
    str,strF : String;
    nPos:Integer;
Begin
    if m_blMDMPrep=1 then
    Begin
     Fl := TINIFile.Create(strCurrPath);
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
     Fl.WriteInteger('DBCONFIG','m_blMDMPrep',0);
     Fl.Destroy;
    End;
End;

procedure TTKnsForm.OnDrawInfoPanell(StatusBar: TStatusBar;Panel: TStatusPanel; const Rect: TRect);
Var
    nIndex : Integer;
Begin
    with msbStatBar.Canvas do
    begin
     nIndex := Panel.Index;
     if Panel.Index=6 then nIndex := 7;
     if m_blConnectST=False then msbImgList.Draw(msbStatBar.Canvas,Rect.Left,Rect.Top,nIndex);
     if m_blConnectST=True then
     Begin
      //nIndex := Panel.Index;
      if Panel.Index=5 then nIndex := 6;
      msbImgList.Draw(msbStatBar.Canvas,Rect.Left,Rect.Top,nIndex);
     End;
     Font.Name := 'Times New Roman';
     TextOut(Rect.left+20, Rect.top,strSB[Panel.Index]);
    end;
End;
procedure TTKnsForm.DoHalfTime(Sender:TObject);
Var
    strTime : String;
    strDate : String;
    i       : Integer;

Begin
    FTimer.Interval := 1000;
    strTime := TimeToStr(Now);
    strDate := DateToStr(Now);
    if msbStatBar<>Nil then
    msbStatBar.Panels[7].Text := strDate+'::'+strTime;
    FL3TreeLoader.Run;
    if m_nIsTimeSV=1 then if m_nST<>Nil then m_nST.Run;

    //Application.Terminate;
    //Exit;


    //TraceL(1,1,strTime);
End;
{
procedure TEventBox.bSaveEvClick(Sender: TObject);
var
  l_str: string;
  I: Integer;
  mPidFile : TextFile;
begin
  if m_sdSaveLog.Execute then
  begin
  try
    AssignFile(mPidFile,m_sdSaveLog.FileName);
    Rewrite(mPidFile);
    if m_blTraceL5=False then
    Begin
     for I := 0 to m_reEventer.Lines.Count-1 do
     begin
      l_str := m_reEventer.Lines[I];
      WriteLn(mPidFile,l_str);
     end;
    end else
    Begin
     for I := 0 to m_reEventer1.Lines.Count-1 do
     begin
      l_str := m_reEventer1.Lines[I];
      WriteLn(mPidFile,l_str);
     End;
    End;
  except
    CloseFile(mPidFile);
    FixEvents(ET_CRITICAL, 'Во время сохранения отчета произошла ошибка!');
  end;
    CloseFile(mPidFile);
    FixEvents(ET_RELEASE, 'Отчет сохранен !');
  end;
end;
}
procedure TTKnsForm.OnGoProto(Sender: TObject);
begin
    m_blProtoState := True;
    m_blRemProtoState := True;
    if m_nCF.IsLocal=False then SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENALL_REQ))
    //SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENALL_REQ));
end;
procedure TTKnsForm.OnStopProto(Sender: TObject);
begin
    m_blProtoState := False;
    m_blRemProtoState := False;
    if m_nCF.IsLocal=False then SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMMALL_REQ))
    //SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMMALL_REQ));
end;
procedure TTKnsForm.OnCloseForm(Sender: TObject; var Action: TCloseAction);
begin
    if blMenuClose=True then
    Begin
    
      if (m_nIsServer=1)and(m_nCurrentConnection=0)and(m_nIsRam<>1) then
      Begin
       if MessageDlg('Сохранить базу перед выходом?',mtWarning,[mbOk,mbCancel],0)=mrOk then
       Begin
        m_pDB.FullDisconnect;
        mL3LmeMoule.PackData;
       End;
      End;

      blMenuClose := True;
      pL2TmrModule.Suspend;
      pL1Module.Suspend;
      pL2Module.Suspend;
      pL3Module.Suspend;
      pL4Module.Suspend;
      TOnSaveTrace('',False);
      //m_pDB.FixUspdEvent(0,0,EVU_POW_OF);
      m_pDB.FullDisconnect;
      Action := caFree;
     //End else Action := caNone;
    End else
    if blMenuClose=False then
    Begin
     blMenuClose := False;
     ActionIcon (1,Application.Icon); // Добавляем значок в трей
     ShowWindow(Handle,SW_HIDE); // Скрываем программу
     ShowWindow(Application.Handle,SW_HIDE); // Скрываем кнопку с TaskBar'а
     Action := caNone;
     m_blMinimized := True;
    End;
end;
procedure TTKnsForm.SetTree;
Var
    rtChild0,rtChild1,rtChild2,rtChild3: TTreeNode;
Begin
     {
     FTreeModule.Items.Clear;
     FTreeModule.ReadOnly := True;
     rtChild0 := FTreeModule.Items.Add(nil,'УСПД');
                 FTreeModule.Items.AddChild(rtChild0,'Настройки');
     rtChild2 := FTreeModule.Items.AddChild(rtChild0,'Конструктор запросов');
                 FTreeModule.Items.AddChild(rtChild2,'Типы устройств');
     rtChild1 := FTreeModule.Items.AddChild(rtChild0,'Каналы');
     }
End;
//L1 Editor Section

procedure TTKnsForm.SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
begin
    if blState=False then //Open
    Begin
     btButt.ImageIndex := 14;
     btButt.Hint       := 'Редактирование';
     blState           := True;
     sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
    End else
    if blState=True then //Close
    Begin
     btButt.ImageIndex := 15;
     btButt.Hint       := 'Отображение';
     blState           := False;
     if blIsRow=True  then sgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect{goEditing}] else
     if blIsRow=False then sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goDrawFocusSelected,goColSizing];
    End;
end;
function TTKnsForm.IsLevelL3(nLevel:Integer):Boolean;
Var
    Node : TTreeNode;
    res  : Boolean;
Begin
    res  := False;
    Node := FTreeModuleData.Selected;
    if Node<>Nil then
    if Node.Level=nLevel then res := True;
    Result := res;
End;
procedure TTKnsForm.OnReloadLevel(Sender: TObject);
begin
    if FTreeLoader.IsLevel(1,'') then m_nL1Editor.OnInitLayer;
end;
procedure TTKnsForm.OnEditNode(Sender: TObject);
begin
    if FTreeLoader.IsLevel(2,'') then m_nL1Editor.OnEditNode;
end;
procedure TTKnsForm.OnAddNode(Sender: TObject);
begin
    if FTreeLoader.IsLevel(1,'') then m_nL1Editor.OnAddNode;
end;
procedure TTKnsForm.OnDeleteNode(Sender: TObject);
begin
    if FTreeLoader.IsLevel(2,'') then m_nL1Editor.OnDeleteNode;
end;
procedure TTKnsForm.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nL1Editor.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure TTKnsForm.OnChannelGetCellType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nL1Editor.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;
procedure TTKnsForm.OnSaveGridChann(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_CE,False,m_blNoCheckPass) then
    begin
      m_nL1Editor.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_PHCHANN)
    end;
    OnSaveEvent;
end;
procedure TTKnsForm.OnSetGridChann(Sender: TObject);
begin
    m_nL1Editor.OnSetGrid;
end;
procedure TTKnsForm.OnInitL1(Sender: TObject);
Var
    pDS : CMessageData;
begin
    m_pDB.FixUspdDescEvent(0,3,EVS_INIT_PHCH,0);
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    if (m_blIsRemCrc=True)or(m_blIsRemEco=True) then Begin OnRemInitL1;exit; End;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL1_REQ,pDS);
end;
procedure TTKnsForm.OnRemInitL1;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Инициализировать L1 в УСПД? ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 0;
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

procedure TTKnsForm.OnAddRowChannel(Sender: TObject);
begin
    if m_blCL2ChannEditor=True then
    m_nL1Editor.OnAddRow;
end;
procedure TTKnsForm.OnCloneRowChann(Sender: TObject);
begin
    if m_blCL2ChannEditor=True then
    m_nL1Editor.OnCloneRow;
end;
procedure TTKnsForm.OnRefreshL1Tree(Sender: TObject);
begin
    if MessageDlg('Обновить дерево?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     //m_nL1Editor.ExecSetTree;
     //FL3TreeLoader.LoadTree;
    End;
end;
procedure TTKnsForm.OnClickGridChannel(Sender: TObject; ARow,
  ACol: Integer);
begin
    m_nL1Editor.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTKnsForm.OnDelRowChann(Sender: TObject);
begin
    if m_blCL2ChannEditor=True then
    m_nL1Editor.OnDelRow;
end;
procedure TTKnsForm.OnDelAllRowChann(Sender: TObject);
begin
    if m_blCL2ChannEditor=True then
    m_nL1Editor.OnDelAllRow;
end;

//L2 Editor Section
procedure TTKnsForm.OnReloadLevelL2(Sender: TObject);
begin
    if FTreeLoader.IsLevel(2,'') then m_nL1Editor.PChild.OnInitLayer;
end;
procedure TTKnsForm.OnEditNodeL2(Sender: TObject);
begin
    if FTreeLoader.IsLevel(3,'') then m_nL1Editor.PChild.OnEditNode;
end;
procedure TTKnsForm.OnAddNodeL2(Sender: TObject);
begin
    if FTreeLoader.IsLevel(2,'') then m_nL1Editor.PChild.OnAddNode;
end;
procedure TTKnsForm.OnDeleteNodeL2(Sender: TObject);
begin
    if FTreeLoader.IsLevel(3,'') then m_nL1Editor.PChild.OnDeleteNode;
end;
procedure TTKnsForm.OnMeterGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nL1Editor.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure TTKnsForm.OnMeterGetCellType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nL1Editor.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;
procedure TTKnsForm.OnChandgeME(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    m_nL1Editor.PChild.OnComboChandge(Sender,ACol, ARow,AItemIndex,ASelection);
end;

procedure TTKnsForm.OnSaveGridMeter(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_CE,False,m_blNoCheckPass) then
    begin
      m_nL1Editor.PChild.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_PHMETER);
    end;
end;
procedure TTKnsForm.OnSetGridMeter(Sender: TObject);
begin
    m_nL1Editor.PChild.OnSetGrid;
end;
procedure TTKnsForm.OnAddRowGridMeter(Sender: TObject);
begin
    //if m_nValue=1 then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_blCL2MetrEditor=True then
    m_nL1Editor.PChild.OnAddRow;
end;
procedure TTKnsForm.OnCloneRowMeter(Sender: TObject);
begin
    //if m_nValue=1 then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_blCL2MetrEditor=True then
    m_nL1Editor.PChild.OnCloneRow;
end;
procedure TTKnsForm.OnDelRowMeter(Sender: TObject);
begin
    if m_blCL2MetrEditor=True then
    m_nL1Editor.PChild.OnDelRow;
end;
procedure TTKnsForm.OnDelAllRowMeter(Sender: TObject);
begin
    if m_blCL2MetrEditor=True then
    m_nL1Editor.PChild.OnDelAllRow;
end;

procedure TTKnsForm.OnInitMeter(Sender: TObject);
Var
    pDS : CMessageData;
begin
    m_pDB.FixUspdDescEvent(0,3,EVS_INIT_MERT,0);
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    if (m_blIsRemCrc=True)or(m_blIsRemEco=True) then Begin OnRemInitL2;exit; End;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL2_REQ,pDS);
end;

procedure TTKnsForm.OnRemInitL2;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Инициализировать L2 в УСПД? ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 1;
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



procedure TTKnsForm.OnClickGridMeter(Sender: TObject; ARow, ACol: Integer);
begin
    m_nL1Editor.PChild.OnClickGrid(Sender,ARow,ACol);
end;
procedure TTKnsForm.OnSetForAllL2Edit(Sender: TObject);
begin
    m_nL1Editor.PChild.OnSetForAll;
end;


//Command Editor
procedure TTKnsForm.OnSetGridCmdL2(Sender: TObject);
begin
    m_nL1Editor.PChild.PChild.OnSetGrid;
end;
procedure TTKnsForm.OnSaveGridCmdL2(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_CE,False,m_blNoCheckPass) then
    m_nL1Editor.PChild.PChild.OnSaveGrid;
end;
procedure TTKnsForm.OnCommandGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nL1Editor.PChild.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure TTKnsForm.OnCommandGetCellType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nL1Editor.PChild.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;
procedure TTKnsForm.OnClickCmdGrid(Sender: TObject; ARow, ACol: Integer);
begin
    m_nL1Editor.PChild.PChild.OnClickGrid(Sender,ARow,ACol);
end;
procedure TTKnsForm.OnDelGridCmdL2(Sender: TObject);
begin
    m_nL1Editor.PChild.PChild.OnDelRow;
end;
procedure TTKnsForm.OnClearScenario(Sender: TObject);
begin
    m_nL1Editor.PChild.PChild.OnDelAllRow;
end;
procedure TTKnsForm.OnDelRowCmd(Sender: TObject);
begin
   if m_blCL2ScenEditor=True then
   m_nL1Editor.PChild.PChild.OnDelRow;
end;
procedure TTKnsForm.OnDelAllRowCmd(Sender: TObject);
begin
   if m_blCL2ScenEditor=True then
   m_nL1Editor.PChild.PChild.OnDelAllRow;
end;
procedure TTKnsForm.OnInitCmp(Sender: TObject);
begin
   m_nL1Editor.PChild.PChild.OnExecInit;
end;
procedure TTKnsForm.OnAddAutoCmd(Sender: TObject);
begin
   if m_blCL2ScenEditor=True then
   m_nL1Editor.PChild.PChild.OnAddAutoCmd;
end;
procedure TTKnsForm.OnClickTree(Sender: TObject);
var
    nNode : TTreeNode;
    pIND  : PCTreeIndex;
Begin
    {
    nNode := FTreeModule.Selected;
    if (nNode<>Nil) then Begin

     m_strL2SelNode := nNode.Text;
     if nNode.Data<>Nil then pIND := nNode.Data;

     if FTreeLoader.IsLevel(3,'Типы устройств') then
     Begin
      m_nL2MTypeEditor.PIndex := pIND.PKey;
      m_nL2MTypeEditor.ExecSelRowGrid;
     End;

     if FTreeLoader.IsLevel(2,'Редактор каналов') then
     Begin
      m_nL1Editor.PIndex := pIND.PKey;
      m_nL1Editor.PChild.PMasterIndex := pIND.PKey;
      m_nL1Editor.ExecSelRowGrid;
     End;

     if FTreeLoader.IsLevel(1,'УСПД') then
     Begin
      //pcGEditor.ActivePageIndex := 0;
     End;



     if FTreeLoader.IsLevel2(3,'Редактор параметров') then
     Begin
      m_nL2ParamEditor.PIndex         := pIND.PKey;
      m_nL2ParamEditor.ExecSelRowGrid;
     End;

     if FTreeLoader.IsLevel2(3,'Редактор каналов') then
     Begin
      //m_nL2MTypeEditor.PIndex := pIND.PKey;
      //m_nL2MTypeEditor.ExecSelRowGrid;
      m_nL1Editor.PIndex              := pIND.FKey;
      m_nL1Editor.PChild.PIndex       := pIND.PKey;
      m_nL1Editor.PChild.PMasterIndex := pIND.FKey;
      m_nL1Editor.PChild.ExecSelRowGrid;
     End;

     if FTreeLoader.IsLevel(2,'Редактор групп') then
     Begin
      m_nEDAB.PChild.PIndex := pIND.PKey;
      m_nEDAB.PChild.PChild.PMasterIndex := pIND.PKey;
      m_nEDAB.PChild.ExecSelRowGrid;
     End;

     if FTreeLoader.IsLevel2(3,'Редактор групп') then
     Begin
      //m_nL2MTypeEditor.PIndex := pIND.PKey;
      //m_nL2MTypeEditor.ExecSelRowGrid;
      m_nEDAB.PChild.PIndex              := pIND.FKey;
      m_nEDAB.PChild.PChild.PIndex       := pIND.PKey;
      m_nEDAB.PChild.PChild.PMasterIndex := pIND.FKey;
      m_nEDAB.PChild.PChild.ExecSelRowGrid;
     End;

     if FTreeLoader.IsLevel(2,'Редактор тарифов') then
     Begin
      m_nTPLED.PChild.PIndex := pIND.PKey;
      m_nTPLED.PChild.PChild.PMasterIndex := pIND.PKey;
      m_nTPLED.PChild.ExecSelRowGrid;
     End;

    End;
    //nNode := FTreeModule.Selected;
    }
end;
procedure TTKnsForm.OnEditParam(Sender: TObject);
begin
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_CONF,SA_USER_PERMIT_PE);
     advTreePanel.Visible := False;
     OpenEditPage;
     SetActiveView(False);
     AdvPanel33.Visible := True;
     pcGEditor.ActivePageIndex := 1;
     m_nL2ParamEditor.ExecSetGrid;
    End;
end;
procedure TTKnsForm.OnEditReq(Sender: TObject);
begin
    if m_nUM.CheckPermitt(SA_USER_PERMIT_QE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_CONF,SA_USER_PERMIT_QE);
      advTreePanel.Visible := False;
     OpenEditPage;
     SetActiveView(False);
     AdvPanel33.Visible := True;
     pcGEditor.ActivePageIndex := 2;
     pcPEditor.ActivePageIndex := 1;
     m_nL2MTypeEditor.ExecSetGrid;
    End;
end;
procedure TTKnsForm.OnEditChannel(Sender: TObject);
begin
    //if m_nUM.CheckPassword(m_blNoCheckPass) then
    if m_nUM.CheckPermitt(SA_USER_PERMIT_CE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_CONF,SA_USER_PERMIT_CE);
     advTreePanel.Visible := False;
     OpenEditPage;
     SetActiveView(False);
     AdvPanel33.Visible := True;
     pcGEditor.ActivePageIndex := 3;
     pcPEditor.ActivePageIndex := 2;
     m_nL1Editor.ExecSetGrid;
    End;
end;
procedure TTKnsForm.OnEditAbons(Sender: TObject);
begin
    //if m_nUM.CheckPassword(m_blNoCheckPass) then
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_CE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_CONF,SA_USER_PERMIT_CE);
     TAbonManager.PrepareAbon(-1,0);
     TAbonManager.ShowModal;
     //OpenEditPage;
     //SetActiveView(False);
     //AdvPanel33.Visible := True;
     //pcGEditor.ActivePageIndex := 3;
     //pcPEditor.ActivePageIndex := 2;
     //m_nL1Editor.ExecSetGrid;
    End;
end;
procedure TTKnsForm.OnEditGroup(Sender: TObject);
begin
    //if m_nUM.CheckPassword(m_blNoCheckPass) then
    if m_nUM.CheckPermitt(SA_USER_PERMIT_GE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_CONF,SA_USER_PERMIT_GE);
     advTreePanel.Visible := False;
     OpenEditPage;
     SetActiveView(False);
     AdvPanel33.Visible := True;
     pcGEditor.ActivePageIndex := 4;
     pcPEditor.ActivePageIndex := 3;
     m_nEDAB.PChild.ExecSetGrid;
    End;
end;
procedure TTKnsForm.OnEditTariffs(Sender: TObject);
begin
    //if m_nUM.CheckPassword(m_blNoCheckPass) then
    if m_nUM.CheckPermitt(SA_USER_PERMIT_TE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_CONF,SA_USER_PERMIT_TE);
     advTreePanel.Visible := False;
     OpenEditPage;
     SetActiveView(False);
     AdvPanel33.Visible := True;
     pcGEditor.ActivePageIndex := 5;
     pcPEditor.ActivePageIndex := 4;
     m_nTPLED.PChild.ExecSetGrid;
    End;
end;
procedure TTKnsForm.OnSetTrace(Sender: TObject);
begin
    advEvGButt.ImageIndex := 12;
    OnOpenL3Trace(Sender);
    pcView.Visible    := False;
    pcPEditor.Align   := alClient;
    pcPEditor.Visible := True;
    pcPEditor.ActivePageIndex := 0;
    OnGoProto(Sender);
end;
procedure TTKnsForm.OnExpandedL1Tree(Sender: TObject; Node: TTreeNode);
Begin
   {
    m_blNoCheckPass := True;
    Node.Selected := True;
    Node := FTreeModule.Selected;
    if (Node<>Nil) then Begin
    if Node.Text='Редактор параметров' then OnEditParam(Sender);
    if Node.Text='Редактор запросов'   then OnEditReq(Sender);
    if Node.Text='Редактор абонентов'  then OnEditAbons(Sender);
    if Node.Text='Редактор каналов'    then OnEditChannel(Sender);
    if Node.Text='Редактор групп'      then OnEditGroup(Sender);
    if Node.Text='Редактор тарифов'    then OnEditTariffs(Sender);
    End;
    m_blNoCheckPass := False;
    }
end;
procedure TTKnsForm.OnChandgeGPage(Sender: TObject);
begin
    m_blNoCheckPass := true;
    if pcGEditor.ActivePage.Caption='Редактор запросов' then OnEditReq(Sender);
    if pcGEditor.ActivePage.Caption='Редактор каналов' then OnEditChannel(Sender);
    if pcGEditor.ActivePage.Caption='Редактор групп' then OnEditGroup(Sender);
    if pcGEditor.ActivePage.Caption='Редактор тарифов' then OnEditTariffs(Sender);
    m_blNoCheckPass := False;
end;
procedure TTKnsForm.OnChandgePPage(Sender: TObject);
begin
    m_blNoCheckPass := true;
    if pcPEditor.ActivePage.Caption='Запросы'   then OnEditReq(Sender);
    if pcPEditor.ActivePage.Caption='Сценарий'  then OnEditChannel(Sender);
    if pcPEditor.ActivePage.Caption='Параметры' then OnEditGroup(Sender);
    if pcPEditor.ActivePage.Caption='Тарифы' then OnEditTariffs(Sender);
    m_blNoCheckPass := False;
end;
procedure TTKnsForm.OnPageTreeCh(Sender: TObject);
begin
    SetActivePage;
end;
procedure TTKnsForm.SetActiveView(blState : Boolean);
Begin
    if blState=False then
    Begin
     pcView.Visible    := False;
     pcPEditor.Align   := alClient;
     pcPEditor.Visible := True;
     m_blEdit          := False;
     m_blEditDT        := True;
    End
    else
    Begin
     pcPEditor.Visible := False;
     pcView.Align      := alClient;
     pcView.Visible    := True;
     m_blEdit          := True;
     m_blEditDT        := False;
    End;
End;
procedure TTKnsForm.SetActivePage;
Begin
    //blMode:Boolean
    {
    if AdvOfficePager1.ActivePage.Caption='Конфигуратор' then
    Begin
     //pcGEditor.Align := alClient;
     //PageControl4.Visible := False;
     //pcGEditor.Visible := True;
     if m_nUM.CheckPassword(False) then
     Begin
      OpenEditPage;
      AdvPanel33.Visible  := True;
      pcView.Visible    := False;
      pcPEditor.Align   := alClient;
      pcPEditor.Visible := True;
     End else CloseEditPage;
    End;
    if AdvOfficePager1.ActivePage.Caption='Данные' then
    Begin
     //PageControl4.Align := alClient;
     //pcGEditor.Visible := False;
     //PageControl4.Visible := True;
     CloseEditPage;
     AdvPanel33.Visible    := False;
     pcPEditor.Visible := False;
     pcView.Align      := alClient;
     pcView.Visible    := True;
    End;
     }
End;

procedure TTKnsForm.OnStartQry(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Запустить УСПД?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FillChar(pDS,sizeof(pDS),0);
     pDS.m_swData0 := -1;
     pDS.m_swData1 := -1;
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True) then Begin SendRemCrcStart(pDS);exit; End;
     m_pDB.FixUspdDescEvent(0,3,EVS_STRT_USPD,0);
     lbUserInfo.Caption := 'Сервер в работе';
     m_nCF.SchedGo;
     pL3LmeModule.m_sALD.Reset;
     if m_nSmartFinder=1 then m_nDataFinder := False;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
     if m_nIsServer=1 then
     Begin
      //advEvGButt.ImageIndex :=26;
      //EventBox.EnableBox;
      //OnOpenL3Trace(Sender);
     End;
    End;
end;

procedure TTKnsForm.OnStopQry(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Остановить УСПД?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FillChar(pDS,sizeof(pDS),0);
     pDS.m_swData3 := 0;
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True) then Begin SendRemCrcStop(pDS);exit; End;
     m_pDB.FixUspdDescEvent(0,3,EVS_STOP_USPD,0);
     lbUserInfo.Caption := 'Сервер остановлен';
     m_nCF.SchedPause;
     pL3LmeModule.m_sALD.Reset;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
    End;
end;
procedure TTKnsForm.SendRemCrcStop(pDS:CMessageData);
Var
    m_nTxMsg  : CHMessage;
    FPRID,fnc,wCRC : Word;
    {szDT,szI,i : Integer;
    nVMID,nMID : Integer;
    m_sdtSumKor,m_sdtLimKor,m_sdtPhLimKor:TDateTime;}
Begin
    FPRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6],  4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10], 4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14], 4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18], 4);
    move(pDS.m_swData4,m_nTxMsg.m_sbyInfo[22], 4);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+1)+4, $FF01);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 201;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26);
     m_nTxMsg.m_sbyInfo[26] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+2));
    End;
    FPUT(BOX_L1, @m_nTxMsg);
    {
    FPRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    szDT  := sizeof(TDateTime);
    szI   := sizeof(Integer);
    nVMID         := 0;
    m_sdtSumKor   := cDateTimeR.SecToDateTime(15);
    m_sdtLimKor   := cDateTimeR.SecToDateTime(950);
    m_sdtPhLimKor := cDateTimeR.SecToDateTime(1850);
    move(nVMID,m_nTxMsg.m_sbyInfo[6],  szI);
    move(m_sdtSumKor,m_nTxMsg.m_sbyInfo[6+szI], szDT);
    move(m_sdtLimKor,m_nTxMsg.m_sbyInfo[6+szI+szDT], szDT);
    move(m_sdtPhLimKor,m_nTxMsg.m_sbyInfo[6+szI+2*szDT], szDT);
    CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (34+1)+4, $FF07);
    CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (34+1)+4);
    FPUT(BOX_L1, @m_nTxMsg);
    }
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
procedure TTKnsForm.SendRemCrcStart(pDS:CMessageData);
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
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+1)+4, $FF00);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 200;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26);
     m_nTxMsg.m_sbyInfo[26] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+1] := Hi(wCRC);
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

{
/Примитивы данных для каждого абонента
  PD_CURRT                     = 0;
  PD_ARCHV                     = 1;
  PD_GRAPH                     = 2;
  PD_PERIO                     = 3;
  PD_RPRTS                     = 4;
  PD_EVENS                     = 5;
  PD_UNKNW                     = 255;
//Тип структуры
  SD_ABONT                     = 0;
  SD_PRIMT                     = 1;
  SD_GROUP                     = 2;
  SD_VMETR                     = 3;
  SD_VPARM                     = 4;
  SD_REPRT                     = 5;
}

procedure TTKnsForm.FTreeModuleDataChange(Sender: TObject;
  Node: TTreeNode);
var
    nNode : TTreeNode;
    pIND  : PCTI;
    //pIND  : PCTreeIndex;
    //res0,res1,res2,res3,res4,res5,res6 : Boolean;
    m_pDS : CGDataSource;
    //m_pDS : CGDataSource;
begin
    nNode := FTreeModuleData.Selected;
    //nNode.ItemId
    if (nNode<>Nil) then
    Begin
     m_strL3SelNode := nNode.Text;
     if nNode.Data<>Nil then
     Begin
      pIND := nNode.Data;
      Move(pIND.m_nCTI,m_pDS.trTRI,sizeof(CTreeIndex));
      Move(m_pDS ,m_pRPDS,sizeof(CGDataSource));
      m_pRPDS.trPTND := pIND;
      m_pDS.dtTime0 := Now;
      m_pDS.dtTime1 := Now;
      m_pDS.nWidth  := Width -advsplitter2.Left-20;
      m_pDS.nHeight := Height-(Height-splHorSplitt.top)-advPannCurrState.Height-advToolPannel.Height-10;
      m_pDS.pOwner  := Owner;
      m_blMinimized := False;
      //trTreeData.Items.Find('Редактор лимитов').Enabled := false;
      with pIND.m_nCTI do Begin
      case PNID of
           PD_UNKNW: if PTSD=SD_ABONT then
           Begin
              //m_pDS.strClassName := 'TDataFrame';
              //m_pDS.strCaption   := 'Абоненты:'+m_strL3SelNode;
           End;
           PD_CURRT: if PTSD=SD_VMETR then
           Begin
              m_pDS.strClassName := 'TDataFrame';
              m_pDS.strCaption   := 'Текущие:'+nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
           End;
           PD_ARCHV,
           PD_PERIO,
           PD_GRAPH: if PTSD=SD_VPARM then
           Begin
              
              m_pDS.strCaption := nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
           End;
           PD_RPRTS: if PTSD=SD_REPRT then
           Begin
              m_pDS.strClassName := 'TTRepPower';
              m_pDS.strCaption   := 'Отчеты:'+nNode.Parent.Parent.Text;
           End;
           PD_EVENS: if PTSD=SD_VMETR then
           Begin
              m_pDS.strClassName := 'TTL5Events';
              m_pDS.strCaption   := 'События:'+nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
           End;
      End;
      End;
     End;
    End;
end;

procedure TTKnsForm.OnClickTreeData(Sender: TObject);
var
    nNode : TTreeNode;
    pIND  : PCTI;
    m_pDS : CGDataSource;
Begin
    if m_blTreeOpen=False then Begin m_blTreeOpen := True;exit; End;
    if m_blIsBackUp=True then
    Begin
     MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
    mnReportEdit.Visible        := False;
    mnAbonEdit.Visible          := False;
    mnControlConnect.Visible    := False;
    mnControlDisconnect.Visible := False;
    mnOpenTransit.Visible       := False;
    nNode := FTreeModuleData.Selected;
    if (nNode<>Nil) then
    Begin
     m_strL3SelNode := nNode.Text;
     if nNode.Data<>Nil then
     Begin
      pIND := nNode.Data;
      Move(pIND.m_nCTI,m_pDS.trTRI,sizeof(CTreeIndex));
      Move(m_pDS ,m_pRPDS,sizeof(CGDataSource));
      m_pRPDS.trPTND := pIND;
      m_pDS.dtTime0 := Now;
      m_pDS.dtTime1 := Now;
      m_pDS.nWidth  := Width -advsplitter2.Left-20;
      m_pDS.nHeight := Height-(Height-splHorSplitt.top)-advPannCurrState.Height-advToolPannel.Height-10;
      m_pDS.pOwner  := Owner;
      m_blMinimized := False;
      with pIND.m_nCTI do Begin
      case PNID of
           PD_UNKNW: if PTSD=SD_ABONT then
           Begin
              if m_blIsLocal=True then
              Begin
               mnControlConnect.Visible    := True;
               mnControlDisconnect.Visible := True;
              End;
              mnAbonEdit.Visible           := True;
           End;
           PD_VMETR: if PTSD=SD_VMETR then
           Begin
              //if m_blIsLocal=True then
              mnOpenTransit.Visible        := True;
           End;
           PD_CURRT: if (PTSD=SD_VMETR) or (PTSD=SD_PRIMT) then
           Begin
              m_pDS.strClassName := 'TDataFrame';
              m_pDS.strCaption   := nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
              SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWDATA_REQ);
           End;
           PD_MONIT: if (PTSD=SD_VMETR) or (PTSD=SD_PRIMT) then
           Begin
              m_pDS.strClassName := 'TTFrmMonitor';
              m_pDS.strCaption   := nNode.Parent.Text+':'+m_strL3SelNode;
              //m_pDS.strCaption := nNode.Parent.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
              SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWDATA_REQ);
           End;
           PD_QWERY: if (PTSD=SD_VMETR) or (PTSD=SD_PRIMT) then
           Begin
             if (fQweryModule <> nil) and (Assigned(fQweryModule.AdvPanel1)) then
             begin
               fQweryModule.Close;
               fQweryModule.Destroy;
               fQweryModule := nil;
             end;
             fQweryModule := TTQweryModule.Create(Self);
             fQweryModule.Caption := nNode.Parent.Text+':'+m_strL3SelNode;
             fQweryModule.InitFrame(@m_pDS.trTRI);
             fQweryModule.WindowState := wsMaximized;
             fQweryModule.Show;
           End;
           PD_SCHEM: if (PTSD=SD_GROUP) then
           Begin
              m_pDS.strClassName := 'TTShemModule';
              m_pDS.strCaption   := 'Схемы:'+nNode.Parent.Text;
              ExecuteSchem(@m_pDS);
           End;
           PD_ARCHV,
           PD_PERIO,
           PD_GRAPH: if PTSD=SD_VPARM then
           Begin
              if m_dwTree=0 then m_pDS.strCaption := nNode.Parent.Text+':'+m_strL3SelNode;
              if m_dwTree=1 then m_pDS.strCaption := nNode.Parent.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
              SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWGRAPH_REQ);
           End;
           PD_LIMIT: if PTSD=SD_VPARM then
           Begin
              fr3LimitEditor.pABOID := pIND.m_nCTI.PAID;
              fr3LimitEditor.pGRID  := pIND.m_nCTI.PGID;
              fr3LimitEditor.pVMID  := pIND.m_nCTI.PVID;
              fr3LimitEditor.pCMDID := pIND.m_nCTI.PCID;
              fr3LimitEditor.ShowModal;
           End;
           PD_RPRTS: if PTSD=SD_REPRT then
           Begin
              m_pDS.strClassName := 'TTRepPower';
              m_pDS.strCaption   := 'Отчеты:'+nNode.Parent.Parent.Text;
              ExecuteReport(@m_pDS);
           End else if PTSD=SD_PRIMT then mnReportEdit.Visible := True;
           PD_VECDG: if PTSD=SD_PRIMT then
           Begin
              m_pDS.strClassName := 'TVectorFrame';
              m_pDS.strCaption   := nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
              SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWDATA_REQ);
           End;
           PD_CTRLF: if PTSD=SD_PRIMT then
           Begin
              m_pDS.strClassName := 'TControlFrame';
              m_pDS.strCaption   := nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
              SendMsg(BOX_L3, m_pDS.trTRI.PVID, DIR_L4TOL3, AL_VIEWDATA_REQ);
           End;
           PD_EVENS: if (PTSD=SD_VMETR) or (PTSD=SD_PRIMT) then
           Begin
              m_pDS.strClassName := 'TTL5Events';
              m_pDS.strCaption   := 'События:'+nNode.Parent.Text+':'+m_strL3SelNode;
              pL3Module.SetDataSource(@m_pDS);
              SendMsg(BOX_L3,m_pDS.trTRI.PVID,DIR_L4TOL3,AL_VIEWDATA_REQ);
           End;
           PD_CHNDG: if (PTSD=SD_PRIMT) then
           Begin
              if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
              Begin
              TMeterChandge.Caption := 'Замены:'+nNode.Parent.Text+':'+m_strL3SelNode;
              TMeterChandge.OnOpen(m_pDS.trTRI);
              TMeterChandge.Show;
              End;
           End;
      End;
      End;
     End;
    End;
end;
procedure TTKnsForm.OnSetWindow(Sender: TObject);
Var
     pDS : CMessageData;
begin
     pDS.m_swData0 := Width -advsplitter6.Left-20;
     pDS.m_swData1 := Height-(Height-splHorSplitt.top)-advPannCurrState.Height-advToolPannel.Height-10;
     SendMsgData(BOX_L3,0,DIR_L4TOL3,AL_VIEWREPLACED_REQ,pDS);
end;
procedure TTKnsForm.OnExpandedTreeData(Sender: TObject; Node: TTreeNode);
Begin
    //Node.Selected := True;
    //Node          := FTreeModuleData.Selected;
    m_blTreeOpen  := False;
    {
    OnClickTreeData(Sender);
    if (Node<>Nil) then Begin
     if Node.Text='Группы' then
     Begin
      PageControl4.ActivePageIndex  := 0;
      m_nEDAB.PChild.ExecSetGrid;
     End;

     if Node.Parent<>Nil then
     if Node.Parent.Text='Группы' then
     Begin
      PageControl4.ActivePageIndex  := 0;
      m_nEDAB.PChild.PChild.ExecSetGrid;
     End;

    End;
    }
end;

//L3 Group Editor
procedure TTKnsForm.OnEditGroupL3(Sender: TObject);
begin
    if IsLevelL3(2) then m_nEDAB.PChild.OnEditNode;
end;
procedure TTKnsForm.OnAddGroupL3(Sender: TObject);
begin
    if IsLevelL3(1) then m_nEDAB.PChild.OnAddNode;
end;
procedure TTKnsForm.OnDelGroupL3(Sender: TObject);
begin
    if IsLevelL3(2) then m_nEDAB.PChild.OnDeleteNode;
end;
procedure TTKnsForm.OnSaveGridGroupL3(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_GE,False,m_blNoCheckPass) then
    begin
      m_nEDAB.PChild.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_GROUP);
    end;
end;
procedure TTKnsForm.OnSetGridGroupL3(Sender: TObject);
begin
    m_nEDAB.PChild.OnSetGrid;
end;
procedure TTKnsForm.OnRefreshL3Tree(Sender: TObject);
begin
    m_nEDAB.PChild.ExecSetTree;
end;
procedure TTKnsForm.OnMeterGetCellColorGL3(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nEDAB.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure TTKnsForm.OnMeterGetCellTypeGL3(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nEDAB.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;
procedure TTKnsForm.OnCloneGroup(Sender: TObject);
begin
    if m_blCL3GroupEditor=True then
    m_nEDAB.PChild.OnCloneRow;
end;
procedure TTKnsForm.OnAddRowGroup(Sender: TObject);
begin
    if m_blCL3GroupEditor=True then
    m_nEDAB.PChild.OnAddRow;
end;
procedure TTKnsForm.OnDelRowGrid(Sender: TObject);
begin
    if m_blCL3GroupEditor=True then
    m_nEDAB.PChild.OnDelRow;
end;
procedure TTKnsForm.OnDelAllRowGroup(Sender: TObject);
begin
    if m_blCL3GroupEditor=True then
    m_nEDAB.PChild.OnDelAllRow;
end;

procedure TTKnsForm.OnClickGroupGrid(Sender: TObject; ARow, ACol: Integer);
begin
    m_nEDAB.PChild.OnClickGrid(Sender,ARow,ACol);
end;

//L3 VMeter Editor
procedure TTKnsForm.OnEditVMeterL3(Sender: TObject);
begin
    if IsLevelL3(3) then m_nEDAB.PChild.PChild.OnEditNode;
end;
procedure TTKnsForm.OnAddVMeterL3(Sender: TObject);
begin
    if IsLevelL3(2) then m_nEDAB.PChild.PChild.OnAddNode;
end;
procedure TTKnsForm.OnDelVMeterL3(Sender: TObject);
begin
    if IsLevelL3(3) then m_nEDAB.PChild.PChild.OnDeleteNode;
end;

procedure TTKnsForm.OnMeterGetCellColorVL3(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nEDAB.PChild.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTKnsForm.OnMeterGetCellTypeVL3(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nEDAB.PChild.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnChandgeVL3(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
   m_nEDAB.PChild.PChild.OnChandgeComboVL3(ACol,ARow,AItemIndex,ASelection)
end;
procedure TTKnsForm.OnSaveGridVMeterL3(Sender: TObject);
begin
   if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
   if m_nUM.CheckPermitt(SA_USER_PERMIT_GE,False,m_blNoCheckPass) then
   begin
     m_nEDAB.PChild.PChild.OnSaveGrid;
     m_pDB.FixUspdEvent(0,3,EVS_CHNG_POINT)
   end;
end;

procedure TTKnsForm.OnSetGridVMeterL3(Sender: TObject);
begin
   m_nEDAB.PChild.PChild.OnSetGrid;
end;
procedure TTKnsForm.OnCloneRowVMeter(Sender: TObject);
begin
   m_nEDAB.PChild.PChild.OnCloneRow;
end;
procedure TTKnsForm.OnAddRowVMeter(Sender: TObject);
begin
   if m_blCL3VMetEditor=True then
   m_nEDAB.PChild.PChild.OnAddRow;
end;
procedure TTKnsForm.OnDelRowVMeter(Sender: TObject);
begin
   if m_blCL3VMetEditor=True then
   m_nEDAB.PChild.PChild.OnDelRow;
end;
procedure TTKnsForm.OnDelAllRowVMeter(Sender: TObject);
begin
   if m_blCL3VMetEditor=True then
   m_nEDAB.PChild.PChild.OnDelAllRow;
end;
procedure TTKnsForm.OnClickGridVMeter(Sender: TObject; ARow,
  ACol: Integer);
begin
   m_nEDAB.PChild.PChild.OnClickGrid(Sender,ARow,ACol);
end;
procedure TTKnsForm.OnChandgeChann(Sender: TObject);
begin
   m_nEDAB.PChild.PChild.OnChandgeChannel;
end;
procedure TTKnsForm.OnConnectVMeter(Sender: TObject);
begin
   m_nEDAB.PChild.PChild.OnConnect;
end;
procedure TTKnsForm.OnClickGridVChannel(Sender: TObject; ARow,
  ACol: Integer);
begin
   m_nEDAB.PChild.PChild.OnClickGridVChannel(Sender,ARow,ACol);
end;
procedure TTKnsForm.OnDropVChannel(Sender: TObject);
begin
   m_nEDAB.PChild.PChild.OnDropVChannel;
end;

//L3 VParam Editor
procedure TTKnsForm.OnMeterGetCellColorVPL3(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   m_nEDAB.PChild.PChild.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);;
end;
procedure TTKnsForm.OnMeterGetCellTypeVPL3(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
   m_nEDAB.PChild.PChild.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;
procedure TTKnsForm.OnChannelGetCellTypeVP(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
   m_nEDAB.PChild.PChild.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;
procedure TTKnsForm.OnSaveGridVParam(Sender: TObject);
begin
   if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
   if m_nUM.CheckPermitt(SA_USER_PERMIT_GE,False,m_blNoCheckPass) then
   begin
     m_nEDAB.PChild.PChild.PChild.OnSaveGrid;
     m_pDB.FixUspdEvent(0,3,EVS_CHNG_PARAM);
   end;
end;
procedure TTKnsForm.OnSetGridVParam(Sender: TObject);
begin
   m_nEDAB.PChild.PChild.PChild.OnSetGrid;
end;
procedure TTKnsForm.OnAddAutoVParam(Sender: TObject);
begin
   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,False,m_blNoCheckPass) then
   if m_blCL3VParEditor=True then
   m_nEDAB.PChild.PChild.PChild.OnAddAutoVParam;
end;
procedure TTKnsForm.OnDelRowVParam(Sender: TObject);
begin
   if m_blCL3VParEditor=True then
   m_nEDAB.PChild.PChild.PChild.OnDelRow;
end;
procedure TTKnsForm.OnDelAllRowVParam(Sender: TObject);
begin
   if m_blCL3VParEditor=True then
   m_nEDAB.PChild.PChild.PChild.OnDelAllRow;
end;
procedure TTKnsForm.OnClickGridVParam(Sender: TObject; ARow,
  ACol: Integer);
begin
    m_nEDAB.PChild.PChild.PChild.OnClickGrid(Sender,ARow,ACol);
end;



procedure TTKnsForm.OnPageL2Resize(Sender: TObject);
Begin
   if m_nL2ParamEditor<>Nil  then m_nL2ParamEditor.OnFormResize;
   if m_nL1Editor<>Nil       then m_nL1Editor.OnFormResize;
   if m_nL2MTypeEditor<>Nil  then m_nL2MTypeEditor.OnFormResize;
   //if m_nEDAB<>Nil           then m_nEDAB.OnFormResize;
   //if m_nTPLED.PChild<>Nil   then m_nTPLED.PChild.OnFormResize;
   if m_nL3ConnEditor<>Nil   then m_nL3ConnEditor.OnFormResize;
   if m_nTPLED<>Nil          then m_nTPLED.OnFormResize;
   //if m_nSZED<>Nil    then m_nSZED.OnFormResize;
end;
procedure TTKnsForm.OnPageL3Resize(Sender: TObject);
begin
   //if m_nEDAB<>Nil  then m_nEDAB.OnFormResize;
end;
//L2 Meter Type Editor
procedure TTKnsForm.OnGetColorMType(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   m_nL2MTypeEditor.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure TTKnsForm.OnGetTypeMType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nL2MTypeEditor.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;


procedure TTKnsForm.OnDelRowMType(Sender: TObject);
begin
   if m_blCL2QmCEditor=True then
   m_nL2MTypeEditor.OnDelRow;
end;

procedure TTKnsForm.OnSetGridMType(Sender: TObject);
begin
   m_nL2MTypeEditor.OnSetGrid;
end;

procedure TTKnsForm.OnSaveGridMType(Sender: TObject);
begin
   if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
   if m_nUM.CheckPermitt(SA_USER_PERMIT_QE,False,m_blNoCheckPass) then
   begin
     m_nL2MTypeEditor.OnSaveGrid;
     m_pDB.FixUspdEvent(0,3,EVS_CHNG_TPMETER);
   end;
end;

procedure TTKnsForm.OnDelAllRowMType(Sender: TObject);
begin
    if m_blCL2QmCEditor=True then
    m_nL2MTypeEditor.OnDelAllRow;
end;

procedure TTKnsForm.OnClickGridMType(Sender: TObject; ARow, ACol: Integer);
begin
    m_nL2MTypeEditor.OnClickGrid(Sender, ARow, ACol);
end;

procedure TTKnsForm.OnSaveGridQmC(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PE,False,m_blNoCheckPass) then
    m_nL2MTypeEditor.PChild.OnSaveGrid;
end;

procedure TTKnsForm.OnSetGridQmC(Sender: TObject);
begin
    m_nL2MTypeEditor.PChild.OnSetGrid;
end;

procedure TTKnsForm.OnDelRowQMC(Sender: TObject);
begin
    m_nL2MTypeEditor.PChild.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowQMC(Sender: TObject);
begin
    m_nL2MTypeEditor.PChild.OnDelAllRow;
end;

procedure TTKnsForm.OnClickGridQMC(Sender: TObject; ARow, ACol: Integer);
begin
    m_nL2MTypeEditor.PChild.OnClickGrid(Sender, ARow, ACol);
end;
procedure TTKnsForm.OnLoadAllCmd(Sender: TObject);
begin
    
    m_nL2MTypeEditor.PChild.OnLoadAllCmd;
end;
procedure TTKnsForm.OnSetForAllQmParam(Sender: TObject);
begin
    m_nL2MTypeEditor.PChild.OnSetForAllQmParam;
end;
procedure TTKnsForm.OnAddMType(Sender: TObject);
begin
    if m_blCL2QmCEditor=True then
    m_nL2MTypeEditor.OnAddRow;
end;
procedure TTKnsForm.OnComboChQMC(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    m_nL2MTypeEditor.PChild.OnComboChandge(Sender,ACol, ARow, AItemIndex,ASelection);
end;
procedure TTKnsForm.OnCloneRowMType(Sender: TObject);
begin
    if m_blCL2QmCEditor=True then
    m_nL2MTypeEditor.OnCloneRow;
end;

procedure TTKnsForm.OnEditFrame(Sender: TObject);
begin
       AdvPanel33.Visible := False;
       //m_nL2EditFrame := TTL2EditForm.Create(Owner);
       //m_nL2EditFrame.Show;
       //m_nL2EditFrame.Free;
       //TL2EditForm.WindowState := wsMaximized;
end;

procedure TTKnsForm.OnSaveTrace(Sender: TObject);
begin
    TOnSaveTrace('',False);
end;
{
CGDataSource = packed record
     PKey       : Integer;
     FKey       : Integer;
     strCaption : String;
     dtTime0    : TDateTime;
     dtTime1    : TDateTime;
    End;
}
procedure TTKnsForm.OnDataEditor(Sender: TObject);
Var
     pDS : CGDataSource;
begin
     CloseEditPage;
     AdvPanel33.Visible := False;
     advTreePanel.Visible := True;
     //AdvOfficePager1.ActivePageIndex := 1;
     m_nUM.OnClear(Sender);
     {
     m_pDS.PKey       := 0;
     m_pDS.FKey       := 0;
     m_pDS.strCaption := 'View Caption';
     m_pDS.dtTime0    := Now;
     m_pDS.dtTime1    := Now;
     m_pDS.nWidth     := Width -splitter2.Left-20;
     m_pDS.nHeight    := Height-(Height-splHorSplitt.top)-Image15.Height-ToolBar3.Height-10;
     m_pDS.pOwner     := Owner;
     m_nGraphWiew.CreateView(@pDS);
     }
     SetActiveView(True);
end;
//Parameter Editor Routine
procedure TTKnsForm.OnClickParamGrid(Sender: TObject; ARow, ACol: Integer);
begin
     m_nL2ParamEditor.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTKnsForm.OnGetColorParam(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     m_nL2ParamEditor.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTKnsForm.OnGetCellTypeParam(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nL2ParamEditor.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnSaveGridParam(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PE,False,m_blNoCheckPass) then
    begin
      m_nL2ParamEditor.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_SBPARAM);
    end;
end;

procedure TTKnsForm.OnSetGridParam(Sender: TObject);
begin
    m_nL2ParamEditor.OnSetGrid;
end;

procedure TTKnsForm.OnAddParam(Sender: TObject);
begin
    if m_blCL2ParEditor=True then
    m_nL2ParamEditor.OnAddRow;
end;

procedure TTKnsForm.OnCloneParam(Sender: TObject);
begin
    if m_blCL2ParEditor=True then
    m_nL2ParamEditor.OnCloneRow;
end;

procedure TTKnsForm.OnDelRowParam(Sender: TObject);
begin
    if m_blCL2ParEditor=True then
    m_nL2ParamEditor.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowParam(Sender: TObject);
begin
    if m_blCL2ParEditor=True then
    m_nL2ParamEditor.OnDelAllRow;
end;



procedure TTKnsForm.OnLoadFFile(Sender: TObject);
begin
    m_nL2ParamEditor.OnLoadFromFile;
end;



procedure TTKnsForm.OnPCViewResize(Sender: TObject);
begin
    if pL3Module<>Nil then pL3Module.PGView.OnFormResize(Sender);
    if pL3Module<>Nil then pL3Module.PDView.OnFormResize(Sender);
end;

procedure TTKnsForm.OnGetCellColorGV(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    pL3Module.PGView.OnGetCellColorGV(Sender,ARow,ACol,AState,ABrush,AFont);
end;
{
     pDS  : CMessageData;
begin
     if IsGraph=True then
     Begin
      szDT := sizeof(TDateTime);
      pDS.m_swData0 := FMasterIndex;
      pDS.m_swData1 := FIndex;
      pDS.m_swData2 := FMID;
      pDS.m_swData3 := FPRID;
      pDS.m_swData4 := FLocation;
      Move(dtPic2.DateTime,pDS.m_sbyInfo[0]   ,szDT);
      Move(dtPic1.DateTime,pDS.m_sbyInfo[szDT],szDT);
      SendMsgData(BOX_L3_LME,FMasterIndex,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
      SendMsgData(BOX_L3_LME,FMID,DIR_LHTOLM3,QL_DATA_GRAPH_REQ,pDS);

}
procedure TTKnsForm.OnInitL3(Sender: TObject);
Var
    pDS : CMessageData;
begin
    m_pDB.FixUspdDescEvent(0,3,EVS_INIT_VMET,0);
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INITL3_REQ,pDS);
end;

//Tarif Type Editor
procedure TTKnsForm.OnClickTypeTarGrid(Sender: TObject; ARow,
  ACol: Integer);
begin
    m_nTPLED.PChild.OnClickGrid(Sender, ARow, ACol);
end;
procedure TTKnsForm.OnChannelGetCellTTypeColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nTPLED.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure TTKnsForm.OnChannelGetCellTTarType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nTPLED.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnSaveGridTTar(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_TE,False,m_blNoCheckPass) then
    begin
      m_nTPLED.PChild.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_OPZONE);
    end;
end;

procedure TTKnsForm.OnSetGridTTar(Sender: TObject);
begin
    m_nTPLED.PChild.OnSetGrid;
end;

procedure TTKnsForm.OnAddTTar(Sender: TObject);
begin
    if m_blCL3TarTypeEditor=True then
    m_nTPLED.PChild.OnAddRow;
end;

procedure TTKnsForm.OnCloneTTar(Sender: TObject);
begin
    if m_blCL3TarTypeEditor=True then
    m_nTPLED.PChild.OnCloneRow;
end;

procedure TTKnsForm.OnDellRowTTar(Sender: TObject);
begin
    if m_blCL3TarTypeEditor=True then
    m_nTPLED.PChild.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowTTar(Sender: TObject);
begin
    if m_blCL3TarTypeEditor=True then
    m_nTPLED.PChild.OnDelAllRow;
end;

procedure TTKnsForm.OnChandgeTar(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    m_nTPLED.PChild.PChild.OnComboChandge(Sender,ACol,ARow,AItemIndex,ASelection);
end;

procedure TTKnsForm.OnGetCellColorTar(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nTPLED.PChild.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTKnsForm.OnGetCellTar(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nTPLED.PChild.PChild.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnSaveGridTar(Sender: TObject);
begin
    if m_nUM.CheckPermitt(SA_USER_PERMIT_TE,False,m_blNoCheckPass) then
    begin
      m_nTPLED.PChild.PChild.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_T_ZONE); 
    end;
    OnSaveEvent;
end;

procedure TTKnsForm.OnSetGridTar(Sender: TObject);
begin
    m_nTPLED.PChild.PChild.OnSetGrid;
end;

procedure TTKnsForm.OnAddAutoTar(Sender: TObject);
begin
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,False,m_blNoCheckPass) then
    if m_blCL3TariffEditor=True then
    m_nTPLED.PChild.PChild.OnAddRow;
end;

procedure TTKnsForm.OnDelRowTar(Sender: TObject);
begin
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,False,m_blNoCheckPass) then
    if m_blCL3TariffEditor=True then
    m_nTPLED.PChild.PChild.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowTar(Sender: TObject);
begin
   if m_blCL3TariffEditor=True then
    m_nTPLED.PChild.PChild.OnDelAllRow;
end;

procedure TTKnsForm.OnClickTarGrid(Sender: TObject; ARow, ACol: Integer);
begin
    m_nTPLED.PChild.PChild.OnClickGrid(Sender, ARow, ACol);
end;



procedure TTKnsForm.OnCalculate(Sender: TObject);
begin
    //pL3Module.OnCalculate;
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,False,m_blNoCheckPass) then
    m_nEDAB.PChild.PChild.PChild.OnTimeSynchronize;
end;

procedure TTKnsForm.OnSetForAllParam(Sender: TObject);
begin
    m_nEDAB.PChild.PChild.PChild.OnSetForAllParam;
end;


procedure TTKnsForm.OnGetCellColorDV(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    pL3Module.PDView.OnGetCellColorDV(Sender,ARow,ACol,AState,ABrush,AFont);
end;


procedure TTKnsForm.OnPrintData1(Sender: TObject);
begin
   sgPGrid.PrintSettings.Centered    := true;
   //sgPGrid.PrintSettings.Borders     := pbSingle;
   AdvPreviewDialog1.Grid := sgPGrid;
   AdvPreviewDialog1.Execute;
end;

procedure TTKnsForm.OnPrintVectorData(Sender: TObject);
begin
   sgVGrid.PrintSettings.Centered    := true;
   //sgPGrid.PrintSettings.Borders     := pbSingle;
   AdvPreviewDialog1.Grid := sgVGrid;
   AdvPreviewDialog1.Execute();
end;

procedure TTKnsForm.OnPrintData4(Sender: TObject);
begin
   sgEGrid.PrintSettings.Centered    := true;
   //sgEGrid.PrintSettings.Borders     := pbSingle;
   AdvPreviewDialog1.Grid := sgEGrid;
   AdvPreviewDialog1.Execute;
end;

procedure TTKnsForm.OnPrintDataTr(Sender: TObject);
begin
   sgCGrid.PrintSettings.Centered    := true;
   //sgCGrid.PrintSettings.Borders     := pbSingle;
   AdvPreviewDialog1.Grid := sgCGrid;
   AdvPreviewDialog1.Execute;
end;

procedure TTKnsForm.OnGetCellColorGV4(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  pL3Module.PGView.OnGetCellColorGV4(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTKnsForm.OnConnectToUspd(Sender: TObject);
begin
   //SendPMSG(BOX_L1,1,DIR_L5TOL1,PH_CONN_IND);
   ConnForm.Init;
   ConnForm.ShowModal;
   //ConnForm.Show;
end;

procedure TTKnsForm.OnDiscUspd(Sender: TObject);
begin
   //SendPMSG(BOX_L1,1,DIR_L5TOL1,PH_DISC_IND);
    m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_STAT,0);
    TL2Statistic.Show;
end;



//Connection Editor Routine
procedure TTKnsForm.OnSaveGridConn(Sender: TObject);
begin
   if m_nUM.CheckPermitt(SA_USER_PERMIT_CNE,False,m_blNoCheckPass) then
   m_nL3ConnEditor.OnSaveGrid;
end;
procedure TTKnsForm.OnSetGridConn(Sender: TObject);
begin
   m_nL3ConnEditor.OnSetGrid;
end;
procedure TTKnsForm.OnAddAutoConn(Sender: TObject);
begin
   m_nL3ConnEditor.OnAddRow;
end;

procedure TTKnsForm.OnCloneConn(Sender: TObject);
begin
   m_nL3ConnEditor.OnCloneRow;
end;
procedure TTKnsForm.OnDelRowConn(Sender: TObject);
begin
   m_nL3ConnEditor.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowConn(Sender: TObject);
begin
   m_nL3ConnEditor.OnDelAllRow;
end;

procedure TTKnsForm.OnClickConnGrid(Sender: TObject; ARow, ACol: Integer);
begin
   m_nL3ConnEditor.OnClickGrid(Sender, ARow, ACol);
end;

procedure TTKnsForm.OnGetCellColorConn(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   m_nL3ConnEditor.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTKnsForm.OnGetCellConn(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
   m_nL3ConnEditor.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnChandgeConn(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
   m_nL3ConnEditor.OnComboChandge(Sender,ACol,ARow,AItemIndex,ASelection);
end;
//REPORTS
{
procedure CCDataView.CreateView(pDS:PCGDataSource);
Begin
     m_strClassName := pDS.strClassName;
     if m_strClassName='TDataFrame' then
     Begin
      pDS.nViewID    := FindView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End else
     if m_strClassName='TTL5Events' then
     Begin
      pDS.nViewID    := FindEvView(pDS.trTRI.PVID);
      if pDS.nViewID =-1 then CreateEvNew(pDS);
      if pDS.nViewID<>-1 then View(pDS.nViewID);
     End;
End;
}
procedure TTKnsForm.ExecuteReport(pDS:PCGDataSource);
Var
    FForm : TForm;
    //TTRepPower
Begin
    if m_blIsBackUp=True then
    Begin
     MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
    FForm := self;
    //Move(pDS^,m_pRPDS,sizeof(CGDataSource));
    pDS.nViewID := FindRepView(pDS.trTRI.PAID);
    if pDS.nViewID=-1 then
    begin
     m_nL3RepFrame        := TTRepPower.Create(Owner);
     m_nL3RepFrame.Caption:= pDS.strCaption;
     m_nL3RepFrame.PABOID := pDS.trTRI.PAID;
     m_nL3RepFrame.PCURREP:= pDS.trTRI.PGID;
     m_nL3RepFrame.Init;
     m_nL3RepFrame.PrepareForm;
     m_nL3RepFrame.SetActivePage;
    end else
    if pDS.nViewID<>-1 then
    Begin
     (FForm.MDIChildren[pDS.nViewID] as TTRepPower).PCURREP := pDS.trTRI.PGID;
     (FForm.MDIChildren[pDS.nViewID] as TTRepPower).PrepareForm;
     (FForm.MDIChildren[pDS.nViewID] as TTRepPower).SetActivePage;
     FForm.MDIChildren[pDS.nViewID].Show;
    End;
End;
{
 property PABOID   : Integer         read FABOID    write FABOID;
    property PMID     : Integer         read FMID      write FMID;
    property PVMID    : Integer         read FVMID     write FVMID;
    property PPRID    : Integer         read FPRID     write FPRID;
    property PTID     : Integer         read FTID      write FTID;
}
procedure TTKnsForm.ExecuteVectorDG(pDS:PCGDataSource);
Var
    FForm : TForm;
    //TTRepPower
Begin
{
    if m_blIsBackUp=True then
    Begin
     MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
    FForm := self;
    //Move(pDS^,m_pRPDS,sizeof(CGDataSource));
    pDS.nViewID := FindVecView(pDS.trTRI.PVID);
    if pDS.nViewID=-1 then
    begin
     m_nL3VecFrame        := TVectorFrame.Create(Owner);
     m_nL3VecFrame.Caption:= pDS.strCaption;
     m_nL3VecFrame.PABOID := pDS.trTRI.PAID;
     m_nL3VecFrame.PMID   := pDS.trTRI.PMID;
     m_nL3VecFrame.PVMID  := pDS.trTRI.PVID;
     m_nL3VecFrame.PPRID  := pDS.trTRI.PPID;
     m_nL3VecFrame.PTID   := pDS.trTRI.PTID;
     m_nL3VecFrame.PsgVGrid := @sgVGrid;
     //m_nL3RepFrame.PCURREP:= pDS.trTRI.PGID;
     m_nL3VecFrame.Init;
     //m_nL3VecFrame.PrepareForm;
    end else
    if pDS.nViewID<>-1 then
    Begin
     //(FForm.MDIChildren[pDS.nViewID] as TVectorFrame).PrepareForm;
     //(FForm.MDIChildren[pDS.nViewID] as TVectorFrame).PCURREP := pDS.trTRI.PGID;
     //(FForm.MDIChildren[pDS.nViewID] as TVectorFrame).SetActivePage;
     FForm.MDIChildren[pDS.nViewID].Show;
    End;
    }
End;

function TTKnsForm.FindRepView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     FForm : TForm;
Begin
     res := -1;
     FForm := self;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TTRepPower' then
      if (FForm.MDIChildren[i] as TTRepPower).PABOID = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
function TTKnsForm.FindVecView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     FForm : TForm;
Begin
     res := -1;
     FForm := self;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TVectorFrame' then
      if (FForm.MDIChildren[i] as TVectorFrame).PVMID = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
procedure TTKnsForm.OnExecuteReport(Sender: TObject);
begin
    if m_pRPDS.trTRI.PAID<>$ffff then ExecuteReport(@m_pRPDS);
    {
    if m_blIsBackUp=True then
    Begin
     MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
    AdvPanel33.Visible := False;
    if blCreateReport = False then
    begin
     m_nL3RepFrame := TTRepPower.Create(Owner);
     m_nL3RepFrame.WindowState:=wsNormal;
     m_nL3RepFrame.Show;
     blCreateReport := True;
     ReportFormCrete :=True;
    end else
    if blCreateReport = True then
    Begin
     ReportFormCrete :=True;
     m_nL3RepFrame.Show;
     m_nL3RepFrame.SetActivePage;
    End;
    }
end;

procedure TTKnsForm.ExecuteSchem(pDS:PCGDataSource);
Var
    FForm,frm : TForm;
    nDesc : Integer;
    //TTRepPower
Begin
    if m_blIsBackUp=True then
    Begin
     MessageDlg('Производится сжатие базы. Повторите попытку позже.',mtWarning,[mbOk,mbCancel],0);
     exit;
    End;
    FForm := self;
    pDS.nViewID := FindSchemView(pDS.trTRI.PGID);
    if pDS.nViewID=-1 then
    begin
     m_nSchDrv.GetForm(0,0,FForm,frm,nDesc);
     //FForm.MDIChildren[nIndex].ClassName
     //FForm.MDIChildren.
     //m_nL3SchFrame        := TTShemModule.Create(Owner);
     //m_nL3SchFrame.Caption:= pDS.strCaption;
     //m_nL3SchFrame.PABOID := pDS.trTRI.PAID;
     //m_nL3SchFrame.PGID   := pDS.trTRI.PGID;
     //m_nL3SchFrame.Init;
     //m_nL3SchFrame.PrepareForm;
    end else
    if pDS.nViewID<>-1 then
    Begin
     //(FForm.MDIChildren[pDS.nViewID] as TTRepPower).PCURREP := pDS.trTRI.PGID;
     (FForm.MDIChildren[pDS.nViewID] as TTShemModule).PrepareForm;
     //(FForm.MDIChildren[pDS.nViewID] as TTShemModule).SetActivePage;
     FForm.MDIChildren[pDS.nViewID].Show;
     //(FForm.MDIChildren[pDS.nViewID] as TTShemModule).SaveForm;
    End;
End;
{
Procedure TForm1.Button2Click(Sender : TObject);
Var
  InStream, BinStream : TMemoryStream;
//  StList            : TStringList;
//  St                : String;
  I, K, NAddr       : integer;
  AComps            : TComponent;
Begin

  BinStream := TMemoryStream.Create;
  InStream := TMemoryStream.Create;
//  StrStream := TMemoryStream.Create;
//  StList := TStringList.Create;

  InStream.LoadFromFile('c:\1111.dfm');

  InStream.Position := 0;
  ObjectTextToBinary(InStream, BinStream);

//  K := ComponentCount;
//  I := 0;
//
//  While (I < K) And (K > 0) Do
//    If ((Components[I] Is TControl)) Then Begin
//      Components[I].Destroy;
//      K := ComponentCount;
//    End Else Inc(I);

  BinStream.Position := 0;
  AComps := BinStream.ReadComponent(Nil);

//  While AComps.ComponentCount > 0 Do Begin
//    TC := TControl(AComps.Components[0]);
//    TC.Parent := Self;
//    AComps.RemoveComponent(TC);
//    InsertComponent(TC);
//    (TC As TButton).OnClick := Button2Click;
//  End;

  For I := 1 To AComps.ComponentCount Do
    If TControl(AComps.Components[I - 1]) Is TButton Then
      (AComps.Components[I - 1] As TButton).OnClick := Button2Click;
//  AComps.free;

End;

}

function TTKnsForm.FindSchemView(nIndex:Integer):Integer;
Var
     i,res : Integer;
     FForm : TForm;
Begin
     res := -1;
     FForm := self;
     for i:=0 to FForm.MDIChildCount-1 do
     Begin
      if FForm.MDIChildren[i].ClassName='TTShemModule' then
      if (FForm.MDIChildren[i] as TTShemModule).PGID = nIndex then
       Begin
        res := i;
        break;
       End;
     End;
     Result := res;
End;
procedure TTKnsForm.OnChandgeOpenL1(Sender: TObject);
begin
    if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENL1_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMML1_REQ));
end;
procedure TTKnsForm.OnChandgeOpenL2(Sender: TObject);
begin
    if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENL2_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMML2_REQ));
end;
procedure TTKnsForm.OnChandgeOpenL3(Sender: TObject);
begin
    if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENL3_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMML3_REQ));
end;
procedure TTKnsForm.OnChandgeOpenL4(Sender: TObject);
begin
    if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENL4_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMML4_REQ));
end;
procedure TTKnsForm.OnChandgeOpenL5(Sender: TObject);
begin
    if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENL5_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMML5_REQ));
end;

procedure TTKnsForm.OnChandgeOpenAll(Sender: TObject);
begin
    if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENALL_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMMALL_REQ));
end;

procedure TTKnsForm.OnChandgeOpenRAll(Sender: TObject);
begin
if (Sender as TAdvOfficeCheckBox).Checked then
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETOPENRALL_REQ)) else
    SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SETREMMRALL_REQ));
end;

procedure TTKnsForm.OnSaveProto(Sender: TObject);
begin
    svSaveDProto.Filter := 'Text files (*.log)|*.log;*.*';
    svSaveDProto.Execute;    //TSaveDialog
    TOnSaveTrace(svSaveDProto.FileName,True);
end;

procedure TTKnsForm.OnSaveBase(Sender: TObject);
Var
    pDS : CMessageData;
begin
    //if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
    if MessageDlg('Выполнить сохранение базы?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_STRT_ARCH_BASE,0);
     lbUserInfo.Caption := 'Сервер в работе';
     //if m_blIsLocal=True  then pL3LmeModule.StartPackProc;;
     if (m_blIsRemCrc=True)or(m_blIsRemEco=True) then Begin OnPackDB;exit; End;
     if m_blIsLocal=True then
     Begin
      pDS.m_swData4:=MTR_LOCAL;
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SAVE_DB_REQ,pDS);
     End;
     if m_blIsLocal=False then SendRSMsg(CreateMSG(BOX_L3,0,DIR_LHTOLMC,NL_SAVEDB_REQ));
    End;
end;
procedure TTKnsForm.OnPackDB;
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
    FPRID    : integer;
Begin
    //Выключить функцию поиска пустот
    if MessageDlg('Упаковать базу в УСПД? ',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FPRID := 0;
     FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
     m_nTxMsg.m_sbyInfo[6] := 4;
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

procedure TTKnsForm.OnActivate(Sender: TObject);
begin
    if m_nFirstStart=0 then
    Begin
    //if m_blIsSlave=False then
    Begin
      //m_nCurrentConnection := 0;
      //m_nL3RepFrame := TTRepPower.Create(Owner);
      //m_pDB.FixMeterEvent(0, EVH_FIRST_START, 0, 0, Now);
      //m_pDB.FixMeterEvent(0, EVH_POW_ON, 0, 0, Now - timeGetTime*EncodeTime(0,0,0,1));
      OnConnectToUspd(self);
      if ConnForm.m_blQuerryConnected=False then
      Begin
       if m_blTimerClose=False then
       Begin
        blMenuClose := True;
        Close;
       End else exit;
      End  else
      Begin
       if m_nReStartEvent = 1 then
       begin
       //m_pDB.FixUspdEvent(0,0,EVH_POW_ON);
       m_pDB.FixUspdEvent(0,0,EVH_START_REPROGRAMM);
       m_nReStartEvent := 0;
       m_pDB.WriteReStartEvent(strSettingsPath);
       end;
       lbUserInfo.Caption := 'Успешная авторизация';
       if EventBox<>Nil then  m_nCF.m_nSetColor.PEventBoxStyler :=  EventBox.PEventBoxStyler;
       //WindowState := wsMaximized;
       //if m_nEDAB<>Nil  then m_nEDAB.OnFormResize;
       FOpenTimer.Enabled := False;
      End;
    End;
    End;
    m_nFirstStart:=m_nFirstStart+1;
end;

procedure TTKnsForm.OnGetCellColorDVT(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    pL3Module.PDView.OnGetCellColorDV(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTKnsForm.OnClickSettings(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else 
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_INIT,0);
     m_nCF.Show;
    End;
end;

procedure TTKnsForm.OnPpResize(Sender: TObject);
begin
    if m_nL1Editor<>Nil       then m_nL1Editor.OnFormResize;
    if m_nEDAB<>Nil  then m_nEDAB.OnFormResize;
    if m_nL2MTypeEditor<>Nil  then m_nL2MTypeEditor.OnFormResize;
    //if m_nEDAB.PChild<>Nil  then m_nEDAB.PChild.OnFormResize;
    if m_nL2ParamEditor<>Nil  then m_nL2ParamEditor.OnFormResize;
    //if m_nTPLED.PChild<>Nil then m_nTPLED.PChild.OnFormResize;
    if m_nTPLED<>Nil        then m_nTPLED.OnFormResize;
    if m_nL3ConnEditor<>Nil    then m_nL3ConnEditor.OnFormResize;
end;
procedure TTKnsForm.OnEntCh(Sender: TObject);
begin
    SetActivePage;
end;
procedure TTKnsForm.CloseEditPage;
Begin
    m_pDB.FixUspdDescEvent(0,3,EVS_CLOS_CONF,0);
    //AdvOfficePage5.Enabled  := False;
    AdvOfficePage7.Enabled := False;
    AdvOfficePage9.Enabled  := False;
    AdvOfficePage10.Enabled  := False;
    AdvOfficePage11.Enabled := False;
End;
procedure TTKnsForm.OpenEditPage;
Begin
    //AdvOfficePage5.Enabled  := True;
    AdvOfficePage7.Enabled := True;
    AdvOfficePage9.Enabled  := True;
    AdvOfficePage10.Enabled  := True;
    AdvOfficePage11.Enabled := True;
End;
                               
procedure TTKnsForm.OnStopLocalServer(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Разорвать модемное соединение?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     //lbUserInfo.Caption := 'Сервер остановлен';
     //if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     //if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
    End;
end;


procedure TTKnsForm.OnStartLocalServer(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Установить модемное соединение?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     //lbUserInfo.Caption := 'Сервер в работе';
     //if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     //if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     pDS.m_swData4 := MTR_LOCAL;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
    End;
end;

procedure TTKnsForm.OnCreateMeters(Sender: TObject);
begin
    if mBtiModule<>Nil then
    Begin
     mBtiModule.ResetBTI;
    End;
end;

procedure TTKnsForm.OnDisconnect(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Разорвать удаленное соединение?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     lbUserInfo.Caption := 'Соединение разорвано';
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
    End;
end;
procedure TTKnsForm.OnMDownPE(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  m_nEDAB.PChild.PChild.PChild.OnMDownPE(Sender,Button,Shift,X,Y);
end;

procedure TTKnsForm.N61Click(Sender: TObject);
begin
  if MessageDlg('Вы действительно хотите завершить работу с программой?',mtWarning,[mbOk,mbCancel],0)=mrOk then
  Begin
   blMenuClose := True;
   //m_pDB.FixUspdEvent(0,0,EVU_POW_OF);
   //ActionIcon (2,Application.Icon);
   m_pDB.FixUSPDEvent(0,0,EVH_ARM_EXIT);
   Close;
  End
end;

procedure TTKnsForm.OnEvents(Sender: TObject);
Var
    i : Integer;
    nNode : TTreeNode;
    strNode : String;
Begin
     strNode := 'УСПД';
     for i:=0 to FTreeModuleData.Items.Count-1 do
     Begin
      if FTreeModuleData.Items[i].Text=strNode then
      Begin
       //if FTreeModuleData.Items[i].Count<>0 then
       Begin
        FTreeModuleData.Items[i].Selected := True;
        OnClickTreeData(self);
       End;
       //FTree.Items[i+1].StateIndex := 1;
       break;
      End
     End;
End;
Procedure TTKnsForm.WindowMessage(Var Msg:TMessage);
Begin
    IF Msg.WParam=SC_MINIMIZE then
    Begin
     //WindowState:=wsMinimized;
     blMenuClose := False;
     ActionIcon (1,Application.Icon); // Добавляем значок в трей
     ShowWindow(Handle,SW_HIDE); // Скрываем программу
     ShowWindow(Application.Handle,SW_HIDE); // Скрываем кнопку с TaskBar'а
     m_blMinimized := True;
    End
     else
        inherited;
    //inherited;
End; // end proc
procedure TTKnsForm.MouseClick(var Msg:TMessage);
Var p:tpoint;
begin

    GetCursorPos(p); //Запоминаем координаты курсора мыши(см. P/S)
    Case Msg.LParam OF //Проверяем какая кнопка была нажата
    WM_LBUTTONUP,WM_LBUTTONDBLCLK:
    Begin
     ActionIcon (2,Application.Icon); // Удаляем значок из трея
     ShowWindow(Application.Handle,SW_SHOW); // Восстанавливаем кнопку программы
     ShowWindow(Handle,SW_SHOW); // Восстанавливаем окно программы
     m_blMinimized := False;
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLDATA_REQ);
     OnActivate(self);
    End;
    WM_RBUTTONUP:
    Begin
     SetForegroundWindow(Handle); // Восстанавливаем программу в качестве переднего окна
     //pTrayPopup1.Popup(p.X, p.Y); // Заставляем всплыть TPopUp
     PostMessage(Handle,WM_NULL,0,0);
    end;
    End; // end proc
end;
procedure TTKnsForm.ActionIcon(n:Integer;Icon:TIcon);
Var
    Nim:TNotifyIconData;
    strNotify : String;
    i : Integer;
begin
    With Nim do // Заполняем структуру Nim….
    Begin
     cbSize:=SizeOf(Nim); // Размер
     Wnd:=Handle; // Хендл нашего приложения(окна)
     uID:=1;
     uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
     hicon:=Icon.Handle; // Хендл передаваемой в процедуру иконки
     uCallbackMessage:=wm_user+1;
     //szTip:='Арм Энергетика v2.2_101010';
     strNotify := 'Арм Энергетика v2.2 '+ lbLocal.Caption;
     if (Length(strNotify)-2)<63 then
     Begin
      for i:=0 to Length(strNotify)-2 do szTip[i] := strNotify[1+i];
      szTip[i+1] := Char(0);
     End else szTip:='Арм Энергетика v2.2';
    End;
    Case n OF // Действия выполняемые процедурой
        1: Shell_NotifyIcon(Nim_Add,@Nim);
        2: Shell_NotifyIcon(Nim_Delete,@Nim);
        3: Shell_NotifyIcon(Nim_Modify,@Nim);
    end;
end; // end proc
procedure TTKnsForm.DoHalfOpenTime(Sender:TObject);
Begin
     FOpenTimer.Enabled := False;
     //if m_blIsSlave=False then
     Begin
      if m_nCF.IsAutoTray=True then
      Begin
       m_blTimerClose:= True;
       m_nFirstStart := 0;
       blMenuClose := False;
       ActionIcon (1,Application.Icon); // Добавляем значок в трей
       ShowWindow(Handle,SW_HIDE); // Скрываем программу
       ShowWindow(Application.Handle,SW_HIDE); // Скрываем кнопку с TaskBar'а
       m_blMinimized := True;
       ConnForm.Close;
      End;
     End;
End;
procedure TTKnsForm.N62Click(Sender: TObject);
begin
     ShellExecute(Application.MainForm.Handle,nil,
                pChar('Help.doc'),'','',SW_SHOW);
end;

procedure TTKnsForm.OnGoScheduler(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
     //if MessageDlg('Запустить планировщик?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
     Begin
      m_pDB.FixUspdDescEvent(0,3,EVS_STRT_SHDL,0);
      if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Запуск планировщика...';End;
      if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Запуск удаленного планировщика...';End;
      if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SHLGO_DATA_REQ,pDS);
     End;
end;
procedure TTKnsForm.OnPauseScheduler(Sender: TObject);
Var
    pDS : CMessageData;
    str : String;
begin
     if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
     //if MessageDlg('Остановить планировщик?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_pDB.FixUspdDescEvent(0,3,EVS_STOP_SHDL,0);
      if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Останов планировщика...';End;
      if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Останов удаленного планировщика...';End;
      if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_SHLST_DATA_REQ,pDS);
     End;
end;

procedure TTKnsForm.OnSetUsers(Sender: TObject);
begin
    //if m_nUM.CheckPassword(m_blNoCheckPass) then
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else Begin
    m_nUM.OnClear(Sender);
    if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
    Begin
     m_pDB.FixUspdDescEvent(0,3,EVS_OPEN_EACC,0);
     TUsers.ShowModal;
    End;
    End;
end;
procedure TTKnsForm.OnSaveEvent;
begin
    if EventFlag = EVH_MOD_TARIFF     then   m_pDB.FixUspdEvent(0,0,EVH_MOD_TARIFF);
    if EventFlag_Speed = EVH_MOD_SPEED      then   m_pDB.FixUspdEvent(0,0,EVH_MOD_SPEED);
    if EventFlag_Adress = EVH_MOD_ADRES_USPD then   m_pDB.FixUspdEvent(0,0,EVH_MOD_ADRES_USPD);
    if EventFlag = EVH_MOD_PASSWORD   then   m_pDB.FixUspdEvent(0,0,EVH_MOD_PASSWORD);
    EventFlag_Speed   := -1;
    EventFlag_Adress  := -1;
    EventFlag         := -1;
    m_nReStartEvent   := 1;
    m_pDB.WriteReStartEvent(strSettingsPath);
end;

procedure TTKnsForm.sgChannelsGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  IF  ACol = 8   then  EventFlag_Speed := EVH_MOD_SPEED;
  IF  ACol = 17  then  EventFlag_Adress := EVH_MOD_ADRES_USPD;
end;

procedure TTKnsForm.sgTariffGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  IF  ((ACol = 7) or (ACol = 8))  then  EventFlag := EVH_MOD_TARIFF;
end;

procedure TTKnsForm.WMGotoForeground(var Msg:TMessage);
begin
   if m_blMinimized then
   begin
     ActionIcon (2,Application.Icon);        // Удаляем значок из трея
     ShowWindow(Application.Handle,SW_SHOW); // Восстанавливаем кнопку программы
     ShowWindow(Handle,SW_SHOW);             // Восстанавливаем окно программы
     m_blMinimized := False;
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLGRAPH_REQ);
     SendMsg(BOX_L3,0,DIR_L4TOL3,AL_UPDATEALLDATA_REQ);
     OnActivate(self);
   end
   else
   begin
     Application.Minimize;
     Application.Restore;
   end;
   inherited;
end;

procedure TTKnsForm.OnClickAbout(Sender: TObject);
begin
   Tabout.ShowModal;
end;

procedure TTKnsForm.OnMDownGE(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  m_nEDAB.PChild.PsgGridChild  := @sgVParam;
  m_nEDAB.PChild.OnMDownGE(Sender,Button,Shift,X,Y);
end;


{
//Состояние абонента/счетчика
  SA_LOCK                      = $01;
  SA_UNLK                      = $02;
  SA_CVRY                      = $04;
  SA_ALRM                      = $08;
  Move(pIND^,m_pDS.trTRI,sizeof(CTreeIndex));
      m_pDS.dtTime0 := Now;
      m_pDS.dtTime1 := Now;
      m_pDS.nWidth  := Width -advsplitter2.Left-20;
      m_pDS.nHeight := Height-(Height-splHorSplitt.top)-AdvPanel16.Height-AdvPanel22.Height-10;
      m_pDS.pOwner  := Owner;
      m_blMinimized := False;
      case pIND.PNID of
           PD_UNKNW: if pIND.PTSD=SD_ABONT then
           Begin
}
procedure TTKnsForm.OnExclude_Inquiry(Sender: TObject);
var
    pDS       : CMessageData;
begin
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW: if PTSD=SD_ABONT then
         Begin
          if MessageDlg('Отключить абонента?',mtWarning,[mbOk,mbCancel],0)=mrOk then
          Begin
           PSTT := SA_LOCK;
           FL3TreeLoader.SetAbonState(m_pRPDS);
           pDS.m_swData0 := PAID;
           pDS.m_swData1 := 0;
           pDS.m_swData2 := 0;
           if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
           if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
           SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CONNM_ABON_REQ,pDS);
          End;
         End;
         PD_VMETR,
         PD_EVENS,
         PD_CURRT,
         PD_ARCHV,
         PD_PERIO,
         PD_GRAPH : if PTSD=SD_VMETR then
         Begin
          if MessageDlg('Отключить счетчик?',mtWarning,[mbOk,mbCancel],0)=mrOk then
          Begin
           PSTT := SA_LOCK;
           FL3TreeLoader.SetVMetrState(m_pRPDS);
           pDS.m_swData0 := PVID;
           pDS.m_swData1 := PMID;
           pDS.m_swData2 := 0;
           if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
           if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
           SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CONNM_METR_REQ,pDS);
          End;
         End;
    End;
    End;
    {
    //if IsLevelL3(2) then
    Begin
     if MessageDlg('Отключить счетчик ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      //FL3TreeLoader.SetState(SA_LOCK);
     FTreeModuleData.Selected.ImageIndex    := 7;
     FTreeModuleData.Selected.SelectedIndex :=7;
     nNode    := FTreeModuleData.Selected;
     NameTree := FTreeModuleData.Selected.text;
     FL3TreeLoader.LoadGraph(0,NameTree);
     if nNode.Data<>Nil then
     Begin
      pIND  := nNode.Data;
      nVMID := pIND.PVID;
      nMID  := pIND.PMID;
      pDS.m_swData0 := nVMID;
      pDS.m_swData1 := nMID;
      pDS.m_swData2 := 0;
      if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
      if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CONNM_METR_REQ,pDS);
     End;
     End;
    End;
    }
end;
procedure TTKnsForm.OnInclude_Inquiry(Sender: TObject);
var
    pDS       : CMessageData;
begin
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW: if PTSD=SD_ABONT then
         Begin
          if MessageDlg('Подключить абонента?',mtWarning,[mbOk,mbCancel],0)=mrOk then
          Begin
           PSTT := SA_UNLK;
           FL3TreeLoader.SetAbonState(m_pRPDS);
           pDS.m_swData0 := PAID;
           pDS.m_swData1 := 0;
           pDS.m_swData2 := 1;
           if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
           if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
           SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CONNM_ABON_REQ,pDS);
          End;
         End;
         PD_VMETR,
         PD_EVENS,
         PD_CURRT,
         PD_ARCHV,
         PD_PERIO,
         PD_GRAPH : if PTSD=SD_VMETR then
         Begin
          if MessageDlg('Подключить счетчик?',mtWarning,[mbOk,mbCancel],0)=mrOk then
          Begin
           PSTT := SA_UNLK;
           FL3TreeLoader.SetVMetrState(m_pRPDS);
           pDS.m_swData0 := PVID;
           pDS.m_swData1 := PMID;
           pDS.m_swData2 := 1;
           if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
           if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
           SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_CONNM_METR_REQ,pDS);
          End;
         End;
    End;
    End;
end;

//Редатор сезонов
procedure TTKnsForm.OnClickGridSzn(Sender: TObject; ARow, ACol: Integer);
begin
   m_nSZED.OnClickGrid(Sender, ARow, ACol);
end;

procedure TTKnsForm.OnChannelGetCellSznType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
    m_nSZED.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnSaveGridSzTar(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    if m_nUM.CheckPermitt(SA_USER_PERMIT_TE,False,m_blNoCheckPass) then
    begin
      m_nSZED.OnSaveGrid;
      m_pDB.FixUspdEvent(0,3,EVS_CHNG_SYZONE);
    end;
end;

procedure TTKnsForm.OnSetGridSZTar(Sender: TObject);
begin
    m_nSZED.OnSetGrid;
end;

procedure TTKnsForm.OnAddSZTar(Sender: TObject);
begin
    if m_blCL3SznEditor=True then
    m_nSZED.OnAddRow;
end;

procedure TTKnsForm.OnCloneSZTar(Sender: TObject);
begin
    if m_blCL3SznEditor=True then
    m_nSZED.OnCloneRow;
end;

procedure TTKnsForm.OnDellRowSZTar(Sender: TObject);
begin
    if m_blCL3SznEditor=True then
    m_nSZED.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowSZTar(Sender: TObject);
begin
    if m_blCL3SznEditor=True then
    m_nSZED.OnDelAllRow;
end;

procedure TTKnsForm.OnSzResize(Sender: TObject);
begin
    if m_nSZED<>Nil    then m_nSZED.OnFormResize;
end;

    //m_nSZED.OnMDownSZN(Sender,Button,Shift,X,Y);
procedure TTKnsForm.OnMDownSZN(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    m_nSZED.OnMDownSZN(Sender,Button,Shift,X,Y);
end;

procedure TTKnsForm.OnCreateSzn(Sender: TObject);
begin
    m_nSZED.OnCreateSzn;
end;

procedure TTKnsForm.OnGetCellColorSznDay(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nSZED.OnGetCellColorSznDay(Sender,ARow,ACol,AState,ABrush,AFont);;
end;

procedure TTKnsForm.msbStatBarDrawPanel(
  StatusBar: TAdvOfficeStatusBar; Panel: TAdvOfficeStatusPanel;
  const Rect: TRect);
  Var
    nIndex : Integer;
begin
    with msbStatBar.Canvas do
    begin
     nIndex := Panel.Index;
     if Panel.Index=6 then nIndex := 7;
     if m_blConnectST=False then msbImgList.Draw(msbStatBar.Canvas,Rect.Left,Rect.Top,nIndex);
     if m_blConnectST=True then
     Begin
      //nIndex := Panel.Index;
      if Panel.Index=5 then nIndex := 6;
      if Panel.Index=6 then nIndex := 7;
      msbImgList.Draw(msbStatBar.Canvas,Rect.Left,Rect.Top,nIndex);
     End;
     Font.Name := 'Times New Roman';
     TextOut(Rect.left+20, Rect.top,strSB[Panel.Index]);
    end;
end;

procedure TTKnsForm.OnSetForMeters(Sender: TObject);
begin
   if m_nSZED<>Nil then
   m_nSZED.OnFormResize;
end;

procedure TTKnsForm.AdvPanel3Resize(Sender: TObject);
begin
   if m_nSZED<>Nil then
   m_nSZED.OnFormResize;
end;

procedure TTKnsForm.AdvPanel5Resize(Sender: TObject);
begin
  if m_nEDAB.PChild<>Nil then
  m_nEDAB.PChild.PChild.OnFormResize;
end;

procedure TTKnsForm.AdvPanel6Resize(Sender: TObject);
begin
  if m_nEDAB.PChild<>Nil then
  m_nEDAB.PChild.PChild.OnFormResize;
end;

procedure TTKnsForm.OnResizeTarif(Sender: TObject);
begin
  if m_nTPLED<>Nil then
  Begin
   if m_nTPLED.PChild<>Nil then
   m_nTPLED.PChild.OnFormResize;
   m_nTPLED.OnFormResize;
  End;
end;

procedure TTKnsForm.sgMetersMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col, Row : integer;
begin

   sgMeters.MouseToCell(X, Y, Col, Row);
   if (Button = mbLeft) and (Shift = [ssCtrl, ssLeft]) then
   begin
     if (Row = 0) or (sgMeters.Cells[8, Row] = '') then
     begin
       ConfMeterModule.PHAddres        := '0';
       ConfMeterModule.edPassword.Text := '';
     end
     else
     begin
       ConfMeterModule.PHAddres        := sgMeters.Cells[8, Row];
       ConfMeterModule.edPassword.Text := sgMeters.Cells[9, Row];
       if sgMeters.Cells[23, Row] = 'Да' then
         ConfMeterModule.chbGsmCon.Checked := true
       else
         ConfMeterModule.chbGsmCon.Checked := false;
       ConfMeterModule.edTelGsmCon.Text := sgMeters.Cells[22, Row];
       ConfMeterModule.Caption          := 'Параметризация счетчика: ' + sgMeters.Cells[10, Row];
       ConfMeterModule.PhabNum          := sgMeters.Cells[7, Row];
       ConfMeterModule.MID              := StrToInt(sgMeters.Cells[4, Row]);
       ConfMeterModule.m_Type           := m_nL1Editor.PChild.m_nTypeList.IndexOf(sgMeters.Cells[5, Row]);
       ConfMeterModule.m_ProtoID        := m_nTypeProt.IndexOf(sgChannels.Cells[5,m_nL1Editor.PIndex+1]);
       ConfMeterModule.m_sbyReply        := StrToInt(sgMeters.Cells[12,Row]);
       if (ConfMeterModule.m_Type = utlconst.MET_C12) then
       begin
         ConfMeterModule.seVMAddress.MaxValue := HIGH(Integer);
         ConfMeterModule.sePHAddress.MaxValue := HIGH(Integer);
       end;
       ConfMeterModule.m_Password       := sgMeters.Cells[9, Row];
     end;
     advEvGButt.ImageIndex :=26;
     EventBox.EnableBox;
     OnOpenL3Trace(Sender);
     ConfMeterModule.Show;
   end;

end;

procedure TTKnsForm.OnStartTest(Sender: TObject);
begin
   //Start Test
   mL3STModule.OnStart;
end;

procedure TTKnsForm.OnSaveTPlane(Sender: TObject);
begin
   if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
   m_nTPLED.OnSaveGrid;
   m_pDB.FixUspdEvent(0,3,EVS_CHNG_TPLANE);
end;

procedure TTKnsForm.OnSetTPlane(Sender: TObject);
begin
   m_nTPLED.OnSetGrid;
end;

procedure TTKnsForm.OnAddTPlane(Sender: TObject);
begin
   if m_blCL3TarPlaneEditor=True then
   m_nTPLED.OnAddRow;
end;

procedure TTKnsForm.OnCloneTPlane(Sender: TObject);
begin
   if m_blCL3TarPlaneEditor=True then
   m_nTPLED.OnCloneRow;
end;

procedure TTKnsForm.OnDelRowTPlane(Sender: TObject);
begin
   if m_blCL3TarPlaneEditor=True then
   m_nTPLED.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowTPlane(Sender: TObject);
begin
   if m_blCL3TarPlaneEditor=True then
   m_nTPLED.OnDelAllRow;
end;

procedure TTKnsForm.OnClickTPlane(Sender: TObject; ARow, ACol: Integer);
begin
   m_nTPLED.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTKnsForm.OnGetEdTPlane(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
   m_nTPLED.OnChannelGetCellType(Sender,ACol,ARow,AEditor);
end;

procedure TTKnsForm.OnEditSyzone(Sender: TObject);
begin
    SetEditGrid(m_blCL3SznEditor,sznEditButt,sgSyazone,True);
    m_nSZED.SetEditSz;
    if m_blCL3SznEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_SYZONE_ED_ON) else
    if m_blCL3SznEditor=False then m_pDB.FixUspdEvent(0,3,EVS_SYZONE_ED_OF);
end;
                                                         
procedure TTKnsForm.OnSelectSzTday(Sender: TObject; ACol, ARow: Integer;var CanSelect: Boolean);
begin
    //m_nSZED.OnSelectSzTday(Sender,ACol,ARow,CanSelect);
end;

procedure TTKnsForm.OnEditTdaySz(Sender: TObject);
begin
    SetEditGrid(m_blCL3SznTDayEditor,sznTDayEditButt,sgSznDay,False);
    m_nSZED.SetEditDy;
    if m_blCL3SznTDayEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_SZTDAY_ED_ON) else
    if m_blCL3SznTDayEditor=False then m_pDB.FixUspdEvent(0,3,EVS_SZTDAY_ED_OF);
end;                                                       

procedure TTKnsForm.OnGetEdTxtSzDay(Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
    m_nSZED.OnGetEdTxtSzDay(Sender,ACol,ARow,Value);
end;

procedure TTKnsForm.OnDrawTdayCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
    m_nSZED.OnDrawTdayCell(Sender,ACol,ARow,Rect,State);
end;

procedure TTKnsForm.OnSetFreeDay(Sender: TObject);
begin
    m_nSZED.OnSetFreeDay((Sender as TMenuItem).MenuIndex);
end;

procedure TTKnsForm.OnClickCellTday(Sender: TObject; ARow, ACol: Integer);
begin
    m_nSZED.OnClickCellTday(Sender,ARow,ACol);
end;

procedure TTKnsForm.OnSaveGridTDay(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    m_nSZED.OnSaveGridTDay;
    m_pDB.FixUspdEvent(0,3,EVS_CHNG_SZTDAY)
end;

procedure TTKnsForm.OnDelTDay(Sender: TObject);
begin
    if m_blCL3SznTDayEditor=True then
    m_nSZED.OnDelTDay;
end;

procedure TTKnsForm.OnDelTDays(Sender: TObject);
begin
    if m_blCL3SznTDayEditor=True then
    m_nSZED.OnDelTDays;
end;

procedure TTKnsForm.OnSetAllTariff(Sender: TObject);
begin
    m_nTPLED.PChild.OnSetForAll;
end;

procedure TTKnsForm.OnEditTPlane(Sender: TObject);
begin
    SetEditGrid(m_blCL3TarPlaneEditor,plnEditButt,sgTarPlane,True);
    m_nTPLED.SetEdit;
    if m_blCL3TarPlaneEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_TPLANE_ED_ON) else
    if m_blCL3TarPlaneEditor=False then m_pDB.FixUspdEvent(0,3,EVS_TPLANE_ED_OF);
end;                                            

procedure TTKnsForm.OnEditTatiff(Sender: TObject);
begin
    SetEditGrid(m_blCL3TarTypeEditor,trfEditButt,sgTariffType,True);
    m_nTPLED.PChild.SetEdit;
    if m_blCL3TarTypeEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_OPZONE_ED_ON) else
    if m_blCL3TarTypeEditor=False then m_pDB.FixUspdEvent(0,3,EVS_OPZONE_ED_OF);
end;

procedure TTKnsForm.OnSetAllSyzon(Sender: TObject);
begin
    if m_blCL3TarTypeEditor=True then
    if MessageDlg('Тарифный план будет действовать для всех сезонов.Выполнить?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     m_nTPLED.PChild.OnSetAllSyzon;
    End;
end;

procedure TTKnsForm.OnSetAllTDay(Sender: TObject);
begin
    if m_blCL3TarTypeEditor=True then
    if MessageDlg('Генерировать зоны для всех типов дней.Выполнить?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     m_nTPLED.PChild.OnSetAllTDay;
    End;
end;

procedure TTKnsForm.OnCreateTPlanPattern(Sender: TObject);
begin
   if m_blCL3TarTypeEditor=True then
   if MessageDlg('Генерировать шаблонное тарифное расписание.Выполнить?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
     m_nTPLED.PChild.OnSetAllTPlanPattern;
   End;
end;

procedure TTKnsForm.OnSetEdition(Sender: TObject);
begin
    m_nTPLED.PChild.OnSetEdition;
end;

procedure TTKnsForm.OnLoadTariffs(Sender: TObject);
begin
    m_nTPLED.PChild.OnLoadTariffs;
end;

procedure TTKnsForm.OnComboChTType(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    m_nTPLED.PChild.OnComboChTType(Sender,ACol,ARow,AItemIndex,ASelection);
end;

procedure TTKnsForm.OnSetEdGroup(Sender: TObject);
begin
    SetEditGrid(m_blCL3GroupEditor,gruToolBtn,sgGroup,True);
    m_nEDAB.PChild.SetEdit;
    if m_blCL3GroupEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_GROUP_ED_ON) else
    if m_blCL3GroupEditor=False then m_pDB.FixUspdEvent(0,3,EVS_GROUP_ED_OF);
end;
                                
procedure TTKnsForm.OnSetEdVmet(Sender: TObject);
begin
    SetEditGrid(m_blCL3VMetEditor,vmtAdvButt,sgVMeter,True);
    m_nEDAB.PChild.PChild.SetEdit;
    if m_blCL3VMetEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_POINT_ED_ON) else
    if m_blCL3VMetEditor=False then m_pDB.FixUspdEvent(0,3,EVS_POINT_ED_OF);
end;
                   
procedure TTKnsForm.OnSetEdVPar(Sender: TObject);
begin
    SetEditGrid(m_blCL3VParEditor,vprAdvButt,sgVParam,True);
    m_nEDAB.PChild.PChild.PChild.SetEdit;
    if m_blCL3VParEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_PARAM_ED_ON) else
    if m_blCL3VParEditor=False then m_pDB.FixUspdEvent(0,3,EVS_PARAM_ED_OF);
end;
                                     
procedure TTKnsForm.OnSetEdCnl(Sender: TObject);
begin
    SetEditGrid(m_blCL2ChannEditor,cnlAdvButt,sgChannels,True);
    m_nL1Editor.SetEdit;
    if m_blCL2ChannEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_PHCHANN_ED_ON) else
    if m_blCL2ChannEditor=False then m_pDB.FixUspdEvent(0,3,EVS_PHCHANN_ED_OF);
end;
            
procedure TTKnsForm.OnSetEdMtr(Sender: TObject);
begin
    SetEditGrid(m_blCL2MetrEditor,mtrAdvButt,sgMeters,True);
    m_nL1Editor.PChild.SetEdit;
    if m_blCL2MetrEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_PHMETER_ED_ON) else
    if m_blCL2MetrEditor=False then m_pDB.FixUspdEvent(0,3,EVS_PHMETER_ED_OF);
end;
               
procedure TTKnsForm.OnSetEdSce(Sender: TObject);
begin
    SetEditGrid(m_blCL2ScenEditor,sceAdvButt,sgCommands,True);
    m_nL1Editor.PChild.PChild.SetEdit;
    if m_blCL2ScenEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_PHSCEN_ED_ON) else
    if m_blCL2ScenEditor=False then m_pDB.FixUspdEvent(0,3,EVS_PHSCEN_ED_OF);
end;

procedure TTKnsForm.OnSetEdQm(Sender: TObject);
begin
    SetEditGrid(m_blCL2QmCEditor,qmnAdvButt,sgMeterType,True);
    m_nL2MTypeEditor.SetEdit;
    if m_blCL2QmCEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_TPMETER_ED_ON) else
    if m_blCL2QmCEditor=False then m_pDB.FixUspdEvent(0,3,EVS_TPMETER_ED_OF);
end;
       
procedure TTKnsForm.OnSetEdQmz(Sender: TObject);
begin
    SetEditGrid(m_blCL2QmEditor,qmzAdvButt,sgQMCommand,True);
    m_nL2MTypeEditor.PChild.SetEdit;
    if m_blCL2QmEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_SBSCEN_ED_ON) else
    if m_blCL2QmEditor=False then m_pDB.FixUspdEvent(0,3,EVS_SBSCEN_ED_OF);
end;

procedure TTKnsForm.OnSetEdPar(Sender: TObject);
begin
    SetEditGrid(m_blCL2ParEditor,prmAdvButt,sgParam,True);
    m_nL2ParamEditor.SetEdit;
    if m_blCL2ParEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_SBPARAM_ED_ON) else
    if m_blCL2ParEditor=False then m_pDB.FixUspdEvent(0,3,EVS_SBPARAM_ED_OF);
end;

procedure TTKnsForm.OnSetEdZone(Sender: TObject);
begin
    SetEditGrid(m_blCL3TariffEditor,tszAdvButt,sgTariff,True);
    m_nTPLED.PChild.PChild.SetEdit;
    if m_blCL3TariffEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_TZONE_ED_ON) else
    if m_blCL3TariffEditor=False then m_pDB.FixUspdEvent(0,3,EVS_TZONE_ED_OF);
end;             

procedure TTKnsForm.OnSaveParamEx(Sender: TObject);
Var
    str : String;
begin
    str := ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    'Параметры.xls';
    sgParam.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveEdQry1Ex(Sender: TObject);
Var
    str : String;
begin
    str := ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    'ТипыCчетчиков.xls';
    sgMeterType.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveEdQry2Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nL2MTypeEditor.PChild.PMasterIndex)+'_ТипыCчетчиков.xls';
    sgQMCommand.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveChann1Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    'ФизКаналы.xls';
    sgChannels.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveChann3Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nL1Editor.PChild.PChild.PMasterIndex)+'_Команды_Счетчики_ФизКаналы.xls';
    sgCommands.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveChann2Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nL1Editor.PChild.PMasterIndex)+'_Счетчики_ФизКаналы.xls';
    sgMeters.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveGroup1Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    'ГруппыБалл.xls';
    sgGroup.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveGroup2Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nEDAB.PChild.PChild.PMasterIndex)+'_VСчетчики_ГруппыБалл.xls';
    sgVMeter.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveGroup3Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nEDAB.PChild.PChild.PChild.PMasterIndex)+'_VПараметры_VСчетчики_ГруппыБалл.xls';
    sgVParam.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveSzEx(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    'ТарСезоны.xls';
    sgSyazone.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveTPlane1Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    'ТарПланы.xls';
    sgTarPlane.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;
procedure TTKnsForm.OnSaveTPlane2Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nTPLED.PChild.PMasterIndex)+'_ТипыЗон_ТарПланы.xls';
    sgTariffType.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveTPlane3Ex(Sender: TObject);
Var
    str : String;
begin
    str :=ExtractFilePath(Application.ExeName)+'ExportSettings\'+
    IntToStr(m_nTPLED.PChild.PChild.PMasterIndex)+'_Зоны_ТипыЗон_ТарПланы.xls';
    sgTariff.SaveToXLS(str,false);
    SetTexSB(0,'Экспорт в Excel: '+str);
end;

procedure TTKnsForm.OnSaveCurrEx(Sender: TObject);
Var
    str,strCaption : String;
begin
    strCaption := pL3Module.PDView.GetActiveCaption;
    if strCaption<>'' then
    Begin
     strCaption := StringReplace(strCaption,':','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'.','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'"','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'-','_',[rfReplaceAll]);
     str := ExtractFilePath(Application.ExeName)+'ExportData\Текущие_'+strCaption+'.xls';
     sgCGrid.SaveToXLS(str,false);
     SetTexSB(0,'Экспорт в Excel: '+str);
    End;
end;

procedure TTKnsForm.OnSaveEnrg4Ex(Sender: TObject);
Var
    str,strCaption : String;
begin
    strCaption := pL3Module.PGView.GetActiveCaption;
    if strCaption<>'' then
    Begin
     strCaption := StringReplace(strCaption,':','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'.','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'"','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'-','_',[rfReplaceAll]);
     str := ExtractFilePath(Application.ExeName)+'ExportData\Графики4Е_'+strCaption+'.xls';
     sgEGrid.SaveToXLS(str,false);
     SetTexSB(0,'Экспорт в Excel: '+str);
    End;
end;

procedure TTKnsForm.OnSaveEnrgEx(Sender: TObject);
Var
    str,strCaption : String;
begin
    strCaption := pL3Module.PGView.GetActiveCaption;
    if strCaption<>'' then
    Begin
     strCaption := StringReplace(strCaption,':','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'.','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'"','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'-','_',[rfReplaceAll]);
     str := ExtractFilePath(Application.ExeName)+'ExportData\ГрафикиЕ_'+strCaption+'.xls';
     sgPGrid.SaveToXLS(str,false);
     SetTexSB(0,'Экспорт в Excel: '+str);
    End;
end;


procedure TTKnsForm.OnSaveVectorEx(Sender: TObject);
Var
    str,strCaption : String;
begin
    strCaption := pL3Module.PGView.GetActiveCaption;
    if strCaption<>'' then
    Begin
     strCaption := StringReplace(strCaption,':','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'.','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'"','_',[rfReplaceAll]);
     strCaption := StringReplace(strCaption,'-','_',[rfReplaceAll]);
     str := ExtractFilePath(Application.ExeName)+'ExportData\Текущие_'+strCaption+'.xls';
     sgVGrid.SaveToXLS(str,false);
     SetTexSB(0,'Экспорт в Excel: '+str);
    End;
end;


procedure TTKnsForm.OnSaveGridAbonL3(Sender: TObject);
begin
    if TAbout.m_blRG=False then MessageDlg('Разрешено только владельцу!',mtWarning,[mbOk,mbCancel],0) else
    m_nEDAB.OnSaveGrid;
end;

procedure TTKnsForm.OnSetGridAbon(Sender: TObject);
begin
    m_nEDAB.OnSetGrid;
end;

procedure TTKnsForm.OnAddRowAbon(Sender: TObject);
begin
    if m_blCL3AbonEditor=True then
    m_nEDAB.OnAddRow;
end;

procedure TTKnsForm.OnCloneRowAbon(Sender: TObject);
begin
    if m_blCL3AbonEditor=True then
    m_nEDAB.OnCloneRow;
end;

procedure TTKnsForm.OnDelRowAbon(Sender: TObject);
begin
    if m_blCL3AbonEditor=True then
    m_nEDAB.OnDelRow;
end;

procedure TTKnsForm.OnDelAllRowAbon(Sender: TObject);
begin
    if m_blCL3AbonEditor=True then
    m_nEDAB.OnDelAllRow;
end;

procedure TTKnsForm.OnSetEdAbon(Sender: TObject);
begin
    SetEditGrid(m_blCL3AbonEditor,aboToolBtn,sgAbon,True);
    m_nEDAB.SetEdit;
    if m_blCL3AbonEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_ABON_ED_ON) else
    if m_blCL3AbonEditor=False then m_pDB.FixUspdEvent(0,3,EVS_ABON_ED_OF);
end;

procedure TTKnsForm.OnAbonGetCellType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nEDAB.OnChannelGetCellType(Sender,ACol,ARow,AEditor); 
end;

procedure TTKnsForm.OnClickCellAbon(Sender: TObject; ARow, ACol: Integer);
begin
    m_nEDAB.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTKnsForm.OnMDownAbon(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    m_nEDAB.OnMDownGE(Sender,Button,Shift,X,Y);
end;

procedure TTKnsForm.OnAbonResize(Sender: TObject);
begin
    if m_nEDAB<>Nil then
    m_nEDAB.OnFormResize;
end;

procedure TTKnsForm.OnVmeterResize(Sender: TObject);
begin
   if m_nEDAB.PChild.PChild<>Nil then
   m_nEDAB.PChild.PChild.OnFormResize;
end;

procedure TTKnsForm.OnDbClickAbon(Sender: TObject; ARow, ACol: Integer);
begin
    if m_blCL3AbonEditor=False then
    m_nEDAB.OnCloneRow;
end;

procedure TTKnsForm.OnCryOblect(Sender: TObject);
var
    pDS : CMessageData;
    res : Boolean;
begin
    res := False;
    FillChar(pDS,sizeof(pDS),0);
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW: if PTSD=SD_ABONT then
         Begin
          res := True;
         End;
         PD_VMETR,
         PD_EVENS,
         PD_CURRT,
         PD_ARCHV,
         PD_PERIO,
         PD_GRAPH : if PTSD=SD_VMETR then
         Begin
          res := True;
         End;
    End;
    End;
    if res=True then
    Begin
     advEvGButt.ImageIndex :=26;
     EventBox.EnableBox;
     OnOpenL3Trace(Sender);
     move(m_pRPDS.trTRI,TDataFinder.m_pTRI,sizeof(m_pRPDS.trTRI));
     TDataFinder.Init;
     TDataFinder.Caption := m_strL3SelNode;
     TDataFinder.Show;
    End;
End;

procedure TTKnsForm.OnOpenTrace(Sender: TObject);
begin
    if EventBox.Visible=True  then EventBox.Hide else
    if EventBox.Visible=False then
    Begin
       if EventBox.PTraceL5=False then EventBox.Show else
       if EventBox.PTraceL5=True  then
       Begin
        advEvGButt.ImageIndex :=12;
        OnOpenL3Trace(Sender);
        EventBox.Show;
       End;
    End;
end;

procedure TTKnsForm.OnSetCmdForMeters(Sender: TObject);
begin
    m_nL1Editor.PChild.PChild.OnSetCmdForMeters;
end;

procedure TTKnsForm.OnSetCmdForPMeters(Sender: TObject);
begin
    m_nL1Editor.PChild.PChild.OnSetCmdForPMeters;
end;
procedure TTKnsForm.OnSetAllGroup(Sender: TObject);
begin
    m_nEDAB.PChild.PChild.PChild.OnSetAllGroup;
end;
procedure TTKnsForm.OnSetAllInAbon(Sender: TObject);
begin
    m_nEDAB.PChild.PChild.PChild.OnSetAllInAbon;
end;

procedure TTKnsForm.OnSetAllAbon(Sender: TObject);
begin
    m_nEDAB.PChild.PChild.PChild.OnSetAllAbon;
end;

procedure TTKnsForm.btnLimitClick(Sender: TObject);
begin
   //fr3LimitEditor.ShowModal;
end;

procedure TTKnsForm.OnArchivate(Sender: TObject);
begin
    //if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
    Begin
     SaveDialog1.DefaultExt := 'fbk';
     SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Archive';
     SaveDialog1.FileName   := 'sysinfoauto.fbk';
     SaveDialog1.Filter     := 'Файлы баз данных|*.fbk;*.fdb';
     try
     if SaveDialog1.Execute=True then
     Begin
      m_nCF.m_nBA.OnHotArchivate(SaveDialog1.FileName);    //
     End;
     except

     end;
    End;
end;

procedure TTKnsForm.OnChandgeDTreeType(Sender: TObject);
var
    Fl   : TINIFile;
begin
    try
    if m_pDB.IsConnectDB=True then
    Begin
     FL3TreeLoader.m_blEnable := False;
     Fl := TINIFile.Create(strSettingsPath);
     //m_dwTree := advRdTreeDataType.ItemIndex;
     m_dwTree := 1;
     FL3TreeLoader.SelectTreeType;
     Fl.WriteInteger('DBCONFIG','m_dwTree', m_dwTree);
     Fl.Destroy;
     FL3TreeLoader.m_blEnable := True;
    End;
    except
    end;
end;

procedure TTKnsForm.OnClickSort(Sender: TObject);
var
    Fl   : TINIFile;
    nM   : TMenuItem;
begin
    try
    FL3TreeLoader.m_blEnable := False;
    Fl := TINIFile.Create(strSettingsPath);
    nM := (Sender as TMenuItem);
    if nM.Checked=True  then
    Begin
     m_dwSort   := m_dwSort and not(1 shl nM.Tag);
     nM.Checked := False;
    End else
    if nM.Checked=False then
    Begin
     m_dwSort   := m_dwSort or(1 shl nM.Tag);
     nM.Checked := True;
    End;
    //m_dwSort :=
    {
    m_dwSort := (Dword(advReg.Checked)shl 0) or
                (Dword(advAbo.Checked)shl 1) or
                (Dword(advGru.Checked)shl 2) or
                (Dword(advTuc.Checked)shl 3);
                }
    FL3TreeLoader.SelectTreeType;
    Fl.WriteInteger('DBCONFIG','m_dwSort', m_dwSort);
    Fl.Destroy;
    FL3TreeLoader.m_blEnable := True;
    except
    end;
end;

procedure TTKnsForm.OnOpenL3Trace(Sender: TObject);
begin
    if advEvGButt.ImageIndex=26 then
    Begin
     m_blEdit              := pcView.Visible;
     m_blEditDT            := pcPEditor.Visible;
     pcView.Visible        := False;
     pcPEditor.Visible     := False;
     if EventBox.Visible=True then EventBox.Hide;
     advEvGButt.Caption := 'Выкл. окно сообщений системы';
     advEventBox.Align     := alClient;
     EventBox.PTraceL5     := True;
     advEventBox.Visible   := True;
     advEvGButt.ImageIndex := 12;
    End else
    if advEvGButt.ImageIndex=12 then
    Begin
     advEvGButt.Caption  := 'Вкл. окно сообщений системы';
     pcView.Visible        := m_blEdit;
     pcPEditor.Visible     := m_blEditDT;
     EventBox.PTraceL5     := False;
     advEventBox.Visible   := False;
     advEvGButt.ImageIndex := 26;
    End;
end;
procedure TTKnsForm.CollapsedEvBox(Sender:TObject);
Begin
    advEvGButt.ImageIndex := 26;
    OnOpenL3Trace(Sender);
End;

procedure TTKnsForm.bClearEvClick(Sender: TObject);
begin
    EventBox.OnbClearEvClick(Sender);
end;

procedure TTKnsForm.bSaveEvClick(Sender: TObject);
begin
    EventBox.OnbSaveEvClick(Sender);
end;

procedure TTKnsForm.bEnablEvClick(Sender: TObject);
begin
    EventBox.OnbEnablEvClick(Sender);
end;

procedure TTKnsForm.bDisablEvClick(Sender: TObject);
begin
    EventBox.OnbDisablEvClick(Sender);
end;

procedure TTKnsForm.OnExpand(Sender: TObject);
begin
    advEvGButt.ImageIndex := 12;
    OnOpenL3Trace(Sender);
    if EventBox.Visible=False then EventBox.Show;
end;
{
  //if m_blIsRemCrc=True then Begin SendRemCrcStart(pDS);exit; End;
  //m_pDB.FixUspdDescEvent(0,3,EVU_STRT_USPD,0);
  //lbUserInfo.Caption := 'Сервер в работе';
  //m_nCF.SchedGo;
}
procedure TTKnsForm.OnLoadAllData(Sender: TObject);
var
    pDS : CMessageData;
    res : Boolean;
begin
    FillChar(pDS,sizeof(pDS),0);
    res := False;
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW:
          if PTSD=SD_REGIN then
          Begin
           if MessageDlg('Выполнить загрузку данных из всех абонентов по шаблону?',mtWarning,[mbOk,mbCancel],0)=mrOk then
           Begin
            //trTreeData.Items.Find('Опросить объект по шаблону').Enabled := false;
            pDS.m_swData0 := -1;//PAID
            pDS.m_swData1 := -1;//PVID
            res := True;
           End;
          End;
    End;
    End;
    if res=True then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
     if pcPEditor.ActivePageIndex<>0 then
     if m_nIsServer=1 then Begin advEvGButt.ImageIndex :=26;EventBox.EnableBox;OnOpenL3Trace(Sender);End;
    end;
End;

procedure TTKnsForm.OnLoadAbonData(Sender: TObject);
var
    pDS : CMessageData;
    res : Boolean;
begin
    FillChar(pDS,sizeof(pDS),0);
    res := False;
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW:
          if PTSD=SD_ABONT then
          Begin
           if MessageDlg('Выполнить загрузку данных из абонента по шаблону?',mtWarning,[mbOk,mbCancel],0)=mrOk then
           Begin
            pDS.m_swData0 := PAID;//PAID
            pDS.m_swData1 := -1;  //PVID
            res := True;
           End;
          End;
         PD_VMETR{,
         PD_EVENS,
         PD_CURRT,
         PD_ARCHV,
         PD_PERIO,
         PD_GRAPH }:
         if PTSD=SD_VMETR then
         Begin
          if MessageDlg('Выполнить загрузку данных из т.учета по шаблону?',mtWarning,[mbOk,mbCancel],0)=mrOk then
          Begin
           pDS.m_swData0 := PAID;//PAID
           pDS.m_swData1 := PVID;//PVID
           res := True;
          End;
        End;
    End;
    End;
    if res=True then
    Begin
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_GO_POLL_REQ,pDS);
     if pcPEditor.ActivePageIndex<>0 then
     if m_nIsServer=1 then Begin advEvGButt.ImageIndex :=26;EventBox.EnableBox;OnOpenL3Trace(Sender);End;
    end;
End;


procedure TTKnsForm.sgChannelsDblClick(Sender: TObject);
begin
      m_nL1Editor.ExecMainEditor;
end;

procedure TTKnsForm.sgMetersDblClick(Sender: TObject);
begin
      m_nL1Editor.PChild.ExecMainEditor;
end;

procedure TTKnsForm.LastTimeTimerTimer(Sender: TObject);
begin
   LastDate      := Now;
   LastTickCount := GetTickCount;
end;

procedure TTKnsForm.OnToolBarResize(Sender: TObject);
Var
   nSize:Integer;
begin
   nSize := trunc(advToolPannel.Width/6)-3;
   advTopToolBar.Width := advToolPannel.Width-5;
   advButConn.Width := nSize;
   advButConf.Width := nSize;
   advButData.Width := nSize;
   advButSett.Width := nSize;
   advButUser.Width := nSize;
   advButShem.Width := nSize;
end;

procedure TTKnsForm.OnResizeTrePannel(Sender: TObject);
Var
   nSize:Integer;
begin
   nSize := trunc(advTreePanell.Width/2)-7;
   advTreeTool.Width := advTreePanell.Width;
   advButTree.Width := nSize;
   advButOper.Width := nSize;
end;

procedure TTKnsForm.OnResizePannCurrState(Sender: TObject);
Var
   nLeft,nWidth : Integer;

begin
   //advPannCurrState
   nLeft  := lbOnTransState.Left + lbOnTransState.Width;
   nWidth := advPannCurrState.Width - nLeft;
   //lbFreeInfo.Left := nLeft;
   lbFreeInfo.Width := nWidth - 3;
end;

procedure TTKnsForm.OnAddReports(Sender: TObject);
var
    pDS : CMessageData;
    res : Boolean;
begin
    res := False;
    FillChar(pDS,sizeof(pDS),0);
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW : if PTSD=SD_ABONT then
         Begin
          if TAbonManager.PrepareAbon(m_pRPDS.trTRI.PAID,0)=True then
          TAbonManager.ShowModal;
         End;
         PD_RPRTS : if PTSD=SD_PRIMT then
         Begin
          if TAbonManager.PrepareAbon(m_pRPDS.trTRI.PAID,1)=True then
          TAbonManager.ShowModal;
         End;
    End;
    End;
end;

procedure TTKnsForm.OpenControlSession(Sender: TObject);
begin
    if MessageDlg('Установить связь с УСПД?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW : if PTSD=SD_ABONT then
         Begin
          if TAbonManager.PrepareAbon(m_pRPDS.trTRI.PAID,0)=True then
          Begin
           advEvGButt.ImageIndex :=26;
           EventBox.EnableBox;
           OnOpenL3Trace(Sender);
           TAbonManager.OpenSession(m_pRPDS.trTRI.PAID);
          End;
         End;
    End;
    End;
    End;
end;
procedure TTKnsForm.CloseControlSession(Sender: TObject);
begin
    if MessageDlg('Разорвать связь с УСПД?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_UNKNW : if PTSD=SD_ABONT then
         Begin
          if TAbonManager.PrepareAbon(PAID,0)=True then
          Begin
           advEvGButt.ImageIndex :=26;
           EventBox.EnableBox;
           OnOpenL3Trace(Sender);
           TAbonManager.CloseSession(PAID);
          End;
         End;
    End;
    End;
    End;
end;
procedure TTKnsForm.CloseTransitSession(Sender: TObject);
Var
    nTypeL1,nTypeL2:Integer;
    sE : SECOMTRANZ;
begin
    with m_pRPDS.trTRI do
    Begin
    case PNID of
         PD_VMETR : if PTSD=SD_VMETR then
         Begin
          if TAbonManager.PrepareAbon(PAID,0)=True then
          Begin
           nTypeL1 := mL1Module.m_sIniTbl.Items[PPID].m_sbyProtID;
           nTypeL2 := mL2Module.m_pMeter[PMID].m_nP.m_sbyType;
           if ((nTypeL1=DEV_MASTER)or(nTypeL1=DEV_BTI_SRV))and(nTypeL2<>MET_EKOM3000) then
           Begin
            advEvGButt.ImageIndex :=26;
            EventBox.EnableBox;
            OnOpenL3Trace(Sender);
            ConfMeterModule.PVAddres          := mL2Module.m_pMeter[PMID].m_nP.m_sddPHAddres;
            ConfMeterModule.PHAddres          := mL2Module.m_pMeter[PMID].m_nP.m_sddPHAddres;
            if m_blIsSlave=False then
            ConfMeterModule.PHAddres          := mL3Module.m_nP.Item.Items[PVID].m_sddPHAddres;
            ConfMeterModule.edPassword.Text   := mL2Module.m_pMeter[PMID].m_nP.m_schPassword;
            ConfMeterModule.chbGsmCon.Checked := true;
            ConfMeterModule.edTelGsmCon.Text  := mL2Module.m_pMeter[PMID].m_nP.m_sPhone;
            ConfMeterModule.cbTranzTime.ItemIndex := 5;
            ConfMeterModule.Caption           := '('+ConfMeterModule.PHAddres+')Установка транзитного доступа для '+mL2Module.m_pMeter[PMID].m_nP.m_schName;
            ConfMeterModule.PhabNum           := mL2Module.m_pMeter[PMID].m_nP.m_sddFabNum;
            ConfMeterModule.MID               := PMID;
            ConfMeterModule.m_Type            := mL1Module.m_sIniTbl.Items[PPID].m_sbyType;
            ConfMeterModule.m_ProtoID         := mL1Module.m_sIniTbl.Items[PPID].m_sbyProtID;
            ConfMeterModule.m_sbyReply        := mL2Module.m_pMeter[PMID].m_nP.m_sbyRepMsg;
            ConfMeterModule.PrepareTransit(0);
            //ConfMeterModule.OpenTransit;
            ConfMeterModule.Show;
           End else
           if ((nTypeL1=DEV_MASTER)or(nTypeL1=DEV_BTI_SRV))and(nTypeL2=MET_EKOM3000) then
           Begin
            sE.m_nAutoStart := 0;
            sE.m_nPort      := mL1Module.m_sIniTbl.Items[PPID].m_sbyPortNum;
            sE.m_nPortSpeed := m_nSpeedList.Strings[mL1Module.m_sIniTbl.Items[PPID].m_sbySpeed];
            sE.m_nPhone     := mL2Module.m_pMeter[PMID].m_nP.m_sPhone;
            sE.m_nNode      := 1;
            sE.m_nPassword  := mL2Module.m_pMeter[PMID].m_nP.m_schPassword;
            sE.m_nPause     := -1;
            sE.m_nTotalTime := -1;
            sE.m_nPortUspd  := -1;
            OpenEcomTranz(sE);
           End;
          End;
         End;
    End;
    End;
end;
procedure TTKnsForm.OpenEcomTranz(sE:SECOMTRANZ);
Var
    Fl : TINIFile;
    wnd : HWND;
Begin
    Fl := TINIFile.Create(ExtractFilePath(Application.ExeName)+'DirectECOM.ini');
    with sE do
    Begin
     if sE.m_nAutoStart<>-1 then Fl.WriteInteger('DIRCONFIG','m_nAutoStart',m_nAutoStart);
     if sE.m_nPort<>-1      then Fl.WriteInteger('DIRCONFIG','m_nPort',m_nPort);
     if sE.m_nPortSpeed<>'' then Fl.WriteString('DIRCONFIG','m_nPortSpeed',m_nPortSpeed);
     if sE.m_nPhone<>''     then Fl.WriteString('DIRCONFIG','m_nPhone',m_nPhone);
     if sE.m_nNode<>-1      then Fl.WriteInteger('DIRCONFIG','m_nNode',m_nNode);
     if sE.m_nPassword<>''  then Fl.WriteString('DIRCONFIG','m_nPassword',m_nPassword);
     if sE.m_nPause<>-1     then Fl.WriteInteger('DIRCONFIG','m_nPause',m_nPause);
     if sE.m_nTotalTime<>-1 then Fl.WriteInteger('DIRCONFIG','m_nTotalTime',m_nTotalTime);
     if sE.m_nPortUspd<>-1  then Fl.WriteInteger('DIRCONFIG','m_nPortUspd',m_nPortUspd);
    End;
    Fl.Destroy;
    if FileExists(ExtractFilePath(Application.ExeName)+'SpacePort.exe')=True then
     //pL3LmeModule.StartProcess(ExtractFilePath(Application.ExeName)+'SpacePort.exe',False) else
     ShellExecute(Application.MainForm.Handle,nil,pChar(ExtractFilePath(Application.ExeName)+'SpacePort.exe'),'','',SW_SHOW) else
    MessageDlg('Приложенеие SpacePort не найдено!',mtWarning,[mbOk,mbCancel],0);
    wnd := FindWindow(LPCTSTR('SpacePortForm'),nil);
    if wnd <> 0 then SendMessage(wnd,WM_GOTOFOREGROUND, 0, 0);
End;

{
    SECOMTRANZ = packed record
     m_nPort      : Integer;
     m_nPortSpeed : String;
     m_nPhone     : String;
     m_nNode      : Integer;
     m_nPassword  : String;
     m_nPause     : Integer;
     m_nTotalTime : Integer;
     m_nPortUspd  : Integer;
    End;

[DIRCONFIG]
m_nPort=5
m_nPortSpeed=9600
m_nPhone=1730878
m_nNode=1
m_nPassword=12321
m_nPause=300
m_nTotalTime=900
m_nPortUspd=1

}
{
sgMeters.MouseToCell(X, Y, Col, Row);
   if (Button = mbLeft) and (Shift = [ssCtrl, ssLeft]) then
   begin
     if (Row = 0) or (sgMeters.Cells[8, Row] = '') then
     begin
       ConfMeterModule.PHAddres        := '0';
       ConfMeterModule.edPassword.Text := '';
     end
     else
     begin
       ConfMeterModule.PHAddres        := sgMeters.Cells[8, Row];
       ConfMeterModule.edPassword.Text := sgMeters.Cells[9, Row];
       if sgMeters.Cells[23, Row] = 'Да' then
         ConfMeterModule.chbGsmCon.Checked := true
       else
         ConfMeterModule.chbGsmCon.Checked := false;
       ConfMeterModule.edTelGsmCon.Text := sgMeters.Cells[22, Row];
       ConfMeterModule.Caption          := 'Параметризация счетчика: ' + sgMeters.Cells[10, Row];
       ConfMeterModule.PhabNum          := sgMeters.Cells[7, Row];
       ConfMeterModule.MID              := StrToInt(sgMeters.Cells[4, Row]);
       ConfMeterModule.m_Type           := m_nL1Editor.PChild.m_nTypeList.IndexOf(sgMeters.Cells[5, Row]);
       ConfMeterModule.m_ProtoID        := m_nTypeProt.IndexOf(sgChannels.Cells[5,m_nL1Editor.PIndex+1]);
       ConfMeterModule.m_sbyReply        := StrToInt(sgMeters.Cells[12,Row]);
       if (ConfMeterModule.m_Type = utlconst.MET_C12) then
       begin
         ConfMeterModule.seVMAddress.MaxValue := HIGH(Integer);
         ConfMeterModule.sePHAddress.MaxValue := HIGH(Integer);
       end;
       ConfMeterModule.m_Password       := sgMeters.Cells[9, Row];
     end;
     advEvGButt.ImageIndex :=26;
     EventBox.EnableBox;
     OnOpenL3Trace(Sender);
     ConfMeterModule.Show;
   end;
}

procedure TTKnsForm.OnChannelGen(Sender: TObject);
begin
   if m_blCL2ScenEditor=True then
   m_nL1Editor.PChild.PChild.OnChannelGen;
end;     

procedure TTKnsForm.OnShadow(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (ssAlt in Shift) and (ssCtrl in Shift) and (ssDouble in Shift) then
   begin
     HideCtrlFrame.ShowModal;
   end;
end;

procedure TTKnsForm.AdvGlowButton1Click(Sender: TObject);
begin
    //TQweryModule.InitFrame(5);
    //TQweryModule.ShowModal;
end;

end.
