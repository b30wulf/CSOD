unit knslRPPokEnerg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  FR_Desgn, FR_Class, utlbox;

type
  TrpPokEnerg = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
  private
    { Private declarations }
    VMeters           : SL3GROUPTAG;
    m_pGrData         : L3GRAPHDATAS;
    Data              : CCDatas;
    FsgGrid           : PTAdvStringGrid;
    DateReport        : TDateTime;
    FDB               : PCDBDynamicConn;
    ItemInd           : integer;
    Koef              : extended;
    globalTtlMainName : string;
    globalTblName     : string;
    globalTblDate     : string[15];
    globalTblNakEn    : string;
    globalTblRasnEn   : string;
    globalTblRasxEn   : string;
    PokDay            : array [1..31] of extended;
    RaznDay           : array [1..31] of extended;
    IsData            : array [1..31] of boolean;
    FABOID            : Integer;
  public
    { Public declarations }
    KindEnergy  : integer;
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign         : string;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode : string;
    procedure  OnFormResize;
    procedure  SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure  PrepareTable;
    procedure  PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
    procedure  ReadArch(Date : TDateTime);
    procedure  FillReport(Date : TDateTime);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpPokEnerg: TrpPokEnerg;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');
implementation

{$R *.DFM}

procedure TrpPokEnerg.PrepareTable;
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
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;
   end;
   OnFormResize;
end;

procedure TrpPokEnerg.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TrpPokEnerg.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpPokEnerg.PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
begin
   DateReport  := Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   frReport1.ShowReport;
end;

procedure TrpPokEnerg.ReadArch(Date : TDateTime);
var j, k, i          : integer;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
begin
   DecodeDate(Date, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   FDB.GetGData(Date, Date, StrToInt(FsgGrid.Cells[0, ItemInd]),
                QRY_NAK_EN_MONTH_EP + KindEnergy, 0, Data);
   for i := 0 to Data.Count - 1 do
     if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= 3) then
       PokDay[1] := PokDay[1] + Data.Items[i].m_sfValue/Koef;
   if FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, ItemInd]),
                           QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
     for k := 0 to m_pGrData.Count - 1 do
     begin
       DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
       for j := 0 to 47 do
       begin
         RaznDay[Day] := RaznDay[Day] + m_pGrData.Items[k].v[j]/Koef;
         IsData[Day]  := true;
       end;
       if Day <> 31 then
         PokDay[Day + 1] := PokDay[Day] + RaznDay[Day];
     end;
end;

procedure TrpPokEnerg.FillReport(Date : TDateTime);
var Year, Month, Day : word;
begin
   DecodeDate(Date, Year, Month, Day);
   globalTblDate   := DateToStr(Date);
   if IsData[Day] then
   begin
     globalTblNakEn  := DVLS(PokDay[Day]);
     globalTblRasnEn := DVLS(RaznDay[Day]);
     globalTblRasxEn := DVLS(RaznDay[Day]*Koef);
   end
   else
   begin
     globalTblNakEn  := 'Н/Д';
     globalTblRasnEn := 'Н/Д';
     globalTblRasxEn := 'Н/Д';
   end;
end;

procedure TrpPokEnerg.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;                       
begin
   for i := 0 to 31 do
   begin
     PokDay[i]  := 0;
     RaznDay[i] := 0;
     IsData[i]  := false;
   end;
   Koef   := StrToFloat(FsgGrid.Cells[3, ItemInd]);
   DecodeDate(DateReport, Year, Month, Day);
   globalTtlMainName := 'Показания счетчика на конец дня в ' + cDateTimeR.GetNameMonth(Month)
                         + ' ' + IntToStr(Year) + ' года';
   globalTblName  := 'Отчетный субабонент: ' + FsgGrid.Cells[1, ItemInd];
   Page.ShowBandByType(btReportTitle);
   Day      := 1;
   TempDate := EncodeDate(Year, Month, Day);
   ReadArch(TempDate);
   while cDateTimeR.CompareMonth(TempDate, DateReport) = 0 do
   begin
     FillReport(TempDate);
     Page.ShowBandByName('MasterData1');
     cDateTimeR.IncDate(TempDate);
   end;
   Page.ShowBandByName('PageFooter1');
   //FsgGrid := nil;
end;

procedure TrpPokEnerg.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'   then ParValue := WorksName;
   if ParName = 'FirstSign'   then ParValue := FirstSign;
   if ParName = 'ThirdSign'   then ParValue := ThirdSign;
   if ParName = 'SecondSign'  then ParValue := SecondSign;
   if ParName = 'TtlMainName' then ParValue := globalTtlMainName;
   if ParName = 'TtlNameTbl'  then ParValue := globalTblName;
   if ParName = 'KindEnergy'  then ParValue := strEnergy[KindEnergy];
   if ParName = 'TblDate'     then ParValue := globalTblDate;
   if ParName = 'TblDayPok'   then ParValue := globalTblNakEn;
   if ParName = 'TblDayRazn'  then ParValue := globalTblRasnEn;
   if ParName = 'TblDayRasx'  then ParValue := globalTblRasxEn;
   if ParName = 'NDogovor'    then ParValue := NDogovor;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;
end;

end.
