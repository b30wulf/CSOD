unit knsRPMaxDayFact;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, BaseGrid, AdvGrid, utltypes, utldatabase, utlTimeDate, utlconst,
  FR_Desgn, utlbox, FR_E_CSV,utlexparcer;

type
  TrpMaxDayFact = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReportMaxDManualBuild(Page: TfrPage);
    procedure frReportMaxDGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReportMaxDEnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    FsgGrid           : PTAdvStringGrid;
    DateReport        : TDateTime;
    m_pTariffs        : TM_TARIFFS;
    FTID              : Integer;
    m_pGrData         : L3GRAPHDATAS;
    VMeters           : SL3GROUPTAG;
    globalTtlMainName : string;
    globalTtlNameTbl  : string;
    globalTblTName    : array [0..3] of string;
    globalTblDate     : string[15];
    globalTblPolInf   : string[10];
    globalTblBegSlT   : array [0..3] of string[10];
    globalTblEndSlT   : array [0..3] of string[10];
    globalTblMaxSlT   : array [0..3] of string[15];
    globalTblMaxSlDay : string[15];
    globalTblMaxT     : array [0..3] of string[15];
    globalTblMax      : string[15];
    singTblMaxSlT     : array [0..3] of single;
    IsInitTar         : array [0..3,0..31] of boolean;
    maxArray          : array [0..3,0..31] of single;
    MaxInd            : array [0..3,0..31] of byte;
    ArraySumSlice     : array [0..31,0..47] of single;
    FillColorMaxDay   : array [0..3] of TColor;
    singTblMaxSl      : single;
    ItemInd           : Integer;
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
    Fm_nEVL           : CEvaluator;
    GroupID           : integer;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FindMax(Date : TDateTime);
    procedure FindMaxDay(Date : TDateTime);
    procedure ReadSlicesMetrolog(Date : TDateTime);
    procedure FillReport(Date : TDateTime);
    procedure FillNull(Date : TDateTime);
    procedure CreateTariffsNames();
    function DateOutSec(Date : TDateTime) : string;
  public
    { Public declarations }
    IsRPGroup   : byte;
    KindEnergy  : byte;
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign         : string;
    ColorsRep   : array [0..2] of TColor;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    procedure OnFormResize;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
    property Pm_nEVL     :CEvaluator       read fm_nEVL      write fm_nEVL;
    property prGroupID   :integer          read GroupID      write GroupID;
  end;

var
  rpMaxDayFact: TrpMaxDayFact;

const
  strEnergy   : array [0..3] of string = ('¬ид мощности : јктивна€ принимаема€(к¬т)',
                                          '¬ид мощности : јктивна€ отдаваема€(к¬т)',
                                          '¬ид мощности : –еактивна€ принимаема€(к¬ар)',
                                          '¬ид мощности : –еактивна€ отдаваема€(к¬ар)');
  strEK       : array [0..3] of string = ('к¬т',
                                          'к¬т',
                                          'к¬ар',
                                          'к¬ар');


implementation

{$R *.DFM}

function TrpMaxDayFact.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TrpMaxDayFact.CreateTariffsNames();
var i : integer;
begin
  for i := 0 to 3 do
  begin
    globalTblTName[i] := '';
  end;
  for i := 1 to m_pTariffs.Count - 1 do
  begin
    if globalTblTName[m_pTariffs.Items[i].m_swTID-1] = '' then
      globalTblTName[m_pTariffs.Items[i].m_swTID-1] := m_pTariffs.Items[i].m_sName + '('
        + DateOutSec(m_pTariffs.Items[i].m_dtTime0) + ' - ' + DateOutSec(m_pTariffs.Items[i].m_dtTime1)
    else
      globalTblTName[m_pTariffs.Items[i].m_swTID-1] := globalTblTName[m_pTariffs.Items[i].m_swTID-1] + '; '
        + DateOutSec(m_pTariffs.Items[i].m_dtTime0) + ' - ' + DateOutSec(m_pTariffs.Items[i].m_dtTime1);
  end;
  for i := 0 to 3 do
    if globalTblTName[i] <> '' then
      globalTblTName[i] := globalTblTName[i] + ')'
    else
      globalTblTName[i] := '“ариф не определен';
end;

function TrpMaxDayFact.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
var SumS                         : word;
    Hour0, Min0, Sec0, ms0, Sum0 : word;
    Hour1, Min1, Sec1, ms1, Sum1 : word;
    i                            : byte;
