unit knsl3datamatrix;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlbox,utlconst,
controls,knsl5tracer,knsl3EventBox,utlTimeDate,utlDataBase,knsl3datatype,utlexparcer;
type
    CDataMatrix = class
    private
     m_nCount: Integer;
     m_nCMD  : TStringList;
     m_nEVT  : CEvaluator;
     FCJoin  : Pointer;
     m_nDescDB : Integer;
     FDB     : PCDBDynamicConn;
     procedure InitData(nAID,nVMID:Integer);
     procedure InitCommand;
     function  CheckData(nVMID,nCMDID:Integer):Boolean;
     function  FreeTime(nVMID,nCMDID:Integer):Boolean;
     function  GetTrueDate(nVMID,nCMDID:Integer;var nIsUpdate:Boolean;var sTime:TDateTime):Boolean;
     function  FindToken(var str:String;var nVMID,nCMDID:Integer;var sPName:String):Boolean;
     function  CalcCell(nVMID,nCMDID,nIndex:Integer;var Value:Extended;var sTime:TDateTime):Boolean;
     function  IsTrueValue(var dbVal:Double):Boolean;
     procedure SetLockCmd(nVMID,nCMDID:Integer;byLockState:Byte);
     function  GetMaxCMD(var nCMD:Integer):Integer;
     function  CalculateCMD(nVMID,nCMDID:Integer):Boolean;
     procedure FreeCmdData(nVMID,nCMDID:Integer);
     procedure SetInState(nVMID,nCMDID:Integer;byInState:Byte);
     procedure SetVMeterName;
    public
     m_nDMX : array[0..MAX_VMETER,0..QRY_END] of CData;
     destructor Destroy();override;
     constructor Create;
     procedure getMeterFromAbon(abon,cmd : Integer;var mids,vmids:TStringList);
     function ExtractData(var pMsg:CMessage):Boolean;
     function Calculate(nVMID,nCMDID:Integer):Boolean;
     procedure FreeData(nVMID,nCMDID:Integer);
     procedure SetLockState(nVMID,nCMDID:Integer;byState:Byte);
     procedure SetAllLockState(nVMID:Integer;byState:Byte);
     function  Flush(nVMID,nCMDID:Integer):Boolean;
     function  GetLevel(nVMID,nCMDID:Integer):Byte;
     function  GetCluster(nVMID,nCMDID:Integer):Byte;
     function  GetState(nVMID,nCMDID:Integer):Byte;
     procedure SetState(nVMID,nCMDID:Integer;byState:Byte);
     procedure OnInitDMX(nAID,nVMID:Integer);
    public
     property PCJoin : Pointer read FCJoin write FCJoin;
    End;
    PCDataMatrix = ^CDataMatrix;
implementation
constructor CDataMatrix.Create;
Begin
     m_nCMD := TStringList.Create;
     m_nEVT := CEvaluator.Create;
     m_nMeterName := TStringList.Create ;
     FDB    := m_pDB.CreateConnectEx(m_nDescDB);
     InitData(-1,-1);
     InitCommand;
End;
destructor CDataMatrix.Destroy;
Var
     i,j:Integer;
Begin
     m_nCMD.Clear;
     m_nCMD.Destroy;
     m_nEVT.Destroy;
     m_nMeterName.Destroy;
     m_pDB.DynDisconnectEx(m_nDescDB);
     for i:=0 to MAX_VMETER-1 do
     for j:=0 to QRY_END-1 do
     if m_nDMX[i,j]<>Nil then
     Begin
      m_nDMX[i,j].Destroy;
      m_nDMX[i,j] := Nil;
     End;
End;
procedure CDataMatrix.InitData(nAID,nVMID:Integer);
var
     pTable : SL3VMETERTAG;
     i : Integer;
