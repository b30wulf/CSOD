unit knsl2querybytunloader;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
controls,knsl3EventBox,utldatabase,utldynconnect,utlTimeDate,ShellAPI,forms,
knsl5config, ADOdb, ActiveX,Dialogs,AdvOfficeStatusBar,UtlDB;
type
  ExportRec = record
    LIC_CH,FIO,NAM_PUNK,NAS_STR,DOM,KORP,KVAR,NOM_SCH :String;
    STAMP,D1,D2 :TDateTime;
    VAL_K1,VAL_MAX1,VAL_MIN1,VAL_MINN1, VAL_MAXX1, VAL_K2, VAL_MAX2, VAL_MIN2, VAL_MINN2, VAL_MAXX2,
    R_MAX,R_MIN,R_MINN, R_MAXX, R_ALL :Double;
    KFTRN :Integer;
  end;

    CBytUnloader = class
    private
     m_nTbl : QGPARAM;
     FConnMySql,
     FConnDBF :TADOConnection;
     FQueryMySql,
     FQueryDBF :TADOQuery;
     FNoFabNumFileName : String;
     function CopyBase(strSrc,strDst:String):Boolean;
     function GetLastDate:TDateTime;
     function ExportData(ds, de : TDateTime) : Boolean;
     procedure GetSQLMogilev(QGID : Integer; de : TDate; NamePath : string);
    {$IFDEF HOMEL} function ExportFile (pTableExport :SL2INITITAG):Boolean;{$ENDIF}
     function ConnectToMySql() :Boolean;
     procedure CloseConnectToMySql();
     procedure ExportLineToMySql(var aExportRec :ExportRec);
     function ConnectToDBF(const aDir, aTable :String) :Boolean;
     procedure CloseConnectToDBF();
     procedure ExportLineToDBF(var aExportRec :ExportRec; const aTable :String);
     procedure SetProgressIMport(nPRC:Integer);     
    public
     constructor Create(var pTbl:QGPARAM);
     destructor Destroy();override;
     procedure onExport;

    End;

implementation

uses knsl5module;

// ----------------------------------------------------------------------
constructor CBytUnloader.Create(var pTbl:QGPARAM);
Begin
  m_nTbl := pTbl;
 {$IFDEF HOMEL}
  OleInitialize(nil);
 {$ENDIF}
End;
// ----------------------------------------------------------------------
destructor CBytUnloader.Destroy();
Begin
  if FQueryMySql <> nil then FreeAndNil(FQueryMySql);
  if FConnMySql <> nil then FreeAndNil(FConnMySql);
  if FQueryDBF <> nil then FreeAndNil(FQueryDBF);
  if FConnDBF <> nil then FreeAndNil(FConnDBF);
  {$IFDEF HOMEL}
  OleUnInitialize;
  {$ENDIF}
  inherited;
End;
// ----------------------------------------------------------------------
function GetSqlValue(aStr :String; const aLeftLength :Integer) :String;
var
  I :Integer;
  M :Byte;
const
  O = #0#8#9#$0A#$0D#$1A'\"'''{TEST STRING};
  N = '0btnrZ\"''';
begin
  Result := '';  // Должно быть обязательно

  aStr := Copy(aStr, 1, aLeftLength);

  for I := 1 to Length(aStr) do begin
    M := Pos(aStr[I], O);
    if M > 0 then Result := Result + '\' + N[M]
    else Result := Result + aStr[I];
  end;
end;

function GetSqlDecimal(const D :Double): String;
begin
  Result := StringReplace(FloatToStr(D), DecimalSeparator, '.', [rfReplaceAll]);
end;
// ----------------------------------------------------------------------
const
  sFormatAnsiDate = 'yyyymmdd';
  sFormatDBFDate = 'dd.mm.yyyy';
// ----------------------------------------------------------------------
function CBytUnloader.ConnectToMySql() :Boolean;
begin
  Result := False;

  if knsl5config.m_nCF = nil then Exit;

  if FQueryMySql <> nil then FQueryMySql.Close;

  if FConnMySql = nil then
    FConnMySql := TADOConnection.Create(nil)
  else
    FConnMySql.Close;

  if FQueryMySql = nil then FQueryMySql := TADOQuery.Create(nil);

  FQueryMySql.Connection := FConnMySql;

  FConnMySql.ConnectionString :=
    Format('Driver=MySQL ODBC 5.1 Driver;Server=%s;Port=%d;Database=%s;Uid=%s;Pwd=%s;Option=71829522;',
           [m_nCF.m_pGenTable.m_SDBSERVER,
            m_nCF.m_pGenTable.m_SDBPORT,
            m_nCF.m_pGenTable.m_sDBNAME,
            m_nCF.m_pGenTable.m_sDBUSR,
            m_nCF.m_pGenTable.m_sDBPASSW]);
  FConnMySql.LoginPrompt := False;
  FConnMySql.Open();
  Result := FConnMySql.Connected;
end;
// ----------------------------------------------------------------------
function CBytUnloader.ConnectToDBF(const aDir, aTable :String) :Boolean;
begin
  Result := False;

  if knsl5config.m_nCF = nil then Exit;

  if FQueryDBF <> nil then FQueryDBF.Close;

  if FConnDBF = nil then
    FConnDBF := TADOConnection.Create(nil)
  else
    FConnDBF.Close;

  if FQueryDBF = nil then FQueryDBF := TADOQuery.Create(nil);

  FQueryDBF.Connection := FConnDBF;

  FConnDBF.ConnectionString:= Format('Provider=MSDASQL.1;Persist Security Info=False;'
                                   + 'Extended Properties="DRIVER={Microsoft dBase Driver (*.dbf)};UID=;'
                                   + 'DefaultDir=%s;SourceType=DBF;Exclusive=No;BackgroundFetch=Yes;Collate=Machine;Null=Yes;Deleted=Yes;";Locale Identifier=1049',
                                   [aDir]);

