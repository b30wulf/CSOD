unit knslRPValidSlice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TRPValidSlice = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
   procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : Integer;
    DateReport        : TDateTime;
    glTable1Name      : string;
    sl                : array [0..31] of string;
    cl_sl             : array [0..31] of byte;
    VMeterName        : string;
    globalTitle       : string;
    glKindEn          : string;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure FillReport(var Page: TfrPage);
    function  FindColSlicesFromMask(Mask : int64) : integer;
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
    KindEnergy           : integer;
    procedure PrepareTable;
    procedure PrintPreview(Date : TDateTime);
  public
    property PsgGrid     : PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   : integer          read GroupID      write GroupID;
    property PDB         : PCDBDynamicConn  read FDB          write FDB;
    property PABOID      : Integer          read FABOID       write FABOID;
  end;

var
  RPValidSlice: TRPValidSlice;
const                   
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');
                                                   //Green  Red      Yellow
  clColors    : array [0..3] of TColor = (clWhite, $7FFF00, $6A6AFF, $00FFFF);

implementation

{$R *.DFM}

procedure TRPValidSlice.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPValidSlice.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPValidSlice.PrepareTable;
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
   if not FDB.GetMeterTableForReport(FABOID,GroupID, Meters) then
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

procedure TRPValidSlice.PrintPreview(Date : TDateTime);
begin
   DateReport   := Date;
   glTable1Name := 'Таблица 1';
   frReport1.ShowReport;
end;

function  TRPValidSlice.FindColSlicesFromMask(Mask : int64) : integer;
var i : integer;
begin
   Result := 0;
   for i := 0 to 47 do
     if IsBitInMask(Mask, i) then
       Result := Result + 1;
end;

procedure TRPValidSlice.FillReport(var Page: TfrPage);
var i, j,k              : integer;
    m_pGrData         : L3GRAPHDATAS;
    SlN, SumN, AllSlN : integer;
    Day, Year, Month  : word;
    Hour, Min, Sec, ms: word;
    TempDate          : TDateTime;
begin
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     for k := 0 to 31 do
     begin
       sl[k]    := '-';
       cl_sl[k] := 0;
     end;
     VMeterName := FsgGrid.Cells[1, i];
     FDB.GetGraphDatas(DateReport, cDateTimeR.GetBeginMonth(DateReport), StrToInt(FsgGrid.Cells[0, i]),
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData);
     SumN     := 0;
     for j := 0 to m_pGrData.Count - 1 do
     begin
       DecodeDate(m_pGrData.Items[j].m_sdtDate, Year, Month, Day);
       SlN := FindColSlicesFromMask(m_pGrData.Items[j].m_sMaskRead);
       sl[Day] := IntToStr(SlN);
       SumN := SumN + SlN;
       if trunc(m_pGrData.Items[j].m_sdtDate) < trunc(Now) then
       begin
         if SlN = 48 then
           cl_sl[Day] := 1;
         if (SlN < 48) and (SlN > 0) then
           cl_sl[Day] := 3;
         if (SlN = 0) then
           cl_sl[Day] := 2;
       end;
       if trunc(m_pGrData.Items[j].m_sdtDate) = trunc(Now) then
       begin
         DecodeTime(Now, Hour, Min, Sec, ms);
         if SlN = (Hour*2 + Min div 30) then
           cl_sl[Day] := 1;
         if (SlN < (Hour*2 + Min div 30)) and (SlN > 0) then
           cl_sl[Day] := 3;
         if (SlN = 0) then
           cl_sl[Day] := 2;
       end;
     end;
     if cDateTimeR.GetBeginMonth(DateReport) <= Now then
     begin
       cl_sl[0] := 1;
       TempDate := cDateTimeR.GetBeginMonth(DateReport);
       for j := 1 to cDateTimeR.DayPerMonthDT(DateReport) do
       begin
         if sl[j] = '-' then
           if trunc(TempDate) <= trunc(Now) then
           begin
             sl[j] := '0';
             cl_sl[j] := 2;
           end;
         cDateTimeR.IncDate(TempDate);
       end;
       for j := 1 to cDateTimeR.DayPerMonthDT(DateReport) do
         if (cl_sl[j] = 2) or (cl_sl[j] = 3) then
         begin
           cl_sl[0] := 3;
           break;
         end;
       if SumN = 0 then
         cl_sl[0] := 2;
       sl[0] := IntToStr(SumN);
     end;
     Page.ShowBandByName('MasterData2');
   end;
