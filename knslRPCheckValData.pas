unit knslRPCheckValData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TRPCheckValData = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    DateReport        : TDateTime;
    VMeterName        : string;
    glTable1Name      : string;
    globalTitle       : string;
    clDayColors       : array [0..31] of integer;
    alNakData         : CCDatas;
    alGraphData       : L3GRAPHDATAS;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure BuildReport(var Page: TfrPage);
    procedure FindValInAllData(VMID: integer; date: TDateTime; var val: CCDatas);
    procedure FindValInGrData(VMID: integer; date: TDateTime; var val: L3GRAPHDATAS);
    function FindNakDayVal(VMID: integer; sm: integer) : double;
    function FindSliceVal(VMID: integer; sm: integer) : double;
    procedure GetMonthSlieceValues(VMID: integer);
    procedure GetNakDayValues(VMID: integer);
  public
    { Public declarations }
    WorksName            : string;
    FirstSign            : string;
    SecondSign           : string;
    ThirdSign            : string;
    NDogovor             : string;
    NameObject           : string;
    Adress               : string;
    m_strObjCode         : string;
    procedure PrintPreview(Date : TDateTime);
    procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
  end;

var
  RPCheckValData: TRPCheckValData;
const clNoNak         = $FFFFFF;
      clNoSlice       = $C0C0C0;
      clValData       = $7FFF00;
      clHalInvalData  = $00FFFF;
      clFullInvalData = $6A6AFF;

implementation

{$R *.DFM}

