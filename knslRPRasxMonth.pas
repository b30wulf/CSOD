unit knslRPRasxMonth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TrpRasxMonth = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1BeginPage(pgNo: Integer);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    IsUsePokNow       : boolean;
    m_ID              : integer;
    glKoef            : extended;
    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergRazn       : array [1..4] of extended;
    glEnergRasx       : array [1..4] of extended;
    glMB              : string[15];
    glME              : string[15];
    glKindEn          : string;
    globalTitle       : string;
    globalMeterName   : string;
    MeterN            : string;
    glSum             : array [1..4] of string;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    DateReport        : TDateTime;
    SumEnergy         : array [0..3,1..4] of extended;
    glTable1Name      : string;
    AllMeter          : string;
    IsLastPage        : boolean;
    Fm_nEVL            : CEvaluator;
    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    Meters            : SL2TAGREPORTLIST;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure FillReport(MID : integer; var Page :TfrPage);
    procedure FillReportTtl(KindEN : byte; var Page : TfrPage);
    function  Replace(Str, X, Y: string): string;
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign   : string;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    IsReadZerT  : boolean;
    bEnergMask  : byte;
    //SumEnergy
    procedure PrintPreview(Date : TDateTime);
    procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property Pm_nEVL      :CEvaluator        read fm_nEVL          write fm_nEVL;
  end;

var
  rpRasxMonth: TrpRasxMonth;
const                   
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');
  IndEn       : array [0..3] of string = ('Активная потребляемая(кВт*ч)',
                                          'Активная отдаваемая(кВт*ч)',
                                          'Реактивная потребляемая(кВар*ч)',
                                          'Реактивная отдаваемая(кВар*ч)');

implementation

{$R *.DFM}

procedure TrpRasxMonth.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TrpRasxMonth.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpRasxMonth.PrepareTable;
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

procedure TrpRasxMonth.PrintPreview(Date : TDateTime);
begin
   DateReport   := Date;
   glTable1Name := 'Таблица 1';
   if FsgGrid.RowCount > 1 then
     frReport1.ShowReport;
end;

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}

function TrpRasxMonth.Replace(Str, X, Y: string): string;
var
  buf1, buf2, buffer: string;
  i: Integer;

begin
  buf1 := '';
  buf2 := Str;
  Buffer := Str;

  while Pos(X, buf2) > 0 do
  begin
    buf2 := Copy(buf2, Pos(X, buf2), (Length(buf2) - Pos(X, buf2)) + 1);
    buf1 := Copy(Buffer, 1, Length(Buffer) - Length(buf2)) + Y;
    Delete(buf2, Pos(X, buf2), Length(X));
    Buffer := buf1 + buf2;
  end;

  Replace := Buffer;
end;

procedure TrpRasxMonth.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
var
 stReplace : string;
 i:byte;
begin
 stReplace := 'v'+mid + '_P';
 if tarif <> 6 then
 begin
   sExpr1[KindEn][tarif] := replace(sExpr1[KindEn][tarif],stReplace,FloatTostr(abs(SumFormula[KindEn][tarif])));
 end
 else
 begin
 for i :=1 to 4 do
   sExpr1[KindEn][i] := replace(sExpr1[KindEn][i],stReplace,'0');
 end;
end;

procedure TrpRasxMonth.FillReport(MID : integer; var Page: TfrPage);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i : word;
    TempDate            : TDateTime;
    param               : extended;
    nTypeID,swPLID,nMaxT: Integer;
    nTypeEn,nTypeCEn,nMaxKind : Byte;
