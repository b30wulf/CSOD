{*******************************************************************************
 *    Экспорт данных 
 *
 ******************************************************************************}

unit knsl3ExportDBMaket;

interface           
uses
    Windows, SysUtils, Forms, ShellAPI, Classes, Messages, Dialogs,
    knsl5tracer,
    utltypes, utlbox, utlconst, utldatabase, utltimedate, db, dbtables,
    
    StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
    IdMessageClient, IdSMTP, IdMessage, IdCoderMIME,FileCtrl,knsl3EventBox,utlmtimer;

type
  CL3Export2DBMaket = class
  private
    w_mGEvent0      : THandle;
    m_pExportDBF    : SL3ExportDBFS;
    m_boIsConnected : Boolean;
    //m_boEnabled     : Boolean;
    m_boQweryExport : Boolean;
    m_boHandExport  : Boolean;
    m_QTable        : TTable;
    m_pGenSett      : PSGENSETTTAG;
    m_sTblL1        : SL1INITITAG;
    m_dtStartExp    : TDateTime; // Время начала экспорта
    m_dtNextExport  : TDateTime; // Временная метка следующего экспорта
    m_dtInterval    : TDateTime; // Интервал экспорта
    m_dtLast        : TDateTime; // последний опрос
    m_boOnExport    : Boolean;
    m_boChDate      : Boolean;
    m_nOldDay       : Byte;
    m_nOldMonth     : Byte;
    m_nAbonentsCount: Integer;
    m_pAbonents     : array of SABON;     // структура дял хранения системы
    m_boIsMaked     : Boolean;
    IdSMTP1         : TIdSMTP;
    IdEncoderMIME1  : TIdEncoderMIME;
    m_nExportTimer  : CTimer;

    m_dtStartExpSv  : TDateTime; // Время начала экспорта
    m_dtEndExpSv    : TDateTime; // Время окончания экспорта
    blUpdateLastTime: Boolean;
    FlbExportTime   : PTlabel;
    FlbExportTimeNext    : PTlabel;
    Fcbm_blExportLast    : PTCheckBox;

    //m_pDB           : CDBase;
    function ExportSlice(dtDate:TDateTime):Boolean;
    function ExportArch(dtDate:TDateTime):Boolean;
    function TimeExpired:Boolean;
    function FindDayChandge:Boolean;
    function FindMonthChandge:Boolean;
    function ConvertToWIN1251(instr:string):string;
    procedure OpenInternet;
    function RS(str:String):String;
    procedure QweryDisconnect;
  public
    constructor Create();
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
    procedure OnInternetConnect;
    procedure OnInternetDisconnect;

    function  GetRealPort(nPort:Integer):Integer;
    procedure Init(pTable:PSGENSETTTAG);
    procedure ReInit();
    procedure Start();
    function  SentMail(FName: String):Boolean;
    function  ExportData(dLoTime,dHiTime : TDateTime) : Boolean;
    function  ExportDataEx(dLoTime,dHiTime : TDateTime) : Boolean;
    function  Win2Dos(Const S: String) : String;
 public
      property PlbExportTime        :PTLabel    read FlbExportTime          write FlbExportTime;
      property PlbExportTimeNext    :PTLabel    read FlbExportTimeNext      write FlbExportTimeNext;
      property Pcbm_blExportLast    :PTCheckBox read Fcbm_blExportLast      write Fcbm_blExportLast;
end;
implementation
constructor CL3Export2DBMaket.Create();
begin
    m_QTable := TTable.Create(nil);
    IdSMTP1 := TIdSMTP.Create(nil);
    IdEncoderMIME1 := TIdEncoderMIME.Create(nil);
end;

destructor CL3Export2DBMaket.Destroy();
begin
  if m_QTable <> nil then FreeAndNil(m_QTable);
  if IdSMTP1 <> nil then FreeAndNil(IdSMTP1);
  if IdEncoderMIME1 <> nil then FreeAndNil(IdEncoderMIME1);
  if m_nExportTimer <> nil then FreeAndNil(m_nExportTimer);
  inherited;
end;

procedure CL3Export2DBMaket.Init(pTable:PSGENSETTTAG);
var
    List : TStringList;
    Year,Month,Day : Word;
