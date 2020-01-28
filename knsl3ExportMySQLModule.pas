{
    Экспорт данных в базу MySQL для Гомельского энергосбыта
    Петрушевич
}
//{$DEFINE MYSQL_UNLOAD_DEBUG}
unit knsl3ExportMySQLModule;


interface
uses
    Windows,SysUtils, utltypes, utlbox, classes, utlconst, utldatabase,
    utltimedate, knsl5tracer, SyncObjs,paramchklist,knsl2qwerytmr,inifiles,comctrls,stdctrls;

type
    CL3Export2MySQLModule = class(CTimeMDL)
    private
        m_pGenSett      : PSGENSETTTAG;
        m_sTblL1        : SL1INITITAG;
        m_PTMemo        : PTMemo;
        m_plbComplete   : PTLabel;
        m_plbNext       : PTLabel;
        w_mGEvent0      : THandle;
        m_sConnDSN      : String;    // Строка подключения к серверу
        m_dtStartExp    : TDateTime; // Время начала экспорта
        m_dtNextExport  : TDateTime; // Временная метка следующего экспорта
        m_dtInterval    : TDateTime; // Интервал экспорта

        m_dtLast        : TDateTime; // последний опрос

        m_boEnabled     : Boolean;

        m_nAbonentsCount: Integer;
        m_pAbonents     : array of SABON;     // структура дял хранения системы
        m_boIsMaked     : Boolean;
        m_boIsFirst     : Boolean;
        clm_swDayMask   : TParamCheckList;
        clm_sdwMonthMask: TParamCheckList;
        dtm_sdtBegin    : TDateTimePicker;
        dtm_sdtEnd      : TDateTimePicker;
        dtm_sdtPeriod   : TDateTimePicker;
        chm_swDayMask   : TCheckBox;
        chm_sdwMonthMask: TCheckBox;
        chm_sbyEnable   : TCheckBox;
        cbm_snDeepFind  : TComboBox;
        chm_sbyFindData : TCheckBox;
        mMySQLECmpl     : TLabel;
        mMySQLENext     : TLabel;
        clm_strAbons  : TParamCheckList;
        m_pAbonTable    : SL3ABONSNAMES;
        m_strAbons      : String;
    public
        m_boIsConnected : Boolean;   // Подключен ли к серверу
        constructor Create(_pMemo: PTMemo; _pLCMP, _pLNXT : PTLabel);
        destructor Destruct();

        function  GetRealPort(nPort:Integer):Integer;
        procedure Init(pTable:PSGENSETTTAG);
        procedure SaveUnloadSett;
        procedure LoadUnloadSett;
        procedure ReInit();
        function  GetLeftDT(dtS, dtI : TDateTime): TDateTime;
        procedure Start();
        procedure Finish(directly : Boolean);

        procedure InitTree();
        function  VMID2Tuch(_VMID : Integer) : INteger;
        // удаление абонентов
        function DeleteABONS() : Boolean;
        function DeleteABON(a : SABON) : Boolean;
        // удаление точек учета
        function DeleteTUCHS() : Boolean;
        function DeleteTUCHByABON(a : SABON) : Boolean;
        function DeleteTUCH(t : STUCH) : Boolean;
        // удаление данных
        function DeleteValues(ds, de : TDateTime) : Boolean;
        function DeleteValuesByABON(ds, de : TDateTime; a : SABON) : Boolean;
        function DeleteValuesByTUCH(ds, de : TDateTime; t : STUCH) : Boolean;

        function ExportValues(ds, de : TDateTime) : Boolean;
        function ExportBytValues(ds, de : TDateTime) : Boolean;
        function ExportBytTeploValues(ds, de : TDateTime) : Boolean;
        procedure CalcRash(var sTable:L3DATASAVT_EXPS;var sTable1:L3DATASAVT_EXPS);
        function GetAboID(nAID:Integer):Integer;

        function CreateDeInvalidREQ(var Table : L3VALIDATASMY) : Boolean;
        function ExportDeInvalidValues(var Table : L3VALIDATASMY) : Boolean;

        procedure RunExport();
        procedure OnExportOn();
        procedure OnExportOff();
        procedure OnExportInit();
        procedure OnExport;
        procedure OnQueryComplette;

        procedure ExportBuf_V_Int(nAbon, nVMID : Integer; ds, de : TDateTime);
        procedure ExportAVT_EXP(nAbon, nVMID : Integer; ds, de : TDateTime);

        procedure OnHandler;
        function  EventHandler(var pMsg : CMessage):Boolean;
        function  SelfHandler(var pMsg:CMessage):Boolean;
        function  LoHandler(var pMsg:CMessage):Boolean;
        function  HiHandler(var pMsg:CMessage):Boolean;

        procedure OnExpired; override;
        procedure SetLastDate(dtDate:TDateTime);
        function LoadSettings:SQWERYMDL;
        procedure SaveSettings(pTbl:SQWERYMDL);
        procedure SetToScreen(pTbl:SQWERYMDL);
        function GetToScreen:SQWERYMDL;
        procedure LoadDayChBox(dwDayWMask:Dword);
        procedure LoadMonthChBox(dwDayMask:Dword);
        function  GetWDayMask:Word;
        function  GetMDayMask:DWord;
        function  GetLastDate:TDateTime;
        function  LoadAbonsCheckList:String;
        function  GetAbonCluster:String;
        procedure SetAbonCluster(strCluster:String);
        function  GetAID(strAID:String):Integer;
        function  GetSAID(nAID:Integer):String;
        function  FindAID(nAID:Integer;strAID:String):Boolean;
    public
        property Pclm_swDayMask:TParamCheckList read clm_swDayMask write clm_swDayMask;
        property Pclm_sdwMonthMask:TParamCheckList read clm_sdwMonthMask write clm_sdwMonthMask;
        property Pchm_swDayMask:TCheckBox read chm_swDayMask write chm_swDayMask;
        property Pchm_sdwMonthMask:TCheckBox read chm_sdwMonthMask write chm_sdwMonthMask;
        property Pchm_sbyEnable:TCheckBox read chm_sbyEnable write chm_sbyEnable;
        property Pclm_strMyAbons:TParamCheckList read clm_strAbons write clm_strAbons;
        property Pdtm_sdtBegin:TDateTimePicker read dtm_sdtBegin write dtm_sdtBegin;
        property Pdtm_sdtEnd:TDateTimePicker read dtm_sdtEnd write dtm_sdtEnd;
        property Pdtm_sdtPeriod:TDateTimePicker read dtm_sdtPeriod write dtm_sdtPeriod;
        property Pcbm_snDeepFind:TComboBox read cbm_snDeepFind write cbm_snDeepFind;
        property Pchm_sbyFindData:TCheckBox read chm_sbyFindData write chm_sbyFindData;

        property PmMySQLECmpl:TLabel read mMySQLECmpl write mMySQLECmpl;
        property PmMySQLENext:TLabel read mMySQLENext write mMySQLENext;


    end;


implementation

