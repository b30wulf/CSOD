unit knslRPExpenseDayXL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox;

type
   TrpExpenseDayXL = class(TForm)
   constructor Create;
   destructor Destroy;override;
   private
    m_ID              : byte; 
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
    DateReport        : TDateTime;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glCountTable      : integer;
    globalTblDate     : string[15];
    glCountTableShow  : string;
    glSumEnergy       : array [1..4] of extended;
    glTblData         : string;
    glTblSub          : string;
    glTblRasx         : string;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    a_                : integer;
    Page              : byte;
    GroupID           : integer;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    FABOID            : Integer;
    procedure Report1ManualBuild;
    procedure ShowGlParam(MID : integer);
    procedure FillReport(MID : integer; Date : TDateTime);
    procedure FillReportTtl;
    procedure ShowData;
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure FormFooter;
    { Private declarations }
  public
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign   : string;
    KindEnergy  : integer;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
  
    procedure CreatReport(Date : TDateTime;CountTable :integer);
    procedure FillReportChooseParam;
    { Public declarations }
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer          read GroupID      write GroupID;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar  read FProgress         write FProgress;
  end;

var
  rpExpenseDayXL: TrpExpenseDayXL;
const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная принимаемая',
                                          'Вид энергии : Активная отдаваемая',
                                          'Вид энергии : Реактивная принимаемая',
                                          'Вид энергии : Реактивная отдаваемая');

implementation

constructor TrpExpenseDayXL.Create;
Begin

End;

destructor TrpExpenseDayXL.Destroy;
Begin
    inherited;
End;

 procedure   TrpExpenseDayXL.CreatReport(Date : TDateTime;CountTable :integer);
 begin
   Page :=1;
   DateReport := Date;
   glCountTable := CountTable;

   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\EcspenseDay.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Расход за день';
   Report1ManualBuild;
 end;

procedure TrpExpenseDayXL.ShowData();
begin
     a_:= a_+ 1;
     Excel.ActiveSheet.Cells[a_,1].Value := globalTblDate;
     Excel.ActiveSheet.Cells[a_,2].Value := glTblData;
     Excel.ActiveSheet.Cells[a_,3].Value := glTblSub;
     Excel.ActiveSheet.Cells[a_,4].Value := glTblRasx;
end;

Function  TrpExpenseDayXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TrpExpenseDayXL.FillReport(MID : integer; Date : TDateTime);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i,r : word;
    PredDay             :word;
    param               : extended;
    nMaxT,swPLID,nTypeID: Integer;
begin

   DecodeDate(Date, Year, Month, Day);
   for i:= 1 to 4 do
   glSumEnergy[i]  := 0;
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID];
   globalTblMeter  := '№ :' +FsgGrid.Cells[2, MID];
   Date            := EncodeDate(Year, Month, Day);
   Day             := 0;
   PredDay         := 1;
   m_ID            := StrToInt(FsgGrid.Cells[0, MID]);
   nMaxT  := 3;
   swPLID := 0;
   FDB.GetMeterType(m_ID,nTypeID,swPLID);
   if swPLID=1 then nMaxT:=2;
 while (cDateTimeR.CompareMonth(Date, DateReport) = 0) and (cDateTimeR.CompareDay(Date, DateReport)<> 0)  do
   begin

     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);

     Day := Day + 1;
     if Day <> 1 then
     cDateTimeR.IncDate(Date);
     globalTblDate  := DateToStr(Date);

      for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergME[i]   := 0;
       glEnergRazn[i] := 0;
       glEnergRasx[i] := 0;
     end;
     if not FDB.GetGData(Date, Date, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEnergy, 0, Data) then
     begin
       FillReportChooseParam;
       ShowData();
       //Page.ShowBandByName('MasterData1');
       continue;
     end;

     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin

         glEnergME[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
       end;

     if Day = 1 then
       begin
       cDateTimeR.DecMonth(Date);
       cDateTimeR.EndDayMonth(Date);
       end
       else
        begin
        cDateTimeR.DecDate(Date);
         Day := Day - 1;
         end;

     if not FDB.GetGData(Date, Date, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEnergy, 0, Data) then
     begin
      FillReportChooseParam;
      ShowData();
    if (PredDay = 1) and (Day = 1) then
       begin
       cDateTimeR.IncMonth(Date);
       PredDay := 0;
       end
     else
       begin
      cDateTimeR.IncDate(Date);
      Day := Day + 1;
       end;
      continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
       end;
     for i := 1 to 4 do
     begin
       glEnergRazn[i] := glEnergME[i] - glEnergMB[i];
       glEnergRasx[i] := RVLPr(glEnergRazn[i], MeterPrecision[m_ID])*glKoef;
       SumEnergy[KindEnergy][i] := SumEnergy[KindEnergy][i] + glEnergRasx[i];
       glSumEnergy[i] := glSumEnergy[i] + glEnergRasx[i];
     end;
     FillReportChooseParam;
     ShowData();
      if (PredDay = 1) and (Day = 1) then
      begin
       cDateTimeR.IncMonth(Date);
       PredDay := 0;
      end
      else
        begin
      cDateTimeR.IncDate(Date);
      Day := Day + 1;
        end;
   end;
end;

procedure TrpExpenseDayXL.FillReportChooseParam;
begin
   if  glEnergME[4]<=0 then
   begin
       glTblRasx := 'Н/Д';
       glTblSub  := 'Н/Д';
       glTblData := 'Н/Д';
  end
  else
  begin
       if glEnergRasx[4]<0 then glTblRasx := 'Н/Д' else   glTblRasx  := FloatToStr(RVLPr(glEnergRasx[4], MeterPrecision[m_ID]));
       if glEnergRazn[4]<0 then glTblSub := 'Н/Д' else  glTblSub  := FloatToStr(RVLPr(glEnergRazn[4], MeterPrecision[m_ID]));
       if glEnergME[4]<=0 then glTblData := 'Н/Д' else  glTblData := FloatToStr(RVLPr(glEnergME[4], MeterPrecision[m_ID]));
   end;
end;

procedure TrpExpenseDayXL.FillReportTtl();
var i : byte;
begin
   if glSumEnergy[4]<0 then glSum := 'Н/Д' else
   glSum := DVLS(glSumEnergy[4]);
end;

procedure TrpExpenseDayXL.ShowGlParam(MID : integer);
begin
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID+1];
   globalTblMeter  := '№ :' +FsgGrid.Cells[2, MID+1];
   glKoef   := StrToFloat(FsgGrid.Cells[3, MID+1]);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable) + '(продолжение)';
