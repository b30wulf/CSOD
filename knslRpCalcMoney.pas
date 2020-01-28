unit knslRpCalcMoney;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, utlbox,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  FR_E_RTF, FR_E_HTM, FR_E_CSV;

type
  TrpCalcMoney = class(TForm)
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
  private
    { Private declarations }
    globalTtlMainName : string;
    globalTblName     : string;
    globalTblDate     : string[15];
    globalTblTName    : array [0..3] of string;
    globalTblKoef     : array [0..4] of string[20];
    globalTblEnerg    : array [0..4] of string[20];
    globalTblMoney    : array [0..4] of string[20];
    globalTblEnergTtl : array [0..4] of string[20];
    globalTblMoneyTtl : array [0..4] of string[20];
    SumEnerg          : array [0..4] of single;
    PrirDay           : array of single;
    IsData            : array of boolean;
    VMeters           : SL3GROUPTAG;
    m_pGrData         : L3GRAPHDATAS;
    m_pTariffs        : TM_TARIFFS;
    FTID              : integer;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    maxDate           : TDateTime;
    maxParam          : single;
    SrezNumb          : byte;
    FABOID            : Integer;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure ReadArch();
    procedure ReadArchAbonent();
    procedure FillReport(Date : TDateTime);
    procedure FillTotal;
    function  DateOutSec(Date : TDateTime) : string;
    procedure CreateTariffsNames();
    function  CalcCountTariffs() : byte;
  public
    { Public declarations }
    DateBeg           : TDateTime;
    DateEnd           : TDateTime;
    IsRPGroup         : boolean;
    KindEnergy        : integer;
    ItemInd           : integer;
    WorksName         : string;
    FirstSign         : string;
    ThirdSign         : string;
    SecondSign        : string;
    NDogovor          : string;
    NameObject        : string;
    Adress            : string;
   
    
    KoefTar           : single;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    function  DeleteSpaces(str :string) : string;
    procedure PrepareTable;
    procedure PrepareTableSub;
    procedure PrintPreview(Date1, Date2 : TDateTime; ItemIndMaxCtrl:Integer);
    procedure InitArrays();
  public
    property PABOID      :Integer          read FABOID       write FABOID;
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property TID         :integer          read FTID         write FTID;
  end;

var
  rpCalcMoney: TrpCalcMoney;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');

implementation

{$R *.DFM}

function  TrpCalcMoney.CalcCountTariffs() : byte;
var i : word;
begin
  if m_pTariffs.Count = 0 then exit;
  Result := m_pTariffs.Items[0].m_swTID;
  for i := 1 to m_pTariffs.Count - 1 do
    if m_pTariffs.Items[i].m_swTID > Result then
      Result := m_pTariffs.Items[i].m_swTID;
end;

function TrpCalcMoney.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TrpCalcMoney.CreateTariffsNames();
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
      globalTblTName[i] := 'Тариф не определен';
end;

function  TrpCalcMoney.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

function TrpCalcMoney.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TrpCalcMoney.PrepareTable;
var Groups    : SL3INITTAG;
    i, j      : integer;
    NumberTar : byte;
begin
   if FsgGrid=Nil then
     exit;
   FDB.GetTMTarPeriodsTable(-1, FTID + KindEnergy, m_pTariffs);
   NumberTar := CalcCountTariffs;
   FsgGrid.ColCount   := 3 + NumberTar;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование группы';
   for i := 0 to m_pTariffs.Count - 1 do
     FsgGrid.Cells[2 + m_pTariffs.Items[i].m_swTID,0] :=  m_pTariffs.Items[i].m_sName;
   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);

   if not FDB.GetAbonGroupsTable(FABOID,Groups) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       FsgGrid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
       for j := 0 to m_pTariffs.Count - 1 do
         FsgGrid.Cells[2 + m_pTariffs.Items[j].m_swTID, i + 1] := DVLS(m_pTariffs.Items[j].m_sfKoeff);
     end;
   end;
   OnFormResize;
end;

procedure TrpCalcMoney.PrepareTableSub;
var Meters   : SL2TAGREPORTLIST;
    i, j     : integer;
    NumberTar: word;