procedure CL3Export2MySQLModule.OnHandler; Begin End;
function  CL3Export2MySQLModule.EventHandler(var pMsg : CMessage):Boolean;
begin
    case pMsg.m_sbyType of
         DL_EXPORTMYSQL_START       : OnExport;
    end;

end;
function  CL3Export2MySQLModule.SelfHandler(var pMsg:CMessage):Boolean; begin end;
function  CL3Export2MySQLModule.LoHandler(var pMsg:CMessage):Boolean; begin end;
function  CL3Export2MySQLModule.HiHandler(var pMsg:CMessage):Boolean; begin end;

constructor CL3Export2MySQLModule.Create(_pMemo: PTMemo; _pLCMP, _pLNXT : PTLabel);
begin
    m_PTMemo      := _pMemo;
    m_plbComplete := _pLCMP;
    m_plbNext     := _pLNXT;
end;


{
    Инициализация модуля
    @param dtStart TDateTime    Время начала экспорта
    @param dtInterval TDateTime Интервал экспорта
    @param sSRV String          имя или IP сервера баз данных MySQL
    @param sUSR String          пользователь
    @param sPASSW String        пароль
    @param sDBN String          имя базы данных
}
procedure CL3Export2MySQLModule.Init(pTable:PSGENSETTTAG);
begin
    try
    m_PTMemo.Lines.Clear;
    m_pGenSett := pTable;

    if w_mGEvent0=0 then
        w_mGEvent0 := CreateEvent(nil, False, False, nil);
    LoadUnloadSett;
    ReInit();
    //OnExport;
    //SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTMYSQL_START);
    except
    end;
end;
///////////////////////////////////////////////////////////
function CL3Export2MySQLModule.LoadAbonsCheckList:String;
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
function CL3Export2MySQLModule.GetAbonCluster:String;
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
function CL3Export2MySQLModule.GetAID(strAID:String):Integer;
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
function CL3Export2MySQLModule.GetSAID(nAID:Integer):String;
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
procedure CL3Export2MySQLModule.SetAbonCluster(strCluster:String);
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
function CL3Export2MySQLModule.FindAID(nAID:Integer;strAID:String):Boolean;
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
//////////////////////////////////////

procedure CL3Export2MySQLModule.OnQueryComplette;
var
    y,m,d,hh,mm,ss,mss : Word;
    Table : L3VALIDATASMY;
Begin
    if (m_boIsConnected) then
    begin
        m_pDB.MyGetInvalidData(Table);
        ExportDeInvalidValues(Table);
    end;
End;


procedure CL3Export2MySQLModule.ReInit();
Var
    pTbl : SQWERYMDL;
begin
    try
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Инициализация модуля');

    pTbl := LoadSettings;
    inherited Init(pTbl);
    m_boEnabled := (m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=1);
    m_boIsConnected := false;
    m_pDB.DisconnectMySQL();
    m_boIsMaked := false;
    m_sConnDSN := 'Driver=MySQL ODBC 5.1 Driver;Server='+m_pGenSett.m_SDBSERVER+';'+
                        'Port='+IntToStr(m_pGenSett.m_SDBPORT)+';'+
                        'Database='+m_pGenSett.m_sDBNAME+';'+
                        'Uid='+m_pGenSett.m_sDBUSR+';'+
                        'Pwd='+m_pGenSett.m_sDBPASSW+';'+
                        'Option=71829522;';


    {
    ReplaceDate(m_pGenSett.m_dtEStart, 0);
    m_dtStartExp := m_pGenSett.m_dtEStart;
    ReplaceDate(m_pGenSett.m_dtEInt,0);
    m_dtInterval := m_pGenSett.m_dtEInt;
    if (m_dtInterval<>0) then
    Begin
        m_dtNextExport := GetLeftDT(m_dtStartExp, m_dtInterval);
        m_plbNext.Caption := TimeToStr(m_dtNextExport+m_dtInterval);
        Start();
    End;
    }
    Start();
    except
    end;
end;

function CL3Export2MySQLModule.GetLeftDT(dtS, dtI : TDateTime): TDateTime;
Var
    dt0,dtNow: TDateTime;
begin
    dtNow := Now;
    ReplaceDate(dtNow,0);
    dt0 := dtS;
    while dt0<=dtNow do
    Begin
     if (dt0+dtI)>=dtNow then
     Begin
      Result := Now;
      ReplaceTime(Result,dt0);
      exit;
     End;
     dt0 := dt0 + dtI;
    End;
    Result := Now;
    ReplaceTime(Result,dt0-dtI);
end;

{
    Начало работы
        Подключение к базе MySQL
        Создание структуры "абонент -> точка учета"
}
procedure CL3Export2MySQLModule.Start();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Запуск модуля');
    if (m_boIsConnected OR (not m_boEnabled) OR (m_pGenSett.m_sSetForETelecom<>1) OR(m_pGenSett.m_sChooseExport<>1)) then
        exit;
    {$ifndef MYSQL_UNLOAD_DEBUG}
    m_pDB.InitMySQL(m_sConnDSN);
    {$endif}
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Подключение к серверу MySQL (' + m_sConnDSN + ')');
    try
    {$ifndef MYSQL_UNLOAD_DEBUG}
    m_boIsConnected := m_pDB.ConnectMySQL();
    if (not m_boIsMaked) then
        InitTree();
    {$else}
     m_boIsConnected := true;
    {$endif}
    except
    m_boIsConnected := false;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Подключение к серверу MySQL не удалось, ошибка #' + IntToStr(GetLastError()));
    end;
end;


destructor CL3Export2MySQLModule.Destruct();
begin
    Finish(true);
end;
{
    Отключение от базы данных
}
procedure CL3Export2MySQLModule.Finish(directly : Boolean);
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Останов модуля');
    if m_boIsConnected and not directly then
        exit;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Отключение от сервера MySQL');
    {$ifndef MYSQL_UNLOAD_DEBUG}
    m_boIsConnected := not m_pDB.DisconnectMySQL();
   {$else}
    m_boIsConnected := False;
   {$endif}
end;


{$define D_IABO}
{$define D_ITUCH}
{
    Создание структуры "абонент -> точка учета"
}
procedure CL3Export2MySQLModule.InitTree();
var
    _pAbon         : SL3ABONS;
    _nAbonI        : Integer;

    _pAbonGroups   : SL3INITTAG;
    _nAbonGroupsI  : Integer;

    _pMeterZ       : SL3MYGROUPTAG;
    _nMeterZI      : Integer;
