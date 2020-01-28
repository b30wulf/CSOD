{
    ������� ������ � ���� MySQL ��� ����������� �����������
    ����������
}

unit knsl3MyExportModule;

interface
uses
    Windows,SysUtils, utltypes, utlbox, classes, utlconst, utldatabase, utltimedate, knsl5tracer, SyncObjs;

type
    CL3Export2MySQLModule = class
    private
        m_pGenSett      : PSGENSETTTAG;
        m_PTMemo        : PTMemo;
        m_plbComplete   : PTLabel;
        m_plbNext       : PTLabel;
        w_mGEvent0      : THandle;
        m_sConnDSN      : String;    // ������ ����������� � �������
        m_dtStartExp    : TDateTime; // ����� ������ ��������
        m_dtNextExport  : TDateTime; // ��������� ����� ���������� ��������
        m_dtInterval    : TDateTime; // �������� ��������

        m_dtLast        : TDateTime; // ��������� �����

        m_boEnabled     : Boolean;

        m_nAbonentsCount: Integer;
        m_pAbonents     : array of SABON;     // ��������� ��� �������� �������
        m_boIsMaked     : Boolean;
        m_boIsFirst     : Boolean;

    public
        m_boIsConnected : Boolean;   // ��������� �� � �������
        constructor Create(_pMemo: PTMemo; _pLCMP, _pLNXT : PTLabel);
        destructor Destruct();

        procedure Init(pTable:PSGENSETTTAG);
        procedure ReInit();
        function GetLeftDT(dtS, dtI : TDateTime): TDateTime;
        function GetRightDT(dtS, dtI : TDateTime): TDateTime;        
        procedure Start();
        procedure Finish(directly : Boolean);

        procedure InitTree();
        function VMID2Tuch(_VMID : Integer) : INteger;
        // �������� ���������
        function DeleteABONS() : Boolean;
        function DeleteABON(a : SABON) : Boolean;
        // �������� ����� �����
        function DeleteTUCHS() : Boolean;
        function DeleteTUCHByABON(a : SABON) : Boolean;
        function DeleteTUCH(t : STUCH) : Boolean;
        // �������� ������
        function DeleteValues(ds, de : TDateTime) : Boolean;
        function DeleteValuesByABON(ds, de : TDateTime; a : SABON) : Boolean;
        function DeleteValuesByTUCH(ds, de : TDateTime; t : STUCH) : Boolean;

        function ExportValues(ds, de : TDateTime) : Boolean;

        procedure RunExport();
        procedure OnExportOn();
        procedure OnExportOff();
        procedure OnExportInit();
        procedure OnExport;

        procedure ExportBuf_V_Int(nAbon, nVMID : Integer; ds, de : TDateTime);


      procedure OnHandler;
      function  EventHandler(var pMsg : CMessage):Boolean;
      function  SelfHandler(var pMsg:CMessage):Boolean;
      function  LoHandler(var pMsg:CMessage):Boolean;
      function  HiHandler(var pMsg:CMessage):Boolean;
    end;

   
implementation

procedure CL3Export2MySQLModule.OnHandler; Begin End;
function  CL3Export2MySQLModule.EventHandler(var pMsg : CMessage):Boolean;
begin
    case pMsg.m_sbyType of
         DL_EXPORT_START : OnExport;
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
    ������������� ������
    @param dtStart TDateTime    ����� ������ ��������
    @param dtInterval TDateTime �������� ��������
    @param sSRV String          ��� ��� IP ������� ��� ������ MySQL
    @param sUSR String          ������������
    @param sPASSW String        ������
    @param sDBN String          ��� ���� ������
}
procedure CL3Export2MySQLModule.Init(pTable:PSGENSETTTAG);
begin

    m_PTMemo.Lines.Clear;
    m_pGenSett := pTable;

    if w_mGEvent0=0 then
        w_mGEvent0 := CreateEvent(nil, False, False, nil);
    ReInit();
    OnExport;
end;

procedure CL3Export2MySQLModule.ReInit();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������������� ������');

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


    ReplaceDate(m_pGenSett.m_dtEStart, 0);
    m_dtStartExp := m_pGenSett.m_dtEStart;

    ReplaceDate(m_pGenSett.m_dtEInt,0);

    m_dtInterval := m_pGenSett.m_dtEInt;
    if (m_dtStartExp<>0)and(m_dtInterval<>0) then
    Begin
     m_dtNextExport := GetLeftDT(m_dtStartExp, m_dtInterval);
     m_plbNext.Caption := TimeToStr(m_dtNextExport+m_dtInterval);
     Start();
    End
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

