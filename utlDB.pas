unit utlDB;

interface
uses
  Windows,forms, Classes, SysUtils, SyncObjs, StdCtrls, ComCtrls, Db, Dates,
  utltypes, utlconst, utlbox, INIfiles, IBDatabase,IBQuery, utlSendRecive;
type
    TDBase = class
    private
     m_strProvider   : String;
     m_strFileName   : String;
     m_blIsConnect   : Boolean;
     SenderClass     : TSenderClass;
     procedure SendEventBox(aType : Byte; aMessage : String);
    public
//     IBTr            : TIBTransaction;
     IBConnection    : TIBDatabase;
     IBQuery         : TIBQuery;     
     constructor Create(m_strProvider : string); overload;
     procedure Init(strFileName:String);
     function  Connect:Boolean;
     function  Disconnect:Boolean;
     procedure CreateConnection(var vConn:TIBDatabase;var vQry:TIBQuery);
     procedure DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
     procedure DestroyConnectionQuery(vQry:TIBQuery);
     function  ExecQry(strSQL:String):Boolean;
     function  OpenQry(strSQL:String;var nCount:Integer):Boolean;
     function  OpenQrySL(SL:TStringList;var nCount:Integer):Boolean;
     function  ExecQrySL(strSQL:TStringList):Boolean;
     procedure CloseQry;
    End;

 var DBase : TDBase;
     strSettingsPath : string;

implementation

const
    MAX_BLOCK_QRY = 50;

constructor TDBase.Create(m_strProvider : string);
begin
  Self.Init(m_strProvider);
  Self.Connect;
end;

procedure TDBase.Init(strFileName:String);
var Fl   : TINIFile;
Begin
//  m_strFileName := strFileName;
  m_strProvider := strFileName;
  m_blIsConnect := False;
  Fl := TINIFile.Create(strFileName);
  m_strProvider := Fl.ReadString('DBCONFIG', 'DBProvider', '');
  FreeAndNil(Fl);
End;

function TDBase.Connect:Boolean;
Begin
  Result := True;
  m_blIsConnect := True;
  try
   CreateConnection(IBConnection,IBQuery);
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error In TDBase.Connect: ' + E.Message);
      Result := False;
    end;
  end;
End;

function TDBase.Disconnect:Boolean;
Begin
   Result := True;
  m_blIsConnect := False;
  try
   DestroyConnection(IBConnection,IBQuery);
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error In TDBase.Disconnect: ' + E.Message);
      Result := False;
    end;
  end;
End;

procedure TDBase.CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
  DestroyConnection(vConn, vQry);
//  if vConn = Nil then Begin
    vConn := TIBDataBase.Create(nil);
    IBTr := TIBTransaction.Create(nil);
    IBTr.Params.Add('read_committed');
    IBTr.Params.Add('rec_version');
    IBTr.Params.Add('wait');
    with vConn do begin
     SQLDialect := 3;
     DatabaseName := m_strProvider;
     Params.Add('user_name=sysdba');
     Params.Add('password=masterkey');
     Params.Add('lc_ctype=WIN1251');
     LoginPrompt := False;
     DefaultTransaction := IBTr;
    end;
    vConn.Connected := True;
//    if vQry = Nil then begin
     vQry := TIBQuery.Create(Nil);
     vQry.Transaction:=IBTr;
     vQry.Database:=vConn;
//    end;
//  End;
End;

procedure TDBase.DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
  if vConn <> Nil then Begin
    IBTr := vQry.Transaction;
    vConn.DefaultTransaction := nil;
   FreeAndNil(vConn);
    if vQry<>Nil then FreeAndNil(vQry);
    if IBTr<>Nil then FreeAndNil(IBTr);
  End;
End;