begin
    m_pDB.GetL1Table(m_sTblL1);
    //m_dtLast := Now();
    //cDateTimeR.DecDate(m_dtLast);

    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Инициализация структуры системы');
    {$ifndef MYSQL_UNLOAD_DEBUG}
    if (m_pDB.GetAbonsTableNS(_pAbon)) then
    begin
        m_nAbonentsCount := _pAbon.Count;
        SetLength(m_pAbonents, m_nAbonentsCount);
        for _nAbonI:=0 to _pAbon.Count-1 do
        begin
            m_pAbonents[_nAbonI].m_nABOID     := _pAbon.Items[_nAbonI].m_swABOID;
            m_pAbonents[_nAbonI].m_nABO       := _pAbon.Items[_nAbonI].m_swABOID + 1;
            m_pAbonents[_nAbonI].m_sNM_ABO    := StringReplace(_pAbon.Items[_nAbonI].m_sName, '"', '\"', [rfReplaceAll]);
            m_pAbonents[_nAbonI].m_sKSP       := _pAbon.Items[_nAbonI].m_sKSP;
            m_pAbonents[_nAbonI].m_sNOM_DOGWR := _pAbon.Items[_nAbonI].m_sDogNum;

            m_pAbonents[_nAbonI].M_NABONTYPE    := _pAbon.Items[_nAbonI].M_NABONTYPE;
            m_pAbonents[_nAbonI].M_SMARSHNUMBER := _pAbon.Items[_nAbonI].M_SMARSHNUMBER;
            m_pAbonents[_nAbonI].M_SHOUSENUMBER := _pAbon.Items[_nAbonI].M_SHOUSENUMBER;
            m_pAbonents[_nAbonI].M_SKORPUSNUMBER:= _pAbon.Items[_nAbonI].M_SKORPUSNUMBER;

            m_pAbonents[_nAbonI].Count        := 0;
            if m_pAbonents[_nAbonI].M_NABONTYPE=ABO_PROM then
            Begin

            {$ifdef D_IABO}
            if (m_boIsConnected) then
            m_pDB.MyInsertABO(m_pAbonents[_nAbonI].m_nABO,
                              m_pAbonents[_nAbonI].m_sNM_ABO,
                              m_pAbonents[_nAbonI].m_sKSP,
                              m_pAbonents[_nAbonI].m_sNOM_DOGWR);
            {$endif}

            m_pDB.GetAbonGroupsTableNS(m_pAbonents[_nAbonI].m_nABOID, _pAbonGroups);

            for _nAbonGroupsI:=0 to _pAbonGroups.Count-1 do
            begin
                if (m_pDB.MyGetAbonVMetersTable(m_pAbonents[_nAbonI].m_nABOID, _pAbonGroups.Items[_nAbonGroupsI].m_sbyGroupID, _pMeterZ)) then
                begin
                    SetLength(m_pAbonents[_nAbonI].Items, m_pAbonents[_nAbonI].Count + _pMeterZ.Item.Count);
                    for _nMeterZI := 0 to _pMeterZ.Item.Count-1 do
                    begin
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nABO     := m_pAbonents[_nAbonI].m_nABO; // ид абонента (с 1)
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nVMID    := _pMeterZ.Item.Items[_nMeterZI].m_swVMID; // вирт ид связанного счетчика
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nMID     := _pMeterZ.Item.Items[_nMeterZI].m_swMID; // вирт ид связанного счетчика
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nPID     := _pMeterZ.Item.Items[_nMeterZI].m_vPortID; // вирт ид связанного счетчика
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nTUCH    := m_pAbonents[_nAbonI].Count + _nMeterZI + 1; // ид точки учета (с 1)
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sZNOM_SH := _pMeterZ.Item.Items[_nMeterZI].m_sddPHAddres;
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sADRTU   := StringReplace(_pMeterZ.Item.Items[_nMeterZI].m_sVMeterName, '"', '\"', [rfReplaceAll]);
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nKFTRN   := _pMeterZ.Item.Items[_nMeterZI].m_sfKTR;
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nType    := _pMeterZ.Item.Items[_nMeterZI].m_nType;

                        {$ifdef D_ITUCH}
                        if (m_boIsConnected) then
                        Begin
                         //m_pDB.MyDeleteTUCH(m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nABO,
                         //                  m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nTUCH);
                         m_pDB.MyAddTUCH(m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nABO,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nTUCH,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sZNOM_SH,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sADRTU,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nKFTRN);
                        end;
                        {$endif}
                    end;
                    m_pAbonents[_nAbonI].Count := m_pAbonents[_nAbonI].Count + _pMeterZ.Item.Count;
                end;
            end;
            end;
        end;
    end;
    {$endif}
    m_boIsMaked := true;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Инициализация завершена');
end;

{$define NO_MASK_READ}
{
    Экспорт данных по номеру абонента и виртуальному номеру точки учета
    @param nAbon Integer    Номер абонента
    @param nVMID Integer    Виртуальный номер точки учета
    @param ds TDateTime     Дата/Время начала периода
    @param de TDateTime     Дата/время окончания периода
}
procedure CL3Export2MySQLModule.ExportBuf_V_Int(nAbon, nVMID : Integer; ds, de : TDateTime);
var
    ni, it : Integer;
    sTable : L3GRAPHDATASMY;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт данных по абоненту ' + IntToStr(nAbon) + ', VMID ' + IntToStr(nVMID)+
                ' с ' + DateTimeToStr(ds) + ' по ' + DateTimeToStr(de));
    if (not m_boIsConnected) then
    begin
        TraceL(3,0,'(__)CEXMD::> Is Disconnected!');
        exit;
    end;

    ReplaceTime(ds, 0); // устанавливаем время == 00:00:00
    // достать показания 30мин срезов на указанные сутки
    if (true = m_pDB.GetGraphDatasMyExport(ds, de, nVMID, sTable)) then
    begin
        for ni := 0 to sTable.Count-1 do
        begin
            m_pDB.MyPrepareMultiExec();
            for it := 0 to 47 do
            begin
                sTable.Items[ni].m_swSumm := sTable.Items[ni].m_swSumm + sTable.Items[ni].v[it];
                if True {$ifndef NO_MASK_READ}= IsBitInMask(sTable.Items[ni].m_sMaskRead, it){$endif} then
                begin
                    m_pDB.MyMakeInsertBUF_V_INT(nAbon,
                                                VMID2Tuch(nVMID),
                                                sTable.Items[ni].m_swCMDID,
                                                sTable.Items[ni].m_sdtDate,
                                                it + 1,
                                                sTable.Items[ni].v[it],
                                                sTable.Items[ni].m_swSumm,
                                                sTable.Items[ni].v[it]);
                    m_pDB.MyMakeDeleteBUF_V_FAIL(nAbon,
                                                VMID2Tuch(nVMID),
                                                sTable.Items[ni].m_swCMDID,
                                                sTable.Items[ni].m_sdtDate,
                                                it + 1);
                end else
                    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Недостоверные данные по абоненту №' + IntToStr(nAbon) + ', точка учета №'+ IntToStr(VMID2Tuch(nVMID))+
                    'VMID[' + IntToStr(nVMID) +'] на дату ' + DateToStr(sTable.Items[ni].m_sdtDate) + '['+IntToStr(it)+']');
            end;
            m_pDB.MyMultiExec();
        end;
    end;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт данных по абоненту завершен');
end;

procedure CL3Export2MySQLModule.OnExport;
var
    y,m,d,hh,mm,ss,mss : Word;
    Table : L3VALIDATASMY;