begin
    Result := 0;
    SumS   := 30 * Srez;
    for i := 1 to pTable.Count - 1 do
    begin
      DecodeTime(pTable.Items[i].m_dtTime0, Hour0, Min0, Sec0, ms0);
      DecodeTime(pTable.Items[i].m_dtTime1, Hour1, Min1, Sec1, ms1);
      Sum0 := Hour0*60 + Min0;
      Sum1 := Hour1*60 + Min1;
      if Hour0 < Hour1 then
      begin
        if (SumS >= Sum0) and (SumS < Sum1) then
          Result := pTable.Items[i].m_swTID;
      end
      else
      begin
        if SumS >= Sum0 then
          Result := pTable.Items[i].m_swTID;
        if SumS < Sum1 then
          Result := pTable.Items[i].m_swTID;
      end;
    end;
end;

procedure TrpMaxDayFact.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TrpMaxDayFact.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpMaxDayFact.PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
begin
   DateReport  := Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   FTID        := 10;
   frReport1.ShowReport;
end;

procedure TrpMaxDayFact.frReportMaxDEnterRect(Memo: TStringList;
  View: TfrView);
begin
   if View.Name = 'Memo33' then
     View.FillColor := FillColorMaxDay[0];
   if View.Name = 'Memo36' then
     View.FillColor := FillColorMaxDay[1];
   if View.Name = 'Memo39' then
     View.FillColor := FillColorMaxDay[2];
   if View.Name = 'Memo42' then
     View.FillColor := FillColorMaxDay[3];
   if View.Name = 'Memo43' then
     View.FillColor := ColorsRep[1];
   if View.Name = 'Memo50' then
     View.FillColor := ColorsRep[2];
   if View.Name = 'Memo51' then
     View.FillColor := ColorsRep[2];
   if View.Name = 'Memo52' then
     View.FillColor := ColorsRep[2];
   if View.Name = 'Memo53' then
     View.FillColor := ColorsRep[2];
   if View.Name = 'Memo54' then
     View.FillColor := ColorsRep[2];

end;

procedure TrpMaxDayFact.frReportMaxDGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'TtlMaxPower' then ParValue := DVLS(singTblMaxSl) + ' ' + strEK[KindEnergy];
   if ParName = 'NDogovor'    then ParValue := NDogovor;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;
   if ParName = 'WorksName'   then ParValue := WorksName;
   if ParName = 'FirstSign'   then ParValue := FirstSign;
   if ParName = 'ThirdSign'   then ParValue := ThirdSign;
   if ParName = 'SecondSign'  then ParValue := SecondSign;
   if ParName = 'TtlMainName' then ParValue := globalTtlMainName;
   if ParName = 'TtlNameTbl'  then ParValue := globalTtlNameTbl;
   if ParName = 'TblT1Name'   then ParValue := globalTblTName[0];
   if ParName = 'TblT2Name'   then ParValue := globalTblTName[1];
   if ParName = 'TblT3Name'   then ParValue := globalTblTName[2];
   if ParName = 'TblT4Name'   then ParValue := globalTblTName[3];
   if ParName = 'TblDate'     then ParValue := globalTblDate;
   if ParName = 'TblPolInf'   then ParValue := globalTblPolInf;
   if ParName = 'TblBegSlT1'  then ParValue := globalTblBegSlT[0];
   if ParName = 'TblEndSlT1'  then ParValue := globalTblEndSlT[0];
   if ParName = 'TblMaxSlT1'  then ParValue := globalTblMaxSlT[0];
   if ParName = 'TblBegSlT2'  then ParValue := globalTblBegSlT[1];
   if ParName = 'TblEndSlT2'  then ParValue := globalTblEndSlT[1];
   if ParName = 'TblMaxSlT2'  then ParValue := globalTblMaxSlT[1];
   if ParName = 'TblBegSlT3'  then ParValue := globalTblBegSlT[2];
   if ParName = 'TblEndSlT3'  then ParValue := globalTblEndSlT[2];
   if ParName = 'TblMaxSlT3'  then ParValue := globalTblMaxSlT[2];
   if ParName = 'TblBegSlT4'  then ParValue := globalTblBegSlT[3];
   if ParName = 'TblEndSlT4'  then ParValue := globalTblEndSlT[3];
   if ParName = 'TblMaxSlT4'  then ParValue := globalTblMaxSlT[3];
   if ParName = 'TblMaxSlDay' then ParValue := globalTblMaxSlDay;
   if ParName = 'TblMaxT1'    then ParValue := DVLS(maxArray[0][31]);
   if ParName = 'TblMaxT2'    then ParValue := DVLS(maxArray[1][31]);
   if ParName = 'TblMaxT3'    then ParValue := DVLS(maxArray[2][31]);
   if ParName = 'TblMaxT4'    then ParValue := DVLS(maxArray[3][31]);
   if ParName = 'TblMaxDay'   then ParValue := DVLS(singTblMaxSl);
   if ParName = 'KindEnergy'  then Parvalue := strEnergy[KindEnergy];
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
   if ParName = 'Pmax1'        then ParValue := 'Pмакс(' + strEK[KindEnergy] + ')';
   if ParName = 'Pmax2'        then ParValue := 'Pмакс(' + strEK[KindEnergy] + ')';
   if ParName = 'Pmax3'        then ParValue := 'Pмакс(' + strEK[KindEnergy] + ')';
   if ParName = 'Pmax4'        then ParValue := 'Pмакс(' + strEK[KindEnergy] + ')';
   if ParName = 'Pmax5'        then ParValue := 'ћаксимальна€ мощность за день (' + strEK[KindEnergy] + ')';