begin
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID];
   MeterN          := 'Счетчик. №' + FsgGrid.Cells[2, MID];
   AllMeter        :=  AllMeter + FsgGrid.Cells[1, MID] + ',';
   AllMeter := replace(AllMeter,'  ', '');
   m_ID            := StrToInt(FsgGrid.Cells[0, MID]);

    nMaxKind := 4;
    nMaxT  := 3;
    swPLID := 0;
    nTypeEn  := QRY_NAK_EN_MONTH_EP;
    nTypeCEn := QRY_ENERGY_SUM_EP;
    FDB.GetMeterType(m_ID,nTypeID,swPLID);
    if swPLID=1 then nMaxT:=2;
    if nTypeID=MET_PULCR then
    Begin
     nTypeEn  := QRY_RASH_MON_V;
     nTypeCEn := QRY_SUM_RASH_V;
     nMaxKind := 1;
    End;

   Page.ShowBandByName('MasterHeader1');
   TempDate := DateReport;
   for KindEn := 0 to nMaxKind-1 do
   begin
     if not IsBitInMask(bEnergMask, KindEn) then
       continue;
     glKindEn := strEnergy[KindEn];
     if nTypeID=MET_PULCR then glKindEn := 'Вид энергии : Расход жидкости(м.куб)';
     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);
     TempDate := DateReport;
     cDateTimeR.IncMonth(TempDate);
     for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergME[i]   := 0;
       glEnergRazn[i] := 0;
       glEnergRasx[i] := 0;
     end;

     if not IsUsePokNow then
     begin
       if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                           nTypeEn + KindEn, 0, Data) then
       begin
         FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
         Page.ShowBandByName('MasterData1');
         continue;
       end;
     end
     else
     begin
       if not FDB.GetCurrentDataInCCDatas(StrToInt(FsgGrid.Cells[0, MID]),
                                 nTypeCEn + KindEn, Data) then
       begin
         FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
         Page.ShowBandByName('MasterData1');
         continue;
       end
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergME[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
         if (IsReadZerT){ or (swPLID=1)} then                      //Суммирование по тарифам
           glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
       end else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
           glEnergME[4] :=  RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
     cDateTimeR.DecMonth(TempDate);
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         nTypeEn + KindEn, 0, Data) then
     begin
       FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
       Page.ShowBandByName('MasterData1');
       continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
         if (IsReadZerT){ or (swPLID=1)} then
           glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end
       else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
           glEnergMB[4] := RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
     for i := 1 to 4 do
     begin
       glEnergRazn[i] := glEnergME[i] - glEnergMB[i];
       glEnergRasx[i] := RVLPr(glEnergRazn[i], MeterPrecision[m_ID])*glKoef;
       SumEnergy[KindEn][i] := SumEnergy[KindEn][i] + glEnergRasx[i];
       SumFormula[KindEn][i] := glEnergRasx[i];
       FindValueFormula(i,KindEn,FsgGrid.Cells[0, MID]);
     end;
     Page.ShowBandByName('MasterData1');
   end;
end;

procedure TrpRasxMonth.FillReportTtl(KindEN : byte; var Page : TfrPage);
var i : byte;
begin
  //if GroupID=-1 then Begin Page.ShowBandByName('MasterData2');exit; End;
   glKindEn := IndEn[KindEn];
  for i := 1 to 4 do
   begin
   if  not((sExpr='[x]')or(sExpr='')) then
   begin
       fm_nEVL.Expression :=  sExpr1[KindEn][i];  //формула
       if fm_nEVL.Value < 0 then glSum[i] := 'Н/Д' else
       glSum[i] := FloatToStr(RVLPr(fm_nEVL.Value, MaxPrecision));
   end
   else
   if SumEnergy[KindEn][i] < 0 then glSum[i] := 'Н/Д' else
   glSum[i] := FloatToStr(RVLPr(SumEnergy[KindEn][i], MaxPrecision));  {glSum[i] := DVLS(SumEnergy[KindEn][i]);}
   end;
   Page.ShowBandByName('MasterData2');
end;

procedure TrpRasxMonth.frReport1ManualBuild(Page: TfrPage);
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT : SL3GROUPTAG;
begin
 ////инициализация //формулы
 sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
 if GroupID=-1 then //Meters : SL2TAGREPORTLIST;
 Begin
  sExpr := '';
  sExpr := 'v'+FsgGrid.Cells[0, 1]+'_P';
  for i := 2 to FsgGrid.RowCount - 1 do
  sExpr :=sExpr + ' + v'+FsgGrid.Cells[0, i]+'_P';
 End;
 fm_nEVL.Expression := sExpr;
 for i:=1 to 4 do
    for j:=0 to 3 do
       sExpr1[j][i] := sExpr;
 //////////////
   AllMeter :='';
   IsLastPage := false;
   for i := 0 to 3 do
     for j := 1 to 4 do
       SumEnergy[i][j] := 0;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   //globalTitle := 'Отчет о фактическом потреблении электроэнергии в ' +
   //                  cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   globalTitle := 'Отчет о фактическом расходе в ' +
                     cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   cDateTimeR.IncDate(DateReport);
   glME := DateToStr(DateReport);
   cDateTimeR.DecMonth(DateReport);
   glMB := DateToStr(DateReport);
   IsUsePokNow := false;
   if cDateTimeR.IsDateInMonthNow(DateReport) then
   begin
     glME := DateToStr(Now);
     IsUsePokNow := true;
   end;
   Page.ShowBandByType(btReportTitle);
   for i := 1 to FsgGrid.RowCount - 1 do
     FillReport(i, Page);

   if GroupID <> -1 then
   begin
     IsLastPage := true;
     Page.NewPage;
     delete(AllMeter, length(AllMeter), 1);
     AllMeter := AllMeter + '.';
     Page.ShowBandByName('MasterHeader2');
     for i := 0 to 3 do
       if (IsBitInMask(bEnergMask, i)) then
         FillReportTtl(i, Page);
   end;
   Page.ShowBandByName('PageFooter1');
   //fm_nEVL.Free;