(*  !!! ПРИМЕРЫ
1.
Provider=MSDASQL.1;Persist Security Info=False;Connect Timeout=15;Extended Properties="Driver={Microsoft FoxPro VFP Driver (*.dbf)};UID=;SourceDB=c:\FCB\BASE;SourceType=DBF;Exclusive=No;BackgroundFetch=Yes;Collate=Machine;Null=Yes;Deleted=Yes;";Locale Identifier=1049

Таблица открывается (первый байт заголовка равен $30)

Второй вариант тоже открывает
2.
Provider=MSDASQL.1;Persist Security Info=False;Connect Timeout=15;Extended Properties="CollatingSequence=ASCII;DBQ=c:\FCB\BASE;DefaultDir=c:\FCB\BASE;Deleted=0;Driver={Microsoft dBase Driver (*.dbf)};DriverId=533;FIL=dBase 5.0;FILEDSN=C:\Program Files\Common Files\ODBC\Data Sources\ttt.dsn;MaxBufferSize=2048;MaxScanRows=8;PageTimeout=5;SafeTransactions=0;Statistics=0;Threads=3;UID=admin;UserCommitSync=Yes;";Locale Identifier=1049
*)


  FConnDBF.LoginPrompt := False;
  FConnDBF.Open();
  Result := FConnDBF.Connected;

  DeleteFile(aDir + '\' + aTable + '.dbf');

  FQueryDBF.SQL.Clear;
  FQueryDBF.SQL.Add(Format('CREATE TABLE %s ('
    + 'LIC_CH CHAR(20),'
    + 'FIO CHAR(40),'
    + 'NAM_PUNK CHAR(20),'
    + 'NAS_STR CHAR(20),'
    + 'DOM CHAR(5),'
    + 'KORP CHAR(4),'
    + 'KVAR CHAR(4),'
    + 'STAMP DATE,'
    + 'NOM_SCH CHAR(20),'
    + 'D1 DATE,'
    + 'D2 DATE,'
    + 'VAL_K1 DOUBLE,'
    + 'VAL_MAX1 DOUBLE,'
    + 'VAL_MIN1 DOUBLE,'
    + 'VAL_MAXX1 DOUBLE,'
    + 'VAL_MINN1 DOUBLE,'
    + 'VAL_K2 DOUBLE,'
    + 'VAL_MAX2 DOUBLE,'
    + 'VAL_MIN2 DOUBLE,'
    + 'VAL_MAXX2 DOUBLE,'
    + 'VAL_MINN2 DOUBLE,'
    + 'R_MAX DOUBLE,'
    + 'R_MIN DOUBLE,'
    + 'R_MAXX DOUBLE,'
    + 'R_MINN DOUBLE,'
    + 'R_ALL DOUBLE,'
    + 'KFTRN INTEGER'
    + ')',
    [aTable]));
  FQueryDBF.ExecSQL;
end;
// ----------------------------------------------------------------------
procedure CBytUnloader.CloseConnectToMySql();
begin
  if FQueryMySql <> nil then begin
    FQueryMySql.Close();
    FreeAndNil(FQueryMySql);
  end;

  if FConnMySql <> nil then begin
    FConnMySql.Close();
    FreeAndNil(FConnMySql);
  end;
end;
// ----------------------------------------------------------------------
procedure CBytUnloader.CloseConnectToDBF();
begin
  if FQueryDBF <> nil then begin
    FQueryDBF.Close();
    FreeAndNil(FQueryDBF);
  end;

  if FConnDBF <> nil then begin
    FConnDBF.Close();
    FreeAndNil(FConnDBF);
  end;
end;
// ----------------------------------------------------------------------
procedure CBytUnloader.ExportLineToMySql(var aExportRec :ExportRec);
begin
  if FQueryMySql = nil then Exit;

  FQueryMySql.SQL.Clear;
  FQueryMySql.SQL.Add(Format('DELETE FROM asbyt_enrg '
    + 'WHERE LIC_CH="%s" and NOM_SCH="%s" and D1=%s and D2=%s',
    [GetSqlValue(aExportRec.LIC_CH, 20),
     GetSqlValue(aExportRec.NOM_SCH, 20),
     FormatDateTime(sFormatAnsiDate, aExportRec.D1),
     FormatDateTime(sFormatAnsiDate, aExportRec.D2)]));
  FQueryMySql.ExecSQL;

  FQueryMySql.SQL.Clear;
  FQueryMySql.SQL.Add(Format('INSERT INTO asbyt_enrg '
    + '(LIC_CH,FIO,NAM_PUNK,NAS_STR,DOM,KORP,KVAR,STAMP,NOM_SCH,D1,D2,VAL_K1,VAL_MAX1,VAL_MIN1,VAL_MAXX1,VAL_MINN1,VAL_K2,VAL_MAX2,VAL_MIN2,VAL_MAXX2,VAL_MINN2,R_MAX,R_MIN,R_MAXX,R_MINN,R_ALL,KFTRN) VALUES '
    + '("%s","%s","%s","%s","%s","%s","%s",%s,"%s",%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%d)',
    [GetSqlValue(aExportRec.LIC_CH, 20),
     GetSqlValue(aExportRec.FIO, 40),
     GetSqlValue(aExportRec.NAM_PUNK, 20),
     GetSqlValue(aExportRec.NAS_STR, 20),
     GetSqlValue(aExportRec.DOM, 5),
     GetSqlValue(aExportRec.KORP, 4),
     GetSqlValue(aExportRec.KVAR, 4),
     FormatDateTime(sFormatAnsiDate, aExportRec.STAMP),
     GetSqlValue(aExportRec.NOM_SCH, 20),
     FormatDateTime(sFormatAnsiDate, aExportRec.D1),
     FormatDateTime(sFormatAnsiDate, aExportRec.D2),
     GetSqlDecimal(aExportRec.VAL_K1),
     GetSqlDecimal(aExportRec.VAL_MAX1),
     GetSqlDecimal(aExportRec.VAL_MIN1),
     GetSqlDecimal(aExportRec.VAL_MAXX1),
     GetSqlDecimal(aExportRec.VAL_MINN1),
     GetSqlDecimal(aExportRec.VAL_K2),
     GetSqlDecimal(aExportRec.VAL_MAX2),
     GetSqlDecimal(aExportRec.VAL_MIN2),
     GetSqlDecimal(aExportRec.VAL_MAXX2),
     GetSqlDecimal(aExportRec.VAL_MINN2),
     GetSqlDecimal(aExportRec.R_MAX),
     GetSqlDecimal(aExportRec.R_MIN),
     GetSqlDecimal(aExportRec.R_MAXX),
     GetSqlDecimal(aExportRec.R_MINN),
     GetSqlDecimal(aExportRec.R_ALL),
     aExportRec.KFTRN]));
  FQueryMySql.ExecSQL;

  FQueryMySql.SQL.Clear;
  FQueryMySql.Close();
end;
// ----------------------------------------------------------------------
(*
Кодировка - Windows 1251.

Структура и описание полей:

LIC_CH   C(20) - лицевой счет абонента;
FIO      C(40) - ФИО абонента;
NAM_PUNK C(20) - наименование населенного пункта;
NAS_STR  C(20) - наименование улицы;
DOM      C(5) - номер дома;
KORP     C(4) - номер корпуса;
KVAR     C(4) - номер квартиры;
STAMP    D     - дата опроса (конец опрашиваемого периода +1 день);
NOM_SCH  C(20) - номер счетчика;
D1       D     - дата начала опрашиваемого периода на 00:00;
D2       D     - дата конца опрашиваемого периода на 24:00;
VAL_K1   N(16,5) - общее показание счетчика на начало опрашиваемого периода (Т1+Т2);
VAL_MAX1 N(16,5) - показание счетчика зоны MAX-нагрузки на начало опрашиваемого периода ( T1 – тариф 1);
VAL_MIN1 N(16,5) - показание счетчика зоны MIN-нагрузки на начало опрашиваемого периода ( T2 - тариф 2);
VAL_MINN1N(16,5) - показание счетчика зоны MIN-нагрузки на начало опрашиваемого периода ( T3 - тариф 3);
VAL_MAXX1N(16,5) - показание счетчика зоны MAX-нагрузки на начало опрашиваемого периода ( T4 – тариф 4);
VAL_K2   N(16,5) - общее показание счетчика на конец опрашиваемого периода;
VAL_MAX2 N(16,5) - показание счетчика зоны MAX-нагрузки на конец опрашиваемого периода ( T1 );
VAL_MIN2 N(16,5) - показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T2 );
VAL_MINN2N(16,5) - показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T3 );
VAL_MAXX2N(16,5) - показание счетчика зоны MAX-нагрузки на конец опрашиваемого периода ( T4 );
R_MAX    N(16,5) - расход (кВт.ч) по дифференцированному учет пиковой зоны ( T1 );
R_MIN    N(16,5) - расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T2 );
R_MAXX   N(16,5) - расход (кВт.ч) по дифференцированному учет пиковой зоны ( T3 );
R_MINN   N(16,5) - расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T4 );
R_ALL    N(16,5) - общий расход (кВт.ч) по всем тарифным учетам;
KFTRN    N(6)  - коэфициент трансформации.
*)
// ----------------------------------------------------------------------
procedure CBytUnloader.ExportLineToDBF(var aExportRec :ExportRec; const aTable :String);
begin
  if FQueryDBF = nil then Exit;

  FQueryDBF.SQL.Clear;

  FQueryDBF.SQL.Add(Format('INSERT INTO %s '
     //+ '(LIC_CH,FIO,NAM_PUNK,NAS_STR,DOM,KORP,KVAR,STAMP,NOM_SCH,D1,D2,VAL_K1,VAL_MAX1,VAL_MIN1,VAL_K2,VAL_MAX2,VAL_MIN2,R_MAX,R_MIN,R_ALL,KFTRN) VALUES '
     //+ '(''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',%d)',
    + '(LIC_CH,FIO,NAM_PUNK,NAS_STR,DOM,KORP,KVAR,STAMP,NOM_SCH,D1,D2,VAL_K1,VAL_MAX1,VAL_MIN1,VAL_MAXX1,VAL_MINN1,VAL_K2,VAL_MAX2,VAL_MIN2,VAL_MAXX2,VAL_MINN2,R_MAX,R_MIN,R_MAXX,R_MINN,R_ALL,KFTRN) VALUES '
    + '(''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',%s,''%s'',%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%d)',
    [aTable,
     GetSqlValue(aExportRec.LIC_CH, 20),
     GetSqlValue(aExportRec.FIO, 40),
     GetSqlValue(aExportRec.NAM_PUNK, 20),
     GetSqlValue(aExportRec.NAS_STR, 20),
     GetSqlValue(aExportRec.DOM, 5),
     GetSqlValue(aExportRec.KORP, 4),
     GetSqlValue(aExportRec.KVAR, 4),
     FormatDateTime(sFormatDBFDate, aExportRec.STAMP),
     GetSqlValue(aExportRec.NOM_SCH, 20),
     FormatDateTime(sFormatDBFDate, aExportRec.D1),
     FormatDateTime(sFormatDBFDate, aExportRec.D2),
{     GetSqlDecimal(aExportRec.VAL_K1),
     GetSqlDecimal(aExportRec.VAL_MAX1),
     GetSqlDecimal(aExportRec.VAL_MIN1),
     GetSqlDecimal(aExportRec.VAL_K2),
     GetSqlDecimal(aExportRec.VAL_MAX2),
     GetSqlDecimal(aExportRec.VAL_MIN2),
     GetSqlDecimal(aExportRec.R_MAX),
     GetSqlDecimal(aExportRec.R_MIN),
     GetSqlDecimal(aExportRec.R_MAXX),
     GetSqlDecimal(aExportRec.R_MINN),
     GetSqlDecimal(aExportRec.R_ALL),
     aExportRec.KFTRN]));  }
     GetSqlDecimal(aExportRec.VAL_K1),
     GetSqlDecimal(aExportRec.VAL_MAX1),
     GetSqlDecimal(aExportRec.VAL_MIN1),
     GetSqlDecimal(aExportRec.VAL_MAXX1),
     GetSqlDecimal(aExportRec.VAL_MINN1),
     GetSqlDecimal(aExportRec.VAL_K2),
     GetSqlDecimal(aExportRec.VAL_MAX2),
     GetSqlDecimal(aExportRec.VAL_MIN2),
     GetSqlDecimal(aExportRec.VAL_MAXX2),
     GetSqlDecimal(aExportRec.VAL_MINN2),
     GetSqlDecimal(aExportRec.R_MAX),
     GetSqlDecimal(aExportRec.R_MIN),
     GetSqlDecimal(aExportRec.R_MAXX),
     GetSqlDecimal(aExportRec.R_MINN),
     GetSqlDecimal(aExportRec.R_ALL),
     aExportRec.KFTRN]));
  if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,FQueryDBF.SQL.Strings[0]);     
  FQueryDBF.ExecSQL;

  FQueryDBF.SQL.Clear;
  FQueryDBF.Close();

