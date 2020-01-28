unit knsl3archive;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,inifiles,Db,ADODB,
    math,forms,ShellAPI,Dialogs;
type
 SGENSETTTAG = packed record
     m_swID         : Integer;
     m_sbyMode      : Byte;
     m_sbyLocation  : Byte;
     m_sbyAutoPack  : Byte;
     m_swAddres     : String[30];
     m_swMask       : String[30];
     m_swGate       : String[30];
     m_sStorePeriod : Integer;
     m_sStoreClrTime: Integer;
     m_sStoreProto  : Integer;
     m_sPoolPeriod  : Integer;
     m_sProjectName : String[100];
     m_sPrePoolGraph: Byte;
     m_sQryScheduler: Byte;
     m_sPowerLimit  : Double;
     m_sPowerPrc    : Integer;
     m_sAutoTray    : Byte;
     m_sPrecise     : Byte;
     m_sPreciseExpense : Byte;
     m_sCorrDir     : Byte;
     m_sBaseLocation: Byte;
     m_sKorrDelay   : Double;
     m_sSetForETelecom : Byte;
     m_sInterSet    : Byte;
     m_sMdmJoinName : String[50];
     m_sUseModem    : Byte;
     m_sInterDelay  : Double;
     m_sChannSyn    : Byte;
     m_sbyAllowInDConn :Byte;
     m_sTransTime   : Byte;
     m_sChooseExport: integer;
     m_swSelfTest   : Dword;
     m_blOnStartCvery:Byte;   
     m_sbyDeltaFH   : Byte;
     {MySQL}
     m_dtEStart     : TDateTime;
     m_dtEInt       : TDateTime;
     m_sDBNAME      : String[16];
     m_sDBUSR       : String[16];
     m_sDBPASSW     : String[16];
     m_SDBSERVER    : String[20];
     m_SDBPORT      : Integer;
     {Archive}
     m_byEnableArchiv : Byte;
     m_sArchPath      : String[100];
     m_sSrcPath       : String[100];
     m_tmArchPeriod   : Byte;
     m_dtEnterArchTime: TDateTime;
     M_SQUERYMASK     : int64;
     {DBF, Минский Энергосбыт}
     m_sDBFLOCATION   : String[255];
    end;
    PSGENSETTTAG =^ SGENSETTTAG; 

    CArchiveBase = class
    private
     m_pTable : PSGENSETTTAG;
     FForm    : TForm;
     m_blSaved: Boolean;
     m_dwIndex: Integer;
    public
     m_strCurrentDir : string;
    private
     function TimeElapsed:Boolean;
     function CopyBase(strSrc,strDst:String):Boolean;
    public
     constructor Create;overload;
     constructor Create(sSrcPath:String;pTable : PSGENSETTTAG);overload;
     function CopyFile(strSrc,strDst:String):Boolean;
     function Delete(strSrc:String):Boolean;
     function OnHotArchivate(strPath:string):Boolean;
     function OnHandArchivate:Boolean;
     function OnAutoArchivate:Boolean;
     procedure Run;
    property PForm : TForm read FForm write FForm;
    End;
implementation
constructor CArchiveBase.Create;
Begin

End;
constructor CArchiveBase.Create(sSrcPath:String;pTable : PSGENSETTTAG);
Begin
    m_pTable  := pTable;
    m_blSaved := False;
    m_dwIndex := 0;
End;
function CArchiveBase.OnHandArchivate:Boolean;
Var
    m_sArchPath : String;
    Year,Month,Day : Word;
Begin
    try
     DecodeDate(Now,Year,Month,Day);
     m_sArchPath := m_pTable.m_sArchPath+'\Archive_'+IntToStr(Year)+'_'+IntToStr(Month)+'_'+IntToStr(Day)+'.fbk';
     if MessageDlg('Выполнить архивацию из '+m_pTable.m_sSrcPath+' в '+m_sArchPath+' ?',mtWarning,[mbOk,mbCancel],0)=idOK then
     CopyBase(m_pTable.m_sSrcPath,m_sArchPath);
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Ручная архивация из '+m_pTable.m_sSrcPath+' в '+m_sArchPath);
    except
    end;