Begin
    if (m_boIsConnected) then
    begin
        if ExportValues(GetLastDate, Now)=True then
        Begin
         m_dtLast := Now;
         SetLastDate(m_dtLast);
         mMySQLECmpl.Caption := DateTimeToStr(m_dtLast);
         mMySQLENext.Caption := DateTimeToStr(m_dtLast+m_nTbl.m_sdtPeriod);
        End;

        if ExportBytValues(GetLastDate, Now)=True then
        Begin
         //m_dtLast := Now;
         //SetLastDate(m_dtLast);
         //mMySQLECmpl.Caption := DateTimeToStr(m_dtLast);
         //mMySQLENext.Caption := DateTimeToStr(m_dtLast+m_nTbl.m_sdtPeriod);
        End;
        if ExportBytTeploValues(GetLastDate, Now)=True then
        Begin
         //m_dtLast := Now;
         //SetLastDate(m_dtLast);
         //mMySQLECmpl.Caption := DateTimeToStr(m_dtLast);
         //mMySQLENext.Caption := DateTimeToStr(m_dtLast+m_nTbl.m_sdtPeriod);
        End;

        //DecodeDate(Now(),y,m,d);
        //DecodeTime(m_dtStartExp, hh,mm,ss,mss);
        //m_dtStartExp := EncodeDate(y,m,d) + EncodeTime(hh,mm,ss,mss);

        m_pDB.MyGetInvalidData(Table);//AAV
        CreateDeInvalidREQ(Table);    //AAV
//        if FCHECK(BOX_LOAD)<>0 then
//         SendMsg(BOX_L3_LME, DIR_LM3TOLM3, DIR_LM3TOLM3,QL_START_UNLOAD_REQ);
    end;
end;


function CL3Export2MySQLModule.CreateDeInvalidREQ(var Table : L3VALIDATASMY) : Boolean;
var
    l_i : WORD;
//    l_ABO,
//    l_TUCH   : WORD;
    
//    szDT : Integer;
//    pDS  : CMessageData;
begin
    Result := false;
    
    if (Table.Count = 0) then
        exit;
    // Создаем задание на опрос отсутствующих данных
    // ходим по Table
    // 1 запрос на 1 день
    for l_i := 0 to Table.Count-1 do
      m_pDB.SetSliceToRead(Table.Items[l_i].m_sdtDate,
                          m_pAbonents[Table.Items[l_i].m_swAbon-1].Items[Table.Items[l_i].m_swTuch-1].m_nVMID,
                          QRY_SRES_ENR_EP,
                          0,
                          false);
            SendQSDataGEx(QS_FIND_SR,-1,-1,-1,CLS_GRAPH48,QRY_SRES_ENR_EP,Now,Now);
end;

function CL3Export2MySQLModule.ExportDeInvalidValues(var Table : L3VALIDATASMY) : Boolean;
var
    l_Abo,
    l_Tuch,
    l_VMID,
    ni, it, l_i,
    l_j        : Integer;
    sTable     : L3GRAPHDATASMY;
    l_LastDT   : TDateTime;
begin
    TraceL(3,0,'(__)CEXMD::> in ExportData');
    if (not m_boIsConnected) then
    begin
        TraceL(3,0,'(__)CEXMD::> Is Disconnected!');
        exit;
    end;
    m_boEnabled := false;

    if (Table.Count > 0) then
        l_LastDT := Table.Items[0].m_sdtDate
    else
        exit;

    // Создаем задание на опрос отсутствующих данных
    // ходим по Table
    // 1 запрос на 1 день
    for l_i := 0 to Table.Count-1 do
    begin
        l_Abo  := Table.Items[l_i].m_swAbon-1;
        l_Tuch := Table.Items[l_i].m_swTuch-1;
        l_VMID :=m_pAbonents[l_Abo].Items[l_Tuch].m_nVMID;
        // достать показания 30мин срезов на указанные сутки
        if (Table.Items[l_i].m_sdtDate > 0) AND (true = m_pDB.GetGraphDatasMyExport(Table.Items[l_i].m_sdtDate, Table.Items[l_i].m_sdtDate, l_VMID, sTable)) then
        begin
            DeleteValuesByTUCH(Table.Items[l_i].m_sdtDate, Table.Items[l_i].m_sdtDate, m_pAbonents[l_Abo].Items[l_Tuch]);
            for ni := 0 to sTable.Count-1 do
            begin
                m_pDB.MyPrepareMultiExec();
                for it := 0 to 47 do
                begin
                    sTable.Items[ni].m_swSumm := sTable.Items[ni].m_swSumm + sTable.Items[ni].v[it];
                    if True{$ifndef NO_MASK_READ}= IsBitInMask(sTable.Items[ni].m_sMaskRead, it){$endif} then
                    begin
                        m_pDB.MyMakeInsertBUF_V_INT(m_pAbonents[l_Abo].Items[l_Tuch].m_nABO,
                                                    m_pAbonents[l_Abo].Items[l_Tuch].m_nTUCH,
                                                    sTable.Items[ni].m_swCMDID,
                                                    sTable.Items[ni].m_sdtDate,
                                                    it + 1,
                                                    sTable.Items[ni].v[it],
                                                    sTable.Items[ni].m_swSumm,
                                                    sTable.Items[ni].v[it]);
                        {m_pDB.MyMakeDeleteBUF_V_FAIL(m_pAbonents[l_Abo].Items[l_Tuch].m_nABO,
                                                     m_pAbonents[l_Abo].Items[l_Tuch].m_nTUCH,
                                                     sTable.Items[ni].m_swCMDID,
                                                     sTable.Items[ni].m_sdtDate,
                                                     it + 1);}
                    end else
                        m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Недостоверные данные по абоненту №' + IntToStr(m_pAbonents[l_Abo].Items[l_Tuch].m_nABO) + ', точка учета №'+ IntToStr(m_pAbonents[l_Abo].Items[l_Tuch].m_nTUCH)+
                                               'VMID[' + IntToStr(sTable.Items[ni].m_swVMID) +'] на дату ' + DateToStr(sTable.Items[ni].m_sdtDate) + '['+IntToStr(it+1)+']');
                end;
                m_pDB.MyMultiExec();
                // пометить все срезы по абоненту-точке учета-дате как записанные
                for l_j :=0 to Table.Count do
                begin
                    if (Table.Items[l_j].m_sdtDate = Table.Items[l_i].m_sdtDate) AND (Table.Items[l_j].m_swAbon = Table.Items[l_i].m_swAbon) AND (Table.Items[l_j].m_swTuch = Table.Items[l_i].m_swTuch) then
                        Table.Items[l_j].m_sdtDate := 0;
                end;
                WaitForSingleObject(w_mGEvent0,1);
            end;
        end;
    end;

    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт инвалиданных завершен');
    m_plbComplete.Caption := TimeToStr(Now());
    m_boEnabled := true;
end;


function CL3Export2MySQLModule.DeleteABONS() : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление всех абонентов ');
    m_pDB.MyDeleteABON(0);
end;

function CL3Export2MySQLModule.DeleteABON(a : SABON) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление абонента №' + IntToStr(a.m_nABOID));
    m_pDB.MyDeleteTUCH(a.m_nABO,0);
end;