procedure TRPCheckValData.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPCheckValData.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPCheckValData.PrepareTable;
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
   FsgGrid.ColWidths[1]  := 200;
   SetHigthGrid(FsgGrid^,20);
   if not FDB.GetMeterGLVTableForReport(FABOID,GroupID,0, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;
   end;
   OnFormResize;
end;

procedure TRPCheckValData.PrintPreview(Date : TDateTime);
begin
   DateReport := Date;
   frReport1.ShowReport;
end;

procedure TRPCheckValData.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
begin
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'Отчет о правильности срезов и накопленной энергии на начало суток в ' +
                  cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   Page.ShowBandByType(btReportTitle);
   Page.ShowBandByName('MasterData1');

   DateReport := cDateTimeR.GetBeginMonth(DateReport);
   BuildReport(Page);

   //Page.ShowBandByName('MasterData2');
   Page.ShowBandByName('MasterData3');
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPCheckValData.BuildReport(var Page: TfrPage);
var i, j, VMID       : integer;
    Year, Month, Day : word;
    ValNak           : double;
    ValSl            : double;
    Perc             : double;
begin
   DecodeDate(DateReport, Year, Month, Day);
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     for j := 0 to 31 do
       clDayColors[j] := 0;
     VMeterName := FsgGrid.Cells[1, i];

     if FsgGrid.Cells[0, i] <> '' then
       VMID := StrToInt(FsgGrid.Cells[0, i])
     else
       continue;
     GetMonthSlieceValues(VMID);
     GetNakDayValues(VMID);
     for j := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
     begin
       if (DateReport + j >= trunc(Now)) then
       begin
         clDayColors[j] := clNoNak;
         continue;
       end;


       ValNak := FindNakDayVal(VMID, j);
       ValSl := FindSliceVal(VMID, j);

       if (clDayColors[j] <> 0) then continue;
       if (ValNak = 0.0) and (ValSl = 0.0) then
       begin
         clDayColors[j] := clValData;
         continue;
       end;
       if (ValNak >= ValSl) then
         Perc := (1.0 - ValSl / ValNak) * 100.0
       else
         Perc := (1.0 - ValNak / ValSl) * 100.0;
       if (Perc <= 0.1) then
         clDayColors[j] := clValData
       else if (Perc > 0.1) and (Perc < 5) then
         clDayColors[j] := clHalInvalData
       else
         clDayColors[j] := clFullInvalData;
     end;
     Page.ShowBandByName('MasterData2');
   end;
end;
{
alNakData         : CCDatas;
    alGraphData       : L3GRAPHDATAS;
    }
procedure TRPCheckValData.GetMonthSlieceValues(VMID: integer);
begin
   FDB.GetGraphDatas(cDateTimeR.EndMonth(DateReport), DateReport, VMID,
                                QRY_SRES_ENR_EP, alGraphData);
end;

procedure TRPCheckValData.GetNakDayValues(VMID: integer);
begin
   FDB.GetGData(cDateTimeR.EndMonth(DateReport) + 1, DateReport, VMID, QRY_NAK_EN_DAY_EP, -1, alNakData);
end;

procedure TRPCheckValData.FindValInAllData(VMID: integer; date: TDateTime; var val: CCDatas);
var i: integer;
begin
   val.Count := 0;
   for i := 0 to alNakData.Count - 1 do
   begin
     if (alNakData.Items[i].m_swVMID = VMID) and
        (trunc(alNakData.Items[i].m_sTime) = trunc(date)) then
     begin
       if Length(val.Items) < 1 then
         SetLength(val.Items, 1);
       val.Count := 1;
       val.Items[0].m_sfValue := alNakData.Items[i].m_sfValue;
       break;
     end;
   end;
end;

procedure TRPCheckValData.FindValInGrData(VMID: integer; date: TDateTime; var val: L3GRAPHDATAS);
var i: integer;
begin
   val.Count := 0;
   //for i := 0 to alNakData.Count - 1 do
   for i := 0 to alGraphData.Count - 1 do
   begin
     if (alGraphData.Items[i].m_swVMID = VMID) and
        (trunc(alGraphData.Items[i].m_sdtDate) = trunc(date)) then
     begin
       if Length(val.Items) < 1 then
         SetLength(val.Items, 1);
       val.Count := 1;
       move(alGraphData.Items[i].v[0], val.Items[0].v[0], 48*sizeof(Double));
     end;
   end;
end;

function TRPCheckValData.FindNakDayVal(VMID: integer; sm: integer) : double;
var DataBeg, DataEnd : CCDatas;
begin
   Result := 0.0;
   //FDB.GetGData(DateReport + sm, DateReport + sm, VMID, QRY_NAK_EN_DAY_EP, -1, DataBeg);
   //FDB.GetGData(DateReport + sm + 1, DateReport + sm + 1, VMID, QRY_NAK_EN_DAY_EP, -1, DataEnd);
   FindValInAllData(VMID, DateReport + sm, DataBeg);
   FindValInAllData(VMID, DateReport + sm + 1, DataEnd);
   if (DataBeg.Count = 0) or (DataEnd.Count = 0) then
   begin
     clDayColors[sm] := clNoNak;
     exit;
   end;
   if (DataBeg.Items[0].m_sfValue > DataEnd.Items[0].m_sfValue) then
   begin
     clDayColors[sm] := clNoNak;
     exit;
   end;
   Result := DataEnd.Items[0].m_sfValue - DataBeg.Items[0].m_sfValue;
end;

function TRPCheckValData.FindSliceVal(VMID: integer; sm: integer) : double;
var pGrTable        : L3GRAPHDATAS;
    i               : integer;
begin
   Result := 0.0;
   //FDB.GetGraphDatas(DateReport + sm, DateReport + sm, VMID,
   //                             QRY_SRES_ENR_EP, pGrTable);
   FindValInGrData(VMID, DateReport + sm, pGrTable);
   if pGrTable.Count = 0 then
   begin
     clDayColors[sm] := clNoSlice;
     exit;
   end;
   for i := 0 to 47 do
     Result := Result + pGrTable.Items[0].v[i];
end;

procedure TRPCheckValData.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'   then begin ParValue := WorksName; end;
   if ParName = 'FirstSign'   then begin ParValue := FirstSign; end;
   if ParName = 'ThirdSign'   then begin ParValue := ThirdSign; end;
   if ParName = 'SecondSign'  then begin ParValue := SecondSign; end;
   if ParName = 'TtlMainName' then begin ParValue := globalTitle; end;
   if ParName = 'NDogovor'    then begin ParValue := NDogovor; end;
   if ParName = 'NameObject'  then begin ParValue := NameObject; end;
   if ParName = 'Adress'      then begin ParValue := Adress; end;
   if ParName = 'Tbl1Name'    then begin ParValue := glTable1Name; end;
   if ParName = 'VMeterName'  then begin ParValue := VMeterName; end;
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
end;
//clDayColors[j]
procedure TRPCheckValData.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
   if View.Name = 'Memo2' then
     View.FillColor := clDayColors[0];
   if View.Name = 'Memo10' then
     View.FillColor := clDayColors[1];
   if View.Name = 'Memo40' then
     View.FillColor := clDayColors[2];
   if View.Name = 'Memo41' then
     View.FillColor := clDayColors[3];
   if View.Name = 'Memo42' then
     View.FillColor := clDayColors[4];
   if View.Name = 'Memo3' then
     View.FillColor := clDayColors[5];
   if View.Name = 'Memo43' then
     View.FillColor := clDayColors[6];
   if View.Name = 'Memo44' then
     View.FillColor := clDayColors[7];
   if View.Name = 'Memo45' then
     View.FillColor := clDayColors[8];
   if View.Name = 'Memo46' then
     View.FillColor := clDayColors[9];
   if View.Name = 'Memo49' then
     View.FillColor := clDayColors[10];
   if View.Name = 'Memo50' then
     View.FillColor := clDayColors[11];
   if View.Name = 'Memo51' then
     View.FillColor := clDayColors[12];
   if View.Name = 'Memo54' then
     View.FillColor := clDayColors[13];
   if View.Name = 'Memo56' then
     View.FillColor := clDayColors[14];
   if View.Name = 'Memo58' then
     View.FillColor := clDayColors[15];
   if View.Name = 'Memo59' then
     View.FillColor := clDayColors[16];
   if View.Name = 'Memo60' then
     View.FillColor := clDayColors[17];
   if View.Name = 'Memo61' then
     View.FillColor := clDayColors[18];
   if View.Name = 'Memo62' then
     View.FillColor := clDayColors[19];
   if View.Name = 'Memo63' then
     View.FillColor := clDayColors[20];
   if View.Name = 'Memo64' then
     View.FillColor := clDayColors[21];
   if View.Name = 'Memo65' then
     View.FillColor := clDayColors[22];
   if View.Name = 'Memo66' then
     View.FillColor := clDayColors[23];
   if View.Name = 'Memo67' then
     View.FillColor := clDayColors[24];
   if View.Name = 'Memo68' then
     View.FillColor := clDayColors[25];
   if View.Name = 'Memo69' then
     View.FillColor := clDayColors[26];
   if View.Name = 'Memo70' then
     View.FillColor := clDayColors[27];
   if View.Name = 'Memo71' then
     View.FillColor := clDayColors[28];
   if View.Name = 'Memo72' then
     View.FillColor := clDayColors[29];
   if View.Name = 'Memo73' then
     View.FillColor := clDayColors[30];
end;

end.
