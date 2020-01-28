unit knslRPGenOutPowerHour;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;

type
  TRPGenOutPowerHour = class(TForm)
    frReport1: TfrReport;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    m_pGr1DataGen,
    m_pGr1DataGenOut,
    m_pGr2DataGen,
    m_pGr2DataGenOut  : L3GRAPHDATAS;
    
    m_ItemIndex       : Integer;
    m_Grid            : PTAdvStringGrid;


    VMeters           : SL3GROUPTAG;

    FDB               : PCDBDynamicConn;
    FABOID            : Integer;

    RasxDayActSum     : double;
    RasxDayReactSum   : double;
    m_ID              : Integer;

    PH_HID            : String;
    PH_Date1          : String;
    PH_Date2          : String;
    PH_Time           : String;
    PH_D1Gen          : String;
    PH_D1GenOut       : String;
    PH_D2Gen          : String;
    PH_D2GenOut       : String;

    
    glVMeterName      : string;


    glHour            : string;
    glActPower        : double;
    glReactPower      : double;
    glRasxDayAct      : double;
    glRasxDayReact    : double;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure ReadSlices();
  public
    { Public declarations }
    m_Precission       : integer;
    IsRPGroup          : boolean;
    m_Date1            : TDateTime;
    m_Date2            : TDateTime;
    m_ContractID       : String;
    m_ObjectName   : String;
    m_AbonentName      : String;
    PH_FirstSign       : String;
    
    procedure PrepareTable();
    procedure PrepareTableSub();
    procedure PrintPreview(Date1, Date2 : TDateTime);
  public
    property PsgGrid     :PTAdvStringGrid  read m_Grid      write m_Grid;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
  end;

var
  RPGenOutPowerHour: TRPGenOutPowerHour;

implementation

{$R *.DFM}

procedure TRPGenOutPowerHour.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if m_Grid=Nil then
     exit;


   m_Grid.ColCount   := 2;
   m_Grid.Cells[0,0] := '№ п/п';
   m_Grid.Cells[1,0] := 'Наименование группы';
   m_Grid.ColWidths[0]  := 30;
   SetHigthGrid(m_Grid^,20);
   if not FDB.GetAbonGroupsLVTable(FABOID,1,Groups) then
     m_Grid.RowCount := 1
   else
   begin
     m_Grid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       m_Grid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       m_Grid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TRPGenOutPowerHour.PrepareTableSub;
var Meters : SL2TAGREPORTLIST;
    i      : integer;
begin
   if m_Grid=Nil then exit;
   m_Grid.ColCount      := 5;
   m_Grid.RowCount      := 60;
   m_Grid.Cells[0,0]    := '№ п.п';
   m_Grid.Cells[1,0]    := 'Наименование учета';
   m_Grid.Cells[2,0]    := 'Номер счетчика';
   m_Grid.Cells[3,0]    := 'Коэффициент';
   m_Grid.Cells[4,0]    := 'Тип счетчика';
   m_Grid.ColWidths[0]  := 30;
   SetHigthGrid(m_Grid^,20);
//   FDB.GetMetersAll(Meters)

   if not FDB.GetMeterGLVTableForReport(FABOID,-1,0, Meters) then
     m_Grid.RowCount := 1
   else
   begin
     m_Grid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       {if (Meters.m_sMeter[i].m_sbyType = MET_SUMM) or (Meters.m_sMeter[i].m_sbyType = MET_GSUMM) or
          (Meters.m_sMeter[i].m_sbyType = MET_VZLJOT) then
         continue;
       }
       m_Grid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       m_Grid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       m_Grid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       m_Grid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       m_Grid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;

   end;
   OnFormResize;
end;

procedure TRPGenOutPowerHour.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TRPGenOutPowerHour.OnFormResize;
Var
    i : Integer;
