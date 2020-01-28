unit knsl3savetime;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,inifiles, forms,mmsystem,FileCtrl;
type
    CSaveTime = class
    protected
     m_strApplication : String;
     m_nCSize    : Integer;
     m_strPath   : String;
//     m_nAR       : CArchiveBase;
     m_dtOldTime : TDateTime;
     m_dtFl      : TINIFile;
     m_dwCount   : DWord;
     m_blEnable  : Boolean;
     m_nDTime    : Integer;

     procedure CreateCluster;
     procedure ReopenFile;

     procedure Generate;
     function  GetDecDateTime(dtDate:TDateTime):String;
     procedure RefreshTime;
    public
     constructor Create(nDTime,nCSize:Integer;strApp,strPath:String;FForm:TForm);
     destructor Destroy; override;
     function GetDateTime:TDateTime;
     procedure ExecSaveTime;
     procedure SetDTime(nSec:Integer);
     procedure SetState(byState:Byte);
     procedure Run;
    End;
Var
    m_nST : CSaveTime;
implementation

constructor CSaveTime.Create(nDTime,nCSize:Integer;strApp,strPath:String;FForm:TForm);
Begin
    m_nST            := self;
    m_strApplication := strApp;
    m_nCSize         := nCSize;
    m_strPath        := strPath;
    m_nDTime         := nDTime;
//    m_nAR            := CArchiveBase.Create;
//    m_nAR.PForm      := FForm;
    m_dtOldTime      := Now-1;
    m_dwCount        := 0;
    m_blEnable       := False;
    Generate;
End;
destructor CSaveTime.Destroy;
Begin
 // if m_nAR <> nil then FreeAndNil(m_nAR);
    inherited;
End;
function CSaveTime.GetDateTime:TDateTime;
Var
    strTime : String;
    i       : Integer;
Begin
    try
     for i:=0 to 10 do
     begin
      strTime:=GetDecDateTime(Now-i);
      if strTime<>'FREE' then break;
     End;
     if strTime='FREE' then Result := Now else
     Result := StrToDateTime(strTime);
     m_blEnable :=True;
    except

    end;
End;
procedure CSaveTime.ExecSaveTime;
Begin
    ReopenFile;
    if m_dtFl<>Nil then m_dtFl.WriteString('LASTTIME','m_nLastTime',DateTimeToStr(Now));
End;
procedure CSaveTime.ReopenFile;
Var
    Year,Month,Day,oldYear,oldMonth,oldDay:Word;
    strPath : String;
Begin
    try
    DecodeDate(Now,Year,Month,Day);
    DecodeDate(m_dtOldTime,oldYear,oldMonth,oldDay);
    if trunc(m_dtOldTime)<>trunc(Now) then
    Begin
     if oldYear<>Year then RefreshTime;
     strPath := m_strPath+IntToStr(Month)+'\'+IntToStr(Day)+'.ini';
     if (FileExists(strPath)=False) then exit;
     if m_dtFl<>Nil then m_dtFl.Destroy;
     m_dtFl      := TINIFile.Create(strPath);
     m_dtOldTime := Now;
    End;
    except

    end;
End;
procedure CSaveTime.RefreshTime;
Var
    Fl : TINIFile;
    Month,Day:Integer;
    strPath : String;
Begin
    for Month:=1 to 12 do
    Begin
     for Day:=1 to 31 do
     Begin
      strPath := m_strPath+IntToStr(Month)+'\'+IntToStr(Day)+'.ini';
      if (FileExists(strPath)=False) then exit;
      Fl := TINIFile.Create(strPath);
      Fl.WriteString('LASTTIME','m_nLastTime','FREE');
      Fl.Destroy;
     End;
    End;
end;
function CSaveTime.GetDecDateTime(dtDate:TDateTime):String;
Var
    Fl : TINIFile;
    Year,Month,Day:Word;
    strPath : String;
Begin
    DecodeDate(dtDate,Year,Month,Day);
    strPath := m_strPath+IntToStr(Month)+'\'+IntToStr(Day)+'.ini';
    if (FileExists(strPath)=False) then exit;
    Fl := TINIFile.Create(strPath);
     Result := Fl.ReadString('LASTTIME','m_nLastTime',DateTimeToStr(Now));
    Fl.Destroy;
End;
procedure CSaveTime.SetDTime(nSec:Integer);
Var
    Fl  : TINIFile;
Begin
    m_nDTime := nSec;
    Fl := TINIFile.Create(m_strApplication+'\Settings\USPD_Config.ini');
    Fl.WriteInteger('DBCONFIG','m_nTimeDlt',m_nDTime);
    Fl.Destroy;
End;
procedure CSaveTime.SetState(byState:Byte);
Begin
    if byState=1 then m_blEnable := True;
    if byState=0 then m_blEnable := False;
end;
procedure CSaveTime.Generate;
Var
    i,j : Integer;
    strSrc,strDst:String;
Begin
    try
    {$I-}
    if DirectoryExists(m_strPath)=True then exit;
    CreateCluster;
    MkDir(m_strPath);
    if DirectoryExists(m_strPath)=False then exit;
    for i:=1 to 12 do
    Begin
     strSrc := m_strPath+IntToStr(i);
     MkDir(strSrc);
     for j:=1 to 31 do
     Begin
      strDst := m_strPath+IntToStr(i)+'\'+IntToStr(j)+'.ini';
//      m_nAR.CopyFile(m_strApplication+'\Settings\clXX.ini',strDst);
     End;
    End;
    except

    end;
End;
procedure CSaveTime.CreateCluster;
Var
    str : String;
    i   : Integer;
    Fl  : TINIFile;
Begin
    try
    Fl := TINIFile.Create(m_strApplication+'\Settings\clXX.ini');
     str := 'B5 9A 61 9F 2B B4 A1 42 12 CB 4C 3E 8B 9D E7 4E 2C 0E F4 D1 42 6C 06 D1 92 E5 50 04 43 43 23';
     Fl.WriteString('LASTTIME','m_nLastTime','FREE');
     for i:=0 to trunc(m_nCSize/100) do
     Fl.WriteString('DATA','CODE'+IntToStr(i),str);
    Fl.Destroy;
    except

    end;
End;
procedure CSaveTime.Run;
Begin
    if (m_dwCount mod m_nDTime)=0 then
    if m_blEnable=True then ExecSaveTime;
    m_dwCount := m_dwCount + 1;
End;
end.
 