function CL3Export2MySQLModule.GetRightDT(dtS, dtI : TDateTime): TDateTime;
begin
    ReplaceDate(dtS, 0);
    ReplaceDate(dtI, 0);
    Result := Now();
    ReplaceTime(Result, dtI*trunc(dtS /dtI));
end;

{
    ������ ������
        ����������� � ���� MySQL
        �������� ��������� "������� -> ����� �����"
}
procedure CL3Export2MySQLModule.Start();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������ ������');
    if (m_boIsConnected OR (not m_boEnabled) OR (m_pGenSett.m_sSetForETelecom<>1) OR(m_pGenSett.m_sChooseExport<>1)) then
        exit;
    m_pDB.InitMySQL(m_sConnDSN);
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ����������� � ������� MySQL (' + m_sConnDSN + ')');
    try
    m_boIsConnected := m_pDB.ConnectMySQL();
    except
    m_boIsConnected := false;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ����������� � ������� MySQL �� �������, ������ #' + IntToStr(GetLastError()));
    end;
    if (not m_boIsMaked) then
        InitTree();
end;


destructor CL3Export2MySQLModule.Destruct();
begin
    Finish(true);
end;
{
    ���������� �� ���� ������
}
procedure CL3Export2MySQLModule.Finish(directly : Boolean);
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ������');
    if m_boIsConnected and not directly then
        exit;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ���������� �� ������� MySQL');
    m_boIsConnected := not m_pDB.DisconnectMySQL();
end;


