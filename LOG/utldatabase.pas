unit utldatabase;

interface
uses
   Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,
   inifiles,Db,ADODB,Dates,dbtables, Math,IBDataBase,IBQuery;
type
   CDBase = class
   public
     function GetUserID(name : string):integer;
     function GetUserNameFromID(ID : integer):string;
   private
     FADOConnection  : TIBDataBase;
     FADOQuery       : TIBQuery;
     constructor Create;
     destructor Destroy; override;     
     procedure CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
     procedure DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
     function  OpenQry(strSQL:String;var nCount:Integer):Boolean;
     procedure CloseQry;
   public
     m_strDbUser     : String;
     m_strDbPassw    : String;
   End;
var
    m_pDB              : CDBase;

implementation

constructor CDBase.Create;
Begin
  CreateConnection(FADOConnection, FADOQuery);
End;

destructor CDBase.Destroy;
begin
  DestroyConnection(FADOConnection, FADOQuery);
  inherited;
end;

procedure CDBase.CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
Var
    IBTr : TIBTransaction;
Begin
  if vConn=Nil then
    Begin
      vConn := TIBDataBase.Create(nil);
      IBTr := TIBTransaction.Create(nil);
      with vConn do begin
       SQLDialect := 3;
       DatabaseName := 'D:\Kon2\SYSINFOAUTO.FDB';
       Params.Add('user_name=sysdba');
       Params.Add('password=masterkey');
       Params.Add('lc_ctype=WIN1251');
       LoginPrompt := False;
       DefaultTransaction := IBTr;
      end;
      vConn.Connected := True;
      if vQry=Nil then
      Begin
       vQry := TIBQuery.Create(Nil);
       vQry.Transaction:=IBTr;
       vQry.Database:=vConn;
      End;
  End;
End;

procedure CDBase.DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
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



function CDBase.OpenQry(strSQL:String;var nCount:Integer):Boolean;
Var
  res : Boolean;
Begin
  res    := False;
  nCount := 0;
  try
    FADOQuery.SQL.Clear;
    FADOQuery.SQL.Add(strSQL);
    FADOQuery.Open;
    FADOQuery.FetchAll;
    if FADOQuery.RecordCount>0 then begin
      nCount := FADOQuery.RecordCount;
      res := True;
    end;
  except
    res := False;
  end;
  Result := res;
End;

procedure CDBase.CloseQry;
Begin
  FADOQuery.Close;
End;



function CDBase.GetUserID(name : string):integer;
  // JKLJKL    BO 20.11.18
Var
  strSQL   : String;
  res      : Boolean;
  nCount   : Integer;
Begin
  strSQL := 'SELECT M_SWID ID FROM SUSERTAG WHERE M_STRSHNAME = ''' + name + '''';
  if OpenQry(strSQL,nCount)=True then
  Begin
   Result   := FADOQuery.FieldByName('ID').asInteger;
  End else Result := -1;
  CloseQry;
end;

function CDBase.GetUserNameFromID(ID : integer):string;
Var
  strSQL   : String;
  res      : Boolean;
  nCount   : Integer;
Begin
  strSQL := 'SELECT M_STRSHNAME NAME FROM SUSERTAG WHERE M_SWID = ''' + IntToStr(ID) + '''';
  if OpenQry(strSQL,nCount)=True then
  Begin
   Result   := FADOQuery.FieldByName('NAME').asString;
  End else Result := 'Безымянный';
  CloseQry;
end;



initialization
  m_pDB := CDBase.Create;

finalization
  m_pDB.Free;




end.

