unit knslRPCalcHeatMTZ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  FR_Desgn, FR_Class, utlbox;

type
  TRPCalcHeatMTZ = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    FDB              : PCDBDynamicConn;
    FsgGrid          : PTAdvStringGrid;
    FABOID           : Integer;
    DateReport       : TDateTime;
    ItemInd          : Integer;
    VMID             : Integer;
    PokEnP, PokEnO   : array [1..32] of Double;
    PokMP, PokMO     : array [1..32] of Double;
    PokVP, PokVO     : array [1..32] of Double;
    SumEnD, SumMD,
    SumVD, SumEn,
    SumM, SumV       : Double;
    glTtlMainName    : string;
    glDay            : string;
    glPokEnFKan      : Double;
    glPokEnSKan      : Double;
    glPokEnR         : Double;
    glPokVFKan       : Double;
    glPokVSKan       : Double;
    glPokVR          : Double;
    glPokMFKan       : Double;
    glPokMSKan       : Double;
    glPokMR          : Double;
    glDecName        : String;
    glPokEnRDS       : Double;
    glPokVRDS        : Double;
    glPokMRDS        : Double;
    glPokEnRS        : Double;
    glPokVRS         : Double;
    glPokMRS         : Double;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure ReadPokEn();
    procedure ReadPokV();
    procedure ReadPokM();
    procedure ReadPokEnPFromArray(Day: integer);
    procedure ReadPokEnOFromArray(Day: integer);
    procedure ReadPokMPFromArray(Day: integer);
    procedure ReadPokMOFromArray(Day: integer);
    procedure ReadPokVPFromArray(Day: integer);
    procedure ReadPokVOFromArray(Day: integer);
    procedure MakeReport(var Page: TfrPage);
  public
    { Public declarations }
    prGroupID        : integer;
    glWorksName      : string;
    glNameObject     : string;
    glAdress         : string;
    glFirstSign      : string;
    glSecondSign     : string;
    glThirdSign      : string;
    procedure PrepareTable;
    procedure ShowReport(DateReport : TDateTime);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  RPCalcHeatMTZ: TRPCalcHeatMTZ;

implementation

{$R *.DFM}

