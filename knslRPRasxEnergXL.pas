unit knslRPRasxEnergXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TrpRasxEnergXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
   private
    { Private declarations }
    VMeters           : SL3GROUPTAG;
    m_pGrData         : L3GRAPHDATAS;
    m_pTariffs        : TM_TARIFFS;
    FTID              : Integer;
    FsgGrid           : PTAdvStringGrid;
    DateReport        : TDateTime;
    ItemInd           : Integer;
    globalTtlMainName : string;
    globalTblName     : string;
    globalTblDate     : string[15];
    globalTblDosInf   : string[10];
    globalTblTName    : array [0..3] of string;
    globalTblDaySumT  : array [0..4] of string[15];
    PrirDay           : array [0..3,0..31] of extended;
    IsData            : array [0..3,0..31] of boolean;
    SumEnerg          : array [0..4] of extended;
    FDB               : PCDBDynamicConn;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    function  DeleteSpaces(str :string) : string;
    procedure ReadArch(TempDate : TDateTime);
    procedure ReadArchAbonent(TempDate : TDateTime);
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FillReport(Date : TDateTime);
    function  DateOutSec(Date : TDateTime) : string;
    procedure CreateTariffsNames();
    procedure ReadArchForEMS(TempDate : TDateTime; VMID : integer);
    procedure ReadArchForCE6822(TempDate : TDateTime; VMID : integer);
    procedure ShowData2;
    procedure ShowData;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure frReport1ManualBuild;
  public
    { Public declarations }
    IsRPGroup   : boolean;
    KindEnergy  : integer;
    WorksName   : string;
    FirstSign   : string;
    ThirdSign    : string;
    SecondSign  : string;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    procedure CreatReport(Date : TDateTime; ItemIndMaxCtrl:Integer);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpRasxEnergXL : TrpRasxEnergXL;
  //FsgGrid   : ^TAdvStringGrid;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная принимаемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная принимаемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');

implementation

constructor TrpRasxEnergXL.Create;
Begin

End;

destructor TrpRasxEnergXL.Destroy;
Begin
    inherited;
End;

procedure TrpRasxEnergXL.ReadArchForEMS(TempDate : TDateTime; VMID : integer);
var DataRazn            : CCDatas;
    i, j                : byte;
    Day, Month, Year    : word;
begin
  if not FDB.GetGData(TempDate, TempDate, VMID,
                      QRY_ENERGY_MON_EP + KindEnergy, 0, DataRazn) then
    exit;
  DecodeDate(TempDate, Year, Month, Day);
  for i := 0 to DataRazn.Count - 1 do
    DataRazn.Items[i].m_sfValue := DataRazn.Items[i].m_sfValue/cDateTimeR.DayPerMonth(Month, Year);
  for i := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
    for j := 0 to DataRazn.Count - 1 do
    begin
      if (DataRazn.Items[j].m_swTID = 0) or (DataRazn.Items[j].m_swTID = 4) then
        continue;
      PrirDay[j, i] := PrirDay[j, i] + DataRazn.Items[j].m_sfValue;
      IsData[j, i]  := true;
    end;
end;

procedure TrpRasxEnergXL.ReadArchForCE6822(TempDate : TDateTime; VMID : integer);
var DataRazn1, DataRazn2  : CCDatas;
    i, j                  : byte;
    Day, Month, Year      : word;
begin
  DecodeDate(TempDate, Year, Month, Day);
  if not FDB.GetGData(TempDate, TempDate, VMID,
                      QRY_NAK_EN_MONTH_EP + KindEnergy, 0, DataRazn1) then
    exit;
  for i := 0 to DataRazn1.Count - 1 do
    DataRazn1.Items[i].m_sfValue := DataRazn1.Items[i].m_sfValue/cDateTimeR.DayPerMonth(Month, Year);
  cDateTimeR.DecMonth(TempDate);
  if not FDB.GetGData(TempDate, TempDate, VMID,
                      QRY_NAK_EN_MONTH_EP + KindEnergy, 0, DataRazn2) then
    exit;
  for i := 0 to DataRazn2.Count - 1 do
    DataRazn2.Items[i].m_sfValue := DataRazn2.Items[i].m_sfValue/cDateTimeR.DayPerMonth(Month, Year);

  for i := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
    for j := 0 to DataRazn1.Count - 1 do
    begin
      if (DataRazn1.Items[j].m_swTID = 0) or  (DataRazn1.Items[j].m_swTID = 4)
          or (DataRazn2.Items[j].m_swTID = 0) or  (DataRazn2.Items[j].m_swTID = 4) then
          continue;
      PrirDay[j, i] := PrirDay[j, i] + DataRazn1.Items[j].m_sfValue - DataRazn2.Items[j].m_sfValue;
      IsData[j, i]  := true;
    end;