begin
    DecodeDate(Now,Year,Month,Day);
    m_pGenSett   := pTable;
    m_boOnExport := False;
    m_boChDate   := False;
    m_nOldDay    := Day;
    m_nOldMonth  := Month;
    m_dtLast     := pTable.m_dtLast;
    m_boIsConnected := False;
    m_boHandExport  := False;
    blUpdateLastTime:= True;
    FlbExportTime.Caption     := DateTimeToStr(m_dtLast);//FormatDateTime('dd.mm.yy hh:mm:ss', m_dtLast);
    FlbExportTimeNext.Caption := DateTimeToStr(m_dtLast+m_pGenSett.m_dtEStart+1);//FormatDateTime('dd.mm.yy hh:mm:ss', m_dtLast+pTable.m_dtEInt+1);
    if abs(trunc((pTable.m_dtLast-Now)))>30 then
    Begin
     pTable.m_dtLast := Now;
     m_dtLast := Now;
    End;
    m_nExportTimer := CTimer.Create;
    m_nExportTimer.SetTimer(DIR_L3TOL3,DL_EXPORT_START_TMR_IND,0,0,BOX_L3);
end;
procedure CL3Export2DBMaket.OnHandler; Begin End;
function  CL3Export2DBMaket.SelfHandler(var pMsg:CMessage):Boolean;
begin
   Result := false;
end;
function  CL3Export2DBMaket.LoHandler(var pMsg:CMessage):Boolean;
begin
   Result := false;
end;
function  CL3Export2DBMaket.HiHandler(var pMsg:CMessage):Boolean;
begin
   Result := false;
end;
function  CL3Export2DBMaket.EventHandler(var pMsg : CMessage):Boolean;
begin
    case pMsg.m_sbyType of
         DL_EXPORTFMAK_START     : OpenInternet;
         DL_INTERNET_CONN_IND    : OnInternetConnect;
         DL_INTERNET_DISC_IND    : OnInternetDisconnect;
         DL_EXPORT_START_TMR_IND : OnExport;
    end;
   Result := false;
end;
procedure CL3Export2DBMaket.OpenInternet;
var
    pDS : CMessageData;
begin
    pDS.m_swData0 := 0;
    pDS.m_swData1 := 25*60;//Открыть Internet на 25 минут
    pDS.m_swData2 := 7;    //Скорость 115200
    pDS.m_swData3 := 0;
    SendMsgData(BOX_L3,0,DIR_L3TOL3,DL_INTERNET_OPEN_REQ,pDS);
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Открытие сессии для выгрузки данных на '+IntToStr(trunc(pDS.m_swData1/60))+' мин.');
End;
procedure CL3Export2DBMaket.OnInternetConnect;
Begin
    if m_boQweryExport=True then
    Begin
     m_boIsConnected := True;
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Интернет сессия активна');
     m_nExportTimer.OnTimer(3);
    End;
End;
procedure CL3Export2DBMaket.OnInternetDisconnect;
Var
    Time : _SYSTEMTIME;
Begin
    m_boIsConnected := False;
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Интернет сессия деактивирована');
    //ExportDataEx(m_dtStartExpSv,m_dtEndExpSv);
    {
    Time.wMilliseconds := 0;
    Time.wSecond    := 50;
    Time.wMinute    := 0;
    Time.wHour      := 0;
    Time.wDay       := 6;
    Time.wMonth     := 4;
    Time.wYear      := 2012;
    Time.wDayOfWeek := 3;
    SetLocalTime(Time);
    m_nOldDay       := Time.wDay - 1;
    m_dtLast        := Now - 1;
    }
End;
procedure CL3Export2DBMaket.ReInit();
begin
end;
procedure CL3Export2DBMaket.Start();
begin
end;

procedure CL3Export2DBMaket.RunExport();
begin
    if not((m_pGenSett.m_sSetForETelecom=1)AND(m_pGenSett.m_sChooseExport=3)) then  exit;
    if TimeExpired=True then
    Begin
     m_boQweryExport := True;
     if m_pGenSett.m_blMdmExp=1 then SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTFMAK_START) else OnExport;
    End;
    if m_nExportTimer<>Nil then m_nExportTimer.RunTimer;