end;

procedure TrpMaxDayFact.FindMax(Date : TDateTime);
var i, j             : byte;
    Year, Month, Day : word;
begin
   DecodeDate(Date, Year, Month, Day);
   singTblMaxSl :=  maxArray[0][0];
   for i := 0 to 3 do
     for j := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
     begin
       maxArray[i][j] := maxArray[i][j] * 2;
       if maxArray[i][j] > singTblMaxSl then
         singTblMaxSl :=  maxArray[i][j];
       if not IsInitTar[i][31] then
       begin
         maxArray[i][31]  := maxArray[i][j];
         IsInitTar[i][31] := true;
         MaxInd[i][31]    := j;
       end;
       if maxArray[i][j] > maxArray[i][31] then
       begin
         maxArray[i][31] := maxArray[i][j];
         MaxInd[i][31]   := j;
       end;
     end;
end;

procedure TrpMaxDayFact.FindMaxDay(Date : TDateTime);
var Year, Month, Day : word;
    i                : byte;
    ColorInd         : word;
    param            : single;
begin
   DecodeDate(Date, Year, Month, Day);
   Day          := Day - 1;
   ColorInd     := 0;
   param        := maxArray[0, Day];
   for i := 0 to 3 do
     FillColorMaxDay[i] := ColorsRep[0];
   for i := 1 to 3 do
     if maxArray[i, Day] > param then
     begin
       param         := maxArray[i, Day];
       ColorInd      := i;
     end;
   FillColorMaxDay[ColorInd] := ColorsRep[1];
   globalTblMaxSlDay := DVLS(param);
end;

procedure TrpMaxDayFact.FillNull(Date : TDateTime);
var i : byte;
begin
   globalTblDate     := DateToStr(Date);
   globalTblPolInf   := '0%';
   globalTblMaxSlDay := DVLS(0);
   for i := 0 to 3 do
   begin
     globalTblBegSlT[i]   := '--:--';
     globalTblEndSlT[i]   := '--:--';
     globalTblMaxSlT[i]   := DVLS(0);
   end;
end;

procedure TrpMaxDayFact.ReadSlicesMetrolog(Date : TDateTime);
var
    i, j, k          : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
