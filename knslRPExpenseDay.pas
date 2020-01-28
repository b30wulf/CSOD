unit knslRPExpenseDay;                                                
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;

type
  TrpExpenseDay = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
  private
    { Private declarations }
    m_ID              : Word;
    glKoef            : extended;
    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergRazn       : array [1..4] of extended;
    glEnergRasx       : array [1..4] of extended;
    glMB              : string[15];
    glME              : string[15];

    globalTitle       : string;
    globalMeterName   : string;
    glSum             :  string;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    DateReport        : TDateTime;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glCountTable      : integer;
    globalTblDate     : string[15];
    glCountTableShow  : string;
    glSumEnergy       : array [1..4] of extended;

    glTblData:string;
    glTblSub:string;
    glTblRasx:string;
    sEnerType:string;
    strKoefTs:string;
    FABOID            : Integer;
    Meters : SL2TAGREPORTLIST;
    sKindEn : string;


    procedure OnFormResize;
    procedure FillReport(MID : integer; var Page :TfrPage;Date : TDateTime);
    procedure FillReportTtl(var Page : TfrPage);
    procedure ShowGlParam(byType:Byte;MID : integer;var Page : TfrPage);
    procedure FillTitle(byType:Byte);
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign   : string;
    KindEnergy  : integer;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    //SumEnergy 
    procedure PrintPreview(Date : TDateTime;CountTable :integer);
    procedure PrepareTable;
    procedure FillReportChooseParam;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
  end;

var
  rpExpenseDay: TrpExpenseDay;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная принимаемая',
                                          'Вид энергии : Активная отдаваемая',
                                          'Вид энергии : Реактивная принимаемая',
                                          'Вид энергии : Реактивная отдаваемая');

implementation

{$R *.DFM}


procedure TrpExpenseDay.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;

procedure TrpExpenseDay.PrepareTable;
var //Meters : SL2TAGREPORTLIST;
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

procedure TrpExpenseDay.PrintPreview(Date : TDateTime;CountTable :integer);
begin
   DateReport := Date;
   glCountTable := CountTable;
   if FsgGrid.RowCount > 1 then
     frReport1.ShowReport;

end;

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}

procedure TrpExpenseDay.FillReport(MID : integer; var Page: TfrPage; Date : TDateTime);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i,r : word;
    PredDay             :word;
    param               : extended;
    nTypeID,swPLID,nMaxT: Integer;
    nTypeEn : Byte;
begin
   DecodeDate(Date, Year, Month, Day);
   for i:= 1 to 4 do
     glSumEnergy[i]  := 0;
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID];
   globalTblMeter  := '№ :' +FsgGrid.Cells[2, MID];
   Date := EncodeDate(Year, Month, Day);
   Day             := 0;
   PredDay         := 1;
   m_ID            := StrToInt(FsgGrid.Cells[0, MID]);
   nMaxT  := 3;
   swPLID := 0;
   nTypeEn:= QRY_NAK_EN_DAY_EP;
   FDB.GetMeterType(m_ID,nTypeID,swPLID);
   if swPLID=1 then nMaxT:=2;
   if nTypeID=MET_PULCR then  nTypeEn:= QRY_RASH_DAY_V;
   while (trunc(Date) <= trunc(DateReport))  do
   begin
     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);
     globalTblDate  := DateToStr(Date);

     for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergME[i]   := 0;
       glEnergRazn[i] := 0;
       glEnergRasx[i] := 0;
     end;
     if not FDB.GetGData(Date, Date, StrToInt(FsgGrid.Cells[0, MID]),
                         nTypeEn + KindEnergy, 0, Data) then
     begin
       glTblData := 'Н/Д';
       FillReportChooseParam;
       Page.ShowBandByName('MasterData1');
       Date := Date + 1;
       continue;
     end;

     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end;
     glTblData := FloatToStr(RVLPr(glEnergMB[4], MeterPrecision[m_ID]));
     Date := Date + 1;
     if not FDB.GetGData(Date, Date, StrToInt(FsgGrid.Cells[0, MID]),
                         nTypeEn + KindEnergy, 0, Data) then
     begin
       FillReportChooseParam;
       Page.ShowBandByName('MasterData1');
       //Date := Date + 1;
       continue;
     end;

     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergME[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
       end;

     for i := 1 to 4 do
     begin
       glEnergRazn[i] := glEnergME[i] - glEnergMB[i];
       glEnergRasx[i] := RVLPr(glEnergRazn[i], MeterPrecision[m_ID])*glKoef;
       SumEnergy[KindEnergy][i] := SumEnergy[KindEnergy][i] + glEnergRasx[i];
       glSumEnergy[i] := glSumEnergy[i] + glEnergRasx[i];
     end;
      FillReportChooseParam;
      Page.ShowBandByName('MasterData1');
      //Date := Date + 1;
   end;
end;

procedure TrpExpenseDay.FillReportChooseParam;
begin
{glTblData:string;
    glTblSub:string;
    glTblRasx:string;    }
   if  glEnergME[4]<=0 then
   begin
       glTblRasx := 'Н/Д';
       glTblSub  := 'Н/Д';
       //glTblData := 'Н/Д';
  end
  else
  begin
       if glEnergRasx[4]<0 then glTblRasx := 'Н/Д' else   glTblRasx  := FloatToStr(RVLPr(glEnergRasx[4], MeterPrecision[m_ID]));
       if glEnergRazn[4]<0 then glTblSub := 'Н/Д' else  glTblSub  := FloatToStr(RVLPr(glEnergRazn[4], MeterPrecision[m_ID]));
       if glEnergME[4]<=0 then glTblData := 'Н/Д' else  glTblData := FloatToStr(RVLPr(glEnergMB[4], MeterPrecision[m_ID]));
   end;

end;

procedure TrpExpenseDay.ShowGlParam(byType:Byte;MID : integer;var Page : TfrPage);
begin
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID+1];
   globalTblMeter  := '№ :' +FsgGrid.Cells[2, MID+1];
   glKoef   := StrToFloat(FsgGrid.Cells[3, MID+1]);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable) + '(продолжение)';
   FillTitle(byType);
