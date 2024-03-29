{*******************************************************************************
 *    ������� ������ � ���� ���� dBase
 *      ��� �������� �����������
 *
 *
 *    ������������ ������ �� ���� ����������, ���������� �������� �����,
 * ������ ����� ������������� �������.
 *
 *    ����������� ������� � ��������� ������ (��� ���������) ����� ����������
 * ������������ �����.
 *    ����������� ���� ����������� �������������� � ������
 * (��������: - AGATGGMM.dbf, ��� GG-2 ��������� ����� ����, �� - ����� ��
 * 1 ����� �������� ����������� ������.
 *
 *    ��� ���� �������� ������������ �� ������ ����������� ��������� SPRSCHET.dbf,
 * � ��� ���������� ������ �������� � ���,  ������� ��� �� ����������� �����
 * ��������� - SPRTPSC.dbf. ��� ������������ ����������� ������� �� Ctrl+C  - Ctrl+V.
 ******************************************************************************}

unit knsl3ExportDBFModule;

interface
uses
    Windows, SysUtils, Forms, ShellAPI, Classes,
    knsl5tracer,inifiles,knsl3EventBox,
    utltypes, utlbox, utlconst, utldatabase, utltimedate, db, dbtables,paramchklist,stdctrls,comctrls,knsl2qwerytmr;

type
  CL3Export2DBFModule = class(CTimeMDL)
  private
    m_pExportDBF    : SL3ExportDBFS;
    m_QTable        : TTable;
    m_pGenSett      : PSGENSETTTAG;
    m_sTblL1        : SL1INITITAG;
    m_dtLast        : TDateTime; // ��������� �����
    m_nAbonentsCount: Integer;
    m_pAbonents     : array of SABON;     // ��������� ��� �������� �������
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
    procedure CreateTable(_TableName : String);
    procedure OnLoadParam;
    procedure OnSaveParam;
    procedure OnHandExport;
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
procedure CL3Export2DBFModule.OnHandler;
Begin

End;
function  CL3Export2DBFModule.SelfHandler(var pMsg:CMessage):Boolean;
begin
    Result := false;
end;
function  CL3Export2DBFModule.LoHandler(var pMsg:CMessage):Boolean;
begin
    Result := false;
end;
function  CL3Export2DBFModule.HiHandler(var pMsg:CMessage):Boolean;
begin
    Result := false;
end;
function  CL3Export2DBFModule.EventHandler(var pMsg : CMessage):Boolean;
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
constructor CL3Export2DBFModule.Create(pTable:PSGENSETTTAG);
var
    strConnect,strDName : string;
    pTbl : SQWERYMDL;
begin
    try
    m_pGenSett := pTable;
    m_QTable := TTable.Create(nil);
    pTbl := LoadSettings;
    if (m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=2) then
    Begin
     m_nDT := CDTRouting.Create;
     FDB := m_pDB.CreateConnectEx(m_nDescDB);
     strDName := LoadDrvName;
     strConnect := 'Provider=MSDASQL.1;Persist Security Info=False;Data Source='+strDName+';Initial Catalog='+ExtractFilePath(Application.ExeName)+'\Archive;Collate=Russian;';
     if (pTbl.m_sbyEnable=1) then m_pDB.ConnectDBF(strConnect);
    End;
    except
    
    end;
end;
procedure CL3Export2DBFModule.Init(pTable:PSGENSETTTAG);
begin
    m_pGenSett := pTable;
    LoadAbonsCheckList;
    OnExportInit;
end;
procedure CL3Export2DBFModule.Prepare;
Begin
    if (m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=2) then
    OnLoadParam;
End;
procedure CL3Export2DBFModule.OnExportInit;
Var
    pTbl : SQWERYMDL;
Begin
    //SaveSettings(GetToScreen);
    pTbl := LoadSettings;
    inherited Init(pTbl);
End;
function CL3Export2DBFModule.LoadSettings:SQWERYMDL;
Var
    strPath : String;
    Fl      : TINIFile;
    pTbl    : SQWERYMDL;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     m_strPath      := Fl.ReadString('UNLOAD_DBF','m_strPath','');
     m_strPath1     := Fl.ReadString('UNLOAD_DBF','m_strPath1','');
     m_strAbons     := Fl.ReadString('UNLOAD_DBF','m_strAbons','');
     m_sdtBegin     := StrToTime(Fl.ReadString('UNLOAD_DBF','m_sdtBegin',TimeToStr(Now)));
     m_sdtEnd       := StrToTime(Fl.ReadString('UNLOAD_DBF','m_sdtEnd',TimeToStr(Now)));
     m_sdtPeriod    := StrToTime(Fl.ReadString('UNLOAD_DBF','m_sdtPeriod',TimeToStr(Now)));
     m_dtLast       := StrToDate(Fl.ReadString('UNLOAD_DBF','m_dtLast',DateToStr(GetLastDate)));
     m_swDayMask    :=Fl.ReadInteger('UNLOAD_DBF','m_swDayMask',0);
     m_sdwMonthMask :=Fl.ReadInteger('UNLOAD_DBF','m_sdwMonthMask',0);
     m_sbyEnable    :=Fl.ReadInteger('UNLOAD_DBF','m_sbyEnable',0);
     m_snDeepFind   :=Fl.ReadInteger('UNLOAD_DBF','m_snDeepFind',0);
     m_nUnlPower    :=Fl.ReadInteger('UNLOAD_DBF','m_nUnlPower',0);
     m_nMaxUtro     :=Fl.ReadInteger('UNLOAD_DBF','m_nMaxUtro',0);
     m_nMaxVech     :=Fl.ReadInteger('UNLOAD_DBF','m_nMaxVech',0);
     m_nMaxDay      :=Fl.ReadInteger('UNLOAD_DBF','m_nMaxDay',0);
     m_nMaxNoch     :=Fl.ReadInteger('UNLOAD_DBF','m_nMaxNoch',0);
     m_nMaxTar      :=Fl.ReadInteger('UNLOAD_DBF','m_nMaxTar',0);
     m_nExpTret     :=Fl.ReadInteger('UNLOAD_DBF','m_nExpTret',0);
    end;
    Fl.Destroy;
    except
    end;
    Result := pTbl;
End;
function CL3Export2DBFModule.LoadDrvName:String;
Var
    strPath : String;
    Fl      : TINIFile;
    pTbl    : SQWERYMDL;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     Result := Fl.ReadString('UNLOAD_DBF','m_strDriverName','dBASE Files');
    end;
    Fl.Destroy;
    except
     Result := 'dBASE Files';
    end;
End;
procedure CL3Export2DBFModule.SaveSettings(pTbl:SQWERYMDL);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     Fl.WriteString('UNLOAD_DBF','m_strPath',m_strPath);
     Fl.WriteString('UNLOAD_DBF','m_strPath1',m_strPath1);
     Fl.WriteString('UNLOAD_DBF','m_strAbons',m_strAbons);
     Fl.WriteString('UNLOAD_DBF','m_sdtBegin',TimeToStr(m_sdtBegin));
     Fl.WriteString('UNLOAD_DBF','m_sdtEnd',TimeToStr(m_sdtEnd));
     Fl.WriteString('UNLOAD_DBF','m_sdtPeriod',TimeToStr(m_sdtPeriod));
     Fl.WriteString('UNLOAD_DBF','m_dtLast',DateToStr(GetLastDate));
     Fl.WriteInteger('UNLOAD_DBF','m_swDayMask',m_swDayMask);
     Fl.WriteInteger('UNLOAD_DBF','m_sdwMonthMask',m_sdwMonthMask);
     Fl.WriteInteger('UNLOAD_DBF','m_sbyEnable',m_sbyEnable);
     Fl.WriteInteger('UNLOAD_DBF','m_snDeepFind',m_snDeepFind);

     Fl.WriteInteger('UNLOAD_DBF','m_nUnlPower',m_nUnlPower);
     Fl.WriteInteger('UNLOAD_DBF','m_nMaxUtro',m_nMaxUtro);
     Fl.WriteInteger('UNLOAD_DBF','m_nMaxVech',m_nMaxVech);
     Fl.WriteInteger('UNLOAD_DBF','m_nMaxDay',m_nMaxDay);
     Fl.WriteInteger('UNLOAD_DBF','m_nMaxNoch',m_nMaxNoch);
     Fl.WriteInteger('UNLOAD_DBF','m_nMaxTar',m_nMaxTar);
     Fl.WriteInteger('UNLOAD_DBF','m_nExpTret',m_nExpTret);
    end;
    Fl.Destroy;
    except
    end;
End;
procedure CL3Export2DBFModule.SetToScreen(pTbl:SQWERYMDL);
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
     cbm_nUnlPower.Checked    := Boolean(m_nUnlPower);
     cbm_nMaxUtro.Checked     := Boolean(m_nMaxUtro);
     cbm_nMaxVech.Checked     := Boolean(m_nMaxVech);
     cbm_nMaxDay.Checked      := Boolean(m_nMaxDay);
     cbm_nMaxNoch.Checked     := Boolean(m_nMaxNoch);
     cbm_nMaxTar.Checked      := Boolean(m_nMaxTar);
     cbm_nExpTret.Checked     := Boolean(m_nExpTret);
     cbm_nUnlPowerClick(cbm_nUnlPower);
    End;
End;
function CL3Export2DBFModule.GetToScreen:SQWERYMDL;
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
     m_nUnlPower    := Byte(cbm_nUnlPower.Checked);
     m_nMaxUtro     := Byte(cbm_nMaxUtro.Checked);
     m_nMaxVech     := Byte(cbm_nMaxVech.Checked);
     m_nMaxDay      := Byte(cbm_nMaxDay.Checked);
     m_nMaxNoch     := Byte(cbm_nMaxNoch.Checked);
     m_nMaxTar      := Byte(cbm_nMaxTar.Checked);
     m_nExpTret     := Byte(cbm_nExpTret.Checked);
    End;
    Result := pTbl;
End;
procedure CL3Export2DBFModule.cbm_nUnlPowerClick(Sender: TObject);
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
procedure CL3Export2DBFModule.LoadDayChBox(dwDayWMask:Dword);
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
procedure CL3Export2DBFModule.LoadMonthChBox(dwDayMask:Dword);
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
function CL3Export2DBFModule.GetWDayMask:Word;
var
    i     : integer;
    wMask : Word;
Begin
    wMask := Byte(chm_swDayMask.Checked=True);
    for i := 0 to 6 do
    wMask := wMask or ((Byte(clm_swDayMask.Checked[i]=True)) shl (i+1));
    Result := wMask;
End;
function CL3Export2DBFModule.GetMDayMask:DWord;
var
    i      : integer;
    dwMask : DWord;
Begin
    dwMask := Byte(chm_sdwMonthMask.Checked=True);
    for i := 0 to 30 do
    dwMask := dwMask or ((Byte(clm_sdwMonthMask.Checked[i]=True)) shl (i+1));
    Result := dwMask;
End;
procedure CL3Export2DBFModule.Start();
begin
    m_nTbl.m_sbyEnable := 1;
end;
destructor CL3Export2DBFModule.Destroy();
begin
    if m_QTable <> nil then FreeAndNil(m_QTable);
    m_pDB.DynDisconnectEx(m_nDescDB);
    inherited;
end;
procedure CL3Export2DBFModule.Finish;
begin
    m_nTbl.m_sbyEnable := 0;
end;
procedure CL3Export2DBFModule.OnExpired;
Begin
    SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTDBF_START);
