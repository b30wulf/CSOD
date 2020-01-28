unit utlQueryQualityDyn;

interface

uses
  Forms, ComObj, SysUtils, utldynconnect,knsl3EventBox,utlconst;

type
  TQQData = record
    Dats : TDateTime;  // 10 символов
    Stat : Byte;       // 1-3 символа
    Perc : Byte;       // 1-3 символа
  end;

  TQueryQualityDyn = class
    public
      Months : TQQData;  // Месяц   17 символов  DD.MM.YYYY;X;XXX;
      Days   : TQQData;  // День    17 символов  DD.MM.YYYY;X;XXX;
      Currs  : TQQData;  // Текущая 17 символов  DD.MM.YYYY;X;XXX;

      procedure GetQueryQuality(pDb : CDBDynamicConn; AbonID : integer);
      procedure SetQueryQuality(pDb : CDBDynamicConn; AbonID : integer);
      procedure SetQueryQualityInNil(pDb : CDBDynamicConn; AbonID : integer); // для заполнения значений пустыми значениями ('')
      function GetQQMonths(pDb : CDBDynamicConn; AbonID : integer): TQQData;
      procedure SetQQMonths(pDb : CDBDynamicConn; AbonID : integer; QData : TQQData);
      function GetQQDays(pDb : CDBDynamicConn; AbonID : integer): TQQData;
      procedure SetQQDays(pDb : CDBDynamicConn; AbonID : integer; QData : TQQData);
      function GetQQCurrs(pDb : CDBDynamicConn; AbonID : integer): TQQData;
      procedure SetQQCurrs(pDb : CDBDynamicConn; AbonID : integer; QData : TQQData);
      function GetPercent(pDb : CDBDynamicConn; AbonID : integer) : Double;
  end;

{var QueryQuality : TQueryQuality;
    QQData       : TQQData;   }


implementation
{$R+}
function GetStr(var str : string):string;
var h : Integer;
begin
  h := Pos(';', str);
  if h <> 0 then begin
    Result := Copy(str,1,h-1);
    delete(str,1,h);
  end else Result := '';
end;

function GetDate(var str : string): TDateTime;
var s : string;
begin
  s := GetStr(str);
  if Length(s) > 0 then begin
    try
      Result := StrToDate(s);
    except
      Result := StrToDate('01.01.1990');
    end;
  end else Result := StrToDate('01.01.1990');
end;

function GetByte(var str : string) : Byte;
var s : string;
begin
  s := GetStr(str);
  if Length(s) > 0 then begin
    try
      Result := StrToInt(s);
    except
      Result := StrToInt('255');
    end;
  end else Result := StrToInt('255');
end;

{ TQueryQuality }

procedure TQueryQualityDyn.GetQueryQuality(pDb : CDBDynamicConn; AbonID : integer);
var strSQL     : string;
    nCount     : integer;
    str        : string;
begin
  strSQL:='SELECT QUERYQUALITY FROM SL3ABON WHERE M_SWABOID = ' + IntToStr(AbonID);
  if pDb.OpenQry(strSQL,nCount)=True then begin
    //for i := 0 to pDb.FADOQuery.RecordCount-1 do begin
      Str := pDb.FADOQuery.FieldByName('QUERYQUALITY').AsString;
      Months.Dats := GetDate(str);
      Months.Stat := GetByte(str);
      Months.Perc := GetByte(str);
      Days.Dats   := GetDate(str);
      Days.Stat   := GetByte(str);
      Days.Perc   := GetByte(str);
      Currs.Dats  := GetDate(str);
      Currs.Stat  := GetByte(str);
      Currs.Perc  := GetByte(str);
      //pDb.FADOQuery.Next;
    //end;
  end
end;


procedure TQueryQualityDyn.SetQueryQuality(pDb : CDBDynamicConn; AbonID: integer);
var str        : string;
    strSQL     : string;