Begin
     m_pDB.GetVMNameTable(m_sVMName);
     if m_pDB.GetVPMatrix(nAID,nVMID,pTable)=True then
     Begin
      for i:=0 to pTable.Item.Count-1 do
      Begin
       with pTable.Item.Items[i] do
       Begin   //m_sbyDataGroup <=> Group Level; m_sbyRecursive<=>m_sbyDeltaPer m_sbyDataGroup<=> Тип счетчика
        if m_nDMX[m_swVMID,m_swParamID]<>Nil then m_nDMX[m_swVMID,m_swParamID].Destroy;
        case m_snDataType of
             DTP_FLT48    : m_nDMX[m_swVMID,m_swParamID] := CDataF48.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_DBL1     : m_nDMX[m_swVMID,m_swParamID] := CDataD1.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_DBL3     : m_nDMX[m_swVMID,m_swParamID] := CDataD3.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_DBL4     : m_nDMX[m_swVMID,m_swParamID] := CDataD4.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_DBL5     : m_nDMX[m_swVMID,m_swParamID] := CDataD5.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_DBL48    : m_nDMX[m_swVMID,m_swParamID] := CDataD48.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_DATETIME : m_nDMX[m_swVMID,m_swParamID] := CDataDateTime.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
             DTP_EVENT    : m_nDMX[m_swVMID,m_swParamID] := CDataEvent.Create(FDB,m_swAID,m_swGID,m_swVMID,m_swMID,m_swParamID,m_sbyRecursive,m_stSvPeriod,m_sbyDataGroup,m_sblSaved,m_sblTarif,m_sParamExpress);
        End;
        m_nDMX[m_swVMID,m_swParamID].m_sbyPortId := m_sbyPortID;
       End;
      End;
     End;
     SetVMeterName;
     SetLength(pTable.Item.Items,0);
End;

procedure CDataMatrix.getMeterFromAbon(abon,cmd : Integer;var mids,vmids:TStringList);
Var
     data : CData;
     i    : Integer;
Begin
     for i:=0 to MAX_VMETER-1 do
     Begin
       data := m_nDMX[i,cmd];
       if data<>nil then
       Begin
          if (data.m_snAID=abon) then
          Begin
           mids.Add(IntToStr(data.m_snMID));
           vmids.Add(IntToStr(data.m_snVMID));
          End;
       End;
     End;
End;

procedure CDataMatrix.SetVMeterName;
Var
     i : Integer;
     pTable : SL3GROUPTAG;
Begin
     m_nMeterName.Clear;
     if m_pDB.GetAbonVMetersTable(-1,-1,pTable) then
     Begin
      for i:=0 to pTable.Item.Count-1 do
      m_nMeterName.Add('('+IntToStr(pTable.Item.Items[i].m_swVMID)+')'+pTable.Item.Items[i].m_sVMeterName);
     End;
     SetLength(pTable.Item.Items,0);
end;
procedure CDataMatrix.OnInitDMX(nAID,nVMID:Integer);
Begin
     InitData(nAID,nVMID); 
End;
procedure CDataMatrix.InitCommand;
var
     pTable : QM_PARAMS;
     i : Integer;
Begin
     m_nCMD.Clear;
     if m_pDB.GetParamsTypeTable(pTable)=True then
     Begin
      for i:=0 to pTable.Count-1 do
      with pTable.Items[i] do m_nCMD.Add(m_sEName);
     End;
     SetLength(pTable.Items,0);
End;
function CDataMatrix.ExtractData(var pMsg:CMessage):Boolean;
Var
     nCID,nVMID : Integer;
Begin
     try
     nVMID := pMsg.m_swObjID;
     nCID  := pMsg.m_sbyInfo[1];
     if Assigned(m_nDMX[nVMID,nCID])then
     m_nDMX[nVMID,nCID].ExtractData(pMsg);
     except
      TraceER('(__)CDMMD::>Error In CDataMatrix.ExtractData!!!');
     end;
End;
function CDataMatrix.Calculate(nVMID,nCMDID:Integer):Boolean;
Var
     i,Count : Integer;
Begin
     try
     Count := GetMaxCMD(nCMDID);
     for i:=0 to Count-1 do CalculateCMD(nVMID,nCMDID+i);
     except
      TraceER('(__)CDMMD::>Error In CDataMatrix.Calculate!!!');
     end;
End;
function CDataMatrix.CalculateCMD(nVMID,nCMDID:Integer):Boolean;
Var
     Value : Extended;
     sTime : TDateTime;
     i     : Integer;
     dbValue : Double;
     res : Boolean;