end;

function TrpRasxEnergXL.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TrpRasxEnergXL.CreateTariffsNames();
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

function  TrpRasxEnergXL.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

function TrpRasxEnergXL.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TrpRasxEnergXL.CreatReport(Date : TDateTime; ItemIndMaxCtrl:Integer);
begin
   Page := 1;
   DateReport  := Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   FTID        := FDB.LoadTID(QRY_SRES_ENR_EP + KindEnergy);;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\rpRasxEnerg.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 2;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Расход энергии';
   frReport1ManualBuild;
end;

procedure TrpRasxEnergXL.ReadArch(TempDate : TDateTime);
var i, j, k          : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
    fExt : Extended;
begin
   DecodeDate(TempDate, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   fExt := 0;
   for i := 0 to VMeters.m_swAmVMeter-1 do
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

           Index := GetColorFromTariffs(j, m_pTariffs) - 1;
           PrirDay[Index, Day] := PrirDay[Index, Day] + m_pGrData.Items[k].v[j];
            IsData[Index, Day]  := true;
         end;
       end;
   end;
   for i := 0 to VMeters.m_swAmVMeter-1 do
   begin
     if VMeters.Item.Items[i].m_sbyType = MET_EMS134 then
       ReadArchForEMS(TempDate, VMeters.Item.Items[i].m_swVMID);
     if VMeters.Item.Items[i].m_sbyType = MET_CE6822 then
       ReadArchForCE6822(TempDate, VMeters.Item.Items[i].m_swVMID);
   end;
end;

procedure TrpRasxEnergXL.ReadArchAbonent(TempDate : TDateTime);
var j, k          : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
begin
   DecodeDate(TempDate, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   if FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, ItemInd]),
                           QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
     for k := 0 to m_pGrData.Count - 1 do
     begin
       DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
       Dec(Day);
       for j := 0 to 47 do
       begin
         Index := GetColorFromTariffs(j, m_pTariffs) - 1;
         PrirDay[Index, Day] := PrirDay[Index, Day] + m_pGrData.Items[k].v[j];
         IsData[Index, Day]  := true;
       end;
     end;
end;

procedure TrpRasxEnergXL.FillReport(Date : TDateTime);
var i                : byte;
    Year, Month, Day : word;
begin
   DecodeDate(Date, Year, Month, Day);
   Day := Day - 1;
   PrirDay[0, 31] := 0;
   globalTblDate  := DateToStr(Date);
   for i := 0 to 3 do
   begin
     if not IsData[i, Day] then
     begin
       globalTblDaySumT[i] := 'Н/Д';
       continue;
     end;
     globalTblDaySumT[i] := DVLS(PrirDay[i, Day]);
     PrirDay[0, 31] := PrirDay[0, 31] + PrirDay[i, Day];
     SumEnerg[i]    := SumEnerg[i] + PrirDay[i][Day];
   end;
   PrirDay[1, 31] := PrirDay[1, 31] + PrirDay[0, 31];
end;

Function  TrpRasxEnergXL.FindAndReplace(find_,rep_:string):boolean;
 var range:variant;
begin
FindAndReplace:=false;
if find_<>'' then begin
   try
   range:=Excel.Range['A1:EL230'].Replace(What:=find_,Replacement:=rep_);
   FindAndReplace:=true;
   except
   FindAndReplace:=false;
   end;
   end;
End;

procedure TrpRasxEnergXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTtlMainName);
        FindAndReplace('TtlNameTbl',globalTblName);
        FindAndReplace('KindEnergy',strEnergy[KindEnergy]);
        FindAndReplace('TblT1Name',globalTblTName[0]);
        FindAndReplace('TblT2Name',globalTblTName[1]);
        FindAndReplace('TblT3Name',globalTblTName[2]);
        FindAndReplace('TblT4Name',globalTblTName[3]);
