unit knslRPTeploMoz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TRPTeploMoz = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
  private
    { Private declarations }
    FDB                  : PCDBDynamicConn;
    FsgGrid              : PTAdvStringGrid;
    FABOID               : Integer;
    GroupID              : integer;
    dt1, dt2             : TDateTime;
    VMeterName           : string;
    globalTitle          : string;
    SerialNumb           : string;
    PokTepPodBeg         : string;
    PokTepObrBeg         : string;
    PokTimBeg            : string;
    PokErrBeg            : string;
    PokTepPodEnd         : string;
    PokTepObrEnd         : string;
    PokTimEnd            : string;
    PokErrEnd            : string;
    PokTepPodRaz         : string;
    PokTepObrRaz         : string;
    PokTimRaz            : string;
    PokErrRaz            : string;
    KolPotrEnerg         : string;
    WorkDays             : string;
    PokObPodBeg          : string;
    PokObmObrBeg         : string;
    PokObPodEnd          : string;
    PokObmObrEnd         : string;
    PokObPodRaz          : string;
    PokObmObrRaz         : string;
    KolPotrObm           : string;
    DateBegEnd           : string;
    procedure OnFormResize;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure InitStringValues;
    procedure FillReport;
    procedure FillReportTtl;
  public
    { Public declarations }
    WorksName            : string;
    FirstSign            : string;
    SecondSign           : string;
    ThirdSign            : string;
    NDogovor             : string;
    NameObject           : string;
    Adress               : string;
    KindEnergy           : integer;
    ItemInd              : integer;
    procedure PrepareTable;
    procedure PrintPreview(dt_beg, dt_end : TDateTime);
  public
    property PsgGrid     : PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   : integer          read GroupID      write GroupID;
    property PDB         : PCDBDynamicConn  read FDB          write FDB;
    property PABOID      : Integer          read FABOID       write FABOID;
  end;

var
  RPTeploMoz: TRPTeploMoz;

implementation

{$R *.DFM}

procedure TRPTeploMoz.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPTeploMoz.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPTeploMoz.PrepareTable;
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
   if not FDB.GetMeterGLVTableForReport(FABOID,GroupID,2, Meters) then
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

procedure TRPTeploMoz.PrintPreview(dt_beg, dt_end : TDateTime);
begin
   if FsgGrid.RowCount = 1 then
     exit;
   if ItemInd = 0 then
     ItemInd := 1;
   dt1 := dt_beg;
   dt2 := dt_end;
   frReport1.ShowReport;
end;

procedure TRPTeploMoz.InitStringValues;
begin
   PokTepPodBeg         := 'Н/Д';
   PokTepObrBeg         := 'Н/Д';
   PokTimBeg            := '';
   PokErrBeg            := '';
   PokTepPodEnd         := 'Н/Д';
   PokTepObrEnd         := 'Н/Д';
   PokTimEnd            := '-';
   PokErrEnd            := '-';
   PokTepPodRaz         := '-';
   PokTepObrRaz         := '-';
   PokTimRaz            := '-';
   PokErrRaz            := '-';
   KolPotrEnerg         := '-';
   WorkDays             := '0';
   PokObPodBeg          := 'Н/Д';
   PokObmObrBeg         := 'Н/Д';
   PokObPodEnd          := 'Н/Д';
   PokObmObrEnd         := 'Н/Д';
   PokObPodRaz          := '-';
   PokObmObrRaz         := '-';
   KolPotrObm           := '-';
   DateBegEnd           := '-';
end;

procedure TRPTeploMoz.FillReport;
var Data       : CCDatas;
    i          : integer;
    tempVal    : Double;
begin
   if PDB.GetGData(dt2, dt1, StrToInt(FsgGrid.Cells[0, ItemInd]), QRY_POD_TRYB_HEAT, 0, Data) then  //AAV
   begin
     if (trunc(Data.Items[0].m_sTime) = trunc(dt1)) then
       PokTepPodBeg := FloatToStrF(Data.Items[0].m_sfValue, ffFixed, 10, 3);
     if (trunc(Data.Items[Data.Count - 1].m_sTime) = trunc(dt2)) then
       PokTepPodEnd := FloatToStrF(Data.Items[Data.Count - 1].m_sfValue, ffFixed, 10, 3);
   end;
   if PDB.GetGData(dt2, dt1, StrToInt(FsgGrid.Cells[0, ItemInd]), QRY_OBR_TRYB_HEAT, 1, Data) then  //AAV
   begin
     if (trunc(Data.Items[0].m_sTime) = trunc(dt1)) then
       PokTepObrBeg := FloatToStrF(Data.Items[0].m_sfValue, ffFixed, 10, 3);
     if (trunc(Data.Items[Data.Count - 1].m_sTime) = trunc(dt2)) then
       PokTepObrEnd := FloatToStrF(Data.Items[Data.Count - 1].m_sfValue, ffFixed, 10, 3);
   end;
   if PDB.GetGData(dt2, dt1, StrToInt(FsgGrid.Cells[0, ItemInd]), QRY_POD_TRYB_V, 0, Data) then  //AAV
   begin
     if (trunc(Data.Items[0].m_sTime) = trunc(dt1)) then
       PokObPodBeg := FloatToStrF(Data.Items[0].m_sfValue, ffFixed, 10, 1);
     if (trunc(Data.Items[Data.Count - 1].m_sTime) = trunc(dt2)) then
       PokObPodEnd := FloatToStrF(Data.Items[Data.Count - 1].m_sfValue, ffFixed, 10, 1);
   end;
   if PDB.GetGData(dt2, dt1, StrToInt(FsgGrid.Cells[0, ItemInd]), QRY_OBR_TRYB_V, 0, Data) then   //AAV
   begin
     if (trunc(Data.Items[0].m_sTime) = trunc(dt1)) then
       PokObmObrBeg := FloatToStrF(Data.Items[0].m_sfValue, ffFixed, 10, 1);
     if (trunc(Data.Items[Data.Count - 1].m_sTime) = trunc(dt2)) then
       PokObmObrEnd := FloatToStrF(Data.Items[Data.Count - 1].m_sfValue, ffFixed, 10, 1);
   end;
   if PDB.GetGData(dt2, dt1, StrToInt(FsgGrid.Cells[0, ItemInd]), QRY_POD_TRYB_RUN_TIME, 0, Data) then //AAV
   begin
     tempVal := 0;
     for i := 0 to Data.Count - 1 do
       tempVal := tempVal + Data.Items[i].m_sfValue;
     PokTimRaz := FloatToStrF(tempVal, ffFixed, 10, 2);
     WorkDays   := IntToStr(round(tempVal / 24));
   end;
   if PDB.GetGData(dt2, dt1, StrToInt(FsgGrid.Cells[0, ItemInd]), QRY_WORK_TIME_ERR, 0, Data) then   //AAV
   begin
     tempVal := 0;
     for i := 0 to Data.Count - 1 do
       tempVal := tempVal + Data.Items[i].m_sfValue;
     PokErrRaz := FloatToStrF(tempVal, ffFixed, 10, 2);
   end;