procedure TDBase.DestroyConnectionQuery(vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
  if vQry <> Nil then Begin
    IBTr := vQry.Transaction;
    if IBTr <> nil then FreeAndNil(IBTr);
    FreeAndNil(vQry);
   End;
End;

function TDBase.ExecQry(strSQL:String):Boolean;
var iQ, iT : Integer;
Begin
  Result := false;
  if m_blIsBackUp=True then exit;
  Result := True;
  try
    if not IBQuery.Transaction.Active then
      IBQuery.Transaction.StartTransaction;
    iQ := Integer(IBQuery);
    iT := Integer(IBQuery.Transaction);
   IBQuery.Close;
   IBQuery.SQL.Clear;
   IBQuery.SQL.Add(strSQL);
   IBQuery.ExecSQL;
   IBQuery.SQL.Clear;
   IBQuery.Close;
    IBQuery.Transaction.Commit;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in ExecQry.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'IBQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'IBQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      IBQuery.Transaction.Rollback;
      Result := False;
    end;
  end;
End;

function TDBase.OpenQry(strSQL:String; var nCount:Integer):Boolean;
var iQ, iT : Integer;
Begin
  Result    := False;
  if m_blIsBackUp=True then exit;
  nCount := 0;
  if m_blIsConnect=False then Begin Result := False;exit;End;
  Result := True;
  try
    if not IBQuery.Transaction.Active then
      IBQuery.Transaction.StartTransaction;
    iQ := Integer(IBQuery);
    iT := Integer(IBQuery.Transaction);
   IBQuery.SQL.Clear;
   IBQuery.SQL.Add(strSQL);
   IBQuery.Open;
   IBQuery.FetchAll;
    IBQuery.Transaction.CommitRetaining;
    if IBQuery.RecordCount>0 then nCount := IBQuery.RecordCount;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in TDBase.OpenQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'IBQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'IBQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      IBQuery.Transaction.Rollback;
      Result := False;
    end;
  end;
End;


function  TDBase.OpenQrySL(SL:TStringList;var nCount:Integer):Boolean;
var iQ, iT : Integer;
    i : Integer;
Begin
  Result := False;
  if m_blIsBackUp=True then exit;
  nCount := 0;
  if m_blIsConnect=False then Begin Result := False; exit; End;
  Result := True;
  try
    if not IBQuery.Transaction.Active then
      IBQuery.Transaction.StartTransaction;
    iQ := Integer(IBQuery);
    iT := Integer(IBQuery.Transaction);
   IBQuery.SQL.Clear;
   IBQuery.SQL := SL;
   IBQuery.Open;
   IBQuery.FetchAll;
    IBQuery.Transaction.CommitRetaining;
    if IBQuery.RecordCount>0 then nCount := IBQuery.RecordCount;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in TDBase.OpenQrySL: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'IBQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'IBQuery.Transaction = ' + IntToStr(iT));
      for i:=0 to SL.Count-1 do
        if i = 0 then
          SendEventBox(ET_CRITICAL, 'SQL reqest = ' + IBQuery.SQL.Strings[i])
        else SendEventBox(ET_CRITICAL, '             ' + IBQuery.SQL.Strings[i]);
      IBQuery.Transaction.Rollback;
      Result := False;
    end;
  end;
end;


procedure TDBase.CloseQry;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  IBQuery.SQL.Clear;
  IBQuery.Close;
End;

function TDBase.ExecQrySL(strSQL:TStringList):Boolean;
var iQ, iT : Integer;
    i      : Integer;
Begin
  Result := false;
  if m_blIsBackUp=True then exit;
  Result := True;
  try
    if not IBQuery.Transaction.Active then
      IBQuery.Transaction.StartTransaction;
    iQ := Integer(IBQuery);
    iT := Integer(IBQuery.Transaction);
   IBQuery.Close;
   IBQuery.SQL.Clear;
   IBQuery.SQL:=strSQL;
   IBQuery.ExecSQL;
   IBQuery.SQL.Clear;
   IBQuery.Close;
    IBQuery.Transaction.Commit;
  except
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error in TDBase.ExecQrySL: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'IBQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'IBQuery.Transaction = ' + IntToStr(iT));
      for i:=0 to strSQL.Count-1 do
        if i = 0 then
          SendEventBox(ET_CRITICAL, 'SQL reqest = ' + IBQuery.SQL.Strings[i])
        else SendEventBox(ET_CRITICAL, '             ' + IBQuery.SQL.Strings[i]);
      IBQuery.Transaction.Rollback;
      Result := False;
    end;
  end;
End;

procedure TDBase.SendEventBox(aType : Byte; aMessage : String);
Var s  : string;
    ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(aType, aMessage);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT, EventBoxHandle, ID, s);
End;


initialization
  strSettingsPath := ExtractFilePath(Application.ExeName) + 'Settings\USPD_Config.ini';
  DBase := TDBase.Create(strSettingsPath);
  DBase.Connect;

finalization
  DBase.Disconnect;
  DBase.Destroy;

end.