begin
   DecodeDate(Date, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   for i := 0 to VMeters.m_swAmVMeter - 1 do
   begin
     if not FDB.GetGraphDatas(DateEnd, DateBeg, VMeters.Item.Items[i].m_swVMID,
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
       continue
     else
       for k := 0 to m_pGrData.Count - 1 do
       begin
         DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
         Dec(Day);
         for j := 0 to 47 do
         begin
           ArraySumSlice[Day, j] := ArraySumSlice[Day, j] + m_pGrData.Items[k].v[j];
           Index := GetColorFromTariffs(j, m_pTariffs) - 1;
           IsInitTar[Index][Day] := true;
         end;
       end;
   end;
   for Day := 0 to cDateTimeR.DayPerMonth(Month, Year) do
     for j := 0 to 47 do
     begin
       Index := GetColorFromTariffs(j, m_pTariffs) - 1;
       if not IsInitTar[Index, Day] then
       begin
         maxArray[Index][Day]  := ArraySumSlice[Day,j];
         MaxInd[Index][Day]    := j;
       end;
       if ArraySumSlice[Day,j] > maxArray[Index][Day] then
       begin
         maxArray[Index][Day] := ArraySumSlice[Day,j];
         maxInd[Index][Day]   := j;
       end;
     end;
end;

procedure TrpMaxDayFact.FillReport(Date : TDateTime);
var Year, Month, Day : word;
    i                : byte;
begin
   FindMaxDay(Date);
   DecodeDate(Date, Year, Month, Day);
   Day := Day - 1;
   globalTblDate     := DateToStr(Date);
   if not((IsInitTar[0][Day]) or (IsInitTar[1][Day]) or (IsInitTar[2][Day]) or (IsInitTar[3][Day])) then
   begin     //≈сли тарифы не проиницилизированны
     FillNull(Date);
     exit;
   end;
   for i := 0 to 3 do
   begin
     globalTblBegSlT[i] := IntToStr(MaxInd[i, Day] div 2) + ':';
     if MaxInd[i, Day] mod 2 = 0 then
       globalTblBegSlT[i] := globalTblBegSlT[i] + '00'
     else
       globalTblBegSlT[i] := globalTblBegSlT[i] + '30';
     globalTblEndSlT[i] := IntToStr((MaxInd[i, Day] + 1) div 2) + ':';
     if (MaxInd[i, Day] + 1) mod 2 = 0 then
       globalTblEndSlT[i] := globalTblEndSlT[i] + '00'
     else
       globalTblEndSlT[i] := globalTblEndSlT[i] + '30';
     globalTblMaxSlT[i] := DVLS(maxArray[i][Day]);
     if maxInd[i][31] <> Day then
     begin
       if FillColorMaxDay[i] <> ColorsRep[1] then
         FillColorMaxDay[i] := ColorsRep[0];
     end
     else
       FillColorMaxDay[i] := ColorsRep[2];
   end;
end;

procedure TrpMaxDayFact.frReportMaxDManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i,j              : integer;
    TempDate         : TDateTime;
begin
   for i := 0 to 3 do
     for j := 0 to 31 do
     begin
       maxArray[i, j] := 0;
       IsInitTar[i, j] := false;
     end;
   FillChar(ArraySumSlice, sizeof(ArraySumSlice), 0);
   //FDB.GetTMTarPeriodsTable(-1, FTID{ + KindEnergy}, m_pTariffs);


   FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters);
   FDB.GetTMTarPeriodsCmdTable(DateReport,VMeters.Item.Items[0].m_swVMID,QRY_SRES_ENR_EP + KindEnergy,8,m_pTariffs);

   DecodeDate(DateReport, Year, Month, Day);
   globalTtlMainName := '—овмещенные максимумы мощности в ' + cDateTimeR.GetNameMonth(Month)
                         + ' ' + IntToStr(Year) + ' года' + ' в часы максимальных нагрузок энергосистемы ' +
                         DateOutSec(m_pTariffs.Items[5].m_dtTime0) + ' - ' + DateOutSec(m_pTariffs.Items[5].m_dtTime1) +
                         ' и ' +DateOutSec(m_pTariffs.Items[6].m_dtTime0) + ' - ' + DateOutSec(m_pTariffs.Items[6].m_dtTime1);
   if IsRPGroup = 0 then
     globalTtlNameTbl  := '”чет: ' + FsgGrid.Cells[1, ItemInd]
   else
     globalTtlNameTbl  := '”чет: ' + FsgGrid.Cells[1, ItemInd];
   //FDB.GetTMTarPeriodsTable(-1, FTID{ + KindEnergy}, m_pTariffs);
   FDB.GetTMTarPeriodsCmdTable(DateReport,VMeters.Item.Items[0].m_swVMID,QRY_SRES_ENR_EP + KindEnergy,8,m_pTariffs);
   CreateTariffsNames();

   Page.ShowBandByType({'PageHeader1'}btReportTitle);
   Day      := 1;
   TempDate := EncodeDate(Year, Month, Day);

   FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters);

   ReadSlicesMetrolog(DateReport);

   TempDate := EncodeDate(Year, Month, Day);
   FindMax(TempDate);
   while cDateTimeR.CompareMonth(TempDate, DateReport) = 0 do
   begin
     FillReport(TempDate);
     Page.ShowBandByName('MasterData1');
     cDateTimeR.IncDate(TempDate);
   end;

   Page.SHowBandByName('MasterData2');
   Page.ShowBandByName('PageFooter1');
   //FsgGrid := nil;
end;

end.