end;
procedure TrpExpenseDay.FillTitle(byType:Byte);
Begin
   if byType=MET_PULCR then
   Begin
    sEnerType := 'м.куб';
    sKindEn   := 'Вид расхода : Расход жидкости м.куб';
    strKoefTs := 'Коэфф.преобразования';
   End else
   Begin
    sEnerType := 'кВт';
    strKoefTs := 'Коэфф.трансформации(Ki*Ku)';
    sKindEn   := strEnergy[KindEnergy];
   End;
End;

procedure TrpExpenseDay.FillReportTtl(var Page : TfrPage);
var i : byte;
begin
   if glSumEnergy[4]<0 then glSum := 'Н/Д' else
   glSum := DVLS(glSumEnergy[4]);
end;

procedure TrpExpenseDay.frReport1ManualBuild(Page: TfrPage);
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
begin
   DecodeDate(DateReport, Year, Month, Day);
   //for i := 0 to 3 do
   //  for j := 1 to 4 do
   //globalTitle := 'Отчет о фактическом потреблении электроэнергии в ' +
   //                  cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';

   globalTitle := 'Отчет о фактическом потреблении в ' +
                     cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   sKindEn := strEnergy[KindEnergy];
   Day := 1;
   TempDate := EncodeDate(Year, Month, Day);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, 1];
   globalTblMeter  := 'сч. № :' +FsgGrid.Cells[2, 1];
   glKoef   := StrToFloat(FsgGrid.Cells[3, 1]);
   if Meters.Count>0 then
    FillTitle(Meters.m_sMeter[0].m_sbyType);

   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     Day      := 1;
     TempDate := EncodeDate(Year, Month, Day);
     FillReport(i, Page,TempDate);
     FillReportTtl(Page);
     if i <> FsgGrid.RowCount - 1 then
     begin
       if i<=(Meters.Count-1) then
        ShowGlParam(Meters.m_sMeter[i].m_sbyType,i, Page);
       page.NewPage();
     end;
   end;

   Page.ShowBandByName('PageFooter1');
end;

procedure TrpExpenseDay.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin

   if ParName = 'strKoefTs'     then ParValue := strKoefTs;
   if ParName = 'EnerType'      then ParValue := sEnerType;
   if ParName = 'CountTbl'      then ParValue := glCountTableShow;
   if ParName = 'TblDate'       then ParValue := globalTblDate;
   if ParName = 'WorksName'     then ParValue := WorksName;
   if ParName = 'TtlMainName'   then ParValue := globalTitle;
   if ParName = 'DateTtlB'      then ParValue := glMB;
   if ParName = 'DateTtlE'      then ParValue := glME;
   if ParName = 'MDNameCounter' then ParValue := globalMeterName;
   if ParName = 'KindEnergy'    then ParValue := sKindEn;
   if ParName = 'TblMeter'      then ParValue := globalTblMeter;

   if ParName = 'EnerTsRasx' then ParValue := glTblRasx;
   if ParName = 'EnergTsTtl' then ParValue := glSum;
   if ParName = 'EnerTsSub'  then ParValue := glTblSub;
   if ParName = 'EnerTsME'   then ParValue := glTblData;

   {if ParName = 'EnerTsRasx' then ParValue := DVLSEx(glEnergRasx[4], glKoef);
   if ParName = 'EnergTsTtl' then ParValue := glSum;
   if ParName = 'EnerTsSub'  then ParValue := DVLSEx(glEnergRazn[4], glKoef);
   if ParName = 'EnerTsME'   then ParValue := DVLSEx(glEnergME[4], glKoef);}

  // glKoef
   if ParName = 'EnerT1MB'   then ParValue := RVLPr(glEnergMB[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2MB'   then ParValue := RVLPr(glEnergMB[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3MB'   then ParValue := RVLPr(glEnergMB[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsMB'   then ParValue := RVLPr(glEnergMB[4], MeterPrecision[m_ID]);
   if ParName = 'EnerT1ME'   then ParValue := RVLPr(glEnergME[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2ME'   then ParValue := RVLPr(glEnergME[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3ME'   then ParValue := RVLPr(glEnergME[3], MeterPrecision[m_ID]);

   if ParName = 'EnerT1Sub'  then ParValue := RVLPr(glEnergRazn[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2Sub'  then ParValue := RVLPr(glEnergRazn[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3Sub'  then ParValue := RVLPr(glEnergRazn[3], MeterPrecision[m_ID]);

   if ParName = 'KoefT1'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefT2'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefT3'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefTs'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'EnerT1Rasx' then ParValue := RVLPr(glEnergRasx[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2Rasx' then ParValue := RVLPr(glEnergRasx[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3Rasx' then ParValue := RVLPr(glEnergRasx[3], MeterPrecision[m_ID]);
   if ParName = 'FirstSign'  then ParValue := FirstSign;
   if ParName = 'SecondSign' then ParValue := SecondSign;
   if ParName = 'ThirdSign'   then ParValue := ThirdSign;
   if ParName = 'NDogovor'   then ParValue := NDogovor;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
end;

end.
