unit knslRPMaxDayXL;


interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TrpMaxDayXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
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
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    function  DeleteSpaces(str :string) : string;
    procedure FindMax(Date : TDateTime);
    procedure FindMaxDay(Date : TDateTime);
    procedure ReadSlices(Date : TDateTime);
    procedure ReadSlicesAbonent(Date : TDateTime);
    procedure ReadSlicesMetrolog(Date : TDateTime);
    procedure FillReport(Date : TDateTime);
    procedure FillNull(Date : TDateTime);
    procedure CreateTariffsNames();
    function  DateOutSec(Date : TDateTime) : string;
    procedure ShowData2;
    procedure ShowData;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure frReportMaxDManualBuild;
  public
    { Public declarations }
    IsRPGroup   : byte;
    KindEnergy  : byte;
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign    : string;
    ColorsRep   : array [0..2] of TColor;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    procedure CreatReport(Date : TDateTime; ItemIndMaxCtrl:Integer);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
  end;

var
  rpMaxDayXL    : TrpMaxDayXL;
  IsFirstLoad : boolean = true;
const
  strEnergy   : array [0..3] of string = ('Вид мощности : Активная принимаемая(кВт)',
                                          'Вид мощности : Активная отдаваемая(кВт)',
                                          'Вид мощности : Реактивная принимаемая(кВар)',
                                          'Вид мощности : Реактивная отдаваемая(кВар)');
  strEK       : array [0..3] of string = ('кВт',
                                          'кВт',
                                          'кВар',
                                          'кВар');


implementation

constructor TrpMaxDayXL.Create;
Begin

End;

destructor TrpMaxDayXL.Destroy;
Begin
    inherited;
End;

function TrpMaxDayXL.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TrpMaxDayXL.CreateTariffsNames();
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

function TrpMaxDayXL.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

function  TrpMaxDayXL.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

procedure TrpMaxDayXL.CreatReport(Date : TDateTime; ItemIndMaxCtrl:Integer);
begin
   Page := 1;
  IsFirstLoad := false;
   DateReport  := Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   FTID        := FDB.LoadTID(QRY_E30MIN_POW_EP + KindEnergy);
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RpMaxDay.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 2;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Контроль Макимума';
   frReportMaxDManualBuild;
end;

procedure TrpMaxDayXL.FindMax(Date : TDateTime);
var i, j             : byte;
    Year, Month, Day : word;
begin
   DecodeDate(Date, Year, Month, Day);
   singTblMaxSl :=  maxArray[0][0];
   for i := 0 to 3 do
     for j := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
     begin
       maxArray[i][j] := maxArray[i][j] * 2;
       if (maxArray[i][j] > singTblMaxSl)  and ((i = 0) or (i = 1)) then
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

procedure TrpMaxDayXL.FindMaxDay(Date : TDateTime);
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
   for i := 1 to 1 do
     if maxArray[i, Day] > param then
     begin
       param         := maxArray[i, Day];
       ColorInd      := i;
     end;
   FillColorMaxDay[ColorInd] := ColorsRep[1];
   globalTblMaxSlDay := DVLS(param);
end;

procedure TrpMaxDayXL.FillNull(Date : TDateTime);
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

procedure TrpMaxDayXL.ReadSlicesMetrolog(Date : TDateTime);
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
     //if VMeters.Item.Items[i].m_sbyType = MET_SUMM then
     //  continue;
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

procedure TrpMaxDayXL.ReadSlicesAbonent(Date : TDateTime);
var
    j, k             : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
begin
   DecodeDate(Date, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   if not FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, ItemInd]),
                             QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
       exit
   else
     for k := 0 to m_pGrData.Count - 1 do
     begin
       DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
       Dec(Day);
       for j := 0 to 47 do
       begin
         Index := GetColorFromTariffs(j, m_pTariffs) - 1;
         if not IsInitTar[Index, Day] then
         begin
           maxArray[Index][Day]  := m_pGrData.Items[k].v[j];
           IsInitTar[Index][Day] := true;
           MaxInd[Index][Day]    := j;
         end;
         if m_pGrData.Items[k].v[j] > maxArray[Index][Day] then
         begin
           maxArray[Index][Day] := m_pGrData.Items[k].v[j];
           maxInd[Index][Day]   := j;
         end;
       end;
     end;
end;


procedure TrpMaxDayXL.ReadSlices(Date : TDateTime);
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
     //if VMeters.Item.Items[i].m_sbyType = MET_SUMM then
     //  continue;
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
           if not IsInitTar[Index, Day] then
           begin
             maxArray[Index][Day]  := m_pGrData.Items[k].v[j];
             IsInitTar[Index][Day] := true;
             MaxInd[Index][Day]    := j;
           end;
           if m_pGrData.Items[k].v[j] > maxArray[Index][Day] then
           begin
             maxArray[Index][Day] := m_pGrData.Items[k].v[j];
             maxInd[Index][Day]   := j;
           end;
         end;
       end;
   end;
end;

procedure TrpMaxDayXL.FillReport(Date : TDateTime);
var Year, Month, Day : word;
    i                : byte;
begin
   FindMaxDay(Date);
   DecodeDate(Date, Year, Month, Day);
   Day := Day - 1;
   globalTblDate     := DateToStr(Date);
   if not((IsInitTar[0][Day]) or (IsInitTar[1][Day]) or (IsInitTar[2][Day]) or (IsInitTar[3][Day])) then
   begin     //Если тарифы не проиницилизированны
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

