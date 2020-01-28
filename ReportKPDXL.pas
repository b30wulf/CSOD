unit knslReportKPDXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;
type
  TReportKPDXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
 private
    { Private declarations }
    FsgGrid        : PTAdvStringGrid;
    GroupID        : integer;
    glKoef            : extended;
    MeterN            : string;
    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergRazn       : array [1..4] of extended;
    glEnergRasx       : array [1..4] of extended;
    glMB              : string[15];
    glME              : string[15];
    globalTitle       : string;
    globalMeterName   : string;
    glSum             : array [1..4] of string;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glKindEn          : string;
    globalTblDate     : string[15];
    glCountTable      : integer;
    glCountTableShow  : string;
    AllMeter          : string;
    DateReport        : TDateTime;
    FDB               : PCDBDynamicConn;
    IsLastPage        : boolean;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    procedure FillReport(MID : integer);
    procedure FillReportTtl(KindEN : byte);
    procedure frReport1ManualBuild;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure ShowData1;
    procedure ShowData2;
    procedure ShowHeader1;
    procedure ShowHeader2;
  public
    { Public declarations }
    KindEnergy   : byte;
    FirstSign    : string;
    SecondSign   : string;
    ThirdSign    : string;
    WorksName    : string;
    Telephon     : string;
    EMail        : string;
    NDogovor     : string;
    NameObject   : string;
    Adress       : string;
   procedure CreatReport(Date : TDateTime;CountTable:integer);
   function Replace(Str, X, Y: string): string;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
  end;

var
  ReportKPDXL  : TReportKPDXL;
  //FsgGrid    : ^TAdvStringGrid;
  IsFirstLoad  : boolean = true;
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

constructor TReportKPDXL.Create;
Begin

End;

destructor TReportKPDXL.Destroy;
Begin
    inherited;
End;

procedure TReportKPDXL.CreatReport(Date : TDateTime;CountTable:integer);
begin
   Page := 1;
   DateReport := Date;
   glCountTable := CountTable;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPIncrememtDay.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Приращение за месяц';
   frReport1ManualBuild;
end;

function TReportKPDXL.Replace(Str, X, Y: string): string;
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

Function  TReportKPDXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TReportKPDXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
        FindAndReplace('#CountTbl&',glCountTableShow);
        FindAndReplace('DateTtlB',glMB);

end;

procedure TReportKPDXL.ShowData1;
begin
   a_ := a_+ 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := globalMeterName;

   Excel.ActiveSheet.Cells[a_+1,1].Value := 'T1';
   Excel.ActiveSheet.Cells[a_+1,2].Value := DVLSEx(glEnergMB[1], glKoef);
   Excel.ActiveSheet.Cells[a_+1,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+1,4].Value := DVLSEx(glEnergRazn[1], glKoef);
   //
   Excel.ActiveSheet.Cells[a_+2,1].Value := 'T2';
   Excel.ActiveSheet.Cells[a_+2,2].Value := DVLSEx(glEnergMB[2], glKoef);
   Excel.ActiveSheet.Cells[a_+2,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+2,4].Value := DVLSEx(glEnergRazn[2], glKoef);
   //
   Excel.ActiveSheet.Cells[a_+3,1].Value := 'T3';
   Excel.ActiveSheet.Cells[a_+3,2].Value := DVLSEx(glEnergMB[3], glKoef);
   Excel.ActiveSheet.Cells[a_+3,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+3,4].Value := DVLSEx(glEnergRazn[3], glKoef);
   //
   Excel.ActiveSheet.Cells[a_+4,1].Value := 'Сумма по тарифам';
   Excel.ActiveSheet.Cells[a_+4,2].Value := DVLSEx(glEnergMB[4], glKoef);
   Excel.ActiveSheet.Cells[a_+4,3].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+4,4].Value := DVLSEx(glEnergRazn[4], glKoef);
   a_:= a_+ 4;
end;

procedure TReportKPDXL.ShowHeader1;
begin
   a_ := a_+1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['B'+IntToStr(a_)+':B'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := glKindEn;

   Excel.ActiveSheet.Range['C'+IntToStr(a_)+':D'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['C'+IntToStr(a_)+':D'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,3].Value := MeterN;
end;

procedure TReportKPDXL.FillReport(MID : integer);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i,r : word;
    TempDate            : TDateTime;
    param               : extended;

begin
    TempDate := DateReport;
    globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID];
    MeterN          := 'Эл. сч. №' + FsgGrid.Cells[2, MID];
    AllMeter        :=  AllMeter + FsgGrid.Cells[1, MID] + ',';
    AllMeter        := replace(AllMeter,'  ', '');
    ShowHeader1;
    //Page.ShowBandByName('MasterHeader1');
for KindEn := 0 to 3 do
   begin
     //Page.ShowBandByName('MasterHeader1');
     glKindEn := strEnergy[KindEn];
     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);

    for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergRazn[i] := 0;
     end;

     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_ENERGY_MON_EP + KindEn, 0, Data) then
     begin
       //Page.ShowBandByName('MasterData1');
       ShowData1;
       continue;
     end;
    for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= 3) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := RVL(Data.Items[i].m_sfValue/glKoef);
         glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end;

     for i := 1 to 4 do
     begin
       glEnergRazn[i] := RVL(glEnergMB[i])*glKoef;
       SumEnergy[KindEn][i] := SumEnergy[KindEn][i] + glEnergRazn[i];
     end;
     ShowData1;
     // Page.ShowBandByName('MasterData1');
   end;