{$define D_IABO}
{$define D_ITUCH}
{
    �������� ��������� "������� -> ����� �����"
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
    m_dtLast := Now();
    cDateTimeR.DecDate(m_dtLast);

    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������������� ��������� �������');
    if (m_pDB.GetAbonsTable(_pAbon)) then
    begin
        m_nAbonentsCount := _pAbon.Count;
        SetLength(m_pAbonents, _pAbon.Count);
        for _nAbonI:=0 to _pAbon.Count-1 do
        begin
            m_pAbonents[_nAbonI].m_nABOID     := _pAbon.Items[_nAbonI].m_swABOID;
            m_pAbonents[_nAbonI].m_nABO       := _pAbon.Items[_nAbonI].m_swABOID + 1;
            m_pAbonents[_nAbonI].m_sNM_ABO    := StringReplace(_pAbon.Items[_nAbonI].m_sName, '"', '\"', [rfReplaceAll]);
            m_pAbonents[_nAbonI].m_sKSP       := _pAbon.Items[_nAbonI].m_sKSP;
            m_pAbonents[_nAbonI].m_sNOM_DOGWR := _pAbon.Items[_nAbonI].m_sDogNum;
            m_pAbonents[_nAbonI].Count        := 0;

            {$ifdef D_IABO}
            if (m_boIsConnected) then
            m_pDB.MyInsertABO(m_pAbonents[_nAbonI].m_nABO,
                              m_pAbonents[_nAbonI].m_sNM_ABO,
                              m_pAbonents[_nAbonI].m_sKSP,
                              m_pAbonents[_nAbonI].m_sNOM_DOGWR);
            {$endif}

            m_pDB.GetAbonGroupsTable(m_pAbonents[_nAbonI].m_nABOID, _pAbonGroups);

            for _nAbonGroupsI:=0 to _pAbonGroups.Count-1 do
            begin
                if (m_pDB.MyGetAbonVMetersTable(m_pAbonents[_nAbonI].m_nABOID, _pAbonGroups.Items[_nAbonGroupsI].m_sbyGroupID, _pMeterZ)) then
                begin
                    SetLength(m_pAbonents[_nAbonI].Items, m_pAbonents[_nAbonI].Count + _pMeterZ.Item.Count);
                    for _nMeterZI := 0 to _pMeterZ.Item.Count-1 do
                    begin
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nABO     := m_pAbonents[_nAbonI].m_nABO; // �� �������� (� 1)
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nVMID    := _pMeterZ.Item.Items[_nMeterZI].m_swVMID; // ���� �� ���������� ��������
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nTUCH    := m_pAbonents[_nAbonI].Count + _nMeterZI + 1; // �� ����� ����� (� 1)
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sZNOM_SH := _pMeterZ.Item.Items[_nMeterZI].m_sddPHAddres;
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sADRTU   := StringReplace(_pMeterZ.Item.Items[_nMeterZI].m_sVMeterName, '"', '\"', [rfReplaceAll]);
                        m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nKFTRN   := _pMeterZ.Item.Items[_nMeterZI].m_sfKTR;

                        {$ifdef D_ITUCH}
                        if (m_boIsConnected) then
                        m_pDB.MyInsertTUCH(m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nABO,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nTUCH,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sZNOM_SH,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_sADRTU,
                                           m_pAbonents[_nAbonI].Items[m_pAbonents[_nAbonI].Count + _nMeterZI].m_nKFTRN);
                        {$endif}
                    end;
                    m_pAbonents[_nAbonI].Count := m_pAbonents[_nAbonI].Count + _pMeterZ.Item.Count;
                end;                
            end;
        end;
    end;
    m_boIsMaked := true;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������������� ���������');
end;

{
    ������� ������ �� ������ �������� � ������������ ������ ����� �����
    @param nAbon Integer    ����� ��������
    @param nVMID Integer    ����������� ����� ����� �����
    @param ds TDateTime     ����/����� ������ �������
    @param de TDateTime     ����/����� ��������� �������
}
procedure CL3Export2MySQLModule.ExportBuf_V_Int(nAbon, nVMID : Integer; ds, de : TDateTime);
var
    ni, it : Integer;
    sTable : L3GRAPHDATASMY;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ������ �� �������� ' + IntToStr(nAbon) + ', VMID ' + IntToStr(nVMID)+
                ' � ' + DateTimeToStr(ds) + ' �� ' + DateTimeToStr(de));
    if (not m_boIsConnected) then
    begin
        TraceL(3,0,'(__)CEXMD::> Is Disconnected!');
        exit;
    end;

    ReplaceTime(ds, 0); // ������������� ����� == 00:00:00
    // ������� ��������� 30��� ������ �� ��������� �����
    if (true = m_pDB.GetGraphDatasMyExport(ds, de, nVMID, sTable)) then
    begin
        for ni := 0 to sTable.Count-1 do
        begin
            m_pDB.MyPrepareMultiExec();
            for it := 0 to 47 do
            begin
                sTable.Items[ni].m_swSumm := sTable.Items[ni].m_swSumm + sTable.Items[ni].v[it];
                m_pDB.MyMakeInsertBUF_V_INT(nAbon,
                                        VMID2Tuch(nVMID),
                                        sTable.Items[ni].m_swCMDID,
                                        sTable.Items[ni].m_sdtDate,
                                        it + 1,
                                        sTable.Items[ni].v[it],
                                        sTable.Items[ni].m_swSumm,
                                        sTable.Items[ni].v[it]);
            end;
            m_pDB.MyMultiExec();
        end;
    end;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ������ �� �������� ��������');
end;

procedure CL3Export2MySQLModule.RunExport();
begin
    if(not ((m_pGenSett.m_sSetForETelecom=1) AND (m_pGenSett.m_sChooseExport=1)) OR not m_boEnabled) then
     exit;
    if (Now>=(m_dtNextExport+m_dtInterval)) then
    Begin
        m_dtNextExport:= Now();
        m_plbNext.Caption := TimeToStr(m_dtNextExport+m_dtInterval);
        SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORT_START);
    end;
end;

procedure CL3Export2MySQLModule.OnExport;
var
    y,m,d,hh,mm,ss,mss : Word;
Begin
    if (m_boIsConnected) then
    begin
        ReplaceTime(m_dtLast, 0);
        ExportValues(m_dtLast, Now());
        DecodeDate(Now(),y,m,d);
        DecodeTime(m_dtStartExp, hh,mm,ss,mss);
        m_dtStartExp := EncodeDate(y,m,d) + EncodeTime(hh,mm,ss,mss);
    end;
end;







function CL3Export2MySQLModule.DeleteABONS() : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ���� ��������� ');
    m_pDB.MyDeleteABON(0);
end;

function CL3Export2MySQLModule.DeleteABON(a : SABON) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� �������� �' + IntToStr(a.m_nABOID));
    m_pDB.MyDeleteTUCH(a.m_nABO,0);
