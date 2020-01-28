unit utlDBForOneQuery;

interface
uses
  Windows,forms, Classes, SysUtils, SyncObjs, StdCtrls, ComCtrls, Db, Dates,
  utltypes, utlconst, utlbox, INIfiles, IBDatabase,IBQuery, utlSendRecive;
type
    TDBaseForOneQuery = class
    private
      NameBase       : string;
      m_blIsConnect  : Boolean;
      SenderClass    : TSenderClass;
    public
//     IBTr            : TIBTransaction;
     IBConnection    : TIBDatabase;
     IBQuery         : TIBQuery;
//     constructor Create(m_strProvider : string); overload;
     destructor Destroy; override;
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
     constructor Create{(m_strProvider: string; base: TDBase)}; overload;
     procedure SendEventBox(aType : Byte; aMessage : String);
    End;

function GetConnectForOneQuery : TDBaseForOneQuery;

implementation

const
    MAX_BLOCK_QRY = 50;

function GetConnectForOneQuery : TDBaseForOneQuery;
var str  : string;
    base : TDBaseForOneQuery;
begin
  str := ExtractFilePath(Application.ExeName) + 'Settings\USPD_Config.ini';
  base := TDBaseForOneQuery.Create;
  base.Init(str);
  base.Connect;
  Result := base;
end;

constructor TDBaseForOneQuery.Create;
begin
  Self.Init(ExtractFilePath(Application.ExeName) + 'Settings\USPD_Config.ini');
  Self.Connect;
end;

destructor TDBaseForOneQuery.Destroy;
begin
  Self.Disconnect;
  inherited;
//  Self.Destroy;
end;

procedure TDBaseForOneQuery.Init(strFileName:String);
var Fl   : TINIFile;
    strProvider : string;
Begin
  m_blIsConnect := False;
  Fl := TINIFile.Create(strFileName);
  strProvider := Fl.ReadString('DBCONFIG', 'DBProvider', '');
  NameBase := strProvider;
  FreeAndNil(Fl);
End;

function TDBaseForOneQuery.Connect:Boolean;
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

function TDBaseForOneQuery.Disconnect:Boolean;
Begin
   Result := True;
  m_blIsConnect := False;
  try
   DestroyConnection(IBConnection,IBQuery);
  except
    on E: Exception do begin
      SendEventBox(0, 'Error In TDBase.Disconnect: ' + E.Message);
      Result := False;
    end;
  end;
End;

procedure TDBaseForOneQuery.CreateConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
 try
  DestroyConnection(vConn, vQry);
//  if vConn=Nil then Begin
    vConn := TIBDataBase.Create(nil);
    IBTr := TIBTransaction.Create(nil);
    IBTr.Params.Add('read_committed');
    IBTr.Params.Add('rec_version');
    IBTr.Params.Add('wait');
    with vConn do begin
     SQLDialect := 3;                                              
     DatabaseName := NameBase; //m_strProvider;
     Params.Add('user_name=sysdba');
     Params.Add('password=masterkey');
     Params.Add('lc_ctype=WIN1251');
     LoginPrompt := False;
     DefaultTransaction := IBTr;
    end;
    vConn.Connected := True;
//    if vQry=Nil then begin
     vQry := TIBQuery.Create(Nil);
     vQry.Transaction:=IBTr;
     vQry.Database:=vConn;
//    End;
//  End;
 except 
    on E: Exception do begin
      SendEventBox(ET_CRITICAL, 'Error In TDBase.Disconnect: ' + E.Message);
    end;
 end;
End;

procedure TDBaseForOneQuery.DestroyConnection(var vConn:TIBDataBase;var vQry:TIBQuery);
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

procedure TDBaseForOneQuery.DestroyConnectionQuery(vQry:TIBQuery);
var IBTr : TIBTransaction;
Begin
  if vQry <> Nil then Begin
    IBTr := vQry.Transaction;
    if IBTr <> nil then FreeAndNil(IBTr);
    FreeAndNil(vQry);
   End;
End;

function TDBaseForOneQuery.ExecQry(strSQL:String):Boolean;
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
      SendEventBox(ET_CRITICAL, 'Error in TDBaseForOneQuery.ExecQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'IBQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'IBQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      IBQuery.Transaction.Rollback;
      Result := False;
    end;
  end;
End;

function TDBaseForOneQuery.OpenQry(strSQL:String;var nCount:Integer):Boolean;
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
      SendEventBox(ET_CRITICAL, 'Error in TDBaseForOneQuery.OpenQry: ' + E.Message);
      SendEventBox(ET_CRITICAL, 'IBQuery = ' + IntToStr(iQ));
      SendEventBox(ET_CRITICAL, 'IBQuery.Transaction = ' + IntToStr(iT));
      SendEventBox(ET_CRITICAL, 'SQL reqest = ' + strSQL);
      IBQuery.Transaction.Rollback;
      Result := False;
    end;
  end;
End;

function  TDBaseForOneQuery.OpenQrySL(SL:TStringList;var nCount:Integer):Boolean;
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
      SendEventBox(ET_CRITICAL, 'Error in TDBaseForOneQuery.OpenQrySL: ' + E.Message);
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


procedure TDBaseForOneQuery.CloseQry;
Begin
  if m_blIsConnect=False then exit;
  if m_blIsBackUp=True then exit;
  IBQuery.SQL.Clear;
  IBQuery.Close;
End;

function TDBaseForOneQuery.ExecQrySL(strSQL:TStringList):Boolean;
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
      SendEventBox(ET_CRITICAL, 'Error in TDBaseForOneQuery.ExecQrySL: ' + E.Message);
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

procedure TDBaseForOneQuery.SendEventBox(aType : Byte; aMessage : String);
Var s  : string;
    ID : Integer;
Begin
  ID := 0;
  s := SenderClass.ToStringBox(aType, aMessage);
  ID := GetCurrentThreadID;
  SenderClass.Send(QL_QWERYBOXEVENT, EventBoxHandle, ID, s);
End;

end.
 