begin
   if FsgGrid=Nil then exit;
   FDB.GetTMTarPeriodsTable(-1, FTID + KindEnergy, m_pTariffs);
   NumberTar := CalcCountTariffs;
   FsgGrid.ColCount   := 3 + NumberTar;
   FsgGrid.RowCount      := 60;
   FsgGrid.Cells[0,0]    := '№ п.п';
   FsgGrid.Cells[1,0]    := 'Наименование учета';
   for i := 0 to m_pTariffs.Count - 1 do
     FsgGrid.Cells[2 + m_pTariffs.Items[i].m_swTID,0] := m_pTariffs.Items[i].m_sName;

   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);
   if not FDB.GetMeterTableForReport(FABOID,-1, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       if Meters.m_sMeter[i].m_sbyType = MET_VZLJOT then
         continue;
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       for j := 0 to m_pTariffs.Count - 1 do
         FsgGrid.Cells[2 + m_pTariffs.Items[j].m_swTID, FsgGrid.RowCount] := DVLS(m_pTariffs.Items[j].m_sfKoeff);
     end;
   end;
   OnFormResize;
end;

procedure TrpCalcMoney.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TrpCalcMoney.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpCalcMoney.InitArrays();
var i                : integer;
    NumberOfDays     : integer;
    TempDate         : TDateTime;
begin
   TempDate     := DateBeg;
   NumberOfDays := cDateTimeR.DifDays(TempDate, DateEnd);
   SetLength(PrirDay, NumberOfDays*5);
   SetLength(IsData, NumberOfDays*5);
   for i := 0 to NumberOfDays*5 - 1 do
   begin
     PrirDay[i] := 0;
     IsData[i] := false;
   end;
   for i := 0 to 4 do
     SumEnerg[i] := 0;
   for i := 0 to m_pTariffs.Count - 1 do
     globalTblKoef[i] := FsgGrid.Cells[2 + m_pTariffs.Items[i].m_swTID, ItemInd];
end;

procedure TrpCalcMoney.PrintPreview(Date1, Date2 : TDateTime; ItemIndMaxCtrl:Integer);
begin
   //FsgGrid   := @pTable;
   maxParam    := -10000000000;
   DateBeg     := Date1;
   DateEnd     := Date2;
   ItemInd     := ItemIndMaxCtrl;
   FTID        := FDB.LoadTID(QRY_SRES_ENR_EP + KindEnergy);;
   if FsgGrid.RowCount > 1 then
   begin
     KoefTar     := StrToFloat(FsgGrid.Cells[2, ItemInd]);
     frReport1.ShowReport;
   end;
end;

procedure TrpCalcMoney.ReadArch();
var i, j, k          : word;
    Day              : integer;
    Index            : word;
    DateReads        : TDateTime;
    IsNothing        : boolean;
begin
   DateReads := DateBeg;
   IsNothing := true;
   try
   for i := 0 to VMeters.m_swAmVMeter - 1 do
   begin
     if not FDB.GetGraphDatas(DateEnd, DateBeg, VMeters.Item.Items[i].m_swVMID,
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
       continue
     else
     begin
       IsNothing := false;
       for k := 0 to m_pGrData.Count - 1 do
       begin
         Day := cDateTimeR.DifDays(DateBeg, m_pGrData.Items[k].m_sdtDate);
         Dec(Day);
         for j := 0 to 47 do
         begin
           if m_pGrData.Items[k].v[j] > maxParam then
           begin
             maxParam := m_pGrData.Items[k].v[j];
             maxDate  := m_pGrData.Items[k].m_sdtDate;
             SrezNumb := j;
           end;
           Index := GetColorFromTariffs(j, m_pTariffs);
           PrirDay[Day*5 + Index] := PrirDay[Day*5 + Index] + m_pGrData.Items[k].v[j];
           IsData[Day*5 + Index]  := true;
           //PrirDay[Day*5]         := PrirDay[Day*5] + m_pGrData.Items[k].v[j];
           SumEnerg[Index]        := SumEnerg[Index] + m_pGrData.Items[k].v[j];
         end;
       end;
     end;
   end;
   except
     InitArrays;
   end;
end;

procedure TrpCalcMoney.ReadArchAbonent();
var j, k             : word;
    Day              : integer;
    Index            : word;
begin
   if FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, ItemInd]),
                           QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
     for k := 0 to m_pGrData.Count - 1 do
     begin
       Day := cDateTimeR.DifDays(DateBeg, m_pGrData.Items[k].m_sdtDate);
       Dec(Day);
       for j := 0 to 47 do
       begin
         if m_pGrData.Items[k].v[j] > maxParam then
         begin
           maxParam := m_pGrData.Items[k].v[j];
           maxDate  := m_pGrData.Items[k].m_sdtDate;
           SrezNumb := j;
         end;
         Index := GetColorFromTariffs(j, m_pTariffs);
         PrirDay[Day*5 + Index]  := PrirDay[Day*5 + Index] + m_pGrData.Items[k].v[j];
         IsData[Day*5 + Index]   := true;
         //PrirDay[Day*5]          := PrirDay[Day*5] + m_pGrData.Items[k].v[j];
         SumEnerg[Index]         := SumEnerg[Index] + m_pGrData.Items[k].v[j]
       end;
     end;
