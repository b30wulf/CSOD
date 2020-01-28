unit fLogFile;

interface

uses Classes, Sysutils, Db, IBQuery, fBases, Windows,
     utldatabase;


type
  TEventItem = class(TObject)
    GRP  : string[4];
    EVNT : string[4];
    USR  : string[4];
    DT   : string[19];
  end;

  TEventStringItem = class(TObject)
    GRP  : string[4];
    EVNT : string[4];
    USR  : string[4];
    DT   : string[19];
    LS   : string[150];
    OUTI : string[4];
  end;

  TUserItem = class(TObject)
    ID   : integer;
    Name : string;
  end;

  TLOGItem = class(TObject)
    EVNT    : integer;
    GRP     : integer;
    DTIME   : string[19];
    EVTEXT  : string;
    TX      : string;
    USER    : string;
  end;

  TLogFile = class(TObject)
  private
    EventItem       : TEventItem;
    EventList       : TList;
    EventStringItem : TEventStringItem;
    EventStringList : TList;
    procedure EventListClear;
    procedure EventStringListClear;
    procedure UserListClear;
    function GetNextBlobID:Integer;
  public
    onCloseProgram  : boolean;
    STR             : TStringList;
    UserItem        : TUserItem;
    UserList        : TList;
    LOGItem         : TLOGItem;
    LOGList         : TList;

    constructor Create;
    destructor  Destroy; override;

    procedure LOGListClear;

    procedure AddEvent(GRP, EVNT, USR : integer; DT : TDateTime);
    procedure AddEventGroup(GRP, EVNT, USR : integer; DT : TDateTime);

    procedure AddEventString(GRP, EVNT, USR : integer; DT : TDateTime; LS : string);
    procedure AddEventStringGroup(GRP, EVNT, USR : integer; DT : TDateTime; LS : string);
    procedure AddEventFeedbackGroup(GRP, EVNT, USR, OUTINT : integer; DT : TDateTime; LS : string);

    procedure AddEventBlob(GRP, EVNT, USR : integer; DT : TDateTime; BLB : TMemoryStream);

    procedure LoadEventList(BeginTime,EndTime:TDateTime);
    procedure LoadEventListSTR;

    procedure HowManyUsers;
    { Public declarations }
  end;

function MemoryStreamToHexStr(AStream: TMemoryStream): string;

var LogFile : TLogFile;

implementation

procedure SaveSTRToFile(SL : TStringList);
var  TF : textfile;
     i  : integer;
begin
  assignfile(TF,'_rep.txt');
  Rewrite(TF);
  for i := 0 to SL.Count -1 do begin
    writeln(TF,SL.Strings[i]);
  end;
  closefile(TF);
end;

procedure TLogFile.HowManyUsers;
var strSQL : string;
    Query  : TIBQuery;
    ID     : integer;
    Name   : string;
begin
 { strSQL := 'SELECT USR FROM LOGS GROUP BY USR ';
  if fBase.GetQuery(strSQL, Query) then begin
    while not Query.Eof do begin
      ID := Query.FieldByName('USR').AsInteger;

//      Name := m_pDB.GetUserNameFromID(ID);
      Name := 'energo';
      UserItem := TUserItem.Create;
      UserItem.ID := ID;
      UserItem.Name := Name;
      UserList.Add(UserItem);
      Query.Next;
    end;
  end;   }
end;


procedure TLogFile.LoadEventList(BeginTime,EndTime:TDateTime);
var strSQL  : string;
    Query   : TIBQuery;
    old_USR : integer;
    USRName : string;
begin
  old_USR := -1;
//  HowManyUsers;
  strSQL := 'select logs.EVNT, events.EVTEXT, logs.USR, logs.DTIME, logs.GRP, ' +
            '  (select str from extstring where extstring.id = logs.extint) TX ' +
            'from logs, events ' +
            'where logs.EVNT = events.EVNT ' +
            '  and logs.GRP = events.GRP and (CAST(logs.DTIME AS DATE) BETWEEN '+''''+DateToStr(BeginTime)+''''+' and '+''''+DateToStr(EndTime)+''''+')'+
            ' ORDER BY logs.DTIME ';
  if fBase.GetQuery(strSQL, Query) then begin
    while not Query.Eof do begin
      if (old_USR <> Query.FieldByName('USR').AsInteger) then begin
        old_USR := Query.FieldByName('USR').AsInteger;

  //      USRName:=m_pDB.GetUserNameFromID(old_USR);
        USRName := 'energo';          // temporary
      end;
      LOGItem := TLOGItem.Create;
      LOGItem.EVNT := Query.FieldByName('EVNT').AsInteger;
      LOGItem.GRP := Query.FieldByName('GRP').AsInteger;
      LOGItem.DTIME := Query.FieldByName('DTIME').AsString;
      LOGItem.EVTEXT := Query.FieldByName('EVTEXT').AsString;
      LOGItem.TX := Query.FieldByName('TX').AsString;
      LOGItem.USER := USRName;
      LOGList.Add(LOGItem);
      Query.Next;
    end;
  end;
