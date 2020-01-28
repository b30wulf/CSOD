unit fAddUtilDBF;

interface

uses IBQuery, IBDatabase, classes, Sysutils,utltypes,utlconst;


type
  TAddDBF = class(TObject)
    FQuery : TIBQuery;
    IBTr   : TIBTransaction;
    constructor Create(pDb:TIBDatabase; IBTr:TIBTransaction);
    destructor Destroy;
    function ExecQry(strSQL:String):Boolean;
    function OpenQry(strSQL:String;var nCount:Integer):Boolean;
    procedure CloseQry;
    function setQueryState(aid,mid,qState:Integer):Boolean;
    function addErrorArch(aid,mid:Integer):Boolean;
    function GetAbonL2Join(gid,nAbon:Integer;var pTable:TThreadList):Boolean;
    function DelArchData(dtBegin, dtEnd : TDateTime; abo,cmd:Integer):Boolean;
    function setDtBeginEndInQueryQroup(id:Integer;dtBegin,dtEnd:TDateTime;state:Integer):Integer;
    function setDtEndInQueryQroup(id:Integer;date:TDateTime;state:Integer):Integer;
    function GetMMeterTableEx(nIndex:Integer;var pTable:SL2TAG):Boolean;
    function GetQueryAbonsError(aboid:Integer; var data : QGABONS):Boolean;
  end;

implementation

constructor TAddDBF.Create(pDb:TIBDatabase; IBTr:TIBTransaction);
begin
  FQuery := TIBQuery.Create(Nil);
  IBTr := TIBTransaction.Create(nil);
  FQuery.Transaction:=IBTr;
  FQuery.Database:=pDb;
end;

destructor TAddDBF.Destroy;
begin
  FQuery.Destroy;
  FQuery := Nil;
end;

function TAddDBF.ExecQry(strSQL:String):Boolean;
Var
  res : Boolean;
Begin
  res := True;
  try
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(strSQL);
  FQuery.ExecSQL;
  FQuery.Close;
 except
  res := False;
 end;
 Result := res;
End;


function TAddDBF.OpenQry(strSQL:String;var nCount:Integer):Boolean;
Var
  res : Boolean;
Begin
  res    := False;
  nCount := 0;
  try
   FQuery.SQL.Clear;
   FQuery.SQL.Add(strSQL);
   FQuery.Open;
   FQuery.FetchAll;
   if FQuery.RecordCount>0 then  Begin nCount := FQuery.RecordCount; res := True;End;
  except
   res := False;
  end;
  Result := res;
End;

procedure TAddDBF.CloseQry;
Begin
  FQuery.Close;
End;

function TAddDBF.setQueryState(aid,mid,qState:Integer):Boolean;
Var
    strSQL,sqlQuery : String;
Begin
    if(mid=-1)  then sqlQuery := ' m_swABOID='+IntToStr(aid);
    if(mid<>-1) then sqlQuery := ' M_SWMID='+IntToStr(mid);
    strSQL := 'update l2tag set QUERYSTATE='+IntToStr(qState)+' where'+sqlQuery;
    Result := ExecQry(strSQL);
End;

function TAddDBF.addErrorArch(aid,mid:Integer):Boolean;
Var
    strSQL: String;
Begin
    strSQL := 'UPDATE OR INSERT INTO ARCHIVE_ERROR (m_swABOID, M_SWMID, M_DATE) VALUES('+IntToStr(aid) + ',' + IntToStr(mid) + ','  + '''' + DateToStr(now) + '''' +')';
    Result := ExecQry(strSQL);
End;

function TAddDBF.GetAbonL2Join(gid,nAbon:Integer;var pTable:TThreadList):Boolean;
Var
   // i : Integer;
    strSQL   : String;
    strQuery : String;
    res      : Boolean;
    nCount   : Integer;
    pD       : CJoinL2;
    vList    : TList;
    sStatus  : String;
Begin
    res := False;
    sStatus := '';
    strQuery := '';
    if(gid<>-1) then strQuery := ' and s3.QGID='+IntToStr(gid);
    strSQL := 'SELECT s2.pullid,s2.m_swMID,s0.m_swVMID,s2.M_SBYTYPE'+
              ' FROM SL3VMETERTAG as s0,SL3GROUPTAG as s1,L2TAG as s2,QGABONS as s3'+
              ' WHERE s0.m_sbyGroupID=s1.m_sbyGroupID'+
              ' and s2.m_swMID=s0.m_swMID'+
              ' and s2.m_sbyEnable=1'+
              ' and s1.m_swABOID=s3.aboid'+
              ' and s3.enable=1'+
              strQuery +
              ' and s1.m_swABOID='+IntToStr(nAbon)+
              ' ORDER BY s0.m_swVMID';
    if OpenQry(strSQL,nCount)=True then
    Begin
     vList  := pTable.LockList;
     res := True;
     while not FQuery.Eof do
     Begin
      pD := CJoinL2.Create;
      with FQuery do  Begin
       pD.m_swMID    := FieldByName('m_swMID').AsInteger;
       pD.m_swVMID   := FieldByName('m_swVMID').AsInteger;
       pD.m_swPullID := FieldByName('pullid').AsInteger;
       pD.M_SBYTYPE  := FieldByName('M_SBYTYPE').AsInteger;
       Next;
      End;
      vList.Add(pD);
     End;
     pTable.UnlockList;
    End;
    CloseQry;
    Result := res;