end;

procedure TrpCalcMoney.FillReport(Date : TDateTime);
var i                : byte;
    Year, Month, Day : word;
    sm               : integer;
begin
   sm := cDateTimeR.DifDays(DateBeg, Date);
   sm := sm - 1;
   globalTblDate := DateToStr(Date);
   for i := 1 to 4 do
   begin
     if not IsData[sm*5 + i] then
     begin
       globalTblEnerg[i] := 'Н/Д';
       globalTblMoney[i] := 'Н/Д';
       continue;
     end;
     {globalTblEnerg[i] := DVLS(PrirDay[sm*5 + i]);
     globalTblMoney[i] := DVLS(PrirDay[sm*5 + i]*m_pTariffs.Items[i].m_sfKoeff);  }
     PrirDay[sm]       := PrirDay[sm] + PrirDay[sm*5 + i];
   end;
   {globalTblEnerg[0] := DVLS(PrirDay[sm]);
   globalTblMoney[0] := DVLS(PrirDay[sm]*m_pTariffs.Items[0].m_sfKoeff);  }
end;

procedure TrpCalcMoney.FillTotal();
var i : integer;
begin
   for i := 1 to 4 do
   begin
     globalTblEnergTtl[i] := DVLS(SumEnerg[i]);
     if i < FsgGrid.ColCount - 2 then
       globalTblMoneyTtl[i] := DVLS(SumEnerg[i]*StrToFloat(FsgGrid.Cells[3, ItemInd]))
     else
       globalTblMoneyTtl[i] := '0.00';
     SumEnerg[0] := SumEnerg[0] + SumEnerg[i];
   end;
   globalTblEnergTtl[0] := DVLS(SumEnerg[0]);
   globalTblMoneyTtl[0] := DVLS(SumEnerg[0]*StrToFloat(FsgGrid.Cells[3, ItemInd]));

end;

procedure TrpCalcMoney.frReport1ManualBuild(Page: TfrPage);
var i                : integer;
    TempDate         : TDateTime;
begin
   TempDate := DateBeg;
   maxDate  := Now;
   SrezNumb := 0;
   maxParam := 0;
   globalTtlMainName := 'Расчет расхода энергии от ' + DateToStr(DateBeg) + ' до ' + DateToStr(DateEnd);
   if IsRPGroup then
   begin
     globalTblName  := 'Отчетная группа: ' + FsgGrid.Cells[1, ItemInd];
     FDB.GetTMTarPeriodsTableGr(StrToInt(FsgGrid.Cells[0, ItemInd]), FTID{ + KindEnergy}, m_pTariffs);
   end
   else
   begin
     globalTblName  := 'Отчетный субабонент: ' + FsgGrid.Cells[1, ItemInd];
     FDB.GetTMTarPeriodsTable(StrToInt(FsgGrid.Cells[0, ItemInd]), FTID{ + KindEnergy}, m_pTariffs);
   end;
   CreateTariffsNames;
   InitArrays;
   Page.ShowBandByType(btReportTitle);
   if IsRPGroup then
   begin
     if FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters) then
       ReadArch();
   end
   else
     ReadArchAbonent();
   while cDateTimeR.CompareDay(TempDate, DateEnd) <> 1 do
   begin
     FillReport(TempDate);
     {Page.ShowBandByName('MasterData1'); }
     cDateTimeR.IncDate(TempDate);
   end;
   FillTotal;
   Page.SHowBandByName('MasterData2');
   Page.ShowBandByName('MasterHeader1');
   Page.SHowBandByName('MasterHeader2');
   Page.ShowBandByName('PageFooter1');
   //FsgGrid := nil;
end;