function CL3Export2MySQLModule.DeleteTUCHS() : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление всех точек учета');
    m_pDB.MyDeleteTUCH(0, 0);
end;

function CL3Export2MySQLModule.DeleteTUCHByABON(a : SABON) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление всех точек учета по абоненту №' + IntToStr(a.m_nABOID));
    m_pDB.MyDeleteTUCH(a.m_nABO, 0);
end;

function CL3Export2MySQLModule.DeleteTUCH(t : STUCH) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление точки учета ' + IntToStr(t.m_nTUCH) + ' VMID ' + IntToStr(t.m_nVMID) + ' абонента № ' + IntToStr(t.m_nABO-1));
    m_pDB.MyDeleteTUCH(t.m_nABO, t.m_nTUCH);
end;

function CL3Export2MySQLModule.DeleteValues(ds, de : TDateTime) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление данных системы по всем точкам учета с ' + DateToStr(ds) + ' по '+DateToStr(de));
    m_pDB.MyDeleteValues(ds, de, 0, 0);
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление завершено');
end;

function CL3Export2MySQLModule.DeleteValuesByABON(ds, de : TDateTime; a : SABON) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление данных по абоненту №' + IntToStr(a.m_nABOID));
    m_pDB.MyDeleteValues(ds, de, a.m_nABO, 0);
end;

function CL3Export2MySQLModule.DeleteValuesByTUCH(ds, de : TDateTime; t : STUCH) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Удаление данных точки учета ' + IntToStr(t.m_nTUCH) + ' VMID ' + IntToStr(t.m_nVMID) + ' абонента № ' + IntToStr(t.m_nABO-1));
    m_pDB.MyDeleteValues(ds, de, t.m_nABO, t.m_nTUCH);
end;
{
asbyt_enrg = packed record
     m_swID   : Integer;
     LIC_CH   : String[20];
     FIO      : String[40];
     NAM_PUNK : String[20];
     NAS_STR  : String[20];
     DOM      : String[5];
     KORP     : String[4];
     KVAR     : String[4];
     STAMP    : TDateTime;
     NOM_SCH  : String[20];
     D1       : TDateTime;
     D2       : TDateTime;
     VAL_K1   : Double;
     VAL_MAX1 : Double;
     VAL_MIN1 : Double;
     VAL_K2   : Double;
     VAL_MAX2 : Double;
     VAL_MIN2 : Double;
     R_MAX    : Double;
     R_MIN    : Double;
     R_ALL    : Double;
    End;
    asbyt_enrgs = packed record
     Count : Integer;
     Items : array of asbyt_enrg;
    End;
function CDBase.MyMakeDeleteBYT(dtDate:TDateTime):Integer;
function CDBase.MyMakeInsertBYT(var pTbl:asbyt_enrg):Integer;
}
function CL3Export2MySQLModule.ExportBytValues(ds, de : TDateTime) : Boolean;
var
    nAboIT,nAID  : Integer;
    nTuchIT,i : Integer;
    ni, it  : Integer;
    sTable  : asbyt_enrgs;
    res0,res1 : Boolean;
    year,month,day:Word;
    dtTmps,dtTmpe : TDateTime;
    pLabel      : SL3ABONLB;
    str : String;
begin
    //m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт. данных с ' + DateTimeToStr(ds) + ' по ' +DateTimeToStr(de));
    TraceL(3,0,'(__)CEXMD::> in ExportData Byt');
    if (not m_boIsConnected) then
    begin
     TraceL(3,0,'(__)CEXMD::>Byt Is Disconnected!');
     exit;
    end;
    Result := True;
    {$ifndef MYSQL_UNLOAD_DEBUG}
    m_boEnabled := false;
    ReplaceTime(ds, 0);
    try
    if de<ds then Begin Result := False;exit;End;

    //ds := cDateTimeR.DecMonth1(de);
    DecodeDate(ds,year,month,day); ds := EncodeDate(year,month,1);
    DecodeDate(de,year,month,day); de := EncodeDate(year,month,1);
    if m_blIsBackUp=True then
    Begin
     m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :>Экспорт Быт. Производится сжатие данных.Выгрузка временно не возможна!');
     exit;
    End;
    //m_pDB.MyMakeDeleteBYT(ds,de);  r

    dtTmps := ds;
    dtTmpe := de;
    while dtTmpe>=ds do
    Begin
    dtTmps := cDateTimeR.DecMonth1(dtTmpe);
    //for nAboIT:=0 to m_nAbonentsCount-1 do
    //begin
    //for nAboIT:=0 to m_nAbonentsCount-1 do
    str := m_strAbons;
    while GetCode(nAID,str)<>False do
    begin
     nAboIT := GetAboID(nAID);
     if m_pAbonents[nAboIT].M_NABONTYPE=ABO_BYT then
     Begin
      //m_pDB.MyMakeDeleteBYT_Ex(dtTmps,dtTmps,m_pAbonents[nAboIT].M_SHOUSENUMBER,m_pAbonents[nAboIT].M_SKORPUSNUMBER);
      m_pDB.GetAbonLabel(m_pAbonents[nAboIT].m_nABOID,pLabel);
      m_pDB.MyMakeDeleteBYT_Ex(dtTmpe,dtTmpe,m_pAbonents[nAboIT].M_SHOUSENUMBER,m_pAbonents[nAboIT].M_SKORPUSNUMBER,pLabel.m_sStreetName);
      m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт с ' + DateTimeToStr(dtTmpe) + ' по ' +DateTimeToStr(dtTmpe)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
      res0:=m_pDB.GetBytDatasMyExport(0,m_pAbonents[nAboIT].m_nABOID,dtTmps,dtTmps,sTable);
      res1:=m_pDB.GetBytDatasMyExport(1,m_pAbonents[nAboIT].m_nABOID,dtTmpe,dtTmpe,sTable);
      if (res0=True)or(res1=True) then
      Begin
       m_pDB.MyPrepareMultiExec;
        for i:=0 to sTable.RCount-1 do
        m_pDB.MyMakeInsertBYT(sTable.Items[i]);
       m_pDB.MyMultiExec;
      End;
      if (res0=True)and(res1=True) then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Успешная выгрузка для '+m_pAbonents[nAboIT].m_sNM_ABO) else
      if (res0=False)              then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт. Ошибка! Нет данных за ' + DateTimeToStr(dtTmps)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
      if (res1=False)              then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт. Ошибка! Нет данных за ' + DateTimeToStr(dtTmpe)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
     End;
     End;//m_pAbonents[nAboIT].M_NABONTYPE=ABO_BYT
     cDateTimeR.DecMonth(dtTmpe);
    End;
    except
      Result := False;
      m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Ошибка при экспорте данных');
      m_boEnabled := true;
      ReInit;
    end;
    {$endif}
    if (res0=True)and(res1=True)  then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт данных завершен успешно.');
    m_boEnabled := true;
End;
function CL3Export2MySQLModule.ExportBytTeploValues(ds, de : TDateTime) : Boolean;
var
    nAboIT,nAID  : Integer;
    nTuchIT,i : Integer;
    ni, it  : Integer;
    sTable,sTable1 : L3DATASAVT_EXPS;
    res0,res1 : Boolean;
    year,month,day:Word;
    dtTmps,dtTmpe : TDateTime;
    str : String;