End;
function CArchiveBase.OnAutoArchivate:Boolean;
Var
    m_sArchPath : String;
    Year,Month,Day,msec : Word;
Begin
    try
     DecodeDate(Now,Year,Month,Day);
     DecodeTime(Now,Year,Month,Day,msec);
     m_sArchPath := m_pTable.m_sArchPath+'\Archive_'+IntToStr(Year)+'_'+IntToStr(Month)+'_'+IntToStr(Day)+'.fbk';
     CopyBase(m_pTable.m_sSrcPath,m_sArchPath);
     //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Архивация из '+m_pTable.m_sSrcPath+' в '+m_sArchPath);
     CopyFile(ExtractFilePath(Application.ExeName)+'SYSINFOAUTO.FBK',ExtractFilePath(Application.ExeName)+'Restore\SYSINFOAUTO.FBK');
    except
    end;
End;
function CArchiveBase.OnHotArchivate(strPath:string):Boolean;
Begin
    CopyBase(m_pTable.m_sSrcPath,strPath);
    //if EventBox<>Nil then EventBox.FixEvents(ET_RELEASE,'Горячий резерв из '+m_pTable.m_sSrcPath+' в '+strPath);
End;
function CArchiveBase.CopyFile(strSrc,strDst:String):Boolean;
Begin
    Result := CopyBase(strSrc,strDst);
End;
function CArchiveBase.CopyBase(strSrc,strDst:String):Boolean;
var
    OpStruc: TSHFileOpStruct;
    frombuf, tobuf: array [0..128] of Char;
    x,y:string;
Begin
    //x:='\\ssmdev\client\Client';//откуда;
    //y:='C:\Users\SSM-DEV\Desktop\lancher\Debug\Win32\id1\';//куда;
    if FileExists(strSrc)=True then
    Begin
     FillChar(frombuf,Sizeof(frombuf),0);
     FillChar(tobuf  ,Sizeof(tobuf),0);
     StrPCopy(frombuf,strSrc);
     StrPCopy(tobuf  ,strDst);
     with OpStruc do
     begin
      Wnd    := PForm.Handle;
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
End;
function CArchiveBase.Delete(strSrc:String):Boolean;
var
    OpStruc: TSHFileOpStruct;
    strDst:String;
    frombuf, tobuf: array [0..128] of Char;
    x,y:string;
Begin
    //x:='\\ssmdev\client\Client';//откуда;
    //y:='C:\Users\SSM-DEV\Desktop\lancher\Debug\Win32\id1\';//куда;
    strDst := strSrc;
    if FileExists(strSrc)=True then
    Begin
     FillChar(frombuf,Sizeof(frombuf),0);
     FillChar(tobuf  ,Sizeof(tobuf),0);
     StrPCopy(frombuf,strSrc);
     StrPCopy(tobuf  ,strDst);
     with OpStruc do
     begin
      Wnd    := PForm.Handle;
      wFunc  := FO_DELETE;
      pFrom  := @frombuf;
      pTo    := @tobuf;
      fFlags := FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION or FOF_SILENT;
      fAnyOperationsAborted := False;
      hNameMappings         := nil;
      lpszProgressTitle     := nil;
     end;
     ShFileOperation(OpStruc);
    End;
End;
function CArchiveBase.TimeElapsed:Boolean;
Var
    Year,Month,Day,Hour,Min,Sec,Msec,Hour0,Min0,Sec0,Msec0 : Word;
Begin
    try
     DecodeDate(Now,Year,Month,Day);
     DecodeTime(Now,Hour,Min,Sec,Msec);
     DecodeTime(m_pTable.m_dtEnterArchTime,Hour0,Min0,Sec0,Msec0);
     if (Month mod (m_pTable.m_tmArchPeriod+1)=0) and (Day=1) and (Hour=Hour0) then
     Begin
      if (m_blSaved=False) then
      Begin
       m_blSaved := True;
       Result    := True
      End;
     End else
     Begin
      if Day<>1 then m_blSaved := False;
      Result:=False;
     End;
    except

    end;
End;
procedure CArchiveBase.Run;
Begin
    //if (m_dwIndex mod 60)=0 then
    Begin
     if (TimeElapsed=True) then OnAutoArchivate;
    End;
    m_dwIndex := m_dwIndex + 1;
End;

end.
