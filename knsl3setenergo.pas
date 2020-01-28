unit knsl3setenergo;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate,math,utldatabase;
type
    CSetEnergotel = class
    private
     m_pData   : CCDatas;
     m_pVMeter : SL3GROUPTAG;
     m_pGrData : L3GRAPHDATAS;
     m_sLArchDate  : TDateTime;
     m_sLGraphDate : TDateTime;
     procedure SetArchEnergoDataItem(var pVMeter:SL3VMETERTAG;var pData:CCData);
     procedure SetHalfEnergoDataItem(var pVMeter:SL3VMETERTAG;var pData:L3GRAPHDATA);
     procedure SetArchData(tDate0,tDate1:TDateTime);
     procedure SetHalfData(tDate0,tDate1:TDateTime);
     procedure SetEventData(tDate : TDateTime);
     procedure CopyArchiveEnergo(IsSave:Boolean);
     procedure CopyGraphEnergo(IsSave:Boolean);
    public
     procedure Init;
     procedure CopyEnergoInfo(IsSave:Boolean);
     procedure CopyEnergoInfoUser(dtDate0,dtDate1:TDateTime);
    public
    End;
var
  m_nEN : CSetEnergotel;
implementation
procedure CSetEnergotel.Init;
Begin
    m_pDB.GetVMetersTable(-1,m_pVMeter);
    m_sLArchDate  := Now;
    m_sLGraphDate := Now;
End;
{
  QRY_NAK_EN_DAY_EP     = 17;//42
  QRY_NAK_EN_DAY_EM     = 18;
  QRY_NAK_EN_DAY_RP     = 19;
  QRY_NAK_EN_DAY_RM     = 20;
}
procedure CSetEnergotel.SetArchData(tDate0,tDate1:TDateTime);
Var
    i,j : Integer;
    DataBrestEnergo : Val;
Begin
    DataBrestEnergo.n_obj := $ffff;
    DataBrestEnergo.izm_type := 5;
    m_pDB.DelArchEnergoData(tDate0{-10}, tDate1, DataBrestEnergo);
    for i:=0 to m_pVMeter.m_swAmVMeter-1 do
    Begin
     if m_pVMeter.Item.Items[i].m_sbyExport=1 then
     Begin
      if m_pDB.GetGDataEnergo(tDate1,tDate0{-10},m_pVMeter.Item.Items[i].m_swVMID,QRY_NAK_EN_DAY_EP,-1,m_pData) then
      Begin
       for j:=0 to m_pData.Count-1 do
       SetArchEnergoDataItem(m_pVMeter.Item.Items[i],m_pData.Items[j]);
      End;
     End;
    End;
End;
procedure CSetEnergotel.SetArchEnergoDataItem(var pVMeter:SL3VMETERTAG;var pData:CCData);
Var
     m_pTable : VAl;
Begin
    m_pTable.n_obj      := pVMeter.m_sbyPortID;
    //m_pTable.link_adr   := StrToInt(pVMeter.m_sddPHAddres);
    m_pTable.link_adr   := pVMeter.m_swVMID;
    m_pTable.n_ri       := 0;
    m_pTable.izm_type   := pData.m_swCMDID - QRY_NAK_EN_DAY_EP + 5 ;
    m_pTable.data       := pData.m_sTime;
    m_pTable.n_zone     := pData.m_swTID;
    m_pTable.flag       := '';
    m_pTable.znach      := pData.m_sfValue;
    m_pTable.inter_val  := 0;
    m_pDB.AddArchDataEnergo(m_pTable);
End;
procedure CSetEnergotel.SetHalfData(tDate0,tDate1:TDateTime);
Var
    i,j : Integer;
    DataBrestEnergo : Val;
Begin
    DataBrestEnergo.n_obj := $ffff;
    DataBrestEnergo.izm_type := 1;
    m_pDB.DelArchEnergoData(tDate0{-10}, tDate1, DataBrestEnergo);
    for i:=0 to m_pVMeter.m_swAmVMeter-1 do
    Begin
     if m_pVMeter.Item.Items[i].m_sbyExport=1 then
     Begin
      if m_pDB.GetGraphDatasEnergo(tDate1,tDate0{-10},m_pVMeter.Item.Items[i].m_swVMID,QRY_SRES_ENR_EP,m_pGrData) then
      Begin
       for j:=0 to m_pGrData.Count-1 do
       SetHalfEnergoDataItem(m_pVMeter.Item.Items[i],m_pGrData.Items[j]);
      End;
     End;
    End;
End;
procedure CSetEnergotel.SetHalfEnergoDataItem(var pVMeter:SL3VMETERTAG;var pData:L3GRAPHDATA);
Var
    m_pTable : VAl;
    i        : Integer;
Begin
    m_pTable.n_obj      := pVMeter.m_sbyPortID;
    //m_pTable.link_adr   := StrToInt(pVMeter.m_sddPHAddres);
    m_pTable.link_adr   := pVMeter.m_swVMID;
    m_pTable.n_ri       := 0;
    m_pTable.izm_type   := pData.m_swCMDID - QRY_SRES_ENR_EP + 1;
    m_pTable.data       := pData.m_sdtDate;
    m_pTable.n_zone     := 0;
    m_pTable.flag       := '';
    for i:=0 to 47 do
    Begin
     m_pTable.znach      := pData.v[i];
     m_pTable.inter_val  := i;
     m_pDB.AddArchDataEnergo(m_pTable);
    End;
End;
procedure CSetEnergotel.SetEventData(tDate : TDateTime);
Begin
End;
procedure CSetEnergotel.CopyEnergoInfo(IsSave:Boolean);
Begin
    CopyArchiveEnergo(IsSave);
    CopyGraphEnergo(IsSave);
End;
procedure CSetEnergotel.CopyEnergoInfoUser(dtDate0,dtDate1:TDateTime);
Begin
    SetArchData(dtDate0,dtDate1);
    SetHalfData(dtDate0,dtDate1);
End;
procedure CSetEnergotel.CopyArchiveEnergo(IsSave:Boolean);
Begin
    if (trunc(m_sLArchDate)<>trunc(Now))or(IsSave=True) then SetArchData(m_sLArchDate,Now);
    m_sLArchDate := Now;
End;
procedure CSetEnergotel.CopyGraphEnergo(IsSave:Boolean);
Begin
    if (trunc(m_sLGraphDate)<>trunc(Now))or(IsSave=True) then SetHalfData(m_sLGraphDate,Now);
    m_sLGraphDate := Now;
End;
end.
