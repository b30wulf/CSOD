unit knslRPRasxMonthXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;
type
  TrpRasxMonthXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
   private
    { Private declarations }
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
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    exWorkBook        : Variant;
    FProgress         : PTProgressBar;
    Fm_nEVL            : CEvaluator;
    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure FormTitle;
    procedure ShowData1;
    procedure ShowData2;
    procedure ShowHeader1;
    procedure FillReport(MID : integer);
    procedure FillReportTtl(KindEN : byte);
    procedure frReport1ManualBuild;
    function  SReplace(Str, X, Y: string): string;
    procedure FormTitle2;
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
    IsReadZerT  : boolean;
    //SumEnergy 
    procedure CreatReport(Date : TDateTime);

  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PABOID      :integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
    property Pm_nEVL      :CEvaluator        read fm_nEVL          write fm_nEVL;
  end;

var
  rpRasxMonthXL: TrpRasxMonthXL;
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
constructor TrpRasxMonthXL.Create;
Begin

End;

destructor TrpRasxMonthXL.Destroy;
Begin
    inherited;
End;

procedure TrpRasxMonthXL.CreatReport(Date : TDateTime);
begin
   Page := 1;
   DateReport   := Date;
   glTable1Name := 'Таблица 1';
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   exWorkBook  := Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPRasxMonth.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet      := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := 'Расход за месяц';
   frReport1ManualBuild;
end;

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}

function TrpRasxMonthXL.SReplace(Str, X, Y: string): string;
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

  SReplace := Buffer;
end;

Function  TrpRasxMonthXL.FindAndReplace(find_,rep_:string):boolean;
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

 procedure TrpRasxMonthXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
        FindAndReplace('Tbl1Name',glTable1Name);
        FindAndReplace('DateTtlB',glMB);
        FindAndReplace('DateTtlE',glME);
end;

procedure TrpRasxMonthXL.FormTitle2();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
       // FindAndReplace('AllMeter',AllMeter);
end;

procedure TrpRasxMonthXL.ShowData1;
begin
   a_ := a_+ 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':F'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':F'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := glKindEn;

   Excel.ActiveSheet.Cells[a_+1,1].Value := 'T1';
   Excel.ActiveSheet.Cells[a_+1,2].Value := RVLPr(glEnergMB[1], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+1,3].Value := RVLPr(glEnergME[1], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+1,4].Value := RVLPr(glEnergRazn[1], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+1,5].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+1,6].Value := RVLPr(glEnergRasx[1], MeterPrecision[m_ID]);
   //
   Excel.ActiveSheet.Cells[a_+2,1].Value := 'T2';
   Excel.ActiveSheet.Cells[a_+2,2].Value := RVLPr(glEnergMB[2], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+2,3].Value := RVLPr(glEnergME[2], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+2,4].Value := RVLPr(glEnergRazn[2], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+2,5].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+2,6].Value := RVLPr(glEnergRasx[2], MeterPrecision[m_ID]);
   //
   Excel.ActiveSheet.Cells[a_+3,1].Value := 'T3';
   Excel.ActiveSheet.Cells[a_+3,2].Value := RVLPr(glEnergMB[3], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+3,3].Value := RVLPr(glEnergME[3], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+3,4].Value := RVLPr(glEnergRazn[3], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+3,5].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+3,6].Value := RVLPr(glEnergRasx[3], MeterPrecision[m_ID]);
   //
   Excel.ActiveSheet.Cells[a_+4,1].Value := 'Сумма по тарифам';
   Excel.ActiveSheet.Cells[a_+4,2].Value := RVLPr(glEnergMB[4], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+4,3].Value := RVLPr(glEnergME[4], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+4,4].Value := RVLPr(glEnergRazn[4], MeterPrecision[m_ID]);
   Excel.ActiveSheet.Cells[a_+4,5].Value := DVLSEx(glKoef, glKoef);
   Excel.ActiveSheet.Cells[a_+4,6].Value := RVLPr(glEnergRasx[4], MeterPrecision[m_ID]);

   a_:= a_+ 4;
end;