begin
    //m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт. данных с ' + DateTimeToStr(ds) + ' по ' +DateTimeToStr(de));
    TraceL(3,0,'(__)CEXMD::> in ExportData Byt');
    if (not m_boIsConnected) then
    begin
     TraceL(3,0,'(__)CEXMD::>Byt Is Disconnected!');
     exit;
    end;
    Result := True;
    {$ifndef MYSQL_UNLOAD_DEBUG}
    m_boEnabled := false;
    ReplaceTime(ds, 0);
    try
    if de<ds then Begin Result := False;exit;End;

    //ds := cDateTimeR.DecMonth1(de);
    DecodeDate(ds,year,month,day); ds := EncodeDate(year,month,1);
    DecodeDate(de,year,month,day); de := EncodeDate(year,month,1);
    if m_blIsBackUp=True then
    Begin
     m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :>Экспорт Быт. Производится сжатие данных.Выгрузка временно не возможна!');
     exit;
    End;
    //m_pDB.MyMakeDeleteBYT(ds,de);  r

    dtTmps := ds;
    dtTmpe := de;
    while dtTmpe>=ds do
    Begin
    dtTmps := cDateTimeR.DecMonth1(dtTmpe);
    //for nAboIT:=0 to m_nAbonentsCount-1 do
    //begin
    //for nAboIT:=0 to m_nAbonentsCount-1 do
    str := m_strAbons;
    while GetCode(nAID,str)<>False do
    begin
     nAboIT := GetAboID(nAID);
     if m_pAbonents[nAboIT].M_NABONTYPE=ABO_BYT then
     Begin
      //m_pDB.MyMakeDeleteBYT_Ex(dtTmps,dtTmps,m_pAbonents[nAboIT].M_SHOUSENUMBER,m_pAbonents[nAboIT].M_SKORPUSNUMBER);
      m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт теплосчетчиков быт с ' + DateTimeToStr(dtTmpe) + ' по ' +DateTimeToStr(dtTmpe)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
      res0:=m_pDB.GetTplMyExport(m_pAbonents[nAboIT].m_nABOID,dtTmps,sTable);
      res1:=m_pDB.GetTplMyExport(m_pAbonents[nAboIT].m_nABOID,dtTmpe,sTable1);
      CalcRash(sTable,sTable1);
      if (res0=True)or(res1=True) then
      Begin
       for i:=0 to sTable1.Count-1 do m_pDB.DelAVT_EXP(dtTmpe,dtTmpe,sTable1.Items[i]);
       m_pDB.MyPrepareMultiExec;
       for i:=0 to sTable1.Count-1 do
       m_pDB.MyMakeInsertAVT_EXP(sTable1.Items[i]);
       m_pDB.MyMultiExec;
      End;
      if (res0=True)and(res1=True) then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Успешная выгрузка тпл для '+m_pAbonents[nAboIT].m_sNM_ABO) else
      if (res0=False)              then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт. Ошибка! Нет данных за ' + DateTimeToStr(dtTmps)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
      if (res1=False)              then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт быт. Ошибка! Нет данных за ' + DateTimeToStr(dtTmpe)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
     End;
     End;//m_pAbonents[nAboIT].M_NABONTYPE=ABO_BYT
     cDateTimeR.DecMonth(dtTmpe);
    End;
    except
      Result := False;
      m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Ошибка при экспорте данных');
      m_boEnabled := true;
      ReInit;
    end;
    {$endif}
    if (res0=True)and(res1=True)  then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт данных завершен успешно.');
    m_boEnabled := true;
End;
procedure CL3Export2MySQLModule.CalcRash(var sTable:L3DATASAVT_EXPS;var sTable1:L3DATASAVT_EXPS);
Var
    i : Integer;
    dbTime : Double;
Begin
    for i:=0 to sTable1.Count-1 do
    Begin
     if sTable.Items[i].m_swVMID=sTable1.Items[i].m_swVMID then
     Begin
      dbTime := sTable1.Items[i].TRAB-sTable.Items[i].TRAB;
      if dbTime=0 then dbTime:=1;
      sTable1.Items[i].G1 := (sTable1.Items[i].V1-sTable.Items[i].V1)/dbTime;
      sTable1.Items[i].G2 := (sTable1.Items[i].V2-sTable.Items[i].V2)/dbTime;
     End;
    End;
End;
function CL3Export2MySQLModule.GetAboID(nAID:Integer):Integer;
Var
    i : Integer;
Begin
    Result := 0;
    for i:=0 to m_nAbonentsCount-1 do
    if nAID=m_pAbonents[i].m_nABOID then
    Result := i;
End;
function CL3Export2MySQLModule.ExportValues(ds, de : TDateTime) : Boolean;
var
    nAboIT  : Integer;
    nTuchIT : Integer;
    ni, it  : Integer;
    sTable  : L3GRAPHDATASMY;
    str     : String;
    nAID    : Integer;