end;
function CL3Export2DBMaket.TimeExpired:Boolean;
Begin
    if m_pGenSett.m_nEInt=0 then Result:=FindDayChandge;
    if m_pGenSett.m_nEInt=1 then Result:=FindMonthChandge;
End;
function CL3Export2DBMaket.FindDayChandge:Boolean;
Var
    Year,Month,Day:Word;
    Hour,Min,Sec,mSec:Word;
    lHour,lMin,lSec,lmSec:Word;
Begin
    try
    Result := False;
    DecodeDate(Now,Year,Month,Day);
    if m_nOldDay<>Day then
    Begin
     DecodeTime(Now,Hour,Min,Sec,mSec);
     DecodeTime(m_pGenSett.m_dtEStart,lHour,lMin,lSec,lmSec);
     if (Hour=lHour)and(Min=lMin) then
     Begin
      m_nOldDay := Day;
      Result    := True;
     End;
    End;
    except

    end;
end;
function CL3Export2DBMaket.FindMonthChandge:Boolean;
Begin
end;
procedure CL3Export2DBMaket.OnExport;
var
    y,m,d,hh,mm,ss,mss : Word;
Begin
    if m_boHandExport=True  then ExportData(m_dtStartExpSv,m_dtEndExpSv) else
    if m_boHandExport=False then ExportData(m_dtLast, Now-1);
    m_boHandExport  := False;
    m_boQweryExport := False;
end;
function CL3Export2DBMaket.ExportDataEx(dLoTime,dHiTime : TDateTime) : Boolean;
Begin
    m_boQweryExport := True;
    blUpdateLastTime:=Fcbm_blExportLast.Checked;
    if (m_pGenSett.m_blMdmExp=1)and(m_boIsConnected=False) then
    Begin
     m_dtStartExpSv := dLoTime; // Время начала экспорта
     m_dtEndExpSv   := dHiTime; // Время окончания экспорта
     m_boHandExport := True;
     SendMsg(BOX_L3,0,DIR_L3TOL3,DL_EXPORTFMAK_START);
     exit;
    End
    else if ExportData(dLoTime,dHiTime)=True then Result:=True else Result:=False;
    blUpdateLastTime:=True;
    //m_boHandExport:=False;
End;
function CL3Export2DBMaket.ExportData(dLoTime,dHiTime : TDateTime) : Boolean;
Var
    dtTime : TDateTime;
    res0,res1 : Boolean;
begin
    dtTime := dLoTime;
    while (trunc(dHiTime)>=trunc(dtTime)) do
    Begin
     res0 := ExportSlice(dtTime);
     if (res0=False) then Begin QweryDisconnect;Result:=False;exit;End;
     res1 := ExportArch(dtTime);
     if (res1=False) then Begin QweryDisconnect;Result:=False;exit;End;
     dtTime := trunc(dtTime + 1);
     If (blUpdateLastTime) then
     begin
      m_pDB.SetLastExportDate(dtTime);
      m_dtLast := dtTime;
      FlbExportTime.Caption     := FormatDateTime('dd.mm.yy hh:mm:ss', now);
      FlbExportTimeNext.Caption := FormatDateTime('dd.mm.yy hh:mm:ss', m_dtLast+1+frac(m_pGenSett.m_dtEStart));
     end;
    End;
    Result:=True;
    QweryDisconnect;
end;
procedure CL3Export2DBMaket.QweryDisconnect;
Var
    pDS : CMessageData;
Begin
    if (m_pGenSett.m_blMdmExp=1)and(m_boIsConnected=True) then
    Begin
     pDS.m_swData1 := 10;
     SendMsgData(BOX_L3,0,DIR_L3TOL3,DL_INTERNET_CLOSE_REQ,pDS);
    End;
End;
function CL3Export2DBMaket.ExportSlice(dtDate:TDateTime):Boolean;
var Fdat, i, j, k: Integer;
    Name, value,strFName: String;
    Sum: real;
    l_L3gra:L3GRAPHDATAMCS;
    s_L3AB: SL3ABONS;
    s_GENSET: SGENSETTTAG;
    strDirName : String;