end;

// **************** получение запроса всех событий *********************
procedure TLogFile.LoadEventListSTR;
var strSQL : string;
    Query  : TIBQuery;
begin
  strSQL := 'select logs.EVNT, events.EVTEXT, logs.USR, logs.DTIME, logs.GRP ' +
            '  (select str from extstring where extstring.id = logs.extint) TX ' +
            'from logs, events ' +
            'where logs.EVNT = events.EVNT ' +
            '  and logs.GRP = events.GRP ' +
            'ORDER BY logs.DTIME ';
  if fBase.GetQuery(strSQL, Query) then begin
    while not Query.Eof do begin
      STR.Add(Query.FieldByName('DTIME').AsString + ' | ' +
              Query.FieldByName('EVTEXT').AsString + ' | ' +
              Query.FieldByName('TX').AsString +' | ' +
              Query.FieldByName('USR').AsString);
      Query.Next;
    end;
  end;
end;



// **************** добавление одного обычного события *********************
procedure TLogFile.AddEvent(GRP, EVNT, USR : integer; DT : TDateTime);
var strSQL : TStringList;
begin
  strSQL := TStringList.Create;
  strSQL.Add('INSERT INTO LOGS(ID, GRP, EVNT, USR, DTIME, EXTINT, OUTINT) ');
  strSQL.Add('VALUES(gen_id(GEN_LOGS_ID, 1), ' + IntToStr(GRP) + ', '
                                               + IntToStr(EVNT) + ', '
                                               + IntToStr(USR) + ', '
                                               + '''' + DateTimeToStr(DT) + ''''
                                               + ', 0, 0) ');
  fBase.SetQuery(strSQL);
  StrSQL.Destroy;
end;

// **************** добавление одного обычного события с учетом накопления до 200 элементов *********************
procedure TLogFile.AddEventGroup(GRP, EVNT, USR : integer; DT : TDateTime);
var strSQL : TStringList;
    i      : integer;
begin
  if (EventList.Count <= 200) and (not onCloseProgram) then begin
    EventItem := TEventItem.Create;
    EventItem.GRP := IntToStr(GRP);
    EventItem.EVNT := IntToStr(EVNT);
    EventItem.USR := IntToStr(USR);
    EventItem.DT := DateTimeToStr(DT);
    EventList.Add(EventItem);
  end;
  if (EventList.Count = 200) or (onCloseProgram) then begin
    if EventList.Count <> 0 then begin
      strSQL := TStringList.Create;
      strSQL.Add('EXECUTE BLOCK AS BEGIN ');
      for i := 0 to EventList.Count - 1 do begin
        EventItem:=TEventItem(EventList.Items[i]);
      strSQL.Add('INSERT INTO LOGS(ID, GRP, EVNT, USR, DTIME, EXTINT, OUTINT) ');
      strSQL.Add('VALUES(gen_id(GEN_LOGS_ID, 1), ' + EventItem.GRP + ', '
                                                   + EventItem.EVNT + ', '
                                                   + EventItem.USR + ', '
                                                   + '''' + EventItem.DT + ''''
                                                   + ', 0, 0); ');
      end;
      strSQL.Add('END ');
      fBase.SetQuery(strSQL);
      StrSQL.Destroy;
//      SaveSTRToFile(strSQL);
      EventListClear;
    end;
  end;
end;