Begin
    if m_Grid=Nil then exit;
    for i:=1 to m_Grid.ColCount-1  do m_Grid.ColWidths[i]  := trunc((m_Grid.Width-2*m_Grid.ColWidths[0])/(m_Grid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPGenOutPowerHour.PrintPreview(Date1, Date2 : TDateTime);
begin
  m_Date1 := Date1;
  m_Date2 := Date2;

  m_ItemIndex := m_Grid.Row;
  if (m_Grid.Cells[0, m_ItemIndex] <> '') and (m_ItemIndex > 0) then
  begin
    m_ID := StrToInt(m_Grid.Cells[0, m_ItemIndex]);
    ReadSlices();
    frReport1.ShowReport();
  end;
end;



procedure TRPGenOutPowerHour.ReadSlices();
var
  i                    : integer;
  strHour1, strHour2   : string;
  HourAct, HourReact   : double;
begin
  SetLength(m_pGr1DataGen.Items, 1);
  SetLength(m_pGr1DataGenOut.Items, 1);
  SetLength(m_pGr2DataGen.Items, 1);
  SetLength(m_pGr2DataGenOut.Items, 1);

  for i := 0 to 47 do
  begin
    m_pGr1DataGen.Items[0].v[i] := 0;
    m_pGr1DataGenOut.Items[0].v[i] := 0;
    m_pGr2DataGen.Items[0].v[i] := 0;
    m_pGr2DataGenOut.Items[0].v[i] := 0;
  end;

  if (FDB.GetGraphDatas(m_Date1, m_Date1, m_ID, QRY_SRES_ENR_EM, m_pGr1DataGen) AND
      FDB.GetGraphDatas(m_Date1, m_Date1, m_ID, QRY_SRES_ENR_EP, m_pGr1DataGenOut) AND
      FDB.GetGraphDatas(m_Date2, m_Date2, m_ID, QRY_SRES_ENR_EM, m_pGr2DataGen) AND
      FDB.GetGraphDatas(m_Date2, m_Date2, m_ID, QRY_SRES_ENR_EP, m_pGr2DataGenOut) ) then
  begin
    for i := 0 to 47 do
    begin
      m_pGr1DataGenOut.Items[0].v[i] := m_pGr1DataGen.Items[0].v[i] - m_pGr1DataGenOut.Items[0].v[i];
      m_pGr2DataGenOut.Items[0].v[i] := m_pGr2DataGen.Items[0].v[i] - m_pGr2DataGenOut.Items[0].v[i];
    end;
  end;
end;

procedure TRPGenOutPowerHour.frReport1ManualBuild(Page: TfrPage);
var
  i :Integer;
begin
  PH_DATE1    := FormatDateTime('dd.mm.yyyy', m_Date1);
  PH_DATE2    := FormatDateTime('dd.mm.yyyy', m_Date2);

  glVMeterName := m_Grid.Cells[1, m_ItemIndex];
//  Page.ShowBandByType(btReportTitle);

  Page.ShowBandByName('MasterHeader1');

  m_ID := -1;
  if not IsRPGroup then
    m_ID := StrToInt(m_Grid.Cells[0, m_ItemIndex])
  else
    if FDB.GetVMetersTable(FABOID,StrToInt(m_Grid.Cells[0, m_ItemIndex]), VMeters) then
       m_ID := VMeters.Item.Items[0].m_swVMID;


  i := 0;
  while i < 48 do
  begin
    PH_HID      := IntToStr((i div 2) + 1);
    PH_Time     := Format('%0.2d:00 - %0.2d:00', [(i div 2), (i div 2)+1]);
    PH_D1Gen    := '';//DVLSTF((m_pGr1DataGen.Items[0].v[i] + m_pGr1DataGen.Items[0].v[i+1])/1000, m_Precission+2, m_Precission);
    PH_D1GenOut := FloatToStrF(RVL((m_pGr1DataGenOut.Items[0].v[i] + m_pGr1DataGenOut.Items[0].v[i+1])/1000), ffFixed, 18, m_Precission);
    PH_D2Gen    := '';//DVLSTF((m_pGr2DataGen.Items[0].v[i] + m_pGr2DataGen.Items[0].v[i+1])/1000, m_Precission+2, m_Precission);
    PH_D2GenOut := FloatToStrF(RVL((m_pGr2DataGenOut.Items[0].v[i] + m_pGr2DataGenOut.Items[0].v[i+1])/1000), ffFixed, 18, m_Precission);
    Page.ShowBandByName('MasterData1');
    INc(i, 2);
  end;

  Page.ShowBandByName('PageFooter1');
end;

procedure TRPGenOutPowerHour.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'HID'        then ParValue := PH_HID;
   if ParName = 'ContractID' then ParValue := m_ContractID;
   if ParName = '_Date1'     then ParValue := PH_Date1;
   if ParName = '_Date2'     then ParValue := PH_Date2;
   if ParName = 'Hours'      then ParValue := PH_Time;
   if ParName = 'VMeterName' then ParValue := glVMeterName;

   if ParName = '_D1Gen'     then ParValue := PH_D1Gen;
   if ParName = '_D1GenOut'  then ParValue := PH_D1GenOut;
   if ParName = '_D2Gen'     then ParValue := PH_D2Gen;
   if ParName = '_D2GenOut'  then ParValue := PH_D2GenOut;


   if ParName = 'AbonentName'   then ParValue := m_AbonentName;
   if ParName = 'ObjectName'   then ParValue := m_ObjectName;
   if ParName = 'FirstSign'   then ParValue := PH_FirstSign;
end;

end.