end;

procedure TReportKPDXL.FillReportTtl(KindEN : byte);
var i : byte;
begin
 glKindEn := IndEn[KindEn];
   for i := 1 to 4 do
     glSum[i] := DVLS(SumEnergy[KindEn][i]);
     ShowData2;
   //Page.ShowBandByName('MasterData2');
end;

procedure  TReportKPDXL.ShowData2;
begin
   a_ :=a_ + 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':A'+IntToStr(a_+ 3)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':A'+IntToStr(a_+ 3)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := glKindEn;
   //
   Excel.ActiveSheet.Cells[a_,2].Value := 'T1';
   Excel.ActiveSheet.Cells[a_,3].Value := glSum[1];
   //
   Excel.ActiveSheet.Cells[a_+1,2].Value := 'T2';
   Excel.ActiveSheet.Cells[a_+1,3].Value := glSum[2];
   //
   Excel.ActiveSheet.Cells[a_+2,2].Value := 'T3';
   Excel.ActiveSheet.Cells[a_+2,3].Value := glSum[3];
   //
   Excel.ActiveSheet.Cells[a_+3,2].Value := 'Сумма по тарифам:';
//   Excel.ActiveSheet.Range['G'+IntToStr(a_+3)+':I'+IntToStr(a_+3)].Select;
//   Excel.ActiveSheet.Range['G'+IntToStr(a_+3)+':I'+IntToStr(a_+3)].Merge;
   Excel.ActiveSheet.Cells[a_+3,3].Value := glSum[4];
   a_ := a_+3
end;

procedure  TReportKPDXL.ShowHeader2;
begin
   a_ :=a_ + 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':D'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := 'Суммарный расход электрической энергии по следующим точкам учета:';

   Excel.ActiveSheet.Range['A'+IntToStr(a_+1)+':D'+IntToStr(a_+ 2)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_+1)+':D'+IntToStr(a_+ 2)].Merge;
   Excel.ActiveSheet.Cells[a_+1,1].Value := AllMeter;

   Excel.ActiveSheet.Range['A'+IntToStr(a_+3)+':D'+IntToStr(a_+ 3)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_+3)+':D'+IntToStr(a_+ 3)].Merge;
   Excel.ActiveSheet.Cells[a_+3,1].Value := 'Таблица 2';
   ///////
//   Excel.ActiveSheet.Range['A'+IntToStr(a_+4)+':C'+IntToStr(a_+4)].Select;
//   Excel.ActiveSheet.Range['A'+IntToStr(a_+4)+':C'+IntToStr(a_+4)].Merge;
   Excel.ActiveSheet.Cells[a_+4,1].Value := 'Вид энергии';

//   Excel.ActiveSheet.Range['D'+IntToStr(a_+4)+':F'+IntToStr(a_+4)].Select;
//   Excel.ActiveSheet.Range['D'+IntToStr(a_+4)+':F'+IntToStr(a_+4)].Merge;
   Excel.ActiveSheet.Cells[a_+4,2].Value := 'Тариф';

//   Excel.ActiveSheet.Range['G'+IntToStr(a_+4)+':I'+IntToStr(a_+4)].Select;
//   Excel.ActiveSheet.Range['G'+IntToStr(a_+4)+':I'+IntToStr(a_+4)].Merge;
   Excel.ActiveSheet.Cells[a_+4,3].Value := 'Расход';
   a_:= a_+4;
end;

procedure TReportKPDXL.frReport1ManualBuild();
var i,j                : integer;
    Month,Month1, Year,Year1, Day : word;
     TempDate         : TDateTime;
begin
   a_ := 11;
   AllMeter :='';
   IsLastPage := false;
    for i := 0 to 3 do
     for j := 1 to 4 do
      SumEnergy[i][j] := 0;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'Сведения о потреблении/отдачи энергии в ' +
                                            cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';


   cDateTimeR.IncDate(DateReport);
   glMB := DateToStr(DateReport);

  // Page.ShowBandByType(btReportTitle);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   FormTitle();
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
   FillReport(i);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable) + '(продолжение)';
   end;
   IsLastPage := true;
   //Page.NewPage;
   delete(AllMeter, length(AllMeter)-1, 2);
   ShowHeader2;
  // Page.ShowBandByName('MasterHeader2');
   for i := 0 to 3 do
     FillReportTtl(i);

   Excel.ActiveWorkBook.WorkSheets[1].Range['c12:D'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$11 ';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
 try
      Excel.Visible := true;
    finally
     if not VarIsEmpty(Excel) then
    begin
      Excel.Quit;
      Excel := Unassigned;
      Sheet := Unassigned;
      FsgGrid := nil;
     end;
end;
end;
end.