End;
procedure CL3Export2DBFModule.RunExport;
begin
    Run;
end;
function CL3Export2DBFModule.GetLastDate:TDateTime;
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
procedure CL3Export2DBFModule.SetLastDate(dtDate:TDateTime);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    Fl.WriteString('UNLOAD_DBF','m_dtLast',DateToStr(dtDate));
    Fl.Destroy;
    except
    end;
End;
procedure CL3Export2DBFModule.OnExport;
Begin
    InitTree;
    ExportData(m_dtLast,Now);
    SetLastDate(Now);
end;
procedure CL3Export2DBFModule.OnSaveParam;
Begin
    SaveSettings(GetToScreen);
End;
procedure CL3Export2DBFModule.OnLoadParam;
Begin
    LoadAbonsCheckList;
    SetToScreen(LoadSettings);
End;
procedure CL3Export2DBFModule.OnHandExport;
Begin
    InitTree;
    ExportData(GetLastDate,Now);
End;
procedure CL3Export2DBFModule.OnExportOn;
begin
    EventBox.FixEvents(ET_RELEASE,'��������� ������� � DBF.');
    m_nTbl.m_sbyEnable := 1;

end;
procedure CL3Export2DBFModule.OnExportOff;
begin
    EventBox.FixEvents(ET_NORMAL,'��������� ������� � DBF.');
    m_nTbl.m_sbyEnable := 0;