Begin
    m_pDB.GetAbonsTable(s_L3AB);
    m_pDB.GetGenSettTable(s_GENSET);
    for k:=0 to s_L3AB.Count-1 do
    Begin
     strDirName := {s_GENSET.m_sMAKLOCATION+} ExtractFilePath(Application.ExeName) + 'Maket';
     Name:=strDirName+'\'+s_L3AB.items[k].m_sLIC+'_'+FormatDateTime('ddmmyy', dtDate+1)+'_917.dat';
     if DirectoryExists(strDirName)=False then
       MkDir(strDirName);
     Fdat:=FileCreate(Name);FileClose(Fdat);
     Fdat:=FileOpen(Name,FmOpenWrite);
     value:='((//30917:'+FormatDateTime('mmdd', dtDate+1)+':'+s_L3AB.items[k].m_strOBJCODE+':++'+#13+#10;
     FileWrite(Fdat,value[1],length(value));
       if (true = m_pDB.GetGraphDatasFMAK(s_L3AB.items[k].m_strOBJCODE ,dtDate,dtDate,l_L3gra)) then
        begin
            for j:=0 to l_L3gra.Count-1 do
             Begin
              value :='('+l_L3gra.items[j].m_sMeterCode;
              Case l_L3gra.items[j].m_swCMDID of
                13: value :=value+'1): ';
                14: value :=value+'2): ';
                15: value :=value+'3): ';
                16: value :=value+'6): ';
              end;
              FileWrite(Fdat,(value)[1],length(value));
              Sum:=0;
              for i:=0 to 47 do
               begin
                Sum :=Sum + l_L3gra.items[j].v[i];
                //StringReplace(Sum,'.',',',rfReplaceAll)
                end;
              FileWrite(Fdat,(RS(FloatToStr(Sum))+' : ')[1],length(FloatToStr(Sum)+' : '));
              for i:=0 to 47 do
               begin
                value := RS(FloatToStr(l_L3gra.items[j].v[i]))+' : ';
                FileWrite(Fdat,(value)[1],length(value));
               end;
              FileWrite(Fdat,(#13+#10)[1],length(#13+#10));
             end;
         end;
     FileWrite(Fdat,('=))')[1],length('=))'));
     FileClose(Fdat);
     strFName := s_L3AB.items[k].m_sLIC+'_'+FormatDateTime('ddmmyy', dtDate+1)+'_917.dat';
     Result := SentMail(strFName);
     If Result=False then exit;
     if EventBox<>Nil then Begin EventBox.FixEvents(ET_RELEASE,'Выгрузка срезов   : '+strFName+' завершена');EventBox.Refresh;End;
     if m_pGenSett.M_BLFMAKDELFILE=1 then DeleteFile(Name);
    End;
End;
function CL3Export2DBMaket.ExportArch(dtDate:TDateTime):Boolean;
var Fdat, i, j, k: Integer;
    Name, value, strFName: String;
    l_L3gra:CCDataMCs;
    s_L3AB: SL3ABONS;
    s_GENSET: SGENSETTTAG;
Begin
    m_pDB.GetAbonsTable(s_L3AB);
    m_pDB.GetGenSettTable(s_GENSET);
    for k:=0 to s_L3AB.Count-1 do
    Begin
    Name:={s_GENSET.m_sMAKLOCATION+} ExtractFilePath(Application.ExeName) + '\\Maket\\' + s_L3AB.items[k].m_sLIC+'_'+FormatDateTime('ddmmyy', dtDate+1)+'_818.dat';
    Fdat:=FileCreate(Name);
    FileClose(Fdat);
    Fdat:=FileOpen(Name,FmOpenWrite);
    value:='((//30818:'+FormatDateTime('mmdd', dtDate+1)+':'+s_L3AB.items[k].m_strOBJCODE+':++'+#13+#10;
    FileWrite(Fdat,value[1],length(value));
       if (true = m_pDB.GetGDataFMAK(s_L3AB.items[k].m_strOBJCODE,dtDate,dtDate,QRY_NAK_EN_DAY_EP,l_L3gra)) then
        begin
            for j:=0 to l_L3gra.Count-1 do
             Begin
              value :='('+l_L3gra.items[j].m_sMeterCode;
              Case l_L3gra.items[j].m_swCMDID of
                17: value :=value+'1): ';
                18: value :=value+'2): ';
                19: value :=value+'3): ';
                20: value :=value+'6): ';
              end;
              FileWrite(Fdat,(value)[1],length(value));
              FileWrite(Fdat,(RS(FloatToStr(l_L3gra.Items[j].m_sfValue))+' : ')[1],length(FloatToStr(l_L3gra.Items[j].m_sfValue)+' : '));
              FileWrite(Fdat,(#13+#10)[1],length(#13+#10));
             end;
         end;
    FileWrite(Fdat,('=))')[1],length('=))'));
    FileClose(Fdat);
    strFName := s_L3AB.items[k].m_sLIC+'_'+FormatDateTime('ddmmyy', dtDate+1)+'_818.dat';
    Result := SentMail(strFName);
    If Result=False then exit;
    if EventBox<>Nil then Begin EventBox.FixEvents(ET_RELEASE,'Выгрузка показаний: '+strFName+' завершена');EventBox.Refresh;End;
    if m_pGenSett.M_BLFMAKDELFILE=1 then DeleteFile(Name);
    End;
End;
procedure CL3Export2DBMaket.OnExportOn();
begin
    //m_boEnabled := True;
    m_pGenSett.m_sSetForETelecom:=1;
end;
procedure CL3Export2DBMaket.OnExportOff();
begin
    //m_boEnabled := false;
    m_pGenSett.m_sSetForETelecom:=0;
end;
procedure CL3Export2DBMaket.OnExportInit();
begin
    //m_PTMemo.Lines.Add(TimeToStr(Now())+ ' :> Инициализация экспорта');
    ReInit();
end;
function CL3Export2DBMaket.RS(str:String):String;
Begin
    try
     if str<>'' then
      Result := StringReplace(str,'.',',',[rfReplaceAll]) else Result := '0';
    except
     Result := '0';
    end;
End;
function CL3Export2DBMaket.GetRealPort(nPort:Integer):Integer;
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
Function CL3Export2DBMaket.Win2Dos(Const S: String) : String;
 { Конвертирует строку из кодировки Windows в DOS кодировку }
begin
    Result := s;
    exit;
    SetLength(Result,Length(S));
    if  Length(S) <> 0  then
    m_QTable.Translate(PChar(S),PChar(Result), true);
end;
function CL3Export2DBMaket.SentMail(FName: String):Boolean;
var
    msg      :TIdMessage;
    s_GENSET : SGENSETTTAG;
begin
    try
    m_pDB.GetGenSettTable(s_GENSET);
    IdSMTP1.AuthenticationType:=atLogin;
    IdSMTP1.Host:=s_GENSET.M_SHOSTMAK;
    IdSMTP1.Port:=25;
    IdSMTP1.Username:=s_GENSET.M_SEMAILMAK;
    IdSMTP1.Password:=s_GENSET.M_SPASSMAK;
    //IdSMTP1.Connect(10000);
    msg:=TIdMessage.Create(nil);
    msg.MessageParts.Clear;
    IdSMTP1.Connect(10000);
    with TIdAttachment.Create(msg.MessageParts,ExtractFilePath(Application.ExeName) + '\\Maket\\'+FName) do
    begin
      ContentType := 'text/plain';
      FileName := FName;
    end;
    msg.ContentType := 'multipart/mixed';
    msg.Subject:=FName;
    msg.From.Address:=s_GENSET.M_SEMAILMAK;
    msg.From.Name:=ConvertToWIN1251(s_GENSET.m_sNAMEMAILMAK);
    msg.Recipients.EMailAddresses:=s_GENSET.m_sMAKLOCATION;
    msg.IsEncoded:=false;
    IdSMTP1.Send(msg);
    msg.Free;
    IdSMTP1.Disconnect;
    Result := True;
    except
    on e:Exception do
     begin
      Result := False;
      msg.Free;
      TraceER('(__)CERMD::>Error In CL3Export2DBMaket.SentMail!!!');
      FlbExportTime.Caption:='Ошибка экспорта';
      IdSMTP1.Disconnect;
     end;
    end;
end;
function CL3Export2DBMaket.ConvertToWIN1251(instr: string): string;
begin
  result:='=?'+'Windows-1251'+'?B?'+IdEncoderMIME1.Encode(instr)+'?=';
end;
end.
