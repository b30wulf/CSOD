unit knsl3setenergomoz;

interface
uses
    Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,utlconst,inifiles,Db,ADODB
    ,knsl5tracer, Dates,utlbox, utlTimeDate,math,utldatabase;
type
    CSetEnergoMoz = class
    private
     m_pData   : CCDatas;
     m_pVMeter : SL3GROUPTAG;
     m_pGrData : L3GRAPHDATAS;
     ReportSettings: REPORT_F1;
     m_sLArchDate  : TDateTime;
     m_sLGraphDate : TDateTime;
     M_pABON: ABON;
     procedure SetHalfEnergoDataItem(var pVMeter:SL3VMETERTAG;var pData:L3GRAPHDATa;var pDataPok:CCData;b_CurrentData:boolean);
     procedure SetEventData(tDate : TDateTime);
     procedure CopyGraphEnergo(IsSave:Boolean);
     procedure SetAbon;
     procedure SetTUCH;
     procedure SetBUF_V_INT(tDate0,tDate1:TDateTime);
    public
     procedure Init;
     procedure CopyEnergoInfo(IsSave:Boolean);
     procedure CopyEnergoInfoUser(dtDate0,dtDate1:TDateTime);
     procedure InitTableA_T;
    public
    End;
var
  m_nMZ  : CSetEnergoMoz;
implementation
procedure CSetEnergoMoz.Init;
Begin
    m_pDB.GetVMetersTable(-1,m_pVMeter);
    m_sLArchDate  := Now;
    m_sLGraphDate := Now;

End;

procedure CSetEnergoMoz.SetAbon;
 var   ReportSettings: REPORT_F1;
Begin
   m_pDB.LoadReportParams(0,ReportSettings);
   M_pABON.ABO       := ReportSettings.ABO;
   M_pABON.NM_abo    := ReportSettings.m_sNameObject;
   M_pABON.KSP       := ReportSettings.KSP;
   M_pABON.NOM_DOGWR := ReportSettings.m_sNDogovor;
   m_pDB.AddAbon(M_pABON);
End;

procedure CSetEnergoMoz.SetTUCH;
 var ptable: SLTUCH;
Begin
   m_pDB.LoadForTUCHParams(ptable,M_pABON.ABO);
End;

procedure  CSetEnergoMoz.InitTableA_T;
begin
  SetAbon;
  SetTUCH;
end;

{$o-}

procedure CSetEnergoMoz.SetBUF_V_INT(tDate0,tDate1:TDateTime);
 var DataGomelEnergo: BUF_V_INT;
     i,j : Integer;
     b_CurrentData:boolean;
Begin
    DataGomelEnergo.ABO := $ffff;
    DataGomelEnergo.N_GR_TY := 1;
    m_pDB.DelBUF_V_INT(tDate0{-10}, tDate1, DataGomelEnergo,M_pABON.ABO);
    for i:=0 to m_pVMeter.m_swAmVMeter-1 do
    Begin
     if m_pVMeter.Item.Items[i].m_sbyExport=1 then
     Begin
     if m_pDB.GetGraphDatasEnergo(tDate1,tDate0{-10},m_pVMeter.Item.Items[i].m_swVMID,QRY_SRES_ENR_EP,m_pGrData)then
      Begin
       b_CurrentData := m_pDB.GetGDataGomelEnergo(tDate1,tDate0{-10},m_pVMeter.Item.Items[i].m_swVMID,QRY_NAK_EN_DAY_EP,-1,m_pData);
       if  m_pData.Count = m_pGrData.Count then b_CurrentData := true else b_CurrentData := false;
       for j:=0 to m_pGrData.Count-1 do
       SetHalfEnergoDataItem(m_pVMeter.Item.Items[i],m_pGrData.Items[j],m_pData.Items[j],b_CurrentData);
      End;
     End;
    End;
End;

procedure CSetEnergoMoz.SetHalfEnergoDataItem(var pVMeter:SL3VMETERTAG;var pData:L3GRAPHDATA;var pDataPok:CCData;b_CurrentData:boolean);
Var
    m_pTable   : BUF_V_INT;
    i,j        : Integer;
Begin
    try
     m_pTable.ABO          := M_pABON.ABO;
     m_pTable.TUCH         := pVMeter.m_swVMID;
     m_pTable.N_GR_TY      := pData.m_swCMDID - QRY_SRES_ENR_EP + 1;
     m_pTable.DD_MM_YYYY   := pData.m_sdtDate;
     m_pTable.pok_start    := 0;
     m_pTable.VAL1         := 0;

     for i:=0 to 47 do
     Begin

     if  b_CurrentData = true  then
     begin
      for j := 0 to i do
      m_pTable.pok_start    := m_pTable.pok_start + pData.v[i];
      m_pTable.pok_start    := m_pTable.pok_start + pDataPok.m_sfValue;
     end;

      m_pTable.VAL          := pData.v[i];
      m_pTable.N_INTER_RAS  := i+1;
      m_pDB.AddBUF_V_INT(m_pTable);
      m_pTable.pok_start    := 0;

    End;
   except

   end;
End;

{
  QRY_NAK_EN_DAY_EP     = 17;//42
  QRY_NAK_EN_DAY_EM     = 18;
  QRY_NAK_EN_DAY_RP     = 19;
  QRY_NAK_EN_DAY_RM     = 20;
}

procedure CSetEnergoMoz.SetEventData(tDate : TDateTime);
Begin
End;

procedure CSetEnergoMoz.CopyEnergoInfo(IsSave:Boolean);
Begin
    //CopyArchiveEnergo(IsSave);
    CopyGraphEnergo(IsSave);
End;

procedure CSetEnergoMoz.CopyEnergoInfoUser(dtDate0,dtDate1:TDateTime);
Begin
   // SetAbon;
   // SetTUCH;
    SetBUF_V_INT(dtDate0,dtDate1);
    //SetHalfData(dtDate0,dtDate1);
End;

procedure CSetEnergoMoz.CopyGraphEnergo(IsSave:Boolean);
Begin
    if (trunc(m_sLGraphDate)<>trunc(Now))or(IsSave=True) then SetBUF_V_INT(m_sLGraphDate,Now);
    m_sLGraphDate := Now;
    m_sLArchDate := Now;
End;

end.