end;
procedure CL3Export2DBFModule.OnAbonClear;
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := ExtractFilePath(Application.ExeName)+'\Settings\UnLoad_Config.ini';
    try
     Fl := TINIFile.Create(strPath);
     Fl.WriteString('UNLOAD_DBF','m_strAbons','');
     Fl.Destroy;
     except
    end;
    LoadAbonsCheckList;
End;
function CL3Export2DBFModule.LoadAbonsCheckList:String;
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
function CL3Export2DBFModule.GetAbonCluster:String;
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
function CL3Export2DBFModule.GetAID(strAID:String):Integer;
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
function CL3Export2DBFModule.GetSAID(nAID:Integer):String;
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
procedure CL3Export2DBFModule.SetAbonCluster(strCluster:String);
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
function CL3Export2DBFModule.FindAID(nAID:Integer;strAID:String):Boolean;
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
procedure CL3Export2DBFModule.InitTree;
begin
    FDB.GetAbonsTableNSDBF('KONU','145335',m_strAbons,m_pExportDBF);
end;
function CL3Export2DBFModule.ExportData(ds, de : TDateTime) : Boolean;
var
    l_IT, ni,nAID : Integer;
    l_Ys, l_Ms, l_Ds,
    l_Ye, l_Me, l_De : WORD;
    seTable  : L3ARCHDATAMY;
    str,strFileName : String;
    m_pGrData : L3GRAPHDATAS;
    pTable:TM_TARIFFS;
    KE : Double;
    //pTbl : SL3ExportDBF;