end;

procedure TRPValidSlice.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i                : integer;
begin
   for i := 0 to 31 do
   begin
     sl[i]    := '-';
     cl_sl[i] := 0;
   end;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'Отчет о полноте сбора значений 30-мин.интервалов энергии в ' +
                  cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   glKindEn    := strEnergy[KindEnergy];
   Page.ShowBandByType(btReportTitle);
   Page.ShowBandByName('MasterData1');
   FillReport(Page);
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPValidSlice.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'   then begin ParValue := WorksName; end;
   if ParName = 'FirstSign'   then begin ParValue := FirstSign; end;
   if ParName = 'ThirdSign'   then begin ParValue := ThirdSign; end;
   if ParName = 'SecondSign'  then begin ParValue := SecondSign; end;
   if ParName = 'TtlMainName' then begin ParValue := globalTitle; end;
   if ParName = 'KindEn'      then begin ParValue := glKindEn; end;
   if ParName = 'NDogovor'    then begin ParValue := NDogovor; end;
   if ParName = 'NameObject'  then begin ParValue := NameObject; end;
   if ParName = 'Adress'      then begin ParValue := Adress; end;
   if ParName = 'Tbl1Name'    then begin ParValue := glTable1Name; end;
   if ParName = 'VMeterName'  then begin ParValue := VMeterName; end;
   if ParName = 's1'          then begin ParValue := sl[1]; end;
   if ParName = 's2'          then begin ParValue := sl[2]; end;
   if ParName = 's3'          then begin ParValue := sl[3]; end;
   if ParName = 's4'          then begin ParValue := sl[4]; end;
   if ParName = 's5'          then begin ParValue := sl[5]; end;
   if ParName = 's6'          then begin ParValue := sl[6]; end;
   if ParName = 's7'          then begin ParValue := sl[7]; end;
   if ParName = 's8'          then begin ParValue := sl[8]; end;
   if ParName = 's9'          then begin ParValue := sl[9]; end;
   if ParName = 's10'         then begin ParValue := sl[10]; end;
   if ParName = 's11'         then begin ParValue := sl[11]; end;
   if ParName = 's12'         then begin ParValue := sl[12]; end;
   if ParName = 's13'         then begin ParValue := sl[13]; end;
   if ParName = 's14'         then begin ParValue := sl[14]; end;
   if ParName = 's15'         then begin ParValue := sl[15]; end;
   if ParName = 's16'         then begin ParValue := sl[16]; end;
   if ParName = 's17'         then begin ParValue := sl[17]; end;
   if ParName = 's18'         then begin ParValue := sl[18]; end;
   if ParName = 's19'         then begin ParValue := sl[19]; end;
   if ParName = 's20'         then begin ParValue := sl[20]; end;
   if ParName = 's21'         then begin ParValue := sl[21]; end;
   if ParName = 's22'         then begin ParValue := sl[22]; end;
   if ParName = 's23'         then begin ParValue := sl[23]; end;
   if ParName = 's24'         then begin ParValue := sl[24]; end;
   if ParName = 's25'         then begin ParValue := sl[25]; end;
   if ParName = 's26'         then begin ParValue := sl[26]; end;
   if ParName = 's27'         then begin ParValue := sl[27]; end;
   if ParName = 's28'         then begin ParValue := sl[28]; end;
   if ParName = 's29'         then begin ParValue := sl[29]; end;
   if ParName = 's30'         then begin ParValue := sl[30]; end;
   if ParName = 's31'         then begin ParValue := sl[31]; end;
   if ParName = 's'           then begin ParValue := sl[0]; end;
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
end;