// **************** добавление одного события с использованием дополнительной строки (150 символов) *********************
procedure TLogFile.AddEventString(GRP, EVNT, USR : integer; DT : TDateTime; LS : string);
var strSQL : TStringList;
begin
  strSQL := TStringList.Create;
  strSQL.Add('INSERT INTO LOGS(ID, GRP, EVNT, USR, DTIME, EXTINT, OUTINT) ');
  strSQL.Add('VALUES(gen_id(GEN_LOGS_ID, 1), ' + IntToStr(GRP) + ', '
                                               + IntToStr(EVNT) + ', '
                                               + IntToStr(USR) + ', '
                                               + '''' + DateTimeToStr(DT) + ''''
                                               + ', (SELECT ID FROM CHECK_ID_EXTSTR('''+ LS +''')), 0) ');
  fBase.SetQuery(strSQL);
  StrSQL.Destroy;
//    STR:=strSQL;
end;

// **************** добавление одного события с использованием дополнительной строки (150 символов) с учетом накопления до 50 элементов *********************
procedure TLogFile.AddEventStringGroup(GRP, EVNT, USR : integer; DT : TDateTime; LS : string);
var strSQL : TStringList;
    i      : integer;
begin
  if (EventStringList.Count <= 50) and (not onCloseProgram) then begin
    EventStringItem := TEventStringItem.Create;
    EventStringItem.GRP := IntToStr(GRP);
    EventStringItem.EVNT := IntToStr(EVNT);
    EventStringItem.USR := IntToStr(USR);
    EventStringItem.DT := DateTimeToStr(DT);
    EventStringItem.LS := LS;
    EventStringItem.OUTI:=IntToStr(0);
    EventStringList.Add(EventStringItem);
  end;
  if (EventStringList.Count = 50) or (onCloseProgram)  then begin
    if EventStringList.Count <> 0 then begin
      strSQL := TStringList.Create;
      strSQL.Add('EXECUTE BLOCK AS BEGIN ');
      for i := 0 to EventStringList.Count - 1 do begin
        EventStringItem:=TEventStringItem(EventStringList.Items[i]);
        strSQL.Add('INSERT INTO LOGS(ID, GRP, EVNT, USR, DTIME, EXTINT, OUTINT) ');
        strSQL.Add('VALUES(gen_id(GEN_LOGS_ID, 1), ' + EventStringItem.GRP + ', '
                                                     + EventStringItem.EVNT + ', '
                                                     + EventStringItem.USR + ', '
                                                     + '''' + EventStringItem.DT + ''''
                                                     + ', (SELECT ID FROM CHECK_ID_EXTSTR('''+ EventStringItem.LS +''')), '
                                                     + EventStringItem.OUTI + '); ');
      end;
      strSQL.Add('END ');
      fBase.SetQuery(strSQL);
      StrSQL.Destroy;
      EventListClear;
    end;  
  end;
end;

// **************** добавление одного события с обратной связъю с учетом накопления до 50 элементов *********************
// в данном случае в поле OUTINT пишется ID элемента, а в поле LS - талица:поле расположения в базе данных
procedure TLogFile.AddEventFeedbackGroup(GRP, EVNT, USR, OUTINT : integer; DT : TDateTime; LS : string);
var strSQL : TStringList;
    i      : integer;
begin
  if EventStringList.Count <= 50 then begin
    EventStringItem := TEventStringItem.Create;
    EventStringItem.GRP := IntToStr(GRP);
    EventStringItem.EVNT := IntToStr(EVNT);
    EventStringItem.USR := IntToStr(USR);
    EventStringItem.DT := DateTimeToStr(DT);
    EventStringItem.LS := LS;
    EventStringItem.OUTI:=IntToStr(OUTINT);
    EventStringList.Add(EventStringItem);
  end;
  if EventStringList.Count = 50 then begin
    strSQL := TStringList.Create;
    strSQL.Add('EXECUTE BLOCK AS BEGIN ');
    for i := 0 to EventStringList.Count - 1 do begin
      EventStringItem:=TEventStringItem(EventStringList.Items[i]);
      strSQL.Add('INSERT INTO LOGS(ID, GRP, EVNT, USR, DTIME, EXTINT, OUTINT) ');
      strSQL.Add('VALUES(gen_id(GEN_LOGS_ID, 1), ' + EventStringItem.GRP + ', '
                                                   + EventStringItem.EVNT + ', '
                                                   + EventStringItem.USR + ', '
                                                   + '''' + EventStringItem.DT + ''''
                                                   + ', (SELECT ID FROM CHECK_ID_EXTSTR('''+ EventStringItem.LS +''')), '
                                                   + EventStringItem.OUTI + '); ');
    end;
    strSQL.Add('END ');
    fBase.SetQuery(strSQL);
    StrSQL.Destroy;
    EventListClear;
  end;
end;



procedure TLogFile.AddEventBlob(GRP, EVNT, USR : integer; DT : TDateTime; BLB : TMemoryStream);
var strSQL : TStringList;
    ID : integer;
begin
  // Запись самого блоба
  ID := GetNextBlobID;

  strSQL := TStringList.Create;
  strSQL.Add('INSERT INTO BLOBTBL(ID, BLB)');
  strSQL.Add('VALUES ('+ IntToStr(ID) +', :BLB)');
  fBase.LOGBLOB.ParamByName('BLB').LoadFromStream(BLB,ftBlob);
  fBase.SetBLOB(strSQL);
  StrSQL.Destroy;

  strSQL := TStringList.Create;
  strSQL.Add('INSERT INTO LOGS(ID, GRP, EVNT, USR, DTIME, EXTINT, OUTINT, IDXBLOB) ');
  strSQL.Add('VALUES(gen_id(GEN_LOGS_ID, 1), ' + IntToStr(GRP) + ', '
                                               + IntToStr(EVNT) + ', '
                                               + IntToStr(USR) + ', '
                                               + '''' + DateTimeToStr(DT) + ''''
                                               + ', 0, 0, ' + IntToStr(ID) + ') ');
  fBase.SetQuery(strSQL);
  StrSQL.Destroy;

end;

{
if MyIDField.IsNull then MyIDField.AsInteger:=GetNextID; 
...}

function TLogFile.GetNextBlobID:Integer;
begin
  fBase.LOGQuery.Active:=False;
  fBase.LOGQuery.SQL.Text:= 'SELECT gen_id(GEN_BLOBTBL_ID, 1) from rdb$database';
  fBase.LOGQuery.Open;
  Result:=fBase.LOGQuery.Fields[0].AsInteger;
  fBase.LOGQuery.Close;
end;

{
var
  MemStrm: TMemoryStream;
  ImgJPG: TJpegImage;
begin
  ImgJPG.SaveToStream(MemStrm);
  MemStrm.Position:=_iZero;
  DM.qryMultiA.ParamByName('PS').LoadFromStream(MemStrm,ftBlob);
                                 SaveToStream
}



// **************** преобразование TMemoryStream в строку с 16-ричными значениями *********************
function MemoryStreamToHexStr(AStream: TMemoryStream): string;
const
 HexArr: array[0..15] of char =
 ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
 AByte: Byte;
 i: Integer;
begin
 SetLength(Result, AStream.Size * 2);
 for i := 0 to AStream.Size - 1 do
 begin
   AByte := PByte(Integer(AStream.Memory) + i)^;    // PByte
   Result[i * 2 + 1] := HexArr[AByte shr 4];
   Result[i * 2 + 2] := HexArr[AByte and $0F];
 end; 
end;


// **************** очистка временного модуля простых событий *********************
procedure TLogFile.EventListClear;
var i : integer;
begin
  for i := 0 to EventList.Count - 1 do begin
    EventItem := TEventItem(EventList.Items[i]);
    FreeAndNil(EventItem);
  end;
  EventList.Clear;
end;

procedure TLogFile.EventStringListClear;
var i : integer;
begin
  for i := 0 to EventStringList.Count - 1 do begin
    EventStringItem := TEventStringItem(EventStringList.Items[i]);
    FreeAndNil(EventStringItem);
  end;
  EventStringList.Clear;
end;

procedure TLogFile.UserListClear;
var i : integer;
begin
  for i := 0 to UserList.Count - 1 do begin
    UserItem := TUserItem(UserList.Items[i]);
    FreeAndNil(UserItem);
  end;
  UserList.Clear;
end;

procedure TLogFile.LOGListClear;
var i : integer;
begin
  for i := 0 to LOGList.Count - 1 do begin
    LOGItem := TLOGItem(LOGList.Items[i]);
    FreeAndNil(LOGItem);
  end;
  LOGList.Clear;
end;

constructor TLogFile.Create;
begin
  onCloseProgram  := false;
  EventList       := TList.Create;
  EventStringList := TList.Create;
  UserList        := TList.Create;
  LOGList         := TList.Create;
  STR             := TStringList.Create;
end;

destructor TLogFile.Destroy;
begin
  onCloseProgram := true;
  AddEventGroup(0,0,0,0);
  AddEventStringGroup(0,0,0,0,'');
  EventListClear;
  FreeAndNil(EventList);
  EventStringListClear;
  FreeAndNil(EventStringList);
  UserListClear;
  FreeAndNil(UserList);
  LOGListClear;
  FreeAndNil(LOGList);
  FreeAndNil(STR);
  inherited;
end;


initialization
  LogFile := TLogFile.Create;


finalization
  FreeAndNil(LogFile);

end.