end;

procedure TRPTeploMoz.FillReportTtl;
begin
   if (PokTepPodBeg <> 'Н/Д') and (PokTepPodEnd <> 'Н/Д') then
     PokTepPodRaz := FloatToStrF(StrToFloat(PokTepPodEnd) - StrToFloat(PokTepPodBeg), ffFixed, 10, 3);
   if (PokTepObrBeg <> 'Н/Д') and (PokTepObrEnd <> 'Н/Д') then
     PokTepObrRaz := FloatToStrF(StrToFloat(PokTepObrEnd) - StrToFloat(PokTepObrBeg), ffFixed, 10, 3);
   if (PokTepPodRaz <> '-') and (PokTepObrRaz <> '-') then
     KolPotrEnerg := FloatToStrF(StrToFloat(PokTepPodRaz) - StrToFloat(PokTepObrRaz), ffFixed, 10, 3);
   if (PokObPodBeg <> 'Н/Д') and (PokObPodEnd <> 'Н/Д') then
     PokObPodRaz := FloatToStrF(StrToFloat(PokObPodEnd) - StrToFloat(PokObPodBeg), ffFixed, 10, 3);
   if (PokObmObrBeg <> 'Н/Д') and (PokObmObrEnd <> 'Н/Д') then
     PokObmObrRaz := FloatToStrF(StrToFloat(PokObmObrEnd) - StrToFloat(PokObmObrBeg), ffFixed, 10, 3);
   if (PokObPodRaz <> '-') and (PokObmObrRaz <> '-') then
     KolPotrObm := FloatToStrF(StrToFloat(PokObPodRaz) - StrToFloat(PokObmObrRaz), ffFixed, 10, 3);
end;

procedure TRPTeploMoz.frReport1ManualBuild(Page: TfrPage);
begin
   InitStringValues;
   DateBegEnd := DateToStr(dt1) + 'г ' + 'по ' + DateToStr(dt2) + 'г';
   SerialNumb :=  '№' + FsgGrid.Cells[2, ItemInd];
   Page.ShowBandByType(btReportTitle);
   FillReport;
   FillReportTtl;
   Page.ShowBandByName('MasterData1');
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPTeploMoz.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName' then ParValue := WorksName;
   if ParName = 'DateBegEnd' then ParValue := DateBegEnd;
   if ParName = 'WorkAdress' then ParValue := Adress;
   if ParName = 'SerialNumb' then ParValue := SerialNumb;
   if ParName = 'PokTepPodBeg' then ParValue := PokTepPodBeg;
   if ParName = 'PokTepObrBeg' then ParValue := PokTepObrBeg;
   if ParName = 'PokTimBeg' then ParValue := PokTimBeg;
   if ParName = 'PokErrBeg' then ParValue := PokErrBeg;
   if ParName = 'PokTepPodEnd' then ParValue := PokTepPodEnd;
   if ParName = 'PokTepObrEnd' then ParValue := PokTepObrEnd;
   if ParName = 'PokTimEnd' then ParValue := PokTimEnd;
   if ParName = 'PokErrEnd' then ParValue := PokErrEnd;
   if ParName = 'PokTepPodRaz' then ParValue := PokTepPodRaz;
   if ParName = 'PokTepObrRaz' then ParValue := PokTepObrRaz;
   if ParName = 'PokTimRaz' then ParValue := PokTimRaz;
   if ParName = 'PokErrRaz' then ParValue := PokErrRaz;
   if ParName = 'KolPotrEnerg' then ParValue := KolPotrEnerg;
   if ParName = 'WorkDays' then ParValue := WorkDays;
   if ParName = 'PokObPodBeg' then ParValue := PokObPodBeg;
   if ParName = 'PokObmObrBeg' then ParValue := PokObmObrBeg;
   if ParName = 'PokObPodEnd' then ParValue := PokObPodEnd;
   if ParName = 'PokObmObrEnd' then ParValue := PokObmObrEnd;
   if ParName = 'PokObPodRaz' then ParValue := PokObPodRaz;
   if ParName = 'PokObmObrRaz' then ParValue := PokObmObrRaz;
   if ParName = 'KolPotrObm' then ParValue := KolPotrObm;
end;

end.