Begin
     sTime := 0;
     if Assigned(m_nDMX[nVMID,nCMDID])then
     with m_nDMX[nVMID,nCMDID] do
     Begin
      //LoadData;
      //if (m_sbyLevel<>0)and(m_sbyType<>MET_VZLJOT) then
      if (m_sbyType=MET_SUMM)or(m_sbyType=MET_GSUMM) then
      CheckData(nVMID,nCMDID);
      //if nVMID=8 then
      // sTime := 0;
      for i:=0 to Count-1 do
      Begin
       res := CalcCell(nVMID,nCMDID,i,Value,sTime);
       dbValue     := Value;
       IsTrueValue(dbValue);
       SetValue[i] := dbValue;
       if res=True then
        SetMask(i)
         else
          ReSetMask(i);

       //SetVal(i,dbValue);
       m_sTime     := sTime;
       //TraceL(4,nVMID,'(__)CDTMX::>CALC: '+DateTimeToStr(m_sTime)+' SID:'+IntToStr(i)+' CMD:'+m_nCommandList.Strings[nCMDID]+' VAL:'+FloatToStr(Value));
      End;
      //FreeTime(nVMID,nCMDID);
      //if (m_sbyLevel<>0) then
      //FreeData(nVMID,nCMDID);
      //GetTMState
      {if (m_sbyLevel=0)and(m_sTime<>0) then} EventBox.FixEvents(ET_NORMAL,'Расчет. Объект:'+GetVMName(nVMID)+' Время: '+DateTimeToStr(m_sTime)+' Параметр:'+GetCMD(nCMDID));
      //if m_byInState=DT_NEW then Flush;
      //TraceL(4,nVMID,'(__)CDTMX::>CALC: '+DateTimeToStr(m_sTime)+' CMD:'+m_nCommandList.Strings[nCMDID]);
     End;
End;
function CDataMatrix.IsTrueValue(var dbVal:Double):Boolean;
Begin
   Result := True;
   if IsNaN(dbVal) or IsInfinite(dbVal) or (abs(dbVal)<0.000001) or (abs(dbVal)>1000000000) then
   Begin
    dbVal  := 0.0;
    Result := False;
   End;
End;
function CDataMatrix.CalcCell(nVMID,nCMDID,nIndex:Integer;var Value:Extended;var sTime:TDateTime):Boolean;
Var
     lVMID,lCMDID : Integer;
     Expression,sPName : String;
     blMask,res : Boolean;
Begin
     res:=True;
     with m_nDMX[nVMID,nCMDID] do
     Begin
      Expression        := Express+';';
      m_nEVT.Expression := Express;
      blMask            := True;
      while(FindToken(Expression,lVMID,lCMDID,sPName))=True do
      Begin
       if m_nDMX[lVMID,lCMDID]<>Nil then
       Begin
        m_nEVT.Variable[sPName] := m_nDMX[lVMID,lCMDID].GetValue(nIndex);
        blMask  := blMask and m_nDMX[lVMID,lCMDID].GetMask(nIndex);
        if blMask=False then res:=False;
        if m_nDMX[lVMID,lCMDID].GetTMState=True then
        Begin
         sTime    := m_nDMX[lVMID,lCMDID].m_sTime;
         IsUpdate := m_nDMX[lVMID,lCMDID].IsUpdate;
        End;
       if blMask=True then SetMask(nIndex) else ReSetMask(nIndex);
       End else m_nEVT.Variable[sPName] := 0;
      End;
     End;
     Value := m_nEVT.Value;
     Result := res;
End;
function CDataMatrix.CheckData(nVMID,nCMDID:Integer):Boolean;
Var
     lVMID,lCMDID : Integer;
     Expression,sPName : String;
     sTime    : TDateTime;
     nIsUpdate : Boolean;
Begin
     Result := False;
     if GetTrueDate(nVMID,nCMDID,nIsUpdate,sTime)=False then exit;
     with m_nDMX[nVMID,nCMDID] do
     Begin
      Expression := Express+';';
      while(FindToken(Expression,lVMID,lCMDID,sPName))=True do
      Begin
       if m_nDMX[lVMID,lCMDID]<>Nil then
       Begin
        m_nDMX[lVMID,lCMDID].LoadData(sTime,nIsUpdate);
        Result := True;
       End;
      End;
     End;
End;
function CDataMatrix.FreeTime(nVMID,nCMDID:Integer):Boolean;
Var
     lVMID,lCMDID : Integer;
     Expression,sPName : String;
     sTime    : TDateTime;
Begin
     Result := False;
     with m_nDMX[nVMID,nCMDID] do
     Begin
      Expression := Express+';';
      while(FindToken(Expression,lVMID,lCMDID,sPName))=True do
      Begin
       if m_nDMX[lVMID,lCMDID]<>Nil then
       Begin
        m_nDMX[lVMID,lCMDID].m_sTime := 0;
        Result := True;
       End;
      End;
     End;
End;
function CDataMatrix.GetTrueDate(nVMID,nCMDID:Integer;var nIsUpdate:Boolean;var sTime:TDateTime):Boolean;
Var
     lVMID,lCMDID : Integer;
     Expression,sPName : String;
     sOTime : TDateTime;
