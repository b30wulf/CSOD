unit knslRPPowerHourMTZ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;

type
  TRPPowerHourMTZ = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    VMeters           : SL3GROUPTAG;
    FsgGrid           : PTAdvStringGrid;
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
    ItemInd           : Integer;
    RasxDayActSum     : double;
    RasxDayReactSum   : double;
    m_ID              : Integer;
    glReportDate      : string;
    glVMeterName      : string;
    glNpp             : string;
    glHour            : string;
    glActPointName    : string;
    glActPower        : double;
    glReactPointName  : string;
    glReactPower      : double;
    glRasxDayAct      : double;
    glRasxDayReact    : double;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure ReadSlices(var Page: TfrPage);
  public
    { Public declarations }
    m_nKindEnergy      : integer;
    IsRPGroup          : boolean;
    dtDateReport       : TDateTime;
    glNDogovor         : string;
    m_strObjCode       : string;
    procedure PrepareTable;
    procedure PrepareTableSub;
    procedure PrintPreview(DateReport : TDateTime);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
  end;

var
  RPPowerHourMTZ: TRPPowerHourMTZ;

implementation

{$R *.DFM}

procedure TRPPowerHourMTZ.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if FsgGrid=Nil then
     exit;
   FsgGrid.ColCount   := 2;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование группы';
   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);
   if not FDB.GetAbonGroupsLVTable(FABOID,1,Groups) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       FsgGrid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TRPPowerHourMTZ.PrepareTableSub;
var Meters : SL2TAGREPORTLIST;
    i      : integer;
begin
   if FsgGrid=Nil then exit;
   FsgGrid.ColCount      := 5;
   FsgGrid.RowCount      := 60;
   FsgGrid.Cells[0,0]    := '№ п.п';
   FsgGrid.Cells[1,0]    := 'Наименование учета';
   FsgGrid.Cells[2,0]    := 'Номер счетчика';
   FsgGrid.Cells[3,0]    := 'Коэффициент';
   FsgGrid.Cells[4,0]    := 'Тип счетчика';
   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);
//   FDB.GetMetersAll(Meters)

   if not FDB.GetMeterGLVTableForReport(FABOID,-1,0, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       {if (Meters.m_sMeter[i].m_sbyType = MET_SUMM) or (Meters.m_sMeter[i].m_sbyType = MET_GSUMM) or
          (Meters.m_sMeter[i].m_sbyType = MET_VZLJOT) then
         continue;
       }
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;

   end;
   OnFormResize;
end;

procedure TRPPowerHourMTZ.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TRPPowerHourMTZ.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPPowerHourMTZ.PrintPreview(DateReport : TDateTime);
begin
   dtDateReport := DateReport;
   ItemInd := FsgGrid.Row;
   if (ItemInd = 0) or (FsgGrid.Cells[0, ItemInd] = '') then
     exit;
   frReport1.ShowReport;
end;

procedure TRPPowerHourMTZ.ReadSlices(var Page: TfrPage);
var m_pGrDataAct,
    m_pGrDataReact       : L3GRAPHDATAS;
    i                    : integer;
    strHour1, strHour2   : string;
    HourAct, HourReact   : double; 
begin
   if not FDB.GetGraphDatas(dtDateReport, dtDateReport, m_ID,
                        QRY_SRES_ENR_EP + m_nKindEnergy, m_pGrDataAct) then
   begin
     SetLength(m_pGrDataAct.Items, 1);
      for i := 0 to 47 do
        m_pGrDataAct.Items[0].v[i] := 0;
   end;
   if not FDB.GetGraphDatas(dtDateReport, dtDateReport, m_ID,
                        QRY_SRES_ENR_RP + m_nKindEnergy, m_pGrDataReact) then
   begin
     SetLength(m_pGrDataReact.Items, 1);
      for i := 0 to 47 do
        m_pGrDataReact.Items[0].v[i] := 0;
   end;
   for i := 0 to 23 do
   begin
     glNpp            := IntToStr(i + 1);
     glActPointName   := 'P' + glNpp;
     glReactPointName := 'Q' + glNpp;
     strHour1         := IntToStr(i);
     strHour2         := IntToStr(i + 1);
     if Length(strHour1) = 1 then  strHour1 := '0' + strHour1;
     if Length(strHour2) = 1 then  strHour2 := '0' + strHour2;
     glHour := strHour1 + '.' + '00' +  '-' + strHour2 + '.' + '00';
     glActPower := RVLPr(m_pGrDataAct.Items[0].v[i*2] + m_pGrDataAct.Items[0].v[i*2 + 1], MeterPrecision[m_ID]);
     glReactPower := RVLPr(m_pGrDataReact.Items[0].v[i*2] + m_pGrDataReact.Items[0].v[i*2 + 1], MeterPrecision[m_ID]);
     glRasxDayAct := glRasxDayAct + glActPower;
     glRasxDayReact := glRasxDayReact + glReactPower;
     Page.ShowBandByName('MasterData1');
   end;
end;

procedure TRPPowerHourMTZ.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
begin
   RasxDayActSum   := 0;
   RasxDayReactSum := 0;
   DecodeDate(dtDateReport, Year, Month, Day);
   glReportDate := 'за ' + IntToStr(Day) + ' ' + cDateTimeR.GetNameMonth1(Month) + ' ' + IntToStr(Year) + ' года';
   glVMeterName := 'по ' + FsgGrid.Cells[1, ItemInd];
   Page.ShowBandByType(btReportTitle);

   Page.ShowBandByName('MasterHeader1');
   m_ID := -1;
   if not IsRPGroup then
     m_ID := StrToInt(FsgGrid.Cells[0, ItemInd])
   else
     if FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters) then
       m_ID := VMeters.Item.Items[0].m_swVMID;
   ReadSlices(Page);

   Page.ShowBandByName('MasterData2');
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPPowerHourMTZ.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'ReportDate'     then ParValue := glReportDate;
   if ParName = 'NDogovor'       then ParValue := glNDogovor;
   if ParName = 'VMeterName'     then ParValue := glVMeterName;
   if ParName = 'Npp'            then ParValue := glNpp;
   if ParName = 'Hour'           then ParValue := glHour;
   if ParName = 'ActPointName'   then ParValue := glActPointName;
   if ParName = 'ActPower'       then ParValue := glActPower;
   if ParName = 'ReactPointName' then ParValue := glReactPointName;
   if ParName = 'ReactPower'     then ParValue := glReactPower;
   if ParName = 'RasxDayAct'     then ParValue := glRasxDayAct;
   if ParName = 'RasxDayReact'   then ParValue := glRasxDayReact;
   if ParName = 'm_strObjCode'   then ParValue := m_strObjCode;
end;

end.