begin
    //m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт пром с ' + DateTimeToStr(ds) + ' по ' +DateTimeToStr(de));
    TraceL(3,0,'(__)CEXMD::> in ExportData Prom');
    if (not m_boIsConnected) then
    begin
        TraceL(3,0,'(__)CEXMD::>Prom Is Disconnected!');
        exit;
    end;
    Result := True;
    if m_blIsBackUp=True then
    Begin
     m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :>Экспорт Пром. Производится сжатие данных.Выгрузка временно не возможна!');
     exit;
    End;

    {$ifndef MYSQL_UNLOAD_DEBUG}
    m_boEnabled := false;
    ReplaceTime(ds, 0);
    try
    if de<ds then Begin Result := False;exit;End;
    //DeleteValues(ds, de);

    //for nAboIT:=0 to m_nAbonentsCount-1 do
    str := m_strAbons;
    while GetCode(nAID,str)<>False do
    begin
        nAboIT := GetAboID(nAID);
        if m_pAbonents[nAboIT].M_NABONTYPE=ABO_PROM then
        Begin
        //DeleteValues(ds, de);  ee
        m_pDB.MyDeleteValues(ds, de, m_pAbonents[nAboIT].m_nABO, 0);
        m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт пром с ' + DateTimeToStr(ds) + ' по ' +DateTimeToStr(de)+' для '+m_pAbonents[nAboIT].m_sNM_ABO);
        for nTuchIT:=0 to m_pAbonents[nAboIT].Count-1 do
        begin
        if ( m_pAbonents[nAboIT].Items[nTuchIT].m_nType <> 14) then
        begin
            // достать показания 30мин срезов на указанные сутки
            if (true = m_pDB.GetGraphDatasMyExport(ds, de, m_pAbonents[nAboIT].Items[nTuchIT].m_nVMID, sTable)) then
            begin
                for ni := 0 to sTable.Count-1 do
                begin
                    m_pDB.MyPrepareMultiExec();
                    for it := 0 to 47 do
                    begin
                        sTable.Items[ni].m_swSumm := sTable.Items[ni].m_swSumm + sTable.Items[ni].v[it];
                        if True{$ifndef NO_MASK_READ}= IsBitInMask(sTable.Items[ni].m_sMaskRead, it){$endif} then
                        begin
                            m_pDB.MyMakeInsertBUF_V_INT(m_pAbonents[nAboIT].Items[nTuchIT].m_nABO,
                                                        m_pAbonents[nAboIT].Items[nTuchIT].m_nTUCH,
                                                        sTable.Items[ni].m_swCMDID,
                                                        sTable.Items[ni].m_sdtDate,
                                                        it + 1,
                                                        sTable.Items[ni].v[it],
                                                        sTable.Items[ni].m_swSumm/m_pAbonents[nAboIT].Items[nTuchIT].m_nKFTRN,
                                                        sTable.Items[ni].v[it]);
                            m_pDB.MyMakeDeleteBUF_V_FAIL(m_pAbonents[nAboIT].Items[nTuchIT].m_nABO,
                                                        m_pAbonents[nAboIT].Items[nTuchIT].m_nTUCH,
                                                        sTable.Items[ni].m_swCMDID,
                                                        sTable.Items[ni].m_sdtDate,
                                                        it + 1);
                        end else
                            m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Недостоверные данные по абоненту №' + IntToStr(m_pAbonents[nAboIT].Items[nTuchIT].m_nABO) + ', точка учета №'+ IntToStr(m_pAbonents[nAboIT].Items[nTuchIT].m_nTUCH)+
                                               'VMID[' + IntToStr(sTable.Items[ni].m_swVMID) +'] на дату ' + DateToStr(sTable.Items[ni].m_sdtDate) + '['+IntToStr(it+1)+']');
                    end;
                    m_pDB.MyMultiExec();
                    WaitForSingleObject(w_mGEvent0,1);
                end;
            //m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт данных завершен успешно.');
            end else
             Result := False;
        end;
        //else
        //    ExportAVT_EXP(m_pAbonents[nAboIT].Items[nTuchIT].m_nABO,m_pAbonents[nAboIT].Items[nTuchIT].m_nVMID,ds,de);
        end;
          if Result=False then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Ошибка! Абонент: '+m_pAbonents[nAboIT].m_sNM_ABO+'. Данные для выгрузки отсутствуют.Последняя дата выгрузки:'+DateToStr(m_dtLast));
          if Result=True  then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> '+m_pAbonents[nAboIT].m_sNM_ABO+' Экспорт данных завершен успешно.');
        End;
        //m_dtLast := de;
    end;
    except
        Result := False;
        m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Ошибка при экспорте данных');
        m_boEnabled := true;
        ReInit;
    end;
    {$endif}
    //if Result=False then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Данные для выгрузки отсутствуют.Последняя дата выгрузки:'+DateToStr(m_dtLast)) else
    //if Result=True  then m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт данных завершен успешно.');
    //m_plbComplete.Caption := TimeToStr(Now());
    m_boEnabled := true;
end;

function CL3Export2MySQLModule.VMID2Tuch(_VMID : Integer) : INteger;
var
    ai : INteger;
    ti : Integer;
begin
    for ai:=0 to m_nAbonentsCount do
        for ti:=0 to m_pAbonents[ai].Count do
            if (_VMID = m_pAbonents[ai].Items[ti].m_nVMID) then
            begin
                Result := m_pAbonents[ai].Items[ti].m_nTUCH;
                exit;
            end;
end;

procedure CL3Export2MySQLModule.OnExportOn();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт разрешен');
    m_boEnabled := True;
    m_nTbl.m_sbyEnable := 1;
end;

procedure CL3Export2MySQLModule.OnExportOff();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Экспорт запрещен');
    m_boEnabled := false;
    m_nTbl.m_sbyEnable := 0;
end;

procedure CL3Export2MySQLModule.OnExportInit();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Инициализация экспорта');
    ReInit();
end;


procedure CL3Export2MySQLModule.ExportAVT_EXP(nAbon, nVMID : Integer; ds, de : TDateTime);
var
    l_AVT_EXPT : L3DATASAVT_EXP;
    l_ARCH     : L3ARCHDATASMY;
    l_IsQry    : Boolean;
begin

    // достать список счетчиков "Взлет"
    if true = m_pDB.GetConfDataMyExport(nVMID, l_AVT_EXPT) then
    begin
    l_AVT_EXPT.KJU := IntToStr(nAbon);

    m_pDB.MyPrepareMultiExec();
    while de >= ds do
    begin
    if true = m_pDB.GetArchDataMyExport(de,nVMID,l_ARCH) then
    begin
        if (l_ARCH.Count = 9) then
        begin
            l_AVT_EXPT.DAT     := de;
            ReplaceTime(l_AVT_EXPT.DAT,0);
            l_AVT_EXPT.VREM    := 0;
            ReplaceDate(l_AVT_EXPT.VREm,0);
        
            l_AVT_EXPT.Q1	  := l_ARCH.Items[0].m_sfValue; // QRY_POD_TRYB_HEAT
            l_AVT_EXPT.V1	  := l_ARCH.Items[1].m_sfValue; // QRY_POD_TRYB_RASX
            l_AVT_EXPT.G1	  := -1;
            l_AVT_EXPT.TPOD	  := l_ARCH.Items[2].m_sfValue; // QRY_POD_TRYB_TEMP

            l_AVT_EXPT.Q2	  := l_ARCH.Items[3].m_sfValue; // QRY_OBR_TRYB_HEAT
            l_AVT_EXPT.V2	  := l_ARCH.Items[4].m_sfValue; // QRY_OBR_TRYB_RASX
            l_AVT_EXPT.G2	  := -1;
            l_AVT_EXPT.TOBR	  := l_ARCH.Items[5].m_sfValue; // QRY_OBR_TRYB_TEMP

            l_AVT_EXPT.TXV	  := l_ARCH.Items[6].m_sfValue; // QRY_TEMP_COLD_WAT_DAY
            l_AVT_EXPT.TRAB	  := l_ARCH.Items[7].m_sfValue; // QRY_POD_TRYB_RUN_TIME
            l_AVT_EXPT.TRAB_O := l_ARCH.Items[8].m_sfValue; // QRY_WORK_TIME_ERR
            l_AVT_EXPT.N_GRUCH:= 0;
            m_pDB.MyMakeInsertAVT_EXP(l_AVT_EXPT);
            l_IsQry := true;
        end;
    end;
    cDateTimeR.DecDate(de);
    end;
    if l_IsQry then
        m_pDB.MyMultiExec();
    end;
end;