begin
{  Months.Dats := StrToDate('1.1.2001');
  Months.Stat := 10;
  Months.Perc := 98;
  Days.Dats := StrToDate('2.2.2002');
  Days.Stat := 20;
  Days.Perc := 99;
  Currs.Dats := StrToDate('3.3.2003');
  Currs.Stat := 30;
  Currs.Perc := 100; }

  str :=       DateToStr(Months.Dats) + ';' + IntToStr(Months.Stat) + ';' + IntToStr(Months.Perc) + ';';
  str := str + DateToStr(Days.Dats)   + ';' + IntToStr(Days.Stat)   + ';' + IntToStr(Days.Perc)   + ';';
  str := str + DateToStr(Currs.Dats)  + ';' + IntToStr(Currs.Stat)  + ';' + IntToStr(Currs.Perc)  + ';';
  strSQL := 'UPDATE SL3ABON SET QUERYQUALITY = ''' + str + ''' WHERE M_SWABOID = ' + IntToStr(AbonID);
  pDb.ExecQry(strSQL);
end;

procedure TQueryQualityDyn.SetQueryQualityInNil(pDb : CDBDynamicConn; AbonID : integer);
var str        : string;
    strSQL     : string;                
begin
  str := ';;;;;;;;;';
  strSQL := 'UPDATE SL3ABON SET QUERYQUALITY = ''' + str + ''' WHERE M_SWABOID = ' + IntToStr(AbonID);
  pDb.ExecQry(strSQL);
end;

function TQueryQualityDyn.GetQQMonths(pDb : CDBDynamicConn; AbonID: integer): TQQData;
begin
  GetQueryQuality(pDb, AbonID);
  Result := Months;
end;

procedure TQueryQualityDyn.SetQQMonths(pDb : CDBDynamicConn; AbonID: integer; QData: TQQData);
begin
  GetQueryQuality(pDb, AbonID);
  Months.Dats := QData.Dats;
  Months.Stat := QData.Stat;
  Months.Perc := QData.Perc;
  SetQueryQuality(pDb, AbonID);
end;

function TQueryQualityDyn.GetQQDays(pDb : CDBDynamicConn; AbonID: integer): TQQData;
begin
  GetQueryQuality(pDb, AbonID);
  Result := Days;
end;

procedure TQueryQualityDyn.SetQQDays(pDb : CDBDynamicConn; AbonID: integer; QData: TQQData);
begin
  GetQueryQuality(pDb, AbonID);
  Days.Dats := QData.Dats;
  Days.Stat := QData.Stat;
  Days.Perc := QData.Perc;
  SetQueryQuality(pDb, AbonID);
end;

function TQueryQualityDyn.GetQQCurrs(pDb : CDBDynamicConn; AbonID: integer): TQQData;
begin
  GetQueryQuality(pDb, AbonID);
  Result := Currs;
end;

procedure TQueryQualityDyn.SetQQCurrs(pDb : CDBDynamicConn; AbonID: integer; QData: TQQData);
begin
  GetQueryQuality(pDb, AbonID);
  Currs.Dats := QData.Dats;
  Currs.Stat := QData.Stat;
  Currs.Perc := QData.Perc;
  SetQueryQuality(pDb, AbonID);
end;


function TQueryQualityDyn.GetPercent(pDb : CDBDynamicConn; AbonID: integer): Double;
var strSQL     : string;
    nCount     : integer;
    d1, d2     : Double;
begin
  try
    d1:=0;
    d2:=0;
    strSQL:='SELECT COUNT(L2T.M_SWABOID) as S1, ' +
            'COUNT(case when L2T.QUERYSTATE=0 then L2T.M_SWABOID end) as S2, ' +
            'COUNT(case when L2T.QUERYSTATE=2 then L2T.M_SWABOID end) as S3 ' +
            'FROM QUERYGROUP QG, QGABONS QGA, L2TAG L2T ' +
            'WHERE L2T.M_SBYENABLE = 1 AND QG.ID = QGA.QGID ' +
            '  AND QGA.ABOID = L2T.M_SWABOID AND QGA.ABOID = ' + IntToStr(AbonID) + ' ' +
            'GROUP BY QG.NAME, QG.ID ';
    if pDb.OpenQry(strSQL,nCount)=True then begin
      d1 := StrToFloat(pDb.FADOQuery.FieldByName('S2').AsString);
      d2 := StrToFloat(pDb.FADOQuery.FieldByName('S1').AsString);
      if (d2<>0)then
      Result := (d1 / d2) * 100
      else
      Result := -1;
    end else Result := -1;
  except
    if EventBox<>Nil then  EventBox.FixEvents(ET_CRITICAL,'(d1/d2'+FloatToStr(d1)+'/'+FloatToStr(d2)+')GetPercent!!!');
    Result := -1;
  end;
end;

end.