procedure TrpRasxMonthXL.ShowHeader1;
begin

   a_ := a_+1;

   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':C'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['C'+IntToStr(a_)+':C'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := globalMeterName;

   Excel.ActiveSheet.Range['D'+IntToStr(a_)+':F'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['D'+IntToStr(a_)+':F'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,4].Value := MeterN;
end;

procedure  TrpRasxMonthXL.ShowData2;
begin
   a_ :=a_ + 1;
    Excel.ActiveSheet.Cells[a_,3].Value := glSum[1];
   a_ :=a_ + 1;
    Excel.ActiveSheet.Cells[a_,3].Value := glSum[2];
   a_ :=a_ + 1;
     Excel.ActiveSheet.Cells[a_,3].Value := glSum[3];
   a_ :=a_ + 1;
     Excel.ActiveSheet.Cells[a_,3].Value := glSum[4];
end;

procedure TrpRasxMonthXL.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
var
 stReplace : string;
 i:byte;
begin
 stReplace := 'v'+mid + '_P';
 if tarif <> 6 then
 begin
   sExpr1[KindEn][tarif] := Sreplace(sExpr1[KindEn][tarif],stReplace,FloatTostr(abs(SumFormula[KindEn][tarif])));
 end
 else
 begin
 for i :=1 to 4 do
   sExpr1[KindEn][i] := Sreplace(sExpr1[KindEn][i],stReplace,'0');
 end;
end;

procedure TrpRasxMonthXL.FillReport(MID : integer);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i : word;
    TempDate            : TDateTime;
    param               : extended;
    nTypeID,swPLID,nMaxT: Integer;
begin
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID];
   MeterN          := 'Эл. сч. №' + FsgGrid.Cells[2, MID];
   AllMeter        :=  AllMeter + FsgGrid.Cells[1, MID] + ',';
   AllMeter        := Sreplace(AllMeter,'  ', '');
   m_ID            := StrToInt(FsgGrid.Cells[0, MID]);
    nMaxT  := 3;
    swPLID := 0;
    FDB.GetMeterType(m_ID,nTypeID,swPLID);
    if swPLID=1 then nMaxT:=2;

   ShowHeader1;
//   Page.ShowBandByName('MasterHeader1');
   TempDate := DateReport;
   for KindEn := 0 to 3 do
   begin
     glKindEn := strEnergy[KindEn];
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
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_MONTH_EP + KindEn, 0, Data) then
     begin
      FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
      ShowData1;
      continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergME[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
       if (IsReadZerT){ or (swPLID=1)} then                       //Суммирование по тарифам
           glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
       end else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
           glEnergME[4] :=  RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
     cDateTimeR.DecMonth(TempDate);
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_MONTH_EP + KindEn, 0, Data) then
     begin
      FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
      ShowData1;
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
     ShowData1;
   end;
end;

procedure TrpRasxMonthXL.FillReportTtl(KindEN : byte);
var i : byte;
begin
   glKindEn := IndEn[KindEn];
    for i := 1 to 4 do
   begin
   if  sExpr <> '[x]' then
   begin
   try
       fm_nEVL.Expression :=  sExpr1[KindEn][i];  //формула
       glSum[i] := FloatToStr(RVLPr(fm_nEVL.Value, MaxPrecision));
   except
        MessageDlg('Ошибка в вычислениях',mtWarning,[mbOk,mbCancel],0);
        exit;
   end;
   end
   else
   if SumEnergy[KindEn][i] < 0 then glSum[i] := 'Н/Д' else
   glSum[i] := FloatToStr(RVLPr(SumEnergy[KindEn][i], MaxPrecision));
   end;

     ShowData2;
end;

procedure TrpRasxMonthXL.frReport1ManualBuild();
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT : SL3GROUPTAG;
begin
   FProgress.Create(Owner);
   FProgress.Visible := true;
////инициализация //формулы
 sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
 fm_nEVL.Expression := sExpr;
 for i:=1 to 4 do
    for j:=0 to 3 do
       sExpr1[j][i] := sExpr;
 //////////////
   a_:= 10;
   AllMeter :='';
   IsLastPage := false;
   for i := 0 to 3 do
     for j := 1 to 4 do
       SumEnergy[i][j] := 0;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'Отчет о фактическом потреблении электроэнергии в ' +
                     cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   cDateTimeR.IncDate(DateReport);
   glME := DateToStr(DateReport);
   cDateTimeR.DecMonth(DateReport);
   glMB := DateToStr(DateReport);
   FormTitle();
   FProgress.Max:=FsgGrid.RowCount;
  for i := 1 to FsgGrid.RowCount - 1 do
  begin
  FProgress.Position := i;
  FillReport(i);
  end;
   IsLastPage := true;
   delete(AllMeter, length(AllMeter), 1);
   AllMeter := AllMeter + '.';

   Excel.ActiveWorkBook.WorkSheets[1].Range['A11:D'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$10 ';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;

   Page := Page + 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := 'Суммарный расход' + IntToStr(Page);
   FormTitle2;
   Excel.ActiveSheet.Cells[8,1].Value := AllMeter;
   a_:= 11;
    for i := 0 to 3 do
     FillReportTtl(i);
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
      exWorkBook:=Unassigned;
      //FsgGrid := nil;
      FProgress.Visible :=false;
      FProgress.Enabled  := false;
      FProgress := nil;
      //fm_nEVL.free;
     end;
end;
end;

end.