procedure TrpCalcMoney.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'NDogovor'       then begin ParValue := NDogovor; exit; end;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;
   if ParName = 'WorksName'      then begin ParValue := WorksName; exit; end;
   if ParName = 'TtlMainName'    then begin ParValue := globalTtlMainName; exit; end;
   if ParName = 'TtlNameTbl'     then begin ParValue := globalTblName; exit; end;
   if ParName = 'KindEnergy'     then begin ParValue := strEnergy[KindEnergy]; exit; end;
   if ParName = 'TblT1Name'      then begin ParValue := globalTblTName[0]; exit; end;
   if ParName = 'TblT2Name'      then begin ParValue := globalTblTName[1]; exit; end;
   if ParName = 'TblT3Name'      then begin ParValue := globalTblTName[2]; exit; end;
   if ParName = 'TblT4Name'      then begin ParValue := globalTblTName[3]; exit; end;
   if ParName = 'TblDate'        then begin ParValue := globalTblDate; exit; end;
   if ParName = 'TblKoefSum'     then begin ParValue := globalTblKoef[0]; exit; end;
   if ParName = 'TblEnergSum'    then begin ParValue := globalTblEnerg[0]; exit; end;
   if ParName = 'TblMoneySum'    then begin ParValue := globalTblMoney[0]; exit; end;
   if ParName = 'TblKoefT1'      then begin ParValue := globalTblKoef[1]; exit; end;
   if ParName = 'TblEnergT1'     then begin ParValue := globalTblEnerg[1]; exit; end;
   if ParName = 'TblMoneyT1'     then begin ParValue := globalTblMoney[1]; exit; end;
   if ParName = 'TblKoefT2'      then begin ParValue := globalTblKoef[2]; exit; end;
   if ParName = 'TblEnergT2'     then begin ParValue := globalTblEnerg[2]; exit; end;
   if ParName = 'TblMoneyT2'     then begin ParValue := globalTblMoney[2]; exit; end;
   if ParName = 'TblKoefT3'      then begin ParValue := globalTblKoef[3]; exit; end;
   if ParName = 'TblEnergT3'     then begin ParValue := globalTblEnerg[3]; exit; end;
   if ParName = 'TblMoneyT3'     then begin ParValue := globalTblMoney[3]; exit; end;
   if ParName = 'TblKoefT4'      then begin ParValue := globalTblKoef[4]; exit; end;
   if ParName = 'TblEnergT4'     then begin ParValue := globalTblEnerg[4]; exit; end;
   if ParName = 'TblMoneyT4'     then begin ParValue := globalTblMoney[4]; exit; end;
   if ParName = 'TblKoefSumTtl'  then begin ParValue := globalTblKoef[0]; exit; end;
   if ParName = 'TblEnergSumTtl' then begin ParValue := globalTblEnergTtl[0]; exit; end;
   if ParName = 'TblMoneySumTtl' then begin ParValue := globalTblMoneyTtl[0]; exit; end;
   if ParName = 'TblKoefT1Ttl'   then begin ParValue := globalTblKoef[1]; exit; end;
   if ParName = 'TblEnergT1Ttl'  then begin ParValue := globalTblEnergTtl[1]; exit; end;
   if ParName = 'TblMoneyT1Ttl'  then begin ParValue := globalTblMoneyTtl[1]; exit; end;
   if ParName = 'TblKoefT2Ttl'   then begin ParValue := globalTblKoef[2]; exit; end;
   if ParName = 'TblEnergT2Ttl'  then begin ParValue := globalTblEnergTtl[2]; exit; end;
   if ParName = 'TblMoneyT2Ttl'  then begin ParValue := globalTblMoneyTtl[2]; exit; end;
   if ParName = 'TblKoefT3Ttl'   then begin ParValue := globalTblKoef[3]; exit; end;
   if ParName = 'TblEnergT3Ttl'  then begin ParValue := globalTblEnergTtl[3]; exit; end;
   if ParName = 'TblMoneyT3Ttl'  then begin ParValue := globalTblMoneyTtl[3]; exit; end;
   if ParName = 'TblKoefT4Ttl'   then begin ParValue := globalTblKoef[4]; exit; end;
   if ParName = 'TblEnergT4Ttl'  then begin ParValue := globalTblEnergTtl[4]; exit; end;
   if ParName = 'TblMoneyT4Ttl'  then begin ParValue := globalTblMoneyTtl[4]; exit; end;
   if ParName = 'FirstSign'      then begin ParValue := FirstSign; exit; end;
   if ParName = 'ThirdSign'      then begin ParValue := ThirdSign;exit;end;
   if ParName = 'SecondSign'     then begin ParValue := SecondSign; exit; end;
   if ParName = 'DateMax'        then begin ParValue := DateToStr(maxDate); exit; end;
   if ParName = 'KoefMax'        then begin ParValue := DVLS(m_pTariffs.Items[0].m_sfKoeff); exit; end;
   if ParName = 'EnergMax'       then begin ParValue := DVLS(maxParam); exit; end;
   if ParName = 'MoneyMax'       then begin ParValue := DVLS(maxParam*m_pTariffs.Items[0].m_sfKoeff); exit; end;
   if ParName = 'TimeMax'        then
   begin
     if SrezNumb mod 2 = 0 then
       ParValue := IntToStr(SrezNumb div 2) + ':' + '00' + ' - ' + IntToStr((SrezNumb + 1) div 2) +
                   ':' + IntToStr(((SrezNumb + 1) mod 2)*30)
     else
       ParValue := IntToStr(SrezNumb div 2) +  ':' + IntToStr((SrezNumb mod 2)*30) +
                   ' - ' + IntToStr((SrezNumb + 1) div 2) + ':' + '00';
   end;
end;

end.