Function  TrpMaxDayXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TrpMaxDayXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTtlMainName);
        FindAndReplace('TtlNameTbl',globalTtlNameTbl);
        FindAndReplace('KindEnergy',strEnergy[KindEnergy]);
        FindAndReplace('TblT1Name',globalTblTName[0]);
        FindAndReplace('TblT2Name',globalTblTName[1]);
        FindAndReplace('TblT3Name',globalTblTName[2]);
        FindAndReplace('TblT4Name',globalTblTName[3]);

        FindAndReplace('Pmax1','Pмакс(' + strEK[KindEnergy] + ')');
        FindAndReplace('Pmax2','Pмакс(' + strEK[KindEnergy] + ')');
        FindAndReplace('Pmax3','Pмакс(' + strEK[KindEnergy] + ')');
        FindAndReplace('Pmax4','Pмакс(' + strEK[KindEnergy] + ')');
        FindAndReplace('Pmax5','Максимальная мощность за день (' + strEK[KindEnergy] + ')');
end;

procedure TrpMaxDayXL.ShowData();
begin
       a_:= a_+1;
       FProgress.Position := a_;
       Excel.ActiveSheet.Cells[a_,1].Value := globalTblDate;
       Excel.ActiveSheet.Cells[a_,2].Value := globalTblBegSlT[0] + ' ' + globalTblEndSlT[0];
       Excel.ActiveSheet.Cells[a_,3].Value := globalTblMaxSlT[0];
       Excel.ActiveSheet.Cells[a_,3].Interior.Color := FillColorMaxDay[0];

       Excel.ActiveSheet.Cells[a_,4].Value := globalTblBegSlT[1] + ' ' +  globalTblEndSlT[1];
       Excel.ActiveSheet.Cells[a_,5].Value := globalTblMaxSlT[1];
       Excel.ActiveSheet.Cells[a_,6].Value := globalTblBegSlT[2] + ' ' +  globalTblEndSlT[2];
       Excel.ActiveSheet.Cells[a_,6].Interior.Color := FillColorMaxDay[1];

       Excel.ActiveSheet.Cells[a_,7].Value := globalTblMaxSlT[2];
       Excel.ActiveSheet.Cells[a_,8].Value := globalTblBegSlT[3] + ' ' +  globalTblEndSlT[3];
       Excel.ActiveSheet.Cells[a_,9].Value := globalTblMaxSlT[3];
       Excel.ActiveSheet.Cells[a_,9].Interior.Color := FillColorMaxDay[3];

       Excel.ActiveSheet.Cells[a_,10].Value := globalTblMaxSlDay;
       Excel.ActiveSheet.Cells[a_,10].Interior.Color := ColorsRep[1];
end;

procedure TrpMaxDayXL.ShowData2();
begin
        FindAndReplace('TblMaxT1', DVLS(maxArray[0][31]));
        FindAndReplace('TblMaxT2', DVLS(maxArray[1][31]));
        FindAndReplace('TblMaxT3', DVLS(maxArray[2][31]));
        FindAndReplace('TblMaxT4', DVLS(maxArray[3][31]));
        FindAndReplace('TblMaxDay',DVLS(singTblMaxSl));
        FindAndReplace('TtlMaxPower',DVLS(singTblMaxSl) + ' ' + strEK[KindEnergy]);


         FindAndReplace('TblDate',DateToStr(Now));
         FindAndReplace('TblTime',TimeToStr(Now));
end;

procedure TrpMaxDayXL.frReportMaxDManualBuild;
var Year, Month, Day : word;
    i,j              : integer;
    TempDate         : TDateTime;
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_:= 8;
   for i := 0 to 3 do
     for j := 0 to 31 do
     begin
       maxArray[i, j] := 0;
       IsInitTar[i, j] := false;
     end;
   FDB.GetTMTarPeriodsTable(-1, FTID{ + KindEnergy}, m_pTariffs);
   FillChar(ArraySumSlice, sizeof(ArraySumSlice), 0);

   DecodeDate(DateReport, Year, Month, Day);

   globalTtlMainName := 'Совмещенные максимумы мощности в ' + cDateTimeR.GetNameMonth(Month)
                         + ' ' + IntToStr(Year) + ' года' + ' в часы максимальных нагрузок энергосистемы ';
   if KindEnergy = 0 then
   globalTtlMainName := globalTtlMainName + DateOutSec(m_pTariffs.Items[5].m_dtTime0) + ' - ' + DateOutSec(m_pTariffs.Items[5].m_dtTime1) +
                         ' и ' +DateOutSec(m_pTariffs.Items[6].m_dtTime0) + ' - ' + DateOutSec(m_pTariffs.Items[6].m_dtTime1);
   if IsRPGroup = 0 then
     globalTtlNameTbl  := 'Учет: ' + FsgGrid.Cells[1, ItemInd]
   else
     globalTtlNameTbl  := 'Учет: ' + FsgGrid.Cells[1, ItemInd];
    CreateTariffsNames();

  // Page.ShowBandByType({'PageHeader1'}btReportTitle);
   FormTitle();
   Day      := 1;
   TempDate := EncodeDate(Year, Month, Day);

   FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters);

   if IsRPGroup = 0 then
     //ReadSlices(DateReport);
     ReadSlicesMetrolog(DateReport);
   if IsRPGroup = 1 then
     ReadSlicesAbonent(DateReport);
   //if IsRPGroup = 2 then
   //  ReadSlicesMetrolog(DateReport);

   TempDate := EncodeDate(Year, Month, Day);
   FindMax(TempDate);
    FProgress.Max:= a_ + 31;
   while cDateTimeR.CompareMonth(TempDate, DateReport) = 0 do
   begin
     FillReport(TempDate);
     ShowData;
   //  Page.ShowBandByName('MasterData1');
      cDateTimeR.IncDate(TempDate);

   end;
   ShowData2;
  //  ShowData;
   Excel.ActiveWorkBook.WorkSheets[1].Range['A9:J'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
 //  Excel.Selection.Borders.Weight           := xlMedium;
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
end.