End;

function TAddDBF.DelArchData(dtBegin, dtEnd : TDateTime; abo,cmd:Integer):Boolean;
Var
    strSQL,strSel          : String;
    FirstCMDID,LastCMDID   : Integer;
Begin
    FirstCMDID := cmd - (cmd - 1) mod 4;
    LastCMDID  := FirstCMDID + 4;
    strSel := '(select distinct m_swVMID from SL3ABON as s0,SL3GROUPTAG as s1,SL3VMETERTAG as s2'+
    ' where s0.m_swABOID=s1.m_swABOID and s1.m_sbyGroupID=s2.m_sbyGroupID and s0.m_swABOID='+IntToStr(abo)+')';
    strSQL := 'DELETE FROM L3ARCHDATA WHERE m_swVMID in'+strSel+
    ' and m_swCMDID BETWEEN '+ IntToStr(fIRSTcmdid) + ' AND ' + IntToStr(LastCMDID) +
    ' and CAST(m_sTime as DATE) BETWEEN '+''''+DateToStr(dtBegin)+'''' +
    ' and ' + '''' + DateToStr(dtEnd) + '''';
    Result := ExecQry(strSQL);
End;

function TAddDBF.setDtBeginEndInQueryQroup(id:Integer;dtBegin,dtEnd:TDateTime;state:Integer):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set DTBEGINH='+''''+DateTimeToStr(dtBegin)+''''+','+
              ' DTENDH='+''''+DateTimeToStr(dtEnd)+''''+','+
              ' STATE='+IntToStr(state)+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;

function TAddDBF.setDtEndInQueryQroup(id:Integer;date:TDateTime;state:Integer):Integer;
Var
    strSql : String;
Begin
    strSql := 'update QGABONS set DTENDH='+''''+DateTimeToStr(date)+''''+','+
              ' STATE='+IntToStr(state)+
              ' where aboid='+IntToStr(id);
    ExecQry(strSQL);
    Result := 1;
End;

function TAddDBF.GetMMeterTableEx(nIndex:Integer;var pTable:SL2TAG):Boolean;
Var
    nCount : Integer;
    res    : Boolean;
    strSQL : String;