end;



function CL3Export2MySQLModule.DeleteTUCHS() : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ���� ����� �����');
    m_pDB.MyDeleteTUCH(0, 0);
end;

function CL3Export2MySQLModule.DeleteTUCHByABON(a : SABON) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ���� ����� ����� �� �������� �' + IntToStr(a.m_nABOID));
    m_pDB.MyDeleteTUCH(a.m_nABO, 0);
end;

function CL3Export2MySQLModule.DeleteTUCH(t : STUCH) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ����� ����� ' + IntToStr(t.m_nTUCH) + ' VMID ' + IntToStr(t.m_nVMID) + ' �������� � ' + IntToStr(t.m_nABO-1));
    m_pDB.MyDeleteTUCH(t.m_nABO, t.m_nTUCH);
end;

function CL3Export2MySQLModule.DeleteValues(ds, de : TDateTime) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ������ ������� �� ���� ������ ����� � ' + DateToStr(ds) + ' �� '+DateToStr(de));
    m_pDB.MyDeleteValues(ds, de, 0, 0);
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ���������');
end;

function CL3Export2MySQLModule.DeleteValuesByABON(ds, de : TDateTime; a : SABON) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ������ �� �������� �' + IntToStr(a.m_nABOID));
    m_pDB.MyDeleteValues(ds, de, a.m_nABO, 0);
end;

function CL3Export2MySQLModule.DeleteValuesByTUCH(ds, de : TDateTime; t : STUCH) : Boolean;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> �������� ������ ����� ����� ' + IntToStr(t.m_nTUCH) + ' VMID ' + IntToStr(t.m_nVMID) + ' �������� � ' + IntToStr(t.m_nABO-1));
    m_pDB.MyDeleteValues(ds, de, t.m_nABO, t.m_nTUCH);
end;

function CL3Export2MySQLModule.ExportValues(ds, de : TDateTime) : Boolean;
var
    nAboIT  : Integer;
    nTuchIT : Integer;
    ni, it  : Integer;
    sTable  : L3GRAPHDATASMY;
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ������ � ' + DateTimeToStr(ds) + ' �� ' +DateTimeToStr(de));
    TraceL(3,0,'(__)CEXMD::> in ExportData');
    if (not m_boIsConnected) then
    begin
        TraceL(3,0,'(__)CEXMD::> Is Disconnected!');
        exit;
    end;
    m_boEnabled := false;
    ReplaceTime(ds, 0);
    try
    DeleteValues(ds, de);

    for nAboIT:=0 to m_nAbonentsCount-1 do
    begin
        for nTuchIT:=0 to m_pAbonents[nAboIT].Count-1 do
        begin
            // ������� ��������� 30��� ������ �� ��������� �����
            if (true = m_pDB.GetGraphDatasMyExport(ds, de, m_pAbonents[nAboIT].Items[nTuchIT].m_nVMID, sTable)) then
            begin
                for ni := 0 to sTable.Count-1 do
                begin
                    m_pDB.MyPrepareMultiExec();
                    for it := 0 to 47 do
                    begin
                        sTable.Items[ni].m_swSumm := sTable.Items[ni].m_swSumm + sTable.Items[ni].v[it];
                        m_pDB.MyMakeInsertBUF_V_INT(m_pAbonents[nAboIT].Items[nTuchIT].m_nABO,
                                                m_pAbonents[nAboIT].Items[nTuchIT].m_nTUCH,
                                                sTable.Items[ni].m_swCMDID,
                                                sTable.Items[ni].m_sdtDate,
                                                it + 1,
                                                sTable.Items[ni].v[it],
                                                sTable.Items[ni].m_swSumm,
                                                sTable.Items[ni].v[it]);
                    end;
                    m_pDB.MyMultiExec();
                    WaitForSingleObject(w_mGEvent0,1);
                end;
            end;
        end;
        m_dtLast := de;
    end;
    except
        m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������ ��� �������� ������');
        m_boEnabled := true;
    end;
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ������ ��������');
    m_plbComplete.Caption := TimeToStr(Now());
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
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ��������');
    m_boEnabled := True;
end;

procedure CL3Export2MySQLModule.OnExportOff();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������� ��������');
    m_boEnabled := false;
end;

procedure CL3Export2MySQLModule.OnExportInit();
begin
    m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> ������������� ��������');
    ReInit();
end;


end.