procedure TRPValidSlice.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
   if View.Name = 'Memo2' then
     View.FillColor := clColors[cl_sl[1]];
   if View.Name = 'Memo10' then
     View.FillColor := clColors[cl_sl[2]];
   if View.Name = 'Memo40' then
     View.FillColor := clColors[cl_sl[3]];
   if View.Name = 'Memo41' then
     View.FillColor := clColors[cl_sl[4]];
   if View.Name = 'Memo42' then
     View.FillColor := clColors[cl_sl[5]];
   if View.Name = 'Memo3' then
     View.FillColor := clColors[cl_sl[6]];
   if View.Name = 'Memo43' then
     View.FillColor := clColors[cl_sl[7]];
   if View.Name = 'Memo44' then
     View.FillColor := clColors[cl_sl[8]];
   if View.Name = 'Memo45' then
     View.FillColor := clColors[cl_sl[9]];
   if View.Name = 'Memo46' then
     View.FillColor := clColors[cl_sl[10]];
   if View.Name = 'Memo49' then
     View.FillColor := clColors[cl_sl[11]];
   if View.Name = 'Memo50' then
     View.FillColor := clColors[cl_sl[12]];
   if View.Name = 'Memo51' then
     View.FillColor := clColors[cl_sl[13]];
   if View.Name = 'Memo54' then
     View.FillColor := clColors[cl_sl[14]];
   if View.Name = 'Memo56' then
     View.FillColor := clColors[cl_sl[15]];
   if View.Name = 'Memo58' then
     View.FillColor := clColors[cl_sl[16]];
   if View.Name = 'Memo59' then
     View.FillColor := clColors[cl_sl[17]];
   if View.Name = 'Memo60' then
     View.FillColor := clColors[cl_sl[18]];
   if View.Name = 'Memo61' then
     View.FillColor := clColors[cl_sl[19]];
   if View.Name = 'Memo62' then
     View.FillColor := clColors[cl_sl[20]];
   if View.Name = 'Memo63' then
     View.FillColor := clColors[cl_sl[21]];
   if View.Name = 'Memo64' then
     View.FillColor := clColors[cl_sl[22]];
   if View.Name = 'Memo65' then
     View.FillColor := clColors[cl_sl[23]];
   if View.Name = 'Memo66' then
     View.FillColor := clColors[cl_sl[24]];
   if View.Name = 'Memo67' then
     View.FillColor := clColors[cl_sl[25]];
   if View.Name = 'Memo68' then
     View.FillColor := clColors[cl_sl[26]];
   if View.Name = 'Memo69' then
     View.FillColor := clColors[cl_sl[27]];
   if View.Name = 'Memo70' then
     View.FillColor := clColors[cl_sl[28]];
   if View.Name = 'Memo71' then
     View.FillColor := clColors[cl_sl[29]];
   if View.Name = 'Memo72' then
     View.FillColor := clColors[cl_sl[30]];
   if View.Name = 'Memo73' then
     View.FillColor := clColors[cl_sl[31]];
   if View.Name = 'Memo74' then
     View.FillColor := clColors[cl_sl[0]];
   if View.Name = 'Memo75' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo76' then View.FillColor := $00E1FFE1;
   {
   if View.Name = 'Memo4' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo5' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo6' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo7' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo11' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo13' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo14' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo15' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo16' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo17' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo18' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo19' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo20' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo21' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo22' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo23' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo24' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo25' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo26' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo27' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo28' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo29' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo30' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo31' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo32' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo33' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo34' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo35' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo36' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo37' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo38' then View.FillColor := $00E1FFE1;
   if View.Name = 'Memo39' then View.FillColor := $00E1FFE1;
   }

end;

end.
