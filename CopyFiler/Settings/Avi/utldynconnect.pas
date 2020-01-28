unit utldynconnect;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate;
type
    CDBDynamicConn = class
    private
     m_strProvider   : String;
     m_strFileName   : String;
     m_nCurrentConnection : Integer;
     m_byConnectionLevel  : Integer;
     FFileIndex      : Integer;
     FADOConnection  : TADOConnection;
     FADOQuery       : TADOQuery;
     sCS             : TCriticalSection;
    public
     procedure Init(strFileName:String);
     function  Connect:Boolean;
     function  Disconnect:Boolean;
     procedure CreateConnection(var vConn:TADOConnection;var vQry:TADOQuery);
     procedure DestroyConnection(var vConn:TADOConnection;var vQry:TADOQuery);
     function  ExecQry(strSQL:String):Boolean;
     function  OpenQry(strSQL:String;var nCount:Integer):Boolean;
     procedure CloseQry;
     //Function
     function LoadReportParams(var pTable : REPORT_F1):boolean;
     function SaveReportParams(var pTable : REPORT_F1):boolean;
     function GetVMetersTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
     function GetMeterTableForReport(GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
     function GetTMTarPeriodsTable(nIndex:Integer;var pTable:TM_TARIFFS):Boolean;
     function GetGroupsTable(var pTable:SL3INITTAG):Boolean;

     function GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
     function GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
     function GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
     function GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
    End;
implementation

procedure CDBDynamicConn.Init(strFileName:String);
var
    Fl: TINIFile;
Begin
    m_strFileName := strFileName;
    Fl := TINIFile.Create(strFileName);
    sCS:=TCriticalSection.Create;
    m_strProvider        := Fl.ReadString('DBCONFIG', 'DBProvider', '');
    m_nCurrentConnection := Fl.ReadInteger('DBCONFIG','CurrentConnection', 0);
    FFileIndex           := Fl.ReadInteger('DBCONFIG','FFileIndex', 0);
    m_byConnectionLevel  := 1;
    Fl.Destroy;
End;
function CDBDynamicConn.Connect:Boolean;
Begin
    Result := True;
    try
     CreateConnection(FADOConnection,FADOQuery);
    except
     TraceER('(__)CERMD::>Error In CDBDynamicConn.Connect!!!');
    end;
End;
function CDBDynamicConn.Disconnect:Boolean;
Begin
    Result := True;
    try
     DestroyConnection(FADOConnection,FADOQuery);
    except
     TraceER('(__)CERMD::>Error In CDBDynamicConn.Disconnect!!!');
    end;
End;
procedure CDBDynamicConn.CreateConnection(var vConn:TADOConnection;var vQry:TADOQuery);
Begin
    if vConn=Nil then
    Begin
     vConn := TADOConnection.Create(Nil);
     vConn.ConnectionString := m_strProvider;
     vConn.LoginPrompt      := False;
     vConn.Connected        := true;
     if vQry=Nil then
     Begin
      vQry := TADOQuery.Create(Nil);
      vQry.ConnectionString := m_strProvider;
     End;
    End;
End;
procedure CDBDynamicConn.DestroyConnection(var vConn:TADOConnection;var vQry:TADOQuery);
Begin
    if vConn<>Nil then
    Begin
     vConn.Destroy;
     vConn := Nil;
     if vQry<>Nil then
     Begin
      vQry.Destroy;
      vQry := Nil;
     End;
    End;
End;
function CDBDynamicConn.ExecQry(strSQL:String):Boolean;
Var
    res : Boolean;
Begin
    res := True;
    try
    sCS.Enter;
    FADOConnection.BeginTrans;
     FADOQuery.Close;
     FADOQuery.SQL.Clear;
     FADOQuery.SQL.Add(strSQL);
     FADOQuery.ExecSQL;
     FADOQuery.Close;
    FADOConnection.CommitTrans;
    sCS.Leave;
   except
    FADOConnection.RollbackTrans;
    sCS.Leave;
    res := False;
   end;
   Result := res;
End;
function CDBDynamicConn.OpenQry(strSQL:String;var nCount:Integer):Boolean;
Var
    res : Boolean;
Begin
    res    := False;
    nCount := 0;
    try
     FADOQuery.SQL.Clear;
     FADOQuery.SQL.Add(strSQL);
     FADOQuery.Open;
     if FADOQuery.RecordCount>0 then  Begin nCount := FADOQuery.RecordCount; res := True;End;
    except
     res := False;
    end;
    Result := res;
End;
procedure CDBDynamicConn.CloseQry;
Begin
    FADOQuery.Close;
End;
//Dynamic Report

function CDBDynamicConn.GetGroupsTable(var pTable:SL3INITTAG):Boolean;
Var
    strSQL   : String;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT * FROM SL3INITTAG';res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FADOQuery,pTable do
     Begin
      m_sbyLayerID := FieldByName('m_sbyLayerID').AsInteger;
      m_swAmGroup  := FieldByName('m_swAmGroup').AsInteger;
     End;
    CloseQry;
    strSQL := 'SELECT * FROM SL3GROUPTAG ORDER BY m_sbyGroupID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i := 0;
     SetLength(pTable.m_sGroups,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sGroups[i] do Begin
      m_sbyID         := FieldByName('m_sbyID').AsInteger;
      m_sbyGroupID    := FieldByName('m_sbyGroupID').AsInteger;
      m_swAmVMeter    := FieldByName('m_swAmVMeter').AsInteger;
      m_sGroupName    := FieldByName('m_sGroupName').AsString;
      m_sGroupExpress := FieldByName('m_sGroupExpress').AsString;
      m_sbyEnable     := FieldByName('m_sbyEnable').AsInteger;
      Inc(i);
      Next;
     End;
     End;
    res := True;
    End;
    CloseQry;
   Result := res;
   End;
End;
function CDBDynamicConn.LoadReportParams(var pTable : REPORT_F1):boolean;
Var
    strSQL   : String;
    nCount   : integer;
    res      : boolean;
begin
   strSQL := 'SELECT * FROM REPORT_F1';
   if OpenQry(strSQL,nCount)=True then
   Begin
    pTable.m_swID         := FADOQuery.FieldByName('m_swID').AsInteger;
    pTable.m_sWorkName    := FADOQuery.FieldByName('m_sWorkName').AsString;
    pTable.m_sFirstSign   := FADOQuery.FieldByName('m_sFirstSign').AsString;
    pTable.m_sSecondSign  := FADOQuery.FieldByName('m_sSecondSign').AsString;
    pTable.m_swColorCol   := FADOQuery.FieldByName('m_swColorCol').AsInteger;
    pTable.m_swColorRow   := FADOQuery.FieldByName('m_swColorRow').AsInteger;
   End;
   CloseQry;
   Result := res;
end;

function CDBDynamicConn.SaveReportParams(var pTable : REPORT_F1):boolean;
Var
    strSQL   : String;
begin
   with pTable do
    Begin
       strSQL := 'UPDATE REPORT_F1 SET ' +
                 ' m_sWorkName = ' + '''' + m_sWorkName + '''' +
                 ' ,m_sFirstSign = ' + '''' + m_sFirstSign + '''' +
                 ' ,m_sSecondSign = ' + '''' + m_sSecondSign + '''' +
                 ' ,m_swColorCol = ' + IntToStr(m_swColorCol) +
                 ' ,m_swColorRow = ' + IntToStr(m_swColorRow) +
                 ' WHERE m_swID='+IntToStr(m_swID);
    end;
    Result := ExecQry(strSQL);
end;
function CDBDynamicConn.GetVMetersTable(nChannel:Integer;var pTable:SL3GROUPTAG):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    if nChannel<>-1 then strSQL := 'SELECT * FROM SL3VMETERTAG WHERE m_sbyGroupID='+IntToStr(nChannel)+ ' ORDER BY m_swVMID';
    if nChannel=-1  then strSQL := 'SELECT * FROM SL3VMETERTAG ORDER BY m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.m_swAmVMeter := nCount;
     SetLength(pTable.m_sVMeters,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.m_sVMeters[i] do  Begin
      m_swID        := FieldByName('m_swID').AsInteger;
      m_swMID       := FieldByName('m_swMID').AsInteger;
      m_sbyPortID   := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType     := FieldByName('m_sbyType').AsInteger;
      m_sbyGroupID  := FieldByName('m_sbyGroupID').AsInteger;
      m_swVMID      := FieldByName('m_swVMID').AsInteger;
      m_sddPHAddres := FieldByName('m_sddPHAddres').AsString;
      m_sMeterName  := FieldByName('m_sMeterName').AsString;
      m_sVMeterName := FieldByName('m_sVMeterName').AsString;
      m_sbyEnable   := FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetMeterTableForReport(GroupID : integer;var pTable : SL2TAGREPORTLIST) : boolean;
Var
    nCount,i : Integer;
    res      : Boolean;
    strSQL   : String;
begin
    res := False;
    if GroupID <> - 1 then
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                'L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname ' +
                'from SL3VMETERTAG, L2TAG, QM_METERS ' +
                'where l2tag.m_swmid = SL3VMETERTAG.m_swmid and QM_METERS.m_swtype = SL3VMETERTAG.m_sbytype' +
                ' and  SL3VMETERTAG.M_SBYGROUPID = ' + IntToStr(GroupID)
    else
      strSQL := 'SELECT SL3VMETERTAG.m_svmetername, L2TAG.M_SDDFABNUM, SL3VMETERTAG.m_swvmid, '+
                'L2TAG.M_SWMID, M_SFKI, M_SFKU, m_sname ' +
                'from SL3VMETERTAG, L2TAG, QM_METERS ' +
                'where l2tag.m_swmid = SL3VMETERTAG.m_swmid and QM_METERS.m_swtype = SL3VMETERTAG.m_sbytype';
    i := 0;
    if OpenQry(strSQL,nCount)=True then
    Begin
     pTable.Count := nCount;
     SetLength(pTable.m_sMeter, nCount);
     while not FADOQuery.Eof do
     begin
       with FADOQuery,pTable.m_sMeter[i] do
       Begin
         m_sVMeterName := FieldByName('m_svmetername').AsString;
         m_sddPHAddres := FieldByName('M_SDDFABNUM').AsString;
         m_swVMID      := FieldByName('m_swvmid').AsInteger;
         m_swMID       := FieldByName('M_SWMID').AsInteger;
         m_sfKI        := FieldByName('M_SFKI').AsFloat;
         m_sfKU        := FieldByName('M_SFKU').AsFloat;
         m_sName       := FieldByName('m_sname').AsString;
         Inc(i);
         Next;
       End;
     end;
     res := True;
    End;
    CloseQry;
    Result := res;
end;
function CDBDynamicConn.GetTMTarPeriodsTable(nIndex:Integer;var pTable:TM_TARIFFS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
    res := False;
    strSQL := 'SELECT * FROM TM_TARIFF WHERE m_swTTID='+IntToStr(nIndex)+' ORDER BY m_swTID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     i:=0;res := True;
     pTable.Count := nCount;
     SetLength(pTable.Items,nCount);
     while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID     := FieldByName('m_swID').AsInteger;
      m_swPTID   := FieldByName('m_swPTID').AsInteger;
      m_swTTID   := FieldByName('m_swTTID').AsInteger;
      m_swTID    := FieldByName('m_swTID').AsInteger;
      m_sName    := FieldByName('m_sName').AsString;
      m_dtTime0  := FieldByName('m_dtTime0').AsDateTime;
      m_dtTime1  := FieldByName('m_dtTime1').AsDateTime;
      m_sfKoeff  := FieldByName('m_sfKoeff').AsFloat;
      m_sbyEnable:= FieldByName('m_sbyEnable').AsInteger;
      Next;
      Inc(i);
      End;
     End;
    End;
    CloseQry;
    Result := res;
End;
//Dynamic Function CRC
function CDBDynamicConn.GetGData(dtP0,dtP1:TDateTime;FKey,PKey,TID:Integer;var pTable:CCDatas):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
     if TID = 0 then
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime'
     else
       strSQL := 'SELECT m_sTime,m_sfValue,m_swTID'+
                 ' FROM L3ARCHDATA'+
                 ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and '+
                 'm_swTID='+IntToStr(TID)+ ' and ' +
                 ' CAST(m_sTime AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sTime';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      m_swTID      := FieldByName('m_swTID').AsInteger;
      m_sTime      := FieldByName('m_sTime').AsDateTime;
      m_sfValue    := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetGraphDatas(dtP0,dtP1:TDateTime;FKey,PKey:Integer;var pTable:L3GRAPHDATAS):Boolean;
Var
    strSQL,strV : AnsiString;
    res         : Boolean;
    nCount,i,j  : Integer;
Begin
     strSQL := 'SELECT *' +
     ' FROM L2HALF_HOURLY_ENERGY'+
     ' WHERE m_swVMID='+IntToStr(FKey)+' and m_swCMDID='+IntToStr(PKey)+' and'+
     ' CAST(m_sdtDate AS DATE) BETWEEN '+ ''''+DateToStr(dtP1)+''''+ ' and ' +''''+DateToStr(dtP0)+''''+' ORDER BY m_sdtDate';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID       := i;
      //m_sdtLastTime  := FieldByName('m_sdtLastTime').AsDateTime;
      m_sdtDate      := FieldByName('m_sdtDate').AsDateTime;
      m_swSumm       := FieldByName('m_swSumm').AsFloat;
      for j:=0 to 47 do v[j] := FieldByName('v'+IntToStr(j)).AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex);
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
function CDBDynamicConn.GetTariffData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
Var
    strSQL   : AnsiString;
    res      : Boolean;
    nCount,i : Integer;
Begin
    strSQL := 'SELECT *'+
    ' FROM L3CURRENTDATA WHERE m_swVMID='+IntToStr(FIndex)+
    ' and m_swCMDID='+IntToStr(FCmdIndex)+' and m_swTID<>0 ORDER BY m_swTID';
    res := False;
    if OpenQry(strSQL,nCount)=True then
    Begin
    i := 0;
    res := True;
    pTable.Count := nCount;
    SetLength(pTable.Items,nCount);
    while not FADOQuery.Eof do Begin
     with FADOQuery,pTable.Items[i] do  Begin
      m_swID    := i;
      m_swVMID  := FieldByName('m_swVMID').AsInteger;
      m_swTID   := FieldByName('m_swTID').AsInteger;
      m_swCMDID := FieldByName('m_swCMDID').AsInteger;
      m_sTime   := FieldByName('m_sTime').AsDateTime;
      m_sfValue := FieldByName('m_sfValue').AsFloat;
      Next;
      Inc(i);
     End;
    End;
    End;
    CloseQry;
    Result := res;
End;
end.
