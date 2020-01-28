{*******************************************************************************
 *    Экспорт данных в файл базы dBase
 *      для Минского энергосбыта
 *    Петрушевич
 *
 *    Предоставить доступ ко всей информации, касающейся приборов учета,
 * систем учета электрической энергии.
 *
 *    Возможность задания в программе опроса (как настройка) места дислокации
 * выгружаемого файла.
 *    Выгружаемый файл формировать автоматический с именем
 * (например: - AGATGGMM.dbf, где GG-2 последние цифры года, ММ - месяц на
 * 1 число которого выгружаются данные.
 *
 *    Код типа счетчика подхватывать из нашего справочника счетчиков SPRSCHET.dbf,
 * а при отсутствии номера счетчика в нем,  выбрать тип из справочника типов
 * счетчиков - SPRTPSC.dbf. Или предоставить возможность вводить по Ctrl+C  - Ctrl+V.
 ******************************************************************************}

unit knsl3ExportMogModule;

interface
uses
    Windows, SysUtils, Forms, ShellAPI, Classes,
    knsl5tracer,inifiles,knsl3EventBox,
    utltypes, utlbox, utlconst, utldatabase, utltimedate, db, dbtables,paramchklist,stdctrls,comctrls,knsl2qwerytmr;

type
  CL3ExportMogModule = class(CTimeMDL)
  private
    m_pExportMOGB   : SL3ExportMOGBS;
    m_QTable        : TTable;
    m_pGenSett      : PSGENSETTTAG;
    m_sTblL1        : SL1INITITAG;
    m_dtLast        : TDateTime; // последний опрос
    m_nAbonentsCount: Integer;
    m_pAbonents     : array of SABON;     // структура дял хранения системы
    m_boIsMaked     : Boolean;
    m_pAbonTable    : SL3ABONSNAMES;
    clm_strAbons    : TParamCheckList;
    em_strPath      : TEdit;
    em_strPath1     : TEdit;
    clm_swDayMask   : TParamCheckList;
    clm_sdwMonthMask: TParamCheckList;
    dtm_sdtBegin    : TDateTimePicker;
    dtm_sdtEnd      : TDateTimePicker;
    dtm_sdtPeriod   : TDateTimePicker;
    chm_swDayMask   : TCheckBox;
    chm_sdwMonthMask: TCheckBox;
    chm_sbyEnable   : TCheckBox;
    cbm_snDeepFind  : TComboBox;
    cbm_nUnlPower   : TCheckBox;
    cbm_nMaxUtro    : TCheckBox;
    cbm_nMaxVech    : TCheckBox;
    cbm_nMaxDay     : TCheckBox;
    cbm_nMaxNoch    : TCheckBox;
    cbm_nMaxTar     : TCheckBox;
    cbm_nExpTret    : TCheckBox;

    m_strAbons      : String;
    m_strPath       : String;
    m_strPath1      : String;

    m_nUnlPower     : Byte;
    m_nMaxUtro      : Byte;
    m_nMaxVech      : Byte;
    m_nMaxDay       : Byte;
    m_nMaxNoch      : Byte;
    m_nMaxTar       : Byte;
    m_nExpTret      : Byte;
    m_nDescDB       : Integer;
    m_nDT           : CDTRouting;
    FDB             : PCDBDynamicConn;
    m_pTTbl         : SL3ExportDBF;
    m_strLockFP     : String;
    procedure OnExpired; override;
    procedure SetToScreen(pTbl:SQWERYMDL);
    function  GetToScreen:SQWERYMDL;
    procedure LoadDayChBox(dwDayWMask:Dword);
    procedure LoadMonthChBox(dwDayMask:Dword);
    function  GetWDayMask:Word;
    function  GetMDayMask:DWord;
    function  LoadSettings:SQWERYMDL;
    function  LoadDrvName:String;
    procedure SaveSettings(pTbl:SQWERYMDL);
    function GetLastDate:TDateTime;
    procedure SetLastDate(dtDate:TDateTime);
    function  LoadAbonsCheckList:String;
    function  GetAbonCluster:String;
    procedure SetAbonCluster(strCluster:String);
    function  GetAID(strAID:String):Integer;
    function  GetSAID(nAID:Integer):String;
    function  FindAID(nAID:Integer;strAID:String):Boolean;
    function  GetMaxPower(var pTbl:SL3ExportDBF):Double;
    function  FillTretTag(dtDate:TDateTime;nVMID:Integer;var pTbl:SL3ExportDBF):Integer;
    procedure SaveData(FDat:Integer;var pTbl:SL3ExportMOGB);
  public
    constructor Create(pTable:PSGENSETTTAG);
    destructor Destroy(); override;

    procedure OnHandler;
    function  EventHandler(var pMsg : CMessage):Boolean;
    function  SelfHandler(var pMsg:CMessage):Boolean;
    function  LoHandler(var pMsg:CMessage):Boolean;
    function  HiHandler(var pMsg:CMessage):Boolean;

    procedure RunExport();
    procedure OnExportOn();
    procedure OnExportOff();
    procedure OnExportInit();
    procedure OnExport();
    procedure OnAbonClear;


    function  GetRealPort(nPort:Integer):Integer;
    procedure Init(pTable:PSGENSETTTAG);
    procedure Prepare;
    procedure Start;
    procedure Finish;
    function  ExportData(ds, de : TDateTime) : Boolean;

    procedure InitTree();
    function CreateTable(_TableName : String):Integer;
    procedure OnLoadParam;
    procedure OnSaveParam;
    procedure OnHandExport;
    procedure OnHandExportPerid(ds, de : TDateTime);
    procedure cbm_nUnlPowerClick(Sender: TObject);

    property Pem_strPath:TEdit read em_strPath write em_strPath;
    property Pem_strPath1:TEdit read em_strPath1 write em_strPath1;
    property Pclm_strAbons:TParamCheckList read clm_strAbons write clm_strAbons;


    property Pcbm_nUnlPower:TCheckBox read cbm_nUnlPower write cbm_nUnlPower;
    property Pcbm_nMaxUtro:TCheckBox read cbm_nMaxUtro write cbm_nMaxUtro;
    property Pcbm_nMaxVech:TCheckBox read cbm_nMaxVech write cbm_nMaxVech;
    property Pcbm_nMaxDay:TCheckBox read cbm_nMaxDay write cbm_nMaxDay;
    property Pcbm_nMaxNoch:TCheckBox read cbm_nMaxNoch write cbm_nMaxNoch;
    property Pcbm_nMaxTar:TCheckBox read cbm_nMaxTar write cbm_nMaxTar;
    property Pcbm_nExpTret:TCheckBox read cbm_nExpTret write cbm_nExpTret;

    property Pclm_swDayMask:TParamCheckList read clm_swDayMask write clm_swDayMask;
    property Pclm_sdwMonthMask:TParamCheckList read clm_sdwMonthMask write clm_sdwMonthMask;
    property Pchm_swDayMask:TCheckBox read chm_swDayMask write chm_swDayMask;
    property Pchm_sdwMonthMask:TCheckBox read chm_sdwMonthMask write chm_sdwMonthMask;
    property Pchm_sbyEnable:TCheckBox read chm_sbyEnable write chm_sbyEnable;
    property Pdtm_sdtBegin:TDateTimePicker read dtm_sdtBegin write dtm_sdtBegin;
    property Pdtm_sdtEnd:TDateTimePicker read dtm_sdtEnd write dtm_sdtEnd;
    property Pdtm_sdtPeriod:TDateTimePicker read dtm_sdtPeriod write dtm_sdtPeriod;
    property Pcbm_snDeepFind:TComboBox read cbm_snDeepFind write cbm_snDeepFind;
end;
type
  TConvertChars = array [#128..#255] of char;

const
  Win_KoiChars: TConvertChars = (
  #128,#129,#130,#131,#132,#133,#134,#135,#136,#137,#060,#139,#140,#141,#142,#143,
  #144,#145,#146,#147,#148,#169,#150,#151,#152,#153,#154,#062,#176,#157,#183,#159,
  #160,#246,#247,#074,#164,#231,#166,#167,#179,#169,#180,#060,#172,#173,#174,#183,
  #156,#177,#073,#105,#199,#181,#182,#158,#163,#191,#164,#062,#106,#189,#190,#167,
  #225,#226,#247,#231,#228,#229,#246,#250,#233,#234,#235,#236,#237,#238,#239,#240,
  #242,#243,#244,#245,#230,#232,#227,#254,#251,#253,#154,#249,#248,#252,#224,#241,
  #193,#194,#215,#199,#196,#197,#214,#218,#201,#202,#203,#204,#205,#206,#207,#208,
  #210,#211,#212,#213,#198,#200,#195,#222,#219,#221,#223,#217,#216,#220,#192,#209);

  Koi_WinChars: TConvertChars = (
  #128,#129,#130,#131,#132,#133,#134,#135,#136,#137,#138,#139,#140,#141,#142,#143,
  #144,#145,#146,#147,#148,#149,#150,#151,#152,#153,#218,#155,#176,#157,#183,#159,
  #160,#161,#162,#184,#186,#165,#166,#191,#168,#169,#170,#171,#172,#173,#174,#175,
  #156,#177,#178,#168,#170,#181,#182,#175,#184,#185,#186,#187,#188,#189,#190,#185,
  #254,#224,#225,#246,#228,#229,#244,#227,#245,#232,#233,#234,#235,#236,#237,#238,
  #239,#255,#240,#241,#242,#243,#230,#226,#252,#251,#231,#248,#253,#249,#247,#250,
  #222,#192,#193,#214,#196,#197,#212,#195,#213,#200,#201,#202,#203,#204,#205,#206,
  #207,#223,#208,#209,#210,#211,#198,#194,#220,#219,#199,#216,#221,#217,#215,#218);

implementation
procedure CL3ExportMogModule.OnHandler;
Begin

End;
function  CL3ExportMogModule.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := false;
end;
function  CL3ExportMogModule.LoHandler(var pMsg:CMessage):Boolean;
begin
    Result := false;
end;
function  CL3ExportMogModule.HiHandler(var pMsg:CMessage):Boolean;
begin
    Result := false;
end;
function  CL3ExportMogModule.EventHandler(var pMsg : CMessage):Boolean;
begin
    case pMsg.m_sbyType of
         DL_EXPORTDBF_START :
         begin
            OnExport();
            Result := true;
            exit;
         end;
    end;
    Result := false;
end;
{
Var
    pTbl : SQWERYMDL;
Begin
    //SaveSettings(GetToScreen);
    pTbl := LoadSettings;
}
constructor CL3ExportMogModule.Create(pTable:PSGENSETTTAG);
var
    strConnect,strDName : string;
    pTbl : SQWERYMDL;
begin
    try
    m_pGenSett := pTable;
    //m_QTable := TTable.Create(nil);
    pTbl := LoadSettings;
    if (m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=4) then
    Begin
     m_nDT := CDTRouting.Create;
     FDB := m_pDB.CreateConnectEx(m_nDescDB);
     //strDName := LoadDrvName;
     //strConnect := 'Provider=MSDASQL.1;Persist Security Info=False;Data Source='+strDName+';Initial Catalog='+GetCurrentDir+'\Archive;Collate=Russian;';
     //if (pTbl.m_sbyEnable=1) then m_pDB.ConnectDBF(strConnect);
    End;
    except
    
    end;
end;
procedure CL3ExportMogModule.Init(pTable:PSGENSETTTAG);
begin
    m_pGenSett := pTable;
    LoadAbonsCheckList;
    OnExportInit;
    SetToScreen(LoadSettings);
end;
procedure CL3ExportMogModule.Prepare;
Begin
    if (m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=4) then
    OnLoadParam;
End;
procedure CL3ExportMogModule.OnExportInit;
Var
    pTbl : SQWERYMDL;
Begin
    //SaveSettings(GetToScreen);
    pTbl := LoadSettings;
    inherited Init(pTbl);
End;
function CL3ExportMogModule.LoadSettings:SQWERYMDL;
Var
    strPath : String;
    Fl      : TINIFile;
    pTbl    : SQWERYMDL;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     m_strPath      := Fl.ReadString('UNLOAD_MOG','m_strPath','');
     m_strPath1     := Fl.ReadString('UNLOAD_MOG','m_strPath1','');
     m_strAbons     := Fl.ReadString('UNLOAD_MOG','m_strAbons','');
     m_sdtBegin     := StrToTime(Fl.ReadString('UNLOAD_MOG','m_sdtBegin',TimeToStr(Now)));
     m_sdtEnd       := StrToTime(Fl.ReadString('UNLOAD_MOG','m_sdtEnd',TimeToStr(Now)));
     m_sdtPeriod    := StrToTime(Fl.ReadString('UNLOAD_MOG','m_sdtPeriod',TimeToStr(Now)));
     m_dtLast       := StrToDate(Fl.ReadString('UNLOAD_MOG','m_dtLast',DateToStr(GetLastDate)));
     m_swDayMask    :=Fl.ReadInteger('UNLOAD_MOG','m_swDayMask',0);
     m_sdwMonthMask :=Fl.ReadInteger('UNLOAD_MOG','m_sdwMonthMask',0);
     m_sbyEnable    :=Fl.ReadInteger('UNLOAD_MOG','m_sbyEnable',0);
     m_snDeepFind   :=Fl.ReadInteger('UNLOAD_MOG','m_snDeepFind',0);
     //m_nUnlPower    :=Fl.ReadInteger('UNLOAD_MOG','m_nUnlPower',0);
     //m_nMaxUtro     :=Fl.ReadInteger('UNLOAD_MOG','m_nMaxUtro',0);
     //m_nMaxVech     :=Fl.ReadInteger('UNLOAD_MOG','m_nMaxVech',0);
     //m_nMaxDay      :=Fl.ReadInteger('UNLOAD_MOG','m_nMaxDay',0);
     //m_nMaxNoch     :=Fl.ReadInteger('UNLOAD_MOG','m_nMaxNoch',0);
     //m_nMaxTar      :=Fl.ReadInteger('UNLOAD_MOG','m_nMaxTar',0);
     //m_nExpTret     :=Fl.ReadInteger('UNLOAD_MOG','m_nExpTret',0);
    end;
    Fl.Destroy;
    except
    end;
    Result := pTbl;
End;
function CL3ExportMogModule.LoadDrvName:String;
Var
    strPath : String;
    Fl      : TINIFile;
    pTbl    : SQWERYMDL;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     Result := Fl.ReadString('UNLOAD_MOG','m_strDriverName','dBASE Files');
    end;
    Fl.Destroy;
    except
     Result := 'dBASE Files';
    end;
End;
procedure CL3ExportMogModule.SaveSettings(pTbl:SQWERYMDL);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     Fl.WriteString('UNLOAD_MOG','m_strPath',m_strPath);
     Fl.WriteString('UNLOAD_MOG','m_strPath1',m_strPath1);
     Fl.WriteString('UNLOAD_MOG','m_strAbons',m_strAbons);
     Fl.WriteString('UNLOAD_MOG','m_sdtBegin',TimeToStr(m_sdtBegin));
     Fl.WriteString('UNLOAD_MOG','m_sdtEnd',TimeToStr(m_sdtEnd));
     Fl.WriteString('UNLOAD_MOG','m_sdtPeriod',TimeToStr(m_sdtPeriod));
     Fl.WriteString('UNLOAD_MOG','m_dtLast',DateToStr(GetLastDate));
     Fl.WriteInteger('UNLOAD_MOG','m_swDayMask',m_swDayMask);
     Fl.WriteInteger('UNLOAD_MOG','m_sdwMonthMask',m_sdwMonthMask);
     Fl.WriteInteger('UNLOAD_MOG','m_sbyEnable',m_sbyEnable);
     Fl.WriteInteger('UNLOAD_MOG','m_snDeepFind',m_snDeepFind);

     //Fl.WriteInteger('UNLOAD_MOG','m_nUnlPower',m_nUnlPower);
     //Fl.WriteInteger('UNLOAD_MOG','m_nMaxUtro',m_nMaxUtro);
     //Fl.WriteInteger('UNLOAD_MOG','m_nMaxVech',m_nMaxVech);
     //Fl.WriteInteger('UNLOAD_MOG','m_nMaxDay',m_nMaxDay);
     //Fl.WriteInteger('UNLOAD_MOG','m_nMaxNoch',m_nMaxNoch);
     //Fl.WriteInteger('UNLOAD_MOG','m_nMaxTar',m_nMaxTar);
     //Fl.WriteInteger('UNLOAD_MOG','m_nExpTret',m_nExpTret);
    end;
    Fl.Destroy;
    except
    end;
End;
procedure CL3ExportMogModule.SetToScreen(pTbl:SQWERYMDL);
Begin
    with pTbl do
    Begin
     em_strPath.Text          := m_strPath;
     em_strPath1.Text         := m_strPath1;
     dtm_sdtBegin.DateTime    := m_sdtBegin;
     dtm_sdtEnd.DateTime      := m_sdtEnd;
     dtm_sdtPeriod.DateTime   := m_sdtPeriod;
     LoadDayChBox(m_swDayMask);
     LoadMonthChBox(m_sdwMonthMask);
     SetAbonCluster(m_strAbons);
     cbm_snDeepFind.ItemIndex := m_snDeepFind;
     chm_sbyEnable.Checked    := Boolean(m_sbyEnable);
     //cbm_nUnlPower.Checked    := Boolean(m_nUnlPower);
     //cbm_nMaxUtro.Checked     := Boolean(m_nMaxUtro);
     //cbm_nMaxVech.Checked     := Boolean(m_nMaxVech);
     //cbm_nMaxDay.Checked      := Boolean(m_nMaxDay);
     //cbm_nMaxNoch.Checked     := Boolean(m_nMaxNoch);
     //cbm_nMaxTar.Checked      := Boolean(m_nMaxTar);
     //cbm_nExpTret.Checked     := Boolean(m_nExpTret);
     //cbm_nUnlPowerClick(cbm_nUnlPower);
    End;
End;
function CL3ExportMogModule.GetToScreen:SQWERYMDL;
Var
    pTbl : SQWERYMDL;
Begin
    with pTbl do
    Begin
     m_strPath      := em_strPath.Text;
     m_strPath1     := em_strPath1.Text;
     m_sdtBegin     := dtm_sdtBegin.DateTime;
     m_sdtEnd       := dtm_sdtEnd.DateTime;
     m_sdtPeriod    := dtm_sdtPeriod.DateTime;
     m_swDayMask    := GetWDayMask;
     m_sdwMonthMask := GetMDayMask;
     m_strAbons     := GetAbonCluster;
     m_snDeepFind   := cbm_snDeepFind.ItemIndex;
     m_sbyEnable    := Byte(chm_sbyEnable.Checked);
     //m_nUnlPower    := Byte(cbm_nUnlPower.Checked);
     //m_nMaxUtro     := Byte(cbm_nMaxUtro.Checked);
     //m_nMaxVech     := Byte(cbm_nMaxVech.Checked);
     //m_nMaxDay      := Byte(cbm_nMaxDay.Checked);
     //m_nMaxNoch     := Byte(cbm_nMaxNoch.Checked);
     //m_nMaxTar      := Byte(cbm_nMaxTar.Checked);
     //m_nExpTret     := Byte(cbm_nExpTret.Checked);
    End;
    Result := pTbl;
End;
procedure CL3ExportMogModule.cbm_nUnlPowerClick(Sender: TObject);
begin
    if (Sender as TCheckBox).Checked=True then
    Begin
     cbm_nMaxUtro.Enabled := True;
     cbm_nMaxVech.Enabled := True;
     cbm_nMaxDay.Enabled  := True;
     cbm_nMaxNoch.Enabled := True;
     cbm_nMaxTar.Enabled  := True;
    End else
    Begin
     cbm_nMaxUtro.Enabled := False;
     cbm_nMaxVech.Enabled := False;
     cbm_nMaxDay.Enabled  := False;
     cbm_nMaxNoch.Enabled := False;
     cbm_nMaxTar.Enabled  := False;
    End;
end;
procedure CL3ExportMogModule.LoadDayChBox(dwDayWMask:Dword);
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
procedure CL3ExportMogModule.LoadMonthChBox(dwDayMask:Dword);
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
function CL3ExportMogModule.GetWDayMask:Word;
var
    i     : integer;
    wMask : Word;
Begin
    wMask := Byte(chm_swDayMask.Checked=True);
    for i := 0 to 6 do
    wMask := wMask or ((Byte(clm_swDayMask.Checked[i]=True)) shl (i+1));
    Result := wMask;
End;
function CL3ExportMogModule.GetMDayMask:DWord;
var
    i      : integer;
    dwMask : DWord;
Begin
    dwMask := Byte(chm_sdwMonthMask.Checked=True);
    for i := 0 to 30 do
    dwMask := dwMask or ((Byte(clm_sdwMonthMask.Checked[i]=True)) shl (i+1));
    Result := dwMask;
End;
procedure CL3ExportMogModule.Start();
begin
    m_nTbl.m_sbyEnable := 1;
end;
destructor CL3ExportMogModule.Destroy();
begin
    if m_QTable <> nil then FreeAndNil(m_QTable);
    m_pDB.DynDisconnectEx(m_nDescDB);
    inherited;
end;
procedure CL3ExportMogModule.Finish;
begin
    m_nTbl.m_sbyEnable := 0;
end;
procedure CL3ExportMogModule.OnExpired;
Begin
    SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTDBF_START);
End;
procedure CL3ExportMogModule.RunExport;
begin
    Run;
end;
function CL3ExportMogModule.GetLastDate:TDateTime;
Var
    dtBegin,dtEnd  : TDateTime;
    year,month,day : Word;
Begin
    dtBegin:= Now;
    dtEnd  := Now;
    if m_nTbl.m_snDeepFind=0 then
    Begin
     DecodeDate(dtEnd,year,month,day);
     dtEnd := EncodeDate(year,month,1);
    End else
    if (m_nTbl.m_snDeepFind<>0)and(m_nTbl.m_snDeepFind<>255) then dtEnd := dtEnd - DeltaFHF[m_nTbl.m_snDeepFind];
    Result := dtEnd;
End;
procedure CL3ExportMogModule.SetLastDate(dtDate:TDateTime);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    Fl.WriteString('UNLOAD_MOG','m_dtLast',DateToStr(dtDate));
    Fl.Destroy;
    except
    end;
End;
procedure CL3ExportMogModule.OnExport;
Begin
    InitTree;
    ExportData(m_dtLast,Now);
    SetLastDate(Now);
end;
procedure CL3ExportMogModule.OnSaveParam;
Begin
    SaveSettings(GetToScreen);
End;
procedure CL3ExportMogModule.OnLoadParam;
Begin
    LoadAbonsCheckList;
    SetToScreen(LoadSettings);
End;
procedure CL3ExportMogModule.OnHandExport;
Begin
    InitTree;
    ExportData(GetLastDate,Now);
End;
procedure CL3ExportMogModule.OnHandExportPerid(ds, de : TDateTime);
Begin
    InitTree;
    ExportData(de,ds);
End;
procedure CL3ExportMogModule.OnExportOn;
begin
    EventBox.FixEvents(ET_RELEASE,'Разрешить Экспорт в DBF.');
    m_nTbl.m_sbyEnable := 1;

end;
procedure CL3ExportMogModule.OnExportOff;
begin
    EventBox.FixEvents(ET_NORMAL,'Запретить Экспорт в DBF.');
    m_nTbl.m_sbyEnable := 0;
end;
procedure CL3ExportMogModule.OnAbonClear;
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
     Fl := TINIFile.Create(strPath);
     Fl.WriteString('UNLOAD_MOG','m_strAbons','');
     Fl.Destroy;
     except
    end;
    LoadAbonsCheckList;
End;
function CL3ExportMogModule.LoadAbonsCheckList:String;
var
    i : integer;
    strCluster : String;
begin
    strCluster := '';
    m_pDB.GetAbonsNamesTable(m_pAbonTable);
    clm_strAbons.Clear;
    for i := 0 to m_pAbonTable.Count - 1 do
    Begin
     clm_strAbons.Items.Add(m_pAbonTable.Items[i].m_sName);
     clm_strAbons.Checked[i] := False;
    End;
    Result := strCluster;
end;
function CL3ExportMogModule.GetAbonCluster:String;
Var
    i,nAID,sID : Integer;
    strCluster : String;
Begin
    strCluster := '';
    for i:=0 to clm_strAbons.Items.Count-1 do
    Begin
     nAID := GetAID(clm_strAbons.Items[i]);
     if clm_strAbons.Checked[i]=True then 
     strCluster := strCluster + IntToStr(nAID) + ',';
    End;
    Result := strCluster;
End;
function CL3ExportMogModule.GetAID(strAID:String):Integer;
Var
    i : Integer;
Begin
    Result := 0;
    for i := 0 to m_pAbonTable.Count - 1 do
    Begin
     if strAID=m_pAbonTable.Items[i].m_sName then
     Begin
      Result := m_pAbonTable.Items[i].m_swABOID;
      exit;
     End;
    End;
End;
function CL3ExportMogModule.GetSAID(nAID:Integer):String;
Var
    i : Integer;
Begin
    Result := '';
    for i := 0 to m_pAbonTable.Count - 1 do
    Begin
     if nAID=m_pAbonTable.Items[i].m_swABOID then
     Begin
      Result := m_pAbonTable.Items[i].m_sName;
      exit;
     End;
    End;
End;
procedure CL3ExportMogModule.SetAbonCluster(strCluster:String);
Var
    i : Integer;
Begin
    for i := 0 to m_pAbonTable.Count - 1 do
    Begin
     if FindAID(m_pAbonTable.Items[i].m_swABOID,strCluster)=True then
     clm_strAbons.Checked[i] := True else
     clm_strAbons.Checked[i] := False;
    End;
End;
function CL3ExportMogModule.FindAID(nAID:Integer;strAID:String):Boolean;
Var
    i,nCode : Integer;
    str : String;
Begin
    Result := False;
    str := strAID;
    while GetCode(nCode,str)<>False do
    Begin
     if nCode=nAID then
     Begin
      Result := True;
      exit;
     End;
    End;
End;
procedure CL3ExportMogModule.InitTree;
begin
    //FDB.GetAbonsTableNSDBF('KONU','145335',m_strAbons,m_pExportMOGB);
end;
function CL3ExportMogModule.ExportData(ds, de : TDateTime) : Boolean;
var
    FDat,i, ni,nAID : Integer;
    l_Ys, l_Ms, l_Ds,
    l_Ye, l_Me, l_De : WORD;
    seTable  : L3ARCHDATAMY;
    str,strFileName : String;
    m_pGrData : L3GRAPHDATAS;
    pTable:TM_TARIFFS;
    KE : Double;
begin
    DecodeDate(ds, l_Ys, l_Ms, l_Ds); l_Ds := 1;
    ds := EncodeDate(l_Ys, l_Ms, l_Ds);
    DecodeDate(de, l_Ye, l_Me, l_De); l_De := 1;
    de := EncodeDate(l_Ye, l_Me, l_De);
try
    while(cDateTimeR.CompareMonth(ds, de) <> 1) do
    begin
      strFileName := FormatDateTime('yymmdd', de)+'.obh';
      FDat := CreateTable(strFileName);
      if (FDat=-1) then
      Begin
       EventBox.FixEvents(ET_RELEASE,'Ошибка экспорта! Абонент:'+GetSAID(nAID));
       exit;
      End;
      str := m_strAbons;
      while GetCode(nAID,str)<>False do
      Begin
       if m_strPath<>''then EventBox.FixEvents(ET_RELEASE,'Экспорт в '+m_strPath+'\'+strFileName+'.DBF. за '+DateToStr(de)+'. Абонент:'+GetSAID(nAID));
       if m_strPath1<>''then EventBox.FixEvents(ET_RELEASE,'Экспорт в '+m_strPath1+'\'+strFileName+'.DBF. за '+DateToStr(de)+'. Абонент:'+GetSAID(nAID));
       FDB.GetMogBitData(nAID,de,m_pExportMOGB);
       for i:=0 to m_pExportMOGB.Count-1 do
       SaveData(FDat,m_pExportMOGB.Items[i]);
      end;
      cDateTimeR.DecMonth(de);
      FileClose(FDat);
      if m_strPath<>'' then CopyFile(m_strLockFP,m_strPath+'\'+strFileName);
      if m_strPath1<>'' then CopyFile(m_strLockFP,m_strPath1+'\'+strFileName);
    end;
    except
    end;
end;
function CL3ExportMogModule.FillTretTag(dtDate:TDateTime;nVMID:Integer;var pTbl:SL3ExportDBF):Integer;
Begin
    Result := 0;
    m_nDT.DecMonth(dtDate);
    with pTbl do
    Begin
     NOM_SC := NOM_SC+':(ПОТЕРИ)';
     POKP_ALL := -1;POKP_1:=-1;POKP_2:=-1;POKP_3:=-1;POKP_4:=-1;POKP_5:=-1;POKP_6:=-1;POKP_7:=-1;POKP_8:=-1;
     POKO_ALL := -1;POKO_1:=-1;POKO_2:=-1;POKO_3:=-1;POKO_4:=-1;POKO_5:=-1;POKO_6:=-1;POKO_7:=-1;POKO_8:=-1;
     MU       := -1;MV    :=-1;MD    :=-1;MN    := -1;
     POKP_ALL := RVLPr(FDB.CalcTRET(dtDate,nVMID, QRY_SRES_ENR_EP,0),3); if POKP_ALL=-1 then Begin Result:=-1;exit;End;
     POKP_1   := RVLPr(FDB.CalcTRET(dtDate,nVMID, QRY_SRES_ENR_EP,1),3); if POKP_1  =-1 then Begin Result:=-1;exit;End;
     POKP_2   := RVLPr(FDB.CalcTRET(dtDate,nVMID, QRY_SRES_ENR_EP,2),3); if POKP_2  =-1 then Begin Result:=-1;exit;End;
     POKP_3   := RVLPr(FDB.CalcTRET(dtDate,nVMID, QRY_SRES_ENR_EP,3),3); if POKP_3  =-1 then Begin Result:=-1;exit;End;
     POKP_4   := RVLPr(FDB.CalcTRET(dtDate,nVMID, QRY_SRES_ENR_EP,4),3); if POKP_4  =-1 then Begin Result:=-1;exit;End;
    End;
    with m_pTTbl do
    Begin
     POKP_ALL := POKP_ALL + pTbl.POKP_ALL;
     POKP_1   := POKP_1   + pTbl.POKP_1;
     POKP_2   := POKP_2   + pTbl.POKP_2;
     POKP_3   := POKP_3   + pTbl.POKP_3;
     POKP_4   := POKP_4   + pTbl.POKP_4;
    End;
End;
function CL3ExportMogModule.GetMaxPower(var pTbl:SL3ExportDBF):Double;
Var
    dbValues: array[0..3] of Double;
    dbVal : Double;
    i,j   : Integer;
Begin
    dbVal := -1;j:=0;
    Move(pTbl.MU,dbValues[0],4*sizeof(Double));
     for i:=0 to 3 do
     if dbValues[i]>dbVal then
     Begin dbVal := dbValues[i];j:=i;End;
     for i:=0 to 3 do if i<>j then dbValues[i]:=-1;
    Move(dbValues[0],pTbl.MU,4*sizeof(Double));
    Result := dbVal;
End;
function CL3ExportMogModule.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
    for i:=0 to m_sTblL1.Count-1 do
    Begin
     with m_sTblL1.Items[i] do
     Begin
      if m_sbyPortID=nPort then
      Begin
       Result := m_sbyPortID;
       if m_sblReaddres=1 then Result := m_swAddres;
       exit;
      End;
     End;
    End;
End;
{
SL3ExportMOGB = packed record
     m_nABOID    : Integer;
     m_swVMID    : Integer;
     m_nCMDID    : Integer;
     m_dtDate    : TDateTime;
     m_byREGID   : Byte;
     m_wDEPID    : Word;
     m_strLicNb  : String;
     m_nGorSel   : String;
     m_nRES      : Byte;
     m_nCS       : Byte;
     m_strLicNbAbo : String;
     m_strKvNb   : String;
     m_strFabNum : String;
     m_strFIO    : String;
     m_strAddr   : String;
     m_dbDataT1  : Double;
     m_dbDataT2  : Double;
     m_dbDataT3  : Double;
     m_dbDataT4  : Double;
   End;
}
procedure CL3ExportMogModule.SaveData(FDat:Integer;var pTbl:SL3ExportMOGB);
Var
    i,sum : Integer;
    str  : String;
    byByff : array[0..50] of Byte;
Begin
    //Дата
    str := FormatDateTime('dd.mm.yyyу', pTbl.m_dtDate);
    str := StringReplace(str,'.','/',[rfReplaceAll]);
    str[length(str)] := ';';
    FileWrite(Fdat,str[1],length(str));
    //Рег №
    sum := 0;
    byByff[0]  := pTbl.m_byREGID;
    move(pTbl.m_wDEPID,byByff[1],sizeof(Word));
    move(pTbl.m_strLicNb[1],byByff[3],7);
    //byByff[10] := StrToInt(pTbl.m_nGorSel);
    byByff[10] := 0;
    byByff[11] := pTbl.m_nRES;
    for i:=0 to 11 do sum := sum + byByff[i];
    byByff[12] := Byte(sum mod 9);
    byByff[13] := Byte(';');
    FileWrite(Fdat,byByff,14);
    //Лиц счет
    //pTbl.m_strLicNbAbo := '#12345';
    str := pTbl.m_strLicNbAbo + ';';
    FileWrite(Fdat,str[1],length(str));
    //Эав №
    //pTbl.m_strFabNum := '#654321';
    str := pTbl.m_strFabNum + ';';
    FileWrite(Fdat,str[1],length(str));
    //ФИО
    //pTbl.m_strFIO := 'Петров Петр Петрович';
    str := pTbl.m_strFIO + ';';
    FileWrite(Fdat,str[1],length(str));
    //Адр
    //pTbl.m_strAddr := 'г.Минск';
    str := pTbl.m_strAddr + ';';
    FileWrite(Fdat,str[1],length(str));
    //Т1
    str := FloatToStrF(pTbl.m_dbDataT1,ffFixed,6,3) + ';';
    FileWrite(Fdat,str[1],length(str));
    //Т2
    str := FloatToStrF(pTbl.m_dbDataT2,ffFixed,6,3) + ';';
    FileWrite(Fdat,str[1],length(str));
    //Т3
    str := FloatToStrF(pTbl.m_dbDataT3,ffFixed,6,3) + ';';
    FileWrite(Fdat,str[1],length(str));
    //Т4
    str := FloatToStrF(pTbl.m_dbDataT4,ffFixed,6,3) + ';';
    FileWrite(Fdat,str[1],length(str));
    //Конец
    byByff[0] := 13;
    byByff[1] := 10;
    FileWrite(Fdat,byByff,2);
End;
function CL3ExportMogModule.CreateTable(_TableName : String):Integer;
Var
    Fdat    : Integer;
begin
    m_strLockFP := ExtractFilePath(Application.ExeName)+'\Archive\' +_TableName;
    if FileExists(m_strLockFP)=True then
    DeleteFile(m_strLockFP);
    Fdat:=FileCreate(m_strLockFP);
    //FileClose(Fdat);
    //Fdat:=FileOpen(m_strLockFP,FmOpenWrite);
    Result := Fdat;
end;
end.