end;

procedure TrpExpenseDayXL.FormFooter();
begin
     FindAndReplace('glSum',glSum);
   {  a_:= a_ + abs(50-a_);
     Excel.ActiveSheet.Cells[a_,1].Value := 'Итого:';
     Excel.ActiveSheet.Cells[a_,2].Value := glSum;  }
end;

procedure TrpExpenseDayXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
        FindAndReplace('#CountTbl&',glCountTableShow);
        FindAndReplace('#globalMeterName&',globalMeterName);
        FindAndReplace('#strEnergy[KindEnergy]&',strEnergy[KindEnergy]);
        FindAndReplace('TblMeter',globalTblMeter);
        FindAndReplace('#glKoef&',DVLSEx(glKoef, glKoef));
end;



procedure TrpExpenseDayXL.Report1ManualBuild;
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
begin
    FProgress.Create(Owner);
    FProgress.Visible := true;
    a_:= 12;
    DecodeDate(DateReport, Year, Month, Day);
    globalTitle := 'Отчет о фактическом потреблении электроэнергии в ' +
                     cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';

   Day := 1;
   TempDate := EncodeDate(Year, Month, Day);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, 1];
   globalTblMeter  := 'сч. № :' +FsgGrid.Cells[2, 1];
   glKoef   := StrToFloat(FsgGrid.Cells[3, 1]);
   for i := 1 to FsgGrid.RowCount - 2 do
   begin
     Sheet.Copy(After:=Sheet);
   end;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   FormTitle();
   FProgress.Max:= FsgGrid.RowCount;
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     Day := 1;
     FProgress.Position := i;
     TempDate := EncodeDate(Year, Month, Day);
     FillReport(i, TempDate);
     FillReportTtl();
     if i <> FsgGrid.RowCount - 1 then
     begin
     ShowGlParam(i);
     FormFooter();
   a_ := 12;
   Page := Page + 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := 'Суммарный расход' + IntToStr(Page);
   FormTitle();
      end;
    end;
    FormFooter();
    try
    for i := 1 to Page do
    begin
     Excel.ActiveWorkBook.WorkSheets[i].activate;
     Excel.ActiveWorkBook.WorkSheets[i].Range['a13:D'+IntToStr(a_)].Select;//[1].Range['a13:D'+IntToStr(a_)].Select;//выделяем всю таблицу
     Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
   //  Excel.Selection.Borders.Weight           := xlMedium;
     Excel.Selection.HorizontalAlignment       :=-4108;
     Excel.Selection.WrapText:=true;
    end;
     Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
     FProgress.Position := 0;
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
