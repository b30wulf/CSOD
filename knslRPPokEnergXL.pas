unit knslRPPokEnergXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TrpPokEnergXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
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
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    procedure frReport1ManualBuild;
    function  FindAndReplace(find_,rep_:string):boolean;
    procedure ShowData1;
    procedure FormTitle;
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
    procedure CreatReport(Date : TDateTime; ItemIndMaxCtrl:Integer);
    procedure  ReadArch(Date : TDateTime);
    procedure  FillReport(Date : TDateTime);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpPokEnergXL: TrpPokEnergXL;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');
implementation

constructor TrpPokEnergXL.Create;
Begin

End;

destructor TrpPokEnergXL.Destroy;
Begin
    inherited;
End;
procedure TrpPokEnergXL.ReadArch(Date : TDateTime);
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

procedure TrpPokEnergXL.FillReport(Date : TDateTime);
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

procedure TrpPokEnergXL.ShowData1;
begin
   a_ := a_+ 1;
   FProgress.Position := a_;
   Excel.ActiveSheet.Cells[a_,1].Value := globalTblDate;
   Excel.ActiveSheet.Cells[a_,2].Value := globalTblNakEn;
   Excel.ActiveSheet.Cells[a_,3].Value := globalTblRasnEn;
   Excel.ActiveSheet.Cells[a_,4].Value := globalTblRasxEn;

end;

Function  TrpPokEnergXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TrpPokEnergXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTtlMainName);
        FindAndReplace('TtlNameTbl',globalTblName);
        FindAndReplace('KindEnergy',strEnergy[KindEnergy]);

end;
procedure TrpPokEnergXL.CreatReport(Date : TDateTime; ItemIndMaxCtrl:Integer);
begin

   Page := 1;
   DateReport  := Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\rpPokEnerg.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 2;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Показания счетчика';
   frReport1ManualBuild;
end;

procedure TrpPokEnergXL.frReport1ManualBuild;
var Year, Month, Day : word;
    i                : integer;
    TempDate         : TDateTime;                       
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_:= 8;
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
   FormTitle;
   Day      := 1;
   TempDate := EncodeDate(Year, Month, Day);
   ReadArch(TempDate);
   FProgress.Max:= a_+30;
   while cDateTimeR.CompareMonth(TempDate, DateReport) = 0 do
   begin
     FillReport(TempDate);
     ShowData1;
     cDateTimeR.IncDate(TempDate);
   end;
   FindAndReplace('TblDate',DateToStr(Now) +' '+ TimeToStr(Now));
   Excel.ActiveWorkBook.WorkSheets[1].Range['a9:D'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$8 ';// при печати на каждой странице ввыводится шапка
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