begin
    DecodeDate(ds, l_Ys, l_Ms, l_Ds); l_Ds := 1;
    ds := EncodeDate(l_Ys, l_Ms, l_Ds);
    DecodeDate(de, l_Ye, l_Me, l_De); l_De := 1;
    de := EncodeDate(l_Ye, l_Me, l_De);
try
    while(cDateTimeR.CompareMonth(ds, de) <> 1) do
    begin
      strFileName := 'KON1' + FormatDateTime('yymm', de);
      CreateTable(strFileName);
      str := m_strAbons;
      while GetCode(nAID,str)<>False do
      Begin
      if m_strPath<>''then EventBox.FixEvents(ET_RELEASE,'������� � '+m_strPath+'\'+strFileName+'.DBF. �� '+DateToStr(de)+'. �������:'+GetSAID(nAID));
      if m_strPath1<>''then EventBox.FixEvents(ET_RELEASE,'������� � '+m_strPath1+'\'+strFileName+'.DBF. �� '+DateToStr(de)+'. �������:'+GetSAID(nAID));
      with m_pTTbl do
      Begin
       //TIP_SC := NUMABON;
       NOM_SC := '����� ������';
       ZAVOD  := '�'+IntToStr(nAID);
       POKP_ALL := 0.0;POKP_1:=0.0;POKP_2:=0.0;POKP_3:=0.0;POKP_4:=0.0;POKP_5:=0.0;POKP_6:=0.0;POKP_7:=0.0;POKP_8:=0.0;
       POKO_ALL := -1; POKO_1:=-1; POKO_2:=-1; POKO_3:=-1; POKO_4:=-1; POKO_5:=-1; POKO_6:=-1; POKO_7:=-1; POKO_8:=-1;
      End;
      for l_IT:=0 to m_pExportDBF.Count-1 do
      begin
         with m_pExportDBF.Items[l_IT] do
         Begin
         if nAID=s_AID then
         begin
            DAT      := de;
            m_pTTbl.DAT     := DAT;
            m_pTTbl.NUMABON := NUMABON;
            m_pTTbl.TIP_SC  := NUMABON;
            //m_pTTbl.TIP_SC  := TIP_SC;
            m_pTTbl.UL      := UL;
            m_pTTbl.DOM     := DOM;
            m_pTTbl.KORP    := KORP;
            m_pTTbl.KV      := KV;

            POKP_ALL := 0.0;POKP_1:=0.0;POKP_2:=0.0;POKP_3:=0.0;POKP_4:=0.0;POKP_5:=0.0;POKP_6:=0.0;POKP_7:=0.0;POKP_8:=0.0;
            POKO_ALL := 0.0;POKO_1:=0.0;POKO_2:=0.0;POKO_3:=0.0;POKO_4:=0.0;POKO_5:=0.0;POKO_6:=0.0;POKO_7:=0.0;POKO_8:=0.0;
            MU       := -1; MV    := -1;MD    := -1;MN    := -1;
            if m_strMType='Raschet' then
            Begin
             TIP_SC := NUMABON;
             NOM_SC := '����.��������';
             ZAVOD  := '�'+IntToStr(s_AID);
             POKP_ALL := -1;POKP_1:=-1;POKP_2:=-1;POKP_3:=-1;POKP_4:=-1;POKP_5:=-1;POKP_6:=-1;POKP_7:=-1;POKP_8:=-1;
             POKO_ALL := -1;POKO_1:=-1;POKO_2:=-1;POKO_3:=-1;POKO_4:=-1;POKO_5:=-1;POKO_6:=-1;POKO_7:=-1;POKO_8:=-1;
            End;
            if s_Type=0 then
            Begin
             KE := KI*KU;if KE=0 then KE:=1;
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 0, QRY_NAK_EN_MONTH_EP, seTable) ) then POKP_ALL := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 0, QRY_NAK_EN_DAY_EP  , seTable) ) then POKP_ALL := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 1, QRY_NAK_EN_MONTH_EP, seTable) ) then POKP_1 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 1, QRY_NAK_EN_DAY_EP  , seTable) ) then POKP_1 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 2, QRY_NAK_EN_MONTH_EP, seTable) ) then POKP_2 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 2, QRY_NAK_EN_DAY_EP  , seTable) ) then POKP_2 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 3, QRY_NAK_EN_MONTH_EP, seTable) ) then POKP_3 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 3, QRY_NAK_EN_DAY_EP  , seTable) ) then POKP_3 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 4, QRY_NAK_EN_MONTH_EP, seTable) ) then POKP_4 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 4, QRY_NAK_EN_DAY_EP  , seTable) ) then POKP_4 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 0, QRY_NAK_EN_MONTH_EM, seTable) ) then POKO_ALL := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 0, QRY_NAK_EN_DAY_EP  , seTable) ) then POKO_ALL := RVLPr(seTable.m_sfValue/KE,3);

             if (true = m_pDB.GetAtomArchDataDBFExport(de, s_VMID, 1, QRY_NAK_EN_MONTH_EM, seTable) ) then POKO_1 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = m_pDB.GetAtomArchDataDBFExport(de, s_VMID, 1, QRY_NAK_EN_DAY_EP  , seTable) ) then POKO_1 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 2, QRY_NAK_EN_MONTH_EM, seTable) ) then POKO_2 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 2, QRY_NAK_EN_DAY_EP  , seTable) ) then POKO_2 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 3, QRY_NAK_EN_MONTH_EM, seTable) ) then POKO_3 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 3, QRY_NAK_EN_DAY_EP  , seTable) ) then POKO_3 := RVLPr(seTable.m_sfValue/KE,3);

             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 4, QRY_NAK_EN_MONTH_EM, seTable) ) then POKO_4 := RVLPr(seTable.m_sfValue/KE,3) else
             if (true = FDB.GetAtomArchDataDBFExport(de, s_VMID, 4, QRY_NAK_EN_DAY_EP  , seTable) ) then POKO_4 := RVLPr(seTable.m_sfValue/KE,3);
            End;

            if m_nUnlPower=1 then
            //if (m_strMType='Raschet')and(m_pDB.GetGraphDatas(de,cDateTimeR.DecMonth1(de),s_VMID,QRY_SRES_ENR_EP, m_pGrData)) then
            if (FDB.GetGraphDatas(de,cDateTimeR.DecMonth1(de),s_VMID,QRY_SRES_ENR_EP, m_pGrData)) then
            Begin
              FDB.GetTMTarPeriodsCmdTable(Now,s_VMID,QRY_SRES_ENR_EP,4,pTable);
              if m_nMaxUtro=1 then MU := RVLPr(GetMaxTZone(GetTAllMask(3,pTable),m_pGrData)*2,3);
              if m_nMaxVech=1 then MV := RVLPr(GetMaxTZone(GetTAllMask(4,pTable),m_pGrData)*2,3);
              if m_nMaxDay =1 then MD := RVLPr(GetMaxTZone(GetTAllMask(2,pTable),m_pGrData)*2,3);
              if m_nMaxNoch=1 then MN := RVLPr(GetMaxTZone(GetTAllMask(1,pTable),m_pGrData)*2,3);
              if m_nMaxTar=1  then GetMaxPower(m_pExportDBF.Items[l_IT]);
            End;

            if (s_Type=0)or(m_strMType='Raschet') then
             m_pDB.InsertUPDBF(strFileName,m_pExportDBF.Items[l_IT]);

            if (m_nExpTret=1) then
            if(FillTretTag(de,s_VMID,m_pExportDBF.Items[l_IT])<>-1) then
            m_pDB.InsertUPDBF(strFileName,m_pExportDBF.Items[l_IT]);

         End;
         End;
      End;
      if (m_nExpTret=1)and(m_pTTbl.POKP_ALL<>0) then m_pDB.InsertUPDBF(strFileName,m_pTTbl);
      end;
      cDateTimeR.DecMonth(de);
      if m_strPath<>'' then CopyFile(ExtractFilePath(Application.ExeName)+'\Archive\'+strFileName+'.dbf',m_strPath+'\'+strFileName+'.dbf');
      if m_strPath1<>'' then CopyFile(ExtractFilePath(Application.ExeName)+'\Archive\'+strFileName+'.dbf',m_strPath1+'\'+strFileName+'.dbf');
    end;
    except

    end;
end;
function CL3Export2DBFModule.FillTretTag(dtDate:TDateTime;nVMID:Integer;var pTbl:SL3ExportDBF):Integer;
Begin
    Result := 0;
    m_nDT.DecMonth(dtDate);
    with pTbl do
    Begin
     NOM_SC := NOM_SC+':(������)';
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
function CL3Export2DBFModule.GetMaxPower(var pTbl:SL3ExportDBF):Double;
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
function CL3Export2DBFModule.GetRealPort(nPort:Integer):Integer;
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
procedure  CL3Export2DBFModule.CreateTable(_TableName : String);
Var
    strPath : String;
begin
    strPath := ExtractFilePath(Application.ExeName)+'\Archive\'+_TableName+'.dbf';
    if FileExists(strPath)=True then
    m_pDB.DeleteUPDBF(_TableName);
    m_pDB.CreateUPDBF(_TableName);
end;
end.