end;
procedure TrpRasxEnergXL.ShowData();
begin
       a_:= a_+1;
       FProgress.Position:=a_;
       Excel.ActiveSheet.Cells[a_,1].Value := globalTblDate;
       Excel.ActiveSheet.Cells[a_,2].Value := DVLS(PrirDay[0][31]);
       Excel.ActiveSheet.Cells[a_,3].Value := DVLS(PrirDay[1][31]);
       Excel.ActiveSheet.Cells[a_,4].Value := globalTblDaySumT[0];
       Excel.ActiveSheet.Cells[a_,5].Value := DVLS(SumEnerg[0]);
       Excel.ActiveSheet.Cells[a_,6].Value := globalTblDaySumT[1];
       Excel.ActiveSheet.Cells[a_,7].Value := DVLS(SumEnerg[1]);
       Excel.ActiveSheet.Cells[a_,8].Value := globalTblDaySumT[2];
       Excel.ActiveSheet.Cells[a_,9].Value := DVLS(SumEnerg[2]);
       Excel.ActiveSheet.Cells[a_,10].Value := globalTblDaySumT[3];
       Excel.ActiveSheet.Cells[a_,11].Value := DVLS(SumEnerg[3]);


end;

procedure TrpRasxEnergXL.ShowData2();
begin
        FindAndReplace('Sum', DVLS(PrirDay[1][31]));
        FindAndReplace('TblMaxT1', DVLS(SumEnerg[0]));
        FindAndReplace('TblMaxT2', DVLS(SumEnerg[1]));
        FindAndReplace('TblMaxT3', DVLS(SumEnerg[2]));
        FindAndReplace('TblMaxT4',DVLS(SumEnerg[3]));
        FindAndReplace('TblDate',DateToStr(Now));
        FindAndReplace('TblTime',TimeToStr(Now));
end;
procedure TrpRasxEnergXL.frReport1ManualBuild();
var Year, Month, Day : word;
    i, j             : integer;
    TempDate         : TDateTime;
    nGroup : Integer;
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_:= 8;
   DecodeDate(DateReport, Year, Month, Day);
   for i := 0 to 3 do
   begin
     for j := 0 to 31 do
     begin
       PrirDay[i, j] := 0;
       IsData[i, j]  := false;
     end;
     SumEnerg[i] := 0;
   end;
   globalTtlMainName := 'Расход электроэнергии по группам в ' + cDateTimeR.GetNameMonth(Month)
                         + ' ' + IntToStr(Year) + ' года';
   if IsRPGroup then
   begin
     globalTblName  := 'Отчетная группа: ' + FsgGrid.Cells[1, ItemInd];
     FDB.GetTMTarPeriodsTableGr(StrToInt(FsgGrid.Cells[0, ItemInd]), FTID, m_pTariffs);
   end
   else
   begin
     globalTblName  := 'Отчетный субабонент: ' + FsgGrid.Cells[1, ItemInd];
     FDB.GetTMTarPeriodsTable(StrToInt(FsgGrid.Cells[0, ItemInd]), FTID, m_pTariffs);
   end;

   CreateTariffsNames;
   FormTitle();
   if IsRPGroup then
   begin
     nGroup := StrToInt(FsgGrid.Cells[0, ItemInd]);
     if FDB.GetVMetersTable(FABOID,nGroup, VMeters) then
       ReadArch(DateReport);
   end
   else
     ReadArchAbonent(DateReport);
   Day := 1;
   TempDate := EncodeDate(Year, Month, Day);

   FProgress.Max:= a_+30;
   while cDateTimeR.CompareMonth(TempDate, DateReport) = 0 do
   begin

     FillReport(TempDate);
     ShowData;
     cDateTimeR.IncDate(TempDate);
   end;
   ShowData2;
   Excel.ActiveWorkBook.WorkSheets[1].Range['A9:K'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
  // Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$8';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
   try
     FProgress.Position:=0;
     Excel.Visible := true;
    finally
     if not VarIsEmpty(Excel) then
    begin
      //Excel.Quit;
      Excel := Unassigned;
      Sheet := Unassigned;
      //FsgGrid := nil;
      FProgress.Visible := false;
      FProgress.Enabled := false;
      FProgress := nil;
     end;
end;
end;


end.