Begin
    res := False;
    //strSQL := 'SELECT L2TAG.*,L1TAG.m_sbyProtID FROM L2TAG,L1TAG WHERE L1TAG.m_sbyPortID=L2TAG.m_sbyPortID'+
    //' AND M_SBYENABLE=1'+
    //' AND m_swMID='+IntToStr(nIndex);
    strSQL := 'SELECT * FROM L2TAG'+
    ' WHERE M_SBYENABLE=1'+
    ' AND m_swMID='+IntToStr(nIndex);
    if OpenQry(strSQL,nCount)=True then
    Begin
     with FQuery,pTable do  Begin
      m_sbyID        := FieldByName('m_sbyID').AsInteger;
      //m_sbyProtID    := FieldByName('m_sbyProtID').AsInteger;
      m_sbyProtID    := 0;
      m_sbyGroupID   := FieldByName('m_sbyGroupID').AsInteger;
      m_swMID        := FieldByName('m_swMID').AsInteger;
      m_swVMID       := FieldByName('m_swVMID').AsInteger;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyType      := FieldByName('m_sbyType').AsInteger;
      m_sbyLocation  := FieldByName('m_sbyLocation').AsInteger;
      m_sddFabNum    := FieldByName('m_sddFabNum').AsString;
      m_schPassword  := FieldByName('m_schPassword').AsString;
      m_sddPHAddres  := FieldByName('m_sddPHAddres').AsString;
      m_sddPHAddres2 := '';
      m_swAddrOffset := 0;
      m_schName      := FieldByName('m_schName').AsString;
      m_sbyPortID    := FieldByName('m_sbyPortID').AsInteger;
      m_sbyRepMsg    := FieldByName('m_sbyRepMsg').AsInteger;
      m_swRepTime    := FieldByName('m_swRepTime').AsInteger;
      m_sfKI         := FieldByName('m_sfKI').asFloat;
      m_sfKU         := FieldByName('m_sfKU').asFloat;
      m_sfMeterKoeff := FieldByName('m_sfMeterKoeff').asFloat;
      m_sbyPrecision := FieldByName('m_sbyPrecision').AsInteger;
      m_swCurrQryTm  := FieldByName('m_swCurrQryTm').AsInteger;
      m_sPhone       := FieldByName('m_sPhone').AsString;
      m_sbyTSlice    := FieldByName('m_sbyTSlice').AsInteger;
      m_sbyModem     := FieldByName('m_sbyModem').AsInteger;
      m_sbyEnable    := FieldByName('m_sbyEnable').AsInteger;
      m_swMinNKan    := FieldByName('m_swMinNKan').AsInteger;
      m_swMaxNKan    := FieldByName('m_swMaxNKan').AsInteger;
      m_sdtSumKor    := FieldByName('m_sdtSumKor').AsDateTime;
      m_sdtLimKor    := FieldByName('m_sdtLimKor').AsDateTime;
      m_sdtPhLimKor  := FieldByName('m_sdtPhLimKor').AsDateTime;
      m_sAdvDiscL2Tag:= FieldByName('m_sAdvDiscL2Tag').AsString;
      m_sbyStBlock   := FieldByName('m_sbyStBlock').AsInteger;
      m_sTariffs     := FieldByName('m_sTariffs').AsString;
      m_bySynchro    := FieldByName('m_bySynchro').AsInteger;
      m_swKE         := FieldByName('m_swKE').AsInteger;
      m_sAD.m_sbyNSEnable := FieldByName('m_sbyNSEnable').AsInteger;
      m_sAD.m_sdwFMark    := FieldByName('m_sdwFMark').AsInteger;
      m_sAD.m_sdwEMark    := FieldByName('m_sdwEMark').AsInteger;
      m_sAD.m_sdwRetrans  := FieldByName('m_sdwRetrans').AsInteger;
      m_sAD.m_sdwKommut   := FieldByName('m_sdwKommut').AsInteger;
      m_sAD.m_sdwDevice   := FieldByName('m_sdwDevice').AsInteger;
      m_sAD.m_sbySpeed    := FieldByName('m_sbySpeed').AsInteger;
      m_sAD.m_sbyParity   := FieldByName('m_sbyParity').AsInteger;
      m_sAD.m_sbyStop     := FieldByName('m_sbyStop').AsInteger;
      m_sAD.m_sbyKBit     := FieldByName('m_sbyKBit').AsInteger;
      m_sAD.m_sbyPause    := FieldByName('m_sbyPause').AsInteger;
      m_sAD.m_nB0Timer    := FieldByName('m_nB0Timer').AsInteger;
      m_sAktEnLose   := FieldByName('m_sAktEnLose').AsFloat;
      m_sReaEnLose   := FieldByName('m_sReaEnLose').AsFloat;
      m_sTranAktRes  := FieldByName('m_sTranAktRes').AsFloat;
      m_sTranReaRes  := FieldByName('m_sTranReaRes').AsFloat;
      m_sGrKoeff     := FieldByName('m_sGrKoeff').AsInteger;
      m_sTranVolt    := FieldByName('m_sTranVolt').AsInteger;
      m_sTpNum       := FieldByName('m_sTpNum').AsString;
      pullid         := FieldByName('pullid').AsInteger;
      M_SWABOID      := FieldByName('M_SWABOID').AsInteger;
      m_aid_channel  := FieldByName('M_SWABOID_CHANNEL').AsInteger;
      m_aid_tariff   := FieldByName('M_SWABOID_TARIFF').AsInteger;
     End;
     res := True;
    End;
    CloseQry;
    Result := res;
End;


function TAddDBF.GetQueryAbonsError(aboid:Integer; var data : QGABONS):Boolean;
Var
    strSQL : String;
    res    : Boolean;
    nCount : Integer;
    dbIsOk : Double;
    dbIsNo : Double;
//    dbIsEr : Double;
    dbAllCt: Double;
Begin
    res := false;
    strSQL := 'SELECT'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and M_SWABOID=s0.ABOID) as ALLCOUNTER,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_OK)+' and M_SWABOID=s0.ABOID) as ISOK,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_NO)+' and M_SWABOID=s0.ABOID) as ISNO,'+
    ' (select sum(1) from l2tag where M_SBYENABLE=1 and QUERYSTATE='+IntToStr(QUERY_STATE_ER)+' and M_SWABOID=s0.ABOID) as ISER'+
    ' FROM QGABONS as s0'+
    ' where s0.ABOID='+IntToStr(aboid);
    if OpenQry(strSQL,nCount)=True then
    Begin
     while not FQuery.Eof do Begin
      if data=nil then data := QGABONS.Create;
      data.ALLCOUNTER  := FQuery.FieldByName('ALLCOUNTER').AsInteger;
      data.ISOK        := FQuery.FieldByName('ISOK').AsInteger;
      data.ISNO        := FQuery.FieldByName('ISNO').AsInteger;
      data.ISER        := FQuery.FieldByName('ISER').AsInteger;
      dbAllCt          := data.ALLCOUNTER;
      if(dbAllCt=0) then dbAllCt:=1;
      dbIsOk           := data.ISOK;
      dbIsNo           := data.ISNO;
      data.PERCENT     := 100*(dbAllCt-dbIsNo)/dbAllCt;
      data.QUALITY     := 100*dbIsOk/dbAllCt;
      FQuery.Next;
     End;
    res := True;
    End;
    CloseQry;
    Result := res;
End;
end.