///////////////////////////////////////////////////////////////////////////
function CL3Export2MySQLModule.LoadSettings:SQWERYMDL;
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
     m_strAbons     := Fl.ReadString('UNLOAD_MY','m_strAbons','');
     m_sdtBegin     := StrToTime(Fl.ReadString('UNLOAD_MY','m_sdtBegin',TimeToStr(Now)));
     m_sdtEnd       := StrToTime(Fl.ReadString('UNLOAD_MY','m_sdtEnd',TimeToStr(Now)));
     m_sdtPeriod    := StrToTime(Fl.ReadString('UNLOAD_MY','m_sdtPeriod',TimeToStr(Now)));
     m_dtLast       := StrToDateTime(Fl.ReadString('UNLOAD_MY','m_dtLast',DateTimeToStr(Now)));
     m_swDayMask    :=Fl.ReadInteger('UNLOAD_MY','m_swDayMask',0);
     m_sdwMonthMask :=Fl.ReadInteger('UNLOAD_MY','m_sdwMonthMask',0);
     m_sbyEnable    :=Fl.ReadInteger('UNLOAD_MY','m_sbyEnable',0);
     m_snDeepFind   :=Fl.ReadInteger('UNLOAD_MY','m_snDeepFind',0);
     m_sbyFindData  :=Fl.ReadInteger('UNLOAD_MY','m_sbyFindData',0);
     m_sbyPause     := 0;
    end;
    Fl.Destroy;
    except
    end;
    Result := pTbl;
End;
procedure CL3Export2MySQLModule.SetLastDate(dtDate:TDateTime);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    Fl.WriteString('UNLOAD_MY','m_dtLast',DateToStr(dtDate));
    Fl.Destroy;
    except
    end;
End;
procedure CL3Export2MySQLModule.SaveSettings(pTbl:SQWERYMDL);
Var
    strPath : String;
    Fl      : TINIFile;
Begin
    strPath := GetCurrentDir+'\Settings\UnLoad_Config.ini';
    try
    Fl := TINIFile.Create(strPath);
    with pTbl do
    Begin
     Fl.WriteString('UNLOAD_MY','m_strAbons',m_strAbons);
     Fl.WriteString('UNLOAD_MY','m_sdtBegin',TimeToStr(m_sdtBegin));
     Fl.WriteString('UNLOAD_MY','m_sdtEnd',TimeToStr(m_sdtEnd));
     Fl.WriteString('UNLOAD_MY','m_sdtPeriod',TimeToStr(m_sdtPeriod));
     Fl.WriteString('UNLOAD_MY','m_dtLast',DateTimeToStr(m_dtLast));
     Fl.WriteInteger('UNLOAD_MY','m_swDayMask',m_swDayMask);
     Fl.WriteInteger('UNLOAD_MY','m_sdwMonthMask',m_sdwMonthMask);
     Fl.WriteInteger('UNLOAD_MY','m_sbyEnable',m_sbyEnable);
     Fl.WriteInteger('UNLOAD_MY','m_snDeepFind',m_snDeepFind);
     Fl.WriteInteger('UNLOAD_MY','m_sbyFindData',m_sbyFindData);
    end;
    Fl.Destroy;
    except
    end;
End;
procedure CL3Export2MySQLModule.SetToScreen(pTbl:SQWERYMDL);
Begin
    with pTbl do
    Begin
     dtm_sdtBegin.DateTime    := m_sdtBegin;
     dtm_sdtEnd.DateTime      := m_sdtEnd;
     dtm_sdtPeriod.DateTime   := m_sdtPeriod;
     LoadDayChBox(m_swDayMask);
     LoadMonthChBox(m_sdwMonthMask);
     SetAbonCluster(m_strAbons);
     cbm_snDeepFind.ItemIndex := m_snDeepFind;
     chm_sbyEnable.Checked    := Boolean(m_sbyEnable);
     chm_sbyFindData.Checked:= Boolean(m_sbyFindData);
    End;
End;
function CL3Export2MySQLModule.GetToScreen:SQWERYMDL;
Var
    pTbl : SQWERYMDL;
Begin
    with pTbl do
    Begin
     m_strAbons     := GetAbonCluster;
     m_sdtBegin     := dtm_sdtBegin.DateTime;
     m_sdtEnd       := dtm_sdtEnd.DateTime;
     m_sdtPeriod    := dtm_sdtPeriod.DateTime;
     m_swDayMask    := GetWDayMask;
     m_sdwMonthMask := GetMDayMask;
     m_snDeepFind   := cbm_snDeepFind.ItemIndex;
     m_sbyEnable    := Byte(chm_sbyEnable.Checked);
     m_sbyFindData:= Byte(chm_sbyFindData.Checked);
    End;
    Result := pTbl;
End;
procedure CL3Export2MySQLModule.LoadDayChBox(dwDayWMask:Dword);
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
procedure CL3Export2MySQLModule.LoadMonthChBox(dwDayMask:Dword);
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
function CL3Export2MySQLModule.GetWDayMask:Word;
var
    i     : integer;
    wMask : Word;
Begin
    wMask := Byte(chm_swDayMask.Checked=True);
    for i := 0 to 6 do
    wMask := wMask or ((Byte(clm_swDayMask.Checked[i]=True)) shl (i+1));
    Result := wMask;
End;
function CL3Export2MySQLModule.GetMDayMask:DWord;
var
    i      : integer;
    dwMask : DWord;
Begin
    dwMask := Byte(chm_sdwMonthMask.Checked=True);
    for i := 0 to 30 do
    dwMask := dwMask or ((Byte(clm_sdwMonthMask.Checked[i]=True)) shl (i+1));
    Result := dwMask;
End;
function CL3Export2MySQLModule.GetLastDate:TDateTime;
Var
    dtBegin,dtEnd  : TDateTime;
    year,month,day : Word;
Begin
    dtBegin:= Now;
    dtEnd  := Now;
    if m_nTbl.m_sbyFindData=1 then Begin dtEnd := m_dtLast;Result := dtEnd;exit;end;
    if m_nTbl.m_snDeepFind=0 then
    Begin
     DecodeDate(dtEnd,year,month,day);
     dtEnd := EncodeDate(year,month,1);
    End else
    if (m_nTbl.m_snDeepFind<>0)and(m_nTbl.m_snDeepFind<>255) then dtEnd := dtEnd - DeltaFHF[m_nTbl.m_snDeepFind];
    Result := dtEnd;
End;
procedure CL3Export2MySQLModule.SaveUnloadSett;
Begin

    SaveSettings(GetToScreen);
End;
procedure CL3Export2MySQLModule.LoadUnloadSett;
Begin
    LoadAbonsCheckList;
    SetToScreen(LoadSettings);
End;
procedure CL3Export2MySQLModule.OnExpired;
Begin
    //SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTDBF_START);
    SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTMYSQL_START);
End;
{
procedure CL3Export2MySQLModule.RunExport();
begin
    if(not m_boIsConnected OR not m_boEnabled OR not ((m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=1))) then
     exit;
    if (Now>=(m_dtNextExport+m_dtInterval)) then
    Begin
        m_dtNextExport:= Now();
        m_plbNext.Caption := TimeToStr(m_dtNextExport+m_dtInterval);
        SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTMYSQL_START);
    end;
end;

}
procedure CL3Export2MySQLModule.RunExport;
begin
    if(not m_boIsConnected OR not m_boEnabled OR not ((m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=1))) then
    exit;
    Run;
end;
function CL3Export2MySQLModule.GetRealPort(nPort:Integer):Integer;
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
end.