Begin
     Result    := False;
     sTime     := 0;
     nIsUpdate := True;
     with m_nDMX[nVMID,nCMDID] do
     Begin
      Expression        := Express+';';
      //m_nEVT.Expression := Express;
      while(FindToken(Expression,lVMID,lCMDID,sPName))=True do
      Begin
       if m_nDMX[lVMID,lCMDID]<>Nil then
       Begin
        if m_nDMX[lVMID,lCMDID].GetTMState=True then
        Begin
         sTime    := m_nDMX[lVMID,lCMDID].m_sTime;
         //if sOTime>sTime then sTime := sOTime;
         nIsUpdate := m_nDMX[lVMID,lCMDID].IsUpdate;
         Result    := True;
        End;
       End;
      End;
     End;
End;
function CDataMatrix.FindToken(var str:String;var nVMID,nCMDID:Integer;var sPName:String):Boolean;
Var
     res   : Boolean;
     i,j,k,n,km : Integer;
     sV,sP : String;
Begin
     Result := False;
     //Find VMID
     i := Pos('v',str)+1;
     if i=1 then exit;
     if i>2 then Begin Delete(str,1,i-2);i:=Pos('v',str)+1;End;
     j := Pos('_',str);
     if j<=i then exit;
     sV := Copy(str,i,j-i);
     nVMID := StrToInt(sV);
     //Find CMD
     km := 100;
     for n:=0 to 7 do
     Begin
      k:=Pos(chEndTn[n],str);
      if (k<=km) and (k<>0) then km:=k;
     End;
     if km>=j then sP:=Copy(str,j+1,km-(j+1));
     if km=100 then exit;
     //Extract Value
     if sP<>'' then
     Begin
      nCMDID := m_nCMD.IndexOf(sP);
      sPName := Copy(str,i-1,km-(i-1));
      Delete(str,i-1,(km+1)-(i-1));
      Result := True;
     End;
End;
procedure CDataMatrix.SetAllLockState(nVMID:Integer;byState:Byte);
Var
     i,nCMDID,lCMDID,Count : Integer;
Begin
     for nCMDID:=QRY_AUTORIZATION to QRY_END do
     Begin
      lCMDID := nCMDID;
      Count  := GetMaxCMD(lCMDID);
      for i:=0 to Count-1 do SetLockCmd(nVMID,lCMDID+i,byState);
     End;
End;
procedure CDataMatrix.SetLockState(nVMID,nCMDID:Integer;byState:Byte);
Var
     i,Count : Integer;
Begin
     Count := GetMaxCMD(nCMDID);
     for i:=0 to Count-1 do SetLockCmd(nVMID,nCMDID+i,byState);
End;
procedure CDataMatrix.SetLockCmd(nVMID,nCMDID:Integer;byLockState:Byte);
Begin
     if Assigned(m_nDMX[nVMID,nCMDID])then
     m_nDMX[nVMID,nCMDID].m_sbyLockState := byLockState;
End;
procedure CDataMatrix.SetState(nVMID,nCMDID:Integer;byState:Byte);
Var
     i,Count : Integer;
Begin
     Count := GetMaxCMD(nCMDID);
     for i:=0 to Count-1 do SetInState(nVMID,nCMDID+i,byState);
End;
{
QRY_MGAKT_POW_S       = 37;//8
  QRY_MGAKT_POW_A       = 38;
  QRY_MGAKT_POW_B       = 39;
  QRY_MGAKT_POW_C       = 40;
  QRY_MGREA_POW_S       = 41;//9
  QRY_MGREA_POW_A       = 42;
  QRY_MGREA_POW_B       = 43;
  QRY_MGREA_POW_C       = 44;
  QRY_U_PARAM_S         = 45;
  QRY_U_PARAM_A         = 46;//10
  QRY_U_PARAM_B         = 47;
  QRY_U_PARAM_C         = 48;
  QRY_I_PARAM_S         = 49;
  QRY_I_PARAM_A         = 50;//11
  QRY_I_PARAM_B         = 51;
  QRY_I_PARAM_C         = 52;
  QRY_FREQ_NET          = 53;//13
  QRY_KOEF_POW_A        = 54;//12
  QRY_KOEF_POW_B        = 55;
  QRY_KOEF_POW_C        = 56;
}
procedure CDataMatrix.FreeData(nVMID,nCMDID:Integer);
Var
     i,Count : Integer;
Begin
     Count := GetMaxCMD(nCMDID);
     if nCMDID=-1 then Begin nCMDID:=0;Count:=QRY_END;End;
     for i:=0 to Count-1 do
     FreeCmdData(nVMID,nCMDID+i);