procedure TRPCalcHeatMTZ.PrepareTable;
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

   if not FDB.GetMeterGLVTableForReport(FABOID,prGroupID,0, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := 2;
     for i := 0 to Meters.Count - 1 do
     begin
       if (Meters.m_sMeter[i].m_sbyType <> MET_TEM501) then
         continue;
       FsgGrid.Cells[0,FsgGrid.RowCount-1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,FsgGrid.RowCount-1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,FsgGrid.RowCount-1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,FsgGrid.RowCount-1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,FsgGrid.RowCount-1] := Meters.m_sMeter[i].m_sName;
       FsgGrid.RowCount := FsgGrid.RowCount + 1;
     end;
   end;
   OnFormResize;
end;

procedure TRPCalcHeatMTZ.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPCalcHeatMTZ.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPCalcHeatMTZ.ShowReport(DateReport : TDateTime);
begin
   Self.DateReport := cDateTimeR.GetBeginMonth(DateReport);
   ItemInd := FsgGrid.Row;
   if (FsgGrid.Cells[0, ItemInd] <> '') and (FsgGrid.Cells[1, ItemInd] <> '') and (FsgGrid.Cells[2, ItemInd] <> '') and
      (FsgGrid.Cells[3, ItemInd] <> '') and (ItemInd <> 0) then
     frReport1.ShowReport
   else
     exit;
end;

procedure TRPCalcHeatMTZ.ReadPokEn();
var pTable           : CCDatas;
    Day, Year, Month : word;
    i                : integer;
    j                : integer;
    TempDate         : TDateTime;
begin
   TempDate := DateReport;
   cDateTimeR.IncMonth(TempDate);
   //PDB.GetGDPData_48(TempDate, DateReport, VMID,
   //             QRY_POD_TRYB_NAK_HEAT, QRY_POD_TRYB_NAK_HEAT, pTable);
   pTable.Count := 0; ///!!!!
   i := 0;
   while i*48 <= (pTable.Count - 1) do
   begin
     for j := 0 to 47 do
     begin
       if IsBitInMask(pTable.Items[i*48 + j].m_sbyMaskRead, j) then
       begin
         DecodeDate(pTable.Items[i*48 + j].m_sTime, Year, Month, Day);
         if cDateTimeR.CompareMonth(pTable.Items[i*48 + j].m_sTime, DateReport) = 0 then
           PokEnP[Day] := pTable.Items[i*48 + j].m_sfValue
         else
           PokEnP[32] := pTable.Items[i*48 + j].m_sfValue;
         break;
       end;
     end;
     i := i + 1;
   end;

   {PDB.GetGDPData_48(TempDate, DateReport, VMID,
                QRY_OBR_TRYB_NAK_HEAT, QRY_OBR_TRYB_NAK_HEAT, pTable);   }
   pTable.Count := 0; ///!!!!
   i := 0;
   while i*48 <= (pTable.Count - 1) do
   begin
     for j := 0 to 47 do
     begin
       if IsBitInMask(pTable.Items[i*48 + j].m_sbyMaskRead, j) then
       begin
         DecodeDate(pTable.Items[i*48 + j].m_sTime, Year, Month, Day);
         if cDateTimeR.CompareMonth(pTable.Items[i*48 + j].m_sTime, DateReport) = 0 then
           PokEnO[Day] := pTable.Items[i*48 + j].m_sfValue
         else
           PokEnO[32] := pTable.Items[i*48 + j].m_sfValue;
         break;
       end;
     end;
     i := i + 1;
   end;
end;

procedure TRPCalcHeatMTZ.ReadPokV();
var pTable           : CCDatas;
    Day, Year, Month : word;
    i                : integer;
    j                : integer;
    TempDate         : TDateTime;
begin
   TempDate := DateReport;
   cDateTimeR.IncMonth(TempDate);
   {PDB.GetGDPData_48(TempDate, DateReport, VMID,
                QRY_POD_TRYB_NAK_V, QRY_POD_TRYB_NAK_V, pTable);}
   pTable.Count := 0; ///!!!!
   i := 0;
   while i*48 <= (pTable.Count - 1) do
   begin
     for j := 0 to 47 do
     begin
       if IsBitInMask(pTable.Items[i*48 + j].m_sbyMaskRead, j) then
       begin
         DecodeDate(pTable.Items[i*48 + j].m_sTime, Year, Month, Day);
         if cDateTimeR.CompareMonth(pTable.Items[i*48 + j].m_sTime, DateReport) = 0 then
           PokVP[Day] := pTable.Items[i*48 + j].m_sfValue
         else
           PokVP[32] := pTable.Items[i*48 + j].m_sfValue;
         break;
       end;
     end;
     i := i + 1;
   end;

  { PDB.GetGDPData_48(TempDate, DateReport, VMID,
                QRY_OBR_TRYB_NAK_V, QRY_OBR_TRYB_NAK_V, pTable);     }
  pTable.Count := 0; ///!!!!
   i := 0;
   while i*48 <= (pTable.Count - 1) do
   begin
     for j := 0 to 47 do
     begin
       if IsBitInMask(pTable.Items[i*48 + j].m_sbyMaskRead, j) then
       begin
         DecodeDate(pTable.Items[i*48 + j].m_sTime, Year, Month, Day);
         if cDateTimeR.CompareMonth(pTable.Items[i*48 + j].m_sTime, DateReport) = 0 then
           PokVO[Day] := pTable.Items[i*48 + j].m_sfValue
         else
           PokVO[32] := pTable.Items[i*48 + j].m_sfValue;
         break;
       end;
     end;
     i := i + 1;
   end;
end;

procedure TRPCalcHeatMTZ.ReadPokM();
var pTable           : CCDatas;
    Day, Year, Month : word;
    i                : integer;
    j                : integer;
    TempDate         : TDateTime;
begin
   TempDate := DateReport;
   cDateTimeR.IncMonth(TempDate);
   {PDB.GetGDPData_48(TempDate, DateReport, VMID,
                QRY_POD_TRYB_NAK_RASX, QRY_POD_TRYB_NAK_RASX, pTable); }
   pTable.Count := 0; ///!!!!
   i := 0;
   while i*48 <= (pTable.Count - 1) do
   begin
     for j := 0 to 47 do
     begin
       if IsBitInMask(pTable.Items[i*48 + j].m_sbyMaskRead, j) then
       begin
         DecodeDate(pTable.Items[i*48 + j].m_sTime, Year, Month, Day);
         if cDateTimeR.CompareMonth(pTable.Items[i*48 + j].m_sTime, DateReport) = 0 then
           PokMP[Day] := pTable.Items[i*48 + j].m_sfValue
         else
           PokMP[32] := pTable.Items[i*48 + j].m_sfValue;
         break;
       end;
     end;
     i := i + 1;
   end;

   {PDB.GetGDPData_48(TempDate, DateReport, VMID,
                QRY_OBR_TRYB_NAK_RASX, QRY_OBR_TRYB_NAK_RASX, pTable);   }
   pTable.Count := 0; ///!!!!
   i := 0;
   while i*48 <= (pTable.Count - 1) do
   begin
     for j := 0 to 47 do
     begin
       if IsBitInMask(pTable.Items[i*48 + j].m_sbyMaskRead, j) then
       begin
         DecodeDate(pTable.Items[i*48 + j].m_sTime, Year, Month, Day);
         if cDateTimeR.CompareMonth(pTable.Items[i*48 + j].m_sTime, DateReport) = 0 then
           PokMO[Day] := pTable.Items[i*48 + j].m_sfValue
         else
           PokMO[32] := pTable.Items[i*48 + j].m_sfValue;
         break;
       end;
     end;
     i := i + 1;
   end;
end;

procedure TRPCalcHeatMTZ.ReadPokEnPFromArray(Day: integer);
begin
   glPokEnFKan := 0;
   if (PokEnP[Day] <> -1) then
     glPokEnFKan := RVLPr(PokEnP[Day], MeterPrecision[VMID]);
end;

procedure TRPCalcHeatMTZ.ReadPokEnOFromArray(Day: integer);
var i    : integer;
    temp : double;
begin
   glPokEnSKan := 0;
   glPokEnR := 0;
   if (PokEnO[Day] <> -1) then
     glPokEnSKan := RVLPr(PokEnO[Day], MeterPrecision[VMID]);
   for i := Day + 1 to 32 do
   begin
      if (PokEnP[Day] <> -1) and (PokEnO[Day] <> -1) and
         (PokEnP[i] <> -1) and  (PokEnO[i] <> -1) then
      begin
        //temp := RVLPr((PokEnP[i] - PokEnP[Day]) - (PokEnO[i] - PokEnO[Day]), MeterPrecision[VMID]);
        temp := (RVLPr(PokEnP[i], MeterPrecision[VMID]) - RVLPr(PokEnP[Day], MeterPrecision[VMID])) -
           (RVLPr(PokEnO[i], MeterPrecision[VMID]) - RVLPr(PokEnO[Day], MeterPrecision[VMID]));
        glPokEnR := temp;
        SumEnD := SumEnD + glPokEnR;
        SumEn  := SumEn + glPokEnR;
        break;
      end;
   end;
end;

procedure TRPCalcHeatMTZ.ReadPokMPFromArray(Day: integer);
begin
   glPokMFKan := 0;
   if (PokMP[Day] <> -1) then
     glPokMFKan := RVLPr(PokMP[Day], MeterPrecision[VMID]);
end;

procedure TRPCalcHeatMTZ.ReadPokMOFromArray(Day: integer);
var i    : integer;
    temp : double;
begin
   glPokMSKan := 0;
   glPokMR    := 0;
   if (PokMO[Day] <> -1) then
     glPokMSKan := RVLPr(PokMO[Day], MeterPrecision[VMID]);
   for i := Day + 1 to 32 do
   begin
      if (PokMP[Day] <> -1) and (PokMO[Day] <> -1) and
         (PokMP[i] <> -1) and  (PokMO[i] <> -1) then
      begin
        //temp := RVLPr((PokMP[i] - PokMP[Day]) - (PokMO[i] - PokMO[i]), MeterPrecision[VMID]);
        temp := (RVLPr(PokMP[i], MeterPrecision[VMID]) - RVLPr(PokMP[Day], MeterPrecision[VMID])) -
           (RVLPr(PokMO[i], MeterPrecision[VMID]) - RVLPr(PokMO[Day], MeterPrecision[VMID]));
        glPokMR := temp;
        SumMD   := SumMD + glPokMR;
        SumM    := SumM + glPokMR;
        break;
      end;
   end;
end;

procedure TRPCalcHeatMTZ.ReadPokVPFromArray(Day: integer);
begin
   glPokVFKan := 0;
   if (PokVP[Day] <> -1) then
     glPokVFKan := RVLPr(PokVP[Day], MeterPrecision[VMID]);
end;

procedure TRPCalcHeatMTZ.ReadPokVOFromArray(Day: integer);
var i    : integer;
    temp : double;
begin
   glPokVSKan := 0;
   glPokVR    := 0;
   if (PokVO[Day] <> -1) then
     glPokVSKan := RVLPr(PokVO[Day], MeterPrecision[VMID]);
   for i := Day + 1 to 32 do
   begin
      if (PokVP[Day] <> -1) and (PokVO[Day] <> -1) and
         (PokVP[i] <> -1) and  (PokVO[i] <> -1) then
      begin
        //temp := RVLPr((PokVP[i] - PokVP[Day]) - (PokVO[i] - PokVO[i]), MeterPrecision[VMID]);
        temp := (RVLPr(PokVP[i], MeterPrecision[VMID]) - RVLPr(PokVP[Day], MeterPrecision[VMID])) -
           (RVLPr(PokVO[i], MeterPrecision[VMID]) - RVLPr(PokVO[Day], MeterPrecision[VMID]));
        glPokVR := temp;
        SumVD   := SumVD + glPokVR;
        SumV    := SumV + glPokVR;
        break;
      end;
   end;
end;

procedure TRPCalcHeatMTZ.MakeReport(var Page: TfrPage);
var i                : integer;
    Year, Month, Day : word;
begin
   DecodeDate(DateReport, Year, Month, Day);
   SumEn := 0; SumEnD := 0;
   SumM  := 0; SumMD  := 0;
   SumV  := 0; SumV   := 0;
   for i := 1 to cDateTimeR.DayPerMonth(Month, Year) do
   begin
     glDay := IntToStr(i);
     ReadPokEnPFromArray(i);
     ReadPokEnOFromArray(i);
     ReadPokMPFromArray(i);
     ReadPokMOFromArray(i);
     ReadPokVPFromArray(i);
     ReadPokVOFromArray(i);
     Page.ShowBandByName('MasterData1');
     if ((i mod 10) = 0) and (i < 21) then
     begin
       glDecName := IntToStr(i div 10) + ' декада';
       glPokEnRDS := RVLPr(SumEnD, MeterPrecision[VMID]);
       glPokVRDS  := RVLPr(SumVD, MeterPrecision[VMID]);
       glPokMRDS  := RVLPr(SumMD, MeterPrecision[VMID]);
       SumEnD := 0;
       SumVD  := 0;
       SumMD  := 0;
       Page.ShowBandByName('MasterData2');
     end;
   end;

   glDecName := '3 декада';
   glPokEnRDS := RVLPr(SumEnD, MeterPrecision[VMID]);
   glPokVRDS  := RVLPr(SumVD, MeterPrecision[VMID]);
   glPokMRDS  := RVLPr(SumMD, MeterPrecision[VMID]);
   Page.ShowBandByName('MasterData2');
   
   glPokEnRS := RVLPr(SumEn, MeterPrecision[VMID]);
   glPokVRS  := RVLPr(SumV, MeterPrecision[VMID]);
   glPokMRS  := RVLPr(SumM, MeterPrecision[VMID]);
   Page.ShowBandByName('MasterData3');
end;

procedure TRPCalcHeatMTZ.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i                : integer;
begin
   DecodeDate(DateReport, Year, Month, Day);
   for i := 1 to 32 do
   begin
     PokEnP[i] := -1;
     PokEnO[i] := -1;
     PokMP[i]  := -1;
     PokMO[i]  := -1;
     PokVP[i]  := -1;
     PokVO[i]  := -1;
   end;
   VMID := StrToInt(FsgGrid.Cells[0, ItemInd]);
   glTtlMainName := 'Показания теплосчетчиков в ' + cDateTimeR.GetNameMonth(Month) + ' ' +
        IntToStr(Year) + ' года';
   Page.ShowBandByType(btReportTitle);
   ReadPokEn();
   ReadPokV();
   ReadPokM();
   Page.ShowBandByName('MasterHeader1');
   MakeReport(Page);
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPCalcHeatMTZ.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'   then ParValue := glWorksName;
   if ParName = 'NameObject'  then ParValue := glNameObject;
   if ParName = 'Adress'      then ParValue := glAdress;
   if ParName = 'TtlMainName' then ParValue := glTtlMainName;
   if ParName = 'Day'         then ParValue := glDay;
   if ParName = 'PokEnFKan'   then ParValue := glPokEnFKan;
   if ParName = 'PokEnSKan'   then ParValue := glPokEnSKan;
   if ParName = 'PokEnR'      then ParValue := glPokEnR;
   if ParName = 'PokVFKan'    then ParValue := glPokVFKan;
   if ParName = 'PokVSKan'    then ParValue := glPokVSKan;
   if ParName = 'PokVR'       then ParValue := glPokVR;
   if ParName = 'PokMFKan'    then ParValue := glPokMFKan;
   if ParName = 'PokMSKan'    then ParValue := glPokMSKan;
   if ParName = 'PokMR'       then ParValue := glPokMR;
   if ParName = 'DecName'     then ParValue := glDecName;
   if ParName = 'PokEnRDS'    then ParValue := glPokEnRDS;
   if ParName = 'PokVRDS'     then ParValue := glPokVRDS;
   if ParName = 'PokMRDS'     then ParValue := glPokMRDS;
   if ParName = 'PokEnRS'     then ParValue := glPokEnRS;
   if ParName = 'PokVRS'      then ParValue := glPokVRS;
   if ParName = 'PokMRS'      then ParValue := glPokMRS;
   if ParName = 'FirstSign'   then ParValue := glFirstSign;
   if ParName = 'SecondSign'  then ParValue := glSecondSign;
   if ParName = 'ThirdSign'   then ParValue := glThirdSign;
end;

end.
