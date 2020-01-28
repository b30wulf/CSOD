unit knslRpCalcMoneyXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TrpCalcMoneyXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
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
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure ReadArch();
    procedure ReadArchAbonent();
    procedure FillReport(Date : TDateTime);
    procedure FillTotal;
    function  DateOutSec(Date : TDateTime) : string;
    procedure CreateTariffsNames();
    function  CalcCountTariffs() : byte;
    procedure frReport1ManualBuild;
    procedure ShowData;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
   // procedure FormFooter(i:byte);
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
    function  DeleteSpaces(str :string) : string;
    procedure InitArrays();
    procedure CreatReport(Date1, Date2 : TDateTime; ItemIndMaxCtrl:Integer);
  public
    property PABOID      :Integer          read FABOID       write FABOID;
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property TID         :integer          read FTID         write FTID;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
  end;

var
  rpCalcMoneyXL: TrpCalcMoneyXL;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');

implementation
constructor TrpCalcMoneyXL.Create;
Begin

End;

destructor TrpCalcMoneyXL.Destroy;
Begin
    inherited;
End;

function  TrpCalcMoneyXL.CalcCountTariffs() : byte;
var i : word;
begin
  Result := m_pTariffs.Items[0].m_swTID;
  for i := 1 to m_pTariffs.Count - 1 do
    if m_pTariffs.Items[i].m_swTID > Result then
      Result := m_pTariffs.Items[i].m_swTID;
end;

function TrpCalcMoneyXL.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TrpCalcMoneyXL.CreateTariffsNames();
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

function  TrpCalcMoneyXL.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

function TrpCalcMoneyXL.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TrpCalcMoneyXL.InitArrays();
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

procedure TrpCalcMoneyXL.CreatReport(Date1, Date2 : TDateTime; ItemIndMaxCtrl:Integer);
begin
   Page := 1;
   maxParam    := -10000000000;
   DateBeg     := Date1;
   DateEnd     := Date2;
   ItemInd     := ItemIndMaxCtrl;
   FTID        := FDB.LoadTID(QRY_SRES_ENR_EP + KindEnergy);;
   KoefTar     := StrToFloat(FsgGrid.Cells[2, ItemInd]);
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RpCalcMoneyXL.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 2;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Расчет стоимости';
   frReport1ManualBuild;
end;

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}


Function  TrpCalcMoneyXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TrpCalcMoneyXL.FormTitle();
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

procedure TrpCalcMoneyXL.ShowData();
begin
        a_:=a_+1;
        FProgress.Position:=a_;
        FindAndReplace('TblKoefSu',globalTblKoef[0]);
        FindAndReplace('TblEnergSu',globalTblEnergTtl[0]);
        FindAndReplace('TblMoneySu',globalTblMoneyTtl[0]);
        a_:=a_+1;
        FProgress.Position:=a_;
        FindAndReplace('KoefT1Ttl',globalTblKoef[1]);
        FindAndReplace('EnergT1Ttl',globalTblEnergTtl[1]);
        FindAndReplace('MoneyT1Ttl',globalTblMoneyTtl[1]);

        a_:=a_+1;
        FProgress.Position:=a_;
        FindAndReplace('KoefT2Ttl',globalTblKoef[2]);
        FindAndReplace('EnergT2Ttl',globalTblEnergTtl[2]);
        FindAndReplace('MoneyT2Ttl',globalTblMoneyTtl[2]);
        a_:=a_+1;
         FProgress.Position:=a_;
        FindAndReplace('KoefT3Ttl',globalTblKoef[3]);
        FindAndReplace('EnergT3Ttl',globalTblEnergTtl[3]);
        FindAndReplace('MoneyT3Ttl',globalTblMoneyTtl[3]);
        a_:=a_+1;
        FProgress.Position:=a_;
        FindAndReplace('KoefT4Ttl',globalTblKoef[4]);
        FindAndReplace('EnergT4Ttl',globalTblEnergTtl[4]);
        FindAndReplace('MoneyT4Ttl',globalTblMoneyTtl[4]);
        a_:=a_+1;
        FProgress.Position:=a_;
        FindAndReplace('DateMax',DateToStr(maxDate));
        FindAndReplace('KoefMax',DVLS(m_pTariffs.Items[0].m_sfKoeff));
        FindAndReplace('EnergMax',DVLS(maxParam));
        FindAndReplace('MoneyMax',DVLS(maxParam*m_pTariffs.Items[0].m_sfKoeff));
        if SrezNumb mod 2 = 0 then
        FindAndReplace('TimeMax',IntToStr(SrezNumb div 2) + ':' + '00' + ' - ' + IntToStr((SrezNumb + 1) div 2) +
                   ':' + IntToStr(((SrezNumb + 1) mod 2)*30))
                   else
         FindAndReplace('TimeMax',IntToStr(SrezNumb div 2) +  ':' + IntToStr((SrezNumb mod 2)*30) +
                   ' - ' + IntToStr((SrezNumb + 1) div 2) + ':' + '00');

         FindAndReplace('TblDate',DateToStr(Now));
         FindAndReplace('TblTime',TimeToStr(Now));
end;

procedure TrpCalcMoneyXL.ReadArch();
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
           SumEnerg[Index]        := SumEnerg[Index] + m_pGrData.Items[k].v[j];
         end;
       end;
     end;
   end;
   except
     InitArrays;
   end;
end;

procedure TrpCalcMoneyXL.ReadArchAbonent();
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
         SumEnerg[Index]         := SumEnerg[Index] + m_pGrData.Items[k].v[j]
       end;
     end;
end;

procedure TrpCalcMoneyXL.FillReport(Date : TDateTime);
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
      PrirDay[sm]       := PrirDay[sm] + PrirDay[sm*5 + i];
   end;
end;

procedure TrpCalcMoneyXL.FillTotal();
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

procedure TrpCalcMoneyXL.frReport1ManualBuild;
var i                : integer;
    TempDate         : TDateTime;
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_:= 9;
   TempDate := DateBeg;
   maxDate  := Now;
   SrezNumb := 0;
   maxParam := 0;
   globalTtlMainName := 'Расчет расхода энергии от ' + DateToStr(DateBeg) + ' до ' + DateToStr(DateEnd);
   if IsRPGroup then
     globalTblName  := 'Отчетная группа: ' + FsgGrid.Cells[1, ItemInd]
   else
     globalTblName  := 'Отчетный субабонент: ' + FsgGrid.Cells[1, ItemInd];
   CreateTariffsNames;
   InitArrays;
   FormTitle();
   if IsRPGroup then
   begin

     if FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters) then
       ReadArch();
   end
   else
     ReadArchAbonent();
   FProgress.Max:=a_+7;
   while cDateTimeR.CompareDay(TempDate, DateEnd) <> 1 do
   begin
     FillReport(TempDate);
     cDateTimeR.IncDate(TempDate);
   end;
   FillTotal;
   ShowData;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$11 ';// при печати на каждой странице ввыводится шапка
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