End;
procedure CDataMatrix.FreeCmdData(nVMID,nCMDID:Integer);
Begin
     if Assigned(m_nDMX[nVMID,nCMDID])then
     m_nDMX[nVMID,nCMDID].FreeCmdData;
End;
function CDataMatrix.Flush(nVMID,nCMDID:Integer):Boolean;
Var
     i,Count : Integer;
Begin
     Count := GetMaxCMD(nCMDID);
     for i:=0 to Count-1 do
     Begin
      if Assigned(m_nDMX[nVMID,nCMDID+i])then
      m_nDMX[nVMID,nCMDID+i].Flush;
     End;
End;
procedure CDataMatrix.SetInState(nVMID,nCMDID:Integer;byInState:Byte);
Begin
     if Assigned(m_nDMX[nVMID,nCMDID])then
     m_nDMX[nVMID,nCMDID].m_byInState := byInState;
End;
function CDataMatrix.GetLevel(nVMID,nCMDID:Integer):Byte;
Begin
     Result := 0;
     if Assigned(m_nDMX[nVMID,nCMDID])then
     Result := m_nDMX[nVMID,nCMDID].m_sbyLevel;
End;
function CDataMatrix.GetCluster(nVMID,nCMDID:Integer):Byte;
Begin
     Result := 0;
     if Assigned(m_nDMX[nVMID,nCMDID])then
     Result := m_nDMX[nVMID,nCMDID].m_snCLSID;
End;
function CDataMatrix.GetState(nVMID,nCMDID:Integer):Byte;
Begin
     Result := 0;
     if Assigned(m_nDMX[nVMID,nCMDID])then
     Result := m_nDMX[nVMID,nCMDID].m_byInState;
End;
{
QRY_MGAKT_POW_S       = 37;//8
  QRY_MGAKT_POW_A       = 38;
  QRY_MGAKT_POW_B       = 39;
  QRY_MGAKT_POW_C       = 40;
  QRY_MGREA_POW_S       = 41;//9
  QRY_MGREA_POW_A       = 42;
  QRY_MGREA_POW_B       = 43;
  QRY_MGREA_POW_C       = 44;
  QRY_U_PARAM_S         = 45;
  QRY_U_PARAM_A         = 46;//10
  QRY_U_PARAM_B         = 47;
  QRY_U_PARAM_C         = 48;
  QRY_I_PARAM_S         = 49;
  QRY_I_PARAM_A         = 50;//11
  QRY_I_PARAM_B         = 51;
  QRY_I_PARAM_C         = 52;
  QRY_FREQ_NET          = 53;//13
  QRY_KOEF_POW_A        = 54;//12
  QRY_KOEF_POW_B        = 55;
  QRY_KOEF_POW_C        = 56;
  QRY_KPRTEL_KPR        = 57;//24
  QRY_KPRTEL_KE         = 58;
}
function CDataMatrix.GetMaxCMD(var nCMD:Integer):Integer;
Begin
     Result := 1;
     if ((nCMD>=QRY_ENERGY_SUM_EP)and(nCMD<=QRY_I_PARAM_C))    or
        ((nCMD>=QRY_MAX_POWER_EP) and(nCMD<=QRY_MAX_POWER_RM)) then Result := 4 else
     if ((nCMD>=QRY_KOEF_POW_A)   and(nCMD<=QRY_KOEF_POW_C))   then Result := 3 else
     if ((nCMD=QRY_FREQ_NET)or(nCMD=QRY_KPRTEL_KPR)or(nCMD=QRY_KPRTEL_KE)or(nCMD=QRY_DATA_TIME))or
        ((nCMD>=QRY_JRNL_T1)      and(nCMD<=QRY_JRNL_T4))      then Result := 1 else
     if (nCMD=QRY_SUM_RASH_V)then Result := 5 else
     if ((nCMD>=QRY_POD_TRYB_HEAT)and(nCMD<=QRY_WORK_TIME_ERR))then Result := 11 else
     if ((nCMD>=QRY_NACKM_POD_TRYB_HEAT)and(nCMD<=QRY_NACKM_WORK_TIME_ERR))then Result := 11;

     if nCMD=QRY_MGAKT_POW_A then nCMD:=QRY_MGAKT_POW_S;
     if nCMD=QRY_MGREA_POW_A then nCMD:=QRY_MGREA_POW_S;
     if nCMD=QRY_U_PARAM_A   then nCMD:=QRY_U_PARAM_S;
     if nCMD=QRY_I_PARAM_A   then nCMD:=QRY_I_PARAM_S;
End;

end.