end;

procedure TrpRasxMonth.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'   then ParValue := WorksName;
   if ParName = 'TtlMainName' then ParValue := globalTitle;
   if ParName = 'DateTtlB' then ParValue := glMB;
   if ParName = 'DateTtlE'      then ParValue := glME;
   if ParName = 'MDNameCounter' then ParValue := globalMeterName;
   if ParName = 'MeterN'     then ParValue := MeterN;
   if ParName = 'KindEn'     then ParValue := glKindEn;
   if ParName = 'EnerT1MB'   then ParValue := RVLPr(glEnergMB[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2MB'   then ParValue := RVLPr(glEnergMB[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3MB'   then ParValue := RVLPr(glEnergMB[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsMB'   then ParValue := RVLPr(glEnergMB[4], MeterPrecision[m_ID]);
   if ParName = 'EnerT1ME'   then ParValue := RVLPr(glEnergME[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2ME'   then ParValue := RVLPr(glEnergME[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3ME'   then ParValue := RVLPr(glEnergME[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsME'   then ParValue := RVLPr(glEnergME[4], MeterPrecision[m_ID]);
   if ParName = 'EnerT1Sub'  then ParValue := RVLPr(glEnergRazn[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2Sub'  then ParValue := RVLPr(glEnergRazn[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3Sub'  then ParValue := RVLPr(glEnergRazn[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsSub'  then ParValue := RVLPr(glEnergRazn[4], MeterPrecision[m_ID]);
   if ParName = 'KoefT1'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefT2'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefT3'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'KoefTs'     then ParValue := DVLSEx(glKoef, glKoef);
   if ParName = 'EnerT1Rasx' then ParValue := RVLPr(glEnergRasx[1], MeterPrecision[m_ID]);
   if ParName = 'EnerT2Rasx' then ParValue := RVLPr(glEnergRasx[2], MeterPrecision[m_ID]);
   if ParName = 'EnerT3Rasx' then ParValue := RVLPr(glEnergRasx[3], MeterPrecision[m_ID]);
   if ParName = 'EnerTsRasx' then ParValue := RVLPr(glEnergRasx[4], MeterPrecision[m_ID]);
   if ParName = 'KindEnTtl'  then ParValue := glKindEn;
   if ParName = 'EnergT1Ttl' then ParValue := glSum[1];
   if ParName = 'EnergT2Ttl' then ParValue := glSum[2];
   if ParName = 'EnergT3Ttl' then ParValue := glSum[3];
   if ParName = 'EnergTsTtl' then ParValue := glSum[4];
   if ParName = 'FirstSign'  then ParValue := FirstSign;
   if ParName = 'ThirdSign'  then ParValue := ThirdSign;
   if ParName = 'SecondSign' then ParValue := SecondSign;
   if ParName = 'NDogovor'   then ParValue := NDogovor;
   if ParName = 'm_strObjCode' then ParValue := m_strObjCode;
   if ParName = 'NameObject' then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'     then begin ParValue := Adress; exit; end;
   if ParName = 'Tbl1Name'   then ParValue := glTable1Name;
   if ParName = 'AllMeter'   then ParValue := AllMeter;
end;

procedure TrpRasxMonth.frReport1BeginPage(pgNo: Integer);
begin
   if pgNo > 0 then
     glTable1Name := 'Таблица 1(Продолжение)';
end;

procedure TrpRasxMonth.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
   if IsLastPage then
     if (View.Name = 'Memo2') or (View.Name = 'Memo3') or (View.Name = 'Memo4') or
         (View.Name = 'Memo5') or (View.Name = 'Memo6') or (View.Name = 'Memo7') or
         (View.Name = 'Memo9') or (View.Name = 'Memo47') then
       View.Visible := false;
end;

end.