end;
procedure CBytUnloader.onExport;
Begin
    ExportData(GetLastDate,Now);
End;
{$IFDEF BARANOVICHI}
function CBytUnloader.ExportData(ds, de : TDateTime) : Boolean;
var
    i, nAID,k : Integer;
    l_Ys, l_Ms, l_Ds,
    l_Ye, l_Me, l_De : WORD;
    strLine, strFileName : String;
    pTable  :SL3ExportMOGBS;
    mPidFile: TextFile;
    pDb     : CDBDynamicConn;
    strDate : String;
    pTbl    : TThreadList;
    vList   : TList;
    data    : qgabons;
    uuidNamePath : String;
    vData :Double;
    sData :String;
    vTar :Byte;
const
  maxNumOfTar = 4;
begin
    DecodeDate(ds, l_Ys, l_Ms, l_Ds); l_Ds := 1;
    ds := EncodeDate(l_Ys, l_Ms, l_Ds);
    DecodeDate(de, l_Ye, l_Me, l_De); l_De := 1;
    de := EncodeDate(l_Ye, l_Me, l_De);
    try
    pDb  := m_pDB.getConnection;
    while(cDateTimeR.CompareMonth(ds, de) <> 1) do
    begin
      strFileName := FormatDateTime('"konus_db_"yyyy-mm-dd_hh-nn-ss',(de-1))+'.txt';
      uuidNamePath:= ExtractFilePath(Application.ExeName)+'\Archive\'+IntToStr(random(9999999999))+'.obh';
      AssignFile(mPidFile,uuidNamePath);
      Rewrite(mPidFile);
      if m_nTbl.UNPATH<>''then if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Экспорт в '+m_nTbl.UNPATH+'\'+strFileName+' за '+DateToStr(de));
      pTbl := TThreadList.Create;
      m_nTbl.ISRUNSTATUS:=0;
      m_nTbl.RUNSTATUS:='';
      if pDb.GetQueryAbons(m_nTbl,-1,pTbl)=True then
      Begin
      vList := pTbl.LockList;
      for k:=0 to vList.Count-1 do
      Begin
      data := vList[k];
      nAID := data.ABOID;
      if pDb.GetMogBitData(nAID,de,pTable) then
       Begin
        strLine := '';
        for i:=0 to pTable.Count-1 do
        Begin
           Application.ProcessMessages;

           strDate := FormatDateTime('dd.mm.yyyy hh:nn:ss',pTable.Items[i].m_dtDate-1);

           for vTar := 0 to maxNumOfTar do begin
             case vTar of
               0: vData := pTable.Items[i].m_dbDataT0;
               1: vData := pTable.Items[i].m_dbDataT1;
               2: vData := pTable.Items[i].m_dbDataT2;
               3: vData := pTable.Items[i].m_dbDataT3;
               4: vData := pTable.Items[i].m_dbDataT4;
             else
               Assert(False);
             end;

             sData := FloatToStrF(vData,ffFixed,12,2);
             sData := StringReplace(sData, DecimalSeparator, ',', []);

             strLine :=Format('%.20s;%.20s;%d;%s;%s;;',
                              [pTable.Items[i].m_strTYPE,
                               pTable.Items[i].m_strFabNum,
                               vTar,
                               sData,
                               strDate]);

           WriteLn(mPidFile,strLine);
        end;

        end;
       End;
       End;
       pTbl.UnlockList;
       pTbl.Free();
      end;
      CloseFile(mPidFile);
      if m_nTbl.UNPATH<>'' then CopyBase(uuidNamePath,m_nTbl.UNPATH+'\'+strFileName);
      DeleteFile(uuidNamePath);
      cDateTimeR.DecMonth(de);
      end;
      m_pDB.DiscDynConnect(pDb);
     except
       CloseFile(mPidFile);
       m_pDB.DiscDynConnect(pDb);
       if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Error IN CSheduleCommand.ExportData !!! ');
       MessageDlg('Ошибка при выгрузке! Возможно ошибка в лицевых счетах обенента.',mtWarning,[mbOk],0);
     end;
end;
{$ELSE}
  {$IFDEF HOMEL}
// ----------------------------------------------------------------------
function CBytUnloader.ExportData(ds, de : TDateTime) : Boolean;
var
    FDat,i,j, ni,nAID,s0,s1,k : Integer;
    l_Ys, l_Ms, l_Ds,
    l_Ye, l_Me, l_De : WORD;
    strLineTarif,str,strFileName,vTableDbf : String;
    regNo   : String;
    pTable  :SL3ExportMOGBS;
    pTable1  :SL3ExportMOGBS;
    pTableExport  :SL2INITITAG;
    pDb     : CDBDynamicConn;
    strDate : String;
    nSumm   : Integer;
    pTbl    : TThreadList;
    vList   : TList;
    data    : qgabons;
    vExportRec :ExportRec;
    M_FIO,KV_NAME   :string;
    resTable :boolean;
    Dbegin: TDateTime;
begin
    Result := False;
    resTable:=False;
    ConnectToMySql();

    DecodeDate(ds, l_Ys, l_Ms, l_Ds); l_Ds := 1;
    ds := EncodeDate(l_Ys, l_Ms, l_Ds);
    DecodeDate(de, l_Ye, l_Me, l_De); l_De := 1;
    de := EncodeDate(l_Ye, l_Me, l_De);

    try
    pDb  := m_pDB.getConnection;
      while(cDateTimeR.CompareMonth(ds, de) <> 1) do
      begin
        vTableDbf := FormatDateTime('yymmdd',(de-1));
        strFileName := vTableDbf + '.dbf';
         if m_nTbl.UNPATH <> '' then begin
          ConnectToDBF(m_nTbl.UNPATH, vTableDbf);
         end;
        if m_nTbl.UNPATH<>''then if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Экспорт в '+m_nTbl.UNPATH+'\'+strFileName+' за '+DateToStr(de));
        pTbl := TThreadList.Create;
        m_nTbl.ISRUNSTATUS:=0;
        m_nTbl.RUNSTATUS:='';
        if pDb.GetQueryAbons(m_nTbl,-1,pTbl)=True then
        Begin
        vList := pTbl.LockList;
          for k:=0 to vList.Count-1 do
          Begin
            data := vList[k];
            nAID := data.ABOID;
               Dbegin:=de;
               cDateTimeR.DecMonth(Dbegin);

            pDb.GetMogBitDataMySqlExport(nAID,pTableExport);
            ExportFile(pTableExport);
            //if pDb.GetMogBitData(nAID,Dbegin,pTable1) then
            if pDb.GetMogBitDataMySql(nAID,Dbegin,pTable1) then
                resTable:=true
            else
                resTable:=false;
            //if pDb.GetMogBitData(nAID,de,pTable) then
            if pDb.GetMogBitDataMySql(nAID,de,pTable) then
             Begin
              strLineTarif := '';
              for i:=0 to pTable.Count-1 do
              Begin
                 Application.ProcessMessages;
                 nSumm := 0;
                 strLineTarif := '';
                 regNo := '4'+IntToStr(pTable.Items[i].m_wDEPID)+pTable.Items[i].m_strLicNb+'0'+'0';

                 strDate := FormatDateTime('dd/mm/yyyy',pTable.Items[i].m_dtDate);
                 strDate := StringReplace(strDate,'.','/',[rfReplaceAll]);

                 M_FIO:=pTable.Items[i].m_strFIO;
                 KV_NAME:=pTable.Items[i].m_strFIO;

                 s0:=pos('(',pTable.Items[i].m_strFIO);
                 s1:=pos(')',pTable.Items[i].m_strFIO);
                 if (s0>0) and (s1>0) then
                 Delete(M_FIO,s0,s1+1);

                 s0:=pos('(',pTable.Items[i].m_strFIO);
                 s1:=pos('/',pTable.Items[i].m_strFIO);
                 if (s0>0) and (s1>0) then
                 begin
                 Delete(KV_NAME,1,1);
                 Delete(KV_NAME,s1-1,Length(KV_NAME));
                 end;

                 with vExportRec do begin
                   LIC_CH := pTable.Items[i].m_strLicNb;
                   //FIO := pTable.Items[i].m_strFIO
                   if ((M_FIO<>'')and (M_FIO<>' ')) then
                    FIO := M_FIO
                   else
                    FIO := KV_NAME;

                   NAM_PUNK := pTable.Items[i].m_strTown;
                   NAS_STR := pTable.Items[i].m_strStreet;
                   DOM := pTable.Items[i].m_strHouse;
                   KORP := pTable.Items[i].m_strKorpus;
                   KVAR := pTable.Items[i].m_strKvNb;
                   STAMP := pTable.Items[i].m_dtDate;
                   NOM_SCH := pTable.Items[i].m_strFabNum;
                   D2 := pTable.Items[i].m_dtDate - 1;
                   DecodeDate(D2, l_Ys, l_Ms, l_Ds);
                   D1 := EncodeDate(l_Ys, l_Ms, 1);                                             // BO 18/07/19 и ниже
                   VAL_K2   := pTable.Items[i].m_dbDataT1 + pTable.Items[i].m_dbDataT2 +
                               pTable.Items[i].m_dbDataT3 + pTable.Items[i].m_dbDataT4;    //общее показание счетчика на начало опрашиваемого периода (Т1+Т2);
                   VAL_MAX2 := pTable.Items[i].m_dbDataT1;                          //показание счетчика зоны MAX-нагрузки на начало опрашиваемого периода ( T1 – тариф 1);
                   VAL_MIN2 := pTable.Items[i].m_dbDataT2;                          //показание счетчика зоны MIN-нагрузки на начало опрашиваемого периода ( T2 - тариф 2);
                   VAL_MAXX2:= pTable.Items[i].m_dbDataT3;                          //показание счетчика зоны MAX-нагрузки на начало опрашиваемого периода ( T3 - тариф 3);
                   VAL_MINN2:= pTable.Items[i].m_dbDataT4;                          //показание счетчика зоны MIN-нагрузки на начало опрашиваемого периода ( T4 - тариф 4);

      //                  VAL_K1,VAL_MAX1,VAL_MIN1,VAL_MINN1, VAL_MAXX1, VAL_K2,VAL_MAX2,VAL_MIN2,VAL_MINN2, VAL_MINN2, VAL_MAXX2,
      //    R_MAX,R_MIN,R_MINN, R_MAXX, R_ALL :Double;

                   if (resTable=false)then
                     begin
                       VAL_K1   := -1;   //общее показание счетчика на конец опрашиваемого периода;
                       VAL_MAX1 := -1;                          //показание счетчика зоны MAX-нагрузки на конец опрашиваемого
                       VAL_MIN1 := -1;                          //показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T2 );
                       VAL_MAXX1:= -1;                          //показание счетчика зоны MAX-нагрузки на конец опрашиваемого периода ( T3 );
                       VAL_MINN1:= -1;                          //показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T4 );
                       R_MAX := VAL_MAX2;                       //расход (кВт.ч) по дифференцированному учет пиковой зоны ( T1 );
                       R_MIN := VAL_MIN2;                      //расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T2 );
                       R_MAXX:= VAL_MAXX2;                      //расход (кВт.ч) по дифференцированному учет пиковой зоны ( T3 );
                       R_MINN:= VAL_MINN2;                      //расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T4 );
                       R_ALL := VAL_K2;                        //общий расход (кВт.ч) по всем тарифным учетам;
                     end
                   else
                     begin
                       VAL_K1   := -1;   //общее показание счетчика на конец опрашиваемого периода;
                       VAL_MAX1 := -1;                          //показание счетчика зоны MAX-нагрузки на конец опрашиваемого
                       VAL_MIN1 := -1;                          //показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T2 );
                                                           // BO 18/07/19 и ниже
                       VAL_MAXX1:= -1;                          //показание счетчика зоны MAX-нагрузки на конец опрашиваемого периода ( T3 );
                       VAL_MINN1:= -1;                          //показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T4 );
                       R_MAX := VAL_MAX2;                       //расход (кВт.ч) по дифференцированному учет пиковой зоны ( T1 );
                       R_MIN := VAL_MIN2;                      //расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T2 );
                       R_MAXX:= VAL_MAXX2;                      //расход (кВт.ч) по дифференцированному учет пиковой зоны ( T3 );
                       R_MINN:= VAL_MINN2;                      //расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T4 );
                       R_ALL := VAL_K2;                        //общий расход (кВт.ч) по всем тарифным учетам;
                        for j:=0 to pTable1.Count-1 do
                          begin
                            if (NOM_SCH=pTable1.Items[j].m_strFabNum)then
                                begin
                                 VAL_K1   := pTable1.Items[j].m_dbDataT1+pTable1.Items[j].m_dbDataT2+
                                             pTable1.Items[j].m_dbDataT3+pTable1.Items[j].m_dbDataT4;  //общее показание счетчика на конец опрашиваемого периода;

                                 VAL_MAX1 := pTable1.Items[j].m_dbDataT1;   //показание счетчика зоны MAX-нагрузки на конец опрашиваемого
                                 VAL_MIN1 := pTable1.Items[j].m_dbDataT2;   //показание счетчика зоны MIN-нагрузки на конец опрашиваемого периода ( T2 );
                                 VAL_MAXX1:= pTable1.Items[j].m_dbDataT3;   //показание счетчика зоны MAX-нагрузки на начало опрашиваемого периода ( T3 - тариф 3);
                                 VAL_MINN1:= pTable1.Items[j].m_dbDataT4;   //показание счетчика зоны MIN-нагрузки на начало опрашиваемого периода ( T4 - тариф 4);
                                 R_MAX := VAL_MAX2-VAL_MAX1;                //расход (кВт.ч) по дифференцированному учет пиковой зоны ( T1 );
                                 R_MIN := VAL_MIN2-VAL_MIN1;                //расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T2 );
                                 R_MAXX := VAL_MAXX2-VAL_MINN1;             //расход (кВт.ч) по дифференцированному учет пиковой зоны ( T3 );
                                 R_MINN := VAL_MINN2-VAL_MINN1;             //расход (кВт.ч) по дифференцированному учет внепиковой зоны ( T4 );
                                 R_ALL := VAL_K2- VAL_K1;                   //общий расход (кВт.ч) по всем тарифным учетам;
                                 break;
                                end;

                          end;
                     end;
                   // KFTRN := 1;
                   KFTRN := pTable.Items[i].KFTR;          //коэфициент трансформации
                 end;
                 ExportLineToMySql(vExportRec);
//               ExportLineToDBF(vExportRec, vTableDbf);
              end;
             End;
          End;
         pTbl.UnlockList;
        end;
        cDateTimeR.DecMonth(de);
        if m_nTbl.UNPATH <> '' then begin
          CloseConnectToDBF();
        end;
      end;
      m_pDB.DiscDynConnect(pDb);
      CloseConnectToMySql();
    except
     on E: Exception do begin
       m_pDB.DiscDynConnect(pDb);
       if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Error IN CSheduleCommand.ExportData !!! '+ E.Message);
       MessageDlg('Ошибка при выгрузке! Возможно ошибка в лицевых счетах обенента.',mtWarning,[mbOk],0);
       if pTbl<>nil then FreeAndNil(pTbl);
     end;
    end;
    if pTbl<>nil then FreeAndNil(pTbl);
end;

function CBytUnloader.ExportFile(pTableExport :SL2INITITAG):Boolean;
var
  i, LastRow  : Integer;
  SList       : TStringList;
  strFileName : String;
begin
  strFileName := FormatDateTime('"konus_db_"yyyy-mm-dd_hh-nn-ss',(Now))+'.txt';
  SList := TStringList.Create;
  LastRow := pTableExport.m_swAmMeter - 1;
  try
    for i := 0 to LastRow do
      SList.Add(pTableExport.m_sMeter[i].m_schName);  //  [i].CommaText);
//    SList.SaveToFile('C:\Directory\File.csv');
      SList.SaveToFile(m_nTbl.UNPATH+'\'+strFileName);
  finally
    SList.Free;
  end;
  Result:=True;
end;

  {$ELSE}
//
//function CBytUnloader.ExportData(ds, de : TDateTime) : Boolean;
//var
//    {FDat,}i,j, {ni,}nAID,s0,s1,k : Integer;
//    l_Ys, l_Ms, l_Ds,
//    l_Ye, l_Me, l_De : WORD;
//    strLine, strLineTarif,{str,}strFileName : String;
//    regNo   : String;
//    pTable  :SL3ExportMOGBS;
//    mPidFile: TextFile;
//    pDb     : CDBDynamicConn;
//    strDate : String;
//    nSumm   : Integer;
//    pTbl    : TThreadList;
//    vList   : TList;
//    data    : qgabons;
//    uuidNamePath : String;
//begin
//    FStatBar.Panels[7].Style:=psProgress;    //панель выгрузки
//    FStatBar.Panels[7].Progress.Position:=0;
//
//    DecodeDate(ds, l_Ys, l_Ms, l_Ds); l_Ds := 1;
//    ds := EncodeDate(l_Ys, l_Ms, l_Ds);
//    DecodeDate(de, l_Ye, l_Me, l_De); l_De := 1;
//    de := EncodeDate(l_Ye, l_Me, l_De);
//    try
//    pDb  := m_pDB.getConnection;
//    while(cDateTimeR.CompareMonth(ds, de) <> 1) do
//    begin
//      strFileName := FormatDateTime('yymmdd',(de-1))+'.obh';
//      uuidNamePath:= ExtractFilePath(Application.ExeName)+'\Archive\'+IntToStr(random(9999999999))+'.obh';
//      AssignFile(mPidFile,uuidNamePath);
//      Rewrite(mPidFile);
//      if m_nTbl.UNPATH<>''then if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Экспорт в '+m_nTbl.UNPATH+'\'+strFileName+' за '+DateToStr(de));
//      pTbl := TThreadList.Create;
//      m_nTbl.ISRUNSTATUS:=0;
//      m_nTbl.RUNSTATUS:='';
//      if pDb.GetQueryAbons(m_nTbl,-1,pTbl)=True then
//      Begin
//      vList := pTbl.LockList;
//      for k:=0 to vList.Count-1 do
//      Begin
//      data := vList[k];
//      nAID := data.ABOID;
//      SetProgressIMport(0+((k+1)*98 div vList.Count-1));
//      if pDb.GetMogBitData(nAID,de,pTable) then
//       Begin
//        strLine := '';
//        strLineTarif := '';
//        for i:=0 to pTable.Count-1 do
//        Begin
//           Application.ProcessMessages;
//           nSumm := 0;
//           strLineTarif := '';
//           regNo := '4'+IntToStr(pTable.Items[i].m_wDEPID)+pTable.Items[i].m_strLicNb+'0'+'0';
//           for j:=1 to Length(regNo) do
//            nSumm := nSumm + StrToInt(regNo[j]);
//            nSumm := nSumm mod 9;
//           regNo := regNo+IntToStr(nSumm);
//           strDate := FormatDateTime('dd/mm/yyyy',pTable.Items[i].m_dtDate-1);
//           strDate := StringReplace(strDate,'.','/',[rfReplaceAll]);
//           s0:=pos('(',pTable.Items[i].m_strFIO);
//           s1:=pos(')',pTable.Items[i].m_strFIO);
//           if (s0>0) and (s1>0) then
//           Delete(pTable.Items[i].m_strFIO,s0,s1);
//           strLine :=  strDate+';'+
//                       regNo+';'+
//                       pTable.Items[i].m_strLicNb+';'+
//                       pTable.Items[i].m_strFabNum+';'+
//                       pTable.Items[i].m_strFIO+';'+
//                       pTable.Items[i].m_strAddr+';'+
//                       FloatToStrF(pTable.Items[i].m_dbDataT1,ffFixed,10,0)+';'+
//                       FloatToStrF(pTable.Items[i].m_dbDataT2,ffFixed,10,0)+';'+
//                       FloatToStrF(pTable.Items[i].m_dbDataT3,ffFixed,10,0)+';'+
//                       FloatToStrF(pTable.Items[i].m_dbDataT4,ffFixed,10,0)+';';
//           CharToOem(PChar(StrLine),PChar(StrLine)); //кодировка Кирилица(DOS-866)
//           WriteLn(mPidFile,strLine);
//        end;
//       End;
//       End;
//       pTbl.UnlockList;
//      end;
//      CloseFile(mPidFile);
//      if m_nTbl.UNPATH<>'' then CopyBase(uuidNamePath,m_nTbl.UNPATH+'\'+strFileName);
//      DeleteFile(uuidNamePath);
//      cDateTimeR.DecMonth(de);
//      end;
//      m_pDB.DiscDynConnect(pDb);
//    except
//       CloseFile(mPidFile);
//       m_pDB.DiscDynConnect(pDb);
//       if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Error IN CSheduleCommand.ExportData !!! ');
//       MessageDlg('Ошибка при выгрузке! Возможно ошибка в лицевых счетах абонента.',mtWarning,[mbOk],0);
//
//       for k:=0 to vList.Count-1 do
//        Begin
//         data := vList[k];
//         FreeAndNil(data);
//        end;
//        vList.Clear;
//
//       if pTbl<>nil then FreeAndNil(pTbl);
//    end;
//
//    for k:=0 to vList.Count-1 do
//     Begin
//      data := vList[k];
//      FreeAndNil(data);
//     end;
//    vList.Clear;
//   if pTbl<>nil then FreeAndNil(pTbl);
//   FStatBar.Panels[7].Style:=psOwnerDraw;
//end;
// ----------------------------------------------------------------------

function CBytUnloader.ExportData(ds, de : TDateTime) : Boolean;
var
    i,j : Integer;
    l_Ys, l_Ms, l_Ds,
    l_Ye, l_Me, l_De : WORD;
    strFileName : String;
    mPidFile: TextFile;
    pDb     : CDBDynamicConn;
    uuidNamePath : String;
    DiffMonth, DM : Integer;
    value : Double;
begin
  DecodeDate(ds, l_Ys, l_Ms, l_Ds); l_Ds := 1;
  ds := EncodeDate(l_Ys, l_Ms, l_Ds);
  DecodeDate(de, l_Ye, l_Me, l_De); l_De := 1;
  de := EncodeDate(l_Ye, l_Me, l_De);
  DiffMonth := cDateTimeR.DifferenceMonth(ds, de);
  DM := DiffMonth;
  try
    pDb  := m_pDB.getConnection;
    while(cDateTimeR.CompareMonth(ds, de) <> 1) do begin
      strFileName := FormatDateTime('yymmdd',(de-1))+'.obh';
      uuidNamePath:= ExtractFilePath(Application.ExeName)+'Archive\'+IntToStr(random(9999999999))+'.obh';
      if m_nTbl.UNPATH<>''then EventBox.FixEvents(ET_RELEASE,'Экспорт в '+m_nTbl.UNPATH+'\'+strFileName+' за '+DateToStr(de));
      m_nTbl.ISRUNSTATUS:=0;
      m_nTbl.RUNSTATUS:='';
      GetSQLMogilev(m_nTbl.QGID, de, uuidNamePath);

      if m_nTbl.UNPATH<>'' then CopyBase(uuidNamePath,m_nTbl.UNPATH+'\'+strFileName);
      DeleteFile(uuidNamePath);
      cDateTimeR.DecMonth(de);
      dec(DM);
      value := ((DM+1)/(DiffMonth+1))*100;
    end;
    m_pDB.DiscDynConnect(pDb);
  except
    CloseFile(mPidFile);
    if pDb<>Nil then m_pDB.DiscDynConnect(pDb);
    if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Error IN CSheduleCommand.ExportData !!! ');
    MessageDlg('Ошибка при выгрузке! Возможно ошибка в лицевых счетах абонента.',mtWarning,[mbOk],0);
  end;
end;

  {$ENDIF}
{$ENDIF}

function CBytUnloader.CopyBase(strSrc,strDst:String):Boolean;
var
    OpStruc: TSHFileOpStruct;
    frombuf, tobuf: array [0..128] of Char;
    //x,y:string;
Begin
    try
    if FileExists(strSrc)=True then
    Begin
     FillChar(frombuf,Sizeof(frombuf),0);
     FillChar(tobuf  ,Sizeof(tobuf),0);
     StrPCopy(frombuf,strSrc);
     StrPCopy(tobuf  ,strDst);
     with OpStruc do
     begin
      //Wnd    := PForm.Handle;
      wFunc  := FO_COPY;
      pFrom  := @frombuf;
      pTo    := @tobuf;
      fFlags := FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION or FOF_SILENT;
      fAnyOperationsAborted := False;
      hNameMappings         := nil;
      lpszProgressTitle     := nil;
     end;
     ShFileOperation(OpStruc);
    End;
    except
     
    end;
End;

function CBytUnloader.GetLastDate:TDateTime;
Var
    {dtBegin,}dtEnd  : TDateTime;
    year,month,day : Word;
Begin
    //dtBegin:= Now;
    dtEnd  := Now;
    if m_nTbl.UNDEEPFIND=0 then
    Begin
     DecodeDate(dtEnd,year,month,day);
     dtEnd := EncodeDate(year,month,1);
    End else
    if (m_nTbl.UNDEEPFIND<>0)and(m_nTbl.UNDEEPFIND<>255) then dtEnd := dtEnd - DeltaFHF[m_nTbl.UNDEEPFIND];
    Result := dtEnd;
End;


function aGetm_strAddr(M_SDDHADR_HOUSE, M_SDDHADR_KV, townName, streetName, domName, TPNAME, am_strKvNb : string):string;
var    m_strAddr : string;
begin
    if (M_SDDHADR_HOUSE = '') and (M_SDDHADR_KV = '') then
      m_strAddr := 'г. ' + townName + ',' + ' ул. ' + streetName + ',' + ' ' + domName + ',' + ' кв. '+am_strKvNb
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV <> '') then
      m_strAddr := 'г. ' + townName + ',' + M_SDDHADR_HOUSE + ',' + ' кв. ' + M_SDDHADR_KV
    else if (M_SDDHADR_HOUSE <> '') and (M_SDDHADR_KV = '') then
      m_strAddr     := 'г. ' + townName + ',' + ' ' + TPNAME + ',' + ' '+M_SDDHADR_HOUSE;
  Result := m_strAddr;
end;


procedure CBytUnloader.GetSQLMogilev(QGID : Integer; de : TDate; NamePath : string);
var strSQL    : string;
    nCount, i : Integer;
    nSumm, j  : integer;
    strFIO    : string;
    strAddr   : string;
    nABOID    : Integer;
    dbDataT1  : Double;
    dbDataT2  : Double;
    dbDataT3  : Double;
    dbDataT4  : Double;
    dbDataT0  : Double;    
    strLicNb  : string;
    strFabNum : string;
    swTid     : Integer;
    strLine   : string;
    strTarif  : string;
    strDate   : string;
    regNo     : string;
    mPidFile  : TextFile;
    s0, s1    : Integer;
    yo        : integer;
begin
 try
   try
    AssignFile(mPidFile,NamePath);
    Rewrite(mPidFile);
    FStatBar.Panels[7].Style:=psProgress;    //панель выгрузки
    FStatBar.Panels[7].Progress.Position:=0;
    FStatBar.Panels[7].Progress.Level0Color:=$90EE90;
    FStatBar.Panels[7].Progress.Level1Color:=$90EE90;
    FStatBar.Panels[7].Progress.Level2Color:=$90EE90;
    FStatBar.Panels[7].Progress.Level3Color:=$90EE90;
    strSQL := 'SELECT * FROM UNLOADING_MOGILEV(' + IntToStr(QGID) + ', ' + '''' + DateToStr(de) + ''')';
    yo := -1;
    if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
      for i := 0 to nCount-1 do begin
      if (trunc((i+1)*100 / (nCount-1))) > yo then begin
        SetProgressIMport(trunc((i+1)*100 / (nCount-1)));
        Application.ProcessMessages;
        yo := (trunc((i+1)*100 / (nCount-1)));
      end;
        nSumm := 0;
        regNo := '4' + IntToStr(utlDB.DBase.IBQuery.FieldByName('CODE').AsInteger) +
                       utlDB.DBase.IBQuery.FieldByName('M_STPNUM').AsString + '0' + '0';
        for j:=1 to Length(regNo) do
          nSumm := nSumm + StrToInt(regNo[j]);
        nSumm := nSumm mod 9;
        regNo := regNo+IntToStr(nSumm);

        strDate := FormatDateTime('dd/mm/yyyy',de-1);
        strDate := StringReplace(strDate,'.','/',[rfReplaceAll]);
        strFIO := utlDB.DBase.IBQuery.FieldByName('M_SVMETERNAME').AsString;
        s0:=pos('(',strFIO);
        s1:=pos(')',strFIO);
        if (s0 > 0) and (s1 > 0) then Delete(strFIO, s0, s1);
        strLicNb  := utlDB.DBase.IBQuery.FieldByName('M_STPNUM').AsString;
        strFabNum := utlDB.DBase.IBQuery.FieldByName('M_SDDFABNUM').AsString;

        strAddr := aGetm_strAddr(utlDB.DBase.IBQuery.FieldByName('M_SDDHADR_HOUSE').AsString,
                                 utlDB.DBase.IBQuery.FieldByName('M_SDDHADR_KV').AsString,
                                 utlDB.DBase.IBQuery.FieldByName('townName').AsString,
                                 utlDB.DBase.IBQuery.FieldByName('streetName').AsString,
                                 utlDB.DBase.IBQuery.FieldByName('domName').AsString,
                                 utlDB.DBase.IBQuery.FieldByName('TPNAME').AsString,
                                 utlDB.DBase.IBQuery.FieldByName('M_SDDPHADDRES').AsString);


        if utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsFloat > 0 then begin
          dbDataT1 := utlDB.DBase.IBQuery.FieldByName('T1VALUE').AsFloat;///utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsFloat;
          dbDataT2 := utlDB.DBase.IBQuery.FieldByName('T2VALUE').AsFloat;///utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsFloat;
          dbDataT3 := utlDB.DBase.IBQuery.FieldByName('T3VALUE').AsFloat;///utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsFloat;
          dbDataT4 := utlDB.DBase.IBQuery.FieldByName('T4VALUE').AsFloat;///utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsFloat;
          dbDataT0 := utlDB.DBase.IBQuery.FieldByName('T0VALUE').AsFloat;///utlDB.DBase.IBQuery.FieldByName('M_SFKI').AsFloat;
        end else begin
          if (swTid = 1) then dbDataT1 := utlDB.DBase.IBQuery.FieldByName('T1VALUE').AsFloat;
          if (swTid = 2) then dbDataT2 := utlDB.DBase.IBQuery.FieldByName('T2VALUE').AsFloat;
          if (swTid = 3) then dbDataT3 := utlDB.DBase.IBQuery.FieldByName('T3VALUE').AsFloat;
          if (swTid = 4) then dbDataT4 := utlDB.DBase.IBQuery.FieldByName('T4VALUE').AsFloat;
          if (swTid = 0) then dbDataT0 := utlDB.DBase.IBQuery.FieldByName('T0VALUE').AsFloat;          
         end;

        strTarif := FloatToStrF(dbDataT1,ffFixed,10,0) + ';' +
                    FloatToStrF(dbDataT2,ffFixed,10,0) + ';' +
                    FloatToStrF(dbDataT3,ffFixed,10,0) + ';' +
                    FloatToStrF(dbDataT4,ffFixed,10,0) + ';'+
                    FloatToStrF(dbDataT0,ffFixed,10,0) + ';';


        strLine :=  strDate + ';' + regNo + ';' +
                    strLicNb + ';' + strFabNum + ';' +
                    strFIO + ';' + strAddr + ';' +
                    strTarif;
        WriteLn(mPidFile,strLine);
        utlDB.DBase.IBQuery.Next;
      end;
      CloseFile(mPidFile);
    end;
   except
       if EventBox<>nil then EventBox.FixEvents(ET_CRITICAL,'Ошибка при выгрузке данных!!! ');
   end
 finally
    FStatBar.Panels[7].Style:=psOwnerDraw;
   if EventBox<>nil then EventBox.FixEvents(ET_RELEASE,'Выгрузка данных завершена!!! ');
 end;
end;


procedure CBytUnloader.SetProgressIMport(nPRC:Integer);
Begin
    if not((FStatBar=Nil)) then
     FStatBar.Panels[7].Progress.Position   := nPRC;
End;

end.
 